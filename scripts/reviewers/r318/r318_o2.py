"""O2: does 'Cartan leaves only so(p)+so(q) and u(m)' hold at n=8?
Build sp(1)+sp(2) c so(8) directly and test it as a Z_2-grading."""
import sys, os, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r318_lib as L, r318_spaces as S

# quaternions as 4x4 real matrices on basis 1,i,j,k
def Lq(q):
    a,b,c,d=q
    return np.array([[a,-b,-c,-d],[b,a,-d,c],[c,d,a,-b],[d,-c,b,a]],float)
def Rq(q):
    a,b,c,d=q
    return np.array([[a,-b,-c,-d],[b,a,d,-c],[c,-d,a,b],[d,c,-b,a]],float)
def conj(q): return np.array([q[0],-q[1],-q[2],-q[3]])

I4=np.eye(4); Z=np.zeros((4,4))
imag=[np.array([0,1,0,0.]),np.array([0,0,1,0.]),np.array([0,0,0,1.])]

gens=[]
# sp(1): right multiplication by an imaginary quaternion on both H-coordinates
for q in imag:
    M=np.zeros((8,8)); M[:4,:4]=Rq(q); M[4:,4:]=Rq(q); gens.append(M)
# sp(2): quaternionic anti-hermitian 2x2, acting by LEFT quaternion multiplication
for q in imag:
    M=np.zeros((8,8)); M[:4,:4]=Lq(q); gens.append(M)
    M=np.zeros((8,8)); M[4:,4:]=Lq(q); gens.append(M)
for q in [np.array([1,0,0,0.])]+imag:
    M=np.zeros((8,8)); M[:4,4:]=Lq(q); M[4:,:4]=-Lq(conj(q)); gens.append(M)

n=8
gens=[g for g in gens]
for g in gens:
    assert np.linalg.norm(g+g.T)<1e-12, 'not skew'
P=np.array([L.mat_to_vec(g,n) for g in gens]).T
Qp,_=np.linalg.qr(P)
rk=np.linalg.matrix_rank(P,1e-9)
pcols=np.linalg.svd(P)[0][:, :rk]
print(f'sp(1)+sp(2) inside so(8): dim = {rk}  (expected 13)')
# closure under bracket
c=L.C(n)
Pp=L.proj_from_cols(pcols); Pm=np.eye(28)-Pp
mm=np.linalg.svd(Pm)[0][:, :28-rk]
print(f'   [p,p] -> m leak = {L.bracket_leak(pcols,pcols,mm,n):.2e}')
print(f'   [p,m] -> p leak = {L.bracket_leak(pcols,mm,pcols,n):.2e}')
print(f'   [m,m] -> m leak = {L.bracket_leak(mm,mm,mm,n):.2e}   -> Z_2-GRADING of so(8)')
# irreducibility of R^8 under p  (so(3)+so(5) acts reducibly 3+5)
Msym=np.zeros((8*8,len(gens)))
for k,g in enumerate(gens): Msym[:,k]=g.ravel()
# commutant of p inside Sym(R^8): if 1-dim, R^8 is p-irreducible
rows=[]
for g in gens:
    B=np.zeros((36,64))
    idx=0
    for i in range(8):
        for j in range(i,8):
            E=np.zeros((8,8)); E[i,j]=1; E[j,i]=1
            B[idx]=(g@E-E@g).ravel(); idx+=1
    rows.append(B.T)
Mt=np.hstack(rows)
s=np.linalg.svd(Mt.T, compute_uv=False)
print(f'   dim of the p-commutant inside Sym^2(R^8) = {36-int((s>1e-9*s.max()).sum())}  '
      f'(1 => R^8 is p-irreducible; so(3)+so(5) would give 2)')

# the ad(p)-invariant Weyl tensor of this pair
wb=L.weyl_basis(n)
rows=[]
for k in range(pcols.shape[1]):
    A=L.ad_op(pcols[:,k],n)
    rows.append(np.array([(A@B-B@A).ravel() for B in wb]).T)
M=np.vstack(rows)
s=np.linalg.svd(M, compute_uv=False); rank=int((s>1e-8*s.max()).sum())
ns=np.linalg.svd(M)[2][rank:]
print(f'   dim of the ad(sp(1)+sp(2))-commutant inside Weyl_8 = {len(ns)}')
Wq=sum(cf*B for cf,B in zip(ns[0],wb)); Wq/=np.linalg.norm(Wq)
th,r=L.theta_of(Wq,n)
if th<0: Wq=-Wq; th,r=L.theta_of(Wq,n)
rep=L.grading_report(Wq,n)
print(f'   theta = {th:.9f}  crit resid = {r:.1e}  (S^3xS^5 = 1.115546702)')
print(f'   spectrum {sorted(collections.Counter(np.round(np.linalg.eigvalsh(Wq),6)).items())}')
print(f'   dim E+={rep["dim_p"]} dim E-={rep["dim_m"]} ker={rep["dim_ker"]} SIGN-GRADED={rep["sign_graded"]} Delta={L.defect(Wq,n):.2e}')
# Bianchi defect ||Alt(W_-)||^2
def alt_norm2(X,nn):
    tot=0.0
    for M2 in L.bianchi_rows(nn):
        tot+=float(np.sum(M2*X))**2
    return tot
w,Vv=np.linalg.eigh(Wq); Wm=Vv@np.diag(np.minimum(w,0))@Vv.T
Ws,_=S.sphere_prod_W(3,5); Ws/=np.linalg.norm(Ws)
w2,V2=np.linalg.eigh(Ws); Wm2=V2@np.diag(np.minimum(w2,0))@V2.T
print(f'   Bianchi defect ||Alt(W_-)||^2 proxy: this pair {alt_norm2(Wm,n):.6f}  vs S^3xS^5 {alt_norm2(Wm2,n):.2e}')
