import Mathlib
import HamiltonsCubic.Results.L240SlotBasis

/-!
# L240, piece (a): the orthogonal normal form of a skew matrix, and Ky Fan at every skew `X`

Piece (b) ([L240SlotBasis.lean](L240SlotBasis.lean), `slot_kyFan`) proves Ky Fan for `-ad_X²`
at `X = N.X` in normal form. This file carries it to every skew `X` conjugate to a normal form
by an orthogonal matrix: `kyFan_conj`. Conjugation preserves skewness (`isSkew_conj`), the
inner product `inner2` (`inner2_conj`) and the bracket (`br_conj`), so the orthonormal family
`Oᵀ yⱼ O` meets piece (b)'s hypotheses with the same Rayleigh sum.

**Step A1** (`skew_dot`, `pair_*`): the pair step in coordinates. **Step A2** (`exists_pair`): a
nonzero skew-adjoint `T` has a unit `e` with `T(Te) = -s² e`, `s > 0`, from the spectral theorem
for the symmetric `-T²`. **Step A3** (`skew_decomp`): the normal form on an abstract finite-dimensional
real inner product space, by strong induction on the dimension, splitting off `(e, s⁻¹Te)` and
recursing on its `T`-invariant orthogonal complement.

**Step A4** (`eucl`, `eucl_skew`, **`skew_normal_form`**): `skew_decomp` at `EuclideanSpace ℝ ι`,
read back as a `NormalForm` and the orthogonal matrix whose columns are the basis. **Piece (a) is
done**, and with `kyFan_conj` Ky Fan holds at every real skew matrix.
-/

open HamiltonsCubic.RealLayer Matrix

namespace HamiltonsCubic.L240NormalForm

open HamiltonsCubic.L240SlotBasis

set_option linter.unusedSectionVars false

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem isSkew_conj {O Y : Matrix ι ι ℝ} (hY : IsSkew Y) : IsSkew (Oᵀ * Y * O) := by
  unfold IsSkew at *
  rw [transpose_mul, transpose_mul, transpose_transpose, hY]
  simp [Matrix.mul_assoc]

theorem inner2_conj {O : Matrix ι ι ℝ} (hO : O * Oᵀ = 1) (A B : Matrix ι ι ℝ) :
    inner2 (Oᵀ * A * O) (Oᵀ * B * O) = inner2 A B := by
  unfold inner2
  congr 1
  have : (Oᵀ * A * O)ᵀ * (Oᵀ * B * O) = Oᵀ * (Aᵀ * B) * O := by
    rw [transpose_mul, transpose_mul, transpose_transpose]
    calc Oᵀ * (Aᵀ * O) * (Oᵀ * B * O) = Oᵀ * Aᵀ * (O * Oᵀ) * B * O := by
          simp only [Matrix.mul_assoc]
      _ = Oᵀ * (Aᵀ * B) * O := by rw [hO]; simp only [Matrix.mul_one, Matrix.mul_assoc]
  rw [this, Matrix.trace_mul_comm, ← Matrix.mul_assoc, hO, Matrix.one_mul]

theorem br_conj {O : Matrix ι ι ℝ} (hO : O * Oᵀ = 1) (X Y : Matrix ι ι ℝ) :
    br (Oᵀ * X * O) (Oᵀ * Y * O) = Oᵀ * br X Y * O := by
  unfold br
  have h1 : Oᵀ * X * O * (Oᵀ * Y * O) = Oᵀ * (X * Y) * O := by
    calc Oᵀ * X * O * (Oᵀ * Y * O) = Oᵀ * X * (O * Oᵀ) * Y * O := by simp only [Matrix.mul_assoc]
      _ = Oᵀ * (X * Y) * O := by rw [hO]; simp only [Matrix.mul_one, Matrix.mul_assoc]
  have h2 : Oᵀ * Y * O * (Oᵀ * X * O) = Oᵀ * (Y * X) * O := by
    calc Oᵀ * Y * O * (Oᵀ * X * O) = Oᵀ * Y * (O * Oᵀ) * X * O := by simp only [Matrix.mul_assoc]
      _ = Oᵀ * (Y * X) * O := by rw [hO]; simp only [Matrix.mul_one, Matrix.mul_assoc]
  rw [h1, h2, Matrix.mul_sub, Matrix.sub_mul]

section pairStep
/-! **Step A1, the pair step.** For skew `X` and a unit `e` with `X(Xe) = -s² e`, `s > 0`, the
vector `f = s⁻¹ Xe` completes `e` to an orthonormal pair with `Xe = s f`, `Xf = -s e`, and the
orthogonal complement of `{e, f}` is `X`-invariant. -/

theorem skew_dot {X : Matrix ι ι ℝ} (hX : IsSkew X) (v w : ι → ℝ) :
    v ⬝ᵥ (X *ᵥ w) = -((X *ᵥ v) ⬝ᵥ w) := by
  rw [Matrix.dotProduct_mulVec, ← Matrix.mulVec_transpose, hX, Matrix.neg_mulVec,
    neg_dotProduct]

theorem skew_dot_self {X : Matrix ι ι ℝ} (hX : IsSkew X) (v : ι → ℝ) :
    v ⬝ᵥ (X *ᵥ v) = 0 := by
  have h := skew_dot hX v v
  rw [dotProduct_comm (X *ᵥ v) v] at h
  linarith

variable {X : Matrix ι ι ℝ} {e : ι → ℝ} {s : ℝ}

theorem pair_f_unit (hX : IsSkew X) (he : e ⬝ᵥ e = 1) (hs : 0 < s)
    (hXX : X *ᵥ (X *ᵥ e) = -(s ^ 2) • e) :
    (s⁻¹ • X *ᵥ e) ⬝ᵥ (s⁻¹ • X *ᵥ e) = 1 := by
  have h1 : (X *ᵥ e) ⬝ᵥ (X *ᵥ e) = s ^ 2 := by
    have := skew_dot hX (X *ᵥ e) e
    rw [dotProduct_comm (X *ᵥ (X *ᵥ e)) e, hXX, dotProduct_smul, he] at this
    simp at this; linarith
  rw [smul_dotProduct, dotProduct_smul, h1, smul_eq_mul, smul_eq_mul]
  field_simp

theorem pair_ef_orth (hX : IsSkew X) : e ⬝ᵥ (s⁻¹ • X *ᵥ e) = 0 := by
  rw [dotProduct_smul, skew_dot_self hX, smul_zero]

theorem pair_Xf (hs : 0 < s) (hXX : X *ᵥ (X *ᵥ e) = -(s ^ 2) • e) :
    X *ᵥ (s⁻¹ • X *ᵥ e) = -s • e := by
  rw [Matrix.mulVec_smul, hXX, smul_smul]
  congr 1; field_simp

theorem pair_Xe (hs : 0 < s) : X *ᵥ e = s • (s⁻¹ • X *ᵥ e) := by
  rw [smul_smul, mul_inv_cancel₀ hs.ne', one_smul]

/-- The complement of an `X`-invariant pair is `X`-invariant. -/
theorem pair_compl_invariant (hX : IsSkew X) (hs : 0 < s)
    (hXX : X *ᵥ (X *ᵥ e) = -(s ^ 2) • e) {w : ι → ℝ}
    (hwe : e ⬝ᵥ w = 0) (hwf : (s⁻¹ • X *ᵥ e) ⬝ᵥ w = 0) :
    e ⬝ᵥ (X *ᵥ w) = 0 ∧ (s⁻¹ • X *ᵥ e) ⬝ᵥ (X *ᵥ w) = 0 := by
  constructor
  · rw [skew_dot hX, pair_Xe hs, smul_dotProduct, hwf, smul_zero, neg_zero]
  · rw [skew_dot hX, pair_Xf hs hXX, smul_dotProduct, hwe, smul_zero, neg_zero]

end pairStep

section abstractPair
/-! **Step A2, a pair exists.** On a finite-dimensional real inner product space, a nonzero
skew-adjoint `T` has a unit `e` and `s > 0` with `T(Te) = -s² e`: an eigenvector of the
symmetric `-T²` for a nonzero eigenvalue, which is `‖Te‖² > 0`. -/

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

theorem negSq_isSymmetric (T : E →ₗ[ℝ] E) (hT : ∀ x y, inner ℝ (T x) y = -inner ℝ x (T y)) :
    (-(T ∘ₗ T)).IsSymmetric := by
  intro x y
  simp only [LinearMap.neg_apply, LinearMap.comp_apply, inner_neg_left, inner_neg_right]
  rw [hT (T x) y, hT x (T y)]; ring

theorem inner_negSq_self (T : E →ₗ[ℝ] E) (hT : ∀ x y, inner ℝ (T x) y = -inner ℝ x (T y))
    (x : E) : inner ℝ x ((-(T ∘ₗ T)) x) = ‖T x‖ ^ 2 := by
  simp only [LinearMap.neg_apply, LinearMap.comp_apply, inner_neg_right]
  rw [← real_inner_self_eq_norm_sq, hT x (T x)]

theorem exists_pair (T : E →ₗ[ℝ] E) (hT : ∀ x y, inner ℝ (T x) y = -inner ℝ x (T y))
    (h : T ≠ 0) : ∃ e : E, ‖e‖ = 1 ∧ ∃ s : ℝ, 0 < s ∧ T (T e) = -(s ^ 2) • e := by
  have hS := negSq_isSymmetric T hT
  set b := hS.eigenvectorBasis rfl
  have hb : ∀ i, (-(T ∘ₗ T)) (b i) = (hS.eigenvalues rfl i) • b i := fun i => by
    simpa using hS.apply_eigenvectorBasis (rfl : Module.finrank ℝ E = _) i
  by_cases hall : ∀ i, hS.eigenvalues rfl i = 0
  · exfalso; apply h
    have hS0 : -(T ∘ₗ T) = 0 := by
      apply b.toBasis.ext; intro i
      simp only [OrthonormalBasis.coe_toBasis, LinearMap.zero_apply]
      rw [hb i, hall i]; simp
    ext x
    have h2 := inner_negSq_self T hT x
    rw [hS0, LinearMap.zero_apply, inner_zero_right] at h2
    have : ‖T x‖ = 0 := by nlinarith [norm_nonneg (T x)]
    simpa using this
  · push Not at hall
    obtain ⟨i, hi⟩ := hall
    set μ := hS.eigenvalues rfl i
    have he : ‖b i‖ = 1 := b.orthonormal.1 i
    have hμ : μ = ‖T (b i)‖ ^ 2 := by
      rw [← inner_negSq_self T hT, hb i, inner_smul_right, real_inner_self_eq_norm_sq, he]
      ring
    have hμpos : 0 < μ := lt_of_le_of_ne (by rw [hμ]; positivity) (Ne.symm hi)
    refine ⟨b i, he, Real.sqrt μ, Real.sqrt_pos.mpr hμpos, ?_⟩
    rw [Real.sq_sqrt hμpos.le]
    have h3 : T (T (b i)) = -(μ • b i) := by
      rw [← hb i]; simp
    rw [h3, neg_smul]


/-- The pair `(e, s⁻¹ Te)` in the abstract setting. -/
theorem pair_facts (T : E →ₗ[ℝ] E) (hT : ∀ x y, inner ℝ (T x) y = -inner ℝ x (T y)) {e : E}
    (he : ‖e‖ = 1) {s : ℝ} (hs : 0 < s) (hXX : T (T e) = -(s ^ 2) • e) :
    ‖s⁻¹ • T e‖ = 1 ∧ inner ℝ e (s⁻¹ • T e) = 0 ∧ T e = s • (s⁻¹ • T e) ∧
      T (s⁻¹ • T e) = -s • e := by
  have hTe : ‖T e‖ ^ 2 = s ^ 2 := by
    rw [← inner_negSq_self T hT e]
    simp only [LinearMap.neg_apply, LinearMap.comp_apply, hXX]
    rw [neg_smul, neg_neg, inner_smul_right, real_inner_self_eq_norm_sq, he]; ring
  have hTe' : ‖T e‖ = s := by
    have := abs_eq_abs.mpr (Or.inl rfl : ‖T e‖ = ‖T e‖ ∨ _)
    nlinarith [norm_nonneg (T e), sq_nonneg (‖T e‖ - s), sq_nonneg (‖T e‖ + s)]
  refine ⟨?_, ?_, ?_, ?_⟩
  · rw [norm_smul, hTe', Real.norm_eq_abs, abs_inv, abs_of_pos hs, inv_mul_cancel₀ hs.ne']
  · rw [inner_smul_right]
    have h0 : inner ℝ e (T e) = 0 := by
      have := hT e e; rw [real_inner_comm] at this; linarith
    rw [h0, mul_zero]
  · rw [smul_smul, mul_inv_cancel₀ hs.ne', one_smul]
  · rw [LinearMap.map_smul, hXX, smul_smul]; congr 1; field_simp

/-- **Step A3, the normal form on an abstract space**, by strong induction on the dimension: an
orthonormal basis on `κ ⊕ κ ⊕ μ` with `T eₖ = sₖ fₖ`, `T fₖ = -sₖ eₖ`, `T gⱼ = 0`. -/
theorem skew_decomp (d : ℕ) : ∀ (E : Type*) [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E], Module.finrank ℝ E = d → ∀ T : E →ₗ[ℝ] E,
    (∀ x y, inner ℝ (T x) y = -inner ℝ x (T y)) →
    ∃ (κ μ : Type) (_ : Fintype κ) (_ : Fintype μ) (b : OrthonormalBasis (κ ⊕ κ ⊕ μ) ℝ E)
      (s : κ → ℝ), (∀ c, T (b (.inl c)) = s c • b (.inr (.inl c))) ∧
      (∀ c, T (b (.inr (.inl c))) = -s c • b (.inl c)) ∧ (∀ j, T (b (.inr (.inr j))) = 0) := by
  induction d using Nat.strong_induction_on with
  | _ d ih =>
  intro E _ _ _ hd T hT
  by_cases hT0 : T = 0
  · subst hT0
    let eqv : Fin (Module.finrank ℝ E) ≃ (Empty ⊕ Empty ⊕ Fin (Module.finrank ℝ E)) :=
      ((Equiv.emptySum Empty _).trans (Equiv.emptySum Empty _)).symm
    exact ⟨Empty, Fin (Module.finrank ℝ E), inferInstance, inferInstance,
      (stdOrthonormalBasis ℝ E).reindex eqv, Empty.elim, fun c => c.elim, fun c => c.elim,
      fun _ => rfl⟩
  obtain ⟨e, he, s, hs, hXX⟩ := exists_pair T hT hT0
  obtain ⟨hf, hef, hTe, hTf⟩ := pair_facts T hT he hs hXX
  set f := s⁻¹ • T e with hfdef
  have he0 : e ≠ 0 := by intro h; rw [h, norm_zero] at he; exact zero_ne_one he
  have hf0 : f ≠ 0 := by intro h; rw [h, norm_zero] at hf; exact zero_ne_one hf
  set K : Submodule ℝ E := (ℝ ∙ e) ⊔ (ℝ ∙ f) with hK
  set V : Submodule ℝ E := Kᗮ with hV
  have memV : ∀ v, v ∈ V ↔ inner ℝ e v = 0 ∧ inner ℝ f v = 0 := by
    intro v
    rw [hV, hK, ← Submodule.inf_orthogonal, Submodule.mem_inf,
      Submodule.mem_orthogonal_singleton_iff_inner_right,
      Submodule.mem_orthogonal_singleton_iff_inner_right]
  have hinv : ∀ v ∈ V, T v ∈ V := by
    intro v hv
    rw [memV] at hv ⊢
    constructor
    · rw [← neg_eq_zero, ← hT, hTe, inner_smul_left, hv.2]; simp
    · rw [← neg_eq_zero, ← hT, hTf, inner_smul_left, hv.1]; simp
  -- dimensions
  have hKinf : (ℝ ∙ e) ⊓ (ℝ ∙ f) = ⊥ := by
    rw [eq_bot_iff]; intro x hx
    obtain ⟨⟨a, rfl⟩, ⟨c, hc⟩⟩ := And.intro (Submodule.mem_span_singleton.mp hx.1)
      (Submodule.mem_span_singleton.mp hx.2)
    have : a = 0 := by
      have h1 : inner ℝ e (a • e) = a := by
        rw [inner_smul_right, real_inner_self_eq_norm_sq, he]; ring
      rw [← hc, inner_smul_right, hef, mul_zero] at h1; exact h1.symm
    simp [this]
  have hKdim : Module.finrank ℝ K = 2 := by
    have := Submodule.finrank_sup_add_finrank_inf_eq (ℝ ∙ e) (ℝ ∙ f)
    rw [hKinf, finrank_bot, finrank_span_singleton he0, finrank_span_singleton hf0] at this
    simpa using this
  have hVdim : Module.finrank ℝ V + 2 = d := by
    have := Submodule.finrank_add_finrank_orthogonal K
    rw [hKdim] at this; rw [hV]; omega
  -- the restriction
  let T' : V →ₗ[ℝ] V := T.restrict hinv
  have hT' : ∀ x y, inner ℝ (T' x) y = -inner ℝ x (T' y) := by
    intro x y
    simp only [T', Submodule.coe_inner, LinearMap.restrict_apply]
    exact hT x y
  obtain ⟨κ', μ', _, _, b', s', h1, h2, h3⟩ :=
    ih (Module.finrank ℝ V) (by omega) V rfl T' hT'
  have hb'V : ∀ i, (b' i : E) ∈ V := fun i => (b' i).2
  have hTb : ∀ i, T (b' i : E) = (T' (b' i) : E) := fun i => rfl
  classical
  let F : (Unit ⊕ κ') ⊕ (Unit ⊕ κ') ⊕ μ' → E := fun i => match i with
    | .inl (.inl _) => e
    | .inl (.inr c) => (b' (.inl c) : E)
    | .inr (.inl (.inl _)) => f
    | .inr (.inl (.inr c)) => (b' (.inr (.inl c)) : E)
    | .inr (.inr j) => (b' (.inr (.inr j)) : E)
  have hbo : ∀ i j, inner ℝ (b' i : E) (b' j : E) = if i = j then 1 else 0 := by
    intro i j; rw [← Submodule.coe_inner]; exact orthonormal_iff_ite.mp b'.orthonormal i j
  have heb : ∀ i, inner ℝ e (b' i : E) = 0 := fun i => ((memV _).mp (hb'V i)).1
  have hfb : ∀ i, inner ℝ f (b' i : E) = 0 := fun i => ((memV _).mp (hb'V i)).2
  have hbe : ∀ i, inner ℝ (b' i : E) e = 0 := fun i => by rw [real_inner_comm]; exact heb i
  have hbf : ∀ i, inner ℝ (b' i : E) f = 0 := fun i => by rw [real_inner_comm]; exact hfb i
  have hee : inner ℝ e e = 1 := by rw [real_inner_self_eq_norm_sq, he]; norm_num
  have hff : inner ℝ f f = 1 := by rw [real_inner_self_eq_norm_sq, hf]; norm_num
  have hfe : inner ℝ f e = 0 := by rw [real_inner_comm]; exact hef
  have hon : Orthonormal ℝ F := by
    rw [orthonormal_iff_ite]
    rintro ((_ | c) | ((_ | c) | j)) ((_ | c') | ((_ | c') | j')) <;>
      simp [F, hbo, heb, hfb, hbe, hbf, hee, hff, hef, hfe, he, hf]
  have hcard : Fintype.card ((Unit ⊕ κ') ⊕ (Unit ⊕ κ') ⊕ μ') = Module.finrank ℝ E := by
    have := Module.finrank_eq_card_basis b'.toBasis
    simp only [Fintype.card_sum, Fintype.card_unit] at this ⊢
    omega
  have hsp : ⊤ ≤ Submodule.span ℝ (Set.range F) := by
    rw [← coe_basisOfOrthonormalOfCardEqFinrank hon hcard,
      (basisOfOrthonormalOfCardEqFinrank hon hcard).span_eq]
  refine ⟨Unit ⊕ κ', μ', inferInstance, inferInstance, OrthonormalBasis.mk hon hsp,
    Sum.elim (fun _ => s) s', ?_, ?_, ?_⟩
  · rintro (_ | c) <;> simp only [OrthonormalBasis.coe_mk, F, Sum.elim_inl, Sum.elim_inr]
    · exact hTe
    · rw [hTb, h1 c, Submodule.coe_smul]
  · rintro (_ | c) <;> simp only [OrthonormalBasis.coe_mk, F, Sum.elim_inl, Sum.elim_inr]
    · exact hTf
    · rw [hTb, h2 c, Submodule.coe_smul]
  · intro j
    simp only [OrthonormalBasis.coe_mk, F]
    rw [hTb, h3 j, Submodule.coe_zero]

end abstractPair

section normalForm

/-- The matrix `X` as a linear map on `EuclideanSpace ℝ ι`. -/
noncomputable def eucl (X : Matrix ι ι ℝ) : EuclideanSpace ℝ ι →ₗ[ℝ] EuclideanSpace ℝ ι where
  toFun v := WithLp.toLp 2 (X *ᵥ WithLp.ofLp v)
  map_add' v w := by simp [Matrix.mulVec_add]
  map_smul' c v := by simp [Matrix.mulVec_smul]

theorem ofLp_eucl (X : Matrix ι ι ℝ) (v : EuclideanSpace ℝ ι) :
    WithLp.ofLp (eucl X v) = X *ᵥ WithLp.ofLp v := rfl

theorem real_inner_eucl (x y : EuclideanSpace ℝ ι) :
    inner ℝ x y = WithLp.ofLp x ⬝ᵥ WithLp.ofLp y := by
  rw [EuclideanSpace.inner_eq_star_dotProduct, star_trivial, dotProduct_comm]

theorem eucl_skew {X : Matrix ι ι ℝ} (hX : IsSkew X) (x y : EuclideanSpace ℝ ι) :
    inner ℝ (eucl X x) y = -inner ℝ x (eucl X y) := by
  rw [real_inner_eucl, real_inner_eucl, ofLp_eucl, ofLp_eucl, skew_dot hX, dotProduct_comm]
  ring_nf

/-- **Piece (a): every real skew matrix is orthogonally conjugate to a normal form.** -/
theorem skew_normal_form (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    ∃ (k : ℕ) (N : NormalForm ι k) (O : Matrix ι ι ℝ),
      O * Oᵀ = 1 ∧ Oᵀ * O = 1 ∧ X = O * N.X * Oᵀ := by
  classical
  obtain ⟨κ, μ, _, _, b, s, h1, h2, h3⟩ := skew_decomp _ (EuclideanSpace ℝ ι) rfl (eucl X)
    (eucl_skew hX)
  set B : κ ⊕ κ ⊕ μ → ι → ℝ := fun i => WithLp.ofLp (b i) with hBdef
  have hB : ∀ i j, B i ⬝ᵥ B j = if i = j then 1 else 0 := by
    intro i j; rw [hBdef]; simp only; rw [← real_inner_eucl]
    exact orthonormal_iff_ite.mp b.orthonormal i j
  have hX1 : ∀ c, X *ᵥ B (.inl c) = s c • B (.inr (.inl c)) := by
    intro c; simp only [hBdef, ← ofLp_eucl, h1 c, WithLp.ofLp_smul]
  have hX2 : ∀ c, X *ᵥ B (.inr (.inl c)) = -s c • B (.inl c) := by
    intro c; simp only [hBdef, ← ofLp_eucl, h2 c, WithLp.ofLp_smul]
  have hX3 : ∀ j, X *ᵥ B (.inr (.inr j)) = 0 := by
    intro j; simp only [hBdef, ← ofLp_eucl, h3 j, WithLp.ofLp_zero]
  have hcard : Fintype.card (κ ⊕ κ ⊕ μ) = Fintype.card ι := by
    rw [← Module.finrank_eq_card_basis b.toBasis, finrank_euclideanSpace]
  let σ : κ ⊕ κ ⊕ μ ≃ ι := Fintype.equivOfCardEq hcard
  let τ : κ ≃ Fin (Fintype.card κ) := Fintype.equivFin κ
  let N : NormalForm ι (Fintype.card κ) :=
    { p := fun c => σ (.inl (τ.symm c)), q := fun c => σ (.inr (.inl (τ.symm c))),
      s := fun c => s (τ.symm c),
      hp := fun a b h => by simpa using h
      hq := fun a b h => by simpa using h
      hpq := fun a b h => by simpa using σ.injective h }
  let O : Matrix ι ι ℝ := Matrix.of fun i j => B (σ.symm j) i
  have hOO : Oᵀ * O = 1 := by
    ext j j'
    rw [Matrix.mul_apply, Matrix.one_apply]
    have := hB (σ.symm j) (σ.symm j')
    simp only [dotProduct, Matrix.transpose_apply, O, Matrix.of_apply] at this ⊢
    rw [this]; simp
  have hOO' : O * Oᵀ = 1 := mul_eq_one_comm.mp hOO
  have hcol : ∀ i y, (X * O) i (σ y) = (X *ᵥ B y) i := by
    intro i y; simp [Matrix.mul_apply, Matrix.mulVec, dotProduct, O, Matrix.of_apply]
  have hNX : Oᵀ * (X * O) = N.X := by
    ext j j'
    obtain ⟨x, rfl⟩ := σ.surjective j
    obtain ⟨y, rfl⟩ := σ.surjective j'
    rw [Matrix.mul_apply]
    simp only [Matrix.transpose_apply, O, Matrix.of_apply, hcol, Equiv.symm_apply_apply]
    have hdot : ∀ v, ∑ i, B x i * v i = B x ⬝ᵥ v := fun v => rfl
    rw [hdot]
    simp only [NormalForm.X, Matrix.sum_apply, Matrix.smul_apply, phi, Matrix.sub_apply,
      Matrix.single_apply, N, smul_eq_mul]
    rw [Equiv.sum_comp τ.symm (fun k => s k *
      ((if σ (Sum.inr (Sum.inl k)) = σ x ∧ σ (Sum.inl k) = σ y then 1 else 0) -
        if σ (Sum.inl k) = σ x ∧ σ (Sum.inr (Sum.inl k)) = σ y then 1 else 0))]
    simp only [σ.injective.eq_iff]
    rcases y with c | (c | j)
    · rw [hX1, dotProduct_smul, hB, smul_eq_mul, Finset.sum_eq_single c]
      · by_cases hx : x = Sum.inr (Sum.inl c) <;> simp [hx, eq_comm]
      · intro k _ hk; simp [hk]
      · simp
    · rw [hX2, dotProduct_smul, hB, smul_eq_mul, Finset.sum_eq_single c]
      · by_cases hx : x = Sum.inl c <;> simp [hx, eq_comm]
      · intro k _ hk; simp [hk]
      · simp
    · rw [hX3, dotProduct_zero]; simp
  refine ⟨Fintype.card κ, N, O, hOO', hOO, ?_⟩
  rw [Matrix.mul_assoc O, ← hNX]
  simp only [← Matrix.mul_assoc, hOO', Matrix.one_mul]
  rw [Matrix.mul_assoc, hOO', Matrix.mul_one]

end normalForm

section conj
variable [LinearOrder ι] {k : ℕ} (N : NormalForm ι k)

/-- **Ky Fan at a skew `X` orthogonally conjugate to a normal form.** -/
theorem kyFan_conj {O X : Matrix ι ι ℝ} (hO : O * Oᵀ = 1) (hO' : Oᵀ * O = 1)
    (hX : X = O * N.X * Oᵀ) {r : ℕ} (y : Fin r → Matrix ι ι ℝ) (hyS : ∀ j, IsSkew (y j))
    (hy : ∀ i j, inner2 (y i) (y j) = if i = j then 1 else 0) (c : ℝ) :
    ∑ j, inner2 (y j) (-br X (br X (y j))) ≤ r * c + ∑ ij, max (slotμ N ij - c) 0 := by
  have hNX : N.X = Oᵀ * X * O := by
    rw [hX]
    calc N.X = (Oᵀ * O) * N.X * (Oᵀ * O) := by rw [hO']; simp
      _ = Oᵀ * (O * N.X * Oᵀ) * O := by simp only [Matrix.mul_assoc]
  have h := slot_kyFan N (fun j => Oᵀ * y j * O) (fun j => isSkew_conj (hyS j))
    (fun i j => by rw [inner2_conj hO]; exact hy i j) c
  refine le_of_eq_of_le (Finset.sum_congr rfl fun j _ => ?_) h
  rw [hNX, br_conj hO, br_conj hO]
  have : -(Oᵀ * br X (br X (y j)) * O) = Oᵀ * (-br X (br X (y j))) * O := by
    simp
  rw [this, inner2_conj hO]


/-- **Ky Fan at every real skew matrix**: `skew_normal_form` composed with `kyFan_conj`. -/
theorem kyFan_skew (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    ∃ (k : ℕ) (N : NormalForm ι k) (O : Matrix ι ι ℝ),
      O * Oᵀ = 1 ∧ Oᵀ * O = 1 ∧ X = O * N.X * Oᵀ ∧
      ∀ {r : ℕ} (y : Fin r → Matrix ι ι ℝ), (∀ j, IsSkew (y j)) →
      (∀ i j, inner2 (y i) (y j) = if i = j then 1 else 0) → ∀ c : ℝ,
      ∑ j, inner2 (y j) (-br X (br X (y j))) ≤ r * c + ∑ ij, max (slotμ N ij - c) 0 := by
  obtain ⟨k, N, O, hO, hO', hXO⟩ := skew_normal_form X hX
  exact ⟨k, N, O, hO, hO', hXO, fun y hyS hy c => kyFan_conj N hO hO' hXO y hyS hy c⟩

end conj

end HamiltonsCubic.L240NormalForm
