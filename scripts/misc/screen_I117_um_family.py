# I117 / U: the U(m)-invariant family in so(2m). so(2m) = su(m) + R J + m under U(m) (multiplicity-free, m of complex
# type), so U(m)-invariant symmetric C are a P_su + b P_J + c P_m. Solve C#C = C by Newton in (a,b,c) from many starts and
# list every solution with its positivity; U predicts a = b = c = 1/(n-2) as the only positive one.  A screen, seconds.
# /usr/bin/python3 scripts/misc/screen_I117_um_family.py m1 m2 ...
import sys, itertools, numpy as np
for m in [int(x) for x in sys.argv[1:]]:
    n=2*m; prs=list(itertools.combinations(range(n),2)); N=len(prs)
    E=np.zeros((N,n,n))
    for k,(i,j) in enumerate(prs): E[k,i,j]=1; E[k,j,i]=-1
    f=(np.einsum('aij,bjk,cik->abc',E,E,E)-np.einsum('bij,ajk,cik->abc',E,E,E))/2
    T=np.transpose(f,(2,0,1)); Tf=T.reshape(N,-1)
    def sharp(X): return 0.5*Tf@np.matmul(np.matmul(X,T),X).reshape(N,-1).T
    J=np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=-1; J[2*k+1,2*k]=1
    vec=lambda M: np.array([M[i,j] for i,j in prs])            # coordinates in the e_ij basis (record norm)
    # commuting (u(m)) and anticommuting (m) parts: x -> (x - J x J)/2 and (x + J x J)/2
    Pu=np.array([vec((E[a]-J@E[a]@J)/2) for a in range(N)]).T; Pm=np.eye(N)-Pu
    jv=vec(J); jv=jv/np.linalg.norm(jv); PJ=np.outer(jv,jv); Psu=Pu-PJ
    assert np.allclose(Pu@Pu,Pu) and np.allclose(Psu@PJ,0)
    def G(x):
        a,b,c=x; C=a*Psu+b*PJ+c*Pm; S=sharp(C)
        return np.array([np.trace(S@Psu)/np.trace(Psu)-a, np.trace(S@PJ)-b, np.trace(S@Pm)/np.trace(Pm)-c]), np.linalg.norm(S-(np.trace(S@Psu)/np.trace(Psu)*Psu+np.trace(S@PJ)*PJ+np.trace(S@Pm)/np.trace(Pm)*Pm))
    rng=np.random.default_rng(m); sols=set(); leak=0
    for t in range(200):
        x=rng.uniform(-0.5,0.5,3)*rng.uniform(0.2,3)
        for it in range(60):
            g,_=G(x)
            if np.linalg.norm(g)<1e-12: break
            Jm=np.zeros((3,3))
            for q in range(3):
                e=np.zeros(3); e[q]=1e-7; Jm[:,q]=(G(x+e)[0]-g)/1e-7
            x=x-np.linalg.lstsq(Jm,g,rcond=None)[0]
        g,lk=G(x); leak=max(leak,lk)
        if np.linalg.norm(g)<1e-10: sols.add(tuple(np.round(x,6)))
    print(f'm={m} n={n}: {len(sols)} solutions (max leak of C#C out of the family {leak:.1e}); 1/(n-2) = {1/(n-2):.6f}')
    for s in sorted(sols): print('   a,b,c =',s,' positive' if min(s)>1e-9 else '')
