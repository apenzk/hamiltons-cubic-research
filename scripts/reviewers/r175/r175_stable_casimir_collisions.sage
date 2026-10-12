"""r175: how far a polynomial in the Casimir separates Sym^3(Weyl_n) blocks.

At n = 5 the record tabulates three collisions among 24 blocks and calls the fix
"cheap: a degree-four Casimir".  This runs the same test in the range item 3c is
actually aimed at, n >= 12, using the stable plethysm (no character is expanded).
"""
Sym = SymmetricFunctions(QQ); s,h,o = Sym.s(), Sym.h(), Sym.o()
P = o(h[3].plethysm(s[2,2]-s[2])); d = P.monomial_coefficients()
n = 12; r = n//2
rho = [n/2 - i for i in range(1, r+1)]          # rho_{D_6} = (5,4,3,2,1,0)
def wt(mu):
    mu = list(mu) + [0]*(r-len(list(mu))); return mu
def xs(mu):  return [a+b for a,b in zip(wt(mu), rho)]
def pk(mu,k): return sum(x**k for x in xs(mu))
def cas(mu):
    m = wt(mu); return sum(m[i]*(m[i]+n-2*(i+1)) for i in range(r))
labels = list(d.keys())
print("blocks %d, multiplicities %d, n = %d" % (len(labels), sum(d.values()), n))
for tag, key in [("c_2 alone",           lambda mu: (cas(mu),)),
                 ("c_2 and c_4",         lambda mu: (cas(mu), pk(mu,4))),
                 ("c_2, c_4, c_6",       lambda mu: (cas(mu), pk(mu,4), pk(mu,6))),
                 ("c_2..c_10",           lambda mu: tuple(pk(mu,k) for k in (2,4,6,8,10))),
                 ("c_2..c_10 + Pfaffian",lambda mu: tuple(pk(mu,k) for k in (2,4,6,8,10)) + (prod(xs(mu)),)),
                 ("+ block dimension",   lambda mu: (cas(mu), P.parent()  and 0))]:
    if tag.startswith("+"): continue
    k = len(set(key(mu) for mu in labels))
    print("  %-24s separates %2d of %d blocks" % (tag, k, len(labels)))
# the fused eigenspaces of c_2, by size
from collections import defaultdict
g = defaultdict(list)
for mu in labels: g[cas(mu)].append((tuple(mu), d[mu]))
fused = {c:v for c,v in g.items() if len(v)>1}
print("  c_2 fuses %d blocks into %d classes; largest class has %d blocks"
      % (sum(len(v) for v in fused.values()), len(fused), max(len(v) for v in fused.values())))

# does "each pair differs in dimension" survive at n = 12?
rho6 = [5,4,3,2,1,0]
def dimD6(mu):
    l = xs(mu)
    num = prod(l[i]^2 - l[j]^2 for i in range(6) for j in range(i+1,6))
    den = prod(rho6[i]^2 - rho6[j]^2 for i in range(6) for j in range(i+1,6))
    dd = num/den
    return 2*dd if len(list(mu)) == 6 else dd      # O(12) block doubles on the fork
bad = 0
for c,v in sorted(fused.items()):
    dims = [dimD6(mu) for mu,_ in v]
    if len(set(dims)) < len(dims):
        bad += 1
        print("  SAME DIMENSION inside the c = %s class:" % c, list(zip([m for m,_ in v], dims)))
print("  classes where the dimension fix fails:", bad, "of", len(fused))
print("  total dim check:", sum(d[mu]*dimD6(mu) for mu in labels), "vs binom(1640,3) =", binomial(1640,3))
