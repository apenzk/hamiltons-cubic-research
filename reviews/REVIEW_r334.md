# Reviewer 334, T9, the measure reformulation, and whether $\theta$ is a free objective

**Cold brief, worked from the definitions.** Every derivation below is done by hand from $Q(W)=W^2+W^\#$, $\theta$-criticality and $T_{abc}=\langle[v_a,v_b],v_c\rangle^2$. Four screens appear, all seconds of compute, all labelled; each screens a claim already derived, and the build is validated by reproducing three of [r331](REVIEW_r331.md)'s independently-built numbers exactly (scaled $\theta=5$ at the $n=6$ torus, $3$ at padded $W_{\mathbb{CP}^2}$, $20$ at $\mathbb{CP}^3$). Scripts in [scripts/reviewers/r334/](../scripts/reviewers/r334/), log at [agent_logs/r334-t9.log](../agent_logs/r334-t9.log).

| claim | verdict |
| --- | --- |
| **R4**, contracting (C) against $\lambda_a$ reproduces the cubic identity exactly | **CONFIRMED as algebra**, the two are the same equation, line by line, and the reason is structural: (C) *is* the diagonal of $W^\#=\theta W-W^2$ and the cubic identity is its $\lambda$-weighted trace |
| **R4**, "so $\theta$ is not a free objective; the screen measures a consistency condition, not a maximisation" | **REFUTED**, $\theta$ is an *affine function* of $T$, which is not the same as constant on the feasible set. At the balanced $S^3\times S^3$ spectrum the full $(A)+(B)+(C)+T\ge0$ system admits $\theta\in[5/3,10]$ scaled, i.e. $[0.17568,\,1.054093]$, a genuine interval of length $0.878$, with the maximum sitting exactly at $\theta_0(6)$. The screen at that spectrum is a maximisation, and a tight one; the record's explanation of r331's seven-for-seven is a non sequitur, and the *record's own printed number* $0.176$ is the same interval's lower end |
| **R1** (the measure reformulation | **CONFIRMED**), normalisation, ordered-vs-unordered, the factor $2(n-2)$ and the symmetrisation step are all correct as written |
| **R2**, $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$ and $\lvert\lambda_{\min}\rvert\le(n-2)\lambda_{\max}$ | **CONFIRMED and NONVACUOUS**, not implied by tracelessness, and **saturated exactly** at $\mathbb{CP}^m$ for *every* $m$ and at *every* maximal torus (proved, then screened). In the two-eigenvalue family it is exactly the pinned system's feasibility boundary at $n=6$ |
| **R3**, Lemma L70 is (C)'s condition at the $\lambda_{\min}$ row | **CONFIRMED as a derivation, REFUTED AS STATED as a description**, the sign handling and the equality case are right and the equality case matches the recorded one; but this is *a* necessary condition from (C)'s range at that row, not "the feasibility condition", which is a two-moment problem and is strictly stronger, and which also carries a lower bound on $\theta$ the record drops |
| **R5**, outcome asymmetry, and the three-outcome taxonomy | **Asymmetry CONFIRMED. Taxonomy REFUTED AS STATED, not exhaustive**: it omits *feasible above $\theta_0$ at a **realizable** spectrum*, which is strictly more informative than (iii) and which **already happens at $n=6$** (padded $W_{\mathbb{CP}^2}$: the pinned max equals the true $\theta=\sqrt{3/2}>\theta_0(6)$). That outcome refutes T9's own redirect hypothesis, and its existence means outcome (i) is unreachable at $n<12$, a design constraint the taxonomy does not mention |

**The one-line summary.** The contraction is right and the conclusion drawn from it is wrong: $\theta$ being determined *by $T$* does not make it determined *by $\lambda$*, and at the one spectrum the conjecture is about it demonstrably is not, so T9 is a well-posed maximisation after all, r331's exactness is a real result rather than a tautology, and the record should reverse the sentence rather than delete the screen.

---

## 0. Conventions, fixed once

$W\in\mathcal W_n$ of unit norm acts on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=n(n-1)/2$, with orthonormal eigenbasis $v_1,\dots,v_N$ and eigenvalues $\lambda_1,\dots,\lambda_N$; $c_{abc}=\langle[v_a,v_b],v_c\rangle$ and $T_{abc}=c_{abc}^2$. The inner product is ad-invariant, so $c_{abc}$ is **totally antisymmetric**; hence $T$ is totally symmetric *and* vanishes whenever two indices coincide. Tracelessness $\sum_a\lambda_a=0$ with $W\ne0$ gives $\lambda_{\min}<0<\lambda_{\max}$. All sums $\sum_{b,c}$ are over **ordered** pairs.

Two facts used repeatedly, both derived rather than quoted:

$$\langle v_a,W^\#v_a\rangle=-\tfrac12\operatorname{tr}\big(\mathrm{ad}(v_a)W\,\mathrm{ad}(v_a)W\big)=\tfrac12\sum_{b,c}\lambda_b\lambda_c\,T_{abc},$$

since $(\mathrm{ad}\,v_a)_{cb}=c_{abc}$ is antisymmetric in $(b,c)$, so $\operatorname{tr}(AWAW)=\sum_{b,c}\lambda_b\lambda_cA_{bc}A_{cb}=-\sum_{b,c}\lambda_b\lambda_cT_{abc}$; and

$$\sum_{b,c}T_{abc}=\sum_b\lVert[v_a,v_b]\rVert^2=\lVert\mathrm{ad}(v_a)\rVert_{\mathrm{HS}}^2=-B(v_a,v_a)=2(n-2),$$

$B$ the Killing form of $\mathfrak{so}(n)$, $B(X,Y)=(n-2)\operatorname{tr}(XY)$, with $\operatorname{tr}(v_a^2)=-2$ in this normalisation. Scaled spectra below are integer multiples of the true ones; (A) is scale-free, (B) is degree-$1$ homogeneous in $\lambda$ and (C) degree-$2$ with $\theta$ carrying $\lambda$'s weight, so every relation is preserved and exactness stays visible.

---

## 1. R4, the contraction, and what it does and does not imply

### 1.1 The contraction. CONFIRMED, and it is an identity rather than a coincidence

Take (C) at index $a$, multiply by $\lambda_a$, sum over $a$:

$$\sum_{a,b,c}\lambda_a\lambda_b\lambda_c\,T_{abc}=\sum_a\lambda_a\cdot2\lambda_a(\theta-\lambda_a)=2\theta\sum_a\lambda_a^2-2\sum_a\lambda_a^3=2\theta\lVert W\rVert^2-2\operatorname{tr}W^3=2\theta-2\operatorname{tr}W^3$$

at unit norm. The record's cubic identity, $\theta=\operatorname{tr}W^3+\tfrac12\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}$, rearranges to $\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}=2\theta-2\operatorname{tr}W^3$. **Identical.** The record's claim of exactness is right, with no slack and no hidden hypothesis beyond $\lVert W\rVert=1$.

And the reason is worth stating, because it makes the "why" immediate. (C) at index $a$ is exactly $\langle v_a,W^\#v_a\rangle=\lambda_a(\theta-\lambda_a)$ (the $a$-th diagonal entry of $W^\#=\theta W-W^2$), via the first display of §0. The cubic identity is $\theta=\langle W,Q(W)\rangle=\langle W,W^2\rangle+\langle W,W^\#\rangle=\operatorname{tr}W^3+\sum_a\lambda_a\langle v_a,W^\#v_a\rangle$. So the cubic identity is literally $\sum_a\lambda_a\times$(C)$_a$. The contraction cannot fail to reproduce it; it is a $\lambda$-weighted trace of the same $N$ scalar equations.

### 1.2 The inference. REFUTED

The record writes: *"So at a fixed spectrum $\theta$ is not a free objective over the pinned system … [r331]'s screen is measuring a consistency condition, not a maximisation."* This does not follow, and it is false.

What §1.1 establishes is that on the feasible set

$$\mathcal F(\lambda)=\{(T,\theta):T\ge0,\ T\text{ totally symmetric, zero on repeated indices},\ \text{(A),(B),(C) hold}\}$$

the coordinate $\theta$ is an **affine function of $T$**: $\theta=\operatorname{tr}W^3+\tfrac12S_{111}(T)$ with $S_{111}(T)=\sum\lambda_a\lambda_b\lambda_cT_{abc}$ and $\operatorname{tr}W^3$ a constant of the spectrum. That is a statement that $\theta$ carries no *independent* degree of freedom. It is **not** a statement that $\theta$ takes one value on $\mathcal F(\lambda)$, which is what "not a free objective" and "a consistency condition, not a maximisation" both assert. The two differ exactly when $S_{111}$ is non-constant on $\mathcal F(\lambda)$, and the feasible set is a polyhedron of positive dimension, so there is no reason for $S_{111}$ to be frozen on it.

Note also that every step of §1.1 uses **(C) alone**. So whatever the contraction proves, it proves on the larger set cut out by (A) and (C) without (B), which is the record's own diagonal-criticality LP.

**And the record already contains the refutation.** [findings/bounds.md](../findings/bounds.md) reports, of that very LP at the four balanced spectra: *"Exact to nine digits at four dimensions, and it is a genuine range rather than a pinned value, the same LP minimises to $0.176$, $-0.191$, $-0.420$, $-0.577$."* Against $\max\theta=\theta_0(6)=1.054093$ at $n=6$, that is a range of width $0.878$. A quantity ranging over an interval of width $0.878$ is not "pinned by $T$" in the sense the sentence needs.

### 1.3 Screen, the interval survives adding (B), and (B) is inert there

The one thing §1.2's argument leaves open is whether (B), which the diagonal LP omits, collapses the interval. It does not.

**Screen** ([screen_theta_range.py](../scripts/reviewers/r334/screen_theta_range.py); HiGHS, $455$ variables plus $\theta$, all $3N=45$ rows, integer-scaled $\lambda$):

| spectrum ($n=6$, scaled $\lambda$; mults) | true $\theta$ | pinned $\min\theta$ | pinned $\max\theta$ | pinned? |
| --- | --- | --- | --- | --- |
| $S^3\times S^3$: $(-2,3)$; $(9,6)$ | $10$ | $\mathbf{5/3}$ | $\mathbf{10.0}$ | **no, width $8.33$** |
| maximal torus: $(4,-1)$; $(3,12)$ | $5$ | $5.0$ | $5.0$ | yes |
| padded $W_{\mathbb{CP}^2}$: $(2,-1,0)$; $(1,2,12)$ | $3$ | $3.0$ | $3.0$ | yes |
| $\mathbb{CP}^3$: $(-4,1,16)$; $(6,8,1)$ | $20$ | $20.0$ | $20.0$ | yes |

The three maxima in the lower rows reproduce r331's independently-built values exactly, which is this build's validation. The ablation ((A)+(C) only, same script's variant) returns $[5/3,\,10]$ as well: **(B) changes neither end at the balanced spectrum**. Unscaled, $5/3\big/\sqrt{90}=0.175682$, the record's own $0.176$, and $10/\sqrt{90}=1.054093=\theta_0(6)$.

### 1.4 What this does to r331's screen, and to T9

Three consequences, and the first is the opposite of what the record drew.

- **r331's seven-for-seven is a genuine result, not a tautology.** At three of the four spectra above the LP has no choice; at $S^3\times S^3$ it had an interval of width $0.878$ available and returned the true $\theta$ **exactly**. That is the interesting case, it is the conjectured maximiser's own spectrum, and the record's reading deflates precisely the datum worth keeping. The sentence *"That is the structural reason the relaxation returns the true $\theta$ at a catalogued spectrum, rather than a numerical coincidence at seven of them"* must be withdrawn. The candidate explanation that survives is r331 §4's: at those spectra positivity plus the three relations pin the whole value-type distribution, hence every value-symmetric functional of $T$, $S_{111}$, hence $\theta$, among them. That explanation is spectrum-dependent and fails at $S^3\times S^3$, where $\theta$ is *not* pinned and the maximum is tight anyway.

- **"Maximise $\theta$ at fixed spectrum" is well posed, and T9 is well posed.** (A), (B) and (C) are all **linear in $(T,\theta)$ jointly**, $\theta$ enters only (C)'s right-hand side, multiplied by the constant $\lambda_a$. So $\mathcal F(\lambda)$ is a polyhedron and $\max\theta$ over it is an LP, with the standard trichotomy infeasible / bounded optimum / unbounded. Nothing in R4 makes it ill-posed. The brief's conditional (*"if $\theta$ is determined, maximise-$\theta$ is not well posed"*), has a false antecedent.

- **The boxed T9 restatement inherits the error.** *"The question is therefore not 'what is $\max\theta$' but 'for which $\lambda$ is the system feasible with $T\ge0$, and what $\theta$ does feasibility then force'."* At $S^3\times S^3$ feasibility forces only $\theta\in[0.1757,\,1.0541]$. The reformulation is a restatement of the LP with the answer presumed unique, and it should read: *for which $\lambda$ is the system feasible, and what is the **supremum** of the $\theta$ feasibility then permits*. That is the same question the first half of the sentence rejects.

### 1.5 What is actually free at a fixed spectrum

Stated precisely, since the brief asks. At fixed $\lambda$:

- **$\theta$ is not an independent variable**: it is the affine image $\operatorname{tr}W^3+\tfrac12S_{111}(T)$ of $T$, and equivalently is over-determined by $T$, (C) gives $\theta=\lambda_a+\tfrac1{2\lambda_a}\sum_{bc}\lambda_b\lambda_cT_{abc}$ for every $a$ with $\lambda_a\ne0$, and all of these must agree. The contraction of §1.1 is one weighted average of those $N$ determinations.
- **$T$ is free** in the polyhedron $\mathcal F(\lambda)$, of positive dimension at every spectrum tested (r331 records this too, at fixed $(\lambda,\theta)$).
- **What is undecided, and is the live question**, is whether $S_{111}$ (the one shadow of $T$ that matters), is constant on $\mathcal F(\lambda)$. Screened: constant at the $n=6$ torus, padded $W_{\mathbb{CP}^2}$ and $\mathbb{CP}^3$; **non-constant at $S^3\times S^3$**. So the answer is spectrum-dependent, and the interesting spectra are the ones where it is free.

---

## 2. R1, the measure reformulation. CONFIRMED

**Normalisation.** Row $a$ of (A) reads $\sum_{b,c}T_{abc}=2(n-2)$ with $(b,c)$ **ordered**, as §0 derives from $\lVert\mathrm{ad}(v_a)\rVert^2_{\mathrm{HS}}$. So $\mu_a(b,c):=T_{abc}/2(n-2)$ is nonnegative with total mass $1$ on ordered pairs. Correct, and "ordered" is what is meant: on unordered pairs $\{b,c\}$ the same $T$ has mass $n-2$, and the record's own $a<b$-form constraint $\sum_{b<c}T_{abc}=n-2$ elsewhere in [findings/bounds.md](../findings/bounds.md) is consistent with that. The measure is supported off the diagonal since $T_{abb}=0$.

**Second display, (B).** Dividing (B) by $2(n-2)$: $\mathbb E_{\mu_a}[\lambda_b]=-2\lambda_a/2(n-2)=-\lambda_a/(n-2)$. The record writes the left side as $\mathbb E_{\mu_a}[(\lambda_b+\lambda_c)/2]$. This is legitimate **exactly** because $T_{abc}=T_{acb}$, so $\mu_a$ is invariant under the swap $(b,c)\mapsto(c,b)$, giving $\mathbb E[\lambda_b]=\mathbb E[\lambda_c]=\mathbb E[\tfrac12(\lambda_b+\lambda_c)]$. The symmetry used is symmetry of $T$ in its **last two** slots, which total symmetry supplies; that is the symmetry the step needs and no more. Correct.

**Third display, (C).** Dividing (C) by $2(n-2)$: $\mathbb E_{\mu_a}[\lambda_b\lambda_c]=2\lambda_a(\theta-\lambda_a)/2(n-2)=\lambda_a(\theta-\lambda_a)/(n-2)$. Correct.

The factor $2(n-2)$ is the same in both because the same normalising mass is used, and the $2$ on the right-hand sides of (B) and (C) cancels one of its factors. Both displays check.

---

## 3. R2, the spectral condition. CONFIRMED, and NONVACUOUS

### 3.1 The deduction

$\mu_a$ is a probability measure and $\lambda_b\in[\lambda_{\min},\lambda_{\max}]$ pointwise, so $\mathbb E_{\mu_a}[\lambda_b]\in[\lambda_{\min},\lambda_{\max}]$ for every $a$, i.e. $\lambda_{\min}\le-\lambda_a/(n-2)\le\lambda_{\max}$. Taking $a=\arg\max$ in the left inequality: $\lambda_{\min}\le-\lambda_{\max}/(n-2)$, i.e. $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$. Taking $a=\arg\min$ in the right: $-\lambda_{\min}/(n-2)\le\lambda_{\max}$, i.e. $\lvert\lambda_{\min}\rvert\le(n-2)\lambda_{\max}$. Both as recorded; both need only $\lambda_{\min}<0<\lambda_{\max}$, which tracelessness supplies. **Deduction CONFIRMED.**

### 3.2 It is not implied by tracelessness

The traceless unit spectrum $\lambda=(1,-\tfrac1{N-1},\dots,-\tfrac1{N-1})$ up to scale (which is $\Pi_{\mathfrak h}-\tfrac1NI$ for a one-dimensional $\mathfrak h$), has $\lambda_{\max}/\lvert\lambda_{\min}\rvert=N-1=\tfrac{n^2-n-2}2$, which exceeds $n-2$ for every $n\ge4$. So R2 **fails** on a traceless unit spectrum, and is therefore a strictly stronger condition than $\operatorname{tr}W=0$. Its content is (B)'s, i.e. Ricci-flatness together with first Bianchi, not tracelessness.

More sharply, on the whole two-eigenvalue family $W=\Pi_{\mathfrak h}-\tfrac rNI$ ($r=\dim\mathfrak h$): $\lambda_{\max}=1-\tfrac rN$, $\lambda_{\min}=-\tfrac rN$, so $\lambda_{\max}/\lvert\lambda_{\min}\rvert=(N-r)/r$ and R2 reads

$$\frac{N-r}{r}\le n-2\ \text{ and }\ \frac{r}{N-r}\le n-2 \iff \frac n2\le r\le\frac{n(n-2)}2 .$$

The left endpoint is exactly the maximal torus's dimension $r=n/2$; the family's members with $\dim\mathfrak h<n/2$ are **excluded** by R2.

### 3.3 It is saturated on two infinite families, exactly

**Maximal torus $\mathfrak{so}(2)^{n/2}$.** $r=n/2$ gives $(N-r)/r=n-2$: equality in the first inequality, for every $n$. The structural reason falls straight out of the measure: equality means $\mu_{\max}$ is concentrated on $\lambda_{\min}$, i.e. every unit of bracket mass leaving a $\lambda_{\max}$-index lands on a pair of $\lambda_{\min}$-indices. For a Cartan $\mathfrak h$, $[\mathfrak h,\mathfrak h]=0$ and $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m=E_{\min}$, so this holds identically.

**$\mathbb{CP}^m$, every $m$.** Derived here from the Fubini–Study curvature operator (eigenvalues $2(m+1)$ on $\omega$, $2$ on $\Lambda^{1,1}_0$, $0$ on the real form of $\Lambda^{2,0}\oplus\Lambda^{0,2}$, of dimensions $1,m^2-1,m^2-m$) minus the Einstein constant $\tfrac{\mathrm{scal}}{n(n-1)}=\tfrac{2(m+1)}{2m-1}$:

$$\lambda_\omega=\frac{4(m^2-1)}{2m-1},\qquad \lambda_{(1,1)_0}=\frac{2m-4}{2m-1},\qquad \lambda_{(2,0)}=-\frac{2(m+1)}{2m-1},$$

which is $(16,1,-4)$ at $m=3$ (the record's $\mathbb{CP}^3$ row on the nose) and $(4,0,-2)$ at $m=2$, the record's padded $W_{\mathbb{CP}^2}$. Then

$$\frac{\lambda_{\max}}{\lvert\lambda_{\min}\rvert}=\frac{4(m^2-1)}{2(m+1)}=2(m-1)=n-2 .$$

**Equality for every $m$**, by the same mechanism: $E_{\max}=\mathbb R J$ with $[J,\mathfrak u(m)]=0$ and $[J,\cdot]$ preserving $\Lambda^{2,0}\oplus\Lambda^{0,2}=E_{\min}$, so all of $\mathrm{ad}(J)$'s mass lands on $E_{\min}\times E_{\min}$.

**Screen** across the catalogue ([screen_r2_catalogue.py](../scripts/reviewers/r334/screen_r2_catalogue.py)), reporting $\lambda_{\max}/\big((n-2)\lvert\lambda_{\min}\rvert\big)$, so $1$ means saturated:

| family | ratio |
| --- | --- |
| $\mathbb{CP}^m$, $m=2,3,4,5,6$ | $1.000000$ at every $m$ |
| maximal torus, $n=6,8,10,12$ | $1.000000$ at every $n$ |
| $S^m\times S^m$, $n=6,8,10,12$ | $0.375$, $0.222$, $0.156$, $0.120$ |
| $S^3\times S^5$, $S^5\times S^7$, $S^3\times S^7$ | $0.417$, $0.175$, $0.438$ |
| $C_5$ blow-up, $n=5,10,15$ | $0.333$, $0.250$, $0.127$ |

The second inequality is slack everywhere in the catalogue (largest value $1/3$, at the $n=5$ $C_5$ blow-up), so it is the first that carries the content. The balanced products give $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$, so R2 is slack there for $n>4$ and saturated at $n=4$. The $n=8$ witness is not evaluable: the record does not carry its spectrum, as r331 §4 also notes.

### 3.4 In the two-eigenvalue family, R2 *is* the feasibility boundary

**Screen** ([screen_r2_bite.py](../scripts/reviewers/r334/screen_r2_bite.py)), $n=6$, $\lambda=\big((N-r)^{\times r},(-r)^{\times N-r}\big)$, full $(A)+(B)+(C)+T\ge0$ system:

| $r$ | $1$ | $2$ | $3$ | $4$ | $5$ | $6$ | $7$ | … | $11$ | $12$ | $13$ | $14$ |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| R2 | viol | viol | **tight** | ok | ok | ok | ok | | ok | **tight** | viol | viol |
| pinned system | **infeas** | **infeas** | feas | feas | feas | feas | feas | | feas | feas | **infeas** | **infeas** |

Agreement is exact at both ends, and R2's two saturating members $r=3$ (the maximal torus) and $r=12$ are precisely the last feasible ones. $r=3$ and $r=12$ have $\theta$ pinned to a single value ($15$ and $-15$ scaled); the interior values $r=4,\dots,11$ have genuine $\theta$-intervals. **So R2 is worth something**: it excludes real traceless unit spectra, it is tight on two infinite families, and where it can be compared against the full system it reproduces the feasibility boundary exactly. The record should not hedge it.

Its **limitation** should be recorded alongside: R2 is slack at the balanced products and tight at $\mathbb{CP}^m$ and the tori, so it cuts in the direction *away* from the conjectured maximiser. It will not by itself confine the T9 spectrum search near the extremum.

---

## 4. R3, Lemma L70 relocated. Derivation CONFIRMED; the description REFUTED AS STATED

### 4.1 The derivation, with the sign step

For any $b,c$ with $\lambda_b,\lambda_c\in[\lambda_{\min},\lambda_{\max}]$ and $\lambda_{\min}<0<\lambda_{\max}$: if $\lambda_c>0$ then $\lambda_b\lambda_c\ge\lambda_{\min}\lambda_c\ge\lambda_{\min}\lambda_{\max}$ (the second step because $\lambda_{\min}<0$ and $\lambda_c\le\lambda_{\max}$); if $\lambda_c\le0$ then $\lambda_b\lambda_c\ge0>\lambda_{\min}\lambda_{\max}$. So $\min_{b,c}\lambda_b\lambda_c=\lambda_{\min}\lambda_{\max}$ over the spectrum, and the hypothesis $\lambda_{\min}<0\le\lambda_{\max}$ is exactly what the step needs, the record's recorded caveat, correctly attached.

Take R1's second display at $a=\arg\min$:

$$\frac{\lambda_{\min}(\theta-\lambda_{\min})}{n-2}=\mathbb E_{\mu_{\min}}[\lambda_b\lambda_c]\ \ge\ \lambda_{\min}\lambda_{\max}.$$

Divide by $\lambda_{\min}<0$, **flipping the inequality**: $(\theta-\lambda_{\min})/(n-2)\le\lambda_{\max}$, hence

$$\theta\le\lambda_{\min}+(n-2)\lambda_{\max}.$$

That is Lemma L70. The sign handling is correct as recorded, and the derivation needs neither unit norm nor $n\ge5$, matching the recorded list of what the identity does not need.

### 4.2 The equality case matches

Equality forces $\lambda_b\lambda_c=\lambda_{\min}\lambda_{\max}$ for $\mu_{\min}$-almost every pair. From §4.1's chain, $\lambda_b\lambda_c=\lambda_{\min}\lambda_{\max}$ with $\lambda_{\min}<0<\lambda_{\max}$ forces $\lambda_c>0$, then $\lambda_b=\lambda_{\min}$ and $\lambda_c=\lambda_{\max}$ (both chain steps must be equalities). Symmetrising, every pair in $\mathrm{supp}\,\mu_{\min}$ has one index at $\lambda_{\min}$ and one at $\lambda_{\max}$. That is precisely the recorded equality case (*$\mathrm{ad}(v)$ supported on $E_{\min}\otimes E_{\max}$, all $2(n-2)$ units of bracket mass*) so the two agree, with the caveat that the measure derivation delivers it for the **eigenbasis vectors** $v_a\in E_{\min}$ while Lemma L70 quantifies over all unit $v\in E_{\min}$. The record's own eigenspace-constancy argument ($W^\#=\theta W-W^2$ is a polynomial in $W$, so $\langle v,W^\#v\rangle$ is constant on the unit sphere of $E_{\min}$) closes that gap; it is load-bearing here and should be cited at this derivation, not only at the older one.

### 4.3 Why "IS the feasibility condition" overstates it

Two things are dropped.

- **The other end of the range.** $\mathbb E_{\mu_{\min}}[\lambda_b\lambda_c]\le\max_{b,c}\lambda_b\lambda_c=\max(\lambda_{\min}^2,\lambda_{\max}^2)$, and dividing by $\lambda_{\min}<0$ flips again to give a **lower** bound, $\theta\ge\lambda_{\min}-\max(\lambda_{\min}^2,\lambda_{\max}^2)\,(n-2)/\lvert\lambda_{\min}\rvert$. The $\lambda_{\min}$ row of (C) constrains $\theta$ from both sides; the record keeps one side and calls it the condition.
- **The row's real feasibility condition is a two-moment problem, not two range conditions.** Row $\lambda_{\min}$ of (A), (B) and (C) together demand a single probability measure $\mu_{\min}$ on pairs matching *both* prescribed moments simultaneously. That is strictly stronger than each moment lying in its own range: the attainable set of $\big(\mathbb E[\tfrac{\lambda_b+\lambda_c}2],\mathbb E[\lambda_b\lambda_c]\big)$ is the convex hull of $\{(\tfrac{\lambda_b+\lambda_c}2,\lambda_b\lambda_c)\}$ over pairs, a two-dimensional region whose boundary is not the product of the two intervals. So Lemma L70 is **a** necessary condition read off one moment of one row, not the row's feasibility condition.

**Repair.** *Lemma L70 is the upper half of the range condition on (C)'s moment at the $\lambda_{\min}$ row.* Everything the record then says about it, the equality case, the exactness at the balanced products, the slack at $\mathbb{CP}^3$, the full system being strictly stronger, survives that correction unchanged.

---

## 5. R5, outcome asymmetry and the taxonomy

### 5.1 The asymmetry. CONFIRMED

$P$ is a cubic form on the finite-dimensional $\mathcal W_n$, so it attains its maximum on the unit sphere; $Q$ is the gradient of $P$ up to a constant and maps $\mathcal W_n$ to $\mathcal W_n$ (the record's cited [BW08](../references/boehm-wilking-2008-space-forms/) fact), so the constrained maximiser satisfies $Q(W)=\theta W$ with $\theta=P(W)$. Every such $W$ produces, in its eigenbasis, a spectrum $\lambda$ and a $T\ge0$ satisfying (A), (B), (C). Hence:

- **Infeasibility is conclusive.** If no traceless unit $\lambda\in\mathbb R^N$ admits a feasible $T\ge0$ with $\theta>\theta_0(n)$, no critical point has $\theta>\theta_0(n)$, so $\max P=\theta_0(n)$. Correct as the record states it.
- **Feasibility is not.** $(\lambda,T,\theta)$ feasible carries no claim that $\lambda$ is a Weyl spectrum, still less that $T$ is a square of structure constants in an eigenbasis. Correct.

Two conditions the record should attach to the conclusive half. First, the quantification must be over **all** traceless unit spectra of length $N=n(n-1)/2$, multiplicity patterns included; a run that restricts to few distinct eigenvalues forfeits conclusiveness. Second, outcome (i) closes the *value* half of the conjecture ($\max P=\theta_0$); identifying the maximiser as the balanced sphere product needs the equality analysis on top, which is Lemma L71's territory.

### 5.2 The taxonomy is not exhaustive

The record's three outcomes: (i) infeasible above $\theta_0$ everywhere; (ii) feasible above $\theta_0$ only at demonstrably non-realizable spectra (the redirect; (iii) feasible above $\theta_0$ at a spectrum nobody can rule out), no information.

**Missing: (iv) feasible above $\theta_0$ at a spectrum that is provably *realizable*.** This is not a sub-case of (iii): (iii) is ignorance about realizability, (iv) is knowledge of it. And it is far more informative than (iii), because it **refutes T9's own hypothesis**, the thesis that "realizability of the spectrum, not alignment, is the whole content" dies the moment a realizable spectrum carries a feasible $T$ above $\theta_0$. The missing ingredient would then be realizability of $T$ (Jacobi/Bianchi on $c$), not of $\lambda$, and the programme's redirect would point somewhere else entirely.

**And (iv) is not hypothetical, it already occurs at $n=6$.** Padded $W_{\mathbb{CP}^2}$ is a genuine critical point of $\mathcal W_6$ with $\theta=\sqrt{3/2}=1.224745>\theta_0(6)=1.054093$, so its spectrum is realizable by construction, and §1.3's screen returns the pinned system's $\max\theta$ there as exactly $3$ scaled $=\sqrt{3/2}$. The pinned class is feasible above $\theta_0$ at a realizable spectrum. That this is $n=6$ rather than $n\ge12$ is the point, not an escape:

- **Outcome (i) is unreachable at $n<12$**, because the conjecture is false there ($\sqrt{3/2}>\theta_0(n)$ for $n=6,8,10$) so any T9 run must be $n$-indexed, and a small-$n$ run finding feasibility above $\theta_0$ is outcome (iv), carrying **no** evidence about the pinned class's strength.
- Since (iv) exists and is distinguishable, the run must be designed to separate **four** outcomes, and (iv) is the one that is cheapest to test for: check whether the returned $\lambda$ is a catalogued critical point's spectrum before doing anything else.

A fifth, practical outcome also belongs in the design note: **no answer**. The outer problem over $\lambda$ is not an LP (the constraint coefficients are quadratic in $\lambda$) so the T9 optimisation is bilinear at best and may return only a bound or a local optimum, in which case it decides nothing in any of the four directions. The record's phrase *"the one computation that decides it"* in [plan.md](../plan.md) presumes tractability that the problem's structure does not supply.

---

## 6. What the record should change

1. **[findings/bounds.md](../findings/bounds.md), "What the pinned relaxation can and cannot decide"**, keep the contraction (§1.1, it is exact and its structural reason is worth one line: (C) is the diagonal of $W^\#=\theta W-W^2$, the cubic identity its $\lambda$-weighted trace). **Withdraw** "so at a fixed spectrum $\theta$ is not a free objective" and "[r331]'s screen is measuring a consistency condition, not a maximisation". Replace with: *$\theta$ is an affine function of $T$ on the feasible polyhedron, so it carries no independent degree of freedom, but it is not constant there: at the balanced $S^3\times S^3$ spectrum the full system admits $\theta\in[0.17568,\,1.054093]$, and r331's screen returning the upper end exactly is a genuine sharpness result.*
2. **Same section, the boxed T9 restatement**, "what $\theta$ does feasibility then force" becomes "what supremum of $\theta$ feasibility then permits". Delete the implication that $\max\theta$ is the wrong question; it is the right one, and it is an LP in $(T,\theta)$ at fixed $\lambda$.
3. **R2**, record it as **nonvacuous and tight**, with the two saturating families ($\mathbb{CP}^m$ for every $m$, every maximal torus, both with the one-line structural reason from §3.3), the two-eigenvalue reading $\tfrac n2\le r\le\tfrac{n(n-2)}2$, and the limitation that it is slack at the balanced products and so does not confine the search near the extremum.
4. **Lemma L70's relocation**, "the feasibility condition of the pinned system read at the $\lambda_{\min}$ row" becomes "the upper half of the range condition on (C)'s moment at the $\lambda_{\min}$ row"; add the discarded lower bound on $\theta$, and cite the eigenspace-constancy fact where the derivation now needs it.
5. **T9's outcome taxonomy**, add outcome (iv), *feasible above $\theta_0$ at a realizable spectrum*, note it refutes T9's own redirect hypothesis, note it already occurs at $n=6$ via padded $W_{\mathbb{CP}^2}$, and record that outcome (i) is unreachable at $n<12$ so the run must be $n$-indexed. Add the practical fifth outcome and drop "the one computation that decides it".
6. **A new open question, and it is the sharp one**, for which spectra is $S_{111}$ (equivalently $\theta$) constant on the pinned polyhedron? Screened here: constant at the $n=6$ torus, padded $W_{\mathbb{CP}^2}$ and $\mathbb{CP}^3$; **non-constant at $S^3\times S^3$**, where the LP maximum is nevertheless exactly $\theta_0(6)$. That coincidence at the conjectured maximiser is the one fact in this area that has no explanation on the record, and it is the fact worth explaining.

**Scripts:** [screen_theta_range.py](../scripts/reviewers/r334/screen_theta_range.py), [screen_r2_bite.py](../scripts/reviewers/r334/screen_r2_bite.py), [screen_r2_catalogue.py](../scripts/reviewers/r334/screen_r2_catalogue.py). Log: [agent_logs/r334-t9.log](../agent_logs/r334-t9.log).
