# REVIEW r977, Gate 2 on I106b's face, its first-order condition, and what R28 needs

Reviewer **r977**, working from [BRIEF_I106b_face.md](BRIEF_I106b_face.md) and the mathematics alone. The working note was not read and the block's script was not imported. Log: [agent_logs/r977-face.log](../agent_logs/r977-face.log). Screens: an independent implementation in the scratchpad, every expectation an assert, reported as screens and never as evidence for a positive claim.

## Verdicts

| # | claim | kind | verdict |
|---|---|---|---|
| 1 | the value is $\langle R,A\rangle$ with $A_{ik}=\beta\nu_k^2u_i+\nu_kc_i$ | mathematics | **CONFIRMED** |
| 2 | $A$ has rank at most $2$ | mathematics | **CONFIRMED**, with the equality case named |
| 3 | maximising over the image is maximising $f$ over the group | mathematics | **CONFIRMED**, and the argmax correspondence is exact in both directions |
| 4 | $\mathrm df_Q[Q\Omega]=2\langle Q^{\mathsf T}(A\circ Q),\Omega\rangle$ | mathematics | **CONFIRMED**, re-derived |
| 5 | criticality is exactly symmetry of $Q^{\mathsf T}(A\circ Q)$ | mathematics | **CONFIRMED**, it is an equivalence and not one-way |
| 6 | $\{\mathop{\mathrm{tr}}=0\}$ is a face relative to the affine hull | mathematics | **PLAUSIBLE**, the word "face" is used of a nonconvex set and needs a repair that is available |
| 7 | the second-order condition is batch 21 transported | a shape | **PLAUSIBLE but empty as stated**, and the condition itself is derived below |
| 8 | avoidance is false, so the hand-down statement is what R28 needs | mixed | **REFUTED as reasoning**, the conclusion being true unconditionally and for a reason the block does not give |

## The finding that governs everything else: the maximum is an assignment problem

**The convex hull of the orthostochastic set is the whole Birkhoff polytope, so the maximum of $\langle R,A\rangle$ over $X_k$ is attained at a permutation matrix.** Three lines.

1. $X_k\subseteq B_k$, because the rows and columns of $Q\in O(k)$ are unit vectors, so $Q^{\circ2}$ has nonnegative entries with all row and column sums $1$.
2. Every permutation matrix lies in $X_k$, being $\varphi_r$ of itself, so $\mathop{\mathrm{conv}}(X_k)\supseteq\mathop{\mathrm{conv}}\{\text{permutations}\}=B_k$ by Birkhoff and von Neumann. With 1, $\mathop{\mathrm{conv}}(X_k)=B_k$.
3. A linear functional attains the same maximum on a set and on its convex hull, and on the polytope $B_k$ it attains it at a vertex. Hence $\max_{R\in X_k}\langle R,A\rangle=\max_{\sigma}\sum_k A_{\sigma(k)k}$, a linear assignment problem, attained **inside $X_k$** at the optimal permutation matrix.

Four consequences, in descending order of how much they cost the block.

- **R28's remaining obligation is discharged outright, not conditionally.** A permutation matrix splits in the source's two-sided sense: take the row set $\{\sigma(0)\}$ and the column set $\{0\}$, which is nonempty and proper for $k\ge2$ and satisfies both vanishing conditions. So *the maximum over the image is always attained at a splitting point*, with no hypothesis about the face at all.
- **The face is not load-bearing.** The block's own theorem is the correct thing to want, and it is true, but the route to it runs through Birkhoff rather than through any property of $\{\mathop{\mathrm{tr}}=0\}$. Claim 6 becomes a true remark rather than a step.
- **"The image never has to be parametrised" is right for a stronger reason than the block gives.** Neither the image nor the group has to be searched: the optimal frame is computed by the Hungarian algorithm in $O(k^3)$, exactly, for every $k$ at once.
- **The optimal frame is a signed permutation of the field frame.** That is a statement about R28 worth more than the face: the extremal frame is the aligned one, up to a relabelling that the assignment names.

*What this rests on*: R28's objective being exactly the given expression, with $\nu$ fixed and $P$ ranging over all of $O(k)$. If the frame is constrained further, or if the pairing of $\nu_k$ to $p_k$ is itself part of the optimisation, the reduction changes. It is taken verbatim from the brief. The argument is indifferent to maximising or minimising, since a linear functional attains both extremes of $B_k$ at vertices.

**Screen, not evidence.** A conditional-gradient ascent on $O(k)$ from 12 random starts, over 12 instances at $k\in\{4,5,6\}$, never beat the assignment value, with the inequality asserted at $10^{-8}$ and the assignment value asserted to equal $f$ at its permutation matrix. The best ascent matched the assignment value to machine precision in every instance.

## Claim 1, CONFIRMED

$p_k^{\mathsf T}\hat Up_k=\sum_iu_i(p_k)_i^2=(R^{\mathsf T}u)_k$ with $R=P^{\circ2}$, and likewise for $C$. So the value is $\sum_k\big(\beta\nu_k^2(R^{\mathsf T}u)_k+\nu_k(R^{\mathsf T}c)_k\big)=\sum_{i,k}R_{ik}\big(\beta\nu_k^2u_i+\nu_kc_i\big)=\langle R,A\rangle$. The index convention is the one the Lean file uses, $i$ the field-frame index and $k$ the frame index, and `value A R = (Aᵀ * R).trace` is the Frobenius pairing $\sum_{i,k}A_{ik}R_{ik}$. Correct.

**Vacuity.** The claim would be empty if $\langle R,A\rangle$ were constant on $B_k$, which happens exactly when $A_{ik}=a_i+b_k$. Two degenerate cases sit inside R28's own family and should be excluded by hypothesis wherever the item is cited: **if $\nu$ is constant the value is frame-independent** (then $A_{ik}$ depends on $i$ alone), and **if $u$ and $c$ are both constant vectors the value is frame-independent** (then $A_{ik}$ depends on $k$ alone). Conversely, when $\beta\nu^{\circ2}$, $\nu$ and $\mathbf 1$ are independent, frame dependence forces $u$ or $c$ to be nonconstant. So the item needs $V$ to carry at least two distinct eigenvalues, and that hypothesis is nowhere stated in the block.

## Claim 2, CONFIRMED, with the equality case

$A=u(\beta\nu^{\circ2})^{\mathsf T}+c\nu^{\mathsf T}$ is a sum of two outer products, so $\mathop{\mathrm{rank}}A\le2$. Equality holds exactly when $u,c$ are independent **and** $\beta\nu^{\circ2},\nu$ are independent, and the second fails exactly when every $\nu_k$ lies in $\{0,\lambda\}$ for one $\lambda$.

**What breaks if the screens were run at generic $A$.** The rank matters in two places. The assignment optimum of a rank-$2$ $A$ of this shape is a rearrangement-type optimum and its statistics are not those of a generic cost matrix, so a face-landing frequency measured at generic $A$ answers a different question. In my own screen, the optimal $\sigma$ was a derangement in 5, 2 and 4 of 12 instances at $k=4,5,6$ drawn from R28's own two-outer-product family. A number drawn from a different ensemble would not be comparable, and the block's counts carry no statement about which ensemble produced them.

## Claim 3, CONFIRMED, and the quantifier is safe

The value-level equality is immediate from $\varphi_r(O(k))=X_k$. The stronger statement the block actually uses is also true: since $f=\langle A,\cdot\rangle\circ\varphi_r$ with $\varphi_r$ onto $X_k$,
$$\mathop{\mathrm{argmax}}_{O(k)}f=\varphi_r^{-1}\Big(\mathop{\mathrm{argmax}}_{X_k}\langle\cdot,A\rangle\Big),$$
so a maximiser of one gives a maximiser of the other in both directions, and every preimage of a maximiser is a maximiser. Fibres cause no trouble for this.

**Where the fibres do cause trouble, and it is worth saying.** $\varphi_r^{-1}(R)=\{Q'\in O(k):\lvert Q'\rvert=\lvert Q\rvert\ \text{entrywise}\}$, which is generally strictly larger than the sign orbit $\{D_1QD_2\}$ (at $k=4$ the Hadamard point admits permuted sign patterns that are not sign flips of one another). More to the point, $\varphi_r$ fails to be a submersion exactly where an entry of $Q$ vanishes, which is where the face lives, so **a critical point of $f$ on $O(k)$ does not translate into a tangency statement about $X_k$**. That is the same obstruction the singular-locus route met, and the block should not be read as having restored the transfer.

## Claim 4, CONFIRMED, re-derived rather than checked

$f(Q)=\sum_{i,k}A_{ik}Q_{ik}^2$, so for any matrix direction $Z$, $\mathrm df_Q[Z]=2\sum_{i,k}A_{ik}Q_{ik}Z_{ik}=2\langle A\circ Q,Z\rangle$. Both steps the brief asks about:

- $\langle A,Q\circ Z\rangle=\sum_{i,k}A_{ik}Q_{ik}Z_{ik}=\langle A\circ Q,Z\rangle$, because the Hadamard product is entrywise and the pairing is a sum over entries. The Hadamard factor moves across the Frobenius pairing freely, and this needs nothing about $Q$.
- $\langle M,Q\Omega\rangle=\mathop{\mathrm{tr}}(M^{\mathsf T}Q\Omega)=\langle Q^{\mathsf T}M,\Omega\rangle$, since $\langle Q^{\mathsf T}M,\Omega\rangle=\mathop{\mathrm{tr}}\big((Q^{\mathsf T}M)^{\mathsf T}\Omega\big)=\mathop{\mathrm{tr}}(M^{\mathsf T}Q\Omega)$. This needs nothing about $Q$ either, in particular not orthogonality.

So $\mathrm df_Q[Q\Omega]=2\langle Q^{\mathsf T}(A\circ Q),\Omega\rangle$ as claimed.

**$Q\Omega$ or $\Omega Q$, and whether it matters.** Both sweep the whole tangent space $T_QO(k)$, since $\{Q\Omega:\Omega\ \text{skew}\}=\{\Omega'Q:\Omega'\ \text{skew}\}$ under $\Omega'=Q\Omega Q^{\mathsf T}$. The left-translated form gives $\mathrm df_Q[\Omega Q]=2\langle(A\circ Q)Q^{\mathsf T},\Omega\rangle$ and hence the condition "$(A\circ Q)Q^{\mathsf T}$ symmetric". The two conditions are conjugate, $(A\circ Q)Q^{\mathsf T}=Q\big(Q^{\mathsf T}(A\circ Q)\big)Q^{\mathsf T}$, and conjugation by an orthogonal matrix preserves symmetry, **so the choice does not matter**. The block is entitled to fix one and should say that it has.

**Lean.** `grad_pairing` in [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) states exactly $\langle A,Q\circ(QW)\rangle=\langle Q^{\mathsf T}(A\circ Q),W\rangle$ for every `W`, which is the identity above with the factor $2$ and the skew restriction correctly left outside. The row of the brief's Lean table is accurate.

**Screen.** Central difference along $Q\exp(t\Omega)$ agreed with the formula to $10^{-5}$ relative at $k=4,5,6$, the general-$W$ identity to $10^{-10}$, and the conjugacy of the two gradient forms to $10^{-10}$, all asserted.

## Claim 5, CONFIRMED, and it is genuinely an equivalence

The brief's worry is the right one to raise and it resolves in the strong direction. Under the Frobenius pairing the symmetric and skew subspaces are orthogonal complements, and $\langle S,\Omega\rangle=\langle S_{\mathrm{sym}},\Omega\rangle+\langle S_{\mathrm{skew}},\Omega\rangle=\langle S_{\mathrm{skew}},\Omega\rangle$ for skew $\Omega$. Taking $\Omega=S_{\mathrm{skew}}$ gives $\lVert S_{\mathrm{skew}}\rVert^2=0$, so vanishing against every skew $\Omega$ gives symmetry of $S$ exactly, **not something weaker**. Over the reals there is no characteristic-2 caveat.

Two riders. First, "criticality" means criticality of $f$ **restricted to $O(k)$**, and the restriction is what gives the condition content, since the unconstrained gradient $2A\circ Q$ is generically nonzero at a constrained critical point. Second, the equivalence needs $\{Q\Omega\}$ to exhaust $T_QO(k)$, which it does, so the condition is criticality and not merely criticality along a subfamily.

**Consistency with the finding above.** Every permutation matrix is critical: for $Q$ a signed permutation, $\big(Q^{\mathsf T}(A\circ Q)\big)_{jk}=\sum_iQ_{ij}A_{ik}Q_{ik}$ is supported on $j=k$, so $S$ is diagonal and therefore symmetric. Asserted in the screen at $10^{-12}$.

## Claim 6, PLAUSIBLE, with the word doing unlicensed work

The three facts are correct. $\mathop{\mathrm{tr}}(Q^{\circ2})=\sum_iQ_{ii}^2\ge0$, vanishes exactly when $Q$ has zero diagonal, and is nonconstant on $X_k$ for $k\ge2$ (the identity gives $k$, any derangement gives $0$). The Lean triple `trace_image_eq`, `trace_image_nonneg` and `trace_image_eq_zero_iff` types them correctly and needs no hypothesis, as the brief says.

**The inference is where the block is loose.** "Face" is a notion for convex sets, and $X_k$ is not convex for $k\ge3$, so "a face of $X_k$" is undefined as written. The inference also needs $\mathop{\mathrm{tr}}$ nonconstant on $\mathop{\mathrm{aff}}(X_k)$ rather than on $X_k$, which is a different set. Both repairs are available and the conclusion survives either way.

- $\mathop{\mathrm{aff}}(X_k)=\mathop{\mathrm{aff}}(B_k)$ by the hull computation above, which is the affine space of matrices with all row and column sums $1$, of dimension $(k-1)^2$. $\mathop{\mathrm{tr}}$ is linear, hence affine there, and nonconstant there for $k\ge2$. So the block's own inference goes through once the hull is computed, and **the hull computation is the missing step**.
- The property the induction would want holds directly: if a point of $\{\mathop{\mathrm{tr}}=0\}\cap X_k$ is a convex combination with positive weights of points of $X_k$, then linearity and nonnegativity of $\mathop{\mathrm{tr}}$ force every one of them onto the face. So the set is an exposed, extreme subset even read on the nonconvex $X_k$.
- Cleanest statement: $\{\mathop{\mathrm{tr}}=0\}\cap B_k$ is a genuine face of the Birkhoff polytope, the zero-diagonal face whose vertices are the derangement matrices, and the set under discussion is its intersection with $X_k$.

**Vacuity.** The claim would be empty if the face were empty, which it is at $k=1$. For $k\ge2$ a derangement permutation matrix sits in it, so it is nonempty, and at $k=2$ it is the single point $\bigl(\begin{smallmatrix}0&1\\1&0\end{smallmatrix}\bigr)$. The block should carry $k\ge2$ explicitly.

## Claim 7, the block is right to call it a shape, and here is the condition

**The block is correct to refuse to grade this as a theorem, and I do not grade it as one.** What follows is the derivation the brief asked for, which is worth more than the verdict.

Along the one-parameter subgroup $Q(t)=Q\exp(t\Omega)$, which is a geodesic of $O(k)$ in the bi-invariant metric, write $Q'=Q\Omega$ and $Q''=Q\Omega^2$. From $\tfrac{\mathrm d^2}{\mathrm dt^2}Q_{ik}^2=2(Q'_{ik})^2+2Q_{ik}Q''_{ik}$,
$$\mathop{\mathrm{Hess}}f(\Omega,\Omega)=2\sum_{i,k}A_{ik}\big[(Q\Omega)_{ik}\big]^2+2\big\langle Q^{\mathsf T}(A\circ Q),\Omega^2\big\rangle .$$
With $S=Q^{\mathsf T}(A\circ Q)$ and $\Omega^2=-\Omega^{\mathsf T}\Omega$, the second term is $-2\mathop{\mathrm{tr}}(\Omega S\Omega^{\mathsf T})$, so **the second-order necessary condition at a maximiser is**
$$\boxed{\ \sum_{i,k}A_{ik}\big[(Q\Omega)_{ik}\big]^2\ \le\ \mathop{\mathrm{tr}}\big(\Omega S\Omega^{\mathsf T}\big)\quad\text{for every skew }\Omega,\qquad S=Q^{\mathsf T}(A\circ Q)\ \text{symmetric}. }$$

Two remarks on its shape. The left side is the objective's own quadratic form evaluated at the tangent matrix, and the right side is the multiplier $S$ contracted against the constraint's curvature. That is the Lagrangian shape every constrained problem has, objective Hessian minus multiplier times constraint Hessian, and in particular **the two-condition shape is what maximising any entrywise-quadratic functional on $O(k)$ produces**, whatever the record's $\lvert J\rvert=3$ computation looked like. So the correspondence the block asserts is plausible and, as stated, carries no information: a transport claim earns its keep only by naming which multiplier and which tangent form correspond to which objects at $\lvert J\rvert=3$, and the block names neither. I cannot check the comparison with batch 21 without the note, and I flag that the block is asking a reviewer to take the resemblance on trust.

**The collapse at a permutation, which is the part worth keeping.** At $Q=P_\sigma$ with $Q_{\sigma(j)j}=1$, $S=\mathop{\mathrm{diag}}\big(A_{\sigma(k)k}\big)$ and the Hessian becomes $2\sum_{j,k}\Omega_{jk}^2\big[A_{\sigma(j)k}-A_{\sigma(k)k}\big]$. Pairing $(j,k)$ with $(k,j)$, the second-order condition reads
$$A_{\sigma(j)k}+A_{\sigma(k)j}\ \le\ A_{\sigma(j)j}+A_{\sigma(k)k}\qquad\text{for all }j,k,$$
which is **exactly the no-improving-2-swap test for the assignment problem**. The manifold condition and the combinatorial one are the same inequality, which is independent confirmation of the reduction in the first section, and it also shows what the second-order condition cannot do: 2-swap optimality is necessary and not sufficient for the assignment optimum, so second order alone never certifies the global maximum.

**Screen.** A second central difference agreed with the Hessian formula to $10^{-4}$ relative at $k=4,5,6$, the two writings of the second term agreed to $10^{-9}$, and the 2-swap collapse was asserted at $10^{-9}$ over six random directions per $k$.

## Claim 8, REFUTED as reasoning, with the conclusion true and stronger

Three separate things are bundled here and they part company.

- **The theorem is true, unconditionally.** By the first section the maximum is always attained at a permutation matrix, which splits, so the conclusion holds whether or not the hypothesis does. The conditional form is therefore correct but its hypothesis does no work, and the sentence "the rung does not need the face to be avoided, only that landing on it costs nothing" understates what is available.
- **It is not vacuous, and the block is entitled to say the hypothesis is met.** The hypothesis holds exactly when the optimal assignment is a derangement, which is a condition on $u$, $c$ and $\nu$ that is decidable in $O(k^3)$ and does occur: in my screen it held in 5, 2 and 4 of 12 instances at $k=4,5,6$ drawn from R28's own family. So the theorem has content in the logical sense. It is subsumed rather than empty.
- **The numerical refutation of avoidance does not say what the block reads into it.** "Maximisers land on it, 8 of 12 at $k=4$, 4 of 12 at $k=5$, 1 of 12 at $k=6$" is ambiguous between 12 instances and 12 random starts on one instance, and the two readings are not close. Under the first reading the counts are a statistic about how often the optimal $\sigma$ is a derangement. Under the second they are a statistic about local maxima of a nonconcave ascent, which are not maximisers at all. My screen separates them: the per-instance count of starts landing zero-diagonal was $12/12$ or $0/12$ in eleven of twelve instances, tracking the instance rather than the start, so a count of $8$ within a single instance would be reporting something else again. **The block must say which it measured before the numbers can be cited.** The qualitative conclusion, that the face is met rather than avoided, survives either way and also follows from the derivation without any numerics.

The right statement for R28 to consume is the unconditional one: *the maximum of the frame dependence is attained at a permutation frame, which splits*, obtained from Birkhoff rather than from the face, and computed rather than searched.

## A defect in the Lean statement, at $k=0$

`face_hands_down` as written is **false at $k=0$**. For the empty matrix all three hypotheses hold vacuously (`hzero` quantifies over `Fin 0`, `hQ` holds since both sides are the empty matrix, and `hmax` reduces to $0\le0$), while the conclusion requires `Splits P` with a nonempty `R : Finset (Fin 0)`, which cannot exist. So the named `sorry` sits over a false proposition at that size and can never be discharged as stated, and anything citing it would be unsound. At $k=1$ the statement is fine because the hypotheses are unsatisfiable, `hzero` contradicting `hQ`. **Fix: add `2 ≤ k`.** This is a typing defect rather than a mathematical one, and it is the kind that makes an otherwise provable `sorry` unprovable.

With that fix the open content is smaller than the file suggests: the witness is the optimal permutation matrix, `Splits` holds for it by the row set $\{\sigma(0)\}$ and column set $\{0\}$, and the remaining Lean work is the Birkhoff step, `conv(X_k) = B_k`, rather than anything about the face.

## What I would change in the block

1. **Replace the face argument with the hull argument.** State $\mathop{\mathrm{conv}}(X_k)=B_k$ and conclude that the maximum is attained at a permutation frame. It proves more, in fewer lines, with no numerics.
2. **Carry $k\ge2$**, in the prose, in the face claim, and in `face_hands_down`.
3. **Name the nondegeneracy hypothesis**, that $\nu$ is nonconstant and that $u,c$ are not both constant, without which the value is frame-independent and the item is empty.
4. **Say which quantity the counts 8, 4 and 1 are counting**, and prefer the Hungarian algorithm over random starts for the question they were meant to answer.
5. **Either drop the batch 21 resemblance or make it concrete** by naming the multiplier and the tangent quadratic on both sides, since the two-condition shape alone is common to every problem of this type.
6. **Say "exposed subset" where the set is nonconvex**, or route the face through $B_k$ where the word is licensed.
