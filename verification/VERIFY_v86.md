# VERIFY v86, L146-r2: the operator norm on the margin summand, its supremum $1/\sqrt{m-1}$, and the range $[\Theta(n^{-1}),\Theta(n^{-1/2})]$

*Cold read of the corrected text of Lemma L146, dispatched as [ROUND_L146-r2](ROUND_L146r2.md) from [findings/second-order.md](../findings/second-order.md):1131–1162. Which passages are repairs was not marked and I did not try to guess. **No numerical work was done**: no script was run, and every value below is an exact hand evaluation from the constants the entry names. Log: [agent_logs/verify-L146r2-v86.log](../agent_logs/verify-L146r2-v86.log).*

## Claim table

| # | claim, as the entry states it | verdict |
|---|---|---|
| 1 | $\mathrm{Ric}(h\owedge g_q)=m\,h\ne0$, so the projection term survives | **CONFIRMED** |
| 2 | Weyl image is diagonal on coordinate $2$-planes with $\alpha h_a$ cross, $-\beta(h_a+h_{a'})$ in $B_1$, $0$ in $B_2$ | **CONFIRMED** |
| 3 | $\lVert H\rVert_F^2=\dfrac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ | **CONFIRMED** |
| 4 | $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\ge\tfrac{m-2}{m-1}\max_a\lvert h_a\rvert$, and $\beta/\alpha=\tfrac m{m-2}$ covers it | **CONFIRMED** |
| 4a | that inequality is "sharp at the spike" | **CONFIRMED for $m\ge4$; FALSE at $m=3$**, where the ratio is identically $1$ |
| 5 | $\lVert H\rVert_{op}=\dfrac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$, in-block branch always winning | **CONFIRMED**, on the eigenvalue reading of $h_a$, **the box does not fix that reading** (§4) |
| 6 | supremum $1/\sqrt{m-1}$, attained at the pair-concentrated $h$ | **CONFIRMED and ATTAINED**; the attaining $h$ is **under-named** (§5) |
| 7 | $\lVert H\rVert_{op}$ ranges over $[\Theta(n^{-1}),\Theta(n^{-1/2})]$ | **CONFIRMED**, floor $1/(m-1)$ and attained $\sqrt{2/((m-1)(m-2))}$ both reproduced |
| 8 | on the joint two-copy eigenspace the equality clause is false; witnesses at $m=5$ and $m=6$ | **CONFIRMED**, both witnesses exact |
| 9 | the cross branch caps at $\sqrt{m-2}/m<1/\sqrt{m-1}$, so the supremum is unchanged | **CONFIRMED**, cap is an exact maximum |
| 10 | the first version's $\sqrt{m-1}/m$ is too small by $m/(m-1)$, intervals disjoint at $m=3$ | **CONFIRMED**, both reproduced from the first version's own embedding |
| 11 | the even split is beaten only up to $m=6$, exactly when $m^2-8m+8<0$ | **CONFIRMED as a comparison of two closed forms**; the even split does not exist at odd $m$ (§8) |
| 12 | "though a different family reaches $m=8$" | **CONFIRMED**, family reconstructed by hand as $h=e_1-e_m$; the entry names none |
| 13 | margin is exactly $c_p=3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$ | **CONFIRMED** |
| 14 | this holds for $m\ge5$, where $\lambda_m>\mu$ | **CONFIRMED**, $\lambda_m>\mu\iff m\ge5$ exactly |
| 15 | the disc $g_n/\lVert H\rVert_{op}$ is $\Omega(n^{-1/2})$, a factor $\sqrt n$ above $g_n$ | **CONFIRMED** |
| 16 | r448's $O(n^{1/2})$ against r449's $O(1)$, coinciding at $\rho=\Theta(g_n)$ | **CONFIRMED**, both return $O(n)$ there |
| 17 | the statement, read alone, is what a consumer needs | **REFUTED**, it carries neither homogeneity nor the two-copy extension, and every consumer uses both (§6) |
| 18 | [results.md](../results.md) carries a canonical L146 | **ABSENT**, and the absence is **not fully correct**: results.md consumes $a_0$ and defines it nowhere (§10) |

**One line.** Every display in the lemma is correct and I reproduced all of it by hand, but the citable box is not self-contained: it never says what $h_a$ is, never says it is homogeneous, and prices one copy where all three consumers use two, so the block's named trap is live in exactly the place the round was dispatched to look.

## 0. Conventions, fixed once

- $n=2m$, $W^*=S^m\times S^m$, $V_1\oplus V_2=\mathbb R^n$ with index sets $B_1,B_2$ of size $m$ each. $\pi_2$ is the metric of $V_2$ read as a symmetric $2$-tensor on $\mathbb R^n$.
- Kulkarni–Nomizu: $(h\owedge k)_{ijkl}=h_{ik}k_{jl}+h_{jl}k_{ik}-h_{il}k_{jk}-h_{jk}k_{il}$. For $h,k$ diagonal in one orthonormal frame this is diagonal on the coordinate $2$-planes with $(h\owedge k)_{ijij}=h_ik_j+h_jk_i$, and I read the operator eigenvalue on $e_i\wedge e_j$ as that number.
- $\alpha=\tfrac{m-2}{2(m-1)}$, $\beta=\tfrac m{2(m-1)}$, $\lambda_m=\alpha$, $\mu=\tfrac1{m-1}$, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, $c_p=3\theta_0/(n-2)$, $g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$.
- $M_1(h)=\max_a\lvert h_a\rvert$, $M_2(h)=\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$.
- $g_q$: the entry never defines it. I fixed it as $\pi_2$, the metric of the *other* factor, because that is the unique reading under which both of the entry's own checks come out, $\mathrm{Ric}=m\,h$, and "an earlier version took the eigenvalues to be $h_a$ on the cross planes and zero inside both blocks". Everything below is on that reading.

## 1. Hypothesis inventory

**Carried by the LEMMA box itself**, four, and that is all of them: $H$ is the Weyl image of a **single** $h\in S^2_0(\mathbb R^m)$; $\lVert H\rVert_F=1$; $n=2m$; $m\ge3$.

**Carried by the Setting and the surrounding boxes, and used by the proof.** The base point is $W^*=S^m\times S^m$ (used: the whole eigenvalue list). The frame is adapted to $V_1\oplus V_2$ and diagonalises $h$ (used: "diagonal on coordinate $2$-planes", see §4, it is not stated). $m\ge5$, so that $\lambda_m>\mu$ and the margin sits on this summand (used by the Setting's margin identity and by the order-level box; **not** used by the two displays).

**Imported results, and each against the object it applies to.**

- [Lemma L27](../findings/nondegeneracy.md), for "$L_e$ acts there as the scalar $\lambda_m$". Its hypotheses are $p,q\ge3$ and $(p,q)\ne(3,3)$. At $p=q=m$ this is $m\ge3$ **and $m\ne3$**, so at the LEMMA box's own floor $m=3$ the cited lemma does not apply. Checked, and it is a real edge (§7).
- [Lemma L145](../findings/second-order.md), for $c_p=3\theta_0/(n-2)$ and for $g_n$. Its hypotheses are $n\ge12$, $\lVert H\rVert_F=1$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$. The dimension floor is $m\ge6$, four above the box's.
- The record's projector $\mathrm{KN}(h)=\tfrac12(h\owedge g)$, [nondegeneracy.md](../findings/nondegeneracy.md). Consistent: the trace-free decomposition at scalar curvature $0$ gives $W=R_0-\tfrac{m}{n-2}\,h\owedge g$, and $\tfrac{2m}{n-2}\mathrm{KN}(h)$ is the same tensor.

**Hypotheses the consumers carry that the entry never asserts.** $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$. Both hold, and both are one line from the cited L27, the decomposition is multiplicity-free, $L_e$ is symmetric and acts as a scalar on each summand, and $\lambda_m\notin\{1,\tfrac12\}$ for every $m\ge3$, so $S^2_0(\mathbb R^m)\perp\langle W^*\rangle$ and $S^2_0(\mathbb R^m)\perp(\mathbb R^m\otimes\mathbb R^m)=T_{W^*}\mathcal O$. **No finding: the argument is on file in the source the entry cites.** But the entry stops one line short of saying that the directions it prices are admissible for [L145](../findings/second-order.md) and [L147](../findings/second-order.md), which is the only reason its number is wanted.

**Which of these the written proof uses.** The two displays use only: the frame adapted to $V_1\oplus V_2$ and diagonalising $h$; tracelessness of $h$; $m\ge3$ (so $\alpha>0$). They use neither $m\ge5$, nor $n\ge12$, nor the margin, nor $g_n$, nor L27. **No finding: the proof uses no hypothesis the statement omits, except the frame convention of §4.**

## 2. The embedding, checked from scratch

With $h$ diagonal on $V_1$, traceless, and $R_0=h\owedge\pi_2$: the eigenvalue on $e_i\wedge e_j$ is $h_i(\pi_2)_j+h_j(\pi_2)_i$, hence $h_a$ on a cross plane $(a,b)$, $0$ inside $B_1$ and $0$ inside $B_2$. So $R_0$ *is* the tensor the entry says the first version mistook for the answer.

$\mathrm{Ric}(R_0)_{aa}=\sum_j (R_0)_{ajaj}=\sum_{b\in B_2}h_a=m\,h_a$ and $\mathrm{Ric}(R_0)_{bb}=\sum_{a\in B_1}h_a=0$. So $\mathrm{Ric}(R_0)=m\,h\ne0$ and $\mathrm{scal}=0$. **Claim 1 CONFIRMED.**

At $\mathrm{scal}=0$ the decomposition reads $W=R_0-\tfrac1{n-2}\mathrm{Ric}\owedge g=R_0-\tfrac{m}{2(m-1)}\,h\owedge g=R_0-\beta\,h\owedge g$. Since $h$ is traceless on $\mathbb R^n$, $(h\owedge g)_{ijij}=h_i+h_j$, so

- cross $(a,b)$: $h_a-\beta h_a=(1-\beta)h_a$, and $1-\beta=\tfrac{2(m-1)-m}{2(m-1)}=\tfrac{m-2}{2(m-1)}=\alpha$;
- inside $B_1$: $0-\beta(h_a+h_{a'})=-\beta(h_a+h_{a'})$;
- inside $B_2$: $0-\beta(0+0)=0$.

**Claim 2 CONFIRMED**, exactly as displayed. Two checks the entry does not run and I did: $\mathrm{Ric}(W)=m h-\beta\,(n-2)h=mh-mh=0$, so $W$ really is a Weyl tensor; and the branch count is $m^2+2\binom m2=m(2m-1)=\binom n2$, so no plane is missed.

## 3. The two displays

**Frobenius.** $\sum_{a<a'}(h_a+h_{a'})^2=\tfrac12\big[2(m-1)\lVert h\rVert^2+2((\textstyle\sum h_a)^2-\lVert h\rVert^2)\big]=(m-2)\lVert h\rVert^2$ by tracelessness. Hence
$$\lVert H\rVert_F^2=m\alpha^2\lVert h\rVert^2+\beta^2(m-2)\lVert h\rVert^2=\frac{m(m-2)\big[(m-2)+m\big]}{4(m-1)^2}\lVert h\rVert^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2 .$$
**Claim 3 CONFIRMED exactly.**

**Operator norm.** $\lVert H\rVert_{op}=\max(\alpha M_1,\beta M_2)$. For the in-block branch to always win it suffices that $\beta M_2\ge\alpha M_1$. Normalise $M_1=h_1>0$. Tracelessness gives $\sum_{a\ge2}h_a=-h_1$, so $\max_{a\ge2}h_a\ge-\tfrac{h_1}{m-1}$, and with $a'$ that maximiser, $h_1+h_{a'}\ge\tfrac{m-2}{m-1}h_1$. So $M_2\ge\tfrac{m-2}{m-1}M_1$, and $\beta M_2\ge\tfrac m{2(m-1)}\tfrac{m-2}{m-1}M_1=\tfrac{m}{m-1}\alpha M_1>\alpha M_1$. **Claim 4 CONFIRMED**, with the stated room being exactly the factor $\tfrac m{m-1}$, i.e. $\beta/\alpha=\tfrac m{m-2}$ against the needed $\tfrac{m-1}{m-2}$.

The parenthetical witness reproduces: $h=(3,-1,-1,-1)$ at $m=4$ has $M_2=\max(2,-2)=2$ and $M_1=3$, ratio $\tfrac23=\tfrac{m-2}{m-1}$. **Sharp, at $m\ge4$.** At $m=3$ tracelessness makes $h_a+h_{a'}=-h_{a''}$, so $M_2=M_1$ identically and the ratio is $1$, never the claimed $\tfrac{m-2}{m-1}=\tfrac12$. **Claim 4a: the inequality holds at $m=3$, the sharpness clause does not**, and $m=3$ is inside the box's own range.

## 4. Candidate A, the LEMMA box never says what $h_a$ is, and the naive reading is refuted by its companion display

**Locate.** The box reads: *"For $H$ the Weyl image of a single $h\in S^2_0(\mathbb R^m)$ with $\lVert H\rVert_F=1$ … $\lVert H\rVert_{op}=\frac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$."* The symbol $h_a$ appears in the box with no definition, and the box quantifies over all of $S^2_0(\mathbb R^m)$, not over diagonal $h$.

**Exhibit, in closed form.** Take $m=6$, $n=12$, and $h=e_1\odot e_2$, i.e. $h_{12}=h_{21}=1$ and every other entry $0$. It is symmetric and traceless, so $h\in S^2_0(\mathbb R^6)$. Read $h_a$ as the diagonal entries in the standard frame: all six are $0$, so the second display returns $\lVert H\rVert_{op}=0$. The first display, on the same $h$ with $\lVert h\rVert^2=2$, returns $\lVert H\rVert_F^2=\tfrac{6\cdot4}{2\cdot5}\cdot2=\tfrac{24}5$, so $\lVert H\rVert_F=\sqrt{24/5}\ne0$. A nonzero operator of zero operator norm: **the box's two displays contradict each other on a single admissible $h$.**

**Argue the opposite.** The charitable reading is that $h_a$ are the *eigenvalues* of $h$, the frame being chosen after $h$; a one-index symbol on a symmetric $2$-tensor conventionally means that, and the construction $h\mapsto\mathrm{Weyl}(h\owedge\pi_2)$ is $O(m)\times O(m)$-equivariant, so both displays are invariant under $h\mapsto OhO^{\mathsf T}$ and the reduction to diagonal $h$ is legitimate. On that reading $e_1\odot e_2$ has eigenvalues $1,-1,0,0,0,0$, giving $M_2=1$, $\lVert H\rVert_{op}=\tfrac35$ and ratio $\tfrac{3/5}{\sqrt{24/5}}=0.2739$, inside $[\tfrac15,\tfrac1{\sqrt5}]=[0.2,0.4472]$, consistent.

**Disposition.** Withdrawn as a false theorem; **retained as a defect of the citable statement.** It is the block's named trap in its purest form: the identical failure was repaired **into** [Lemma L148](../findings/second-order.md)'s own statement, *"the diagonalising frame chosen **after** $H$"*, and its scope box says in terms that *"'$W^*$ and $H$ simultaneously diagonal on coordinate $2$-planes' is **false in a fixed frame**, $h_{12}=1$ gives $H_{1424}\ne0$ at every $m\ge3$"*, four entries later in the same file, and L146's box did not receive it. L146's nearest sentence, *"Diagonality does survive, both Kulkarni–Nomizu factors being diagonal in the same frame"*, is outside the box, and is the fixed-frame form L148 labels false.

## 5. Candidate B, "the pair-concentrated $h$" is under-named, and the naive reading overshoots the supremum

**Locate.** *"with supremum $1/\sqrt{m-1}$ attained at the pair-concentrated $h$."*

**Exhibit.** Take $m=6$ and the literally pair-concentrated $h=\mathrm{diag}(1,1,0,0,0,0)$. Fed to the box's own two displays: $\lVert H\rVert_{op}=\tfrac35\cdot2=\tfrac65$ and $\lVert H\rVert_F^2=\tfrac{24}{10}\cdot2=\tfrac{24}5$, so $\lVert H\rVert_{op}/\lVert H\rVert_F=\tfrac{6/5}{\sqrt{24/5}}=\sqrt{\tfrac{6}{20}}=0.5477$, against the box's supremum $1/\sqrt5=0.4472$, larger by exactly $\sqrt{m/(m-2)}=\sqrt{3/2}=1.2247$.

**Argue the opposite.** $h\in S^2_0(\mathbb R^m)$ is a standing hypothesis of the box, and $\mathrm{diag}(1,1,0,\dots,0)$ is not traceless, so it is outside the quantifier; the Frobenius display was derived using tracelessness and has no meaning there. The intended $h$ is the traceless projection of $e_1+e_2$, namely $h^*\propto(m-2,m-2,-2,\dots,-2)$.

**Disposition.** Withdrawn as an error; **retained as a naming defect**, and it is exactly the shape the round pre-registered, a supremum apparently attained outside the admissible set. Under the correct reading the supremum is attained *inside* it; see §6.

**The supremum, derived.** Maximising the linear functional $h\mapsto h_1+h_2$ over the traceless sphere gives $\lVert(e_1+e_2)_\perp\rVert=\sqrt{2-\tfrac4m}=\sqrt{\tfrac{2(m-2)}m}$. With $\lVert H\rVert_F=1$, i.e. $\lVert h\rVert^2=\tfrac{2(m-1)}{m(m-2)}$,
$$M_2^{\max}=\sqrt{\tfrac{2(m-2)}m}\cdot\sqrt{\tfrac{2(m-1)}{m(m-2)}}=\frac{2\sqrt{m-1}}m,\qquad \lVert H\rVert_{op}=\frac m{2(m-1)}\cdot\frac{2\sqrt{m-1}}m=\frac1{\sqrt{m-1}} .$$
**Claim 6 CONFIRMED**, and it is a maximum, not merely a supremum.

**The floor.** $M_2^2\ge\dfrac{\sum_{a<a'}(h_a+h_{a'})^2}{\binom m2}=\dfrac{2(m-2)\lVert h\rVert^2}{m(m-1)}=\dfrac4{m^2}$, so $M_2\ge\tfrac2m$ and $\lVert H\rVert_{op}\ge\tfrac m{2(m-1)}\cdot\tfrac2m=\tfrac1{m-1}$. The even split $h\propto(1,\dots,1,-1,\dots,-1)$ gives $\lVert H\rVert_{op}=\sqrt{\tfrac2{(m-1)(m-2)}}$, which exceeds $\tfrac1{m-1}$ by the factor $\sqrt{\tfrac{2(m-1)}{m-2}}>1$. **The two "conflicting" lower bounds do bracket one infimum, exactly as the entry says**, and both are $\Theta(n^{-1})$. With $\lVert H\rVert_{op}$ continuous on the connected unit sphere of $S^2_0(\mathbb R^m)$, its image is the interval $[\Theta(n^{-1}),1/\sqrt{m-1}]$. **Claim 7 CONFIRMED**, and "ranges over" is literally right.

## 6. The pre-registered questions

### Q1, does the envelope hold where the consumers use it?

The constant is used downstream as $a_0n^{-1/2}$ with $a_0=\sqrt{2n/(n-2)}$, so $a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$, **one quantity written two ways, at its exact finite-$n$ value.** I checked for the block's recorded habit of reading a constant at its $n\to\infty$ endpoint and using it at finite $n$: **it is not committed here.** Had $a_0^2$ been frozen at $2$, the kink would come out $\tfrac{n-2}{n+2}$ rather than $\tfrac{n-4}n$.

| consumer | what it takes | does the box reach it |
|---|---|---|
| [L149](../findings/second-order.md), $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ at every $w\in[0,1]$ | $\lVert H_s\rVert_{op}\le\tfrac1{\sqrt{m-1}}\lVert H_s\rVert_F$ with $H_s$ in the **joint** two-copy eigenspace and $\lVert H_s\rVert_F=\sqrt{1-w^2}\le1$ | **Only after two extensions the box does not carry**: homogeneity (the box fixes $\lVert H\rVert_F=1$) and single copy $\to$ joint. L149 supplies both in its own text (it says "which is homogeneous" and restates the cross-branch cap) so **this consumer is safe** |
| [L158](../findings/second-order.md) and [results.md](../results.md), the envelope at the kink $w_0=\tfrac{n-4}n$ | the same constant, and nothing else from L146 | **Same two extensions, and neither consumer restates them.** They write $a_0n^{-1/2}$ bare |
| the Cauchy estimate over the complex disc $\lvert z\rvert=\rho\asymp g_n/\lVert H\rVert_{op}$ | $\lVert zH\rVert_{op}=\lvert z\rvert\,\lVert H\rVert_{op}<g_n$ for the **complexified** operator | **Reaches**, because $H$ is a real symmetric endomorphism of $\Lambda^2\mathbb R^n$, diagonal in a real orthonormal basis, so its $\mathbb C$-linear extension has the same operator norm and $W^*+zH$ stays invertible. The box never says $H$ is such an operator, that lives in the embedding box |

I confirmed the kink arithmetic by hand from L146's constant alone. With $a^2=a_0^2/n=\tfrac2{n-2}$, solving $a\sqrt{1-w^2}+w=1$ off $w=1$ gives $w_0=\tfrac{1-a^2}{1+a^2}=\tfrac{n-4}n$; and $1-w_0^2=\tfrac{8(n-2)}{n^2}$ gives $\phi'(w_0)=1-\tfrac{aw_0}{\sqrt{1-w_0^2}}=1-\tfrac{n-4}{2(n-2)}=\tfrac n{2(n-2)}$, which is $\tfrac35$ at $n=12$ and $\tfrac7{12}=0.5833$ at $n=14$, **both matching [L157](../findings/second-order.md) and [results.md](../results.md) exactly.** L146's number propagates correctly.

The one caveat on the third row is not L146's: [L148](../findings/second-order.md) records two live complexification debts standing on top of that disc, that "$x\mapsto x_-$ is $1$-Lipschitz" is sourced *on Hermitian operators* while $W^*+zH$ is complex symmetric, and that L146's disc is at $\gamma=1$, L156's excluded endpoint, against $\gamma^*=D/4$. **No finding against L146**, which asserts only that the disc is $\Omega(n^{-1/2})$; recorded because a reader taking L146's disc into a Cauchy estimate inherits both.

### Q2, is the supremum attained, and is the attaining direction admissible?

**Attained, and admissible.** $h^*\propto(m-2,m-2,-2,\dots,-2)$ lies in $S^2_0(\mathbb R^m)$, hence in the summand; by L27 it is therefore orthogonal to $\langle W^*\rangle$ and to $T_{W^*}\mathcal O=\mathbb R^m\otimes\mathbb R^m$, since $L_e$ is symmetric, scalar on each of ten multiplicity-free summands, and $\lambda_m\notin\{1,\tfrac12\}$. It has $\lVert H\rVert_F=1$ and $\lVert H\rVert_{op}=1/\sqrt{m-1}<1$, so it satisfies **all four** of [L147](../findings/second-order.md)'s named hypotheses. It is not orbit-tangent, and the block's earlier orbit-tangent failure is not repeated. The only route out of the admissible set is the misreading of §5.

## 7. The edges

- **Smallest admissible dimension, $m=3$.** The two displays are true there, I checked directly: $\alpha=\tfrac14$, $\beta=\tfrac34$, $M_2\equiv M_1$, $\lVert H\rVert_{op}$ ranges over $[\tfrac{\sqrt3}2\cdot\tfrac1{\sqrt2},\tfrac{\sqrt3}2\sqrt{\tfrac23}]=[0.6124,0.7071]$ with $\sup=1/\sqrt2=1/\sqrt{m-1}$ and floor $\tfrac1{m-1}=0.5$ respected. **But the Setting is false there**: $\lambda_3=\tfrac14<\mu=\tfrac12$, so the off-orbit maximum of $L_e$ sits on $\Lambda^2\otimes\Lambda^2$, the margin is zero, and $(3,3)$ is precisely the case the cited [L27](../findings/nondegeneracy.md) excludes. At $m=4$, $\lambda_4=\mu=\tfrac13$ ties, so "puts the margin maximum on the two $S^2_0$ summands" is not exclusive either.
- **$m=2$** is correctly excluded: $\alpha=0$ and $h_1+h_2=0$, so $H\equiv0$ and $\lVert H\rVert_F=0$. $m\ge3$ is the exact floor for the algebra.
- **The dimension floors across the block.** None in [L145](../findings/second-order.md)'s box, $m\ge3$ here, $m\ge5$ in this entry's own order-level box, $m\ge5$ for the word "margin" in L148, $m\ge6$ in L149. The box's $m\ge3$ is the widest, and it is the one a citation reads.
- **Odd $n$** is outside the statement by construction: $n=2m$ is a definition at the balanced product, not a hypothesis to test. **Odd $m$** ($m=7$, $n=14$, inside every consumer's range), is in scope and every claim above survives it; only the narrative's "even split" does not (§8).
- **$\ker W\ne0$.** L146 is at $W^*=S^m\times S^m$ alone, whose spectrum L145 records as two-valued with no kernel, and $g_n$ is that gap. $H$ itself always has kernel $\supseteq\Lambda^2V_2$, of dimension $\binom m2$, harmless, since nothing here assumes $H$ invertible. The record's $\ker W\ne0$ object, $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$, sits at $n=4$ and at a different base point; L148 says in terms that it asserts nothing there. **No finding: L146's silence about it is correct.**

## 8. Candidate C, "the even split" does not exist at odd $m$

**Locate.** *"And the even split is beaten only up to $m=6$, the spike witness winning exactly when $m^2-8m+8<0$; at $m\ge7$ that witness loses."*

**Derivation first.** For the spike $h=(m-1,-1,\dots,-1)$ with $m\ge4$: $\lVert h\rVert^2=m(m-1)$, $M_2=m-2$, so $\lVert H\rVert_{op}/\lVert H\rVert_F=\tfrac{\sqrt{m-2}}{\sqrt2(m-1)}$. For the even split: $\sqrt{\tfrac2{(m-1)(m-2)}}$. Squaring and clearing $2(m-1)^2(m-2)>0$, spike $<$ even split $\iff(m-2)^2<4(m-1)\iff m^2-8m+8<0$, whose roots are $4\pm2\sqrt2$, so the integer range is $m\le6$. **Claim 11 CONFIRMED exactly, as an inequality between two closed forms.**

**Exhibit.** At $m=7$ the even split does not exist. The best two-valued split, $j=3$ against $4$, gives $M_2/\lVert h\rVert=\tfrac{8}{\sqrt{84}}=0.8729$, while the spike gives $\tfrac5{\sqrt{42}}=0.7715$. So at $m=7$ the spike **wins** against every realisable split of that family, and "at $m\ge7$ that witness loses" is false at the first dimension it names, under the reading that the comparison is between witnesses one can exhibit.

**Argue the opposite.** The sentence compares two closed forms and stakes nothing on realisability; $m^2-8m+8>0$ at $m=7$ is true, and the whole paragraph closes with *"Both bounds are $\Theta(n^{-1})$, so the order is untouched either way"*, which is correct and is all the LEMMA box needs. Nothing in the box depends on this sentence.

**Disposition.** **Withdrawn as a discrepancy; recorded as a precision note.** Two smaller points ride with it. First, "both bounds are $\Theta(n^{-1})$" is true of the pair actually named two sentences earlier (the floor $\tfrac1{m-1}$ and the even split), and would be false of the pair the intervening sentence discusses, the spike is $\tfrac{\sqrt{m-2}}{\sqrt2(m-1)}=\Theta(n^{-1/2})$, the same order as the supremum and only $1/\sqrt2$ below it. Second, **I could not fix the referent of "the clause has no proof"**; no clause in the entry is left standing on that comparison, so I record the ambiguity rather than a defect.

**And the unnamed family, reconstructed.** *"though a different family reaches $m=8$."* Take $h=e_1-e_m=(1,0,\dots,0,-1)$: traceless, $M_2=1$, $\lVert h\rVert=\sqrt2$, so $M_2/\lVert h\rVert=1/\sqrt2$ for **every** $m$. Against the even split's $2/\sqrt m$ the two are equal exactly when $\sqrt m=2\sqrt2$, i.e. **$m=8$**, and $e_1-e_m$ beats the even split for every $m<8$. **Claim 12 CONFIRMED**, by hand and in closed form. The entry could have named this family in six characters and did not, which cost me the derivation.

## 9. The two-copy box, and Candidate D, the citable statement prices one copy where all three consumers use two

**The joint operator norm, derived.** For $H=W(h)+W(k)$ with $h$ on $V_1$ and $k$ on $V_2$, both diagonal in one frame, the branches are $\alpha(h_a+k_b)$ on cross planes, $-\beta(h_a+h_{a'})$ inside $B_1$, $-\beta(k_b+k_{b'})$ inside $B_2$, so
$$\lVert H\rVert_{op}=\max\big(\alpha\max_{a,b}\lvert h_a+k_b\rvert,\ \beta M_2(h),\ \beta M_2(k)\big),$$
and $\langle W(h),W(k)\rangle=\alpha^2(\sum_ah_a)(\sum_bk_b)=0$, so $\lVert H\rVert_F^2=\tfrac{m(m-2)}{2(m-1)}(\lVert h\rVert^2+\lVert k\rVert^2)$. The entry states neither, and both are what a consumer on the joint eigenspace wants.

**The witnesses.** At $m=5$, $\alpha=\tfrac38$, $\beta=\tfrac58$, $h=k=(1,0,0,0,-1)$: cross $\tfrac38\cdot2=\tfrac34$ against in-block $\tfrac58\cdot1=\tfrac58$. At $m=6$, $\alpha=\tfrac25$, $\beta=\tfrac35$, $h=k=(1,-\tfrac15,\dots,-\tfrac15)$: cross $\tfrac25\cdot2=\tfrac45$ against in-block $\tfrac35\cdot\tfrac45=\tfrac{12}{25}$. **Claim 8 CONFIRMED, both exactly.** (Both are unnormalised; the comparison is scale-invariant, so this is sound, though the box that hosts it normalises $\lVert H\rVert_F=1$.)

**The cap.** Maximising $h_1+k_1$ subject to $\lVert h\rVert^2+\lVert k\rVert^2=R^2=\tfrac{2(m-1)}{m(m-2)}$: each of $\max h_1,\max k_1$ is $r\sqrt{\tfrac{m-1}m}$ at radius $r$, and $r_h+r_k\le R\sqrt2$, so the cross branch is at most $\alpha\cdot\sqrt2R\sqrt{\tfrac{m-1}m}=\tfrac{m-2}{2(m-1)}\cdot\tfrac{2(m-1)}{m\sqrt{m-2}}=\tfrac{\sqrt{m-2}}m$, **attained**. And $\tfrac{\sqrt{m-2}}m<\tfrac1{\sqrt{m-1}}\iff(m-1)(m-2)<m^2\iff 3m>2$. The in-block branch on the joint space is maximised by putting all the norm in one copy, returning $1/\sqrt{m-1}$. **Claim 9 CONFIRMED**, cap and reason both. At $n=12$ these are $\tfrac{\sqrt4}6=\tfrac13$ and $\tfrac1{\sqrt5}=0.4472$, the two numerals [L149](../findings/second-order.md) quotes, **both exact**.

**Candidate D. Locate:** the LEMMA box's *"the Weyl image of a **single** $h$"*. **Exhibit:** the margin summand is $\Sigma=S^2_0(V_1)\oplus S^2_0(V_2)$ of dimension $(m+2)(m-1)$, and every consumer quantifies over $\Sigma$; the $m=5$ and $m=6$ witnesses above show the box's equality clause is false there, so a consumer who cites the box on $\Sigma$ cites a false sentence. **Argue the opposite:** the *supremum* clause does survive on $\Sigma$, that is the only clause the consumers use, and the licence for it sits in the box immediately above, which is why the entry writes *"the line licensing it lives here rather than being assumed"*. **Disposition: retained as a scope defect of the citable statement.** It is the round's named trap, and its status is asymmetric across consumers: [L149](../findings/second-order.md) restates the licence in its own text and is safe; [L158](../findings/second-order.md) and [results.md](../results.md) write $a_0n^{-1/2}$ bare and rest on a box they do not cite.

## 10. The two forms

**[results.md](../results.md) carries no L146 at all**, nor L145, nor L147, nor L148. The absence is uniform across the tube sub-block below L149, so as a promotion decision it is consistent, and [Lemma L148](../findings/second-order.md)'s own verdict (*"the operator norm computed here prices a quantity that is not present"*), is a reason not to promote it.

**The absence is nevertheless not fully correct.** The [Lemma L158](../results.md) row consumes L146's constant: it writes *"the envelope being $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$ and equal to $1$ above $w_0$"*. The string `a_0n^{-1/2}` occurs **exactly once** in results.md, $a_0$ is defined nowhere in that file, and there is no pointer to the entry that establishes it. A reader of results.md alone cannot recover $a_0=\sqrt{2n/(n-2)}$, and therefore cannot check $w_0=\tfrac{n-4}n$ or $\phi'(w_0)=\tfrac n{2(n-2)}$, both of which that same row asserts. **Finding: results.md owes either L146's constant inline or a link to it.**

## 11. Every numeral, and which I could not reproduce

**Reproduced exactly, by hand:** $\alpha$, $\beta$, $\beta/\alpha=\tfrac m{m-2}$; $\mathrm{Ric}=m\,h$; the three eigenvalue branches; $\tfrac{m(m-2)}{2(m-1)}$; $\tfrac{m-2}{m-1}$ and the witness $(3,-1,-1,-1)$ at $2$ against $3$; $1/\sqrt{m-1}$; $\tfrac1{m-1}$; $\sqrt{2/((m-1)(m-2))}\approx\sqrt2/m$; $\sqrt{m-1}/m$ and the factor $m/(m-1)$; the disjointness of $[0.4082,0.4714]$ from $[0.6124,0.7071]$ at $m=3$; $m^2-8m+8<0\Rightarrow m\le6$; the $m=8$ crossing; $\tfrac34$ against $\tfrac58$; $\tfrac45$ against $\tfrac{12}{25}$; $\sqrt{m-2}/m$ and $(m-1)(m-2)<m^2$; $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$; $\lambda_m>\mu\iff m\ge5$ with $\mu=\tfrac1{m-1}$ re-derived from L27's $\tfrac12-\mu$; $g_n/\lVert H\rVert_{op}=\Omega(n^{-1/2})$ and the factor $\sqrt n$; $O(n^{1/2})$ against $O(1)$ and their coincidence at $O(n)$ when $\rho=\Theta(g_n)$. **Downstream, from L146's constant:** $a_0=\sqrt{2n/(n-2)}$, $w_0=\tfrac{n-4}n$, $\phi'(w_0)=\tfrac n{2(n-2)}$ at $\tfrac35$ and $\tfrac7{12}$, $\sqrt{m-2}/m=\tfrac13$ and $1/\sqrt{m-1}=0.4472$ at $n=12$, $\kappa=3\sqrt{2(n-1)/(n-2)}=4.4497$ at $n=12$.

**Could not reproduce:** no numeral. Two non-numerical items resisted: the referent of *"the clause has no proof"* (§8), and the identity of *"a different family"*, which the entry never names and which I reconstructed rather than read.

## 12. What would falsify the statement, and what I did to look for it

Three objects would break it, and each is closed off by an identity rather than an estimate.

1. **A traceless $h$ with $\beta M_2<\alpha M_1$**, breaking "the in-block branch always winning". Excluded: $M_2/M_1\ge\tfrac{m-2}{m-1}$ is forced by $\max_{a\ge2}h_a\ge-\tfrac{h_1}{m-1}$, against the available $\beta/\alpha=\tfrac m{m-2}$.
2. **A traceless $h$ with $\lVert H\rVert_{op}/\lVert H\rVert_F>1/\sqrt{m-1}$**, breaking the supremum. Excluded: the maximum of $h\mapsto h_1+h_2$ on the traceless sphere is the exact norm $\sqrt{2(m-2)/m}$ of the projected functional, and on the joint two-copy space the only extra branch is capped at the exact $\sqrt{m-2}/m$.
3. **A traceless $h$ with $\lVert H\rVert_{op}/\lVert H\rVert_F=o(n^{-1})$**, breaking the bottom of the range. Excluded by the identity $\sum_{a<a'}(h_a+h_{a'})^2=(m-2)\lVert h\rVert^2$ over $\binom m2$ pairs.

I searched for all three in closed form, over the diagonal families the entry names (spike, even split, pair-concentrated), over the two families it does not (the near-even split at odd $m$, and $e_1-e_m$), and over the joint two-copy space. **No such object exists.** The only objects I found that break anything break the *wording*: $e_1\odot e_2$ at $m=6$, which the box's undefined $h_a$ sends to a contradiction between its own two displays (§4), and $\mathrm{diag}(1,1,0,\dots,0)$ at $m=6$, which the box's "pair-concentrated" invites and which overshoots its supremum by $\sqrt{m/(m-2)}$ (§5).

## Verdict

**`PROVEN, hypotheses corrected`.**

The mathematics is right. Every display in the LEMMA box, and every numeral in the boxes around it, reproduced exactly from the constants the entry names, including two claims the entry asserts without argument and which I derived independently, the exact cross-branch cap $\sqrt{m-2}/m$, and the family behind "reaches $m=8$".

What is owed is to the citable statement, and it is four amendments, not four arguments, every one of them already has an argument on file, in a neighbouring box of this entry or in [L148](../findings/second-order.md) and [L149](../findings/second-order.md). **I have edited no source file; my remit this round is my own report.**

1. **Say what $h_a$ is** (the eigenvalues of $h$, the frame chosen after $h$) or restrict the quantifier to diagonal $h$. Without it the box's two displays contradict each other at $h=e_1\odot e_2$. This is the repair [L148](../findings/second-order.md) received and L146 did not.
2. **Name the attaining direction**, $h^*\propto(m-2,m-2,-2,\dots,-2)$. "The pair-concentrated $h$" read literally is not traceless and overshoots the stated supremum.
3. **Say that the bound is homogeneous, and that the supremum survives on the joint two-copy eigenspace** with the cross branch capped at $\sqrt{m-2}/m$. Both extensions are used by all three consumers; only [L149](../findings/second-order.md) currently restates them.
4. **Carry the floor the framing needs.** The two displays are true at $m\ge3$; the Setting that makes them relevant needs $m\ge5$, and at the box's own floor $m=3$ the [L27](../findings/nondegeneracy.md) it cites is the excluded $(3,3)$.

And one outside the entry: **[results.md](../results.md) uses $a_0$ once, defines it nowhere, and links to no L146.** Either the constant or the pointer belongs in that row.
