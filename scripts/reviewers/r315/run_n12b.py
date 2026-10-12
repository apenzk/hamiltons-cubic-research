import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, core, geom
from run_n12 import sphere_product_W

LOG = 'agent_logs/r315-c3-reduction.log'
def log(s):
    with open(LOG, 'a') as f:
        f.write(time.strftime('%H:%M:%S') + ' [n12b] ' + s + '\n')

n = 12
alg = core.Alg(n)
B = core.weyl_basis(n, verbose=False)
Bf = B.reshape(B.shape[0], alg.N * alg.N)
j = geom.grading_J(alg, 6); JJ = np.outer(j, j).ravel()
M = Bf @ (Bf * JJ[None, :]).T; M = 0.5*(M+M.T)
ev, Vv = np.linalg.eigh(M); Vc = Vv[:, ev > 0.5]
Vb = np.einsum('da,dij->aij', Vc, B); Vf = Vb.reshape(Vb.shape[0], alg.N*alg.N)
d = Vb.shape[0]
kslice = [c for c,(i,jj) in enumerate(alg.P) if (i<6 and jj<6) or (i>=6 and jj>=6)]
log(f'slice dim {d}')

def Qv(w):
    W = np.einsum('a,aij->ij', w, Vb)
    return Vf @ (W @ W + alg.sharp_self(W)).ravel()

def Pv(w):
    return float(np.dot(w, Qv(w)))

def Lslice(W):
    Lv = np.zeros((d, d))
    for k in range(d):
        Lv[:, k] = Vf @ alg.L(W, Vb[k]).ravel()
    return 0.5*(Lv+Lv.T)

# ---- exact eigenspace-vs-orbit check at S^5 x S^7
W = sphere_product_W(alg, 5); th = core.frob(W, alg.Q(W))
Lv = Lslice(W)
wv = Vf @ W.ravel(); wv /= np.linalg.norm(wv)
Pp = np.eye(d) - np.outer(wv, wv)
evs, Vs = np.linalg.eigh(Pp @ Lv @ Pp)
Le = evs/th
idx = np.where(np.abs(Le-0.5) < 1e-8)[0]
cols = []
for c in kslice:
    ad = alg.C[c].T
    cols.append(Vf @ (ad @ W - W @ ad).ravel())
Mo = np.array(cols).T
U, s, _ = np.linalg.svd(Mo, full_matrices=False)
U = U[:, s > 1e-9*max(1.0, s[0])]
Es = Vs[:, idx]
r1 = np.linalg.norm(U @ (U.T @ Es))/np.linalg.norm(Es)
r2 = np.linalg.norm(Es @ (Es.T @ U))/np.linalg.norm(U)
log(f'S^5xS^7 on (6,6) slice: dim(1/2-eigsp)={len(idx)} dim(orbit tgt)={U.shape[1]} '
    f'eigsp inside orbit={r1:.12f} orbit inside eigsp={r2:.12f}  -> subspaces identical')

# ---- padded CP^2 inside the (6,6) slice
def cp2_padded(alg, base):
    n_ = alg.n; N = alg.N
    a,b,c,dd = base
    def pi(i,j):
        s = 1.0
        if i>j: i,j,s = j,i,-1.0
        return alg.P.index((i,j)), s
    def vec(pairs):
        v = np.zeros(N)
        for (i,jj,co) in pairs:
            k,s = pi(i,jj); v[k] += co*s
        return v/np.linalg.norm(v)
    u1 = vec([(a,b,1.0),(c,dd,1.0)])
    u2 = vec([(a,c,1.0),(b,dd,-1.0)])
    u3 = vec([(a,dd,1.0),(b,c,1.0)])
    Wc = 2*np.outer(u1,u1) - np.outer(u2,u2) - np.outer(u3,u3)
    return Wc/np.linalg.norm(Wc)

Wcp = cp2_padded(alg, (0,1,2,3))
dw = np.linalg.norm(Wcp - np.einsum('a,aij->ij', Bf @ Wcp.ravel(), B))
ds = np.linalg.norm(Wcp - np.einsum('a,aij->ij', Vf @ Wcp.ravel(), Vb))
thc = core.frob(Wcp, alg.Q(Wcp)); resc = np.linalg.norm(alg.Q(Wcp)-thc*Wcp)
log(f'padded CP^2 (coords 0-3): theta={thc:.9f} sqrt(3/2)={np.sqrt(1.5):.9f} dist to Weyl={dw:.2e} dist to (6,6)-slice={ds:.2e} ||Q-thW||={resc:.2e}')
Lv = Lslice(Wcp)
wv = Vf @ Wcp.ravel(); wv /= np.linalg.norm(wv)
Pp = np.eye(d) - np.outer(wv, wv)
Lec = np.sort(np.linalg.eigvalsh(Pp @ Lv @ Pp)/thc)
log(f'padded CP^2 on (6,6) slice: lam_max(L_e)={Lec[-1]:.9f}  #(>1/2+1e-8)={int(np.sum(Lec>0.5+1e-8))} top5={np.round(Lec[-5:],6).tolist()}')

# ---- random ascents on the 834-dim slice
rng = np.random.default_rng(7)
res = {}
NST = int(sys.argv[1]) if len(sys.argv)>1 else 60
for st in range(NST):
    w = rng.standard_normal(d); w /= np.linalg.norm(w)
    t = 0.1; val = Pv(w)
    for it in range(800):
        g = Qv(w); gt = g - np.dot(g,w)*w
        if np.linalg.norm(gt) < 1e-11: break
        ok=False
        for _ in range(40):
            w2 = w + t*gt; w2 /= np.linalg.norm(w2); v2 = Pv(w2)
            if v2 > val: w, val, ok = w2, v2, True; t *= 1.6; break
            t *= 0.4
        if not ok: break
    if val < 0: val = -val; w = -w
    k = round(val, 6)
    res[k] = res.get(k, 0) + 1
    if (st+1) % 10 == 0:
        log(f'ascent {st+1}/{NST}: theta histogram {dict(sorted(res.items()))}')
log(f'FINAL n=12 (6,6) slice ascent histogram over {NST} random starts: {dict(sorted(res.items()))}')
log('n12b DONE')
