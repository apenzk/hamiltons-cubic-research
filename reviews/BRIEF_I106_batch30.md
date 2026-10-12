# Gate 2 brief: batch 30 of the I106 derivation, the commutator relations

You are auditing one block of a research record. **Work from the definitions below and from your own derivations. Do not read the block's supporting scripts, and do not import any code under review.** Your job is to break the claims.

## The standing rule you inherit

**This programme is on an analysis-only footing.** A long or open-ended run (a sweep over a parameter range, a census of a family, an optimisation whose cost is unknown before it starts, a falsifier hunt with no bound on where it looks) is not yours to open. What is permitted: **screening a claim you are about to record**, and any run that finishes in a few minutes on objects already in hand. Where a number is genuinely needed to refute a claim, compute the smallest one that does the job and say why an argument could not replace it.

**Argue from the definitions.** A reviewer that reimplements and agrees has confirmed arithmetic and said nothing about the proof.

## The setting, in full

Let $\hat U$ and $V$ be real symmetric traceless $3\times3$ matrices. Write $\{X,Y\}=XY+YX$, $[X,Y]=XY-YX$, $K=[\hat U,V]$, and $\langle X,Y\rangle=\operatorname{tr}(X^{\mathsf T}Y)$.

The functional is
$$\Phi=\alpha\operatorname{tr}\hat U^3+\beta\operatorname{tr}(\hat UV^2)+\langle\hat U,A\rangle+\langle V,C\rangle,\qquad \alpha=\tfrac{15}4,\quad\beta=\tfrac94,$$
maximised subject to $\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2=T$, where $A$ and $C$ are fixed real symmetric matrices, **both diagonal in one fixed orthonormal frame $F$**, called the field frame. $\alpha-\beta=\tfrac32$.

**Given (batch 10, already on the record, quoted so the items below are answerable).** At a critical point with multiplier $\mu$, the Lagrange conditions are
$$A\equiv3\mu\hat U-3\alpha\hat U^2-\beta V^2,\qquad C\equiv\mu V-\beta\{\hat U,V\},$$
each up to an added multiple of the identity (the multiples arise from the traceless constraint).

**Given (batch 18, already on the record).** At every **global maximum** of $\Phi$ on the constraint surface, $\mu\ge\dfrac{2\beta\lvert\hat U\rvert}{\sqrt6}$. This comes from $V$ solving a trust-region subproblem at fixed $\lvert V\rvert$, whose necessary condition is that the trust-region multiplier $\mu/2$ dominates $\beta\lambda_{\max}(\mathcal L)$ with $\mathcal L V=\tfrac12(\hat UV+V\hat U)$ and $\lambda_{\max}(\mathcal L)=\lvert\hat U\rvert/\sqrt6$ on traceless symmetric matrices.

**Given (batch 18, already on the record).** For traceless $u=(u_1,u_2,u_3)$ and each $k$ with $\{i,j,k\}=\{1,2,3\}$, $2\lvert\hat U\rvert^2-3u_k^2=(u_i-u_j)^2$, where $\lvert\hat U\rvert^2=u_1^2+u_2^2+u_3^2$.

**Given (batch 16, already on the record).** For $\hat U$ with distinct eigenvalues, $\hat U$ and $V$ share an eigenvector exactly when at most one off-diagonal entry of $V$ in $\hat U$'s eigenframe is nonzero. In that eigenframe write $V$'s diagonal as $(a_1,a_2,a_3)$ and its off-diagonal entries as $w_k$, the entry opposite index $k$.

## The block under audit, quoted verbatim from the record

> ## Batch 30, the commutator is carried by the field, and the node reduces to one commutator
>
> **Commuting each Lagrange equation with the other variable gives two identities of the matrix ring.** From $C\equiv\mu V-\beta\{\hat U,V\}$, commuting with $\hat U$ kills the multiple of $I$ and turns $[\hat U,V^2]$ into $[\hat U^2,V]=\{\hat U,K\}$, and from $A\equiv3\mu\hat U-3\alpha\hat U^2-\beta V^2$, commuting with $V$ kills $[V,V^2]$ outright:
> $$\mu K-\beta\{\hat U,K\}=[\hat U,C],\qquad [V,A]=3\alpha\{\hat U,K\}-3\mu K .$$
> **Neither needs symmetry, tracelessness or criticality beyond the single equation it comes from**, so both are identities of $3\times3$ matrices and are typed as such (`commutator_from_C`, `commutator_from_A`), proved by `module` after distributing the products.
>
> **Eliminating $\{\hat U,K\}$ between them leaves $K$ alone on one side.** With $\alpha-\beta=\tfrac{15}4-\tfrac94=\tfrac32\ne0$ and $\mu\ne0$,
> $$3(\alpha-\beta)\,\mu\,K=3\alpha\,[\hat U,C]+\beta\,[V,A].$$
>
> **In $\hat U$'s own eigenframe the first identity is diagonal.** $\{\hat U,K\}$ has entry $(u_i+u_j)K_{ij}$, which tracelessness turns into $-u_kK_{ij}$, so each off-diagonal entry satisfies
> $$(\mu+\beta u_k)\,K_{ij}=[\hat U,C]_{ij},\qquad K_{ij}=(u_i-u_j)V_{ij}.$$
> **Tracelessness is load-bearing here and the screen carries the control that says so**: with $u_1,u_2,u_3$ left free the entrywise form is false while the frame-free form still holds. Typed as `entry_relation` and its two siblings, with `K_zero_of_field_commutes` drawing the conclusion from nonvanishing denominators.
>
> **At a global maximum the denominators cannot obstruct, and the degenerate case closes itself.** Batch 18 gives $\mu\ge2\beta\lvert\hat U\rvert/\sqrt6$, and `jordan_gap_le`'s $3u_k^2\le2\lvert\hat U\rvert^2$ gives $\lvert u_k\rvert\le2\lvert\hat U\rvert/\sqrt6$, so $\mu+\beta u_k\ge0$ for every $k$. *Equality needs both to saturate, and $3u_k^2=2\lvert\hat U\rvert^2$ is exactly $(u_i-u_j)^2=0$ by `jordan_gap`, where $K_{ij}=(u_i-u_j)V_{ij}$ vanishes on its own.* **So at every global maximum, with no hypothesis on the spectrum,**
> $$[\hat U,V]=0\iff[\hat U,C]=0 .$$
>
> **Read in the field frame instead, the same elimination says where $K$ can live.** With $A$ and $C$ diagonal in $F$, $[\hat U,C]_{ij}=\hat U_{ij}(C_j-C_i)$ and $[V,A]_{ij}=V_{ij}(A_j-A_i)$, so
> $$3(\alpha-\beta)\,\mu\,K_{ij}=3\alpha\,\hat U_{ij}(C_j-C_i)+\beta\,V_{ij}(A_j-A_i),$$
> and **$K$ is supported on the pairs where the fields separate**. *In particular a critical point with both fields scalar commutes, and a pair of indices carrying $C_i=C_j$ and $A_i=A_j$ contributes nothing to the commutator whatever $\hat U$ and $V$ do there.*
>
> **What this does to the node.** The open case has been "the two blocks share no eigenvector", a condition on $V$'s off-diagonal entries in $\hat U$'s frame that batch 16 showed is where the system stops being degenerate. **It is now the single condition $[\hat U,C]\ne0$**, the moving block failing to commute with the field the rest of the configuration generates, which is the shape the induction $G(2)\to G(m)$ needs, since the field is what carries the other blocks.
>
> **What is NOT established, and it is the whole remaining gap.** *Nothing here shows $[\hat U,C]=0$.* **Batch 28's four non-commuting critical points are not refuted by any of this**, they satisfy the identities with $[\hat U,C]\ne0$, and the equivalence above is a statement about global maxima resting on batch 18's bound, which those points clear. *What batch 30 buys is that the target is now one commutator rather than a stratum, and that the target is stated in the fields, where the induction hypothesis lives.*

## The claims, one row each, and your verdict on each

| # | claim | verdict |
|---|---|---|
| 1 | $\mu K-\beta\{\hat U,K\}=[\hat U,C]$ follows from the $C$ condition alone | |
| 2 | $[V,A]=3\alpha\{\hat U,K\}-3\mu K$ follows from the $A$ condition alone | |
| 3 | Neither needs symmetry, tracelessness, or any condition beyond its one equation | |
| 4 | $3(\alpha-\beta)\mu K=3\alpha[\hat U,C]+\beta[V,A]$, and the hypotheses it needs are exactly $\alpha\ne\beta$ and $\mu\ne0$ | |
| 5 | In $\hat U$'s eigenframe, $(\mu+\beta u_k)K_{ij}=[\hat U,C]_{ij}$, and tracelessness is load-bearing for this | |
| 6 | At every global maximum $\mu+\beta u_k\ge0$ for every $k$ | |
| 7 | At every global maximum, with no hypothesis on the spectrum, $[\hat U,V]=0\iff[\hat U,C]=0$ | |
| 8 | In the field frame, $3(\alpha-\beta)\mu K_{ij}=3\alpha\hat U_{ij}(C_j-C_i)+\beta V_{ij}(A_j-A_i)$ | |
| 9 | A critical point with both fields scalar has $[\hat U,V]=0$ | |
| 10 | The block's disclaimer is accurate: nothing here establishes $[\hat U,C]=0$, and batch 28's non-commuting critical points are untouched | |

## What to attack hardest, and why each is a real risk

1. **Claim 7 is the headline and it has an edge case the block handles in one clause.** The argument is: $\mu+\beta u_k=0$ would force $\lvert u_k\rvert=2\lvert\hat U\rvert/\sqrt6$, hence $(u_i-u_j)^2=0$, hence $K_{ij}=(u_i-u_j)V_{ij}=0$ anyway. **Check every step of that chain, including the sign of $u_k$, the case $\hat U=0$, the case $\mu=0$, and whether $\beta>0$ is used.** Say whether the claim survives as stated, or needs a hypothesis the block does not carry.

2. **Claim 5's converse direction.** The block concludes $K=0$ from $[\hat U,C]=0$. Check that the forward direction is equally free, and that no entry with $u_i=u_j$ is being quietly handled twice.

3. **Is batch 30 new information, or a rearrangement of batch 15?** The record already derives a system from $[A,C]=0$, namely $(u_i-u_j)V_{ij}\,q(u_k)=\beta^2(VKV)_{ij}$ with $q(t)=3\alpha\beta t^2+3\mu(\alpha+\beta)t+3\mu^2-\tfrac12\beta^2\lvert V\rvert^2$. **Determine whether relations 1, 2 and 4 are independent of that system or derivable from it**, and say which. A block recorded as new information that is a rearrangement of a recorded one is a defect worth the whole round.

4. **Claim 8's signs.** $[\hat U,C]_{ij}=\hat U_{ij}(C_j-C_i)$ has a sign that is easy to flip, and a flipped sign makes claim 9 and the support statement wrong in a way that no symmetric check would see.

5. **Vacuity.** Ask of claims 7 and 9 what they would look like if they were trivially true. Claim 9 in particular: if both fields are scalar, is the critical point forced to be something degenerate for an unrelated reason, making the conclusion empty?

6. **Whether the reduction is circular.** The block says the open stratum "is now one commutator". Check that $[\hat U,C]=0$ is not simply a restatement of $[\hat U,V]=0$ via the $C$ condition in a way that makes the reduction say nothing.

## The Lean declarations that type these claims

They live in `lean/HamiltonsCubic/Results/I106Criticality.lean`: `commutator_from_C` (claim 1), `commutator_from_A` (claim 2), `entry_relation`, `entry_relation'`, `entry_relation''` (claim 5), `K_zero_of_field_commutes` (claim 5's conclusion, taking $[\hat U,C]=0$ and the three nonvanishing denominators as hypotheses). **Claims 4, 6, 7, 8, 9 and 10 are typed nowhere**, which is itself something to report on: say for each whether a Lean statement could carry it and what would be needed.

You may read that file. **Do not treat a successful build as evidence that a declaration says what the block claims**: compare the statement against the block's words and report any mismatch, including a statement quantified over the wrong objects, weakened to something the claim implies, or vacuous.

## Deliverables

Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per row, with corrections, and a short statement of what you would change in the record.

**Commit a skeleton report in your first phase and update it**, rather than writing one at the end: the first commit is the title, the claim table with every verdict `NOT REACHED`, and your log path. **Do not write to `reviews/INDEX.md`**, which the parent writes after every report of the round has landed.

**Log** to `agent_logs/<your task name>.log`: first line carrying your PID and phase plan, a line at every phase transition, a heartbeat at least every three minutes carrying live state rather than "still working", and a closing `DONE <summary>` or `FAILED <reason>` as the last line written, with that word opening the line.
