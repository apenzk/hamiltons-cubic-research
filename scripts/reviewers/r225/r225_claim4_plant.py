"""Plant violations and report whether run_n12_stability.py's asserts fire.
The file under review is NOT edited: its source is exec'd in memory with LOGS
repointed at doctored copies of the covariant logs."""
import os, re, sys, io, contextlib

SRC = open('scripts/runs/run_n12_stability.py').read()
TMP = os.environ.get('SCRATCH', '/tmp') + '/r225_plant'
os.makedirs(TMP, exist_ok=True)
BASE = "".join(open(f).read() for f in
               ["agent_logs/n12_cov_big.log", "agent_logs/n12_cov_t.log", "agent_logs/n12_tail.log"]
               if os.path.exists(f))

def run(name, text):
    path = os.path.join(TMP, name + ".log")
    open(path, "w").write(text)
    src = SRC.replace('LOGS = ["agent_logs/n12_cov_big.log", "agent_logs/n12_cov_t.log",\n        "agent_logs/n12_tail.log"]',
                      'LOGS = [%r]' % path)
    assert 'LOGS = [%r]' % path in src, "source patch failed"
    buf = io.StringIO()
    try:
        with contextlib.redirect_stdout(buf):
            exec(compile(src, 'run_n12_stability.py', 'exec'), {'__name__': '__main__'})
        return "PASSED (no assert fired)", buf.getvalue()
    except AssertionError as e:
        return "ASSERT FIRED: %s" % str(e).split('\n')[0][:110], buf.getvalue()

cases = [
    ("control", BASE),
    # A: the extremal label (2,2,2,2,2,+-2) deleted from the logs
    ("drop_extremal", "\n".join(l for l in BASE.splitlines()
                                if not re.search(r'\(2, ?2, ?2, ?2, ?2, ?-?2\)', l))),
    # B: a seven-row constituent PRESENT in the logs -> step 1 must fire
    ("seven_rows_visible", BASE + "\n(2, 2, 2, 2, 2, 2, 2)  dim 1\n"),
    # C: a lambda'_1+lambda'_2 = 13 constituent PRESENT in the logs
    ("c13_visible", BASE + "\n(3, 2, 2, 2, 2, 2, 2)  dim 1\n"),
    # D: THE REAL GAP -- such a constituent exists in the table but never reached a log.
    #    Simulated by leaving the logs untouched: the file sees only what was logged.
    ("seven_rows_unlogged", BASE),
    # E: only the 20 richest labels logged (a plausible truncation)
    ("truncated_20", "\n".join(BASE.splitlines()[:20])),
]
for name, text in cases:
    v, out = run(name, text)
    first = [l for l in out.splitlines() if 'distinct constituent' in l]
    print("%-22s %-58s %s" % (name, v, first[0] if first else ""))
