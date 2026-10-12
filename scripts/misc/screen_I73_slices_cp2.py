# I73, D3's teeth test: two-dimensional slices span(W, U, V) through padded W_CP2 at n = 12.
# U is the class direction (route A), V ranges over the Weyl-projected eigenspace-pair subspaces S_ab.
# On the slice, P(cos t W + sin t D(phi)) = theta c^3 + 3 a(phi) c s^2 + b(phi) s^3 with a quadratic and b cubic in (cos phi, sin phi).
# The slice detects non-global maximality iff its max exceeds theta. /usr/bin/python3, minutes.
import sys, numpy as np
sys.path.insert(0,__file__.rsplit('/',1)[0])
from screen_I73_pair_direction import pairs, structure_constants, weyl_projector, sharp_mat
from screen_I73_pair_blindness import padded_cp2, theta_and_checks
n=12; N=len(pairs(n)); c=structure_constants(n); Pi,_=weyl_projector(n)
W=padded_cp2(n); W=W/np.linalg.norm(W); w=W.ravel()
th,wy,cr=theta_and_checks(W,c,Pi,N); print('theta',th,'weyl res',wy,'crit res',cr)
P=lambda X: np.trace(X@X@X)+np.sum(X*sharp_mat(c,X,X))
LW=lambda V: 0.5*(W@V+V@W)+sharp_mat(c,W,V)
def perp(V):
    V=(Pi@V.ravel()); V=V-(V@w)*w; nv=np.linalg.norm(V)
    return None if nv<1e-10 else (V/nv).reshape(N,N)
ts=np.linspace(0,np.pi,1201); cs,sn=np.cos(ts),np.sin(ts); phis=np.linspace(0,np.pi,721)
def slice_max(U,V):
    V=V-np.sum(U*V)*U; nv=np.linalg.norm(V)
    if nv<1e-10: return -9
    V=V/nv
    aUU,aUV,aVV=np.sum(U*LW(U)),np.sum(U*LW(V)),np.sum(V*LW(V))
    # cubic coefficients of P(xU+yV) = k0 x^3 + k1 x^2 y + k2 x y^2 + k3 y^3, from four evaluations
    pts=[(1,0),(0,1),(1,1),(1,-1)]; vals=[P(x*U+y*V) for x,y in pts]
    M=np.array([[x**3,x*x*y,x*y*y,y**3] for x,y in pts],float); k=np.linalg.solve(M,vals)
    x,y=np.cos(phis)[:,None],np.sin(phis)[:,None]
    a=aUU*x*x+2*aUV*x*y+aVV*y*y; b=k[0]*x**3+k[1]*x*x*y+k[2]*x*y*y+k[3]*y**3
    g=th*cs**3+3*a*cs*sn**2+b*sn**3   # t in [0,pi] with phi in [0,pi] covers the slice sphere
    return g.max()
ev,Q=np.linalg.eigh(W); vals=[]
for x in ev:
    if not vals or abs(x-vals[-1])>1e-6: vals.append(x)
groups=[Q[:,np.abs(ev-x)<1e-6] for x in vals]
print('eigenvalues',[round(v,6) for v in vals],'mults',[g.shape[1] for g in groups])
Uc=perp(sum((j+1.0)*G@G.T for j,G in enumerate(groups)))
rng=np.random.default_rng(0); best=-9
for A in range(len(vals)):
    for B in range(A,len(vals)):
        Ga,Gb=groups[A],groups[B]; bp=-9
        for _ in range(150):
            u=Ga@rng.normal(size=Ga.shape[1]); u/=np.linalg.norm(u)
            v=Gb@rng.normal(size=Gb.shape[1]); v-= (v@u)*u
            if np.linalg.norm(v)<1e-9: continue
            v/=np.linalg.norm(v); D=perp(0.5*(np.outer(u,v)+np.outer(v,u)))
            if D is None: continue
            bp=max(bp,slice_max(Uc,D))
        print(f'pair ({vals[A]:.4f},{vals[B]:.4f}): best class+pair slice max {bp:.6f}'); best=max(best,bp)
# two pair directions, no class direction
bp2=-9
for _ in range(1500):
    Ds=[]
    for _k in range(2):
        A,B=rng.integers(len(vals),size=2); Ga,Gb=groups[A],groups[B]
        u=Ga@rng.normal(size=Ga.shape[1]); u/=np.linalg.norm(u); v=Gb@rng.normal(size=Gb.shape[1]); v-=(v@u)*u
        Ds.append(perp(0.5*(np.outer(u,v)+np.outer(v,u))) if np.linalg.norm(v)>1e-9 else None)
    if Ds[0] is None or Ds[1] is None: continue
    bp2=max(bp2,slice_max(Ds[0],Ds[1]))
print('best pair+pair slice max',bp2)
# control: the product S^5 x S^5 (p = q = 6), P = theta_split(6,6) = 1.23603 > theta;
# every slice containing W and it exceeds theta, so the test can fire
from screen_I66_sphere_product_anchor import sphere_weight, theta_split
sw=sphere_weight(n,6); X=np.diag([sw[i,j] for (i,j) in pairs(n)]); X=X/np.linalg.norm(X)
print('product: Weyl res',np.linalg.norm(Pi@X.ravel()-X.ravel()),'P',P(X),'theta_split(6,6)',theta_split(6,6))
Ds=perp(X); print('control slice max (contains product)',slice_max(Ds,perp(rng.normal(size=(N,N)))))
w0=w/np.linalg.norm(w); tot=0
for A in range(len(vals)):
    for B in range(A,len(vals)):
        Ga,Gb=groups[A],groups[B]; dirs=[]
        for i in range(Ga.shape[1]):
            for j in range(Gb.shape[1]):
                if A==B and j<=i: continue
                Y=Pi@(0.5*(np.outer(Ga[:,i],Gb[:,j])+np.outer(Gb[:,j],Ga[:,i]))).ravel(); dirs.append(Y-(Y@w0)*w0)
        if not dirs: continue
        Ud,Sd,_=np.linalg.svd(np.array(dirs).T,full_matrices=False); Sb=Ud[:,Sd>1e-9]
        f=np.linalg.norm(Sb.T@Ds.ravel())**2; print(f'  |proj of D* on S({vals[A]:.4f},{vals[B]:.4f})|^2 = {f:.4f}, dim {Sb.shape[1]}')
print('  <W,X*> =',np.sum(W*X))
best_rand=-9
for _ in range(3000):
    X=perp(rng.normal(size=(N,N)))
    best_rand=max(best_rand,slice_max(X,perp(rng.normal(size=(N,N)))))
print('random slice max (null)',best_rand)
print('SUMMARY theta',th,'class+pair',best,'pair+pair',bp2,'random',best_rand)
