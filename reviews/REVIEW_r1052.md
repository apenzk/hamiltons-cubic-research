# Review r1052: `joint_system_holds`'s proof, and the $n=6$ refutation of the $\theta_0$ candidate

Sole reviewer on commit `f73dcd61`, `feat(i104): joint_system_holds is proved, and the theta_0 threshold falls at n = 6`. Prior reviewers on the neighbouring work: [r1050](REVIEW_r1050.md) and [r1051](REVIEW_r1051.md). Analysis only, with the screening allowance. The machine steps are one elaboration of the file under review, four axiom prints on cached oleans, a grep over the pinned Mathlib tree, and seconds of arithmetic on objects I wrote down.

Log: [agent_logs/r1052-i104-proof-and-n6.log](../agent_logs/r1052-i104-proof-and-n6.log)

| # | claim | verdict |
|---|-------|---------|
| 1 | `joint_system_holds` is proved, the statement was not weakened, the hypotheses are satisfiable | **CONFIRMED**, byte-identical statement, non-vacuous, one docstring correction |
| 2 | `axiom_audit.py --only I104GramSystem` gives 19/19 clean, with `joint_system_holds` inside the 19 | **CONFIRMED**, reproduced exactly |
| 3 | The completed square, and whether it needs `Msys` symmetric | **CONFIRMED**, derived independently. Symmetry is NOT needed, and `Msys` is symmetric anyway |
| 4 | The docstring's "no Bessel is needed" | **CONFIRMED** of the dependency, with one correction: this IS Bessel's own proof at three vectors |
| 5 | The $n=6$ table entries and the refutation they support | **CONFIRMED** on all three transcriptions, **REFUTED on "TWICE"**: $\mathbb{CP}^3$ reaches the candidate only under a threshold the paragraph silently loosens |
| 6 | The scoping to $n\ge12$, and the claimed absence at $n\ge12$ | **The call is RIGHT and its stated reason is the weak one.** The absence claim is **REFUTED as reassurance**: [post F43](../findings/bounds-relaxations.md) holds an $n=12$, $s=3$ spectrum at $\theta=1.2917>\theta_0(12)$ with realisability open |
| 7 | The three folded lean-round notes in [lean/INDEX.md](../lean/INDEX.md) | **CONFIRMED**, all three, each checked against the file and the library rather than against the note |
| 8 | Overreach sweep | **REFUTED**: one claim in [plan.md](../plan.md) is false, one row count is wrong, and the row announcing a drift repaired still carries it |

## Claim 1, the proof and the statement: CONFIRMED

**The statement was not touched.** Extracting `joint_system_holds`'s signature from `7860c4b0` and from `f73dcd61` and diffing gives no difference: nine lines, same binders, same five hypotheses, same conclusion `(∑ a, be a ^ 2) + al ⬝ᵥ (Msys *ᵥ al) ≤ t`. The only edits to the declaration are the docstring above it and the tactic block below it.

**It is the record's own system.** `Msys_quadForm`, proved fifty lines above, gives `x ⬝ᵥ (Msys *ᵥ x) = 3/2 (Σ x²) - 3/10 (Σ x)²`, so the conclusion is the first form the file's header quotes from the [I104 working note](2026-09-14-I104-tau-positive.md), $t\ge\sum\beta_a^2+\tfrac32\sum\alpha_a^2-\tfrac3{10}(\sum\alpha_a)^2$, with the $\beta$ term on the side the note puts it. The link from the matrix to the note's coefficients is machine-checked in the same file rather than asserted.

**`lake env lean` on the file exits 0 with no diagnostic at all**, and no `declaration uses 'sorry'` warning, so nothing in it is sorried. `grep -n sorry` over the file returns nothing, in code or in prose.

**The hypotheses are simultaneously satisfiable, and I exhibited an object.** `Ge` is positive definite, its spectrum being $\{5/3,2/3,2/3\}$, so it has a Cholesky factor. Take $E=\mathbb R^6$, let $e_1,e_2,e_3$ be the rows of the factor sitting in the first three coordinates and $f_1,f_2,f_3$ the last three standard basis vectors. Then `heGram`, `hfOrthonormal` and `hef` hold exactly, and `hal`, `hbe` are definitions of `al` and `be` once $D$ is chosen. Over two thousand random $D$ the inequality holds with slack $-3.6\times10^{-15}$, which is equality to rounding, as it must be: $\mathrm{span}(e,f)=\mathbb R^6$ there. **The bound is therefore sharp and not merely true**, and strictness needs an $E$ of dimension above six with $D$ carrying a component off the span. **The theorem is not vacuous.**

**One correction to write.** The docstring at [I104GramSystem.lean:253](../lean/HamiltonsCubic/Results/I104GramSystem.lean) writes the competitor as `u = Σ (Msys ᵥ* al)_a e_a + Σ be_a f_a`, with `ᵥ*`, while the proof at line 267 sets `c := Msys *ᵥ al`. Those are `vecMul` and `mulVec`, and as written `Msys ᵥ* al` does not even typecheck, the notation taking a vector on its left. The two agree numerically because `Msys` is symmetric, so the mathematics is unaffected. Replace `ᵥ*` with `*ᵥ`.

**One overreach in the same docstring.** The new text says the retired description "names the STATEMENT correctly and the DIFFICULTY wrongly". The retired description named a **minimum**: "among vectors with prescribed inner products against a frame of Gram `G`, the least squared norm is the `G⁻¹` quadratic form of the prescribed values." What is typed is the inequality half of that. Attainment follows in one line, at $D=u$, and is not stated. Say "names the INEQUALITY correctly", or type the equality case.

## Claim 2, the axioms: CONFIRMED

`lake build HamiltonsCubic.Results.I104GramSystem` completes, then:

```
auditing 19 declarations across 1 files
19/19 clean -- resting on the standard three alone
```

**`joint_system_holds` is inside the 19**, and on the standard three alone:

```
HamiltonsCubic.I104GramSystem.joint_system_holds: ["Classical.choice", "Quot.sound", "propext"]
```

**And the audit's scope is the whole file.** The 19 names in the JSON table are exactly the file's 19 `theorem` declarations, with the two `noncomputable def`s (`Msys`, `Ge`) carrying no proof obligation. No theorem is outside the audit, so "19/19 clean" is a statement about everything in the file and not about a subset. No `sorryAx`, no `Lean.ofReduceBool`, no `native_decide` axiom.

## Claim 3, the mathematics of the completed square: CONFIRMED, and symmetry is not needed

Derived independently, from the hypotheses alone. Write $c=M\alpha$, $P=\sum_a c_ae_a$, $F=\sum_a\beta_af_a$.

| quantity | value | why |
|---|---|---|
| $\langle D,P\rangle$ | $\sum_a c_a\alpha_a$ | `hal`, one linear expansion |
| $\langle D,F\rangle$ | $\sum_a\beta_a^2$ | `hbe` |
| $\langle P,P\rangle$ | $\sum_{a,b}c_ac_b(G_e)_{ab}=c\cdot(G_ec)=c\cdot\alpha$ | `heGram`, then $G_eM=1$ gives $G_ec=\alpha$ |
| $\langle P,F\rangle$ | $0$ | `hef` |
| $\langle F,F\rangle$ | $\sum_a\beta_a^2$ | `hfOrthonormal` |

So $\langle D,u\rangle$ and $\lVert u\rVert^2$ both equal $c\cdot\alpha+\sum\beta^2$, and $0\le\lVert D-u\rVert^2=t-2(c\cdot\alpha+\sum\beta^2)+(c\cdot\alpha+\sum\beta^2)$ leaves exactly $\sum\beta^2+\alpha^{\mathsf T}M\alpha\le t$, since $c\cdot\alpha=\alpha\cdot(M\alpha)$ by definition of $c$. **The commit's sentence that both collapse to the same scalar is the reason the expansion closes, and it is right.**

**Does it need `Msys` symmetric? No, and the question is moot.** The only facts used about $M$ are $c=M\alpha$ and $G_eM=1$. The target $\alpha\cdot(M\alpha)$ is $\sum_ac_a\alpha_a$ by `mul_comm` on each summand, with no transpose taken anywhere. The one-sided use of `Ge_mul_Msys` is therefore correct and sufficient, and `Msys_mul_Ge` is not needed for this theorem. **Separately, `Msys` is symmetric**, visibly from `if i = j then 6/5 else -(3/10)`, and it could not be otherwise: $G_e$ is symmetric and invertible, and the inverse of such a matrix is symmetric, so $G_eM=1$ pins $M=G_e^{-1}$ uniquely and symmetrically.

The one place symmetry would be needed is the reading of $u$ as an orthogonal projection, which the proof does not use and does not claim.

## Claim 4, "no Bessel": CONFIRMED of the dependency, with a correction

**The proof cites no Bessel lemma and no projection.** Its Mathlib inputs are `real_inner_self_nonneg`, `inner_sum`, `sum_inner`, `real_inner_smul_left`, `real_inner_smul_right`, `real_inner_comm`, `real_inner_self_eq_norm_sq`, `Matrix.mulVec_mulVec` and `Matrix.one_mulVec`, plus `linarith` and `ring`. There is no `Orthonormal` anywhere in the file. So the dependency claim is exactly right, and "only that a norm-square is non-negative" is a fair description of the load-bearing step.

**The correction is about content rather than dependency.** Bessel's inequality for a finite orthonormal family is proved in precisely this way, by expanding $0\le\lVert x-\sum\langle x,e_i\rangle e_i\rVert^2$. What the file did is that argument with $G_e^{-1}\alpha$ in place of $\alpha$, at three vectors, written out. So "no Bessel is needed" is true as "no Bessel LEMMA is needed", and the honest gloss is the one the docstring nearly reaches: the debt was misfiled as a library gap when it was three lines of expansion. A reader who takes "No orthogonal projection and no Bessel" as saying the argument is of a different kind is being misled by one word. Prefer "no Bessel lemma, because the completed square IS Bessel's proof at three vectors".

## Claim 5, the $n=6$ table: CONFIRMED on the numbers, REFUTED on "TWICE"

**All three transcriptions are faithful**, checked against [ungraded-slack.md](../findings/ungraded-slack.md)'s three-witness table.

| item | the table | the fold | mine |
|---|---|---|---|
| $\mathbb{CP}^3$, $n=6$ | $\theta_0(6)=1.054092553$, three eigenvalues, $S=2\times10^{-30}$ | same | $\sqrt{40}/6=1.0540925534$, so the printed nine digits are right |
| Jensen's second Einstein metric on $S^3\times S^3$, $n=6$ | $\sqrt{6/5}=1.095445115$, three eigenvalues $\tfrac5{24},0,-\tfrac18$ at $3,7,5$ | same, verbatim | $\sqrt{1.2}=1.0954451150$, and the multiplicities sum to $15=\dim\Lambda^2\mathbb R^6$ and the spectrum is trace-free, $3\cdot\tfrac5{24}-5\cdot\tfrac18=0$ |
| $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ | line 89 of the same file | same | $\theta_0(6)=1.054092553$, and $\sqrt{6/5}>\theta_0(6)$ strictly |

**Criticality, which the refutation needs and the fold does not restate, holds for both**: $\mathbb{CP}^3$ at residual $5.1\times10^{-16}$ and Jensen's point at $3\times10^{-16}$, both recorded on the same page. **Gradedness is irrelevant here and is correctly not claimed**, so the record's standing rider that Jensen's entry "carries $S=0$ and nothing stronger" does not bite: the candidate quantifies over critical points, not over graded ones.

**REFUTED: "FALSE AT $n=6$, TWICE" holds only under a threshold the paragraph loosens without saying so.** Everywhere else the record states the candidate with a strict inequality: [W7](../findings/INDEX-traps.md) says "critical and above $\theta_0(n)$ survives it entirely", and the paragraph immediately above the new one in [diagonal-half.md](../findings/diagonal-half.md) says the same. The new paragraph writes it as "critical and $\theta\ge\theta_0(n)$ implies $s\le2$". $\mathbb{CP}^3$ sits **at** $\theta_0(6)$ exactly, so it falsifies the $\ge$ form and leaves the "above" form untouched. **Only Jensen's point refutes the candidate as the record had it.** Either say so, or change the candidate's statement to $\ge$ everywhere it appears and say that the change is being made.

*The tie is worth more than the paragraph makes of it, and in the other direction.* A critical point sitting exactly at $\theta_0(n)$ with three eigenvalues is the shape that would kill [I73](../plan.md) itself without refuting Conjecture A, since a second maximiser at the same value carries a three-value spectrum. That is what $\mathbb{CP}^3$ demonstrates is possible at all, and it is a sharper thing to have found than one more point above a threshold.

## Claim 6, the scoping: the call is RIGHT, the stated reason is the weak one, and the absence is oversold

**The restriction to $n\ge12$ is correct and is not too generous.** [plan.md](../plan.md) line 5 states Conjecture A for even $n\ge12$, so both witnesses are outside the goal's range as a matter of the problem statement.

**A counterexample at $n=6$ cannot propagate, and the record carries the construction that would have propagated it.** This is the part the entry should state and does not. [Lemma L164](../findings/stratum-two-negative.md) is padding, Gate 2 passed by [r739](REVIEW_r739.md) and [r740](REVIEW_r740.md) both PROVEN, and its step (iii) proves the operator identity $Q(\mathrm{pad}\,W')=\mathrm{pad}\,Q(W')$ outright, so padding carries norm, $\theta$ and criticality from $n=6$ to any larger $n$. **It fails to produce an $n\ge12$ witness for one reason: padding freezes $\theta$ while $\theta_0$ strictly increases.** $\tfrac{d}{dn}\theta_0(n)^2=\tfrac{6n-8}{n^3}>0$, and $\theta_0$ runs $1.0540926,\ 1.1456439,\ 1.2000000,\ 1.2360331$ at $n=6,8,10,12$. The padded copies sit at $1.0540926$ and $1.0954451$, both far below $\theta_0(12)$. That is a positive, checkable reason, and it is stronger than "both witnesses are $n=6$".

**And the $n=6$ failure is structurally uninformative, which makes "narrows the candidate" the wrong verb.** $\theta_0(n)=\sqrt{3/2}$ at $n=6+2\sqrt7=11.2915$, so below the crossover $\theta_0(n)<\sqrt{3/2}$ and $\theta_0$ is known not to be a ceiling: padded $W_{\mathbb{CP}^2}$ is critical at $\sqrt{3/2}=1.2247449$ at every $n\ge4$, above $\theta_0(n)$ at $n=4,6,8,10$, as [bispectral.md](../findings/bispectral.md) and [second-order.md](../findings/second-order.md) both record. **So at $n=6$ the clause $\theta\ge\theta_0(6)$ selects a mid-band rather than a near-extremal sliver**, and a threshold lemma was never going to hold there. Nothing was narrowed, because the candidate had no content below the crossover to lose. What the round actually establishes is that any proof of the restricted candidate must use $n\ge12$ essentially, since the statement is false without it, and that is worth writing down in place of the narrowing framing.

**REFUTED as reassurance: "the record holds no counterexample" at $n\ge12$ understates what the record holds.** [Post F43](../findings/bounds-relaxations.md), Gate 2 by [r343](REVIEW_r343.md) and [r344](REVIEW_r344.md), carries an $n=12$ spectrum with multiplicities $(30,20,16)$ and values $(-m,1.2m,0.375m)$, kernel-free, traceless, unit norm, **three distinct eigenvalues**, passing every per-row condition at $\theta=1.2917>\theta_0(12)=1.2360331$. [DERIVE-t11](DERIVE-t11.md) §5 says of it: "**Realisability is open.** No criterion for Weyl spectra exists in print." So the record holds no realised counterexample, which is a much weaker fact than the sentence conveys, and the named candidate falsifier is on the plan already as [I24a](../plan.md), waiting on approval for computation. The restricted candidate is not untested territory. It is one blocked linear programme away from a verdict.

**Two further reasons the absence carries little weight.** First, it is nearly forced: a realised critical point at even $n\ge12$ with $\theta>\theta_0(n)$ refutes Conjecture A outright, so its absence from the record is the conjecture being open and not evidence for the candidate. The only genuinely informative case is the boundary, $\theta=\theta_0(n)$ exactly with $s\ge3$, which is precisely the $\mathbb{CP}^3$ shape and which nothing on the record excludes at $n\ge12$. Second, [W7](../findings/INDEX-traps.md) was **not updated by this commit**, and still reads "critical and above $\theta_0(n)$ survives it entirely and is [I73](../plan.md)'s live candidate", with no mention of the $n=6$ failure and no restriction to $n\ge12$. The traps index is the file a new session reads first, so the correction landed in the two places a session reaches after it.

**Corrections to write.** Replace "The record's table carries no $n\ge12$ point at or above $\theta_0(n)$ with $s\ge3$" with the three facts that are true: no REALISED critical point does, [post F43](../findings/bounds-relaxations.md)'s $(30,20,16)$ spectrum at $n=12$ passes every per-row condition at $\theta=1.2917$ with realisability open, and [I24a](../plan.md) is the item that would decide it. Add the padding argument as the reason the $n=6$ witnesses stay at $n=6$. Update [W7](../findings/INDEX-traps.md) in the same change.

## Claim 7, the three folded lean-round notes: CONFIRMED, all three

Each checked against the file and the library rather than against the note. The diff is an append in every case, with nothing deleted.

**I67.** The Mathlib grep is right and I reproduced it at the commit the note names. [lake-manifest.json](../lean/lake-manifest.json) pins mathlib at `0df444a360eaa60ab8c11dca51a86af692955474`, the checkout's own `git log` agrees, and a case-insensitive grep for "pfaffian" over the whole `Mathlib/` tree returns **zero** hits. The fixed-dimension determinant lemmas are `det_fin_zero`, `det_fin_one`, `det_fin_two` and `det_fin_three`, and there is no `det_fin_four` or above. **The debt narrowing is right too**: `starWedge_of_pf` in [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) takes exactly `hPf : ∀ J, IsComplexStructure J → pf6 J = 1 ∨ pf6 J = -1` and nothing else, and the axiom audit puts `det_complex_structure` among the six clean declarations while `pf_sq_eq_det` and `pf6_complex_structure` carry `sorryAx`. So routing through $\mathrm{Pf}(X)^2=\det X$ is a choice, as the note says.

*One stale line the round did not catch, adjacent to its own finding.* [L193Statement.lean:166](../lean/HamiltonsCubic/Results/L193Statement.lean) still says `pf6 J = ±1` "follows from `Pf(X)^2 = det(X)` together with `det J = 1`. *Neither is typed in this layer.*" One of the two is now typed and proved, in a sibling file. Worth one word.

**L199.** `trace_comm_sq` is proved: the audit on `L199Statement` reports 5/9 clean and the four dirty names are `G_eq_sharp`, `trace_Gmat_weyl` and the two `native_decide` screens, so `trace_comm_sq` and `comm_isSymm_gen` are clean. The statement is $\lVert[A,R]\rVert^2=2\mathop{\mathrm{tr}}(ARAR)-2\mathop{\mathrm{tr}}(A^2R^2)$ at every size `m`, at skew `A` and symmetric `R`, which I rederived: $[A,R]$ is symmetric under those hypotheses, and cyclicity turns the two mixed terms into $\mathop{\mathrm{tr}}(A^2R^2)$ each. **The reduction to two $R$-free sums is right**: `Gmat R` has entries $\mathop{\mathrm{tr}}((\mathrm{ad}_jR-R\,\mathrm{ad}_j)^{\mathsf T}(\mathrm{ad}_kR-R\,\mathrm{ad}_k))$, so its trace is $\sum_j\lVert[\mathrm{ad}_j,R]\rVert^2$, and `trace_comm_sq` turns that into $2\sum_j\mathop{\mathrm{tr}}(\mathrm{ad}_jR\,\mathrm{ad}_jR)-2\mathop{\mathrm{tr}}((\sum_j\mathrm{ad}_j^2)R^2)$. The first contracts $R\otimes R$ against $\sum_j\mathrm{ad}_j\otimes\mathrm{ad}_j$, the second against the $6\times6$ rational matrix $\sum_j\mathrm{ad}_j^2$, and neither sum mentions $R$. **The stale provenance line is where the note says**, at [L199Statement.lean:171](../lean/HamiltonsCubic/Results/L199Statement.lean), reading "*verified on forty random symmetric `R` over `ℚ`*", and [r1046](REVIEW_r1046.md)'s claim 3 reads "CONFIRMED, and now DERIVED rather than fitted" word for word.

*One thing the note presents as a finding that the file already says.* `trace_comm_sq`'s own docstring already names both structure sums and already says the thirty-thousand-term expansion "is what this avoids". The round's contribution is the classification, not the observation.

**L144.** The file's docstring concedes exactly what the note quotes, at [L144Statement.lean:265](../lean/HamiltonsCubic/Results/L144Statement.lean): "the record states the bound as proved but gives the argument only in outline, eigenvalue coordinates ... and a final inequality affine in `μ`, so it is not reconstructible from the block". `primitive_thetaSq_lt_quarter` is the `sorry`, confirmed by the audit, which also shows three further declarations inheriting it. **And the buckets really have no slot**: [lean-loop/SKILL.md](../.claude/skills/lean-loop/SKILL.md) offers `ready`, `blocked on <piece>` and `out`, where `<piece>` is "one named piece of the base layer" and `out` is "library machinery that does not exist". A gap in the record's own argument is neither. [Proposal 164](../.claude/skill-proposals.md) exists and was filed in an earlier commit, so the citation is good.

## Claim 8, overreach sweep: REFUTED, three defects

**(a) [plan.md](../plan.md)'s "Both thresholds tried are dead below $n=12$" is FALSE, and it is a regression.** $\sqrt{3/2}$ dies **at** $n=12$, not below it: $S^5\times S^7$ is critical at $n=12$ with $\theta=1.2282390>\sqrt{3/2}=1.2247449$ and three distinct eigenvalues, which is the whole content of [W7](../findings/INDEX-traps.md) and is inside the conjecture's range. The sentence the commit replaced said this correctly: "**And $\sqrt{3/2}$ is the WRONG threshold** ([W7]), dead at $S^5\times S^7$". The new sentence also cites [W7](../findings/INDEX-traps.md), which says the opposite of what it is cited for. Correct it to "$\sqrt{3/2}$ is dead at $n=12$, and $\theta_0(n)$ is dead below $n=12$".

**(b) "the two witnesses sit two rows above the $S^5\times S^7$ one" is wrong for one of the two.** In the three-witness table $\mathbb{CP}^3$ is two rows above $S^5\times S^7$ and Jensen's point is one row above. Small, and it is the kind of number a reader checks first.

**(c) The [lean/INDEX.md](../lean/INDEX.md) I104 row deplores a drift it is still carrying.** The row now reads, in order: "**AND `joint_system_holds` IS NOW TYPED**, with a named `sorry`" ... "**`joint_system_holds` IS PROVED, 2026-09-21, and the file now carries NO `sorry`**" ... "**Two docstrings still announcing the `sorry` were corrected in the same change**, since a discharged debt that still reads as owed is the drift this layer keeps paying for." The appended sentence names the defect three clauses after leaving an instance of it in the same cell. Retire the "IS NOW TYPED, with a named `sorry`" clause. The two appends also join without a full stop, in this row and in the I67 one, which is what makes the stale clause read as continuous with the new one.

**What survives the sweep.**

| claim | verdict |
|---|---|
| "axiom_audit reports 19/19 clean on the standard three" | **CONFIRMED**, reproduced |
| "the file now carries NO `sorry`" | **CONFIRMED**, no warning on elaboration, no occurrence in the source |
| "two docstrings still announcing the `sorry` are corrected in the same change" | **CONFIRMED** in effect. One of the two is a `/-! -/` section comment rather than a docstring, and after the change the string `sorry` occurs nowhere in the file |
| "$\theta_0(6)$ re-derived from $\sqrt{2(n-1)(n-2)}/n$ and matched to the table's own printed value" | **CONFIRMED**. $\sqrt{40}/6=1.0540925533895$ against the table's $1.054092553$ |
| "cross terms die by `hef`, and both $\langle D,u\rangle$ and $\lVert u\rVert^2$ collapse" | **CONFIRMED**, derived independently under claim 3 |
| "five attempts changed only tactics, never the argument" | **UNVERIFIABLE from the record**, and it should be labelled a self-report. No attempt log for this round is committed anywhere in [agent_logs/](../agent_logs/) or [reviews/](.), so nothing outside the session can check it. The claim it is standing in for, that the derivation preceded the tactics, is supported indirectly: the final proof uses no search tactic and no `nlinarith`, only named rewrites and a closing `linarith` |
| `Deliverable: derivation` | **CONFIRMED** for the headline. The same commit also carries a refutation, and a second cycle would have been the cleaner shape |

**One pre-existing defect the commit inherits rather than causes.** The I104 row's status cell read `**proved**` at `7860c4b0`, while the file carried a `sorry` at `joint_system_holds`. The commit makes the cell true without noticing it had been false. Since the row is the record of what the layer holds, a `sorry` in the file and `proved` in the cell is the same drift the commit's own closing sentence describes.
