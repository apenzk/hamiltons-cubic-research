# VERIFY v19, L146: the Weyl image of $S^2_0(\mathbb R^m)$ at $S^m\times S^m$, its Frobenius identity, its operator-norm formula, the supremum $1/\sqrt{m-1}$, and the range $[\Theta(n^{-1}),\Theta(n^{-1/2})]$

**Cold brief.** Verifier v19 on [ROUND_L146.md](ROUND_L146.md), working from the provenance-stripped statement quoted there out of [second-order.md](../findings/second-order.md):1125–1152. Every embedding, every norm, every extremal problem below was rebuilt from the Kulkarni–Nomizu definition and the classical curvature decomposition before the record's own values were read. **No numerical work was done**: every value in this report is an exact hand evaluation in rationals or surds, and every witness is a closed-form vector with a stated arithmetic check. Log: [verify-L146-v19.log](../agent_logs/verify-L146-v19.log).

## Claim table

| # | claim, as written | verdict |
|---|---|---|
| 1 | the corrected embedding: Weyl image diagonal on coordinate 2-planes, $\alpha h_a$ on cross planes, $-\beta(h_a+h_{a'})$ inside $B_1$, $0$ inside $B_2$, with $\alpha=\frac{m-2}{2(m-1)}$, $\beta=\frac m{2(m-1)}$ | **CONFIRMED** |
| 2 | $\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ | **CONFIRMED** |
| 3 | $\lVert H\rVert_{op}=\frac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$, one $S^2_0$ copy | **CONFIRMED** |
| 4 | "the in-block branch always winning", one $S^2_0$ copy | **CONFIRMED** |
| 5 | the same two clauses read on the **joint two-copy** $\lambda_m$-eigenspace the Setting names | **REFUTED AS STATED**, exact witness at $n=12$, factor $\tfrac53$ |
| 6 | supremum $1/\sqrt{m-1}$, attained at the pair-concentrated $h$ | **CONFIRMED**, and sharp, attained, so not improvable |
| 7 | the supremum is still $1/\sqrt{m-1}$ on the joint two-copy eigenspace | **CONFIRMED AS ALGEBRA**, true, but no argument for it stands at L146 |
| 8 | "in order, $\lVert H\rVert_{op}$ ranges over $[\Theta(n^{-1}),\Theta(n^{-1/2})]$" | **CONFIRMED**, both endpoints, one copy and joint |
| 9 | "this holds for $m\ge5$, where $\lambda_m>\mu$" | **CONFIRMED**, and $m\ge5$ is the exact boundary: $\lambda_4=\mu_4=\tfrac13$ |
| 10 | the margin is exactly $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$ | **CONFIRMED AS ALGEBRA**, $\tfrac12-\lambda_m=\tfrac1{n-2}$ is exact; the factor $3\theta_0$ is imported unchecked |
| 11 | "the claimed minimiser (the even split) is wrong in either reading" | **REFUTED AS STATED**, true at $m=5,6,7$, and asymptotically the even split *is* the minimiser to within $1+O(1/m)$ |
| 12 | downstream: $\lVert H_s\rVert_{op}\le a_0n^{-1/2}$ with $a_0=\sqrt{2n/(n-2)}$ | **CONFIRMED**, $a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$ is claim 6 written in $n$ |

**One line the round can act on.** Every clause of the boxed lemma is correct algebra for a single $S^2_0(\mathbb R^m)$ copy, and the two constants downstream depends on are exact and sharp; the one defect is scope, the entry's Setting names the **two** $S^2_0$ summands, the lemma prices **one**, and on the joint eigenspace the operator-norm formula is false by a factor $\tfrac53$ at $n=12$ while the bound $1/\sqrt{m-1}$ nonetheless survives.

## 0. Conventions, fixed once

**The inner product.** [conventions.md](../findings/conventions.md):57–62 puts the $\tfrac12$ at the $\Lambda^2$ level, making $\{\varphi_{ab}\}_{a<b}$ orthonormal. So a curvature tensor is read here as a symmetric operator on $\Lambda^2\mathbb R^n$ in the orthonormal basis $\{e_i\wedge e_j\}_{i<j}$, $\lVert\cdot\rVert_F$ is that operator's Frobenius norm and $\lVert\cdot\rVert_{op}$ its largest eigenvalue in absolute value. **This is not assumed, it is forced**: the record's own displayed value $\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ comes out with coefficient exactly $1$ under this reading and exactly $4$ under the plain tensor pairing $\sum_{ijkl}H_{ijkl}^2$, so section 2 below independently pins the convention.

**Kulkarni–Nomizu.** $(A\owedge B)_{ijkl}=A_{ik}B_{jl}+A_{jl}B_{ik}-A_{il}B_{jk}-A_{jk}B_{il}$, matching the record's projector normalisation $\mathrm{KN}(h)=\tfrac12(h\owedge g)$ ([nondegeneracy.md](../findings/nondegeneracy.md):375). Two consequences used throughout, both derived here:

- **Ricci.** $\mathrm{Ric}(A\owedge B)=(\mathop{\mathrm{tr}}A)B+(\mathop{\mathrm{tr}}B)A-AB-BA$.
- **Simultaneous diagonality.** If $A=\mathop{\mathrm{diag}}(a_i)$ and $B=\mathop{\mathrm{diag}}(b_i)$ in one orthonormal frame, then $A\owedge B$ is diagonal in $\{e_i\wedge e_j\}_{i<j}$ with eigenvalue $a_ib_j+a_jb_i$ on $e_i\wedge e_j$, and every off-diagonal entry vanishes.

**The objects.** $V=\mathbb R^n=V_1\oplus V_2$ with $\dim V_1=\dim V_2=m$, $n=2m$; $B_1,B_2$ the two coordinate blocks; $g_1=P_{V_1}$, $g_2=P_{V_2}$, $g=g_1+g_2$. $h\in S^2_0(\mathbb R^m)$ is a traceless symmetric form on $V_1$, extended by zero, with eigenvalues $h_1,\dots,h_m$, $\sum_ah_a=0$. Write $M_1:=\max_a\lvert h_a\rvert$ and $M_2:=\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$.

## 1. Hypothesis inventory

**Carried by the boxed statement.**

| hypothesis | used? | checked against the object? |
|---|---|---|
| $H$ is the Weyl image of $h\in S^2_0(\mathbb R^m)$ | yes, everywhere | yes, section 2 constructs the map and confirms the eigenvalue list |
| $\lVert H\rVert_F=1$ | **only for claims 6 and 8** | the two displayed formulas are homogeneous of degree $1$ and $2$ in $h$ and do not need it; see withdrawn candidate W1 |
| $n=2m$ | yes, it is what makes the Weyl projector's $\frac1{n-2}$ equal $\frac1{2(m-1)}$ and so produces $\alpha,\beta$ | yes |

**Unstated hypotheses the written proof actually uses.**

- **$m\ge3$.** At $m=2$, $\alpha=0$ and $h=\mathop{\mathrm{diag}}(t,-t)$ gives $h_a+h_{a'}=0$, so $H\equiv0$: the hypothesis $\lVert H\rVert_F=1$ is unsatisfiable, the lemma is vacuous, and the "supremum $1/\sqrt{m-1}$" reads as $1$ over an empty set. Nothing in the boxed statement excludes it.
- **$h$ is a single traceless form on one factor**, so that $H$ lies in one of the two $S^2_0(\mathbb R^m)$ summands rather than in their sum. This is the load-bearing omission; section 5.
- **A frame diagonalising $h$ has been chosen.** Legitimate: $O(m)\times O(m)\subset O(n)$ preserves $g_1$, $g_2$ and $W^*$, and diagonalises any $h$ on $V_1$. Recorded because the eigenvalue list is stated frame-first.
- **$m\ge5$** for the *applicability* clause, not for the algebra. Correctly stated in the follow-up box; verified exactly in section 6.

**Imported results and their hypotheses.**

| import | hypotheses | checked against $W^*=S^m\times S^m$ |
|---|---|---|
| [Lemma L27](../findings/nondegeneracy.md), the $L_e$ spectrum at $S^p\times S^q$ | $p,q\ge3$, $(p,q)\ne(3,3)$, $n\ge5$ | $p=q=m\ge5$ satisfies all three; the spectrum list at [nondegeneracy.md](../findings/nondegeneracy.md):700 gives $\lambda_m$ at multiplicity $s_m=(m+2)(m-1)/2=\dim S^2_0(\mathbb R^m)$ **for each of $p$ and $q$**, so the $\lambda_m$-eigenspace is $2s_m$-dimensional, and this is precisely the fact section 5 turns on |
| the record's Weyl projector, $P(X)=Y-\frac2{n-2}\mathrm{KN}(\rho_0)-\frac1{n(n-1)}s\,\mathrm{KN}(g)$ | $X$ an algebraic curvature tensor | $h\owedge g_2$ satisfies the first Bianchi identity as a Kulkarni–Nomizu product of symmetric forms; its scalar curvature is $\mathop{\mathrm{tr}}(mh)=0$, so the third term drops and the projection is $H_0-\frac1{n-2}\mathring{\mathrm{Ric}}\owedge g$, used in section 2 |
| [Lemma L145](../findings/second-order.md)'s $c_p$ and $g_n=\frac2n\sqrt{\frac{n-2}{2(n-1)}}$ | the balanced product; $\theta_0(n)\uparrow\sqrt2$ | the arithmetic $\tfrac12-\lambda_m=\tfrac1{n-2}$ is verified exactly in section 6; the factor $3\theta_0$ is **not** checked here, it is a Hessian normalisation from L145 and the brief carries no derivation of it |

**Hypotheses stated but never used.** None. **No finding: every hypothesis printed in the boxed statement does work somewhere, and $\lVert H\rVert_F=1$ does work in exactly two of the four clauses.**

## 2. The embedding and the Frobenius identity, rebuilt

$g_q$ in "$\mathrm{Ric}(h\owedge g_q)=m\,h$" is the metric of the **complementary** factor. Taking $A=h$ (traceless, supported on $V_1$) and $B=g_2$ in the Ricci formula of section 0: $\mathop{\mathrm{tr}}h=0$, $\mathop{\mathrm{tr}}g_2=m$, and $hg_2=g_2h=0$ by disjoint support, so $\mathrm{Ric}(h\owedge g_2)=m\,h$. **The record's motivating identity is exact**, and it fixes $q$ as the other factor.

Scalar curvature $\mathop{\mathrm{tr}}(mh)=0$, so $\mathring{\mathrm{Ric}}=mh$ and the Weyl part is

$$H=h\owedge g_2-\frac{m}{n-2}\,h\owedge g=h\owedge\Big(\big(1-\tfrac m{2(m-1)}\big)g_2-\tfrac m{2(m-1)}g_1\Big)=h\owedge(\alpha g_2-\beta g_1),$$

with $1-\frac m{2(m-1)}=\frac{2m-2-m}{2(m-1)}=\frac{m-2}{2(m-1)}=\alpha$ and $\frac m{2(m-1)}=\beta$. **Both constants reproduce exactly.**

$h$ and $\alpha g_2-\beta g_1$ are diagonal in the same frame, so section 0's second consequence applies with $a=(h_1,\dots,h_m,0,\dots,0)$ and $b=(-\beta,\dots,-\beta,\alpha,\dots,\alpha)$, giving eigenvalue $a_ib_j+a_jb_i$:

- $a,a'\in B_1$: $-\beta(h_a+h_{a'})$;
- $a\in B_1$, $b\in B_2$: $\alpha h_a$;
- $b,b'\in B_2$: $0$.

**Claim 1 CONFIRMED**, exactly as printed, including the sign. The record's diagnosis of the earlier version is also confirmed: dropping the projection term leaves $b=(0,\dots,0,1,\dots,1)$, whose eigenvalues are $h_a$ on the cross planes and $0$ in **both** blocks, which is what the entry says the first version had.

**The Frobenius identity.** Summing squares over the orthonormal basis $\{e_i\wedge e_j\}_{i<j}$,

$$\lVert H\rVert_F^2=\beta^2\!\!\sum_{a<a'\in B_1}\!\!(h_a+h_{a'})^2+\alpha^2\!\!\sum_{a\in B_1,\,b\in B_2}\!\!h_a^2 .$$

The second sum is $m\alpha^2\lVert h\rVert^2$. For the first, $\sum_{a,a'}(h_a+h_{a'})^2=2m\lVert h\rVert^2+2(\sum_ah_a)^2=2m\lVert h\rVert^2$ by tracelessness, and removing the $m$ diagonal terms $(2h_a)^2$ leaves $\sum_{a\ne a'}=2m\lVert h\rVert^2-4\lVert h\rVert^2$, so

$$\sum_{a<a'}(h_a+h_{a'})^2=(m-2)\lVert h\rVert^2 .$$

Hence

$$\lVert H\rVert_F^2=\Big[\tfrac{m^2(m-2)}{4(m-1)^2}+\tfrac{m(m-2)^2}{4(m-1)^2}\Big]\lVert h\rVert^2=\frac{m(m-2)\cdot 2(m-1)}{4(m-1)^2}\lVert h\rVert^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2 .$$

**Claim 2 CONFIRMED exactly**, with no convention factor left over, which is what pins section 0's reading of $\lVert\cdot\rVert_F$.

## 3. The operator norm on one copy: the in-block branch does always win

$H$ is diagonal, so $\lVert H\rVert_{op}=\max\big(\beta M_2,\ \alpha M_1\big)$. The claim is that the first term always dominates.

**Proof.** Both $M_1$ and $M_2$ are invariant under $h\mapsto-h$, so take $h_{a^*}=M_1>0$. Tracelessness gives $\sum_{a\ne a^*}h_a=-M_1$ over $m-1$ entries, so some $a'\ne a^*$ has $h_{a'}\ge-\frac{M_1}{m-1}$, whence

$$M_2\ \ge\ h_{a^*}+h_{a'}\ \ge\ M_1\Big(1-\tfrac1{m-1}\Big)=\frac{m-2}{m-1}M_1 .$$

Therefore $\beta M_2\ge\frac{m}{2(m-1)}\cdot\frac{m-2}{m-1}M_1=\frac m{m-1}\cdot\alpha M_1\ge\alpha M_1$, since $\frac m{m-1}>1$. $\square$

**Claims 3 and 4 CONFIRMED for one copy**, at every $m\ge3$, the argument uses nothing beyond tracelessness, so it does not need $m\ge5$.

## 4. The supremum, and both ends of the range

**Scale-free reduction.** By sections 2 and 3,

$$\frac{\lVert H\rVert_{op}}{\lVert H\rVert_F}=\frac{\beta}{\sqrt{m(m-2)/(2(m-1))}}\cdot\frac{M_2}{\lVert h\rVert}=\sqrt{\frac{m}{2(m-1)(m-2)}}\cdot\frac{M_2}{\lVert h\rVert},$$

so both endpoints reduce to extremising $M_2/\lVert h\rVert$ over the traceless $h\ne0$.

**Upper end.** For a fixed pair, minimising $\lVert h\rVert$ at $h_1+h_2=s$ puts $h_1=h_2=s/2$ and spreads $-s$ evenly over the remaining $m-2$ entries: $\lVert h\rVert^2=\frac{s^2}2+\frac{s^2}{m-2}=\frac{m\,s^2}{2(m-2)}$. So $\frac{\lvert h_a+h_{a'}\rvert}{\lVert h\rVert}\le\sqrt{\frac{2(m-2)}m}$ for **every** pair, hence for the maximising one, with equality attained. Then

$$\max\frac{\lVert H\rVert_{op}}{\lVert H\rVert_F}=\sqrt{\frac{m}{2(m-1)(m-2)}\cdot\frac{2(m-2)}m}=\frac1{\sqrt{m-1}} .$$

**The maximiser in closed form**, which is what "pair-concentrated" means: $h^\star=\big(1,1,-\tfrac2{m-2},\dots,-\tfrac2{m-2}\big)$. Trace $2-(m-2)\tfrac2{m-2}=0$; the three pair sums are $2$, $1-\tfrac2{m-2}$ and $-\tfrac4{m-2}$, and for $m\ge5$ both of the latter are below $2$ in absolute value, so $M_2=2$; $\lVert h^\star\rVert^2=2+\tfrac4{m-2}=\tfrac{2m}{m-2}$, giving $M_2/\lVert h^\star\rVert=\sqrt{2(m-2)/m}$. **Claim 6 CONFIRMED, attained, hence sharp.** At $n=12$ this is $1/\sqrt5=0.4472135\ldots$

**Lower end.** Sort $h_1\ge\cdots\ge h_m$ and set $c=M_2$. From $2h_2\le h_1+h_2\le c$ we get $h_2\le c/2$, so $h_a\le c/2$ for every $a\ge2$; symmetrically $h_{m-1}\ge-c/2$ gives $h_a\ge-c/2$ for every $a\le m-1$. **So all but the two extreme entries lie in $[-c/2,c/2]$.** For the extremes, every $h_a$ with $a\ge2$ satisfies $h_a\le c-h_1$, so $0=\sum_ah_a\le h_1+(m-1)(c-h_1)$ gives $h_1\le\frac{(m-1)c}{m-2}$, and symmetrically for $h_m$. Hence

$$\lVert h\rVert^2\ \le\ h_1^2+h_m^2+(m-2)\frac{c^2}4\ \le\ c^2\Big[\frac{2(m-1)^2}{(m-2)^2}+\frac{m-2}4\Big]\ <\ c^2\,\frac{m+15}4\quad(m\ge5),$$

using $\big(\tfrac{m-1}{m-2}\big)^2\le\tfrac{16}9$ at $m\ge5$. So $M_2/\lVert h\rVert>\frac2{\sqrt{m+15}}$ and

$$\min\frac{\lVert H\rVert_{op}}{\lVert H\rVert_F}\ >\ \sqrt{\frac{m}{2(m-1)(m-2)}}\cdot\frac2{\sqrt{m+15}}\ =\ \Theta(m^{-1})=\Theta(n^{-1}).$$

Matching from above: the even split ($m$ even, half the entries $+t$, half $-t$) has $M_2=2t$, $\lVert h\rVert=t\sqrt m$, giving $\lVert H\rVert_{op}=\sqrt{\frac2{(m-1)(m-2)}}$; for odd $m$ the same construction with one zero entry gives $2/\sqrt{m-1}$ and the same order. **Claim 8 CONFIRMED at both endpoints.**

**A by-product for the recorded r448/r449 split.** The two bounds above are $\frac2{\sqrt{m+15}}$ and $\frac2{\sqrt m}$, which agree to $1+O(1/m)$. So $\min\lVert H\rVert_{op}=\frac{\sqrt2}m\big(1+O(1/m)\big)$: r449's $\approx\sqrt2/m$ is asymptotically exact and r448's $1/(m-1)$ lies **below** the true minimum for large $m$. Both are $\Theta(n^{-1})$, so the boxed claim is untouched; recorded because the entry leaves the split open.

## 5. The finding: one copy priced, two copies named

**Locate it.** The Setting reads "[Lemma L27](../findings/nondegeneracy.md) puts the off-orbit margin maximum on the **two** $S^2_0(\mathbb R^m)$ summands … *So the margin is constant across the summand and only $\lVert H\rVert_{op}$ varies over it*", and the boxed lemma then quantifies over a single "$h\in S^2_0(\mathbb R^m)$". The $\lambda_m$-eigenspace of $L_e$ has dimension $2s_m$, not $s_m$ ([nondegeneracy.md](../findings/nondegeneracy.md):700), so a general unit vector of the space the Setting names is a **pair** $(h,k)$ with $h$ on $V_1$ and $k$ on $V_2$. The statement carries no hypothesis excluding it, and downstream ([second-order.md](../findings/second-order.md):1189–1193) it is applied to exactly that joint space.

**Exhibit the failure.** Let $H=W(h\owedge g_2)+W(k\owedge g_1)$. Both summands are diagonal in $\{e_i\wedge e_j\}$, so the eigenvalues of $H$ are

$$-\beta(h_a+h_{a'})\ \text{ on }B_1\text{-planes};\qquad -\beta(k_b+k_{b'})\ \text{ on }B_2\text{-planes};\qquad \alpha\,(h_a+k_b)\ \text{ on cross planes},$$

and the two images are orthogonal, their only common support being the cross planes where the inner product is $\alpha^2(\sum_ah_a)(\sum_bk_b)=0$. **A cross-plane branch now appears that no single-copy $h$ can produce**, and it is not dominated: take $m=6$, $n=12$, and

$$h=k=\big(1,-\tfrac15,-\tfrac15,-\tfrac15,-\tfrac15,-\tfrac15\big),$$

traceless since $1-5\cdot\tfrac15=0$. Here $\alpha=\tfrac25$, $\beta=\tfrac35$, $M_2(h)=\max\big(1-\tfrac15,\ \tfrac25\big)=\tfrac45$, so the lemma's formula returns $\beta M_2=\tfrac35\cdot\tfrac45=\tfrac{12}{25}$; the true operator norm is the cross branch $\alpha\max_{a,b}\lvert h_a+k_b\rvert=\tfrac25\cdot2=\tfrac45$. **The written formula understates $\lVert H\rVert_{op}$ by the factor $\tfrac{4/5}{12/25}=\tfrac53$ at the very dimension the chain uses**, and "the in-block branch always winning" is false there. In general the ratio is $\frac{\alpha\cdot2}{\beta\cdot\frac{m-2}{m-1}}=\frac{2(m-1)}m>1$ at every $m\ge3$.

**Argue the opposite.** The most charitable reading is that the boxed lemma quantifies over one traceless $h$ and therefore never claims anything about pairs, the two copies being carried into one another by the factor swap, so pricing one is pricing "the summand" in the sense of an isometry class. Under that reading claims 3 and 4 are correct as written and the defect is scope, not algebra. **That is the reading I adopt**, which is why claims 3 and 4 stand CONFIRMED and only their extension is REFUTED AS STATED. What the entry owes is one sentence naming which of the two spaces is priced.

**Does the extension survive?** Yes, and I checked it because the brief asks. The supremum of a maximum over branches is the maximum of the branch suprema, so the joint supremum is $\max$ of: the in-block value $1/\sqrt{m-1}$ (attained at $k=0$), and the cross-plane value. For the latter, $\max_ah_a\le\lVert h\rVert\sqrt{(m-1)/m}$ for traceless $h$ (Cauchy–Schwarz against $e_1-\tfrac1m\mathbf1$), so under $\lVert h\rVert^2+\lVert k\rVert^2=1$,

$$\alpha\max_{a,b}(h_a+k_b)\le\alpha\sqrt2\sqrt{\tfrac{m-1}m},\qquad\text{giving}\qquad \frac{\lVert H\rVert_{op}}{\lVert H\rVert_F}\le\alpha\cdot\frac{2(m-1)}{m\sqrt{m-2}}=\frac{\sqrt{m-2}}m .$$

And $\frac{\sqrt{m-2}}m<\frac1{\sqrt{m-1}}$, since $(m-2)(m-1)=m^2-3m+2<m^2$. **So the joint supremum is still exactly $1/\sqrt{m-1}$**, at $n=12$, $\tfrac13$ against $0.4472\ldots$, and the lower end survives too: with $\lVert h\rVert\ge\lVert k\rVert$ one has $\lVert h\rVert^2\ge\tfrac12\lVert H\rVert_F^2/C$, so the in-block branch alone gives $\ge\tfrac1{\sqrt2}$ times the single-copy minimum, still $\Theta(n^{-1})$. **Claim 7 CONFIRMED as algebra, but nothing at [second-order.md](../findings/second-order.md):1125–1152 argues it**, and by the rule that a claim with no argument on file is a debt, that is what this is.

## 6. The range boundaries, the edges, and the named traps

**The smallest admissible dimension.** The algebra of claims 1–4 needs $m\ge3$; at $m=2$ the lemma is vacuous (section 1). The applicability clause needs $\lambda_m>\mu$. At the balanced point $\mu=\frac{n-2}{2(p-1)(q-1)}=\frac{2m-2}{2(m-1)^2}=\frac1{m-1}$, so

$$\lambda_m>\mu\iff\frac{m-2}{2(m-1)}>\frac1{m-1}\iff m-2>2\iff m\ge5 .$$

**Claim 9 CONFIRMED and the boundary is exact and tight**: at $m=4$, $\lambda_4=\mu=\tfrac13$, an equality, so the margin maximum is *shared* with the $+\mu$ summand and the Setting's "puts the maximum on the two $S^2_0$ summands" fails; at $m=3$, $\lambda_3=\tfrac14<\mu=\tfrac12$ and it fails outright. The entry's "$n\ge12$ is inside that" is true but weaker than what it proved: $n=10$ is admissible too.

**Odd $n$.** $n=2m$ is even by construction, so the lemma says nothing at odd $n$ and claims nothing there. **No finding, but a scope note**: any downstream statement wanting this operator-norm input at odd $n$ gets nothing from L146, and the record's own $\theta_0$ / $\Theta_n$ parity split ([INDEX-results.md](../findings/INDEX-results.md):15) shows odd $n$ is not cosmetic in this programme.

**$\ker W\ne0$.** The lemma is a tangent-space statement at $W^*=S^m\times S^m$, whose spectrum L145 records as two-valued with no kernel, so the padded objects the trap names are outside its scope and it makes no claim at them, **the honest answer is scope, not error.** Two things are worth recording anyway. First, $H$ itself is massively degenerate: it annihilates all $\binom m2$ planes inside $B_2$, so $\dim\ker H\ge\binom m2=\Theta(n^2)$, and any downstream step wanting $H$ non-degenerate does not have it. Second, this is *not* a defect of the analyticity disc $g_n/\lVert H\rVert_{op}$, which turns on the spectrum of $W^*+tH$ and the gap $g_n$ of $W^*$, not on $\ker H$; see withdrawn candidate W3.

**A subfamily claim cited in general.** The entry itself says so in its final box: L148 puts the defect identically at zero on this summand, and "the question lives on the mixed directions". Confirmed as a scope statement: the lemma prices one of [Lemma L27](../findings/nondegeneracy.md)'s ten summands and gives nothing on the other nine or on any mixed direction.

**A universal claim with no witness, one object from each named family.** The lemma's universal is "the in-block branch always winning", quantified over $h\in S^2_0(\mathbb R^m)$; I tested it at a diagonal $h$ (every $h$ here is diagonal after the frame choice, the family is exhausted), at the pair-concentrated maximiser $h^\star$ ($\beta M_2=\frac m{m-1}$ against $\alpha M_1=\frac{m-2}{2(m-1)}$, in-block wins by $\frac{2m}{m-2}$), at the one-big vector $\big(1,-\tfrac1{m-1},\dots\big)$ (the extremal case of section 3's inequality, in-block wins by exactly $\frac m{m-1}$), and at the even split (in-block wins outright, the cross branch being $\alpha\cdot\tfrac12$ against $\beta\cdot1$). **No witness against it exists on one copy, section 3 proves it.** The other families the brief names, padded, subalgebra-Casimir, sphere products other than the balanced one, $\mathbb{CP}^m$, tori, are not in the domain of this lemma at all, since $h$ ranges over a fixed representation at one fixed point; testing there would be testing a different statement.

**The margin identity.** $\tfrac12-\lambda_m=\tfrac12-\tfrac{m-2}{2(m-1)}=\tfrac{(m-1)-(m-2)}{2(m-1)}=\tfrac1{2(m-1)}=\tfrac1{n-2}$, so $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$ exactly, and with $\theta_0(n)\uparrow\sqrt2$ this is $\Theta(1/n)$, matching the record's $c_p=\Theta(1/n)$. **Claim 10 CONFIRMED as algebra**; the factor $3\theta_0$ is an unchecked import from L145's Hessian normalisation and this report does not certify it.

## 7. The two downstream uses, answered directly

**(a) $\lVert H_s\rVert_{op}\le a_0n^{-1/2}$ with $a_0=\sqrt{2n/(n-2)}$.** $a_0n^{-1/2}=\sqrt{\frac{2n}{(n-2)n}}=\sqrt{\frac2{n-2}}=\frac1{\sqrt{m-1}}$ at $n=2m$. **The written statement gives exactly this, and gives it sharply**, the supremum is attained at $h^\star$, so no smaller constant is available and none is needed. At $n=12$: $a_0=\sqrt{12/5}$, $a_0/\sqrt{12}=1/\sqrt5$.

**(b) The joint two-copy eigenspace.** **The written statement gives less.** It prices one $S^2_0(\mathbb R^m)$ copy; the eigenspace it is applied to is the sum of two, on which its operator-norm formula is false by $\tfrac53$ at $n=12$ (section 5). The bound itself survives with the same constant, because the cross-plane branch tops out at $\sqrt{m-2}/m<1/\sqrt{m-1}$, but that is a computation this verifier did, not one the lemma contains, and the correct downstream reading is that no $\sqrt2$ is owed for the second copy *and that the reason must be written down*.

## 8. Withdrawn candidates

**W1, "the hypothesis $\lVert H\rVert_F=1$ contradicts the displayed identity $\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2$."** *Withdrawn.* The two are consistent: the hypothesis fixes the normalisation $\lVert h\rVert^2=\frac{2(m-1)}{m(m-2)}$, and the displayed identity is what converts it. The awkwardness is presentational only, and the operator-norm formula is homogeneous so it holds at any scale.

**W2, "the cross-plane eigenvalue $\alpha$ equals $\lambda_m$, which suggests the two were conflated."** *Withdrawn.* Both equal $\frac{m-2}{2(m-1)}$, but for independent reasons: $\alpha=1-\frac m{n-2}$ comes from the Weyl projection in dimension $n=2m$, while $\lambda_m$ is the $L_e$ eigenvalue from [Lemma L27](../findings/nondegeneracy.md). It is a genuine coincidence at the balanced point and no step of the proof uses one where it means the other. Recorded so the next reader does not re-spend on it.

**W3, "$H$ annihilates $\Lambda^2V_2$, so the analyticity disc $g_n/\lVert H\rVert_{op}$ is not what it claims."** *Withdrawn.* The disc is a statement about the spectral gap of $W^*+tH$ separating $\lambda_\pm$; a large $\ker H$ means the perturbation does nothing on part of $\Lambda^2$, which can only help the gap, never hurt it. There is no failure to exhibit.

**W4, "the even split is the minimiser, so the entry's parenthetical is wrong."** *Partly upheld, and reported as claim 11 rather than withdrawn.* The entry says flatly that the even split is not the minimiser. **At $m=5,6,7$ that is right**, by exact witness: the one-big vector $\big(\tfrac{m-1}{m-2},-\tfrac1{m-2},\dots,-\tfrac1{m-2}\big)$ has $M_2=1$ and $\lVert h\rVert^2=\frac{m(m-1)}{(m-2)^2}$, which exceeds the even split's $m/4$ exactly when $m^2-8m+8<0$, i.e. $m\le6$, and at odd $m=5,7$ the even split does not exist, its best surrogate reaching only $(m-1)/4$, which $\tfrac{20}9$ and $\tfrac{42}{25}$ both beat. **For $m\ge8$ the entry's claim is not established and points the wrong way**: section 4's two-sided bound $\frac2{\sqrt{m+15}}<\min M_2/\lVert h\rVert\le\frac2{\sqrt m}$ makes the even split optimal to within $1+O(1/m)$. The blanket phrasing therefore over-reaches. Severity is low, the minimiser is commentary, and the boxed claim asserts only $\Theta(n^{-1})$, which section 4 confirms.

## 9. What would break it

**The object that would falsify the boxed lemma** is a traceless $h\in S^2_0(\mathbb R^m)$, $m\ge3$, whose Weyl image has $\alpha M_1>\beta M_2$, a vector concentrated enough in one entry that the cross-plane branch overtakes the in-block one. **No such object exists**, and section 3 proves why: tracelessness forces some second entry above $-M_1/(m-1)$, which floors $M_2$ at $\frac{m-2}{m-1}M_1$, and $\beta/\alpha=\frac m{m-2}$ is more than enough to cover that. I looked for it at the pair-concentrated maximiser, the one-big vector that makes section 3's inequality an equality, and the even split; the inequality is strict at all three and its proof leaves no gap.

**The object that falsifies the lemma as the Setting scopes it** does exist and is exhibited in section 5: the pair $h=k=(1,-\tfrac15,\dots,-\tfrac15)$ at $n=12$, on which the printed formula is short by $\tfrac53$. I looked for it by asking what the $\lambda_m$-eigenspace actually is, $2s_m$-dimensional by [Lemma L27](../findings/nondegeneracy.md)'s multiplicity list, and then computing the eigenvalue list of a general element of it, which is where the third, cross-plane branch appears.

**The object that would falsify the downstream constant** would be a unit vector of the joint eigenspace with $\lVert H\rVert_{op}>1/\sqrt{m-1}$. **None exists**: section 5 bounds every branch, the cross one by $\sqrt{m-2}/m$ and the two in-block ones by $1/\sqrt{m-1}$.

## Verdict

**PROVEN, hypotheses corrected.**

Every clause of the boxed statement is correct algebra once two unwritten hypotheses are added: **$m\ge3$** (below which the lemma is vacuous, its hypothesis $\lVert H\rVert_F=1$ being unsatisfiable), and **"$h$ a single traceless form, so that $H$ lies in one $S^2_0(\mathbb R^m)$ copy"** (without which the operator-norm formula and "the in-block branch always winning" are both false, by the exact $n=12$ witness of section 5). The supremum $1/\sqrt{m-1}$ is exact, attained, and identical to the downstream $a_0n^{-1/2}$; the range $[\Theta(n^{-1}),\Theta(n^{-1/2})]$ holds at both endpoints; and $m\ge5$ is the exact boundary of the applicability clause. The one thing the entry owes as an argument, rather than as a correction, is why the second copy costs nothing on the joint eigenspace, true, by the cross-plane bound $\sqrt{m-2}/m<1/\sqrt{m-1}$, and absent from L146.
