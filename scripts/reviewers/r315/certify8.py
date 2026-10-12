"""Certify Morse-Bott local maximality on the n=8 (3,5) slice for named points,
and fingerprint whatever the random ascents land on."""
import sys, os, time, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, core, geom, slice8

n = 8
alg = core.Alg(n)
B = core.weyl_basis(n, verbose=False)
Bf = B.reshape(B.shape[0], alg.N*alg.N)
P = alg.P

def slice_for(p):
    Vc, _ = geom.slice_basis(alg, B, p)
    Vb = np.einsum('da,dij->aij', Vc, B)
    return Vb, Vb.reshape(Vb.shape[0], alg.N*alg.N)

def sphere_prod(setA):
    a = len(setA); b = n - a
    al, be, ga = b/(a-1.0), a/(b-1.0), -1.0
    d = np.zeros(alg.N)
    for k,(i,j) in enumerate(P):
        ia, ja = i in setA, j in setA
        d[k] = al if (ia and ja) else (be if not (ia or ja) else ga)
    W = np.diag(d); return W/np.linalg.norm(W)

def cp2(base):
    def pi(i,j):
        s=1.0
        if i>j: i,j,s=j,i,-1.0
        return P.index((i,j)), s
    def vec(pl):
        v=np.zeros(alg.N)
        for (i,j,c) in pl:
            k,s=pi(i,j); v[k]+=c*s
        return v/np.linalg.norm(v)
    a,b,c,d_=base
    u1=vec([(a,b,1.),(c,d_,1.)]); u2=vec([(a,c,1.),(b,d_,-1.)]); u3=vec([(a,d_,1.),(b,c,1.)])
    Wc=2*np.outer(u1,u1)-np.outer(u2,u2)-np.outer(u3,u3)
    return Wc/np.linalg.norm(Wc)

def certify(Vb, Vf, p, W, label):
    d = Vb.shape[0]
    dw = np.linalg.norm(W - np.einsum('a,aij->ij', Bf @ W.ravel(), B))
    ds = np.linalg.norm(W - np.einsum('a,aij->ij', Vf @ W.ravel(), Vb))
    th = core.frob(W, alg.Q(W)); res = np.linalg.norm(alg.Q(W)-th*W)
    Lv = np.zeros((d,d))
    for k in range(d):
        Lv[:,k] = Vf @ alg.L(W, Vb[k]).ravel()
    Lv = 0.5*(Lv+Lv.T)
    wv = Vf @ W.ravel(); wv/=np.linalg.norm(wv)
    Pp = np.eye(d)-np.outer(wv,wv)
    evs, Vs = np.linalg.eigh(Pp@Lv@Pp); Le = evs/th
    idx = np.where(np.abs(Le-0.5)<1e-8)[0]
    above = int(np.sum(Le>0.5+1e-8))
    ks = [c for c,(i,j) in enumerate(P) if (i<p and j<p) or (i>=p and j>=p)]
    cols=[]
    for c in ks:
        ad = alg.C[c].T
        cols.append(Vf @ (ad@W - W@ad).ravel())
    Mo=np.array(cols).T
    U,s,_=np.linalg.svd(Mo, full_matrices=False); U=U[:, s>1e-9*max(1.,s[0])]
    r1 = np.linalg.norm(U@(U.T@Vs[:,idx]))/max(1e-30,np.linalg.norm(Vs[:,idx])) if len(idx) else 1.0
    r2 = np.linalg.norm(Vs[:,idx]@(Vs[:,idx].T@U))/max(1e-30,np.linalg.norm(U)) if U.shape[1] else 1.0
    srt=np.sort(Le)
    nxt = srt[-len(idx)-1] if len(idx) else srt[-1]
    print(f'{label:34s} theta={th:.9f} inWeyl={dw:.1e} inSlice={ds:.1e} |Q-thW|={res:.1e} '
          f'lam_max={srt[-1]:.9f} #(=1/2)={len(idx)} #(>1/2)={above} orbit_tgt={U.shape[1]} '
          f'eig<=orb={r1:.10f} orb<=eig={r2:.10f} next={nxt:.9f}')

for p in [3, 4]:
    Vb, Vf = slice_for(p)
    print(f'=== n=8, ({p},{8-p}) slice, dim {Vb.shape[0]} ===')
    certify(Vb, Vf, p, sphere_prod(set(range(3))), 'S^3xS^5 (coords 012|34567)')
    certify(Vb, Vf, p, sphere_prod(set(range(4))), 'S^4xS^4 (coords 0123|4567)')
    certify(Vb, Vf, p, sphere_prod(set(range(2))), 'S^2xS^6 (coords 01|234567)')
    certify(Vb, Vf, p, cp2((4,5,6,7)), 'padded CP^2 (coords 4567)')
    certify(Vb, Vf, p, cp2((0,1,2,3)), 'padded CP^2 (coords 0123)')
