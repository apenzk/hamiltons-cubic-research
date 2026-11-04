# REVIEW r1147: rank reduction of the pair operator, and r >= p

*Gate 2 reviewer r1147, 2026-09-25, brief [2026-09-25-rank-reduction-gate2-brief.md](2026-09-25-rank-reduction-gate2-brief.md), claims as committed at e1f74374 in [the working file](2026-09-25-I73c-per-vector-rows.md). Analysis from the definitions. One screen of seconds in $\mathfrak{so}(6)$ on random subspaces (ad-invariance sign, $b_{20}=b_{02}$, the rank inequalities with an indefinite diagonal $e$) agreed with every identity derived below. It is a screen, and none of the verdicts rests on it.*

## Summary

| item | verdict |
|---|---|
| 1. steps of claim 1 | CONFIRMED for the linear algebra and the sign of $T$, with a sharpening of the $G$ step. The clause "$4T\le p$, so the lead needs $\dim[E_0,E_2]<p$" is REFUTED (see correction A) |
| 2. ad-invariance and $r\ge p$ | CONFIRMED |
| 3. the displayed threshold | CONFIRMED as the rewriting of $2T/r>\tfrac12$ |
| 4. overstatement | PLAUSIBLE with corrections: "exactly when" and "sharp threshold" describe a sufficient condition, and "$\mathop{\mathrm{rank}}B\le r$" holds for the leading term only |

## Item 1

- **Leading term and $C$.** With $Y_\alpha=u\odot v$ and orthonormal bases, the polarised first term of the boxed formula is $-\tfrac14\langle[u,v],e[u',v']\rangle$, so $B_{\mathrm{lead}}=-\tfrac14C^{\mathsf T}eC$ with $C$ written in orthonormal bases, and $\mathcal B=CC^{\mathsf T}=\sum[u,v][u,v]^{\mathsf T}$. Correct.
- **Rank with indefinite $e$.** $\mathop{\mathrm{rank}}(C^{\mathsf T}eC)\le\mathop{\mathrm{rank}}C=\mathop{\mathrm{rank}}CC^{\mathsf T}=\dim\mathop{\mathrm{span}}[E_0,E_2]$ is the rank of a product, which needs no sign on $e$. The eigenvalue remark (nonzero spectra of $C^{\mathsf T}(eC)$ and $(eC)C^{\mathsf T}$ agree) is also correct and independent of sign. CONFIRMED.
- **Top eigenvalue.** A symmetric matrix of rank $r'\le r$ has at most $r'$ nonzero eigenvalues summing to $T>0$, so $\lambda_{\max}\ge T/r'\ge T/r$. CONFIRMED.
- **$T$ and its sign.** $e=\lambda/\theta$ is $-a/\theta$ on $E_0$, $0$ on $E_1$, $a/\theta$ on $E_2$, so $\sum_v-\tfrac14\langle[u,v],e[u,v]\rangle=\tfrac a{4\theta}\sum_v\big(\lvert P_0[u,v]\rvert^2-\lvert P_2[u,v]\rvert^2\big)=\tfrac a{2\theta}\big(b_{20}(u)-b_{22}(u)\big)$. Summed over a basis of $E_0$ this is $T$ with the stated sign. CONFIRMED.
- **What "$G\approx\tfrac12I$" hides, and a sharpening.** The unprojected family $Y_{(u,v)}=u\odot v$ has Gram exactly $\tfrac12I$, since $\langle u\odot v,u'\odot v'\rangle=\tfrac12(\langle u,u'\rangle\langle v,v'\rangle+\langle u,v'\rangle\langle v,u'\rangle)$ and $E_0\perp E_2$. $X_\alpha$ is the orthogonal projection of $Y_\alpha$, so $G\preceq\tfrac12I$ in Loewner order (the note's $\lVert X\rVert^2=\tfrac12-\lvert h\rvert^2/(n-2)-\lVert\omega\rVert_{\mathrm{op}}^2$ is its diagonal). Every $\sum_\alpha c_\alpha X_\alpha$ lies in $V$, so maximality gives $c^{\mathsf T}Bc\le\tfrac12c^{\mathsf T}Gc\le\tfrac14\lvert c\rvert^2$ for all $c$, with no Gram approximation and no invertibility of $G$ needed. **The necessary condition is $\lambda_{\max}(B)\le\tfrac14$ exactly**, and the approximation sits entirely in $B=B_{\mathrm{lead}}+B_{\mathrm{corr}}$: the leading term refutes it when $T/r>\tfrac14+\lvert\lambda_{\min}(B_{\mathrm{corr}})\rvert$ (Weyl). So "$\approx$" in $G$ errs in the favourable direction, and only the Ricci and $\Lambda^4$ parts of $B$ are owed.
- **Comparison with Wolkowicz–Styan.** With the only spread input on file, $\mathop{\mathrm{tr}}B^2\ge T^2/r$, Wolkowicz–Styan gives $\tfrac TD\big(1+\sqrt{(D/r-1)/(D-1)}\big)\approx\tfrac TD(1+r^{-1/2})$, and $T/r$ dominates it whenever $r\le D-1$ (the gap reduces to $D/r-1\ge1/(D-1)$). "Supersedes" is CONFIRMED.

### Correction A: "$4T\le p$" is false, and the lead does not need $r<p$

The "per-vector ceiling of about $\tfrac14$" of the scale check reads $b_{20}\approx\tfrac12\theta\sqrt{2p}$ as the rows' largest value. It is their smallest. By the definition $b_{ab}(x)=\langle B_{ab}x,x\rangle$ with $B_{ab}=P_a\#P_b$, ad-invariance gives $b_{20}(u)=b_{02}(u)$, and row (C) at unit $u\in E_0$ gives the equality recorded in the working file's first consequence:
$$2b_{20}(u)=b_{00}(u)+b_{22}(u)+\theta\sqrt{2p}+1 .$$
(Check: $\sum\lambda_a\lambda_bb_{ab}(u)=a^2(b_{00}+b_{22}-2b_{02})=-a(\theta+a)$.) Hence the per-vector bracket term is
$$\tfrac a{2\theta}\big(b_{20}-b_{22}\big)=\tfrac14+\tfrac a{4\theta}+\tfrac a{4\theta}\big(b_{00}(u)-b_{22}(u)\big),$$
which exceeds $\tfrac14$ whenever $b_{22}(u)<b_{00}(u)+1$, and has no ceiling near $\tfrac14$ from the rows ($b_{00}$ is bounded only by $\kappa$-type caps of order $n$). So
$$4T=p\Big(1+\tfrac a\theta\Big)+\tfrac a\theta\sum_u\big(b_{00}(u)-b_{22}(u)\big),$$
and $4T>p$ exactly when $\tfrac1p\sum_u(b_{22}-b_{00})<1$. Claim 1's conclusion "the lead needs $\dim[E_0,E_2]<p$" is therefore refuted. The correct form of its headline is: the leading bracket part refutes maximality whenever $r<4T$, with $4T$ as displayed. The same slip sits in the scale check paragraph ("at most about $\tfrac14$ even at the rows' largest $b_{20}$"), which is outside this brief but feeds claim 1 and should be repaired with it.

Claim 2 does not inherit the error: its display and its reading ("binds when $b_{22}$ averages below the rows' slack") are the correct threshold. But its sentence "The $r<p$ branch of the reduction above is empty" read against claim 1 as written would close the lead, so the repair to claim 1 is load-bearing for the record's reading.

## Item 2

- **Identity.** For skew matrices $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}(XY)$, and cyclicity gives $\langle[u,v],w\rangle=-\tfrac12(\mathop{\mathrm{tr}}uvw-\mathop{\mathrm{tr}}uwv)=-\langle u,[w,v]\rangle$. CONFIRMED for this inner product.
- **$w\perp P_0[E_0,E_2]$ forces $b_{20}(w)=0$.** For $w\in E_0$, $w\perp P_0[E_0,E_2]$ is $w\perp[E_0,E_2]$, so $\langle u,[w,v]\rangle=0$ for all $u\in E_0$, $v\in E_2$, i.e. $P_0[w,v]=0$ and $b_{20}(w)=0$. CONFIRMED.
- **$r\ge p$.** L244's rows give $b_{20}(w)>0$ at every unit $w\in E_0$, so the orthogonal complement of $P_0[E_0,E_2]$ in $E_0$ is zero, $\mathop{\mathrm{rank}}P_0C=p$, and $r=\mathop{\mathrm{rank}}C\ge\mathop{\mathrm{rank}}P_0C=p$. CONFIRMED. (Only positivity of $b_{20}$ is used, so the equality above gives it at once from $b_{20}\ge\tfrac12(\theta\sqrt{2p}+1)$.)

## Item 3

$2T/r>\tfrac12\iff T>r/4\iff\tfrac a{2\theta}\sum_u(b_{20}-b_{22})>r/4\iff\sum_u(b_{20}-b_{22})>\tfrac{r\theta}{2a}=r\theta\sqrt{p/2}$, and dividing by $p$ gives the display. The companion bound $\tfrac12(\theta\sqrt{2p}+1)=\theta\sqrt{p/2}+\tfrac12$ is also right. CONFIRMED. With the equality of correction A the threshold has an equivalent closed form worth recording:
$$\Big(\frac rp-1\Big)\theta\sqrt{p/2}\ <\ \frac12+\frac1{2p}\sum_u\big(b_{00}(u)-b_{22}(u)\big),$$
so at $r=p$ it reads $\tfrac1p\sum_u(b_{22}-b_{00})<1$, the same as the file's "average $b_{22}$ below the slack $b_{20}-\theta\sqrt{p/2}=\tfrac12+\tfrac12(b_{00}+b_{22})$".

## Item 4

- **"exactly when" and "sharp threshold".** $\lambda_{\max}(B_{\mathrm{lead}})\ge T/r$ is an inequality, so $r<4T$ is sufficient for the leading bracket part to exceed the bound, and the bracket part can exceed it with $r\ge4T$. Claim 1's "binds only if" and "exceeds the bound exactly when $r<4T$", and claim 2's "excludes a spectrum exactly when", should say that the rank bound binds exactly when, or that the leading part excludes a spectrum if.
- **"$\mathop{\mathrm{rank}}B\le r$"** is stated for $B$ while it holds for $B_{\mathrm{lead}}$. The file names the full-rank corrections as owed, so this is wording, but the bold statement should carry the subscript.
- **Exclusion.** Neither claim excludes a spectrum, and both declare the corrections owed. With the $G$ sharpening of item 1 what is owed is exactly $\lambda_{\min}$ of the Ricci and $\Lambda^4$ parts of $B$ on the pair family, and the upper bound on $r$ together with the average $b_{22}-b_{00}$.
