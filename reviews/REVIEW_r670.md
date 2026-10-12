# REVIEW r670, Lemma L82

**Target:** Lemma L82, "the operator-norm lever $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2\ge1$ for two negative eigenvalues", [findings/isotropy-cap.md:372](../findings/isotropy-cap.md), the heading at line 372, the single content paragraph at line 376 under the separate heading *The lever for closing it* (line 374), and the debt paragraph at lines 378–380. Index row at [findings/INDEX-results.md:97](../findings/INDEX-results.md), which records **"Gate 2: no verdict on the record."**

**Reviewer:** r670, cold, adversarial, **analysis-only footing**. No search, sweep, census, optimisation or falsifier hunt was run, and [review_r61_adnorm.py](../scripts/reviewers/r61/review_r61_adnorm.py) (the block's only source), was read but **not executed**. Everything in §2–§5 was derived by hand from [conventions.md](../findings/conventions.md) and the identity at [isotropy-cap.md:268](../findings/isotropy-cap.md) before the block was read for its reasoning. **Two screens** were taken, a few seconds of dense linear algebra on objects built here for the purpose, and each is reported as a screen and is the ground of no positive claim; both agree to six digits with closed forms derived by hand in the same sections.

**VERDICT: REFUTED, one clause of the numbered statement is false, and the equality is attached to the wrong inequality.** The two displayed inequalities are **both theorems** and I re-derive each from the definitions (§2, §3). What fails is *"with equality at the $m=6$ witness"*: at that witness $T_+=4/\sqrt{14}$ and $\lvert\lambda_N\rvert=3/\sqrt{14}$, so **the block's own first inequality already gives $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}\ge\sqrt{3/2}=1.2247$**, and $1$ is unreachable. The refutation needs no computation, the spectrum is printed twenty lines above the block, at [isotropy-cap.md:351](../findings/isotropy-cap.md). What is true is that **the $m=6$ witness attains equality in the *first* inequality** ($\lVert\mathrm{ad}_{v_N}\rVert^2=2\lvert\lambda_N\rvert/T_+=3/2$ exactly) and the $m=8$ witness attains equality in the *second* ($T_+=2\lvert\lambda_N\rvert$ exactly), **each witness is tight in the step the other is loose in, and neither is tight in $\ge1$** (§4). Six further defects follow. **The degraded $\ge1$ is vacuous at every $m\le9$**, every unit skew matrix in $\mathfrak{so}(m)$ has $s_1+s_2\ge2/\sqrt{\lfloor m/2\rfloor}$, which is $1.1547$ at $m=6,7$ and $1$ at $m=8,9$, so the lever carries information only from $m=10$, exactly where the record has no witnesses (§4.2). **The equality $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2$ is asserted, never derived here**, it is [Lemma L31](../findings/stratum-two-negative.md)'s root-system step in another file, uncited (§5). **"Exactly two" should be "at most two"** (§3.2). **The first of the two debts the block records is already discharged** by [Lemma L35](../findings/stratum-two-negative.md), which the block does not cite (§6). And one genuinely new thing: **at one negative eigenvalue the same contraction reproves [Lemma L33](../findings/stratum-two-negative.md) in two lines**, by hand, which is a case L35 marks as "owed a line" (§7).

---

## 1, Conventions, pinned before anything was derived

[conventions.md](../findings/conventions.md) was re-read in full first, in the state repaired today. **It carries none of this block's four principal symbols.** The readings below are what I derived on, and each is either forced by the file or pinned by an anchor computed here.

| symbol | reading adopted | pinned at | status |
| --- | --- | --- | --- |
| $\langle X,Y\rangle$ | $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ on $\mathfrak{so}(m)\cong\Lambda^2\mathbb R^m$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal | [conventions.md](../findings/conventions.md), "Norms and pairings", bullets 1–2 | the record's choice, pinned twice ([r519](REVIEW_r519.md), [r520](REVIEW_r520.md)) |
| $\lambda_N$ | the **most negative** eigenvalue of $W$ acting on $\Lambda^2\mathbb R^m$, $\lambda_N<0$ | **nowhere in [findings/](../findings/)** | **D1** |
| $v_N$ | its **unit** eigenvector, an element of $\mathfrak{so}(m)$; the eigenbasis $\{v_\alpha\}$ is orthonormal for the pairing above | **nowhere** | **D1** |
| $T_+$ | $\sum_{\lambda>0}\lambda$, the sum of the positive eigenvalues of $W$ | the block itself, line 376 | defined in place, not tabled |
| $s_1,s_2$ | the two largest **angles** of $v_N$, the singular values of $v_N$ as a skew matrix listed **once per conjugate pair**, so $\sum_j s_j^2=\lVert v_N\rVert^2=1$ | [conventions.md](../findings/conventions.md), "A skew matrix's norm" | **D2, the bullet is ambiguous and the other reading falsifies the lemma** |
| $\mathfrak m$ | here the negative eigenspace, so $\dim\mathfrak m\le2$ **is** "at most two negative eigenvalues" | [conventions.md](../findings/conventions.md) tables this as [L36](../findings/isotropy-cap.md)'s sense, one of three | read from context, as the file instructs |

### 1.1, D2, and it is not cosmetic: one reading of the $s_i$ makes the lemma false

[conventions.md](../findings/conventions.md) says a unit skew matrix has *"singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_i s_i^2=1$"*. Read with $i$ ranging over the **listed multiset**, that is $2\sum_j s_j^2=1$; read with $i$ ranging over the **distinct pairs**, it is $\sum_j s_j^2=1$. The two differ by $\sqrt2$ in every $s_j$, and **only the second makes L82 true.**

*Anchor, by hand.* Take $w_1=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})\in\mathfrak{so}(4)$, which is unit under the half-trace pairing. Its four singular values are all $1/\sqrt2$. Under the multiset reading $s_1=s_2=1/2$ and $s_1+s_2=1$; under the distinct-pair reading $s_1=s_2=1/\sqrt2$ and $s_1+s_2=\sqrt2$. Now compute the bracket directly with $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$: with $w_2=\tfrac1{\sqrt2}(\varphi_{13}+\varphi_{42})$ and $w_3=\tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23})$,

$$[w_1,w_2]=\tfrac12\big(-\varphi_{23}-\varphi_{14}-\varphi_{14}-\varphi_{23}\big)=-(\varphi_{14}+\varphi_{23})=-\sqrt2\,w_3 ,$$

so $\lVert\mathrm{ad}_{w_1}\rVert_{\rm op}\ge\sqrt2$. **The distinct-pair reading is the one the record means**, and the multiset reading would turn $s_1+s_2\ge1$ into a statement that is *false for every unit skew matrix at $m\ge6$* ($s_1+s_2\le1$ there, with equality only at rank 4). The block never names a pairing or a reading. *[Lemma L31](../findings/stratum-two-negative.md)'s block at [stratum-two-negative.md:412](../findings/stratum-two-negative.md) has the same wording and the same exposure.*

---

## 2, The contraction bound: CONFIRMED, and it holds far more widely than the heading says

### 2.1, The derivation, in five lines

The identity is the one this file states at [isotropy-cap.md:268](../findings/isotropy-cap.md), for $W\in\mathrm{Weyl}_m$ in an orthonormal eigenbasis $\{v_\alpha\}$ with eigenvalues $\{\lambda_\alpha\}$:

$$\sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2=2W .$$

$\mathrm{ad}(v)$ is **skew-adjoint** for the ad-invariant pairing, so $\langle u,\mathrm{ad}(v)^2u\rangle=-\lVert[v,u]\rVert^2$. Contracting the identity at any unit $u$ gives, with no hypothesis on $u$ at all,

$$\sum_\alpha\lambda_\alpha\lVert[v_\alpha,u]\rVert^2=-2\langle u,Wu\rangle .$$

Put $u=v_\beta$, a unit eigenvector. The right side is $-2\lambda_\beta$, and the $\alpha=\beta$ term on the left vanishes because $[v_\beta,v_\beta]=0$. So

$$\sum_{\alpha\ne\beta}\lambda_\alpha\lVert[v_\alpha,v_\beta]\rVert^2=2\lvert\lambda_\beta\rvert\qquad\text{whenever }\lambda_\beta<0 .$$

Every term with $\lambda_\alpha<0$ is $\le0$, so dropping them **preserves the inequality direction**:

$$\sum_{\lambda_\alpha>0}\lambda_\alpha\lVert[v_\alpha,v_\beta]\rVert^2\ \ge\ 2\lvert\lambda_\beta\rvert .$$

Finally $\lVert[v_\alpha,v_\beta]\rVert=\lVert\mathrm{ad}_{v_\beta}v_\alpha\rVert\le\lVert\mathrm{ad}_{v_\beta}\rVert_{\rm op}$ since $\lVert v_\alpha\rVert=1$, giving

$$\boxed{\ \lVert\mathrm{ad}_{v_\beta}\rVert_{\rm op}^2\ \ge\ \frac{2\lvert\lambda_\beta\rvert}{T_+}\ }$$

**Confirmed.** The route through $N_v\succeq0$ ([Lemma L80](../findings/isotropy-cap.md)) gives the identical line, since $\langle v_\beta,N_{v_\alpha}v_\beta\rangle=2\langle v_\alpha,v_\beta\rangle^2+\lVert[v_\alpha,v_\beta]\rVert^2$ and the first term collapses to $2\lambda_\beta$ by orthonormality; the shorter route above needs only skew-adjointness.

### 2.2, Which hypotheses are actually used, and which the heading claims

| hypothesis | used? |
| --- | --- |
| first Bianchi identity | **yes**, it is what gives $\mathcal A(W)=2W$ rather than $\mathcal A(W)=2W-\mathrm{Ric}$ terms ([L79](../findings/isotropy-cap.md)) |
| Ricci-flatness | **yes**, it deletes the $\operatorname{tr}(u^2v_\alpha^2)$ terms |
| $\lVert W\rVert=1$ | **no**. Both sides of the boxed bound are degree-zero in $W$, so it is scale-invariant |
| criticality $Q(W)=\theta W$ | **no**, nowhere |
| $\lVert v_N\rVert=1$ | **yes**, and only in the last step |
| $\lambda_N$ **most** negative | **no**, the bound holds at **every** negative eigenvector $v_\beta$ |

So the first half of L82 is a statement about **every** negative eigenvector of **every** Ricci-flat Bianchi operator, at every $m$ and with any number of negative eigenvalues. *This is the pattern this audit has been finding all day: the identity is wider than the heading it sits under.* The "most negative" hypothesis is consumed **only** in §3, and unit norm of $W$ only in the $s_1+s_2\le\sqrt2$ step of §5.

### 2.3, D3: "kills the negative terms" is the wrong verb, and it is load-bearing

Exactly **one** negative term is killed, the $\alpha=N$ term, by $[v_N,v_N]=0$. Every other negative term is **discarded because it is $\le0$**, which is a one-sided estimate and is where the bound stops being an identity. With exactly two negative eigenvalues the discarded quantity is the single term $\lambda_{N-1}\lVert[v_{N-1},v_N]\rVert^2$, and it vanishes only when the two negative eigenvectors commute. The record's own $m=8$ witness has them on orthogonal $4$-planes, so there it *does* vanish; the $m=6$ witness overlaps, and there it does not. **A reader who takes "kills" literally will believe the chain is an identity and will look for equality where none can hold.** That is the mechanism of the refutation in §4.

---

## 3, The two-negative step: CONFIRMED, and "at most two" suffices

### 3.1, Derivation

$W$ is trace-free on $\Lambda^2$, **this is not an extra hypothesis**: Ricci-flatness $\sum_kW_{ikjk}=0$ contracted on $i=j$ gives $\sum_{i,k}W_{ikik}=0$, i.e. $\operatorname{tr}W=0$. Hence $T_+=\sum_{\lambda<0}\lvert\lambda\rvert$. With at most two negative eigenvalues, counted with multiplicity, that sum is $\lvert\lambda_{N-1}\rvert+\lvert\lambda_N\rvert$ with $\lvert\lambda_{N-1}\rvert\le\lvert\lambda_N\rvert$ by the choice of $\lambda_N$ as the **most** negative. So $T_+\le2\lvert\lambda_N\rvert$. **Confirmed**, and this is the one step where "most negative" earns its place. Chaining, $\lVert\mathrm{ad}_{v_N}\rVert^2_{\rm op}\ge2\lvert\lambda_N\rvert/T_+\ge1$.

### 3.2, D4: "exactly two" is the wrong quantifier

"At most two, and at least one" is what the argument uses; the "at least one" is free, since trace-freeness makes zero negative eigenvalues impossible for $W\ne0$. **And the one-negative case is not a degenerate boundary, it is strictly stronger**, giving $T_+=\lvert\lambda_N\rvert$ and hence $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}^2\ge2$, which forces equality against the universal $\le2$ (§7). *The record already prefers the wider quantifier where it has thought about it*: [Lemma L35](../findings/stratum-two-negative.md) is stated for **at most** two and [Lemma L29](../findings/stratum-two-negative.md) for one-positive-and-two-negative, and [stratum-two-negative.md:435](../findings/stratum-two-negative.md) records the subsumption. L82 is the narrow one.

---

## 4, REFUTED: "with equality at the $m=6$ witness"

### 4.1, The refutation, from the block's own file, with no computation

The $m=6$ witness is tabled twenty lines above the block, at [isotropy-cap.md:351](../findings/isotropy-cap.md): two padded $\mathrm{Weyl}_4$ summands on $4$-planes overlapping in a $2$-plane, spectrum $(-3,-1,1,1,1,1)/\sqrt{14}$, $\dim U=6$, exactly two negative eigenvalues. Read off $T_+=4/\sqrt{14}$ and $\lvert\lambda_N\rvert=3/\sqrt{14}$. Then

$$\frac{2\lvert\lambda_N\rvert}{T_+}=\frac{6}{4}=\frac32,\qquad\text{so}\qquad \lVert\mathrm{ad}_{v_N}\rVert_{\rm op}\ \ge\ \sqrt{3/2}=1.224745 .$$

**The block's own first inequality forbids the value $1$ at its own witness.** The clause is false, and it is falsified by the sentence it is written in.

Two independent confirmations that the failure is structural rather than a slip of a digit:

- **The second inequality is strict there.** $T_+\le2\lvert\lambda_N\rvert$ reads $4\le6$. Equality in the chain requires equality in *both* steps, and in particular requires the two negative eigenvalues to be **equal**. The $m=6$ witness has $-3$ and $-1$.
- **At $m=6$ equality is geometrically impossible for anything but a simple bivector.** Suppose $s_1+s_2=1$ with $s_1\ge s_2\ge s_3\ge0$ and $s_1^2+s_2^2+s_3^2=1$. Squaring the first gives $s_3^2=2s_1s_2$, and $s_3\le s_2$ then forces $2s_1\le s_2\le s_1$, impossible unless $s_2=0$, leaving $s_1=1$, $v_N$ a unit **rank-2** bivector. The witness's $v_N$ is not one: its most negative eigenvector is a combination of two padded self-dual forms, of rank $\ge4$.

### 4.2, What the clause should have said, and the diagnosis

**Each recorded witness is tight in exactly one step, and it is not the same step.**

| witness | $2\lvert\lambda_N\rvert/T_+$ | $T_+$ vs $2\lvert\lambda_N\rvert$ | true $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}$ | tight where |
| --- | --- | --- | --- | --- |
| $m=6$, overlapping planes | $3/2$ | $4<6$, **strict** | $\sqrt{3/2}=1.224745$ | **the contraction bound**, exactly |
| $m=8$, orthogonal planes | $1$ | $1.1547=1.1547$, **equality** | $\sqrt2=1.414214$ | **the two-negative step**, exactly |

So the correct sentence is *"with equality in the contraction bound at the $m=6$ witness, and in the two-negative step at the $m=8$ one"*, and **the composite $\ge1$ is attained at neither.** *This is also the more useful statement*: it says the first inequality is sharp, which is what licenses using it undegraded.

### 4.3, D5: the degraded $\ge1$ is vacuous at every $m\le9$

For a **unit** skew $v\in\mathfrak{so}(m)$ with $p=\lfloor m/2\rfloor$ angles and $\sum_{j\le p}s_j^2=1$, minimising $s_1+s_2$ under $s_1\ge s_2\ge\dots\ge s_p\ge0$ puts all the mass equally: the minimum is $2/\sqrt p$, at $s_1=\dots=s_p=1/\sqrt p$.

| $m$ | $6$ | $7$ | $8$ | $9$ | $10$ | $12$ |
| --- | --- | --- | --- | --- | --- | --- |
| $\min(s_1+s_2)$ over unit skew | $1.1547$ | $1.1547$ | $1$ | $1$ | $0.8944$ | $0.8165$ |

**So $s_1+s_2\ge1$ excludes nothing at $m\le9$**, it is weaker than a fact about skew matrices that needs no Weyl tensor, no Bianchi and no eigenvalue count. Its first content is at $m=10$. That is not fatal, because $m\ge10$ is precisely the open range; but it means the block advertises an equality case ($m=6$) inside the range where the conclusion is information-free, and the *undegraded* first inequality is the only part with content at small $m$, at the $m=6$ witness it gives $1.2247$ against the free floor $1.1547$. **Degrading through $T_+\le2\lvert\lambda_N\rvert$ throws away exactly what makes the lever non-trivial below $m=10$.**

### 4.4, Screen

*Permitted screening only, seconds of dense linear algebra on objects I constructed for the purpose, reported as a screen and never as evidence for a positive claim.* Building $\mathfrak{so}(m)$ in the half-trace pairing and the two padded-$\mathrm{Weyl}_4$ witnesses by hand: the $m=6$ witness returned spectrum $(-3,-1,1,1,1,1)/\sqrt{14}$ to six digits, $2\lvert\lambda_N\rvert/T_+=1.500000$, $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2=1.224745$ with angles $(0.8165,0.4082,0.4082)$; the $m=8$ witness returned $T_+=2\lvert\lambda_N\rvert$ to six digits and $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=1.414214$ with angles $(0.7071,0.7071,0,0)$. $\lVert\mathrm{ad}_v\rVert_{\rm op}=s_1+s_2$ agreed to eight digits on six random unit skew matrices at $m=5,6,8$. **Nothing in the screen disagrees with §4.1–§4.3, and every claim there was derived by hand first and stands without it.**

---

## 5, D6: the equality $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2$ is ASSERTED here, and proved in another file

**The record may cite it as an equality.** It is true, and it is a theorem:

> $\mathrm{ad}_v$ is skew-adjoint for an ad-invariant pairing, hence normal, hence $\lVert\mathrm{ad}_v\rVert_{\rm op}=\max\lvert\text{eigenvalue}\rvert$. Conjugating $v$ into the maximal torus with angles $s_1\ge\dots\ge s_p$, the eigenvalues of $\mathrm{ad}_v$ are the root values $i(\pm s_i\pm s_j)$, together with $i(\pm s_i)$ at odd $m$, every modulus is $\le s_1+s_2$, and $s_1+s_2$ is attained at the root $e_1+e_2$ whenever $p\ge2$ (and at $e_1$ when $p=1$, where $s_2=0$). Then $(s_1+s_2)^2\le2(s_1^2+s_2^2)\le2\sum_js_j^2=2$, with equality iff $s_1=s_2=1/\sqrt2$ and the rest vanish, **rank exactly $4$, an equal-angle complex structure on a $4$-plane.**

**But none of that is in L82's block, or anywhere in [isotropy-cap.md](../findings/isotropy-cap.md).** It is [Lemma L31](../findings/stratum-two-negative.md)'s proof, at [stratum-two-negative.md:412](../findings/stratum-two-negative.md), re-derived cold by [r543](REVIEW_r543.md) and [r544](REVIEW_r544.md). **L82 does not cite L31, and L31 does not know it is being consumed here.** The heading puts an equality in the name of a numbered result whose block never argues for it, the same failure mode this file was repaired for at [L77](../findings/isotropy-cap.md), which *"has no statement-and-proof block of its own, which is why the hypothesis had nowhere to land"*.

*The rank-$4$ equality clause the block states ("$s_1+s_2\le\sqrt2$ with equality only at rank 4 with $s_1=s_2$"), is correct, and is also L31's, uncited.*

---

## 6, What the lever buys, and D7: the first debt it records is already paid

The block closes with *What B0 now owes*, naming two items. Taking them in order:

1. *"$\sup\theta$ over $\dim\mathfrak m\le2$ with any number of positive eigenvalues (Lemma L29 covers rank 3 only) which closes B0 without any descent"*. **This is [Lemma L35](../findings/stratum-two-negative.md) verbatim**, at [stratum-two-negative.md:443](../findings/stratum-two-negative.md): *"Let $W\in\mathrm{Weyl}_m$ have unit norm and at most two negative eigenvalues, at any number of positive ones, at any $m$. Then $\theta\le\sqrt{3/2}$."* Its own block says it *"generalises the one-positive lemma above to any number of positive eigenvalues and needs no descent"*, and [stratum-two-negative.md:397](../findings/stratum-two-negative.md) records that B0's stratum bound *"is **closed** by Lemma L35 below"*. **The debt is discharged and the block is stale.** *(One qualification the record itself states and I repeat rather than soften: L35's interval $(\tfrac13,0.7096]$ closes by certified interval arithmetic, so it is a proof with a machine-checked step rather than one a reader follows end to end.)*
2. *"the sharpening $s_1+s_2=\sqrt2$, which closes $m\ge10$"*. Still open, and **the block overstates what the sharpening would give**, in two places:
   - *"would force **both** negative eigenvectors to be rank-4 complex structures"*. The lever is derived at $v_N$ only. Applying it at the other negative eigenvector $v_{N-1}$ gives $\lVert\mathrm{ad}_{v_{N-1}}\rVert^2\ge2\lvert\lambda_{N-1}\rvert/T_+$, and since $\lvert\lambda_{N-1}\rvert\le\lvert\lambda_N\rvert$ that right-hand side is **at most $1$**, it never reaches $2$ unless the two negative eigenvalues are equal. **"Both" needs a separate argument the block does not have.**
   - *"and close $m\ge10$ outright"*. Two rank-$4$ complex structures have images spanning at most eight dimensions, so the conclusion needs $\operatorname{supp}W\subseteq\operatorname{im}v_{N-1}+\operatorname{im}v_N$. **The block never supplies that step.** The record does supply it in the shape needed at the *bracket cap*, [stratum-two-negative.md:273](../findings/stratum-two-negative.md) runs it from $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$, but that argument uses $\operatorname{im}v_{N-1}=\operatorname{im}v_N$, which is L31's equality case and is a strictly stronger input than "both are rank $4$".

**So the honest summary of the lever is: it closes nothing.** It is one correct, scale-invariant, hypothesis-light inequality; its degraded form is vacuous where the record has witnesses; the debt it was recorded against has since been paid elsewhere; and the sharpening it points at is the whole of the remaining problem rather than a step toward it. The block should say so.

---

## 7, NEW: at one negative eigenvalue the same contraction reproves Lemma L33 in two lines

This is the one place the lever pays, and the block does not see it. Let $W\in\mathrm{Weyl}_m$, $W\ne0$, have **exactly one** eigenvalue on one side counted with multiplicity, say one negative, $\lambda_N$, with unit eigenvector $v_N$. Trace-freeness gives $T_+=\lvert\lambda_N\rvert$, so §2's bound reads

$$\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}^2\ \ge\ \frac{2\lvert\lambda_N\rvert}{\lvert\lambda_N\rvert}\ =\ 2 .$$

Against the universal $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2\le\sqrt2$ at unit norm (§5), **this is an equality**, so $s_1=s_2=1/\sqrt2$ and every other angle vanishes: $v_N$ is $\tfrac1{\sqrt2}$ times a **complex structure on a $4$-plane**. The argument is symmetric in the sign, so it covers a single positive eigenvalue too.

**That is exactly [Lemma L33](../findings/stratum-two-negative.md)**, at [stratum-two-negative.md:119](../findings/stratum-two-negative.md), whose contrapositive is *"if that eigenvector is not a multiple of a complex structure on a $4$-dimensional subspace, then $W=0$"*, currently proved through the [L32](../findings/isotropy-cap.md) centraliser collapse and certified by a convex-feasibility screen. **The route above is two lines, needs no centraliser, no case split on multiplicity patterns and no numerics.** Push one step further with the record's own PSD identity $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ ([stratum-two-negative.md:273](../findings/stratum-two-negative.md)): the negative side is then $\lvert\lambda_N\rvert v_N^{\mathsf T}v_N$, of rank $4$, so every positive eigenvector's image lies in that same $4$-plane and **$W$ is a padded $\mathrm{Weyl}_4$ element**, whence $\theta\le\sqrt{3/2}$ by the exact $m=4$ result on record. **This is the "line" [L35](../findings/stratum-two-negative.md)'s block says the one-negative case is owed** (*"the one-negative case is the $c\to0$ boundary and is owed a line"*) and unlike L35's main chain it is hand-checkable end to end.

*Screen: the four padded single-summand $\mathrm{Weyl}_4$ tensors I built at $m=6,8$ each returned one negative eigenvalue, $2\lvert\lambda_N\rvert/T_+=2.000000$, $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=1.414214$ and angles $(0.7071,0.7071,0,\dots)$, a screen, agreeing with the derivation above, and the ground of nothing.*

---

## 8, Provenance, duplication, and pointers

### 8.1, Provenance: the same bulk retrofit, and this time it lost neither a hypothesis nor a definition

`git log -S "operator-norm lever" -- findings/isotropy-cap.md` returns exactly one commit, **`5b258c14` "docs(isotropy-cap): place headings for Lemmas 75-82"**, **the fifth heading from the commit that produced [L75](../findings/isotropy-cap.md), [L76](../findings/isotropy-cap.md), [L77](../findings/isotropy-cap.md) and [L78](../findings/isotropy-cap.md), all four found defective.** The diff is one added line and the commit body's claim, *"headings only: no statement, proof or table text is altered"*, **is true here**: `git show 5b258c14 -- findings/isotropy-cap.md` adds the heading and nothing else.

**The defect is a different one, and it is the retrofit's structural signature rather than its textual one.** The heading at line 372 is **immediately followed by another `####` heading** at line 374, *The lever for closing it*. So **L82 owns no text at all**: everything the number stands for lives under a sibling heading, and the numbered result's own name asserts an equality ($=s_1+s_2$) that appears nowhere beneath it. This is precisely the shape [L77](../findings/isotropy-cap.md) was repaired for. **The prose itself is older**, from `51ab61f8` (the split), and older still: it is a copy of [ATTEMPTS.md:2108](../ATTEMPTS.md), written the day of the review it reports.

### 8.2, D8: a verbatim unnumbered twin in ATTEMPTS.md, carrying the same false clause

[ATTEMPTS.md:2108–2109](../ATTEMPTS.md), under *"The lever the review left behind"*, carries the statement in near-identical words including **"with equality at the $m=6$ witness"** and **"sharpening $\ge1$ to $=\sqrt2$ closes $m\ge10$ outright"**. Neither copy has been corrected. *This is the fourth duplication kind the audit has catalogued (a numbered block and an unnumbered twin), with the wrinkle that here **neither** twin was corrected.*

**And the source is cleaner than both copies.** The docstring of [review_r61_adnorm.py](../scripts/reviewers/r61/review_r61_adnorm.py), which is where the lever comes from, states the chain, states $\lVert\mathrm{ad}_X\rVert_{\rm op}=s_1+s_2$ with the normalisation spelled out (*"singular values $s_i$, each twice, sum $s_i^2=1$"*, the distinct-pair reading of §1.1, unambiguous), and **makes no equality claim at any witness**. The false clause was added when the result was written onto the record.

### 8.3, D9: a sentence beginning with a bare colon, from a second retrofit

[isotropy-cap.md:380](../findings/isotropy-cap.md) reads `: $\sup\theta$ over $\dim\mathfrak m\le2$ …`. `git log -S "#### What B0 now owes"` gives **`81418597` "docs(findings): the two flat finding files get a greppable outline"**, which promoted the bold lead-in `**What B0 now owes**:` to a heading and left the colon behind. That commit's body claims *"No prose changed. Verified token by token: the only differences … are the terminal periods stripped from the sentences that became headings"*, **the check looked for terminal periods and not for terminal colons**, and this is the only orphaned colon in the file. Cosmetic, and it is the *one* paragraph in the block a reader consults for what is still owed.

### 8.4, Pointers

- **`[Lemma L36](#)` at [isotropy-cap.md:396](../findings/isotropy-cap.md)**, the empty target the brief flagged. It is in the [L131](../findings/isotropy-cap.md) block, twenty lines below L82, and L36's real anchor is live in this same file at line 17. Outside L82, reported for completeness.
- **"Lemma L29" at [isotropy-cap.md:380](../findings/isotropy-cap.md) is plain text**, with no link; L29 lives in [stratum-two-negative.md](../findings/stratum-two-negative.md). So does L35, which is what that sentence should now point at (§6).
- **"(Reviewer 61)" at [isotropy-cap.md:376](../findings/isotropy-cap.md)** cites no review file and no script. The script is [review_r61_adnorm.py](../scripts/reviewers/r61/review_r61_adnorm.py), indexed at [scripts/INDEX-reviewers.md:534](../scripts/INDEX-reviewers.md); **the record's only route from the lemma to its source runs through a grep.**
- The block's supporting inequality $\lVert\mathrm{ad}_v\rVert_{\rm op}=s_1+s_2\le\sqrt2$ has a canonical home at [Lemma L31](../findings/stratum-two-negative.md) and is cited from neither copy (§5).

---

## 9, Defect summary

| # | where | defect | severity |
| --- | --- | --- | --- |
| **R1** | [isotropy-cap.md:376](../findings/isotropy-cap.md), [ATTEMPTS.md:2109](../ATTEMPTS.md) | *"with equality at the $m=6$ witness"* is **false**; the block's own first inequality gives $\ge\sqrt{3/2}$ there. Equality holds in the *contraction bound* at $m=6$ and in the *two-negative step* at $m=8$; the composite $\ge1$ is attained at neither | **refutes a clause of the numbered statement** |
| **D1** | [conventions.md](../findings/conventions.md) | $v_N$, $\lambda_N$, $T_+$ are defined nowhere on the record | definitional |
| **D2** | [conventions.md](../findings/conventions.md), "A skew matrix's norm" | *"in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_is_i^2=1$"* is ambiguous by a factor $\sqrt2$, and one reading makes L82 **false for every unit skew matrix at $m\ge6$** | live, cross-file ([L31](../findings/stratum-two-negative.md) shares it) |
| **D3** | [isotropy-cap.md:376](../findings/isotropy-cap.md) | *"kills the negative terms"*, one term is killed, the rest are **discarded as $\le0$**; the chain is an inequality, not an identity | wording, load-bearing for R1 |
| **D4** | heading, line 372 | *"exactly two"* should be *"at most two"*; the one-negative case is stronger, not degenerate | scope |
| **D5** | line 376 | $s_1+s_2\ge1$ is **vacuous at every $m\le9$** ($\min=2/\sqrt{\lfloor m/2\rfloor}$); first content at $m=10$. Range unstated | the conclusion is weaker than advertised |
| **D6** | line 372 | $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2$ is **asserted**; proved only at [L31](../findings/stratum-two-negative.md) in another file, uncited | citable-as-equality, but not from here |
| **D7** | lines 378–380 | the first debt is **already discharged by [L35](../findings/stratum-two-negative.md)**; and *"both negative eigenvectors"* and *"closes $m\ge10$ outright"* each need a step the block lacks | stale, and overstated |
| **D8** | [ATTEMPTS.md:2108](../ATTEMPTS.md) | verbatim unnumbered twin, **neither copy corrected**; the source script's docstring is cleaner than both | duplication |
| **D9** | line 380 | sentence begins with a bare `:`, from `81418597`'s heading promotion | cosmetic |

**What may be cited, and how.** The inequality $\lVert\mathrm{ad}_{v_\beta}\rVert_{\rm op}^2\ge2\lvert\lambda_\beta\rvert/T_+$ **at every negative eigenvector of every Ricci-flat Bianchi operator, at every $m$, scale-invariantly**, proved in §2, and sharp (attained at the $m=6$ witness). Its degradation to $s_1+s_2\ge1$ under at-most-two negative eigenvalues is also a theorem, and is **information-free below $m=10$**. The clause *"with equality at the $m=6$ witness"* may not be cited at all. **And the free consequence in §7, one eigenvalue on one side forces a rank-$4$ complex structure and hence a padded $\mathrm{Weyl}_4$, is a two-line hand proof of [L33](../findings/stratum-two-negative.md) that the record does not have.**
