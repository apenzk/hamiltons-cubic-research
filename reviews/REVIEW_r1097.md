# REVIEW r1097: section 5 of the I73c summed-pairs note

*Reviewer r1097, 2026-09-23. Target: section 5 and "What (c) now is" of [2026-09-23-I73c-summed-pairs.md](2026-09-23-I73c-summed-pairs.md) at 5c6281b6. Log: [agent_logs/r1097-c5.log](../agent_logs/r1097-c5.log). Analysis only. Every computation below is a screen of seconds to a few minutes on objects built here, using only `structure_constants`, `weyl_projector`, `sharp_mat` and `circ` from [screen_I73_pair_direction.py](../scripts/misc/screen_I73_pair_direction.py). No Lean was run.*

## Verdicts

| # | claim | verdict |
|---|---|---|
| D1 | $\sum e_{ijkl}\omega_{ijab}\omega_{klab}=8\operatorname{tr}(e\,\omega^2)$ and $\langle N_4,e\circ N_4\rangle=3\operatorname{tr}(eN_4^2)\le3\varepsilon_{\max}\lVert N_4\rVert^2$ | CONFIRMED |
| D2 | $\mathring\mu\le\frac{n\Theta_n}{(n-1)\theta}$ and the Ricci correction $\le\frac{\mathring\mu}{2(n-2)}\lvert h\rvert^2$, conventions matching | CONFIRMED, one notational repair |
| D3 | the per-eigenspace-pair inequality, every direction | CONFIRMED |
| D4 | equality at padded $W_{\mathbb{CP}^2}$ on the $(-\tfrac13,\tfrac23)$ pair | CONFIRMED, and the equality tests neither relaxation |
| D5 | the Schur constants and $\Phi(e;e,e)=9\Omega(e;e,e)$ | CONFIRMED under a normalisation the note never states |
| D5' | $\Phi(e;e,e^2)$ lies outside the pinned data | REFUTED (screen plus mechanism) |
| D6 | every symbol is pinned, spectral, $\theta$ or the Gram parameter | GAP |

## D1

**The factor 8, link by link.** With $\omega_{ijkl}=\langle\varphi_{ij},\omega\varphi_{kl}\rangle$, the ordered sum over $(i,j)$, $(k,l)$, $(a,b)$ visits each unordered pair twice. Swapping $i\leftrightarrow j$ flips the sign of both $e_{ijkl}$ and $\omega_{ijab}$, swapping $k\leftrightarrow l$ flips $e$ and $\omega_{klab}$, and swapping $a\leftrightarrow b$ flips both $\omega$ factors, so every one of the $2^3$ orderings contributes the same sign. The unordered sum is $\sum_{PQR}e_{PQ}\omega_{PR}\omega_{QR}=\operatorname{tr}(e\,\omega^2)$ by symmetry of both operators. The identity is pure counting and holds for every symmetric $e$, Weyl or not. With [L234](../findings/second-order.md)'s $\tfrac38$ the correction is $3\operatorname{tr}(e\,N_4^2)$, and $\operatorname{tr}(e\,N_4^2)=\operatorname{tr}(N_4eN_4)\le\varepsilon_{\max}\operatorname{tr}(N_4^2)=\varepsilon_{\max}\lVert N_4\rVert^2$, the norm being the Frobenius norm on $\mathrm{Sym}^2\Lambda^2$ under which $\lVert Y_0\rVert^2=\tfrac12$. So $\nu\le8\varepsilon_{\max}$.

*Screen.* The ratio is $1$ to $10^{-15}$ at a generic symmetric (non-Weyl) $e$ at $n=5$ and at random Weyl $e$ at $n=6,7$. At $n=5$ with Weyl $e$ both sides are $10^{-16}$, as L234 says. The whole L234 decomposition, $\langle Y_0,e\circ Y_0\rangle-\langle X,e\circ X\rangle-\frac1{2(n-2)}\langle h,\mathring eh\rangle=3\operatorname{tr}(e\omega^2)$ together with $\lVert\omega\rVert^2=\tfrac16(1-g)$ and the norm of $X$, reproduces to $10^{-14}$ at $n=5,6,7$ on eigenvector pairs of random Weyl $e$, and both bounds hold at every sample.

## D2

**The sign convention matches.** The record's $\mathring W$ is Li's, $(\mathring Wh)_{ij}=\sum_{kl}W_{iklj}h_{kl}$ ([conventions.md](../findings/conventions.md)), and $\mu=-\omega_{\min}$ ([bispectral.md](../findings/bispectral.md), the boxed cap). The note's operator $h\mapsto\sum_{jl}e_{ijkl}h_{jl}$ is $-\mathring e$ in Li's order because $W_{iklj}=-W_{ikjl}$. Its top eigenvalue is therefore $\mu(W)/\theta$ at $e=W/\theta$ with $\theta>0$, which the setting assumes. *Screened: top of the note's operator equals $-\min$ of Li's to machine precision at unit random Weyl $W$, $n=5,6,7$.* The pair's $h=-\tfrac12\{U,V\}$ is trace-free ($\operatorname{tr}UV=-2\langle u,v\rangle=0$), so the Rayleigh bound on $S^2_0$ applies. The L234 term $\sum e_{ijkl}h_{ik}h_{jl}$ equals $\langle h,\mathring eh\rangle$ in the note's convention, and $\lvert h\rvert^2$ is Frobenius, consistent with section 2.

**The cap holds at every unit Weyl tensor.** bispectral.md's boxed $\mu\le\sqrt{2(n-2)/(n-1)}=\frac n{n-1}\theta_0(n)$ is argued frame by frame with no criticality and no maximality, and section 5 does not assume $\theta\ge\Theta_n$ (that clause belongs to section 4's remark only).

**Notational repair.** Section 5 uses $\Theta_n$ without defining it. The record's $\Theta_n$ ([conventions.md](../findings/conventions.md)) equals $\theta_0(n)$ at even $n$ and is $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, where its cap rests on the vertex-space form and the external report (Gate 2 r555, r556). The brief's $\Theta_n=\sqrt{2(n-1)(n-2)}/n$ is $\theta_0(n)$, whose cap is the unconditional boxed one. Either reading gives a valid inequality. The note should name which one it uses.

## D3

From L125 with $\langle W,X\rangle=0$ and L234, each pair gives
$$\langle Y_0,e\circ Y_0\rangle-\tfrac14\le\Big(C_r-\frac{\lvert h\rvert^2}{2(n-2)}\Big)+\Big(C_4-\tfrac12\lVert\omega\rVert^2\Big),$$
with $C_r=\frac{\langle h,\mathring eh\rangle}{2(n-2)}$ and $C_4=3\operatorname{tr}(e\omega^2)$. Replacing $C_r$ and $C_4$ by the upper bounds of D1 and D2 enlarges the right side, so the result is a valid necessary condition. The coefficient of $\mathring\mu$ after summing is $\frac{G_{ab}-\frac12\tau_{ab}}{2(n-2)}=\frac1{2(n-2)}\sum\lvert h\rvert^2\ge0$, so substituting the cap $\mathring\mu\le\frac{n\Theta_n}{(n-1)\theta}$ is monotone in the right direction. The summed left side is section 4's pinned unprojected part minus $\tfrac14m_am_b$, and the norm sums are section 2's. Every link checks. *Presentation point:* the display carries the cap as a side condition, and the sentence "an explicit inequality in the pinned data, the Gram and $\theta$" is true only after the cap is substituted, which the note should do in the display and justify by the sign of $G_{ab}-\tfrac12\tau_{ab}$.

## D4

*Screened at $n=6,8$*, with $W_{\mathbb{CP}^2}=2\omega_1\omega_1^{\mathsf T}-\omega_2\omega_2^{\mathsf T}-\omega_3\omega_3^{\mathsf T}$ on $\Lambda^+\mathbb R^4$, padded and normalised: Weyl to $10^{-15}$, critical to $4\cdot10^{-15}$, $\theta=\sqrt{3/2}$, values $\tfrac23,-\tfrac13,0$.

| $n$ | pair | LHS | RHS | exact $S_{ab}$ |
|---|---|---|---|---|
| 6 | $(-\tfrac13,0)$ | $-8$ | $2.541$ | $-5.61$ |
| 6 | $(-\tfrac13,\tfrac23)$ | $0$ | $0$ | $0$ |
| 6 | $(0,\tfrac23)$ | $-1$ | $1.270$ | $-0.264$ |
| 8 | $(-\tfrac13,0)$ | $-16.667$ | $7.081$ | $-12.67$ |
| 8 | $(-\tfrac13,\tfrac23)$ | $0$ | $0$ | $0$ |
| 8 | $(0,\tfrac23)$ | $-2.083$ | $3.540$ | $-0.833$ |

**The equality is structural and tests neither bound.** Distinct self-dual forms anticommute and square to $-\tfrac12I_4$, so on that pair $h=0$ and $g=1$, hence $\lVert\omega\rVert^2=0$. Both corrections vanish, and both relaxations multiply zero. The screen confirms the claim as stated and says nothing about the tightness of $\varepsilon_{\max}$ or of the $\mathring\mu$ cap.

## D5 and D5'

**Normalisation.** The note never defines $\Phi$ or $\Omega$. Built on L234's own $h=-\tfrac12\{U,V\}$, $\Phi(e;A,B)=\sum a_\alpha b_\beta\sum e_{ijkl}h_{ik}h_{jl}$ gives $\Phi(e;\mathrm{Id},Y)=3\langle e,Y\rangle$ and $\Phi(e;e,e)=2\operatorname{tr}e^3-\langle e,e^\#\rangle$. The note's constants hold exactly for $\Phi$ built on $\{U,V\}$, that is four times L234's contraction, so the summed Ricci correction is $\Phi/(8(n-2))$. $\Omega$ built on L234's $\omega$ matches as written, with $\Omega(e;\mathrm{Id},Y)=\tfrac{(n-4)(n-5)}9\langle e,Y\rangle$ ($\tfrac29$ at $n=6$, $\tfrac23$ at $n=7$, screened to $10^{-14}$), the summed $\Lambda^4$ correction being $\tfrac38\Omega$, and $\Phi(e;e,e)=8\operatorname{tr}e^3-4\langle e,e^\#\rangle=9\Omega(e;e,e)$ to $10^{-16}$ at $n=6,7$. $\langle e,Y\rangle$ is the Frobenius pairing on $\mathrm{Sym}^2\Lambda^2$. The Schur argument is sound: $\mathrm{Id}$ is invariant, so $Y\mapsto\Phi(e;\mathrm{Id},Y)$ is an $O(n)$-invariant pairing of $\mathcal W_n$ with $\mathrm{Sym}^2\Lambda^2$, in which $\mathcal W_n$ occurs once. $\langle e,e^\#\rangle=\lVert e\rVert^2-\operatorname{tr}e^3$ (from $\langle W,Q(W)\rangle=\theta$ at unit $W$) is spectral at every point, not only at a critical one. **With the normalisation stated, D5 is CONFIRMED.**

**D5' is REFUTED.** The same Schur mechanism reaches $(e,e^2)$: $Y\mapsto\Phi(e;e,Y)$ is linear in $Y$ and $O(n)$-equivariantly quadratic in $e$, so $\Phi(e;e,Y)=\langle Y,B(e)\rangle$ with $B$ a quadratic equivariant $\mathcal W_n\to\mathrm{Sym}^2\Lambda^2$. Hence $\Phi(e;e,e^2)$ is a combination of the pairings of $e^2$ with the finitely many such equivariants, and the same holds for $\Omega$. *Screened at 14 random Weyl $e$ at $n=6$ and 12 at $n=7$, with the note's normalisation, residuals $\le4\cdot10^{-15}$ and the same rational coefficients at both $n$:*
$$\Phi(e;e,e^2)=4\lvert\operatorname{Ric}e^2\rvert^2-4\,m_{22}-2\,m_{211},$$
$$\Omega(e;e,e^2)=\tfrac49\operatorname{tr}e^4+\tfrac29\lVert e\rVert^4-\tfrac29\lvert\operatorname{Ric}e^2\rvert^2-\tfrac29m_{22}-\tfrac29m_{211},$$
with $m_{22}=\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\varepsilon_\alpha^2\varepsilon_\beta^2$ and $m_{211}=\sum T_{\alpha\beta\gamma}\varepsilon_\alpha\varepsilon_\beta\varepsilon_\gamma^2$ (the latter a multiple of $\langle e^2,e^\#\rangle$). The $\Omega$ form uses $\lVert\pi_{\Lambda^4}e^2\rVert^2=\tfrac13\operatorname{tr}e^4-\tfrac16\lvert\operatorname{Ric}e^2\rvert^2+\tfrac16m_{22}$, screened the same way. At three values these are class-level: $\lvert\operatorname{Ric}e^2\rvert^2=\sum_{ab}\varepsilon_a^2\varepsilon_b^2G_{ab}$, $m_{22}=\sum_{ab}\varepsilon_a^2\varepsilon_b^2\tau_{ab}$, $m_{211}=\sum_{abc}\varepsilon_a\varepsilon_b\varepsilon_c^2\tau_{abc}$. **So the $(e,e^2)$ entry lies inside $(\varepsilon,m,\tau,G)$.** The note's regression missed $m_{22}$, the one T-linear quartic that is not a multiple of $\langle e^2,e^\#\rangle$ or $\operatorname{tr}e^4$. Its list also contains $\langle e,e^\#e^2\rangle$, which is quintic and cannot enter a homogeneous quartic fit.

**What stays open.** The Lagrange polynomials make the exact summed corrections depend on the $(e^2,e^2)$ entries as well, $\Phi(e;e^2,e^2)$ and $\Omega(e;e^2,e^2)$, which are quintic and are not reached by the Schur mechanism above, since $e^2\otimes e^2$ is not a generic argument. A fit of each against a short T-linear and Gram quintic list left residuals of $3\%$ and $11\%$ at $n=6$, which is a failed guess and no evidence either way. So "the exact corrections do not reduce to the pinned calculus" is unestablished: the entry offered as the witness reduces, and the entries that might not reduce were never examined.

## D6

**$\varepsilon_{\max}$ is spectral**, the largest of the three $\varepsilon_a$, and $\varepsilon=\lambda/\theta$ converts it to the calculus's unit-$W$ eigenvalues. **$\tau_{abc}$ is not pinned.** In the record's usage the pinned class is the polyhedron of $T\ge0$ satisfying (A), (B), (C) ([L104](../findings/bounds-relaxations.md)), and its class variables have feasible dimension $4$ at $d=3$, $\theta$ included. At the actual $W$ the $\tau_{abc}$ are the true class sums, they satisfy the class-summed rows exactly, and they enter the section 5 inequality linearly with weights $\varepsilon_c$ and $1$, the same kind of weights the rows carry. That is the status of unknowns of the pinned programme. The note's own closing sentence ("eliminate the Gram parameter and the $\tau$-classes") treats them that way, which contradicts "every symbol is pinned, spectral, $\theta$, or that one Gram parameter". **Repair:** every symbol is spectral ($\varepsilon$, $m$, $\varepsilon_{\max}$), $\theta$, the class sums $\tau$ constrained by the class-summed rows, or the one Gram parameter $G_{12}$. At fixed $(n,m_1,m_2,m_3)$ the unknowns are then $(\varepsilon,\theta,\tau,G_{12})$, and the system is bilinear in $\varepsilon$ and $(\tau,G)$. "Finite question" is right in the sense of finite dimension.

## Summary

Section 5's inequality is correct and its chain is complete. The factor 8 is ordered-pair counting with the three sign flips cancelling, the note's operator is minus Li's $\mathring W$ so its top eigenvalue is the projection estimate's $\mu/\theta$, the cap holds at every unit Weyl tensor with no criticality or $\theta\ge\Theta_n$ needed, and every bound enters with the right direction because the $\mathring\mu$ coefficient is a sum of $\lvert h\rvert^2$. The padded $W_{\mathbb{CP}^2}$ equality is real but vacuous, both corrections being zero on that pair. The Schur constants hold only once $\Phi$ is defined on $\{U,V\}$ rather than on L234's $h$, which the note must state. The claim that $\Phi(e;e,e^2)$ carries a quartic invariant outside the pinned data is refuted: the same Schur mechanism puts both $(e,e^2)$ entries in $(\varepsilon,m,\tau,G)$, screened exact at $n=6,7$ with $n$-independent coefficients, the missing invariant being $\sum T\varepsilon_\alpha^2\varepsilon_\beta^2$. The $(e^2,e^2)$ entries are the real open question. "Every symbol is pinned" should read that $\tau$ is the pinned programme's unknown, not pinned data.
