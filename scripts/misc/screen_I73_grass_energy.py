# Max over orthonormal 6-frames Y_1..Y_6 in p = plane1 (x) R^{n-2} of sum_{j!=k} |[Y_j,Y_k]|^2,
# norm <X,Y> = -1/2 tr XY. Riemannian-ish ascent with random restarts.
import numpy as np
rng=np.random.default_rng(0)
def embed(M,n):
    Y=np.zeros((n,n)); Y[:2,2:]=-M; Y[2:,:2]=M.T; return Y
def energy(Ms,n):
    Ys=[embed(M,n) for M in Ms]; t=0
    for j in range(6):
        for k in range(6):
            if j!=k:
                C=Ys[j]@Ys[k]-Ys[k]@Ys[j]; t+=-0.5*np.trace(C@C)
    return t
def run(n,restarts=30,steps=1500):
    d=2*(n-2); best=0
    for r in range(restarts):
        Z=np.linalg.qr(rng.normal(size=(d,6)))[0]
        lr=0.05
        def E(Z): return energy([Z[:,a].reshape(2,n-2) for a in range(6)],n)
        e=E(Z)
        for s in range(steps):
            G=rng.normal(size=(d,6))*0.05
            Z2=np.linalg.qr(Z+lr*G)[0]; e2=E(Z2)
            if e2>e: Z,e=Z2,e2
        best=max(best,e)
    return best
for n in (6,8,10):
    print(n, round(run(n),4))
