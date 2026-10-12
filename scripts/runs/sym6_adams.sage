# The degree-6 invariant count, via Adams operations in the Weyl character ring.
#
# King's modification rule failed validation three times.  This route avoids it:
# Sym^d is built from the Adams operations psi^k by Newton's identity inside the
# representation ring, where psi^k(chi)(t) = chi(t^k) is again a character of the
# same group.  Nothing is materialised on the weight lattice.
#
# Validated at B2 (n=5) against 1, 1, 4, 5, 14 from Weyl integration, which
# shares no machinery with this, before the D6 answer is reported.
import sys, time

def invariants(ct, V, D):
    """dim (Sym^d V)^G for d = 1..D, by Newton from the Adams operations."""
    one = ct(ct.fundamental_weights()[1] * 0)      # trivial character
    psi = {}
    for k in range(1, D + 1):
        psi[k] = V.adams_operation(k)
        print(f"    psi^{k} built ({len(psi[k].monomial_coefficients())} constituents)",
              flush=True)
    h = {0: one}
    out = []
    for d in range(1, D + 1):
        acc = 0
        for j in range(1, d + 1):
            acc += psi[j] * h[d - j]
        h[d] = acc / d
        out.append(h[d].monomial_coefficients().get(one.support()[0], 0))
        print(f"    Sym^{d}: {len(h[d].monomial_coefficients())} constituents, "
              f"trivial multiplicity {out[-1]}", flush=True)
    return out

print("=== validation at B2, n = 5 ===", flush=True)
B2 = WeylCharacterRing("B2", style="coroots")
W5 = B2(0, 4)                                  # [2,2] = 4 omega_2, dim 35
print(f"  dim = {W5.degree()} (35: {W5.degree() == 35})", flush=True)

# dim 35 does NOT identify the module: V_(2,1) also has dimension 35, and
# reviewer 179 showed the decoy yields 20 blocks / 62 multiplicities / 168
# unknowns.  The Casimir separates them -- c_2(2,2) = 16 against c_2(2,1) = 12 --
# and run_n5_weyl_module.py reaches the same module from the DEFINITION
# (Lambda^2 -> Sym^2 -> Bianchi -> Ricci-traceless) with Casimir 16 exact.
lam = tuple(W5.highest_weight().to_ambient().to_vector()[:2])
assert (int(lam[0]), int(lam[1])) == (2, 2), f"wrong module: highest weight {lam}"
c2_of = lambda l: l[0]*(l[0]+3) + l[1]*(l[1]+1)
assert c2_of((int(lam[0]), int(lam[1]))) == 16, "Casimir is not 16"
print(f"module guarded: highest weight {(int(lam[0]), int(lam[1]))}, dim {W5.degree()}, c2 = 16")

got = invariants(B2, W5, 6)
truth = [0, 1, 1, 4, 5, 14]
print(f"  got   {got}\n  truth {truth}\n  MATCH: {got == truth}", flush=True)
if got != truth:
    print("  VALIDATION FAILED -- no D6 number will be reported.", flush=True)
    sys.exit(1)

print("\n=== D6, n = 12 ===", flush=True)
t0 = time.time()
D6 = WeylCharacterRing("D6", style="coroots")
W12 = D6(0, 2, 0, 0, 0, 0)                     # [2,2] for D6
print(f"  dim = {W12.degree()} (1638: {W12.degree() == 1638})", flush=True)
res = invariants(D6, W12, 6)
print(f"\n  O(12)-invariant dimensions, degrees 1..6: {res}   [{time.time()-t0:.0f}s]",
      flush=True)
print(f"  the record's stable sequence is 1, 2, 7, 19, 89 for degrees 2..6", flush=True)
