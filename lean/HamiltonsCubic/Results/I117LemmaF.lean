import Mathlib
import HamiltonsCubic.Results.I117PsdReduction

set_option linter.style.longLine false

/-!
# I117's Lemma F: the idempotents of `a P_k + b P_p` on an isotropy-irreducible pair

[reviews/2026-09-26-I73-class-ceiling.md](../../../reviews/2026-09-26-I73-class-ceiling.md), batch 38, Lemma F: for
`𝔤 = 𝔨 ⊕ 𝔭` inside a compact simple `𝔤` with `I # I = cI`, `𝔨` a subalgebra of one induced Casimir value and `𝔭`
irreducible under `𝔨`, the block relations are `P_k # P_k = c_k P_k`, `P_k # P_p = α P_p`, `P_p # P_p = x P_k + y P_p`
with `c_k + x = c` and `2α + y = c`. **`IsotropyPair`** carries these as data on any real module with a symmetric
bilinear `#`; `SymmetricPair` in [I117LemmaE.lean](I117LemmaE.lean) is the case `y = 0`.

**`sharp_C`** computes `C # C` for `C = a P_k + b P_p`, and **`pd_unique`** is Lemma F's first half: with `y ≤ x`
(equivalently `Cas_k(p) ≥ ½ Cas_k(k)`), the only idempotent with `b > 0` is `I / c`. **`second_root_idempotent`** is the
converse: the second root `(c x / D, c (y - x) / D)`, `D = c_k y² + 4 α² x`, is always an idempotent, and
`twocomp_second_root_pos` makes both weights positive once `y > x`. **`sharp_lin`** is `L_C = C # ·` on the plane
`span(P_k, P_p)`, and **`twocomp_second_root_peirce`** gives its second eigenvalue at the second root as
`½ + c (2x - y)(y - x) / (2D)`, above `½` when `x < y < 2x`. **`g2_su3_witness`** is the pair `SU(3) ⊂ G₂`
(`c = 4`, `c_k = 3`, `α = 4/3`, `x = 1`, `y = 4/3`): the positive-definite idempotent `(9/28) P_su3 + (3/28) P_p` on `𝔤₂`,
other than `I/4`, with squared norm `351/392` above `I/4`'s `7/8`. **`g2_so4_witness`**, **`g2_so4_unstable`** and **`g2_so4_norm`** are batch 40's symmetric pair
`SO(4) ⊂ G₂` (`𝔨 = 𝔰𝔲(2)_L ⊕ 𝔰𝔲(2)_S`, two Casimir values): a third positive-definite idempotent
`(11/29, 5/29, √(77/1682))`, unstable along an explicit `H ⊥ C` with `⟨C # H, H⟩ - ½‖H‖² = 7/29`, of squared norm
`746/841 > 7/8`. **`so_sharp_scalars`**, **`stable_iff_cas`** and **`sp_omega2_unstable`** are batch 41's arithmetic:
`I # ·` acts on a component `V` of `Sym² 𝔥` by `c - Cas_V/4`, so `I/c` is stable exactly when `Cas_V ≥ Cas(adj)`, which
fails on `𝔰𝔭(m)`'s `ω₂` component. **`sp1sp2_idem`**, **`u3su4_double`** and **`quarter_circle_turn`** are batches 42–43's
scalar cores: `Sp(1)Sp(2) ⊂ SO(8)` has only `I/6` positive, `U(3) ⊂ SU(4)` has a double root at `I/4`, and the
quarter-circle cubic turns inside `(0, ½)` exactly when `5C < 1`. **`orbit_tangent_F`** is L266's first half: for
derivations of a symmetric associative `#` and an idempotent `c`, the cubic vanishes on its orbit tangents.
**`son_asym_idem`**, **`son_asym_disc`** and **`so9_asym_unstable`** are batch 44's counterexample to U on `𝔰𝔬(n)` itself:
the `SU(2)₊ × SU(2)₋ × SO(n-4)` family has a positive idempotent with `a₊ ≠ a₋` for every `n > 6`, unstable at `n = 9`
with projected excess `61389/198656`. **`torus_uniform`** and **`torus_uniform_iff`** are L268's check that `I/c` solves the torus-invariant
system, and its Cartan block exactly when `c = 2(m-1)`. **`weyl_test`** (with `det3`, `det3_eq`) is batch 46's
factorisation of the Weyl-invariant test: `det(L - λG) = (1 - λ)p(λ)` and `p(½) = -Φ`. **`idir_test`** and **`idir_heavy`** are L270: the projection of `I` onto `C^⊥` has Rayleigh quotient above `½` exactly when `q (2cτ - d) > τ²`, which forces `q c² > d`, so the direction `I` destabilises only idempotents heavier than `I/c`; **`torus_light_y`** confines a lighter torus-invariant idempotent to `y < y₀`, and **`l267_idir_n9`** is the test's exact value at L267's idempotent for `n = 9`. **`pq_entry`**, **`pq_square`**, **`pq_triangles`** and **`qsplit_test`** are L271: the torus system in `P = μ₋ + μ₊`, `Q = μ₋ - μ₊`, and the second eigenvalue on the `Z₂`-split `span(C_P, C_Q)`. **`perron_row`**, **`perron_row_eq`**, **`perron_d`**, **`perron_d_eq`** and **`perron_x`** are L272: with `ρ` the Perron root of `X = P + diag d`, every `d_i ≥ ρ - 1`, with equality where `Q`'s row vanishes, and `Σ μ_α ≤ m/2`. **`jh`**, **`jh_mono`**, **`jh_threshold`**, **`jh_zero`**, **`jh_constants`** and **`jh_nonneg`** are L273 (2): in `t = √(1 + a²)`, `Ψ_κ(g) - λ_m(1 - g²)` is a quartic `h` vanishing at `t₀` with non-negative Taylor coefficients there exactly when `m ≥ 5`. *The Schur step (the block relations from the
bracket, `𝔨` of one Casimir value and `𝔭` irreducible) and the Casimir values at `SU(3) ⊂ G₂` are the Lie theory, and
enter as the structure's fields and as the witness's numbers.*
-/

namespace HamiltonsCubic.I117

/-- Lemma F's second root solves both coefficient equations. -/
theorem twocomp_second_root (c ck x y α : ℝ) (hsum1 : ck + x = c) (hsum2 : 2 * α + y = c)
    (hD : ck * y ^ 2 + 4 * α ^ 2 * x ≠ 0) :
    (c * x / (ck * y ^ 2 + 4 * α ^ 2 * x)) ^ 2 * ck
        + (c * (y - x) / (ck * y ^ 2 + 4 * α ^ 2 * x)) ^ 2 * x
        = c * x / (ck * y ^ 2 + 4 * α ^ 2 * x) ∧
      2 * (c * x / (ck * y ^ 2 + 4 * α ^ 2 * x)) * (c * (y - x) / (ck * y ^ 2 + 4 * α ^ 2 * x)) * α
        + (c * (y - x) / (ck * y ^ 2 + 4 * α ^ 2 * x)) ^ 2 * y
        = c * (y - x) / (ck * y ^ 2 + 4 * α ^ 2 * x) := by
  have k1 : (c * x) ^ 2 * ck + (c * (y - x)) ^ 2 * x = c * x * (ck * y ^ 2 + 4 * α ^ 2 * x) := by
    obtain rfl : c = 2 * α + y := by linarith
    obtain rfl : ck = 2 * α + y - x := by linarith
    ring
  have k2 : 2 * (c * x) * (c * (y - x)) * α + (c * (y - x)) ^ 2 * y
      = c * (y - x) * (ck * y ^ 2 + 4 * α ^ 2 * x) := by
    obtain rfl : c = 2 * α + y := by linarith
    obtain rfl : ck = 2 * α + y - x := by linarith
    ring
  generalize ck * y ^ 2 + 4 * α ^ 2 * x = D at hD k1 k2 ⊢
  constructor
  · field_simp
    linear_combination k1
  · field_simp
    linear_combination k2

/-- With `x, α, c_k > 0` and `y > x`, both weights of the second root are positive. -/
theorem twocomp_second_root_pos (c ck x y α : ℝ) (hsum1 : ck + x = c) (hx : 0 < x) (hα : 0 < α)
    (hck : 0 < ck) (hxy : x < y) :
    0 < c * x / (ck * y ^ 2 + 4 * α ^ 2 * x) ∧ 0 < c * (y - x) / (ck * y ^ 2 + 4 * α ^ 2 * x) := by
  have hD : 0 < ck * y ^ 2 + 4 * α ^ 2 * x := by positivity
  have hc : 0 < c := by linarith
  exact ⟨div_pos (mul_pos hc hx) hD, div_pos (mul_pos hc (by linarith)) hD⟩

/-- The values at `SU(3) ⊂ G₂`: `c = 4`, `c_k = 3`, `α = 4/3`, `x = 1`, `y = 4/3`, second root `(9/28, 3/28)`. -/
theorem g2_su3_witness :
    (9 / 28 : ℝ) ^ 2 * 3 + (3 / 28) ^ 2 * 1 = 9 / 28 ∧
      2 * (9 / 28 : ℝ) * (3 / 28) * (4 / 3) + (3 / 28) ^ 2 * (4 / 3) = 3 / 28 ∧
      (9 / 28 : ℝ) ≠ 1 / 4 ∧
      (9 / 28 : ℝ) ^ 2 * 8 + (3 / 28) ^ 2 * 6 = 351 / 392 ∧ (351 / 392 : ℝ) > 14 / 4 ^ 2 := by
  norm_num

/-- The second Peirce eigenvalue of the second root, minus `½`: `L_C` on `span(P_k, P_p)` has trace
`a c_k + a α + b y` and eigenvalue `1` at `(a, b)`, so its other eigenvalue is the trace minus `1`. -/
theorem twocomp_second_root_peirce (c ck x y α : ℝ) (hsum1 : ck + x = c) (hsum2 : 2 * α + y = c)
    (hD : ck * y ^ 2 + 4 * α ^ 2 * x ≠ 0) :
    (c * x / (ck * y ^ 2 + 4 * α ^ 2 * x)) * ck + (c * x / (ck * y ^ 2 + 4 * α ^ 2 * x)) * α
        + (c * (y - x) / (ck * y ^ 2 + 4 * α ^ 2 * x)) * y - 1 - 1 / 2
      = c * (2 * x - y) * (y - x) / (2 * (ck * y ^ 2 + 4 * α ^ 2 * x)) := by
  have k : 2 * (c * x * ck + c * x * α + c * (y - x) * y) - 3 * (ck * y ^ 2 + 4 * α ^ 2 * x)
      = c * (2 * x - y) * (y - x) := by
    obtain rfl : c = 2 * α + y := by linarith
    obtain rfl : ck = 2 * α + y - x := by linarith
    ring
  generalize ck * y ^ 2 + 4 * α ^ 2 * x = D at hD k ⊢
  field_simp
  linear_combination k

/-- At `SU(3) ⊂ G₂` the second Peirce eigenvalue is `15/28 > ½`. -/
theorem g2_su3_peirce : (9 / 28 : ℝ) * 3 + (9 / 28) * (4 / 3) + (3 / 28) * (4 / 3) - 1 = 15 / 28 := by
  norm_num

/-- `SO(4) ⊂ G₂` on the ansatz `a₁ P_L + a₂ P_S + b P_p`: with `b² = 77/1682`, `(11/29, 5/29, b)` solves the three
coefficient equations `2a₁² + 2b² = a₁`, `(2/3)a₂² + (10/3)b² = a₂`, `b(3a₁ + 5a₂ - 2) = 0`. -/
theorem g2_so4_witness (b : ℝ) (hb : b ^ 2 = 77 / 1682) :
    2 * (11 / 29 : ℝ) ^ 2 + 2 * b ^ 2 = 11 / 29 ∧
      (2 / 3) * (5 / 29 : ℝ) ^ 2 + (10 / 3) * b ^ 2 = 5 / 29 ∧
      b * (3 * (11 / 29) + 5 * (5 / 29) - 2) = 0 := by
  refine ⟨?_, ?_, ?_⟩
  · rw [hb]; norm_num
  · rw [hb]; norm_num
  · norm_num

/-- Its instability: for `H = u₁ P_L + u₂ P_S + v P_p` with dimensions `(3, 3, 8)`,
`⟨C # H, H⟩ = 6a₁u₁² + 2a₂u₂² + 4v² + 12b u₁ v + 20b u₂ v`. At `(u₁, u₂, v) = (1, -1, -(261/154) b)`, `H ⊥ C` and
`⟨C # H, H⟩ - ½‖H‖² = 7/29`. -/
theorem g2_so4_unstable (b : ℝ) (hb : b ^ 2 = 77 / 1682) :
    let a₁ : ℝ := 11 / 29
    let a₂ : ℝ := 5 / 29
    let u₁ : ℝ := 1
    let u₂ : ℝ := -1
    let v : ℝ := -(261 / 154) * b
    3 * u₁ * a₁ + 3 * u₂ * a₂ + 8 * v * b = 0 ∧
      (6 * a₁ * u₁ ^ 2 + 2 * a₂ * u₂ ^ 2 + 4 * v ^ 2 + 12 * b * u₁ * v + 20 * b * u₂ * v)
        - (1 / 2) * (3 * u₁ ^ 2 + 3 * u₂ ^ 2 + 8 * v ^ 2) = 7 / 29 := by
  intro a₁ a₂ u₁ u₂ v
  constructor
  · simp only [a₁, a₂, u₁, u₂, v]
    have : b * b = 77 / 1682 := by rw [← sq]; exact hb
    nlinarith [this]
  · simp only [a₁, a₂, u₁, u₂, v]
    have : b * b = 77 / 1682 := by rw [← sq]; exact hb
    nlinarith [this]

/-- Its squared norm `3a₁² + 3a₂² + 8b² = 746/841` exceeds `I/4`'s `14/16`. -/
theorem g2_so4_norm (b : ℝ) (hb : b ^ 2 = 77 / 1682) :
    3 * (11 / 29 : ℝ) ^ 2 + 3 * (5 / 29) ^ 2 + 8 * b ^ 2 = 746 / 841 ∧ (746 / 841 : ℝ) > 14 / 16 := by
  rw [hb]; constructor <;> norm_num

/-- `I # ·` acts on a component `V ⊂ Sym² 𝔥` by `c - Cas_V / 4`. On `𝔰𝔬(n)` (`c = n - 2`) the components' Casimirs
`0, 2n, 4n - 4, 4n - 16` (trace, traceless Ricci, Weyl, `Λ⁴`) give the record's four scalars. -/
theorem so_sharp_scalars (n : ℝ) :
    (n - 2) - 0 / 4 = n - 2 ∧ (n - 2) - 2 * n / 4 = (n - 4) / 2 ∧ (n - 2) - (4 * n - 4) / 4 = -1 ∧
      (n - 2) - (4 * n - 16) / 4 = 2 := by
  refine ⟨by ring, by ring, by ring, by ring⟩

/-- Stability of `I/c` on a component is `(c - Cas_V/4)/c ≤ ½`, which is `Cas_V ≥ 2c = Cas(adj)`. -/
theorem stable_iff_cas (c casV : ℝ) (hc : 0 < c) : (c - casV / 4) / c ≤ 1 / 2 ↔ 2 * c ≤ casV := by
  rw [div_le_iff₀ hc]
  constructor <;> intro h <;> linarith

/-- On `𝔰𝔭(m)` (`c = m + 1`, `Cas(ω₂) = 2m`) the `ω₂` component, present for `m ≥ 2`, has eigenvalue
`(m + 2)/(2(m + 1)) > ½`; the arithmetic holds for every `m > 0`. -/
theorem sp_omega2_unstable (m : ℝ) (hm : 0 < m) :
    ((m + 1) - 2 * m / 4) / (m + 1) = (m + 2) / (2 * (m + 1)) ∧ (m + 2) / (2 * (m + 1)) > 1 / 2 := by
  constructor
  · field_simp; ring
  · rw [gt_iff_lt, div_lt_div_iff₀ (by norm_num) (by positivity)]; nlinarith

/-- `Sp(1)Sp(2) ⊂ SO(8)` on `a₁P₁ + a₂P₂ + bP_p` (`c = 6`, `c₁ = 1`, `x₁ = 5`, `c₂ = 3`, `x₂ = 3`, `y = 0`): every solution
with `b ≠ 0` and `a₁, a₂ > 0` is `a₁ = a₂ = 1/6`, `b² = 1/36`. -/
theorem sp1sp2_idem (a₁ a₂ b : ℝ) (h1 : a₁ ^ 2 + 5 * b ^ 2 = a₁) (h2 : 3 * a₂ ^ 2 + 3 * b ^ 2 = a₂)
    (h3 : 2 * a₁ + 4 * a₂ = 1) (ha₁ : 0 < a₁) :
    a₁ = 1 / 6 ∧ a₂ = 1 / 6 ∧ b ^ 2 = 1 / 36 := by
  have ha : a₁ = 1 / 2 - 2 * a₂ := by linarith
  subst ha
  have hq : (a₂ - 1 / 6) * (a₂ - 3 / 2) = 0 := by nlinarith
  rcases mul_eq_zero.mp hq with h | h
  · refine ⟨by linarith, by linarith, by nlinarith⟩
  · exfalso; linarith

/-- `U(3) ⊂ SU(4)` on `aP_su3 + eP_u1 + bP_V` (`c = 4`): `3a² + b² = a`, `e = 4b²`, `8a + 4e = 3` force `(4a - 1)² = 0`. -/
theorem u3su4_double (a e b : ℝ) (h1 : 3 * a ^ 2 + b ^ 2 = a) (h2 : e = 4 * b ^ 2) (h3 : 8 * a + 4 * e = 3) :
    (4 * a - 1) ^ 2 = 0 ∧ a = 1 / 4 ∧ b ^ 2 = 1 / 16 ∧ e = 1 / 4 := by
  have hq : (4 * a - 1) ^ 2 = 0 := by nlinarith
  have ha : a = 1 / 4 := by nlinarith [sq_nonneg (4 * a - 1)]
  refine ⟨hq, ha, by subst ha; linarith, by subst ha; nlinarith⟩

/-- The quarter-circle example: `f = a₁³ + a₂³ + 3C(a₁²a₂ + a₁a₂²)` on `a₁² + a₂² = 1` has, in `u = a₁a₂`, derivative sign
`3C + u(9C - 3)`, which changes sign at `u* = C/(1 - 3C)`, inside `(0, ½)` exactly when `0 < 5C < 1`; then two interior maxima straddle
`u = ½`. -/
theorem quarter_circle_turn (C : ℝ) (hC : 0 < C) (hC1 : 3 * C < 1) :
    0 < C / (1 - 3 * C) ∧ C / (1 - 3 * C) < 1 / 2 ↔ 5 * C < 1 := by
  have hpos : 0 < 1 - 3 * C := by linarith
  constructor
  · rintro ⟨_, h⟩; rw [div_lt_iff₀ hpos] at h; linarith
  · intro h; refine ⟨div_pos hC hpos, ?_⟩; rw [div_lt_iff₀ hpos]; linarith

/-- `SU(2)₊ × SU(2)₋ × SO(n-4) ⊂ SO(n)` on `apP₊ + amP₋ + a_sP_s + bP_V` (`P±#P± = 2P±`, `P±#P_V = ¾P_V`,
`P_s#P_s = (n-6)P_s`, `P_s#P_V = ½(n-5)P_V`, `P_V#P_V = (n-4)(P₊+P₋) + 4P_s`): with `ap + am = ½`,
`apam = (n-4)b²/2`, `b² = (3n-14)/(64(n-5)²)` and `a_s = 1/(4(n-5))`, all four coefficient equations hold. -/
theorem son_asym_idem (n ap am b : ℝ) (hn : 5 < n) (hsum : ap + am = 1 / 2)
    (hprod : ap * am = (n - 4) * b ^ 2 / 2) (hb : b ^ 2 = (3 * n - 14) / (64 * (n - 5) ^ 2)) :
    2 * ap ^ 2 + (n - 4) * b ^ 2 = ap ∧ 2 * am ^ 2 + (n - 4) * b ^ 2 = am ∧
      (n - 6) * (1 / (4 * (n - 5))) ^ 2 + 4 * b ^ 2 = 1 / (4 * (n - 5)) ∧
      (3 / 2) * (ap + am) + (n - 5) * (1 / (4 * (n - 5))) = 1 := by
  have hn5 : n - 5 ≠ 0 := by linarith
  refine ⟨?_, ?_, ?_, ?_⟩
  · linear_combination (-2) * hprod + (2 * ap) * hsum
  · linear_combination (-2) * hprod + (2 * am) * hsum
  · rw [hb]; field_simp; ring
  · rw [hsum]; field_simp; ring

/-- The two roots `ap ≠ am` are real for `n > 6`: `(ap - am)² = ¼ - 2(n-4)b² > 0` is `(n-6)(5n-24) > 0`. -/
theorem son_asym_disc (n : ℝ) (hn : 6 < n) : 2 * (n - 4) * ((3 * n - 14) / (64 * (n - 5) ^ 2)) < 1 / 4 := by
  have h5 : 0 < 64 * (n - 5) ^ 2 := by nlinarith
  rw [mul_div_assoc', div_lt_iff₀ h5]
  nlinarith [mul_pos (by linarith : (0:ℝ) < n - 6) (by linarith : (0:ℝ) < 5 * n - 24)]

/-- At `n = 9` (`apam = 65/2048`, `b² = 13/1024`, `a_s = 1/16`) the direction `H = amP₊ + apP₋ + ¼P_s + 4bP_V`
(weights `3, 3, 10, 20`) has `⟨H, C⟩ = 1395/1024`, `⟨C#H, H⟩ = 8235/2048`, `‖H‖² = 5373/1024`, `‖C‖² = 873/1024`, so
the projected excess `⟨C#H,H⟩ - ½‖H‖² - ⟨H,C⟩²/(2‖C‖²) = 61389/198656 > 0`: unstable. -/
theorem so9_asym_unstable (ap am b : ℝ) (hsum : ap + am = 1 / 2) (hprod : ap * am = 65 / 2048)
    (hb : b ^ 2 = 13 / 1024) :
    let HC := 3 * am * ap + 3 * ap * am + 10 * (1 / 4) * (1 / 16) + 20 * (4 * b) * b
    let CH := 3 * am * (2 * ap * am + 5 * b * (4 * b)) + 3 * ap * (2 * am * ap + 5 * b * (4 * b))
      + 10 * (1 / 4) * (3 * (1 / 16) * (1 / 4) + 4 * b * (4 * b))
      + 20 * (4 * b) * ((3 / 4) * b * am + (3 / 4) * b * ap + 2 * b * (1 / 4)
        + ((3 / 4) * (ap + am) + 2 * (1 / 16)) * (4 * b))
    let HH := 3 * am ^ 2 + 3 * ap ^ 2 + 10 * (1 / 4) ^ 2 + 20 * (4 * b) ^ 2
    let q := 3 * ap ^ 2 + 3 * am ^ 2 + 10 * (1 / 16) ^ 2 + 20 * b ^ 2
    CH - (1 / 2) * HH - HC ^ 2 / (2 * q) = 61389 / 198656 := by
  intro HC CH HH q
  obtain rfl : ap = 1 / 2 - am := by linarith
  have e1 : HC = 1395 / 1024 := by simp only [HC]; linear_combination 6 * hprod + 80 * hb
  have e2 : CH = 8235 / 2048 := by simp only [CH]; linear_combination 3 * hprod + 300 * hb
  have e3 : HH = 5373 / 1024 := by simp only [HH]; linear_combination (-6) * hprod + 320 * hb
  have e4 : q = 873 / 1024 := by simp only [q]; linear_combination (-6) * hprod + 20 * hb
  rw [e1, e2, e3, e4]; norm_num

/-- The torus-invariant system on `𝔰𝔬(2m)` at the uniform point: with `4(m-2)` non-orthogonal positive roots and
`2(m-2)` root pairs summing to each root, `μ = 1/c` solves `μ = 4μ³ + μ·(4(m-2))μ² + 2(m-2)μ²` exactly when
`c = 2(m-1)`, and then the Cartan block `2(m-1)μ² = μ` as well. -/
theorem torus_uniform (m c : ℝ) (hm : 2 ≤ m) (hc : c = 2 * (m - 1)) :
    1 / c = 4 * (1 / c) ^ 3 + (1 / c) * (4 * (m - 2)) * (1 / c) ^ 2 + 2 * (m - 2) * (1 / c) ^ 2 ∧
      2 * (m - 1) * (1 / c) ^ 2 = 1 / c := by
  have hc0 : c ≠ 0 := by rw [hc]; nlinarith
  obtain rfl : m = c / 2 + 1 := by linarith
  constructor
  · field_simp; ring
  · field_simp; ring

/-- The converse: the Cartan block `2(m-1)μ² = μ` at `μ = 1/c` holds exactly when `c = 2(m-1)`. -/
theorem torus_uniform_iff (m c : ℝ) (hc : 0 < c) :
    2 * (m - 1) * (1 / c) ^ 2 = 1 / c ↔ c = 2 * (m - 1) := by
  have hc0 : c ≠ 0 := hc.ne'
  constructor
  · intro h
    field_simp at h
    nlinarith [h]
  · intro h; subst h; field_simp

/-- The 3×3 determinant by cofactors along the first row. -/
def det3 (a b c d e f g h i : ℝ) : ℝ := a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g)

theorem det3_eq (a b c d e f g h i : ℝ) : det3 a b c d e f g h i = Matrix.det !![a, b, c; d, e, f; g, h, i] := by
  rw [Matrix.det_fin_three]; simp [det3]; ring

/-- The Weyl-invariant test on `span{C, I_t, I_R}`: Gram `[[q,2y,2x],[2y,m,0],[2x,0,2R]]`, form
`⟨C#·,·⟩ = [[q,2y,2x],[2y,0,2x],[2x,2x,W]]`, `W = 4(m-1)y + 4(m-2)x`. Then `det(L - λG) = (1 - λ) p(λ)` and
`p(½) = -Φ`, `Φ = (W - R)(qm/2 + 2y²) + x²(4q - 8y - m)`. -/
theorem weyl_test (q x y m R W l : ℝ) :
    det3 (q - l * q) (2 * y - l * (2 * y)) (2 * x - l * (2 * x))
        (2 * y - l * (2 * y)) (0 - l * m) (2 * x - l * 0)
        (2 * x - l * (2 * x)) (2 * x - l * 0) (W - l * (2 * R))
      = (1 - l) * det3 q (2 * y) (2 * x) (2 * y * (1 - l)) (-(l * m)) (2 * x)
          (2 * x * (1 - l)) (2 * x) (W - l * (2 * R)) ∧
    det3 q (2 * y) (2 * x) (2 * y * (1 - 1 / 2)) (-((1 / 2) * m)) (2 * x)
        (2 * x * (1 - 1 / 2)) (2 * x) (W - (1 / 2) * (2 * R))
      = -((W - R) * (q * m / 2 + 2 * y ^ 2) + x ^ 2 * (4 * q - 8 * y - m)) := by
  constructor <;> (simp only [det3]; ring)

section OrbitTangent

open scoped RealInnerProductSpace

/-- The cubic `F(u, v, w) = ⟪u # v, w⟫` vanishes on orbit tangents of an idempotent: for derivations `D_X`, `D_Y` of a
symmetric associative `#` and an idempotent `c`, with `u_Z` satisfying `c # u_Z = ½ u_Z` (as every orbit tangent
`D_Z c` does), `⟪D_X c # D_Y c, u_Z⟫ = 0`. -/
theorem orbit_tangent_F {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (sharp : E →ₗ[ℝ] E →ₗ[ℝ] E) (hsymm : ∀ u v, sharp u v = sharp v u)
    (hassoc : ∀ u v w, ⟪sharp u v, w⟫ = ⟪u, sharp v w⟫)
    (DX DY : E →ₗ[ℝ] E)
    (hDX : ∀ u v, DX (sharp u v) = sharp (DX u) v + sharp u (DX v))
    (hDY : ∀ u v, DY (sharp u v) = sharp (DY u) v + sharp u (DY v))
    (c uZ : E) (hc : sharp c c = c) (hZ : sharp c uZ = (1 / 2 : ℝ) • uZ) :
    ⟪sharp (DX c) (DY c), uZ⟫ = 0 := by
  have hX : DX c = (2 : ℝ) • sharp c (DX c) := by
    have := hDX c c
    rw [hc, hsymm (DX c) c] at this
    rw [two_smul]; exact this
  have hY2 : DY (DX c) = (2 : ℝ) • (sharp (DY c) (DX c) + sharp c (DY (DX c))) := by
    have h := congrArg DY hX
    rw [map_smul, hDY] at h
    exact h
  set w := DY (DX c) with hw
  have key : sharp (DX c) (DY c) = (1 / 2 : ℝ) • w - sharp c w := by
    rw [hsymm]
    calc sharp (DY c) (DX c)
        = (1 / 2 : ℝ) • ((2 : ℝ) • (sharp (DY c) (DX c) + sharp c w)) - sharp c w := by
          rw [smul_smul]; norm_num
      _ = (1 / 2 : ℝ) • w - sharp c w := by rw [← hY2]
  rw [key, inner_sub_left, inner_smul_left, hsymm c w, hassoc w c uZ, hZ, inner_smul_right]
  simp

end OrbitTangent

/-- The data Lemma F's proof uses: `#` symmetric bilinear, and the two-component block relations. -/
structure IsotropyPair (E : Type*) [AddCommGroup E] [Module ℝ E] where
  sharp : E →ₗ[ℝ] E →ₗ[ℝ] E
  sharp_symm : ∀ u v, sharp u v = sharp v u
  Pk : E
  Pp : E
  c : ℝ
  ck : ℝ
  α : ℝ
  x : ℝ
  y : ℝ
  kk : sharp Pk Pk = ck • Pk
  kp : sharp Pk Pp = α • Pp
  pp : sharp Pp Pp = x • Pk + y • Pp
  trace_p : 2 * α + y = c
  trace_k : ck + x = c
  indep : LinearIndependent ℝ ![Pk, Pp]

namespace IsotropyPair

variable {E : Type*} [AddCommGroup E] [Module ℝ E] (S : IsotropyPair E)

/-- `C # C` for `C = a P_k + b P_p`. -/
theorem sharp_C (a b : ℝ) :
    S.sharp (a • S.Pk + b • S.Pp) (a • S.Pk + b • S.Pp)
      = (a ^ 2 * S.ck + b ^ 2 * S.x) • S.Pk + (2 * a * b * S.α + b ^ 2 * S.y) • S.Pp := by
  simp only [map_add, map_smul, LinearMap.add_apply, LinearMap.smul_apply, S.kk, S.kp, S.pp,
    S.sharp_symm S.Pp S.Pk, smul_smul, smul_add]
  module

/-- The linearisation `L_C = C # ·` on the invariant plane `span(P_k, P_p)`. -/
theorem sharp_lin (a b u v : ℝ) :
    S.sharp (a • S.Pk + b • S.Pp) (u • S.Pk + v • S.Pp)
      = (a * S.ck * u + b * S.x * v) • S.Pk + (b * S.α * u + (a * S.α + b * S.y) * v) • S.Pp := by
  simp only [map_add, map_smul, LinearMap.add_apply, LinearMap.smul_apply, S.kk, S.kp, S.pp,
    S.sharp_symm S.Pp S.Pk, smul_smul, smul_add]
  module

/-- The idempotent equation read on the two coefficients. -/
theorem idempotent_coeffs (a b : ℝ)
    (h : S.sharp (a • S.Pk + b • S.Pp) (a • S.Pk + b • S.Pp) = a • S.Pk + b • S.Pp) :
    a ^ 2 * S.ck + b ^ 2 * S.x = a ∧ 2 * a * b * S.α + b ^ 2 * S.y = b := by
  rw [sharp_C] at h
  have := LinearIndependent.pair_iff.mp S.indep (a ^ 2 * S.ck + b ^ 2 * S.x - a)
    (2 * a * b * S.α + b ^ 2 * S.y - b)
    (by rw [sub_smul, sub_smul]; rw [← sub_eq_zero] at h; rw [← h]; abel)
  constructor <;> linarith [this.1, this.2]

/-- **Lemma F**: with `y ≤ x` and `x, α, c_k > 0`, the only idempotent `a P_k + b P_p` with `b > 0` is `I / c`. -/
theorem pd_unique (hx : 0 < S.x) (hα : 0 < S.α) (hck : 0 < S.ck) (hxy : S.y ≤ S.x) (a b : ℝ) (hb : 0 < b)
    (h : S.sharp (a • S.Pk + b • S.Pp) (a • S.Pk + b • S.Pp) = a • S.Pk + b • S.Pp) :
    a = 1 / S.c ∧ b = 1 / S.c := by
  obtain ⟨h1, h2⟩ := S.idempotent_coeffs a b h
  exact I117PsdReduction.twocomp_pd_unique a b S.c S.ck S.x S.y S.α hx hα hck S.trace_k S.trace_p h1 h2 hb hxy

/-- **Lemma F, converse**: the second root is an idempotent whenever `D ≠ 0`. -/
theorem second_root_idempotent (hD : S.ck * S.y ^ 2 + 4 * S.α ^ 2 * S.x ≠ 0) :
    let a := S.c * S.x / (S.ck * S.y ^ 2 + 4 * S.α ^ 2 * S.x)
    let b := S.c * (S.y - S.x) / (S.ck * S.y ^ 2 + 4 * S.α ^ 2 * S.x)
    S.sharp (a • S.Pk + b • S.Pp) (a • S.Pk + b • S.Pp) = a • S.Pk + b • S.Pp := by
  intro a b
  obtain ⟨h1, h2⟩ := twocomp_second_root S.c S.ck S.x S.y S.α S.trace_k S.trace_p hD
  rw [sharp_C, h1, h2]

end IsotropyPair

section IDirection

open scoped RealInnerProductSpace

/-- L270 (1)-(2): with `B X Y = ⟪C # X, Y⟫` symmetric, `C # C = C` (so `B C Y = ⟪C, Y⟫`) and `⟪C # I, I⟫ = c τ`,
the projection `H = I - (τ/q) C` of `I` onto `C^⊥` has `B H H = c τ - τ²/q` and `‖H‖² = d - τ²/q`, and
`2 B H H > ‖H‖²` exactly when `q (2 c τ - d) > τ²`. -/
theorem idir_test {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (B : E →ₗ[ℝ] E →ₗ[ℝ] ℝ) (hB : ∀ X Y, B X Y = B Y X) (C I : E) (c d : ℝ)
    (hCC : ∀ Y, B C Y = ⟪C, Y⟫) (hII : B I I = c * ⟪I, C⟫) (hd : ⟪I, I⟫ = d)
    (hq : 0 < ⟪C, C⟫) :
    ⟪I - (⟪I, C⟫ / ⟪C, C⟫) • C, C⟫ = 0 ∧
    B (I - (⟪I, C⟫ / ⟪C, C⟫) • C) (I - (⟪I, C⟫ / ⟪C, C⟫) • C)
      = c * ⟪I, C⟫ - ⟪I, C⟫ ^ 2 / ⟪C, C⟫ ∧
    ⟪I - (⟪I, C⟫ / ⟪C, C⟫) • C, I - (⟪I, C⟫ / ⟪C, C⟫) • C⟫ = d - ⟪I, C⟫ ^ 2 / ⟪C, C⟫ ∧
    (2 * (c * ⟪I, C⟫ - ⟪I, C⟫ ^ 2 / ⟪C, C⟫) > d - ⟪I, C⟫ ^ 2 / ⟪C, C⟫ ↔
      ⟪C, C⟫ * (2 * c * ⟪I, C⟫ - d) > ⟪I, C⟫ ^ 2) := by
  set τ := ⟪I, C⟫ with hτ
  set q := ⟪C, C⟫ with hqdef
  have hq0 : q ≠ 0 := ne_of_gt hq
  have hCI : ⟪C, I⟫ = τ := real_inner_comm _ _
  have hBIC : B I C = τ := by rw [hB, hCC, hCI]
  have hBCI : B C I = τ := by rw [hCC, hCI]
  have hBCC : B C C = q := hCC C
  refine ⟨?_, ?_, ?_, ?_⟩
  · rw [inner_sub_left, real_inner_smul_left]
    field_simp
    ring
  · simp only [map_sub, map_smul, LinearMap.sub_apply, LinearMap.smul_apply, smul_eq_mul,
      hII, hBIC, hBCI, hBCC]
    field_simp
    ring
  · rw [inner_sub_left, inner_sub_right, inner_sub_right, real_inner_smul_left, real_inner_smul_left,
      real_inner_smul_right, real_inner_smul_right, hd, hCI]
    field_simp
    ring
  · set s := τ ^ 2 / q with hs
    have hsq : s * q = τ ^ 2 := by rw [hs]; field_simp
    constructor
    · intro h
      nlinarith [mul_pos hq (show 0 < 2 * c * τ - d - s by linarith)]
    · intro h
      by_contra hn
      push Not at hn
      nlinarith [mul_nonneg hq.le (show 0 ≤ -(2 * c * τ - d - s) by linarith)]

end IDirection

/-- L270 (2): the direction `I` destabilises only heavy idempotents. From `q (2 c τ - d) > τ²` and `(c τ - d)² ≥ 0`,
`q c² > d`, that is `‖C‖² > d / c² = ‖I/c‖²`. -/
theorem idir_heavy (c d τ q : ℝ) (hc : 0 < c) (hq : 0 < q) (h : q * (2 * c * τ - d) > τ ^ 2) :
    q * c ^ 2 > d := by
  have h1 : 0 < 2 * c * τ - d := by
    by_contra hn
    push Not at hn
    nlinarith [sq_nonneg τ, mul_nonpos_of_nonneg_of_nonpos hq.le hn]
  have hc2 : 0 < c ^ 2 := by positivity
  have h2 : q * c ^ 2 * (2 * c * τ - d) > d * (2 * c * τ - d) := by
    nlinarith [sq_nonneg (c * τ - d), mul_lt_mul_of_pos_right h hc2]
  by_contra hn
  push Not at hn
  nlinarith [mul_le_mul_of_nonneg_right hn h1.le]

/-- L270 (4): a torus-invariant idempotent lighter than `I/c` has `y < y₀`. With `q ≥ 4y²/m + 2y` (Cauchy–Schwarz on
the Cartan block, `tr A = 2y`) and `q < 4y₀²/m + 2y₀` (the uniform point, where the block is scalar), both multiplied
by `m`. -/
theorem torus_light_y (m y y0 q : ℝ) (hm : 0 < m) (hy : 0 ≤ y) (hy0 : 0 ≤ y0)
    (hq : 4 * y ^ 2 + 2 * m * y ≤ m * q) (hlight : m * q < 4 * y0 ^ 2 + 2 * m * y0) : y < y0 := by
  by_contra hn
  push Not at hn
  nlinarith [mul_le_mul hn hn hy0 hy, mul_le_mul_of_nonneg_left hn hm.le]

/-- L270's screen at L267's idempotent, `n = 9` (`c = 7`, `d = 36`, `q = 873/1024`, `τ = 17/8 + 5√13/8`): the test
value `q (2 c τ - d) - τ²` is `(39350 √13 - 122242)/8192 > 0`. -/
theorem l267_idir_n9 :
    (873 / 1024 : ℝ) * (2 * 7 * (17 / 8 + 5 * Real.sqrt 13 / 8) - 36) - (17 / 8 + 5 * Real.sqrt 13 / 8) ^ 2
      = (39350 * Real.sqrt 13 - 122242) / 8192 ∧ (39350 * Real.sqrt 13 - 122242) / 8192 > 0 := by
  have h13 : Real.sqrt 13 ^ 2 = 13 := Real.sq_sqrt (by norm_num)
  have hs0 : 0 ≤ Real.sqrt 13 := Real.sqrt_nonneg 13
  constructor
  · nlinarith [h13]
  · have : 39350 * Real.sqrt 13 > 122242 := by nlinarith [h13, hs0]
    linarith

/-- L271 (2), entrywise: the two root equations of a pair `ε_i ∓ ε_j` (`u = μ₋`, `v = μ₊`, `e = d_i + d_j`,
`sm`, `sp` the pair sums) are equivalent to the `P = u + v`, `Q = u - v` equations. -/
theorem pq_entry (u v e sm sp : ℝ) :
    (u * (1 - e + 2 * (v ^ 2 - u ^ 2)) = sm ∧ v * (1 - e - 2 * (v ^ 2 - u ^ 2)) = sp) ↔
    ((u + v) * (1 - e - 2 * (u - v) ^ 2) = sm + sp ∧ (u - v) * (1 - e - 2 * (u + v) ^ 2) = sm - sp) := by
  constructor
  · rintro ⟨h1, h2⟩
    exact ⟨by linear_combination h1 + h2, by linear_combination h1 - h2⟩
  · rintro ⟨h1, h2⟩
    exact ⟨by linear_combination (h1 + h2) / 2, by linear_combination (h1 - h2) / 2⟩

/-- L271 (2), the pair sums: `(U + V)² = (U² + V²) + (UV + VU)` and `(U - V)² = (U² + V²) - (UV + VU)`. -/
theorem pq_square {m : ℕ} (U V : Matrix (Fin m) (Fin m) ℝ) :
    (U + V) * (U + V) = (U * U + V * V) + (U * V + V * U) ∧
    (U - V) * (U - V) = (U * U + V * V) - (U * V + V * U) := by
  constructor <;> noncomm_ring

/-- L271 (1), one index triple: the four triangles on `{i, j, k}` are the sign patterns with an even number of `ε_a + ε_b`
roots, and `P_ij P_jk P_ik + Q_ij Q_jk Q_ik` is twice their sum, so `tr P³ + tr Q³ = 12 T₃`. -/
theorem pq_triangles (u1 v1 u2 v2 u3 v3 : ℝ) :
    (u1 + v1) * (u2 + v2) * (u3 + v3) + (u1 - v1) * (u2 - v2) * (u3 - v3)
      = 2 * (u1 * u2 * u3 + u1 * v2 * v3 + v1 * u2 * v3 + v1 * v2 * u3) := by
  ring

/-- L271 (4): the `Z₂`-split `C = C_P + C_Q` gives a pencil on `span(C_P, C_Q)` with row sums `G` and cross term
`L_PQ = G_QQ/2 - κ/4` (`κ = tr Q³`); its second eigenvalue exceeds `½` exactly when `κ (G_PP + G_QQ) > 2 G_QQ²`. -/
theorem qsplit_test (gP gQ κ : ℝ) (hP : 0 < gP) (hQ : 0 < gQ) :
    ((gP - (gQ / 2 - κ / 4)) / gP + (gQ - (gQ / 2 - κ / 4)) / gQ - 1 > 1 / 2) ↔
      κ * (gP + gQ) > 2 * gQ ^ 2 := by
  have key : (gP - (gQ / 2 - κ / 4)) / gP + (gQ - (gQ / 2 - κ / 4)) / gQ - 1 - 1 / 2
      = (κ * (gP + gQ) - 2 * gQ ^ 2) / (4 * gP * gQ) := by
    field_simp
    ring
  have hden : 0 < 4 * gP * gQ := by positivity
  constructor
  · intro h
    have : 0 < (κ * (gP + gQ) - 2 * gQ ^ 2) / (4 * gP * gQ) := by linarith
    have := (div_pos_iff_of_pos_right hden).mp this
    linarith
  · intro h
    have : 0 < (κ * (gP + gQ) - 2 * gQ ^ 2) / (4 * gP * gQ) := div_pos (by linarith) hden
    linarith

/-- L272, the Perron step: a positive eigenvector `w` of `X` (eigenvalue `ρ`) with `X² ≤ X + diag δ` entrywise gives
`ρ² - ρ ≤ δ i` at every row. -/
theorem perron_row {m : ℕ} (X : Matrix (Fin m) (Fin m) ℝ) (δ w : Fin m → ℝ) (ρ : ℝ)
    (hw : ∀ i, 0 < w i) (hX : X.mulVec w = ρ • w)
    (hle : ∀ i j, (X * X) i j ≤ X i j + if i = j then δ i else 0) (i : Fin m) :
    ρ ^ 2 - ρ ≤ δ i := by
  have h2 : (X * X).mulVec w = (ρ ^ 2) • w := by
    rw [← Matrix.mulVec_mulVec, hX, Matrix.mulVec_smul, hX, smul_smul, sq]
  have key : ((X * X).mulVec w) i ≤ (X.mulVec w) i + δ i * w i := by
    simp only [Matrix.mulVec, dotProduct]
    calc ∑ j, (X * X) i j * w j
        ≤ ∑ j, (X i j + if i = j then δ i else 0) * w j :=
          Finset.sum_le_sum (fun j _ => mul_le_mul_of_nonneg_right (hle i j) (hw j).le)
      _ = ∑ j, X i j * w j + δ i * w i := by
          simp [add_mul, Finset.sum_add_distrib, ite_mul]
  rw [h2, hX] at key
  simp only [Pi.smul_apply, smul_eq_mul] at key
  have hwi := hw i
  nlinarith

/-- L272, equality version: where row `i` of the bound is an equality, `ρ² - ρ = δ i`. -/
theorem perron_row_eq {m : ℕ} (X : Matrix (Fin m) (Fin m) ℝ) (δ w : Fin m → ℝ) (ρ : ℝ)
    (hw : ∀ i, 0 < w i) (hX : X.mulVec w = ρ • w) (i : Fin m)
    (heq : ∀ j, (X * X) i j = X i j + if i = j then δ i else 0) :
    ρ ^ 2 - ρ = δ i := by
  have h2 : (X * X).mulVec w = (ρ ^ 2) • w := by
    rw [← Matrix.mulVec_mulVec, hX, Matrix.mulVec_smul, hX, smul_smul, sq]
  have key : ((X * X).mulVec w) i = (X.mulVec w) i + δ i * w i := by
    simp only [Matrix.mulVec, dotProduct, heq]
    simp [add_mul, Finset.sum_add_distrib, ite_mul]
  rw [h2, hX] at key
  simp only [Pi.smul_apply, smul_eq_mul] at key
  have hwi := hw i
  have : (ρ ^ 2 - ρ - δ i) * w i = 0 := by linarith
  rcases mul_eq_zero.mp this with h | h
  · linarith
  · linarith

/-- L272, the scalar step: `d ≥ 0` and `ρ² - ρ ≤ d² + d` give `d ≥ ρ - 1`; with equality and `d + ρ > 0`,
`d = ρ - 1`. -/
theorem perron_d (ρ d : ℝ) (hd : 0 ≤ d) (h : ρ ^ 2 - ρ ≤ d ^ 2 + d) : ρ - 1 ≤ d := by
  by_contra hn
  push Not at hn
  nlinarith

theorem perron_d_eq (ρ d : ℝ) (hpos : 0 < d + ρ) (h : ρ ^ 2 - ρ = d ^ 2 + d) : d = ρ - 1 := by
  have : (d - (ρ - 1)) * (d + ρ) = 0 := by linear_combination -h
  rcases mul_eq_zero.mp this with h1 | h1
  · linarith
  · linarith

/-- L272, the trace step: `d_i ≥ ρ - 1` summed (`Σ d ≥ m(ρ - 1)`) against the Rayleigh bound `m ρ ≥ Σ d + 2x` at the
all-ones vector gives `2x ≤ m`. -/
theorem perron_x (m ρ sd x : ℝ) (hsd : m * (ρ - 1) ≤ sd) (hray : sd + 2 * x ≤ m * ρ) : 2 * x ≤ m := by
  linarith

/-- L273's polynomial: in `t = √(1 + a²)`, `Ψ_κ(g) - λ(1 - g²)` along `g = κ a √(1 + a²)` is
`h(t) = λκ²t⁴ - 2κt³ - λκ²t² + 3κt - λ`. -/
def jh (κ l t : ℝ) : ℝ := l * κ ^ 2 * t ^ 4 - 2 * κ * t ^ 3 - l * κ ^ 2 * t ^ 2 + 3 * κ * t - l

/-- L273 (2), the Taylor step: from `t₀` on, every Taylor coefficient of `h` is non-negative once `t₀² ≥ ½` and
`2λκt₀ ≥ 3`, so `h(t₀ + u) ≥ h(t₀)` for `u ≥ 0`. -/
theorem jh_mono (κ l t0 u : ℝ) (hκ : 0 < κ) (hl : 0 < l) (ht0 : 1 / 2 ≤ t0 ^ 2) (h3 : 3 ≤ 2 * l * κ * t0)
    (ht0pos : 0 < t0) (hu : 0 ≤ u) : jh κ l t0 ≤ jh κ l (t0 + u) := by
  have hexp : jh κ l (t0 + u) - jh κ l t0
      = u * ((2 * t0 ^ 2 - 1) * κ * (2 * l * κ * t0 - 3))
        + u ^ 2 * (κ * (6 * l * κ * t0 ^ 2 - 6 * t0 - l * κ))
        + u ^ 3 * (2 * κ * (2 * l * κ * t0 - 1))
        + u ^ 4 * (l * κ ^ 2) := by
    simp only [jh]; ring
  have c1 : 0 ≤ (2 * t0 ^ 2 - 1) * κ * (2 * l * κ * t0 - 3) := by
    have := mul_nonneg (mul_nonneg (by linarith : (0:ℝ) ≤ 2 * t0 ^ 2 - 1) hκ.le) (by linarith : (0:ℝ) ≤ 2 * l * κ * t0 - 3)
    linarith
  have c2 : 0 ≤ κ * (6 * l * κ * t0 ^ 2 - 6 * t0 - l * κ) := by
    have hlk : 0 < l * κ := mul_pos hl hκ
    -- 6λκt₀² - 6t₀ - λκ = λκ(6t₀² - 1) - 6t₀ ≥ (3/(2t₀))(6t₀² - 1) - 6t₀ = 3(2t₀² - 1)/(2t₀) ≥ 0
    have key : 0 ≤ 2 * t0 * (6 * l * κ * t0 ^ 2 - 6 * t0 - l * κ) := by
      nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ 2 * l * κ * t0 - 3) (by nlinarith : (0:ℝ) ≤ 6 * t0 ^ 2 - 1)]
    have : 0 ≤ 6 * l * κ * t0 ^ 2 - 6 * t0 - l * κ := by
      by_contra hn; push Not at hn; nlinarith
    exact mul_nonneg hκ.le this
  have c3 : 0 ≤ 2 * κ * (2 * l * κ * t0 - 1) := by
    have : 0 ≤ 2 * l * κ * t0 - 1 := by linarith
    positivity
  have c4 : 0 ≤ l * κ ^ 2 := by positivity
  have : 0 ≤ jh κ l (t0 + u) - jh κ l t0 := by
    rw [hexp]
    have := mul_nonneg hu c1
    have := mul_nonneg (pow_nonneg hu 2) c2
    have := mul_nonneg (pow_nonneg hu 3) c3
    have := mul_nonneg (pow_nonneg hu 4) c4
    linarith
  linarith

/-- L273 (2), the threshold: with `λκt₀ = 2(m - 2)/(m - 1)`, the condition `2λκt₀ ≥ 3` is `m ≥ 5`. -/
theorem jh_threshold (m : ℝ) (hm : 1 < m) : 3 ≤ 2 * (2 * (m - 2) / (m - 1)) ↔ 5 ≤ m := by
  have hm1 : 0 < m - 1 := by linarith
  rw [show 2 * (2 * (m - 2) / (m - 1)) = 4 * (m - 2) / (m - 1) by ring, le_div_iff₀ hm1]
  constructor <;> intro h <;> linarith

/-- L273 (2), the equality point: with `t₀² = (2m - 1)/(2(m - 1))`, `κ t₀ = √2 √(m-1)/√m`-type constants enter
through two relations, `κ² t₀² (t₀² - 1) = 1/m` (that is `g₀² = 1/m`) and `κ t₀ (3 - 2t₀²) = λ(1 - 1/m)`
(both sides `T_u`); these give `h(t₀) = 0`. -/
theorem jh_zero (κ l t0 m : ℝ) (hg : κ ^ 2 * t0 ^ 2 * (t0 ^ 2 - 1) = 1 / m)
    (hT : κ * t0 * (3 - 2 * t0 ^ 2) = l * (1 - 1 / m)) : jh κ l t0 = 0 := by
  simp only [jh]
  have e1 : l * κ ^ 2 * t0 ^ 4 - l * κ ^ 2 * t0 ^ 2 = l * (1 / m) := by
    rw [← hg]; ring
  have e2 : - 2 * κ * t0 ^ 3 + 3 * κ * t0 = l * (1 - 1 / m) := by
    rw [← hT]; ring
  linarith


/-- L273 (2), the constants: `κ = 2(m-1)/√(m(2m-1))`, `t₀ = √((2m-1)/(2(m-1)))` and
`λ_m = √(2m)(m-2)/((m-1)√(m-1))` satisfy the two relations `jh_zero` uses, `λ_m κ t₀ = 2(m-2)/(m-1)`, and `t₀² ≥ ½`. -/
theorem jh_constants (m : ℝ) (hm : 2 < m) :
    (2 * (m - 1) / Real.sqrt (m * (2 * m - 1))) ^ 2 * (Real.sqrt ((2 * m - 1) / (2 * (m - 1)))) ^ 2 *
        ((Real.sqrt ((2 * m - 1) / (2 * (m - 1)))) ^ 2 - 1) = 1 / m ∧
    (2 * (m - 1) / Real.sqrt (m * (2 * m - 1))) * Real.sqrt ((2 * m - 1) / (2 * (m - 1))) *
        (3 - 2 * (Real.sqrt ((2 * m - 1) / (2 * (m - 1)))) ^ 2)
      = Real.sqrt (2 * m) * (m - 2) / ((m - 1) * Real.sqrt (m - 1)) * (1 - 1 / m) ∧
    Real.sqrt (2 * m) * (m - 2) / ((m - 1) * Real.sqrt (m - 1)) * (2 * (m - 1) / Real.sqrt (m * (2 * m - 1))) *
        Real.sqrt ((2 * m - 1) / (2 * (m - 1))) = 2 * (m - 2) / (m - 1) ∧
    1 / 2 ≤ (Real.sqrt ((2 * m - 1) / (2 * (m - 1)))) ^ 2 := by
  have hm1 : 0 < m - 1 := by linarith
  have hm0 : 0 < m := by linarith
  have h2m : 0 < 2 * m - 1 := by linarith
  have hA : 0 < m * (2 * m - 1) := mul_pos hm0 h2m
  have hB : 0 ≤ (2 * m - 1) / (2 * (m - 1)) := by positivity
  set sA := Real.sqrt (m * (2 * m - 1)) with hsA
  set t0 := Real.sqrt ((2 * m - 1) / (2 * (m - 1))) with ht0
  set s2 := Real.sqrt (2 * m) with hs2
  set s1 := Real.sqrt (m - 1) with hs1
  have eA : sA ^ 2 = m * (2 * m - 1) := Real.sq_sqrt hA.le
  have et : t0 ^ 2 = (2 * m - 1) / (2 * (m - 1)) := Real.sq_sqrt hB
  have e2 : s2 ^ 2 = 2 * m := Real.sq_sqrt (by linarith)
  have e1 : s1 ^ 2 = m - 1 := Real.sq_sqrt hm1.le
  have pA : 0 < sA := Real.sqrt_pos.mpr hA
  have pt : 0 < t0 := Real.sqrt_pos.mpr (by positivity)
  have p2 : 0 < s2 := Real.sqrt_pos.mpr (by linarith)
  have p1 : 0 < s1 := Real.sqrt_pos.mpr hm1
  refine ⟨?_, ?_, ?_, ?_⟩
  · rw [div_pow, eA, et]; field_simp; ring
  · have lhs_pos : 0 ≤ (2 * (m - 1) / sA) * t0 * (3 - 2 * t0 ^ 2) := by
      rw [et]
      have : 0 ≤ 3 - 2 * ((2 * m - 1) / (2 * (m - 1))) := by
        rw [show 3 - 2 * ((2 * m - 1) / (2 * (m - 1))) = (m - 2) / (m - 1) by field_simp; ring]
        exact div_nonneg (by linarith) hm1.le
      positivity
    have rhs_pos : 0 ≤ s2 * (m - 2) / ((m - 1) * s1) * (1 - 1 / m) := by
      have : 0 ≤ 1 - 1 / m := by rw [sub_nonneg, div_le_one hm0]; linarith
      have : 0 ≤ m - 2 := by linarith
      positivity
    rw [← Real.sqrt_sq lhs_pos, ← Real.sqrt_sq rhs_pos]
    congr 1
    simp only [mul_pow, div_pow, eA, et, e2, e1]
    field_simp
    ring
  · have lhs_pos : 0 ≤ s2 * (m - 2) / ((m - 1) * s1) * (2 * (m - 1) / sA) * t0 := by
      have : 0 ≤ m - 2 := by linarith
      positivity
    have rhs_pos : 0 ≤ 2 * (m - 2) / (m - 1) := div_nonneg (by linarith) hm1.le
    rw [← Real.sqrt_sq lhs_pos, ← Real.sqrt_sq rhs_pos]
    congr 1
    simp only [mul_pow, div_pow, eA, et, e2, e1]
    field_simp
  · rw [et, le_div_iff₀ (by linarith)]; linarith

/-- L273 (2), assembled: for `m ≥ 5` the quartic `h` is non-negative from `t₀` on, that is
`λ_m(1 - g²) ≤ Ψ_κ(g)` for every `g ≥ 1/√m`. -/
theorem jh_nonneg (m t : ℝ) (hm : 5 ≤ m) (ht : Real.sqrt ((2 * m - 1) / (2 * (m - 1))) ≤ t) :
    0 ≤ jh (2 * (m - 1) / Real.sqrt (m * (2 * m - 1)))
      (Real.sqrt (2 * m) * (m - 2) / ((m - 1) * Real.sqrt (m - 1))) t := by
  obtain ⟨c1, c2, c3, c4⟩ := jh_constants m (by linarith)
  set κ := 2 * (m - 1) / Real.sqrt (m * (2 * m - 1)) with hκ
  set l := Real.sqrt (2 * m) * (m - 2) / ((m - 1) * Real.sqrt (m - 1)) with hl
  set t0 := Real.sqrt ((2 * m - 1) / (2 * (m - 1))) with ht0
  have hm1 : 0 < m - 1 := by linarith
  have pκ : 0 < κ := by
    have : 0 < Real.sqrt (m * (2 * m - 1)) := Real.sqrt_pos.mpr (by nlinarith)
    positivity
  have pl : 0 < l := by
    have : 0 < Real.sqrt (2 * m) := Real.sqrt_pos.mpr (by linarith)
    have : 0 < Real.sqrt (m - 1) := Real.sqrt_pos.mpr hm1
    have : 0 < m - 2 := by linarith
    positivity
  have pt : 0 < t0 := Real.sqrt_pos.mpr (div_pos (by linarith) (by linarith))
  have h3 : 3 ≤ 2 * l * κ * t0 := by
    have := (jh_threshold m (by linarith)).mpr hm
    calc (3 : ℝ) ≤ 2 * (2 * (m - 2) / (m - 1)) := this
      _ = 2 * l * κ * t0 := by rw [← c3]; ring
  have h0 : jh κ l t0 = 0 := jh_zero κ l t0 m c1 c2
  have := jh_mono κ l t0 (t - t0) pκ pl c4 h3 pt (by linarith)
  rw [show t0 + (t - t0) = t by ring, h0] at this
  exact this

end HamiltonsCubic.I117
