# Review r1710: statement fidelity of L56Weyl.lean, the Weyl operator of every sphere product and the vertex-entry mechanism

Cold brief, analysis only. The kernel checks were taken as given and nothing was built (no `lake build`, no `lake env`). The only arithmetic is hand screens at named objects, reported as screens. Log: agent_logs/review-r1710.log.

**Verdict: every typed statement in [L56Weyl.lean](../lean/HamiltonsCubic/Results/L56Weyl.lean) says what the record means, and no hypothesis is vacuous or trivialising. The uniqueness hypothesis is stronger than the textbook one (orthogonality to all linear Ricci-flat maps rather than to the Weyl space), which narrows `product_weylPart_unique` without falsifying it. Three documentation claims are wrong: the L56Weyl header omits the owed normSq step, and both L56Multi's header and the INDEX row still call the now-typed mechanism untyped or owed.**

| claim | verdict | reason |
|---|---|---|
| model: curvature operator is `diagOp (sectE β)` | CONFIRMED | `diagOp_phi` gives eigenvalue `w a b` on `phi a b`, `inner2 (phi a b) (phi a b) = 1`, so the eigenvalue is the sectional curvature. `1/(p_i-1)` within and `0` across is the Einstein-normalised product, and the layer's `Ric` of it is `1` on every row |
| `sectE_split` | CONFIRMED | `knWeight` of the constant `½/(n-1)` is `1/(n-1)` on every off-diagonal pair, which is `sectE - weylE` entrywise |
| `weylE_isWeight` | CONFIRMED | row sum `(p-1)(1/(p-1) - 1/(n-1)) - (n-p)/(n-1) = 0`. `hbs` is load-bearing: a singleton factor gives row sum `-1` |
| `product_weylPart` | CONFIRMED | existence of the split, with the KN summand orthogonal to every linear Ricci-flat operator via `innerOp_knWeight` |
| `product_weylPart_unique` | CONFIRMED | the conclusion on every `phi i j` fixes `W` on all bivectors by linearity (`hW.1`) and `skew_expand`. `hK` is stronger than "orthogonal to the Weyl space", so the theorem applies to a narrower class of splits than the textbook projection's. Combined with the existence side it still identifies the projection |
| `unit_weights` | CONFIRMED | `(p-1)(1/(p-1) - 1/(n-1)) = 1 - c` and `-(p-1)/(n-1) = -c`, with `c = (p-1)/(kp-1)`, L56Multi's `cMulti` |
| `vertex_entries` | CONFIRMED | `-(n-1)·weylE` is `-(n-p)/(p-1)` within and `1` across, so `-q/(p-1)`, `-p/(q-1)`, `1` at two factors. The sign follows the record's printed entries, which the record itself flags as `-K` |
| `vertex_min` | CONFIRMED | `p/(q-1) ≤ 1` iff `p < q`, and `p(p-1) ≤ q(q-1)` there. `p < q` is needed: at `p = q` the minimum is `1`, and at `q = p+1` it ties with `1` |
| `vertex_normSq`, `gapSq_eq_vertex` | CONFIRMED as arithmetic | both are real identities. The identification of the pair count with `normSq (diagOp w)` is owed and absent from the file |
| L56Weyl header covers what is owed | REFUTED AS STATED | the header has no owed line. Only the INDEX row records the normSq step as owed |
| L56Multi header "*Untyped*: the vertex-entry mechanism, and that the Weyl operator ..." | REFUTED AS STATED | stale since L56Weyl types both |
| INDEX row "the multi-block form of the owed vertex-entry mechanism" | REFUTED AS STATED | stale in the same row that later says both items are PROVED |

**One line:** the mathematics is right and faithfully typed. Three prose claims need a downstream sweep, and `hK` could be weakened to the textbook hypothesis at no cost.

## Conventions

- `phi i j = single j i 1 - single i j 1`, `inner2 X Y = ½ tr(XᵀY)`, so `inner2 (phi i j) (phi i j) = 1` for `i ≠ j` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)).
- `diagOp w X = w ∘ X` entrywise, and `diagOp_phi` gives `diagOp w (phi i j) = w i j • phi i j` for symmetric `w` ([Families.lean](../lean/HamiltonsCubic/Base/Families.lean)).
- `Ric R a b = Σ_c inner2 (R (phi a c)) (phi b c)`. `diagOp_ric` makes it the row sum on the diagonal and `0` off it.
- `innerOp R S = ½ Σ_{i,j} inner2 (R (phi i j)) (S (phi i j))`, ordered pairs with the doubling paid.
- `normSq (diagOp w) = ½ Σ_{a,b} w_ab² = Σ_{a<b} w_ab²` (`diagOp_normSq`, Families.lean), so the unordered pair count is exactly `normSq`, with no multiple.
- `IsLinOp`: additive and homogeneous. `IsWeylOp = IsLinOp ∧ IsWeyl`, with `IsWeyl` carrying skew-valuedness, self-adjointness on bivectors, first Bianchi and `Ric = 0` ([FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean)).
- The record's vertex solution ([graded-half.md](../findings/graded-half.md), L212) at `θ_g = 1` is `K_ij = (n-n_a)/((n-1)(n_a-1))` within and `-1/(n-1)` across, which is `weylE` entry for entry.

## Hypothesis inventory

| hypothesis | where | status |
|---|---|---|
| `hbs : ∀ a, 2 ≤ bs β a` | `weylE_isWeight`, `product_weylPart(_unique)`, `vertex_entries` | the record's range. Every factor is `S^{p_i}` with `p_i ≥ 2`, the floor sits at `S²`, and `S¹` has no Einstein normalisation. Load-bearing: a singleton factor has row sum `-1` |
| `hn : 2 ≤ card ι` | same | implied by `hbs` whenever `ι` is nonempty, so it excludes only the empty type. Redundant and harmless |
| `hW : IsWeylOp W` | `product_weylPart_unique` | the record's `𝒲ₙ` with linearity. Satisfied by `diagOp weylE` |
| `hK` (orthogonal to every linear Ricci-flat `R`) | `product_weylPart_unique` | satisfiable (the KN summand meets it, `product_weylPart`). Stronger than orthogonality to `𝒲ₙ`, see section 2 |
| `hsplit` on all matrices | `product_weylPart_unique` | harmless: set `K := diagOp sectE - W`, and `innerOp` reads `K` only on the `phi` basis |
| `hp : ∀ a, bs β a = p`, `hp2`, `hab` | `unit_weights` | equal factors, `p ≥ 2`, off-diagonal pair. Matches L56Multi's equal-block case |
| `2 ≤ p`, `p < q` | `vertex_min` | the record's `p < q` range. Stated over naturals with no link to `β`, a free-standing inequality |
| nonvanishing of `p-1`, `q-1`, `p`, `q`, `n-1`, `n-2` | `vertex_normSq`, `gapSq_eq_vertex` | denominators only |

## 1. The model: `diagOp (sectE β)` is the curvature operator of the Einstein product

`S^{p}` of radius `r` has sectional curvature `1/r²` and Ricci `(p-1)/r²`, so `Ric = 1` forces `r² = p-1` and sectional curvature `1/(p-1)`. The curvature operator of a Riemannian product is block diagonal on `Λ²V₁ ⊕ Λ²V₂ ⊕ (V₁∧V₂)`, acting as `1/(p_i-1)` on each `Λ²V_i` and `0` on the mixed bivectors. In the coordinate frame this is `e_a∧e_b ↦ K_ab e_a∧e_b`, which `diagOp` realises through `diagOp_phi`. Because `phi a b` has unit `inner2` norm, the eigenvalue `sectE β a b` is the sectional curvature itself, with no factor of two. The sign convention (positive on the round sphere) agrees with the layer's `Ric`: `Ric (diagOp sectE) a a = (p-1)·1/(p-1) = 1`, the record's `Ric = 1`.

`sectE` is symmetric because `bs_eq` gives `bs β a = bs β b` whenever `β a = β b`, which `diagOp_phi` needs.

This identification is a modelling step, the same one [L2SphereWeyl.lean](../lean/HamiltonsCubic/Results/L2SphereWeyl.lean) makes with `sectProd`. The layer carries no Riemannian products, so it is the input the owed item is proved from.

*Falsifier sought:* a factor size where `1/(p-1)` misreads Lean's division. At `bs = 1` Lean's `1/0 = 0`, but a singleton has no within-factor pairs and `hbs` excludes it anyway. None found.

## 2. `product_weylPart` and `product_weylPart_unique`

**Existence.** `sectE_split` is correct entrywise: `knWeight (fun _ => ½·1/(n-1))` is `1/(n-1)` off the diagonal, and `sectE - weylE` is `1/(n-1)` on every off-diagonal pair. Independently, the textbook Weyl part of an Einstein metric with scalar curvature `s = n` subtracts the constant-curvature operator `s/(n(n-1)) = 1/(n-1)`, giving the same `weylE`. `weylE_isWeight` makes `diagOp weylE` a Weyl operator through `diagOp_isWeyl`.

**Uniqueness.** `weylPart_unique` concludes on every `phi i j`. `W` is linear, the `phi` family spans the skew matrices (`skew_expand`), so `W` is fixed on all of `Λ²`. Off the skew matrices nothing is determined, which is correct since a curvature operator lives on `Λ²`.

**The hypothesis on `K` is stronger than the textbook one.** The textbook Weyl projection `W₀` is defined by `R - W₀ ⊥ 𝒲ₙ`. `hK` asks for orthogonality to every linear Ricci-flat map, a larger set (no Bianchi, no skew-valuedness, no self-adjointness). So the theorem is uniqueness within a narrower class of splits, and it does not by itself apply to an arbitrary `W₀` with `R - W₀ ⊥ 𝒲ₙ`.

This does not falsify the owed claim. The existence side supplies a split whose `K` meets even the stronger condition, hence is orthogonal to `𝒲ₙ`, and the orthogonal projection is unique. Better, the Lean proof goes through with `hK` weakened to `∀ R, IsWeylOp R → innerOp K R = 0`: the difference `D = W₁ - W₂` of two `IsWeylOp` operators is itself `IsWeylOp` (each clause of `IsWeyl` is linear in `R`). Recommendation: weaken `hK` in `weylPart_unique`, so that the typed statement is the textbook characterisation.

**Vacuity.** `hK` is met by the KN summand (`product_weylPart`'s third conjunct), and `hW` by `diagOp weylE`, so the hypotheses are jointly satisfiable. `hsplit` quantified over all matrices is harmless, as the inventory notes.

**Concrete object: `S² × S³`, `ι = Fin 5`, `κ = Fin 2`, `β = ![0,0,1,1,1]`** (screen, by hand). `bs = 2` on `{0,1}` and `3` on `{2,3,4}`. `sectE`: `1` on `(0,1)`, `½` on the three pairs inside `{2,3,4}`, `0` on the six mixed pairs. Row checks: `Ric` at `0` is `1`, at `2` is `2·½ = 1`. `weylE` with `1/(n-1) = ¼`: `¾` on `(0,1)`, `¼` inside `{2,3,4}`, `-¼` across. Row sums: `¾ - 3·¼ = 0` and `2·¼ - 2·¼ = 0`. The statement reads: any linear Weyl `W` and any `K` orthogonal to every linear Ricci-flat operator with `diagOp sectE = W + K` have `W (phi 0 1) = ¾ phi 0 1`, `W (phi 2 3) = ¼ phi 2 3`, `W (phi 0 2) = -¼ phi 0 2`, and so on. That is the Weyl operator of the Einstein `S²×S³`.

## 3. The range: `hbs`, `hn`, and one factor

`hbs` is the record's range, factors `S^{p_i}` with `p_i ≥ 2` (L56Statement's floor sits at `p = 2`). `hn` adds nothing once `ι` is nonempty.

A constant `β` (one factor, the round `Sⁿ`) is admitted. Then `bs = n` and `weylE` is `1/(n-1) - 1/(n-1) = 0` on every pair, so the theorems say the Weyl operator of the round sphere is `0`. That agrees with conformal flatness. The file does not mention this case. It is consistent, and a one-line remark in the header would make "every product" visibly include it. Likewise `n = 2, 3` are admitted only as one factor, where the Weyl tensor vanishes identically, again consistent.

## 4. `vertex_entries`

`-(n-1)(1/(p-1) - 1/(n-1)) = -(n-1)/(p-1) + 1 = -(n-p)/(p-1)` within a factor of size `p`, and `-(n-1)·(-1/(n-1)) = 1` across. At two factors `n - p = q` within the `p` factor and `n - q = p` within the `q` factor, giving the record's `-q/(p-1)`, `-p/(q-1)`, `1` with the record's signs.

The record's own review ([ungraded-slack.md](../findings/ungraded-slack.md), L56) says the printed entries are `-K` rather than `K`, harmless since only moduli enter. The vertex solution `K` of L212 at `θ_g = 1` is `weylE` exactly, so the file's `-(n-1)·weylE` reproduces the printed sign, and its docstring's "rescaled by `-(n-1)`" is accurate. The docstring could cite the record's `-K` remark so that a reader does not take the sign as a claim about `K`.

The two-factor reading is prose over the general statement and is not a separate theorem. It is a direct substitution.

*Falsifier sought:* a sign or `n-p` versus `q` mismatch. Screened at `S²×S³`: `-4·¾ = -3 = -q/(p-1)`, `-4·¼ = -1 = -p/(q-1)`, `-4·(-¼) = 1`. None found.

## 5. `vertex_min`

At `2 ≤ p < q`: `p/(q-1) ≤ 1` iff `p ≤ q-1`, and `p/(q-1) ≤ q/(p-1)` iff `p(p-1) ≤ q(q-1)`, which holds for `p < q`. All three moduli are positive, so none is excluded as zero from "smallest nonzero modulus".

The record's claim needs `p < q`. At `p = q` the within entries are `p/(p-1) > 1`, so the smallest modulus is `1` (the across entry), and L56Statement's separate `balancedGapSq` covers that case. Screen: at `p = q`, `1/normSq = (p-1)/(p²(2p-1))`, which equals `balancedGapSq (2p) = 2(2p-2)/(4p²(2p-1))`. At `q = p+1` the minimum ties with `1` (the `S²×S³` object: moduli `3, 1, 1`), which the non-strict `≤` covers. The record's "`3/(n-4)` at `p = 3`" is `p/(q-1)` with `q = n-3`, correct and untyped.

`vertex_min` is stated over natural `p, q` with no link to `β`. That is a faithful typing of the record's one-line comparison.

## 6. `vertex_normSq` and `gapSq_eq_vertex`

`normSq (diagOp w) = ½ Σ_{a,b} w_ab²` over ordered pairs (`diagOp_normSq`), which is `Σ_{a<b} w_ab²`, the unordered pair count with coefficient one. So the pair count `p(p-1)/2·(q/(p-1))² + q(q-1)/2·(p/(q-1))² + pq` is exactly `normSq` of `diagOp` at the vertex weights, once the entry pattern is read off `vertex_entries`. The closed form checks by hand: the bracket's numerator is `(p+q)² - 3(p+q) + 2 = (n-1)(n-2)`. `gapSq_eq_vertex` checks: `(p/(q-1))²·2(p-1)(q-1)/(pq(n-1)(n-2)) = 2p(p-1)/(q(q-1)(n-1)(n-2))`. The gap is scale invariant, so the `-(n-1)` rescaling cancels.

Screens: `S²×S³` gives pair count `1·9 + 3·1 + 6·1 = 18` against `6·4·3/(2·1·2) = 18`, and `gapSq 2 3 = 1/18`. `S³×S⁹` gives `gapSq 3 9 = 12/7920 = 1/660`, the recorded value. `(2,2,8)` gives `weylE = 10/11, 4/77, -1/11`, matching L56Multi's `weights_228`.

**The identification is owed, and only the INDEX says so.** The [INDEX row](../lean/INDEX.md) ends with "**Owed**: that this pair count is `normSq` of `diagOp` at the vertex weights", which is accurate. The L56Weyl header has no owed or untyped line. Its words ("the pair count of the squared vertex entries") make no false claim, but the file does not state the gap. The brief's premise that the file states it is inaccurate. The step is nearly free: `diagOp_normSq` applied to `-(n-1)·weylE` at a two-factor `β`, plus a count of pairs by type, closes it.

## 7. Prose the typed statements do not carry

- **L56Weyl header, "so it is the Weyl projection"** (line 25). This holds through existence plus orthogonal-projection uniqueness, with the narrower `hK` (section 2). Acceptable. Weakening `hK` would make it literal.
- **L56Weyl header, no owed line.** REFUTED AS STATED against the claim that the file records what is owed. Add "*Owed*: that the pair count is `normSq (diagOp (-(n-1)·weylE))`."
- **[L56Multi.lean](../lean/HamiltonsCubic/Results/L56Multi.lean) lines 24–25**, "*Untyped*: the vertex-entry mechanism, and that the Weyl operator of the Einstein product is the diagonal operator with these weights". Stale since L56Weyl types both. It should point at L56Weyl.
- **INDEX L56 row**, "the weights themselves being the multi-block form of the owed vertex-entry mechanism". Stale in the same row that later says "Both owed items are PROVED".
- **`vertex_entries` docstring.** Accurate. A pointer to the record's `-K` remark would help.

## Overall verdict

**CONFIRMED on the mathematics, with three documentation repairs owed.** Every typed statement is true, says what the record means, and carries the record's range (`p_i ≥ 2`, and `p < q` where the record needs it). No hypothesis is vacuous: `hbs` is load-bearing, `hn` is redundant, and `hK`, `hW` are jointly met by the constructed split. Recommended, in priority order:

1. Add the owed normSq line to the L56Weyl header, or discharge it from `diagOp_normSq`.
2. Update L56Multi's "*Untyped*" line and the INDEX row's "owed vertex-entry mechanism" phrase.
3. Weaken `hK` in `weylPart_unique` to orthogonality against `IsWeylOp` operators. The proof is unchanged in substance, and the statement becomes the textbook characterisation.
