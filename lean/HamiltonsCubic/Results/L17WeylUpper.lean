import HamiltonsCubic.Results.L17WeylDim
import HamiltonsCubic.Results.L17Phi

set_option linter.style.longLine false

/-!
# `dim 𝒲₁₂ ∩ T_uS = 1637`: the upper bound

Milestone 5 of [the Weyl-dimension plan](../../../reviews/2026-09-26-lean-weyl-dimension-plan.md). With
[L17WeylDim.lean](L17WeylDim.lean)'s lower bound it gives the record's `dim 𝒲₁₂ ∩ T_uS = 1637` in the bivector model.

- `coords_phi_apply`, **`sum_coords_phi`**, **`opOf`**, `inner_opOf`, `opOf_mem`, **`compOf_opOf`**: every tensor `T`
  with the curvature symmetries is `compOf` of a symmetric operator on `Λ²ℝⁿ`;
- `pairF`, `T4`, `isCurv_T4`, `ric_T4`, **`alt4_T4`**: `(e_a ∧ e_b) ⊙ (e_c ∧ e_d)` for `a < b < c < d` is Ricci-flat,
  and its `Alt` on increasing quadruples is `1/3` at `(a, b, c, d)` and `0` elsewhere (`mem_range_T4`);
- `dlt`, `KN`, `isCurv_KN`, `alt4_KN`, **`ric_KN`**: the Kulkarni–Nomizu product `h ⊙ g` has `Alt = 0` and
  `Ric = (n − 2) h + tr(h) g`, which reaches every symmetric Ricci target (`mem_range_KN`);
- `consMap_uOp`: the padded competitor maps to `(0, 0, 1)`;
- **`consMap_range`**: the constraint map is onto its target on the symmetric operators, for `n ≥ 4`;
- `ext_ep`, `symSub_eq_sum`, **`finrank_symSub_le`**: the `symOp` span the symmetric operators;
- **`finrank_weylT_le`**, **`finrank_weylT_12_eq`**: `dim 𝒲ₙ ∩ T_uS ≤ N(N+1)/2 − C(n,4) − n(n+1)/2 − 1`, and
  `dim 𝒲₁₂ ∩ T_uS = 1637`.
-/

namespace HamiltonsCubic.L17Deriv

open Module HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.SpectralFn HamiltonsCubic.BivModel

variable {n : ℕ}

/-! ## Operators from tensors -/

theorem coords_phi_apply (i j : Fin n) (p : Pairs n) :
    coords (phi i j) p = (if i = p.1.1 ∧ j = p.1.2 then 1 else 0) - (if j = p.1.1 ∧ i = p.1.2 then 1 else 0) := by
  rw [coords_apply, inner2_phi _ (phi_isSkew _ _)]
  simp only [phi, Matrix.sub_apply, Matrix.single_apply]
  by_cases h1 : i = p.1.1 ∧ j = p.1.2 <;> by_cases h2 : j = p.1.1 ∧ i = p.1.2 <;>
    simp only [h1, h2, if_false] <;> simp_all [eq_comm]

/-- **Contracting against `coords (phi k l)`** reads off an antisymmetric function at `(k, l)`. -/
theorem sum_coords_phi {f : Fin n → Fin n → ℝ} (hf : ∀ i j, f j i = -f i j) (k l : Fin n) :
    ∑ p : Pairs n, coords (phi k l) p * f p.1.1 p.1.2 = f k l := by
  rcases lt_trichotomy k l with h | h | h
  · rw [Fintype.sum_eq_single ⟨(k, l), h⟩]
    · simp [coords_phi_apply, h.ne]
    · rintro ⟨⟨a, b⟩, hab⟩ hp
      simp only at hab
      rw [coords_phi_apply]
      simp only
      have h1 : ¬(k = a ∧ l = b) := fun e => hp (by obtain ⟨rfl, rfl⟩ := e; rfl)
      have h2 : ¬(l = a ∧ k = b) := fun e => by obtain ⟨rfl, rfl⟩ := e; exact absurd (h.trans hab) (lt_irrefl _)
      simp [h1, h2]
  · subst h
    have : f k k = 0 := by have := hf k k; linarith
    rw [this]; refine Finset.sum_eq_zero fun p _ => ?_
    rw [coords_phi_apply]; simp
  · rw [Fintype.sum_eq_single ⟨(l, k), h⟩]
    · simp [coords_phi_apply, h.ne, hf l k]
    · rintro ⟨⟨a, b⟩, hab⟩ hp
      simp only at hab
      rw [coords_phi_apply]
      simp only
      have h1 : ¬(l = a ∧ k = b) := fun e => hp (by obtain ⟨rfl, rfl⟩ := e; rfl)
      have h2 : ¬(k = a ∧ l = b) := fun e => by obtain ⟨rfl, rfl⟩ := e; exact absurd (h.trans hab) (lt_irrefl _)
      simp [h1, h2]

/-- **The operator of a four-index tensor**: `⟨e_p, opOf T e_q⟩ = T q p`. -/
noncomputable def opOf (T : Fin n → Fin n → Fin n → Fin n → ℝ) : Biv n →ₗ[ℝ] Biv n :=
  ∑ p : Pairs n, ∑ q : Pairs n, T q.1.1 q.1.2 p.1.1 p.1.2 • E1 p q

theorem inner_opOf (T : Fin n → Fin n → Fin n → Fin n → ℝ) (x y : Biv n) :
    inner ℝ x (opOf T y) = ∑ p : Pairs n, ∑ q : Pairs n, T q.1.1 q.1.2 p.1.1 p.1.2 * (x p * y q) := by
  simp only [opOf, LinearMap.sum_apply, LinearMap.smul_apply, E1_apply, inner_sum, real_inner_smul_right, ep,
    EuclideanSpace.inner_single_right, EuclideanSpace.inner_single_left]
  refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
  simp only [conj_trivial]; ring

theorem opOf_mem {T : Fin n → Fin n → Fin n → Fin n → ℝ} (hT : IsCurv T) : opOf T ∈ symSub n := fun x y => by
  rw [real_inner_comm, inner_opOf, inner_opOf, Finset.sum_comm]
  refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
  rw [hT.pair]; ring

theorem compOf_opOf {T : Fin n → Fin n → Fin n → Fin n → ℝ} (hT : IsCurv T) (i j k l : Fin n) :
    compOf (opOf T) i j k l = T i j k l := by
  unfold compOf
  rw [inner_opOf]
  have e1 : ∀ p : Pairs n, ∑ q : Pairs n, T q.1.1 q.1.2 p.1.1 p.1.2 * (coords (phi k l) p * coords (phi i j) q) =
      coords (phi k l) p * T i j p.1.1 p.1.2 := fun p => by
    rw [← sum_coords_phi (f := fun a b => T a b p.1.1 p.1.2) (fun a b => hT.left a b _ _) i j, Finset.mul_sum]
    refine Finset.sum_congr rfl fun q _ => ?_; ring
  simp_rw [e1]
  exact sum_coords_phi (f := fun a b => T i j a b) (fun a b => hT.right i j a b) k l

/-! ## The `Λ⁴` preimages -/

/-- The elementary bivector `e_a ∧ e_b` as an antisymmetric function. -/
def pairF (a b : Fin n) (x y : Fin n) : ℝ := (if x = a ∧ y = b then 1 else 0) - (if x = b ∧ y = a then 1 else 0)

theorem pairF_swap (a b x y : Fin n) : pairF a b y x = -pairF a b x y := by
  unfold pairF
  have e1 : (y = a ∧ x = b) ↔ (x = b ∧ y = a) := and_comm
  have e2 : (y = b ∧ x = a) ↔ (x = a ∧ y = b) := and_comm
  simp only [e1, e2]; ring

theorem pairF_lt {a b x y : Fin n} (hab : a < b) (hxy : x < y) : pairF a b x y = if x = a ∧ y = b then 1 else 0 := by
  unfold pairF
  rw [if_neg (show ¬(x = b ∧ y = a) from fun h => by obtain ⟨rfl, rfl⟩ := h; exact lt_asymm hab hxy), sub_zero]

theorem pairF_gt {a b x y : Fin n} (hab : a < b) (hxy : y < x) : pairF a b x y = -(if y = a ∧ x = b then 1 else 0) := by
  rw [show pairF a b x y = -pairF a b y x by rw [pairF_swap], pairF_lt hab hxy]

/-- **The `Λ⁴` preimage**: `(e_a ∧ e_b) ⊙ (e_c ∧ e_d)`. -/
def T4 (a b c d : Fin n) (i j k l : Fin n) : ℝ := pairF a b i j * pairF c d k l + pairF c d i j * pairF a b k l

theorem isCurv_T4 (a b c d : Fin n) : IsCurv (T4 a b c d) where
  left i j k l := by unfold T4; rw [pairF_swap a b j i, pairF_swap c d j i]; ring
  right i j k l := by unfold T4; rw [pairF_swap a b l k, pairF_swap c d l k]; ring
  pair i j k l := by unfold T4; ring

theorem pairF_mul_eq_zero {a b c d : Fin n} (hac : a ≠ c) (had : a ≠ d) (hbc : b ≠ c) (hbd : b ≠ d) (x y k : Fin n) :
    pairF a b x k * pairF c d y k = 0 := by
  by_cases hk : k = a ∨ k = b
  · have : pairF c d y k = 0 := by
      unfold pairF
      rcases hk with rfl | rfl <;> simp [hac, had, hbc, hbd]
    rw [this, mul_zero]
  · have : pairF a b x k = 0 := by
      unfold pairF; push Not at hk; simp [hk.1, hk.2]
    rw [this, zero_mul]

theorem ric_T4 {a b c d : Fin n} (hac : a ≠ c) (had : a ≠ d) (hbc : b ≠ c) (hbd : b ≠ d) (x y : Fin n) :
    ∑ k, T4 a b c d x k y k = 0 := by
  unfold T4
  refine Finset.sum_eq_zero fun k _ => ?_
  rw [pairF_mul_eq_zero hac had hbc hbd, mul_comm (pairF c d x k),
    pairF_mul_eq_zero hac had hbc hbd, add_zero]

theorem alt4_T4 {a b c d i j k l : Fin n} (hab : a < b) (hbc : b < c) (hcd : c < d) (hij : i < j) (hjk : j < k)
    (hkl : k < l) : alt4 (T4 a b c d) i j k l = if i = a ∧ j = b ∧ k = c ∧ l = d then 1 / 3 else 0 := by
  unfold alt4 T4
  have hik := hij.trans hjk; have hjl := hjk.trans hkl; have hil := hik.trans hkl
  rw [pairF_lt hab hij, pairF_lt hcd hkl, pairF_lt hcd hij, pairF_lt hab hkl, pairF_lt hab hik, pairF_gt hcd hjl,
    pairF_lt hcd hik, pairF_gt hab hjl, pairF_lt hab hil, pairF_lt hcd hjk, pairF_lt hcd hil, pairF_lt hab hjk]
  have z : ∀ (P Q : Prop) [Decidable P] [Decidable Q], ¬(P ∧ Q) →
      (if P then (1 : ℝ) else 0) * (if Q then 1 else 0) = 0 := fun P Q _ _ h => by
    by_cases hP : P <;> by_cases hQ : Q <;> simp_all
  have t2 := z (i = c ∧ j = d) (k = a ∧ l = b) (fun ⟨⟨_, h2⟩, ⟨h3, _⟩⟩ => by subst h2 h3; order)
  have t3 := z (i = a ∧ k = b) (j = c ∧ l = d) (fun ⟨⟨_, h2⟩, ⟨h3, _⟩⟩ => by subst h2 h3; order)
  have t4 := z (i = c ∧ k = d) (j = a ∧ l = b) (fun ⟨⟨h1, _⟩, ⟨h3, _⟩⟩ => by subst h1 h3; order)
  have t5 := z (i = a ∧ l = b) (j = c ∧ k = d) (fun ⟨⟨_, h2⟩, ⟨h3, _⟩⟩ => by subst h2 h3; order)
  have t6 := z (i = c ∧ l = d) (j = a ∧ k = b) (fun ⟨⟨h1, _⟩, ⟨h3, _⟩⟩ => by subst h1 h3; order)
  simp only [mul_neg, t2, t3, t4, t5, t6, neg_zero, add_zero]
  by_cases hm : i = a ∧ j = b ∧ k = c ∧ l = d
  · obtain ⟨rfl, rfl, rfl, rfl⟩ := hm; simp
  · rw [if_neg hm, z (i = a ∧ j = b) (k = c ∧ l = d) (fun ⟨⟨h1, h2⟩, ⟨h3, h4⟩⟩ => hm ⟨h1, h2, h3, h4⟩)]; ring

/-! ## The Ricci preimages: Kulkarni–Nomizu -/

/-- The Kronecker delta. -/
def dlt (a b : Fin n) : ℝ := if a = b then 1 else 0

theorem dlt_comm (a b : Fin n) : dlt a b = dlt b a := by unfold dlt; simp only [eq_comm]

/-- **The Kulkarni–Nomizu product `h ⊙ g`.** -/
def KN (h : Fin n → Fin n → ℝ) (i j k l : Fin n) : ℝ :=
  h i k * dlt j l + h j l * dlt i k - h i l * dlt j k - h j k * dlt i l

section KNsec
variable {h : Fin n → Fin n → ℝ} (hh : ∀ a b, h b a = h a b)
include hh

theorem isCurv_KN : IsCurv (KN h) where
  left i j k l := by unfold KN; ring
  right i j k l := by unfold KN; ring
  pair i j k l := by unfold KN; rw [hh k i, hh l j, hh k j, hh l i, dlt_comm l j, dlt_comm k i, dlt_comm l i, dlt_comm k j]; ring

theorem alt4_KN : alt4 (KN h) = 0 := by
  funext i j k l
  simp only [alt4, KN, Pi.zero_apply]
  rw [dlt_comm l j, hh l j, dlt_comm k j, hh k j, dlt_comm l k, hh l k]; ring

omit hh in
theorem ric_KN (a b : Fin n) :
    ∑ k, KN h a k b k = ((n : ℝ) - 2) * h a b + (∑ k, h k k) * dlt a b := by
  simp only [KN, Finset.sum_add_distrib, Finset.sum_sub_distrib, dlt, mul_ite, mul_one, mul_zero,
    Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true, Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul]
  by_cases hab : a = b <;> simp [hab] <;> ring

end KNsec

/-! ## The symmetric operators are spanned by the `symOp` -/

theorem ext_ep {X Y : Biv n →ₗ[ℝ] Biv n} (h : ∀ a b, inner ℝ (ep a) (X (ep b)) = inner ℝ (ep a) (Y (ep b))) : X = Y :=
  (EuclideanSpace.basisFun (Pairs n) ℝ).toBasis.ext fun b =>
    InnerProductSpace.ext_inner_left_basis (EuclideanSpace.basisFun (Pairs n) ℝ).toBasis fun a => by
      simpa [ep] using h a b

theorem symSub_eq_sum {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric) :
    H = ∑ s : Sym2 (Pairs n), (inner ℝ (ep (Quot.out s).1) (H (ep (Quot.out s).2)) /
      (if (Quot.out s).1 = (Quot.out s).2 then 2 else 1)) • symOp s := by
  refine ext_ep fun a b => ?_
  simp only [LinearMap.sum_apply, LinearMap.smul_apply, inner_sum, real_inner_smul_right, entry_symOp,
    mul_ite, mul_zero, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  have hrep : s((Quot.out s(a, b)).1, (Quot.out s(a, b)).2) = s(a, b) := Quot.out_eq _
  rw [Sym2.eq_iff] at hrep
  rcases hrep with ⟨e1, e2⟩ | ⟨e1, e2⟩
  · rw [e1, e2]; split_ifs <;> field_simp
  · rw [e1, e2, ← hH, real_inner_comm]
    by_cases hab : a = b
    · subst hab; simp
    · rw [if_neg (Ne.symm hab), if_neg hab]; field_simp

theorem finrank_symSub_le : finrank ℝ (symSub n) ≤ (Fintype.card (Pairs n) + 1).choose 2 := by
  set v : Sym2 (Pairs n) → symSub n := fun s => ⟨symOp s, symOp_mem s⟩
  have hspan : Submodule.span ℝ (Set.range v) = ⊤ := by
    refine eq_top_iff.2 fun H _ => ?_
    have e : H = ∑ s : Sym2 (Pairs n), (inner ℝ (ep (Quot.out s).1) ((H : Biv n →ₗ[ℝ] Biv n) (ep (Quot.out s).2)) /
        (if (Quot.out s).1 = (Quot.out s).2 then 2 else 1)) • v s :=
      Subtype.ext (by rw [Submodule.coe_sum]; simpa [v] using symSub_eq_sum H.2)
    rw [e]
    exact Submodule.sum_mem _ fun s _ => Submodule.smul_mem _ _ (Submodule.subset_span ⟨s, rfl⟩)
  have := finrank_range_le_card (R := ℝ) v
  rwa [Set.finrank, hspan, finrank_top, Sym2.card] at this

/-! ## The constraint map is onto -/

theorem ric_opOf {T : Fin n → Fin n → Fin n → Fin n → ℝ} (hT : IsCurv T) (a b : Fin n) :
    ric (opOf T) a b = ∑ k, T a k b k := by
  unfold ric; simp only [compOf_opOf hT]

/-- **The padded competitor hits the trace direction**: `consMap u = (0, 0, 1)`. -/
theorem consMap_uOp (hn : 4 ≤ n) : consMap (uOp (n := n)) = (0, 0, 1) := by
  have hW := isWeyl2_restrict (HamiltonsCubic.CP2Real.Wc_weyl hn)
  have hc : compOf (uOp (n := n)) = compOf (opB (u2 hn)) := by rw [opB_u2]
  refine Prod.ext (funext fun s => ?_) (Prod.ext (funext fun s' => ?_) ?_)
  · simp only [consMap, LinearMap.coe_mk, AddHom.coe_mk, altTup, hc, Pi.zero_apply]
    exact congrFun (congrFun (congrFun (congrFun (alt4_opB_eq_zero hW) _) _) _) _
  · simp only [consMap, LinearMap.coe_mk, AddHom.coe_mk, ric, hc, compOf_opB, Pi.zero_apply]
    exact hW.ric _ _
  · simp only [consMap, LinearMap.coe_mk, AddHom.coe_mk]
    rw [show (uOp (n := n)) ∘ₗ uOp = uOp ∘ₗ rankSum lam6 vec from rfl, trace_comp_rankSum]
    simp only [uOp, rankSum_vec hn, real_inner_smul_right, orthonormal_iff_ite.mp (vec_orthonormal hn), if_true,
      mul_one, Fin.sum_univ_six]
    have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
    have h6' : Real.sqrt 6 * Real.sqrt 6 = 6 := Real.mul_self_sqrt (by norm_num)
    have hne : Real.sqrt 6 ≠ 0 := by positivity
    simp [lam6, neg_div]
    field_simp
    linarith

theorem mem_range_T4 (s : Q4 n) :
    ∃ z : ℝ, (Pi.single s 1, 0, z) ∈ LinearMap.range (consMap (n := n) ∘ₗ (symSub n).subtype) := by
  set e := s.1.orderEmbOfFin s.2
  have h01 : e 0 < e 1 := e.strictMono (by decide)
  have h12 : e 1 < e 2 := e.strictMono (by decide)
  have h23 : e 2 < e 3 := e.strictMono (by decide)
  have hT := isCurv_T4 (e 0) (e 1) (e 2) (e 3)
  have hc : ∀ i j k l, compOf ((3 : ℝ) • opOf (T4 (e 0) (e 1) (e 2) (e 3))) i j k l =
      3 * T4 (e 0) (e 1) (e 2) (e 3) i j k l := fun i j k l => by rw [compOf_smul, compOf_opOf hT]
  refine ⟨(consMap ((3 : ℝ) • opOf (T4 (e 0) (e 1) (e 2) (e 3)))).2.2,
    ⟨⟨(3 : ℝ) • opOf (T4 (e 0) (e 1) (e 2) (e 3)), (symSub n).smul_mem _ (opOf_mem hT)⟩, ?_⟩⟩
  refine Prod.ext (funext fun s' => ?_) (Prod.ext (funext fun y => ?_) rfl)
  · simp only [LinearMap.comp_apply, Submodule.subtype_apply, consMap, LinearMap.coe_mk, AddHom.coe_mk, altTup]
    have ha : ∀ i j k l, alt4 (compOf ((3 : ℝ) • opOf (T4 (e 0) (e 1) (e 2) (e 3)))) i j k l =
        3 * alt4 (T4 (e 0) (e 1) (e 2) (e 3)) i j k l := fun i j k l => by simp only [alt4, hc]; ring
    rw [ha]
    set e' := s'.1.orderEmbOfFin s'.2
    rw [alt4_T4 h01 h12 h23 (e'.strictMono (show (0 : Fin 4) < 1 by decide))
      (e'.strictMono (show (1 : Fin 4) < 2 by decide)) (e'.strictMono (show (2 : Fin 4) < 3 by decide))]
    by_cases hs : s' = s
    · subst hs; rw [if_pos ⟨rfl, rfl, rfl, rfl⟩, Pi.single_eq_same]; ring
    · rw [Pi.single_apply, if_neg hs, if_neg]
      · ring
      rintro ⟨h0, h1, h2, h3⟩
      apply hs
      have hee : (e' : Fin 4 → Fin n) = e := by
        funext i; fin_cases i <;> assumption
      apply Subtype.ext
      rw [← Finset.coe_inj, ← Finset.range_orderEmbOfFin s'.1 s'.2, ← Finset.range_orderEmbOfFin s.1 s.2]
      exact congrArg Set.range hee
  · simp only [LinearMap.comp_apply, Submodule.subtype_apply, consMap, LinearMap.coe_mk, AddHom.coe_mk, ric, hc,
      ← Finset.mul_sum, Pi.zero_apply]
    rw [ric_T4 (h01.trans h12).ne (h01.trans (h12.trans h23)).ne h12.ne (h12.trans h23).ne, mul_zero]

theorem mem_range_KN (hn : 4 ≤ n) (y : Sym2 (Fin n) → ℝ) :
    ∃ z : ℝ, (0, y, z) ∈ LinearMap.range (consMap (n := n) ∘ₗ (symSub n).subtype) := by
  set m : Fin n → Fin n → ℝ := fun a b => y s(a, b)
  have hm : ∀ a b, m b a = m a b := fun a b => by simp only [m, Sym2.eq_swap]
  have h4 : (4 : ℝ) ≤ n := by exact_mod_cast hn
  have hn2 : ((n : ℝ) - 2) ≠ 0 := by linarith
  have hn22 : (2 * (n : ℝ) - 2) ≠ 0 := by linarith
  set τ : ℝ := (∑ k, m k k) / (2 * (n : ℝ) - 2)
  set h : Fin n → Fin n → ℝ := fun a b => (m a b - τ * dlt a b) / ((n : ℝ) - 2)
  have hh : ∀ a b, h b a = h a b := fun a b => by simp only [h, hm a b, dlt_comm b a]
  have htr : ∑ k, h k k = τ := by
    have e1 : ∑ k, h k k = ((∑ k, m k k) - n * τ) / ((n : ℝ) - 2) := by
      simp only [h, dlt, if_true, mul_one, ← Finset.sum_div, Finset.sum_sub_distrib, Finset.sum_const,
        Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
    rw [e1, div_eq_iff hn2]
    have hn1 : (-1 + (n : ℝ)) ≠ 0 := by linarith
    have hn1' : ((n : ℝ) - 1) ≠ 0 := by linarith
    simp only [τ, show (2 * (n : ℝ) - 2) = 2 * ((n : ℝ) - 1) by ring]
    field_simp; ring
  have hT := isCurv_KN hh
  refine ⟨(consMap (opOf (KN h))).2.2, ⟨⟨opOf (KN h), opOf_mem hT⟩, ?_⟩⟩
  refine Prod.ext (funext fun s => ?_) (Prod.ext (funext fun s' => ?_) rfl)
  · have hc : compOf (opOf (KN h)) = KN h := by funext i j k l; exact compOf_opOf hT i j k l
    simp only [LinearMap.comp_apply, Submodule.subtype_apply, consMap, LinearMap.coe_mk, AddHom.coe_mk, altTup, hc,
      alt4_KN hh, Pi.zero_apply]
  · simp only [LinearMap.comp_apply, Submodule.subtype_apply, consMap, LinearMap.coe_mk, AddHom.coe_mk, ric_opOf hT,
      ric_KN, htr]
    have hrep : s((Quot.out s').1, (Quot.out s').2) = s' := Quot.out_eq _
    simp only [h]
    field_simp
    rw [show m (Quot.out s').1 (Quot.out s').2 = y s' by simp only [m, hrep]]
    ring

/-- **The constraint map is onto its target** on the symmetric operators, for `n ≥ 4`. -/
theorem consMap_range (hn : 4 ≤ n) : LinearMap.range (consMap (n := n) ∘ₗ (symSub n).subtype) = ⊤ := by
  set R := LinearMap.range (consMap (n := n) ∘ₗ (symSub n).subtype)
  have hU : ((0 : Q4 n → ℝ), (0 : Sym2 (Fin n) → ℝ), (1 : ℝ)) ∈ R :=
    ⟨⟨uOp, uOp_isSymmetric⟩, by simpa using consMap_uOp hn⟩
  have hA : ∀ s : Q4 n, ((Pi.single s 1 : Q4 n → ℝ), (0 : Sym2 (Fin n) → ℝ), (0 : ℝ)) ∈ R := fun s => by
    obtain ⟨z, hz⟩ := mem_range_T4 s
    convert R.sub_mem hz (R.smul_mem z hU) using 1
    refine Prod.ext ?_ (Prod.ext ?_ ?_) <;> simp
  have hY : ∀ y : Sym2 (Fin n) → ℝ, ((0 : Q4 n → ℝ), y, (0 : ℝ)) ∈ R := fun y => by
    obtain ⟨z, hz⟩ := mem_range_KN hn y
    convert R.sub_mem hz (R.smul_mem z hU) using 1
    refine Prod.ext ?_ (Prod.ext ?_ ?_) <;> simp
  refine eq_top_iff.2 fun ⟨x, y, z⟩ _ => ?_
  have e : ((x, y, z) : (Q4 n → ℝ) × (Sym2 (Fin n) → ℝ) × ℝ) =
      ∑ s, x s • ((Pi.single s 1 : Q4 n → ℝ), (0 : Sym2 (Fin n) → ℝ), (0 : ℝ)) + ((0 : Q4 n → ℝ), y, (0 : ℝ)) +
        z • ((0 : Q4 n → ℝ), (0 : Sym2 (Fin n) → ℝ), (1 : ℝ)) := by
    refine Prod.ext ?_ (Prod.ext ?_ ?_)
    · funext s'; simp [Prod.fst_sum, Finset.sum_apply, Pi.single_apply]
    · funext s'; simp [Prod.snd_sum]
    · simp [Prod.snd_sum]
  rw [e]
  exact R.add_mem (R.add_mem (R.sum_mem fun s _ => R.smul_mem _ (hA s)) (hY y)) (R.smul_mem z hU)

/-- The tangent Weyl operators are exactly the symmetric operators the constraint map kills. -/
theorem consMap_of_weylT {H : Biv n →ₗ[ℝ] Biv n} (hH : H ∈ weylT n) : consMap H = 0 := by
  obtain ⟨-, hA, hR, hT⟩ := hH
  refine Prod.ext (funext fun s => ?_) (Prod.ext (funext fun s' => ?_) ?_)
  · simp only [consMap, LinearMap.coe_mk, AddHom.coe_mk, altTup, hA, Pi.zero_apply, Prod.fst_zero]
  · simp only [consMap, LinearMap.coe_mk, AddHom.coe_mk, hR, Pi.zero_apply, Prod.snd_zero, Prod.fst_zero]
  · simp only [consMap, LinearMap.coe_mk, AddHom.coe_mk, hT, Prod.snd_zero]

/-- **`dim 𝒲ₙ ∩ T_uS ≤ N(N+1)/2 − C(n,4) − n(n+1)/2 − 1`** for `n ≥ 4`. -/
theorem finrank_weylT_le (hn : 4 ≤ n) :
    finrank ℝ (weylT n) + (n.choose 4 + (n + 1).choose 2 + 1) ≤ (Fintype.card (Pairs n) + 1).choose 2 := by
  set C := consMap (n := n) ∘ₗ (symSub n).subtype
  have hrn := LinearMap.finrank_range_add_finrank_ker C
  rw [consMap_range hn, finrank_top, finrank_consTarget] at hrn
  have hle : weylT n ≤ (LinearMap.ker C).map (symSub n).subtype := fun H hH =>
    ⟨⟨H, hH.1⟩, by simp [C, consMap_of_weylT hH], rfl⟩
  have hk := Submodule.finrank_mono hle
  rw [Submodule.finrank_map_subtype_eq] at hk
  have := finrank_symSub_le (n := n)
  omega

/-- **`dim 𝒲₁₂ ∩ T_uS = 1637`**, the record's dimension. -/
theorem finrank_weylT_12_eq : finrank ℝ (weylT 12) = 1637 := by
  have h1 := finrank_weylT_12
  have h2 := finrank_weylT_le (n := 12) (by norm_num)
  rw [card_pairs12] at h2
  norm_num [Nat.choose] at h2
  omega

end HamiltonsCubic.L17Deriv
