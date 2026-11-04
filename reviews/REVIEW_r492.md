# Review r492, Lemma L23 (`findings/ungraded-slack.md`)

**Target.** Lemma L23, "the conjecture on the subalgebra family, and gradedness as the cap", in [ungraded-slack.md](../findings/ungraded-slack.md). Cited 29 times, cites nothing, never audited.

**VERDICT: PLAUSIBLE**, statement and proof re-derived cold and correct; seven defects in the block as written, two requiring a fix. Full reasoning below, verdict section at the end.

**Footing.** Analysis only. No searches, sweeps or censuses were run. Every number below is hand-derived; the one arithmetic screen is labelled as such.

## Phase plan

1. The two structure-constant identities, derived cold from `conventions.md`.
2. The closed forms for $\theta$ and $S_{\mathfrak{mmm}}$, plus the $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ hand check.
3. The cap, monotonicity, and the four-condition equality chain arrow by arrow.
4. The even-$n$ classification claim and $\mathfrak u(n/2)$; the odd-$n$ case.
5. The "Producing members" criterion and the invariant-dimension count.
6. The "Berger list" paragraph, the verification paragraph, and what the 29 citations actually take.
7. What the record already holds.

## Phase 1, the two structure-constant identities: **both correct**

Conventions used, all quoted from [conventions.md](../findings/conventions.md): the inner product on $\Lambda^2$ is $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$; $c_{abc}=\langle[v_a,v_b],v_c\rangle$ is **totally antisymmetric**, so $T_{abc}=c_{abc}^2$ is **totally symmetric** and vanishes when two indices coincide; sums are over **ordered** tuples; and the Killing marginal is $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$, i.e. $\sum_{\beta,\gamma}T_{\alpha\beta\gamma}=\kappa=2(n-2)$ for every $\alpha$.

**$\kappa=2(n-2)$ verified twice, independently of the record.**

1. *From the Killing form.* $B(X,X)=\mathop{\mathrm{tr}}(\mathrm{ad}_X^2)=-\sum_\beta\lVert[X,v_\beta]\rVert^2$, so $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=-B(v_\alpha,v_\alpha)=-(n-2)\mathop{\mathrm{tr}}(v_\alpha^2)=2(n-2)$, using $\mathop{\mathrm{tr}}(v^2)=-2$ at a unit bivector. Note $\varphi_{ab}=E_{ab}-E_{ba}$ *is already unit* in the $\Lambda^2$ inner product ($\tfrac12\mathop{\mathrm{tr}}(\varphi^{\mathsf T}\varphi)=1$); conventions.md's "$\lVert\varphi_{ab}\rVert^2=2$" is the $n\times n$ Frobenius reading, the factor-2 collision that file itself flags. Taking the Frobenius reading here would double $\kappa$ and rescale everything downstream.
2. *By hand.* $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$, norm$^2=1$; $[\varphi_{12},\varphi_{ab}]=0$ unless $\{a,b\}$ meets $\{1,2\}$ in one index. The nonzero partners are $\varphi_{1c}$ and $\varphi_{2c}$, $c\notin\{1,2\}$, $2(n-2)$ of them, each contributing $1$. So $\kappa=2(n-2)$. ✅

**The subalgebra vanishing.** $\mathfrak h$ a subalgebra $\Rightarrow[\mathfrak h,\mathfrak h]\subseteq\mathfrak h\perp\mathfrak m$, so $c_{abc}=0$ whenever two of $a,b,c$ lie in $\mathfrak h$ and one in $\mathfrak m$. **Total antisymmetry is what makes this slot-independent**: $T_{abc}$ with any two indices in $\mathfrak h$ and one in $\mathfrak m$ vanishes, whichever slot the $\mathfrak m$-index sits in. This is the load-bearing use of the antisymmetry convention.

**Identity 1.** Fix $a\in\mathfrak h$ and split $\sum_{b,c}T_{abc}=\kappa$ by membership: the $(\mathfrak h,\mathfrak m)$ and $(\mathfrak m,\mathfrak h)$ blocks vanish, leaving $T_{a\mathfrak h\mathfrak h}+T_{a\mathfrak m\mathfrak m}=\kappa$. Sum over $a\in\mathfrak h$:
$$S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r,\qquad S_{\mathfrak{hmm}}:=\sum_{a\in\mathfrak h}\sum_{b,c\in\mathfrak m}T_{abc}.$$
Coefficient $1$ on $S_{\mathfrak{hmm}}$ is right: for $a\in\mathfrak h$ there is exactly **one** $(\mathfrak m,\mathfrak m)$ block. ✅

**Identity 2.** Fix $a\in\mathfrak m$: the $(\mathfrak h,\mathfrak h)$ block vanishes, and the $(\mathfrak h,\mathfrak m)$ and $(\mathfrak m,\mathfrak h)$ blocks are two distinct ordered blocks of equal total, each equal (by total symmetry of $T$) to a copy of $S_{\mathfrak{hmm}}$ once summed over $a\in\mathfrak m$. So
$$2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r).$$
**The coefficient $2$ is the ordered-pair convention, not double counting.** With unordered pairs both identities would change, and the pair would become inconsistent; the record's standing "sums are over ORDERED pairs" is exactly what licenses $1$ in the first and $2$ in the second. The asymmetry is real and correct: $S_{\mathfrak{hmm}}$ is defined with the single $\mathfrak h$-index in a *named* slot, so from an $\mathfrak h$-row it is reached once and from an $\mathfrak m$-row twice. ✅

**Both identities: CONFIRMED.**

## Phase 2, the closed forms: **both correct**, and they reproduce the record's independently measured numbers

**The $\#$ normalisation, checked.** For diagonal $W$ in the structure basis, $W^\#_{\alpha\alpha}=\tfrac12\sum_{\gamma\delta}T_{\alpha\gamma\delta}w_\gamma w_\delta$. Anchor: $W=\mathrm{Id}$ gives $\mathrm{Id}^\#=\tfrac12\kappa\,\mathrm{Id}=(n-2)\mathrm{Id}$, the standard Böhm–Wilking value, and at $n=3$ it returns $\mathrm{Id}^\#=\mathrm{Id}$ by direct count. The $\tfrac12$ is right.

**The two block equations are traces, hence necessary.** Averaging $Q(W)_{\alpha\alpha}=\theta w_\alpha$ over $\alpha\in\mathfrak h$ and over $\alpha\in\mathfrak m$ gives exactly the block's two scalar equations, the cross terms dropping by the subalgebra vanishing. *Wording quibble only*: the block says the eigen-equation "splits into" these, which reads as equivalence; it is used only in the $\Rightarrow$ direction, which is all the lemma needs.

**The elimination, redone.** Substituting the identities and writing $\sigma=1+\kappa/2=n-1$, $s=N-r$:
$$\sigma u^2+\tfrac{S_{\mathfrak{hmm}}}{2r}(v^2-u^2)=\theta u,\qquad \sigma v+\tfrac{S_{\mathfrak{hmm}}}{s}(u-v)=\theta .$$
With $v=-ru/s$ these give $\sigma N/s=S_{\mathfrak{hmm}}N^2/(2rs^2)$, i.e. $S_{\mathfrak{hmm}}=2\sigma r(N-r)/N$ and $\theta=\sigma ur/(N-r)$, the block's values exactly.

**Unit norm and the headline form.** $\mathop{\mathrm{tr}}(W^2)=ru^2+sv^2=ru^2N/s=1$, so $u=\sqrt{(N-r)/(rN)}$ and
$$\theta=(n-1)\sqrt{\tfrac r{N(N-r)}}=\tfrac2n\sqrt{\tfrac{rN}{N-r}},$$
the two agreeing because $N=n(n-1)/2$. ✅ **Back-substitution** gives $S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}=(N-r)\big[2(n-2)-\tfrac{4(n-1)r}N\big]$. ✅

**Hand check at $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$.** $r=2\binom{n/2}2=n(n-2)/4$, so $N-r=n^2/4$, $rN/(N-r)=(n-1)(n-2)/2$, and $\theta=\tfrac2n\sqrt{(n-1)(n-2)/2}=\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$ **exactly**. And $2(n-2)-4(n-1)r/N=2(n-2)-8r/n=0$, so $S_{\mathfrak{mmm}}=0$, as a symmetric pair must give. ✅ *This is a genuine check rather than a restatement: $\theta_0(n)$ enters from [problem.md](../findings/problem.md) and the structure-constant route reproduces it.*

**Two further checks against numbers the record measured by a different route.** Using my derived $S_{\mathfrak{mmm}}=\tfrac2n(N-r)[n(n-2)-4r]$: $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ at $n=8$ gives $15\cdot(12-13)=-15$; $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ at $n=12$ gives $35\cdot(20-\tfrac{62}3)=-23.33$. Both match [nondegeneracy.md](../findings/nondegeneracy.md) digit for digit. ✅

**Closed forms: CONFIRMED.** *And note the derivation never uses that $W_{\mathfrak h}$ is a Weyl tensor*, only the two trace equations. The lemma is therefore stronger than its surrounding text suggests.

## Phase 3, cap, monotonicity, equality chain: **correct**, with one arrow silently omitted

- **Cap.** $S_{\mathfrak{mmm}}$ is a sum of squares, so $\ge0$; with $N-r>0$ this is $n(n-2)-4r\ge0$, i.e. $r\le n(n-2)/4$. ✅ Equality iff $r=n(n-2)/4$ **exactly** (the factor $N-r$ never vanishes on $0<r<N$).
- **Monotonicity and the second branch.** $\theta^2=\tfrac4{n^2}\cdot\tfrac{rN}{N-r}$; $r\mapsto r/(N-r)$ is a Möbius map with its only pole at $r=N$, strictly increasing on the whole of $(0,N)$ and non-negative there. So $\theta$ is a strictly increasing bijection of $(0,N)$ onto $(0,\infty)$. **There is no second branch**, $\theta\le\theta_0\iff r\le n(n-2)/4$, and equality transfers both ways. ✅
- **The four-condition chain, arrow by arrow.**

| arrow | status |
|---|---|
| $r=$ cap $\iff S_{\mathfrak{mmm}}=0$ | one line from the closed form; needs the hypothesis $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ |
| $S_{\mathfrak{mmm}}=0\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ | one line: a sum of squares vanishes iff $\langle[\varphi_a,\varphi_b],\varphi_c\rangle=0$ for all $a,b,c\in\mathfrak m$, i.e. $[\mathfrak m,\mathfrak m]\perp\mathfrak m$ |
| $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\iff$ symmetric pair | **needs $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, which the block never states.** It is one line, ad-invariance gives $\langle[\mathfrak h,\mathfrak m],\mathfrak h\rangle=-\langle\mathfrak m,[\mathfrak h,\mathfrak h]\rangle=0$, but it is the chain's only non-immediate step and it is missing |
| symmetric pair $\iff W_{\mathfrak h}$ is $\mathbb Z_2$-graded | **definitional** in the sense L23 is tagged with. [graded-half.md](../findings/graded-half.md)'s labelling table assigns L23 sense **(C)**, pair-graded, in which this arrow unwinds a definition. It is *not* free in sense (A) or (B) generally; here it happens to be, because $W_{\mathfrak h}$ has no kernel and $E_\pm=\mathfrak h,\mathfrak m$ exactly |

  So of the four displayed equivalences, one is a computation, one is a one-line sum-of-squares fact, one is a one-line omission, and one is a definition. **The block presents all four as if equally substantive.** That is presentational, not an error.
- **Cross-check the block's own concession.** With $N=n(n-1)/2$, $S_{\mathfrak{mmm}}=\tfrac2n(N-r)[n(n-2)-4r]$ and $S=\tfrac r{nN}[4(N-r)-n^2]=\tfrac r{nN}[n(n-2)-4r]$, so $S=S_{\mathfrak{mmm}}\cdot\tfrac r{2N(N-r)}$ with a strictly positive factor. **The two are literally proportional on this family**, so "the cap is the graded compression inequality restricted here, a re-derivation and a cross-check rather than independent leverage" is exactly right and I confirm it. ✅

**Phase 3: CONFIRMED**, with the $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ step owed.

## Phase 4, the even-$n$ equality case: **true, proof incomplete at $n=8$**

**Where $\mathfrak u(n/2)$ actually goes.** The brief's suspicion is right that the block's handling is thin, but there is no contradiction.

- $\dim\mathfrak u(m)=m^2$ against the cap $m(m-1)$ at $n=2m$, so $\mathfrak u(m)$ **exceeds** the cap by exactly $m$, for every $m\ge1$. [nondegeneracy.md](../findings/nondegeneracy.md) and [bounds.md](../findings/bounds.md) both record the overshoot as $m$; I get the same.
- $(\mathfrak{so}(2m),\mathfrak u(m))$ *is* a symmetric pair, so its true $S_{\mathfrak{mmm}}$ is $0$ while the lemma's closed form would return a negative number. **The resolution is that L23 is a conditional**: $Q(W_{\mathfrak u(m)})=\theta W_{\mathfrak u(m)}$ simply fails. Concretely, a symmetric pair has $S_{\mathfrak{hmm}}=\kappa(N-r)/2=(n-2)(N-r)$, while criticality forces $S_{\mathfrak{hmm}}=2(n-1)r(N-r)/N$; the two agree **iff** $r=n(n-2)/4$. So *every* symmetric pair off the balanced split is non-critical in this construction, $\mathfrak u(m)$ included. ✅ No contradiction, and the cap is not violated.
- **Where the exclusion happens.** For $\mathfrak u(m)$ it is genuinely the fourth-form condition: $(\mathrm{Sym}^2\mathbb R^{2m})^{U(m)}=\mathbb R\,\mathrm{Id}$ **holds**, but $\omega\wedge\omega\in(\Lambda^4\mathbb R^{2m})^{U(m)}$ is nonzero for $m\ge2$, so $W_{\mathfrak u(m)}$ fails Bianchi and is not a Weyl operator. The block's "Berger list" sentence is right *for this member*. ✅

**The classification argument, redone.**

- $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, $p+q=n$: $r=\binom p2+\binom q2=(p^2+q^2-n)/2=(n^2+d^2-2n)/4$ with $d=p-q$, so $r-\text{cap}=d^2/4$. Equality iff $p=q$. ✅ (Same identity as [nondegeneracy.md](../findings/nondegeneracy.md)'s $(2p-n)^2=0$.)
- $\mathfrak u(m)$: $r-\text{cap}=m>0$. ✅
- **THE GAP: the list is incomplete at $n=8$, and the block never says so.** The block writes "Among symmetric pairs, $\binom p2+\binom q2=n(n-2)/4$ … and $\mathfrak u(m)\subset\mathfrak{so}(2m)$ has $r=m^2\ne m(m-1)$", i.e. it takes $\{\mathfrak{so}(p)\oplus\mathfrak{so}(q),\ \mathfrak u(m)\}$ as the complete list of symmetric subalgebras of $\mathfrak{so}(n)$. That is right exactly when $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$, which **fails at $n=8$**, the record states this itself in [graded-half.md](../findings/graded-half.md), "The enumeration this record has been quoting is complete only for $n\ne8$". So the argument as written does not cover $n=8$, which is the very dimension the record flags as exceptional and the smallest even $n$ where the equality case has an interesting proof.
  - **The gap closes, from the record's own table.** The two triality classes at $n=8$ are $\mathfrak{spin}(7)$ ($r=21$) and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ ($r=13$); the cap is $12$; neither is $12$. I checked the remaining worry independently, that the *triality image* of $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ might be a second, non-$O(8)$-conjugate subalgebra of dimension exactly $12$. It is not: $\mathfrak{so}(4)\oplus\mathfrak{so}(4)=\mathfrak{su}(2)^{\oplus4}$ acts on the vector rep as $(2,2,1,1)\oplus(1,1,2,2)$ and on $S^+$ as $(2,1,2,1)\oplus(1,2,1,2)$, which is again a block-diagonal $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ for a different splitting $\mathbb R^8=\mathbb R^4\oplus\mathbb R^4$, hence $O(8)$-conjugate to the original. **So the conclusion survives; the block owes one sentence.**
- **Odd $n$.** $n$ odd $\Rightarrow n(n-2)$ odd $\Rightarrow n(n-2)/4\notin\mathbb Z$, so $r<n(n-2)/4$ strictly and $\theta<\theta_0(n)$ strictly. **There is no equality case at odd $n$, and the block says exactly that.** ✅ *No exposure to the $\Theta_n$ odd-row trap*: L23 uses $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ throughout and never $\Theta_n$.

## Phase 5, the "Producing members" criterion: **logic sound, one hypothesis missing**

**The dimension count, done independently.** $Q$ is $O(n)$-equivariant, hence $K$-equivariant, and preserves $\mathcal W_n$. If $\mathcal W_n^K=\mathbb R\,W_{\mathfrak h}$ with $W_{\mathfrak h}\ne0$, then $Q(W_{\mathfrak h})\in\mathcal W_n^K=\mathbb R\,W_{\mathfrak h}$, so $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$. That is the whole argument and it is valid. What has to be checked is the "$=1$".

- $\Lambda^2\mathbb R^n=\mathfrak h\oplus\mathfrak m$ as $K$-modules. If both are $K$-irreducible **and non-isomorphic**, the space of $K$-invariant self-adjoint operators is $\mathrm{Sym}\,\mathrm{End}_K(\mathfrak h)\oplus\mathrm{Sym}\,\mathrm{End}_K(\mathfrak m)$. For an irreducible real module $\mathrm{End}_K$ is $\mathbb R$, $\mathbb C$ or $\mathbb H$, and in every case its self-adjoint part is $\mathbb R$ (the extra generators are orthogonal complex structures, hence skew). So the invariant space is exactly $\mathrm{span}\{\Pi_{\mathfrak h},\Pi_{\mathfrak m}\}=\mathrm{span}\{\Pi_{\mathfrak h},\mathrm{Id}\}$, **dimension $2$**, whose traceless part is the single line $\mathbb R\,W_{\mathfrak h}$. **That is exactly what the brief asks about, and it is what the block claims.** ✅
- $\mathrm{Id}$ is not Ricci-flat, so it is not in $\mathcal W_n$; hence $\mathcal W_n^K$ is at most that line, and it contains $W_{\mathfrak h}$ once conditions (F2) and (F3) put $W_{\mathfrak h}$ in $\mathcal W_n$.
- **(F2) $\Rightarrow$ Ricci-flat, checked and it is not automatic-looking but is exact.** $\mathrm{Ric}(W_{\mathfrak h})$ is $K$-invariant, so $=\lambda\,\mathrm{Id}$ by (F2). The trace contraction gives $\mathop{\mathrm{tr}}\mathrm{Ric}(R)=2\mathop{\mathrm{tr}}(R)$ (anchor: $R=\mathrm{Id}$ has $\mathrm{Ric}=(n-1)\mathrm{Id}$, and $n(n-1)=2N$), so $\mathrm{Ric}(\Pi_{\mathfrak h})=\tfrac{2r}n\mathrm{Id}$ and $\mathrm{Ric}(\tfrac rN\mathrm{Id})=\tfrac rN(n-1)\mathrm{Id}=\tfrac{2r}n\mathrm{Id}$. **They cancel identically.** ✅
- **(F3) $\Rightarrow$ Bianchi-free**: $\mathrm{Alt}$ is equivariant with image in $\Lambda^4$, so $\mathrm{Alt}(W_{\mathfrak h})\in(\Lambda^4\mathbb R^n)^K=0$. ✅

> **DEFECT D1, the hypothesis $\mathfrak h\not\cong\mathfrak m$ as $K$-modules is missing from both the Statement and the "Producing members" paragraph, in [ungraded-slack.md](../findings/ungraded-slack.md) and in [results.md](../results.md), although the block's own verification paragraph says Reviewer 25 supplied it.** [REVIEW_r25.md](REVIEW_r25.md), Correction 3, reads: *"two hypotheses were unstated: $0<r<N$ … and $\mathfrak h\not\cong\mathfrak m$ as $K$-modules."* Only the first was folded in. Without it the invariant space can be $3$-dimensional (an intertwiner $\mathfrak h\to\mathfrak m$ contributes a symmetric off-block piece), the traceless part $2$-dimensional, and **the criterion certifies criticality that need not hold**, it is unsound as written, not merely imprecise. *The exposure is narrow: $\mathfrak h\cong\mathfrak m$ forces $r=N/2>n(n-2)/4$, so no such certificate could ever be correct, but that is an argument the block does not make, and it runs through L23's own cap, which the criterion is upstream of.* **This is a recording failure, not a mathematical one: the fix is one clause the record already owns.**

**Minor: the $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ remark undercounts.** The block says connected $K$ "fails two of the three conditions"; $K^0=SO(4)\times SO(4)$ fails **all three**, $\mathfrak h$ splits into four $3$-dimensional pieces (F1); $(\mathrm{Sym}^2\mathbb R^8)^{K^0}=\mathrm{span}\{\mathrm{Id}_4\oplus0,\ 0\oplus\mathrm{Id}_4\}$ is $2$-dimensional (F2); and $e_{1234},e_{5678}$ are invariant (F3). The miscount is inherited verbatim from [REVIEW_r25.md](REVIEW_r25.md)'s Correction 1, which names only (F1) and (F3). The *repair* is right and I verified it: under $K=(O(4)\times O(4))\rtimes\mathbb Z_2$ the reflections kill both volume forms and both block identities, the swap makes $\mathfrak h=\Lambda^2\mathbb R^4\oplus\Lambda^2\mathbb R^4$ irreducible, $\mathfrak m=\mathbb R^4\otimes\mathbb R^4$ is irreducible, and $\dim\mathfrak h=12\ne16=\dim\mathfrak m$ so D1's missing hypothesis holds here. ✅

## Phase 6, the "Berger list" paragraph: **two false claims and a self-contradictory corollary**

This paragraph is not part of the Statement or the Proof, but it is inside the block, it is stated in the record's assertive voice, and it is wrong in three places.

> **DEFECT D2, "Each carries a parallel $4$-form, so the third condition says precisely that $\mathfrak h$ is not a special-holonomy algebra" is FALSE for two of the five items the sentence quantifies over.**
>
> The list is $\mathfrak g_2$, $\mathfrak{spin}(7)$, $\mathfrak{so}(n-1)\subset\mathfrak{so}(n)$, $\{\mathfrak u(m),\mathfrak{su}(m),\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)\}$, "together with the unbalanced splits". For the last two named items the $\Lambda^4$ condition is **vacuously satisfied**, so it excludes nothing:
> - **Unbalanced splits.** $K=N_{O(n)}(\mathfrak{so}(p)\oplus\mathfrak{so}(q))\supseteq O(p)\times O(q)$, and $\Lambda^4(\mathbb R^p\oplus\mathbb R^q)=\bigoplus_{a+b=4}\Lambda^a\mathbb R^p\otimes\Lambda^b\mathbb R^q$. $(\Lambda^a\mathbb R^p)^{O(p)}=0$ for every $a\ge1$, including $a=p$, where the volume form is reversed by a reflection. So $(\Lambda^4\mathbb R^n)^K=0$ for **every** $p,q$. Condition (F3) holds at $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, at $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$, everywhere.
> - **$\mathfrak{so}(n-1)\subset\mathfrak{so}(n)$.** $K=O(n-1)\times O(1)$; the same count gives $(\Lambda^4\mathbb R^n)^K=0$ for all $n$.
>
> **What actually excludes them is (F2), not (F3)**: $(\mathrm{Sym}^2\mathbb R^n)^K$ is $2$-dimensional in both cases, because the two block identities are separately invariant. [bounds-relaxations.md](../findings/bounds-relaxations.md) states this correctly, *"$(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$ … **fails for unbalanced splits** because the two block projections are separately invariant"*, with measured Ricci residuals $0.474$, $0.359$, $0.288$, **so the L23 block contradicts a sibling findings file on which hypothesis does the work.** The sentence's origin is [REVIEW_r25.md](REVIEW_r25.md)'s "One framing worth adopting", whose own list omitted $\mathfrak{so}(n-1)$ and the splits; the block added them and kept the "each carries a parallel $4$-form" clause.

> **DEFECT D3, $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ does not exceed the cap for $m\ge3$.** *Arithmetic screen, seconds, on objects constructed for the check; reported as a screen.* $r=m(2m+1)+3$ against $\text{cap}=m(4m-2)$ at $n=4m$: $m=1$ gives $6>2$, $m=2$ gives $13>12$, and then $m=3$ gives $24<30$, $m=4$ gives $39<56$, $m=5$ gives $58<90$, widening thereafter. So the claim "the subalgebras that exceed the cap are … $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$" is true only at $m\le2$. (The same screen confirms $\mathfrak{su}(m)$ at $m^2-1$ and $\mathfrak u(m)$ at $m^2$ exceed $m(m-1)$ for every $m\ge2$, and that $\mathfrak{sp}(m)$ alone (absent from the block's list), exceeds only at $m=1$.) **This does not damage the lemma**: $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ is still excluded, by its Kraines $4$-form, i.e. by (F3). It damages the paragraph's claim to be a *characterisation*.

> **DEFECT D4, the "Lie-theoretic bound" corollary is self-contradictory.** *"An irreducible non-special-holonomy subalgebra of $\mathfrak{so}(n)$ has dimension at most $n(n-2)/4$, with equality only for the balanced split."* **$\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ acts reducibly on $\mathbb R^n$**, preserving the two $\mathbb R^{n/2}$ summands is what it is, so under the corollary's own hypothesis the equality case is empty. The slip is a substitution of one notion of irreducibility for another: the criterion asks for $\mathfrak h$ and $\mathfrak m$ to be irreducible **as $K$-modules inside $\Lambda^2\mathbb R^n$**, which the balanced split satisfies (via the block swap), while the corollary reads it as $\mathfrak h$ acting irreducibly **on $\mathbb R^n$**, which it does not. The corollary also silently drops (F1) and (F2) from the hypotheses. Inherited from [REVIEW_r25.md](REVIEW_r25.md) verbatim.

## Phase 7, what rests on numbers, and what the 29 citations take

**Nothing in the Statement or Proof rests on the script.** I reconstructed every step by hand from [conventions.md](../findings/conventions.md): the two identities, the $\#$ normalisation, the elimination, the unit-norm reduction, the cap, the monotonicity, the four-condition chain and the classification. [p5_casimir_family.py](../scripts/lib/p5_casimir_family.py) is a check, correctly labelled as one. **"Reviewer 25 … found no counterexample" is the one sentence that reads as evidence and is not**, a failed search is not a proof, and the corrections r25 *did* supply are the load-bearing part of that paragraph. Two of the three corrections landed (normaliser, $0<r<N$, odd-$n$ strictness); the third (D1) did not.

**The block's concession is understated in one direction and accurate in the other.** I verified $S=S_{\mathfrak{mmm}}\cdot\tfrac r{2N(N-r)}$: on this family the compression slack and $S_{\mathfrak{mmm}}$ are **the same inequality up to a positive factor**, so "a sum-of-squares re-derivation and a cross-check rather than independent leverage" is if anything generous, they are one inequality, not two that agree.

**Is that consistent with 29 citations?** The 29 mentions across [findings/](../findings/), [results.md](../results.md), [ATTEMPTS.md](../ATTEMPTS.md) and [plan-verification.md](../plan-verification.md) split as follows, and **none of them treats L23 as independent leverage on the crux**:

| consumer | what it takes | sound? |
|---|---|---|
| [bounds-relaxations.md](../findings/bounds-relaxations.md), Lemma L105 | derives the **same cap** $r\le n(n-2)/4$ from $t_{222}\ge0$, "with no sum of squares, no Lie theory and no hypothesis that $E_+$ is closed under bracket" | **yes, and it is corroboration**: an independent route to L23's cap, which raises my confidence in the closed form |
| [fence-posts.md](../findings/fence-posts.md), post F40 | proves the $\dim E_+$ **extension** of L23's bound false | sound; a correct negative use |
| [support-dichotomy.md](../findings/support-dichotomy.md) | records that extending the cap off the family via $S_{\mathfrak{mmm}}$ "misreads L23, where $S_{\mathfrak{mmm}}\ge0$ **is** the cap" | **the record already carries my Phase-3 finding**, in the same words |
| [nondegeneracy.md](../findings/nondegeneracy.md) | uses the equality case to show $\{S=0\}$ collapses to the cap on the family, then states the reach: *"true and … nearly a tautology"* | sound and self-limiting |
| [bounds.md](../findings/bounds.md) | uses the family to turn the $\Pi$-bound's equality case into "$(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair" | sound |
| [graded-half.md](../findings/graded-half.md) | tags L23 sense **(C)** and warns it transfers to sense (A) only on this family | sound, and it is the caveat Phase 3 wants |
| [results.md](../results.md) | statement, index rows, and "the family excludes every frontier point" | sound |

**The section immediately after L23 does not undercut it.** "The graded critical set is strictly wider than the subalgebra family" is a statement about the *converse* direction (that $\{S=0\}$ is bigger than the family) while L23 quantifies only over the family. $S^5\times S^7$ is the sharpest case: $r=31$ against a cap of $30$ at $n=12$, so it is graded and critical and **not** a member, which is exactly what L23 predicts for a symmetric pair off the balanced split. **The two are consistent, and the later section is the honest statement of L23's reach.**

**One cross-file number I could not reconcile, flagged for a successor.** [nondegeneracy.md](../findings/nondegeneracy.md) reports "its slack is $140$" at $\mathfrak{so}(5)\subset\mathfrak{so}(10)$ by the adjoint ($r=10$, $N=45$). L23's closed form gives $S_{\mathfrak{mmm}}=35[16-8]=280$, and the compression slack $S=\tfrac r{nN}[4(N-r)-n^2]=\tfrac{40}{450}=0.889$. $140$ is exactly $S_{\mathfrak{mmm}}/2$, which is the shape of the ordered/unordered collision [conventions.md](../findings/conventions.md) warns about. **This is a defect in the consumer, not in L23**, L23's own formula reproduces [nondegeneracy.md](../findings/nondegeneracy.md)'s other two measured values ($-15$ and $-23.33$) exactly, but the factor of $2$ should be chased.

## VERDICT: PLAUSIBLE

**The mathematics is right and I re-derived all of it cold.** Both structure-constant identities, the coefficients $1$ and $2$ on $S_{\mathfrak{hmm}}$, $\kappa=2(n-2)$ (twice, from the Killing form and by hand), the $\tfrac12$ in $W^\#$, $\theta=\tfrac2n\sqrt{rN/(N-r)}$, $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-\tfrac{4(n-1)r}N]$, the cap, strict monotonicity with no second branch, the four-condition chain, the $(p-q)^2=0$ classification and $\mathfrak u(m)$'s overshoot of $m$, the odd-$n$ strictness, and the $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ hand check landing on $\theta_0(n)$ exactly. The derived $S_{\mathfrak{mmm}}$ reproduces two numbers the record measured by a different route. **No step of the Statement or Proof is wrong.**

**It is PLAUSIBLE rather than CONFIRMED because the argument as written has gaps, and the block carries claims that are false:**

| # | defect | severity |
|---|---|---|
| **D1** | $\mathfrak h\not\cong\mathfrak m$ as $K$-modules is **missing** from the Statement and from "Producing members", in both [ungraded-slack.md](../findings/ungraded-slack.md) and [results.md](../results.md), although the block's own verification paragraph says [Reviewer 25](REVIEW_r25.md) supplied it. Without it the criterion is **unsound**, certifying criticality on a $2$-dimensional invariant space | **fix required** |
| **D2** | "Each carries a parallel $4$-form, so the third condition says precisely that $\mathfrak h$ is not a special-holonomy algebra" is **false** for $\mathfrak{so}(n-1)\subset\mathfrak{so}(n)$ and for every unbalanced split, where $(\Lambda^4\mathbb R^n)^K=0$ identically. The operative hypothesis there is (F2), as [bounds-relaxations.md](../findings/bounds-relaxations.md) states correctly, so two findings files disagree | **fix required** |
| **D3** | $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ is listed as exceeding the cap; it does so only for $m\le2$ ($24<30$ at $m=3$) | correction |
| **D4** | the "Lie-theoretic bound" corollary is **self-contradictory**, its equality case, the balanced split, is reducible on $\mathbb R^n$ and so fails the corollary's own irreducibility hypothesis; it also drops (F1) and (F2) | withdraw or restate |
| **D5** | the symmetric-pair classification used in the equality case is **incomplete at $n=8$**, where $\mathrm{Aut}(\mathfrak{so}(8))\supsetneq PO(8)$. The conclusion survives, the triality classes have $r=21$ and $r=13$, and I checked the triality image of $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ is $O(8)$-conjugate to it, but the block owes the sentence, and [graded-half.md](../findings/graded-half.md) already holds the table | one sentence |
| **D6** | $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, the only non-immediate arrow of the four-condition chain, is never stated. One line from ad-invariance | one line |
| **D7** | "splits into the two scalar equations" reads as equivalence; the two equations are traces, hence necessary only, which is all the lemma uses | wording |

**None of D1–D7 touches the Statement's truth.** D1 and D2 are the two that must be fixed, D1 because it makes a stated criterion unsound and D2 because it puts this file in contradiction with [bounds-relaxations.md](../findings/bounds-relaxations.md). Every repair is already somewhere in the record.

*Analysis-only footing observed. The only computation was the Phase-6 dimension screen (`sp(m)+sp(1)`, `su(m)`, `u(m)` against the cap), seconds of arithmetic on objects constructed for the check, reported as a screen and used only to falsify a recorded claim.*
