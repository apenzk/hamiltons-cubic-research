"""Reviewer 187, claim 1.  The shipped validation is a SUM over beta, so it is
blind to any redistribution of mass among the beta's.  Two explicit witnesses,
then a replacement check that pins every beta individually.
"""
import sys, os, random, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import WI, coeff, coeff_sym, ep

P, K, N = 10007, 6, 5

def true_coeffs(A, B, m):
    return [coeff([A, B], [d, 6-d], m, K, P) for d in range(7)]

# ---------------- two wrong "coefficient rules" -----------------------------
def rule_swap(c):        # swap coeff(2,4) <-> coeff(4,2), and (1,5) <-> (5,1)
    d = list(c); d[2], d[4] = d[4], d[2]; d[1], d[5] = d[5], d[1]; return d
def rule_reverse(c):     # beta -> reversed beta everywhere
    return list(reversed(c))
def rule_shift(c):       # move a unit of mass from beta=(2,4) to beta=(4,2)
    d = list(c); d[2] = (d[2]-1) % P; d[4] = (d[4]+1) % P; return d

def main():
    rng = np.random.default_rng(11); pyrng = random.Random(11)
    A = WI.random_weyl(N, P, rng); B = WI.random_weyl(N, P, rng)
    mats = [WI.random_matching(K, pyrng) for _ in range(6)]

    print("=" * 74)
    print("A. THE SHIPPED CHECK, and three rules that pass it")
    print("=" * 74)
    hdr = f"{'matching':>8} | {'shipped':>7} | {'swap':>7} | {'reverse':>7} | {'shift':>7}"
    print(hdr); print("-" * len(hdr))
    tally = {k: 0 for k in ("shipped", "swap", "reverse", "shift")}
    differs = {k: 0 for k in ("swap", "reverse", "shift")}
    for i, m in enumerate(mats):
        c = true_coeffs(A, B, m)
        tgt = WI.eval_diagram((A + B) % P, m, K, P) % P
        rules = {"shipped": c, "swap": rule_swap(c),
                 "reverse": rule_reverse(c), "shift": rule_shift(c)}
        row = [f"{i:>8}"]
        for k in ("shipped", "swap", "reverse", "shift"):
            ok = sum(rules[k]) % P == tgt
            tally[k] += ok
            row.append(f"{'PASS' if ok else 'FAIL':>7}")
            if k != "shipped" and rules[k] != c: differs[k] += 1
        print(" | ".join(row))
    print("-" * len(hdr))
    print(" totals  | " + " | ".join(f"{tally[k]}/6".rjust(7)
                                     for k in ("shipped", "swap", "reverse", "shift")))
    print(f"\n  the three rules genuinely DIFFER from the shipped one on "
          f"{differs['swap']}/6, {differs['reverse']}/6, {differs['shift']}/6 matchings")
    print("  => the shipped validation cannot distinguish them.  It tests one linear")
    print("     functional of the seven coefficients, and there are seven unknowns.")

    print()
    print("=" * 74)
    print("B. THE SHIPPED 'TEETH' TEST does not catch a redistribution either")
    print("=" * 74)
    print("  the teeth test replaces the whole map (vertex-ordered eval_polarised).")
    print("  A redistribution keeps the sum, so it survives the teeth test verbatim:")
    for i, m in enumerate(mats[:3]):
        c = true_coeffs(A, B, m)
        tgt = WI.eval_diagram((A + B) % P, m, K, P) % P
        vo = sum(ep([A]*d + [B]*(6-d), m, P) for d in range(7)) % P
        print(f"    matching {i}: vertex-ordered sum {vo:5d} != {tgt:5d} (caught)"
              f" | swap sum {sum(rule_swap(c)) % P:5d} == {tgt:5d} (NOT caught)")

    print()
    print("=" * 74)
    print("C. THE REPLACEMENT: one t-parametrised identity pins all seven")
    print("=" * 74)
    print("  J(t*A + B) = sum_d coeff(d, 6-d) * t^d  for every t in F_p.")
    print("  Seven distinct t give a Vandermonde system of full rank, so the identity")
    print("  holding at t=1..7 forces every individual coefficient.")
    ts = list(range(1, 8))
    ok_all = 0; caught = {k: 0 for k in ("swap", "reverse", "shift")}
    for i, m in enumerate(mats):
        c = true_coeffs(A, B, m)
        tv = [WI.eval_diagram((t*A + B) % P, m, K, P) % P for t in ts]
        def passes(cc):
            return all(sum(cc[d]*pow(t, d, P) for d in range(7)) % P == v
                       for t, v in zip(ts, tv))
        ok_all += passes(c)
        for k, cc in (("swap", rule_swap(c)), ("reverse", rule_reverse(c)),
                      ("shift", rule_shift(c))):
            caught[k] += (not passes(cc))
    print(f"    shipped coefficients pass: {ok_all}/6")
    print(f"    swap    rejected: {caught['swap']}/6")
    print(f"    reverse rejected: {caught['reverse']}/6")
    print(f"    shift   rejected: {caught['shift']}/6   <- a 1-unit perturbation is caught")

    print()
    print("=" * 74)
    print("D. THE SECOND REPLACEMENT: homogeneity pins each beta on its own")
    print("=" * 74)
    print("  coeff(beta; sA, uB) = s^beta0 u^beta1 coeff(beta; A, B) -- one equation")
    print("  per beta, no sum anywhere.")
    ok = tot = 0
    for m in mats[:3]:
        for (s, u) in [(2, 3), (5, 7), (11, 4)]:
            for d in range(7):
                lhs = coeff([(s*A) % P, (u*B) % P], [d, 6-d], m, K, P)
                rhs = pow(s, d, P) * pow(u, 6-d, P) % P * coeff([A, B], [d, 6-d], m, K, P) % P
                ok += (lhs == rhs); tot += 1
    print(f"    individually-scaled coefficients agree: {ok}/{tot}")
    print("    (a swap of beta=(2,4) with (4,2) breaks this: s^2 u^4 != s^4 u^2)")
    # show it fails for the swapped rule
    m = mats[0]; s, u = 2, 3
    c_scaled = [coeff([(s*A) % P, (u*B) % P], [d, 6-d], m, K, P) for d in range(7)]
    c_base = true_coeffs(A, B, m)
    pred_swap = [pow(s, d, P)*pow(u, 6-d, P) % P * rule_swap(c_base)[d] % P for d in range(7)]
    print(f"    swap rule predicts {pred_swap[:3]}... vs truth {c_scaled[:3]}...  -> "
          f"{'REJECTED' if pred_swap != c_scaled else 'passes'}")

# ---------------------------------------------------------------------------
def main_E():
    """E.  run_n5_coefficient.py was patched MID-REVIEW with ONE weighted
    identity at (s1,s2) = (3,5).  Two linear functionals on seven unknowns still
    leave a 5-dimensional space of redistributions.  Explicit witness."""
    rng = np.random.default_rng(11); pyrng = random.Random(11)
    A = WI.random_weyl(N, P, rng); B = WI.random_weyl(N, P, rng)
    mats = [WI.random_matching(K, pyrng) for _ in range(6)]
    s1, s2 = 3, 5
    # delta with sum(delta) = 0 and sum(delta_d s1^d s2^{6-d}) = 0
    w0 = [1]*7
    w1 = [pow(s1, d, P)*pow(s2, 6-d, P) % P for d in range(7)]
    # solve the 2 x 7 system, take a nonzero kernel vector supported on d=0,1,2
    a0, a1 = w0[0], w1[0]; b0, b1 = w0[1], w1[1]; c0, c1 = w0[2], w1[2]
    # delta = (u, v, 1, 0,0,0,0):  u*a0 + v*b0 + c0 = 0,  u*a1 + v*b1 + c1 = 0
    det = (a0*b1 - a1*b0) % P
    u = (-c0*b1 + c1*b0) * pow(det, P-2, P) % P
    v = (-a0*c1 + a1*c0) * pow(det, P-2, P) % P
    delta = [u, v, 1, 0, 0, 0, 0]
    assert sum(delta) % P == 0 and sum(delta[d]*w1[d] for d in range(7)) % P == 0
    print()
    print("=" * 74)
    print("E. THE PATCH SHIPPED MID-REVIEW IS STILL NOT ENOUGH")
    print("=" * 74)
    print(f"  witness delta = {delta} added to (coeff(0,6)..coeff(6,0)):")
    print(f"    sum(delta) = 0 and sum(delta_d * 3^d 5^(6-d)) = 0, so BOTH shipped")
    print(f"    identities survive it, while three of the seven coefficients move.")
    okp = okw = ok7 = 0
    for m in mats:
        c = true_coeffs(A, B, m)
        cb = [(c[d] + delta[d]) % P for d in range(7)]
        okp += (sum(cb) % P == WI.eval_diagram((A + B) % P, m, K, P) % P)
        lhs = sum(cb[d]*w1[d] for d in range(7)) % P
        okw += (lhs == WI.eval_diagram((s1*A + s2*B) % P, m, K, P) % P)
        ts = list(range(1, 8))
        ok7 += all(sum(cb[d]*pow(t, d, P)*pow(1, 6-d, P) for d in range(7)) % P
                   == WI.eval_diagram((t*A + B) % P, m, K, P) % P for t in ts)
    print(f"    plain sum identity:            {okp}/6 PASS  <- blind")
    print(f"    weighted identity at (3,5):    {okw}/6 PASS  <- still blind")
    print(f"    seven values of t (my check C): {ok7}/6 PASS  <- catches it")
    print("  => the fix is SEVEN independent weightings, not one.  Seven distinct")
    print("     t give a 7x7 Vandermonde of full rank, and nothing else does.")

if __name__ == "__main__":
    main()
    main_E()
