"""r249 / claim 2: a WRONG projector with the CORRECT trace that passes every
check run_weyl_projector.py makes.

The file asserts the trace is "the ONE that catches a wrong projector".  If a
35-dimensional subspace of (R^5)^{tensor 4} other than Weyl_5 yields a P passing
idempotence, symmetry, trace = 35 and the file's "P fixes a Weyl tensor" test,
then the four checks are jointly insufficient and the file says otherwise.
"""
import importlib.util as _il, io as _io, contextlib as _cl
import numpy as np

def _load(path, name):
    sp = _il.spec_from_file_location(name, path); m = _il.module_from_spec(sp)
    with _cl.redirect_stdout(_io.StringIO()): sp.loader.exec_module(m)
    return m

wm = _load("scripts/runs/run_n5_weyl_module.py", "wm")
N = 5
def dim_weyl(n): return n*(n+1)*(n+2)*(n-3)//12

def to_arr(T):
    return np.array([[[[float(T[a][b][c][d]) for d in range(N)] for c in range(N)]
                      for b in range(N)] for a in range(N)])

def vec_to_tensor(vec):
    return to_arr(wm.sym2_to_R({wm.SPAIRS[c]: vec[c] for c in range(len(vec)) if vec[c]}))

def orthonormalise(B):                       # verbatim from the file
    out = []
    for v in B:
        w = v.copy()
        for u in out:
            w = w - np.einsum('abcd,abcd->', w, u)*u
        nrm = np.sqrt(np.einsum('abcd,abcd->', w, w))
        if nrm > 1e-9: out.append(w/nrm)
    return out

def projector_from_basis(B):
    P = np.zeros((N,)*8)
    for b in B: P += np.einsum('abcd,efgh->abcdefgh', b, b)
    return P

def file_checks(P, ON, label):
    """Exactly the four assertions run_weyl_projector.py makes."""
    PP = np.einsum('abcdefgh,efghijkl->abcdijkl', P, P)
    idem = np.abs(PP-P).max()
    sym  = np.abs(P - P.transpose(4,5,6,7,0,1,2,3)).max()
    tr   = np.einsum('abcdabcd->', P)
    rng  = np.random.default_rng(1)                 # the file's own seed/recipe
    w    = sum(rng.standard_normal()*b for b in ON)
    fix  = np.abs(np.einsum('abcdefgh,efgh->abcd', P, w) - w).max()
    ok = (idem < 1e-9) and (sym < 1e-9) and (abs(tr-dim_weyl(N)) < 1e-9) and (fix < 1e-9)
    print(f"  {label:38s} idem={idem:.1e} sym={sym:.1e} trace={tr:.6f} fix={fix:.1e} "
          f"-> file's checks {'PASS' if ok else 'FAIL'}")
    return ok

# --- the true Weyl basis, for reference and for building witnesses ---
B5  = [vec_to_tensor(v) for v in wm.BASIS]
ONW = orthonormalise(B5)
PW  = projector_from_basis(ONW)
print(f"reference: dim Weyl_5 = {len(ONW)}")
file_checks(PW, ONW, "TRUE Weyl_5 projector")

# --- witness A: 35 elementary coordinate tensors e_{abcd} ---
idxs = [(a,b,c,d) for a in range(N) for b in range(N) for c in range(N) for d in range(N)]
A = []
for (a,b,c,d) in idxs[:35]:
    e = np.zeros((N,)*4); e[a,b,c,d] = 1.0; A.append(e)
PA = projector_from_basis(A)
okA = file_checks(PA, A, "A: 35 coordinate tensors e_abcd")

# --- witness B: a random 35-dim subspace (generic rotation of Weyl_5) ---
rg = np.random.default_rng(7)
Braw = [rg.standard_normal((N,)*4) for _ in range(35)]
ONB = orthonormalise(Braw)
PB = projector_from_basis(ONB)
okB = file_checks(PB, ONB, "B: random 35-dim subspace")

# --- witness C: the sharp one.  30 Weyl directions + 5 Ricci directions, i.e. a
# 35-dim subspace INSIDE the 50-dim space of algebraic curvature tensors: every
# member has all Riemann symmetries and satisfies first Bianchi.  It fails only
# tracelessness, which the file never tests. ---
rows = wm.bianchi_rows()
CURV = [vec_to_tensor(v) for v in wm.nullspace(rows, wm.NS)]   # dim 50
ONC_full = orthonormalise(CURV)
print(f"  (algebraic curvature tensors at n=5: dim {len(ONC_full)}, expect 50)")
# Weyl part first, then complete from the curvature space -> picks up Ricci dirs
mix = orthonormalise(ONW[:30] + ONC_full)[:35]
PC = projector_from_basis(mix)
okC = file_checks(PC, mix, "C: 30 Weyl + 5 Ricci (curvature space)")

# --- do the witnesses actually differ from the true projector? ---
for lbl, Q in (("A", PA), ("B", PB), ("C", PC)):
    print(f"  witness {lbl}: |P_wrong - P_Weyl|_max = {np.abs(Q-PW).max():.3f}")

# --- a check the file does NOT make, which separates them: does P's range obey
# the Weyl symmetries and tracelessness? ---
def range_diagnostics(P, label):
    rg = np.random.default_rng(3)
    X = rg.standard_normal((N,)*4)
    T = np.einsum('abcdefgh,efgh->abcd', P, X)
    nrm = np.abs(T).max() or 1.0
    anti = np.abs(T + T.transpose(1,0,2,3)).max()/nrm
    pair = np.abs(T - T.transpose(2,3,0,1)).max()/nrm
    bian = np.abs(T + T.transpose(0,2,3,1) + T.transpose(0,3,1,2)).max()/nrm
    ric  = np.abs(np.einsum('ambm->ab', T)).max()/nrm
    print(f"  {label:38s} antisym={anti:.1e} pairsym={pair:.1e} bianchi={bian:.1e} ricci={ric:.1e}")

print("\nrange diagnostics (relative), NOT performed by the file:")
range_diagnostics(PW, "TRUE Weyl_5")
range_diagnostics(PA, "A: coordinate tensors")
range_diagnostics(PB, "B: random subspace")
range_diagnostics(PC, "C: 30 Weyl + 5 Ricci")

print("\nVERDICT: file's four checks passed by a wrong projector:",
      {"A": okA, "B": okB, "C": okC})
