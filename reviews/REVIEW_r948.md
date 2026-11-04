# Gate 2 review r948, Lemma L226 (the cubic on the block subalgebra S_J)

Brief: [BRIEF_L226.md](BRIEF_L226.md). Log: agent_logs/review-r948.log. Claim: [second-order.md](../findings/second-order.md) lines 953-975.

**Verdict: the lemma is correct as stated at every $k\ge2$ and every $n$. Every step of the written chain holds except one link of step 5, which asserts a true fact with a non sequitur. Three passages outside the proof need scoping: Gate 1 (a) omits $k=3$, Gate 1 (b) applies item 3's display off its stated domain, and the Lean paragraph says the four `sorry` statements "state items 1 to 3" when they state item 1 at $k=3$ and part of items 2 and 3.**

| Item | Verdict | Reason |
|---|---|---|
| 1 Step 1 | CONFIRMED | In an eigenbasis $W_{\gamma\epsilon}=\lambda_\gamma\delta_{\gamma\epsilon}$ collapses the index formula to $\tfrac12\sum\lambda_\alpha\lambda_\beta\lambda_\gamma c_{\alpha\beta\gamma}^2$ over ordered triples, and at $\mathrm{id}$ each $\varphi_{ij}$ has $2(n-2)$ ordered partners with $c^2=1$. |
| 2 Step 2 brackets | CONFIRMED | Each of the seven brackets checked against the quoted formula, and the formula itself checked against `phi i j = E_ji - E_ij`. The containments and $[x,y]=x\wedge y$, $[x,y]=\langle x,y\rangle\varphi_{ab}$ follow. |
| 3 Step 2 exhaustiveness | CONFIRMED | All fourteen block multisets examined, the ten unlisted ones vanish by the containments. Minor wording point on the $\Lambda^2\mathbb R^A$ eigenbasis, correction C1. |
| 4 Step 3 | CONFIRMED | Counts $3$ and $6$, the factor $2$ from ordered pairs, unit length and completeness of $v_\beta\wedge v_\gamma$, $\mathop{\mathrm{tr}}(M_aM_b)$ and the $\mathfrak{so}(k)$ term all derived. |
| 5 Step 4, item 2 | CONFIRMED | Repeated-index Bianchi sums vanish by pair symmetries in all six cases, four distinct indices not all in $J$ meet only zero entries, the Ricci entries are as written, and the equivalence holds both ways. |
| 6 Step 5, item 3 | PLAUSIBLE | Every conclusion is true. The bracket on $\Lambda^2\mathbb R^J$ being the cross product does not follow from $x\wedge y\mapsto x\times y$ as the "so" claims, correction C2. |
| 7 Gate 1 | CONFIRMED, scoped | (a) true at $k=3$ only and must say so (C3). (b) true, the display used with $S$ free (C4). (d) true against L224's step 1 coordinates. |
| 8 Lean | CONFIRMED, scoped | `blockCoeff` and the factor $\tfrac14$ are right, hypotheses sufficient and satisfiable, axioms as stated. The paragraph overclaims the scope of the four `sorry` statements and cites an unfiled screen, correction C5. |
| 9 Scope | CONFIRMED | $m=0$ gives $\mathcal W_3=0$ at $k=3$, $m=1$ at $n=4$ reproduces $P(W_{S^2\times S^2})=\tfrac43$ by hand. No counterexample. |

## Item 1, step 1

- With $v_\alpha$ orthonormal eigenvectors, $W_{\gamma\epsilon}=\lambda_\gamma\delta_{\gamma\epsilon}$, so $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\gamma,\delta}c_{\alpha\gamma\delta}^2\lambda_\gamma\lambda_\delta$ and $\langle W,W^\#\rangle=\sum_\alpha\lambda_\alpha(W^\#)_{\alpha\alpha}$ is the displayed sum over ordered triples.
- The pairing is $\mathop{\mathrm{tr}}$ in an orthonormal basis of $\Lambda^2$, which is the base layer's `innerOp` ($\tfrac12$ against the ordered-pair double count, `inner2 (phi i j) (phi i j) = 1`).
- At $\mathrm{id}$, $[\varphi_{12},\varphi_{1c}]=\varphi_{2c}$ and $[\varphi_{12},\varphi_{2c}]=-\varphi_{1c}$ for $c\ne1,2$, so $\sum_{\gamma,\delta}c_{\alpha\gamma\delta}^2=2(n-2)$, giving $(\mathrm{id}^\#)_{\alpha\alpha}=n-2$ and $\langle\mathrm{id},\mathrm{id}^\#\rangle=(n-2)\dim\Lambda^2$, as written.
- The index formula is $O(\Lambda^2)$-invariant, so it may be read in the eigenbasis.

## Item 2, step 2

- From $\varphi_{ab}=E_{ba}-E_{ab}$, $\varphi_{ab}\varphi_{cd}-\varphi_{cd}\varphi_{ab}=\delta_{ac}\varphi_{bd}+\delta_{bd}\varphi_{ac}-\delta_{ad}\varphi_{bc}-\delta_{bc}\varphi_{ad}$, derived by expanding the four products. A screen of a few seconds over all index quadruples at $n=5$ gave residual $0$ (screen only).
- $[\varphi_{pa},\varphi_{qa}]$: only $\delta_{aa}$ survives, $\varphi_{pq}$. $[\varphi_{pa},\varphi_{pb}]$: only $\delta_{pp}$, $\varphi_{ab}$. $[\varphi_{pa},\varphi_{qb}]$ and $[\varphi_{pa},\varphi_{bc}]$: no delta, $0$. $[\varphi_{pa},\varphi_{ab}]$: only $-\delta_{aa}\varphi_{pb}$. $[\varphi_{ab},\varphi_{ac}]$: $\varphi_{bc}$. Disjoint index sets commute. All as written.
- The containment $[\Lambda^2\mathbb R^J,V_a]\subseteq V_a$ uses $[\varphi_{pq},\varphi_{pa}]=\varphi_{qa}$ and $[\varphi_{pq},\varphi_{ra}]=0$ for $r\notin\{p,q\}$, which the list does not display but the formula gives at once. $[V_a,\varphi_{ab}]\subseteq V_b$ also needs $[\varphi_{pb},\varphi_{ab}]=\varphi_{pa}$, again immediate.
- $[x,y]=\sum_{p,q}x_py_q[\varphi_{pa},\varphi_{qa}]=\sum_{p\ne q}x_py_q\varphi_{pq}=x\wedge y$ since $\varphi_{pp}=0$. $[x,y]=\sum_px_py_p\varphi_{ab}$ for $x\in V_a$, $y\in V_b$.

## Item 3, exhaustiveness

Write $L_J=\Lambda^2\mathbb R^J$ and $L_{ab}=\mathbb R\varphi_{ab}$. A block multiset carries a nonzero $c$ only if the bracket of two of its blocks has a component in the third.

| Multiset | Bracket used | Result |
|---|---|---|
| $L_JL_JL_J$ | subalgebra | listed |
| $L_JL_JV_a$, $L_JL_JL_{ab}$ | $[L_J,L_J]\subseteq L_J$ | $0$ |
| $L_JV_aV_a$ | $[V_a,V_a]\subseteq L_J$ | listed |
| $L_JV_aV_b$, $L_JV_aL_{bc}$ | $[L_J,V_a]\subseteq V_a$ | $0$ |
| $L_JL_{ab}L_{cd}$ | $[L_J,L_{ab}]=0$ | $0$ |
| $V_aV_aV_a$, $V_aV_aV_b$, $V_aV_aL_{bc}$ | $[V_a,V_a]\subseteq L_J$ | $0$ |
| $V_aV_bV_c$ | $[V_a,V_b]\subseteq L_{ab}$ | $0$ |
| $V_aV_bL_{cd}$ | $[V_a,V_b]\subseteq L_{ab}$ | nonzero only at $\{c,d\}=\{a,b\}$, listed |
| $V_aL_{bc}L_{de}$ | $[L_{bc},L_{de}]\subseteq\Lambda^2\mathbb R^A$ | $0$ |
| $L_{ab}L_{cd}L_{ef}$ | $[\varphi_{ab},\varphi_{cd}]\ne0$ only when the pairs share one index | triangles, listed |

The list is complete. **One wording point (C1).** The triangle count $c^2=1$ and the $V_aV_bL_{ab}$ count both need the eigenvectors on $\Lambda^2\mathbb R^A$ to be the $\varphi_{ab}$ themselves. "Chosen block by block" allows a rotated eigenbasis inside a degenerate eigenspace of $\mathop{\mathrm{diag}}(K)$, for which neither count holds as written. Step 2's phrase "the three blocks $V_a,V_b,\mathbb R\varphi_{ab}$" shows the intended refinement, so this is a clarification, not a gap in the mathematics.

## Item 4, step 3

- **$L_JL_JL_J$.** The $\varphi_{pq}$, $p<q\in J$, are an orthonormal basis of $L_J$ with the bracket of $\mathfrak{so}(k)$, so the sub-sum is the index formula on $\mathfrak{so}(k)$ applied to $R_J$. At $k=2$ it is $0$.
- **$L_JV_aV_a$.** $c^2$ is totally symmetric, so each of the $3$ positions of the $L_J$ vector gives the same sum $\sum_\omega\mu\sum_{\beta,\gamma}\lambda_\beta\lambda_\gamma\langle v_\beta\wedge v_\gamma,\omega\rangle^2$. From $x\wedge y=yx^{\mathsf T}-xy^{\mathsf T}$ and `inner2`, $\langle x\wedge y,x'\wedge y'\rangle=\langle x,x'\rangle\langle y,y'\rangle-\langle x,y'\rangle\langle y,x'\rangle$, so the $v_\beta\wedge v_\gamma$, $\beta<\gamma$, are orthonormal, $\binom k2$ of them, a basis. $\Lambda^2M_a$ is well defined, symmetric, with these eigenvectors and eigenvalues $\lambda_\beta\lambda_\gamma$. The ordered sum is twice the $\beta<\gamma$ sum (antisymmetry, diagonal zero), which is $2\langle\Lambda^2M_a\omega,\omega\rangle$. Total $\tfrac12\cdot3\cdot2\mathop{\mathrm{tr}}(R_J\Lambda^2M_a)$.
- **$V_aV_bL_{ab}$.** Three distinct blocks, $3!=6$ orders per unordered pair $\{a,b\}$, so the sum runs over $a<b$. $c=\langle v_\beta,v_\gamma\rangle$ and $\sum_{\beta,\gamma}\lambda_\beta\lambda_\gamma\langle v_\beta,v_\gamma\rangle^2=\mathop{\mathrm{tr}}(M_aM_b)$. The sign of $\varphi_{ab}$ against $\varphi_{ba}$ enters squared.
- **Triangles.** $6$ orders, $c^2=1$ from $[\varphi_{ab},\varphi_{ac}]=\varphi_{bc}$, total $3K_{ab}K_{ac}K_{bc}$.
- $V_a$ is identified isometrically with $\mathbb R^J$ because the $\varphi_{pa}$ are orthonormal, which the $\mathop{\mathrm{tr}}(M_aM_b)$ and $\lvert M_a\rvert^2$ readings use. The Setting leaves it implicit.
- **Screen (not evidence).** A screen of a few seconds built a random block operator with a general symmetric $R_J$ on $\Lambda^2\mathbb R^4$ at $(k,n)=(4,6),(4,7)$ and $(2,5)$, and item 1 agreed with the trusted `Q_op` of [curvature_operator.py](../scripts/lib/curvature_operator.py) to $10^{-14}$. It covers $k\ne3$, which Gate 1 (c) does not.

## Item 5, step 4 and item 2

- The surviving entries have index multisets in $J$, $\{p,q,a,a\}$ (including $p=q$), or $\{a,b,a,b\}$. Pair antisymmetry does not change the multiset.
- **Repeated index.** With $b(i,j,k,l)=W_{ij,kl}+W_{ik,lj}+W_{il,jk}$ and symmetry plus pair antisymmetry, each of $i=j$, $i=k$, $i=l$, $j=k$, $j=l$, $k=l$ gives $0$. Checked case by case.
- **Four distinct indices not all in $J$.** Every term has multiset $\{i,j,k,l\}$ with no repeat and not inside $J$, which is none of the three shapes, so every term is $0$. Four distinct indices in $J$ read only $R_J$'s entries. So Bianchi for $W$ is Bianchi for $R_J$, both ways.
- **Ricci.** With the base layer's $\mathop{\mathrm{Ric}}_{xy}=\sum_c\langle W\varphi_{xc},\varphi_{yc}\rangle$: $\mathop{\mathrm{Ric}}_{pq}$ splits at $c\in J$ and $c\in A$ as written. $\mathop{\mathrm{Ric}}_{aa}=\sum_p(M_a)_{pp}+\sum_{b\ne a}K_{ab}$. $\mathop{\mathrm{Ric}}_{pa}$ pairs $L_J$ with $V_a$ ($c\in J$) or $V_b$ with $L_{ab}$ ($c=b\in A$), and $\mathop{\mathrm{Ric}}_{ab}$ pairs $V_a$ with $V_b$ or $L_{ac}$ with $L_{bc}$, all zero.
- Symmetry and $\Lambda^2$-preservation hold for every block operator, so $W\in\mathcal W_n$ is equivalent to the three stated conditions. "Exactly when" holds.
- The block note's character reading was rechecked with $\Gamma$ the full diagonal sign group of [second-order.md](../findings/second-order.md) line 626. With $\Gamma\cap SO(n)$ in its place, at $m=1$ and $k$ odd, $\varepsilon_a=\varepsilon_J$ would make $R_{pq,ra}$ survive, so the full group is load-bearing, and it is the group the record fixes.

## Item 6, step 5 and item 3

- $x\wedge y$ has $\varphi_{23}$-coefficient $x_2y_3-x_3y_2$, $\varphi_{31}$-coefficient $x_3y_1-x_1y_3$ (using $\varphi_{13}=-\varphi_{31}$), $\varphi_{12}$-coefficient $x_1y_2-x_2y_1$. So $x\wedge y\mapsto x\times y$ holds.
- **Gap (C2).** "So the bracket of $\Lambda^2\mathbb R^J$ becomes the cross product" does not follow: the first fact concerns the wedge map $\mathbb R^J\times\mathbb R^J\to\Lambda^2\mathbb R^J$, the second the Lie bracket on $\Lambda^2\mathbb R^J$ itself. The conclusion is true: $\varphi_{23}=E_{32}-E_{23}=\hat e_1$, $\varphi_{31}=\hat e_2$, $\varphi_{12}=\hat e_3$ under the hat map, and $[\hat u,\hat v]=\widehat{u\times v}$. Directly from the bracket formula, $[\varphi_{23},\varphi_{31}]=-\varphi_{21}=\varphi_{12}$ and $[\varphi_{31},\varphi_{12}]=-\varphi_{32}=\varphi_{23}$.
- $c=\langle\omega_1\times\omega_2,\omega_3\rangle=\pm\det(\omega_1,\omega_2,\omega_3)=\pm1$ for an orthonormal triple, so $\langle R_J,R_J^\#\rangle=\tfrac12\cdot6\,\mu_1\mu_2\mu_3=3\det S$. At $S=I$ this is $3=\langle\mathrm{id},\mathrm{id}^\#\rangle$ on $\mathfrak{so}(3)$, $(n-2)\dim=1\cdot3$.
- $Mx\times My=\mathop{\mathrm{cof}}(M)(x\times y)$ with $\mathop{\mathrm{cof}}M=\mathop{\mathrm{adj}}(M)^{\mathsf T}$, equal to $\mathop{\mathrm{adj}}M$ for symmetric $M$. The frame is an isometry, so $\mathop{\mathrm{tr}}(R_J\Lambda^2M)=\mathop{\mathrm{tr}}(S\mathop{\mathrm{adj}}M)$.
- $\rho_{11}=S_{33}+S_{22}$ and $\rho_{12}=\langle R_J\varphi_{13},\varphi_{23}\rangle=\langle R_J(-e_2),e_1\rangle=-S_{12}$ as written. The remaining entries follow by the cyclic symmetry $1\to2\to3$ that permutes the frame, and I checked $\rho_{13}=-S_{13}$, $\rho_{23}=-S_{23}$, $\rho_{22}=S_{11}+S_{33}$ directly. The proof leaves the cyclic step unsaid, which is acceptable.
- Bianchi on $\mathbb R^3$ has no four distinct indices, and repeated indices vanish by item 5's case check.
- Trace of $(\mathop{\mathrm{tr}}S)I-S=-N$ gives $2\mathop{\mathrm{tr}}S=-\mathop{\mathrm{tr}}N$, so $S=(\mathop{\mathrm{tr}}S)I+N=N-\tfrac12(\mathop{\mathrm{tr}}N)I$. The display is item 1 with these substitutions.

## Item 7, Gate 1

- **(a)** At $k=3$: $P(R_J)=3+3=6$, per $a$: $3+3\cdot3=12$, per pair: $1+3\cdot3=10$ giving $5m(m-1)$, triangles $3\binom m3=\tfrac12m(m-1)(m-2)$. Both sides expand to $\tfrac12m^3+\tfrac72m^2+8m+6$, an identity in $m$, so $18,40,75$ are three instances of it. It also pins all four coefficients $3$ through the $m$-dependence. **The passage never says $k=3$**: at general $k$, item 1 at $\mathrm{id}$ reads $(k-1)\binom k2+m\big(k+3\binom k2\big)+\binom m2(1+3k)+3\binom m3$. Correction C3.
- **(b)** At a coordinate-diagonal $W$, $S=\mathop{\mathrm{diag}}(K_{23},K_{13},K_{12})$ and $M_a=\mathop{\mathrm{diag}}(K_{1a},K_{2a},K_{3a})$. Then $3\det S$ is the $JJJ$ triangle, $3\mathop{\mathrm{tr}}(S\mathop{\mathrm{adj}}M_a)=3(K_{23}K_{2a}K_{3a}+K_{13}K_{1a}K_{3a}+K_{12}K_{1a}K_{2a})$ the $JJA$ triangles, $3K_{ab}\mathop{\mathrm{tr}}(M_aM_b)=3K_{ab}\sum_pK_{pa}K_{pb}$ the $JAA$ triangles, and $\tfrac12\langle K^{\circ2},K\rangle=\sum_{i<j}K_{ij}^3$, $\tfrac12\langle K^2,K\rangle=3\sum_{i<j<l}$. True. A coordinate-diagonal $W$ need not be Weyl, and item 3's display is stated on $\mathcal S_J\cap\mathcal W_n$ with $S$ fixed by $N$, so what (b) checks is item 1 at $k=3$ rewritten by item 3's first two identities, $S$ free. Correction C4.
- **(d)** At $k=2$, $\rho(R_J)_{jj}=\rho(R_J)_{kk}=K_{jk}$ and $\rho(R_J)_{jk}=0$ ($\varphi_{jj}=\varphi_{kk}=0$), so item 2 reads $\sum_aM_a=-K_{jk}I$. With the block note's $M_a=\begin{pmatrix}K_{ja}&x_a\\x_a&K_{ka}\end{pmatrix}$, the traceless part of $\sum_aM_a$ is $\begin{pmatrix}\sum y&\sum x\\\sum x&-\sum y\end{pmatrix}$ with $y_a=\tfrac12(K_{ja}-K_{ka})$. L224's step 1 has $D=E+D^-_y$ with $E$ swap-even and $D^-_y$ carrying $K_{ja}=y_a$, $K_{ka}=-y_a$, so $K_{ja}-K_{ka}=2y_a$ and L224's $y$ is exactly this $y$. $\nu_x=\sum x_ae_{ja}\odot e_{ka}$ puts $x_a$ at $W_{ja,ka}$. L224 takes $y,x\in\{\sum z=0\}$. So the traceless part vanishing is L224's $\sum y=\sum x=0$, true as written.

## Item 8, Lean

- **Build.** `lake build HamiltonsCubic.Results.L226Statement` completed, with `sorry` warnings at lines 68, 75, 83, 90 only. `#print axioms`: `ricciJ_inverse`, `cubicJ_diagonal`, `coupling_diagonal`, `blockP_identity` depend on `[propext, Classical.choice, Quot.sound]`, and `Pcubic_blockOp`, `normSq_blockOp`, `Ric_blockOp_J`, `Ric_blockOp_outer` add `sorryAx`. As stated.
- **`eps`** is $\det$ of the rows $e_p,e_q,e_x$, the Levi-Civita symbol. $\varphi_{pq}=\sum_x\varepsilon_{pqx}e_x$ in the frame (0-indexed $\varphi_{12}\mapsto e_0$, $\varphi_{20}\mapsto e_1$, $\varphi_{01}\mapsto e_2$, the lemma's frame shifted), so the $JJJ$ entries $\sum\varepsilon_{pqx}\varepsilon_{rsy}S_{xy}$ are right, and `eps p p x = 0`.
- **Mixed entries.** $\langle W\varphi_{pa},\varphi_{qb}\rangle=\delta_{ab}(M_a)_{pq}$, and each swap of $p$ with $a$ in either slot flips the sign. The four cases carry exactly these signs. Outer entries: $K_{ab}$ at $(a,b,a,b)$, $-K_{ab}$ at $(a,b,b,a)$, $a\ne b$. Every other pattern is $0$.
- **The factor $\tfrac14$.** `blockCoeff` is antisymmetric in each pair (the first pair needs `hK` for the outer case). With `inner2 (phi i j) (phi i' j') = δ_ii'δ_jj' - δ_ij'δ_ji'`, `blockOp (phi i j) = ½ Σ_kl W_ij,kl phi k l = Σ_{k<l} W_ij,kl phi k l`, so `inner2 (blockOp (phi i j)) (phi k l) = W_ij,kl`. The $\tfrac14$ is `skew_expand`'s $\tfrac12$ times the $\tfrac12$ of the ordered-pair expansion of $W\varphi_{ij}$. Correct.
- **Hypotheses.** `Pcubic_blockOp` and `normSq_blockOp` need `hS`, `hM` (symmetry) and `hK` (pair antisymmetry of the outer entries). `hK0` is not needed there, since neither `blockCoeff` nor `blockP` reads `K a a`, and it is harmless. `Ric_blockOp_outer` needs `hK0`, because its right side sums over all `b` while the operator yields $\sum_{b\ne a}$. `Ric_blockOp_J` needs no hypothesis on `K`. All hypotheses are satisfiable ($S=0$, $M=0$, $K=0$), so no statement is vacuous.
- **Scope of the statements (C5).** The four `sorry` theorems state item 1 at $k=3$ in item 3's coordinates, the Setting's norm identity at $k=3$, and the Ricci entries on $J$ and on the outer diagonal. They do not state item 1 at general $k$ (the [lean/INDEX.md](../lean/INDEX.md) row records that as owed), the vanishing of $\mathop{\mathrm{Ric}}_{pa}$ and $\mathop{\mathrm{Ric}}_{ab}$, the Bianchi part of items 2 and 3, the equivalence "exactly when" of item 2, or that `blockOp` exhausts $\mathcal S_J$. The findings paragraph's "state items 1 to 3" overclaims.
- **Proved lemmas.** `ricciJ_inverse` is step 5's inversion in both directions. `cubicJ_diagonal` and `coupling_diagonal` are the $JJJ$ and $JJA$ triangle readings of Gate 1 (b) (the $JAA$ term $\mathop{\mathrm{tr}}(M_aM_b)$ at diagonal blocks is not typed, which "for the $J$ terms" covers). `blockP_identity` is Gate 1 (a) at $m=3$. As the paragraph says.
- **Traceability.** The paragraph says "a screen matched [`blockCoeff`'s entries] to the operator of (c) at $n=6,7$ with zero difference". No script in `scripts/`, `reviews/` or `findings/` mentions `blockCoeff` apart from the brief and the lemma. I verified the entries by hand above, so the content stands, and the sentence cites a screen that is not on file.

## Item 9, scope and counterexamples

- **$k\ge2$, every $n$.** No step uses $n$ beyond the index sets. At $k=2$, $L_J$ is a line, the $JJJ$ term is $\mathop{\mathrm{tr}}R_J^3=K_{jk}^3$ and $\Lambda^2M_a=\det M_a$, and the screen above at $(2,5)$ agreed (screen only).
- **$m=0$.** $\mathcal S_{[n]}$ is every curvature operator, item 1 is $P(W)=P(R_J)$, item 2 is Bianchi and $\rho(R_J)=0$. At $k=3$, $N=0$ forces $S=0$, which is $\mathcal W_3=0$. Correct.
- **$m=1$, $n=4$.** Item 2 gives $\mathop{\mathrm{tr}}M=0$ and $S=M$. Item 3 gives $P=2\mathop{\mathrm{tr}}M^3+3\det M+3\mathop{\mathrm{tr}}(M\mathop{\mathrm{adj}}M)=2\mathop{\mathrm{tr}}M^3+12\det M=18\det M$ (using $\mathop{\mathrm{tr}}M^3=3\det M$ for traceless $M$), with $\lVert W\rVert^2=2\lvert M\rvert^2$. For $S^2\times S^2$ (factors $\{1,2\}$, $\{3,4\}$, invariant under $e_4\mapsto-e_4$, so in $\mathcal S_{\{1,2,3\}}$): $K_{12}=K_{34}=\tfrac23$, the other four $-\tfrac13$. $M=\mathop{\mathrm{diag}}(-\tfrac13,-\tfrac13,\tfrac23)$ gives $P=18\cdot\tfrac2{27}=\tfrac43$ and $\lVert W\rVert^2=\tfrac43$. The diagonal form gives $\sum K^3=\tfrac49$ plus $3\cdot4\cdot\tfrac2{27}=\tfrac89$, total $\tfrac43$, and $\sum K^2=\tfrac43$. Agreement by hand, and $S=\mathop{\mathrm{diag}}(K_{23},K_{13},K_{12})=M$ as item 3 predicts.
- **Counterexamples.** None. Items 1 and 3 hold on every $W\in\mathcal S_J$ (resp. $\mathcal S_J\cap\mathcal W_n$) by the derivation above.

## Corrections proposed

- **C1 (step 1, last sentence).** Replace "$W\in\mathcal S_J$ is block-diagonal, so the eigenbasis is chosen block by block." with "$W\in\mathcal S_J$ is block-diagonal, so the eigenbasis is chosen block by block, taking $\varphi_{ab}$ itself as the eigenvector on each line $\mathbb R\varphi_{ab}$ of $\Lambda^2\mathbb R^A$."
- **C2 (step 5, first sentence).** Replace "The frame $\varphi_{23},\varphi_{31},\varphi_{12}\mapsto e_1,e_2,e_3$ carries $x\wedge y$ to $x\times y$, so the bracket of $\Lambda^2\mathbb R^J$ becomes the cross product, every distinct orthonormal triple has $c^2=1$," with "The frame $\varphi_{23},\varphi_{31},\varphi_{12}\mapsto e_1,e_2,e_3$ carries $x\wedge y$ to $x\times y$, and it carries the bracket of $\Lambda^2\mathbb R^J$ to the cross product, since the bracket formula gives $[\varphi_{23},\varphi_{31}]=\varphi_{12}$ and its cyclic images. So every distinct orthonormal triple has $c^2=1$,"
- **C3 (Gate 1 (a)).** Replace "At $W=\mathrm{id}$, not Weyl, item 1 reads" with "At $W=\mathrm{id}$ and $k=3$, not Weyl, item 1 reads", and after "checked at $m=1,2,3$ as $18,40,75$" add "and identical as polynomials in $m$".
- **C4 (Gate 1 (b)).** Replace "At a coordinate-diagonal $W$, item 3 becomes" with "At a coordinate-diagonal $W$, item 1 at $k=3$ written with item 3's first two identities, $S$ free, becomes".
- **C5 (Lean paragraph).** Replace "`Pcubic_blockOp`, `normSq_blockOp`, `Ric_blockOp_J` and `Ric_blockOp_outer` state items 1 to 3 against the base layer and carry named `sorry`s, the bracket computation of steps 2 to 5." with "`Pcubic_blockOp` states item 1 at $k=3$ in item 3's coordinates, `normSq_blockOp` the Setting's norm at $k=3$, and `Ric_blockOp_J` and `Ric_blockOp_outer` the Ricci entries on $J$ and on the outer diagonal, against the base layer, each with a named `sorry`, the bracket computation of steps 2 to 5. Item 1 at general $k$, the mixed Ricci entries, the Bianchi part and the equivalence of item 2 are untyped." Also either file the screen that matched `blockCoeff` to the operator of (c) and link it, or replace "whose entries a screen matched to the operator of (c) at $n=6,7$ with zero difference" with "whose entries are $\langle W\varphi_{ij},\varphi_{kl}\rangle$ of item 3's operator".
- The same "state items 1 to 3" wording sits in the [lean/INDEX.md](../lean/INDEX.md) L226 row and in the Lean file's module docstring ("items 1 to 3 against the base layer's `Pcubic`, `normSq` and `Ric`"), and C5's scoping applies there too.
