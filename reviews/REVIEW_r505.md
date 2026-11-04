# REVIEW r505, Lemma L2 ("exact dimension threshold")

**Target:** [findings/problem.md](../findings/problem.md), `#### Lemma L2 (exact dimension threshold), canonical statement and proof` (line 160) down to the next heading. Duplicated verbatim at [results.md](../results.md) line 300.
**Reviewer:** r505, cold, adversarial. Analysis-only footing observed: one screen, seconds of compute, on objects built for the purpose, reported below as a screen and never as evidence for a positive claim.

**VERDICT: CONFIRMED**, the number, the polynomial, the two closed forms and the integer threshold are all correct, and the derivation is not circular. Three defects in the block's *supporting prose* are named below and require correction; none of them moves the number.

---

## 0. What the block actually contains

The whole of `#### Lemma L2 … canonical statement and proof` is:

> Needed to pin down where the known critical points rank. $n=6+2\sqrt7\approx11.29$ is exactly where the balanced sphere-product overtakes the $\mathbb{CP}^2$-type competitor (Fox's $\mathcal S^4(\alpha)$), derived three independent ways. Reproduces the $n\geq12$ threshold exactly, not just approximately.

**There is no proof in the block.** The heading promises "canonical statement and proof" and the italic note says the argument was moved here "where the argument was the only copy", but no argument arrived. The only derivations live in [ATTEMPTS.md](../ATTEMPTS.md), which its own header declares append-only and superseded by [findings/INDEX.md](../findings/INDEX.md). **A `Lemma` whose sole proof lives in the untrusted lab notebook is a `Lemma` with no proof on the record.** Section 5 below supplies one.

---

## 1. The mathematics, rebuilt from the definitions

### 1.1 The sphere-product closed form, derived, not quoted

Take $S^p\times S^q$, $n=p+q$, Einstein (so $a(p-1)=b(q-1)=\rho$ for the two factors' sectional curvatures). On $\Lambda^2\mathbb R^n$ the curvature operator is $a$ on $\Lambda^2V_1$, $b$ on $\Lambda^2V_2$, $0$ on $V_1\wedge V_2$; Einstein kills the $\mathring{\mathrm{Ric}}$ term, so $W=R-\frac{\mathrm{scal}}{n(n-1)}\mathrm{Id}$. Normalising $\rho=n-1$:

$$\lambda_{\Lambda^2V_1}=\tfrac q{p-1},\qquad \lambda_{\Lambda^2V_2}=\tfrac p{q-1},\qquad \lambda_{\mathrm{mixed}}=-1,$$

traceless as required. In the normalisation of [conventions.md](../findings/conventions.md), $v_{ij}$ orthonormal with $[v_{ij},v_{jk}]=v_{ik}$, so $T_{\alpha\gamma\delta}=c_{\alpha\gamma\delta}^2$ is $1$ exactly on triangles, the marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ checks out, and

$$\langle W^\#,W\rangle=3\sum_{i<j<k}\lambda_{ij}\lambda_{ik}\lambda_{jk}.$$

Counting triangles by how they split across the two factors and adding $\mathop{\mathrm{tr}}(W^3)$:

$$\lVert W\rVert^2=\frac{pq(n-1)(n-2)}{2(p-1)(q-1)},\qquad P(W)=\frac{pq\,(n-1)^2(n-2)}{2(p-1)(q-1)},$$

the numerator collapsing through $p^3+q^3-(p^2+q^2)+(3n-2)(pq-n+1)=n^3-4n^2+5n-2=(n-1)^2(n-2)$. Hence

$$\boxed{\ \theta(S^p\times S^q)^2=\frac{P^2}{\lVert W\rVert^6}=\frac{2(n-1)(p-1)(q-1)}{(n-2)\,pq}\ }$$

**This is exactly the closed form the brief put to me. It agrees.** At $p=q=n/2$ it gives $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$, matching [conventions.md](../findings/conventions.md)'s $\theta_0$; at $p=(n-1)/2,q=(n+1)/2$ it gives $\frac{2(n-1)(n-3)}{(n+1)(n-2)}$, matching the corrected odd-$n$ $\Theta_n$ of [Lemma L57](../findings/problem.md), **an independent confirmation of the L57 repair, obtained here as a by-product**. At $(4,n-4)$ it gives $\frac{3(n-1)(n-5)}{2(n-2)(n-4)}$, matching the retracted-as-new formula in [problem.md](../findings/problem.md)'s Fox-point section.

### 1.2 The competitor's value, derived, and the normalisation trap checked

$W_{\mathbb{CP}^2}=\mathop{\mathrm{diag}}(0,0,0,-1,-1,2)/\sqrt6$, the last three entries on $\Lambda^+\subset\Lambda^2\mathbb R^4$. Then $\lVert W\rVert^2=1$ and $\mathop{\mathrm{tr}}(W^3)=6/6^{3/2}=1/\sqrt6$. For $\Lambda^+=\mathfrak{su}(2)_+$ with orthonormal $a_1,a_2,a_3$, a direct bracket computation gives $[a_1,a_2]=-(v_{14}+v_{23})=-\sqrt2\,a_3$, so $\gamma^2=2$ and $\langle W^\#,W\rangle=3\gamma^2w_1w_2w_3=12/6^{3/2}=2/\sqrt6$. Hence

$$P(W_{\mathbb{CP}^2})=\tfrac1{\sqrt6}+\tfrac2{\sqrt6}=\tfrac3{\sqrt6}=\sqrt{3/2}=1.2247\ldots$$

**On the right side of the trap.** The value is $\sqrt{3/2}=1.2247$, not the deflated $\sqrt3/2=0.8660$, and it is computed in *the same* structure-constant normalisation that produced $\theta_0(n)$ in §1.1, so the two sides of the crossing are commensurable by construction, which is the only thing the trap can break.

### 1.3 $n$-independence, and criticality at every $n$, proved, not assumed

$\lVert W\rVert$ and $\mathop{\mathrm{tr}}(W^3)$ are untouched by zero-padding. For $\langle W^\#,W\rangle$: $W$ is supported on $\Lambda^+$, and $\mathfrak{su}(2)_+$ is a **subalgebra** of $\mathfrak{so}(n)$, so $c_{\alpha\gamma\delta}=\langle[v_\gamma,v_\delta],v_\alpha\rangle$ vanishes unless $\alpha\in\Lambda^+$ whenever $\gamma,\delta\in\Lambda^+$. Hence $W^\#$ is supported on $\Lambda^+\times\Lambda^+$, is unchanged by the padding, and $\theta$ is **exactly** $n$-independent. The same argument gives $Q(W)=\theta W$ exactly: on $\Lambda^+$, $W^2=(\frac16,\frac16,\frac23)$ and $W^\#=(-\frac23,-\frac23,\frac13)$, so $Q=(-\frac12,-\frac12,1)=\sqrt{3/2}\cdot(-1,-1,2)/\sqrt6$; off $\Lambda^+$ both terms vanish. **Fox's $\mathcal S^4(\alpha)$ enters the crossing as a genuine critical point at every $n\ge4$, at a value that does not move with $n$**, which is what makes "overtakes at $n=11.29$" a one-sided computation rather than a race between two moving quantities.

### 1.4 The threshold, and both integers by hand

$$\frac{2(n-1)(n-2)}{n^2}\ \ge\ \frac32\iff 4(n-1)(n-2)\ge3n^2\iff n^2-12n+8\ge0\iff n\ge6+2\sqrt7,$$
with $6+2\sqrt7=11.29150\ldots$. By hand at the two integers that matter:

| $n$ | $n^2-12n+8$ | best realisable split | $\theta^2$ | vs $3/2$ |
| --- | --- | --- | --- | --- |
| $11$ | $121-132+8=-3$ | $S^5\times S^6$ | $\frac{2\cdot10\cdot4\cdot5}{9\cdot30}=\frac{400}{270}=1.48148$ | **fails, strictly** |
| $12$ | $144-144+8=+8$ | $S^6\times S^6$ | $\frac{2\cdot11\cdot10}{144}=\frac{220}{144}=1.52\overline{7}$ | **holds, strictly** |

Nothing rounds. $\theta_0(n)^2=2(1-\frac1n)(1-\frac2n)$ is strictly increasing, so the sign is settled once and for all at $n=12$.

**Strictness and attainment.** $6+2\sqrt7$ is irrational, so $n^2-12n+8\ne0$ at every integer and **the crossing is strict at every dimension, there is no equality case and $n=11.2915$ is attained by nothing.** What is exact is two things, and they should be distinguished in the block's wording: the *real root* $6+2\sqrt7$ of the polynomial obtained by formally continuing $\theta_0$ to real $n$, and the *integer threshold* $12$, which is exact because $\lceil 11.2915\rceil=12$ and the inequality is monotone.

**Both parities.** At odd $n$ the realisable maximum is $\Theta_n$, not $\theta_0(n)$; $\Theta_{11}^2=\frac{160}{108}=1.4815<\frac32$ and $\Theta_{13}^2=\frac{240}{154}=1.5584>\frac32$, so the least admissible odd $n$ is $13\ge12$. **The integer statement $n\ge12$ is right at both parities**, see defect D3 for the price of saying this the way [results.md](../results.md) line 88 says it.

### 1.5 Screen (seconds; a screen, not evidence)

Structure constants of $\mathfrak{so}(n)$ built directly from $E_{ab}-E_{ba}$, $P(W)=\mathop{\mathrm{tr}}(W^3)+\langle W^\#,W\rangle$ evaluated with no closed form used as input:

- $\theta(S^p\times S^q)^2$ reproduces §1.1's formula to $\le1.8\times10^{-15}$ at **every** split $2\le p\le n/2$ for $n=6,8,9,10,11,12$.
- $\theta(W_{\mathbb{CP}^2})=1.224744871392=\sqrt{3/2}$ at $n=4,6,8,10,12$, with $\lVert Q(W)-\theta W\rVert\le1.6\times10^{-16}$ at each.
- $n=11$: the largest of all five splits is $1.48148<1.5$. $n=12$: $p=5$ gives $1.50857$ and $p=6$ gives $1.52778$, both $>1.5$.

---

## 2. Is the brief's cross-check a fourth derivation? No, it is derivation 1 in different units.

**It is not independent.** [ATTEMPTS.md](../ATTEMPTS.md)'s Fox-algebra section (the block's derivation 1) records Fox's Corollary 7.5 norm as $|\mathcal B(\beta)|^{-2}=\frac{(n-1)(p-1)(q-1)}{2(n-2)pq}$ and his (10.4) norm as $f(4)=\frac38$. Compare with §1.1 and §1.2:

$$\tfrac{(n-1)(p-1)(q-1)}{2(n-2)pq}=\tfrac14\theta(S^p\times S^q)^2,\qquad \tfrac38=\tfrac14\cdot\tfrac32 .$$

Both sides carry the *same* factor $\tfrac14$, Fox's $\tfrac16$-scalar convention composed with an inner-product difference, as ATTEMPTS.md itself flags. So Fox's Step 3 ($\frac{(n-1)(n-2)}{2n^2}=\frac38$) and the brief's cross-check ($\frac{2(n-1)(n-2)}{n^2}=\frac32$) are **the same equation multiplied by 4**. The cross-check is a re-derivation of the *inputs*, not a fourth route to the threshold.

**A corollary worth recording: the threshold is convention-independent even though $\sqrt{3/2}$ is not.** Any renormalisation scales every $\theta$ by one constant, so the crossing point is invariant. That is why the record survives the $\sqrt{3/2}$-vs-$\sqrt3/2$ trap here even though it has been bitten by it elsewhere.

---

## 3. What each of the block's three derivations assumes, and which are independent

| # | route | derives $\theta_0(n)$? | derives $\theta(\mathcal S^4)=\sqrt{3/2}$? | forms $n^2-12n+8=0$? |
| --- | --- | --- | --- | --- |
| 1 | Fox's nonassociative-algebra idempotents ([ATTEMPTS.md](../ATTEMPTS.md), "Nonassociative algebra") | yes, from Fox's Cor. 7.5 norm formula | yes, from Fox's (10.4) $\lvert\mathcal S^r(\alpha)\rvert^2=\frac{6r(r-2)}{(r+2)(r-1)}$, plus $f'(r)<0$ singling out $r=4$ | **yes** |
| 2 | the coordinate-level Tachibana-trick computation ([ATTEMPTS.md](../ATTEMPTS.md), "Tachibana-trick estimate extension") | yes, from Kulkarni–Nomizu in coordinates, exact fraction arithmetic | **no** | **no** |
| 3 | the from-scratch explicit-tensor construction ([ATTEMPTS.md](../ATTEMPTS.md), "4. The actual persistent competitor…") | yes, by hand from Kulkarni–Nomizu, then cross-checked *against* route 2 | yes, from an explicit Ricci-flat $s:t=1:-1$ combination on a $4$-plane | **yes** |

**Route 2 never touches the competitor.** Its entry's own confidence paragraph says the diagnosis "rests on the sphere-product example only, it is not yet shown that $\mathop{\mathrm{tr}}(W^3)$ stays negligible for *all* competitors (e.g. **was not checked for the $\mathbb{CP}^2$-type tensor**)". It produces $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$ and stops. **So the block's "all derive the identical equation $n^2-12n+8=0$" is false for one of the three.**

**And routes 1 and 3 share their weak input.** Route 3's sphere-product value is explicitly "cross-validated in Step 1", i.e. against route 2; and route 3's own entry concedes that its absolute $P$ is $2\times$ Fox's, so it does not independently pin $\sqrt{3/2}$ in the record's normalisation, only the ratio. **What the record actually holds is: three independent computations of $\theta_0(n)$, and two of $\theta(\mathcal S^4)$.**

**The independence claim is weaker still across the record.** [graded-half.md](../findings/graded-half.md) line 104 calls the L47/L48 meeting the "third independent appearance", line 130 calls the dimension count the "fourth", and [problem.md](../findings/problem.md) line 66 calls L44 "the same polynomial a fifth time". **None of these is independent of the others.** Each reduces to $\theta_0(n)$ against $\sqrt{3/2}$:

- L48's $\tfrac16\ge\frac{n^2}{8(n-1)(n-2)}$ is $\theta_0(n)^2\ge\frac32$ verbatim, since $\frac{n^2}{8(n-1)(n-2)}=\frac1{4\theta_0(n)^2}$ and $\tfrac16=\tfrac14\cdot\tfrac32$;
- L47's $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}$ is *derived from* $\lVert W\rVert^2\ge\frac16$, i.e. from $\theta\le\sqrt{3/2}$ with equality at $\mathbb{CP}^2$, so the "fourth appearance" $\frac{n(n-2)}4>\frac{3n^2(n-1)}{2(7n-4)}\iff n^2-12n+8>0$ (verified here: it reduces to $2n^2-24n+16>0$) carries the same input in disguise;
- L44's criterion fails "exactly when $\theta_0(n)<\sqrt{3/2}$", the same two numbers, read on the cone boundary.

**One value is a single point of failure for the whole family: $\theta(\mathcal S^4(\alpha))=\sqrt{3/2}$.** If that were wrong, all five "appearances" fall together. It is *not* wrong, §1.2 and §1.3 establish it from the definitions, but the record should stop describing these as independent confirmations of the threshold. They are independent confirmations of the two *inputs*, chained through one arithmetic step.

---

## 4. Defects found

### D1, "derived three independent ways" is an overcount (block sentence 2; item 1 above it)

**Correct to two.** The Tachibana-trick route derives $\theta_0(n)$ only; its own entry disclaims having checked the $\mathbb{CP}^2$-type tensor. The honest sentence is *"three independent derivations of the sphere-product value and two of the competitor's, meeting in one arithmetic step"*. This is a defect in the block's evidence claim, not in its number.

### D2, the block labelled "canonical statement and proof" contains no proof, and no Gate 2 record exists

`Lemma` asserts Gate 1 and Gate 2 passed ([INDEX-results.md](../findings/INDEX-results.md) header). The block carries no proof, no `Gate 2 passed` line (contrast [Lemma L48](../findings/problem.md), which says "Gate 2 passed by four reviewers"), and row 2 of [INDEX-results.md](../findings/INDEX-results.md) is a bare `Lemma` with no annotation. No review in [reviews/INDEX.md](INDEX.md) names Lemma L2, the `L2` hits there are per-review claim labels. [plan-verification.md](../plan-verification.md) lists `L02` in tier 0 **unticked**. **The label is not presently supported by anything on the record.** §1 above supplies the missing proof and should be transcribed into the block; the label is then earned.

### D3, "Lemma L2's crossover … [is] parity-free" is wrong about the root ([results.md](../results.md) line 88)

At odd $n$ the realisable crossing is $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}=\frac32$, i.e. $4(n-1)(n-3)=3(n+1)(n-2)$, i.e. $n^2-13n+18=0$, whose larger root is $\frac{13+\sqrt{97}}2=11.4244\ldots$, **a different number from $6+2\sqrt7=11.2915$.** The *integer* conclusion is parity-free ($12$ at even, $13$ at odd, both $\ge12$); the *root* is not. This is the same line that already carries the L57 $\Theta_n$ correction, so the fix is local: say "the integer threshold is parity-free" and give the odd root beside the even one.

### D4, item 4 of the numbered list contradicts the Fox-point section, and item 4 is the wrong one

Item 1's list, entry 4, says the literal zero-padded $\mathbb{CP}^2$ "is not itself the competitor, it is only an idempotent at $n=4,5$". §1.3 above **proves** it is exactly critical at every $n\ge4$ (the $\mathfrak{su}(2)_+$ subalgebra argument), and the screen returns $\lVert Q(W)-\theta W\rVert\le1.6\times10^{-16}$ at $n=4,6,8,10,12$; the [Fox point, correctly constructed](../findings/problem.md) section says the same and is right. **Item 4's parenthetical is false and should be struck.** It does not move the threshold: item 4's replacement object carries the identical $\sqrt{3/2}$.

### D5, name collision on the label `Lemma L2`

[isotropy-cap.md](../findings/isotropy-cap.md) lines 58, 118 and 127 use `Lemma L2` for an internal step of the isotropy-cap argument ("every $d$-dimensional subspace has $\mu\ge4d^2/n-2d$"), and line 127 writes "the Lemma-2 bound". [INDEX-results.md](../findings/INDEX-results.md) owns the numbering and assigns `2` to the dimension threshold. Rename the internal steps.

---

## 5. Scope, does anything read L2 as the conjecture's threshold?

**Checked, and no.** L2 establishes a crossing between two *known* points; the conjecture's $n\ge12$ is a statement about *all* of $\mathcal W_n$. These are different, and the record keeps them apart everywhere I looked:

- [results.md](../results.md) line 13 scopes it as "$n\ge12$ **necessary**", crediting Lemmas 2, 43, 44 jointly;
- [results.md](../results.md) line 37 states it as a crossing plus L44's non-invariance witness;
- [ATTEMPTS.md](../ATTEMPTS.md) is explicit that "the $n\ge12$ threshold is purely about **which of two competing local maxima** has the larger $P$-value … not a local stability question", and that "global maximality among *all* critical points remains open";
- [isotropy-cap.md](../findings/isotropy-cap.md) line 184's "which is why the conjecture holds only from $n=12$" is a necessity statement and reads correctly.

The one wording to tighten is [results.md](../results.md) line 112's "the $\mathbb{CP}^2$-type competitor genuinely wins below the crossover": in context it means *wins the two-way comparison*, but read alone it asserts global maximality for $4\le n\le11$, which the record elsewhere calls only "presumed" ([problem.md](../findings/problem.md), item 11). Add "of the two".

**No circularity.** Both inputs are $n$-uniform closed forms derived without reference to any threshold; the threshold is their consequence. The direction of implication is right.

---

## 6. Verdict

**CONFIRMED.** $n=6+2\sqrt7$ is exactly the crossing of $\theta_0(n)$ with $\theta(\mathcal S^4(\alpha))=\sqrt{3/2}$; the polynomial is $n^2-12n+8$; the competitor's value is $n$-independent and is on the un-deflated side of the normalisation trap; the crossing is strict at every integer, fails at $n=11$ by $-3$ and holds at $n=12$ by $+8$, at both parities. The brief's closed form is correct and agrees with mine, and is not a fourth independent derivation but Fox's own Step 3 rescaled by $4$.

Required corrections, none of which moves the number: **D1** (three→two independent derivations of the equation), **D2** (transcribe a proof into the block, or the `Lemma` label is unearned), **D3** (the odd-$n$ root is $\frac{13+\sqrt{97}}2$, not $6+2\sqrt7$), **D4** (strike item 4's "only an idempotent at $n=4,5$"), **D5** (the `Lemma L2` name collision in [isotropy-cap.md](../findings/isotropy-cap.md)).
