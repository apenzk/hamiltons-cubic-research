# r224: arithmetic check on the whole universal table -- sum over the 71 blocks of
# (multiplicity x dim_{O(n)}[lambda]) must equal binom(dim Weyl_n + 2, 3).
# Dimensions come from the Weyl dimension formula (WeylCharacterRing), with the
# n-even, ell(lambda)=n/2 labels doubled because [lambda]_{O(n)} splits in two there.
import json
E = {tuple(json.loads(k)): v for k, v in json.load(open('scripts/reviewers/r224/universal_table.json')).items()}
for n in (12, 13, 14, 16, 18):
    m = n // 2
    A = WeylCharacterRing(("B%d" if n % 2 else "D%d") % m)
    tot = 0
    for lam, mult in E.items():
        assert len(lam) <= m, (n, lam)
        hw = list(lam) + [0]*(m - len(lam))
        d = A(*hw).degree()
        if n % 2 == 0 and len(lam) == m:
            d = 2*d                     # self-associate at ell = n/2: splits over SO(n)
        tot += mult * d
    dW = n*(n+1)*(n+2)*(n-3)//12
    want = binomial(dW + 2, 3)
    print("n=%-3d sum mult*dim = %-22d  binom(dim Weyl_n + 2, 3) = %-22d  %s"
          % (n, tot, want, "MATCH" if tot == want else "*** MISMATCH ***"))

# PLANTED VIOLATION: does this check actually fail when the table is wrong?
# At n = 10 the table DOES move.  Pretending it does not must break the identity.
print()
def cols(l): return [sum(1 for x in l if x >= j) for j in range(1, (max(l) if l else 0)+1)]
def from_cols(c):
    c = [x for x in c if x]
    return tuple(sum(1 for y in c if y >= i) for i in range(1, (max(c) if c else 0)+1))
n = 10; m = 5
A = WeylCharacterRing("D5")
def dimO(lam):
    if len(lam) > m:                      # long label: same dimension as its associate
        c = cols(lam); lam = from_cols([n - c[0]] + c[1:])
    hw = list(lam) + [0]*(m - len(lam))
    d = A(*hw).degree()
    return 2*d if len(lam) == m else d
dW = n*(n+1)*(n+2)*(n-3)//12
want = binomial(dW + 2, 3)
naive = sum(v*dimO(l) for l, v in E.items())
print("n=10, PRETENDING the stable table still holds: %d vs %d  -> %s"
      % (naive, want, "MATCH" if naive == want else "MISMATCH (check fires)"))
fixed = {l: v for l, v in E.items() if l not in [(2,2,2,2,2,2), (2,2,2,2,2)]}
corr = sum(v*dimO(l) for l, v in fixed.items())
print("n=10, with King's rule applied ((2^6) -> -(2^5)):        %d vs %d  -> %s"
      % (corr, want, "MATCH" if corr == want else "MISMATCH"))
