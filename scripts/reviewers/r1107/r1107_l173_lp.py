import sympy as sp, numpy as np, random
src=open('scripts/misc/screen_I73c_I1_lp.py').read().split('random.seed(3)')[0]
src=src.replace("__file__.rsplit('/', 1)[0]","'scripts/misc'")
exec(src)
th=np.sqrt(21)/2
for n,m in ((12,(4,59,3)),(8,(4,21,3)),(10,(4,38,3))):
    e,res,rng_,low=lp_at(n,m,[-1/7,0,4/21],th)
    print(n,m,[round(x,6) for x in e],res,"I1 range",rng_,"window",(low,0))
