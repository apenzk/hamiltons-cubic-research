"""r233 claim 2: does every sibling constructor in scripts/runs/ build the TRUE
Weyl tensor?  Each carries a compensating leading minus that the catalogue lacked."""
import numpy as np, importlib.util as il, io, contextlib, sys, os
sys.path.insert(0, 'scripts/lib')
exec(open('scripts/reviewers/r233/r233_c2_signs.py').read().split('print("=== S^p')[0])

def load(path,name):
    sp=il.spec_from_file_location(name,path); m=il.module_from_spec(sp)
    with contextlib.redirect_stdout(io.StringIO()):
        with contextlib.redirect_stderr(io.StringIO()):
            sp.loader.exec_module(m)
    return m

def unit(T): return T/np.linalg.norm(T)
sibs=["run_omega_diagonal_blind","run_both_diagonals","run_schurhorn_rebuild",
      "run_bispectral_region","run_g_cap_refinement","run_diagonal_spread",
      "run_k_bound_falsifier","run_graded_spectral_gap","run_graded_gap_at_fixed_n",
      "run_kappa_frame_invariant"]
p=q=4; n=8
Wt=unit(weyl_from_R(R_sphere_product(p,q)))
print(f"reference: true Weyl of S^{p}xS^{q} (Hamilton convention, from the metric)")
for s in sibs:
    try:
        m=load(f"scripts/runs/{s}.py",s)
        W=unit(m.sphere_product(p,q,n))
        print(f"  {s:32s} |W-Wtrue|={np.linalg.norm(W-Wt):.1e}  |W+Wtrue|={np.linalg.norm(W+Wt):.1e}")
    except Exception as e:
        print(f"  {s:32s} SKIP ({type(e).__name__}: {e})")
cat=load("scripts/runs/run_bispectral_catalogue.py","cat")
W=unit(cat.sphere_product(p,q))
print(f"  {'run_bispectral_catalogue (FIXED)':32s} |W-Wtrue|={np.linalg.norm(W-Wt):.1e}  |W+Wtrue|={np.linalg.norm(W+Wt):.1e}")
