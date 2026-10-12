"""C1: are the P_i genuinely highest-weight covariants of the stated weight?

Independent of how the cache was built: act on W by an explicit SO(5) matrix over
F_p and compare P_i(gW) with the character prediction.  A wrong monomial
convention (e.g. multinomial multiplicity factors applied or omitted wrongly)
breaks this.
"""
import sys, os, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "r179"))
import core, weyl_invariants as WI
p = core.P

rng = np.random.default_rng(7)
W = WI.random_weyl(5, p, rng)
P0 = core.allP(W)
print(f"nonzero covariant values at the sample: {sum(1 for x in P0 if x!=(0,0))}/{core.NV}")

# --- torus: rotation in the (0,1) plane by zeta, and in the (2,3) plane ---
for (plane, comp, name) in (((0,1), 0, "H1 / lambda_1"), ((2,3), 1, "H2 / lambda_2")):
    zeta = 5   # a generic element of F_p^*
    g = core.plane_rot(zeta, *plane)
    Pg = core.allP(core.act(g, W))
    okp = okm = 0
    for idx, (lam, k) in enumerate(core.COV):
        e = lam[comp]
        pred_p = core.gmul((pow(zeta, e, p), 0), P0[idx])
        pred_m = core.gmul((pow(zeta, (-e) % (p-1), p), 0), P0[idx])
        okp += (Pg[idx] == pred_p); okm += (Pg[idx] == pred_m)
    print(f"  plane {plane}: P_i(gW) = zeta^(+lam) P_i(W) for {okp}/{core.NV};"
          f"  zeta^(-lam) for {okm}/{core.NV}")

# --- full group: only the trivial block should be invariant ---
inv_count = {}
gs = [core.cayley_so5(np.random.default_rng(200+t)) for t in range(4)]
Ws = [W] + [WI.random_weyl(5, p, np.random.default_rng(300+t)) for t in range(2)]
for lam in core.BL:
    m = len(core.HW2[lam])
    allinv = True
    for Wx in Ws:
        Px = [core.Pval(u, core.omegas(Wx)) for u in core.HW2[lam]]
        for g in gs:
            Pgx = [core.Pval(u, core.omegas(core.act(g, Wx))) for u in core.HW2[lam]]
            if Pgx != Px: allinv = False
    inv_count[lam] = allinv
print("\n  blocks whose covariants are pointwise SO(5)-invariant:",
      [l for l, v in inv_count.items() if v])
print("  blocks that are not:", sum(1 for v in inv_count.values() if not v), "of", len(core.BL))

# --- is the trivial covariant proportional to tr(W^3)? ---
lam0 = (0, 0)
rats = []
for t in range(6):
    Wx = WI.random_weyl(5, p, np.random.default_rng(400+t))
    P1 = core.Pval(core.HW2[lam0][0], core.omegas(Wx))
    t3 = core.tr3(Wx)
    rats.append((P1, t3, (P1[0]*pow(t3, p-2, p)) % p, P1[1]))
print("\n  trivial-block covariant vs tr(W^3):")
for r in rats:
    print(f"    P_1 = {r[0]},  tr3 = {r[1]},  Re(P_1)/tr3 = {r[2]},  Im(P_1) = {r[3]}")
print(f"  constant ratio across samples: {len(set(r[2] for r in rats))==1}, "
      f"purely real: {all(r[3]==0 for r in rats)}")
