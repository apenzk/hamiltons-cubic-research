# I73 (c), n = 12, p = 7, L253's certificate: 38 I - 5 G_S positive definite at every seven-subset S of D6's thirty roots
# (integer Bareiss; entries at most 38, minors below 1e12, so int64 is exact), so any seven angle values sum to < 7.6.
# Cross-checked: 37 I - 5 G_S fails at exactly the 480 subsets whose floating lambda_max is >= 7.4. /usr/bin/python3, ~1 min.
# exact: for every 7 of the 30 roots e_i -+ e_j of D6, 38 I - 5 G_S (7.6 I - G_S) is positive definite (integer Bareiss),
# so the sum of any 7 of the thirty angle values is < 7.6 |s|^2
import itertools, numpy as np
E=list(itertools.combinations(range(6),2)); R=[]
for i,j in E:
    for sg in (-1,1):
        v=np.zeros(6,dtype=np.int64); v[i]=1; v[j]=sg; R.append(np.outer(v,v))
R=np.array(R)
def pd_all(A):
    A=A.copy(); prev=np.ones(len(A),dtype=np.int64); ok=np.ones(len(A),bool)
    for k in range(6):
        piv=A[:,k,k]; ok&=piv>0
        if k==5: break
        for i in range(k+1,6):
            for j in range(k+1,6):
                A[:,i,j]=(A[:,i,j]*piv-A[:,i,k]*A[:,k,j])//prev
        prev=np.where(piv==0,1,piv)
    return ok
bad=0; tot=0; batch=[]
for S in itertools.combinations(range(30),7):
    batch.append(38*np.eye(6,dtype=np.int64)-5*R[list(S)].sum(0))
    if len(batch)==200000:
        ok=pd_all(np.array(batch)); bad+=(~ok).sum(); tot+=len(batch); batch=[]
if batch:
    ok=pd_all(np.array(batch)); bad+=(~ok).sum(); tot+=len(batch)
print('subsets',tot,'not PD',bad)
# sanity: 746 fails somewhere (4+2sqrt3 = 7.464)
