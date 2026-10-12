# I111, the equal-u ansatz lifted in the SCALAR chain: which (N1,N2,N3,tau) survive with unequal u_a, and does the band top keep
# theta - sqrt3 u_a > 0 (invertibility) off the ansatz?  theta^2 = 3/2.  Per block, with N = sum N, t = 1 - N:
#   F_a(u) = theta u^2 - u^3/(2 sqrt3) - (u/sqrt3)(t + (N - N_a)/2) - N_a theta/2 + tau          (chain slack; F_a >= 0 excludes)
#   (theta - 2 tau/N_a)/sqrt3 <= u_a   (pinning),   3 u_a^2 <= theta^2 + (N_b N_c - 4 theta tau)/N_a   (band top),   u_a <= sqrt t
#   sum u_a^2 <= 5t/3  (Gram),   0 < tau <= sqrt(N1 N2 N3)/2  (product bound).
# Survives iff some u in the box has every F_a < 0 and passes Gram.  A screen of the scalar system only. /usr/bin/python3, minutes.
import numpy as np, itertools
th=np.sqrt(1.5); r3=np.sqrt(3)
G=np.linspace(0.01,0.45,45); U=np.linspace(0,1,2001)
surv=[]; noninv=[]
for N1,N2,N3 in itertools.product(G,G,G):
    if not (N1<=N2<=N3): continue
    Ns=np.array([N1,N2,N3]); N=Ns.sum(); t=1-N
    if t<=0: continue
    tmax=0.5*np.sqrt(N1*N2*N3)
    for f in np.linspace(0.02,1,50):
        tau=f*tmax; best=[]; ok=True
        for a in range(3):
            b,c=[k for k in range(3) if k!=a]
            lo=max(0,(th-2*tau/Ns[a])/r3); hi2=(th**2+(Ns[b]*Ns[c]-4*th*tau)/Ns[a])/3
            hi=min(np.sqrt(max(hi2,0)),np.sqrt(t))
            if hi2<0 or lo>hi: ok=False; break
            u=U[(U>=lo)&(U<=hi)]
            F=th*u**2-u**3/(2*r3)-(u/r3)*(t+(N-Ns[a])/2)-Ns[a]*th/2+tau
            neg=u[F<0]
            if neg.size==0: ok=False; break
            best.append((neg.min(),neg.max(),hi))
        if not ok: continue
        if sum(x[0]**2 for x in best)>5*t/3: continue
        surv.append((N1,N2,N3,f,[round(x[0],4) for x in best]))
        if any(r3*x[0]>=th for x in best): noninv.append(surv[-1])
print('survivors',len(surv))
if surv:
    S=np.array([[s[0],s[1],s[2],s[3]] for s in surv])
    print('N range',S[:,:3].min(),S[:,:3].max(),' max N3/N1',(S[:,2]/S[:,0]).max(),' f range',S[:,3].min(),S[:,3].max())
    diag=[s for s in surv if s[2]-s[0]<0.011]; print('near-diagonal survivors',len(diag))
    far=sorted(surv,key=lambda s:-(s[2]-s[0]))[:8]
    for s in far: print(' spread',round(s[2]-s[0],3),s)
print('survivors whose smallest admissible u_a breaks invertibility',len(noninv)); print(noninv[:5])
