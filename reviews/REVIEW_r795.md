# Lean review, reviewer r795, do the two new theorems state the results they are named for?

**Cold brief.** I worked from the coordinator's brief, held outside the repository at `/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/brief-lean-r795.md`, and read [L177Statement.lean](../lean/HamiltonsCubic/Results/L177Statement.lean) and [L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean) line by line before reading L177's block in [findings/diagonal-half.md](../findings/diagonal-half.md#L589) or L182's in [findings/second-order.md](../findings/second-order.md#L1618). **No numerical work was done and every value in this report is exact**, the quadratic below is solved in radicals and every decimal quoted is checked against a radical, never produced by one. **Two screens were run**, each an elaboration in Lean of an object I constructed for the purpose, in a scratch file outside the repository; they are reported as screens in §3 and no positive claim here rests on one. This is a single-reviewer report by design: the kernel has already checked every step, so the one question left is whether the typed statements are the results the record names. Log: [agent_logs/lean-r795.log](../agent_logs/lean-r795.log).

## The claim table

| # | Claim attacked | Verdict |
| --- | --- | --- |
| 1 | [finrank_ker_incidence](../lean/HamiltonsCubic/Results/L177Statement.lean#L64) is the record's L177(1) | **CONFIRMED AS THE DIMENSION HALF, REFUTED AS THE WHOLE**, L177(1) is a conjunction, the identification of the locus *with* $\ker N$ and then its dimension; the Lean goal carries the second conjunct only, and its own docstring headline asserts the first |
| 2 | The $\mathbb Z$ statement is the right one | **CONFIRMED, AND THE WITHDRAWN $\mathbb N$ FORM HAS AN EXACT COUNTEREXAMPLE**, $K_2$ gives $1-2+1=0$ over $\mathbb Z$ and $1$ over $\mathbb N$, against a true kernel dimension of $0$; the three casts are each on a $\mathbb N$-valued quantity and hide nothing further |
| 3 | `hrank` is satisfiable at a graph with an edge | **CONFIRMED, TWICE OVER AND MORE STRONGLY THAN ASKED**, it is satisfiable at **every** `ends` with $b:=\lvert V\rvert-\mathop{\mathrm{rank}}N$, since $\mathop{\mathrm{rank}}N\le\lvert V\rvert$; and at $K_2$ the satisfying $b=1$ is the genuine bipartite-component count |
| 4 | $b$ is unconstrained | **REFUTED ($b$ is pinned uniquely**), `hrank` forces $b=\lvert V\rvert-\mathop{\mathrm{rank}}N$, hence $b\le\lvert V\rvert$, so no absurd or vacuity-inducing $b$ exists. *The cost is the mirror of the benefit: a hypothesis satisfiable at every graph restricts no graph, so the theorem is rank–nullity restated and carries no graph theory* |
| 5 | [lamInf_lt_lam](../lean/HamiltonsCubic/Results/L182Statement.lean#L97) is the record's claim | **CONFIRMED AS ONE FACTOR, WEAKER THAN L182**, it is the record's $\lambda(n)>\lambda_\infty$ exactly, over a range narrower than the record's own ($12\le n$ against $n>6+2\sqrt7$) and a type wider ($n:\mathbb R$, no parity); L182 itself is the product bound and remains a `sorry` |
| 6 | [theta0sq_lt_two](../lean/HamiltonsCubic/Results/L182Statement.lean#L64) and [three_halves_lt_theta0sq](../lean/HamiltonsCubic/Results/L182Statement.lean#L73) are true and use their hypothesis | **CONFIRMED (both true, both hypotheses honest, both stronger than needed**), the first holds exactly on $n>2/3$, the second exactly off $[6-2\sqrt7,\,6+2\sqrt7]$; $12\le n$ is a safe over-restriction in each |
| 7 | The crossover claim: roots $6\pm2\sqrt7$, and $n=12$ clears $11.2915$ | **CONFIRMED EXACTLY**, the discriminant is $112=4\cdot28$, so the roots are $6\pm2\sqrt7$, and $6+2\sqrt7=11.29150262\ldots$; the margin at $n=12$ is exactly $6-2\sqrt7$, the *other* root, since the roots sum to $12$ |
| 8 | [theta0_bounds](../lean/HamiltonsCubic/Results/L182Statement.lean#L80) and [lam_radicand_bounds](../lean/HamiltonsCubic/Results/L182Statement.lean#L87) carry their nonnegativity honestly | **CONFIRMED, no step leans on `Real.sqrt` of a negative**, both `Real.sqrt_lt_sqrt` calls discharge $0\le x$ from a proved bound, and $\lambda_\infty$ is shown non-junk as a by-product of [lam_radicand_bounds](../lean/HamiltonsCubic/Results/L182Statement.lean#L87) |
| 9 | Nothing in either file claims more than it proves | **REFUTED FOR THREE DOCSTRINGS**, [finrank_ker_incidence](../lean/HamiltonsCubic/Results/L177Statement.lean#L57)'s headline asserts the locus identification, [deriv_in_u_neg](../lean/HamiltonsCubic/Results/L182Statement.lean#L54) is documented as a derivative computation and states a linear inequality in a free variable, and [theta0sq_lt_two](../lean/HamiltonsCubic/Results/L182Statement.lean#L62)'s docstring claims a range the theorem does not have |
| 10 | [lean/INDEX.md](../lean/INDEX.md#L42)'s L177 row calls the statement **proved** | **CONFIRMED FOR THE ROW, REFUTED FOR TWO PROSE LINES AND ONE CREDIT**, the row is accurate and names the hypothesis, but [line 425](../lean/INDEX.md#L425) and [line 436](../lean/INDEX.md#L436) still say L177 carries a declared `sorry`, and the row credits as proved two "mechanisms" the file's own docstrings retract |

## One-line summary

**Both new theorems are true, their proofs are sound, and their hypotheses are load-bearing, but L177's hypothesis is satisfiable at every graph and so imports no graph theory, `lamInf_lt_lam` is one factor of L182 rather than L182, and three docstrings plus three lines of [lean/INDEX.md](../lean/INDEX.md) describe more than the file contains.**

## 0. Conventions, fixed once

- $G=(V,E)$ is a finite graph, $N\in\{0,1\}^{V\times E}$ its **unsigned** incidence matrix, $b(G)$ its number of bipartite connected components. In Lean the graph is the bare datum `ends : E → V × V` and $N$ is [incidence](../lean/HamiltonsCubic/Results/L177Statement.lean#L24).
- **Corank** means $\lvert V\rvert-\mathop{\mathrm{rank}}N$. It is what `hrank` names $b$, and it agrees with $b(G)$ exactly when Zaslavsky's identity applies.
- $\theta_0(n)^2=2(n-1)(n-2)/n^2$, $\lambda(n)=2/\sqrt{9(\theta_0(n)-\sqrt{3/2})}$, $\lambda_\infty=2/\sqrt{9(\sqrt2-\sqrt{3/2})}$, as in [L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean#L22).
- **Junk value** means Lean's total-function convention: `Real.sqrt x = 0` at $x<0$, and `x / 0 = 0`. Both matter below and both were checked.
- A **screen** is seconds of elaboration on an object I constructed, run outside the repository and reported as a screen. **The programme is on an analysis-only footing and I did not open any search, sweep or census.**

## 1. The hypothesis inventory

**A pass with no inventory is not a pass, so here is every binder of every theorem under review, against the object it applies to.**

### 1.1 [finrank_ker_incidence](../lean/HamiltonsCubic/Results/L177Statement.lean#L64)

| binder | what it constrains | checked against the record's object |
| --- | --- | --- |
| `{V E : Type*}` | vertices and edges as bare types | **matches**, the record's $V$ and $E$ are index sets and nothing more is used |
| `[Fintype V] [Fintype E]` | finiteness | **needed and correct**, `Fintype.card` and `Module.finrank_fintype_fun_eq_card` both consume it |
| `[DecidableEq V]` | the `if v = …` branch in [incidence](../lean/HamiltonsCubic/Results/L177Statement.lean#L24) | **harmless**, every type carries it classically; it changes no mathematics |
| `ends : E → V × V` | each edge is an *ordered* pair of endpoints | **wider than the record's object.** It admits a loop ($(ends\ e).1=(ends\ e).2$) and parallel edges. At a loop the definition puts $1$ in the column, where the classical unsigned incidence matrix (Zaslavsky's all-negative $H$), puts $2$. So [incidence](../lean/HamiltonsCubic/Results/L177Statement.lean#L24) *is* the record's $N$ on loopless graphs and is a different matrix on graphs with loops. The record names looplessness as one of the two hypotheses it had left unstated, so this is a known gap now sitting inside a definition instead of a sentence. It causes no unsoundness, because every graph-theoretic claim enters through `hrank` and is asserted about whatever matrix the definition produces |
| `b : ℕ` | *intended*: $b(G)$. *Actual*: any natural satisfying `hrank` | **pinned, see §4**, `hrank` admits exactly one $b$, namely the corank |
| `hrank` | *intended*: Zaslavsky Theorem IV.1. *Actual*: the definition of $b$ as corank | **satisfiable at every `ends`, see §3** |
| conclusion | $\dim\ker N=\lvert E\rvert-\lvert V\rvert+b$ over $\mathbb Z$ | **matches L177(1)'s second conjunct**, and only that |

### 1.2 The L182 chain

Every theorem in the chain takes the single hypothesis `hn : 12 ≤ n` at `n : ℝ`, and the chain actually used is [theta0sq_lt_two](../lean/HamiltonsCubic/Results/L182Statement.lean#L64) and [three_halves_lt_theta0sq](../lean/HamiltonsCubic/Results/L182Statement.lean#L73) into [theta0_bounds](../lean/HamiltonsCubic/Results/L182Statement.lean#L80) into [lam_radicand_bounds](../lean/HamiltonsCubic/Results/L182Statement.lean#L87) into [lamInf_lt_lam](../lean/HamiltonsCubic/Results/L182Statement.lean#L97).

| theorem | hypothesis as written | hypothesis actually needed | the record's own range |
| --- | --- | --- | --- |
| [theta0sq_lt_two](../lean/HamiltonsCubic/Results/L182Statement.lean#L64) | $12\le n$ | $n>2/3$ |, |
| [three_halves_lt_theta0sq](../lean/HamiltonsCubic/Results/L182Statement.lean#L73) | $12\le n$ | $n>6+2\sqrt7$ or $n<6-2\sqrt7$ | $n\ge12$ even |
| [theta0_bounds](../lean/HamiltonsCubic/Results/L182Statement.lean#L80) | $12\le n$ | $n>6+2\sqrt7$ | $n\ge12$ even |
| [lam_radicand_bounds](../lean/HamiltonsCubic/Results/L182Statement.lean#L87) | $12\le n$ | $n>6+2\sqrt7$ | $n\ge12$ even |
| [lamInf_lt_lam](../lean/HamiltonsCubic/Results/L182Statement.lean#L97) | $12\le n$ | $n>6+2\sqrt7$ | $n\ge12$ even |

**The hypothesis is load-bearing everywhere and is nowhere the minimal one.** *That $\lambda$'s domain begins at the crossover $6+2\sqrt7$ is the record's own correction to an earlier draft that read the monotonicity threshold $n>4/3$ as the domain; the Lean file takes $12$, which is inside the domain and inside the record's range, so it over-restricts in the safe direction.* **`n : ℝ` with no evenness and no integrality is wider than the record's even integers**, which is the direction the file's own docstring calls *the unsafe direction*, and it is the safe direction for these five theorems, because each is proved for all real $n\ge12$ and none of them needs $F$.

## 2. Item 1, is `finrank_ker_incidence` the record's L177(1)?

**The record's L177(1) is a conjunction and the Lean theorem is its second conjunct.** [findings/diagonal-half.md](../findings/diagonal-half.md#L593) states it as *"The coordinate-diagonal Weyl tensors supported inside $G$ are exactly $\ker N$, so their space has dimension $\lvert E\rvert-\lvert V\rvert+b(G)$"*, an identification, then a count that follows from it.

**The identification appears in no Lean statement in the file.** There is no Weyl tensor, no coordinate-diagonal locus, no notion of support and no graph anywhere in [L177Statement.lean](../lean/HamiltonsCubic/Results/L177Statement.lean): the file's entire vocabulary is a matrix built from `ends`, its `mulVec`, its rank and its kernel. [mulVec_apply_eq](../lean/HamiltonsCubic/Results/L177Statement.lean#L30) is the nearest thing, and it states the expansion of `mulVec` into a sum, which is the *row-sum reading* of the kernel condition and not its identification with a locus of tensors.

**The map and its domain are right.** `Matrix.mulVecLin (incidence ends)` has type $(E\to\mathbb R)\to_{\ell}(V\to\mathbb R)$, so its domain is the edge weights, of dimension $\lvert E\rvert$, which is what the count needs, and it is the space the record's $x\in\mathbb R^E$ lives in. **The `rfl` at [line 70](../lean/HamiltonsCubic/Results/L177Statement.lean#L70) is genuine**: `Matrix.rank` is *defined* in Mathlib as the finrank of `mulVecLin`'s range, so `hrank` feeds the rank–nullity identity with no coercion of meaning.

**Verdict.** *Confirmed as the dimension half; refuted as L177(1) entire.* **The defect is the docstring rather than the theorem**, see §9.1.

## 3. Items 3 and 2, satisfiability, with a witness that has an edge

### 3.1 `hrank` holds at every `ends`, not merely at some

$\mathop{\mathrm{rank}}N\le\lvert V\rvert$ for any $V\times E$ matrix, the rank being at most the number of rows. So $b:=\lvert V\rvert-\mathop{\mathrm{rank}}N$ is a natural number and the cast $((\lvert V\rvert-\mathop{\mathrm{rank}}N:\mathbb N):\mathbb Z)$ equals $\lvert V\rvert-\mathop{\mathrm{rank}}N$ over $\mathbb Z$, which is `hrank`. **Screen A** elaborated exactly this, `∀ ends, ∃ b : ℕ, ((incidence ends).rank : ℤ) = (Fintype.card V : ℤ) - b`, by `Matrix.rank_le_card_height` and `omega`, and it elaborated clean.

### 3.2 The witness with an edge, in closed form

**Take $V=\{0,1\}$, $E=\{e\}$, $ends\ e=(0,1)$, the single edge $K_2$.** Then $N=\begin{pmatrix}1\\1\end{pmatrix}$, and $Nx=(x_e,x_e)$, so $Nx=0$ forces $x_e=0$ and $\ker N=0$. By rank–nullity $\mathop{\mathrm{rank}}N=\lvert E\rvert-0=1$. And $K_2$ is connected and bipartite, so $b(K_2)=1$ and $\lvert V\rvert-b=2-1=1=\mathop{\mathrm{rank}}N$: **`hrank` holds at $b=1$, and the $b$ that satisfies it is the genuine bipartite-component count rather than a fitted constant.** The conclusion then reads $\dim\ker N=1-2+1=0$, which is the kernel just computed. **Screen B** elaborated the two load-bearing steps of this ($\ker=\bot$ and hence $\mathop{\mathrm{rank}}=1$), at exactly this instance.

**Both screens were run in one scratch file with a deliberate control**, `example : (1:Nat) = 2 := by rfl`, appended afterwards; the file elaborated with exit code $0$ before the control and failed on the control alone, so the clean elaboration is a fact about the examples and not about a mis-invoked tool.

**So the brief's degenerate $\lvert E\rvert=0$ witness is superseded**: the theorem is exercised at a graph with an edge, and the answer to *how much does the theorem say* is settled in §4 rather than by non-vacuity.

### 3.3 Item 2, the $\mathbb Z$ form, and $K_2$ as the exact counterexample to the $\mathbb N$ form

$\dim\ker N=\lvert E\rvert-\mathop{\mathrm{rank}}N=\lvert E\rvert-(\lvert V\rvert-b)=\lvert E\rvert-\lvert V\rvert+b$ over $\mathbb Z$, with every step total. **$K_2$ is an exact counterexample to the withdrawn $\mathbb N$ statement**: $\lvert E\rvert-\lvert V\rvert+b$ evaluates over $\mathbb N$ to $(1-2)+1=0+1=1$, against the true kernel dimension $0$. *So the file's account of why the earlier version was false is correct, and it is false already at the smallest graph carrying an edge.*

**The casts hide nothing further.** There are exactly three: `((incidence ends).rank : ℤ)`, `(Fintype.card V : ℤ)` and `(b : ℕ) : ℤ` in the hypothesis, and the same pattern on `Module.finrank` and `Fintype.card E` in the conclusion. Each is `Nat.cast` on a quantity that is a natural for a structural reason (a rank, a cardinality, a finrank, a binder) and `omega` closes the goal by linear arithmetic over $\mathbb Z$ with the cast facts, which is where a truncation would have had to hide.

## 4. Item 4, $b$ is pinned, and that is the finding

**Nothing needs to stop $b$ from exceeding $\lvert V\rvert$, because `hrank` already does.** From $\mathop{\mathrm{rank}}N\ge0$ and `hrank`, $b=\lvert V\rvert-\mathop{\mathrm{rank}}N\le\lvert V\rvert$; from $\mathop{\mathrm{rank}}N\le\lvert E\rvert$, also $b\ge\lvert V\rvert-\lvert E\rvert$. **The hypothesis determines $b$ uniquely**, so a caller cannot choose one, cannot make the conclusion absurd, and cannot make it vacuous.

**The same fact is the theorem's real limitation, and it is the sharpest thing in this report.** *A hypothesis that every graph satisfies restricts no graph.* Read literally, `finrank_ker_incidence` says: **for any $V\times E$ real matrix of this shape, $\dim\ker=\lvert E\rvert-\mathop{\mathrm{rank}}$**, rank–nullity, with $b$ a name for the corank. Zaslavsky's content is the identification of that corank with $b(G)$, and **that identification is precisely what the Lean statement cannot see**, since $b$ is bound by an existential the caller discharges however it likes.

**Argued the opposite, as the protocol requires.** The strongest defence the words support is that this is exactly the intended division of labour and that the file says so: the docstring calls the rank identity *"classical … and enters as a hypothesis rather than a derivation"*, and [lean/INDEX.md](../lean/INDEX.md#L9) has a stated convention (*a quoted input enters as a hypothesis only when it is classical and external*), under which quoting Zaslavsky this way is correct practice and a `sorry` would be wrong. **That defence holds and I do not report a defect here.** *What it does not license is reading the theorem as machine-checking any part of L177's graph theory; the index row at [line 42](../lean/INDEX.md#L42) says as much in its last sentence, and that sentence is the one a reader must not skip.*

## 5. Item 5, is `lamInf_lt_lam` the record's claim?

**It is one of the record's two factors, over a narrower range, in a wider type, and it is not L182.**

- **L182 is $\lambda(n)F(n)>\lambda_\infty F(12)>0.5923$ at every even $n\ge12$.** Both theorems stating that, [lam_mul_F_gt](../lean/HamiltonsCubic/Results/L182Statement.lean#L117) and [lam_mul_F_floor](../lean/HamiltonsCubic/Results/L182Statement.lean#L125), remain `sorry`, and the file is honest about it.
- **The record's $\lambda$ half is *"$\lambda$ decreases and exceeds its limit"*, and Lean proves the second clause only.** No monotonicity of $\lambda$, of $\theta_0$ or of $\theta_0^2$ is a theorem anywhere in the file.
- **The Lean proof is nonetheless better than the record's**, which is worth saying plainly: $\lambda(n)>\lambda_\infty$ follows from the single inequality $\theta_0(n)<\sqrt2$ and needs no monotonicity at all. *The record reaches the same conclusion through a monotonicity argument whose sign reversal it flags as the step such arguments usually get wrong; the Lean file routes around that step entirely.*
- **The range is narrower than the record's $\lambda$ claim.** The record says $\lambda(n)>\lambda_\infty$ *at every finite $n$* in $\lambda$'s domain, i.e. $n>6+2\sqrt7$; Lean says it at $n\ge12$.
- **The type is wider, and here that is safe.** `n : ℝ` admits odd and non-integer $n$; the record restricts to even $n$ **because of $F$**, which does not appear in this theorem. So the parity restriction has no purchase on `lamInf_lt_lam`, and the docstring's warning about *the unsafe direction*, correctly attached to [lam_mul_F_gt](../lean/HamiltonsCubic/Results/L182Statement.lean#L117), where $F$ is present, does not transfer to it.

**Verdict.** *Confirmed as the $\lambda$ half of the product bound; weaker than L182, which stays owed.*

## 6. Item 6, the two bounds, checked by hand

### 6.1 [theta0sq_lt_two](../lean/HamiltonsCubic/Results/L182Statement.lean#L64)

At $n\ne0$, $\theta_0(n)^2<2$ iff $2(n-1)(n-2)<2n^2$ iff $n^2-3n+2<n^2$ iff $-3n+2<0$ iff $n>2/3$. **The proof is honest**: `div_lt_iff₀` consumes $0<n^2$, supplied by `positivity` from `hn0 : 0 < n`, and the residual goal $2(n-1)(n-2)<2n^2$ is linear after expansion, well within `nlinarith`. **The exact truth set of the Lean proposition is $\{n>2/3\}\cup\{0\}$**, the junk point $n=0$ is in it because `theta0sq 0 = 4/0 = 0 < 2`. $12\le n$ sits inside with room.

### 6.2 [three_halves_lt_theta0sq](../lean/HamiltonsCubic/Results/L182Statement.lean#L73)

At $n\ne0$, $\theta_0(n)^2>3/2$ iff $3n^2<4(n-1)(n-2)$ iff $3n^2<4n^2-12n+8$ iff $n^2-12n+8>0$. **This is the record's crossover exactly.** The proof mirrors the first, with `lt_div_iff₀` and the same `positivity` side goal, and the residual is the quadratic. **The exact truth set is $\{n<6-2\sqrt7\}\cup\{n>6+2\sqrt7\}$ minus $\{0\}$**, $n=0$ drops out because `theta0sq 0 = 0`. $12\le n$ lands in the upper branch.

**Both hypotheses are used and neither is minimal.** `hn` enters twice in each proof, through `hn0` into `positivity` and directly into `nlinarith`; deleting it leaves both goals false (at $n=1/2$ and at $n=6$ respectively). **The over-restriction is deliberate and matches the record's range**, so it is an observation and not a defect.

## 7. Item 7, the crossover, exactly

- **Roots.** $n^2-12n+8=0$ has discriminant $144-32=112=4\cdot28=16\cdot7$, so $n=\dfrac{12\pm4\sqrt7}{2}=6\pm2\sqrt7$. **Confirmed exactly.**
- **The decimal.** $\sqrt7=2.6457513110645905905\ldots$, so $6+2\sqrt7=11.2915026221291811\ldots$, which rounds to $11.2915$. **Confirmed**, and the docstring quotes it to four places without asserting equality, which is the right register.
- **The margin at $n=12$.** $12-(6+2\sqrt7)=6-2\sqrt7$, **which is the other root**, the roots sum to $12$, so the distance from $12$ to the upper root is the lower root itself, $0.7084973778708188\ldots$. *That is a cleaner statement of the margin than "a margin" and it is exact.*
- **The value at $n=12$.** $n^2-12n+8=8>0$, and equivalently $\theta_0(12)^2=\dfrac{2\cdot11\cdot10}{144}=\dfrac{220}{144}=\dfrac{55}{36}$, exceeding $3/2=\dfrac{54}{36}$ by exactly $\dfrac1{36}$, **which reproduces the record's own stated margin** at [findings/second-order.md](../findings/second-order.md#L1622). The two files agree.

**Verdict.** *Confirmed on every clause, with the margin sharpened to a radical.*

## 8. Item 8, the square roots, and where a junk value could have hidden

**`Real.sqrt` of a negative is $0$ in Mathlib, and $x/0=0$, so both idioms can make a false inequality provable. Neither is leaned on here.**

- **[theta0_bounds](../lean/HamiltonsCubic/Results/L182Statement.lean#L80), lower half.** `Real.sqrt_lt_sqrt` takes $0\le x$ and $x<y$. Here $x=3/2$, and $0\le3/2$ is `norm_num`. **Honest.**
- **Upper half.** $x=\theta_0(n)^2$, and $0\le\theta_0(n)^2$ is obtained by `linarith` **from the already-proved $3/2<\theta_0(n)^2$**, not from a positivity extension that might have been vacuous. **Honest, and this is the step where the junk value would have entered had $\theta_0(n)^2$ been allowed to go negative.**
- **[lam_radicand_bounds](../lean/HamiltonsCubic/Results/L182Statement.lean#L87).** Both parts are `linarith` from the two bounds, multiplying by the positive constant $9$. **Honest.**
- **$\lambda_\infty$ is not a junk value, and the file proves it without saying so.** Were $9(\sqrt2-\sqrt{3/2})\le0$, `Real.sqrt` would return $0$, `lamInf` would be $2/0=0$, and `lamInf < lam n` would be a statement about $0$. But the two components of [lam_radicand_bounds](../lean/HamiltonsCubic/Results/L182Statement.lean#L87) give $0<9(\theta_0(n)-\sqrt{3/2})<9(\sqrt2-\sqrt{3/2})$, so the limiting radicand is positive by transitivity, and `lamInf` is $2$ over a genuine positive square root. **The final step is then real division**: `div_lt_div_of_pos_left` consumes $0<2$, $0<\sqrt{9(\theta_0(n)-\sqrt{3/2})}$, from `Real.sqrt_pos` on the proved positivity, and the strict inequality of the two roots, and returns $2/\text{larger}<2/\text{smaller}$, which is $\lambda_\infty<\lambda(n)$ with the roots in the right places. **Checked orientation by hand; it is right.**
- **Where the junk *would* bite, and why the hypothesis is load-bearing.** At $n=5$, $\theta_0(5)^2=\dfrac{2\cdot4\cdot3}{25}=\dfrac{24}{25}<\dfrac32$, so $\theta_0(5)<\sqrt{3/2}$, the radicand is negative, `Real.sqrt` returns $0$ and `lam 5 = 2/0 = 0`. Since $\lambda_\infty>0$, **`lamInf < lam n` is FALSE at $n=5$**, so the theorem is not an artefact of the junk convention, and $12\le n$ cannot be weakened past the crossover.

## 9. Item 9, three docstrings claim more than their theorems

**All three clear the discrepancy protocol: each is located at a line, each failure is exhibited against the theorem's actual goal, and the strongest defence is stated and found wanting.**

### 9.1 [finrank_ker_incidence](../lean/HamiltonsCubic/Results/L177Statement.lean#L57)'s headline

*Located.* The docstring's first sentence: **"L177(1). The tensors supported inside $G$ are exactly $\ker N$, of dimension $\lvert E\rvert-\lvert V\rvert+b(G)$."**

*Exhibited.* The theorem's goal contains `Module.finrank`, `LinearMap.ker`, `Matrix.mulVecLin`, `Fintype.card` and `Int`, no tensor, no locus, no support, no graph. **"Are exactly $\ker N$" is asserted by the headline and stated by no proposition in the file.**

*The opposite argued.* The label "L177(1)" can be read as a *pointer* to the record's item rather than a claim to have typed it, and the body of the same docstring narrows honestly, *"Given it, the dimension count is rank–nullity on `mulVecLin N`"*. **That defence carries the paragraph and not the headline**, which is the sentence a reader skimming the file will take away.

*Verdict.* **UPHELD, minor**, a documentation defect in the class the brief names, not a soundness defect.

### 9.2 [deriv_in_u_neg](../lean/HamiltonsCubic/Results/L182Statement.lean#L54)

*Located.* Line 53's docstring: **"The derivative in $u=1/n$ is negative below $3/4$, so $\theta_0^2$ increases in $n$."** Line 54's statement: `theorem deriv_in_u_neg {u : ℝ} (h : u < 3 / 4) : 2 * (-3 + 4 * u) < 0`.

*Exhibited.* The statement mentions no derivative, no $\theta_0$, no $n$ and no monotonicity: it is *"a linear function of a free real is negative on a half-line"*, closed by `linarith`. Nothing connects `2 * (-3 + 4 * u)` to $\dfrac{d}{du}\,2(1-3u+2u^2)$ except the reader.

*The opposite argued.* The file's L177 counterparts do the same thing and are honest about it, [bipartite_sign_kills_edge](../lean/HamiltonsCubic/Results/L177Statement.lean#L39) is documented as *"the arithmetic behind"* its mechanism and adds **"This is $(1)+(-1)=0$ and nothing more … it is not the first half of $\mathop{\mathrm{rank}}N=\lvert V\rvert-b$, which quantifies over components and edges; a docstring here claimed it was."** *So the layer already knows this failure mode and has the correction written down for the neighbouring file.* **[deriv_in_u_neg](../lean/HamiltonsCubic/Results/L182Statement.lean#L54) carries no such disclaimer, and its "so" asserts the monotonicity conclusion outright.**

*Verdict.* **UPHELD, minor**, and it is the same defect the L177 file was already repaired for.

### 9.3 [theta0sq_lt_two](../lean/HamiltonsCubic/Results/L182Statement.lean#L62)'s range

*Located.* The docstring: **"$\theta_0(n)^2<2$ at every $n>2/3$"**, above a theorem whose hypothesis is $12\le n$.

*Exhibited.* The claim is **true** (§6.1) and is **not the theorem**. A reader taking the docstring for the statement would believe a bound available at $n=1$ that the file does not provide.

*The opposite argued.* The docstring is describing the mathematics and the following clause gives the reason (*"$(n-1)(n-2)=n^2-3n+2<n^2$"*) which is the general argument, so the range is the argument's and the hypothesis is the chain's. **A fair reading, and it is why this is minor rather than a misstatement**; the neighbouring [three_halves_lt_theta0sq](../lean/HamiltonsCubic/Results/L182Statement.lean#L73) states its range as $n\ge12$, matching its theorem, so the file is inconsistent with itself between adjacent declarations.

*Verdict.* **UPHELD, minor.**

### 9.4 What is honest, recorded because silence is not a verdict

[bipartite_sign_kills_edge](../lean/HamiltonsCubic/Results/L177Statement.lean#L39), [odd_walk_forces_zero](../lean/HamiltonsCubic/Results/L177Statement.lean#L45) and [dim_ker_eq](../lean/HamiltonsCubic/Results/L177Statement.lean#L52) all disclaim explicitly and correctly; [lam_mul_F_gt](../lean/HamiltonsCubic/Results/L182Statement.lean#L117) and [lam_mul_F_floor](../lean/HamiltonsCubic/Results/L182Statement.lean#L125) both say what the `sorry` owes, and the second exists **only** to record that the record's floor $0.5923$ is a separate claim from the comparison, *which is a good catch by whoever wrote it and the kind of thing this layer usually omits*. Both module headers describe the record accurately.

### 9.5 An observation, not a finding, seven dead theorems

**[mulVec_apply_eq](../lean/HamiltonsCubic/Results/L177Statement.lean#L30), [bipartite_sign_kills_edge](../lean/HamiltonsCubic/Results/L177Statement.lean#L39), [odd_walk_forces_zero](../lean/HamiltonsCubic/Results/L177Statement.lean#L45), [dim_ker_eq](../lean/HamiltonsCubic/Results/L177Statement.lean#L52), [theta0sq_eq](../lean/HamiltonsCubic/Results/L182Statement.lean#L48), [deriv_in_u_neg](../lean/HamiltonsCubic/Results/L182Statement.lean#L54) and [product_bound](../lean/HamiltonsCubic/Results/L182Statement.lean#L59) are invoked by no proof in the layer.** In particular [finrank_ker_incidence](../lean/HamiltonsCubic/Results/L177Statement.lean#L64) closes with `omega` rather than through [dim_ker_eq](../lean/HamiltonsCubic/Results/L177Statement.lean#L52), and [product_bound](../lean/HamiltonsCubic/Results/L182Statement.lean#L59) waits on a `sorry`. *They are documentation of the argument's shape rather than parts of it, which is legitimate and worth knowing when reading the index's counts of "steps proved".* **The chain that is live is the five-theorem one in §1.2, and it really is a chain.**

## 10. Item 10, the index rows

**The row itself is accurate.** [lean/INDEX.md line 42](../lean/INDEX.md#L42) marks L177 (statement) **proved**, and in this table `proved` means *a Lean theorem with no `sorry`*, which [finrank_ker_incidence](../lean/HamiltonsCubic/Results/L177Statement.lean#L64) is. **The row states the hypothesis explicitly**, *"taking $\mathop{\mathrm{rank}}N=\lvert V\rvert-b$ as an explicit hypothesis … classical, Zaslavsky Thm IV.1, quoted rather than derived"*, and closes with the sentence that answers the brief's question directly: *"The graph-theoretic half stays outside Lean, so what is checked is the counting and not the identity it counts with."* **Given §4, that is exactly right and I confirm it.**

**Three things around it are wrong.**

1. **[Line 425](../lean/INDEX.md#L425) and [line 436](../lean/INDEX.md#L436) contradict the row.** Both still say L177 carries *"the statement with a declared `sorry`"*; commit `d7f6e283` removed it, and `grep sorry` over [L177Statement.lean](../lean/HamiltonsCubic/Results/L177Statement.lean) now returns nothing. **Line 436's headline "ALL FOUR ARE NOW TYPED, AND ONE IS PROVED" is stale by the same commit, two now are.** *Defence considered: these lines sit in a retrospective section about which results were escapes, so a reader might grant them a historical tense. The tense they use is the present, and line 436 is a count, so the defence fails.*
2. **[Line 42](../lean/INDEX.md#L42) credits what the file retracts.** It lists among the proved *"the two mechanisms behind $\mathop{\mathrm{rank}}N=\lvert V\rvert-b$, a bipartite component's sign vector annihilating each edge and an odd closed walk forcing $\epsilon_v=-\epsilon_v$"*, while the file's docstrings say of exactly those two theorems that each *"is not"* the corresponding half of the rank identity. **The word "behind" is a real defence** and is the file's own word, but the sentence's frame is *"Proved: …"*, which is the claim the file went out of its way to withdraw. *Verdict: UPHELD, minor, and it is a one-word fix.*
3. **[Line 51](../lean/INDEX.md#L51), the L182 row, was never updated.** Commit `87911678` touched the `.lean` file alone. The row still reads state **stated** with *"Proved: $\theta_0^2=2(1-3/n+2/n^2)$, the derivative sign under $u=1/n$, and the crude product bound"*, three steps, where the file now proves eight and, more to the point, **proves one of the product bound's two factors outright**. *The row understates the work rather than overstating it, which is the rarer direction and still leaves the index wrong.*

**One adjacent staleness, found while counting.** [Line 440](../lean/INDEX.md#L440) says *"1525 theorems, of which four carry a `sorry`"*; the only real `sorry` terms left in the layer are the two in [L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean#L118), the other matches under `grep` are the word inside docstrings. **I did not repair it, per the brief.**

## 11. What would falsify each theorem, and what I did to look

| theorem | what would falsify it | what I did |
| --- | --- | --- |
| [finrank_ker_incidence](../lean/HamiltonsCubic/Results/L177Statement.lean#L64) | an `ends` and a $b$ satisfying `hrank` with $\dim\ker\ne\lvert E\rvert-\lvert V\rvert+b$ | **nothing can**, it is rank–nullity over $\mathbb Z$ and the kernel has checked it. I instead attacked the *reading*: constructed $K_2$ by hand and screened it, and screened universal satisfiability of `hrank`, which located the theorem's content precisely (§4) |
| the record's **L177(1)**, which the docstring claims | a graph where the coordinate-diagonal locus differs from $\ker N$, or where $\mathop{\mathrm{rank}}N\ne\lvert V\rvert-b(G)$ | **unreachable from this file**, no such object is expressible in it. I checked [incidence](../lean/HamiltonsCubic/Results/L177Statement.lean#L24) against the classical $N$ and found the loop convention differs (§1.1), which is the one place a mismatch could enter |
| [theta0sq_lt_two](../lean/HamiltonsCubic/Results/L182Statement.lean#L64) | an $n\ge12$ with $-3n+2\ge0$ | solved the inequality exactly: truth set $n>2/3$, so nothing at $n\ge12$ |
| [three_halves_lt_theta0sq](../lean/HamiltonsCubic/Results/L182Statement.lean#L73) | an $n\ge12$ inside $[6-2\sqrt7,6+2\sqrt7]$ | solved the quadratic in radicals; the interval's right end is $11.2915\ldots<12$, margin exactly $6-2\sqrt7$ |
| [theta0_bounds](../lean/HamiltonsCubic/Results/L182Statement.lean#L80) | a `Real.sqrt_lt_sqrt` application whose $0\le x$ side goal came from a vacuous positivity | read both applications' side goals; each is discharged from a proved bound (§8) |
| [lamInf_lt_lam](../lean/HamiltonsCubic/Results/L182Statement.lean#L97) | an $n\ge12$ with $\theta_0(n)\le\sqrt{3/2}$, which would make `lam n` the junk $0$; or $\sqrt2\le\sqrt{3/2}$, which would make `lamInf` junk | both excluded, the first by the crossover with margin $6-2\sqrt7$, the second by $3/2<2$ and transitivity inside [lam_radicand_bounds](../lean/HamiltonsCubic/Results/L182Statement.lean#L87). Confirmed the junk case is *real* below the crossover by evaluating $\theta_0(5)^2=24/25$ exactly, where the proposition is **false** |
| **L182 itself** | any even $n\ge12$ with $F(n)<F(12)$, or the floor $0.5923$ exceeding $\lambda_\infty F(12)$ | **untouched here, and correctly so**, it is behind two `sorry`s, and the record localises the whole falsifier set onto $F(n)\ge F(12)$, quoted from L162 |

## Verdict

**CONFIRMED AS PROVED, WEAKER THAN NAMED, WITH SIX DOCUMENTATION DEFECTS.**

- **The mathematics is sound.** Both new theorems are true, both proofs are correct step by step, every hypothesis is used, no square-root or division junk value is leaned on anywhere, and the crossover arithmetic is exact and agrees with the record.
- **Neither theorem is the result it is named for.** [finrank_ker_incidence](../lean/HamiltonsCubic/Results/L177Statement.lean#L64) is L177(1)'s dimension conjunct with $b$ pinned as the corank, so it imports no graph theory; [lamInf_lt_lam](../lean/HamiltonsCubic/Results/L182Statement.lean#L97) is one factor of L182's product bound, which stays a `sorry`.
- **The six defects are all documentation**: three docstrings (§9.1, §9.2, §9.3) and three index claims (§10), none touching a proof. **I repaired nothing**, per the brief.
- **The one substantive thing the layer should decide** is whether a hypothesis satisfiable at every instance is the right way to quote a classical theorem. [lean/INDEX.md line 9](../lean/INDEX.md#L9) already has the convention and the argument for it; §4 supplies the sharpest statement of its cost, which is that the quoted content becomes invisible to the kernel rather than merely unproved by it.
