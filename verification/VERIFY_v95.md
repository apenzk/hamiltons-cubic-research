# VERIFY v95, Lemma L2: the crossover $6+2\sqrt7$, the integer cutoff $12$, and the two values it compares

**Verifier v95, cold brief.** Target: [findings/problem.md](../findings/problem.md):160–176, quoted as "The brief as dispatched" in [ROUND_L02.md](ROUND_L02.md). **No numerical work was done**: no script was run, and every value below is an exact hand evaluation of a rational or a named surd. Log: [agent_logs/verify-L02-v95.log](../agent_logs/verify-L02-v95.log). Forms checked: [findings/problem.md](../findings/problem.md):160–176, [results.md](../results.md):13/37/88/112/302, [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) with its row and its "What L2 still owes" section in [lean/INDEX.md](../lean/INDEX.md):278 and :368. Reports read before recording any absence: [r505](../reviews/REVIEW_r505.md), [r506](../reviews/REVIEW_r506.md), [LEDGER.md](../findings/LEDGER.md):473/540/544, [second-order.md](../findings/second-order.md):317, [conventions.md](../findings/conventions.md):18–21, [references/fox-2019-nonassociative-curvature-algebra/](../references/fox-2019-nonassociative-curvature-algebra/).

## Claim table

| # | Claim as the block states it | Verdict |
| --- | --- | --- |
| C1 | $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}$ is the $p=q=n/2$ case of $\theta(S^p\times S^q)^2=\tfrac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ | **CORRECT**, specialisation verified by hand; the general formula is a **CITATION** in the block, derived on file at [LEDGER.md](../findings/LEDGER.md):473 and [r505](../reviews/REVIEW_r505.md) §1.1, with no pointer from the block |
| C2 | The competitor has $\theta^2=\tfrac32$ at every $n\ge4$ | **SPLIT**: the base value at $n=4$ is **IMPORTED** by the block with no argument; the extension to $n>4$ is a genuine **PROOF SKETCH** and is correct |
| C3 | $\theta_0(n)^2-\tfrac32=\tfrac{n^2-12n+8}{2n^2}$ | **CORRECT**, verified by hand |
| C4 | Numerator $-3$ at $n=11$, $+8$ at $n=12$, root $6+2\sqrt7$ | **ARITHMETICALLY CORRECT, WRONG CONSTANT AT $n=11$**, $n=11$ is odd, where no balanced product exists; the attained object gives $-4$, not $-3$ |
| C5 | The root is irrational, so no integer attains it and the crossing is strict on both sides | **CORRECT**, and **UNDER-HYPOTHESISED**: it needs the domain $n\ge4$, which the prose never states and [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) does carry |
| C6 | Both inputs are $n$-uniform closed forms derived without reference to any threshold, so the crossing is not circular | **CORRECT** |
| C7 | At odd $n$, $\Theta_n^2\ge\tfrac32$ is $n^2-13n+18\ge0$, root $\tfrac{13+\sqrt{97}}2=11.4244$ | **CORRECT**, verified by hand from the sphere-product formula |
| C8 | "the integer threshold $12$ survives at both parities" | **TRUE BUT UNEVALUATED**, the block names the odd polynomial and evaluates it at no integer; the odd side turns on $n=13$, which appears nowhere |
| C9 | "the $\mathbb{CP}^2$-type competitor (Fox's $\mathcal S^4(\alpha)$)", the two named in apposition | **CONTRADICTED FIFTEEN LINES ABOVE**, by item 4 of the same file, whose correction landed inside the sentence and left its headline denial standing |
| C10 | [results.md](../results.md):302 and :112, "derived three independent ways" / "by three independent derivations" | **WITHDRAWN ON THE RECORD AND STILL STANDING IN THE CITABLE FORM** |

**Summary.** The number, the polynomial, both closed forms and the integer cutoff are correct at both parities and I re-derived all of them by hand; the block now carries a real argument where a prior audit found none, but its decisive lower witness is the even-$n$ constant read at an odd dimension, its odd-parity half is stated and never evaluated, and the two most citable sentences on the record ([results.md](../results.md):302 and [problem.md](../findings/problem.md):164) still carry claims the record itself has withdrawn.

**VERDICT: GAP.**

---

## 0. Conventions, fixed once

$\mathcal W_n$ is the space of Weyl (algebraic curvature, Ricci-flat) tensors, nonzero from $n\ge4$. $P(W)=\langle Q(W),W\rangle$ with $Q(W)=W^2+W^\#$, and $\theta(W)=P(W)/\lVert W\rVert^3$. Three constants must be kept apart, and [conventions.md](../findings/conventions.md):18–21 is the authority for all three:

| symbol | meaning | parity |
| --- | --- | --- |
| $\theta_0(n)$ | **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$ and nothing more** | a *value at an object* only at even $n$ |
| $\Theta_n$ | the diagonal maximum: $=\theta_0(n)$ at even $n$, $=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$ | both, by cases |
| $M(n)$ | the global maximum of $P$ on the unit sphere of $\mathcal W_n$ | both |

$\theta^*:=\sqrt{3/2}$ is the competitor's value. The block's whole displayed derivation runs at $\theta_0$; its closing paragraph alone runs at $\Theta_n$.

---

## 1. Hypothesis inventory

**A pass without one is not a pass, so here is the whole of it.**

### 1.1 Hypotheses the block carries in its own words

| # | Hypothesis | Stated where | Verdict against the object |
| --- | --- | --- | --- |
| H1 | The sphere-product formula $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ holds | asserted, sentence 1 | true on file; **unsourced in the block** (§3.1) |
| H2 | $p=q=n/2$ is admissible | implicit | **requires $n$ even**; never stated (§4) |
| H3 | The competitor's $\theta^2=\frac32$ at $n=4$ | asserted, sentence 2 | true; **no argument in the block** (§3.2) |
| H4 | $\mathfrak{su}(2)_+$ is a subalgebra of $\mathfrak{so}(n)$ | asserted, sentence 2 | true |
| H5 | The competitor is supported on $\Lambda^+\subset\Lambda^2\mathbb R^4$ | **unstated**, and H4 is useless without it | true of padded $W_{\mathbb{CP}^2}$; **the record denies it of the object the block names** (§5) |
| H6 | $6+2\sqrt7$ is the relevant root | asserted | true **only on $n\ge4$**; the polynomial has a second root $6-2\sqrt7=0.70850\ldots$ (§4.2) |
| H7 | $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ at odd $n$ | implicit in the closing paragraph, which gives only the polynomial | true, and I derive it in §2.3 |
| H8 | The near-balanced split maximises over sphere products at odd $n$ | **wholly unstated**, and $\Theta_n$ is meaningless without it | true, and I prove it in §2.3 |

### 1.2 Hypotheses of every result the block imports

| Imported | Its own hypotheses | Met here? |
| --- | --- | --- |
| $\theta(S^p\times S^q)^2$ closed form ([LEDGER.md](../findings/LEDGER.md):473, [r505](../reviews/REVIEW_r505.md) §1.1) | $p,q\ge2$, $n=p+q$, both factors Einstein-normalised, the [conventions.md](../findings/conventions.md) structure-constant normalisation | yes at every $n\ge4$ |
| $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$ at $n=4$ ([r505](../reviews/REVIEW_r505.md) §1.2, [Base/CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean):52) | $W_{\mathbb{CP}^2}\in\mathcal W_4$, symmetric, first Bianchi, Ricci-flat | yes, verified in the Lean base file |
| padding preserves $\lVert\cdot\rVert$, $\mathop{\mathrm{tr}}(\cdot^3)$, $\langle W^\#,W\rangle$ ([Base/Padding.lean](../lean/HamiltonsCubic/Base/Padding.lean)) | $W$ supported on a subalgebra of $\mathfrak{so}(m)\subset\mathfrak{so}(n)$ | yes for padded $W_{\mathbb{CP}^2}$; **see §5** |

### 1.3 Which of these the written proof actually uses

The proof uses H1, H3, H4, H6 and (silently), H2 and H5. It does **not** use H7 or H8 anywhere in the displayed derivation; they enter only in the closing paragraph, which is outside the $\square$. **This is the single structural fact behind every finding below**: the proof proper is an even-$n$ argument, and everything that makes the cutoff a cutoff at odd $n$ sits after the box, unevaluated.

**No finding on one head:** the proof uses no hypothesis about criticality, about $\ker W$, or about diagonalisability, and its statement claims none. It is a comparison of two *values*, and it needs the competitor only to lie in $\mathcal W_n$ with that value, never to be a critical point there. So [LEDGER.md](../findings/LEDGER.md):540's "L2 does not depend on it", written of the padded point's *criticality*, still holds, narrowly, and for a reason the ledger line does not give.

---

## 2. The mathematics, re-derived by hand

### 2.1 The balanced specialisation (C1)

With $p=q=n/2$: $(p-1)(q-1)=\left(\tfrac{n-2}2\right)^2=\tfrac{(n-2)^2}4$ and $pq=\tfrac{n^2}4$. So
$$\frac{2(n-1)\cdot\frac{(n-2)^2}4}{(n-2)\cdot\frac{n^2}4}=\frac{2(n-1)(n-2)}{n^2}.$$
**Confirmed.** [L2.lean](../lean/HamiltonsCubic/Results/L2.lean)'s `sphereProductSq_balanced` proves the same identity over $\mathbb R$ under `n ≠ 0`, `n ≠ 2`.

### 2.2 The threshold identity and its roots (C3, C5)

$$\frac{2(n-1)(n-2)}{n^2}-\frac32=\frac{4(n^2-3n+2)-3n^2}{2n^2}=\frac{n^2-12n+8}{2n^2}.$$
Roots: $n=\tfrac{12\pm\sqrt{144-32}}2=6\pm\tfrac{\sqrt{112}}2=6\pm2\sqrt7$, since $\sqrt{112}=4\sqrt7$. With $\sqrt7=2.6457513\ldots$, $6+2\sqrt7=11.2915026\ldots$ and $6-2\sqrt7=0.7084973\ldots$. $\sqrt7$ is irrational, so both roots are, and no integer is a zero. **Confirmed.**

### 2.3 The odd constant, derived rather than quoted (C7, H7, H8)

At odd $n$ take $p=\tfrac{n-1}2$, $q=\tfrac{n+1}2$. Then $p-1=\tfrac{n-3}2$, $q-1=\tfrac{n-1}2$, $pq=\tfrac{n^2-1}4$, and
$$\theta^2=\frac{2(n-1)\cdot\frac{(n-3)(n-1)}4}{(n-2)\cdot\frac{(n-1)(n+1)}4}=\frac{2(n-1)(n-3)}{(n-2)(n+1)}.$$
Setting this $\ge\tfrac32$: $4(n-1)(n-3)\ge3(n-2)(n+1)$, i.e. $4n^2-16n+12\ge3n^2-3n-6$, i.e. $n^2-13n+18\ge0$. Roots $\tfrac{13\pm\sqrt{97}}2$, and $\sqrt{97}=9.8488578\ldots$ gives $11.4244289\ldots$ and $1.5755710\ldots$. **The block's C7 is confirmed exactly.**

**H8, which the block never states, is a two-line fact.** Write $\theta(S^p\times S^q)^2=\frac{2(n-1)}{n-2}\left(1-\tfrac1p\right)\left(1-\tfrac1q\right)$. With $p+q=n$ fixed,
$$\left(1-\tfrac1p\right)\left(1-\tfrac1q\right)=1-\frac{p+q-1}{pq}=1-\frac{n-1}{pq},$$
strictly increasing in $pq$, which is maximal at the most balanced admissible split. **So $\Theta_n$ is attained at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ at either parity, and the block's $\Theta_n$ is well defined.** This is the argument [LEDGER.md](../findings/LEDGER.md):473 gestures at; it is nowhere in the block.

### 2.4 Cross-check against the conventions table

[conventions.md](../findings/conventions.md):18 records $\theta_0^2-\Theta_n^2=\frac{8(n-1)}{n^2(n+1)(n-2)}$ at odd $n$, from $(n-2)^2(n+1)-n^2(n-3)=4$. By hand: $(n^2-4n+4)(n+1)=n^3-3n^2+4$ and $n^2(n-3)=n^3-3n^2$, difference $4$; hence
$$2(n-1)\left[\frac{n-2}{n^2}-\frac{n-3}{(n+1)(n-2)}\right]=\frac{2(n-1)\cdot4}{n^2(n+1)(n-2)}=\frac{8(n-1)}{n^2(n+1)(n-2)}.$$
**Confirmed, and it is the load-bearing sign fact of §4.1: $\Theta_n<\theta_0(n)$ strictly at every odd $n\ge4$.**

### 2.5 The two integers, at both constants

| $n$ | $\theta_0(n)^2-\tfrac32$ | $\Theta_n^2-\tfrac32$ | attained? |
| --- | --- | --- | --- |
| $10$ | $\tfrac{-12}{200}=-\tfrac3{50}$ | same ($n$ even) | yes, $S^5\times S^5$ |
| $11$ | $\tfrac{-3}{242}$ | $\tfrac{-4}{2\cdot9\cdot12}=-\tfrac1{54}$ | **only the second**; $\Theta_{11}^2=\tfrac{40}{27}$ |
| $12$ | $\tfrac{8}{288}=\tfrac1{36}$ | same ($n$ even); $\theta_0(12)^2=\tfrac{55}{36}$ | yes, $S^6\times S^6$ |
| $13$ | $\tfrac{264}{169}-\tfrac32=\tfrac{9}{338}$ | $\tfrac{18}{2\cdot11\cdot14}=\tfrac9{154}$; $\Theta_{13}^2=\tfrac{120}{77}$ | **only the second** |

Every entry is an exact rational. $\Theta_{13}=\sqrt{120/77}=1.2483756\ldots$ against $\theta_0(13)=\sqrt{264/169}=1.2498521\ldots$, matching [results.md](../results.md):220 to seven places.

---

## 3. Pre-registered question 1, does the prose prove what the kernel imports?

[lean/INDEX.md](../lean/INDEX.md):278 says two things stay outside the kernel: **$\theta_0(n)^2$ for the balanced sphere product**, and **the extension of $\theta^2=\tfrac32$ from $n=4$ to every $n\ge4$ by padding**. I take them separately, and the answers differ.

### 3.1 $\theta_0(n)^2$, the block gives a CITATION, not a proof

The whole of what the block says is: *"The balanced product has $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$, the special case $p=q=n/2$ of $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$."*

The **specialisation** is a proof, one line, and I did it in §2.1. The **general formula** is asserted flat, with no derivation and **no reference of any kind**. Following the standing instruction to read the reports the record cites before recording an absence, I found the derivation exists twice: [r505](../reviews/REVIEW_r505.md) §1.1 builds it from the Einstein-normalised two-block spectrum $\left(\tfrac q{p-1},\tfrac p{q-1},-1\right)$ through $\lVert W\rVert^2=\frac{pq(n-1)(n-2)}{2(p-1)(q-1)}$ and $P=\lVert W\rVert^2(n-1)$, and [LEDGER.md](../findings/LEDGER.md):473 records it as validated by hand at audit; [target.md](../findings/target.md):494 records two reviewers deriving it independently.

**I checked r505's chain for internal consistency by hand.** With $A:=\lVert W\rVert^2$ and $P=A(n-1)$, $\theta^2=P^2/\lVert W\rVert^6=A^2(n-1)^2/A^3=(n-1)^2/A$, which is $\frac{2(n-1)(p-1)(q-1)}{pq(n-2)}$ exactly. At $S^2\times S^2$ the spectrum is $(2,2,-1^{\times4})$, traceless as required, $\lVert W\rVert^2=4+4+4=12$, matching $\frac{4\cdot3\cdot2}{2}=12$; and $\theta^2=\frac{2\cdot3\cdot1\cdot1}{2\cdot4}=\tfrac34$, matching $\theta_0(4)^2=\tfrac{12}{16}$ and [lean/INDEX.md](../lean/INDEX.md):273's $\Theta_4^2=\tfrac34$. **Self-consistent at every point I could reach without computation.**

**So the answer to the first half of question 1 is: the prose does not prove what the kernel imports here. It repeats it.** The proof is on the record, in a review and a ledger entry, and the block points at neither.

### 3.2 The competitor's value, the block PROVES the extension and IMPORTS the base

*"The competitor has $\theta^2=\frac32$ at every $n\ge4$, since $\mathfrak{su}(2)_+$ is a subalgebra and $W^\#$ therefore stays inside $\Lambda^+$ under padding."*

Unpacked, this is a real argument and it is correct. $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$; $\Lambda^+\cong\mathfrak{su}(2)_+$ is a Lie subalgebra of $\mathfrak{so}(4)\subseteq\mathfrak{so}(n)$; the inclusion $\Lambda^2\mathbb R^4\hookrightarrow\Lambda^2\mathbb R^n$ is isometric and a Lie homomorphism. If $W$ is supported on $\Lambda^+$ then $W^\#$, being the Lie square, is supported on $[\Lambda^+,\Lambda^+]\subseteq\Lambda^+$ and takes the same values there as it does at $n=4$; $\lVert W\rVert$ and $\mathop{\mathrm{tr}}(W^3)$ are untouched by padding by inspection. Hence $\theta$ is **exactly** $n$-independent. [r505](../reviews/REVIEW_r505.md) §1.3 spells this out; [Base/Padding.lean](../lean/HamiltonsCubic/Base/Padding.lean) formalises every ingredient, `trace_pad`, `pairing_pad`, and `pad_br`, whose own docstring says *"so `W#` stays inside, which is the `θ` [argument]"*.

**So the answer to the second half is: yes, the block does prove, as a compressed but sound sketch, exactly the step [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) declares unformalised.** That is the strongest single finding in this report's favour, and no round had read it.

**But the block establishes only the *invariance*, never the *value*.** The sentence proves "$\theta$ is the same at every $n$" and asserts "and it is $\sqrt{3/2}$". The base value has no argument in the block at all. It is proven twice elsewhere: by hand at [r505](../reviews/REVIEW_r505.md) §1.2, which I re-checked, $W=\mathop{\mathrm{diag}}(0,0,0,-1,-1,2)/\sqrt6$ gives $\lVert W\rVert^2=\tfrac{1+1+4}6=1$, $\mathop{\mathrm{tr}}(W^3)=\tfrac{-1-1+8}{6^{3/2}}=\tfrac1{\sqrt6}$, and with $[a_1,a_2]=-\sqrt2\,a_3$ so $\gamma^2=2$, $\langle W^\#,W\rangle=3\gamma^2w_1w_2w_3=\tfrac{12}{6^{3/2}}=\tfrac2{\sqrt6}$, whence $P=\tfrac3{\sqrt6}=\sqrt{3/2}$, and in the kernel at [Base/CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean):52 as `Pcubic WCP2 ^ 2 * 2 = 3 * (trace)^3`, rational where $\theta$ is not.

**The two forms are exactly complementary, and nothing on the record says so.** The kernel proves the base and owes the extension; the prose proves the extension and owes the base. Together they cover both; **neither alone covers either input completely**, and a consumer reading one form has no way to learn that the other closes its gap.

---

## 4. Pre-registered question 2, is the threshold a threshold in both directions?

### 4.1 The insufficiency direction, $n\le11$, DEFECT D1

**Locate it.** The block: *"whose numerator is $-3$ at $n=11$ and $+8$ at $n=12$."*

**Exhibit the failure concretely.** $n=11$ is **odd**. $S^{11/2}\times S^{11/2}$ does not exist, and by [conventions.md](../findings/conventions.md):18 $\theta_0(11)$ is *the closed form and nothing more*, it is the value at no object. The quantity that a consumer needs at $n=11$ is $\Theta_{11}$, and from §2.3, $\Theta_{11}^2=\frac{2\cdot10\cdot8}{9\cdot12}=\frac{40}{27}$, with $\Theta_{11}^2-\tfrac32=-\tfrac1{54}$; in the block's own "numerator" idiom the number is $-4$ (from $n^2-13n+18$), not $-3$. **The block's decisive lower witness for the cutoff is the even-$n$ constant read at an odd dimension**, the exact substitution the round before this one found, $\Theta_n$ against $\theta_0(n)$.

**And the witness is not replaceable by an even one without weakening the claim.** The sharpness of the cutoff $12$ requires a failure at $n=11$; the nearest even failure, $n=10$ at $-\tfrac3{50}$, establishes only $n\ge11$. **So the one integer at which the cutoff is sharp is the one integer at which the block names the wrong constant.**

**Argue the opposite.** The most charitable reading the words support: the block states in its own closing paragraph that *"the real root of the formally continued formula"* is one of the two exact things, so $-3$ is a legitimate statement about a formally continued function, and the conclusion is unharmed because §2.4's identity gives $\Theta_n<\theta_0(n)$ at every odd $n$, so $\theta_0(11)^2=\tfrac{180}{121}<\tfrac32$ implies $\Theta_{11}^2<\tfrac32$ **a fortiori**. That is right, and it is why this is a gap and not a break. **But the block never says it.** The monotone comparison $\Theta_n\le\theta_0(n)$ is the entire warrant for using the even constant at an odd dimension, it lives in [conventions.md](../findings/conventions.md) and nowhere in the block, and a consumer reading the block alone takes $-3$ as the value at $n=11$ and has the wrong number for the object. **Three steps met: located, exhibited at $n=11$ with the exact rationals, opposite argued. The defect stands.**

**Note also the direction-asymmetry**, which is what makes this more than pedantry: $\theta_0$ is a valid **upper** bound for $\Theta_n$, so substituting it is safe in the *insufficiency* direction and **unsafe in the sufficiency direction**, $\theta_0(n)^2>\tfrac32$ does *not* imply $\Theta_n^2>\tfrac32$ at odd $n$. The block uses it in the safe direction, but by accident of which integer it named rather than by any stated principle.

### 4.2 The sufficiency direction, $n\ge12$, CORRECT, with an unstated domain

$n=12$: numerator $+8$, $\theta_0(12)^2=\tfrac{55}{36}>\tfrac32$, attained at $S^6\times S^6$. For every integer $n\ge12$ the numerator is positive, since $12>6+2\sqrt7$ and the parabola opens upward. **Confirmed.** [L2.lean](../lean/HamiltonsCubic/Results/L2.lean)'s `threshold_pos` and `cutoff_is_twelve` carry it over $\mathbb Z$.

**DEFECT D2, the domain $n\ge4$ is absent from the prose and present in the kernel.** *"the root is irrational, so no integer attains it and the crossing is strict on both sides"* is true of non-attainment, but "the crossing is strict on both sides" as a statement about *which* side an integer falls on requires $n>6-2\sqrt7=0.70850$. Concretely: at $n=0$ the numerator is $+8$, on the wrong side. [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) states `threshold_neg {n : ℤ} (h4 : 4 ≤ n) (h11 : n ≤ 11)` and `cutoff_is_twelve {n : ℤ} (h4 : 4 ≤ n)`; the prose states neither, and it never says $\mathcal W_n\ne0$ needs $n\ge4$ either. **This is harmless in the geometry and is a genuine hypothesis the third form carries and the first does not.** Charitably: the whole file is about $\mathcal W_n$ and $n\ge4$ is ambient. That is the reading I accept, hence "under-hypothesised", not "wrong".

### 4.3 At the irrational root itself

At $n=6+2\sqrt7$, $\theta_0(n)^2=\tfrac32$ exactly: a tie, with neither overtaking. Since the root is irrational, no dimension sits there, so **there is no equality case and $11.2915\ldots$ is attained by nothing.** The block says this and it is correct. [L2.lean](../lean/HamiltonsCubic/Results/L2.lean)'s `crossover_root` and `crossover_irrational` prove both halves ($\sqrt7$ irrational by `Nat.Prime.irrational_sqrt`, closed under rational scaling and translation). **No finding.**

### 4.4 Both parities, DEFECT D3

**Locate it.** *"while the integer threshold $12$ survives at both parities."*

**Exhibit.** The claim is true: on $4\le n\le11$ the odd polynomial is negative (roots $1.5756$ and $11.4244$), and at $n=13$ it is $169-169+18=+18>0$, so the least admissible odd dimension is $13\ge12$ and the union statement "$\Theta_n^2>\tfrac32\iff n\ge12$" holds over all integers $n\ge4$. **But the block evaluates $n^2-13n+18$ at no integer whatever.** It gives the polynomial and the root and stops. The odd side of a two-sided threshold claim therefore rests on the reader performing an evaluation the block does not perform, and $n=13$, the integer that decides it, appears nowhere in the block, nowhere in [results.md](../results.md):88, and nowhere in [L2.lean](../lean/HamiltonsCubic/Results/L2.lean), whose `odd_threshold_pos` is stated at `12 ≤ n` and never instantiated. It is on the record once, in [r506](../reviews/REVIEW_r506.md) §F7.

**Argue the opposite.** $11.4244<12$ is visible in the block's own text, so the inference is one comparison. That is fair, and it is why this is a small gap. **But the round's brief asks whether the threshold is a threshold in both directions, and at odd parity the answer the block supports is "the reader can check that it is", not "it is shown here".** Three steps met. **The defect stands, at low severity.**

---

## 5. The competitor's identity, DEFECT D4, and it is the named trap

**Locate it.** The block: *"the balanced sphere-product overtakes the $\mathbb{CP}^2$-type competitor (Fox's $\mathcal S^4(\alpha)$)"* (the two named in apposition, as one object) and then the proof's only argument for the value at $n>4$ is *"$\mathfrak{su}(2)_+$ is a subalgebra and $W^\#$ therefore stays inside $\Lambda^+$ under padding"*, which is an argument about **padded $W_{\mathbb{CP}^2}$**.

**Exhibit concretely.** Fifteen lines above, in the same file, [problem.md](../findings/problem.md):149 item 4 opens: *"The literal '$\mathbb{CP}^2$ zero-padded into $\mathbb R^n$' **is not itself the competitor**, it is an idempotent at **every** $n\ge4$: $\mathfrak{su}(2)_+$ is a subalgebra, so $W^\#$ stays inside $\Lambda^+$ under padding and $Q(W)=\theta W$ holds exactly, with $\theta=\sqrt{3/2}$ independent of $n$"*, and then: *"The actual persistent low-dimensional competitor is a specific Ricci-flat linear combination of the round-sphere pattern and a $J$-correction on a fixed 4-plane ... exactly, term-by-term identified as Fox's $\mathcal S^4(\alpha)$."*

**Read as it stands, item 4 says the padding argument is about an object that is not the competitor, and L2's proof uses that argument for the competitor.** The record contradicts itself: [second-order.md](../findings/second-order.md):317 states flatly *"Fox $\mathcal S^4(\alpha)=$ padded $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$ exactly"*, while [problem.md](../findings/problem.md):149 denies the identification in its headline clause. [r506](../reviews/REVIEW_r506.md) §F6 already logged the contradiction (*"These two lines cannot both be right, and the contradiction is live in one file"*) and judged it **not load-bearing for L2** on the ground that *"the crossing consumes only the value ... which padding preserves whether or not the padded point is critical"*.

**That judgement is now stale, and this is the trap.** r506 read a block that contained **no proof at all**. The block has since acquired one, and its sole argument for the competitor's value beyond $n=4$ is the padding argument, which is sound for padded $W_{\mathbb{CP}^2}$ and, on item 4's own words, is an argument about the wrong object. Worse, item 4's correction has visibly landed **inside** the sentence and left its headline standing: r506 quotes item 4 as reading *"it is only an idempotent at $n=4,5$"*, the premise that once justified the words "is not itself the competitor"; that premise was corrected to *"an idempotent at every $n\ge4$"*, and **the denial it supported was left in place, together with the sentence naming a different tensor as the real competitor.** *A citation of L2 inherits an identification the file it sits in denies four sentences earlier.*

**Argue the opposite.** The most charitable reading: the two tensors are in fact the same element of $\mathcal W_n$. The Weyl part of a round-sphere curvature operator is zero, so a Ricci-flat combination of the round-sphere pattern with a $J$-correction on a fixed 4-plane projects onto exactly the padded $\mathbb{CP}^2$ Weyl tensor; [second-order.md](../findings/second-order.md):317 asserts the equality outright, and item 4's surviving "not itself the competitor" is stale wording from a superseded premise rather than a live mathematical claim. **I judge this reading correct.** Consequently the mathematics is safe and the number does not move.

**But the defect is not the mathematics; it is that the correction landed beside the statement it corrects, which is precisely the failure mode the brief names.** Read alone, as a consumer must, item 4 says the block's argument concerns a non-competitor. Three steps met. **The defect stands.**

**On the source.** [references/fox-2019-nonassociative-curvature-algebra/](../references/fox-2019-nonassociative-curvature-algebra/) is present, with the PDF, a text dump and notes. Its [notes.md](../references/fox-2019-nonassociative-curvature-algebra/notes.md):36–38 says only that *"$\mathcal S^4(\alpha)$ is constructed from the index formulas of §6"* and that the term-by-term match was made here. **So the record's identification of its competitor with Fox's object rests on a construction summarised in the notes and not reproduced in them; I did not verify the term-by-term match, which would require computation the analysis-only footing forbids.** The claim that $\mathcal S^4(\alpha)$ *equals* padded $W_{\mathbb{CP}^2}$ is the record's, not Fox's, and its warrant is a machine match recorded at [problem.md](../findings/problem.md):149 rather than an argument on file.

---

## 6. The three forms compared, and DEFECT D5

| Form | Carries what the others do not | Owes |
| --- | --- | --- |
| [problem.md](../findings/problem.md):160–176 | **the padding argument** for the competitor's $n$-independence; the odd-parity polynomial and root; the distinction between the real root and the integer cutoff; the correction-note withdrawing "three independent ways" | the sphere-product formula (cited, unsourced); the base value $\sqrt{3/2}$ at $n=4$; the domain $n\ge4$; any integer evaluation at odd parity |
| [results.md](../results.md):302 and :112 | nothing mathematical the block lacks | **it still asserts "derived three independent ways" / "by three independent derivations"** |
| [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) + [lean/INDEX.md](../lean/INDEX.md):278 | the domain hypothesis `4 ≤ n`; the cutoff as an **iff** (`cutoff_is_twelve`); the base value $\theta^2=\tfrac32$ at $n=4$ from `Q` ([Base/CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean):52); irrationality from `Nat.Prime.irrational_sqrt`; the odd polynomial's two sign theorems | $\theta_0(n)^2$ at general $n$; the padding extension |

**The row is accurate about what it owes, and it understates what the kernel has.** [lean/INDEX.md](../lean/INDEX.md):278 says the padding extension *"is not formalised"*. Strictly true of the composed statement, no theorem in [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) says $\theta(\mathrm{pad}\,W)=\theta(W)$, but every ingredient is proved in [Base/Padding.lean](../lean/HamiltonsCubic/Base/Padding.lean): `trace_pad`, `pairing_pad`, `pad_br`. **So the step the block rests on and the kernel disclaims is one composition away from being closed, and the row does not say so.** The brief warned that a `partial` row may owe exactly the step the block rests on; **it does, and that is the correct reading of the row.**

**DEFECT D5, the withdrawn claim survives in the citable form.** [LEDGER.md](../findings/LEDGER.md):544 records: *"'Derived three independent ways' is withdrawn"*, and [problem.md](../findings/problem.md):174's note repeats the withdrawal in the block itself. **[results.md](../results.md):302 still reads *"derived three independent ways"* and [results.md](../results.md):112 still reads *"in closed form and by three independent derivations"*.** [results.md](../results.md) is the summary form (the one a consumer reads and cites) and it carries a claim the record withdrew. **This is the named trap in its purest form: the correction sits in the file it corrects and never reached the file that repeats it.** Located, exhibited at two line numbers, and the charitable reading, that [results.md](../results.md) is a stale mirror rather than an independent assertion, does not help a consumer, who has no way to know which of two copies is current. **Stands.**

---

## 7. Every constant checked for parity dependence

| Constant | Parity-dependent? | Does the block's argument use it? |
| --- | --- | --- |
| $\sqrt{3/2}$, the competitor | **no**, $n$-independent by the padding argument, at either parity | **yes**, as the fixed side of the comparison |
| $\theta_0(n)$ | **a value at an object only at even $n$**; at odd $n$ it is a formal continuation, and strictly above the attained value by §2.4 | **yes**, it is the whole of the displayed derivation, including the $n=11$ evaluation (D1) |
| $\Theta_n$ | **yes, by cases**, per [conventions.md](../findings/conventions.md):19 | **only after the $\square$**, in the closing paragraph, and never evaluated (D3) |
| $M(n)$ | no | **not used**, and correctly so: L2 is a two-point comparison, not a statement about the global maximum |
| $n^2-12n+8$ | the even-parity crossing polynomial | yes |
| $n^2-13n+18$ | the odd-parity crossing polynomial | named, never evaluated |

**One inherited instance, out of scope and flagged.** [lean/INDEX.md](../lean/INDEX.md):273, the W5 row, states *"`Θₙ² < 3/2` is `n² - 12n + 8 < 0`, which holds exactly on `4 ≤ n ≤ 11`"*. **That equivalence is false at odd $n$**, where $\Theta_n^2<\tfrac32$ is $n^2-13n+18<0$, the same substitution as D1, in the index of the Lean form. Its two instances are $\Theta_4^2=\tfrac34$ and $\Theta_6^2=\tfrac{10}9$, both even, so W5's own content is unaffected and the conclusion "holds exactly on $4\le n\le11$" happens to be true at both parities. **I report it and do not adjudicate it: it is W5's row, not L2's.**

---

## 8. Quantifier order, scope, and the edges

- **Quantifier order.** The block's claim is $\forall n$ [comparison], with both closed forms fixed first. No quantifier is inverted and no constant is chosen after $n$. **No finding.**
- **Smallest admissible dimension.** $\mathcal W_n\ne0$ from $n=4$, where the balanced product is $S^2\times S^2$ and $\theta_0(4)^2=\tfrac34$. The sphere-product formula needs $p,q\ge2$, met throughout. The prose states no lower bound (D2); the kernel does.
- **Odd $n$.** The whole of D1 and D3. This is the edge the block half-covers.
- **$\ker W\ne0$.** Padded $W_{\mathbb{CP}^2}$ has kernel of dimension $\binom n2-3$ at every $n>4$, and the balanced product's Weyl operator has no zero eigenvalue in its two-block spectrum $\left(\tfrac q{p-1},\tfrac p{q-1},-1\right)$. **No finding: L2 uses no hypothesis on $\ker W$, and its statement claims none.** The record's kernel-sensitive results ([results.md](../results.md):555's *"$\Delta=0$ certifies equivariance only where $\ker W=0$"*) are downstream of L2 and do not feed it.
- **Criticality.** **No finding: the proof uses no criticality hypothesis.** [LEDGER.md](../findings/LEDGER.md):540's *"L2 does not depend on it"* survives, because the comparison consumes membership in $\mathcal W_n$ and a value, never idempotence.

---

## 9. What is proven, what is used, and what a consumer may cite

**Proven, on the union of the three forms:** for every integer $n\ge4$, the best two-factor sphere product satisfies $\Theta_n^2>\tfrac32$ if and only if $n\ge12$; the formally continued balanced value crosses $\tfrac32$ at the irrational $6+2\sqrt7$, attained by no dimension; at odd $n$ the attained crossing is at $\tfrac{13+\sqrt{97}}2$; and $\sqrt{3/2}$ is attained in $\mathcal W_n$ at every $n\ge4$.

**Used downstream:** [results.md](../results.md):13 cites L2 with L43 and L44 for *"$n\ge12$ necessary"*; [results.md](../results.md):37 for the bare crossing; [L44.lean](../lean/HamiltonsCubic/Results/L44.lean)'s row ([lean/INDEX.md](../lean/INDEX.md):264) composes L2's two sign theorems with the competitor's value at $n=4$ and records the padding map as owed. **The necessity half is what the record takes, and it is what L2 supports.**

**A consumer may cite:**
1. *"$\theta_0(n)^2-\tfrac32=\tfrac{n^2-12n+8}{2n^2}$, with root $6+2\sqrt7$, irrational."* Unqualified.
2. *"For every integer $n\ge4$: $\theta_0(n)^2>\tfrac32\iff n\ge12$."* Unqualified, but $\theta_0$ is the closed form, and at odd $n$ it is a value at no object.
3. *"For every integer $n\ge4$: $\Theta_n^2>\tfrac32\iff n\ge12$."* True and re-derived here in §2.3/§2.5, **but the block does not establish it, because it evaluates the odd polynomial nowhere. Cite [r506](../reviews/REVIEW_r506.md) §F7 or this report for the $n=11$ and $n=13$ evaluations.**
4. *"Conjecture A fails at every $4\le n\le11$"*, the necessity half, and it needs the padding step, which is the block's sketch and the kernel's declared debt.

**A consumer may NOT cite:** *"derived three independent ways"* ([results.md](../results.md):302 and :112, withdrawn at [LEDGER.md](../findings/LEDGER.md):544); *"the numerator is $-3$ at $n=11$"* as the value at the object in dimension 11 (it is $-4$); or the parenthesis *"the $\mathbb{CP}^2$-type competitor (Fox's $\mathcal S^4(\alpha)$)"* as an identification the file supports ([problem.md](../findings/problem.md):149 denies it in its headline).

---

## 10. What would break it, and what I did to look

**The falsifier.** An integer $n$ with $4\le n\le11$ at which some algebraic Weyl tensor of the compared families reaches $\Theta_n^2\ge\tfrac32$, or an integer $n\ge12$ at which the best sphere product falls short, either would destroy the cutoff at $12$.

**What I did.** I evaluated both crossing polynomials as exact rationals at $n=10,11,12,13$ (§2.5) and read their root structure: $n^2-12n+8$ has roots $0.70850$ and $11.29150$, $n^2-13n+18$ has roots $1.57557$ and $11.42443$, so on the integers $4\le n\le11$ both are strictly negative and from $n=12$ both are strictly positive, at either parity. I closed the split-choice loophole by proving in §2.3 that $\left(1-\tfrac1p\right)\left(1-\tfrac1q\right)=1-\tfrac{n-1}{pq}$ is strictly increasing in $pq$, so **no unbalanced split can beat the near-balanced one and no sphere product at $n\le11$ can reach $\tfrac32$**, the block never states this and it is what makes the falsifier search finite. I checked the competitor's side for a dimension-dependent leak by tracing the padding argument through $\lVert\cdot\rVert$, $\mathop{\mathrm{tr}}(\cdot^3)$ and $\langle W^\#,W\rangle$ separately, and against [Base/Padding.lean](../lean/HamiltonsCubic/Base/Padding.lean)'s `trace_pad` / `pairing_pad` / `pad_br`.

**No such object exists**, and none can: at every integer $n\ge4$ the comparison is between two exact rationals and $\tfrac32$. **The number is right at both parities. What is wrong is which constant the block names at the one dimension where the cutoff is sharp, that the odd half is asserted rather than evaluated, that one of the two inputs is a citation with no pointer, and that the summary form still carries a claim the record withdrew.**

---

## Verdict

**GAP.** The statement is true at both parities and I re-derived every part of it by hand. The block now carries a real argument where the prior audit found none, and, answering the round's first question, that argument **proves exactly the padding extension the kernel declares unformalised**, while **citing without a pointer the $\theta_0(n)^2$ the kernel imports** and **importing without argument the base value the kernel proves**. Answering the second question: the sufficiency direction is proved and the behaviour at the irrational root is correct, while **the insufficiency direction is witnessed at $n=11$ under the wrong constant** and **the odd-parity half of "12 survives at both parities" is evaluated at no integer**. Four one-line repairs close the gap: state the $n=11$ witness at $\Theta_{11}^2=\tfrac{40}{27}$ (or state $\Theta_n\le\theta_0(n)$ as the warrant for the substitution); evaluate $n^2-13n+18$ at $n=11$ and $n=13$; point at [LEDGER.md](../findings/LEDGER.md):473 or [r505](../reviews/REVIEW_r505.md) §1.1 for the sphere-product formula and at [Base/CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) for $\sqrt{3/2}$ at $n=4$; and propagate the two withdrawals into [results.md](../results.md):112 and :302. **None of them moves a number.**
