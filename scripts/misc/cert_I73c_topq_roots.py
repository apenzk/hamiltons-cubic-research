# I73 (c), n = 12: exact certificates T*_q < t for the largest sum of q of the thirty root values (e_i -+ e_j, D6):
# num*I - den*G_S positive definite at every q-subset S (integer Bareiss; the leading minors are exact in int64 when
# entries stay below ~200). Usage: /usr/bin/python3 <this> q num den    (checks T*_q < num/den)
import sys, itertools, numpy as np
q, num, den = int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3])
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
for S in itertools.combinations(range(30),q):
    batch.append(S)
    if len(batch)==400000:
        G=R[np.array(batch)].sum(1); ok=pd_all(num*np.eye(6,dtype=np.int64)-den*G); bad+=(~ok).sum(); tot+=len(batch); batch=[]
if batch:
    G=R[np.array(batch)].sum(1); ok=pd_all(num*np.eye(6,dtype=np.int64)-den*G); bad+=(~ok).sum(); tot+=len(batch)
print(f'q={q} T*_q < {num}/{den}: subsets {tot}, not PD {bad}', 'CERTIFIED' if bad==0 else 'FAILED')
