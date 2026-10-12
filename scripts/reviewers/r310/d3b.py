import sys, os, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib310 as L
from census import V_basis, M_of, find

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

def comps(M, tol=1e-11):
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

def ds(Ms, pad=0):
    ths=[L.P(L.W_from_M(m)) for m in Ms]
    th=1.0/np.sqrt(sum(1.0/t**2 for t in ths))
    n=sum(m.shape[0] for m in Ms)+pad; M=np.zeros((n,n)); o=0; lab=-np.ones(n,dtype=int)
    for i,m in enumerate(Ms):
        k=m.shape[0]; M[o:o+k,o:o+k]=(th/ths[i])*m; lab[o:o+k]=i; o+=k
    return M, np.array(ths), th, lab

print("=== D3 (repaired statement) : >=2 components CARRYING AN EDGE ===")
cases=[("S3xS3 + S4xS4 + 1 isolated",[sp(3,3),sp(4,4)],1),
       ("S3xS3 + S3xS3 + 2 isolated",[sp(3,3),sp(3,3)],2),
       ("S2xS4 + S3xS3 + 3 isolated",[sp(2,4),sp(3,3)],3),
       ("S3xS3 + S3xS5",[sp(3,3),sp(3,5)],0),
       ("S3xS3 + S4xS4 + S3xS3",[sp(3,3),sp(4,4),sp(3,3)],0),
       ("padCP2-free: S2xS3 + S2xS3 + 1 iso",[sp(2,3),sp(2,3)],1)]
for tag,Ms,pad in cases:
    M,ths,th,lab=ds(Ms,pad); n=M.shape[0]
    W=L.W_from_M(M); thc=L.P(W)
    k,lb=comps(M)
    edgec=sum(1 for c in range(k) if np.abs(M[lb==c][:,lb==c]).max()>1e-11)
    kr=n-np.linalg.matrix_rank(M,tol=1e-11)
    dl,_=L.diag_L_eigs(M)
    print(f" {tag}: n={n} theta={thc:.9f} crit={np.abs(L.Q(W)-thc*W).max():.1e} "
          f"#comp={k} #comp-with-edge={edgec} dim ker M={kr} Delta={L.defect_diag(M):.4f} "
          f"diag lam_max(L_e)={dl[-1]/thc:.9f}  >=1? {dl[-1]/thc >= 1-1e-9}")

print()
print("=== cos(N,M) under the WEAK condition sum a_c = 0, with disparate theta_c ===")
lowM = find(7, 3)          # a low-theta n=7 diagonal critical point
lowth = L.P(L.W_from_M(lowM))
print(f" low-theta component: n=7 theta={lowth:.6f}")
for partner,name in [(sp(3,3),'S3xS3'),(sp(4,4),'S4xS4'),(sp(5,5),'S5xS5')]:
    M,ths,th,lab=ds([lowM,partner])
    a=np.array([1.0,-1.0])
    N=np.zeros_like(M)
    for c in range(2):
        idx=np.where(lab==c)[0]; N[np.ix_(idx,idx)]=a[c]*M[np.ix_(idx,idx)]
    cs=0.5*np.sum(N*M)/(np.sqrt(0.5*np.sum(N**2))*np.sqrt(0.5*np.sum(M**2)))
    pred=th**2*(1/ths[0]**2-1/ths[1]**2)
    print(f"  low + {name}: thetas={np.round(ths,6)} theta={th:.6f}  cos(N,M)={cs:+.6f} (closed form {pred:+.6f})")

print()
print("=== dim ker M vs #connected components over my census + blow-ups ===")
bad=[]; tot=0
import glob
for f in sorted(glob.glob('scripts/reviewers/r310/census_n*.npy')):
    n=int(f.split('_n')[1].split('.')[0])
    arr=np.load(f)
    for M in arr:
        tot+=1
        k,_=comps(M); kr=M.shape[0]-np.linalg.matrix_rank(M,tol=1e-10)
        if k!=kr: bad.append((n,k,kr,M))
print(f" checked {tot} diagonal critical points; mismatches dim ker != #components: {len(bad)}")
for (n,k,kr,M) in bad[:6]:
    W=L.W_from_M(M); th=L.P(W); dl,_=L.diag_L_eigs(M)
    print(f"   n={n} #comp={k} dim ker={kr} theta={th:.6f} Delta={L.defect_diag(M):.4f} diag lam_e={dl[-1]/th:.6f}")
