# Review r965: the coupling constraint between the two orthostochastic factors (I106a)

Gate 2, cold brief [BRIEF_I106a_coupling.md](BRIEF_I106a_coupling.md). Worked from the definitions and from [I106aOrthostochastic.lean](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean) alone. Log: [agent_logs/r965-coupling.log](../agent_logs/r965-coupling.log).

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $F^{\mathsf T}P=G^{\mathsf T}Q$, so $S=(G^{\mathsf T}Q)^{\circ2}$ | **CONFIRMED**, and $EE^{\mathsf T}=I$ is spent here |
| 2 | the decomposition $S_{ik}=((G^{\circ2})^{\mathsf T}R)_{ik}+2\sum_{j<l}G_{ji}G_{li}T^{(jl)}_k$ | **CONFIRMED** |
| 3 | $(T^{(jl)}_k)^2=R_{jk}R_{lk}$ | **CONFIRMED**, unconditional |
| 4 | $T^{(12)}_kT^{(13)}_kT^{(23)}_k=R_{1k}R_{2k}R_{3k}\ge0$ | **CONFIRMED**, the inequality carrying no information, and the sign corollary the record states elsewhere needing a non-vanishing hypothesis it does not carry |
| 5 | claim 2 uses no orthogonality | **REFUTED as tabulated**, CONFIRMED for `coupling_decomposition` |
| 6 | at $G=I$ the display collapses to $S=R$ | **CONFIRMED**, on the one locus where the term under review is invisible |
| 7 | $S$ is determined by $R$, $G$ and a finite sign choice | **PLAUSIBLE**: true in both readings, and the recorded constraints leave $64$ branches where $4$ are realisable. **One constraint is missing, and is supplied below with a proof of completeness** |
| 8 | the record does not already hold this pair under another name | **CONFIRMED** to the reach of a search |

## The finding that matters: the constraint list is incomplete, and the completion is provable

Claims 3 and 4 are both **per column of $R$**. Nothing in the block ties the three columns to each other, so for a generic $R$ they admit $4^3=64$ sign assignments. Only $4$ of those come from a $Q\in O(3)$. The other $60$ are not harmless: they produce an $S$ that is **not bistochastic**, so they leave the orthostochastic variety that [I106a](../plan.md)'s next step, the Lagrange conditions, is to be posed on.

**Where the spurious branches fail, exactly.** Fix a column $k$ and a parity-admissible sign choice. By the per-column argument below it is realised by a vector $q^{(k)}$ with $(q^{(k)}_j)^2=R_{jk}$, so $S_{ik}=(\sum_jG_{ji}q^{(k)}_j)^2$ is a genuine square. Hence **every one of the $64$ branches keeps $S\ge0$ entrywise**, and $\sum_iS_{ik}=\lvert G^{\mathsf T}q^{(k)}\rvert^2=\lvert q^{(k)}\rvert^2=\sum_jR_{jk}=1$, so **every branch keeps $S$'s column sums**. The same fact reads off the cross term directly: with $M_{i,(jl)}:=2G_{ji}G_{li}$ the linear map carrying the three $T^{(jl)}_k$ into the cross term, $\sum_iM_{i,(jl)}=(G^{\mathsf T}G)_{jl}=0$, so $\mathbf1^{\mathsf T}M=0$ for every orthogonal $G$ and $\mathop{\mathrm{rank}}M\le2$. **Only the row sums can break, and they are what breaks.**

**The missing constraint.** $Q$'s rows are orthonormal as well as its columns, and that says

$$\sum_k T^{(jl)}_k=\sum_k Q_{jk}Q_{lk}=(QQ^{\mathsf T})_{jl}=0\qquad (j<l),$$

three linear equations, one per pair. This is the row counterpart of the column relation `orthostochastic_eq` already turns on, and the block drops it.

**Proposition (r965), and it is a proof rather than a screen.** Let $R$ be $3\times3$ bistochastic. The assignments $T^{(jl)}_k$ satisfying (i) $(T^{(jl)}_k)^2=R_{jk}R_{lk}$, (ii) $T^{(12)}_kT^{(13)}_kT^{(23)}_k=R_{1k}R_{2k}R_{3k}$ and (iii) $\sum_kT^{(jl)}_k=0$ are **exactly** those of the form $T^{(jl)}_k=Q_{jk}Q_{lk}$ for a $Q\in O(3)$ with $Q^{\circ2}=R$.

*Per column.* (i) forces $T^{(jl)}_k=\varepsilon_{jl}\sqrt{R_{jk}R_{lk}}$ for signs $\varepsilon$, and where all three are nonzero (ii) forces $\varepsilon_{12}\varepsilon_{13}\varepsilon_{23}=+1$. Conversely, given such an $\varepsilon$, put $q_1=\sqrt{R_{1k}}$, $q_2=\varepsilon_{12}\sqrt{R_{2k}}$, $q_3=\varepsilon_{13}\sqrt{R_{3k}}$: the first two products are $\varepsilon_{12}$ and $\varepsilon_{13}$ times the radicals by construction, and $q_2q_3=\varepsilon_{12}\varepsilon_{13}\sqrt{R_{2k}R_{3k}}=\varepsilon_{23}\sqrt{R_{2k}R_{3k}}$ by the pinned product. Where some $R_{jk}=0$ the two products through $j$ vanish under (i) alone, (ii) is $0=0$, and $q_j=0$ realises the remaining free sign. So the per-column step holds with no case left over.

*Assembling.* Let $Q'$ carry those columns. Each is unit because $R$'s column sums are $1$, so $\mathop{\mathrm{tr}}(Q'Q'^{\mathsf T})=3$, and (iii) makes $Q'Q'^{\mathsf T}$ diagonal with $(Q'Q'^{\mathsf T})_{jj}=\sum_kR_{jk}=1$ because $R$'s **row** sums are $1$. Hence $Q'Q'^{\mathsf T}=I$, $Q'\in O(3)$, and $Q'^{\circ2}=R$. $\square$

Two hypotheses the block does not state are load-bearing here: $R$ bistochastic in **both** directions, and (iii). Screened for arithmetic before recording, on six generic $R$ ($4$ surviving assignments, set-equal to the $4$ realisable) and on two $R$ with zero entries ($2$ and $2$, likewise equal), against $64$, $4$ and $4$ admitted by (i) and (ii) alone.

**Consequence for the route.** [routes.md](../routes.md)'s R28 row reads the display as making the pair "a $3$-manifold again", so "the tangency exclusion can be posed on it". The pair traced by $P\in O(3)$ is $3$-dimensional whatever the block says, so that count is right. What does **not** follow from the constraints **as recorded** is that they cut out that manifold: they cut out a set with $16$ times as many branches at a generic point, and a Lagrange computation posed against them would range over the larger set. Adding (iii) repairs this, and the proposition above says it repairs it exactly.

## Claim by claim

**1. CONFIRMED, and it is where the orthogonality goes.** $G^{\mathsf T}Q=(E^{\mathsf T}F)^{\mathsf T}(E^{\mathsf T}P)=F^{\mathsf T}(EE^{\mathsf T})P=F^{\mathsf T}P$, using $EE^{\mathsf T}=I$, which for a real square matrix is equivalent to $E^{\mathsf T}E=I$. **$F$ and $P$ contribute nothing to this step.** Hence $S=(F^{\mathsf T}P)^{\circ2}=(G^{\mathsf T}Q)^{\circ2}$. The brief's Lean row is right that nothing in the file states it, and right about why.

**2. CONFIRMED.** $(\sum_jg_jq_j)^2=\sum_jg_j^2q_j^2+2\sum_{j<l}g_jg_lq_jq_l$ with $g_j=G_{ji}$, $q_j=Q_{jk}$. The index convention checks out: $((G^{\circ2})^{\mathsf T}R)_{ik}=\sum_j(G^{\circ2})_{ji}R_{jk}=\sum_jG_{ji}^2Q_{jk}^2$, which is the first sum, and the transpose is needed rather than decorative. `coupling_decomposition` is this statement with the same grouping. Screened at $1.7\cdot10^{-15}$ over $200$ random $(E,F,P)\in O(3)^3$.

**3. CONFIRMED, with no hypothesis at all.** $(Q_{jk}Q_{lk})^2=Q_{jk}^2Q_{lk}^2=R_{jk}R_{lk}$ is an identity in one variable pair, true when either entry vanishes. `coupling_square` is exactly it.

**4. The equality CONFIRMED. The inequality is true and empty. The sign statement the record actually uses is stated without the hypothesis it needs.**

- Equality: $(Q_1Q_2)(Q_1Q_3)(Q_2Q_3)=(Q_1Q_2Q_3)^2=R_{1k}R_{2k}R_{3k}$, which `coupling_parity` types.
- Non-negativity is **not an independent fact and cannot fail**. It is visible on either side without the equality: the right side is a product of three entrywise squares, the left is the single square $(Q_{1k}Q_{2k}Q_{3k})^2$. It follows from $R=Q^{\circ2}$ alone. The brief is right that no declaration asserts it, and it is one `positivity` call from `coupling_parity`'s right-hand side.
- **What the record leans on is the corollary**, written in [I106aOrthostochastic.lean](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean)'s docstring and in [routes.md](../routes.md) as "the three signs' product pinned to $+1$". That corollary is **false as a statement about signs when any $R_{jk}=0$**: two of the three $T$'s then vanish, the third's sign is unconstrained, and the equality degenerates to $0=0$. The correct reading is the one the proposition above uses, that the pinning binds where all three are nonzero and the free sign is realisable where they are not. **The hypothesis is owed wherever the phrase "pinned to $+1$" appears.**

**5. REFUTED as tabulated, CONFIRMED for the Lean statement.** The two must be separated.

- `coupling_decomposition`, six unconstrained reals, needs no orthogonality. True, and its signature shows it.
- Claim 2 **with $S$ as defined**, $S=(F^{\mathsf T}P)^{\circ2}$, needs $EE^{\mathsf T}=I$, spent at claim 1. A screen makes the dependence one-sided and sharp: with $E$ drawn non-orthogonal the residual runs $2.4$ to $108$ over $20$ draws, while with $F$ non-orthogonal or $P$ non-orthogonal it stays at $10^{-15}$. **Only $E$'s orthogonality is load-bearing**, which is what the derivation predicts.
- So the block's "It needs NO orthogonality" is true of the display read as an identity in $(G,Q)$ and false of the chain that reaches $S$ from the objects R28 names. The Lean docstring inherits it, placing "these need no orthogonality" under a paragraph that has already defined $S=(G^{\mathsf T}Q)^{\circ2}$, which is where the orthogonality was spent. **A one-clause repair**: no orthogonality beyond the $EE^{\mathsf T}=I$ that identifies $F^{\mathsf T}P$ with $G^{\mathsf T}Q$.

**6. CONFIRMED, and the ceiling is chosen on the locus where the claim it should test disappears.** At $G=I$ the first term is $\sum_j\delta_{ji}R_{jk}=R_{ik}$, and $G_{ji}G_{li}=0$ for every $j\ne l$, so the cross term is zero entrywise. It also follows from the definitions with no display at all: $E^{\mathsf T}F=I$ with $E$ orthogonal gives $F=E$, so $S=(E^{\mathsf T}P)^{\circ2}=R$.

The criticism is of Gate 1 item (d) rather than of the claim. **The cross term vanishes at $G=I$ for every value of the $T$'s**, so the ceiling tests the first term's index convention and nothing else: not the coefficient $2$, not the pair set $j<l$, not the $T$'s. The same holds at every signed permutation $G$, where $M=0$ as well. A ceiling that exercises the coupling needs a $G$ with $M\ne0$, and $\mathop{\mathrm{rank}}M=2$ at a generic $G$ (screened over $300$ draws) says such $G$ are the rule.

**7. PLAUSIBLE. Two readings, both true, and the second is supported by a constraint list that is missing a third of itself.**

- *Reading A, the sentence as written.* $S$ is a function of $R$, $G$ and finitely many signs. **True**, and close to trivial: claim 2 makes $S_{ik}$ a polynomial in $G$, $R$ and the $T$'s, and claims 3 and 4 make each column's $T$-triple one of at most four. The map is well defined because $S_{ik}=(\sum_jG_{ji}q_j)^2$ is invariant under $q\mapsto-q$, which is the ambiguity the signs leave.
- *Reading B, what R28 uses it for.* The recorded constraints cut the sign freedom to the realisable set, so the pair is the object the Lagrange conditions may be posed on. **False as recorded**, by the $64$-against-$4$ count above, and **true once (iii) is added**, by the proposition.
- *Vacuity.* Reading A would be vacuous if the extra data were allowed to be continuous, since then "determined by $R$, $G$ and something else" says nothing. It is not vacuous: the data is a choice from a set of size at most $4$ per column, at least $1$, and exactly $4$ at a generic $R$ once (iii) is imposed. **The force of the claim rests entirely on $G$ being fixed**, and $G=E^{\mathsf T}F$ is fixed by the eigenframes rather than by $P$, so that holds in R28's setting.

**8. CONFIRMED to the reach of a search.** Not a proposition, as the brief's Lean row says. Searching [findings/](../findings/), [results.md](../results.md), [routes.md](../routes.md), [plan.md](../plan.md), the four findings indexes and [lean/INDEX.md](../lean/INDEX.md): the objects $R=(E^{\mathsf T}P)^{\circ2}$, $S=(F^{\mathsf T}P)^{\circ2}$ and $G=E^{\mathsf T}F$ appear only in R28's row, in [findings/LEDGER.md](../findings/LEDGER.md) and in [lean/INDEX.md](../lean/INDEX.md), all dated 2026-09-16 and all already carrying this display, so they are the same cycle rather than a prior name. The near misses are genuinely different objects: [diagonal-half.md](../findings/diagonal-half.md) carries $M^{\circ2}$, the entrywise square of **one** symmetric matrix in a spectral-gap relation, with no second frame, and [L224](../findings/second-order.md) carries the Gram matrix of the swap-odd columns, a rank-one peaking argument with no entrywise square. **No earlier alias.**

## One observation outside the eight claims

The Lean docstring says the parity is "the same shape as `degenerate_triangle`, which is why the converse's method applies to the pair as well". [degenerate_triangle](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean) concludes a **linear** relation $U+\varepsilon_1V+\varepsilon_2T=0$ among non-negative reals, and derives it from positivity. The parity is a **multiplicative** relation among signed reals, and derives from nothing but $R$ being an entrywise square. They are different statements, and the inference drawn from the resemblance is the sentence that would license the next step, so it should be dropped or replaced by the proposition above, which is the converse the pair actually has.

## What was run

Screens only, seconds each, on objects constructed for the screen, reported as screens: the identity over $200$ random $(E,F,P)\in O(3)^3$ and over $20$ draws each with one factor non-orthogonal; $\mathop{\mathrm{rank}}M$ and $\mathbf1^{\mathsf T}M$ over $300$ random $G$; the branch counts over eight $R$, six generic and two with zero entries. Every positive claim above is settled by hand, and the proposition is proved rather than screened.
