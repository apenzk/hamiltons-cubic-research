# REVIEW r901: does the repaired salvage script behave as commit d86e47a6 asserts?

**Verdict: the ROOT claim and the watchdog claim are CONFIRMED exactly as stated, the glob claim is OVERSTATED, and the one salvage the repair produced misnames its own source log.** The glob does find the fourth convention, and it drops `gate2_<N>.log`, which is one of the three conventions the list it replaced knew, so the replacement is not a superset of what it replaced. Two further defects sit outside the commit's claims: the PARTIAL's provenance sentence hardcodes `agent_logs/reviewer<N>.log` rather than the log actually found, and the only invocation the loop documents still points at a path that does not exist.

**A tool-versus-assertion comparison, not new mathematics.** One reviewer, the round comparing code against the behaviour asserted of it. I read [salvage_reviewer.py](../scripts/lib/salvage_reviewer.py) whole, reconstructed the move from git history, ran the three globs as regexes over all 1499 log files in [agent_logs/](../agent_logs/), and exercised the script end to end on nine crafted cases in a throwaway sparse clone of this repository under the session scratchpad. Everything ran in seconds on objects I built for the purpose, inside the analysis-only footing the brief restates. No file in this repository was modified except this report, and no crafted file was left in [agent_logs/](../agent_logs/) or [reviews/](.). Log: [agent_logs/review-r901-salvage.log](../agent_logs/review-r901-salvage.log).

## The three quoted claims

| # | Claim | Verdict | Reason |
|---|---|---|---|
| C1 | ROOT resolved to `scripts/`, every lookup ran against directories that do not exist, and the tool has been non-functional since it was moved | **CONFIRMED, and the interval is 11 days 22 hours** | the move is [564456cc](../scripts/lib/salvage_reviewer.py) on 2026-08-31 21:10, a pure R100 rename with no compensating edit, and `scripts/agent_logs` and `scripts/reviews` exist in no commit in the repository's history, so every call in the interval returned `nothing to salvage` |
| C2 | the log name is a glob now, which cannot go stale as naming drifts | **OVERSTATED** | the glob does find `review-r<N>-<topic>.log`, and it is anchored on the letter `r` immediately before the number, so `gate2_<N>.log` is now unreachable for every `N`. That convention was in the list the glob replaced, and 141 such logs are on disk, 15 of them with no report |
| C3 | a watchdog's log matches that glob, is usually the newer file, holds no findings, so watchdog logs are excluded | **CONFIRMED and load-bearing** | with the filter removed, a crafted pair salvages the watchdog's two lines and loses the reviewer's finding. In 12 of the 16 live watchdog-versus-reviewer pairs the watchdog log is the newer file, and the mechanism guarantees it: the watchdog writes because the reviewer's log went silent |

## 1. The ROOT claim against git history

- **The move.** [564456cc](../scripts/lib/salvage_reviewer.py), 2026-08-31 21:10:26 +0200, "refactor(scripts): the library moves to scripts/lib, leaving six folders at the top", recorded by git as `R100 scripts/salvage_reviewer.py -> scripts/lib/salvage_reviewer.py`. Before it the file sat at `scripts/`, where two `dirname` calls reached the repository root correctly. The rename changed the depth and left the count at two.
- **Broken from that moment.** The only edit to the file between the move and the repair is [1c889333](../scripts/lib/salvage_reviewer.py), which rewrote two prose mentions of `FINDINGS.md` in the docstring and the report template. No path arithmetic changed, so the file was broken for the whole interval, 2448 commits and 11 days 22 hours wide.
- **No salvage could have succeeded.** With `ROOT` at `scripts/`, the existence test on the log fails for every `N`, so the function returns its `nothing to salvage` message before touching [reviews/](.). `git log --all` shows no commit ever adding `scripts/agent_logs` or `scripts/reviews`, and neither directory is present now, so there is no configuration in which the broken path resolved.
- **Corroboration from the artefacts.** Every report carrying this script's exact marker string, `PARTIAL (salvaged from its log)`, was added on or before 2026-08-31 10:22, eleven hours before the move. The salvages performed during the broken interval were written by hand in a different format, for instance [REVIEW_r440.md](REVIEW_r440.md) heading `# Review r440 — PARTIAL, salvaged from the log` in [0abc5a24](REVIEW_r440.md), and [REVIEW_r423.md](REVIEW_r423.md) with [REVIEW_r424.md](REVIEW_r424.md) in [ba0d3f3f](REVIEW_r423.md). The only script-written PARTIAL after the move is [REVIEW_r893.md](REVIEW_r893.md), from the repair commit itself.
- **Reviewers were lost in the interval.** Thirteen reviewer-numbered logs written between the move and the repair have no report in [reviews/](.) and no row in [reviews/INDEX.md](INDEX.md): r371, r372, r458, r459, r489, r495, r707, r787, r788, r793, r794, r815, r819. Most are one or two lines of phase plan. Two hold real work: [agent_logs/r459-L152.log](../agent_logs/r459-L152.log) records five substantive lines, among them that L152 attacks a strawman because r457's factor comes from the second Riesz term, that r441's chain reproduces the constant in general parameters so the "6" is not independent, and that r456 already holds the formula and the correct admissibility. [agent_logs/g2-fold2-r815.log](../agent_logs/g2-fold2-r815.log) records a hook defect and two record defects and ends at `PHASE E: writing report`. Neither number appears anywhere in the record outside its own log.
- **Consequence worth acting on.** [agent_logs/](../agent_logs/) is ignored by git at [.gitignore:7](../.gitignore#L7), so those logs exist only in this working tree. Both are still salvageable today with the repaired tool, and r459's content bears on L152's standing.

## 2. The glob against every convention on disk

I matched the three globs, written as equivalent regexes over the basename, against all 1499 `.log` files in [agent_logs/](../agent_logs/), asking for each file whether any integer `N` makes the tool find it.

**Found, including the fourth convention the commit names.** `review-r<N>-<topic>.log` and `review-r<N>.log` (34 files), `r<N>.log` (115), `reviewer<N>.log` (91, matched by the `*r<N>.log` pattern as well as the dedicated one), `r<N>-<topic>.log` and `r<N>_<topic>.log` (about 200 across many topic spellings), `g2-<topic>-r<N>.log` (about 90), `verify-L<N>r<N>-v<N>.log` and `verify-L<N>-r<N>.log` (22). Running the committed code confirms it: `n=893` yields `review-r893-l207-lean.log`, `n=871` yields `review-r871-dual.log`, `n=280` yields `r280.log`, `n=79` yields `reviewer79.log`.

**Missed, and this is the finding.** `gate2_<N>.log`, 141 files, returns nothing for every `N`. Run in the clone on a crafted `gate2_953.log`, the tool answers `no log matching agent_logs/*r953*.log — nothing to salvage` and leaves the log open, which is the exact failure the commit message condemns. The numbers in those names are reviewer numbers, not topic indices: 126 of the 141 have a matching `REVIEW_r<N>.md`, and `gate2_197.log` opens `PID 25490 | reviewer 197`. The 15 with no report are r134, r135, r136, r138, r141, r142, r143, r144, r149, r150, r205, r206, r217, r218, r219, and at least three carry substance, r138 with a hit on a padded W_CP2 witness, r141 at `all checks pass; writing reviews/REVIEW_r141.md`, r142 with derived fence-post asymptotics. The convention is retired for new work, the newest numeric one being `gate2_258.log` from 2026-08-30, so the cost is confined to retrospective salvage, which is precisely what item 1 shows is owed.

**Outside the tool's addressing scheme by construction.** `verify-L<N>-v<N>.log` (190 files), `audit-L<N>-a.log` and `audit-L<N>-b.log` (106), `gate2_I41-A.log`, `watchdog-<N>.log` and about 100 topic-named run logs carry no reviewer number at all, so no integer argument can reach them. The verification loop's verifiers are the largest single population of agents in the folder and the salvage cannot be pointed at one. That is a gap in the tool's interface rather than a defect in the glob.

**Two smaller defects in the same code.** For small `N` the glob over-matches: `n=2` picks up 15 files of the form `verify-L149r2-v82.log`, where the `r2` is a round index, and `n=3` picks up `n12_tier3.log`, because a topic word ending in `r` before the number satisfies `*r<N>.log`. Reviewer numbers are in the 900s, so the exposure is historical. Separately, the not-found message advertises `agent_logs/*r<N>*.log`, which is wider than the three patterns actually tried, so a reader who trusts the message will conclude a log is absent when it is merely unmatched.

## 3. The watchdog exclusion

- **It is load-bearing.** I copied the script in the clone, deleted the filter clause, and ran it on a fresh pair, a reviewer log holding one finding and a watchdog log written one second later. The resulting PARTIAL carries the watchdog's "looks dead" line and none of the reviewer's finding, and the closing line is appended to the watchdog's log while the reviewer's stays open. With the filter in place the same pair salvages the reviewer's content and leaves the watchdog untouched.
- **The watchdog usually is newer, and not by accident.** Across the 16 live watchdog-versus-reviewer pairings in [agent_logs/](../agent_logs/), the watchdog log is the newer file in 12. Of the four exceptions, one is `watchdog-r893-895.log` against `review-r893-l207-lean.log`, where the reviewer log is newer only because the salvage itself appended to it at 19:57 after the watchdog wrote at 19:01, and the other three are current reviewers still writing. The mechanism settles it: a watchdog writes at the moment it observes the reviewer's log to have gone silent, so its write is later than the reviewer's last by the whole silence window.
- **It can skip a real reviewer log, and silently.** The test is a substring search for `watchdog` over the basename, so under the live fourth convention a reviewer briefed on the watchdog logs to `review-r<N>-watchdog.log` and is excluded. Run in the clone on `review-r954-watchdog.log`, the tool answers `nothing to salvage` and leaves the log open. This is not idle: r876 was pointed at the watchdog and compared it against this script line by line, and only its choice of topic word, `review-r876-fold2.log`, kept it salvageable. My own log for this round is `review-r901-salvage.log`, one topic word away from the same trap. A test anchored on the name's first segment, or on the absence of a reviewer's own `PID ... r<N>` opening line, would close it.

## 4. End to end on crafted logs, in a throwaway clone

Run in a sparse local clone under the session scratchpad, with empty `agent_logs/` and `reviews/`. Nine cases, all as asserted except where noted.

| Case | What was set up | Result |
|---|---|---|
| A | `review-r950-topic.log`, four lines, deliberately without a trailing newline | PARTIAL written, first line `# Reviewer 950 — PARTIAL (salvaged from its log)`, all four log lines present verbatim inside the fence, count reported as 4, closing line appended as its own line rather than concatenated onto the final heartbeat |
| B | a full report already at `REVIEW_r951.md` | refused, report byte-identical afterwards, and the log closed on the refusal path |
| C | a full report whose own text reads "PARTIAL CONFIRMATION" | refused, the regression the marker regex was written for does not recur |
| D | the PARTIAL from case A, re-run | overwritten, as intended |
| E | `gate2_953.log` | `nothing to salvage`, report absent, log left open. See item 2 |
| F | `review-r954-watchdog.log` | `nothing to salvage`, report absent, log left open. See item 3 |
| G | reviewer log plus a newer watchdog log for the same number | reviewer content salvaged, watchdog text absent from the report |
| H | no log for the number | `nothing to salvage`, and nothing written |
| I | two numbers in one invocation | both handled, one line of output each |

**One rough edge.** A second salvage of the same reviewer folds the closing lines written by the first into the new PARTIAL's verbatim block, so "FAILED closed by scripts/salvage_reviewer.py" is presented among the lines the reviewer logged, and the reported line count grows with each run. Harmless where a PARTIAL is written once, misleading where it is written twice.

**One behaviour to know.** A hand-written salvage such as [REVIEW_r440.md](REVIEW_r440.md), whose heading reads `# Review r440 — PARTIAL`, does not match the marker regex, so the script treats it as a full report and refuses. The protection runs the safe way, and the message describes the file wrongly.

## 5. The ROOT assertion when the file moves

It fires on every displacement I tried, and the message names the directory that was reached, which is the information a reader needs.

- Copied to `scripts/salvage_reviewer.py`, one level too shallow: `AssertionError: ROOT resolved to <parent of the clone>, which has no agent_logs/`.
- Copied to `scripts/lib/sub/salvage_reviewer.py`, one level too deep: `ROOT resolved to <clone>/scripts`.
- Copied to the repository root: `ROOT resolved to <parent of the clone>`.

**Two limits.** The guard is an `assert`, so `python3 -O scripts/lib/salvage_reviewer.py 950` restores the original silent failure exactly, printing `nothing to salvage` from a wrong root. A plain `raise SystemExit` would hold under `-O`. And the check passes whenever the wrongly computed parent happens to contain an `agent_logs/` directory, which a nested checkout or a sibling scratch tree can supply, so it detects the common move rather than every move. Checking for a repository marker such as `.git` alongside `agent_logs` would narrow that.

**One consequence.** The assertion runs at import, so any importer with a stale path now aborts rather than misbehaving. That is right for the CLI and it changes the failure mode of the harness scripts that load this file by path, for example [r278_hook_cases.py](../scripts/reviewers/r278/r278_hook_cases.py) and [r279_salvage_hook.py](../scripts/reviewers/r279/r279_salvage_hook.py), which still point at `scripts/salvage_reviewer.py`.

## 6. REVIEW_r893.md, the one real salvage

- **Marked correctly.** The heading carries PARTIAL, the body states in bold that the reviewer did not file, that nothing has been reconciled against the record, and that none of it may be cited as a verdict, and it names Reviewer 78 as the precedent. The row in [reviews/INDEX.md](INDEX.md) repeats the marking and italicises that nothing there is a verdict. Nothing in the file reads as a finding of the programme.
- **Content preserved.** The log on disk holds three content lines plus the closing line the salvage appended. The report carries exactly those three lines, verbatim, and reports the count as 3, so it captured the pre-closure state and the ordering of write-then-close is right.
- **Its provenance sentence is wrong.** The report says it was salvaged from `agent_logs/reviewer893.log`. No such file exists. The log is [agent_logs/review-r893-l207-lean.log](../agent_logs/review-r893-l207-lean.log), found by the new glob. The template at [salvage_reviewer.py:98](../scripts/lib/salvage_reviewer.py#L98) hardcodes `agent_logs/reviewer{n}.log` while the search result is held in `log`, so the glob repair did not reach the line that records where the content came from. Reproduced in the clone: the PARTIAL for case G names `agent_logs/reviewer955.log` while the source was `review-r955-topic.log`. Every future PARTIAL will misname its source until that line interpolates `log`. In a record whose whole discipline is that a partial must be traceable back to its log before anything in it is rebuilt, the artefact points at a file that is not there.

## 7. What would break this verdict, and what I did to look

- **If `gate2_<N>.log` numbers were not reviewer numbers,** the C2 finding would shrink to a naming curiosity. I checked, and they are: 126 of 141 have a matching `REVIEW_r<N>.md`, and `gate2_197.log` opens by naming reviewer 197. If instead the convention were wholly dead and every one of its logs already reported, the finding would be historical only. It is retired for new work, and 15 of its logs have no report, three of them substantive, so it is not.
- **If the tool had worked at any point in the interval,** C1 would fail. I looked three ways: the diff of the only interim edit, which changes no path, a history search for `scripts/agent_logs` and `scripts/reviews`, which finds nothing, and the add-dates of every report carrying the script's exact marker, all of which predate the move except r893.
- **If the watchdog exclusion were cosmetic,** C3 would be unearned. I removed the clause and re-ran on a constructed pair, which loses the reviewer's finding without it, and I checked the live mtime ordering across all 16 pairs rather than resting on the r893 instance alone.
- **If the assertion did not fire,** item 5 would fail. Three displacements, all fired. I also tried `-O`, which is where it does not.
- **What I did not test.** Concurrency, two salvages racing on one log, and behaviour on an unreadable or non-UTF-8 log beyond the `errors='replace'` the code already passes. Both are outside the claims under review.
- **Where my own reading is the weak link.** I judged r459 and r815 "lost with findings" from their logs plus the absence of their numbers anywhere in the record. If either reviewer's content was folded in under a different number, that judgement is wrong while the structural finding, no report and no index row, stands.

## What is owed from this round

1. Interpolate the found log path into the PARTIAL's provenance sentence at [salvage_reviewer.py:98](../scripts/lib/salvage_reviewer.py#L98), and correct the line in [REVIEW_r893.md](REVIEW_r893.md) to name `agent_logs/review-r893-l207-lean.log`.
2. Add a pattern reaching a number that carries no `r` prefix, `*_{n}.log` alongside the three, or restore `gate2_{n}.log` explicitly, so the glob is a superset of the list it replaced.
3. Narrow the watchdog test so a reviewer whose topic word is "watchdog" survives it.
4. Fix the documented invocation. [research-loop/SKILL.md](../.claude/skills/research-loop/SKILL.md#L357) and the module's own docstring both instruct `python3 scripts/salvage_reviewer.py N`, which fails with `No such file or directory`. The repair commit names this and defers it, so at HEAD the tool works only for a caller who knows the path is wrong, and the loop's stated procedure still cannot salvage anyone.
5. Consider salvaging [agent_logs/r459-L152.log](../agent_logs/r459-L152.log) and [agent_logs/g2-fold2-r815.log](../agent_logs/g2-fold2-r815.log) now, since those logs live only in this working tree and r459's content bears on L152.
