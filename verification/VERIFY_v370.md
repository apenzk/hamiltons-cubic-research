# Verifier v370, whether the L115 Lean declarations state and prove a claim of Lemma L115 or a component it uses (step F8)

Cold brief [ADJ_L115_F8.md](ADJ_L115_F8.md). No numerical work, no scripts written, every value exact (the only decimals are the literals already inside the Lean statements, checked as exact rationals). Log at [agent_logs/verify-L115-v370.log](../agent_logs/verify-L115-v370.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | theta_ge_diag proves the implication behind Passage A's by-product: diag $M=\lambda$ and $\lambda_{\max}(M)\le\theta$ give $\lambda_\alpha\le\theta$ for every $\alpha$ | CONFIRMED |
| 2 | theta_gt_lambda proves the heading's second clause, $\theta\ge\max_\alpha\lambda_\alpha$, at every global maximiser (strictly), once its two hypotheses are discharged by facts the brief supplies | CONFIRMED |
| 3 | Some declaration proves the headline $\lambda_{\max}(M)=\theta$, in the unrestricted form or in the coordinate-diagonal or $S^m\times S^m$ form | REFUTED |
| 4 | cap_on_subspace_transfers_nothing models the non-transfer principle behind "on $\mathcal W_n\cap W^\perp$ and nowhere else" | CONFIRMED AS ALGEBRA |
| 5 | The dimension and share lemmas, c5_exceeds_nonWeyl_cap, margin and the witness state claims of Passage A | REFUTED AS STATED (they are auxiliary arithmetic) |
| 6 | The step: the declarations state and prove a claim of Passage A or a component Passage A uses | VALID |

**Summary: the step is VALID, carried by theta_ge_diag (the by-product's inference) and theta_gt_lambda (the by-product's conclusion at every global maximiser), while the headline $\lambda_{\max}(M)=\theta$ enters only as the hypothesis hlam and is proved nowhere.**

## 0. Conventions, fixed once

- $W$ is a unit Weyl tensor read as a symmetric operator on $\Lambda^2\mathbb R^n$ with the Frobenius inner product $\langle A,B\rangle=\operatorname{tr}(AB)$, so its spectrum $\lambda=(\lambda_\alpha)$ satisfies $\sum_\alpha\lambda_\alpha^2=\|W\|^2=1$.
- $\theta=P(W)$. At a global maximiser $\theta=M(n)$.
- $M(\lambda)_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\beta\gamma}\lambda_\gamma$ as in Passage B, where $c'^2_{\alpha\beta\gamma}$ is the square of the structure constant $c'_{\alpha\beta\gamma}$ in the eigenbasis.
- In Lean, IsTopRayleigh A t is the statement $x\cdot Ax\le t\,(x\cdot x)$ for all real vectors $x$. For symmetric $A$ this is exactly $\lambda_{\max}(A)\le t$ by the Rayleigh characterisation.
- "The declarations of L115.lean in Passage D" is read as the declarations Passage D quotes, which are those of L115.lean and L115Statement.lean together (Passage D's heading names both files).

## 1. Hypothesis inventory

- **H1 (scope).** The step's "declarations of L115.lean" covers both files quoted in Passage D. Without H1 the step rests on claim 4 alone (section 5).
- **H2 (symmetry of $M$).** $M$ is symmetric, so $\lambda_{\max}(M)=\theta$ yields IsTopRayleigh $M$ $\theta$. Passage B states it.
- **H3 (diag $M=\lambda$).** $M_{\alpha\alpha}=\lambda_\alpha$. This needs $c'_{\alpha\alpha\gamma}=0$, which holds because the structure constants of $\mathfrak{so}(n)$ in an orthonormal basis for an ad-invariant inner product are totally antisymmetric, and an orthogonal change of basis preserves that. Lean takes it as the hypothesis hdiag.
- **H4 (unit norm).** $\sum_\alpha\lambda_\alpha^2=1$, from Section 0 and Passage B's "Since $\|\lambda\|=1$". Lean takes it as hnorm.
- **H5 (maximum lower bound).** $\theta\ge\sqrt{3/2}$ at a global maximiser, because $\theta=M(n)\ge P(\text{padded }W_{\mathbb{CP}^2})=\sqrt{3/2}$ (Definitions). Lean takes it as hθ.
- **H6 (global).** "Maximiser" in the by-product means global maximiser, as the heading says. H5 fails for local maximisers in general.

## 2. theta_ge_diag is the by-product's inference

Passage A, line 294: "since $\operatorname{diag}M=\lambda$ and $\lambda_{\max}(M)=\theta$ at a maximiser, $\theta\ge\max_\alpha\lambda_\alpha$".

The declaration theta_ge_diag takes hdiag ($A_{\alpha\alpha}=\lambda_\alpha$) and hlam (IsTopRayleigh $A$ $\theta$) and concludes $\lambda_\alpha\le\theta$ for all $\alpha$. The proof evaluates the Rayleigh bound at the standard basis vector $e_\alpha$ (evec), where diag_is_rayleigh gives $e_\alpha\cdot Ae_\alpha=A_{\alpha\alpha}$ and $e_\alpha\cdot e_\alpha=1$. Then $\lambda_\alpha=A_{\alpha\alpha}\le\theta$.

This is correct mathematics and it is exactly the inference Passage A draws. It uses only the half $\lambda_{\max}(M)\le\theta$ of the equality. Instantiating $A=M$ needs H2 and H3. The premise $\lambda_{\max}(M)=\theta$ itself is not proved (section 4), so theta_ge_diag proves a component, the implication, and not the by-product outright.

## 3. theta_gt_lambda proves the by-product at every global maximiser

The declaration takes hnorm ($\sum_a\lambda_a^2=1$) and hθ ($\sqrt{3/2}\le\theta$) and concludes $\lambda_\alpha<\theta$ for all $\alpha$.

- le_norm_of_sum_sq: $\lambda_\alpha^2\le\sum_a\lambda_a^2=1$, hence $\lambda_\alpha\le1$. Correct (if $\lambda_\alpha>1$ then $\lambda_\alpha^2>1$).
- one_lt_sqrt_three_halves: $1=\sqrt1<\sqrt{3/2}$ by strict monotonicity of the square root. Correct.
- Chaining, $\lambda_\alpha\le1<\sqrt{3/2}\le\theta$.

At a global maximiser H4 and H5 hold, so $\max_\alpha\lambda_\alpha<\theta$ there. This is Passage A's second heading clause "with $\theta\ge\max_\alpha\lambda_\alpha$ there", in a strictly stronger form, and at **every** global maximiser. It does not depend on $\lambda_{\max}(M)=\theta$, which Passage A itself restricts to coordinate-diagonal maximisers and $S^m\times S^m$. So this declaration proves a claim of Passage A in the unrestricted scope of its heading.

The auxiliaries check as exact rationals. margin: $1.2247^2=1.49989009\le\tfrac32$, so $1.2247\le\sqrt{3/2}$ and $\sqrt{3/2}-1\ge0.2247$. theta_sub_lambda_ge then gives $\theta-\lambda_\alpha\ge0.2247$ from $\lambda_\alpha\le1$. wit_norm: $(1/\sqrt2)^2+(-1/\sqrt2)^2=\tfrac12+\tfrac12=1$, and the closing example shows the hypotheses of theta_gt_lambda are jointly satisfiable with $\theta=\sqrt{3/2}$, so the theorem is not vacuous.

## 4. The headline is proved by no declaration

Passage A's headline is $\lambda_{\max}(M)=\theta$, citable only at coordinate-diagonal global maximisers and $S^m\times S^m$, $m\ge4$ (line 290). No declaration mentions $W$, $Q$, $L_e$, coordinate-diagonal tensors or sphere products. The only place $\lambda_{\max}(M)\le\theta$ appears is hlam, a hypothesis of theta_ge_diag, and the reverse inequality $\theta\le\lambda_{\max}(M)$ (Passage B's boxed bound) appears nowhere. So claim 3 is REFUTED. This is the strongest case against the step, and it does not defeat it, because the step asks for a claim **or a component**, and sections 2 and 3 supply both.

## 5. The declarations of L115.lean proper

- lambda2_six, ambient_dim, weyl_six are natural-number identities: $30/2=15$, $240/2=120$, $1008/12=84$. They read as $\dim\Lambda^2\mathbb R^6=15$, $\dim\operatorname{Sym}^2(\Lambda^2\mathbb R^6)=120$ and $\dim\mathcal W_6=n(n+1)(n+2)(n-3)/12=84$. All true, none stated in Passage A.
- The share lemmas: $1/120<1/100$, $1/100<1/84$, and $1/84<12/1000$ because $1000<12\cdot84=1008$. True, not in Passage A.
- cap_on_subspace_transfers_nothing: with $f(p)=p_2$ and $c=0$, $f(t,0)=0\le0$ for all $t$, and $f(0,B+1)=B+1>B$. So a function bounded on a line can be unbounded on the plane. This is a correct abstract instance of the principle Passage A uses at line 288, that a cap proved on $\mathcal W_n\cap W^\perp$ does not transfer to $\mathcal D$. It is a model, a linear functional on $\mathbb Q^2$ in place of the Rayleigh quotient of $L_e$ on $\mathcal D$, so it shows the inference form is invalid and says nothing about whether $\lambda_{\max}(L_e|_{\mathcal D})=1$ is true. Verdict CONFIRMED AS ALGEBRA.
- true_claim_bad_argument: from $C$ and $\neg H$ it gives $(H\to C)\wedge C$. A correct tautology, recording that a true conclusion may sit behind an unusable premise. Not a claim of Passage A.

Under the narrow reading that drops H1, the step is carried only by cap_on_subspace_transfers_nothing as a model of a principle Passage A uses. That is a defensible but thin reading, so the substantive VALID reading names H1.

## 6. c5_exceeds_nonWeyl_cap is outside Passage A

It proves $1/\sqrt2<0.809017$: from $\sqrt2\ge1.4142$ (as $1.4142^2=1.99996164\le2$) one has $0.809017\cdot1.4142=1.1441138...$, which exceeds $1$ as an exact rational product. The inequality is true. The value $0.809017$ is Passage B's $\lambda_{\max}(M)$ at the $C_5$ blow-up, a catalogue decimal, and $1/\sqrt2$ is not named in Passages A to C. Passage A cites the $C_5$ blow-up only through its ratio $1.206$. So this declaration states no claim of Passage A.

## 7. Verdict for step F8

**VALID.** The declarations quoted in Passage D state and prove a component Passage A uses (theta_ge_diag, the inference diag $M=\lambda$ and $\lambda_{\max}(M)\le\theta$ imply $\max_\alpha\lambda_\alpha\le\theta$) and a claim of Passage A (theta_gt_lambda, $\max_\alpha\lambda_\alpha<\theta$ at every global maximiser). The VALID reading needs H1 (both quoted files count as the declarations), H2 and H3 to instantiate theta_ge_diag at $M$, and H4, H5 and H6 to discharge theta_gt_lambda at a global maximiser. The Lean record proves nothing of the headline $\lambda_{\max}(M)=\theta$, which enters only as the hypothesis hlam.
