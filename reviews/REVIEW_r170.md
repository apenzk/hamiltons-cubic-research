# Gate 2 review r170, item 3c's sub-step 2 scoping

*Cold adversarial review of [plan.md](../plan.md) item 3c, commits `4abde7e`, `082a7d3`, `dca494d`. Every figure below was recomputed from the definitions with an implementation independent of [sym3_weyl_blocks.sage](../scripts/runs/sym3_weyl_blocks.sage); the one shared component is [review_r25_core.py](../scripts/review_r25_core.py)'s `sharp`/`Q`, itself an independent reviewer implementation.*

**Verdict.** The four claims' *numbers* are all correct, every one reproduced here, several by a route the source did not use. Three of the four *inferences* built on them are not.

| | claim | numbers | inference |
| --- | --- | --- | --- |
| 1 | $\mathrm{Weyl}_5=4\omega_2$; 24 blocks, 65 unknowns, largest $4\times4$ | **confirmed**, and the identification is now settled by a discriminator stronger than the weight algebra | sound |
| 2 | $\alpha=3/2$ sharp at $n=5$ | the value $\sqrt{3/2}$ is confirmed; $300$ of my own ascents reproduce it | **REFUTED**, 60 ascents give no upper bound, and this very computation is shown missing a genuine critical point of $\mathrm{Weyl}_5$ |
| 3 | 14 degree-6 invariants, 65 unknowns, 51 degrees of freedom | **confirmed** ($1,1,4,5,14$ at $k=2..6$, computed by Weyl integration) | **REFUTED**, the $W_{\mathbb{CP}^2}$ orbit forces $\ge45.9\%$ of $\mathrm{Sym}^3$ into $\ker G$; the surviving parameter count is between $9$ and $56$, and $9<14$ |
| 4 | $F$ is spectral at $n=5$, so $\mathcal W_5$ tests machinery not mechanism | **confirmed** to $1.7\times10^{-16}$ | **REFUTED as stated**, the conclusion is right, its ground is wrong, and the right ground is already fence post F7 |

---

## Claim 1, the module identification is correct, and can now be settled without the weight algebra

The weight arithmetic in `dca494d` is right. In $B_2$, $\omega_1=e_1$ and $\omega_2=\tfrac12(e_1+e_2)$, so $a\omega_1+b\omega_2=(a+\tfrac b2)e_1+\tfrac b2e_2$; matching $2e_1+2e_2$ gives $b=4,a=0$, i.e. $[2,2]=4\omega_2$. Weyl's dimension formula returns $1\cdot3\cdot5\cdot\tfrac73=35$. The plan's caution is also right: $\omega_1+2\omega_2=[2,1]$ has dimension $35$ as well ($2\cdot\tfrac52\cdot3\cdot\tfrac73$), and $2\omega_2$ (the naive label), is the $10$-dimensional adjoint, confirmed in Sage.

**A discriminator the plan does not use, and it is decisive.** The trivial multiplicity of $\mathrm{Sym}^3$ separates the two candidates outright:

$$[2,2]:\ \dim\mathrm{Sym}^k(\cdot)^{O(5)}=1,1,4,5,14\ (k=2..6),\qquad [2,1]:\ 1,\mathbf{0},5,4 .$$

$[2,1]$ carries **no** cubic invariant at all, while $\mathrm{Weyl}_5$ demonstrably carries exactly one ($\operatorname{tr}W^3$, the $n\le5$ collapse of [fence post F2g](../findings/fence-posts.md)). So the identification rests on a proved fact about $\mathrm{Weyl}_5$ rather than on solving for the label. The plan reaches the same place via "trivial multiplicity $1$ at $n=5$ against $2$ at $n=12$", which is the same observation used as a consistency check rather than as the discriminator it is.

**Block data, reproduced exactly.** `WeylCharacterRing("B2")(2,2).symmetric_power(3)`: degree $7770=\binom{37}3$, **24 blocks**, multiplicities $1..4$ summing to $41$, $\sum m(m{+}1)/2=\mathbf{65}$, largest block $4\times4$, trivial multiplicity $1$. Every figure matches.

*One point of rigour the plan skips.* These are $SO(5)$ constituents, and the certificate needs $O(5)$ ones. They coincide here for a reason worth recording: $n=5$ is odd, so $O(5)=SO(5)\times\{\pm I\}$, and $-I$ acts trivially on $\mathrm{Weyl}_5$ (four tensor indices), hence trivially on $\mathrm{Sym}^3$. Every constituent therefore has a determined $O(5)$-type and nothing splits or fuses. At $n=12$ that argument is unavailable, which is exactly the $SO(12)$-versus-$O(12)$ error the plan already records.

## Claim 2, REFUTED. The ascent is a lower bound, and it demonstrably misses critical points at $n=5$

The plan's two load-bearing sentences are:

> *an exhibited point bounds the maximum from below, and only the ascent bounds it from above*

> *The nonnegativity itself comes from the ascent, which bounds the maximum from above; the screen cannot.*

**A gradient ascent bounds a maximum from below.** Every point it visits is feasible, so its output is $\le\max\theta$ always and $=\max\theta$ only if the run happened to land in the global basin. Sixty runs agreeing establishes that one basin dominates the sampling measure, which is a statement about the basin, not about the maximum. The exhibited $W_{\mathbb{CP}^2}$ and the ascent bound $\max\theta$ from the **same** side; the plan has one of them upside down, and the two quoted sentences are the only support offered for $F\ge0$ on $\mathrm{Weyl}_5$.

**And the failure is not hypothetical at this $n$.** I ran $300$ projected-gradient ascents on the $35$-dimensional $\mathrm{Weyl}_5$ from independent random starts. All $300$ returned $\theta=1.2247448713915898=\sqrt{3/2}$, reproducing the plan's finding, with a wider sample. In the same run I built the $S^2\times S^3$ Weyl tensor from the Einstein-normalised block formula and checked it is an **exact** critical point:

$$\theta(S^2\times S^3)=0.942809042=\tfrac{2\sqrt2}{3},\qquad \lVert Q(W)-\theta W\rVert=2.0\times10^{-16},\qquad \lVert\mathrm{Ric}\rVert_\infty=5.6\times10^{-17}.$$

**The $300$ ascents found it zero times.** So at the exact dimension in question, this method's basin capture is $100\%$ for one critical point and $0\%$ for another that certainly exists, which is the same phenomenon [ATTEMPTS.md](../ATTEMPTS.md) already recorded ("*the balanced sphere product only $3.3\%$ (at $n=8$; $0\%$ observed at $n=6,7$ despite being a confirmed genuine local max there, its basin is simply far smaller)*"). The record contains its own counterexample to the method's exhaustiveness, and it now has an $n=5$ instance.

**What the record actually proves about $\sqrt{3/2}$ at $n=5$, which is more than the ascent and is not cited.** [response.md](../response.md) **Lemma L35**, *"at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$, at every dimension"*, marked **Proven, Gate 2 passed twice**, closing inequality by interval arithmetic, applies verbatim at $n=5$. The presumed maximiser's $\Lambda^2$ spectrum is $(2,-1,-1,0^7)/\sqrt6$: **two** negative eigenvalues, inside Lemma L35's stratum. So $\theta\le\sqrt{3/2}$ is *proved* on the part of $\mathrm{Weyl}_5$ containing the equality point, and the open region is exactly

$$\{W\in\mathrm{Weyl}_5:\ \Lambda^2\text{-spectrum has}\ \ge3\ \text{negative eigenvalues}\}.$$

**And the gap there is not small.** On that region the purely spectral relaxation is loose by a factor $2.07$: for a traceless unit operator on the $10$-dimensional $\Lambda^2\mathbb R^5$, Okumura gives $p_3\le(D-2)/\sqrt{D(D-1)}=0.8432740$, so $\theta=3p_3\le2.5298$ against the true $1.2247$. The extremal profile there is $(9,-1^9)/\sqrt{90}$, nine negative eigenvalues, deep inside the open region. Sharpness at $n=5$ is therefore an open question with a $2.07\times$ hole in it, not a nine-digit fact.

**Consequence for sub-step 2, and it inverts the plan's grading of that step.** A feasible rational Gram certificate at $\alpha=3/2$ on $\mathrm{Weyl}_5$ would be the **first proof** that $\max\theta=\sqrt{3/2}$ there, a statement the record currently only presumes. Sub-step 2 is not a calibration of the pipeline; it is the missing proof of the fact sub-step 2 is described as calibrating against. Conversely the falsifier is one-sided: SOS is sufficient and not necessary, so infeasibility at $n=5$ would leave the bound open rather than refute it, and (given the plan's "calibration" framing), would be read as a pipeline defect. That reading should be written down *before* the solver runs.

## Claim 3, the counts are right, "no obstruction" does not follow, and the orbit costs $45.9\%$ of $\mathrm{Sym}^3$

**14 is right.** Computed independently by Weyl integration rather than by plethysm: from the $35$ weights of $[2,2]$, form $p_k$ by scaling exponents, build $h_k$ by Newton's identities in the Laurent ring $\mathbb Z[x^{\pm},y^{\pm}]$, then take $\tfrac1{|W|}\mathrm{CT}\big[h_k\prod_{\alpha\in\Phi}(1-x^\alpha)\big]$. Positive controls: the denominator's constant term is $8=|W(B_2)|$; $k=2$ gives $1$; $k=3$ gives $1$, matching the cubic-invariant count the record proves four ways. Result $1,1,4,5,14$ at $k=2,\dots,6$. $O(5)$-invariants equal $SO(5)$-invariants here by the $-I$ argument of Claim 1.

**And $51$ is right as arithmetic.** The Gram map $\mathrm{Sym}^2(\mathrm{Sym}^3V^*)\to\mathrm{Sym}^6V^*$ is surjective, and taking $O(5)$-invariants of a surjection of $O(5)$-modules stays surjective, so the $14$ constraints are independent and the affine slice of invariant Grams reproducing $F$ has dimension $65-14=51$.

**The inference is where it breaks, in two ways.**

*First, direction.* Dimension counting can produce an obstruction (unknowns $<$ constraints) and can never produce its absence. Feasibility of an SDP is whether an affine slice meets the PSD **cone**, and a count of the slice says nothing about that. A Motzkin-type nonnegative-but-not-SOS form has as many degrees of freedom as one likes.

*Second, and specific to this problem: $F$ has zeros, so the Gram spectrahedron is a proper face, never full-dimensional.* Write the invariant Gram as $G=\bigoplus_\lambda G_\lambda\otimes\mathrm{Id}_{\dim\lambda}$ and $F(W)=\sum_\lambda\langle G_\lambda,B_\lambda(W)\rangle$ with $B_\lambda(W)\succeq0$ the block moment matrix of the $\lambda$-covariants. At $W_0=W_{\mathbb{CP}^2}$, $F=0$ and every summand is $\ge0$, so **every** summand vanishes and

$$G_\lambda\,B_\lambda(W_0)=0\quad\text{for every }\lambda,\qquad\text{i.e.}\qquad \operatorname{rank}G_\lambda\le m_\lambda-\operatorname{rank}B_\lambda(W_0).$$

Two consequences, one exact and one measured.

**Exact: the trivial block is forced to zero.** $m_{\mathrm{triv}}=1$ and $B_{\mathrm{triv}}(W_0)\propto\operatorname{tr}(W_0^3)^2=1/6\neq0$, so $G_{\mathrm{triv}}=0$. One of the $65$ unknowns is gone before any solver starts.

**Measured: the orbit kills $3570$ of $7770$ dimensions.** The zero set contains the cone over $O(5)\cdot W_0$ (a $6$-dimensional orbit, $\dim\mathfrak{so}(5)-\dim(\mathfrak u(2)\oplus\mathfrak{so}(1))=10-4$), and $O(5)\cdot W_0=SO(5)\cdot W_0$ because $-I$ acts trivially. Evaluating the $7770$ cubic monomials at $5200$ random orbit points and taking the rank of the $5200\times5200$ Gram gives, cleanly and identically at tolerances $10^{-8}$, $10^{-10}$, $10^{-12}$,

$$\dim\operatorname{span}\{v(W):W\in O(5)\!\cdot\!W_0\}=3570\quad\Longrightarrow\quad \operatorname{rank}G\le7770-3570=4200 .$$

So **$45.9\%$ of $\mathrm{Sym}^3(\mathrm{Weyl}_5)$ is forced into $\ker G$** by a constraint the $65$-versus-$14$ count cannot see. Feeding $\sum_\lambda r_\lambda\dim\lambda=3570$, $0\le r_\lambda\le m_\lambda$, $r_{\mathrm{triv}}=1$ into the exact block table (24 blocks, dimensions $810,770,625,455,455,429,390,\dots,14,5,1$) and optimising $\sum(m_\lambda-r_\lambda)(m_\lambda-r_\lambda+1)/2$ over integer profiles:

$$\boxed{\ \textbf{9}\ \le\ \text{surviving free parameters}\ \le\ \textbf{56}\ \ (\text{against }65)\ }$$

The lower end is **below the 14 constraints**. So the honest statement is not "51 degrees of freedom, no obstruction" but "somewhere between an over-determined system and 42 degrees of freedom, and which one is not known until the isotypic projections exist". Pinning $r_\lambda$ requires exactly the projections the plan lists as the outstanding step, so the degree-of-freedom claim and the outstanding step are the same unknown, and the claim was made as though it were not.

*Scope of that number.* $3570$ is measured on the $SO(5)$ orbit of one point; the true zero set may be larger (it contains $-W_0$'s orbit, and any further equality points), so $4200$ is an upper bound on $\operatorname{rank}G$ that can only fall.

## Claim 4, the identity holds, the conclusion is right, the stated ground is wrong

**The identity, reproduced.** With an independent Weyl projector and $\Lambda^2$-matrix conversion, on random unit $\mathrm{Weyl}_n$ tensors:

| $n$ | $\max\lvert\langle W^\#,W\rangle-2\operatorname{tr}W^3\rvert$ | $\theta/\operatorname{tr}W^3$ |
| --- | --- | --- |
| 4 | $2.8\times10^{-16}$ | $3.000000000$ |
| 5 | $1.7\times10^{-16}$ | $3.000000000$ |
| 6 | $8.6\times10^{-2}$ | $-0.17,\ 2.90,\ 4.21$ (wanders) |

So $\theta=3\operatorname{tr}(W^3)$ at $n\le5$ and $F=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$ is a function of the $\Lambda^2$ spectrum. Confirmed.

**But "$F$ is spectral" and "$F\ge0$ is a spectral theorem" are different statements, and only the first is true.** The inequality $\tfrac32(\sum\mu_i^2)^3\ge9(\sum\mu_i^3)^2$ is **false** for a general traceless unit operator on $\Lambda^2\mathbb R^5$: Okumura gives $\sup p_3=0.8432740$ at $(9,-1^9)/\sqrt{90}$, i.e. $\theta\le2.5298$, against $\sqrt{3/2}=1.2247$. What closes that $2.07\times$ gap is nothing about the spectrum, it is which spectra $\mathrm{Weyl}_5$ realises, i.e. [fence post F10](../findings/fence-posts.md)'s frame-realisability, the original problem in new coordinates. So $100\%$ of the content of $F\ge0$ at $n=5$ lives in the Weyl structure, and an SOS certificate is a statement about that structure.

**Hence the appeal to fence post F6 is a category error.** Post F6 retired a route that tried to **bound** $\theta$ from spectral moments of $L_W$ and came out $49.7\times$ short. Here the spectrum is the *objective*, not the *method*: the certificate quantifies over $\mathrm{Weyl}_5$ and its Gram matrix is indexed by $\mathrm{Sym}^3$ of the module, so it inspects exactly the alignment data post F6 says is needed. The plan applies a fence about what can bound $\theta$ to a question about what a certificate can certify, the distinction the brief flags, and it does not survive.

**The conclusion is nonetheless right, on grounds already on the record.** Two of them, both stronger than the spectral one:

- **[Fence post F7](../findings/fence-posts.md).** $n=5$ sits below the crossover $6+2\sqrt7\approx11.29$, where $W_{\mathbb{CP}^2}$ genuinely wins. The threshold being certified is $\sqrt{3/2}$ against a $\mathbb{CP}^2$-type extremiser; at $n\ge12$ it is $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ against a balanced sphere product. **Different constant, different extremiser, different equality orbit**, so the $n=5$ certificate's zero set has nothing to do with the $n\ge12$ one. That is the same sanity filter [ATTEMPTS.md](../ATTEMPTS.md) applies to the diagonal certificate, and it fires here for a reason the plan does not give.
- **The syzygy cuts the transfer, not the certificate.** Track B's whole rationale was that a certificate found once, rewritten in trace words, is a candidate identity at all $n$. At $n\le5$ the extra relation $\beta=\alpha/2$ (Lovelock) means the trace-word form of an $n=5$ certificate is *not unique* and need not restrict correctly to $n\ge6$, precisely [ATTEMPTS.md](../ATTEMPTS.md) Result 4's "any basis fitted at $n=8$ will not restrict correctly to $n=6,7$", one degree down. This is the sharp reason $\mathcal W_5$ does not transfer, and it is about syzygies among invariants rather than about spectra.

**What a $\mathcal W_5$ certificate would and would not establish.**

- **Would:** a rigorous proof that $\max\theta=\sqrt{3/2}$ on $\mathrm{Weyl}_5$, closing the $\ge3$-negative-eigenvalue region that Lemma L35 leaves open, and settling a value the record presumes from basin evidence. It would also establish that degree $6$ suffices for the *full-space* problem at one $n$, which [ATTEMPTS.md](../ATTEMPTS.md) Result 1 established only on the diagonal locus.
- **Would not:** say anything about $\theta_0(n)$ at $n\ge12$, because the polynomial, the constant and the equality orbit all change; and its trace-word form is not a candidate identity for $n\ge6$, because of the syzygy.

That is a real deliverable, and it is more than "evidence about machinery and degree".

## Answers to the brief's three questions

**(a) Asserted as new, already on the record.** Four items:

- $\theta=3\operatorname{tr}(W^3)$ at $n\le5$ and its consequence that the problem is single-spectrum there, [fence post F2g](../findings/fence-posts.md) as rewritten 2026-08-26, and the paragraph above it ("*At $n=4,5$: $p_3(\omega)=-3p_3(\mu)$ exactly, so $\theta=3p_3(\mu)$ and the problem is single-spectrum*"). The plan cites 2g for the identity but presents the single-spectrum consequence as the new step.
- Independence of the two cubics from $n=6$, 2g's "*All fail from $n=6$*"; the plan's $9.2\times10^{-2}$ is a re-measurement.
- $\theta=\sqrt{3/2}$ at padded $W_{\mathbb{CP}^2}$, $n=5$, [ATTEMPTS.md](../ATTEMPTS.md) records the exact match "*checked at $n=4,5,6,8,10$*" with residual literally zero.
- Ascent basin dominance for the $\mathcal S^4(\alpha)$ attractor, [ATTEMPTS.md](../ATTEMPTS.md) Result 1, $470$ restarts at $n=6,7,8$, $100/99.3/95.8\%$.

**Running the other way**, one record item strictly stronger than a plan claim is not cited: [response.md](../response.md) Lemma L35 already *proves* $\theta\le\sqrt{3/2}$ at every dimension on the $\le2$-negative stratum, which contains the $n=5$ maximiser. The plan's "$60$ ascents" is weaker evidence for a weaker statement.

**(b) The grade of $9$ should come down to $6$.** The `closes` factor of $3$ stands: a certificate at $n=12$ closes Problem P, and the $n=5$ relocation does not touch that. The middle factor does not. It was set on a tractability reading, "*a small semidefinite program*", "*the '734 million' figure describes a space the certificate never touches*", "*a factor of $2809$*", and all three of those are wrong or unsound (see (c)). What is actually established is that the SDP is small **once posed**; posing it at $n\ge12$ needs isotypic projections of a $733{,}813{,}080$-dimensional space, which the plan correctly names as outstanding but prices as the last chore rather than as the research step it is. With the $2809$ comparison withdrawn, nothing measured supports the tractability factor, so $3\times2\times1=6$ until an explicit projection exists at any $n\ge6$.

**(c) The $2809$-fold comparison is unsound, twice, and the two Gram matrices are for different problems.** Reconstructing the sizes from $\dim\mathrm{Weyl}_n=n(n+1)(n+2)(n-3)/12$:

| object | count |
| --- | --- |
| $\dim\mathrm{Weyl}_{12}$ | $1638$ |
| monomials of degree $\le2$ in $1638$ vars | $1{,}343{,}980$, **the $1.34\times10^6$** |
| $\dim\mathrm{Sym}^3(\mathrm{Weyl}_{12})=\binom{1640}3$ | $733{,}813{,}080$, **the $734$ million** |

The identification is confirmed by the diagonal-locus rows, which reproduce [ATTEMPTS.md](../ATTEMPTS.md) Result 1 exactly: degree-$\le2$ monomial counts in $n(n-3)/2$ variables give $6,55,231,666$ at $n=4,6,8,10$ against the recorded Gram sizes $6,55,231,666$. So the earlier attempt's Gram is the **degree-4** basis for the cubic statement $\theta_0-P\ge0$ with a sphere multiplier, and $1.34\times10^6$ is that same degree-4 basis on the full space at $n=12$.

Item 3c is a **degree-6** homogeneous SOS of a sextic, whose Gram is indexed by $\mathrm{Sym}^3$, of size $733{,}813{,}080$. Therefore:

- **Wrong units.** $1{,}343{,}980$ is a row count; $477$ is a parameter count. The degree-4 problem's parameter count is $\binom{1343981}2\approx9.0\times10^{11}$, not $1.34\times10^6$.
- **Wrong problem.** The two Grams are for different polynomials at different degrees. In matched units, 3c's own unreduced problem at $n=12$ is $733{,}813{,}080$ rows, **$546\times$ larger** than the wall the earlier attempt hit, not $2809\times$ smaller.
- **And the dismissal of $734$ million is exactly backwards.** $\binom{1640}3=733{,}813{,}080=\dim\mathrm{Sym}^3(\mathrm{Weyl}_{12})$ is *precisely* the space 3c's Gram matrix is indexed by. The `D6.symmetric_power(3)` blow-up and the certificate's ambient Gram are the same object, which is why the number coincides. The defensible sentence is "the block form means the certificate never has to **materialise** that space", reducing $2.69\times10^{17}$ unreduced parameters to $477$, a far larger and genuinely impressive reduction. The sentence on record instead says the space is not touched, which mis-locates the object and makes the earlier attempt's measured wall look like evidence about 3c when it is evidence about a different SDP.

## What I checked and what I did not

*Two scripts are added so the record can regenerate the new figures:* [review_r170_n5_invariants.sage](../scripts/reviewers/r170/review_r170_n5_invariants.sage) (block profile, invariant dimensions by Weyl integration, the $[2,1]$ discriminator) and [review_r170_orbit_face.py](../scripts/review_r170_orbit_face.py) (the two critical points, the orbit-span rank, the parameter range).

**Reproduced independently:** the $n\le5$ cubic collapse and its failure at $n=6$; $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$ and its spectrum $(2,-1,-1,0^7)/\sqrt6$; $S^2\times S^3$ as an exact critical point at $\theta=2\sqrt2/3$; $300$ ascents on $\mathrm{Weyl}_5$; the $24$-block profile and $65$ unknowns; the invariant dimensions $1,1,4,5,14$ at $n=5$ by Weyl integration; the discriminating $[2,1]$ profile $1,0,5,4$; the stable $71/477/89$ from a copy of the repo script; every Gram-size count above; the orbit-span rank $3570$; the $[9,56]$ parameter range by exact integer DP over the block table.

**Not attempted:** any $n\ge6$ plethysm beyond the stable-range script (per the brief); an explicit isotypic projection at any $n$; a proof or refutation of $\max\theta=\sqrt{3/2}$ on the $\ge3$-negative region of $\mathrm{Weyl}_5$, that region is now the precise open statement, and it is the one sub-step 2 would settle.

*Reviewer r170.*
