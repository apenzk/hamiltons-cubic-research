# r768, Gate 2 on [Lemma L175](../findings/bounds-relaxations.md)'s $(A),(B)$ fence, and on the rewritten letter-$M$ bullet in [conventions.md](../findings/conventions.md)

*The brief was read cold and in full before any file was opened. **No numerical work was done**: every value below is exact (rational, symbolic, or a dimension count) and the only machine time spent was `lake build` on the record's own Lean layer plus four screening statements written into a scratch file that has been deleted. Log: [agent_logs/g2-l175-r768.log](../agent_logs/g2-l175-r768.log).*

## Claim table

| # | Claim, as the record states it | Verdict |
| --- | --- | --- |
| 1a | $\theta$ occurs in (C) and nowhere else; (A$_i$)'s right side is $2(n-2)$ and (B$_i$)'s is $-2\nu_i$ | **PROVEN** |
| 1b | The feasible set cut out by (A) and (B) does not move with $\theta$ | **PROVEN, and empty of content** |
| 1c | *"Any bound derived from membership in it alone holds at every $\theta$ at once, which is to say it bounds nothing"* | **BROKEN AS WRITTEN** |
| 1d | *"Hence no Schur-convexity argument from the SDIEP toolbox reaches $\theta$, every object that toolbox produces being built from (A) and (B)"* | **HYPOTHESIS-DEBT**, the "hence" does not follow, and the premise has no argument on file |
| 1e | The majorisation half (the subset-sum family is exactly $-\lambda/(n-2)\prec\lambda$), is a recognition and stands | **PROVEN** |
| 1f | [L175.lean](../lean/HamiltonsCubic/Results/L175.lean) checks what its docstring says it checks | **BROKEN**, two of its four theorems state nothing, and one is vacuously hypothesised |
| 2a | The two conventions bullets are inconsistent, so the tabled one is wrong as written | **GAP**, inconsistent as *table entries*, but a scope reading on which the original stands does exist |
| 2b | The repair's reason: *"$K$ captures only the entries $W_{abab}$, so equality is exactly the case where those determine $W$"* | **BROKEN**, the inequality half is right, the equality half is refuted |
| 2c | The conclusion the repair reaches: $\lVert K\rVert_F^2\le2$, $=2$ iff $W$ is coordinate-diagonal in that frame | **PROVEN** |
| 2d | The consequence: off the diagonal locus, [L94](../findings/bispectral.md) read at the sectional matrix would give $\kappa^2\le4$ | **PROVEN** |

**Overall verdict: BROKEN.** The clause the plan cites when it closes [I17](../plan.md) is the one clause of L175 that a bound already on this record contradicts, and the conventions repair reaches a true conclusion by a reason that is false.

**Actionable summary, one line.** Withdraw L175's *"which is to say it bounds nothing"* and the *"hence"* that hangs on it, the record's own $\Pi$-bound is a convexity argument over the $(A),(B)$ marginals that does reach $\theta$, and replace the conventions bullet's *"where those determine $W$"* with *"where those exhaust $W$'s norm"*, which is the true equality condition.

## 0. Conventions, fixed once

- **Sums are ordered** unless said otherwise, per [conventions.md](../findings/conventions.md) line 136. So (A) reads $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$ and $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$.
- **$T_{abc}=c_{abc}^2$** with $c_{abc}=\langle[v_a,v_b],v_c\rangle$ in an orthonormal eigenbasis of $W$ on $\Lambda^2\mathbb R^n$; $T\ge0$, totally symmetric, hollow. $N=\binom n2$.
- **$\lambda$ is the $\Lambda^2$ spectrum**, $\nu_1,\dots,\nu_d$ its distinct values with multiplicities $m_j$, $\sum_jm_j\nu_j=0$, $\sum_jm_j\nu_j^2=1$. $\mu_j=m_j-\delta_{ij}$ inside row $i$.
- **$\theta$ is a variable of the relaxation**, not a function of $\lambda$: $\Pi(\lambda)$ is a set of *pairs* $(T,\theta)$, per [L104](../findings/bounds-relaxations.md).
- **$W$ as an operator on $\Lambda^2$** carries $\operatorname{tr}(W^2)=1$ at unit norm; $K_{ab}=W_{abab}$ is the $n\times n$ sectional matrix, whose entries are $W$'s **diagonal** in the pair basis $\{\varphi_{ab}\}_{a<b}$ of the frame ([conventions.md](../findings/conventions.md) line 88, half-trace pairing, $\lVert\varphi_{ab}\rVert=1$).
- **All arithmetic below is exact.** No sweep, census, optimisation or falsifier hunt was run; the four Lean statements in §4 were screened as screens and are reported as such.

## 1. Hypothesis inventory

**Claim 1 consumes, and the block states, none of these but the first:**

| # | Hypothesis | Where it binds | Stated in the block? |
| --- | --- | --- | --- |
| H1 | $\nu_i\ne0$ | the "(C) determines $\theta$" half, at a zero row (C$_i$) reads $0=0$ | **yes**, in the proof |
| H2 | Every $m_j\ge3$ | the variable count $\binom{d+2}3$; inherited from [L104](../findings/bounds-relaxations.md)'s admissibility caveat | no, idle here, since the fence is about right-hand sides |
| H3 | $\Pi(\lambda)\ne\varnothing$ | *"a constraint set independent of $\theta$ is satisfied by data $T$ irrespective of $\theta$"* is a statement about a **nonempty** set; at the $(26,2)$ spectrum [L104](../findings/bounds-relaxations.md) proves $\Pi(\lambda)=\varnothing$ | **no**, and it is where the sentence's only true reading lives |
| H4 | "the SDIEP toolbox" has a fixed extension | the whole of clause 1d | **no**, and this is the debt |
| H5 | $\theta$ is not otherwise related to $T$ | clause 1c. **Refuted by (C) itself**, which is in the same system | **no** |

**Claim 2 consumes:**

| # | Hypothesis | Where it binds | Stated? |
| --- | --- | --- | --- |
| H6 | $\operatorname{tr}(W^2)=1$, $W$ the $\Lambda^2$ operator | the numeral $2$ in $t\le2$ | **yes**, in the same bullet |
| H7 | $K$'s entries are $W$'s pair-basis diagonal in the frame $F$ | the whole derivation; it is what makes $t=2\lVert\operatorname{diag}W\rVert^2$ | implicit, and tabled at line 138 |
| H8 | The bullet is read as a **global** glossary entry rather than as scoped to [diagonal-half.md](../findings/diagonal-half.md) | the claim that the original is *wrong* rather than merely unscoped | **no**, see §7 |

## 2. Item 1, $\theta$ is absent from (A) and (B), checked at source

**Verdict: the claim holds, and nothing carries $\theta$ in through the back.** At source, [bounds.md](../findings/bounds.md) line 266:

$$\text{(A)}\ \sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2),\qquad \text{(B)}\ \sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k,\qquad \text{(C)}\ \sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k).$$

Three routes by which $\theta$ could enter (A) or (B), each closed:

1. **Through $\nu$.** $\nu$ is the multiset of distinct values of $\operatorname{spec}(W)$ on $\Lambda^2$. It is the datum $\Pi(\lambda)$ is fixed at, and $\theta$ is a coordinate of the polytope over it. No definitional dependence in either direction inside the relaxation.
2. **Through the normalisation.** The two normalisations in play are $\sum_jm_j\nu_j=0$ (tracelessness) and $\sum_jm_j\nu_j^2=1$ (unit norm). Neither mentions $\theta$.
3. **Through provenance.** (A) is [L153](../findings/bounds.md)'s Killing row marginal and is Böhm–Wilking's $I\#I=(n-2)I$; (B) is $W\#I=-W$, linear in $W$ and consuming first Bianchi and Ricci-flatness. (C) is the only one of the three that consumes **criticality**, $Q(W)=\theta W$, which is where $\theta$ is defined at all. So the location of $\theta$ is not an accident of presentation: it tracks which relation consumes criticality.

The value-type reduction preserves this. (A$_i$)'s right side is $2(n-2)$, (B$_i$)'s is $-2\nu_i$, (C$_i$)'s is $2\nu_i(\theta-\nu_i)$, the $G$-averaging of [L104](../findings/bounds-relaxations.md) touches only the left sides, and its own proof says so (*"$\Pi(\lambda)$ is $G$-stable with $\theta$ untouched"*).

**Item 1 clears.** Clause 1a is proven.

## 3. Item 2, the inference, pressed hardest

### 3.1 The reduction that makes the question sharp

Fix a row $i$ and set, for $j<k$ and for $j=k$,

$$c_{jk}:=2\mu_j\mu_k\,t_{ijk}\ \ (j<k),\qquad c_{jj}:=\mu_j(\mu_j-1)\,t_{ijj},$$

all $\ge0$ since $T\ge0$. Then the three row relations are one measure and three of its moments:

$$\text{(A}_i)\ \sum_{j\le k}c_{jk}=2(n-2),\qquad \text{(B}_i)\ \sum_{j\le k}c_{jk}X_{jk}=-2\nu_i,\qquad \text{(C}_i)\ \sum_{j\le k}c_{jk}Y_{jk}=2\nu_i(\theta-\nu_i),$$

with $X_{jk}=\tfrac{\nu_j+\nu_k}2$ and $Y_{jk}=\nu_j\nu_k$. *Check of the two off-diagonal coefficients, which is where a factor $2$ could hide.* (B$_i$)'s $j<k$ term is $\mu_j\mu_k(\nu_j+\nu_k)t_{ijk}=\tfrac{c_{jk}}2(\nu_j+\nu_k)=c_{jk}X_{jk}$, and its $j=k$ term is $\mu_j(\mu_j-1)\nu_jt_{ijj}=c_{jj}\nu_j=c_{jj}X_{jj}$, the same weight on both, which is the point [L104](../findings/bounds-relaxations.md) makes about "the two orders of a mixed pair". (C$_i$)'s $j<k$ term is $2\mu_j\mu_k\nu_j\nu_kt_{ijk}=c_{jk}\nu_j\nu_k=c_{jk}Y_{jk}$ and its $j=k$ term is $c_{jj}\nu_j^2=c_{jj}Y_{jj}$.

So with $p:=c/2(n-2)$ a probability measure, **(A) normalises $p$, (B) fixes $\mathbb E_p[X]=-\nu_i/(n-2)$, and (C) says $\mathbb E_p[Y]=\nu_i(\theta-\nu_i)/(n-2)$.**

### 3.2 The fence's own words, and what they forbid

Read the third moment identity in the direction the fence does not: **(C$_i$) is solvable for $\theta$.** At any row with $\nu_i\ne0$,

$$\theta\;=\;g_i(T)\;:=\;\nu_i+\frac{n-2}{\nu_i}\,\mathbb E_p[Y]\;=\;\nu_i+\frac1{2\nu_i}\Big(\sum_{j<k}2\mu_j\mu_k\nu_j\nu_kt_{ijk}+\sum_j\mu_j(\mu_j-1)\nu_j^2t_{ijj}\Big).$$

$g_i$ is a linear functional of $T$ **carrying no $\theta$**. Let $F:=\{T\ge0\ \text{totally symmetric, hollow}:\ \text{(A}_i),\text{(B}_i)\ \forall i\}$, the $\theta$-free feasible set the fence names. Then for every $(T,\theta)\in\Pi(\lambda)$ we have $T\in F$ and $\theta=g_i(T)$, so

$$\sup\{\theta:(T,\theta)\in\Pi(\lambda)\}\ \le\ \sup_{T\in F}\,g_i(T),$$

and the right-hand side is **finite**: (A) with $T\ge0$ gives $0\le c_{jk}\le2(n-2)$, so $\lvert\mathbb E_p[Y]\rvert\le\max_{j,k}\lvert\nu_j\nu_k\rvert\le\nu_{\max}^2$ and $g_i(T)\le\nu_i+(n-2)\nu_{\max}^2/\nu_i$; at $\nu_i=\nu_{\max}=h>0$ that is $\theta\le(n-1)h$, an exact closed form. **A $\theta$-free constraint set therefore bounds $\theta$, non-vacuously, and (A) alone suffices to do it.** The fence's clause 1c is false on the reading under which it says anything.

### 3.3 The counterexample is on this record, and it is a standing bound

The $\Pi$-bound. Take $m_-=\lambda_{\min}<0<\lambda_{\max}=h$ and use only convexity of the parabola on $[m_-,h]$: $Y_{jk}=\nu_j\nu_k\le X_{jk}^2\le(m_-+h)X_{jk}-m_-h$ for every admissible pair, since $X_{jk}\in[m_-,h]$ and the chord dominates $X\mapsto X^2$ there. Averaging against $p$ and substituting the two moments,

$$\frac{\nu_i(\theta-\nu_i)}{n-2}\ \le\ (m_-+h)\cdot\frac{-\nu_i}{n-2}-m_-h\quad\Longrightarrow\quad \nu_i(\theta-\nu_i)\ \le\ -(m_-+h)\nu_i-(n-2)m_-h .$$

At $\nu_i=h$, writing $m=\lvert m_-\rvert$: $h\theta-h^2\le-h^2+mh+(n-2)mh$, i.e. $\boxed{\theta\le(n-1)m}$. That is the $\Pi$-bound, exactly as [r649](REVIEW_r649.md) §1.2 records it and exactly as [L105](../findings/bounds-relaxations.md) uses it.

**Every inequality step in that derivation is a convexity step on a measure whose only constraints are (A) and (B).** (C) enters once, and only to name what $\mathbb E_p[Y]$ *is*. So:

- as an argument, it is precisely of the shape "convexity, consuming the marginals";
- the marginals it consumes are (A) and (B), exactly as the fence's closing box says convexity arguments do;
- and it **reaches $\theta$**.

**The strongest reading on which the fence survives**, which the brief asks me to argue. Read *"a bound derived from membership in it alone"* as: the only fact asserted about the pair $(T,\theta)$ is $T\in F$, with **no** functional relation between $T$ and $\theta$ named. Then the feasible pairs form $F\times\mathbb R$, whose projection to $\theta$ is all of $\mathbb R$, and no bound follows. That reading makes clause 1c true. It also makes it empty: it describes no argument anyone has proposed, it is refuted as a description of the $\Pi$-bound, and it cannot support the *"hence"* that follows, because the arguments the *"hence"* forecloses are exactly the ones that do name a function of $T$. **The lemma is true on a reading that carries none of its content and false on the reading that carries all of it.**

*One further hypothesis the sentence needs and does not state (H3).* *"A constraint set independent of $\theta$ is satisfied by data $T$ irrespective of $\theta$"* presupposes some $T$ satisfies it. [L104](../findings/bounds-relaxations.md) proves $\Pi(\lambda)=\varnothing$ at $n=8$ with multiplicities $(26,2)$, and proves infeasibility from **(A) and (B) alone** at every $d=2$ spectrum with a simple class at every $n\ge3$. At such a spectrum the $\theta$-free set bounds $\theta$ by $-\infty$ (the strongest bound there is), from (A) and (B) alone. That is a second, cleaner refutation of 1c: emptiness is a $\theta$-bound, it is proved on this record, and it is proved without (C).

**Verdict on item 2: the fence is too strong, and BROKEN as written.**

## 4. Item 4, the Lean file, read against the claim and run

`cd lean && PATH="$HOME/.elan/bin:$PATH" lake build` **succeeds**, 8996 jobs, no `sorry`. The file compiles; what it compiles is the question.

| theorem | what it says | verdict |
| --- | --- | --- |
| `C_determines_theta` | $2\nu(\theta-\nu)=2\nu(\theta'-\nu)\wedge\nu\ne0\Rightarrow\theta=\theta'$ | **real, and true.** Injectivity of an affine map with nonzero slope. It is the one statement here with content, and it supports clause 1a's second half |
| `A_theta_free` | `(2 * (n - 2) : ℝ) = 2 * (n - 2) := rfl`, with `θ θ' : ℝ` **unused** | **states nothing.** It is reflexivity of a term in which $\theta$ does not occur; the two $\theta$ binders are decoration. It holds verbatim with them erased, screened |
| `B_theta_free` | `(-2 * ν : ℝ) = -2 * ν := rfl`, same shape | **states nothing**, same reason |
| `theta_free_bounds_nothing` | `(∃ d, P d) ↔ (∃ d, P d) := Iff.rfl` | **states nothing at all.** It is $X\leftrightarrow X$ for an arbitrary `P`, with `θ θ'` unused. Screened: it discharges the same goal for a `P` chosen to pin $\theta$ maximally, so it distinguishes no `P` from any other |
| `bound_must_come_from_C` | from `h : ∀ d, P d → ∀ θ, θ ≤ f d` and `hd : P d`, concludes `∀ θ, θ ≤ f d`, by `h d hd` | **vacuous, and worse than vacuous.** Screened: `h d hd (f d + 1)` with `linarith` proves `False`. So the hypothesis is *unsatisfiable* whenever any `d` meets `P`, the theorem has no instance in which its antecedent holds and `P` is inhabited |

**Answering the brief's question directly: `theta_free_bounds_nothing` states nothing.** It is `Iff.rfl` on a proposition with no $\theta$ in it; its type is `(∃ d, P d) ↔ (∃ d, P d)`, provable for every `P` and every pair of reals, and it would be equally provable if (A), (B) and (C) all carried $\theta$. Nothing in the file is a formalisation of the fence.

*The four screens above were written into a scratch file inside the project, compiled with `lake env lean` (exit 0), and the file was deleted. They are screens on objects I constructed, reported as screens, and none is offered as evidence for a positive claim.*

**What a faithful formalisation would need**, stated because the file's own docstring claims the consequence is checked: a `Data` type, a `θ`-free predicate `P`, a **relation** `R : Data → ℝ → Prop` standing for (C), and the statement that `{θ | ∃ d, P d ∧ R d θ}` is unbounded above. Against the honest version the theorem is **false**, §3.2 exhibits the bounding functional, which is why no such statement appears.

[lean/INDEX.md](../lean/INDEX.md)'s row is more honest than the file: it marks L175 **partial** and names the toolbox premise as owed. It is wrong on one point, it says the file checks *"the consequence for a $\theta$-free constraint set"*, and the file checks no such consequence.

## 5. Item 3, "every object that toolbox produces is built from (A) and (B)"

**As stated, it is not the kind of claim that can be true or false**, because "the SDIEP toolbox" has no fixed extension: it quantifies over a body of technique, i.e. over arguments not yet written. A claim of that form can be refuted by one instance and confirmed by none. §3.3 supplies the instance.

**There is a precise nearby statement, and it is true.** The objects the symmetric-doubly-stochastic reading actually produces are $S_{ab}=\sum_cT_{abc}$ and $P=S/2(n-2)$, and their defining properties are exactly (A) and (B): $S\mathbf1=2(n-2)\mathbf1$ is (A), $S\lambda=-2\lambda$ is (B), and $S$ symmetric, hollow, entrywise $\ge0$ comes from $T$. So every consequence of *that* structure is a consequence of (A) and (B), and [r649](REVIEW_r649.md) §1.1 gives the reason the fence should have given: $T\mapsto S$ is the compression $\binom N3\to\binom N2$ that integrates the third slot at weight $\lambda^0$, while $\theta$'s $T$-dependence is the $\{1,1,1\}$ contraction, **$\theta$ is invisible to $S$**, not merely absent from a right-hand side.

**The scope was lost in transcription, and this is where.** [plan-spectral.md](plan-spectral.md) line 132 and [plan.md](../plan.md)'s I17 both read *"no Schur-convexity argument **on the spectrum** reaches $\theta$"*. L175's Statement, [INDEX-results.md](../findings/INDEX-results.md)'s row 175 and [L175.lean](../lean/HamiltonsCubic/Results/L175.lean)'s docstring all drop *"on the spectrum"* and generalise to *"from the SDIEP toolbox"*. The narrower claim is provable by the compression argument; the broader one is refuted by the $\Pi$-bound. **The block proves neither**: its proof establishes only that two right-hand sides carry no $\theta$, which is clause 1a.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved, in the form the record could hold: *every functional of $T$ that factors through $S$ is constant on the fibres of $T\mapsto\theta$ at fixed $\lambda$*, for which [r649](REVIEW_r649.md)'s contraction count is the argument, and it is in a review rather than in the block.

## 6. Item 5, the majorisation half

**It is a recognition, and it stands.** The chain, each link textbook or already on the record:

1. $S_{ab}=\sum_cT_{abc}$ is symmetric ($T$ totally symmetric), entrywise $\ge0$ ($T\ge0$), and hollow ($S_{aa}=\sum_cT_{aac}=0$ by hollowness of $T$).
2. $\sum_bS_{ab}=\sum_{bc}T_{abc}=2(n-2)$ is (A) verbatim, so $P=S/2(n-2)$ has all row sums $1$ and, being symmetric, all column sums $1$: **doubly stochastic**.
3. $\sum_b\lambda_bS_{ab}=\sum_{bc}\lambda_bT_{abc}=-2\lambda_a$ is (B), so $P\lambda=-\lambda/(n-2)$.
4. Hardy–Littlewood–Pólya: $Px\prec x$ for doubly stochastic $P$. Hence $-\lambda/(n-2)\prec\lambda$, whose partial-sum unpacking is [r338](REVIEW_r338.md)'s subset-sum family.

Nothing in this touches $\theta$, so **the closure's defect leaves it intact**, the majorisation half is independent of the fence and survives the fence's withdrawal.

**But the closure of [I17](../plan.md) does not survive intact.** I17 was graded and closed on two halves. The recognition half stands; the fence half is the one §3 refutes. So the plan row *"CLOSED as Lemma L175"* over-reports: what is closed is the recognition, and *"the hope that Schur-convexity adds anything"* is **not** closed by this argument. That is the impact of the finding, and it is the only line of the plan that has to move.

## 7. Item 6, are the two conventions bullets actually inconsistent?

**As table entries read in the table's own scope, yes. As written, there is a reading on which the original stands, and the cycle's "wrong as written" overstates it.**

The two bullets:

- Line 136: $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2\le2$, with $t=2$ iff $W$ is coordinate-diagonal in some frame.
- Line 153 before the edit: *"$M$ (or $K$) is the $n\times n$ **sectional** matrix in [diagonal-half.md](../findings/diagonal-half.md), where $\lVert K\rVert_F^2=2$ at a unit Weyl tensor"*.

**The escape the brief asks about exists and is grammatical.** The relative clause *"where …"* attaches to *"in [diagonal-half.md](../findings/diagonal-half.md)"*, and [diagonal-half.md](../findings/diagonal-half.md) is a file **wholly about the diagonal locus**, its opening line says so (*"the functional on the diagonal locus"*), its every $W$ is $\operatorname{diag}(w)$, and it carries $\operatorname{tr}M^2=2$ as a **standing normalisation constraint** in its own display, four lines below $\sum_{a<b}w_{ab}^2=1$. On the diagonal locus $\lVert K\rVert_F^2=2$ is not an approximation or a special case: it is exact and universal there, because $t=2\sum_{a<b}W_{abab}^2=2\operatorname{tr}(W^2)=2$ when every off-diagonal pair entry vanishes. **So in the scope its locator names, the original bullet is true.**

**What is genuinely wrong is the placement, not the sentence.** [conventions.md](../findings/conventions.md) is the record's global glossary (the file every other file quotes definitions from, by its own standfirst) so a row of it is read as a fact about the letter, not as a fact about one file. A locus-restricted value sitting in a global glossary is an accident waiting, and this one has already happened: [second-order.md](../findings/second-order.md) line 1612 records the near-miss in as many words, *"under the table's one attached sense of $M$, $\lVert M\rVert_F^2=2$ at a unit Weyl tensor, so L94 would read $\kappa^2\le4$ and this block's 'at unit norm that reads $\kappa^2=2$' would be false"*, and [r765](REVIEW_r765.md) filed the repair as a named reopening route (*"the letter $M$, the live route, L94 is safe only in line 92's $\Lambda^2$ sense, and line 153's sectional sense gives $\kappa^2\le4$"*).

**No rival normalisation of $K$ rescues the unqualified reading.** Both bullets define $K_{ab}=W_{abab}$ and both take $\lVert\cdot\rVert_F$, so the objects and the norms agree; the table's other sense of $M$ (line 92, the $\Lambda^2$ operator at $\lVert M\rVert_F=1$) is a different matrix, not a rescaling of this one. And the extremal escape fails too: reading $t$ as $\max_Ft_F$ per line 140 would make the unqualified bullet assert that *every* unit Weyl tensor is coordinate-diagonal in some frame, which [L94](../findings/bispectral.md)'s equality clause makes a substantive and false claim, padded $W_{\mathbb{CP}^2}$ is on the record at $\kappa^2=1$.

**Verdict: GAP.** The edit is warranted and closes a route two prior audits named. Its stated ground (that the bullet is *wrong*), is the one part that does not hold up: the bullet was under-scoped for the file it lives in, and correct in the file it points at.

## 8. Item 7, is the repair's reason right?

**The inequality half is right. The equality half is refuted. This is the defect the brief predicted.**

The repair reads: *"$\lVert K\rVert_F^2\le2$ otherwise, since $K$ captures only the entries $W_{abab}$ and equality is exactly the case where those determine $W$."*

**Derivation, exact.** Fix a frame $F$ and let $\alpha,\beta$ range over the $\binom n2$ pair indices, $\{\varphi_{ab}\}_{a<b}$ orthonormal. Then $K_{ab}=W_{\alpha\alpha}$ for $\alpha=\{a,b\}$, and

$$t_F=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2=2\sum_{\alpha}W_{\alpha\alpha}^2,\qquad \operatorname{tr}(W^2)=\sum_{\alpha,\beta}W_{\alpha\beta}^2=1 .$$

Hence, in closed form,

$$t_F\;=\;2\Big(1-\sum_{\alpha\ne\beta}W_{\alpha\beta}^2\Big)\;\le\;2,$$

**with equality iff $W_{\alpha\beta}=0$ for every $\alpha\ne\beta$, i.e. iff $W$ is diagonal in $F$'s pair basis.** So the conclusion is exactly right, and *"$K$ captures only the entries $W_{abab}$"* is exactly the right reason for the **inequality**, a subsum of a sum of squares, the dropped terms being the off-diagonal ones.

**The equality clause is a different statement, and it is false.** *"Equality is exactly the case where those determine $W$"* asks whether the numbers $(W_{abab})_{a<b}$ **determine** $W$. Take the linear map $\mathrm{diag}_F:\mathcal W_n\to\mathbb R^{\binom n2}$, $W\mapsto(W_{abab})_{a<b}$. Its target has $\binom n2$ dimensions; its source has $\dim\mathcal W_n=\tfrac{n(n+1)(n+2)(n-3)}{12}$. At $n=6$ that is $\tfrac{6\cdot7\cdot8\cdot3}{12}=84$ against $15$, so every fibre of $\mathrm{diag}_F$ has dimension at least $69$. *Cross-check on the dimension, exact:* $\dim$ (algebraic curvature tensors) $=\tfrac{n^2(n^2-1)}{12}=\tfrac{36\cdot35}{12}=105$, minus $\dim S^2(\mathbb R^6)=21$, gives $84$. **So no Weyl tensor at $n\ge4$ is determined by its coordinate sectional curvatures in a single frame, including the coordinate-diagonal ones**; the count at $n=4$ is $10$ against $6$ and at $n=5$ is $35$ against $10$. Read literally, the clause makes the equality set empty, which contradicts the very sentence it is attached to: $\lVert K\rVert_F^2=2$ *does* hold on the diagonal locus.

**The other reading is circular rather than false.** If *"determine"* means "determine $W$ among symmetric operators on $\Lambda^2$ with that diagonal", then the diagonal determines $W$ exactly when $W$ has no off-diagonal part, which is diagonality, the thing to be concluded, assumed. Either way the clause is not a derivation.

**What the true clause is, in one word.** Equality holds exactly where the captured entries **exhaust** $W$ (where they carry all of $\lVert W\rVert_F^2$) which is $\sum_{\alpha\ne\beta}W_{\alpha\beta}^2=0$. The record already carries this, correctly, at [conventions.md](../findings/conventions.md) line 138: *"$t=2\lVert\operatorname{diag}W\rVert^2$ … with equality exactly when $W$ is diagonal."* The repair reached for a fresh reason fifteen lines from a correct one.

*A smaller note on the same bullet, and it is right:* the new headline *"their norms differ by $\sqrt2$ on the diagonal locus and by less off it"* checks, $\lVert K\rVert_F=\sqrt{t_F}\le\sqrt2=\sqrt2\cdot\lVert W\rVert_F$, with strict inequality off the locus.

**Verdict: BROKEN, in the reason only.** The conclusion stands (clause 2c, PROVEN); the reason recorded for it does not.

## 9. Item 8, was the original bullet load-bearing?

**Yes, as a hazard rather than as a premise, and the record had already found it twice.** No consumer *derives* anything from the unqualified $\lVert K\rVert_F^2=2$; what the record holds is two blocks that had to step around it:

- [second-order.md](../findings/second-order.md) line 1612 names the trap explicitly and concludes *"the working sense is the $\Lambda^2$ operator matrix"*.
- [r765](REVIEW_r765.md) lists it first among L94's reopening routes; [r762](REVIEW_r762.md) filed the same clash against [L174](../findings/second-order.md) (*"conventions.md's letter-$M$ row gives $\lVert M\rVert_F^2=2$ at a unit Weyl tensor, under which L94 reads $\kappa^2\le4$"*).

So the edit changes nothing a consumer may claim; it removes a trap two audits had to disarm by hand. **That is a real gain and the cycle is right to have taken it.**

**One live instance the edit does not reach, and I locate it exactly.** [second-order.md](../findings/second-order.md) line 1060 carries the same defect one file away, in an italicised aside: *"$M$ is the $n\times n$ vertex matrix in [diagonal-half.md](../findings/diagonal-half.md) and $W$ is the $\Lambda^2$ operator in [bispectral.md](../findings/bispectral.md), with $\lVert K\rVert_F^2=2\lVert W\rVert^2$."* Stated as an identity, it is the diagonal-locus case again: by §8's closed form, $\lVert K\rVert_F^2=2\lVert W\rVert^2-2\sum_{\alpha\ne\beta}W_{\alpha\beta}^2$, so the identity holds **only** on the diagonal locus and reads $<$ everywhere else. The same sentence is the one that ends *"conventions.md … owes a row for $M$"*, the row is now written, and the sentence beside the request still needs the scope the row just gained. **Repair: write $\le$, or append "on the diagonal locus".**

## 10. Item 9, the consequence, checked

**It checks.** [L94](../findings/bispectral.md) states $\kappa^2\le2\lVert M\rVert_F^2$. Substituting the sectional sense of $M$ together with the unqualified $\lVert K\rVert_F^2=2$ gives $\kappa^2\le2\cdot2=4$. Arithmetic exact.

Two qualifications the sentence does not make, neither of which damages it:

1. **The resulting statement is true but slack, not false.** $\kappa^2=\max_Ft_F\le2$ always, so $\kappa^2\le4$ is a weaker true bound. The hazard is a valid-*looking* derivation of a bound a factor $4$ short, which is precisely the failure mode L94's own text fences (*"the norm must be $\lVert M\rVert_F$, not the $4$-tensor norm, or the bound is slack by a factor $4$"*).
2. **The phrase "off the diagonal locus" is doing different work than it reads.** Off the locus $\lVert K\rVert_F^2<2$, so the *correct* substitution would give $\kappa^2<4$. The $4$ arises from carrying the **locus** value off the locus, which is exactly the defect being repaired, so the sentence is describing its own subject correctly, if compressed.

## 11. Item 10, what would show the edit wrong

Named as positive conditions, each checkable:

1. **A unit Weyl tensor, coordinate-diagonal in some frame, with $\lVert K\rVert_F^2\ne2$ in that frame.** This would break §8's closed form and with it both bullets. It cannot exist while $\operatorname{tr}(W^2)=1$ and the pair basis is orthonormal.
2. **A tabled reading of $K$ under which the sectional matrix is normalised to $\lVert K\rVert_F=1$**, i.e. an unordered-pair convention for $t$. Then $t\le1$, the numeral $2$ moves, and both bullets are restated, the hazard [r765](REVIEW_r765.md) and [r766](REVIEW_r766.md) closed, and it stays closed only while line 136 keeps the word *"ordered"* and the word *"matrix"*.
3. **A consumer that reads line 153 as scoped to [diagonal-half.md](../findings/diagonal-half.md) and needs the unqualified value there.** Since [diagonal-half.md](../findings/diagonal-half.md) fixes $\operatorname{tr}M^2=2$ as a constraint, such a consumer loses nothing from the edit; a consumer that instead reads the bullet globally is the one the edit protects.
4. **A proof that $\mathrm{diag}_F$ is injective on $\mathcal W_n$ at coordinate-diagonal points.** That, and only that, would rescue the word *"determine"*. §8's dimension count forecloses it at every $n\ge6$; at $n=4,5$ the count is $\dim\mathcal W_4=10$ against $6$ and $\dim\mathcal W_5=35$ against $10$, so it is foreclosed there too.

## 12. Two smaller findings, recorded because silence is not a verdict

**(i) The closing box's unification is a non sequitur, of the family [r649](REVIEW_r649.md) already caught once.** L175 ends: *"[L173](../findings/bounds-relaxations.md)'s zero class absorbs (A) at negligible cost and pays nothing in (B) or (C), a slack visible only because (A) is the relation carrying no $\theta$."* The mechanism L173 states for itself is different: *"the type $\{1,3,3\}$ enters (A$_1$) with weight $\mu_3(\mu_3-1)=3422$ against a right-hand side of $2(n-2)=20$, while $\nu_3=0$ removes it from (B$_1$) and (C$_1$) entirely."* **The operative fact there is $\nu_3=0$, not $\theta\notin$ (A).** Had (A) carried $\theta$, the zero class would absorb its row mass just the same, its coefficient being $\mu_3(\mu_3-1)$ and nothing to do with $\theta$. So *"the two closures are the same observation read at two levels"* is a resemblance, not an identity.

**(ii) The proof's own last sentence is correct and contradicts the Statement's third.** *"An inequality holding for all such $T$ constrains $\theta$ only through whatever function of $T$ it names, never through the constraints."* That is right, and it is the concession §3.2 turns into a bound: the $\Pi$-bound names $g_i$, and naming it is enough. The Statement's *"which is to say it bounds nothing"* is a strengthening of the proof's own conclusion that the proof does not license.

## 13. Verdicts

| claim | verdict | what has to change |
| --- | --- | --- |
| L175 clauses 1a, 1b | **PROVEN** | nothing |
| L175 clause 1c, the fence | **BROKEN AS WRITTEN** | strike *"which is to say it bounds nothing"*; the $\Pi$-bound and the $(26,2)$ infeasibility are both counterexamples |
| L175 clause 1d, the toolbox | **HYPOTHESIS-DEBT** | restore *"on the spectrum"* from [plan.md](../plan.md)'s I17, and cite [r649](REVIEW_r649.md) §1.1's compression argument as the reason |
| L175 clause 1e, majorisation | **PROVEN** | nothing; but [I17](../plan.md)'s closure narrows to this half |
| [L175.lean](../lean/HamiltonsCubic/Results/L175.lean) | **BROKEN** | `theta_free_bounds_nothing` and the two `_theta_free` theorems state nothing; `bound_must_come_from_C`'s hypothesis is unsatisfiable when `P` is inhabited |
| conventions bullet, the edit | **GAP** | keep the edit; drop *"wrong as written"*, the original was scoped by its locator, and under-placed rather than false |
| conventions bullet, the reason | **BROKEN** | replace *"where those determine $W$"* with *"where those exhaust $W$"*, or cite line 138's $t=2\lVert\operatorname{diag}W\rVert^2$ |
| conventions bullet, conclusion and consequence | **PROVEN** | nothing |
| [second-order.md](../findings/second-order.md) line 1060 | **defect, unrepaired** | $\lVert K\rVert_F^2=2\lVert W\rVert^2$ holds only on the diagonal locus; write $\le$ |

**Overall: BROKEN.**
