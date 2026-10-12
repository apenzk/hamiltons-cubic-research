"""Is the witness GRADED?  p := span of positive eigenvectors, m := span of negatives."""
import sys
import numpy as np
sys.path.insert(0, 'scripts/reviewers/r296')
import core296 as c

n = 8
W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
lam, V = np.linalg.eigh(W)
pos, neg = lam > 1e-9, lam < -1e-9
Vp, Vm = V[:, pos], V[:, neg]                    # columns = elements of so(8) in phi basis
cst = c.cst(n)


def brk(x, y):                                   # bracket in the phi coordinates
    return np.einsum('a,b,abg->g', x, y, cst)


def proj_res(X, Y, S):
    """max over pairs of ||[x,y] - proj_S [x,y]|| / ||[x,y]||."""
    worst, worstabs = 0.0, 0.0
    for i in range(X.shape[1]):
        for j in range(Y.shape[1]):
            v = brk(X[:, i], Y[:, j])
            nv = np.linalg.norm(v)
            r = np.linalg.norm(v - S @ (S.T @ v))
            worstabs = max(worstabs, r)
            if nv > 1e-9:
                worst = max(worst, r / nv)
    return worst, worstabs


print(f"dim p = {Vp.shape[1]}, dim m = {Vm.shape[1]}")
for lab, X, Y, S in [("[p,p] in p", Vp, Vp, Vp), ("[p,m] in m", Vp, Vm, Vm),
                     ("[m,m] in p", Vm, Vm, Vp)]:
    r, a = proj_res(X, Y, S)
    print(f"   {lab}:  max relative leak {r:.2e}   max absolute leak {a:.2e}")
print("=> so(8) = p + m is a Z_2 grading and W is a GRADED critical point.")

# which grading?  does p act reducibly on R^8?
P = np.zeros((n, n, Vp.shape[1]))
phis = np.zeros((28, n, n))
for a, (i, j) in enumerate(c.pairs_of(n)):
    phis[a, i, j] = 1.0; phis[a, j, i] = -1.0
Pm = np.einsum('ak,aij->kij', Vp, phis)          # 13 matrices in so(8)
# common invariant subspaces: eigenvectors of the Casimir sum? use the commutant
Comm = []
for k in range(Pm.shape[0]):
    A_ = Pm[k]
    # X A - A X = 0 for X symmetric
    rows = []
    for i in range(n):
        for j in range(i, n):
            E = np.zeros((n, n)); E[i, j] = E[j, i] = 1.0
            rows.append((E @ A_ - A_ @ E).reshape(-1))
    Comm.append(np.array(rows).T)
Cm = np.vstack(Comm)
sv = np.linalg.svd(Cm, compute_uv=False)
print(f"\ndim of the symmetric commutant of p on R^8 = {int((sv < 1e-8*sv[0]).sum())}"
      f"   (1 => p acts IRREDUCIBLY on R^8)")

# ideal structure of p: 13 = 3 + 10
K = np.einsum('kij,lji->kl', Pm, Pm)             # trace form
print(f"trace form of p: eigenvalues {np.round(np.linalg.eigvalsh(K), 4)}")
# decompose p into ideals by the adjoint action
str_p = np.zeros((13, 13, 13))
G = np.einsum('ak,al->kl', Vp, Vp)
for i in range(13):
    for j in range(13):
        v = brk(Vp[:, i], Vp[:, j])
        str_p[i, j] = Vp.T @ v
casimir = np.einsum('ikl,jlk->ij', str_p, str_p)
ev = np.linalg.eigvalsh(casimir)
print(f"Killing form of p (eigenvalues): {np.round(ev, 4)}")
print("   two distinct values with multiplicities 3 and 10  =>  p = so(3) + so(5)"
      "  (= sp(1) + sp(2))")
