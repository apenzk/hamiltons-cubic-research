# Review r724, the typed statements and the plan corrections

*Gate 2, cold brief, 2026-09-06. Four claims recorded without review: the removability of the irrationality in [I1](../plan.md), the fidelity of [PencilConstants.lean](../lean/HamiltonsCubic/Results/PencilConstants.lean)'s two definitions to the record, the scope of [B1](../plan.md)'s "only `Qop` and `Pcubic` are missing", and four corrections written into I2, I6 and I31. **Analysis only**, the programme's standing rule ([analysis-only.md](../.claude/rules/analysis-only.md)) was in force, and the arithmetic below is screening of numerals this report records: reproducing $\theta_0$, $\rho^{\text{eff}}$, $J$ and $D(n)$ at four dimensions from closed forms already on the record, taking seconds, cited as a screen and never as evidence. No search, sweep or falsifier hunt was opened. Log: [agent_logs/r724.log](../agent_logs/r724.log).*

| # | claim | verdict |
| --- | --- | --- |
| A1 | $\theta\le\sqrt{3/2}\iff2P(W)^2\le3\lVert W\rVert^6$ once $\theta\le0$ is separated | **CONFIRMED AS ALGEBRA** |
| A2 | therefore stating I1's theorem needs no real-number layer, and the missing piece is B1 rather than mathematics | **REFUTED AS STATED** |
| B1 | `theta0` and `rhoEff` are the record's $\theta_0(n)$ and $\rho^{\text{eff}}_n$ | **CONFIRMED** |
| B2 | the three results state what the record holds about them | **REFUTED AS STATED** |
| C | the base layer blocks only on `Qop` and `Pcubic` | **REFUTED** |
| D1 | the radius is $\Omega(n^{-3/2})$, not $\Theta$ | **CONFIRMED** |
| D2 | L148 voids L146 at $w=0$ only, branch 1 present there at $c_p/S\le3/(n-2)$ | **CONFIRMED** |
| D3 | $\sigma$ does not factorise; $J^*$ is the reach's constant only to $O(t^2)$, about $16\%$ at $n=12$ | **CONFIRMED** |
| D4 | branch 2 binds to $n\approx1140$; branch 1 is $\Theta(n^{-3/2})$ at $w=\Theta(1)$ | **CONFIRMED** |

**Summary in one line.** The four plan corrections of claim D are faithful to [second-order.md](../findings/second-order.md) in every numeral and every hedge, and the two Lean definitions reproduce the record exactly at four dimensions, but both claims *about* those definitions overreach: the file states as a plain theorem a monotonicity the record calls false under the alternative reading of an open debt, and the plan's "only `Qop` and `Pcubic` are missing" omits the scalar field, the negative part, `Alt`, the orbit, and the link between the two encodings of `#`.

## 0. Conventions, fixed once

Quoted, not restated, from [conventions.md](../findings/conventions.md) and [second-order.md](../findings/second-order.md).

- $\theta$ is **$P(W)/\lVert W\rVert^3$**, and "at a critical point, $Q(W)=\theta W$", the two agree exactly on $\lVert W\rVert=1$ and differ by a factor $\lVert W\rVert$ off it.
- "**Critical point" is $Q(W)=\theta W$, the first-order condition on $\{\lVert W\rVert=1\}$**, the unit norm is part of the definition, not a normalisation applied afterwards.
- $\theta_0(n)^2=2(n-1)(n-2)/n^2$, **and nothing more**; the gloss "the value at the balanced sphere product" is retired, holding at even $n$ only, the diagonal maximum being $\Theta_n$.
- $\rho^{\text{eff}}_n=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert$ with $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$, closed form $\sqrt6-\theta_0(n)\frac{n+16}{2(n-2)}$ ([L149](../findings/second-order.md)).
- $S(W):=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)\ge0$, the gradedness slack ([ungraded-slack.md](../findings/ungraded-slack.md)), measured after normalising $W$ to $\theta>0$.
- $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$, and $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ with $\mathrm{Alt}$ the orthogonal projection onto $\Lambda^4$.

## 1. Claim A, the irrationality, and what removing it does not buy

### 1.1 The equivalence, both directions

Take $\theta=P(W)/\lVert W\rVert^3$, so $P=\theta\lVert W\rVert^3$ and $P^2=\theta^2\lVert W\rVert^6$ identically. Then for $W\ne0$:

- **$\theta\le0$.** $\theta\le\sqrt{3/2}$ holds trivially; the squared form may fail, and fails exactly on $\theta<-\sqrt{3/2}$.
- **$\theta>0$.** $2P^2\le3\lVert W\rVert^6\iff2\theta^2\lVert W\rVert^6\le3\lVert W\rVert^6\iff\theta^2\le\tfrac32\iff\theta\le\sqrt{3/2}$.

So the disjunction "$\theta\le0$ or $2P(W)^2\le3\lVert W\rVert^6$" is **equivalent** to $\theta\le\sqrt{3/2}$, and the exponent $6$ is what identifies which $\theta$ is meant: it is the degree-$0$ one of [conventions.md](../findings/conventions.md), $P/\lVert W\rVert^3$, whose square is $\theta^2\lVert W\rVert^6$. The plan's line is exact. **The case split is load-bearing in one direction only** ($\Leftarrow$ needs nothing, $\Rightarrow$ needs it) and it is what supplies the missing hypothesis $\theta\ge-\sqrt{3/2}$, which no part of I1's conclusion provides.

### 1.2 The reading under which it fails, and why the defence holds

Under the item's own displayed set, $\theta$ is the **eigenvalue** in $Q(W)=\theta W$, which is degree $1$: $Q(cW)=c^2Q(W)=c\theta\,(cW)$. Then $P=\theta\lVert W\rVert^2$ and the squared form reads $2\theta^2\le3\lVert W\rVert^2$, i.e. $\theta\le\sqrt{3/2}\,\lVert W\rVert$, not $\theta\le\sqrt{3/2}$.

**Concretely, at a named point.** Let $W$ be padded $W_{\mathbb{CP}^2}$ at $\lVert W\rVert=1$, where the record puts $\theta=\sqrt{3/2}$ ([M(n)](../findings/conventions.md) and [I1](../plan.md)'s own equality case), and set $W'=2W$. Then $Q(W')=4Q(W)=2\sqrt{3/2}\,W'$, so the eigenvalue at $W'$ is $2\sqrt{3/2}=2.4495>\sqrt{3/2}$, while $P(W')=8\sqrt{3/2}$ gives $2P(W')^2=192=3\cdot2^6=3\lVert W'\rVert^6$, **the squared form holds with equality at a point where the eigenvalue statement fails**, and $\theta>0$ there, so the case split does not reach it.

**The strongest defence, and it succeeds.** [conventions.md](../findings/conventions.md) makes $\lVert W\rVert=1$ part of the definition of "critical point", so $W'$ is not in I1's set and the two readings of $\theta$ coincide throughout it. On that domain the equivalence is exact, and the homogeneous form is the correct scale-covariant statement of it. **A1 stands**; what is owed is one word, I1's displayed set carries no $\lVert W\rVert=1$, and without it the supremum is $+\infty$ by the same scaling.

### 1.3 Can $\theta\le0$ occur on the set?

The cheap argument that it can, $Q$ is quadratic, so $Q(-W)=Q(W)=-\theta(-W)$ and the critical set is symmetric with $\theta\mapsto-\theta$, **does not survive the constraint $S=0$**: $S$ is built from $W_-$, and $(-W)_-=W_+$, so $S$ is not $W\mapsto-W$ symmetric and the reflected point need not lie in the set. Nor can $\theta\le0$ be excluded from the closed form: with $W_-\ne0$ at every nonzero trace-free $W$, $S=0$ reads $\mathop{\mathrm{tr}}(W_-^2)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)$, whose right side only **grows** as $\theta$ goes negative, since $\mathop{\mathrm{tr}}(W_-)\ge0$. So the branch is not visibly empty. Against that, [conventions.md](../findings/conventions.md) instructs "**normalise $W$ to $\theta>0$ before measuring $S$**", under which the set carries $\theta>0$ by construction and the split is vacuous. **Either way the split is sound**: it is needed if the branch is inhabited and free if it is not, and the plan is right to write it in rather than argue the point.

### 1.4 A2, what "no real-number layer" does not cover

The claim as written is *"$\theta\le\sqrt{3/2}$ needs no real-number layer … the irrationality lives entirely in the normalisation"*, and in the B1 row *"the missing piece is B1 rather than mathematics"*. The first half is true of **the constant**: squaring removes the only surd in I1, and $\sqrt{3/2}$ is the only one the item carries. Both halves are false of **the statement**:

- **The base layer is over $\mathbb Q$.** [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) and [Curvature.lean](../lean/HamiltonsCubic/Base/Curvature.lean) are `Matrix ι ι ℚ` throughout. A universally quantified inequality over $\mathcal W_n(\mathbb Q)$ is not [Conjecture A](../README.md): the hypothesis $Q(W)=\theta W\wedge S=0$ cuts out a positive-codimension variety, whose rational points are a countable subset carrying no information about the real supremum. In the limiting case the $\mathbb Q$-statement is **vacuously true** and proves nothing, and no argument on the record rules that case out.
- **"Non-diagonal" is an $O(n)$-quantified condition.** [conventions.md](../findings/conventions.md): "diagonality is MEASURED as off-diagonal Frobenius mass minimised over $O(n)$". Over $\mathbb Q$ the minimisation runs over $O(n)(\mathbb Q)$, a proper subgroup, so the $\mathbb Q$-reading of "non-diagonal" names a **strictly larger** set than the real one and the resulting statement is strictly stronger than, and unequal to, I1.
- **$S=0$ needs $W_-$**, i.e. the real functional calculus, see §3.2.

So I1's theorem needs $\mathbb R$ in the quantifier even though it needs no `Real.sqrt` in the constant, and it needs $S$, $\mathrm{Alt}$ and the $O(n)$-orbit besides. **A2 is refuted as stated**: the missing piece is not B1 alone, and the mathematics I1 is short of is not only its proof.

## 2. Claim B, the two definitions, and the three statements

### 2.1 The definitions reproduce the record exactly

[PencilConstants.lean](../lean/HamiltonsCubic/Results/PencilConstants.lean) sets `theta0 n = Real.sqrt (2*(n-1)*(n-2)) / n`, whose square is $2(n-1)(n-2)/n^2$, [conventions.md](../findings/conventions.md)'s closed form, with the coercion written as `((n : ℝ) - 1)` so no truncated $\mathbb N$-subtraction enters. And `rhoEff n = Real.sqrt 6 - theta0 n * (n+16) / (2*(n-2))` is the record's closed form. The two forms agree by one line:

$$3\theta_0\frac{n-8}{2(n-2)}-\frac29\cdot9\big(\theta_0-\sqrt{3/2}\big)=\theta_0\frac{3(n-8)-4(n-2)}{2(n-2)}+2\sqrt{3/2}=\sqrt6-\theta_0\frac{n+16}{2(n-2)}.$$

**By hand at $n=12$.** $\theta_0(12)=\sqrt{220}/12=\sqrt{55}/6=1.236033$, matching the record's tabulated $1.236033$; $(n+16)/(2(n-2))=28/20=7/5$, and $\tfrac75\cdot\tfrac{\sqrt{55}}6=\tfrac7{30}\sqrt{55}$, so $\rho^{\text{eff}}_{12}=\sqrt6-\tfrac7{30}\sqrt{55}=0.7190434$, the record's printed $0.7190434$ to all seven digits. Screened at three more dimensions against [L157](../findings/second-order.md)'s printed row: $0.8724$, $0.9856$, $1.0727$ at $n=14,16,18$, all reproduced. The docstring's polynomial form is also an identity, not a paraphrase: $\sqrt6>\theta_0\frac{n+16}{2(n-2)}\iff12n^2(n-2)>(n-1)(n+16)^2\iff11n^3-55n^2-224n+256>0$, worth $8656$ at $n=12$ as the record says. **B1 confirmed.**

### 2.2 What the three statements say that the record does not

- **The `theta0` docstring is the retired gloss.** It reads "the balanced product's critical value". [conventions.md](../findings/conventions.md) says of exactly that phrase: "**the gloss 'the value at the balanced sphere product' stood here until 2026-09-04 and is what regrew [L0](../findings/problem.md)'s refuted constant**"; the closed form is the value at even $n$ only. The function is defined at every `n : ℕ` and the three results quantify over `12 ≤ n`, odd $n$ included. **At $n=13$** the gloss is false in closed form: $\theta_0(13)^2=264/169=1.5621$ against $\Theta_{13}^2=2\cdot12\cdot10/(14\cdot11)=240/154=1.5584$, the gap being conventions.md's own $8(n-1)/(n^2(n+1)(n-2))=96/26026$. The record's $\rho^{\text{eff}}_n$ likewise exists only at $n=2m$, $m\ge6$ ([L149](../findings/second-order.md), which records that at $n=10$ "$\lvert\kappa_n\rvert$ is negative and $\rho^{\mathrm{eff}}$ has no definition"). The statements are true as arithmetic and wider than the object.
- **The `2/9` debt is resolved by the definition and named nowhere.** [L149](../findings/second-order.md) carries an open `HYPOTHESIS-DEBT` on the penalty coefficient, and states the consequence flatly: "**At penalty coefficient $1$ the record's own values run $0.6400\to0.4161$, decreasing, so monotonicity is false under that reading rather than merely unproved.**" Screened: the coefficient-$1$ form $3\theta_0\frac{n-8}{2(n-2)}-\lvert\kappa_n\rvert$ gives $0.640026,0.613843,0.592772,0.575582$ at $n=12,14,16,18$, decreasing, as the record says. The Lean file bakes the $\tfrac29$ into the definition, so `rhoEff_strictMonoOn` is a true statement about the function it defines; but its header sentence ("**the penalised pencil's radius is governed by `rhoEff`**"), asserts the identification of the $(2,2)$ four-set block with $\Lambda^2\!\otimes\!\Lambda^2$ that the record records as owed, and the file carries no `HYPOTHESIS-DEBT` marker of any kind. That is the record's own load-bearing hedge, dropped in the transcription.
- **There is already an unlinked $\mathbb Q$ development of both constants, and it proves more.** [Theta0.lean](../lean/HamiltonsCubic/Results/Theta0.lean) defines `evenSq n = 2*(n-1)*(n-2)/n^2` and proves `evenSq 12 = 55/36` and monotonicity of $\theta_0^2$, kernel-checked; [RhoEff.lean](../lean/HamiltonsCubic/Results/RhoEff.lean) proves the polynomial identity `12n²(n-2) - (n-1)(n+16)² = D n` by `ring`, `D 7 < 0 < D 8`, `D_increasing` from $n=8$, and the integer comparison $49\cdot55<6\cdot900$, all without `sorry`. So the docstring line "Equivalent to `11n³ − 55n² − 224n + 256 > 0`", which PencilConstants states as a comment against a `sorry`, is **already a theorem three files away**, and RhoEff.lean's threshold is $n\ge8$ where PencilConstants hypothesises $12\le n$. [PencilConstants.lean](../lean/HamiltonsCubic/Results/PencilConstants.lean) imports only `Mathlib` and introduces a second `theta0` in a different namespace and a different scalar type, so nothing connects the two and the $\mathbb R$-side `sorry`s cannot consume the $\mathbb Q$-side proofs.

**B2 refuted as stated.** The definitions are right; the file says of them one thing the record calls conditional, one thing the record retired, and one thing the record already proved elsewhere.

## 3. Claim C, what a general I1 or I2 also needs

The row's three factual assertions check out. [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) does fix `sharpMat`, `Qop`, `Pcubic` and `IsWeyl` at `Matrix (Fin 6) (Fin 6) ℚ`, which is $\Lambda^2\mathbb R^4$ and so $n=4$; [Curvature.lean](../lean/HamiltonsCubic/Base/Curvature.lean) does carry `sharpQF'`, `RicOf`, `bianchiOf` and `IsWeylOf` over `{ι : Type*} [Fintype ι] [DecidableEq ι]`, with the pair table replaced by the ordered-pair sum and its compensating $\tfrac12$. **The word that fails is "only".** Six things a general statement of I1 or I2 needs are not named by the row.

### 3.1 The scalar field

Both files are over $\mathbb Q$; [PencilConstants.lean](../lean/HamiltonsCubic/Results/PencilConstants.lean) is over $\mathbb R$. Adding `Qop` and `Pcubic` at general `ι` over $\mathbb Q$ therefore does **not** let "the constant chain follow": the constants are real and the forms would be rational, with no map between them. And the domain objection of §1.4 applies to the statement itself.

### 3.2 The negative part, which $\mathbb Q$ cannot carry

I2's functional is $\Phi=P-\kappa_n\delta^2$ with $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$, and $W_-=\tfrac12(\lvert W\rvert-W)$ is a spectral construction. **It does not preserve $\mathbb Q$.** In closed form, $W=\begin{pmatrix}1&1\\1&0\end{pmatrix}$ over $\mathbb Q$ has $\lambda_\pm=(1\pm\sqrt5)/2$ and $(W_-)_{11}=(3\sqrt5-5)/10=0.17082\ldots$, irrational. So the base layer as constituted cannot define $\delta^2$ at all, at any index type, and the whole of [L141](../findings/second-order.md), [L145](../findings/second-order.md) and [L148](../findings/second-order.md) rests on it, L148's content is precisely *which* $W(t)_-$ is coordinate-diagonal. This is the largest missing piece and the row does not mention it.

### 3.3 `Alt`

$\mathrm{Alt}$ is the orthogonal projection onto $\Lambda^4$ carrying its $\tfrac13$ ([conventions.md](../findings/conventions.md)). `bianchiOf` computes the *numbers* $\mathrm{Alt}$ annihilates, index tuple by index tuple; it is not the projection, has no norm attached, and $\lVert\mathrm{Alt}(X)\rVert$ is what $\delta^2$ needs.

### 3.4 The tie between `ι` and `n`

`Curvature.lean` declares `variable {ι} … {n : ℕ}` with no hypothesis `Fintype.card ι = n`, and `n` is used only in the unused abbreviation `Biv`. Every constant in play, $\theta_0(n)$, $c_p=3\theta_0/(n-2)$, $\rho^{\text{eff}}_n$, the anchor $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, the hypothesis $n\ge12$, is a function of $n$, so no statement of I1 or I2 is expressible until that hypothesis is added. Related and sharper: **the anchor itself is not proved at general `ι`.** `sharpQF'_id_four/five/six` are three `native_decide` spot checks at `Fin 4`, `Fin 5`, `Fin 6`. Sharp.lean's own header says "if `#` were normalised wrong, everything downstream would be wrong by a constant, so the anchor is proved before anything is built on it", at general `ι` it is not proved, it is sampled.

### 3.5 No bridge for `#`

[Bridge.lean](../lean/HamiltonsCubic/Base/Bridge.lean) relates the two encodings for **Ricci** (`RicOf_ofMatrix`, `isRicciFlat_iff`) and for **Bianchi** (`bianchiOf_ofMatrix`, `isBianchi_iff`), and for nothing else. There is no lemma `sharpQF (ofMatrix R) = sharpQF' R` or its equivalent. So a general `Qop'` built on `sharpQF'` would be a second, independent construction of the one operator whose normalisation the record calls its most expensive convention, with no theorem tying it to the audited $n=4$ one, and the conversion is exactly where the traps live: `Pcubic R = (Rᵀ * Qop R).trace` is a Λ²-level Frobenius trace that in the map encoding must be rewritten as $\tfrac12\sum_{i,j}\langle R\varphi_{ij},Q(R)\varphi_{ij}\rangle$ with `inner2`'s $\tfrac12$ and the ordered-pair $\tfrac12$ both accounted, the misplacement of which [conventions.md](../findings/conventions.md) says "inflates every $\theta$ by $\sqrt2$".

### 3.6 The rest of I2's vocabulary

$W^*=S^m\times S^m$ as a term; the orbit $SO(n)\cdot W^*$ and its tangent space; the normal space and the two orthogonality hypotheses $H\perp W^*$, $H\perp T_{W^*}\mathcal O$ that [L145](../findings/second-order.md) records as used-and-unstated and without which the displayed infimum is zero; the second variation as an object; $\kappa_n$; and for I1 additionally $S(W)$ and "non-diagonal". **C is refuted**: `Qop` and `Pcubic` at general `ι` are necessary and are a small fraction of what is missing, and the row's inference ("after which both items are statable"), does not hold.

## 4. Claim D, the four corrections

### 4.1 $\Omega$, not $\Theta$, CONFIRMED

[L145](../findings/second-order.md)'s box: "**THE $\Theta$ THIS BOX CARRIED IS REFUTED, AND THE UPPER HALF IS ARGUED NOWHERE ON THE RECORD.** *No statement of the form $r_n=O(\cdot)$ appears in this entry or in [L146](../findings/second-order.md)–[L158](../findings/second-order.md)* … **The chain cannot yield an upper bound at all**, every ingredient bounds a denominator above or a numerator below". The plan's sentence is that, clause for clause, including the correct treatment of the one apparent counterexample: [L147](../findings/second-order.md)'s $\Theta(n^{-1})$ is a ceiling on **what the route can prove**, which the record distinguishes from a bound on $r_n$ in the same box. The step table's row also reads "CONFIRMED as a lower bound", with the equality reading withdrawn. Nothing to attack.

### 4.2 L148 voids L146 at $w=0$ only, CONFIRMED, and it repairs the record

[L148](../findings/second-order.md)'s statement: "*the branch that vanishes there is the second one alone: at $w=0$ the first branch is $c_p/S\le3/(n-2)$, finite and positive, and it is what proves the route's ceiling.*" The inequality checks in closed form: $c_p=3\theta_0/(n-2)$ and $S\ge\theta_0$, so $c_p/S\le c_p/\theta_0=3/(n-2)$ exactly, which is [L147](../findings/second-order.md)'s "proved, by $c_p/S\le c_p/\theta_0=3/(n-2)$ alone, exact and unconditional in $\beta$".

**The one place the plan and the record differ, and the plan is right.** [L146](../findings/second-order.md)'s own box still says "**AND LEMMA L148 DISPLACES THIS LEMMA ENTIRELY** … *What it establishes about the ten-summand infimum is nothing*". That is contradicted eleven lines later by [L149](../findings/second-order.md), whose first input is "$\lVert H\rVert_{op}\le\lVert H_s\rVert_{op}+\lVert H_r\rVert_{op}\le\Theta(n^{-1/2})+w$, by the triangle inequality and [Lemma L146](../findings/second-order.md)", a use at every $w$. The plan's "voids the first **at $w=0$ only** … and L149 consumes L146's envelope at every $w$" is the reading that makes the two entries consistent, and it is the one L149 actually runs on. **The defect is in L146's box, not in the plan**; a repair belongs there and is out of scope for this report.

### 4.3 $\sigma$ does not factorise, CONFIRMED

[L156](../findings/second-order.md)'s closing block: "**So $\gamma$ does not separate from $\sigma$**: at $\gamma=d/2$ the reach has $\partial_\gamma(\gamma\eta^*)>0$ for every $t>0$, and the reach's own optimum is the larger $\gamma^\dagger$"; "$C^*$, $J^*$ are the reach's constants to $O(t^2)$"; "**The licence is exactly $J(\gamma^\dagger)/J(\gamma^*)=1/(1-\eta^{*2})=\frac{(s+1)^2}{4s}$** … at $n=12$ … it is about $16\%$"; and "**The gain over the frozen $(\tfrac12,\tfrac14)$ is $3.46$, not the recorded $4.8$**". The plan's four assertions map one-to-one onto those, and the crossing it prints, $\sigma=\eta^*(\Lambda/2C)$, is L156's "the crossing is $t=\Lambda/(2J\gamma)=\Lambda/(2C)$".

Screened: at $m=6$, $\alpha^*=11/10$, $J^*=4(1+\alpha^*)/\alpha^{*2}=6.9421$; at the frozen $(\tfrac12,\tfrac14)$, $d=\tfrac12$ and $C=\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}=6$, so $J=24$ and the ratio is $24/6.9421=3.457$. And $(s+1)^2/(4s)$ over the record's $t\in[0.50036,0.96209]$ runs $1.0774$ to $1.1640$. **One nuance worth recording**: "about $16\%$" is the *top* of that interval, the bottom being $7.7\%$, the plan reproduces the record's own phrasing, and the record's own phrasing quotes its worst case.

### 4.4 $n\approx1140$, and branch 1 at $\Theta(n^{-3/2})$, CONFIRMED

[L158](../findings/second-order.md): "**The extension 'provably so at every $n$ up to $\approx1800$' is withdrawn** … carrying every constant to the corrected coefficient gives $S^*$ capped at $34.71$ against $1+\sqrt{n-2}$, so the crossing is $n\approx1140$." Screened for internal consistency: $1+\sqrt{n-2}=34.71$ gives $n=1138.4$, which is the record's $\approx1140$. And [L147](../findings/second-order.md): "**THE RADIUS $r_n\gtrsim n^{-1-\beta}$ IS REFUTED** … branch 1 is $(c_p+u^2)/(S+au)$ with $f'(0)=-ac_p/S^2<0$, so its infimum is $2u^*/a=\Theta(n^{-3/2})$ at $w=\Theta(1)$". The plan's I31 text carries both, with the right attributions and with the conclusion the record draws (that I31's constant is not load-bearing at any dimension the programme reaches), kept intact.

## 5. What is owed, in order

1. **I1's displayed set carries no $\lVert W\rVert=1$** ([plan.md](../plan.md)), without which its supremum is $+\infty$ by scaling and its squared form is a different statement (§1.2). One word.
2. **The B1 row's "only"** ([plan.md](../plan.md)) should name the scalar field, $W_-$, $\mathrm{Alt}$, $\mathrm{card}\,\iota=n$, the `#` bridge and I2's geometric vocabulary, or drop the inference that both items become statable (§3).
3. **[PencilConstants.lean](../lean/HamiltonsCubic/Results/PencilConstants.lean)** should carry the $\tfrac29$ `HYPOTHESIS-DEBT` on `rhoEff`, restrict or annotate the odd-$n$ scope, drop the retired gloss on `theta0`, and import [Theta0.lean](../lean/HamiltonsCubic/Results/Theta0.lean) and [RhoEff.lean](../lean/HamiltonsCubic/Results/RhoEff.lean) rather than restate them (§2.2).
4. **[L146](../findings/second-order.md)'s "displaces this lemma entirely" box** contradicts [L149](../findings/second-order.md)'s use of it at every $w$; the plan already carries the correct reading (§4.2).
