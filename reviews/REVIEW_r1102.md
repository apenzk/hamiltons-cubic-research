# r1102: I73(c) section 6, the elimination of the quintic corrections

Log: [agent_logs/r1102-I73c-sec6.log](../agent_logs/r1102-I73c-sec6.log). One of two Gate 2 reviewers of section 6 of [2026-09-23-I73c-summed-pairs.md](2026-09-23-I73c-summed-pairs.md) at bc19f92b. Sections 1 to 5 are givens. Every computation below is a screen of seconds on objects constructed for it.

**Verdict: the mathematics of section 6 holds. The Lemma, the signs, the Proposition and the cone clause are correct as stated, and the elimination works for both corrections at once. Four small defects sit in the surrounding text: the Lemma's proof omits the symmetry it spends, the screen never tests the combination that actually enters $S_{ab}$ (it fails too, so the conclusion stands), one screen line is independent of $F$ while claiming to check $F$, and the Lean "not typed" reason names an absence the layer does not have.**

| # | claim | verdict |
|---|---|---|
| 1 | screen paragraph and candidate list | CONFIRMED, with F2 and F3 |
| 2 | the Lemma | CONFIRMED, proof gap F1 (true, one line) |
| 3 | signs of the lead products and the vanishing combinations | CONFIRMED |
| 4 | the Proposition | CONFIRMED |
| 5 | the cone clause and simultaneous elimination | CONFIRMED, scope remark F4 |
| 6 | Lean statements | CONFIRMED for the four statements. The "not typed" reason needs correcting (F5, F6) |

## Claim 1, the screen

- Reproduced by running [screen_I73c_quintic.py](../scripts/misc/screen_I73c_quintic.py): control $\Phi(e;e,e^2)$ returns RicRic22 $=+4$, m220 $=-4$, m211 $=-2$, residual $10^{-14}$. The quintic fits miss by $17\%,28\%$ ($n=6$) and $14\%,21\%$ ($n=7$), and by $13\%,27\%,13\%,10\%$ with $K$. The quoted ranges are right.
- **Candidate list, complete in its own class.** A homogeneous degree-5 polynomial invariant of $e$ that is linear in the eigenvector data is a trace $\sum m\varepsilon^5$, a T-moment $m_{pqr}$ with $p+q+r=5$, or a Gram moment $\langle\mathop{\mathrm{Ric}}e^i,\mathop{\mathrm{Ric}}e^j\rangle$ with $i+j=5$. $m_{500}$ is a multiple of $\mathop{\mathrm{tr}}e^5$ because $\sum_{\beta\gamma}T_{\alpha\beta\gamma}$ is the Casimir constant. $(1,4)$ vanishes by $\mathop{\mathrm{Ric}}e=0$ and $(0,5)$ is a multiple of $\mathop{\mathrm{tr}}e^5$. Products need degrees $2+3$ (degree-1 invariants vanish, and the degree-2 Gram moment is $\lvert\mathop{\mathrm{Ric}}e\rvert^2=0$), which gives exactly the six listed. The list misses nothing in this class.
- **Where "every" is too strong.** At three values a class-level formula may also be nonlinear in class data with $\varepsilon$-rational weights (for instance $\sum\tau_{abc}G_{ab}f(\varepsilon)$), which has no well-defined generic-$e$ counterpart and so cannot appear in a screen over generic $e$. The note's own caveat ("establishes nothing at three values") covers this, so the conclusion does not overreach.
- **F2, the screen never tests the quantity that enters $S_{ab}$.** It regresses $M^\Phi_{22}$ and $M^\Omega_{22}$ separately, but $S_{ab}$ sees only $Q=\frac{M^\Phi_{22}}{8(n-2)}+\frac38M^\Omega_{22}$, which could be class-level even when neither summand is. Screened here (40 random Weyl $e$, seed 7, same candidate set): $Q$ misses by $11.5\%$ at $n=6$ and $10.1\%$ at $n=7$. Adding $M^\Omega_{22}$ as a candidate for $M^\Phi_{22}$ still misses by $7$ to $10\%$. The motivation stands. The paragraph should say it also covers $Q$.
- **F3, two numerical overstatements.** (a) The percentages depend on the seed: at seed 7, $\Phi$ at $n=6$ misses by $8.5\%$, outside the quoted "14 to 28%". The qualitative statement is robust and the range is not. (b) The closing screen line reports "the $M_{22}$ coefficient of both combinations zero to $10^{-15}$, for $\Phi$ and $\Omega$". In the script `c1`, `c2` are computed from the Lagrange matrix alone, so this is one arithmetic check of the sign identities, and it does not depend on $F$.
- Side remark: the script normalises $\mathop{\mathrm{tr}}e^2=1$, so products with $\mathop{\mathrm{tr}}e^2$ collapse to degree-3 invariants. That makes the fit more permissive, and its failure is only stronger.

## Claim 2, the Lemma

- $P_a=L_a(e)=\sum_i[L_a]_ie^i$ exactly on the eigenbasis, and $[L_a]_2=\ell_a$. $\Phi$ and $\Omega$ are bilinear in $X,Y$ as tensors: the inner sum is quadratic in $u$ and in $v$, hence linear in $\psi_\alpha\otimes\psi_\alpha$ and $\psi_\beta\otimes\psi_\beta$. They are therefore basis-independent inside a repeated eigenspace. The expansion $\sum_{ij}[L_a]_i[L_b]_jM_{ij}$ follows.
- **F1, symmetry is spent without being stated.** The proof says only "bilinear". Listing five moments ($M_{00},M_{01},M_{02},M_{11},M_{12}$) for a $3\times3$ array needs $M_{ij}=M_{ji}$, which is symmetry of $F$ in $(X,Y)$. It holds: $\{U,V\}=\{V,U\}$, and $u\wedge v=v\wedge u$ for 2-forms. The fix is one clause in the proof.
- Three-value evaluations checked. $M_{00}=12\mathop{\mathrm{tr}}e=0$ and $\Omega$'s analogue both vanish. $\mathop{\mathrm{Ric}}(\psi\otimes\psi)=\Psi\Psi^{\mathsf T}$ in section 3's normalisation (the one in which $\mathop{\mathrm{Ric}}\mathrm{Id}=(n-1)g$ and $\mathop{\mathrm{tr}}A_a=2m_a$), so by linearity $\mathop{\mathrm{Ric}}(e^2)=\sum_a\varepsilon_a^2A_a$ with a plus sign, and $\lvert\mathop{\mathrm{Ric}}e^2\rvert^2=\sum\varepsilon_a^2\varepsilon_b^2G_{ab}$. $m_{22}=\sum_{abc}\varepsilon_a^2\varepsilon_b^2\tau_{abc}$ and $m_{211}=\sum\varepsilon_a\varepsilon_b\varepsilon_c^2\tau_{abc}$. $\langle e,e^\#\rangle=\lVert e\rVert^2-\mathop{\mathrm{tr}}e^3$ is spectral. $\Omega(e;e,e^2)$ adds $\mathop{\mathrm{tr}}e^4$ and $\lVert e\rVert^4$, both spectral. With $G$ fixed by $(\varepsilon,m,G_{12})$ (section 3), $\widehat F_{ab}$ is class-level in $(\varepsilon,m,\tau_{abc},G_{12})$.
- Reproduced: direct against Vandermonde $6\times10^{-14}$ (random three-valued) and $5\times10^{-8}$ (padded $W_{\mathbb{CP}^2}$, $n=8$).

## Claim 3, the signs

$\ell_1=\frac1{p(p+q)}$, $\ell_2=-\frac1{pq}$, $\ell_3=\frac1{q(p+q)}$. The three products are as stated. $p\ell_1\ell_2=-\frac1{pq(p+q)}=-(p+q)\ell_1\ell_3$ and $q\ell_2\ell_3=-\frac1{pq(p+q)}=-(p+q)\ell_1\ell_3$.

## Claim 4, the Proposition

- From [L234](../findings/second-order.md): $\langle X,e\circ X\rangle=\langle Y_0,e\circ Y_0\rangle-\frac1{2(n-2)}\sum e\,hh-\frac38\sum e\,\omega\omega$, and $\sum e\,hh=\frac14\sum e\,HH$. Summing over $\alpha\in a$, $\beta\in b$ gives $U_{ab}-\frac{\Phi(e;P_a,P_b)}{8(n-2)}-\frac38\Omega(e;P_a,P_b)$. With $-\frac12N_{ab}$ this is section 1's $S_{ab}$. It reproduces section 4's per-pair inequality term by term, so the signs are consistent.
- **Nothing else non-class-level.** $U_{ab}=\frac14m_am_b(\varepsilon_a+\varepsilon_b)-\frac14\sum_c\varepsilon_c\tau_{abc}$ and $N_{ab}$ (in $m,G_{ab},\tau_{ab}$) are class-level. The corrections are $\widehat F+\ell_a\ell_bM_{22}$. $\theta$ enters only through $\lVert e\rVert^2=\sum m\varepsilon^2$.
- $p,q>0$, so both weight vectors are nonnegative, and the inequalities follow from $S_{ab}\le0$.

## Claim 5, the cone, and both corrections at once

- The quintic part of $\sum w_{ab}S_{ab}$ is $-\big(\sum w_{ab}\ell_a\ell_b\big)Q$, with $Q$ as in F2. The Lagrange coefficients are the same for $\Phi$ and $\Omega$, and the prefactors $\frac1{8(n-2)}$ and $\frac38$ are uniform across pairs. So one scalar condition removes both entries at once, and the different prefactors do not matter.
- Dividing by $\ell_1\ell_3>0$, the condition is $w_{13}=(p+q)(w_{12}/p+w_{23}/q)$. Then $w=\frac{w_{12}}p(p,p+q,0)+\frac{w_{23}}q(0,p+q,q)$ in the order $(w_{12},w_{13},w_{23})$, with nonnegative coefficients when $w\ge0$. CONFIRMED.
- **F4, scope.** "Free of the quintic entries" is a statement about formal dependence on $Q$ treated as an indeterminate. That is the right reading, and the clause is true in it. Whether $Q$ is itself class-level at a three-valued critical $e$ is untested. F2's screen says it is not at generic $e$.

## Claim 6, Lean

- `lead3 e1 e2 e3` $=1/((e_1-e_2)(e_1-e_3))$, so $\ell_1,\ell_2,\ell_3$ are `lead3 e1 e2 e3`, `lead3 e2 e1 e3` and `lead3 e3 e1 e2`. The second and third arguments are symmetric, so their order is immaterial.
- `lead_signs` is the three signs. `elim_first` is $(e_2-e_1)\ell_1\ell_2+(e_3-e_1)\ell_1\ell_3=0$ and `elim_second` is $(e_3-e_2)\ell_2\ell_3+(e_3-e_1)\ell_1\ell_3=0$. These are the note's two identities, with the right weights on the right products.
- `elim_iff` is the hyperplane equation. It carries no sign hypothesis and does not state the decomposition into the two vectors with nonnegative coefficients. That step is one line of arithmetic, but calling `elim_iff` "the cone characterisation" overstates it slightly.
- **F5, coordinate order.** The module docstring gives the weight vectors as $(p,0,p+q)$ and $(0,q,p+q)$, which is the order $(w_{12},w_{23},w_{13})$. `elim_iff` and its docstring use $(w_{12},w_{13},w_{23})$. Read in the latter order, $(p,0,p+q)$ is wrong. Write $(p,p+q,0)$ and $(0,p+q,q)$, or name the order.
- **F6, the "not typed" reason.** $\Phi$ and $\Omega$ are indeed undefined in the layer, and so is $\pi_{\mathcal W_n}$ (L234's own Lean note). But "the layer's eigenspace projections ... none of which it defines" is inaccurate. [L39Statement.lean:133](../lean/HamiltonsCubic/Results/L39Statement.lean#L133) defines `proj`, the orthogonal projection onto the span of an orthonormal family, and [L30Statement.lean:90](../lean/HamiltonsCubic/Results/L30Statement.lean#L90) (also L35, L40) defines `Eigenframe`. An eigenspace projection is one definition away. The Ricci contraction and the $\Lambda^4$ part `altCoeff` exist in [AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean). The reason should read: $\Phi$, $\Omega$ and $\pi_{\mathcal W_n}$ are not defined.
