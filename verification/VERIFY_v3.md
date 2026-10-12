# REVIEW r338, "Problem P holds if and only if it holds at every critical point, i.e. iff Conjecture A holds"

Reviewer r338, cold brief, analytical only. No script was run and no floating-point value was computed; every numeric comparison below is exact rational or exact radical arithmetic.

## 0. What the sentence has to mean

The statement is a biconditional between two families of assertions. To make it well formed I fix the following reading, which is the only one under which "it holds at every critical point" parses:

- **Problem P (dimension n).** With `Weyl^1_n = {W in Weyl_n : |W| = 1}`, the maximum of `P(W) = <W, W^2 + W^#>` over `Weyl^1_n` is attained at the unit Weyl operator of a product of round spheres.
- **"Problem P holds at W".** `P(W) <= P(W_prod)` where `W_prod` is the unit Weyl operator of the relevant sphere product.
- **"critical point".** Critical point of `P` restricted to `Weyl^1_n`, i.e. critical *inside* the Weyl sphere. This is exactly the quantifier of the published Conjecture A; the alternative reading (critical for `P` on the unit sphere of *all* algebraic curvature operators) is a different and smaller set and would break the `<=` direction, so it is excluded here and should be excluded in the record's wording too.

Conjecture A, quoted verbatim from [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) lines 212-219:

> **Conjecture A.** Let `W in Weyl_n` be a unit Weyl curvature operator that is a critical point of `P(R) = <R^2 + R^#, R>` among `Weyl^1_n = {W in Weyl_n | ||W|| = 1}`. If either `n >= 12` or `8 <= n <= 11` and `W not in SO(n).W_{CP^2}`, we have `P(W) <= P(W^crit_sym)`.

with `R^crit_sym` the curvature operator of `S^ceil(n/2) x S^floor(n/2)` with its symmetric Einstein metric and `W^crit_sym` its unit Weyl part.

## 1. Hypothesis inventory

### 1a. Hypotheses of the statement itself

| # | Hypothesis | Stated? | Checked against |
|---|---|---|---|
| H1 | `n >= 12` on the Problem P side | stated in the README | Conjecture A's own hypothesis is `n >= 12` **or** `8 <= n <= 11` with the `CP^2` orbit removed. Mismatch, Finding 1. |
| H2 | Quantifier over `n`: the biconditional is between two universally quantified families | unstated | The equivalence is true dimension by dimension; as a statement about the two *families* the `=>` direction fails (Finding 1). |
| H3 | `Weyl_n != 0`, so `Weyl^1_n` is nonempty | unstated | `dim Weyl_n = n(n+1)(n+2)(n-3)/12 > 0` for `n >= 4`. Holds for `n >= 12`. Pass. |
| H4 | `W_prod != 0`, so a unit Weyl operator of the sphere product exists | unstated | `S^k x S^l` is non-conformally-flat for `k, l >= 2`; `n >= 12` gives `k, l >= 6`. Pass. |
| H5 | "products of spheres" means the **balanced** split `k = ceil(n/2)`, `l = floor(n/2)` | unstated (README says only "products of spheres") | True but needs proof, Finding 2. |
| H6 | "maximized on" means *the value is attained there*, not *only there* | unstated | Under the rigidity reading the `<=` direction fails, Finding 3. |
| H7 | The unit Weyl operator of `S^k x S^l` is well defined independently of the two radii | unstated | Pass, see Withdrawn W3. |
| H8 | `ker W != 0` is admissible | not excluded anywhere | No step uses invertibility of `W`; the Lagrange derivation, the `#` formula and the compactness argument are all insensitive to `ker W`. Pass. |

### 1b. Hypotheses of the imported theorems

| # | Imported theorem | Its hypotheses | Checked against |
|---|---|---|---|
| I1 | Weierstrass extreme-value theorem (the max is attained) | continuous function on a nonempty compact set | `P` is a cubic polynomial, hence continuous; `Weyl^1_n` is the unit sphere of a finite-dimensional real inner-product space, hence compact and nonempty by H3. Pass. |
| I2 | Lagrange multipliers / first-order condition on a constrained max | the constraint set is a smooth submanifold, the constraint gradient is nonvanishing at the point, the objective is differentiable there | The constraint gradient at `W` is `2W != 0` on the unit sphere; `P` is polynomial. Pass. The clean form needs no multiplier theorem at all: differentiate `t -> P(cos(t)W + sin(t)X)` at `t = 0` for `X in Weyl_n`, `X ⊥ W`. |
| I3 | `Q(Weyl_n) ⊆ Weyl_n` (needed only to identify the record's critical-point equation `Q(W) = λW` with Conjecture A's "critical point among `Weyl^1_n`") | `W` an algebraic curvature operator with vanishing Ricci contraction | Pass, verified two independent ways, see section 2 and Withdrawn W1. |
| I4 | Full symmetry of the trilinear form `T(X,Y,Z) = <X, Q(Y,Z)>` | `X, Y, Z` self-adjoint | `tr(XYZ) = tr((XYZ)^T) = tr(ZYX)` plus cyclicity gives full symmetry of `tr(XYZ)`; the `#`-half of the symmetry is standard (Böhm-Wilking) and is asserted rather than argued in Material A. Pass, with the note that Material A justifies only the `W^2` half. |
| I5 | `P(W_{S_{k,l}}) = θ_{k,l}` in closed form | `k, l >= 2`, symmetric Einstein product metric | Nienhaus, Proposition 2.25, see section 2. Used for Finding 2. |

## 2. Imported-theorem checks, sources read

**Conjecture A, verbatim.** [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404), lines 212-219. Quoted in section 0.

**`Q` preserves `Weyl_n` (I3).** Stated in the same source at lines 1090-1092: "if `R, S in Weyl_n` are curvature operators of Weyl type, then `Q(R,S)` is again a Weyl curvature operator", and used again in the proof of Lemma 2.17 (line 1191ff): "the fact that `Q(W) in Weyl_n` for any Weyl curvature operator". I re-derived it independently rather than take it on citation:

1. `Ric ∘ Q` restricted to `Weyl_n` is an `O(n)`-equivariant quadratic map `Weyl_n -> Sym^2(R^n)`. Enumerating the pairings of `W ⊗ W` with two free indices: terms with both free indices on one factor force a Ricci trace of the other factor, which vanishes for Weyl; terms with the free indices on different factors reduce, via the pair symmetries and the first Bianchi identity `W_{iabc}W_{kbac} = (1/2) W_{iabc}W_{kabc}`, to the single tensor `(W∘W)_{ik} = W_{iabc}W_{kabc}`. So `Ric(Q(W)) = c_1 (W∘W) + c_2 |W|^2 δ` for constants `c_1, c_2` depending only on `n`.
2. Evaluate on coordinate-diagonal Weyl operators, i.e. on `D_n`. Using the diagonal formula `(Q(W))_{ij,ij} = λ_{ij}^2 + Σ_{k≠i,j} λ_{ik}λ_{jk}`, the `i`-th row sum of `Q(W)` (which is the `i`-th Ricci eigenvalue) is `Σ_{j≠i} λ_{ij}^2 + Σ_{k≠i} λ_{ik} Σ_{j≠i,k} λ_{jk} = Σ_{j≠i} λ_{ij}^2 + Σ_{k≠i} λ_{ik}(-λ_{ik}) = 0`, using `Σ_{j≠k} λ_{jk} = 0`. So `Ric(Q(W)) = 0` for every `W in D_n`.
3. The two basis maps are separated on `D_n` for `n >= 5`: take the `D_4` element `S_{12} = S_{34} = 1`, `S_{13} = S_{24} = -1`, `S_{14} = S_{23} = 0` (all row sums zero) and extend it to `R^n` by zero. Its row-square-sums are `2` on indices `1..4` and `0` on indices `5..n`, so `(W∘W)` is not a multiple of `δ`. Hence `c_1 = 0`, and then `c_2 = 0` since `|W|^2 != 0`.
4. For `n = 4` the separation fails (`W∘W = (1/4)|W|^2 g` is an identity in dimension 4), and the claim is instead read off Hamilton's block form: with `R = (A, B; B^T, C)`, `Ric`-flat means `B = 0` and `tr A = tr C = 0`; `dB/dt = AB + BC + 2B^# = 0` when `B = 0`, and `tr(A^2 + 2A^#) = |A|^2 + 2e_2(A) = -2e_2(A) + 2e_2(A) = 0` for traceless `A`. So `Q` preserves `Weyl_4`.

**`P` of the sphere products (I5).** Nienhaus, Proposition 2.25, [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) lines 1483-1523: `W^2_{S_{k,l}} + W^#_{S_{k,l}} = θ_{k,l} W_{S_{k,l}}` with `θ_{k,l} = sqrt(2) · sqrt( ((k-1)/k)·((l-1)/l)·((n-1)/(n-2)) )`, and `P(W_{S_{k,l}}) = θ_{k,l}`. The proposition also records `θ_n = θ_{n/2,n/2} = (1/n) sqrt(2(n-1)(n-2))` for even `n`, which I checked against the general formula: `sqrt(2)·((n-2)/n)·sqrt((n-1)/(n-2)) = (1/n) sqrt(2(n-1)(n-2))`. Consistent.

**`P(W_{CP^2}) = sqrt(3/2)` (used only for the sharpness remark in Finding 1).** Same source, line 4688: "we use the statement that `max{P(W) | W in Weyl_n, ||W|| = 1} = sqrt(3/2)`" in the low-dimensional range. Taken as an imported claim; nothing in my verdict depends on its exact value, only on the fact that Conjecture A's low-dimensional clause is a separate assertion.

## 3. Findings

### Finding 1, the biconditional is false as written: Conjecture A carries a low-dimensional clause that Problem P does not

**Re-derivation.** Conjecture A's hypothesis is a disjunction: `n >= 12`, **or** `8 <= n <= 11` together with `W not in SO(n).W_{CP^2}`. So "Conjecture A holds" is the conjunction of two independent assertions, `A_{>=12}` and `A_{8..11}`. Problem P as defined in the README speaks only of `n >= 12`. The `<=` direction is fine: `A_{>=12}` alone implies Problem P. The `=>` direction is not: Problem P says nothing at all about `n = 8, 9, 10, 11`.

**Concrete failure.** Take `n = 10`. The comparison value in Conjecture A is `θ_10 = (1/10) sqrt(2·9·8) = (1/10) sqrt(144) = 6/5`, while the critical value at `W_{CP^2}` is `sqrt(3/2)`. Exactly, `(6/5)^2 = 36/25 = 1.44 < 3/2`, so `P(W_{CP^2}) > θ_10`: the sphere product is **not** the maximiser in dimension 10, which is precisely why Conjecture A excises the `CP^2` orbit there and why Problem P is confined to `n >= 12`. The content of `A_{8..11}` (that after removing the `CP^2` orbit the sphere product bound is restored), is a live statement with no counterpart in Problem P. A world in which `A_{>=12}` is true and `A_{8..11}` is false satisfies Problem P and refutes Conjecture A.

For completeness, the crossover claimed in the source is exact: `θ_12^2 = 2·11·10/144 = 220/144 = 55/36 > 54/36 = 3/2`, so from `n = 12` on the sphere product does overtake `W_{CP^2}`.

**Defence attempted.** Two defences were tried and both fail. (i) *Dimension reduction*: `Weyl_m` embeds isometrically in `Weyl_n` for `m < n` (extend by zero; the Ricci contraction of the extension still vanishes), `Q` preserves the subalgebra `Λ^2(R^m) ⊂ Λ^2(R^n)`, so a unit critical point of `P` on `Weyl^1_m` is also one on `Weyl^1_n` with the same value of `P`. But the implication runs the wrong way: it lets the `n = 12` statement bound low-dimensional critical points by `θ_12`, which is *weaker* than the bound `θ_10` that `A_{8..11}` asserts. So `A_{>=12}` does not recover `A_{8..11}`. (ii) *Reading "Conjecture A" as its `n >= 12` clause only*: this is presumably the intent, and it makes the sentence true, but it is a correction to the statement, not a defence of it, since the published Conjecture A is a single conjecture with a disjunctive hypothesis.

**Repair.** State the result per dimension: *for each fixed `n >= 12`, Problem P in dimension `n` holds if and only if the `n >= 12` clause of Conjecture A holds in dimension `n`.* The record must not claim the converse for the `8 <= n <= 11` clause.

### Finding 2, the `=>` direction needs "the balanced split is the best split", which the material never supplies

**Re-derivation.** Problem P as worded in the README asserts only that the maximum is attained "on the Weyl tensor of products of spheres", an unspecified split `k + l = n`. Conjecture A's right-hand side is the specific balanced split. So `Problem P => Conjecture A` requires `max_{k+l=n} P(W_{S_{k,l}}) = P(W^crit_sym)`, i.e. that the balanced split is the maximising one. Nothing in Material A or Material B establishes this. (Material B(c) shows only that a certain orthogonal projection lands parallel to the balanced product; it compares no two splits.)

**Status: the auxiliary is true, and provable in one line.** From Proposition 2.25, `θ_{k,l}^2 = 2·((k-1)/k)·((l-1)/l)·((n-1)/(n-2)) = 2·((n-1)/(n-2))·(1 - (n-1)/(kl))`, since `(k-1)(l-1)/(kl) = (kl - (k+l) + 1)/(kl) = 1 - (n-1)/(kl)`. This is strictly increasing in `kl`, and `kl` subject to `k + l = n`, `k, l >= 2` integers is maximised exactly at `k = ceil(n/2)`, `l = floor(n/2)`. Hence the balanced split is the unique maximiser among splits, and `P(W_{S_{k,l}}) < θ_n` for every unbalanced split. No numerics.

**Defence attempted.** The strongest defence is that "the Weyl tensor of products of spheres" was always intended to name the balanced one, so no auxiliary is needed. That defence is plausible about intent and useless about the text: as written the phrase quantifies over the whole family, and the record's own Material A writes `S^p x S^q` with free `p, q`. So the auxiliary must be recorded, not assumed.

**Repair.** Add the displayed monotonicity of `θ_{k,l}` in `kl` to the record as a named ingredient of the `=>` direction, or reword Problem P to name the balanced split.

### Finding 3, under the rigidity reading of "is maximized on", the `<=` direction fails

**Re-derivation.** "Restricted to `W` of norm 1, `P` is maximized on the Weyl tensor of products of spheres" admits two readings: (V) the maximum *value* equals `θ_n` and is attained at `W^crit_sym`; (R) the set of maximisers is *exactly* the `O(n)`-orbit of the sphere-product Weyl tensors. Conjecture A is a bare inequality `P(W) <= P(W^crit_sym)` at critical points, with no equality clause anywhere in its statement.

**Concrete failure.** Conjecture A is satisfied by any configuration in which some unit critical point `W_0 not in O(n)·W^crit_sym` has `P(W_0) = θ_n` exactly. Such a configuration falsifies reading (R) while satisfying Conjecture A, so `Conjecture A => Problem P` fails under (R). I cannot exhibit such a `W_0` (this is a defect of logical form, not a counterexample) but the material contains nothing that excludes it, and Nienhaus does *not* derive his own rigidity from Conjecture A: at line 251ff the equality case ("with equality if and only if `R_p = R^crit_sym`") comes from the angle inequality in (1.1), not from Conjecture A.

**Defence attempted.** One could argue that "maximized on X" idiomatically means "attains its maximum on X", i.e. reading (V), so no rigidity is claimed. I accept this defence (it is why this is a scope finding rather than a break) but it has to be written down, because the record elsewhere treats the sphere product as *the* maximiser and a rigidity statement would not be equivalent to Conjecture A.

**Repair.** Fix reading (V) in the statement of Problem P, or, if rigidity is wanted, note explicitly that it is strictly stronger than Conjecture A.

### Finding 4, Material B does not bear on this statement at all

**Re-derivation.** I re-derived all three parts of Material B from scratch and they are **correct**:

- The Weyl projection of a coordinate-diagonal curvature operator with vertex matrix `S` is `S_{ij} - (r_i + r_j)/(n-2) + s/((n-1)(n-2))` with `r_i` the row sums and `s = Σ_i r_i`. For `S_{ij} = v_i v_j` (`i != j`) one gets `r_i = v_i Σ_{j≠i} v_j = -v_i^2` and `s = -1`, so the projection is `v_i v_j + (v_i^2 + v_j^2)/(n-2) - 1/((n-1)(n-2))`, which is exactly `Z(v)`. Part (a)'s row-sum identity checks out line for line.
- Part (b): the residual is `a_i + a_j + c` with `a_i = -v_i^2/(n-2)`, `c = 1/((n-1)(n-2))`, and `Σ_{i<j}(a_i + a_j + c)T_{ij} = Σ_i a_i·(row sum of T) + (c/2)Σ_i (row sum of T) = 0` for every `T in D_n`. Correct, and independent of the positive constant relating the vertex-matrix pairing to the operator inner product.
- Part (c): at the balanced two-value `v`, `Z_same = 1/(n-1)` and `Z_cross = -(n-2)/(n(n-1))`, ratio `-n/(n-2)`, which agrees with the claimed `-(n/2)/(n/2-1)`. The Weyl vertex matrix of the symmetric `S^{n/2} x S^{n/2}` is `within = n/(2(n-1))`, `cross = -(n-2)/(2(n-1))`, same ratio `-n/(n-2)`; indeed `Z = (2/n)·W`, so they are genuinely parallel, not merely equal in ratio.

**Concrete failure.** Nothing in (a), (b) or (c) mentions a critical point, the map `Q`, compactness, or a quantifier over `Weyl^1_n`. It is a lemma about the orthogonal projection of a rank-one hollow matrix onto `D_n` and about which vertex matrix the balanced case is parallel to. It establishes neither direction of the biconditional, and the equality case it "computes" in (c) is the equality case of a *projection*, not of the cubic `P`. The record's entry for this result therefore names the wrong section as its argument.

**Defence attempted.** The most charitable reading is that (c) is meant to supply "the balanced product is the extremal object" and so to feed Finding 2. It does not: `Z(v)` is the projection of `v ⊗ v`, and its being parallel to the balanced product's vertex matrix at the balanced `v` says nothing about `P(W_{S_{k,l}})` for competing splits. The real supply for Finding 2 is the monotonicity of `θ_{k,l}` in `kl`.

### The proof the material should have contained

For fixed `n >= 12`, with reading (V) and the balanced split named:

- `=>`: if `max_{Weyl^1_n} P = θ_n`, then in particular `P(W) <= θ_n = P(W^crit_sym)` at every critical point. (Trivial; needs Finding 2's monotonicity only if "products of spheres" is left with a free split.)
- `<=`: `Weyl^1_n` is nonempty and compact (I1), `P` is continuous, so the maximum is attained at some `W_*`. Differentiating `t -> P(cos(t)W_* + sin(t)X)` at `t = 0` for `X in Weyl_n` with `X ⊥ W_*` gives `<Q(W_*), X> = 0`, so `W_*` is a critical point of `P|_{Weyl^1_n}` (I2), and since `Q(W_*) in Weyl_n` (I3) this is equivalent to `Q(W_*) = λ W_*` with `λ = P(W_*)`, the equation of Material A. Conjecture A then gives `P(W_*) <= θ_n`, while `W^crit_sym in Weyl^1_n` gives `P(W_*) >= θ_n`. Hence the maximum equals `θ_n` and is attained at the balanced sphere product.

Note that the `<=` direction does not use `Q(W) = λ W` at all, it needs only Conjecture A's intrinsic notion of criticality. `Q(W) = λ W` is needed solely to make the record's phrasing of "critical point" coincide with Conjecture A's, which is why I3 was checked.

### Withdrawn candidates

- **W1, "`Q(W) = λW` should be `π_{Weyl}(Q(W)) = λW`".** Withdrawn: `Q(Weyl_n) ⊆ Weyl_n`. Verified independently (section 2, steps 1-4) and confirmed in the source at lines 1090-1092 and 1191ff. Note the representation-theoretic obstruction *is* absent (an equivariant quadratic map `Weyl_n -> Sym^2_0(R^n)` exists) so this had to be checked rather than waved through.
- **W2, "`Q` does not preserve diagonality", citing the source's own warning at line ~1113 ("after diagonalizing a curvature operator `R`, the expression `Q(R)` is not diagonal anymore").** Withdrawn: that warning concerns a general orthonormal eigenbasis of `Λ^2`. In the *coordinate 2-plane* basis, `[e_i ∧ e_j, e_k ∧ e_l]` is either zero or `±` a single basis element, so in `<R^# x, y> = (1/2) Σ_{α,β} λ_α λ_β <[b_α,b_β],x><[b_α,b_β],y>` every term with `x = b_γ`, `y = b_δ`, `γ != δ` vanishes. Material A's claim is about the coordinate basis and is correct.
- **W3, "the unit Weyl operator of `S^k x S^l` depends on the two radii, so 'the Weyl tensor of products of spheres' is ill defined".** Withdrawn: for `k, l >= 3`, `Λ^2_1`, `Λ^2_2` and `V_1 ⊗ V_2` are pairwise non-isomorphic `O(k) x O(l)`-modules, so the invariant self-adjoint operators form a 3-dimensional space; subtracting the 1-dimensional scalar part and the 1-dimensional invariant trace-free Ricci part leaves a 1-dimensional invariant Weyl space. The unit Weyl operator is therefore determined up to sign, independently of the radii; the sign is fixed by `P` being odd. (The source's "with its symmetric Einstein metric" is accordingly decoration, not a hypothesis.)
- **W4, "the supremum may not be attained / the Lagrange condition needs a constraint qualification".** Withdrawn: `Weyl_n` is finite-dimensional, `Weyl^1_n` is compact, and the constraint gradient `2W` never vanishes on it. No infinite-dimensional or degeneracy issue exists.
- **W5, "`ker W != 0` is quietly excluded".** Withdrawn: no step in Material A, Material B, or the proof above uses invertibility of `W`; the `#` formula, the row-sum identity and the compactness argument are all valid on the whole of `Weyl^1_n`.
- **W6, "`tr(XYZ) = tr(ZYX)` is false for non-commuting operators".** Withdrawn: `tr(M) = tr(M^T)` and `X, Y, Z` self-adjoint give `tr(XYZ) = tr(Z^T Y^T X^T) = tr(ZYX)`; with cyclicity this is full symmetry. Material A's justification is correct as far as the `W^2` half goes; the symmetry of `<X # Y, Z>` is standard (Böhm-Wilking) and is imported without comment.

## 4. Verdict

**PROVEN, hypotheses corrected.**

The equivalence is true and its proof is three lines (compactness plus the first-order condition inside `Weyl^1_n`), but only after three corrections, and the section the record names as its argument proves none of it.

Corrected hypotheses:

1. **Per dimension, and against the `n >= 12` clause of Conjecture A only.** For each fixed `n >= 12`: Problem P in dimension `n` holds iff `P(W) <= P(W^crit_sym)` at every critical point of `P|_{Weyl^1_n}`. The published Conjecture A additionally asserts the `8 <= n <= 11` clause with the `SO(n)·W_{CP^2}` orbit removed, which Problem P does not imply (Finding 1).
2. **"Products of spheres" means the balanced split** `S^ceil(n/2) x S^floor(n/2)`; the `=>` direction otherwise needs the monotonicity `θ_{k,l}^2 = 2((n-1)/(n-2))(1 - (n-1)/(kl))` in `kl`, which is true and is supplied in Finding 2 but appears nowhere in the record's material.
3. **"Maximized on" is the value reading, not the rigidity reading.** Conjecture A carries no equality case, so it cannot be equivalent to a statement that the sphere products are the *only* maximisers (Finding 3).

Standing findings: 4 (Findings 1-4). Withdrawn candidates: 6 (W1-W6). Finding 4 (that Material B is a correct but unrelated projection lemma), is the one to act on first, since it means this result currently has no argument on file even though one exists in three lines.
