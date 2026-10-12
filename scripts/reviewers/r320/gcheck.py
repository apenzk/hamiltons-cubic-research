import sys; sys.path.insert(0,'scripts/reviewers/r320')
import numpy as np, lib320 as L, cat320 as C

def adm(v,n):
    """matrix of ad(v) on Lambda^2 in the orthonormal basis: A[a,b]=<[v,phi_b],phi_a>"""
    c=L.struct(n)
    return np.einsum('g,gba->ab',v,c,optimize=True)

def gvec(W,n):
    ev,V=np.linalg.eigh(W); N=len(ev); g=np.zeros(N)
    for i in range(N):
        A=adm(V[:,i],n); Cm=A@W-W@A
        g[i]=float(np.einsum('ab,ab->',Cm,Cm))
    return ev,V,g

print(f"{'point':22}{'n':>3}{'theta':>10}{'sum g':>10}{'4(n-1)':>9}{'4theta':>10}{'sum|l|g-':>10}{'Pi/4':>10}{'Delta':>10}{'ker':>5}")
def show(name,W,n):
    q=L.Q(W,n); th=L.frob(W,q)
    if th<0: W=-W;th=-th
    ev,V,g=gvec(W,n)
    pos=ev>1e-9; neg=ev<-1e-9
    ident=(np.abs(ev[neg])*g[neg]).sum()-(ev[pos]*g[pos]).sum()
    Pi=abs(ev.min())*g.sum()
    print(f"{name:22}{n:>3}{th:>10.6f}{g.sum():>10.5f}{4*(n-1):>9}{4*th:>10.6f}{ident:>10.6f}{Pi/4:>10.6f}{g[pos].sum():>10.2e}{int((np.abs(ev)<=1e-9).sum()):>5}")
for (p,q) in [(3,3),(3,5),(4,4),(5,7),(2,4)]:
    show(f"S^{p}xS^{q}",C.sphere_product(p,q),p+q)
for n in [4,8,12]: show(f"CP^2 pad{n}",C.cp2(n),n)
for m in [3,4]: show(f"CP^{m}",C.cpm(m),2*m)
show("Cas so(3)^3",C.casimir(C.so_block_subalg([3,3,3],9),9)[0],9)
show("Cas so(2)^3",C.casimir(C.so_block_subalg([2,2,2],6),6)[0],6)
# random (non-critical) Weyl: does sum g = 4(n-1) hold off criticality?
for n in [6,8]:
    B=L.weyl_basis(n); rng=np.random.default_rng(7)
    x=rng.standard_normal(B.shape[0]); W=np.einsum('t,tab->ab',x,B); W/=np.sqrt(L.frob(W))
    ev,V,g=gvec(W,n); print(f"{'random Weyl (noncrit)':22}{n:>3}{L.P_of(W,n):>10.6f}{g.sum():>10.5f}{4*(n-1):>9}")
