# Gate 2 brief: the forced band's margin, and the trace reduction for the corrections (r1155, r1156)

**Two reviewers, independently: the round checks an argument.** Analysis-only: argue from the definitions; seconds of computation on objects you construct only as a screen. Model: opus.

## The claims, verbatim from [the working file](2026-09-25-I73c-per-vector-rows.md) at 30d17e39

> **In the forced region the certificate's margin is $(\kappa-(n-5))/(16\kappa)$, independent of $p$ but small near $\theta_0$.** The certificate gives $\lambda_{\max}(L_e)\ge2T/p$ at leading order, and $2T/p-\tfrac12=(t_{000}-t_{022}+p)/(2p\kappa)=-D/(p\kappa)$ with $\kappa=\theta\sqrt{2p}$ (row (C$_0$) traced, and $t_{022}-t_{000}-p=2D$). [r1149](REVIEW_r1149.md)'s identity with the three traces nonnegative gives $-16D\ge(\kappa-n+5)\,p$, so
> $$\lambda_{\max}(L_e)-\tfrac12\ \ge\ \frac{\kappa-(n-5)}{16\,\kappa}\qquad(\text{leading order}),$$
> **independent of $p$, but bounded by the family's own size**: $p\le n(n-1)/4$ gives $\kappa\le\theta\sqrt{n(n-1)/2}$, which at $\theta=\theta_0(n)(1+\delta)$ is about $(n-2)(1+\delta)$. So $\kappa-(n-5)\lesssim3+n\delta$ and **the margin is about $(3+n\delta)/(16n)$: of order $1/n$ near $\theta_0$, and of order $\delta$ only for $\theta$ well above it.** *The Ricci and $\Lambda^4$ corrections therefore have to be $o(1/n)$ relative to the certificate near $\theta_0$, the same thinness [r1146](REVIEW_r1146.md) found on the open region, at a different scale.* **Owed**: a bound on the Ricci and $\Lambda^4$ parts of the pair matrix below that margin; the trace reduction below gives the form it takes. Arithmetic on reviewed identities; no computation.

> **Where the band sits.** The symmetric family has $2p+m=N=\binom n2$, so $p\le n(n-1)/4$, and the forced region $\theta\sqrt{2p}>n-5$ is $p>(n-5)^2/(2\theta^2)$. At $\theta\ge\theta_0(n)$, $\theta_0^2=2(n-1)(n-2)/n^2$, the lower end is at most $n^2(n-5)^2/(4(n-1)(n-2))=\tfrac14\big(n^2-7n+O(1)\big)$, so **the band is nonempty at every $n$ and spans about $\tfrac32n$ values of $p$ at the top of the range**, where the kernel $E_1$ has dimension $m=N-2p$ of order $n$ (at most about $3n$). *The case $m=0$ is excluded inside the band outright: every trace with index $1$ vanishes, so r1149's identity reads $16D=(n-5-\kappa)p-4t_{000}$ with $D=0$ (r1150), forcing $\kappa\le n-5$.* The margin statement is typed as `margin_lower` in [ClassTraceTest.lean](../lean/HamiltonsCubic/Results/ClassTraceTest.lean). Arithmetic; no computation.

> **The corrections enter through a trace, not an operator norm.** Let $V_+$ be the positive eigenspace of $B_{\mathrm{lead}}$, of dimension at most $\mathop{\mathrm{rank}}P_0C=p$, on which $\mathop{\mathrm{tr}}B_{\mathrm{lead}}\ge T$. For any symmetric $A$ and subspace $W$, $\lambda_{\max}(A)\ge\mathop{\mathrm{tr}}_W(A)/\dim W$, and $\mathop{\mathrm{tr}}_W(C)\ge-\mathop{\mathrm{tr}}(C^-)$ for the negative part $C^-$. So, writing $B_{\mathrm{full}}=B_{\mathrm{lead}}+B_{\mathrm{Ric}}+B_{\Lambda^4}$ in the family's coefficients and using $G\preceq\tfrac12I$ ([r1146](REVIEW_r1146.md)),
> $$\lambda_{\max}(L_e)\ \ge\ \frac2p\Big(T-\mathop{\mathrm{tr}}B_{\mathrm{Ric}}^--\mathop{\mathrm{tr}}B_{\Lambda^4}^-\Big)\qquad(\text{when the bracket is positive}).$$
> **So the band's exclusion needs only $\mathop{\mathrm{tr}}B_{\mathrm{Ric}}^-+\mathop{\mathrm{tr}}B_{\Lambda^4}^-<T-\tfrac p4$, which is at least $p(\kappa-n+5)/(32\kappa)$ by `margin_lower`.** The Ricci term is $B_{\mathrm{Ric}}=-\tfrac1{2(n-2)}\big(\langle h_\alpha,\mathring eh_\beta\rangle\big)$, whose negative part has trace at most $\tfrac1{2(n-2)}\sum_\alpha\langle h_\alpha,\mathring e^+h_\alpha\rangle\le\tfrac{\lVert\mathring e^+\rVert}{2(n-2)}\,S_{02}$, with $S_{02}=\sum_{u\in E_0,v\in E_2}\lvert h_{uv}\rvert^2$ the cross anticommutator mass, a class-level quantity; the $\Lambda^4$ term likewise through the cross Bianchi overlap. **The record's identity $\mathcal R_x+\mathcal S_x=D(xx^{\mathsf T})$ (above) bounds $S_{02}$ at the right scale**: summed over a basis of $E_2$, $\sum_v\mathcal S_x(v)\le\mathop{\mathrm{tr}}D(xx^{\mathsf T})=(n-1)\mathop{\mathrm{tr}}(xx^{\mathsf T})=2(n-1)$, so $S_{02}\le2p(n-1)$ and $\mathop{\mathrm{tr}}B_{\mathrm{Ric}}^-\lesssim\lVert\mathring e^+\rVert\,p$. **Against the corrected margin $\approx p(3+n\delta)/(32n)$ this closes only if $\lVert\mathring e^+\rVert$ on the span of the $h_{uv}$ is $O(1/n)$ near $\theta_0$**, while Huisken's inequality gives only $O(1)$. *So the trace route needs a cancellation in $\langle h_{uv},\mathring e\,h_{uv}\rangle$ over the cross pairs, not a norm bound; for $\theta$ a fixed factor above $\theta_0$ the margin is $O(\delta)$ and the same estimate reaches it once $\lVert\mathring e^+\rVert\lesssim\delta/32$.* Linear algebra on the reviewed pieces; normalisations as in the half-summed note, unchecked; no computation.
> 

## Givens (audited)

- The rank certificate and its class form ([r1146](REVIEW_r1146.md), [r1147](REVIEW_r1147.md), [r1149](REVIEW_r1149.md), [r1150](REVIEW_r1150.md)): $\lambda_{\max}(L_e)\ge2\lambda_{\max}(B_{\mathrm{full}})$ from $G\preceq\tfrac12I$; $\lambda_{\max}(B_{\mathrm{lead}})\ge T/p$ with $B_{\mathrm{lead}}\preceq M_0$, $\mathop{\mathrm{rank}}M_0=p$; $2T/p-\tfrac12=-D/(p\kappa)$; $16D=(n-5-\kappa)p-4t_{000}-t_{011}-4t_{122}$ on the traced rows, $t_{abc}\ge0$.
- Symmetric family: $\lambda=(-a,0,a)$, $\dim E_0=\dim E_2=p$, $\dim E_1=m$, $2p+m=\binom n2$, $a=1/\sqrt{2p}$, $\kappa=\theta\sqrt{2p}$, $\theta_0(n)^2=2(n-1)(n-2)/n^2$.
- The per-vector identity $\mathcal R_x+\mathcal S_x=D(xx^{\mathsf T})$ as stated in the working file's paragraph "Per vector it is weak", with $\mathcal S_x(y)=\tfrac14\lVert\{x,y\}\rVert_F^2$.

## Lean

| claim | declaration |
|---|---|
| margin $\ge(\kappa-(n-5))/(16\kappa)$ on the rows | `margin_lower` in [ClassTraceTest.lean](../lean/HamiltonsCubic/Results/ClassTraceTest.lean) |
| the band's location, $\kappa\le\theta\sqrt{n(n-1)/2}$, the margin's size near $\theta_0$ | none: scalar arithmetic on the family's dimension count, stated in prose |
| the trace reduction and the $S_{02}$ bound | none: the pair matrix and the anticommutator family have no declarations in the layer |

## Items

1. Is the margin paragraph right as corrected: is $\kappa\le\theta\sqrt{n(n-1)/2}\approx(n-2)(1+\delta)$ at $\theta=\theta_0(1+\delta)$ right, and is the margin $\approx(3+n\delta)/(16n)$?
2. The band paragraph: the range of $p$, its width, $m=O(n)$ inside it, and "$m=0$ is excluded inside the band".
3. The trace reduction: does $\lambda_{\max}(L_e)\ge\tfrac2p(T-\mathop{\mathrm{tr}}B_{\mathrm{Ric}}^--\mathop{\mathrm{tr}}B_{\Lambda^4}^-)$ follow (including when $\dim V_+<p$, and the sign condition)? Is the Ricci negative-part bound right, and is $S_{02}\le2p(n-1)$ right from the identity (check $\mathop{\mathrm{tr}}D(xx^{\mathsf T})$ and the normalisations)?
4. Is any conclusion stated beyond what these support, in particular the final sentence about $\lVert\mathring e^+\rVert=O(1/n)$?

## Protocol

Reviewer N (1155 or 1156) logs to `agent_logs/rN.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_rN.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md` or any other file; do not read the other reviewer's report or log. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
