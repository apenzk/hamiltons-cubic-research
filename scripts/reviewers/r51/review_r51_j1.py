"""J1: attack the basis-free Weyl projector."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r51_core import *
import b_weyl_projector_free as repo   # the repository's own implementation

rng = np.random.default_rng(51)

def rand_sym(N):
    M = rng.normal(size=(N, N)); return 0.5*(M+M.T)

print("== A. mine vs basis vs repo, at n NOT in {6,8,10} ==")
print(f"{'n':>3} {'mine-vs-basis':>14} {'repo-vs-basis':>14} {'mine-vs-repo':>13} "
      f"{'idem(mine)':>11} {'selfadj':>10} {'in-Weyl':>10}")
for n in (4, 5, 7, 9, 11, 12):
    P, idx, sgn = pairs_of(n); N = len(P)
    e1=e2=e3=e4=e5=e6=0.0
    for _ in range(3):
        X = rand_sym(N)
        t = basis_project(n, X)
        a = weyl_project(n, X)
        b = repo.weyl_project(n, X)
        nt = np.linalg.norm(t)
        e1 = max(e1, np.linalg.norm(a-t)/nt)
        e2 = max(e2, np.linalg.norm(b-t)/nt)
        e3 = max(e3, np.linalg.norm(a-b)/nt)
        e4 = max(e4, np.linalg.norm(weyl_project(n,a)-a)/np.linalg.norm(a))
        Z = rand_sym(N)
        num = abs(float(np.tensordot(weyl_project(n,X),Z)) - float(np.tensordot(X,weyl_project(n,Z))))
        e5 = max(e5, num/(np.linalg.norm(X)*np.linalg.norm(Z)))
        e6 = max(e6, max(np.abs(alt_part(n,a)).max(), np.abs(ricci_of(n,a)).max())/nt)
    print(f"{n:3d} {e1:14.2e} {e2:14.2e} {e3:13.2e} {e4:11.2e} {e5:10.2e} {e6:10.2e}")

print()
print("== B. coefficients fitted INDEPENDENTLY against the basis projector ==")
print("   model  P(X) = Y - alpha*KN(rho0) - beta*s*KN(g)")
print(f"{'n':>3} {'alpha_fit':>12} {'2/(n-2)':>12} {'beta_fit':>14} {'1/(n(n-1))':>14} {'resid':>10}")
for n in (5, 6, 7, 8, 9, 10, 11, 12):
    P, idx, sgn = pairs_of(n); N = len(P)
    rows = []; rhs = []
    for _ in range(4):
        X = rand_sym(N)
        Y = X - alt_part(n, X)
        R = ricci_of(n, Y); s = float(np.trace(R)); rho0 = R - s/n*np.eye(n)
        u1 = KN(n, rho0).ravel()
        u2 = (s*KN(n, np.eye(n))).ravel()
        rows.append(np.stack([u1, u2], axis=1))
        rhs.append((Y - basis_project(n, X)).ravel())
    A = np.concatenate(rows); b = np.concatenate(rhs)
    sol, res, rank, sv = np.linalg.lstsq(A, b, rcond=None)
    pred = A@sol
    print(f"{n:3d} {sol[0]:12.8f} {2/(n-2):12.8f} {sol[1]:14.10f} {1/(n*(n-1)):14.10f} "
          f"{np.linalg.norm(pred-b)/np.linalg.norm(b):10.2e}")

print()
print("== C. one-coefficient-wrong probes (does a combined test hide it?) ==")
n = 9
P, idx, sgn = pairs_of(n); N = len(P)
X = rand_sym(N); t = basis_project(n, X); nt = np.linalg.norm(t)
Wp = weyl_basis(n)
Wel = normalize(sum(rng.normal()*bb for bb in Wp))   # a genuine element of Weyl_n
for lab, al, be in (("correct", 2/(n-2), 1/(n*(n-1))),
                    ("alpha/2", 1/(n-2), 1/(n*(n-1))),
                    ("beta/2",  2/(n-2), 0.5/(n*(n-1))),
                    ("both /2", 1/(n-2), 0.5/(n*(n-1)))):
    a = weyl_project(n, X, al, be)
    onW = weyl_project(n, Wel, al, be)
    idem = np.linalg.norm(weyl_project(n, a, al, be)-a)/np.linalg.norm(a)
    print(f"  {lab:8s} off-Weyl rel err {np.linalg.norm(a-t)/nt:9.3e}  "
          f"idem {idem:9.3e}   fixes Weyl_n to {np.linalg.norm(onW-Wel):9.3e}")

print()
print("== D. does the projector work at n=13,14 (cost check) ==")
for n in (13, 14):
    P, idx, sgn = pairs_of(n); N = len(P)
    X = rand_sym(N)
    t0 = time.time(); a = weyl_project(n, X); t1 = time.time()
    idem = np.linalg.norm(weyl_project(n,a)-a)/np.linalg.norm(a)
    Z = rand_sym(N)
    sa = abs(float(np.tensordot(weyl_project(n,X),Z)) - float(np.tensordot(X,weyl_project(n,Z))))/(np.linalg.norm(X)*np.linalg.norm(Z))
    inw = max(np.abs(alt_part(n,a)).max(), np.abs(ricci_of(n,a)).max())/np.linalg.norm(a)
    tr = None
    print(f"  n={n} N={N} time={t1-t0:.3f}s idem={idem:.2e} selfadj={sa:.2e} in-Weyl={inw:.2e}")

print()
print("== E. trace of the projector = dim Weyl_n (the r49 lesson) ==")
for n in (5, 6, 7, 8, 9, 10):
    P, idx, sgn = pairs_of(n); N = len(P)
    # trace over an orthonormal basis of Sym^2
    tr = 0.0
    for a in range(N):
        E = np.zeros((N,N)); E[a,a] = 1.0
        tr += float(np.tensordot(E, weyl_project(n, E)))
    for a in range(N):
        for bq in range(a+1, N):
            E = np.zeros((N,N)); E[a,bq]=E[bq,a]=1/np.sqrt(2)
            tr += float(np.tensordot(E, weyl_project(n, E)))
    print(f"  n={n} tr(P)={tr:.6f} dim Weyl={dim_weyl(n)}  diff={tr-dim_weyl(n):.2e}")
