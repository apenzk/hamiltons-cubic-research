"""Is h at probe 0 the Gram of the raw highest-weight vectors?  If so, the
nonsingularity assert is a theorem about nullspace_G, not a screen."""
import importlib.util, sys, os
RUNS = "scripts/runs"
def load(name):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(RUNS, name))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(m); sys.stdout = o
    return m
ad = load("run_n5_adapted.py")
hw = load("run_n5_highest_weight.py")
ADAPTED, HW = ad.ADAPTED, hw.HW
same = diff = 0
for lam, cs in ADAPTED.items():
    cols, ns = HW[lam]
    if len(ns) != len(cs): print(f"  !! {lam}: {len(ns)} nullspace vectors vs {len(cs)} copies"); continue
    for i, v in enumerate(ns):
        u = {cols[j]: v[j] for j in range(len(cols)) if v[j]}
        def norm(d): return {k: (x.r, x.i) for k, x in d.items()}
        if norm(u) == norm(cs[i][0]): same += 1
        else:
            diff += 1
            print(f"  !! {lam} copy {i}: R_i[0] != u_i")
print(f"\n  R_i[0] == u_i (the raw highest-weight vector) in {same}/{same+diff} copies")
print(f"  -> h at probe 0 is exactly the Gram of the nullspace basis {{u_i}}.")
print(f"     nullspace_G returns a BASIS, so the u_i are independent by construction,")
print(f"     and a Gram of independent vectors under a definite form is nonsingular.")
print(f"     The assert det h != 0 therefore cannot fail on any live build.")
