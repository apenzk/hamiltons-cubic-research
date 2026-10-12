"""r251, claim 2: is "P fixes an independently built Weyl tensor" a sufficient
separating check for run_weyl_projector.py?

The file's four live checks on a candidate P are
   (1) idempotent, (2) symmetric, (3) trace(P) = 35, (4) P fixes Wi,
where Wi = independent_weyl(5, default_rng(1)) is one Kulkarni-Nomizu-corrected
Weyl tensor built without the module.  Reviewer 249 showed (3) only counts basis
vectors when P is built from an orthonormal list, so (4) is meant to carry the
separation.

Below: the brief's literal suggestion (Weyl_5 PLUS an extra orthogonal
direction) and the rank-preserving sharpening of it.
"""
import importlib.util as il, io, contextlib, numpy as np

def load(path, name):
    sp = il.spec_from_file_location(name, path); m = il.module_from_spec(sp)
    with contextlib.redirect_stdout(io.StringIO()):
        sp.loader.exec_module(m)
    return m

wp = load("scripts/runs/run_weyl_projector.py", "wp")
P, ON, orth, projector_from_basis = wp.P, wp.ON, wp.orthonormalise, wp.projector_from_basis
n = 5
print(f"  loaded the file: |ON| = {len(ON)}, trace(P) = "
      f"{np.einsum('abcdabcd->', P):.6f}")

# the file's own witness tensor, same seed, so this is literally the tensor the
# assert at line 190 uses
Wi = wp.independent_weyl(5, np.random.default_rng(1))
assert np.abs(Wi - wp.Wi).max() < 1e-12, "failed to reproduce the file's Wi"

def report(name, Q):
    QQ = np.einsum('abcdefgh,efghijkl->abcdijkl', Q, Q)
    idem = np.abs(QQ - Q).max()
    sym = np.abs(Q - Q.transpose(4,5,6,7,0,1,2,3)).max()
    tr = np.einsum('abcdabcd->', Q)
    fix = np.abs(np.einsum('abcdefgh,efgh->abcd', Q, Wi) - Wi).max()/np.abs(Wi).max()
    dist = np.abs(Q - P).max()
    verdict = ("PASSES ALL FOUR" if idem < 1e-9 and sym < 1e-9
               and abs(tr - 35) < 1e-9 and fix < 1e-9 else "caught")
    print(f"  {name:<44} idem {idem:.1e}  sym {sym:.1e}  trace {tr:9.6f}  "
          f"fix(Wi) {fix:.1e}  |Q-P| {dist:.3f}   {verdict}")
    return verdict.startswith("PASSES")

rng = np.random.default_rng(2510)

def ricci_dir(rng):
    h = rng.standard_normal((n, n)); h = 0.5*(h + h.T)
    g = np.eye(n)
    KN = lambda A,B: (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                      -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    T = KN(h, g); T = 0.5*(T + T.transpose(2,3,0,1))
    return T/np.sqrt(np.einsum('abcd,abcd->', T, T))

print("\n  candidates:")
report("the true P (control)", P)

# --- witness D1: the brief's literal suggestion, Weyl_5 + one extra direction
D1basis = orth(ON + [ricci_dir(rng)])
D1 = projector_from_basis(D1basis)
caught_by_trace = not report(f"D1  Weyl_5 + 1 extra dir (rank {len(D1basis)})", D1)

# --- witness D2: RANK-PRESERVING.  Keep Wi inside, swap one Weyl direction out.
# Wi lies in Weyl_5, so orthonormalising [Wi] first and then 33 of ON gives a
# 34-dimensional subspace of Weyl_5 containing Wi; one Ricci direction completes
# it to 35.  Every one of the file's four checks passes.
start = orth([Wi] + ON)                      # = Weyl_5, with Wi as first vector
D2basis = orth(start[:34] + [ricci_dir(rng)])
assert len(D2basis) == 35
D2 = projector_from_basis(D2basis)
passes = report("D2  34 Weyl dirs (incl. Wi) + 1 Ricci dir", D2)

# --- witness D3: as D2 but with a generic non-curvature direction
X = rng.standard_normal((n,n,n,n)); X = X/np.sqrt(np.einsum('abcd,abcd->',X,X))
D3basis = orth(start[:34] + [X])
D3 = projector_from_basis(D3basis)
passes3 = report("D3  34 Weyl dirs (incl. Wi) + 1 generic dir", D3)

# --- how much of Weyl_5 does the check certify?
print("\n  how much the fix-one-tensor check certifies:")
print("    fixing one tensor pins 1 of the 35 dimensions of Weyl_5; 34 remain")
print("    free, and D2/D3 spend one of them on a NON-Weyl direction.")
q = np.einsum('abcdefgh,efgh->abcd', D2, Wi)
print(f"    D2 . Wi - Wi (abs max) = {np.abs(q - Wi).max():.2e}   "
      f"D2 fixes it EXACTLY because Wi is in the span by construction")

# --- does a second independent Weyl tensor catch them?
print("\n  a SECOND independently built Weyl tensor (different seed):")
W2 = wp.independent_weyl(5, np.random.default_rng(99))
for nm, Q in (("D2", D2), ("D3", D3)):
    e = np.abs(np.einsum('abcdefgh,efgh->abcd', Q, W2) - W2).max()/np.abs(W2).max()
    print(f"    {nm}: rel err on W2 = {e:.2e}  -> {'CAUGHT' if e > 1e-3 else 'still passes'}")

# --- the check that is actually sufficient: range(P) is inside Weyl
print("\n  the sufficient check -- RANGE(P) c Weyl_n, plus trace = dim Weyl_n:")
def weyl_defect(Q, rng, trials=3):
    g = np.eye(n); worst = 0.0
    for _ in range(trials):
        Y = np.einsum('abcdefgh,efgh->abcd', Q, rng.standard_normal((n,n,n,n)))
        s = np.abs(Y).max() or 1.0
        d = [np.abs(Y + Y.transpose(1,0,2,3)).max(),          # antisym ab
             np.abs(Y + Y.transpose(0,1,3,2)).max(),          # antisym cd
             np.abs(Y - Y.transpose(2,3,0,1)).max(),          # pair symmetry
             np.abs(Y + Y.transpose(0,2,3,1) + Y.transpose(0,3,1,2)).max(),  # Bianchi
             np.abs(np.einsum('ikjk->ij', Y)).max()]          # Ricci-flat
        worst = max(worst, max(d)/s)
    return worst
rr = np.random.default_rng(5)
for nm, Q in (("true P", P), ("D1", D1), ("D2", D2), ("D3", D3),
              ("r249 witness C", projector_from_basis(wp.WITNESS_C))):
    d = weyl_defect(Q, np.random.default_rng(5))
    print(f"    {nm:<16} max Weyl-equation defect of P(random tensor) = {d:.2e}"
          f"   -> {'ok' if d < 1e-9 else 'CAUGHT'}")
print("\n  range c Weyl_n AND trace = dim Weyl_n force range = Weyl_n exactly,")
print("  so with idempotence and symmetry P is THE orthogonal projector.  That")
print("  check needs no Weyl tensor at all and catches D1, D2, D3 and C.")
print("\nDONE")

# ---- the DETERMINISTIC form of the sufficient check: no probes at all.
# The five Weyl equations act on the FIRST four indices of P, so range(P) c Weyl
# is a set of exact 8-index identities on P itself.
print("\n  deterministic form (constraints applied to P's first four indices):")
def range_defect(Q):
    d = [np.abs(Q + Q.transpose(1,0,2,3,4,5,6,7)).max(),
         np.abs(Q + Q.transpose(0,1,3,2,4,5,6,7)).max(),
         np.abs(Q - Q.transpose(2,3,0,1,4,5,6,7)).max(),
         np.abs(Q + Q.transpose(0,2,3,1,4,5,6,7)
                  + Q.transpose(0,3,1,2,4,5,6,7)).max(),
         np.abs(np.einsum('akbkefgh->abefgh', Q)).max()]
    return max(d)/max(np.abs(Q).max(), 1e-30)
for nm, Q in (("true P", P), ("D1", D1), ("D2", D2), ("D3", D3),
              ("r249 witness C", projector_from_basis(wp.WITNESS_C)),
              ("the zero stub", np.zeros_like(P))):
    d = range_defect(Q)
    tr = np.einsum('abcdabcd->', Q)
    ok = d < 1e-9 and abs(tr - 35) < 1e-9
    print(f"    {nm:<16} range defect {d:.2e}  trace {tr:8.4f}  -> "
          f"{'ACCEPTED' if ok else 'CAUGHT'}")
