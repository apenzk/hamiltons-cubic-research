"""
Reviewer 7 -- Tasks 4 and 5: verify the two quartic polynomials from Jaeger's
2016 thesis (section 3.5, proof of Lemma 3.5.6) whose sign forces the n>=15
(hence, restricted to even n, n>=16) threshold in Theorem A, and attempt to
reconstruct the "quantified slack" claim -- how much the dominant negative
term in each inequality chain would need to be strengthened to push the
threshold down to n=14 or n=12.

Both polynomials were located verbatim in the thesis text (checked directly,
not taken on trust):
    diss_jaeger.txt line 4337:  g(n) = -40n^4 + 588n^3 + 127n^2 - 943n + 573
    diss_jaeger.txt line 4392:  h(n) = -662n^4 + 13111n^3 - 54261n^2 + 98703n - 67311
Both arise as "0 <= [dominant negative term] + [rest]" chains (Case 1 -> g,
Case 2 -> h in the proof of Lemma 3.5.6), and the proof concludes "g(n) < 0
for all n >= 15" (resp. h(n)) via g(15)<0, g'(15)<0, g''(n)<=0 for n>=8 (resp.
h(15)<0, h'(15)<0, h''(n)<=0 for n>=9), i.e. g and h are eventually concave
and already decreasing at n=15, hence negative for all n>=15.

This script re-derives everything about these two polynomials from scratch
with sympy: exact/numeric roots, the concavity argument, and the sign table
at n=12,13,14,15,16. It also reconstructs the dominant-negative-term /
"rest" split exactly as it appears in the thesis text (quoted above) and
computes, for each of g and h, the multiplicative strengthening factor f
needed on the dominant term alone to make the (still valid, still an upper
bound) inequality negative already at n=12 and n=14.
"""
import sympy as sp

n = sp.symbols("n", real=True)

g = -40 * n**4 + 588 * n**3 + 127 * n**2 - 943 * n + 573
h = -662 * n**4 + 13111 * n**3 - 54261 * n**2 + 98703 * n - 67311

print("=== Task 4: roots and sign table of g(n), h(n) ===\n")

for name, poly in [("g", g), ("h", h)]:
    print(f"--- {name}(n) = {sp.expand(poly)} ---")
    roots = sp.solve(sp.Eq(poly, 0), n)
    # sympy's symbolic .is_real often returns None on these deeply-nested
    # cubic-formula radicals even when the root is genuinely real; classify
    # numerically instead (evaluate to high precision, check |Im| ~ 0).
    numeric_roots = [complex(r.evalf(30)) for r in roots]
    real_roots = sorted([r.real for r in numeric_roots if abs(r.imag) < 1e-15])
    print("  exact roots (sympy solve), numerically evaluated:")
    for r in numeric_roots:
        print(f"    {r}")
    print(f"  real roots, numeric: {real_roots}")
    largest_real_root = float(real_roots[-1])
    print(f"  largest real root ~= {largest_real_root:.6f}")

    # cross-check with numpy.roots on the raw coefficient list, fully
    # independent code path from sympy's algebraic solver
    import numpy as np
    coeffs = [float(sp.Poly(poly, n).coeff_monomial(n**k)) for k in range(4, -1, -1)]
    np_roots = np.roots(coeffs)
    np_real = sorted([r.real for r in np_roots if abs(r.imag) < 1e-8])
    print(f"  numpy.roots cross-check, real roots: {np_real}")
    print(f"  numpy largest real root: {np_real[-1]:.6f}  "
          f"(sympy vs numpy diff: {abs(np_real[-1]-largest_real_root):.2e})")

    # second derivative concavity claim
    pp = sp.diff(poly, n, 2)
    print(f"  {name}''(n) = {sp.expand(pp)}")
    # find where pp <= 0
    pp_roots = sp.solve(sp.Eq(pp, 0), n)
    pp_roots_real = sorted([float(r) for r in pp_roots if r.is_real])
    print(f"  {name}''(n) roots: {pp_roots_real}  "
          f"(should be concave, i.e. {name}''<=0, for n beyond the larger root)")

    print("  sign table at n=12,13,14,15,16,17:")
    for nv in [12, 13, 14, 15, 16, 17]:
        val = float(poly.subs(n, nv))
        print(f"    {name}({nv}) = {val:.6f}   sign={'NEG' if val<0 else 'POS'}")

    # verify thesis's own printed values at n=15
    val15 = float(poly.subs(n, 15))
    d15 = float(sp.diff(poly, n).subs(n, 15))
    print(f"  {name}(15) = {val15:.6f}   {name}'(15) = {d15:.6f}")
    print()

print("=== cross-check against thesis's own stated numeric values ===")
print("thesis states: g(15) = -25497, g'(15) = -140233")
print(f"  computed:     g(15) = {float(g.subs(n,15))}, g'(15) = {float(sp.diff(g,n).subs(n,15))}")
print("thesis states: h(15) = -59616, h'(15) = -1616202")
print(f"  computed:     h(15) = {float(h.subs(n,15))}, h'(15) = {float(sp.diff(h,n).subs(n,15))}")
print()
print("thesis states g''(n) = -480n^2+3528n+254 <= 0 for n>=8")
gpp = sp.expand(sp.diff(g, n, 2))
print(f"  computed g''(n) = {gpp}")
print(f"  g''(8) = {float(gpp.subs(n,8))}  (should be <=0)")
print("thesis states h''(n) = -7944n^2+78666n-108522 <= 0 for n>=9")
hpp = sp.expand(sp.diff(h, n, 2))
print(f"  computed h''(n) = {hpp}")
print(f"  h''(9) = {float(hpp.subs(n,9))}  (should be <=0)")

print()
print("=== Task 5: quantified slack -- how much would the dominant negative")
print("    term need to be strengthened to reach n=14 or n=12? ===\n")

# --- g(n): dominant term is -5(n-1)^2(n+1)(8n-9), rest is everything else,
# reconstructed exactly from the thesis's own pre-multiplication display
# (line 4334-4337): 0 <= -5(n-1)^2(n+1)(8n-9) + 22(n-1)(n^2+15n-24)
#                        + 176 n^2 (n-1) + 305 n^3
dominant_g = -5 * (n - 1) ** 2 * (n + 1) * (8 * n - 9)
rest_g = 22 * (n - 1) * (n**2 + 15 * n - 24) + 176 * n**2 * (n - 1) + 305 * n**3
check_g = sp.expand(dominant_g + rest_g - g)
print(f"reconstruction check: dominant_g + rest_g - g(n) = {check_g}  (should be 0)")

# --- h(n): dominant term is -273(n-3)^3(4n-9), rest is everything else,
# reconstructed exactly from the thesis's own pre-multiplication display
# (line 4388-4392): 0 <= -273(n-3)^3(4n-9) + 36(n-1)(n^3+17n^2-53n+27)
#                        + 144n^2(n^2-1) + 250n^3(n+1)
dominant_h = -273 * (n - 3) ** 3 * (4 * n - 9)
rest_h = (36 * (n - 1) * (n**3 + 17 * n**2 - 53 * n + 27)
          + 144 * n**2 * (n**2 - 1) + 250 * n**3 * (n + 1))
check_h = sp.expand(dominant_h + rest_h - h)
print(f"reconstruction check: dominant_h + rest_h - h(n) = {check_h}  (should be 0)")
print()

for name, dom, rest, target_ns in [("g", dominant_g, rest_g, [14, 12]),
                                    ("h", dominant_h, rest_h, [14, 12])]:
    print(f"--- {name}: dominant term = {sp.factor(dom)} ---")
    for nv in target_ns:
        dom_v = float(dom.subs(n, nv))
        rest_v = float(rest.subs(n, nv))
        # want f * dom_v + rest_v <= 0, dom_v < 0, so f >= -rest_v/dom_v = rest_v/|dom_v|
        f_needed = -rest_v / dom_v
        pct = (f_needed - 1) * 100
        print(f"    n={nv}: dominant={dom_v:.2f}, rest={rest_v:.2f}, "
              f"factor f needed = {f_needed:.6f}  ({pct:+.2f}% strengthening)")
    print()
