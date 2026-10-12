"""r279 claim 4: run the COMMITTED salvage script and Stop hook against constructed logs.

Nothing here touches the repository's own agent_logs/ or reviews/: every case runs in a
throwaway tree that mirrors the layout the two files expect.
"""
import importlib.util, json, os, shutil, subprocess, sys, tempfile, time

ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..'))

def load_hook():
    sys.path.insert(0, os.path.join(ROOT, '.claude', 'hooks'))
    spec = importlib.util.spec_from_file_location(
        'rls', os.path.join(ROOT, '.claude', 'hooks', 'research_loop_stop.py'))
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m

HOOK = load_hook()

def sandbox():
    d = tempfile.mkdtemp(prefix='r279_')
    os.makedirs(os.path.join(d, 'agent_logs'))
    os.makedirs(os.path.join(d, 'reviews'))
    os.makedirs(os.path.join(d, 'scripts'))
    shutil.copy(os.path.join(ROOT, 'scripts', 'salvage_reviewer.py'),
                os.path.join(d, 'scripts', 'salvage_reviewer.py'))
    return d

def run_salvage(d, n):
    out = subprocess.run([sys.executable, os.path.join(d, 'scripts', 'salvage_reviewer.py'), str(n)],
                         capture_output=True, text=True)
    return out.stdout.strip()

def running(d):
    return HOOK._agents_running(d)

def show(label, verdict, detail=''):
    print(f"  {label:<58} {verdict}{('  ' + detail) if detail else ''}")

print("=" * 78)
print("A. CAN A CORPSE STILL SILENCE THE LOOP?  (_agents_running True => hook exit 0,")
print("   no message emitted, the loop simply stops)")
print("=" * 78)

# A1 -- killed reviewer, salvage never run
d = sandbox()
p = os.path.join(d, 'agent_logs', 'r901.log')
open(p, 'w').write("PID 1 r901 start\n[10:00] phase2 running the n=12 solve\n")
show("A1 killed reviewer, salvage NEVER run", f"in flight = {running(d)}",
     "<- SILENCES the loop for the whole 45 min window")

# A2 -- killed reviewer, salvage run (the fixed path)
d = sandbox()
p = os.path.join(d, 'agent_logs', 'r902.log')
open(p, 'w').write("PID 1 r902 start\n[10:00] phase2 running\n")
msg = run_salvage(d, 902)
show("A2 killed reviewer, salvage RUN", f"in flight = {running(d)}", f"| {msg}")

# A3 -- killed reviewer whose last log write had NO trailing newline
d = sandbox()
p = os.path.join(d, 'agent_logs', 'r903.log')
open(p, 'w').write("PID 1 r903 start\n[10:00] phase2 running the n=12 solve")   # no \n
msg = run_salvage(d, 903)
tail = open(p).readlines()[-1]
show("A3 no trailing newline, salvage RUN", f"in flight = {running(d)}", f"| {msg}")
print(f"      last line becomes: {tail!r}")

# A4 -- reviewer that FILED ITS REPORT then was killed (the e1fc1e6 fix)
d = sandbox()
p = os.path.join(d, 'agent_logs', 'r904.log')
open(p, 'w').write("PID 1 r904 start\n[10:00] phase2 running\n")
open(os.path.join(d, 'reviews', 'REVIEW_r904.md'), 'w').write("# REVIEW r904 — Gate 2\n\nverdict table\n")
msg = run_salvage(d, 904)
show("A4 filed-then-killed (the e1fc1e6 fix)", f"in flight = {running(d)}", f"| {msg}")

# A5 -- same, but the log had no trailing newline
d = sandbox()
p = os.path.join(d, 'agent_logs', 'r905.log')
open(p, 'w').write("PID 1 r905 start\n[10:00] phase2 running")
open(os.path.join(d, 'reviews', 'REVIEW_r905.md'), 'w').write("# REVIEW r905 — Gate 2\n")
msg = run_salvage(d, 905)
show("A5 filed-then-killed, no trailing newline", f"in flight = {running(d)}", f"| {msg}")
print(f"      last line becomes: {open(p).readlines()[-1]!r}")

# A6 -- log ends in a blank line after a proper DONE
d = sandbox()
open(os.path.join(d, 'agent_logs', 'r906.log'), 'w').write("PID 1\nDONE all six claims filed\n\n")
show("A6 proper DONE then a blank line", f"in flight = {running(d)}")

# A7 -- empty log
d = sandbox()
open(os.path.join(d, 'agent_logs', 'r907.log'), 'w').write("")
show("A7 empty log (agent died before its first write)", f"in flight = {running(d)}")

# A8 -- something keeps the corpse warm
d = sandbox()
p = os.path.join(d, 'agent_logs', 'r908.log')
open(p, 'w').write("PID 1\n[10:00] phase2 running\n")
os.utime(p, None)
show("A8 corpse whose mtime is refreshed by a poller", f"in flight = {running(d)}",
     "<- indefinite, the window buys nothing")

print()
print("=" * 78)
print("B. CAN A LIVE REVIEWER BE DECLARED DEAD?  (in flight = False while it works)")
print("=" * 78)

# B1 -- live reviewer inside a long computation, log 46 min old
d = sandbox()
p = os.path.join(d, 'agent_logs', 'r911.log')
open(p, 'w').write("PID 1 r911\n[10:00] phase3 started the sage solve, back in an hour\n")
old = time.time() - 46*60
os.utime(p, (old, old))
show("B1 live reviewer, 46 min into one computation", f"in flight = {running(d)}",
     "<- declared dead on 6.7 min of margin over the measured 39.3")

# B2 -- salvage run on a LIVE reviewer by mistake
d = sandbox()
p = os.path.join(d, 'agent_logs', 'r912.log')
open(p, 'w').write("PID 1 r912\n[10:00] phase2 running\n")
msg = run_salvage(d, 912)
show("B2 salvage run on a LIVE reviewer (no liveness test)", f"in flight = {running(d)}",
     f"| {msg}")

# B3 -- salvage OVERWRITES a real report whose header contains the word PARTIAL
d = sandbox()
p = os.path.join(d, 'agent_logs', 'r913.log')
open(p, 'w').write("PID 1 r913\n[10:00] phase2 running\n")
real = os.path.join(d, 'reviews', 'REVIEW_r913.md')
open(real, 'w').write("# REVIEW r913 — Gate 2\n\n| # | Claim | Verdict |\n"
                      "|---|---|---|\n| 1 | the harmonic law | **PARTIAL CONFIRMATION** |\n"
                      "\n(the rest of a real report)\n")
before = open(real).read()
msg = run_salvage(d, 913)
after = open(real).read()
show("B3 real report saying 'PARTIAL' in its first 200 chars",
     f"overwritten = {before != after}", f"| {msg}")
