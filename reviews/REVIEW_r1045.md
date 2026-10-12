# r1045: the debt-gate repair and two folds, audited

**Scope.** `d46264ac` on [.claude/hooks/lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py), `0a7b4bee` on [I104GramSystem.lean](../lean/HamiltonsCubic/Results/I104GramSystem.lean) and [L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean), and `a3ea41d9` on [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) with its record rows. Sole reviewer on this scope.

**Log.** [agent_logs/r-folds-hook.log](../agent_logs/r-folds-hook.log)

**The headline is the count.** The I106b fold declares SIX distinct conditions at `k = 4` and states that "the original 'six advertised' was right". [r1040](REVIEW_r1040.md), [r1041](REVIEW_r1041.md) and [r1043](REVIEW_r1043.md) all say TWELVE, six on `ν` and six on the weights, and r1043 says in as many words that adding `l ≠ m` "makes 'twelve' exactly right". The fold applied that binder and then recorded the number the three reports were written to correct.

| # | claim | verdict |
|---|---|---|
| 1 | the old `\b` pattern could never match under POSIX ERE | **CONFIRMED**, and the mechanism is sharper than the commit says |
| 2 | the new character-class boundary preserves both discriminations | **CONFIRMED**, seven probes |
| 3 | the hook clears a debt when the declaration exists and fires when it does not | **CONFIRMED** by construction, four states |
| 4 | `sum_u_sq_le_of_joint_system` is the record's `Σ u_a² ≤ (5/3) t` | **CONFIRMED** |
| 5 | `joint_system_holds` is the note's system and its `sorry` gap is named correctly | **CONFIRMED**, inhabited and tight |
| 6 | every finding of r1040–r1043 the folds claim was applied, was applied | **REFUTED**: two corrections REVERSED, one dropped, one misattributed |
| 7 | six distinct conditions at `k = 4`, and 48/24/12 are what the fold says | **REFUTED**: `6` counts the weight clause alone, the cost is `12`, and the `24` and `12` on the record are not what the fold says they are |
| 8 | deleting the general `zero_diag_critical_is_isSignedPerm` is the right call | **CONFIRMED**, with one qualifier lost in transit |

## 1. The gate could not be satisfied, and `\b` is why

**The old pattern matches nothing that a Lean declaration can be.** In this repository, at `git version 2.55.0`:

| pattern | exit |
|---|---|
| `(theorem\|lemma\|def\|abbrev\|structure\|instance)[[:space:]]+joint_system_holds\b` | `1`, no file |
| the same with the new tail `([^A-Za-z0-9_.'!?]\|$)` | `0`, [I104GramSystem.lean](../lean/HamiltonsCubic/Results/I104GramSystem.lean) |
| the same with no boundary at all | `0`, the same file |

**The alternation and `[[:space:]]` are innocent, which the commit does not establish and which matters because it is the only other candidate.** Isolating each element: `joint_system_holds` alone returns `0`, `joint_system_holds\b` returns `1`, `\bjoint_system_holds` returns `1`, and `(theorem|lemma)[[:space:]]+joint_system_holds` returns `0`. The failure is `\b` at either end, alone.

**And `\b` does not merely fail to assert a boundary, it matches a literal `b`.** On a throwaway repository carrying `theorem foo :`, `theorem foob :` and `theorem fooX :`, the pattern `theorem foo\b` matched **exactly one line, `theorem foob :`**. So the old test asked whether the layer declares something called `<name>b`. That is the commit's conclusion reached by a stronger route, and it disposes of the `re.escape` hypothesis too: Python 3.7's `re.escape` touches only `()[]{}?*+-|^$\.&~#` and whitespace, so on the names [IDENT](../.claude/hooks/lean_blocked_debt.py) can extract it rewrites `.` to `\.` and `?` to `\?`, both of which ERE reads as the literal character. It never introduces a backslash that changes meaning.

## 2. Both discriminations survive, and two more

Seven probes on a constructed layer, all as the commit claims.

| debt name | layer | exit | reading |
|---|---|---|---|
| `foo` | `theorem foo :` | `0` | a declaration pays |
| `barbaz` | prose only, no keyword | `1` | a mention does not pay |
| `foo_longer` | `theorem foo_long :` | `1` | a shorter declaration does not pay a longer debt |
| `foo_long` | `theorem foo_long :` | `0` | its own does |
| `quux` | `theorem quux_long :` | `1` | a longer declaration does not pay a shorter debt |
| `prime_thm` | `theorem prime_thm' :` | `1` | the apostrophe is inside the name, as Lean spells it |
| `eol_case` | `theorem eol_case` at end of line | `0` | the `$` branch is live |

**The apostrophe and the `.` in the excluded class are doing real work** and the commit does not name them: Lean's primed names and namespaced names both end up on the correct side because of them.

## 3. The gate fires and clears, observed

A throwaway git repository with `lean/`, a commit carrying `Lean: blocked -- the joint system needs sharedChannelGram, absent from the layer`, twenty filler commits so the debt passes `AGE = 15`, and the hook run with the flag armed for the payload's session.

| state | layer | hook exit | stderr |
|---|---|---|---|
| A | nothing | `2` | names `sharedChannelGram`, 20 commits ago |
| B | `theorem sharedChannelGram :` added | `0` | silent |
| C | declaration removed, `-- sharedChannelGram will never be written` left | `2` | fires again |
| D | `theorem sharedChannel :` only | `2` | fires, the prefix does not pay |

**State B is what sixteen commits of history could not reach.** Running the faithful old pattern against state B's layer returns `1`, so before this commit the same repository state was read as an unpaid debt. The gate is now satisfiable and still discriminating.

## 4. The record's `u`-bound is the record's

[sum_u_sq_le_of_joint_system](../lean/HamiltonsCubic/Results/I104GramSystem.lean) takes `(∑ β_a²) + αᵀ Msys α ≤ t` and concludes `∑ (α_a² + β_a²) ≤ (5/3) t`. The note's line 49 is `t ≥ Σβ_a² + (3/2)Σα_a² − (3/10)(Σα_a)²`, and [Msys_quadForm](../lean/HamiltonsCubic/Results/I104GramSystem.lean) proves that expression equals `αᵀ Msys α`, so the hypothesis is the note's system verbatim. With `u_a² = α_a² + β_a²` from the note's line 48, the conclusion is the note's `Σ u_i² ≤ (5/3) t`. **The chain is the one r1042 supplied**, `t ≥ Σβ² + (3/5)Σα² ≥ (3/5)(Σβ² + Σα²)`, and `λ_min(Msys) = 3/5` is right: `Msys = (3/2)I − (3/10)J` and `J` carries `3` on the constants, giving `3/2 − 9/10 = 3/5`.

### The one r1042 finding the fold dropped

r1042's claim 6 closes: *"The sharpness the record's scalar bound actually rests on is missing. That bound comes from `λ_min(Msys) = 3/5`, so its sharpness is equality in `Msys_quadForm_ge`, at the all-ones vector where both sides are `9/5`. It is one line and it is not in the file."* **It is still not in the file.** A grep for `Msys_quadForm_eq` returns nothing, while its twin [Ge_quadForm_eq_at_ones](../lean/HamiltonsCubic/Results/I104GramSystem.lean) sits eight declarations above. Both sides are `9/5` at the all-ones vector, by hand: `x ⬝ᵥ x = 3` gives `(3/5)·3 = 9/5`, and `(3/2)·3 − (3/10)·9 = 9/5`. **Correction: add the one line, or record in the row that the dual sharpness is unstated.**

## 5. `joint_system_holds` is the note's system, and the gap is named right

**The binders match the note once the reading is fixed, and the reading is the non-obvious part.** [hal](../lean/HamiltonsCubic/Results/I104GramSystem.lean) makes `α_a = ⟪D, e_a⟫`, an inner product against the SHARED-channel direction, while the note's line 48 writes `q_a = α_a ê_a + β_a f̂_a`, a COEFFICIENT. They coincide, and only because `ê_a` lies in plane `a` and is orthogonal to `f̂_a`, so `⟪D, ê_a⟫ = ⟪q_a, ê_a⟫ = α_a`. The distinction is live here, since the `e_a` are not orthonormal among themselves, and the file does not say why the two readings agree.

**The statement is true and the hypotheses are the right ones.** Split `D` by `span{e} ⊥ span{f}`, which [hef](../lean/HamiltonsCubic/Results/I104GramSystem.lean) supplies. Writing the `e`-part as `Σ x_a e_a` gives `⟪D, e_b⟫ = (G x)_b`, so `x = G⁻¹α` and `‖P_e D‖² = αᵀ G⁻¹ α = αᵀ Msys α` by [Ge_mul_Msys](../lean/HamiltonsCubic/Results/I104GramSystem.lean). The `f`-part contributes `Σβ_a²` and the remainder is nonnegative. The `sorry`'s docstring names exactly that step, the non-orthonormal Bessel inequality, and names it correctly.

**Inhabited and tight, screened.** Realising `Ge = MᵀM` in `ℝ⁶` with the `f_a` the last three basis vectors, 200 random `D` give slack `≥ −3.6e−15`, which is floating-point zero, and equality holds identically because the six directions span. So the hypothesis set is satisfiable at every `D`, the conclusion is attained, and the theorem is not vacuous. The note's third assertion, `⟪q_a, q_b⟫ = (1/3) α_a α_b`, follows from the same three orthogonality hypotheses, so nothing in the note's line 49 is left untyped except the `sorry`.

### The sentence the commit contradicted and left standing

[I104GramSystem.lean](../lean/HamiltonsCubic/Results/I104GramSystem.lean) line 256, eleven lines below the declaration the same commit added: **"`joint_system_holds` is absent from the layer, and what is missing is now the GEOMETRY alone."** The section it heads is titled "What is NOT stated, and the debt that names it". The second half of the sentence is still true and the first half is now false, in the file that falsifies it. **Correction: "`joint_system_holds` is now stated and `sorry`'d, and what is missing is the GEOMETRY alone."**

## 6. The folds, finding by finding

### r1042, three defects: two applied, one applied in a way that creates a new one, one dropped

| r1042 finding | fold | verdict |
|---|---|---|
| `lam_mul_F_floor` docstring is a pre-proof leftover, `4e−5` margin and `0.5923041` as an equality | rewritten with `4.9e−6`, `4.77e−6` proved, eight digits | **applied**, and it introduces a second figure for one screen |
| `sum_sq_le_of_quadForm_le` is the `α`-part, not the record's `u`-bound | renamed to [sum_alpha_sq_le_of_quadForm_le](../lean/HamiltonsCubic/Results/I104GramSystem.lean), [sum_u_sq_le_of_joint_system](../lean/HamiltonsCubic/Results/I104GramSystem.lean) added, [lean/INDEX.md](../lean/INDEX.md) row rewritten | **applied in full**, the recommended option of the two |
| `forcing_at_excluded_config`'s gloss inverts the safety direction | rewritten, naming rounding UP as unsafe and both earlier versions as wrong | **applied** in the Lean, **not** in [lean/INDEX.md](../lean/INDEX.md), whose row still carries only *"The record's $0.116707$ rounds UP from the rational, not down"* with no safety direction |
| the dual sharpness `Msys_quadForm_ge` at the all-ones vector is missing | nothing | **DROPPED**, see section 4 |
| the `Lean: blocked` trailer's stated reason is now false | superseded, the declaration exists so the gate clears | **moot**, correctly |

**The new defect.** [L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean) now records the six-digit screen twice and differently: line 121 says `0.5922980` and line 338, added by the fold, says `0.592297845`. r1042 flagged that pair explicitly as a grid-choice difference in the last digit, and the fold imported the reviewer's figure without reconciling it with the file's own. Both lie below `0.5923`, so the conclusion is untouched. The irony is that the new docstring's closing sentence is **"A numeral that survives being written down wrongly twice is one to emit from the computation rather than to restate."** **Correction: emit both from [l182_emit.py](../scripts/misc/l182_emit.py), or state the grid beside each.**

### r1040 and r1041: applied earlier, and one correction REVERSED here

Everything r1040 and r1041 found was applied by `6eff524e` and `64005452`, which are r1043's scope rather than mine, with one exception that `a3ea41d9` undoes.

| finding | where it stands at HEAD |
|---|---|
| the typed statement is FALSE with no hypothesis on `ν` (r1040, r1041) | applied, then superseded by deletion |
| the repair is injective `ν` PLUS per-pair weight separation (both) | applied, [CriticalityGeneric](../lean/HamiltonsCubic/Results/I106bFace.lean) |
| claim 3's attribution, one dimension to orthogonality and one to criticality (both) | applied, the row says *"ORTHOGONALITY of the columns removes one dimension there and CRITICALITY removes one, not two"* |
| claim 6 over-credits Jin, part (i) is an in-house corollary (r1040) | applied |
| *"THE OPEN STATEMENT IS A THEOREM AT `k = 4`" is false* (r1041) | applied |
| **r1040: "The genericity cost is therefore twelve conditions at `k = 4`, six on `ν` and six on the weights, where the claim advertises six"** | **REVERSED.** [lean/INDEX.md](../lean/INDEX.md) now reads *"Its cost is SIX distinct conditions at $k=4$"* and [ATTEMPTS.md](../ATTEMPTS.md) says *"The original 'six advertised' was correct and the correction of it was not"* |
| **r1041: *"'Its cost is one stated hypothesis' undercounts: it is six weight conditions and the pairwise distinctness of `ν`"*** | **REVERSED the same way**, the row having returned to a single number that omits the `ν` half |

### r1043, four corrections owed: all four applied, and its count misreported

| r1043 section 9 | fold |
|---|---|
| 1. delete the general statement, since restricting it to `k = 4` is `zero_diag_critical_is_isSignedPerm_four` | **applied**, with the prose replacing it |
| 2. add `l ≠ m →` to [CriticalityGeneric](../lean/HamiltonsCubic/Results/I106bFace.lean) | **applied**, one binder, and `hwsep`'s call site updated |
| 3. record the structural lemma of section 1 | **applied**, in the file, [ATTEMPTS.md](../ATTEMPTS.md), [lean/INDEX.md](../lean/INDEX.md) and by implication [plan.md](../plan.md). The kernel direction `(w_d − w_b, w_a − w_d, w_b − w_a)` is r1043's own up to sign, and it is the cross product of `1` with `w` |
| 4. the route needs maximality at `k ≥ 5` | **applied**, [plan.md](../plan.md) now ends *"What R28 needs at $k\ge5$ is MAXIMALITY rather than criticality"* |

Its overreach sweep fares nearly as well: items 1, 2, 3 and 4's `plan.md` and `lean/INDEX.md` occurrences are all gone. **Two are left.**

- **Item 5 is untouched.** [lean/INDEX.md](../lean/INDEX.md)'s I106b row still closes *"Gate 2 CLEARED by r1040 and r1041 … claim 4 REFUTED by both and true under the repaired hypotheses."* The final clause is exactly what r1043 refuted. **Correction: "claim 4 REFUTED by both, and FALSE under the repaired hypotheses as well, at `k = 5` ([r1043](REVIEW_r1043.md)). Those readers cleared the version they read, and the repaired statement was reviewed only afterwards."**
- **Item 4's `ATTEMPTS.md` occurrence is untouched**, the 2026-09-20 entry still reading *"genericity that is now twelve scalar conditions at `k = 4`"*, so the file now contradicts its own next entry. Since twelve is the right total, the fix is to the newer entry.

### And one thing applied that no report found

The reconciliation of the three figures is the fold's own, and section 7 shows it is wrong.

## 7. The count, done here

**What the clause is.** `∀ l m a b, l ≠ m → a ≠ l → a ≠ m → b ≠ l → b ≠ m → a ≠ b → w_a ≠ w_b` with `w = β(ν_l + ν_m)u + c`.

**What is symmetric in what.** `w` depends on `(l,m)` only through `ν_l + ν_m`, so it is symmetric in `l` and `m`. The conclusion `w_a ≠ w_b` is symmetric in `a` and `b`. At `k = 4` the complement of `{l,m}` has exactly two elements, so `{a,b}` is DETERMINED by `{l,m}` and carries no freedom of its own. **A distinct condition is therefore an unordered pair `{l,m}`, and there are `C(4,2) = 6` of them.**

Enumerated:

| figure | what it counts | value at `k = 4` |
|---|---|---|
| quantifier instances, no `l ≠ m` | `(l,m,a,b)` tuples passing the five inequations | **48** |
| quantifier instances, with `l ≠ m` | the same, restricted | **24** |
| ordered `(l,m)` with `l ≠ m` | one complement pair each | **12** |
| DISTINCT weight conditions, no `l ≠ m` | `6` from `l ≠ m` plus `4 × 3 = 12` from `l = m` | **18** |
| DISTINCT weight conditions, with `l ≠ m` | unordered `{l,m}` | **6** |
| distinct injectivity conditions on `ν` | `ν_i ≠ ν_j` | **6** |
| **DISTINCT conditions in [CriticalityGeneric](../lean/HamiltonsCubic/Results/I106bFace.lean) as it now stands** | injectivity plus the clause | **12** |

**So the fold's four numbers are each correct about the weight clause and the sentence built from them is not.** Three failures, and they compound.

1. **`CriticalityGeneric` is a conjunction and the fold counts one conjunct.** `Function.Injective nu` is six conditions at `k = 4`. The genericity cost is `6 + 6 = 12`. [plan.md](../plan.md) now reads *"The hypothesis is now injective $\nu$ PLUS a per-pair separation of the complementary weights, SIX distinct conditions at $k=4$"*, where the apposition attaches six to a hypothesis that costs twelve.
2. **r1040's twelve is not "ordered pairs of those same six".** r1040 wrote *"twelve conditions at `k = 4`, **six on `ν` and six on the weights**"*, which is the post-repair total and is right. The fold's `12` is the count of ordered `(l,m)`, a different object that happens to share a value.
3. **r1043's twenty-four is not "quantifier instances of those same six".** r1043 wrote *"6 injectivity conditions plus `6 + 12 = 18` weight conditions, twenty-four distinct scalar conditions"*, under the unrepaired definition. The fold's `24` is quantifier instances under the repaired one. Same value, unrelated derivation.

**And r1043 states the post-repair figure outright**, in the sentence recommending the binder: *"adding `l ≠ m →` to the definition costs the proof nothing and **makes 'twelve' exactly right**."* The fold carried out that recommendation and recorded the opposite of its stated consequence. **Corrections: [lean/INDEX.md](../lean/INDEX.md) to "SIX distinct weight conditions and six on `ν`, twelve in all, which is [r1040](REVIEW_r1040.md)'s figure"; [plan.md](../plan.md) and [ATTEMPTS.md](../ATTEMPTS.md) the same; and delete "The original 'six advertised' was correct and the correction of it was not", since the advertised six was the genericity cost and the cost is twelve.**

## 8. Deleting it was right

**The case against deletion, stated at its strongest.** r1043's witness is numerical. Newton-Kantorovich needs verified bounds on the residual, the inverse Jacobian norm and the Lipschitz constant of the derivative, and r1043 reports the first two and asserts the conclusion rather than certifying it in interval arithmetic. A `sorry`'d proposition costs nothing while it sits unproved, and the alternative of restating it as open preserves the target for a later exact witness. Three deletions in this repository have later had to be undone on weaker grounds than this.

**The case for, which wins.** Four things decide it.

- **Asymmetry of the burden.** Deleting a `sorry` asserts nothing. Retaining one asserts, to every reader and to the kernel's users, that the proposition is a target worth discharging. The evidence needed to stop advertising a target is far below the evidence needed to assert its negation as a theorem, and the fold asserts only the former in the layer.
- **The margins are not close.** Every hypothesis that could fail under perturbation is open with margin `5e−2` against a residual of `5e−62`, and the conclusion misses by `3.1` in `‖Q‖₄⁴` against a scale of `5`. No arithmetic error of the kind numerics produce spans forty orders of magnitude and then a gap of `3.1`.
- **A hand-checkable structural lemma predicts the witness.** r1043's `k = 5` kernel computation is exact and needs no solver: the `2 × 3` system has kernel spanned by `1 × w`, whose entries the weight clause makes nonzero, so the `k − 4 = 1` free dimension is occupied rather than empty. The witness is the expected object, not an anomaly, and that is what turns a numerical near-miss into a refutation.
- **Nothing depends on it.** r1043's `#print axioms` over all twenty-nine declarations found `sorryAx` on exactly two and no other declaration depending on either, so deletion breaks nothing.

**What restatement would have bought is zero.** "Open" is a claim about the state of knowledge, and the state of knowledge is that it is false at `k = 5`. Restating it as open is a weaker false claim, which is r1043's own phrase and is right.

**The one qualifier lost in transit.** The fold's commit message says *"its status is recorded as the reviewer stated it: a VERIFIED NUMERICAL witness, not an exact one"*, and [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean), [ATTEMPTS.md](../ATTEMPTS.md) and [lean/INDEX.md](../lean/INDEX.md) do carry it. **[plan.md](../plan.md) does not.** Its new sentence is *"THE $k=4$ PROOF LANDED AND THE GENERAL CASE IS REFUTED, NOT OWED: [r1043](REVIEW_r1043.md) exhibits a $k=5$ counterexample with the genericity in force"*, with no epistemic qualifier anywhere in the item. plan.md is the file a cycle reads first. **Correction: add "a verified numerical witness with margins `5e−2` and a conclusion gap of `3.1`, exact certification outstanding" to the plan item.**

## 9. Overreach sweep

Every sentence below was added or left standing by these three commits and is not supported by their artifacts.

1. [I104GramSystem.lean](../lean/HamiltonsCubic/Results/I104GramSystem.lean): *"`joint_system_holds` is absent from the layer"*, eleven lines under the declaration `0a7b4bee` added. Section 5.
2. [lean/INDEX.md](../lean/INDEX.md): *"claim 4 REFUTED by both and true under the repaired hypotheses"*. False at `k = 5`, and it is r1043's own overreach item 5 left in place.
3. [lean/INDEX.md](../lean/INDEX.md): *"Its cost is SIX distinct conditions at $k=4$ … the $24$ and $12$ that appear in the round's own record are quantifier instances and ordered pairs of those same six"*. Both attributions false. Section 7.
4. [ATTEMPTS.md](../ATTEMPTS.md): *"all three were right about different things … The original 'six advertised' was correct and the correction of it was not"*. The correction was right and stands.
5. [plan.md](../plan.md): *"injective $\nu$ PLUS a per-pair separation of the complementary weights, SIX distinct conditions at $k=4$"*. Twelve.
6. [plan.md](../plan.md): *"THE $k=4$ PROOF LANDED AND THE GENERAL CASE IS REFUTED, NOT OWED"*, with no record anywhere in the item that the witness is numerical. Section 8.
7. [reviews/INDEX.md](INDEX.md), the r1043 row: *"the honest count is SIX distinct conditions at $k=4$, the reviewer's $24$ and the commit's $12$ being quantifier instances and ordered pairs of the same six"*. This attributes to r1043 a conclusion it did not reach and contradicts the sentence of r1043 that recommended the change.
8. [L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean) line 338: *"six-digit surds give `0.592297845`"* against line 121's `0.5922980` for the same screen. Section 6.
9. [ATTEMPTS.md](../ATTEMPTS.md), the 2026-09-20 entry: *"twelve scalar conditions at `k = 4`"*, now contradicting the 2026-09-21 entry below it. Here the older entry is the correct one.
10. The commit body of `d46264ac`: *"both discriminations survive … each checked by hand"*. Both do survive and section 2 confirms it, but the commit does not record what was checked, and the two discriminations it names are not the two the character class actually turns on, which are the apostrophe and the dot.

**What these commits claim and DO support**, checked and not listed above: the `\b` diagnosis, the character class, the `sum_alpha`/`sum_u` split and its two-line proof, the Bessel reading of the joint system, the `4.9e−6` and `4.77e−6` margins, the rounding-direction correction, the structural `k = 5` lemma, the `0.3828` against `1.4688` valuation, the `l ≠ m` binder and the deletion itself.

## 10. How the analysis-only rule was honoured

**No sweep, no census, no optimisation of unknown cost, no falsifier hunt.** Everything here ran in seconds on objects constructed for the purpose.

- Eleven `git grep` invocations against this repository and two throwaway repositories built in the scratchpad, to settle sections 1, 2 and 3. The hook itself was run four times against a constructed history, never against this repository's state.
- One exhaustive enumeration of `4⁴ = 256` tuples for section 7, which is the whole quantifier range at `k = 4` rather than a sample.
- One 200-draw screen of [joint_system_holds](../lean/HamiltonsCubic/Results/I104GramSystem.lean) in `ℝ⁶`, reported as a screen and cited for inhabitedness and tightness only. The verdict on claim 5 rests on the orthogonal-decomposition argument in section 5, which is by hand.
- **No Lean process was started and `lake build` was never run**, so nothing here contended with r1044 for the machine. Claim 5's `sorry` is read from the source, and r1043's axiom audit is taken as reported rather than repeated.
