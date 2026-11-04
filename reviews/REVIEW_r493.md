# REVIEW r493, Lemma L73, "a purely spectral necessary condition on all of $\mathcal W_n$"

**Target.** [findings/bounds.md](../findings/bounds.md) lines 313–326: the `#### Lemma L73` heading, the LEMMA box, and the four appended blockquotes (r335 ×2, the row-calculus split, r336), down to `#### Lemma L107` at line 327. The display at line 325, $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$, is inside the block.

**Reviewer.** r493, cold, adversarial. Analysis-only footing: no searches, sweeps or censuses; seconds-long screens of claims about to be recorded, labelled as screens.

## Phase plan

- P1, consistency of the headline box against the accumulated corrections (criticality boundary).
- P2, derive (A), (B), (C) from the definitions; state the hypotheses each needs.
- P3, derive the core inequality from (B) + $T\ge0$; check the constant $n-2$.
- P4, the "not implied by tracelessness / gives only $N-1$" comparison.
- P5, the row-range sharpening and the claim that it coincides with the crude bound at the saturating families.
- P6, the replacement sharpness witness $S^2\times S^{n-2}$, verified by hand at one $n$.
- P7, r337's two-dimensional condition vs L73 stated one-dimensionally.
- P8, cross-check against the rest of `findings/`.

VERDICT: CONFIRMED

**Scope of the verdict.** The verdict is on **Lemma L73 as stated in its box**, every clause of it is true and I derived every one of them cold: the inequality, its holding at every $W\in\mathcal W_n$ critical or not, the constant $n-2$, the $N-1$ comparison, and the sharpness at $S^2\times S^{n-2}$ for every $n$. **The block around it carries one separately FALSE sentence** (line 321's "Lemma L73 is therefore the whole of what the row calculus says on $\mathcal W_n$") which the record refutes twice further down the same file and has never struck (D1 below). That sentence is not part of the lemma, so it does not make L73 refuted; it does make the block wrong as it stands, and it is the one thing here that must change.

## Findings

### F1 (P2), (A), (B), (C) derived cold; hypotheses as the block states them, with one omission

Fix an orthonormal eigenbasis $\{v_a\}$ of $W$ on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $Wv_a=\lambda_av_a$, $c_{abc}=\langle[v_a,v_b],v_c\rangle$ totally antisymmetric, $T_{abc}=c_{abc}^2$ totally symmetric, $\ge0$, vanishing when two indices agree ([conventions.md](../findings/conventions.md)).

- **(A) $\sum_{b,c}T_{abc}=2(n-2)$.** $\sum_c T_{abc}=\lVert[v_a,v_b]\rVert^2$, and $\sum_b\lVert[v_a,v_b]\rVert^2=-B(v_a,v_a)$ with $B(X,X)=(n-2)\mathop{\mathrm{tr}}(X^2)=-2(n-2)\lVert X\rVert^2$. **Hypotheses: none beyond $\{v_a\}$ orthonormal in $\mathfrak{so}(n)$.** It is not even a statement about $W$. Confirmed.
- **(B) $\sum_{b,c}T_{abc}\lambda_b=-2\lambda_a$**, i.e. $\mathbb E_{\mu_a}[\tfrac{\lambda_b+\lambda_c}2]=-\lambda_a/(n-2)$ with $\mu_a=T_{a\bullet\bullet}/2(n-2)$. Writing $(W\#I)_{\alpha\beta}=\sum_{\gamma\delta}W_{\gamma\delta}\langle[v_\alpha,v_\gamma],[v_\beta,v_\delta]\rangle$, the diagonal in the eigenbasis is $\sum_{bc}T_{abc}\lambda_b$. **Confirmed a Weyl identity on all of $\mathcal W_n$, by an argument that needs no computer:**
  1. $R\mapsto R\#I$ is $O(n)$-equivariant on $S^2(\Lambda^2)=\text{(scalar)}\oplus\text{Ric}_0\oplus\mathcal W\oplus\Lambda^4$; $\mathcal W$ and $\Lambda^4$ are inequivalent, so Schur gives $W\#I=c_W(n)W$ on $\mathcal W_n$.
  2. **Padding fixes $c_W$ across dimensions**: for $W\in\mathcal W_4$ extended by zero to $\Lambda^2\mathbb R^{n}$ (still Ricci-flat, still Bianchi), every bracket in the sum stays inside $\mathfrak{so}(4)$, so the $\Lambda^2\mathbb R^4$ block of $W\#I$ is unchanged. Hence $c_W(n)=c_W(4)$.
  3. **$c_W(4)=-2$ by hand.** $\mathfrak{so}(4)=\mathfrak{su}(2)^+\oplus\mathfrak{su}(2)^-$, $[e^+_i,e^+_j]=\kappa\epsilon_{ijk}e^+_k$ with $\kappa^2=2$ forced by (A) ($2\kappa^2=2(n-2)=4$). Take $W$ self-dual, $\lambda_1+\lambda_2+\lambda_3=0$ on $\Lambda^+$, zero on $\Lambda^-$. Then $\sum_{bc}T_{1bc}\lambda_b=2\lambda_2+2\lambda_3=-2\lambda_1$.
  So **(B) holds at every $W\in\mathcal W_n$, critical or not**, the record's claim stands, and the normalisation $-2\lambda_a$ is exactly the record's ($W\#I=-W$ in the record's $\#$, which carries the $\tfrac12$).
- **(C) $\sum_{bc}T_{abc}\lambda_b\lambda_c=2\lambda_a(\theta-\lambda_a)$.** The left side is the eigenbasis diagonal of $W\#W$; the right is the diagonal of $2(\theta W-W^2)$, which is $2W^\#$ **only when $Q(W)=W^2+W^\#=\theta W$**. **Hypothesis: criticality.** Confirmed; the block is right that (C) is the diagonal of $W^\#=\theta W-W^2$ and critical-only.

**Minor defect (M1).** The r336 blockquote says "*The derivation uses only (B) and $T\ge0$*". It also uses **(A)**: without the total mass $2(n-2)$, (B) plus $T\ge0$ gives $\lambda_{\min}m_a\le-2\lambda_a\le\lambda_{\max}m_a$ with $m_a=\sum_{bc}T_{abc}$ unknown, and the constant $n-2$ does not appear. (A) is likewise unconditional, so the verdict is unaffected; the sentence is simply short by one ingredient.

### F2 (P3), the core inequality and the constant $n-2$: CONFIRMED

$\mu_a$ is a probability measure by (A); $X_{bc}=\tfrac{\lambda_b+\lambda_c}2\in[\lambda_{\min},\lambda_{\max}]$ pointwise; (B) puts $\mathbb E_{\mu_a}[X]=-\lambda_a/(n-2)$. An expectation lies in the closed convex hull of the values, so $\lambda_{\min}\le-\lambda_a/(n-2)\le\lambda_{\max}$, i.e. $-(n-2)\lambda_{\max}\le\lambda_a\le(n-2)\lvert\lambda_{\min}\rvert$ (using $\lambda_{\min}<0<\lambda_{\max}$, forced by $\mathop{\mathrm{tr}}W=0$, $W\ne0$). The constant is $n-2$ exactly (it is (A)'s $2(n-2)$ divided by (B)'s $2$), **not $n-1$ and not $(n-2)/2$**. The "equivalently" is right: $a=\arg\max$ and $a=\arg\min$ give the two scalar forms, and those two imply the per-$a$ form since $\lambda_{\min}\le\lambda_a\le\lambda_{\max}$.

### F3 (P4), "not implied by tracelessness", $N-1$: CONFIRMED

With $\sum_{a=1}^N\lambda_a=0$: $\lambda_{\max}=-\sum_{a\ne\arg\max}\lambda_a\le(N-1)\lvert\lambda_{\min}\rvert$, attained at $(N-1,-1,\dots,-1)$, so $N-1$ is exactly the tracelessness constant and the comparison is fair. $\binom n2-1>n-2$ for every $n\ge3$, and the extremal traceless vector violates L73, so the implication genuinely fails. Confirmed.
### F4 (P1), the criticality boundary: the headline and the corrections DO reconcile, but the block draws the line in the wrong place at line 325

The two corrections are compatible, and both are right:

| statement | ingredients | where it holds |
| --- | --- | --- |
| $-(n-2)\lambda_{\max}\le\lambda_a\le(n-2)\lvert\lambda_{\min}\rvert$ (the LEMMA box) | (A), (B), $T\ge0$ | **all of $\mathcal W_n$** |
| $\lambda_{\max}\le-\tfrac{n-2}2(\lambda_{(1)}+\lambda_{(2)})$ (line 317) | (A), (B), $T\ge0$, $T$ hollow | **all of $\mathcal W_n$** |
| the per-row $\theta$-bounds, and $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$ (**line 325**) | (A), (B), **(C)**, $T\ge0$ | **critical points only** |

r336's "needs no criticality" is about the first two rows; r335/r338's "(C) holds only at critical points" is about the third. No contradiction. But:

**Defect D2 (moderate, placement).** The display at **line 325**, $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$, is the *last line of the blockquote headed "**AND IT NEEDS NO CRITICALITY**"*, introduced by "From the second at $a=\arg\min$", and "the second" is (C), the relation the block itself declares critical-only at line 321. The derivation is correct ((C) at $a=\arg\min$, $\lambda_b\lambda_c\ge\lambda_{\min}\lambda_{\max}$ on the box, divide by $\lambda_{\min}<0$), but it carries **no criticality qualifier**, and it sits inside a lemma whose box begins "At **every** $W\in\mathcal W_n$, critical or not". A reader who takes the block at its word reads a $\theta$-inequality as holding off the critical set, where $\theta=P(W)/\lVert W\rVert^3$ is defined but is not delivered by any relation in the block. **The boundary falls between line 323's prose and line 325's display, and the block does not mark it.** Repair: append "at every critical point" to line 325, or move the display into [Lemma L70](../findings/bounds.md)'s block, which is where the same inequality already lives.

### F5 (P5), the row-range sharpening: derivation CONFIRMED, and the "coincides at the saturating families" evidence is drawn at points where the bound is *not* attained

$T_{abc}>0$ forces $a,b,c$ pairwise distinct, so $\mathop{\mathrm{supp}}\mu_a\subseteq\{(b,c):b\ne c,\ b,c\ne a\}$ and $\min_{\mathop{\mathrm{supp}}}X=\tfrac12(\lambda_{(1)}+\lambda_{(2)})$ over the two smallest eigenvalues indexed away from $a$. At $a=\arg\max$ this gives $\lambda_{\max}\le-\tfrac{n-2}2(\lambda_{(1)}+\lambda_{(2)})$, **correct**, unconditional, and strictly stronger exactly when $\lambda_{(2)}>\lambda_{\min}$, i.e. when $\lambda_{\min}$ is simple. Both halves of the block's claim check out.

**The block's own numbers check out too.** For $S^{n/2}\times S^{n/2}$ Einstein, $\lambda_{\max}=\tfrac{\mu n}{(n-2)(n-1)}$, $\lambda_{\min}=-\tfrac\mu{n-1}$, and unit norm gives $\tfrac\mu{n-1}=\tfrac1m\sqrt{\tfrac{m-1}{2m-1}}$ with $m=n/2$; the recorded slack is $\lvert\lambda_{\min}\rvert-\tfrac{\lambda_{\max}}{n-2}=\tfrac1m\sqrt{\tfrac{m-1}{2m-1}}\big[1-\tfrac{n}{(n-2)^2}\big]$, giving $0.131762,\ 0.127295,\ 0.112500,\ 0.098883$ at $n=6,8,10,12$, **exactly the block's $0.1318,\ 0.1273,\ 0.1125,\ 0.0989$.** Derived here in closed form, not screened.

**Defect D3 (minor, but it inverts the evidence).** Line 319 reads "**it coincides with the recorded form exactly at the saturating families**, slack identical at the balanced products $(0.1318,\dots)$". Those slacks are **nonzero**: the balanced products *do not saturate*, line 367 of the same file says so ("at the balanced end the ratio is $n/(n-2)<n-2$, genuinely slack"). So the sentence calls the balanced products a saturating family and then prints their slack. And the family that *does* saturate under the current headline, $S^2\times S^{n-2}$, **is absent from the coincidence check entirely**.

**The repair is a theorem, not another measurement.** If $W$ saturates, $\lambda_{\max}=(n-2)\lvert\lambda_{\min}\rvert$, then the sharpened bound (valid everywhere), forces $-\tfrac{n-2}2(\lambda_{(1)}+\lambda_{(2)})\ge-(n-2)\lambda_{\min}$, i.e. $\tfrac12(\lambda_{(1)}+\lambda_{(2)})\le\lambda_{\min}$, hence $\lambda_{(1)}=\lambda_{(2)}=\lambda_{\min}$. **Saturation of L73 forces $\lambda_{\min}$ to be non-simple away from $\arg\max$, and the two forms therefore coincide at *every* saturating point, for every $n$.** That is what line 319 wants to say, and it needs no examples at all. (Consistency check: at $S^2\times S^{n-2}$, $E_{\min}$ is the mixed block, $\dim=2(n-2)\ge2$ ✓; at the even-$n$ maximal torus, $\dim E_{\min}=\binom n2-\tfrac n2\ge2$ ✓; at $\mathbb{CP}^m$, $E_{\min}=[\Lambda^{2,0}]$, $\dim=m(m-1)\ge2$ ✓.)

**Defect D4 (minor).** Line 319's "**and at every maximal torus**" drops the restriction line 317 imposes two lines above. Verified here: the coordinate-diagonal $K_{ij}=\alpha$ on the $n/2$ torus planes and $\beta$ elsewhere is Ricci-flat iff $\alpha+(n-2)\beta=0$; at odd $n$ the row through the unpaired index $e_n$ reads $\sum_{j\ne n}K_{nj}=(n-1)\beta$, which vanishes only at $\beta=0$. **So there is no torus witness at odd $n$**, and "every maximal torus" should read "every maximal torus at even $n$". At even $n$ the witness is real: $\alpha=n-2$, $\beta=-1$ gives $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n-2$ exactly.

### F6 (P6), the replacement witness saturates, and by *more* than the block claims: CONFIRMED and extended

Verified by hand, without the catalogue. For $S^p(r_1)\times S^q(r_2)$ with $R = \mathop{\mathrm{diag}}(\kappa_1$ on $\Lambda^2V_p$, $\kappa_2$ on $\Lambda^2V_q$, $0$ on mixed$)$ and $W=R-\tfrac1{n-2}\mathrm{Ric}_0\owedge g-\tfrac{s}{2n(n-1)}g\owedge g$, so that $w_{ij}=R_{ijij}-\tfrac{(\mathrm{Ric}_0)_{ii}+(\mathrm{Ric}_0)_{jj}}{n-2}-\tfrac{s}{n(n-1)}$:

- **Einstein case**, $p=2$: $\lambda(\Lambda^2V_2)=\tfrac{(n-2)\mu}{n-1}$, $\lambda(\Lambda^2V_{n-2})=\tfrac{2\mu}{(n-3)(n-1)}$, $\lambda(\text{mixed})=-\tfrac\mu{n-1}$; trace $=0$ ✓; $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n-2$ **exactly**. This matches the block spectrum already on the record at [bounds.md](../findings/bounds.md) line 367, independently rederived here.
- **$n=4$ works too.** $S^2\times S^2$: blocks $\tfrac{2\mu}3,\tfrac{2\mu}3,-\tfrac\mu3$, ratio $2=n-2$. So the saturating range is **every $n\ge4$**, one dimension wider than line 367's "every $n\ge5$".
- **Einstein is not needed.** At $n=5$ with free Ricci eigenvalues $t$ on $V_2$ and $u$ on $V_3$: $\lambda(\Lambda^2V_2)=\tfrac t2+\tfrac u4$, $\lambda(\text{mixed})=-\tfrac t6-\tfrac u{12}=-\tfrac13(\tfrac t2+\tfrac u4)$, $\lambda(\Lambda^2V_3)=+\tfrac13(\tfrac t2+\tfrac u4)$. The ratio is **identically $3=n-2$ for every radius pair**, and the ordering holds whenever $t,u>0$. So the witness is a two-parameter family, not a point.
- **The mechanism the block gives is the right one and proves all of this in one line.** For $a=$ the area form of $V_2$ (the whole of $\Lambda^2V_2$, one-dimensional, hence abelian), $[v_a,\cdot]$ annihilates $\Lambda^2V_2$ and maps $\Lambda^2V_{n-2}\to0$, so $\mathop{\mathrm{supp}}\mu_a$ lies in mixed$\times$mixed; (B) then reads $-\lambda_{\max}/(n-2)=\lambda_{\text{mixed}}$ **with no averaging slack**. Saturation follows the moment the mixed block is $E_{\min}$, which the spectrum above gives.
- **The block's other claimed saturators check out.** $\mathbb{CP}^m$ ($n=2m$): with $\mathcal R\alpha=\alpha-J\alpha J+\langle J,\alpha\rangle J$ the curvature operator has $2m+2$ on $\mathbb RJ$, $2$ on $\Lambda^{1,1}_0$, $0$ on $[\Lambda^{2,0}]$; subtracting $\tfrac s{n(n-1)}=\tfrac{2(m+1)}{2m-1}$ gives Weyl eigenvalues $\tfrac{4(m^2-1)}{2m-1},\ \tfrac{2m-4}{2m-1},\ -\tfrac{2(m+1)}{2m-1}$, trace zero ✓, **ratio $=2(m-1)=n-2$ exactly**. So line 323's "$\mathbb{CP}^m$ and the maximal tori are critical points and saturate it" is true (with D4's even-$n$ rider on the tori).

**Verdict on the headline's sharpness clause: CONFIRMED**, and the "$n=5,6,8,10,12$" list at line 317 is a screened subset of a family that saturates at every $n\ge4$ and at every radius ratio. **No surviving sentence in the block asserts either withdrawn claim** ("slack at every sphere product" appears nowhere outside the explicit withdrawal at line 317 and the resolution at line 367); the only residue is D4's unqualified "every maximal torus".
### F7 (P7, MAJOR), line 321's "the whole of what the row calculus says" is FALSE, is refuted twice below it in the same file, and still stands unstruck

Line 321 asserts, inside L73's own block:

> **Lemma L73 is therefore the whole of what the row calculus says on $\mathcal W_n$, and the per-row family is the whole of what it says at critical points.**

**Both halves are false, and the record already knows it, 14 and 30 lines further down, under two other lemma headings, with no mark on line 321.**

- **Second half, refuted at line 335** ([r337](REVIEW_r337.md), inside L107's block): row $a$ pins *two* moments against the *same* measure $\mu_a$, so the complete per-row condition is that $(\mathbb E X,\mathbb E Y)$ lies in the **convex hull** of the pair-points $\{(X_{bc},Y_{bc})\}$, of which the per-row family is one axis projection. A hull is contained in its bounding box, strictly in general, and the record gives padded $W_{\mathbb{CP}^2}$ as the separating witness ($\theta\le3\varepsilon=\sqrt{3/2}$ exact from the hull against $\tfrac{n+2}2\varepsilon$ from the projection).
- **First half, refuted at line 351** ([r338](REVIEW_r338.md), L112). Verified cold here: $S_{ab}:=\sum_cT_{abc}$ is symmetric ($T$ totally symmetric), nonnegative, hollow ($T_{aac}=0$); (A) gives $\sum_bS_{ab}=2(n-2)$ and (B) gives $S\lambda=-2\lambda$, so $D:=S/2(n-2)$ is symmetric hollow doubly stochastic with $D\lambda=-\lambda/(n-2)$. **L73 is exactly the $k=1$ shadow of that**: $(D\lambda)_a$ is a convex combination of the $\lambda$'s. The full statement is strictly stronger, a doubly stochastic $D$ forces $-\lambda/(n-2)\prec\lambda$ (majorization), an infinite family of subset-sum inequalities of which L73 is the top-$1$ member.
- **A third, independent refutation, available without leaving the block.** L73 as *displayed* is not even the sharp **one-row** projection of (B): line 319, two lines above line 321, records the strictly stronger row-range form. A sentence claiming to be "the whole of" a calculus is contradicted by the sharper consequence of that calculus printed immediately above it.

**This is precisely the failure mode the record has caught before**: a headline claim refuted by a passage further down the same file, never reconciled. Line 321 is currently the load-bearing sentence for what [I24](../plan.md) "can hope for" (it tells the reader to stop developing (A)+(B) on $\mathcal W_n$) while line 351 says the opposite ("**This is what I24 should be built on**"). **Repair: strike or rewrite the sentence at line 321**, keeping its true part (the (A),(B) vs (C) split) and pointing forward to L112 for what the calculus actually says.

### F8 (P7), is L73 the sharp projection? No, and the block claims more than it proves

Answer to the brief's question directly. L73 reads **one** moment of **one** row, then relaxes the support to the full spectral interval. It is therefore lossy at three levels:

1. **Support relaxation**, $[\lambda_{\min},\lambda_{\max}]$ in place of $\{\tfrac{\lambda_b+\lambda_c}2:b\ne c,\ b,c\ne a\}$. The sharp one-moment, one-row projection is line 319's strengthened form, not the displayed one.
2. **One row of two moments**, off the critical set only (B) is available, so a *one-dimensional* statement is the right shape for L73 and r337's hull does **not** apply to it (the hull needs (C), hence criticality). **So L73 being one-dimensional is consistent with r337**; what r337 refutes is line 321's second clause about the critical-point family, not the lemma.
3. **One row of many**, L112's $D\lambda=-\lambda/(n-2)$ couples all rows and is strictly stronger.

So: **the LEMMA claims exactly what it proves**; the **block** claims more than it proves, in one sentence (line 321), and understates its own strength in another (the headline box prints the crude form while line 319 holds the sharper one, and results.md line 198 already carries both).

### F9 (P8), cross-check against the rest of the record

- [conventions.md](../findings/conventions.md) is consistent with everything used here: $\kappa=2(n-2)$ Killing marginal, $T_{abc}=c_{abc}^2$ totally symmetric and hollow, the pair cap $\sum_\gamma T_{\alpha\beta\gamma}\le2$. The $\Theta_n$ odd-$n$ square-root repair is not touched by L73, L73 carries no $\theta$.
- [references/boehm-wilking-2008-space-forms/notes.md](../references/boehm-wilking-2008-space-forms/notes.md) carries Lemma 2.1 verbatim: $R+R\#I=(n-1)R_I+\tfrac{n-2}2R_{\mathrm{Ric}_0}$, whose Weyl component is $W\#I=-W$, and whose proof runs by exactly the $n=4$-plus-embedding route derived independently in F1. **The record's attribution for (B) is correct**, and the notes also give the $\Lambda^4$-free Schur argument for why (A) and (B) are the *only* two linear relations of this kind. So "(B) is a Weyl identity holding on all of $\mathcal W_n$" is **confirmed** twice over.
- [results.md](../results.md) line 198 states L73 correctly, including the strengthened form, the no-criticality clause, and the even-$n$ rider on the tori that line 319 of bounds.md drops (D4). **results.md is the more accurate of the two.**
- [findings/bounds-relaxations.md](../findings/bounds-relaxations.md) line 329 and line 360 cite L73 correctly (as $\theta$-free, and as one of the row-calculus bounds); **no contradiction found there**.
- [findings/bounds.md](../findings/bounds.md) line 367 settles the sharpness dispute in closed form and agrees with F6, except that its "$n\ge5$" understates the range by one dimension (F6 gives $n\ge4$) and it restricts to the Einstein sub-family (F6 gives every radius ratio).
- [findings/INDEX-results.md](../findings/INDEX-results.md) **has no row for L73**, the file's only hit on the string is result 112's row, which mentions L73 in passing. Given the lemma is cited 17 times, the missing index row is a structural defect (D5) rather than a mathematical one.

## Defect list, in priority order

| # | where | severity | what |
| --- | --- | --- | --- |
| **D1** | [bounds.md](../findings/bounds.md) line 321, the sentence "Lemma L73 is therefore the whole of what the row calculus says on $\mathcal W_n$, and the per-row family is the whole of what it says at critical points" | **major, false, and refuted twice below it** | Refuted by L112 at line 351 and r337 at line 335, both unstruck against it; also by line 319 two lines above. Strike or rewrite, keep the (A),(B)/(C) split. |
| **D2** | line 325, the display $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$ | moderate, scope | Derived from (C), hence **critical points only**, but printed unqualified as the closing line of the blockquote headed "AND IT NEEDS NO CRITICALITY", inside a lemma box that says "critical or not". Add the qualifier or move it to L70. |
| **D3** | line 319, "coincides ... exactly at the saturating families, slack identical at the balanced products $(0.1318,\dots)$" | minor, inverted evidence | The balanced products are **not** saturating (their printed slack is nonzero, and line 367 says so); the actual saturator $S^2\times S^{n-2}$ is missing from the check. Replace with the one-line theorem of F5: saturation forces $\lambda_{(1)}=\lambda_{(2)}=\lambda_{\min}$, so the two forms coincide at every saturating point. |
| **D4** | line 319, "and at every maximal torus" | minor, residue of a withdrawn claim | Line 317 restricts the torus family to **even $n$**; line 319 drops the restriction. Verified: no torus witness exists at odd $n$. |
| **D5** | [INDEX-results.md](../findings/INDEX-results.md) | structural | No row for L73, though it is cited 17 times. |
| **M1** | line 323, "The derivation uses only (B) and $T\ge0$" | cosmetic | It also uses **(A)**, without the mass $2(n-2)$ the constant $n-2$ does not appear. (A) is equally unconditional, so nothing downstream moves. |
| **M2** | line 317, "$S^2\times S^{n-2}$ **saturates**, at $n=5,6,8,10,12$"; line 367, "at every $n\ge5$" | cosmetic, understated | Saturation holds at every $n\ge4$ and at every radius ratio, not only the Einstein member (F6). |
