"""The product in frames that pass the pi/4 matching family (direct rotation over all matching and orientation patterns, cap 0.2, seed 9, n = 8): t^2, |grad t^2| over so(8), pair and four-set mass, and the split P(B_f) = (3/2) tr(B_f^3) + 24 sum_R XXX. A screen (reviews/2026-09-28d-I121-smallmass-direct.md). Run: sage -python screen_I121_matching_frame_split.py 4,4"""
"""r1816 screen: at the unit product Weyl tensor e of S^p x S^q in its own frame, the largest eigenvalue of L_e = Q(e,.) compressed to the subspace the maximal frame allows (B perp D, within-factor pair profiles zero, mixed pair profiles perp delta) versus c_*, and with only the orbit line removed. Run with sage -python."""
import numpy as np, itertools, sys
import scipy.linalg as sla
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
    import itertools as it_
    def t2of(W): return float(sum(W[i_,i_]**2 for i_ in range(N)))
    def gM(Mt,signs):
        g=np.eye(n); c=np.cos(np.pi/4)
        for (a,b),sg in zip(Mt,signs):
            g[a,a]=c; g[b,b]=c; g[a,b]=-sg*c; g[b,a]=sg*c
        return g
    rots=[rot_op(gM(Mt,(1,)+sg)) for Mt in allM for sg in it_.product((1,-1),repeat=len(allM[0])-1)]
    def direct(W):
        t0=t2of(W); return np.array([t2of(L@W@L.T) for L in rots])-t0, t0
    def viol_relaxed(g,tau=60.0,cap=None,lam=40.0):
        W=rot_op(g)@e@rot_op(g).T
        sh,t2=shares(W); V=sh*(1-t2)-t2
        m=V.max(); return m+np.log(np.sum(np.exp(tau*(V-m))))/tau+lam*max(0.0,t2-cap)**2
    def viol_direct(g,tau=60.0,cap=None,lam=40.0):
        W=rot_op(g)@e@rot_op(g).T
        D,t2=direct(W); m=D.max()
        return m+np.log(np.sum(np.exp(tau*(D-m))))/tau+lam*max(0.0,t2-cap)**2
    gens=[]
    for a_ in range(n):
        for b_ in range(a_+1,n):
            X=np.zeros((n,n)); X[a_,b_]=1; X[b_,a_]=-1; gens.append(X)
    def descend(fun,cap,seed):
        rng=np.random.default_rng(seed); out=[]
        for st in range(3):
            g,_=np.linalg.qr(rng.standard_normal((n,n)))
            h=1e-4; lr=0.3
            for it in range(80):
                f0=fun(g,cap=cap); grad=np.array([(fun(sla.expm(h*X)@g,cap=cap)-f0)/h for X in gens])
                g=sla.expm(-lr*sum(c*X for c,X in zip(grad,gens)))@g
            out.append(g)
        return out
    import itertools as it2
    def JXe(W,e,f):
        (i,j),(k,l)=e,f
        return ent2(W,i,j,k,l), 0.5*(ent2(W,i,k,j,l)+ent2(W,i,l,j,k))
    def split(W):
        diag=np.diag(np.diag(W)); Bf=np.zeros_like(W); Bp=np.zeros_like(W)
        for (a,b),r in idx.items():
            for (c,d),s in idx.items():
                if r==s: continue
                if len({a,b,c,d})==4: Bf[r,s]=W[r,s]
                else: Bp[r,s]=W[r,s]
        return diag,Bp,Bf
    def xsum(W):
        tot=0
        for S in it2.combinations(range(n),6):
            a=S[0]; rest=list(S[1:])
            for b in rest:
                r2=[x for x in rest if x!=b]; c=r2[0]
                for d in r2[1:]:
                    r3=[x for x in r2 if x not in (c,d)]
                    E=[tuple(sorted((a,b))),tuple(sorted((c,d))),tuple(r3)]
                    X=[JXe(W,E[0],E[1])[1],JXe(W,E[0],E[2])[1],JXe(W,E[1],E[2])[1]]
                    tot+=X[0]*X[1]*X[2]
        return tot
    def grad_t2(W):
        g=[]
        for X in gens:
            L=rot_op(sla.expm(1e-5*X)); Wp=L@W@L.T; L=rot_op(sla.expm(-1e-5*X)); Wm=L@W@L.T
            g.append((t2of(Wp)-t2of(Wm))/2e-5)
        return np.array(g)
    for st,g in enumerate(descend(viol_direct,0.2,9)):
        W=rot_op(g)@e@rot_op(g).T; D,t2=direct(W)
        A,Bp,Bf=split(W)
        PW=np.sum(Qb(W,W)*W); PBf=np.sum(Qb(Bf,Bf)*Bf); tr3=np.trace(Bf@Bf@Bf); xs=xsum(W)
        gr=grad_t2(W)
        print(f"start {st}: t^2={t2:.4f} direct max={D.max():+.4f} |grad t^2|={np.linalg.norm(gr):.4f}  pair mass={np.sum(Bp*Bp):.4f} four-set mass={np.sum(Bf*Bf):.4f}",flush=True)
        print(f"   P(W)={PW:.6f} (theta_0(8)=1.145644)  P(B_f)={PBf:.6f} = 1.5 tr(B_f^3) {1.5*tr3:.6f} + 24 sum XXX {24*xs:.6f}",flush=True)

p,q=map(int,sys.argv[1].split(',')); run(p,q)
