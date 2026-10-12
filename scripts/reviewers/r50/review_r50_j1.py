"""J1: attack the basis-free Weyl projector.

Tested at n NOT in the claimed list {6,8,10}: n = 5,7,9,11 (and 6,8 as controls).
Every test is OFF the subspace, on random symmetric matrices.
Checks: (a) agreement with the true basis projector, (b) idempotence,
(c) self-adjointness, (d) EACH coefficient alone, by a 2-D least-squares refit.
Also runs the REPOSITORY implementation and compares it to mine.
"""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r50_core as C
from b_weyl_projector_free import weyl_project as repo_project

rng = np.random.default_rng(5050)


def basis_projector_apply(n, X):
    B, _ = C.weyl_basis_vec(n)
    N = len(C.pairs_idx(n)[0])
    v = C.mat2vec(N, X)
    return C.vec2mat(N, B.T @ (B @ v))


print("=== (a,b,c) agreement / idempotence / self-adjointness, OFF Weyl_n ===")
print(f"{'n':>3} {'mine vs basis':>14} {'repo vs basis':>14} {'idem(mine)':>11} {'selfadj':>10} {'res in Weyl':>12}")
for n in (5, 6, 7, 8, 9, 10, 11):
    N = len(C.pairs_idx(n)[0])
    e1 = e1r = e2 = 0.0
    resw = 0.0
    for _ in range(3):
        X = rng.normal(size=(N, N)); X = 0.5 * (X + X.T)
        t = basis_projector_apply(n, X)
        a = C.weyl_project_free(n, X)
        r = repo_project(n, X)
        e1 = max(e1, np.linalg.norm(a - t) / np.linalg.norm(t))
        e1r = max(e1r, np.linalg.norm(r - t) / np.linalg.norm(t))
        e2 = max(e2, np.linalg.norm(C.weyl_project_free(n, a) - a) / np.linalg.norm(a))
        # is the output actually in Weyl_n?
        resw = max(resw, max(np.linalg.norm(C.alt_part(n, a)), np.linalg.norm(C.ricci(n, a))) / np.linalg.norm(a))
    # self-adjointness: <P X, Y> - <X, P Y>
    sa = 0.0
    for _ in range(4):
        X = rng.normal(size=(N, N)); X = 0.5 * (X + X.T)
        Y = rng.normal(size=(N, N)); Y = 0.5 * (Y + Y.T)
        d = float(np.tensordot(C.weyl_project_free(n, X), Y)) - float(np.tensordot(X, C.weyl_project_free(n, Y)))
        sa = max(sa, abs(d) / (np.linalg.norm(X) * np.linalg.norm(Y)))
    print(f"{n:3d} {e1:14.2e} {e1r:14.2e} {e2:11.2e} {sa:10.2e} {resw:12.2e}", flush=True)

print()
print("=== (d) each coefficient alone: least-squares refit of (alpha,beta) ===")
print("    P(X) = Y - alpha*KN(rho_0) - beta*s*KN(g);  claimed alpha=2/(n-2), beta=1/(n(n-1))")
print(f"{'n':>3} {'alpha_fit':>12} {'2/(n-2)':>12} {'beta_fit':>14} {'1/(n(n-1))':>14} {'cond':>9}")
for n in (5, 6, 7, 8, 9, 10, 11):
    N = len(C.pairs_idx(n)[0])
    rows, rhs = [], []
    for _ in range(6):
        X = rng.normal(size=(N, N)); X = 0.5 * (X + X.T)
        Y = X - C.alt_part(n, X)
        rho = C.ricci(n, Y); s = float(np.trace(rho))
        rho0 = rho - (s / n) * np.eye(n)
        u1 = C.KN(n, rho0).ravel()
        u2 = (s * C.KN(n, np.eye(n))).ravel()
        b = (Y - basis_projector_apply(n, X)).ravel()
        rows.append(np.stack([u1, u2], axis=1)); rhs.append(b)
    A = np.concatenate(rows); b = np.concatenate(rhs)
    sol, *_ = np.linalg.lstsq(A, b, rcond=None)
    cond = np.linalg.cond(A.T @ A)
    print(f"{n:3d} {sol[0]:12.9f} {2.0/(n-2):12.9f} {sol[1]:14.11f} {1.0/(n*(n-1)):14.11f} {cond:9.2e}")

print()
print("=== compensating-pair test: perturb ONE coefficient, see the error move ===")
n = 9
N = len(C.pairs_idx(n)[0])
X = rng.normal(size=(N, N)); X = 0.5 * (X + X.T)
t = basis_projector_apply(n, X)
a0, b0 = 2.0 / (n - 2), 1.0 / (n * (n - 1))
for da, db in [(0, 0), (0.5, 0), (-0.5, 0), (0, 0.5), (0, -0.5), (0.5, 0.5)]:
    a = C.weyl_project_free(n, X, alpha=a0 * (1 + da), beta=b0 * (1 + db))
    print(f"  alpha*(1{da:+.1f}) beta*(1{db:+.1f}): rel err vs basis = "
          f"{np.linalg.norm(a-t)/np.linalg.norm(t):.3e}")
