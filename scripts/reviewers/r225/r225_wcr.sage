# Independent finite-n check: decompose Sym^3 of the SO(2m) irrep with h.w. (2,2,0,...,0)
# using Sage's Weyl character ring.  This uses only root-system character theory --
# no Littlewood restriction, no King modification rule, no repo code.
import json, sys, time
m = Integer(sys.argv[1])
R = WeylCharacterRing("D%d"%m)
V = R(*([2,2]+[0]*(m-2)))
n = 2*m
assert V.degree() == n*(n+1)*(n+2)*(n-3)//12, (V.degree(),)
t=time.time()
S3 = V.symmetric_power(3)
d = {}
for k,c in S3.monomial_coefficients().items():
    d[str(list(R.coerce_to_sl(k) if False else k.to_vector()))] = int(c)
assert sum(int(c)*R(k).degree() for k,c in S3.monomial_coefficients().items()) == binomial(V.degree()+2,3)
json.dump(d, open('scripts/reviewers/r225/r225_so%d.json'%n,'w'), indent=0)
print("n=%d  m=%d  SO-blocks=%d  total-mult=%d  seconds=%.0f" % (n, m, len(d), sum(d.values()), time.time()-t))
