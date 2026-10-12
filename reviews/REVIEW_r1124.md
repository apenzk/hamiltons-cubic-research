# REVIEW r1124: L241, an exact off-ray witness to I73 (c)'s capped class-level system (Gate 2)

Log: [agent_logs/r1124.log](../agent_logs/r1124.log). Brief: [2026-09-25-L241-gate2-brief.md](2026-09-25-L241-gate2-brief.md). Claim: Lemma L241 in [bounds-relaxations.md](../findings/bounds-relaxations.md). Screens (seconds, on the witness only): r1124_eval.py (exact, independent transcription of every constraint and of $I_1$ from the note's sections 5 and 6) and r1124_lp.py (six LPs at this one spectrum), both in the session scratchpad.

**Verdict: the witness holds.** Every constraint the lemma lists is satisfied in exact arithmetic, reproduced from an independent transcription. Three corrections, none load-bearing for the Statement: the Scope's "237 ... one of many" and the "190 at $T_7\le42$" count come from a screen whose system omits section 5; the "$T_7\le44$ infeasible, $46$ feasible" sentence is a floating LP and is not labelled a screen; and `rhs5_mono` is typed over $\mathbb Q$, so the Lean chain does not reach the irrational cap. One observation: the recorded vertex sits at $G_{02}=m_0m_2$, whose equality case is provably unrealisable, but the system stays feasible for $G_{12}\in[56,98]$, so an interior point is available.

| # | Item | Verdict |
|---|---|---|
| 1 | Exactness | CONFIRMED |
| 2 | Normalisation | CONFIRMED |
| 3 | Seven-frame constraint in class form | CONFIRMED |
| 4 | Transcription | CONFIRMED, two untested on-file constraints both satisfied |
| 5 | Section 5 at $\mathring\mu=1$ | CONFIRMED in prose, the Lean chain stops short of the cap |
| 6 | Scope | PLAUSIBLE: the Statement holds, the Scope's supporting count is for a weaker system |
| 7 | Where it sits | PLAUSIBLE: the $44/46$ sentence needs a screen label or a certificate |

## 1. Exactness: CONFIRMED

- $\sum m=66=\binom{12}2$, $\sum m_ae_a=0$, $\sum m_ae_a^2=\tfrac{14}{25}$.
- All nine rows hold exactly, $\tau\ge0$.
- $P_{ab}=\tau_{ab}/(m_a(m_b-\delta_{ab}))$ agrees with the $N_{abc}$ form: $P_{00}=P_{22}=1$, $P_{02}=\tfrac87$, $P_{01}=P_{12}=\tfrac3{26}$, $P_{11}=\tfrac{239}{663}$. Every pair cap and every Ky Fan profile with $1\le\sum r\le6$, $r_b\le m_b-\delta_{ab}$ holds, the tightest at slack $\tfrac67$.
- Seven-frame compositions: the maximum is $\tfrac{318}7$ at $(4,0,3)$ and $(3,0,4)$, next $\tfrac{314}7$ at $(5,0,2)$.
- Gram: solving section 3's six equations at $G_{01}=56$ directly gives $G=\begin{pmatrix}49&56&49\\56&1032&56\\49&56&49\end{pmatrix}$. All listed constraints hold, $(0,2)$ tight in $G\le mm$ and in Cauchy–Schwarz.
- Section 5 at $\mathring\mu=1$: $(0,1)$: $-\tfrac{1099}{10}\le\tfrac{77}{15}$, $(0,2)$: $-\tfrac{203}{20}\le0$, $(1,2)$: $-\tfrac{147}2\le\tfrac{77}{15}$. Also checked symbolically at $\mathring\mu=\sqrt{3080}/55$.
- Window, from my own transcription of $S_{ab}=U_{ab}-\widehat\Phi_{ab}/(8(n-2))-\tfrac38\widehat\Omega_{ab}-\tfrac12N_{ab}$: $I_1=-\tfrac{7322}{375}$, $I_2=-\tfrac{5278}{375}$, $\Gamma=-\tfrac{168}{25}$, $\Gamma/p=-\tfrac{168}5$, and $pI_1+qI_2=\Gamma$ exactly. The $(2,2)$ symbols cancel in both combinations and survive in each single $S_{ab}$, as section 6 says.

## 2. Normalisation: CONFIRMED

- $\lVert W\rVert=1$ and $e=W/\theta$ give $\sum m_ae_a^2=\theta^{-2}$, so $\theta^2=\tfrac{25}{14}$.
- L104's row (C) in $\nu$-units is $2\nu_i(\theta-\nu_i)$. With $\nu=\theta e$ it becomes $2e_i(1-e_i)$ after dividing by $\theta^2$, which is the class row used. Rows (A), (B) are scale-free.
- $\theta$ enters the rest only through $E_2=\theta^{-2}$ (with $\langle e,e^\#\rangle=E_2-E_3$) and the $\mathring\mu$ cap. The moments $M^\Phi$, $M^\Omega$ and $\Gamma$ are all written in $e$-units, consistent with the note.
- The cap: $\Theta_{12}=\theta_0(12)=\sqrt{220}/12$ at even $n$ ([bispectral.md](../findings/bispectral.md)), and $\tfrac{12}{11}\cdot\tfrac{\sqrt{220}}{12}\cdot\tfrac{\sqrt{14}}5=\sqrt{3080}/55\approx1.00905$.

## 3. The seven-frame constraint in class form: CONFIRMED

- For a frame of $k_a$ distinct eigenvectors from class $a$, the ordered total is $\sum_{i\ne j}\sum_\gamma T_{ij\gamma}$. Averaging over all such frames of one composition sends each ordered within-class pair to $P_{aa}$ and each ordered cross pair to $P_{ab}$. That gives $\sum_ak_a(k_a-1)P_{aa}+2\sum_{a<b}k_ak_bP_{ab}$, and an average of numbers each at most $54.064$ is at most $54.064$.
- It is the whole class-level content. The class-symmetrised $T$ gives every eigenframe of a composition the same total, so eigenframes give no stronger constraint on $\tau$. For Haar-random orthonormal frames inside the eigenspaces the average pair value is again $P_{ab}$ (for $a=b$ the Weingarten average gives $S/(m(m-1))$). Frames mixing eigenspaces involve cross contractions that are not class data.
- The identity $\lVert[X_\alpha,X_\beta]\rVert^2=\sum_\gamma T_{\alpha\beta\gamma}$ in the record norm matches row (A) ($2(n-2)$, the Casimir) and the pair cap $2$.

## 4. Transcription: CONFIRMED

- The rows, $P_{ab}$, the Ky Fan loop (with $\kappa_3\to6$, $\kappa_5\to8$, the weakest valid form of $\kappa_{2k-1}\le\kappa_{2k}$), the seven-frame loop, the Gram formulas, section 5 and $\Gamma$ in [verify_I73c_offray_witness.py](../scripts/misc/verify_I73c_offray_witness.py) all match the note and L104. The Cauchy–Schwarz rows are affine in $G_{12}$, since the $G_{12}^2$ terms cancel along $zz^{\mathsf T}$ (section 7), so the script's degree split is harmless.
- **Not in the script, both satisfied**: the diagonal $G_{aa}\ge\tfrac12\tau_{aa}$ ($49\ge21$, $1032\ge478$, $49\ge21$, still true after adding the $\operatorname{tr}\Psi_\alpha^4\ge\tfrac13$ diagonal terms), and positive semidefiniteness of $G$ as a Gram matrix (eigenvalues $0$ and $565\pm3\sqrt{24929}$, all nonnegative).
- The script evaluates section 5 at $\mathring\mu=\tfrac{1009}{1000}$, while the record and Lean use $\mathring\mu=1$. Both are valid below the cap. The record's sentence "Section 5 holds already at $\mathring\mu=1$" is established by Lean, not by the script.

## 5. Section 5 at $\mathring\mu=1$: CONFIRMED in prose

- Only the first term of the right side involves $\mathring\mu$, as $\tfrac{\mathring\mu-1}{2(n-2)}(G_{ab}-\tfrac12\tau_{ab})$ with $G_{ab}-\tfrac12\tau_{ab}\ge0$ (35, 21, 35). So the right side is nondecreasing in $\mathring\mu$. The relaxation asks for some $\mathring\mu\le$ cap, which is equivalent to the inequality at the cap. $1\le\sqrt{3080}/55$ since $3080\ge3025$.
- **Lean correction**: `rhs5_mono` quantifies over `μ μ' : ℚ`, and the cap $\sqrt{3080}/55$ is irrational. The typed facts `section5`, `rhs5_mono` and `mu_cap_ge_one` therefore do not compose into the inequality at the cap. Restate `rhs5_mono` over $\mathbb R$ (casting `G`, `tauab`) or add a corollary at the real cap. The step is trivial, but the table's row "Section 5 and its $\mathring\mu$ direction" says more than the declarations deliver.

## 6. Scope: PLAUSIBLE

- **The Statement stands.** Every class-level constraint I could locate on file (rows, $\tau\ge0$, L31, L237, L240, section 3 including the two items in 4, section 5, L235 through the window, and L236's corollary, automatic here since $\operatorname{tr}e^3=0$) holds at the witness. Anything excluding every three-value spectrum above $\sqrt{3/2}$ at $n=12$ would have to exclude this one.
- **Correction to the Scope paragraph.** [screen_I73c_capped_offray.py](../scripts/misc/screen_I73c_capped_offray.py) builds on `system` in screen_I73c_kyfan_lp.py, which has rows, pair caps, Ky Fan, Gram and window, and with the patch adds $T_7$. **It omits section 5's per-pair inequalities.** So "finds 237 with a feasible direction ... so this witness is one of many" counts a weaker system than the one L241 defines. It also samples only five directions per triple, in floating point. Say "237 feasible for the system without section 5, five sampled directions (a screen)", or add section 5 to the screen.
- **Observation, not load-bearing.** The recorded vertex has $G_{02}=m_0m_2=49$. By section 2 every cross pair then has $g_{\alpha\beta}=1$, i.e. $\psi_\alpha\wedge\psi_\beta=0$ in $\Lambda^4$. That is impossible for $7$-dimensional orthogonal $E_0,E_2\subset\Lambda^2\mathbb R^{12}$. For $u$ of rank $\ge6$, $v\mapsto u\wedge v$ is injective (Lefschetz, component by component). For $u$ of rank $4$ its kernel is $5$-dimensional. So every element of both spaces is decomposable, both lie in some $x\wedge\mathbb R^{12}$ and $y\wedge\mathbb R^{12}$, and $x\parallel y$ breaks the dimension count ($14>11$), while $x\nparallel y$ forces the images mod $\langle x,y\rangle$ to be one line. **This does not touch the class-level claim**: a screen (LP at this spectrum, full system, $T_7=54.064$) finds $G_{12}$ feasible over $[56,98]$, and the system is linear, so interior points with $G_{02}<49$ exist. *Recording an interior point, or stating that the vertex's Gram equality is non-realisable, would stop a reader from reading the witness as a near-geometric object.*

## 7. Where it sits: PLAUSIBLE

- "190 of the 2080 triples ... (a screen)" is labelled correctly. It carries the same section 5 omission as item 6 and the same five-direction sampling.
- "**At this spectrum the linear system is infeasible once $T_7\le44$ and feasible at $T_7=46$**" is unlabelled and cites no script. I reproduced it as a floating HiGHS LP, full system with section 5 at the cap: infeasible at $T_7=42,44,45$, feasible at $46$ (and the same without section 5). As written it is a screen. Label it so, or give an exact dual certificate at $44$ and an exact point at $46$.
- "**It does not close the system**" is bold and unconditional, but it rests on that screen of the weaker system. Soften it to "a screen suggests it does not", or supply one exact feasible point at $T_7=42$ with section 5 included.
- The ray sentence (post F76, L240 closes L173's ray) and "off the ray" ($\operatorname{tr}e^3=0$, so $\theta=\langle W,W^\#\rangle$ at unit $W$) are correct.

## Lean statements

- `rowA`–`rowC`, `tau_nonneg`, `tau_symm` (two transpositions generate $S_3$), `P_values`, `pair_caps` and `kyfan_caps` (for every $r$ with $2\le\sum r\le6$, stronger than needed since $r_b\le m_b-\delta_{ab}$ is dropped) say what the prose needs.
- `seven_frame_caps` covers every composition with no $k_a\le m_a$ restriction, which is stronger than needed.
- `gram_rows` verifies section 3's defining equations, so it checks the formula transcription independently.
- `gram_constraints` omits the diagonal $G_{aa}\ge\tfrac12\tau_{aa}$ and PSD, both satisfied (item 4).
- The one gap is `rhs5_mono` over $\mathbb Q$ (item 5).
