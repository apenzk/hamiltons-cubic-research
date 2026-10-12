"""r280: exercise the Stop hook's in-flight detector and the salvage script.

Both directions are constructed against the real code, imported, not re-implemented.
"""
import importlib.util, os, sys, time, tempfile, shutil, subprocess

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))))
HOOK = os.path.join(ROOT, ".claude", "hooks", "research_loop_stop.py")
spec = importlib.util.spec_from_file_location("rls", HOOK)
m = importlib.util.module_from_spec(spec)
sys.modules["rls"] = m
sys.path.insert(0, os.path.dirname(HOOK))
spec.loader.exec_module(m)

def sandbox():
    d = tempfile.mkdtemp(prefix="r280_")
    os.makedirs(os.path.join(d, "agent_logs"))
    os.makedirs(os.path.join(d, "reviews"))
    return d

def w(d, name, text, age_s=0):
    p = os.path.join(d, "agent_logs", name)
    open(p, "w").write(text)
    if age_s:
        t = time.time() - age_s
        os.utime(p, (t, t))
    return p

cases = []

# --- direction 1: a CORPSE reads as in flight, so the hook exits 0 and the turn ends
d = sandbox(); w(d, "r901.log", "PID 1 plan\nphase2 running\nheartbeat 12:00 alive\n")
cases.append(("corpse, warm log, no closing line", m._agents_running(d), True))

d = sandbox(); w(d, "r902.log", "PID 1 plan\nDONE all six claims\n\n")
cases.append(("closed reviewer with a TRAILING BLANK LINE", m._agents_running(d), True))

d = sandbox(); w(d, "r903.log", "PID 1\nDONE all six claims\n")
cases.append(("closed reviewer, clean", m._agents_running(d), False))

d = sandbox(); w(d, "r904.log", "PID 1\nheartbeat\n", age_s=2701)
cases.append(("corpse gone cold (45 min + 1 s)", m._agents_running(d), False))

d = sandbox()
w(d, "r905.log", "PID 1\nheartbeat\n", age_s=99999)
w(d, "r905_hunt.log", "raw job output, no closing line\n")   # job log, must NOT match
cases.append(("cold corpse + warm JOB log beside it", m._agents_running(d), False))

# --- direction 2: a LIVE reviewer declared dead
d = sandbox(); w(d, "r906.log", "PID 1\nphase3 started a 50-minute sage run\n", age_s=2760)
cases.append(("LIVE reviewer, 46-minute heartbeat gap", m._agents_running(d), False))

d = sandbox(); w(d, "gate2_907.log", "PID 1\nheartbeat\n")
cases.append(("gate2_NNN.log naming, warm", m._agents_running(d), True))

d = sandbox(); w(d, "r908_claim3.log", "PID 1\nheartbeat\n")
cases.append(("LIVE reviewer logging to r908_claim3.log", m._agents_running(d), False))

d = sandbox(); w(d, "r909.log", "PID 1\n  DONE trailing-space indent\n")
cases.append(("closing line indented (regex allows \\s*)", m._agents_running(d), False))

print(f"{'case':58s} {'in-flight?':>10s} {'expected':>9s}  ok")
for name, got, exp in cases:
    print(f"{name:58s} {str(got):>10s} {str(exp):>9s}  {'ok' if got == exp else 'MISMATCH'}")

# --- the salvage script's refuse-to-overwrite path, on a real tree copy
print()
print("== salvage_reviewer.py refuse-to-overwrite path ==")
d = sandbox()
shutil.copytree(os.path.join(ROOT, "scripts"), os.path.join(d, "scripts"),
                ignore=lambda *a: [x for x in a[1] if x != "salvage_reviewer.py"])
log = w(d, "r910.log", "PID 1\nphase2\nheartbeat\n")
open(os.path.join(d, "reviews", "REVIEW_r910.md"), "w").write("# REVIEW r910 - full report\n")
out = subprocess.run([sys.executable, os.path.join(d, "scripts", "salvage_reviewer.py"), "910"],
                     capture_output=True, text=True)
print("  ", out.stdout.strip() or out.stderr.strip())
print("   log tail after salvage:", repr(open(log).read().split("\n")[-2]))
print("   hook now sees in-flight:", m._agents_running(d))

print()
print("== salvage on a reviewer that never made a log ==")
d = sandbox()
shutil.copytree(os.path.join(ROOT, "scripts"), os.path.join(d, "scripts"),
                ignore=lambda *a: [x for x in a[1] if x != "salvage_reviewer.py"])
out = subprocess.run([sys.executable, os.path.join(d, "scripts", "salvage_reviewer.py"), "911"],
                     capture_output=True, text=True)
print("  ", out.stdout.strip())

print()
print("== a FULL report whose first 200 bytes contain the word PARTIAL ==")
d = sandbox()
shutil.copytree(os.path.join(ROOT, "scripts"), os.path.join(d, "scripts"),
                ignore=lambda *a: [x for x in a[1] if x != "salvage_reviewer.py"])
log = w(d, "r912.log", "PID 1\nphase2\nheartbeat\n")
real = os.path.join(d, "reviews", "REVIEW_r912.md")
open(real, "w").write(
    "# REVIEW r912 — Gate 2, route S\n\nReviewer 912. Commits under review: `abc1234`.\n"
    "Filed early per the brief; PARTIAL — claims 4-6 still running.\n\n"
    "| # | Claim | Verdict |\n|---|---|---|\n| 1 | the theorem | **REFUTED** — witness below |\n")
before = open(real).read()
out = subprocess.run([sys.executable, os.path.join(d, "scripts", "salvage_reviewer.py"), "912"],
                     capture_output=True, text=True)
after = open(real).read()
print("  ", out.stdout.strip())
print("   report preserved:", before == after)
print("   first line now:", after.split("\n")[0])
print("   the word REFUTED survives:", "REFUTED" in after)

print()
print("== the repaired guard, re-probed ==")
def salv(d, n):
    return subprocess.run([sys.executable, os.path.join(d, "scripts", "salvage_reviewer.py"), str(n)],
                          capture_output=True, text=True).stdout.strip()

def tree():
    d = sandbox()
    shutil.copytree(os.path.join(ROOT, "scripts"), os.path.join(d, "scripts"),
                    ignore=lambda *a: [x for x in a[1] if x != "salvage_reviewer.py"])
    return d

# (a) an earlier PARTIAL must still be re-salvageable
d = tree(); log = w(d, "r913.log", "PID 1\nfresh heartbeat\n")
open(os.path.join(d, "reviews", "REVIEW_r913.md"), "w").write(
    "# Reviewer 913 — PARTIAL (salvaged from its log)\n\nold dump\n")
print("  (a) re-salvage an existing PARTIAL:", salv(d, 913))

# (b) a log whose last write carries NO trailing newline
d = tree(); log = w(d, "r914.log", "PID 1\nheartbeat with no trailing newline")
print("  (b)", salv(d, 914))
tail = open(log).read().split("\n")[-2]
print("      log second-to-last line:", repr(tail), "| hook in-flight:", m._agents_running(d))

# (c) the not-found message vs the paths actually searched
d = tree()
print("  (c)", salv(d, 915))
