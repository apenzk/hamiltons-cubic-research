import sympy as sp, random, numpy as np
from scipy.optimize import linprog
exec(open('scripts/misc/screen_I73c_I1_rowspan.py').read().split('for trial in range')[0])
def diag(n,m,raw,theta):
    e=np.array(raw,float); e=e-np.dot(m,e)/sum(m); e=e/np.sqrt(np.dot(m,e**2))/theta
    eps=[sp.Rational(x).limit_denominator(10**9) for x in e]
    I1,rows,tvars,g12=build(n,m,eps)
    tv={tuple(int(c) for c in str(t)[1:]):t for t in tvars}; tau=lambda a,b,c: tv[tuple(sorted((a,b,c)))]
    cls=range(3); X=list(tvars)
    Aeq=np.array([[float(sp.expand(r).coeff(x)) for x in X] for r in rows]); beq=np.array([-float(sp.expand(r).subs({x:0 for x in X})) for r in rows])
    r0=linprog(np.zeros(len(X)),A_eq=Aeq,b_eq=beq,bounds=[(0,None)]*len(X),method='highs')
    Nabc=lambda a,b,c: m[a]*(m[b]-(a==b))*(m[c]-(a==c)-(b==c))
    caps=[sum((m[c]-(a==c)-(b==c))*tau(a,b,c)/Nabc(a,b,c) for c in cls if Nabc(a,b,c)>0)-2 for a in cls for b in cls if a<=b]
    Aub=np.array([[float(sp.expand(r).coeff(x)) for x in X] for r in caps]); bub=np.array([-float(sp.expand(r).subs({x:0 for x in X})) for r in caps])
    r1=linprog(np.zeros(len(X)),A_ub=Aub,b_ub=bub,A_eq=Aeq,b_eq=beq,bounds=[(0,None)]*len(X),method='highs')
    # theta* over rows+tau>=0 : maximise theta. rows C in lambda form: theta enters; do it via e-scaling? report status only
    return r0.status==0, r1.status==0
random.seed(3)
for n in (8,6,10):
    N=n*(n-1)//2; cnt=0
    while cnt<3:
        m1,m2=random.randint(3,N//2),random.randint(3,N//2); m3=N-m1-m2
        if m3<3: continue
        raw=sorted(random.uniform(-1,1) for _ in range(3))
        for th in (1.25,1.45):
            print(n,(m1,m2,m3),th,"rows+tau>=0 feasible:",*diag(n,[m1,m2,m3],raw,th))
        cnt+=1
