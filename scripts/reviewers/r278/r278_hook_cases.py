"""r278 -- claim 6: can a corpse still silence the loop, and can a live reviewer
still be declared dead?  Constructed cases against the code as committed in d8a34c2.
"""
import importlib.util, os, re, sys, tempfile, time

spec = importlib.util.spec_from_file_location(
    "rls", os.path.join(os.getcwd(), ".claude/hooks/research_loop_stop.py"))
rls = importlib.util.module_from_spec(spec); spec.loader.exec_module(rls)

def mk(d, name, text, age_s=0.0):
    p = os.path.join(d, "agent_logs", name)
    os.makedirs(os.path.dirname(p), exist_ok=True)
    open(p, "w").write(text)
    if age_s: os.utime(p, (time.time()-age_s, time.time()-age_s))
    return p

cases = []
with tempfile.TemporaryDirectory() as d:
    # A. corpse, log ends in a heartbeat, killed 10 minutes ago
    mk(d, "r900.log", "PID 1 plan\nHEARTBEAT phase 2\n", age_s=600)
    cases.append(("A  corpse aged 10 min, ends in HEARTBEAT", rls._agents_running(d)))
    os.remove(os.path.join(d, "agent_logs", "r900.log"))

    # B. same corpse, aged 46 minutes -> past the new window
    mk(d, "r900.log", "PID 1 plan\nHEARTBEAT phase 2\n", age_s=46*60)
    cases.append(("B  corpse aged 46 min (past 45-min window)", rls._agents_running(d)))
    os.remove(os.path.join(d, "agent_logs", "r900.log"))

    # C. LIVE reviewer, last heartbeat 46 minutes ago (heavy computation)
    mk(d, "r901.log", "PID 2 plan\nHEARTBEAT phase 3 running sage\n", age_s=46*60)
    cases.append(("C  LIVE reviewer, 46-min heartbeat gap", rls._agents_running(d)))
    os.remove(os.path.join(d, "agent_logs", "r901.log"))

    # D. corpse kept warm by a leftover polling shell appending to its own log
    mk(d, "r902.log", "PID 3 plan\nHEARTBEAT poll: waiting on pid 4\n", age_s=5)
    cases.append(("D  corpse kept warm by a leftover poller", rls._agents_running(d)))
    os.remove(os.path.join(d, "agent_logs", "r902.log"))

    # E. properly closed log, but a trailing blank line after DONE
    mk(d, "r903.log", "PID 5 plan\nDONE all six claims filed\n\n", age_s=60)
    cases.append(("E  closed with DONE, then one blank line", rls._agents_running(d)))
    os.remove(os.path.join(d, "agent_logs", "r903.log"))

    # F. closed properly
    mk(d, "r904.log", "PID 6 plan\nDONE all six claims filed\n", age_s=60)
    cases.append(("F  closed with DONE, no trailing blank", rls._agents_running(d)))

for name, v in cases:
    print(f"  _agents_running = {str(v):5s}  <- {name}")

print("\n--- salvage_reviewer.py: does it always close the log? ---")
with tempfile.TemporaryDirectory() as d:
    root = d
    os.makedirs(os.path.join(root, "agent_logs")); os.makedirs(os.path.join(root, "reviews"))
    import importlib.util as iu
    sp = iu.spec_from_file_location("sv", os.path.join(os.getcwd(), "scripts/salvage_reviewer.py"))
    sv = iu.module_from_spec(sp); sp.loader.exec_module(sv)
    sv.ROOT = root
    # (i) killed reviewer that had ALREADY filed a full report -- the protocol's own
    #     instruction is to file as soon as the first verdict exists
    open(os.path.join(root, "agent_logs", "r910.log"), "w").write("PID 1\nHEARTBEAT phase 2\n")
    open(os.path.join(root, "reviews", "REVIEW_r910.md"), "w").write("# REVIEW r910 — Gate 2\n\nverdict table\n")
    print("  ", sv.salvage(910))
    tail = open(os.path.join(root, "agent_logs", "r910.log")).readlines()[-1]
    ok = bool(re.match(r"\s*(DONE|FAILED)\b", tail))
    print("     log tail now: %r  -> closed? %s" % (tail, ok))
    # (ii) killed reviewer whose log has NO trailing newline
    open(os.path.join(root, "agent_logs", "r911.log"), "w").write("PID 1\nHEARTBEAT phase 2")
    print("  ", sv.salvage(911))
    tail = open(os.path.join(root, "agent_logs", "r911.log")).readlines()[-1]
    ok = bool(re.match(r"\s*(DONE|FAILED)\b", tail))
    print("     log tail now: %r  -> closed? %s" % (tail, ok))
