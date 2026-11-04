# Review r952, Lemma L228 (the |J| = 3 step of R27 on two strata at every n)

Brief: [BRIEF_L228.md](BRIEF_L228.md). Log: [agent_logs/review-r952.log](../agent_logs/review-r952.log). Claim: [findings/second-order.md](../findings/second-order.md) lines 1001-1027, read against the brief's quotation and found identical.

**Verdict: the lemma stands.** Every algebraic step of items 1 and 2 was rederived by hand and agrees coefficient by coefficient. The alignment arguments of items 3 and 4 are sound. There are seven corrections: one citation gap in the membership of the comparison tensor, one overstated Gate 1 clause, and five points of wording and scope.

| Item | Verdict | Reason |
|---|---|---|
| 1. Item 1 | CONFIRMED | Both Cayley-Hamilton expansions, the four substituted terms, the zero coefficient of $\lvert X_a\rvert^2$, $\beta_{ab}$ over ordered pairs and the norm all rederive, and $S=X-\tfrac12\mu I$ follows from $\mathop{\mathrm{tr}}N=3\mu$ |
| 2. Item 2 | CONFIRMED | The expansion, the constant $9$, the completed square, the cancellation of $\mathop{\mathrm{tr}}(Y_a^2R_a)$ and $\ell'_a=\ell_a-\tfrac92R_a^2$ rederive, and $c_a,n_a$ are built from $R_a$, $T_a$, the $X_c$ with $c\ne a$ and the scalars only |
| 3. Item 3 | CONFIRMED, gap C1 | Diagonality of $\ell'_a$, the Birkhoff step and its direction, $Y'$ and its invariants, norm, value, rotation and L57 all hold. The sentence placing $W'$ in $\mathcal S_J$ cites only L226's item 2, which does not give membership in $\mathcal S_J$ |
| 4. Item 4 | CONFIRMED, corrections C1, C3, C4, C7 | The frame-dependent part $\mathop{\mathrm{tr}}(V^2Z)+\mathop{\mathrm{tr}}(VL)$, both terms linear in one doubly stochastic matrix, and the fixed norm all rederive. The permutation is never defined and $\nu\circ\sigma^{-1}$ is inverted against item 3's convention, and "item 3's last three sentences" cite item 2 for a norm and value that item 4 proves itself |
| 5. Scope | CONFIRMED | At $m=2$ the one other block is diagonal in its own eigenframe, at $m=1$ the hypothesis is empty and $\ell'_1=0$, $n\ge4$ gives $m\ge1$, and items 3 and 4 use nothing about $(t,K)$ beyond membership in $\mathcal W_n$ |
| 6. Gate 1 | (a) REFUTED in its norm clause (C2), (b) (c) CONFIRMED, (d) CONFIRMED with C6 | [screen_I106.py](../scripts/misc/screen_I106.py) compares item 1's norm with L226's block norm, formula to formula, and never with the trusted operator. The value and every other clause reproduce |
| 7. Lean | CONFIRMED, correction C5 | The four theorems state what the paragraph says, with no weakening hypothesis, the build succeeds, and the axioms are propext, Classical.choice and Quot.sound. The "outside the file" list understates what is outside, since `cubicX` is item 1's cubic part by definition |
| 8. What it gives | CONFIRMED | Both strata are described as proved, L227 is item 3 at $m=2$ ($n=5$) with attainment in $\mathcal D_5$, and a general $W$ at $m\ge3$ lies in neither stratum |
| 9. Counterexample hunt | CONFIRMED (none found) | No unit $W$ in either stratum exceeds $\Theta_n$ and item 2's identity holds, by the analysis of items 2 to 4. Screens below are screens only |

## Item 1

- $\mathop{\mathrm{tr}}N=\sum_a\mathop{\mathrm{tr}}M_a=3\mu$, so $S=\mu I+X-\tfrac32\mu I=X-\tfrac12\mu I$, which is $c=\tfrac12\mu$.
- For traceless $Z$: $e_1=0$, $e_2=-\tfrac12\lvert Z\rvert^2$, $e_3=\tfrac13\mathop{\mathrm{tr}}Z^3$. Then $\det(Z-cI)=e_3-ce_2-c^3$ gives the first identity. With $A=tI+Z$, $\mathop{\mathrm{adj}}A=A^2-(\mathop{\mathrm{tr}}A)A+e_2(A)I$ and $e_2(A)=3t^2-\tfrac12\lvert Z\rvert^2$ give the second.
- $\mathop{\mathrm{tr}}S^3=\mathop{\mathrm{tr}}X^3-3c\lvert X\rvert^2-3c^3$ and $3\det S=\mathop{\mathrm{tr}}X^3+\tfrac32c\lvert X\rvert^2-3c^3$ sum to $2\mathop{\mathrm{tr}}X^3-\tfrac34\mu\lvert X\rvert^2-\tfrac34\mu^3$.
- $3\mathop{\mathrm{tr}}\big((X-cI)(X_a^2-t_aX_a+(t_a^2-\tfrac12\lvert X_a\rvert^2)I)\big)=3\mathop{\mathrm{tr}}(XX_a^2)-3t_a\mathop{\mathrm{tr}}(XX_a)+\tfrac32c\lvert X_a\rvert^2-9ct_a^2$, the stated term at $c=\tfrac12\mu$. The terms $\mathop{\mathrm{tr}}X$ and $\mathop{\mathrm{tr}}X_a$ vanish.
- The $\lvert X_a\rvert^2$ coefficient is $-\tfrac34\mu+3t_a-3t_a+\tfrac34\mu=0$. On the unordered pair $\{a,b\}$ the coefficients are $-\tfrac32\mu$, $-3(t_a+t_b)$ and $3K_{ab}$, half of which per ordered pair is $\beta_{ab}$.
- No term linear in the $X_a$ survives, so $P_0=-\tfrac34\mu^3+3\sum t_a^3-\tfrac92\mu\sum t_a^2+\sum_{a<b}(K_{ab}^3+9K_{ab}t_at_b)+3\sum K_{ab}K_{ac}K_{bc}$ and $N_0=\tfrac34\mu^2+3\sum t_a^2+\sum K_{ab}^2$ depend on the scalars only.

## Item 2

- The three cubic contributions and the Gram contribution are as written, each by cyclicity alone, with symmetry unused. The total is $6\mathop{\mathrm{tr}}X_a^3+9\mathop{\mathrm{tr}}(X_a^2R_a)+\mathop{\mathrm{tr}}(X_a\ell_a)$.
- $6\mathop{\mathrm{tr}}(Y-\tfrac12R)^3=6\mathop{\mathrm{tr}}Y^3-9\mathop{\mathrm{tr}}(Y^2R)+\tfrac92\mathop{\mathrm{tr}}(YR^2)-\tfrac34\mathop{\mathrm{tr}}R^3$ and $9\mathop{\mathrm{tr}}((Y-\tfrac12R)^2R)=9\mathop{\mathrm{tr}}(Y^2R)-9\mathop{\mathrm{tr}}(YR^2)+\tfrac94\mathop{\mathrm{tr}}R^3$ sum to the stated expression.
- $c_a=\tfrac32\mathop{\mathrm{tr}}R_a^3-\tfrac12\mathop{\mathrm{tr}}(R_a\ell_a)+(\text{item 1's terms free of }X_a)$ and $n_a=N_0+\tfrac12\lvert R_a\rvert^2+\sum_{c\ne a}\lvert X_c\rvert^2$. The scalars are tied to $K$ by $3t_a+\sum_bK_{ab}=0$ and not to $X_a$, so both are free of $X_a$.

## Item 3

- $\mathop{\mathrm{tr}}(Y_a\ell'_a)=\mathop{\mathrm{tr}}(D_yQ^{\mathsf T}FD_lF^{\mathsf T}Q)=\sum_{i,k}(Q^{\mathsf T}F)_{ik}^2y_il_k$ is right. With the permutation matrix $[k=\sigma(i)]$, $Y'=F\mathop{\mathrm{diag}}(y\circ\sigma^{-1})F^{\mathsf T}$ has $\mathop{\mathrm{tr}}(Y'\ell'_a)=\sum_iy_il_{\sigma(i)}$, so the direction is right.
- The rotation step is right. On $V_a$ the rotation acts by $F^{\mathsf T}$, on the Hodge frame by $(\det F)F^{\mathsf T}$, and the sign squares away. $O(n)$, orientation-reversing elements included, acts on $\mathfrak{so}(n)$ by automorphisms, so $P$ is invariant.
- **Gap C1.** "The result $W'$ lies in $\mathcal S_J\cap\mathcal W_n$, since the traceless blocks are free once the scalars satisfy L226's item 2" establishes $\mathcal W_n$ only. L226's Setting gives the direction "$W\in\mathcal S_J$ is block-diagonal", and the proof needs the converse, that an operator of this block form is fixed by $H_J$. The converse is true and on file: the [block note](2026-09-14-I104-block-J.md) reads characters entry by entry, and [L227](../findings/second-order.md)'s step 4 cites it at exactly this point. The same converse underlies "$\mathcal D_n\subseteq\mathcal S_J$" in the Attainment line, which follows from $H_J\subseteq\Gamma=H_{\{i\}}$ and $\mathcal S_{\{i\}}=\mathcal D_n$ in the block note.

## Item 4

- $X_a^2+X_b^2=\tfrac12(U^2+V^2)$ and $\mathop{\mathrm{tr}}(U+V)^3+\mathop{\mathrm{tr}}(U-V)^3=2\mathop{\mathrm{tr}}U^3+6\mathop{\mathrm{tr}}(UV^2)$, the odd terms cancelling. The Gram pairs $(a,b),(b,a)$ give $2\beta_{ab}\cdot\tfrac14(\lvert U\rvert^2-\lvert V\rvert^2)$, and the pairs with $c\notin\{a,b\}$ give the stated sum. So $Z=\tfrac32X+\tfrac34U$ and $L$ are right, and $X=U+\sum_{c\ne a,b}X_c$ is diagonal in $F$.
- $\mathop{\mathrm{tr}}(V^2Z)=\sum_{i,k}(F^{\mathsf T}Q)_{ik}^2z_i\nu_k^2$ is right, and both terms are linear in the one matrix $\big((F^{\mathsf T}Q)_{ik}^2\big)$.
- **C3.** Here the rows index $F$. Under item 3's convention, the permutation matrix $[k=\sigma(i)]$ gives $\sum_i(z_i\nu_{\sigma(i)}^2+l_i\nu_{\sigma(i)})$ and $V'=F\mathop{\mathrm{diag}}(\nu\circ\sigma)F^{\mathsf T}$. The block writes $\nu\circ\sigma^{-1}$ for a $\sigma$ it never defines, and the derivation note's batch 3 has $\nu\circ\sigma$.
- **C4.** "Item 3's last three sentences finish" imports "by item 2 it has $\lVert W'\rVert=\lVert W\rVert$ and $P(W')\ge P(W)$". In item 4 both come from item 4's own computation.
- **C7.** Statement item 4 uses $a,b$ without saying they are distinct. The title says "one pair", and the proof needs $a\ne b$.

## Scope

- At $m=2$ item 4 also covers every $W$, since $X_a+X_b$ is diagonal in its eigenframe. This is unstated and harmless.
- Items 3 and 4 use $(t,K)$ only through the constraint $3t_a+\sum_bK_{ab}=0$, which they leave unchanged.

## Gate 1

- **(a)** Screen 1 of [screen_I106.py](../scripts/misc/screen_I106.py) was run alone, its ascent skipped. It reproduces value agreement at $n=5,6,7$ ($8.8487923450$, $-12.1437163652$, $145.7277371131$), with the cubic written as $6\sum C_{ccc}+9\sum C_{ccd}+12\sum C_{cde}$, which equals item 1's form for symmetric blocks. The norm is `norm2_blocks`, L226's block norm, against `P_traceless`'s norm. **This is formula to formula, and the clause "cubic and norm agree with the trusted $Q$" overstates it (C2).** [L227](../findings/second-order.md)'s Gate 1 was repaired for the same point. Item 2's rotation prediction in [screen_I106_m3.py](../scripts/misc/screen_I106_m3.py) reproduces $26.0966647666$ and $20.5774649600$, with norm changes $7.1\cdot10^{-15}$.
- **(b)** L227 is the case $n=5$, $m=2$, by a route of its own (Rayleigh bounds). It is true as written.
- **(c)** Reproduced. $P$ went $7.37\to11.86$ and $14.15\to20.33$ at fixed norm, with commutators $1.1\cdot10^{-16}$ and $3.1\cdot10^{-16}$.
- **(d)** True. At $m=1$, $2+3+1=6$, $\lvert X\rvert^2+\lvert X_1\rvert^2=2\lvert X_1\rvert^2$ and $t_1=0$. Also $\sqrt6/2^{3/2}=\sqrt3/2=\Theta_4$. The reading as L225 needs $P_0=N_0=0$, which holds (no $K$, $t_1=0$) but is not said (C6).

## Lean

- `lake build HamiltonsCubic.Results.L228Statement` completed successfully.
- `#print axioms` on `cubic_split`, `complete_square`, `complete_square_norm` and `align_to_frame` gives `[propext, Classical.choice, Quot.sound]` for each.
- `cubic_split` splits `cubicX` at block `0` over `Fin (m + 1)`. Its remainder $2\mathop{\mathrm{tr}}R^3+3\mathop{\mathrm{tr}}(RT)+\sum\mathop{\mathrm{tr}}X_c^3$ is right, and no symmetry or trace hypothesis appears, which is correct since only cyclicity is used.
- `complete_square` takes arbitrary `L`, so it covers the Gram part of $\ell_a$ as an input. `complete_square_norm` writes $\lvert X_a\rvert^2$ as `trace (Xa * Xa)`, which is equal for symmetric blocks.
- `align_to_frame` takes orthogonal `F` (both products), symmetric `Y` and arbitrary `l`, and returns `y` with equal first three power traces and the pairing inequality. That is exactly what item 3 consumes: $\mathop{\mathrm{tr}}Y'=0$, $\lvert Y'\rvert=\lvert Y_a\rvert$ (since $Y'$ is symmetric), $\mathop{\mathrm{tr}}Y'^3$ and the pairing.
- **C5.** "Item 1's scalar and Gram parts ... are outside the file" suggests item 1's cubic part is inside. The file defines `cubicX` as that cubic part and never derives it from L226's item 3. Item 2's Gram and norm expansions are also outside.

## Counterexample hunt and screens

A screen, not evidence. The script is r952_screen.py in the session scratchpad, `/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/8003e6c1-e5ca-4867-b816-0a2997ebc8d6/scratchpad/r952_screen.py`, run in seconds.

- Item 1 at $n=8$: value $64.6550427968$ against the trusted $Q$ and norm $50.7938677451$ against the assembled operator's Frobenius norm, both to ten digits.
- Item 2 at $n=8$, $a=3$: $c_a$ and $n_a$ computed at two unrelated $X_a$ agree to $10^{-13}$.
- Item 4 at $n=7$: a random rotation of $V$ moves $P$ by $0.8707582402$, equal to the predicted $\mathop{\mathrm{tr}}((V_2^2-V^2)Z)+\mathop{\mathrm{tr}}((V_2-V)L)$, with the norm unchanged. The best of the six permutations raises $P$ from $11.88$ to $14.62$ at fixed norm, and every block commutes to $1.5\cdot10^{-16}$.
- Four fixed random points in item 3's stratum at each of $n=6,7,8$ stay well below $\Theta_n$. This is a bounded sample and not a search.

## Corrections

- **C1** (item 3, gap). Replace "The result $W'$ lies in $\mathcal S_J\cap\mathcal W_n$, since the traceless blocks are free once the scalars satisfy L226's item 2, and by item 2 it has" with "The result $W'$ lies in $\mathcal S_J$, since every block entry carries a character trivial on $H_J$ ([block note](../reviews/2026-09-14-I104-block-J.md)), and in $\mathcal W_n$ by L226's items 2 and 3, the traceless blocks being free once the scalars satisfy item 2, and by item 2 it has". In **Attainment**, replace "$\mathcal D_n\subseteq\mathcal S_J$, and" with "$\mathcal D_n=\mathcal S_{\{i\}}\subseteq\mathcal S_J$, since $H_J$ is a subgroup of the sign changes ([block note](../reviews/2026-09-14-I104-block-J.md)), and".
- **C2** (Gate 1 (a)). Replace "Item 1's cubic and norm agree with the trusted $Q$ of [curvature_operator.py](../scripts/lib/curvature_operator.py) at $n=5,6,7$ to ten digits ([screen_I106.py](../scripts/misc/screen_I106.py))" with "Item 1's cubic agrees with the trusted $Q$ of [curvature_operator.py](../scripts/lib/curvature_operator.py) at $n=5,6,7$ to ten digits, and item 1's norm agrees with L226's block norm to ten digits, formula to formula ([screen_I106.py](../scripts/misc/screen_I106.py))".
- **C3** (item 4). Replace "linear in one doubly stochastic matrix, so a permutation does at least as well, and $V'=F\mathop{\mathrm{diag}}(\nu\circ\sigma^{-1})F^{\mathsf T}$" with "linear in one doubly stochastic matrix, so by Birkhoff's theorem it is at most $\sum_i\big(z_i\nu_{\sigma(i)}^2+l_i\nu_{\sigma(i)}\big)$ for some permutation $\sigma$, and $V'=F\mathop{\mathrm{diag}}(\nu\circ\sigma)F^{\mathsf T}$".
- **C4** (item 4). Replace "Item 3's last three sentences finish." with "$W'$ lies in $\mathcal S_J\cap\mathcal W_n$ as in item 3, with the norm and value just shown, and item 3's last two sentences finish."
- **C5** (Lean paragraph). Replace "Item 1's scalar and Gram parts, item 4, the rotation to a diagonal tensor, L57 and the bridges of L226 are outside the file." with "`cubicX` is item 1's cubic part by definition. Item 1's reduction of L226's item 3 (the Cayley–Hamilton expansions, the Gram and scalar parts and the norm), item 2's Gram and norm expansions, item 4, the rotation to a diagonal tensor, L57 and the bridges of L226 are outside the file."
- **C6** (Gate 1 (d)). Replace "item 1 reads $P=6\mathop{\mathrm{tr}}X_1^3+P_0$ at $\lVert W\rVert^2=2\lvert X_1\rvert^2+N_0$ with $t_1=0$" with "item 1 reads $P=6\mathop{\mathrm{tr}}X_1^3$ at $\lVert W\rVert^2=2\lvert X_1\rvert^2$, since $t_1=0$ and there is no $K$, so $P_0=N_0=0$".
- **C7** (Statement item 4). Replace "*If the blocks $X_c$, $c\notin\{a,b\}$, and $X_a+X_b$" with "*If for distinct $a,b\in A$ the blocks $X_c$, $c\notin\{a,b\}$, and $X_a+X_b$".
