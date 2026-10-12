# VERIFY v145, L8: the pinning formula, the "three integers and one table lookup", and the finite check

**Cold brief.** Verifier v145 on [ROUND_L08.md](ROUND_L08.md), checking the text quoted there from [findings/graded-half.md](../findings/graded-half.md):421– with its canonical form at [results.md](../results.md):367 and its landscape line at [results.md](../results.md):124. **No numerical work was done and no script was run**; every value below is an exact hand evaluation, with decimals given only as the decimal expansion of an exact expression stated alongside. Log: [agent_logs/verify-L08-v145.log](../agent_logs/verify-L08-v145.log).

## Verdicts

| # | claim, as a consumer would read it alone | verdict |
|---|---|---|
| **C1** | The pinning $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$ holds at *a compact symmetric pair* $(\mathfrak{so}(n),\mathfrak k)$, [results.md](../results.md):369 as written | **BROKEN** |
| **C2** | The elimination of $C$ between $\theta=(qC-p)/\sqrt{pq(p+q)}$ and $c_{\mathfrak k}=[C(2q-p)-2(p+q)]/q$ yields the boxed formula | **PROVEN** |
| **C3** | "The value follows from three integers and one table lookup, with no curvature operator built at any stage" | **BROKEN** as written; **PROVEN, hypotheses corrected** under four named hypotheses |
| **C4** | "It reproduces the Ricci-flat Kähler family and the sphere pairs identically" | **BROKEN** |
| **C5** | (R2), the structure-constant count $\sum_ic_ip_i+3q\sum_iC_i=c^{\mathrm{ad}}_{\mathfrak h}(p+q)$ | **PROVEN**, verified by hand at the headline pair |
| **C6** | "The compact symmetric pairs being classified, the equivariant graded case is a finite check" | **HYPOTHESIS-DEBT** |
| **C7** | "Every equivariant graded point above the rival maximizer is a sphere product", [results.md](../results.md):124 as written | **GAP** |
| **C8a** | The SCOPE REFUTED headline, read as a restriction on what the *derivation* establishes | **PROVEN** |
| **C8b** | The existence of the second, non-equivariant graded point on the same pair at $\theta=1.088948$ | **HYPOTHESIS-DEBT** |
| **C9** | The heading: **Lemma** L8 at [results.md](../results.md):124, **Conjecture** L8 at [results.md](../results.md):367 and in [INDEX-results.md](../findings/INDEX-results.md) | **BROKEN** |
| **C10** | Lean: no row for L8 anywhere but the *out* bucket | **HYPOTHESIS-DEBT** |

**Overall verdict: BROKEN.**

**One line.** The algebra of the pinning is correct and I rebuilt it, but the formula's symbol $c_{\mathfrak k}$ is defined only for simple $\mathfrak k$, so the statement at [results.md](../results.md):369 (quantified over *every* compact symmetric pair), is false at the record's own headline pair $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$, where the advertised route returns $1337/(16\sqrt{5460})=1.13086\ldots$ against the true $\sqrt{56/45}=1.11554\ldots$, is undefined at the rival maximizer $\mathbb{CP}^2$ ($2q-p=0$), and at $\mathbb{CP}^3$ manufactures $35/(9\sqrt{10})=1.22977\ldots$, **above the threshold $\sqrt{3/2}=1.22474\ldots$**, and [findings/graded-half.md](../findings/graded-half.md) carries the correction that says so while the two [results.md](../results.md) sites do not.

## 0. Conventions, fixed once

- $\mathfrak h\subseteq\mathfrak{so}(n)$ is the support of $W$, carrying a $\mathbb Z_2$-grading $\mathfrak h=\mathfrak k\oplus\mathfrak m$ with $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$, $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$.
- $p=\dim\mathfrak k$, $q=\dim\mathfrak m$, so $p+q=\dim\mathfrak h$. These are **Lie-algebra** dimensions. Where a sphere product $S^k\times S^l$ is named, $k+l=n$ are the **block** sizes, a different pair of integers; the record fixes the correspondence "split $\mathbb R^k\oplus\mathbb R^l$ corresponds to $S^k\times S^l$" ([graded-half.md](../findings/graded-half.md), Correction 1).
- $C$ = Casimir eigenvalue of $\mathfrak k$ on $\mathfrak m$; $c_{\mathfrak k}$ = adjoint Casimir of $\mathfrak k$ on itself; $c^{\mathrm{ad}}_{\mathfrak h}$ = adjoint Casimir of $\mathfrak h$ on itself. All three in the $\mathfrak{so}(n)$-induced normalisation, in which $c^{\mathrm{ad}}_{\mathfrak{so}(N)}=2(N-2)$, this last is **on file and Gate-2 confirmed** as [Lemma L153](../findings/bounds.md), the Killing row marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$.
- Named relations, with the labels the record uses in [ATTEMPTS.md](../ATTEMPTS.md):
  - **($\mathfrak m$-block)** $\theta=(qC-p)/\sqrt{pq(p+q)}$, from the $\mathfrak m$-block of $Q(W)=\theta W$ on the two-eigenvalue ansatz $W=(q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m})/\sqrt{pq(p+q)}$.
  - **(R1)** $c_{\mathfrak k}=[C(2q-p)-2(p+q)]/q$, from the $\mathfrak k$-block, using $A_{\mathfrak{mm}}=qC/p$.
  - **(R2)** $\sum_ic_ip_i+3q\sum_iC_i=c^{\mathrm{ad}}_{\mathfrak h}(p+q)$, the structure sum counted two ways.
  - **(D)** the dictionary $C=(p+q)[q\,c^{\mathrm{ad}}_{\mathfrak h}+2p]/[2pq-p^2+3q^2]$ and $c^{\mathrm{ad}}_{\mathfrak h}=\frac{2(p+q)}{n}\cdot\frac{C_2(\mathrm{adj})}{C_2(V)}$, this is the "three integers and one table lookup".
- $\theta_0(n)^2=2(n-1)(n-2)/n^2$ is the balanced sphere product's value; $\sqrt{3/2}=1.224744871\ldots$ is the threshold, attained by $W_{\mathbb{CP}^2}$.

## 1. The hypothesis inventory

**A pass without one is not a pass, so here is the full list.** Column three says whether the written statement at [results.md](../results.md):369 carries it.

| # | hypothesis | where it enters | carried at :369? |
|---|---|---|---|
| H1 | $\mathfrak h=\mathfrak k\oplus\mathfrak m$ is a $\mathbb Z_2$-grading, i.e. $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$ | the $\mathfrak m$-block equation is a gradedness test; its residual is $0.421$ at $\mathbb{HP}^3$ ([ATTEMPTS.md](../ATTEMPTS.md), Step 3) | **yes**, "compact symmetric pair" |
| H2 | $W$ is **scalar on $\mathfrak k$**, equivalently $\mathfrak k$ is simple, or its ideals are interchanged by a symmetry of the pair | the ansatz $W=(q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m})/\sqrt{\cdot}$ has exactly two eigenvalues; $c_{\mathfrak k}$ is otherwise not a number | **NO** |
| H3 | $W$ is $\mathrm{ad}(\mathfrak p)$-equivariant | Schur is what makes $W$ scalar on each summand; the record's SCOPE REFUTED headline | **yes**, "equivariant graded critical point" |
| H4 | $2q>p$ | $2q-p$ is the denominator; $38$ of $594$ pairs are rejected on this in the sweep | **NO** |
| H5 | $\mathfrak h$ acts **irreducibly** on $\mathbb R^n$ | this is what makes $\mathrm{Ric}(W)$ a multiple of the identity, so Ricci-flatness is free ([ATTEMPTS.md](../ATTEMPTS.md), "The structural reading this settles") | **NO** |
| H6 | the pair **carries** an equivariant graded critical point, (R1) is a *constraint*, not a definition of $C$ | the record's own methodological correction: solving instead of checking "manufactures a $\theta$ for pairs that are not critical points at all", output up to $51.3$ against the ceiling $\sqrt2$ | **partly**, ":369 says "An equivariant graded critical point … is pinned by", which is the conditional form; but the following clause "the value follows from three integers and one table lookup" is the *solve*, not the check |
| H7 | $\ker W=0$, if the result is to be composed with [Lemma L7](../findings/bounds.md)'s equality class | L7's equality class is "a symmetric pair **only when** $\ker W=0$"; [Observation L12](../results.md) composes L7 with L8 | **NO** |
| H8 | the classification of compact symmetric pairs | "the compact symmetric pairs being classified … is a finite check" | **yes**, as an appeal; **the source is not in [references/](../references/)** |
| H9 | the table $C_2(\mathrm{adj})/C_2(V)$ | the "one table lookup" | **yes**, as an appeal; **no table is in [references/](../references/)** |

**Which the written argument uses.** H1, H2, H3, H4, H5, H6, H8, H9 are all load-bearing in the derivation as it stands in [ATTEMPTS.md](../ATTEMPTS.md). H7 is used by no step of L8 itself and is owed only by consumers who route L8 through L7. **Four of the eight load-bearing hypotheses (H2, H4, H5, and the check-direction of H6) appear nowhere in the canonical statement**, and H2 is the one that makes the difference between a true statement and a false one.

## 2. C2, the elimination is correct, rebuilt cold

From (R1), $c_{\mathfrak k}q=C(2q-p)-2(p+q)$, so $C=\dfrac{q\,c_{\mathfrak k}+2(p+q)}{2q-p}$ whenever $2q\ne p$. Substituting into the $\mathfrak m$-block relation,

$$\theta\sqrt{pq(p+q)}=qC-p=\frac{q^2c_{\mathfrak k}+2q(p+q)}{2q-p}-p=\frac{q^2c_{\mathfrak k}+2pq+2q^2-2pq+p^2}{2q-p}=\frac{c_{\mathfrak k}q^2+2q^2+p^2}{2q-p},$$

which is the boxed formula exactly. **The algebra is right and I get it independently.** Note what the step needs: $2q\ne p$, and that $c_{\mathfrak k}$ be a single scalar.

**Two consistency checks of (R1) itself, by hand, on the two families the record says survive.**

*The Ricci-flat Kähler family $(\mathfrak{su}(m),\mathfrak{so}(m))$.* Here $p=\tfrac{m(m-1)}2$, $q=\tfrac{(m-1)(m+2)}2$, $C=m$, $c_{\mathfrak k}=m-2$. Then $2q-p=(m-1)\big[(m+2)-\tfrac m2\big]=\tfrac{(m-1)(m+4)}2$ and $p+q=\tfrac{(m-1)(2m+2)}2=(m-1)(m+1)$. So
$$\frac{C(2q-p)-2(p+q)}{q}=\frac{\tfrac{m(m-1)(m+4)}2-2(m-1)(m+1)}{\tfrac{(m-1)(m+2)}2}=\frac{m(m+4)-4(m+1)}{m+2}=\frac{m^2-4}{m+2}=m-2.\ \checkmark$$
And the value: $qC-p=\tfrac{m(m-1)(m+2)}2-\tfrac{m(m-1)}2=\tfrac{m(m-1)(m+1)}2$, while $pq(p+q)=\tfrac{m(m-1)^3(m+2)(m+1)}4$, so
$$\theta^2=\frac{m^2(m-1)^2(m+1)^2/4}{m(m-1)^3(m+2)(m+1)/4}=\frac{m(m+1)}{(m-1)(m+2)},$$
which is the record's fitted closed form, and **exactly $3/2$ at $m=2$**, Fox at the threshold. $\checkmark$

*The balanced sphere pair $(\mathfrak{so}(2m),\mathfrak{so}(m)\oplus\mathfrak{so}(m))$.* Here $p=m(m-1)$, $q=m^2$, $p+q=m(2m-1)$, $C=2(m-1)$, $2q-p=m(m+1)$. Then $[C(2q-p)-2(p+q)]/q=[2(m-1)m(m+1)-2m(2m-1)]/m^2=2m[m^2-1-2m+1]/m^2=2(m-2)$, matching $c_{\mathfrak k}=2(m-2)$. $\checkmark$ And from the boxed formula,
$$\theta=\frac{2(m-2)m^4+2m^4+m^2(m-1)^2}{m(m+1)\cdot m^2\sqrt{(m-1)(2m-1)}}=\frac{m^2(2m-1)(m-1)(m+1)}{m^3(m+1)\sqrt{(m-1)(2m-1)}}=\frac{\sqrt{(m-1)(2m-1)}}{m},$$
using $2m^3-m^2-2m+1=(2m-1)(m^2-1)$. With $n=2m$ this is $\theta_0(n)^2=\frac{(m-1)(2m-1)}{m^2}=\frac{2(n-1)(n-2)}{n^2}$. $\checkmark$ At $m=3$: $\sqrt{10}/3=1.054093\ldots$; at $m=4$: $\sqrt{21}/4=1.145644\ldots$. Both match the record.

**Verdict C2: PROVEN.** The identity is an algebraic consequence of ($\mathfrak m$-block) and (R1) and I rebuilt it, and both surviving families satisfy (R1) identically in $m$.

## 3. C5, (R2) checked by hand at the headline pair

(R2) reads $\sum_ic_ip_i+3q\sum_iC_i=c^{\mathrm{ad}}_{\mathfrak h}(p+q)$. At $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ the record supplies ideals of dimension $3$ and $10$ with $(C_i,c_i)=(2,2)$ and $(4,6)$, and $q=15$, $p+q=28$, $c^{\mathrm{ad}}_{\mathfrak{so}(8)}=2(8-2)=12$ by [Lemma L153](../findings/bounds.md).

$$\sum_ic_ip_i=2\cdot3+6\cdot10=66,\qquad 3q\sum_iC_i=45\cdot(2+4)=270,\qquad 66+270=336=12\cdot28.\ \checkmark$$

Exact. **Verdict C5: PROVEN**, at the one pair where the record states enough data to check it. *No finding on the derivation of (R2) itself: the "count the structure sum two ways" argument is stated in one sentence in [ATTEMPTS.md](../ATTEMPTS.md) Step 4 and is not written out anywhere on the record, the check above is a numerical corroboration of a sentence, not a reading of a proof.*

## 4. C1 and C4, the discrepancy at $S^3\times S^5$, in three steps

### 4.1 Located exactly

[results.md](../results.md):369, first clause, read alone as a consumer would:

> "An equivariant graded critical point, the Weyl operator of a compact symmetric pair $(\mathfrak{so}(n),\mathfrak k)$ with $p=\dim\mathfrak k$, $q=\dim\mathfrak m$, is pinned by its pair's dimensions, $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$"

and the same sentence in the brief as dispatched, [ROUND_L08.md](ROUND_L08.md):21, together with its two consequences there: "**So the value follows from three integers and one table lookup, with no curvature operator built at any stage.** It reproduces the Ricci-flat Kähler family and **the sphere pairs** identically."

The quantifier is over *a compact symmetric pair*. Nothing in the sentence, in the rest of the [results.md](../results.md):367 block, or in the brief restricts $\mathfrak k$ to be simple.

### 4.2 Exhibited concretely, at $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$

This is the record's own headline pair ($S^3\times S^5$, and under triality $\mathbb{HP}^2$), with $p=3+10=13$, $q=3\cdot5=15$, $p+q=28=\dim\mathfrak{so}(8)$, $n=8$, $2q-p=17$, $pq(p+q)=13\cdot15\cdot28=5460$.

**First: $c_{\mathfrak k}$ is not a number here.** $\mathfrak k=\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ is not simple, and its two ideals have *different* adjoint Casimirs in the induced normalisation, $c=2(j-2)$ gives $2$ for $\mathfrak{so}(3)$ and $6$ for $\mathfrak{so}(5)$. The symbol $c_{\mathfrak k}$ in the formula has no referent. **The statement is not merely false at this pair; it is not well-formed there.**

**Second: the true operator has three eigenvalues, so no two-eigenvalue ansatz represents it.** The record gives its spectrum as $(0.398410^{\times3},\,0.119523^{\times10},\,-0.159364^{\times15})$. These are exactly $\sqrt{10/63}$, $\sqrt{1/70}$, $-\sqrt{8/315}$, which I confirm by the two invariants the ansatz must satisfy:
$$3\cdot\tfrac{10}{63}+10\cdot\tfrac1{70}+15\cdot\tfrac8{315}=\tfrac{10}{21}+\tfrac3{21}+\tfrac8{21}=1\quad(\lVert W\rVert^2=1),$$
$$3\sqrt{\tfrac{10}{63}}+10\sqrt{\tfrac1{70}}=\tfrac{\sqrt{10}}{\sqrt7}+\tfrac{10}{\sqrt{70}}=\tfrac{2\sqrt{70}}7=15\sqrt{\tfrac8{315}}\quad(\operatorname{tr}W=0).$$
Both exact. The multiplicities $3$ and $10$ are $\dim\mathfrak{so}(3)$ and $\dim\mathfrak{so}(5)$: $W$ is scalar on each **ideal** and not on $\mathfrak k$.

**Third: the advertised route returns the wrong number.** Take the sentence at its word ("the value follows from three integers and one table lookup") and run (D) with $n=8$, $p=13$, $q=15$, $c^{\mathrm{ad}}_{\mathfrak{so}(8)}=12$:
$$2pq-p^2+3q^2=390-169+675=896,\qquad C=\frac{28\,(15\cdot12+26)}{896}=\frac{28\cdot206}{896}=\frac{5768}{896}=\frac{103}{16},$$
$$\theta=\frac{qC-p}{\sqrt{pq(p+q)}}=\frac{15\cdot\frac{103}{16}-13}{\sqrt{5460}}=\frac{1337}{16\sqrt{5460}}=1.130862\ldots$$
against the true value $\theta=\sqrt{56/45}=1.115547\ldots$ (from the sphere-product closed form $\theta^2=\frac{2(n-1)(k-1)(l-1)}{(n-2)kl}$ at $n=8$, $k=3$, $l=5$: $\frac{2\cdot7\cdot2\cdot4}{6\cdot15}=\frac{112}{90}=\frac{56}{45}$). **The discrepancy is $1.53\times10^{-2}$**, and this is the same $1.5\times10^{-2}$ the record itself records as the amount by which its first, uncorrected sweep "missed $\mathbb{HP}^2$" ([ATTEMPTS.md](../ATTEMPTS.md), "A methodological correction"). The error the record diagnosed inside its sweep is still live inside the sentence it publishes.

**Consistency check the other way.** No rational $c_{\mathfrak k}$ rescues the boxed formula here. Solving $225c_{\mathfrak k}+619=17\sqrt{5460}\cdot\sqrt{56/45}$ and using $5460\cdot56/45=20384/3$ with $20384=2^5\cdot7^2\cdot13$, so $\sqrt{20384}=28\sqrt{26}$:
$$c_{\mathfrak k}=\frac{\tfrac{476\sqrt{78}}3-619}{225}=3.4769\ldots,$$
**irrational**, and lying strictly between the two ideals' Casimirs $2$ and $6$. This is the record's own blockquote claim ("the pinning would need an irrational Casimir ratio") and I confirm it in exact arithmetic.

### 4.3 The most charitable reading, and why it also fails

The charitable reading is that "compact symmetric pair" tacitly means *a pair whose isotropy carries a single Casimir*, the screen the sweep actually applies. Three things defeat it as a defence of the written statement:

1. The screen is stated in [ATTEMPTS.md](../ATTEMPTS.md) Step 5 and **in no citable form**. Neither [results.md](../results.md):369 nor :124 nor the brief mentions it.
2. Under that reading the sentence "it reproduces … **the sphere pairs** identically" (C4) becomes false by construction, because $S^k\times S^l$ with $k\ne l$ has $\mathfrak k=\mathfrak{so}(k)\oplus\mathfrak{so}(l)$ with non-interchangeable ideals, that is *every unbalanced sphere product*, including $S^5\times S^7$, the very object [Lemma L69](../findings/graded-half.md) needs above the threshold. The reading rescues C1 at the cost of C4.
3. It leaves $S^3\times S^5$ (the pair the record names in the same paragraph, four times), outside the theorem while the paragraph presents it as the theorem's leading example.

**Verdict C1: BROKEN.** **Verdict C4: BROKEN**, "the sphere pairs" is true of the balanced ones and false of the unbalanced ones, and the record's own blockquote lists eight failures by name ($S^3\times S^5$, $S^3\times S^7$, $S^4\times S^6$, $S^5\times S^7$, $S^3\times S^9$, $S^4\times S^8$, $S^2\times S^6$, $\mathbb{CP}^m$ for $m\ge4$).

## 5. Quantifier order, scope, and the edge of every range

### 5.1 $2q-p=0$: the formula is undefined at the rival maximizer

The $\mathfrak u(n/2)$ grading of $\mathfrak{so}(n)$ ([graded-half.md](../findings/graded-half.md)'s own table) has, at $n=2m$, $p=\dim\mathfrak u(m)=m^2$ and $q=\dim\mathfrak{so}(2m)-m^2=m(2m-1)-m^2=m(m-1)$, so
$$2q-p=2m(m-1)-m^2=m(m-2).$$
**At $m=2$ this is $0$.** That pair is $(\mathfrak{so}(4),\mathfrak u(2))$, $\mathbb{CP}^2$, $W_{\mathbb{CP}^2}$, the rival maximizer, the object at $\theta^2=3/2$ that the entire programme is organised around. **The pinning formula divides by zero there.** The second such pair is $(\mathfrak{so}(6),\mathfrak{so}(5))$, i.e. $S^5$, with $p=10$, $q=5$, $2q-p=0$.

Nothing at [results.md](../results.md):369 or :124 says the formula has a pole, and $2q>p$ is hypothesis H4, carried nowhere in the canonical statement.

### 5.2 $\mathbb{CP}^3$: the advertised route manufactures a value **above the threshold**

Take the pair $(\mathfrak{so}(6),\mathfrak u(3))$: $n=6$, $p=9$, $q=6$, $p+q=15=\dim\mathfrak{so}(6)$, $2q-p=3$, $c^{\mathrm{ad}}_{\mathfrak{so}(6)}=2(6-2)=8$. Run (D):
$$2pq-p^2+3q^2=108-81+108=135,\qquad C=\frac{15\,(6\cdot8+18)}{135}=\frac{15\cdot66}{135}=\frac{22}3,$$
$$\theta=\frac{qC-p}{\sqrt{pq(p+q)}}=\frac{44-9}{\sqrt{810}}=\frac{35}{9\sqrt{10}}=1.229772\ldots$$
The true value is $\theta(\mathbb{CP}^3)=\sqrt{10}/3=1.054093\ldots$, from the $\mathbb{CP}^m$ closed form $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, which I confirm by hand at all four values the record quotes: $m=3$ gives $\tfrac{4\cdot5}{18}=\tfrac{10}9$, $\theta=1.054093$; $m=4$ gives $\tfrac{5\cdot7}{36}=\tfrac{35}{36}$, $\theta=0.986013$; $m=5$ gives $\tfrac{6\cdot9}{60}=0.9$, $\theta=0.948683$; $m=6$ gives $\tfrac{7\cdot11}{90}=\tfrac{77}{90}$, $\theta=0.924962$. All four match [graded-half.md](../findings/graded-half.md) exactly.

**$1.229772>\sqrt{3/2}=1.224745$.** Read as written, the citable sentence at [results.md](../results.md):369 hands a consumer a symmetric pair on this record's own grading table whose "value" **exceeds the threshold**, a manufactured counterexample to Conjecture A.

**The most charitable reading, and it holds only partly.** The sweep's screen catches this row: the corresponding $c_{\mathfrak k}=[C(2q-p)-2(p+q)]/q=[22-30]/6=-\tfrac43<0$ fails the sign gate, and $\mathfrak u(3)=\mathfrak{su}(3)\oplus\mathfrak u(1)$ fails H2. So **the implementation is safe and the sentence is not**, which is exactly the gap between what is proven and what is citable. I record it as a defect of the written claim, not of the sweep.

### 5.3 $2q<p$: an entire classical family screened out by a sign, not by a check

For $(\mathfrak{so}(n),\mathfrak{so}(n-1))$ (the sphere $S^{n-1}$), $p=\tfrac{(n-1)(n-2)}2$, $q=n-1$, so $2q-p=\tfrac{(n-1)(6-n)}2$, negative for every $n\ge7$. The record's sweep rejects $38$ of $594$ pairs on "$2q\le p$", **before** testing (R1). Since $c_{\mathfrak k}q^2+2q^2+p^2>0$ always, $2q<p$ only forces $\theta<0$, and [Lemma L10](../results.md) records that critical points come as $\pm W$ with multipliers $\pm\theta$, so a negative $\theta$ names the *other* member of the pair, not the absence of a point. **The record's ground for discarding these $38$ is a sign convention, and it does not carry an argument that they hold no critical point.**

*I looked for a falsifier there.* At $(\mathfrak{so}(8),\mathfrak{so}(7))$: $p=21$, $q=7$, $p+q=28$, and the record's true Casimirs for $\mathfrak{so}(j)\subset\mathfrak{so}(N)$ give $c_{\mathfrak k}=2(7-2)=10$, $C=7-1=6$. (R1) returns $[6\cdot(-7)-2\cdot28]/7=-14\ne10$: **inconsistent, so this pair carries no two-eigenvalue graded critical point** and is no counterexample. But the exclusion I just performed is the (R1) *check*, which the sweep never ran on these rows.

### 5.4 Odd $n$, the smallest admissible $n$, and $\ker W\ne0$

- **Odd $n$.** L8's variables are $p,q$, Lie dimensions, so no parity condition enters and none is stated. The smallest odd sphere-product pair, $S^3\times S^4$ at $n=7$, has $\mathfrak k=\mathfrak{so}(3)\oplus\mathfrak{so}(4)$ (non-simple with $\mathfrak{so}(4)$ itself non-simple) so H2 fails and only the ideal-wise system applies. **No finding of a defect at odd $n$; the finding is that odd $n$ is entirely outside the two-eigenvalue formula.**
- **Smallest $n$.** $n=4$: covered by §5.1, a pole at $\mathbb{CP}^2$.
- **$\ker W\ne0$ (hypothesis H7).** The ansatz $W=(q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m})/\sqrt{pq(p+q)}$ is supported on $\mathfrak h$, so whenever $\mathfrak h\subsetneq\mathfrak{so}(n)$, $\ker W\supseteq\mathfrak h^\perp\ne0$. **Fox is such a point**: $\mathfrak h=\mathfrak{su}(2)\subset\mathfrak{so}(4)$, $p+q=3$ against $\dim\Lambda^2\mathbb R^4=6$, so $\dim\ker W=3$. L8 is therefore *about* points with nonzero kernel. But [Lemma L7](../findings/bounds.md)'s equality class is a symmetric pair **only when $\ker W=0$**, and [Observation L12](../results.md) composes them: "Lemma L7 splits the critical points by whether its inequality is an equality; Lemma L8 settles the equality side." **That composition is invalid at exactly the points L8's own leading witness occupies.** [graded-half.md](../findings/graded-half.md)'s labelling table already records the underlying obstruction, "(C) and (A) are incomparable" and "$\Delta=0\Rightarrow$ L69 applies" is "UNSOUND off $\ker W=0$", but **that table sits in [findings/](../findings/) and the composition sits in [results.md](../results.md)**, which carries no kernel caveat on L8, L7 or L12.
- **Reducible / non-equivariant.** Explicitly excluded by the SCOPE REFUTED headline (H3), and the record locates the open half correctly at [plan.md](../plan.md) item C3.

## 6. The universal claim, family by family, named, and one object tried in each

"Settled across the classical families" names no families in the brief. The families are in [ATTEMPTS.md](../ATTEMPTS.md) Step 5: $\mathfrak h=\mathfrak{so}(N)$ on $\mathbb R^N$ with $\mathfrak k=\mathfrak{so}(j)\oplus\mathfrak{so}(N-j)$ or $\mathfrak u(N/2)$; $\mathfrak h=\mathfrak{su}(m)$ on $\mathbb C^m$ with $\mathfrak k=\mathfrak{so}(m)$, $\mathfrak{sp}(m/2)$ or $\mathfrak s(\mathfrak u(j)\oplus\mathfrak u(m-j))$; $\mathfrak h=\mathfrak{sp}(m)$ on $\mathbb H^m$ with $\mathfrak k=\mathfrak u(m)$ or $\mathfrak{sp}(j)\oplus\mathfrak{sp}(m-j)$, $594$ pairs, $N,m\le40$.

| family | object I tried, by hand | outcome |
|---|---|---|
| $(\mathfrak{so}(2m),\mathfrak{so}(m)\oplus\mathfrak{so}(m))$ | $S^3\times S^3$, $S^4\times S^4$ | **holds**, (R1) returns $2(m-2)$ identically; $\theta=\sqrt{(m-1)(2m-1)}/m$ (§2) |
| $(\mathfrak{so}(N),\mathfrak{so}(j)\oplus\mathfrak{so}(N-j))$, $j\ne N-j$ | $S^3\times S^5$ | **fails**, H2 fails, three eigenvalues, (D) off by $1.53\times10^{-2}$ (§4) |
| $(\mathfrak{so}(2m),\mathfrak u(m))$ | $\mathbb{CP}^2$, $\mathbb{CP}^3$ | **fails**, pole at $m=2$; at $m=3$, (D) returns $1.229772>\sqrt{3/2}$ against the true $1.054093$ (§5.1–5.2) |
| $(\mathfrak{su}(m),\mathfrak{so}(m))$ | the whole family in closed form | **holds**, $\theta^2=m(m+1)/[(m-1)(m+2)]$, $=3/2$ at Fox (§2) |
| $(\mathfrak{su}(2k),\mathfrak{sp}(k))$ | all $k\ge2$, in closed form | **carries no point**, I verify: $p=k(2k+1)$, $q=(2k+1)(k-1)$, $2q-p=(2k+1)(k-2)$, $p+q=(2k+1)(2k-1)$, so (R1) returns $\frac{2(2k+1)(k^2-4k+1)}{(2k+1)(k-1)}=\frac{2k^2-8k+2}{k-1}$, which equals $c_{\mathfrak k}=2(k+1)$ only at $k=\tfrac12$; at $k=6$ both give $26/5$ ([ATTEMPTS.md](../ATTEMPTS.md):1105) |
| $(\mathfrak{su}(m),\mathfrak s(\mathfrak u(j)\oplus\mathfrak u(m-j)))$ | complex Grassmannians | **outside the formula**, $\mathfrak k$ non-simple for every $j$, so H2 fails at every member |
| $(\mathfrak{sp}(2j),\mathfrak{sp}(j)\oplus\mathfrak{sp}(j))$ | $j=2,3,4$ | **carries no point**, I verify (R1) returns $-\tfrac{42}{16}=-2.625$, $-\tfrac{51}{36}=-1.41\overline6$, $-\tfrac{20}{64}=-0.3125$ against $c_{\mathfrak k}=2(j+1)=6,8,10$, using $p=2j(2j+1)$, $q=4j^2$, $p+q=2j(4j+1)$ |
| $(\mathfrak{sp}(m),\mathfrak u(m))$ |, | **no object tried on this record**; I find no row for it in Step 5's consistency closure or in Step 6 |
| **the exceptional algebras**, $\mathfrak g_2,\mathfrak f_4,\mathfrak e_6,\mathfrak e_7,\mathfrak e_8$ | **none, and none can be** | see below |

**The exceptional case cannot be tried on this record, and that is the finding.** The scope admits it: [graded-half.md](../findings/graded-half.md)'s own $\mathbb Z_2$-grading table enumerates gradings of $\mathfrak{so}(n)$, but L8's $\mathfrak h$ is any symmetric subalgebra of $\mathfrak{so}(n)$ acting irreducibly, and $\mathfrak g_2\subset\mathfrak{so}(7)$ irreducibly on $\mathbb R^7$ with the symmetric pair $(\mathfrak g_2,\mathfrak{su}(2)\oplus\mathfrak{su}(2))$, $p=6$, $q=8$, $p+q=14$, $2q-p=10>0$. To evaluate it I need $c^{\mathrm{ad}}_{\mathfrak g_2}=\frac{2(p+q)}{n}\cdot\frac{C_2(\mathrm{adj})}{C_2(V)}$, **and the ratio $C_2(\mathrm{adj})/C_2(V)$ for $\mathfrak g_2$ is a table lookup, with no table in [references/](../references/)**. I decline to supply it from memory. *So the "one table lookup" is, for the exceptional algebras, a lookup into a source this record does not hold; for $\mathfrak{so}(N)$ it is not a lookup at all, being [Lemma L153](../findings/bounds.md) with $c^{\mathrm{ad}}=2(N-2)$; and for $\mathfrak{su}(m)$ the value $2m^2/(m^2-1)$ is asserted in [ATTEMPTS.md](../ATTEMPTS.md) with no source and no derivation.*

**"Across the classical families" is therefore literally accurate and the brief's next sentence is not.** [ROUND_L08.md](ROUND_L08.md):22 says "*Since the compact symmetric pairs are classified, the graded case is then a finite check*". The classification includes the exceptional pairs. The check does not.

**Two positive findings worth recording.**

- **Every sphere product is defect-free, and this is a proof rather than a measurement.** $\Pi_{\mathfrak m}=\sum_av_av_a^{\mathsf T}$ for any orthonormal basis of $\mathfrak m$; under $S^2(\Lambda^2)\to\Lambda^4$, $\mathrm{Alt}(vv^{\mathsf T})\propto v\wedge v$, which vanishes iff $v$ is decomposable; for $(\mathfrak{so}(N),\mathfrak{so}(j)\oplus\mathfrak{so}(N-j))$, $\mathfrak m$ is spanned by the mixed coordinate $2$-planes $e_i\wedge e_j$, all decomposable. The argument is uniform in $N$ and $j$ and I find no gap in it. **This half of the claim is PROVEN for every dimension and every split**, balanced or not.
- **The $(\mathfrak{su}(2k),\mathfrak{sp}(k))$ row is settled analytically**, as verified above. *A staleness inside [ATTEMPTS.md](../ATTEMPTS.md): line 1041 says that row "still lacks a derived $C$ and is the one classical single-Casimir family not yet checked this way", and line 1105 checks it in exact rational arithmetic. The later line supersedes the earlier; the earlier was not withdrawn.*

## 7. C6, what "finite" rests on

**The classification used is Cartan's classification of compact symmetric pairs.** Neither Cartan nor Helgason, Berger or Besse is in [references/](../references/), I read the directory listing; the nearest entry is [schwahn-2020-symmetric-space-stability](../references/schwahn-2020-symmetric-space-stability/), which is a stability paper that *uses* the classification, and [wolf-1968-isotropy-irreducible](../references/wolf-1968-isotropy-irreducible/), which classifies isotropy-irreducible spaces, a different list. **So the finiteness clause of L8 rests on an unread source.** *(This confirms rather than assumes the round's standing note; the check was a directory read.)*

**Three things "finite" would have to mean, and only the first is discharged.**

1. **Finitely many families.** The classification gives finitely many *families*, each infinite in its rank parameter. Finiteness of the check therefore requires, per family, a closed form in that parameter. The record has one for the balanced spheres ($c_{\mathfrak k}=2(m-2)$, checked in closed form), for $(\mathfrak{su}(m),\mathfrak{so}(m))$, for $(\mathfrak{sp}(2j),\mathfrak{sp}(j)\oplus\mathfrak{sp}(j))$ and for $(\mathfrak{su}(2k),\mathfrak{sp}(k))$, I verified all four by hand above. It has none for $\mathfrak u(m)$, for the complex Grassmannians, or for any ideal-wise row.
2. **A truncation is not a check.** Both sweeps are capped at $N,m\le40$ ($594$ pairs in Step 5, $342$ in Step 6). **Where no closed form exists, $N\le40$ is a finite sample of an infinite family, and the record nowhere argues that $\theta$ is monotone or bounded past $40$ in those families.**
3. **The exceptional pairs are absent** (§6).

**If the classification were unavailable**, the check would have to exhaust: every $\mathbb Z_2$-graded subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$ acting irreducibly on $\mathbb R^n$, for every $n$, with the $n=8$ exception ($\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$, triality images) showing that "the obvious enumeration" is already short by two at one dimension. *[graded-half.md](../findings/graded-half.md) offers a route around the classification (the $\mathrm{ad}(\mathfrak p)$-commutant inside $\mathcal W_n$ being one-dimensional) but that is stated as holding "at every symmetric pair tested", at five pairs at $n=8,10$, which is a measurement and does not discharge the classification for L8.*

**Verdict C6: HYPOTHESIS-DEBT.** What would have to be shown: (i) a reading of a source that states Cartan's classification, placed in [references/](../references/); (ii) a closed form in the rank parameter for the $\mathfrak u(m)$ and complex-Grassmannian families and for the ideal-wise rows, replacing $N,m\le40$; (iii) the exceptional pairs.

## 8. Comparing the forms, and the named trap, twice

### 8.1 The four written forms

| site | heading | what it says the result is |
|---|---|---|
| [graded-half.md](../findings/graded-half.md):421 | **Conjecture L8** … "canonical statement and proof" | carries the SCOPE REFUTED headline *and* the Gate-2 blockquote at :429–431 refuting the pinning off the balanced splits |
| [results.md](../results.md):367 | **Conjecture L8** | carries the equivariance scope; **carries no simplicity restriction, no "balanced splits only", no $2q>p$, no kernel caveat** |
| [results.md](../results.md):124 | **Lemma L8 (landscape)** | "The graded case is a finite check, settled across the classical families. … **Every equivariant graded point above the rival maximizer is a sphere product, and every sphere product is defect-free.**", unscoped |
| [INDEX-results.md](../findings/INDEX-results.md):23 | **Conjecture**, "Gate 2: **REFUTED**, both reviewers" | the fullest and most accurate of the four |
| [lean/INDEX.md](../lean/INDEX.md):359 | (| L8 appears only in the *out), needs machinery Mathlib does not have* bucket, with L46, L47, L48, under "the classification of compact symmetric spaces" |

**Report of the differences, since the round asked for it.**

- **The label differs.** :124 says **Lemma**; :367, [graded-half.md](../findings/graded-half.md) and [INDEX-results.md](../findings/INDEX-results.md) say **Conjecture**. Under this record's own vocabulary those are different claims, one proven, one a candidate. [LEDGER.md](../findings/LEDGER.md):903 records a repair for exactly this ("L8's own heading still read `Lemma` in two files while the index read `Conjecture` … now closed"); **the landscape line at :124 was not among the sites repaired, and still reads `Lemma`.** Sibling landscape lines carry the canonical label ("Conjecture L6 (landscape)", "Lemma L7 (landscape)"), so this is a live inconsistency and not a convention of that section.
- **The scope differs.** :124 asserts flatly what the blockquote at [graded-half.md](../findings/graded-half.md):429 refutes and what [LEDGER.md](../findings/LEDGER.md):521 records as an open obligation.
- **The Lean row does not exist.** *What a row would have to claim, if one were written:* not the pinning, L8's content above is a statement about a classification Mathlib does not carry. The formalisable residue is the **algebra of §2**: given reals $p,q,C,c_{\mathfrak k},\theta$ with $2q\ne p$, $\theta\sqrt{pq(p+q)}=qC-p$ and $qc_{\mathfrak k}=C(2q-p)-2(p+q)$ imply $\theta(2q-p)\sqrt{pq(p+q)}=c_{\mathfrak k}q^2+2q^2+p^2$. That is a two-line `field_simp` and would be honest about what it does **not** cover, which is everything the word "pair" carries. The current row places L8 out of scope on the classification, which is right for the whole and hides that the arithmetic core is trivially in scope.

### 8.2 The named trap, instance one: the correction is in a different file

The record's signature failure is a correction landing beside the statement it corrects. Here it lands **one file away**. A consumer who cites [results.md](../results.md):369 (the canonical statement file, which is where a consumer is supposed to cite from), gets:

- the equivariance scope (H3), **which is there**; and
- a formula quantified over every compact symmetric pair, **which is false at $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$, undefined at $\mathbb{CP}^2$, and above-threshold at $\mathbb{CP}^3$**;

and nothing that would warn them. The blockquote that says so is at [graded-half.md](../findings/graded-half.md):429, reached only by following the `**Proof:**` pointer.

### 8.3 The named trap, instance two: the brief as dispatched dropped the refutation

[ROUND_L08.md](ROUND_L08.md):21–23 quotes [graded-half.md](../findings/graded-half.md) lines **425, 427, 433, 435, and omits 429–431**, which is the Gate-2 blockquote "THE PINNING IS REFUTED OFF THE BALANCED SPLITS, AND SO IS THE SENTENCE ABOUT SPHERE PRODUCTS". The omitted lines are mathematics, not provenance, and the brief's own preamble says "*Provenance stripped, mathematics verbatim*". **The dispatch reproduced the refuted paragraph and dropped its refutation.** I record this without editing the round file. *It does not change my verdicts (I reached §4 and §5 from the sources rather than from the brief) but it is the exact failure mode the round was told to hunt, committed by the round's own brief.*

### 8.4 One place the record may be under-claiming

[LEDGER.md](../findings/LEDGER.md):521 records the open obligation as "the sweep evaluated $94$ of $594$ pairs, and whether any of the $500$ rejected for non-single $\mathfrak k$ exceeds $\sqrt{3/2}$ is open", and [graded-half.md](../findings/graded-half.md):431 says "*none was in the sweep, $S^5\times S^7$ among them*". But [ATTEMPTS.md](../ATTEMPTS.md) **Step 6** solves the ideal-wise system outright for $(\mathfrak{so}(N),\mathfrak{so}(j)\oplus\mathfrak{so}(N-j))$, $342$ unbalanced pairs with $N\le40$, $181$ consistent, of which $108$ exceed $\sqrt{3/2}$ and are the unbalanced sphere products, all zero-defect by the decomposable-basis proof. Those $342$ rows are non-single-$\mathfrak k$ rows, so a large majority of the $500$ appear to have been resolved by a **different** sweep than the one the refutation names.

*Charitable reading, and it is probably the right one:* the blockquote is careful to say "**the sweep behind** *settles it there*", i.e. Step 5, and it is accurate about Step 5. What is not accurate is the ledger's blanket "the $500$ … is open". **I state this as a discrepancy between two sites on the record and go no further**, because settling which pairs are in which sweep's input set would require running them, and the analysis-only rule blocks that. What it would decide: whether the outstanding obligation is $500$ pairs or roughly $158$ ($\mathfrak u(m)$, complex and quaternionic Grassmannian rows).

## 9. C8, the scope refutation, read as two claims

**C8a, the restriction on the derivation: PROVEN, by reading the derivation.** The chain is: $\Delta=0$ on a graded point iff $W$ is $\mathrm{ad}(\mathfrak p)$-equivariant ([bounds.md](../findings/bounds.md)); Schur then makes $W$ scalar on each irreducible summand; the two-eigenvalue ansatz is that scalarity with $\mathfrak k$ irreducible. **Every step after "equivariant" uses equivariance**, so the derivation establishes nothing about a graded point that lacks it. The headline is a correct reading of the argument's reach, and I did not have to supply anything to see it.

**C8b, the existence of the witness: HYPOTHESIS-DEBT.** The second point at $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ with $\theta=1.088948$ is certified by "all three bracket inclusions to $10^{-29}$", "$\Delta=1.512231$", "five distinct positive eigenvalues", and a Killing-spectrum match to difference exactly $0$. **That is a numerical construction, and numerical agreement is not evidence.** *What would have to be shown:* an exhibited operator with the criticality relation verified in exact arithmetic, or an argument that the ad$(\mathfrak p)$-commutant of $\mathcal W_8$ restricted to graded points on this pair has dimension $>1$. **I note the record's own tension here**: [graded-half.md](../findings/graded-half.md) also states that "the $\mathrm{ad}(\mathfrak p)$-commutant inside $\mathcal W_n$ is exactly one-dimensional at every symmetric pair tested: $(3,5)$, $(4,4)$ and $(2,6)$ at $n=8$", $(3,5)$ *is* this pair. The two statements are compatible only because one quantifies over $\mathrm{ad}(\mathfrak p)$-**equivariant** operators and the other over graded ones, and neither says so at its own site.

*No finding on the triality subtlety at $n=8$.* The argument, two non-conjugate embeddings of one pair need an outer automorphism, $\mathrm{Aut}(\mathfrak{so}(N))=PO(N)$ except at $N=8$, so the phenomenon is confined to one dimension, is a correct use of a standard fact, and it is the right shape. **But $\mathrm{Aut}(\mathfrak{so}(N))=PO(N)$ for $N\ge5$, $N\ne8$ is itself a cited-not-read fact**: no source for it is in [references/](../references/).

## 10. The gap between what is proven and what is used, and what a consumer may cite

**Proven, and citable as such:**

1. The algebraic identity of §2 (the elimination of $C$) as a statement about five real numbers with $2q\ne p$.
2. $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$ for $(\mathfrak{su}(m),\mathfrak{so}(m))$, and **it never exceeds the threshold**: $\tfrac32(m-1)(m+2)-m(m+1)=m^2+m-6=(m+3)(m-2)\ge0$ for $m\ge2$, with equality exactly at $m=2$. So Fox attains $\sqrt{3/2}$ and no member of that family passes it.
3. $\theta_0(2m)=\sqrt{(m-1)(2m-1)}/m$ for the balanced sphere pairs, with (R1) satisfied identically in $m$.
4. $(\mathfrak{sp}(2j),\mathfrak{sp}(j)\oplus\mathfrak{sp}(j))$ and $(\mathfrak{su}(2k),\mathfrak{sp}(k))$ carry **no** isotropy-scalar graded critical point, both in exact arithmetic and both re-derived here by hand.
5. **Every sphere product has zero defect**, for every dimension and every split, by the decomposable-basis argument, a genuine proof, uniform in the parameters.

**Used but not proven:**

- The pinning **at any pair with non-simple, non-interchangeable isotropy**, which is every unbalanced sphere product, every $\mathfrak u(m)$ pair, and every complex Grassmannian.
- The **finiteness** of the check (§7): unsourced classification, $N,m\le40$ truncation, exceptional pairs absent.
- The **correspondence** *equivariant graded critical point $\leftrightarrow$ compact symmetric space*. [graded-half.md](../findings/graded-half.md) is explicit that "**[Lemma L8] assumes it rather than supplying it**, its variables *are* the pair, so its implication runs pair $\Rightarrow$ value and never point $\Rightarrow$ pair". **Neither [results.md](../results.md):124 nor :367 says this**, and :124's "Every equivariant graded point above the rival maximizer is a sphere product" is precisely a point $\Rightarrow$ pair statement.

**What a consumer may cite, stated as a single sentence:** *For a compact symmetric pair $(\mathfrak{so}(n),\mathfrak k)$ with $\mathfrak k$ simple or with its simple ideals interchanged by a symmetry of the pair, with $\mathfrak h$ acting irreducibly on $\mathbb R^n$ and $2q>p$, and which is known independently to carry an $\mathrm{ad}(\mathfrak p)$-equivariant graded critical point, the value of that point is $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$; and separately, every sphere product $S^k\times S^l$ has zero defect.* **Nothing wider than that is citable from this block**, and in particular the words "finite check" and "settled across the classical families" are not.

## 11. Name what would break it

**The object.** A compact symmetric pair $(\mathfrak h,\mathfrak k)$ with $\mathfrak h\subseteq\mathfrak{so}(n)$ acting irreducibly, $\mathfrak k$ carrying a single Casimir, $2q>p$, satisfying (R1) against its **true** Casimirs, with $\theta>\sqrt{3/2}$, and **not** a balanced sphere pair, or, for the defect half, a sphere product with $\delta^2\ne0$.

**What I did to look for it.**

- Checked (R1) by hand against true Casimirs in every family the record names: balanced spheres (consistent, $\theta<\sqrt2$, monotone), $(\mathfrak{su}(m),\mathfrak{so}(m))$ (consistent, $\theta^2\le3/2$ with equality only at Fox, by the exact inequality in §10), $(\mathfrak{sp}(2j),\mathfrak{sp}(j)\oplus\mathfrak{sp}(j))$ at $j=2,3,4$ (inconsistent, wrong sign), $(\mathfrak{su}(2k),\mathfrak{sp}(k))$ for all $k$ (inconsistent, in closed form), $(\mathfrak{so}(8),\mathfrak{so}(7))$ as a representative of the $2q<p$ rows the sweep discards on a sign (inconsistent, so no falsifier hides there).
- **Found no falsifier.** The regions I could not examine, and where one would have to live: the exceptional $\mathfrak h$, because the Casimir ratio is a table lookup and no table is on file; $(\mathfrak{sp}(m),\mathfrak u(m))$, for which I find no Casimirs anywhere on the record; and every pair with $N,m>40$ in a family with no closed form.
- **The defect half I could not break at all**, the decomposable-basis argument is uniform and I found no crack in it.

## 12. Verdict

**BROKEN.**

- The **arithmetic core is sound** and I rebuilt every piece of it independently (§2, §3, §6, §10).
- The **canonical statement at [results.md](../results.md):369 is false as written**, at three named objects on this record: $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ (§4), $(\mathfrak{so}(4),\mathfrak u(2))=\mathbb{CP}^2$ (§5.1, a pole), and $(\mathfrak{so}(6),\mathfrak u(3))=\mathbb{CP}^3$ (§5.2, where the advertised route returns a value **above the threshold**). Four of its eight load-bearing hypotheses are missing from it (§1).
- The **landscape line at [results.md](../results.md):124 is worse**: it heads a Gate-2-REFUTED `Conjecture` as a `Lemma` and asserts unscoped what [LEDGER.md](../findings/LEDGER.md):521 records as an open obligation.
- The **findings block at [graded-half.md](../findings/graded-half.md):421 is honest** (it carries both the scope refutation and the Gate-2 blockquote) and [INDEX-results.md](../findings/INDEX-results.md):23 is the most accurate site of the four. **The defect is one of propagation, not of discovery**, which is this record's named trap; and the round's own brief reproduced it by dropping lines 429–431 (§8.3).

**The minimum repair, stated so a fixer need not re-derive it.** Add H2 and H4 to [results.md](../results.md):369 as explicit hypotheses; replace [results.md](../results.md):124's assertion with the scoped form and its `Conjecture` label; and record against the block that "finite check" is owed a source, a closed form per family in place of $N,m\le40$, and the exceptional pairs.
