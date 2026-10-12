"""Master formula  lambda_S = 1 - (c_S + q_S^2)/(4(m+1))  checked against measurement."""
import sympy as sp
m=sp.symbols('m', positive=True, integer=True)
def cas(nu, mm):
    return sum(nu[i]*(nu[i]+mm+1-2*(i+1)) for i in range(len(nu)))
rows=[]
# highest weights written as (front entries, tail entries); c_S computed symbolically
def cS_sym(front, tail):
    # front = list of nu_1..  ; tail = list of nu_{m-k+1}..nu_m
    s=0
    for i,v in enumerate(front):
        s+= v*(v+m+1-2*(i+1))
    k=len(tail)
    for j,v in enumerate(tail):
        idx = m-k+1+j          # 1-based index
        s+= v*(v+m+1-2*idx)
    return sp.simplify(s)
data=[('trivial (W)',[],[],0),
      ('su(m) adjoint',[1],[-1],0),
      ('Lam^2 E (orbit)',[1,1],[],2),
      ('V_{(1,1);(1,1)}',[1,1],[-1,-1],0),
      ('V_{(2,1);(1)}',[2,1],[-1],2),
      ('V_{(2);(2)} Bochner',[2],[-2],0),
      ('V_{(2,2);0}',[2,2],[],4)]
print(f"{'summand':22s} {'c_S':16s} {'q':>3s} {'lambda = 1-(c_S+q^2)/(4(m+1))':30s}")
for nm,fr,tl,q in data:
    c=cS_sym(fr,tl); lam=sp.simplify(1-(c+q**2)/(4*(m+1)))
    print(f"{nm:22s} {str(c):16s} {q:3d} {str(sp.factor(lam)):30s}")
