# REVIEW r1099: L209 Ricci split and the two effort-gate hooks

Log: [agent_logs/r1099-l209hooks.log](../agent_logs/r1099-l209hooks.log). Sole reviewer of a comparison round. All computation below is a screen.

| # | commit | claim | verdict |
|---|---|---|---|
| H1 | 48d244f6 | L209 Ricci half split, one named sorry | CONFIRMED, two stale doc lines |
| H2 | 7a7ed600 | dispatch-effort gate | PLAUSIBLE: logic confirmed, level source in the hook process unverified |
| H3 | e64763de | per-tool-call effort gate | GAP: no wedge, but thrashes with concurrent subagents and misreads the declaration when the two session ids differ |

## H1, [L209FoxClosure.lean](../lean/HamiltonsCubic/Results/L209FoxClosure.lean) at 48d244f6

- Axioms: `ric_compOp_eq` and `ric_Qop_split` carry the standard three only. `ric_sharpOp_eq` and `ric_Qop_eq` carry `sorryAx`. Command: a scratch file importing the module with four `#print axioms` lines, run from `lean/` with `lake env lean`. The olean (20:05:29) postdates the committed source.
- Statement of `ric_sharpOp_eq` screened true: a literal numpy transcription of `sharpQF`, `sharpBil`, `sharpOp`, `Ric` and `R4`, at `R` a random sum of four Kulkarni-Nomizu products (pair-symmetric, Bianchi, Ricci not zero). n = 4: max residual 2.3e-13 against entries of size 1.1e3. n = 5: 3.7e-13 against 1.5e3.
- `hB` is load-bearing: adding a totally antisymmetric 4-form (pair-symmetric, Bianchi fails) gives residuals 3.8 (n = 4) and 2.8e2 (n = 5). So the sorried statement is true and its hypotheses are neither vacuous nor idle. The `id` anchors and the KN tensors both satisfy them.
- Defect, cosmetic: the module docstring, lines 19-22 of the committed file, still says `ric_Qop_eq`'s proof is a named sorry and that the kernel has nothing to unfold `sharpOp` into. The sorry now sits in `ric_sharpOp_eq`. The footer (lines 133-136) prints axioms for none of the three new theorems.
- Note: the working tree holds staged, uncommitted edits to this file from another session (180 lines). This review reads the committed version.

## H2, [effort_gate.py](../.claude/hooks/effort_gate.py) at 7a7ed600

- Registration: PreToolUse, matcher `Agent`, after `brief_lean_table.py`.
- Inert when the loop is not running: `tool_name` check at line 60 and `armed_for` at line 63 return 0 before any file I/O. Screened: unarmed xhigh Agent passes. Armed xhigh Bash passes.
- Level: payload `effort.level`, then `$CLAUDE_EFFORT` (lines 48-52), as the skill (f9950649) now says. No level anywhere passes.
- "Blocked once" means alternating: at a persistent xhigh the screen gives block, pass, block, since the retry deletes the marker (line 83). This matches the docstring.
- Reach, unverified: the gate reads the level of the request making the dispatch, not the dispatched agent's own level. Whether the hook process sees `CLAUDE_EFFORT` at all is untested by the commit. If it sees neither source, the gate is silently inert.
- Superseded at HEAD: e64763de rewrote the file and removed the `Agent` registration.

## H3, [effort_gate.py](../.claude/hooks/effort_gate.py) at e64763de

- "The stage declares" means the file `.claude/effort-expect` with `session:` and `level:` lines (lines 74-84). It is gitignored. The research-loop SKILL.md writes it before the raise and deletes it after the derivation.
- No declaration: expected is `medium`, so a medium session passes every call. A session at another level is blocked once and then passes (screened: rc 2, 0, 0). No wedge.
- Refusal names the fix: `/effort xhigh`, or `/effort medium`, or write the file.
- Defect 1, thrash with concurrent subagents (lines 104-109 and 111-115): a matching call deletes the marker, so interleaved calls at two levels re-block the mismatched side on every call. Screen: parent xhigh plus child medium under an xhigh declaration gives the child rc 2 on all three rounds. Reach: subagents run under the parent's session id. This reviewer's `$CLAUDE_CODE_SESSION_ID` equals the id in `.claude/research-loop-active`, so its own calls pass through the gate. The same thrash hits the parent in the window between the delete and the drop back if any subagent is running.
- Defect 2, session id (line 100): the declaration is matched against the payload `session_id` first. The skill writes `$CLAUDE_CODE_SESSION_ID`. [loop_flag.py](../.claude/hooks/loop_flag.py) lines 23-25 accept either because they can differ. When they differ, the declared xhigh is ignored and the raised session gets the drop-back advice. Screen: payload id B, env id A gives rc 2 with the drop-back text. Reach: conditional on the ids differing, which was not observed here.
- Defect 3, wording (line 124): any live level other than medium under no declaration gets ADVICE_DROP, "above the standing level", including `low`. Screened.
- Scope note: after one block, the same mismatch passes for good (lines 113-115). So "work left at xhigh is blocked" holds for the first call only. The commit states this ("each mismatch blocks once"). This also retires H2's dispatch-specific block: once any Bash call has taken the block, an xhigh Agent dispatch passes.
