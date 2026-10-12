# Review r1058: the Jin 2026 route for I106b, checked against F72, the source and the Lean file

Sole reviewer, comparison round. Every finding below is labelled for reach: **one file** or **the route as a whole**. Log: [agent_logs/r1058-i106b-route.log](../agent_logs/r1058-i106b-route.log).

| claim | subject | verdict |
|---|---|---|
| A | Jin Theorem 1(iii) is a second-variation statement and so clears the fence post | **REFUTED as implemented**, and the post is misnamed |
| B | the remaining gap is ONE named implication, and it is exactly the weight | **REFUTED**, a second gap exists and it points against the route |
| C | [MaxValueForcesFourthPeak](../lean/HamiltonsCubic/Results/I106bFace.lean) is correctly a `def` because the record has no reason to believe it | **REFUTED**, the proposition is FALSE for the record's own A |
| D | [isSignedPerm_of_maxValue](../lean/HamiltonsCubic/Results/I106bFace.lean) is faithful and is the rung the item wants | **SPLIT**: faithful to itself, CONFIRMED. The rung, REFUTED, and it is vacuous |

## A brief defect that must be fixed before anything else: the post is F69, not F72

**Reach: three files, named individually.** The requirement quoted as Premise 1, *"Any proposed maximality input phrased as a condition on $A$ or $C$ is checked by substituting that field's Lagrange form before it is counted as an input ... A genuine input must see the second variation or the value"*, is [post F69](../findings/fence-posts.md) (heading at line 548, the quoted sentence at line 568). [Post F72](../findings/fence-posts.md) begins at line 604 and its own *"What a successor must clear"* reads *"A mechanism that does not route through vertices of a Birkhoff polytope, or a reason the maximum over the joint image lands on a splitting frame without landing on a permutation pair."*

The miscitation is in the committed work, not only in the brief:

| location | text | status |
|---|---|---|
| [plan.md:66](../plan.md) | "clears [post F72]" | **wrong, it is F69** |
| [plan.md:98](../plan.md) | "it clears [post F72]'s bar that a maximality input must see the second variation or the value" | **wrong, it is F69** |
| [I106bFace.lean:758](../lean/HamiltonsCubic/Results/I106bFace.lean) | "[Post F72] requires a maximality input to SEE the second variation or the value" | **wrong, it is F69** |
| [I106bFace.lean:42](../lean/HamiltonsCubic/Results/I106bFace.lean) | "R28's rung is the coupled pair and is untouched, per [post F72]" | **correct** |

The two citations in one Lean file point at different posts and only one is right, so this is a mis-target rather than a renumbering.

## CLAIM A, REFUTED as implemented

**Reach: the route as a whole for A2, one file for A3.**

**A1, the bar belongs to F69.** Corrected above. The substance of the bar survives the correction, so A is graded against F69's wording.

**A2, part (iii) enters no declaration.** The Lean chain from the second-order condition to a signed permutation is `SecondOrderMax` → `MaxValueForcesFourthPeak` → `JinFourthPeak` → `IsSignedPerm`. [JinFourthPeak](../lean/HamiltonsCubic/Results/I106bFace.lean) is part **(i)** and nothing else. The file says so in capitals at line 766, *"WHAT IS TYPED HERE IS PART (i), WHICH IS ALGEBRAIC, AND NOT (ii) OR (iii)"*. Part (iii), the only clause of Theorem 1 that is a second-variation statement, is cited in [plan.md](../plan.md) and appears in no proposition anywhere.

**So the second-variation content the route actually carries is [SecondOrderMax](../lean/HamiltonsCubic/Results/I106bFace.lean), which is the record's own object**, confirmed by [r1048](REVIEW_r1048.md) and [r1049](REVIEW_r1049.md) before Jin was read. Jin contributes nothing to clearing F69's bar in the implemented route.

**A3, and the one Jin item that does enter is not external.** [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) at line 745 says part (i) and its equality case *"follow from the identity below together with orthonormality and are reached here rather than imported"*, and [lean/INDEX.md](../lean/INDEX.md)'s I106b row repeats it. The two halves are already proved in the file, [row_offdiag_eq_sq_sub_quartic](../lean/HamiltonsCubic/Results/I106bFace.lean) and [isSignedPerm_of_rows_disjoint](../lean/HamiltonsCubic/Results/I106bFace.lean). Yet [JinFourthPeak](../lean/HamiltonsCubic/Results/I106bFace.lean)'s docstring reads *"carried as a hypothesis because it is an EXTERNAL result"*, which contradicts both. Part (i) is one line from the rows being unit vectors: $\sum_l q_{il}^4 \le (\sum_l q_{il}^2)^2 = 1$ per row, with equality exactly when the row has one nonzero entry.

**Correction.** The route as DESCRIBED in [plan.md](../plan.md) would clear F69's bar, because (iii) is a second-variation statement. The route as IMPLEMENTED clears nothing, because it uses only a fact the file proves itself. The regrade of `attackable` from 1 to 2 rests on (iii), so it rests on a clause no declaration reaches.

## CLAIM B, REFUTED: the second gap is the weight's DERIVATIVE, and it points the wrong way

**Reach: the route as a whole.** The gap is not the weight alone. Freezing the weight changes the Hessian, and it changes it in the direction that breaks the implication the item names.

Write $X = \sum_{ij} q_{ij}^2 (Q\Omega)_{ij}^2 \ge 0$, $T = \operatorname{tr}(Q^{\mathsf T}Q^{\circ3}\,\Omega^2)$, and $S = Q^{\mathsf T}(A\circ Q)$.

- **Our objective, weight frozen.** The file's own derivation gives $\tfrac12 f''(0) = \langle A, (Q\Omega)\circ(Q\Omega)\rangle + \operatorname{tr}(S\Omega^2)$. Substituting $A = Q^{\circ2}$ AT THE BASE POINT, the weight held fixed thereafter, gives $f''_{\text{frozen}} = 2X + 2T$.
- **Jin's objective, weight moving.** [Jin's §5 formula](../references/jin-2026-l4-norm-orthogonal-group/notes.md), quoted in the notes file, is $f_r''(0) = 12X + 4T$.
- **Therefore** $f''_{\text{Jin}} = 2\,f''_{\text{frozen}} + 8X$, with $X \ge 0$.

*Screened at $k=5$ on a random orthogonal $Q$ and random skew $\Omega$: the numeric second differences are $-3.55718983$ and $-4.51189206$ against the formulas' $-3.55719001$ and $-4.51189208$, and the residual is $5.46659429$ against $8X = 5.46659415$. A screen on objects built for the purpose, and the identity above is algebra that stands on its own.*

**What that settles.** A nonpositive second variation of OUR functional gives $2X + 2T \le 0$. Jin's condition needs $12X + 4T \le 0$, which is strictly more by $8X$ and fails whenever $X > 0$, that is at every direction $\Omega$ not annihilated by the support of $Q$. **The implication CLAIM B names runs uphill.** The same holds at the exact weight the route wants, so the gap does not close by choosing $A = Q^{\circ2}$.

**A second problem inside the same claim.** The record's $A$ is FIXED and rank two. $Q^{\circ2}$ is of that shape only at special $Q$, so "the gap is the weight" needs $A$ and $Q$ to be related, which is a condition on the point and not a change of parameter.

**The record already says this.** The filed notes file says outright *"It does not transfer as a citation ... A theorem about the quartic says nothing directly about the linear one."* [plan.md:98](../plan.md) contradicts the source note it cites.

## CLAIM C, REFUTED: the proposition is FALSE, not open

**Reach: one declaration, [MaxValueForcesFourthPeak](../lean/HamiltonsCubic/Results/I106bFace.lean), and through it one theorem.**

**The proof, in four steps, none of it numerical.**

1. At a permutation matrix $P_\sigma$, the second variation is DIAGONAL in the elementary skew basis, with $\tfrac12 f''(0)[E_{ab}] = (A_{\sigma^{-1}a,b} + A_{\sigma^{-1}b,a}) - (A_{\sigma^{-1}a,a} + A_{\sigma^{-1}b,b})$. **This is the file's own formula**, at line 685, confirmed by [r1048](REVIEW_r1048.md) and [r1049](REVIEW_r1049.md).
2. So `SecondOrderMax A P_σ` is 2-opt optimality of $\sigma$, and at the value-optimal $\sigma$ with every transposition gap STRICT the form is strictly positive definite.
3. The form's matrix is polynomial in the entries of $Q$, so strict positive definiteness is an OPEN condition on $O(k)$. **`SecondOrderMax A Q` therefore holds on a whole neighbourhood of $P_\sigma$**, and the file's line 685 stops one step short of this.
4. [fourthPower](../lean/HamiltonsCubic/Results/I106bFace.lean) is continuous and equals $k$ only at the signed permutations, which are isolated in $O(k)$. That neighbourhood therefore contains $Q$ with `fourthPower Q < k`.

**Hence `MaxValueForcesFourthPeak A` is false for every $A$ whose optimal assignment is strictly 2-opt optimal, an open dense condition, and the record's rank-two $A$ is in it.**

*Screened at $k=4$ with $A_{ik} = \beta\nu_k^2 u_i + \nu_k c_i$ at random $u, c, \nu, \beta$, rank $2$, along $Q_t = P_\sigma \exp(t\Omega)$:*

| $t$ | min eigenvalue of the form | `fourthPower` | `SecondOrderMax` |
|---|---|---|---|
| $10^{-3}$ | $0.006167$ | $3.999998$ | holds |
| $10^{-2}$ | $0.006131$ | $3.999800$ | holds |
| $3\cdot10^{-2}$ | $0.005841$ | $3.998201$ | holds |
| $10^{-1}$ | $0.002550$ | $3.980090$ | holds |
| $2\cdot10^{-1}$ | $-0.008227$ | $3.921423$ | fails |

*At $t=0$ the form is exactly diagonal, off-diagonal mass $0$, which reproduces step 1 independently.* **Two degenerate members of the same family are falsifiers with no computation at all**: $A = 0$ makes both sides of `SecondOrderMax` zero at every $Q$, and $A_{ik} = u_i$, which is the record's shape at $c = 0$ and $\nu \equiv 1$, makes the value CONSTANT on $O(k)$ and `SecondOrderMax` an identity, since $\Omega\Omega^{\mathsf T} = \Omega^{\mathsf T}\Omega$ at skew $\Omega$. The `def` carries no hypothesis on $A$ whatever, so both are inside its quantifier.

**The `def`-versus-`sorry` choice is right for the wrong reason, and the file breaks its own rule.** A `sorry` on a false proposition would let `False` be derived, so `def` is the safer of the two. But [I106bFace.lean:423](../lean/HamiltonsCubic/Results/I106bFace.lean) already fixes the standard: *"A false proposition behind a `sorry` is exactly the defect the previous repair was written to remove, and restating it as OPEN would repeat it in weaker words."* The docstring 360 lines later calls `MaxValueForcesFourthPeak` *"the item's question, typed as one"*, which is restating a false proposition as open, in weaker words. **This is the third time the item has typed a false statement**, after the two [r1040](REVIEW_r1040.md) and [r1041](REVIEW_r1041.md) refuted.

**The correction owed.** The hypothesis has to be genuine maximality, a local maximum of `value A (Q ⊙ Q)` over $O(k)$, or at minimum `SecondOrderMax` holding on a neighbourhood together with criticality. The pointwise algebraic shadow is strictly weaker than the condition the implication needs, and the gap between them is exactly what step 3 exploits.

## CLAIM D, SPLIT

**CONFIRMED, faithfulness of the two declarations to themselves.** Reach: one file.

- [JinFourthPeak](../lean/HamiltonsCubic/Results/I106bFace.lean) renders Theorem 1(i) clause by clause. `Q * Qᵀ = 1` is the right orthogonality hypothesis, since `mul_eq_one_comm` gives `Qᵀ * Q = 1` for a square matrix and the file itself uses that step at line 222. The bound is $f_k \le k$ and the equality case is an `iff`, which is Jin's *"equality exactly at the signed permutation matrices"*, in the right direction. [IsSignedPerm](../lean/HamiltonsCubic/Results/I106bFace.lean) is one nonzero entry per row of modulus one at $\sigma i$, the standard definition. No genericity, no support restriction, no parity, matching the source note's *"Hypotheses: none beyond $Q\in O(r)$ and $r\ge1$."*
- [isSignedPerm_of_maxValue](../lean/HamiltonsCubic/Results/I106bFace.lean) elaborates. The file's only two occurrences of `sorry` are both in prose, at lines 423 and 787, and the `.olean` is one minute newer than the source, so the file built after its last edit.

**REFUTED, that it is the rung.** Reach: the route as a whole.

- **It is VACUOUS at the record's $A$**, by CLAIM C. `MaxValueForcesFourthPeak A` is false there, so the theorem is true and says nothing.
- **Its proof is modus ponens.** `((hjin Q hQ).2).mp (hmax Q hQ hQmax)`. `hQmax` is used only to feed `hmax` and `hQ` only to feed both. All of the content sits in the two hypotheses, one of them false.
- **`IsSignedPerm Q` for a single $Q$ is not [plan.md](../plan.md)'s target.** [plan.md:98](../plan.md) states it as *"the maximum of R28's value over the COUPLED pair sits at a splitting frame."* The real [post F72](../findings/fence-posts.md) is precisely the finding that a single-$Q$ argument cannot be transported to the coupled pair, and [lean/INDEX.md](../lean/INDEX.md)'s I106b row says the same and adds that the rung consumes `Splits`, which is WEAKER than vertex-ness, so `face_hands_down` is *"the WRONG target"*. This declaration reaches the same single-$Q$ vertex conclusion by a different road.
- **The file contradicts itself on this exact point.** The section header at line 674 reads *"this section serves the CRITICALITY question ... and it serves no rung"*. The docstring at line 795 reads *"WHAT THE OBLIGATION BUYS, ONCE DISCHARGED: the rung"*. One of the two has to go.

**Not a defect, corrected against the brief.** $[\hat U, C] = 0$ is [I106a](../plan.md)'s target and belongs to the $\hat U, V$ Lagrange system at [second-order.md:1090](../findings/second-order.md). [plan.md](../plan.md)'s I106b entry does not name it, so the suggestion that the rung is a commutator statement is not borne out.

## What this round leaves standing

- **The Lean file is sound.** Nothing in it is proved falsely, and the false statement is a `def`, so no theorem depends on it.
- **[SecondOrderMax](../lean/HamiltonsCubic/Results/I106bFace.lean) and its 2-opt reading stand**, and step 3 above is new information about it: the condition is satisfied on an open set around the best permutation, which is why it cannot by itself force the peak.
- **[row_offdiag_eq_sq_sub_quartic](../lean/HamiltonsCubic/Results/I106bFace.lean) and [isSignedPerm_of_rows_disjoint](../lean/HamiltonsCubic/Results/I106bFace.lean) stand**, and together they make [JinFourthPeak](../lean/HamiltonsCubic/Results/I106bFace.lean) provable in the file rather than assumed.
- **The source reading stands.** The notes file states the theorem and its hypotheses correctly and says plainly that it does not transfer as a citation. The defect is downstream of the notes, in [plan.md](../plan.md) and in the Lean docstrings.

## The four repairs, in the order they should land

1. **Change F72 to F69** at [plan.md:66](../plan.md), [plan.md:98](../plan.md) and [I106bFace.lean:758](../lean/HamiltonsCubic/Results/I106bFace.lean), leaving [I106bFace.lean:42](../lean/HamiltonsCubic/Results/I106bFace.lean) alone.
2. **Restate [MaxValueForcesFourthPeak](../lean/HamiltonsCubic/Results/I106bFace.lean)** with genuine maximality in place of the pointwise second-order shadow, or delete it, following the file's own line 423 rule.
3. **Withdraw "the gap is exactly the weight"** from [plan.md:98](../plan.md) and record $f''_{\text{Jin}} = 2f''_{\text{frozen}} + 8X$ instead, which names the second gap and its direction.
4. **Reopen the `attackable` regrade** at [plan.md:66](../plan.md). It was granted on part (iii), and part (iii) reaches no declaration and has no route to one while the second gap points uphill.
