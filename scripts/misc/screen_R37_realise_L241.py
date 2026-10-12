# R37's abandon test at L241: does ANY orthogonal decomposition so(12) = V0 + V1 + V2, dims (7,52,7),
# carry L241's class data tau_abc and G_ab? The class data depends on the decomposition alone
# (tau = squared structure constants summed over classes, G = tr A_a A_b with A_a = Ric(P_a)).
# Screen: least squares over orthonormal bases of V0, V2 with an exact analytic gradient, fixed restarts.
# A residual reaching zero means L241's class data is realisable and R37 cannot exclude it.
# Usage: python3 screen_R37_realise_L241.py [restarts] [G12]
import sys, time, numpy as np
from scipy.optimize import minimize
n = 12; R = int(sys.argv[1]) if len(sys.argv) > 1 else 6; G12 = float(sys.argv[2]) if len(sys.argv) > 2 else 77.0
pairs = [(i, j) for i in range(n) for j in range(i+1, n)]; N = len(pairs)
E = np.zeros((N, n, n))
for k, (i, j) in enumerate(pairs): E[k, i, j], E[k, j, i] = 1, -1          # record norm <X,Y> = -1/2 tr XY: <E,E> = 1
ip = lambda X, Y: -0.5*np.trace(X@Y)
# structure constants c_ijk = <[E_i,E_j],E_k>, totally antisymmetric
C = np.zeros((N, N, N))
for a in range(N):
    for b in range(N):
        Br = E[a]@E[b]-E[b]@E[a]
        C[a, b] = -0.5*np.einsum('pq,kqp->k', Br, E)
assert abs(np.einsum('ijk,ijk->i', C, C)[0] - 2*(n-2)) < 1e-9          # row (A): sum_{jk} c_ijk^2 = 2(n-2)
# L(P) = sum_{i,i'} P[i,i'] E_i E_i'^T, the isotropy of a projector
EE = np.einsum('ipq,jrq->ijpr', E, E)                                   # (E_i E_j^T)_{pr}
L = lambda P: np.einsum('ij,ijpr->pr', P, EE)
Lstar = lambda M: np.einsum('pr,ijpr->ij', M, EE)
e = [-0.2, 0.0, 0.2]; m = [7, 52, 7]
tt = {(0,0,0):0,(0,0,1):0,(0,0,2):42,(0,1,1):28,(0,1,2):14,(0,2,2):0,(1,1,1):928,(1,1,2):0,(1,2,2):28,(2,2,2):14}
G02 = (154-G12)/2; G00 = (154-G12)/2; G11 = 1144-2*G12; G22 = 154-G02-G12
gt = {(0,0):G00,(0,1):G12,(0,2):G02,(1,1):G11,(1,2):G12,(2,2):G22}
trip = list(tt); prs = list(gt)
def unpack(x):
    U0 = x[:N*7].reshape(N, 7); U2 = x[N*7:].reshape(N, 7)
    return U0, U2
def f_and_grad(x):
    U0, U2 = unpack(x)
    P0, P2 = U0@U0.T, U2@U2.T; P = [P0, np.eye(N)-P0-P2, P2]
    # tau_abc = <C, (P_a x P_b x P_c) C>
    CP = {}
    val = 0.0; gP = [np.zeros((N, N)) for _ in range(3)]
    for (a, b, c) in trip:
        X = np.einsum('ijk,kl->ijl', C, P[c]); X = np.einsum('ijl,jm->iml', X, P[b])   # C with P_b, P_c on slots 2,3
        tau = np.einsum('il,ljk,ijk->', P[a], X, C)
        s_ = 1.0/(1.0+tt[(a, b, c)]); r = (tau - tt[(a, b, c)])*s_; val += r*r
        # d tau / d P_a[i,l] = sum_jk C_ijk X_ljk ; similarly for slots b, c by symmetry of C
        Ga = np.einsum('ijk,ljk->il', C, X)
        Xac = np.einsum('ijk,kl->ijl', C, P[c]); Xac = np.einsum('ijl,im->mjl', Xac, P[a])
        Gb = np.einsum('ijk,ilk->jl', C, Xac)
        Xab = np.einsum('ijk,jl->ilk', C, P[b]); Xab = np.einsum('ilk,im->mlk', Xab, P[a])
        Gc = np.einsum('ijk,ijl->kl', C, Xab)
        for s, Gs in ((a, Ga), (b, Gb), (c, Gc)): gP[s] += 2*r*s_*Gs
    A = [L(p) for p in P]
    for (a, b) in prs:
        s_ = 1.0/(1.0+gt[(a, b)]); g = np.trace(A[a]@A[b]); r = (g - gt[(a, b)])*s_; val += r*r
        gP[a] += 2*r*s_*Lstar(A[b]); gP[b] += 2*r*s_*Lstar(A[a])
    # P1 = I - P0 - P2
    g0 = gP[0]-gP[1]; g2 = gP[2]-gP[1]
    # penalties: orthonormality and V0 perp V2
    O0 = U0.T@U0-np.eye(7); O2 = U2.T@U2-np.eye(7); X02 = U0.T@U2
    w = 1e3; val += w*(np.sum(O0**2)+np.sum(O2**2)+2*np.sum(X02**2))
    dU0 = (g0+g0.T)@U0 + w*4*U0@O0 + w*4*U2@X02.T
    dU2 = (g2+g2.T)@U2 + w*4*U2@O2 + w*4*U0@X02
    return val, np.r_[dU0.ravel(), dU2.ravel()]
# gradient check once
rng = np.random.default_rng(0); x = rng.standard_normal(2*N*7)*0.1
v, g = f_and_grad(x); d = rng.standard_normal(x.size); h = 1e-6
fd = (f_and_grad(x+h*d)[0]-f_and_grad(x-h*d)[0])/(2*h); print('gradient check: analytic', g@d, 'finite difference', fd, flush=True)
best = None; t0 = time.time()
for r in range(R):
    x0 = np.linalg.qr(rng.standard_normal((N, 14)))[0].ravel(order='F')
    x0 = np.r_[x0[:N*7], x0[N*7:]]
    res = minimize(f_and_grad, x0, jac=True, method='L-BFGS-B', options={'maxiter': 4000, 'gtol': 1e-10})
    U0, U2 = unpack(res.x); print(f'restart {r}: residual {res.fun:.3e}  orth {np.linalg.norm(U0.T@U0-np.eye(7)):.1e} {np.linalg.norm(U0.T@U2):.1e}  {time.time()-t0:.0f}s', flush=True)
    if best is None or res.fun < best[0]: best = (res.fun, res.x)
print('DONE best residual', best[0])
np.save(__file__.rsplit('/',1)[0] + '/../../agent_logs/R37_best.npy', best[1])
