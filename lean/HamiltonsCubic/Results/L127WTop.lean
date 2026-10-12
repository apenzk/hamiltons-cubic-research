import HamiltonsCubic.Results.L127Dim

set_option linter.style.longLine false

/-!
# L127's within-factor top is simple

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, within-factor row: the top
`(p − 2)/(2(p − 1))` in `L_e` units, which is `λ = ½(α + t)(p − 2)` for `M ∘` at a sphere product. [L127Within.lean](L127Within.lean)'s
`within_top_exists` shows it occurs, and this file shows its eigenspace on the Ricci cut is one line, at `j, k ∈ T`,
`p ≥ 3`, `t > 0`, `α = tq/(p − 1)`, `β = tp/(q − 1)`:

* **`within_top_identity`**: `2λ + 2t + α + β = (t + β) q`, which is what makes the second factor's coefficient
  equation consistent with the first's;
* **`within_top_mem`**: a coefficient vector vanishing off the pair index set, on the Ricci cut and in the
  `λ`-eigenspace is exactly a multiple of `withinTopVec`, `q` on the first factor's part and `−(p − 2)` on `Tᶜ`;
* **`within_top_finrank`**: that line has dimension `1`.

With [L127Dim.lean](L127Dim.lean)'s counts the three within-block dimensions `(p − 3) + (q − 1) + 1` sum to `n − 3`,
the dimension of the Ricci cut, and [L127Fill.lean](L127Fill.lean)'s `within_fill` declares that the three spaces
together fill the cut.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The consistency identity**: `2λ + 2t + α + β = (t + β) q`, `λ = ½(α + t)(p − 2)`. -/
theorem within_top_identity (P Q t : ℝ) (hP : P - 1 ≠ 0) (hQ : Q - 1 ≠ 0) :
    2 * ((1 / 2 : ℝ) * (t * (Q / (P - 1)) + t) * (P - 2)) + 2 * t + t * (Q / (P - 1)) + t * (P / (Q - 1))
      = (t + t * (P / (Q - 1))) * Q := by
  field_simp
  ring

/-- The within top's coefficients at `j, k ∈ T`: `q` on the first factor's part of the pair index set, `−(p − 2)` on
`Tᶜ`, zero at `j` and `k`. -/
noncomputable def withinTopVec (T : Finset ι) (j k : ι) : ι → ℝ := fun i =>
  if i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i) then (if i ∈ T then (Tᶜ.card : ℝ) else -((T.card : ℝ) - 2)) else 0

/-- **The within top's coefficients** (`j, k ∈ T`, `p ≥ 3`): vanishing off the pair index set, on the Ricci cut, and in
the `½(α + t)(p − 2)`-eigenspace, exactly the multiples of `withinTopVec`. -/
theorem within_top_mem (T : Finset ι) (hp : 3 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) (c : ι → ℝ) :
    ((∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
      ∧ ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0
      ∧ ∀ X : Matrix ι ι ℝ, IsSkew X →
        foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
          c i • rk2 (phi j i) (phi k i) Y) X
          = ((1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t) * ((T.card : ℝ) - 2))
            • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X)
      ↔ c ∈ Submodule.span ℝ {withinTopVec T j k} := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  set P : ℝ := (T.card : ℝ) with hP
  set Q : ℝ := (Tᶜ.card : ℝ) with hQ
  have hpR : (3 : ℝ) ≤ P := by rw [hP]; exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ Q := by rw [hQ]; exact_mod_cast hq
  have hP1 : P - 1 ≠ 0 := by linarith
  have hQ1 : Q - 1 ≠ 0 := by linarith
  have hP2 : P - 2 ≠ 0 := by linarith
  have hQ0 : Q ≠ 0 := by linarith
  set α := t * (Q / (P - 1)) with hα
  set β := t * (P / (Q - 1)) with hβ
  have hαpos : 0 < α := mul_pos ht (div_pos (by linarith) (by linarith))
  have hβpos : 0 < β := mul_pos ht (div_pos (by linarith) (by linarith))
  have hid := within_top_identity P Q t hP1 hQ1
  rw [← hα, ← hβ] at hid
  set lam := (1 / 2 : ℝ) * (α + t) * (P - 2) with hlam
  -- the part sizes: `|s ∩ T| = p − 2`, `s \ T = Tᶜ`
  have hB := within_B_eq (T := T) hj hk
  rw [← hsdef] at hB
  have cardA : ((s.filter (· ∈ T)).card : ℝ) = P - 2 := by
    have h1 := Finset.card_filter_add_card_filter_not (s := s) (· ∈ T)
    rw [hB] at h1
    have h2 : s.card + 2 = Fintype.card ι := pairIdx_card hjk
    have h3 := Finset.card_compl_add_card T
    have : (s.filter (· ∈ T)).card + 2 = T.card := by omega
    rw [hP, ← this]; push_cast; ring
  have cardB : ((s.filter (· ∉ T)).card : ℝ) = Q := by rw [hB]
  -- the eigen-equation as coefficient equations, on the Ricci cut
  have coeff : ∀ d : ι → ℝ, ∑ i ∈ s, d i = 0 →
      ((∀ X : Matrix ι ι ℝ, IsSkew X →
        foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ s, d i • rk2 (phi j i) (phi k i) Y) X
          = lam • ∑ i ∈ s, d i • rk2 (phi j i) (phi k i) X)
        ↔ ∀ q ∈ s, (if q ∈ T then (1 / 2 : ℝ) * (α + t) * ∑ i ∈ s.filter (· ∈ T), d i
            else (1 / 2 : ℝ) * ((-2 * t - α - β) * d q + (t + β) * ∑ i ∈ s.filter (· ∉ T), d i)) = lam * d q) := by
    intro d hd
    rw [forall_congr' fun X => imp_congr_right fun hX => by rw [withinPair T t hj hk hjk d hd hX], pairSpan_eq_iff hjk]
  have hSA : ∀ a : ℝ, ∑ i ∈ s.filter (· ∈ T), (a • withinTopVec T j k) i = a * Q * (P - 2) := by
    intro a
    rw [Finset.sum_congr rfl (fun i hi => show (a • withinTopVec T j k) i = a * Q by
      simp only [Pi.smul_apply, smul_eq_mul, withinTopVec, ← hsdef, ← hP, ← hQ, if_pos (Finset.mem_filter.mp hi).1,
        if_pos (Finset.mem_filter.mp hi).2]), Finset.sum_const, nsmul_eq_mul, cardA]
    ring
  have hSB : ∀ a : ℝ, ∑ i ∈ s.filter (· ∉ T), (a • withinTopVec T j k) i = -(a * (P - 2) * Q) := by
    intro a
    rw [Finset.sum_congr rfl (fun i hi => show (a • withinTopVec T j k) i = a * -(P - 2) by
      simp only [Pi.smul_apply, smul_eq_mul, withinTopVec, ← hsdef, ← hP, ← hQ, if_pos (Finset.mem_filter.mp hi).1,
        if_neg (Finset.mem_filter.mp hi).2]), Finset.sum_const, nsmul_eq_mul, cardB]
    ring
  rw [Submodule.mem_span_singleton]
  constructor
  · rintro ⟨h0, hsum, h⟩
    have hc := (coeff c hsum).mp h
    have hsplit := sum_split_T T s c
    set CA := ∑ i ∈ s.filter (· ∈ T), c i with hCA
    have hCB : ∑ i ∈ s.filter (· ∉ T), c i = -CA := by linarith
    refine ⟨CA / ((P - 2) * Q), funext fun i => ?_⟩
    simp only [Pi.smul_apply, smul_eq_mul, withinTopVec, ← hsdef, ← hP, ← hQ]
    by_cases his : i ∈ s
    · rw [if_pos his]
      have e := hc i his
      split_ifs at e ⊢ with hiT
      · -- `½(α + t) C_A = λ c_i`
        have hat : (1 / 2 : ℝ) * (α + t) ≠ 0 := by positivity
        have : c i = CA / (P - 2) := by
          field_simp
          have e' : (1 / 2 : ℝ) * (α + t) * (CA - c i * (P - 2)) = 0 := by rw [hlam] at e; linarith
          have := (mul_eq_zero.mp e').resolve_left hat
          linarith
        rw [this]; field_simp
      · rw [hCB] at e
        have htb : t + β ≠ 0 := by positivity
        -- `c_i (2λ + 2t + α + β) = −(t + β) C_A`, and `2λ + 2t + α + β = (t + β) q`
        have e' : c i * ((t + β) * Q) = -((t + β) * CA) := by
          rw [← hid]; linear_combination (-2 : ℝ) * e
        have : c i = -CA / Q := by
          field_simp
          have := mul_left_cancel₀ htb (show (t + β) * (c i * Q) = (t + β) * (-CA) by linear_combination e')
          linarith
        rw [this]; field_simp
    · rw [if_neg his, h0 i his, mul_zero]
  · rintro ⟨a, rfl⟩
    have hsplit := sum_split_T T s (a • withinTopVec T j k)
    have hsum : ∑ i ∈ s, (a • withinTopVec T j k) i = 0 := by rw [hsplit, hSA, hSB]; ring
    refine ⟨fun i hi => by simp only [Pi.smul_apply, smul_eq_mul, withinTopVec, ← hsdef, ← hP, ← hQ, if_neg hi, mul_zero], hsum,
      (coeff _ hsum).mpr fun q hq' => ?_⟩
    rw [hSA, hSB]
    simp only [Pi.smul_apply, smul_eq_mul, withinTopVec, ← hsdef, ← hP, ← hQ, if_pos hq']
    split_ifs
    · rw [hlam]; ring
    · rw [hlam]; linear_combination ((a * (P - 2)) / 2) * hid

/-- **The within top is simple**: `withinTopVec` is nonzero at `p ≥ 3`, so its span is one line. -/
theorem within_top_finrank (T : Finset ι) (hp : 3 ≤ T.card) (hq : 2 ≤ Tᶜ.card) {j k : ι} (hj : j ∈ T) (hk : k ∈ T) :
    Module.finrank ℝ (Submodule.span ℝ {withinTopVec T j k}) = 1 := by
  apply finrank_span_singleton
  obtain ⟨q, hqT⟩ : ∃ q, q ∈ Tᶜ := Finset.card_pos.mp (by omega)
  have hqT' := Finset.mem_compl.mp hqT
  have hqs : q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i) :=
    Finset.mem_filter.mpr ⟨Finset.mem_univ _, fun e => hqT' (e ▸ hj), fun e => hqT' (e ▸ hk)⟩
  intro h
  have e := congrFun h q
  simp only [withinTopVec, if_pos hqs, if_neg hqT', Pi.zero_apply] at e
  have hpR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  linarith

end HamiltonsCubic.L121Block
