import sympy as sp, random, numpy as np, itertools
exec(open('scripts/misc/screen_I73c_I1_rowspan.py').read().split('for trial in range')[0])
random.seed(7); n=8; N=28
def red(I1,rows,tv,free):
    others=[t for t in tv if t not in free]; sol=sp.solve(rows,others,dict=True)
    if not sol: return None
    r=sp.expand(I1.subs(sol[0]))
    if any(r.has(o) for o in others): return None
    return r
cnt=0
while cnt<5:
    m1,m2=random.randint(3,N//2),random.randint(3,N//2); m3=N-m1-m2
    if m3<3: continue
    raw=sorted(random.uniform(-1,1) for _ in range(3))
    e=np.array(raw); m=[m1,m2,m3]; e=e-np.dot(m,e)/N; e=e/np.sqrt(np.dot(m,e**2))/1.3
    eps=[sp.Rational(x).limit_denominator(10**7) for x in e]
    # exact tracelessness: adjust eps3
    eps[2]=-(m1*eps[0]+m2*eps[1])/m3
    I1,rows,tv,g12=build(n,m,eps)
    M=sp.Matrix([[sp.expand(r).coeff(t) for t in tv] for r in rows]); rk=M.rank()
    tvd={str(t):t for t in tv}
    out=[]
    for fr in (('t012','t000','t222'),('t001','t011','t122'),('t002','t112','t022')):
        r=red(I1,rows,tv,[tvd[f] for f in fr])
        out.append((fr, None if r is None else [float(r.coeff(tvd[f])) for f in fr]))
    print(m,[float(x) for x in eps],"rank",rk,"g12",I1.coeff(g12),out)
    cnt+=1
