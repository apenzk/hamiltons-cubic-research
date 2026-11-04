# Review r966: the coupling constraint between the two orthostochastic factors

Gate 2, reviewer r966, on the block quoted in [BRIEF_I106a_coupling.md](BRIEF_I106a_coupling.md). Log: [agent_logs/r966-coupling.log](../agent_logs/r966-coupling.log). Worked from the definitions in the brief and from [I106aOrthostochastic.lean](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean), without the derivation note and without the other reviewer's report.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $F^{\mathsf T}P=G^{\mathsf T}Q$, so $S=(G^{\mathsf T}Q)^{\circ2}$ | **CONFIRMED**, and it consumes $EE^{\mathsf T}=I$. The orthogonality of $F$ and of $P$ is unused |
| 2 | $S_{ik}=\big((G^{\circ2})^{\mathsf T}R\big)_{ik}+2\sum_{j<l}G_{ji}G_{li}T^{(jl)}_k$ | **CONFIRMED** as a polynomial identity in free reals, at every size |
| 3 | $(T^{(jl)}_k)^2=R_{jk}R_{lk}$ | **CONFIRMED**, one line |
| 4 | $T^{(12)}_kT^{(13)}_kT^{(23)}_k=R_{1k}R_{2k}R_{3k}\ge0$ | equality **CONFIRMED**. The inequality **CONFIRMED and VACUOUS**. The sign reading carried elsewhere, *the three signs' product pinned to $+1$*, is **REFUTED** at every column where $R$ has a zero entry, which is R28's own boundary |
| 5 | claim 2 uses no orthogonality | **CONFIRMED** for claim 2 read narrowly, with a scope correction: the block's sentence covers the expansion and not the display, whose left side needs $E$ orthogonal |
| 6 | at $G=I$ the display collapses to $S=R$ | **CONFIRMED**, and sharpened: the collapse holds exactly on the $48$ signed permutations, and at $G=I$ it is the record's existing L227 and L228 item 4 |
| 7 | $S$ is determined by $R$, $G$ and a finite sign choice | **CONFIRMED** on the forward reading, **REFUTED** on the sufficiency reading. Of the $64$ parity-even sign arrays, $60$ produce an $S$ that is not row-stochastic, so not orthostochastic |
| 8 | the record does not already hold this pair under another name | **REFUTED**. The $T^{(jl)}_k$ are the three column products of `orthostochastic_eq` applied to $Q^{\mathsf T}$, and the relation the block omits is that theorem's own hypothesis |

## The one change the block needs

**Add the three row relations**, which are what make the sign choice finite in the sense the block wants:

$$\sum_k T^{(jl)}_k=0,\qquad j<l.$$

They say the rows of $Q$ are orthogonal, so they cost the orthogonality the block declines to spend, and they are the missing half of the constraint. **Their arithmetic:** the three squares $(T^{(jl)}_k)^2=R_{jk}R_{lk}$ together with a vanishing signed sum are exactly `degenerate_triangle`'s hypothesis, so for each row pair $j<l$ one of $\sqrt{R_{j1}R_{l1}}$, $\sqrt{R_{j2}R_{l2}}$, $\sqrt{R_{j3}R_{l3}}$ is the sum of the other two, and the three signs of that pair are pinned up to one global flip. Three pairs give $8$ sign arrays, and the block's parity condition then halves that to $4$, which is the true count.

**So the cut the block reports is the small half of the cut.** From $2^9=512$ arrays, parity alone leaves $64$, the row relations alone leave $8$, and the two together leave $4$.

## Findings, in order

### Claim 1 spends the orthogonality of $E$ and nothing else

$G^{\mathsf T}Q=(E^{\mathsf T}F)^{\mathsf T}(E^{\mathsf T}P)=F^{\mathsf T}(EE^{\mathsf T})P$, which is $F^{\mathsf T}P$ precisely when $EE^{\mathsf T}=I$. Nothing else enters: $F$ and $P$ may be arbitrary. Screened as a symbolic residual in nine free entries of each of $E$, $F$, $P$, and the residual is a non-zero polynomial whose vanishing is $EE^{\mathsf T}=I$ contracted against $F$ and $P$. **Non-vacuous**: a vacuous version would have $G$ defined as $F^{\mathsf T}P Q^{-1}$, making the claim a definition. $G=E^{\mathsf T}F$ is fixed before $P$ is chosen, which is what gives the display content as $P$ varies.

### Claim 2 is an identity in free reals, and claim 5 is right about it

$(\sum_jG_{ji}Q_{jk})^2=\sum_jG_{ji}^2Q_{jk}^2+2\sum_{j<l}G_{ji}G_{li}Q_{jk}Q_{lk}$, and $\sum_j(G^{\circ2})_{ji}R_{jk}=((G^{\circ2})^{\mathsf T}R)_{ik}$ by the definition of the transpose. Verified entry by entry in sympy over $18$ free symbols, and the size $3$ plays no part: the same holds at every $n$ with $j<l$ over all $\binom n2$ pairs. The Lean binders in `coupling_decomposition` are six unconstrained reals, which is the honest form of the same fact.

**The scope correction claim 5 needs.** The block's *It needs NO orthogonality* is true of the expansion and false of the display as the brief defines $S$. With $S:=(F^{\mathsf T}P)^{\circ2}$ the left side reaches the right side only through claim 1, so the display holds for orthogonal $E$ and arbitrary $F$, $P$. The distinction is load-bearing rather than pedantic: the constraint the item owes is the part that does need orthogonality, and the block's boast is a signal that it has stopped one step early.

### Claim 3, and what claim 4's inequality actually carries

$(Q_{jk}Q_{lk})^2=Q_{jk}^2Q_{lk}^2=R_{jk}R_{lk}$, and $T^{(12)}_kT^{(13)}_kT^{(23)}_k=(Q_{1k}Q_{2k}Q_{3k})^2=R_{1k}R_{2k}R_{3k}$. Both verified symbolically, both one line by hand.

**The inequality is vacuous as written.** $R_{jk}=Q_{jk}^2\ge0$ by construction, so $R_{1k}R_{2k}R_{3k}\ge0$ needs neither the equality nor any hypothesis. It is not a consequence of the equality, it is a consequence of $R$ being a matrix of squares, and the equality is not needed to see it. **A claim of this shape is vacuous exactly when its right side is non-negative for a reason independent of the identity, which is the case here.**

**The informative reading, and where it fails.** What the display is for is the left side: three signed reals whose product is non-negative, so the number of negative $T^{(jl)}_k$ in each column is even. That is a real constraint and it is correct **while all three are non-zero**. The strengthened form carried by `coupling_parity`'s docstring and by the [R28](../routes.md) row, *per column the coupling is three signs whose product is $+1$*, is **false at any column where $R$ has a zero entry**: at $Q_{1k}=0$ the triple is $(0,0,\mathop{\mathrm{sign}}(Q_{2k}Q_{3k}))$, whose product is $0$, and the surviving entry is free to be negative. **This is not an edge case for R28**: its boundary is the split locus, the singular set of $Q\mapsto Q^{\circ2}$, which is where zero entries live, so the wording fails on exactly the stratum the route intends to push the maximum onto. The equality $T^{12}T^{13}T^{23}=R_1R_2R_3$ survives there untouched, so the repair is to state the parity as the equality plus *at columns with no zero entry*, or to keep the equality alone.

### Claim 6 holds, and its collapse set is larger than $G=I$

At $G=I$, $(G^{\circ2})^{\mathsf T}=I$ and $G_{ji}G_{li}=\delta_{ji}\delta_{li}=0$ for $j\ne l$, so $S=R$. Consistent with $G=E^{\mathsf T}F=I$ meaning $F=E$ and $S=(E^{\mathsf T}P)^{\circ2}=R$.

**Sharper:** the coupling term vanishes for all $Q$ if and only if $G_{ji}G_{li}=0$ for every $i$ and every $j<l$, that is, every column of $G$ has at most one non-zero entry. For orthogonal $G$ that is the group of $48$ signed permutations, on which $S$ is $R$ with rows permuted. **So the ceiling is genuine but weak**: it tests a $48$-point set of a $3$-dimensional group, and it is passed by any decomposition that is correct to zeroth order in the off-diagonal part of $G$.

### Claim 7 has two readings, and the block is stated in the one that is true and weak

**Forward reading.** *Given a $Q$*, with $R=Q^{\circ2}$ and $\varepsilon_{jl,k}=\mathop{\mathrm{sign}}(Q_{jk}Q_{lk})$, the display returns $S$. **True**, since $T^{(jl)}_k=\varepsilon_{jl,k}\sqrt{R_{jk}R_{lk}}$ and claim 2 is an identity. Zero entries are harmless: where $R_{jk}R_{lk}=0$ the term is $0$ whatever sign is attached. **True and close to empty**: $(R,T)$ determines $Q$ up to column signs, $S=(G^{\mathsf T}Q)^{\circ2}$ is invariant under column signs of $Q$, so the forward reading is the observation that a function of $Q$ is a function of $Q$.

**Sufficiency reading.** *Any $(R,G)$ with any parity-even sign array yields a legitimate $S$*, which is what *rather than free beside it* needs if the pair is to be a parametrised manifold that Lagrange conditions can be written on. **False.** Column sums survive every sign array, since $\sum_i2G_{ji}G_{li}=2(GG^{\mathsf T})_{jl}=0$ for $j\ne l$ leaves $\sum_iS_{ik}=\sum_jR_{jk}=1$. Row sums do not: $\sum_kS_{ik}=1+2\sum_{j<l}G_{ji}G_{li}\sum_kT^{(jl)}_k$, and $\sum_kT^{(jl)}_k=0$ holds only for a row-orthogonal $Q$. **Screened**, at one random $(Q,G)\in O(3)^2$: of the $64$ parity-even arrays, $4$ give a bistochastic $S$ and $60$ do not, the failure being in the row sums alone, with the all-plus array giving row sums $(1.237,0.843,0.921)$. The count $4$ matches the independent count of sign matrices $\Sigma$ with $\Sigma\circ Q$ orthogonal, which is $32$, falling onto $4$ distinct sign-triple arrays because the column flips act trivially on $T$.

**So the honest form of claim 7** is that $S$ is determined by $R$, by $G$ and by one of **four** sign classes, and the cut from $64$ to $4$ is made by the three row relations, which lie outside the quoted block and which need the orthogonality the block advertises doing without.

### The $T$ cannot be eliminated from $(R,S)$ by linear algebra

Read the display at fixed $k$ as a linear system for the three unknowns $T^{(jl)}_k$ with matrix $M_{i,(jl)}=2G_{ji}G_{li}$. **$M$ is singular for every orthogonal $G$**, since $\mathbf 1^{\mathsf T}M$ has entries $2(GG^{\mathsf T})_{jl}=0$. The left kernel is the column-stochasticity of $S$ and carries nothing else. Screened at four random $G\in O(3)$: $\det M$ at machine zero, rank $2$ each time, rank $0$ at $G=I$. **Consequence for the item**: a constraint on the pair $(R,S)$ alone is obtained by eliminating $T$, and that elimination is rank-deficient, so it needs the quadratic relations $(T^{(jl)}_k)^2=R_{jk}R_{lk}$ and the row relations rather than the display alone. The block states a parametrisation and calls it a constraint. The two differ by exactly this elimination, which is not done.

### Claim 8: the record already holds these variables, one theorem above

`orthostochastic_eq` is proved from *one linear relation among the three column products* $q_{00}q_{01}$, $q_{10}q_{11}$, $q_{20}q_{21}$, the products of a pair of columns across the rows. The $T^{(jl)}_k$ are the products of a pair of **rows** across the columns. **They are the same object at $Q^{\mathsf T}$**, and the file's own docstring names them. Two consequences.

- **The block's own missing relation is already typed**, as `orthostochastic_eq`'s hypothesis `h` instantiated at $Q^{\mathsf T}$ and the row pair $(j,l)$. So is its consequence for the signs, as `degenerate_triangle`. The coupling therefore inherits the converse machinery the file already has, which is stronger than the block claims for it and is the natural route to the sufficiency reading of claim 7.
- **The $G=I$ case is on the record as a proved lemma.** [L228](../findings/second-order.md) item 4 reduces the frame dependence to $\sum_{i,k}(F^{\mathsf T}Q)_{ik}^2(z_i\nu_k^2+l_i\nu_k)$ with $Z$ and $L$ **both diagonal in $F$**, that is $E=F$ and $G=I$, *linear in one doubly stochastic matrix*, and closes it by Birkhoff, as does L227's `alignment_step`. So claim 6's ceiling is not a sanity check on a new object, it is the statement that the new display degenerates to the lemma the record already proved, and the whole of the new content sits at $G$ off the signed permutations.

What is genuinely new, and claim 8 is right about this much, is the **decomposition** of $S$ into an $R$-only part and a coupling part with the fixed $G$ as coefficients. The variables and their relations are not new.

## Vacuity checks

| claim | what vacuous would look like | is it vacuous |
|---|---|---|
| 1 | $G$ defined from $P$, making the identity a definition | no, $G$ is fixed before $P$ moves |
| 2 | both sides expanding to the same monomials by construction of the right side | no, the right side is built from $R$ and $G^{\circ2}$, which are strictly less data than $Q$ and $G$ |
| 3, 4 equality | identities in free reals, so no restriction on any configuration | **yes in the sense that matters**: they constrain nothing until $T$ is eliminated, which the block does not do |
| 4 inequality | a right side non-negative for reasons outside the identity | **yes**, $R$ is a matrix of squares |
| 6 | a collapse holding for all $G$ | no, it holds on the signed permutations only |
| 7 | *finitely many signs* with no bound, since any finite set is finite | **close to it**: the true bound is $4$ per configuration, and the block's stated condition permits $64$ |

## What I did not do

No long or open-ended run. Two screens, each seconds on objects built for the screen: a sympy check of claims 2, 3, 4 and 6 as polynomial identities, and an enumeration of $2^9$ sign matrices and $64$ sign arrays at one random $(Q,G)\in O(3)^2$. Both are reported as screens. Every verdict above rests on the hand derivation beside it.
