"""M6: does 'ten distinct joint Casimir eigenvalues' establish irreducibility?
   Casimir values predicted from Young labels, and commutant tests inside each block."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r34_core import struct, weyl_basis, idempotent, Le_matrix
from review_r34_casimir import machinery, blocks
from review_r34_summands import commutant_dim
from review_r34_m37 import rep_on_weyl

# SO(m) Casimir c(lambda) = sum lambda_i (lambda_i + m - 2i), normalised so vector -> m-1
def cas(lmbda, m):
    return sum(li*(li + m - 2*(i+1)) for i, li in enumerate(lmbda))

def predicted_table(p, q):
    W = lambda m: m*(m+1)*(m+2)*(m-3)//12
    s = lambda m: (m+2)*(m-1)//2
    c = lambda m: m*(m-1)//2
    X = lambda m: m*(m*m-4)//3
    T = [("<W>",            (0,0),                          1),
         ("Weyl_p",         (cas([2,2],p), 0),              W(p)),
         ("Weyl_q",         (0, cas([2,2],q)),              W(q)),
         ("R^p (x) R^q",    (cas([1],p), cas([1],q)),       p*q),
         ("S2_0(p)",        (cas([2],p), 0),                s(p)),
         ("S2_0(q)",        (0, cas([2],q)),                s(q)),
         ("S2_0 (x) S2_0",  (cas([2],p), cas([2],q)),       s(p)*s(q)),
         ("L2 (x) L2",      (cas([1,1],p), cas([1,1],q)),   c(p)*c(q)),
         ("X_p (x) R^q",    (cas([2,1],p), cas([1],q)),     X(p)*q),
         ("X_q (x) R^p",    (cas([1],p), cas([2,1],q)),     X(q)*p)]
    return [t for t in T if t[2] > 0]

print("=== joint Casimir labels from Young diagrams: coincidences over p,q >= 3 ===")
hits = []
for p in range(3, 26):
    for q in range(p, 26):
        T = predicted_table(p, q)
        seen = {}
        for name, lab, d in T:
            seen.setdefault(lab, []).append(name)
        for lab, names in seen.items():
            if len(names) > 1:
                hits.append((p, q, lab, names))
print(f"  coincidences found for 3<=p<=q<=25: {hits}")

print()
print("=== measured joint-Casimir block counts vs the Young-label prediction ===")
for (p, q) in [(3,3),(3,4),(3,5),(3,6),(4,4),(4,5),(4,6),(5,5),(5,6)]:
    CP, CQ, RP, RQ, B, D, n = machinery(p, q)
    labs, Vs = blocks([CP, CQ], D)
    T = predicted_table(p, q)
    distinct_pred = len({lab for _, lab, _ in T})
    # scale: measured Casimir of the vector-type block vs predicted; find the scale factor
    meas = sorted([(V.shape[1], lab) for lab, V in zip(labs, Vs)])
    print(f"  ({p},{q}): measured blocks {len(labs):2d}   predicted distinct labels {distinct_pred:2d}   "
          f"summands {len(T):2d}   {'OK' if len(labs)==distinct_pred else 'MISMATCH'}")
    # dimension multiset check
    pd = sorted(d for _, _, d in T)
    agg = {}
    for name, lab, d in T: agg[lab] = agg.get(lab, 0)+d
    if sorted(agg.values()) != sorted(v.shape[1] for v in Vs):
        print(f"      dims measured {sorted(v.shape[1] for v in Vs)}")
        print(f"      dims predicted{sorted(agg.values())}")

print()
print("=== is a Casimir eigenspace irreducible?  commutant of each block ===")
for (p, q) in [(3,3),(4,4),(3,5),(5,5)]:
    CP, CQ, RP, RQ, B, D, n = machinery(p, q)
    prs, _, C = struct(n); N = len(prs)
    Bf = B.reshape(D, N*N)
    def gen(a):
        A = C[a]
        out = np.einsum('mn,dnk->dmk', A, B) - np.einsum('dmn,nk->dmk', B, A)
        return Bf @ out.reshape(D, N*N).T
    gens = [gen(a) for a, (i, j) in enumerate(prs) if j < p or i >= p]
    labs, Vs = blocks([CP, CQ], D)
    print(f"  ({p},{q}):")
    for lab, V in sorted(zip(labs, Vs), key=lambda t: -t[1].shape[1]):
        d = V.shape[1]
        if d > 45:
            print(f"     block dim {d:4d}  (commutant skipped, too large)")
            continue
        cso = commutant_dim(V, gens)
        co = commutant_dim(V, gens, extra=(RP, RQ))
        flag = "" if (cso == 1 and co == 1) else "   <-- NOT SO-irreducible" if cso > 1 else ""
        print(f"     block dim {d:4d}  dim Comm_SO = {cso}  dim Comm_O = {co}{flag}")
