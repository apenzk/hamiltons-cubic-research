# REVIEW r1156: the forced band's margin and the trace reduction

Brief: [2026-09-25-band-trace-gate2-brief.md](2026-09-25-band-trace-gate2-brief.md). Claims read at 30d17e39 in [the working file](2026-09-25-I73c-per-vector-rows.md), the three paragraphs after the class-trace identity. Analysis-only, with one sympy screen of the asymptotic expansions (seconds), reported as a screen.

## Verdicts

| item | verdict | correction |
|---|---|---|
| 1. margin and its size near $\theta_0$ | CONFIRMED with two wording corrections | "independent of $p$" is false as written, and "about $(3+n\delta)/(16n)$" is the band's supremum |
| 2. the band | CONFIRMED with one correction | $m\le3n$ holds on the top $\tfrac32n$ values, not on the whole band once $\theta>\theta_0$ |
| 3. trace reduction, Ricci bound, $S_{02}$ | CONFIRMED | $S_{02}\le np$ is available and sharper by a factor $2(n-1)/n$ |
| 4. conclusions beyond support | PLAUSIBLE | the Huisken $O(1)$ sentence is unsourced, "$o(1/n)$" should be "below $c/n$", and the $\delta/32$ sentence holds only at the top of the band |

## Item 1

**The chain.** Row (C) at $u\in E_0$ traced over $E_0$ gives $2t_{002}=t_{000}+t_{022}+p(\kappa+1)$. With $a/\theta=1/\kappa$ and $T=\tfrac a{2\theta}(t_{002}-t_{022})$ this is $4T=p+(t_{000}-t_{022}+p)/\kappa$, so $2T/p-\tfrac12=(t_{000}-t_{022}+p)/(2p\kappa)$. Row (B) traced over $E_0$ gives $t_{022}-t_{000}-p=t_{001}-t_{012}$, and the solved rows give $t_{001}-t_{012}=(4D+t_{122})-(2D+t_{122})=2D$. So $2T/p-\tfrac12=-D/(p\kappa)$. CONFIRMED.

**The inequality.** $16D=(n-5-\kappa)p-4t_{000}-t_{011}-4t_{122}\le(n-5-\kappa)p$ gives $-D/(p\kappa)\ge(\kappa-(n-5))/(16\kappa)$ for $p,\kappa>0$, which is `margin_lower` in [ClassTraceTest.lean](../lean/HamiltonsCubic/Results/ClassTraceTest.lean) verbatim (hypotheses $0<p$, $0<\kappa$, three traces nonnegative). In the forced region $D<0$, so $T>p/4>0$ and $\lambda_{\max}(B_{\mathrm{lead}})\ge T/p$ applies. CONFIRMED.

**The size.** $p\le n(n-1)/4$ gives $\kappa\le\theta\sqrt{n(n-1)/2}$, and $\theta_0\sqrt{n(n-1)/2}=(n-1)\sqrt{1-2/n}=n-2+\tfrac1{2n}+O(n^{-3})$ (screened by series expansion). So at $\theta=\theta_0(1+\delta)$, $\kappa-(n-5)\le3+(n-2)\delta+O(1/n)\le3+n\delta$, and the margin at the top of the range is $\approx(3+n\delta)/(16n(1+\delta))$. CONFIRMED at leading order.

**Corrections.**

- **"Independent of $p$" is wrong as written.** The margin is a function of $\kappa=\theta\sqrt{2p}$, increasing in $p$, zero at the band's lower end $\kappa=n-5$ and largest at $p=n(n-1)/4$. What the paragraph means is that it carries no explicit $1/p$ factor, unlike the earlier $(\dots)/(2p\kappa)$ form. Suggested: "a function of $\kappa$ alone, with no $1/p$ factor".
- **"The margin is about $(3+n\delta)/(16n)$" is its supremum over the band.** Across the band it runs from $0$ up to that value. Suggested: "at most about".
- **The crossover is $\delta\approx3/n$.** The margin is of order $\delta$ once $n\delta\gg3$, which already holds for $\delta$ of a few multiples of $1/n$. "Only for $\theta$ well above it" overstates how far above $\theta_0$ that is.

## Item 2

- **Range.** $\kappa>n-5$ is $p>(n-5)^2/(2\theta^2)$, decreasing in $\theta$, so at $\theta\ge\theta_0$ the lower end is at most $n^2(n-5)^2/(4(n-1)(n-2))=\tfrac14(n^2-7n+2+O(1/n))$. CONFIRMED.
- **Width.** $\tfrac{n(n-1)}4-\tfrac{n^2(n-5)^2}{4(n-1)(n-2)}=\tfrac{n(3n^2-10n-1)}{2(n-1)(n-2)}=\tfrac32n-\tfrac12+O(1/n)$, positive and above $1$ for $n\ge4$ (at $n=4$ it is $7/3$), so an integer $p$ lies in the band at every $n\ge4$. CONFIRMED at $\theta=\theta_0$. For $\theta>\theta_0$ the band is wider, so "at least about $\tfrac32n$".
- **$m$ inside the band.** On $p\ge\tfrac{n^2(n-5)^2}{4(n-1)(n-2)}$, $m=N-2p\le3n-1+O(1/n)$. CONFIRMED at $\theta=\theta_0$. **Correction**: at $\theta=\theta_0(1+\delta)$ the band reaches down to $p\approx\tfrac14(n^2-7n)/(1+\delta)^2$, where $m\approx\tfrac12n^2\big(1-(1+\delta)^{-2}\big)$ is of order $n^2\delta$. The sentence "where $m$ is of order $n$ (at most about $3n$)" holds for the top $\tfrac32n$ values, not for the whole band away from $\theta_0$.
- **$m=0$.** With $E_1=0$ every trace carrying index $1$ vanishes, the identity reads $16D=(n-5-\kappa)p-4t_{000}$, and [r1150](REVIEW_r1150.md) records $D=0$ at $m=0$. Then $(n-5-\kappa)p=4t_{000}\ge0$, so $\kappa\le n-5$, which is outside the band. CONFIRMED.

## Item 3

**The reduction.** $B_{\mathrm{lead}}\preceq M_0$ with $\operatorname{rank}M_0=p$ gives at most $p$ positive eigenvalues (Courant–Fischer), so $k=\dim V_+\le p$ and $\operatorname{tr}_{V_+}B_{\mathrm{lead}}\ge\operatorname{tr}B_{\mathrm{lead}}=T$. For symmetric $C=C^+-C^-$, $\operatorname{tr}(P_WCP_W)\ge-\operatorname{tr}(P_WC^-)\ge-\operatorname{tr}C^-$. Hence $\operatorname{tr}_{V_+}B_{\mathrm{full}}\ge X:=T-\operatorname{tr}B_{\mathrm{Ric}}^--\operatorname{tr}B_{\Lambda^4}^-$ and $\lambda_{\max}(B_{\mathrm{full}})\ge X/k$.

- **$k<p$**: when $X>0$, $X/k\ge X/p$. $k\ge1$ is automatic, since $k=0$ forces $T\le0$ and then $X\le0$.
- **Sign condition**: $X>0$ gives $\lambda_{\max}(B_{\mathrm{full}})>0$, which the step $\lambda_{\max}(L_e)\ge2\lambda_{\max}(B_{\mathrm{full}})$ from $G\preceq\tfrac12I$ needs. A coefficient vector in $\ker G$ represents the zero element, so its $B$-value is $0$ and it never carries a positive quotient.
- **Threshold**: $\tfrac2pX>\tfrac12$ is $\operatorname{tr}B_{\mathrm{Ric}}^-+\operatorname{tr}B_{\Lambda^4}^-<T-\tfrac p4=\tfrac p2\cdot\big(-D/(p\kappa)\big)\ge p(\kappa-n+5)/(32\kappa)$. CONFIRMED.

**The Ricci bound.** With $H:c\mapsto\sum c_\alpha h_\alpha$ and $K=H^{\mathsf T}\mathring eH$, $B_{\mathrm{Ric}}=-\tfrac1{2(n-2)}K$ has negative part $\tfrac1{2(n-2)}K^+$. Since $K\preceq H^{\mathsf T}\mathring e^+H\succeq0$, $\operatorname{tr}K^+=\max_Q\operatorname{tr}(QK)\le\operatorname{tr}(H^{\mathsf T}\mathring e^+H)=\sum_\alpha\langle h_\alpha,\mathring e^+h_\alpha\rangle\le\lVert\mathring e^+\rVert S_{02}$. CONFIRMED given the polarised boxed formula of [the projected-pair note](2026-09-23-I73c-projected-pair.md), whose Ricci coefficient $-\tfrac1{2(n-2)}$ I took as given (the paragraph says so). The $\Lambda^4$ term's "likewise" is the same argument with $\tfrac38\lVert(e\diamond)^+\rVert\sum\lVert\omega_\alpha\rVert^2$, stated in the paragraph and not written out.

**The $S_{02}$ bound and its normalisations.** From the projected-pair note, $\lvert h_{uv}\rvert^2=\tfrac14\lVert\{u,v\}\rVert_F^2=\mathcal S_u(v)$, so $S_{02}=\sum_{u\in E_0}\operatorname{tr}(P_2\mathcal S_u)$. Since $\mathcal R_u\succeq0$, $\mathcal S_u\preceq D(uu^{\mathsf T})\succeq0$, so $\operatorname{tr}(P_2\mathcal S_u)\le\operatorname{tr}D(uu^{\mathsf T})$. On $\Lambda^2$, $D(A)(e_i\wedge e_j)=Ae_i\wedge e_j+e_i\wedge Ae_j$ has trace $\sum_{i<j}(A_{ii}+A_{jj})=(n-1)\operatorname{tr}A$. Unit in $\Lambda^2$ means $\lVert u\rVert_F^2=2$ (checked on $u=E_{12}-E_{21}$: $\mathcal R+\mathcal S$ at $y=u$ is $0+2$ and $\langle u,D(uu^{\mathsf T})u\rangle=2$, and at $y=e_1\wedge e_k$ it is $\tfrac12+\tfrac12=1$, matching the record's $R=n-2$, $S=n$). So $\operatorname{tr}D(uu^{\mathsf T})=2(n-1)$ and $S_{02}\le2p(n-1)$. CONFIRMED.

**Sharper, from the same record.** $\operatorname{tr}\mathcal R_u=\tfrac12\operatorname{tr}(-\mathrm{ad}_u^2)=n-2$ for every unit $u$ (Casimir), so $\operatorname{tr}\mathcal S_u=n$ exactly, which is the record's $\sum_aS_a=n$. Hence $S_{02}\le np$ and $\operatorname{tr}B_{\mathrm{Ric}}^-\le\tfrac{n}{2(n-2)}\lVert\mathring e^+\rVert p\approx\tfrac12\lVert\mathring e^+\rVert p$, a factor $2(n-1)/n\approx2$ better. The $\delta$-regime threshold becomes $\lVert\mathring e^+\rVert\lesssim\delta/16$ in place of $\delta/32$. Scale unchanged.

## Item 4

- **"Huisken's inequality gives only $O(1)$" is unsourced in the chain.** No statement on file bounds $\lVert\mathring e^+\rVert$ for this $e$, and the record's Huisken material ([fence-posts.md](../findings/fence-posts.md), [problem.md](../findings/problem.md)) concerns cubic trace bounds, not the second-kind operator. The scale is plausible ($\lVert e\rVert_{\mathrm{op}}=1/\kappa\approx1/n$ at the top of the band, and a contraction over $n$ indices can restore $O(1)$), but it should be stated as a scale estimate with its source or marked owed. PLAUSIBLE.
- **"The corrections have to be $o(1/n)$" overstates.** They have to be below the margin, which is $c/n$ with $c\le3/16$ at $\theta_0$. That is $O(1/n)$ with a small constant, and since the corrections were earlier sized at $p^{-1/2}\approx2/n$ at the top of the band, the question is one of constants at the same order, which is the sharper and truer statement.
- **"Closes only if $\lVert\mathring e^+\rVert=O(1/n)$"** is right for this estimate at the top of the band. It is a statement about the norm route, not about the corrections, and the paragraph says so ("needs a cancellation"). Acceptable.
- **The $\delta/32$ sentence holds only at the top of the band.** The margin is $(\kappa-(n-5))/(16\kappa)$ and vanishes at the band's lower end at every $\delta$, so a norm bound $\lVert\mathring e^+\rVert\le\epsilon$ excludes only $p$ with $\kappa-(n-5)\gtrsim16\kappa\epsilon$, a sub-band. No fixed norm bound closes the whole forced band. The paragraph should say the route shrinks the band rather than closes it.

## Summary of corrections to fold

1. Paragraph 1: replace "independent of $p$" by "a function of $\kappa$ alone, with no $1/p$ factor". Replace "the margin is about" by "the margin is at most about". Replace "$o(1/n)$" by "below $(3+n\delta)/(16n)$ in absolute terms, the same order as their $p^{-1/2}$ size".
2. Paragraph 2: write "spans at least about $\tfrac32n$ values". Then restrict "$m$ at most about $3n$" to the top $\tfrac32n$ values, noting $m$ of order $n^2\delta$ at the band's lower end for $\theta=\theta_0(1+\delta)$.
3. Paragraph 3: optional sharpening $S_{02}\le np$. Then source or mark owed the Huisken $O(1)$ sentence. Then state that any norm bound excludes a sub-band $\kappa-(n-5)\gtrsim16\kappa\lVert\mathring e^+\rVert$, since the margin vanishes at the lower end.
