# Review r996: the $\Lambda^4$ obstructions, and whether I75 is a finite list

Gate 2, one of two independent reviewers on identical briefs. Brief: [BRIEF_I75_lambda4.md](BRIEF_I75_lambda4.md). Worked from the brief's definitions, [AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean) and [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean). No findings file was opened.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $\mathrm{Alt}(W^k)=\tfrac16\sum_\mu\mu^k\,\mathfrak b(P_\mu)$ at every $k$ | **CONFIRMED**, and the $\tfrac16$ is the definition of $\mathfrak b$ rather than a computed constant |
| 2 | $\sum_\mu\mathfrak b(P_\mu)=\mathfrak b(\mathrm{Id})=0$, a free relation | **CONFIRMED**, derived below in one line, true at every $n$ |
| 3 | $\sum_\mu\mu\,\mathfrak b(P_\mu)=6\,\mathrm{Alt}(W)=0$, and it IS first Bianchi | **CONFIRMED** |
| 4 | the $\mathfrak b(P_\mu)$ lie in the kernel of a $2\times s$ Vandermonde | **CONFIRMED with one correction of statement**: the kernel is $(\ker V)\otimes\Lambda^4$, read coordinatewise |
| 5 | at $s=2$ every $\mathfrak b(P_\mu)=0$, with no further hypothesis | **CONFIRMED**, and the class is inhabited, though it excludes nothing until $s$ is bounded |
| 6 | at $s=3$ the family reduces to the single condition $\mathrm{Alt}(W^2)=0$ | **CONFIRMED** |
| 7 | at $s=3$, $\mathrm{Alt}(W^3)=(\sum_\mu\mu)\mathrm{Alt}(W^2)$, over DISTINCT values | **CONFIRMED**, DISTINCT is right and the multiplicity reading is decisively wrong |
| 8 | in general I75 is exactly $s-2$ conditions, $k=2,\dots,s-1$ | **CONFIRMED with a sharpened statement** of what "exactly" means |
| 9 | sharp at the obstruction: $W_{\mathbb{CP}^2}$ has spectrum $\{2c,-c,0\}$, $s=3$ | **PLAUSIBLE**: the spectrum is CONFIRMED and stronger than claimed, the word "exactly" overreaches |
| 10 | what it does NOT give: any bound on $s$ at a maximiser | **CONFIRMED**, and it is the row the other nine hang on |

Nothing is refuted. Four corrections follow, one of which (row 9) is a wording change and one of which (row 4) is a type error in the statement rather than in the mathematics. The material addition is a **derivation of row 2**, which the record carries only as a screen, and an **$n=4$ characterisation of I75** that falls out of it.

## Row 2, attacked first: $\mathrm{Alt}(\mathrm{Id})=0$ is a one-line identity, at every $n$

**The derivation.** In the orthonormal pair basis of $\Lambda^2$,

$$\mathrm{comp}(\mathrm{Id})_{ijkl}=\langle e_i\wedge e_j,\ e_k\wedge e_l\rangle=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}=:G_{ijkl}.$$

$\mathrm{Alt}$ on a tensor with these symmetries is the normalised cyclic average (established in the next section), so

$$3\,\mathrm{Alt}(\mathrm{Id})_{ijkl}=G_{ijkl}+G_{iklj}+G_{iljk}
=(\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk})+(\delta_{il}\delta_{kj}-\delta_{ij}\delta_{kl})+(\delta_{ij}\delta_{lk}-\delta_{ik}\delta_{lj}).$$

The six terms cancel in three pairs: $\delta_{ik}\delta_{jl}$ against $-\delta_{ik}\delta_{lj}$, $-\delta_{il}\delta_{jk}$ against $+\delta_{il}\delta_{kj}$, and $-\delta_{ij}\delta_{kl}$ against $+\delta_{ij}\delta_{lk}$.

**The symmetry that kills it is the symmetry of the Kronecker delta, $\delta_{ab}=\delta_{ba}$, and nothing else.** No trace condition, no Bianchi hypothesis, no dimension hypothesis. It holds at **every $n$** and identically in the indices, so there is no $n$ at which it fails and rows 4 to 8 do not fall.

**The same fact, stated conceptually.** $G$ is the curvature operator of the constant-curvature metric, $\tfrac12\,g\owedge g$ in the Kulkarni–Nomizu product. That is a genuine Riemann tensor, a genuine Riemann tensor satisfies the first Bianchi identity, and by the brief's own line first Bianchi **is** $\mathrm{Alt}=0$. So $\mathrm{Alt}(\mathrm{Id})=0$ is first Bianchi for the round sphere, which is why it was never going to be false.

**Status, which is what the brief doubted.** The record's screen to machine zero is correct, and the claim deserves better than a screen: the display above is the whole proof and it is typable in the existing layer. [comp](../lean/HamiltonsCubic/Base/AltPart.lean) is $\langle R\varphi_{ij},\varphi_{kl}\rangle$ and [alt4](../lean/HamiltonsCubic/Base/AltPart.lean) is the $\tfrac13$ cyclic average, so the obligation is `comp id i j k l = δ_ik δ_jl − δ_il δ_jk` followed by `ring`. The layer's global sign on [comp](../lean/HamiltonsCubic/Base/AltPart.lean), noted in its own docstring, is common to all three cyclic terms and cannot affect a vanishing statement.

**Vacuity.** $\Lambda^4\mathbb R^n=0$ for $n\le3$, so the row says nothing below $n=4$ and has content from $n=4$ up. That is the only vacuity available to it, and the brief's worry was the reverse one.

*Screen, asserted on objects built for the purpose:* $\mathrm{Alt}(\mathrm{Id})=0$ at $n=4,5,6,7$, with the CONTROL that $\mathrm{Alt}$ is **not** identically zero on symmetric operators, asserted at a random symmetric $M$ at each of $n=4,5,6$.

## Row 1: true, and the constant is a normalisation rather than a result

Four things had to hold, and all four do.

- **$\mathrm{comp}$ is linear in the operator.** $\mathrm{comp}(R)_{ijkl}=\langle R\varphi_{ij},\varphi_{kl}\rangle$ is linear in $R$ by inspection, and the layer proves it: [altCoeff_add](../lean/HamiltonsCubic/Base/AltPart.lean) and [altCoeff_smul](../lean/HamiltonsCubic/Base/AltPart.lean).
- **$\mathrm{Alt}$ is a fixed linear average of index permutations**, so $\mathrm{Alt}$ is linear in $R$. Both of the brief's two descriptions of it are linear, and they agree (below).
- **The spectral decomposition pushes through term by term.** $W$ is a symmetric operator on $\Lambda^2$ by [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean)'s second clause, so $W^k=\sum_\mu\mu^kP_\mu$ is a **finite** sum, and linearity is all that is needed. Nothing here requires $W$ to be Weyl.
- **The constant.** $\mathrm{Alt}(W^k)=\sum_\mu\mu^k\mathrm{Alt}(P_\mu)$ and $\mathfrak b(P_\mu):=6\,\mathrm{Alt}(P_\mu)$, so $\mathrm{Alt}(W^k)=\tfrac16\sum_\mu\mu^k\mathfrak b(P_\mu)$. **The $\tfrac16$ is the inverse of the $6$ in the definition of $\mathfrak b$ and is not computed from anything.** Row 1 is therefore a definition chase, and it is exactly right.

**Where the $6$ earns its place, which is the question the constant actually raises.** At $n=4$, $\Lambda^4$ is one-dimensional, spanned by the Hodge star $\star=\Pi_{SD}-\Pi_{ASD}$ with $\|\star\|^2=6$, so $\mathrm{Alt}$ is the projection $R\mapsto\tfrac{\langle R,\star\rangle}{6}\star$ and

$$\mathfrak b(R)=6\,\mathrm{Alt}(R)=\langle R,\star\rangle\,\star=\big(\mathop{\mathrm{tr}}R_+-\mathop{\mathrm{tr}}R_-\big)\star .$$

So $\mathfrak b(P_\mu)=(m^+_\mu-m^-_\mu)\star$ with $m^\pm_\mu$ the multiplicity of $\mu$ in $\Lambda^2_\pm$: **the $6$ is what makes $\mathfrak b$ integral.** That is a fact about the definition worth recording, because it turns every relation below into an integer relation at $n=4$.

**A check the brief's two definitions needed.** The brief defines $\mathrm{Alt}$ as $\tfrac1{4!}\sum_{\sigma\in S_4}\mathrm{sgn}(\sigma)(\cdot)_\sigma$ while the layer defines it as $\tfrac13(T_{ijkl}+T_{iklj}+T_{iljk})$. They agree on $\mathrm{comp}(R)$ at symmetric $R$: the subgroup generated by $(ij)$, $(kl)$ and $(ik)(jl)$ has order $8$ and every element leaves $\mathrm{sgn}(\sigma)\,\mathrm{comp}(R)_\sigma$ unchanged, using the two pair antisymmetries and the pair symmetry, so the $24$ terms fall into $3$ cosets of $8$ equal terms with representatives $ijkl$, $iklj$, $iljk$, all three $3$-cycles carrying sign $+1$. Hence $\tfrac{8}{24}$ times the cyclic sum. **Both readings of the brief give the same $\mathrm{Alt}$, and row 1 is insensitive to the choice.**

*Screen, asserted:* the two averages agree on $\mathrm{comp}(M)$ at random symmetric $M$, $n=4,5,6$; and row 1 holds with the $\tfrac16$ for $k=0,\dots,7$ on a generic $n=4$ Weyl tensor ($s=6$), on the $\mathbb{CP}^2$ model, on a second $s=3$ tensor and on an $s=2$ tensor.

## Row 3: correct, and the identification with Bianchi is exact

$\sum_\mu\mu\,\mathfrak b(P_\mu)=6\,\mathrm{Alt}\big(\sum_\mu\mu P_\mu\big)=6\,\mathrm{Alt}(W)$ by row 1 at $k=1$, and $\mathrm{Alt}(W)=0$ because [altCoeff](../lean/HamiltonsCubic/Base/AltPart.lean) is definitionally $\tfrac13\cdot$[bianchi](../lean/HamiltonsCubic/Base/WeylReal.lean) (the layer proves it by `rfl` in [altCoeff_eq_third_bianchi](../lean/HamiltonsCubic/Base/AltPart.lean)) and [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean)'s third clause is `bianchi R i j k l = 0`. **"It IS first Bianchi" is literally true here, not an analogy.** "Free" is the right word in the intended sense: the relation costs no hypothesis beyond the one already in force.

## Rows 4, 5 and 8: the rank count, counted

**Row 4, with a correction.** The $\mathfrak b(P_\mu)$ are $\Lambda^4$-VALUED, so the map they are killed by is $V\otimes\mathrm{Id}_{\Lambda^4}$, where $V=\begin{pmatrix}1&\cdots&1\\ \mu_1&\cdots&\mu_s\end{pmatrix}$, and its kernel is $(\ker V)\otimes\Lambda^4$ of dimension $(s-2)\dim\Lambda^4$. Read coordinatewise in any basis of $\Lambda^4$, each coordinate vector $(\mathfrak b(P_\mu)^\alpha)_\mu$ lies in $\ker V$ and the row as written is correct. **As written it types a vector of $4$-forms as a vector of scalars**, which is harmless in this argument and would not be harmless in a Lean statement, so the correction is worth carrying into any typed version.

**The nodes are distinct by construction.** $\mu_1,\dots,\mu_s$ are the DISTINCT eigenvalues, which is what the spectral decomposition means, and $W$ is symmetric so it has one. Hence $\mathop{\mathrm{rank}}V=\min(2,s)$, and $\dim\ker V=s-2$ for $s\ge2$.

**Row 5.** At $s=2$, $V$ is square with $\det V=\mu_2-\mu_1\neq0$, so $\mathfrak b(P_{\mu_1})=\mathfrak b(P_{\mu_2})=0$, so $\mathrm{Alt}(W^k)=0$ for every $k\ge0$ by row 1. **No further hypothesis, confirmed.** Two scope notes:

- **$s=1$ is not covered by the row and is trivial anyway**: $W=\mu\,\mathrm{Id}$ with $\mathop{\mathrm{tr}}W=0$ forces $\mu=0$, so $W=0$, which is not on the unit sphere. The record should say so rather than leave $s=1$ outside both rows.
- **Vacuity, the brief's question 7.** The class is inhabited: I built an $s=2$ algebraic Weyl tensor at $n=4$ by giving $W_+$ and $W_-$ the same spectrum $(a,a,-2a)$, and asserted $\mathrm{Ric}=0$, $\mathrm{Alt}(W)=0$, spectrum $\{1,-2\}$, every $\mathfrak b(P_\mu)=0$ and $\mathrm{Alt}(W^k)=0$ for $k\le7$. **So row 5 is a statement about a non-empty class.** What remains open is whether any critical point above $\sqrt{3/2}$ lies in it, and nothing in rows 1 to 9 says it does. See row 10.

**Row 8, confirmed, by two routes.** *The rank route:* the constraints $k=2,\dots,s-1$ append $s-2$ further rows to $V$, giving the square Vandermonde on $\mu_1,\dots,\mu_s$ with $\det=\prod_{i<j}(\mu_j-\mu_i)\neq0$ on distinct nodes. So the enlarged system has kernel $0$, every $\mathfrak b(P_\mu)$ vanishes, and $\mathrm{Alt}(W^k)=0$ for **every** $k\ge0$. The added rows complete a square Vandermonde rather than a singular one precisely because the exponents $0,1,\dots,s-1$ are consecutive from zero and the nodes are distinct.

*The minimal-polynomial route, which needs no matrix at all:* $W$'s minimal polynomial is $m(x)=\prod_\mu(x-\mu)$ of degree $s$, so $W^s$ lies in the span of $\mathrm{Id},W,\dots,W^{s-1}$ and so does every higher power. Applying the linear map $\mathrm{Alt}$ and using $\mathrm{Alt}(\mathrm{Id})=0$ (row 2) and $\mathrm{Alt}(W)=0$ (row 3), every $\mathrm{Alt}(W^k)$ is a combination of $\mathrm{Alt}(W^2),\dots,\mathrm{Alt}(W^{s-1})$. **This is the cleaner derivation and it exhibits rows 2 and 3 as exactly the two free rows.**

**The sharpened statement of "exactly".** The defensible claim is: *the infinite family $\{\mathrm{Alt}(W^k)=0:k\ge0\}$ is EQUIVALENT to the finite subfamily $k=2,\dots,s-1$, which is $s-2$ conditions, and no subfamily of fewer than $s-2$ of them suffices for a general $W$ of that spectrum, because the solution space they must cut to zero has dimension $(s-2)\dim\Lambda^4$.* The claim that would overreach, and that the current wording could be read as, is that all $s-2$ are independent **at a given $W$**. They need not be: a $W$ with all $\mathfrak b(P_\mu)=0$ satisfies all of them for free.

*Screen, asserted:* over $200$ random node sets with $s$ from $2$ to $7$, $\mathop{\mathrm{rank}}V=2$ and the square Vandermonde is nonsingular.

## Row 7, derived independently, and the coefficient is over DISTINCT eigenvalues

At $s=3$, $\ker V$ is spanned by $c=(\mu_2-\mu_3,\ \mu_3-\mu_1,\ \mu_1-\mu_2)$, so $\mathfrak b(P_{\mu_i})=c_i\,v$ for a **single** $v\in\Lambda^4$, and $\mathrm{Alt}(W^k)=\tfrac16\big(\sum_i\mu_i^kc_i\big)v$. The two sums that matter are classical:

$$\sum_i\mu_i^2c_i=-(\mu_1-\mu_2)(\mu_2-\mu_3)(\mu_3-\mu_1),\qquad
\sum_i\mu_i^3c_i=-(\mu_1-\mu_2)(\mu_2-\mu_3)(\mu_3-\mu_1)\,(\mu_1+\mu_2+\mu_3).$$

Dividing, and noting the difference product is nonzero exactly because the nodes are distinct,

$$\boxed{\ \mathrm{Alt}(W^3)=(\mu_1+\mu_2+\mu_3)\,\mathrm{Alt}(W^2)\ }$$

**the sum over the three DISTINCT values, each counted once.**

**The second derivation, which says why.** $m(x)=x^3-e_1x^2+e_2x-e_3$ with $e_i$ elementary symmetric in the **distinct** eigenvalues, so $W^3=e_1W^2-e_2W+e_3\mathrm{Id}$. Apply $\mathrm{Alt}$, kill the last two terms by rows 3 and 2: $\mathrm{Alt}(W^3)=e_1\mathrm{Alt}(W^2)$. **The coefficient is $e_1$ of the MINIMAL polynomial**, and $e_1$ of the minimal polynomial is by definition the sum over distinct values. Row 6 is the same computation stopped one step earlier: $\sum\mu_i^2c_i\neq0$ makes $\mathrm{Alt}(W^2)=0$ equivalent to $v=0$, hence to all $\mathfrak b(P_\mu)=0$, hence to the whole family.

**Why this is the row that could have been got wrong, and the control that separates the readings.** The multiplicity-weighted sum is $\sum_\mu m_\mu\mu=\mathop{\mathrm{tr}}W$, which is **zero** for every Weyl tensor. Had the coefficient been that one, row 7 would read $\mathrm{Alt}(W^3)=0$ unconditionally and the $s=3$ case would collapse to nothing. It does not: at the $\mathbb{CP}^2$ model, $\sum\mu_i^3\mathfrak b_i=6c^3\star\neq0$ while $\mathop{\mathrm{tr}}W=0$. **DISTINCT is right, MULTIPLICITY is wrong, and the two are distinguishable on a tensor the record already owns.**

*Screen, asserted:* $\mathrm{Alt}(W^3)=e_1^{\text{distinct}}\mathrm{Alt}(W^2)$ at the $\mathbb{CP}^2$ model and at a second $s=3$ tensor, with the CONTROL that the multiplicity-weighted coefficient gives a value differing from $\mathrm{Alt}(W^3)$ by more than $10^{-3}$, and the assertion $\mathop{\mathrm{tr}}W=0$ that makes the two readings differ.

## Row 9: the spectrum is confirmed and says more than the row claims, but "exactly where" overreaches

**Confirmed, and constructed.** $W_{\mathbb{CP}^2}$ is self-dual Einstein: $W_-=0$ and $W_+$ has eigenvalues $(2c,-c,-c)$. On $\Lambda^2\mathbb R^4$ the spectrum is therefore $\{2c,-c,0\}$ with multiplicities $(1,2,3)$, **exactly three distinct values for $c\neq0$, so $s=3$.** I rebuilt it as $W=c(3uu^{\mathsf T}-\Pi_+)$ at a unit $u\in\Lambda^2_+$ and asserted $\mathrm{Ric}=0$, $\mathrm{Alt}(W)=0$, and the spectrum and multiplicities above.

**Stronger than the row states, and it is the fact that makes the row worth having.** By row 1's $n=4$ reading, $\mathfrak b(P_\mu)=(m^+_\mu-m^-_\mu)\star$, so at $\mathbb{CP}^2$

$$\mathfrak b(P_{2c})=+\star,\qquad \mathfrak b(P_{-c})=+2\star,\qquad \mathfrak b(P_0)=-3\star,$$

which sum to zero (row 2) and have $\mu$-weighted sum $2c-2c+0=0$ (row 3), while $\sum_\mu\mu^2\mathfrak b(P_\mu)=(4c^2+2c^2)\star=6c^2\star\neq0$. **So $\mathrm{Alt}(W^2)=c^2\star\neq0$: $W_{\mathbb{CP}^2}$ VIOLATES the single $s=3$ condition of row 6.** The relation between it and I75 is therefore that I75's conclusion **excludes** it, which is the right shape for an obstruction and is stronger than "the first case row 5 does not cover".

**Two corrections to the sharpness wording.**

1. **One witness with $s=3$ does not make $s=3$ the locus of failure.** It shows the reduction cannot be pushed past $s=2$ by this route, and it is consistent with sharpness. It does not show that a general $s=3$ Weyl tensor fails the link, nor that failure requires $s\ge3$. Recommended wording: *"the first case row 5 does not cover is $s=3$, and the known obstruction $W_{\mathbb{CP}^2}$ has $s=3$ and violates $\mathrm{Alt}(W^2)=0$."* Drop "exactly where".
2. **A scope mismatch that the wording hides.** [plan.md](../plan.md) line 87 has the link failing at $W_{\mathbb{CP}^2}$ "at the threshold itself", while I75's hypothesis is a critical point **strictly above** $\sqrt{3/2}$. A witness sitting on the boundary is outside the quantifier, so it cannot be a sharpness witness for a statement about the open range. It remains a perfectly good reason to expect no argument to reach $s=3$ for free.

**A characterisation the record should carry, which this row hands over.** At $n=4$, $6\,\mathrm{Alt}(R)=(\mathop{\mathrm{tr}}R_+-\mathop{\mathrm{tr}}R_-)\star$, so

$$\text{I75's requirement}\iff \mathop{\mathrm{tr}}(W_+^k)=\mathop{\mathrm{tr}}(W_-^k)\ \text{for all }k\iff W_+\ \text{and}\ W_-\ \text{are ISOSPECTRAL with multiplicity.}$$

That reads every row above at a glance: $\mathbb{CP}^2$ fails because $W_-=0\neq W_+$; my $s=2$ witness satisfies it because I gave the two blocks the same spectrum; and the requirement is neither vacuous nor automatic at $n=4$.

## Row 10: honest, and it is the load-bearing row

**Nothing in rows 1 to 9 bounds $s$, secretly or otherwise.** Every step is linear algebra in the $\mu$'s and in $\Lambda^4$, valid verbatim at any $s\ge1$: row 2 is an index identity, row 3 is the hypothesis, rows 4 to 8 are Vandermonde rank counts parametrised by $s$, row 9 is one tensor. The only bound in sight is the ambient one, $s\le\dim\Lambda^2=\binom n2$, which is a fact about the space and not about being a maximiser. **At $n=12$ that is $s\le66$, so the "finite list" is up to $64$ conditions.**

**What the reduction does and does not buy, stated positively.** It converts I75 from an infinite family into a finite one whose length is the number of distinct eigenvalues, it discharges the family outright at $s\le2$, and it leaves the finite family open at every $s\ge3$. The record should read it as a restatement of I75 at controlled $s$ and as progress toward I75 only where $s$ is controlled, which is nowhere yet.

## Vacuity, row by row, as the brief asks

| # | what VACUOUS would look like | is it? |
|---|---|---|
| 1 | no $W$ admits a spectral decomposition | no: $W$ is symmetric on $\Lambda^2$, so it always does |
| 2 | $\Lambda^4=0$, i.e. $n\le3$ | no from $n=4$ up, and the CONTROL shows $\mathrm{Alt}\neq0$ on general symmetric operators |
| 3 | $\mathrm{Alt}(W)=0$ holding for reasons other than Bianchi | no: it is Bianchi, definitionally |
| 4 | $s<2$, so no Vandermonde | $s=1$ forces $W=0$, and from $s=2$ up the matrix is a real rank-$2$ constraint |
| 5 | no Weyl tensor has $s=2$ | no: constructed at $n=4$. **The live gap is that no critical point is known to have $s=2$** |
| 6 | $\mathrm{Alt}(W^2)=0$ automatic at $s=3$ | no: $\mathbb{CP}^2$ violates it |
| 7 | both sides zero at every $s=3$ tensor | no: both sides are $6c^3\star/6$ and $c\cdot 6c^2\star/6$ at $\mathbb{CP}^2$, nonzero |
| 8 | $s-2=0$ always | no: $s=6$ on a generic $n=4$ Weyl tensor, giving four conditions |
| 9 | $W_{\mathbb{CP}^2}$ having $s\neq3$ | no: $s=3$, asserted |
| 10 | a bound on $s$ existing elsewhere and making the disclaimer moot | no bound is in evidence |

## Corrections, in the order they should be applied

1. **Record row 2 as a derived lemma, not a screen.** The proof is the display in the first section, the symmetry is $\delta_{ab}=\delta_{ba}$, it holds at every $n$, and it is typable against [alt4](../lean/HamiltonsCubic/Base/AltPart.lean) and [comp](../lean/HamiltonsCubic/Base/AltPart.lean) with a `ring` after one `simp`.
2. **Row 4: say that the kernel is $(\ker V)\otimes\Lambda^4$.** The $\mathfrak b$'s are $4$-forms, so the scalar phrasing is a type error waiting to be inherited by a Lean statement.
3. **Row 8: replace "exactly $s-2$ conditions" with the equivalence plus the minimality clause**, so the claim is about the family being spanned rather than about independence at a fixed $W$.
4. **Row 9: drop "exactly where the link is known to fail"**, add that $W_{\mathbb{CP}^2}$ **violates** $\mathrm{Alt}(W^2)=0$, and note that it sits at the threshold rather than above it, so it is outside I75's own quantifier.
5. **Add the $n=4$ reading** $\mathfrak b(R)=(\mathop{\mathrm{tr}}R_+-\mathop{\mathrm{tr}}R_-)\star$ and its corollary that I75 at $n=4$ is exactly the isospectrality of $W_+$ and $W_-$. It explains the $6$, makes every $\mathfrak b(P_\mu)$ an integer multiple of $\star$, and gives the record a cheap supply of tensors on both sides of the condition.
6. **Note the two derivations of row 7 and prefer the minimal-polynomial one**, since it proves rows 6, 7 and 8 at once and uses rows 2 and 3 as its only inputs.

## What this review did NOT establish

It did not check that $W_{\mathbb{CP}^2}$ is a critical point, or at what $\theta$. That is taken from [plan.md](../plan.md) and flagged rather than verified. It did not examine whether any critical point above $\sqrt{3/2}$ has $s=2$, which is the question rows 5 and 10 hand back to the programme. It ran no sweep, no census and no search.

*Method note.* The derivations above are by hand. Every numeric statement in this report is a screen on objects constructed for the purpose, run as assertions with two controls, finishing in $0.1$ seconds.
