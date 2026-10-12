# I73 (c): the largest lambda_max of sum_{alpha in S} alpha alpha^T over q-subsets S of the thirty roots e_i -+ e_j of D6,
# the largest sum of q of the thirty angle values at a unit vector. q = 6: (7+sqrt41)/2, q = 7: 4+2sqrt3. /usr/bin/python3, a few minutes.
import itertools, numpy as np
E=list(itertools.combinations(range(6),2)); R=[]
for i,j in E:
    for sg in (-1,1):
        v=np.zeros(6); v[i]=1; v[j]=sg; R.append(np.outer(v,v))
R=np.array(R)
for q in (6,7):
    mx=0; batch=[]
    for S in itertools.combinations(range(30),q):
        batch.append(R[list(S)].sum(0))
        if len(batch)==300000:
            mx=max(mx,np.linalg.eigvalsh(np.array(batch))[:,-1].max()); batch=[]
    if batch: mx=max(mx,np.linalg.eigvalsh(np.array(batch))[:,-1].max())
    print(q,'max lambda_max =',mx,' 4+2sqrt3 =',4+2*np.sqrt(3))
