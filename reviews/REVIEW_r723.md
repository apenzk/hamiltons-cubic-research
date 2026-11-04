# Review r723, the typed statements and the plan corrections

**Reviewer r723, Gate 2, cold brief.** Four claims recorded without review: I1's removable irrationality, [PencilConstants.lean](../lean/HamiltonsCubic/Results/PencilConstants.lean)'s definitions against the record, [plan.md](../plan.md)'s new B1 row on the base layer, and the four corrections written into I6 and I31. The programme is on an analysis-only footing ([analysis-only.md](../.claude/rules/analysis-only.md)); **no numerical work was done beyond the screening allowance**, one seconds-long evaluation of closed forms I was about to record, reported as a screen in §0 and never cited as evidence for a positive claim. Every counterexample below is exhibited in closed form. Log: [agent_logs/r723.log](../agent_logs/r723.log).

## Verdicts

| # | claim | verdict |
| --- | --- | --- |
| A | $\theta\le\sqrt{3/2}$ **is** $2P(W)^2\le3\lVert W\rVert^6$ once $\theta\le0$ is separated | **REFUTED AS STATED** |
| A′ | the exponent $6$ is the right homogenisation | **CONFIRMED** |
| A″ | "the irrationality lives entirely in the normalisation" / "no real-number layer" | **REFUTED** |
| B | [theta0](../lean/HamiltonsCubic/Results/PencilConstants.lean) and [rhoEff](../lean/HamiltonsCubic/Results/PencilConstants.lean) are the record's $\theta_0(n)$ and $\rho^{\text{eff}}_n$ | **CONFIRMED** |
| B′ | the three theorem statements are about that function | **CONFIRMED** |
| B″ | `theta0`'s doc gloss "the balanced product's critical value" | **REFUTED**, false at every odd $n$, and it is the struck gloss |
| B‴ | `rhoEff_pos`'s doc "Equivalent to $11n^3-55n^2-224n+256>0$" | **REFUTED AS STATED**, fails at $n=1,2$ on Lean's junk values |
| B⁗ | "The penalised pencil's radius is governed by `rhoEff`" | **UNPROVEN**, the record marks the defining $\tfrac29$ `HYPOTHESIS-DEBT`, and the alternative reverses `rhoEff_strictMonoOn` |
| C | [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) fixes the cubic form at `Fin 6`, i.e. $n=4$ | **CONFIRMED** |
| C′ | [Curvature.lean](../lean/HamiltonsCubic/Base/Curvature.lean) is already general over an index type | **CONFIRMED** |
| C″ | **only** `Qop` and `Pcubic` are missing | **REFUTED**, five further inputs, one of which is unavailable over $\mathbb Q$ at all |
| D1 | the radius is $\Omega(n^{-3/2})$ rather than $\Theta$ | **CONFIRMED** |
| D2 | L148 voids L146 at $w=0$ only, branch 1 present there at $c_p/S\le3/(n-2)$ | **CONFIRMED** |
| D3 | $\sigma$ does not factorise; $J^*$ the reach's constant only to $O(t^2)$, $\approx16\%$ at $n=12$ | **CONFIRMED** |
| D4a | branch 2 binding to $n\approx1140$ rather than $1800$ | **CONFIRMED** |
| D4b | branch 1 is $\Theta(n^{-3/2})$ at $w=\Theta(1)$, not $\Theta(n^{-1-\beta})$ | **CONFIRMED** |
| D4c | "so $w=0$ is its maximum rather than its minimum" | **REFUTED AS STATED**, the record says "never its minimum", and $u=0$ is not the maximum at any $\beta>0$ |

**One line.** The two Lean constants are exactly the record's and the three plan corrections on the second-order chain are exactly what [second-order.md](../findings/second-order.md) says; what fails is the surrounding prose, the squared form is strictly stronger than the inequality it is offered as, the base layer's irrationality is relocated rather than removed, B1's "only two things missing" undercounts by five, and I31 turns "never its minimum" into "its maximum".

## 0. Conventions, fixed once

- $\theta=P(W)/\lVert W\rVert^3$, and at a critical point $Q(W)=\theta W$, [conventions.md](../findings/conventions.md) row 17. The two readings agree exactly on $\lVert W\rVert=1$, which is where [problem.md](../findings/problem.md)'s Lagrange derivation puts them ("*whose Lagrange condition is $Q(W)=\theta W$ with $\theta=P(W)$*").
- $\theta_0(n)^2=2(n-1)(n-2)/n^2$, **and nothing more**, [conventions.md](../findings/conventions.md) row 18, which explicitly strikes the gloss "the value at the balanced sphere product".
- $\rho^{\text{eff}}_n=\sqrt6-\theta_0(n)\tfrac{n+16}{2(n-2)}$, [second-order.md:1237](../findings/second-order.md).
- $c_p=3\theta_0/(n-2)$, $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}$, $S=\sup\lvert P\rvert=\Theta(n^\beta)$ with $\beta\in[0,\tfrac12]$, [second-order.md:1288](../findings/second-order.md), [L147](../findings/second-order.md).
- Branch 1 is $f(u)=(c_p+u^2)/(S+au)$ and branch 2 carries $w$; **they are different variables**, as [L149](../findings/second-order.md)'s display at line 1224 shows.

**The screen.** One evaluation of the closed forms above at $n\in\{12,13,14,18\}$ and of $D(n)=11n^3-55n^2-224n+256$ at $n\in\{1,2,3,7,8,12\}$, to check the numerals I record here against the record's printed digits. It reproduced $\theta_0(12)=1.2360331$, $\rho^{\text{eff}}_{12}=0.7190434$, $D(12)=8656$, $C^*=42/11$ and $J^*=6.9421$. It is a screen; nothing below rests on it that is not also derived by hand.

## 1. Claim A, the equivalence, in both directions

### 1.1 What $\theta$ is, and why the exponent is right

[conventions.md](../findings/conventions.md) fixes $\theta=P(W)/\lVert W\rVert^3$. $P$ is cubic, so $\theta$ is scale-invariant and

$$\theta^2\le\tfrac32\iff \frac{P(W)^2}{\lVert W\rVert^6}\le\tfrac32\iff 2P(W)^2\le3\lVert W\rVert^6$$

for every $W\ne0$, with no normalisation and no root. **The exponent $6$ is correct and it is correct because of the cube in the definition of $\theta$**, this is the part of the annotation that is exactly right, and it is worth saying so, because the other reading on the record gives a different exponent. Under "$Q(W)=\theta W$" read off the unit sphere, $\theta=P(W)/\lVert W\rVert^2$ and the same manipulation returns $2P^2\le3\lVert W\rVert^4$. The two readings coincide only at $\lVert W\rVert=1$; a Lean statement that drops the normalisation must therefore commit to the $\lVert W\rVert^3$ reading, and $\lVert W\rVert^6$ is that commitment. **CONFIRMED.**

### 1.2 The equivalence fails in one direction, and the separation does not repair the sentence

$$2P^2\le3\lVert W\rVert^6\iff\lvert\theta\rvert\le\sqrt{3/2}\iff -\sqrt{3/2}\le\theta\le\sqrt{3/2}.$$

- **($\Rightarrow$)** the squared form implies $\theta\le\sqrt{3/2}$. Sound, unconditionally.
- **($\Leftarrow$)** $\theta\le\sqrt{3/2}$ does **not** imply the squared form. It says nothing about $\theta<-\sqrt{3/2}$, where the squared form is false.

So the squared form is **strictly stronger pointwise**, which is what the brief asks: *equivalent or merely implied*, it implies, and is not implied.

**Locate.** [plan.md:110](../plan.md), B1's last paragraph: *"No real-number layer: [I1](../plan.md)'s $\theta\le\sqrt{3/2}$ is equivalent to $2P(W)^2\le3\lVert W\rVert^6$ once $\theta\le0$ is separated"*, and [plan.md:64](../plan.md): *"$\theta\le\sqrt{3/2}$ needs no real-number layer, it is $2P(W)^2\le3\lVert W\rVert^6$ once $\theta\le0$ is separated"*.

**Exhibit.** Take any $W$ with $\lVert W\rVert=1$ and $\theta(W)=-2$. Then $\theta\le\sqrt{3/2}$ holds and $2P^2=8>3$ fails. The separation clause is doing exactly the work of excluding this, so the honest Lean statement is the **disjunction**

$$P(W)\le0\ \lor\ 2P(W)^2\le3\lVert W\rVert^6,$$

which is a different proposition from the one both plan lines name. The second line (the one that says what I1's theorem "**is**"), carries the bare conjunct, and a reader typing from it types the wrong theorem. That is the defect: not that the algebra is wrong, but that the sentence's main clause and its subordinate clause disagree about what the statement is, and the main clause is what gets copied.

**Can $\theta\le0$ occur on I1's set?** Two answers, and neither rescues the bare form.

1. $Q$ is quadratic and $P$ is odd, so $Q(-W)=Q(W)=-\theta\,(-W)$: the criticality clause and "non-diagonal" are both invariant under $W\mapsto-W$ with $\theta\mapsto-\theta$. If the $S=0$ clause is too, the set is symmetric and $\theta\le0$ occurs at every point of it, half the set. The separation is then not a corner case but the larger half.
2. [conventions.md](../findings/conventions.md)'s normalisation bullet says **"Normalise $W$ to $\theta>0$ before measuring $S$"**, under which $S=0$ is only ever asserted at $\theta>0$ and the negative half is excluded by the clause itself. Then the separation is vacuous, **but the exclusion is a hypothesis the plan does not name**, and a Lean statement that omits it quantifies over the symmetric set of (1).

Either way the row owes a clause it does not carry. Note also that $S$'s own definition runs through $W_-$ ([ungraded-slack.md](../findings/ungraded-slack.md), and $\mathop{\mathrm{tr}}(W_-)$ at its line 190), and $(-W)_-=W_+$, so the invariance in (1) is **not** free and nothing on the record establishes it.

**Argue the opposite.** The strongest defence: on I1's set the two statements are equivalent *as theorems*, because the $\pm$ symmetry makes $\sup\theta=-\inf\theta$, so bounding $\theta$ above by $\sqrt{3/2}$ bounds $\lvert\theta\rvert$ by it too. That defence is good, and it is not the defence the plan gives. It routes through the oddness of $P$ and the invariance of the $S=0$ clause, neither of which the row states, and it makes "once $\theta\le0$ is separated" the wrong reason for a right conclusion. **REFUTED AS STATED**; the algebra on $\{\theta>0\}$ is `CONFIRMED AS ALGEBRA`.

### 1.3 "The irrationality lives entirely in the normalisation", the layer is $\mathbb Q$, and the attaining point is not a $\mathbb Q$-point

The whole base layer is over $\mathbb Q$: [Bivectors.lean](../lean/HamiltonsCubic/Base/Bivectors.lean), [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) and [Curvature.lean](../lean/HamiltonsCubic/Base/Curvature.lean) are all `Matrix _ _ ℚ`. "No real-number layer" therefore means: state I1 over $\mathbb Q$. Granted, $\lVert W\rVert^6=(\lVert W\rVert^2)^3\in\mathbb Q$ and $2P^2\le3\lVert W\rVert^6$ needs no root, that half is right.

**But the hypothesis set does not survive the restriction.** I1 quantifies over $\{Q(W)=\theta W,\ S=0,\ W\ \text{non-diagonal}\}$, an algebraic variety, not a linear space; $\mathbb Q$-points of a variety are not dense in its real points, so the $\mathbb Q$-statement neither implies nor is implied by I1.

**Exhibit, in closed form.** [second-order.md:255](../findings/second-order.md) records the point that attains I1's supremum as

$$W_{\mathbb{CP}^2}=\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6,$$

with $\theta^2=\tfrac32$. Its entries are $\pm1/\sqrt6$ and $2/\sqrt6$, and $\sqrt6\notin\mathbb Q$, so **$W_{\mathbb{CP}^2}\notin\mathcal W_4(\mathbb Q)$**, I1's own equality case, the point [plan.md:60](../plan.md) calls "the non-diagonal $S=0$ critical point that **attains** this item's supremum", is invisible to a $\mathbb Q$-statement. More sharply: a $\mathbb Q$-point with $\lVert W\rVert^2=1$ and $Q(W)=\theta W$ has $\theta=P(W)\in\mathbb Q$, so $2P^2=3$ is unreachable and the $\mathbb Q$-statement is never sharp. The irrationality has been moved out of the inequality and into the *set*, where it decides whether the theorem has any content.

**Argue the opposite.** One could say the intent is only "state it over $\mathbb R$ without `Real.sqrt`", which the squared form achieves, and [PencilConstants.lean](../lean/HamiltonsCubic/Results/PencilConstants.lean) shows the repository is willing to import $\mathbb R$. That is a coherent reading and it makes A″ true. It is however not the reading B1 is written for: B1 is a row about the $\mathbb Q$ base layer, its stated deliverable is "`Qop` and `Pcubic` over a general index type" built on [Curvature.lean](../lean/HamiltonsCubic/Base/Curvature.lean)'s `ι` over $\mathbb Q$, and the sentence's job is to say that layer suffices. It does not. **REFUTED.**

## 2. Claim B, the Lean constants against the record

### 2.1 The definitions match, exactly

| Lean | record | verdict |
| --- | --- | --- |
| `theta0 n = Real.sqrt (2*(n-1)*(n-2)) / n` | $\theta_0(n)^2=2(n-1)(n-2)/n^2$, [conventions.md](../findings/conventions.md) row 18 | positive root of the record's square, **matches** |
| `rhoEff n = Real.sqrt 6 - theta0 n * (n+16) / (2*(n-2))` | $\rho^{\text{eff}}_n=\sqrt6-\theta_0(n)\tfrac{n+16}{2(n-2)}$, [second-order.md:1237](../findings/second-order.md) | **matches character for character** |

No factor, no normalisation drift, no coercion drift on $12\le n$. **At $n=12$, by hand:** $\theta_0(12)=\sqrt{2\cdot11\cdot10}/12=\sqrt{220}/12=\tfrac{2\sqrt{55}}{12}=\tfrac{\sqrt{55}}6=1.2360331$, which is the record's printed $1.236033$ ([Theta0.lean](../lean/HamiltonsCubic/Results/Theta0.lean) `at_12 : evenSq 12 = 55/36`, and $\sqrt{55/36}$ is that). Then

$$\rho^{\text{eff}}_{12}=\sqrt6-\frac{\sqrt{55}}6\cdot\frac{28}{20}=\sqrt6-\frac{7\sqrt{55}}{30}=2.4494897-1.7304463=0.7190434,$$

which is the record's $0.7190434$ at [second-order.md:1338](../findings/second-order.md) and its integer form $\sqrt6-\tfrac7{30}\sqrt{55}$ at line 1237. **CONFIRMED.**

**And the cross-check in the `rhoEff_pos` docstring is a genuine identity, derived here from scratch.** $\rho^{\text{eff}}_n>0\iff 24(n-2)^2>\theta_0^2(n+16)^2$; multiplying by $n^2$ and cancelling $2(n-2)>0$,

$$12n^2(n-2)-(n-1)(n+16)^2=12n^3-24n^2-(n^3+31n^2+224n-256)=11n^3-55n^2-224n+256,$$

which is the docstring's cubic and [RhoEff.lean](../lean/HamiltonsCubic/Results/RhoEff.lean)'s `D`. At $n=12$ it is $19008-7920-2688+256=8656$, the record's number. The three statements are therefore about the record's function and not another one. **CONFIRMED.**

**Monotonicity, checked independently.** $p(n):=\theta_0(n)\tfrac{n+16}{2(n-2)}=\tfrac{n+16}{2n}\sqrt{\tfrac{2(n-1)}{n-2}}$. Both factors are positive and strictly decreasing ($\tfrac{n+16}{2n}=\tfrac12+\tfrac8n$, and $\tfrac{n-1}{n-2}=1+\tfrac1{n-2}$) so $p$ decreases and $\rho^{\text{eff}}=\sqrt6-p$ strictly increases, to $\sqrt6-\tfrac{\sqrt2}2\cdot\ldots=1.74238$. `rhoEff_strictMonoOn` and `rhoEff_ge_twelve` are true of the defined function, the third being the second at $m=12$ together with reflexivity.

### 2.2 The `theta0` gloss reproduces the gloss the record struck

**Locate.** [PencilConstants.lean:16](../lean/HamiltonsCubic/Results/PencilConstants.lean): *"`θ₀ n = √(2(n-1)(n-2)) / n`, **the balanced product's critical value**."*

**The record's own words**, [conventions.md](../findings/conventions.md) row 18: *"$\theta_0(n)$, **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** … **The gloss 'the value at the balanced sphere product' stood here until 2026-09-04 and is what regrew [L0](../findings/problem.md)'s refuted constant**."*

**Exhibit, in closed form at a named value.** `theta0 : ℕ → ℝ` is total, so the gloss is asserted at odd $n$ too, where it is false. At $n=13$:

$$\theta_0(13)=\frac{\sqrt{264}}{13}=1.2498521,\qquad \Theta_{13}=\sqrt{\frac{2\cdot12\cdot10}{14\cdot11}}=\sqrt{\frac{240}{154}}=1.2483756,$$

and the gap reproduces the record's identity $\theta_0^2-\Theta_n^2=\tfrac{8(n-1)}{n^2(n+1)(n-2)}=\tfrac{96}{26026}=0.0036886$ against $1.5621302-1.5584416=0.0036886$. So at $n=13$ the balanced product's critical value is $1.2483756$ and `theta0 13` is $1.2498521$: **the docstring names the wrong number.**

**Argue the opposite.** The file's consumers are all at even $n$ ($\rho^{\text{eff}}$ is only used at $n=2m\ge12$) so nothing downstream reads the gloss at an odd argument. True, and it makes this harmless *today*. It is nonetheless the exact sentence [conventions.md](../findings/conventions.md) records as having cost the programme a refuted constant, re-entering the record in a file whose whole purpose is to be the citable statement. **REFUTED.**

### 2.3 The stated equivalence in `rhoEff_pos` fails at $n=1$ and $n=2$

**Locate.** [PencilConstants.lean:24](../lean/HamiltonsCubic/Results/PencilConstants.lean): *"Positivity on the programme's range. **Equivalent to** `11n³ − 55n² − 224n + 256 > 0`."* The theorem below it is hypothesised on $12\le n$; the docstring's equivalence is not.

**Exhibit.** In Lean, $x/0=0$. At $n=2$: `theta0 2 = Real.sqrt (2*1*0)/2 = 0`, and `rhoEff 2 = Real.sqrt 6 - 0 * 18 / 0 = Real.sqrt 6`. So

$$\texttt{rhoEff}\ 2=\sqrt6>0\qquad\text{while}\qquad D(2)=88-220-448+256=-324<0 .$$

At $n=1$ the same: `theta0 1 = Real.sqrt 0 = 0`, `rhoEff 1 = Real.sqrt 6 > 0`, $D(1)=-12<0$. The equivalence holds from $n\ge3$ (where the cancellation of $2(n-2)>0$ is legitimate) and fails at exactly the two arguments where the derivation divides by zero.

**Argue the opposite.** The docstring's first sentence says "on the programme's range", which arguably scopes the second. That is the right defence and it is why this is `REFUTED AS STATED` rather than `REFUTED`: the fix is four words. It matters because [RhoEff.lean](../lean/HamiltonsCubic/Results/RhoEff.lean) already carries the sign analysis and states the threshold as **$n\ge8$**, so a reader reconciling the two files is invited to read the equivalence as global, which it is not.

### 2.4 The module docstring asserts what the record marks `HYPOTHESIS-DEBT`

**Locate.** [PencilConstants.lean:6](../lean/HamiltonsCubic/Results/PencilConstants.lean): *"The penalised pencil's radius **is governed by** `rhoEff`."*

**The record.** [second-order.md:1241](../findings/second-order.md): *"**THE $\tfrac29$ IS A DEBT, AND THE MONOTONICITY TURNS ON IT.** … nothing on file joins the two decompositions. … **At coefficient $1$ the constant reads $0.689771$ and *decreases* to a floor of $0.582938$, reversing the monotonicity above.** … `HYPOTHESIS-DEBT`."*

**Exhibit.** The alternative reading replaces $\tfrac29$ by $1$ in $\rho=3\theta_0\tfrac{n-8}{2(n-2)}-c\lvert\kappa_n\rvert$ with $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$, giving in closed form $\rho^{(1)}_n=9\sqrt{3/2}-\theta_0(n)\tfrac{15n-12}{2(n-2)}$, that is

$$\rho^{(1)}_{12}=0.7416200-0.1015940=0.6400260,\quad \rho^{(1)}_{14}=0.6138428,\quad \rho^{(1)}_\infty=\tfrac32\sqrt2-9(\sqrt2-\sqrt{3/2})=0.4161021,$$

**strictly decreasing**. Under that reading `rhoEff_strictMonoOn` is false, and `rhoEff_ge_twelve` (the form the uniformity argument consumes), is false in the direction that matters. The Lean file states both as `theorem` with no marker, and its module docstring converts the identification into an assertion.

**Argue the opposite.** The three statements are about `rhoEff` **as defined**, and of that function they are true regardless of how the debt resolves; the debt is about whether that function is the pencil's coefficient. Exactly so, which is why B and B′ are `CONFIRMED` and only the prose is `UNPROVEN`. But the prose is what a reader of a statements-only file uses to decide what has been claimed, and this file is offered as the typed record of the constant. The line should say the identification is owed.

### 2.5 Two files already carry this, in $\mathbb Q$, with no `sorry`

[RhoEff.lean](../lean/HamiltonsCubic/Results/RhoEff.lean) proves `D_eq`, `D_at_7`, `D_at_8`, `D_at_12`, `sign_change`, `D_increasing` and `factor_decreasing`, the whole positivity-and-monotonicity skeleton, kernel-checked, and it establishes the threshold at $n\ge8$, four dimensions below what [PencilConstants.lean](../lean/HamiltonsCubic/Results/PencilConstants.lean) hypothesises. [Theta0.lean](../lean/HamiltonsCubic/Results/Theta0.lean) carries $\theta_0^2$ as `evenSq` with `at_12 : evenSq 12 = 55/36` and `evenSq_mono`. PencilConstants imports neither and names neither. Recorded as a duplication, not as a defect in the claim.

## 3. Claim C, what else a general statement needs

### 3.1 What the row gets right

- **`Fin 6` is $n=4$.** [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) types `sharpMat`, `Qop`, `Pcubic` and `IsWeyl` on `Matrix (Fin 6) (Fin 6) ℚ`, and `basis4`/`pair4` identify the index with the six coordinate $2$-planes of $\mathbb R^4$, $\dim\Lambda^2\mathbb R^4=6$. **CONFIRMED.**
- **[Curvature.lean](../lean/HamiltonsCubic/Base/Curvature.lean) is general.** `variable {ι : Type*} [Fintype ι] [DecidableEq ι]`, and `sharpQF'`, `RicOf`, `bianchiOf`, `IsWeylOf` are all stated over `ι`. **CONFIRMED.**

### 3.2 What "only `Qop` and `Pcubic` are missing" leaves out

**The two files are in different representations, and the bridge between them is hard-wired to $n=4$.** [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) takes $R$ as a **matrix on the pair index**; [Curvature.lean](../lean/HamiltonsCubic/Base/Curvature.lean) takes $R$ as a **map** `Matrix ι ι ℚ → Matrix ι ι ℚ`. The translation is [Bridge.lean](../lean/HamiltonsCubic/Base/Bridge.lean)'s `ofMatrix R = fun X => toMat4 (R *ᵥ coord4 X)`, and `toMat4`/`coord4` run through `pair4 : Fin 6 → Fin 4 × Fin 4`, a table. So building `Qop`/`Pcubic` "on that same `ι`" is not a re-typing; it needs, and the row names none of these:

1. **An inner product on curvature operators.** `Pcubic R = (Rᵀ * Qop R).trace` is a trace over the pair index. In the map representation there is no transpose and no trace, so $P(W)=\langle W,Q(W)\rangle$ and $\lVert W\rVert$ both need a pairing on maps, defined as a sum over $\Lambda^2$, and carrying [conventions.md](../findings/conventions.md)'s "**the $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level**", the normalisation whose other reading "*inflates every $\theta$ by $\sqrt2$*". Every constant in I1 and I2 is downstream of that choice.
2. **`sharpMat`, i.e. polarisation without a basis.** [Curvature.lean](../lean/HamiltonsCubic/Base/Curvature.lean) has only the quadratic form `sharpQF'`; `Qop = R*R + sharpMat R` needs $\#$ as an *operator*. At `Fin 6` it is recovered on the pair basis via `Pi.single a 1`. Over `ι` the candidate family is $\{\varphi_{ij}\}$, which is **not** an independent indexed family (`phi_swap : phi j i = -phi i j` and $\varphi_{ii}=0$) so the polarisation needs an orthonormality-over-$i<j$ lemma that the base layer does not have. [Bivectors.lean](../lean/HamiltonsCubic/Base/Bivectors.lean) proves `inner2_phi_self` for one $\varphi$ and nothing about the family.
3. **Well-definedness of the operand.** `R : Matrix ι ι ℚ → Matrix ι ι ℚ` is an arbitrary function: `IsWeylOf` requires **neither linearity nor that $R$ maps skew to skew**, its symmetry clause being quantified over skew arguments only. Both `R ∘ R` (inside `Qop`) and any trace-level $P$ read $R$ off the skew subspace. A general `Qop`/`Pcubic` therefore needs a hypothesis class that `IsWeylOf` does not supply.
4. **For I1 specifically: "non-diagonal" and "$S=0$".** [conventions.md](../findings/conventions.md) defines diagonal as *"diagonal in coordinate $2$-planes $e_i\wedge e_j$ **of an orthonormal frame**"*, an $O(n)$-orbit condition; and *"Diagonality is MEASURED as off-diagonal Frobenius mass minimised over $O(n)$"*. Over $\mathbb Q$ there is no $O(n)$ to minimise over. $S$, the gradedness slack, has no Lean definition anywhere. Neither predicate exists, and I1's theorem is a statement about the set they cut out.
5. **For I2 specifically: the second variation cannot be stated over $\mathbb Q$ at all.** It needs $\delta^2$, hence $\mathrm{Alt}(W_-)$, and [conventions.md](../findings/conventions.md) fixes $W_-=\tfrac12(\lvert W\rvert-W)$, the absolute value of a symmetric operator, i.e. its spectral decomposition. A rational symmetric matrix has irrational eigenvalues in general, so $W_-\notin\mathrm{Mat}(\mathbb Q)$ and `Alt (W_-)` has no $\mathbb Q$-valued definition. It also needs the orbit $SO(n)\cdot W^*$, its normal space, $\kappa_n$, and a Hessian spectrum, all real-analytic objects.

**Exhibit for (5), in closed form.** [second-order.md:255](../findings/second-order.md) gives $W_{\mathbb{CP}^2}=\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$ with $\delta^2=\tfrac19$, and [L145](../findings/second-order.md) gives $W^*_-=\lvert\lambda_-\rvert(\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2})$ with $\lvert\lambda_-\rvert=g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$, irrational at $n=12$, being $\tfrac16\sqrt{\tfrac{10}{22}}=\tfrac16\sqrt{5/11}$. The very first constant of I2's chain is a surd. The repository already concedes this: [PencilConstants.lean](../lean/HamiltonsCubic/Results/PencilConstants.lean) imports Mathlib and works in `ℝ` with `Real.sqrt`.

**Argue the opposite.** The row's own scope may be narrower than it reads: it says what would make "both items **statable**", and one could argue that with `Qop` and `Pcubic` in place the remaining pieces are I1's and I2's own business rather than B1's. That defence holds for (4) and (5) if the row is read as "the base layer's part", but not for (1), (2) and (3), which are base-layer objects with no home anywhere else, and it is contradicted by the row's own final paragraph, which asserts that after `Qop` and `Pcubic` "**both items are statable and the constant chain follows**". **REFUTED.**

## 4. Claim D, the four corrections against [second-order.md](../findings/second-order.md)

### 4.1 D1, $\Omega$, not $\Theta$: **CONFIRMED**

[L145](../findings/second-order.md), the box under the statement: *"**THE $\Theta$ THIS BOX CARRIED IS REFUTED, AND THE UPPER HALF IS ARGUED NOWHERE ON THE RECORD.** No statement of the form $r_n=O(\cdot)$ appears in this entry or in [L146](../findings/second-order.md)–[L158](../findings/second-order.md) … **The chain cannot yield an upper bound at all**, every ingredient bounds a denominator above or a numerator below."* [plan.md:66](../plan.md) reproduces this, including the clause about denominators and numerators. The step table reads *"$r_n=\Omega(n^{-3/2})$, **CONFIRMED as a lower bound.** *The equality reading is withdrawn*"*, and $C_\delta=O(n)$ is the corrected constant. Every element of the plan's sentence is on the page. The apparent tension with [L147](../findings/second-order.md)'s $\Theta(n^{-1})$ ceiling is pre-empted by L145's own qualification that the ceiling *"caps what the route can prove rather than the radius"*, which the plan sentence respects.

### 4.2 D2, L148 at $w=0$ only, branch 1 present at $c_p/S\le3/(n-2)$: **CONFIRMED**

[L148](../findings/second-order.md), second box: *"**WHAT IS ABSENT AT $w=0$ IS THE TWO DEFECT *TERMS*, NOT TWO BRANCHES.** Branch 1 is present there and equals $c_p/S\le3/(n-2)$, it is the branch that proves the route's $\Theta(n^{-1})$ ceiling. Only branch 2 goes unbounded."* The lemma statement repeats it. The displacement of L146 is the entry's own last box: *"**THIS IS STRONGER THAN [L146](../findings/second-order.md) AND IT DISPLACES IT.** A bound on $\lVert A''\rVert$ over a summand where $A\equiv0$ prices a quantity that is not there"*, and the summand is $\Sigma$, the joint two-copy $S^2_0(\mathbb R^m)$ eigenspace, which is $w=0$. The plan's "at $w=0$ only" and "the joint two-copy margin summand" are both exact.

**Checked independently.** $c_p/S\le3/(n-2)$ requires $\theta_0\le S$, since $c_p=3\theta_0/(n-2)$. That is [L147](../findings/second-order.md)'s $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)$, so the inequality holds and is not an extra assumption.

### 4.3 D3, $\sigma$ does not factorise, $16\%$ at $n=12$: **CONFIRMED**

[L156](../findings/second-order.md), last two paragraphs: *"**So $\gamma$ does not separate from $\sigma$**: … the reach's own optimum is the larger $\gamma^\dagger$ with $\gamma^\dagger/(d-\gamma^\dagger)=s$"*, and *"$C^*$, $J^*$ are the reach's constants **to $O(t^2)$**. **The licence is exactly $J(\gamma^\dagger)/J(\gamma^*)=1/(1-\eta^{*2})=\tfrac{(s+1)^2}{4s}$**, and it is read at the dimension in hand: at $n=12$ … it is about $16\%$."* The plan's "$\sigma=\eta^*(\Lambda/2C)$ moves with $\gamma$" matches [L157](../findings/second-order.md)'s $t=\Lambda/(2J\gamma)$ together with $J\gamma=C$. And *"**The gain over the frozen $(\tfrac12,\tfrac14)$ is $3.46$, not the recorded $4.8$**"* is verbatim.

**Checked independently at $m=6$.** $D=\tfrac{2m-1}{m-1}=\tfrac{11}5$, $\alpha^*=D/2=1.1$, $\gamma^*=\alpha^*/2=0.55$, $C^*=2+\tfrac{4\cdot5}{11}=\tfrac{42}{11}=3.8182$, $J^*=\tfrac{4(1+\alpha^*)}{\alpha^{*2}}=\tfrac{8.4}{1.21}=6.9421$, the record's numbers, and the plan's transcription of $C^*=2+\tfrac{4(m-1)}{2m-1}$ and $\gamma^*=\alpha^*/2$ is correct.

### 4.4 D4a, $n\approx1140$, not $1800$: **CONFIRMED**

[L158](../findings/second-order.md): *"**The extension 'provably so at every $n$ up to $\approx1800$' is withdrawn**: … carrying every constant to the corrected coefficient gives $S^*$ capped at $34.71$ against $1+\sqrt{n-2}$, so the crossing is $n\approx1140$."* Verbatim, and internally consistent: $1+\sqrt{n-2}=34.71\Rightarrow n=2+33.71^2=1138.4$.

### 4.5 D4b, branch 1 is $\Theta(n^{-3/2})$ at $w=\Theta(1)$: **CONFIRMED**

[L147](../findings/second-order.md): *"**THE RADIUS $r_n\gtrsim n^{-1-\beta}$ IS REFUTED** … branch 1 is $(c_p+u^2)/(S+au)$ with $f'(0)=-ac_p/S^2<0$, so its infimum is $2u^*/a=\Theta(n^{-3/2})$ at $w=\Theta(1)$, **too large on all of $\beta\in[0,\tfrac12)$**."* The plan's sentence is this sentence.

**Checked independently.** With $N(u)=au^2+2Su-ac_p$, the unique positive root is $u^*=(\sqrt{S^2+a^2c_p}-S)/a$, and $ac_p=au^{*2}+2Su^*$ gives $f(u^*)=\tfrac{2u^{*2}+2Su^*/a}{S+au^*}=\tfrac{2u^*}a$, the record's identity, reproduced. With $a=\Theta(n)$ from $C_\delta=O(n)$ and $c_p=\Theta(1/n)$, the regime $a^2c_p\gg S^2$ holds for $\beta<\tfrac12$ and $u^*\to\sqrt{c_p}$, so $f(u^*)=2\sqrt{c_p}/a=\Theta(n^{-1/2})/\Theta(n)=\Theta(n^{-3/2})$. The order is right.

### 4.6 D4c, "so $w=0$ is its maximum rather than its minimum": **REFUTED AS STATED**

**Locate.** [plan.md:133](../plan.md), I31: *"branch 1 being $(c_p+u^2)/(S+au)$ with $f'(0)<0$, **so $w=0$ is its maximum rather than its minimum**, so any $\beta>0$ eventually makes branch 1 bind."*

**What the record says.** [L147](../findings/second-order.md): *"$f'(0)=-ac_p/S^2<0$, so $u=0$ is **never** its minimum; the minimum is interior at $u^*$."* [L158](../findings/second-order.md) repeats it: *"its infimum is **strictly below** $\kappa/(nS)$ and does not sit at $u=0$."* Neither says maximum.

**Exhibit, in closed form.** $f(u)=(c_p+u^2)/(S+au)$ on the admissible $u\in[0,1]$ has one interior stationary point, a minimum; so it decreases on $[0,u^*]$ and increases on $[u^*,1]$, and its maximum on $[0,1]$ is at an endpoint. Comparing them,

$$f(0)\ge f(1)\iff c_p(S+a)\ge S(c_p+1)\iff a\,c_p\ge S .$$

With the record's own orders, $a=\Theta(n)$ and $c_p=\kappa/n$ with $\kappa\downarrow3\sqrt2$, so $ac_p=\Theta(1)$, while $S=\Theta(n^\beta)$. **For every $\beta>0$ the inequality fails for all large $n$**, and

$$f(0)=\frac{c_p}{S}=\Theta(n^{-1-\beta})\quad\text{against}\quad f(1)=\frac{c_p+1}{S+a}=\Theta(n^{-1}),$$

so $f(1)/f(0)=\Theta(n^{\beta})\to\infty$: **$u=0$ is not the maximum, and it is smaller than the other endpoint by the whole factor $n^\beta$ the sentence is about.** The clause's own conclusion ("*so any $\beta>0$ eventually makes branch 1 bind*"), is the correct one and follows from $f(0)=\Theta(n^{-1-\beta})$ being the *ceiling*, i.e. from $u=0$ being the direction where branch 1 is **smallest among the orders that matter**, not largest.

**A second, smaller slip in the same clause: the variable.** Branch 1 carries $u$ and branch 2 carries $w$, [L149](../findings/second-order.md)'s display at line 1224 writes $\min\big(\tfrac{c_p+u^2}{S+au},\ \tfrac{\sqrt{c_p+\rho^{\text{eff}}_nw^2}}{n^{1/2}+nw},\ \tfrac{\rho(H)}2\big)$. Writing branch 1's endpoint as "$w=0$" puts it at the direction [L148](../findings/second-order.md) empties **of branch 2**, and reading $\eta^*$ there is the error [L158](../findings/second-order.md) itself charges: *"$\eta^*$ was read at $w=0$, the one direction [L148](../findings/second-order.md) empties of branch 2."*

**Argue the opposite.** $f'(0)<0$ does make $u=0$ a **local** maximum of $f$ at the left endpoint, and in the sentence's context (a correction to a claim that $u=0$ was the *minimiser*), "maximum rather than minimum" reads as naming the endpoint's local character. That is a fair defence of the intent and it is why the verdict is `REFUTED AS STATED` rather than `REFUTED`: the fix is one word, "local". As written it asserts a global property that is false at every $\beta>0$, in a row whose entire subject is what happens as $\beta$ moves off zero, and it is the one of I31's four corrections that is not a quotation of the record.

## 5. What is owed

- **[plan.md](../plan.md) I1 and B1**: state the theorem as the disjunction $P(W)\le0\lor2P(W)^2\le3\lVert W\rVert^6$, or name the $\theta>0$ normalisation as a hypothesis of the set; and withdraw "no real-number layer", the base layer being $\mathbb Q$ and the equality case $\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$ not a $\mathbb Q$-point.
- **[plan.md](../plan.md) B1**: add the five inputs of §3.2, of which $\mathrm{Alt}(W_-)$ has no $\mathbb Q$-valued definition and so decides the layer question by itself.
- **[plan.md](../plan.md) I31**: "$w=0$ is its maximum" → "$u=0$ is never its minimum", the record's own wording.
- **[PencilConstants.lean](../lean/HamiltonsCubic/Results/PencilConstants.lean)**: drop the struck gloss on `theta0`; scope `rhoEff_pos`'s equivalence to $n\ge3$; record the $\tfrac29$ `HYPOTHESIS-DEBT` against the module docstring's "governed by"; and cite [RhoEff.lean](../lean/HamiltonsCubic/Results/RhoEff.lean) and [Theta0.lean](../lean/HamiltonsCubic/Results/Theta0.lean), which carry the same arithmetic in $\mathbb Q$ with no `sorry` and a threshold four dimensions lower.
