# Gate 2 brief, L183, rank three as collinearity of the images

**Cold brief. Work from what is below and nothing else.** Do not read [findings/](../findings/) for the answer.

## The standing rule you inherit

**This programme is on an ANALYSIS-ONLY footing.** Computation requires the user's approval for a specific task and you do not have it. **Permitted without asking: screening a claim you are about to record, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim.** Reserved and forbidden: searches, sweeps, optimisations, censuses, falsifier hunts. **A refutation must be exhibited in closed form or it is not a refutation.**

## Conventions and constants, everything the checklist names

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: the Riemann symmetries, the first Bianchi identity, and total trace-freeness $\sum_bW_{abcb}=0$. **It is a linear subspace, so $0\in\mathcal W_n$.**
- $\Lambda^2\mathbb R^n$ has $\{f_a\wedge f_b\}_{a<b}$ orthonormal; a $2$-form is also read as a skew matrix, and $\lVert\omega\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(\omega^2)$. A $2$-form's **support** is the image of that skew matrix.
- $W$ acts self-adjointly on $\Lambda^2$; **in spectral form $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$** over an orthonormal eigenbasis, $\omega\otimes\omega$ meaning $\eta\mapsto\langle\omega,\eta\rangle\omega$, the sum over the **nonzero** eigenvalues.
- **The conjecture's range is even $n\ge12$**, its threshold $\sqrt{3/2}=1.224745$, $\theta_0(12)=1.236033$, and the crossover $n=6+2\sqrt7=11.2915$. **None should appear in this proof; say so if one does.**

## The two givens, both audited by two reviewers each and passed, use them freely

**Given A (Ricci).** For $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$, total trace-freeness is exactly $\sum_i\lambda_i\,\omega_i^2=0$ in $S^2(\mathbb R^n)$, equivalently $\sum_i\lambda_iA_i=0$ with $A_i=\omega_i\omega_i^{\mathsf T}$ positive semidefinite of trace $2$.

**Given B (Bianchi).** The first Bianchi identity is exactly $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$ in $\Lambda^4$, the zero eigenvalues dropping out.

**Given C.** At $\dim V=4$ the statement is settled by a separate audited lemma, so **no finding is available by exhibiting a rank-three Weyl tensor with four-dimensional support**, two earlier reviewers each produced one against a brief that withheld this, and both were right about the brief and reached nothing on the record.

## The block, quoted verbatim from the file

#### Lemma L183, a rank-three Weyl tensor is an orthonormal triple whose images are collinear

**Statement.** Define $\Phi:\Lambda^2\mathbb R^n\to S^2(\mathbb R^n)\oplus\Lambda^4\mathbb R^n$ by $\Phi(\omega)=(\omega^2,\ \omega\wedge\omega)$. Then $W=\sum_{i=1}^3\lambda_i\,\omega_i\otimes\omega_i$ with the $\omega_i$ orthonormal and every $\lambda_i\ne0$ lies in $\mathcal W_n$ **if and only if the three points $\Phi(\omega_1),\Phi(\omega_2),\Phi(\omega_3)$ are collinear**, and the weights are then determined up to scale by the collinearity ratio.

**Proof.** By [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support) Ricci-flatness is $\sum_i\lambda_i\omega_i^2=0$ and by [L179](../findings/diagonal-half.md#lemma-l179-the-support-of-a-low-rank-weyl-tensor-and-the-first-bianchi-identity-read-on-the-spectrum) first Bianchi is $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$, so together they are the single equation $\sum_i\lambda_i\Phi(\omega_i)=0$, **and tracelessness, being Ricci's trace, adds $\sum_i\lambda_i=0$ rather than a further constraint.**

*Three vectors carrying weights that sum to zero and vanish nowhere are affinely dependent, hence collinear.* Writing $\lambda_3=-(\lambda_1+\lambda_2)$ turns $\sum\lambda_i\Phi_i=0$ into $\lambda_1(\Phi_1-\Phi_3)=-\lambda_2(\Phi_2-\Phi_3)$, so $\Phi_1-\Phi_3$ and $\Phi_2-\Phi_3$ are parallel. **Conversely**, from $\Phi_1-\Phi_3=t(\Phi_2-\Phi_3)$ with $t\ne0,1$ the weights $(1,-t,t-1)$ sum to zero, vanish nowhere and annihilate the triple. $\square$

> **AND IT EXPLAINS WHY $n=4$ IS EASY: THERE THE THREE IMAGES COINCIDE.** *On the self-dual forms of $\mathbb R^4$ every $\omega_i^2=-\tfrac12\mathrm{Id}_4$ and every $\omega_i\wedge\omega_i=f_{1234}$*, so $\Phi_1=\Phi_2=\Phi_3$ and **every** weight vector summing to zero gives a Weyl tensor, which is why [L178](../findings/diagonal-half.md#lemma-l178-every-weyl-tensor-of-lambda2-rank-at-most-three-has-thetalesqrt32-with-equality-exactly-at-w_mathbbcp2)'s family is a whole $2$-parameter set rather than isolated points, and why $\theta$ there is a function of the weights alone.

> **WHAT IT ASKS AT $\dim V=6$, WHICH IS [I38](../plan.md)'S REMAINING CASE.** *The coincident sub-case is the one to try first, being what $n=4$ does: three orthonormal $\omega_i$ with equal $\omega_i^2$ and equal $\omega_i\wedge\omega_i$.* **Equal squares at full rank forces each $\omega_i$ to be a scaled complex structure** ($\omega\omega^{\mathsf T}=cI_6$ says $\omega/\sqrt c$ is both orthogonal and skew), *so that sub-case asks for three complex structures on $\mathbb R^6$, pairwise orthogonal in the sense $\mathop{\mathrm{tr}}(J_iJ_j)=0$, sharing a common $J\wedge J$.* **The first two conditions are the quaternionic relations, which need a dimension divisible by four**; whether the weaker trace condition can be met on $\mathbb R^6$ together with the shared $4$-form is the question. *Unaudited, and the non-coincident sub-case is untouched.*

## What to attack, and answer every item in writing

**Silence is not a verdict.** Answer each explicitly, including where you found nothing.

1. **Every hypothesis**, of the statement and of the givens as applied. Used, stated-and-unused, used-and-unstated.
2. **The forward direction.** Does $\sum_i\lambda_i\Phi_i=0$ with $\sum_i\lambda_i=0$ and every $\lambda_i\ne0$ really give collinearity? **Check the degenerate configurations**: two images equal, all three equal, an image at the origin.
3. **The converse.** The block takes $t\ne0,1$. **Is that the right exclusion, and is every collinear triple reached?** What if $\Phi_2=\Phi_3$, so no such $t$ exists, is the equivalence then false as stated?
4. **"Collinear" in a direct sum.** $\Phi$ lands in $S^2\oplus\Lambda^4$. Is collinearity there the right notion, and does it mean collinear in each factor separately or jointly? **These differ.**
5. **The orthonormality of the $\omega_i$** is a hypothesis of the statement. **Is it used anywhere in the proof?** If not, say so, the equivalence may hold without it, and that would be a stronger statement the block does not make.
6. **The claim that tracelessness "adds $\sum\lambda_i=0$ rather than a further constraint".** Verify it is the trace of Given A and not independent.
7. **The $n=4$ coincidence.** Are $\omega_i^2=-\tfrac12\mathrm{Id}_4$ and $\omega_i\wedge\omega_i=f_{1234}$ correct for the self-dual forms, in this brief's normalisation? **Check both, and check the claim that the family is therefore two-parameter.**
8. **The complex-structure reduction.** Does $\omega\omega^{\mathsf T}=cI$ force $\omega/\sqrt c$ to be a complex structure, and does "equal squares at full rank" really give equal $c$ across the three? **Is $\mathop{\mathrm{tr}}(J_iJ_j)=0$ the right rendering of orthonormality here, with the right constant?**
9. **The quaternionic remark.** Is it true that pairwise trace-orthogonal complex structures want a dimension divisible by four, or is that a statement about *anticommuting* ones? **These are not the same condition and the block may be conflating them.**
10. **The kernel.** $\ker W\ne0$ is this record's recurring obstruction. Does any step assume otherwise?
11. **The boundary.** $n=4$, $n=5$, $n=6$, odd $n$, and $n$ below the conjecture's range.
12. **Overreach.** Does the block claim anything its proof does not reach, in particular about which sub-cases remain?

**Name what would break it.** End by naming the object that, if it existed, would falsify the equivalence, and say what you did to look for it.

**Do not supply a missing argument.** Where a claim has no proof on file the finding is *"this claim has no argument on file"*, verdict `HYPOTHESIS-DEBT`.

## Output

`reviews/REVIEW_r<N>.md`: title; standfirst saying the brief was cold and **no numerical work was done, every value exact**, with your log path; **the claim table before any prose**, verdicts in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections with derivations in full; the overall verdict. **Use your own verdict vocabulary, the fold records your word, not a kinder one.**

Log to `agent_logs/g2-l183-r<N>.log` with PID, a line per phase, live state at every tool round, and a closing `DONE <verdict>`.

**Commit your report alone. Do NOT edit [reviews/INDEX.md](INDEX.md)**, the fold writes every row after both reports land, and the commit gate now exempts a commit staging only a report.
