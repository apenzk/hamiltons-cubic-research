# Gate 2 brief: the Lean for L240 piece (b), orthonormality case (C) and the audit fix (r1144)

**One reviewer: the round compares Lean declarations and a script against statements already fixed.** Analysis-only: read and check; seconds of computation on objects you construct are allowed only as a screen. Every Lean build or `lake env lean` runs in the background. Model: opus.

## What to compare

1. **[L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean)**: `i2_comm`, `pairSlot_orth_same`, `pairSlot_orth_diff`. **Claims**: `inner2` is symmetric; two pair slots of one block pair $a\ne b$ with memberships $x,x'\in a$, $y,y'\in b$ have `inner2` equal to $2$ when $(x,y)=(x',y')$ and $0$ otherwise; pair slots of different ordered block pairs ($a<b$, $c<d$, $(a,b)\ne(c,d)$) are orthogonal. Check the hypotheses are the ones the assembly over `slotφ` will have, and that `pairSlot_orth_diff` needs no membership hypotheses (its statement quantifies over all $x,y,x',y'$).
2. **[axiom_audit.py](../scripts/misc/axiom_audit.py)**, the widened `DECL` regex. **Claim**: it now captures whole declaration names containing Unicode letters (e.g. `slotφ_of_not_cross`) and still captures ASCII names, subscripts and primes as before. Screen it on a handful of names.
3. Run `python3 scripts/misc/axiom_audit.py --only L240SlotBasis` after a background build and report the axioms and whether every declaration was found (no "AUDIT INCOMPLETE").

## Items

1. Does each declaration state its claim, with no weakening, vacuity or missing hypothesis?
2. Is the regex change correct and complete?
3. The audit result, and whether the file's docstring and [lean/INDEX.md](../lean/INDEX.md)'s L240 row claim anything not delivered.

## Protocol

Log to `agent_logs/r1144.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with the word DONE or FAILED, nothing before it. Commit a skeleton `reviews/REVIEW_r1144.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md`, any Lean file or the script. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
