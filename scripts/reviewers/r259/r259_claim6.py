"""r259 -- claim 6, option (b)'s dependency audit, and claim 1's leg count.

Three things are checked against the record rather than against the audit's summary
of it.

(1) THE AUDIT'S ASSERTS.  run_b_dependency_audit.py says it "checks the two
    arithmetic facts the audit turns on".  Both are computed from hard-coded
    constants, so both are constant-folded; the third is an algebraic identity true
    for every n >= 1.  Shown here by running each on the inputs that would have to
    change for it to fire.

(2) r244's WITNESS, EXACTLY.  S_n = [1/n - 1/n^2, 1/n + 1/n^2].  The audit reads it
    as showing the fallback is rational "regardless", and concludes the constant-t
    question is skippable.  What the witness actually decides is computed here: the
    intersection over the route's own range.

(3) THE LEG COUNT.  Lehrer-Zhang 3.4's basis half is about the O(V)-INVARIANTS on
    (V^{tensor 2r})^*, i.e. the lambda = empty block.  A covariant into a block of
    label lambda is a map V^{tensor 12} -> V_lambda; pairing against V_lambda, which
    sits inside V^{tensor |lambda|}, makes it an invariant functional on
    V^{tensor (12+|lambda|)}, so the r that Theorem 3.4 needs is 6 + |lambda|/2, not
    6.  The largest lambda in V^{tensor 12} has 12 boxes, giving r = 12.
"""
from fractions import Fraction as F


def conj(lam):
    return tuple(sum(1 for p in lam if p > k) for k in range(lam[0])) if lam else ()


def admissible(lam, n):
    c = conj(lam)
    return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0) <= n


def neighbours(lam):
    out = []
    for k in range(len(lam) + 1):
        new = list(lam) + [0]
        new[k] += 1
        if all(new[t] >= new[t + 1] for t in range(len(new) - 1)):
            out.append(tuple(x for x in new if x))
    for k in range(len(lam)):
        new = list(lam)
        new[k] -= 1
        if new[k] >= 0 and all(new[t] >= new[t + 1] for t in range(len(new) - 1)):
            out.append(tuple(x for x in new if x))
    return out


def updown(m):
    cur = {(): 1}
    for _ in range(m):
        nxt = {}
        for lam, c in cur.items():
            for mu in neighbours(lam):
                nxt[mu] = nxt.get(mu, 0) + c
        cur = nxt
    return cur


print("=" * 84)
print("(1)  can the audit's asserts fire?")
print("=" * 84)
DEGREE, LEGS = 3, 4
two_r = DEGREE * LEGS
r = two_r // 2
print(f"  DEGREE and LEGS_PER_WEYL are literals; two_r = {two_r}, r = {r} follow.")
print(f"    assert two_r % 2 == 0  ->  {two_r % 2 == 0}   (12 % 2, a constant)")
print(f"    assert r <= 12         ->  {r <= 12}   (6 <= 12, a constant)")
print(f"    assert r <= 6          ->  {r <= 6}   (6 <= 6, a constant)")
print("  Neither depends on n, on the covariants, or on anything measured.  The")
print("  message on the last one -- 'independence would fail somewhere in [6, 12]'")
print("  -- describes a state that no input to this file can produce.")
print("  The loop prints 'r <= n is X -> diagrams are a basis: X', the same")
print("  boolean twice, at n = 6, 12, 24 where it is True by the same constant.")
print()
print("  The third check, assert lo < 1/n < hi with lo = 1/n - 1/n^2:")
for n in (2, 3, 12, 10 ** 6):
    lo, hi = F(1, n) - F(1, n * n), F(1, n) + F(1, n * n)
    print(f"    n={n:>8}: lo < 1/n < hi is {lo < F(1,n) < hi}"
          f"   because 1/n^2 = {F(1,n*n)} > 0")
print("  True for every n >= 1 by 1/n^2 > 0.  It restates the definition of lo, hi.")

print()
print("=" * 84)
print("(2)  what r244's witness decides -- exactly, over the route's own range")
print("=" * 84)
print("  S_n = [ (n-1)/n^2 , (n+1)/n^2 ], from det B(t;n) >= 0 in r244 R2.\n")
lo = {n: F(n - 1, n * n) for n in range(12, 41, 2)}
hi = {n: F(n + 1, n * n) for n in range(12, 41, 2)}
for n in (12, 14, 16, 18, 20):
    print(f"    n={n:>3}   S_n = [{lo[n]}, {hi[n]}] = "
          f"[{float(lo[n]):.6f}, {float(hi[n]):.6f}]   1/n in S_n: "
          f"{lo[n] < F(1,n) < hi[n]}")
L = max(lo.values())
H = min(hi.values())
print(f"\n  over even n in [12, 40]:  max lower end = {L} ({float(L):.6f}),"
       f"  min upper end = {H} ({float(H):.6f})")
print(f"  intersection nonempty: {L <= H}")
print(f"  already empty on the pair n = 12, 16:  "
      f"{not (max(lo[12], lo[16]) <= min(hi[12], hi[16]))}"
      f"   ({float(lo[12]):.6f} > {float(hi[16]):.6f})")
print("\n  So the witness kills a CONSTANT t as well as a polynomial one, and it")
print("  does so with two dimensions.  What it does NOT do is decide the real")
print("  instance: it is a 2x2 family 'of A2's exact shape', not A2 itself.")
print("  r244's own R1 says the constant-t question is finite convex feasibility")
print("  and that conceding it is PREMATURE; the audit cites r244 for the")
print("  opposite reading.")

print()
print("=" * 84)
print("(3)  which r Theorem 3.4 needs for a covariant into a block of label lambda")
print("=" * 84)
ud = updown(12)
sizes = sorted({sum(lam) for lam in ud})
print("  |lambda| for the blocks of V^{tensor 12}:", sizes)
print("  a covariant into V_lambda is an invariant functional on "
      "V^{tensor (12+|lambda|)},")
print("  so 2r = 12 + |lambda| and r = 6 + |lambda|/2:\n")
print("   |lambda|    r    r <= n at n=6    r <= n at n=12")
for k in sizes:
    rr = 6 + k // 2
    print(f"     {k:>3}     {rr:>3}        {str(rr <= 6):>5}            {str(rr <= 12):>5}")
print("\n  r = 6 is the lambda = empty (invariant) row alone.  The record's 'r = 6,")
print("  six dimensions of slack' and 'independence holds for every n >= 6' are")
print("  statements about that one row.")
print("\n  And the blocks themselves do not survive to n = 6.  Of the labels of")
print("  V^{tensor 12}:")
for n in (6, 10, 11, 12):
    keep = [lam for lam in ud if admissible(lam, n)]
    print(f"    n={n:>3}:  {len(keep):>3} of {len(ud)} labels admissible"
          f"   (dropped: {len(ud) - len(keep)})")
