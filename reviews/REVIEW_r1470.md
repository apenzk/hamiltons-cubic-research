# REVIEW r1470: L162's monotonicity steps in Lean, commit 5f394cce: C_closed, C_strictMono, theta0Sq_strictMono, F_form, D_pos, the L162 row, the L143 row and the two findings edits

Log [agent_logs/r1470.log](../agent_logs/r1470.log). One reviewer, working cold and adversarially. Analysis-only: `lake build HamiltonsCubic.Results.L162` and one scratch file in the session scratchpad outside the repository holding the `#print axioms` calls. Two coefficients of $D(12+x)$ and the constant term were recomputed by hand. One seconds-long sympy screen was run under Sage's Python on objects constructed for it, and it is reported below as a screen, not as evidence.

**Standfirst.** The module builds and all five declarations rest on `propext`, `Classical.choice` and `Quot.sound` alone. $P(n)$ and $D(n)$ are the record's to the coefficient, and $D$ is exactly what the record's squaring step produces from the $S'(n)$ numerator. `C_closed` is L156's $C^*$ with $\alpha^*=D/2=(n-1)/(n-2)$, `theta0Sq_strictMono` carries conventions' $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and `F_form` is the record's rewrite. `D_pos` covers every real $n\ge12$, which is what the record's derivative argument consumes, since $S'(n)>0$ must hold on the whole real interval between even integers. The hand checks reproduce $D(12)=23798734848$, the $x^7$ coefficient $\tfrac{62753}2$ and the $x^8$ coefficient $\tfrac{3047}8$. The second-order.md citation, r1469's G1 and G2 repairs and the row's owed list are honest. The one gap is a semicolon splice in the new L162 row (G1).

| Item | Verdict | Reason |
| --- | --- | --- |
| A. Fidelity | CONFIRMED | $P$ and $D$ match second-order.md:2292 and :2296 coefficient by coefficient. Squaring $8n(n-2)(n-4)\sqrt{6(n-1)(n-2)}>-\sqrt2P$ gives $384n^2(n-2)^3(n-4)^2(n-1)>2P^2$, which is $D>0$. $C$ is L156's $C^*$ (second-order.md:2230). $\theta_0^2$ is the record's (problem.md:21). `F_form` is second-order.md:2286. Real $n\ge12$ is needed and supplied |
| B. Proofs | CONFIRMED | $D(12+x)$'s expansion is an honest ring identity, checked by `ring` and by hand at three coefficients. The `theta0Sq_strictMono` hint is exact: the cross-multiplied difference is $2(m-n)(3nm-2n-2m)$ and $3nm-2n-2m\ge4m-4>0$. `C_strictMono` and `F_form` check |
| C. Axioms | CONFIRMED | `D_pos`, `F_form`, `C_closed`, `theta0Sq_strictMono`, `C_strictMono`: `[propext, Classical.choice, Quot.sound]` each |
| D. Record text | CONFIRMED WITH GAP | The citation, the L143 row's added owed items (r1469 G1) and the bounds.md split (r1469 G2) are correct, the diff adds no em dash, and the owed list is honest. The new L162 row splices two clauses with a semicolon (G1, lean/INDEX.md:490) |

**Summary: CONFIRMED WITH GAP, the four monotonicity steps are proved faithfully and on the range the proof needs, and the new row carries one semicolon splice.**

## A. Fidelity

**The record's claim, quoted from source** (second-order.md:2290-2300): *"With $S=c_p+\rho^{\mathrm{eff}}_nw_0^2$, clearing denominators gives $S'(n)$ the numerator $\sqrt2\,P(n)+8n(n-2)(n-4)\sqrt{6(n-1)(n-2)}$, $P(n)=\tfrac54n^4-\tfrac{229}2n^3+694n^2-1312n+768$, over a manifestly positive denominator. [...] Squaring reduces it to $D(n)>0$ [...] with $D(n)=384\,n^2(n-2)^3(n-4)^2(n-1)-2P(n)^2$. Substituting $n=12+u$ makes every coefficient of $D$ positive, from $23798734848$ at $u^0$ up to $\tfrac{3047}8$ at $u^8$."*

- **$P$ and $D$.** The Lean `P` is $\tfrac54n^4-\tfrac{229}2n^3+694n^2-1312n+768$ and `D` is $384n^2(n-2)^3(n-4)^2(n-1)-2P(n)^2$, both verbatim.
- **$D$ is what the record squares to.** The second term of the numerator is positive on $n\ge12$. If $P\ge0$ the numerator is positive outright. If $P<0$, positivity is $8n(n-2)(n-4)\sqrt{6(n-1)(n-2)}>\sqrt2\lvert P\rvert$ with both sides positive, and squaring gives $64\cdot6\,n^2(n-2)^3(n-4)^2(n-1)>2P^2$, which is $D>0$. So $D>0$ implies the numerator is positive at either sign of $P$, as the record says.
- **$C$.** L156 fixes $D=\tfrac{2m-1}{m-1}$ and $\alpha^*=D/2=\tfrac{2m-1}{2(m-1)}$ (second-order.md:2227, :2230), which at $n=2m$ is $\tfrac{n-1}{n-2}$. Then $(4+2D)/D=2+2/\alpha^*=2+\tfrac{2(n-2)}{n-1}=\tfrac{2(2n-3)}{n-1}$, and L156's own $C^*=2+\tfrac{4(m-1)}{2m-1}$ is the same number. `C_closed` states exactly this, with $D$ inlined as $2\alpha^*$. At $n=12$ it gives $\tfrac{42}{11}$, the record's printed value.
- **$\theta_0^2$.** The record's $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ (problem.md:21, second-order.md:1678) squares to the Lean expression. The hypothesis $n\ge2$ is wider than the lemma's range and harmless.
- **`F_form`.** The Lean statement is the record's $\tfrac{4s}{(\sqrt{4\beta s+1}+1)^2}=\tfrac{2s}{1+2\beta s+\sqrt{1+4\beta s}}$ (second-order.md:2286), under $s,\beta\ge0$, which contains the record's $s_0>0$ and $\beta>0$.
- **Real or even $n$.** The record's statement is at even $n$, but its proof of "$s_0$ rises" is a sign of $S'(n)$, and a derivative argument from $n=12$ to $n=14$ needs $S'>0$ on the real interval $[12,14]$, not only at its endpoints. So the proof needs $D>0$ on real $n\ge12$. `D_pos` supplies exactly that.

*Screen, not evidence.* A sympy computation of $S'(n)$ from the record's $c_p$, $\rho^{\mathrm{eff}}_n$, $w_0$ and $\theta_0$ returned $S'(n)/N(n)>0$ at $n=12,14,50,86,200$ with $N$ the record's numerator, and the expansion of $D(n+12)$ returned the nine coefficients in the Lean file. It checks the reduction the row lists as owed. It proves nothing about it.

## B. Proofs

- **`D_pos`.** The substitution $n=12+x$ with $x\ge0$ is exact, the identity is closed by `unfold D P; ring`, and `positivity` closes a sum of positive rationals times powers of a nonnegative $x$. The constant term being positive makes it strict. By hand: $384\cdot144\cdot1000\cdot64\cdot11=38928384000$, $P(12)=25920-197856+99936-15744+768=-86976$, $2\cdot86976^2=15129649152$, so $D(12)=23798734848$. The $x^8$ coefficient is $384-2(\tfrac54)^2=\tfrac{3047}8$. The $x^7$ coefficient is $384\cdot(24+30+16+11)=31104$ from the first term plus $-2\cdot2\cdot\tfrac54\cdot(60-\tfrac{229}2)=272.5$ from $-2P^2$, total $\tfrac{62753}2$. All three match the Lean file.
- **`C_strictMono`.** After `div_lt_div_iff₀` the goal is $2(2n-3)(m-1)<2(2m-3)(n-1)$, whose difference is $2(m-n)>0$, linear after expansion. `nlinarith` closes it.
- **`theta0Sq_strictMono`.** The cross-multiplied goal is $2(n-1)(n-2)m^2<2(m-1)(m-2)n^2$. The difference is $2[3nm(m-n)-2(m-n)(m+n)]=2(m-n)(3nm-2n-2m)$, so the hint `mul_pos (m-n>0) (3nm-2n-2m>0)` is exactly the needed product. Its second factor is positive since $3nm-2n-2m=n(3m-2)-2m\ge2(3m-2)-2m=4m-4>0$ at $n\ge2<m$.
- **`F_form`.** $(q+1)^2=q^2+2q+1=4\beta s+2+2q$ from `Real.sq_sqrt`, which is `hd`, then `field_simp` with the positive denominator. Correct.

## C. Axioms

`lake build HamiltonsCubic.Results.L162` completes. From a scratch file outside the repository, `#print axioms` on `D_pos`, `F_form`, `C_closed`, `theta0Sq_strictMono` and `C_strictMono` returns `[propext, Classical.choice, Quot.sound]` for each. No `sorry`, no `native_decide`.

## D. Record text

- **The L162 row's proved part** (lean/INDEX.md:490) names the five declarations with the record's statements and the standard three axioms. Accurate.
- **The owed list is honest.** It owes $h'>0$ with the elasticity bound, the $S'(n)$ numerator reduction to $D$, and the composition into $F(n)>F(12)$ at even $n\ge14$, and it calls $F(12)=0.38673$ and the limit $0.90304$ measurements. *Candidate considered and withdrawn*: the row glosses `theta0Sq_strictMono` with "so $\lambda$ falls", and the step from $\theta_0$ rising to $\beta=\lambda/(2C)$ falling (which needs $\theta_0>\sqrt{3/2}$ for $\lambda$ to be real and positive) is not formalised. The opposite reading holds: the gloss is a one-line monotone composition the record itself calls one line, and "the composition into $F(n)>F(12)$" names the assembly of $\beta$ falling with $s_0$ rising. Withdrawn.
- **The second-order.md citation** (second-order.md:2294) says `D_pos` is machine-checked for every real $n\ge12$, with the $C$, $\theta_0$ and $F$-form steps. Accurate.
- **r1469's G1** is repaired: the L143 row (lean/INDEX.md:345) now owes $\lambda_{\max}p\le1$ and the assembly into $\sup\lvert P\rvert\le1+\sqrt{n-2}$.
- **r1469's G2** is repaired: findings/bounds.md:33 now ends the first clause at a full stop and starts "The same AM–GM" as its own sentence.
- **Em dashes.** None in the added lines. The Lean docstring's "L156–L158" is an en dash on a range.
- **G1. A semicolon splice in the new L162 row** ([lean/INDEX.md:490](../lean/INDEX.md#L490)). The owed list reads *"... and the composition into $F(n)>F(12)$ at even $n\ge14$; the values $F(12)=0.38673$ and the limit $0.90304$ are measurements"*. The list closes with "and the composition", so what follows the semicolon is an independent clause, not another item. *Opposite argued*: the row's earlier semicolons separate list items that carry commas, which is the permitted use, and this one might be read as one more item. It cannot be: the list is already closed by "and", and "the values ... are measurements" has its own subject and verb. The splice stands. It is a style defect with no mathematical consequence.

**Overall: CONFIRMED WITH GAP.**
