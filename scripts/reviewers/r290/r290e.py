import numpy as np
from scipy.optimize import minimize
# post-33 moment problem, recomputed in the ||M||_F=1 normalisation: p2=3, x_i>=-m, sum x=0, minimise sum x^3
def p3min_numeric(N,m,p2=3.0,seed=0):
    rng=np.random.default_rng(seed); best=1e9
    for t in range(30):
        x0=rng.standard_normal(N)
        cons=[dict(type='eq',fun=lambda x:x.sum()),dict(type='eq',fun=lambda x:np.sum(x**2)-p2)]
        r=minimize(lambda x:np.sum(x**3),x0,constraints=cons,bounds=[(-m,None)]*N,method='SLSQP',
                   options=dict(maxiter=500,ftol=1e-12))
        if r.success and r.fun<best: best=r.fun
    return best
def p3min_closed(N,m,p2=3.0):
    # k atoms at -m, rest at a=km/(N-k); k from k m^2 N/(N-k)=p2
    k=p2*N/(m*m*N+p2)   # solve k m^2 N = p2 (N-k)
    a=k*m/(N-k)
    return -k*m**3+(N-k)*a**3, k
for (n,m) in [(12,0.816497),(8,0.816497),(24,0.816497),(12,1.348400)]:
    N=n*(n+1)//2-1
    num=p3min_numeric(N,m); cl,k=p3min_closed(N,m)
    # post 33's published closed form, in ITS normalisation (|W|_4tensor=1 -> p2=3/4, m'=m/2), rescaled back by 8
    mp=m/2; pub=8*(9/(16*mp*N)-3*mp/4)
    print(f"n={n} N={N} m={m:.6f}: numeric p3min={num:+.6f}  k-atom closed form={cl:+.6f} (k={k:.3f})  post33 published (rescaled)={pub:+.6f}")
