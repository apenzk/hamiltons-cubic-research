import HamiltonsCubic.Results.L127DnExcl
import HamiltonsCubic.Results.L120DiagDim

set_option linter.style.longLine false

/-!
# L127's `𝒟ₙ` families, the dimension of each

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, `𝒟ₙ` row:
`σ(L_e|_{𝒟ₙ}) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^{rest}}`. [L127DnSpan.lean](L127DnSpan.lean)'s
`dn_decomp` writes every weight as one member of each of six families, and this file gives the families' dimensions,
each stated for a general `S` so that `S = T` and `S = Tᶜ` give both factors:

* **`withinSub`**, **`extL`**, **`withinSub_eq_range`**, **`finrank_withinSub`**: the zero family inside `S`
  (`IsWithinW`) is the extension by zero of `S`'s own weights (L120DiagDim's `rowSumL` kernel on the index type `S`), of
  dimension `binom |S| 2 − |S| = |S|(|S| − 3)/2` at `|S| ≥ 3`;
* **`sumL`**, **`lamMap`**, **`lamMap_injective`**, **`finrank_lam`**, **`mem_range_lamMap`**: the `λ` family is the
  `lamW` of the zero-sum functions on `S`, injective at `|S| ≥ 3` (`h_a` is half of `(h_a + h_b) + (h_a + h_c) −
  (h_b + h_c)`), of dimension `|S| − 1`;
* **`rcL`**, **`diffL`**, **`range_rcL`**, **`finrank_ker_rcL`**: the `S × Sᶜ` blocks with zero row and column sums
  have dimension `pq − (p + q − 1)`, the row and column sums reaching exactly the pairs of equal total;
* **`sphereWeight_ne_zero`**, **`finrank_sphereLine`**: the sphere-weight line has dimension `1`;
* **`crossSub`**, **`crossExt`**, **`crossSub_eq_range`**, **`finrank_crossSub`**: the cross family (`IsCrossW`) is
  those blocks placed across `S` and mirrored, of dimension `(p − 1)(q − 1)`.

So the families have dimensions `1`, `p − 1`, `q − 1`, `(p − 1)(q − 1)`, `p(p − 3)/2` and `q(q − 3)/2`, the counts the
record's row carries. [L127DnDirect.lean](L127DnDirect.lean)'s `dn_direct2` makes their sum direct at `p, q ≥ 2`. [L127DnEig.lean](L127DnEig.lean) and [L127DnLam.lean](L127DnLam.lean) turn
these into eigenspace dimensions at `t ≠ 0`, added where values coincide (`λ_p = λ_q` at `p = q` and the two zeros).
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The zero family inside `S`, as a subspace. -/
def withinSub (S : Finset ι) : Submodule ℝ (Matrix ι ι ℝ) where
  carrier := {Z | IsWithinW S Z}
  add_mem' {Z Z'} h h' := ⟨fun a b => by simp [h.1 a b, h'.1 a b], fun a => by simp [h.2.1 a, h'.2.1 a],
    fun a b hab => by simp [h.2.2.1 a b hab, h'.2.2.1 a b hab],
    fun a ha => by simp [Finset.sum_add_distrib, h.2.2.2 a ha, h'.2.2.2 a ha]⟩
  zero_mem' := ⟨fun _ _ => rfl, fun _ => rfl, fun _ _ _ => rfl, fun _ _ => by simp⟩
  smul_mem' c Z h := ⟨fun a b => by simp [h.1 a b], fun a => by simp [h.2.1 a],
    fun a b hab => by simp [h.2.2.1 a b hab], fun a ha => by simp [← Finset.mul_sum, h.2.2.2 a ha]⟩

/-- Extension by zero from `S × S` to `ι × ι`. -/
def extL (S : Finset ι) : Matrix S S ℝ →ₗ[ℝ] Matrix ι ι ℝ where
  toFun u := Matrix.of fun a b => if h : a ∈ S ∧ b ∈ S then u ⟨a, h.1⟩ ⟨b, h.2⟩ else 0
  map_add' u v := by ext a b; simp only [Matrix.of_apply, Matrix.add_apply]; split_ifs <;> simp
  map_smul' c u := by ext a b; simp only [Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, RingHom.id_apply]; split_ifs <;> simp

omit [Fintype ι] in
theorem extL_injective (S : Finset ι) : Function.Injective (extL S) := by
  intro u v h
  ext a b
  have := congrFun (congrFun h a) b
  simpa [extL, a.2, b.2] using this

/-- The weights on `S`, extended by zero. -/
def withinMap (S : Finset ι) : LinearMap.ker (rowSumL (ι := S)) →ₗ[ℝ] Matrix ι ι ℝ :=
  extL S ∘ₗ (symHollow S).subtype ∘ₗ (LinearMap.ker (rowSumL (ι := S))).subtype

omit [Fintype ι] in
theorem withinMap_injective (S : Finset ι) : Function.Injective (withinMap S) :=
  (extL_injective S).comp (Subtype.val_injective.comp Subtype.val_injective)

omit [Fintype ι] in
/-- **The zero family inside `S` is the extension of `S`'s own weights.** -/
theorem withinSub_eq_range (S : Finset ι) : withinSub S = LinearMap.range (withinMap S) := by
  ext Z
  constructor
  · intro hZ
    obtain ⟨hs, hh, hsupp, hrow⟩ := hZ
    let u : Matrix S S ℝ := Matrix.of fun a b => Z a b
    have hu : u ∈ symHollow S := ⟨fun a b => hs a b, fun a => hh a⟩
    have hk : (⟨u, hu⟩ : symHollow S) ∈ LinearMap.ker (rowSumL (ι := S)) := by
      rw [LinearMap.mem_ker]
      funext a
      change ∑ c : S, Z a c = 0
      rw [Finset.sum_coe_sort S (fun c => Z a c)]
      exact hrow a a.2
    refine ⟨⟨⟨u, hu⟩, hk⟩, ?_⟩
    ext a b
    change (if h : a ∈ S ∧ b ∈ S then Z a b else 0) = Z a b
    split_ifs with h
    · rfl
    · rw [not_and_or] at h; exact (hsupp a b h).symm
  · rintro ⟨⟨⟨u, hs, hh⟩, hk⟩, rfl⟩
    have hrow : ∀ a : S, ∑ c : S, u a c = 0 := fun a => congrFun (LinearMap.mem_ker.mp hk) a
    refine ⟨fun a b => ?_, fun a => ?_, fun a b hab => ?_, fun a ha => ?_⟩
    · change (if h : a ∈ S ∧ b ∈ S then u ⟨a, h.1⟩ ⟨b, h.2⟩ else 0)
        = (if h : b ∈ S ∧ a ∈ S then u ⟨b, h.1⟩ ⟨a, h.2⟩ else 0)
      by_cases ha : a ∈ S <;> by_cases hb : b ∈ S <;> simp [ha, hb, hs]
    · change (if h : a ∈ S ∧ a ∈ S then u ⟨a, h.1⟩ ⟨a, h.2⟩ else 0) = 0
      split_ifs <;> simp [hh]
    · change (if h : a ∈ S ∧ b ∈ S then u ⟨a, h.1⟩ ⟨b, h.2⟩ else 0) = 0
      rw [dif_neg]; rintro ⟨h1, h2⟩; rcases hab with h | h <;> contradiction
    · change ∑ b ∈ S, (if h : a ∈ S ∧ b ∈ S then u ⟨a, h.1⟩ ⟨b, h.2⟩ else 0) = 0
      rw [← Finset.sum_coe_sort S]
      simp only [ha, Finset.coe_mem, and_self, dif_pos]
      exact hrow ⟨a, ha⟩

omit [Fintype ι] in
/-- **The dimension of the zero family inside `S`**: `binom |S| 2 − |S|`, which is `|S|(|S| − 3)/2`, at `|S| ≥ 3`. -/
theorem finrank_withinSub (S : Finset ι) (hS : 3 ≤ S.card) :
    Module.finrank ℝ (withinSub S) = S.card.choose 2 - S.card := by
  rw [withinSub_eq_range, LinearMap.finrank_range_of_inj (withinMap_injective S),
    finrank_weights (by simpa using hS), Fintype.card_coe]

/-- The sum of a function on `S`. -/
def sumL (S : Finset ι) : (S → ℝ) →ₗ[ℝ] ℝ where
  toFun h := ∑ i, h i
  map_add' h h' := by simp [Finset.sum_add_distrib]
  map_smul' c h := by simp [Finset.mul_sum]

omit [Fintype ι] in
theorem finrank_ker_sumL (S : Finset ι) (hS : 1 ≤ S.card) : Module.finrank ℝ (LinearMap.ker (sumL S)) = S.card - 1 := by
  obtain ⟨a, ha⟩ := Finset.card_pos.mp hS
  have hsurj : Function.Surjective (sumL S) := fun r => ⟨Pi.single ⟨a, ha⟩ r, by simp [sumL]⟩
  have h := LinearMap.finrank_range_add_finrank_ker (sumL S)
  rw [LinearMap.range_eq_top.mpr hsurj, finrank_top, Module.finrank_self, Module.finrank_fintype_fun_eq_card,
    Fintype.card_coe] at h
  omega

/-- A function on `S`, extended by zero. -/
def extF (S : Finset ι) (h : S → ℝ) : ι → ℝ := fun a => if ha : a ∈ S then h ⟨a, ha⟩ else 0

/-- The `λ_p` weights of the zero-sum functions on `S`. -/
noncomputable def lamMap (S : Finset ι) (κ : ℝ) : LinearMap.ker (sumL S) →ₗ[ℝ] Matrix ι ι ℝ where
  toFun h := lamW S κ (extF S h)
  map_add' h h' := by
    ext a b; simp only [lamW, extF, Matrix.of_apply, Matrix.add_apply, Submodule.coe_add, Pi.add_apply]
    split_ifs <;> ring
  map_smul' c h := by
    ext a b; simp only [lamW, extF, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, Submodule.coe_smul,
      Pi.smul_apply, RingHom.id_apply]
    split_ifs <;> ring

omit [Fintype ι] in
/-- **At `|S| ≥ 3` the `λ_p` weights determine `h`**: `h_a` is half of `(h_a + h_b) + (h_a + h_c) − (h_b + h_c)`. -/
theorem lamMap_injective (S : Finset ι) (κ : ℝ) (hS : 3 ≤ S.card) : Function.Injective (lamMap S κ) := by
  rw [← LinearMap.ker_eq_bot, LinearMap.ker_eq_bot']
  intro h hz
  ext ⟨a, ha⟩
  have hc : 1 < ((S.erase a).card) := by rw [Finset.card_erase_of_mem ha]; omega
  obtain ⟨b, hb, c, hc', hbc⟩ := Finset.one_lt_card.mp hc
  have hab : b ≠ a := Finset.ne_of_mem_erase hb
  have hac : c ≠ a := Finset.ne_of_mem_erase hc'
  have hbS := Finset.mem_of_mem_erase hb
  have hcS := Finset.mem_of_mem_erase hc'
  have e : ∀ x y, x ∈ S → y ∈ S → x ≠ y → extF S h x + extF S h y = 0 := fun x y hx hy hxy => by
    have := congrFun (congrFun hz x) y
    simpa [lamMap, lamW, hxy, hx, hy] using this
  have e1 := e a b ha hbS (Ne.symm hab)
  have e2 := e a c ha hcS (Ne.symm hac)
  have e3 := e b c hbS hcS hbc
  have : extF S h a = 0 := by linarith
  simpa [extF, ha] using this

omit [Fintype ι] in
/-- **The dimension of the `λ_p` family**: `|S| − 1` at `|S| ≥ 3`. -/
theorem finrank_lam (S : Finset ι) (κ : ℝ) (hS : 3 ≤ S.card) :
    Module.finrank ℝ (LinearMap.range (lamMap S κ)) = S.card - 1 := by
  rw [LinearMap.finrank_range_of_inj (lamMap_injective S κ hS), finrank_ker_sumL S (by omega)]

omit [Fintype ι] in
/-- The `λ_p` family's members are the `lamW` of zero-sum functions on `S`, the family of
[L127DnSpan.lean](L127DnSpan.lean)'s `dn_decomp`. -/
theorem mem_range_lamMap (S : Finset ι) (κ : ℝ) (h : ι → ℝ) (hh : ∑ b ∈ S, h b = 0) :
    lamW S κ h ∈ LinearMap.range (lamMap S κ) := by
  refine ⟨⟨fun a => h a, ?_⟩, ?_⟩
  · rw [LinearMap.mem_ker]; change ∑ i : S, h i = 0; rw [Finset.sum_coe_sort S h]; exact hh
  · ext a b
    simp only [lamMap, LinearMap.coe_mk, AddHom.coe_mk, lamW, extF, Matrix.of_apply]
    by_cases ha : a ∈ S <;> by_cases hb : b ∈ S <;> simp [ha, hb]

/-! ## The cross family -/

/-- The block row and column sums of an `S × Sᶜ` block. -/
def rcL (S : Finset ι) : Matrix S (Sᶜ : Finset ι) ℝ →ₗ[ℝ] (S → ℝ) × ((Sᶜ : Finset ι) → ℝ) where
  toFun B := (fun i => ∑ j, B i j, fun j => ∑ i, B i j)
  map_add' B B' := by ext <;> simp [Finset.sum_add_distrib]
  map_smul' c B := by ext <;> simp [Finset.mul_sum]

/-- The total of the row sums less the total of the column sums. -/
def diffL (S : Finset ι) : (S → ℝ) × ((Sᶜ : Finset ι) → ℝ) →ₗ[ℝ] ℝ where
  toFun x := ∑ i, x.1 i - ∑ j, x.2 j
  map_add' x y := by simp [Finset.sum_add_distrib]; ring
  map_smul' c x := by
    simp only [Prod.smul_fst, Prod.smul_snd, Pi.smul_apply, smul_eq_mul, RingHom.id_apply, ← Finset.mul_sum]; ring

theorem range_rcL (S : Finset ι) (hS : 1 ≤ S.card) (hSc : 1 ≤ (Sᶜ : Finset ι).card) :
    LinearMap.range (rcL S) = LinearMap.ker (diffL S) := by
  obtain ⟨a0, ha0⟩ := Finset.card_pos.mp hS
  obtain ⟨c0, hc0⟩ := Finset.card_pos.mp hSc
  ext ⟨r, c⟩
  constructor
  · rintro ⟨B, hB⟩
    rw [← hB, LinearMap.mem_ker]
    change ∑ i, ∑ j, B i j - ∑ j, ∑ i, B i j = 0
    rw [Finset.sum_comm]; ring
  · intro hx
    have hrc : ∑ i, r i = ∑ j, c j := by
      have := LinearMap.mem_ker.mp hx; change ∑ i, r i - ∑ j, c j = 0 at this; linarith
    let a : S := ⟨a0, ha0⟩
    let d : (Sᶜ : Finset ι) := ⟨c0, hc0⟩
    refine ⟨Matrix.of fun i j => (if j = d then r i else 0) + (if i = a then c j else 0)
      - (if i = a ∧ j = d then ∑ k, r k else 0), ?_⟩
    change (fun i => ∑ j, _, fun j => ∑ i, _) = (r, c)
    ext i
    · simp only [Matrix.of_apply, Finset.sum_sub_distrib, Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.mem_univ,
        if_true]
      by_cases hi : i = a
      · subst hi
        have h2 := hrc; simp only [Finset.univ_eq_attach] at h2
        simp; linarith
      · simp [hi]
    · simp only [Matrix.of_apply, Finset.sum_sub_distrib, Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.mem_univ,
        if_true]
      by_cases hj : i = d
      · subst hj; simp
      · simp [hj]

theorem finrank_ker_diffL (S : Finset ι) (hS : 1 ≤ S.card) :
    Module.finrank ℝ (LinearMap.ker (diffL S)) = S.card + (Sᶜ : Finset ι).card - 1 := by
  obtain ⟨a0, ha0⟩ := Finset.card_pos.mp hS
  have hsurj : Function.Surjective (diffL S) := fun t => ⟨(Pi.single ⟨a0, ha0⟩ t, 0), by simp [diffL]⟩
  have h := LinearMap.finrank_range_add_finrank_ker (diffL S)
  rw [LinearMap.range_eq_top.mpr hsurj, finrank_top, Module.finrank_self, Module.finrank_prod,
    Module.finrank_fintype_fun_eq_card, Module.finrank_fintype_fun_eq_card, Fintype.card_coe, Fintype.card_coe] at h
  omega

/-- **The zero-sum blocks have dimension `pq − (p + q − 1)`.** -/
theorem finrank_ker_rcL (S : Finset ι) (hS : 1 ≤ S.card) (hSc : 1 ≤ (Sᶜ : Finset ι).card) :
    Module.finrank ℝ (LinearMap.ker (rcL S)) = S.card * (Sᶜ : Finset ι).card - (S.card + (Sᶜ : Finset ι).card - 1) := by
  have h := LinearMap.finrank_range_add_finrank_ker (rcL S)
  rw [range_rcL S hS hSc, finrank_ker_diffL S hS, Module.finrank_matrix, Module.finrank_self, Fintype.card_coe,
    Fintype.card_coe, mul_one] at h
  omega

/-- The cross family as a subspace. -/
def crossSub (S : Finset ι) : Submodule ℝ (Matrix ι ι ℝ) where
  carrier := {X | IsCrossW S X}
  add_mem' {X X'} h h' := ⟨fun a b => by simp [h.1 a b, h'.1 a b],
    fun a b hab => by simp [h.2.1 a b hab, h'.2.1 a b hab],
    fun a ha => by simp [Finset.sum_add_distrib, h.2.2.1 a ha, h'.2.2.1 a ha],
    fun a ha => by simp [Finset.sum_add_distrib, h.2.2.2 a ha, h'.2.2.2 a ha]⟩
  zero_mem' := ⟨fun _ _ => rfl, fun _ _ _ => rfl, fun _ _ => by simp, fun _ _ => by simp⟩
  smul_mem' c X h := ⟨fun a b => by simp [h.1 a b], fun a b hab => by simp [h.2.1 a b hab],
    fun a ha => by simp [← Finset.mul_sum, h.2.2.1 a ha], fun a ha => by simp [← Finset.mul_sum, h.2.2.2 a ha]⟩

/-- A block, placed across `S` and mirrored. -/
def crossExt (S : Finset ι) : Matrix S (Sᶜ : Finset ι) ℝ →ₗ[ℝ] Matrix ι ι ℝ where
  toFun B := Matrix.of fun a b =>
    if h : a ∈ S ∧ b ∉ S then B ⟨a, h.1⟩ ⟨b, Finset.mem_compl.mpr h.2⟩
    else if h' : a ∉ S ∧ b ∈ S then B ⟨b, h'.2⟩ ⟨a, Finset.mem_compl.mpr h'.1⟩ else 0
  map_add' B B' := by ext a b; simp only [Matrix.of_apply, Matrix.add_apply]; split_ifs <;> simp
  map_smul' c B := by
    ext a b; simp only [Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, RingHom.id_apply]; split_ifs <;> simp

theorem crossExt_injective (S : Finset ι) : Function.Injective (crossExt S) := by
  intro B B' h
  ext i j
  have := congrFun (congrFun h i) j
  have hj : (j : ι) ∉ S := Finset.mem_compl.mp j.2
  simpa [crossExt, i.2, hj] using this

/-- The zero-sum blocks, placed across `S`. -/
def crossMap (S : Finset ι) : LinearMap.ker (rcL S) →ₗ[ℝ] Matrix ι ι ℝ :=
  crossExt S ∘ₗ (LinearMap.ker (rcL S)).subtype

/-- **The cross family is the zero-sum blocks placed across `S`.** -/
theorem crossSub_eq_range (S : Finset ι) : crossSub S = LinearMap.range (crossMap S) := by
  ext X
  constructor
  · intro hX
    obtain ⟨hs, hsupp, hr1, hr2⟩ := hX
    let B : Matrix S (Sᶜ : Finset ι) ℝ := Matrix.of fun i j => X i j
    have hk : B ∈ LinearMap.ker (rcL S) := by
      rw [LinearMap.mem_ker]
      ext i
      · change ∑ j : (Sᶜ : Finset ι), X i j = 0
        rw [Finset.sum_coe_sort Sᶜ (fun j => X i j)]; exact hr1 i i.2
      · change ∑ k : S, X k i = 0
        rw [Finset.sum_coe_sort S (fun k => X k i), Finset.sum_congr rfl fun k _ => hs k i]
        exact hr2 i (Finset.mem_compl.mp i.2)
    refine ⟨⟨B, hk⟩, ?_⟩
    ext a b
    change (if h : a ∈ S ∧ b ∉ S then X a b
      else if h' : a ∉ S ∧ b ∈ S then X b a else 0) = X a b
    by_cases ha : a ∈ S <;> by_cases hb : b ∈ S
    · simp [ha, hb, hsupp a b (iff_of_true ha hb)]
    · simp [ha, hb]
    · simp [ha, hb, hs b a]
    · simp [ha, hb, hsupp a b (iff_of_false ha hb)]
  · rintro ⟨⟨B, hk⟩, rfl⟩
    have hrow : ∀ i : S, ∑ j, B i j = 0 := fun i => congrFun (congrArg Prod.fst (LinearMap.mem_ker.mp hk)) i
    have hcol : ∀ j : (Sᶜ : Finset ι), ∑ i, B i j = 0 := fun j => congrFun (congrArg Prod.snd (LinearMap.mem_ker.mp hk)) j
    refine ⟨fun a b => ?_, fun a b hab => ?_, fun a ha => ?_, fun a ha => ?_⟩
    · change (if h : a ∈ S ∧ b ∉ S then _ else if h' : a ∉ S ∧ b ∈ S then _ else 0)
        = (if h : b ∈ S ∧ a ∉ S then _ else if h' : b ∉ S ∧ a ∈ S then _ else 0)
      by_cases ha : a ∈ S <;> by_cases hb : b ∈ S <;> simp [ha, hb]
    · change (if h : a ∈ S ∧ b ∉ S then _ else if h' : a ∉ S ∧ b ∈ S then _ else 0) = 0
      by_cases ha : a ∈ S <;> by_cases hb : b ∈ S <;> simp_all
    · change ∑ b ∈ Sᶜ, (if h : a ∈ S ∧ b ∉ S then _ else if h' : a ∉ S ∧ b ∈ S then _ else 0) = 0
      rw [← Finset.sum_coe_sort Sᶜ]
      simp only [ha, true_and, Finset.mem_compl.mp (Subtype.prop _), not_false_eq_true, dif_pos]
      exact hrow ⟨a, ha⟩
    · change ∑ b ∈ S, (if h : a ∈ S ∧ b ∉ S then _ else if h' : a ∉ S ∧ b ∈ S then _ else 0) = 0
      rw [← Finset.sum_coe_sort S]
      simp only [ha, false_and, dif_neg, not_false_eq_true, true_and, Finset.coe_mem, dif_pos]
      exact hcol ⟨a, Finset.mem_compl.mpr ha⟩

/-- **The dimension of the cross family**: `(p − 1)(q − 1)`. -/
theorem finrank_crossSub (S : Finset ι) (hS : 1 ≤ S.card) (hSc : 1 ≤ (Sᶜ : Finset ι).card) :
    Module.finrank ℝ (crossSub S) = (S.card - 1) * ((Sᶜ : Finset ι).card - 1) := by
  rw [crossSub_eq_range, LinearMap.finrank_range_of_inj (f := crossMap S) (fun x y h => Subtype.ext (crossExt_injective S h)),
    finrank_ker_rcL S hS hSc]
  obtain ⟨p, hp⟩ : ∃ p, S.card = p + 1 := ⟨S.card - 1, by omega⟩
  obtain ⟨q, hq⟩ : ∃ q, (Sᶜ : Finset ι).card = q + 1 := ⟨(Sᶜ : Finset ι).card - 1, by omega⟩
  rw [hp, hq]
  simp only [Nat.add_sub_cancel]
  rw [show (p + 1) * (q + 1) = p * q + (p + 1 + (q + 1) - 1) by ring_nf; omega]
  omega

/-! ## The sphere-weight line -/

/-- The sphere weight is nonzero once both factors are: its `T × Tᶜ` entries are `−1`. -/
theorem sphereWeight_ne_zero (S : Finset ι) (hS : 1 ≤ S.card) (hSc : 1 ≤ Sᶜ.card) : sphereWeight S ≠ 0 := by
  obtain ⟨a, ha⟩ := Finset.card_pos.mp hS
  obtain ⟨b, hb⟩ := Finset.card_pos.mp hSc
  have hbS := Finset.mem_compl.mp hb
  have hab : a ≠ b := fun e => hbS (e ▸ ha)
  intro h
  have := congrFun (congrFun h a) b
  simp [sphereWeight, hab, ha, hbS] at this

/-- **The dimension of the sphere-weight line**: `1`. -/
theorem finrank_sphereLine (S : Finset ι) (hS : 1 ≤ S.card) (hSc : 1 ≤ Sᶜ.card) :
    Module.finrank ℝ (Submodule.span ℝ {sphereWeight S}) = 1 :=
  finrank_span_singleton (sphereWeight_ne_zero S hS hSc)

end HamiltonsCubic.Results
