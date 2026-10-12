# Review r503, Lemma L8, the graded case reduced to a finite check

**Target.** [findings/graded-half.md](../findings/graded-half.md), the block `#### Lemma L8` at line 383, down to the next heading. Read verbatim first, then derived cold.

**Which claim I judged.** Not the sentence the block's own third line already retracts ("a graded critical point is pinned by its pair's dimensions"). I judged the claim that **survives** that retraction, as the block states it:

> *An **equivariant** graded critical point on a compact symmetric pair $(\mathfrak{so}(n),\mathfrak k)$ has $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$ with $p=\dim\mathfrak k$, $q=\dim\mathfrak m$ and $c_{\mathfrak k}$ a tabulated Casimir ratio; the compact symmetric pairs being classified, the equivariant graded case is a finite check; and running that check over the classical families settles it there, sphere products, balanced and unbalanced alike, exceed the rival maximizer's value and are provably defect-free for every dimension and every split, everything else falling below or not existing.*

**VERDICT: REFUTED.** The pinning identity and the defect claim are both correct (one proved symbolically here, one by a one-line argument that is genuinely a proof). The clause **"Sphere products, balanced and unbalanced alike, exceed the rival maximizer's value" is false**, and the sweep the words "settles it there" point at never evaluated the cases that decide it.

**Analysis-only footing observed.** Everything below is derived by hand. One screen was run (exact-rational arithmetic on the closed form, seconds of compute, on objects I constructed) and it is reported as a screen confirming a hand derivation, never as the evidence.

---

## 1. What survives the refutation, in one sentence

> **Let $(\mathfrak{so}(n),\mathfrak k)$ be a compact symmetric pair with $\mathfrak k$ acting on $\mathfrak m=\mathfrak k^\perp$ with a *single* Casimir $c_{\mathfrak k}$ (i.e. $\mathfrak k$ simple, or its ideals interchanged by a symmetry of the pair), and let $W$ be the pair's $\mathrm{ad}(\mathfrak k)$-equivariant critical point. Then $\theta(W)=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$, $p=\dim\mathfrak k$, $q=\dim\mathfrak m$.**

Three hypotheses, of which the block states one. *Equivariant* it states. **The single-Casimir hypothesis it does not state**, and that hypothesis is exactly what the sweep behind "settles it there" screened on, see §5 and §6. And the pair being $(\mathfrak{so}(n),\mathfrak k)$ rather than an abstract symmetric pair it states only in [results.md](../results.md) line 340, not here.

## 2. The label the row is entitled to

| where | what it says |
| --- | --- |
| the block, line 3 | `SCOPE REFUTED` … *"Candidate, Gate 2 owed"* |
| [INDEX-results.md](../findings/INDEX-results.md) row 8 | `Lemma`, bare, no scope note, no Gate-2 note |
| [INDEX-results.md](../findings/INDEX-results.md) header | *"Labels are literal. **Lemma** is proven, Gate 1 and Gate 2 passed."* |

**The row is not entitled to `Lemma`.** By the record's own literal convention a result whose block says "Gate 2 owed" cannot carry it, and every neighbouring row (1, 10, 11, 15, 16, …) carries its Gate-2 status in the cell. Row 8 is the only row on that page whose block says *candidate* and whose cell says *Lemma* with nothing attached.

**What it should read.** The block holds two claims of different status and the row should say so, as row 18 already does for [L18](../findings/problem.md):

- the **pinning identity**, analytic, and I re-derive it in §4; it has never been through Gate 2, so `Lemma` is premature and `Conjecture` understates it. The honest cell is `Lemma` **with** *"Gate 2 owed; scope refuted, pins the pair's equivariant point only, and only where $\mathfrak k$ acts on $\mathfrak m$ with a single Casimir"*.
- the **"settled across the classical families"** half, refuted in §5, and in any case a numerical sweep at named dimensions, i.e. `Observation` at best.

## 3. The 19 citations, triaged

I found **17 sites naming L8 in the canonical record** ([results.md](../results.md) and [findings/](../findings/)); the balance of the 19 are in [reviews/](.). **Zero citations in [plan.md](../plan.md), [routes.md](../routes.md), [ATTEMPTS.md](../ATTEMPTS.md) or [report/](../report/)**, the blast radius is smaller than the count suggests.

**Three sites are broken. The rest are safe, and most of them state the scope correctly.**

| # | site | relies on | verdict |
| --- | --- | --- | --- |
| 1 | [results.md:124](../results.md#L124) | equivariant | **safe**, scoped in its first clause |
| 2 | [results.md:340](../results.md#L340) | equivariant | **safe**, see §7, this copy is *better* than the canonical one |
| 3 | [results.md:366](../results.md#L366) | equivariant | **safe**, *"settles the equality side over the equivariant graded points"* |
| 4 | [results.md:530](../results.md#L530) | equivariant | **scope-safe, warrant broken**, *"the correspondence being Lemma L8"*; L8 assumes that correspondence (§4) |
| 5 | [findings/INDEX.md:20](../findings/INDEX.md#L20) | equivariant | **safe**, states the scope and *"Candidate, Gate 2 owed"* |
| 6 | [findings/INDEX-results.md:83](../findings/INDEX-results.md#L83) | (| **safe**), the L69 row, which flags the credit |
| 7 | **[findings/ungraded-slack.md:285](../findings/ungraded-slack.md#L285)** | **every graded point** | **BROKEN**, see below |
| 8–10 | [findings/LEDGER.md:266](../findings/LEDGER.md#L266), [:485](../findings/LEDGER.md#L485), [:489](../findings/LEDGER.md#L489) | (| **safe**), these record the defect |
| 11 | [graded-half.md:222](../findings/graded-half.md#L222) | equivariant | **safe**, *"L8 does not extend off it"* |
| 12 | [graded-half.md:248](../findings/graded-half.md#L248) | (C) label | safe |
| 13 | **[graded-half.md:252](../findings/graded-half.md#L252)** | **(B) label** | **BROKEN**, see below |
| 14 | [graded-half.md:273](../findings/graded-half.md#L273) | (C) label | safe |
| 15 | [graded-half.md:333](../findings/graded-half.md#L333) | (| safe), the correction box |
| 16 | [graded-half.md:354](../findings/graded-half.md#L354) | (C) label | safe, but see #13, it claims a fix that was not applied |
| 17 | **[graded-half.md:379](../findings/graded-half.md#L379)** | **L8 supplying the correspondence** | **BROKEN** |

### Broken 1, [findings/ungraded-slack.md:285](../findings/ungraded-slack.md#L285), an unrepaired twin

> *"Lemma L7 splits the critical points by whether its inequality is an equality; **Lemma L8 settles the equality side across the classical families.**"*

Its twin at [results.md:366](../results.md#L366) is the same sentence with *"over the equivariant graded points"* substituted for *"across the classical families"*. **The repair was applied to one copy of a duplicated sentence and not the other.** As written, ungraded-slack.md asserts the refuted scope: L7's equality side is *every* graded critical point, and L8 settles only the equivariant ones. Fix: copy results.md:366's wording across.

### Broken 2, [graded-half.md:252](../findings/graded-half.md#L252) contradicts [:354](../findings/graded-half.md#L354), and the contradiction is load-bearing

The (B) bullet still reads *"This is what [Lemma L8] and the C3 route use"*, while the labelling table 100 lines below says L8 is **(C)** and that *"an earlier version of the definitions block called it (B) in the adjacent bullet; that is the labelling table's own inconsistency, found by [r317](REVIEW_r317.md) and corrected here."* **The correction was written down and not made.** [r317](REVIEW_r317.md) found exactly this and it is still there.

**This is not cosmetic, it decides whether the block's own `SCOPE REFUTED` is valid.** Under **(C)**, a graded point is by definition the $\mathrm{ad}(\mathfrak p)$-invariant tensor of a pair, so "graded" *already means* equivariant, the counterexample (which [r318](REVIEW_r318.md) §69 certifies is **(A) and not (C)**) is outside L8's scope, and there is nothing to refute, but then L8 says nothing whatever about the graded half, since [item C3](../plan.md) is about the non-(C) points. Under **(B)**, the witness bites and the refutation stands. **The block cannot have both**: it is labelled (C) at line 354 and refuted at line 387 by a witness that only a (B) reading admits.

### Broken 3, [graded-half.md:379](../findings/graded-half.md#L379), the false credit that survived its own correction

> *"The one hypothesis that is this project's own … is the correspondence equivariant graded critical point $\leftrightarrow$ compact symmetric space; **[Lemma L8] supplies it** and is scoped to exactly the equivariant points."*

Forty-six lines above, **inside the same L69 block**, sits the correction box: *"THE FIRST VERSION CREDITED THIS SENTENCE TO LEMMA L8, **WHICH ASSUMES IT**."* [LEDGER.md:489](../findings/LEDGER.md#L489) records the repair as *"applied"*. **It was applied to L69's opening sentence and not to L69's "What it inherits" paragraph**, so the same false credit stands 46 lines later in the same block. This is the defect [r501](REVIEW_r501.md)/[r502](REVIEW_r502.md) reported, still live at its second site. Fix: replace with *"the invariant count in the proof above supplies it, needing no classification"*.

## 4. The reduction, L8 assumes "graded $\Rightarrow$ symmetric pair", it does not prove it

**Confirmed independently, and stated plainly because [L69](../findings/graded-half.md) was relying on L8 to supply it.**

The block's sentence is *"Since the compact symmetric pairs are classified, the graded case is then a finite check."* Read the quantifiers: the classification is a statement about pairs, and the inference to "the graded case is finite" needs *every graded critical point to be indexed by a pair*. **Nothing in the block derives that.** The pinning formula's own variables are $p=\dim\mathfrak k$ and $q=\dim\mathfrak m$, the pair is an *input*, present in the statement before the argument starts. The whole content is: *given* a pair and *given* equivariance, Schur makes $W$ scalar on each summand and two structure-constant counts pin $\theta$. The implication runs pair $\Rightarrow$ value, never point $\Rightarrow$ pair.

**Where the file does argue toward it, it is a different argument, in a different section, under hypotheses L8 never states**: the Reviewers 30/31 paragraph, *"for a critical point **of the subalgebra family** at $n\ne8$"*, shows $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ makes $\sigma=(+1,-1)$ an involution and Cartan then leaves $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(m)$. That is (i) restricted to the subalgebra family, (ii) restricted to $n\ne8$, (iii) not part of L8, and (iv) **still short of what L8 needs**, because it produces a pair but not the *equivariance* of $W$ for it, which is the second half of the correspondence and the half that carries the Schur step.

**So [L69](../findings/graded-half.md)'s repair was necessary**, and its replacement, the invariant count $\dim\operatorname{End}^{\mathrm{sym}}_K(\Lambda^2)-\operatorname{rank}(\mathrm{Alt})-\operatorname{rank}(\mathrm{Ric})=1$, is the right shape, since it runs the implication in the direction L8 never did.

## 5. "Running it over the classical families settles it there", the two words carrying the weight

### 5a. The closed form settles the first claim outright, by refuting it

The record holds $\theta(S^p\times S^q)^2=\dfrac{2(n-1)(p-1)(q-1)}{(n-2)pq}$, $p+q=n$ ([problem.md:511](../findings/problem.md#L511), contributed by [r500](REVIEW_r500.md) at audit; [LEDGER.md:472](../findings/LEDGER.md#L472)). **I checked it before using it**, four ways, all by hand: it returns $\theta_0(n)^2=2(n-1)(n-2)/n^2$ at $p=q=n/2$ and $2(n-1)(n-3)/((n+1)(n-2))$ at $p,q=\tfrac{n\mp1}2$, matching [conventions.md](../findings/conventions.md)'s $\Theta_n$; and it reproduces **all four** exact rationals the Gate-2 block records for $n=12$, $\tfrac{176}{135},\tfrac{231}{160},\tfrac{264}{175},\tfrac{55}{36}$ at splits $3{+}9,\,4{+}8,\,5{+}7,\,6{+}6$. It is trustworthy.

**Now read those four rationals against the rival maximizer's $\theta^2=\tfrac32$:**

| split at $n=12$ | $\theta^2$ | $\theta$ | vs $\sqrt{3/2}=1.224745$ |
| --- | --- | --- | --- |
| $S^3\times S^9$ | $176/135=1.30370$ | $1.14179$ | **below** |
| $S^4\times S^8$ | $231/160=1.44375$ | $1.20156$ | **below** |
| $S^5\times S^7$ | $264/175=1.50857$ | $1.22824$ | above |
| $S^6\times S^6$ | $55/36=1.52778$ | $1.23603$ | above |

**Two of the record's own four recorded rationals sit below the rival maximizer.** The sentence *"Sphere products, balanced and unbalanced alike, exceed the rival maximizer's value"* is false, and false at the very dimension the conjecture is stated from. It is also false for **every** balanced product below $n=11.29$: $\theta_0(n)^2>\tfrac32\iff n^2-12n+8>0\iff n>6+2\sqrt7$, which is [fence post 7](../findings/INDEX-traps.md)'s crossover, so the block contradicts a standing fence post of this record.

**And the closed form settles the claim positively as well.** With $a=p-1$, $b=q-1$, $s=a+b$, $m=ab$:
$$\theta^2>\tfrac32\iff 4m(s+1)>3s(m+s+1)\iff m(s+4)>3s(s+1).$$
At $p=4$ this reads $3b(b+7)>3(b+3)(b+4)$, i.e. $0>12$, **impossible at every $q$**. At $p=5$ it reads $b^2+5b-60>0$ with $b=n-6$, i.e. $n^2-7n-54\ge0$, i.e. $n\ge12$. So

> **A sphere product exceeds the rival maximizer iff $p,q\ge5$ and $n\ge12$.**

$n^2-7n-54$ is [L69](../findings/graded-half.md)'s own inequality, reached there from $\lVert W\rVert^2\le\tfrac16$ rather than from $\theta$. **The two routes agree identically**, a real cross-check, and it means L69's statement is the correct version of the sentence L8 gets wrong.

*Screen (seconds, exact rationals, on objects I built): the four $n=12$ values reproduce; $254$ sphere products with $n\le40$ exceed $\sqrt{3/2}$, the smallest at $n=12$. Reported as a screen.*

### 5b. The sweep behind "settles it there" never evaluated the deciding cases

The provenance is [ATTEMPTS.md:1037](../ATTEMPTS.md#L1037), *"Step 5, the sweep over classical symmetric pairs"*, $594$ pairs, $N,m$ up to $40$. Its result:

> *"Of the 594 pairs, **53 survive the screen (500 rejected for non-single $\mathfrak k$**, 38 for $2q\le p$, 3 on Casimir sign). Exactly **15 exceed $\sqrt{3/2}$, and every one of them is a balanced sphere pair** $(\mathfrak{so}(2m),\mathfrak{so}(m)\oplus\mathfrak{so}(m))$ with $m\ge6$."*

$m=6,\dots,20$ is **exactly 15 pairs**. The screen requires $\mathfrak k$ to act on $\mathfrak m$ with a single Casimir, and $\mathfrak{so}(j)\oplus\mathfrak{so}(N-j)$ with $j\ne N-j$ has two ideals that no symmetry of the pair interchanges. **So every unbalanced sphere split fell into the 500 rejected**, and the sweep's "every one of them is balanced" is a property of its screen, not of the mathematics. By §5a there are $254$ sphere products with $n\le40$ above $\sqrt{3/2}$, of which **239 are unbalanced** and none was in the sweep, including $S^5\times S^7$, which is [L69](../findings/graded-half.md)'s own headline case and is recorded at $\theta=1.228239158$ in [target.md:494](../findings/target.md#L494).

**So the block asserts "balanced and unbalanced alike" on the strength of a run that evaluated $53$ of $594$ pairs and rejected every unbalanced sphere split before evaluating it.** This is the block's own named trap, *"the criticality relation has to be tested against each pair's true Casimirs rather than solved for them"*, one level up: a screen applied so as to make the surviving set look like the conclusion.

### 5c. Which families are covered

- **Covered and correct**: the balanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ pairs, $\mathfrak u(m)$, and the $\mathfrak{su}$/$\mathfrak{sp}$ rejections (the latter shown in exact arithmetic, $(\mathfrak{sp}(2j),\mathfrak{sp}(j)\oplus\mathfrak{sp}(j))$ has $c_{\mathfrak k}=2(j+1)$, $C=(2j+1)/2$ against (R1)'s $-2.625,-1.417,-0.313$, wrong sign, so no two-eigenvalue graded point).
- **Not covered**: **every unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$** (§5b), the block does not say so, and this is the omission that matters, because those are the points its own sentence is about.
- **Named as outstanding, correctly**: *"the same closure for the $\mathfrak{su}$ and $\mathfrak{sp}$ families, and the exceptional algebras"*, echoed at [ATTEMPTS.md:1547](../ATTEMPTS.md#L1547) as *"the exceptional $\mathfrak h$ ($G_2,F_4,E_6,E_7,E_8$), and non-standard representations such as the spin representations."*
- **"Finite check" is per dimension, not finite.** The pairs $(\mathfrak{so}(n),\mathfrak k)$ are finite in number for each $n$ and the conjecture quantifies over all $n$. The closed forms discharge this; the phrase does not.

## 6. The pinning identity itself, CONFIRMED, with an unstated hypothesis

**I verified it symbolically, for all $m$, at the balanced sphere pair.** Take $(\mathfrak{so}(2m),\mathfrak{so}(m)\oplus\mathfrak{so}(m))$: $p=\dim\mathfrak k=m(m-1)$, $q=\dim\mathfrak m=m^2$, $p+q=m(2m-1)=\binom{2m}2$ ✓, and $c_{\mathfrak k}=2(m-2)$. Then

$$c_{\mathfrak k}q^2+2q^2+p^2=2m^4(m-1)+m^2(m-1)^2=m^2(m-1)(2m-1)(m+1),\qquad 2q-p=m(m+1),$$
$$\sqrt{pq(p+q)}=m^2\sqrt{(m-1)(2m-1)},\qquad\text{so}\qquad \theta=\frac{\sqrt{(m-1)(2m-1)}}{m},$$

i.e. $\theta^2=\dfrac{(m-1)(2m-1)}{m^2}=\dfrac{2(n-1)(n-2)}{n^2}=\theta_0(2m)^2$. **Exact, every $m$.** The identity is right.

**The hypothesis the block omits.** Applied to $S^3\times S^5$ (the very pair the block's counterexample lives on), the formula with $p=13$, $q=15$ needs $c_{\mathfrak k}=3.476916$ to return $\theta=1.115547$. That is none of the tabulated candidates: the adjoint Casimirs of the two ideals are $2$ and $6$, their dimension-weighted mean is $66/13=5.077$, and the $\mathbb R^n$-Casimirs sum to $6$. **A single lookup cannot produce it**, and [ATTEMPTS.md:1037](../ATTEMPTS.md#L1037) confirms the reason: at non-simple $\mathfrak k$ *"the ideal-wise system is required"*, as it was for $\mathbb{HP}^2$. So *"the value follows from three integers and one table lookup"* holds where $\mathfrak k$ acts on $\mathfrak m$ with a single Casimir and needs one lookup per ideal plus a linear solve otherwise. **This is the same hypothesis whose screen hid the unbalanced splits in §5b**, one omission, two consequences.

## 7. "Provably defect-free for every dimension and every split", CONFIRMED

**The one-line reason given is a genuine proof, and I reconstructed it.** For $S^p\times S^q$ the Weyl operator is $W\propto q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m}$ with $\mathfrak m=\mathbb R^p\otimes\mathbb R^q$, so by [conventions.md](../findings/conventions.md)'s sign, $W_-=\tfrac12(\lvert W\rvert-W)$ is supported on $\mathfrak m$ alone: $W_-=b\,\Pi_{\mathfrak m}$, $b>0$. Writing $\Pi_{\mathfrak m}=\sum_\alpha v_\alpha\odot v_\alpha$ over any orthonormal basis, $\mathrm{Alt}(v\odot v)\propto v\wedge v$, which vanishes **iff $v$ is decomposable**. The basis $\{e_i\wedge f_a\}$ of $\mathbb R^p\otimes\mathbb R^q$ is decomposable to a vector, so $\mathrm{Alt}(\Pi_{\mathfrak m})=0$ and $\delta^2=0$. No balance is used and no $n$ is used, so *"every dimension and every split"* is exactly right. The general form (*$\delta^2=0$ whenever $\mathfrak m$ admits an orthonormal basis of decomposable bivectors*), is already at [ATTEMPTS.md:1037](../ATTEMPTS.md#L1037).

**Two guards worth keeping.** The argument consumes the *sign* (that $W_-$ sits on $\mathfrak m$ and not on $\mathfrak k$) which is [conventions.md](../findings/conventions.md)'s live collision, *"a collision between the two refuted four lemmas in one day"*. And the converse fails: $S^4\times S^4$ has $(\Lambda^4\mathbb R^8)^{\mathfrak k}\ne0$ and $\delta^2=0$ anyway ([ATTEMPTS.md:1547](../ATTEMPTS.md#L1547)).

## 8. The counterexample, sound as a numerical witness, and it needs one reading the file denies

**What is shown.** The witness is the most heavily corroborated object in this record: independently rebuilt from the definitions by [r295](REVIEW_r295.md), [r296](REVIEW_r296.md), [r301](REVIEW_r301.md), [r305](REVIEW_r305.md), [r306](REVIEW_r306.md), [r308](REVIEW_r308.md), [r309](REVIEW_r309.md), [r310](REVIEW_r310.md), [r313](REVIEW_r313.md), [r314](REVIEW_r314.md), [r317](REVIEW_r317.md) and [r322](REVIEW_r322.md), agreeing to twelve digits at $\theta=1.088948052505$, $\Delta=1.512230534$, criticality residual $2.9\times10^{-15}$, $\ker W=0$, $\dim\mathfrak m=15$, $S_{\mathfrak{mpp}}=0$, $S_{\mathfrak{mmm}}=1.4\times10^{-28}$. [r308](REVIEW_r308.md) conjugates its invariant $3{+}5$ splitting of $\mathbb R^8$ to the coordinate one and gets a block-diagonal operator, so it does sit on that splitting; [r313](REVIEW_r313.md) overturned the record's own rebuttal that the eigenspace splitting is not a grading.

**What is asserted rather than shown, and it is the load-bearing part.** The block's argument that this is *the same pair* is *"its isotropy algebra has the identical Killing spectrum $-3.0^{\times10}\oplus-1.0^{\times3}$, difference exactly $0$, so it is the same pair and not a coincidence of dimensions."* An isospectral Killing form settles the **isomorphism type** of $\mathfrak k$; it does not settle that $\mathfrak k$ sits in $\mathfrak{so}(8)$ *conjugately* to the sphere product's. The block itself knows this, its next paragraph is about $S^3\times S^5$ and $\mathbb{HP}^2$ being *isospectral with the identical value* and non-conjugate. It does not matter for the refutation (two different $\theta$ on one abstract pair already breaks a formula in $p,q,c_{\mathfrak k}$), but the sentence claims more than its evidence.

**The reading problem, which does matter.** [r318](REVIEW_r318.md) certifies the witness is **(A) and not (C)**. L8 is labelled **(C)** at [graded-half.md:354](../findings/graded-half.md#L354). **A witness outside a lemma's sense cannot refute it.** The refutation is therefore a refutation of L8 read as **(B)**, which is what the still-live (B) bullet at line 252 says L8 uses, and what line 354 says is a mistake. §3's Broken 2 is this same fork. **Until the file picks one, the block's own `SCOPE REFUTED` is either valid or vacuous and nobody can say which.**

## 9. What the record already knows, and one inversion

**The rest of the record is largely ahead of the block.** [findings/INDEX.md:20](../findings/INDEX.md#L20) states the scope and the Gate-2 debt correctly. [results.md:18](../results.md#L18) carries a separate `Open` row for the non-equivariant graded half. [graded-half.md:222](../findings/graded-half.md#L222) states that $\lVert A\rVert^2$ *"is pinned by $(p,q)$ at the EQUIVARIANT point and nowhere else"*. [post F38](../findings/INDEX-traps.md) records that no mass separates the loci. The canon headline [ELIM-canon.md:176](ELIM-canon.md#L176) complains about (*"Settled across the classical symmetric pairs (Lemmas 7–8, 10)"*), is gone.

**One passage contradicts the block outright**, ~55 lines below it, in the same file, in *"The graded classification"* section:

> *"So a graded critical point is not merely associated with a symmetric pair; it **is** the unique invariant operator of that pair, **with no room for a second point to hide**."*

That is precisely what the counterexample denies. The two are reconcilable only by reading *"graded"* there as *"equivariant"*, which makes the sentence a tautology and removes its content. As written it is a second unscoped statement of the refuted claim, in the file that owns it.

**The inversion.** [results.md:340](../results.md#L340) (the *pointer* copy), is fully repaired: it scopes to equivariant, says *"the equivariant graded case is a finite check"*, and **drops the "sphere products exceed" and "settles across the classical families" sentences entirely**. [findings/graded-half.md](../findings/graded-half.md), which its own header calls the ***canonical statement and proof***, keeps them. The record's rule is that the canonical copy is the one to trust; here it is the one carrying the false sentence.

## 10. Repairs, in order of value

1. **Delete or replace the false sentence.** *"Sphere products, balanced and unbalanced alike, exceed the rival maximizer's value"* $\to$ *"a sphere product exceeds the rival maximizer exactly when $p,q\ge5$ and $n\ge12$, by the closed form $\theta^2=2(n-1)(p-1)(q-1)/((n-2)pq)$"*. Cite [problem.md:511](../findings/problem.md#L511).
2. **Attach the single-Casimir hypothesis** to the pinning statement, and record that the unbalanced splits were rejected by the sweep's screen rather than checked (§5b).
3. **Fix [graded-half.md:252](../findings/graded-half.md#L252)**, remove L8 from the (B) bullet, or, if (B) is the intended reading, fix line 354 instead. Say which, because the block's own refutation depends on the answer.
4. **Fix [graded-half.md:379](../findings/graded-half.md#L379)**, *"Lemma L8 supplies it"* $\to$ the invariant count of L69's own proof.
5. **Fix [ungraded-slack.md:285](../findings/ungraded-slack.md#L285)**, adopt [results.md:366](../results.md#L366)'s wording.
6. **Amend [INDEX-results.md](../findings/INDEX-results.md) row 8** to carry the scope refutation and the Gate-2 debt, as every neighbouring row does.
7. **Scope the "no room for a second point to hide" sentence** in *"The graded classification"* to equivariant points.

## 11. What a computation would decide, and is not run

Under this programme's analysis-only footing I name these rather than running them.

- **Whether the sweep's conclusion survives its screen.** Re-running [review_r11_cartan_sweep.py](../scripts/reviewers/r11/review_r11_cartan_sweep.py) with the ideal-wise system in place of the single-Casimir screen would evaluate the 500 rejected pairs. *If* no non-sphere pair among them exceeds $\sqrt{3/2}$, the block's conclusion, *"across the classical families every graded critical point above the rival maximizer is a sphere product"*, is restored on evidence rather than on a screen; *if* one does, that conclusion is false and the graded half is open in the equivariant case too. Nothing on the record decides it either way, and §5b shows the present run cannot.
- **Whether the witness's $\mathfrak k$ is $\mathfrak{so}(8)$-conjugate to the sphere product's.** A conjugacy test would upgrade §8's "same pair" from an isospectrality claim to a proof. It changes no verdict here.

