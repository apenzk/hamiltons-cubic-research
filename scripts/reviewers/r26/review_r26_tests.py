import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, itertools
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r26_core import *

np.set_printoptions(precision=10, suppress=True)

for n in [4,5,6,7,8]:
    prs, mats = phi_mats(n)
    N = len(prs)
    C = struct_const(n)
    # orthonormality of basis
    G = np.array([[ip(mats[a],mats[b]) for b in range(N)] for a in range(N)])
    assert np.allclose(G, np.eye(N)), n
    # total antisymmetry of C
    asym = max(np.abs(C + np.transpose(C,(1,0,2))).max(),
               np.abs(C + np.transpose(C,(0,2,1))).max(),
               np.abs(C - np.transpose(C,(2,0,1))).max())
    # row marginal kappa
    T = C**2
    rows = T.sum(axis=(1,2))
    pair = T.sum(axis=2)
    nnz = int((np.abs(C)>1e-12).sum())
    print(f"n={n} N={N} antisym_resid={asym:.2e} kappa(min,max)=({rows.min():.6f},{rows.max():.6f}) "
          f"expect {2*(n-2)}  max_pair={pair.max():.6f}  nnzC={nnz} expect {6*(n*(n-1)*(n-2)//6)}")
    # diagonal vanishing of T
    d1 = max(abs(T[a,a,b]) for a in range(N) for b in range(N))
    d2 = max(abs(T[a,b,a]) for a in range(N) for b in range(N))
    d3 = max(abs(T[a,b,b]) for a in range(N) for b in range(N))
    print(f"     T with repeated index: max = {max(d1,d2,d3):.2e}")
    # sharp: two implementations agree; Q(Id)=(n-1)Id
    rng = np.random.default_rng(7)
    Wr = rng.normal(size=(N,N)); Wr = Wr+Wr.T
    print(f"     sharp vs sharp_fast resid = {np.abs(sharp(Wr,C)-sharp_fast(Wr,C)).max():.2e}")
    I = np.eye(N)
    print(f"     Q(Id) - (n-1)Id resid = {np.abs(Q(I,C)-(n-1)*I).max():.2e}")
    # Weyl space
    B = weyl_basis(n)
    print(f"     dim Weyl = {B.shape[0]}  formula = {weyl_dim_formula(n)}")
