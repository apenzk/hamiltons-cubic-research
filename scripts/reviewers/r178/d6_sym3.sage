# r178: independent decomposition of Sym^3(Weyl_12) for so(12)=D6, via Adams operations
# + the Racah/Brauer alternating-sum multiplicity formula. No repo code used.
import itertools, time
D6 = WeylCharacterRing("D6")
V = D6(2,2,0,0,0,0)
print("dim Weyl_12 =", V.degree())
wm = {tuple(Integer(c) for c in k.to_vector()): Integer(m) for k,m in V.weight_multiplicities().items()}
print("distinct weights of Weyl_12:", len(wm), " sum mult:", sum(wm.values()))
def adams(d):
    return {tuple(d*c for c in w): m for w,m in wm.items()}
def mul(A,B):
    C = {}
    for wa,ma in A.items():
        for wb,mb in B.items():
            k = tuple(x+y for x,y in zip(wa,wb))
            C[k] = C.get(k,0) + ma*mb
    return C
t0=time.time()
p1 = wm; p2 = adams(2); p3 = adams(3)
c = {}
A = mul(mul(p1,p1),p1)          # p1^3
B = mul(p1,p2)                  # p1*p2
for w,m in A.items(): c[w] = c.get(w,0)+m
for w,m in B.items(): c[w] = c.get(w,0)+3*m
for w,m in p3.items(): c[w] = c.get(w,0)+2*m
c = {w: m//6 for w,m in c.items() if m != 0}
assert all((mm*6) % 6 == 0 for mm in c.values())
print("Sym^3 char: distinct weights", len(c), " total dim", sum(c.values()),
      " expected", binomial(1638+2,3), " time", time.time()-t0)

rho = (5,4,3,2,1,0)
# W(D6): permutations x even sign changes
perms = list(itertools.permutations(range(6)))
signs = [s for s in itertools.product([1,-1],repeat=6) if s.count(-1)%2==0]
Wel = []
for p in perms:
    sp = Permutation([i+1 for i in p]).signature()
    for s in signs:
        Wel.append((p,s,sp))   # w(rho)_i = s_i * rho_{p_i}
print("|W(D6)| =", len(Wel))
wrho = []
for p,s,sp in Wel:
    wrho.append((tuple(s[i]*rho[p[i]] for i in range(6)), sp))
def dominant(mu):
    return all(mu[i] >= mu[i+1] for i in range(4)) and mu[4] >= abs(mu[5])
cand = sorted([w for w in c if dominant(w)], key=lambda t: (-sum(t), t))
print("dominant weights present:", len(cand))
res = {}
t0=time.time()
for mu in cand:
    mr = tuple(mu[i]+rho[i] for i in range(6))
    n = 0
    for wr,sg in wrho:
        k = tuple(mr[i]-wr[i] for i in range(6))
        v = c.get(k)
        if v: n += sg*v
    if n: res[mu] = n
print("blocks:", len(res), " time", time.time()-t0)
tot = sum(m*D6(mu).degree() for mu,m in res.items())
print("sum m*dim =", tot, " == ", sum(c.values()), tot==sum(c.values()))
print("sum of multiplicities =", sum(res.values()))
neg = [mu for mu in res if mu[5] != 0]
print("blocks with lam_6 != 0:", len(neg), neg[:20])
for mu in sorted(res, key=lambda t:(-sum(t),t)):
    print(mu, res[mu], D6(mu).degree())
