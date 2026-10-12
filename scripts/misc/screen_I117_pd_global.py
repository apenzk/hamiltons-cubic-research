# I117 / U: a global search for positive-definite #-idempotents on so(n). Minimise ||C#C - C||^2 over C = exp(H)
# (H symmetric, so C stays positive definite) by Gauss-Newton with backtracking from random H of varied spread, and
# report every converged C: its distance to I/(n-2), eigenvalue range, and residual.  A screen, minutes.
# /usr/bin/python3 scripts/misc/screen_I117_pd_global.py <log> n starts
import sys, itertools, time, numpy as np
log=open(sys.argv[1],'a'); n=int(sys.argv[2]); S=int(sys.argv[3])
def L(*a): print(time.strftime('%H:%M:%S'),*a,file=log,flush=True)
prs=list(itertools.combinations(range(n),2)); N=len(prs)
E=np.zeros((N,n,n))
for k,(i,j) in enumerate(prs): E[k,i,j]=1; E[k,j,i]=-1
f=(np.einsum('aij,bjk,cik->abc',E,E,E)-np.einsum('bij,ajk,cik->abc',E,E,E))/2
T=np.transpose(f,(2,0,1)); Tf=T.reshape(N,-1)
def sharp(X,Y): return 0.25*(Tf@np.matmul(np.matmul(X,T),Y).reshape(N,-1).T+Tf@np.matmul(np.matmul(Y,T),X).reshape(N,-1).T)
iu=np.triu_indices(N); D=len(iu[0])
def mat(v):
    M=np.zeros((N,N)); M[iu]=v; return M+M.T-np.diag(np.diag(M))
def expm_sym(H):
    w,U=np.linalg.eigh(H); return (U*np.exp(w))@U.T
def res(v):
    C=expm_sym(mat(v)); R=sharp(C,C)-C; return R[iu],C
rng=np.random.default_rng(7); I=np.eye(N)/(n-2); found=[]
L(f'START n={n} N={N} starts={S}')
for s in range(S):
    H=rng.normal(size=(N,N))*rng.uniform(0.1,1.5); H=(H+H.T)/2+np.eye(N)*np.log(1/(n-2))*rng.uniform(0.5,1.5)
    v=H[iu].copy()
    for it in range(80):
        r,C=res(v); nr=np.linalg.norm(r)
        if nr<1e-11: break
        Jm=np.zeros((D,D)); h=1e-6
        for q in range(D):
            e=np.zeros(D); e[q]=h; Jm[:,q]=(res(v+e)[0]-r)/h
        if not np.all(np.isfinite(Jm)): break
        try: step=np.linalg.lstsq(Jm,r,rcond=None)[0]
        except np.linalg.LinAlgError: break
        sn=np.linalg.norm(step)
        if sn>1.0: step=step/sn        # clip: C = exp(H) overflows on long steps
        t=1.0
        while t>1e-6 and np.linalg.norm(res(v-t*step)[0])>nr: t/=2
        v=v-t*step
    r,C=res(v)
    if not np.all(np.isfinite(r)): L(f'  start {s}: diverged'); continue
    if np.linalg.norm(r)<1e-9:
        ev=np.linalg.eigvalsh(C); found.append((round(float(np.linalg.norm(C-I)),6),round(float(ev.min()),5),round(float(ev.max()),5)))
    L(f'  start {s}: residual {np.linalg.norm(r):.2e}' + (f', distance to I/(n-2) {np.linalg.norm(C-I):.2e}, eig [{np.linalg.eigvalsh(C).min():.4f},{np.linalg.eigvalsh(C).max():.4f}]' if np.linalg.norm(r)<1e-9 else ''))
L(f'converged positive-definite idempotents (distance to I/(n-2), min eig, max eig): {sorted(set(found))}')
L('DONE')
