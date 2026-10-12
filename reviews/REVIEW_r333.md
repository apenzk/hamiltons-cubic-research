# Reviewer 333, T9's measure reformulation, the spectral condition, Lemma L70's relocation, and whether $\theta$ is a free objective

**Cold brief, definitions only.** Every derivation below is done by hand from (A), (B), (C) and the definition of $T_{abc}$. The two scripts in [scripts/reviewers/r333/](../scripts/reviewers/r333/) are exact-rational **screens** of claims derived first, run in seconds; neither is offered as evidence for a positive claim. Log: [agent_logs/r333-t9.log](../agent_logs/r333-t9.log).

| claim | verdict |
| --- | --- |
| **R4**, contracting (C) against $\lambda_a$ reproduces the cubic identity exactly | **CONFIRMED as algebra, REFUTED as an explanation.** The contraction is exact. But the conclusion drawn from it in [bounds.md](../findings/bounds.md) ("*that is the structural reason the relaxation returns the true $\theta$*"), is a non sequitur, and it is false in a checkable way: **the linear pinned system leaves $\theta$ free at six of [r331](REVIEW_r331.md)'s seven spectra.** What returns the true $\theta$ is $T\ge0$, exactly as r331 said in its own §4 |
| **R1**, the measure reformulation | **CONFIRMED.** Normalisation, the ordered-pair reading and the factor $2(n-2)$ are all right in each of the three rows; the symmetrisation in (B) uses only symmetry of $T$ in its last two slots, which total symmetry supplies |
| **R2** (the spectral necessary condition | **CONFIRMED, and NONVACUOUS), sharp, in fact.** It is strictly stronger than tracelessness for every $n\ge3$, and it is attained with **equality** at three of the seven catalogued spectra: both maximal tori and $\mathbb{CP}^3$ |
| **R3**, Lemma L70 is the (C)-feasibility condition at the $\lambda_{\min}$ row | **CONFIRMED.** The derivation is exact, it reproduces Lemma L70's boxed identity term for term, not merely its inequality, the division by $\lambda_{\min}<0$ is handled correctly, and the equality condition is the one already recorded |
| **R5**, the outcome asymmetry and the three-outcome taxonomy | **Asymmetry CONFIRMED. Taxonomy REFUTED AS STATED, it is not exhaustive**, and the missing cell is the one that would decide where the programme goes |

---

## 1. R4, the contraction is right and the conclusion drawn from it is wrong

### 1.1 The contraction, line by line. CONFIRMED

Take (C) at index $a$ and multiply by $\lambda_a$:

$$\lambda_a\sum_{b,c}\lambda_b\lambda_c T_{abc}\;=\;2\lambda_a^2(\theta-\lambda_a)\;=\;2\theta\lambda_a^2-2\lambda_a^3 .$$

Sum over $a$:

$$\sum_{a,b,c}\lambda_a\lambda_b\lambda_c T_{abc}\;=\;2\theta\sum_a\lambda_a^2-2\sum_a\lambda_a^3\;=\;2\theta\lVert W\rVert^2-2\operatorname{tr}W^3\;\overset{\lVert W\rVert=1}{=}\;2\theta-2\operatorname{tr}W^3 .$$

The record's cubic identity is $\theta=\operatorname{tr}W^3+\tfrac12\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}$, i.e. $\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}=2\theta-2\operatorname{tr}W^3$. **Identical.** Substituting one into the other returns $\theta=\theta$.

For completeness, the cubic identity itself is nothing but (C) contracted: $\langle W,W^\#\rangle=\sum_a\lambda_a\langle\varphi_a,W^\#\varphi_a\rangle=\tfrac12\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}$, and $P(W)=\operatorname{tr}W^3+\langle W,W^\#\rangle=\theta\lVert W\rVert^2$. So the record is right that the two are one relation, and right that the cubic identity is **not** an extra constraint on the pinned system. The unit-norm hypothesis is used and is present in the setting. **CONFIRMED.**

### 1.2 The inference from it is a non sequitur

The record continues: *"So at a fixed spectrum $\theta$ is not a free objective over the pinned system … That is the structural reason the relaxation returns the true $\theta$ at a catalogued spectrum, rather than a numerical coincidence at seven of them."*

$\theta$ being determined by $T$ is exactly the statement that $\theta$ is a **linear functional of the LP variables**, which is what an LP objective *is*. It says nothing about whether that functional is constant on the feasible set. r331 itself states the problem correctly at its own §3: *"$\theta$ … enters (C)'s right side linearly, so $\max\theta$ at fixed spectrum is one LP over $(T,\theta)$."* Contracting an equality system against a vector cannot collapse a polytope.

The precise structure at a fixed spectrum: $\{(T,\theta):T\ge0\ \text{symmetric, zero on repeated indices},\ \text{(A),(B),(C)}\}$ is a bounded polyhedron ((A) with $T\ge0$ bounds every entry), and $\theta$ is a linear functional on it. Maximising $\theta$ over it **is a well-posed linear programme.** The brief's worry that a determined $\theta$ makes "maximise $\theta$ at fixed spectrum" ill-posed is itself misplaced; the record should keep calling it an optimisation, and drop the sentence claiming the answer is forced.

### 1.3 And the claim is false, not merely unsupported, the linear rows leave $\theta$ free at six of the seven spectra

**Value-type aggregation, derived first.** Let $G$ be the group of index permutations preserving $\lambda$. $G$ permutes the rows $\{A_a,B_a,C_a\}$ among themselves (their coefficients depend on indices only through values), and acts trivially on $\theta$. So the nullspace of the $(T,\theta)$ system is $G$-invariant, and averaging any nullspace vector over $G$ preserves its $\theta$-component. A $G$-invariant symmetric $T$ is precisely a mass assignment $M_\tau$ to the $G$-orbits of index triples, and those orbits are exactly the **value types**, multisets $\tau$ of three eigenvalues, subject to the multiplicity caps. Hence:

> $\theta$ is pinned by the $3N$ index-level rows **iff** it is pinned by the $3d$ value-averaged rows.

Averaging the rows over each value class $x$ (with $n_x(\tau)$ the multiplicity of $x$ in $\tau$, $S_\tau$ the type's value sum, $P_{\tau,x}$ the product of the other two slots) gives

$$\text{(A)}_x:\ \sum_\tau n_x(\tau)M_\tau=(n-2)m_x,\qquad \text{(B)}_x:\ \sum_\tau n_x(\tau)(S_\tau-x)M_\tau=-2x\,m_x,$$
$$\text{(C)}_x:\ 2\sum_\tau n_x(\tau)P_{\tau,x}M_\tau=2x(\theta-x)m_x .$$

**Two dependencies, by hand, and both need $\operatorname{tr}W=0$.** Total symmetry of $T$ gives $\sum_{abc}\lambda_bT_{abc}=\sum_{abc}\lambda_aT_{abc}$, so $\sum_a B_a-\sum_a\lambda_aA_a$ reads $-2\sum\lambda_a=2(n-2)\sum\lambda_a$, vacuous at $\operatorname{tr}W=0$. Likewise $\sum_{abc}\lambda_a\lambda_bT_{abc}=\sum_{abc}\lambda_b\lambda_cT_{abc}$ makes $\sum_a\lambda_aB_a$ and $\sum_aC_a$ differ by $2\theta\sum\lambda_a$, vacuous again. So the expected rank is $3d-2$. *(Note that $\sum_a\lambda_aC_a$ is **not** a third dependency, it is the cubic identity of §1.1, a genuine equation. That is exactly why §1.1 buys nothing here.)*

**Screened, exact rationals** ([screen_typecount.py](../scripts/reviewers/r333/screen_typecount.py)), rank $=3d-2$ at every traceless spectrum, as derived:

| spectrum (r331's scaled $\lambda$; mults) | $d$ | types | rank | nullity | $\theta$ pinned by the **linear** rows? |
| --- | --- | --- | --- | --- | --- |
| torus $n=6$: $(4,-1)$; $(3,12)$ | 2 | 4 | 4 | 1 | **no** |
| torus $n=8$: $(6,-1)$; $(4,24)$ | 2 | 4 | 4 | 1 | **no** |
| $S^4\times S^4$: $(-3,4)$; $(16,12)$ | 2 | 4 | 4 | 1 | **no** |
| padded $W_{\mathbb{CP}^2}$: $(2,-1,0)$; $(1,2,12)$ | 3 | 6 | 7 | 0 | yes |
| $\mathbb{CP}^3$: $(-4,1,16)$; $(6,8,1)$ | 3 | 7 | 7 | 1 | **no** |
| $S^3\times S^5$: $(-4,3,10)$; $(15,10,3)$ | 3 | 10 | 7 | 4 | **no** |
| $S^5\times S^7$: $(-12,10,21)$; $(35,21,10)$ | 3 | 10 | 7 | 4 | **no** |
| generic $d=4$, $n=12$ | 4 | 20 | 10 | 11 | **no** |

Only padded $W_{\mathbb{CP}^2}$ is linearly pinned, and there for a reason that has nothing to do with the contraction: its top eigenvalue has multiplicity $1$, which deletes four types and drops the unknown count to $7$ against rank $7$.

**The mechanism, in full, at the maximal torus $n=6$** (screened exactly, [screen_torus_pin.py](../scripts/reviewers/r333/screen_torus_pin.py)). Types over $(\lambda_{\mathfrak h},\lambda_{\mathfrak m})=(4,-1)$, mults $(3,12)$. The true point is $(M_{\mathfrak{hhh}},M_{\mathfrak{hhm}},M_{\mathfrak{hmm}},M_{\mathfrak{mmm}};\theta)=(0,0,12,8;5)$, and the unique free direction of the linear rows is

$$\delta=(1,\,-3,\,3,\,-1;\ \tfrac{25}{4}),\qquad\text{so}\qquad \theta=5+\tfrac{25}{4}t .$$

$\theta$ moves along it at rate $25/4$. What stops it is that $M_{\mathfrak{hhh}}=t$ needs $t\ge0$ while $M_{\mathfrak{hhm}}=-3t$ needs $t\le0$. **$T\ge0$ alone forces $t=0$ and returns $\theta=5$.** The Lie-algebraic fact behind it ($\mathfrak h$ abelian, so both those types carry zero bracket mass), is *recovered* by positivity, never supplied to the LP.

### 1.4 What this means for the record and for T9

- The sentence at [bounds.md](../findings/bounds.md) beginning *"That is the structural reason…"* must be **withdrawn**, together with *"r331's screen is measuring a consistency condition, not a maximisation."* It is a maximisation, and the record already held the right explanation: r331 §4's *"positivity converts the three relations into the full type distribution."*
- **What is still free at a fixed spectrum**, precisely: $\theta$ is a linear functional of $T$; the free object is $T$ itself, ranging over a polytope of dimension $\binom I3-\operatorname{rank}$, with $\operatorname{rank}=3N-2$ at the index level. Its $G$-invariant shadow (the type masses, which is all $\theta$ sees), has nullity $\binom{d+2}{3}+1-(3d-2)$ before multiplicity caps: $1$ at $d=2$, $4$ at $d=3$, $11$ at $d=4$, $22$ at $d=5$.
- **That growth is the actionable consequence.** Every spectrum r331 screened has $d\le3$. The nullity positivity must close grows like $d^3/6$ against $3d$, so **exactness at $d\le3$ is no evidence at all for $d\ge4$**, and T9 should be run first at a $d\ge4$ spectrum. The record's current reading predicts exactness everywhere and therefore predicts nothing; the positivity reading predicts the grip weakens with $d$ and is falsifiable.

---

## 2. R1, the measure reformulation. CONFIRMED

**Normalisation.** (A) reads $\sum_{b,c}T_{abc}=2(n-2)$ with $b,c$ ranging over **ordered** pairs. So $\mu_a(b,c):=T_{abc}/2(n-2)$ is nonnegative with total mass $1$ on ordered pairs. Correct, and "ordered" is the right reading: on unordered pairs the same numbers give mass $\tfrac12\cdot 2(n-2)/(2(n-2))$ per pair only after halving, and every expectation below would then need the compensating factor. The record's convention is consistent throughout.

**(B).** Dividing $\sum_{b,c}\lambda_bT_{abc}=-2\lambda_a$ by $2(n-2)$ gives $\mathbb E_{\mu_a}[\lambda_b]=-\lambda_a/(n-2)$. The symmetrisation is legitimate: $T$ is totally symmetric, so in particular $T_{abc}=T_{acb}$, which is exactly the symmetry in the **last two slots** that the step uses, and it gives $\mathbb E_{\mu_a}[\lambda_b]=\mathbb E_{\mu_a}[\lambda_c]=\mathbb E_{\mu_a}[(\lambda_b+\lambda_c)/2]$. Nothing stronger than that one transposition is needed.

**(C).** Dividing $\sum_{b,c}\lambda_b\lambda_cT_{abc}=2\lambda_a(\theta-\lambda_a)$ by $2(n-2)$ gives $\mathbb E_{\mu_a}[\lambda_b\lambda_c]=\lambda_a(\theta-\lambda_a)/(n-2)$. Correct.

**One free sharpening the record leaves on the table.** $T$ vanishes on repeated indices, so $\mu_a$ is supported on pairs with $b\ne c$ and $b,c\ne a$. Every range argument below may therefore use $[\min_{b\ne a}\lambda_b,\max_{b\ne a}\lambda_b]$ rather than $[\lambda_{\min},\lambda_{\max}]$. This is strictly sharper whenever an extreme eigenvalue has multiplicity $1$ and $a$ is its index; it is inert at all seven catalogued spectra, so nothing on the record changes, but it should be stated where the reformulation is.

---

## 3. R2, the spectral condition. CONFIRMED, and it is sharp

**The deduction.** $\mathbb E_{\mu_a}[(\lambda_b+\lambda_c)/2]$ averages values in $[\lambda_{\min},\lambda_{\max}]$, so $\lambda_{\min}\le-\lambda_a/(n-2)\le\lambda_{\max}$ for every $a$. At $a=\arg\max$: $\lambda_{\min}\le-\lambda_{\max}/(n-2)$, i.e. $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$. At $a=\arg\min$: $-\lambda_{\min}/(n-2)\le\lambda_{\max}$, i.e. $\lvert\lambda_{\min}\rvert\le(n-2)\lambda_{\max}$. Both correct, and both free of $\theta$.

**Is it implied by tracelessness? No, and by a wide margin.** $\operatorname{tr}W=0$ gives $\lambda_{\max}\le\sum_{\lambda<0}\lvert\lambda\rvert\le(N-1)\lvert\lambda_{\min}\rvert$ with $N=\binom n2$, and that is the best tracelessness affords, the extremal configuration $\lambda=(c,-c/(N-1),\dots)$ attains it. That configuration violates the new condition whenever $N-1>n-2$, i.e. $(n-1)(n-2)>0$, **true for every $n\ge3$.** So the condition excludes a nonempty set of traceless unit spectra at every dimension, and it is stronger than tracelessness by a factor $\sim N/n\sim n/2$.

**Against the catalogue** (r331's scaled data; the two columns are $\lambda_{\max}$ vs $(n-2)\lvert\lambda_{\min}\rvert$ and $\lvert\lambda_{\min}\rvert$ vs $(n-2)\lambda_{\max}$):

| spectrum | $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$ | $\lvert\lambda_{\min}\rvert\le(n-2)\lambda_{\max}$ |
| --- | --- | --- |
| torus $n=6$: $(4,-1)$ | $4\le4$, **equality** | $1\le24$ |
| torus $n=8$: $(6,-1)$ | $6\le6$, **equality** | $1\le48$ |
| $\mathbb{CP}^3$, $n=6$: $(-4,1,16)$ | $16\le16$, **equality** | $4\le64$ |
| $S^4\times S^4$, $n=8$: $(-3,4)$ | $4\le18$ | $3\le24$ |
| padded $W_{\mathbb{CP}^2}$, $n=6$: $(2,-1,0)$ | $2\le4$ | $1\le8$ |
| $S^3\times S^5$, $n=8$: $(-4,3,10)$ | $10\le24$ | $4\le60$ |
| $S^5\times S^7$, $n=12$: $(-12,10,21)$ | $21\le120$ | $12\le210$ |

**It excludes none of the catalogued spectra (as it must, they are realizable) but it is SATURATED at three of them**, so the constant $n-2$ cannot be improved. This is the answer to the brief's question: the condition is worth something, and the reason is visible. Equality at $a=\arg\max$ means $\mu_{\max}$ sits entirely on pairs with $\lambda_b=\lambda_c=\lambda_{\min}$, i.e. **all of $\mathrm{ad}(v_{\max})$'s bracket mass lands in $E_{\min}\otimes E_{\min}$**. At the maximal torus that is the abelianness of $\mathfrak h$ verbatim, $[\mathfrak h,\mathfrak h]=0$ and $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ kill every other type. That the inequality reproduces $[\mathfrak h,\mathfrak h]=0$ as its own equality case is an independent confirmation that §2 and the derivation here are right.

**General check of the torus saturation, without numbers.** For $W=\Pi_{\mathfrak h}-\tfrac rNI$ with $\mathfrak h=\mathfrak{so}(2)^{m}$, $n=2m$, $r=m$, $N=m(2m-1)$: $\lambda_{\max}=1-r/N$, $\lvert\lambda_{\min}\rvert=r/N$, and $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert\iff N-m\le(2m-2)m\iff 2m^2-2m\le2m^2-2m$, **equality for every $m$.** By contrast the balanced product ($r=m(m-1)$) gives $N\le(2m-1)r\iff m\ge2$, slack and widening.

---

## 4. R3, Lemma L70 relocated. CONFIRMED, and the relocation is exact rather than approximate

Take (C) at an index $a$ with $\lambda_a=\lambda_{\min}$. With $\lambda_{\min}<0\le\lambda_{\max}$ (supplied by $\operatorname{tr}W=0$, the hypothesis the record already added), every product satisfies $\lambda_b\lambda_c\ge\lambda_{\min}\lambda_{\max}$: if $\lambda_b,\lambda_c$ share a sign the product is $\ge0\ge\lambda_{\min}\lambda_{\max}$; if they differ, $\lvert\lambda_b\lambda_c\rvert\le\lvert\lambda_{\min}\rvert\lambda_{\max}$ and the product is negative, so again $\ge\lambda_{\min}\lambda_{\max}$. Hence

$$\frac{\lambda_{\min}(\theta-\lambda_{\min})}{n-2}=\mathbb E_{\mu_a}[\lambda_b\lambda_c]\;\ge\;\lambda_{\min}\lambda_{\max}.$$

Divide by $\lambda_{\min}<0$, **the inequality reverses**, and this is the one step worth watching:

$$\frac{\theta-\lambda_{\min}}{n-2}\le\lambda_{\max}\qquad\Longrightarrow\qquad \theta\le\lambda_{\min}+(n-2)\lambda_{\max}. $$

That is Lemma L70. **The relocation is exact, not merely an inequality that happens to agree.** Keeping the difference rather than bounding it,

$$D(v)=\tfrac12\sum_{b,c}\big(\lambda_b\lambda_c-\lambda_{\min}\lambda_{\max}\big)T_{vbc} \;\overset{\text{(C)}}{=}\;\lambda_{\min}(\theta-\lambda_{\min})\;\overset{\text{(A)}}{-}\;(n-2)\lambda_{\min}\lambda_{\max} \;=\;\lvert\lambda_{\min}\rvert\big[\lambda_{\min}+(n-2)\lambda_{\max}-\theta\big],$$

which rearranges to Lemma L70's boxed identity $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert$ term for term. So **Lemma L70 is exactly (A) and (C) at the $\lambda_{\min}$ row plus the termwise product bound**, and the record's relocation is right.

**Equality condition.** Equality holds iff $\mu_a$-almost every pair has $\lambda_b\lambda_c=\lambda_{\min}\lambda_{\max}$, i.e. all $2(n-2)$ units of $\mathrm{ad}(v)$'s mass sit on pairs with one index in $E_{\min}$ and one in $E_{\max}$. **That is verbatim the condition already recorded** ("$\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$"). Matched.

**One caveat on what the relocation buys.** "Explains its exactness at balanced products and its slack at $\mathbb{CP}^3$" is a restatement, not an explanation: the slack *is* $D(v)/\lvert\lambda_{\min}\rvert$ by the identity, so saying the slack is off-extreme-pair mass says the same thing twice. The genuine content of the relocation is different and worth stating as such: **Lemma L70 uses one row of (A) and one row of (C) and discards (B) entirely and $2(N-1)$ other rows**, which is precisely why the full system is stronger. Also note the derivation is per-basis-index, whereas Lemma L70 is stated per unit $v\in E_{\min}$; the two agree because $W^\#=\theta W-W^2$ makes $\langle v,W^\#v\rangle$ eigenspace-constant, as the record establishes separately.

---

## 5. R5, the asymmetry is right, the taxonomy is not exhaustive

**The asymmetry. CONFIRMED.** (A), (B), (C) with $T\ge0$ are necessary conditions on every $\theta$-critical unit $W\in\mathcal W_n$, so:

- *Infeasibility is conclusive.* If no $(\lambda,T)$ with $\operatorname{tr}=0$, $\lVert\lambda\rVert=1$, $T\ge0$ satisfies the rows with $\theta>\theta_0(n)$, then no critical point has $\theta>\theta_0(n)$. Combined with the standard fact that on the compact unit sphere $\nabla P=3Q(W)$, so a constrained critical point has $Q(W)=\theta W$ and $P(W)=\theta$ there, this gives $\max_{\lVert W\rVert=1}P\le\theta_0(n)$, attained at the balanced product. The conjecture closes. The domain is legitimate and compact: $\operatorname{tr}W=0$ holds on $\mathcal W_n$ by Ricci-flatness.
- *Feasibility is not conclusive.* A feasible $(\lambda,T)$ needs two further things the pinned system never sees: $\lambda$ must be some Weyl tensor's spectrum, and $T$ must be realizable as $\langle[v_a,v_b],v_c\rangle^2$ in that tensor's eigenbasis. Both are open. Right as recorded.

**The taxonomy. REFUTED AS STATED.** The record's three cells are (i) infeasible above $\theta_0$ everywhere (closed; (ii) feasible above $\theta_0$ only at demonstrably non-realizable spectra), redirect; (iii) feasible above $\theta_0$ at a spectrum nobody can rule out, no information. Three defects:

- **The missing cell.** *(iv) feasible above $\theta_0$ at a spectrum that is demonstrably realizable* is not "no information" and is not (ii). It refutes nothing about Conjecture A ($T$-realizability at that spectrum is still open) but it **kills the redirect**: if a realizable spectrum admits a pinned-feasible $T$ above $\theta_0$, then spectral realizability cannot be the missing ingredient, and the missing ingredient is bracket-realizability of $T$ at a fixed spectrum, a different programme. Cell (iv) is the single most informative outcome the run can return, and the taxonomy as written would file it under "no information".
- **(ii) is not operational.** It requires a test for non-realizability of a *spectrum*, and the record carries none. What it carries is distance-from-$\mathcal W_n$ for specific operators (the $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, $\mathfrak u(4)$ rows in the Lemma L70 table), which does not lift to a statement about a spectrum. So the redirect outcome cannot currently be distinguished from (iii), the very failure mode the record warns about two sentences later.
- **(i) needs global optimality it may not get.** The outer problem is bilinear ($\lambda$ enters the constraint coefficients), so a run returns a *lower* bound on the ceiling. That is enough for (ii)/(iii)/(iv) and never enough for (i). Delivering (i) needs either a convex relaxation of the outer problem or an analytic argument; **R2's condition is exactly the kind of ingredient such an argument would use**, and it is the first the record has.

**Repaired taxonomy, four cells:** (i) certified infeasible above $\theta_0$ over the whole spectral domain (closed; (ii) feasible above $\theta_0$, every witness spectrum shown non-realizable), realizability is the content, redirect; (iii) feasible above $\theta_0$, witness spectrum shown realizable, the redirect is dead and the content is $T$-realizability at fixed spectrum; (iv) feasible above $\theta_0$, realizability of the witness spectrum unknown, no information, and the run must be able to say it is in this cell rather than (ii) or (iii).

---

## 6. What the record should change

1. **[bounds.md](../findings/bounds.md), "What the pinned relaxation can and cannot decide":** keep the contraction (it is correct and it does establish that the cubic identity adds nothing to (C)). **Withdraw** *"That is the structural reason the relaxation returns the true $\theta$"* and *"measuring a consistency condition, not a maximisation."* Replace with the positivity mechanism and the torus worked example of §1.3, and with the nullity table, the linear rows leave $\theta$ free at six of seven catalogued spectra.
2. **Add the rank law** $\operatorname{rank}=3d-2$ for the value-averaged pinned system, with its two hand-derived dependencies, and the nullity $\binom{d+2}{3}+1-(3d-2)$. It is what makes r331's seven-for-seven interpretable, and it says the evidence is confined to $d\le3$.
3. **[plan.md](../plan.md) T9:** the first run should be at a $d\ge4$ spectrum, where the positivity reading and the withdrawn structural reading make opposite predictions. Add cell (iii) of §5 to the outcome list, and record that outcome (i) requires a certified global bound over the spectral domain, not a solver's best point.
4. **R2's condition deserves a number.** It is purely spectral, $\theta$-free, strictly stronger than tracelessness at every $n\ge3$, saturated at both maximal tori and at $\mathbb{CP}^3$, and its equality case reads off as $[\mathfrak h,\mathfrak h]=0$ at the torus. Record the support-restricted sharpening of §2 alongside it.
5. **Lemma L70:** record that it spends one row of (A) and one row of (C) and drops (B) and $2(N-1)$ rows, that, rather than the tautological slack identity, is why the full system beats it by $2.1$ at $\mathbb{CP}^3$.

**Scripts (screens only):** [screen_typecount.py](../scripts/reviewers/r333/screen_typecount.py) (value-type rank and $\theta$-pinning, exact rationals), [screen_torus_pin.py](../scripts/reviewers/r333/screen_torus_pin.py) (the torus free direction and the positivity pin, exact rationals). Log: [agent_logs/r333-t9.log](../agent_logs/r333-t9.log).
