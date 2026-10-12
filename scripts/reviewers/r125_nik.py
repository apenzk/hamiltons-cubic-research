import numpy as np
from r125_lib import to_tensor, weyl_basis
print("===== N_ik AUDIT:  N_ik = sum_{mpq} W_impq W_kmpq =?= |W|^2 I / n =====")
for n in (4,5,6,7):
    b,pr,pos,N,c=weyl_basis(n)
    rng=np.random.default_rng(11)
    devs=[];rat=[]
    for _ in range(5):
        co=rng.standard_normal(len(b)); M=np.einsum('k,kab->ab',co,b); M/=np.linalg.norm(M)
        W=to_tensor(M,pos,n)
        Nik=np.einsum('impq,kmpq->ik',W,W)
        n2=np.sum(W**2)
        devs.append(np.linalg.norm(Nik-n2/n*np.eye(n))/np.linalg.norm(Nik))
        rat.append(np.trace(Nik)/n2)
    print(f" n={n}: dim Weyl={len(b)}  max rel dev from |W|^2 I/n = {max(devs):.3e}   tr(N)/|W|^2 = {np.mean(rat):.8f}   |W|_tensor^2 (||W||_F=1) = {n2:.6f}")
