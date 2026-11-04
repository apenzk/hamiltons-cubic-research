# r1108: I73(c) section 8, the pair test as one quantity in a window

*Gate 2 review of section 8 of [2026-09-23-I73c-summed-pairs.md](2026-09-23-I73c-summed-pairs.md) at commit 41df8828, sections 1 to 7 taken as given. Analysis first, screens of seconds on constructed objects, reported as screens. Log: [r1108-I73c-sec8.log](../agent_logs/r1108-I73c-sec8.log). Scratch scripts in the session scratchpad, not committed.*

| # | Claim | Verdict |
|---|---|---|
| 1 | The lemma, window $\Gamma/p\le I_1\le0$ | CONFIRMED, one side clause repaired |
| 2 | $I_1$'s $\tau$-part outside the span of rows (A)-(C) | CONFIRMED and PROVED: the $\tau$-part is a positive multiple of $m_{22}$ modulo the rows |
| 3 | The $n=8$ sign claim and its scope | CONFIRMED and upgraded from a five-spectrum screen to a statement at every three-valued spectrum |
| 4 | The control at padded $W_{\mathbb{CP}^2}$ | CONFIRMED, independently by direct projection |
| 5 | The LP screen | CONFIRMED as a screen, attribution of the infeasibility repaired |
| 6 | The route claim, a per-spectrum LP endgame | PLAUSIBLE, refined: the objective is one named moment, and a dimension count is wrong |
| 7 | Lean: pair_iff_window | CONFIRMED |

## 1. The lemma

- **The factor.** $p I_1+qI_2=p^2S_{12}+(p+q)^2S_{13}+q^2S_{23}=\sum_{a<b}(\varepsilon_a-\varepsilon_b)^2S_{ab}$. The ordered eigenpair sum of section 7 runs over ordered class pairs $a\ne b$, and $S_{ab}=S_{ba}$ because $X=\pi(\psi_\alpha\odot\psi_\beta)$ is symmetric in $\alpha,\beta$, so the ordered sum is $2\sum_{a<b}$ and $pI_1+qI_2$ is half of it, which is $\Gamma$ with the $\tfrac{n+4}{12}$ as written.
- **The signs.** $\varepsilon_1<\varepsilon_2<\varepsilon_3$ gives $p,q>0$, so $I_2=(\Gamma-pI_1)/q\le0$ is $I_1\ge\Gamma/p$. The window is nonempty exactly when $\Gamma\le0$, which is L236's corollary.
- **Formal versus evaluated.** As an expression in the class unknowns $(\tau,G_{12})$, $pI_1+qI_2-\Gamma$ is a combination of rows (A)-(C) (L236's proof uses (A), (B) and $m_{111}=2(E_2-E_3)$, which is $\sum_a\varepsilon_a(\mathrm C_a)$). So the lemma holds on the row-feasible set, which is where section 8 uses it.
- **Repair to the side clause.** "Automatic above $\sqrt{3/2}$" is proved by Okumura only at $n\ge11$ and screened at $n=6,7,8$ (section 7). At $n=9,10$ the Okumura threshold is $1.277$ and $1.243$, both above $\sqrt{3/2}=1.2247$, and no screen is on file. Suggested text: "which is automatic above $\sqrt{3/2}$ at $n\ge11$, screened at $n=6,7,8$, and open at $n=9,10$".

## 2. The row-span claim, with a proof

**The encoding is faithful.** [screen_I73c_I1_rowspan.py](../scripts/misc/screen_I73c_I1_rowspan.py) stores $\tau$ on sorted triples, so total symmetry is built in. Its rows are L104's (A), (B), (C) summed over a class and divided by $\theta^2$ ($\nu=\theta\varepsilon$ turns $2\nu(\theta-\nu)$ into $2\varepsilon(1-\varepsilon)$). Its moments $M_{ij}$ match sections 5 and 6 entry by entry, and $S_{ab}=U-\Phi/(8(n-2))-\tfrac38\Omega-\tfrac12N$ is section 6's. Its Gram parametrisation satisfies the six linear equations of section 3 exactly (checked in sympy at 18 spectra). The samples have every $m_a\ge3$, so all ten types are admissible. The rows have rank $7$ (L104's two dependencies), so three class coordinates are free.

**The row span, described.** At three values a class functional is a symmetric function $f$ on $\{\varepsilon_1,\varepsilon_2,\varepsilon_3\}^3$, spanned by monomials with every exponent at most $2$. Row $a$ contributes $\sum_{b,c}\tau_{abc}\varphi_a(\varepsilon_b,\varepsilon_c)$ with $\varphi_a\in\{1,y,yz\}$. The homogeneous kernel of the rows is exactly $\{\mathrm{Sym}(u\otimes\ell\otimes\ell):u\in\mathbb R^3\}$ with $\ell_a$ the Lagrange leading coefficients, because $D(g)=\sum_b\ell_bg(\varepsilon_b)$ kills $1$ and $y$. So a functional lies in the row span iff it vanishes on these three vectors.

**The reduction.** Pair it against $\mathrm{Sym}(u\otimes\ell\otimes\ell)$:

- The pair-specific parts $-\tfrac14\sum_c(\varepsilon_c+\tfrac1{n-2})\tau_{abc}$ of $S_{12}$ and $S_{13}$ pair to $\tfrac13(w_{12}\ell_1\ell_2+w_{13}\ell_1\ell_3)\sum_cu_cg_c$, which is $0$ on $(p,p+q)$ by section 6's identity. **They lie in the row span.**
- $m_{211}$ has at most one exponent $2$, so it lies in the row span ($m_{211}=2(E_3-E_4)$ on the rows).
- $m_{22}=\sum\varepsilon_a^2\varepsilon_b^2\tau_{abc}$ pairs to $\tfrac13\sum_au_a\ne0$. It enters $I_1$ through $M_{12}$ only, with coefficient $\big(\tfrac1{2(n-2)}+\tfrac1{12}\big)\sum w_{ab}\kappa_{ab}=\frac{n+4}{12(n-2)\,p(p+q)}$, where $\kappa_{ab}=-\ell_a\ell_b(2\sigma-\varepsilon_a-\varepsilon_b)$ and $\sum w\kappa=\tfrac1{p(p+q)}$ by section 7.

**Result.** Modulo rows (A)-(C), at every three-valued spectrum with all $m_a\ge3$ and every $n$,
$$I_1\equiv C(\varepsilon,m,n)+\frac{n+4}{12(n-2)\,p(p+q)}\,m_{22}-c\,pq\,G_{12},\qquad c=\frac{n-8}{12(n-2)} .$$
*Screened exact in rational arithmetic: $I_1$ minus the last two terms has its $\tau$- and $G_{12}$-parts in the row span at five spectra, $n=6,7,8,10,10$.* So the non-membership is structural, not an encoding artefact: **$I_1$ carries exactly one datum beyond the rows, the unpinned $(2,2,0)$ moment of [INDEX-traps.md](../findings/INDEX-traps.md) row 42**, and the window reads $\Gamma/p\le C+K\,m_{22}-c\,pq\,G_{12}\le0$. *Suggested for the note: replace the three-spectrum screen sentence by this reduction, which is a hand derivation.*

## 3. The $n=8$ sign claim

With free coordinates $(\tau_{123},\tau_{111},\tau_{333})$ the kernel vectors dual to them give $m_{22}$ coefficients $\tfrac1{\ell_1\ell_3}$, $\tfrac{\ell_1-\ell_2}{3\ell_1^3}$, $\tfrac{\ell_3-\ell_2}{3\ell_3^3}$, all positive since $\ell_1,\ell_3>0>\ell_2$. Times $K$, the coefficients of $I_1$ are
$$\frac{n+4}{12(n-2)}\,q(p+q),\qquad \frac{n+4}{36(n-2)}\cdot\frac{p(p+q)(p+2q)}{q},\qquad \frac{n+4}{36(n-2)}\cdot\frac{q^2(p+q)(2p+q)}{p^2}.$$
*Screened: these match the reduced coefficients at eight $n=8$ spectra (for instance $0.15995$, $0.27739$, $0.09554$ at $m=(10,11,7)$), one of them at $\theta=1.54$.* **So the claim holds at every three-valued spectrum and at every $n$ for the $\tau$-part**, not only at five sampled spectra outside the regime. The scope sentence "at spectra outside the regime of interest" can go. At $n\ne8$ the $G_{12}$ term rides along, and the cut is on the pair $(m_{22},G_{12})$.

## 4. The control

Reproduced: rows exact, $I_1=-38/9$, window $[-16/3,0]$ ($\Gamma=-16/9$, $p=1/3$). **The note's control evaluates the class formula at the point's own class data, so it checks the rows and the formula's value at one point, not the formula against the geometry.** An independent check closes that: by direct projection over all eigenpairs of padded $W_{\mathbb{CP}^2}$, $n=8$, $S_{12}=-38/3$, $S_{13}=0$ (the vacuous pair of section 5), $S_{23}=-5/6$, hence $I_1=-4.2222222180$ (equal to $-38/9$ to $4\times10^{-9}$, eigenvalue rounding), $I_2=-5/9$, and $pI_1+qI_2=-16/9=\Gamma$. *Suggested for the note: cite the direct-projection value beside the class value, which is what supports "the encoding is faithful".*

## 5. The LP screen

- **Constraints are valid necessary conditions.** The pair cap in class form is $\tau_{ab}/(m_a(m_b-\delta_{ab}))\le2$, the average of the per-pair cap $\sum_\gamma T\le2$ over the pairs in $a\times b$, valid without averaging $T$. $G_{ab}\ge\tfrac12\tau_{ab}$ is $\lvert h\rvert^2\ge0$ summed, $G_{ab}\le m_am_b$ is $\lVert N_4\rVert^2\ge0$, $G_{ab}\ge0$ holds for PSD $A_a$, $G_{aa}\ge4m_a^2/n$ is Cauchy-Schwarz on $\mathop{\mathrm{tr}}A_a=2m_a$. The Cauchy-Schwarz constraints are affine: their $G_{12}^2$ coefficient is exactly $0$ at all 18 spectra, so the `coeff` extraction drops nothing.
- **"17 of 18 infeasible before the window" is reproduced.** The feasible one is $n=10$, $m=(16,15,14)$, $\theta=1.25$, $I_1\in[-16.96,-16.92]$ inside $[-43.45,0]$.
- **Repair: the infeasibility is L104's, not the Gram system's.** Layered, all 17 are already infeasible at rows plus $\tau\ge0$ alone, that is $\Pi(\lambda)=\varnothing$, before any pair cap or Gram constraint. Rerunning with exact tracelessness ($\varepsilon_3$ recomputed from $\varepsilon_1,\varepsilon_2$, since limit_denominator breaks it at $10^{-16}$ and the rank-deficient rows need it) gives the same verdicts. So no constraint of section 8 is at fault, **and the sample mostly tests nothing: 17 of the random spectra are not critical spectra by L104.** Suggested text: "17 are infeasible already at rows (A)-(C) and $\tau\ge0$, L104's $\Pi(\lambda)$ being empty there, so only one spectrum tests the window". A screen that tests the window should draw spectra with $\Pi(\lambda)\ne\varnothing$.
- **Scoped as a screen**: yes.

## 6. The route claim

- **Dimension repair.** "A polytope of dimension at most $5$ (four class directions and $G_{12}$)" should read **at most $4$ (three class directions and $G_{12}$)**. At fixed $\varepsilon$, $\theta=E_2^{-1/2}$ is fixed, the rows have rank $7$ on $10$ types, and the paragraph above it in the same section already names three free coordinates. L104's count $4$ includes $\theta$ as a variable.
- **The endgame is an LP in form, but its objective is one named moment.** By section 2 of this review the exact content at three values is a two-sided bound on $K\,m_{22}-c\,pq\,G_{12}$ against explicit spectral numbers, and at $n=8$ on $m_{22}$ alone. Excluding a spectrum by the upper cut needs $\min(K\,m_{22}-c\,pq\,G_{12})>-C$ over the polytope, by the lower cut $\max<\Gamma/p-C$.
- **That is the shape of L105, so "certificate, not an argument" overstates the obstruction.** A closed-form dual certificate would need: (i) $C(\varepsilon,m,n)$ in closed form, which is class-level and derivable by hand; (ii) per class a multiplier quadratic $\alpha_a+\beta_ay+\gamma_ayz$ on the rows, plus multipliers on the pair caps and the Gram interval ends, whose accumulated type coefficients dominate those of $m_{22}$ on every admissible type, with a branch structure in $(p,q)$ as L105 has in $u/w$; (iii) at $n\ne8$, the $G_{12}$ end selected by the sign of $n-8$. **Recommended next step: bound $m_{22}$ above and below over $\Pi(\lambda)$ at three values by the multiplier method, by hand.** Whether that closes is open. The route claim stands as "a per-spectrum LP" and falls as "not an argument".

## 7. Lean

pair_iff_window in [I73cGapWeighted.lean](../lean/HamiltonsCubic/Results/I73cGapWeighted.lean) states exactly the lemma over reals, with $pI_1+qI_2=\Gamma$, $p>0$, $q>0$ as hypotheses. The identity itself (L236 in class form) enters as a hypothesis and is not derived there, which the note should say in one clause. Nothing else in section 8 is typed. The reduction of section 2 above is a candidate for the Lean layer as a statement about the kernel pairing, since it is finite linear algebra at three values.

## Suggested repairs, collected

1. Lemma side clause: "automatic above $\sqrt{3/2}$ at $n\ge11$, screened at $n=6,7,8$, open at $n=9,10$".
2. Row-span paragraph: replace by the reduction $I_1\equiv C+\frac{n+4}{12(n-2)p(p+q)}m_{22}-c\,pq\,G_{12}$ modulo rows, and the $n=8$ sign claim by the three closed-form coefficients, valid at every three-valued spectrum.
3. Control: add the direct-projection value.
4. LP screen: attribute the 17 infeasibilities to $\Pi(\lambda)=\varnothing$.
5. Route: dimension at most $4$, and the endgame is the extremes of one moment $m_{22}$ over L104's polytope, the multiplier problem L105 solved at two values.
6. Lean: say the identity is a hypothesis of pair_iff_window.
