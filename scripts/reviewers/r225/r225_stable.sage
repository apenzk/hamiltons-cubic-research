# r225: independent stable decomposition of Sym^3(Weyl_n) as an O(n) universal character.
# Route: Weyl_n = res_{O(n)}( s_{2,2} - s_2 )  (virtual GL character; Littlewood restriction
# of s_{2,2} is [2,2]+[2]+[0] and of s_2 is [2]+[0]).  res is a lambda-ring hom, so
# Sym^3(Weyl_n) = res( Sym^3(s_{2,2} - s_2) ).  Then Littlewood restriction of the degree-12
# symmetric function gives the STABLE O-table (exact for n >= 24; modification rules handled
# separately).
import json, sys

Sym = SymmetricFunctions(QQ)
s = Sym.s(); p = Sym.p(); h = Sym.h(); e = Sym.e()

A = s[2,2] - s[2]

# Adams operations psi^k(A) = p_k o A  (additive, ring hom)
psi1 = A
psi2 = p[2].plethysm(A)
psi3 = p[3].plethysm(A)
F = (psi1*psi1*psi1 + 3*psi1*psi2 + 2*psi3) / 6

# cross-check 1: h_3 plethysm directly
F2 = h[3].plethysm(A)
assert F == F2, "Adams-vs-plethysm mismatch"

# cross-check 2: lambda-ring expansion Sym^3(x-y) = S3x - S2x*y + x*L2y - L3y
x = s[2,2]; y = s[2]
F3 = h[3].plethysm(x) - h[2].plethysm(x)*y + x*e[2].plethysm(y) - e[3].plethysm(y)
assert F == F3, "lambda-ring identity mismatch"

# sanity: dimension of Sym^3 at n variables must be binom(D+2,3), D = dim Weyl_n
def hook(la):
    la=list(la); c=[sum(1 for r in la if r>j) for j in range(la[0])] if la else []
    return {(i,j): la[i]-j + c[j]-i - 1 for i in range(len(la)) for j in range(la[i])}
def dim_gl(la, n):
    la=list(la)
    if not la: return 1
    if len(la) > n: return 0
    H=hook(la); d=1
    for (i,j),hh in H.items():
        d *= Integer(n + j - i)
    for hh in H.values():
        d /= Integer(hh)
    return Integer(d)
for n in [6,8,10,12,16,24]:
    D = n*(n+1)*(n+2)*(n-3)//12
    val = sum(c * dim_gl(la, n) for la,c in F)
    assert val == binomial(D+2,3), (n, val, binomial(D+2,3))
print("dimension self-check of F passed at n=6,8,10,12,16,24")

# --- Littlewood restriction:  mult of [mu] = sum over delta with all parts EVEN of <F, s_mu s_delta>
#     = coefficient of s_mu in  sum_delta  s_delta^perp F
evens = []
for d in range(0, 13, 2):
    for la in Partitions(d//2):
        evens.append(Partition([2*x for x in la]))
G = Sym.zero()
for d in evens:
    G += F.skew_by(s(d))

T = {}
for la, c in s(G):
    if c != 0:
        T[tuple(la)] = int(c)

blocks = len(T)
total = sum(T.values())
neg = {k:v for k,v in T.items() if v < 0}
maxrows = max(len(k) for k in T)
def conj(la):
    la = list(la)
    if not la: return []
    return [sum(1 for r in la if r > j) for j in range(la[0])]
def c12(la):
    cc = conj(la)
    return (cc[0] if len(cc)>0 else 0) + (cc[1] if len(cc)>1 else 0)
mx = max(c12(k) for k in T)
print("STABLE TABLE: blocks=%d  total multiplicity=%d  max rows=%d  max lam'_1+lam'_2=%d  negative entries=%s"
      % (blocks, total, maxrows, mx, neg))
extremes = sorted([k for k in T if c12(k)==mx])
print("labels attaining the max:", extremes)
json.dump({str(list(k)): v for k,v in sorted(T.items())}, open('scripts/reviewers/r225/r225_stable_table.json','w'), indent=0)
print("wrote scripts/reviewers/r225/r225_stable_table.json")
