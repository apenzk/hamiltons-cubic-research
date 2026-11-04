# Review r978: does R28's rung hand down exactly on the commuting stratum?

Reviewer **r978**, Gate 2, working from [BRIEF_R28_commuting.md](BRIEF_R28_commuting.md) alone. Log: [agent_logs/r978-commuting.log](../agent_logs/r978-commuting.log).

## Verdicts

| # | claim | kind | verdict |
|---|---|---|---|
| 1 | The value is $\langle R,A_1\rangle+\langle S,A_2\rangle$, linear in the coupled pair jointly | mathematics | **CONFIRMED**, with both cost matrices rank one, and with the warning that linearity on the product is not convexity on the feasible set |
| 2 | Signed permutations are the ONLY orthogonal matrices whose entrywise square is a permutation matrix | mathematics | **CONFIRMED**, one line, and the orthogonality hypothesis is never used |
| 3 | $R$ and $S$ can be simultaneously permutation matrices only when $G$ is a signed permutation | mathematics | **CONFIRMED**, unconditional, and it is in fact an iff |
| 4 | $G$ is a signed permutation iff $\hat U$ and $C$ share an eigenframe, iff $[\hat U,C]=0$ | mathematics | **REFUTED** as an unconditional iff, **CONFIRMED** when both spectra are simple |
| 5 | The maximum is attained at a splitting frame exactly when $[\hat U,C]=0$ | mathematics | forward **CONFIRMED**, converse **CONFIRMED under $\nu$ pairwise distinct and REFUTED without it**, and the screen is superseded by a proof |
| 6 | Hence once $[\hat U,C]=0$ the rung needs only Birkhoff, with no face, tangency or second-order input | a reduction | **PLAUSIBLE**, with two quiet assumptions named: an every-maximiser gap that still needs a face, and a transfer of the target from the outer problem to the slice |
| 7 | Hence R28 owes nothing separate at general $\lvert J\rvert$, and work on the coupled hull is misdirected | about a route | first half **CONFIRMED**, second half **REFUTED** |

## The single identity the whole round turns on

Write the frame dependence with no orthostochastic language at all. With $P=(p_1,\dots,p_k)\in O(k)$, $D_1=\beta\mathop{\mathrm{diag}}(\nu^{\circ2})$ and $D_2=\mathop{\mathrm{diag}}(\nu)$,

$$f(P)\;=\;\sum_k\big(\beta\nu_k^2\,p_k^{\mathsf T}\hat Up_k+\nu_k\,p_k^{\mathsf T}Cp_k\big)\;=\;\mathop{\mathrm{tr}}\!\big(D_1P^{\mathsf T}\hat UP\big)+\mathop{\mathrm{tr}}\!\big(D_2P^{\mathsf T}CP\big).$$

Along $P(t)=Pe^{t\Omega}$ with $\Omega$ antisymmetric, $P(t)^{\mathsf T}AP(t)=e^{-t\Omega}(P^{\mathsf T}AP)e^{t\Omega}$, so $\tfrac{d}{dt}\big|_0\mathop{\mathrm{tr}}(DP^{\mathsf T}AP)=\mathop{\mathrm{tr}}(D[B,\Omega])=\mathop{\mathrm{tr}}([D,B]\Omega)$ with $B=P^{\mathsf T}AP$. Hence with $B_1=P^{\mathsf T}\hat UP$ and $B_2=P^{\mathsf T}CP$,

$$df(P)[\Omega]=\mathop{\mathrm{tr}}\big(([D_1,B_1]+[D_2,B_2])\,\Omega\big),$$

and $[D,B]_{ab}=(d_a-d_b)B_{ab}$ is antisymmetric whenever $D$ is diagonal and $B$ symmetric, so $P$ is a critical point of $f$ on $O(k)$ if and only if

$$(\star)\qquad \big(\nu_a-\nu_b\big)\Big[\beta\big(\nu_a+\nu_b\big)\big(P^{\mathsf T}\hat UP\big)_{ab}+\big(P^{\mathsf T}CP\big)_{ab}\Big]=0\quad\text{for all }a\neq b.$$

**$(\star)$ is the whole first-order theory of the rung, and it does more than the block's screen does.** It is derived in three lines, it holds at every $\lvert J\rvert$, and it uses neither the orthostochastic image, nor Birkhoff, nor a convex hull. Everything below about claim 5 is a corollary of it.

## Claim 1: CONFIRMED

With $\hat U=E\mathop{\mathrm{diag}}(\lambda)E^{\mathsf T}$, $C=F\mathop{\mathrm{diag}}(\mu)F^{\mathsf T}$, $R=(E^{\mathsf T}P)^{\circ2}$ and $S=(F^{\mathsf T}P)^{\circ2}$, expanding $p_k^{\mathsf T}\hat Up_k=\sum_i\lambda_iR_{ik}$ and $p_k^{\mathsf T}Cp_k=\sum_j\mu_jS_{jk}$ gives $f=\langle R,A_1\rangle+\langle S,A_2\rangle$ with

$$A_1=\beta\,\lambda\,(\nu^{\circ2})^{\mathsf T},\qquad A_2=\mu\,\nu^{\mathsf T}.$$

Two things worth adding to the block, because the block states the form without stating either.

- **Both cost matrices are rank one**, outer products of a spectrum with a power of $\nu$. A linear functional with a rank-one cost on the Birkhoff polytope is the rearrangement inequality, so the single-matrix maximisation is solved by sorting rather than merely by Birkhoff.
- **Joint linearity on $B_k\times B_k$ is not the property the rung needs.** The feasible set is the coupled image $\{((E^{\mathsf T}P)^{\circ2},(F^{\mathsf T}P)^{\circ2}):P\in O(k)\}$, and its convex hull is a proper subset of $B_k\times B_k$ in general, so maximising over the hull of the image does not put you at a pair of permutation matrices. The given Birkhoff input is a statement about one factor and does not lift to the product. This is exactly the difficulty R28 names, and the block's claim 6 is entitled to skip it only because the commuting hypothesis makes the two factors the same matrix.

## Claim 2: CONFIRMED, one line, and the hypothesis is too strong

If $Q^{\circ2}=\Pi$ is a permutation matrix, then every entry of $Q^{\circ2}$ is $0$ or $1$, so $Q_{ij}^2\in\{0,1\}$, so $Q_{ij}=0$ off the support of $\Pi$ and $Q_{ij}=\pm1$ on it. That is a signed permutation matrix. The converse is immediate.

**Orthogonality is never used.** The correct lemma is about an arbitrary real matrix, and the doubly-stochastic route (rows of $Q$ are unit vectors, so $Q^{\circ2}$ is doubly stochastic, so a $0/1$ pattern forces $\pm1$) is a detour. So the statement is true as written, and the block's phrasing "the only orthogonal matrices" understates it.

**It is one line, and it is typeable, so I confirm the obligation the brief flags.** The right form for the base layer drops the orthogonality hypothesis: for `Q : Matrix (Fin n) (Fin n) ℝ` and a permutation matrix `Π`, `(∀ i j, Q i j ^ 2 = Π i j) → ∀ i j, Q i j = 0 ∨ Q i j = 1 ∨ Q i j = -1`, together with the support statement. The proof is `sq_eq_zero_iff` and `sq_eq_one_iff_of_ne_neg_one` style case analysis on `Π i j ∈ {0,1}`, entrywise, with no matrix theory at all.

## Claim 3: CONFIRMED, unconditional, and stronger than stated

$E^{\mathsf T}P$ and $F^{\mathsf T}P$ are orthogonal. If $R$ and $S$ are both permutation matrices then claim 2 makes both $E^{\mathsf T}P$ and $F^{\mathsf T}P$ signed permutations, and

$$G=E^{\mathsf T}F=(E^{\mathsf T}P)(F^{\mathsf T}P)^{\mathsf T}$$

is a product of two signed permutations, hence a signed permutation. **The brief's worry, that $P$ might make each factor a vertex "through different mechanisms", cannot arise**: claim 2 has no slack, so vertex-ness of a factor pins that factor exactly, and the two pinnings compose.

The converse also holds and the block does not claim it. If $G$ is a signed permutation, take $P=E$: then $R=I$ and $S=(G^{\mathsf T})^{\circ2}$ is a permutation matrix. So simultaneity is achievable exactly on the signed-permutation locus, and claim 3 is an iff.

## Claim 4: REFUTED as an unconditional iff, CONFIRMED under simple spectra

- **Forward, unconditional.** If $G$ is a signed permutation then $F=EG$, so $C=E\big(G\mathop{\mathrm{diag}}(\mu)G^{\mathsf T}\big)E^{\mathsf T}$ and $G\mathop{\mathrm{diag}}(\mu)G^{\mathsf T}$ is diagonal, the signs squaring away. Both operators are then diagonal in $E$, so $[\hat U,C]=0$. This is the direction the brief calls a one-line [Matrix.commute](../lean/HamiltonsCubic/Results/I106bFace.lean) obligation, and it is.
- **Reverse, false as stated.** $G=E^{\mathsf T}F$ is not a function of the pair $(\hat U,C)$, it is a function of a *choice* of eigenframes, and the choice is free exactly on the degenerate strata. Take $\hat U=I$ and $C$ any non-scalar symmetric matrix. Then $[\hat U,C]=0$, every orthogonal $E$ is an eigenframe of $\hat U$, $F$ is fixed by $C$, and $G=E^{\mathsf T}F$ ranges over all of $O(k)$. A generic choice is not a signed permutation. The same failure occurs whenever either spectrum has a repeated eigenvalue.
- **Correct statement.** $[\hat U,C]=0$ if and only if $E$ and $F$ **can be chosen** with $G$ a signed permutation, indeed with $G=I$ after matching the orderings. The unconditional iff holds only when both spectra are simple, and then $G$ is determined up to column signs and the permutation matching the two orderings.
- **Why it matters here rather than being pedantry.** The block routes its entire equivalence through $G$, so it is reasoning with a choice-dependent object while asserting a choice-free conclusion. The fix costs nothing, quantify existentially over eigenframes, but the block should carry it, because the second failure below is a real degeneracy failure and not a bookkeeping one.
- The second half of the chain, "share an eigenframe iff $[\hat U,C]=0$", is correct unconditionally for symmetric operators, since "share an eigenframe" is already existential.

## Claim 5: the screen is superseded by a theorem, and the "exactly when" is false without a hypothesis the block does not state

Throughout, **splitting frame** means $R=(E^{\mathsf T}P)^{\circ2}$ is a permutation matrix, equivalently the off-diagonal part of $P^{\mathsf T}\hat UP$ vanishes. The alternative reading is discussed at the end.

### Forward, $[\hat U,C]=0$ implies a splitting maximiser: a theorem

Choose a common eigenframe $E$. Then $F=E$ up to a signed permutation, so $S=R$ and

$$f=\langle R,A_1+A_2\rangle,\qquad A_1+A_2=\beta\lambda(\nu^{\circ2})^{\mathsf T}+\mu\nu^{\mathsf T},$$

a linear functional on a **single** orthostochastic matrix. The given Birkhoff input then puts the maximum at a permutation matrix, attained at $P=E\Pi$, which splits. Screened at $k=3,4$: the supremum over $O(k)$ from 300 retraction restarts agrees with the best of the $k!$ permutation values to $10^{-6}$, asserted rather than printed.

### Converse under $\nu$ pairwise distinct: also a theorem, and much stronger than four data points

Let $P$ be a splitting frame, so $(P^{\mathsf T}\hat UP)_{ab}=0$ for $a\neq b$. Then $(\star)$ collapses to $(\nu_a-\nu_b)(P^{\mathsf T}CP)_{ab}=0$, so with $\nu$ pairwise distinct $P^{\mathsf T}CP$ is diagonal as well. A single frame diagonalises both operators, so $[\hat U,C]=0$. A maximiser is in particular critical, so **the maximum being attained at a splitting frame forces $[\hat U,C]=0$**.

Three things this buys over the block's screen.

- It proves more than the block claims: a splitting frame that is merely **stationary** already forces commuting, so the hypothesis "is a maximum" is not needed.
- It explains the block's own data rather than resting on it. With $[\hat U,C]\neq0$ and $\nu$ distinct, no splitting frame is even stationary, so it is beaten by an arbitrarily small rotation, and the beating direction is explicit: $\Omega$ supported on any pair $(a,b)$ where $(\star)$ fails. Screened at $k=3$ with $\nu=(2,1.3,0.4)$ and a non-commuting pair, the best of the six splitting frames is $21.83$ and is beaten by $21.9275$, the maximiser carrying off-diagonal $\lVert P^{\mathsf T}\hat UP\rVert_{\text{off}}=0.2926$.
- It is $\lvert J\rvert$-free and $k$-free, so it does not need transporting.

### Converse without that hypothesis: REFUTED

$(\star)$ imposes nothing on $(P^{\mathsf T}CP)_{ab}$ when $\nu_a=\nu_b$, and the gap is real, not a technicality. Take $k=3$, $\beta=1$, $\nu=(2,1,1)$,

$$\hat U=\mathop{\mathrm{diag}}(5,1,0),\qquad C=\begin{pmatrix}0&0&0\\0&0.2&0.5\\0&0.5&-0.3\end{pmatrix},\qquad \lVert[\hat U,C]\rVert_F=0.7071\neq0.$$

With $\nu_2=\nu_3=\nu$ the $k=2,3$ terms see only the projector $I-p_1p_1^{\mathsf T}$, so

$$f(P)=\beta\nu^2\mathop{\mathrm{tr}}\hat U+\nu\mathop{\mathrm{tr}}C+\beta(\nu_1^2-\nu^2)\,p_1^{\mathsf T}\hat Up_1+(\nu_1-\nu)\,p_1^{\mathsf T}Cp_1,$$

a function of the single unit vector $p_1$. The maximiser is the top eigenvector of $M=\beta(\nu_1^2-\nu^2)\hat U+(\nu_1-\nu)C=3\hat U+C$, whose $(1,1)$ entry is $15$ while the top eigenvalue of its lower block is about $3.28$, so the top eigenvector is exactly $e_1$. Hence $P=I$ is a global maximiser, $R=I$ is a permutation matrix, the frame splits, and $[\hat U,C]\neq0$. Screened: the collapse identity was asserted against $f$ at 200 random frames, the top eigenvector was asserted to be $e_1$, and 400 restarts of a retraction-based maximisation never beat $f(I)$.

**So claim 5 should read: with $\nu_1,\dots,\nu_k$ pairwise distinct, the maximum is attained at a splitting frame exactly when $[\hat U,C]=0$.** The failure locus is precisely the $\nu$-degeneracy stratum, on which the value sees only the flag of $\nu$-level sets rather than the full frame. Whether the $\lvert J\rvert=3$ node's $\nu$ can have repeats is data I do not have from the brief, and that is the question the block has to answer before the "exactly when" can be recorded.

### The other reading of "splitting"

If "splitting frame" is instead read as the **pair** $(R,S)$ being vertex, then claim 3 makes the converse unconditional, but the claim is then a restatement of claim 3 with the word "maximum" added for decoration, carrying no information about maximisation. The block advertises maximisation content, so the first reading is the one that has to hold, and under it the $\nu$ hypothesis is required.

## Claim 6: PLAUSIBLE, non-vacuous, non-discharging, with two quiet assumptions

**What is right, and it is the block's real contribution.** On $[\hat U,C]=0$ the coupling genuinely dissolves rather than being bounded away. $S$ and $R$ become the same matrix, the cost matrices add, and what is left is a linear functional on one orthostochastic matrix. No coupled hull, no tangency, no second variation. I confirm that this is exactly the object the layer already carries: the `value` in [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) is `⟪R, A⟫` with `A i k = β νₖ² uᵢ + νₖ cᵢ`, and that single index `i` carrying both $u$ and $c$ **is** the shared-eigenframe hypothesis, written into the type. The single-matrix layer was therefore only ever valid on the commuting stratum, which is a point in the block's favour and one it does not make.

**Quiet assumption 1, an every-maximiser gap that still needs a face.** Birkhoff delivers "some maximiser is a permutation matrix". The node's target as quoted is about **every** global maximum. If $A_1+A_2$ ties across a face of $B_k$, non-vertex maximisers exist, and the orthostochastic points of that face need not split. Concluding "every maximiser splits" therefore still needs a face argument on the tied face, which is the very work claim 7 calls misdirected. Two mitigations and one aggravation: $A_1+A_2$ has rank at most $2$, so ties are non-generic, but the node's data is not free to be perturbed, and the tie locus is not disjoint from the trouble already found, since the repeated-$\nu$ counterexample above is exactly a tie, $A_1$ and $A_2$ having equal columns $2$ and $3$.

**Quiet assumption 2, the transfer.** The node's target is "$[\hat U,C]=0$ at every global maximum" of the outer problem. The rung's collapse consumes $[\hat U,C]=0$ as a hypothesis on the inner frame slice at a fixed $J$. The reduction is entitled to that only if the $\hat U$ and $C$ entering the frame expression on $\mathcal S_J$ are the operators the node's statement quantifies over, and only if the target is available at the maxima of the restricted problem and not merely at global maxima of the whole. If it is proved only for global maxima, the rung gets nothing on non-maximal strata, so the R28 clause "its boundary is the split locus, the previous rung" is not discharged by it. The block should say which.

**Vacuity check, as the brief asks.** The claim would be empty if $[\hat U,C]=0$ were already known on the relevant stratum. It is not: the brief's own quotation calls it "the statement to aim at". So the reduction is **non-vacuous and also non-discharging**. It trades one open obligation for another open obligation, and its entire value is that the second is already on the programme's critical path while the first was not. That is a genuine gain in bookkeeping and a zero gain in mathematics, which is what the block's own third paragraph says, so the block is honest about its own weight.

## Claim 7: first half CONFIRMED, second half REFUTED

- **"R28 owes nothing separate at general $\lvert J\rvert$" stands, conditionally on claim 6.** The collapse argument is $\lvert J\rvert$-free: it uses only that $f$ is a linear functional of one orthostochastic matrix of size $k=\lvert J\rvert$, plus the given Birkhoff input at every $k$. Nothing is transported and nothing is size-specific.
- **"Work on the coupled hull is misdirected" does not follow.** It would follow only if the commuting stratum were the whole problem. It is not. The node's difficulty lives on the complement, where $[\hat U,C]\neq0$, and proving the target means ruling that complement out. An object that handles non-commuting frames is therefore still needed, and the coupled image is one candidate for it. The block has shown that the hull is not needed to **finish** the rung, and has concluded that it is not needed to **attack** the node. Those are different statements.
- **Sharper route advice than either.** $(\star)$ is a better handle on the complement than the hull is. It says that at any critical $P$ the off-diagonal parts of $P^{\mathsf T}\hat UP$ and $P^{\mathsf T}CP$ are proportional entry by entry with the explicit factor $-\beta(\nu_a+\nu_b)$, on every pair with $\nu_a\neq\nu_b$. That is a hard constraint on non-commuting critical points, stated in the operators themselves, with no convexity input and no frame decomposition. Ruling out the complement then becomes a second-order question on the solution set of $(\star)$.
- **Note the tension this exposes in claim 6's slogan.** "No second-order condition is needed" is true on the commuting stratum and is precisely false off it, and off it is where the node's target has to be proved. So the block's own conclusion argues for moving effort from the coupled hull to the second variation of $f$ at solutions of $(\star)$, not for moving effort away from the complement.

## Obligations this review creates

| statement | status |
|---|---|
| Claim 2, in the hypothesis-free form, any real matrix whose entrywise square is a permutation matrix is a signed permutation matrix | typeable in the base layer, one line, **confirmed, so it is now owed** |
| Claim 3, as a corollary of claim 2 once the two factors are named | typeable, a few lines |
| Claim 4 forward, a shared eigenframe gives $[\hat U,C]=0$ | typeable, one line, as the brief says |
| Claim 4 reverse | should be **restated existentially over eigenframes** before anything is typed, since as written it is false |
| $(\star)$, the first-order condition on $O(k)$ | not typeable in the base layer, which carries no derivative and no $O(k)$ |
| Claim 5, with the $\nu$ pairwise distinct hypothesis added | the hypothesis has to be checked against the $\lvert J\rvert=3$ node's data before the claim is recorded |

## Screen

One screen, eleven seconds, at $k=3,4,5$, every control an assertion. Controls: the first-order formula $df=\mathop{\mathrm{tr}}(([D_1,B_1]+[D_2,B_2])\Omega)$ against a central difference, the antisymmetry of that matrix, the reduction of $(\star)$ to $[\mathop{\mathrm{diag}}(\nu),P^{\mathsf T}CP]$ at an $\hat U$-eigenframe, and the equivalence of its vanishing with $[\hat U,C]=0$ at distinct $\nu$. The screen supports the three positive statements above that were proved by hand and supplies the maximiser values quoted for the two explicit $k=3$ instances. No positive claim here rests on it.
