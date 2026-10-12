import HamiltonsCubic.Results.L17Codim

set_option linter.style.longLine false

/-!
# The dimension of the tangent Weyl space, and L17's `dim {F = 0} ≥ 1451` at `n = 12`

[route-a.md](../../../findings/route-a.md), Lemma L17: *"`codim {F = 0} ≤ 186` at `n = 12`, so it has dimension at least
`1451` of `T_uS`'s `1637`"*. The build of [the Weyl-dimension plan](../../../reviews/2026-09-26-lean-weyl-dimension-plan.md),
a rank-nullity count with no surjectivity:

- **milestone 2**, `IsCurv`, `alt4_swap01`, `alt4_swap12`, `alt4_swap23`, `altTup_swap`, `altTup_perm`,
  **`altTup_eq_zero`**: for a tensor with the curvature symmetries, `Alt` changes sign under every transposition of its
  four indices, so it vanishes everywhere once it vanishes on increasing indices;
- `isCurv_compOf`, `ric`, `ric_symm`: a symmetric operator on `Λ²ℝⁿ` has the curvature symmetries, and its Ricci
  contraction is symmetric;
- `symSub`, **`weylT`**: the symmetric operators, and `𝒲ₙ ∩ T_uS` in the bivector model (symmetric, `Alt(H) = 0`,
  Ricci-flat, orthogonal to the padded competitor `u`);
- **milestone 1**, `ep`, `E1`, `symOp`, `entry_symOp`, **`finrank_symSub_ge`**: the symmetrised rank-one operators of the
  unordered pairs `{p, q}` are independent, so `dim Sym(Λ²ℝⁿ) ≥ N(N+1)/2`, `N = dim Λ²ℝⁿ`;
- **milestone 3**, `consMap`, `finrank_consTarget`, **`mem_weylT_of_consMap`**: `H ↦ (Alt(H) on increasing quadruples,
  Ric(H) on unordered pairs, tr(Hu))`, into a space of dimension `C(n,4) + n(n+1)/2 + 1`, whose kernel on `Sym(Λ²ℝⁿ)` lies
  in `𝒲ₙ ∩ T_uS`;
- **milestone 4**, **`finrank_weylT_ge`**, **`finrank_weylT_12`**: `dim 𝒲ₙ ∩ T_uS ≥ N(N+1)/2 − C(n,4) − n(n+1)/2 − 1`,
  which is `2211 − 495 − 78 − 1 = 1637` at `n = 12`;
- **`L17_dim_12`**: with [L17Codim.lean](L17Codim.lean)'s `L17_codim`, `{F = 0} ∩ 𝒲₁₂ ∩ T_uS` is the kernel of the
  condition map there and has dimension at least `1637 − 186 = 1451`.

The upper bound `dim 𝒲₁₂ ∩ T_uS ≤ 1637`, which needs the constraint map onto its target, is not proved here.
-/

namespace HamiltonsCubic.L17Deriv

open Module HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.SpectralFn HamiltonsCubic.BivModel

variable {n : ℕ}

/-! ## Milestone 2: alternation -/

section Alt
variable {ι : Type*}

/-- The symmetries of a curvature tensor's components. -/
structure IsCurv (T : ι → ι → ι → ι → ℝ) : Prop where
  left : ∀ i j k l, T j i k l = -T i j k l
  right : ∀ i j k l, T i j l k = -T i j k l
  pair : ∀ i j k l, T k l i j = T i j k l

variable {T : ι → ι → ι → ι → ℝ} (hT : IsCurv T)
include hT

theorem alt4_swap01 (i j k l : ι) : alt4 T j i k l = -alt4 T i j k l := by
  unfold alt4
  have e1 := hT.left i j k l
  have e2 : T j k l i = -T i l j k := by rw [← hT.pair, hT.left]
  have e3 : T j l i k = -T i k l j := by rw [← hT.pair, hT.right]
  rw [e1, e2, e3]; ring

theorem alt4_swap12 (i j k l : ι) : alt4 T i k j l = -alt4 T i j k l := by
  unfold alt4
  rw [hT.right i k j l, hT.right i j l k, hT.right i l k j]; ring

theorem alt4_swap23 (i j k l : ι) : alt4 T i j l k = -alt4 T i j k l := by
  unfold alt4
  rw [hT.right i j l k, hT.right i l k j, hT.right i k j l]; ring

/-- `Alt` as a function of the index tuple. -/
noncomputable def altTup (v : Fin 4 → ι) : ℝ := alt4 T (v 0) (v 1) (v 2) (v 3)

theorem altTup_swap (v : Fin 4 → ι) {a b : Fin 4} (hab : a ≠ b) :
    altTup (T := T) (v ∘ Equiv.swap a b) = -altTup (T := T) v := by
  have s01 := alt4_swap01 hT; have s12 := alt4_swap12 hT; have s23 := alt4_swap23 hT
  unfold altTup
  fin_cases a <;> fin_cases b <;> simp at hab <;> simp [Equiv.swap_apply_def] <;>
    linarith [s01 (v 0) (v 1) (v 2) (v 3), s01 (v 1) (v 2) (v 0) (v 3), s12 (v 1) (v 0) (v 2) (v 3),
      s01 (v 1) (v 3) (v 2) (v 0), s12 (v 1) (v 2) (v 3) (v 0), s23 (v 1) (v 2) (v 0) (v 3),
      s12 (v 0) (v 1) (v 2) (v 3), s12 (v 0) (v 2) (v 3) (v 1), s23 (v 0) (v 2) (v 1) (v 3), s23 (v 0) (v 1) (v 2) (v 3)]

theorem altTup_perm (σ : Equiv.Perm (Fin 4)) :
    ∀ v : Fin 4 → ι, altTup (T := T) (v ∘ σ) = (Equiv.Perm.sign σ : ℤ) * altTup (T := T) v := by
  induction σ using Equiv.Perm.swap_induction_on with
  | one => intro v; simp
  | swap_mul f x y hxy ih =>
    intro v
    have e : v ∘ ⇑(Equiv.swap x y * f) = (v ∘ Equiv.swap x y) ∘ f := by ext; simp
    rw [e, ih, altTup_swap hT v hxy, Equiv.Perm.sign_mul, Equiv.Perm.sign_swap hxy]; push_cast; ring

/-- **`Alt` vanishes everywhere once it vanishes on increasing indices.** -/
theorem altTup_eq_zero [LinearOrder ι]
    (h : ∀ s : Finset ι, ∀ hs : s.card = 4, altTup (T := T) (s.orderEmbOfFin hs) = 0) (v : Fin 4 → ι) :
    altTup (T := T) v = 0 := by
  by_cases hv : Function.Injective v
  · set s := Finset.univ.image v with hsdef
    have hs : s.card = 4 := by rw [Finset.card_image_of_injective _ hv]; simp
    have hmem : ∀ i, v i ∈ s := fun i => Finset.mem_image_of_mem v (Finset.mem_univ i)
    let σf : Fin 4 → Fin 4 := fun i => (s.orderIsoOfFin hs).symm ⟨v i, hmem i⟩
    have hσ : ∀ i, s.orderEmbOfFin hs (σf i) = v i := fun i => by
      rw [← Finset.coe_orderIsoOfFin_apply]; simp [σf]
    have hinj : Function.Injective σf := fun i i' hii => hv (by rw [← hσ i, ← hσ i', hii])
    let σ := Equiv.ofBijective σf (Finite.injective_iff_bijective.mp hinj)
    have hve : v = (s.orderEmbOfFin hs) ∘ σ := by ext i; exact (hσ i).symm
    rw [hve, altTup_perm hT, h s hs, mul_zero]
  · obtain ⟨a, b, hab, hne⟩ : ∃ a b, v a = v b ∧ a ≠ b := by
      simp only [Function.Injective, not_forall] at hv
      obtain ⟨a, b, h1, h2⟩ := hv; exact ⟨a, b, h1, h2⟩
    have hsw : v ∘ Equiv.swap a b = v := by
      ext i
      simp only [Function.comp_apply, Equiv.swap_apply_def]
      split_ifs with h1 h2 <;> subst_vars <;> simp [hab]
    have := altTup_swap hT v hne
    rw [hsw] at this; linarith

end Alt

/-! ## The curvature symmetries of `compOf` -/

theorem coords_neg (X : Matrix (Fin n) (Fin n) ℝ) : coords (-X) = -coords X := by
  ext p; simp [coords_apply, inner2_neg_left]

theorem isCurv_compOf {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric) : IsCurv (compOf H) where
  left i j k l := by unfold compOf; rw [phi_swap i j, coords_neg, map_neg, inner_neg_right]
  right i j k l := by unfold compOf; rw [phi_swap k l, coords_neg, inner_neg_left]
  pair i j k l := by simp only [compOf]; rw [← hH, real_inner_comm]

theorem compOf_add (H H' : Biv n →ₗ[ℝ] Biv n) (i j k l : Fin n) :
    compOf (H + H') i j k l = compOf H i j k l + compOf H' i j k l := by
  simp [compOf, inner_add_right]

theorem compOf_smul (c : ℝ) (H : Biv n →ₗ[ℝ] Biv n) (i j k l : Fin n) :
    compOf (c • H) i j k l = c * compOf H i j k l := by
  simp [compOf, real_inner_smul_right]

/-- **The Ricci contraction** of an operator on `Λ²ℝⁿ`. -/
noncomputable def ric (H : Biv n →ₗ[ℝ] Biv n) (a b : Fin n) : ℝ := ∑ k, compOf H a k b k

theorem ric_symm {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric) (a b : Fin n) : ric H b a = ric H a b := by
  unfold ric; refine Finset.sum_congr rfl fun k _ => (isCurv_compOf hH).pair _ _ _ _

/-! ## The spaces -/

variable (n) in
/-- The symmetric operators on `Λ²ℝⁿ`. -/
def symSub : Submodule ℝ (Biv n →ₗ[ℝ] Biv n) where
  carrier := {H | H.IsSymmetric}
  add_mem' {H H'} hH hH' x y := by
    simp only [LinearMap.add_apply, inner_add_left, inner_add_right, hH x y, hH' x y]
  zero_mem' x y := by simp
  smul_mem' c H hH x y := by
    simp only [LinearMap.smul_apply, real_inner_smul_left, real_inner_smul_right, hH x y]

variable (n) in
/-- **`𝒲ₙ ∩ T_uS` in the bivector model**: symmetric, `Alt(H) = 0`, Ricci-flat, and orthogonal to the padded
competitor `u`. -/
def weylT : Submodule ℝ (Biv n →ₗ[ℝ] Biv n) where
  carrier := {H | H.IsSymmetric ∧ alt4 (compOf H) = 0 ∧ ric H = 0 ∧ LinearMap.trace ℝ (Biv n) (H ∘ₗ uOp) = 0}
  add_mem' {H H'} hH hH' := by
    refine ⟨(symSub n).add_mem hH.1 hH'.1, ?_, ?_, ?_⟩
    · funext i j k l
      have h1 := congrFun (congrFun (congrFun (congrFun hH.2.1 i) j) k) l
      have h2 := congrFun (congrFun (congrFun (congrFun hH'.2.1 i) j) k) l
      simp only [alt4, compOf_add, Pi.zero_apply] at h1 h2 ⊢; linarith
    · funext a b
      have h1 := congrFun (congrFun hH.2.2.1 a) b; have h2 := congrFun (congrFun hH'.2.2.1 a) b
      simp only [ric, compOf_add, Finset.sum_add_distrib, Pi.zero_apply] at h1 h2 ⊢; linarith
    · rw [LinearMap.add_comp, map_add, hH.2.2.2, hH'.2.2.2, add_zero]
  zero_mem' := ⟨(symSub n).zero_mem, by funext i j k l; simp [alt4, compOf], by funext a b; simp [ric, compOf],
    by simp⟩
  smul_mem' c H hH := by
    refine ⟨(symSub n).smul_mem c hH.1, ?_, ?_, ?_⟩
    · funext i j k l
      have h1 := congrFun (congrFun (congrFun (congrFun hH.2.1 i) j) k) l
      simp only [alt4, compOf_smul, Pi.zero_apply] at h1 ⊢; linear_combination c * h1
    · funext a b
      have h1 := congrFun (congrFun hH.2.2.1 a) b
      simp only [ric, compOf_smul, ← Finset.mul_sum, Pi.zero_apply] at h1 ⊢; rw [h1, mul_zero]
    · rw [LinearMap.smul_comp, map_smul, hH.2.2.2, smul_zero]

theorem admissible_of_weylT {H : Biv n →ₗ[ℝ] Biv n} (hH : H ∈ weylT n) : Admissible H :=
  ⟨hH.1, hH.2.1, hH.2.2.2⟩

/-! ## Milestone 1: the symmetric operators have dimension at least `N(N+1)/2` -/

/-- The coordinate bivector `e_p`. -/
noncomputable def ep (p : Pairs n) : Biv n := EuclideanSpace.single p 1

theorem inner_ep (p q : Pairs n) : inner ℝ (ep p) (ep q) = if p = q then 1 else 0 := by
  unfold ep; rw [EuclideanSpace.inner_single_left, PiLp.single_apply]; split_ifs <;> simp

/-- The rank-one operator `x ↦ ⟨e_q, x⟩ e_p`. -/
noncomputable def E1 (p q : Pairs n) : Biv n →ₗ[ℝ] Biv n := (innerₛₗ ℝ (ep q)).smulRight (ep p)

theorem E1_apply (p q : Pairs n) (x : Biv n) : E1 p q x = inner ℝ (ep q) x • ep p := rfl

/-- **The symmetrised rank-one operator** of an unordered pair `{p, q}`. -/
noncomputable def symOp (s : Sym2 (Pairs n)) : Biv n →ₗ[ℝ] Biv n :=
  E1 (Quot.out s).1 (Quot.out s).2 + E1 (Quot.out s).2 (Quot.out s).1

theorem symOp_mem (s : Sym2 (Pairs n)) : symOp s ∈ symSub n := fun x y => by
  simp only [symOp, LinearMap.add_apply, E1_apply, inner_add_left, inner_add_right, real_inner_smul_left,
    real_inner_smul_right]
  rw [real_inner_comm x (ep (Quot.out s).1), real_inner_comm x (ep (Quot.out s).2)]; ring

theorem entry_symOp (s : Sym2 (Pairs n)) (a b : Pairs n) :
    inner ℝ (ep a) (symOp s (ep b)) = if s(a, b) = s then (if a = b then 2 else 1) else 0 := by
  have hrep : s((Quot.out s).1, (Quot.out s).2) = s := Quot.out_eq s
  simp only [symOp, LinearMap.add_apply, E1_apply, inner_add_right, real_inner_smul_right, inner_ep]
  generalize (Quot.out s).1 = p at hrep ⊢
  generalize (Quot.out s).2 = q at hrep ⊢
  subst hrep
  simp only [Sym2.eq_iff]
  by_cases h1 : a = p <;> by_cases h2 : b = q <;> by_cases h3 : a = q <;> by_cases h4 : b = p <;>
    (subst_vars; simp_all [eq_comm]; try norm_num)

/-- **Milestone 1**: `dim Sym(Λ²ℝⁿ) ≥ N(N+1)/2`, `N = dim Λ²ℝⁿ`. -/
theorem finrank_symSub_ge : (Fintype.card (Pairs n) + 1).choose 2 ≤ finrank ℝ (symSub n) := by
  have hli : LinearIndependent ℝ (fun s : Sym2 (Pairs n) => (⟨symOp s, symOp_mem s⟩ : symSub n)) := by
    rw [Fintype.linearIndependent_iff]
    intro g hg s0
    have hrep : s((Quot.out s0).1, (Quot.out s0).2) = s0 := Quot.out_eq s0
    set a := (Quot.out s0).1; set b := (Quot.out s0).2
    have h := congrArg (fun X : symSub n => inner ℝ (ep a) ((X : Biv n →ₗ[ℝ] Biv n) (ep b))) hg
    simp only [Submodule.coe_sum, Submodule.coe_smul, LinearMap.sum_apply, LinearMap.smul_apply,
      inner_sum, real_inner_smul_right, entry_symOp, Submodule.coe_zero, LinearMap.zero_apply, inner_zero_right] at h
    have hab : s(a, b) = s0 := hrep
    rw [Finset.sum_eq_single s0 (fun s _ hs => by rw [if_neg (by rw [hab]; exact Ne.symm hs), mul_zero])
      (fun h => absurd (Finset.mem_univ _) h), if_pos hab] at h
    have hc : (if a = b then (2 : ℝ) else 1) ≠ 0 := by split_ifs <;> norm_num
    exact (mul_eq_zero.mp h).resolve_right hc
  have := hli.fintype_card_le_finrank
  rwa [Sym2.card] at this

/-! ## Milestone 3: the constraint map -/

variable (n) in
/-- The four-element subsets of the index set. -/
abbrev Q4 := {s : Finset (Fin n) // s.card = 4}

/-- **The constraint map**: `Alt(H)` on increasing index quadruples, `Ric(H)` on unordered index pairs, and `tr(H u)`. -/
noncomputable def consMap : (Biv n →ₗ[ℝ] Biv n) →ₗ[ℝ] ((Q4 n → ℝ) × (Sym2 (Fin n) → ℝ) × ℝ) where
  toFun H := (fun s => altTup (T := compOf H) (s.1.orderEmbOfFin s.2),
    fun s' => ric H (Quot.out s').1 (Quot.out s').2, LinearMap.trace ℝ (Biv n) (H ∘ₗ uOp))
  map_add' H H' := by
    refine Prod.ext (funext fun s => ?_) (Prod.ext (funext fun s' => ?_) ?_)
    · simp only [altTup, alt4, compOf_add, Pi.add_apply, Prod.fst_add]; ring
    · simp only [ric, compOf_add, Finset.sum_add_distrib, Pi.add_apply, Prod.snd_add, Prod.fst_add]
    · simp only [LinearMap.add_comp, map_add, Prod.snd_add]
  map_smul' c H := by
    refine Prod.ext (funext fun s => ?_) (Prod.ext (funext fun s' => ?_) ?_)
    · simp only [altTup, alt4, compOf_smul, Pi.smul_apply, Prod.smul_fst, smul_eq_mul, RingHom.id_apply]; ring
    · simp only [ric, compOf_smul, ← Finset.mul_sum, Pi.smul_apply, Prod.smul_snd, Prod.smul_fst, smul_eq_mul,
        RingHom.id_apply]
    · simp only [LinearMap.smul_comp, map_smul, Prod.smul_snd, smul_eq_mul, RingHom.id_apply]

theorem finrank_consTarget :
    finrank ℝ ((Q4 n → ℝ) × (Sym2 (Fin n) → ℝ) × ℝ) = n.choose 4 + (n + 1).choose 2 + 1 := by
  rw [Module.finrank_prod, Module.finrank_prod, Module.finrank_fintype_fun_eq_card,
    Module.finrank_fintype_fun_eq_card, Module.finrank_self, Fintype.card_finset_len, Sym2.card, Fintype.card_fin]
  ring

/-- **A symmetric operator the constraint map kills is a tangent Weyl operator.** -/
theorem mem_weylT_of_consMap {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric) (h : consMap H = 0) : H ∈ weylT n := by
  have h1 := congrArg Prod.fst h
  have h2 := congrArg (fun x => x.2.1) h
  have h3 := congrArg (fun x => x.2.2) h
  refine ⟨hH, ?_, ?_, by simpa [consMap] using h3⟩
  · funext i j k l
    have := altTup_eq_zero (isCurv_compOf hH) (fun s hs => by simpa [consMap] using congrFun h1 ⟨s, hs⟩) ![i, j, k, l]
    simpa [altTup] using this
  · funext a b
    have hs := congrFun h2 s(a, b)
    simp only [consMap, LinearMap.coe_mk, AddHom.coe_mk] at hs
    have hrep : s((Quot.out s(a, b)).1, (Quot.out s(a, b)).2) = s(a, b) := Quot.out_eq _
    rw [Sym2.eq_iff] at hrep
    rcases hrep with ⟨e1, e2⟩ | ⟨e1, e2⟩
    · rw [e1, e2] at hs; exact hs
    · rw [e1, e2, ric_symm hH] at hs; exact hs

/-! ## Milestone 4: the count -/

/-- **`dim 𝒲ₙ ∩ T_uS ≥ N(N+1)/2 − C(n,4) − n(n+1)/2 − 1`**, `N = dim Λ²ℝⁿ`. -/
theorem finrank_weylT_ge :
    (Fintype.card (Pairs n) + 1).choose 2 ≤ finrank ℝ (weylT n) + (n.choose 4 + (n + 1).choose 2 + 1) := by
  set C := consMap (n := n) ∘ₗ (symSub n).subtype
  have hrn := LinearMap.finrank_range_add_finrank_ker C
  have hr := Submodule.finrank_le (LinearMap.range C)
  rw [finrank_consTarget] at hr
  have hle : (LinearMap.ker C).map (symSub n).subtype ≤ weylT n := by
    rintro _ ⟨H, hH, rfl⟩
    exact mem_weylT_of_consMap H.2 hH
  have hk := Submodule.finrank_mono hle
  rw [Submodule.finrank_map_subtype_eq] at hk
  have := finrank_symSub_ge (n := n)
  omega

theorem card_pairs12 : Fintype.card (Pairs 12) = 66 := rfl

/-- **At `n = 12`: `dim 𝒲₁₂ ∩ T_uS ≥ 1637`.** -/
theorem finrank_weylT_12 : 1637 ≤ finrank ℝ (weylT 12) := by
  have := finrank_weylT_ge (n := 12)
  rw [card_pairs12] at this
  norm_num [Nat.choose] at this
  omega

/-- **L17's dimension count at `n = 12`**: the equality cone `{F = 0}` in `𝒲₁₂ ∩ T_uS` is the kernel of the condition
map there, and has dimension at least `1451`. -/
theorem L17_dim_12 {N : ℕ} (hN : finrank ℝ (Biv 12) = N) :
    (∀ H : weylT 12, H ∈ LinearMap.ker (condMap (by norm_num) ∘ₗ (weylT 12).subtype) ↔
        Fval hN (admissible_of_weylT H.2).symm = 0) ∧
      1451 ≤ finrank ℝ (LinearMap.ker (condMap (by norm_num) ∘ₗ (weylT 12).subtype)) := by
  obtain ⟨h1, h2⟩ := L17_codim hN (by norm_num) (weylT 12) fun H hH => admissible_of_weylT hH
  refine ⟨h1, ?_⟩
  rw [finrank_biv12] at h2
  have := finrank_weylT_12
  omega

end HamiltonsCubic.L17Deriv
