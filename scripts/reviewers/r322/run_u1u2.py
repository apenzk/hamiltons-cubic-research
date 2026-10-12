import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core, points, walk
S='/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/'
pts={}
for (p,q) in [(3,3),(4,4),(3,5),(5,5)]:
    n,W=points.sphere_product(p,q); pts[f'S{p}xS{q}']=(n,W)
pts['C5blowup']=(10,np.load(S+'W_c5.npy'))
Wt=np.load('scripts/data/w_n8_nondiagonal_witness.npy'); pts['n8witness']=(8,Wt/np.linalg.norm(Wt))
rng=np.random.default_rng(11)
def rand_so(n,rng):
    A=rng.normal(size=(n,n)); q,r=np.linalg.qr(A); return q@np.diag(np.sign(np.diag(r)))
def conj(n,W,g):
    B=core.basis(n); Bg=np.einsum('ik,akl,jl->aij',g,B,g)  # g phi g^T
    T=-0.5*np.einsum('aij,bji->ab',Bg,B)                    # change of basis (orthogonal)
    return T.T@W@T
g=rand_so(10,rng); pts['C5conj']=(10,conj(10,np.load(S+'W_c5.npy'),g))

print(f"{'point':11s} {'n':>2s} {'theta':>11s} {'lmin':>10s} {'mult':>4s} {'mass':>8s} {'2(n-2)':>7s} {'<v,W#v>':>11s} {'lmin(th-lmin)':>13s} {'mm':>10s} {'mp':>10s} {'pp':>10s} {'Smmm':>10s} {'Smpp':>10s}")
for k,(n,W) in pts.items():
    Q=core.Qop(n,W); th=core.frob(W,Q)
    lam,Phi,C=walk.walk_data(n,W)
    b,m,p,z=walk.blocks(lam,C)
    sh=core.sharp(n,W)
    lhs=float(np.einsum('a,ab,b->',np.eye(len(lam))[0],
        (Phi.reshape(len(lam),-1)@ (0*np.eye(n*n)) if False else np.zeros((len(lam),len(lam)))),np.eye(len(lam))[0]))
    # <v,W# v> directly: v = eigvec 0 in coordinate basis
    lamW,U=np.linalg.eigh(W); u0=U[:,0]
    lhs=float(u0@sh@u0)
    Smmm,Smpp,c=walk.S_tensors(n,lam,Phi)
    mult=int((np.abs(lam-lam[0])<1e-9).sum())
    print(f"{k:11s} {n:2d} {th:11.7f} {lam[0]:10.6f} {mult:4d} {b['mass']:8.4f} {2*(n-2):7d} {lhs:11.7f} {lam[0]*(th-lam[0]):13.7f} {b['mm']:10.6f} {b['mp']:10.6f} {b['pp']:10.6f} {Smmm:10.4f} {Smpp:10.4f}")
