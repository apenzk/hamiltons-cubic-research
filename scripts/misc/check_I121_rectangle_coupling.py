"""Check for the visibility route: at n=6, the trilinear coupling T on the three four-set blocks of a rectangle triple Q1={0,1,2,3}, Q2={0,1,4,5}, Q3={2,3,4,5}, and whether it vanishes when one block lies in the kernel of the combination the matching {01,23,45} sees. It does not (0.289 against 0.577). Built on r1816's construction. Run: sage -python check_I121_rectangle_coupling.py 3,3"""
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

    def ent2(W,a,b,c,d):
        s1=1
        if a>b: a,b=b,a; s1=-s1
        if c>d: c,d=d,c; s1=-s1
        return s1*W[idx[(a,b)],idx[(c,d)]]
    def block_basis(Q):
        # W_n elements supported on the four-set block of Q (character chi_Q): project entries with index set Q
        rows=[]
        for (a,b),i1 in idx.items():
            for (c,d_),j1 in idx.items():
                if i1<=j1 and not (set((a,b,c,d_))==set(Q) and len({a,b,c,d_})==4):
                    M=np.zeros((N,N)); M[i1,j1]+=1; M[j1,i1]+=1; rows.append(Qo.T@M.ravel())
        Cm=np.array(rows); _,sv,vt=np.linalg.svd(Cm); rk=(sv>1e-9).sum(); S=vt[rk:].T
        return [(Qo@S[:,k]).reshape(N,N) for k in range(S.shape[1])]
    Q1=(0,1,2,3); Q2=(0,1,4,5); Q3=(2,3,4,5)
    B1=block_basis(Q1); B2=block_basis(Q2); B3=block_basis(Q3)
    print("block dims", len(B1),len(B2),len(B3))
    # visible combination of matching mu={01,23,45}: for Q1 pairing (01|23): W(0 2,1 3)+W(0 3,1 2)
    combo=lambda W,i_,j_,k_,l_: ent2(W,i_,k_,j_,l_)+ent2(W,i_,l_,j_,k_)
    c1=[combo(X,0,1,2,3) for X in B1]; c2=[combo(X,0,1,4,5) for X in B2]; c3=[combo(X,2,3,4,5) for X in B3]
    T=np.zeros((2,2,2))
    for a in range(2):
        for b in range(2):
            for c in range(2):
                T[a,b,c]=np.sum(Qb(B1[a],B2[b])*B3[c])
    # kernel directions of each combo
    def kern(cv): v=np.array([cv[1],-cv[0]]); return v/np.linalg.norm(v)
    k1,k2,k3=kern(c1),kern(c2),kern(c3)
    print("T(ker1,.,.) norm", np.linalg.norm(np.einsum('a,abc->bc',k1,T)))
    print("T(.,ker2,.) norm", np.linalg.norm(np.einsum('b,abc->ac',k2,T)))
    print("T(.,.,ker3) norm", np.linalg.norm(np.einsum('c,abc->ab',k3,T)))
    print("T overall norm", np.linalg.norm(T))

import sys
for a_ in sys.argv[1:]:
    p,q=map(int,a_.split(',')); run(p,q)
