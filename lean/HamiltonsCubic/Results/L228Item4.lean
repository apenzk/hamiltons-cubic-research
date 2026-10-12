import Mathlib
import HamiltonsCubic.Results.L228Item3

set_option linter.style.longLine false

/-!
# L228 item 4: two blocks whose sum joins a common frame

[findings/second-order.md](../../../findings/second-order.md), Lemma L228, item 4: *"For distinct $a,b\in A$, so
$m\ge2$, if the blocks $X_c$, $c\notin\{a,b\}$, and $X_a+X_b$ are simultaneously diagonal in one orthonormal frame,
then $P(W)\le\Theta_n\lVert W\rVert^3$."* The proof: with $U=X_a+X_b$ and $V=X_a-X_b$, the value depends on the frame
of $V$ only through $\operatorname{tr}(V^2Z)+\operatorname{tr}(VL)$, $Z=\tfrac32X+\tfrac34U$,
$L=\sum_{c\ne a,b}(\beta_{ac}-\beta_{bc})X_c$, both diagonal in the frame; a Birkhoff step moves $V$ into the frame at
the same spectrum and no smaller value, and item 3's last step finishes. This file, at the blocks `a = 0`, `b = 1`
of `Fin (m + 2)`:

* `le_perm_general`: a doubly stochastic pairing of any matrix of coefficients is at most a permutation pairing;
* `align_lin`: for `Z`, `L` diagonal in an orthonormal frame `F` and symmetric `V`, some `V'` diagonal in `F` has
  `V`'s trace and `tr V²` and `tr(V²Z) + tr(VL) ≤ tr(V'²Z) + tr(V'L)`;
* `sum_split2`, `sum_ne_split2` and the `3 × 3` pair identities: the sums of item 1 split at the blocks `0`, `1`;
* `E_split`, `PsiE_eq`: item 1's value is `PhiE(X, U, rest) + tr(V²Z) + tr(VL) - ½β₀₁|V|²`;
* `L228_item4_of`, `L228_item4`, `L228_item4_odd`: the item for any bound its diagonal tensors obey, and with
  `θ₀(n)` (the record's `Θₙ` at even `n`) and the record's odd `Θₙ` at odd `n ≥ 5`.
-/

namespace HamiltonsCubic.L228Item4

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement HamiltonsCubic.L228Statement
  HamiltonsCubic.L228Item1 HamiltonsCubic.L228Item2 HamiltonsCubic.L228Item3 HamiltonsCubic.L57Block
  HamiltonsCubic.L57BlockConj HamiltonsCubic.L226Mixed HamiltonsCubic.L227Alignment

section Birkhoff
variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **Birkhoff's step for any coefficients**: `∑ B_ik² c_ik ≤ ∑ c_{i σ(i)}` for some permutation `σ`. -/
theorem le_perm_general {B : Matrix n n ℝ} (h₁ : Bᵀ * B = 1) (h₂ : B * Bᵀ = 1) (c : n → n → ℝ) :
    ∃ σ : Equiv.Perm n, ∑ i, ∑ k, B i k ^ 2 * c i k ≤ ∑ i, c i (σ i) := by
  let L : Matrix n n ℝ →ₗ[ℝ] ℝ :=
    { toFun := fun M => ∑ i, ∑ k, M i k * c i k
      map_add' := fun M N => by
        simp only [Matrix.add_apply, add_mul, Finset.sum_add_distrib]
      map_smul' := fun r M => by
        simp only [Matrix.smul_apply, smul_eq_mul, RingHom.id_apply, Finset.mul_sum]
        exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun k _ => by ring }
  have hconv : ConvexOn ℝ Set.univ L := L.convexOn convex_univ
  have hS := sq_mem_doublyStochastic h₁ h₂
  have hS' : (Matrix.of fun i k => B i k ^ 2) ∈ convexHull ℝ {x | ∃ σ : Equiv.Perm n, σ.permMatrix ℝ = x} := by
    rw [← doublyStochastic_eq_convexHull_permMatrix]; exact hS
  obtain ⟨_, ⟨σ, rfl⟩, hle⟩ := hconv.exists_ge_of_mem_convexHull (Set.subset_univ _) hS'
  refine ⟨σ, ?_⟩
  have lhs : L (Matrix.of fun i k => B i k ^ 2) = ∑ i, ∑ k, B i k ^ 2 * c i k := rfl
  have rhs : L (σ.permMatrix ℝ) = ∑ i, c i (σ i) := by
    change ∑ i, ∑ k, (σ.permMatrix ℝ) i k * c i k = _
    refine Finset.sum_congr rfl fun i _ => ?_
    simp [Equiv.Perm.permMatrix, PEquiv.toMatrix_apply]
  rw [← lhs, ← rhs]
  exact hle

end Birkhoff

/-- **The alignment of item 4**: for `Z`, `L` diagonal in an orthonormal frame `F` and symmetric `V`, some `V'`
diagonal in `F` has `V`'s trace and `tr V²` and `tr(V²Z) + tr(VL) ≤ tr(V'²Z) + tr(V'L)`. -/
theorem align_lin (F V : Matrix (Fin 3) (Fin 3) ℝ) (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1) (hV : V.IsSymm)
    (z l : Fin 3 → ℝ) :
    ∃ ν' : Fin 3 → ℝ, (inFrame F ν').trace = V.trace ∧ (inFrame F ν' * inFrame F ν').trace = (V * V).trace ∧
      (V * V * inFrame F z).trace + (V * inFrame F l).trace
        ≤ (inFrame F ν' * inFrame F ν' * inFrame F z).trace + (inFrame F ν' * inFrame F l).trace := by
  have hVH := isHermitian_of_isSymm hV
  have hVd := spectral_real hVH
  have hQ₁ := orth_tr_mul hVH.eigenvectorUnitary.2
  have hQ₂ := orth_mul_tr hVH.eigenvectorUnitary.2
  generalize (hVH.eigenvectorUnitary : Matrix (Fin 3) (Fin 3) ℝ) = Q at hVd hQ₁ hQ₂
  generalize hVH.eigenvalues = ν at hVd
  subst hVd
  have hB₁ : (Qᵀ * F)ᵀ * (Qᵀ * F) = 1 := by
    rw [transpose_mul, transpose_transpose]
    simp only [Matrix.mul_assoc]; rw [← Matrix.mul_assoc Q Qᵀ, hQ₂, Matrix.one_mul, hF1]
  have hB₂ : (Qᵀ * F) * (Qᵀ * F)ᵀ = 1 := by
    rw [transpose_mul, transpose_transpose]
    simp only [Matrix.mul_assoc]; rw [← Matrix.mul_assoc F Fᵀ, hF2, Matrix.one_mul, hQ₁]
  obtain ⟨σ, hσ⟩ := le_perm_general hB₁ hB₂ (fun i k => ν i ^ 2 * z k + ν i * l k)
  refine ⟨fun k => ν (σ.symm k), ?_, ?_, ?_⟩
  · unfold inFrame
    rw [L227Alignment.trace_conj hF1, L227Alignment.trace_conj hQ₁, trace_diagonal, trace_diagonal]
    exact Equiv.sum_comp σ.symm ν
  · unfold inFrame
    rw [conj_mul_conj hF1, conj_mul_conj hQ₁, L227Alignment.trace_conj hF1, L227Alignment.trace_conj hQ₁,
      diagonal_mul_diagonal, diagonal_mul_diagonal, trace_diagonal, trace_diagonal]
    exact Equiv.sum_comp σ.symm (fun k => ν k * ν k)
  · unfold inFrame
    have hVV : Q * diagonal ν * Qᵀ * (Q * diagonal ν * Qᵀ) = Q * diagonal (fun k => ν k ^ 2) * Qᵀ := by
      rw [conj_mul_conj hQ₁, diagonal_mul_diagonal]; simp [sq]
    rw [hVV, trace_two_frames, trace_two_frames]
    rw [conj_mul_conj hF1, conj_mul_conj hF1, conj_mul_conj hF1, L227Alignment.trace_conj hF1,
      L227Alignment.trace_conj hF1, diagonal_mul_diagonal, diagonal_mul_diagonal, diagonal_mul_diagonal,
      trace_diagonal, trace_diagonal]
    have hL : ∑ i, ∑ k, ν i ^ 2 * (Qᵀ * F) i k ^ 2 * z k + ∑ i, ∑ k, ν i * (Qᵀ * F) i k ^ 2 * l k
        = ∑ i, ∑ k, (Qᵀ * F) i k ^ 2 * (ν i ^ 2 * z k + ν i * l k) := by
      rw [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun i _ => ?_
      rw [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun k _ => ?_
      ring
    have hR : ∑ k, ν (σ.symm k) * ν (σ.symm k) * z k + ∑ k, ν (σ.symm k) * l k
        = ∑ i, (ν i ^ 2 * z (σ i) + ν i * l (σ i)) := by
      rw [← Finset.sum_add_distrib, ← Equiv.sum_comp σ]
      refine Finset.sum_congr rfl fun i _ => ?_
      simp only [Equiv.symm_apply_apply]
      ring
    rw [hL, hR]
    exact hσ

variable {m : ℕ}

/-- A sum over `Fin (m + 2)` splits off the indices `0` and `1`. -/
theorem sum_split2 {β : Type*} [AddCommMonoid β] (f : Fin (m + 2) → β) :
    ∑ a, f a = f 0 + f 1 + ∑ i : Fin m, f i.succ.succ := by
  rw [Fin.sum_univ_succ, Fin.sum_univ_succ, Fin.succ_zero_eq_one]
  exact (add_assoc _ _ _).symm

/-- **The ordered pairs of `Fin (m + 2)` split off the pairs through `0` and `1`**, for a symmetric summand. -/
theorem sum_ne_split2 (g : Fin (m + 2) → Fin (m + 2) → ℝ) (hg : ∀ a b, g a b = g b a) :
    ∑ a, ∑ b, (if a ≠ b then g a b else 0)
      = 2 * g 0 1 + 2 * ∑ i : Fin m, (g 0 i.succ.succ + g 1 i.succ.succ)
        + ∑ i : Fin m, ∑ j : Fin m, (if i ≠ j then g i.succ.succ j.succ.succ else 0) := by
  rw [sum_ne_succ g hg, sum_ne_succ (fun i j : Fin (m + 1) => g i.succ j.succ) (fun a b => hg _ _),
    Fin.sum_univ_succ (fun i : Fin (m + 1) => g 0 i.succ)]
  simp only [Fin.succ_zero_eq_one, Finset.sum_add_distrib]
  ring

section Three
variable (A B C X : Matrix (Fin 3) (Fin 3) ℝ)

theorem sq_pair : (A * A).trace + (B * B).trace
    = 1 / 2 * ((A + B) * (A + B)).trace + 1 / 2 * ((A - B) * (A - B)).trace := by
  simp only [Matrix.trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three, Matrix.add_apply, Matrix.sub_apply]
  ring

theorem xsq_pair : (X * A * A).trace + (X * B * B).trace
    = 1 / 2 * (X * (A + B) * (A + B)).trace + 1 / 2 * ((A - B) * (A - B) * X).trace := by
  simp only [Matrix.trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three, Matrix.add_apply, Matrix.sub_apply]
  ring

theorem cube_pair : (A * A * A).trace + (B * B * B).trace
    = 1 / 4 * ((A + B) * (A + B) * (A + B)).trace + 3 / 4 * ((A - B) * (A - B) * (A + B)).trace := by
  simp only [Matrix.trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three, Matrix.add_apply, Matrix.sub_apply]
  ring

theorem mul_pair : (A * B).trace = 1 / 4 * ((A + B) * (A + B)).trace - 1 / 4 * ((A - B) * (A - B)).trace := by
  simp only [Matrix.trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three, Matrix.add_apply, Matrix.sub_apply]
  ring

theorem lin_pair (b0 b1 : ℝ) : b0 * (A * C).trace + b1 * (B * C).trace
    = (b0 + b1) / 2 * ((A + B) * C).trace + (b0 - b1) / 2 * ((A - B) * C).trace := by
  simp only [Matrix.trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three, Matrix.add_apply, Matrix.sub_apply]
  ring

end Three

/-- The part of item 1's value that sees `V = X_0 - X_1`. -/
noncomputable def PsiE (t : Fin (m + 2) → ℝ) (K : Fin (m + 2) → Fin (m + 2) → ℝ)
    (X U V : Matrix (Fin 3) (Fin 3) ℝ) (Xr : Fin m → Matrix (Fin 3) (Fin 3) ℝ) : ℝ :=
  3 / 2 * (V * V * X).trace + 3 / 4 * (V * V * U).trace - 1 / 2 * beta t K 0 1 * (V * V).trace
    + ∑ i, (beta t K 0 i.succ.succ - beta t K 1 i.succ.succ) * (V * Xr i).trace

/-- The rest, a function of `X`, `U = X_0 + X_1` and the other blocks. -/
noncomputable def PhiE (t : Fin (m + 2) → ℝ) (K : Fin (m + 2) → Fin (m + 2) → ℝ)
    (X U : Matrix (Fin 3) (Fin 3) ℝ) (Xr : Fin m → Matrix (Fin 3) (Fin 3) ℝ) : ℝ :=
  2 * (X * X * X).trace + 3 / 2 * (X * U * U).trace + 3 * ∑ i, (X * Xr i * Xr i).trace
    + 1 / 4 * (U * U * U).trace + ∑ i, (Xr i * Xr i * Xr i).trace + 1 / 2 * beta t K 0 1 * (U * U).trace
    + ∑ i, (beta t K 0 i.succ.succ + beta t K 1 i.succ.succ) * (U * Xr i).trace
    + ∑ i, ∑ j, (if i ≠ j then beta t K i.succ.succ j.succ.succ * (Xr i * Xr j).trace else 0)

/-- **Item 1's value in `U` and `V`.** -/
theorem E_split (t : Fin (m + 2) → ℝ) (K : Fin (m + 2) → Fin (m + 2) → ℝ) (hK : ∀ a b, K a b = K b a)
    (Xs : Fin (m + 2) → Matrix (Fin 3) (Fin 3) ℝ) :
    cubicX Xs + ∑ a, ∑ b, (if a ≠ b then beta t K a b * (Xs a * Xs b).trace else 0)
      = PhiE t K (∑ a, Xs a) (Xs 0 + Xs 1) (fun i => Xs i.succ.succ)
        + PsiE t K (∑ a, Xs a) (Xs 0 + Xs 1) (Xs 0 - Xs 1) (fun i => Xs i.succ.succ) := by
  have hβ : ∀ a b, beta t K a b = beta t K b a := fun a b => by unfold beta; rw [hK]; ring
  have hg : ∀ a b, beta t K a b * (Xs a * Xs b).trace = beta t K b a * (Xs b * Xs a).trace :=
    fun a b => by rw [hβ, Matrix.trace_mul_comm]
  unfold cubicX PhiE PsiE
  rw [sum_ne_split2 (fun a b => beta t K a b * (Xs a * Xs b).trace) hg,
    sum_split2 (fun c => ((∑ d, Xs d) * Xs c * Xs c).trace), sum_split2 (fun c => (Xs c * Xs c * Xs c).trace)]
  have h1 := xsq_pair (Xs 0) (Xs 1) (∑ d, Xs d)
  have h2 := cube_pair (Xs 0) (Xs 1)
  have h3 := mul_pair (Xs 0) (Xs 1)
  have h4 : 2 * ∑ i : Fin m, (beta t K 0 i.succ.succ * (Xs 0 * Xs i.succ.succ).trace
        + beta t K 1 i.succ.succ * (Xs 1 * Xs i.succ.succ).trace)
      = ∑ i : Fin m, (beta t K 0 i.succ.succ + beta t K 1 i.succ.succ) * ((Xs 0 + Xs 1) * Xs i.succ.succ).trace
        + ∑ i : Fin m, (beta t K 0 i.succ.succ - beta t K 1 i.succ.succ) * ((Xs 0 - Xs 1) * Xs i.succ.succ).trace := by
    rw [Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    have := lin_pair (Xs 0) (Xs 1) (Xs i.succ.succ) (beta t K 0 i.succ.succ) (beta t K 1 i.succ.succ)
    linarith
  linear_combination 3 * h1 + h2 + (2 * beta t K 0 1) * h3 + h4

/-- `PsiE` is the pairing `tr(V²Z) + tr(VL)` less `½β₀₁|V|²`, `Z = (3/2)X + (3/4)U`, `L = ∑ (β₀c - β₁c) X_c`. -/
theorem PsiE_eq (t : Fin (m + 2) → ℝ) (K : Fin (m + 2) → Fin (m + 2) → ℝ) (X U V : Matrix (Fin 3) (Fin 3) ℝ)
    (Xr : Fin m → Matrix (Fin 3) (Fin 3) ℝ) :
    PsiE t K X U V Xr = (V * V * ((3 / 2 : ℝ) • X + (3 / 4 : ℝ) • U)).trace
      + (V * ∑ i, (beta t K 0 i.succ.succ - beta t K 1 i.succ.succ) • Xr i).trace
      - 1 / 2 * beta t K 0 1 * (V * V).trace := by
  unfold PsiE
  rw [Matrix.mul_add, Matrix.trace_add, Matrix.mul_smul, Matrix.mul_smul, Matrix.trace_smul, Matrix.trace_smul,
    Matrix.mul_sum, Matrix.trace_sum]
  simp only [Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul]
  ring

/-- **L228 item 4 for any diagonal bound**, at the blocks `a = 0`, `b = 1` of `Fin (m + 2)`: if `X_0 + X_1` and
the other blocks are simultaneously diagonal in one orthonormal frame `F` and every weight's diagonal tensor obeys
`P ≤ c ‖·‖³`, a Ricci-flat `W` obeys it. -/
theorem L228_item4_of (c : ℝ)
    (hc : ∀ w : Matrix (Fin 3 ⊕ Fin (m + 2)) (Fin 3 ⊕ Fin (m + 2)) ℝ, HamiltonsCubic.FamilyLayer.IsWeight w →
      Pcubic (HamiltonsCubic.FamilyLayer.diagOp w) ≤ c * HamiltonsCubic.RealLayer.norm (HamiltonsCubic.FamilyLayer.diagOp w) ^ 3)
    (t : Fin (m + 2) → ℝ) (Xs : Fin (m + 2) → Matrix (Fin 3) (Fin 3) ℝ)
    (hX : ∀ a, (Xs a).trace = 0) (hXs : ∀ a, (Xs a).IsSymm)
    (K : Fin (m + 2) → Fin (m + 2) → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) i j = 0)
    (F : Matrix (Fin 3) (Fin 3) ℝ) (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (hUd : DiagIn F (Xs 0 + Xs 1)) (hrest : ∀ i : Fin m, DiagIn F (Xs i.succ.succ)) :
    Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
      ≤ c * HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
          (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) ^ 3 := by
  obtain ⟨hP, hN⟩ := L228_item1 t Xs hX hXs K hK hK0
  have hE := E_split t K hK Xs
  set X := ∑ a, Xs a with hXdef
  set U := Xs 0 + Xs 1 with hUdef
  set V := Xs 0 - Xs 1 with hVdef
  set Xr : Fin m → Matrix (Fin 3) (Fin 3) ℝ := fun i => Xs i.succ.succ with hXr
  have hXsplit : X = U + ∑ i, Xr i := by rw [hXdef, sum_split2]
  have hXd : DiagIn F X := by rw [hXsplit]; exact diagIn_add hUd (diagIn_sum _ _ hrest)
  set Z := (3 / 2 : ℝ) • X + (3 / 4 : ℝ) • U with hZ
  set L := ∑ i, (beta t K 0 i.succ.succ - beta t K 1 i.succ.succ) • Xr i with hL
  have hZd : DiagIn F Z := diagIn_add (diagIn_smul _ hXd) (diagIn_smul _ hUd)
  have hLd : DiagIn F L := diagIn_sum _ _ fun i => diagIn_smul _ (hrest i)
  have hZl := eq_inFrame hF2 hZd
  have hLl := eq_inFrame hF2 hLd
  have hVs : V.IsSymm := by
    unfold Matrix.IsSymm; rw [hVdef, Matrix.transpose_sub, (hXs 0).eq, (hXs 1).eq]
  have hUs : U.IsSymm := by
    unfold Matrix.IsSymm; rw [hUdef, Matrix.transpose_add, (hXs 0).eq, (hXs 1).eq]
  obtain ⟨ν, h1, h2, h3⟩ := align_lin F V hF1 hF2 hVs (fun x => (Fᵀ * Z * F) x x) (fun x => (Fᵀ * L * F) x x)
  rw [← hZl, ← hLl] at h3
  set V' := inFrame F ν with hV'def
  set Xs' : Fin (m + 2) → Matrix (Fin 3) (Fin 3) ℝ :=
    Fin.cons ((1 / 2 : ℝ) • (U + V')) (Fin.cons ((1 / 2 : ℝ) • (U - V')) Xr) with hXs'
  have hs0 : Xs' 0 = (1 / 2 : ℝ) • (U + V') := rfl
  have hs1 : Xs' 1 = (1 / 2 : ℝ) • (U - V') := rfl
  have hss : ∀ i : Fin m, Xs' i.succ.succ = Xr i := fun i => rfl
  have hU' : Xs' 0 + Xs' 1 = U := by rw [hs0, hs1]; module
  have hV' : Xs' 0 - Xs' 1 = V' := by rw [hs0, hs1]; module
  have hXr' : (fun i => Xs' i.succ.succ) = Xr := funext hss
  have hX' : ∑ a, Xs' a = X := by rw [sum_split2, hU', hXr', hXsplit]
  have htrUV : U.trace + V.trace = 0 ∧ U.trace - V.trace = 0 := by
    rw [hUdef, hVdef, Matrix.trace_add, Matrix.trace_sub, hX 0, hX 1]; constructor <;> ring
  have hXtr' : ∀ a, (Xs' a).trace = 0 := by
    intro a
    refine Fin.cases ?_ (fun j => Fin.cases ?_ (fun i => ?_) j) a
    · rw [hs0, Matrix.trace_smul, Matrix.trace_add, h1, htrUV.1, smul_zero]
    · show (Xs' 1).trace = 0
      rw [hs1, Matrix.trace_smul, Matrix.trace_sub, h1, htrUV.2, smul_zero]
    · rw [hss]; exact hX _
  have hXs'' : ∀ a, (Xs' a).IsSymm := by
    intro a
    refine Fin.cases ?_ (fun j => Fin.cases ?_ (fun i => ?_) j) a
    · rw [hs0]; unfold Matrix.IsSymm
      rw [Matrix.transpose_smul, Matrix.transpose_add, hUs.eq, (inFrame_isSymm F ν).eq]
    · show (Xs' 1).IsSymm
      rw [hs1]; unfold Matrix.IsSymm
      rw [Matrix.transpose_smul, Matrix.transpose_sub, hUs.eq, (inFrame_isSymm F ν).eq]
    · rw [hss]; exact hXs _
  obtain ⟨hP', hN'⟩ := L228_item1 t Xs' hXtr' hXs'' K hK hK0
  have hE' := E_split t K hK Xs'
  rw [hX', hU', hV', hXr'] at hE'
  -- `P` does not decrease and the norm is kept
  have hPle : Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
      ≤ Pcubic (blockOp (∑ a, Xs' a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs' a) K) := by
    rw [hP, hP', hE, hE', PsiE_eq, PsiE_eq, ← hZ, ← hL, h2]
    linarith [h3]
  have hsq : ∑ a, (Xs' a * Xs' a).trace = ∑ a, (Xs a * Xs a).trace := by
    rw [sum_split2 (fun a => (Xs' a * Xs' a).trace), sum_split2 (fun a => (Xs a * Xs a).trace),
      sq_pair (Xs' 0) (Xs' 1), sq_pair (Xs 0) (Xs 1), hU', hV', h2]
    simp only [hss, hUdef, hVdef, hXr]
  have hnorm : HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs' a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs' a) K)
      = HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) := by
    unfold HamiltonsCubic.RealLayer.norm
    rw [hN, hN', hX', hsq]
  -- `W'` is Ricci-flat
  have hSym : ∀ Zs : Fin (m + 2) → Matrix (Fin 3) (Fin 3) ℝ, (∀ a, (Zs a).IsSymm) →
      (∑ a, Zs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ)).IsSymm ∧
        ∀ a, (t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Zs a).IsSymm := by
    intro Zs hZs
    refine ⟨?_, fun a => ?_⟩
    · unfold Matrix.IsSymm
      rw [Matrix.transpose_sub, Matrix.transpose_smul, Matrix.transpose_one, (isSymm_sum _ _ hZs).eq]
    · unfold Matrix.IsSymm
      rw [Matrix.transpose_add, Matrix.transpose_smul, Matrix.transpose_one, (hZs a).eq]
  obtain ⟨hSs, hMs⟩ := hSym Xs hXs
  obtain ⟨hS's, hM's⟩ := hSym Xs' hXs''
  obtain ⟨-, hO⟩ := (ricciFlat_iff _ hSs _ hMs K hK hK0).mp hRic
  have hRic' : ∀ i j, Ric (blockOp (∑ a, Xs' a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs' a) K) i j = 0 := by
    refine (ricciFlat_iff _ hS's _ hM's K hK hK0).mpr ⟨?_, fun a => ?_⟩
    · have hJ := (ricciJ_inverse _ _).mpr (N_shift t Xs' hXtr').symm
      rw [hJ, neg_add_cancel]
    · have h := hO a
      rw [Matrix.trace_add, hX a] at h
      rw [Matrix.trace_add, hXtr' a]
      exact h
  -- every block of `W'` is diagonal in `F`
  have hXd' : ∀ a, DiagIn F (Xs' a) := by
    intro a
    refine Fin.cases ?_ (fun j => Fin.cases ?_ (fun i => ?_) j) a
    · rw [hs0]; exact diagIn_smul _ (diagIn_add hUd (diagIn_inFrame hF1 ν))
    · show DiagIn F (Xs' 1)
      rw [hs1]; exact diagIn_smul _ (diagIn_sub hUd (diagIn_inFrame hF1 ν))
    · rw [hss]; exact hrest i
  have hSd : DiagIn F (∑ a, Xs' a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ)) :=
    diagIn_sub (diagIn_sum _ _ hXd') (diagIn_smul _ (diagIn_one hF1))
  have hMd : ∀ a, DiagIn F (t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs' a) :=
    fun a => diagIn_add (diagIn_smul _ (diagIn_one hF1)) (hXd' a)
  have hLb := L57_block_conj_of (m := m + 2) c hc _ hS's _ hM's K hK hK0 hRic' F hF1 hF2 hSd hMd
  rw [hnorm] at hLb
  exact hPle.trans hLb

/-- **L228 item 4**, `θ₀(n)` at `n = (m + 2) + 3`, the record's `Θₙ` at even `n`. -/
theorem L228_item4 (t : Fin (m + 2) → ℝ) (Xs : Fin (m + 2) → Matrix (Fin 3) (Fin 3) ℝ)
    (hX : ∀ a, (Xs a).trace = 0) (hXs : ∀ a, (Xs a).IsSymm)
    (K : Fin (m + 2) → Fin (m + 2) → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) i j = 0)
    (F : Matrix (Fin 3) (Fin 3) ℝ) (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (hUd : DiagIn F (Xs 0 + Xs 1)) (hrest : ∀ i : Fin m, DiagIn F (Xs i.succ.succ)) :
    Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
      ≤ Real.sqrt (2 * ((((m + 2 : ℕ) : ℝ) + 3) - 1) * ((((m + 2 : ℕ) : ℝ) + 3) - 2)) / (((m + 2 : ℕ) : ℝ) + 3)
        * HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
          (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) ^ 3 :=
  L228_item4_of _ (diag_bound (by omega)) t Xs hX hXs K hK hK0 hRic F hF1 hF2 hUd hrest

/-- **L228 item 4 at odd `n = (m + 2) + 3`**, with the record's odd constant `Θₙ`. -/
theorem L228_item4_odd (hodd : ¬ Even (m + 2 + 3)) (t : Fin (m + 2) → ℝ)
    (Xs : Fin (m + 2) → Matrix (Fin 3) (Fin 3) ℝ)
    (hX : ∀ a, (Xs a).trace = 0) (hXs : ∀ a, (Xs a).IsSymm)
    (K : Fin (m + 2) → Fin (m + 2) → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) i j = 0)
    (F : Matrix (Fin 3) (Fin 3) ℝ) (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (hUd : DiagIn F (Xs 0 + Xs 1)) (hrest : ∀ i : Fin m, DiagIn F (Xs i.succ.succ)) :
    Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
      ≤ Real.sqrt (HamiltonsCubic.L57Critical.thetaOddSq (((m + 2 : ℕ) : ℝ) + 3))
        * HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
          (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) ^ 3 :=
  L228_item4_of _ (diag_bound_odd (by omega) hodd) t Xs hX hXs K hK hK0 hRic F hF1 hF2 hUd hrest

end HamiltonsCubic.L228Item4
