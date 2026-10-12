"""R6: which U(m)-summand of Sym^2(Lambda^2) can carry L_e = 1/2?
   lambda_S = 1 - (c_S+q^2)/(4(m+1)) = 1/2  <=>  c_S + q^2 = 2(m+1).
   Enumerate every dominant weight reachable as a sum of two Lambda^2 weights."""
import sympy as sp, itertools
m=sp.symbols('m', integer=True, positive=True)

def cas(nu_pairs):
    # nu given as list of (position_from_front or from_back, value); build as explicit
    pass

# a weight of Sym^2(Lambda^2) is w1+w2 with w_i in {e_k+e_l, e_k-e_l, -e_k-e_l}.
# Up to the Weyl group the dominant representative is described by the multiset of
# nonzero entries with a front block (positive, descending) and a back block
# (negative, descending).  Entries lie in {-2,-1,1,2} and sum of |entries| <= 4.
cands=set()
for pos in itertools.chain.from_iterable(itertools.combinations_with_replacement([1,2],k) for k in range(0,3)):
    for neg in itertools.chain.from_iterable(itertools.combinations_with_replacement([1,2],k) for k in range(0,3)):
        p=tuple(sorted(pos,reverse=True)); nneg=tuple(sorted(neg,reverse=True))
        if sum(p)+sum(nneg)>4: continue
        cands.add((p,nneg))
sols=[]
for p,nneg in sorted(cands):
    q=sum(p)-sum(nneg)
    c=0
    for i,v in enumerate(p):
        c+= v*(v+m+1-2*(i+1))
    k=len(nneg)
    for j,v in enumerate(nneg):
        vv=-v; idx=m-k+1+j
        c+= vv*(vv+m+1-2*idx)
    c=sp.expand(c)
    lam=sp.simplify(1-(c+q**2)/(4*(m+1)))
    eq=sp.simplify(c+q**2-2*(m+1))
    r=sp.solve(sp.Eq(c+q**2,2*(m+1)), m)
    tag=''
    if r: tag=f"   <-- 1/2 at m={r}"
    print(f"nu=(+{p}|-{nneg}) q={q:+d} c_S={sp.factor(c)}  lambda={sp.factor(lam)}{tag}")
