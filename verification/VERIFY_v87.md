# VERIFY v87, Lemma L146-r2: the Weyl image of a single $h\in S^2_0(\mathbb R^m)$, its two norms, the supremum $1/\sqrt{m-1}$, and the three boxes around it

*Cold read of [ROUND_L146-r2](ROUND_L146r2.md)'s dispatched brief, quoted from [findings/second-order.md](../findings/second-order.md):1131–1162. Which passages are repairs was not marked and I did not try to guess. **No numerical work was done: no script was run, and every value below is an exact hand evaluation**, given in closed form with the decimal, if any, as a gloss. Log: [agent_logs/verify-L146r2-v87.log](../agent_logs/verify-L146r2-v87.log).*

## Claim table

| # | Claim, as the entry states it | Verdict |
|---|---|---|
| C1 | $\mathrm{Ric}(h\owedge g_q)=m\,h\ne0$, so the projection term survives | **BROKEN**, the value is $(m-2)h$; the entry's own $\alpha$, $\beta$ and $\lVert H\rVert_F^2$ all require $(m-2)$ |
| C2 | Weyl image diagonal on coordinate $2$-planes, eigenvalues $\alpha h_a$ / $-\beta(h_a+h_{a'})$ / $0$ | **PROVEN** (up to one global sign, which no norm sees) |
| C3 | $\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ | **PROVEN**, exactly reproduced |
| C4 | $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\ge\frac{m-2}{m-1}\max_a\lvert h_a\rvert$, sharp at $h=(3,-1,-1,-1)$ | **PROVEN**, and the witness is exact |
| C5 | $\lVert H\rVert_{op}=\frac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$, in-block branch always winning | **PROVEN**, with strict margin $m/(m-1)$ |
| C6 | supremum $1/\sqrt{m-1}$, attained at the pair-concentrated $h$ | **PROVEN**, and attained inside the consumers' domain |
| C7 | $\lVert H\rVert_{op}$ ranges over $[\Theta(n^{-1}),\Theta(n^{-1/2})]$ | **PROVEN** |
| C8 | joint two-copy: cross branch $\alpha(h_a+k_b)$; $\tfrac34$ vs $\tfrac58$ at $m=5$, $\tfrac45$ vs $\tfrac{12}{25}$ at $m=6$ | **PROVEN**, all four numerals exact |
| C9 | cross branch caps at $\sqrt{m-2}/m<1/\sqrt{m-1}$, so the supremum is unchanged | **PROVEN**, and the cap is sharp (attained at $m=6$) |
| C10 | $\lVert H\rVert_{op}=O(n^{-1/2})$ throughout the summand, disc $\Omega(n^{-1/2})$, a factor $\sqrt n$ over $g_n$ | **PROVEN** at order; the disc is written at its own excluded endpoint |
| C11 | "$\lambda_m>\mu$ … holds for $m\ge5$; $n\ge12$ is inside that" | **PROVEN**, exactly |
| C12 | the spike beats the even split exactly when $m^2-8m+8<0$ | **PROVEN**, exactly |
| C13 | [L27](../findings/nondegeneracy.md) puts the off-orbit margin **maximum** on the two $S^2_0$ summands | **BROKEN**, it is the margin **minimum**; the record says so in three other places |
| C14 | "[L148](../findings/second-order.md) **displaces this lemma entirely**… what it establishes is nothing" | **BROKEN**, L146's $a_0$ fixes L157/L158's binding minimiser and its one-sided derivative |
| C15 | the citable box, read alone, reaches L149's use of it | **HYPOTHESIS-DEBT**, the box covers one copy at unit norm; L149 needs both copies at every norm |
| C16 | [results.md](../results.md) carries a canonical L146 | absent; the absence is **a record inconsistency**, but no citation inherits a stale scope |

**One line.** Every displayed formula in the boxed lemma is correct and I re-derived each from scratch; what fails is around it, one Ricci numeral that contradicts the box two lines below it, one extremum word inverted, one self-effacement that is false, and a citable statement narrower than the use three entries make of it.

## 0. Conventions, fixed once

The entry states none of these. I fixed them by requiring the entry's own $\lVert H\rVert_F^2$ to come out, and every one of them is forced.

- $V=\mathbb R^n=V_1\oplus V_2$, $\dim V_1=\dim V_2=m$, $n=2m$; $B_1,B_2$ the index sets; $g_q$ the orthogonal projector onto $V_1$ read as a symmetric form, $g=g_q+g_{q'}$.
- $h\in S^2_0(\mathbb R^m)$ is carried on $V_1$ and extended by zero; diagonal entries $h_1,\dots,h_m$ with $\sum_ah_a=0$.
- Kulkarni–Nomizu $(h\owedge k)_{abcd}=h_{ac}k_{bd}+h_{bd}k_{ac}-h_{ad}k_{bc}-h_{bc}k_{ad}$, matching the record's projector $P(X)=Y-\frac2{n-2}\mathrm{KN}(\rho_0)-\frac{s}{n(n-1)}\mathrm{KN}(g)$ with $\mathrm{KN}(h)=\frac12(h\owedge g)$, [nondegeneracy.md:375](../findings/nondegeneracy.md).
- $H$ is read as an operator on $\Lambda^2V$ in the orthonormal basis $\{e_a\wedge e_b\}_{a<b}$; $\lVert H\rVert_{op}=\max$ modulus of its eigenvalues and $\lVert H\rVert_F^2=\sum_{a<b}\lambda_{ab}^2=\frac14\sum_{ijkl}H_{ijkl}^2$.

**That last one is load-bearing and unstated.** Under the competing convention $\lVert H\rVert_F^2=\sum_{ijkl}H_{ijkl}^2$ both of the box's displays change: the first constant becomes $\frac{2m(m-2)}{m-1}$ and the supremum becomes $\frac1{2\sqrt{m-1}}$. The box's own first display is what pins the choice, so the entry is self-consistent, but a consumer who imports the second display without the first imports it at the wrong scale.

## 1. Hypothesis inventory

**Carried by the boxed statement, and used.**

| Hypothesis | Where the proof uses it |
|---|---|
| $H$ is the Weyl image of a **single** $h$ | the whole eigenvalue list; the equality clause is false without it (§7) |
| $h\in S^2_0$, i.e. traceless | twice: it makes $\mathrm{Ric}$ traceless so $s=0$ and the third Weyl term drops (§2), and it is the entire content of C4 (§4) |
| $\lVert H\rVert_F=1$ | the supremum only; it **over-constrains** the two displays, which are homogeneous identities (§3) |
| $n=2m$ | $n-2=2(m-1)$, which is where $\alpha$'s denominator comes from |
| $m\ge3$ | $\frac{m(m-2)}{2(m-1)}$ vanishes at $m=2$, so $\lVert H\rVert_F=1$ is unsatisfiable there; and $\mathrm{Ric}\ne0$ needs $m\ge3$ once C1 is repaired |

**Used by the proof, absent from the statement.**

1. **The embedding itself.** The box says "the Weyl image of a single $h\in S^2_0(\mathbb R^m)$" for an $H$ living on $\Lambda^2\mathbb R^{2m}$. The map is $h\mapsto \mathcal P_{\mathrm{Weyl}}(h\owedge g_q)$ and it exists only after the splitting $V_1\oplus V_2$ is chosen. Read alone, the box does not say which map "Weyl image" names. Everything else in the box is a statement about that map.
2. **The base point.** $W^*=S^m\times S^m$ appears in the Setting and in no box. The algebra does not need it; the third box's analyticity disc does.
3. **The Frobenius convention**, §0.
4. **$\ker W^*=0$**, needed by the "ORDER-LEVEL CONCLUSION" box, since $W\mapsto W_-$ is analytic at $W^*$ only then. It is stated in [L149](../findings/second-order.md)'s hypotheses box and in no box of L146. The record names a witness against it elsewhere, $W_{\mathbb{CP}^2}$; §10.

**Imported, and checked against the object it is applied to.**

- The record's Weyl projector, [nondegeneracy.md:375](../findings/nondegeneracy.md). Applied to $h\owedge g_q$, which is a genuine algebraic curvature tensor: Kulkarni–Nomizu products satisfy the first Bianchi identity, so $\mathrm{Alt}(h\owedge g_q)=0$ and $Y=X$. ✓
- [Lemma L27](../findings/nondegeneracy.md) for $L_e=\lambda_m$ on the two $S^2_0$ copies, and $L_e=\frac12$ exactly on $T_{W^*}\mathcal O$. Used in §6 and §13.
- [Lemma L145](../findings/second-order.md) for $c_p$, $g_n$ and the two-point spectrum.

**No finding: the boxed proof uses no hypothesis the box omits *for the algebra*.** The four omissions above are all in the entry's outer boxes or in the naming of the map, not in the derivation of the two displays.

## 2. The embedding, re-derived, and C1 is broken

$\mathrm{Ric}(h\owedge g_q)_{bd}=\sum_a(h\owedge g_q)_{abad}=(\operatorname{tr}h)(g_q)_{bd}+(\operatorname{tr}g_q)h_{bd}-(g_qh)_{bd}-(hg_q)_{bd}$. With $\operatorname{tr}h=0$, $\operatorname{tr}g_q=m$, and $g_qh=hg_q=h$ because $h$ is carried on $V_1$ where $g_q$ is the identity:

$$\mathrm{Ric}(h\owedge g_q)=(m-2)\,h .$$

It is traceless, so $s=0$ and the scalar term of the projector drops, leaving

$$H=h\owedge g_q-\frac{1}{n-2}(m-2)\,h\owedge g=\beta\,h\owedge g_q-\alpha\,h\owedge g_{q'},\qquad \alpha=\frac{m-2}{2(m-1)},\ \ \beta=1-\alpha=\frac{m}{2(m-1)} .$$

Both of the entry's constants come out, and they come out **from $(m-2)$**.

> **Discrepancy D1, located.** "$\mathrm{Ric}(h\owedge g_q)=m\,h\ne0$", first line of the box **THE EMBEDDING, CORRECTED**.

> **Exhibited.** Put $\mathrm{Ric}=mh$ into the record's own projector and the subtracted coefficient is $\frac{m}{2(m-1)}=\beta$, not $\alpha$; then $H=\alpha\,h\owedge g_q-\beta\,h\owedge g_{q'}$ and the entry's displayed eigenvalue list has $\alpha$ and $\beta$ **interchanged**. The consequence is checkable in one line at $m=4$: the interchanged list gives $\lVert H\rVert_F^2=\big[m\beta^2+(m-2)\alpha^2\big]\lVert h\rVert^2=\frac{m^3+(m-2)^3}{4(m-1)^2}\lVert h\rVert^2=\frac{64+8}{36}\lVert h\rVert^2=2\lVert h\rVert^2$, against the box's own $\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2=\frac43\lVert h\rVert^2$ two lines below. So the entry's own lemma refutes the entry's own Ricci.

> **The opposite, argued.** The most charitable reading is that "$m$" is the surviving trace $\operatorname{tr}g_q=m$ and the two $hg_q$ terms were dropped, a slip of the pen with the right qualitative content ($\ne0$). The clause is used for nothing else: the sentence's job is to say the projection term survives. But the numeral is also the only place the entry says where $\alpha$ comes from, and at $m=2$ it says $\mathrm{Ric}\ne0$ where the truth is $\mathrm{Ric}=0$, i.e. the correct value is what makes $m\ge3$ the right floor, and the stated one hides that. **The discrepancy stands.**

**Eigenvalues.** For $h,k$ both diagonal in one frame, $(h\owedge k)_{abcd}$ is nonzero only when $\{a,b\}=\{c,d\}$, so $H$ is diagonal on coordinate $2$-planes with $(h\owedge k)_{abab}=h_ak_b+h_bk_a$. Hence

$$H\big|_{e_a\wedge e_{a'}}=\beta(h_a+h_{a'})\ (a,a'\in B_1);\qquad H\big|_{e_a\wedge e_b}=-\alpha h_a\ (a\in B_1,b\in B_2);\qquad H\big|_{e_b\wedge e_{b'}}=0 .$$

This is the entry's list times $-1$. C2 **PROVEN**; the global sign is a convention on the curvature operator and no norm in the entry sees it. *No finding.*

## 3. The two displays

Counting: $m^2$ cross planes, $\binom m2$ in each block, total $2m^2-m=\binom{2m}2$. ✓

$$\sum_{a<a'}(h_a+h_{a'})^2=\tfrac12\Big[2(m-1)\lVert h\rVert^2+2\big((\textstyle\sum h_a)^2-\lVert h\rVert^2\big)\Big]=(m-2)\lVert h\rVert^2$$

using $\sum h_a=0$. So

$$\lVert H\rVert_F^2=\big[m\alpha^2+(m-2)\beta^2\big]\lVert h\rVert^2=\frac{m(m-2)\big[(m-2)+m\big]}{4(m-1)^2}\lVert h\rVert^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2 .$$

C3 **PROVEN**, exactly as written. Since $H$ is diagonal, $\lVert H\rVert_{op}=\max\big(\alpha\max_a\lvert h_a\rvert,\ \beta\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\big)$, which C5 then resolves.

> **Scope note S1.** Both displays are $1$- and $2$-homogeneous identities in $h$, valid at every scale. The box states them under its hypothesis $\lVert H\rVert_F=1$, which makes the first display a determination of $\lVert h\rVert$ rather than an identity. [L149](../findings/second-order.md) uses the homogeneous form ("which is homogeneous so $\lVert H_s\rVert_F<1$ only helps") and the box does not carry it. One line of scaling repairs it; the box does not contain that line.

## 4. The in-block branch dominates

Order so that $\lvert h_1\rvert=\max_a\lvert h_a\rvert$; both sides are invariant under $h\mapsto-h$, so take $h_1>0$. Write $M_2=\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$. Summing $\lvert h_1+h_{a'}\rvert\le M_2$ over the $m-1$ indices $a'\ne1$ and using $\sum_{a'\ne1}h_{a'}=-h_1$:

$$(m-2)h_1=\Big\lvert(m-1)h_1-h_1\Big\rvert=\Big\lvert\sum_{a'\ne1}(h_1+h_{a'})\Big\rvert\le(m-1)M_2 .$$

C4 **PROVEN**. Sharpness: $h=(3,-1,-1,-1)$ at $m=4$ is traceless, has pair sums $\{2,-2\}$ so $M_2=2$, entry maximum $3$, and $\frac{m-2}{m-1}=\frac23$, equality, exactly the entry's witness. Then with $\beta/\alpha=\frac m{m-2}$,

$$\beta M_2\ \ge\ \alpha\cdot\frac m{m-2}\cdot\frac{m-2}{m-1}\max_a\lvert h_a\rvert=\frac m{m-1}\,\alpha\max_a\lvert h_a\rvert\ >\ \alpha\max_a\lvert h_a\rvert .$$

C5 **PROVEN**, strictly, with the stated margin. *No finding.*

## 5. The supremum, and question 2

Normalising, $\lVert H\rVert_F=1$ means $\lVert h\rVert=r:=\sqrt{\frac{2(m-1)}{m(m-2)}}$. The functional $h\mapsto h_1+h_2$ on the traceless hyperplane has norm $\lVert e_1+e_2-\frac2m\mathbf 1\rVert=\sqrt{2-\frac4m}=\sqrt{\frac{2(m-2)}m}$, so

$$\max_{\lVert h\rVert=r}\ \max_{a\ne a'}\lvert h_a+h_{a'}\rvert=r\sqrt{\tfrac{2(m-2)}m}=\frac{2\sqrt{m-1}}m,\qquad \lVert H\rVert_{op}=\frac m{2(m-1)}\cdot\frac{2\sqrt{m-1}}m=\frac1{\sqrt{m-1}} .$$

C6 **PROVEN**. The maximiser is $h=t(1,1,-\tfrac2{m-2},\dots,-\tfrac2{m-2})$ with $t=r\sqrt{\frac{m-2}{2m}}$ (the entry's "pair-concentrated $h$") and it is a genuine maximum, the objective being continuous on a compact sphere.

**Pre-registered question 2, answered.** *Attained*: yes, in closed form above. *Inside the consumers' domain*: yes, and the reason is not in this entry. The consumers quantify over $T_{W^*}S\cap T_{W^*}\mathcal O^{\perp}$, i.e. $\lVert H\rVert_F=1$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$. By [L27](../findings/nondegeneracy.md), $L_e$ equals $\frac12$ **exactly** on $T_{W^*}\mathcal O$, and $\lambda_m=\frac{m-2}{2(m-1)}<\frac12$ at every finite $m$; $L_e$ is symmetric, so distinct eigenvalues give orthogonal eigenspaces and the *whole* summand (extremiser included), is orthogonal to the orbit tangent. $W^*$ sits in a different summand again, the one [L149](../findings/second-order.md) records as carrying $\langle W\rangle$'s negative margin. **So the block's earlier failure mode (a claim false at an orbit-tangent direction), is not repeated here.** The finding is that **L146 supplies none of this**: it names no orthogonality hypothesis and gives no admissibility argument, and a reader who wants one must go to L149's margin box.

## 6. The order interval, and the two lower bounds

Minimising instead of maximising is the same as maximising $\lVert h\rVert$ over the polytope $\{\sum h_a=0,\ \lvert h_a+h_{a'}\rvert\le1\}$, whose value I write $L_m$; then $\min\lVert H\rVert_{op}=\frac m{2(m-1)}\cdot\frac{r}{L_m}$. Sorting $h_1\ge\dots\ge h_m$ forces $h_a\in[-\frac12,\frac12]$ for $2\le a\le m-1$ and hence $\lvert h_1\rvert,\lvert h_m\rvert\le\frac32$, so $L_m^2\le\frac{m-2}4+\frac92$. With $r=\Theta(m^{-1/2})$ this gives $\min\lVert H\rVert_{op}=\Theta(m^{-1})=\Theta(n^{-1})$, and §5 gives the top end. **C7 PROVEN**, and the interval is genuinely traversed: the traceless sphere is connected for $m\ge3$ and $\lVert H\rVert_{op}$ is continuous on it.

**C12, checked exactly.** Spike $h=\big(\frac{m-1}{m-2},-\frac1{m-2},\dots\big)$ gives $L^2=\frac{m(m-1)}{(m-2)^2}$; even split $(\frac12,\dots,-\frac12)$ gives $L^2=\frac m4$. The spike wins iff $\frac{4(m-1)}{(m-2)^2}>1$ iff $m^2-8m+8<0$, roots $4\pm2\sqrt2$, so exactly $m\le6$. **PROVEN, exactly as stated**, and the corresponding values are $\frac{\sqrt{2(m-2)}}{2(m-1)}$ and $\sqrt{\frac2{(m-1)(m-2)}}\approx\frac{\sqrt2}m$, the entry's "$\approx\sqrt2/m$ attained value" reproduces.

> **Observation O1, a smaller attained value, at the programme's own dimension, and it refutes nothing.** The family $h=(1,0,\dots,0,-1)$ is traceless with pair maximum $1$ and $L^2=2$, giving
> $$\lVert H\rVert_{op}=\frac m{2(m-1)}\cdot\frac r{\sqrt2}=\frac{\sqrt m}{2\sqrt{(m-1)(m-2)}} .$$
> At $m=6$ this is $\frac{\sqrt{30}}{20}=0.273861$, below **both** values the entry lists: the spike's $\frac{\sqrt2}5=0.282843$ and the even split's $\sqrt{\frac2{20}}=0.316228$. **This is not a refutation of anything.** The entry's $\frac1{m-1}$ is a lower bound, and the block's own history records a lower bound once "refuted" by exhibiting a smaller value, the trap is named and I am not walking into it. $\frac1{m-1}=0.2$ at $m=6$ and $0.273861>0.2$, so the floor survives; what the family does is narrow the bracket the entry describes, and show that the list "the two lower bounds on file" is a list of two attained values out of at least three.

> **Candidate C-W1, WITHDRAWN.** *Located*: "**And the even split is beaten only up to $m=6$**". *Exhibited*: at $m=7$ the even-split-type optimum is $(\frac12,\frac12,\frac12,-\frac38,-\frac38,-\frac38,-\frac38)$ with $L^2=\frac{21}{16}$, against $L^2=2$ for $(1,0,0,0,0,0,-1)$; since a larger $L$ is a smaller $\lVert H\rVert_{op}$, the even split is beaten at $m=7$, by $\frac{\sqrt{210}}{60}=0.241523$ against $\frac{14\sqrt3}{3\sqrt{735}}=0.298142$. *The opposite, argued*: the sentence's subject is supplied by its own next clause ("the **spike witness** winning exactly when $m^2-8m+8<0$"), under which the statement is exactly true, and the trailing "though a different family reaches $m=8$" says in as many words that other families do better. **Withdrawn**: the charitable reading is the intended one and it is correct. It remains an elliptical subject in a bolded clause, which is how this block has produced defects before.

**On "$1/(m-1)$ is a proven floor".** No proof of it is in this entry; the entry attributes the resolution to [ROUND_L146](ROUND_L146.md). It is equivalent to $L_m^2\le\frac{m(m-1)}{2(m-2)}$, which my crude bound $L_m^2\le\frac{m-2}4+\frac92$ gives outright for $m\ge16$, and which I verified by exact hand values at $m=3$ ($2\le3$), $m=4$ ($3\le3$, **equality**), $m=5$ ($\frac{20}9\le\frac{10}3$), $m=6$ ($2\le\frac{15}4$), $m=7$ ($2\le\frac{21}5$) and $m=8$ ($2\le\frac{14}3$). **I could not reproduce a general proof from this entry**, and I record that as an attribution to be honoured rather than a debt, since the floor is used only to say both ends are $\Theta(n^{-1})$, which §6's own bound gives independently.

## 7. The joint two-copy space, and the trap

Writing the second copy's image by the same computation with $B_1,B_2$ swapped, the pair $(h,k)$ gives eigenvalues $\beta(h_a+h_{a'})$ on $\Lambda^2V_1$, $\beta(k_b+k_{b'})$ on $\Lambda^2V_2$, and $-\alpha(h_a+k_b)$ on the cross planes, **C8's third branch, exactly as claimed**, and it exists for no single $h$. The Frobenius constant is unchanged: the cross sum is $\alpha^2\sum_{a,b}(h_a+k_b)^2=\alpha^2m(\lVert h\rVert^2+\lVert k\rVert^2)$ by tracelessness, so $\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}\big(\lVert h\rVert^2+\lVert k\rVert^2\big)$.

**The two witnesses, exactly.** At $m=5$: $\alpha=\frac38$, $\beta=\frac58$, $h=k=(1,0,0,0,-1)$ has pair maximum $1$ and cross maximum $\lvert1+1\rvert=2$, giving $\beta\cdot1=\frac58$ against $\alpha\cdot2=\frac34$. At $m=6$: $\alpha=\frac25$, $\beta=\frac35$, $h=k=(1,-\frac15,\dots,-\frac15)$ has pair maximum $\frac45$ and cross maximum $2$, giving $\beta\cdot\frac45=\frac{12}{25}$ against $\alpha\cdot2=\frac45$. **All four numerals reproduce.** C8 **PROVEN**.

**C9, and it is sharp.** $\max_a\lvert h_a\rvert\le\sqrt{\frac{m-1}m}\lVert h\rVert$ (the projection of $e_a$ onto the traceless hyperplane), and $\sqrt{s_h}+\sqrt{s_k}\le\sqrt{2(s_h+s_k)}$, so at $\lVert H\rVert_F=1$, i.e. $\lVert h\rVert^2+\lVert k\rVert^2=r^2$,

$$\alpha\max_{a,b}\lvert h_a+k_b\rvert\ \le\ \frac{m-2}{2(m-1)}\cdot\sqrt{\tfrac{m-1}m}\cdot r\sqrt2\ =\ \frac{m-2}{2(m-1)}\cdot\frac{2(m-1)}{m\sqrt{m-2}}\ =\ \frac{\sqrt{m-2}}m .$$

And $\frac{\sqrt{m-2}}m<\frac1{\sqrt{m-1}}\iff(m-1)(m-2)<m^2\iff 3m>2$ ✓. The cap is **attained**: at $m=6$ the entry's own second witness normalises to $\frac45/2.4=\frac13=\frac{\sqrt4}6$ exactly, so there is no slack hiding inside it. The in-block branches on the joint space need one further line the entry does not write, $\beta\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\le\frac1{\sqrt{m-1}}\lVert H_h\rVert_F\le\frac1{\sqrt{m-1}}\lVert H\rVert_F$ by §5 plus homogeneity, after which $\sup=\frac1{\sqrt{m-1}}$ on the joint space, attained at $k=0$. C9 **PROVEN**.

> **The named trap, answered directly.** **Read the box alone and it carries: one copy, one scale, and no map.** It says "For $H$ the Weyl image of a **single** $h$ … with $\lVert H\rVert_F=1$". [L149](../findings/second-order.md) uses it on $H_s$ ranging over the **joint** two-copy eigenspace at $\lVert H_s\rVert_F=\sqrt{1-w^2}<1$. **Neither extension is inside the box.** Both are on the record, the two-copy extension in the box **THIS PRICES ONE COPY**, the homogeneity asserted in L149's own bullet, so this is the repair landing *beside* the statement, precisely as the round predicted. It is a `HYPOTHESIS-DEBT` of the citable statement and not of the mathematics: each extension is one line, and I have written both lines above.
>
> Two facts make it milder than it looks. [L149](../findings/second-order.md) records the gap itself ("**L146 prices one $S^2_0$ copy and is applied here to the joint two-copy eigenspace** … recorded because the step was silent"), and the index row at [INDEX-results.md:165](../findings/INDEX-results.md) states the joint-space conclusion outright. **The one-line summary of L146 in the index is stronger and more accurate than L146's own citable box**, which is worth saying plainly, because it inverts the usual direction of drift.

## 8. Pre-registered question 1, the three consumers

| Consumer | What it takes | Does the box reach it? |
|---|---|---|
| [L149](../findings/second-order.md), at **every $w\in[0,1]$**: $\lVert H\rVert_{op}\le\lVert H_s\rVert_{op}+\lVert H_r\rVert_{op}\le\Theta(n^{-1/2})+w$ | $\lVert H_s\rVert_{op}\le\frac1{\sqrt{m-1}}\lVert H_s\rVert_F$ for $H_s$ in **both** copies, at **any** norm | **No**, on two counts, §7. Yes on the hypothesis that homogeneity and the two-copy extension are imported; both hold, both are proved elsewhere |
| [L157](../findings/second-order.md)/[L158](../findings/second-order.md), at the **kink** $w_0=\frac{n-4}n$: envelope $\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$ | the constant $a_0n^{-1/2}$, and the slope it induces at $w_0$ | **Yes, once the same two extensions are made**, and the translation is exact: $a_0n^{-1/2}=\sqrt{\frac{2n}{n-2}}\,n^{-1/2}=\sqrt{\frac2{n-2}}=\frac1{\sqrt{m-1}}$ |
| [L147](../findings/second-order.md), inside a **Cauchy estimate over a complex disc**: $\lVert A''\rVert=O(M/\rho^2)$ with $\rho\asymp g_n/\lVert H\rVert_{op}$ | an upper bound on $\lVert H\rVert_{op}$ only, since $\lVert zH\rVert_{op}=\lvert z\rvert\lVert H\rVert_{op}$ | **Yes at order.** The real, symmetric computation suffices; the complexification difficulty in that consumer is about $x\mapsto x_-$, not about $H$ |

**The direction of the inequality is safe in all three.** The envelope sits in a denominator, so an upper bound on $\lVert H\rVert_{op}$ produces a lower bound on the branch, which is what a tube radius needs.

**Two checks on the constants the consumers derive from L146, both exact.** Setting $c=a_0n^{-1/2}$, $c\sqrt{1-w^2}=1-w$ gives $w_0=\frac{1-c^2}{1+c^2}=\frac{(n-2)-2}{(n-2)+2}=\frac{n-4}n$, which is $\frac23$ at $n=12$ ✓; and with $\sqrt{1-w_0^2}=\frac{2\sqrt{2(n-2)}}n$,

$$\phi'(w_0)=1-\frac{c\,w_0}{\sqrt{1-w_0^2}}=1-\frac{n-4}{2(n-2)}=\frac n{2(n-2)},$$

which is $\frac35$ at $n=12$ and $\frac7{12}=0.5833$ at $n=14$, both the values [L158](../findings/second-order.md) carries. **L146's constant is what fixes the binding minimiser of the whole chain.** That is the fact C14 denies.

## 9. The two remaining broken statements

> **Discrepancy D2, located.** Setting: "[Lemma L27](../findings/nondegeneracy.md) puts the off-orbit margin **maximum** on the two $S^2_0(\mathbb R^m)$ summands".

> **Exhibited.** The margin on an $L_e$-eigenspace is $3\theta_0(\frac12-\lambda)$, decreasing in $\lambda$, and the summand carries the **largest** off-orbit $\lambda$, which the entry itself says four boxes later: "$\lambda_m>\mu$ puts the margin on this summand". So the summand carries the **smallest** margin. In closed form, $\frac12-\lambda_m=\frac1{2(m-1)}$ against $\frac12-\mu=\frac{m-3}{2(m-1)}$, and $\frac{m-3}{2(m-1)}>\frac1{2(m-1)}$ for every $m\ge5$. The record agrees three times over: [L145](../findings/second-order.md), "$c_p=3\theta_0/(n-2)$ is the **strict minimum** only from $m\ge5$"; [L149](../findings/second-order.md)'s convex combination $c(H)\ge c_p+3\theta_0\frac{m-4}{2(m-1)}w^2$, whose coefficient is exactly $\big(3\theta_0\frac{m-3}{2(m-1)}\big)-c_p\ge0$ and which is a lower bound only because $c_p$ is smallest; and [L149](../findings/second-order.md) again, "its coefficient is the *smallest surviving* one".

> **The opposite, argued.** "The off-orbit margin maximum" can be read as "the off-orbit maximum &#91;of $L_e$&#93;", with "margin" attached to the wrong noun; under that reading the sentence is true and is the sentence the rest of the entry uses. But the phrase as written names the wrong extremum of the wrong quantity, and it inverts the entry's whole point: the summand matters because it is the **worst** case, the one that binds. A reader who takes it literally concludes the binding directions are elsewhere. **The discrepancy stands**, and it is not confined to this entry, [plan.md](../plan.md) repeats the same phrase.

> **Discrepancy D3, located.** "**AND [LEMMA L148](../findings/second-order.md) DISPLACES THIS LEMMA ENTIRELY.** … **What it establishes about the ten-summand infimum is nothing.**"

> **Exhibited.** [L148](../findings/second-order.md) empties the defect on the summand itself, i.e. at $w=0$. At every $w>0$ the direction is $H=H_s+H_r$ with $H_r\ne0$, the defect is present, and the only bound on $\lVert H_s\rVert_{op}$ in the block is L146's. Concretely: [L149](../findings/second-order.md)'s first input bullet is "$\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$, by the triangle inequality and [Lemma L146](../findings/second-order.md)", quantified over all $w\in[0,1]$; and [L158](../findings/second-order.md)'s binding minimiser $w_0=\frac{n-4}n$ and its one-sided slope $\phi'(w_0)=\frac n{2(n-2)}$ are functions of L146's $a_0$ alone, §8. Remove L146 and the kink location, the slope, and hence L158's verdict that branch 2 binds all lose their input. [plan.md](../plan.md) states the correct scope in as many words: "**[L148] voids the first at $w=0$ only** … and L149 consumes L146's envelope at every $w$."

> **The opposite, argued.** The sentence carries its own qualifier ("about the **ten-summand infimum**") and on that infimum, taken over the pure summand, the claim is right: a bound on $\lVert A''\rVert$ where $A\equiv0$ prices nothing. But the headline is "DISPLACES THIS LEMMA **ENTIRELY**", and a consumer reads headlines. **The discrepancy stands against the word "entirely" and against "what it establishes is nothing"**, which is a claim about the lemma and not about one infimum.

> **Note N1, not a discrepancy.** "the analyticity disc $g_n/\lVert H\rVert_{op}$" is the disc at $\gamma=1$, where $\lVert zH\rVert_{op}=g_n$ and the perturbed cluster can reach $0$, [L156](../findings/second-order.md)'s excluded endpoint, and [L145](../findings/second-order.md)'s step-2 row already records "the complex radius must be $\rho<g_n/2$, not $\rho=g_n/2$". The claim made is $\Omega(n^{-1/2})$, an order, and any fixed $\gamma^*<1$ preserves it, so nothing here is wrong at the stated strength. [plan.md](../plan.md) already carries this as a live gap; L146's box restates the endpoint without the caveat.

## 10. Every edge of every range

| Edge | What happens |
|---|---|
| $m=2$ ($n=4$) | excluded, and correctly: $\lVert H\rVert_F^2=0$, so $\lVert H\rVert_F=1$ is unsatisfiable, and $\mathrm{Ric}=(m-2)h=0$ makes $h\owedge g_q$ already Weyl |
| $m=3$ ($n=6$) | the box holds: $\alpha=\frac14$, $\beta=\frac34$, $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert=\max_a\lvert h_a\rvert$ by tracelessness, in-block still wins $\frac34$ to $\frac14$, and $\sup=\frac34\cdot\frac{2\sqrt2}3=\frac{\sqrt2}2=\frac1{\sqrt{m-1}}$ ✓. But the **word "margin" is empty here**, [L148](../findings/second-order.md) records that at $m=3$ the margin is exactly zero, $\mu=\frac12$ tying the orbit |
| $m=4$ ($n=8$) | box holds; $\lambda_4=\mu=\frac13$, so the $\lambda_m$-eigenspace strictly contains the two copies, and the floor $\frac1{m-1}=\frac13$ is **attained**, by the spike |
| $m\ge5$ | C11 exactly: $\lambda_m>\mu\iff\frac{m-2}{2(m-1)}>\frac1{m-1}\iff m>4$; and $n\ge12\Rightarrow m\ge6$ ✓ |
| **three floors in one block** | the box carries $m\ge3$, its own conclusion box needs $m\ge5$, [L149](../findings/second-order.md) needs $m\ge6$, [L145](../findings/second-order.md) carries none. The box's $m\ge3$ is right *for the algebra* and wrong for anything the word "margin" touches |
| $w=0$ | the envelope is $\frac1{\sqrt{m-1}}$, the box's supremum on the nose, and the one point where the box's "single $h$" is most visibly short of the joint eigenspace. [L148](../findings/second-order.md) empties branch 2 here; branch 1 survives at $c_p/S\le\frac3{n-2}$ |
| $w=1$ | envelope $=1$, from $\lVert H_r\rVert_{op}\le\lVert H_r\rVert_F$ alone. **L146 is not used at $w=1$** |
| $w=w_0=\frac{n-4}n$ | the two branches meet at value $1$; L146 enters through the one-sided slope, §8 |
| odd $n$ | out of scope by $n=2m$, there being no balanced $S^m\times S^m$. The consumers write the envelope in $n$ ($a_0n^{-1/2}$, $w_0=\frac{n-4}n$), which reads at odd $n$ without complaint; nothing on the record evaluates it there |
| $\ker W\ne0$, $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$ | the **algebra** is base-point-free and untouched. The **third box** is not: analyticity of $W\mapsto W_-$ needs $\ker W^*=0$, which holds at $W^*$ ($g_n>0$, two-point spectrum, [L145](../findings/second-order.md)) but is stated in [L149](../findings/second-order.md) and in no box of L146. [INDEX-results.md:166](../findings/INDEX-results.md) records that $W_{\mathbb{CP}^2}$ is a named witness against that hypothesis for [L147](../findings/second-order.md); L146's box gives a reader no reason not to carry its disc there |

## 11. Quantifier order and scope

- **"a single $h$" versus the two copies**, §7. The singular is correct and deliberate in the box; the consumers are plural. This is the one live singular/plural in the entry and it is the trap.
- **"the supremum" versus "the maximum"**, the supremum is attained (§5), so nothing turns on the word here.
- **"$\lVert H\rVert_{op}$ ranges over $[\Theta(n^{-1}),\Theta(n^{-1/2})]$"**, an image claim, and correct: connectedness of the traceless sphere at $m\ge3$ gives every intermediate value.
- **One variable substituted for another**, I checked the block's live pair: $u$ (the defect's linear rate) against $w$ (the weight off the summand), which [L149](../findings/second-order.md) warns "is **not** $w$". **No finding: neither letter occurs in L146.**
- **One letter, several meanings.** Inside this entry, $g$ is both the factor metric $g_q$ and the spectral gap $g_n$; $\lambda$ is both the $L_e$ eigenvalue $\lambda_m$ and, through [L145](../findings/second-order.md) one screen above, the curvature spectrum $\lambda_\pm$. Across the block, **$\beta$ collides head-on**: it is $\frac m{2(m-1)}\in(\frac12,\frac34]$ here and the growth exponent $\sup\lvert P\rvert=\Theta(n^\beta)$ with $\beta\in[0,\frac12]$ in the very next entry; $\alpha$ is $\frac{m-2}{2(m-1)}$ here and [L156](../findings/second-order.md)'s contour radius with $\alpha^*=\frac{11}{10}$. A reader carrying either letter from L146 into L147 gets a contradiction in the first line. *Recorded as a hazard, not a defect: within L146 each letter has one meaning.*

## 12. Numerals, one by one

| Numeral | Reproduced? |
|---|---|
| $\alpha=\frac{m-2}{2(m-1)}$, $\beta=\frac m{2(m-1)}$, $\beta/\alpha=\frac m{m-2}$ | **yes**, from the record's own projector |
| $\mathrm{Ric}=m\,h$ | **no**, it is $(m-2)h$; D1 |
| $\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ | **yes** |
| $3\theta_0(\frac12-\lambda_m)=\frac{3\theta_0}{n-2}$ | **yes**: $\frac12-\frac{m-2}{2(m-1)}=\frac1{2(m-1)}=\frac1{n-2}$ |
| $\frac{m-2}{m-1}$, sharp at $(3,-1,-1,-1)$ | **yes**, equality $\frac23$ |
| $\sup=\frac1{\sqrt{m-1}}$ | **yes** |
| $\frac34$ vs $\frac58$ at $m=5$; $\frac45$ vs $\frac{12}{25}$ at $m=6$ | **yes**, all four |
| cross cap $\frac{\sqrt{m-2}}m$, and $(m-1)(m-2)<m^2$ | **yes**, and the cap is attained at $m=6$ |
| $\sqrt{m-1}/m$, "too small by $m/(m-1)$" | **yes**: $\frac1{\sqrt{m-1}}\big/\frac{\sqrt{m-1}}m=\frac m{m-1}$ |
| "intervals disjoint from the truth at $m=3$" | **yes**: the superseded top end is $\frac{\sqrt2}3=0.4714$, below the true bottom end $\frac34\sqrt{\frac23}=0.6124$ |
| $m^2-8m+8<0$ | **yes**, roots $4\pm2\sqrt2$ |
| "$\approx\sqrt2/m$ an attained value" | **yes**: $\sqrt{\frac2{(m-1)(m-2)}}$ |
| "$1/(m-1)$ is a proven floor" | **no proof in this entry**; verified true at $m=3,\dots,8$ and for $m\ge16$; §6 |
| $\lambda_m>\mu$ at $m\ge5$; $n\ge12$ inside | **yes** |
| $M=O(\rho)\Rightarrow\lVert A''\rVert=O(n^{1/2})$; $M=O(g_n)\Rightarrow O(1)$; coinciding at $\rho=\Theta(g_n)$ | **yes**, all three: $O(1/\rho)$ at $\rho=\Theta(n^{-1/2})$; $O(g_n/\rho^2)$ at $\rho=\Theta(n^{-1})$; and both give $O(n)$ there |
| disc $\Omega(n^{-1/2})$, "a factor $\sqrt n$ larger than $g_n$" | **yes** at order; N1 |
| "meets only the weaker $o(1)$"; $O(g_n)$ not delivered | **yes**, the top of the range is $\Theta(n^{-1/2})\ne O(n^{-1})$ |
| $a_0n^{-1/2}=\sqrt{\frac2{n-2}}=\frac1{\sqrt{m-1}}$ (consumer side) | **yes**, one quantity written two ways |
| $w_0=\frac{n-4}n$, $\phi'(w_0)=\frac n{2(n-2)}$ (consumer side) | **yes**, both derived above |

**Everything I could not reproduce is in the table: the Ricci numeral, which is wrong, and the floor $1/(m-1)$, whose general proof is off-entry.**

## 13. [results.md](../results.md), and the two forms

**There is no canonical L146 in [results.md](../results.md)**, nor L145, L147, L148 or L149; the file's numbered entries jump from L140 to L154. Since L154–L158 come from the same file and the same block and *are* there, and since [results.md](../results.md):363 cites "Lemma L149's parametrisation" by name with no entry to point at, **the absence is an inconsistency in the record rather than a correct omission.** Its concrete cost is exactly the trap: with no canonical box, the citable form of L146 is the findings box, whose scope is one copy at unit norm.

**What limits the damage** is that [findings/INDEX-results.md:165](../findings/INDEX-results.md) carries the one-line canonical row and it states the correction, "on the **joint two-copy** eigenspace a cross-plane branch appears and the clause is false there, though the supremum $1/\sqrt{m-1}$ is unchanged and attained". **So no citation that goes through the index inherits a stale scope.** The two forms on file agree; the third form, in [results.md](../results.md), is missing rather than wrong.

## 14. What would falsify this, and what I did to look for it

**The object that would break C5/C6** is a traceless $h\in\mathbb R^m$ with $\lVert h\rVert=r$ and $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert>\frac{2\sqrt{m-1}}m$. I looked for it by computing the exact norm of the linear functional $h\mapsto h_a+h_{a'}$ on the traceless hyperplane, $\sqrt{2-\frac4m}$; the supremum is that norm times $r$ and there is nothing left over, so no such $h$ exists at any $m$. **The object that would break C9** is a pair $(h,k)$ with $\alpha\max_{a,b}\lvert h_a+k_b\rvert>\frac1{\sqrt{m-1}}$ at $\lVert H\rVert_F=1$; I bounded the branch by two sharp inequalities in series, $\max_a\lvert h_a\rvert\le\sqrt{\frac{m-1}m}\lVert h\rVert$ and $\sqrt{s_h}+\sqrt{s_k}\le\sqrt{2(s_h+s_k)}$, reaching $\frac{\sqrt{m-2}}m$ and then confirming at $m=6$ that the entry's own witness attains it exactly. **A sharp cap strictly below the claimed supremum leaves no room for a counterexample**, which is the strongest form this check can take. **The object that would break C4** is a traceless $h$ with all pair sums small against one large entry; the averaging identity $\sum_{a'\ne1}(h_1+h_{a'})=(m-2)h_1$ forbids it, and $(3,-1,-1,-1)$ shows the constant cannot be improved. I did not look for a counterexample to D1, D2 or D3: those are internal contradictions, exhibited against the entry's own other lines.

## Verdict

**`PROVEN, hypotheses corrected`.**

The boxed lemma is true and I derived every one of its claims independently: the eigenvalue list, the Frobenius constant, the tracelessness inequality with its sharp witness, the dominance of the in-block branch with a strict margin, and the supremum $1/\sqrt{m-1}$ attained at the pair-concentrated $h$ and lying inside the domain the consumers quantify over. The joint two-copy correction is true and its cap is sharp. **Four corrections are owed and none of them touches the boxed conclusion:**

1. **$\mathrm{Ric}(h\owedge g_q)=(m-2)h$, not $m\,h$**, the stated value swaps $\alpha$ and $\beta$ and contradicts the box's own $\lVert H\rVert_F^2$ at $m=4$ (D1).
2. **"the off-orbit margin *minimum*"**, the summand carries the smallest margin, as [L145](../findings/second-order.md) and [L149](../findings/second-order.md) both say, and it is the binding case for exactly that reason (D2).
3. **Withdraw "displaces this lemma entirely" and "what it establishes is nothing"**, L146's $a_0$ fixes [L157](../findings/second-order.md)/[L158](../findings/second-order.md)'s binding minimiser $w_0=\frac{n-4}n$ and its slope $\frac n{2(n-2)}$, and [L149](../findings/second-order.md) consumes the envelope at every $w$. [plan.md](../plan.md) already states the correct scope: L148 voids L146 at $w=0$ only (D3).
4. **Write the two extensions into the box** (the joint two-copy eigenspace, and arbitrary $\lVert H\rVert_F$) since those are what three later entries cite it for, and the box read alone reaches neither (§7, S1).

**On the scale of the correction the round asked about**, item 4 is the round's own pre-registered trap and it is real; items 1–3 are three false sentences in the surrounding prose of an entry whose mathematics is sound. The one genuinely open question I met, $1/(m-1)$'s general proof, is inert: the interval $[\Theta(n^{-1}),\Theta(n^{-1/2})]$ that the box claims follows from a bound I gave in §6 without it.
