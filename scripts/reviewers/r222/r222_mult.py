"""r222 claim 2a: recompute all 77 multiplicities from the character, my own route.

Independent of the record in two places at once:
  * the weight multiplicity function of Sym^3 is built by CONVOLUTION from the
    weight multiplicities of the CONSTRUCTED 1638-dimensional module in
    weyl12.pkl, so it never reads n12_sym3_char.pkl;
  * the multiplicities are extracted by the Weyl-denominator (Racah/Brauer) sum
        c_lambda = sum_{w in W(D6)} sgn(w) . m(lambda + rho - w rho),
    which is the coefficient of e^{lambda+rho} in (char M).(Weyl denominator).

Then the SAME numbers are recomputed a third way in Sage (r222_mult.sage) from
the abstract Weyl character ring, touching no file in this repo at all.

A PLANTED VIOLATION runs at the end: one weight of the module is given one extra
dimension and the whole pipeline is rerun, to show the comparison can fail.
"""
import pickle, os, sys, time
from collections import defaultdict
from itertools import permutations, product

R = 6
d = os.path.dirname(os.path.abspath(__file__))
D = pickle.load(open(os.path.join(d, "..", "r216", "weyl12.pkl"), "rb"))

def sym3_weights(WD):
    """weight multiplicity function of Sym^3(M) from that of M.
    Sym^3 = (f^3 + 3 f psi^2 f + 2 psi^3 f)/6 with psi^k f = sum m(w) e^{kw}."""
    f = dict(WD)
    def mul(A, B):
        o = defaultdict(int)
        for a, ca in A.items():
            for b, cb in B.items(): o[tuple(x+y for x, y in zip(a, b))] += ca*cb
        return o
    def psi(k):
        return {tuple(k*x for x in w): m for w, m in f.items()}
    f2 = mul(f, f)
    t = mul(f2, f)
    for w, v in mul(f, psi(2)).items(): t[w] += 3*v
    for w, v in psi(3).items(): t[w] += 2*v
    out = {}
    for w, v in t.items():
        if v:
            assert v % 6 == 0, f"Sym^3 coefficient {v} at {w} is not divisible by 6"
            out[w] = v // 6
    return out

RHO = (5, 4, 3, 2, 1, 0)
def weyl_D6():
    """(sgn, rho - w(rho)) for every w in W(D6): signed permutations with an
    EVEN number of sign changes.  sgn(w) = sgn(sigma) since the sign flips
    contribute (-1)^{even} = +1 to the determinant."""
    out = []
    for sigma in permutations(range(R)):
        # sign of the permutation
        seen = [False]*R; s = 1
        for i in range(R):
            if seen[i]: continue
            j, L = i, 0
            while not seen[j]: seen[j] = True; j = sigma[j]; L += 1
            if L % 2 == 0: s = -s
        for eps in product((1, -1), repeat=R):
            if eps.count(-1) % 2: continue
            wr = tuple(eps[i]*RHO[sigma[i]] for i in range(R))
            out.append((s, tuple(RHO[i]-wr[i] for i in range(R))))
    return out

def dominant(w):
    return all(w[i] >= w[i+1] for i in range(R-2)) and w[R-2] >= abs(w[R-1])

def racah(m, WEY):
    """multiplicities of every irreducible in a module with weight function m."""
    out = {}
    for lam in m:
        if not dominant(lam): continue
        c = 0
        for s, sh in WEY:
            v = m.get(tuple(lam[i]+sh[i] for i in range(R)))
            if v: c += s*v
        if c: out[lam] = c
    return out

if __name__ == "__main__":
    t0 = time.time()
    WD = D["WEYL"]
    print(f"module: {len(WD)} weights, dim {sum(WD.values())}")
    WEY = weyl_D6()
    print(f"|W(D6)| = {len(WEY)}   (expected 23040: {len(WEY)==23040})")
    S = sym3_weights(WD)
    n = sum(WD.values())
    print(f"Sym^3: {len(S)} weights, dim {sum(S.values()):,} "
          f"(binom(n+2,3) = {n*(n+1)*(n+2)//6:,}: "
          f"{sum(S.values()) == n*(n+1)*(n+2)//6})")
    print(f"  [{time.time()-t0:.1f}s]")
    C = racah(S, WEY)
    print(f"decomposition: {len(C)} irreducibles, {sum(C.values())} multiplicities "
          f" [{time.time()-t0:.1f}s]")
    neg = {k: v for k, v in C.items() if v < 0}
    print(f"  negative multiplicities: {len(neg)}  (must be 0)")

    BL = pickle.load(open(os.path.join(d, "..", "..", "runs", "n12_sym3_blocks.pkl"), "rb"))
    S3 = pickle.load(open(os.path.join(d, "..", "..", "runs", "n12_sym3_char.pkl"), "rb"))
    bad = [(l, C.get(l), BL.get(l)) for l in set(C) | set(BL) if C.get(l) != BL.get(l)]
    print(f"\nagainst n12_sym3_blocks.pkl: {len(BL)} blocks recorded, "
          f"{len(C)} found, {len(bad)} disagreements")
    for b in bad[:20]: print("   MISMATCH", b)
    badd = [(l, S.get(l), S3.get(l)) for l in set(S) | set(S3) if S.get(l) != S3.get(l)]
    print(f"against n12_sym3_char.pkl: {len(badd)} weight-space disagreements "
          f"over {len(S)} weights")
    for b in badd[:10]: print("   MISMATCH", b)
    print(f"\ntrivial block (0,0,0,0,0,0): multiplicity {C.get((0,)*6)}, "
          f"weight space {S.get((0,)*6):,}")
    # dimension identity: sum m_lambda dim V_lambda = dim Sym^3
    print(f"\nlargest 8 multiplicities: "
          f"{sorted(C.items(), key=lambda kv: -kv[1])[:8]}")

    print("\nPLANTED VIOLATION: give weight (2,2,0,0,0,0) one extra dimension")
    WD2 = dict(WD); WD2[(2,2,0,0,0,0)] += 1
    C2 = racah(sym3_weights(WD2), WEY)
    diff = [(l, C.get(l, 0), C2.get(l, 0)) for l in set(C)|set(C2) if C.get(l,0) != C2.get(l,0)]
    print(f"  multiplicities that move: {len(diff)}  (the check FIRES: "
          f"{len(diff) > 0})")
    print(f"  e.g. {diff[:4]}")
