# Review r594, Lemma L109, the per-coordinate cap $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$

**Verdict: CONFIRMED as an inequality, the constant, the exponent and the derivation are all correct, and the derivation needs strictly less than the block claims. Six surrounding statements are GAPS and one statement elsewhere on the record is REFUTED with a witness.**

Reviewer B of two on identical briefs. Reviewer number 594, audit target [bounds-relaxations.md:47–75](../findings/bounds-relaxations.md#L47), read cold from [conventions.md](../findings/conventions.md) and [Prop 1.7](../references/petersen-wink-2019-bochner-technique/notes.md) rather than from the block's reasoning. Analysis only; the one screen run is labelled as such in §6 and supports nothing that is not derived first.

| # | question from the brief | verdict |
|---|---|---|
| 1 | the cap and its derivation | **CONFIRMED**, and it holds far more widely than the block's placement suggests |
| 2 | the excluded-index sharpening | **real, correctly diagnosed, and provably void wherever the cap is tight**, with a stronger sharpening the block misses |
| 3 | saturation on $S^k\times S^k$ | **exact and derivable in closed form**; the block's *slack $0.0000$* is an identity reported as a measurement, **GAP** |
| 4 | the two saturation statements | **compatible**, but the block's stated reason is a non sequitur, **GAP** |
| 5 | the stale ceiling | the *stale* charge is itself wrong: the two numbers belong to different constraint classes. The conclusion survives either way, **GAP** |
|, | provenance | **TRUE**, and verified against both reviewer files. The first true provenance note in this audit series |
|, | the double heading | one heading too many, and the surplus one carries provenance where an address belongs |

## 1. The cap, re-derived from the definitions

Three inputs, and nothing else.

- **[Prop 1.7](../references/petersen-wink-2019-bochner-technique/notes.md).** For $\{\Xi_\alpha\}$ an orthonormal basis of $\Lambda^2V$ diagonalising $R\in\mathrm{Sym}^2(\Lambda^2V)$, $|LR|^2=2\sum_{\alpha<\beta}(\lambda_\alpha-\lambda_\beta)^2g(L\Xi_\alpha,\Xi_\beta)^2$ for every $L\in\mathfrak{so}(V)$. Taking $L=v_\gamma$ and reading sums over **ordered** pairs as [conventions.md](../findings/conventions.md) requires, this is $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$ with $T_{\gamma\alpha\beta}=c_{\gamma\alpha\beta}^2$.
- **$T\ge0$**, immediate from $T_{abc}=c_{abc}^2$ and the total antisymmetry of the structure constants ([conventions.md](../findings/conventions.md)).
- **The row marginal.** $\sum_\alpha\|[v_\gamma,v_\alpha]\|^2=-\mathop{\mathrm{tr}}_{\mathfrak{so}(n)}\mathrm{ad}(v_\gamma)^2=-(n-2)\mathop{\mathrm{tr}}(v_\gamma^2)=2(n-2)$, using the Killing form $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ and $\mathop{\mathrm{tr}}(v^2)=-2$ at unit norm in the half-trace pairing. Since $\|[v_\gamma,v_\alpha]\|^2=\sum_\beta c_{\gamma\alpha\beta}^2=R_{\gamma\alpha}$, this is $\rho_\gamma=\sum_{\alpha\beta}T_{\gamma\alpha\beta}=2(n-2)$.

Then one line of Hölder, $\ell^\infty$ against $\ell^1$:

$$g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}\ \le\ \Big(\max_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2\Big)\sum_{\alpha\beta}T_{\gamma\alpha\beta}=2(n-2)(\lambda_{\max}-\lambda_{\min})^2 .$$

**The constant $2(n-2)$ and the exponent $2$ are confirmed.** The substitution into a single $g_\gamma$ is legitimate exactly because it is not a contraction: [post F18](../findings/bounds-relaxations.md#L108) shows that contracting Prop 1.7 against weight $1$ returns $\sum g=4(n-1)$ and against weight $\lambda$ returns $-4\theta$, both already on the record, whereas the per-row statement is $N=\binom n2$ inequalities and no weight has been spent. That is [Reviewer 109's category point](REVIEW_r109.md) (the collapse is a statement about equalities, bounds are made of inequalities) and it is correct.

**Sanity check that the marginal is the right one.** Summing the cap's own ingredients over $\gamma$ reproduces the recorded second moment: $\sum_{\gamma\alpha\beta}(\lambda_\alpha^2+\lambda_\beta^2)T=2\cdot2(n-2)\sum_\alpha\lambda_\alpha^2$ and $-2\sum_{\gamma\alpha\beta}\lambda_\alpha\lambda_\beta T=-2\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta R_{\alpha\beta}=+4$, giving $4(n-2)+4=4(n-1)$.

## 2. The quantifier the block omits, a gap of the same kind [r563/r564](REVIEW_r563.md) found in L107

**The cap needs no criticality, no first Bianchi identity, no trace-freeness and no normalisation.** Prop 1.7 is stated in the source for any $R\in\mathrm{Sym}^2(\Lambda^2V)$, and its three-line proof uses only that $L$ acts skew-adjointly; the row marginal is a Killing-form fact about $\mathfrak{so}(n)$ that holds for any orthonormal basis. Both sides of the cap are homogeneous of degree $2$ in $W$, so unit norm is not needed either.

So the correct statement is: **for every symmetric operator $W$ on $\Lambda^2\mathbb R^n$, every unit eigenvector $v_\gamma$, $\|[\mathrm{ad}(v_\gamma),W]\|^2\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$.** The block files it in a Weyl-only, critical-point-only context and states no hypotheses at all. This is the same defect [bounds.md:349](../findings/bounds.md#L349) records against L107 (*"the record files as a critical-point bound something that holds everywhere"*) and it matters here for the same reason: a bound with a hypothesis it does not need cannot be applied off the locus where a successor wants it.

## 3. "Outside $\{g\ge0,\ \sum g=4(n-1)\}$" is true and the block asserts it without proof

Write $s=\lambda_{\max}-\lambda_{\min}$ and $C=2(n-2)s^2$. At $\|W\|=1$,

$$s^2\le2(\lambda_{\max}^2+\lambda_{\min}^2)\le2\sum_\alpha\lambda_\alpha^2=2\quad\Longrightarrow\quad C\le4(n-2)<4(n-1),$$

with the first step AM–QM and the second the definition of the norm. So the cap is **strictly** informative at every unit $W$, at every $n$, with a margin of at least $4$ in the total. The block and both reviewer reports assert this and none derives it; it is two lines and belongs in the block.

**A free corollary the block could carry, in the other direction.** Combining $g_\gamma\le C$ over all $N=\binom n2$ rows with $\sum_\gamma g_\gamma=4(n-1)$ forces $NC\ge4(n-1)$, i.e.

$$\lambda_{\max}-\lambda_{\min}\ \ge\ \frac2{\sqrt{n(n-2)}}\qquad\text{at every unit }W\in\mathcal W_n .$$

It is slack by a factor $\sqrt{(2k-1)/k}\to\sqrt2$ at the balanced products, so it is not a live bound, but it shows the cap has global content and not only pointwise content, which is the thing the block's "it sharpens pointwise and stops there" leaves unexamined.

## 4. The excluded-index sharpening, the main question

### 4a. The correct closed form

$T$ is hollow as a $3$-tensor ([conventions.md](../findings/conventions.md)), so every term of $g_\gamma$ has $\alpha,\beta\ne\gamma$ and $\alpha\ne\beta$. The maximum of $(\lambda_\alpha-\lambda_\beta)^2$ over that index set is attained at an argmax/argmin pair among the indices away from $\gamma$, which are distinct whenever the deleted spectrum is non-constant. Hence the sharp form of this argument is

$$\boxed{\,g_\gamma\ \le\ 2(n-2)\big(\lambda^{\hat\gamma}_{\max}-\lambda^{\hat\gamma}_{\min}\big)^2\,},\qquad \lambda^{\hat\gamma}_{\max}=\max_{\alpha\ne\gamma}\lambda_\alpha,\quad \lambda^{\hat\gamma}_{\min}=\min_{\alpha\ne\gamma}\lambda_\alpha .$$

This is the sharpest statement obtainable from $T\ge0$, hollowness and the marginal alone: given only those, the extremal $T$ puts the whole marginal on the maximising pair.

### 4b. The bite condition, the record's reading is RIGHT

$\lambda^{\hat\gamma}_{\max}<\lambda_{\max}$ holds iff $\gamma$ is the **unique** argmax, and symmetrically at the bottom. So the effect bites on row $\gamma$ iff $\lambda_\gamma$ is an extreme eigenvalue **and** that extreme eigenvalue is simple, which is the condition [LEDGER.md:1320](../findings/LEDGER.md#L1320) states, and the same multiplicity-one condition that separates [L107](../findings/bounds.md#L345) from [L70](../findings/bounds.md#L185). **Confirmed.** Note the consequence the record does not draw: at most **two** of the $N$ rows are ever affected, and the top row is one of them.

### 4c. REFUTED, the record's written form of the sharpened spread is not a valid cap

[LEDGER.md:1320](../findings/LEDGER.md#L1320) writes the sharpened spread as $(\sigma_\gamma-\ell_\gamma)^2$ and ties it in the next clause to [L107](../findings/bounds.md#L345), where those symbols are defined as *"the means of the two smallest and the two largest eigenvalues over indices $\ne a$"*. Under that reading the claim is **false**, not merely loose:

$$\sigma_\gamma\le\lambda^{\hat\gamma}_{\max},\qquad \ell_\gamma\ge\lambda^{\hat\gamma}_{\min}\ \Longrightarrow\ (\sigma_\gamma-\ell_\gamma)^2\le\big(\lambda^{\hat\gamma}_{\max}-\lambda^{\hat\gamma}_{\min}\big)^2,$$

strictly whenever the deleted top or bottom eigenvalue is simple, so $2(n-2)(\sigma_\gamma-\ell_\gamma)^2$ is a **strictly smaller** quantity than the sharp cap, and nothing derives it. **The witness is the derivation itself.** In L107 the row variable is the *mean* $X=\tfrac12(\lambda_b+\lambda_c)$ of two distinct indices, so the two-largest mean $\sigma_a$ is exactly the right endpoint of its range. In L109 the summand is a *difference* $(\lambda_\alpha-\lambda_\beta)^2$, which needs only two distinct indices and reaches $\lambda^{\hat\gamma}_{\max}-\lambda^{\hat\gamma}_{\min}$ outright. **The analogy to L107 breaks precisely at the object being maximised, and the LEDGER imports the symbols across that break.** Concretely: with the deleted spectrum $(3,1,1,\dots,-1)$ up to scale, $\sigma_\gamma=2$ against $\lambda^{\hat\gamma}_{\max}=3$, so the LEDGER's form asserts $g_\gamma\le2(n-2)\cdot9$ where the derivation supports only $2(n-2)\cdot16$.

*Scope of the refutation:* the defect is in [LEDGER.md](../findings/LEDGER.md), not in the L109 block, which carries no sharpened form at all. It is recorded here because the LEDGER row is what a successor will read when it picks the sharpening up. Per the brief I have edited nothing under [findings/](../findings/).

### 4d. "Restricting to the support" splits into two claims, and only one is usable

The brief asks whether restricting to the **support of row $\gamma$** sharpens the cap. It does, but the support has two parts and they have opposite standing.

| part of the restriction | what it rests on | usable in the constraint class? |
|---|---|---|
| $\alpha,\beta\ne\gamma$ | hollowness of $T$, i.e. antisymmetry of the structure constants, universal | **yes**, it is a property of every $T$ the class admits |
| $R_{\gamma\alpha}=0$ for further $\alpha$ | which pairs of eigenvectors happen to commute at this $W$ | **no**, it is data about one point, and an LP over $(\lambda,T)$ will simply choose full support |

So the second part sharpens the *evaluation* of $g_\gamma$ at a given $W$ and cannot sharpen the *bound*. This is not a small distinction: at a coordinate-diagonal $W$ the support of row $\gamma$ has only $2(n-2)$ of the $N-1$ available indices, which looks like an enormous gain and is worth exactly nothing to any bound in the class.

### 4e. A strictly stronger sharpening, from a fact the record already holds

The pair cap $R_{\gamma\alpha}=\|[v_\gamma,v_\alpha]\|^2\le2$ ([Lemma L31](../findings/stratum-two-negative.md), tabled in [conventions.md](../findings/conventions.md)) is in the class and the block does not use it. Let $p_\gamma$ and $q_\gamma$ count the indices $\alpha\ne\gamma$ with $\lambda_\alpha=\lambda_{\max}$ and $\lambda_\alpha=\lambda_{\min}$. The mass $T_{\gamma\cdot\cdot}$ puts on ordered extreme pairs is $2\Sigma$ with $\Sigma=\sum_{\alpha\in E_{\max},\beta\in E_{\min}}T_{\gamma\alpha\beta}$, and

$$\Sigma\le\sum_{\alpha\in E_{\max}}R_{\gamma\alpha}\le2p_\gamma,\qquad \Sigma\le\sum_{\beta\in E_{\min}}R_{\gamma\beta}\le2q_\gamma\ \Longrightarrow\ 2\Sigma\le4\min(p_\gamma,q_\gamma).$$

Since saturation of the cap requires the **whole** marginal $2(n-2)$ to sit on extreme pairs, this gives a dimension theorem:

$$\boxed{\,g_\gamma=2(n-2)(\lambda_{\max}-\lambda_{\min})^2\ \Longrightarrow\ \min\big(\dim E_{\max},\dim E_{\min}\big)\ \ge\ \tfrac{n-2}2\,}$$

(counting away from $\gamma$; the extra unit is free at $n\ge6$). **This is the L109 analogue of [L70](../findings/bounds.md#L195)'s $\dim E_{\min}\ge n/2$, $\dim E_{\max}\ge(n-2)/2$, obtained the same way, pair cap plus Killing marginal, no spectrum and no Lie theory.**

Two consequences, both of which the block reaches only by measurement:

1. **The excluded-index sharpening is provably void wherever the cap is tight.** Saturation forces both extreme eigenvalues to have multiplicity $\ge(n-2)/2\ge2$ for $n\ge6$, and §4b says the sharpening bites only at a *simple* extreme eigenvalue. So *"sharpening costs nothing at the maximiser"* is a **theorem about every saturating point**, not a fact about $S^k\times S^k$. This is the strongest thing in this review and it answers brief items 2 and 3 jointly.
2. **When multiplicities are small the cap is unattainable by a factor in closed form**, since the extreme-pair mass cannot exceed $4\min(p_\gamma,q_\gamma)$, and unlike the excluded-index effect this bites on *every* row, not on two.

### 4f. How much the excluded-index effect is worth, in closed form

Only the bottom row matters: water-filling $4\theta=-\sum_\gamma\lambda_\gamma g_\gamma$ under $0\le g_\gamma\le C_\gamma$, $\sum g=4(n-1)$ fills the most negative rows first, and the sharpened top row is never filled unless every other row is. Let $\epsilon=\lambda^{(2)}_{\min}-\lambda_{\min}$ be the bottom gap. The row cap falls from $C=2(n-2)s^2$ to $C'=2(n-2)(s-\epsilon)^2$, displacing

$$C-C'=2(n-2)\,\epsilon\,(2s-\epsilon)$$

of mass onto a row worth at least $\epsilon$ less and at most $s$ less, so the gain in the $\theta$-bound lies in

$$\Big[\tfrac{(n-2)}2\,\epsilon^2(2s-\epsilon),\ \ \tfrac{(n-2)}2\,\epsilon\,s\,(2s-\epsilon)\Big].$$

**Both ends vanish with $\epsilon$, and the sharpened cap is continuous in $\lambda$**, so an LP free to choose its spectrum can evade the sharpening entirely by doubling its bottom eigenvalue, at a first-order cost of its own. Whether the class ceiling actually moves is therefore *not* decidable from here: it is the question whether the crude LP's optimising spectrum has a simple $\lambda_{\min}$, and if it does, by how much re-optimising under the added degeneracy costs. **That is the one run I would ask approval for**, and it is one run: solve the recorded $n=6$ marginals-plus-$T\ge0$ LP twice, once with $C$ and once with the $\gamma$-dependent $C_\gamma$ of §4a, and report the optimising spectrum's bottom multiplicity in both. *If* the two optima agree, the sharpening is confirmed inert as a ceiling and the block's "it sharpens pointwise and stops there" is established rather than asserted; *if* the sharpened optimum is lower, the record has an LP ceiling below $1.60$ and the class question reopens at the third digit. Either outcome is worth having and neither is reachable by hand, because it turns on the numerical optimiser's vertex.

## 5. Saturation on $S^k\times S^k$, exact, and derivable twice

Take $S^k\times S^k$ at equal radii, $n=2k$. It is Einstein with $\mathrm{Ric}=(k-1)g$ and $s_{\mathrm{scal}}=2k(k-1)$, so $W=R-\tfrac{s_{\mathrm{scal}}}{n(n-1)}\mathrm{Id}$ on $\Lambda^2$, giving

$$\lambda_{\max}=\tfrac k{2k-1}\ \text{ on }\Lambda^2V_1\oplus\Lambda^2V_2\ (\text{multiplicity }k(k-1)),\qquad \lambda_{\min}=-\tfrac{k-1}{2k-1}\ \text{ on }V_1\otimes V_2\ (\text{multiplicity }k^2),$$

which is traceless as required and matches the multiplicities [post F28](../findings/bounds-relaxations.md#L21)'s own table records ($\#\{g_\gamma=0\}=k(k-1)$, $\dim E_{\min}=k^2$). Unnormalised $\lambda_{\max}-\lambda_{\min}=1$ and $\|W\|^2=k^2(k-1)/(2k-1)$, so at unit norm $s^2=(2k-1)/(k^2(k-1))$ and

$$C=2(n-2)s^2=\frac{4(2k-1)}{k^2}.$$

**First derivation of $g_\gamma$, structural.** $\mathfrak{so}(2k)=\mathfrak h\oplus\mathfrak p$ with $\mathfrak h=\mathfrak{so}(k)\oplus\mathfrak{so}(k)=E_{\max}$ and $\mathfrak p=V_1\otimes V_2=E_{\min}$ is a symmetric pair, so for $\gamma\in\mathfrak p$ the bracket relations $[\mathfrak p,\mathfrak p]\subseteq\mathfrak h$, $[\mathfrak h,\mathfrak p]\subseteq\mathfrak p$, $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ force **every** nonzero $c_{\gamma\alpha\beta}$ to have one of $\alpha,\beta$ in $\mathfrak h$ and the other in $\mathfrak p$. So every surviving term carries the factor $(\lambda_{\max}-\lambda_{\min})^2$ exactly, and Hölder is an equality:

$$g_\gamma=(\lambda_{\max}-\lambda_{\min})^2\rho_\gamma=2(n-2)s^2=C\qquad\text{for every }\gamma\in E_{\min}.$$

**Second derivation, by the second moment.** $g$ is a quadratic form in $v_\gamma$ invariant under the isometry group, and $V_1\otimes V_2$ is irreducible under $SO(k)\times SO(k)$, so $g$ is constant on the $k^2$ unit vectors of $E_{\min}$; it vanishes on $\mathfrak h$, whose elements are infinitesimal symmetries. Then $k^2g_\gamma=\sum_\gamma g_\gamma=4(n-1)=4(2k-1)$ gives $g_\gamma=4(2k-1)/k^2$, **which is $C$**. The two routes are independent and agree.

**A third consistency check, on the split of the marginal.** For $\gamma\in\mathfrak p$, $\sum_{\alpha\in\mathfrak h}R_{\gamma\alpha}$ is the Casimir of $\mathfrak{so}(k)\oplus\mathfrak{so}(k)$ on the vector-times-vector representation, $=2(k-1)$ by direct summation over $\varphi_{ab}$. The per-row identity $\sum_\alpha\lambda_\alpha R_{\gamma\alpha}=-2\lambda_\gamma$ with $\sum_\alpha R_{\gamma\alpha}=4(k-1)$ solves to the same $2(k-1)$, independently.

### 5a. So the block's "slack $0.0000$" is a defect of presentation

**Saturation here is an identity with a two-line structural proof, and the block reports it as a measurement at three dimensions.** By the brief's own criterion this is a number presented as an identity, in the direction that costs the most: the reader is told a fact is observed when it is derived, and so cannot see *why* it is true or where else it holds. The same applies to *"the capped bound returns $\theta_0(2k)$ to machine precision"*: since $\dim E_{\min}\cdot C=k^2\cdot4(2k-1)/k^2=4(n-1)$ exactly, water-filling places the entire mass on $E_{\min}$ and returns $\theta\le(n-1)|\lambda_{\min}|$, which is [L107](../findings/bounds.md#L345)'s $\Pi$-bound; and $(2k-1)\cdot\tfrac{\sqrt{k-1}}{k\sqrt{2k-1}}=\tfrac{\sqrt{(2k-1)(k-1)}}k=\theta_0(2k)$ by the recorded $\theta_0(n)^2=2(n-1)(n-2)/n^2$. **Two lines, and the block spends "to machine precision" on them.**

### 5b. And "saturated *exactly* on $S^k\times S^k$" is two claims, one of which is false as written

The word does double duty. *Exact equality*: **true and now derived.** *Only there*: **unproven, and false at the level of rows.** Even at $S^k\times S^k$ the cap is saturated only on the $k^2$ rows of $E_{\min}$; on the $k(k-1)$ rows of $E_{\max}$, $g_\gamma=0$ against a cap of $C>0$, which is maximal slack. And the derivation of §5 shows saturation at $\gamma$ needs only that $W$ take two values, $\lambda_{\max}$ on $\mathfrak h$ and $\lambda_{\min}$ on $\mathfrak p$, for **some** $\mathbb Z_2$-grading of $\mathfrak{so}(n)$ with $\gamma\in\mathfrak p$, a hypothesis about the point, of which "is a balanced sphere product" is one instance and not obviously the only one. The honest statement is: *saturated at every two-eigenvalue graded $W$ whose grading splits $E_{\max}/E_{\min}$, on the $\mathfrak p$ rows; the balanced products are the record's instances, and whether the classification closes there is open.* Two entries of [post F28](../findings/bounds-relaxations.md#L21)'s own table are consistent with this and neither settles it: $\mathbb{CP}^m$ is graded with $\mathfrak h=\mathfrak u(m)$ but carries **three** eigenvalues, so $\mathfrak h$ is not a single $\lambda_{\max}$ and saturation fails there, as the block's own numbers show.

## 6. One screen, reported as a screen

To guard against a convention slip in §5 (the half-trace pairing, the ordered-pair marginal), I built the two-eigenvalue operator above on $\Lambda^2\mathbb R^{2k}$ in the $\varphi_{ab}=E_{ab}-E_{ba}$ basis and evaluated $g_\gamma=\|[\mathrm{ad}(v_\gamma),W]\|^2$ directly, for $k=3,4,5$. It returns $C=g_\gamma=2.2\overline2,\ 1.75,\ 1.44$ against the predicted $4(2k-1)/k^2$, $g_\gamma=0$ on every $E_{\max}$ row, $\sum_\gamma g_\gamma=4(n-1)$, and $\dim E_{\min}=k^2$. **This is a screen of claims already derived above and is not evidence for any of them**; the derivations in §5 stand or fall on their own. Seconds of compute, objects constructed for the purpose, nothing swept and nothing searched.

## 7. The two saturation statements are compatible, and the block's reason for one of them is a non sequitur

The block writes: *"Since $\sum_{\mathfrak m}g=4(n-1)-\Delta-G_0$ exactly and the cap is smaller than $4(n-1)$, mass is forced off the bottom eigenvalue."*

**As stated this is invalid.** The cap bounds each row, so what it forces is

$$\dim E_{\min}\cdot C\ \ge\ 4(n-1)-\Delta-G_0,$$

and mass is displaced iff that fails. The comparison "$C<4(n-1)$" is the special case $\dim E_{\min}=1$; §3 shows $C<4(n-1)$ holds at **every** $W$, so as written the sentence would force mass off the bottom everywhere, including where nothing is forced.

**With the multiplicity restored the two statements are compatible, and their coexistence is exact rather than lucky.** At $S^k\times S^k$, $\dim E_{\min}\cdot C=k^2\cdot4(2k-1)/k^2=4(2k-1)=4(n-1)$ and $\Delta=G_0=0$. The two constraints (the per-row cap and the total mass), are **simultaneously tight**, so the balanced product sits exactly on the boundary of the forcing condition: the cap is active, and its gain is zero. That is the structural content of "costs nothing at the maximiser", and it is the same fact as §4e's dimension theorem read at the equality case.

## 8. The ceiling, the block's own "stale" verdict is the thing that is wrong

The two numbers belong to two different constraint classes and are not versions of each other.

| figure | constraint set | relation to L109's cap |
|---|---|---|
| $1.60/2.29/2.49$ at $n=6,8,12$ | $T\ge0$, total symmetry, row marginals $2(n-2)$, pair caps $2$, $\mathop{\mathrm{tr}}(W^\#)=-1$, [fence-posts.md:175](../findings/fence-posts.md#L175) | **a superset** of L109's inputs, so L109's own relaxation optimises no lower than $1.60$ |
| $1.413614$ at $n=6$, $2.2585$ at $n=8$ | the above **plus the vector identity** $R\lambda=-2\lambda$, [bounds-relaxations.md:92](../findings/bounds-relaxations.md#L92) | outside L109's inputs entirely; the cap is built from $T\ge0$ and the marginal and carries no per-row identity |

So the block should carry $1.60/2.29/2.49$ **with the constraint set named**, and the later paragraph's charge that this is *"stale in two places"* is a class confusion rather than a correction: a tighter ceiling for a larger constraint set is not a ceiling for L109's smaller one. **What the block genuinely owes is the naming, not the number.** As written, neither paragraph says which constraints its number belongs to, which is what let the two collide.

**The conclusion survives every variant on the record, and this is the robust part.** Against $\sqrt{3/2}=1.224745$: $1.60$, $1.5305$, $1.722739$, $1.6089$, $1.413614$, $1.4212$, $1.3993/1.4005$ and even $1.306498$ (the tightest figure anywhere, from marginals plus the vector identity plus $S=0$), all exceed the target, several by more than $6\%$ and most by far more. **"It cannot close" holds under all of them.** The single sub-target figure on the record, the $n=12$ pointwise bite at $1.212$, is explicitly recorded as not surviving as a ceiling, and it is the one number that would matter if it did.

## 9. Provenance, TRUE, and this is the first one

The block claims: *"Gate 2 output rather than cycle output, Reviewers 109 and 110 constructed it separately while refuting post F25."* Checked against both files rather than against the claim:

- [REVIEW_r109.md:46](REVIEW_r109.md#L46) carries $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}\le(\lambda_{\max}-\lambda_{\min})^2\rho_\gamma=2(n-2)(\lambda_{\max}-\lambda_{\min})^2=:c$.
- [REVIEW_r110.md:66](REVIEW_r110.md#L66) carries the identical display under the name $K$, and §3c there calls it *"a per-coordinate cap, provably outside $\{g\ge0,\ \sum g=4(n-1)\}$"*.
- Both reports are headed *fence post F25*, and [fence-posts.md:77](../findings/fence-posts.md#L77) confirms F25 is withdrawn; the commit `eb31bc71` reads *"fence post 25 withdrawn; the refutation produced a sharpening"*.
- The two implementations are independent: r110 states it computed $g_\gamma$ directly from $\mathrm{ad}$ rather than through Prop 1.7, precisely so the Prop 1.7 check is a check.

**Every clause is true.** The brief records six such notes audited and six false; this one holds, including the reading it forces, that two constructions are evidence and not an audit, which is why [INDEX-results.md:127](../findings/INDEX-results.md#L127) correctly says *Gate 2: no verdict on the record*.

**One attribution inside the block is wrong, though.** The table files r109's *8–15%* under **against the a priori bound**, alongside r110's *15–25%*. r109's baseline is *the recorded bound* (its §(a) is titled around $\Delta$ and $G_0$ and its table column is headed *recorded bound*) which is the **$\Delta$-aware** bound, the second row of the block's table. r110's a priori figure is $15$–$25\%$ and its $\Delta$-aware figure is $2$–$12\%$. So the two entries in the first row are not two measurements of one thing, and the apparent disagreement between $15$–$25\%$ and $8$–$15\%$ is an artefact of the mis-filing.

## 10. The heading, and what the correct structure is

[structure-check](../.claude/skills/structure-check/SKILL.md) requires **"Every numbered result is a heading, exactly `#### Lemma L<N>, <short name>`"**, and that an id appear as a heading exactly once. The block has that at line 47 and then a second `####` at line 49 with **no body between them**, so the numbered heading has an empty section and the two read as one title broken over two lines.

**The correct structure is one `#### Lemma L109, <short name>` heading followed immediately by the statement.** Two further points:

- The surplus heading duplicates the numbered one's content (both say *per-coordinate cap on $g_\gamma$*) so it carries no navigational information.
- What it *does* carry is a **provenance claim**, *"found by two reviewers independently"*. A heading is an address; provenance is a property of the body, and putting it in a heading means a `grep` for the result's name returns the history instead of the mathematics.

This is a house pattern in the file rather than a slip unique to L109, [L114](../findings/bounds-relaxations.md#L118), [L115](../findings/bounds-relaxations.md#L244), [L116](../findings/bounds-relaxations.md#L222) and [L119](../findings/bounds-relaxations.md#L292) all do it, while [L110](../findings/bounds-relaxations.md#L76) does not, so the fix is a decision about the file, not about this block.

## 11. Pointers and hedges

**All pointers resolve.** The block's three links, [notes.md](../references/petersen-wink-2019-bochner-technique/notes.md) (Prop 1.7 present at §1.7, quoted verbatim, and stated in the source for any $R\in\mathrm{Sym}^2(\Lambda^2V)$), [fence-posts.md](../findings/fence-posts.md) (F25 and F10 both present) and [target.md](../findings/target.md), all land.

**But the block names no script**, while carrying at least ten numerical claims: the two sharpening ranges, the four random-point maxima, the saturation over $k=3,\dots,10$, the $0.0000$ slack at three dimensions, the $+3.8$ to $+4.7$ random slack, the four ratios at unbalanced products, the $17$–$33\%$ LP gain and the $4\times10^{-15}$ cancellation residual. Both source reports do name theirs ([scripts/reviewers/r109/](../scripts/reviewers/r109/), five files, and [r110_g_collapse.py](../scripts/reviewers/r110/r110_g_collapse.py)), and those files exist. **The block is the one place in the chain where the numbers become uncheckable**, and it is the place a successor will read.

**Hedges audited.** *"costs nothing"* (twice), true, and §4e upgrades it from a measurement to a theorem. *"to machine precision"*, conceals the two-line identity of §5a. *"exactly"* (five uses), the equality sense is right everywhere; the uniqueness sense in *"saturated exactly on $S^k\times S^k$"* is unproven and false at row level (§5b). *"Both reviewers state the limit unprompted"*, true, r109 §63 and r110 §86 both do.

## 12. What is owed, and whether it is reachable

| # | owed | reachable? |
|---|---|---|
| 1 | State the quantifier: the cap holds for every symmetric $W$ on $\Lambda^2\mathbb R^n$, no criticality, no Bianchi, no normalisation | **yes**, §2 |
| 2 | Prove *"outside $\{g\ge0,\sum g=4(n-1)\}$"* from $s^2\le2$ instead of asserting it | **yes**, §3, two lines |
| 3 | Correct [LEDGER.md:1320](../findings/LEDGER.md#L1320)'s $(\sigma_\gamma-\ell_\gamma)^2$ to $(\lambda^{\hat\gamma}_{\max}-\lambda^{\hat\gamma}_{\min})^2$ | **yes**, §4c, and it must be done before the sharpening is picked up, since the written form is not valid |
| 4 | Record the dimension theorem $\min(\dim E_{\max},\dim E_{\min})\ge(n-2)/2$ at saturation, and with it the *proof* that the sharpening is void at every tight point | **yes**, §4e, this is a new result and wants a number |
| 5 | Restate saturation as derived, on the $\mathfrak p$ rows of a two-eigenvalue graded $W$, with $S^k\times S^k$ as the instance | **yes**, §5 |
| 6 | Repair the forcing sentence with the $\dim E_{\min}$ factor | **yes**, §7 |
| 7 | Name the constraint set beside each ceiling, and withdraw the *stale* charge | **yes**, §8 |
| 8 | Re-file r109's $8$–$15\%$ under the $\Delta$-aware baseline | **yes**, §9 |
| 9 | Decide whether the sharpened cap moves the class ceiling | **no, blocked, one run.** §4f names it: the $n=6$ marginals-plus-$T\ge0$ LP solved with $C$ and with $C_\gamma$, reporting the optimiser's bottom multiplicity in each. Agreement establishes the block's "sharpens pointwise and stops there"; disagreement reopens the class at the third digit |
| 10 | Cite a script for the block's ten numerical claims | **yes**, the files exist and are named in the two source reports |

**Bottom line.** The lemma is right, its derivation is three lines from three recorded inputs, and it is stated with more hypotheses than it needs and less proof than it could carry. The excluded-index sharpening is real, is correctly diagnosed by [LEDGER.md](../findings/LEDGER.md) as biting at a simple extreme eigenvalue, is written there in a form that is not valid, and is provably void wherever the cap is tight, so the block's *"costs nothing at the maximiser"*, which it reports as four measurements, is a theorem. **Nothing found here reaches the inequality itself.**
