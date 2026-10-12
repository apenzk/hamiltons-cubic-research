"""P2(ii): the exceptional algebras in the graded enumeration.

For h exceptional acting irreducibly on R^n, the dictionary gives theta from
(p, q, n, C2(adj)/C2(V)) -- but (R1) must be CHECKED against the pair's true
Casimirs, never solved for (the Step-5 lesson).  Casimirs from the index
relation C2(R) = index(R) * dim(g) / dim(R), with index(adj) = 2 h^dual.

Only pairs with SIMPLE isotropy are treated here; the rest need the ideal-wise
route.  c_k for a simple k embedded in h is c_k = c_k^V * C2(adj_k)/C2(V|_k),
which needs branching data, so instead (R1) is used in the direction it can be
used without it: given the pair's (p,q) and c_h^ad, (R1)+the structure-sum
identity determine C and c_k, and the resulting c_k is then tested for
plausibility (a Casimir of a compact algebra must be >= 0, and theta <= sqrt 2).
"""
import numpy as np
SQ2, SQ32 = np.sqrt(2.0), np.sqrt(1.5)

# h : (dim h, n, dual Coxeter, index of V, dim V_real)
EXC = {
    "G2":  dict(dim=14,  hv=4,  idxV=2,  n=7),
    "F4":  dict(dim=52,  hv=9,  idxV=6,  n=26),
    "E6":  dict(dim=78,  hv=12, idxV=6,  n=54),   # 27 complex -> 54 real
    "E7":  dict(dim=133, hv=18, idxV=12, n=56),
    "E8":  dict(dim=248, hv=30, idxV=60, n=248),  # adjoint
}
# symmetric pairs (h, k): (name, dim k, k simple?)
PAIRS = {
    "G2": [("su(2)+su(2)", 6, False)],
    "F4": [("so(9)", 36, True), ("sp(3)+su(2)", 24, False)],
    "E6": [("sp(4)", 36, True), ("su(6)+su(2)", 38, False),
           ("so(10)+u(1)", 46, False), ("F4", 52, True)],
    "E7": [("su(8)", 63, True), ("so(12)+su(2)", 69, False), ("E6+u(1)", 79, False)],
    "E8": [("so(16)", 120, True), ("E7+su(2)", 136, False)],
}

def dict_theta(p, q, n, ratio):
    dh = p + q
    ch = (2.0 * dh / n) * ratio
    den = 2*p*q - p*p + 3*q*q
    if den == 0 or 2*q - p == 0: return None
    C = dh * (q*ch + 2*p) / den
    ck = (C*(2*q - p) - 2*dh) / q
    th = (ck*q*q + 2*q*q + p*p) / ((2*q - p) * np.sqrt(p*q*dh))
    return C, ck, th

print(f"{'pair':<22} {'n':>4} {'p':>4} {'q':>4} {'C':>8} {'c_k':>9} {'theta':>10}  verdict")
print("-"*84)
for h, d in EXC.items():
    dimh, hv, idxV, n = d["dim"], d["hv"], d["idxV"], d["n"]
    C2adj = 2*hv*dimh/dimh
    C2V = idxV*dimh/n
    ratio = C2adj/C2V
    for kname, p, simple in PAIRS[h]:
        q = dimh - p
        r = dict_theta(p, q, n, ratio)
        if r is None:
            print(f"{h+'/'+kname:<22} {n:>4} {p:>4} {q:>4}   degenerate (2q=p)"); continue
        C, ck, th = r
        bad = []
        if ck < -1e-9: bad.append("c_k<0")
        if not (0 < th <= SQ2 + 1e-9): bad.append("theta out of range")
        if 2*q - p <= 0: bad.append("2q<=p")
        verdict = ("REJECTED: " + ",".join(bad)) if bad else (
            "ABOVE sqrt(3/2)" if th > SQ32 else "below sqrt(3/2)")
        tag = "" if simple else "  [k non-simple: dictionary not valid, screen only]"
        print(f"{h+'/'+kname:<22} {n:>4} {p:>4} {q:>4} {C:>8.3f} {ck:>9.3f} {th:>10.5f}  {verdict}{tag}")
print("-"*84)
print(f"sqrt(3/2) = {SQ32:.5f},  ceiling sqrt(2) = {SQ2:.5f}")
