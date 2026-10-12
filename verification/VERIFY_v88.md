# VERIFY v88, L146's operator-norm identity, its supremum $1/\sqrt{m-1}$, and whether the citable box reaches its three consumers

*Cold brief, [ROUND_L146r2](ROUND_L146r2.md), source [findings/second-order.md](../findings/second-order.md):1131–1162. **No numerical work was done**: no script was run, and every value below is an exact hand evaluation from closed forms. Log: [agent_logs/verify-L146r2-v88.log](../agent_logs/verify-L146r2-v88.log).*

## Verdicts

| # | Claim, as the entry writes it | Verdict |
|---|---|---|
| C1 | $\alpha=\tfrac{m-2}{2(m-1)}$, $\beta=\tfrac m{2(m-1)}$, and the three-branch eigenvalue list | **CONFIRMED**, rederived from the record's own projector |
| C2 | $\mathrm{Ric}(h\owedge g_q)=m\,h\ne0$, so the projection term survives | **CONFIRMED** |
| C3 | $\lVert H\rVert_F^2=\tfrac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ | **CONFIRMED**, exact |
| C4 | $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\ge\tfrac{m-2}{m-1}\max_a\lvert h_a\rvert$, and $\beta/\alpha=\tfrac m{m-2}$ covers it | **CONFIRMED**, with room factor exactly $\tfrac m{m-1}$ |
| C5 | $\lVert H\rVert_{op}=\tfrac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$, the in-block branch always winning | **CONFIRMED** for every $m\ge3$ |
| C6 | supremum $1/\sqrt{m-1}$, attained at the pair-concentrated $h$ | **CONFIRMED**, and it is a **maximum**; the attaining direction is **admissible** |
| C7 | the cross branch caps at $\sqrt{m-2}/m<1/\sqrt{m-1}$, so the joint supremum is unchanged | **CONFIRMED**, the cap exact and attained, **but asserted with no derivation anywhere on the record** |
| C8 | the $m=5$ and $m=6$ witnesses $\tfrac34$ vs $\tfrac58$ and $\tfrac45$ vs $\tfrac{12}{25}$ | **CONFIRMED**, all four exact |
| C9 | $\lVert H\rVert_{op}$ ranges over $[\Theta(n^{-1}),\Theta(n^{-1/2})]$ | **CONFIRMED**; $1/(m-1)$ is the exact Cauchy–Schwarz floor |
| C10 | "$1/(m-1)$ a proven floor and $\approx\sqrt2/m$ an attained value, so they bracket" | **FALSE at $m=3$**, inside the box's own range |
| C11 | "the even split is beaten only up to $m=6$", the spike winning iff $m^2-8m+8<0$ | **the quadratic is exact; the headline is FALSE at $m=7$** |
| C12 | "sharp at the spike" for C4 | **FALSE at $m=3$**; true at every $m\ge4$ |
| C13 | the box's scope ("a **single** $h$"), against L149's use on the joint two-copy eigenspace | **GAP**: the extension is true, argued beside the box, never inside it |
| C14 | Setting: "[L27] puts the off-orbit margin **maximum** on the two $S^2_0$ summands" | **INVERTED**, the summand carries the margin **minimum** |
| C15 | "the analyticity disc $g_n/\lVert H\rVert_{op}$" | **$\gamma=1$, which [L156](../findings/second-order.md) excludes**; order survives, radius does not |
| C16 | a canonical L146 in [results.md](../results.md) | **ABSENT, and the absence is not correct** |

**One line.** Every identity, the supremum, the floor and all eight numerals in the entry reproduce exactly by hand, and the supremum is attained at a direction the consumers legitimately quantify over, but the citable box prices **one** copy where its principal consumer applies it to **two**, names no map for the words "Weyl image", states no $\ker W^*=0$, and is surrounded by two prose clauses that are false at $m=3$ and $m=7$; verdict **GAP**.

## 0. Conventions, fixed once

$n=2m$; $\mathbb R^n=V_1\oplus V_2$ with index blocks $B_1,B_2$ of size $m$; $g_p,g_q$ the metrics of $V_1,V_2$ and $g=g_p+g_q$; $h\in S^2_0(\mathbb R^m)$ acting on $V_1$, diagonal with entries $h_a$ in a frame chosen after $h$.

Kulkarni–Nomizu $(h\owedge k)_{ijkl}=h_{ik}k_{jl}+h_{jl}k_{ik}-h_{il}k_{jk}-h_{jk}k_{il}$. A curvature tensor is read as a symmetric operator on $\Lambda^2\mathbb R^n$ with $\{e_i\wedge e_j\}_{i<j}$ orthonormal, so $\langle\mathcal R(e_i\wedge e_j),e_k\wedge e_l\rangle=R_{ijkl}$; $\lVert\cdot\rVert_F$ and $\lVert\cdot\rVert_{op}$ are that operator's norms, which is the convention under which the entry's $\lVert H\rVert_F^2$ comes out as written and the only one under which it does.

$\mathrm{Ric}(R)_{jl}=\sum_iR_{ijil}$. The record's projector is [nondegeneracy.md](../findings/nondegeneracy.md):375: $P(X)=Y-\tfrac2{n-2}\mathrm{KN}(\rho_0)-\tfrac{s}{n(n-1)}\mathrm{KN}(g)$ with $Y=X-\mathrm{Alt}(X)$ and $\mathrm{KN}(h)=\tfrac12(h\owedge g)$.

$\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$; $c_p=3\theta_0/(n-2)$; $g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$; $\mu=1/(m-1)$ and $\lambda_m=(m-2)/(2(m-1))$ at the balanced product ([Lemma L27](../findings/nondegeneracy.md)).

## 1. The hypothesis inventory

**Carried by the box itself.** $n=2m$; $m\ge3$; $h\in S^2_0(\mathbb R^m)$, i.e. symmetric and **traceless**; $H$ "the Weyl image" of that $h$; $H$ is the image of a **single** $h$; $\lVert H\rVert_F=1$.

**Used by the written proof and *not* carried by the box.**

1. **The embedding.** $H=W\text{-projection of }h\owedge g_q$. The box says "the Weyl image of $h$" and names no map; the map is defined only in the box above it. Without it the two displayed identities have no referent.
2. **The frame is chosen after $h$.** Diagonality of $H$ on coordinate $2$-planes holds in the frame diagonalising $h$, not in a fixed one. [Lemma L148](../findings/second-order.md) writes this hypothesis into its own statement and exhibits the failure in a fixed frame ($h_{12}=1$ giving $H_{1424}\ne0$); L146 states it nowhere.
3. **$\mathrm{tr}\,h=0$** is used twice and load-bearing both times, in $\mathrm{Ric}(h\owedge g_q)=m\,h$ (through $\mathrm{tr}\,h=0$ killing the $(\mathrm{tr}\,h)g_q$ term and $s=0$ killing the scalar term) and in C4. It **is** in the box, through "$h\in S^2_0$".
4. **$\ker W^*=0$**, equivalently $g_n>0$, for the "ORDER-LEVEL CONCLUSION" box's analyticity-disc claim. Stated in [L147](../findings/second-order.md):1179 and in L149's hypothesis box, with $W_{\mathbb{CP}^2}$ ($\dim\ker W=3$) the named witness; absent here.
5. **$m\ge5$** for the word "margin" in the entry's own title and Setting. The box says $m\ge3$.

**Imported results and their hypotheses, checked against the object.**

- **[Lemma L27](../findings/nondegeneracy.md)**, the $L_e$ spectrum at $S^p\times S^q$: eigenvalues $\pm\mu$, $\lambda_m$ at multiplicity $s_m=(m+2)(m-1)/2$ for $m=p,q$, $\tfrac12$ at multiplicity $pq$, $1$ simple, every other eigenvalue strictly below $\tfrac12$. Applied at $p=q=m$, which is in range. **Two checks the entry does not make and which pass**: $\dim S^2_0(\mathbb R^m)=\tfrac{m(m+1)}2-1=\tfrac{(m+2)(m-1)}2=s_m$, so $h\mapsto H$ is a linear injection **onto** the whole $\lambda_m$-summand and the box's parametrisation loses nothing; and $\lambda_m\notin\{\tfrac12,1\}$, which is what makes §5's admissibility work.
- **The record's Weyl projector**, [nondegeneracy.md](../findings/nondegeneracy.md):375. Its hypotheses are that $X$ be an algebraic curvature tensor. $h\owedge g_q$ is a Kulkarni–Nomizu product of symmetric $2$-tensors, hence satisfies the first Bianchi identity, hence $\mathrm{Alt}(h\owedge g_q)=0$ and $Y=X$. Checked.
- **[Lemma L145](../findings/second-order.md)** for $g_n$ and for the identification of the summand margin with $c_p$. L145's own audit found it false at $m=2,3$; L146 inherits that only through its Setting sentence, not through the box.

**No finding on one point worth stating positively**: the proof uses no hypothesis on $h$ beyond symmetry and tracelessness, and both are in the box.

## 2. The embedding and the eigenvalue list, C1, C2

$h$ is supported on $B_1$ and $g_q$ on $B_2$, so $hg_q=0$ and $\mathrm{tr}\,h=0$, whence
$$\mathrm{Ric}(h\owedge g_q)=(\mathrm{tr}\,h)g_q+(\mathrm{tr}\,g_q)h-2(hg_q)_{\mathrm{sym}}=m\,h .$$
So $\rho_0=mh$ and $s=\mathrm{tr}(mh)=0$. **C2 confirmed.**

Against the record's projector, with $\mathrm{KN}(h)=\tfrac12(h\owedge g)$ and $s=0$,
$$\tfrac2{n-2}\mathrm{KN}(mh)=\tfrac2{2m-2}\cdot\tfrac12(mh\owedge g)=\tfrac m{2(m-1)}\,h\owedge g=\beta\,h\owedge g,$$
so
$$H=h\owedge g_q-\beta\,(h\owedge g_p+h\owedge g_q)=(1-\beta)\,h\owedge g_q-\beta\,h\owedge g_p,\qquad 1-\beta=\tfrac{2(m-1)-m}{2(m-1)}=\tfrac{m-2}{2(m-1)}=\alpha .$$
**C1's two constants confirmed against the record's own projector, not against a textbook one.**

With $h,g_p,g_q$ all diagonal, $(h\owedge k)_{ijkl}$ is nonzero only when $\{i,j\}=\{k,l\}$, so $H$ is diagonal on coordinate $2$-planes. Its sectional entries $(h\owedge k)_{ijij}=h_{ii}k_{jj}+h_{jj}k_{ii}-2h_{ij}k_{ij}$ give

| plane | $h\owedge g_q$ | $h\owedge g_p$ | $H$ |
|---|---|---|---|
| $e_a\wedge e_b$, $a\in B_1$, $b\in B_2$ | $h_a$ | $0$ | $\alpha h_a$ |
| $e_a\wedge e_{a'}$, $a,a'\in B_1$ | $0$ | $h_a+h_{a'}$ | $-\beta(h_a+h_{a'})$ |
| inside $B_2$ | $0$ | $0$ | $0$ |

**C1 confirmed in full**, and the entry's diagnosis of its own earlier error is right: dropping the $-\beta\,h\owedge g_p$ term is exactly $h\owedge g_q$, whose in-block planes are zero.

## 3. The two displayed identities, C3, C4, C5

**Frobenius.** Cross planes contribute $\alpha^2m\lVert h\rVert^2$ ($m^2$ planes, $m$ per value of $a$). For the in-block planes, tracelessness gives
$$\sum_{a<a'}(h_a+h_{a'})^2=\tfrac12\Big[2(m-1)\lVert h\rVert^2+2\big((\textstyle\sum_ah_a)^2-\lVert h\rVert^2\big)\Big]=(m-2)\lVert h\rVert^2 .$$
Hence
$$\lVert H\rVert_F^2=\big[\alpha^2m+\beta^2(m-2)\big]\lVert h\rVert^2=\frac{m(m-2)}{4(m-1)^2}\big[(m-2)+m\big]\lVert h\rVert^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2 .$$
**C3 confirmed exactly.**

**The tracelessness inequality.** Replacing $h$ by $-h$ if needed, let $h_1=M=\max_a\lvert h_a\rvert$. For $a\ne1$, $h_1+h_a=M+h_a\ge0$, so $\max_{a\ne1}\lvert h_1+h_a\rvert=M+\max_{a\ne1}h_a$. If some $h_a\ge0$ with $a\ne1$ the pair maximum is already $\ge M$. Otherwise $\sum_{a\ne1}h_a=-M$ over $m-1$ negative entries forces $\max_{a\ne1}h_a\ge-M/(m-1)$, so the pair maximum is $\ge M\tfrac{m-2}{m-1}$. **C4's inequality confirmed.** $\beta/\alpha=\tfrac m{m-2}$ is immediate, and
$$\beta\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\ \ge\ \alpha\cdot\tfrac m{m-2}\cdot\tfrac{m-2}{m-1}\max_a\lvert h_a\rvert=\tfrac m{m-1}\,\alpha\max_a\lvert h_a\rvert\ \ge\ \alpha\max_a\lvert h_a\rvert,$$
the room being exactly the factor $\tfrac m{m-1}$ the entry claims. Since $H$ is diagonal, $\lVert H\rVert_{op}$ is the largest of the three branch moduli, and the in-block one dominates for every $m\ge3$. **C5 confirmed.**

**The entry's witness.** At $h=(3,-1,-1,-1)$, $m=4$: pair maximum $\max(\lvert 3-1\rvert,\lvert-1-1\rvert)=2$ against entry maximum $3$, and $\tfrac{m-2}{m-1}\cdot3=2$. **Exact, and sharp.**

## 4. The supremum, C6, and the two lower bounds, C9

Normalise: $\lVert H\rVert_F=1$ means $\lVert h\rVert^2=c:=\tfrac{2(m-1)}{m(m-2)}$.

**Upper bound.** On the traceless hyperplane the linear functional $h\mapsto h_1+h_2$ has gradient $u=(1,1,0,\dots,0)$, whose projection has $\lVert u-\tfrac2m\mathbf 1\rVert^2=2-\tfrac4m=\tfrac{2(m-2)}m$. So $\max\lvert h_1+h_2\rvert=\sqrt c\cdot\sqrt{\tfrac{2(m-2)}m}=\tfrac{2\sqrt{m-1}}m$, and by symmetry the same for every pair, giving
$$\sup\lVert H\rVert_{op}=\tfrac m{2(m-1)}\cdot\tfrac{2\sqrt{m-1}}m=\frac1{\sqrt{m-1}} .$$
**Attained**, at $h^*=t(1,1,-\tfrac2{m-2},\dots,-\tfrac2{m-2})$ with $t=\sqrt{m-1}/m$, a maximum on a compact sphere, not a limiting supremum. **C6 confirmed.**

**Check at the smallest admissible dimension.** $m=3$, $h^*=\tfrac{\sqrt2}3(1,1,-2)$: $\lVert h\rVert^2=6\cdot\tfrac29=\tfrac43=c$; $\lVert H\rVert_F^2=\tfrac34\cdot\tfrac43=1$; pair maximum $\tfrac{2\sqrt2}3$; $\lVert H\rVert_{op}=\tfrac34\cdot\tfrac{2\sqrt2}3=\tfrac1{\sqrt2}=1/\sqrt{m-1}$. Confirmed at the edge.

**The floor $1/(m-1)$, which the entry states without a derivation.** It is exactly Cauchy–Schwarz over the $\binom m2$ in-block planes: from §3, $\sum_{a<a'}(h_a+h_{a'})^2=(m-2)\lVert h\rVert^2$, so
$$\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\ \ge\ \lVert h\rVert\sqrt{\tfrac{2(m-2)}{m(m-1)}},\qquad \lVert H\rVert_{op}\ \ge\ \tfrac m{2(m-1)}\sqrt{\tfrac{2(m-1)}{m(m-2)}\cdot\tfrac{2(m-2)}{m(m-1)}}=\tfrac m{2(m-1)}\cdot\tfrac2m=\frac1{m-1}.$$
The constant reproduces to the digit. **The floor is proven and is $\Theta(n^{-1})$.**

**The attained values.** For the two-value family with $p\le m/2$ entries $+a$ and $m-p$ entries $-pa/(m-p)$, $\lVert H\rVert_{op}^2=\tfrac{2(m-p)}{p(m-1)(m-2)}$, minimised at $p=\lfloor m/2\rfloor$. At even $m$ this is the even split, $\sqrt{2/((m-1)(m-2))}\sim\sqrt2/m$; at odd $m$ the balanced three-value $h=(u,\dots,u,0,-u,\dots,-u)$ gives $\sqrt{2m/((m-1)^2(m-2))}\sim\sqrt2/m$. **So a $\Theta(n^{-1})$ value is attained at every $m\ge4$, and C9's interval is confirmed**, floor and attained value both $\Theta(n^{-1})$, supremum $1/\sqrt{m-1}=\sqrt2/\sqrt{n-2}=\Theta(n^{-1/2})$.

**And the spike, for C11.** For $m\ge4$ the spike $h=(M,-\tfrac M{m-1},\dots)$ gives $\lVert H\rVert_{op}=\sqrt{\tfrac{m-2}{2(m-1)^2}}$, and
$$\tfrac{m-2}{2(m-1)^2}<\tfrac2{(m-1)(m-2)}\iff(m-2)^2<4(m-1)\iff m^2-8m+8<0,$$
whose roots are $4\pm2\sqrt2$, so the condition is $m\le6$. **The quadratic and its threshold are exact.**

## 5. Pre-registered question 2, is the supremum attained, and is the direction admissible?

**Attained: yes**, as a maximum, §4.

**Admissible: yes, and this is where the block's standing trap does not fire.** The consumers quantify over $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$, i.e. $\lVert H\rVert_F=1$ with $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$. The maximiser $H^*$ lies in $E_{L_e}(\lambda_m)$; $L_e$ is symmetric, $\langle W^*\rangle=E_{L_e}(1)$, and $T_{W^*}\mathcal O=E_{L_e}(\tfrac12)$ ([Lemma L27](../findings/nondegeneracy.md), as L149 restates it). Since $\lambda_m=\tfrac{m-2}{2(m-1)}<\tfrac12$ strictly for every finite $m$, distinct eigenspaces of a symmetric operator are orthogonal and **both orthogonality hypotheses hold automatically on the whole summand**, maximiser included. The direction that attains $1/\sqrt{m-1}$ is therefore inside the set L145, L147 and L149 quantify over. **No finding.**

*The contrast with the block's history is worth recording: [L145](../findings/second-order.md)'s box failed precisely because its quantifier admitted orbit-tangent $H$; L146's summand is orthogonal to the orbit tangent by the spectrum, so the same failure cannot occur here.*

## 6. Pre-registered question 1, does the envelope reach the three consumers?

**Consumer A, [Lemma L149](../findings/second-order.md), at every $w\in[0,1]$.** It needs $\lVert H_s\rVert_{op}\le a_0n^{-1/2}\lVert H_s\rVert_F$ with $H_s$ in the **joint** $\lambda_m$-eigenspace, both copies. **The box does not reach**, twice over.

*First, homogeneity.* The box asserts its identities under the standing hypothesis $\lVert H\rVert_F=1$, and states the supremum only there; L149 applies it at $\lVert H_s\rVert_F=\sqrt{1-w^2}<1$. The two displayed formulas are manifestly $1$-homogeneous in $h$, so a reader can rescale, but it is the displayed formulas that license it, not the supremum clause, and L149 has to say so itself.

*Second, and this is the finding.* Write $H(h)$ for the image of $h$ on $V_1$ and $H(k)$ for $k$ on $V_2$; a general element of the joint eigenspace is $H(h)+H(k)$. The two are Hilbert–Schmidt orthogonal, their supports meet only on the cross planes, where $\sum_{a,b}\alpha^2h_ak_b=\alpha^2(\sum_ah_a)(\sum_bk_b)=0$, so $\lVert H\rVert_F^2=\tfrac{m(m-2)}{2(m-1)}(\lVert h\rVert^2+\lVert k\rVert^2)$, and the sum is still diagonal, with **three** branches: $\alpha(h_a+k_b)$ on cross planes, $-\beta(h_a+h_{a'})$ on $B_1$, $-\beta(k_b+k_{b'})$ on $B_2$. **The box's equality is false there**, and I confirm the entry's two witnesses exactly:

- $m=5$, $h=k=(1,0,0,0,-1)$: $\alpha=\tfrac38$, $\beta=\tfrac58$; cross gives $\tfrac38\lvert1+1\rvert=\tfrac34$, the box's formula gives $\tfrac58\cdot1=\tfrac58$. **$\tfrac34$ against $\tfrac58$.**
- $m=6$, $h=k=(1,-\tfrac15,\dots,-\tfrac15)$: $\alpha=\tfrac25$, $\beta=\tfrac35$; cross gives $\tfrac25\cdot2=\tfrac45$, the formula gives $\tfrac35\cdot\tfrac45=\tfrac{12}{25}$. **$\tfrac45$ against $\tfrac{12}{25}$.**

**C8 confirmed, all four numerals exact.**

**C7, the cap, which no file derives.** Maximising $h_1+k_1$ over the joint sphere: $\max h_1=\lVert h\rVert\sqrt{(m-1)/m}$ on the traceless hyperplane, and $\lVert h\rVert+\lVert k\rVert\le\sqrt{2c}$ with $c=\tfrac{2(m-1)}{m(m-2)}$, so
$$\alpha\max(h_a+k_b)\le\tfrac{m-2}{2(m-1)}\cdot\sqrt{\tfrac{m-1}m}\cdot\tfrac{2\sqrt{m-1}}{\sqrt{m(m-2)}}=\frac{\sqrt{m-2}}m,$$
attained at $h=k\propto e_1-\tfrac1m\mathbf 1$. And $\tfrac{\sqrt{m-2}}m<\tfrac1{\sqrt{m-1}}\iff(m-1)(m-2)<m^2\iff 2<3m$. The in-block branch on the joint space is maximised by putting the whole norm budget into one copy, recovering $1/\sqrt{m-1}$. **So the joint supremum is indeed $1/\sqrt{m-1}$, C7 confirmed, and L149's use is safe.** At $m=6$: $\sqrt4/6=0.3\overline3$ against $1/\sqrt5=0.4472$, matching the numerals L149 and [r716](../reviews/REVIEW_r716.md) carry.

*But*: the value $\sqrt{m-2}/m$ is **asserted** in L146, **asserted** in L149's set-up bullet, and **asserted** in [r716](../reviews/REVIEW_r716.md):54, I read the report the record cites, and it gives the orthogonality reason and the numeral, not the maximisation. The derivation above is not on the record anywhere. **HYPOTHESIS-DEBT on C7's constant**, small and dischargeable in three lines, but currently owed.

**Consumer B, the kink $w_0=(n-4)/n$** ([L157](../findings/second-order.md), [results.md](../results.md):363). It uses the supremum as an upper envelope, $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$, with $a_0=\sqrt{2n/(n-2)}$, so $a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$, **one quantity written two ways, confirmed**: $n-2=2m-2$. The crossing solves $c\sqrt{1-w^2}=1-w$ with $c^2=\tfrac2{n-2}$, giving $w_0=\tfrac{1-c^2}{1+c^2}=\tfrac{(n-4)/(n-2)}{n/(n-2)}=\tfrac{n-4}n$, which is $\tfrac23$ at $n=12$. And the one-sided slope: $\sqrt{1-w_0^2}=\tfrac2n\sqrt{2(n-2)}$, so $cw_0/\sqrt{1-w_0^2}=\tfrac{n-4}{2(n-2)}$ and $\phi'(w_0^-)=1-\tfrac{n-4}{2(n-2)}=\tfrac n{2(n-2)}=\tfrac35$ at $n=12$. **Every one of these reproduces exactly from L146's constant.** The box reaches this consumer on the same hypothesis as A (the joint two-copy reading) and no other; and because the supremum is *attained*, the envelope is tight at $w=0$, so the kink is not an artefact of a loose bound.

**Consumer C, the Cauchy estimate over a complex disc.** The disc is $\rho=\gamma g_n/\lVert H\rVert_{op}$; $\lVert zH\rVert_{op}=\lvert z\rvert\lVert H\rVert_{op}$ for real $H$ and complex $z$, so L146's real statement does extend. **Two shortfalls.** (i) L146's own box writes the disc as $g_n/\lVert H\rVert_{op}$, i.e. $\gamma=1$, which [Lemma L156](../findings/second-order.md) excludes: $\gamma^*=D/4=0.55$ at $m=6$, a factor $20/11$ in radius, and [L148](../findings/second-order.md)'s box says that on the larger disc "the enclosed cluster reaches $0$ and the integrand stops being the defect". The **order** claim survives, $\gamma^*$ being a constant, so $\Omega(n^{-1/2})$ stands and "a factor $\sqrt n$ larger than the direction-blind $g_n=\Theta(n^{-1})$" stands; the **stated radius** does not. **C15.** (ii) The claim needs $g_n>0$, i.e. $\ker W^*=0$, which L147 and L149 state and L146 does not.

## 7. The named trap, what the citable statement carries alone

Read with the surrounding boxes removed, the box says: *for $H$ the Weyl image of a single traceless symmetric $h$ on $\mathbb R^m$, with $\lVert H\rVert_F=1$, $n=2m$, $m\ge3$: $\lVert H\rVert_F^2=\tfrac{m(m-2)}{2(m-1)}\lVert h\rVert^2$, $\lVert H\rVert_{op}=\tfrac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$, the in-block branch always winning, supremum $1/\sqrt{m-1}$ attained at the pair-concentrated $h$, and $\lVert H\rVert_{op}\in[\Theta(n^{-1}),\Theta(n^{-1/2})]$ in order.*

**What it does not carry.**

1. **The map.** "The Weyl image" names no map. A consumer cannot compute $H$ from the box. The words "in-block branch" also have no referent without the eigenvalue list above.
2. **The joint two-copy scope.** The box says "**single**". Its principal consumer applies it to two copies, where its equality clause is **false** by the witnesses of §6. The correcting box sits four lines above the statement; L149's set-up repeats the correction; [r716](../reviews/REVIEW_r716.md) says in terms "the record should say so, since the direction it is applied in is not the direction it was proved in". **It still does not say so inside the statement.** This is exactly the defect [L148](../findings/second-order.md) was repaired for, and L148's repair box states the principle L146 has not applied: *"THE SCOPE CORRECTIONS ARE IN THE STATEMENT ABOVE, WHICH IS WHERE A CITATION READS THEM."* **C13, and the round's named trap fires.**
3. **The frame chosen after $h$.** Absent, and false in a fixed frame, L148 exhibits the witness.
4. **$\ker W^*=0$ and $m\ge5$.** The order-level and margin claims need them; the box carries neither.

**And one singular/plural slip inside the entry.** The "ORDER-LEVEL CONCLUSION" box reads "Every $H$ in **the summand**", singular, while the Setting three lines above says "the two $S^2_0(\mathbb R^m)$ **summands**", plural. That is the identical slip L148's box records as *"written singular, used plural by every citation, which is the slip that cost [L149] a factor of $n$"*. The claim happens to be true on the joint space by §6, but it is true for a reason the sentence does not give. **C13's second half.**

## 8. The three prose defects, with the discrepancy protocol run on each

### 8.1 "$\approx\sqrt2/m$ an attained value" fails at $m=3$, C10, upheld

**Locate.** [findings/second-order.md](../findings/second-order.md):1151, *"**The two lower bounds on file are not in conflict**: $1/(m-1)$ is a proven floor and $\approx\sqrt2/m$ an attained value, so they bracket one infimum rather than contradict."*

**Exhibit.** At $m=3$, inside the box's own $m\ge3$: the proven floor is $1/(m-1)=\tfrac12$ and the quoted attained value is $\sqrt2/3=0.471405$. **The "attained value" lies strictly below the "proven floor"**, so the two do not bracket, they invert. And nothing attains $\sqrt2/3$: at $m=3$ every pair sum is $-h_c$, so $\lVert H\rVert_{op}=\tfrac34\max_a\lvert h_a\rvert$, and with $\lVert h\rVert^2=c=\tfrac43$ the constraint $\max_a\lvert h_a\rvert=M$ permits $\lVert h\rVert^2\le2M^2$ (maximised at $h=(M,0,-M)$ over the traceless triples), so $M\ge\sqrt{2/3}$ and
$$\min\lVert H\rVert_{op}=\tfrac34\sqrt{\tfrac23}=\frac{\sqrt6}4=0.612372,\qquad\text{at }h=\sqrt{\tfrac23}\,(1,0,-1).$$
*Verification of that witness end to end*: $\lVert h\rVert^2=\tfrac43$; $\lVert H\rVert_F^2=\alpha^2m\lVert h\rVert^2+\beta^2(m-2)\lVert h\rVert^2=\tfrac1{16}\cdot3\cdot\tfrac43+\tfrac9{16}\cdot1\cdot\tfrac43=\tfrac14+\tfrac34=1$; branches $\{\pm\tfrac14\sqrt{2/3},0\}$ on the cross planes and $\{\mp\tfrac34\sqrt{2/3},0\}$ on the $B_1$ planes; $\lVert H\rVert_{op}=\sqrt6/4$.

**Argue the opposite.** The most charitable reading is that "$\approx$" makes the clause asymptotic and the sentence is about large $m$, where $\sqrt2/m>1/(m-1)$ for every $m\ge4$ (since $m<\sqrt2(m-1)\iff m>2+\sqrt2$) and the bracketing does hold. That reading rescues the mathematics but not the sentence: the entry places the clause immediately beside a box that says $m\ge3$, and it is offered as the *resolution of a recorded disagreement*, i.e. as a statement about the record's bounds rather than about their limits. **Not withdrawn.** The defect is contained, the interval claim C9 rests on the proven floor and on the $m\ge4$ attained value, neither of which this touches.

### 8.2 "the even split is beaten only up to $m=6$" fails at $m=7$, C11, upheld as written, charitable reading recorded

**Locate.** Same line, *"**And the even split is beaten only up to $m=6$**, the spike witness winning exactly when $m^2-8m+8<0$; at $m\ge7$ that witness loses and the clause has no proof, though a different family reaches $m=8$."*

**Exhibit**, at $m=7$, i.e. $n=14$, one of the three dimensions the record evaluates. Here $c=\tfrac{2\cdot6}{7\cdot5}=\tfrac{12}{35}$ and $\beta=\tfrac7{12}$. The two-sided spike $h=\sqrt{6/35}\,(1,0,0,0,0,0,-1)$ is traceless with $\lVert h\rVert^2=\tfrac{12}{35}$, pair maximum $\sqrt{6/35}$, and
$$\lVert H\rVert_{op}=\tfrac7{12}\sqrt{\tfrac6{35}}=\frac{\sqrt{210}}{60}=0.2415229,$$
against the best two-value split at $m=7$ ($p=3$), $\sqrt{\tfrac{2\cdot4}{3\cdot6\cdot5}}=\tfrac2{3\sqrt5}=0.2981424$, and against the spike's $\sqrt{5/72}=0.2635231$. **The even split is beaten at $m=7$, by two families, one of which the entry's own tail names.** Moreover "the even split" is undefined at odd $m$, and $m=7$ is odd; the entry's threshold is computed against a family that does not exist at the dimension its inequality is read at.

The tail is right about $m=8$: there the two-sided spike gives $\tfrac12\sqrt{\tfrac8{7\cdot6}}=\tfrac1{\sqrt{21}}$ and the even split gives $\sqrt{\tfrac2{7\cdot6}}=\tfrac1{\sqrt{21}}$, **an exact tie**, which is what "reaches $m=8$" must mean.

**Argue the opposite.** The charitable reading is that "beaten" in the headline is shorthand for "beaten *by the spike witness*", which the next clause makes explicit and which is then exactly right, $m^2-8m+8<0\iff m\le6$. Under that reading the sentence is compressed rather than false, and the tail correctly flags the family that survives to $m=8$. **Partially withdrawn**: recorded as a wording defect plus a genuine odd-$m$ scope hole at $n=14$, not as a mathematical error. Nothing downstream consumes it, the box claims only the order.

### 8.3 "the off-orbit margin maximum" is the margin minimum, C14, upheld

**Locate.** [findings/second-order.md](../findings/second-order.md):1133, *"At $W^*=S^m\times S^m$, [Lemma L27] puts the off-orbit margin maximum on the two $S^2_0(\mathbb R^m)$ summands."*

**Exhibit.** The margin on an $L_e$-eigensummand is $3\theta_0(\tfrac12-\lambda)$, decreasing in $\lambda$. [Lemma L27](../findings/nondegeneracy.md) puts $\lambda_m$ above every other off-orbit eigenvalue exactly when $\lambda_m>\mu$, i.e. $\tfrac{m-2}{2(m-1)}>\tfrac1{m-1}\iff m>4$. So the $S^2_0$ summands carry the **largest $\lambda$**, hence the **smallest** margin. The entry's own next sentence confirms it: the margin there is *"exactly [L145]'s $c_p$"*, and L145's box calls $c_p=3\theta_0/(n-2)$ *"the strict minimum"*. Two adjacent sentences of L146 call one quantity the maximum and the minimum. The identity itself is exact: $\tfrac12-\lambda_m=\tfrac{(m-1)-(m-2)}{2(m-1)}=\tfrac1{2(m-1)}=\tfrac1{n-2}$, so $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)=c_p$.

**Argue the opposite.** "Margin maximum" could be read as elliptical for "the maximiser of $L_e$ among the off-orbit summands", which is what L27 supplies and what the entry then uses. That reading is available and is almost certainly the intent. **Not withdrawn** as a wording defect: the words as written invert the quantity, and a citing reader who takes the summand for the *largest* margin will draw the opposite of L149's convex-combination step, which takes the *smallest surviving* summand margin as its coefficient.

### 8.4 "sharp at the spike", C12, minor, upheld at $m=3$

C4's inequality is claimed sharp at the spike with no dimension floor. At $m=3$ the spike $h=(2,-1,-1)$ has pair maximum $\max(\lvert2-1\rvert,\lvert-2\rvert)=2$ against $\tfrac{m-2}{m-1}\max_a\lvert h_a\rvert=1$, **not sharp**, the in-pair sum $2M/(m-1)$ overtaking $M(m-2)/(m-1)$ whenever $m<4$. Sharp at $m=4$ (both equal $2$ at $(3,-1,-1,-1)$) and at every $m\ge4$. Charitable reading: the entry's own witness is at $m=4$, so "the spike" may be meant only there. **Contained**; the inequality itself, which is what C5 uses, holds at every $m\ge3$.

## 9. The edges

| edge | finding |
|---|---|
| smallest admissible $m$ | $m=3$: **C3, C5, C6 all hold** and I checked them by closed form. But the entry's Setting is false there ($\lambda_3=\tfrac14<\mu=\tfrac12$, so the $S^2_0$ summands are not where the margin sits), the title's word "margin" is wrong, C10 inverts and C12 fails. $m=2$ is correctly excluded, $\lVert H\rVert_F^2=0$ there, so $\lVert H\rVert_F=1$ is unsatisfiable |
| $m=4$ | $\lambda_4=\tfrac13=\mu$ exactly, a tie: the summand is not strictly the extremal one, and the entry's $m\ge5$ box is the right floor for the word "margin". The norm identities hold |
| $w=0$ | L146's envelope is **tight** there, the supremum being attained (§5). But [L148](../findings/second-order.md) empties $w=0$ of the quantity L146 prices, and L146's own last box says so |
| $w=1$ | $\min(\cdot,1)$ makes the envelope constant $1$ above $w_0=(n-4)/n$, so L146 contributes nothing there; the truncation at $1$ is $\lVert H\rVert_{op}\le\lVert H\rVert_F$ and is not L146's |
| odd $n$ | **outside the setting by construction**: $n=2m$, and $S^m\times S^m$ exists at even $n$ only. L149's uniformity numeral is correctly stated as "its minimum over **even** $n\ge12$". No exposure. *Odd $m$ ($n=14$), is a live edge, §8.2* |
| $\ker W\ne0$ | $\ker W^*=0$ at $S^m\times S^m$ (two-valued spectrum, [L145](../findings/second-order.md)), so the base point is safe. The named kernel witness $W_{\mathbb{CP}^2}$, $\dim\ker W=3$ ([bounds.md](../findings/bounds.md):59, [second-order.md](../findings/second-order.md):1179), is a different base point at $n=4$ and is out of scope. **The hypothesis is nonetheless used unstated** by L146's analyticity-disc box, §6 consumer C. *Note that $H$ itself has a large kernel (it annihilates all $\binom m2$ planes inside $B_2$) which is harmless, the disc depending on the spectrum of $W^*$ and not of $H$* |

## 10. Constants: which reproduced and which did not

**Reproduced exactly, by hand:** $\alpha=\tfrac{m-2}{2(m-1)}$; $\beta=\tfrac m{2(m-1)}$; $\beta/\alpha=\tfrac m{m-2}$ and the room factor $\tfrac m{m-1}$; $\mathrm{Ric}=m\,h$; $\tfrac{m(m-2)}{2(m-1)}$; $\sum_{a<a'}(h_a+h_{a'})^2=(m-2)\lVert h\rVert^2$; $1/\sqrt{m-1}$ and its maximiser $t=\sqrt{m-1}/m$; the floor $1/(m-1)$, as exact Cauchy–Schwarz; $\sqrt{m-2}/m$ and $(m-1)(m-2)<m^2$; $\tfrac34$ vs $\tfrac58$ at $m=5$; $\tfrac45$ vs $\tfrac{12}{25}$ at $m=6$; $m^2-8m+8<0\iff m\le6$, roots $4\pm2\sqrt2$; "too small by $m/(m-1)$" for the retracted $\sqrt{m-1}/m$; $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$; $\lambda_m>\mu\iff m\ge5$; $n\ge12\Rightarrow m\ge6\ge5$; $\dim S^2_0(\mathbb R^m)=s_m$.

**Reproduced at the consumers, from L146's constant:** $a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$; $a_0=\sqrt{2n/(n-2)}=\sqrt{2.4}$ at $n=12$; $w_0=\tfrac{1-a_0^2/n}{1+a_0^2/n}=\tfrac{n-4}n=\tfrac23$ at $n=12$; $\phi'(w_0)=\tfrac n{2(n-2)}=\tfrac35$ at $n=12$; and, as a cross-check on the block's arithmetic, $1/g_n=\tfrac n2\sqrt{\tfrac{2(n-1)}{n-2}}=n^2c_p/6$ and $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}$.

**Could not reproduce from what is written:** the phrase "a different family reaches $m=8$" names no family. I identified one that fits exactly, the two-sided spike $h\propto(1,0,\dots,0,-1)$, which gives $\tfrac1{\sqrt{21}}$ at $m=8$ against the even split's $\tfrac1{\sqrt{21}}$, an exact tie, and strictly beats it for every $m\le7$, but that identification is mine, not the record's.

**Overloaded letters, the round's standing warning.** Inside L146: $g$ is the metric ($g_q$, $g_p$, $g$, three occurrences in the embedding box) and $g_n$ is the spectral gap eight lines later; $\alpha$ is $\tfrac{m-2}{2(m-1)}$ here and the contour radius $\alpha^*=1.1$ in [L156](../findings/second-order.md); $\beta$ is $\tfrac m{2(m-1)}\in(\tfrac12,1]$ here and the exponent $\sup\lvert P\rvert=\Theta(n^\beta)$, $\beta\in[0,\tfrac12]$, in [L147](../findings/second-order.md) and [L149](../findings/second-order.md), numerically adjacent ranges in neighbouring entries. And $\lambda_m$ and $\alpha$ are **the same number**, $\tfrac{m-2}{2(m-1)}$, given two names four lines apart with no remark; that coincidence is structural rather than accidental and the entry loses it.

## 11. The two forms, is [results.md](../results.md) consistent?

**There is no canonical L146.** [results.md](../results.md) carries canonical entries for L133, L140, L154, L155, L156, L157 and L158, and none for L141, L143, L145, L146, L147, L148, L149 or L152. [findings/INDEX.md](../findings/INDEX.md) has no row for it either.

**The absence is not correct**, for a reason internal to results.md. Its **canonical Lemma L158** ([results.md](../results.md):363) reads *"the envelope being $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$ and equal to $1$ above $w_0$"* and takes $w_0=(n-4)/n$ as the binding minimiser of the comparison that is L158's entire content. Both quantities are L146's, and **$a_0$ is used there once and defined nowhere in results.md**, every other match for the string is inside $\theta_0(n)$. So a reader of the canonical layer alone cannot say what $a_0$ is, where it comes from, on what dimension floor it holds, or that it prices one copy where the chain applies it to two. The canonical layer's dependency leaves the canonical layer.

*This is the pattern the round's warning names, corrections written in one file and not its neighbours. The sibling entries L156, L157 and L158 were promoted; the entry all three rest on was not.*

## 12. What would break it, and what I did to look for it

**The object that would falsify the box** is an $h\in S^2_0(\mathbb R^m)$ with $\lVert H\rVert_F=1$ and $\lVert H\rVert_{op}>1/\sqrt{m-1}$, or (for the use L149 makes), a pair $(h,k)$ on the joint two-copy eigenspace exceeding it.

**How I looked.** In the frame diagonalising $h$ (and $k$), $H$ is diagonal on the coordinate $2$-plane basis, since a Kulkarni–Nomizu product of two diagonal symmetric tensors has $(h\owedge k)_{ijkl}\ne0$ only for $\{i,j\}=\{k,l\}$. So $\lVert H\rVert_{op}$ is the maximum of exactly three branch moduli, and no direction escapes the classification. I maximised each branch in closed form by projecting its linear functional onto the traceless hyperplane and applying Cauchy–Schwarz to the joint norm budget: the in-block branch gives $1/\sqrt{m-1}$, attained; the single-copy cross branch gives $\alpha\lVert h\rVert\sqrt{(m-1)/m}=\tfrac{\sqrt{2(m-2)}}{2m}$, below $1/\sqrt{m-1}$ since $(m-1)(m-2)<2m^2$; the two-copy cross branch gives $\sqrt{m-2}/m<1/\sqrt{m-1}$. The three maxima exhaust the operator norm. **No such object exists**, at any $m\ge3$, on either the single copy or the joint space.

**The object that would falsify the *citation*** is a consumer that reads the box literally on the joint eigenspace and takes the equality clause with it. [Lemma L149](../findings/second-order.md) is that consumer; it escapes only because its own set-up bullet re-derives the scope from [r716](../reviews/REVIEW_r716.md). A fourth consumer, arriving later and reading the box alone, would not escape.

## Verdict

**`GAP`**

The mathematics is sound and I reproduced every part of it: the embedding, the eigenvalue list, both displayed identities, the in-block dominance argument, the supremum $1/\sqrt{m-1}$ and its maximiser, the floor $1/(m-1)$, the cross-branch cap $\sqrt{m-2}/m$, all four joint-eigenspace numerals, and the threshold $m^2-8m+8$. The supremum is attained and (answering the round's second pre-registered question), **the attaining direction is inside the domain all three consumers quantify over**, the $\lambda_m$-summand being $L_e$-orthogonal to both $\langle W^*\rangle$ and $T_{W^*}\mathcal O$; the block's orbit-tangent trap does not fire here.

The gap is scope, and it is the trap the round named. **The citable statement prices a single copy, names no map for "the Weyl image", carries neither $\ker W^*=0$ nor the $m\ge5$ that its own title's word "margin" requires, and says "the summand" where the object is two.** Each correction exists, in a box beside the statement, in L149's set-up, in [r716](../reviews/REVIEW_r716.md), and none is inside the statement, which is the one place a citation reads. [Lemma L148](../findings/second-order.md) received exactly this repair and records the principle; L146 did not. Two prose clauses are additionally false inside the box's own $m\ge3$ (the bracketing at $m=3$ and the even-split threshold at $m=7$) and neither is load-bearing. The cross-branch cap $\sqrt{m-2}/m$ carries no derivation anywhere on the record, which is a small standing debt on the one line that licenses L149's use.

**To close it**: move the joint two-copy clause, the frame-after-$h$ clause, $\ker W^*=0$ and the $m\ge5$ margin floor into the box; name the map; strike or repair the $m=3$ bracketing and the $m=7$ threshold; write the three-line maximisation behind $\sqrt{m-2}/m$; and either promote a canonical L146 to [results.md](../results.md) or define $a_0$ where canonical L158 spends it.
