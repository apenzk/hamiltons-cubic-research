# Proposed skill rules

**Where a cycle in `locked` mode files a lesson.** The skill folder is read-only there, so a rule the cycle wants stated goes here instead and waits for the user to promote it. One entry is **at most three sentences**: the rule, and the failure it came from. The user promotes an entry by switching the flag to `mode: learning` and telling the cycle which one, or by editing the skill directly.

## How these are scored

**Three numbers and their product.**

- **Occurrences**, distinct incidents on the record. A `!` marks a **critical** one: it would have falsified a recorded claim, corrupted a bound in the unsafe direction, or let a defect survive an audit that was looking for it. **The third disjunct alone is about the net**, so an audit that CAUGHT its target earns no `!` *on that ground*. *The first two stand independently and are counterfactual: what the defect would have done had it survived, which an audit catching it does not change.*
- **An occurrence is an incident the PROPOSED RULE would have prevented, and the test is the fix rather than the description.** Ask of each: does the rule as written stop this one, and is the repair the same repair? **Where two incidents need different repairs they are two proposals**, however naturally one sentence covers both. *Widening the description until it holds three incidents is how a single occurrence reaches the promotion bar, and the widened rule then misdirects every later run, because it names a category instead of a failure.* **Write the fix beside each occurrence before scoring**, and let a differing fix split the row rather than raise the count.
- **Impact, 0–10**, what the failure has already cost. **A defect seen once is worth little, however vivid**, because one incident is as easily an accident as a pattern. *Occurrences drive it:* 5+ scores 10, 3–4 scores 8, twice scores 6, **once scores 3**. **A critical single occurrence overrides that and scores 7**, and a critical recurrence scores 9–10.
- **Importance, 0–10**, what the rule protects going forward, judged independently of what it has cost. A rule can be central and cheap so far.
- **Total = impact × importance**, out of 100. **The product is the ranking, AND THE TABLE BELOW IS ORDERED BY IT, HIGHEST FIRST, so the promotion pass reads the top rather than the whole file**, because a rule needs both halves: something costly that protects little is a one-off to absorb, and something central that has never bitten is a prediction. *Multiplying refuses to trade one for the other, which adding would allow.*

**`HOLD` overrides the automatic promotion, and a row carries it when its SCORE is not yet trustworthy.** *A total is only as good as its occurrence count and its `!` marks, and both are judgements made when the row was filed.* **A row reaching the bar through a correction rather than through a new incident is held**, because nothing about the failure changed: only the arithmetic did. *Clear a `HOLD` by writing the fix beside each occurrence, splitting the row where the fixes differ, and re-checking the `!` against its three disjuncts. Then the total means what it says.*

**Goes in** names the file the rule would be written into; a rule reaching two loops names both. **Applied automatically at a total of 80 or more, and `HOLD` vetoes that regardless of score.** *Everything below waits, and waits precisely to see whether it recurs*, **a proposal that never recurs is one the record was right not to spend an edit on.**

| # | Total | Impact | Imprt | Occ | Action | Goes in | Proposal |
|---|---|---|---|---|---|---|---|
| 75 | **81** | 9 | 9 | 2! | **HOLD** | [verification-loop](skills/verification-loop/SKILL.md) + [research-loop](skills/research-loop/SKILL.md) | Nobody writes the shared index until every report is final. *PROMOTED 2026-09-08 into both loops, so its entry here is gone and this row is the ledger of it.* |
| 179 | **81** | 9 | 9 | 2! | **RETIRED 2026-09-25 as already held**: both loops quote the brief verbatim from the block, so its entry here is gone and this row is the ledger of it | [research-loop](skills/research-loop/SKILL.md) | A brief states the object under review from the record, verbatim. |
| 180 | **81** | 9 | 9 | 3! | **PROMOTED 2026-09-25 at the user's instruction into [research-loop](skills/research-loop/SKILL.md) and [verification-loop](skills/verification-loop/SKILL.md), so its entry here is gone and this row is the ledger of it** | [research-loop](skills/research-loop/SKILL.md) + [verification-loop](skills/verification-loop/SKILL.md) | A brief carries the author's inferences only as questions with their premises stated. |
| 153 | **80** | 10 | 8 | 10 | **PROMOTED 2026-09-20 into [research-loop](skills/research-loop/SKILL.md), so its entry here is gone and this row is the ledger of it** | [research-loop](skills/research-loop/SKILL.md) | An absence claim is dated the moment it is written, so it names a declaration and the commit that adds one greps for it. |
| 188 | **80** | 10 | 8 | 6 | **PROMOTED 2026-09-25 at the user's instruction into [verification-loop](skills/verification-loop/SKILL.md)'s Phase 0, research-loop already holding it, so its entry here is gone and this row is the ledger of it** | [verification-loop](skills/verification-loop/SKILL.md) | Read the record's own index before calling anything new or unrecorded. |
| 173 | **72** | 8 | 9 | 4 | waits | [research-loop](skills/research-loop/SKILL.md) | [A route's row records the screens that were run, so an unscreened route is visible before it is ranked](#a-routes-row-records-the-screens-that-were-run-so-an-unscreened-route-is-visible-before-it-is-ranked) |
| 172 | **72** | 8 | 9 | 4 | waits | [research-loop](skills/research-loop/SKILL.md) | [A novelty claim is checked in BOTH directions, not just the one the argument came from](#a-novelty-claim-is-checked-in-both-directions-not-just-the-one-the-argument-came-from) |
| 171 | **72** | 8 | 9 | 1! | waits | [argument-practice](skills/research-loop/argument-practice.md) | [Permute a printed formula against the symmetry its object is proved to have, before deriving from it](#permute-a-printed-formula-against-the-symmetry-its-object-is-proved-to-have-before-deriving-from-it) |
| 162 | **72** | 8 | 9 | 3 | waits | [computational-practice](skills/research-loop/computational-practice.md) | [Before trusting a zero, feed the pattern a case it must match](#before-trusting-a-zero-feed-the-pattern-a-case-it-must-match) |
| 154 | **72** | 8 | 9 | 3 | waits | [lean-practice](skills/lean-practice.md) | [A tactic budget is spent per declaration, so a computation that exhausts it is split into declarations](#a-tactic-budget-is-spent-per-declaration-so-a-computation-that-exhausts-it-is-split-into-declarations) |
| 93 | **72** | 8 | 9 | 3 | **APPLIED at the user's instruction 2026-09-10** | [research-loop](skills/research-loop/SKILL.md) | [A status reports how many items can be STARTED, not how many are live](#a-status-reports-how-many-items-can-be-started-not-how-many-are-live) |
| 79 | **72** | 9 | 8 | 3! | **HOLD** | [argument-practice](skills/research-loop/argument-practice.md) | [Ask whether a bound's hypotheses are satisfiable before recording the bound](#ask-whether-a-bounds-hypotheses-are-satisfiable-before-recording-the-bound) |
| 71 | **72** | 9 | 8 | 2! | **HOLD** | [research-loop](skills/research-loop/SKILL.md) | [A finding that names a set is folded by copying the set, not by re-deriving it](#a-finding-that-names-a-set-is-folded-by-copying-the-set-not-by-re-deriving-it) |
| 56 | **72** | 9 | 8 | 3! | **HOLD** | [research-loop](skills/research-loop/SKILL.md) + [editing-skills](skills/editing-skills/SKILL.md) | [Read a file's head before appending to its foot](#read-a-files-head-before-appending-to-its-foot) |
| 110 | **72** | 8 | 9 | 3 | **APPLIED at the user's instruction 2026-09-13**, below the bar and approved directly | [research-loop](skills/research-loop/SKILL.md) | A closing log line must OPEN with DONE or FAILED, and whoever kills an agent writes it. *Entry removed on promotion, the incident being in [ATTEMPTS.md](../ATTEMPTS.md).* |
| 165 | **72** | 8 | 9 | 4 | waits | [lean-loop](skills/lean-loop/SKILL.md) | [A recorded blocker is re-checked against the library it names before the round trusts it](#a-recorded-blocker-is-re-checked-against-the-library-it-names-before-the-round-trusts-it) |
| 164 | **72** | 8 | 9 | 3 | waits | [lean-loop](skills/lean-loop/SKILL.md) | [The scan needs a fourth bucket: the RECORD's argument is an outline, not the library's gap](#the-scan-needs-a-fourth-bucket-the-records-argument-is-an-outline-not-the-librarys-gap) |
| 60 | **72** | 8 | 9 | 3 | **HOLD** | [verification-loop](skills/verification-loop/SKILL.md) | [An annotation enters a round as a claim, because annotations decay faster than prose](#an-annotation-enters-a-round-as-a-claim-because-annotations-decay-faster-than-prose) |
| 175 | **72** | 8 | 9 | 3 | **HOLD**, inherited from 160, whose two `!` marks are one author's same-session judgement | [lean-practice](skills/lean-practice.md) | [A typed statement is evaluated where the prose claim changes truth value, before its sorry or its proof](#a-typed-statement-is-evaluated-where-the-prose-claim-changes-truth-value-before-its-sorry-or-its-proof) |
| 176 | **72** | 9 | 8 | 2! | waits | [research-loop](skills/research-loop/SKILL.md) + [verification-loop](skills/verification-loop/SKILL.md) | [An agent is dead only by its closing line or the harness, never by its silence, and a round folds only then](#an-agent-is-dead-only-by-its-closing-line-or-the-harness-never-by-its-silence-and-a-round-folds-only-then) |
| 177 | **72** | 9 | 8 | 4! | waits | [research-loop](skills/research-loop/SKILL.md) + [verification-loop](skills/verification-loop/SKILL.md) | [A supervisor's completion test is the hook's own closing-line test, reused and run against a real log, never a new detector or an early artifact](#a-supervisors-completion-test-is-the-hooks-own-closing-line-test-reused-and-run-against-a-real-log-never-a-new-detector-or-an-early-artifact) |
| 178 | **72** | 9 | 8 | 2! | waits | [research-loop](skills/research-loop/SKILL.md) + [hooks/](hooks/) | [A novelty claim names the files it grepped, and they include the destination file and the cycle's own diff](#a-novelty-claim-names-the-files-it-grepped-and-they-include-the-destination-file-and-the-cycles-own-diff) |
| 181 | **72** | 8 | 9 | 3 | waits | [argument-practice](skills/research-loop/argument-practice.md) + [research-loop](skills/research-loop/SKILL.md) | [A claim that something is open or missing is screened by reading the text beside it: the neighbouring lemma's argument and the section's opening](#a-claim-that-something-is-open-or-missing-is-screened-by-reading-the-text-beside-it-the-neighbouring-lemmas-argument-and-the-sections-opening) |
| 207 | **72** | 9 | 8 | 2! | waits | [research-loop](skills/research-loop/SKILL.md) | [A value cited as proved carries the result that proves it, and a table row is not one](#a-value-cited-as-proved-carries-the-result-that-proves-it-and-a-table-row-is-not-one) |
| 113 | **70** | 7 | 10 | 1! | **APPLIED 2026-09-13 at the user's instruction**, below the automatic bar and asked for directly | [research-loop](skills/research-loop/SKILL.md) | `closes` is measured against the REMAINING OPEN STATEMENT alone, and securing what is already proved scores $0$ and leaves section 1. *Entry removed on promotion, the incident being in [ATTEMPTS.md](../ATTEMPTS.md).* |
| 120 | **70** | 7 | 10 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [A fold is audited against each reviewer's own section list, item by item](#a-fold-is-audited-against-each-reviewers-own-section-list-item-by-item) |
| 55 | **70** | 10 | 7 | 6 | **HOLD** | [verification-loop](skills/verification-loop/SKILL.md) | [A correction carries the phrase it removes into the chronology](#a-correction-carries-the-phrase-it-removes-into-the-chronology) |
| 108 | **70** | 10 | 7 | 13 | waits | [computational-practice](skills/research-loop/computational-practice.md) | [Shell calls in one batch share one shell, so use absolute paths and explicit lists](#shell-calls-in-one-batch-share-one-shell-so-use-absolute-paths-and-explicit-lists) |
| 190 | **70** | 10 | 7 | 5+ | **HOLD**, a bundle of five rules: each is split out and scored on its own occurrences before it can move | [lean-practice](skills/lean-practice.md) | [Five Lean-round statement checks, filed as bullets beneath another entry](#five-lean-round-statement-checks-filed-as-bullets-beneath-another-entry) |
| 7 | **64** | 8 | 8 | 3 | waits | [argument-practice](skills/research-loop/argument-practice.md) | [Arguments that BOUND an object survive errors that kill arguments which COMPUTE it](#arguments-that-bound-an-object-survive-errors-that-kill-arguments-which-compute-it) |
| 150 | **64** | 8 | 8 | 3 | waits | [research-loop](skills/research-loop/argument-practice.md) | [A SUFFICIENT HYPOTHESIS IS NOT ASSERTED NECESSARY IN THE SENTENCE THAT STATES IT](#a-sufficient-hypothesis-is-not-asserted-necessary-in-the-sentence-that-states-it) |
| 151 | **64** | 8 | 8 | 3 | | [research-loop](skills/research-loop/SKILL.md) + [verification-loop](skills/verification-loop/SKILL.md) | [A failed instance search is a failed SEARCH, so name the instance before recording a route as closed](#a-failed-instance-search-is-a-failed-search-so-name-the-instance-before-recording-a-route-as-closed) |
| 196 | **64** | 8 | 8 | 3 | waits | [research-loop](skills/research-loop/SKILL.md) | [A tracked file is committed by path without being staged, since staging exposes it to another session's whole-index commit](#a-tracked-file-is-committed-by-path-without-being-staged-since-staging-exposes-it-to-another-sessions-whole-index-commit) |
| 167 | **63** | 7 | 9 | 1! | waits | [lean-practice](skills/lean-practice.md) | [Deleting a definition is an API change, and its blast radius is every file that OPENS its namespace](#deleting-a-definition-is-an-api-change-and-its-blast-radius-is-every-file-that-opens-its-namespace) |
| 137 | **63** | 7 | 9 | 1! | waits | [computational-practice](skills/research-loop/computational-practice.md) | [A screen of a polynomial identity is evidence only above the interpolation count, which is computable before it runs](#a-screen-of-a-polynomial-identity-is-evidence-only-above-the-interpolation-count-which-is-computable-before-it-runs) |
| 136 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [A route's factual claims about named objects are screened against those objects before it is registered](#a-routes-factual-claims-about-named-objects-are-screened-against-those-objects-before-it-is-registered) |
| 135 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [The domain check fires at every substitution into a recorded bound, not only when a route is graded](#the-domain-check-fires-at-every-substitution-into-a-recorded-bound-not-only-when-a-route-is-graded) |
| 134 | **63** | 7 | 9 | 1! | waits | [argument-practice](skills/research-loop/argument-practice.md) | [A non-existence claim reached by testing one candidate formula is not a non-existence claim](#a-non-existence-claim-reached-by-testing-one-candidate-formula-is-not-a-non-existence-claim) |
| 133 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [A brief quoting a figure a script produced quotes the script's own constraints, each marked theorem or implementation](#a-brief-quoting-a-figure-a-script-produced-quotes-the-scripts-own-constraints-each-marked-theorem-or-implementation) |
| 94 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [A route proposed to the user is screened before the sentence goes out, not after they choose](#a-route-proposed-to-the-user-is-screened-before-the-sentence-goes-out-not-after-they-choose) |
| 118 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [A step that divides by a quantity checks it against the OPEN CASE, never against a lemma](#a-step-that-divides-by-a-quantity-checks-it-against-the-open-case-never-against-a-lemma) |
| 78 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) + [verification-loop](skills/verification-loop/SKILL.md) | [Run the brief's attack list against the block before dispatching it](#run-the-briefs-attack-list-against-the-block-before-dispatching-it) |
| 84 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) + [verification-loop](skills/verification-loop/SKILL.md) | [Check a reviewer's correction before applying it, the fold is a judgement, not a transcription](#check-a-reviewers-correction-before-applying-it-the-fold-is-a-judgement-not-a-transcription) |
| 58 | **63** | 7 | 9 | 1! | waits | [verification-loop](skills/verification-loop/SKILL.md) + [research-loop](skills/research-loop/SKILL.md) | [A global substitution is forbidden from the text that argues about the value](#a-global-substitution-is-forbidden-from-the-text-that-argues-about-the-value) |
| 72 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [A brief auditing a fold is written from the reports, not from the folder's account of them](#a-brief-auditing-a-fold-is-written-from-the-reports-not-from-the-folders-account-of-them) |
| 112 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) + [verification-loop](skills/verification-loop/SKILL.md) | [A reviewer never amends, because HEAD in a shared repository may be another writer's commit](#a-reviewer-never-amends-because-head-in-a-shared-repository-may-be-another-writers-commit) |
| 122 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) + [hooks/](hooks/) | [The loop's armed flag is invisible when absent, so the status answer reports it](#the-loops-armed-flag-is-invisible-when-absent-so-the-status-answer-reports-it) |
| 127 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [A failed check of a reviewer's claim is DIAGNOSED before it is reported, by fitting the term that would make it hold](#a-failed-check-of-a-reviewers-claim-is-diagnosed-before-it-is-reported-by-fitting-the-term-that-would-make-it-hold) |
| 128 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/computational-practice.md) | [A condition stated as an INEQUALITY is checked by the signature, never by the rank](#a-condition-stated-as-an-inequality-is-checked-by-the-signature-never-by-the-rank) |
| 130 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/computational-practice.md) | [A control that fails must FAIL the run, never print beside its own expected value](#a-control-that-fails-must-fail-the-run-never-print-beside-its-own-expected-value) |
| 144 | **63** | 7 | 9 | 2! | waits | [research-loop](skills/research-loop/computational-practice.md) | [A control must SEPARATE the claim from its competitor, not merely be a value the record carries](#a-control-must-separate-the-claim-from-its-competitor-not-merely-be-a-value-the-record-carries) |
| 149 | **63** | 7 | 9 | 3! | waits | [research-loop](skills/research-loop/computational-practice.md) | [A CHECK'S EXIT STATUS IS DATA, SO A COMMIT NEVER SITS BEHIND ONE](#a-checks-exit-status-is-data-so-a-commit-never-sits-behind-one) |
| 158 | **63** | 7 | 9 | 3 | waits | [lean-practice](skills/lean-practice.md) | [A tactic that succeeds without closing its goal swallows every alternative after it](#a-tactic-that-succeeds-without-closing-its-goal-swallows-every-alternative-after-it) |
| 166 | **63** | 7 | 9 | 1! | waits | [lean-loop](skills/lean-loop/SKILL.md) + a hook | [A machine-checked file unreachable from the project root is checked by nothing, and says so nowhere](#a-machine-checked-file-unreachable-from-the-project-root-is-checked-by-nothing-and-says-so-nowhere) |
| 168 | **63** | 7 | 9 | 1! | waits | [lean-loop](skills/lean-loop/SKILL.md) + a hook | [A statement whose scope was narrowed keeps the witness that narrowed it](#a-statement-whose-scope-was-narrowed-keeps-the-witness-that-narrowed-it) |
| 174 | **63** | 9 | 7 | 4! | waits | [lean-practice](skills/lean-practice.md) + [hooks/](hooks/) | [A commit gate checks the commit it is about to record, the staged content after the command's own staging](#a-commit-gate-checks-the-commit-it-is-about-to-record-the-staged-content-after-the-commands-own-staging) |
| 193 | **63** | 7 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) + [computational-practice](skills/research-loop/computational-practice.md) | [A threshold a screen or a claim is measured against is checked against the record's warnings and its catalogued values before the first run](#a-threshold-a-screen-or-a-claim-is-measured-against-is-checked-against-the-records-warnings-and-its-catalogued-values-before-the-first-run) |
| 206 | **63** | 7 | 9 | 1! | waits | [computational-practice](skills/research-loop/computational-practice.md) | [A heredoc that carries record text is quoted, and values enter it through the environment](#a-heredoc-that-carries-record-text-is-quoted-and-values-enter-it-through-the-environment) |
| 152 | **60** | 10 | 6 | 6 | **GATED 2026-09-20 in [mechanical_check.py](hooks/mechanical_check.py) rather than promoted: the shape is decidable from the file and needs no judgement, so a gate beats a rule** | [lean-practice](skills/lean-practice.md) | [A scope or option modifier goes before a declaration's docstring, never between them](#a-scope-or-option-modifier-goes-before-a-declarations-docstring-never-between-them) |
| 80 | **56** | 7 | 8 | 1! | waits | [argument-practice](skills/research-loop/argument-practice.md) | [Re-check every premise against the configuration it is used in, not the one it came from](#re-check-every-premise-against-the-configuration-it-is-used-in-not-the-one-it-came-from) |
| 81 | **56** | 7 | 8 | 1! | waits | [lean-layer](skills/lean-layer.md) | [An index row states what a declaration states, never what a reader can infer from it](#an-index-row-states-what-a-declaration-states-never-what-a-reader-can-infer-from-it) |
| 77 | **56** | 7 | 8 | 1! | waits | [argument-practice](skills/research-loop/argument-practice.md) | [State a numeric bound at the precision its inputs certify, and never as an equality](#state-a-numeric-bound-at-the-precision-its-inputs-certify-and-never-as-an-equality) |
| 62 | **56** | 7 | 8 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [Ask what the consumer consumes before choosing among candidate statements](#ask-what-the-consumer-consumes-before-choosing-among-candidate-statements) |
| 59 | **56** | 8 | 7 | 3 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [Stage by path when other agents share the index](#stage-by-path-when-other-agents-share-the-index) |
| 9 | **56** | 8 | 7 | 4 | waits | [research-loop](skills/research-loop/SKILL.md) + [results-spec](skills/research-loop/results-spec.md) | [A quantity withdrawn under one reading returns under the same name until the record renames it](#a-quantity-withdrawn-under-one-reading-returns-under-the-same-name-until-the-record-renames-it) |
| 32 | **56** | 8 | 7 | 4 | waits | [computational-practice](skills/research-loop/computational-practice.md) | [Screen at a dimension where the claimed structure is not degenerate](#screen-at-a-dimension-where-the-claimed-structure-is-not-degenerate) |
| 123 | **56** | 7 | 8 | 1! | waits | [research-loop](skills/research-loop/computational-practice.md) | [A number reaches the record from the filed screen, never from the exploratory script that found it](#a-number-reaches-the-record-from-the-filed-screen-never-from-the-exploratory-script-that-found-it) |
| 124 | **56** | 7 | 8 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [Correcting a number does not correct the verdicts computed from it](#correcting-a-number-does-not-correct-the-verdicts-computed-from-it) |
| 129 | **56** | 7 | 8 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [A brief naming specific POINTS hands over the equations that select them](#a-brief-naming-specific-points-hands-over-the-equations-that-select-them) |
| 170 | **56** | 8 | 7 | 3 | waits | [lean-practice](skills/lean-practice.md) | [A simp lemma reported UNUSED is saying the term never reached its shape, so repair upstream of it](#a-simp-lemma-reported-unused-is-saying-the-term-never-reached-its-shape-so-repair-upstream-of-it) |
| 182 | **56** | 8 | 7 | 4 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [Before discharging a debt, read the reports that raised it](#before-discharging-a-debt-read-the-reports-that-raised-it) |
| 192 | **56** | 7 | 8 | 1! | waits | [computational-practice](skills/research-loop/computational-practice.md) | [A constraint written for one witness is re-derived at the sweep's general parameters, and a control through the sweep's code path runs first](#a-constraint-written-for-one-witness-is-re-derived-at-the-sweeps-general-parameters-and-a-control-through-the-sweeps-code-path-runs-first) |
| 194 | **56** | 7 | 8 | 1! | waits | [computational-practice](skills/research-loop/computational-practice.md) | [A max-min search from random starts is seeded with the structured candidates first, and its 'none found' is never read as absence](#a-max-min-search-from-random-starts-is-seeded-with-the-structured-candidates-first-and-its-none-found-is-never-read-as-absence) |
| 199 | **56** | 8 | 7 | 3 | waits | [research-loop](skills/research-loop/SKILL.md) | [A quoted given is extracted up to its Proof marker and checked against the block's end, never cut at the first newline](#a-quoted-given-is-extracted-up-to-its-proof-marker-and-checked-against-the-blocks-end-never-cut-at-the-first-newline) |
| 203 | **56** | 8 | 7 | 3 | waits | [lean-practice](skills/lean-practice.md) | [A module's import line enters the shared root file only in the commit that adds the module](#a-modules-import-line-enters-the-shared-root-file-only-in-the-commit-that-adds-the-module) |
| 204 | **56** | 7 | 8 | 1! | waits | [computational-practice](skills/research-loop/computational-practice.md) | [A feasibility screen evaluates the inequality as recorded, and its returned objects are checked against the definition](#a-feasibility-screen-evaluates-the-inequality-as-recorded-and-its-returned-objects-are-checked-against-the-definition) |
| 159 | **54** | 6 | 9 | 2 | waits | [lean-practice](skills/lean-practice.md) | [Split a computation at the granularity of the object's own definition, not one level up](#split-a-computation-at-the-granularity-of-the-objects-own-definition-not-one-level-up) |
| 157 | **54** | 6 | 9 | 2 | waits | [lean-practice](skills/lean-practice.md) | [A result proved over one field is blocked in another only if its proof uses what the fields differ in](#a-result-proved-over-one-field-is-blocked-in-another-only-if-its-proof-uses-what-the-fields-differ-in) |
| 146 | **54** | 6 | 9 | 2 | waits | [research-loop](skills/research-loop/SKILL.md) | [A HIGH-WATER MARK IS A CLAIM ABOUT THE ROWS, AND THE NEXT ID IS TAKEN FROM THE ROWS](#a-high-water-mark-is-a-claim-about-the-rows-and-the-next-id-is-taken-from-the-rows) |
| 106 | **54** | 6 | 9 | 2 | waits | [argument-practice](skills/research-loop/argument-practice.md) | [When the target is a supremum, a bound failing at some points is not refuted, because a case split is legitimate](#when-the-target-is-a-supremum-a-bound-failing-at-some-points-is-not-refuted-because-a-case-split-is-legitimate) |
| 86 | **54** | 6 | 9 | 2 | waits | [argument-practice](skills/research-loop/argument-practice.md) | [Before recording a consequence, name what would have to be true for it to fail](#before-recording-a-consequence-name-what-would-have-to-be-true-for-it-to-fail) |
| 10 | **54** | 6 | 9 | 2 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [The round's own repairs get the scrutiny the round gave the text](#the-rounds-own-repairs-get-the-scrutiny-the-round-gave-the-text) |
| 201 | **50** | 10 | 5 | 8 | waits | [structure_gate.py](hooks/structure_gate.py) + [computational-practice](skills/research-loop/computational-practice.md) | [A commit refuses text carrying a control byte followed by a letter](#a-commit-refuses-text-carrying-a-control-byte-followed-by-a-letter) |
| 11 | **49** | 7 | 7 | 1! | waits | [results-spec](skills/research-loop/results-spec.md) | [An entry prints the constants its own numerals depend on](#an-entry-prints-the-constants-its-own-numerals-depend-on) |
| 90 | **48** | 6 | 8 | 2 | waits | [research-loop](skills/research-loop/SKILL.md) | [Grep for the recorded quantity a first step EXPANDS, not for the object the expansion produces](#grep-for-the-recorded-quantity-a-first-step-expands-not-for-the-object-the-expansion-produces) |
| 95 | **48** | 6 | 8 | 2 | waits | [research-loop](skills/research-loop/SKILL.md) | [A recorded "searched, nothing found" names the phrasing that was searched](#a-recorded-searched-nothing-found-names-the-phrasing-that-was-searched) |
| 101 | **48** | 6 | 8 | 6 | waits | [research-loop](skills/research-loop/SKILL.md) | [A Gate 2 debt is discharged by reviewers IN FLIGHT, not only by reports on disk](#a-gate-2-debt-is-discharged-by-reviewers-in-flight-not-only-by-reports-on-disk) |
| 115 | **48** | 6 | 8 | 2 | waits | [research-loop](skills/research-loop/SKILL.md) | [A brief quotes a given by its block's boundaries, never by the first matching marker after a heading](#a-brief-quotes-a-given-by-its-blocks-boundaries-never-by-the-first-matching-marker-after-a-heading) |
| 12 | **48** | 6 | 8 | 2 | waits | [argument-practice](skills/research-loop/argument-practice.md) | [A clause added after the QED is an unproved claim wearing a proof's authority](#a-clause-added-after-the-qed-is-an-unproved-claim-wearing-a-proofs-authority) |
| 13 | **48** | 6 | 8 | 2 | waits | [research-loop](skills/research-loop/SKILL.md) | [A correction the cycle just recorded is the one it is most likely to repeat](#a-correction-the-cycle-just-recorded-is-the-one-it-is-most-likely-to-repeat) |
| 29 | **48** | 8 | 6 | 4 | waits | [computational-practice](skills/research-loop/computational-practice.md) | [Name the falsifying outcome before running a screen, or the screen tests nothing](#name-the-falsifying-outcome-before-running-a-screen-or-the-screen-tests-nothing) |
| 186 | **48** | 6 | 8 | 2 | waits | [lean-practice](skills/lean-practice.md) | [Every derived constant in a Lean file is a theorem, never only a comment](#every-derived-constant-in-a-lean-file-is-a-theorem-never-only-a-comment) |
| 195 | **48** | 6 | 8 | 2 | waits | [lean-loop](skills/lean-loop/SKILL.md) | [Before formalising an id, list every lean file carrying its name and read the statement row, since a sibling file may already prove the round's target](#before-formalising-an-id-list-every-lean-file-carrying-its-name-and-read-the-statement-row-since-a-sibling-file-may-already-prove-the-rounds-target) |
| 198 | **48** | 8 | 6 | 3 | waits | [research-loop](skills/research-loop/SKILL.md) + [lean-loop](skills/lean-loop/SKILL.md) | [A reviewer number is claimed by creating its report file exclusively, never by reading the highest one in use](#a-reviewer-number-is-claimed-by-creating-its-report-file-exclusively-never-by-reading-the-highest-one-in-use) |
| 147 | **45** | 5 | 9 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [A CLAIM INHERITED FROM THE RECORD AND REPEATED INTO A NEW FILE IS A CLAIM THE CYCLE IS NOW MAKING](#a-claim-inherited-from-the-record-and-repeated-into-a-new-file-is-a-claim-the-cycle-is-now-making) |
| 14 | **42** | 7 | 6 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [A position file quotes a definition from the record, never restates it in its own symbols](#a-position-file-quotes-a-definition-from-the-record-never-restates-it-in-its-own-symbols) |
| 15 | **42** | 7 | 6 | 1! | waits | [hooks/](hooks/) + [verification-loop](skills/verification-loop/SKILL.md) | [A queue row's id must be readable by the tooling that names the next task](#a-queue-rows-id-must-be-readable-by-the-tooling-that-names-the-next-task) |
| 111 | **42** | 6 | 7 | 2 | waits | [computational-practice](skills/research-loop/computational-practice.md) | [A sweep that rewrites headings repoints the links into them, in the same commit](#a-sweep-that-rewrites-headings-repoints-the-links-into-them-in-the-same-commit) |
| 69 | **42** | 6 | 7 | 2 | waits | [verification-loop](skills/verification-loop/SKILL.md) + [research-loop](skills/research-loop/SKILL.md) | [Options come before the pathspec, and a pathspec commit stages nothing](#options-come-before-the-pathspec-and-a-pathspec-commit-stages-nothing) |
| 185 | **42** | 6 | 7 | 2 | waits | [lean-loop](skills/lean-loop/SKILL.md) | [A row filed as blocked names the piece it waits on, not the field it belongs to](#a-row-filed-as-blocked-names-the-piece-it-waits-on-not-the-field-it-belongs-to) |
| 208 | **42** | 6 | 7 | 2 | waits | [research-loop](skills/research-loop/SKILL.md) | [A reviewer number is proved free by a command that cannot fail silently, and sessions sharing a counter reserve blocks](#a-reviewer-number-is-proved-free-by-a-command-that-cannot-fail-silently-and-sessions-sharing-a-counter-reserve-blocks) |
| 22 | **42** | 6 | 7 | 2 | waits | [research-loop](skills/research-loop/SKILL.md) | [Check a new claim against the record's own theorems before recording it](#check-a-new-claim-against-the-records-own-theorems-before-recording-it) |
| 169 | **36** | 6 | 6 | 2 | waits | [research-loop](skills/research-loop/SKILL.md) + [lean-loop](skills/lean-loop/SKILL.md) | [A procedure you paraphrase is a procedure you can silently drop an item from](#a-procedure-you-paraphrase-is-a-procedure-you-can-silently-drop-an-item-from) |
| 114 | **36** | 6 | 6 | 2 | waits | [research-loop](skills/research-loop/SKILL.md) + [structure_gate.py](hooks/structure_gate.py) | [Stage record files in the call before their commit, never while reviewers are in flight](#stage-record-files-in-the-call-before-their-commit-never-while-reviewers-are-in-flight) |
| 99 | **30** | 3 | 10 | 1 | waits | [lean-layer](skills/lean-layer.md) | [Key a machine-checked index row by the RESULT's id, never by the item that motivated it](#key-a-machine-checked-index-row-by-the-results-id-never-by-the-item-that-motivated-it) |
| 102 | **30** | 3 | 10 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [A reviewer index row is matched by its ID column, never by a grep for its filename](#a-reviewer-index-row-is-matched-by-its-id-column-never-by-a-grep-for-its-filename) |
| 85 | **30** | 3 | 10 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [Step 1's question asks what the item proves, and must also ask what stands between that and the goal](#step-1s-question-asks-what-the-item-proves-and-must-also-ask-what-stands-between-that-and-the-goal) |
| 191 | **30** | 6 | 5 | 2 | waits | [lean-practice](skills/lean-practice.md) | [A scope or option modifier goes before a declaration's docstring, never between them](#a-scope-or-option-modifier-goes-before-a-declarations-docstring-never-between-them) |
| 148 | **27** | 3 | 9 | 1 | **APPLIED 2026-09-19 at the user's instruction**, below the automatic bar and asked for directly | [research-loop](skills/research-loop/SKILL.md) | [A USER DECISION IS NAMED BY A TRIGGER, NEVER BY A CATEGORY](#a-user-decision-is-named-by-a-trigger-never-by-a-category) |
| 107 | **27** | 3 | 9 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [For a multiplicity or dimension question the analytical attempt is a character count over the symmetry group, and it is usually one line](#for-a-multiplicity-or-dimension-question-the-analytical-attempt-is-a-character-count-over-the-symmetry-group-and-it-is-usually-one-line) |
| 66 | **27** | 3 | 9 | 1 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [A check is scaled to the part of the claim that is not machine-checked](#a-check-is-scaled-to-the-part-of-the-claim-that-is-not-machine-checked) |
| 18 | **27** | 3 | 9 | 1 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [A per-lemma brief cannot see a contradiction that lives between lemmas](#a-per-lemma-brief-cannot-see-a-contradiction-that-lives-between-lemmas) |
| 19 | **27** | 3 | 9 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [Gate 2 answers the question it was asked, and the question is the author's to frame](#gate-2-answers-the-question-it-was-asked-and-the-question-is-the-authors-to-frame) |
| 20 | **27** | 3 | 9 | 1 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [Three verifiers reaching the same argument is corroboration, not verification](#three-verifiers-reaching-the-same-argument-is-corroboration-not-verification) |
| 141 | **27** | 3 | 9 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [A `Gate 2 pending` marker in a findings file obliges a LEDGER ROW in the same edit](#a-gate-2-pending-marker-in-a-findings-file-obliges-a-ledger-row-in-the-same-edit) |
| 163 | **27** | 3 | 9 | 1! | waits | [research-loop](skills/research-loop/SKILL.md) | [A "this hypothesis is load-bearing" claim is screened by searching for the record saying it FAILS](#a-this-hypothesis-is-load-bearing-claim-is-screened-by-searching-for-the-record-saying-it-fails) |
| 200 | **24** | 3 | 8 | 1 | **PROMOTED 2026-09-28 at the user's instruction into [research-loop](skills/research-loop/SKILL.md), [loop_flag.py](hooks/loop_flag.py) and [loop_stop.py](hooks/loop_stop.py) (7503d119), so its entry here is gone and this row is the ledger of it** | [research-loop](skills/research-loop/SKILL.md) + hooks | The strategy stop fires on the reach gate alone, and a route switch is never a target change. |
| 132 | **24** | 3 | 8 | 1 | waits | [argument-practice](skills/research-loop/argument-practice.md) | [A conclusion free of a parameter its hypotheses all carry is evidence the parameter is eliminable](#a-conclusion-free-of-a-parameter-its-hypotheses-all-carry-is-evidence-the-parameter-is-eliminable) |
| 82 | **24** | 3 | 8 | 1 | waits | [results-spec](skills/research-loop/results-spec.md) | [Changing a numbered result's type lands in every file that types it, in one commit](#changing-a-numbered-results-type-lands-in-every-file-that-types-it-in-one-commit) |
| 116 | **24** | 3 | 8 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [A classification screen reads a numbered result's ITEMS, not only its statement](#a-classification-screen-reads-a-numbered-results-items-not-only-its-statement) |
| 119 | **24** | 3 | 8 | 1 | waits | [lean-layer](skills/lean-layer.md) | [A corrected constant sweeps the machine-checked layer, which will certify the withdrawn one](#a-corrected-constant-sweeps-the-machine-checked-layer-which-will-certify-the-withdrawn-one) |
| 121 | **24** | 3 | 8 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [A correction taken from one reviewer is checked against the other before it lands](#a-correction-taken-from-one-reviewer-is-checked-against-the-other-before-it-lands) |
| 140 | **24** | 3 | 8 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [Every Lean module carries a row in the layer's index, and the COMMIT GATE decides it](#every-lean-module-carries-a-row-in-the-layers-index-and-the-commit-gate-decides-it) |
| 142 | **24** | 3 | 8 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [A watched log that does not EXIST is treated as alive, so the watchdog never trips on a reviewer that died before its first write](#a-watched-log-that-does-not-exist-is-treated-as-alive-so-the-watchdog-never-trips-on-a-reviewer-that-died-before-its-first-write) |
| 145 | **24** | 3 | 8 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [A reviewer whose NUMBERS the record may later need as a control files the script that produced them](#a-reviewer-whose-numbers-the-record-may-later-need-as-a-control-files-the-script-that-produced-them) |
| 100 | **21** | 3 | 7 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [A brief that grants access to a file NAMES that file](#a-brief-that-grants-access-to-a-file-names-that-file) |
| 117 | **21** | 3 | 7 | 1 | waits | [argument-practice](skills/research-loop/argument-practice.md) | [A case split produced by eliminating variables one at a time is a signal to look for one closed form](#a-case-split-produced-by-eliminating-variables-one-at-a-time-is-a-signal-to-look-for-one-closed-form) |
| 54 | **21** | 3 | 7 | 1 | waits | [editing-skills](skills/editing-skills/SKILL.md) | [A coined phrase is marked differently from a quotation](#a-coined-phrase-is-marked-differently-from-a-quotation) |
| 155 | **21** | 3 | 7 | 1 | waits | [lean-practice](skills/lean-practice.md) | [A case split leaves index terms in constructor form, which matches no lemma stated at a literal](#a-case-split-leaves-index-terms-in-constructor-form-which-matches-no-lemma-stated-at-a-literal) |
| 21 | **21** | 7 | 3 | 1! | **SPENT 2026-09-23**, the cited sentence was deleted with the Fable retirement | [research-loop](skills/research-loop/SKILL.md) | The model-discipline section cited a settings value that could change under it. *Entry removed on retirement, the section now being effort-only.* |
| 139 | **21** | 3 | 7 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [A block appended to a findings file is filed under whatever heading happens to be LAST](#a-block-appended-to-a-findings-file-is-filed-under-whatever-heading-happens-to-be-last) |
| 183 | **21** | 3 | 7 | 1 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [The brief's file list is a claim about where the argument lives, and it inherits the record's filing errors](#the-briefs-file-list-is-a-claim-about-where-the-argument-lives-and-it-inherits-the-records-filing-errors) |
| 184 | **21** | 3 | 7 | 1 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [The whole-record search runs on the round's own findings, including the ones it raises last](#the-whole-record-search-runs-on-the-rounds-own-findings-including-the-ones-it-raises-last) |
| 202 | **21** | 3 | 7 | 1 | waits | [computational-practice](skills/research-loop/computational-practice.md) | [A screen for a maximum over a family starts from the family's structured objects and runs past where their value crosses the claim](#a-screen-for-a-maximum-over-a-family-starts-from-the-familys-structured-objects-and-runs-past-where-their-value-crosses-the-claim) |
| 205 | **21** | 3 | 7 | 1 | waits | [lean-practice](skills/lean-practice.md) | [An edit to a module the root imports is made in the scratchpad and copied back only once it builds](#an-edit-to-a-module-the-root-imports-is-made-in-the-scratchpad-and-copied-back-only-once-it-builds) |
| 88 | **18** | 3 | 6 | 1 | waits | [lean-practice](skills/lean-practice.md) | [Grep the machine-checked layer for a supporting lemma before writing one](#grep-the-machine-checked-layer-for-a-supporting-lemma-before-writing-one) |
| 23 | **18** | 3 | 6 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) + [hooks/](hooks/) | [A finished loop's flag must be disarmed, because an armed flag shadows the loop that is running](#a-finished-loops-flag-must-be-disarmed-because-an-armed-flag-shadows-the-loop-that-is-running) |
| 24 | **18** | 3 | 6 | 1 | waits | [verification-loop](skills/verification-loop/SKILL.md) + [hooks/](hooks/) | [A loop that forbids the other loop's flag needs a flag of its own](#a-loop-that-forbids-the-other-loops-flag-needs-a-flag-of-its-own) |
| 25 | **18** | 3 | 6 | 1 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [A refuted entry is not a closed entry](#a-refuted-entry-is-not-a-closed-entry) |
| 26 | **18** | 3 | 6 | 1 | waits | [computational-practice](skills/research-loop/computational-practice.md) | [A screen must check the object exists, not that the formula evaluates](#a-screen-must-check-the-object-exists-not-that-the-formula-evaluates) |
| 27 | **18** | 3 | 6 | 1 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [Before applying a repair, check what each claim quantifies over](#before-applying-a-repair-check-what-each-claim-quantifies-over) |
| 28 | **18** | 3 | 6 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [Carry a Gate 2 fence into the successor's hypothesis list, not the notebook](#carry-a-gate-2-fence-into-the-successors-hypothesis-list-not-the-notebook) |
| 30 | **18** | 3 | 6 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [Put a convention in the conventions file the first time a lemma needs it](#put-a-convention-in-the-conventions-file-the-first-time-a-lemma-needs-it) |
| 31 | **18** | 3 | 6 | 1 | waits | [computational-practice](skills/research-loop/computational-practice.md) | [Re-run the test that refuted a claim against whatever survives the refutation](#re-run-the-test-that-refuted-a-claim-against-whatever-survives-the-refutation) |
| 33 | **18** | 3 | 6 | 1 | waits | [argument-practice](skills/research-loop/argument-practice.md) | [Test the criterion the argument uses, not a stronger one that feels natural](#test-the-criterion-the-argument-uses-not-a-stronger-one-that-feels-natural) |
| 34 | **18** | 3 | 6 | 1 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [Validating a finding means checking the identification, not only the arithmetic](#validating-a-finding-means-checking-the-identification-not-only-the-arithmetic) |
| 138 | **18** | 3 | 6 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [A failed reindexing proof is diagnosed by the PERMUTATION'S PARITY before it is recorded as owed](#a-failed-reindexing-proof-is-diagnosed-by-the-permutations-parity-before-it-is-recorded-as-owed) |
| 187 | **18** | 3 | 6 | 1 | waits | [lean-practice](skills/lean-practice.md) | [To decide a question over rationals, carry them as normalised integer pairs](#to-decide-a-question-over-rationals-carry-them-as-normalised-integer-pairs) |
| 197 | **18** | 3 | 6 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [Before creating a references folder, grep the references index for the source's identifier](#before-creating-a-references-folder-grep-the-references-index-for-the-sources-identifier) |
| 36 | **15** | 3 | 5 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [Screen a node against the record's audits of it before planning against it, not against the map's picture of it](#screen-a-node-against-the-records-audits-of-it-before-planning-against-it-not-against-the-maps-picture-of-it) |
| 37 | **15** | 3 | 5 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [Subagents inherit the parent model, so a step's model rule reaches its reviewers too](#subagents-inherit-the-parent-model-so-a-steps-model-rule-reaches-its-reviewers-too) |
| 38 | **12** | 3 | 4 | 1 | waits | [editing-skills](skills/editing-skills/SKILL.md) | [A block scan must end at the next heading of any level, not the next heading of its own kind](#a-block-scan-must-end-at-the-next-heading-of-any-level-not-the-next-heading-of-its-own-kind) |
| 39 | **12** | 3 | 4 | 1 | waits | [argument-practice](skills/research-loop/argument-practice.md) | [A completeness claim argued from spanning is checked by asking what it makes redundant](#a-completeness-claim-argued-from-spanning-is-checked-by-asking-what-it-makes-redundant) |
| 40 | **12** | 3 | 4 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [A log-matching pattern is verified against a real filename, not against its own docstring](#a-log-matching-pattern-is-verified-against-a-real-filename-not-against-its-own-docstring) |
| 41 | **12** | 3 | 4 | 1 | waits | [editing-skills](skills/editing-skills/SKILL.md) | [A pointer check must verify where it lands, not that it exists](#a-pointer-check-must-verify-where-it-lands-not-that-it-exists) |
| 43 | **12** | 3 | 4 | 1 | waits | [argument-practice](skills/research-loop/argument-practice.md) | [An identity between a frame-dependent quantity and frame-invariant ones is impossible, check that before deriving it](#an-identity-between-a-frame-dependent-quantity-and-frame-invariant-ones-is-impossible-check-that-before-deriving-it) |
| 44 | **12** | 3 | 4 | 1 | waits | [computational-practice](skills/research-loop/computational-practice.md) | [Before reserving a run as blocked, read the definition of the object the run would need](#before-reserving-a-run-as-blocked-read-the-definition-of-the-object-the-run-would-need) |
| 45 | **12** | 3 | 4 | 1 | waits | [editing-skills](skills/editing-skills/SKILL.md) | [Document order is not numeric order, never splice a section by a range between two headings](#document-order-is-not-numeric-order-never-splice-a-section-by-a-range-between-two-headings) |
| 46 | **12** | 3 | 4 | 1 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [When a block restates a reviewer's finding, check the variable the verdict was about](#when-a-block-restates-a-reviewers-finding-check-the-variable-the-verdict-was-about) |
| 47 | **9** | 3 | 3 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [A brief that names a reference must name its size](#a-brief-that-names-a-reference-must-name-its-size) |
| 48 | **9** | 3 | 3 | 1 | waits | [editing-skills](skills/editing-skills/SKILL.md) | [Applying a verdict must not assume the row it edits](#applying-a-verdict-must-not-assume-the-row-it-edits) |
| 49 | **9** | 3 | 3 | 1 | waits | [verification-loop](skills/verification-loop/SKILL.md) | [Check the block's "what it does not need" list first, clause by clause](#check-the-blocks-what-it-does-not-need-list-first-clause-by-clause) |
| 50 | **9** | 3 | 3 | 1 | waits | [editing-skills](skills/editing-skills/SKILL.md) | [Deleted words stay in the verbatim quote, struck through](#deleted-words-stay-in-the-verbatim-quote-struck-through) |
| 51 | **9** | 3 | 3 | 1 | waits | [research-loop](skills/research-loop/SKILL.md) | [The loop's present-and-continue handoff overrides the commit skill's approval step](#the-loops-present-and-continue-handoff-overrides-the-commit-skills-approval-step) |
| 52 | **6** | 3 | 2 | 1 | waits | [editing-skills](skills/editing-skills/SKILL.md) | [Report skill edits as a markdown blockquote, never a fenced code block](#report-skill-edits-as-a-markdown-blockquote-never-a-fenced-code-block) |

# Ready, promote on approval

**Total 80 or more with no `HOLD`, and the part the skills do not already hold has been subtracted.** *These are the only proposals put to the user for approval; everything under **Noted** waits.* **A proposal moves here by recurring, not by being rewritten.**

*(none pending: 103 was promoted at 81 into [argument-practice](skills/research-loop/argument-practice.md), its incident moved to [ATTEMPTS.md](../ATTEMPTS.md), and the three other rows at 81 carry `HOLD`.)*

# Noted, waiting to recur

## A simp lemma reported UNUSED is saying the term never reached its shape, so repair upstream of it

**When a `simp only` set leaves a lemma unused, that lemma is not too weak: the term never took the form it matches, and the repair is a lemma EARLIER in the pipeline rather than a stronger one at the same point.** *Lean reports this for free as an unused-argument warning, and it names the defect precisely, which is why reaching for a bigger hammer instead is pure waste.*

**Three occurrences in one session, on one goal, with the same diagnostic and different upstream repairs.** *First: `smul_smul` and `ite_mul` reported unused because `ite_smul` had moved the conditional INSIDE `inner2`'s first argument, where no lemma reaches it; the repair was to REMOVE `ite_smul` so the conditional stayed a scalar.* **Fix: drop the lemma that buries the subterm, rather than adding one to dig it out.**

*Second: `mul_ite` never fired because the weight multiplied a SUM of four conditionals, and `mul_ite` matches `a * if c then x else y`; the repair was `mul_add` and `mul_sub` ahead of it.* **Fix: distribute before pushing inside.**

*Third: a purpose-built identity `∑ x, w_px w_qx = (w²)_pq` was inert because every sum carried its conditional INSIDE, as `∑ x, if <cond on x> then w_px w_qx else 0`.* **Fix: split the sums on their conditionals first, and only the survivors are bare.**

*The cost each time was one five-minute elaboration spent on a stronger lemma that could not fire either, against a warning already in the log saying so.*


## A result proved over one field is blocked in another only if its proof uses what the fields differ in

**A layer that carries a theorem over the reals and needs it over the rationals records the gap as a port, and prices it by the theorem's length.** That price is almost always wrong, because the fields differ in an order and a completeness, and a proof that uses neither transcribes unchanged however long it is.

**So read the TACTICS before estimating.** Steps that are ring normalisation, case enumeration, equational simplification or linear arithmetic over an ordered field carry across untouched. Only a step invoking a supremum, a limit, a square root, or an inequality that fails rationally is a real obstruction, and a proof usually has none.

**The cost of getting this wrong is not the port; it is what stands in for it.** The instances that were actually needed get closed by trusting the compiler at a few fixed points, and the record then carries a general theorem in one place and unverifiable special cases in another, with a block between them that was never there. *A blocked row whose block is never reopened is indistinguishable from a real one.*

**The check is mechanical and takes one reading**: list the tactics, and name the one that needs the field. Where no step names it, the port is transcription.

*Occurrences: two, in the same session, both in the same layer and neither noticed until the port was attempted and took an afternoon less than its estimate.*


## A commit gate checks the commit it is about to record, the staged content after the command's own staging

**Merged 2026-09-25 from 2 entries that share one repair.** **Rule.** A pre-commit gate evaluates the prospective commit: the index as it will stand once the command's own `git add` arguments are applied, read as staged content rather than as the file on disk. *The working tree and the pre-command index are each a different configuration from the commit, and both entries are the gate checking one of them.*

**Fix beside each occurrence.**

- 156, one critical occurrence: verify staged content, or refuse when a staged file carries unstaged edits.
- 83, three occurrences: union the command's staging paths with the staged set before testing.

#### A commit gate that checks the working tree has not checked what is being committed


**A gate that verifies files by running a tool over them reads the working tree, while the commit records the index.** When the two agree the distinction is invisible, which is most of the time, and that is what makes it dangerous: the gate is trusted on the strength of runs where the difference could not show.

**The state that breaks it is ordinary, not exotic.** Work is staged in part, because some of it verifies and some does not, and the part held back is exactly the part most likely to be broken. The gate then certifies a configuration that includes the broken edits and excludes nothing, and reports success about a commit it never examined.

**So a gate of this shape either checks the index, or says plainly that it does not.** Checking the index means verifying the staged content rather than the file on disk. Saying so means refusing, or warning loudly, when a file staged for commit also has unstaged changes, since that is precisely when the two differ.

*Occurrence: one, CRITICAL. It was found by reasoning about the gate, recorded, and then observed within the same session: a commit whose staged files were all verified was refused because an unstaged edit to one of them did not elaborate. The gate reported on a configuration that was not being committed, and would equally have PASSED one.*

#### A pre-commit gate reads the index the command is about to change


**Proposed rule.** A gate that inspects staged files must account for staging the command has not performed yet. `git add <paths> && git commit` is one tool call, and a hook firing before it sees the index as it was, which in a repository several sessions write to is somebody else's unfinished work.

**The failure is a gate that reports true defects against the wrong commit.** Every report is accurate and none of it belongs to the change being made, so the author learns to stage separately or to read past the output. *Both responses degrade the gate: one is a ritual that hides nothing, and the other is the bypass the gate exists to prevent.*

**The fix is to read the command's own staging arguments** and test the union of those paths with the already-staged set, rather than the index alone.

## A tactic that succeeds without closing its goal swallows every alternative after it

**`first | a | b | c` moves past `a` only when `a` FAILS.** A tactic that rewrites something and leaves the goal open has succeeded, so `b` and `c` never run, and the goal is reported unsolved at the end of the block with no indication which branch consumed it.

**The tactics that do this are the ones reached for as fallbacks**: simplification and arithmetic normalisation both make progress on almost anything and close only some of it. Putting either early in an alternation disables everything after it.

**So every branch of an alternation either closes the goal or fails.** Wrap a progress-making tactic so that it fails when it does not finish, or place the tactics that can only close or fail ahead of it. *Naming the failing case in the error is no help here: the message points at the whole block.*

*Occurrences: three in one session, each costing an iteration, and one of them a "fix" that raised the failure count from one to twenty-three by making the swallowing branch strict without reordering.*


## Split a computation at the granularity of the object's own definition, not one level up

**When a computation exhausts the elaborator, the useful question is what the object is DEFINED as, and the split follows that.** A definition built entrywise splits per entry; one built by polarisation splits per evaluation. Splitting at any coarser level leaves each piece carrying the same combinatorial load as the whole.

**The coarser split is the tempting one because it looks like the natural unit.** A matrix identity seems to split into matrices; an operator identity into operators. But the cost is set by how many subterms each branch must match against how many facts, and that is decided by the definition, not by the statement.

**The symptom of splitting too coarsely is that memory grows rather than time.** Heartbeat exhaustion says a declaration is doing too much and is cured by more declarations. Memory growth says each branch is building terms without bound, and more declarations at the same granularity make it worse, not better.

*Occurrences: two in one session on the same theorem, at 2.4 GB and at 6 GB, before the per-entry split elaborated in seconds with flat memory.*


## Before trusting a zero, feed the pattern a case it must match

**A search that returns nothing is two different events wearing one face: the thing is absent, or the pattern cannot match it.** *The command succeeds either way, the count is `0` either way, and nothing distinguishes them downstream.* **So a zero is trusted only after the pattern has been shown to match a case it MUST match**, which is one known-good input and one line.

**This is NOT the absence-claim rule already on file.** That one governs a SENTENCE and says to grep the scope the sentence names. This one governs a PATTERN and applies even when the scope is right, because the defect is in the matcher rather than in where it was pointed.

**Three occurrences in one session, one repair for all three.**

*First*: a commit gate tested for a declaration with `git grep -E` and a trailing `\b`. POSIX ERE reads `\b` as a LITERAL `b`, so the gate asked whether the layer declares `<name>b`, matched nothing, and could never be satisfied by writing the thing it demanded.

*Second*: the same `\b` in a BSD `sed` expression, which left the file unchanged while reporting success, so the next compile failed on the unedited text.

*Third*: a count of numbered results lacking Lean, run twice with two patterns, giving `44` and then `1`. The second used a file-name pattern that cannot match a base-layer file named for its subject, which is precisely where the one remaining result's machine-checked Lean lives. **The true answer was zero**, and three of the four figures reported that session were artefacts of the matcher.

*The fix in each case is the same and is cheap: run the pattern against one input whose answer is known before believing an empty result.*
## A tactic budget is spent per declaration, so a computation that exhausts it is split into declarations

**A computation that overruns the elaborator's budget is not thereby too large; it is in one declaration.** The budget is charged per declaration, so the same work distributed over many finishes comfortably while the monolith dies, and the two differ in no other way.

**The failure is that a timeout reads as a statement about the mathematics.** A record then files the item as unbudgeted or out of reach, proposes making the single goal cheaper (supplying entries as facts, raising the limit, trimming the reduction set), and each attempt fails the same way, because every one of them keeps the work in one declaration.

**So the first question about a timeout is how many declarations the computation occupies, never how expensive it is.** Where the object is built from a definition with named parts, a polarisation, a sum over a basis, an entrywise construction, the parts are the split, and each becomes a theorem whose statement is one value.

*Occurrences: three, all on the same shape, two recorded in the file itself as attempts that "died the same way" and one repeated before the split was tried.*


## A case split leaves index terms in constructor form, which matches no lemma stated at a literal

**After a tactic enumerates a finite index, the goal carries `⟨0, ⋯⟩` where a lemma stated about that index says `0`.** The two are definitionally equal and syntactically different, so rewriting matches neither, and every prepared value silently fails to land.

**What makes this expensive is where the symptom appears.** The missed rewrite leaves its term untouched, a later stage then unfolds the definitions underneath it, and the error surfaces as a goal full of expanded literals. That reads as a staging mistake, unfolding too early, so the natural response is to reorder the reduction, which cannot help and costs a full run each time.

**So normalise the constructor form back to the literal FIRST, ahead of everything else in the reduction.** A goal that still shows a term the prepared lemma names exactly is the check that it worked.

**And diagnose this class of failure with a probe that replaces the real values by assumptions of the same shape.** The question is whether the rewrite matches, which does not depend on the values being true, and a probe that assumes them answers it in seconds where re-running the real file costs minutes.

*Occurrence: one, costing three full-file runs and two wrong diagnoses before the shape was isolated.*


## Before discharging a debt, read the reports that raised it

**Rule.** A `HYPOTHESIS-DEBT` names the reports that recorded it; read those before deriving anything, because a debt is by construction a thing someone has already looked at.

**A debt is not an unexplored question, it is a question a reader stopped short of, and the report that stopped names where it stopped.** *The general search rule says to look across every directory; what it does not say is that a debt line is itself a citation, and following it costs one file open.*

**Four discharges in one cycle re-derived what the cited report already held.** One debt's answer stood in the review that found the lemma, and again in the verification report **whose own paragraph raised the debt**, written out as one of two closures it named. Another's ingredients were the three lemmas the debt line itself cites, needing only to be joined. **In each case the derivation was correct, the novelty was nil, and the cost was a Gate 2 pair.**

**The trigger is the word `HYPOTHESIS-DEBT`**, which is where the general rule fails to fire: a debt reads as an open question, and an open question invites derivation rather than reading.

**Below 80, or carrying `HOLD`, and waiting to see whether the failure happens again.** *A single incident is as easily an accident as a pattern, and a rule added on one costs every later reader the time to read it.* **These are not surfaced for approval.** When a second occurrence is recorded, raise the occurrence count in the index; if the total reaches 50 the proposal moves to **Ready** on its own.

## An agent is dead only by its closing line or the harness, never by its silence, and a round folds only then

**Merged 2026-09-25 from 2 entries that share one repair.** **Rule.** A staleness report opens an inquiry. Record an agent as dead, and fold its round on the remaining reader, only once its closing line lands, the harness reports it gone, or it is deliberately stopped.

**Fix beside each occurrence.**

- 42, one occurrence: wait for the closing line before recording a round as single-audited.
- 87, one critical occurrence: the same repair, a fold that waits for the closing line.

#### A reviewer is declared dead by its output, never by its silence


**Rule.** Declare a reviewer dead by its output, never by its silence.

**A round was written up as single-audited because a reviewer had not logged for thirty-six minutes against a three-minute protocol; it filed a full report at eighty-two minutes, agreeing with its pair and carrying two findings no one else had.** Heartbeat cadence is an instruction to the agent, not a property of its logs, and a long silence is what a hard derivation looks like from outside. Wait for the closing line or for the harness to report the agent gone, and record a round as single-audited only then.

The mode is the second line of `.claude/research-loop-active`, see [loop_flag.py](hooks/loop_flag.py). Absent, it reads as `locked`.

---

#### A staleness report says an agent is quiet, and a fold waits for the closing line


**A watchdog reports SILENCE, which is the only thing it can observe, so the report opens an inquiry rather than settling one.** *An agent reasoning at length between tool calls writes nothing for half an hour, and a dead one writes nothing either*, and the two are separated by exactly one signal, the log's closing line or the completion notification, neither of which a timer can anticipate.

**A ping is not that signal.** *A subagent reading its inbox only between turns cannot answer while it is thinking, so an unanswered ping distinguishes nothing and reads as confirmation.* **So a round does not fold, and no death reaches the record, until the closing line lands or the agent is deliberately stopped.**

*The failure: a reviewer reported stale was written into the record as dead, its round folded on the remaining reader, and it filed a full report forty minutes later carrying an independent re-derivation of the round's central claim and a refutation of a sentence nobody had put to it. The record then stated a death that had not happened, in a findings file, an index and a commit.*

**What the watchdog is for stands unchanged**: it is the only instrument that catches an agent which really has died, and the alternative is a supervisor that goes quiet and hands back the next task as though the round had passed.

## Check a new claim against the record's own theorems before recording it

**Rule.** Check a claim against the theorems the record already proves before recording it.

A claim that contradicts a theorem the record already proved is refuted before it is written, and the check costs one line. [Reviewer 339](../reviews/REVIEW_r339.md) killed a cycle's T12 result, *no strongly regular graph solution saturates Lemma 70*, by naming $K_{m,m}$, which saturates, is in the record's own enumeration, and **is the balanced sphere product** that [Lemma 71](../findings/bounds.md) says every saturating point must be. The same cycle used $n-2$ for the saturation ratio where the same findings file states $n/(n-2)$ eleven lines further down.


**Occurrence 2, 2026-09-28.** *I124's batch 9 derived that a single pair character under $R=0$ puts $W$ below $\theta_0$, while [L224](../findings/second-order.md) already capped every unit tensor in $\mathcal D_n\oplus V_{jk}$ at $\Theta_n$ with no hypothesis, and the same note's batch 6 cited L224 in a bullet; both Gate 2 readers ([r1942](../reviews/REVIEW_r1942.md), [r1943](../reviews/REVIEW_r1943.md)) found it.*
## A clause added after the QED is an unproved claim wearing a proof's authority

**Proposed rule.** **Rule.** A sentence generalising a proof is a separate claim: give it its own case analysis, or do not write it.

When a cycle proves a statement and then writes a sentence generalising it, "so X is never Y", "so the mechanism is Z", that sentence is a separate claim and gets its own case analysis or is not written. *A cycle proved the rank of a system and added "so the maximum is never forced", false in two cases it had not enumerated; and it explained a recorded exactness by a mechanism the record's own measurement refuted.* Both survived a careful self-read because they sat beside a proof and inherited its authority.

## A correction the cycle just recorded is the one it is most likely to repeat

**Proposed rule.** **Rule.** Keep a refutation of one's own claim on a short list, re-read before the next note is written.

When a cycle records a refutation of one of its own claims, that claim goes on a short list re-read before the *next* note is written, because the reasoning that produced it is still the cycle's working intuition and reproduces it verbatim. *A cycle recorded that "the LP is tight because the feasible segment is short" was false, with the measured counterexample, and then wrote "the two endpoints meet" into the next derivation two steps later, the same conflation of vertex degeneracy with segment length, caught by a reviewer rather than by the author.*

## Screen at a dimension where the claimed structure is not degenerate

**Occurrences raised to four by the same pass.** Both checks one refuted lemma offered were blind by construction, the padded flat zeroes every disputed term, and a first-order check cannot see a second-order sign. A fence post's negative half rested on a single-row measurement. And a radius was called conservative from a direction-blind estimate.

**Proposed rule.** **Rule.** Pick the screen's dimension where the claimed distinctness could fail, and include one dimension above it.

When a claim rests on objects being *distinct*, characters, eigenvalues, blocks, orbits, the cheap small cases are exactly where they coincide, so a screen run there confirms the arithmetic while the structural claim is false. Pick the screen's dimension by asking where the claimed distinctness could fail, and include one dimension above it. *A cycle screened a character decomposition at $n=4\dots8$ and the fusions it missed occur at exactly $n=4,6,8$; the identity it checked was blind to them, because fusing two blocks changes no dimension.*

## A screen must check the object exists, not that the formula evaluates

**Proposed rule.** **Rule.** Confirm the object exists before checking that its formula evaluates.

Before screening a claim at a list of parameters, confirm the object the claim is about exists at each one; a closed form evaluates wherever its symbols do, and agreement between two formulas at a parameter where neither describes anything is not evidence. *A bound was screened at $n=5,\dots,50$ against a competitor that does not exist at odd $n$, and the screen agreed at every odd entry while the claim was false there.*

## A "this hypothesis is load-bearing" claim is screened by searching for the record saying it FAILS

**Proposed rule.** **Rule.** Before recording that a hypothesis carries weight, search the record for it being reported useless.

A claim that a hypothesis is load-bearing and a claim that it does not help are about the SAME hypothesis and read oppositely, so a search by that hypothesis's own objects returns the instances where it holds and never the sentence retiring it. **Query what the hypothesis is asserted to BUY, not what it is made of**, and read the result before filing. *Earned when a warning was filed saying a threshold could not be dropped, while the record already carried a witness above that threshold refuting the very bound the warning was protecting, in a file whose sentence said in plain words that no threshold repairs the claim. The filing searched the numeric quantities in the claim, found the supporting instances, and recorded an absence that two files falsified.*

## The scan needs a fourth bucket: the RECORD's argument is an outline, not the library's gap

**Proposed rule.** **Rule.** Add a bucket for a result whose recorded argument is not reconstructible.

The scan's buckets are `ready`, `blocked on <piece>` and `out`, and a result the record STATES AS PROVED while giving its argument only in outline fits none of them. *It is not ready, no named piece of the base layer unblocks it, and no library machinery is missing.* **Filing it as `blocked on <piece>` sends a later round hunting a declaration that would not help, and filing it as `out` blames the library for a gap in the record.** The bucket's value is not the routing but the disclosure: it says a numbered result is carried as proved on an argument nobody can currently follow, which is the defect a machine check cannot see and a reader must. *Three instances in one sweep, each conceding it in the file's own words.* **A bound stated at every dimension** whose block names its chain in outline, coordinates, an inequality, an AM-GM step, a symmetry reduction and a final affine inequality, "not reconstructible from the block". *TWO INDEPENDENT FILES RECORD THAT SAME SENTENCE AS UNRESOLVABLE, written at different times: the statement file says the record gives the argument only in outline, and the proof file, fifteen theorems and no `sorry`, says in its own words that "one sentence in the block does not resolve" and stops exactly where the prose stops, covering the other half of the result completely.* **That is the bucket's evidence at its strongest**: not one author's judgement but two, arriving separately, each writing it into the only place available to them, a docstring, because the scan has no slot for it. **A result the programme treats as externally known**, where four steps have no argument on file, one of them unnumbered and never audited, and the certificate runs at one dimension alone. **And a Wick computation** whose file says the pieces are "not on this record in a form that can be replayed here". *The last is also the clean contrast case: choosing `sorry` over a hypothesis is RIGHT when what is missing is the proof, and wrong when what goes missing is a hypothesis the statement needs, and only reading the type against the docstring separates the two.*

## A recorded blocker is re-checked against the library it names before the round trusts it

**Proposed rule.** **Rule.** Re-grep a `sorry`'s named blocker before planning around it.

A blocker is written when the `sorry` is created and is never read again, so it ages against a moving library and a growing base layer while reading as current. **Grep the names it gives before the round treats it as the obstruction**, and where it names no greppable name, that is itself the finding. *The failure is not that the blocker is stale but that it MISDIRECTS: a round plans against the wrong obstruction, hunts a declaration that would not help, or blames the library for a gap in the record.* **Four shapes seen in one day, all in blockers that read as authoritative**: one whose debt was strictly narrower than stated because a supporting lemma had since been proved; one naming an expensive expansion that a proved lemma in the same file already avoids; one blaming the library where the recorded ARGUMENT was the outline; and one naming as missing the single piece the library carries in full while omitting the two it lacks.

## A machine-checked file unreachable from the project root is checked by nothing, and says so nowhere

**Proposed rule.** **Rule.** Gate a new machine-checked file on being reachable from the project root.

A file the root does not import still compiles on its own, so every signal a round reads says it is checked. **It is invisible to the build's reachability sweep and to the axiom audit, which reads the artefacts the build produces**, so its index row can claim `proved, no sorry` with nothing enforcing the claim and no later edit re-testing it. *The check is REACHABILITY IN THE IMPORT GRAPH, not membership in the root's import list, and a first version of this proposal said the latter.* **That version produces false positives on ordinary structure**: a file the root does not name directly can still be pulled in by another file that does, and forty-three verified theorems across two such files were briefly read as unchecked on exactly that mistake. *The right query walks the graph from the root and asks which source files it never reaches. It belongs in the commit gate rather than in anyone's memory, because the real failure leaves no trace to notice later: the row and the file both read as correct.* **This is the general shape of the layer's invisible debt** and is worth a gate for the same reason the numbered-result rule has one: a defect nothing reads back is indistinguishable from no defect.

## Deleting a definition is an API change, and its blast radius is every file that OPENS its namespace

**Proposed rule.** **Rule.** Before deleting a definition, list the files that open its namespace, not the files that import it.

Removing a duplicate definition looks local and is not. **Dependents reach the name through `open <Namespace>`, and a transitive import keeps the DEFINITION reachable while the NAME stops resolving**, so the breakage is pure name resolution in files the edit never touched. *Every per-file check passes: the edited file elaborates, its `sorry` count is unchanged, the axiom audit is clean, and an auditor briefed on the edit's own file confirms the change preserves its propositions, because it does.* **The query is `open` plus the namespace being emptied, and it must be run before the deletion**; querying the moved NAMES instead returns the same files and reads as "who mentions this" rather than "who will stop compiling". *Earned when one deduplication broke three downstream files for hours: a single-file check, an adversarial audit scoped to that file, an unchanged `sorry` count and a clean axiom report all passed, and only a whole-project elaboration caught it, twice refusing a commit before the cause was understood.*

## A statement whose scope was narrowed keeps the witness that narrowed it

**Proposed rule.** **Rule.** When a hypothesis is added to make a statement true, keep the witness that shows it false without one.

**The layer already does this in at least SIX places and the practice is worth making general.** *One file keeps `rank_form_needs_isotropy`, the witness that its three-way equivalence is FALSE without the isotropy conjunct; another keeps `wider_claim_fails`, one line closed by `omega`, showing the wider claim fails at the boundary value; a third guards its emptiness claim with an inhabitation witness and says in writing that the witness is for inhabitation and nothing else; a fourth pins a NORMALISATION hazard with two one-line lemmas, so a factor-of-two collision reaching every computed value and no stated conclusion is visible rather than remembered; and a fifth carries a NINE-FOLD conjunction exhibiting an explicit pair that meets every hypothesis of a coincidence claim and violates its conclusion, both unit, mutually orthogonal, same square and same self-wedge, yet not equal up to sign, and both invertible. *And a sixth exhibits parameters OUTSIDE its intended range at which the objective exceeds the claimed maximum, so the range restriction is not a convenience: drop it and the theorem is false, with a kernel-checked witness saying so.* **That sixth is also the file a count-based detector flagged as suspicious**, on seven underscored binders, and reading it shows an author MORE careful than average, not less. *The count points at care as readily as at carelessness, which is why the rule is the practice rather than the query.* **The nine-fold witness shows the payoff**: because the falsifier is typed, the dimension hypothesis of the emptiness claim it bounds is visibly LOAD-BEARING rather than arbitrary, and a would-be generaliser meets a kernel-checked counterexample instead of a prose caveat.* **A narrowing recorded only in prose is invisible to everything that reads the layer mechanically**, and the witness costs one line and is checked forever. *The counterexample that would have caught a false statement typed this session is of exactly this shape: an explicit symmetric operator at which the conclusion fails.* Every binder of a sorried theorem is unused, so marking one with an underscore asserts that the eventual proof will not need it. **That assertion is never tested, and it fails in two directions.** *Loosened wrongly, the proof turns out to need the hypothesis and nothing is harmed. Tightened wrongly, the hypothesis is decorative, the statement is more general than the argument supports, and the result can be FALSE while type-checking and reading as an ordinary debt.* **THE COUNT IS NOT THE SIGNAL, AND A FIRST VERSION OF THIS PROPOSAL SAID IT WAS.** *A query for sorried theorems whose underscored binders outnumber their named ones returns BOTH directions and cannot tell them apart: one flagged theorem carried seven underscored hypotheses, every one of which the conclusion is false without, so they are underscored only because the proof is absent, which is the benign case this rule does not want reported.* **What separates them is one question per binder, asked by a reader**: does the conclusion survive dropping it? *The count narrows where to look and decides nothing, so a rule written around the count sends a later cycle to audit a file with nothing wrong in it.* *Earned when a statement quantified over every symmetric operator, with the one binder that would have tied it to the intended objects absent, was false at an explicit witness and carried a theorem beneath it that inherited the falsity without a `sorry` of its own. A sibling file's docstring had already named the same shape, an unused binder, as "the visible tell: a hypothesis nobody needed because nobody had attempted the proof".*

## A procedure you paraphrase is a procedure you can silently drop an item from

**Proposed rule.** **Rule.** Quote a recorded procedure into the work, item by item, rather than summarising it.

When a file, block or brief lists the steps a proof or a correction needs, **copy the list and tick it**, because a paraphrase is where an item disappears without anyone noticing it has. *The paraphrase reads as complete, the work proceeds against it, and the missing step is invisible until something downstream cannot close.* **The cost is asymmetric**: quoting costs seconds, while the omission is diagnosed only by inspecting the actual state, which is the step a confident summary makes feel unnecessary. *Earned twice in one session. A docstring named THREE expansions a proof needed; a summary of it recorded two plus a separate list of rearrangements, and seven compiles were spent adjusting coefficients around a term that could never cancel, until one state inspection showed the unexpanded third sitting in the hypothesis. And a correction that had to reach three sites reached one, was reported complete, and the other two were found by a reviewer.* **The same fix serves both**: the list is quoted, and each item is struck only when the artefact shows it done.

## Name the falsifying outcome before running a screen, or the screen tests nothing

**Proposed rule.** **Rule.** State the outcome that would falsify the claim before running the screen.

Before running any screen, write down which outcome would falsify the claim; if no outcome could have come out otherwise, the screen is not evidence and must not be reported as agreement. *Three screens in one session were forced independently of the claim they appeared to support: one compared a formula against the code that generated it, one evaluated closed forms at parameters where the object does not exist, and one checked an identity that follows from two recorded relations at every point of the space.* This is sharper than "run a control", because each of those screens did produce numbers that matched.

**A FOURTH OCCURRENCE, AND IT MOVES THE RULE FROM THE SCREEN TO THE CONTROL.** A screen tabulated three points and two of them could not have come out otherwise: at both, a theorem the SAME CYCLE PROVED forces the outcome, so the rows read as corroboration while carrying no information, and the block rested on one point while appearing to rest on three. *The first version of that control had a different defect, testing the wrong member of the family, and correcting it produced a control that was forced instead, so the repair moved the failure rather than removing it.* **The question to ask of a CONTROL is the one this rule asks of a screen**: which recorded result already constrains the value here, and could this row have come out the other way? *A control drawn from the very family a just-proved theorem governs is the likeliest place for the answer to be no.*

## Test the criterion the argument uses, not a stronger one that feels natural

**Proposed rule.** **Rule.** Test the criterion the argument actually uses, not a stronger one that feels natural.

When an argument turns on a condition, restate that condition verbatim before checking any instance of it, a stronger surrogate that feels equivalent will silently reclassify cases and the error survives every recount. *An argument requiring a quantity to be nonzero was checked for positivity throughout; three successive counts of the same set were wrong, each recomputed carefully from the previous wrong classification, and two reviewers found the same root cause.*

## A completeness claim argued from spanning is checked by asking what it makes redundant

**Rule.** Check a spanning-based completeness claim by asking what it makes redundant.

**When a derivation claims to have enumerated a whole apparatus, test the criterion by asking what else it certifies as unnecessary.** A spanning argument, *these generators span the space, so the family they generate is everything*, proves too much whenever the objects are constrained beyond linearity, and the symptom is that it declares redundant some member the record actively uses. **The check is one sentence and it runs before the claim is recorded.**

*Earned when a family of eighteen identities was called exhaustive because three double-root multipliers spanned each row's multiplier space. The true apparatus was twenty-seven, a two-point-line count settles it in two lines, and the spanning argument would equally have made the recorded two-root family redundant, which the same file denies by using it.*

## An identity between a frame-dependent quantity and frame-invariant ones is impossible, check that before deriving it

**Rule.** Check a proposed identity for frame-dependence on one side before deriving it.

**Before recording an identity, ask which side of it survives a change of frame.** If one side is computed from a frame's own entries and the other is built only from invariants, no identity can hold, and the check costs one sentence. *A derivation once equated a quantity assembled from sectional curvatures to a squared norm under two frame-invariant hypotheses; two reviewers killed it independently, one of them without computing anything, and the counterexample was the record's own object rotated in place.* **The same test upgrades a false identity into a true inequality**, the frame-dependent side is extremal in some frame, which is the statement worth keeping.

## Document order is not numeric order, never splice a section by a range between two headings

**Rule.** Locate a section by its heading, never by a numeric range between two headings.

**Cut a section by matching its own heading and the next heading of any level, never by the range between the heading you want and some later landmark.** A file whose sections were inserted over many cycles carries them in insertion order, so section $N+1$ frequently sits *above* section $N$, and a range chosen from a remembered ordering silently swallows whatever lies between. *An edit aimed at one lemma deleted the neighbouring one this way; a second attempt to restore it returned an empty string, because the same wrong ordering was assumed again when extracting the replacement from git.* **Verify with a heading diff against the previous version afterwards**, it is one command and it names exactly what went missing.

## Re-run the test that refuted a claim against whatever survives the refutation

**Rule.** Re-run a refuting test against whatever survives the refutation.

**When an audit kills a claim by some test, apply that same test to the replacement before recording it.** The salvaged statement is written in the moments after the refutation, under the impression that the defect has been dealt with, and it is the one statement in the cycle nobody has screened, because the screen that just fired is remembered as *spent* rather than as *available*. *A lemma was refuted for equating a frame-dependent quantity to a frame-invariant one; the part rescued from it ordered that same frame-dependent quantity against a frame-invariant one, and the next round of reviewers killed it by the identical argument.* **The test costs one line and it is already written down**, it is the sentence the reviewers just handed over.

## Screen a node against the record's audits of it before planning against it, not against the map's picture of it

**Rule.** Screen a node against the record's audits of it, not against the map's picture of it.

**A diagram shows whether a node is proven; it does not show whether the node has been audited and found hollow.** Those are different facts and only the first has a colour. So a node can sit unproven-and-inviting on the map while the record already holds that it is circular, that its margin is nil by construction, or that on the set the problem actually lives it restates the target, none of which changes the picture. **Before an item is written against a node, grep the findings for that node's own mechanism and read what the audits say**, exactly as a route proposed from a literature sweep must be screened.

*The gap is structural rather than careless: the screen is mandated where routes arrive from outside, and a node lifted off the programme's own map arrives from inside, where nothing asks for it.* A section was once rebuilt around a node whose every branch the record had already audited away, and the audits were three scrolls further down the file the item's own first sentence cited.

## Carry a Gate 2 fence into the successor's hypothesis list, not the notebook

**Rule.** Require the fenced hypothesis in the successor's own hypothesis list, beyond the route register that already records it.

**[routes.md](../routes.md) already carries *what a successor must clear*, and the skill requires reading it whole.** What remains open is the successor's own statement: *the register records the fence and the lemma built next does not restate it*, so the hypothesis is one lookup away rather than on the page.

When Gate 2 closes an attempt, the next attempt states the fenced hypothesis in its own hypothesis list before any derivation begins. A cycle was fenced for ignoring an orbit-free hypothesis, then built two further estimates that ignored the same one, and both reviewers had to rediscover it. The fence was recorded correctly each time; what failed was carrying it forward.

## Deleted words stay in the verbatim quote, struck through

**Rule.** Keep deleted words in a verbatim quote, struck through.

A skill edit is reported by quoting it with the changed words in CAPITALS, but a replacement quoted without its predecessor shows only what arrived. **Show the removal too, struck through, in the same quote.** Three consecutive edit reports in one session quoted only the new text, and the removal is the half a reader objects to, one of them silently dropped a clause the user had asked for two messages earlier.

## Report skill edits as a markdown blockquote, never a fenced code block

**Rule.** Report skill edits as a markdown blockquote.

The reporting convention asks for a blockquote and the reason is mechanical: CAPITALS and strikethrough are markup, and a code fence renders them as literal punctuation. Two consecutive edit reports in one session used fences, so the deltas the convention exists to show arrived as raw tildes. **Every line of the quote is prefixed `>`.**

## Put a convention in the conventions file the first time a lemma needs it

**Rule.** Record a convention in the conventions file the first time a lemma needs it.

When a derivation fixes a sign, a normalisation or a projection constant that the conventions file does not carry, **add the row before finishing the lemma**. *A record whose conventions file had no row for its own alternation projector and no row for the sign of a spectral part produced three separate failures from that one pair in a single day, each invisible at first order and each biting only where a one-sided inequality was applied.*

## A brief that names a reference must name its size

**Rule.** State a reference's size in the brief that names it.

**Two reviewers died in the same phase, reading a 253 kB dissertation their brief told them to consult.** Neither reached a finding; both left a report header and nothing else. *The reference folder gives no clue: `notes.md` is 4 kB and sits beside a `.txt` sixty times larger.*

**And the sharper rule, which one version of this note missed:** *the reference had already been read, and its notes carried the exact claim under audit*, "lifted off the diagonal locus with the Bianchi defect entering at one priced point". **A brief should send a reviewer to the source only when the record's own notes do not answer the question**, since reading a source the record has already digested repeats work at the cost of the reviewer.

**A brief that names a large file at all is a brief that has not checked what the record holds.**

## Applying a verdict must not assume the row it edits

**Rule.** Read the row before editing it.

**An audited result's index row stayed silent because the edit replaced a marker the row never carried.** The verdict landed in the block and the ledger, the row kept nothing, and the result reappeared as unaudited on the next pass, costing a second full pair had the ready-list not been read carefully.

**The rows are of two kinds:** those already marked by a previous pass, and those never marked at all. *An edit written for the first kind is a no-op on the second, and a no-op that raises no error is indistinguishable from success.*

**The rule:** after applying a verdict, **read the row back**. The structure check's own count of results awaiting audit falls by one when the application worked, and does not when it did not, *so the number that reports progress is also the one that verifies it.*

## Validating a finding means checking the identification, not only the arithmetic

**Rule.** Check what a finding identifies, not only its arithmetic.

**Two reviewers agreed that a formula was the wrong one, their numbers were right, and the reading was wrong**, the record's own passage, confirmed at five splits, said which quantity the formula named. Three files were edited before it surfaced.

**Agreement between independent readers is weak evidence about a definition.** They are cold on the same sentence, so a shared misreading of what a symbol denotes survives both of them; what their independence tests is derivation, not vocabulary. **So validate the identification against the record, what is this quantity, and does the record already say, before validating the algebra.**

## Before applying a repair, check what each claim quantifies over

**Rule.** Read what each claim quantifies over before editing it.

**Three repairs this audit made were themselves wrong, and all three failed the same way**: a statement was checked for internal soundness and not against the set it ranges over. One credited a lemma about *critical* points with closing a clause about *equality* points, where the first set is a subset of the second, so the credit ran backwards. One read "the strict inequality fails" as "the equality holds", turning a lost maximality into a lost nondegeneracy. One took two reviewers' shared reading of which quantity a formula named.

**A reviewer's algebra is usually right; what travels badly is the identification.** So the check before applying is not "does this derivation hold" but **"what does each side range over, and does the record already say"**, the containment, the quantifier, the object named. That question would have caught all three at zero cost.

## Check the block's "what it does not need" list first, clause by clause

**Rule.** Check a block's what-it-does-not-need list clause by clause, before anything else.

**A list of hypotheses a result does not require is the one sentence in a block that no later step consumes**, so nothing downstream breaks when it is wrong and only a reader comparing it against the derivation ever tests it. Every such list this audit examined omitted something the argument genuinely uses, and in one case a pair of reviewers restating the block propagated the omission with it. **So a brief should quote the list back and check each clause against what the derivation actually consumes, before attacking anything else**, the defect it finds is the kind that leaves a true theorem uncitable rather than false.

## A block scan must end at the next heading of any level, not the next heading of its own kind

**Rule.** End a block scan at the next heading of any level.

**A checker that ends a result's block at the next heading *of the same kind* makes each block swallow every intervening result of other kinds**, so its dependency edges report citations that the block does not contain, one scanned block ran four hundred lines and absorbed the very result it was reported as citing. The failure is invisible because the edges look plausible and nothing downstream consumes them, and it is expensive because a reader builds findings on the derived signal instead of opening the block. **So a block ends at the next heading of any level, and any edge a scan reports is confirmed by reading the block before it is recorded.**

## When a block restates a reviewer's finding, check the variable the verdict was about

**Rule.** Check which variable a restated verdict was about.

**A block restating a review reliably keeps the reviewer's reasoning and loses the variable their verdict ranged over**, a diagnosis explaining *why* a proof misses a case gets installed as the hypothesis, a disjunction arrives with one branch, a basis choice or a positivity guard is dropped from the restatement while the argument that needed it stays. The result is a restriction that is often still true, so any check asking only "is the stated hypothesis correct?" passes it; what fails is that the hypothesis is does not the one the proof consumes, and the block may not define the symbol it is now written in. **So a brief compares the block's restriction against its source's own words, and asks which variable the source's verdict quantified over.**

## A pointer check must verify where it lands, not that it exists

**Rule.** Check where a pointer lands, not that it exists.

**A structure check that confirms every indexed result has a block somewhere, and every block is indexed, still passes a record whose pointers send readers to the wrong file**, it tests the shape of the link and never resolves it. On this record that left six stale pointers standing: index rows, canonical `Proof:` lines and a ledger reference, three of them for results nobody had audited, and for one result the three pointers disagreed with each other. **So the check compares the file each pointer names against the file the block is actually in**, which is three lines against data the checker already parses.

## A position file quotes a definition from the record, never restates it in its own symbols

**Rule.** Quote a definition verbatim from the record; never restate one in a position file's own symbols.

**A hunt starts from its position file, so a definition paraphrased there is the definition the hunt attacks.** One such paraphrase lost a sign while moving an operator from a closed form into projection blocks, and the operator it produced was positive where the real one was zero, so the hunt would have proved its grant for the wrong object. Every definition in a position file is copied verbatim from the record's primary statement with a pointer to the line it came from.

## Before reserving a run as blocked, read the definition of the object the run would need

**Rule.** Read the definition of the object a reserved run would need before reserving it.

**A cycle reserved a search for a critical point at which a residual is nonzero, and the record's definition of a critical point is that the residual vanishes.** Two reviewers settled it from the definitions in a line; the run had already been approved and made. Before a plan item names a computation as its block, the object the run would find is checked against the record's conventions file, since a run for an object the definitions exclude is not blocked but empty.

## The loop's present-and-continue handoff overrides the commit skill's approval step

**Rule.** State that the loop's handoff supersedes the commit skill's approval step.

**When the skill is untouched, the research loop's handoff says to present the message and continue, and the commit skill it then invokes says to wait for approval.** A cycle read the second as binding and stopped to ask, which is the stop the loop exists to prevent. The loop skill states that in the untouched case the commit skill is the route and not a gate, and the cycle commits without asking.

## Subagents inherit the parent model, so a step's model rule reaches its reviewers too

**Rule.** State a step's model rule as reaching its subagents, since they inherit the parent model.

**A loop that puts some steps on a strong model and others on the default will break the rule silently through its subagents**, which take the parent's model whenever no per-agent or default-subagent model is configured. A review step specified to run on one model therefore runs on whatever the derivation step was switched to. Pass the model explicitly when spawning, or state in the step that its agents inherit and must be checked.

## A log-matching pattern is verified against a real filename, not against its own docstring

**Rule.** Verify a log-matching pattern against a real filename.

**A hook that detects running agents by filename has now missed a fourth naming convention**, its docstring recording the previous three and the breakage each caused. The pattern list requires a name beginning `reviewer` or `r<digits>`, and logs written as `review_r<digits>.log` match none of it, so eight consecutive reviewers were invisible to the detector. When a rule keys on a filename, the launch instruction states the exact name the detector matches, and the detector is exercised once against a file the loop actually writes.

## A finished loop's flag must be disarmed, because an armed flag shadows the loop that is running

**Rule.** Disarm a loop's flag as its closing action, and have a hook that dispatches on several flags report which one it took.

**Two loops can be armed at once, and the Stop hook checks one of them first and never reaches the other.** Here the audit flag stayed armed after its audit closed; with nothing awaiting audit its branch exits silently, so the research cycle's own branch, the one that names the next plan item and refuses a bare ending, was unreachable for the rest of the session. The loop that finishes disarms its flag as its closing action, and a hook that dispatches on several flags reports which one it took.

## A loop that forbids the other loop's flag needs a flag of its own

**Rule.** Give a loop that forbids another's flag one of its own, with a branch reading its own queue.

**The verification loop tells the cycle not to arm `research-loop-active`, correctly, since that routes the Stop hook to the research plan, and nothing replaces it, so the loop runs with its continuation rule unenforced and stops after one phase.** [loop_flag.py](hooks/loop_flag.py) knows only `research-loop-active` and `audit-active`; a session in the verification loop arms nothing, `armed_for` is false, and the hook exits before any check. Add `verification-active` with a branch that reads [plan-verification.md](../plan-verification.md) and hands back the next unchecked id and phase, so the rule that is written down is also the rule that fires.

## A per-lemma brief cannot see a contradiction that lives between lemmas

**Rule.** Give at least one brief per block its neighbouring entries, so a contradiction between lemmas has a reader.

**One entry's display was refuted in writing by another entry in the same file, and the round auditing the first left the display standing**, the brief quoted one block, and the refutation was three blocks away. Both entries passed their own audits while contradicting each other. Before dispatching, grep the file for the brief's own displayed formulas and include any passage that restates or denies one, marked as context rather than as verdict.

## A queue row's id must be readable by the tooling that names the next task

**Rule.** Give every queue row an id the tooling's parser matches, and widen the parser when a row needs a suffix.

The verification queue carried a row reading `F7, F9, F10, F11, F12`, and the Stop hook's parser matched only `L\d+`. So the hook skipped tier C's last live row and named a tier 0 id instead, every time it fired. **The row sat unread through six rounds**, and one of the findings in it, a boxed lower bound stated upward, was still false when it was finally adjudicated. *A row the tooling cannot name is a row the loop walks past, and nothing about that failure is visible from the row itself.* **Give every queue row an id in the form the parser reads, and when a row needs a suffix, widen the parser rather than the convention.**

## An entry prints the constants its own numerals depend on

**Rule.** Name where every constant comes from at the point of use, so no reader has to reconstruct it.

L158's numerals were all exact and three separate readers filed defects against them, because the entry never printed $C$, so each reconstructed the derived parameter for itself and three got it wrong. **The cost was five agents and three false findings.** *A constant that every numeral depends on and no line states turns an entry into one that must be re-derived from a neighbour before it can be read.* **When a value is used, name where it comes from at the point of use.**

## A refuted entry is not a closed entry

**Rule.** Audit a refuted entry for what still stands in it, not only for what has fallen.

L152's heading listed two failures; the entry carried five, three of them overturned elsewhere in the same file and left standing, one *sixteen lines* below the lemma that overturned it. **Nothing cites a refuted entry expecting the refutation to be complete**, and a surviving clause inside one travels without its refutation attached. **Audit refuted entries for what still stands in them, not only for what has fallen.**

## Three verifiers reaching the same argument is corroboration, not verification

**Rule.** Tell the loop what to do when verifiers converge: record the shared argument as the loop's own repair, marked as such, and keep the verdict at `HYPOTHESIS-DEBT`.

**The verifier half is already in [verification-loop/SKILL.md](skills/verification-loop/SKILL.md)**, a verifier never supplies a missing argument, and one that does *hands the record a fresh proof nobody audited, arriving under the letterhead of a check*. **The loop half is absent**: nothing says what the round does when three verifiers supply the *same* argument, which is where the agreement starts to read as verification.

When a claim has no proof on file, the verifiers reliably supply one, and when three supply the *same* two-line argument, the temptation is to treat the agreement as a check. **It is not: no cold reader has audited that argument, and it arrives under the letterhead of a check.** The correct output stays `HYPOTHESIS-DEBT`, and the loop may write the argument in **as its own repair, marked as such**, so the next round reads it as text rather than as something already verified.

## Gate 2 answers the question it was asked, and the question is the author's to frame

**Rule.** Put every quantity the author already doubts into the brief as a question, or it passes unexamined.

A derivation was sent to Gate 2 carrying a *ratio*; both reviewers confirmed it exactly, and neither could reproduce the *base* the ratio multiplied. The base had been flagged as unreproducible in the author's own working notes and sent anyway. **A Gate 2 pass covers the claim in the brief and nothing adjacent to it**, so a quantity the author already doubts must go into the brief as a question, or it passes unexamined behind one that did.

## The brief's file list is a claim about where the argument lives, and it inherits the record's filing errors

**Rule.** Before accepting "no argument on file", search the derived documents too, the report, the conventions file, the reviewer scripts, not only the file the brief named.

Three verifiers correctly reported that hypotheses were stated nowhere and that a membership claim was argued nowhere; all of it sat in the report section that mirrors the block, which the brief did not name. **A derived document can run ahead of its sources**, and when it does, a brief built from the sources makes every reader report the same absence.

## The whole-record search runs on the round's own findings, including the ones it raises last

**Rule.** Apply phase 2's search to any finding the round adds later, before filing it, a finding raised in adjudication and written up at the end has never been searched.

A round that had just diagnosed three verifiers for skipping that search filed its own `HYPOTHESIS-DEBT` without running it, and the owed statement turned out to be two-thirds present in a neighbouring block. **The check is cheap wherever it is applied and the round's own findings are the ones nobody applies it to.**

## A row filed as blocked names the piece it waits on, not the field it belongs to

**Rule.** When a scan files a row `blocked` or `out`, make it name the specific missing object, a definition, a lemma, a construction. A row whose blocker is a subject area is misfiled until someone reads its argument.

The skill already says to classify by what the argument needs rather than by what the statement mentions, and calls that the scan's one systematic error. **The rule cannot fire at scan time**, because the scanner is reading statements, that is all an index holds. Naming the blocked piece is the test that can be applied without the argument: *"needs the LP"* and *"real analysis on orbits"* are fields, and both rows turned out to be reachable, one by a dual certificate the record had already written down and one by a cubic root.

## Every derived constant in a Lean file is a theorem, never only a comment

**Rule.** When a file's prose names a number the file did not import, a gap, a margin, a growth rate, state it as a theorem too. A docstring is unchecked text sitting inside a checked file.

Two rounds in succession stated a hand-derived constant in a theorem and got it wrong; the kernel refused both, and both would have passed unnoticed in a comment. **The loop exists because prose carrying arithmetic is unreliable, and a Lean file's prose is prose.** The rule costs one line per constant and converts the file's commentary into the same currency as its content.

## To decide a question over rationals, carry them as normalised integer pairs

**Rule.** When a claim ranges over a finite set of rational values, a census, an ordering, a maximum, represent each value as its normalised numerator–denominator pair over the naturals. Kernel `decide` then closes the enumeration.

`ℚ`'s equality does not reduce in the kernel, so `decide` fails on any collection of rationals, and the natural fallback is to report the enumeration as a search the file does not prove. **The pair representation removes that fallback**: equality becomes structural, `Nat.gcd` reduces, and a claim that was scope-limited prose becomes a theorem. Raise `maxRecDepth` and it scales to a few hundred points.

## Five Lean-round statement checks, filed as bullets beneath another entry

- **A theorem whose statement is true of every input is padding, and the draft is where to catch it.** Two consecutive rounds shipped drafts containing an identity that holds for any values, a trace minus itself, a dimension subtraction, placed where the round wanted a structural claim. Before a file is wired in, read each statement asking what input would make it false; if none exists, either strengthen it into the claim it was standing in for or delete it.

- **A sampled or restricted quantity bounds one side only, and a block that reads an equality off it has the inference backwards.** **Five blocks across four files were found doing this**, one inferring an unmeasured rank from a measured one through `≤`, one reading `= 14` off a sampled matrix with `rank ≤ 14`, one printing `=` for an infimum a census bounds only from above. It is a programme-wide habit, not a local slip. Both look locally sound because the arithmetic is right and only the direction is wrong. When a round meets a measured number feeding a conclusion, check which side of the inequality the measurement sits on before checking the number.

- **A hypothesis stated and never used narrows a result silently, and the audit language for it is "far more general than claimed".** **Eight blocks in one pass were found carrying one**, which makes it the most common defect the layer has surfaced. Examples: a dimension bound guarding the variable count rather than the conclusion, a multiplicity condition absent from the rank formula it appears beside, an orthogonality holding at any base point over any Euclidean space while stated at a critical one, a Cauchy-Schwarz bound stated at critical points and true at every unit vector, and a third condition that never enters its own derivation. Each is invisible locally because the proof is correct as written. When a round records what a statement needs, list the hypotheses the proof does *not* touch as well, that list is a finding, not a byproduct.

- **When a finding is about the *shape* of an argument rather than its content, state it as an implication with a false antecedent or a refuted converse, never as a disjunction whose second branch is trivially true.** Two drafts in one session reached for `¬(A → C) ∨ C` and similar to express "the conclusion survives its argument"; both are provable by taking the right branch and say nothing. The honest forms are short: `(hH : ¬H) : H → C` for a vacuous implication, and an explicit counterexample for a failed converse. **The shape recurred three times in one session after the rule was written**, so make the check mechanical rather than attentive: **run the check before the build, not after**, the occurrence caught earliest in this session was the one where the grep ran first, and every earlier miss was found after wiring in or not at all. Grep the new statements for `∨ True`, `rfl`, `:= h`, and any proof term that is a hypothesis applied to its own arguments (`h x hx y hy`), and delete every hit. The grep alone misses the last form, which slipped through once after the rule was written, so read each proof term as well as searching it. It also fires on `rfl` inside a witness for a genuine existence claim, which is the honest counterexample form, so treat every hit as a prompt to read, not as a verdict. **A satisfiable existential over `Prop` matches none of those patterns and is the form that now slips through**: a draft claiming two reductions independent wrote `∃ P Q : Prop, (P ∧ ¬Q) ∨ …` and discharged it with `⟨True, False, _⟩`, which is provable for any statement whatever. Add `∃ .* : Prop` to the grep, and treat any proof term containing `True` or `trivial` as a hit, a claim about specific objects should never be dischargeable by supplying the truth values. A statement no input can falsify belongs in the docstring, not the file.

- **Two objects sharing a name or a numeric value license no transfer between them, and the record does this in both forms.** Three blocks were found moving a result across a shared label, an equality case transferred between two quantities both written `Π`, three letters carried from one operator's diagonal to another's, and a target landing on a ceiling proved for a different quantity that happens to equal it. Each reads as a citation rather than a step, which is why none was caught by checking the mathematics on either side. When a round follows a citation, check that the cited object is the one the citing block names, not only that the cited statement is true.

## A correction carries the phrase it removes into the chronology

**Rule.** A round that corrects a passage it quotes writes the superseded wording into the history file as a quotation, not a paraphrase.
 An audit of one layer's quotations found `23` of `115` no longer matching the record; one was a misquote and the rest were phrases a later round had correctly deleted while quoting them in the file that did the deleting. Neither step is a mistake and the pair still fails, so the rate grows with how much the loop corrects, write the superseded wording into the history file as a quotation, not as a paraphrase.

## A coined phrase is marked differently from a quotation

**Rule.** Reserve the citation marker for spans findable in the record verbatim; give coinages a visibly different one, and paraphrases neither.
 A layer used `*"…"*` for both the record's wording and phrases its own files invented to name a hypothesis; an audit reading every span as a citation reported three coinages as missing sources, which is a category error in the question rather than a false positive in the checker, no normalisation would have caught it. Fix the convention before auditing against it, and state it once where the files can see it. **A worked form**: reserve the citation marker for spans findable in the record verbatim, give coinages a visibly different one, and mark paraphrases with neither, then a checker's hits are all real.

## Read a file's head before appending to its foot

**Rule.** Before writing into a file that already exists, appending, overwriting, or extending, read enough of its head to learn its conventions. A file that scores its entries, names its owner, or forbids a form says so at the top, and an append lands at the bottom where none of that is visible.

Three incidents in one session, one of them destructive. A layer file was overwritten with `cat >` without reading the target; the original was stronger, stated over $\mathbb R$ where the replacement used $\mathbb Q$, and carrying a biconditional where the replacement had one inequality, and was recovered only because a *dependent* file failed to build. A second round re-derived a result the layer already held, discovered at a namespace collision. A third filed three proposals as bullets at the foot of a file whose head defines a scoring table, so all three were invisible to the promotion pass.

**The check is one command and it is the same every time:** read the target before the write, not after the failure.

## A supervisor's completion test is the hook's own closing-line test, reused and run against a real log, never a new detector or an early artifact

**Merged 2026-09-25 from 2 entries that share one repair.** **Rule.** A supervisor imports the anchored closing-line test the Stop hook already implements, and tests it against one real closed log and one real heartbeat before arming. *Every divergence on file is a detector written beside a working one: a hand-written pattern, a broken bracket class, or a file's existence standing in for completion.*

**Fix beside each occurrence.**

- 57, three occurrences: reuse the hook's test and run it against real logs before arming.
- 112, one critical occurrence: the same repair, since the hook's test reads the closing line and never a skeleton file.

#### A watchdog reuses the hook's closure test rather than restating it


**A loop that arms its own watchdog over agent logs takes the closure test from the hook that already implements it, rather than writing a fresh one that looks equivalent.** The test has to accept a timestamp before the closing word, tolerate a remark appended below it, and stay anchored so a heartbeat mentioning the word mid-sentence is not read as closure, three conditions that are obvious only after each has been paid for, and a hand-written detector meets some of them and looks correct.

**The failure is silent in the direction that costs most.** A detector that misses a closure reports the agent as still running, so the loop waits on work that finished; nothing errors, and the only signal is an eventual cold-log warning that reads as a stalled agent rather than a blind watcher. *A watchdog written this way reported no closure at all for a round whose three agents had all filed, and its "cold" line arrived long after the round was adjudicated from the reports directly.*

**The recurrence is the point.** This family, a detector re-implemented beside a working one and diverging from it, has cost a missed log-name pattern and **three** blind watchdogs, each time within a few lines of code that already handled the case.

**And the repair recurred as the same failure.** A watchdog rewritten to accept a timestamp prefix used the bracket expression `[0-9:._ TZ[]+-]`, in which the unescaped `[` closes the class early and leaves a literal `-]` behind, **so the corrected detector matched nothing at all**, and its silence looked exactly like the silence it was written to fix. *A detector is testable against the logs already on disk in one command, and neither version was tested before it was armed.* **Test a closure detector against a real closed log and a real heartbeat before arming it**, which costs one command and is the only step that distinguishes a working pattern from a plausible one.

**And set the cold threshold from the longest silent phase the work actually has, not from a round figure.** An agent writing a long report makes no tool calls for many minutes by design, so a threshold shorter than that reports every healthy agent as cold and trains the reader to ignore the warning, which is the failure the warning exists to prevent. *Three agents once tripped a fifteen-minute threshold simultaneously while all three were mid-report, and the only true signal in that window was the completion notification the harness sends anyway.* **Where the harness notifies on completion, the watchdog's job is the case it cannot see, a process that dies without exiting, and its threshold belongs well beyond the longest legitimate silence.**

#### A supervisor's completion test reads the agent's own closing line, never an artifact the agent creates early


**Proposed rule.** **Rule.** A supervisor decides an agent has finished from the agent's anchored closing log line alone, never from the existence of a file the agent is instructed to create in its first phase.

*A watchdog treated the presence of a reviewer's report as completion, while the skeleton-report rule makes that file exist from phase 0, so it exited seconds after every dispatch declaring success and no round was ever supervised.* Two rules each correct, and their interaction disarms the supervisor silently, which is worse than having none because the arming step reads as protection.

## Arguments that BOUND an object survive errors that kill arguments which COMPUTE it

**Rule.** Prefer bounding a quantity by a structural property over computing it in coordinates.

Given a choice between deriving a quantity in coordinates and bounding it by a structural property, prefer the bound, not for elegance but for failure mode. *In one session three chains that computed a coefficient block by block were refuted on a sign convention and an omitted perturbation term, while every result that bounded the same coefficient by a range-length or an annihilation property survived, including under the same convention error.* **A bound that is invariant under the convention cannot be broken by getting the convention wrong.**

## A quantity withdrawn under one reading returns under the same name until the record renames it

**Rule.** When a value is withdrawn from a role, rename it to what it actually measures in the same edit.

**A measured number was refuted three separate times as the supremum it was taken for, each refutation recorded, and a fourth cycle used it the same way again.** The withdrawals all said what the number is *not*; none gave the quantity it *is* a distinct name, so the string kept matching the wrong slot on every later search. When a value is withdrawn from a role, rename it in the same edit to what it actually measures, and let the old name resolve to nothing.

## The round's own repairs get the scrutiny the round gave the text

**Rule.** Treat a repair as new text by an interested author, and re-read it cold before closing the round.

Twice in one session a round wrote a fresh defect into the record while repairing one: a cost priced at a superseded constant, after that same round had written up *"a superseded constant surviving in a neighbouring paragraph"* as the block's pattern; and a derivation built on the wrong member of a symbol pair, three commits after the round had written a warning about exactly that pair into the record. **Writing the trap down does not protect the next paragraph from it.** *A repair is new text by an author under the pressure of a finding, which is the condition the loop distrusts everywhere else.*

---

## A global substitution is forbidden from the text that argues about the value

**Proposed rule.** **Rule.** When a recorded figure is corrected everywhere, exclude every sentence that *reasons about* the old figure; correct those by hand or delete them.

A correction applied "in all places" reaches the prose explaining why the old value was wrong, and rewrites that explanation into an assertion about the new one. The result is a paragraph asserting a figure, then that the figure is unreachable, then the figure again, **and it reads as an argued position rather than as damage**, so it survives audits that a bare wrong number would not. *The tell is a constant that belongs to the old value's arithmetic surviving beside the new one: it fits nothing in the repaired sentence and is the fingerprint of what was overwritten.*

**And a superseded figure is not always an error.** Two figures differing by a wide margin may measure two different bounds, one of them tighter and undisplayed; the "correction" then deletes the better result. **Before replacing a number, say which quantity each figure measures.**

## Stage by path when other agents share the index

**Proposed rule.** **Rule.** Never `git add -A` where concurrent agents write; stage the paths you own.

Agents running in parallel share one working tree and one index. A blanket stage sweeps another agent's in-progress file into a commit under the wrong message, and the displaced agent's own commit then finds nothing to add. *The content survives and the attribution does not*, so the record shows a verdict filed by an agent that did not reach it.

## An annotation enters a round as a claim, because annotations decay faster than prose

**Proposed rule.** **Rule.** Brief every annotation as a claim to check, never as a settled finding, and date-check any annotation asserting an absence.

A correction written beside a block records what was true when it was written. The prose it corrects then gets repaired, or the gap it names gets filled elsewhere, and **the annotation stays**, now asserting a defect that no longer exists, in the same emphatic voice as the ones that still do. *A reader cannot tell a live correction from a dead one, and neither can a round that inherits them.*

**The sharpest case is an annotation asserting that something is defined or proved nowhere.** That claim is refuted by any later commit, so it decays fastest and reads most authoritatively; one was found stale by under a minute against the very commit that defined its subject. **Check the timestamps before repeating such a claim.**

**And a block can be half-repaired**, some annotations absorbed into the prose and others left standing above it, which is worse than none absorbed, because the reader cannot tell which half is current.

## Ask what the consumer consumes before choosing among candidate statements

**Proposed rule.** **Rule.** When several derivations of the same fact are on hand, pick by what the consumer needs, not by which is most general.

A verification round that refuses its checkers' proofs leaves several derivations of one fact to be adjudicated later. **The reflex is to keep the most general and discard the rest as special cases**, and generality can cost the very property the consumer needs, turning an equality at one object into an inequality over a family. *An inequality supports no argument that requires knowing the object exactly.*

**The cost is invisible at the moment of choice**, because the general statement implies the specific one numerically while no longer implying it logically. **Read the consumer first; then choose.**

## A check is scaled to the part of the claim that is not machine-checked

**Proposed rule.** Before dispatching checkers at a result, split it into the part a machine-checked file discharges and the part it does not, and dispatch only the second. A population of cold readers re-deriving an identity a kernel has already accepted buys nothing and costs a full round.

**The split also decides the count.** Several independent readers are worth their cost where the claim rests on prose, because the errors a cold reader catches are drawn from a wide distribution. **They are worth nothing against a formal statement**, where the distribution has one point and the kernel already sampled it.

**And a finding that is a claim about arithmetic is settled by a machine-checked file rather than by adjudication.** Two readers arguing over an identity is the weakest instrument available for it, and the strongest is a few lines that either compile or do not.

## Options come before the pathspec, and a pathspec commit stages nothing

**Proposed rule.** Write the commit as `git commit -m "..." -- <paths>`, and `git add` those same paths first. Every option must precede the `--`, and a pathspec commit leaves the index empty, which is what the structure gate reads to decide whose failing row it is looking at.

**Two failures ride on the same line, and a brief has been prescribing the broken form.** *Written as `git commit -- <paths> -m "..."` git reads `-m` and the message itself as more pathspecs and refuses the commit outright.* **And with nothing staged, [structure_gate.py](hooks/structure_gate.py) cannot attribute a failing row and fails closed**, so a reviewer is blocked by a sibling's half-written report, which is exactly the case the gate's own comment says it was built to let through. *Staging the two paths restores the attribution; the pathspec on the commit still keeps a sibling's staged file out, so nothing about the isolation the rule exists for is given up.*

**And the `git add` must be its OWN tool call.** *The gate is a `PreToolUse` hook, so it reads the index **before** the command runs: written as one `git add … && git commit …` line the index is still empty when the attribution runs, and the reviewer is blocked by the sibling's row exactly as if nothing had been staged.* **Two calls, add then commit**, [r762](../reviews/REVIEW_r762.md) was blocked twice by [761]'s unfiled report before splitting them.

**Second occurrence, the missing half of the rule, in the verification loop.** *A round's brief told three verifiers to stage only their own report by path and did not tell them to commit with a pathspec. The parent had staged an unrelated Lean discharge while they ran, and one verifier's plain `git commit` swept it in under a message naming only its report, while the parent's own commit failed on the moved `HEAD`.* **Fix beside it: the same, `git commit -m "..." -- <own report path>`**, which keeps a sibling's staged files out of the commit. *The loop's own dispatch had carried this as a standing instruction in earlier sessions and the brief written after a compaction dropped it.*

## A brief auditing a fold is written from the reports, not from the folder's account of them

**Proposed rule.** When a brief asks whether findings were applied faithfully, it hands the reviewer the reports and tells them to enumerate the findings themselves; any list the brief supplies is a checklist read second, and is labelled as the folding cycle's own.

**A list written by the cycle that did the folding reproduces that cycle's omissions**, so the audit is blind to exactly the findings most likely to have been dropped. *One such brief listed nine findings and missed three, two of them made by both reviewers, including the one a reviewer had ranked as the single most dangerous inherited hypothesis. Both auditors found them only because the brief also told them to distrust its own list, which is a fix that happened to work and cannot be relied on.*

## A finding that names a set is folded by copying the set, not by re-deriving it

**Second occurrence, the round after the first.** A reviewer named the operator form of a quantity as *"the cheaper citation"* for a hazard; the fold recorded it as a separate remark about citations and left the circular sentence standing as the citation. **Both occurrences are the same shape**, the reviewer's own words available, and the fold writing something adjacent to them.

**When a Gate 2 finding enumerates, the two risks an abstraction cannot see, the three hazards, the four ingredients, the fold reproduces the reviewer's members verbatim and cites the section they came from; re-deriving the enumeration from memory of the finding is where a member gets swapped.** *Folding [L174](../findings/second-order.md), both reviewers named the norm and the extremal/per-frame swap as the two risks invisible to [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s abstraction; what landed in the docstring and in [lean/INDEX.md](../lean/INDEX.md) was the norm and attainment of $\max_F$, so the swap, the one risk with a record of having already occurred, left the L174 material entirely, while a hypothesis both reviewers had discharged was reopened as a live risk.* **Each member is true on its own, which is why the substitution reads as compliance and survives a check that only asks whether the sentence is false.**

## State a numeric bound at the precision its inputs certify, and never as an equality

**Write a bound as an inequality against a rounded-DOWN numeral, and never assert the product of rounded inputs as the value.** *A product of two five-decimal quotations is not accurate to seven decimals; reading each input as rounded puts the true product in an interval, and a numeral inside that interval is not entailed even when it happens to be right.* **So round each factor in the safe direction, state the bound to the digits that survive, and say which direction the rounding went.**

**The incident.** A block asserted a limit constant to five decimals with the last digit wrong, then asserted the product of that mis-rounded factor with a second quoted constant as an equality, then used it as a lower bound. *The argument was sound and every numeral in it was defective; a second numeral in the same block was refuted outright by a machine check before commit, and a reviewer showed the stated bound was not entailed at its last two digits.* **Critical, because a bound that is not entailed at its stated precision is a false statement standing where a true one was available for free.**

**What it costs to comply: one digit.** *The safe form is shorter than the unsafe one.*

## Run the brief's attack list against the block before dispatching it

**Once the attack list is written, answer it yourself against the block, and repair what it catches before the reviewers are launched.** *Writing the list is the moment the author first looks at the claim the way an adversary will, and it is a different act from writing the claim, which is why it finds things the author has read past a dozen times.* **A defect the author can find with the list is one the audit should not be spent on**, and every such defect that survives to dispatch either consumes a reviewer's attention or arrives as a correction mid-round, both of which cost more than answering the item would have.

**The incident.** A chain of two lemmas went to audit with an attack list naming its own weakest points. Working that list against the blocks, after dispatch, not before, produced five defects in succession: a false "if and only if", a hypothesis stated and unused, an obstruction that conflated two inequivalent conditions, a reduction claimed for a case it does not cover, and a sign asserted without its orientation. *Four reviewers were already running, so each repair went out as a mid-round correction.* **The list found all five and the audit found none of them, because the audit was still reading the version the list had already broken.**

**What it costs to comply: answering your own list once.** *The pull to skip it is that the list feels like output rather than input, it is written for someone else, so it does not read as a thing to act on.*

## Check a reviewer's correction before applying it, the fold is a judgement, not a transcription

**Derive each correction before it lands, exactly as the claim it corrects was derived.** *A reviewer is right about most things and that is precisely what makes the exception expensive: a fold that has agreed with nine findings applies the tenth without looking, and the tenth is the one that replaces a correct attribution with a wrong one.* **A correction is a claim, and it enters the record with the reviewer's authority and none of the reviewer's evidence**, the report gives a verdict, not always a derivation, and the fold is the last reader who can tell the difference.

**The incident.** A block attributed a well-definedness to the right group. A reviewer proposed a different one, the fold adopted it, and a later round showed the substitute does not supply the statement at all, so a correct clause was degraded by an audit whose other findings were all sound. *Critical, because it inverts what the audit is for: the round improved the mathematics everywhere except where the fold stopped thinking.*

**What it costs to comply: derive the correction.** *The pull to skip it is the reviewer's track record within the same report, which is exactly the wrong evidence, a report's earlier findings say nothing about its later ones.*

## Ask whether a bound's hypotheses are satisfiable before recording the bound

**A valid argument from contradictory hypotheses yields a true bound that is weaker than the truth, and reads as a live constraint.** The derivation is sound, the number is right, and the claim still misdirects, a reader takes it as saying configurations exist below the bound, when none exist at all. **So before recording an inequality, exhibit one object satisfying its hypotheses, or show there is none and record THAT.**

*It recurred within the hour of being filed, on the next lemma of the same line, and the second time cost two Gate 2 rounds and a false census in the record. The failure: an argument gave `dim V ≤ 5` on a branch, and it was recorded as a bound. Both Gate 2 reviewers found the hypotheses contradictory at every width, the branch is empty, reaching it by two independent routes, and one noted the record already held a stronger statement two lemmas earlier. The bound was true and two dimensions too timid.*

**The skills already hold the neighbouring rule**, *a true statement that is trivially true*, under how to validate a REVIEWER's finding. What is absent is the same test applied to the cycle's own derivation, at the moment it is written rather than at the moment someone else's is read.

## Re-check every premise against the configuration it is used in, not the one it came from

**A case analysis carries its premises forward, and a premise exact in one case can be vacuous in the next.** The step reads identically in both, so nothing looks wrong: the sentence is the same sentence, its derivation is the same derivation, and only the objects it quantifies over have changed. **So when a case splits, re-derive each carried premise inside the new case rather than inheriting it.**

*The failure: a bound `dim V ≤ 6` was derived from `supp ω₁ = supp ω₂ + P₃` where `ω₂` was a plane, and carried into the case where `ω₂` is not. There it reads `dim V ≤ dim V + 2`, vacuous, and it was exactly the rank bound the argument existed to prove. Two reviewers located it independently; the author had checked the algebra above and below it and not the premise.*

**A circular premise is invisible to a proof assistant when it enters as a hypothesis.** The Lean statement took the rank bound as a binder and closed by arithmetic, so the kernel confirmed the step while the step assumed its own conclusion. *That is the shape to watch: a hypothesis that is standard in one configuration and is the theorem in another.*

## An index row states what a declaration states, never what a reader can infer from it

**A row that credits a Lean file with a consequence of its theorems, rather than with its theorems, reads exactly like a row that is right.** The inference is usually sound, which is what makes the row survive: a reader checking it reconstructs the same two steps the author did and agrees, and neither party asks whether the conclusion has a name in the file. The row is what later work cites.

*One instance. A spanning lemma plus an independence lemma give a dimension, and the row asserted the dimension where no declaration in the layer states one.*

*Two neighbours were first counted here as recurrence and are separate failures with separate fixes.* **A vacuous declaration**, an identity rowed as a check on a normalisation when its two sides are definitionally equal, so it cannot fail for any input, *is already covered by the exhibit-one-object check.* **A false credit**, an attainment at one point rowed as supplying a rigidity clause, *claims something that does not follow from the file at all, where this rule is about a conclusion that does follow and is unstated.* **Counting them together is what pushed this proposal over the promotion bar**, and a category broad enough to hold three unrelated defects is how a single incident gets promoted.

**Write the row from the declaration names and their statements, then ask what a reader would cite it for.** Where the useful claim is a consequence, the row says so and names it as owed. **A row asserting the consequence obliges a declaration carrying it**, and writing that declaration is usually cheaper than softening the row.
## Step 1's question asks what the item proves, and must also ask what stands between that and the goal

**A grade that scores tractability selects for tractable corners, and every cycle of work on one is legal, produces a deliverable, and leaves the goal exactly where it was.** The corner is usually worth doing: it is where a supremum is attained, or where the constant is sharp. What it is not is progress toward the goal, and nothing in the cycle distinguishes the two, because a cycle's success test is that it closed.

*Step 1 already asks, in one line, what the item lets someone prove and whether they could follow it. Both answers can be good while the statement reached is a lemma about a sub-family and the goal has no live route at all.*

**So the question takes a second clause: what stands between that statement and the goal, and is anything working on it?** *An item whose answer is "nothing is" is not thereby wrong to take, the tractable corner may be all there is, but the plan then says so, rather than carrying the goal at the top of the list while every cycle works elsewhere.*
## Before recording a consequence, name what would have to be true for it to fail

**A derived statement that cannot fail is a restatement of its own hypothesis, and it arrives feeling exactly like a result.** The derivation is real work, every step is valid, and the conclusion is true, so the usual checks pass. What none of them asks is whether the conclusion excludes anything, and a statement that excludes nothing has been carried, not derived.

*Two instances, one repair. A theorem took a hypothesis and concluded a consequence which, quantified over the same range, was that hypothesis instantiated. A constraint was derived by contracting an identity against a condition that annihilates it, and under that condition the constraint was equivalent to the identity it came from.*

**The repair in both is the same: state the UNCONDITIONAL identity of which the claim is a specialisation.** *Written that way the content is visible, the identity says something at every input, and where the specialisation sits inside it says exactly how much the hypotheses bought.*

**The test is one question, asked before the claim is written down: what would have to be true for this to be false?** *An answer names an object; no answer means the statement is its own hypothesis wearing a conclusion's grammar.* **Both instances announced themselves in their own prose**, one said the left side was the zero matrix times the quantity of interest, and the author read that as the finding.
## Changing a numbered result's type lands in every file that types it, in one commit

**A result's kind is recorded in more than one place, and a rename that reaches some of them leaves the record contradicting itself in exactly the way the rename was meant to end.** The heading, the numbered table's kind column, and every citation each carry it, and the one most easily missed is the table, because the change that prompts the rename is usually read in the block.

*The failure: a result whose block stated both halves proved was retyped from `Observation` to `Lemma` in its heading and in one citing file, while the numbered table kept typing it `Observation`. The record then said both, and a reader taking the kind from the table would cite a proven result as numerically verified.*

**Grep the id across the repository before the rename and after it, and let the two lists match.** The kind is a claim about evidence, so a half-applied rename is a claim the record makes twice with two answers.

## Grep the machine-checked layer for a supporting lemma before writing one

**A layer built over many cycles carries small structural lemmas under names the current work would not think to search**, and the base file a new result imports is rarely the file that holds them.

*The failure: a supporting lemma was written, proved and imported, and the whole-project build then refused it as a duplicate of one already proved in a sibling base file.* **The build catches it, which is why this is cheap rather than dangerous**, what it costs is the proof, written twice.

**Query the layer by the statement's shape rather than by the name it would be given**, since the name is the part that varies between authors and the shape is not.

## Grep for the recorded quantity a first step EXPANDS, not for the object the expansion produces

**When a derivation opens by expanding the definition of a quantity the record already names, grep the destination file for THAT quantity's own symbol before grepping for whatever the expansion produces.** The new object arrives with a fresh letter, so a search by it returns nothing while the record holds the same step under the old letter one screen away. *A block was written whose first line the destination file already carried verbatim, because the search ran on the new symbol and the record used a different one for the same sum.*

## A claim that something is open or missing is screened by reading the text beside it: the neighbouring lemma's argument and the section's opening

**Merged 2026-09-25 from 2 entries that share one repair.** **Rule.** Before writing that a constant is unknown, a question open, or a handle missing, read the argument of the lemma the claim sits beside and the opening paragraph of the section it is written into. *A negative claim reaches the record unscreened, and the text that refutes it is usually adjacent and phrased in an older vocabulary a grep misses.*

**Fix beside each occurrence.**

- 91, two occurrences: spend the neighbouring proof's inputs, and open the lemma an owed-needs line points at.
- 98, one occurrence: read the section's opening before claiming the record lacks something.

#### Calling a question open is a claim, and it takes the same screen as a positive one


**Before writing that a bound's constant is unknown, that a question is open, or that two results are independent, spend the inputs the NEIGHBOURING result's proof already spends and see whether they settle it.** A negative claim reaches the record with no screen at all, because screening feels like something only assertions need, and a wrong one misdirects every later cycle into work that was already done. *A block declared a ceiling open and two reviewers each closed it in one line from two facts the lemma directly above it had already used.*


**A SECOND OCCURRENCE, AND IT SHOWS THE RULE REACHES THE RECORD'S OWN OWED-NEEDS LINES.** A route register listed a constant as an unmet need and a plan note called pinning it an item's first sub-step. *A cycle met the need as those lines stated it, recorded the discharge across four files, and then found the constant derived in two lines inside the Argument of the very lemma the claim rested on.* **So both lines were stale rather than open, and the work was a confirmation of something already proved.** *The fix is the rule as written, applied to a class the entry did not name: an owed-needs line, a `needs:` clause in a route row, a `still owed` bullet, are each a claim ABOUT the record, and the screen for them is to open the lemma they point at and read its argument before believing that something is missing.* **The cost here was a claim recorded in the record and withdrawn twenty minutes later**, with two notebook headings left asserting it until a separate check caught them.

#### A claim that the record LACKS something is checked against the section's own opening


**Before writing that the record was missing a shape, a reformulation or a handle, read the opening paragraph of the section being written into.** A section's first paragraph carries its framing, which is exactly what a mid-section addition contradicts, and a grep for the new claim's own vocabulary cannot reach it because the framing is stated in the vocabulary of the older result. The failure costs a sentence that a reviewer or a later reader reads as the record contradicting itself, and it survives because everything else in the addition is right.

## A typed statement is evaluated where the prose claim changes truth value, before its sorry or its proof

**Merged 2026-09-25 from 2 entries that share one repair.** **Rule.** Evaluate the Lean statement at one instance chosen where the prose claim flips, at the degeneracy the prose names or at an object where the prose claim fails, and check the statement agrees with the prose there. *A statement that holds where the prose fails was typed from its own definitions; one that fails where the prose holds is mis-quantified. One evaluation separates both from the claim.*

**Fix beside each occurrence.**

- 160, two occurrences: evaluate both sides at the degeneracy the prose names, before the `sorry`.
- 97, one occurrence: instantiate where the prose claim is false and confirm the theorem does not apply.

#### A sorried statement ships with one adversarial instance evaluated in the file's own definitions


**Before a `sorry` is written under a statement, evaluate both sides at one concrete object built from the file's own definitions, and record the outcome beside the statement.** *A kernel checks the proof it is given and never whether the statement is the one the record meant, so a `sorry` marks a missing proof while nothing marks a false claim*: the hypotheses that make the claim true are written in the surrounding prose, the binders are written from memory, and the two disagree silently for as long as nobody attempts the proof. **The instance is chosen adversarially, at the degeneracy the prose names**, since a seeded solve samples the region where the claim holds and reports nothing.

**Occurrence one**, critical: a statement of an item's open content quantified over every parameter with no genericity, so at the degenerate parameter its hypothesis held at every object and it asserted a classification that is false. The surrounding prose named the genericity twice. *Two reviewers refuted it on different witnesses, one deriving `False` from the declaration in the kernel; a 583-solution screen run beforehand had found nothing, both witnesses lying where a seeded solve does not look.* **Fix: evaluate at the degeneracy the prose names, before the `sorry`.**

**Occurrence two**, critical: a moment identity typed for every symmetric operator, where the record's own block says the moment is a check at the constrained objects rather than at full generality. Its unused hypothesis was named with a leading underscore, which is the visible tell that nobody had attempted the proof. *Four evaluations in the file's own conventions, three disagreements, seconds.* **Fix: the same one, and it is the same repair.**

*A third incident the same session, a docstring claiming a theorem says more than it does, is NOT counted here: evaluation would not catch it, the theorem being true and its description overclaimed, so its repair differs and it belongs in its own row if it recurs.*

**HELD because the score is not yet trustworthy.** *Both occurrences are one session and one author, and each `!` is the author's own counterfactual judgement made minutes after the fact. Two incidents a few hours apart are as easily one sitting's habit as a pattern, which is the case the occurrence count cannot distinguish and the `HOLD` exists for.*

#### Instantiate a typed statement where the prose claim is FALSE and check the theorem does not apply


**After typing a geometric identity, find an object at which the prose version fails and confirm the Lean statement fails there too.** A statement built from definitions that already encode the conclusion is provable without touching the geometry, so the build confirms nothing and the row describing it reads as machine-checked geometry. *One file defined a projection as an outer-product sum and then proved that a sum of such terms regroups, which is true of any summands whatever, while the prose identity it claimed to type was false at the object that separates them and the theorem applied there happily.* **The test is one instantiation and it distinguishes a typed theorem from a typed definition.**

## A status reports how many items can be STARTED, not how many are live

**A status gives the count of section 1 items scoring above zero alongside the graded total, and where every zeroed item is zeroed by the same factor it names that factor and the count.** Value is a product, so a zero is not a low ranking but an item the rubric says cannot be worked, and a live count that includes them reports a programme as larger than it is. *One plan read as twenty-eight live advance items and six attackable, with all eight zeros coming from `attackable` alone and none from importance, margin or analyticity, so the whole bottom of the list was one missing route wearing eight numbers.*

**Filed alongside the edit rather than instead of it**, the user having instructed the edit directly while the flag read `locked`. The rule stands here so that reverting the skill loses nothing.

## A route proposed to the user is screened before the sentence goes out, not after they choose

**Run a proposed mechanism against the destination file's own convention and definition notes BEFORE putting it in front of the user, to the same standard a block gets before it is written.** A route offered in conversation is acted on immediately: the user chooses, the plan is rewritten around it, and there is no gate between the sentence and the decision, so a mechanism that collapses on first contact has already cost a decision made on false information. *One session answered a demand for a more ambitious route with a mechanism resting on a Lagrange multiplier that does not exist, the map in question preserving the subspace so that the multiplier is zero and the commutator it turned on vanishes identically, and the destination file said so in one line.*

## A recorded "searched, nothing found" names the phrasing that was searched

**When a sweep records a negative outcome, write the query beside it, not only the topic.** A later cycle reading "searched, nothing found" against a node cannot tell whether its own phrasing was covered, so it either repeats a search that was done or skips one that was not, and both look identical in the record. *One sweep recorded a node as searched having queried the membership TEST for a class of objects, and a later cycle searching the CLASSIFICATION of the same objects found a sourced structure theorem in one query.*

## Key a machine-checked index row by the RESULT's id, never by the item that motivated it

**A row in the machine-checked layer's index is addressed by the id of the result it types.** The commit gate that enforces a numbered result's Lean debt matches on that id, so a row keyed by the plan item reads as an absent file and blocks the commit while the file exists and is correct. Name the item in the row's prose instead.

## When the target is a supremum, a bound failing at some points is not refuted, because a case split is legitimate

**Before writing that a route "must" supply some ingredient, check whether the goal is an extremum over a set that can be partitioned, because then handling the awkward points by any other means is a legal proof and the word "must" is false.** A bound that is weak somewhere is not thereby useless: the goal is one number, and reaching it by cases is as valid as reaching it uniformly.

**The failure produces a fence post wider than the argument earned, and a too-wide post kills live routes.** *A post is the most expensive kind of record entry to get wrong, because nobody reopens a closed route to re-derive its closure.* So the scope written into a post is exactly the scope the derivation reached, and the difference between "this bound never reaches the target" and "no argument of this shape reaches it" is the whole of what a later reader will act on.

**The tell is the word "any" or "must" in front of a proof obligation.** Where it appears, name the set the goal ranges over, ask whether the argument covers every point of it or only the generic ones, and write the scoped version. **A point whose value is already known needs no bound at all**, which is the commonest way the universal version turns out false.

*Two occurrences in one run, both refuted by two independent readers on the same ground. In the first, a floor was asserted at every dimension and every critical point while a recorded object with a large eigenspace multiplicity already exceeded it. In the second, a debt was said to require positive excess of any proof whatever, while at the one witness the value was known exactly and settled the case with no excess. Both repairs were the same: state the scope the argument reached and say what pays the debt outside it.*

## For a multiplicity or dimension question the analytical attempt is a character count over the symmetry group, and it is usually one line

**When the question is the dimension of an eigenspace, the multiplicity of an eigenvalue, or whether a list of blocks is complete, the named analytical attempt the derive-first rule demands is a decomposition under whatever group commutes with the operator, plus a dimension identity.** Write that identity before computing any spectrum. It either closes the question outright or it fails visibly, and either outcome is reached in minutes.

**The head rule already says derive before computing, and it gets skipped here because the computation looks like the derivation.** Producing a spectrum at four dimensions, fitting closed forms to the multiplicities and confirming them by prediction feels like establishing a structural fact, and the prediction passing feels like proof. *What it establishes is the fact at those dimensions, and the structural reason stays unexamined, so the account written up is whatever pattern the numbers suggested rather than the mechanism.*

**The cost is not the wasted computation, it is that the pattern gets recorded as the reason.** A fitted description can be true of every computed case and still have the logic inverted, naming as an obstruction something that is present by construction. **That reaches the record as an argument, and correcting it costs an audit** rather than the one line the count would have taken.

**The tell is a multiplicity that looks like a coincidence.** An eigenvalue whose multiplicity happens to equal a dimension with independent meaning is almost never a coincidence: it is that object, appearing in a sector nobody has named. *Ask which sector carries it before asking how large it is.*

*One occurrence. A multiplicity was established by prediction across four dimensions and written up as an inequality between two block families straddling the value; two cold readers each went to the character count first, closed the enumeration on a one-line dimension identity, and found the eigenvalue in an unnamed sector where it sat by construction. The operator's symmetry group and its block-diagonalisation were already recorded results.*

## A brief that grants access to a file NAMES that file

**When a cold brief carves out an exception to its own withholding rule, the exception carries the path.** A brief assembled by trimming an earlier one keeps the sentence granting access while losing the section that named the target, so the reviewer reads a permission it cannot act on and opens nothing. The cost is a whole attack item silently unanswered, and it is invisible in the report, which simply does not mention the file.

## A Gate 2 debt is discharged by reviewers IN FLIGHT, not only by reports on disk

**A commit gate that measures the review debt by counting reviewer files will fire repeatedly while a round is still running, because the reports do not exist until the agents finish.** The cycle then reads an instruction to launch reviewers it has already launched, and the cheapest reading of that instruction is a second redundant round on the same claims. **State the debt against dispatched rounds rather than filed reports**, and let the check pass while a round's logs are warm. The failure costs agents and, worse, teaches the cycle to ignore a gate that is right most of the time.

## A reviewer index row is matched by its ID column, never by a grep for its filename

**The completeness check for the reviewer index must key on the row's own identifier column.** A check that greps the whole file for the report's filename is satisfied by any CITATION of that report from another row, so a reviewer whose verdicts are cited by a neighbour passes the check while having no row of its own, and the top-down reader the index exists for never learns it ran. The failure is invisible precisely when the round mattered enough to be cited.

## Shell calls in one batch share one shell, so use absolute paths and explicit lists

**Occurrence 13, 2026-09-17, one hour after occurrence 12 was filed.** *A `lake build` carrying `cd lean` ran in the SAME batch as a `python3` heredoc written as `cd <repo> && python3 - ...` with the relative path `reviews/INDEX.md` inside it. The build moved the shared shell, the compound `cd` did not take, and the edit failed with "No such file or directory" on a file that exists.* **The rule's own title names this half and it had been re-filed within the hour.** *Fix beside it*: put the ABSOLUTE path inside the script and drop the leading `cd` entirely, which is what the retry did. **Thirteen occurrences, and the two halves of the title have now each failed twice in one session.**

**Occurrence 12, 2026-09-17, the OTHER half of the rule's own title.** *A sweep was written as `cd <repo> && F="a.md b.md ..."; grep -c "<the em-dash character>" $F`, and zsh does not word-split an unquoted parameter, so the ten paths arrived as ONE filename and the check reported "No such file or directory" instead of running.* **The failure is loud, which is the only reason it cost a round trip rather than a false pass**, and that is the argument for the rule rather than against it: had the command been `grep -L` or any test whose empty result reads as success, a sweep that examined nothing would have reported clean. *Fix beside it*: build the file list in the tool that consumes it, here a `python3` heredoc holding an explicit list of absolute paths, which is what the retry used and which worked. **Twelve occurrences, and this one is the `explicit lists` half of the title while occurrences 6 to 8 were the `absolute paths` half**, so both halves have now failed in the same session, hours apart, with the rule written down throughout.

**Proposed rule.** **Rule.** Shell calls issued in one batch run in one shell, so a `cd` in any of them moves every relative path in the others and an unquoted list expands as that shell splits it: use absolute paths and explicit file lists.

*A build call moved the shell into a subdirectory and a check batch then greped files that did not exist and printed a clean count, which reads as a pass, and a list of seven files passed to `sed` as one argument left thirty-seven anchors dangling into a commit.* The cost is a check that reports clean on nothing.

**Occurrence 4, 2026-09-15.** *A build call's `cd` into the Lean folder moved the relative paths of a sibling call in the same batch, so a findings insert failed on a file it could not find, and the failure was loud rather than silent.* **Fix beside it**: absolute paths in every call of a batch.

**Occurrence 5, 2026-09-16, twice in one cycle.** *A `lake build` call carrying `cd lean` ran beside three record greps in the same batch, and the greps reported "No such file or directory" for `results.md` and `ATTEMPTS.md`, which exist; a second batch repeated it, and the working directory was reported as changed by the harness both times.* **Fix: every call in a batch names absolute paths, and a call that must `cd` does so in a subshell so the batch's directory is unchanged.** *The failure was loud here, and the reason it keeps recurring is that the batch reads correctly line by line: each call is right about its own directory and wrong about its siblings'.*

**Occurrence 6, 2026-09-16, while the rule's own row was being rescored.** *A `lake build` call carrying `cd lean` ran beside a `grep` over `reviews/` in the same batch, and the grep reported "No such file or directory" for a file that exists, because the build had moved the shared shell. The cycle had added occurrence 5 for exactly this a few hours earlier and still wrote the sibling call with a relative path.* **Fix: absolute paths in every call of a batch, without exception, since the habit fails precisely when attention is on the mathematics rather than on the shell.** *The failure is loud, which is why it costs a round trip rather than a result, and that is also why it keeps being tolerated.*

**Occurrence 7, 2026-09-16, the cycle after the rule was rescored for occurrence 6.** *A `lake build` call carrying `cd lean` ran, and the NEXT batch's `python3 scripts/misc/axiom_audit.py` then resolved against the Lean folder and reported the script missing, because the harness had carried the changed working directory forward across batches rather than only within one.* **So the rule is wider than its own title**: a `cd` persists past the batch it sits in, and the fix is absolute paths in every call whether or not a sibling call shares the batch. *This occurrence is what shows the title's "in one batch" understates the failure, and the rule text should say that the working directory persists across calls.*

**Occurrence 8, 2026-09-16, in the turn that fixed a different skill bug.** *A `lake build` left the shell in `lean/`, and the NEXT call's `sed .claude/research-loop-active` failed with "No such file or directory" on a file that exists, killing a hook control test mid-way.* **The rule had been given occurrence 7 hours earlier in the same session, and the call was still written with a relative path.** *Fix beside it*: absolute paths in every call, which the retry used and which worked. **Eight occurrences, and the habit has not changed once**, which is the argument that this belongs in a hook or a wrapper rather than in a sentence a cycle reads and then does not apply.

## A sweep that rewrites headings repoints the links into them, in the same commit

**Proposed rule.** **Rule.** A heading edit is an anchor edit: whatever rewrites a heading resolves every link into it in the same commit, and reports the count it repointed beside the count it rewrote.

*A punctuation sweep over headings changed the slug of each one it touched, which staled every link written against the old slug, and the tool reported only the headings. Thirty-four anchors dangled across filed reports, round files and findings, in two batches, both found by a later audit rather than by the sweep.* The cost is a reader following a link that cannot resolve, in artifacts nobody rereads.

## A reviewer never amends, because HEAD in a shared repository may be another writer's commit

**Proposed rule.** **Rule.** A reviewer fixes its own committed report with a NEW commit naming its own path, never with `git commit --amend`, since `--amend` rewrites whatever HEAD is, and while a parent session and a second reviewer are committing, HEAD can be their commit rather than the reviewer's own.

*A reviewer amended its final report commit to strip a semicolon from the message. The reflog shows the amend replaced its own commit, but a parent commit and the second reviewer's skeleton sat directly beneath it, landed minutes earlier; had either landed in the seconds between the reviewer's commit and its amend, the amend would have rewritten a commit carrying a permanent address in someone else's name.* **Critical on a single occurrence because the failure is silent and irreversible without a rewrite**: the pathspec guards what is staged, not which commit is replaced.

## Stage record files in the call before their commit, never while reviewers are in flight

**Proposed rule.** Stage the cycle's record files in the call immediately before their commit, and never leave them staged across a Gate 2 dispatch. *Where a commit must land while reviewers are in flight, add only untracked new files and commit tracked ones by pathspec, so the shared index holds nothing of the cycle's but what the commit names.*

**The failure.** The structure gate attributes a failing row by reading the whole staged set, `git diff --cached`, rather than the commit's own paths. Reviewers stage their skeleton reports and an unindexed report is a failing row that the reviewer exemption waives only when every staged path is a report. **A cycle that stages its record files before dispatch and commits after defeats that exemption in both directions**: the cycle's commit is blocked by the reviewers' staged reports, and each reviewer's commit is blocked by the cycle's staged record files, so neither side can commit and the reviewers' skeletons sit staged. *It is distinct from [#63](#commit-the-paths-you-own-because-staging-by-path-does-not-stop-a-shared-index), whose repair, a pathspec commit, does not change what the gate reads.*

**Occurrence 1, 2026-09-14, Lemma L217.** *The cycle staged L217's seven files, dispatched r933 and r934, and committed; the gate blocked on reviews 933 and 934 unindexed, and both reviewers' reports stayed staged and uncommitted.* **Fix beside it**: unstaging the seven files, adding only the two untracked ones, and committing by pathspec cleared both sides. Not critical: no claim, bound or audit was at risk, only commits.

**The gate's own repair, for the user rather than a cycle.** *[structure_gate.py](hooks/structure_gate.py) could attribute by the paths named on the `git commit` command when a pathspec is given, and treat staged reviewer reports as someone else's in-flight work, which would remove the deadlock without any rule.*

**Occurrence 2, 2026-09-15.** *The parent staged a tracked plan file in a call of its own while two reviewers were in flight, and a reviewer's whole-index commit landed between that call and the parent's commit.* **Fix beside it**: commit the tracked file by pathspec with no prior staging. Not critical.

## A brief quotes a given by its block's boundaries, never by the first matching marker after a heading

**Proposed rule.** Extract a quoted premise between its own heading and the next heading of the same level, and check the extracted text names the result it is quoted as, because a pattern search for a statement marker after a heading returns the next block's statement whenever the intended block writes its statement without that marker.

**Occurrence 2, 2026-09-16.** *A Gate 2 brief quoted two thresholds as givens, "batch 18 needs $\mu\ge9.3675$ at the first and batch 21 needs $\mu\ge15$", attaching both to $(1,-3,2)$. Those numbers sit in batch 33's table against the spectrum $(3,1,-4)$, at EXCLUDED points; the survivors' own thresholds are $6.8739$ and $11.25$.* **Both reviewers reported it independently**, which is what a misquoted given always produces, and neither verdict turned on it because both computed the numbers themselves. *Same shape as occurrence 1: the quote was taken by matching the right-looking text rather than by the row it belongs to.* **The fix generalises**: a quoted given carries the row or block it came from, so the attachment is checkable rather than remembered.

**Occurrence 1, 2026-09-15.** *A brief for a new lemma quoted "L57's statement" by taking the first `**Statement` after L57's heading, and L57 states itself in plain prose, so the brief carried L223's statement under L57's name. One reviewer caught it in its first phase.* **Fix beside it**: slice from the heading to the next same-level heading and assert the result's own defining sentence is inside the slice. Not critical: caught before any verdict rested on it.

## A classification screen reads a numbered result's ITEMS, not only its statement

**Proposed rule.** **Rule.** When classifying a fresh derivation against the record, read the numbered ITEMS inside each candidate lemma's statement and proof, not only its heading and its one-line claim, because a multi-item lemma proves several results under one number and only the first of them is visible to a scan of headings, statements and index rows. *The query is the new claim's own mechanism run over the bodies of nearby lemmas.*

**Occurrence 1, 2026-09-16, Lemma L229's cycle.** *The derivation proved that a diagonal block in diagonal fields forces its partner to be diagonal at fixed norm, greped the record for the trust-region subproblem, the Jordan operator's spectrum and the constant $1/\sqrt6$, found nothing, and was minutes from recording it as new. It is [L228](../findings/second-order.md)'s **item 4**, in the stronger form at fixed spectrum and by Birkhoff, inside a lemma whose heading, statement summary and index row all describe two strata of a block step and name no partner at all.* **Fix: the screen reads the enclosing lemma's items.** *Nothing reached the record, and what it cost was part of a derivation batch and one screen that was written, run and then deleted.*

## A case split produced by eliminating variables one at a time is a signal to look for one closed form

**Proposed rule.** When a maximisation is closed by eliminating one variable at a time and the answer arrives as two or more regimes, spend one step asking whether the objective's deficit against a natural cap is a single expression before building anything on the regimes, because every later step inherits the split and prices it separately. *A deficit that is a squared norm, a squared distance or a discriminant is the form to try first.*

**Occurrence 1, 2026-09-16, the three-coupling phase maximum.** *Batch 12 eliminated one angle, maximised a concave function of the other, and produced a triangle-condition regime with a closed form beside a collinear regime, and batch 13 then spent itself on the comparison that split made necessary, ending in a screen and an owed inequality in four amplitudes. The whole maximum is $\Lambda[1+\rho_1^2+\rho_2^2-\mathop{\mathrm{dist}}(1,\mathcal A)^2]$, the deficit being one squared distance, the triangle condition being the statement that $1$ lies in the annulus, and with it the comparison is unnecessary.* **Fix: try the single-expression form before consuming the cases.** *Cost: batches 12 and 13, of which batch 13 is now superseded.*

## A step that divides by a quantity checks it against the OPEN CASE, never against a lemma

**Proposed rule.** **Rule.** Before a derivation divides by a quantity, saturates on it, or assumes it nonzero, restate the open case in its own words and check that the quantity's vanishing locus lies OUTSIDE it. *Checking against a lemma instead is unsafe, because a lemma's hypotheses are narrower than the open case by construction, and the gap is invisible once the lemma is cited by name.*

**Occurrence 1, 2026-09-16, I106 batches 25 and 27.** *Batch 16 recorded the open case correctly as "at least two of $w_1,w_2,w_3$ nonzero". Batch 25's elimination then divided by $w_1w_2w_3$ and batch 27's saturation adjoined $t\,w_1w_2w_3-1$, both assuming all THREE nonzero, which is strictly smaller. The sub-stratum with exactly two is populated: Gate 2 found four exact non-commuting critical points there, so the node could never have been closed by that route and a blocked Groebner run would not have decided it either.* **What made it invisible was a typed lemma**, `w1_zero_forces`, whose hypothesis is a degenerate-spectrum equation and whose docstring credited it to the general batch 16, so "all three nonzero" read as the whole open case. **Fix: the check is on the open case as stated, and a lemma's docstring names the exact provenance of its hypothesis.** *Two batches and one blocked run were spent inside the narrowed case, and Gate 2 caught it rather than the author.*

## A corrected constant sweeps the machine-checked layer, which will certify the withdrawn one

**Proposed rule.** When a constant is corrected in prose, grep the machine-checked layer for every declaration that carries it and correct or supersede each one in the same change, because **the kernel certifies the withdrawn value as happily as the right one** and a later reader trusts it more for being typed.

**Occurrence 1, 2026-09-16, `Q_floor`.** *Batch 18's multiplier bound was corrected from $\mu\ge\beta\lvert\hat U\rvert/\sqrt6$ to twice that, and the prose was swept. `Q_floor` and `Q_floor_nonpos_iff` continued to evaluate the floor at the withdrawn $\mu=\beta t$, giving the threshold $n\ge32t^2$ against the corrected $66t^2$, and both are true as algebra so nothing failed to build.* **Both readers caught it independently, which is what a pair of readers is for.** *The danger is specific to a typed layer: a stale prose sentence reads as prose, while a stale theorem reads as certified.* **Fix: `Q_floor_sharp` now carries the constant in use, and the stale pair is kept with its status stated rather than deleted.**

## A fold is audited against each reviewer's own section list, item by item

**Proposed rule.** **Rule.** After folding a Gate 2 round, walk **each reviewer's own section list** and tick every item against the record. *Do not fold from the summary, from the verdict table, or from memory of what the round said.* A summary names the findings its author thought largest, and the ones it omits are exactly the ones nobody will look for again.

**Occurrence 1, 2026-09-16, the I106 round.** *The fold of [r957](../reviews/REVIEW_r957.md) and [r958](../reviews/REVIEW_r958.md) was written from their summaries and dropped **nine** findings. Three separate audits were needed to recover them: the first found batch 23's REFUTED diagnosis and a stronger bound batch 19 never mentioned, the second found batch 21's two unstated hypotheses and batch 22's gap at a degenerate leading coefficient, the third found four more by walking r958's sections, which carry findings r957 never raised.* **A REFUTED verdict sat unapplied on the record for hours while the cycle moved on to new work.** *The fold commit had claimed the verdicts were applied and named validation routes for them, so nothing downstream could see the omission.* **Fix: the audit is mechanical, one pass per reviewer, one tick per section heading.**

## A correction taken from one reviewer is checked against the other before it lands

**Proposed rule.** Where two readers cover the same claim, a correction adopted from one is checked against what the other wrote about it **before** the correction is committed, because the second reader may contradict the first on exactly that point and the fold will otherwise record one reading as settled.

**Occurrence 1, 2026-09-16, batch 19 and batch 21.** *[r957](../reviews/REVIEW_r957.md) observed that batch 21's bound beats batch 18's on batch 19's slice, and the fold recorded that batch 21's bound is "stronger still". [r958](../reviews/REVIEW_r958.md) had written that **neither bound dominates**, the two measuring different things, with $7.5$ against $4.5$ at one spectrum and $3.75$ against $4.5$ at another.* **So a correction made to fix one reviewer's finding introduced a false general claim, and it stood for two commits.** *Both reports were on disk the whole time.* **Fix: before committing a correction, grep the other report for the same batch number.**


## The loop's armed flag is invisible when absent, so the status answer reports it

**Proposed rule.** **Rule.** The `status` answer names whether the loop's arming flag exists, beside what is running, because a disarmed `Stop` hook and a satisfied one produce identical silence and nothing else distinguishes them.

*The skill already says an unarmed hook is indistinguishable from one that allowed the stop. It offers no way to notice, and the flag is written once at a cycle's opening action, which is exactly the moment a resumed or compacted session skips.*

**Occurrence 1, 2026-09-16, critical.** *A session ran for many cycles with `.claude/research-loop-active` never written, so the `Stop` hook that refuses an ending with no condition named was inert throughout. The session then ended a turn on prose citing "turn length", which is not one of the seven stop conditions, and nothing objected.* **The user had to catch it.** **Fix beside it**: the status answer's "what is running" part names the flag's presence, which costs one `ls` and is read at exactly the moment a cycle is being resumed. *Marked critical under the third disjunct: the hook is the net that was looking for this defect, and it was disarmed rather than passing.*

## A number reaches the record from the filed screen, never from the exploratory script that found it

**Proposed rule.** **Rule.** A number is transcribed into the record from the run of the INDEXED screen, never from the exploratory script that produced it first, and where the two disagree the exploratory one is wrong until shown otherwise.

*An exploratory script is written to answer a question once and is never reread; the filed screen is written to be checked. Numbers from the first reach the record because they arrive first, and the screen is then written to agree with what is already recorded.*

**Occurrence 1, 2026-09-16, critical.** *Two bounds entered a derivation's comparison table at twice their true size, from a stray `0.5*(...)*2/2` on the positive form of a generalised eigenvalue in a throwaway script. The filed screen computed the same form correctly, and the error surfaced only because the two runs disagreed after the screen was written.* **Had the screen been written first, or the table filled from it, the wrong numbers would never have been recorded.** **Fix beside it**: fill every recorded figure from the indexed screen's own output, and treat a disagreement with an exploratory run as a fault in the exploratory run. *Critical under the first disjunct: the table asserted exclusions at values that were wrong, which is a recorded claim falsified, and a factor of two on a bound is invisible to any check that only asks whether the bound is cleared.*


## Correcting a number does not correct the verdicts computed from it

**Proposed rule.** **Rule.** When a recorded figure is corrected, re-derive every verdict, comparison and conclusion computed from it in the same edit, because those were derived from the old value and nothing about them changes when the value does.

*A correction feels complete when the wrong number is gone. The cells that READ that number are a second population, they carry no mark that they depend on it, and they are the half a later reader trusts.*

**Occurrence 1, 2026-09-16, critical.** *Two bounds in a comparison table were recorded at twice their size and then corrected. The verdict cell beside one of them, "clears the bound", had been correct for the doubled value and was FALSE for the corrected one, and it was not re-derived. The block then asserted that a critical point cleared a condition which in fact excludes it, and it also drew a summary clause from that cell, so one stale verdict propagated into the block's stated conclusion.* **Both Gate 2 readers found it; the author did not, having just corrected the number and read the correction as finished.** **Fix beside it**: the edit that changes a figure recomputes every cell derived from it, and where a verdict is a comparison, re-derive it from the quantity itself rather than from the threshold, since a sign is cheaper to check than an inequality. *Critical under the first disjunct: a recorded claim was falsified, and the conclusion drawn from it was stated in the record.*

## A novelty claim names the files it grepped, and they include the destination file and the cycle's own diff

**Merged 2026-09-25 from 2 entries that share one repair.** **Rule.** A claim recorded as new carries its classification line, *searched `<files>` for `<tokens>`*, and the files named include the one being written into and the cycle's own commits (`git diff` over them). *Both occurrences are the nearest text going unsearched after a wider search came back empty.*

**Fix beside each occurrence.**

- 126, one critical occurrence: name the target file and its tokens in the classification line, checkable by a gate.
- 96, one occurrence: the same line, extended to the cycle's own diff.

#### An outward search that finds nothing reads as a completed search, so the file being written into is never grepped


**Rule.** A novelty claim names the TARGET FILE and the tokens grepped **in it**. *The outward search does not discharge this, and a clean outward result is the case where it is most likely to be skipped.*

A coupling identity was derived, screened, classified **genuinely new**, typed and committed. Gate 2 refuted the classification one theorem above the new code: the objects were an existing theorem's own column products, and the relation the derivation had omitted was that theorem's own hypothesis. **It stood about sixty lines above the block, in the file the block was written into, which was open in the editor at the time.**

**The rule already exists** and reads *"Read the file you are about to write into, before you derive. Grep that file for the statement before deriving it, not after."* It did not fire, and the reason is specific rather than forgetfulness. **The outward search by object was run, carefully, across the findings, the reviews and the notebook, and it came back empty.** An empty outward result is indistinguishable, from the inside, from having searched everywhere: the checklist item *search the record* is felt to be discharged, and the one grep that would have worked is the one never reached.

**So the failure is in the ORDER, not the diligence.** The outward search is the wide one and runs first, and completing it retires the intent. *The file-local grep has to be bound to the act of writing rather than to the act of searching*, because the target file is unknown while searching and obvious while writing.

**The checkable form.** A block claiming novelty carries its classification as *searched `<file>` for `<tokens>`*, naming the file the block is being written into. A gate can read that: a note or brief asserting **genuinely new** without naming the target file in its classification line is refused, exactly as a Gate 2 brief is refused for an empty Lean cell. *Restating the prose rule is what has already been tried, and this is its second recorded failure in one session.*

#### Grep the cycle's OWN output before calling a claim new, not only the destination file


**Before recording a claim as new, search the files the CURRENT cycle has already written, not only the file the claim is going into.** The destination-read rule covers text an earlier cycle left and misses text this one produced minutes ago in a different file, because nothing about a file the cycle wrote itself reads as unfamiliar. *One cycle recorded a dichotomy and its separating witness as a new find from an outside source while the same session had written both into the task list nineteen minutes earlier.* **The cheapest form is one `git diff` over the cycle's own commits before the write-up.**

## A failed check of a reviewer's claim is DIAGNOSED before it is reported, by fitting the term that would make it hold

**Rule.** When an independent check of a reviewer's identity fails, solve for the coefficient or term that would make it hold and compare that against the report. **Take every term's definition from the REPORT that states it, never from the brief.** *A failed check is evidence about one of two things, and which one is cheap to determine and expensive to guess.*

**Occurrence 1, 2026-09-17.** *A reviewer returned an exact identity that reopened a closed route and showed two of the programme's levers to be coefficients of one object.* The parent checked it independently, as the standing rule requires, and the check **failed by $61.6$**, nowhere near machine precision. **The identity was correct.** The parent had taken $Q$ from the dispatch brief, where it is batch 21's bare expression, while the report defines $Q$ with a $-\mu(3\lvert X\rvert^2+\lvert Y\rvert^2)$ term. *Fitting $Q$ from the identity showed the difference was exactly $\mu\lVert Z\rVert^2$ in every row, which located the error in the parent's code in one command.* Corrected, the identity holds at $2.3\cdot10^{-13}$.

**Why this needs a rule.** The standing discipline says a refutation carries the heavier burden and that reviewer findings are validated before they change the record. *Both were followed, and both point the wrong way here*: the parent's screen was the independent instrument, the reviewer's claim was the thing under test, and a failing screen reads as the discipline working. **Reporting that failure would have retracted a correct central finding on the strength of a dropped term.**

**The brief is the wrong source and that is the mechanical part.** A brief states a claim in the parent's words for a cold reader. A report states it in the reviewer's, with every term the reviewer actually used. *When checking the reviewer, the reviewer's definitions are the specification.*

## A condition stated as an INEQUALITY is checked by the signature, never by the rank

**One occurrence, 2026-09-17, and it is critical because the wrong conclusion reached the record and two reviewers were spent catching it.**

*A screen built the second variation on the $9$-dimensional tangent space at three critical points, called `numpy.linalg.eigvalsh`, and asked the returned spectrum ONE question: how many eigenvalues are zero. The answer, $\dim\ker H=0$, was correct. It was then recorded as "the second variation is nondegenerate, so no direction with $Q(Z)=0$ exists there, and the lever has no hypothesis to act on".* **That inference is false.** A nondegenerate INDEFINITE form has a null cone of dimension $8$ inside a $9$-dimensional space and an empty kernel, so emptying the null SPACE says nothing about the null CONE. Only definiteness collapses one onto the other.

**And the sign was already in hand.** The eigenvalues sat in the variable one line above where the script stopped. Asking for their signs instead of their zero-count gives signature $6/3$, $6/3$ and $7/2$, which refutes not only the inference but its premise: batch 21 requires the form to be non-positive, so the three points are not local maxima at all and were never obstacles to the node. *Two Gate 2 readers caught the invalid inference independently, and one of them went on to find the stronger fact.*

**Fix beside it.** *When the recorded condition is an INEQUALITY on a quadratic form, the screen reports the SIGNATURE and the extreme eigenvalue, never a kernel count.* A rank or kernel dimension answers "is the form degenerate", which is the question a maximality condition almost never asks. **Report `(neg, zero, pos)` and $\lambda_{\max}$, and report $\sigma_{\min}/\rho$ alongside any kernel count**, since a rank is a threshold choice and at one of these points $\sigma_{\min}/\rho$ was $2.2\cdot10^{-8}$, making the count meaningless without it.

**Proposed rule.** **Rule.** A screen of a second-order condition reports the signature, the extreme eigenvalue and $\sigma_{\min}/\rho$, because the condition is an inequality and a kernel count cannot see a sign. *An empty kernel empties the null space and not the null cone.*

*The general shape, and the reason this is not just an arithmetic slip: the script computed everything needed and the cycle asked it the question it had in mind rather than the question the claim required. The guard is to derive the question from the recorded condition's own form, inequality or equality, before choosing what the screen prints.*

## A brief naming specific POINTS hands over the equations that select them

**One occurrence, 2026-09-17, and it is critical because it made an audit item unanswerable rather than merely harder.**

*A Gate 2 brief asked two readers to reproduce a numerical claim at "the three surviving non-commuting critical points", giving each point's spectrum and its multiplier $\mu$, and giving the Lagrange fields $A$ and $C$ as expressions in $(\hat U,V,\mu)$.* **Those field expressions make EVERY point critical for $\Phi$**, as one reviewer checked directly: substituting them turns $\nabla\Phi=\mu\nabla T$ into an identity. *So "critical point" in the brief's source means a further system, batches 18, 21, 30 and 33, which the brief never carried.* **A reader given spectra and multipliers cannot recover the six entries of each $\hat U$ and $V$**, and one reviewer returned NOT REPRODUCIBLE while the other rebuilt the points only by guessing a normalisation.

**Fix beside it.** *The brief carries the equations that SELECT the points, or the points' own entries, whenever an item asks a reader to reproduce anything at them.* The test is mechanical and can be run before dispatch: **ask whether the brief's givens determine the objects uniquely**, and if a reader could satisfy every given with a different object, the selecting data is missing.

**Proposed rule.** **Rule.** An attack item naming specific points hands over the system that selects them, or their explicit coordinates. *Labels, spectra and multipliers identify a point to someone who already has it and determine nothing for a cold reader.*

*This is the cold-brief rule's own failure mode and the loop already states it: withhold the record, never what the attack items depend on. It failed here because the brief DID carry field formulas, which read as the selecting data and are the opposite, being satisfied by everything. **So the check is not "did I give them the definitions" but "do the definitions pin the object", and a given satisfied by every candidate is worse than an absent one, because it looks like the premise it replaces.***

## A control that fails must FAIL the run, never print beside its own expected value

**One occurrence, 2026-09-17, and it is critical because the broken measurement was filed as a script and its output read as a result.**

*A screen for [I106b](../plan.md) measured whether $Q^{\mathsf T}(A\circ Q)$ is symmetric at a zero-diagonal witness. Both the measurement and its control called the random-matrix constructor TWICE inside one expression, so each compared $Q^{\mathsf T}(A_1\circ Q)$ against the transpose of $Q^{\mathsf T}(A_2\circ Q)$ for two DIFFERENT draws.* **That measures nothing whatever.** The control printed `6.089e+00` immediately after the string `(0 expected)`, and the run continued, printed its summary, and was read.

**What makes this worth a rule rather than a shrug.** The control did its job: it detected the breakage and said so, in the same line, against its own stated expectation. *What failed is that nothing acted on it*, because the expectation was carried in a print label rather than in an assertion, and a label cannot stop anything. **A control whose only consequence is a number on a screen is a comment, and the parent read past it exactly as one reads past a comment.**

**Fix beside it.** *Every control asserts.* Where a screen prints `(0 expected)`, the zero is checked with `assert` before the line is printed, so a broken measurement ends the run instead of decorating it. The repair here also draws each random object ONCE and reuses it, which is the underlying bug, but the rule is about the control rather than about the draw, because the draw will be got wrong again and the assertion is what catches it.

**Proposed rule.** **Rule.** A screen's control is an assertion, never a printed expectation. *A number printed next to the words "0 expected" has no consequence, and a run whose control silently failed is indistinguishable from one that passed.*

*This is the same shape as the standing method rule that an identity checked where both sides vanish is not checked, and it is the enforcement half of it: that rule says to confirm the check CAN fail, and this one says that when it does fail it must take the run down with it.* **Note the interaction with [128](#a-condition-stated-as-an-inequality-is-checked-by-the-signature-never-by-the-rank), filed hours earlier in the same session**: there the script computed the right numbers and was asked the wrong question, here the script asked the right question and computed it wrongly, and in both the output looked exactly like a result.

## A conclusion free of a parameter its hypotheses all carry is evidence the parameter is eliminable

**One occurrence, 2026-09-17, and it cost a long proof rather than a wrong one.** A derivation reached a conclusion with no $\theta$ in it, from hypotheses every one of which carried $\theta$, by a fourth-derivative expansion whose $\theta$ terms cancelled as $3-12+9=0$, and the write-up called that cancellation the whole content; both Gate 2 readers then found a three-line proof that never introduces $\theta$ at all, and one showed the cancellation was forced rather than fortunate.

**Fix beside it.** *Before spending a review on a derivation whose conclusion omits a parameter its hypotheses all carry, look for the proof that never introduces the parameter, since the omission is usually a property of the statement rather than an accident of the route.*

**Proposed rule.** **Rule.** When a derived statement is free of a quantity every one of its hypotheses carries, treat that as a signal the quantity is eliminable and look for the argument that never introduces it. *A cancellation presented as the mechanism is the mark of a longer road to a fact that did not need the quantity, and the signal is on the page before any reviewer is spawned.*

## A brief quoting a figure a script produced quotes the script's own constraints, each marked theorem or implementation

**One occurrence, 2026-09-17, and it is critical because it put a false statement into four files before the cycle caught it.** A Gate 2 brief quoted a sweep's worst-case figure and the prose constraints around it, but not the ceiling the sweep's own loop imposed, so the reviewer correctly reported the figure as resting on something unstated and swept past the ceiling to a three-times-worse number; the ceiling was a constant the same file DERIVED under its own heading, so the reviewer's finding was right about the brief and wrong about the problem, and the parent then recorded the deficit as undecided across the note, the ledger, the plan and two scripts.

**Fix beside it.** *List every constraint the script actually enforces, not only the ones its prose mentions, and mark each as a theorem the record proves or a choice the implementation made. A cold reader cannot tell the two apart by reading the loop, which is exactly what makes the omission invisible to them and to the parent.*

**Proposed rule.** **Rule.** Where a brief hands over a figure a script produced, it lists the constraints that script enforces and marks each as PROVED or IMPLEMENTATION, citing the record for the proved ones. *This is the existing rule about quoting every constant an attack item needs, sharpened at the case it misses: the constant lives in code rather than in prose, so quoting the prose faithfully still omits it.*

## A non-existence claim reached by testing one candidate formula is not a non-existence claim

**One occurrence, 2026-09-17, and it is critical because it was committed to the record and weakened a result that was already true.** A screen tested whether two quantities were individually determined by checking a single guessed formula, found it false, and recorded that they are "NOT separately determined, only their sum"; both Gate 2 readers derived the actual formulas within minutes, so the result fed an identity rather than the weaker bound that was typed, indexed and written into three files.

**Fix beside it.** *Derive the candidate from the hypotheses before screening for it, and where a screen is the instrument, sample the map from inputs to outputs rather than one hypothesised closed form: if the output is a function of the inputs at all, a rank or interpolation check finds it, and failing one guess distinguishes nothing.*

**Proposed rule.** **Rule.** Establish that a quantity is undetermined by exhibiting two admissible configurations agreeing on the inputs and differing in it, never by a formula that failed to match. *A failed guess says the guess was wrong. The two configurations are usually cheaper to produce than the guess was, and they are what the claim actually asserts.*

## The domain check fires at every substitution into a recorded bound, not only when a route is graded

**One occurrence, 2026-09-17, and it is critical because the substitution reached a correct conclusion by an argument that did not establish it, and that reached the record.** A cycle closed an owed boundary case by setting a parameter to zero in a recorded relaxation, where the relaxation was stated and proved for the case that parameter is nonzero: its dominant term came from configurations the boundary case does not contain, so the substitution was outside the hypothesis class rather than an instance of it, and a Gate 2 reader had to supply a direct argument that happened to give the same answer.

**Fix beside it.** *The skill already carries "name every borrowed quantity's DOMAIN before the route is graded". The gap is the trigger: that rule fires when a route is proposed, and a substitution into a recorded bound mid-derivation passes through no such moment, so nobody asks whether the value lies in the class the bound was proved for.*

**Proposed rule.** **Rule.** Before substituting a particular value into a recorded bound, state the hypothesis class that bound was proved under and check the value lies inside it. *Boundary values are the ones most often outside: a bound whose derivation counts configurations of a certain shape is not an instance of itself when the shape becomes empty. This is the existing domain rule with its trigger moved from route grading to the substitution itself, which is where the failure actually happens.*

## A route's factual claims about named objects are screened against those objects before it is registered

**One occurrence, 2026-09-17, and it is critical because a route was registered, a plan rewritten around it, and the whole of it undone the same day by one screen.** A sweep proposed a route whose plausibility rested on a single sentence asserting a property of an object the record constructs, the scripts build and the layer types; the mechanism screen ran and passed, since the mechanism genuinely had never been used as a route, but nobody evaluated the sentence, and the property was false for every dimension the programme works in.

**Fix beside it.** *The existing screen asks whether the record has already closed the MECHANISM. It does not ask whether the route's supporting claims are true. Those claims name objects that are usually already built, so checking them is a screen of seconds rather than a derivation, and it belongs before registration because registration is what makes the next cycle build on them.*

**Proposed rule.** **Rule.** Before a route is registered, list every factual claim its plausibility rests on that names an object the record already constructs, and evaluate each on that object. *A route's mechanism being unused is not evidence that its warrant is true, and the two screens catch different things: one asks whether the road has been walked, the other whether it exists. The claims are cheap to check precisely because the objects are built, which is also why nobody thinks to check them.*

## A screen of a polynomial identity is evidence only above the interpolation count, which is computable before it runs

**One occurrence, 2026-09-17, and it is critical because the screen became the warrant for a reclassification that reached the record, and two reviewers had to supply the proof.** An identity between two matrices of homogeneous cubics in fifteen variables was checked at three hundred random points and recorded as holding; those cubics span six hundred and eighty dimensions, and each sample contributes one linear condition, so the check left a space of at least three hundred and eighty forms fitting the data exactly as well.

**Fix beside it.** *The existing rule that numerical evidence never substitutes for a proof was followed here: the screen was labelled a screen. What it does not say is that a screen of a polynomial identity has a THRESHOLD, and below it the screen excludes nothing, so labelling it honestly still leaves it worthless as support for the claim built on it.*

**Proposed rule.** **Rule.** Before screening a polynomial identity at sampled points, compute the dimension of the space of forms of that degree and arity, and sample more points than that or say the screen is decorative. *For degree $d$ in $n$ variables the count is $\binom{n+d-1}{d}$, so it is one line and it is available before any sampling.* **Where the identity is multilinear the cube $\{0,1\}^n$ settles it outright**, which is cheaper than sampling and is a proof rather than evidence.

## A failed reindexing proof is diagnosed by the PERMUTATION'S PARITY before it is recorded as owed

**Occurrence, 2026-09-17.** `relabel_df` failed, and I recorded in [diagonal-half.md](../findings/diagonal-half.md) that the target needed "three adjacent transpositions, not the two my proof applies", with the numerics confirming the target so that the failure read as my proof shape rather than the statement. **Both halves of that were wrong.** The substitution carrying $C$ to $A$ is the CYCLE $(d,e,f)\mapsto(f,d,e)$, which is EVEN and needs exactly two neighbouring swaps. The proof that failed was applying the right NUMBER of swaps at the wrong POSITIONS: it swapped $(d,e)$ where the second swap owed was $(e,f)$. Reading the substitution as the reversal $(f,e,d)$ made an odd permutation out of an even one and turned a one-line fix into a recorded debt.

**The rule it would add.** When a proof by reindexing fails, write the substitution down as a permutation and compute its parity and its decomposition into ADJACENT transpositions, before concluding anything about the proof's shape. *One line of arithmetic decides whether the swaps are too few, too many, or in the wrong places, and those three have different repairs.*

**Why it is a waits.** The occurrence count is one, the loss was under an hour, and the rule is narrow: it fires only on reindexing proofs over nested sums, which this programme has used twice. *A rule earned by one occurrence in a narrow setting is a rule the next cycle reads past.* **Filed so a second occurrence has something to join.**

## A block appended to a findings file is filed under whatever heading happens to be LAST

**Occurrence, 2026-09-17.** Four blocks recording I67's closure were appended to the end of [diagonal-half.md](../findings/diagonal-half.md) and landed under `### I66, DiagCubicFormula, the record's largest single unproved dependency`, a heading about a different result. **It surfaced only because step 7 asked for an anchored link and the anchor computed was the I66 slug**, which is the one place the misfiling is visible. Nothing else would have shown it: the prose reads correctly, the links resolve, the file parses, and a top-down reader meets I67's closure filed under I66.

**The rule it would add.** *The skill already says to fold a result "at the topic it belongs to rather than at the end".* What it lacks is the check: **after appending to a findings file, print the nearest heading ABOVE the new block and confirm it names the block's subject.** One command, and it is the same command step 7 already runs to build an anchored link.

**Why this is stronger than the existing sentence.** The existing rule is an instruction to the author about where to write, and an author appending with a heredoc is not choosing a position at all, so there is nothing for the instruction to attach to. *A check that runs after the write catches what an instruction before the write cannot.*

**Why it is a waits.** One occurrence, and the repair cost minutes. **But the failure mode is silent and the record is the programme's memory**, so a second occurrence should promote it rather than join it.

## Every Lean module carries a row in the layer's index, and the COMMIT GATE decides it

**Occurrence, 2026-09-17.** [r994](../reviews/REVIEW_r994.md) spent part of a Gate 2 round establishing that [I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean) was the only one of 489 modules in `Results/` with no row in [lean/INDEX.md](../lean/INDEX.md). *It checked them one by one and was right.* **The skill already says no reviewer is spent on what a script decides, and this is three lines of `python`.**

**Why the existing gate misses it.** [mechanical_check.py](hooks/mechanical_check.py)'s `check_named_decls` reads each ADDED index row and verifies the file and the declarations it names exist. **That is the one direction, and the gap is the other**: a module with no row adds no line, so nothing is read and nothing fires. *A check driven by added lines cannot see an absence.*

**The rule, and it runs in BOTH directions because the same line decides each.** When a commit stages a new `.lean` module under a layer directory, the gate lists every module in that directory and refuses the commit while any lacks a row in the layer's index. **And when a commit adds a numbered result to the results index, the gate refuses it while that id carries no row in the layer's index**, which is the rule that numbering a result obliges a machine-checked file, enforced where the number is created. **Directory listing against index text, and index against index, not diff against diff**, which is what makes either see an absence at all. *The second direction is the larger debt: a survey found one module unrowed against FORTY numbered Lemmas with no row at all, and the second gap had gone unnoticed under a record section asserting the opposite.*

**Why it is a waits.** One occurrence, and the repair was a single row. **What it protects is the expensive instrument**: a reviewer round is the costliest check the loop runs, and this one spent part of itself on a `for` loop's worth of work, which the skill names as the thing a commit gate exists to prevent.

## A `Gate 2 pending` marker in a findings file obliges a LEDGER ROW in the same edit

**Occurrence, 2026-09-17.** A census found **41** blocks marked `Gate 2 pending` across six findings files, 32 of them in one file, and **not one has a row in the Gate 2 debt ledger**. *The ledger's owed section tracks rounds that LANDED rather than blocks awaiting a first one, which is the opposite of what it is for.* **Three of the untracked blocks are load-bearing and cited by live plan items.**

**Why the existing rule does not catch it.** The skill already says to keep a ledger so that *"a pending marker cannot age into an assumed result"*. **That rule fires when a review is deferred, and these markers were never deferred: they were written as the block was derived**, by a cycle that had no reviewer in flight and nothing to defer. *So the moment the rule addresses never arrives, and the marker is created outside it.*

**The rule.** A commit that adds the string `Gate 2 pending` to a file under the findings directory must add a ledger row in the same commit, and the gate counts markers against rows and refuses the difference. **Marker count against row count, which a script decides in one pass.**

**Why it is a waits.** One systemic occurrence, and it costs nothing until an unaudited block is cited as settled. *What it protects is the discipline the whole loop rests on: Gate 2 is only a gate while the record knows what has not been through it.*

## A watched log that does not EXIST is treated as alive, so the watchdog never trips on a reviewer that died before its first write

**Occurrence, 2026-09-17.** Two reviewers were dispatched together. One wrote its first log line within seconds; the other wrote **no log at all**. [reviewer_watchdog.sh](../scripts/misc/reviewer_watchdog.sh) reads `if [ ! -f "$log" ]; then alive=1; continue; fi`, **so a log that was never created counts as alive on every pass, forever.**

**Why this is the script's own stated failure reached by an uncovered path.** *Its header says a dead agent "SILENCES the supervisor rather than tripping it, and the round waits on a corpse", and the staleness test is what prevents that.* **The staleness test needs a file to take an age from.** *An agent that dies between launch and its first write leaves no file, so the one test that would catch it is skipped by the guard meant to make the script robust.*

**The rule.** A watched log absent for longer than the staleness threshold **counts as dead, not alive**: record the dispatch time and compare against it while the file is missing, so the same threshold covers the window before the first write.

**Why it is a waits.** One occurrence, and it costs nothing while agents start normally. *What it protects is the supervisor itself: this is the single case where the watchdog reports health it has not checked, and a round can then wait on a corpse with the watchdog running and silent, which is indistinguishable from a round proceeding well.*

## A control must SEPARATE the claim from its competitor, not merely be a value the record carries

**Occurrence, the same day the known-value rule was promoted.** *A brief supplied an anchor the record proves, named it decisive, and a reviewer confirmed the claim reproduced it. The claim was false.* **The anchor sat at the one point of parameter space where the claimed form and the true one must agree**, so reproducing it was guaranteed and carried no information.

**Why the existing rule does not catch it.** It says a reimplementation is run on a known value before its disagreement is believed, which is satisfied here: the value was known, it was run, it agreed. *The rule constrains WHETHER a control exists, not whether it can fail.* **A control that cannot fail is a ritual.**

**The rule.** Before a control is relied on, name the competing claim it is meant to exclude and check the control takes a DIFFERENT value there. Where the two agree at the control point, the control is recorded as blind and another is found.

**SECOND OCCURRENCE, and it is the critical kind: a check aimed at a defect let the defect through.** *A claim that two topology instances agreed was checked by asking whether `inferInstance` equalled the subtype instance. `inferInstance` RESOLVES to that instance, so the check compared one thing with itself and could not fail.* **The competing claim was that the two differ, and the check takes the same value there**, which is exactly what this rule tells its reader to test. *The false claim then reached a committed file and an index row, and was found only by an adversarial reader.*

**Why it earns an edit rather than a wait.** *A blind control is worse than none: it converts an unchecked claim into a checked one in the record's own account, and every later reader inherits that.* **And it is cheap to apply**, since naming the competitor is one line and evaluating it is the same call already being made.

## A reviewer whose NUMBERS the record may later need as a control files the script that produced them

**Occurrence.** A round published a multiplier, a functional value and nine eigenvalues at each of three constructed points, and filed no script. *Its construction survives as one sentence naming the solver and two parameters it solved for, without the parameterisation those parameters index.* **A later round needed those points as a control and could not rebuild them**, which blocked half of an approved search.

**Why the existing rules do not cover it.** *One says a reviewer's numbers are not evidence until rebuilt from the object's own definition, which protects the reader FROM the reviewer.* **Nothing obliges the reviewer to leave the means of rebuilding.** A second says to index any scripts a reviewer leaves behind, which is silent when it leaves none.

**The rule.** A reviewer that reports numbers at CONSTRUCTED objects files the script that builds them, indexed with the report. **Numbers at objects the record already carries need no script**, since the record is the construction. *The test is whether a later reader could rebuild the object from what is written, and the reviewer is the last party able to answer it cheaply.*

**Why it is a waits.** One occurrence. *But it is the shape that costs most later: the numbers read as settled, are cited as a control, and their irreproducibility surfaces only when someone needs them, by which time the round that could have filed the script is long closed.*

## A HIGH-WATER MARK IS A CLAIM ABOUT THE ROWS, AND THE NEXT ID IS TAKEN FROM THE ROWS

**Occurrence, and it is the second.** *[INDEX-results.md](../findings/INDEX-results.md)'s footer read "226 numbered results, ids L0 through L228, next free 229" while the table already carried rows through L230, so the number it offered was one already assigned to a lemma with a Gate 2 verdict against it.* **The same file records the same line drifting in 2026-09-05**, when it read "next free 133" against 153 rows, and the fix that time was to correct the number.

**Why the existing rule does not catch it.** Step 6 says a class owned by a working file carries a high-water mark at its head, taken and incremented on assignment and never reused, and step 3 says to take the next free number the index reports. *Both are instructions to READ the mark, and both were followed.* **The mark is prose maintained by hand beside a table maintained by hand, and nothing compares them**, so it drifts exactly when a cycle assigns a number and updates one of the two.

**The rule.** The next id is computed from the rows, and the mark is checked against that computation and corrected in the same edit. *One command: extract the ids, take the maximum, add one.* **A mark that disagrees with the rows is a finding to record rather than a number to use**, since a cycle that trusted it has already cited a colliding id somewhere.

**Why it is a waits.** *The durable fix is a commit-gate check rather than a rule, exactly as the reviewer-index and script-index lapses were, and this file's own standing on that is that a rule violated twice is replaced by a check.* **The proposal is therefore for the gate**, and the rule above is what the gate would enforce.

## A CLAIM INHERITED FROM THE RECORD AND REPEATED INTO A NEW FILE IS A CLAIM THE CYCLE IS NOW MAKING

**Occurrence.** *The record said in several places that `DiagCubicFormula` and [L57](../findings/problem.md)'s $\mathop{\mathrm{tr}}W^3$ bridge were "the same statement under another name".* **A cycle proving the first repeated that sentence into three new files and two indexes**, and [r1001](../reviews/REVIEW_r1001.md) refuted it: the bridge is the CONJUNCTION of two identities where the formula is their SUM, so it follows from the bridge and does not imply it. *The consequence survived only because the two conjuncts happened to be proved separately.*

**Why the existing rules do not catch it.** *The quoting rules govern what a BRIEF may carry and are about not paraphrasing. The classification rules fire when a cycle DERIVES something and ask whether the record already holds it.* **Neither fires when a cycle copies a sentence the record already holds into somewhere new**, which reads as citation rather than as assertion, and is the cheapest possible action.

**The rule.** A sentence carried out of the record into a file this cycle writes is checked before it is carried, at the cost of reading what it asserts and asking whether it follows. *Where it cannot be checked cheaply, it is cited rather than restated: a link cannot go stale and a copy can.* **The test is whether the cycle would be willing to defend the sentence at Gate 2**, because by writing it into a new file that is exactly what it has done.

**Why it is a waits.** One occurrence, and the cheaper half of it is already covered by the existing instruction to link rather than restate. *What is new is the direction: those rules protect the PLAN from duplicating the record, and this one protects the record from a cycle propagating its own errors outward under the record's authority.*

## A USER DECISION IS NAMED BY A TRIGGER, NEVER BY A CATEGORY

**The failure.** A rule that names a CATEGORY of decision, *a restructuring*, *a scope change*, is matched on the size of the work rather than on the reason the rule exists, so a correction with a right answer and no information loss gets referred to the user as though it were a choice.

**What distinguishes it from the thing it resembles.** A decision genuinely belongs to the user when it is irreversible, spends something outside the work, or settles what the project may forget. Fixing what a layer has wrong does none of those: it has one correct answer, and the cost of getting it wrong is another cycle rather than a lost record.

**The rule.** Name user decisions by a trigger a reader can check, never by a category. *Where a category is already written, the neighbouring rule that names the trigger is the one to keep.*

**APPLIED 2026-09-19** as a deletion of two passages in [research-loop](skills/research-loop/SKILL.md), 44 words removed and none added. *The incident is in [ATTEMPTS.md](../ATTEMPTS.md).*

## A CHECK'S EXIT STATUS IS DATA, SO A COMMIT NEVER SITS BEHIND ONE

**The failure.** A verification step and the commit that cites it go in one call, joined by `&&`. The step exits non-zero for an ordinary reason, `grep -c` returning `1` on zero matches being the common one, so everything after it is skipped. **The commit still lands, carrying a message that cites the verification that never ran.**

**What distinguishes it from the rule it resembles.** One existing rule says a command a gate can REFUSE is the only thing in its call, which is about a gate rejecting the whole call. Another says to chain an edit and its commit with `&&` so a failed edit cannot be committed. *Both are right and neither covers this*: here nothing is refused and nothing fails, a check simply reports a count of zero, and `&&` reads that as an instruction to stop.

**The rule.** A check whose result the commit message will cite runs in its own call, and the message is written after its output is read. *Where a check must be chained, invert it so success is non-zero, or terminate it with `; true`, so the exit status carries no control.*

**Why it is a waits.** Three occurrences in one session and none of them produced a false claim, the verifications having passed when finally run. *The cost is that the commit log records checks as done on the author's intention rather than on their output, which is invisible until one of them would have failed.*


## A SUFFICIENT HYPOTHESIS IS NOT ASSERTED NECESSARY IN THE SENTENCE THAT STATES IT

**The failure.** A theorem is stated under a hypothesis, and the prose beside it adds *"and only there"*, *"and not otherwise"*, or *"which needs"*. **The theorem is right, the hypothesis is genuinely needed, and the exclusivity claim is false**, because a sufficient condition can be one of several, or can be sufficient at the value in question for a second reason. *The claim is never checked, because the sentence that carries it is the sentence that got the hypothesis right.*

**What distinguishes it from the rules it resembles.** One existing rule says a new rule owes a search for the text it contradicts; another says a reviewer's finding is a claim whose reach is checked. **Neither covers this**: nothing is contradicted, nothing is imported from a reviewer, and the author is stating a fact about their own theorem in the act of proving it.

**The rule.** *Where a hypothesis is stated as necessary, exhibit the failure.* Compute the residual the hypothesis kills and ask what else kills it; where nothing else does, one witness outside the hypothesis makes the claim checkable. **Where that has not been done, write what the hypothesis buys and stop**: `holds at a self-adjoint A` is a complete sentence.

**It is a `waits` at three occurrences.** *All three are in one session and each was caught by the round that followed, so the record cost is three folds.* **The reason it is worth carrying at all is the asymmetry**: the false half sits inside a true statement and reads as precision, so the next reader inherits it as a fact about the mathematics rather than as an author's flourish.

**Occurrence 1, `trCube2`'s *"and not otherwise"*.** Written as a repair after [r1012] found the name `tr R³` unconditional. **At a skew-adjoint `R` both sides vanish**, so the two agree there too. Caught by [r1013]. *Fix: state the quantified form, that self-adjointness makes the identity hold at every `R`.*

**Occurrence 2, `innerOp2_eq_trOp`'s *"and only there"*.** Written fresh, and repeated into an index row. **The residual is `Tr((A* - A) B)`, so self-adjointness of EITHER argument suffices.** Caught by [r1015], which proved the other side in three rewrites. *Fix: the same, plus the second lemma.*

**Occurrence 3, *"the hypothesis still cannot be dropped"*, on the SAME lemma as occurrence 2.** Written in the repair OF occurrence 2, and false at small index sets: at $\lvert\iota\rvert\le2$ the space $\Lambda^2$ has dimension at most one, every operator on it is self-adjoint, and the exhibited witness is exactly zero there. Caught by [r1016]. *Fix: the bound $3\le\lvert\iota\rvert$, one clause.* **This one is the sharpest evidence for the rule**: the necessity claim was added while fixing a necessity claim, and the witness beside it was never evaluated at the smallest case.

*A fourth was claimed in the fold that carried occurrence 2, which said "the third repair this session". At that point there were two, and one of them was not a repair. **The overcount is the same defect in miniature**: a tally stated because it made the point land.*

### A failed instance search is a failed SEARCH, so name the instance before recording a route as closed

**An `infer_instance` or `#synth` that fails proves that the elaborator's search did not find the instance, and nothing at all about whether the instance exists.** Where two structures on one type carry the same underlying data through different paths, search fails while the instance elaborates the moment it is written by name, so a route recorded as closed on a failed search is a route nobody tried.

**Write the instance by name before concluding**, and where the named form elaborates, record the route as unreached and tedious rather than closed. *A route called closed is never reopened, which is what makes this failure expensive rather than merely wrong.*

**And a kernel check is a check only when the line that failed is the line that made the claim.** A probe file reporting an error attributes it to a line number, and reading that error as refuting a different statement in the same file produces a false finding wearing a verified finding's clothes.

*Three occurrences in one session, each corrected by the next round and each costing that round: a statement called "one lemma", an object called "the root of both remaining obstacles", and a bundling route called closed and "checked in the kernel" while naming the instance reaches it.*

### A scope or option modifier goes before a declaration's docstring, never between them

**`open ... in`, `open scoped ... in` and `set_option ... in` attach to the declaration that follows, and a docstring counts as that declaration's opening.** Placing the modifier between a docstring and its `theorem` or `def` is a parse error, and the message names a token rather than the layout, so it reads as a problem with the statement.

**Write the modifier first, then the docstring, then the declaration.** *The mistake recurs because a docstring is written as part of the statement and the modifier is added afterwards, when the natural insertion point is immediately above the line that needs it.*

## Permute a printed formula against the symmetry its object is proved to have, before deriving from it

**Proposed rule.** **Rule.** Where the record proves an object symmetric and also prints a formula for it in coordinates, apply the symmetry to the printed formula before deriving anything from it. A permutation that fails locates a wrong sign or index in one line.

**The sharpening over what is already written.** [argument-practice](skills/research-loop/argument-practice.md) says to settle a convention against a derived identity rather than a numeral, which fires when two readings are in dispute. This fires earlier and with no dispute: the invariant is the symmetry the record ALREADY proves of the object, and the check is run at the moment the formula is first used, not when something disagrees.

**Why a coordinate formula is where this bites.** A proof establishes the symmetry abstractly, and a formula in coordinates is written once, by hand, with one coefficient per slot. Nothing downstream re-derives it, and every consumer evaluates it on one ordering of its arguments, which is exactly the case a transposition-symmetric error survives.

### The incident

A trilinear form proved fully symmetric had its bilinear companion printed with one sign wrong on one of three output slots. It is invariant under transposition and not under rotation, so every use on a single ordering agreed. Three sections of derivation were built on it, concluding that a recorded bound was lossy by a factor and that a long-standing item closed outright. Both were artifacts. The cyclic defect is one expression and the test takes seconds. **The occurrence is single and CRITICAL**: it would have put a false refutation of a recorded bound into the record, and a false closure of the item that bound serves.

## A novelty claim is checked in BOTH directions, not just the one the argument came from

**The failure.** A cycle combines two recorded results, or extends one, and checks that the *second* source does not already contain the *first*. It never runs the reverse check, and the reverse is where the answer is. The claim "neither source had the other's piece" then reaches the record, and a reader finds the combination sitting inside one source.

**Why the existing rule does not catch it.** *Search by the object, never by the vocabulary* governs finding a result at all, and it works: the sources ARE found and read. What goes unrun is the second containment test, because after reading source A and confirming it lacks B's ingredient, the question feels settled. **A search that returned hits feels like a search that was performed.**

**The rule.** *Before recording a combination or an extension as new, state which source is claimed not to contain which, and run that test in both directions.* Where the claim is "A and B were never combined", the work is two greps, not one.

**Occurrences, one session, three:** an identity claimed as a specialisation of a general relation while the per-block form sat in the lemma the note cited throughout; a closed form claimed as new while a reviewer's report, committed three minutes earlier, already carried it; and a combination of two reviewers' bounds claimed as taken by neither, while the first reviewer's own line yielded the second's bound exactly. *Each was caught by a reader, each cost a retraction, and in each the mathematics was right.*

**A fourth, 2026-09-28, same repair.** A bound on the node's $E$ was assembled from L50 and a frame cap on the bottom of the second-kind operator, and the cap was written up as this cycle's step after checking the record for the combined bound only. The file that owns L50 already carried the cap frame by frame, used with a cruder budget. *Found by the author after the commit and before Gate 2; the fix is the same, the second containment test (does L50's own file hold the other ingredient).*

## A route's row records the screens that were run, so an unscreened route is visible before it is ranked

**The rule says a candidate route is screened against the fence posts and by grepping the findings for its mechanism before it is proposed. Both screens are written, neither is read back by anything, and a route that skipped them looks exactly like one that passed them.** So the register row carries the screens as named entries, the post table's verdict and the mechanism query with its result, and a row that cannot name them is a route not yet proposable.

**The failure mode.** A route is proposed, ranked top as the only startable thing touching the goal, and worked for a cycle before an audit finds the record already closed it, usually under the name of a different mechanism. The screen's absence is invisible because the route's row records what a successor must clear and never what the proposal itself cleared, so the omission leaves no trace at the one moment anyone would look.

**Why the existing rule does not catch it.** The screens are prescribed at the moment of proposal, which is the moment with no artefact: the sweep file records what was found, the plan records the ranking, and neither records what was looked for and came back empty. A negative result that nobody writes down is indistinguishable from a search never run, and the author is the party least able to tell them apart.

**Occurrences, four, each needing the same repair.** A route proposed and worked for a cycle that was the record's own lemma, closed three times in the notebook. A sweep two of whose three routes were things the record already held, one of them a citation that did not exist. A route whose input was killed by a numbered post established a month earlier, and whose predecessor sat in the closed-route table of the same file. A goal sweep's only pick, whose open step was a uniqueness claim a numbered post had refuted a day earlier, searched for under the sweep's own word for the object rather than the record's, and worked for a cycle and a Gate 2 round before the record's lemmas turned up under their name.

**The check it ships with.** The register's rows are a table, so a gate reads the new row's screen cells and refuses a commit that adds a route leaving either blank. *That is the weak-gate form the editing rules ask for: a declaration the author writes into the register, checkable against one row, turning an invisible omission into a visible claim.*

## A constraint written for one witness is re-derived at the sweep's general parameters, and a control through the sweep's code path runs first

**Rule.** Before sweeping a family, rewrite every constraint that was first written at one member in the family's general parameters, and run a control through the sweep's own code path: a point whose verdict is already proved, which the run must reproduce before it counts. *A constraint copied from the witness it was built for keeps that witness's coefficients, so at every other member it is a different and usually weaker condition, and the sweep reports feasibility the true system does not have.*

**Occurrence, 2026-09-25, critical.** A three-value feasibility screen across all multiplicity triples reused the seven-frame cap with the coefficients of the single frame composition the witness had, $4R_0+3R_2\le T_7$, where the cap holds for every composition $(k_0,k_1,k_2)$ summing to seven. The screen was committed as 239 feasible triples with no control run; the corrected family, with a control on the witness's ray, kept 241 of the 243 points, so the conclusion survived by luck while the recorded run was not the run described. **Fix: re-derive the constraint in the general parameters, and gate the sweep on a control reproducing the witness's proved verdict.**

## A threshold a screen or a claim is measured against is checked against the record's warnings and its catalogued values before the first run

**Rule.** Before a screen, a witness or a recorded claim uses a numerical threshold, grep the record's warnings index and its value table for that threshold and for the dimension in play, and run the catalogued critical points that sit near it through the system as positive controls. *A threshold inherited from an earlier formulation can already be refuted in the record at the very dimension being screened, and every count taken against it then mixes relaxation weakness with real objects.*

**Occurrence, 2026-09-25, critical.** A cycle screened I73's sub-step (c) at $\theta=1.2248$, just above $\sqrt{3/2}$, and recorded survivor counts (237, 190, 234) as evidence of the relaxation's weakness, while the warnings index (W7) records $S^5\times S^7$ as a genuine three-value critical point at $n=12$ with $\theta=1.228239>\sqrt{3/2}$, making the live threshold $\theta_0(12)=1.23603$. The two exact witnesses survived, sitting above $\theta_0(12)$; the counts did not. **Fix: grep the warnings and value tables for the threshold before the first run, and add the nearest catalogued critical point as a positive control, which here passed all 307 constraints and would have flagged the threshold at once.**

## A max-min search from random starts is seeded with the structured candidates first, and its 'none found' is never read as absence

**Rule.** Before a search over subspaces, frames or configurations reports that nothing satisfies a condition, evaluate the structured candidates the problem names (subspaces of decomposable elements, coordinate subalgebras, the catalogued extremal objects) and seed the search with them; report a heuristic optimum as "found" or "not reached", never as "none exists". *Random starts in a large Grassmannian almost never land near a structured subspace, and the search's failure to reach one reads exactly like its absence.*

**Occurrence, 2026-09-25, critical.** A bounded max-min screen over eight-dimensional subspaces of $\mathfrak{so}(12)$ reported no all-good eigenspace at the symmetric spectrum $(8,50,8)$, and the finding was committed as evidence that the spectrum is excluded; one evaluation of the decomposable type showed its ceiling above the threshold, so every subspace of $e_1\wedge\mathbb R^{11}$ was all good. **Fix: evaluate the structured types before the search, and seed it with them.**

## Before formalising an id, list every lean file carrying its name and read the statement row, since a sibling file may already prove the round's target

**Phase 0 opens with `ls lean/HamiltonsCubic/Results/L<id>*.lean` and the id's statement row in `lean/INDEX.md`, and the round's target is what those leave unproved.** A round that read only the main row's owed list re-proved lemmas a sibling statement file already carried, then filed the restatement as new and dropped an owed item another row had discharged. *Twice in one session (L112, L82), each caught only at Gate 2.*

## STOP, you have reached the bottom of this file

**An entry appended here is lost.** Proposals are `##` headings with a scored row in the ranked table near the top; an entry with neither is invisible to the promotion pass and to every later reader.

Before adding one, read **[How these are scored](#how-these-are-scored)**, then:

1. write the rule as a `## heading` in the body, phrased as an instruction;
2. score it `impact × importance`, occurrences driving impact;
3. insert a row in the table **in rank order**, linking the heading;
4. `**APPLY**` at a total of 80 or more with no `HOLD`, `waits` below it.

*This guard exists because a session filed three proposals as bullets at this exact spot, having read the skill that said where to file and not the file that said how.*

### A tracked file is committed by path without being staged, since staging exposes it to another session's whole-index commit

**`git commit -- <paths>` commits the named tracked files from the working tree without any `git add`, and only those paths; staging them first puts them in the shared index, where a concurrent session's whole-index commit takes them under its own message.** Stage only what a gate reads from the index (a NEW file, and the `.lean` a `Deliverable: derivation` commit carries, which [cycle_deliverable.py](hooks/cycle_deliverable.py) checks among the staged files), in the call immediately before its path-named commit. *Three occurrences on 2026-09-26: the step 9 sweep files, D12 and I115 landed in e5dfeeae; a reference-folder deletion in 88488926; batch 36's addendum and a screen script in 30f49126, each a lean-loop commit.*

## Before creating a references folder, grep the references index for the source's identifier

**Rule.** A source found by an outward search is looked up in [references/INDEX.md](../references/INDEX.md) by its identifier (the arXiv number or DOI) before any folder is created, and a hit is read and extended rather than rewritten. *`mkdir -p` on an existing slug succeeds silently, so a fresh README and notes written into it overwrite the filed reading.*

**Incident (2026-09-27, I117).** A web search for self-similar solutions of Hamilton's ODE returned arXiv:1310.4618; the cycle created `references/bhattacharya-2013-curvature-ode/` and wrote a new README and notes over the tracked ones filed on 2026-09-02, which carried a fuller reading. Recovered with `git checkout`, and the re-consultation appended instead. Step 0 of the search rule (search this repository first) covers it and was skipped because the source arrived from outside.

## A reviewer number is claimed by creating its report file exclusively, never by reading the highest one in use

**Rule.** Two sessions share one reviewer sequence, so a number read as free can be taken between the read and the write. Claim it by creating `reviews/REVIEW_rN.md` with an exclusive create (fail if it exists) and move to the next number on failure; never write a skeleton over a path that exists.

**Incidents (2026-09-27, I117).** A brief builder reused r1567 and r1568 after the lean session's reviewers had taken them, overwrote the lean session's committed REVIEW_r1567.md (restored by `git checkout`) and its r1568 reviewer's untracked report path mid-write (flagged to that session, which had the reviewer confirm its file). Earlier the same day the lean session had taken r1554 and r1559 between this session's number checks, caught before any write. Later the same day (r1711) this session claimed the number by an exclusive create of agent_logs/r1711.log while the lean session's reader logged to agent_logs/review-r1711.log, so neither claim saw the other: the reader's REVIEW_r1711.md replaced this session's report before its commit, the L279 fidelity report's text was lost, and it was re-filed as r1713 from the reviewer's hand-back. An exclusive create on the report path, the one file both sessions write, would have stopped it.

## A quoted given is extracted up to its Proof marker and checked against the block's end, never cut at the first newline

**Rule.** A brief quotes a given's statement by extracting from its `Statement` marker to its `Proof` marker, and the builder checks that the quoted text ends where the statement ends. A statement carrying display maths spans several lines, so a cut at the first newline hands the reviewer a truncated premise that reads as complete, which the verbatim-quoting rule already forbids and no check enforces.

**Incidents (2026-09-27, I117).** One brief builder cut every quoted statement at its first newline. L268's statement was truncated in the briefs of r1575/r1576, r1586/r1587 and r1589/r1590, and L271's in r1589/r1590's. r1590 noticed and read the full statements from the record; the others did not report it. **Fix for each**: extract to the Proof marker and assert the quote's last line is the statement's last line.


## lean-loop, phase 0: grep the layer for the step before formalising it

**Rule.** Before writing a declaration for an owed step, grep `lean/` for the step's natural names and for the row's other files, and read every file the row already lists. A row can owe a step in prose while a file it names already proves it, and a round that skips the search ships a second copy under a new name.

**Incident (2026-09-27, L240).** 97872ff0 added `L240Row.lean` with `row_le_eight` and `bracketTotal_le_56`, both already proved in `L240Rows.lean` (7a6fdc13, Gate 2 r1157) and credited on the same row; reader r1706 caught it and 99bff4f5 removed the copy.

- **The root import file is shared, so stage only your own lines of it.** A path-named commit of lean/HamiltonsCubic.lean takes the whole working-tree file, including another session's unstaged import of a module that is not yet tracked, and HEAD then fails to build. Before a commit that names it after --, check that its diff against HEAD is exactly this round's import lines, since a path-named commit takes the working-tree copy, and wait for the other session's commit when it is not.

- **Compile a draft module from the scratchpad, not from lean/HamiltonsCubic/Results/.** The pre-commit gate refuses every commit while an untracked module there is unimported, so a draft left in the tree blocks every session's commit, including the author's own. `lake env lean <scratchpad>/X.lean` resolves imports from the project, and the file moves into Results/ in the same step that adds its import line.

- **Check a named constant against the record at every case it splits into.** A constant the record defines piecewise (by parity, by range of `n`) is stated in Lean from the piece that was in view, and a docstring then names the whole constant: L57's `Θₙ` is `θ₀(n)` only at even `n`, and three files read `θ₀(n)` as `Θₙ` at odd `n` until a reader refuted it. Before writing a constant's name in a statement, docstring or index row, grep the record for its definition and carry each case, or name the case typed.

- **lean-loop, commit step (2026-09-28):** Edit the index row and check the edit landed before launching the build-and-commit script, never inside the same shell chain. An anchor that no longer matches fails the edit silently in a chain without `set -e`, and the script then commits the code with a stale row, which a second commit has to repair.

## A commit refuses text carrying a control byte followed by a letter

**Rule.** The commit gate refuses a staged `.md`, `.tex` or `.lean` file containing a tab, form feed, backspace, carriage return or bell byte immediately followed by a letter, and a script that writes LaTeX into the record uses raw strings or writes bytes. **Failure.** `\t`, `\f`, `\b` and `\r` inside non-raw strings became control bytes in `\theta`, `\times`, `\tfrac`, `\frac`, `\beta`, `\binom`, `\rVert` and `\rangle`, 85 sites across seven files (second-order.md since eb34968c, stratum-two-negative.md, LEDGER.md, BRIEF_L219.md, ATTEMPTS.md, reviews/INDEX.md, REVIEW_r1110.md), each rendering as broken math and one hiding CRs that a text-mode rewrite turned into line breaks. **Seven occurrences, none critical**: the corruption garbles display rather than any recorded claim. **Occurrence 8, 2026-09-28**: `\rVert` in a table header written through a non-raw Python string, the carriage return already normalised to a line feed on disk, so a control-byte gate would pass it; the same shape sat in seven older reviewer-index rows as lines opening with `Vert`, `angle` or `ho`. *The gate also flags a line opening with the tail of a LaTeX command after a backslash-less break.*

## A screen for a maximum over a family starts from the family's structured objects and runs past where their value crosses the claim

**Rule.** Seed a screen of a maximum with the family's natural objects (the identity, the Casimir, the known critical points) beside random starts, compute their values in closed form, and run the screen past the dimension where any of them crosses the claimed bound. **Failure.** A uniform bound of $\tfrac56$ was read off random-start screens at $m\le6$ and recorded as a candidate lemma, while the identity, whose value $\binom m3/\binom m2^{3/2}$ is one line, crosses it at $m=9$.

## A module's import line enters the shared root file only in the commit that adds the module

**Rule.** Draft a new module in the scratchpad and compile it with `lake env lean <path>`, then place it, `lake build` it so its object file exists, write its line into the root import file and commit module and root together, so the root never carries an uncommitted import. When the root already carries another session's uncommitted line, wait for that session's commit. A path-named commit takes the working-tree copy of the root, so another session's commit then elaborates an import whose module has no build output and is refused, or lands it under the wrong message.

**Incidents.** (1) The lean-loop note above (the root import file is shared): another session's unstaged import rode into a path-named commit and HEAD failed to build. (2) 2026-09-28: this session added `import HamiltonsCubic.Results.ProductFoothold` to the root while its own commit waited on the index lock, and the lean session's pre-commit elaboration of the root failed on it, so that session pulled its own module out of the tree until f7a6cd52 landed. (3) 2026-09-28, reversed: the lean session's uncommitted `L224LineOdd` import sat in the root while this session committed `CircleEndpoint` by path, so the commit took both lines and its pre-commit refused the root for two missing object files.

## A feasibility screen evaluates the inequality as recorded, and its returned objects are checked against the definition

**Proposed rule.** A screen reporting that objects satisfy an inequality evaluates the inequality term for term as the record states it, and before its verdict is written down, the objects it returns are tested against the definition the inequality came from (here, applying the rotation itself), by code sharing none of the screen's algebra. *A relaxed test passes more objects than the real one, so a feasibility verdict from it overstates in exactly the direction that weakens a separator.*

**Occurrence 1, 2026-09-28, critical.** *A descent screen compared the visible energy with the diagonal mass, dropping a quarter of the block-sum squares from the left side and the matching's own edge mass from the right, and reported frames satisfying every matching inequality at small mass. The verdict was recorded, set a floor, and weakened a recommendation sent for decision. Two reviewers found every returned frame violating the full inequality, and a direct-rotation check agreed.* **Fix**: evaluate the recorded inequality, and apply the defining rotation to the returned frames before recording.

## An edit to a module the root imports is made in the scratchpad and copied back only once it builds

**Rule.** To change a module the root import file already carries, edit a scratchpad copy, compile it with `lake env lean <path>`, and copy it over the tracked file only after that passes, then `lake build` it before any commit. *A failed build of an imported module leaves no object file, and every session's pre-commit elaboration of the root then fails on it, so a half-finished edit in the tree blocks commits it has nothing to do with.*

**Occurrence 1, 2026-09-28.** *Two lemmas added in place to an imported module failed to build twice (a `linarith` step, then an unsubstituted equation), and the lean session's commit of an unrelated module was refused for about half an hour ("object file ... does not exist") until that session built the module from this session's working tree.* **Fix**: the scratchpad edit above.

## A heredoc that carries record text is quoted, and values enter it through the environment

**Rule.** A heredoc whose body quotes the record (a brief, a note, a commit body) is written `<<'EOF'`, and any value the script needs is passed in as an environment variable (`A=1853 python3 - <<'PY'`), never by leaving the delimiter unquoted. *An unquoted delimiter makes the shell run every backticked span and expand every `$`, so the record's own code spans execute as commands and vanish from the text.*

**Occurrence 1, 2026-09-28, critical.** *A Gate 2 brief was assembled with `<<PY` so that one shell variable could reach the script; the shell executed each backticked name in it (a commit hash, declaration names, a file path, `lake env lean`), the brief was committed with those names missing and its LaTeX escapes mangled, and it was caught only by reading the tool output before dispatch.* **Fix**: the quoted delimiter and an environment variable, as above.

## A value cited as proved carries the result that proves it, and a table row is not one

**Rule.** Before a claim consumes a constant as proved (a maximum at a dimension, a threshold, a sharp value), cite the numbered result or certificate that proves it; a conventions row, a warnings row or a sentence saying "the record certifies" is a pointer to check, not a proof.

**Occurrence 1, critical.** *A findings block called a split at $n=6$ "a theorem" on $M(6)=\sqrt{3/2}$, a value the record held only as a lower bound; the same value sat in a conventions row and a warnings row, and an earlier audit (r649) had flagged it without the rows being repaired.* **Occurrence 2, 2026-09-28.** *I124's batch 8 excluded six-index configurations on the same row, and two Gate 2 readers (r1940, r1941) found the missing ceiling independently.*

## A reviewer number is proved free by a command that cannot fail silently, and sessions sharing a counter reserve blocks

**Rule.** Check a reviewer number free with a command whose failure is visible (zsh aborts a whole `ls` on one unmatched glob, which reads as "no such file"), and when several sessions draw on one counter, reserve a block per session by message before dispatching.

**Occurrence 1, 2026-09-28.** *A free-number check `ls reviews/REVIEW_r1912.md agent_logs/r1912*` aborted on the unmatched glob and printed nothing, so a reviewer was dispatched as r1912 over another session's committed report and overwrote it in the working tree; it was restored from HEAD and the reviewer renumbered.* **Occurrence 2, the same day.** *The next pair skipped a number the other session had just taken, found only by a second check.*

