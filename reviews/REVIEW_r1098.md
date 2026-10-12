# Review r1098: section 5 of the I73c summed-pairs note

*Reviewer r1098, 2026-09-23. Target: section 5 and "What (c) now is" of [2026-09-23-I73c-summed-pairs.md](2026-09-23-I73c-summed-pairs.md) at 5c6281b6. Log: [agent_logs/r1098-c5.log](../agent_logs/r1098-c5.log). Analysis-only brief: every computation below is a screen of seconds on objects built here, using only `structure_constants`, `weyl_projector`, `sharp_mat` and `circ` from [screen_I73_pair_direction.py](../scripts/misc/screen_I73_pair_direction.py). Screen scripts live in the session scratchpad and are not committed.*

| # | claim | verdict |
|---|---|---|
| D1 | $\Lambda^4$ operator trace, factor 8, bound $3\varepsilon_{\max}\lVert N_4\rVert^2$ | CONFIRMED |
| D2 | $\mathring\mu$ cap from the projection estimate, Ricci correction bound | CONFIRMED, with a note on $\Theta_n$ |
| D3 | the per-eigenspace-pair inequality | CONFIRMED |
| D4 | equality at padded $W_{\mathbb{CP}^2}$ on the $(-\tfrac13,\tfrac23)$ pair | CONFIRMED, and the equality is vacuous |
| D5 | Schur reductions and $\Phi(e;e,e^2)$ | CONFIRMED constants once $\Phi,\Omega$ are defined (the note never defines them), last clause PLAUSIBLE |
| D6 | "every symbol is pinned, spectral, $\theta$, or one Gram parameter" | GAP: $\tau_{abc}$ is not pinned |

## D1, CONFIRMED

- The basis $\{\varphi_{ij}\}_{i<j}$ is orthonormal for $\langle\cdot,\cdot\rangle$, so an operator's matrix entries are $R_{ijkl}$ with $i<j$, $k<l$, and $\operatorname{tr}(e\,\omega^2)=\sum_{i<j,\,k<l,\,a<b}e_{ijkl}\omega_{klab}\omega_{abij}$.
- Passing to ordered pairs doubles each of the three pair sums, a factor $2^3=8$, and $\omega_{abij}=\omega_{ijab}$ (a pair swap is an even permutation of a 4-form) turns the result into $\sum e_{ijkl}\omega_{ijab}\omega_{klab}$. The factor 8 is right.
- With L234's $\tfrac38$: $\langle N_4,e\circ N_4\rangle=3\operatorname{tr}(eN_4^2)$. Since $N_4$ is symmetric, $N_4^2\succeq0$ and $\operatorname{tr}(eN_4^2)\le\varepsilon_{\max}\operatorname{tr}(N_4^2)$, with $\lVert N_4\rVert^2=\operatorname{tr}(N_4^2)$ in the convention that gives $\lVert Y_0\rVert^2=\tfrac12$.
- Screen, $n=6,7$, random Weyl $e$ and random orthonormal pairs: factor 8 to $3\cdot10^{-17}$, $\langle N_4,e\circ N_4\rangle=3\operatorname{tr}(eN_4^2)$ to $2\cdot10^{-18}$, $\lVert N_4\rVert^2=\tfrac16(1-g)$ to $10^{-16}$, the L234 split and the vanishing $N_4$–$N_r$ cross term to $3\cdot10^{-17}$. Slack of the bound positive at every sample.
- "$\nu\le8\varepsilon_{\max}$" is right as an upper bound on section 4's $\nu$.

## D2, CONFIRMED

- **Index order.** The note's operator $h\mapsto\sum_{jl}e_{ijkl}h_{jl}$ contracts slots 2 and 4. The record's $\mathring W$ is Li's, $(\mathring Wh)_{ik}=\sum W_{ijlk}h_{jl}$ ([conventions.md](../findings/conventions.md), "SETTLED on Li's $iklj$"), and $W_{ijkl}=-W_{ijlk}$, so the note's operator is $-\mathring W/\theta$. Screened: the two spectra are negatives at random Weyl $W$, $n=6,7$.
- **Sign of $\mu$.** [target.md](../findings/target.md) and [bispectral.md](../findings/bispectral.md) define $\mu$ by $\mathring Wh=-\mu h$ at the bottom of $\mathring W$ on $S^2_0$, at unit $W$. The top of $-\mathring W$ is therefore $\mu$, and at $e=W/\theta$ the top of the note's operator is $\mathring\mu=\mu/\theta$. Conventions match.
- **Scope of the estimate.** bispectral.md states the cap $\mu\le n\theta_0(n)/(n-1)$ "unconditionally", frame by frame, at every unit Weyl $W$. It needs neither criticality nor a maximiser, and section 5 assumes no $\theta\ge\Theta_n$: the cap is kept as $n\Theta_n/((n-1)\theta)$. Screened: $\tfrac{n-1}n\mu/\Theta_n\le0.63$ at random unit Weyl, $n=6,7$.
- **$\Theta_n$.** The note leaves $\Theta_n$ undefined, and this brief wrote it as $\sqrt{2(n-1)(n-2)}/n$, which is $\theta_0(n)$. The record's $\Theta_n$ equals $\theta_0(n)$ at even $n$ and is smaller at odd $n$ ([conventions.md](../findings/conventions.md)). The odd-$n$ estimate rests on the vertex-space argument, which bispectral.md takes from the external report, Gate 2 by [r555](REVIEW_r555.md) and [r556](REVIEW_r556.md). With $\theta_0(n)$ in place of $\Theta_n$, the cap is proved inside bispectral.md at every $n$. *Correction: define $\Theta_n$ in the note, or state the cap with $\theta_0(n)$ and add that the odd-$n$ sharpening is available.*
- **Ricci bound.** L234 gives $\langle N_r,e\circ N_r\rangle=\frac1{2(n-2)}\sum e_{ijkl}h_{ik}h_{jl}=\frac1{2(n-2)}\langle h,\mathring{S}h\rangle_F$, where $\mathring S$ is the note's operator. Here $h\in S^2_0$ because $\operatorname{tr}h=-\operatorname{tr}(UV)=2\langle u,v\rangle=0$, and $\lvert h\rvert^2$ is the full Frobenius norm, as section 2 uses it. Screened to $10^{-17}$, with the bound's slack positive.

## D3, CONFIRMED

The chain, link by link:

- Section 1 gives $\sum[\langle X,e\circ X\rangle-\tfrac12\lVert X\rVert^2]\le0$.
- Substituting L234 and section 2's $\lVert X\rVert^2$: $\sum[\langle Y_0,e\circ Y_0\rangle-\tfrac14]\le\sum[C_r-\tfrac{\lvert h\rvert^2}{2(n-2)}]+\sum[C_4-\tfrac12\lVert N_4\rVert^2]$, with $C_r,C_4$ the two corrections.
- Both corrections sit on the right with a plus sign, so an **upper** bound on each keeps the inequality valid. D1 and D2 supply exactly upper bounds.
- The summed norms are section 2's: $\sum\lvert h\rvert^2=G_{ab}-\tfrac12\tau_{ab}$ and $\sum\lVert N_4\rVert^2=\tfrac16(m_am_b-G_{ab})$. The left side is section 4's pinned sum minus $\tfrac14m_am_b$. That gives the display exactly.
- **Direction of the $\mathring\mu-1$ coefficient.** It multiplies $\sum\lvert h\rvert^2\ge0$, so replacing $\mathring\mu$ by its cap keeps the direction whatever the sign of $\mathring\mu-1$. The $(3\varepsilon_{\max}-\tfrac12)$ coefficient is exact (nothing is substituted into it) and multiplies $\sum\lVert N_4\rVert^2\ge0$.
- *Advice for the class-level system:* carry $G_{ab}-\tfrac12\tau_{ab}\ge0$ and $m_am_b-G_{ab}\ge0$ as explicit constraints, since a relaxation in $(\tau,G)$ does not inherit them automatically.
- Screen at padded $W_{\mathbb{CP}^2}$, $n=6,8$: the exact $S_{ab}$ and both correction sums reproduce the display's terms, and the left-side formula matches the direct sum to machine precision.

## D4, CONFIRMED, and the equality is vacuous

- Screen, $n=6$ and $8$: $\theta=\sqrt{3/2}$, criticality residual $\le4\cdot10^{-15}$, values $(-\tfrac13,0,\tfrac23)$ with multiplicities $(2,12,1)$ and $(2,25,1)$, $\mathring\mu=\tfrac23$, cap $1.033$ and $1.069$.
- The inequality holds on all three pairs and is an equality on $(-\tfrac13,\tfrac23)$. **Every term there is zero**: $\sum\lvert h\rvert^2=0$ ($G=2$, $\tau_{ab}=4$), $\sum\lVert N_4\rVert^2=0$ ($m_am_b=G=2$), left side $0$, both corrections $0$. Both vectors lie in $\Lambda^2_+(\mathbb R^4)$, so $Y_0$ is already Weyl and nothing is projected away. **The equality therefore tests neither bound of section 5.**
- On the other two pairs the bounds are loose. For $n=6$, $(-\tfrac13,0)$: exact correction side $-2.39$ against bound $2.08$ at the true $\mathring\mu$, with $C_4=-0.056$ against $3\varepsilon_{\max}\lVert N_4\rVert^2=3.33$. The $\varepsilon_{\max}$ bound on the $\Lambda^4$ term is the looser of the two by far.
- *Correction to the note's wording:* say the equality is the trivial one, the pair on which $\pi_{\mathcal W_n}$ acts as the identity.

## D5, CONFIRMED constants, symbols undefined, last clause PLAUSIBLE

- **$\Phi$ and $\Omega$ are never defined in the note.** Reverse-engineered from the constants:
  - $\Omega(e;P,P')$ is the polarisation of $\sum_{\alpha,\beta}\sum e_{ijkl}\omega_{ijab}\omega_{klab}$, the raw $\Lambda^4$ contraction.
  - $\Phi(e;P,P')$ is the polarisation of $\sum e_{ijkl}\{U,V\}_{ik}\{U,V\}_{jl}$, which is **four times** the $h$-contraction L234 uses, since $h=-\tfrac12\{U,V\}$.
  - So the summed corrections are $\tfrac{\Phi}{8(n-2)}$ and $\tfrac38\Omega$. *Correction: write these definitions into the note.*
- **Screened constants,** $n=6,7$, random Weyl $e$, random symmetric $Y$:
  - $\Phi(e;\mathrm{Id},Y)/\langle e,Y\rangle=12$, since the $h$-form gives $3.000000$.
  - $\Omega(e;\mathrm{Id},Y)/\langle e,Y\rangle=0.222222$ and $0.666667$, which is $(n-4)(n-5)/9$.
  - $\Phi(e;e,e)=8\operatorname{tr}e^3-4\langle e,e^\#\rangle$ to all printed digits.
  - $\Phi(e;e,e)/\Omega(e;e,e)=9.000000$.
- **Schur argument.** Each form is linear in $e\in\mathcal W_n$ and linear in $Y\in\operatorname{Sym}^2\Lambda^2$, and $O(n)$-invariant. $\mathcal W_n$ occurs once in $\operatorname{Sym}^2\Lambda^2=\mathbb R\oplus S^2_0\oplus\mathcal W_n\oplus\Lambda^4$, so each form is a multiple of $\langle e,\pi_{\mathcal W}Y\rangle=\langle e,Y\rangle$. This is sound.
- **"Spectral at a critical point".** $Q(e)=e$ at $e=W/\theta$, so $\langle e,e^\#\rangle=\theta^{-2}-\operatorname{tr}e^3$. Correct.
- **$\Phi(e;e,e^2)$.** Screen at $n=6$, 14 random Weyl $e$: least squares against the six listed quartics leaves relative residual $9\cdot10^{-3}$, while a control built in their span fits to $4\cdot10^{-16}$. So it is outside that span (screen, random $e$ only; I did not reproduce the twelve critical points).
- **"A quartic invariant outside the pinned data"** is stronger than the screen supports, because the six are not shown to span the pinned quartics. PLAUSIBLE. It is not load-bearing, since section 5 routes around the exact term.

## D6, GAP: $\tau_{abc}$ is not pinned

- **$\tau_{abc}$ is not pinned.** At three values it is $\sum L_a(\lambda_\alpha)L_b(\lambda_\beta)L_c(\lambda_\gamma)T_{\alpha\beta\gamma}$ with each Lagrange $L$ quadratic, so it involves exponents up to $(2,2,2)$.
- The record states that the per-index relations pin $\sum\lambda^p\lambda^q\lambda^rT$ **only when two exponents are $\le1$** ([INDEX-traps.md](../findings/INDEX-traps.md), row 42), and names $\{2,2,0\}$ as the first moment beyond them. The inequality's $\tau_{ab}$ is a class $\{2,2,0\}$ moment and $\sum_c\varepsilon_c\tau_{abc}$ is $\{2,2,1\}$.
- The $\tau_{abc}$ are the **variables** of [Lemma L104](../findings/bounds-relaxations.md)'s pinned programme, $\binom{d+2}3=10$ class unknowns at $d=3$ constrained by the rows (A), (B), (C), not data the rows determine. The note's own last sentence ("eliminate ... the $\tau$-classes against the per-index rows") treats them as unknowns, which contradicts "every symbol is pinned".
- **The other symbols are fine.**
  - $\varepsilon_{\max}$ and the $\varepsilon_a$ are spectral.
  - $\theta$ is spectral too, $\sum m_a\varepsilon_a^2=\lVert e\rVert^2=\theta^{-2}$.
  - $\mathring\mu$ leaves the system once the cap is substituted, which D3 licenses.
  - $G$ carries one parameter (section 3, given).
- **Corrected sentence:** "every symbol in it is spectral in $(\varepsilon,m)$ (which fixes $\theta$), the one Gram parameter, or a class variable $\tau_{abc}$ of [L104](../findings/bounds-relaxations.md)'s programme, constrained by the per-index rows and $\tau\ge0$". The "finite question at fixed $(n,m_1,m_2,m_3)$" survives, as a finite semialgebraic feasibility problem in $(\varepsilon,\tau,G_{12})$.

## Summary

Section 5's chain is correct link by link, including the parts most likely to break:

- **The factor 8** is ordered-pair counting with $\omega_{abij}=\omega_{ijab}$.
- **The sign convention for $\mu$.** The note's operator is $-\mathring W/\theta$ in the record's Li order, so its top eigenvalue is $\mu/\theta$ with $\mu$ as the projection estimate defines it at unit $W$.
- **The scope of the projection estimate.** It holds at every unit Weyl tensor, and section 5 assumes no $\theta\ge\Theta_n$.
- **Every correction bound has the right direction.** Each is an upper bound on a term on the right-hand side, multiplying a nonnegative summed norm.

Three repairs are owed to the text:

- $\Phi$, $\Omega$ and $\Theta_n$ are used undefined. $\Phi$ is four times the $h$-contraction.
- The $W_{\mathbb{CP}^2}$ equality is $0=0$ on a pair that $\pi_{\mathcal W_n}$ fixes, so it validates neither bound.
- The closing claim that every symbol is "pinned, spectral, $\theta$, or one Gram parameter" is false for $\tau_{abc}$, which are the unpinned class variables of L104's programme (the $\{2,2,0\}$ moment and above).
