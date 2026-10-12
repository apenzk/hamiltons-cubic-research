import HamiltonsCubic.Results.L94Statement

set_option linter.style.longLine false

/-!
# L95, `κ²(ℂℙᵐ) = 3/(m+1)` at every `m`

[bispectral.md](../../../findings/bispectral.md), Lemma L95: *"`κ²(ℂℙᵐ) = 3/(m+1)` at every `m ≥ 2`."* [r101](../../../reviews/REVIEW_r101.md)
derives the value in the **standard frame**, and its global maximality over `O(2m)` is r615's. The standard frame gives the lower bound, and [r615](../../../reviews/REVIEW_r615.md) §2.2 proves by hand that it is
the maximum: in any frame `F` the sectional matrix is `3A² - 3/(n-1)` with `A = FJFᵀ` orthogonal and skew, and
`ΣA⁴ ≤ ΣA² = n`. Both halves are proved here:

* **`isWeyl_Wcp`**: `W = T - (3/(n-1))G`, with `T_{abcd} = J_{ac}J_{bd} - J_{ad}J_{bc} + 2J_{ab}J_{cd}` the
  Fubini–Study `J`-part and `G_{abcd} = δ_{ac}δ_{bd} - δ_{ad}δ_{bc}`, is a Weyl tensor, `3/(n-1)` being exactly the
  constant that removes the Ricci trace `3δ_{bd}`;
* **`frobK_std`**, **`full4_std`**, **`ratio_std`**: in a `J`-adapted frame `‖K‖_F² = 9n(n-2)/(n-1)`,
  `Σ W² = 6n(n-2)(n+2)/(n-1)` and `‖K‖_F² = (6/(n+2))‖M‖_F²`, r101's three closed forms at `n = 2m`;
* **`rotate_Wcp`**, **`IsCx.conj`**, **`IsCx.sum4_le`**, **`frobK_le`**: a frame carries `Wcp J` to `Wcp (RJRᵀ)` and
  `RJRᵀ` is again a complex structure, whose `ΣA⁴ ≤ n` caps every frame at the adapted value;
* **`stdJ`**, **`kappaSq_CP`**: with the standard complex structure on `ℝ^{2m}`,
  **`κ²(ℂℙᵐ) = 3/(m+1) · ‖M‖_F²` at every `m ≥ 1`**;
* **`normM2_CP_pos`**, **`CP_not_coordDiag`**: at `m ≥ 2` the norm is positive and `3/(m+1) < 2`, so by L94's
  equality case `ℂℙᵐ` is coordinate-diagonal in no frame.

The equality case of `ΣA⁴ ≤ ΣA²` (the maximisers are exactly the `J`-adapted frames) is r615's and is not typed.
-/

namespace HamiltonsCubic.L95

open HamiltonsCubic.L94Statement Finset

variable {n : ℕ}

/-- The Kronecker delta. -/
def del (a b : Fin n) : ℝ := if a = b then 1 else 0

theorem del_comm (a b : Fin n) : del a b = del b a := by
  unfold del; by_cases h : a = b <;> simp [h, eq_comm]

theorem del_self (a : Fin n) : del a a = 1 := by simp [del]

theorem del_sq (a b : Fin n) : del a b ^ 2 = del a b := by unfold del; split_ifs <;> norm_num

theorem sum_del_left (f : Fin n → ℝ) (a : Fin n) : ∑ b, del a b * f b = f a := by
  simp [del]

theorem sum_del_right (f : Fin n → ℝ) (a : Fin n) : ∑ b, f b * del a b = f a := by
  simp [del]

/-- `G_{abcd} = δ_{ac}δ_{bd} - δ_{ad}δ_{bc}`. -/
def G (a b c d : Fin n) : ℝ := del a c * del b d - del a d * del b c

/-- The `J`-part of the Fubini–Study tensor. -/
def T (J : Fin n → Fin n → ℝ) (a b c d : Fin n) : ℝ := J a c * J b d - J a d * J b c + 2 * J a b * J c d

/-- **The Weyl tensor of `ℂℙᵐ`** in a frame where `J` is the complex structure. -/
noncomputable def Wcp (J : Fin n → Fin n → ℝ) : Tensor4 n := fun a b c d => T J a b c d - 3 / ((n : ℝ) - 1) * G a b c d

/-- A complex structure read in an orthonormal frame: skew, squaring to `-1`. -/
structure IsCx (J : Fin n → Fin n → ℝ) : Prop where
  skew : ∀ a b, J b a = -J a b
  sq : ∀ a d, ∑ c, J a c * J c d = -del a d

variable {J : Fin n → Fin n → ℝ}

theorem IsCx.diag (hJ : IsCx J) (a : Fin n) : J a a = 0 := by linarith [hJ.skew a a]

/-- Rows are orthonormal: `Σ_b J_{ab} J_{db} = δ_{ad}`. -/
theorem IsCx.row (hJ : IsCx J) (a d : Fin n) : ∑ b, J a b * J d b = del a d := by
  have h := hJ.sq a d
  have e : ∀ b, J a b * J d b = -(J a b * J b d) := fun b => by rw [hJ.skew d b]; ring
  simp only [e, sum_neg_distrib, h, neg_neg]

/-- Columns are orthonormal: `Σ_a J_{ab} J_{ad} = δ_{bd}`. -/
theorem IsCx.col (hJ : IsCx J) (b d : Fin n) : ∑ a, J a b * J a d = del b d := by
  have h := hJ.sq b d
  have e : ∀ a, J a b * J a d = -(J b a * J a d) := fun a => by rw [hJ.skew b a]; ring
  simp only [e, sum_neg_distrib, h, neg_neg]

theorem IsCx.sumSq (hJ : IsCx J) : ∑ a, ∑ b, J a b ^ 2 = n := by
  have : ∀ a, ∑ b, J a b ^ 2 = 1 := fun a => by
    rw [← del_self a, ← hJ.row a a]; exact sum_congr rfl fun b _ => by ring
  simp [this]

/-- **`Wcp` is a Weyl tensor**: an algebraic curvature tensor whose Ricci trace `3δ - (3/(n-1))(n-1)δ` vanishes. -/
theorem isWeyl_Wcp (hJ : IsCx J) (hn : 2 ≤ n) : IsWeyl (Wcp J) := by
  have hn1 : ((n : ℝ) - 1) ≠ 0 := by
    have : (2 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  refine ⟨⟨fun a b c d => ?_, fun a b c d => ?_, fun a b c d => ?_, fun a b c d => ?_⟩, fun b d => ?_⟩
  · simp only [Wcp, T, G]; rw [hJ.skew a b]; ring
  · simp only [Wcp, T, G]; rw [hJ.skew c d]; ring
  · simp only [Wcp, T, G]
    rw [hJ.skew a c, hJ.skew b d, hJ.skew b c, hJ.skew a d, del_comm c a, del_comm d b, del_comm c b, del_comm d a]
    ring
  · simp only [Wcp, T, G]
    rw [hJ.skew b c, hJ.skew b d, hJ.skew c d, del_comm c b, del_comm d c, del_comm d b]
    ring
  · have e : ∀ a, Wcp J a b a d = -(J b a * J a d) + 2 * (J a b * J a d) - 3 / ((n : ℝ) - 1) * del b d
        + 3 / ((n : ℝ) - 1) * (del b a * del a d) := fun a => by
      simp only [Wcp, T, G, del_self, hJ.diag, del_comm a d]
      ring
    rw [sum_congr rfl fun a _ => e a]
    simp only [sum_add_distrib, sum_sub_distrib, sum_neg_distrib, ← mul_sum, hJ.sq, hJ.col, sum_const, card_univ, Fintype.card_fin,
      nsmul_eq_mul]
    rw [show ∑ a, del b a * del a d = del b d from sum_del_left (fun a => del a d) b]
    field_simp
    ring

/-! ## The standard-frame value -/

theorem rotate_id (W : Tensor4 n) : rotate (fun a i => if a = i then (1 : ℝ) else 0) W = W := by
  funext a b c d; simp [rotate]

/-- **`‖K‖_F² = 9n(n-2)/(n-1)` in the frame**, when `J`'s entries there are `0` or `±1` (`Σ J⁴ = Σ J² = n`). -/
theorem frobK_std (hJ : IsCx J) (hn : 2 ≤ n) (h4 : ∀ a b, J a b ^ 4 = J a b ^ 2) :
    frobK (fun a i => if a = i then (1 : ℝ) else 0) (Wcp J) = 9 * n * (n - 2) / (n - 1) := by
  have hn1 : ((n : ℝ) - 1) ≠ 0 := by
    have : (2 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  have e : ∀ a b, (Wcp J a b a b) ^ 2 = 9 * J a b ^ 4 - 6 * (3 / ((n : ℝ) - 1)) * J a b ^ 2
      + (3 / ((n : ℝ) - 1)) ^ 2 - (3 / ((n : ℝ) - 1)) ^ 2 * del a b := by
    intro a b
    by_cases h : a = b
    · subst h; simp [Wcp, T, G, hJ.diag, del_self]
    · have hd : del a b = 0 := by simp [del, h]
      have hd' : del b a = 0 := by rw [del_comm]; exact hd
      simp only [Wcp, T, G, del_self, hd, hd', hJ.diag]
      rw [hJ.skew a b]; ring
  unfold frobK
  rw [rotate_id]
  simp only [e, h4, sum_add_distrib, sum_sub_distrib, ← mul_sum, sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul]
  rw [hJ.sumSq, show ∑ a : Fin n, ∑ b, del a b = n by simp [del]]
  field_simp; ring

/-- `Σ_{c,d} X_{cd} G_{abcd} = X_{ab} - X_{ba}`. -/
theorem sum_G (X : Fin n → Fin n → ℝ) (a b : Fin n) : ∑ c, ∑ d, X c d * G a b c d = X a b - X b a := by
  simp [G, del, mul_sub, sum_sub_distrib, mul_ite]

/-- `Σ_{a,b,c,d} f(a,c) g(b,d)` factorises. -/
theorem sum_split13 (f g : Fin n → Fin n → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, f a c * g b d = (∑ a, ∑ c, f a c) * (∑ b, ∑ d, g b d) := by
  rw [sum_mul]
  refine sum_congr rfl fun a _ => ?_
  rw [sum_comm, sum_mul]
  refine sum_congr rfl fun c _ => ?_
  rw [mul_sum]
  refine sum_congr rfl fun b _ => ?_
  rw [mul_sum]

/-- The six monomial sums of `T²`. -/
theorem mono_sums (hJ : IsCx J) :
    (∑ a, ∑ b, ∑ c, ∑ d, (J a c * J b d) ^ 2) = (n : ℝ) ^ 2 ∧
    (∑ a, ∑ b, ∑ c, ∑ d, (J a d * J b c) ^ 2) = (n : ℝ) ^ 2 ∧
    (∑ a, ∑ b, ∑ c, ∑ d, (J a b * J c d) ^ 2) = (n : ℝ) ^ 2 ∧
    (∑ a, ∑ b, ∑ c, ∑ d, J a c * J b d * (J a d * J b c)) = n ∧
    (∑ a, ∑ b, ∑ c, ∑ d, J a c * J b d * (J a b * J c d)) = n ∧
    (∑ a, ∑ b, ∑ c, ∑ d, J a d * J b c * (J a b * J c d)) = -n := by
  have hS := hJ.sumSq
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · have := sum_split13 (fun a c => J a c ^ 2) (fun b d => J b d ^ 2)
    simp only [mul_pow]; rw [this, hS]; ring
  · have e : ∀ a b, ∑ c, ∑ d, (J a d * J b c) ^ 2 = ∑ c, ∑ d, J a c ^ 2 * J b d ^ 2 := fun a b => by
      rw [sum_comm]; exact sum_congr rfl fun c _ => sum_congr rfl fun d _ => by ring
    simp only [e]
    rw [sum_split13 (fun a c => J a c ^ 2) (fun b d => J b d ^ 2), hS]; ring
  · have e : ∀ a b, ∑ c, ∑ d, (J a b * J c d) ^ 2 = J a b ^ 2 * n := fun a b => by
      rw [← hS, mul_sum]; exact sum_congr rfl fun c _ => by rw [mul_sum]; exact sum_congr rfl fun d _ => by ring
    simp only [e, ← sum_mul, hS]; ring
  · have e : ∀ a b, ∑ c, ∑ d, J a c * J b d * (J a d * J b c) = del a b ^ 2 := fun a b => by
      rw [sq, ← hJ.row a b, sum_mul_sum]
      exact sum_congr rfl fun c _ => sum_congr rfl fun d _ => by ring
    simp only [e, del_sq]; simp [del]
  · have e : ∀ a b c, ∑ d, J a c * J b d * (J a b * J c d) = J a c * J a b * del b c := fun a b c => by
      rw [← hJ.row b c, mul_sum]; exact sum_congr rfl fun d _ => by ring
    simp only [e]
    have e2 : ∀ a b, ∑ c, J a c * J a b * del b c = J a b ^ 2 := fun a b => by
      rw [show (∑ c, J a c * J a b * del b c) = ∑ c, del b c * (J a c * J a b) from
        sum_congr rfl fun c _ => by ring, sum_del_left]; ring
    simp only [e2, hS]
  · have e : ∀ a b, ∑ c, ∑ d, J a d * J b c * (J a b * J c d) = -(J a b ^ 2) := fun a b => by
      rw [sum_comm]
      have : ∀ d, ∑ c, J a d * J b c * (J a b * J c d) = J a d * J a b * (-del b d) := fun d => by
        rw [← hJ.sq b d, mul_sum]; exact sum_congr rfl fun c _ => by ring
      simp only [this]
      rw [show (∑ d, J a d * J a b * -del b d) = -∑ d, del b d * (J a d * J a b) by
        rw [← sum_neg_distrib]; exact sum_congr rfl fun d _ => by ring, sum_del_left]; ring
    simp only [e, sum_neg_distrib, hS]

/-- **`Σ W² = 6n(n+1) - 18n/(n-1)`**, the full four-index norm, `= 6n(n-2)(n+2)/(n-1)`. -/
theorem full4_std (hJ : IsCx J) (hn : 2 ≤ n) :
    full4 (Wcp J) = 6 * n * (n + 1) - 18 * n / (n - 1) := by
  have hn1 : ((n : ℝ) - 1) ≠ 0 := by
    have : (2 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  obtain ⟨m1, m2, m3, m4, m5, m6⟩ := mono_sums hJ
  have pT : ∀ a b c d, T J a b c d ^ 2 = (J a c * J b d) ^ 2 + (J a d * J b c) ^ 2 + 4 * (J a b * J c d) ^ 2
      - 2 * (J a c * J b d * (J a d * J b c)) + 4 * (J a c * J b d * (J a b * J c d))
      - 4 * (J a d * J b c * (J a b * J c d)) := fun a b c d => by unfold T; ring
  have hT2 : (∑ a, ∑ b, ∑ c, ∑ d, T J a b c d ^ 2) = 6 * (n : ℝ) ^ 2 + 6 * n := by
    simp only [pT, sum_add_distrib, sum_sub_distrib, ← mul_sum]
    rw [m1, m2, m3, m4, m5, m6]; ring
  have hTG : (∑ a, ∑ b, ∑ c, ∑ d, T J a b c d * G a b c d) = 6 * n := by
    have e : ∀ a b, ∑ c, ∑ d, T J a b c d * G a b c d = 6 * J a b ^ 2 := fun a b => by
      rw [sum_G (fun c d => T J a b c d) a b]
      simp only [T, hJ.diag]; rw [hJ.skew a b]; ring
    simp only [e, ← mul_sum, hJ.sumSq]
  have hG2 : (∑ a : Fin n, ∑ b, ∑ c, ∑ d, G a b c d * G a b c d) = 2 * (n : ℝ) ^ 2 - 2 * n := by
    have e : ∀ a b : Fin n, ∑ c, ∑ d, G a b c d * G a b c d = 2 - 2 * del a b := fun a b => by
      rw [sum_G (fun c d => G a b c d) a b]
      simp only [G, del_self, del_comm b a]
      have := del_sq a b
      nlinarith
    simp only [e, sum_sub_distrib, sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul, ← mul_sum]
    rw [show ∑ a : Fin n, ∑ b, del a b = n by simp [del]]; ring
  have pW : ∀ a b c d, Wcp J a b c d ^ 2 = T J a b c d ^ 2 - 2 * (3 / ((n : ℝ) - 1)) * (T J a b c d * G a b c d)
      + (3 / ((n : ℝ) - 1)) ^ 2 * (G a b c d * G a b c d) := fun a b c d => by unfold Wcp; ring
  unfold full4
  simp only [pW, sum_add_distrib, sum_sub_distrib, ← mul_sum]
  rw [hT2, hTG, hG2]
  field_simp; ring

/-- **`‖K‖_F² = (6/(n+2))‖M‖_F²` in the frame**, which is `3/(m+1)` at `n = 2m`. -/
theorem ratio_std (hJ : IsCx J) (hn : 2 ≤ n) (h4 : ∀ a b, J a b ^ 4 = J a b ^ 2) :
    frobK (fun a i => if a = i then (1 : ℝ) else 0) (Wcp J) = 6 / ((n : ℝ) + 2) * normM2 (Wcp J) := by
  have hW := isWeyl_Wcp hJ hn
  have hq := normM2_quarter (Wcp J) hW.antisym12 hW.antisym34
  rw [full4_std hJ hn] at hq
  rw [frobK_std hJ hn h4]
  have hn1 : ((n : ℝ) - 1) ≠ 0 := by
    have : (2 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  have hn2 : ((n : ℝ) + 2) ≠ 0 := by positivity
  have hM : normM2 (Wcp J) = (6 * n * (n + 1) - 18 * n / (n - 1)) / 4 := by linarith
  rw [hM]; field_simp; ring

/-- **`κ²(ℂℙᵐ) ≥ 3/(m+1) · ‖M‖_F²`**: at `n = 2m` the standard frame alone gives `6/(2m+2) = 3/(m+1)`. -/
theorem kappaSq_ge (m : ℕ) (hm : 1 ≤ m) {J : Fin (2 * m) → Fin (2 * m) → ℝ} (hJ : IsCx J)
    (h4 : ∀ a b, J a b ^ 4 = J a b ^ 2) :
    3 / ((m : ℝ) + 1) * normM2 (Wcp J) ≤ kappaSq (Wcp J) := by
  have hn : 2 ≤ 2 * m := by omega
  have hW := isWeyl_Wcp hJ hn
  have hbdd : BddAbove {c : ℝ | ∃ R : Fin (2 * m) → Fin (2 * m) → ℝ, IsFrame R ∧ c = frobK R (Wcp J)} :=
    ⟨2 * normM2 (Wcp J), by rintro c ⟨R, hR, rfl⟩; exact frame_bound R hR _ hW.toIsAlgCurv⟩
  have hle := le_csSup hbdd ⟨_, isFrame_id, rfl⟩
  have hr := ratio_std hJ hn h4
  have e : (6 : ℝ) / (((2 * m : ℕ) : ℝ) + 2) = 3 / ((m : ℝ) + 1) := by
    push_cast; field_simp; ring
  rw [e] at hr
  unfold kappaSq
  rw [← hr]; exact hle

/-! ## The standard complex structure on `ℝ^{2m}` -/

/-- The partner index, `2k ↔ 2k+1`. -/
def partner {m : ℕ} (a : Fin (2 * m)) : Fin (2 * m) :=
  ⟨if a.val % 2 = 0 then a.val + 1 else a.val - 1, by split_ifs <;> omega⟩

theorem partner_partner {m : ℕ} (a : Fin (2 * m)) : partner (partner a) = a := by
  ext; simp only [partner]; split_ifs <;> omega

theorem partner_ne {m : ℕ} (a : Fin (2 * m)) : partner a ≠ a := by
  intro h; have := congrArg Fin.val h; simp only [partner] at this; split_ifs at this <;> omega

theorem partner_parity {m : ℕ} (a : Fin (2 * m)) : ((partner a).val % 2 = 0) ↔ ¬ (a.val % 2 = 0) := by
  simp only [partner]; split_ifs <;> omega

/-- **The standard complex structure**: `J e_{2k} = -e_{2k+1}` on each coordinate plane. -/
def stdJ (m : ℕ) (a b : Fin (2 * m)) : ℝ := if b = partner a then (if a.val % 2 = 0 then 1 else -1) else 0

theorem stdJ_isCx (m : ℕ) : IsCx (stdJ m) := by
  constructor
  · intro a b
    unfold stdJ
    by_cases h : a = partner b
    · have h' : b = partner a := by rw [h, partner_partner]
      rw [if_pos h, if_pos h']
      have hp := partner_parity b
      rw [← h] at hp
      split_ifs with h1 h2 <;> first | (exfalso; tauto) | norm_num
    · have h' : ¬ b = partner a := fun h' => h (by rw [h', partner_partner])
      rw [if_neg h, if_neg h']; ring
  · intro a d
    rw [Finset.sum_eq_single (partner a)]
    · unfold stdJ del
      rw [if_pos rfl, partner_partner]
      have hp := partner_parity a
      by_cases had : d = a
      · subst had; rw [if_pos rfl, if_pos rfl]
        split_ifs with h1 h2 <;> first | (exfalso; tauto) | norm_num
      · rw [if_neg had, if_neg (Ne.symm had)]; ring
    · intro c _ hc; unfold stdJ; rw [if_neg hc, zero_mul]
    · intro h; exact absurd (Finset.mem_univ _) h

theorem stdJ_four (m : ℕ) (a b : Fin (2 * m)) : stdJ m a b ^ 4 = stdJ m a b ^ 2 := by
  unfold stdJ; split_ifs <;> norm_num

/-- **`κ²(ℂℙᵐ) ≥ 3/(m+1) · ‖M‖_F²` at every `m ≥ 1`**, with the standard complex structure. -/
theorem kappaSq_CP_ge (m : ℕ) (hm : 1 ≤ m) :
    3 / ((m : ℝ) + 1) * normM2 (Wcp (stdJ m)) ≤ kappaSq (Wcp (stdJ m)) :=
  kappaSq_ge m hm (stdJ_isCx m) (stdJ_four m)

/-! ## The maximum over frames, after r615 -/

/-- `J` read in the frame `R`: `(RJRᵀ)_{ab} = Σ_{i,j} R_{ai} R_{bj} J_{ij}`. -/
def conjJ (R J : Fin n → Fin n → ℝ) (a b : Fin n) : ℝ := ∑ i, ∑ j, R a i * R b j * J i j

/-- A four-fold sum of a product of a function of `(i,k)` and one of `(j,l)` factorises. -/
theorem sum4_ik_jl (f g : Fin n → Fin n → ℝ) :
    ∑ i, ∑ j, ∑ k, ∑ l, f i k * g j l = (∑ i, ∑ k, f i k) * (∑ j, ∑ l, g j l) := sum_split13 f g

theorem sum4_il_jk (f g : Fin n → Fin n → ℝ) :
    ∑ i, ∑ j, ∑ k, ∑ l, f i l * g j k = (∑ i, ∑ l, f i l) * (∑ j, ∑ k, g j k) := by
  rw [← sum_split13 f g]
  exact sum_congr rfl fun i _ => sum_congr rfl fun j _ => sum_comm

theorem sum4_ij_kl (f g : Fin n → Fin n → ℝ) :
    ∑ i, ∑ j, ∑ k, ∑ l, f i j * g k l = (∑ i, ∑ j, f i j) * (∑ k, ∑ l, g k l) := by
  rw [sum_mul]; refine sum_congr rfl fun i _ => ?_
  rw [sum_mul]; refine sum_congr rfl fun j _ => ?_
  rw [mul_sum]; refine sum_congr rfl fun k _ => ?_
  rw [mul_sum]

/-- Linearity of a four-fold sum. -/
theorem sum4_lin (u v w : Fin n → Fin n → Fin n → Fin n → ℝ) :
    ∑ i, ∑ j, ∑ k, ∑ l, (u i j k l - v i j k l + 2 * w i j k l)
      = (∑ i, ∑ j, ∑ k, ∑ l, u i j k l) - (∑ i, ∑ j, ∑ k, ∑ l, v i j k l) + 2 * ∑ i, ∑ j, ∑ k, ∑ l, w i j k l := by
  simp only [sum_add_distrib, sum_sub_distrib, mul_sum]

/-- **The rotated `T` is `T` of the rotated `J`.** -/
theorem rotate_T (R : Fin n → Fin n → ℝ) (a b c d : Fin n) :
    (∑ i, ∑ j, ∑ k, ∑ l, R a i * R b j * R c k * R d l * T J i j k l) = T (conjJ R J) a b c d := by
  have e : ∀ i j k l, R a i * R b j * R c k * R d l * T J i j k l
      = (R a i * R c k * J i k) * (R b j * R d l * J j l) - (R a i * R d l * J i l) * (R b j * R c k * J j k)
        + 2 * ((R a i * R b j * J i j) * (R c k * R d l * J k l)) := fun i j k l => by unfold T; ring
  rw [sum_congr rfl fun i _ => sum_congr rfl fun j _ => sum_congr rfl fun k _ => sum_congr rfl fun l _ => e i j k l]
  rw [sum4_lin (fun i j k l => (R a i * R c k * J i k) * (R b j * R d l * J j l))
    (fun i j k l => (R a i * R d l * J i l) * (R b j * R c k * J j k))
    (fun i j k l => (R a i * R b j * J i j) * (R c k * R d l * J k l))]
  rw [sum4_ik_jl (fun i k => R a i * R c k * J i k) (fun j l => R b j * R d l * J j l),
    sum4_il_jk (fun i l => R a i * R d l * J i l) (fun j k => R b j * R c k * J j k),
    sum4_ij_kl (fun i j => R a i * R b j * J i j) (fun k l => R c k * R d l * J k l)]
  unfold T conjJ; ring

/-- **`G` is frame-invariant.** -/
theorem rotate_G (R : Fin n → Fin n → ℝ) (hR : IsFrame R) (a b c d : Fin n) :
    (∑ i, ∑ j, ∑ k, ∑ l, R a i * R b j * R c k * R d l * G i j k l) = G a b c d := by
  have hd : ∀ x y : Fin n, ∑ i, ∑ k, R x i * R y k * del i k = del x y := fun x y => by
    have h : ∀ i, ∑ k, R x i * R y k * del i k = R x i * R y i := fun i => by
      rw [show (∑ k, R x i * R y k * del i k) = ∑ k, del i k * (R x i * R y k) from
        sum_congr rfl fun k _ => by ring, sum_del_left]
    simp only [h]; exact hR x y
  have e : ∀ i j k l, R a i * R b j * R c k * R d l * G i j k l
      = (R a i * R c k * del i k) * (R b j * R d l * del j l) - (R a i * R d l * del i l) * (R b j * R c k * del j k)
        + 2 * 0 := fun i j k l => by unfold G; ring
  rw [sum_congr rfl fun i _ => sum_congr rfl fun j _ => sum_congr rfl fun k _ => sum_congr rfl fun l _ => e i j k l]
  rw [sum4_lin (fun i j k l => (R a i * R c k * del i k) * (R b j * R d l * del j l))
    (fun i j k l => (R a i * R d l * del i l) * (R b j * R c k * del j k)) (fun _ _ _ _ => 0)]
  rw [sum4_ik_jl (fun i k => R a i * R c k * del i k) (fun j l => R b j * R d l * del j l),
    sum4_il_jk (fun i l => R a i * R d l * del i l) (fun j k => R b j * R c k * del j k), hd, hd, hd, hd]
  simp [G]

/-- **The rotated `Wcp J` is `Wcp` of the rotated `J`.** -/
theorem rotate_Wcp (R : Fin n → Fin n → ℝ) (hR : IsFrame R) : rotate R (Wcp J) = Wcp (conjJ R J) := by
  funext a b c d
  unfold rotate Wcp
  have e : ∀ i j k l, R a i * R b j * R c k * R d l * (T J i j k l - 3 / ((n : ℝ) - 1) * G i j k l)
      = R a i * R b j * R c k * R d l * T J i j k l - 3 / ((n : ℝ) - 1) * (R a i * R b j * R c k * R d l * G i j k l) :=
    fun i j k l => by ring
  simp only [e, sum_sub_distrib, ← mul_sum]
  rw [rotate_T, rotate_G R hR]

/-- **A frame carries a complex structure to a complex structure.** -/
theorem IsCx.conj (hJ : IsCx J) (R : Fin n → Fin n → ℝ) (hR : IsFrame R) : IsCx (conjJ R J) := by
  have hcol := cols_of_rows R hR
  constructor
  · intro a b
    unfold conjJ
    rw [sum_comm, ← sum_neg_distrib]
    exact sum_congr rfl fun i _ => by
      rw [← sum_neg_distrib]; exact sum_congr rfl fun j _ => by rw [hJ.skew i j]; ring
  · intro a d
    -- `Σ_c (RJRᵀ)_{ac}(RJRᵀ)_{cd} = (R J (RᵀR) J Rᵀ)_{ad} = -(RRᵀ)_{ad}`
    have hJJ : ∀ i l, ∑ j, J i j * J j l = -del i l := hJ.sq
    unfold conjJ
    have step1 : ∀ c, (∑ i, ∑ j, R a i * R c j * J i j) * (∑ k, ∑ l, R c k * R d l * J k l)
        = ∑ i, ∑ j, ∑ k, ∑ l, R a i * J i j * (R c j * R c k) * (J k l * R d l) := fun c => by
      rw [sum_mul]; refine sum_congr rfl fun i _ => ?_
      rw [sum_mul]; refine sum_congr rfl fun j _ => ?_
      rw [mul_sum]; refine sum_congr rfl fun k _ => ?_
      rw [mul_sum]; exact sum_congr rfl fun l _ => by ring
    simp only [step1]
    -- move `c` innermost and contract it
    have step2 : (∑ c, ∑ i, ∑ j, ∑ k, ∑ l, R a i * J i j * (R c j * R c k) * (J k l * R d l))
        = ∑ i, ∑ j, ∑ k, ∑ l, R a i * J i j * del j k * (J k l * R d l) := by
      rw [sum_comm]; refine sum_congr rfl fun i _ => ?_
      rw [sum_comm]; refine sum_congr rfl fun j _ => ?_
      rw [sum_comm]; refine sum_congr rfl fun k _ => ?_
      rw [sum_comm]; refine sum_congr rfl fun l _ => ?_
      rw [← sum_mul, ← mul_sum, hcol j k]; rfl
    rw [step2]
    have step3 : ∀ i j, ∑ k, ∑ l, R a i * J i j * del j k * (J k l * R d l) = ∑ l, R a i * (J i j * J j l) * R d l :=
      fun i j => by
        rw [sum_comm]; refine sum_congr rfl fun l _ => ?_
        rw [show (∑ k, R a i * J i j * del j k * (J k l * R d l)) = ∑ k, del j k * (R a i * J i j * (J k l * R d l)) from
          sum_congr rfl fun k _ => by ring, sum_del_left]; ring
    simp only [step3]
    have step4 : ∀ i, ∑ j, ∑ l, R a i * (J i j * J j l) * R d l = -(R a i * R d i) := fun i => by
      rw [sum_comm]
      have : ∀ l, ∑ j, R a i * (J i j * J j l) * R d l = R a i * R d l * (-del i l) := fun l => by
        rw [← hJJ i l, mul_sum]; exact sum_congr rfl fun j _ => by ring
      simp only [this]
      rw [show (∑ l, R a i * R d l * -del i l) = -∑ l, del i l * (R a i * R d l) by
        rw [← sum_neg_distrib]; exact sum_congr rfl fun l _ => by ring, sum_del_left]
    simp only [step4, sum_neg_distrib]
    rw [hR a d]; rfl

/-- **`Σ A⁴ ≤ Σ A² = n` for a complex structure**, each row being a unit vector. -/
theorem IsCx.sum4_le (hJ : IsCx J) : ∑ a, ∑ b, J a b ^ 4 ≤ n := by
  rw [← hJ.sumSq]
  refine sum_le_sum fun a _ => sum_le_sum fun b _ => ?_
  have hrow : ∑ b', J a b' ^ 2 = 1 := by
    rw [← del_self a, ← hJ.row a a]; exact sum_congr rfl fun b' _ => by ring
  have h1 : J a b ^ 2 ≤ 1 := by
    rw [← hrow]; exact single_le_sum (f := fun b' => J a b' ^ 2) (fun _ _ => sq_nonneg _) (mem_univ b)
  have h0 : 0 ≤ J a b ^ 2 := sq_nonneg _
  nlinarith

/-- `‖K‖_F²` in the identity frame for any complex structure, `9ΣJ⁴ - 6cn + c²n(n-1)`. -/
theorem frobK_gen (hJ : IsCx J) :
    frobK (fun a i => if a = i then (1 : ℝ) else 0) (Wcp J)
      = 9 * (∑ a, ∑ b, J a b ^ 4) - 6 * (3 / ((n : ℝ) - 1)) * n + (3 / ((n : ℝ) - 1)) ^ 2 * ((n : ℝ) ^ 2 - n) := by
  have e : ∀ a b, (Wcp J a b a b) ^ 2 = 9 * J a b ^ 4 - 6 * (3 / ((n : ℝ) - 1)) * J a b ^ 2
      + (3 / ((n : ℝ) - 1)) ^ 2 - (3 / ((n : ℝ) - 1)) ^ 2 * del a b := by
    intro a b
    by_cases h : a = b
    · subst h; simp [Wcp, T, G, hJ.diag, del_self]
    · have hd : del a b = 0 := by simp [del, h]
      have hd' : del b a = 0 := by rw [del_comm]; exact hd
      simp only [Wcp, T, G, del_self, hd, hd', hJ.diag]
      rw [hJ.skew a b]; ring
  unfold frobK
  rw [rotate_id]
  simp only [e, sum_add_distrib, sum_sub_distrib, ← mul_sum, sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul]
  rw [hJ.sumSq, show ∑ a : Fin n, ∑ b, del a b = n by simp [del]]
  ring

/-- **Every frame gives at most the standard-frame value** `9n(n-2)/(n-1)`. -/
theorem frobK_le (hJ : IsCx J) (hn : 2 ≤ n) (R : Fin n → Fin n → ℝ) (hR : IsFrame R) :
    frobK R (Wcp J) ≤ 9 * n * (n - 2) / (n - 1) := by
  have hn1 : ((n : ℝ) - 1) ≠ 0 := by
    have : (2 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  have hJ' := hJ.conj R hR
  have hf : frobK R (Wcp J) = frobK (fun a i => if a = i then (1 : ℝ) else 0) (Wcp (conjJ R J)) := by
    unfold frobK; rw [rotate_Wcp R hR, rotate_id]
  rw [hf, frobK_gen hJ']
  have h4 := hJ'.sum4_le
  have : 9 * (n : ℝ) * (n - 2) / (n - 1)
      = 9 * n - 6 * (3 / ((n : ℝ) - 1)) * n + (3 / ((n : ℝ) - 1)) ^ 2 * ((n : ℝ) ^ 2 - n) := by
    field_simp; ring
  rw [this]; linarith

/-- **`κ²(ℂℙᵐ) = 3/(m+1) · ‖M‖_F²` at every `m ≥ 1`**: the standard frame attains the maximum over all frames. -/
theorem kappaSq_CP (m : ℕ) (hm : 1 ≤ m) :
    kappaSq (Wcp (stdJ m)) = 3 / ((m : ℝ) + 1) * normM2 (Wcp (stdJ m)) := by
  have hn : 2 ≤ 2 * m := by omega
  refine le_antisymm ?_ (kappaSq_CP_ge m hm)
  have hstd := ratio_std (stdJ_isCx m) hn (stdJ_four m)
  have e : (6 : ℝ) / (((2 * m : ℕ) : ℝ) + 2) = 3 / ((m : ℝ) + 1) := by
    push_cast; field_simp; ring
  rw [e, frobK_std (stdJ_isCx m) hn (stdJ_four m)] at hstd
  rw [← hstd]
  exact kappaSq_le_of_forall _ fun R hR => frobK_le (stdJ_isCx m) hn R hR

/-- **`‖M‖_F² > 0` for `ℂℙᵐ` at `m ≥ 2`**: it is `(3/2)n(n-2)(n+2)/(n-1)` with `n = 2m`. -/
theorem normM2_CP_pos (m : ℕ) (hm : 2 ≤ m) : 0 < normM2 (Wcp (stdJ m)) := by
  have hn : 2 ≤ 2 * m := by omega
  have hW := isWeyl_Wcp (stdJ_isCx m) hn
  have hq := normM2_quarter (Wcp (stdJ m)) hW.antisym12 hW.antisym34
  rw [full4_std (stdJ_isCx m) hn] at hq
  have h4 : (4 : ℝ) ≤ ((2 * m : ℕ) : ℝ) := by exact_mod_cast (by omega : 4 ≤ 2 * m)
  have hval : 6 * ((2 * m : ℕ) : ℝ) * (((2 * m : ℕ) : ℝ) + 1) - 18 * ((2 * m : ℕ) : ℝ) / (((2 * m : ℕ) : ℝ) - 1)
      = 6 * ((2 * m : ℕ) : ℝ) * (((2 * m : ℕ) : ℝ) - 2) * (((2 * m : ℕ) : ℝ) + 2) / (((2 * m : ℕ) : ℝ) - 1) := by
    have : (((2 * m : ℕ) : ℝ) - 1) ≠ 0 := by linarith
    field_simp; ring
  rw [hval] at hq
  have : 0 < 6 * ((2 * m : ℕ) : ℝ) * (((2 * m : ℕ) : ℝ) - 2) * (((2 * m : ℕ) : ℝ) + 2) / (((2 * m : ℕ) : ℝ) - 1) := by
    apply div_pos _ (by linarith)
    have : 0 < ((2 * m : ℕ) : ℝ) - 2 := by linarith
    positivity
  linarith

/-- **`ℂℙᵐ` is coordinate-diagonal in no frame, at every `m ≥ 2`**: `κ² = 3/(m+1)‖M‖² < 2‖M‖²`, and
[L94Statement](L94Statement.lean)'s `kappaSq_eq_iff` makes `κ² = 2‖M‖²` the coordinate-diagonal case. -/
theorem CP_not_coordDiag (m : ℕ) (hm : 2 ≤ m) :
    ¬ ∃ R : Fin (2 * m) → Fin (2 * m) → ℝ, IsFrame R ∧ CoordinateDiagonal (rotate R (Wcp (stdJ m))) := by
  have hn : 2 ≤ 2 * m := by omega
  rw [← kappaSq_eq_iff _ (isWeyl_Wcp (stdJ_isCx m) hn), kappaSq_CP m (by omega)]
  have hpos := normM2_CP_pos m hm
  have hlt : 3 / ((m : ℝ) + 1) < 2 := by
    have : (2 : ℝ) ≤ m := by exact_mod_cast hm
    rw [div_lt_iff₀ (by positivity)]; linarith
  intro h
  have : (3 / ((m : ℝ) + 1) - 2) * normM2 (Wcp (stdJ m)) = 0 := by rw [sub_mul, h]; ring
  rcases mul_eq_zero.mp this with h1 | h1
  · linarith
  · linarith

end HamiltonsCubic.L95
