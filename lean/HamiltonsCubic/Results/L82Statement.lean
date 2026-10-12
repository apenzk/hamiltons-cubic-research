import Mathlib

/-!
# L82, the operator-norm lever, STATED, and refuted in its equality clause

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L82, quoted verbatim from the
block's own displayed proof:

> Contracting the identity at the most negative eigenvector kills the negative terms and gives
> `‖ad_{v_N}‖²_op ≥ 2|λ_N|/T₊` with `T₊ = Σ_{λ>0} λ`. With exactly two negative eigenvalues
> `T₊ ≤ 2|λ_N|`, so `‖ad_{v_N}‖_op = s₁ + s₂ ≥ 1`: **at least half the norm of the most negative
> eigenvector sits inside a single 4-plane**, with equality at the `m = 6` witness. Since
> `s₁ + s₂ ≤ √2` with equality only at rank 4 with `s₁ = s₂`, **sharpening `≥ 1` to `= √2` would
> force both negative eigenvectors to be rank-4 complex structures and close `m ≥ 10` outright.**

The heading carries two corrections the block records and this file types: the quantifier is
**at most** two negative eigenvalues, and **the equality clause is REFUTED**.

**What [L82.lean](L82.lean) already carries and this file does not repeat**: the witness
spectrum's unitness and tracelessness as integer arithmetic, and the `4/k ≥ 1 ↔ k ≤ 4` bracket.
**What that file never states is the lever**: no eigenvalues, no `T₊`, no `ad`. Those are typed
here, and the three steps between them are proved.

## The two record inputs, and where each sits

* **The contraction bound `‖ad_{v_N}‖² ≥ 2|λ_N|/T₊`** enters as the hypothesis `hcontract`
  below and is **not proved here**. It is a contraction of the Ricci-flat Bianchi identity at a
  negative eigenvector and needs `Λ²ℝᵐ` and `Q`; the record's Gate 2 calls it a theorem, and this
  file imports it. *It is carried in a binder rather than as a `sorry` only because the goal it
  would head cannot be stated without that base layer.*
* **`‖ad_v‖_op = s₁ + s₂`** is [L31](../../../findings/stratum-two-negative.md)'s root-system
  step. It **is** statable here, so it is stated, and it is PROVED (`adNorm_eq_sum_two`),
  blockwise on the canonical form. The file carries no `sorry`.

## The correction this file makes to the record, with a witness

The block's audit note says *"every unit skew matrix satisfies `s₁ + s₂ ≥ 2/√⌊m/2⌋`, which is
`1.1547` at `m = 6,7` and `1` at `m = 8,9`, so `≥ 1` says nothing until `m = 10`"*.

**The constant `2/√⌊m/2⌋` is the all-equal value, and it is the minimum only from `⌊m/2⌋ = 4`
upward.** At `m = 6` the rank-2 bivector `φ₀₁` is unit under the record's own `Λ²` pairing and
has singular values `(1,0,0)`, so `s₁ + s₂ = 1 < 1.1547`: the displayed inequality is **false at
`m ≤ 7`**. The sharp universal bound is `min(1, 2/√⌊m/2⌋)`, which is `1` exactly when
`⌊m/2⌋ ≤ 4`, i.e. exactly when `m ≤ 9`.

**The audit's conclusion survives and its cut-off is unchanged**, indeed it is now tight rather
than approximate: `s₁ + s₂ ≥ 1` holds for *every* unit skew matrix at `m ≤ 9` and is attained by
the rank-2 one, so the lever is information-free there; from `m = 10` the universal bound falls
below `1` and the lever first says something. `sum_two_ge_one` and `rank_two_refutes_free_bound`
below are the two halves.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L82Statement

open Finset Matrix

/-! ## Step 1, the quantifier: at most two negative eigenvalues gives `T₊ ≤ 2|λ_N|`

Trace-freeness, and nothing else. *The block says the one-negative case is stronger rather than
degenerate, so "at most" is the right quantifier and it is the one used here.* -/

/-- **`T₊ ≤ 2|λ_N|` from trace-freeness alone**, when at most two eigenvalues are negative and
`λ_N` is the most negative of them. `S` is the set of negative indices and `T₊ = Σ_{i ∉ S} λᵢ`. -/
theorem Tplus_le_two_abs {N : ℕ} (lam : Fin N → ℝ) (S : Finset (Fin N)) (iN : Fin N)
    (hiN : iN ∈ S) (hnegN : lam iN < 0)
    (hmin : ∀ i ∈ S, lam iN ≤ lam i)
    (hcard : S.card ≤ 2)
    (htrace : ∑ i, lam i = 0) :
    ∑ i ∈ Sᶜ, lam i ≤ 2 * |lam iN| := by
  have hsplit : (∑ i ∈ S, lam i) + ∑ i ∈ Sᶜ, lam i = ∑ i, lam i :=
    Finset.sum_add_sum_compl S lam
  have hlow : (S.card : ℝ) * lam iN ≤ ∑ i ∈ S, lam i := by
    calc (S.card : ℝ) * lam iN = ∑ _i ∈ S, lam iN := by
            rw [Finset.sum_const, nsmul_eq_mul]
      _ ≤ ∑ i ∈ S, lam i := Finset.sum_le_sum hmin
  have hcard' : (S.card : ℝ) ≤ 2 := by exact_mod_cast hcard
  have h2 : 2 * lam iN ≤ (S.card : ℝ) * lam iN := by nlinarith
  have habs : |lam iN| = -lam iN := abs_of_neg hnegN
  rw [habs]
  rw [htrace] at hsplit
  linarith

/-! ## Step 2, the chain: contraction plus step 1 gives `≥ 1` -/

/-- **The lever.** From the contraction bound and `T₊ ≤ 2|λ_N|`, the operator norm is at least
`1`. *`adn` is `‖ad_{v_N}‖_op`; `hcontract` is the record's contraction of the identity at the
most negative eigenvector and is imported, not proved.* -/
theorem lever {adn absLamN Tplus : ℝ} (hadn : 0 ≤ adn) (hTpos : 0 < Tplus)
    (hcontract : 2 * absLamN / Tplus ≤ adn ^ 2) (hstep1 : Tplus ≤ 2 * absLamN) :
    1 ≤ adn := by
  have h1 : (1 : ℝ) ≤ 2 * absLamN / Tplus := by
    rw [le_div_iff₀ hTpos]; linarith
  nlinarith [le_trans h1 hcontract]

/-! ## Step 3, the equality clause is false, and the block refutes it on its own numbers

The `m = 6` witness has spectrum `(-3,-1,1,1,1,1)/√14`, so `T₊ = 4/√14` and `|λ_N| = 3/√14`.
The contraction bound alone then gives `adn² ≥ 3/2`, and `√(3/2) = 1.2247 > 1`. -/

/-- **The witness's two aggregates.** `2|λ_N|/T₊ = 3/2` at the `m = 6` spectrum, the `√14`
cancelling. -/
theorem witness_ratio (r : ℝ) (hr : 0 < r) : 2 * (3 * r) / (4 * r) = 3 / 2 := by
  field_simp
  ring

/-- **So the equality clause "with equality at the `m = 6` witness" is false**: the block's own
first inequality forces `adn ≥ √(3/2) > 1` there, with no computation. -/
theorem no_equality_at_witness {adn r : ℝ} (hadn : 0 ≤ adn) (hr : 0 < r)
    (hcontract : 2 * (3 * r) / (4 * r) ≤ adn ^ 2) :
    1 < adn ∧ Real.sqrt (3 / 2) ≤ adn := by
  rw [witness_ratio r hr] at hcontract
  have hge : Real.sqrt (3 / 2) ≤ adn := by
    rw [show adn = Real.sqrt (adn ^ 2) by rw [Real.sqrt_sq hadn]]
    exact Real.sqrt_le_sqrt hcontract
  refine ⟨?_, hge⟩
  have h1 : (1 : ℝ) < Real.sqrt (3 / 2) := by
    have : Real.sqrt 1 < Real.sqrt (3 / 2) := Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
    simpa using this
  linarith

/-! ## The universal cap, and the free result at one negative eigenvalue -/

/-- **`s₁ + s₂ ≤ √2`** at every unit skew matrix, since `(s₁+s₂)² ≤ 2(s₁²+s₂²) ≤ 2`. -/
theorem sum_two_le_sqrt_two {s1 s2 : ℝ} (h1 : 0 ≤ s1) (h2 : 0 ≤ s2) (hunit : s1 ^ 2 + s2 ^ 2 ≤ 1) :
    s1 + s2 ≤ Real.sqrt 2 := by
  have hsq : (s1 + s2) ^ 2 ≤ 2 := by nlinarith [sq_nonneg (s1 - s2)]
  have := Real.sqrt_le_sqrt hsq
  rwa [Real.sqrt_sq (by linarith)] at this

/-- **The free result the block leaves unclaimed.** At *one* negative eigenvalue trace-freeness
gives `T₊ = |λ_N|` exactly, so the contraction bound reads `adn² ≥ 2`; against the universal cap
`adn ≤ √2` that is equality, forcing `v_N` to be a rank-4 complex structure. -/
theorem one_negative_forces_sqrt_two {adn absLamN : ℝ} (hadn : 0 ≤ adn) (hpos : 0 < absLamN)
    (hcontract : 2 * absLamN / absLamN ≤ adn ^ 2) (hcap : adn ≤ Real.sqrt 2) :
    adn = Real.sqrt 2 := by
  have h2 : (2 : ℝ) ≤ adn ^ 2 := by
    rw [mul_div_assoc, div_self (ne_of_gt hpos), mul_one] at hcontract
    exact hcontract
  have hs2 : Real.sqrt 2 ≤ adn := by
    rw [show adn = Real.sqrt (adn ^ 2) by rw [Real.sqrt_sq hadn]]
    exact Real.sqrt_le_sqrt h2
  linarith

/-! ## The correction: the sharp universal bound below `m = 10` is `1`, not `2/√⌊m/2⌋`

`s` below lists the `⌊m/2⌋` singular-value *pairs* of a unit skew matrix, in decreasing order;
`Σ sᵢ² = 1` is unitness under the record's `Λ²` pairing `⟨X,Y⟩ = ½ tr(XᵀY)`. Four entries covers
every `m ≤ 9`, the range in which the lever is claimed to be free. -/

/-- **`s₁ + s₂ ≥ 1` at every `m ≤ 9`**, which is the sharp universal bound there. The step is
`2s₀s₁ ≥ 2s₁² ≥ s₂² + s₃²`, which needs `⌊m/2⌋ ≤ 4` and fails from `5` on. -/
theorem sum_two_ge_one (s : Fin 4 → ℝ) (hnn : ∀ i, 0 ≤ s i)
    (hord : s 1 ≤ s 0 ∧ s 2 ≤ s 1 ∧ s 3 ≤ s 2)
    (hunit : ∑ i, s i ^ 2 = 1) :
    1 ≤ s 0 + s 1 := by
  obtain ⟨h10, h21, h32⟩ := hord
  have h0 := hnn 0
  have h1 := hnn 1
  have h2 := hnn 2
  have h3 := hnn 3
  have hsum : s 0 ^ 2 + s 1 ^ 2 + s 2 ^ 2 + s 3 ^ 2 = 1 := by
    simpa [Fin.sum_univ_four] using hunit
  nlinarith [sq_nonneg (s 0 - s 1), sq_nonneg (s 1 - s 2), sq_nonneg (s 1 - s 3)]

/-- **And the record's constant is false at `m = 6`.** The rank-2 bivector has pair spectrum
`(1,0,0)`, which is unit, and `s₁ + s₂ = 1 < 2/√3 = 1.1547`. *Stated on squares, so no root is
taken: `1 < 4/3`.* -/
theorem rank_two_refutes_free_bound :
    (1 : ℝ) ^ 2 + 0 ^ 2 + 0 ^ 2 = 1 ∧ ((1 : ℝ) + 0) ^ 2 < 4 / 3 := by
  constructor <;> norm_num

/-! ## The root-system step, stated

`‖ad_v‖_op = s₁ + s₂` is asserted in the L82 block and proved in
[L31](../../../findings/stratum-two-negative.md)'s file, which this block cites nowhere. It is
stated here through the two clauses that make a real number an attained operator norm, so no
`sSup` is needed. -/

/-- The `Λ²` inner product `⟨X, Y⟩ = ½ tr(Xᵀ Y)`. -/
noncomputable def inner2 {ι : Type*} [Fintype ι] [DecidableEq ι] (X Y : Matrix ι ι ℝ) : ℝ :=
  (1 / 2) * (Xᵀ * Y).trace

/-- The bracket. -/
def br {ι : Type*} [Fintype ι] [DecidableEq ι] (X Y : Matrix ι ι ℝ) : Matrix ι ι ℝ :=
  X * Y - Y * X

/-- `c` is the operator norm of `ad_v` on `𝔰𝔬(m)`: it dominates every ratio and is attained. -/
def AdNormIs {ι : Type*} [Fintype ι] [DecidableEq ι] (v : Matrix ι ι ℝ) (c : ℝ) : Prop :=
  (∀ h : Matrix ι ι ℝ, hᵀ = -h → inner2 (br v h) (br v h) ≤ c ^ 2 * inner2 h h) ∧
    (∃ h : Matrix ι ι ℝ, hᵀ = -h ∧ h ≠ 0 ∧
      inner2 (br v h) (br v h) = c ^ 2 * inner2 h h)

/-- The canonical form of a skew matrix: `⌊m/2⌋` blocks `[[0, -sᵢ], [sᵢ, 0]]` down the diagonal,
`sᵢ` the singular-value pairs. -/
def skewBlocks {k : ℕ} (s : Fin k → ℝ) : Matrix (Fin 2 × Fin k) (Fin 2 × Fin k) ℝ :=
  Matrix.blockDiagonal (fun i => !![0, -s i; s i, 0])

/-! ## The root-system step, proved blockwise

*Conjugation by `O` preserves `inner2` and the bracket, so the operator norm is read off the canonical
form `D`. On the `(a,b)` block, `[D,h]` is `s_a J X - s_b X J`, whose squared norm is
`(s_a+s_b)²‖X‖² - 2 s_a s_b ((x₂-x₃)² + (x₁+x₄)²)`; the diagonal blocks vanish by skewness, and
`s_a + s_b ≤ s₀ + s₁` for `a ≠ b` by the ordering. The anticommuting `diag(1,-1)` in block `(0,1)`
attains it.* -/

namespace Proof

variable {k : ℕ}

abbrev I (k : ℕ) := Fin 2 × Fin k

theorem inner2_conj (O X Y : Matrix (I k) (I k) ℝ) (hO : Oᵀ * O = 1) :
    inner2 (O * X * Oᵀ) (O * Y * Oᵀ) = inner2 X Y := by
  unfold inner2
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose]
  congr 1
  calc _ = (O * (Xᵀ * (Oᵀ * O) * Y) * Oᵀ).trace := by
        simp only [Matrix.mul_assoc]
    _ = (Xᵀ * Y * (Oᵀ * O)).trace := by
        rw [hO, Matrix.mul_one, Matrix.mul_one, Matrix.trace_mul_comm, ← Matrix.mul_assoc, hO,
          Matrix.one_mul]
    _ = (Xᵀ * Y).trace := by rw [hO, Matrix.mul_one]

theorem br_conj (O D H : Matrix (I k) (I k) ℝ) (hO : Oᵀ * O = 1) :
    br (O * D * Oᵀ) (O * H * Oᵀ) = O * br D H * Oᵀ := by
  unfold br
  simp only [Matrix.mul_assoc, ← Matrix.mul_assoc Oᵀ O, hO, Matrix.one_mul, Matrix.mul_sub,
    Matrix.sub_mul]

/-- `inner2 X X` as a sum of the `2 × 2` blocks' squared entries. -/
theorem inner2_blocks (X : Matrix (I k) (I k) ℝ) :
    inner2 X X = (1 / 2) * ∑ a, ∑ b, ∑ p, ∑ q, X (p, a) (q, b) ^ 2 := by
  unfold inner2
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, Fintype.sum_prod_type]
  congr 1
  have e1 : ∀ F : Fin 2 → Fin k → Fin 2 → Fin k → ℝ,
      ∑ q, ∑ b, ∑ p, ∑ a, F q b p a = ∑ t : Fin 2 × Fin k × Fin 2 × Fin k, F t.1 t.2.1 t.2.2.1 t.2.2.2 := by
    intro F; simp only [Fintype.sum_prod_type]
  have e2 : ∀ G : Fin k → Fin k → Fin 2 → Fin 2 → ℝ,
      ∑ a, ∑ b, ∑ p, ∑ q, G a b p q = ∑ t : Fin k × Fin k × Fin 2 × Fin 2, G t.1 t.2.1 t.2.2.1 t.2.2.2 := by
    intro G; simp only [Fintype.sum_prod_type]
  refine (e1 _).trans ((Fintype.sum_equiv
    (⟨fun t => (t.2.2.2, t.2.1, t.2.2.1, t.1), fun t => (t.2.2.2, t.2.1, t.2.2.1, t.1),
      fun _ => rfl, fun _ => rfl⟩ : Fin 2 × Fin k × Fin 2 × Fin k ≃ Fin k × Fin k × Fin 2 × Fin 2)
      _ _ ?_).trans (e2 _).symm)
  rintro ⟨q, b, p, a⟩
  simp only [Equiv.coe_fn_mk, sq]


/-- The four entries of a block of `[D, h]`, `D` the canonical form. -/
theorem brD_00 (s : Fin k → ℝ) (h : Matrix (I k) (I k) ℝ) (a b : Fin k) :
    br (skewBlocks s) h (0, a) (0, b) = -s a * h (1, a) (0, b) - h (0, a) (1, b) * s b := by
  simp [br, skewBlocks, Matrix.mul_apply, Matrix.blockDiagonal_apply, Fintype.sum_prod_type, Fin.sum_univ_two]
theorem brD_01 (s : Fin k → ℝ) (h : Matrix (I k) (I k) ℝ) (a b : Fin k) :
    br (skewBlocks s) h (0, a) (1, b) = -s a * h (1, a) (1, b) + h (0, a) (0, b) * s b := by
  simp [br, skewBlocks, Matrix.mul_apply, Matrix.blockDiagonal_apply, Fintype.sum_prod_type, Fin.sum_univ_two]
theorem brD_10 (s : Fin k → ℝ) (h : Matrix (I k) (I k) ℝ) (a b : Fin k) :
    br (skewBlocks s) h (1, a) (0, b) = s a * h (0, a) (0, b) - h (1, a) (1, b) * s b := by
  simp [br, skewBlocks, Matrix.mul_apply, Matrix.blockDiagonal_apply, Fintype.sum_prod_type, Fin.sum_univ_two]
theorem brD_11 (s : Fin k → ℝ) (h : Matrix (I k) (I k) ℝ) (a b : Fin k) :
    br (skewBlocks s) h (1, a) (1, b) = s a * h (0, a) (1, b) + h (1, a) (0, b) * s b := by
  simp [br, skewBlocks, Matrix.mul_apply, Matrix.blockDiagonal_apply, Fintype.sum_prod_type, Fin.sum_univ_two]


theorem block_sq (X : Matrix (I k) (I k) ℝ) (a b : Fin k) :
    ∑ p, ∑ q, X (p, a) (q, b) ^ 2
      = X (0, a) (0, b) ^ 2 + X (0, a) (1, b) ^ 2 + X (1, a) (0, b) ^ 2 + X (1, a) (1, b) ^ 2 := by
  simp only [Fin.sum_univ_two]; ring

/-- **The block bound**: every `2 × 2` block of `[D, h]` is at most `(s₀+s₁)` times that of `h`. -/
theorem block_bound {j : ℕ} (s : Fin (j + 2) → ℝ) (hnn : ∀ i, 0 ≤ s i)
    (hord : ∀ i i' : Fin (j + 2), i ≤ i' → s i' ≤ s i)
    (h : Matrix (I (j + 2)) (I (j + 2)) ℝ) (hh : hᵀ = -h) (a b : Fin (j + 2)) :
    ∑ p, ∑ q, br (skewBlocks s) h (p, a) (q, b) ^ 2 ≤ (s 0 + s 1) ^ 2 * ∑ p, ∑ q, h (p, a) (q, b) ^ 2 := by
  have hsk : ∀ x y, h y x = -h x y := fun x y => by
    have := congrFun (congrFun hh x) y; simpa [Matrix.transpose_apply] using this
  rw [block_sq, block_sq, brD_00, brD_01, brD_10, brD_11]
  set x1 := h (0, a) (0, b); set x2 := h (0, a) (1, b); set x3 := h (1, a) (0, b); set x4 := h (1, a) (1, b)
  have hq : 0 ≤ x1 ^ 2 + x2 ^ 2 + x3 ^ 2 + x4 ^ 2 := by positivity
  by_cases hab : a = b
  · subst hab
    have e1 : x1 = 0 := by have := hsk (0, a) (0, a); linarith
    have e4 : x4 = 0 := by have := hsk (1, a) (1, a); linarith
    have e3 : x3 = -x2 := hsk (0, a) (1, a)
    rw [e1, e4, e3]
    nlinarith [sq_nonneg (s 0 + s 1), sq_nonneg x2]
  · have hsa := hnn a; have hsb := hnn b
    have hsum : s a + s b ≤ s 0 + s 1 := by
      rcases lt_or_gt_of_ne hab with h1 | h1
      · have : s a ≤ s 0 := hord 0 a (Fin.zero_le _)
        have : s b ≤ s 1 := hord 1 b (by
          rw [Fin.le_def]; have := Fin.lt_def.mp h1; simp at this ⊢; omega)
        linarith
      · have : s b ≤ s 0 := hord 0 b (Fin.zero_le _)
        have : s a ≤ s 1 := hord 1 a (by
          rw [Fin.le_def]; have := Fin.lt_def.mp h1; simp at this ⊢; omega)
        linarith
    have key : (-s a * x3 - x2 * s b) ^ 2 + (-s a * x4 + x1 * s b) ^ 2 + (s a * x1 - x4 * s b) ^ 2
        + (s a * x2 + x3 * s b) ^ 2
        = (s a + s b) ^ 2 * (x1 ^ 2 + x2 ^ 2 + x3 ^ 2 + x4 ^ 2)
          - 2 * (s a * s b) * ((x2 - x3) ^ 2 + (x1 + x4) ^ 2) := by ring
    rw [key]
    have h2 : (s a + s b) ^ 2 ≤ (s 0 + s 1) ^ 2 := by nlinarith
    have h3 : 0 ≤ 2 * (s a * s b) * ((x2 - x3) ^ 2 + (x1 + x4) ^ 2) := by positivity
    nlinarith [mul_le_mul_of_nonneg_right h2 hq]

theorem bound_D {j : ℕ} (s : Fin (j + 2) → ℝ) (hnn : ∀ i, 0 ≤ s i)
    (hord : ∀ i i' : Fin (j + 2), i ≤ i' → s i' ≤ s i)
    (h : Matrix (I (j + 2)) (I (j + 2)) ℝ) (hh : hᵀ = -h) :
    inner2 (br (skewBlocks s) h) (br (skewBlocks s) h) ≤ (s 0 + s 1) ^ 2 * inner2 h h := by
  rw [inner2_blocks, inner2_blocks]
  have hsum : ∑ a, ∑ b, ∑ p, ∑ q, br (skewBlocks s) h (p, a) (q, b) ^ 2
      ≤ (s 0 + s 1) ^ 2 * ∑ a, ∑ b, ∑ p, ∑ q, h (p, a) (q, b) ^ 2 := by
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun a _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun b _ => block_bound s hnn hord h hh a b
  calc (1 / 2) * ∑ a, ∑ b, ∑ p, ∑ q, br (skewBlocks s) h (p, a) (q, b) ^ 2
      ≤ (1 / 2) * ((s 0 + s 1) ^ 2 * ∑ a, ∑ b, ∑ p, ∑ q, h (p, a) (q, b) ^ 2) := by linarith
    _ = _ := by ring

/-- The attaining `h`: the anticommuting `diag(1,-1)` in block `(0,1)`, and its negative
transpose in block `(1,0)`. -/
def h0 (j : ℕ) : Matrix (I (j + 2)) (I (j + 2)) ℝ := fun x y =>
  if x.2 = 0 ∧ y.2 = 1 then (if x.1 = y.1 then (if x.1 = 0 then 1 else -1) else 0)
  else if x.2 = 1 ∧ y.2 = 0 then (if x.1 = y.1 then (if x.1 = 0 then -1 else 1) else 0) else 0

theorem h0_skew (j : ℕ) : (h0 j)ᵀ = -h0 j := by
  have h01 : (0 : Fin (j + 2)) ≠ 1 := by simp [Fin.ext_iff]
  ext x y
  simp only [Matrix.transpose_apply, Matrix.neg_apply, h0]
  by_cases a1 : x.2 = 0 <;> by_cases a2 : x.2 = 1 <;> by_cases b1 : y.2 = 0 <;> by_cases b2 : y.2 = 1 <;>
    simp_all [eq_comm] <;> split_ifs <;> simp_all

theorem block_eq_h0 {j : ℕ} (s : Fin (j + 2) → ℝ) (a b : Fin (j + 2)) :
    ∑ p, ∑ q, br (skewBlocks s) (h0 j) (p, a) (q, b) ^ 2
      = (s 0 + s 1) ^ 2 * ∑ p, ∑ q, h0 j (p, a) (q, b) ^ 2 := by
  have h01 : (0 : Fin (j + 2)) ≠ 1 := by simp [Fin.ext_iff]
  rw [block_sq, block_sq, brD_00, brD_01, brD_10, brD_11]
  by_cases hA : a = 0 ∧ b = 1
  · obtain ⟨rfl, rfl⟩ := hA; simp [h0, h01]; ring
  · by_cases hB : a = 1 ∧ b = 0
    · obtain ⟨rfl, rfl⟩ := hB; simp [h0, h01, Ne.symm h01]; ring
    · simp [h0, hA, hB]

theorem eq_D {j : ℕ} (s : Fin (j + 2) → ℝ) :
    inner2 (br (skewBlocks s) (h0 j)) (br (skewBlocks s) (h0 j)) = (s 0 + s 1) ^ 2 * inner2 (h0 j) (h0 j) := by
  rw [inner2_blocks, inner2_blocks]
  simp only [block_eq_h0, ← Finset.mul_sum]
  ring

theorem h0_ne (j : ℕ) : h0 j ≠ 0 := by
  intro h
  have := congrFun (congrFun h (0, 0)) (0, 1)
  simp [h0, Fin.ext_iff] at this

theorem adNorm' {j : ℕ} (s : Fin (j + 2) → ℝ)
    (hnn : ∀ i, 0 ≤ s i) (hord : ∀ i i' : Fin (j + 2), i ≤ i' → s i' ≤ s i)
    (v : Matrix (Fin 2 × Fin (j + 2)) (Fin 2 × Fin (j + 2)) ℝ)
    (O : Matrix (Fin 2 × Fin (j + 2)) (Fin 2 × Fin (j + 2)) ℝ) (hO : Oᵀ * O = 1)
    (hcanon : v = O * skewBlocks s * Oᵀ) :
    AdNormIs v (s 0 + s 1) := by
  have hO' : O * Oᵀ = 1 := mul_eq_one_comm.mp hO
  subst hcanon
  refine ⟨fun h hh => ?_, ⟨O * h0 j * Oᵀ, ?_, ?_, ?_⟩⟩
  · set h' := Oᵀ * h * O
    have hrec : h = O * h' * Oᵀ := by
      simp only [h', ← Matrix.mul_assoc, hO', Matrix.one_mul]
      rw [Matrix.mul_assoc, hO', Matrix.mul_one]
    have hh' : h'ᵀ = -h' := by
      simp only [h', Matrix.transpose_mul, Matrix.transpose_transpose, hh, Matrix.neg_mul, Matrix.mul_neg,
        Matrix.mul_assoc]
    rw [hrec, br_conj O _ _ hO, inner2_conj O _ _ hO, inner2_conj O _ _ hO]
    exact bound_D s hnn hord h' hh'
  · rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, h0_skew]
    simp only [Matrix.neg_mul, Matrix.mul_neg, Matrix.mul_assoc]
  · intro h
    apply h0_ne j
    have h2 : Oᵀ * (O * h0 j * Oᵀ) * O = 0 := by rw [h]; simp
    have h3 : Oᵀ * (O * h0 j * Oᵀ) * O = h0 j := by
      simp only [← Matrix.mul_assoc, hO, Matrix.one_mul]
      rw [Matrix.mul_assoc, hO, Matrix.mul_one]
    rw [h3] at h2; exact h2
  · rw [br_conj O _ _ hO, inner2_conj O _ _ hO, inner2_conj O _ _ hO]
    exact eq_D s

end Proof

/-- **`‖ad_v‖_op = s₁ + s₂`**, the largest sum of two distinct singular-value pairs of `v`.

**Proved** (`Proof.adNorm'`), blockwise on the canonical form: this is
[L31](../../../findings/stratum-two-negative.md)'s root-system step, which the L82 block asserts and
does not cite.

**The typing covers even `m = 2(j+2) ≥ 4` and says so.** An odd `m` adds a zero row and column
to the canonical form, and the identity is unchanged there; that case is outside this statement
rather than denied by it. The block's own witnesses sit at `m = 6, 8, 10`. -/
theorem adNorm_eq_sum_two {j : ℕ} (s : Fin (j + 2) → ℝ)
    (hnn : ∀ i, 0 ≤ s i) (hord : ∀ i i' : Fin (j + 2), i ≤ i' → s i' ≤ s i)
    (v : Matrix (Fin 2 × Fin (j + 2)) (Fin 2 × Fin (j + 2)) ℝ)
    (O : Matrix (Fin 2 × Fin (j + 2)) (Fin 2 × Fin (j + 2)) ℝ) (hO : Oᵀ * O = 1)
    (hcanon : v = O * skewBlocks s * Oᵀ) :
    AdNormIs v (s 0 + s 1) :=
  Proof.adNorm' s hnn hord v O hO hcanon

/-! ## The statement itself -/

/-- **L82, corrected.** At a unit critical Weyl operator with **at most** two negative
eigenvalues, the most negative eigenvector `v_N` satisfies `‖ad_{v_N}‖_op ≥ 1`; and the block's
equality clause is false, the same contraction forcing `≥ √(3/2)` at the `m = 6` witness.

*`hcontract` is the record's contraction bound, imported. Everything after it is proved.* -/
theorem L82 {N : ℕ} (lam : Fin N → ℝ) (S : Finset (Fin N)) (iN : Fin N) (adn : ℝ)
    (hiN : iN ∈ S) (hnegN : lam iN < 0)
    (hmin : ∀ i ∈ S, lam iN ≤ lam i) (hcard : S.card ≤ 2)
    (htrace : ∑ i, lam i = 0) (hTpos : 0 < ∑ i ∈ Sᶜ, lam i) (hadn : 0 ≤ adn)
    (hcontract : 2 * |lam iN| / (∑ i ∈ Sᶜ, lam i) ≤ adn ^ 2) :
    1 ≤ adn :=
  lever hadn hTpos hcontract (Tplus_le_two_abs lam S iN hiN hnegN hmin hcard htrace)

/-- **The hypotheses of `L82` are inhabited**, so the lever is not vacuous: two negative
eigenvalues and four positive ones, trace-free, with `T₊ = 4 > 0` and the most negative at
`-3`. *This is the `m = 6` witness's spectrum up to the `1/√14` scale, which the ratio
`2|λ_N|/T₊` does not see.* -/
example : ∑ i : Fin 6, ![(-3 : ℝ), -1, 1, 1, 1, 1] i = 0 := by
  simp [Fin.sum_univ_six]
  norm_num

end HamiltonsCubic.L82Statement
