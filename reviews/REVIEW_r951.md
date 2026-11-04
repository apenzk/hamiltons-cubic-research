# Gate 2 review r951, Lemma L227

Brief: [BRIEF_L227.md](BRIEF_L227.md), with the coordinator's correction that L57's own block ([problem.md](../findings/problem.md), heading "Lemma L57, the diagonal theorem, all $n$, both parities") replaces the first version's quote, which was L223's statement. Log: [agent_logs/review-r951.log](../agent_logs/review-r951.log).

**Verdict: L227 stands.** Every step was rederived by hand from L226, the block note and L57, and every constant agrees. The chain has two citation gaps in step 4 (the membership of $W'$ in $\mathcal S_J$ and the invariance of $P$ under the rotation) and one inheritance it does not disclose (L57's two flagged identities). The Lean paragraph and What it gives each need one precision. No counterexample exists.

| Item | Verdict | Reason |
|---|---|---|
| 1. Step 1 | CONFIRMED | Both Cayley–Hamilton expansions, the polynomial, $-72m^3$ and $18m^2$ rederived by hand. The letter $m$ collides with L226's $m=n-k$ (C1). |
| 2. Step 2 | CONFIRMED | The three trace identities need only cyclicity and $\mathop{\mathrm{tr}}(UV)=\mathop{\mathrm{tr}}(VU)$, and $\tfrac{15}4,\tfrac94,\tfrac92,\tfrac32,\tfrac12$ follow. At fixed $m$, $U$, $\lvert V\rvert$ every other term is fixed. |
| 3. Step 3 | CONFIRMED | Rayleigh bounds in the right direction, $d_1+d_2\le w_1+w_2$ from the equal sums, the Abel summation checks coefficient by coefficient, and $V'$ has every stated property. Ties and $V=0$ are covered. |
| 4. Step 4 | CONFIRMED, gaps | Conclusion right. $W'\in\mathcal S_J$ needs the converse of L226's block form, from the block note (C2). $P(W')$ equal to the rotated value needs $O(5)$-invariance (C3). $\det Q=-1$ also conjugates $S$. L57 applies at $n=5$ and its caveat is inherited (C4). |
| 5. Attainment | CONFIRMED | $\mathcal D_5=\mathcal S_{\{i\}}$ is fixed by every sign change, so $\mathcal D_5\subseteq\mathcal S_J$. The $S^2\times S^3$ vertex matrix $(3,1,-1)$ gives $72/18^{3/2}=\tfrac{2\sqrt2}3$ by hand. |
| 6. Gate 1 | CONFIRMED, (c) PLAUSIBLE | (a) rerun of the formula part of the screen reproduces ten digits. (b) matches the file. (c) is an ascent, not rerun, and the script labels 3 restarts as 60 (C7). (d) is true, worded as the wrong formula (C6). |
| 7. Lean | CONFIRMED | Compiles with one `sorry` at line 94. Axioms exactly as stated. `alignment_step` is true and non-vacuous, stated with commuting in place of diagonal in $Q$. The paragraph's "it needs" has the wrong antecedent (C8). |
| 8. What it gives | PLAUSIBLE | Scope claims true. The three-outer-index sentence reuses $m$ as a count and omits batch 6's weighted Gram part (C9). "Vacuous" is loose (C10). |
| 9. Counterexample hunt | CONFIRMED | None exists: step 3 constructs $V'$ for every symmetric $U$ and traceless symmetric $V$, and steps 1 to 4 hold without further hypotheses. |

## Item 1, step 1

- **Ricci reduction.** With $A=\{a,b\}$, L226's item 2 at each outer index reads $\mathop{\mathrm{tr}}M_a+K_{ab}=0=\mathop{\mathrm{tr}}M_b+K_{ab}$, so both traces are $3m$ with $K_{ab}=-3m$. Then $N=2mI+X_1+X_2$, $\mathop{\mathrm{tr}}N=6m$ and item 3's $S=N-3mI=X_1+X_2-mI$.
- **Adjugate.** For $3\times3$ $A$, $\mathop{\mathrm{adj}}A=A^2-(\mathop{\mathrm{tr}}A)A+e_2(A)I$. At $A=mI+X$, $e_2=\tfrac12(9m^2-3m^2-\mathop{\mathrm{tr}}X^2)$, which gives $X^2-mX+(m^2-\tfrac12\mathop{\mathrm{tr}}X^2)I$.
- **Determinant.** $e_3=\tfrac16\big((\mathop{\mathrm{tr}}A)^3-3\mathop{\mathrm{tr}}A\mathop{\mathrm{tr}}A^2+2\mathop{\mathrm{tr}}A^3\big)$ at $A=X-mI$ with $\mathop{\mathrm{tr}}A^3=\mathop{\mathrm{tr}}X^3-3m\mathop{\mathrm{tr}}X^2-3m^3$ gives $\tfrac13\mathop{\mathrm{tr}}X^3+\tfrac12m\mathop{\mathrm{tr}}X^2-m^3$.
- **Assembling**, with $s=\lvert X_1\rvert^2+\lvert X_2\rvert^2$, $c=\mathop{\mathrm{tr}}X_1X_2$ and $\lvert U\rvert^2=s+2c$:
  - $\mathop{\mathrm{tr}}S^3+3\det S=2\mathop{\mathrm{tr}}U^3-\tfrac32m\lvert U\rvert^2-6m^3$.
  - $\sum_a\mathop{\mathrm{tr}}M_a^3=6m^3+3ms+\mathop{\mathrm{tr}}X_1^3+\mathop{\mathrm{tr}}X_2^3$.
  - $\sum_a3\mathop{\mathrm{tr}}(S\mathop{\mathrm{adj}}M_a)=3\mathop{\mathrm{tr}}\big(U(X_1^2+X_2^2)\big)-3m\lvert U\rvert^2+\tfrac32ms-18m^3$.
  - $K^3+3K\mathop{\mathrm{tr}}(M_aM_b)=-54m^3-9mc$.
  - Cubic part: $2(A+3B)+A+3(A+B)=6A+9B$ with $A=\sum\mathop{\mathrm{tr}}X_i^3$, $B=\mathop{\mathrm{tr}}X_1^2X_2+\mathop{\mathrm{tr}}X_1X_2^2$.
  - Linear in $m$: $-\tfrac92m(s+2c)+\tfrac92ms-9mc=-18mc$.
  - Constant: $-6+6-18-54=-72$.
- **Norm.** $\lvert S\rvert^2=\lvert U\rvert^2+3m^2$, $\sum\lvert M_a\rvert^2=6m^2+s$, $K^2=9m^2$, total $2s+2c+18m^2$.
- **Screen**, screen_r951.py in the session scratchpad, uncommitted (`/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/8003e6c1-e5ca-4867-b816-0a2997ebc8d6/scratchpad/screen_r951.py`), seconds: one random $W$ at $n=5$ built entry by entry, Ricci contraction $4\cdot10^{-16}$, step 1's $P$ and norm equal to the trusted $Q$ to $10^{-14}$. A screen of the hand derivation above, no evidence by itself.
- **Precision.** L226's Setting fixes $m=n-k$, which is $2$ here, and L227 uses $m$ for $\tfrac13\mathop{\mathrm{tr}}M_a$ without saying so. The Lean file shows the clash as `blockP (m := 2)` beside a real `m`. C1.

## Item 2, step 2

- $\mathop{\mathrm{tr}}(U\pm V)^3=\mathop{\mathrm{tr}}U^3\pm3\mathop{\mathrm{tr}}U^2V+3\mathop{\mathrm{tr}}UV^2\pm\mathop{\mathrm{tr}}V^3$ by cyclicity, so the sum over signs divided by $8$ is $\tfrac14\mathop{\mathrm{tr}}U^3+\tfrac34\mathop{\mathrm{tr}}UV^2$.
- $\mathop{\mathrm{tr}}X_1^2X_2+\mathop{\mathrm{tr}}X_1X_2^2=\mathop{\mathrm{tr}}X_1X_1X_2+\mathop{\mathrm{tr}}X_2X_1X_2=\mathop{\mathrm{tr}}(UX_1X_2)$, and $4X_1X_2=U^2-UV+VU-V^2$ gives $\tfrac14(\mathop{\mathrm{tr}}U^3-\mathop{\mathrm{tr}}UV^2)$.
- $\mathop{\mathrm{tr}}X_1X_2=\tfrac14(\lvert U\rvert^2-\lvert V\rvert^2)$ uses symmetry only for $\lvert\cdot\rvert^2=\mathop{\mathrm{tr}}(\cdot)^2$.
- Coefficients: $\tfrac64+\tfrac94=\tfrac{15}4$, $\tfrac{18}4-\tfrac94=\tfrac94$, $\tfrac{18}4=\tfrac92$ on both squares. Norm: $s=\tfrac12(\lvert U\rvert^2+\lvert V\rvert^2)$ gives $\tfrac32\lvert U\rvert^2+\tfrac12\lvert V\rvert^2$.
- The bold claim is right: at fixed $m$, $U$, $\lvert V\rvert$ the terms $\mathop{\mathrm{tr}}U^3$, $\lvert U\rvert^2$, $\lvert V\rvert^2$, $m^3$ and the whole norm are fixed. Both $V$'s frame and its spectrum at fixed $\lvert V\rvert$ enter through $\mathop{\mathrm{tr}}(UV^2)$ alone, and step 3 keeps the spectrum.

## Item 3, step 3

- $d_1=q_1^{\mathsf T}V^2q_1\le w_1$ and $d_3=q_3^{\mathsf T}V^2q_3\ge w_3$, both Rayleigh in the stated direction. $\sum d_i=\mathop{\mathrm{tr}}V^2=\sum w_i$ gives $d_1+d_2=\sum w_i-d_3\le w_1+w_2$.
- Abel summation: the coefficients of $d_1,d_2,d_3$ in $u_3\sum d_i+(u_2-u_3)(d_1+d_2)+(u_1-u_2)d_1$ are $u_1,u_2,u_3$. The inequality uses $u_1-u_2\ge0$ and $u_2-u_3\ge0$ only, so repeated $u_i$ are covered.
- $V$ symmetric, so $V^2$ has eigenvalues $\nu_i^2$ and an indexing with $\nu_i^2=w_i$ exists, ties included.
- $V'$: $\mathop{\mathrm{tr}}V'=\sum\nu_i=\mathop{\mathrm{tr}}V=0$, symmetric, diagonal in $Q$ with $U$ so commuting, $\lvert V'\rvert^2=\sum\nu_i^2=\lvert V\rvert^2$, and $V'^2=Q\mathop{\mathrm{diag}}(w)Q^{\mathsf T}$ gives $\mathop{\mathrm{tr}}UV'^2=\sum u_iw_i$.
- $Q\in SO(3)$ is available: flipping one column keeps an eigenframe.
- Screen (same file, seconds, $\det Q$ forced to $-1$): $[U,V']$ at $7\cdot10^{-16}$, $\mathop{\mathrm{tr}}UV'^2=\sum u_iw_i$ to $10^{-15}$.

## Item 4, step 4

- **Membership.** $X_i'$ traceless, symmetric, diagonal in $Q$. With the same $m$ and $K=-3m$ the Ricci-determined curvature block is $S'=X_1'+X_2'-mI=U-mI=S$, unchanged, a fact the proof uses silently. L226's items 2 and 3 then give Weyl: Bianchi automatic at $k=3$, $(\mathop{\mathrm{tr}}S')I-S'+N'=0$ from $S'=N'-\tfrac12(\mathop{\mathrm{tr}}N')I$, and $\mathop{\mathrm{tr}}M_a'+K_{ab}=0$.
- **Gap (C2).** L226's item 2 characterises Weyl *within* $\mathcal S_J$, and L226's Setting states only that $W\in\mathcal S_J$ is block-diagonal. That the operator built from $(S,M_a',K)$ lies in $\mathcal S_J$ is the converse, which the [block note](2026-09-14-I104-block-J.md) supplies: $H_J$ is the sign changes constant on $J$, and an entry survives exactly when its index multiset is trivial on $H_J$. Every block entry ($JJJJ$, $pa\,qa$, $ab\,ab$) is such. The step cites item 2 alone.
- **Norm and value.** Step 2 at the same $m$, $U$ and $\lvert V'\rvert=\lvert V\rvert$ gives both. Screen: $P(W')-P(W)$ divided by $\tfrac94$ equals $\mathop{\mathrm{tr}}UV'^2-\mathop{\mathrm{tr}}UV^2=3.9011$, norms equal to $10^{-14}$.
- **The rotation.** $O=Q^{\mathsf T}\oplus I_2$ acts on $V_a\cong\mathbb R^J$ by $Q^{\mathsf T}$, so $M_a\mapsto Q^{\mathsf T}M_aQ$, and fixes every $\varphi_{ab}$. On $\Lambda^2\mathbb R^J$ in the frame $\varphi_{23},\varphi_{31},\varphi_{12}$ it acts by $Q^{\mathsf T}x\times Q^{\mathsf T}y=\det(Q)\,Q^{\mathsf T}(x\times y)$, so $S\mapsto Q^{\mathsf T}SQ$ for **every** orthogonal $Q$: the sign $\det Q$ appears twice and cancels in a conjugation. The restriction to $SO(3)$ is correct and unnecessary. Screen at $\det Q=-1$: the rotated $W'$ has off-diagonal entries at $4\cdot10^{-16}$ and the same $P$.
- **Gap (C3).** The chain $P(W)\le P(W')\le\Theta_5$ applies L57 to the rotated tensor, not to $W'$. The link needs $P$, $\lVert\cdot\rVert$ and $\mathcal W_5$ invariant under $O(5)$ conjugation, standard and unstated.
- **Coordinate-diagonal and unit.** Every block diagonal means $W$ is diagonal in the pair basis. L57's domain paragraph identifies it with its vertex matrix in $\mathcal D_5$, Ricci-flatness being $S\mathbf 1=0$. "A unit element of $\mathcal D_5$ at unit norm" says unit twice.
- **L57 at $n=5$.** L57 holds for every diagonal $W$ at every $n\ge4$ with $\Theta_5^2=\frac{2\cdot4\cdot2}{6\cdot3}=\frac89$, so $\Theta_5=\tfrac{2\sqrt2}3$.
- **Inheritance (C4).** L57's block says "Two identities carry this result and neither is derived on file ... a consumer of L57 inherits them." L227 is such a consumer and does not say so. The second identity is supplied at coordinate-diagonal $W$ by L226's item 1 as its Gate 1 (b) reads it ($\tfrac12\langle M^{\circ2},M\rangle=\sum_{i<j}M_{ij}^3$, $\tfrac12\langle M^2,M\rangle=3\sum_{i<j<l}M_{ij}M_{il}M_{jl}$). The first, $\lvert Z(v)\rvert^2$, is the formula L223's block reports deriving. I did not audit L223's derivation.

## Item 5, attainment

- $\mathcal D_5=\mathcal S_{\{i\}}$ (block note line 13): a coordinate-diagonal operator is fixed by every sign change, $H_J$ among them, so $\mathcal D_5\subseteq\mathcal S_J$ for every $J$.
- L57's equality case at odd $n=5$ is $S^2\times S^3$. Its vertex matrix, constant on the three classes with row sums zero, is $x=3$ on the one pair inside the $2$-class, $y=1$ on the three pairs inside the $3$-class, $z=-1$ on the six cross pairs. Norm$^2=9+3+6=18$. Cubes $27+3-6=24$. Triangles: one $yyy$, six $yzz$, three $xzz$, sum $16$, times $3$ is $48$. $P=72$ and $72/18^{3/2}=\tfrac{2\sqrt2}3$. Screen: $0.9428090416$ from the trusted $Q$.
- The vertex tensor has diagonal, hence commuting, blocks for every $J$. The statement is existential ("attained at a unit $W$"), and the proof gives nothing about uniqueness, consistent with batch 4's remark that non-commuting maximisers can occur.

## Item 6, Gate 1

- **(a)** CONFIRMED as a screen. The formula part of [screen_I106.py](../scripts/misc/screen_I106.py) (screen 1 and the batch 4 line, cut before screens 3 and 2) reproduces trusted $Q$ equal to the traceless formula at $n=5$ ($8.8487923450$) and to the $U,V$ form ($54.7927829790$), norms likewise. The script checks step 1 through batch 1's general traceless formula, whose reading at two outer indices is step 1's polynomial term by term ($\mu=2m$, Gram weight $\tfrac32(K-2m-m)$ per ordered pair giving $-18m$, constants $-6+6-18-27-27=-72$), checked by hand.
- **(b)** CONFIRMED. `blockP_m2` unfolds `blockP` with `det_fin_three` and `adjugate_fin_three`, independent of the written expansions. It takes $S=X_1+X_2-mI$ as input, the Ricci inversion being L226's `ricciJ_inverse`.
- **(c)** PLAUSIBLE. An ascent is an optimisation, excluded by the brief, so not rerun. The script's screen 2 header prints "60 restarts" while the loop runs `range(3)` (C7).
- **(d)** CONFIRMED in substance. At one outer index item 2 forces $\mathop{\mathrm{tr}}M_a=0$ and there is no $K$, so $S=X$, $\det X=\tfrac13\mathop{\mathrm{tr}}X^3$, $\mathop{\mathrm{tr}}(X\mathop{\mathrm{adj}}X)=\mathop{\mathrm{tr}}X^3$ and $P=(1+1+1+3)\mathop{\mathrm{tr}}X^3=6\mathop{\mathrm{tr}}X^3$, norm $2\lvert X\rvert^2$. L225 at $k=3$ gives $6/(\sqrt6\cdot2\sqrt2)=\tfrac{\sqrt3}2=\Theta_4$. "The same formula" is step 1's at $X_2=0$, $m=0$, which agrees, but the derivation is L226's item 3 at one outer index (C6).

## Item 7, Lean

- `lake env lean HamiltonsCubic/Results/L227Statement.lean` exits 0 with one warning, `declaration uses sorry` at line 94, `alignment_step`.
- `#print axioms` on a scratch copy with the queries appended:
  - `blockP_m2`, `normSq_m2`, `value_UV`, `norm_UV`, `rearrangement`: `propext`, `Classical.choice`, `Quot.sound`.
  - `alignment_step`, `commuting_improvement`: the same plus `sorryAx`.
- `blockP_m2` uses L226's `blockP` at two outer indices with blocks $mI+X_a$, $K=-3m$ off the diagonal and $S=X_1+X_2-mI$, as step 1. It needs no symmetry hypothesis, which is stronger. `normSq_m2`'s left side is `normSq_blockOp`'s right side at `m := 2`, copied rather than referenced, and it matches.
- `value_UV`, `norm_UV` are step 2 as identities over all real $3\times3$ matrices, with $\lvert\cdot\rvert^2$ written as $\mathop{\mathrm{tr}}(\cdot\cdot)$, equal on symmetric matrices.
- `rearrangement` is step 3's inequality from $d_1\le w_1$, $d_1+d_2\le w_1+w_2$ and equal sums.
- `alignment_step` is true (step 3 proves it) and non-vacuous: symmetric $U$, symmetric traceless $V$, conclusion symmetric traceless $V'$ with $\mathop{\mathrm{tr}}V'^2=\mathop{\mathrm{tr}}V^2$, $UV'=V'U$, $\mathop{\mathrm{tr}}UVV\le\mathop{\mathrm{tr}}UV'V'$. It replaces "diagonal in $Q$" with "commutes with $U$", which is what step 4 uses, since commuting symmetric matrices diagonalise together. $U$ need not be traceless, a harmless generalisation.
- `commuting_improvement` follows as stated: $Y_{1,2}=\tfrac12(U\pm V')$, traces, commutation by `abel` after `hcomm`, and norm and value by `norm_UV`, `value_UV`, `hV'n`, `nlinarith`. It covers steps 3 and 4 up to the membership of $W'$ and the rotation.
- **Precision (C8).** In the block's Lean paragraph, "is proved from it: it needs the spectral theorem ..." attaches the need to `commuting_improvement`. The spectral theorem and Rayleigh bounds are what the `sorry` in `alignment_step` stands for.

## Item 8, what it gives

- **Outside $n\ge12$**: $n=5<12$, and [problem.md](../findings/problem.md)'s necessity of $n\ge12$ is the padded $W_{\mathbb{CP}^2}$ witness. True.
- **Global maximisers**: $\sqrt{3/2}\approx1.2247>0.9428\approx\Theta_5$, so no global maximiser of $P$ on the unit sphere of $\mathcal W_5$ lies in any $\mathcal S_J\cap\mathcal W_5$ with $\lvert J\rvert=3$. True. "Vacuous" reads as a claim that the lemma is empty, which it is not (C10).
- **Three or more outer indices.** Checked by hand from batch 1's cubic coefficients $6,9,12$ with $T=\sum_aX_a$, $Y_a=X_a-T/\lvert A\rvert$ and symmetric blocks ($\mathop{\mathrm{tr}}X_aX_bX_c=\mathop{\mathrm{tr}}X_aX_cX_b$): the cubic is $\big(2+\tfrac3{\lvert A\rvert}+\tfrac1{\lvert A\rvert^2}\big)\mathop{\mathrm{tr}}T^3+\big(3+\tfrac3{\lvert A\rvert}\big)\mathop{\mathrm{tr}}\big(T\sum_aY_a^2\big)+\sum_a\mathop{\mathrm{tr}}Y_a^3$. At $\lvert A\rvert=2$ this is $\tfrac{15}4$, $\tfrac92\cdot\tfrac12=\tfrac94$ and $0$, matching step 2. So the second cubic invariant is right.
- **Omission (C9).** Batch 6 names a second frame-dependent part, the Gram part $\sum_{a\ne b}\beta_{ab}[\ldots+\mathop{\mathrm{tr}}(Y_aY_b)]$, "adds the pairwise alignments". At two outer indices it is one multiple of $\lvert V\rvert^2$. At three the weights $\beta_{ab}$ differ, since item 2 no longer forces equal traces and the $K_{ab}$ are free, so the relative frames enter quadratically as well. L227's sentence names only the cubic invariant.
- **Letter clash (C9).** The sentence writes $\tfrac1m$ for the number of outer indices, in the block whose proof uses $m$ for a trace scalar.

## Item 9, counterexample hunt

- **No unit $W\in\mathcal S_J\cap\mathcal W_5$ with $P(W)>\Theta_5$** exists: steps 1 to 4 hold for every such $W$ with no further hypothesis, the two gaps of item 4 being citations of true facts.
- **No pair $(U,V)$ without a $V'$**: the construction of step 3 works for every symmetric $U$ and traceless symmetric $V$, including repeated eigenvalues of $U$, repeated or zero $\nu_i$ and $V=0$ ($V'=0$).
- No search was run.

## Corrections

All in [second-order.md](../findings/second-order.md), L227's block, except C7.

- **C1 (step 1).** Replace "so $M_a=mI+X_1$, $M_b=mI+X_2$ with $\mathop{\mathrm{tr}}X_i=0$ and $K_{ab}=-3m$," with "so $M_a=mI+X_1$, $M_b=mI+X_2$ with $\mathop{\mathrm{tr}}X_i=0$ and $K_{ab}=-3m$, where the scalar $m=\tfrac13\mathop{\mathrm{tr}}M_a$ is distinct from L226's $m=n-k$, which is $2$ here,".
- **C2 (step 4, membership).** Replace "and with the same $m$ and $K$ they define $W'\in\mathcal S_J\cap\mathcal W_5$ by L226's item 2," with "and with the same $m$ and $K$, and the same $S=X_1'+X_2'-mI=U-mI$, they define a block operator $W'$, which lies in $\mathcal S_J$ because every block entry carries a character trivial on $H_J$ ([block note](../reviews/2026-09-14-I104-block-J.md)) and in $\mathcal W_5$ by L226's items 2 and 3,".
- **C3 (step 4, invariance).** Replace "That tensor is coordinate-diagonal, a unit element of $\mathcal D_5$ at unit norm, and [L57](problem.md) gives $P(W)\le P(W')\le\Theta_5$." with "That tensor is the coordinate-diagonal Weyl operator of a vertex matrix in $\mathcal D_5$, of unit norm, and it has the value of $W'$, since $P$, the norm and $\mathcal W_5$ are invariant under $O(5)$. [L57](problem.md) gives $P(W)\le P(W')\le\Theta_5$." Optional, after "conjugates $S$ as well": "(any orthogonal $Q$ would do, since $\Lambda^2Q$ acts on that frame by $(\det Q)\,Q$)".
- **C4 (inheritance).** Append to the italic provenance line: "L227 inherits the two identities that L57's block names as carrying L57: the vertex-matrix form of the cubic, which L226's item 1 gives at a coordinate-diagonal $W$ as its Gate 1 (b) reads it, and the norm formula for $Z(v)$, which L223's block reports deriving."
- **C6 (Gate 1 (d)).** Replace "*At one outer index* the same formula reads $P=6\mathop{\mathrm{tr}}X_1^3$" with "*At one outer index* L226's item 3, with $\mathop{\mathrm{tr}}M_a=0$ from item 2 and no $K$, reads $P=6\mathop{\mathrm{tr}}X_1^3$, which is step 1's formula at $X_2=0$ and $m=0$,".
- **C7 (script label, [screen_I106.py](../scripts/misc/screen_I106.py)).** The screen 2 header `60 restarts` should read `3 restarts`, matching `for r in range(3)`. Gate 1 (c) itself names no count and stands.
- **C8 (Lean paragraph).** Replace "`alignment_step` is the existence of $V'$ in step 3 and carries the named `sorry`, and `commuting_improvement`, steps 3 and 4 up to the rotation, is proved from it: it needs the spectral theorem for symmetric $3\times3$ matrices and the Rayleigh bounds, which the file does not build." with "`alignment_step` is the existence of $V'$ in step 3, with commuting with $U$ in place of diagonal in $Q$, and carries the named `sorry`, which stands for the spectral theorem for symmetric $3\times3$ matrices and the Rayleigh bounds, neither built in the file. `commuting_improvement`, steps 3 and 4 up to the membership of $W'$ and the rotation, is proved from it."
- **C9 (What it gives, three outer indices).** Replace "the fluctuations $Y_a=X_a-\tfrac1m\sum_bX_b$ carry a second cubic invariant, $\sum_a\mathop{\mathrm{tr}}Y_a^3$ under $\sum_aY_a=0$, which no single alignment controls" with "the fluctuations $Y_a=X_a-\tfrac1{\lvert A\rvert}\sum_bX_b$ carry a second cubic invariant, $\sum_a\mathop{\mathrm{tr}}Y_a^3$ under $\sum_aY_a=0$, which no single alignment controls, and the Gram terms $\mathop{\mathrm{tr}}(Y_aY_b)$ enter with pairwise weights $\beta_{ab}$ that the outer entries $K_{ab}$ leave unequal".
- **C10 (What it gives, optional).** Replace "At $n=5$ it is vacuous for global maximisers, padded $W_{\mathbb{CP}^2}$ having $\sqrt{3/2}>\Theta_5$." with "At $n=5$ it locates no global maximiser, since padded $W_{\mathbb{CP}^2}$ has $\sqrt{3/2}>\Theta_5$."
- **Brief (already handled).** The first version of [BRIEF_L227.md](BRIEF_L227.md) quoted L223's statement as L57's. The coordinator corrected it mid-review, and items 4 and 5 above use L57's own block.
