"""r201, claim 3: the two blind spots, driven through the `dis == 0` assert.
Executes the real source truncated at line 403 (through `assert dis == 0`)."""
import sys, os, time
SRC = "scripts/runs/run_n5_assemble.py"
LINES = open(SRC).read().split("\n")
CUT = 403
assert "assert dis == 0" in LINES[401], LINES[401]
HEAD = "\n".join(LINES[:CUT])
MARK = 'print("\\nmeasuring the multiplicity Gram h ...", flush=True)'

def run(name, inject=None):
    src = HEAD.replace(MARK, (inject + "\n" + MARK) if inject else MARK)
    g = {"__name__": "__main__", "__file__": SRC}
    out = sys.stdout; sys.stdout = open(os.devnull, "w"); t = time.time(); err = None
    try: exec(compile(src, SRC, "exec"), g)
    except AssertionError as e: err = ("AssertionError", str(e)[:90])
    except Exception as e: err = (type(e).__name__, str(e)[:90])
    sys.stdout = out
    v = "FIRES" if err and err[0] == "AssertionError" else ("CRASH " + err[0] if err else "passes")
    d = f" dis={g.get('dis')} skipped={g.get('skipped')}"
    print(f"[{name:34s}] {v:16s} [{time.time()-t:.0f}s]{d}  {err[1] if err else ''}", flush=True)

W = sys.argv[1]
if W == "a":
    run("E0 baseline")
    run("E1 coincident copies (2,0)",
        inject="ADAPTED[(2,0)][1] = [dict(v) for v in ADAPTED[(2,0)][0]]")
if W == "b":
    run("E2 positions rotated, ALL copies", inject="""
_pp = list(range(len(ADAPTED[(2,0)][0]))); _pp = _pp[7:] + _pp[:7]
for _i in range(len(ADAPTED[(2,0)])):
    _old = ADAPTED[(2,0)][_i]; ADAPTED[(2,0)][_i] = [_old[_j] for _j in _pp]
""")
    run("E3 positions rotated, ONE copy", inject="""
_pp = list(range(len(ADAPTED[(2,0)][0]))); _pp = _pp[7:] + _pp[:7]
_old = ADAPTED[(2,0)][1]; ADAPTED[(2,0)][1] = [_old[_j] for _j in _pp]
""")
if W == "c":
    run("E4 every block's copies coincident", inject="""
for _l in ADAPTED:
    for _i in range(1, len(ADAPTED[_l])):
        ADAPTED[_l][_i] = [dict(v) for v in ADAPTED[_l][0]]
""")
