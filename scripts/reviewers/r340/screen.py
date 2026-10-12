import math
# parameter-level screen of Lemma 74: two independent theta routes + Lemma 70 slack, both orientations.
def srg(v,k,lam,mu,name=""):
    assert k*(k-lam-1)==(v-k-1)*mu, ("identity fails",name)
    w=v-1-k; t=k/w
    a=math.sqrt(2*w/(v*k*(v-1)))
    F=((v-1)**2*lam+2*k*(v-1)-k*k*v+w*w)/(w*w)
    th74=F*a
    # spectral route
    disc=math.sqrt((lam-mu)**2+4*(k-mu))
    r=((lam-mu)+disc)/2; s=((lam-mu)-disc)/2
    if disc==0: f=g=0
    else:
        f=0.5*((v-1)-(2*k+(v-1)*(lam-mu))/disc)
        g=0.5*((v-1)+(2*k+(v-1)*(lam-mu))/disc)
    al=a; be=-a*t
    mr=a*((1+t)*r+t); ms=a*((1+t)*s+t)
    thspec=0.5*(v*(k*al**3+w*be**3)+f*mr**3+g*ms**3)
    nrm=0.5*(v*(k*al**2+w*be**2))   # = ||W||^2
    trM2=v*(k*al**2+w*be**2)
    # Lambda^2 spectrum: al with mult v*k/2, be with mult v*w/2
    out=[]
    for sgn in (1,-1):
        e1,e2=sgn*al,sgn*be
        lmax=max(e1,e2); lmin=min(e1,e2)
        th=sgn*th74
        bound=lmin+(v-2)*lmax
        out.append((sgn,th,bound,bound-th,lmax/abs(lmin)))
    return dict(name=name,v=v,k=k,lam=lam,mu=mu,w=w,F=F,a=a,th74=th74,thspec=thspec,
                nrm=nrm,trM2=trM2,orient=out)

cases=[(6,4,2,4,"octahedron K_{2,2,2}=K_{3x2}"),(6,1,0,0,"3K_2 perfect matching / max torus"),
       (6,3,0,3,"K_{3,3} balanced sphere product"),(6,2,1,0,"2K_3"),
       (5,2,0,1,"C_5"),(9,4,1,2,"Paley(9)=K_{3,3,3}c? rook"),(10,3,0,1,"Petersen"),
       (8,6,4,6,"K_{4x2}"),(8,1,0,0,"4K_2"),(8,4,0,4,"K_{4,4}"),(8,3,2,0,"2K_4"),
       (12,6,0,6,"K_{6,6}"),(12,1,0,0,"6K_2"),(12,5,4,0,"2K_6"),(12,10,8,10,"K_{6x2}"),
       (16,5,0,2,"Clebsch"),(13,6,2,3,"Paley(13)"),(25,12,5,6,"Paley(25)"),(28,12,6,4,"Chang/T(8)")]
print(f"{'name':34s} {'th74':>11s} {'thspec':>11s} {'||W||^2':>8s} {'F':>9s} {'ratio+':>8s} {'slack(+)':>10s} {'slack(-)':>10s} {'th0':>9s}")
for c in cases:
    d=srg(*c)
    n=d['v']; th0=math.sqrt(2*(n-1)*(n-2))/n
    p=[o for o in d['orient'] if o[0]==1][0]; m=[o for o in d['orient'] if o[0]==-1][0]
    print(f"{d['name']:34s} {d['th74']:11.6f} {d['thspec']:11.6f} {d['nrm']:8.4f} {d['F']:9.4f} {p[4]:8.4f} {p[3]:10.6f} {m[3]:10.6f} {th0:9.6f}")
