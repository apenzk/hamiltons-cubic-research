"""Reviewer 44 -- validation gates before any claim is tested."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r44_core import *

def log(m):
    print(m, flush=True)
    with open('agent_logs/review_r44_padded.log', 'a') as f:
        f.write(m + '\n')

log('PHASE 2 validation gates start')

# G0: sharp via structure constants == sharp via 4-tensor
rng = np.random.default_rng(7)
for n in (4, 5, 6, 7):
    N = n * (n - 1) // 2
    X = rng.standard_normal((N, N)); X = X + X.T
    a = sharp_structconst(X, n); b = sharp_bilin(X, X, n)
    log(f'G0 n={n}: ||#_structconst - #_4tensor|| = {np.abs(a-b).max():.3e}')

# G0b: Q(Id) = (n-1) Id
for n in (4, 6, 8):
    N = n * (n - 1) // 2
    q = Qop(np.eye(N), n)
    log(f'G0b n={n}: ||Q(I) - (n-1)I|| = {np.abs(q-(n-1)*np.eye(N)).max():.3e}')

# G1: dim Weyl_n
for n in range(4, 13):
    C = constraint_matrix(n)
    r = np.linalg.matrix_rank(C)
    D = C.shape[1]
    log(f'G1 n={n}: dim(Sym)={D} rank(C)={r} nullity={D-r} formula={n*(n+1)*(n+2)*(n-3)//12}')

# G2: orthonormal Weyl basis actually satisfies the constraints
for n in (6, 8, 10, 12):
    B = weyl_basis(n); C = constraint_matrix(n)
    log(f'G2 n={n}: dim={B.shape[1]} ||C B||={np.abs(C@B).max():.2e} '
        f'||B^T B - I||={np.abs(B.T@B-np.eye(B.shape[1])).max():.2e}')

# G3: trilinear symmetry of <X o Y, Z> (Frobenius on the pair matrix)
for n in (5, 6, 8):
    B = weyl_basis(n) if n >= 6 else None
    N = n * (n - 1) // 2
    def rnd():
        if B is None:
            Y = rng.standard_normal((N, N)); return Y + Y.T
        v = rng.standard_normal(B.shape[1])
        return p_to_X(B @ v, n)
    X, Y, Z = rnd(), rnd(), rnd()
    t1 = np.tensordot(circ(X, Y, n), Z)
    t2 = np.tensordot(circ(Y, Z, n), X)
    t3 = np.tensordot(circ(Z, X, n), Y)
    log(f'G3 n={n}: trilinear spread = {max(abs(t1-t2),abs(t2-t3)):.3e} (scale {abs(t1):.3f})')

# G4: sphere product is critical with theta = theta_0(n), and L_e W = W
for n in (6, 8, 10, 12):
    k = n // 2
    W = sphere_product_W((k, k))
    th = float(np.tensordot(W, Qop(W, n)))
    res = np.linalg.norm(Qop(W, n) - th * W)
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    e = W / th
    lw = circ(e, W, n)
    log(f'G4 n={n} S^{k}xS^{k}: theta={th:.12f} theta_0={th0:.12f} res={res:.2e} '
        f'||Ric||={np.abs(ricci(W,n)).max():.2e} |Bianchi|={np.abs(bianchi(W,n)).max():.2e} '
        f'||L_e W - W||={np.linalg.norm(lw-W):.2e}')

# G5: tr(L_x) = 0 on Weyl_n for random x in Weyl_n
for n in (6, 8):
    B = weyl_basis(n); D = B.shape[1]
    v = rng.standard_normal(D); Xr = p_to_X(B @ v, n); Xr /= np.linalg.norm(Xr)
    tr = 0.0
    TX = to_tensor(Xr, n)
    for j in range(D):
        Yj = p_to_X(B[:, j], n)
        tr += float(np.tensordot(circ(Xr, Yj, n, TX=TX), Yj))
    log(f'G5 n={n}: tr(L_x) = {tr:.3e}')
log('PHASE 2 validation gates done')
