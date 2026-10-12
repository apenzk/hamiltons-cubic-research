# I73 (c), n = 12 window: min over the unit pencil span(x, y) of s_1^2, x, y decomposable with principal angles (a, b)
# between their planes. Line-sharing (a = 0) gives 1, equal angles 0.5, unequal angles in between. /usr/bin/python3, seconds.
# two unit decomposables x=e1^e2, y=(cos a e1 + sin a e3)^(cos b e2 + sin b e4) (principal angles a,b between planes),
# orthogonalised; min over unit combinations of s1^2 = (largest singular value)^2 in 1/2tr-unit normalisation
import numpy as np
n=6; e=np.eye(n)
def w(u,v): return np.outer(v,u)-np.outer(u,v)
def s1sq(X):
    X=X/np.sqrt(0.5*np.sum(X*X)); sv=np.linalg.svd(X,compute_uv=False); return sv[0]**2
def minpencil(a,b):
    x=w(e[0],e[1]); y=w(np.cos(a)*e[0]+np.sin(a)*e[2], np.cos(b)*e[1]+np.sin(b)*e[3])
    y=y-0.5*np.sum(x*y)*x
    if np.sum(y*y)<1e-12: return 1.0
    return min(s1sq(np.cos(t)*x+np.sin(t)*y) for t in np.linspace(0,np.pi,721))
for a in np.linspace(0,np.pi/2,7):
    print(round(np.degrees(a)),[round(minpencil(a,b),3) for b in np.linspace(0,np.pi/2,7)])
