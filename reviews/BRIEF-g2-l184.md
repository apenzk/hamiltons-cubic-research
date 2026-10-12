# Gate 2 brief, L184, the coincident case at $\dim V=6$

**Cold brief. Work from what is below and nothing else.** Do not read [findings/](../findings/) for the answer.

## The standing rule you inherit

**This programme is on an ANALYSIS-ONLY footing.** Computation requires the user's approval for a specific task and you do not have it. **Permitted without asking: screening a claim you are about to record, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim.** Reserved and forbidden: searches, sweeps, optimisations, censuses, falsifier hunts. **A refutation must be exhibited in closed form or it is not a refutation.**

## Conventions and constants

- $\mathcal W_n$: algebraic Weyl tensors on $\mathbb R^n$, Riemann symmetries, first Bianchi, total trace-freeness. A linear subspace, so $0\in\mathcal W_n$.
- $\Lambda^2\mathbb R^n$ has $\{f_a\wedge f_b\}_{a<b}$ orthonormal; a $2$-form is also a skew matrix, $\lVert\omega\rVert^2=-\tfrac12\operatorname{tr}(\omega^2)$, and its **support** is that matrix's image.
- $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$ over an orthonormal eigenbasis, the sum over **nonzero** eigenvalues; $\Phi(\omega)=(\omega^2,\ \omega\wedge\omega)$.
- **The conjecture's range is even $n\ge12$**, threshold $\sqrt{3/2}=1.224745$, $\theta_0(12)=1.236033$, crossover $6+2\sqrt7=11.2915$. **None should appear in this proof; say so if one does.**

## The givens, all audited by two reviewers each and passed, use them freely

**Given A.** Total trace-freeness is exactly $\sum_i\lambda_i\,\omega_i^2=0$; equivalently $\sum_i\lambda_iA_i=0$ with $A_i=\omega_i\omega_i^{\mathsf T}$ positive semidefinite of trace $2$.

**Given B.** The first Bianchi identity is exactly $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$ in $\Lambda^4$.

**Given C ([L181](../findings/diagonal-half.md), Gate 2 passed).** Fix an orthogonal decomposition of $\mathbb R^n$ into planes $P_j$ with unit area forms $\varepsilon_j$. If **every** eigen-$2$-form with nonzero eigenvalue is a real combination of the $\varepsilon_j$, then $W=0$. *Its mechanism: Ricci fixes the diagonal and Bianchi the off-diagonal of $M^{\mathsf T}\Lambda M$, so both together force $M^{\mathsf T}\Lambda M=0$, and $MM^{\mathsf T}=I_r$ gives $\Lambda=0$.*

**Given D.** $\dim V=4$ is settled elsewhere, so **no finding is available by exhibiting a rank-three Weyl tensor with four-dimensional support.**

## The block, quoted verbatim from the file

#### Lemma L184, the coincident case at $\dim V=6$ is empty

*Derived 2026-09-08 while [L183](../findings/diagonal-half.md#lemma-l183-a-rank-three-weyl-tensor-is-an-orthonormal-triple-whose-images-are-collinear)'s Gate 2 ran. **Unaudited**, and the three cases below are separable, so a reviewer can attack them one at a time.*

**Statement.** There is no rank-three $W\in\mathcal W_n$ with $\dim V=6$ whose three images under $\Phi$ coincide, that is, no orthonormal $\omega_1,\omega_2,\omega_3$ spanning a six-dimensional $V$ with $\omega_1^2=\omega_2^2=\omega_3^2$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2=\omega_3\wedge\omega_3$.

**Setup.** Write $A=-\omega_i^2$, common by hypothesis, positive definite of trace $2$ on $V$. *Each $\omega_i$ commutes with $\omega_i^2$, hence preserves every eigenspace of $A$*, and $A$'s eigenvalues come in equal pairs, $\omega_i$ being skew with eigenvalues $\pm\mathrm ic_j$. **So $A$ has spectrum $\{c_1^2,c_1^2,c_2^2,c_2^2,c_3^2,c_3^2\}$ and the three cases are set by how many of the $c_j^2$ agree.**

**Case 1, the $c_j^2$ pairwise distinct.** *$A$'s eigenspaces are then three specific planes $P_1,P_2,P_3$, each $\omega_i$ preserves them, and a skew map on a plane is a multiple of its area form*, so $\omega_i=\sum_j\pm c_j\varepsilon_j$ for every $i$, **all three block-diagonal for one common splitting.** [Lemma L181](../findings/diagonal-half.md#lemma-l181-ricci-flatness-and-first-bianchi-are-the-two-halves-of-one-matrix-and-together-they-empty-the-simultaneously-block-diagonal-family) then gives $W=0$. $\square$

**Case 2, all three equal, $A=cI_6$.** *Then $\omega_i/\sqrt c$ is orthogonal and skew, a complex structure, and on $\mathbb R^6$ every compatible one satisfies $\star(J\wedge J)=2\epsilon_JJ$ with $\epsilon_J=\pm1$ by orientation.* **Equal $J_i\wedge J_i$ forces $\epsilon_iJ_i$ all equal, so $J_i=\pm K$ for a single $K$**, and then $\operatorname{tr}(J_iJ_j)=\mp\operatorname{tr}(K^2)=\pm6\ne0$ against orthogonality. $\square$

**Case 3, exactly two agree, spectrum $(a,a,b)$ with $a\ne b$.** *$A$'s eigenspaces are a $4$-plane $Q$ and a plane $P$, both preserved, so $\omega_i=\sqrt a\,J_i\oplus\tau_i\sqrt b\,\varepsilon_P$ with $J_i$ a complex structure on $Q$ and $\tau_i=\pm1$.* **Equal wedges force $J_i=\sigma_iJ$ for one $J$**: the cross term $2\tau_i\sqrt{ab}\,J_i\wedge\varepsilon_P$ lives in $\Lambda^2Q\otimes\Lambda^2P$ and is the only part that varies with $i$, since $J_i\wedge J_i=2\,\mathrm{vol}_Q$ for every complex structure on a $4$-plane. **Then orthogonality is a sign identity that has no solution.** *With $\operatorname{tr}(J^2)=-4$ on $Q$ and $\varepsilon_P^2=-\mathrm{Id}_P$, $\operatorname{tr}(\omega_i\omega_j)=-4a\sigma_i\sigma_j-2b\tau_i\tau_j$, so orthogonality reads $4a\,\sigma_i\sigma_j=-2b\,\tau_i\tau_j$ at all three pairs. Setting $\rho_i=\sigma_i\tau_i$, the ratio $\sigma_i\sigma_j/(\tau_i\tau_j)=\rho_i\rho_j$ must be one constant, and three signs with all pairwise products equal force that constant to be $+1$*, **whence $4a=-2b$, impossible for $a,b>0$.** $\square$

> **WHAT IS LEFT OF [I38](../plan.md) IS ONE CASE.** *The images are distinct and collinear, at $\dim V\ge6$.* **The coincident case (the one $n=4$ realises, and the natural first guess at every larger dimension), is now closed at $\dim V=6$.** *Nothing here reaches $\dim V\ge8$, where case 1's argument still applies whenever the $c_j^2$ are pairwise distinct but the other two cases are untried.*

## What to attack, and answer every item in writing

**Silence is not a verdict.** Answer each explicitly, including where you found nothing.

1. **Every hypothesis**, of the statement and of the givens as applied. Used, stated-and-unused, used-and-unstated.
2. **The setup.** Does $\omega_i$ commuting with $\omega_i^2$ really give that it preserves every eigenspace of $A$? Is $A$ positive **definite** rather than merely semidefinite here, and does $\dim V=6$ give that? **Are $A$'s eigenvalues necessarily doubled?**
3. **Case 1.** Pairwise distinct $c_j^2$ give three eigenplanes. **Is "a skew map preserving a plane restricts to a multiple of its area form" right**, and does it give the SAME splitting for all three $\omega_i$, which is what Given C needs?
4. **Case 2, the identity $\star(J\wedge J)=2\epsilon_JJ$.** Derive it independently on $\mathbb R^6$ and check the orientation bookkeeping. **Does equal $J_i\wedge J_i$ really force $\epsilon_iJ_i$ all equal, or something weaker?** Is $\operatorname{tr}(K^2)=-6$?
5. **Case 3, the splitting.** Is $\omega_i=\sqrt a\,J_i\oplus\tau_i\sqrt b\,\varepsilon_P$ the general form, with $J_i$ a complex structure on the $4$-plane? **Is $J\wedge J=2\,\mathrm{vol}$ for every complex structure on a $4$-plane, or only the self-dual ones?** *That distinction is the likeliest break.*
6. **Case 3, the cross term.** Is the cross term the only part varying with $i$, and does its vanishing-difference really force $J_i=\sigma_iJ$ rather than merely constraining the $J_i$?
7. **Case 3, the sign identity.** Check $\operatorname{tr}(\omega_i\omega_j)=-4a\sigma_i\sigma_j-2b\tau_i\tau_j$ including both constants, then the step that three signs with all pairwise products equal force that product to be $+1$, then $4a=-2b$.
8. **Exhaustiveness.** Are the three cases exhaustive for a positive definite $A$ with doubled spectrum on a six-space? **Is any configuration missed?**
9. **The kernel.** $\ker W\ne0$ is this record's recurring obstruction. Does any step assume otherwise?
10. **The boundary.** $\dim V=4$; $\dim V\ge8$, where the block claims nothing; odd $n$; $n$ below the conjecture's range.
11. **Overreach.** The block concludes that what remains of the programme's item is the distinct-and-collinear case. **Is that entailed by what is proved here plus the givens?**

**Name what would break it.** End by naming the object that, if it existed, would falsify the claim, and say what you did to look for it. **A rank-three Weyl tensor with six-dimensional support and coincident images is the most valuable thing you could exhibit.**

**Do not supply a missing argument.** Where a claim has no proof on file the finding is *"this claim has no argument on file"*, verdict `HYPOTHESIS-DEBT`.

## Output

`reviews/REVIEW_r<N>.md`: title; standfirst saying the brief was cold and **no numerical work was done, every value exact**, with your log path; **the claim table before any prose**, verdicts in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections with derivations in full; the overall verdict. **Use your own verdict vocabulary, the fold records your word, not a kinder one.**

Log to `agent_logs/g2-l184-r<N>.log` with PID, a line per phase, live state at every tool round, and a closing `DONE <verdict>`.

**Commit your report alone. Do NOT edit [reviews/INDEX.md](INDEX.md)**, the fold writes every row after both reports land, and the commit gate exempts a commit staging only a report.
