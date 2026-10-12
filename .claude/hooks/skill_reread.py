#!/usr/bin/env python3
"""SessionStart hook: a compaction drops the loop's skill, so demand it back.

The rule is in .claude/rules/research-loop-reread.md and says to read the
running loop's SKILL.md in full before the next cycle or round action. It has
been in context and skipped, which is the same shape as the Deliverable trailer:
every individual step is legal, and the omission is invisible until something
goes wrong much later.

What makes it skippable is that the loop's own armed flag survives a compaction.
.claude/research-loop-active still names the session, so the loop reads as set
up while the guidance it follows has been dropped. The flag's presence is what
makes the omission feel impossible.

So this fires where the harness already knows: SessionStart reports source
"compact" when a summary has replaced the transcript.

Two signals, and they act at different moments. The message printed here reaches
the session as context immediately, which is what actually precedes the next
cycle action. The marker .claude/skill-reread-owed is the BACKSTOP, read by
loop_stop.py at a turn ending, which catches a session that read the message and
carried on anyway. Reading the skill and deleting the marker is one act, which is
what makes the read observable rather than recalled.

Session binding and the TTL come from loop_flag.armed_for, the one reader both
loops share, so this hook cannot drift from the rules the rest of the chain uses.
"""
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import loop_flag  # noqa: E402

ROOT = os.environ.get("CLAUDE_PROJECT_DIR", os.getcwd())
# Flag names come from loop_flag.py, which owns them: FLAG and VERIFY_FLAG. A name
# invented here reads as a loop that is never running, so the hook is silently dead
# for that loop -- which is how the verification half shipped inert.
LOOPS = {
    ".claude/" + loop_flag.FLAG: ".claude/skills/research-loop/SKILL.md",
    ".claude/" + loop_flag.VERIFY_FLAG: ".claude/skills/verification-loop/SKILL.md",
}
OWED = os.path.join(ROOT, ".claude/skill-reread-owed")


def main() -> int:
    try:
        payload = json.load(sys.stdin)
    except Exception:
        return 0
    if payload.get("source") != "compact":
        return 0

    for flag, skill in LOOPS.items():
        if not loop_flag.armed_for(payload, ROOT, flag=os.path.basename(flag)):
            continue
        with open(OWED, "w") as fh:
            fh.write(skill + "\n")
            # armed_for matches the payload id OR CLAUDE_CODE_SESSION_ID, so the
            # marker must record whichever one identified this session. Writing the
            # payload alone leaves the line empty on an env-only id, and the reader's
            # owner check then never matches -- inert exactly where the flag matched.
            owner = str(payload.get("session_id") or "").strip() or os.environ.get(
                "CLAUDE_CODE_SESSION_ID", ""
            ).strip()
            fh.write("session: " + owner + "\n")
        print(
            "The conversation was compacted, so the loop's guidance was dropped "
            "while its armed flag survived. Read " + skill + " IN FULL before the "
            "next cycle or round action, then delete .claude/skill-reread-owed. "
            "loop_stop.py refuses to hand back a plan item until you do."
        )
        return 0
    return 0


if __name__ == "__main__":
    sys.exit(main())
