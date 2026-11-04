# r1112: I73(c) section 10, the seven-frame cap

*Gate 2 review of section 10 of [2026-09-23-I73c-summed-pairs.md](2026-09-23-I73c-summed-pairs.md) at commit 7588af1f, sections 1 to 9 and [L237](../findings/second-order.md) taken as given. Analysis first, screens of seconds to two minutes on constructed objects, reported as screens. Log: [r1112-I73c-sec10.log](../agent_logs/r1112-I73c-sec10.log). Scratch scripts in the session scratchpad, uncommitted.*

| # | Claim | Verdict |
|---|---|---|
| 1 | Vertex tightness, the seven-frame total 56 | CONFIRMED |
| 2 | The triangle-realisation argument, total at most 44 | CONFIRMED in its conclusion, one link REFUTED and repaired: the general rank-4 top-six bound is false at $n\ge6$, the elements of $\mathfrak m$ all have equal angles and top-six exactly $6$. The star case is SETTLED by the same argument, so $T_7<56$ at every fixed $n$ |
| 3 | The class-level constraint, the LP threshold 54.064 and the frame ascent 40.8 | Constraint CONFIRMED (an identity), LP threshold REPRODUCED with a closed-form candidate $\tfrac{7(45+21\sqrt{14})}{16}$, the ascent value REFUTED as an estimate: two explicit frames total exactly $42$ |
| 4 | The open-lemma paragraph | PLAUSIBLE, corrected: "the truth near 41" becomes "at least 42, screens put it at 42", and the equality case is now closed |
| 5 | Lean: rank4_top6 and triangle_frame_total | triangle_frame_total CONFIRMED as arithmetic. rank4_top6 REFUTED as a statement of the top-six sum: it types the note's expression, whose slot list is $n=5$'s, and its hypothesis is unused |

## 1. Vertex tightness

- **Arithmetic.** $P_{00}=\tfrac{26}{21}$, $P_{02}=\tfrac{30}{21}$, $P_{22}=\tfrac{24}{21}$. Then $3P_{00}+3P_{02}=\tfrac{168}{21}=8$ and $4P_{02}+2P_{22}=\tfrac{168}{21}=8$.
- **Partner counts.** The negative class has $m_0=4$, so a negative eigenvector has $3$ own-class and $3$ positive-class partners among the seven. The positive class has $m_2=3$, so a positive eigenvector has $4$ negative and $2$ own-class partners. $P_{ab}=\sum_c\mu_c^{(ab)}t_{abc}$ is symmetric in $(a,b)$ since $\mu_c^{(ab)}$ and $t_{abc}$ are, so $P_{20}=P_{02}$ and the rows are right.
- **The total.** $4R_0+3R_2=12P_{00}+24P_{02}+6P_{22}$, which is the ordered sum over all pairs of the seven: $4\cdot3$ ordered pairs in class $0$, $2\cdot4\cdot3$ across, $3\cdot2$ in class $2$. At the vertex it is $56=7\kappa_6$.
- **Every row extremal.** Each row is at most $\kappa_6$ by L237, and the seven rows sum to $7\kappa_6$, so each row equals $\kappa_6$. Equality in Ky Fan puts the six partners in the span of the top eigenvectors, and it IS the top eigenspace because both extremal types have a gap, $\lambda_6=\tfrac43>\lambda_7$ ($\lambda_7\le\tfrac34$, see section 2). The note's "spanning its top eigenspace" needs that gap, which holds.

## 2. The triangle-realisation argument, link by link

- **Extremal of triangle type is $J/\sqrt3$.** CONFIRMED. The triangle slot sum $(s_a+s_b)^2+(s_a+s_c)^2+(s_b+s_c)^2$ has $M=\begin{psmallmatrix}2&1&1\\1&2&1\\1&1&2\end{psmallmatrix}$ with top eigenvalue $4$ simple on $(1,1,1)$, and mass off the three indices contributes nothing, so $s=(1,1,1,0,\dots)/\sqrt3$ up to signs and order. Equal angles on three planes is $J/\sqrt3$ for a complex structure $J$ on a six-dimensional subspace, and $\lVert J\rVert^2=\tfrac12\mathop{\mathrm{tr}}I_6=3$.
- **Top eigenspace $\mathfrak m$, eigenvalue $\tfrac43$, dimension $6$.** CONFIRMED. For $A$ with $AJ=-JA$, $[J,A]=2JA$ and $\mathrm{ad}_J^2A=2(-A-JAJ)=-4A$, so $-\mathrm{ad}_X^2=\tfrac43$ on $\mathfrak m$. On $\mathfrak u(3)$ it is $0$, on $\mathbb R^6\otimes\mathbb R^{n-6}$ it is $\tfrac13$, on $\mathfrak{so}(n-6)$ it is $0$. $\dim\mathfrak m=15-9=6$.
- **The frame spans $\langle J\rangle\oplus\mathfrak m$.** CONFIRMED, by the gap $\tfrac43>\tfrac13$ and section 1.
- **Every element of $\mathfrak m$ is rank 4.** CONFIRMED and sharper than stated. Anti-$J$-linear skew maps are the real parts of $(2,0)$-forms, $\dim_{\mathbb R}\Lambda^{2,0}\mathbb C^3=6$, and every element of $\Lambda^2\mathbb C^3$ is decomposable. More: $\Lambda^{2,0}\mathbb C^3\cong(\mathbb C^3)^\ast\otimes\det$ as a $U(3)$-module, so $U(3)$ is transitive on its unit sphere, and every unit element of $\mathfrak m$ is conjugate to $\tfrac1{\sqrt2}\mathop{\mathrm{Re}}(dz_1\wedge dz_2)=\tfrac1{\sqrt2}(dx_1\wedge dx_2-dy_1\wedge dy_2)$. **Its angles are equal**, $x=y=\tfrac1{\sqrt2}$.
- **"A rank-4 unit element has top-six sum $2(x+y)^2+2(x-y)^2+2\max(x,y)^2\le6$": REFUTED as stated.** The slot list is incomplete. With angles $(x,y,0,\dots)$ and $x\ge y\ge0$, each zero-angle index $c$ gives two slots $(x\pm0)^2=x^2$, so at $n\ge6$ (at least one zero angle besides the two) the value $x^2$ has multiplicity $2(n-4)\ge4$ in $-\mathrm{ad}_X^2$, not $2$. The top six are
$$2(x+y)^2+4x^2\quad(n\ge6),$$
whose maximum at unit norm is $4+2\sin2t+2\cos2t\le4+2\sqrt2\approx6.828$ at $t=\pi/8$. Screen: $6.828427$ at $n=6,8$, against the note's formula $5.707$. The note's expression is not the top-six sum even at $n=5$: at $x=y$ it gives $5$ where the true value is $6$, since it takes $(x-y)^2$ in place of the larger $y^2$.
- **Repair.** Only the elements of $\mathfrak m$ are used, and they have $x=y=\tfrac1{\sqrt2}$, so the top six are $2\cdot2+4\cdot\tfrac12=6$ exactly, at every $n\ge6$. Suggested text: *"every unit element of $\mathfrak m$ is $U(3)$-conjugate to $\tfrac1{\sqrt2}\mathop{\mathrm{Re}}(dz_1\wedge dz_2)$, of angles $(\tfrac1{\sqrt2},\tfrac1{\sqrt2})$, whose top six eigenvalues are $2,2,\tfrac12,\tfrac12,\tfrac12,\tfrac12$, sum $6$."* **The bound $44$ stands.** (With the false general bound, $8+6(4+2\sqrt2)\approx49$ would still be below $56$, so the qualitative conclusion never depended on it.)
- **The exact triangle total is $40$.** Screen, exact to $10^{-12}$ at $n=6,7,8$: rows $8$ and six of $\tfrac{16}3$, each $\mathfrak m$-row being $\tfrac43$ from $J/\sqrt3$ plus $4$ from the other five.

### The star realisation, settled

- **Extremal of star type.** $s=(3,1,1,1,0,\dots)/\sqrt{12}$ (the star's $M$ has spectrum $4,1,1,0$, top vector $(3,1,1,1)$), $n\ge8$. Its top slots are $(s_1+s_j)^2=\tfrac43$, $j=2,3,4$. The next value is at most $\tfrac34$ ($s_1^2$ or $s_1$ against a zero angle), so the top eigenspace $V$ has dimension exactly $6$ and the gap holds.
- **$V$ consists of decomposable forms.** Let $J_0$ be the complex structure with angle $+1$ on the four planes, so $X\in\mathfrak u(4)$ and the roots $e_a+e_b$ are the weights of the anti-linear part $\Lambda^{2,0}\mathbb C^4$. Then $V=\{\mathop{\mathrm{Re}}(dz_1\wedge\beta):\beta\in\mathop{\mathrm{span}}(dz_2,dz_3,dz_4)\}$. Each is the real part of a decomposable $(2,0)$-form, hence $U(4)$-conjugate to a multiple of $\mathop{\mathrm{Re}}(dz_1\wedge dz_2)$, **rank $4$ with equal angles, top six exactly $6$**.
- **So the star frame totals at most $8+6\cdot6=44$ too.** Screen: exactly $40$ again, rows $8$ and six of $\tfrac{16}3$, and random unit elements of $V$ have angles $(0.7071,0.7071)$ and top six $6.000000$.
- **Consequence, stronger than the note records.** By [r1110](REVIEW_r1110.md)'s enumeration only the triangle and the star reach slot sum $4$, with simple top vectors, so every $\kappa_6$-extremal element is one of the two types above. A frame of total $56$ needs all seven elements extremal, but the six partners of any one of them have top six $6<8$. **So no seven-frame reaches $56$, and by compactness of the Stiefel manifold the maximum at each fixed $n$ is strictly below $56$.** The phrase *"frames with no extremal element are not settled"* is then accurate only for the quantitative cap: the equality case is closed, what is missing is a bound uniform in $n$ and at or below $54.064$.

## 3. The class-level constraint, the LP and the ascent

- **Validity.** CONFIRMED, and it is an identity, not an inequality lost to averaging. The seven non-kernel eigenvectors are orthonormal, $T_{\alpha\beta\gamma}$ summed over $\gamma$ is $\lVert[\Psi_\alpha,\Psi_\beta]\rVert^2$ (the $\gamma\in\{\alpha,\beta\}$ terms vanish by Ad-invariance), and since the frame contains every member of both classes, the ordered total is $12P_{00}+24P_{02}+6P_{22}=4R_0+3R_2$ exactly. L104's averaging preserves it by linearity.
- **LP, reproduced** ([screen_I73c_frame7_lp.py](../scripts/misc/screen_I73c_frame7_lp.py), 150 s). $T_7=56$: ceiling $1.293719$ ($=\tfrac{83\sqrt{21}}{294}$, L237). $T_7=48$: $1.00870$. $T_7\le44$: infeasible. Threshold $54.064$ at $n=8$ and $n=12$.
- **Closed-form candidate.** $54.064/7=7.7234$ matches section 9's single-cap threshold $\tfrac{45+21\sqrt{14}}{16}=7.723425$. So the candidate is $T_7^\ast=\tfrac{7(45+21\sqrt{14})}{16}=54.063977$, i.e. the binding point has $R_0=R_2$. Screen: the ceiling crosses $\sqrt{3/2}$ between $T_7^\ast-0.0005$ ($-1.8\times10^{-5}$) and $T_7^\ast+0.0005$ ($+1.7\times10^{-5}$). Not proved, and no certificate was extracted.
- **"At $T_7\le44$ the ray is empty from $\theta=1$ up."** The script tests $\theta=1$ only. Screen: infeasible at $\theta\in\{1,1.1,1.2247,1.3,1.5,2,3\}$ for $T_7=44$ and $42$. PLAUSIBLE, monotonicity in $\theta$ is not argued.
- **The ascent value $40.8$ is REFUTED as an estimate of the maximum.** Two exact frames:
  - **Clifford frame, $n=8$.** Seven anticommuting complex structures $L_{e_i}$ on $\mathbb R^8=\mathbb O$ (left multiplication by imaginary units), $X_i=L_{e_i}/2$ unit. For $i\ne j$, $[X_i,X_j]=\tfrac12L_{e_i}L_{e_j}$ with $L_{e_i}L_{e_j}$ orthogonal and skew, so $\lVert[X_i,X_j]\rVert^2=\tfrac14\cdot4=1$. **Total $42\cdot1=42$**, every row $6$, which is each element's own top-six sum (angles $(\tfrac12,\tfrac12,\tfrac12,\tfrac12)$).
  - **$G_2$ cross-product frame, $n=7$.** $X_i=C_{e_i}/\sqrt3$ with $C_u(v)=u\times v$ on $\mathop{\mathrm{Im}}\mathbb O$. Each $X_i$ is triangle-type $\kappa_6$-extremal, yet its row is $6$. Screen: total $42.000000$, every pair $1$.
  - **Screen.** Riemannian gradient ascent on the Stiefel manifold (QR retraction), fifteen random starts each: every start ends at exactly $42.000000$ at $n=7,8,9,10$ (four starts at $n=12$, all $42$, all pairs $1$), and at $40.000000$ at $n=6$. The repository's random-perturbation hill-climb stalls near $40.8$. **Exact candidate for the maximum: $42$ for $n\ge7$, $40$ at $n=6$**, as a screen.

## 4. The open-lemma paragraph

- **Honest on scope.** "The screens are screens; nothing here excludes a critical point" is right, and the lemma is correctly posed as the missing piece. The $3.5\%$ is $1-54.064/56=3.46\%$, fine.
- **Correction.** "Where the evidence puts the truth near $41$" should read *"where two explicit frames (Clifford at $n=8$, $G_2$ cross product at $n=7$) reach $42$ and gradient screens at $n\le12$ find nothing above $42$"*. The margin is then $54.064-42\approx12$, still wide.
- **Update.** With the star case settled (section 2 above), the equality analysis is complete: $T_7<56$ at each fixed $n$. The remaining gap is exactly the stability form the paragraph names, plus uniformity in $n$, which the LP needs since its threshold is $n$-independent and compactness gives nothing uniform.

## 5. Lean

- **The file compiles** (`lake env lean`, 3.9 s), axioms standard, one linter warning: `hxy` is unused.
- **triangle_frame_total** states $8+6\cdot6=44\wedge44<54$. Faithful to the note's arithmetic, trivially true. CONFIRMED.
- **rank4_top6.** The hypothesis $y^2\le x^2$ is the right WLOG reading of $\max(x,y)^2=x^2$. But it is never used, because the conclusion $6x^2+4y^2\le6x^2+6y^2$ holds unconditionally. **The slot list in the docstring is $n=5$'s** (kernel dimension $1$). At $n\ge6$ the $x^2$ value has multiplicity $2(n-4)\ge4$ (section 2), and even at $n=5$ the typed six slots are not the top six. So the theorem types a true inequality about an expression that is not the top-six sum, and the claim "a rank-4 element's top-six sum is at most $6$" is false in general. REFUTED as a statement of the note's claim.
- **Suggested replacement.** For what the argument uses: `theorem m_elem_top6 (x : ℝ) : 2 * (x + x) ^ 2 + 4 * x ^ 2 = 6 * (x ^ 2 + x ^ 2)`, with a docstring saying the elements of $\mathfrak m$ (and of the star's $V$) have equal angles, and the $n\ge6$ top six are $2(x+y)^2+4\max(x,y)^2$. Optionally the general bound $2(x+y)^2+4x^2\le(4+2\sqrt2)(x^2+y^2)$. The equal-angle fact and the spectrum remain untyped, as before.

## Consequences for the note

- Section 10's title and conclusion stand: the vertex is excluded in both extremal realisations, and the ray closes under a seven-frame cap at $54.064$ (candidate $\tfrac{7(45+21\sqrt{14})}{16}$).
- Replace the rank-4 sentence by the equal-angle statement, delete "the star realisation ... not settled" in favour of the star argument, and replace "near 41" by the two $42$-frames.
- The open lemma's best candidate value is $42$, attained by $\mathop{\mathrm{Cl}}_7$ and $G_2$ frames, which suggests a representation-theoretic proof route (every pair at $1$, every row equal to its own top-six sum).
