# REVIEW r873: does [L203DualBound.lean](../lean/HamiltonsCubic/Results/L203DualBound.lean) say what the I77 dual block claims, and did the $p=2$ correction land everywhere?

*Reviewer r873, single-act round. This was a comparison of a machine-checked file against the prose it is supposed to carry, plus one correction checked against the places that carried the old reading. **No mathematics of the dual bound was re-derived**: the LP-duality step, the minimax reduction and the general-$p$ witness are a separate round's business and were taken as given. What was done here is reading, building, `#print axioms`, and one exact-arithmetic **screen** of the four dual functions at $p=2$, in seconds, on objects constructed for the screen and reported as a screen. In the tables below, `√3` abbreviates the file's `Real.sqrt 3` and everything else is quoted verbatim. Log: [agent_logs/review-r873-leancheck.log](../agent_logs/review-r873-leancheck.log).*

## The claim table

| # | The Lean statement | The prose claim | Agree? |
|---|---|---|---|
| 1a | [dual_n4_unit_norm](../lean/HamiltonsCubic/Results/L203DualBound.lean#L28): `2 * (1 / √3) ^ 2 + 4 * (-(1 / (2 * √3))) ^ 2 = 1` | the balanced product's spectrum at $n=4$ has unit norm | **YES**, exactly |
| 1b | [dual_n4_trace_free](../lean/HamiltonsCubic/Results/L203DualBound.lean#L35): `2 * (1 / √3) + 4 * (-(1 / (2 * √3))) = 0` | and is trace-free | **YES**, exactly |
| 1c | nothing | the multiplicities are $p(p-1)=2$ and $p^2=4$, and the values are $1/\sqrt3$ and $-1/(2\sqrt3)$ *because* $D^2=(p-1)(2p-1)$ at $p=2$ | **NOT TYPED.** The multiplicities enter as the literal coefficients $2$ and $4$ and the eigenvalues as literals. Nothing connects them to $p=2$ |
| 2 | [dual_n4_bound_eq_theta0](../lean/HamiltonsCubic/Results/L203DualBound.lean#L44): `2 * (1/√3)^3 + 4 * (-(1/(2*√3)))^3 + 12 * (1/(12*√3)) = √3 / 2` | at $z=1/4$, $y=1/(12\sqrt3)$ the bound $\sum_\alpha\lambda_\alpha^3+(n-2)Ny$ equals $\theta_0(4)=\sqrt3/2$ | **YES on the arithmetic.** Three interpretive steps stay outside: $12$ is a literal and not $(n-2)N$, $\sqrt3/2$ is a literal and not $\theta_0(4)$, and $z$ does not occur in the statement at all |
| 3a | [dual_n4_within_active](../lean/HamiltonsCubic/Results/L203DualBound.lean#L55): `(1/√3)^3 - (1/4)/3 * (3 * (1/√3)) = 1/(12*√3)` | "the all-within triple is ACTIVE at the witness" | **ARITHMETIC YES, LABEL VOID.** The identity is exact. The all-within class is empty at $p=2$, so no constraint of the programme is being met with equality here |
| 3b | [dual_n4_cross_active](../lean/HamiltonsCubic/Results/L203DualBound.lean#L64): `(-(1/(2*√3)))^3 - (1/4)/3 * (3 * (-(1/(2*√3)))) = 1/(12*√3)` | "the all-cross triple is active too, the second of the three coincidences" | **YES**, and this is one of the two genuinely active constraints. The words "of the three coincidences" carry the retracted reading |
| 3c | nothing | the correction's genuinely active partner, the one-within-two-cross triple | **ABSENT.** The file types no theorem for the class that actually binds at $p=2$ |
| 4a | [dual_balanced_collapses](../lean/HamiltonsCubic/Results/L203DualBound.lean#L81): for real `p ≠ 0`, `D ≠ 0`, `D^2 = (p-1)*(2*p-1)`, `1/(p*D) + (2*p-3)/D = D/p` | the bound $1/(pD)+(2p-3)/D$ is $D/p$ | **YES**, and wider than claimed: it holds for every real pair, integer $p\ge2$ never being assumed |
| 4b | [theta0_eq_D_div_p](../lean/HamiltonsCubic/Results/L203DualBound.lean#L88): for `0 < p`, `0 ≤ D`, `D^2 = (p-1)*(2*p-1)`, `√(2*(2*p-1)*(2*p-2))/(2*p) = D/p` | $\theta_0(2p)=D/p$, so the agreement is an identity in $p$ | **YES.** $\sqrt{2(n-1)(n-2)}/n$ at $n=2p$ is exactly the left side, so the formula is $\theta_0$ and not a lookalike |
| 4c | nothing | $y=(2p-3)/(2pD^3)$ and $(n-2)N=2p(p-1)(2p-1)$ together turn the second term into $(2p-3)/D$ | **NOT TYPED.** [dual_balanced_collapses](../lean/HamiltonsCubic/Results/L203DualBound.lean#L81) begins at $(2p-3)/D$, so the one step that consumes the witness is prose |

**One line.** Every arithmetic claim the block makes about $n=4$ and about general $p$ is exactly what the file proves, the file builds clean and carries no gap axiom, and the correction's reading of $p=2$ is right, but the retracted reading is still asserted in five places: three of them inside the machine-checked file itself, one in the index row, and one in the block's own earlier blockquote.

## 1. Does each theorem state the claim it is named for?

**Six of the seven do. The seventh, [dual_n4_within_active](../lean/HamiltonsCubic/Results/L203DualBound.lean#L55), states a true identity under a name that the correction has emptied.** The table above pairs each statement with its prose. Three observations that the table compresses.

**Every theorem in the file is an EQUALITY.** Not one inequality is typed anywhere, so nothing in the file asserts that $\theta$ is at most anything. [dual_n4_bound_eq_theta0](../lean/HamiltonsCubic/Results/L203DualBound.lean#L44) evaluates an expression, and the reader supplies the fact that the expression bounds $\theta$. This is a stronger statement of the index row's "the dual inequality is not typed", and it is the single largest distance between the file and the block.

**The word ACTIVE is doing work the statements cannot do.** [dual_n4_within_active](../lean/HamiltonsCubic/Results/L203DualBound.lean#L55) and [dual_n4_cross_active](../lean/HamiltonsCubic/Results/L203DualBound.lean#L64) are numeric identities of the form $f(\text{eigenvalue triple})=y$. Nothing in either statement says which triple class it belongs to, that the class is nonempty, that the value is the maximum over classes, or that the constraint is one the programme imposes. Activity is a property of the constraint set, and the constraint set is not typed, so activity is prose in both cases.

**The general theorems are correctly and harmlessly wider than the block.** [dual_balanced_collapses](../lean/HamiltonsCubic/Results/L203DualBound.lean#L81) is a real-variable identity: $1/(pD)+(2p-3)/D=(1+p(2p-3))/(pD)=(2p-1)(p-1)/(pD)=D^2/(pD)=D/p$, using nothing about $p$ beyond the hypothesis. [theta0_eq_D_div_p](../lean/HamiltonsCubic/Results/L203DualBound.lean#L88) needs $0\le D$ to take the root, and it has it. For $p$ in $(1/2,1)$ the hypothesis $D^2=(p-1)(2p-1)$ is unsatisfiable over the reals, so the statement is vacuous there rather than false.

## 2. Build and axioms

**Builds clean, and all nine declarations are gap-free.**

```
lake build HamiltonsCubic.Results.L203DualBound
Build completed successfully (3006 jobs).
```

`#print axioms` on all nine declarations, the two private helpers included, run against a copy of the file so the private names resolve:

| Declaration | Axioms |
|---|---|
| [sqrt3_sq](../lean/HamiltonsCubic/Results/L203DualBound.lean#L23), [sqrt3_pos](../lean/HamiltonsCubic/Results/L203DualBound.lean#L25) | `propext`, `Classical.choice`, `Quot.sound` |
| [dual_n4_unit_norm](../lean/HamiltonsCubic/Results/L203DualBound.lean#L28), [dual_n4_trace_free](../lean/HamiltonsCubic/Results/L203DualBound.lean#L35), [dual_n4_bound_eq_theta0](../lean/HamiltonsCubic/Results/L203DualBound.lean#L44) | `propext`, `Classical.choice`, `Quot.sound` |
| [dual_n4_within_active](../lean/HamiltonsCubic/Results/L203DualBound.lean#L55), [dual_n4_cross_active](../lean/HamiltonsCubic/Results/L203DualBound.lean#L64) | `propext`, `Classical.choice`, `Quot.sound` |
| [dual_balanced_collapses](../lean/HamiltonsCubic/Results/L203DualBound.lean#L81), [theta0_eq_D_div_p](../lean/HamiltonsCubic/Results/L203DualBound.lean#L88) | `propext`, `Classical.choice`, `Quot.sound` |

**Exactly which carry a gap axiom: none.** The three standard Lean axioms are all that appear. No `sorryAx`, which is the repository's marker for an unfinished statement and does appear elsewhere, for instance at `HamiltonsCubic.L42Statement.sharp_dual_weight`. No `native_decide` axiom either, which is the repository's other gap marker. The file contains no occurrence of the string `sorry`. **So the block's "machine-checked in exact arithmetic and carries no gap axiom" and the index row's "nothing carries a gap axiom" are both accurate.**

*One nit, not a defect of any claim.* [lean/axioms.json](../lean/axioms.json) is dated 2026-09-09 and contains none of these nine names, so the audit artefact is stale with respect to this file. Nothing over-credits it: the gap-free claim is checkable directly and I checked it that way. This is the same staleness [r813](REVIEW_r813.md) recorded for a different commit.

## 3. Is the file in the root import?

**Yes.** [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean#L472) has `import HamiltonsCubic.Results.L203DualBound` as its last line, one line after the L202 import. [lakefile.toml](../lean/lakefile.toml) sets `defaultTargets = ["HamiltonsCubic"]` and the library's root is that file, so a plain `lake build` compiles L203. The file is not orphaned.

## 4. The correction, and whether the file and the index row are consistent with it

**The correction's reading is CONFIRMED, and the emptiness needs no geometry.** The $\lambda_+$ level set at $p=2$ has multiplicity $p(p-1)=2$, which the file itself types as the coefficient $2$ in [dual_n4_unit_norm](../lean/HamiltonsCubic/Results/L203DualBound.lean#L28). The dual constraint is imposed "at every triple of distinct indices", so the all-within constraint is indexed by three distinct members of a two-element set. There are none. **The class is empty, the constraint does not exist, and imposing it can only shrink the feasible $(y,z)$ set and so raise the bound.** The block's phrasing by way of "only two within-factor planes" is the same fact stated geometrically, one within-plane per $S^2$ factor.

**Screen of the four classes at $p=2$**, with $P=1/\sqrt3$, $Q=1/(2\sqrt3)$, $P=2Q$, and $f_S(z)=\prod\lambda-\tfrac z3\sum\lambda$. Exact symbolic arithmetic, constructed for this screen, reported as a screen.

| Class | Exists at $p=2$? | $f_S(z)$ | $f_S(1/4)$ |
|---|---|---|---|
| all-within $(+,+,+)$ | **NO**, needs 3 distinct indices in a level set of size 2 | $\sqrt3(1-3z)/9$ | $\sqrt3/36=y$ |
| two-within-one-cross $(+,+,-)$ | yes | $-\sqrt3(3z+1)/18$ | $-7\sqrt3/72$, strictly below |
| one-within-two-cross $(+,-,-)$ | yes | $\sqrt3/36$, **constant in $z$** because $P-2Q=0$ | $\sqrt3/36=y$ |
| all-cross $(-,-,-)$ | yes | $\sqrt3(12z-1)/72$ | $\sqrt3/36=y$ |

**This confirms every part of the correction and sharpens one clause.** Three functions do meet $y=1/(12\sqrt3)=\sqrt3/36$ at $z=1/4$, which is what the first pass saw, and one of the three is the empty class. Dropping the empty one leaves $\max\{f_{++-},f_{+--},f_{---}\}$, whose value is $\sqrt3/36$ for every $z$ in $[-1/2,1/4]$ and larger outside it, because $f_{+--}$ is constant at exactly $y$ while the other two cross that level at the endpoints. **So $y$ is unchanged and $z=1/4$ remains optimal, which is what the block says.** The clause worth sharpening: $z=1/4$ loses its uniqueness and becomes the right endpoint of a flat optimal interval, the minimax being attained on a segment rather than at a point. The block's "changes neither $z=1/4$ nor $y$" is true as written and could be read as claiming a unique witness survives.

**The genuinely active pair at the witness is one-within-two-cross and all-cross**, exactly as the block's correction states. And the general witness specialises correctly: $z=\tfrac32P(P-Q)=3Q^2=1/4$ and $y=\tfrac12P^2(3Q-P)=\tfrac16\cdot\tfrac1{2\sqrt3}=1/(12\sqrt3)$, and $(2p-3)/(2pD^3)$ at $p=2$, $D=\sqrt3$ is $1/(12\sqrt3)$ too. Three routes to the same $y$.

**Consistency of the file with the correction: THREE PLACES FAIL.**

1. [The header docstring, line 14](../lean/HamiltonsCubic/Results/L203DualBound.lean#L14): "that the all-within triple is an ACTIVE constraint at that witness, which is what makes the bound tight rather than merely valid". At $n=4$ there is no all-within triple, and tightness comes from the bound equalling $\theta_0(4)$ at a realised tensor.
2. [The docstring of dual_n4_within_active, line 52](../lean/HamiltonsCubic/Results/L203DualBound.lean#L52): "The all-within triple is ACTIVE at the witness" and "the bound cannot be improved by lowering $y$ alone". The first clause names a triple that does not exist. The second is true, but for the other two classes, not this one.
3. [The docstring of dual_n4_cross_active, line 62](../lean/HamiltonsCubic/Results/L203DualBound.lean#L62): "the second of the three coincidences". Three functions do coincide, so this is defensible as arithmetic, but in context it reads as three active constraints, which is the retracted claim.

**And one omission.** The class that genuinely binds at $p=2$, one-within-two-cross, has no theorem. It is a one-line addition, $P Q^2 = y$, and it would carry the corrected reading where the file currently carries the old one.

**Consistency of the index row: it FAILS.** [lean/INDEX.md, the I77 dual row](../lean/INDEX.md#L101) says "[dual_n4_within_active](../lean/HamiltonsCubic/Results/L203DualBound.lean#L55) and [dual_n4_cross_active](../lean/HamiltonsCubic/Results/L203DualBound.lean#L64) show the all-within and all-cross triples are ACTIVE at $z=1/4$, which is what makes the bound tight rather than merely valid". That is the pre-correction sentence verbatim, and the row is what a reader consults to learn what the file establishes.

## 5. Does anything still assert the old reading?

**Yes, in two documents beyond the Lean file.**

- [lean/INDEX.md#L101](../lean/INDEX.md#L101), as quoted in section 4.
- [findings/diagonal-half.md#L1256](../findings/diagonal-half.md#L1256), twice in one blockquote: "the three active functions meet at $z=1/4$" and, in its closing sentence, "the all-within and all-cross triples both ACTIVE at $z=1/4$". The correction sits at [#L1260](../findings/diagonal-half.md#L1260), four blockquotes later, and does not amend the earlier text.

**On the second half of the question, whether anything still calls the agreement numerical.** [#L1256](../findings/diagonal-half.md#L1256) reports the two dimensions as near-misses, "$0.8659$ against $\theta_0(4)=\sqrt3/2=0.86603$" and "$1.2362$ against $\theta_0(12)=1.236033$", and closes "Both agree, and the symbolic identity below shows the agreement is exact at every even $n$". The forward reference rescues the framing, but **both figures are rounding slips and both understate an exact identity**. With $y=1/(12\sqrt3)$ the $n=4$ total is $0.2886751+0.5773503=0.8660254$, which is $\sqrt3/2$ to every digit shown, not $0.8659$. At $n=12$ the total is $0.0224733+1.2135576=1.2360331$, which is $\theta_0(12)=1.2360331$, not $1.2362$. The $n=12$ figure inherits its error from rounding $y$ up to $0.001839$ before multiplying by $660$. **So the one place in the record that reads as a numerical near-agreement is reading its own rounding.** No search elsewhere in the record found another carrier: [results.md](../results.md) and [findings/INDEX.md](../findings/INDEX.md) have no row for the dual bound, and [plan.md](../plan.md)'s I77 rows describe the LP item without mentioning the witness.

## 6. Are the block's figures the values the file proves?

**Every one of them, with two rounding slips already named and one third-decimal slip in $z$ at $p=6$.** Each row below was checked against the file's literals and, where the file has no literal, by exact arithmetic.

| Figure in the block | Status | Where |
|---|---|---|
| $y=1/(12\sqrt3)$ | **agrees.** The file's literal is `1/(12*√3)`, and $y=\sqrt3/36=0.0481125$ | [#L57](../lean/HamiltonsCubic/Results/L203DualBound.lean#L57), [#L46](../lean/HamiltonsCubic/Results/L203DualBound.lean#L46) |
| $y=0.04811$ | agrees to the digits shown | [#L1256](../findings/diagonal-half.md#L1256) |
| $z=1/4$ | **agrees.** The file's literal is `(1/4 : ℝ)` in both activity theorems | [#L56](../lean/HamiltonsCubic/Results/L203DualBound.lean#L56), [#L65](../lean/HamiltonsCubic/Results/L203DualBound.lean#L65) |
| $\theta_0(4)=\sqrt3/2=0.86603$ | **agrees**, and is the file's right-hand side. $\sqrt{2\cdot3\cdot2}/4=\sqrt3/2$ | [#L47](../lean/HamiltonsCubic/Results/L203DualBound.lean#L47) |
| $\sum_\alpha\lambda_\alpha^3=1/(2\sqrt3)=0.2887$ | **agrees.** $2P^3-4Q^3=1/(2\sqrt3)$, and it is $1/(pD)$ at $p=2$ | [#L42](../lean/HamiltonsCubic/Results/L203DualBound.lean#L42) |
| $\theta\le0.2887+2\cdot6\cdot0.04811=0.8659$ | **the sum is wrong in its last digit.** $2\cdot6=(n-2)N=12$ is right and matches the file's `12`, and the total is $0.8660254$, exactly $\theta_0(4)$ | [#L1256](../findings/diagonal-half.md#L1256) |
| $(2p-3)/(2pD^3)$ | **agrees** as the general $y$: it is $1/(12\sqrt3)$ at $p=2$, $0.0018387$ at $p=6$. **Not typed** | [#L74](../lean/HamiltonsCubic/Results/L203DualBound.lean#L74) docstring only |
| $(n-2)N=2p(p-1)(2p-1)$ | **agrees.** $N=p(2p-1)$ and $n-2=2(p-1)$, giving $12$ at $p=2$ and $660$ at $p=6$. **Not typed**, the $12$ being a bare literal | [#L74](../lean/HamiltonsCubic/Results/L203DualBound.lean#L74) docstring only |
| $(n-2)N\cdot y=(2p-3)/D$ | **agrees**, since $2p(p-1)(2p-1)/(2pD^3)=D^2/D^3$. **Not typed** | prose |
| $n=12$ figures $z=0.004544$, $y=0.001839$, $0.02248$ | $y$ and $\sum\lambda^3$ agree to the digits shown. **$z$ is $1/220=0.0045455$**, so $0.004544$ is wrong in the sixth decimal | [#L1256](../findings/diagonal-half.md#L1256) |
| $\theta\le1.2362$ against $\theta_0(12)=1.236033$ | **the total is $1.2360331$, equal to $\theta_0(12)$**. The $1.2362$ comes from rounding $y$ up before multiplying by $660$ | [#L1256](../findings/diagonal-half.md#L1256) |
| $\theta_0(2p)=\sqrt{2(2p-1)(2p-2)}/(2p)$ | **agrees** with the record's $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ at $n=2p$, and is the file's left-hand side | [#L90](../lean/HamiltonsCubic/Results/L203DualBound.lean#L90) |

*One notation nit inside the file.* [The docstring at line 63](../lean/HamiltonsCubic/Results/L203DualBound.lean#L63) writes the cubed term as $(-\lambda_-)^3$, while the statement computes $\lambda_-^3$ with $\lambda_-=-1/(2\sqrt3)$. The statement is the correct one for the constraint. The docstring is using $\lambda_-$ for the magnitude, which is the opposite convention to the header's.

## 7. What the file does not type that the block claims

**The index row names three omissions and all three are real.** The dual inequality is not typed over all triples, the derivation of $y$ and $z$ from the active pair is prose, and the reduction from the programme to the minimax is prose. **Seven more belong on that list**, and a reader who relies on the row will otherwise over-credit the file.

1. **No inequality occurs in the file at all**, so nothing typed is a bound on $\theta$. Every theorem is an equality between numbers.
2. **$\theta_0$ is never defined.** $\sqrt3/2$ in [dual_n4_bound_eq_theta0](../lean/HamiltonsCubic/Results/L203DualBound.lean#L44) is a literal, and the file never instantiates [theta0_eq_D_div_p](../lean/HamiltonsCubic/Results/L203DualBound.lean#L88) at $p=2$ to connect the two. The name alone asserts that the right-hand side is $\theta_0(4)$.
3. **The two general theorems are not chained.** Nothing states that the bound equals $\theta_0(2p)$, which is claim 4 as the block makes it. The reader composes [dual_balanced_collapses](../lean/HamiltonsCubic/Results/L203DualBound.lean#L81) with [theta0_eq_D_div_p](../lean/HamiltonsCubic/Results/L203DualBound.lean#L88) by hand.
4. **$(n-2)N=2p(p-1)(2p-1)$ is not typed**, and neither is $N=n(n-1)/2$. The $12$ at $n=4$ is a literal with no provenance in the file.
5. **$y=(2p-3)/(2pD^3)$ is not typed**, so the step that consumes the dual witness at general $p$ is prose. [dual_balanced_collapses](../lean/HamiltonsCubic/Results/L203DualBound.lean#L81) starts after it.
6. **The general spectrum is not typed.** $P=1/D$ with multiplicity $p(p-1)$ and $-Q$ with $Q=(p-1)/(pD)$ and multiplicity $p^2$, together with its unit norm and trace-freeness at general $p$, appear only at $p=2$ and only as literals.
7. **Nothing states that the remaining classes sit strictly below at the witness**, at $n=4$ or at general $p$. Without that, no theorem in the file distinguishes a maximum over classes from one value among several, which is precisely the distinction the correction turns on. **This is the omission that let the retracted reading into the docstrings**, and it is also the cheapest to repair: the two remaining classes at $n=4$ are $-7\sqrt3/72$ and the constant $\sqrt3/36$, both one-line facts.

*Also absent, and correctly so, since the block claims no machine check for them*: the $n=12$ arithmetic, the emptiness of the all-within class at $p=2$, and any notion of triple class or of the programme's constraint set.

## Verdict

**CONFIRMED ON THE ARITHMETIC, AND THE ACTIVITY LABELS ARE STALE IN FIVE PLACES.**

- **The file is sound and gap-free.** It builds, all nine declarations rest on `propext`, `Classical.choice` and `Quot.sound` alone, and it is in the root import so a plain `lake build` compiles it. Every literal in it matches the block.
- **The correction is right.** The all-within class is empty at $p=2$ because the $\lambda_+$ level set has two members, the constraint there is vacuous, and dropping it changes neither $y$ nor the optimality of $z=1/4$. It does cost $z=1/4$ its uniqueness, the minimax being attained on $[-1/2,1/4]$.
- **Five locations still assert the retracted reading**: [L203DualBound.lean#L14](../lean/HamiltonsCubic/Results/L203DualBound.lean#L14), [#L52](../lean/HamiltonsCubic/Results/L203DualBound.lean#L52) and [#L62](../lean/HamiltonsCubic/Results/L203DualBound.lean#L62), [lean/INDEX.md#L101](../lean/INDEX.md#L101), and [findings/diagonal-half.md#L1256](../findings/diagonal-half.md#L1256) twice. Three of the five are inside the machine-checked file, which is where a reader is least likely to doubt them.
- **Two figures in the block understate exact identities as near-misses**, $0.8659$ for $0.8660254$ and $1.2362$ for $1.2360331$, both rounding artefacts, and $z=0.004544$ at $p=6$ should be $0.0045455$.
- **One theorem is owed**: the one-within-two-cross class, which is what actually binds at $p=2$, has no statement, while the class that does not exist has two sentences of docstring calling it active.
