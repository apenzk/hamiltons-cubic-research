# Gate 2 brief, L179's support reduction and L180's PSD form of Ricci-flatness

**Cold brief. Work from the definitions and statements below and nothing else.** Do not read [findings/](../findings/) for the answer.

## The standing rule you inherit

**This programme is on an ANALYSIS-ONLY footing.** Computation requires the user's approval for a specific task and you do not have it. **Permitted without asking: screening a claim you are about to record, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim.** Reserved and forbidden: searches, sweeps, optimisations, censuses, falsifier hunts. **A refutation must be exhibited in closed form or it is not a refutation.**

## Conventions, fixed once, every constant this brief's checklist names is here

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: the Riemann symmetries, the first Bianchi identity $W_{abcd}+W_{acdb}+W_{adbc}=0$, and total trace-freeness $\sum_bW_{abcb}=0$ for all $a,c$. **It is a linear subspace, so $0\in\mathcal W_n$.**
- $\Lambda^2\mathbb R^n$ carries the inner product making $\{f_a\wedge f_b\}_{a<b}$ orthonormal. A $2$-form is written both as $\omega=\sum_{a<b}\omega_{ab}f_a\wedge f_b$ and as the skew matrix $(\omega_{ab})$, so $\lVert\omega\rVert^2=\sum_{a<b}\omega_{ab}^2=-\tfrac12\mathop{\mathrm{tr}}(\omega^2)$.
- **A $2$-form's support** is the image of that skew matrix, a subspace of even dimension. $\omega$ is **decomposable** when $\omega=u\wedge v$, equivalently when its support is a plane, equivalently when $\omega\wedge\omega=0$.
- $W$ acts self-adjointly on $\Lambda^2$ by $W(f_a\wedge f_b)=\sum_{c<d}W_{abcd}f_c\wedge f_d$. **In spectral form $W=\sum_\alpha\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha$ over an orthonormal eigenbasis, where $\omega\otimes\omega$ means $\eta\mapsto\langle\omega,\eta\rangle\,\omega$.**
- **The conjecture's range is $n\ge12$**, its threshold is $\sqrt{3/2}=1.224745$, and $\theta_0(12)=1.236033$. **The crossover the record watches is $n=6+2\sqrt7$.** $\theta=P/\lVert W\rVert^3$ with $P(W)=\langle W,W^2+W^\#\rangle$.
- *You may take as given, from an audit two reviewers have already passed:* a nonzero Weyl tensor that is coordinate-diagonal in an orthonormal frame (meaning $W_{abcd}=0$ unless $\{a,b\}=\{c,d\}$), has $\Lambda^2$-rank at least four.

## Claim 1, L179

**(a)** Let $V$ be the span of the supports of the $\omega_\alpha$ with $\lambda_\alpha\ne0$. **Then $W$ is supported on $\Lambda^2V$**, meaning $W_{abcd}=0$ whenever any index leaves $V$. *Proof as written: $\mathop{\mathrm{Im}}W\subseteq\Lambda^2V$ by construction, so $W(f_a\wedge f_b)\in\Lambda^2V$ and $W_{abcd}=\langle W(f_a\wedge f_b),f_c\wedge f_d\rangle$ vanishes when $\{c,d\}\not\subseteq V$; the pair symmetry $W_{abcd}=W_{cdab}$ gives the other pair.*

**(b)** The Bianchi obstruction is the map $\mathfrak b:S^2\Lambda^2\to\Lambda^4$ sending $\omega\odot\eta$ to $\omega\wedge\eta$, so the first Bianchi identity is **$\sum_{\lambda_\alpha\ne0}\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$ in $\Lambda^4$**, the zero eigenvalues drop out, so at rank $r$ it constrains $r$ terms and no more.

**(c)** **Rank one is impossible**: $W=\lambda\,\omega\otimes\omega$ has $\mathop{\mathrm{tr}}W=\lambda\lVert\omega\rVert^2$, killed by tracelessness.

**(d)** If all three image forms are decomposable then (b) holds automatically and $\dim V\le6$; **but the three planes cannot be mutually orthogonal**, since an adapted frame would make $W$ coordinate-diagonal, which the given fact forbids at rank three.

## Claim 2, L180

Let $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$ be nonzero with the $\omega_i$ orthonormal and every $\lambda_i\ne0$. Set $A_i=-\omega_i^2=\omega_i\omega_i^{\mathsf T}$.

**(1)** **Ricci-flatness is exactly $\sum_i\lambda_i\,\omega_i^2=0$**, equivalently $\sum_i\lambda_iA_i=0$ with every $A_i$ positive semidefinite of trace $2$. *Proof as written: $W_{abcd}=\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$, so $\sum_bW_{abcb}=\sum_i\lambda_i\sum_b(\omega_i)_{ab}(\omega_i)_{cb}=\big(\sum_i\lambda_i\omega_i\omega_i^{\mathsf T}\big)_{ac}$, and $\omega^{\mathsf T}=-\omega$.*

**(2)** **Tracelessness is its trace**, since $\mathop{\mathrm{tr}}(\omega_i^2)=-2$ at unit norm, so it is not an extra condition.

**(3)** **At rank three, $V$ is the support of the single form carrying the minority sign, and $\dim V$ is even and at least four.** *Proof as written: the $\lambda_i$ are nonzero and sum to zero, so their signs are not all equal and the pattern is $(+,+,-)$ or $(+,-,-)$ up to relabelling. Moving the minority-sign term leaves a sum of PSD matrices equal to a PSD matrix, and the range of a sum of PSD matrices is the sum of their ranges, so the minority form's support contains the other two and equals $V$. Here $\mathop{\mathrm{range}}(A)=\mathop{\mathrm{range}}(\omega)=\mathop{\mathrm{supp}}\omega$, because $\omega^2x=0$ forces $\lVert\omega x\rVert^2=-x^{\mathsf T}\omega^2x=0$. At $\dim V=2$ the space $\Lambda^2V$ is one-dimensional so the rank is at most one.*

**(4)** **At rank two, $\lambda_2=-\lambda_1$ forces $A_1=A_2$**, so the two forms share a support.

## What to attack, and answer every item in writing

**Silence is not a verdict.** Answer each explicitly, including where you find nothing.

1. **Every hypothesis** of both statements and of everything imported, checked against the object. Used, stated-and-unused, used-and-unstated.
2. **The normalisation of $W_{abcd}=\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$.** Derive it from $\omega\otimes\omega:\eta\mapsto\langle\omega,\eta\rangle\omega$ and the stated $\Lambda^2$ inner product. **Is there a factor of $2$ or $\tfrac12$, and would one change any conclusion?** *This record has admitted a factor-of-two error twice, and every claim below rests on this line.*
3. **The Ricci contraction.** $\sum_bW_{abcb}$ runs $b$ over all indices and uses the antisymmetric extension of $(\omega)_{ab}$ beyond $a<b$. Check the index bookkeeping explicitly. **Is $\sum_b(\omega)_{ab}(\omega)_{cb}$ really $(\omega\omega^{\mathsf T})_{ac}$?**
4. **Is $A=\omega\omega^{\mathsf T}$ positive semidefinite with $\mathop{\mathrm{range}}(A)=\mathop{\mathrm{supp}}\omega$ and $\mathop{\mathrm{tr}}A=2\lVert\omega\rVert^2$?** Each separately.
5. **Range additivity.** *Is the range of a sum of positive semidefinite matrices the sum of their ranges?* **Prove it or refute it, this is load-bearing for (3) and is stated without argument.** Read it at a source rather than recalling it, and fetch that source into [references/](../references/) with a `notes.md`.
6. **L180(3)'s sign analysis.** Are $(+,+,-)$ and $(+,-,-)$ the only patterns up to relabelling, and does the argument really identify $V$ with the **minority**-sign form's support in both? Check each pattern separately rather than by symmetry.
7. **$\dim V\ge4$.** Is $\dim V=2$ really impossible, and is $\dim V$ necessarily even given that it is a span of several supports rather than one? **L180(3) claims $V$ IS a single form's support, which is what makes it even, check that step does not circle.**
8. **L179(a).** Does $\mathop{\mathrm{Im}}W\subseteq\Lambda^2V$ actually follow, and is the pair-symmetry step valid for all four indices rather than two?
9. **L179(b), the Bianchi map.** Is the first Bianchi identity equivalent to the vanishing of $W$ under $S^2\Lambda^2\to\Lambda^4$, in this normalisation, with no constant? Read it at a source.
10. **L179(c) and (d).** Rank one; and whether "all decomposable $\Rightarrow$ $\omega\wedge\omega=0$ each $\Rightarrow$ (b) automatic" is right, and whether $\dim V\le6$ follows.
11. **The kernel.** $\ker W\ne0$ is this record's recurring obstruction and every object here is almost all kernel. Does any step assume otherwise?
12. **The boundary.** $n=4$ exactly, $n=5$, odd $n$, $n=6+2\sqrt7$, and $n$ below the conjecture's range $n\ge12$.
13. **Overreach.** The record concludes from these that *"$\dim V\ge6$ is the whole of what remains"* for a rank-three tensor. **Is that entailed by what is proved here, or does it need something not on file?**

**Name what would break it.** End by naming the object that, if it existed, would falsify each claim, and say what you did to look for it. **A rank-three Weyl tensor with six-dimensional support would be the most valuable object you could produce; exhibiting one in closed form settles an open question, and failing to find one settles nothing.**

**Do not supply a missing argument.** Where a claim has no proof on file the finding is *"this claim has no argument on file"*, verdict `HYPOTHESIS-DEBT`.

## Output

`reviews/REVIEW_r<N>.md`: title; standfirst saying the brief was cold and **no numerical work was done, every value exact**, with your log path; **the claim table before any prose**, verdicts in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections with derivations in full; the overall verdict. **Use your own verdict vocabulary and state it plainly, the fold records your word, not a kinder one.**

Log to `agent_logs/g2-l180-r<N>.log` with PID, a line per phase, live state at every tool round, and a closing `DONE <verdict>`. Commit your report alone, `review(L180): r<N> <verdict>`. **Leave any reference folder you fetch uncommitted and say so, the parent folds it in.**
