# r1107: I73(c) section 8, the pair test as one quantity in a window

*Gate 2 review of section 8 of [2026-09-23-I73c-summed-pairs.md](2026-09-23-I73c-summed-pairs.md) at commit 41df8828, sections 1-7 taken as given. Log: [agent_logs/r1107-I73c-sec8.log](../agent_logs/r1107-I73c-sec8.log). Screens are in [scripts/reviewers/r1107/](../scripts/reviewers/r1107/), seconds each, reported as screens.*

**Verdict: the lemma, the row-span screen and the control stand. The LP sentence hides that every infeasibility is already L104's, and the route claim fails in its implicit hope: L173's witness spectrum at $n=12$, $\theta=\sqrt{21}/2$, satisfies the ENTIRE class-level system of sections 5-8 in exact rationals, so no per-spectrum LP certificate over this system can close (c) at three values.**

| # | Claim | Verdict |
|---|---|---|
| 1 | The lemma: $I_1\le0,I_2\le0\iff\Gamma/p\le I_1\le0$ | CONFIRMED, one gloss overstated (F1) |
| 2 | $I_1$'s $\tau$-part is outside the span of rows (A)-(C) | CONFIRMED |
| 3 | The $n=8$ sign claim and its scope | PLAUSIBLE, chart-dependent (F2) |
| 4 | The control at padded $W_{\mathbb{CP}^2}$ | CONFIRMED, reproduced independently |
| 5 | The LP screen | PLAUSIBLE, cause of infeasibility misattributed by omission (F3) |
| 6 | The route claim: the endgame is a per-spectrum LP | REFUTED as a route to closing (c) (F4), dimension count corrected (F5) |
| 7 | Lean: pair_iff_window states the lemma | CONFIRMED with a wording repair (F6) |

## 1. The lemma

- $pI_1+qI_2=p^2S_{12}+(p+q)^2S_{13}+q^2S_{23}=\sum_{a<b}(\varepsilon_a-\varepsilon_b)^2S_{ab}$. Since $s_{\alpha\beta}=s_{\beta\alpha}$ ($X$ depends on $\psi_\alpha\odot\psi_\beta$) and same-class pairs carry weight $0$, the ordered sum is twice this, so $pI_1+qI_2=\tfrac12\cdot\tfrac{n+4}6[\dots]=\Gamma$. The factor $\tfrac12$ is right.
- $p,q>0$ by the ordering $\varepsilon_1<\varepsilon_2<\varepsilon_3$, and then $I_2=(\Gamma-pI_1)/q\le0\iff I_1\ge\Gamma/p$. The equivalence is correct.
- Checked in the note's own encoding: $pI_1+qI_2-\Gamma$ reduced modulo rows (A)-(C) is exactly $0$ at one rational spectrum each for $n=6,7,8,9,10$, the $G_{12}$ and quintic symbols cancelling ([r1107_lemma_modrows.py](../scripts/reviewers/r1107/r1107_lemma_modrows.py)).

**F1 (gloss, inherited from section 7).** "Nonempty exactly when L236's corollary holds, which is automatic above $\sqrt{3/2}$" is proved only at $n\ge11$ (Okumura) and $n=5$ (empty). At $n=6,7,8$ it is a screen. **At $n=9,10$ neither argument reaches it**: the Okumura threshold $\frac{n-1}{n-3}\cdot\frac{N-2}{\sqrt{N(N-1)}}$ is $1.277$ and $1.243$ there, both above $\sqrt{3/2}=1.2247$, and section 7's screen covered only $6,7,8$. Repair: "automatic above $\sqrt{3/2}$ at $n\ge11$, screened at $n=6,7,8$, open at $n=9,10$". The same repair applies to section 7's sentence "the corollary says nothing about a maximiser above $\sqrt{3/2}$".

## 2. The row-span claim

- Rows in the script match [bounds.md](../findings/bounds.md) (A), (B), (C) in the $e$-normalisation: (C) $\sum\lambda_\beta\lambda_\gamma T=2\lambda_k(\theta-\lambda_k)$ becomes $\sum\varepsilon_\beta\varepsilon_\gamma T=2\varepsilon_k(1-\varepsilon_k)$, summed over a class to $2m_a\varepsilon_a(1-\varepsilon_a)$. The ordered-triple normalisation of $\tau_{abc}$ is consistent with (A)'s ordered-pair reading.
- $\tau$ is encoded as ten symbols keyed by the sorted triple, so total symmetry is built in. Admissibility holds since every sampled multiplicity is at least $3$. Rows missing a symmetry cannot be the cause.
- The Gram parametrisation satisfies $\sum_bG_{ab}=2(n-1)m_a$ and $\sum_b\varepsilon_bG_{ab}=0$ at rows 1 and 2 by hand, and row 3's weighted equation follows from tracelessness, which the script imposes exactly.
- $m_{22}$, $m_{211}$, $M_{11}=12E_3-4E_2$ and the $\Omega$ entries agree with sections 5-6. The row span in class form is complete for linear equalities: by [L104](../findings/bounds-relaxations.md) its rank is $3d-2=7$ at these multiplicities, and I found rank $7$ at five further spectra.
- Reproduced: NO at all three spectra, and the $G_{12}$ coefficient $1139/684500$ at $n=6$ equals $-c\,pq$ by hand.

## 3. The $n=8$ sign claim

- Reproduced, and extended into the regime: at five random $n=8$ spectra normalised to $\theta=1.3$, the reduced coefficients of $\tau_{123},\tau_{111},\tau_{333}$ are all positive ([r1107_n8_charts.py](../scripts/reviewers/r1107/r1107_n8_charts.py)). The scope clause "outside the regime of interest" can go, as a screen.
- **F2.** The sign depends on the chart. Taking $\tau_{112},\tau_{122},\tau_{233}$ as the free coordinates, all three coefficients are **negative** at the same five spectra, and with $\tau_{113},\tau_{223},\tau_{133}$ they are mixed. So "$I_1\le0$ is a genuine upper cut on them" says only which side of a hyperplane is kept in one chart. Whether it cuts the feasible set is the LP question, and at the one feasible spectrum of the note's screen and at the L173 spectra below it does not. Repair: "reduced modulo the rows in the chart $(\tau_{123},\tau_{111},\tau_{333})$, $I_1$ has positive coefficients at the sampled spectra".

## 4. The control

- Reproduced by the note's script, and **independently by direct projection over all eigenpairs** ([r1107_control_projection.py](../scripts/reviewers/r1107/r1107_control_projection.py)): $S_{12}=-38/3$, $S_{13}=0$, $S_{23}=-5/6$, so $I_1=-38/9$, $I_2=-5/9$ and $pI_1+qI_2=-16/9=\Gamma$, residuals about $4\times10^{-9}$ from eigenvalue rounding. Window $[-16/3,0]$ by hand from $E_2=2/3$, $E_3=2/9$.
- The control's reach: $S_{13}=0$ here (section 5's vacuous $\Lambda^2_+$ pair), so $I_1=pS_{12}$ and the $S_{13}$ term is not exercised. Multiplicities $(2,25,1)$ make $\tau_{111}$, $\tau_{333}$ and $\tau_{33x}$ inadmissible, so admissibility is not exercised either.

## 5. The LP screen

- **Every constraint is a valid necessary condition.** The class cap is the orbit-averaged pair cap $\tau_{ab}/(m_a(m_b-\delta_{ab}))\le2$, which the script's expression equals. $G_{ab}\ge\tfrac12\tau_{ab}$ is $\sum\lvert h\rvert^2\ge0$, $G_{ab}\le m_am_b$ is $\sum\lVert N_4\rVert^2\ge0$, $G_{ab}\ge0$ and Cauchy-Schwarz are Frobenius facts, $G_{aa}\ge4m_a^2/n$ is Cauchy-Schwarz on $\mathop{\mathrm{tr}}A_a=2m_a$. Cauchy-Schwarz is affine in $G_{12}$ because the $t^2$ terms of $(G^0+tzz^{\mathsf T})$ cancel. The normalisation $E_2=1/\theta^2$ is right.
- "17 of 18 infeasible before the window" is what the script prints, reproduced.
- **F3. All 17 infeasibilities occur already at rows (A)-(C) with $\tau\ge0$ alone, before caps, Gram constraints or the window** ([r1107_lp_diagnosis.py](../scripts/reviewers/r1107/r1107_lp_diagnosis.py)). They are L104's $\Pi(\lambda)$ being empty at that $\theta$, a fact the record held before sections 1-8. The sampler is not conditioned on $\Pi(\lambda)\ne\varnothing$, so section 8's content is exercised at one spectrum. Repair: "17 are infeasible at rows and $\tau\ge0$ alone (L104's $\Pi$), so the screen tests the pair content at one spectrum". It is scoped as a screen, correctly.

## 6. The route claim

**F4. The endgame's answer is already known at one three-value family, and it is "not excluded".** L173's witness ([bounds-relaxations.md](../findings/bounds-relaxations.md)) at $n=12$, $m=(4,59,3)$ in value order $(-\tfrac17,0,\tfrac4{21})$ for $e$, $\theta=\sqrt{21}/2\approx2.29$, with $\tau$ from its closed form, satisfies in exact rationals ([r1107_l173_exact.py](../scripts/reviewers/r1107/r1107_l173_exact.py)):
- all nine rows, and the caps $(2,\tfrac8{59},2,\tfrac{562}{1711},\tfrac8{59},2)$
- the Gram constraints, which pin $G_{12}=60$ (in value order, $G=\begin{pmatrix}16&60&12\\60&1193&45\\12&45&9\end{pmatrix}$, with $G_{13}=m_1m_3=\tfrac12\tau_{13}$ and Cauchy-Schwarz tight on $(1,3)$)
- the window: $I_1=-\tfrac8{147}-\tfrac{344}{45}\approx-7.70\in[-\tfrac{2848}{189},0]$
- section 5's three relaxed per-pair inequalities, with $\mathring\mu\le n\theta_0(n)/((n-1)\theta)$ and $\varepsilon_{\max}=\tfrac4{21}$

The float LP of the note's own script finds the same family ($m=(4,N-7,3)$) feasible at $n=8$ and $10$ as well, $I_1$ pinned inside the window ([r1107_l173_lp.py](../scripts/reviewers/r1107/r1107_l173_lp.py), a screen). **So the class-level system of (c) at three values, sections 5 to 8 together, admits a solution with $\theta$ far above $\sqrt{3/2}$, and no census or closed-form dual over it can close (c).** This extends L173's own conclusion from (A), (B), (C), caps and positivity to include the isotropy Gram and the pair test. "What (c) now is" calls survival "a finite question", and at this family it has a known answer, and the sweep it defers would only confirm that.

What a closed-form certificate would need, for the record:
- At spectra where the system is infeasible, a Farkas dual is row multipliers of the form $\varphi_a(\varepsilon_a)$ with $\varphi_a$ of degree at most $2$ per class (the L105 shape), plus nonnegative multipliers on the caps, the Gram constraints and the window, with the active set fixed across a chamber of $(\varepsilon,m)$ and the leftover coefficients' signs as polynomial inequalities. That is an analytic object in principle, and the note's "certificate, not an argument" undersells it.
- But any certificate that is to exclude every spectrum above $\sqrt{3/2}$ must use an ingredient the L173 witness violates. The one on file is [L31](../findings/stratum-two-negative.md)'s equality case: three tight caps force a common $4$-dimensional image, and seven orthonormal elements do not fit in $\mathfrak{so}(4)$. At the witness the Gram data already shows the shape ($G_{13}^2=G_{11}G_{33}$, so $A_1\propto A_3$). A class-level constraint on $G$ that encodes $\dim\mathfrak{so}(\mathop{\mathrm{im}}A_a)\ge$ the number of classes whose forms live there is the missing piece, and it is not linear.

**F5 (count).** "A polytope of dimension at most $5$ (four class directions and $G_{12}$)": the rows have rank $3d-2=7$ on ten class variables at multiplicities $\ge3$ (L104, and rank $7$ at every spectrum screened here), leaving **three** $\tau$ directions, as the $n=8$ paragraph itself uses. With $G_{12}$ the dimension is at most $4$. $\theta$ is not a separate coordinate, since $E_2=1/\theta^2$ fixes it from $\varepsilon$.

## 7. Lean

pair_iff_window in [I73cGapWeighted.lean](../lean/HamiltonsCubic/Results/I73cGapWeighted.lean) (line 63) takes $p,q>0$ and $pI_1+qI_2=\Gamma$ as hypotheses over $\mathbb R$ and proves the equivalence, axioms the standard three. It states the lemma's arithmetic step. **F6.** "The lemma is typed and proved" should read "its arithmetic step is typed and proved, with $pI_1+qI_2=\Gamma$ (the class form of L236) a hypothesis", since the layer defines neither $S_{ab}$ nor $\Phi,\Omega$. Nothing else in section 8 is typed, which is right: the rest is screens. I did not compile the file. The L173 exact check of F4 is rational arithmetic on stated numbers and could be typed by norm_num if the record wants it.
