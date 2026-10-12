# VERIFY v51, L148-r2: the coordinate-diagonality claim, the "both branches absent" clause, and the $m\ge3$ / $m\ge5$ floors

**Verifier v51, cold brief, [ROUND_L148r2](ROUND_L148r2.md), text at [findings/second-order.md](../findings/second-order.md):1189–1202.** No numerical work of any kind was done: no script was run, nothing was sampled, and every value below is an exact hand evaluation from closed forms already on the record. Log: [agent_logs/verify-L148r2-v51.log](../agent_logs/verify-L148r2-v51.log).

## Claim table

| # | Claim, as the entry states it | Verdict |
| --- | --- | --- |
| C1 | $\mathrm{Alt}(W(t)_-)=0$ for every real $t$ along $W(t)=W^*+tH$, $H$ in the joint $\lambda_m$-eigenspace | **PROVEN**, an exact algebraic identity, per direction, on the affine subspace $W^*+H_s$ |
| C2 | The vanishing holds on **both** $S^2_0(\mathbb R^m)$ copies, $h$ on $V_1$ and $k$ on $V_2$ diagonalising in one frame | **PROVEN**, $O(m)\times O(m)$ acts independently on the two factors and fixes $W^*$ |
| C3 | "$W^*$ and $H$ simultaneously diagonal on coordinate $2$-planes" is false in a fixed frame, $h_{12}=1$ giving $H_{1424}=\alpha h_{12}\ne0$ at every $m\ge3$ | **CONCLUSION PROVEN, CONSTANT WRONG**, the entry is exact at $m=3$ and carries the wrong coefficient at every $m\ge4$, where the entry is $-\beta h_{12}$ |
| C4 | $\lambda_m-\mu=\tfrac{m-4}{2(m-1)}$, tying at $m=4$, the margin sitting on $\Lambda^2\!\otimes\!\Lambda^2$ at $m=3$ | **PROVEN**, reproduced exactly from [Lemma L27](../findings/nondegeneracy.md)'s ten values and [Lemma L26](../findings/nondegeneracy.md)'s $\mu$ |
| C5 | Branch 1 is present at $w=0$ and equals $c_p/S\le3/(n-2)$; only branch 2 goes unbounded | **PROVEN**, $c_p/\theta_0=3/(n-2)$ exactly, reproduced by hand |
| C6 | The entry asserts nothing at $W_{\mathbb{CP}^2}$, whose $\delta^2=\tfrac19\ne0$ shows contrapositively that it is coordinate-diagonal in no frame | **PROVEN**, $\delta^2=\tfrac19$ reproduced by hand; the contrapositive is valid |
| C7 | The printed **LEMMA L148**: "both defect branches are absent there" | **BROKEN**, refuted by the entry's own second box and by [L147](../findings/second-order.md):1185, and still printed |
| C8 | The printed **LEMMA L148**: "For $H$ in $S^2_0(\mathbb R^m)$" | **GAP**, singular where the box is plural, and the consumer at [L149](../findings/second-order.md):1224 still reads it singular |
| C9 | Consumer use: [L147](../findings/second-order.md):1181 reads L148 as setting $\lVert A''\rVert$ to zero on the summand | **HYPOTHESIS-DEBT**, L148 proves real-$t$ vanishing; $\lVert A''\rVert$ is a Cauchy estimate over a complex disc, and the extension is written nowhere |

**One line the round can act on.** The mathematics of the repair is right and every constant but one reproduces exactly by hand, but the repairs were written into boxes and never folded into the canonical **LEMMA L148** line, which still carries a clause the entry itself refutes ("both defect branches are absent") and a singular quantifier the entry itself widens, so the verdict is `GAP`, and the fix is three edits to line 1199 rather than any new mathematics.

## 0. Conventions, fixed once

- $n=2m$, $W^*$ the unit-norm Weyl tensor of the balanced product $S^m\times S^m$, $\mathbb R^n=V_1\oplus V_2=B_1\oplus B_2$ with $\dim V_i=m$.
- A tensor is **coordinate-diagonal** when, as a symmetric operator on $\Lambda^2\mathbb R^n$, it is diagonal in the basis $\{e_i\wedge e_j\}_{i<j}$ of coordinate $2$-planes.
- $\mathrm{Alt}$ is the first-Bianchi map, $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$, landing in $\Lambda^4$; $\delta^2(W)=\lVert\mathrm{Alt}(W_-)\rVert^2$ ([results.md](../results.md):667), with the operator norm $\lVert R\rVert^2=\sum_{i<j,\,k<l}R_{ijkl}^2$ that makes $W$ unit.
- $x\mapsto x_-$ is $\min(x,0)$ applied to the spectrum, so $W_-=\sum_\lambda\min(\lambda,0)P_\lambda$; it is defined for every real symmetric operator and needs no simple spectrum.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$; $\lambda_m=\tfrac{m-2}{2(m-1)}$; $\mu=\tfrac{n-2}{2(p-1)(q-1)}$, which at $p=q=m$ is $\tfrac1{m-1}$; $c_p=3\theta_0(\tfrac12-\lambda_m)$; $S=\sup\lvert P\rvert$.
- $\alpha=\tfrac{m-2}{2(m-1)}$ and $\beta=\tfrac m{2(m-1)}$ are [Lemma L146](../findings/second-order.md)'s corrected embedding constants, the cross-plane and in-block coefficients of the Weyl image of $h$. L148 uses the symbol $\alpha$ without redefining it, so this is the binding definition.

## 1. The hypothesis inventory

**Hypotheses the statement carries.** Base point $W^*=S^m\times S^m$; $n=2m$, so $n$ even and the split balanced; $m\ge3$; $H\in S^2_0(\mathbb R^m)$ (the box widens this to the joint two-copy eigenspace); $m\ge5$ carried as a caveat on the word "margin" in the title rather than on the conclusion.

**Hypotheses of every imported result, checked against the object.**

| Import | Its hypotheses | Does $W^*$ at $n=2m$, $m\ge3$ satisfy them? |
| --- | --- | --- |
| [Lemma L27](../findings/nondegeneracy.md), the ten summands and their $L_e$ values | $p,q\ge3$, $(p,q)\ne(3,3)$ | Yes for $m\ge4$; **at $m=3$ the balanced case $(3,3)$ is L27's single exclusion**, so the value list is available at $m=3$ but the nondegeneracy conclusion is not. L148 uses only the value list and the summand names, both of which L27 derives before the exclusion bites. |
| [Lemma L26](../findings/nondegeneracy.md), $\mu=\tfrac{n-2}{2(p-1)(q-1)}$ | $p,q\ge2$ | Yes at every $m\ge2$. |
| [Lemma L146](../findings/second-order.md), the corrected embedding $S^2_0(\mathbb R^m)\to\mathrm{Weyl}_n$, eigenvalues $\alpha h_a$ on cross planes, $-\beta(h_a+h_{a'})$ inside $B_1$, $0$ inside $B_2$ | single $h$, $\lVert H\rVert_F=1$, $n=2m$, $m\ge3$ | Yes. L148's $\alpha$ and its whole diagonality claim rest on this display, and **L148 never cites it**. |
| $O(m)\times O(m)$-invariance of $W^*$ | none beyond the product structure | Yes; it is the isotropy of the balanced product. |
| $O(n)$-equivariance of $\mathrm{Alt}$ and of $x\mapsto x_-$ | none | Yes; both are defined by $O(n)$-natural operations. |

**Which of these the written proof actually uses.** Only three: that $W^*$ is coordinate-diagonal in a frame adapted to $V_1\oplus V_2$; that $H$ becomes coordinate-diagonal after an $O(m)\times O(m)$ rotation; and that a coordinate-diagonal operator has $\mathrm{Alt}=0$. The proof uses **no** spectral gap $g_n$, **no** analyticity, **no** $\ker W^*=0$, **no** $n\ge12$ and **no** dimension floor at all beyond $m\ge3$, and the third of those three steps, the one that carries the whole conclusion, is stated in neither the box nor the statement.

**No finding on the omitted-hypothesis axis.** Every hypothesis the proof uses is stated or is immediate from the base point, and the entry states no hypothesis the proof fails to need. The floors $m\ge3$ and $m\ge5$ are both weaker than nothing the proof needs: at $m=2$ the summand is zero, since [Lemma L146](../findings/second-order.md) gives $\lVert H\rVert_F^2=\tfrac{m(m-2)}{2(m-1)}\lVert h\rVert^2=0$ there, so $m\ge3$ is exactly the range in which the entry has an object to talk about.

## 2. The two pre-registered questions, answered

### Q1, does the entry's scope match what its neighbours take from it?

**The floor this entry states:** $m\ge3$ on the conclusion, $m\ge5$ on the title's word "margin".

**The floor its proof needs:** none above $m\ge3$, and $m\ge3$ only so that the summand is non-zero. The vanishing itself is dimension-free.

**The floors its consumers assume:**

| Consumer | Floor it runs at | What it takes | Within L148's scope? |
| --- | --- | --- | --- |
| [L146](../findings/second-order.md):1159, "L148 displaces this lemma entirely" | $m\ge3$ | $A\equiv0$ on the two $S^2_0$ copies | **Yes.** The vanishing is true at $m=3$ and $m=4$; only the word "margin" fails there, and L146's displacement claim does not use it. |
| [L147](../findings/second-order.md):1181, "L148 sets that to zero on the very summand" | $n\ge12$, i.e. $m\ge6$ | $\lVert A''\rVert=0$ | **Scope yes, content no**, see F4. |
| [L149](../findings/second-order.md):1224 | $m\ge6$ | "L148 pins the variable $u$ to zero **on the named copy**" | **Yes on the floor, no on the quantifier**, see F2. |
| [second-order.md](../findings/second-order.md):1253, the penalty term | $n=12$ | "$A'(0)$ … vanishes on the margin subspace by L148, $u\le w$" | **Needs the plural**, since $w$ is defined at line 1211 as the weight outside *both* copies. |

**The answer.** The floors are consistent: $m\ge3$ contains every consumer's range, and the one place where the entry's own floor matters (the word "margin"), is flagged in the entry itself. The mismatch is not in the dimension floor at all; it is in the **quantifier over the copies**, which is F2.

### Q2, is the vanishing identical, or identical on a subspace?

**It is an algebraic identity, and it is identical on a subspace, a precisely nameable one.**

The identity is this. If $R$ is coordinate-diagonal, then $R_{ijkl}=0$ whenever $i,j,k,l$ are four distinct indices, because $\{i,j\}\ne\{k,l\}$ forces the entry off the diagonal. But $\mathrm{Alt}(R)$ lands in $\Lambda^4$, whose components are indexed by four *distinct* indices, and each is $\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$, a sum of three such entries. So $\mathrm{Alt}(R)=0$ identically. There is no inequality anywhere in this; nothing is bounded, and no constant enters.

**The subspace.** Let $H_s$ be the joint $\lambda_m$-eigenspace, $S^2_0(V_1)\oplus S^2_0(V_2)$ at $m\ge5$, of dimension $2s_m=(m+2)(m-1)$. Then for every $H\in H_s$ and every real $t$, $\mathrm{Alt}((W^*+tH)_-)=0$. Since $W^*+H$ is the $t=1$ point of the ray through $H$, the vanishing holds on the whole **affine subspace** $W^*+H_s$, not merely on rays.

**Two things it is not.** It is not vanishing on a neighbourhood of $W^*$ in $\mathcal W_n$: an arbitrarily small perturbation off $H_s$ carries a defect, which is what makes the mixed directions of [L149](../findings/second-order.md) the live question. And it is not vanishing in a single frame, the frame depends on $H$, which is F3's territory and the box's own correction.

## 3. Findings

### F1, the printed **LEMMA L148** still says "both defect branches are absent there", which the entry itself refutes six lines above it

**Locate.** [findings/second-order.md](../findings/second-order.md):1199, the canonical statement: "*Therefore $\mathrm{Alt}(W(t)_-)=0$ for every $t$: **the defect is identically zero along the whole segment**, and both defect branches are absent there.*"

**Exhibit the failure concretely.** Branch 1 is $f(u)=(c_p+u^2)/(S+au)$ ([L147](../findings/second-order.md):1183). L148 pins $u=0$ on $H_s$ and leaves $a$ and $S$ untouched, so branch 1 takes the value $f(0)=c_p/S$ there. At $n=12$ this is exactly $c_p/S$ with $c_p=3\theta_0(12)/10$ and $\theta_0(12)=\sqrt{220}/12$, hence $c_p/S\le c_p/\theta_0=3/10$, a finite, non-zero, non-absent number. Branch 1 is not merely present; it is the branch that carries [L147](../findings/second-order.md)'s ceiling. Two other places in the same file say so: the entry's own second box ("**WHAT IS ABSENT AT $w=0$ IS THE TWO DEFECT *TERMS*, NOT TWO BRANCHES**"), and [L147](../findings/second-order.md):1185 ("'both defect branches moved out of the way' is **impossible in principle**").

**Argue the opposite.** The most charitable reading is that "branch" in the LEMMA line means "defect term", the entry's own box says the two are being confused, and the box exists precisely to fix the confusion. On that reading the sentence is true. But the reading cannot be sustained: the box spends a whole paragraph separating the two senses of the word, and it names the sentence it is correcting. A repair box that corrects a sentence, followed by the uncorrected sentence, leaves the reader with the false one, and this file's own history is of exactly that failure ([L145](../findings/second-order.md):"the box is what the indexes propagated").

**Verdict: upheld.** The clause is false as printed and is refuted twice within the same file.

### F2, the statement's quantifier is singular where the box is plural, and the consumer 25 lines below still reads it singular

**Locate.** Statement at [findings/second-order.md](../findings/second-order.md):1199, "*For $H$ in $S^2_0(\mathbb R^m)$ at $W^*$*". Box at :1191, "**And the vanishing holds on both $S^2_0(\mathbb R^m)$ copies**". Consumer at :1224, "[L148] pins the **variable** $u$ to zero **on the named copy**".

**Exhibit the failure concretely.** At $m=6$, $n=12$, take $h=\mathrm{diag}(1,-1,0,0,0,0)$ on $B_1$ and $k=\mathrm{diag}(0,0,1,-1,0,0)$ on $B_2$, both trace-free, and let $H$ be the normalised sum of their Weyl images. This $H$ lies in the joint $\lambda_6$-eigenspace and is exactly the kind of vector [L149](../findings/second-order.md):1211 defines $H_s$ to range over, that line says in terms that reading $H_s$ as one copy is "*wrong by a factor $n$ on a subspace of dimension $\Theta(n^2)$*". Under the printed statement's singular reading, $H$ is not "in $S^2_0(\mathbb R^m)$" and L148 says nothing about it. The same singular reading is what [L149](../findings/second-order.md):1224 performs when it writes "the named copy".

**Argue the opposite.** "$S^2_0(\mathbb R^m)$" could name the isotypic component rather than one copy, and the box itself uses the same symbol for both copies. That is a real reading. Against it: [ROUND_L146](ROUND_L146.md) settled the identical phrase in the sibling entry by writing "*single* $h$" into L146's statement ([INDEX-results.md](../findings/INDEX-results.md) row 146), so the record has already fixed the singular sense for this exact phrase in this exact file; and the box's own gloss ("*written singular, used plural by every citation*"), is the record's own judgement that the singular reading is the operative one.

**Verdict: upheld.** The plural repair reached the box and reached neither the statement nor the citation that the box blames for the factor of $n$.

### F3, $H_{1424}=\alpha h_{12}$ is exact at $m=3$ and carries the wrong constant at every $m\ge4$

**Locate.** [findings/second-order.md](../findings/second-order.md):1191, "$h_{12}=1$ gives $H_{1424}=\alpha h_{12}\ne0$ at every $m\ge3$".

**Exhibit the failure concretely.** [Lemma L146](../findings/second-order.md)'s corrected embedding gives the Weyl image of $h$ as $\alpha h_a$ on $e_a\wedge e_b$ with $a\in B_1,b\in B_2$; $-\beta(h_a+h_{a'})$ on $e_a\wedge e_{a'}$ with $a,a'\in B_1$; and $0$ inside $B_2$, which is the map $H=-\beta\,(h\owedge g_1)+\alpha\,(h\owedge g_2)$, $g_i$ the metric of $B_i$. Take $h$ with $h_{12}=h_{21}=1$ and every other entry zero, which is trace-free and so admissible.

- At $m=3$, index $4\in B_2$, so $(g_1)_{44}=0$ and $(g_2)_{44}=1$, giving $H_{1424}=\alpha h_{12}\cdot 1=\alpha=\tfrac14$. **The entry is exact.**
- At $m=5$ ($n=10$), index $4\in B_1$, so $(g_1)_{44}=1$ and $(g_2)_{44}=0$, giving $H_{1424}=-\beta h_{12}=-\tfrac58$, while the entry's $\alpha h_{12}=\tfrac38$. The two differ in both sign and magnitude, and the same holds at every $m\ge4$.

**Argue the opposite.** L148 never defines $\alpha$ in its own text, so a reader may take it as an unnamed non-zero structure constant, under which the sentence is true at every $m\ge3$. And the clause's *purpose*, exhibiting one non-zero off-diagonal entry, so that "simultaneously diagonal in a fixed frame" is refuted, is served at every $m\ge3$ either way, since $\beta=\tfrac m{2(m-1)}>0$.

**Verdict: upheld as a constant, inert for the conclusion.** The entry's own file defines $\alpha$ fifty lines above, in the very lemma whose embedding this clause is testing, so the symbol is bound; but the refutation the clause exists to perform stands at every $m\ge3$ under both readings.

### F4, L148 proves real-$t$ vanishing; the consumer converts it into a Cauchy estimate over a complex disc, and the conversion is written nowhere

**Locate.** The claim: [findings/second-order.md](../findings/second-order.md):1193, "$\mathrm{Alt}(W(t)_-)=0$ for **every real $t$** … using no spectral gap, **no analyticity**". The use: [findings/second-order.md](../findings/second-order.md):1181, "it needs a **lower** bound on $\lVert A''\rVert$, and L148 sets that to zero on the very summand".

**Exhibit the failure concretely.** [L147](../findings/second-order.md):1173 defines the object being differentiated: $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ is a supremum over a **complex** disc, and $\lVert A''\rVert=O(M/\rho^2)$ is a Cauchy estimate, the record's holomorphic realisation of $W\mapsto W_-$ is the contour integral $W_-=-\tfrac1{2\pi i}\oint_\Gamma\zeta(W-\zeta)^{-1}d\zeta$ at [second-order.md](../findings/second-order.md):1471. So the quantity the consumer sets to zero is $A(z)$ on $\lvert z\rvert=\rho$, and what L148 delivers is $A(t)$ for $t$ real. The real diameter is a proper subset of the disc, and vanishing on it does not by itself set a supremum over the boundary circle to zero.

**Argue the opposite.** Two one-line closures exist. Either invoke the identity theorem, $A$ is holomorphic on the disc and vanishes on the real diameter, a set with a limit point, hence vanishes identically, which is the analyticity L148 explicitly disclaims and which is legitimately available since [L156](../findings/second-order.md) supplies the resolvent bounds. Or extend the entry's own argument: $W(z)=W^*+zH$ is diagonal in the *same* frame for complex $z$, its entries being affine in $z$, and the contour integral of a diagonal matrix is diagonal, so $A(z)=0$ on the whole disc without any analyticity. Both are immediate; **neither is on the record in L148 or in L147.**

**Verdict: upheld as debt, not as a defect.** What would have to be written: *for $H\in H_s$ and every complex $z$ in the disc of [Lemma L156](../findings/second-order.md), $W(z)$ is diagonal in the frame diagonalising $(h,k)$, hence so is its Riesz negative part, hence $A(z)=0$ and $M=\lVert A''\rVert=0$.* One sentence. I do not supply it; I name it.

## 4. Candidates examined and withdrawn

- **"The tensors $W^*$ and $H$ are simultaneously diagonal on coordinate $2$-planes" is false as printed.** *Withdrawn.* "Simultaneously diagonal" is standardly existential in the basis, and under that reading the statement is true per direction. The box's "false in a fixed frame" is then a clarification of a wording hazard rather than a correction of a falsehood. The three-step test fails at step three: the charitable reading is not merely available, it is the standard one.
- **At $m=4$ the joint $\lambda_m$-eigenspace is larger than the two $S^2_0$ copies, and L148 says nothing about the excess.** *Withdrawn as a defect, recorded as a consequence.* At $m=4$, $\lambda_4=\tfrac13=\mu$, so $\Lambda^2\!\otimes\!\Lambda^2$ joins the $\lambda_m$-eigenspace and the vanishing is claimed on none of it. But the entry's own clause "$\lambda_m-\mu$ … ties at $m=4$" is exactly this flag, and $m=4$ sits below every consumer's floor. I checked the remaining coincidences and there are none: $\lambda_m=-\mu$ never, $\lambda_m=0$ only at $m=2$, $\lambda_m=\tfrac12$ never since $\tfrac12-\lambda_m=\tfrac1{n-2}>0$, $\lambda_m=1$ never. So $m=4$ is the only dimension at which the eigenspace is larger than the two copies.
- **The absence of a canonical L148 from [results.md](../results.md).** *Withdrawn as a discrepancy*, see §7.
- **"$\Theta(n^{-1})$ ceiling" where the quantity is an upper cap.** *Withdrawn.* $c_p/S$ runs from $3/(n-2)$ down to $\Theta(n^{-3/2})$ as $S$ grows, so the cap is $O(n^{-1})$ and is $\Theta(n^{-1})$ only at $\beta=0$; but "the route's $\Theta(n^{-1})$ ceiling" is [L147](../findings/second-order.md)'s established name for the object, inherited rather than coined here, and the entry correctly writes "the **route's**" rather than the radius's.

## 5. The edge of every range

| Edge | What this entry asserts there |
| --- | --- |
| $m=2$, $n=4$ | **Nothing**, excluded by the stated floor $m\ge3$. And correctly: [L146](../findings/second-order.md)'s $\lVert H\rVert_F^2=\tfrac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ vanishes at $m=2$, so the summand is zero and the lemma would be vacuous. Both embedding constants degenerate too: $\alpha=\tfrac{m-2}{2(m-1)}=0$, which is why F3's counterexample needs $m\ge3$ exactly. |
| $m=3$, $n=6$ | The vanishing **is** asserted and **is** true; the title's word "margin" is **not**, and the entry says so. The margin at $m=3$ sits on $\Lambda^2\!\otimes\!\Lambda^2$, which carries $+\mu=\tfrac12$ by [L27](../findings/nondegeneracy.md), against $\lambda_3=\tfrac14$, so the smallest off-orbit margin is $3\theta_0(\tfrac12-\mu)=0$ there. This is also L27's excluded $(3,3)$, and the $\dim E(\tfrac12)=18$ against orbit $9$ is exactly the $9=\dim(\Lambda^2\mathbb R^3\otimes\Lambda^2\mathbb R^3)$ this clause names. **The clause is exactly right, including which of the two tensor summands it names.** |
| $m=4$, $n=8$ | The vanishing on the two copies is asserted and true; the margin ties, and the eigenspace grows, see §4. |
| Odd $n$ | **Nothing.** The entry fixes $n=2m$, so $n$ is even by construction, and at $p\ne q$ the two $S^2_0$ summands carry different eigenvalues $\lambda_p\ne\lambda_q$ and are not a joint eigenspace at all. No consumer takes an odd-$n$ statement from it. |
| $\ker W\ne0$ | The entry asserts the vanishing **survives** a kernel, and it is right: the proof uses no gap and no invertibility, and $x\mapsto x_-$ is defined at every real symmetric operator, so eigenvalue crossings along the segment are harmless. I checked the claim "the one link in the tube chain that survives a kernel" against the block: [L145](../findings/second-order.md) and [L146](../findings/second-order.md) both use $g_n$, [L147](../findings/second-order.md):1179 states $\ker W^*=0$ as a used hypothesis, [L149](../findings/second-order.md):1239 states it too, and [L156](../findings/second-order.md):1428 states it in its own statement. So among L145–L149, L152 and L156, L148 is indeed the only kernel-free link. |
| $W_{\mathbb{CP}^2}$, $\dim\ker W=3$ | The entry asserts **nothing** there, and says so, correctly, since $W_{\mathbb{CP}^2}$ lies on no segment $W^*+tH$ with $H\in H_s$. The contrapositive it does draw is valid: coordinate-diagonal $\Rightarrow$ $W_-$ coordinate-diagonal $\Rightarrow$ $\mathrm{Alt}(W_-)=0$ $\Rightarrow$ $\delta^2=0$, so $\delta^2=\tfrac19\ne0$ puts $W_{\mathbb{CP}^2}$ in no coordinate-diagonal frame. This agrees independently with [Lemma L40](../results.md), which classes it as non-diagonal. |

## 6. What a reader may take from this entry

**May take.** For every $H$ in the joint $\lambda_m$-eigenspace $H_s$ and every real $t$, the Bianchi defect of $(W^*+tH)_-$ is exactly zero. This is an identity, not a bound; it holds on the affine subspace $W^*+H_s$; the frame realising it depends on $H$; and it needs no spectral gap, no analyticity, no $\ker W^*=0$ and no dimension floor above $m\ge3$.

**May not take.** (i) That $\lVert A''\rVert=0$ where $A''$ is the Cauchy second derivative over a complex disc, F4. (ii) That both branches of the radius chain are absent at $w=0$; branch 1 is present and equals $c_p/S$, F1. (iii) A statement about any base point other than $W^*=S^m\times S^m$: "survives a kernel" is a claim about which ingredients the argument uses, not a lemma at a kernel-carrying base point. (iv) A statement at odd $n$ or at unbalanced $S^p\times S^q$. (v) A statement about the whole $\lambda_4$-eigenspace at $m=4$.

**What the block's surviving lower bound actually rests on here.** [L149](../findings/second-order.md)'s $c(H)\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)}w^2$ and its $u\le w$ both need the vanishing on **both** copies, since $w$ is defined as the weight outside both. That is precisely the content the box supplies and the statement does not, which is why F2 is the finding this round should act on.

## 7. The two forms

**[results.md](../results.md) carries no L148.** I checked: the string does not occur in the file, and neither do L145, L146, L147 or L149. The whole tube-radius block lives only in [findings/second-order.md](../findings/second-order.md), indexed from [findings/INDEX-results.md](../findings/INDEX-results.md).

**The absence is correct**, and for a reason stronger than uniformity: with no second copy there is no second form to diverge, and this file's recorded failure mode is a correction landing in one file and not its neighbour. I checked the third form that does exist, [INDEX-results.md](../findings/INDEX-results.md) row 148, against the entry, and it reproduces all three box corrections faithfully (frame after $H$, both copies, terms not branches) and adds no claim of its own. **One omission worth naming:** the index row records "no $\ker W^*=0$" and "no $n\ge12$" but records neither the $m\ge3$ floor nor the $m\ge5$ caveat on "margin", so a reader working from the index alone would take the entry as floor-free, which is the exact propagation route [second-order.md](../findings/second-order.md):1106 records for the previous floor error in this block.

## 8. Every numeral, against the constants the entry itself names

**Reproduced exactly, by hand.**

- $\lambda_m-\mu=\tfrac{m-4}{2(m-1)}$. From [L27](../findings/nondegeneracy.md), $\lambda_m=\tfrac{m-2}{2(m-1)}$; from [L26](../findings/nondegeneracy.md), $\mu=\tfrac{n-2}{2(p-1)(q-1)}$, which at $p=q=m$, $n=2m$ is $\tfrac{2m-2}{2(m-1)^2}=\tfrac1{m-1}$. So $\lambda_m-\mu=\tfrac{m-2}{2(m-1)}-\tfrac2{2(m-1)}=\tfrac{m-4}{2(m-1)}$. Zero at $m=4$; $-\tfrac14$ at $m=3$; positive from $m=5$.
- **The $m=3$ summand name.** [L27](../findings/nondegeneracy.md) assigns $+\mu$ to $\Lambda^2\!\otimes\!\Lambda^2$ and $-\mu$ to $S^2_0\!\otimes\!S^2_0$, forced by $\operatorname{tr}_{\mathcal W_n}L_e=0$ and discriminated against the reverse assignment. At $m=3$, $\mu=\tfrac12$ sits on $\Lambda^2\!\otimes\!\Lambda^2$, above $\lambda_3=\tfrac14$, so the smallest off-orbit margin is there. **The entry names the right summand.**
- $c_p/\theta_0=3/(n-2)$. $\tfrac12-\lambda_m=\tfrac{(m-1)-(m-2)}{2(m-1)}=\tfrac1{2(m-1)}=\tfrac1{n-2}$, so $c_p=3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$ and $c_p/\theta_0=3/(n-2)$ exactly. Since $S=\sup\lvert P\rvert\ge P(W^*)=\theta_0$, $c_p/S\le3/(n-2)$. Cross-checked against [results.md](../results.md):367's $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}$, which is the same $c_p$: $n\cdot3\theta_0/(n-2)=3\sqrt{2(n-1)(n-2)}/(n-2)=3\sqrt{2(n-1)/(n-2)}$. At $n=12$: $\theta_0=\sqrt{220}/12$, $c_p=3\sqrt{220}/120=\sqrt{220}/40$, $c_p/\theta_0=12/40=3/10$.
- $\delta^2(W_{\mathbb{CP}^2})=\tfrac19$. $W_{\mathbb{CP}^2}$ is self-dual with $\Lambda^2_+$-spectrum $(2,-1,-1)/\sqrt6$ ([Lemma L29](../results.md)) and zero on $\Lambda^2_-$, whence $\dim\ker W=3$. Writing $\omega_1=(e_{12}+e_{34})/\sqrt2$, $\omega_2=(e_{13}+e_{42})/\sqrt2$, $\omega_3=(e_{14}+e_{23})/\sqrt2$, each rank-one projector $\omega_i\otimes\omega_i$ contributes $R_{1234}+R_{1342}+R_{1423}=\tfrac12$, since exactly one of the three terms survives and equals $\tfrac1{\sqrt2}\cdot\tfrac1{\sqrt2}$. So $W_-=-\tfrac1{\sqrt6}(\omega_2\otimes\omega_2+\omega_3\otimes\omega_3)$ gives $R_{1234}+R_{1342}+R_{1423}=-\tfrac1{\sqrt6}$, hence $\mathrm{Alt}(W_-)_{1234}=-\tfrac1{3\sqrt6}$, and $\lVert\mathrm{Alt}(W_-)\rVert^2=6\cdot\tfrac1{54}=\tfrac19$ under the record's $\sum_{i<j,k<l}$ norm, the six terms being the three index pairings each counted twice. **Exactly $\tfrac19$, and the norm convention is the one that makes $W$ unit.**
- $\dim\ker W_{\mathbb{CP}^2}=3$: the anti-self-dual half of $\Lambda^2\mathbb R^4$, from the same spectrum.

**Not reproduced.**

- $H_{1424}=\alpha h_{12}$ at $m\ge4$. The correct value from [L146](../findings/second-order.md)'s own display is $-\beta h_{12}$, i.e. $-\tfrac58 h_{12}$ at $m=5$ against the entry's $\tfrac38 h_{12}$. Exact at $m=3$. This is F3, and it is inert: both constants are non-zero at every $m\ge3$, so the clause's refutation stands.

## 9. What would falsify the statement, and what I did to look for it

**The object that would break it.** A direction $H$ in the joint $\lambda_m$-eigenspace, and a real $t$, for which $W^*+tH$ admits no orthonormal frame making it coordinate-diagonal, equivalently, an $H\in H_s$ with $\mathrm{Alt}((W^*+tH)_-)\ne0$ for some $t$. By the contrapositive the entry itself draws, such an $H$ would have to produce a genuinely non-diagonal $W(t)$, so its own defect would be a closed-form non-zero number, exactly as $\tfrac19$ is at $W_{\mathbb{CP}^2}$.

**What I did to look for it.** Three routes, all by hand and all closed.

1. **The general element of $H_s$.** Every $H\in H_s$ is $(h,k)$ with $h\in S^2_0(V_1)$, $k\in S^2_0(V_2)$. $O(m)\times O(m)$ diagonalises the two independently and fixes $W^*$, so a falsifier would need an $H$ whose two components cannot be diagonalised by the *same* group element, impossible, since the group is a direct product acting on the two factors separately. **No falsifier of this shape.**
2. **A summand mistakenly counted into $H_s$.** I ran the eigenvalue-coincidence check over [L27](../findings/nondegeneracy.md)'s ten values: $\lambda_m$ collides with another value only at $m=4$ (with $+\mu$) and at $m=2$ (with $0$). At $m=4$ the excess is $\Lambda^2\!\otimes\!\Lambda^2$, on which the entry claims nothing, so it is not a falsifier of what is asserted; at $m=2$ the summand is zero. **No falsifier of this shape at any $m\ge5$.**
3. **The named kernel witness.** $W_{\mathbb{CP}^2}$ is the record's non-diagonal object with non-zero defect, and I checked whether it can be reached from $W^*$ along $H_s$. It cannot: it lives at $n=4$, and its padding at $n=2m$ has $\delta^2=\tfrac19$, so by the entry's own contrapositive it is not on the affine subspace $W^*+H_s$, every point of which has $\delta^2=0$. **The kernel witness confirms rather than falsifies.**

I did not search numerically, run any script, or sample any tensor; every object above is constructed in closed form.

## Verdict

`GAP`

**The core claim C1 and its widening C2 are proven**, an exact algebraic identity on the affine subspace $W^*+H_s$, for every real $t$, needing no gap, no analyticity, no $\ker W^*=0$ and no floor above $m\ge3$, and every constant the entry names reproduces exactly by hand except one, which is inert. **The gap is that the repairs live in boxes and the canonical statement was never edited:** it still carries "both defect branches are absent there", which the entry's own box and [L147](../findings/second-order.md):1185 each refute (F1), and it still quantifies over one copy where the box quantifies over two and where every consumer needs two (F2). Alongside them sits one genuine debt: the consumer at [L147](../findings/second-order.md):1181 reads L148 as zeroing a Cauchy second derivative over a complex disc, while L148 proves vanishing for real $t$ and explicitly disclaims the analyticity that would close the difference (F4). **What is owed is three edits to line 1199 and one sentence extending the diagonality to complex $z$, no new mathematics.**
