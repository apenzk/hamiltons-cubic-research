# Gate 2 brief: the first-order condition on $O(k)$, and what it forces

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the working note this block was drawn from, do not import the scripts, and do not read the other reviewer's report.

**This round audits an object nobody has audited.** Two earlier reviewers derived it independently while answering a different question, and their agreement is evidence that it is easy to reach, not that it is right. **It is now the object the whole $\lvert J\rvert=3$ node rests on**, so an error here is the expensive kind.

## The setting, quoted from the route register and NOT restated

> the $V$-frame dependence of the value is $\sum_k\big(\beta\nu_k^2\,p_k^{\mathsf T}\hat Up_k+\nu_k\,p_k^{\mathsf T}Cp_k\big)$ over an orthonormal frame

$\hat U$ and $C$ are fixed real symmetric $k\times k$ matrices, $\nu\in\mathbb R^k$ is fixed, $\beta=\tfrac94$, and $P$ ranges over $O(k)$ with columns $p_k$. Write $\tilde U=P^{\mathsf T}\hat UP$, $\tilde C=P^{\mathsf T}CP$, $a=\beta\nu^{\circ2}$ and $b=\nu$, so the value is $\operatorname{tr}(\operatorname{diag}(a)\tilde U)+\operatorname{tr}(\operatorname{diag}(b)\tilde C)$.

**Given, and NOT under review**: `Splits` is the record's two-sided block condition, a proper nonempty row set $R$ and an equinumerous column set $C$ with the matrix vanishing on $R\times C^{\mathsf c}$ and on $R^{\mathsf c}\times C$, rows and columns permuted independently.

## The block under review, quoted verbatim from disk

> **The first-order lemma.** Criticality on $O(k)$ is
> $$(a_i-a_j)\tilde U_{ij}+(b_i-b_j)\tilde C_{ij}=0\qquad\text{for all }i\ne j,$$
> equivalently $(\nu_i-\nu_j)\big[\beta(\nu_i+\nu_j)\tilde U_{ij}+\tilde C_{ij}\big]=0$.
>
> **With $\nu$ pairwise distinct and $\tilde U$ diagonal, $\tilde C$ is diagonal, hence $[\hat U,C]=0$.** This holds at every $k$, at every critical point rather than only at maxima, and with no numerics.
>
> **Run with $\tilde U$ merely BLOCK diagonal, which is what `Splits` gives**, it yields simultaneous BLOCK diagonalisation of $\tilde U$ and $\tilde C$, and that does not imply commuting.
>
> *The distinctness hypothesis is necessary: with $\nu_1=\nu_2$ the value is invariant under rotations of the $(p_1,p_2)$ plane and the converse fails.*

## The claims to attack

| # | claim | kind |
|---|---|---|
| 1 | Criticality on $O(k)$ is exactly $(a_i-a_j)\tilde U_{ij}+(b_i-b_j)\tilde C_{ij}=0$ for all $i\ne j$ | mathematics |
| 2 | That is equivalent to $(\nu_i-\nu_j)[\beta(\nu_i+\nu_j)\tilde U_{ij}+\tilde C_{ij}]=0$ | mathematics |
| 3 | It holds at every critical point, not only at maxima, and is $\lvert J\rvert$-free | mathematics |
| 4 | With $\nu$ pairwise distinct and $\tilde U$ diagonal, $\tilde C$ is diagonal | mathematics |
| 5 | Hence $[\hat U,C]=0$ | mathematics |
| 6 | With $\tilde U$ block diagonal it gives simultaneous block diagonalisation, which does NOT imply commuting | mathematics |
| 7 | The distinctness hypothesis is necessary, not decorative | mathematics |

## The Lean declarations, one row per claim

| # | Lean |
|---|---|
| 1 | none: criticality needs a differential on $O(k)$, and the base layer carries matrices with no smooth structure. `grad_pairing` in [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) types the algebraic half of the ANALOGOUS single-matrix statement and is not this |
| 2 | none as stated, being an algebraic rearrangement of row 1, but the factorisation $a_i-a_j=\beta(\nu_i-\nu_j)(\nu_i+\nu_j)$ is a `ring` identity and IS typeable. *It is not typed* |
| 3 | none: a statement about which points a condition holds at, quantifying over critical points |
| 4 | none: it quantifies over diagonality of a conjugated matrix, and conjugation by a variable frame is not an object here |
| 5 | none: `Matrix.commute` exists and the step from a shared eigenframe to commuting is one line, but the hypothesis is row 4's conclusion, which is not typed |
| 6 | none: block diagonality is `Splits`-adjacent, and [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean)'s `Splits` types the record's two-sided condition rather than block diagonality of a conjugate |
| 7 | none: a necessity claim, established by a counterexample, and counterexamples are objects rather than propositions here |

## What to do

1. **Claim 1 is the whole round. Derive it yourself from scratch**, differentiating along $P\exp(t\Omega)$ for skew $\Omega$, and say whether the condition is exactly as stated or carries a factor, a sign, or a symmetrisation the block has dropped. **Say explicitly whether it is "for all $i\ne j$" or only for $i<j$, and whether that matters.**
2. **Claim 3 hides the load-bearing word "exactly".** A necessary condition at a critical point is not the same as a characterisation. Is the displayed equation equivalent to criticality, or merely implied by it?
3. **Claim 4 is where a reader nods.** It reads as immediate. Check whether $\tilde U$ diagonal really forces $\tilde C_{ij}=0$ for ALL $i\ne j$, or only where $\nu_i\ne\nu_j$, and whether the block has stated the hypothesis it actually needs.
4. **Claim 5 is a one-line inference that crosses a frame.** $\tilde U$ and $\tilde C$ diagonal in the SAME frame gives $[\tilde U,\tilde C]=0$, and the block concludes $[\hat U,C]=0$. Confirm conjugation preserves that, and say whether anything is assumed about $P$ being orthogonal rather than merely invertible.
5. **Claim 6 is the one that killed the previous round's conclusion, so it should be the most suspect.** Verify that block diagonality of $\tilde U$ forces the same block structure on $\tilde C$, and give an explicit pair that is simultaneously block diagonal without commuting.
6. **Claim 7**: produce the degenerate counterexample yourself rather than accepting it, and say whether $\nu$ can in fact repeat in the node's own setting, which decides whether the hypothesis is a restriction or free.
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.** Claim 4 in particular: if $\tilde U$ diagonal already forced $P$ to be the eigenframe of $\hat U$, the claim would be a restatement rather than a deduction, so say which.

**The most useful thing you can do is settle claim 1 exactly**, because every other claim is a corollary of it and two prior derivations of it agree, which is weaker evidence than it looks.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, and any run finishing in a few minutes on objects already in hand.

**A control is an assertion, never a printed expectation.**

**Report.** Write `reviews/REVIEW_r<N>.md`, skeleton in your first phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_r<N>.md`, never `git add -A` and never `git commit -a`. **Never amend.** **Do not write to [reviews/INDEX.md](INDEX.md).**

**Log** to `agent_logs/<task-name>.log`: PID and phase plan on the first line, a line per phase, a heartbeat at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.
