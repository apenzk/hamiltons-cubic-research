"""Critical points of P on the sphere of V = {W in Weyl_8 : [W, Ad(J)] = 0},
looking for one that is sign-graded with the u(4) splitting and Delta > 0."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib317 as L, points317 as PT

n = 8; m = 4
c = L.structure_constants(n)
ns, coords, N = L.weyl_basis(n)
ker = np.load('scripts/reviewers/r317/kerJ_n8.npy')
mats = np.array([L.coords_to_M(ns[d], coords, N) for d in range(ns.shape[0])])
Vb = np.einsum('kd,dab->kab', ker, mats)
# orthonormalise V
flat = Vb.reshape(Vb.shape[0], -1)
qq, _ = np.linalg.qr(flat.T)
Vb = qq.T.reshape(-1, N, N)
Wb = mats.reshape(mats.shape[0], -1)
qw, _ = np.linalg.qr(Wb.T)
Wb = qw.T.reshape(-1, N, N)
print('dim V =', Vb.shape[0], ' dim Weyl =', Wb.shape[0])

def projV(M):
    co = np.einsum('kab,ab->k', Vb, M)
    return np.einsum('k,kab->ab', co, Vb)

def projW(M):
    co = np.einsum('kab,ab->k', Wb, M)
    return np.einsum('k,kab->ab', co, Wb)

J = np.zeros((n, n))
for a in range(m):
    J[2*a, 2*a+1] = 1.0; J[2*a+1, 2*a] = -1.0
AdJ = L.Lambda2(J, n)
evJ, VJ = np.linalg.eigh(AdJ)
Pp = VJ[:, evJ > 0.5] @ VJ[:, evJ > 0.5].T

rng = np.random.default_rng(31700)
found = {}
for trial in range(60):
    v = rng.normal(size=Vb.shape[0])
    W = np.einsum('k,kab->ab', v, Vb); W /= np.linalg.norm(W)
    for it in range(1500):
        G = projV(L.Q(W, c))
        Wn = W + 0.15 * (G - float(np.sum(G * W)) * W)
        Wn /= np.linalg.norm(Wn)
        if np.linalg.norm(Wn - W) < 1e-13:
            W = Wn; break
        W = Wn
    QW = L.Q(W, c); th = float(np.sum(W * QW))
    resV = np.linalg.norm(projV(QW) - th * W)
    resW = np.linalg.norm(projW(QW) - th * W)
    if resW > 1e-8:
        continue
    ev = np.linalg.eigvalsh(W)
    npos = int((ev > 1e-9).sum()); nneg = int((ev < -1e-9).sum())
    D, _ = L.defect_Delta(W, c)
    S = L.S_components(W, c)
    key = (npos, nneg, round(th, 7), round(D, 5))
    if key not in found:
        found[key] = (W.copy(), S, resW)
print('\n%d distinct limits' % len(found))
for key in sorted(found, key=lambda k: -k[2]):
    W, S, resW = found[key]
    npos, nneg, th, D = key
    _, V = np.linalg.eigh(W)
    ev = np.linalg.eigvalsh(W)
    Ep = V[:, ev > 1e-9]
    match = np.linalg.norm(Pp @ Ep - Ep) if npos else -1
    print(f'dims(+,-,0)=({npos},{nneg},{N-npos-nneg}) theta={th:+.7f} Delta={D:.5f} '
          f'S_mmm={S["S_mmm"]:.2e} S_mpp={S["S_mpp"]:.2e} res={resW:.1e} |E+ inside u(4)|={match:.1e}')
    np.save('scripts/reviewers/r317/crit_%d_%d_%s.npy' % (npos, nneg, str(th).replace('.', 'p').replace('-', 'm')), W)
