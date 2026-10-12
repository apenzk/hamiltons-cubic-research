# I73 batch 30: checks of the identities behind the norm statement H for Hamilton's sharp on Sym^2(so(n)).
# (1) sigma#sigma = (n-2) sigma for sigma = Ad_g, g = diag(-1_k, 1_{n-k}) (symmetric orthogonal automorphism).
# (2) for every #-idempotent C (C#C = C): ||C||^2 = 2 s^2/n - s + ((n-2)/2)||C_Ric0||^2 + 3 ||C_L4||^2, s = tr C,
#     components read off the eigenspaces of L_I = I#. (scalars n-2, (n-4)/2, -1, 2), tested on I/(n-2),
#     so(k)/(k-2), Lambda^2_+/2 and sigma_k/(n-2).
# (3) realignment Z = iota(X) = sum mu_i v_i (x) v_i: F(X) = tr Z^3 / 2, ||X||^2 = tr Z^2 / 4, and every eigenvalue
#     obeys lambda^2 <= (1 - pi)/2 tr Z^2, pi = sum of fourth powers of the eigenvector's Schmidt coefficients.
# /usr/bin/python3 scripts/misc/check_I73_sharp_norm_identities.py
import itertools, numpy as np
n=9; prs=list(itertools.combinations(range(n),2)); N=len(prs)
E=np.zeros((N,n,n))
for k,(i,j) in enumerate(prs): E[k,i,j]=1; E[k,j,i]=-1
f=(np.einsum('aij,bjk,cik->abc',E,E,E)-np.einsum('bij,ajk,cik->abc',E,E,E))/2
T=np.transpose(f,(2,0,1))
def sharp(X,Y=None):
    Y=X if Y is None else Y
    U=np.matmul(np.matmul(X,T),Y); V=np.matmul(np.matmul(Y,T),X)
    return 0.25*(T.reshape(N,-1)@U.reshape(N,-1).T+T.reshape(N,-1)@V.reshape(N,-1).T)
I=np.eye(N); idx={p:k for k,p in enumerate(prs)}
def e(i,j): v=np.zeros(N); v[idx[(min(i,j),max(i,j))]]=1 if i<j else -1; return v
def proj(vs): Q,_=np.linalg.qr(np.array(vs).T); return Q@Q.T
def Ad(g): return np.array([[np.sum(E[a]*(g@E[b]@g.T))/2 for b in range(N)] for a in range(N)])
lam=[n-2,(n-4)/2,-1.0,2.0]
def comps(C):
    out=[]
    for j,l in enumerate(lam):
        Y=C.copy()
        for i,m in enumerate(lam):
            if i!=j: Y=(sharp(I,Y)-m*Y)/(l-m)
        out.append(Y)
    return out
print('(1) automorphisms:')
for k in range(1,n):
    g=np.diag([-1.0]*k+[1.0]*(n-k)); s=Ad(g)
    print(f'  k={k}: ||s#s-(n-2)s||={np.linalg.norm(sharp(s)-(n-2)*s):.1e}  tr s={np.trace(s):.0f}  s/(n-2) trace={np.trace(s)/(n-2):.4f}')
print(f'  window ends: s_- = {(n-1)*(n-4)/(2*(n-2)):.4f}, lower {-n/(2*(n-2)):.4f}; target ||C||^2 = N/(n-2)^2 = {N/(n-2)**2:.4f}')
lp=proj([e(0,1)+e(2,3),e(0,2)-e(1,3),e(0,3)+e(1,2)])
cands={'I/(n-2)':I/(n-2),'Lambda2+/2':lp/2}
for k in (3,5,7): cands[f'so({k})/({k}-2)']=proj([e(i,j) for i in range(k) for j in range(i+1,k)])/(k-2)
for k in (1,2,4): cands[f'sigma_{k}/(n-2)']=Ad(np.diag([-1.0]*k+[1.0]*(n-k)))/(n-2)
print('(2) idempotent identity:')
for name,C in cands.items():
    c0,c1,c2,c3=comps(C); s=np.trace(C); q=np.sum(C*C)
    rhs=2*s*s/n-s+(n-2)/2*np.sum(c1*c1)+3*np.sum(c3*c3)
    print(f'  {name}: idem res={np.linalg.norm(sharp(C)-C):.1e} split res={np.linalg.norm(c0+c1+c2+c3-C):.1e} s={s:.4f} ||C||^2={q:.4f} rhs={rhs:.4f}  >=target {q>=N/(n-2)**2-1e-12}')
print('(3) realignment and the Gamma cap:')
rng=np.random.default_rng(0)
for t in range(3):
    X=rng.normal(size=(N,N)); X=X+X.T
    Z=np.einsum('ab,aij,bkl->ikjl',X,E,E).reshape(n*n,n*n)
    F=np.sum(sharp(X)*X); w,U=np.linalg.eigh(Z); T2=np.sum(w*w)
    worst=max(w[j]**2/((1-np.sum(np.linalg.svd(U[:,j].reshape(n,n),compute_uv=False)**4))/2*T2) for j in range(n*n))
    print(f'  X{t}: F-trZ^3/2={F-np.sum(w**3)/2:.1e}  ||X||^2-trZ^2/4={np.sum(X*X)-T2/4:.1e}  max lambda^2/cap={worst:.4f}')
Z0=np.einsum('ab,aij,bkl->ikjl',I,E,E).reshape(n*n,n*n); w,U=np.linalg.eigh(Z0)
print(f'  Z0: top eig {w[-1]:.4f} (n-1={n-1}), cap sqrt((1-1/n)/2 trZ^2)={np.sqrt((1-1/n)/2*np.sum(w*w)):.4f}')
# (4) Casimir split of the internal mass on a subspace V (orthonormal skew v_i): with P = -sum v_i^2 and
#     C = -sum D(v_i)^2, D(v) = v(x)1 + 1(x)v, one has Z = (P(x)1 + 1(x)P - C)/2 and M(V) = 2 tr P^2 - tr(C Z^2)/2.
print('(4) Casimir split:')
for d in (3,10,20):
    Q,_=np.linalg.qr(rng.normal(size=(N,d))); vs=np.einsum('ai,ajk->ijk',Q,E)
    M=sum(np.sum(np.einsum('ij,jk->ik',a,b)*c.T)**2 for a in vs for b in vs for c in vs)
    P=-sum(v@v for v in vs); one=np.eye(n)
    Z=sum(np.kron(v,v) for v in vs); Cc=-sum((np.kron(v,one)+np.kron(one,v))@(np.kron(v,one)+np.kron(one,v)) for v in vs)
    print(f'  d={d}: M={M:.6f} trZ^3={np.trace(Z@Z@Z):.6f} split={2*np.trace(P@P)-np.trace(Cc@Z@Z)/2:.6f} 2trP^2={2*np.trace(P@P):.4f}')
