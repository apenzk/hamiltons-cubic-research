# The stable table must satisfy sum_lambda m_lambda * dim_O(n)[lambda] = binom(D_n+2, 3)
# at every n where no modification rule fires.  Exact integers, no slack.
import json
load('scripts/reviewers/r225/r225_littlewood_check.sage') if False else None
def conj(la):
    la=[x for x in la if x]; return [sum(1 for r in la if r>j) for j in range(la[0])] if la else []
def hooks(la):
    la=[x for x in la if x]; c=conj(la)
    return {(i,j): la[i]-j+c[j]-i-1 for i in range(len(la)) for j in range(la[i])}
def dim_o(la,n):
    la=[x for x in la if x]; c=conj(la)
    if not la: return Integer(1)
    if (c[0] if c else 0)+(c[1] if len(c)>1 else 0) > n: return None
    H=hooks(la); num=1; den=1
    lam=lambda i: la[i-1] if i-1<len(la) else 0
    col=lambda i: c[i-1] if i-1<len(c) else 0
    for (i0,j0),hh in H.items():
        i,j=i0+1,j0+1
        num *= (n+lam(i)+lam(j)-i-j) if i<=j else (n-col(i)-col(j)+i+j-2)
        den *= hh
    return Integer(num)/Integer(den)

T = {tuple(eval(k)): v for k,v in json.load(open('scripts/reviewers/r225/r225_stable_table.json')).items()}
print("%4s %14s %28s %28s %s" % ("n","allowed?","sum m*dim_O(n)","binom(dim Weyl_n + 2, 3)","match"))
for n in [10,11,12,13,14,16,18,20,24]:
    D = n*(n+1)*(n+2)*(n-3)//12
    tgt = binomial(D+2,3)
    dims = [dim_o(la,n) for la in T]
    if None in dims:
        bad = [la for la in T if dim_o(la,n) is None]
        print("%4d %14s %28s %28s %s" % (n, "NO (%d labels)"%len(bad), "-", tgt, "table invalid at this n"))
        continue
    tot = sum(T[la]*dim_o(la,n) for la in T)
    print("%4d %14s %28d %28d %s" % (n, "yes", tot, tgt, "YES" if tot==tgt else "*** NO ***"))

print()
print("planted violations at n=12:")
tgt = binomial(12*13*14*9//12+2,3)
base = sum(T[la]*dim_o(la,12) for la in T)
for desc, delta in [("one multiplicity 8 -> 9 at [2,2]", dim_o([2,2],12)),
                    ("delete the extremal block [2,2,2,2,2,2]", -dim_o([2,2,2,2,2,2],12))]:
    print("  %-42s sum=%d vs %d -> %s" % (desc, base+delta, tgt,
          "CHECK FIRES" if base+delta != tgt else "check blind"))
