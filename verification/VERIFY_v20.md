# VERIFY v20, L146: the Weyl image of $S^2_0(\mathbb R^m)$, its two norms, the in-block branch, the supremum $1/\sqrt{m-1}$, and the range $[\Theta(n^{-1}),\Theta(n^{-1/2})]$

*Cold brief, worked from the definitions. No numerical work: every value below is an exact hand evaluation in rationals and surds, and every witness is exhibited in closed form. The two imports I read at source are the record's own Weyl projector and the $L_e$ spectrum at $S^p\times S^q$, both in [nondegeneracy.md](../findings/nondegeneracy.md); nothing else was consulted for the mathematics. Log: [agent_logs/verify-L146-v20.log](../agent_logs/verify-L146-v20.log).*

## Claim table

| # | claim | verdict |
|---|---|---|
| C1 | $\mathrm{Ric}(h\owedge g_q)=m\,h\ne0$, so the projection term survives | **CONFIRMED** |
| C2 | The Weyl image is diagonal on coordinate $2$-planes, with $\alpha h_a$ / $-\beta(h_a+h_{a'})$ / $0$, $\alpha=\frac{m-2}{2(m-1)}$, $\beta=\frac m{2(m-1)}$ | **CONFIRMED** against the record's own projector |
| C3 | $\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ | **CONFIRMED** (exact identity, every $m\ge2$) |
| C4 | $\lVert H\rVert_{op}=\beta\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$, the in-block branch always winning | **CONFIRMED AS ALGEBRA** on **one** copy, every $m\ge3$, strictly |
| C4′ | the same equality read on the **joint two-copy** $S^2_0(\mathbb R^m)\oplus S^2_0(\mathbb R^m)$ eigenspace | **REFUTED AS STATED**, witness $m=5$, $h=k=(1,0,0,0,-1)$: $3/4$ against the formula's $5/8$ |
| C5 | supremum $1/\sqrt{m-1}$, attained at the pair-concentrated $h$ | **CONFIRMED**, attained |
| C6 | $\lVert H\rVert_{op}$ ranges over $[\Theta(n^{-1}),\Theta(n^{-1/2})]$ | **CONFIRMED**, floor $\frac1{m-1}$ proven, witness $\frac{\sqrt2}{\sqrt{(m-1)(m-2)}}$ exhibited |
| C7 | the even split is not the minimiser | **CONFIRMED**, beaten at every $m\in\{5,6,7,8\}$ by $h\propto(1,0,\dots,0,-1)$ |
| C8 | this holds for $m\ge5$, where $\lambda_m>\mu$; $n\ge12$ is inside | **CONFIRMED**, $\lambda_m>\mu\iff m>4$, exactly; $m=4$ is a tie |
| C9 | the margin is $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$ | **CONFIRMED** as arithmetic ($\tfrac12-\lambda_m=\frac1{n-2}$) |
| C10 | downstream: $\lVert H_s\rVert_{op}\le a_0n^{-1/2}$, $a_0=\sqrt{2n/(n-2)}$, i.e. $1/\sqrt{m-1}$ | **CONFIRMED** on one copy; on the joint eigenspace it is **true but not on file in L146** |
| C11 | the same bound written in $n$, transported off $n=2m$ | **REFUTED**, $m=5$, $p=10$, $n=20$, $h=(4,-1,-1,-1,-1)$ gives $\frac{\sqrt{26}}{15}>\frac13$ |
| C12 | diagonality gives $v=0$ | **CONFIRMED**, $H_{ijkl}=0$ whenever $\{i,j\}\ne\{k,l\}$, so no four-distinct-index weight |

**One line the round can act on.** Every displayed formula in L146 is exactly right on **one** $S^2_0(\mathbb R^m)$ copy and the supremum $1/\sqrt{m-1}$ is attained; the equality clause is **false** on the joint two-copy eigenspace that the Setting names and that [ROUND_L149](ROUND_L149.md) applies it to, though the *bound* survives there because the cross-plane branch tops out at exactly $\sqrt{m-2}/m<1/\sqrt{m-1}$, a line L146 does not write.

**Verdict: PROVEN, hypotheses corrected.** The corrections are: $m\ge3$ (the statement is vacuous at $m\le2$), $n=2m$ is load-bearing and not decorative, the Frobenius norm is the $\Lambda^2$-operator one, and the equality clause is a one-copy statement. The joint-eigenspace extension is a **HYPOTHESIS-DEBT of L146 specifically**, discharged elsewhere in the record, never here.

## 0. Conventions, fixed once

$n=2m$; $\mathbb R^n=B_1\oplus B_2$ with $B_1,B_2$ the two $\mathbb R^m$ factors; $g_p,g_q$ the identity on $B_1,B_2$ extended by zero, $g=g_p+g_q$. Kulkarni–Nomizu

$$(A\owedge B)_{ijkl}=A_{ik}B_{jl}+A_{jl}B_{ik}-A_{il}B_{jk}-A_{jk}B_{il}.$$

An algebraic curvature tensor acts on $\Lambda^2$ with $\lambda_{ij}=R_{ijij}$ its value on $e_i\wedge e_j$ when diagonal there. **Frobenius is the $\Lambda^2$-operator norm** $\lVert R\rVert_F^2=\sum_{i<j}\lambda_{ij}^2$, and $\lVert h\rVert^2=\sum_a h_a^2$. Section 6 shows this convention is forced twice over. $\alpha=\frac{m-2}{2(m-1)}$, $\beta=\frac m{2(m-1)}$; note $\alpha+\beta=1$, $\beta-\alpha=\frac1{m-1}$, and $\alpha=\lambda_m$.

Throughout, $h$ is diagonalised in an orthonormal frame of $B_1$, free, since $h$ is symmetric and $g_p,g_q$ are the identity on their blocks in *every* orthonormal frame adapted to the splitting. The notation $h_a$ presupposes exactly this and nothing more.

## 1. The hypothesis inventory

### 1.1 Stated in the boxed lemma, and used

| hypothesis | where the proof needs it |
|---|---|
| $h\in S^2_0(\mathbb R^m)$, i.e. $\mathop{\mathrm{tr}}h=0$ | three separate places: it kills $(\mathop{\mathrm{tr}}h)g_q$ in $\mathrm{Ric}$ **and** makes $\mathrm{Ric}_0=\mathrm{Ric}$ with $s=0$ (§2); it is what turns $\sum_{a\ne a'}h_ah_{a'}$ into $-\lVert h\rVert^2$ in the $\lVert H\rVert_F^2$ identity (§3); and it is the whole content of the in-block-wins inequality (§4) |
| $H$ = the **Weyl image**, not $h\owedge g_q$ | the in-block eigenvalues exist only after projection; before it they are $0$ |
| $\lVert H\rVert_F=1$ | used **only** for the numeral $1/\sqrt{m-1}$. The operator-norm formula itself is homogeneous of degree $1$ in $h$ and needs no normalisation |
| $n=2m$ | load-bearing: $\alpha,\beta$ are $1-\frac m{n-2}$ and $\frac m{n-2}$, and only at $n=2m$ do these become $\frac{m-2}{2(m-1)},\frac m{2(m-1)}$. §7 exhibits the failure off it |

### 1.2 Used and never stated

- **U1, the Frobenius convention.** $\lVert H\rVert_F^2=\sum_{i<j}\lambda_{ij}^2$ rather than $\sum_{ijkl}H_{ijkl}^2$. These differ by a factor $4$ (a diagonal-on-$2$-planes tensor has exactly four nonzero components $H_{ijij},H_{ijji},H_{jiij},H_{jiji}$ per unordered pair), so the headline would halve to $\frac1{2\sqrt{m-1}}$ under the other reading. **Reported and then withdrawn as a defect**, §6 shows the convention is pinned twice independently.
- **U2, the input normalisation.** The parenthetical quotes the record's projector as $\mathrm{KN}(h)=\tfrac12(h\owedge g)$, but the eigenvalue display is the Weyl image of the **unhalved** $h\owedge g_q$. Immaterial: $\lVert H\rVert_{op}/\lVert H\rVert_F$ is scale-invariant, so neither the display's shape nor the supremum moves. Withdrawn.
- **U3, the second copy.** The Setting says "the **two** $S^2_0(\mathbb R^m)$ summands"; the boxed statement prices one. The second is embedded as the Weyl image of $g_p\owedge k$, $k\in S^2_0(\mathbb R^m)$ on $B_2$, and **the lemma never writes it**. This is the real finding, §5.
- **U4, $\ker\hat W^*=0$.** Not used by L146's own algebra, but used by everything it feeds (L145's analyticity of $W\mapsto W_-$ at $W^*$). §8.

### 1.3 Stated and not used

- **$m\ge5$.** The clause "*This holds for $m\ge5$, where $\lambda_m>\mu$*" attaches to the order-level conclusion, i.e. to *where the margin sits*. The boxed statement (both norms, the branch comparison, the supremum, the range), holds for **every $m\ge3$** and uses $m\ge5$ nowhere. It is correctly placed and correctly valued (§9), but it is not a hypothesis of the boxed claim, and a reader who carries it forward as one will refuse the lemma at $m=3,4$ where it is true.
- **$m\ge3$ is missing at the other end.** At $m=2$, $\lVert H\rVert_F^2=\frac{2\cdot0}{2}\lVert h\rVert^2=0$, so no $H$ with $\lVert H\rVert_F=1$ exists and the statement is vacuously true. No finding, but the honest range of the boxed claim is $3\le m$, and it is written nowhere.

### 1.4 Imports, checked against the object

| import | hypotheses | checked? |
|---|---|---|
| the record's projector $P(X)=Y-\frac2{n-2}\mathrm{KN}(\rho_0)-\frac1{n(n-1)}s\,\mathrm{KN}(g)$, $Y=X-\mathrm{Alt}(X)$ ([nondegeneracy.md](../findings/nondegeneracy.md), the projector paragraph) | $\mathrm{Alt}(X)=0$ needed for $Y=X$; $s=0$ needed to drop the third term | **both hold**: $h\owedge g_q$ is a Kulkarni–Nomizu product, hence satisfies the first Bianchi identity, so $\mathrm{Alt}=0$; and $s=\mathop{\mathrm{tr}}\mathrm{Ric}=m\mathop{\mathrm{tr}}h=0$. With $\mathrm{KN}=\tfrac12(\cdot\owedge g)$ the surviving term is $\frac1{n-2}\mathrm{Ric}_0\owedge g$, the classical one |
| [L27](../findings/nondegeneracy.md) and the $S^p\times S^q$ spectrum of $L_e$ | $p,q\ge3$, $(p,q)\ne(3,3)$ | holds at $p=q=m\ge5$. The summand carrying $\lambda_m=\frac{m-2}{2(m-1)}$ has multiplicity $s_m=\frac{(m+2)(m-1)}2=\dim S^2_0(\mathbb R^m)$, and it occurs **twice**, once for each of $m=p$ and $m=q$, the record's own table says two |
| L145's $g_n=\frac2n\sqrt{\frac{n-2}{2(n-1)}}$ and the disc $g_n/\lVert H\rVert_{op}$ | analyticity of $W\mapsto W_-$; a Frobenius ball | $g_n$ re-derived exactly in §6; the disc machinery itself is outside the brief and I take it as given |

## 2. C1 and C2, the corrected embedding, verified against the record's own projector

For symmetric $A,B$ on $\mathbb R^n$, tracing the Kulkarni–Nomizu product on the first and third slots,

$$\mathrm{Ric}(A\owedge B)=(\mathop{\mathrm{tr}}A)\,B+(\mathop{\mathrm{tr}}B)\,A-AB-BA .$$

With $A=h$ (traceless, supported on $B_1$) and $B=g_q$ (trace $m$, supported on $B_2$): $\mathop{\mathrm{tr}}h=0$, and $hg_q=g_qh=0$ because the supports are orthogonal blocks. Hence $\mathrm{Ric}(h\owedge g_q)=m\,h$, which is nonzero for $h\ne0$, and $s=m\mathop{\mathrm{tr}}h=0$. **C1 CONFIRMED**, and the projection term does survive.

With $s=0$ and $\mathrm{Alt}=0$ the record's projector reduces to $H=h\owedge g_q-\frac1{n-2}(mh)\owedge g$. Splitting $g=g_p+g_q$ and using $n-2=2m-2$,

$$H=\Big(1-\tfrac m{2(m-1)}\Big)\,h\owedge g_q-\tfrac m{2(m-1)}\,h\owedge g_p=\alpha\,h\owedge g_q-\beta\,h\owedge g_p ,$$

since $1-\frac m{2(m-1)}=\frac{2m-2-m}{2(m-1)}=\frac{m-2}{2(m-1)}=\alpha$. **The $\alpha,\beta$ of the display are exactly the record's own projector applied to this object.**

*Diagonality.* With $A,B$ both diagonal, $(A\owedge B)_{ijkl}$ is nonzero only when $i=k,j=l$ or $i=l,j=k$; on $\Lambda^2$ that is a diagonal operator in the coordinate-$2$-plane basis. Both summands above have this form, so $H$ does. On $e_i\wedge e_j$, $(A\owedge B)_{ijij}=A_iB_j+A_jB_i$, giving

- $a\in B_1$, $b\in B_2$: $h_a\cdot1+0\cdot0=h_a$ from the first term, $h_a\cdot0+0\cdot1=0$ from the second ⟹ $\boxed{\alpha h_a}$;
- $a,a'\in B_1$: $0$ from the first, $h_a+h_{a'}$ from the second ⟹ $\boxed{-\beta(h_a+h_{a'})}$;
- $b,b'\in B_2$: $0$ from both ⟹ $\boxed{0}$.

**C2 CONFIRMED**, exactly as displayed. **C12 CONFIRMED** as a corollary: $H_{ijkl}=0$ whenever $\{i,j\}\ne\{k,l\}$, so every component on four distinct indices vanishes and the $(2,2)$ four-set weight is zero.

## 3. C3, the Frobenius identity

Traceless $h$ gives $\sum_{a\ne a'}h_ah_{a'}=(\sum_ah_a)^2-\lVert h\rVert^2=-\lVert h\rVert^2$, hence

$$\sum_{a<a'}(h_a+h_{a'})^2=\tfrac12\big[2(m-1)\lVert h\rVert^2+2\textstyle\sum_{a\ne a'}h_ah_{a'}\big]=(m-2)\lVert h\rVert^2 . \tag{3.1}$$

Summing the squared eigenvalues over the three plane types: $m^2$ cross planes contribute $\alpha^2\sum_{a,b}h_a^2=\alpha^2m\lVert h\rVert^2$; the $B_1$ in-block planes contribute $\beta^2(m-2)\lVert h\rVert^2$ by (3.1); the $B_2$ planes contribute nothing. So

$$\lVert H\rVert_F^2=\big[\alpha^2m+\beta^2(m-2)\big]\lVert h\rVert^2=\frac{m(m-2)}{4(m-1)^2}\big[(m-2)+m\big]\lVert h\rVert^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2 .$$

**C3 CONFIRMED**, exactly, for every $m$. Write $r^2:=\frac{2(m-1)}{m(m-2)}$ for the value of $\lVert h\rVert^2$ at $\lVert H\rVert_F=1$.

## 4. C4, the in-block branch always wins, and it wins strictly

$H$ is diagonal, so $\lVert H\rVert_{op}=\max\big(\alpha M,\ \beta c\big)$ with $M:=\max_a\lvert h_a\rvert$ and $c:=\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$. The claim is $\beta c\ge\alpha M$ always.

> **Lemma (the inequality the claim needs).** For traceless $h$, $c\ge\frac{m-2}{m-1}M$.
>
> *Proof.* Both sides are even in $h$, so replace $h$ by $-h$ if needed and take $h_{a^*}=M$. For every $j\ne a^*$, $\lvert M+h_j\rvert\le c$ gives $h_j\le c-M$. Summing the $m-1$ such $j$ and using $\sum_{j\ne a^*}h_j=-M$: $-M\le(m-1)(c-M)$, i.e. $(m-1)c\ge(m-2)M$. $\square$

Hence $\beta c\ge\frac m{2(m-1)}\cdot\frac{m-2}{m-1}M=\frac m{m-1}\cdot\alpha M$, and $\frac m{m-1}>1$. **The in-block branch wins strictly whenever $h\ne0$, for every $m\ge3$**, there are no ties to worry about, and the equality $\lVert H\rVert_{op}=\beta c$ holds. **C4 CONFIRMED AS ALGEBRA.**

*Sharpness of the auxiliary inequality, so the reader knows it is not slack being spent.* At $h=(m-1,-1,\dots,-1)$ and $m\ge4$: $M=m-1$, $c=\max(m-2,2)=m-2$, and $\frac{m-2}{m-1}M=m-2=c$. The bound is attained.

*What would break C4.* A traceless $h$ with $\frac m{m-2}\,c<M$. The lemma above forbids it: $\frac m{m-2}c\ge\frac m{m-2}\cdot\frac{m-2}{m-1}M=\frac m{m-1}M>M$. I looked for one in the two families where $M$ is largest relative to $c$ (the spike $(m-1,-1,\dots,-1)$ and the near-spike $(A,-\varepsilon,\dots,-\nu)$) and the extremal problem's own solution is the spike, which fails by the factor $\frac m{m-1}$.

## 5. C4′, the equality clause is FALSE on the joint two-copy eigenspace

### 5.1 Locate

The Setting: "*[Lemma L27] puts the off-orbit margin maximum on the **two** $S^2_0(\mathbb R^m)$ summands*". The boxed statement: "*For $H$ the Weyl image of $h\in S^2_0(\mathbb R^m)$ … $\lVert H\rVert_{op}=\frac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$*". The hypothesis the display needs and lacks is **$k=0$**: that the component in the second copy vanishes.

### 5.2 The joint object, in closed form

The second copy is the Weyl image of $g_p\owedge k$, $k\in S^2_0(\mathbb R^m)$ on $B_2$. The §2 computation with the roles of $B_1,B_2$ exchanged gives $\alpha k_b$ on cross planes, $-\beta(k_b+k_{b'})$ inside $B_2$, $0$ inside $B_1$. Both copies are diagonal in the same basis ($h$ and $k$ live on orthogonal blocks, so a single adapted frame diagonalises both), and $H_{\mathrm{tot}}=H(h)+H'(k)$ has

$$\alpha(h_a+k_b)\ \text{ on }e_a\wedge e_b;\qquad -\beta(h_a+h_{a'})\ \text{ inside }B_1;\qquad -\beta(k_b+k_{b'})\ \text{ inside }B_2 . \tag{5.1}$$

The two images are Frobenius-orthogonal: $\sum_{a,b}(h_a+k_b)^2=m\lVert h\rVert^2+2(\sum_ah_a)(\sum_bk_b)+m\lVert k\rVert^2=m(\lVert h\rVert^2+\lVert k\rVert^2)$, so C3 becomes $\lVert H_{\mathrm{tot}}\rVert_F^2=\frac{m(m-2)}{2(m-1)}(\lVert h\rVert^2+\lVert k\rVert^2)$.

### 5.3 Exhibit, an exact counterexample at $m=5$, $n=10$

Take $h=k=(1,0,0,0,-1)$, both traceless. Here $\alpha=\tfrac38$, $\beta=\tfrac58$. From (5.1):

- cross planes: $\max_{a,b}\lvert h_a+k_b\rvert=\lvert1+1\rvert=2$, so the branch is $\tfrac38\cdot2=\tfrac34$;
- inside $B_1$: $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert=1$, branch $\tfrac58$; inside $B_2$: likewise $\tfrac58$.

$$\lVert H_{\mathrm{tot}}\rVert_{op}=\tfrac34\qquad\text{while the lemma's formula returns}\qquad \beta\max_{a\ne a'}\lvert h_a+h_{a'}\rvert=\tfrac58 .$$

Wrong by the factor $\tfrac65$. Normalising: $\lVert H_{\mathrm{tot}}\rVert_F^2=\frac{5\cdot3}{2\cdot4}\cdot4=\tfrac{15}2$, so the true value is $\frac{3/4}{\sqrt{15/2}}=\frac{\sqrt{30}}{20}$ and the formula's is $\frac{\sqrt{30}}{24}$. *(Arithmetic check on (3.1) at this $h$: the ten pair sums are $1,1,1,0,0,0,-1,0,-1,-1$, squares summing to $6=(m-2)\lVert h\rVert^2=3\cdot2$. And $\alpha^2\cdot5\cdot4+2\beta^2\cdot6=\frac{180}{64}+\frac{300}{64}=\frac{480}{64}=\frac{15}2$, consistent.)*

The counterexample is not exotic: from (5.1) the cross branch beats the in-block branch on the whole family $h=k=(1,0,\dots,0,-1)$ whenever $\alpha\cdot2>\beta\cdot1$, i.e. $2(m-2)>m$, i.e. **every $m\ge5$**, the lemma's own stated range.

### 5.4 Argue the opposite

The boxed statement says "*the Weyl image of $h\in S^2_0(\mathbb R^m)$*", singular, and the display's variables are $h_a$ alone. On the most charitable reading (one copy, the second folded into some remainder), my object lies outside the statement and there is nothing to refute. **I accept that reading for the boxed claim**, which is why C4 stands as CONFIRMED. What the reading costs is that the Setting's own sentence ("the two summands") then does not describe the object priced, and the lemma covers a subspace of dimension $s_m$ inside a margin eigenspace of dimension $2s_m$, a subfamily cited in general, this record's named trap.

### 5.5 What the joint case actually gives, and whose line it is

The **bound** does survive, and its value is not the crude one. For traceless $h$, $\max_a h_a=\langle h,E_{11}-\tfrac1mI\rangle\le\lVert h\rVert\sqrt{\tfrac{m-1}m}$, attained. So on $\lVert h\rVert^2+\lVert k\rVert^2=r^2$ the cross branch is at most $\alpha\sqrt{\tfrac{m-1}m}(\lVert h\rVert+\lVert k\rVert)\le\alpha\sqrt{\tfrac{2(m-1)}m}\,r$, and

$$\alpha\sqrt{\tfrac{2(m-1)}m}\;r=\frac{m-2}{2(m-1)}\cdot\frac{2(m-1)}{m\sqrt{m-2}}=\frac{\sqrt{m-2}}{m},$$

attained at $h\propto k\propto(m-1,-1,\dots,-1)$ with $\lVert h\rVert=\lVert k\rVert=r/\sqrt2$ (there the in-block branch is smaller by the factor $\frac m{2(m-1)}<1$, so the cross branch really is the maximum). Since $(m-1)(m-2)<m^2$ for every $m$,

$$\frac{\sqrt{m-2}}m<\frac1{\sqrt{m-1}} ,$$

so the joint supremum is still $\frac1{\sqrt{m-1}}$, attained at $k=0$. At $n=12$ that is $\tfrac13$ against $\tfrac1{\sqrt5}$.

**This is a check I ran against a named object, not a repair.** L146 contains no cross-branch computation and no second-copy variable; the extension is not on file *in this lemma*. The debt is discharged elsewhere in the record, [ROUND_L149](ROUND_L149.md) carries the same two numbers, so this is a locality defect in L146, not a hole in the programme. **C10: the lemma as written gives the bound on one copy; on the joint eigenspace it gives less than downstream uses.**

## 6. The Frobenius convention, reported, then withdrawn

$\lVert\cdot\rVert_F$ is never defined in the entry, and the two candidate conventions differ by a factor $2$ in the norm, hence by $2$ in the headline. It is nonetheless pinned twice:

1. **Internally.** C3's identity $\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ holds in the $\Lambda^2$-operator convention and in no other.
2. **Against L145.** The Weyl tensor of $S^m\times S^m$: $R=\tfrac12(g_p\owedge g_p+g_q\owedge g_q)$ has $\mathrm{Ric}=(m-1)g$, hence $\mathrm{Ric}_0=0$ and $s=2m(m-1)$, so $W^*=R-\frac s{2n(n-1)}g\owedge g$ with $\frac s{2n(n-1)}=\frac{m-1}{2(2m-1)}$. Its $\Lambda^2$ eigenvalues are $1-\frac{m-1}{2m-1}=\frac m{2m-1}$ inside each block (multiplicity $m(m-1)$) and $-\frac{m-1}{2m-1}$ on the cross planes (multiplicity $m^2$), trace $\frac{m(m-1)m-m^2(m-1)}{2m-1}=0$, as a Weyl tensor must have. Then $\lVert W^*\rVert_F^2=\frac{m^2(m-1)}{2m-1}$ and, at unit Frobenius norm,
$$\lvert\lambda_-\rvert=\frac{m-1}{2m-1}\cdot\frac{\sqrt{2m-1}}{m\sqrt{m-1}}=\frac{\sqrt{m-1}}{m\sqrt{2m-1}}=\frac2n\sqrt{\frac{n-2}{2(n-1)}} ,$$
which is L145's $g_n$ **exactly**. The same convention, and the same one L146 needs.

**Withdrawn as a defect**, the third step of the protocol succeeds: the author's meaning is recoverable and consistent. It stays as a note because a reader who guesses $\sum_{ijkl}H_{ijkl}^2$ gets $\frac1{2\sqrt{m-1}}$ and every downstream constant moves.

*By-product, both directions of the disc.* $g_n=\frac{\sqrt{m-1}}{m\sqrt{2m-1}}=\Theta(n^{-1})$ ✓. At the supremum direction $g_n/\lVert H\rVert_{op}=\frac{m-1}{m\sqrt{2m-1}}=\Theta(n^{-1/2})$; at the minimising directions of §7 it is $\Theta(1)$. So "*the disc is $\Omega(n^{-1/2})$ throughout, a factor $\sqrt n$ larger than $g_n$*" is CONFIRMED as arithmetic.

## 7. C5, C6, C7, the supremum, the range, the minimiser

**C5.** Maximising $\lvert h_1+h_2\rvert$ over traceless $h$ with $\lVert h\rVert=r$ is Cauchy–Schwarz against the traceless part $v_0=(1,1,0,\dots,0)-\tfrac2mI$, with $\lVert v_0\rVert^2=2-\tfrac4m=\frac{2(m-2)}m$. So $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert=r\sqrt{\frac{2(m-2)}m}=\sqrt{\frac{2(m-1)}{m(m-2)}}\sqrt{\frac{2(m-2)}m}=\frac{2\sqrt{m-1}}m$, and

$$\lVert H\rVert_{op}=\beta\cdot\frac{2\sqrt{m-1}}m=\frac m{2(m-1)}\cdot\frac{2\sqrt{m-1}}m=\frac1{\sqrt{m-1}} .$$

**Attained** (the feasible set (sphere ∩ hyperplane) is compact), at $h\propto v_0$, which is the pair-concentrated $h$ as named. Worked at $m=5$: $h\propto(3,3,-2,-2,-2)/5$, $r^2=\tfrac8{15}$, $\max$ pair sum $=\tfrac45$, $\lVert H\rVert_{op}=\tfrac58\cdot\tfrac45=\tfrac12=\tfrac1{\sqrt4}$. **CONFIRMED.**

**C6, upper end.** $\frac1{\sqrt{m-1}}=\sqrt{\frac2{n-2}}=\Theta(n^{-1/2})$. **CONFIRMED.**

**C6, lower end, a proven floor.** By (3.1) and averaging over the $\binom m2$ pairs, $c^2\ge\frac{(m-2)\lVert h\rVert^2}{\binom m2}=\frac{2(m-2)}{m(m-1)}\lVert h\rVert^2$, so

$$\frac{\lVert H\rVert_{op}}{\lVert H\rVert_F}\ \ge\ \frac m{2(m-1)}\sqrt{\frac{2(m-2)}{m(m-1)}\cdot\frac{2(m-1)}{m(m-2)}}=\frac m{2(m-1)}\cdot\frac2m=\frac1{m-1} .$$

**C6, lower end, a witness.** For $m$ even take $h$ with $m/2$ entries $+u$ and $m/2$ entries $-u$: $c=2u$, $\lVert h\rVert^2=mu^2=r^2$, so $\lVert H\rVert_{op}=\beta\frac{2r}{\sqrt m}=\frac{\sqrt2}{\sqrt{(m-1)(m-2)}}$. For $m$ odd, $\tfrac{m-1}2$ of each sign and one zero gives $\frac{\sqrt{2m}}{(m-1)\sqrt{m-2}}$. Both are $\Theta(m^{-1})=\Theta(n^{-1})$. So

$$\frac1{m-1}\ \le\ \inf_{\lVert H\rVert_F=1}\lVert H\rVert_{op}\ \le\ \frac{\sqrt2}{\sqrt{(m-1)(m-2)}},$$

and the range $[\Theta(n^{-1}),\Theta(n^{-1/2})]$ is **CONFIRMED**. *This also resolves the entry's "the reviewers differ on the exact lower bound": on the brief's own figures, $1/(m-1)$ is a **proven floor** and $\approx\sqrt2/m$ is an **attained value**, so they are bounds on opposite sides of one infimum and do not conflict. Recorded as `withdrawn`, there is no disagreement to adjudicate, only a bracket of ratio $\sqrt2\sqrt{\frac{m-1}{m-2}}$.*

**C7, the even split is not the minimiser.** At $h\propto(1,0,\dots,0,-1)$: $c=\lVert h\rVert/\sqrt2$ (the largest pair sum pairs the $+$ entry with a zero), giving $\lVert H\rVert_{op}=\frac{\sqrt m}{2\sqrt{(m-1)(m-2)}}$. This beats the even split exactly when $\frac{\sqrt m}2<\sqrt2$, i.e. $m<8$, with equality at $m=8$. At $m=6$ ($n=12$, the flagship): $\frac{\sqrt{30}}{20}=0.2739\ldots$ against the even split's $\frac1{\sqrt{10}}=\frac{\sqrt{40}}{20}$, and $\sqrt{30}<\sqrt{40}$. **CONFIRMED**, at every $m\in\{5,6,7,8\}$, i.e. $n\in\{10,12,14,16\}$. *(For $m\ge9$ the even split is the better of the two; whether it is the infimum is open and neither this lemma nor this report settles it. The floor and the witness bracket it to a factor $\sqrt2$, which is all the order claim needs.)*

## 8. The traps, each answered

**$\ker W\ne0$, two readings, both answered.**
*(a) At $W^*$.* Its $\Lambda^2$ spectrum is $\{\frac m{2m-1},-\frac{m-1}{2m-1}\}$ (§6), both nonzero, so $\ker\hat W^*=0$ and this setting **never exercises the kernel**, exactly the blind spot the trap names. L146's own algebra does not need it; L145's analyticity of $W\mapsto W_-$ does, and inherits it silently. Recorded, no defect **in L146**.
*(b) At the object priced.* Every $H$ in one copy annihilates the whole of $\Lambda^2B_2$, so $\dim\ker\hat H\ge\binom m2=\Theta(n^2)$ for every $h\ne0$. **Nothing in L146 uses invertibility of $H$** ($\lVert H\rVert_{op}$ is a maximum of $\lvert\lambda\rvert$ over a diagonal spectrum) so this is a warning to downstream users rather than a defect. The joint object (5.1) is still singular on every plane where $h_a+k_b=0$.

**The smallest admissible dimension and every range boundary.** $m=2$: vacuous, $H\equiv0$. $m=3$: the boxed claim holds, $\alpha=\tfrac14$, $\beta=\tfrac34$, $\lVert H\rVert_F^2=\tfrac34\lVert h\rVert^2$, $\sup=\tfrac1{\sqrt2}$, checked directly at $h\propto(1,1,-2)/3$. $m=4$: holds. $m=5$: holds, and is the first $m$ where the margin genuinely sits here (§9). Odd $n$ is outside the statement, $n=2m$ forces $n$ even, and at $S^p\times S^q$ with $p\ne q$ the constants become $\alpha_{p,q}=\frac{p-2}{p+q-2}$, $\beta_{p,q}=\frac q{p+q-2}$ (from $\mathrm{Ric}(h\owedge g_q)=qh$), so the record's own unbalanced flagship $S^5\times S^7$ is **not** covered.

**A claim proven on a subfamily and cited in general.** §5, the headline finding: one copy priced, two copies cited.

**A hypothesis stated but never used, and a step using one never stated.** §1.3 and §1.2 respectively.

**A universal claim with no witness, one object from each structured family.**
- *Diagonal / sphere products*: $W^*=S^m\times S^m$ is the statement's own object; verified throughout.
- *Padded*: §7 below in C11, **and here the transported bound fails**.
- *$\mathbb{CP}^m$, tori, subalgebra-Casimir*: at none of these is there a summand of the form "Weyl image of $h\owedge g_q$ with $g_q$ a factor metric", so the lemma has **no content** there. A downstream citation in $n$-form would be applying it to an object it does not describe. No witness is owed; the scope note is.

**An imported result whose hypotheses were never checked against the object.** §1.4, I checked $\mathrm{Alt}=0$ and $s=0$ for the projector, and $p,q\ge3$, $(p,q)\ne(3,3)$ for L27. All hold.

### C11, the $n$-form of the constant does not transport off $n=2m$

*Locate.* Downstream writes $a_0=\sqrt{2n/(n-2)}$ and $\lVert H_s\rVert_{op}\le a_0n^{-1/2}=\sqrt{\frac2{n-2}}$, purely in $n$. The identity $\sqrt{\frac2{n-2}}=\frac1{\sqrt{m-1}}$ holds **only** at $n=2m$.

*Exhibit.* Pad to $\mathbb R^n=B_1\oplus B_2\oplus\mathbb R^p$, $n=2m+p$. Then $H=h\owedge g_q-\frac m{n-2}h\owedge g$ has $\alpha'=\frac{n-2-m}{n-2}$ on $B_1\!-\!B_2$ planes, $-\beta'(h_a+h_{a'})$ inside $B_1$ and $-\beta'h_a$ on $B_1\!-\!\mathbb R^p$ planes with $\beta'=\frac m{n-2}$, so $\lVert H\rVert_F^2=[\alpha'^2m+\beta'^2(m-2+p)]\lVert h\rVert^2$. Take $m=5$, $p=10$, $n=20$, $h=(4,-1,-1,-1,-1)$: $\alpha'=\tfrac{13}{18}$, $\beta'=\tfrac5{18}$, $\lVert h\rVert^2=20$, $M=4$, $c=3$. Then $\lVert H\rVert_{op}=\max(\tfrac{52}{18},\tfrac{15}{18})=\tfrac{26}9$ and $\lVert H\rVert_F^2=\frac{169\cdot5+25\cdot13}{324}\cdot20=\frac{650}9$, so

$$\frac{\lVert H\rVert_{op}}{\lVert H\rVert_F}=\frac{26/9}{5\sqrt{26}/3}=\frac{\sqrt{26}}{15}\ >\ \frac13=\sqrt{\tfrac2{n-2}},$$

since $3\sqrt{26}>15\iff26>25$. **The bound is violated, exactly.** Note the cross branch is the maximum here, so the in-block-wins clause fails off $n=2m$ too.

*Argue the opposite.* L146 states $n=2m$. It therefore claims nothing about padded objects and is not refuted. The finding is against the **$n$-form of the downstream constant**, which invites a transport the lemma does not license, and against any reading of the entry that treats $n$ as free.

## 9. C8 and C9, the range clause and the margin

From the record's spectrum, at $p=q=m$ the off-orbit competitors are $\lambda_m=\frac{m-2}{2(m-1)}$ (twice, multiplicity $s_m$ each) and $\pm\mu$ with $\mu=\frac{n-2}{2(m-1)^2}=\frac{2m-2}{2(m-1)^2}=\frac1{m-1}$. Then

$$\lambda_m>\mu\iff\frac{m-2}{2(m-1)}>\frac1{m-1}\iff m-2>2\iff m\ge5 .$$

**C8 CONFIRMED, and the boundary is exact**: at $m=4$, $\lambda_4=\mu=\tfrac13$, a **tie**, so the margin maximum is attained on this summand *and* on the $+\mu$ summand, and "puts the margin on this summand" is true only up to that tie; at $m=3$, $\lambda_3=\tfrac14<\mu=\tfrac12$ and the clause is false, as the entry's $m\ge5$ correctly excludes. $n\ge12$ means $m\ge6$, inside the range ✓.

**C9.** $\tfrac12-\lambda_m=\frac{(m-1)-(m-2)}{2(m-1)}=\frac1{2(m-1)}=\frac1{n-2}$, so $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$. **CONFIRMED.** The prefactor $3$ rather than $6$ is consistent with the record's own $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ read as a Taylor coefficient $\tfrac12\mathrm{Hess}$; no finding.

## 10. Withdrawn candidates

| candidate | why withdrawn |
|---|---|
| "$\lVert\cdot\rVert_F$ is undefined and the headline could be $\frac1{2\sqrt{m-1}}$" | the convention is pinned twice, by C3's identity and by the exact match of L145's $g_n$ (§6). Recoverable, hence a note, not a defect |
| "the projector is quoted as $\tfrac12(h\owedge g)$ but the input is unhalved" | $\lVert H\rVert_{op}/\lVert H\rVert_F$ is scale-invariant; nothing moves |
| "the two reviewers contradict each other on the lower bound" | they bound one infimum from opposite sides: $\frac1{m-1}$ is a proven floor, $\frac{\sqrt2}{\sqrt{(m-1)(m-2)}}$ an attained value. No contradiction to adjudicate |
| "$h_a$ presupposes a diagonal $h$, which is not a hypothesis" | free by the spectral theorem: $g_p,g_q$ are the identity on their blocks in every adapted orthonormal frame, so diagonalising $h$ costs nothing. Same for $(h,k)$ jointly |
| "$m\ge5$ is unused, so the boxed claim is over-restricted" | the clause is attached to the order-level conclusion, not to the boxed statement, and there it is exactly right. Reported in §1.3 as a scope note only |
| "the padded case refutes the lemma" | the lemma says $n=2m$. The refutation is of the transported $n$-form (C11), not of L146 |
| "L148 says the defect vanishes here, so the lemma is empty" | true of the *ten-summand infimum* use, and the entry says so itself; but $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}$ is still consumed downstream, so the lemma is live and worth checking |

## 11. What would falsify the statement, and what I did to look for it

- **For C4 (in-block always wins):** a traceless $h$ with $\frac m{m-2}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert<\max_a\lvert h_a\rvert$. I solved the extremal problem in closed form, the constraint $h_j\le c-M$ for all $j\ne a^*$ summed against $\mathop{\mathrm{tr}}h=0$ gives $c\ge\frac{m-2}{m-1}M$, tight at the spike, and no such $h$ exists at any $m$. **Not found; provably absent.**
- **For C5/C10 (the supremum $1/\sqrt{m-1}$):** an element of the **joint** eigenspace with $\lVert H\rVert_{op}>\lVert H\rVert_F/\sqrt{m-1}$. I computed the third branch exactly, $\sup=\frac{\sqrt{m-2}}m$, attained at $h\propto k\propto(m-1,-1,\dots,-1)$, and $(m-1)(m-2)<m^2$ closes it. **Not found; provably absent, but by a line L146 does not contain.**
- **For the equality clause read jointly:** found, in closed form, at $m=5$ with $h=k=(1,0,0,0,-1)$, and the whole family $h=k=(1,0,\dots,0,-1)$ falsifies it for every $m\ge5$.
- **For the transported $n$-form:** found, in closed form, at $m=5$, $p=10$, $n=20$, $h=(4,-1,-1,-1,-1)$: $\frac{\sqrt{26}}{15}>\frac13$.
- **Families searched:** sphere products (the statement's own object, and the source of the $\ker=0$ blind spot, checked and recorded), padded objects (falsifier found for the transported form), diagonal $h$ (the general case here, by the spectral theorem), the spike, the even and near-even splits, the single $\pm$ pair, and two-valued $h$ generally (where the even split is optimal *within* that family, which is why it was mistaken for the minimiser). $\mathbb{CP}^m$, tori and the subalgebra-Casimir family carry no summand of this shape, so they are out of scope rather than untested.

## Verdict

**PROVEN, hypotheses corrected.** Every displayed formula is exactly right on one $S^2_0(\mathbb R^m)$ copy at $n=2m$, and the supremum $1/\sqrt{m-1}$ is attained. The corrections owed to the statement: the honest range is $m\ge3$ (vacuous below), $n=2m$ is load-bearing and its $n$-form does not transport, $\lVert\cdot\rVert_F$ is the $\Lambda^2$-operator norm, and the equality clause is a one-copy statement that is **false on the joint two-copy eigenspace** the Setting names. That last is a **HYPOTHESIS-DEBT of L146**: what would have to be proved *here* is $\sup\lVert H_{\mathrm{tot}}\rVert_{op}=\frac1{\sqrt{m-1}}$ over $(h,k)$, whose missing ingredient is the cross-plane branch $\alpha(h_a+k_b)$ and its exact supremum $\frac{\sqrt{m-2}}m$.
