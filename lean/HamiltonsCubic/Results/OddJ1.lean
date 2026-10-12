import HamiltonsCubic.Results.J1
import HamiltonsCubic.Results.OddMW

set_option linter.style.longLine false

/-!
# J1 on the torus slice of `so(2m + 1)`, for `m ≥ 7`

[The R48 working note](../../../reviews/2026-09-27-R48-torus-families.md), batch 11, Gate 2 by r1708 and r1709.
With `U, V` symmetric with zero diagonal on `m = n + 1` indices, `w` a vector, `P = U + V`, `Q = U − V`,
`d_i = Σ_l (U_il² + V_il²)` (`dvec`), `b² = ‖U‖² + ‖V‖² + 2‖w‖² = 1` and
`g² = Σ_i (d_i + w_i²)² + Σ_{i ≠ j} P_ij² Q_ij²`, the statement `J1odd_holds` is

  `½ (tr P³ + tr Q³) + 3 wᵀ P w + λ g² ≤ c₀`,  `λ = 3√2 m / (2(2m − 1))`, `c₀ = √2 (2m − 1)(4m − 1) / (8m²)`.

The proof, one declaration per step of batch 11:
- `bord`: the embedding into `m + 1` indices, `w/√2` on the new row and column of both `U` and `V`, with its entry
  lemmas `bord_cc`, `bord_cl`, `bord_lc`, `bord_ll`, `bord_add`, `bord_sub`, `pairw_bord`, `dvec_bord_c`,
  `dvec_bord_l`.
- `trace_bord` (with `trace_cube`): `tr (bord A z)³ = tr A³ + 3 Σ z_b A_bc z_c`, so the bordered cubic part is the
  left side's cubic part plus `3 wᵀ P w` (step 1).
- L277's `cocktail_rows` at size `m + 1` (step 2), then Cauchy–Schwarz within the old pairs and within the new ones,
  through `term_le`, `fw_symm`, `Rw_symm'` and `sqrt_two_mul` (step 3).
- `sqrt_amgm`: `√F √R ≤ (tF + R/t)/2`, at `t = √2 To` and `t = √2 Tn` (step 4).
- L277's `pair_bound` on the old pairs (step 5), and `fw_new`, the new pairs' exact value (step 6).
- `J1odd_holds`: the assembly, closing on L278's `oddMWprime` at the walk `W i j = U_ij² + V_ij²`, `u i = w_i²`
  (step 7).
-/

namespace HamiltonsCubic.OddJ1

open Matrix Finset HamiltonsCubic.I117S HamiltonsCubic.J1

variable {n : ℕ}

/-- A square matrix bordered by a vector, with a zero corner. -/
noncomputable def bord (A : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z : Fin (n + 1) → ℝ) :
    Matrix (Fin (n + 1 + 1)) (Fin (n + 1 + 1)) ℝ :=
  Matrix.of fun a b => Fin.lastCases (Fin.lastCases 0 z b) (fun i => Fin.lastCases (z i) (fun j => A i j) b) a

@[simp] theorem bord_cc (A : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z : Fin (n + 1) → ℝ) (i j : Fin (n + 1)) :
    bord A z i.castSucc j.castSucc = A i j := by simp [bord]
@[simp] theorem bord_cl (A : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z : Fin (n + 1) → ℝ) (i : Fin (n + 1)) :
    bord A z i.castSucc (Fin.last _) = z i := by simp [bord]
@[simp] theorem bord_lc (A : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z : Fin (n + 1) → ℝ) (j : Fin (n + 1)) :
    bord A z (Fin.last _) j.castSucc = z j := by simp [bord]
@[simp] theorem bord_ll (A : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z : Fin (n + 1) → ℝ) :
    bord A z (Fin.last _) (Fin.last _) = 0 := by simp [bord]

theorem bord_add (A B : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z y : Fin (n + 1) → ℝ) :
    bord A z + bord B y = bord (A + B) (z + y) := by
  ext a b
  refine Fin.lastCases ?_ (fun i => ?_) a <;> refine Fin.lastCases ?_ (fun j => ?_) b <;> simp

theorem bord_sub (A B : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z y : Fin (n + 1) → ℝ) :
    bord A z - bord B y = bord (A - B) (z - y) := by
  ext a b
  refine Fin.lastCases ?_ (fun i => ?_) a <;> refine Fin.lastCases ?_ (fun j => ?_) b <;> simp

theorem trace_cube {N : ℕ} (M : Matrix (Fin N) (Fin N) ℝ) :
    Matrix.trace (M * M * M) = ∑ a, ∑ b, ∑ c, M a b * M b c * M c a := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Finset.sum_mul]
  exact Finset.sum_congr rfl fun a _ => Finset.sum_comm

theorem trace_bord (A : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z : Fin (n + 1) → ℝ) :
    Matrix.trace (bord A z * bord A z * bord A z) = Matrix.trace (A * A * A) + 3 * ∑ i, ∑ j, z i * A i j * z j := by
  rw [trace_cube, trace_cube]
  simp only [Fin.sum_univ_castSucc (n := n + 1), bord_cc, bord_cl, bord_lc, bord_ll, mul_zero, zero_mul, add_zero, Finset.sum_const_zero,
    Finset.sum_add_distrib]
  have h1 : ∑ i, ∑ j, A i j * z j * z i = ∑ i, ∑ j, z i * A i j * z j :=
    Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  have h2 : ∑ i, ∑ k, z i * z k * A k i = ∑ i, ∑ j, z i * A i j * z j := by
    rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  have h3 : ∑ j, ∑ k, z j * A j k * z k = ∑ i, ∑ j, z i * A i j * z j := rfl
  linarith [h1, h2, h3]

theorem pairw_bord (A : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z : Fin (n + 1) → ℝ) (hA : IsPairWeights A) :
    IsPairWeights (bord A z) := by
  refine ⟨?_, fun a => ?_⟩
  · ext a b
    refine Fin.lastCases ?_ (fun i => ?_) a <;> refine Fin.lastCases ?_ (fun j => ?_) b <;>
      simp [Matrix.transpose_apply, symm_of A hA]
  · refine Fin.lastCases ?_ (fun i => ?_) a <;> simp [hA.2]

theorem dvec_bord_c (U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z y : Fin (n + 1) → ℝ) (i : Fin (n + 1)) :
    dvec (bord U z) (bord V y) i.castSucc = dvec U V i + (z i ^ 2 + y i ^ 2) := by
  simp [dvec, Fin.sum_univ_castSucc (n := n + 1)]

theorem dvec_bord_l (U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z y : Fin (n + 1) → ℝ) :
    dvec (bord U z) (bord V y) (Fin.last _) = ∑ j, (z j ^ 2 + y j ^ 2) := by
  simp [dvec, Fin.sum_univ_castSucc (n := n + 1)]

/-! ### Pair terms at any size -/

theorem fw_nonneg' {N : ℕ} (U V : Matrix (Fin N) (Fin N) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V)
    (i j : Fin N) : 0 ≤ fw U V i j := by
  unfold fw; split_ifs with h
  · exact le_refl 0
  · have hR := Rw_nonneg U V hU hV i j
    by_cases hij : i = j
    · simp [Rw, hij] at h
    · have hwi := w_le_d U V i j
      have hwj := w_le_d U V j i
      rw [symm_of U hU i j, symm_of V hV i j] at hwj
      exact div_nonneg (mul_nonneg (sq_nonneg _) (mul_nonneg (by linarith) (by linarith))) hR

theorem term_le {N : ℕ} (U V : Matrix (Fin N) (Fin N) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) (i j : Fin N) :
    (|U i j| + |V i j|) * Real.sqrt ((dvec U V i - (U i j ^ 2 + V i j ^ 2)) * (dvec U V j - (U i j ^ 2 + V i j ^ 2)))
      ≤ Real.sqrt (fw U V i j) * Real.sqrt (Rw U V i j) := by
  have hRHS : 0 ≤ Real.sqrt (fw U V i j) * Real.sqrt (Rw U V i j) := by positivity
  by_cases hij : i = j
  · subst hij; rw [hU.2 i, hV.2 i, abs_zero, add_zero, zero_mul]; exact hRHS
  have hwi := w_le_d U V i j
  have hwj := w_le_d U V j i
  rw [symm_of U hU i j, symm_of V hV i j] at hwj
  set E := (dvec U V i - (U i j ^ 2 + V i j ^ 2)) * (dvec U V j - (U i j ^ 2 + V i j ^ 2)) with hE
  have hE0 : 0 ≤ E := mul_nonneg (by linarith) (by linarith)
  have hER := ee_le_R U V hU hV i j hij
  by_cases hR : Rw U V i j = 0
  · have : E = 0 := le_antisymm (hR ▸ hER) hE0
    rw [this, Real.sqrt_zero, mul_zero]; exact hRHS
  have hfe : fw U V i j * Rw U V i j = (|U i j| + |V i j|) ^ 2 * E := by
    simp only [fw, if_neg hR, hE]; exact div_mul_cancel₀ _ hR
  rw [← Real.sqrt_mul (fw_nonneg' U V hU hV i j), hfe, Real.sqrt_mul (sq_nonneg _), Real.sqrt_sq (by positivity)]

theorem fw_symm {N : ℕ} (U V : Matrix (Fin N) (Fin N) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) (i j : Fin N) :
    fw U V j i = fw U V i j := by
  have hR : Rw U V j i = Rw U V i j := by
    unfold Rw; split_ifs with h1 h2 h2
    · rfl
    · exact absurd h1.symm h2
    · exact absurd h2.symm h1
    · rw [symm_of U hU j i, symm_of V hV j i]; ring
  unfold fw; rw [hR, symm_of U hU j i, symm_of V hV j i]; split_ifs <;> ring

/-- The linearisation `√F √R ≤ (t F + R/t)/2`. -/
theorem sqrt_amgm (F R t : ℝ) (hF : 0 ≤ F) (hR : 0 ≤ R) (ht : 0 < t) :
    Real.sqrt F * Real.sqrt R ≤ (t * F + R / t) / 2 := by
  have h := sq_nonneg (t * Real.sqrt F - Real.sqrt R)
  have hF' := Real.sq_sqrt hF
  have hR' := Real.sq_sqrt hR
  have e : (t * F + R / t) / 2 - Real.sqrt F * Real.sqrt R = (t * Real.sqrt F - Real.sqrt R) ^ 2 / (2 * t) := by
    field_simp; nlinarith [hF', hR']
  have : 0 ≤ (t * Real.sqrt F - Real.sqrt R) ^ 2 / (2 * t) := by positivity
  linarith

/-! ### The new edges are exact -/

theorem fw_new (U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z : Fin (n + 1) → ℝ) (i : Fin (n + 1)) :
    fw (bord U z) (bord V z) i.castSucc (Fin.last _)
      = 2 * z i ^ 2 * 2 * (1 - 2 * z i ^ 2 / (dvec U V i + 2 * z i ^ 2)) * (1 - 2 * z i ^ 2 / ∑ j, 2 * z j ^ 2) := by
  have hdc := dvec_bord_c U V z z i
  have hdl := dvec_bord_l U V z z
  have e2 : ∀ x : ℝ, x ^ 2 + x ^ 2 = 2 * x ^ 2 := fun x => by ring
  simp only [e2] at hdc hdl
  have hR : Rw (bord U z) (bord V z) i.castSucc (Fin.last _) = (dvec U V i + 2 * z i ^ 2) * ∑ j, 2 * z j ^ 2 := by
    unfold Rw; rw [if_neg (Fin.castSucc_ne_last i), hdc, hdl]; simp
  unfold fw; rw [hR]; simp only [bord_cl, hdc, hdl]
  have hsq : (|z i| + |z i|) ^ 2 = 4 * z i ^ 2 := by rw [← two_mul, mul_pow, sq_abs]; ring
  rw [hsq]
  have hdn : 0 ≤ dvec U V i := d_nonneg U V i
  have hzl : 2 * z i ^ 2 ≤ ∑ j, 2 * z j ^ 2 :=
    Finset.single_le_sum (f := fun j => 2 * z j ^ 2) (fun j _ => by positivity) (Finset.mem_univ i)
  split_ifs with h
  · rcases mul_eq_zero.1 h with h1 | h1
    · have : z i = 0 := by nlinarith [sq_nonneg (z i)]
      simp [this]
    · have : z i = 0 := by nlinarith [sq_nonneg (z i)]
      simp [this]
  · have h1 : dvec U V i + 2 * z i ^ 2 ≠ 0 := fun hc => h (by rw [hc, zero_mul])
    have h2 : ∑ j, 2 * z j ^ 2 ≠ 0 := fun hc => h (by rw [hc, mul_zero])
    set D := dvec U V i + 2 * z i ^ 2 with hD
    set Sz := ∑ j, 2 * z j ^ 2 with hSz
    field_simp
    ring

theorem Rw_symm' {N : ℕ} (U V : Matrix (Fin N) (Fin N) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) (i j : Fin N) :
    Rw U V j i = Rw U V i j := by
  unfold Rw; split_ifs with h1 h2 h2
  · rfl
  · exact absurd h1.symm h2
  · exact absurd h2.symm h1
  · rw [symm_of U hU j i, symm_of V hV j i]; ring

theorem sqrt_two_mul (A B : ℝ) : Real.sqrt (2 * A) * Real.sqrt (2 * B) = 2 * (Real.sqrt A * Real.sqrt B) := by
  rw [Real.sqrt_mul (by norm_num), Real.sqrt_mul (by norm_num)]
  have : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  calc Real.sqrt 2 * Real.sqrt A * (Real.sqrt 2 * Real.sqrt B) = (Real.sqrt 2 * Real.sqrt 2) * (Real.sqrt A * Real.sqrt B) := by ring
    _ = 2 * (Real.sqrt A * Real.sqrt B) := by rw [this]

/-- **J1 on the torus slice of `so(2m + 1)`** for `m = n + 1 ≥ 7`. -/
theorem J1odd_holds (n : ℕ) (hn : 6 ≤ n) (U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (w : Fin (n + 1) → ℝ)
    (hU : IsPairWeights U) (hV : IsPairWeights V)
    (hb : ∑ i, ∑ j, U i j ^ 2 + ∑ i, ∑ j, V i j ^ 2 + 2 * ∑ i, w i ^ 2 = 1) :
    (1 / 2 : ℝ) * (Matrix.trace ((U + V) * (U + V) * (U + V)) + Matrix.trace ((U - V) * (U - V) * (U - V)))
      + 3 * ∑ i, ∑ j, w i * (U + V) i j * w j
      + 3 * Real.sqrt 2 * ((n : ℝ) + 1) / (2 * (2 * ((n : ℝ) + 1) - 1))
        * (∑ i, (dvec U V i + w i ^ 2) ^ 2 + ∑ i, ∑ j, if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2)
      ≤ Real.sqrt 2 * (2 * ((n : ℝ) + 1) - 1) * (4 * ((n : ℝ) + 1) - 1) / (8 * ((n : ℝ) + 1) ^ 2) := by
  set r := Real.sqrt 2 with hr
  have hr2 : r ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hr0 : 0 < r := Real.sqrt_pos.2 (by norm_num)
  set z : Fin (n + 1) → ℝ := fun i => w i / r with hzd
  have hz2 : ∀ i, 2 * z i ^ 2 = w i ^ 2 := fun i => by
    simp only [hzd]; rw [div_pow, hr2]; field_simp
  have hU' := pairw_bord U z hU
  have hV' := pairw_bord V z hV
  -- (1) the trace identity
  have htr : (1 / 2 : ℝ) * (Matrix.trace ((bord U z + bord V z) * (bord U z + bord V z) * (bord U z + bord V z))
        + Matrix.trace ((bord U z - bord V z) * (bord U z - bord V z) * (bord U z - bord V z)))
      = (1 / 2 : ℝ) * (Matrix.trace ((U + V) * (U + V) * (U + V)) + Matrix.trace ((U - V) * (U - V) * (U - V)))
        + 3 * ∑ i, ∑ j, w i * (U + V) i j * w j := by
    rw [bord_add, bord_sub, trace_bord, trace_bord]
    have e1 : ∀ i j, (z + z) i * (U + V) i j * (z + z) j = 2 * (w i * (U + V) i j * w j) := fun i j => by
      simp only [Pi.add_apply, hzd]
      have : (w i / r + w i / r) * (U + V) i j * (w j / r + w j / r) = 4 / r ^ 2 * (w i * (U + V) i j * w j) := by
        field_simp; ring
      rw [this, hr2]; ring
    have e2 : ∀ i j, (z - z) i * (U - V) i j * (z - z) j = 0 := fun i j => by simp
    simp only [e1, e2, Finset.sum_const_zero, mul_zero, add_zero, ← Finset.mul_sum]
    ring
  -- (2) the cocktail rows at size n + 2, split into old and new pairs
  set U' := bord U z with hU'd
  set V' := bord V z with hV'd
  have hcr := cocktail_rows U' V' hU' hV'
  set term : Fin (n + 1 + 1) → Fin (n + 1 + 1) → ℝ := fun a b => (|U' a b| + |V' a b|) *
    Real.sqrt ((dvec U' V' a - (U' a b ^ 2 + V' a b ^ 2)) * (dvec U' V' b - (U' a b ^ 2 + V' a b ^ 2))) with htermd
  have hcr' : (1 / 2 : ℝ) * (Matrix.trace ((U' + V') * (U' + V') * (U' + V')) + Matrix.trace ((U' - V') * (U' - V') * (U' - V')))
      ≤ ∑ a, ∑ b, term a b := hcr
  have hsplit : ∑ a, ∑ b, term a b
      = ∑ i : Fin (n + 1), ∑ j : Fin (n + 1), term i.castSucc j.castSucc + ∑ i : Fin (n + 1), (term i.castSucc (Fin.last _) + term (Fin.last _) i.castSucc) := by
    have hll : term (Fin.last _) (Fin.last _) = 0 := by simp [htermd, hU'd, hV'd]
    simp only [Fin.sum_univ_castSucc (n := n + 1), hll, add_zero, Finset.sum_add_distrib]
    ring
  -- (3) Cauchy–Schwarz within each group
  set Fo := ∑ i : Fin (n + 1), ∑ j : Fin (n + 1), fw U' V' i.castSucc j.castSucc with hFo
  set Ro := ∑ i : Fin (n + 1), ∑ j : Fin (n + 1), Rw U' V' i.castSucc j.castSucc with hRo
  set fn := ∑ i : Fin (n + 1), fw U' V' i.castSucc (Fin.last _) with hfn
  set rn := ∑ i : Fin (n + 1), Rw U' V' i.castSucc (Fin.last _) with hrn
  have hFo0 : 0 ≤ Fo := Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => fw_nonneg' U' V' hU' hV' _ _
  have hRo0 : 0 ≤ Ro := Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => Rw_nonneg U' V' hU' hV' _ _
  have hfn0 : 0 ≤ fn := Finset.sum_nonneg fun i _ => fw_nonneg' U' V' hU' hV' _ _
  have hrn0 : 0 ≤ rn := Finset.sum_nonneg fun i _ => Rw_nonneg U' V' hU' hV' _ _
  have hold : ∑ i : Fin (n + 1), ∑ j : Fin (n + 1), term i.castSucc j.castSucc ≤ Real.sqrt Fo * Real.sqrt Ro := by
    have hsum : ∀ F : Fin (n + 1) → Fin (n + 1) → ℝ, ∑ i, ∑ j, F i j = ∑ p : Fin (n + 1) × Fin (n + 1), F p.1 p.2 :=
      fun F => (Fintype.sum_prod_type' F).symm
    calc _ ≤ ∑ i : Fin (n + 1), ∑ j : Fin (n + 1), Real.sqrt (fw U' V' i.castSucc j.castSucc) * Real.sqrt (Rw U' V' i.castSucc j.castSucc) :=
          Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => term_le U' V' hU' hV' _ _
      _ = ∑ p : Fin (n + 1) × Fin (n + 1), Real.sqrt (fw U' V' p.1.castSucc p.2.castSucc)
            * Real.sqrt (Rw U' V' p.1.castSucc p.2.castSucc) := hsum _
      _ ≤ Real.sqrt (∑ p : Fin (n + 1) × Fin (n + 1), fw U' V' p.1.castSucc p.2.castSucc)
            * Real.sqrt (∑ p : Fin (n + 1) × Fin (n + 1), Rw U' V' p.1.castSucc p.2.castSucc) :=
          Real.sum_sqrt_mul_sqrt_le _ (fun p => fw_nonneg' U' V' hU' hV' _ _) (fun p => Rw_nonneg U' V' hU' hV' _ _)
      _ = _ := by rw [← hsum (fun i j => fw U' V' i.castSucc j.castSucc), ← hsum (fun i j => Rw U' V' i.castSucc j.castSucc)]
  have hnew : ∑ i : Fin (n + 1), (term i.castSucc (Fin.last _) + term (Fin.last _) i.castSucc)
      ≤ Real.sqrt (2 * fn) * Real.sqrt (2 * rn) := by
    rw [sqrt_two_mul]
    have hpt : ∀ i : Fin (n + 1), term i.castSucc (Fin.last _) + term (Fin.last _) i.castSucc
        ≤ 2 * (Real.sqrt (fw U' V' i.castSucc (Fin.last _)) * Real.sqrt (Rw U' V' i.castSucc (Fin.last _))) := fun i => by
      have h1 := term_le U' V' hU' hV' i.castSucc (Fin.last _)
      have h2 := term_le U' V' hU' hV' (Fin.last _) i.castSucc
      rw [fw_symm U' V' hU' hV', Rw_symm' U' V' hU' hV'] at h2
      simp only [htermd]; linarith
    calc _ ≤ ∑ i : Fin (n + 1), 2 * (Real.sqrt (fw U' V' i.castSucc (Fin.last _)) * Real.sqrt (Rw U' V' i.castSucc (Fin.last _))) :=
          Finset.sum_le_sum fun i _ => hpt i
      _ = 2 * ∑ i : Fin (n + 1), Real.sqrt (fw U' V' i.castSucc (Fin.last _)) * Real.sqrt (Rw U' V' i.castSucc (Fin.last _)) := by
          rw [Finset.mul_sum]
      _ ≤ 2 * (Real.sqrt fn * Real.sqrt rn) := by
          apply mul_le_mul_of_nonneg_left _ (by norm_num)
          exact Real.sum_sqrt_mul_sqrt_le _ (fun i => fw_nonneg' U' V' hU' hV' _ _) (fun i => Rw_nonneg U' V' hU' hV' _ _)
  -- (4) the linearisation at t_o = √2 To and t_n = √2 Tn
  have hTo := HamiltonsCubic.OddMW.side_To (n - 6)
  have hTn := HamiltonsCubic.OddMW.side_Tn (n - 6)
  have hn6 : ((n - 6 : ℕ) : ℝ) + 7 = (n : ℝ) + 1 := by push_cast [Nat.cast_sub hn]; ring
  rw [hn6] at hTo hTn
  set To' := HamiltonsCubic.OddMW.To ((n : ℝ) + 1) with hTo'd
  set Tn' := HamiltonsCubic.OddMW.Tn ((n : ℝ) + 1) with hTn'd
  have hlo := sqrt_amgm Fo Ro (r * To') hFo0 hRo0 (mul_pos hr0 hTo)
  have hln := sqrt_amgm (2 * fn) (2 * rn) (r * Tn') (by positivity) (by positivity) (mul_pos hr0 hTn)
  -- (5) the walk and its degrees
  set W : Fin (n + 1) → Fin (n + 1) → ℝ := fun i j => U i j ^ 2 + V i j ^ 2 with hWd
  set P : Fin (n + 1) → ℝ := fun i => ∑ k, W i k + w i ^ 2 with hPd
  set P0 : ℝ := ∑ k, w k ^ 2 with hP0d
  have hdc : ∀ i : Fin (n + 1), dvec U' V' i.castSucc = P i := fun i => by
    rw [hU'd, hV'd, dvec_bord_c]; simp only [hPd, hWd, dvec]; rw [← hz2 i]; ring
  have hdl : dvec U' V' (Fin.last _) = P0 := by
    rw [hU'd, hV'd, dvec_bord_l]; simp only [hP0d]; exact Finset.sum_congr rfl fun j _ => by rw [← hz2 j]; ring
  have hwwc : ∀ i j : Fin (n + 1), ww U' V' i.castSucc j.castSucc = W i j := fun i j => by
    simp only [ww, hU'd, hV'd, bord_cc, hWd]
  have hgamc : ∀ i j : Fin (n + 1), gam U' V' i.castSucc j.castSucc = gam U V i j := fun i j => by
    change gam (bord U z) (bord V z) i.castSucc j.castSucc = gam U V i j
    unfold gam ww; rw [bord_cc, bord_cc]
  -- (6) the old pairs, by pair_bound
  have hFo : Fo ≤ ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
      W i j * (1 - W i j / P i) * (1 + gam U V i j * (1 - 2 * (W i j / P i))) := by
    have h1 : Fo ≤ ∑ i : Fin (n + 1), ∑ j : Fin (n + 1), (hterm U' V' i.castSucc j.castSucc + hterm U' V' j.castSucc i.castSucc) :=
      Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => pair_bound U' V' hU' hV' _ _
    have h2 : ∑ i : Fin (n + 1), ∑ j : Fin (n + 1), (hterm U' V' i.castSucc j.castSucc + hterm U' V' j.castSucc i.castSucc)
        = ∑ i : Fin (n + 1), ∑ j : Fin (n + 1), 2 * hterm U' V' i.castSucc j.castSucc := by
      simp only [Finset.sum_add_distrib]
      rw [Finset.sum_comm (f := fun i j : Fin (n + 1) => hterm U' V' j.castSucc i.castSucc)]
      simp only [← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
    have h3 : ∀ i j : Fin (n + 1), 2 * hterm U' V' i.castSucc j.castSucc
        = W i j * (1 - W i j / P i) * (1 + gam U V i j * (1 - 2 * (W i j / P i))) := fun i j => by
      unfold hterm; rw [hdc, hwwc, hgamc]; ring
    rw [h2, Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => h3 i j] at h1
    exact h1
  -- (7) the old R's
  have hRo : Ro = (∑ i, P i) ^ 2 - ∑ i, P i ^ 2 - ∑ i : Fin (n + 1), ∑ j : Fin (n + 1), W i j ^ 2 * (1 - gam U V i j ^ 2) := by
    have e : ∀ i j : Fin (n + 1), Rw U' V' i.castSucc j.castSucc
        = (if i = j then 0 else P i * P j) - W i j ^ 2 * (1 - gam U V i j ^ 2) := fun i j => by
      have hwg := ww_gam U V i j
      simp only [ww] at hwg
      by_cases hij : i = j
      · subst hij; simp [Rw, hWd, hU.2, hV.2]
      · have hne : i.castSucc ≠ j.castSucc := fun h => hij (Fin.castSucc_injective _ h)
        unfold Rw; rw [if_neg hne, if_neg hij, hdc, hdc]
        simp only [hU'd, hV'd, bord_cc, hWd]; rw [hwg]
    simp only [hRo, e, Finset.sum_sub_distrib]
    have e2 : ∀ i : Fin (n + 1), ∑ j, (if i = j then 0 else P i * P j) = P i * ∑ j, P j - P i ^ 2 := fun i => by
      have : ∑ j, (if i = j then 0 else P i * P j) = ∑ j, P i * P j - ∑ j, (if i = j then P i * P j else 0) := by
        rw [← Finset.sum_sub_distrib]; exact Finset.sum_congr rfl fun j _ => by split_ifs <;> ring
      rw [this, Finset.sum_ite_eq, if_pos (Finset.mem_univ _), ← Finset.mul_sum]; ring
    rw [Finset.sum_congr rfl fun i _ => e2 i, Finset.sum_sub_distrib, ← Finset.sum_mul]; ring
  -- (8) the new pairs are exact
  have hfn : fn = ∑ i : Fin (n + 1), 2 * (w i ^ 2 * (1 - w i ^ 2 / P i) * (1 - w i ^ 2 / P0)) := by
    simp only [hfn, hU'd, hV'd]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [fw_new]
    have e1 : ∀ j, 2 * z j ^ 2 = w j ^ 2 := hz2
    have e3 : dvec U V i + 2 * z i ^ 2 = P i := by simp only [hPd, hWd, dvec]; rw [hz2 i]
    rw [e3, Finset.sum_congr rfl fun j _ => e1 j, e1 i]; ring
  have hrn : rn = P0 * ∑ i, P i := by
    simp only [hrn, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    unfold Rw; rw [if_neg (Fin.castSucc_ne_last i), hdc, hdl]
    simp [hU'd, hV'd]; ring
  -- (9) L278
  have hodd := HamiltonsCubic.OddMW.oddMWprime n hn W (fun i => w i ^ 2)
    (fun i j => by simp only [hWd]; positivity) (fun i j => by simp only [hWd, symm_of U hU i j, symm_of V hV i j])
    (fun i => by simp only [hWd, hU.2 i, hV.2 i]; ring) (fun i => sq_nonneg _)
    (by simp only [hWd, Finset.sum_add_distrib]; linarith [hb]) (gam U V) (fun i j => gam_range U V i j)
  -- (10) the assembly
  set N : ℝ := ∑ i : Fin (n + 1), w i ^ 2 * (1 - w i ^ 2 / P i) * (1 - w i ^ 2 / P0) with hNd
  set A : ℝ := ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
    W i j * (1 - W i j / P i) * (1 + gam U V i j * (1 - 2 * (W i j / P i))) with hAd
  set B : ℝ := ∑ i : Fin (n + 1), ∑ j : Fin (n + 1), W i j ^ 2 * (1 - gam U V i j ^ 2) with hBd
  set Lam' := HamiltonsCubic.OddMW.Lam ((n : ℝ) + 1) with hLam'd
  set C0' := HamiltonsCubic.OddMW.C0 ((n : ℝ) + 1) with hC0'd
  have hfnN : fn = 2 * N := by rw [hfn, hNd, Finset.mul_sum]
  have hsum2 : ∑ i : Fin (n + 1), ∑ j : Fin (n + 1), (To' / 2 * W i j * (1 - W i j / P i)
        * (1 + gam U V i j * (1 - 2 * (W i j / P i))) + (Lam' - 1 / (4 * To')) * W i j ^ 2 * (1 - gam U V i j ^ 2))
      = To' / 2 * A + (Lam' - 1 / (4 * To')) * B := by
    rw [hAd, hBd, Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun j _ => by ring
  have hodd' : To' / 2 * A + (Lam' - 1 / (4 * To')) * B + 2 * Tn' * N
      + 1 / (4 * To') * ((∑ i, P i) ^ 2 - ∑ i, P i ^ 2) + P0 * (∑ i, P i) / (2 * Tn') + Lam' * ∑ i, P i ^ 2 ≤ C0' := by
    rw [← hsum2]; exact hodd
  have hg : ∑ i, (dvec U V i + w i ^ 2) ^ 2 + ∑ i, ∑ j, (if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2)
      = ∑ i, P i ^ 2 + B := by
    have e1 : ∑ i, (dvec U V i + w i ^ 2) ^ 2 = ∑ i, P i ^ 2 :=
      Finset.sum_congr rfl fun i _ => by simp only [hPd, hWd, dvec]
    have e2 : ∑ i, ∑ j, (if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2) = B := by
      rw [hBd]
      refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
      have hwg := ww_gam U V i j
      simp only [ww] at hwg
      by_cases hij : i = j
      · subst hij; simp [hWd, hU.2, hV.2]
      · rw [if_neg hij]; simp only [hWd, Matrix.add_apply, Matrix.sub_apply]; rw [hwg]; ring
    rw [e1, e2]
  have hlam : 3 * r * ((n : ℝ) + 1) / (2 * (2 * ((n : ℝ) + 1) - 1)) = r * Lam' := by
    rw [hLam'd]; unfold HamiltonsCubic.OddMW.Lam; ring
  have hc0 : r * (2 * ((n : ℝ) + 1) - 1) * (4 * ((n : ℝ) + 1) - 1) / (8 * ((n : ℝ) + 1) ^ 2) = r * C0' := by
    rw [hC0'd]; unfold HamiltonsCubic.OddMW.C0; ring
  have hTo0 : 0 < To' := hTo
  have hTn0 : 0 < Tn' := hTn
  have h1 : r * To' * Fo ≤ r * To' * A := mul_le_mul_of_nonneg_left hFo (by positivity)
  have h2 : Ro / (r * To') = r * Ro / (2 * To') := by
    rw [div_eq_div_iff (by positivity) (by positivity)]; linear_combination (-(Ro * To')) * hr2
  have h3 : 2 * rn / (r * Tn') = r * rn / Tn' := by
    rw [div_eq_div_iff (by positivity) (by positivity)]; linear_combination (-(rn * Tn')) * hr2
  have hfin := mul_le_mul_of_nonneg_left hodd' hr0.le
  rw [hlam, hc0, hg, ← htr]
  have hid : (r * To' * A + r * Ro / (2 * To')) / 2 + (r * Tn' * (2 * fn) + r * rn / Tn') / 2
        + r * Lam' * (∑ i, P i ^ 2 + B)
      = r * (To' / 2 * A + (Lam' - 1 / (4 * To')) * B + 2 * Tn' * N
        + 1 / (4 * To') * ((∑ i, P i) ^ 2 - ∑ i, P i ^ 2) + P0 * (∑ i, P i) / (2 * Tn') + Lam' * ∑ i, P i ^ 2) := by
    rw [hRo, hfnN, hrn]; field_simp; ring
  rw [h2] at hlo
  rw [h3] at hln
  linarith [hcr', hsplit, hold, hnew, hlo, hln, h1, hid, hfin]

end HamiltonsCubic.OddJ1
