"""Do kernels arise in the BROAD reading of 'symmetric pair' (isotropy of a symmetric
space M^n inside so(n)) at n >= 12?  Test Gr_C(2,3) and HP^3, both n=12."""
import sys, os, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r318_lib as L, r318_spaces as S

def realify(M):
    """C-linear map on C^k -> R-linear on R^{2k}, basis (re_1,im_1,...)."""
    k=M.shape[0]; out=np.zeros((2*k,2*k))
    out[0::2,0::2]=M.real; out[0::2,1::2]=-M.imag
    out[1::2,0::2]=M.imag; out[1::2,1::2]=M.real
    return out

def solve(projs, n, fix=None):
    rws=[];tgt=[]
    for M in L.ricci_rows(n): rws.append([float(np.sum(M*Pi)) for Pi in projs])
    for j in range(n):
        for l in range(j,n): tgt.append(0.5 if j==l else 0.0)
    for M in L.bianchi_rows(n):
        rws.append([float(np.sum(M*Pi)) for Pi in projs]); tgt.append(0.0)
    if fix:
        for (i,v) in fix:
            r=[0.0]*len(projs); r[i]=1.0; rws.append(r); tgt.append(v)
    A=np.array(rws); t=np.array(tgt); lam,res_,*_=np.linalg.lstsq(A,t,rcond=None)[:2]
    return sum(l*Pi for l,Pi in zip(lam,projs)), lam, float(np.linalg.norm(A@lam-t))

def su(k):
    G=[]
    for a in range(k):
        for b in range(a+1,k):
            E=np.zeros((k,k),complex); E[a,b]=1; E[b,a]=-1; G.append(E)
            E=np.zeros((k,k),complex); E[a,b]=1j; E[b,a]=1j; G.append(E)
    for a in range(k-1):
        D=np.zeros((k,k),complex); D[a,a]=1j; D[a+1,a+1]=-1j; G.append(D)
    return G

# ---- Gr_C(2,3): m = Hom(C^2,C^3) = C^6, h = u(1)+su(2)+su(3) ----
n=12
def op_on_hom(B, A):
    """Z -> B Z - Z A on 3x2 complex matrices, as a complex 6x6 on vec(Z)."""
    return np.kron(np.eye(2), B) - np.kron(A.T, np.eye(3))
blocks=[]
cen=[realify(op_on_hom(np.zeros((3,3),complex), -5j/5*np.eye(2)))]   # scalar i on C^6
b2=[realify(op_on_hom(np.zeros((3,3),complex), A)) for A in su(2)]
b3=[realify(op_on_hom(B, np.zeros((2,2),complex))) for B in su(3)]
def blockproj(gens, n):
    V=np.array([L.mat_to_vec(g,n) for g in gens]).T
    u,s,vt=np.linalg.svd(V, full_matrices=False)
    cols=u[:, s>1e-9*s.max()]
    return cols@cols.T, cols.shape[1]
Pc,d0=blockproj(cen,n); P2,d2=blockproj(b2,n); P3,d3=blockproj(b3,n)
print(f'Gr_C(2,3) n=12: isotropy block dims (u(1),su(2),su(3)) = ({d0},{d2},{d3})')
Prest=np.eye(66)-Pc-P2-P3
R,lam,res=solve([Pc,P2,P3,Prest],n,fix=[(3,0.0)])
W=L.weyl_of(R,n); Wn=W/np.linalg.norm(W)
th,r=L.theta_of(Wn,n)
print(f'   lambdas={np.round(lam,8)}  c=1/(2(n-1))={1/(2*(n-1)):.8f}  sysres={res:.1e}')
print(f'   weylres={[f"{x:.1e}" for x in L.weyl_residual(Wn,n)]}  theta={th:.9f} (record: 0.596068081) crit={r:.1e}')
print(f'   W spectrum {sorted(collections.Counter(np.round(np.linalg.eigvalsh(Wn),8)).items())}')
rep=L.grading_report(Wn,n); print(f'   dim ker = {rep["dim_ker"]}')

# ---- HP^3: m = H^3, h = sp(1)+sp(3) ----
def Lq(q):
    a,b,c,d=q; return np.array([[a,-b,-c,-d],[b,a,-d,c],[c,d,a,-b],[d,-c,b,a]],float)
def Rq(q):
    a,b,c,d=q; return np.array([[a,-b,-c,-d],[b,a,d,-c],[c,-d,a,b],[d,c,-b,a]],float)
imag=[np.array([0,1,0,0.]),np.array([0,0,1,0.]),np.array([0,0,0,1.])]
one=np.array([1,0,0,0.])
def conj(q): return np.array([q[0],-q[1],-q[2],-q[3]])
m3=3; n=12
sp1=[]
for q in imag:
    M=np.zeros((12,12))
    for k in range(m3): M[4*k:4*k+4,4*k:4*k+4]=Rq(q)
    sp1.append(M)
sp3=[]
for k in range(m3):
    for q in imag:
        M=np.zeros((12,12)); M[4*k:4*k+4,4*k:4*k+4]=Lq(q); sp3.append(M)
for a in range(m3):
    for b in range(a+1,m3):
        for q in [one]+imag:
            M=np.zeros((12,12)); M[4*a:4*a+4,4*b:4*b+4]=Lq(q); M[4*b:4*b+4,4*a:4*a+4]=-Lq(conj(q)); sp3.append(M)
Pa,da=blockproj(sp1,12); Pb,db=blockproj(sp3,12)
print(f'\nHP^3 n=12: isotropy block dims (sp(1),sp(3)) = ({da},{db})  expected (3,21)')
Prest=np.eye(66)-Pa-Pb
R,lam,res=solve([Pa,Pb,Prest],12,fix=[(2,0.0)])
W=L.weyl_of(R,12); Wn=W/np.linalg.norm(W)
th,r=L.theta_of(Wn,12)
if th<0: Wn=-Wn; th,r=L.theta_of(Wn,12)
print(f'   lambdas={np.round(lam,8)} c={1/(2*11):.8f} sysres={res:.1e}')
print(f'   weylres={[f"{x:.1e}" for x in L.weyl_residual(Wn,12)]} theta={th:.9f} (record: 0.852943860) crit={r:.1e}')
print(f'   W spectrum {sorted(collections.Counter(np.round(np.linalg.eigvalsh(Wn),8)).items())}')
print(f'   dim ker = {L.grading_report(Wn,12)["dim_ker"]}')
