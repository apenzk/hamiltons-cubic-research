# REVIEW r1906: L216Gen, Lemma L216 at every gapped critical orbit

**Gate 2 review of [L216Gen.lean](../lean/HamiltonsCubic/Results/L216Gen.lean) (commits aa38f425 and 4dad80d1), which moves the [lean/INDEX.md](../lean/INDEX.md) "L216 (statement)" row to proved.** The file types step 1 and the final inference of [Lemma L216](../findings/second-order.md#lemma-l216-an-explicit-isolation-radius-at-every-quantitatively-nondegenerate-critical-orbit), instantiates the record's radius through L143, and types the corollary at every sphere product off (3, 3). Every claim holds. The observations concern stale prose in the INDEX row and in the findings Lean note, and two items the record states that the file leaves to arithmetic by hand.

| # | Claim | Verdict |
|---|---|---|
| 1 | `cubDer_eq` is `3 T(c, c, c')`, and `cubDer_crit` kills the rotation derivative at a critical point on the circle | CONFIRMED WITH OBSERVATIONS |
| 2 | `L216_general` is Lemma L216 at every gapped critical orbit with `M` any bound on `|P|` | CONFIRMED |
| 3 | `L216_radius` and `L216_sphere_radius` are the record's radius and corollary | CONFIRMED WITH OBSERVATIONS |
| 4 | the generator-tangent hypothesis is the record's `H ⊥ T_u𝒪` | CONFIRMED WITH OBSERVATIONS |
| 5 | standard three axioms, and the hypothesis inventory | CONFIRMED |
| 6 | INDEX row and findings Lean note | CONFIRMED WITH OBSERVATIONS |

**One line: the lemma and its sphere-product corollary are kernel-checked as stated, on the standard three axioms, with the record's `r ≤ 2/3` derived rather than assumed, and the surrounding prose lags the file in two places.**

## Conventions

- `Tsym` is the symmetrised trilinear form of [L214Op.lean](../lean/HamiltonsCubic/Results/L214Op.lean), with `Tsym R R R = P(R)` (`Tsym_diag`) and `Tsym W W x = θ⟨W, x⟩` at `Q(W) = θW` (`Tsym_crit`).
- `cub q x y = q₀x³ + q₁x²y + q₂xy² + q₃y³`, `Dq q = (q₁, 2q₂ − 3q₀, 3q₃ − 2q₁, −q₂)` (the rotation derivative `−yF_x + xF_y`), and `qP W H = (P(W), 3T(W,W,H), 3T(W,H,H), P(H))`, all from [L216Bern.lean](../lean/HamiltonsCubic/Results/L216Bern.lean).
- `rotR U V` is `cU Uᵀ ∘ V ∘ cU U`, the `O(n)` action on curvature operators, and `tang u j k` is the generator orbit tangent `[ad_{φ_jk}, u]` ([L217Gen.lean:34](../lean/HamiltonsCubic/Results/L217Gen.lean#L34)).
- "Critical point of `P` on the unit sphere of 𝒲ₙ" is `Q(W) = λW`, as [conventions.md](../findings/conventions.md) line 151 fixes. Since `Q` preserves 𝒲ₙ (Böhm–Wilking, recorded in the same file's Φ row), this is exactly the Lagrange condition for the restriction of `P` to the unit Weyl sphere.

## The source, verbatim

**Statement.** "Let $W_0$ be a unit critical point of $P$ with $\theta_0=P(W_0)>0$ and $e=W_0/\theta_0$, and suppose that $\langle L_eH,H\rangle\le\tfrac12-\gamma$ for every unit $H\perp W_0$ orthogonal to the orbit tangent $T_{W_0}\mathcal O$, with $\gamma>0$. Then no critical point of $P$ on the unit sphere of $\mathcal W_n$ lies within geodesic distance $$r=\frac{4\,\theta_0\,\gamma}{9\,\big(1+\sqrt{n-2}\big)}$$ of the orbit $\mathcal O=O(n)\cdot W_0$, other than the points of $\mathcal O$ itself."

**Corollary.** "For $S^p\times S^q$ with $p,q\ge3$ and $(p,q)\ne(3,3)$, [L27] makes the $\tfrac12$-eigenspace exactly the orbit tangent and, with [L26]'s $\mu=\frac{n-2}{2(p-1)(q-1)}$, gives the gap in closed form, $$\gamma_{p,q}=\min\Big(\frac1{2(p-1)},\ \frac1{2(q-1)},\ \frac12-\mu\Big).$$ At the balanced product, $n=2m\ge8$, this is $\gamma=1/(n-2)$ and $$r_n=\frac{4\,\theta_0(n)}{9\,(n-2)\,\big(1+\sqrt{n-2}\big)}=\Theta\big(n^{-3/2}\big),$$ which is $0.0246$ at $n=8$ and $0.0132$ at $n=12$."

**Step 1.** "The geodesic. $\mathcal O$ is compact, so for $W$ on the sphere at distance $s=\operatorname{dist}(W,\mathcal O)$ with $0<s<r$ the distance is attained at some $W_1=g\cdot W_0$, and by the first variation the minimising great circle leaves $W_1$ with unit velocity $H\perp T_{W_1}\mathcal O$, also $H\perp W_1$. So $W=\cos s\,W_1+\sin s\,H$, exact for $0<s<\pi$. By equivariance, $P(g\cdot X)=P(X)$ and $L_{e_1}=gL_eg^{-1}$ with $e_1=W_1/\theta_0$, so the gap hypothesis holds at $W_1$ with the same $\gamma$ and $\theta_0$. The nearest point need not be unique, any minimiser serving. And $r\le\tfrac23$, so every $s$ the proof meets lies well inside $(0,\pi)$: Bernstein twice gives $\lvert\phi''(0)\rvert\le9M$, and step 3 gives $6\theta_0\gamma\le\lvert\phi''(0)\rvert$, so $r=4\theta_0\gamma/(9M)\le\tfrac23$ ([r932]). The first version wrote $s\in(0,\pi/2)$ and never showed $r$ below it, which [r931] found, repairing it by $r\le\pi$ since $-W_1$ is critical on every normal circle. The nearest-point argument is [L134](d)'s, which already joins a point near an orbit to its nearest orbit point by a normal geodesic."

**Step 5.** "The sign. Taylor's theorem with the two bounds gives $\phi'(\sigma)\le-6\theta_0\gamma\,\sigma+\tfrac{27M}2\sigma^2$, which is negative for $0<\sigma<\frac{12\theta_0\gamma}{27M}=r$. If $W=\phi$'s point at $\sigma=s$ were critical, the Riemannian gradient of $P$ there would vanish, and $\phi'(s)$ is that gradient paired with the unit tangent of the circle, so $\phi'(s)=0$. That contradicts the negativity just shown whenever $0<s<r$. $\square$"

## Hypothesis inventory

| Declaration | Hypotheses | Record counterpart |
|---|---|---|
| `cubDer_eq` | none beyond `u v x y` | the identity `φ'(σ) = DP[c'] = 3T(c,c,c')` |
| `cubDer_crit` | `‖u‖ = ‖v‖ = 1`, `⟨u,v⟩ = 0`, `c = xu + yv` self-adjoint with `Q(c) = λc` | step 5, "φ'(s) = 0" at a critical point |
| `L216_general` | `u` unit Weyl, `Q(u) = θu`, `θ > 0`, `γ > 0`, `hgap` over unit Weyl `H ⊥ u` with `H ⊥ tang u j k` for all `j ≠ k`, `M > 0`, `|P| ≤ M` on the unit Weyl sphere, `W` unit Weyl with `Q(W) = λW`, `∃ U` orthogonal with `cos r < ⟨U·W, u⟩` | the statement, with `M` general |
| `L216_radius` | as above with `n ≥ 4` and `M = 1 + √(n−2)` discharged by `L143_unconditional` | the statement exactly |
| `crossOrbit_eq_tang` | `|T|, |Tᶜ| ≥ 2` | L27Span's cross-pair orbit tangent is `tang` |
| `L216_sphere_radius` | `n ≥ 4`, `|T|, |Tᶜ| ≥ 3`, not both 3, `t > 0`, unit normalisation, `W` as above, the tube hypothesis with `θ = t(p+q−1)` and `γ = ½ − lamTop p q` | the corollary |

`hM0` is implied by `hMb` whenever a unit Weyl operator exists (as r1866 O3 found for the sibling), and `hθ`, `hγ` are the record's `θ₀ > 0`, `γ > 0`. No hypothesis is vacuous: at `W = u` with `U = 1` every hypothesis of `L216_sphere_radius` holds, `cos r < 1` because `r > 0`.

## 1. `cubDer_eq` and `cubDer_crit`

By hand, with `q = qP u v`, `Dq q = (3T_uuv, 6T_uvv − 3P_u, 3P_v − 6T_uuv, −3T_uvv)`. Expanding `T(c,c,c') = −y T(c,c,u) + x T(c,c,v)` with `T(c,c,u) = x²P_u + 2xyT_uuv + y²T_uvv` and `T(c,c,v) = x²T_uuv + 2xyT_uvv + y²P_v` gives `3T(c,c,c') = 3T_uuv x³ + (6T_uvv − 3P_u)x²y + (3P_v − 6T_uuv)xy² − 3T_uvv y³`, which is `cub (Dq q) x y` coefficient by coefficient. The kernel agrees ([L216Gen.lean:39](../lean/HamiltonsCubic/Results/L216Gen.lean#L39)).

`cubDer_crit`: `Tsym_crit` turns `T(c,c,c')` into `λ⟨c, c'⟩ = λ(−xy‖u‖² + xy‖v‖² + (x² − y²)⟨u,v⟩)`, which is zero from `‖u‖ = ‖v‖` and `⟨u,v⟩ = 0`. **`x² + y² = 1` is neither assumed nor needed**, the condition `Q(c) = λc` being scale-covariant and the cancellation using only equal norms and orthogonality. So the lemma is slightly more general than its use, which applies it at `(cos s, sin s)` (O1).

## 2. `L216_general`

**The tube hypothesis is the record's geodesic tube.** For unit `X, Y` on the sphere, the geodesic distance is `arccos⟨X, Y⟩`. `rotR U` is an isometry of the Weyl operators (`normSq2_rotR`), so `⟨U·W, u⟩ > cos r` says `U·W` lies within distance below `r` of `u`, equivalently `W` within distance below `r` of `U⁻¹·u ∈ 𝒪`. The record's "within geodesic distance r" is read as strict by its own step 1 (`0 < s < r`), matching the strict inequality. The conclusion `∃ U, U·W = u` is `W ∈ 𝒪`.

**Criticality.** `Q(W) = λW` is the convention's definition, and with `Q(𝒲ₙ) ⊆ 𝒲ₙ` it is the Lagrange condition on the unit Weyl sphere, so no stronger condition is imposed on `W`.

**Step 1 by moving W instead of u.** `exists_max` ([L3Local.lean:149](../lean/HamiltonsCubic/Results/L3Local.lean#L149)) maximises `U ↦ ⟨U·W, u⟩` over the compact orthogonal group, giving `V' = U₀·W` with `c = ⟨V', u⟩ ≥ ⟨U·W, u⟩ > cos r`. `crit_rotR` carries `Q(V') = λV'`. `first_order_gen` gives `⟨tang u j k, V'⟩ = 0`, `tangent_perp` gives `⟨tang u j k, u⟩ = 0`, so `h = V' − cu` is orthogonal to `u` and to every generator tangent. This replaces the record's equivariance transfer of the gap from `W₀` to `W₁`: the gap stays at `u` and the critical point moves, which is equivalent and cleaner.

**`r ≤ 2/3`.** `bern1` applied twice to `qP u v` bounds `|cub (Dq (Dq q)) 1 0| ≤ 9M`. By hand, `cub (Dq (Dq q)) 1 0 = (Dq (Dq q))₀ = (Dq q)₁ = 2q₂ − 3q₀ = 6T_uvv − 3P(u)`, which is `hval`. With `T_uvv ≤ θ(½ − γ)` from `Tsym_eq_Le` and the gap, `6T_uvv − 3θ ≤ −6θγ`, so `6θγ ≤ 9M` and `r = 4θγ/(9M) ≤ 2/3`. This is the record's step 1 argument, `|φ''(0)| ≤ 9M` and `6θ₀γ ≤ |φ''(0)|`, exactly.

**The arccos step.** `c = 1` forces `h = 0` and `V' = u`, which is the conclusion. Otherwise `−1 < cos r < c < 1`, `s = arccos c ∈ (0, π]`, `sin s = √‖h‖² > 0`, and `cos` is antitone on `[0, π]` with `r ∈ [0, 2/3] ⊂ [0, π]`, so `s ≥ r` would give `c = cos s ≤ cos r`, contradicting `cos r < c`. So `0 < s < r`, and `V' = cos s·u + sin s·v` with `v = h / sin s` unit, Weyl, orthogonal to `u` and to every generator tangent.

**The contradiction.** `hgap` at `v` feeds `no_critical_in_tube_Le` ([L217Le.lean:66](../lean/HamiltonsCubic/Results/L217Le.lean#L66)), whose `|P| ≤ M` on the unit circle of `span(u, v)` comes from `hMb` through `plane_unit`, giving `cub (Dq (qP u v)) (cos s) (sin s) < 0`. `cubDer_crit` at the critical `V'` gives the same quantity `= 0`. The record's step 5 in full.

## 3. `L216_radius` and `L216_sphere_radius`

`L216_radius` is `L216_general` with `hMb` discharged by `L143_unconditional hn X ⟨hX1, hXW⟩`, the unit Weyl sphere bound `|P| ≤ 1 + √(n−2)` at `n ≥ 4`. The radius term is literally `4θγ/(9(1 + √(n−2)))`, the record's `r`.

`lamTop p q = max((p−2)/(2(p−1)), (q−2)/(2(q−1)), (p+q−2)/(2(p−1)(q−1)))`. Then `½ − (p−2)/(2(p−1)) = 1/(2(p−1))`, the same at `q`, and `(p+q−2)/(2(p−1)(q−1))` is L26's `μ` with `n = p + q`. So `½ − lamTop p q = min(1/(2(p−1)), 1/(2(q−1)), ½ − μ)`, the record's `γ_{p,q}` exactly. `gap_lt_half` makes it positive off (3, 3).

`θ = t(p + q − 1)` is the eigenvalue of `sphere_isCritical2` at the unit representative, so `Pcubic2_crit` makes it `P(W_{p,q})` at unit norm, the record's `θ_{p,q}`.

**The balanced value is the `p = q = m` instance.** There `1/(2(m−1)) = 1/(n−2)` and `½ − μ = ½ − 1/(m−1)`, which is at least `1/(2(m−1))` exactly when `m ≥ 4`, equality at `m = 4`. So at `n = 2m ≥ 8`, `γ = 1/(n−2)` and the radius becomes `4θ₀(n)/(9(n−2)(1 + √(n−2)))`, the record's `r_n`. The file states the general `lamTop` form and leaves this reduction and the numerical values `0.0246`, `0.0132` to hand arithmetic (O2).

`crossOrbit_eq_tang` identifies L27Span's `orbitOp T t j k` with `tang` of the unit sphere product through `orbitOp_apply`, so `hHt` delivers `hcross`, then `horb_of_orbit` (via `L27_half_span`) and `Le_gap_sphere` give `⟨L_e H, H⟩ ≤ lamTop`, which `linarith` turns into `hgap`. The corollary's own route through L27 and L26 is the one the record names.

## 4. The generator-tangent condition

`hgap` quantifies over unit Weyl `H ⊥ u` with `⟨tang u j k, H⟩ = 0` for every `j ≠ k`. Since `X ↦ [ad_X, u]` is linear and `{φ_jk}` spans `𝔰𝔬(n)`, the tangents `tang u j k` span `T_u𝒪`, so the set of admissible `H` is exactly the record's. The spanning step is by hand, as r1903 O1 recorded for L217 (O3). Two further points. The quantifier over ordered pairs with `j ≠ k` includes both `φ_jk` and `φ_kj = −φ_jk`, which is redundant and harmless. And the lemma quantifies the gap at `u` only, the record quantifying at `W₀`, with no transfer to `W₁` needed in the Lean route (section 2). Nothing else.

## 5. Axioms

`#print axioms` on `cubDer_eq`, `cubDer_crit`, `L216_general`, `L216_radius`, `crossOrbit_eq_tang` and `L216_sphere_radius`, run with `lake env lean` from `lean/` on a scratch file after waiting for the running lake to exit, returns `[propext, Classical.choice, Quot.sound]` for each. The file contains no `sorry`.

## 6. The INDEX row and the findings Lean note

The INDEX row's state is **proved**, and its closing sentences describe `L216_general`, `L216_radius`, `crossOrbit_eq_tang` and `L216_sphere_radius` accurately, including the by-hand spanning step. Two stale passages remain (O4). The row still carries the italic "*statement: typed.*" marker mid-row. Its "What the file does NOT state" list, written for L216IsolationRadius.lean, still names L143's bound, the nearest-point geodesic and equivariance, and the gap at the orbit's other points as untyped, and the "GATE 2 ADDED TWO THINGS" passage still says step 1 and the final inference "appear nowhere in the file". Those items are now typed in L216Gen.lean, and a reader taking the row top down meets the older account first.

The findings Lean note in [second-order.md](../findings/second-order.md) names `L216_general` with "`M` a bound on `|P|` over the unit sphere", and does not name `L216_radius` or `L216_sphere_radius`, so it reads as if the record's `M = 1 + √(n−2)` and the corollary were still outside Lean (O5). It then closes "Prose: step 1 (attained distance, normal geodesic, equivariance) and reading φ'(0), φ''(0) as criticality and L24's Hessian", which contradicts its own earlier clause that step 1 is typed by `L216_general`. The note also says "unit sphere" where the file says unit Weyl sphere, a small imprecision.

## Verdict

**CONFIRMED WITH OBSERVATIONS.** `L216_general`, `L216_radius` and `L216_sphere_radius` are Lemma L216 and its corollary at every sphere product off (3, 3), with the tube read as the geodesic tube, criticality as the Lagrange condition, and `r ≤ 2/3` derived from Bernstein twice exactly as the record's step 1 argues. The row may stay **proved**. The observations ask for prose repairs and name two by-hand residues. None affects the theorem.

**The falsifying object** would be a unit Weyl `W` with `Q(W) = λW`, off the orbit of a gapped critical `u`, with `max_U ⟨U·W, u⟩ > cos r`, or at the level of the file a mismatch between a typed hypothesis and the record (a `Dq` or `qP` coefficient differing from the rotation derivative, a `lamTop` differing from `γ_{p,q}`, a gap hypothesis over a set of `H` larger or smaller than `T_u𝒪^⊥`). I looked for the second kind: `cubDer_eq` and `hval` re-derived coefficient by coefficient, `lamTop` reduced to the record's min by hand, the balanced reduction checked at `m ≥ 4` with equality at `m = 4`, the tangent span argued, and the axioms printed. The first kind is excluded by the kernel given those checks. No numerical screen was run, none being needed to decide any claim.

## Observations

- **O1.** `cubDer_crit` needs only `‖u‖ = ‖v‖` and `⟨u,v⟩ = 0`, never `x² + y² = 1`, which it does not assume. Its docstring "at a critical point `c` of the circle" undersells it slightly. No change needed.
- **O2.** `L216_sphere_radius` states the corollary in `lamTop` form with `θ = t(p+q−1)`. The balanced value `γ = 1/(n−2)` at `n = 2m ≥ 8`, the resulting `r_n` formula and its values `0.0246`, `0.0132` are the `p = q = m` instance by hand arithmetic (section 3), and none is a Lean declaration. A one-line corollary at `p = q = m ≥ 4` with the radius `4θ/(9(n−2)(1+√(n−2)))` would close this, reusing `Le_gap_balanced`.
- **O3.** The generator tangents span `T_u𝒪` by linearity, argued by hand, as r1903 O1 recorded for L217. The INDEX row already says so.
- **O4.** The INDEX "L216 (statement)" row keeps the mid-row "*statement: typed.*" marker and the "What the file does NOT state" and "GATE 2 ADDED TWO THINGS" passages describing L216IsolationRadius.lean, which now read as current gaps although L216Gen.lean types every item in them. Strike or mark them as superseded by L216Gen.lean.
- **O5.** The findings Lean note under Lemma L216 names only `L216_general` (with `M` "over the unit sphere") and ends "Prose: step 1 (attained distance, normal geodesic, equivariance)", contradicting its own statement that step 1 is typed. It should name `L216_radius` (the record's `M` through L143) and `L216_sphere_radius` (the corollary), say "unit Weyl sphere", and leave as prose only the by-hand spanning step and the balanced reduction of O2.
- **O6.** `hM0` in `L216_general` is implied by `hMb` whenever a unit Weyl operator exists, as r1866 O3 found for the sibling lemma. Harmless.
