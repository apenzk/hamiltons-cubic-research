import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
import r318_lib as L

def Jmat(m):
    n = 2*m
    J = np.zeros((n, n))
    for k in range(m):
        J[2*k, 2*k+1] = -1.0
        J[2*k+1, 2*k] = 1.0
    return J

def cp_blocks(m):
    """projections onto R.J, su(m) and the complement inside Lambda^2 R^{2m}."""
    n = 2*m
    J = Jmat(m)
    jv = L.mat_to_vec(J, n); jv = jv/np.linalg.norm(jv)
    # u(m) = centraliser of J inside so(n): +1 eigenspace of Ad(J)
    AdJ = L.lam2(J, n)          # X -> J X J^T = -J X J = Ad(J) X  (J^T = -J, J^2=-I)
    w, V = np.linalg.eigh(AdJ)
    um = V[:, w > 0.5]
    mm = V[:, w < -0.5]
    Pu = L.proj_from_cols(um)
    Pj = np.outer(jv, jv)
    Psu = Pu - Pj
    Pm = L.proj_from_cols(mm)
    return Pj, Psu, Pm, um, mm, jv

def W_CP(m):
    n = 2*m
    Pj, Psu, Pm, um, mm, jv = cp_blocks(m)
    R, lam, res = L.op_from_projs([Pj, Psu, Pm], n)
    W = L.weyl_of(R, n)
    return W, R, lam, res, n, (um, mm, jv)

def sphere_prod_W(p, q):
    n = p+q; P = L.pairs(n)
    d1 = np.array([1.0 if (i < p and j < p) else 0.0 for (i, j) in P])
    d2 = np.array([1.0 if (i >= p and j >= p) else 0.0 for (i, j) in P])
    R, lam, res = L.op_from_projs([np.diag(d1), np.diag(d2)], n)
    return L.weyl_of(R, n), n
