# r224: independent decomposition of Sym^3(Weyl_n) as an SO(n)-representation,
# using ONLY the Weyl character formula (Sage WeylCharacterRing).  No Littlewood
# restriction rule, no King modification rule, nothing read from this repo.
#
# Weyl_n = the O(n)-irreducible [2,2]; as an SO(n)-rep for n >= 5 it is the
# irreducible with highest weight (2,2,0,...,0).
import sys, time
n = Integer(sys.argv[1])
m = n // 2
typ = 'B' if n % 2 else 'D'
A = WeylCharacterRing("%s%d" % (typ, m), style="lattice")
hw = [2,2] + [0]*(m-2)
W = A(*hw)
print("n=%d  type %s%d  dim Weyl = %d  (formula %d)" % (n, typ, m, W.degree(), n*(n+1)*(n+2)*(n-3)/12))
sys.stdout.flush()
t0 = time.time()
S3 = W.symmetric_power(3)
print("Sym^3 dim = %d   (binom(d+2,3) = %d)  [%.1f s]" % (S3.degree(), binomial(W.degree()+2,3), time.time()-t0))
d = S3.monomial_coefficients()
items = sorted(((tuple(A(k).highest_weight().to_vector()), int(v)) for k,v in d.items()), key=lambda t: (-sum(abs(x) for x in t[0]), t[0]))
print("SO blocks = %d   total multiplicity = %d" % (len(items), sum(v for _,v in items)))
for hwt, v in items:
    print("   %s  x%d" % (list(hwt), v))
