# Gate 2 review r800, L186, one non-decomposable image form and $\dim V=4$

*Cold brief. **No numerical work was done in the sense the standing rule reserves**, no search, sweep, census, optimisation or falsifier hunt. Every derivation below is closed form and every constant exact. One **screen** was run and is reported as a screen in section 8, cited for nothing positive: `lake build` on [L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean). Log: [agent_logs/g2-l186-r800.log](../agent_logs/g2-l186-r800.log).*

## The claim table

| # | Claim under audit | Verdict |
|---|---|---|
| 1 | Step 1, Ricci-flatness is $\lambda_1\omega_1\omega_1^{\mathsf T}+\lambda_2\Pi_2+\lambda_3\Pi_3=0$ in the record's own pairing | **CORRECT, EXACTLY**, the $\tfrac12$ cancels and the equation is homogeneous in the $\lambda_i$ regardless |
| 2 | Step 2, the sign hypothesis makes both sides positive semidefinite | **CORRECT**, and **the hypothesis is a THEOREM, not an assumption**, it follows from $\sum\lambda_i=0$ by the block's own rank count, and from [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)(3) directly |
| 3 | Step 3, non-decomposable gives $\operatorname{rank}\omega_1\ge4$, and $\dim(P_2+P_3)\le4$ | **CORRECT**, both; the upper bound holds whether or not the planes meet |
| 4 | Step 4, $\operatorname{range}(A+B)=\operatorname{range}A+\operatorname{range}B$ for PSD $A,B$ | **CORRECT**, and provable in one line from $\ker(A+B)=\ker A\cap\ker B$ |
| 5 | Step 5, $V=\operatorname{supp}\omega_1+P_2+P_3$, of dimension four | **CORRECT**, and it is [L179](../findings/diagonal-half.md#lemma-l179-the-support-of-a-low-rank-weyl-tensor-and-the-first-bianchi-identity-read-on-the-spectrum)(a)'s definition of $V$ |
| 6 | Claim B's rank count, $\operatorname{rank}(aA+bB)\ge\max(\operatorname{rank}A,\operatorname{rank}B)$ for PSD $A,B$, $a,b>0$ | **CORRECT**, and positivity of BOTH weights is load-bearing |
| 7 | **Vacuity, Claim A (as literally stated (Ricci only)** | **NON-VACUOUS**), a closed-form witness is exhibited in section 6 |
| 8 | **Vacuity, Claim A, in the Weyl category, which is where [I38](../plan.md) lives** | **EMPTY, AND EMPTIED BY ONE LINE OF FIRST BIANCHI**, the whole branch carries no Weyl tensor |
| 9 | "THIS BRANCH IS NOT OPEN (IT LANDS INSIDE L178'S HYPOTHESIS" | **MISLEADING**), nothing lands anywhere, there being no rank-three Weyl tensor at this branch |
| 10 | "WHAT IS STILL OPEN AFTER IT (the sign hypothesis, assumed rather than derived" | **WRONG**), it is derived, by the count the same block runs two paragraphs later |
| 11 | The Lean `psd_form_of_ricci` proves "the only step that is about this problem" | **OVERSTATED**, Lean's own linter reports its sign hypothesis UNUSED; the theorem is abelian-group rearrangement over arbitrary reals |
| 12 | The block's provenance note "THE FIRST STATEMENT OF THIS SAID $\dim V\le5$" | **MISFILED**, it is [L185](../findings/diagonal-half.md#lemma-l185-the-all-decomposable-branch-is-empty)'s history, sitting in L186's block |
|, | **Claim A as posed: exactly one non-decomposable $\omega_i$ forces $\dim V=4$** | **CONFIRMED** |
|, | **Claim B as posed: two non-decomposable forms carry opposite-signed weights** | **CONFIRMED** |

**Actionable in one line:** both claims are right and Claim A is about an empty branch, first Bianchi, in the form [L179](../findings/diagonal-half.md#lemma-l179-the-support-of-a-low-rank-weyl-tensor-and-the-first-bianchi-identity-read-on-the-spectrum)(b) that the block itself invokes one paragraph below the proof, reads $\lambda_1\,\omega_1\wedge\omega_1=0$ when exactly one image form is non-decomposable, which says that form is decomposable.

## 0. Conventions, fixed once

Taken from [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support) and [L179](../findings/diagonal-half.md#lemma-l179-the-support-of-a-low-rank-weyl-tensor-and-the-first-bianchi-identity-read-on-the-spectrum), the same set [r798](REVIEW_r798.md) fixed for L185.

- A $2$-form and a real skew matrix are the same object; $\lVert\omega\rVert^2=\tfrac12\sum_{a,b}\omega_{ab}^2$, the pairing that carries the $\tfrac12$.
- **Support** of $\omega$ is the image of its matrix, of dimension equal to its rank; $V$ is the span of the supports of the eigenforms with nonzero eigenvalue.
- $A_i=-\omega_i^2=\omega_i\omega_i^{\mathsf T}$, positive semidefinite of trace $2\lVert\omega_i\rVert^2$; $\Pi_P$ the orthogonal projection onto a plane $P$.
- $e_{ab}$ denotes $e_a\wedge e_b$, and as a matrix $e_ae_b^{\mathsf T}-e_be_a^{\mathsf T}$.

## 1. Step 1, the pairing, and where the $\tfrac12$ goes

**Exact, and the factor cancels rather than surviving.** With the operator convention $(W\eta)_{ab}=\tfrac12\sum_{cd}W_{abcd}\eta_{cd}$ and the spectral form $W\eta=\sum_i\lambda_i\langle\omega_i,\eta\rangle\,\omega_i$ read in the same $\tfrac12$-pairing, the tensor is $W_{abcd}=\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$ with coefficient one, and [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)(1)'s contraction $\sum_bW_{abcb}=\big(\sum_i\lambda_i\omega_i\omega_i^{\mathsf T}\big)_{ac}$ follows.

**And no convention can break the step**, because the equation is homogeneous: a pairing without the $\tfrac12$ scales every term by the same constant, and $\sum_i\lambda_iA_i=0$ is unchanged. What the convention does fix is $\operatorname{tr}A_i=2$, used nowhere in L186.

**$\omega\omega^{\mathsf T}=\Pi$ for a unit decomposable $\omega$, verified rather than imported.** For $\omega=u\wedge v$ with $u\perp v$ unit, the matrix is $uv^{\mathsf T}-vu^{\mathsf T}$, and $\omega^2=-uu^{\mathsf T}-vv^{\mathsf T}=-\Pi$, so $\omega\omega^{\mathsf T}=\Pi$; the norm is $\lVert\omega\rVert^2=\tfrac12\cdot2=1$, so "unit" and "$\Pi$" are the same normalisation. **Step 1 is correct as written.**

*Argued the opposite:* the strongest reading against it is that a decomposable $\omega_i$ of unit norm might be $c\,u\wedge v$ with $c\ne1$ under a different pairing, making $\omega_i\omega_i^{\mathsf T}=c^2\Pi_i$. It changes nothing, $c^2$ is absorbed into $\lambda_i$, and only the SIGNS of the $\lambda_i$ and the RANKS enter the rest of the proof. **Not a discrepancy.**

## 2. Step 2, the sign hypothesis is a theorem, and the block already owns the proof

**Ricci-flatness gives $\sum_i\lambda_i=0$ for free** ([L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)(2), the trace of (1); $\operatorname{tr}A_i=2$). With every $\lambda_i\ne0$ the signs are mixed, so exactly one weight is alone in its sign. Three patterns, and two of them die:

- **$\lambda_1$ alone**, L186's hypothesis, since then $\lambda_2,\lambda_3$ share the opposite sign.
- **$\lambda_2$ alone.** Ricci-flatness becomes $\lvert\lambda_1\rvert A_1+\lvert\lambda_3\rvert\Pi_3=\lvert\lambda_2\rvert\Pi_2$. The left side is a positive combination of PSD matrices, so its rank is at least $\operatorname{rank}A_1=\operatorname{rank}\omega_1\ge4$; the right has rank $2$. **Impossible.**
- **$\lambda_3$ alone.** Identical, with the indices swapped.

**So the hypothesis "the two decomposable weights share a sign opposite to the third" is FORCED**, by exactly the rank count the block runs two paragraphs later for the two-non-decomposable case. It is one sentence and it is not written.

**The record has a second, shorter route to the same place.** [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)(3) says the support $V$ is the support of the minority-sign form, and that $\dim V\ge4$. If the minority form were decomposable, $V$ would be a plane. **So the minority form is the non-decomposable one, which is the sign hypothesis verbatim.** This is the route [L185](../findings/diagonal-half.md#lemma-l185-the-all-decomposable-branch-is-empty)'s own follow-up note already uses.

**The block's "WHAT IS STILL OPEN AFTER IT" is therefore wrong on its first item**, and so is the matching bullet in [L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean)'s *What is NOT typed here*. Both say mixed signs with $P_2\ne P_3$ "need their own argument"; the argument is the rank count, and $P_2=P_3$ (the thing they do exclude), is not what needed excluding.

*Argued the opposite:* could the two dead patterns be revived by $\omega_1$ having rank $2$? Only if $\omega_1$ were decomposable, which the hypothesis forbids. Could $\Pi_2$ have rank above $2$? Only if $\omega_2$ were non-decomposable, likewise forbidden. **The count has no escape.**

## 3. Steps 3 and 4, the two rank facts and the range identity

**Non-decomposable gives rank at least four, exactly.** A real skew matrix has a normal form $\omega=\sum_{j=1}^kc_j\,f_{2j-1}\wedge f_{2j}$ with all $c_j\ne0$ and rank $2k$, and $\omega\wedge\omega=2\sum_{j<l}c_jc_l\,f_{2j-1}\wedge f_{2j}\wedge f_{2l-1}\wedge f_{2l}$, whose terms are independent in $\Lambda^4$. **So $\omega\wedge\omega=0$ iff $k\le1$ iff $\omega$ is decomposable**, and non-decomposable is $\operatorname{rank}\ge4$. Correct.

**$\dim(P_2+P_3)\le4$ holds whether or not the planes meet**: $\dim(P_2+P_3)=4-\dim(P_2\cap P_3)$. The bound is unconditional and the equality case is exactly $P_2\cap P_3=0$, which is what the proof extracts. Correct.

**The rank of the right side IS $\dim(P_2+P_3)$**, not merely bounded by it: $\lvert\lambda_2\rvert\Pi_2+\lvert\lambda_3\rvert\Pi_3$ is PSD, and $x$ is in its kernel iff $x^{\mathsf T}(\cdot)x=0$ iff $\Pi_2x=\Pi_3x=0$ iff $x\perp P_2+P_3$. So the two ends meet at four and the intersection is trivial.

**The range identity is one line.** For PSD $A,B$: $x^{\mathsf T}(A+B)x=0$ forces $x^{\mathsf T}Ax=x^{\mathsf T}Bx=0$, hence $Ax=Bx=0$, so $\ker(A+B)=\ker A\cap\ker B$; taking orthogonal complements of these symmetric matrices' kernels gives $\operatorname{range}(A+B)=\operatorname{range}A+\operatorname{range}B$. **The record sources this to [Fillmore–Williams](../references/fillmore-williams-1971-operator-ranges/) at [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)(3), which is more than the finite-dimensional case needs.** Correct either way.

## 4. Step 5, $V$, and whether the record defines it that way

**It does.** [L179](../findings/diagonal-half.md#lemma-l179-the-support-of-a-low-rank-weyl-tensor-and-the-first-bianchi-identity-read-on-the-spectrum)(a) defines $V$ as the span of the supports of the eigenforms with $\lambda_\alpha\ne0$, so $V=\operatorname{supp}\omega_1+P_2+P_3$ is the definition and not a step. With $\operatorname{supp}\omega_1=P_2+P_3$ from step 4 and $P_2\cap P_3=0$, $V=P_2+P_3$ has dimension four. **Correct, and the conclusion is an equality rather than a bound.**

*One thing worth naming:* $V$ is basis-dependent inside a degenerate eigenspace unless one checks it is not, which [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)'s closing paragraph names as a step it owes. L186 inherits that debt and does not add to it, here the conclusion $V=P_2+P_3$ is forced for every admissible choice, since $P_2+P_3$ is the range of a matrix fixed by $W$ alone.

## 5. Claim B, the rank count, and what it is really an instance of

**The inequality is true and positivity is load-bearing.** For PSD $A,B$ and $a,b>0$, $\ker(aA+bB)=\ker A\cap\ker B\subseteq\ker A$, so $\operatorname{rank}(aA+bB)\ge\operatorname{rank}A$, and symmetrically for $B$. **Where it fails is with a negative weight**: $A+(-1)A=0$ has rank $0$ against $A$'s. The sign split supplies exactly the positivity the step needs, so Claim B's use is legitimate.

**Applied: $\lvert\lambda_1\rvert\omega_1\omega_1^{\mathsf T}+\lvert\lambda_2\rvert\omega_2\omega_2^{\mathsf T}=\lvert\lambda_3\rvert\Pi_3$ has rank $\ge4$ on the left and exactly $2$ on the right.** Contradiction, so the two non-decomposable weights carry opposite signs. **CONFIRMED.**

**It is [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)(3) again.** If the decomposable form were the minority-sign one, $V$ would be its support, a plane, against $\dim V\ge4$. Both of L186's sign arguments (Claim B's and the one section 2 supplies for Claim A), are the same instance of that lemma, which the block cites for step 1 and then does not use for either.

## 6. Vacuity, and the finding that matters

### 6a. As literally stated, the lemma has a witness

L186's statement asks only for Ricci-flatness, so a witness needs no Bianchi. Take $n=4$ with the standard frame:

$$\omega_1=\tfrac1{\sqrt2}\,(e_{13}-e_{24}),\qquad \omega_2=e_{12},\qquad \omega_3=e_{34},\qquad (\lambda_1,\lambda_2,\lambda_3)=(2,-1,-1).$$

- **Orthonormal.** The three have pairwise disjoint supports among the basis $2$-forms, and $\lVert\omega_1\rVert^2=\tfrac12\cdot\tfrac12\cdot4=1$, $\lVert\omega_2\rVert^2=\lVert\omega_3\rVert^2=1$.
- **Exactly one non-decomposable.** $\omega_1\wedge\omega_1=-e_{13}\wedge e_{24}=e_{1234}\ne0$; $\omega_2,\omega_3$ are basis decomposables.
- **The sign split holds**, $\lambda_1>0>\lambda_2,\lambda_3$, and $\sum\lambda_i=0$.
- **Ricci-flat.** $\omega_1$ is $\tfrac1{\sqrt2}$ times a complex structure ($(e_{13}-e_{24})^2=-I_4$) so $A_1=\tfrac12I_4$ and $2\cdot\tfrac12I_4-\Pi_{\langle e_1,e_2\rangle}-\Pi_{\langle e_3,e_4\rangle}=I_4-I_4=0$.
- **$\dim V=4$**, as the lemma concludes: $\operatorname{supp}\omega_1=\mathbb R^4$.

**So Claim A is not vacuous in the category it names, and the witness attains its conclusion rather than contradicting it.**

### 6b. In the Weyl category the branch is EMPTY, by one line

**The witness fails first Bianchi**: $\sum_i\lambda_i\,\omega_i\wedge\omega_i=2\,e_{1234}\ne0$. That is not an accident of the witness.

> **No rank-three Weyl tensor has exactly one non-decomposable image form.** By [L179](../findings/diagonal-half.md#lemma-l179-the-support-of-a-low-rank-weyl-tensor-and-the-first-bianchi-identity-read-on-the-spectrum)(b), first Bianchi is $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$. The two decomposable forms contribute nothing, so it reads $\lambda_1\,\omega_1\wedge\omega_1=0$, and $\lambda_1\ne0$ gives $\omega_1\wedge\omega_1=0$, **which says $\omega_1$ is decomposable**, against the hypothesis. $\square$

**This uses no Ricci-flatness, no sign hypothesis, no PSD rearrangement, no range identity and no rank bound**, and it holds at every $n$ and every $\dim V$. It is strictly stronger than L186 wherever [I38](../plan.md) is asking, because I38 asks about rank-three Weyl tensors.

**The block has the tool in hand and does not turn it on itself.** Its fourth paragraph writes *"the decomposable form contributes nothing, $\omega\wedge\omega=0$ IS decomposability"* while applying Bianchi to the two-non-decomposable case; the same sentence applied to L186's own hypothesis kills L186's own branch.

**What this does to the framing.** *"THIS BRANCH IS NOT OPEN, IT LANDS INSIDE L178'S HYPOTHESIS"* invites a reader to picture a rank-three Weyl tensor at $\dim V=4$ with one non-decomposable image form, covered by [L178](../findings/diagonal-half.md#lemma-l178-every-weyl-tensor-of-lambda2-rank-at-most-three-has-thetalesqrt32-with-equality-exactly-at-w_mathbbcp2). **There is no such tensor.** This is the same shape of understatement [r798](REVIEW_r798.md) and [r799](REVIEW_r799.md) found at L185, one lemma earlier, and the correct closing line is the same kind of sentence: **combining with [L185](../findings/diagonal-half.md#lemma-l185-the-all-decomposable-branch-is-empty), a rank-three Weyl tensor has AT LEAST TWO non-decomposable image forms**, zero killed by Ricci, one killed by Bianchi.

*Argued the opposite:* the defence is that L186 is deliberately Ricci-only, exactly as [L185](../findings/diagonal-half.md#lemma-l185-the-all-decomposable-branch-is-empty)'s "equivalently" clause is, so Bianchi is out of scope and the lemma stands. **That defence holds for the STATEMENT and not for the FRAMING**, the three follow-up notes all speak about I38 and about what is open there, and in that register the branch is empty. It also cannot be pressed far, since the block's own fourth paragraph uses Bianchi.

### 6c. Claim B's hypotheses are unsatisfiable, which is the claim

Claim B asserts an impossibility, so its "witness" is a falsifier and section 5 shows there is none. **What is worth recording is the surviving configuration it points at** (two non-decomposable forms with opposite signs, one decomposable) and that one is NOT emptied by the Bianchi line above: there Bianchi reads $\omega_1\wedge\omega_1=c\,\omega_2\wedge\omega_2$ with $c>0$, which the block states correctly. **Whether that branch is non-empty is genuinely open and is the whole of [I38](../plan.md)**, as the block says.

## 7. The Lean file

**`dim_V_eq_four` is arithmetic over binders and the docstring says so**, which is honest. The two binders `hnondec` and `hrange` are the real content and are external; nothing is smuggled.

**`psd_form_of_ricci` is overstated by the docstring, the block and [lean/INDEX.md](../lean/INDEX.md).** All three call it the step "that is about this problem" and the one that turns Ricci-flatness into an identity between positive-semidefinite matrices. **The theorem contains no positive-semidefiniteness**: the file mentions `PosSemidef` nowhere, its proof is `rw`/`abel`, and its statement $l_1\bullet A=(-l_2)\bullet P_2+(-l_3)\bullet P_3$ holds for arbitrary reals and arbitrary matrices. **Lean's own `unusedVariables` linter reports `hsign` unused**, see the screen in section 8. So what is typed is the rearrangement, and the PSD content is in the prose.

**Two more binder-only theorems.** `rank_ge_of_psd_sum` is `4 ≤ rA → rA ≤ rSum → 4 ≤ rSum`, whose PSD content is the binder `hle`; `same_sign_impossible` is the same shape. Their names claim more than their statements, in the pattern [r795](REVIEW_r795.md) recorded elsewhere in this layer. `nondecomposable_weights_opposite` is genuine trichotomy, though its `hsum` and `h₃` binders are unused too, so $\sum\lambda_i=0$ decorates a statement about two reals.

## 8. The screen

*Reported as a screen, cited for nothing positive.*

`lake build HamiltonsCubic.Results.L186Statement` in [lean/](../lean/) completes successfully, all `8708` jobs replayed, **no `sorry` in the file**. The build emits, among others:

```
warning: HamiltonsCubic/Results/L186Statement.lean:55:47: Variable name `hsign` is not explicitly referenced.
warning: HamiltonsCubic/Results/L186Statement.lean:114:5:  Variable name `hsum` is not explicitly referenced.
warning: HamiltonsCubic/Results/L186Statement.lean:114:59: Variable name `h₃` is not explicitly referenced.
```

Line 55 is `psd_form_of_ricci`'s sign hypothesis. **This is the toolchain agreeing with section 7 and not evidence for any positive claim.**

## 9. One editorial defect

**The note beginning "THE FIRST STATEMENT OF THIS SAID `$\dim V\le5$`" is [L185](../findings/diagonal-half.md#lemma-l185-the-all-decomposable-branch-is-empty)'s provenance, misfiled in L186's block.** It says both reviewers "corrected it to emptiness" and points at [L185Statement.lean](../lean/HamiltonsCubic/Results/L185Statement.lean); L186's conclusion is $\dim V=4$ and no reviewer had yet seen it. Read where it sits, it credits L186 with a history it does not have and describes "the lemma above" as an emptiness result.

## 10. The falsifiers, and what was done to look for them

**Claim A.** The falsifying object is a Ricci-flat orthonormal triple with every $\lambda_i\ne0$, exactly one $\omega_i$ non-decomposable, the stated sign split, and $\dim V\ne4$. **Three routes to one were tried and all close by hand.** Making $\operatorname{supp}\omega_1$ six-dimensional fails because the PSD identity puts that support at $P_2+P_3$, of dimension at most four. Making $\dim V<4$ needs $P_2\cap P_3\ne0$, which puts the common rank below four and makes $\omega_1$ decomposable. Escaping through the normalisation (a unit decomposable whose square is not a projection), fails at the computation in section 1. **No falsifier, and no search was run.**

**Claim B.** The falsifying object is a Ricci-flat orthonormal triple with $\omega_1,\omega_2$ non-decomposable carrying same-signed weights and $\omega_3$ decomposable. **Any such would need $\operatorname{rank}(\lvert\lambda_1\rvert A_1+\lvert\lambda_2\rvert A_2)=2$ while $\ker$ of that sum is contained in $\ker A_1$**, forcing rank at least four. The only way out is a negative coefficient, which $\sum\lambda_i=0$ with $\lambda_3$ alone in its sign forbids. **No falsifier.**

**What I looked for instead, and found.** A witness for Claim A's literal statement, exhibited in closed form in section 6a; and the one-line Bianchi argument of section 6b, which empties the branch in the category [I38](../plan.md) works in. **Both were derived by hand; the only machine time spent was the Lean screen.**

## Verdicts

- **Claim A, exactly one non-decomposable $\omega_i$ forces $\dim V=4$: CONFIRMED.** The proof is valid at every step. **Its sign hypothesis is redundant**, being forced by the block's own rank count and by [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)(3); and **the branch it treats contains no Weyl tensor**, so for [I38](../plan.md) the lemma is vacuous and the one-line Bianchi statement of section 6b should replace its framing.
- **Claim B, the two non-decomposable forms carry opposite-signed weights: CONFIRMED.** The rank count is correct and its positivity hypothesis is supplied. It is an instance of [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)(3) rather than new content, and the configuration it leaves standing is untouched by section 6b's argument.
