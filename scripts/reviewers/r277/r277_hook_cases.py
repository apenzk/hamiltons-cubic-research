"""r277 -- the hook fix (d8a34c2), exercised case by case against the live code.

Answers the two questions the brief asks: can a corpse still silence the loop, and
can a live reviewer still be declared dead.  Writes nothing outside a temp dir.
"""
import importlib.util
import os
import shutil
import tempfile
import time

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))


def load(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


hook = load(os.path.join(ROOT, ".claude/hooks/research_loop_stop.py"), "hook")

d = tempfile.mkdtemp()
os.makedirs(os.path.join(d, "agent_logs"))
cases = [
    ("A corpse, killed 10 min ago, log ends in a heartbeat", "PID 1 start\nHEARTBEAT phase2\n", 600),
    ("Same corpse, 50 min old (past the 45-min window)", "PID 1 start\nHEARTBEAT phase2\n", 3000),
    ("Corpse closed by salvage_reviewer.py", "PID 1 start\nHEARTBEAT\nFAILED salvaged and closed\n", 600),
    ("Finished reviewer, DONE then a BLANK line", "PID 1 start\nDONE all six claims\n\n", 60),
    ("Finished reviewer, DONE last", "PID 1 start\nDONE all six claims\n", 60),
    ("Empty log just created", "", 5),
    ("Heartbeat says 'phase3 DICKSON DONE, f=5 running'", "PID 1\nphase3 DICKSON DONE, f=5 running\n", 60),
]
print("== _agents_running, 45-minute window, no PID check ==")
for label, text, age in cases:
    for f in os.listdir(os.path.join(d, "agent_logs")):
        os.remove(os.path.join(d, "agent_logs", f))
    p = os.path.join(d, "agent_logs", "r900.log")
    open(p, "w").write(text)
    os.utime(p, (time.time() - age, time.time() - age))
    print(f"  _agents_running = {str(hook._agents_running(d)):5s}  <- {label}")
shutil.rmtree(d)

print("\n== salvage_reviewer.py: the 'refused' path skips the closing line ==")
sv = load(os.path.join(ROOT, "scripts/salvage_reviewer.py"), "sv")
d2 = tempfile.mkdtemp()
os.makedirs(os.path.join(d2, "agent_logs"))
os.makedirs(os.path.join(d2, "reviews"))
log = os.path.join(d2, "agent_logs", "r901.log")
open(log, "w").write("PID 1 start\nHEARTBEAT phase4\n")
open(os.path.join(d2, "reviews", "REVIEW_r901.md"), "w").write("# Reviewer 901\n\nA full report.\n")
sv.ROOT = d2
print("  salvage() says:", sv.salvage(901))
print("  log tail now  :", repr(open(log).readlines()[-1]))
print("  ** a reviewer killed AFTER filing its report cannot be closed by the tool built to close it **")
shutil.rmtree(d2)
