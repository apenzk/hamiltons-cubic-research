"""The equality case of the salvage bound theta <= lambda_min + (n-2)lambda_max, derived then checked.

THE DERIVATION THIS TESTS.  The bound comes from the eigenbasis identity at v = a unit
lambda_min eigenvector,

    <v, W# v> = (1/2) sum_{a,b} lambda_a lambda_b c_{1ab}^2,   sum c_{1ab}^2 = 2(n-2),

by replacing every product lambda_a lambda_b with its minimum over the spectrum,
lambda_min lambda_max, and using the fixed mass:

    <v,W# v> >= (n-2) lambda_min lambda_max,
    theta = lambda_min + <v,W# v>/lambda_min <= lambda_min + (n-2) lambda_max

(the division flips because lambda_min < 0).  So EQUALITY HOLDS IFF EVERY PAIR (a,b)
CARRYING BRACKET MASS FROM v HAS {lambda_a, lambda_b} = {lambda_min, lambda_max}: ad(v)
must send E_max into E_min and annihilate everything else.

WHAT THAT PREDICTS, AND WHY IT MATTERS.  At a two-eigenvalue point of Lemma 23's
subalgebra family, W = Pi_h - (r/N)I has lambda_max = 1-r/N on h and lambda_min = -r/N on
m = h^perp, so v lies in m.  The (a,b) both-in-h mass is <v,[h,h]> = 0 automatically since
[h,h] <= h _|_ m.  So equality reduces to ONE condition: v _|_ [m,m]_m, i.e. the m x m
block vanishes -- which holds when h is a SYMMETRIC-PAIR subalgebra ([m,m] <= h) and fails
for a maximal torus, where root brackets [g_al, g_be] <= g_{al+be} land back in m.

  PREDICTION: the salvage bound saturates at balanced sphere products AND at every
  symmetric-pair two-eigenvalue point, and is STRICTLY SLACK at maximal tori and at the
  ad(su(3)) point.

THAT IS THE TEST THE RECORD OWES.  Post 40's correction (i) refuted "saturated exactly at
the balanced sphere products" for the lambda-weighted bound: it saturates on the WHOLE
subalgebra family, six of eight saturations being ungraded.  The salvage bound's claimed
separation of balanced from unbalanced products is new only if it survives the same
population.  A slack of zero at a maximal torus would make it the same artefact again.
"""
import sys
import numpy as np

sys.path.insert(0, 'scripts/reviewers/r319')
import build, core


def report(name, n, W, A):
    W = build.unit(W)
    th = A.P3(W)
    res = float(np.linalg.norm(A.Q(W) - th * W))
    ev = np.linalg.eigvalsh(W)
    lmin, lmax = float(ev[0]), float(ev[-1])
    bound = lmin + (n - 2) * lmax
    slack = bound - th
    tag = "SATURATED" if abs(slack) < 1e-8 else ("VIOLATED" if slack < -1e-8 else "")
    print(f"  {name:26s} n={n:3d} theta={th:11.9f} res={res:.0e}  lmin={lmin:9.6f} "
          f"lmax={lmax:9.6f}  bound={bound:11.6f}  slack={slack:12.9f}  {tag}", flush=True)
    return slack


if __name__ == '__main__':
    print("Salvage bound theta <= lambda_min + (n-2) lambda_max: where does it saturate?\n"
          "Record's claim: exact at balanced sphere products, slack at unbalanced ones.\n"
          "Derived prediction: exact on every SYMMETRIC-PAIR two-eigenvalue point,\n"
          "slack at maximal tori and ad(su(3)).\n", flush=True)

    print("[symmetric pairs so(p)+so(q) as two-eigenvalue Casimir points]", flush=True)
    for n in (6, 8, 10, 12):
        A = build.Arena(n)
        for p in range(2, n // 2 + 1):
            report(f"so({p})+so({n-p})", n, build.subalg_casimir(n, build.so_pq_basis(n, p)), A)

    print("\n[u(m) in so(2m) -- also a symmetric pair]", flush=True)
    for n in (6, 8, 10, 12):
        A = build.Arena(n)
        report(f"u({n//2})", n, build.subalg_casimir(n, build.um_basis(n)), A)

    print("\n[maximal tori and ad(su(3)) -- subalgebras that are NOT symmetric pairs]", flush=True)
    for n in (6, 8, 10, 12):
        A = build.Arena(n)
        report(f"torus so(2)^{n//2}", n, build.subalg_casimir(n, build.torus_basis(n)), A)
    A8 = build.Arena(8)
    report("ad(su(3)) in so(8)", 8, build.subalg_casimir(8, build.adjoint_basis(8, build.su3_adjoint())), A8)

    print("\n[padded CP^2 -- the sqrt(3/2) frontier point]", flush=True)
    for n in (6, 8, 10, 12):
        report(f"CP^2 padded", n, build.cp2(n), build.Arena(n))
    print("\nDONE", flush=True)


def mechanism(name, n, W, A):
    """Direct check of the derived equality condition: is ad(v) supported on E_min x E_max
    for EVERY unit v in the lambda_min eigenspace?  (Criticality gives
    lambda_min^2 + <v,W#v> = theta lambda_min for every such v, so the condition is
    eigenspace-wide, not a statement about one chosen vector.)"""
    W = build.unit(W)
    th = A.P3(W)
    ev, U = np.linalg.eigh(W)
    lmin, lmax = ev[0], ev[-1]
    Emin = np.abs(ev - lmin) < 1e-9
    Emax = np.abs(ev - lmax) < 1e-9
    onext = np.outer(Emin, Emax) | np.outer(Emax, Emin)     # the allowed pairs
    tot = off = 0.0
    for k in np.nonzero(Emin)[0]:
        v = U[:, k]
        C = U.T @ A.ad(v) @ U                                # c_{v a b} in the eigenbasis
        c2 = C ** 2
        tot += c2.sum()
        off += c2[~onext].sum()
    print(f"  {name:26s} dim E_min={int(Emin.sum()):3d} dim E_max={int(Emax.sum()):3d}  "
          f"mass off E_min x E_max = {off:12.6f} of {tot:11.6f}  "
          f"({'CONCENTRATED' if off < 1e-8 else 'spread'})  "
          f"slack={lmin + (n-2)*lmax - th:.9f}", flush=True)
