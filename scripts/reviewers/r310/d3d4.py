import sys, os, numpy as np, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib310 as L

def sp(p,q,pad=0):
    n=p+q+pad; M=np.zeros((n,n))
    for a in range(p):
        for b in range(p):
            if a!=b: M[a,b]=1.0/(p*(p-1))
    for a in range(p,p+q):
        for b in range(p,p+q):
            if a!=b: M[a,b]=1.0/(q*(q-1))
    for a in range(p):
        for b in range(p,p+q): M[a,b]=M[b,a]=-1.0/(p*q)
    W=L.W_from_M(M); W/=np.sqrt(L.ip(W,W)); return L.M_from_W(W)

def comps(M, tol=1e-12):
    n=M.shape[0]; seen=[-1]*n; c=0
    for a in range(n):
        if seen[a]>=0: continue
        st=[a]; seen[a]=c
        while st:
            x=st.pop()
            for y in range(n):
                if abs(M[x,y])>tol and seen[y]<0: seen[y]=c; st.append(y)
        c+=1
    return c, np.array(seen)

print("=== D3: padded points ===")
for (p,q,pad) in [(4,4,1),(3,3,1),(3,4,1),(4,4,2),(5,5,1)]:
    M=sp(p,q,pad); n=M.shape[0]; W=L.W_from_M(M); th=L.P(W)
    k,lab=comps(M)
    kr=n-np.linalg.matrix_rank(M,tol=1e-12)
    dl,_=L.diag_L_eigs(M); full=(L.lam_max_perp(W,n)[0] if n<=10 else float("nan"))
    # component indicator N: a_c constant on each component, N = sum a_c * (block of M)
    ncomp_edge=sum(1 for c in range(k) if np.abs(M[lab==c][:,lab==c]).max()>1e-12)
    print(f"S^{p}xS^{q} pad {pad}: n={n} theta={th:.9f} #components={k} (carrying an edge: {ncomp_edge}) dim ker M={kr}"
          f"  Delta={L.defect_diag(M):.6f}  diag lam_e={dl[-1]/th:.6f} full lam_e={full/th:.6f}")
    # the record's N: a constant on components, sum a = 0
    a=np.zeros(k); a[0]=1.0; a[1:]=-1.0/(k-1)
    N=np.zeros_like(M)
    for c in range(k):
        idx=np.where(lab==c)[0]; N[np.ix_(idx,idx)]=a[c]*M[np.ix_(idx,idx)]
    nn=np.sqrt(0.5*np.sum(N**2))
    if nn>1e-14:
        cos=0.5*np.sum(N*M)/(nn*np.sqrt(0.5*np.sum(M**2)))
        LN=N*M+(M@N+N@M)/2; np.fill_diagonal(LN,0)
        print(f"      indicator N (sum a=0): cos(N,M)={cos:+.6f}  ||L N - theta N||={np.abs(LN-th*N).max():.2e}  rowsum(N)={np.abs(N.sum(1)).max():.1e}")
    else:
        print(f"      indicator N (sum a=0): N IS ZERO  (the padded component carries no edge)")

print()
print("=== D4: <N,M> for genuine direct sums of diagonal critical points ===")
def directsum(Ms):
    ths=[L.P(L.W_from_M(m)) for m in Ms]
    th=1.0/np.sqrt(sum(1.0/t**2 for t in ths))
    n=sum(m.shape[0] for m in Ms); M=np.zeros((n,n)); o=0; lab=np.zeros(n,dtype=int)
    for i,m in enumerate(Ms):
        k=m.shape[0]; M[o:o+k,o:o+k]=(th/ths[i])*m; lab[o:o+k]=i; o+=k
    return M, np.array(ths), th, lab
tests=[[sp(3,3),sp(4,4)],[sp(3,3),sp(3,5)],[sp(4,4),sp(5,5)],[sp(3,3),sp(3,3),sp(4,4)]]
rng=np.random.default_rng(4)
for Ms in tests:
    M,ths,th,lab=directsum(Ms); n=M.shape[0]; W=L.W_from_M(M)
    print(f" n={n} thetas={np.round(ths,6)} theta={th:.9f} predicted={1/np.sqrt(sum(1/t**2 for t in ths)):.9f}"
          f" norm={L.ip(W,W):.12f} crit={np.abs(L.Q(W)-L.P(W)*W).max():.2e}")
    k=len(ths)
    for trial in range(3):
        a=rng.normal(size=k)
        N=np.zeros_like(M)
        for c in range(k):
            idx=np.where(lab==c)[0]; N[np.ix_(idx,idx)]=a[c]*M[np.ix_(idx,idx)]
        ipL=0.5*np.sum(N*M); ipF=np.sum(N*M)
        S=sum(a[c]/ths[c]**2 for c in range(k))
        print(f"    a={np.round(a,4)}  <N,M>_Lambda2={ipL:.9f}  /theta^2 S = {ipL/(th**2*S):.9f}"
              f"   <N,M>_Frob={ipF:.9f} /theta^2 S = {ipF/(th**2*S):.9f}   S={S:.6f}")
    # admissibility test: sum a = 0 vs sum a/theta^2 = 0
    cosmax=0; worst=None
    for trial in range(2000):
        a=rng.normal(size=k); a=a-a.mean()
        N=np.zeros_like(M)
        for c in range(k):
            idx=np.where(lab==c)[0]; N[np.ix_(idx,idx)]=a[c]*M[np.ix_(idx,idx)]
        nn=np.sqrt(0.5*np.sum(N**2))
        if nn<1e-12: continue
        cs=abs(0.5*np.sum(N*M)/(nn*np.sqrt(0.5*np.sum(M**2))))
        if cs>cosmax: cosmax=cs; worst=a
    print(f"    max |cos(N,M)| over 2000 draws with sum a = 0 : {cosmax:.6f}")
    # correct admissibility
    a=np.array([ths[c]**2 for c in range(k)]); a=a*rng.normal(size=k)  # generic then project
    a=a-(sum(a[c]/ths[c]**2 for c in range(k))/sum(1/t**2 for t in ths))*np.ones(k)
    N=np.zeros_like(M)
    for c in range(k):
        idx=np.where(lab==c)[0]; N[np.ix_(idx,idx)]=a[c]*M[np.ix_(idx,idx)]
    nn=np.sqrt(0.5*np.sum(N**2))
    LN=N*M+(M@N+N@M)/2; np.fill_diagonal(LN,0)
    print(f"    repaired a (sum a/theta_c^2=0): cos(N,M)={0.5*np.sum(N*M)/(nn*np.sqrt(0.5*np.sum(M**2))):.2e}"
          f"  ||LN-theta N||={np.abs(LN-th*N).max():.2e}  rowsum={np.abs(N.sum(1)).max():.1e}")
    dl,_=L.diag_L_eigs(M); full=(L.lam_max_perp(W,n)[0] if n<=10 else float("nan"))
    print(f"    diag lam_max(L_e)={dl[-1]/th:.9f}  full lam_max(L_e)={full/th:.9f}")
