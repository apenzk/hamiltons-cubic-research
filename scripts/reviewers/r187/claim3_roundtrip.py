"""Reviewer 187, claim 3.  What the round trip actually discriminates.

run_n5_extremiser.py separates the undoubled coordinate vector from the doubled
one by a ROUND TRIP: sym2_to_R(vec) must reproduce S entrywise on Lambda^2.
Two questions:
  (a) is that the right discriminator for the encoding?   -- yes, and it has teeth;
  (b) does it pin W_0?                                     -- no.  It is a property
      of the map sym2_to_R, satisfied by the correct encoding of ANY symmetric
      operator on Lambda^2, Weyl or otherwise.  Witnesses below.
"""
from fractions import Fraction as F
import importlib.util, sys, os, random
d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
spec = importlib.util.spec_from_file_location("wm", os.path.join(d, "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(spec)
_o = sys.stdout; sys.stdout = open(os.devnull, "w"); spec.loader.exec_module(wm); sys.stdout = _o
NP, PAIRS, PIDX, SPAIRS = wm.NP, wm.PAIRS, wm.PIDX, wm.SPAIRS

def roundtrip_ok(S):
    vec = {SPAIRS[k]: S[a][b] for k, (a, b) in enumerate(SPAIRS) if S[a][b]}
    R = wm.sym2_to_R(vec)
    return all(R[i][j][k][l] == S[PIDX[(i, j)]][PIDX[(k, l)]]
               for (i, j) in PAIRS for (k, l) in PAIRS)

def weyl_ok(S):
    vec = [S[a][b] for (a, b) in SPAIRS]
    rows = wm.bianchi_rows() + wm.ricci_rows()
    return not any(sum(r[i]*vec[i] for i in range(len(vec))) for r in rows)

def sym_from_vec(v):
    S = [[F(0)]*NP for _ in range(NP)]
    for k, (a, b) in enumerate(SPAIRS): S[a][b] = S[b][a] = v[k]
    return S

def formvec(terms):
    v = [F(0)]*NP
    for (i, j), c in terms:
        for k, cc in wm.wedge(i, j).items(): v[k] += F(c)*cc
    return v

W1 = formvec([((0,1),1), ((2,3),1)])
W2 = formvec([((0,2),1), ((1,3),-1)])
W3 = formvec([((0,3),1), ((1,2),1)])
def rank1_sum(pairs):
    S = [[F(0)]*NP for _ in range(NP)]
    for w, s in pairs:
        nrm = sum(x*x for x in w)
        for a in range(NP):
            for b in range(NP):
                if w[a] and w[b]: S[a][b] += F(s)*w[a]*w[b]/nrm
    return S
S0 = rank1_sum([(W1,2),(W2,-1),(W3,-1)])          # sqrt6 * W_0

print("=== (a) the round trip as an encoding test: does it have teeth? ===")
for name, S in (("sqrt6 W_0 (undoubled)", S0),):
    print(f"  {name}: Weyl {weyl_ok(S)}, round trip {roundtrip_ok(S)}")
# the doubled encoding, and three other mis-encodings
def as_vec(S): return [S[a][b] for (a, b) in SPAIRS]
enc = {
  "doubled off-diagonals": [S0[a][b]*(1 if a == b else 2) for (a, b) in SPAIRS],
  "halved off-diagonals":  [S0[a][b]*(1 if a == b else F(1,2)) for (a, b) in SPAIRS],
  "globally scaled by 2":  [2*S0[a][b] for (a, b) in SPAIRS],
  "correct":               as_vec(S0),
}
print("\n  encoding                 Bianchi+Ricci   round trip")
for k, v in enc.items():
    rows = wm.bianchi_rows() + wm.ricci_rows()
    b = not any(sum(r[i]*v[i] for i in range(len(v))) for r in rows)
    R = wm.sym2_to_R({SPAIRS[j]: c for j, c in enumerate(v) if c})
    rt = all(R[i][j][k][l] == S0[PIDX[(i,j)]][PIDX[(k,l)]]
             for (i,j) in PAIRS for (k,l) in PAIRS)
    print(f"  {k:<24} {str(b):<15} {rt}")
print("  => Bianchi+Ricci is blind to all four; the round trip separates the")
print("     correct encoding from every one of them.  Right discriminator, and")
print("     it fails on three witnesses, so it could have failed.")

print("\n=== (b) does the round trip pin W_0?  No -- other Weyl tensors pass it ===")
# a DIFFERENT Weyl tensor: same construction on a different self-dual frame,
# and a genuinely different spectrum.
alts = {
  "diag(2,-1,-1) on a rotated frame": rank1_sum([
      (formvec([((0,1),1), ((2,4),1)]), 2),
      (formvec([((0,2),1), ((1,4),-1)]), -1),
      (formvec([((0,4),1), ((1,2),1)]), -1)]),
  "spectrum (1,-1,0,...) instead":    rank1_sum([(W1,1), (W2,-1)]),
  "spectrum (3,-2,-1,...)":           rank1_sum([(W1,3), (W2,-2), (W3,-1)]),
}
print("  candidate                              Weyl?   round trip?   tr(S^3)")
for k, S in alts.items():
    tr3 = sum(S[i][a]*S[a][b]*S[b][i] for i in range(NP) for a in range(NP) for b in range(NP))
    print(f"  {k:<38} {str(weyl_ok(S)):<7} {str(roundtrip_ok(S)):<13} {tr3}")
tr3_0 = sum(S0[i][a]*S0[a][b]*S0[b][i] for i in range(NP) for a in range(NP) for b in range(NP))
print(f"  {'sqrt6 W_0 itself':<38} {str(weyl_ok(S0)):<7} {str(roundtrip_ok(S0)):<13} {tr3_0}")
print("\n  Every one of these passes the round trip, and two of them are Weyl with")
print("  a DIFFERENT tr(S^3).  The round trip is a property of sym2_to_R, not of")
print("  W_0: it validates the coordinate convention, and nothing about the")
print("  spectrum.  What pins W_0 in the script is the separate exact spectrum")
print("  (2,-1,-1,0^7) accounting for all 10 of Lambda^2 -- that check CAN fail,")
print("  and it, not the round trip, is what makes tr(W_0^3) = 1/sqrt6 binding.")
