# REVIEW r1146: the rank reduction of the pair operator, and r >= p

Brief: [2026-09-25-rank-reduction-gate2-brief.md](2026-09-25-rank-reduction-gate2-brief.md). Working file: [2026-09-25-I73c-per-vector-rows.md](2026-09-25-I73c-per-vector-rows.md) at e1f74374, lines 143 to 169 (claim 1 at line 165, claim 2 at lines 167 to 169). Method: read each link against the definitions (the operator rows at the head of the file, $B_{ab}=P_a\#P_b$, $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$), then derived. One screen of a few seconds on random subspaces of $\mathfrak{so}(7)$ checked the ad-invariance sign and the two rank counts below, as a screen only.

| item | verdict |
|---|---|
| 1. claim 1 step by step | PLAUSIBLE: the linear algebra is CONFIRMED, the step $4T\le p$ is REFUTED |
| 2. claim 2, $r\ge p$ | CONFIRMED |
| 3. the displayed threshold | CONFIRMED as a rewriting, and superseded by a sharper leading-order threshold with $p$ in place of $r$ |
| 4. overreach | REFUTED in three places, corrections below |

## Identification of the masses

- For unit $u\in E_0$, $\langle B_{02}u,u\rangle=\tfrac12\sum_{\gamma\in E_0,\delta\in E_2}\langle[\psi_\gamma,\psi_\delta],u\rangle^2=\tfrac12\sum_{v\in E_2}\lvert P_0[u,v]\rvert^2$ by ad-invariance, which is the half-summed note's $b_{20}(u)$. Likewise $\langle B_{22}u,u\rangle=b_{22}(u)$ and $\langle B_{00}u,u\rangle=\tfrac12\sum_{v\in E_0}\lvert P_0[u,v]\rvert^2=:b_{00}(u)$.
- Row (C) at unit $u\in E_0$ with $\lambda=(-a,0,a)$ reads $a^2(b_{00}-2b_{02}+b_{22})=-a(\theta+a)$, so $b_{20}(u)=\tfrac12\big(b_{00}(u)+b_{22}(u)\big)+\theta\sqrt{p/2}+\tfrac12$ with $a=1/\sqrt{2p}$. This identity is used twice below.

## Item 1: PLAUSIBLE, one step refuted

- **$B\approx-\tfrac14C^{\mathsf T}eC$ and $\mathcal B=CC^{\mathsf T}$: CONFIRMED** as the polarisation of the first term of the boxed formula. The $\varepsilon$ average vanishes for every pair $(u,v),(u',v')$ with $u,u'\in E_0$ and $v,v'\in E_2$, since the eigenvalues are the same as in the diagonal case. $\mathcal B=2B_{02}$ matches the ordered-pair normalisation of $B_{ab}$, which also gives $\sum_{a,b}B_{ab}=(n-2)\mathrm{Id}$ from the Killing form.
- **$\mathop{\mathrm{rank}}B\le r$ with $e$ indefinite: CONFIRMED.** $\mathop{\mathrm{rank}}(C^{\mathsf T}eC)\le\mathop{\mathrm{rank}}C=r$ needs no sign on $e$, and the nonzero spectra of $C^{\mathsf T}(eC)$ and $(eC)C^{\mathsf T}$ agree for any $e$. **It is loose, though**: $e=\tfrac a\theta(P_2-P_0)$ kills $E_1$, so $C^{\mathsf T}eC=(\Pi C)^{\mathsf T}e(\Pi C)$ with $\Pi=P_0+P_2$, and $\mathop{\mathrm{rank}}B\le\dim\Pi[E_0,E_2]\le2p$ unconditionally.
- **Top eigenvalue at least $T/r$: CONFIRMED** (at most $r$ nonzero eigenvalues summing to $T>0$).
- **$T=\mathop{\mathrm{tr}}B=\sum_u\tfrac a{2\theta}(b_{20}-b_{22})$ with this sign: CONFIRMED.** $-\tfrac14\sum_v\langle[u,v],e[u,v]\rangle=-\tfrac1{4\theta}\big(-a\cdot2b_{20}+a\cdot2b_{22}\big)$.
- **$\lambda_{\max}(L_e)\gtrsim2T/r$ from $G\approx\tfrac12I$: CONFIRMED, and the $G$ half of the "$\approx$" is exact in the favourable direction.** The polarised Gram is $G=\tfrac12I-H-\Omega$ with $H,\Omega$ Gram matrices of the $h$ and $\omega$ families, so $G\preceq\tfrac12I$. Let $x$ be a top eigenvector of the full pair matrix $B_{\mathrm{full}}$ with eigenvalue $\mu>0$. Then $Gx\ne0$, because $Gx=0$ forces $X_x=\sum_\alpha x_\alpha X_\alpha=0$ and hence $x^{\mathsf T}B_{\mathrm{full}}x=\langle X_x,e\circ X_x\rangle=0$. So $x^{\mathsf T}Gx\in(0,\tfrac12\lvert x\rvert^2]$ and $\lambda_{\max}(L_e)\ge2\mu$ exactly. **What the "$\approx$" still hides is only $B_{\mathrm{full}}-B$**, the Ricci and $\Lambda^4$ terms of the pair matrix, which the file correctly declares owed. This is conditional on the polarised Gram formula, whose normalisations the file marks unchecked.
- **"Supersedes Wolkowicz–Styan", gain $1+O(r^{-1/2})$ against $D/r$: CONFIRMED.** With $\mathop{\mathrm{tr}}(L_e^2)\approx4\mathop{\mathrm{tr}}B^2\ge4T^2/r$, $s/\sqrt{D-1}\approx(2T/D)r^{-1/2}$ for $r\ll D$.
- **$\mathop{\mathrm{rank}}(P_0\mathop{\mathrm{ad}}_u|_{E_2})\ge2b_{20}(u)/\lVert\mathop{\mathrm{ad}}_u\rVert_{\mathrm{op}}^2$: CONFIRMED** (Frobenius norm squared at most rank times operator norm squared). The sentence "the rows alone leave $\sqrt p\lesssim r<p$ open" is false as a statement about the rows, since claim 2 shows the rows force $r\ge p$. It should be struck or annotated as superseded.
- **"The scale check's per-vector ceiling of about $\tfrac14$ gives $4T\le p$": REFUTED.** The scale check (line 149) evaluates the bracket term at "the rows' largest $b_{20}\approx\tfrac12\theta\sqrt{2p}$", but the rows give $b_{20}\ge\tfrac12(\theta\sqrt{2p}+1)$, a floor. By the row (C) identity above, the per-vector term is exactly
$$\frac a{2\theta}\big(b_{20}(u)-b_{22}(u)\big)=\frac14+\frac{b_{00}(u)-b_{22}(u)+1}{4\theta\sqrt{2p}},$$
  so $4T=p+(\theta\sqrt{2p})^{-1}\sum_u\big(b_{00}(u)-b_{22}(u)+1\big)$, which exceeds $p$ whenever the average of $b_{22}$ over a basis of $E_0$ is below the average of $b_{00}$ plus one. Nothing on file bounds that sign. **Consequence**: the headline "binds only if $\dim[E_0,E_2]<4T\le p$" and "the lead needs $\dim[E_0,E_2]<p$" do not follow. Read together with claim 2 ($r\ge p$), the headline would kill the lead outright, while claim 2's threshold (which does not use $4T\le p$) keeps it alive, so the working file currently contradicts itself. Claim 2's reading is the correct one.
- The same misreading sits in the scale check itself (line 149, "at most about $\tfrac14$"). That paragraph's conclusion survives in weakened form: the bracket term is $\tfrac14+O(p^{-1/2})$ times order-one per-vector data, still $O(1)$ against the right side's $\tfrac p4$.

## Item 2: CONFIRMED

- **The identity**: $\langle[u,v],w\rangle=-\tfrac12\mathop{\mathrm{tr}}(uvw-vuw)$ and $\langle u,[w,v]\rangle=-\tfrac12\mathop{\mathrm{tr}}(uwv-uvw)=-\tfrac12\mathop{\mathrm{tr}}(vuw-uvw)$, so $\langle[u,v],w\rangle=-\langle u,[w,v]\rangle$ as stated. The screen agreed to machine precision.
- **$w\perp P_0[E_0,E_2]$ forces $b_{20}(w)=0$**: for $u\in E_0$, $v\in E_2$, $\langle u,P_0[w,v]\rangle=\langle u,[w,v]\rangle=-\langle[u,v],w\rangle=-\langle P_0[u,v],w\rangle=0$, the third equality because $w\in E_0$. So $P_0[w,v]=0$ for every $v$ and $b_{20}(w)=\tfrac12\sum_v\lvert P_0[w,v]\rvert^2=0$.
- **$r\ge\mathop{\mathrm{rank}}(P_0C)=p$**: L244's rows give $b_{20}(w)>0$ at every unit $w\in E_0$ (only $\theta>0$ is used), so $P_0(\mathop{\mathrm{im}}C)=E_0$, and $r=\mathop{\mathrm{rank}}C\ge\mathop{\mathrm{rank}}P_0C=p$. "The $r<p$ branch is empty" follows.

## Item 3: CONFIRMED, and superseded

- **The rewriting**: $2T/r>\tfrac12\iff\tfrac{2a}\theta\sum_u(b_{20}-b_{22})>r\iff\sum_u(b_{20}-b_{22})>r\theta/(2a)=r\theta\sqrt{p/2}$, which divided by $p$ is the display. The comparison $b_{20}\ge\theta\sqrt{p/2}+\tfrac12$ equals $\tfrac12(\theta\sqrt{2p}+1)$, and the slack $b_{20}-\theta\sqrt{p/2}\ge\tfrac12$ is right. The italic reading at $r=p$ is right.
- **A sharper leading-order bound replaces $r$ by $p$.** Write $B=M_0-M_2$ with $M_c=\tfrac a{4\theta}(P_cC)^{\mathsf T}(P_cC)\succeq0$. Since $B\preceq M_0$ and $\mathop{\mathrm{rank}}M_0=\mathop{\mathrm{rank}}P_0C=p$ (claim 2), $B$ has at most $p$ positive eigenvalues: a $(p+1)$-dimensional positive subspace would meet $\ker M_0$, where $x^{\mathsf T}Bx=-x^{\mathsf T}M_2x\le0$. Its positive eigenvalues sum to at least $T$, so $\lambda_{\max}(B)\ge T/p$ for every $r$. The screen agreed: at $p=5$ in $\mathfrak{so}(7)$, $r=21$, $\mathop{\mathrm{rank}}B=10=2p$, and $B$ had 5 positive eigenvalues.
- **With the item-1 bound on $G$, the leading-order test becomes $2T/p>\tfrac12$, i.e. $4T>p$, which by the row (C) identity is exactly**
$$\frac1p\sum_{u}b_{22}(u)\ <\ \frac1p\sum_ub_{00}(u)+1,\qquad\text{i.e.}\qquad\mathop{\mathrm{tr}}(P_0B_{22})<\mathop{\mathrm{tr}}(P_0B_{00})+p .$$
  This condition sits at the class level, so the owed "upper bound on $r$" is no longer needed. What remains owed is the sign of $\mathop{\mathrm{tr}}(P_0B_{22})-\mathop{\mathrm{tr}}(P_0B_{00})$ against $p$, plus the corrections.
- **Caution on the margin.** $\lambda_{\max}(L_e)\ge\tfrac12+\big(\mathop{\mathrm{tr}}P_0B_{00}-\mathop{\mathrm{tr}}P_0B_{22}+p\big)/(2p\theta\sqrt{2p})$ at leading order. The excess over $\tfrac12$ is of relative size $p^{-1/2}$ times order-one per-vector data, so any Ricci or $\Lambda^4$ correction to the pair matrix of that size decides the test. The corrections are not a detail here.

## Item 4: REFUTED in three places

- **"$4T\le p$" and the headline of claim 1** (line 165): unsupported, for the reason in item 1. Correction: $4T=p+(\theta\sqrt{2p})^{-1}\sum_u(b_{00}-b_{22}+1)$, and the headline should give the certificate condition $r<4T$ (or, sharper, $p<4T$) without the ceiling.
- **"Exactly when"** (claim 1, "the bracket part alone exceeds the bound $\tfrac12$ exactly when $r<4T$", and claim 2, "excludes a spectrum exactly when"): $T/r$ is a lower bound on $\lambda_{\max}$, so $r<4T$ is sufficient for the leading part to exceed $\tfrac12$, not necessary. The same holds for "binds only if". Correction: "the trace-over-rank certificate shows the bracket part exceeds $\tfrac12$ when $r<4T$".
- **"A sharp threshold"** (claim 2's heading): $T/r$ (or $T/p$) is attained only when the positive eigenvalues of $B$ are equal, so the threshold is the certificate's, not the operator's. Correction: "a threshold at the rows' own scale", which the italic sentence already says correctly.
- Everything else is scoped as the leading term with corrections owed, which is accurate. The "exclusion" in claim 2 is conditional on those corrections, and the file says so.
