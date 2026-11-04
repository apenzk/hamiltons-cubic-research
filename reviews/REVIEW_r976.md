# REVIEW_r976: the face of the orthostochastic image, the first-order condition, and what R28 needs

Reviewer **r976**, Gate 2 on the I106b face block, brief [BRIEF_I106b_face.md](BRIEF_I106b_face.md). Log: [agent_logs/r976-face.log](../agent_logs/r976-face.log). Screen: an independent implementation written for this review, every control an assertion, reported below.

Throughout I write $n$ for the size of the matrices and keep $i,k$ for indices, because the block's own $k$ names the size in $O(k)$ and $X_k$ and simultaneously the column index in $\nu_k$, $p_k$ and $A_{ik}$. That collision is a wording defect worth fixing at the source.

## Verdicts

| # | claim | kind | verdict |
|---|---|---|---|
| 1 | value $=\langle R,A\rangle$, $A_{ik}=\beta\nu_k^2u_i+\nu_kc_i$ | mathematics | **CONFIRMED** |
| 2 | $A=u(\beta\nu^{\circ2})^{\mathsf T}+c\nu^{\mathsf T}$ has rank at most 2 | mathematics | **CONFIRMED** |
| 3 | max over $X_n$ is max of $f(Q)=\sum A_{ik}Q_{ik}^2$ over $O(n)$ | mathematics | **CONFIRMED**, in both directions, the fibres harmless |
| 4 | $\mathrm df_Q[Q\Omega]=2\langle Q^{\mathsf T}(A\circ Q),\Omega\rangle$ | mathematics | **CONFIRMED**, re-derived |
| 5 | criticality is exactly symmetry of $Q^{\mathsf T}(A\circ Q)$ | mathematics | **CONFIRMED**, an equivalence and not an implication |
| 6 | $\{\mathop{\mathrm{tr}}=0\}$ is a face of $X_n$ relative to its affine hull | mathematics | **REFUTED as stated, and repaired**: $X_n$ is not convex for $n\ge3$ |
| 7 | the second-order condition is batch 21 transported | a shape | **the flag is right**, the correspondence is generic rather than a transport, and the condition is derived below |
| 8 | avoidance is false, so the hand-down is the right thing to need | mixed | **CONFIRMED**, with an exact witness replacing the counts, and the theorem strengthened to unconditional |

**Which verdicts bear on what.** Claims 1 to 5 are the derivation and they stand. Claim 6 is the geometry and its wording fails while its substance survives. Claim 7 is the shape and is graded only as a shape. Claim 8 is mixed and both halves stand. **The derivation does not carry the shape**: nothing in claims 1 to 5 is evidence for claim 7, and claim 7 is the one line of the block a later rung could cite as if it had been derived.

## The finding that outranks the brief: the maximum is always attained at a permutation matrix

**This follows from the block's own claims 1, 3 and 6 and nothing else, and it makes the face analysis unnecessary rather than wrong.**

The block establishes that the value is a linear functional on $X_n$ and stops there. One more line finishes the problem. Every $Q^{\circ2}$ is doubly stochastic, so $X_n\subseteq B_n$. Every permutation matrix is orthostochastic, being $\varphi_r$ of itself, so $\Pi_n\subseteq X_n$. Birkhoff gives $B_n=\mathop{\mathrm{conv}}(\Pi_n)$, so

$$\Pi_n\subseteq X_n\subseteq B_n=\mathop{\mathrm{conv}}(\Pi_n)\subseteq\mathop{\mathrm{conv}}(X_n)\subseteq B_n,\qquad\text{hence}\qquad \mathop{\mathrm{conv}}(X_n)=B_n .$$

A linear functional has the same maximum over a set and over its convex hull, so $\max_{X_n}\langle R,A\rangle=\max_{B_n}\langle R,A\rangle$, and the right-hand maximum is attained at a vertex of $B_n$, which is a permutation matrix, which lies in $X_n$. **So the maximum of R28's frame functional is attained at a permutation matrix for every $A$, and computing it is a linear assignment problem, $\max_{\sigma\in S_n}\sum_iA_{i\sigma(i)}$.**

Two consequences, both of which bear on the rest of the round.

- **The hand-down R28 needs is unconditional.** A permutation matrix becomes $I_n$ under a column permutation, and $I_n=I_a\oplus I_{n-a}$ for any $1\le a\le n-1$, so every permutation matrix splits in the block's own sense, at any prescribed pair of block sizes. The maximum is therefore attained at a splitting point whether or not it is attained at a zero-diagonal one. Claim 8's theorem is true, and true for a reason that does not use its hypothesis.
- **The first- and second-order machinery is not needed to locate the maximum.** It remains correct, and it remains the right tool for describing the other critical points, but the rung of the induction does not have to pass through it.

**The one hypothesis this rests on** is the block's own reading of the given, that $P$ ranges over all of $O(n)$ while $u$, $c$ and $\nu$ stay fixed. That is exactly what "a linear functional on a compact set" asserts. If R28's real variational problem couples the frame to the fields, then linearity survives for the frame-only variation but the feasible set is no longer all of $X_n$, and the argument above proves only that the frame-only maximum sits at a permutation. **The parent should state which it is**, because everything above turns on it.

## Claim 1, CONFIRMED

With $R=P^{\circ2}$ one has $R_{ik}=(p_k)_i^2$, so for diagonal $\hat U=\mathop{\mathrm{diag}}(u)$,

$$p_k^{\mathsf T}\hat Up_k=\sum_iu_i(p_k)_i^2=\sum_iu_iR_{ik}=(R^{\mathsf T}u)_k,$$

and the same for $C$. Summing,

$$\sum_k\big(\beta\nu_k^2(R^{\mathsf T}u)_k+\nu_k(R^{\mathsf T}c)_k\big)=\sum_{i,k}R_{ik}\big(\beta\nu_k^2u_i+\nu_kc_i\big)=\langle R,A\rangle .$$

The identity uses only that $\hat U$ and $C$ are diagonal in the frame the index $i$ runs over. Screened at $1.4\cdot10^{-14}$ over 200 draws at $n=3,4,5,6$, as an assertion.

## Claim 2, CONFIRMED

$A_{ik}=u_i\cdot\beta\nu_k^2+c_i\cdot\nu_k$ is by inspection $u(\beta\nu^{\circ2})^{\mathsf T}+c\nu^{\mathsf T}$, a sum of two rank-one matrices, so $\mathop{\mathrm{rank}}A\le2$. Asserted on every draw of the screen.

**When it drops below 2**: exactly when $\{u,c\}$ is linearly dependent, or $\{\nu^{\circ2},\nu\}$ is, the latter meaning $\nu_k\in\{0,\lambda\}$ for a single $\lambda$ and every $k$. Generically the rank is exactly 2.

**What breaks if it is wrong**, which the brief asks for. Structurally, nothing: the reduction to the assignment problem above holds for every $A$ whatever its rank, and so do claims 3, 4, 5 and the second-order condition below. What the rank governs is which permutations win and how degenerate the ties are, and therefore whether a screen is representative. **A screen at generic full-rank $A$ answers a different question in one specific way**: the family here is a $3n$-parameter family with the coupling $a=\beta b^{\circ2}$ between the two column vectors $a_k=\beta\nu_k^2$ and $b_k=\nu_k$, and a positivity or sign pattern that holds on that family need not hold on generic $A$, nor the reverse. The brief is right to make this a claim. It is correct as stated, and the caution attached to it is the real content.

## Claim 3, CONFIRMED, in both directions

$f=\langle\cdot,A\rangle\circ\varphi_r$ by construction, since $f(Q)=\langle A,Q^{\circ2}\rangle=\langle\varphi_r(Q),A\rangle$. Because $\varphi_r$ maps $O(n)$ **onto** $X_n$ by definition of $X_n$, the two suprema agree.

**The quantifier the brief asks about causes no trouble, and the reason is worth stating.** $f$ is constant on the fibres of $\varphi_r$, being a function of $\varphi_r(Q)$ alone. Hence

$$\mathop{\mathrm{arg\,max}}_{O(n)}f=\varphi_r^{-1}\Big(\mathop{\mathrm{arg\,max}}_{X_n}\langle\cdot,A\rangle\Big),$$

an exact correspondence in both directions: a maximiser of $f$ pushes to a maximiser of the linear functional, and every preimage of a maximiser of the linear functional maximises $f$. **Nothing is lost and nothing spurious is gained.** The fibre of $\varphi_r$ over $R$ consists of the sign patterns $Q\mapsto D_1QD_2$ with $D_i$ diagonal signs, together with any further coincidences, and since splitting and zero-diagonality are both properties of the entrywise absolute values, they are constant on fibres too. So the block is entitled to use the correspondence to talk about where the maximum is, not only about its value.

One wording point. "Maximising a quadratic form over the group" is right in the sense that $f(Q)=\sum_kq_k^{\mathsf T}D_kq_k$ with $q_k$ the $k$-th column and $D_k=\mathop{\mathrm{diag}}(A_{\cdot k})$, a sum of quadratic forms in the columns. It is not a quadratic form in $Q$ of the $\mathop{\mathrm{tr}}(Q^{\mathsf T}BQD)$ shape that the phrase often names in this literature, and a reader may expect the latter.

## Claim 4, CONFIRMED, re-derived

Re-derived rather than checked, as the brief asks.

**The Hadamard step.** For any $A,B,Z$ of the same shape, $\langle A,B\circ Z\rangle=\sum_{i,k}A_{ik}B_{ik}Z_{ik}=\langle A\circ B,Z\rangle$, because both sides are the same triple sum. The step is entrywise and needs no property of $Q$.

**The differential.** $f(Q)=\sum_{i,k}A_{ik}Q_{ik}^2$ is a polynomial on all of $\mathbb R^{n\times n}$, with $\mathrm df_Q[Z]=2\sum_{i,k}A_{ik}Q_{ik}Z_{ik}=2\langle A\circ Q,Z\rangle$ for every ambient direction $Z$.

**Moving $Q$ across the pairing.** $\langle X,QY\rangle=\mathop{\mathrm{tr}}(X^{\mathsf T}QY)=\mathop{\mathrm{tr}}((Q^{\mathsf T}X)^{\mathsf T}Y)=\langle Q^{\mathsf T}X,Y\rangle$, valid for any $Q$ whatever, orthogonality unused. With $X=A\circ Q$ and $Z=Q\Omega$ this gives $\mathrm df_Q[Q\Omega]=2\langle Q^{\mathsf T}(A\circ Q),\Omega\rangle$.

**Whether the tangent should be $Q\Omega$ or $\Omega Q$, and whether it matters.** Both parametrise the same tangent space, $T_QO(n)=\{Q\Omega:\Omega^{\mathsf T}=-\Omega\}=\{\Omega'Q:\Omega'^{\mathsf T}=-\Omega'\}$, related by $\Omega'=Q\Omega Q^{\mathsf T}$, which is skew when $\Omega$ is. Running the derivation the other way gives $\mathrm df_Q[\Omega'Q]=2\langle(A\circ Q)Q^{\mathsf T},\Omega'\rangle$, so the right-multiplied version produces the condition that $(A\circ Q)Q^{\mathsf T}$ be symmetric. **The two conditions are equivalent**, since $(A\circ Q)Q^{\mathsf T}=Q\big(Q^{\mathsf T}(A\circ Q)\big)Q^{\mathsf T}$ and conjugation by an orthogonal matrix preserves symmetry. So the choice is presentational.

**The Lean row is the right one.** Stating `grad_pairing` for every $W$ rather than only skew $W$ is correct and is the honest split: the identity is ambient algebra, and the restriction to skew is what converts it into a condition. My screen tested it for every $W$, not only skew ones, against a central difference along $Q\exp(tW)$: worst relative error $4.4\cdot10^{-9}$ over 120 draws, asserted.

## Claim 5, CONFIRMED as an equivalence

The brief asks whether $\Omega\mapsto\langle S,\Omega\rangle$ vanishing on all skew $\Omega$ gives symmetry of $S$ or something weaker. **It gives symmetry, exactly.**

Split $S=S_++S_-$ into symmetric and skew parts. The Frobenius pairing makes those subspaces orthogonal, $\langle S_+,\Omega\rangle=0$ for every skew $\Omega$, so $\langle S,\Omega\rangle=\langle S_-,\Omega\rangle$ for every skew $\Omega$. Vanishing for all skew $\Omega$ therefore says $S_-\perp$ the whole skew space, and $S_-$ lies in that space, so $S_-=0$. Testing against the basis $E_{ab}-E_{ba}$ alone already gives $S_{ab}=S_{ba}$ for each pair.

So criticality of $f|_{O(n)}$ at $Q$, which is the vanishing of $\mathrm df_Q$ on the whole tangent space and nothing more, is **equivalent** to symmetry of $Q^{\mathsf T}(A\circ Q)$, and the block's "criticality is that" is not a definition dressed as a theorem. Two caveats worth keeping visible: this is criticality of the **restriction** to $O(n)$ rather than of $f$ on the ambient space, and the equivalence is over $\mathbb R$ with the standard pairing, which is the setting here.

The Lean row is again honest. Calling `grad_pairing` the algebraic half and declining to type the equivalence, for want of a differential in that layer, is the correct refusal.

## Claim 6, REFUTED as stated, and repaired

**The three facts about $\mathop{\mathrm{tr}}$ are all correct.** $\mathop{\mathrm{tr}}(R)=\sum_iQ_{ii}^2\ge0$ on the image, it vanishes iff every $Q_{ii}=0$, which is exactly "the image of a zero-diagonal $Q$", and it is nonconstant because $\varphi_r(I)=I$ has trace $n$ while for $n\ge2$ the swap has trace $0$. The three Lean declarations typing exactly these three facts, with no hypotheses, are correctly scoped.

**The inference to "a face relative to the affine hull" is where it fails.** The implication "an affine functional nonnegative on $C$ and vanishing somewhere cuts out a face of $C$" is a theorem of convex geometry and uses the convexity of $C$. **$X_n$ is not convex for any $n\ge3$**, and here is a self-contained proof by dimension rather than by exhibiting a doubly stochastic non-orthostochastic matrix.

- $X_n$ contains every permutation matrix, and the permutation matrices affinely span the affine hull of $B_n$, of dimension $(n-1)^2$. So $\dim\mathop{\mathrm{aff}}(X_n)=(n-1)^2$.
- $X_n=\varphi_r(O(n))$ is the smooth image of a compact manifold of dimension $n(n-1)/2$, so it has Hausdorff dimension at most $n(n-1)/2$ and in particular empty interior relative to its affine hull whenever $n(n-1)/2<(n-1)^2$, that is whenever $n>2$.
- A convex set has the dimension of its affine hull. $X_n$ does not, for $n\ge3$. So it is not convex.

At $n=2$ the claim is fine, $X_2=B_2$ being a segment. For $n\ge3$ the word "face" is applied to a set that has none in the sense the word carries, and the relative-interior language compounds it, since $X_n$ has empty relative interior in its own affine hull.

**The repair, which is what makes the headline above work.** Two true statements sit underneath the false one.

1. $F=\{\mathop{\mathrm{tr}}=0\}\cap B_n$ is a genuine face of the Birkhoff polytope, by the convex-geometry theorem applied where its hypothesis holds, and $\mathop{\mathrm{tr}}$ is affine everywhere and nonconstant on $\mathop{\mathrm{aff}}(B_n)=\mathop{\mathrm{aff}}(X_n)$. The set the block cares about is $X_n\cap F$.
2. Without any convexity, $\{\mathop{\mathrm{tr}}=0\}\cap X_n$ is the set of **minimisers of an affine functional over $X_n$**, which is the property any argument would actually use. This is the extended sense in which the block's instinct is right.

**Why the failure is quiet, as the brief predicted.** Nothing downstream in the block breaks, because the block never uses a face property. It uses only that $\mathop{\mathrm{tr}}$ is nonnegative and vanishes exactly there. The damage is that the word "face" invites the reader to import convexity, and once convexity is imported the reader is one step from the Birkhoff argument, which is the step nobody took. **The correction is therefore productive rather than pedantic: repairing the word to "a face of $B_n$, met in $X_n$" is what exposes $\mathop{\mathrm{conv}}(X_n)=B_n$ and finishes the problem.**

## Claim 7, the second-order condition, derived

The brief says deriving it is worth more than a verdict, so here it is, derived and then screened.

**The expansion.** Take the curve $t\mapsto Q\exp(t\Omega)$ with $\Omega$ skew, which lies in $O(n)$ and passes through $Q$ at $t=0$ with velocity $Q\Omega$, and set $g(t)=f(Q\exp(t\Omega))$. Writing $Q(t)$ for the curve, $\dot Q=Q(t)\Omega$ and $\ddot Q=Q(t)\Omega^2$, so

$$g''(0)=2\big\langle A,(Q\Omega)^{\circ2}\big\rangle+2\big\langle A\circ Q,\,Q\Omega^2\big\rangle .$$

**The first term, column by column.** With $\omega_k$ the $k$-th column of $\Omega$ one has $(Q\Omega)_{\cdot k}=Q\omega_k$, so with $D_k=\mathop{\mathrm{diag}}(A_{\cdot k})$,

$$\big\langle A,(Q\Omega)^{\circ2}\big\rangle=\sum_k\sum_iA_{ik}(Q\omega_k)_i^2=\sum_k\omega_k^{\mathsf T}\big(Q^{\mathsf T}D_kQ\big)\omega_k .$$

**The second term.** Moving $Q$ across the pairing as in claim 4 gives $\langle A\circ Q,Q\Omega^2\rangle=\langle S,\Omega^2\rangle$ with $S=Q^{\mathsf T}(A\circ Q)$, and skewness gives $\Omega^2=-\Omega\Omega^{\mathsf T}$, so $\langle S,\Omega^2\rangle=-\mathop{\mathrm{tr}}(S^{\mathsf T}\Omega\Omega^{\mathsf T})=-\sum_k\omega_k^{\mathsf T}S\omega_k$. The last step uses $\omega^{\mathsf T}S^{\mathsf T}\omega=\omega^{\mathsf T}S\omega$ for a scalar, so **no symmetry of $S$ is needed** and the identity holds at every $Q$, critical or not.

**The condition.** At every local maximum of $f$ on $O(n)$, for every skew $\Omega$,

$$\boxed{\ \sum_{k=1}^n\omega_k^{\mathsf T}\Big(Q^{\mathsf T}D_kQ-S\Big)\omega_k\ \le\ 0,\qquad D_k=\mathop{\mathrm{diag}}(A_{\cdot k}),\quad S=Q^{\mathsf T}(A\circ Q).\ }$$

Screened against a central second difference of $g$, worst relative error $1.4\cdot10^{-6}$ over 120 draws at $n=3,4,5,6$, asserted.

**Why $S$ appears with a minus sign, and what the shape really is.** $S$ is the Lagrange multiplier. Stationarity of $f-\langle\Lambda,Q^{\mathsf T}Q-I\rangle$ with symmetric $\Lambda$ reads $A\circ Q=Q\Lambda$, that is $\Lambda=Q^{\mathsf T}(A\circ Q)=S$, so **claim 5's condition is exactly "the multiplier is symmetric"**, and the second-order condition is the second variation of $f$ with the multiplier term subtracted, on the tangent space. That is the two-condition shape, and it is the shape of every smooth constrained optimisation.

**The elementary specialisation, which is the useful output.** Take $\Omega=E_{ab}-E_{ba}$. Then $\omega_a=-e_b$, $\omega_b=e_a$ and the rest vanish, and only the diagonal entries of $S$ survive, $S_{aa}=\sum_iA_{ia}Q_{ia}^2$. Substituting and writing $R=Q^{\circ2}$,

$$\tfrac12g''(0)=-\big\langle A_{\cdot a}-A_{\cdot b},\ R_{\cdot a}-R_{\cdot b}\big\rangle ,$$

an identity at every $Q$, screened at $2.7\cdot10^{-15}$ and asserted. So **at every local maximum, and for every pair of columns,**

$$\big\langle A_{\cdot a}-A_{\cdot b},\ R_{\cdot a}-R_{\cdot b}\big\rangle\ \ge\ 0 .$$

Columns $a$ and $b$ of $R$ must be similarly ordered against columns $a$ and $b$ of $A$. This is a pairwise exchange condition, and it needs no criticality hypothesis, because only $\mathop{\mathrm{diag}}S$ entered.

**Verdict on the shape.** The block is **right to flag it as a shape rather than a theorem**, and right that the flag matters. On the correspondence itself:

- **Plausible at the generic level.** Both objects are a multiplier condition plus a non-positive second variation on a tangent space. Every constrained problem has that. Asserting it costs nothing and proves nothing.
- **Not a transport, and the words "with the frame in place of $(\hat U,V)$" are the part that misleads.** The constraint manifold is $O(n)$ here and a sphere in pairs of traceless symmetric matrices there. The multiplier is a symmetric **matrix** $S$ here and a **scalar** $\mu$ there. The objective is quadratic here and cubic-plus-linear there. Most of all, the roles are exchanged: at $\lvert J\rvert=3$ the fields move and the frame is fixed, here the frame moves and the fields are fixed. Neither condition implies the other and there is no map between them on offer.
- **Nothing batch 21 specifically contains transports.** Its content is the cross term $4\beta\mathop{\mathrm{tr}}(XVY)$ as the only second-order lever on non-commutativity, and the specialisation $\mu\ge\alpha\lvert u_{\min}\rvert$. There is no second matrix here to fail to commute with anything, and the analogue of that specialisation is the exchange inequality above, which bounds nothing and instead sorts two columns. The one genuine echo is that both specialisations come out as rearrangement statements.
- **The risk to name.** A shape cited later as a result is [trap 69](../findings/INDEX-traps.md) wearing different clothes. If a later rung cites "the general $\lvert J\rvert$ rung is batch 21 transported" as an input, that citation must be refused until someone writes the map down. The Lean row, "none: a claim about what a computation would resemble, which is not a proposition", is the correct refusal and should be quoted wherever the sentence is.

## Claim 8, CONFIRMED, with the counts replaced by a witness

**What a vacuous version would look like**, which the brief asks for. The theorem is "if the maximum is attained at a zero-diagonal $Q$, then it is also attained at a splitting one". It is vacuous exactly if no admissible $A$, meaning no $A$ of the form $u(\beta\nu^{\circ2})^{\mathsf T}+c\nu^{\mathsf T}$, has its maximum attained on the face. Then the statement would be unrefuted and useless.

**It is not vacuous, and an exact witness beats the counts.** At $n=2$ take $u=(1,0)$, $c=0$, $\nu=(0,1)$, all inside the family and respecting the coupling $a=\beta b^{\circ2}$ between the two column vectors. Then

$$A=\begin{pmatrix}0&\tfrac94\\0&0\end{pmatrix},\qquad f(Q)=\tfrac94Q_{12}^2,$$

whose maximum $\tfrac94$ over $O(2)$ forces $Q_{12}^2=1$, hence $Q_{11}=0$ and, by orthogonality, $Q_{22}=0$. **The maximum is attained on the face and nowhere else.** More generally at $n=2$, writing $t=Q_{11}^2$, one has $f=t(A_{11}+A_{22})+(1-t)(A_{12}+A_{21})$ with $t$ ranging over $[0,1]$, so the maximum sits only on the face exactly when $A_{12}+A_{21}>A_{11}+A_{22}$, an open condition on $(u,c,\nu)$ holding at the witness with a gap of $\tfrac94$. So the hypothesis is met on an **open** subset of the family, not at isolated points. **Avoidance is refuted analytically and the block is entitled to say so, though not for the reason it gives.**

**The mechanism the counts were missing.** By the headline argument the maximum is always attained at a permutation matrix, and a permutation matrix lies on the face exactly when the optimal assignment is a derangement. That is why maximisers land on the face, and how often is a question about how often a rank-two assignment problem is solved by a derangement. This also explains why the counts fall with $n$ without anything being wrong.

**Two cautions about the numerical half as recorded.** The block says "maximisers land on it: $8$ of $12$ at $k=4$, $4$ of $12$ at $k=5$, $1$ of $12$ at $k=6$". Those are an optimiser's outputs, and an output is a local maximum until globality is checked. My own screen found local maxima of $f$ strictly below the assignment optimum, so the distinction is real rather than formal. **The counts are evidence about a search unless the block checked each output against the assignment optimum, which is one line.** The witness above does not depend on any of that.

**The theorem is true, and true unconditionally.** Since the maximum is attained at a permutation matrix and every permutation matrix splits, the conclusion holds whether or not the hypothesis does. So `face_hands_down`'s named `sorry` is dischargeable in principle, the mathematical content being Birkhoff plus the observation that a linear functional and its convex hull share a maximum. Mathlib carries the Birkhoff theorem in [Mathlib/Analysis/Convex/Birkhoff.lean](../lean/.lake/packages/mathlib/Mathlib/Analysis/Convex/Birkhoff.lean), as `doublyStochastic_eq_convexHull_permMatrix` at line 166, with `extremePoints_doublyStochastic` at line 179 supplying the vertex step directly, and this repository already cites the first of the two in [L227Alignment.lean](../lean/HamiltonsCubic/Results/L227Alignment.lean). So the formalisation is a real option rather than a hope. What it would still need is the containment $X_n\subseteq B_n$ and the orthostochasticity of permutation matrices, both one line, and the fact that a linear functional shares its maximum with the convex hull.

**One correction to the Lean table.** Row 8 says that maximisers landing on the face "is numerical and is not a proposition". It **is** a proposition, of the form "there exists an admissible $A$ whose maximum over $X_n$ is attained only at zero-diagonal points", and the witness above proves an instance of it by hand at $n=2$. Whether it is worth typing is a separate question, and the answer is probably no, but the reason given is wrong.

**Whether the hand-down is the right thing for R28 to need.** It was the right weakening to make, and the block's instinct that avoidance is strictly stronger than the route needs is correct. It is now superseded: the route does not need the conditional form either, because the unconditional statement is available. **The remaining question for R28 is not whether the maximum splits, but whether a split into $I_a\oplus I_{n-a}$ at a permutation is the previous rung of its induction or a degenerate one that hands down nothing.** That is a question about R28's induction rather than about this block, and the parent should put it on the ledger.

## The screen

An independent implementation, written for this review, not imported from the block. Every control is an assertion rather than a printed expectation, so a broken measurement ends the run. Seven checks, 7.5 seconds total, all passing.

| control | what it asserts | result |
|---|---|---|
| C1 | the frame expression equals $\langle R,A\rangle$, at $n=3,4,5,6$ | $1.4\cdot10^{-14}$ |
| C2 | $\mathop{\mathrm{rank}}A\le2$ on every draw | pass |
| C3 | the gradient identity, for **every** $W$ and not only skew, against a central difference | $4.4\cdot10^{-9}$ |
| C4 | $\langle S,\Omega\rangle=0$ for all skew $\Omega$ iff $S$ is symmetric, over 200 random $S$ | pass |
| C5 | the second-variation formula against a central second difference | $1.4\cdot10^{-6}$ |
| C6 | the exchange specialisation, as an identity at non-critical $Q$ | $2.7\cdot10^{-15}$ |
| C7 | no start over $O(n)$ beats the assignment optimum, $n=3,4,5$ | gaps $\le5.3\cdot10^{-15}$ |

C7 is the one that matters and it is a control rather than evidence: the headline is a theorem, and the screen exists to catch a misreading of the given. It did not. At $n=3$ and $n=4$ the optimal assignment was a derangement and the best value found over the group matched it to $3\cdot10^{-16}$ and $3\cdot10^{-15}$.

## What the parent should take

1. **The maximum is attained at a permutation matrix, so R28's rung hands down unconditionally.** This subsumes claims 6, 7 and 8 and makes the face analysis unnecessary rather than wrong. It holds only if $P$ genuinely ranges over all of $O(n)$ at fixed $u$, $c$ and $\nu$, which is the block's own reading of the given and should be confirmed against R28.
2. **The derivation, claims 1 to 5, is correct and I re-derived rather than checked it.** The Lean rows for 4 and 5 are honestly scoped.
3. **The word "face" is wrong for $n\ge3$** and the repair is what exposes point 1.
4. **Claim 7 is a shape and must never be cited as a result.** The correspondence is generic, the roles of frame and fields are exchanged between the two settings, and none of batch 21's specific content transports.
5. **The second-order condition is derived above**, together with a pairwise exchange inequality that holds at every local maximum with no criticality hypothesis.
6. **Replace the 13 counts with the $n=2$ witness**, which refutes avoidance on an open set and does not depend on an optimiser being global.
