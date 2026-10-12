"""Dump the two lowering-operator matrices F1C, F2C (weight-basis coordinates)
to JSON so the rest of r192's work does not pay run_n5_highest_weight's cost."""
import importlib.util, sys, os, json, time
d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
spec = importlib.util.spec_from_file_location("hw", os.path.join(d, "run_n5_highest_weight.py"))
hw = importlib.util.module_from_spec(spec)
t0 = time.time()
_o = sys.stdout; sys.stdout = open(os.devnull, "w"); spec.loader.exec_module(hw); sys.stdout = _o
print(f"hw loaded in {time.time()-t0:.0f}s", flush=True)
RV1m, RV2m = hw.root_vector(-1, 1), hw.root_vector(0, -1)
F1C = hw.to_weight_coords([hw.apply(hw.lin({k: RV1m[k] for k in range(10) if RV1m[k]}), v)
                           for v in hw.WBASIS])
F2C = hw.to_weight_coords([hw.apply(hw.lin({k: RV2m[k] for k in range(10) if RV2m[k]}), v)
                           for v in hw.WBASIS])
def _g(x): return [[x.r.numerator, x.r.denominator], [x.i.numerator, x.i.denominator]]
out = {"F1C": [[_g(x) for x in row] for row in F1C],
       "F2C": [[_g(x) for x in row] for row in F2C],
       "WWT": [list(w) for w in hw.WWT]}
p = os.path.join(os.path.dirname(os.path.abspath(__file__)), "low_cache.json")
json.dump(out, open(p, "w"))
print("wrote", p, flush=True)
