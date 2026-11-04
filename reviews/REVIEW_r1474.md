# REVIEW r1474: L162's monotonicity and L124's equality spectrum and (i) in Lean, commits 90dbfe88 and 5ec0bd35

Log [agent_logs/r1474.log](../agent_logs/r1474.log). One reviewer, working cold and adversarially. Analysis-only: `lake build HamiltonsCubic.Results.L162Mono HamiltonsCubic.Results.L124Det` (completed successfully) and one scratch file in the session scratchpad outside the repository carrying `#print axioms` and `#check`. One seconds-long screen was run on objects constructed for it (a central finite difference of `Sfun` against the claimed $S'$ at six points, and $F(12)$ in floating point), reported below as a screen and not as evidence.

**Standfirst.** Both files compile, and `F_gt_twelve`, `Sfun_strictMonoOn`, `det_sq_eq` and `sigma_of_sum_zero` rest on `propext`, `Classical.choice` and `Quot.sound` alone. `Sfun` is the record's $S=c_p+\rho^{\mathrm{eff}}_nw_0^2$ term by term, `F_gt_twelve` is the record's $F(w_0)$ with $s_0=\sqrt S$ and $\beta=\lambda/(2C)$, and its range "every real $n>12$" contains the record's even $n\ge14$. The Lean numerator of $S'$ is the record's numerator times the positive factor $\sqrt{(n-1)(n-2)}$, and the squaring step reduces to exactly $(x-1)(x-2)D(x)>0$. The two-step composition ($\beta$ first at fixed $s_0(12)$, then $s$ at fixed $\beta(n)$) is sound. `det_sq_eq` and `sigma_of_sum_zero` are correct. The gaps are in text: second-order.md still says, in the same L162 block that now cites `F_gt_twelve`, that "$s_0$ increases" is the one statement still owed (G1). `det_sq_eq`'s docstring claims "exactly one $2/\sqrt6$", which its statement does not carry (G2). L162Mono.lean's module docstring splices two clauses with a semicolon (G3).

| Item | Verdict | Reason |
| --- | --- | --- |
| A. Fidelity of `F_gt_twelve` | CONFIRMED | `Sfun` is $3\theta_0/(x-2)+(\sqrt6-\theta_0(x+16)/(2(x-2)))((x-4)/x)^2$ with $\theta_0=q/x$, $q=\sqrt{2(x-1)(x-2)}$. $s=\sqrt{\mathtt{Sfun}}$, $\beta=\lambda/(2C)$, $F=4s/(\sqrt{4\beta s+1}+1)^2$. Real $n>12$ contains even $n\ge14$ |
| B. `Sfun_hasDerivAt` | CONFIRMED | Lean numerator $=\sqrt{(x-1)(x-2)}\cdot$ record numerator. Case $P\ge0$ trivial, case $P<0$ squares to $a^2-q^2P^2=(x-1)(x-2)D(x)$, and `D_pos` closes it. Kernel-checked, screen agrees |
| C. Monotonicity and composition | CONFIRMED | `HasDerivAt` at every $x\ge12$ gives continuity on `Ici 12` including the endpoint, and positivity on `interior (Ici 12) = Ioi 12`. `Sfun_twelve_pos` is $\sqrt{220}\cdot7<60\sqrt6$. `F_antitone_beta` at $s_0(12)$ then `F_strictMono_s` at $\beta(n)$, hypotheses all met |
| D. L124Det additions | CONFIRMED WITH GAP | `det_sq_eq` is correct through `matrix_cube_eq` at $k=3$, $c=\sqrt6$. `sigma_of_sum_zero` is L124(i) verbatim. G2: the docstring (L124Det.lean:84-85) promises "exactly one $2/\sqrt6$", which the statement drops |
| E. Axioms | CONFIRMED | All four: `[propext, Classical.choice, Quot.sound]` |
| F. Record text | CONFIRMED WITH GAP | G1: findings/second-order.md:2308 says "$s_0$ increases" is still owed. G3: L162Mono.lean:10 is a clause-splicing semicolon. The L162 and L124 rows, L162.lean's docstring and the second-order.md:2296 citation are accurate. No em dash added |

**Summary: CONFIRMED WITH GAP, the five L162Mono theorems and the two L124Det theorems are correct, faithful and axiom-clean, and the record's L162 block still owes, two lines below the citation of its proof, the monotonicity the commit proves.**

## A. Fidelity of F_gt_twelve

**The record** (findings/second-order.md:2270-2278, Lemma L162 statement): *"For even $n\ge12$, with $\theta_0=\theta_0(n)$ and $c_p=\frac{3\theta_0}{n-2},\ \rho^{\mathrm{eff}}_n=\sqrt6-\theta_0\frac{n+16}{2(n-2)},\ \lambda=\frac2{\sqrt{9(\theta_0-\sqrt{3/2})}},\ C(n)=\frac{2(2n-3)}{n-1}$, put $\beta=\lambda/(2C)$, $w_0=\frac{n-4}n$ and $s_0=\sqrt{c_p+\rho^{\mathrm{eff}}_nw_0^2}$ ... $F(w_0)=\frac{4s_0}{(\sqrt{4\beta s_0+1}+1)^2}$, with $F(12)=0.38673$ and limit $0.90304$, and $F(n)>F(12)$ at every even $n\ge14$."* $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ is second-order.md:1680 and :2034.

- **`q` and $\theta_0$.** `q x = √(2(x−1)(x−2))`, and `Sfun` uses `q x / x` wherever the record has $\theta_0$. Faithful at $x>0$.
- **`Sfun`.** `3 * (q x / x) / (x − 2)` is $c_p$. `(√6 − q x / x * (x + 16) / (2 * (x − 2)))` is $\rho^{\mathrm{eff}}_n$, Lean's left-associated `a * b / c` being $a\cdot b/c$. `((x − 4) / x) ^ 2` is $w_0^2$. So `Sfun` is $S$.
- **$s_0$, $\beta$, $F$.** The `let` binders are `s x = √(Sfun x)` and `β x = lam x / (2 * (2 * (2x − 3)/(x − 1)))`, which is $\lambda/(2C)$ with the record's closed $C$ and L162.lean's `lam` (confirmed faithful by r1473). The compared expression is `4 * s n / (√(4 * β n * s n + 1) + 1) ^ 2`, the record's $F(w_0)$ exactly.
- **Range.** The hypothesis is `12 < n` over $\mathbb R$, which contains every even $n\ge14$.
- *Argued against:* the record's $F$ is "the binding value of L158's envelope-free $G$ at its minimiser", and Lean defines $F$ by the closed form directly. That identification is the record's composition, which L162.lean's row already scopes as outside the Lean. The theorem proves the record's monotonicity sentence about the closed form, which is what the row claims. No gap.

## B. Sfun_hasDerivAt

**The record** (second-order.md:2294-2300): *"With $S=c_p+\rho^{\mathrm{eff}}_nw_0^2$, clearing denominators gives $S'(n)$ the numerator $\sqrt2\,P(n)+8n(n-2)(n-4)\sqrt{6(n-1)(n-2)}$ ... over a manifestly positive denominator ... harmless, since $D>0$ is sufficient for either sign of $P$. Squaring reduces it to $D(n)>0$ ... $D(n)=384\,n^2(n-2)^3(n-4)^2(n-1)-2P(n)^2$."*

- **The derivative is kernel-checked.** `hS` builds the derivative from `q_hasDerivAt'` (itself $(2x-3)/q$ rewritten with $q^2=2(x-1)(x-2)$) by the product and quotient rules, and `congr_deriv` closes the equality with the claimed form by `field_simp; ring`. Since the build succeeds, the formula is correct as stated. *Screen, not evidence:* a central finite difference of `Sfun` matches the closed form to about nine digits at $x=12,14,20,85,100,1000$.
- **Match with the record.** Write $r=\sqrt{(x-1)(x-2)}$, so $q=\sqrt2\,r$. Then $8\sqrt6x(x-1)(x-2)^2(x-4)+qP=r\,[8x(x-2)(x-4)\sqrt6\,r+\sqrt2P]=r\,[\sqrt2P+8x(x-2)(x-4)\sqrt{6(x-1)(x-2)}]$. The Lean numerator is the record's times $r>0$, and the Lean denominator $x^4(x-2)^2(x-1)$ is positive at $x\ge12$.
- **The case split.** With $a=8\sqrt6x(x-1)(x-2)^2(x-4)>0$ at $x\ge12$: if $P\ge0$ then $a+qP\ge a>0$. If $P<0$ then $b=-qP>0$, and $a^2-b^2=384x^2(x-1)^2(x-2)^4(x-4)^2-2(x-1)(x-2)P^2=(x-1)(x-2)\,D(x)$, which is the `nlinarith [mul_pos h12 hD]` step. From $a^2>b^2$ with $a,b>0$ follows $a>b$, which the final `nlinarith [hsq, ha, hb]` extracts. Sound, and it is the record's "$D>0$ is sufficient for either sign of $P$".
- *Argued against:* `D_pos` is stated for `12 ≤ n`, and `Sfun_hasDerivAt` takes `12 ≤ x`, so the ranges agree. No gap.

## C. Monotonicity and composition

- **`Sfun_strictMonoOn`.** `strictMonoOn_of_deriv_pos (convex_Ici 12)` needs `ContinuousOn Sfun (Ici 12)`, supplied pointwise from `HasDerivAt` at every $x\ge12$, the endpoint included since `Sfun_hasDerivAt` holds at $x=12$. It needs `0 < deriv Sfun x` on `interior (Ici 12) = Ioi 12`, supplied by `hd.deriv`. Correct.
- **`Sfun_twelve_pos`.** At $x=12$, $q=\sqrt{220}$, $c_p=\sqrt{220}/40$, $\rho^{\mathrm{eff}}_{12}=\sqrt6-\tfrac{7}{60}\sqrt{220}$, and `hρ` is $7\sqrt{220}<60\sqrt6$, i.e. $10780<21600$. With $\rho^{\mathrm{eff}}_{12}>0$ both terms are positive. *Screen, not evidence:* $\rho^{\mathrm{eff}}_{12}=0.71904$ in floating point, matching the record.
- **Composition.** $s(12)<s(n)$ from `Real.sqrt_lt_sqrt` with $S(12)>0$. $\beta(n)<\beta(12)$ from `beta_strictAnti le_rfl hn`. $\beta(n)>0$ from $\theta_0^2>3/2$ and $C>0$. After `F_form` at both ends, the chain is $F(s_{12},\beta_{12})<F(s_{12},\beta_n)$ by `F_antitone_beta` (needing $s_{12}>0$, $\beta_n\ge0$, $\beta_n<\beta_{12}$), then $<F(s_n,\beta_n)$ by `F_strictMono_s` (needing $s_{12}\ge0$, $s_{12}<s_n$, $\beta_n>0$). Every hypothesis is discharged. `F_form` at the left end needs $\beta_{12}\ge0$, which `linarith` gets from $0<\beta_n<\beta_{12}$. Sound. *Screen, not evidence:* $F(12)=0.386728$, $F(14)=0.514407$, $F(10^7)=0.903035$.
- *Argued against:* the order could matter if `F_antitone_beta` required strict positivity of the smaller $\beta$ at a point where it fails. It requires only $\beta_n\ge0$, and $\beta_n>0$ is proved. No gap.

## D. L124Det additions

**The record** (second-order.md:1464): *"(i) If $A+B+C=0$ then $\Sigma=\tfrac32(A^2+B^2+C^2)$, an identity in three reals"*, and (iii) at :1469: *"with equality exactly at $\pm W_{\mathbb{CP}^2}$"*, the proof at :1473 reading *"The determinant bound's equality case is $X\propto(2,-1,-1)$."*

- **`sigma_of_sum_zero`.** Substituting $C=-A-B$ and `ring` proves $A^2+B^2+C^2-AB-BC-CA=\tfrac32(A^2+B^2+C^2)$, the record's (i) with $\Sigma$ as defined at :1462. Faithful.
- **`det_sq_eq`, the mathematics.** $\mathop{\mathrm{tr}}X^3=3\det X$ (`trace_cube_eq_three_det`), so $(\det X)^2=1/54$ gives $(\mathop{\mathrm{tr}}X^3)^2=9/54=1/6=(1/\sqrt6)^2$, hence $\mathop{\mathrm{tr}}X^3=\pm1/\sqrt6$. At $k=3$, $c=\sqrt6$ (with $c^2=6=3\cdot2$), $(k-2)/c=1/\sqrt6$ and $(k-1)/c=2/\sqrt6$, so `matrix_cube_eq` applies to $X$ in the $+$ case and to $-X$ in the $-$ case, with $\mathop{\mathrm{tr}}(-X)=0$, $\mathop{\mathrm{tr}}(-X)^2=1$ and $\mathop{\mathrm{tr}}(-X)^3=-\mathop{\mathrm{tr}}X^3$ all correctly established. Correct.
- **G2, the docstring outruns the statement.** The docstring (lean/HamiltonsCubic/Results/L124Det.lean:84-85) reads *"`X` or `−X` has every eigenvalue `2/√6` or `−1/√6`, exactly one `2/√6`"*, and module line 16 and the L124 row (lean/INDEX.md:454) say *"has the spectrum $(2,-1,-1)/\sqrt6$"*. The statement (lines 86-89) concludes only `∀ i, eigenvalues i = 2/√6 ∨ eigenvalues i = −1/√6`, taking `.1` of `matrix_cube_eq` and discarding `.2`, the cardinality clause that says exactly one. Concretely, the conclusion's shape is satisfied by the eigenvalue triple $(-1,-1,-1)/\sqrt6$, so as a typed statement it does not say what the docstring says.
  - *Argued against:* together with the hypothesis $\mathop{\mathrm{tr}}X=0$, $a$ copies of $2/\sqrt6$ and $3-a$ of $-1/\sqrt6$ sum to zero only at $a=1$, so the multiplicity follows in one line and the docstring's claim is true. That makes it a fidelity gap between docstring and statement rather than a false theorem. It survives because `.2` was already in hand and the docstring describes a conclusion the declaration does not export. Minor.
- *Argued against, withdrawn:* the record says equality holds *exactly* at $\pm W_{\mathbb{CP}^2}$, and the converse (the spectrum $(2,-1,-1)/\sqrt6$ attains $(\det X)^2=1/54$) is not typed. The L124 row owes "the reading of the equality spectrum as the point $\pm W_{\mathbb{CP}^2}$", and the converse at the spectral level is the arithmetic $(2/\sqrt6)(1/6)=1/(3\sqrt6)$, which L124(iii)'s proof records. Withdrawn as not load-bearing. Likewise the italic aside to (i), that $A+B+C=0$ holds at a half-flat four-set, reduces to $\mathop{\mathrm{tr}}V_+=0$ once (ii)'s identification is in hand, and (ii) is owed. Withdrawn.

## E. Axioms

`#print axioms` from a scratch file importing both modules after a successful `lake build`:

- `HamiltonsCubic.L162.F_gt_twelve`: `[propext, Classical.choice, Quot.sound]`
- `HamiltonsCubic.L162.Sfun_strictMonoOn`: `[propext, Classical.choice, Quot.sound]`
- `HamiltonsCubic.L124Det.det_sq_eq`: `[propext, Classical.choice, Quot.sound]`
- `HamiltonsCubic.L124Det.sigma_of_sum_zero`: `[propext, Classical.choice, Quot.sound]`

No `sorryAx`, no `Lean.ofReduceBool`. CONFIRMED.

## F. Record text

- **The L162 row** (lean/INDEX.md:490) lists `Sfun_hasDerivAt`, `Sfun_strictMonoOn`, `Sfun_twelve_pos` and `F_gt_twelve` accurately and says *"**Owed**: nothing of the monotonicity. The values $F(12)=0.38673$ and the limit $0.90304$ are measurements"*. That is right: the monotonicity is fully typed, and the two numerals are not. The row stays **partial**, which the untyped numerals justify. Clean.
- **The L124 row** (lean/INDEX.md:454) now owes $\rho^2=\mathop{\mathrm{tr}}V_+^2$ with $\rho=1$ at unit norm, which resolves r1473's G1, and no longer owes the withdrawn $\theta^2\le\Sigma$. Its `det_sq_eq` clause carries G2's overstatement. Otherwise clean.
- **L162.lean's docstring** (line 9) now reads "rests on the facts below", which resolves r1473's G2. Clean.
- **The second-order.md citation** (:2296) says the whole monotonicity, $F(n)>F(12)$ for every real $n>12$, is `F_gt_twelve` in L162Mono.lean. Accurate.
- **G1, the L162 block contradicts its own citation.** findings/second-order.md:2308 reads *"**What is proved, and it is less than the box above once claimed.** ... *And $F(n)>F(12)$ at every even $n\ge14$.* **The one statement still owed is that $s_0$ increases**, where the earlier box named four."* Twelve lines above, :2294-2300 prove $s_0$ rises (reducing to $D>0$), and :2296 now cites `F_gt_twelve`, whose proof is `Sfun_strictMonoOn`. So the block asserts that $s_0$ increasing is both proved and machine-checked and still owed, and it lists $F(n)>F(12)$ as proved while calling its only remaining premise owed. The commit's `Searched:` line grepped "s_0 rising" and "D(n)>0", which misses "$s_0$ increases".
  - *Argued against:* the sentence could be a historical box, left to show what an earlier Gate 2 found. It is written in the present tense ("still owed"), it is not marked superseded, and a reader landing on it sees a live debt. The contradiction predates the commit in part (the text proof and `D_pos` were already there), but the commit added the citation that makes it direct, and the downstream sweep missed it. Survives.
- **G3, a clause-splicing semicolon.** lean/HamiltonsCubic/Results/L162Mono.lean:10 reads *"[L162.lean](L162.lean) proves the pieces; this file supplies `s₀` and composes them."* Two independent clauses joined by a semicolon, which the repository's writing convention forbids.
  - *Argued against:* lines 12-15 end in semicolons too, but those are list separators whose items carry commas, which the convention allows. Line 10 is prose, not a list. Survives. Minor.
- **Em dashes.** `git show 90dbfe88 5ec0bd35` contains none. The L162 and L124 rows' semicolons separate list items that themselves carry commas, which is permitted.
- *Observation, outside the two commits:* second-order.md:2268 still reads *"**Gate 2 owed.**"* under L162's heading, while :2394 and :2418 record L162 as Gate 2 passed with four reviewers. Pre-existing and not touched by either commit, so not scored. The 5ec0bd35 commit body also joins two clauses with a semicolon ("(G1); L162.lean's docstring ..."), which is immutable and not scored.
