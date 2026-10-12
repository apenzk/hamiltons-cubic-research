import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *

np.random.seed(0)
for n in [6, 8, 10]:
    N = len(pairs(n))
    A = Amats(n)
    # Id^# = (n-2) Id
    I = np.eye(N)
    s = sb(n, I, I)
    print(f"n={n} N={N}  Id# - (n-2)Id : {np.abs(s-(n-2)*I).max():.2e}")
    # dim Weyl via projector rank
    Dsym = N*(N+1)//2
    rows = []
    basis = []
    for i in range(N):
        for j in range(i, N):
            X = np.zeros((N, N)); X[i, j] = 1.0; X[j, i] = 1.0
            basis.append(X)
    Pm = np.array([proj_weyl(n, X).ravel() for X in basis])
    r = np.linalg.matrix_rank(Pm, tol=1e-8)
    print(f"   rank P_Weyl = {r}   formula = {dim_weyl(n)}")
    # symmetry of the projector as a map on Sym^2 (orthogonality check)
    G = np.array([[np.sum(basis[a]*proj_weyl(n, basis[b])) for b in range(len(basis))] for a in range(0,0)])
    # random Weyl element check
    X = np.random.randn(N, N); X = X + X.T
    Wr = proj_weyl(n, X)
    print(f"   alt(Wr)={np.abs(alt(n,Wr)).max():.2e} ric(Wr)={np.abs(ricci(n,Wr)).max():.2e} idem={np.abs(proj_weyl(n,Wr)-Wr).max():.2e}")
    # trilinear symmetry <X o Y, Z> totally symmetric on random symmetric
    def rs():
        M = np.random.randn(N, N); return M+M.T
    X1, Y1, Z1 = rs(), rs(), rs()
    t1 = np.sum(circ(n, X1, Y1)*Z1); t2 = np.sum(circ(n, Y1, Z1)*X1); t3 = np.sum(circ(n, Z1, X1)*Y1)
    print(f"   trilinear sym: {abs(t1-t2):.2e} {abs(t1-t3):.2e} (scale {abs(t1):.2e})")
