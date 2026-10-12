# Gate 2, reviewer r169 on item 3c's sub-step 2 scoping

*Cold brief, [plan.md](../plan.md) item 3c and commits `4abde7e`, `082a7d3`, `dca494d`. Every representation-theoretic figure below was recomputed independently by torus/constant-term arithmetic on the $B_2$ weight lattice, which needs no `symmetric_power` and no character materialisation.*

## Verdict in one line

Claims 1 and 3's numbers are **confirmed exactly**, claim 2's status label is **wrong in a way the record's own fence post F1 already warns against**, and **claim 4's conclusion does not follow from its premise**, the premise is true and already on the record in three places, but "the statement is spectral" and "a proof of the statement tests no mechanism" are different assertions, and the second is false. The right ground for calling $\mathcal W_5$ a calibration is non-transferability, not spectrality.

| claim | premise | conclusion | verdict |
|---|---|---|---|
| 1. $n=5$ block data | $4\omega_2$, $24$ blocks, $65$ unknowns, trivial mult $1$ |, | **confirmed**, every figure, independently |
| 2. $\alpha=3/2$ sharp at $n=5$ | $60$ ascents to $\sqrt{3/2}$ | "verified sharp before any solver runs" | **premise is a lower bound plus evidence**; the conclusion overstates it, and the stated reason inverts the direction |
| 3. constraint count | $14$ degree-$6$ invariants at $n=5$ | "$51$ dof, so no dimensional obstruction" | **$14$ confirmed**; the inference misses up to $41$ further linear conditions |
| 4. THE SCOPING CLAIM | $F_5$ is a function of the $\Lambda^2$ spectrum | "tests machinery not mechanism" | **premise true and thrice on record; conclusion refuted** |

## Claim 4, the load-bearing one

### The premise is correct, and it is the record's, not this cycle's

At $n=5$ the generalized Kronecker delta on six indices vanishes, so [fence post F2g](../findings/fence-posts.md)'s Lovelock identity gives $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$ and hence $\theta=3\operatorname{tr}(W^3)$, making $F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$ a function of the $\Lambda^2$ spectrum. That is a **proof**, and it is stronger than the $4\times10^{-16}$ residual `4abde7e` offers for it.

### The conclusion is a scope error the record already names

The commit reasons: $F_5$ is spectral, spectral quantities cannot reach the general case, therefore a $\mathcal W_5$ certificate is about machinery. The middle premise is about **what a bound may read**. The conclusion is about **what a proof may establish**. Those are different, and [fence post F1](../findings/fence-posts.md) states the distinction verbatim in the other direction:

> *Note the scope carefully:* this says no *spectral function* determines $P$; it does **not** say a spectral bound cannot be sharp, and at $n=4$ one is.

The concrete refutation of the inference is that **an SOS certificate for $F_5$ cannot be a spectral argument**, because $F_5$ is *false* on the ambient space of the spectra it reads. $W$ acts on $\Lambda^2\mathbb R^5\cong\mathbb R^{10}$ as a trace-free symmetric operator, and Okumura's sharp bound there is $\lvert p_3\rvert\le\frac{N-2}{\sqrt{N(N-1)}}p_2^{3/2}=\frac{8}{\sqrt{90}}p_2^{3/2}=0.84327\,p_2^{3/2}$, attained at spectrum $(9,-1^9)$. What $F_5\ge0$ asserts is $\lvert p_3\rvert\le p_2^{3/2}/\sqrt6=0.40825\,p_2^{3/2}$, attained at the padded $W_{\mathbb{CP}^2}$ spectrum $(2,-1,-1,0^7)$, a factor $2.0662$ tighter. **The whole content of the $n=5$ certificate is the first Bianchi identity closing that factor of two**, and no spectral reasoning supplies it. A certificate at $n=5$ is a representation-theoretic proof about the realisable $\Lambda^2$-spectra of $\mathrm{Weyl}_5$, which is a mechanism, not machinery.

### What a $\mathcal W_5$ certificate WOULD establish

1. **A theorem the record does not have.** $\Theta_5=\sqrt{3/2}$ is unproved here. [stratum-two-negative.md](../findings/stratum-two-negative.md) records $n=4$ as *"on record and proved"* via $P=9(\det W^++\det W^-)$; nothing proves the $n=5$ maximum, and the chain that comes closest lands at $1.224740$, **under** the target. A rational Gram certificate at $\mu=0$ **is** the missing upper bound, since $F_5\succeq0$ on $\mathrm{Weyl}_5$ is exactly $\max\theta=\sqrt{3/2}$.
2. **Degree adequacy, which is the transferable risk.** $F_5$ is a nonnegative sextic in $35$ variables, so Hilbert puts it outside every case where nonnegative forces SOS. Feasibility at degree $3$ is therefore a genuine finding, and degree adequacy is the one property that the $n=12$ ansatz shares.
3. **That the tight-equality rank conditions are satisfiable at all.** Positive-dimensional equality sets are what make tight SOS fail; see claim 3 below.
4. **The pipeline**: isotypic projection, solve, rational rounding.

### What it would NOT establish

1. **Nothing about alignment.** $\langle W^\#,W\rangle-2\operatorname{tr}(W^3)\equiv0$ at $n=5$, so the invariant carrying $98.2\%$ of $\theta$ at the $n=12$ maximiser is never separately present.
2. **Nothing about the joint-cubic problem**, and this is the sharp form of the record's point. The space of cubic $O(n)$-invariants of $\mathrm{Weyl}_n$ has dimension $\mathbf1$ at $n=5$ and $\mathbf2$ from $n=6$, which is *literally* the trivial multiplicity of $\mathrm{Sym}^3$ that claim 1 already reports. So at $n=5$ the certificate has **no choice about which cubic it bounds**, while at $n\ge6$ it must certify one specific line in a two-parameter family, and [fence posts 2 and 2e](../findings/fence-posts.md) show that bounding the two basis cubics separately overshoots by $1.7$–$1.8\times$. The $1$-versus-$2$ dimension is the structural cause; "spectral versus aligned" is its symptom.
3. **No transfer of the certificate itself, and this is the strongest ground for "calibration".** Track B's stated purpose in [ATTEMPTS.md](../ATTEMPTS.md) is that *"a certificate found once, rewritten in trace words, is a candidate identity for all $n\ge12$"*. That lift needs the **stable range**. $n=5$ sits below it and carries the Lovelock syzygy, so a trace-word rewrite of an $n=5$ certificate is a relation that fails from $n=6$. The certificate is blocked from lifting **by the very identity that makes $F_5$ spectral**, which is the argument `4abde7e` was reaching for and did not make.
4. **Nothing about the equality orbit that matters at $n=12$.** At $n=5$ the equality set is the cone on the $O(5)$-orbit of padded $W_{\mathbb{CP}^2}$, isotropy $\mathfrak u(2)$, orbit dimension $10-4=6$. At $n=12$ it is the balanced sphere product's orbit, a different type with a different stabiliser. Tight-SOS feasibility is governed by the equality set, so one says little about the other.
5. **Nothing about $\mu$.** The $n=5$ form drops $\mu\lvert W\wedge Q(W)\rvert^2$ entirely, so the ansatz's only free structural device is untested. See the note on its sign below.
6. **No block is shared.** $24$ blocks / mults $\le4$ / $65$ unknowns / $14$ constraints against $71$ / $\le9$ / $477$ / $89$: the two SDPs have no common structure beyond both being symmetry-reduced.

### Verdict on claim 4

**The conclusion stands on the wrong ground and is stated too strongly.** "Machinery and degree, not mechanism" is the sentence [ATTEMPTS.md](../ATTEMPTS.md) attaches to the earlier diagonal certificate, and the two cases are not alike: that certificate was restricted to a **locus** where the competitor does not live and where the true bound is smaller, so it bounded the wrong quantity. The $n=5$ certificate is on the **whole** module, at the **sharp** threshold, with the $\mathbb{CP}^2$-type competitor present as the extremiser. Importing the sentence across that difference is the same move [plan.md](../plan.md) itself flags one paragraph earlier as the reason 3c escapes the earlier defect. *Keep the recommendation (run $\mathcal W_5$ first) and rewrite its reason as non-transferability plus the $1$-versus-$2$ cubic dimension.*

## Claim 1, confirmed exactly, independently

The weight arithmetic is right and is the real identification. In $B_2$, $\omega_1=e_1$ and $\omega_2=\tfrac12(e_1+e_2)$, so $[2,2]=2e_1+2e_2=4\omega_2$, with $a=0$ forced. Weyl's dimension formula on $\lambda+\rho=(7/2,5/2)$ gives $1\cdot5\cdot\tfrac73\cdot3=35$, and on $\omega_1+2\omega_2=(2,1)$, $\lambda+\rho=(7/2,3/2)$, gives $2\cdot3\cdot\tfrac73\cdot\tfrac52=35$, **so the plan is right that dimension cannot separate them**.

Every $n=5$ figure reproduced, by decomposing $h_3$ of the $35$ weights against the $B_2$ Weyl denominator:

$$\textbf{24 blocks},\ \text{mults }1\ldots4\text{ summing to }41,\ \textbf{65 unknowns},\ \text{largest }4\times4,\ \text{trivial multiplicity }\mathbf1,\ \dim=7770.$$

**And the trivial-multiplicity check does discriminate**, which the plan asserts without demonstrating: running the same computation on $\omega_1+2\omega_2$ returns cubic-invariant dimension $\mathbf0$ against $4\omega_2$'s $\mathbf1$, and degree-six $24$ against $14$. So the check is sound, not merely consistent.

**One methodological point the plan does not state, and it is what makes the $n=5$ computation legitimate.** For odd $n$, $-\mathrm{Id}\in O(5)\setminus SO(5)$ acts **trivially** on $\mathrm{Weyl}_5$, so the $O(5)$-action factors through $O(5)/\{\pm\mathrm{Id}\}\cong SO(5)$ and the $O(5)$-isotypic decomposition **is** the $B_2$ one. Without that, an $SO$-level count at $n=5$ would risk exactly the associate-pair merging that is the mirror of the $D_6$ error the script records. The labels above are $SO(5)$ highest weights; their $O(5)$ names carry a $\det$ twist on the odd ones, which changes no multiplicity.

**One mislabel.** *"reproducing the parity-sensitive Lovelock collapse"*, the collapse is a **threshold at $n=6$**, from the rank of the generalized Kronecker delta on six indices, and holds at $n=4$ and $n=5$ alike. It is dimension-threshold-sensitive; parity plays no part.

## Claim 2, the numbers are almost certainly right, the epistemic label is not

$60$ ascents converging to $1.224744871$ is a **lower** bound $\max\theta\ge\sqrt{3/2}$ together with strong evidence of equality. [plan.md](../plan.md) says the opposite, twice:

> an exhibited point bounds the maximum from below, and **only the ascent bounds it from above**

> the nonnegativity itself comes from **the ascent, which bounds the maximum from above**; the screen cannot

A gradient ascent returns a point, and a point is a lower bound. Nothing in $60$ restarts bounds the maximum above. This is the failure mode [fence post F1](../findings/fence-posts.md)'s preamble was written about, *"before a sample is quoted as evidence, check that the sample can contain the thing being looked for"*, in its inverted form: checking that the sample can *exclude* it.

So *"its target is verified sharp before any solver runs"* should read **verified sharp numerically**, and $F_5\succeq0$ on $\mathrm{Weyl}_5$ is an **open statement**, not an input. That change is favourable to the route, not against it: it is precisely why sub-step 2 produces a theorem rather than a calibration. As it stands the plan is internally inconsistent, it treats the $n=5$ bound as established when justifying the certificate's target, and as worthless when scoping the certificate's value.

## Claim 3, $14$ confirmed, the inference does not follow

$O(5)$-invariant dimensions of $\mathrm{Weyl}_5$ by degree come out $1,1,4,5,\mathbf{14}$ at $k=2,\dots,6$. The $k=3$ value of $1$ is the record's known cubic-invariant dimension at $n\le5$ and validates the method; the stable-range comparison is $1,2,7,19,89$. **So $14$ is right and $65-14=51$ is right.**

**"No dimensional obstruction" does not follow.** Write $F_5(W)=v(W)^{\mathsf T}Gv(W)$ with $v(W)$ the degree-three Veronese and $G\succeq0$ equivariant. At any $W_0$ with $F_5(W_0)=0$, positivity forces $Gv(W_0)=0$, and by equivariance $\ker G$ must contain the whole submodule generated by the equality orbit. In block $\lambda$ this reads $G_\lambda u_\lambda=0$, which is $m_\lambda$ linear conditions, so the equality cone contributes **up to $\sum_\lambda m_\lambda=41$ further linear conditions** on the same $65$ unknowns, on top of the $14$ coefficient equations. The sharpest form: **every multiplicity-one block in which $W_{\mathbb{CP}^2}$ has a nonzero component is forced to vanish outright**, and there are $12$ such blocks at $n=5$, including the trivial one, whose Gram scalar dies because $\operatorname{tr}(W_{\mathbb{CP}^2}^3)\ne0$. A count of $51$ free directions in an affine slice sees none of this, and none of it is a reason the route fails; it is the reason the route is a real test.

## Answers to the brief's questions

**(a) Already on the record.** The $n=5$ collapse and its consequence are held in **three** places before `4abde7e`: [fence post F2g](../findings/fence-posts.md) (with the Lovelock proof, plus the standing consequence *"a bound that reaches $\theta$ through the $\Lambda^2$-spectrum alone is exact for $n\le5$ and cannot be sharp for $n\ge6$"*), [fence post F23](../findings/fence-posts.md) (*"At $n=4,5$: $p_3(\omega)=-3p_3(\mu)$ exactly, so $\theta=3p_3(\mu)$ and the problem is single-spectrum"*), and [bounds.md](../findings/bounds.md) (*"the cubic invariants are $1$-dimensional ... so $\theta=3\operatorname{tr}W^3$"*). The commit's $4\times10^{-16}$ is a fourth numerical confirmation of a proved identity. What is new is only the application to 3c, and that application is the part this review refutes.

**Two citations are wrong.** [Fence post F6](../findings/fence-posts.md) reads *"Spectral moments of $L_W$ are the wrong invariants, the Track A route closed with a quantified negative, $49.7\times$ short at $n=12$"*, which is about moments of the multiplication operator $L_W$ on a specific closed route. It is **not** the $\Lambda^2$-spectrum statement the commit needs. The right citations are posts **1** and **2g**. And *"the '$734$ million' figure describes a space the certificate never touches"* is false: $\dim\mathrm{Sym}^3(\mathrm{Weyl}_{12})=\binom{1640}{3}=733{,}813{,}080$ **exactly**, and that is the index set of 3c's own degree-six Gram matrix. The true statement is that the certificate never needs to *materialise* it.

**(b) The grade of $9$ is no longer right; it should be $3\times2\times1=6$.** `closes` and `margin` are untouched. `attackable` was scored $3$ on *"sub-step 1 done: $477$ unknowns, $89$ constraints, $71$ blocks"*, a statement about the $n\ge12$ SDP's **size**. The relocation moves the only affordable instance out of the live path, and the plan itself names the outstanding work as the explicit isotypic projection, which *"neither Sage's symmetric functions nor cvxpy supplies"*. At $n=5$ that projection is a job inside a $7{,}770$-dimensional space; at $n=12$ it is a job inside a $733{,}813{,}080$-dimensional one, the very object the machine cannot hold. **The relocation multiplies the owed step by $10^5$ and the plan does not price it.** An item whose SDP is small but not posed, and whose cheap instance has been demoted, is attackable at $2$.

**(c) The $2809$-fold comparison is unsound, on both axes.** Reproduced exactly: $\dim\mathrm{Weyl}_{12}=1638$, and the earlier attempt's *"$\sim1.34\times10^6$ Gram rows"* is $\binom{1640}{2}=1{,}343{,}980$, the count of monomials of degree $\le2$ in $1638$ variables, i.e. a **degree-four** Gram, matching that section's own table ($6,55,231$ at $n=4,6,8$ are $\binom{4}{2},\binom{11}{2},\binom{22}{2}$). Against it the plan sets $477$, the **scalar-unknown** count of a **degree-six** symmetry-reduced Gram. So the ratio compares rows to unknowns and degree four to degree six.

- Like-for-like on rows: $733{,}813{,}080$ against $1{,}343{,}980$, 3c's unreduced problem is $546\times$ **larger**.
- Like-for-like on reduction: $\mathrm{Sym}^2(\mathrm{Weyl}_n)$ in the stable range has $13$ blocks and $\mathbf{15}$ scalar unknowns. So the symmetry reduction the earlier attempt lacked was worth $1.34\times10^6$ rows $\to15$ unknowns at its own degree, far more dramatic than $2809$, and it was available to it.

**The qualitative claim survives the arithmetic**: symmetry reduction is what the earlier attempt lacked, and it is what makes 3c's SDP small. Replace $2809$ with the honest pair of figures.

## One further finding, outside the brief's list

**The sign of $\mu$ decides whether a certificate closes Problem P, and the record never states it.** The ansatz is $\Theta_n^2\lvert W\rvert^6-\langle Q(W),W\rangle^2+\mu\lvert W\wedge Q(W)\rvert^2\succeq0$, with *"a certificate at $n=12$ closes Problem P outright"*. Read as plain global nonnegativity, a certificate with $\mu>0$ proves only $\langle Q(W),W\rangle^2\le\Theta_n^2\lvert W\rvert^6+\mu\lvert W\wedge Q(W)\rvert^2$, which is **weaker** than Conjecture A; the implication needs $\mu\le0$. There is a reading that rescues every sign, $\lvert W\wedge Q(W)\rvert^2$ lies in the ideal cutting out the critical set $\{Q(W)=\theta W\}$, and the maximum of $\theta$ on the sphere is attained at a critical point, so an SOS **modulo that ideal** suffices. That reading is the right one and it makes the ansatz natural, but it is nowhere written down, and the step *"the supremum is attained at a critical point, so certifying there is enough"* is not on the record. `grep` finds exactly one occurrence of the $\mu$ term in the whole repository. **Owed: one sentence fixing the reading, or a sign constraint.**

## Reproducibility

`4abde7e`, `082a7d3` and `dca494d` touch [plan.md](../plan.md) only. No script backs the $n=5$ block data, the $60$ ascents, the $400$-tensor screen or the $4\times10^{-16}$ residual; [sym3_weyl_blocks.sage](../scripts/runs/sym3_weyl_blocks.sage) is stable-range only and its `o`-basis method is **invalid at $n=5$**, where King's modification rules apply. This review's $n=5$ figures come from an independent torus computation and agree with every one of them, so the data is right, but the repository cannot currently regenerate it.

---

*r169, Gate 2. Reproduced: all of claim 1, all of claim 3's counts, both stable-range profiles, and the three dimension figures behind question (c). Not reproduced: the $60$ ascents, the criticality residual, the $400$-point screen.*
