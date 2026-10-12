# VERIFY v143, Conjecture/Lemma L8: the dimension pinning $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$, the "finite check", and "settled across the classical families"

*Cold brief, verifier v143 of round [L08](ROUND_L08.md). **No numerical work was done**: no script was run, and every value below is an exact hand evaluation from the record's own tabulated Lie data. Log: [agent_logs/verify-L08-v143.log](../agent_logs/verify-L08-v143.log). Sources read: [findings/graded-half.md](../findings/graded-half.md):280–437, [results.md](../results.md):17, :92, :124, :367–370, [ATTEMPTS.md](../ATTEMPTS.md):1010–1110 and :1330–1362, [lean/INDEX.md](../lean/INDEX.md):345–362, [references/INDEX.md](../references/INDEX.md).*

## Claim table

| # | Claim, as written | Verdict |
| --- | --- | --- |
| C1 | The elimination step: $\theta=(qC-p)/\sqrt{pq(p+q)}$ together with (R1) $c_{\mathfrak k}=[C(2q-p)-2(p+q)]/q$ gives $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$ | **PROVEN**, exact algebraic identity, re-derived here |
| C2 | "An equivariant graded critical point (the Weyl operator of a compact symmetric pair $(\mathfrak{so}(n),\mathfrak k)$), **is pinned by its pair's dimensions**" by that formula ([results.md](../results.md):369) | **BROKEN**, false at $S^3\times S^5$ and $S^5\times S^7$; **undefined** at $(\mathfrak{so}(4),\mathfrak u(2))$, where $2q-p=0$ |
| C3 | "it reproduces the Ricci-flat Kähler family and the sphere pairs identically" ([results.md](../results.md):369) | **BROKEN** for the sphere pairs (unbalanced splits); **PROVEN** for the balanced splits and for $(\mathfrak{su}(m),\mathfrak{so}(m))$, both re-derived exactly here |
| C4 | The scope restriction to **equivariant** graded points | **PROVEN, hypotheses corrected**; carried correctly into [results.md](../results.md):369 |
| C5 | "the compact symmetric pairs being classified, the equivariant graded case is a finite check" | **HYPOTHESIS-DEBT**, the classification has no source in [references/](../references/), and the check is finite only per dimension, not over the record's $n\ge12$ range |
| C6 | "settled across the classical families" (the title, both files) | **GAP**, the unbalanced $(\mathfrak{sp}(m),\mathfrak{sp}(j)\oplus\mathfrak{sp}(m-j))$ class is named as unchecked at [ATTEMPTS.md](../ATTEMPTS.md):1107 and never closed |
| C7 | "the check that was run settles the **balanced splits only**" ([findings/graded-half.md](../findings/graded-half.md):427) | **BROKEN**, the unbalanced splits were solved by the ideal-wise system at [ATTEMPTS.md](../ATTEMPTS.md):1047–1049; I reproduce $S^5\times S^7$ exactly by hand |
| C8 | The label. [results.md](../results.md):124 and :22 say **Lemma L8**; [results.md](../results.md):367 and [findings/graded-half.md](../findings/graded-half.md):421 say **Conjecture L8** | **BROKEN**, under [results.md](../results.md):92's own literal-label rule these are different claims, one Gate-2-passed and one a candidate |
| C9 | Lean form | **No row exists.** [lean/INDEX.md](../lean/INDEX.md):359 buckets L8 as *out, needs the classification of compact symmetric spaces* |

**Overall verdict: `BROKEN`.** The general reduction (C1) is a correct identity and the two closed-form families (C3, positive half) are exact; but the canonical citable sentence at [results.md](../results.md):369 asserts the pinning **universally over compact symmetric pairs $(\mathfrak{so}(n),\mathfrak k)$**, and it is false at two sphere products the record itself names and undefined at the pair carrying the rival maximizer. The correction that would repair it exists **four lines below the same sentence in [findings/graded-half.md](../findings/graded-half.md) and nowhere in [results.md](../results.md)**, the record's named trap, realised.

## 0. Conventions, fixed once

- $(\mathfrak h,\mathfrak k)$ is a compact symmetric pair with $\mathfrak h=\mathfrak k\oplus\mathfrak m$, $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$, $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$; $p=\dim\mathfrak k$, $q=\dim\mathfrak m$. **$\mathfrak h$ is a subalgebra of $\mathfrak{so}(n)$, not necessarily $\mathfrak{so}(n)$ itself**, this is [ATTEMPTS.md](../ATTEMPTS.md):1035's convention and the one every worked example uses.
- All Casimirs are in the $\mathfrak{so}(n)$-induced normalisation, where the coordinate $2$-planes $e_i\wedge e_j$ are orthonormal. In it, $\mathfrak{so}(j)\subseteq\mathfrak{so}(N)$ has adjoint Casimir $c=2(j-2)$ and acts on $\mathbb R^j\otimes\mathbb R^{N-j}$ with $C=j-1$ ([ATTEMPTS.md](../ATTEMPTS.md):1041, :1047).
- $C$ is the Casimir of $\mathfrak k$ on $\mathfrak m$; $c_{\mathfrak k}$ is $\mathfrak k$'s adjoint Casimir on itself. Where $\mathfrak k=\bigoplus_i\mathfrak k_i$, the per-ideal constants are $p_i,C_i,c_i$.
- **Notation trap, flagged once.** In the pinning formula $p,q$ are $\dim\mathfrak k,\dim\mathfrak m$; in the closed form $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ quoted **in the same paragraph** ([findings/graded-half.md](../findings/graded-half.md):431) they are the two **sphere dimensions**. Two meanings of $(p,q)$, sixteen lines apart, inside one result.
- $\theta_0(n)$ is the balanced sphere product's value; $\sqrt{3/2}=1.224744871\ldots$ is the rival maximizer's.

## 1. The hypothesis inventory

**Hypotheses the block carries, in the order the argument consumes them.**

| # | Hypothesis | Stated where | Used where |
| --- | --- | --- | --- |
| H1 | $W$ is a critical point of $P$ on $\mathcal W_n$: $Q(W)=\theta W$ | both files | (R1) is the $\mathfrak k$-block of this equation |
| H2 | $W$ is **graded**: $\operatorname{ran}W_+\oplus\operatorname{ran}W_-$ is a $\mathbb Z_2$-graded subalgebra, $\mathfrak h$ | both files | the $\mathfrak m$-block equation holds **only** when $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$ ([ATTEMPTS.md](../ATTEMPTS.md):1025) |
| H3 | $W$ is **$\mathrm{ad}(\mathfrak p)$-equivariant** | both files, added at the scope refutation | Schur makes $W$ scalar on each irreducible summand, this is what licenses the ansatz |
| H4 | **$\mathfrak k$ is simple, or its ideals are interchanged by a symmetry of the pair**, i.e. $\mathfrak k$ acts on $\mathfrak m$ with a *single* Casimir | [ATTEMPTS.md](../ATTEMPTS.md):1039 only | the entire $c_{\mathfrak k}$-formula. **Absent from both [results.md](../results.md):124 and :369** |
| H5 | $2q>p$ (strictly; $2q=p$ is degenerate) | [ATTEMPTS.md](../ATTEMPTS.md):1039, :1362 | the denominator. **Absent from both [results.md](../results.md) forms** |
| H6 | $\mathfrak h$ acts **irreducibly on $\mathbb R^n$** | [ATTEMPTS.md](../ATTEMPTS.md):1035, :1029 | this is what makes $\mathrm{Ric}(W)$ scalar, so trace-freeness gives Ricci-flatness free. **Absent from both [results.md](../results.md) forms** |
| H7 | $\ker W=0$ | nowhere | the ansatz $W=(q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m})/\sqrt{pq(p+q)}$ has trivial kernel by construction, so points with a kernel inside $\mathfrak k$ are silently outside it |
| H8 | The **classification of compact symmetric pairs** | both files | "so the graded case is a finite check". No source in [references/](../references/) |
| H9 | The classification of **symmetric subalgebras of $\mathfrak{so}(N)$ up to conjugacy** | [ATTEMPTS.md](../ATTEMPTS.md):1059 | Step 8's closure of the non-conjugate-embedding loophole. No source; and it was **short by two** until [findings/graded-half.md](../findings/graded-half.md):402–419 added $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ at $N=8$ |

**Hypotheses of imported results, checked against the object they apply to.**

- **Lemma L7's equality class** ([results.md](../results.md):124) is *"a symmetric pair only when $\ker W=0$"*, and its ranges are graded **modulo $\ker W$**. L8 is the settlement of that equality class, so L8 inherits L7's kernel caveat, and H7 shows the ansatz does not honour it.
- **The $\Delta=0\iff\mathrm{ad}(\mathfrak p)$-equivariance equivalence** ([findings/bounds.md](../findings/bounds.md), quoted at [findings/graded-half.md](../findings/graded-half.md):425) is itself tagged **"(A) on a (C) point"** in the labelling table at :396, and the neighbouring row at :395 records that *"$\Delta=0\Rightarrow$ Lemma L69 applies"* is **UNSOUND off $\ker W=0$**. L8 quotes the equivalence as its mechanism without repeating the $\ker W=0$ side-condition.
- **Lemma L69** is invoked at [results.md](../results.md):369 to "carry the classification above $\sqrt{3/2}$". Its own hypotheses are $n\ge12$ and $\theta\ge\sqrt{3/2}$; its enumeration input carries the standing quotation rule **"$n\ne8$"** ([findings/graded-half.md](../findings/graded-half.md):415). Neither range is reproduced at [results.md](../results.md):369.

**Which of these the written argument actually uses.** H1, H2, H3, H4, H5, H6, H8. **H7 is used implicitly and stated nowhere.** H9 is used by the closure step that [findings/graded-half.md](../findings/graded-half.md):435 still lists as outstanding for $\mathfrak{su}$, $\mathfrak{sp}$ and the exceptional $\mathfrak h$.

*No finding: the block imports no result whose hypotheses fail at the object it is applied to, other than the kernel caveat at H7 and the L69 ranges above.*

## 2. Pre-registered question 1, what is established, and what is checked

The block is two different kinds of statement wearing one number. Separated:

### 2a. Proved for all objects in scope (the general reduction)

| statement | scope | status |
| --- | --- | --- |
| **The elimination identity.** Given $\theta=(qC-p)/\sqrt{pq(p+q)}$ and (R1), $\theta=\dfrac{c_{\mathfrak k}q^2+2q^2+p^2}{(2q-p)\sqrt{pq(p+q)}}$ | every $(p,q,C,c_{\mathfrak k})$ with $2q\ne p$ | **exact algebra**, re-derived in §3a |
| **The structure-constant double count.** $\sum_i c_ip_i+3q\sum_iC_i=c^{\mathrm{ad}}_{\mathfrak h}(p+q)$ | every $\mathbb Z_2$-graded $\mathfrak h$ | asserted at [ATTEMPTS.md](../ATTEMPTS.md):1033 from total antisymmetry; **not written out**, and checked at one point ($\mathbb{HP}^2$, $336=336$) |
| **The Casimir normalisation.** $c^{\mathrm{ad}}_{\mathfrak h}=\frac{2(p+q)}n\cdot\frac{C_2(\mathrm{adj})}{C_2(V)}$ | $\mathfrak h$ irreducible on $\mathbb R^n$ | pinned by the trace $\sum_{\alpha\in\mathfrak h}\operatorname{tr}(e_\alpha^2)=-2\dim\mathfrak h$; **the trace identity itself is asserted** |
| **Zero defect of every sphere product.** $\mathrm{Alt}(vv^{\mathsf T})\propto v\wedge v$, which vanishes iff $v$ is decomposable; $\mathfrak m$ for a block split is spanned by mixed coordinate $2$-planes, all decomposable, so $\mathrm{Alt}(\Pi_{\mathfrak m})=0$ | **every $N$, every split**, balanced or not | **PROVEN**, and I confirm the argument closes: $\mathrm{Alt}$ is linear and $\mathrm{Alt}(\mathrm{Id})=0$ for the same reason, so $\mathrm{Alt}(W)=-(a+b)\mathrm{Alt}(\Pi_{\mathfrak m})=0$ |
| **Two rank-uniform closed forms.** $(\mathfrak{so}(2m),\mathfrak{so}(m)\oplus\mathfrak{so}(m))\Rightarrow\theta=\sqrt{(m-1)(2m-1)}/m$ and $(\mathfrak{su}(m),\mathfrak{so}(m))\Rightarrow\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$ | all $m$ | **PROVEN**; both re-derived exactly in §3b |

### 2b. Verified family by family (the case-by-case settlement)

| family | how settled | bound on the check |
| --- | --- | --- |
| $(\mathfrak{so}(N),\mathfrak{so}(j)\oplus\mathfrak{so}(N-j))$ balanced | (R1) tested against true Casimirs, closed form in $m$ | all $m$ |
| the same, **unbalanced** | ideal-wise system solved, $181$ of $342$ consistent, $108$ above $\sqrt{3/2}$ ([ATTEMPTS.md](../ATTEMPTS.md):1047) | **$N\le40$ only** |
| $(\mathfrak{so}(2m),\mathfrak u(m))$ | operator built directly | **$n=6,8,10,12$ only**, four rows |
| $(\mathfrak{su}(m),\mathfrak{so}(m))$ | (R1) verified by hand for all $m$ | all $m$ |
| $(\mathfrak{su}(m),\mathfrak s(\mathfrak u(j)\oplus\mathfrak u(m-j)))$ | operator built directly | **nine rows, $n\le12$** |
| $(\mathfrak{sp}(2j),\mathfrak{sp}(j)\oplus\mathfrak{sp}(j))$, $(\mathfrak{su}(2k),\mathfrak{sp}(k))$ | (R1) inconsistent; the second in exact rational arithmetic for all $k$ | all $j$, all $k$ |
| $(\mathfrak{sp}(m),\mathfrak u(m))$ | operator rebuilt after a construction bug ([ATTEMPTS.md](../ATTEMPTS.md):1334) | **four rows** |
| $(\mathfrak{sp}(m),\mathfrak{sp}(j)\oplus\mathfrak{sp}(m-j))$, $j\ne m-j$ | **never checked**, named as owed at [ATTEMPTS.md](../ATTEMPTS.md):1107 |, |
| exceptional $\mathfrak h$ | Lie-data dictionary; **two of twelve pairs properly computed, five rejected, the non-simple-$\mathfrak k$ pairs screened rather than solved** ([ATTEMPTS.md](../ATTEMPTS.md):1362) |, |

**So: "settled across the classical families" is a `GAP`.** Two classical entries are open (the unbalanced quaternionic Grassmannians, and every unbalanced real Grassmannian with $N>40$) and the exceptional families are screened, not solved. The record says both things itself, in [ATTEMPTS.md](../ATTEMPTS.md); neither survives into [results.md](../results.md):367, whose title asserts the settlement flatly.

*The one thing that does cover the tail:* [Lemma L69](../findings/graded-half.md#lemma-l69-above-sqrt32-the-only-equivariant-graded-points-are-sphere-products-with-both-factors-ge5-and-all-of-them-are-nondegenerate) reaches every $n$ by a norm-budget inequality rather than a sweep. But L69 is a **different result with a different proof**, and it does not use L8's formula, [findings/graded-half.md](../findings/graded-half.md):369 records that the first version of L69 credited its key sentence *to L8, which assumes it*. A consumer who cites L8 for coverage above $\sqrt{3/2}$ is citing the wrong lemma.

## 3. Pre-registered question 2, does the value follow from the pair's dimensions and one Casimir ratio?

### 3a. The derivation, in full

From (R1) at [ATTEMPTS.md](../ATTEMPTS.md):1016, $c_{\mathfrak k}q=C(2q-p)-2(p+q)$, so provided $2q\ne p$,

$$C=\frac{q\,c_{\mathfrak k}+2(p+q)}{2q-p}.$$

Substituting into $\theta\sqrt{pq(p+q)}=qC-p$:

$$\theta\sqrt{pq(p+q)}=\frac{q^2c_{\mathfrak k}+2q(p+q)}{2q-p}-p=\frac{q^2c_{\mathfrak k}+2pq+2q^2-2pq+p^2}{2q-p}=\frac{c_{\mathfrak k}q^2+2q^2+p^2}{2q-p}.$$

**The identity is exact.** It needs, and only needs: (i) the two-eigenvalue ansatz, which supplies $\theta=(qC-p)/\sqrt{pq(p+q)}$; (ii) (R1), the $\mathfrak k$-block of criticality, which needs $A_{\mathfrak{mm}}=qC/p$, an index count valid only when a *single* $C$ exists (**H4**); (iii) $2q\ne p$ (**H5**). So the value follows from $(p,q,c_{\mathfrak k})$ (and $c_{\mathfrak k}$ from $(p,q,n,C_2(\mathrm{adj})/C_2(V))$), **on the class where H4 and H5 hold, and there only**.

### 3b. Named pairs where the formula is right, both re-derived exactly

**Balanced sphere pair $(\mathfrak{so}(2m),\mathfrak{so}(m)\oplus\mathfrak{so}(m))$.** $p=m(m-1)$, $q=m^2$, $p+q=m(2m-1)$, $c_{\mathfrak k}=2(m-2)$ (the two ideals share one Casimir, so H4 holds by interchangeability). Then

- numerator $=2(m-2)m^4+2m^4+m^2(m-1)^2=2m^4(m-1)+m^2(m-1)^2=m^2(m-1)(2m^2+m-1)=m^2(m-1)(2m-1)(m+1)$;
- $2q-p=2m^2-m^2+m=m(m+1)$, and $\sqrt{pq(p+q)}=\sqrt{m(m-1)\cdot m^2\cdot m(2m-1)}=m^2\sqrt{(m-1)(2m-1)}$;
- $\theta=\dfrac{m^2(m-1)(2m-1)(m+1)}{m^3(m+1)\sqrt{(m-1)(2m-1)}}=\dfrac{\sqrt{(m-1)(2m-1)}}m.$

At $m=6$ ($n=12$): $\theta=\sqrt{55}/6$, $\theta^2=55/36$, identical to the record's exact rational for the $6{+}6$ split ([findings/graded-half.md](../findings/graded-half.md):466) and to $\theta_0(12)=1.236033081$. **Reproduced identically, as claimed.**

**Ricci-flat Kähler family $(\mathfrak{su}(m),\mathfrak{so}(m))$.** $p=\tfrac{m(m-1)}2$, $q=\tfrac{(m-1)(m+2)}2$, $C=m$, $c_{\mathfrak k}=m-2$. Check (R1) independently of the code: $2q-p=\tfrac{(m-1)(m+4)}2$, $p+q=(m-1)(m+1)$, so

$$\frac{C(2q-p)-2(p+q)}q=\frac{(m-1)\big[\tfrac{m(m+4)}2-2(m+1)\big]}{\tfrac{(m-1)(m+2)}2}=\frac{m^2-4}{m+2}=m-2=c_{\mathfrak k}.\quad\checkmark$$

And $qC-p=\tfrac{m(m-1)(m+1)}2$, $pq(p+q)=\tfrac{m(m-1)^3(m+1)(m+2)}4$, so $\theta^2=\dfrac{m(m+1)}{(m-1)(m+2)}$, **exactly $3/2$ at $m=2$, i.e. Fox at the rival maximizer's value.** Reproduced identically, as claimed.

**Fox directly, as $(\mathfrak{su}(2),\mathfrak u(1))$ with $\mathfrak h=\mathfrak{su}(2)\subset\mathfrak{so}(4)$:** $p=1$, $q=2$, $c_{\mathfrak k}=0$ (abelian), $2q-p=3$, $pq(p+q)=6$, giving $\theta=(0+8+1)/(3\sqrt6)=3/\sqrt6=\sqrt{3/2}$. Exact.

### 3c. The named pair where the two sides differ, $S^3\times S^5$, $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$

$\mathfrak k=\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ has $c_1=2(3-2)=2$ on one ideal and $c_2=2(5-2)=6$ on the other. **H4 fails: there is no single $c_{\mathfrak k}$.** The record's own claim ([findings/graded-half.md](../findings/graded-half.md):429) is that forcing one would require an irrational Casimir. I confirm it exactly. With $p=13$, $q=15$, $2q-p=17$, $pq(p+q)=13\cdot15\cdot28=5460=2^2\cdot3\cdot5\cdot7\cdot13$, and the true value $\theta=\sqrt{56/45}$ (from $\theta^2=\frac{2(n-1)(p_s-1)(q_s-1)}{(n-2)p_sq_s}=\frac{2\cdot7\cdot2\cdot4}{6\cdot15}=\frac{56}{45}$ at sphere dimensions $3,5$):

$$225\,c_{\mathfrak k}+450+169=\sqrt{\tfrac{56}{45}}\cdot17\cdot2\sqrt{1365}=34\sqrt{\tfrac{56\cdot1365}{45}}=34\sqrt{\tfrac{5096}3}=\frac{34\cdot14\sqrt{26}}{\sqrt3}=\frac{476\sqrt{78}}3,$$

so $c_{\mathfrak k}=\big(\tfrac{476\sqrt{78}}3-619\big)/225$, **irrational**, while every adjoint Casimir in this normalisation is the integer $2(j-2)$. The pinning formula therefore has **no admissible input** at $S^3\times S^5$. Confirmed.

### 3d. What *does* pin the value there, the ideal-wise system, verified exactly by hand at two pairs

The record's replacement ([ATTEMPTS.md](../ATTEMPTS.md):1021) is, with $W=\sum_ia_i\Pi_{\mathfrak k_i}-b\,\Pi_{\mathfrak m}$:

$$\text{(E1)}\ b-\sum_ia_iC_i=-\theta,\quad\text{(E2)}_i\ a_i^2+\tfrac12\Big[c_ia_i^2+\tfrac{qC_i}{p_i}b^2\Big]=\theta a_i,\quad\text{(E3)}\ \sum_ip_ia_i=qb,\quad\text{(E4)}\ \sum_ip_ia_i^2+qb^2=1.$$

**At $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$:** $p_1=3$, $p_2=10$, $q=15$, $C_1=2$, $C_2=4$, $c_1=2$, $c_2=6$. Put $a_1=\alpha b$, $a_2=\beta b$. (E2)$_1$: $\alpha^2+\tfrac12[2\alpha^2+10]=\theta\alpha/b$; (E2)$_2$: $\beta^2+\tfrac12[6\beta^2+6]=\theta\beta/b$; (E1): $\theta/b=2\alpha+4\beta-1$. Eliminating, $2\alpha^2+5=\alpha(2\alpha+4\beta-1)$ gives $5=4\alpha\beta-\alpha$, and $4\beta^2+3=\beta(2\alpha+4\beta-1)$ gives $3=2\alpha\beta-\beta$. Solving: $\alpha=5/(4\beta-1)$, then $2\beta\cdot5/(4\beta-1)-\beta=3\Rightarrow10\beta-\beta(4\beta-1)=3(4\beta-1)\Rightarrow-4\beta^2+11\beta=12\beta-3\Rightarrow4\beta^2+\beta-3=0\Rightarrow\beta=3/4$ (or $-1$), whence $\alpha=5/2$.
**(E3) is the consistency check and was not used:** $3\cdot\tfrac52+10\cdot\tfrac34=7.5+7.5=15=q$. $\checkmark$ **Exact.**
(E4): $\big(3\cdot\tfrac{25}4+10\cdot\tfrac9{16}+15\big)b^2=\tfrac{315}8b^2=1$, so $b^2=8/315$; and $\theta=(2\cdot\tfrac52+4\cdot\tfrac34-1)b=7b$, so $\theta^2=49\cdot\tfrac8{315}=\tfrac{392}{315}=\tfrac{56}{45}$. **$\theta=\sqrt{56/45}=1.115546702\ldots$ exactly**, the recorded value, from tabulated Lie data alone, with no operator built.

**At $S^5\times S^7$, $(\mathfrak{so}(12),\mathfrak{so}(5)\oplus\mathfrak{so}(7))$:** $p_1=10$, $p_2=21$, $q=35$, $C_1=4$, $C_2=6$, $c_1=6$, $c_2=10$. (E2)$_1$ becomes $4\alpha^2+7=\alpha(4\alpha+6\beta-1)$, i.e. $7=6\alpha\beta-\alpha$; (E2)$_2$ becomes $6\beta^2+5=\beta(4\alpha+6\beta-1)$, i.e. $5=4\alpha\beta-\beta$. Then $\alpha=7/(6\beta-1)$ and $28\beta-\beta(6\beta-1)=5(6\beta-1)$, i.e. $6\beta^2+\beta-5=0$, i.e. $\beta=5/6$, $\alpha=7/4$.
**(E3), again unused in the solve:** $10\cdot\tfrac74+21\cdot\tfrac56=17.5+17.5=35=q$. $\checkmark$ **Exact.**
(E4): $\big(\tfrac{490}{16}+\tfrac{525}{36}+35\big)b^2=\tfrac{1925}{24}b^2=1$; $\theta=(4\cdot\tfrac74+6\cdot\tfrac56-1)b=11b$, so

$$\theta^2=\frac{121\cdot24}{1925}=\frac{2904}{1925}=\frac{264}{175},$$

matching **both** the record's exact rational for the $5{+}7$ split and the independent closed form $\frac{2\cdot11\cdot4\cdot6}{10\cdot35}=\frac{264}{175}$. Three routes agree exactly; $\theta=1.228239\ldots$

**Answer to question 2.** *The value does follow from the pair's dimension data and tabulated Casimirs*, but through the **ideal-wise system**, which needs one Casimir pair $(C_i,c_i)$ **per simple ideal**, not "one Casimir ratio". The single-ratio sentence is true exactly on the sub-class where $\mathfrak k$ presents a single Casimir; that class is the balanced splits, $(\mathfrak{su}(m),\mathfrak{so}(m))$, Fox, and the simple-$\mathfrak k$ exceptional pairs. **[results.md](../results.md):124's "one Casimir ratio" and :369's "three integers and one table lookup" are false as universal statements over compact symmetric pairs.**

## 4. Pre-registered question 3, what does "finite" rest on?

**The classification named.** Two, in fact, and the block conflates them.

1. **Cartan's classification of compact symmetric pairs**, invoked verbatim: *"Since the compact symmetric pairs are classified, the graded case is then a finite check"* ([findings/graded-half.md](../findings/graded-half.md):427, [results.md](../results.md):369).
2. **The classification of symmetric subalgebras of $\mathfrak{so}(N)$ up to conjugacy**, invoked at [ATTEMPTS.md](../ATTEMPTS.md):1059 to close the non-conjugate-embedding loophole: *"Symmetric subalgebras of $\mathfrak{so}(N)$ are classified up to conjugacy: the blocks $\mathfrak{so}(j)\oplus\mathfrak{so}(N-j)$ and $\mathfrak u(N/2)$."*

**Is the source on file? No.** [references/INDEX.md](../references/INDEX.md) lists 63 sources; **there is no Cartan, Helgason, Berger or Besse entry**, and no entry for any symmetric-space classification. [wolf-1968-isotropy-irreducible](../references/wolf-1968-isotropy-irreducible/) classifies isotropy-irreducible homogeneous spaces, which is a different list; [petersen-stanfield-2025-poincare-polynomials](../references/petersen-stanfield-2025-poincare-polynomials/) is explicitly ruled out as a substitute, its own index card records *"Closing the graded enumeration by citation from their tables is unsound"*, and [findings/graded-half.md](../findings/graded-half.md):460 gives the reason: they classify symmetric **spaces**, while the enumeration needs symmetric **pairs $(\mathfrak h,\mathfrak k)$ with $\mathfrak h\subseteq\mathfrak{so}(n)$**. **So both classifications rest on unread sources.** [lean/INDEX.md](../lean/INDEX.md):359 records this in the record's own voice, bucketing L8 as *out, needs machinery Mathlib does not have: the classification of compact symmetric spaces*.

**And the second classification was demonstrably incomplete as quoted.** [findings/graded-half.md](../findings/graded-half.md):402–419 records that the $\mathbb Z_2$-grading enumeration the record had been quoting *"is complete only for $n\ne8$"*, and that the $N=8$ row was **short by two**, $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$, both acting irreducibly on $\mathbb R^8$, so **no element of $O(8)$ carries either to a block $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$**. That is a classification recited from memory being wrong, caught internally. It is the strongest available reason not to grant the other one on the same footing.

**What "finite" actually means here, and it is not what the sentence says.** Cartan's list is finite in **families**, not in pairs: $(\mathfrak{so}(N),\mathfrak{so}(j)\oplus\mathfrak{so}(N-j))$ is one entry and infinitely many pairs. The programme's target runs over **all $n\ge12$**. So a check over the classification is finite only when each family is closed in **closed form in the rank**, or truncated at some $N$. The record does both, in different places:

| covered rank-uniformly | truncated |
| --- | --- |
| balanced spheres (§3b), $(\mathfrak{su}(m),\mathfrak{so}(m))$ (§3b), $\mathbb{CP}^m$, $(\mathfrak{sp}(2j),\mathfrak{sp}(j)^{\oplus2})$ and $(\mathfrak{su}(2k),\mathfrak{sp}(k))$ rejections, the zero-defect proof | **the unbalanced real Grassmannians ($N\le40$)**, $SO(2m)/U(m)$ (four rows), the complex Grassmannians (nine rows), $Sp(m)/U(m)$ (four rows) |

**So what the check would have to exhaust if the classification were unavailable** is every $\mathbb Z_2$-graded subalgebra $\mathfrak k\subseteq\mathfrak h\subseteq\mathfrak{so}(n)$ up to $O(n)$-conjugacy, at every $n\ge12$, an infinite problem with no bound on $\dim\mathfrak h$ from the block itself. The one place the record escapes this is **[Lemma L69](../findings/graded-half.md#lemma-l69-above-sqrt32-the-only-equivariant-graded-points-are-sphere-products-with-both-factors-ge5-and-all-of-them-are-nondegenerate)**, whose proof runs on the norm budget $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13$ and an invariant count, and which [findings/graded-half.md](../findings/graded-half.md):383 states *"no longer needs the classification"*. **That escape belongs to L69, not to L8**, and L69's own invariant count is asserted uniform over the gradings, with the supporting commutant measurement taken at five pairs at $n=8$ and $n=10$, outside L69's own $n\ge12$.

**Verdict on C5: `HYPOTHESIS-DEBT`.** What would have to be shown, exactly: **(i)** a citable classification of compact symmetric pairs $(\mathfrak h,\mathfrak k)$ with $\mathfrak h\subseteq\mathfrak{so}(n)$ acting irreducibly, read into [references/](../references/); **(ii)** a rank-uniform closed form or exclusion for each family in that list, since the list is finite only in families; **(iii)** the conjugacy statement of [ATTEMPTS.md](../ATTEMPTS.md):1059 in its corrected $n\ne8$ form, from a source.

## 5. Quantifier order, scope, and the edge of every range

**Quantifier order.** The block's implication runs **pair $\Rightarrow$ value**, and [findings/graded-half.md](../findings/graded-half.md):417 states this explicitly: *"its variables **are** the pair, so its implication runs pair $\Rightarrow$ value and never point $\Rightarrow$ pair."* That is the right way round and it is stated. **But [results.md](../results.md):369 opens with the other direction** (*"An equivariant graded critical point), the Weyl operator of a compact symmetric pair $(\mathfrak{so}(n),\mathfrak k)$ (is pinned by…"*), quantifying over **points** and asserting each is a pair's Weyl operator. The correspondence point $\Rightarrow$ pair is exactly what [findings/graded-half.md](../findings/graded-half.md):417 says **L8 assumes rather than supplies**. The canonical form has the quantifier the findings file warns against.

**The edges, one at a time.**

| edge | what happens |
| --- | --- |
| **Smallest admissible $n$** | **L8 states no range at all.** Its two files give no $n\ge12$, no $n\ge5$, nothing. Consequences below. |
| **$2q=p$** | The formula is $0/0$. This is not hypothetical: $(\mathfrak{so}(4),\mathfrak u(2))$ has $p=\dim\mathfrak u(2)=4$, $q=\dim\mathfrak m=6-4=2$, so $2q-p=0$ **exactly**. [findings/graded-half.md](../findings/graded-half.md):284 records that $W_{\mathbb{CP}^2}$ at $n=4$ **is** the unique $\mathrm{ad}(\mathfrak u(2))$-invariant tensor of that pair. So the formula is undefined at the pair carrying the record's rival maximizer, $\theta=\sqrt{3/2}$, the most-cited value in the programme. [ATTEMPTS.md](../ATTEMPTS.md):1362 knows $2q=p$ is degenerate; neither [results.md](../results.md) form says so. |
| **$2q<p$** | The formula returns a **negative** $\theta$ with a positive numerator. At $(\mathfrak{so}(8),\mathfrak{so}(7))$: $p=21$, $q=7$, $c_{\mathfrak k}=10$, numerator $=10\cdot49+2\cdot49+441=1029$, $2q-p=-7$, so $\theta=-1029/(7\sqrt{4116})<0$. The screen catches it; the canonical statement does not mention it. |
| **$\ker W\ne0$** | The ansatz $W=(q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m})/\sqrt{pq(p+q)}$ has **trivial kernel by construction**, so every graded point with a kernel inside $\mathfrak k$ is silently outside L8. $W_{\mathbb{CP}^2}$ at $n=4$ is such a point, [findings/graded-half.md](../findings/graded-half.md):284: *"its kernel carries $3$ of $6$"*, matching $a_1=0$ on the $\mathfrak{su}(2)$ ideal of $\mathfrak u(2)$. This is the **second, independent** way L8 misses the rival maximizer. And [Lemma L7](../results.md), whose equality class L8 settles, is stated with its ranges graded **modulo $\ker W$** and is *"a symmetric pair only when $\ker W=0$"*, so L7 hands L8 a class wider than L8's ansatz can represent. |
| **Odd $n$** | *No finding.* Block splits $\mathfrak{so}(j)\oplus\mathfrak{so}(n-j)$ exist at odd $n$ and the derivations of §3 are parity-blind; $\mathfrak u(n/2)$ simply does not arise. Nothing in L8 breaks at odd $n$, and nothing in L8 is stated only for even $n$. |
| **Reducible / non-equivariant** | Correctly excluded, and the exclusion is carried into [results.md](../results.md):369. See §6, candidate D. |
| **$n=8$** | The enumeration L8's finiteness rests on carries a standing *"$n\ne8$"* ([findings/graded-half.md](../findings/graded-half.md):415). **Neither [results.md](../results.md) form carries it**, and the block's own headline counterexample lives at $n=8$. |

**A universal claim tested at one object from each family in scope** (question: does the *sentence at [results.md](../results.md):369* hold?):

| family | object | verdict |
| --- | --- | --- |
| real Grassmannian, balanced | $S^6\times S^6$, $n=12$ | **holds**, $\theta=\sqrt{55}/6$ (§3b) |
| real Grassmannian, unbalanced | $S^5\times S^7$, $n=12$ | **fails**, no single $c_{\mathfrak k}$; the ideal-wise system gives $\theta^2=264/175$ (§3d) |
| real Grassmannian, unbalanced | $S^3\times S^5$, $n=8$ | **fails**, would need an irrational Casimir (§3c) |
| Hermitian $SO(2m)/U(m)$ | $(\mathfrak{so}(6),\mathfrak u(3))$ | **fails**, $\mathfrak u(3)$ is not simple and has a centre; [findings/target.md](../findings/target.md):355 records that $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ fails whenever $\mathfrak k$ has a centre, *"and every Hermitian symmetric pair has a centre in $\mathfrak k$"* |
| Ricci-flat Kähler | $(\mathfrak{su}(m),\mathfrak{so}(m))$, all $m$ | **holds** (§3b) |
| complex Grassmannian | $\mathbb{CP}^m$, $m\ge4$ | **fails**, per [findings/graded-half.md](../findings/graded-half.md):429 |
| quaternionic | $(\mathfrak{sp}(2j),\mathfrak{sp}(j)^{\oplus2})$ | **vacuous**, no such critical point; (R1) returns $-2.625,-1.417,-0.313$ at $j=2,3,4$ |
| **exceptional** | $G_2/(\mathfrak{su}(2)+\mathfrak{su}(2))$, $n=7$, $\theta=5\sqrt3/8$ | **fails**, $\mathfrak k$ non-simple; [ATTEMPTS.md](../ATTEMPTS.md):1362 states the non-simple exceptional pairs are *"screened rather than solved, since the two-eigenvalue dictionary does not strictly apply to them"* |

**Three of eight families hold; five fail or are vacuous.** The sentence at [results.md](../results.md):369 is universally quantified over compact symmetric pairs and is false on the majority of them.

## 6. The four forms compared, and what each calls this result

| where | heading | what it asserts | what it omits |
| --- | --- | --- | --- |
| [findings/graded-half.md](../findings/graded-half.md):421 | **"Conjecture L8 (the graded case reduced to a finite check, and settled across the classical families), canonical statement and proof"** | the full sentence, **preceded** by SCOPE REFUTED and **followed four lines later** by the refutation box |, (this is the only complete form) |
| [results.md](../results.md):367 | **"Conjecture L8, the graded case reduced to a finite check, and settled across the classical families"** | the pinning, the Casimir reduction, the finite check, "reproduces the Ricci-flat Kähler family and the sphere pairs identically"; **carries the equivariance restriction** | **H4** (single Casimir), **H5** ($2q>p$), **H6** (irreducibility), the balanced-splits restriction, the $n\ne8$ quotation rule, the whole r503/r504 refutation |
| [results.md](../results.md):124 | **"Lemma L8 (landscape)"** | *"An equivariant graded point's value follows from its pair's dimensions and one Casimir ratio"*; *"Every equivariant graded point above the rival maximizer is a sphere product"* | the same, plus it upgrades the label |
| [results.md](../results.md):17 (state table) | *"Graded half … over equivariant graded points, **Settled** (Lemmas 7, 8, 23, 69)"* | settlement | the same; L8 is a Lemma here too |
| [lean/INDEX.md](../lean/INDEX.md):359 | **no row.** Bucketed *"out (needs machinery Mathlib does not have: L46, L47, L48, L8), the classification of compact symmetric spaces"* | (|), |

**Report on the difference in what the files call this result.** [results.md](../results.md):92 fixes the labels *literally*: **"Lemma is proven with Gate 1 and Gate 2 passed, Observation is verified numerically at the dimensions stated, Conjecture is a candidate."** [results.md](../results.md) therefore calls L8 a **Lemma** twice (:22, :124) and a **Conjecture** once (:367), in the same file, under a rule that makes those different claims. [findings/graded-half.md](../findings/graded-half.md) heads it **Conjecture** at :421 and refers to it as **Lemma L8** at :284, :309, :391 and :415. Independently, the block's own first line marks the scope refutation *"Candidate, Gate 2 owed"* while the refutation box below it is Gate-2 complete (*"[r503](../reviews/REVIEW_r503.md) and [r504](../reviews/REVIEW_r504.md) on identical briefs, both REFUTED"*), two Gate-2 states inside one block, for two different corrections.

**What a Lean row would have to claim, if one existed.** Not the settlement, that needs the classification, which is why the row is in the *out* bucket. The formalisable part is exactly §3a: **given** $p,q,C,c_{\mathfrak k}$ with $2q\ne p$, $qc_{\mathfrak k}=C(2q-p)-2(p+q)$ and $\theta\sqrt{pq(p+q)}=qC-p$, **then** $\theta(2q-p)\sqrt{pq(p+q)}=c_{\mathfrak k}q^2+2q^2+p^2$. That is a field identity over $\mathbb R$ with one side condition, and it is the whole of what L8 proves unconditionally.

## 7. The gap between what is proven and what is used

**Proven, unconditionally:** the elimination identity (§3a); the two rank-uniform closed forms (§3b); the zero-defect statement for every sphere product at every split and every dimension (§2a).

**Used downstream:** [results.md](../results.md):17 lists L8 among the four lemmas that make the graded half **"Settled"**; [findings/INDEX.md](../findings/INDEX.md):20 says *"Lemma L8 pins $\theta$ from the pair's dimensions"*; the brief records the result is cited eight or more times.

**The gap.** The settlement above $\sqrt{3/2}$ is L69's, by a norm budget that never touches L8's formula. L8's formula covers the balanced splits and the $\mathfrak{su}$ Kähler family; **every sphere product above the threshold with $p\ne q$ (which is most of them), is settled by the ideal-wise system of §3d, not by the pinning sentence L8 states.**

> **What a consumer may cite, exactly.**
> **(a)** For a symmetric pair with $\mathfrak k$ presenting a **single** Casimir on $\mathfrak m$ ($\mathfrak k$ simple, or its ideals interchanged by a symmetry of the pair), with $2q>p$ and $\mathfrak h$ irreducible on $\mathbb R^n$: $\theta=\frac{c_{\mathfrak k}q^2+2q^2+p^2}{(2q-p)\sqrt{pq(p+q)}}$ for the pair's **equivariant** graded critical point, if one exists, (R1) must be **tested** against the pair's true Casimirs, never solved for them.
> **(b)** The two closed forms of §3b, at every rank.
> **(c)** $\delta^2=0$ for every sphere product, every split, every $n$.
> **(d)** For non-simple $\mathfrak k$: the **ideal-wise system**, not the single-Casimir formula.
> **Nobody may cite** "a graded critical point is pinned by its pair's dimensions", "one Casimir ratio", "three integers and one table lookup", or "reproduces the sphere pairs identically", the first three are false off the single-Casimir class and the fourth is false at every unbalanced split.

## 8. Discrepancy record, locate, exhibit, argue the opposite

### A. The canonical sentence is false at named pairs, **CONFIRMED**

**Locate.** [results.md](../results.md):369: *"An equivariant graded critical point, the Weyl operator of a compact symmetric pair $(\mathfrak{so}(n),\mathfrak k)$ with $p=\dim\mathfrak k$, $q=\dim\mathfrak m$, is pinned by its pair's dimensions, $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$."*

**Exhibit.** At $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ the two ideals have adjoint Casimirs $2$ and $6$, so no $c_{\mathfrak k}$ exists; forcing the formula to return the true $\theta=\sqrt{56/45}$ requires $c_{\mathfrak k}=\big(\tfrac{476\sqrt{78}}3-619\big)/225$, irrational (§3c). At $(\mathfrak{so}(12),\mathfrak{so}(5)\oplus\mathfrak{so}(7))$ the ideals have $6$ and $10$ (§3d). At $(\mathfrak{so}(4),\mathfrak u(2))$, $2q-p=0$ and the formula is $0/0$ (§5).

**Argue the opposite.** The most charitable reading is that $c_{\mathfrak k}$ silently means "the ideal-wise data", so the sentence is shorthand for the $r+2$ system. It does not survive: the sentence writes a **single scalar $c_{\mathfrak k}$** into a single closed form, and its own next clause reduces that scalar to *"a tabulated Casimir ratio"*, singular. Nor does it survive the record's own reading: [findings/graded-half.md](../findings/graded-half.md):429 states plainly that the formula *"holds exactly on balanced splits with $c_{\mathfrak k}=2(k-2)$, and fails at $S^3\times S^5$, $S^3\times S^7$, $S^4\times S^6$, $S^5\times S^7$, …"*. **Candidate stands.**

### B. "reproduces the Ricci-flat Kähler family and the sphere pairs identically", **CONFIRMED, half**

**Locate.** [results.md](../results.md):369, same sentence.

**Exhibit.** The Ricci-flat Kähler half is true and I re-derived it exactly (§3b). **The sphere-pairs half is false at every unbalanced split**, of which the record names eight. Balanced splits alone are $\lceil$one per even $n\rceil$; unbalanced splits above $\sqrt{3/2}$ number $108$ within $N\le40$ by the record's own count ([ATTEMPTS.md](../ATTEMPTS.md):1049).

**Argue the opposite.** Read "the sphere pairs" as "the balanced sphere pairs", and the sentence is true. But the same paragraph's finiteness claim is about **all** pairs, and [results.md](../results.md):124 states the conclusion over *"Every equivariant graded point above the rival maximizer"*, which is overwhelmingly the unbalanced ones. **Candidate stands, as a scope defect rather than an arithmetic one.**

### C. The canonical form restricts $\mathfrak h=\mathfrak{so}(n)$, excluding the families it claims to reproduce, **CONFIRMED**

**Locate.** [results.md](../results.md):369 writes the pair as $(\mathfrak{so}(n),\mathfrak k)$. [ATTEMPTS.md](../ATTEMPTS.md):1035 writes it as $(\mathfrak h,\mathfrak k)$ *"with $\mathfrak h$ acting irreducibly on $\mathbb R^n$"*, and [findings/graded-half.md](../findings/graded-half.md):425 writes only $p=\dim\mathfrak k$, $q=\dim\mathfrak m$.

**Exhibit.** Fox is $(\mathfrak{su}(2),\mathfrak u(1))$ with $\mathfrak h=\mathfrak{su}(2)\subset\mathfrak{so}(4)$, $p=1$, $q=2$, $p+q=3=\dim\mathfrak{su}(2)$, the formula returns $\sqrt{3/2}$ exactly (§3b). Under [results.md](../results.md):369's $\mathfrak h=\mathfrak{so}(n)$ reading the same object is $(\mathfrak{so}(4),\mathfrak u(2))$, where $p+q=6$, $2q-p=0$, and the formula is undefined. **The stated hypothesis and the worked example use different $\mathfrak h$.** The Ricci-flat Kähler family $(\mathfrak{su}(m),\mathfrak{so}(m))$ that the same sentence claims to reproduce has $\mathfrak h=\mathfrak{su}(m)\ne\mathfrak{so}(n)$ at every $m$.

**Argue the opposite.** One could read $\mathfrak{so}(n)$ as loose notation for "a subalgebra of $\mathfrak{so}(n)$". Against that: the sentence pairs $\mathfrak{so}(n)$ with an explicit $q=\dim\mathfrak m$, and $\mathfrak m$'s dimension is fixed by which $\mathfrak h$ is meant, the two readings give $q=2$ and $q=2$ at Fox but $p=1$ versus $p=4$, changing $2q-p$ from $3$ to $0$. The ambiguity is load-bearing, not cosmetic. **Candidate stands.**

### D. The equivariance restriction, **NO FINDING**

**Locate.** [findings/graded-half.md](../findings/graded-half.md):425 SCOPE REFUTED; [results.md](../results.md):369 *"pins the pair's equivariant point only … the non-equivariant case is witnessed instead by the $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ point at $1.088948$, which has trivial kernel"*.

**Assessment.** This correction **did** travel to the canonical form, in both files, and [results.md](../results.md):17 and :124 both say "equivariant". The mechanism cited ($\Delta=0\iff\mathrm{ad}(\mathfrak p)$-equivariant on a graded point, then Schur), is coherent, and I confirm Schur is exactly what licenses "scalar on each ideal", which is the ansatz. **This is the record's named trap avoided, on this one correction.** The kernel side-condition on the $\Delta$ equivalence ([findings/graded-half.md](../findings/graded-half.md):395) does not travel, but the witness quoted has trivial kernel, so the citation is sound as written.

### E. "the check that was run settles the balanced splits only", **CONFIRMED**

**Locate.** [findings/graded-half.md](../findings/graded-half.md):427: *"Since the compact symmetric pairs are classified, the graded case is then a finite check, **and the check that was run settles the balanced splits only**."* Reinforced at :431: *"the sweep behind 'settles it there' screened out every unbalanced split before evaluating it, 500 of 594 pairs rejected for non-single $\mathfrak k$. … none was in the sweep, $S^5\times S^7$ among them."*

**Exhibit.** [ATTEMPTS.md](../ATTEMPTS.md):1047 is a **second, separate** sweep (Step 6, the ideal-wise system) which states: *"of 342 unbalanced pairs with $N\le40$, 181 are consistent and 161 are not"*, and :1049: *"Of those 181, exactly 108 exceed $\sqrt{3/2}$, and they are the unbalanced sphere products."* $S^5\times S^7$ has $N=12\le40$ and is inside it. I reproduced that pair's solution **by hand and exactly** in §3d, including the extra consistency equation (E3), which the solve does not use and which closes to $17.5+17.5=35$; the result $\theta^2=264/175$ matches the record's exact rational and the independent closed form.

**Argue the opposite.** "The check" could mean only Step 5's two-eigenvalue sweep, in which case both sentences are accurate about **that** sweep. This reading rescues :431 (which names "the sweep") but not :427, which says *"the check that was run"* immediately after the finiteness claim and is the sentence a consumer reads as the scope of the whole settlement. **Candidate stands against :427; withdrawn against :431.**

### F. The label, **CONFIRMED**

**Locate.** [results.md](../results.md):124 *"Lemma L8 (landscape)"* and :22 *"(Lemmas 7, 8, 23, 69)"* against [results.md](../results.md):367 *"Conjecture L8"*.

**Exhibit.** [results.md](../results.md):92 makes the labels literal and the file's own preamble says *"a result appears here once Gate 2 has passed"*. A reader taking the landscape line at face value imports a Gate-2-passed lemma; a reader taking the canonical line imports a candidate. Both lines are in one file, 243 lines apart, and only the second carries the equivariance scope refutation's provenance.

**Argue the opposite.** "Lemma" in the landscape line could be a section-wide convention rather than a status claim. Against that: [results.md](../results.md):188 heads the same section *"Conjecture L14 (direct)"*, so the landscape section does distinguish. **Candidate stands.**

### G. "Sphere products exceed the rival maximizer's value exactly when $p,q\ge5$", **WITHDRAWN**

**Locate.** [findings/graded-half.md](../findings/graded-half.md):431.

**Exhibit.** $S^5\times S^5$ at $n=10$ has both factors $\ge5$ and $\theta^2=\frac{2\cdot9\cdot4\cdot4}{8\cdot25}=\frac{288}{200}=1.44<\tfrac32$. So $p,q\ge5$ is necessary and not sufficient.

**Argue the opposite.** The clause continues *"which needs $n\ge12$, … reduces the condition to $n^2-7n-54\ge0$"*, and the conjunction $\{p,q\ge5\text{ and }n\ge12\}$ **is** exactly right: at $p=5$ the L69 budget gives $\frac5{(n-6)(n-1)}\le\frac1{12}$, i.e. $n^2-7n-54\ge0$, i.e. $n\ge12$; at $p\ge6$ it is slacker. The words support the conjunction. **Withdrawn, compressed, not wrong.**

### H. The $(p,q)$ notation clash, **CONFIRMED, minor**

**Locate.** [findings/graded-half.md](../findings/graded-half.md):425 uses $p=\dim\mathfrak k=13$, $q=\dim\mathfrak m=15$ for $S^3\times S^5$; :431 uses $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$, which at the same object needs $p=3$, $q=5$.

**Exhibit.** Feeding $p=13$, $q=15$ into the :431 formula at $n=8$ gives $\frac{2\cdot7\cdot12\cdot14}{6\cdot195}=\frac{2352}{1170}=2.010$, i.e. $\theta=1.418>\sqrt2$, above the record's own hard ceiling. A consumer reading the two formulas from one paragraph gets a value that violates a different lemma.

**Argue the opposite.** Sphere dimensions are the standard meaning of $S^p\times S^q$ and context disambiguates. True for a careful reader; the two conventions are sixteen lines apart inside a single numbered result, and the record's own error log ([findings/graded-half.md](../findings/graded-half.md):444, "the sphere labels were off by one") shows this family of confusion has already cost the record once. **Candidate stands as a presentation defect.**

## 9. The named trap, each citable claim read alone, as a consumer would

The record's signature failure is a correction landing **beside** the statement it corrects. Reading each citable form in isolation:

| read alone | does it carry its own corrections? |
| --- | --- |
| [results.md](../results.md):369 | **No.** It carries the *equivariance* correction and none of the others. A consumer citing it applies the pinning formula to $S^5\times S^7$ and gets nothing, or to $(\mathfrak{so}(4),\mathfrak u(2))$ and divides by zero. The r503/r504 refutation lives **in a different file entirely**, at [findings/graded-half.md](../findings/graded-half.md):429. |
| [results.md](../results.md):124 | **No**, and it is worse: it says *"one Casimir ratio"* and *"Every equivariant graded point above the rival maximizer is a sphere product"*, the second being L69's theorem, credited here to L8, which [findings/graded-half.md](../findings/graded-half.md):369 records as the exact mis-attribution L69's first version made. |
| [results.md](../results.md):17 | **No.** "Settled (Lemmas 7, 8, 23, 69)". |
| [findings/graded-half.md](../findings/graded-half.md):421–437 | **Yes.** SCOPE REFUTED opens the block; the r503/r504 box sits four lines below the sentence it refutes. **This is the one form that is safe to cite**, and it is the only one that is. |

**So the trap is realised, three times over.** The two corrections have opposite fates: the equivariance restriction reached every form, and the balanced-splits refutation reached none outside its own file. The mechanism is visible, the equivariance restriction was written **into** the sentence, and the balanced-splits refutation was written into a blockquote **after** it.

## 10. What would falsify the statement, and what I did to look for it

**The object that would break it.** A compact symmetric pair $(\mathfrak h,\mathfrak k)$, $\mathfrak h\subseteq\mathfrak{so}(n)$ acting irreducibly, with $\mathfrak k$ **simple** (so H4 genuinely holds), $2q>p$, carrying an equivariant graded critical point whose $\theta$ **differs** from $\frac{c_{\mathfrak k}q^2+2q^2+p^2}{(2q-p)\sqrt{pq(p+q)}}$. That would break the identity itself rather than its scope.

**What I did to look for it.** The identity of §3a is exact algebra from two stated inputs, so such an object must break one input: either the two-eigenvalue ansatz (which Schur forces once $\mathfrak k$ is simple and $\mathfrak m$ is $\mathfrak k$-irreducible) or (R1)'s index count $A_{\mathfrak{mm}}=qC/p$. **I could not break either by hand**, and I verified (R1) independently of the code in closed form at two infinite families, $(\mathfrak{su}(m),\mathfrak{so}(m))$ giving $\frac{m^2-4}{m+2}=m-2$ for every $m$, and the balanced spheres giving $2(m-2)$, and confirmed the resulting $\theta$ against $\theta_0(12)=\sqrt{55}/6$ and $\theta(\text{Fox})=\sqrt{3/2}$ exactly.

**The object that would break the *scope*, and it exists on the record.** Any pair whose $\mathfrak k$ has ideals with **unequal** adjoint Casimirs. $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ ($2$ and $6$) and $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ ($6$ and $10$) are two, and both carry genuine critical points above and near the region of interest. **I found these by looking, not by search**: the record names them, and the hand computations of §3c and §3d settle both exactly.

**One further candidate I looked for and did not find.** A pair with $\mathfrak k$ simple where the record's screen and the formula disagree. The screened families with simple $\mathfrak k$ are $(\mathfrak{su}(m),\mathfrak{so}(m))$, $(\mathfrak{su}(2k),\mathfrak{sp}(k))$, $(\mathfrak{sp}(2j),\mathfrak{sp}(j)\oplus\mathfrak{sp}(j))$ (interchangeable ideals), $E_6/\mathfrak{sp}(4)$ and $E_7/\mathfrak{su}(8)$. The first is exact for all $m$ (§3b); the second and third are consistent rejections, the second in exact rational arithmetic for every $k$; the last two are single rows I cannot check without their Casimir data, which the record does not tabulate on file. *No finding, and that last gap is stated rather than closed.*

## 11. Verdict

> ## `BROKEN`

**What is broken.** The universally quantified sentence at [results.md](../results.md):369 and its landscape form at [results.md](../results.md):124. Both assert that an equivariant graded critical point's value follows from the pair's dimensions and **one** Casimir ratio. That is false at $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$, false at $(\mathfrak{so}(12),\mathfrak{so}(5)\oplus\mathfrak{so}(7))$, false at every Hermitian pair (all of which have a centre in $\mathfrak k$), and **undefined** at $(\mathfrak{so}(4),\mathfrak u(2))$ where $2q=p$ exactly, the pair carrying the rival maximizer. Three hypotheses the argument consumes (single Casimir, $2q>p$, $\mathfrak h$ irreducible on $\mathbb R^n$) appear in neither [results.md](../results.md) form, and the canonical form's own $\mathfrak h=\mathfrak{so}(n)$ excludes the families it claims to reproduce.

**What survives, and is genuinely proven.** The elimination identity (§3a); the balanced-sphere and $(\mathfrak{su}(m),\mathfrak{so}(m))$ closed forms at every rank (§3b); $\delta^2=0$ for every sphere product at every split and dimension; and the **ideal-wise system**, which I verified exactly by hand at $S^3\times S^5$ and $S^5\times S^7$, returning $\theta^2=56/45$ and $264/175$ from tabulated Lie data with no operator built. **The substance of L8 is true; the sentence stating it is not.**

**Attached verdicts.** C5 (the finite check) is `HYPOTHESIS-DEBT`, no classification source is in [references/](../references/), and the list is finite in families, not in pairs, while the target runs over all $n\ge12$. C6 ("settled across the classical families") is `GAP`, the unbalanced $(\mathfrak{sp}(m),\mathfrak{sp}(j)\oplus\mathfrak{sp}(m-j))$ class is named as owed and never closed, the unbalanced real Grassmannians are checked only to $N\le40$, and the non-simple exceptional pairs are screened rather than solved. C8 (the label) is `BROKEN` under [results.md](../results.md):92's own rule.

**The minimal repair, stated as what the sentence should assert.** *For a compact symmetric pair $(\mathfrak h,\mathfrak k)$ with $\mathfrak h\subseteq\mathfrak{so}(n)$ acting irreducibly on $\mathbb R^n$, $\mathfrak k$ presenting a single Casimir on $\mathfrak m$, and $2q>p$: the pair's equivariant graded critical point, where (R1) tested against the pair's true Casimirs is consistent, has $\theta=\frac{c_{\mathfrak k}q^2+2q^2+p^2}{(2q-p)\sqrt{pq(p+q)}}$. For $\mathfrak k$ with ideals of unequal Casimir, the value is fixed instead by the ideal-wise system, one $(C_i,c_i)$ per simple ideal.*
