# I73: Cauchy-Schwarz gives M(V) <= 2 sqrt(d) ||Pi#Pi||_F (equality on subalgebras), so the internal-mass cap follows from
# the projection-free quartic bound  ||Pi#Pi||_F <= (n-2) d / sqrt(N)  for every rank-d projector Pi onto V in so(n).
# Screen (refutation instrument): gradient ascent of ||Pi#Pi||_F^2 / d^2 over the Grassmannian, ratio r = ||B||_F sqrt(N)/((n-2)d).
# Record normalisation; B = Pi#Pi = (1/2) sum_{i,j} |[v_i,v_j]><[v_i,v_j]|. Also checks M <= 2 sqrt(d) ||B|| at the optimum.
# /usr/bin/python3 <log> n d1 d2 ...
import sys, time, itertools, numpy as np
log=open(sys.argv[1],'w'); n=int(sys.argv[2]); ds=[int(x) for x in sys.argv[3:]]
def L(*a): print(time.strftime('%H:%M:%S'),*a,file=log,flush=True)
prs=list(itertools.combinations(range(n),2)); N=len(prs)
E=np.zeros((N,n,n))
for k,(i,j) in enumerate(prs): E[k,i,j]=1; E[k,j,i]=-1
f=(np.einsum('aij,bjk,cik->abc',E,E,E)-np.einsum('bij,ajk,cik->abc',E,E,E))/2   # <[e_a,e_b],e_c>, record
rng=np.random.default_rng(2)
def parts(X):
    C=np.einsum('abc,ai,bj->ijc',f,X,X); B=0.5*np.einsum('ijc,ijd->cd',C,C); return C,B
def obj(X): C,B=parts(X); return np.sum(B*B),C,B
L('START pid',__import__('os').getpid(),f'plan: n={n}, d in {ds}, 3 restarts x 400 iters; target ratio 1 (whole algebra)')
C,B=parts(np.eye(N)); L('control so(n): ||B||_F=',np.linalg.norm(B),' (n-2)sqrtN=',(n-2)*np.sqrt(N))
for d in ds:
    best=(0,None)
    for r in range(3):
        X,_=np.linalg.qr(rng.normal(size=(N,d))); lr=0.02
        for it in range(400):
            J,C,B=obj(X); BC=np.einsum('cd,ijd->ijc',B,C); G=8*np.einsum('ijc,abc,bj->ai',BC,f,X)
            while lr>1e-10:
                Xn,_=np.linalg.qr(X+lr*G)
                if obj(Xn)[0]>=J: X=Xn; lr*=1.3; break
                lr*=0.5
        J,C,B=obj(X); ratio=np.sqrt(J)*np.sqrt(N)/((n-2)*d)
        M=np.einsum('ijc,ck->ijk',C,X); M=np.sum(M**2)
        L(f'd={d} restart {r}: ratio={ratio:.4f}  M={M:.3f}  2sqrt(d)||B||={2*np.sqrt(d)*np.sqrt(J):.3f}')
        if ratio>best[0]: best=(ratio,M)
    L(f'RESULT n={n} d={d} best ratio {best[0]:.4f} {"<=1" if best[0]<=1+1e-9 else "ABOVE 1"}')
L('DONE')
