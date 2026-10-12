"""r262 claim 4(c) -- is the RESTRICTED up-down count the true O(n) multiplicity?

Two independent tests the up-down recursion knows nothing about:
  1. sum_lambda m_lambda(n) * dim V_lambda^{O(n)} = n^f, with dim V from the
     El Samra - King hook formula.  This is the completeness of the isotypic
     decomposition of V^{tensor f}, and it FAILS if any multiplicity is wrong or
     if a self-associate label needs doubling.
  2. sum_lambda m_lambda(n)^2 against the exact Gram rank (r262_gram.py).

It also prints, for each (f,n), the labels with lam'_1 = n/2 -- the self-associate
row, where V_lambda tensor det = V_lambda and the SO(n) restriction splits in two.
If a doubling were owed anywhere it would be owed there, and test 1 localises it.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r262_gram import restricted_updown, dim_O, conj, admissible, gram_rank

print("== test 1:  sum_lambda m_lambda(n) * dim V_lambda == n^f ==")
print(f"  {'f':>2} {'n':>2} {'sum m*dimV':>12} {'n^f':>10} {'ok':>6} {'#labels':>8}  self-associate labels (lam'_1 = n/2)")
allok = True
for f in range(1, 9):
    for n in range(1, 10):
        m = restricted_updown(f, n)
        tot = sum(c * dim_O(lam, n) for lam, c in m.items())
        ok = (tot == n**f)
        allok &= ok
        sa = [lam for lam in m if conj(lam) and 2*conj(lam)[0] == n]
        print(f"  {f:>2} {n:>2} {str(tot):>12} {n**f:>10} {str(ok):>6} {len(m):>8}  {sa if sa else ''}")
    print()
print(f"  ALL PAIRS OK: {allok}")

print("\n== test 2:  sum m_lambda(n)^2 against the EXACT Gram rank ==")
print(f"  {'f':>2} {'n':>2} {'sum m^2':>9} {'exact rank[n^loops]':>20} {'agree':>6}")
for f in (2, 3, 4):
    for n in range(1, 7):
        uni = sum(c*c for c in restricted_updown(f, n).values())
        g, N = gram_rank(f, n, exact=True)
        print(f"  {f:>2} {n:>2} {uni:>9} {g:>20} {str(uni==g):>6}")
