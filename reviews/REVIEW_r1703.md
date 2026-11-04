# REVIEW r1703: L143 proved unconditionally, the second-order bound pointwise (28cee279)

**Verdict: CONFIRMED, with two stale-record findings and two observations.** `second_order_pointwise` in [L143Attain.lean](../lean/HamiltonsCubic/Results/L143Attain.lean#L99) proves $P\le\lambda_{\max}p+B_5$ at every unit Weyl eigenframe, which is [second-order.md](../findings/second-order.md)'s bound (the display under "A bound that survives both regimes") with $p$ and $B_5$ exactly as [L143Assembly.lean](../lean/HamiltonsCubic/Results/L143Assembly.lean) defines them. `L143_unconditional` ([L143Attain.lean:143](../lean/HamiltonsCubic/Results/L143Attain.lean#L143)) is the record's statement $\sup_{\lVert W\rVert=1}\lvert P(W)\rvert\le1+\sqrt{n-2}$ on the unit sphere of $\mathcal W_n$ at every $n\ge4$, with `hn` its only hypothesis. The module builds and the audit screen reports 7/7 on the standard three axioms. The findings are that [bounds.md:33](../findings/bounds.md#L33) still names the second-order bound as "the one unchecked input" (G1) and that the row's marker still reads `statement: not typed` (G2).

| # | Claim | Verdict |
|---|---|---|
| 1a | `second_order_pointwise` is the record's $\theta\le\lambda_{\max}p+B_5$, $p=\sum_{\lambda>0}\lambda^2$, $B_5$ as L143Assembly defines it | **CONFIRMED** |
| 1b | $\mathop{\mathrm{tr}}W^3=\sum\lambda^3\le\lambda_{\max}p$ termwise, $\lambda\le0$ terms included | **CONFIRMED** |
| 1c | $\langle W,W^\#\rangle\le\tfrac12\sum\lvert\lambda_\gamma\rvert X_\gamma\le B_5$ via $\lvert S_\gamma\rvert\le X_\gamma$ and Cauchy–Schwarz | **CONFIRMED**, direction $\le$ at both steps |
| 1d | `sharpPair_T`'s $\tfrac12\sum\lambda_\gamma\lambda_\alpha\lambda_\beta c^2$ is the right starting point | **CONFIRMED**, a proved identity in the normalisation of the proved marginals |
| 2a | `L143_unconditional` is the record's headline at every $n\ge4$, on the unit Weyl sphere, no residual hypothesis | **CONFIRMED** |
| 2b | "proved" on the row covers every clause of the record's L143 Statement | **CONFIRMED** for the Statement, and the block's surrounding prose carries no further formal clause (see attack line 2) |
| 3 | Consistency with known values in the layer | **CONFIRMED**, no contradiction (screen) |
| 4 | Axioms: standard three only | **CONFIRMED** (screen by the repo's audit script, 7/7) |
| 5 | The record's prose and the row's marker are current | **STALE** at bounds.md:33 (G1) and the row marker (G2) |

One line: the record's L143 is now a kernel-checked theorem with no binder beyond $n\ge4$, and its second-order input is proved pointwise from two identities the layer already held, exactly as r1702's O2 predicted.

## Attack line 1: `second_order_pointwise`

- **What it reads.** For any `IsWeyl W`, `EigenFrame W v lam` with $\sum_a\lambda_a^2=1$, and any `amax` with $\lambda_b\le\lambda_{\rm amax}$ for all $b$: `Pcubic W ≤ lam amax * posMass lam + (1/2) * √(∑_a (∑_b ∑_c cst v a b c ^ 2 * |lam b| * |lam c|)^2)`. The right side is character for character the binder `hso` of `L143_of_second_order` and of `L143_headline`, which r1702 already matched to the record's $\lambda_{\max}p+B_5$ with $T=c^2$ and $\mu=\lvert\lambda\rvert$. The hypothesis `hmax` makes `amax` the record's $\lambda_{\max}$ exactly.
- **The starting point.** The proof rewrites `Pcubic W = trCube W + sharpPair W` by `trCube_frame` ($\sum\lambda^3$) and `sharpPair_T` ($\tfrac12\sum_{\gamma\alpha\beta}\lambda_\gamma\lambda_\alpha\lambda_\beta c_{\gamma\alpha\beta}^2$), both proved in [L41Statement.lean:810–830](../lean/HamiltonsCubic/Results/L41Statement.lean#L810). Since these are identities, the only fidelity question is whether `cst` is the record's $c'$, and it is: `B5_frame` proves $B_5\le\sqrt{n-2}$ from the pair cap 2 and the Killing row mass $2(n-2)$ in this same `cst`, and those marginals are the record's. A factor error in `cst` would break one of those two proved marginals.
- **Step 1, the cubic trace.** `posMass lam = ∑_a (if 0 < lam a then lam a^2 else 0)`. Termwise after `Finset.mul_sum`: at $\lambda_\gamma>0$, $\lambda_\gamma^3=\lambda_\gamma\cdot\lambda_\gamma^2\le\lambda_{\max}\lambda_\gamma^2$ since $\lambda_\gamma\le\lambda_{\max}$ and $\lambda_\gamma^2\ge0$. At $\lambda_\gamma\le0$ the right term is $\lambda_{\max}\cdot0=0$ and $\lambda_\gamma^3=\lambda_\gamma\cdot\lambda_\gamma^2\le0$. Both branches hold without any sign assumption on $\lambda_{\max}$. This is the record's "dropping the negative eigenvalues".
- **Step 2a, $\lvert S_\gamma\rvert\le X_\gamma$.** Each summand $\lambda_\gamma\lambda_\alpha\lambda_\beta c^2\le\lvert\lambda_\gamma\rvert\cdot(c^2\lvert\lambda_\alpha\rvert\lvert\lambda_\beta\rvert)$ by `le_abs_self` and $\lvert c^2\rvert=c^2$. Summing over $\alpha,\beta$ gives $\sum_\gamma\lambda_\gamma S_\gamma\le\sum_\gamma\lvert\lambda_\gamma\rvert X_\gamma$ with $X_\gamma=\langle T_\gamma\mu,\mu\rangle$, the record's first inequality $\langle W,W^\#\rangle\le\tfrac12\sum_\alpha\mu_\alpha\langle T_\alpha\mu,\mu\rangle$ after the factor $\tfrac12$.
- **Step 2b, Cauchy–Schwarz.** `Finset.sum_mul_sq_le_sq_mul_sq` gives $(\sum\lvert\lambda\rvert X)^2\le(\sum\lambda^2)(\sum X^2)=\sum X^2$, then `Real.abs_le_sqrt` and `le_abs_self` give $\sum\lvert\lambda\rvert X\le\sqrt{\sum X^2}$. This is the record's second inequality, and it uses $\sum\mu^2=1$ as the record does.
- **Assembly.** The final `linarith` combines $h_1$, $h_2a$, $h_2b$ with the positive factor $\tfrac12$, which is linear. Every inequality points the way the record's does.
- **Pointwise, not only at critical points.** The record says the bound "holds pointwise at every unit Weyl tensor" (bounds.md:33), and at unit norm $\theta=P$, so `Pcubic W` on the left is the record's $\theta$. The theorem is at least as strong as `hso` needs.
- **Hand screen against the record's own number.** At $W_{\mathbb{CP}^2}$'s unit spectrum $(2,-1,-1,0,0,0)/\sqrt6$: $\mathop{\mathrm{tr}}W^3=6/6^{3/2}=0.4082$ and $\lambda_{\max}p=(2/\sqrt6)(4/6)=0.5443$. These are second-order.md's "0.5443 against a truth of 0.4082", so step 1's normalisation agrees with the record at a point. Reported as a screen.

## Attack line 2: `L143_unconditional` against the record's block

- **What it reads.** `∀ R ∈ weylSphereSet (Fin n), |Pcubic2 R| ≤ 1 + √(n − 2)` under `hn : 4 ≤ n` alone. `weylSphereSet` is `{R | normSq2 R = 1 ∧ IsWeyl2 R}`, the unit sphere of $\mathcal W_n$, the domain r1701 and r1702 confirmed.
- **The proof discharges `hso` honestly.** At each critical `R` it builds the frame by `eigenFrame_exists`, derives $\sum\lambda^2=1$ from `normSq_frame`, `normSq_extend` and `hR.1` (the same derivation r1702 checked in `L143_headline`), picks `amax` by `Finset.exists_max_image` over `Finset.univ`, nonempty by `pairs_nonempty`, and applies `second_order_pointwise`, transporting back by `Pcubic_extend`. No hypothesis is left open.
- **`pairs_nonempty`.** The pair $(0,1)$ with $0<1$, valid from $n\ge2$. Correct and only needed for the argmax.
- **The record's Statement.** $\sup_{\lVert W\rVert=1}\lvert P(W)\rvert\le1+\sqrt{n-2}$. Covered at every $n\ge4$. The record names no range of $n$. At $n\le3$ the space $\mathcal W_n$ is zero, so its unit sphere is empty and the statement has no content there. The Lean restriction to $n\ge4$ loses nothing (O1).
- **Clauses of the block beyond the Statement.** The proof's inner steps (first term $\le1$, the displayed chain $0\le\langle T_\alpha\mu,\mu\rangle\le2$, the row-mass AM–GM, $B_5\le\sqrt{n-2}$, attainment at a critical point) are each typed and proved (`first_term_le`, `form_le`, `form_le_mass`, `B5_sq_le`, `B5_frame`, `B5_le_sqrt`, `sup_abs_attained`). The blockquote's F10 domination claim ($\mathrm{LP}(n)\le1+\sqrt{n-2}$, and the measured LP values) and "improves $\Theta(n)$ to $O(\sqrt n)$" are commentary about other results, not part of L143's Statement, and the row makes no claim about them. So "proved" describes everything the Statement asserts.

## Attack line 3: consistency with known values

- **The direction to test.** The headline is an upper bound, so a contradiction needs a unit Weyl tensor with $\lvert P\rvert>1+\sqrt{n-2}\ge1+\sqrt2=2.414$.
- **$W_{\mathbb{CP}^2}$.** `L24_nonvacuous` and `sup_abs_attained` give a critical $a$ with $P(a)\ge\sqrt{3/2}=1.2247$ in the same `Pcubic2`/`normSq2` normalisation. $1.2247\le2.414$ at $n=4$, and the gap grows with $n$.
- **Sphere products.** At the dimensions the record measured, nothing it reports approaches $\sqrt3$ (second-order.md: unconstrained ascent reaches $\sqrt{3/2}$ below $n=12$ and $\theta_0(12)$ at $n=12$, "nothing anywhere near $\sqrt3$"), and $\sqrt3<2.414\le1+\sqrt{n-2}$.
- **The record's own bound values.** second-order.md reports $\lambda_{\max}p+B_5$ between $1.08$ and $1.5443$ over the catalogue, each at or above the $\theta$ it bounds, consistent with the pointwise $\le$ direction and each below $1+\sqrt{n-2}$.
- **Conclusion.** No value in the layer or record contradicts the theorem. This is a screen of consistency, not evidence for it. The evidence is the kernel check.

## Attack line 4: axioms and build

- `lake build HamiltonsCubic.Results.L143Attain` completed successfully (8799 jobs), with only linter notes, and no `sorry` in the file.
- `python3 scripts/misc/axiom_audit.py --only L143Attain.lean`: "7/7 clean -- resting on the standard three alone". The seven are the file's theorems (`neg_mem_weylSphereSet`, `sup_abs_attained`, `sup_abs_le_of_critical`, `L143_headline`, `second_order_pointwise`, `pairs_nonempty`, `L143_unconditional`), and `evOf` and `vOf` are definitions. Screen, by the repo's script.

## The object that would break the claims

- **A `cst` normalisation off by a factor**, which would make `second_order_pointwise` a true theorem about a rescaled $B_5$. Looked for: `sharpPair_T` and the two marginals in `B5_frame` are proved in the same `cst`, so the scale is pinned twice, and a factor would falsify one of them.
- **A sign slip at $\lambda\le0$ in step 1**, which the record avoids by dropping those terms. Looked for: read both `split_ifs` branches, and the $\lambda\le0$ branch needs only $\lambda^3\le0$.
- **A unit Weyl tensor with $\lvert P\rvert>1+\sqrt{n-2}$.** Looked for: every exhibited value in the layer and record (attack line 3), and none comes close.
- **A residual binder hidden in `L143_headline`'s chain.** Looked for: `L143_unconditional`'s signature carries `hn` only, and the build accepted it.

## Findings

- **G1: [bounds.md:33](../findings/bounds.md#L33) is stale.** Its italic note ends "That leaves the second-order bound $\theta\le\lambda_{\max}p+B_5$ as the one unchecked input." That bound is now `second_order_pointwise`, and the headline is `L143_unconditional`. The note should name both and say L143 is machine-checked at every $n\ge4$. Owner: the research loop (the record's text).
- **G2: the row's marker reads `statement: not typed`.** [lean-layer.md](../.claude/skills/lean-layer.md) says a row whose file carries the lemma's own statement says `statement: typed`, and [L143Attain.lean](../lean/HamiltonsCubic/Results/L143Attain.lean) now carries it as `L143_unconditional`. The marker should read `statement: typed`. Owner: the lean loop.

## Observations

- **O1: the range $n\ge4$.** It is inherited from `sup_abs_le_of_critical`, and `second_order_pointwise` with `L143_at_frame` would prove the bound pointwise at every $n$ without the attainment step. Nothing is lost, since the sphere is empty at $n\le3$, and the detour through critical points is redundant but sound.
- **O2: the row's prose.** The new row keeps the old "the headline is typed modulo `hso`" paragraph and joins it with "standard three axioms. and `second_order_pointwise` discharges `hso`", a lowercase sentence start. The paragraph now describes a superseded intermediate state and could be cut to one clause.
