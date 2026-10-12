"""r1843 check: reruns screen_I121_matching_feasible.py unchanged (same seed) and evaluates the FULL matching inequality E+sum x^2+1/4 sum s^2 <= t^2 - sum a_e^2 at the final frames. Does the matching family alone force large diagonal mass? From random frames of the balanced product, descent on O(n) minimises the worst matching violation max_M(V_M) - t^2 with a penalty holding t^2 below a cap; a value <= 0 is a frame satisfying every matching inequality. Built on r1816's construction. Run: sage -python screen_I121_matching_feasible.py 4,4 <cap>. A screen, local descent."""
"""r1816 screen: at the unit product Weyl tensor e of S^p x S^q in its own frame, the largest eigenvalue of L_e = Q(e,.) compressed to the subspace the maximal frame allows (B perp D, within-factor pair profiles zero, mixed pair profiles perp delta) versus c_*, and with only the orbit line removed. Run with sage -python."""
import numpy as np, itertools, sys
def run(p,q):
    n=p+q; P=list(range(p))
    pairs=list(itertools.combinations(range(n),2)); idx={pr:i for i,pr in enumerate(pairs)}; N=len(pairs)
    def mat(a,b):
        M=np.zeros((n,n)); M[a,b]=1; M[b,a]=-1; return M/np.sqrt(2)
    basis=[mat(a,b) for (a,b) in pairs]
    C=np.zeros((N,N,N))
    for i in range(N):
        for j in range(N):
            br=basis[i]@basis[j]-basis[j]@basis[i]
            for k in range(N): C[i,j,k]=np.sum(br*basis[k])
    def sharp(X,Y): return 0.5*np.einsum('ack,bdl,cd,kl->ab',C,C,X,Y,optimize=True)
    I=np.eye(N); scale=(n-2)/sharp(I,I)[0,0]
    def Qb(X,Y): return 0.5*(X@Y+Y@X)+scale*0.5*(sharp(X,Y)+sharp(Y,X))
    # W_n basis: symmetric N x N, Bianchi, Ricci-free
    def ent(R,a,b,c,d):
        s=1
        if a>b: a,b=b,a; s=-s
        if c>d: c,d=d,c; s=-s
        if a==b or c==d: return None
        return (s,idx[(a,b)],idx[(c,d)])
    sym=[]
    for i in range(N):
        for j in range(i,N):
            M=np.zeros((N,N)); M[i,j]=M[j,i]=1 if i!=j else 1; sym.append(M)
    cons=[]
    for a,b,c,d in itertools.combinations(range(n),4):
        row=np.zeros(len(sym))
        cons_ops=[(a,b,c,d),(b,c,a,d),(c,a,b,d)]
        # linear functional R -> R_abcd + R_bcad + R_cabd
        cons.append(cons_ops)
    def bianchi(R):
        out=[]
        for a,b,c,d in itertools.combinations(range(n),4):
            v=0
            for (x,y,z,w) in [(a,b,c,d),(b,c,a,d),(c,a,b,d)]:
                s,i,j=ent(R,x,y,z,w); v+=s*R[i,j]
            out.append(v)
        return out
    def ricci(R):
        out=[]
        for a in range(n):
            for b in range(a,n):
                v=0
                for k in range(n):
                    if k in (a,b): continue
                    s1=ent(R,a,k,b,k)
                    s,i,j=s1; v+=s*R[i,j]
                out.append(v)
        return out
    A=np.array([bianchi(M)+ricci(M) for M in sym]).T
    _,sv,vt=np.linalg.svd(A); rank=(sv>1e-9).sum(); null=vt[rank:]
    Wb=[sum(c*M for c,M in zip(v,sym)) for v in null]
    Wb=[M/np.linalg.norm(M) for M in Wb]
    G=np.array([M.ravel() for M in Wb]).T; Qo,_=np.linalg.qr(G)   # orthonormal basis of W_n in HS
    dimW=Qo.shape[1]; assert dimW==n*(n-3)*(n+1)*(n+2)//12, dimW
    # product e
    Nn=(n-1)*(n-2); al=q*(q-1)/Nn; be=-(p-1)*(q-1)/Nn; ga=p*(p-1)/Nn
    E=np.zeros((N,N))
    for (a,b),i in idx.items(): E[i,i]= al if (a in P and b in P) else (ga if (a not in P and b not in P) else be)
    e=E/np.linalg.norm(E); d=np.sum(Qb(e,e)*e)

    def ent2(W,a,b,c,d):
        s1=1
        if a>b: a,b=b,a; s1=-s1
        if c>d: c,d=d,c; s1=-s1
        return s1*W[idx[(a,b)],idx[(c,d)]]
    def matchings(lst):
        if not lst: yield []; return
        a=lst[0]
        for j in range(1,len(lst)):
            rest=lst[1:j]+lst[j+1:]
            for m in matchings(rest): yield [(a,lst[j])]+m
    allM=list(matchings(list(range(n))))
    def rot_op(g):
        Lg=np.zeros((N,N))
        for (a,b),col in idx.items():
            for (p_,q_),row in idx.items():
                Lg[row,col]=g[p_,a]*g[q_,b]-g[q_,a]*g[p_,b]
        return Lg
    def visible_total(W):
        best=0
        for Mt in allM:
            V=0.0
            for x in range(len(Mt)):
                for y in range(x+1,len(Mt)):
                    (i_,j_),(k_,l_)=Mt[x],Mt[y]
                    V+=(ent2(W,i_,k_,j_,l_)+ent2(W,i_,l_,j_,k_))**2
                    V+=(ent2(W,i_,k_,j_,k_)+ent2(W,i_,l_,j_,l_))**2   # x^e_k + x^e_l, e={i,j}
                    V+=(ent2(W,k_,i_,l_,i_)+ent2(W,k_,j_,l_,j_))**2   # x^f_i + x^f_j, f={k,l}
            best=max(best,V)
        return best
    import scipy.linalg as sla
    pairs_M=[]
    for Mt in allM:
        pl=[]
        for x in range(len(Mt)):
            for y in range(x+1,len(Mt)):
                pl.append((Mt[x],Mt[y]))
        pairs_M.append(pl)
    def shares(W):
        t2=sum(W[i_,i_]**2 for i_ in range(N)); off=1-t2; out=[]
        for pl in pairs_M:
            V=0.0
            for (i_,j_),(k_,l_) in pl:
                V+=(ent2(W,i_,k_,j_,l_)+ent2(W,i_,l_,j_,k_))**2+(ent2(W,i_,k_,j_,k_)+ent2(W,i_,l_,j_,l_))**2+(ent2(W,k_,i_,l_,i_)+ent2(W,k_,j_,l_,j_))**2
            out.append(V/off)
        return np.array(out), t2
    def viol(g,tau=60.0,cap=CAP,lam=40.0):
        W=rot_op(g)@e@rot_op(g).T
        sh,t2=shares(W); V=sh*(1-t2)-t2          # V_M - t^2 for each matching
        m=V.max(); soft_=m+np.log(np.sum(np.exp(tau*(V-m))))/tau
        return soft_+lam*max(0.0,t2-cap)**2
    soft=viol
    gens=[]
    for a_ in range(n):
        for b_ in range(a_+1,n):
            X=np.zeros((n,n)); X[a_,b_]=1; X[b_,a_]=-1; gens.append(X)
    rng=np.random.default_rng(9)
    for st in range(3):
        g,_=np.linalg.qr(rng.standard_normal((n,n)))
        h=1e-4; lr=0.3
        for it in range(80):
            f0=soft(g); grad=np.array([(soft(sla.expm(h*X)@g)-f0)/h for X in gens])
            step=-lr*sum(c*X for c,X in zip(grad,gens))
            g=sla.expm(step)@g
        sh,t2=shares(rot_op(g)@e@rot_op(g).T)
        Wf=rot_op(g)@e@rot_op(g).T
        full=[]
        for Mt,pl in zip(allM,pairs_M):
            L=0.0
            for (i_,j_),(k_,l_) in pl:
                L+=(ent2(Wf,i_,k_,j_,l_)+ent2(Wf,i_,l_,j_,k_))**2+(ent2(Wf,i_,k_,j_,k_)+ent2(Wf,i_,l_,j_,l_))**2+(ent2(Wf,k_,i_,l_,i_)+ent2(Wf,k_,j_,l_,j_))**2
                s=ent2(Wf,i_,k_,i_,k_)+ent2(Wf,i_,l_,i_,l_)+ent2(Wf,j_,k_,j_,k_)+ent2(Wf,j_,l_,j_,l_)
                L+=0.25*s*s
            R=t2-sum(ent2(Wf,a_,b_,a_,b_)**2 for (a_,b_) in Mt)
            full.append(L-R)
        full=np.array(full)
        print(f"n={n} start {st}: t^2={t2:.4f}  relaxed max_M(V_M)-t^2 = {(sh*(1-t2)).max()-t2:.4f}  FULL max_M(LHS-RHS) = {full.max():.4f}  #violated full = {(full>1e-9).sum()}/105", flush=True)

import sys
CAP=float(sys.argv[2])
p,q=map(int,sys.argv[1].split(',')); run(p,q)
