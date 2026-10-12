# Gate 2 brief, the half-eigenspace at a local maximum

**You are one of two reviewers working from identical briefs, cold and independently.** Work from what is below and from sources you fetch yourself. Do not read the findings file this came from until you have formed your own verdict on every claim.

## Standing rules for this brief

**Analysis only.** Computation requires the user's approval for a specific task and it has not been given here. The one allowance is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. **All arithmetic exact**, rational or symbolic.

**Log** to the path your dispatch names: PID and phase plan on the first line, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before a long reasoning stretch what you are about to derive.

**Committing, under a shared index.** Other reviewers are committing concurrently to the same working tree. **Name your paths on the commit itself**, `git commit -- reviews/REVIEW_r<N>.md reviews/INDEX.md -m "..."`, so a sibling's staged file cannot ride into your commit; staging by path alone does not prevent it. Leave nothing staged. Your scope is your own report, your index row, and any `references/` folder you create. If your index row conflicts, re-read `reviews/INDEX.md` and re-apply it.

**Before you write a discrepancy down**, clear all three or report it `withdrawn` with the reason: **locate it exactly** (step, line, the hypothesis it lacks); **exhibit the failure concretely** in closed form; **argue the opposite**, the strongest reading the words support.

**Silence is not a verdict.** Answer every attack item in writing, including where you find nothing.

## Report format

`reviews/REVIEW_r<N>.md`: title naming the claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**, one row per claim with a verdict in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections carrying each derivation in full; the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file the finding is *"this claim has no argument on file"*, full stop, and the verdict is `HYPOTHESIS-DEBT` naming what would have to be proved.

## Definitions

- $\mathcal W_n$: symmetric operators on $\Lambda^2\mathbb R^n$ satisfying first Bianchi and Ricci-flat; $S$ its unit sphere.
- $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)$ at unit norm, $\mathcal O=SO(n)\cdot W$.
- $L_e$ is the linearisation of the criticality map at $W$, normalised so that $W$ itself is a $1$-eigenvector and the orbit tangent sits at $\tfrac12$; $E(\tfrac12)$ is its $\tfrac12$-eigenspace.
- **On the record already**: $\mathrm{Hess}(P|_S)_W=6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$ on $W^\perp$; $T_W\mathcal O\subseteq E(\tfrac12)$ at every critical point; and a block criterion (*"$W$ is Morse–Bott nondegenerate), $\ker\mathrm{Hess}(P|_S)_W=T_W\mathcal O$, if and only if $\tfrac12$ is NOT an $L_e$-eigenvalue of any four-set block or of $\mathcal D_n\cap W^\perp$, and in every pair block $\tfrac12$ is either absent or simple with eigenvector $o^{jk}$"*, stated for a **pure (frame-diagonal)** critical point. That criterion's own audit records that a block **above** $\tfrac12$ is admissible *"because the hypothesis is criticality, not maximality"*, with $S^2\times S^4$ at $\mu_{2,4}=\tfrac23$ as the witness.

## The statement under review

> Let $W$ be a critical point of $P|_S$ at unit norm with $\theta>0$. **If $W$ is a local maximum then**
> $$E(\tfrac12)=\ker\mathrm{Hess}(P|_S)_W,\qquad\text{so}\qquad E(\tfrac12)=T_W\mathcal O\iff W\ \text{is Morse–Bott nondegenerate.}$$
> Hence the clause *"at a local maximum the $\tfrac12$-eigenspace is exactly the orbit tangent"* is a **nondegeneracy hypothesis** rather than a statement awaiting proof, and at a pure $W$ it is decided by the block criterion above.

## The proof as written

> $\mathrm{Hess}(P|_S)_W=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$, and $\theta>0$, so a local maximum has $L_e\preceq\tfrac12$ there and $\ker\mathrm{Hess}=E(\tfrac12)\cap W^\perp$. **The intersection is the whole eigenspace**: $L_eW=W$, so $E(\tfrac12)\perp W$. Morse–Bott nondegeneracy is $\ker\mathrm{Hess}=T_W\mathcal O$ by definition, which is the equivalence. $\square$

Two claims are made around it:

> **(a)** The two recorded witnesses, $S^3\times S^3$ with $\dim E(\tfrac12)=18$ against an orbit of $9$, and $S^2\times S^3\times S^3$ with $60$ against $21$, are **degenerate critical points and not local maxima**, so both are consistent with the statement. **A degenerate local maximum would refute the clause and would contradict nothing on the record**, so no proof of it is available.
>
> **(b)** At a local maximum the block criterion **simplifies**: four-set blocks lie in $W^\perp$, where $L_e\preceq\tfrac12$, so the exclusion of $\tfrac12$ is the strict inequality $\mu<\tfrac12$. Hence the repair that weakened a downstream obligation from $\Sigma<\theta^2$ to $\Sigma\ne\theta^2$ is right for critical points and unnecessary at maxima.

## What to attack

1. **The Hessian identity's normalisation.** $\mathrm{Hess}=6\theta(L_e-\tfrac12\mathrm{Id})$ is quoted from the record. Does the argument depend on the constant $6\theta$ beyond its **sign**? State exactly what is used, and whether $\theta>0$ is enough or whether $\theta\ne0$ would do.
2. **Second-order optimality.** A local maximum of $P|_S$ gives $\mathrm{Hess}\preceq0$ **on the tangent space to the sphere**, which is $W^\perp$. Is that the right tangent space, and is the passage from $\mathrm{Hess}\preceq0$ to $\ker\mathrm{Hess}=E(\tfrac12)\cap W^\perp$ complete, in particular, does it need $\tfrac12$ to be the *top* $L_e$-eigenvalue on $W^\perp$, and does maximality actually deliver that?
3. **$L_eW=W$.** Derive it rather than reading it, and check that it puts $E(\tfrac12)$ inside $W^\perp$, this is what turns an intersection into the whole eigenspace, and it is one line in the proof.
4. **The definitional step.** "Morse–Bott nondegeneracy is $\ker\mathrm{Hess}=T_W\mathcal O$ by definition", is that the definition in use, or does Morse–Bott nondegeneracy carry more (constant rank, a neighbourhood condition, the critical set being a manifold)? **If it carries more, the equivalence is weaker than claimed.**
5. **Claim (a), the two witnesses.** Are $S^3\times S^3$ and $S^2\times S^3\times S^3$ really not local maxima of $P|_S$? Say how you decided. And is the assertion that a degenerate local maximum *would contradict nothing on the record* checkable, or is it an absence of evidence stated as a fact?
6. **Claim (a)'s strong form.** "No proof of it is available" is a claim about what cannot be proved. **Attack it**: is there any route (real-analyticity of $P$, the Łojasiewicz inequality, compactness of $S$, the $O(n)$-action) that would force nondegeneracy at a maximum? A negative answer needs an argument, not a shrug.
7. **Claim (b), the simplification.** Do four-set blocks lie in $W^\perp$? $W$ is pure, hence in $\mathcal D_n$, check that this puts it outside every four-set block rather than merely generically so. Then check that $L_e\preceq\tfrac12$ on $W^\perp$ turns "$\tfrac12$ is not an eigenvalue" into "$\mu<\tfrac12$", and that nothing in the pair-block half of the criterion is disturbed.
8. **Scope.** The block criterion is stated for **pure** critical points; the statement under review is not. Where does the lemma silently assume purity, and where does it not?
9. **Hypothesis inventory**, and which stated hypotheses go unused.
10. **The edges.** $\theta=0$; $W$ with $\ker W\ne0$; a local maximum that is not the global one; the case $E(\tfrac12)=T_W\mathcal O$ trivially because both are zero; and odd $n$.
11. **Name what would break it**, the object that, if it existed, would falsify the displayed equality, and what you did to look for it.
