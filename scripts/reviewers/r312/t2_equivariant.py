import sys; sys.path.insert(0,'scripts/reviewers/r312')
import numpy as np, r312lib as L
from itertools import combinations
np.set_printoptions(precision=9, suppress=True)

def so_basis(n, block):
    G=[]
    for i,j in combinations(block,2):
        X=np.zeros((n,n)); X[i,j]=1; X[j,i]=-1; G.append(X)
    return G

def gens_so_kl(n,k): return so_basis(n,range(k))+so_basis(n,range(k,n))

def gens_um(n):
    m=n//2; J=np.zeros((n,n))
    for i in range(m): J[2*i,2*i+1]=1; J[2*i+1,2*i]=-1
    B=[]
    for i,j in combinations(range(n),2):
        X=np.zeros((n,n)); X[i,j]=1; X[j,i]=-1; B.append(X)
    B=np.array(B)
    Mmap=np.array([(b@J-J@b).ravel() for b in B]).T
    U,s,Vt=np.linalg.svd(Mmap, full_matrices=True)
    r=int((s>1e-9).sum()); NS=Vt[r:]
    return [np.einsum('k,kij->ij',v,B) for v in NS]

def equivariant_weyl(a, gens, verbose=True):
    N=a.N
    Ds=[a.deriv(X) for X in gens]
    C=sum(D@D for D in Ds)
    C=0.5*(C+C.T)
    ev,U=np.linalg.eigh(C)
    # group eigenvalues
    groups=[]; cur=[0]
    for i in range(1,N):
        if abs(ev[i]-ev[cur[-1]])<1e-7*max(1,abs(ev[i])): cur.append(i)
        else: groups.append(cur); cur=[i]
    groups.append(cur)
    if verbose: print("   Casimir eigenspaces:", [(round(ev[g[0]],6), len(g)) for g in groups])
    inv=[]           # symmetric invariant operators on Lambda^2
    for g in groups:
        P=U[:,g]; d=len(g)
        Dr=[P.T@D@P for D in Ds]
        # commutant inside End(V_g)
        rows=[]
        E=np.eye(d*d)
        for D in Dr:
            K=np.kron(np.eye(d),D)-np.kron(D.T,np.eye(d))
            rows.append(K)
        M=np.vstack(rows)
        u2,s2,v2t=np.linalg.svd(M, full_matrices=True)
        r=int((s2>1e-8*max(1,s2[0])).sum()); NS=v2t[r:]
        mats=[v.reshape(d,d) for v in NS]
        # symmetric part span
        S=[]
        for m0 in mats:
            S.append((m0+m0.T).ravel()); S.append(1j*0+ (m0-m0.T).ravel()*0)
        Sm=np.array([ (m0+m0.T).ravel() for m0 in mats])
        u3,s3,v3t=np.linalg.svd(Sm, full_matrices=False)
        rk=int((s3>1e-8*max(1,s3[0])).sum())
        if verbose: print(f"     block dim {d}: commutant dim {len(mats)}, symmetric-commutant dim {rk}")
        for t in range(rk):
            Mi=v3t[t].reshape(d,d); inv.append(P@Mi@P.T)
    inv=np.array([0.5*(m+m.T) for m in inv])
    # orthonormalise
    Fl=inv.reshape(len(inv),-1)
    u,s,vt=np.linalg.svd(Fl, full_matrices=False)
    rk=int((s>1e-9*max(1,s[0])).sum())
    inv=vt[:rk].reshape(rk,N,N)
    if verbose: print("   dim symmetric p-invariant operators on Lambda^2 =", rk)
    # impose Ricci=0 and Bianchi=0
    cons=[]
    for M in inv:
        r=a.ricci(M); b=a.bianchi(M)
        cons.append(np.concatenate([r.ravel(), b.ravel()]))
    Cm=np.array(cons).T
    u4,s4,v4t=np.linalg.svd(Cm, full_matrices=True)
    r4=int((s4>1e-8*max(1,s4[0])).sum())
    NS=v4t[r4:]
    return np.einsum('mk,kab->mab', NS, inv), rk

for n in [12,13,14]:
    a=L.Amb(n)
    print(f"===== n={n}")
    for k in range(2, n//2+1):
        E,rk=equivariant_weyl(a, gens_so_kl(n,k), verbose=False)
        s=f" p=so({k})+so({n-k}): invariant-sym dim {rk} -> equivariant Weyl dim {E.shape[0]}"
        if E.shape[0]>0:
            W=E[0]/np.linalg.norm(E[0]); th=float(np.sum(a.Q(W)*W))
            if th<0: W=-W; th=-th
            s+=f"  theta={th:.9f} crit-resid={np.linalg.norm(a.Q(W)-th*W):.2e} Ric={np.abs(a.ricci(W)).max():.1e} Bi={np.abs(a.bianchi(W)).max():.1e}"
        print(s)
    if n%2==0:
        E,rk=equivariant_weyl(a, gens_um(n), verbose=False)
        s=f" p=u({n//2}):        invariant-sym dim {rk} -> equivariant Weyl dim {E.shape[0]}"
        if E.shape[0]>0:
            W=E[0]/np.linalg.norm(E[0]); th=float(np.sum(a.Q(W)*W))
            if th<0: W=-W; th=-th
            s+=f"  theta={th:.9f} theta^2={th*th:.9f} crit-resid={np.linalg.norm(a.Q(W)-th*W):.2e}"
        print(s)
