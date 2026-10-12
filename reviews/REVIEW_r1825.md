# REVIEW r1825: L224EqRot, L224's equality clause on the operators, and the L224 row set to proved

Gate 2 on [lean/HamiltonsCubic/Results/L224EqRot.lean](../lean/HamiltonsCubic/Results/L224EqRot.lean) at commit 9769f1a8 (the file is unchanged at HEAD), against Lemma L224 of [findings/second-order.md](../findings/second-order.md), and on the state change of the L224 row of [lean/INDEX.md](../lean/INDEX.md) to **proved**. Analysis only: every construction was re-derived by hand from the definitions, the one numeric evaluation below is exact rational arithmetic done by hand, and the only runs were the three axiom audits the brief names.

| Claim | Verdict |
|---|---|
| Dminus_smul, nuX_smul, $D^-_{ty}=tD^-_y$ and $\nu_{tx}=t\nu_x$ | CONFIRMED |
| double_angle, $c=\sqrt{(1+p)/2}$, $s=q/(2c)$, and the branch $p=-1$ | CONFIRMED |
| even_fixed, a swap-even Weyl operator of character $1$ is fixed by every $\mathrm{Rot}_{jk}(c,s)$ | CONFIRMED WITH OBSERVATIONS |
| assemble, $D+\nu=R\cdot B$ with $B=E+D^-_{\gamma\bar u}$, $\gamma^2=\alpha^2+\beta^2$ | CONFIRMED |
| L224_eq_even, the forward equality clause at $n\ge4$ and $\theta_0(n)$ | CONFIRMED |
| L224_eq_odd, the forward equality clause at odd $n\ge5$ and the odd $\Theta_n$ | CONFIRMED |
| L224_eq_converse, $R\cdot B$ attains whatever $B$ attains | CONFIRMED |
| The whole Statement on the operators, from L224_bound/L224_bound_odd, L224_eq_even/L224_eq_odd and L224_eq_converse | CONFIRMED WITH OBSERVATIONS |
| lean/INDEX.md, the L224 row's state **proved** and its two owed items marked off the Statement's path | CONFIRMED WITH OBSERVATIONS |
| Axiom audits of L224EqRot, L224Bound and L57Bridge | CONFIRMED, 8/8, 3/3 and 5/5 on the standard three |

**Summary.** The three layers (bound, forward equality, converse) together prove L224's Statement on the operators at every $n\ge4$, both owed items are genuinely off the Statement's path, and the row's **proved** state is justified. The observations concern a stale header name, an unstated rotation-closure fact and the gate citation the row still lacks.

## 1. The record, verbatim

The Statement (line 1613): "**Statement.** *Let $n\ge4$, $j\ne k$ and $\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$. Every unit $W\in\mathcal S_{jk}$ has $P(W)\le\Theta_n$. Equality holds exactly when $W=e^{\varphi\xi}\cdot B$ for a unit diagonal $B$ attaining [L57](problem.md)'s equality and an angle $\varphi$, where $\xi$ generates the rotations of the $(j,k)$-plane.*"

Step 5 (line 1620): "5. **Equality.** If $P(W)=\Theta_n$ then $P(W')=\Theta_n$, $q_E(y)=\lambda\lVert y\rVert^2$ and $q_E(x)=\lambda\lVert x\rVert^2$. At $s=0$, $W=E$ is diagonal. At $s>0$, $\lVert E\rVert<1$ gives $P(E)\le\Theta_n\lVert E\rVert^3<\Theta_n$, so $\lambda>0$. $W'$ is an L57 maximiser $B'$ with swap-even part $E$ and nonzero odd part, so $j$ and $k$ lie in different blocks $A\ni j$, $B\ni k$ of $B'$, which is block-constant with values $\alpha_A,\alpha_B$ inside the blocks and $\gamma$ across. Since $G_z$ is swap-even, $q_E=q_{B'}$, and expanding, $q_{B'}(z)=(\alpha_A+\alpha_B-2\gamma)\big(\sum_{a\in A'}z_a\big)^2$ with $A'=A\setminus\{j\}$. On $\{\sum z=0\}$ this is $c\langle\bar u,z\rangle^2$ with $\bar u$ the indicator of $A'$ centred over the $n-2$ coordinates off $\{j,k\}$, which keeps it in the plane $z_j=z_k=0$ (centring over all $n$ leaves it, [r1820](../reviews/REVIEW_r1820.md) O1), so $\lambda=c\lVert\bar u\rVert^2>0$ has the line of $\bar u$ as its whole eigenspace, and both $y$ and $x$ lie on it: $(y,x)=\sqrt s\,\hat u\,(\cos\psi,\sin\psi)$. By L222's item 5, $\xi\cdot E=0$, $\xi\cdot D^-_y=\nu_{2y}$ and $\xi\cdot\nu_x=D^-_{-2x}$, so $e^{\varphi\xi}$ fixes $E$ and rotates $(y,x)$ by $2\varphi$, and $W=e^{\varphi\xi}\cdot W'$ with $2\varphi=\psi$ up to the sign convention of $\xi$. Conversely $P$ is $O(n)$-invariant. $\square$"

The sentence the brief singles out: "Conversely $P$ is $O(n)$-invariant."

## 2. The declarations

### 2.1 Dminus_smul, nuX_smul

- Dminus j k y is the weight $u\,v^{\mathsf T}+v\,u^{\mathsf T}$ with $u=e_j-e_k$ and $v=$ vy j k y, and vy is linear in $y$ (vy_smul), so the weight scales by $t$ and coordOp_smul' carries it through. CONFIRMED.
- nuX j k x is sandOp $(S,\mathrm{diag}(v))$, linear in $\mathrm{diag}(v)$, hence $\nu_{tx}=t\nu_x$. CONFIRMED.

### 2.2 double_angle

- At $p\ne-1$, $p^2\le1$ gives $p>-1$, so $c=\sqrt{(1+p)/2}>0$ and $s=q/(2c)$ is defined. Then $c^2+s^2=\frac{1+p}2+\frac{q^2}{2(1+p)}=\frac{1+p}2+\frac{1-p}2=1$, $c^2-s^2=\frac{1+p}2-\frac{1-p}2=p$ and $2cs=q$. CONFIRMED.
- At $p=-1$, $q^2=0$ and $(c,s)=(0,1)$ gives $c^2+s^2=1$, $c^2-s^2=-1$, $2cs=0=q$. CONFIRMED. The branch is needed, since the formula for $s$ divides by $c=0$ there.
- The lemma gives $(c,s)$ on the unit circle, not an angle. That is the right shape for the Statement, see 3.3.

### 2.3 even_fixed

- trivial_block_iff writes $E$ as coordOp of an IsWeight $e$. rotR_swap_coordOp turns $\sigma E=E$ into coordOp of the swapped weight equal to coordOp $e$, and coordOp_weight_eq reads off $e_{ka}=e_{ja}$ for $a\notin\{j,k\}$ (the call passes $a\ne k$ as Ne.symm haj together with the swap evaluation, and the result is flipped by .symm). rot_even (r1824) then fixes coordOp $e$. CONFIRMED.
- Only the off-$\{j,k\}$ entries are needed: rot_even's decomposition handles $e_{jk}$ itself (r1824). The module header calls this declaration even_weight, which does not exist (O1).

### 2.4 assemble

- $E=\tfrac12(D+\sigma D)$ is Weyl, of character $1$ (signChar_rotR_swap) and swap-even ($\sigma^2=1$). With hM, $D+\nu=E+D^-_y+\nu_x$ (hsplit). CONFIRMED.
- Zero branch: $y=x=0$ gives $D+\nu=E$ (zero_branch), and $E=\mathrm{Rot}(1,0)\cdot E$ by even_fixed. The same branch covers $\alpha=\beta=0$ inside the line case. CONFIRMED.
- Line branch: $y=\alpha\bar u$, $x=\beta\bar u$ with $\alpha=\langle\bar u,y\rangle/\lVert\bar u\rVert^2$, $\beta$ likewise, $\gamma=\sqrt{\alpha^2+\beta^2}>0$, and double_angle at $(p,q)=(\alpha/\gamma,\beta/\gamma)$. Then $R\cdot(E+D^-_{\gamma\bar u})=E+\gamma(c^2-s^2)D^-_{\bar u}+\gamma\,2cs\,\nu_{\bar u}=E+\alpha D^-_{\bar u}+\beta\nu_{\bar u}=E+D^-_y+\nu_x$ by even_fixed and rot_Dminus. CONFIRMED.
- $B$ is Weyl of character $1$: $\gamma\bar u$ vanishes at $j,k$ (vy_of_zero) and sums to zero, so Dminus_weyl and Dminus_charOne apply. CONFIRMED.
- $\lVert\gamma\bar u\rVert^2=(\alpha^2+\beta^2)\lVert\bar u\rVert^2=\lVert y\rVert^2+\lVert x\rVert^2=s$, so $B$ is the record's $W'=E+D^-_{\sqrt s\,z_*}$ with $z_*=\bar u/\lVert\bar u\rVert$, the sign of $z_*$ fixed by $\gamma>0$. The Lean does not need this identification: it reaches $\lVert B\rVert$ and $P(B)$ through the rotation instead.

### 2.5 L224_eq_even, L224_eq_odd

- Each takes the line data from L224_line_even or L224_line_odd, drops the Even n conjunct in the even case, calls assemble, and gets $\lVert B\rVert=\lVert D+\nu\rVert$ and $P(B)=P(D+\nu)$ from normSq2_rotR and Pcubic2_rotR at the orthogonal Rot (Rot_orth). Substituting into the hypothesis gives $P(B)=\Theta\lVert B\rVert^3$. CONFIRMED.
- L224_eq_even carries no Even n hypothesis. At odd $n$ its hypothesis $P=\theta_0(n)\lVert W\rVert^3$ has only $W=0$ as a solution ([r1813](REVIEW_r1813.md) O4), so the theorem is true and harmless there. The parity is supplied by the reader choosing the right theorem, see 3.4.
- thetaOddSq in L224_eq_odd resolves to L57Critical.thetaOddSq, $\frac{2(n-1)(n-3)}{(n+1)(n-2)}$, the same constant L224_line_odd and charOne_eq_odd use, and the record's $\Theta_n^2=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$ ([problem.md](../findings/problem.md) line 170).

### 2.6 L224_eq_converse

- $P$ and the norm are invariant under any orthogonal frame change of a Weyl operator, so $P(B)=\Theta\lVert B\rVert^3$ transfers to $R\cdot B$ at every $\Theta$. CONFIRMED. It is the record's "Conversely $P$ is $O(n)$-invariant" specialised to the rotations of the plane.

## 3. The central question: does the set prove the whole Statement

Verdict: yes on the operators, with the readings below.

### 3.1 (a) The encoding of $W\in\mathcal S_{jk}$

- $\mathcal D_n$: a Weyl operator of character $1$ is exactly coordOp of an IsWeight $w$ (trivial_block_iff), and IsWeight is symmetric, hollow, zero row sums, which is Families.lean's reading of the record's $\mathcal D_n$.
- $V_{jk}$: pair_iff (PairConv.lean) is the equivalence "Weyl of character $\varepsilon_j\varepsilon_k$ iff $\nu=\nu_x$ with $x_j=x_k=0$, $\sum x=0$", which is the record's step 1 description "Every element of $V_{jk}$ is $\nu_x=\sum_ax_a\,e_{ja}\odot e_{ka}$" on $\{\sum z=0\}$.
- The odd part: odd_iff (OddPart.lean) is the equivalence for $D^-_y$, and hM in the line lemmas is its forward half.
- The theorems quantify over every pair $(D,\nu)$, so they range over the whole direct sum. The encoding is faithful in both directions. CONFIRMED.

### 3.2 (b) Unit versus homogeneous

- Every Lean statement is homogeneous: $P(D+\nu)\le\Theta\lVert D+\nu\rVert^3$ and the equality $P=\Theta\lVert\cdot\rVert^3$. At $\lVert W\rVert=1$ these read $P(W)\le\Theta_n$ and $P(W)=\Theta_n$.
- The forward $B$ has $\lVert B\rVert=\lVert W\rVert=1$, so it is unit as the Statement asks, and nonzero, which is the hypothesis charOne_eq_even and charOne_eq_odd need. The homogeneous form is strictly stronger (it also covers $W=0$ trivially). CONFIRMED.

### 3.3 (c) $\mathrm{Rot}_{jk}(c,s)$ as $e^{\varphi\xi}$

- Rot j k c s has $Re_j=c\,e_j+s\,e_k$, $Re_k=-s\,e_j+c\,e_k$ and fixes the other basis vectors (PairSquare.lean). With $\xi e_j=e_k$, $\xi e_k=-e_j$, the one-parameter group is $e^{\varphi\xi}=\mathrm{Rot}(\cos\varphi,\sin\varphi)$, and every $(c,s)$ with $c^2+s^2=1$ is $(\cos\varphi,\sin\varphi)$ for $\varphi=\operatorname{atan2}(s,c)$.
- So the set $\{\mathrm{Rot}(c,s):c^2+s^2=1\}$ is exactly $\{e^{\varphi\xi}:\varphi\in\mathbb R\}$, and the Lean's quantifier over $(c,s)$ is the Statement's quantifier over $\varphi$. Neither the exponential nor the angle is a Lean theorem (O3). The action's direction ($R$ against $R^{\mathsf T}$) changes $\varphi$ to $-\varphi$ and leaves the set unchanged, which is the record's "up to the sign convention of $\xi$". CONFIRMED WITH OBSERVATIONS.

### 3.4 (d) Even $n$ against odd $n$

- The record's $\Theta_n$ is $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ at even $n$ and $\sqrt{2(n-1)(n-3)/((n-2)(n+1))}$ at odd $n$.
- Even $n\ge4$: L224_bound and L224_eq_even at $\theta_0(n)$, with $n=4$ the first case.
- Odd $n\ge5$: L224_bound_odd and L224_eq_odd at the odd $\Theta_n$. L224_bound at $\theta_0(n)$ is true there and weaker, $\theta_0(n)>\Theta_n$ ([problem.md](../findings/problem.md) line 183), and plays no part.
- Every $n\ge4$ is covered by exactly one pair. CONFIRMED.

### 3.5 (e) The converse

- The Statement's converse reads, for a unit $W\in\mathcal S_{jk}$: if $W=e^{\varphi\xi}\cdot B$ with $B$ a unit diagonal L57 maximiser, then $P(W)=\Theta_n$. L224_eq_converse at $\Theta=\Theta_n$ with $\lVert R\cdot B\rVert=\lVert B\rVert=1$ gives exactly that, and needs no membership $R\cdot B\in\mathcal S_{jk}$, since $W\in\mathcal S_{jk}$ is the Statement's standing hypothesis. CONFIRMED.
- The closure $e^{\varphi\xi}\cdot\mathcal D_n\subseteq\mathcal S_{jk}$ is true and follows from files in hand: split $B=E+D^-_y$ with odd_iff, then even_fixed and rot_Dminus give $R\cdot B=E+D^-_{(c^2-s^2)y}+\nu_{2csy}$, which lies in $\mathcal S_{jk}$ by pair_iff and odd_iff. It is not stated as a theorem. It is needed only for the stronger reading "the equality set of $P$ on the unit sphere of $\mathcal S_{jk}$ is the set of all $e^{\varphi\xi}\cdot B$", which says every such rotation lands in $\mathcal S_{jk}$ (O2).
- L224_eq_converse is proved for any Weyl $B$. It is more general than the Statement asks, since it does not require $B$ diagonal.

### 3.6 (f) The state proved and the two owed items

- "B attaining L57's equality" reads as $P(B)=\Theta_n\lVert B\rVert^3$ at a diagonal $B$, which the forward theorems give directly. L57's equality clause in block-constant form is a description of such $B$, not a condition in the Statement, so it is off the path. The forcing half of that description, sphere-product form, is charOne_eq_even and charOne_eq_odd, and the record's step 5 needed it only to reach the line, which L224_line_even and L224_line_odd already consume.
- The link to the polynomial core pair_value_le concerns the older L224Statement.lean route. The operator bound takes L57 directly through L57_diagonal and L57_diagonal_odd, so nothing in the three layers passes through pair_value_le.
- The row therefore does not overclaim the mathematics. What it lacks is a Gate 2 citation for L224EqRot, which this review supplies, and the findings entry still reads "Gate 2 on that commit pending" (O4).

## 4. Hand evaluation (exact, by hand, labelled as such)

Setting: $n=4$, $j=0$, $k=1$, blocks $\{0,2\}$ and $\{1,3\}$, $B$ the $S^2\times S^2$ weight.

- $S^2\times S^2$ has $K_{02}=K_{13}=1$ and all other $K_{il}=0$, every row sum $1$. Subtracting the constant $\tfrac13$ off the diagonal makes the row sums zero, and scaling by $3$ gives the weight $w_{02}=w_{13}=2$, $w_{01}=w_{03}=w_{12}=w_{23}=-1$. It is IsWeight: row $0$ reads $-1+2-1=0$, row $2$ reads $2-1-1=0$.
- Swap split at $\sigma=(0\,1)$, $a\in\{2,3\}$: $y_a=\tfrac12(w_{0a}-w_{1a})$ gives $y_2=\tfrac32$, $y_3=-\tfrac32$, $\sum y=0$. The even part $E$ has $E_{02}=E_{03}=E_{12}=E_{13}=\tfrac12$, $E_{01}=E_{23}=-1$, with row sums $-1+\tfrac12+\tfrac12=0$ and $\tfrac12+\tfrac12-1=0$.
- Rotation at $(c,s)=(\tfrac35,\tfrac45)$: $c^2-s^2=-\tfrac7{25}$, $2cs=\tfrac{24}{25}$. By even_fixed and rot_Dminus, $R\cdot B=E+D^-_{y'}+\nu_{x'}$ with $y'=-\tfrac7{25}y=(0,0,-\tfrac{21}{50},\tfrac{21}{50})$ and $x'=\tfrac{24}{25}y=(0,0,\tfrac{36}{25},-\tfrac{36}{25})$.
- So $D=E+D^-_{y'}$ is diagonal with $\sum y'=0$, and $\nu=\nu_{x'}$ has $x'\ne0$, hence $\lVert\nu\rVert^2=2\lVert x'\rVert^2=2\cdot2\cdot\tfrac{1296}{625}=\tfrac{5184}{625}\ne0$.
- Norms, with $\lVert a\odot\cdot\rVert^2=\tfrac12\sum_{i\ne l}a_{il}^2$ (innerOp2_coordOp): $\lVert B\rVert^2=\tfrac12(2\cdot(4+4)+2\cdot4\cdot1)=12$. Through L224_norm, $\lVert E\rVert^2=\tfrac12\cdot2\,(1+1+4\cdot\tfrac14)=3$ and $2\lVert y\rVert^2=2\cdot\tfrac92=9$, total $12$, which agrees. For $R\cdot B$: $2(\lVert y'\rVert^2+\lVert x'\rVert^2)=2\cdot\tfrac{49+576}{625}\cdot\tfrac92=9$, so $\lVert R\cdot B\rVert^2=3+9=12=\lVert B\rVert^2$.
- Round trip through assemble: $\bar u=y$, $\alpha=-\tfrac7{25}$, $\beta=\tfrac{24}{25}$, $\gamma=1$, and double_angle at $p=-\tfrac7{25}$, $q=\tfrac{24}{25}$ returns $c=\sqrt{(1-\tfrac7{25})/2}=\tfrac35$ and $s=\tfrac{24}{25}\big/\tfrac65=\tfrac45$, with $B=E+D^-_{\bar u}$ the original weight. The construction recovers the rotation it was fed.

This is a screen of the construction at one point and establishes nothing by itself. At $n=4$ the plane $\{z_j=z_k=0,\ \sum z=0\}$ is one line, so the line step is automatic here ([r1820](REVIEW_r1820.md) O2).

## 5. Axiom audits

- L224EqRot.lean: "8/8 clean -- resting on the standard three alone".
- L224Bound.lean: "3/3 clean -- resting on the standard three alone".
- L57Bridge.lean: "5/5 clean -- resting on the standard three alone".

## 6. Observations

- **O1.** The module header of L224EqRot.lean lists even_weight ("a swap-even Weyl operator of character $1$ has a swap-even weight, so the rotation fixes it"), and no declaration of that name exists. The declaration is even_fixed, as the commit body and lean/INDEX.md say. Fix: rename the header bullet to even_fixed.
- **O2.** The closure $e^{\varphi\xi}\cdot\mathcal D_n\subseteq\mathcal S_{jk}$ is unstated. The Statement as written does not need it, but a consumer citing "the equality set is the $(j,k)$-rotations of L57's maximisers" as a subset of $\mathcal S_{jk}$ does. A three-line corollary from odd_iff, even_fixed, rot_Dminus and pair_iff would close it.
- **O3.** The identification $\{\mathrm{Rot}(c,s):c^2+s^2=1\}=\{e^{\varphi\xi}\}$ is by reading, not a Lean theorem. It is the standard parametrisation of $SO(2)$ and the row's wording "$\mathrm{Rot}_{jk}(c,s)$" is accurate, so this is a note for any consumer that needs an explicit angle.
- **O4.** The L224 row reports the equality clause **PROVED** with no Gate 2 citation, and findings/second-order.md reads "Gate 2 on that commit pending". The row and the findings entry should cite this review.
- **O5.** L224_eq_even applies at every $n\ge4$ without Even n, and at odd $n$ its hypothesis forces $W=0$. A consumer reading it as "the Statement at odd $n$" would get a vacuous result. The row says "at $P(D+\nu)=\Theta_n\lVert D+\nu\rVert^3$" and names both theorems, so the pairing is correct. A docstring line saying the even theorem is the Statement at even $n$ only would prevent the misreading.

## 7. What would falsify each headline

- The forward clause would fail if assemble's final identity were wrong, for example if rot_Dminus carried $-2cs$ where it carries $+2cs$: then $R\cdot B$ would have $\nu_{-\beta\bar u}$. The kernel check closes that, and the hand evaluation reproduces the sign.
- The encoding would be unfaithful if some $W\in\mathcal S_{jk}$ were not $D+\nu$ with the stated characters, or conversely. pair_iff, odd_iff and trivial_block_iff are equivalences, so a counterexample would have to break one of them.
- The row's **proved** would overclaim if the Statement's "attaining L57's equality" meant the block-constant description rather than $P(B)=\Theta_n$. The Statement's text is "a unit diagonal $B$ attaining [L57](problem.md)'s equality", which is the value.
- The audits would falsify the state by a non-standard axiom or sorryAx in any of the three files. None appeared.
