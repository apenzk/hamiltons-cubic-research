# Gate 2 brief, padding preserves the norm and $\theta$

**You are one of two reviewers working from identical briefs, cold and independently.** Work from the definitions below and from sources you fetch yourself. Do not read the findings files this statement came from until you have formed your own verdict on every claim; then, if you wish, read them only to check whether a defect you found is already recorded.

## Standing rules for this brief

**Analysis only.** This programme is on an analysis-only footing: computation requires the user's approval for a specific task, and that approval has not been given here. What remains permitted without asking is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. A counterexample is exhibited in closed form or it is not a counterexample.

**All arithmetic is exact**, rational or symbolic. A floating-point residual is not an argument in either direction.

**Log** to `agent_logs/g2-l164-r<N>.log`: first line with PID and phase plan, a line at every tool round carrying live state, and a closing `DONE <verdict>` or `FAILED <reason>`. Say in the log before a long stretch of reasoning what you are about to derive, so a gap reads as depth rather than as death.

**Write** your report to `reviews/REVIEW_r<N>.md`, **index it in `reviews/INDEX.md` in the same commit**, and commit both yourself, `review(l164): r<N> <verdict>`. **Stage by path; never `git add -A`; leave nothing staged.** Your scope is your own report, the index row, and any `references/` folder you create. Nothing else.

## Definitions, fixed before anything else

- $\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: symmetric operators on $\Lambda^2\mathbb R^n$ satisfying the first Bianchi identity and Ricci-flat.
- **Inner product.** The $\tfrac12$ goes at the $\Lambda^2$ level: $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ for skew matrices, so the coordinate bivectors $\varphi_{ab}=E_{ab}-E_{ba}$ have $\lVert\varphi_{ab}\rVert^2=1$ and $\{\varphi_{ab}\}_{a<b}$ is orthonormal. (Under plain Frobenius the same bivector has squared norm $2$; the record runs on the half-trace pairing.) On operators the pairing is plain Frobenius.
- **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ in an orthonormal basis $\{v_a\}$ of $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, totally antisymmetric.
- **The sharp product** is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$; in the basis above, $(W^\#)_{ab}=\sum c_{acd}c_{bef}W_{ce}W_{df}$.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $\theta(W)=P(W)/\lVert W\rVert^3$.
- $\mathrm{Ric}$ is the adjoint of $\cdot\wedge\mathrm{id}$.
- **"Padding"**: for $U\subseteq\mathbb R^n$ a subspace, a tensor supported on $\Lambda^2U$, extended by zero.

## The statement under review

> **Statement.** Let $W\in\mathcal W_n$ vanish on $u\wedge u^\perp$ for every $u\perp U$, so that $W$ is supported on $\Lambda^2U$. Then the restriction $W'=W|_{\Lambda^2U}$ lies in $\mathcal W_{\dim U}$, and
> $$\lVert W'\rVert=\lVert W\rVert,\qquad P(W')=P(W),\qquad \theta(W')=\theta(W).$$

## The proof as written

> **Proof.** *Four steps, and the third is the only one that needs anything.*
>
> **(i) The support.** $\Lambda^2\mathbb R^n=\Lambda^2U\oplus(U\otimes U^\perp)\oplus\Lambda^2U^\perp$, and the hypothesis kills $W$ on the last two summands, so $W$ maps $\Lambda^2U$ into itself and annihilates its complement.
>
> **(ii) The norm.** The coordinate bivectors $\varphi_{ij}$ with $i<j$ in $U$ are orthonormal for the half-trace pairing **in $\Lambda^2U$ and in $\Lambda^2\mathbb R^n$ alike**, so $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ is an isometry and $\lVert W'\rVert=\lVert W\rVert$ by (i).
>
> **(iii) The two quadratic terms.** $W^2$ restricts because $W$ preserves $\Lambda^2U$ and kills its complement. For the sharp, $(W^\#)_{ab}=\sum c_{acd}c_{bef}W_{ce}W_{df}$: **the factors $W_{ce},W_{df}$ force $c,d,e,f\in\Lambda^2U$**, and then $c_{acd}=\langle[v_c,v_d],v_a\rangle$ forces $a\in[\Lambda^2U,\Lambda^2U]\subseteq\Lambda^2U$, **since $\Lambda^2U=\mathfrak{so}(U)$ is a subalgebra**. *So $W^\#$ is supported on $\Lambda^2U$ and its entries there are computed with $\mathfrak{so}(U)$'s own structure constants, which are $\mathfrak{so}(n)$'s restricted.* Hence $Q(W)$ is supported on $\Lambda^2U$ and restricts to $Q(W')$.
>
> **(iv) Membership.** First Bianchi at indices in $U$ is a sub-family of first Bianchi on $\mathbb R^n$, so it is inherited; pair symmetry likewise; and Ricci-flatness of the restriction holds because the terms of $\mathrm{Ric}$ involving directions outside $U$ vanish with $W$.
>
> Then $P(W')=\langle W',Q(W')\rangle=\langle W,Q(W)\rangle=P(W)$ by (i)–(iii), and $\theta=P/\lVert W\rVert^3$ follows from that and (ii). $\square$

The entry also records what it does **not** claim: the operator identity $Q(\mathrm{pad}\,W')=\mathrm{pad}\,Q(W')$ for arbitrary tensors. Judge that disclaimer too, is the weaker scalar statement really all the displayed equalities need?

## What to attack, and answer every item in writing

**Silence is not a verdict.** Answer each item below explicitly, including the ones where you find nothing, *"no finding: …"* is an answer, saying nothing is not. A report missing an item is returned rather than counted.

1. **The three steps the author judged to be one line each.** These were written fast and are the likeliest site of a defect:
   - **(ii)** Does the half-trace pairing really make $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ an isometry, and does that give $\lVert W'\rVert=\lVert W\rVert$ for the *operator* norm the record uses? The operator norm is a Frobenius norm on $\mathrm{End}(\Lambda^2)$, not the bivector norm, check whether the step conflates the two, and whether the pairing on $\mathrm{End}$ inherits the $\tfrac12$.
   - **(iv), Bianchi.** Is first Bianchi genuinely inherited by restricting the index range? State the identity in the index form the record uses and check whether restricting $i,j,k,l$ to $U$ yields exactly a sub-family, or whether the identity on $U$ involves indices the restriction has thrown away.
   - **(iv), pair symmetry.** *"likewise"* is the whole argument. Is it?
2. **(iii), the sharp.** Two separate claims are made: that $W^\#$ is *supported* on $\Lambda^2U$, and that its *entries there* are computed with $\mathfrak{so}(U)$'s own structure constants. Check both. In particular: the sum defining $(W^\#)_{ab}$ runs over all $c,d,e,f$ in $\Lambda^2\mathbb R^n$, does the vanishing of $W$ off $\Lambda^2U$ really kill every term with an index outside, and is $c_{acd}$ with $c,d\in\Lambda^2U$ and $a\notin\Lambda^2U$ genuinely zero? Give the bracket computation, not the assertion.
3. **The index-set claim $[\Lambda^2U,\Lambda^2U]\subseteq\Lambda^2U$** is a statement about the Lie algebra; the proof uses it to constrain a *basis index* $a$. Is the step from "the bracket lies in the subalgebra" to "the coefficient against $v_a$ vanishes for $a$ outside" complete, and does it need the basis to be adapted to the splitting?
4. **The final chain.** $P(W')=\langle W',Q(W')\rangle=\langle W,Q(W)\rangle$, check the middle equality on the nose, with the pairing convention above, including whether restricting an operator to a subspace preserves the trace pairing when the complement is annihilated.
5. **Hypothesis inventory.** List every hypothesis of the statement, then every hypothesis of every imported fact the proof uses, then check each against the object it is applied to. **Which stated hypotheses does the written proof actually use?** A hypothesis nobody uses and a step using a hypothesis nobody stated are both findings. Note in particular that the statement is quantified over $W\in\mathcal W_n$ and asks the conclusion at *every* $U$ meeting the support hypothesis.
6. **The edges.** $\dim U=n$ (the hypothesis is vacuous, does the conclusion still read correctly?); $\dim U\le 3$, where $\mathcal W_{\dim U}=0$; $\dim U=4$, where the $\Lambda^\pm$ splitting exists; odd $\dim U$; and $W=0$, where $\theta=P/\lVert W\rVert^3$ is $0/0$. **Is the $\theta$ equality stated without a nonvanishing hypothesis?**
7. **$\ker W\neq0$**, this record's recurring obstruction. Ask what the statement says at an object with a large kernel, and whether $U$ is even determined by $W$ in that case.
8. **A universal claim with no witness.** Try the statement against one object from each structured family the record names: sphere products $W_{p,q}$, $W_{\mathbb{CP}^m}$, paddings of those, subalgebra-Casimir tensors, and the tori. Random objects cannot see these failures.
9. **Name what would break it.** End by naming the object that, if it existed, would falsify the statement, and say what you did to look for it. A reviewer who cannot say what a counterexample would look like has read the proof without understanding what it claims.

## Before you write a discrepancy down

Clear all three, or report it as `withdrawn` with the reason:

1. **Locate it exactly**, name the step, quote the line, say which hypothesis or definition it needs and does not have.
2. **Exhibit the failure concretely**, the object or parameter value at which the step breaks, in closed form.
3. **Argue the opposite**, state the most charitable reading the words support, including a hypothesis the author may have meant but not written.

## Report format

`reviews/REVIEW_r<N>.md`, in this order: title naming the specific claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**, one row per claim with its verdict in caps and the reason compressed to a clause; a one-line summary someone can act on without reading the derivation; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections carrying each derivation in full; and the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file, the finding is *"this claim has no argument on file"*, full stop. Supplying the missing argument hands the record fresh mathematics nobody audited, arriving under the letterhead of a check. The correct output there is `HYPOTHESIS-DEBT`, naming precisely what would have to be proved.
