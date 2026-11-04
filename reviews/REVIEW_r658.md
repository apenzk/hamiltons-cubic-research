# REVIEW r658, Observation L53, the champion split

**Target:** the block headed "Observation L53, the champion split", [findings/bispectral.md:442](../findings/bispectral.md) (lines 442–459), together with the section its provenance note names, "Numerical, by ascent, so these are lower bounds on each direction's maximum, and the identifications are evidence rather than proof", [findings/bispectral.md:405](../findings/bispectral.md) (lines 403–440). Copies checked: [results.md:250](../results.md) and [results.md:720](../results.md), [findings/INDEX-results.md:68](../findings/INDEX-results.md), [report/sections/06b-bispectral.tex:103](../report/sections/06b-bispectral.tex).

**Reviewer:** r658, cold, adversarial, on the **analysis-only** footing. The ascent was not re-run, not extended, and no direction was added. Every closed form below was derived by hand from the definitions before the block was read for its reasoning. One **screen** was run, a construction of the Fubini–Study curvature tensor at $m=2,3,4,5$ to check the hand-derived $\mathbb{CP}^m$ spectra, reported as a screen in §3 and used for nothing else; the positive claims stand on the hand derivation and on three independent agreements with material already on the record.

**VERDICT: GAP.** The three tabulated landings are right, and **every entry of the table is now a closed form** rather than a measurement, row 1 at all four dimensions from the record's own balanced-product formulas, rows 2 and 3 from two $\mathbb{CP}^m$ formulas derived here, the $n=8$ figure reproducing to all six printed digits. But the block over-claims a superlative it cannot reach, its $n=6$ entry names an object by a constant that at that one dimension belongs to a *different* object, its $n=10$ entry is missing though the column header promises it, its maximisation carries no norm constraint, and its provenance line is **half-false**. One sentence in the section it names as its argument is **refuted** outright, and one is the landing-as-optimum inversion the brief warns of.

---

## 0. Readings adopted, and the symbols the record does not define

| symbol | reading I adopt | where it is fixed |
| --- | --- | --- |
| $\mu$ | the $\Lambda^2$ spectrum, $\mathop{\mathrm{spec}}(M)$ at $\lVert M\rVert_F=1$, $\sum\mu=0$, $\sum\mu^2=1$ | [conventions.md](../findings/conventions.md), "Norms and pairings" |
| $\omega$ | $\mathop{\mathrm{spec}}(\mathring W)$ in Li's $iklj$ order, $\sum\omega=0$, $\sum\omega^2=3$ | [conventions.md](../findings/conventions.md), same bullet, and "The second-kind operator" |
| pairing | $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal | [conventions.md](../findings/conventions.md), "Norms and pairings" |
| $\theta_0(n)$ | the closed form $\sqrt{2(n-1)(n-2)}/n$, equal to the balanced-product value at **even** $n$ | [conventions.md](../findings/conventions.md), the objects table |

Three flags, one of them material.

- **$p_3$ is defined nowhere on the record.** [conventions.md](../findings/conventions.md) tables $\mu$ and $\omega$ and never says what $p_3$ is. The record fixes it only in passing, at [findings/bispectral.md:417](../findings/bispectral.md), by noting that $p_3(\mu)$ at the balanced product "is $\mathop{\mathrm{tr}}(W^3)$", so $p_3$ is the **power sum** $\sum_ix_i^3$, not the elementary symmetric $e_3$. The distinction is not cosmetic: under the $e_3$ reading the bi-spectral identity of [Lemma L50](../findings/bispectral.md) is false, and every number in L53's table is a different number. It belongs in the objects table.
- **$\mu$ carries a second sense in this very file and a third in [target.md](../findings/target.md)** (the scalar $-\min\omega$) which [conventions.md](../findings/conventions.md) already flags. L53 needs the spectrum sense, since $p_3$ of a scalar is meaningless; the block never says so. (For the record, the two senses are related on the $\mathbb{CP}^m$ family by $-p_3(\omega)=\tfrac3m\,\mu_{\text{scalar}}$, derived in §3, which is why they collide numerically at $m=3$.)
- **No normalisation is stated in the block.** L53 maximises "over $\Weyl_n$". The objective $a\,p_3(\mu)+b\,p_3(\omega)$ is homogeneous of degree $3$, so over $\mathcal W_n$ itself the supremum is $+\infty$ and the statement is vacuous as printed. The constraint is the unit sphere $\lVert M\rVert_F=1$; [results.md:722](../results.md) says so, the findings block does not. Given the live cross-file normalisation trap that [conventions.md](../findings/conventions.md) records for exactly these two symbols, post F33 works at $\lvert W\rvert_4=1$ where $p_2(\omega)=\tfrac34$, this file at $\lVert M\rVert_F=1$ where $p_2(\omega)=3$, the omission is the one that costs cycles.

**Parity, said rather than assumed:** $n=6,8,10$ and the $n=12$ mentioned in row 1 are all **even**, so $\Theta_n=\theta_0(n)$ at all four and the odd-$n$ gap $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))$ never enters. Row 1's use of $\theta_0(n)$ as "the value at the balanced sphere product" is legitimate at exactly these dimensions and would be false at odd $n$. The block does not say this; it should, since it is one line and the refuted [L0](../findings/problem.md) constant regrew from the same gloss.

---

## 1. Clause by clause: derivable, observed, or asserted beyond the evidence

I take the block's sentences plus the three sentences of the named section that carry its meaning.

| clause | status |
| --- | --- |
| "Ascent in a direction $(a,b)$, maximizing $a\,p_3(\mu)+b\,p_3(\omega)$ over $\Weyl_n$ from six starts each" | **vacuous as printed**, no norm constraint (§0). Repaired by "over the unit sphere of $\mathcal W_n$", it is an accurate description of [run_bispectral_region.py](../scripts/runs/run_bispectral_region.py) |
| row 1: $(0,-1)$ lands on the balanced sphere product at $n=6,8,10$ and at $n=12$ | **observed**, and its coordinates are **derivable**, §2 gives them in closed form and they reproduce the $n=12$ figures to all six digits |
| row 1's column head, "what it maximizes: the second-kind cubic alone" | **wrong sign.** $(0,-1)$ maximises $-p_3(\omega)$, i.e. *minimises* the second-kind cubic. The markdown twin at [findings/bispectral.md:411](../findings/bispectral.md) carries the expression "$-p_3(\omega)$" and L53's paste drops it |
| row 2: $(\tfrac32,-\tfrac12)$ lands on $W_{\mathbb{CP}^2}$ at $\thstar=1.224745$ | **derivable**: $\sqrt{3/2}$ is the $m=2$ member of $\theta^2(\mathbb{CP}^m)=\frac{(m+1)(2m-1)}{3m(m-1)}$, and by [conventions.md](../findings/conventions.md) it is $M(n)$ itself at $n=4,6$. At $n=8,10$ it is a lower bound that the record's own crossover $n=6+2\sqrt7=11.2915$ says is not beaten by the balanced product |
| row 3, $n=6$: "$\theta_0(6)$" | **mislabelled**, see §4. The landing is $\mathbb{CP}^3$, whose $\theta$ coincides with $\theta_0(6)$ at $m=3$ alone |
| row 3, $n=8$: "$\mathbb{CP}^4$'s $0.986013$" | **derivable and confirmed to six digits** by the closed forms of §3 |
| row 3, $n=10$ | **missing**, though the column header reads "$n=6,8,10$". §4 supplies the predicted entry |
| the title, "the champion split" | **asserted beyond the evidence** as a superlative (§5), though the split itself is **derivable at $n=6$** by an argument the record does not make (§6) |
| section, [findings/bispectral.md:417](../findings/bispectral.md): "At $n=6,8,10$ **the maximiser** of the second-kind cubic alone **is** the balanced sphere product" | **the inversion.** A landing point stated as the maximiser, three lines under a heading that says these are lower bounds |
| section, [findings/bispectral.md:421](../findings/bispectral.md): "$W_{\mathbb{CP}^2}$ wins the $\Lambda^2$ cubic" | **REFUTED** under the reading the sentence invites; true only if silently restricted to the two competitors (§5) |
| section, [findings/bispectral.md:440](../findings/bispectral.md): "this is consistent with Conjecture A rather than evidence for it … which is the only thing ascent can say" | **correct, and the best sentence in the section.** It is also not in the numbered block |

The direction of use is right in the section's headings and wrong in its sentences. The numbered block inherits the sentences and **carries none of the headings' caution**: the report keeps a "Label caution" paragraph immediately after the `Obs` environment ([report/sections/06b-bispectral.tex:118](../report/sections/06b-bispectral.tex)), and the paste into [findings/](../findings/) dropped it. A reader of the block alone cannot tell that ascent bounds from below.

---

## 2. The balanced-product row, in closed form

These are on the record already at [findings/bispectral.md:185](../findings/bispectral.md); I re-derived them and they are right. At $S^m\times S^m$, $n=2m$, $m\ge2$:

$$p_3(\mu)=\frac1{m\sqrt{(m-1)(2m-1)}},\qquad p_3(\omega)=-\frac{4m^2-6m-1}{m\sqrt{(m-1)(2m-1)}},\qquad \theta=\theta_0(2m)=\frac{\sqrt{(m-1)(2m-1)}}{m}.$$

The identity $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\theta_0(2m)$ closes by hand with no radical manipulation: the numerator over the common denominator is $\tfrac12\big(3+4m^2-6m-1\big)=(2m-1)(m-1)$, and $\theta_0(2m)=\sqrt{(m-1)(2m-1)}/m$ follows at once. The objective maximised in row 1 is therefore

$$-p_3(\omega)\big|_{S^m\times S^m}=\frac{2\sqrt2\,\big[(n-1)(n-2)-3\big]}{n\sqrt{(n-1)(n-2)}},\qquad n=2m,$$

which is $1.791958$, $2.127634$, $2.300000$, $2.404646$ at $n=6,8,10,12$, the last reproducing the block's $n=12$ table entry $-2.404646$ exactly. **Every figure in the $n=12$ table is a closed form**: $p_3(\mu)=2\sqrt2/(12\sqrt{110})=0.022473$, $p_3(\omega)=3p_3(\mu)-2\theta_0(12)=-2.404646$, $\theta=\sqrt{220}/12=1.236033$. They are checks, not measurements.

---

## 3. The $\mathbb{CP}^m$ row, in closed form, new to the record

Row 3 names $\mathbb{CP}^4$ by a single scalar, $\theta=0.986013$. A one-coordinate match is weak identification in a two-coordinate plane, and the named script prints no $\mathbb{CP}^m$ reference point at all, [run_bispectral_region.py](../scripts/runs/run_bispectral_region.py) constructs only the balanced sphere product for comparison. So the $\mathbb{CP}^m$ identifications in row 3 come from outside the run that is cited for them. The following closes that gap.

**The $\Lambda^2$ Weyl spectrum of $\mathbb{CP}^m$.** The curvature operator is $U(m)$-equivariant with three blocks, $\mathbb R\hat J$, $\mathfrak{su}(m)$, and the $J$-anti-invariant complement of dimension $m^2-m$, and two sectional curvatures fix it. With holomorphic sectional curvature $4$: a holomorphic plane $e_1\wedge Je_1$ lies wholly in $\mathfrak u(m)$ with $\hat J$-component $1/\sqrt m$, giving $4=\alpha/m+\beta(1-1/m)$; a totally real plane splits $\tfrac12/\tfrac12$ between $\mathfrak{su}(m)$ and the complement, giving $1=\beta/2$. Hence $\beta=2$, $\alpha=2m+2$, and the complement carries $0$, the symmetric-space kernel, of the right dimension. Subtracting the Einstein part $\frac{s}{n(n-1)}=\frac{2(m+1)}{2m-1}$ leaves the Weyl operator on $\Lambda^2\mathbb R^{2m}$:

| eigenvalue of $M$ | multiplicity |
| --- | --- |
| $\dfrac{4(m^2-1)}{2m-1}$ | $1$ |
| $\dfrac{2(m-2)}{2m-1}$ | $m^2-1$ |
| $-\dfrac{2(m+1)}{2m-1}$ | $m^2-m$ |

The trace vanishes identically in $m$, and at $m=2$ the spectrum is $(4,0,0,0,-2,-2)$, which, normalised, is exactly the record's own $W_{\mathbb{CP}^2}=\mathop{\mathrm{diag}}(0,0,0,-1,-1,2)/\sqrt6$ at [report/sections/03-setup.tex:23](../report/sections/03-setup.tex). Summing gives $\sum\mu^2_{\text{raw}}=\frac{12m(m^2-1)}{2m-1}$ and $\sum\mu^3_{\text{raw}}=\frac{8m(m^2-1)(4m^2+2m-11)}{(2m-1)^2}$, so

$$\boxed{\;p_3(\mu)\big|_{\mathbb{CP}^m}=\frac{4m^2+2m-11}{3\sqrt{3m(m^2-1)(2m-1)}}\;}$$

**And the second-kind coordinate follows from material already on the record.** [findings/target.md:130](../findings/target.md) derives $\mathring W$ on $\mathbb{CP}^m$ with top $6(m-1)/(2m-1)$ at multiplicity $m(m+1)$ and bottom $-6m/(2m-1)$ at multiplicity $m^2-1$. Its Frobenius square is $\frac{36m(m^2-1)}{2m-1}$, exactly **three times** my $\sum\mu^2_{\text{raw}}$, the identity $\lVert\mathring W\rVert_F^2=3\lVert M\rVert^2$ holding on the nose, which is an independent check on the table above. Carrying the same normalisation through the cube:

$$\boxed{\;p_3(\omega)\big|_{\mathbb{CP}^m}=-\frac{9}{\sqrt{3m(m^2-1)(2m-1)}}\;}$$

**These two close the bi-spectral identity symbolically in $m$ on a second family.** The record has only ever verified [Lemma L50](../findings/bispectral.md) symbolically at the sphere products; here

$$\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\frac{4m^2+2m-2}{2\sqrt{3m(m^2-1)(2m-1)}}=\frac{(2m-1)(m+1)}{\sqrt{3m(m-1)(m+1)(2m-1)}}=\sqrt{\frac{(m+1)(2m-1)}{3m(m-1)}}=\theta(\mathbb{CP}^m),$$

recovering the record's $\theta$ closed form with no radical left over. A fourth agreement: my formulas give $-\min\omega=3m/\sqrt{3m(m^2-1)(2m-1)}$, which reproduces every entry of the $\mu$ row of [findings/target.md:127](../findings/target.md), $0.8164966$, $0.4743416$, $0.3380617$, $0.2635231$, to seven digits.

| $m$ | $n$ | $p_3(\mu)$ | $p_3(\omega)$ | $\theta$ |
| --- | --- | --- | --- | --- |
| $2$ | $4$ (padded) | $1/\sqrt6=0.4082483$ | $-\sqrt{3/2}=-1.2247449$ | $\sqrt{3/2}=1.2247449$ |
| $3$ | $6$ | $31/(18\sqrt{10})=0.5446145$ | $-9/\sqrt{360}=-0.4743416$ | $\sqrt{10}/3=1.0540926$ |
| $4$ | $8$ | $61/(3\sqrt{1260})=0.5728268$ | $-9/\sqrt{1260}=-0.2535463$ | $\sqrt{35}/6=\mathbf{0.9860133}$ |
| $5$ | $10$ | $99/(3\sqrt{3240})=0.5797509$ | $-9/\sqrt{3240}=-0.1581139$ | $3/\sqrt{10}=0.9486833$ |

The bolded entry is row 3's measured $0.986013$, reproduced to every digit printed. **Row 3's $n=8$ entry is now a check rather than evidence.**

*Screen, reported as a screen.* I built the Fubini–Study curvature tensor at $m=2,3,4,5$, projected out the Einstein part and took eigenvalues: the raw triples match the table above exactly and $p_3(\mu)$ matches the boxed formula to nine digits at all four. The screen carries an overall sign from my contraction order, which the record's own $\mathop{\mathrm{diag}}(0,0,0,-1,-1,2)/\sqrt6$ settles; it is confirmation of arithmetic, and the claims rest on the derivation and on the three record agreements above.

---

## 4. The $n=6$ entry names the wrong object's constant, and $n=10$ is missing

Row 3 at $n=6$ reads "$\theta_0(6)$". In row 1 and everywhere else in this file, $\theta_0(n)$ **is** the balanced sphere product's value. Read that way the entry is false by a factor of five: the $(1,0)$ ascent maximises $p_3(\mu)$, and

$$p_3(\mu)\big|_{S^3\times S^3}=0.1054093\qquad\text{against}\qquad p_3(\mu)\big|_{\mathbb{CP}^3}=0.5446145 .$$

A run of six starts reporting $0.105$ when $0.545$ sits on the same record would be a stall, not a landing. The entry is therefore $\mathbb{CP}^3$, reported by its $\theta$, and it happens that

$$\theta(\mathbb{CP}^m)=\theta_0(2m)\iff 3m(m-1)^2=m^2(m+1)\iff 2m^2-7m+3=0\iff m=3 ,$$

so $\theta(\mathbb{CP}^3)=\theta_0(6)=\sqrt{10}/3$ **exactly, at $m=3$ and nowhere else**. The record already carries the collision unremarked: $1.0540926$ appears as $\theta(\mathbb{CP}^3)$ at [findings/target.md:126](../findings/target.md) and as $\theta_0(6)$ at [findings/bispectral.md:417](../findings/bispectral.md).

**So the one entry in the table that names a constant instead of an object does so at the single dimension where that constant belongs to two objects, and the two are the row's competitors.** The repair is one line:

> $(1,0)$ | the $\Lambda^2$ cubic alone | $\mathbb{CP}^{n/2}$ at all three: $\mathbb{CP}^3$ at $n=6$, where $\theta(\mathbb{CP}^3)=\theta_0(6)$ by the accident $2m^2-7m+3=0$; $\mathbb{CP}^4$'s $0.986013$ at $n=8$; $\mathbb{CP}^5$'s $0.948683$ at $n=10$

The $n=10$ figure is a **prediction**, not a measurement: $\theta(\mathbb{CP}^5)=3/\sqrt{10}=0.9486833$ with $p_3(\mu)=0.5797509$. It is what the existing run already computed and did not report, and re-reading its output would settle it, a landing at $0.5798$ confirms the row and one at $0.0333$ (the balanced product's $p_3(\mu)$ at $n=10$) would mean the ascent stalls at $n=10$ where it does not at $n=6,8$. **I did not run it.**

---

## 5. "Champion", what it claims, and what one of its two instances costs

Stated precisely, the superlative claims that for the ray $u=(a,b)$ the landing point $X_u$ satisfies

$$\langle u,\Phi(X_u)\rangle=\max\{\langle u,\Phi(W)\rangle:\ W\in\mathcal W_n,\ \lVert W\rVert=1\},\qquad \Phi(W)=(p_3(\mu),p_3(\omega)),$$

over the whole unit sphere of $\mathcal W_n$, dimension $84$, $210$, $450$ at $n=6,8,10$. Six random starts of a projected-gradient ascent with backtracking give "$\ge$" and nothing else. The named script says so in its own docstring, *"Ascent gives a LOWER bound on the support function in each direction … It cannot confirm support. That is the intended use."*, and the prose built on it says "the maximiser … is".

**One instance of the superlative is outright false.** [findings/bispectral.md:421](../findings/bispectral.md) and [report/sections/06b-bispectral.tex:120](../report/sections/06b-bispectral.tex) both read "$W_{\mathbb{CP}^2}$ wins the $\Lambda^2$ cubic". Under the reading the heading invites (champion of the direction $(1,0)$), it is false at every dimension in the table, and **the table's own row 3 is the disproof**: $\mathbb{CP}^4$ beats it at $n=8$ ($0.5728$ against $0.4083$) and $\mathbb{CP}^3$ beats it at $n=6$ ($0.5446$ against $0.4083$). It is true only under the unstated restriction to the two named competitors, $W_{\mathbb{CP}^2}$ against the balanced product.

The mechanism is worth recording, because it is a fact about the family and not a slip: **within $\mathbb{CP}^m$ the $\theta$-ordering and the $p_3(\mu)$-ordering are different orderings.** $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ is strictly decreasing, so $m=2$ is the family's $\theta$-champion; but $p_3(\mu)=\frac{4m^2+2m-11}{3\sqrt{3m(m^2-1)(2m-1)}}$ is $0.4082$, $0.5446$, $0.5728$, $0.5798$, $0.5806$, $0.5795$ at $m=2,\dots,7$, rising to a maximum at $m=6$ and falling to $4/(3\sqrt6)=0.5443$, so $m=2$ is the family's $p_3(\mu)$ **minimum**. Transporting "the rival wins" from the $\theta$ direction to the $(1,0)$ direction is exactly the step that fails.

Triple-checked before reporting: the sentence's two readings, the two numbers at $n=6$ and $n=8$, and the report's identical wording.

---

## 6. What the ascent cannot give, and the one thing that is derivable

**The split at $n=6$ is a theorem, and the record does not have it.** Suppose one $W^\ast$ maximised both $(1,0)$ and $(0,-1)$ on the unit sphere of $\mathcal W_6$. Being a $(1,0)$-maximiser it beats the feasible $\mathbb{CP}^3$: $p_3(\mu)\ge 31/(18\sqrt{10})$. Being a $(0,-1)$-maximiser it beats the feasible $S^3\times S^3$: $-p_3(\omega)\ge 17/(3\sqrt{10})$. Then

$$\theta(W^\ast)=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)\ \ge\ \frac{31}{12\sqrt{10}}+\frac{34}{12\sqrt{10}}=\frac{13\sqrt{10}}{24}=1.712901\ >\ \sqrt{3/2}=M(6),$$

the last value being the record's own global maximum at $n=6$ ([conventions.md](../findings/conventions.md), the $M(n)$ row). Contradiction. **So the two extreme directions have disjoint argmax sets at $n=6$, the "champion split" as a statement about maximisers, from two lower bounds and one upper bound, with no ascent in it.**

The same computation gives $1.923$ at $n=8$ and $2.020$ at $n=10$ against the same $\sqrt{3/2}$, so the split holds there too **conditionally on $M(n)=\sqrt{3/2}$ below the crossover**, which [report/sections/06-shape.tex:55](../report/sections/06-shape.tex) asserts ("the padded point is therefore the global maximizer") but [conventions.md](../findings/conventions.md) certifies only at $n=4$ and $n=6$. Closing $n=8,10$ needs an upper bound on $M(n)$, and the bi-spectral relaxation is far too slack to supply one: dropping all coupling gives only $\theta\le3.74$ at $n=6$.

**The extreme directions, analysed.** Maximising $p_3(\mu)$ alone over spectra constrained by $\sum\mu=0,\sum\mu^2=1$ on $N=\binom n2$ entries gives $\max p_3=\frac{N-2}{\sqrt{N(N-1)}}$, at the spectrum with one large entry and $N-1$ equal ones, i.e. $M$ a rank-one perturbation of $\mathrm{Id}_{\Lambda^2}$, which is the constant-curvature operator and carries Ricci, so it is not realisable by a Weyl tensor. The direction's true maximum is therefore pinned strictly between the $\mathbb{CP}^{n/2}$ landing and that bound:

| $n$ | lower, $\mathbb{CP}^{n/2}$ | upper, free spectrum |
| --- | --- | --- |
| $6$ | $0.544615$ | $13/\sqrt{210}=0.897133$ |
| $8$ | $0.572827$ | $26/\sqrt{756}=0.945580$ |
| $10$ | $0.579751$ | $43/\sqrt{1980}=0.966363$ |

A factor of $1.65$ of unclosed room. Nothing in the block or its section says the $(1,0)$ maximum is unknown to within that factor.

**A fence post the record should carry.** Linear maximisation of $\langle u,\Phi(\cdot)\rangle$ can only ever reach **exposed points of $\overline{\mathop{\mathrm{conv}}}\,\mathcal R_n$**. A maximiser lying in the interior of the hull, or on a non-exposed face, is invisible to the sweep **at every direction and every density**. So no refinement of the direction list can turn this Observation into a classification, and the conjectured maximiser is reachable only because the record separately claims the line $\tfrac32x-\tfrac12y=\theta_0(12)$ supports $\mathcal R_{12}$ there, a claim ascent is structurally unable to confirm, as the script's docstring states and the section at [findings/bispectral.md:440](../findings/bispectral.md) correctly repeats.

---

## 7. The direction sweep, scale invariance, density, and the missing half-plane

**The objective is homogeneous in $(a,b)$, so only the ratio matters**, and [run_bispectral_region.py](../scripts/runs/run_bispectral_region.py) implements this, it divides $(a,b)$ by $\sqrt{a^2+b^2}$ before ascending. So $(\tfrac32,-\tfrac12)$ and $(3,-1)$ are the same problem, and the table's three rows are three **rays**, not three vectors. The block never says so; a reader may reasonably think the weights are calibrated.

**The section claims "six directions"; the table shows three.** The script's list is $(\tfrac32,-\tfrac12)$, $(0,-1)$, $(1,0)$, $(1,-1)$, $(2,-1)$, $(1,-2)$, at polar angles $0^\circ$, $-18.43^\circ$, $-26.57^\circ$, $-45^\circ$, $-63.43^\circ$, $-90^\circ$. **Half the sweep is unreported.** The three omitted rays are the interior ones, which are exactly where a champion between the tabulated ones would show up; the largest sampled gap is $26.57^\circ$, between $(1,-2)$ and $(0,-1)$.

**And the sweep covers one quadrant only.** No direction has $b>0$ or $a<0$; in particular $(0,+1)$ (maximising $p_3(\omega)$, which the brief asks after), is never run. The free-spectrum bound there is $3^{3/2}\frac{D-2}{\sqrt{D(D-1)}}$ with $D=\tfrac{(n-1)(n+2)}2$, giving $4.797$ at $n=6$; what point attains it is unknown to the record. This is a fence post and should be recorded as one rather than left implicit: **the region $\mathcal R_n$ has been probed on a quarter of the circle, at six rays, and reported at three.**

---

## 8. Provenance, half-false, and the same 69-character truncation as two other blocks

The note reads: *"Numbered here on 2026-08-31: the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block."*

| sub-claim | verdict | evidence |
| --- | --- | --- |
| "the result was numbered in report/" | **true** | [report/sections/06b-bispectral.tex:103](../report/sections/06b-bispectral.tex), `\begin{Obs}{53}[The champion split]` |
| "the mathematics has always been in this file" | **FALSE as history** | `git log -S "The two cubics have different champions"` gives `1f82f29f`, which added the section and its table to **findings/live-front.md**. [findings/bispectral.md](../findings/bispectral.md) did not exist then: `git show ea7c61c4 -- findings/bispectral.md` opens with `--- /dev/null`, the commit being "split the live front in three", which moved the material in |
| "but it carried no block" | **true** | the `#### Observation 53` heading first appears at `86621751` |

So the boilerplate is **half-false at birth**, in the same way the brief reports of one earlier copy: true in the weak sense that the argument already sat in this file when the number arrived, false in the sense it states. Fifteen copies survive; this is one more data point for retiring the sentence in favour of naming the file the mathematics was born in.

**The locator is truncated mid-word.** It quotes *"Numerical, by ascent, so these are lower bounds on each direction's m"* against the real heading, which ends *"…on each direction's maximum, and the identifications are evidence rather than proof"*. It resolves as a prefix, so a reader can still find the section, but it is not a quotation of anything. It is not unique: `grep -o 'is in this file under "[^"]*"' findings/*.md` shows three locators cut at the same length, this one and two more: [findings/ungraded-slack.md:294](../findings/ungraded-slack.md), which stops at "the subalgebra family, " against a heading ending "at every threshold" ([findings/ungraded-slack.md:152](../findings/ungraded-slack.md)), and [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), which stops mid-word at "closed modulo three nam". **A tool truncated them all; fixing them is one pass.**

---

## 9. Presentation, duplication, pointers

- **The block does not render.** Lines 446–459 are raw LaTeX inside a markdown file: `\begin{center}`, `\begin{tabular}{@{}p{0.13\linewidth}…}`, `\toprule`/`\midrule`/`\bottomrule` (booktabs), and the row separator `\\`. It is a verbatim paste of the report's `Obs` body.
- **Three report-only macros come with it and are defined nowhere in [findings/](../findings/):** `\Weyl`, `\CP`, `\thstar`. They also appear at [findings/sym3-blocks.md:198](../findings/sym3-blocks.md), [findings/sym3-stability.md:58](../findings/sym3-stability.md), [findings/target.md:636](../findings/target.md), [findings/ungraded-slack.md:261](../findings/ungraded-slack.md) and [findings/LEDGER.md:960](../findings/LEDGER.md), the leak is wider than the two blocks found earlier today.
- **Markdown bold survives inside the LaTeX**: row 1 carries `**balanced sphere product**` where the report has `\textbf{…}`. So the paste was half-converted, it will render as neither.
- **Columns and header agree** in count and order, three and three; the defects are in the entries (§1, §4), not the alignment. The header promises $n=6,8,10$ and row 1 delivers a fourth dimension, row 3 only two.
- **Duplication: the table appears twice in this file**, as markdown at [findings/bispectral.md:407](../findings/bispectral.md) and as LaTeX at [findings/bispectral.md:447](../findings/bispectral.md), thirty-five lines apart, **with drift**, the markdown twin carries the objective expressions ("$-p_3(\omega)$, the second-kind cubic alone") that the numbered copy drops, and the two spell "maximises"/"maximizes" differently. No other number carries this content; [results.md](../results.md) restates it twice under L53 alone, at lines 250 and 720, and the line-722 restatement adds a superlative the block does not have ("the balanced product is the champion of one spectrum's cubic").
- **Pointers resolve**, all of them: [report/](../report/), [run_bispectral_region.py](../scripts/runs/run_bispectral_region.py), [fence post F7](../findings/fence-posts.md) at line 166. The block itself carries **no links and no anchor**, where its neighbour [Lemma L54](../findings/bispectral.md) links its dependency by anchor.
- **Filing.** Reading a `##` as owning every `####` that follows it until the next `##` (the reading I use, and this file has exactly one `##`, at line 244), Observation L53 is filed **inside "Post F26, one-sided improvement on the second-kind cubic cannot close"**, which is not its subject and is a refuted-post heading. Under the other reading the block is orphaned instead. Either way the file needs a `##` before the champion-split material.
- **Index consistency is clean:** [findings/INDEX-results.md:68](../findings/INDEX-results.md) records "Gate 2: no verdict on the record", and [findings/LEDGER.md:49](../findings/LEDGER.md) names the champion split in the Reviewers 99/100 batch while recording verdicts for the other three items only. The two agree.

---

## 10. What to change

1. **Row 3, $n=6$: replace "$\theta_0(6)$" with "$\mathbb{CP}^3$", noting $\theta(\mathbb{CP}^3)=\theta_0(6)$ holds at $m=3$ alone** ($2m^2-7m+3=0$). This is the material fix.
2. **Add the $n=10$ entry** the header promises, or narrow the header. The predicted entry is $\mathbb{CP}^5$, $\theta=3/\sqrt{10}=0.948683$, $p_3(\mu)=0.579751$, settled by re-reading the existing run's output, which I did not do.
3. **Give the maximisation its constraint** ("over the unit sphere of $\mathcal W_n$, $\lVert M\rVert_F=1$"), without which the display is vacuous, and state the reading of $\mu$.
4. **Restore the sign in row 1's middle column**: $(0,-1)$ maximises $-p_3(\omega)$.
5. **Fold in the closed forms of §2 and §3.** Four of the six table cells then become checks. The $\mathbb{CP}^m$ pair is new to the record and confirms [Lemma L50](../findings/bispectral.md) symbolically in $m$ on a second family.
6. **Replace "the maximiser … is" at line 417 with "the ascent reaches"**, and either delete "$W_{\mathbb{CP}^2}$ wins the $\Lambda^2$ cubic" at line 421 or restrict it in writing to the two competitors, it is false as it stands, disproved by the block's own row 3.
7. **Record §6's $n=6$ split as a derivation**, and the two conditional dimensions with the upper bound they wait on.
8. **Record the two fence posts of §7**: only exposed points of $\overline{\mathop{\mathrm{conv}}}\,\mathcal R_n$ are reachable by any direction at any density; and the sweep covers one quadrant, six rays, three reported.
9. **Convert the LaTeX to a markdown table, drop `\Weyl`/`\CP`/`\thstar`, fix the truncated locator, and correct the provenance note** to say the mathematics was born in `findings/live-front.md` and moved here when the live front was split.

**Where I would look next.** Direction $(0,+1)$ has never been run, and it is the only extreme of the plane the record has no point for; and the $\mathbb{CP}^m$ closed forms of §3 now make the whole family a curve in the bi-spectral plane, which is a second exact sharpness locus for a candidate transfer inequality, the record currently imposes sharpness at the sphere products only.
