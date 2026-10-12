"""Dump the 10 so(5) generators as matrices in the WEIGHT basis, matching the
convention of run_n5_highest_weight.py's GC (row = source index)."""
import importlib.util, sys, os, json, time
d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
spec = importlib.util.spec_from_file_location("hw", os.path.join(d, "run_n5_highest_weight.py"))
hw = importlib.util.module_from_spec(spec)
_o = sys.stdout; sys.stdout = open(os.devnull, "w"); spec.loader.exec_module(hw); sys.stdout = _o
GC = [hw.to_weight_coords([hw.apply(hw.lin({k: hw.ONE}), v) for v in hw.WBASIS])
      for k in range(10)]
def _g(x): return [[x.r.numerator, x.r.denominator], [x.i.numerator, x.i.denominator]]
json.dump({"GC": [[[_g(x) for x in row] for row in M] for M in GC]},
          open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "gens_cache.json"), "w"))
print("done", flush=True)
