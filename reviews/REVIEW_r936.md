# Reviewer 936: Lemma L218, the off-diagonal coupling at a diagonal point

Log: [agent_logs/review-r936.log](../agent_logs/review-r936.log)

| # | Claim | Verdict | Reason |
|---|---|---|---|
| 1 | Reduction to blocks | CONFIRMED | the summands are distinct characters of the full sign group, hence orthogonal, and preservation by $L_D$ kills every cross term |
| 2 | Four-set bound $\tfrac{\sqrt3}2$ | CONFIRMED | the identity for $E$ is exact, the six entries are the six pairs of the $4$-set, and the trace of $G^2$ reproduces the spectrum |
| 3 | Pair bound $\tfrac{\sqrt5}2$ | CONFIRMED | each estimate and the disjointness hold as written, $\lVert S\rVert_F^2$ counts ordered entries, and bounding over all of $\mathbb R^{n-2}$ bounds the $\mathbf 1^\perp$ restriction |
| 4 | Normalisation $\sum_{a<b}K_{ab}^2=1$ | CONFIRMED | it is Given 4's $\lVert K\rVert_F^2=2$ read over unordered pairs, and both block formulas return the exact orbit eigenvalue $\theta_0(6)/2$ at $S^3\times S^3$ at this scale |
| 5 | Lower bound at padded $S^2\times S^2$ | CONFIRMED | unit, Ricci-flat and $E=3$ exactly, though the printed entries are those of $-W_{S^2\times S^2}$, which attains the same value |
| 6 | Banach's theorem as used | PLAUSIBLE | $\langle L_DN,N\rangle=T(D,N,N)$ and the Banach step are right, but "would refute Conjecture A" holds only at $n\ge12$, since padded $\mathbb{CP}^2$ already puts $\sup P$ above $\Theta_n$ at $n\le11$ |
| 7 | $\theta_0(n)^2>\tfrac54$ from $n=8$ | CONFIRMED | $3n^2-24n+16$ has roots $4\pm\tfrac43\sqrt6$, negative at $n=7$, and the odd case $\Theta_n^2>\tfrac54$ also holds from $n=9$ though unstated |
| 8 | "Not a route input" | CONFIRMED | F67's ceiling needs only $\Lambda_n\ge\Theta_n/2$, which is proved, so no upper constant moves it |
| 9 | Range $n\ge5$ | CONFIRMED | nothing in the proof uses $n\ge5$, both bounds hold verbatim at $n=4$, and the blocks exist at $n=5,6,7$ |
| 10 | Sharpness left open | REFUTED | one Cauchy--Schwarz on the pair block's form as a linear functional of $K$ gives $\tfrac{\sqrt3}2$, so $\Lambda_n=\tfrac{\sqrt3}2$ exactly and $\tfrac{\sqrt5}2$ is never attained |

**Summary: the lemma's inequalities are true, but its upper bound is loose, and the pair block obeys $\tfrac{\sqrt3}2$ by a two-line argument, so the cycle should restate L218 as $\Lambda_n=\tfrac{\sqrt3}2$ at every $n\ge4$, extend the comparison to both parities at every $n\ge5$, and scope the refutation reading to $n\ge12$.**

## 1. The reduction to blocks

Lemma L120's decomposition sorts $\mathrm{Sym}^2(\Lambda^2)$ by the character of the full sign group $\Gamma$: trivial on the pair-diagonal entries, $\varepsilon_j\varepsilon_k$ on $e_{ij}\odot e_{ik}$, and $\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_l$ on the three pairings of a $4$-subset. Under the full group these characters are pairwise distinct at every $n$ (the fusion recorded in L120 happens only for $\Gamma\cap SO(n)$), and $\Gamma$ acts orthogonally, so the isotypic summands are mutually orthogonal. Hence $\mathcal W_n=\mathcal D_n\oplus\bigoplus V_{ijkl}\oplus\bigoplus V_{jk}$ is an orthogonal sum and $\mathcal D_n^\perp\cap\mathcal W_n=\bigoplus V_{ijkl}\oplus\bigoplus V_{jk}$ exactly.

$D\in\mathcal D_n$ is $\Gamma$-fixed and $\circ$ is $O(n)$-equivariant, so $L_D$ commutes with $\Gamma$ and preserves each isotypic summand. No criticality and no unit norm enter. For $N=\sum_bN_b$ with $N_b$ in distinct summands, $L_DN_b$ lies in the summand of $N_b$, which is orthogonal to $N_c$ for $c\ne b$, so $\langle L_DN,N\rangle=\sum_b\langle L_DN_b,N_b\rangle\le\max_b\lambda_{\max}(L_D\vert_{V_b})\sum_b\lVert N_b\rVert^2$. Self-adjointness is not needed for the cross terms, only preservation and orthogonality. The step is what `coupling_le_of_blocks` types.

**What the kernel does not see**: `coupling_le_sqrt5_half` takes the per-block bound `hblock` as a hypothesis, so it certifies the convex combination and nothing about Weyl tensors. That is as the brief says and is not a defect.

## 2. The four-set bound

The identity: $(A+B+C)^2=\sum A^2+2\sum AB$, so $\tfrac32\sum A^2-\tfrac12(A+B+C)^2=\sum A^2-\sum AB=E$. Exact. Then $E\le\tfrac32\sum A^2$ and $A^2=(K_{ij}+K_{kl})^2\le2(K_{ij}^2+K_{kl}^2)$ and likewise for $B,C$, giving $E\le3\sum_6K^2$. The six entries $\{ij\},\{kl\},\{ik\},\{jl\},\{il\},\{jk\}$ are the six distinct pairs of $\{i,j,k,l\}$, so $\sum_6K^2\le\sum_{a<b}K_{ab}^2=1$ and $E\le3$. `fourset_disc_le` checks exactly this.

The spectrum against Given 2: $G$ is symmetric with $\operatorname{tr}G=A+B+C$ and $\operatorname{tr}G^2=3(A^2+B^2+C^2)$, since each row is a permutation of $(A,B,C)$. The eigenvalue $A+B+C$ on $\mathbf 1$ is removed by Bianchi, so the two remaining eigenvalues sum to $0$ and satisfy $(A+B+C)^2+2\mu^2=3\sum A^2$, whence $\mu^2=E$ and the block spectrum is $\pm\tfrac12\sqrt E$, as used. The basis question: the signed coordinates differ from the raw ones by the orthogonal $\operatorname{diag}(1,-1,1)$, and the three pairings $e_{ij}\odot e_{kl}$, $e_{ik}\odot e_{jl}$, $e_{il}\odot e_{jk}$ share a common norm, so the eigenvalues are basis-free. The scale is confirmed independently in item 4.

## 3. The pair bound

Given 3's matrix in the basis $f_i$ of common norm $\sqrt2$: a uniform scaling of an orthogonal basis leaves the Rayleigh quotient $x^{\mathsf T}Bx/\lVert x\rVert^2$ unchanged, so no factor is owed, as L122's own note says. The block as a subspace of $\mathcal W_n$ is the Ricci cut $\mathbf 1^\perp$. With $D$ Ricci-flat, row $i$ gives $K_{ij}+K_{ik}+\sum_lS_{il}=0$, so $B\mathbf 1=-\kappa\mathbf 1$ and $\mathbf 1^\perp$ is invariant. The proof bounds the quadratic form over all of $\mathbb R^{n-2}$, which contains $\mathbf 1^\perp$, so it is a valid upper bound that forgoes the cut.

The three estimates: $\sum_id_ix_i^2\le\max_i\lvert d_i\rvert\lVert x\rVert^2$ holds. $-\kappa\le\lvert\kappa\rvert$ holds. $\lvert\sum_{i,l}S_{il}x_ix_l\rvert\le(\sum_{i,l}S_{il}^2)^{1/2}(\sum_{i,l}x_i^2x_l^2)^{1/2}=\lVert S\rVert_F\lVert x\rVert^2$ holds, and it is `quad_le_frob`. $\lVert S\rVert_F^2$ is summed over ordered pairs $(i,l)$ with $S$ hollow and symmetric, so it is $2Y$ with $Y$ the unordered mass, as written. Choose $i^\ast$ maximising $\lvert d_i\rvert$ and $X=K_{ji^\ast}^2+K_{ki^\ast}^2$: then $d_i^2\le d_{i^\ast}^2\le2X$ for every $i$, which is the universally quantified `hd`. The entries $\{j,i^\ast\},\{k,i^\ast\}$, $\{j,k\}$ and the pairs inside the complement of $\{j,k\}$ are disjoint sets, so $X+Y+Z\le1$. The weighted Cauchy--Schwarz $(\sqrt2\sqrt X+\sqrt Z+\sqrt2\sqrt Y)^2\le5(X+Y+Z)$ is `three_term_cs` with $p=\sqrt{2X}$, $q=\sqrt Z$, $r=\sqrt{2Y}$. The chain is correct, and loose, which item 10 takes up.

## 4. The normalisation

A unit coordinate-diagonal $D$ is the operator on $\Lambda^2$ with eigenvalue $K_{ab}$ on $e_a\wedge e_b$, so $\lVert D\rVert^2=\operatorname{tr}(D^2)=\sum_{a<b}K_{ab}^2=1$, which is Given 4's $\lVert K\rVert_F^2=2$ over ordered pairs. The two agree.

Independent check that L121 and L122 are stated at this scale, using only the record's $\theta_0(6)=\sqrt{10}/3$ and L24's structural fact that orbit tangents are exact $\tfrac\theta2$-eigenvectors. At $S^3\times S^3$ put within-factor entries $x$ and cross entries $z$. Ricci-flatness gives $2x+3z=0$ and the unit norm gives $6x^2+9z^2=1$, so $z^2=\tfrac2{45}$. For $j,k$ in different factors, $d_i=x+z$ for all four $i$, $\kappa=z$, and the orbit vector $(K_{ki}-K_{ji})_i\propto(-1,-1,1,1)$ is an eigenvector of $S$ with eigenvalue $x-2z$. The bracket eigenvalue is $(x+z)-z+(x-2z)=2(x-z)$ and the block eigenvalue is $x-z=-\tfrac52z$, of modulus $\tfrac52\sqrt{2/45}=\tfrac{\sqrt{10}}6=\tfrac{\theta_0(6)}2$ exactly. On the four-set block for a $(2,2)$-split subset, $A=2x$, $B=C=2z$, so $E=4(x-z)^2=25z^2=\tfrac{10}9$ and $\tfrac12\sqrt E=\tfrac{\sqrt{10}}6$ again, which is L121's nine extra $\tfrac12$-directions in $L_e$ units. Both formulas therefore carry the unit scale. Had the norm been $\lVert K\rVert_F^2=1$ both would miss by $\sqrt2$. The sign of the check also fixes the record's orientation: $x-z>0$ forces $z<0$, cross entries negative, which item 5 uses.

## 5. The lower bound at padded $S^2\times S^2$

With $K_{12}=K_{34}=-2/\sqrt{12}$ and cross entries $1/\sqrt{12}$, padded by zeros: every row sum is $(-2+1+1)/\sqrt{12}=0$ and the padded rows vanish, so $K$ is hollow, symmetric and Ricci-flat, hence in $\mathcal D_n$ at every $n\ge4$. The norm is $2\cdot\tfrac4{12}+4\cdot\tfrac1{12}=1$. On $\{1,2,3,4\}$, $A=-4/\sqrt{12}$ and $B=C=2/\sqrt{12}$, so $E=(A-B)^2=36/12=3$, and $V_{1234}\subset\mathcal D_n^\perp\cap\mathcal W_n$ carries the eigenvalue $+\tfrac{\sqrt3}2$. The Lean example checks $36=3\cdot12$.

**A sign note, not a defect.** In the product metric the Weyl tensor of $S^2\times S^2$ has within-factor sectional entries $+\tfrac23c$ and cross entries $-\tfrac13c$ (Schouten $A=\tfrac16g$, subtracted twice from $K=1$ and $K=0$), and item 4's orbit check confirms negative cross entries in the record's own orientation. So the printed entries are those of $-W_{S^2\times S^2}$. The value is unaffected because $E$ is quadratic in $K$ and the block spectrum is symmetric, and $\Lambda_n$ ranges over all unit $D$ including $-D$. The correction is to say "at $\pm W$" or flip the signs.

## 6. Banach's theorem as used

$L_MM=Q(M)=M\circ M$ at unit norm and L217's proof records $T(u,V,V)=\langle L_uV,V\rangle$ with $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ totally symmetric and $T(x,x,x)=P(x)$. So $\langle L_DN,N\rangle=T(D,N,N)$. Banach's theorem for a symmetric continuous trilinear form on a real Hilbert space gives $\sup\lvert T\rvert=\sup\lvert P\rvert$ over unit arguments, and since both are odd the absolute values drop, giving the displayed identity. Consequently $\Lambda_n\le M(n)$ always, and $\Lambda_n>c$ forces $M(n)>c$.

**The refutation reading is mis-scoped.** "$\Lambda_n>\Theta_n$ would refute Conjecture A" needs $M(n)>\Theta_n$ to contradict the conjecture. But [problem.md](../findings/problem.md) (line 213) records that padded $W_{\mathbb{CP}^2}$ has $P=\sqrt{3/2}$ at every $n\ge4$ and $\Theta_n<\sqrt{3/2}$ at every $n\le11$ ($\Theta_{11}^2=\tfrac{40}{27}$, $\theta_0(10)^2=\tfrac{36}{25}$, $\theta_0(8)^2=\tfrac{21}{16}$), so $M(n)>\Theta_n$ is already known there and is no refutation. At $n=8$ and $n=10$, which the statement names, the falsifier firing would have refuted nothing. The correction: the implication holds at $n\ge12$, and below that the falsifier would have to exceed $\sqrt{3/2}$. The conclusion "does not fire" is unaffected, and with item 10 it is moot: $\Lambda_n=\tfrac{\sqrt3}2<\sqrt{3/2}\le M(n)$ at every $n\ge4$.

A second, softer point: $\Lambda_n$ is a supremum over the slice of triples $(D,N,N)$ with $D$ diagonal and $N\in\mathcal D_n^\perp$, so its not firing says nothing about Conjecture A beyond that slice. The lemma's "through it" already says this.

## 7. $\theta_0(n)^2>\tfrac54$ from $n=8$

$2(n-1)(n-2)/n^2>\tfrac54$ is $8(n^2-3n+2)>5n^2$, which is $3n^2-24n+16>0$, with roots $4\pm\tfrac43\sqrt6$, that is $0.734$ and $7.266$. At $n=7$ the value is $147-168+16=-5<0$, at $n=8$ it is $16>0$. Correct, and `theta_sq_gt_five_quarters` checks it for real $n\ge8$.

**Odd $n$ is omitted and holds.** $\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}>\tfrac54$ is $8(n^2-4n+3)>5(n^2-n-2)$, which is $3n^2-27n+34>0$, with larger root $(27+\sqrt{321})/6\approx7.49$. So the falsifier does not fire at odd $n\ge9$ either. The statement's "even $n\ge8$" is an understatement, and "well below $\theta_0(n)$" overstates the margin at $n=8$, where $\theta_0(8)=\sqrt{21}/4\approx1.146$ against $\tfrac{\sqrt5}2\approx1.118$. With item 10 both points are superseded, see there.

## 8. "Not a route input"

Post F67's argument is $f(t)=\sqrt t\,\Theta_n+\tfrac{1-t}{\sqrt t}\Lambda\ge\tfrac{\Theta_n}2(u+u^{-1})\ge\Theta_n$ for every $\Lambda\ge\Theta_n/2$, and $\Lambda_n\ge\Theta_n/2$ is proved from the orbit direction at the balanced product. Any valid upper constant for $\Lambda_n$ is at least $\Lambda_n\ge\Theta_n/2$, so no upper bound can lower the ceiling. The lemma's "$\tfrac{\sqrt5}2\ge\Theta_n/2$" is true since $\Theta_n^2<2$, and it remains true for $\tfrac{\sqrt3}2$. Consistent with F67's own remark that its maximiser has $\Sigma=3$, which is item 5's $E=3$. Confirmed.

## 9. The range $n\ge5$

No step uses $n\ge5$. The four-set blocks need four indices and exist from $n=4$. The pair blocks have dimension $n-3$, which is $1$ at $n=4$, and the bracket bound applies to any size. The lower bound needs four indices. So $\tfrac{\sqrt3}2\le\Lambda_n\le\tfrac{\sqrt5}2$ holds verbatim at $n=4$, and at $n=5,6,7$ as stated. At $n=4$ the sharpened value of item 10 gives $\Lambda_4=\tfrac{\sqrt3}2=\theta_0(4)=\Theta_4$, since $\theta_0(4)^2=\tfrac{12}{16}$, so the comparison there is equality rather than strict. The hypothesis $n\ge5$ is harmless and unexplained. The statement is silent on the falsifier at $n=5,6,7$, where $\tfrac{\sqrt5}2>\Theta_n$ ($\theta_0(6)^2=\tfrac{10}9<\tfrac54$), which item 10 closes.

## 10. Sharpness: the pair block is at most $\tfrac{\sqrt3}2$

**The failing step is not an error but a loss**: splitting the bracket into three pieces and bounding each by a separate supremum discards that they cannot be large at once (the diagonal term wants $x$ concentrated on one index, where $x^{\mathsf T}Sx=S_{ii}=0$). The overlooked argument treats the form as linear in $K$.

For unit $x\in\mathbb R^{n-2}$,
$$x^{\mathsf T}Bx=\sum_iK_{ji}x_i^2+\sum_iK_{ki}x_i^2-K_{jk}+\sum_{i<l}2K_{il}x_ix_l .$$
This is a linear functional of the unordered entries of $K$, with coefficients $x_i^2$ on $\{j,i\}$, $x_i^2$ on $\{k,i\}$, $-1$ on $\{j,k\}$ and $2x_ix_l$ on $\{i,l\}$, each entry appearing once. The squared coefficient norm is
$$2\sum_ix_i^4+1+4\sum_{i<l}x_i^2x_l^2=2\sum_ix_i^4+1+2\Big(\big(\textstyle\sum_ix_i^2\big)^2-\sum_ix_i^4\Big)=3,$$
identically in $x$. Cauchy--Schwarz against $\sum_{a<b}K_{ab}^2=1$ gives $x^{\mathsf T}Bx\le\sqrt3$, so the pair block's top eigenvalue is at most $\tfrac{\sqrt3}2$, with no Ricci condition used and no restriction to $\mathbf 1^\perp$.

The four-set block has the same structure, which is a consistency check on the argument. In signed coordinates on $\mathbf 1^\perp\subset\mathbb R^3$ with $\lVert y\rVert=1$, the coefficient of both entries of $A$ is $y_1^2+2y_2y_3=3y_1^2-1$, and likewise for $B,C$, so the squared coefficient norm is $2\sum_m(3y_m^2-1)^2=2(9\sum y_m^4-3)=3$, using $\sum y_m^4=\tfrac12$ on the unit circle of $\mathbf 1^\perp$. Both blocks have coefficient norm exactly $\sqrt3$.

**Corrected statement.** With item 1 and item 5,
$$\Lambda_n=\tfrac{\sqrt3}2\quad\text{at every }n\ge4,$$
attained on the four-set block at $\pm$ padded $S^2\times S^2$, and $\tfrac{\sqrt5}2$ is never attained. The comparison becomes $\tfrac{\sqrt3}2<\Theta_n$ at every $n\ge5$ at both parities: at even $n$ it is $5n^2-24n+16>0$, with roots $4$ and $\tfrac45$, and at odd $n$ it is $5n^2-29n+30>0$, with larger root $(29+\sqrt{241})/10\approx4.45$. At $n=4$ it is equality. The sentence "whether $\tfrac{\sqrt5}2$ is attained, or the pair block's true supremum lies nearer $\tfrac{\sqrt3}2$, is not settled here" should be replaced by this. The Lean side needs one lemma, a Cauchy--Schwarz on a finite sum with the coefficient identity, and `three_term_cs` and `pair_block_rayleigh` become unnecessary.

Does any claim say more than its proof shows? No inequality does. The overreaches are the refutation scope of item 6 and the parity and margin wording of item 7.

## Overall verdict

**CONFIRMED with corrections.** Every stated inequality is true and every step of the written chain follows from the givens at the stated scale. The corrections, in order of weight:

- **Sharpen the upper bound** (item 10): the pair block obeys $\tfrac{\sqrt3}2$ by Cauchy--Schwarz on its form as a linear functional of $K$, so $\Lambda_n=\tfrac{\sqrt3}2$ exactly at every $n\ge4$ and the open question in "What it does and does not give" is closed.
- **Widen the comparison** (items 7, 9, 10): $\tfrac{\sqrt3}2<\Theta_n$ at every $n\ge5$ at both parities, replacing "even $n\ge8$".
- **Scope the refutation reading** (item 6): $\Lambda_n>\Theta_n$ refutes Conjecture A only at $n\ge12$, since padded $\mathbb{CP}^2$ gives $M(n)\ge\sqrt{3/2}>\Theta_n$ below that.
- **Fix the sign of the witness** (item 5): the printed entries are those of $-W_{S^2\times S^2}$, with the value unchanged.

No other files were staged or modified by this reviewer. The working tree was clean apart from this report and the log when the review began.
