### Reviewer 316: the graded-slice reduction, the equivariant point on the slice, and the uniqueness premise

**Verdicts.**

| | claim | verdict |
|---|---|---|
| **I1** | `V` is a linear slice of dimension `155` at `n = 8` on `(3,5)`; a graded critical point that is not a local max on `S(V)` is not a local max on the full sphere | **CONFIRMED as stated, but the "so it never needs `λ_max(L_e) > ½`" gloss is BACKWARDS**, the implication is trivially valid, and it makes the pointwise task *harder*, not easier: any second-order proof of "not a local max on `S(V)`" needs `λ_max(L_e|_{V ∩ W^⊥}) > ½`, which *implies* `λ_max(L_e|_{W^⊥}) > ½` |
| **I2** | Lemma L69's `λ_max(L_e|_{W^⊥}) = ½` attained exactly on the orbit tangent gives the equivariant point as a local max on `S(V)` "modulo its orbit" | **CONFIRMED, and stronger than claimed**, the orbit tangent is *entirely orthogonal to* `V`, so on the slice `λ_max = (M-2)/(2(M-1)) < ½` exactly (`M = max(p,q)`) and the equivariant point is a **strict, isolated, nondegenerate** local max on `S(V)`; no "modulo the orbit" is needed. The converse needs strictness only, and strictness is available |
| **I3** | the equivariant point is the only local maximum of `P` on `S(V)`, which would close the graded half | **REFUTED at every pair and every `n` tested, by three independent mechanisms.** On `S(V_{(3,5)})` at `n = 8` the equivariant point sits at `1.115546702` while ascents reach `√(3/2) = 1.224744871`. On the *balanced* slice `V_{(6,6)}` at `n = 12`, `150` ascents find **five** distinct local-max values. `ad(p)`-commutant `= 1` re-verified at three pairs |

**The route as written is dead; a repaired version survives.** The mechanism is one line: **every sphere-product Weyl operator is diagonal in the `E_ij` basis, so it commutes with every coordinate grading involution and therefore lies in *every* slice `V_{(a,b)}`.** Since `θ` grows with balance, for each unbalanced pair the slice `V_{(a,b)}` contains a more balanced sphere product with strictly larger `θ`. So "the equivariant point maximises `P` on its own graded subspace" is false at every unbalanced pair, at every `n`, with no computation beyond the `θ` table. What survives is the weaker statement `max_{S(V_{(a,b)})} P = θ(S^{n/2} × S^{n/2})` for every split, which at `n = 12` the numerics support, but which is a restatement of the graded half rather than a reduction of it.

---

#### What was built

Everything is re-derived in [core.py](../scripts/reviewers/r316/core.py) from the definitions alone, importing nothing from the repository. `Λ²ℝⁿ ≅ so(n)` with `⟨A,B⟩ = -½ tr(AB)`, so the `E_ij` (`i<j`) are orthonormal; structure constants `c_{αγδ} = ⟨[φ_α,φ_γ], φ_δ⟩`; and the sharp taken in the trace form `(W#)_{αβ} = -½ tr(A_α W A_β W)` with `A_α = ad(φ_α)`.

**The normalisation was fixed independently of the repository.** Hamilton's flow `∂_t R = ΔR + 2(R² + R#)` on the shrinking round sphere (`K = 1/(r_0² - 2(n-1)t)`, so `dK/dt = 2(n-1)K²`) forces `R# = (n-2)Id` at `R = Id`. My build returns exactly `(n-2)Id` at `n = 5,6,8`, `off-diagonal 0.0`. `Weyl_n` was then built as the kernel of (first Bianchi) `⊕` (Ricci), giving `dim = 84, 300, 770, 1638` at `n = 6,8,10,12`. An ambient projector `Sym(Λ²) → Weyl_n` built from the symmetries alone (Bianchi projection plus removal of the Kulkarni–Nomizu span), agrees with the basis-built projector to `2e-14` and is what makes `n = 12` cheap.

**Gate before any claim.** The sphere-product Weyl operators come back critical at residual `≤ 5e-16` with `θ(S³×S⁵) = 1.115546702`, `θ(S⁴×S⁴) = 1.145643924`, `θ(S⁵×S⁵) = 1.200000000`, `θ(S⁵×S⁷) = 1.228239158`, `θ(S⁶×S⁶) = 1.236033081`, the record's numbers to nine digits, so the conventions coincide and the comparisons below are meaningful.

**Lemma L24's second variation re-derived and measured.** `P` is the cubic form `T(W,W,W)` with `T(W,H,H) = ⟨H, L_W H⟩`, so along `W(t) = (W + tH)/‖W + tH‖` with `H ⊥ W` in `Weyl_n`, `P(W(t)) - θ = 3t²(⟨H, L_W H⟩ - θ/2) + O(t³)`. Measured at `S³×S⁵` for three random `H`: `(P(W_ε) - θ)/ε² = -1.525378` against a predicted `-1.525294` at `ε = 1e-3`, and likewise for the other two. The direction is one-way exactly as the brief says: local max `⟹ λ_max(L_e|_{W^⊥}) ≤ ½`, with no strictness on the right.

---

#### I1, the slice is linear and `155`-dimensional; the reduction is valid and does not weaken the pointwise task

**`V` is linear, trivially.** Conjugation by `Λ²σ`, `σ = diag(I_p, -I_q)`, is a *linear* involution of `Sym(Λ²)`; `V` is its `+1` eigenspace, hence a linear subspace. Measured: the involution restricted to `Weyl_n` is symmetric to `0.0`, squares to the identity to `4e-15`, and preserves `Weyl_n` to `3.5e-14`. Concretely `V = {W ∈ Weyl_n : W(p) ⊆ p, W(m) ⊆ m}`, `W` commutes with the involution iff it is block-diagonal for `Λ² = p ⊕ m`.

**The dimension is right.** `dim V = 155` at `n = 8` on `(3,5)`, against `dim Weyl_8 = 300`, eigenvalue count and `(300 + tr)/2` with `tr = 10` agree. It also comes out combinatorially with no linear algebra: block-diagonal symmetric operators on `Λ²ℝ⁸` number `C(13,2)+13 + C(15,2)+15 = 211`; the invariant part of `Λ⁴ℝ⁸` (even index count in the `5`-block) is `C(3,2)C(5,2) + C(5,4) = 35`; the invariant part of `Sym²ℝ⁸` is `6 + 15 = 21`; and `211 - 35 - 21 = 155`.

| `n` | pair | `dim Weyl_n` | `dim V` |
|---|---|---|---|
| `8` | `(2,6)` | `300` | `160` |
| `8` | `(3,5)` | `300` | `155` |
| `8` | `(4,4)` | `300` | `156` |
| `10` | `(3,7)` | `770` | `399` |
| `10` | `(4,6)` | `770` | `394` |
| `10` | `(5,5)` | `770` | `395` |

**The implication is valid, and for a reason so cheap it is worth saying out loud.** `S(V) ⊆ S(Weyl_n)`, so a nearby point of `S(V)` with larger `P` is a nearby point of the big sphere with larger `P`. Contrapositive: not a local max on `S(V)` `⟹` not a local max on the full sphere `⟹` not the maximiser. Restricting to `V` loses nothing *in this direction*.

**What it does not give, precisely.** (i) The converse fails in general: a local max on `S(V)` may be a saddle in the full space, so the set of local maxima of `P|_{S(V)}` is a **superset** of `Crit(P) ∩ V ∩ {local maxima}`. That makes the uniqueness hypothesis on `S(V)` **strictly stronger** than what the conjecture needs, an argument in favour of the reduction's *soundness* and against its *availability*. (ii) Palais's principle of symmetric criticality does apply, `V` is the fixed-point set of an isometric involution of the sphere under which `P` is invariant, so `Crit(P|_{S(V)}) = Crit(P) ∩ S(V)` exactly; every point my ascents converged to came back critical **in the full space** at residual `≤ 1.5e-15` after polishing, which is the check that confirms it.

**The one claim in the record that is backwards.** "So the conjecture does not need `λ_max(L_e) > ½` at these points, it needs only that they fail to be local maxima." At second order, "`W` fails to be a local max on `S(V)`" is exactly `λ_max(L_e|_{V ∩ W^⊥}) > ½`. Since `V ∩ W^⊥ ⊆ W^⊥`, that **implies** `λ_max(L_e|_{W^⊥}) > ½`. The slice route does not sidestep the quantity C3 was built to avoid; it demands the violating direction additionally be *graded*, which is more, not less. The only escape is an argument that is global on `S(V)` rather than second-order, which is what the record proposes, and which I3 refutes.

---

#### I2, the eigenvalue statement holds; the converse needs strictness, and strictness is there for a reason the record misstates

**The eigenvalue statement, on my own build, at the splits that matter.**

| `n` | pair | `θ` | `λ_max(L_e|_{W^⊥})` | mult. at `½` | orbit tangent `dim` | next below `½` | `λ_max(L_e|_{V ∩ W^⊥})` |
|---|---|---|---|---|---|---|---|
| `8` | `(3,5)` | `1.115546702` | `0.500000000000` | `15` | `15` | `0.375` | `0.375 = 3/8` |
| `8` | `(4,4)` | `1.145643924` | `0.500000000000` | `16` | `16` | `1/3` | `0.333333333 = 1/3` |
| `10` | `(5,5)` | `1.200000000` | `0.500000000000` | `25` | `25` | `0.375` | `0.375 = 3/8` |
| `10` | `(4,6)` | `1.185854123` | `0.500000000000` | `24` | `24` | `0.4` | `0.400000000 = 2/5` |
| `12` | `(5,7)` | `1.228239158` | `0.500000000000` | `35` | `35` | `5/12` | `0.416666667 = 5/12` |
| `12` | `(6,6)` | `1.236033081` | `0.500000000000` | `36` | `36` | `0.4` | `0.400000000 = 2/5` |

`λ_max = ½` to twelve digits, the multiplicity equals the orbit-tangent dimension `ab` exactly, and the Rayleigh quotient on every orbit direction is `½` to twelve digits. **CONFIRMED at `(5,5)`, `(5,7)` and `(6,6)`**, the `p,q ≥ 5` range the brief asked for.

**The extra input the converse needs is strictness, and the record's stated reason for having it is wrong in a way that helps.** `λ_max ≤ ½` is necessary, never sufficient; to run it backwards one needs the second variation *negative definite* on `T_W S(V) = V ∩ W^⊥`, which then gives a strict local max by Taylor, no third-order condition and no Morse–Bott hypothesis. The record says the point is a local max on `S(V)` "modulo its orbit", inheriting the `½` with equality. It does not: **the orbit tangent is entirely orthogonal to `V`.** For `X ∈ p` the generator `[ad X, W]` vanishes (`W` is `ad(p)`-invariant), and for `X ∈ m`, `ad X` maps `p → m` and `m → p`, so `[ad X, W]` is block **off**-diagonal and leaves `V`. Measured: the projection of the whole orbit tangent onto `V` has norm `0.00e+00` at all six rows above. Hence on the slice `λ_max` drops to the *second* full-space eigenvalue, and the equivariant point is a strict, isolated local max on `S(V)` with **no degenerate direction at all**.

**A closed form falls out, and it carries a warning.** Across all six rows, `λ_max(L_e|_{V ∩ W^⊥}) = (M-2)/(2(M-1))` with `M = max(p,q)`, the record's block closed form `(p-2)/(2(p-1))`, here appearing as the slice-restricted maximum. So the margin is `½ - (M-2)/(2(M-1)) = 1/(2(M-1))`, which **decays like `1/n`**. The local-max conclusion is fine at each fixed `n`; any argument that wants a uniform-in-`n` quantitative version has a shrinking gap to work with.

---

#### I3, REFUTED. The commutant is one-dimensional, and that is the only part of the premise that survives

**The commutant, re-verified.** `dim {W ∈ Weyl_n : [ad X, W] = 0 ∀X ∈ p} = 1` at `(3,5)` and `(4,4)` on `n = 8` (against `300`) and at `(5,5)` on `n = 10` (against `770`), computed as the rank deficit of the stacked map `W ↦ ([ad X, W])_X` over a basis of `p`. **CONFIRMED**, including at `(4,4)` where `so(4)` splits.

**The census on the slice.** [n3_run.py](../scripts/reviewers/r316/n3_run.py) does line-searched Riemannian gradient ascent on `S(V)` from random starts, then a Gauss–Newton polish; [n3_n12.py](../scripts/reviewers/r316/n3_n12.py) does a shifted power iteration matrix-free at `n = 12`. Every limit was confirmed critical **in the full space** (residual `≤ 1e-13`) and its `λ_max(L_e|_{V ∩ W^⊥})` measured.

| slice | `θ` of its equivariant point | ascents | distinct local-max `θ` found (descending) |
|---|---|---|---|
| `n=8`, `(3,5)` | `1.115546702` | `120` | `1.224744871` (`103`), `1.145643924` (`13`), `1.115546702` (`3`), `1.082531755` (`1`) |
| `n=8`, `(4,4)` | `1.145643924` | `120` | `1.224744871` (`106`), `1.145643924` (`12`), `1.115546702` (`1`), `1.082531755` (`1`) |
| `n=12`, `(3,9)` | `1.141798451` | `60` | `1.236033081` (`24`), `1.228239158` (`20`), `1.224744871` (`16`) |
| `n=12`, `(6,6)` | `1.236033081` | `150` | `1.236033081` (`67`), `1.228239158` (`31`), `1.224744871` (`31`), `1.201561484` (`2`), `1.115546702` (`19`) |

**Four or five distinct values on every slice, so the "only local maximum" premise is refuted numerically.** It is refuted structurally too, and by three separate mechanisms, worth separating because they have different consequences.

**Mechanism 1, every sphere product lies in every slice.** A sphere-product Weyl operator is `κ₁ Π_{Λ²ℝ^a} + κ₂ Π_{Λ²ℝ^b} - c·Id`, which is **diagonal in the `E_ij` basis** (measured deviation `0.0e+00` at every split at `n = 8` and `n = 12`). A diagonal operator commutes with every coordinate sign involution, so it lies in `V_{(c,n-c)}` for *every* `c`. Cross-membership is total:

| `n = 12` slice | its `θ_eq` | sphere products inside it with strictly larger `θ` |
|---|---|---|
| `(2,10)` | `0.994987437` | `(3,9) 1.141798`, `(4,8) 1.201561`, `(5,7) 1.228239`, `(6,6) 1.236033` |
| `(3,9)` | `1.141798451` | `(4,8) 1.201561`, `(5,7) 1.228239`, `(6,6) 1.236033` |
| `(4,8)` | `1.201561484` | `(5,7) 1.228239`, `(6,6) 1.236033` |
| `(5,7)` | `1.228239158` | `(6,6) 1.236033` |
| `(6,6)` | `1.236033081` |, |

So **"the equivariant point maximises `P` on its own graded subspace" is false for every unbalanced pair, at every `n`, by inspection of the `θ` table alone.** This is the finding that kills the route as written: C3 needs the statement at *every* pair, because it is deployed to rule out non-equivariant graded critical points on arbitrary pairs.

**Mechanism 2, even the top value is attained many times, on the balanced slice.** Take `V_{(6,6)}` at `n = 12` and the sphere product of the coordinate split `S` with `|S ∩ {1..6}| = k`. All of them lie in `V` (`deviation 0e+00`) and all carry `θ = 1.236033081`, at distances `0, 1.1055, 1.3984, 1.4832` from the canonical point for `k = 6,5,4,3`. The group preserving `V` is `(O(6) × O(6)) ⋊ ℤ₂`, and `k` is an invariant of its orbits, so these are **at least four genuinely distinct orbits of local maxima at the maximal value**. Each of the non-canonical ones has `λ_max(L_e|_{V ∩ W^⊥}) = ½` (a non-trivial orbit inside `V`), against `2/5` for the canonical one. This also explains why my ascents report `λ_max = ½` at `θ = θ_eq` while §I2 reports `2/5`: the ascents land on permuted-split representatives, not on the canonical point.

**Mechanism 3, the padded `W_{ℂP²}` beats the equivariant point at `n = 8`.** The dominant attractor on both `n = 8` slices (`103/120` and `106/120`) is the operator with spectrum `{2, -1, -1}/√6` on a self-dual `Λ²₊ℝ⁴` and `0` on the remaining `25` directions, the padded `ℂP²` Weyl tensor, critical at `θ = √(3/2) = 1.224744871392` to fifteen digits. At `n = 8` that is above `θ(S⁴×S⁴) = 1.145643924`, so the equivariant point is not the slice maximum even at the balanced pair. At `n = 12` it sits *below* `θ(S⁶×S⁶) = 1.236033081`, so it is a second local maximum without being a counterexample to the target. The fourth attractor, `θ = 1.082531755`, is another padded point: rank `14`, support `7` of `8` directions, eigenvalue multiplicities `(3, 3, 8)` with a `7`-dimensional kernel inside `Λ²ℝ⁷`.

**No refutation of the target.** Nothing above `θ(S⁶×S⁶) = 1.236033081` appeared in `210` ascents at `n = 12`, on the balanced and on a maximally unbalanced slice.

**What the plan should record instead.** The reduction that survives is `max_{S(V_{(a,b)})} P = θ(S^{n/2} × S^{n/2})` for every split, every graded critical point lies in some `V_{(a,b)}`, so this closes the graded half. It is consistent with everything measured here. But it is no longer a *reduction*: the slice's maximum is attained at a point of a different pair, so proving it for the pair `(a,b)` means proving the whole graded statement, and "the equivariant point of the pair is the answer" is exactly the part that is false.

---

#### Beyond the brief

**Padded `ℂP²` is a Morse–Bott NONDEGENERATE local maximum of `P` at `θ = √(3/2)` exactly, for every `n` tested.** This bears directly on [plan.md](../plan.md)'s F5 and on R12's abandonment condition 1, and it is worth having on the record with its numbers.

| point | `n` | `θ` | orbit `dim` | `mult(½)` | `#` above `½` | next below `½` | verdict |
|---|---|---|---|---|---|---|---|
| padded `ℂP²` | `8` | `1.224744871` | `18` | `18` | `0` | `1/3` | Morse–Bott **nondegenerate** |
| padded `ℂP²` | `10` | `1.224744871` | `26` | `26` | `0` | `1/3` | nondegenerate |
| padded `ℂP²` | `12` | `1.224744871` | `34` | `34` | `0` | `1/3` | nondegenerate |
| `S⁵×S⁵` (control) | `10` | `1.200000000` | `25` | `25` | `0` | `3/8` | nondegenerate |
| `S⁶×S⁶` (control) | `12` | `1.236033081` | `36` | `36` | `0` | `2/5` | nondegenerate |

Three consequences.

- **It really is a local maximum, not merely second-order-clean.** Over `1600` random tangent probes at four scales (`ε = 1e-1 … 3e-3`), in both slice and full-space directions, `P` never increased, the best was `-1.36e-5` at `n = 8` and `-1.58e-5` at `n = 12`; and ascent from perturbed starts (`ε = 0.05`) returns to `θ = 1.224744871` every time. So `Crit(P)` at `n = 12` carries a local maximum at `θ = √(3/2)` that is not a sphere product.
- **F5 is not answered by this point, and R12's condition 1 is not triggered.** The hunt is for a *degenerate* orbit with `θ ≥ √(3/2)`; this one sits exactly at the threshold and is nondegenerate with a gap of `1/6` to the next eigenvalue. It supports the value-localisation hypothesis rather than breaking it, but it does show the hypothesis is being asked about a set that is **not** empty at its boundary, so "every graded critical orbit with `θ ≥ √(3/2)`" has at least one member beyond the sphere products and the wording should not assume otherwise.
- **A caution for C2 that the record already half-holds.** [plan.md](../plan.md) says padded `W_{ℂP²}` is critical at `√(3/2)` with "no usable grading". For the *slice* notion of gradedness used in C3 it is perfectly graded (it lies in `V_{(6,6)}` with deviation `0e+00`) so the two senses of "graded" diverge exactly at this point, and C3's slice statements are quantified over a set that includes it.

**Every slice local maximum I found also passes the full-space second-order test.** At `n = 8` on `(3,5)`, all four attractors have `λ_max(L_e|_{W^⊥}) = ½` with nothing above, in the full space as well as on the slice. I looked for and did **not** find a witness that is a local max on `S(V)` and a genuine saddle in `Weyl_n`. So the superset worry in I1(i) is real in principle but was not realised in this sample, the slice does not appear to manufacture spurious maxima at second order; it manufactures them by *containing points of other pairs*.

---

#### Reproduction

Scripts under [scripts/reviewers/r316/](../scripts/reviewers/r316/): [core.py](../scripts/reviewers/r316/core.py) (algebra, `Weyl_n`, sharp, `L_W`, projectors), [n2_spectrum.py](../scripts/reviewers/r316/n2_spectrum.py) (I2 table), [n3_slice.py](../scripts/reviewers/r316/n3_slice.py) and [n3_run.py](../scripts/reviewers/r316/n3_run.py) (`n = 8` slice census and commutant), [n3_n12.py](../scripts/reviewers/r316/n3_n12.py) (`n = 12` matrix-free census), [n3_identify.py](../scripts/reviewers/r316/n3_identify.py) (identifying the attractors), [padded_cp2.py](../scripts/reviewers/r316/padded_cp2.py), [localmax_check.py](../scripts/reviewers/r316/localmax_check.py), [mb_degeneracy.py](../scripts/reviewers/r316/mb_degeneracy.py). Log: [r316-c3-reduction.log](../agent_logs/r316-c3-reduction.log). Peak memory stayed under `250 MB`; the `n = 12` work is matrix-free on the ambient `Sym(Λ²)`, `4356` coordinates, and never materialises an operator on `Weyl_12`.
