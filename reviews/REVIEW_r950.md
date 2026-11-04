# Review r950, Lemma L227 (the |J| = 3 step of R27 at n = 5)

Brief: [BRIEF_L227.md](BRIEF_L227.md), with the coordinator's correction that the L57 passage is L57's own block (domain bijection, attainment formula, diagonal theorem) and not L223's statement, which the first version of the brief quoted. Log: [agent_logs/review-r950.log](../agent_logs/review-r950.log).

**Verdict: the proof is correct.** Every step of the chain follows from the line above it and from L226 and L57 as stated. The findings are four wording and scope repairs (Gate 1 (a), Gate 1 (c), the **Lean** paragraph, **What it gives**), none of which touches the bound or the attainment.

| Item | Verdict | Reason |
|---|---|---|
| 1 Step 1 | CONFIRMED | Ricci forces one $m$ and $K_{ab}=-3m$, both Cayley–Hamilton expansions hold, and the constants $-72m^3$ and $18m^2$ come out term by term |
| 2 Step 2 | CONFIRMED | The three trace identities need only cyclicity and hold for all $3\times3$ matrices. All five coefficients agree, and $V$ enters $P$ and the norm only through $\mathop{\mathrm{tr}}(UV^2)$ and $\lvert V\rvert^2$ |
| 3 Step 3 | CONFIRMED | Rayleigh gives $d_1\le w_1$ and $d_3\ge w_3$, the Abel summation is exact with nonnegative weights, and $V'$ is traceless, symmetric, commuting and isospectral to $V$ |
| 4 Step 4 | CONFIRMED | $W'$ is a block operator with the Ricci-determined $S'=S$, so it lies in $\mathcal S_J\cap\mathcal W_5$. $\Lambda^2g=(\det g)\,g$ in the frame $\varphi_{23},\varphi_{31},\varphi_{12}$, so $\det Q=-1$ is harmless too. The rotated tensor is coordinate-diagonal, unit and Weyl, so L57 applies at $n=5\ge4$ |
| 5 Attainment | CONFIRMED | $H_J\subseteq\Gamma$ gives $\mathcal D_5\subseteq\mathcal S_J$, and $\theta(S^2\times S^3)^2=\tfrac{2\cdot4\cdot1\cdot2}{3\cdot6}=\tfrac89$ |
| 6 Gate 1 | PLAUSIBLE, two corrections | (b) and (d) are true. (a) screens the norm formula against a second formula, not against the trusted $Q$. (c) reproduces $0.942809$ but with commutator $2\cdot10^{-8}$, not $5\cdot10^{-10}$ |
| 7 Lean | CONFIRMED, one wording correction | The statements match steps 1 to 3 and the axioms are as stated. `alignment_step` is a weakening of step 3's $V'$, still true, not vacuous and sufficient for its consumer. The **Lean** paragraph's "it needs the spectral theorem" reads as referring to `commuting_improvement` |
| 8 What it gives | PLAUSIBLE, one correction | The model-case and vacuity claims are true. The three-outer-index sentence reuses $m$ with a second meaning and states batch 6's heuristic as a fact |
| 9 Counterexample hunt | CONFIRMED (none exists) | The chain reduces every unit $W$ to a unit diagonal Weyl tensor of no smaller value, and $V'$ exists for every $(U,V)$ by the spectral theorem |

## Item 1, step 1

- **Ricci.** L226 item 2 at $A=\{a,b\}$ reads $\mathop{\mathrm{tr}}M_a+K_{ab}=0=\mathop{\mathrm{tr}}M_b+K_{ab}$, so the traces agree, $M_a=mI+X_1$, $M_b=mI+X_2$ and $K_{ab}=-3m$. $N=2mI+U$ with $U=X_1+X_2$, $\mathop{\mathrm{tr}}N=6m$, so $S=N-3mI=U-mI$.
- **Adjugate.** For $A=mI+X$: $\mathop{\mathrm{adj}}A=A^2-(\mathop{\mathrm{tr}}A)A+e_2(A)I$ with $e_2(A)=\tfrac12\big((\mathop{\mathrm{tr}}A)^2-\mathop{\mathrm{tr}}A^2\big)=3m^2-\tfrac12\mathop{\mathrm{tr}}X^2$. Expanding gives $X^2-mX+(m^2-\tfrac12\mathop{\mathrm{tr}}X^2)I$, as written.
- **Determinant.** $\det(X+tI)=t^3+e_2(X)t+\det X$ with $e_2(X)=-\tfrac12\mathop{\mathrm{tr}}X^2$ and $\det X=\tfrac13\mathop{\mathrm{tr}}X^3$ for traceless $X$. At $t=-m$ this is the displayed formula.
- **The value, by degree in $m$.** $\mathop{\mathrm{tr}}S^3+3\det S=2\mathop{\mathrm{tr}}U^3-\tfrac32m\mathop{\mathrm{tr}}U^2-6m^3$. Each $\mathop{\mathrm{tr}}M_a^3=3m^3+3m\mathop{\mathrm{tr}}X_a^2+\mathop{\mathrm{tr}}X_a^3$. Each $3\mathop{\mathrm{tr}}(S\mathop{\mathrm{adj}}M_a)=3\mathop{\mathrm{tr}}(UX_a^2)-3m\mathop{\mathrm{tr}}(UX_a)+\tfrac32m\mathop{\mathrm{tr}}X_a^2-9m^3$, using $\mathop{\mathrm{tr}}U=0$. $K^3=-27m^3$ and $3K\mathop{\mathrm{tr}}(M_aM_b)=-27m^3-9m\mathop{\mathrm{tr}}(X_1X_2)$.
  - $m^3$: $-6+2\cdot3+2\cdot(-9)-27-27=-72$.
  - Cubic in $X$: $2(A+3B)+A+3(A+B)=6A+9B$ with $A=\sum_a\mathop{\mathrm{tr}}X_a^3$ and $B=\mathop{\mathrm{tr}}X_1^2X_2+\mathop{\mathrm{tr}}X_1X_2^2$.
  - Linear in $m$, with $t_a=\mathop{\mathrm{tr}}X_a^2$ and $c=\mathop{\mathrm{tr}}X_1X_2$: $(t_1+t_2)(-\tfrac32+\tfrac92-3)=0$ and $c(-3-6-9)=-18$.
  - No $m^2$ term survives, since every candidate carries $\mathop{\mathrm{tr}}U$ or $\mathop{\mathrm{tr}}X_a$.
- **The norm.** $\lvert S\rvert^2=\mathop{\mathrm{tr}}U^2+3m^2$, $\lvert M_a\rvert^2=3m^2+t_a$, $K^2=9m^2$, total $2(t_1+t_2)+2c+18m^2$.

## Item 2, step 2

- $\mathop{\mathrm{tr}}(U\pm V)^3=\mathop{\mathrm{tr}}U^3\pm3\mathop{\mathrm{tr}}U^2V+3\mathop{\mathrm{tr}}UV^2\pm\mathop{\mathrm{tr}}V^3$ by cyclicity, so the sum of cubes is $\tfrac18\cdot2(\mathop{\mathrm{tr}}U^3+3\mathop{\mathrm{tr}}UV^2)$.
- $\mathop{\mathrm{tr}}X_1X_2X_2=\mathop{\mathrm{tr}}X_2X_1X_2$, so $B=\mathop{\mathrm{tr}}(UX_1X_2)$, and $X_1X_2=\tfrac14(U^2-UV+VU-V^2)$ gives $\tfrac14(\mathop{\mathrm{tr}}U^3-\mathop{\mathrm{tr}}UV^2)$ since $\mathop{\mathrm{tr}}U^2V=\mathop{\mathrm{tr}}UVU$.
- $\mathop{\mathrm{tr}}X_1X_2=\tfrac14(\mathop{\mathrm{tr}}U^2-\mathop{\mathrm{tr}}V^2)$.
- Coefficients: $\tfrac64+\tfrac94=\tfrac{15}4$, $\tfrac{18}4-\tfrac94=\tfrac94$, $-18m\cdot\tfrac14=-\tfrac92m$. Norm: $\lvert U\rvert^2+\lvert V\rvert^2+\tfrac12(\lvert U\rvert^2-\lvert V\rvert^2)$.
- **The bold claim is right.** At fixed $m$, $U$ and $\lvert V\rvert$, $V$ enters $P$ only through $\mathop{\mathrm{tr}}(UV^2)$ and the norm not at all. The spectrum of $V$ at fixed $\lvert V\rvert$ also enters only there, and step 3 keeps the spectrum, so nothing further is needed.

## Item 3, step 3

- An eigenframe of symmetric $U$ can be taken in $SO(3)$ by negating a column. $\mathop{\mathrm{tr}}(UV^2)=\mathop{\mathrm{tr}}\big((Q^{\mathsf T}UQ)(Q^{\mathsf T}V^2Q)\big)=\sum_iu_id_i$.
- $d_i=q_i^{\mathsf T}V^2q_i$ for the unit column $q_i$, so $w_3\le d_i\le w_1$, the direction written. $d_1+d_2=\sum w-d_3\le w_1+w_2$.
- The Abel form has coefficient $u_1,u_2,u_3$ on $d_1,d_2,d_3$, and its weights $u_2-u_3$ and $u_1-u_2$ are nonnegative, so the inequality follows term by term.
- The eigenvalues of $V^2$ are the squares of those of $V$ with multiplicity, so an indexing with $\nu_i^2=w_i$ exists (ties and pairs $\pm\nu$ allowed).
- $V'$: symmetric, $\mathop{\mathrm{tr}}V'=\sum\nu_i=\mathop{\mathrm{tr}}V=0$, diagonal in the frame that diagonalises $U$ so commuting, $\lvert V'\rvert^2=\sum\nu_i^2=\lvert V\rvert^2$, $\mathop{\mathrm{tr}}(UV'^2)=\sum u_iw_i$.
- *Screen*: one constructed random pair gave $\mathop{\mathrm{tr}}V'\approx4\cdot10^{-15}$, equal norms, commutator $7\cdot10^{-15}$ and $\mathop{\mathrm{tr}}(UV^2)=39.5\le89.9=\mathop{\mathrm{tr}}(UV'^2)$. A screen, not evidence.

## Item 4, step 4

- **Membership.** The block note's character argument reads "survives exactly when", so an operator of the block form lies in $\mathcal S_J$, and L226's Setting takes $\mathcal S_J$ in the symmetric operators with no Weyl condition. $W'$ built from $M_a'=mI+X_1'$, $M_b'=mI+X_2'$, $K'=-3m$ and $S'=X_1'+X_2'-mI=U-mI=S$ satisfies item 2: Bianchi is automatic at $k=3$ (item 3), $\mathop{\mathrm{tr}}M'_a+K'=0$, and $S'$ is the Ricci-determined $R_J$.
- **Norm and value.** $m$, $U$ and $\lvert V'\rvert=\lvert V\rvert$ agree, so step 2 gives equal norms and $P(W')-P(W)=\tfrac94\big(\mathop{\mathrm{tr}}UV'^2-\mathop{\mathrm{tr}}UV^2\big)\ge0$.
- **The rotation.** Let $g$ act on $\mathbb R^J$ and fix $\mathbb R^A$. Then $\varphi_{pa}\mapsto\sum_rg_{rp}\varphi_{ra}$, so $M_a\mapsto gM_ag^{\mathsf T}$. Under $\varphi_{23},\varphi_{31},\varphi_{12}\mapsto e_1,e_2,e_3$, $x\wedge y\mapsto x\times y$, and $gx\times gy=(\det g)\,g(x\times y)$ for orthogonal $g$, so $\Lambda^2g=(\det g)\,g$ and $S\mapsto gSg^{\mathsf T}$ **for either sign of $\det g$**. The restriction $Q\in SO(3)$ is harmless but unnecessary. *Screen*: an improper orthogonal $3\times3$ matrix $R$ gave $\lvert\Lambda^2R+R\rvert_\infty=2\cdot10^{-16}$.
- At $g=Q^{\mathsf T}$ every block is diagonal and $K$ is unchanged. The cross-block entries vanish by the block form, so every $\varphi_{ij}$ is an eigenvector: the tensor is coordinate-diagonal. $O(J)$ preserves $P$, the norm and $\mathcal W_5$ (the block note records $\mathcal S_J$ as $O(J)$-invariant, and $P$ is $O(n)$-invariant). By L57's domain bijection it corresponds to a vertex matrix in $\mathcal D_5$, and L57 at $n=5\ge4$ gives $P\le\Theta_5\lVert W\rVert^3=\Theta_5$.
- **Normalisation.** L226's norm on a diagonal tensor is $\sum_{i<j}K_{ij}^2$, the unordered sum, which is the reading of $\lVert W\rVert=1$ that [conventions.md](../findings/conventions.md) records (unit coordinate-diagonal $W$ has unordered sum $1$). *Screen*: the vertex matrix $Z(v)$ at $v=(3,3,-2,-2,-2)/\sqrt{30}$, normalised to $\sum_{i<j}Z_{ij}^2=1$, has zero row sums and value $0.9428090416$ under L226's Gate 1 (b) diagonal form, against $\tfrac{2\sqrt2}3=0.9428090416$.
- **Inherited, not a defect of L227.** L57's block states that two identities it rests on ($\lvert Z(v)\rvert^2$ and the vertex-matrix form of $\mathop{\mathrm{tr}}W^3$ and $\langle W,W^\#\rangle$) are "supported by agreement at test points" and that "a consumer of L57 inherits them". L227 is such a consumer.
- **Wording.** "a unit element of $\mathcal D_5$ at unit norm" says unit twice, and $\mathcal D_5$ is the vertex-matrix space, not the tensor space. Correction C4 below.

## Item 5, attainment

- $H_J$ is the sign changes constant on $J$ and free off it, a subgroup of $\Gamma$, so $\mathcal D_n=\mathcal S_{\{i\}}=\mathop{\mathrm{Fix}}\Gamma\subseteq\mathop{\mathrm{Fix}}H_J=\mathcal S_J$. Directly: a diagonal entry $W_{ij,ij}$ carries a squared character.
- L57's attainment formula at $n=5$, $p=2$, $q=3$: $\theta^2=\tfrac{2\cdot4\cdot1\cdot2}{3\cdot2\cdot3}=\tfrac89$, so $\theta=\tfrac{2\sqrt2}3=\Theta_5$, which matches $\Theta_5^2=\tfrac{2\cdot4\cdot2}{6\cdot3}=\tfrac89$. The attaining tensor is diagonal, so its blocks and $S$ commute, as the statement says.
- The statement claims existence of a commuting maximiser, not that every maximiser commutes, and the proof gives exactly that.

## Item 6, Gate 1

I reran [screen_I106.py](../scripts/misc/screen_I106.py) unchanged (seeded, 7.8 s). This is a reproduction of the cited screen, and it establishes nothing about the lemma.

- **(a)** Screen 1 at $n=5$ gives $P$ trusted $8.8487923450$ against the traceless formula $8.8487923450$. At two outer indices that formula has pair coefficient $\tfrac32(-3m-m-m-m)\cdot2=-18m$ and constant $-72m^3$, so it is step 1's polynomial. The batch-4 line gives $54.7927829790$ for both the trusted value and step 2's form. **The norm is not compared with anything trusted.** Both norm columns are `norm2_blocks` (L226's block norm) against the traceless or $U,V$ formula, so "Step 1's polynomial and norm agree with the trusted $Q$" overstates the norm half. The norm claim is true (the assembled pair-basis matrix has entry squares equal to the block norm by construction), but the script does not check it. Correction C1.
- **(b)** True. `blockP_m2` closes by `simp` with `det_fin_three` and `adjugate_fin_three`, entrywise, with no use of the Cayley–Hamilton forms, and `value_UV`, `norm_UV` are step 2.
- **(c)** Reproduced: `n=5: best theta 0.942809`, `max|[M_a,M_b]|/|W|^2 2.05e-08`, `max|[S,M_a]| 2.05e-08`, blocks with eigenvalues $(-0.236,-0.236,0.236)$ and $K=0.236$ (units of $\lvert W\rvert$). **The commutator is $2\cdot10^{-8}$, not $5\cdot10^{-10}$.** The screen prints "60 restarts" but its loop runs `range(3)` restarts of at most 400 steps. Correction C2.
- **(d)** True, though "the same formula" is loose. At one outer index Ricci gives $\mathop{\mathrm{tr}}M_a=0$, $S=M_a=X_1$, and L226 item 3 reads $\mathop{\mathrm{tr}}X^3+\mathop{\mathrm{tr}}X^3+\mathop{\mathrm{tr}}X^3+3\mathop{\mathrm{tr}}(X\mathop{\mathrm{adj}}X)=6\mathop{\mathrm{tr}}X^3$ at norm $2\lvert X\rvert^2$. This is step 1's formula at $X_2=0$, $m=0$ with the $K$ terms absent. L225 at $k=3$ gives $6\cdot\tfrac1{\sqrt6}\cdot2^{-3/2}=\tfrac{\sqrt3}2$, and $\Theta_4^2=\tfrac{2\cdot3\cdot2}{16}=\tfrac34$. Optional correction C3.

## Item 7, Lean

`lake build HamiltonsCubic.Results.L227Statement` succeeds with one `declaration uses sorry` warning, at line 94 (`alignment_step`). `#print axioms` from a scratch file:

| Declaration | Axioms |
|---|---|
| `blockP_m2`, `normSq_m2`, `value_UV`, `norm_UV`, `rearrangement` | `propext`, `Classical.choice`, `Quot.sound` |
| `alignment_step`, `commuting_improvement` | `propext`, `sorryAx`, `Classical.choice`, `Quot.sound` |

- `blockP_m2` instantiates L226's `blockP` at two outer indices with $S=X_1+X_2-m\cdot1$, blocks `![m • 1 + X₁, m • 1 + X₂]` and $K_{ab}=-3m$ off the diagonal, which is step 1's data. `valueX` is step 1's display. The triple sum is empty at two outer indices.
- `normSq_m2`'s left side is the right side of L226's `normSq_blockOp` at the same data, restated inline rather than referenced, and `normX` is step 1's norm.
- `value_UV`, `norm_UV` are step 2 for all real $3\times3$ matrices. `((X₁+X₂)*(X₁-X₂)*(X₁-X₂)).trace` is $\mathop{\mathrm{tr}}(UV^2)$, and `((X₁+X₂)*(X₁+X₂)).trace` equals $\lvert U\rvert^2$ on the symmetric inputs where it is used.
- `rearrangement` is step 3's inequality with hypotheses $u_2\le u_1$, $u_3\le u_2$, $d_1\le w_1$, $d_1+d_2\le w_1+w_2$ and equal sums. It is not used by `alignment_step`, whose proof is the `sorry`.
- **`alignment_step` is a weakening of step 3, not the exact claim.** It assumes $U$ symmetric (not traceless) and asserts a traceless symmetric $V'$ with $\mathop{\mathrm{tr}}V'^2=\mathop{\mathrm{tr}}V^2$, $UV'=V'U$ and $\mathop{\mathrm{tr}}(UV^2)\le\mathop{\mathrm{tr}}(UV'^2)$. It drops step 3's clauses that $V'$ is isospectral to $V$ and that $\mathop{\mathrm{tr}}(UV'^2)=\sum u_iw_i$. The statement is true (step 3 proves it), its hypotheses are satisfiable, and its conclusion is not trivially met, since at fixed norm the inequality needs the Rayleigh or rearrangement input. It is exactly what `commuting_improvement` consumes.
- `commuting_improvement` follows from it with $Y_{1,2}=\tfrac12(U\pm V')$: traces, symmetry, $Y_1Y_2=Y_2Y_1\iff UV'=V'U$, and `norm_UV`, `value_UV` with $\tfrac94(\cdot)\ge0$. It states nothing about $W'$ or $P$ itself, which the paragraph's closing sentence covers.
- **Wording.** In "`commuting_improvement`, steps 3 and 4 up to the rotation, is proved from it: it needs the spectral theorem ...", the second "it" grammatically picks up `commuting_improvement`, whose proof needs nothing of the kind. The declaration that needs the spectral theorem is `alignment_step`. Correction C5.

## Item 8, What it gives

- **Model case outside $n\ge12$.** True, $n=5$.
- **Vacuity for global maximisers.** True: $\sqrt{3/2}\approx1.2247>0.9428\approx\Theta_5$, so no global maximiser of $P$ on the unit sphere of $\mathcal W_5$ lies in $\mathcal S_J\cap\mathcal W_5$ for any $\lvert J\rvert=3$.
- **Three outer indices.** Two problems.
  - **Notation.** In this sentence $m$ is the number of outer indices (L226's $m=n-k$). In steps 1 to 4 of the same block $m$ is the scalar with $M_a=mI+X_a$. At three outer indices the traces $\mathop{\mathrm{tr}}M_a=-\sum_{b\ne a}K_{ab}$ are no longer forced equal, so the reader cannot carry step 1's $m$ over.
  - **Status.** The claim that $\sum_a\mathop{\mathrm{tr}}Y_a^3$ is an invariant "which no single alignment controls" is batch 6's heuristic reading, not a derived statement. Batch 6 also records a second change, the Gram part $\sum_{a\ne b}\beta_{ab}[\cdot]$ with pairwise alignments, which the sentence omits. The vanishing at two outer indices is right ($Y_1=-Y_2=\tfrac12V$). Correction C6.

## Item 9, counterexample hunt

- **No unit $W$ with $P(W)>\Theta_5$ exists.** Steps 1 to 4 map every unit $W\in\mathcal S_J\cap\mathcal W_5$ to a unit coordinate-diagonal Weyl tensor of value at least $P(W)$, and L57 bounds that by $\Theta_5$. Every link is confirmed above, so a counterexample would refute L57 or L226.
- **No pair $(U,V)$ lacks a $V'$.** The spectral theorem gives $Q$ for every symmetric $U$, and step 3's construction then applies to every traceless symmetric $V$, including $V=0$, repeated eigenvalues of $U$, and $\pm\nu$ pairs in $V$.
- **Edges checked.**
  - $m<0$ and $m=0$ need no sign condition anywhere.
  - Ties $u_1=u_2$ make an Abel weight zero.
  - $J$ other than the first three indices is a permutation, under which $P$ and $\mathcal W_5$ are invariant.
  - At the three placements of $S^2\times S^3$ relative to $J$, the blocks give $V=0$ twice and $V$ proportional to $\mathop{\mathrm{diag}}(2,-1,-1)$ once, with $U$ diagonal in the same frame, so commuting in each case.

## Corrections

**C1 (Gate 1 (a)).** Replace

> Step 1's polynomial and norm agree with the trusted $Q$ of [curvature_operator.py](../scripts/lib/curvature_operator.py) at $n=5$ to ten digits, and so does step 2's form in $U,V$ ([screen_I106.py](../scripts/misc/screen_I106.py)).

with

> Step 1's polynomial and step 2's form in $U,V$ agree with the trusted $Q$ of [curvature_operator.py](../scripts/lib/curvature_operator.py) at $n=5$ to ten digits, and both norm formulas agree with L226's block norm to ten digits ([screen_I106.py](../scripts/misc/screen_I106.py)). The norm is compared formula to formula, not against the trusted operator.

**C2 (Gate 1 (c)).** Replace "A bounded random-restart ascent on $\mathcal S_J\cap\mathcal W_5$ reached $0.942809=\Theta_5$ at blocks commuting to $5\cdot10^{-10}$" with "A bounded ascent from three random starts on $\mathcal S_J\cap\mathcal W_5$ reached $0.942809=\Theta_5$ at blocks commuting to $2\cdot10^{-8}$". Optionally correct the script's printed "60 restarts" to "3 restarts" (not a findings edit, and outside this reviewer's remit to apply).

**C3 (Gate 1 (d), optional).** Replace "*At one outer index* the same formula reads $P=6\mathop{\mathrm{tr}}X_1^3$" with "*At one outer index* Ricci forces $\mathop{\mathrm{tr}}M_a=0$, and L226's item 3 reads $P=6\mathop{\mathrm{tr}}X_1^3$".

**C4 (step 4, wording).** Replace "That tensor is coordinate-diagonal, a unit element of $\mathcal D_5$ at unit norm, and [L57](problem.md) gives" with "That tensor is a unit coordinate-diagonal Weyl tensor, whose vertex matrix lies in $\mathcal D_5$ by L57's domain bijection, and [L57](problem.md) gives". Optionally add after "conjugates $S$ as well": "(for any orthogonal $g$ of $\mathbb R^J$, $\Lambda^2g=(\det g)\,g$ in that frame, so the sign of $\det Q$ is immaterial)".

**C5 (Lean paragraph).** Replace

> `alignment_step` is the existence of $V'$ in step 3 and carries the named `sorry`, and `commuting_improvement`, steps 3 and 4 up to the rotation, is proved from it: it needs the spectral theorem for symmetric $3\times3$ matrices and the Rayleigh bounds, which the file does not build.

with

> `alignment_step` is the existence of $V'$ in step 3, stated without the isospectral clause, which its consumer does not need. It carries the named `sorry`, since it needs the spectral theorem for symmetric $3\times3$ matrices and the Rayleigh bounds, which the file does not build. `commuting_improvement`, steps 3 and 4 up to the rotation and stated for the polynomials `valueX` and `normX`, is proved from it.

**C6 (What it gives).** Replace

> At three or more outer indices the fluctuations $Y_a=X_a-\tfrac1m\sum_bX_b$ carry a second cubic invariant, $\sum_a\mathop{\mathrm{tr}}Y_a^3$ under $\sum_aY_a=0$, which no single alignment controls ([derivation](../reviews/2026-09-15-I106-derivation.md), batch 6).

with

> At $\lvert A\rvert\ge3$ outer indices the traces $\mathop{\mathrm{tr}}M_a$ are no longer forced equal, and the fluctuations $Y_a=X_a-\tfrac1{\lvert A\rvert}\sum_bX_b$ carry a cubic term $\sum_a\mathop{\mathrm{tr}}Y_a^3$ under $\sum_aY_a=0$, which vanishes at $\lvert A\rvert=2$, together with pairwise Gram couplings. The derivation found no single alignment that controls them ([derivation](../reviews/2026-09-15-I106-derivation.md), batch 6), a heuristic reading and not a derived obstruction.

**Brief note (already handled).** The first version of the brief quoted L223's statement as L57's. The coordinator's correction supplies L57's own block, and items 4 and 5 above were checked against that block in [problem.md](../findings/problem.md).
