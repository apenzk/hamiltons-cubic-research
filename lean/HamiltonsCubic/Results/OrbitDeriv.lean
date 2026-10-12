import HamiltonsCubic.Results.L209FoxClosure
import HamiltonsCubic.Results.L15Statement
import HamiltonsCubic.Results.WeylFoxEquivariance
import HamiltonsCubic.Base.FoxBilinear

set_option linter.style.longLine false

/-!
# The Fox trilinear form is infinitesimally `SO(n)`-invariant

[findings/route-a.md](../../../findings/route-a.md)'s Lemma L101 runs on three hypotheses about a trilinear
form `T` and a derivation `D`: symmetry, `T(Dp,q,r) + T(p,Dq,r) + T(p,q,Dr) = 0`, and skewness of `D`.
[L101Statement.lean](L101Statement.lean) proves the lemma from them abstractly. **This file proves the second
and third for the record's `T = foxTri` and `D R = [ad A, R]` at skew `A`**, on every matrix size:

- `F4_invariance`: the four-slot form `F₄(R,S,η,ζ) = −¼ ∑ ⟨[η, R[ζ, S φ]], φ⟩` behind `#` is invariant,
  from trace cyclicity against `ad A` (`trL_ad_comm`);
- `basis_rot`: `∑ [B([A,φ],φ) + B(φ,[A,φ])] = 0` for every bilinear `B`, the rotation of the `φ` basis;
- `mixOp_pair`: `⟨mixOp R S X, W⟩ = ½ P(X,W)` at bivector `W`, the polarised mixed form;
- `foxTri_split`: `T = ¼(Jordan(p,q) + Jordan(q,p) + ½ mix)` through `foxProd_eq`;
- **`foxTri_hder`**, the invariance of `T`, and **`innerOp_Dop_skew`**, the skewness of `D`;
- **`orbit_half`**: at a critical `u`, `T(Du, u, r) = (θ/2)⟨Du, r⟩`, so `Du` is a `½`-eigenvector of `L_e`.

The hypotheses are linearity of `p, q, r` and that `r` maps bivectors to bivectors, both part of `IsWeylOp`.
-/

namespace HamiltonsCubic.OrbitDeriv

open Finset Matrix HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The trace on `Λ²`, `½ ∑ ⟨F φ_ij, φ_ij⟩`. -/
noncomputable def trL (F : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ := (1 / 2) * ∑ i, ∑ j, inner2 (F (phi i j)) (phi i j)

theorem inner2_smul_l' (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 (c • X) Y = c * inner2 X Y := by
  unfold inner2; rw [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul]; ring

theorem inner2_smul_r' (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 X (c • Y) = c * inner2 X Y := by
  unfold inner2; rw [Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul]; ring

theorem inner2_sum_l' {κ : Type*} (s : Finset κ) (f : κ → Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) :
    inner2 (∑ k ∈ s, f k) Y = ∑ k ∈ s, inner2 (f k) Y := by
  unfold inner2; simp only [Matrix.transpose_sum, Matrix.sum_mul, Matrix.trace_sum, Finset.mul_sum]

theorem inner2_sum_r' {κ : Type*} (s : Finset κ) (f : κ → Matrix ι ι ℝ) (X : Matrix ι ι ℝ) :
    inner2 X (∑ k ∈ s, f k) = ∑ k ∈ s, inner2 X (f k) := by
  unfold inner2; simp only [Matrix.mul_sum, Matrix.trace_sum, Finset.mul_sum]

theorem br_phi_skew' (A : Matrix ι ι ℝ) (hA : IsSkew A) (i j : ι) : IsSkew (br A (phi i j)) :=
  HamiltonsCubic.Results.br_isSkew_real A (phi i j) hA (phi_isSkew i j)

/-- **Trace cyclicity against `ad A`**: `tr(ad_A ∘ F) = tr(F ∘ ad_A)` for linear `F` on `Λ²` and skew `A`. -/
theorem trL_ad_comm (A : Matrix ι ι ℝ) (hA : IsSkew A) (F : Matrix ι ι ℝ → Matrix ι ι ℝ) (hF : IsLinOp F) :
    trL (fun Z => br A (F Z)) = trL (fun Z => F (br A Z)) := by
  unfold trL
  congr 1
  set c : ι → ι → ι → ι → ℝ := fun i j k l => inner2 (br A (phi i j)) (phi k l) with hc
  have hanti : ∀ i j k l, c i j k l = -c k l i j := fun i j k l => by
    simp only [hc]; rw [HamiltonsCubic.Results.inner2_br_skew A _ _ hA, inner2_comm]
  have hexp : ∀ i j, br A (phi i j) = (1 / 2 : ℝ) • ∑ k, ∑ l, c i j k l • phi k l := fun i j =>
    (skew_expand _ (br_phi_skew' A hA i j)).symm
  have hFsum : ∀ i j, F (br A (phi i j)) = (1 / 2 : ℝ) • ∑ k, ∑ l, c i j k l • F (phi k l) := fun i j => by
    rw [hexp i j, hF.2, HamiltonsCubic.Results.linOp_sum F hF]
    congr 1; refine Finset.sum_congr rfl fun k _ => ?_
    rw [HamiltonsCubic.Results.linOp_sum F hF]
    exact Finset.sum_congr rfl fun l _ => hF.2 _ _
  -- left side: `⟨[A, Fφ], φ⟩ = −⟨Fφ, [A, φ]⟩`
  have hL : ∀ i j, inner2 (br A (F (phi i j))) (phi i j)
      = -((1 / 2 : ℝ) * ∑ k, ∑ l, c i j k l * inner2 (F (phi i j)) (phi k l)) := fun i j => by
    rw [HamiltonsCubic.Results.inner2_br_skew A _ _ hA, hexp i j, inner2_smul_r', inner2_sum_r']
    congr 2; refine Finset.sum_congr rfl fun k _ => ?_
    rw [inner2_sum_r']; exact Finset.sum_congr rfl fun l _ => by rw [inner2_smul_r']
  have hR : ∀ i j, inner2 (F (br A (phi i j))) (phi i j)
      = (1 / 2 : ℝ) * ∑ k, ∑ l, c i j k l * inner2 (F (phi k l)) (phi i j) := fun i j => by
    rw [hFsum i j, inner2_smul_l', inner2_sum_l']
    congr 1; refine Finset.sum_congr rfl fun k _ => ?_
    rw [inner2_sum_l']; exact Finset.sum_congr rfl fun l _ => by rw [inner2_smul_l']
  simp only [hL, hR]
  -- relabel `(i,j) ↔ (k,l)` and use antisymmetry of `c`
  have hswap : ∑ i, ∑ j, ∑ k, ∑ l, c i j k l * inner2 (F (phi k l)) (phi i j)
      = ∑ i, ∑ j, ∑ k, ∑ l, c k l i j * inner2 (F (phi i j)) (phi k l) :=
    HamiltonsCubic.Results.sum4_swapM (fun i j k l => c i j k l * inner2 (F (phi k l)) (phi i j))
  have e2 : ∑ i, ∑ j, (1 / 2 : ℝ) * ∑ k, ∑ l, c i j k l * inner2 (F (phi k l)) (phi i j)
      = (1 / 2 : ℝ) * ∑ i, ∑ j, ∑ k, ∑ l, c i j k l * inner2 (F (phi k l)) (phi i j) := by
    simp only [Finset.mul_sum]
  have e1 : ∑ i, ∑ j, -((1 / 2 : ℝ) * ∑ k, ∑ l, c i j k l * inner2 (F (phi i j)) (phi k l))
      = (1 / 2 : ℝ) * ∑ i, ∑ j, ∑ k, ∑ l, c k l i j * inner2 (F (phi i j)) (phi k l) := by
    simp only [Finset.mul_sum, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
      Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    rw [hanti k l i j]; ring
  rw [e1, e2, hswap]

theorem inner2_add_l' (X Y Z : Matrix ι ι ℝ) : inner2 (X + Y) Z = inner2 X Z + inner2 Y Z := by
  unfold inner2; rw [Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring

theorem inner2_sub_l' (X Y Z : Matrix ι ι ℝ) : inner2 (X - Y) Z = inner2 X Z - inner2 Y Z := by
  unfold inner2; rw [Matrix.transpose_sub, Matrix.sub_mul, Matrix.trace_sub]; ring

theorem br_linOp (η : Matrix ι ι ℝ) : IsLinOp (fun Z => br η Z) :=
  ⟨fun X Y => by unfold br; simp only [Matrix.mul_add, Matrix.add_mul]; abel,
   fun c X => by unfold br; simp only [Matrix.mul_smul, Matrix.smul_mul, smul_sub]⟩

theorem linOp_comp (F G : Matrix ι ι ℝ → Matrix ι ι ℝ) (hF : IsLinOp F) (hG : IsLinOp G) :
    IsLinOp (fun Z => F (G Z)) :=
  ⟨fun X Y => by simp only [hG.1, hF.1], fun c X => by simp only [hG.2, hF.2]⟩

theorem brR_sub (X Y Z : Matrix ι ι ℝ) : br X (Y - Z) = br X Y - br X Z := by
  unfold br; simp only [Matrix.mul_sub, Matrix.sub_mul]; abel

theorem brL_sub (X Y Z : Matrix ι ι ℝ) : br (X - Y) Z = br X Z - br Y Z := by
  unfold br; simp only [Matrix.mul_sub, Matrix.sub_mul]; abel

theorem jacobi' (A η Z : Matrix ι ι ℝ) : br (br A η) Z = br A (br η Z) - br η (br A Z) := by
  unfold br; simp only [Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_assoc]; abel

theorem linOp_sub (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (X Y : Matrix ι ι ℝ) :
    R (X - Y) = R X - R Y := by
  rw [sub_eq_add_neg, hR.1, show -Y = (-1 : ℝ) • Y by simp, hR.2]; simp [sub_eq_add_neg]

/-- The derivative of an operator along `ad A`: `D R = [ad A, R]`. -/
def Dop (A : Matrix ι ι ℝ) (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun Z => br A (R Z) - R (br A Z)

/-- The four-slot form behind `#`: `F₄(R, S, η, ζ) = −¼ ∑ ⟨[η, R[ζ, S φ]], φ⟩`; `sharpQF R η = F₄(R, R, η, η)`. -/
noncomputable def F4 (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) (η ζ : Matrix ι ι ℝ) : ℝ :=
  -(1 / 4) * ∑ i, ∑ j, inner2 (br η (R (br ζ (S (phi i j))))) (phi i j)

theorem sharpQF_F4 (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (η : Matrix ι ι ℝ) : sharpQF R η = F4 R R η η := rfl

/-- **The pointwise identity**: the four first-order terms add up to `[ad A, G]`, `G = ad η ∘ R ∘ ad ζ ∘ S`. -/
theorem four_terms (A η ζ : Matrix ι ι ℝ) (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (hS : IsLinOp S)
    (Z : Matrix ι ι ℝ) :
    br η (Dop A R (br ζ (S Z))) + br η (R (br ζ (Dop A S Z))) + br (br A η) (R (br ζ (S Z)))
      + br η (R (br (br A ζ) (S Z)))
      = br A (br η (R (br ζ (S Z)))) - br η (R (br ζ (S (br A Z)))) := by
  unfold Dop
  rw [jacobi' A η (R (br ζ (S Z))), jacobi' A ζ (S Z)]
  simp only [brR_sub, linOp_sub R hR, linOp_sub S hS]
  abel

/-- **The infinitesimal invariance of `F₄`**: at skew `A` and linear `R, S`,
`F₄(DR, S, η, ζ) + F₄(R, DS, η, ζ) + F₄(R, S, [A,η], ζ) + F₄(R, S, η, [A,ζ]) = 0`. -/
theorem F4_invariance (A : Matrix ι ι ℝ) (hA : IsSkew A) (η ζ : Matrix ι ι ℝ) (R S : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hR : IsLinOp R) (hS : IsLinOp S) :
    F4 (Dop A R) S η ζ + F4 R (Dop A S) η ζ + F4 R S (br A η) ζ + F4 R S η (br A ζ) = 0 := by
  set G : Matrix ι ι ℝ → Matrix ι ι ℝ := fun Z => br η (R (br ζ (S Z)))
  have hG : IsLinOp G :=
    linOp_comp _ _ (br_linOp η) (linOp_comp _ _ hR (linOp_comp _ _ (br_linOp ζ) hS))
  have hc := trL_ad_comm A hA G hG
  have key : ∀ i j, inner2 (br η (Dop A R (br ζ (S (phi i j))))) (phi i j)
      + inner2 (br η (R (br ζ (Dop A S (phi i j))))) (phi i j)
      + inner2 (br (br A η) (R (br ζ (S (phi i j))))) (phi i j)
      + inner2 (br η (R (br (br A ζ) (S (phi i j))))) (phi i j)
      = inner2 (br A (G (phi i j))) (phi i j) - inner2 (G (br A (phi i j))) (phi i j) := by
    intro i j
    rw [← inner2_add_l', ← inner2_add_l', ← inner2_add_l', four_terms A η ζ R S hR hS, inner2_sub_l']
  unfold F4
  have hsum := Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) =>
    Finset.sum_congr rfl fun j (_ : j ∈ Finset.univ) => key i j
  unfold trL at hc
  simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib] at hsum
  have : ∑ i, ∑ j, inner2 (br A (G (phi i j))) (phi i j) = ∑ i, ∑ j, inner2 (G (br A (phi i j))) (phi i j) := by
    linarith
  linarith

/-- **The basis-rotation lemma**: for a bilinear `B` and skew `A`, `∑ [B([A, φ_ij], φ_ij) + B(φ_ij, [A, φ_ij])] = 0`. -/
theorem basis_rot (A : Matrix ι ι ℝ) (hA : IsSkew A) (B : Matrix ι ι ℝ → Matrix ι ι ℝ → ℝ)
    (hB1 : ∀ c X Y Z, B (c • X + Y) Z = c * B X Z + B Y Z) (hB2 : ∀ c X Y Z, B X (c • Y + Z) = c * B X Y + B X Z) :
    ∑ i, ∑ j, (B (br A (phi i j)) (phi i j) + B (phi i j) (br A (phi i j))) = 0 := by
  have hB1s : ∀ (s : Finset (ι × ι)) (f : ι × ι → ℝ) (Z : Matrix ι ι ℝ),
      B (∑ p ∈ s, f p • phi p.1 p.2) Z = ∑ p ∈ s, f p * B (phi p.1 p.2) Z := by
    intro s f Z
    induction s using Finset.induction_on with
    | empty =>
      simp only [Finset.sum_empty]
      have := hB1 1 0 0 Z; simp at this; linarith
    | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, hB1, ih]
  have hB2s : ∀ (s : Finset (ι × ι)) (f : ι × ι → ℝ) (X : Matrix ι ι ℝ),
      B X (∑ p ∈ s, f p • phi p.1 p.2) = ∑ p ∈ s, f p * B X (phi p.1 p.2) := by
    intro s f X
    induction s using Finset.induction_on with
    | empty =>
      simp only [Finset.sum_empty]
      have := hB2 1 X 0 0; simp at this; linarith
    | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, hB2, ih]
  set c : ι → ι → ι → ι → ℝ := fun i j k l => inner2 (br A (phi i j)) (phi k l) with hc
  have hanti : ∀ i j k l, c i j k l = -c k l i j := fun i j k l => by
    simp only [hc]; rw [HamiltonsCubic.Results.inner2_br_skew A _ _ hA, inner2_comm]
  have hexp : ∀ i j, br A (phi i j) = ∑ p : ι × ι, ((1 / 2 : ℝ) * c i j p.1 p.2) • phi p.1 p.2 := fun i j => by
    conv_lhs => rw [← skew_expand _ (br_phi_skew' A hA i j)]
    rw [Finset.smul_sum, ← Finset.univ_product_univ, Finset.sum_product]
    exact Finset.sum_congr rfl fun k _ => by rw [Finset.smul_sum]; exact Finset.sum_congr rfl fun l _ => by rw [smul_smul]
  have e1 : ∀ i j, B (br A (phi i j)) (phi i j) = ∑ p : ι × ι, (1 / 2 : ℝ) * c i j p.1 p.2 * B (phi p.1 p.2) (phi i j) :=
    fun i j => by rw [hexp i j, hB1s]
  have e2 : ∀ i j, B (phi i j) (br A (phi i j)) = ∑ p : ι × ι, (1 / 2 : ℝ) * c i j p.1 p.2 * B (phi i j) (phi p.1 p.2) :=
    fun i j => by rw [hexp i j, hB2s]
  simp only [e1, e2, ← Finset.sum_add_distrib]
  -- as a sum over pairs of pairs, the summand is antisymmetric under `(i,j) ↔ p`
  rw [← Finset.sum_product' (s := Finset.univ) (t := Finset.univ)
    (f := fun i j => ∑ p : ι × ι, ((1 / 2 : ℝ) * c i j p.1 p.2 * B (phi p.1 p.2) (phi i j)
      + (1 / 2 : ℝ) * c i j p.1 p.2 * B (phi i j) (phi p.1 p.2)))]
  simp only [Finset.sum_add_distrib, Finset.univ_product_univ]
  have hsw : ∑ x : ι × ι, ∑ p : ι × ι, (1 / 2 : ℝ) * c x.1 x.2 p.1 p.2 * B (phi x.1 x.2) (phi p.1 p.2)
      = ∑ x : ι × ι, ∑ p : ι × ι, (1 / 2 : ℝ) * c p.1 p.2 x.1 x.2 * B (phi p.1 p.2) (phi x.1 x.2) :=
    Finset.sum_comm
  rw [hsw, ← Finset.sum_add_distrib]
  exact Finset.sum_eq_zero fun x _ => by
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_eq_zero fun p _ => by rw [hanti p.1 p.2 x.1 x.2]; ring

theorem brL_add (X Y Z : Matrix ι ι ℝ) : br (X + Y) Z = br X Z + br Y Z := by
  unfold br; simp only [Matrix.add_mul, Matrix.mul_add]; abel

theorem brL_smul (c : ℝ) (X Z : Matrix ι ι ℝ) : br (c • X) Z = c • br X Z := by
  unfold br; simp only [Matrix.smul_mul, Matrix.mul_smul, smul_sub]

/-- `F₄` is linear in `η`. -/
theorem F4_eta (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) (c : ℝ) (η η' ζ : Matrix ι ι ℝ) :
    F4 R S (c • η + η') ζ = c * F4 R S η ζ + F4 R S η' ζ := by
  unfold F4
  simp only [brL_add, brL_smul, inner2_add_l', inner2_smul_l', Finset.sum_add_distrib, ← Finset.mul_sum]
  ring

/-- `F₄` is linear in `ζ`. -/
theorem F4_zeta (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (c : ℝ) (η ζ ζ' : Matrix ι ι ℝ) :
    F4 R S η (c • ζ + ζ') = c * F4 R S η ζ + F4 R S η ζ' := by
  unfold F4
  simp only [brL_add, brL_smul, hR.1, hR.2, HamiltonsCubic.RealLayer.br_add_right, br_smul_right,
    inner2_add_l', inner2_smul_l', Finset.sum_add_distrib, ← Finset.mul_sum]
  ring

theorem mixQF_F4 (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (η : Matrix ι ι ℝ) : mixQF A B η = F4 A B η η := rfl

/-- The polarised mixed form: `½(mixSym(X+Y) − mixSym X − mixSym Y)` is the four `F₄` cross terms, halved. -/
theorem mixSym_polar (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (hA : IsLinOp A) (hB : IsLinOp B) (X Y : Matrix ι ι ℝ) :
    (1 / 2) * (mixSym A B (X + Y) - mixSym A B X - mixSym A B Y)
      = (1 / 2) * (F4 A B X Y + F4 A B Y X + F4 B A X Y + F4 B A Y X) := by
  unfold mixSym
  simp only [mixQF_F4]
  have e1 : ∀ (R S : Matrix ι ι ℝ → Matrix ι ι ℝ), IsLinOp R →
      F4 R S (X + Y) (X + Y) = F4 R S X X + F4 R S X Y + F4 R S Y X + F4 R S Y Y := fun R S hR => by
    have h1 := F4_eta R S 1 X Y (X + Y)
    have h2 := F4_zeta R S hR 1 X X Y
    have h3 := F4_zeta R S hR 1 Y X Y
    simp only [one_smul, one_mul] at h1 h2 h3
    rw [h1, h2, h3]; ring
  rw [e1 A B hA, e1 B A hB]; ring

theorem inner2_add_r' (X Y Z : Matrix ι ι ℝ) : inner2 X (Y + Z) = inner2 X Y + inner2 X Z := by
  unfold inner2; rw [Matrix.mul_add, Matrix.trace_add]; ring

/-- **`D` is skew for the pairing**: `∑ ⟨DF φ, G φ⟩ + ⟨F φ, DG φ⟩ = 0` for linear `F, G` and skew `A`. -/
theorem pair_skew (A : Matrix ι ι ℝ) (hA : IsSkew A) (F G : Matrix ι ι ℝ → Matrix ι ι ℝ) (hF : IsLinOp F)
    (hG : IsLinOp G) :
    ∑ i, ∑ j, (inner2 (Dop A F (phi i j)) (G (phi i j)) + inner2 (F (phi i j)) (Dop A G (phi i j))) = 0 := by
  have hrot := basis_rot A hA (fun X Y => inner2 (F X) (G Y))
    (fun c X Y Z => by simp only [hF.1, hF.2, inner2_add_l', inner2_smul_l'])
    (fun c X Y Z => by simp only [hG.1, hG.2, inner2_add_r', inner2_smul_r'])
  have e : ∀ i j, inner2 (Dop A F (phi i j)) (G (phi i j)) + inner2 (F (phi i j)) (Dop A G (phi i j))
      = -(inner2 (F (br A (phi i j))) (G (phi i j)) + inner2 (F (phi i j)) (G (br A (phi i j)))) := by
    intro i j
    unfold Dop
    rw [inner2_sub_l', inner2_comm (F (phi i j)), inner2_sub_l', HamiltonsCubic.Results.inner2_br_skew A _ _ hA]
    have h1 := inner2_comm (br A (G (phi i j))) (F (phi i j))
    have h2 := inner2_comm (G (br A (phi i j))) (F (phi i j))
    linarith
  simp only [e, Finset.sum_neg_distrib, hrot, neg_zero]

/-! ## The Fox trilinear form is `ad`-invariant -/

theorem Dop_lin (A : Matrix ι ι ℝ) (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) : IsLinOp (Dop A R) := by
  constructor
  · intro X Y; unfold Dop
    rw [hR.1, HamiltonsCubic.RealLayer.br_add_right, HamiltonsCubic.RealLayer.br_add_right, hR.1]; abel
  · intro c X; unfold Dop; rw [hR.2, br_smul_right, br_smul_right, hR.2, smul_sub]

theorem isSkew_sub' {X Y : Matrix ι ι ℝ} (hX : IsSkew X) (hY : IsSkew Y) : IsSkew (X - Y) := by
  unfold IsSkew at *; rw [Matrix.transpose_sub, hX, hY]; abel

theorem Dop_skew (A : Matrix ι ι ℝ) (hA : IsSkew A) (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hR : ∀ X, IsSkew X → IsSkew (R X)) : ∀ X, IsSkew X → IsSkew (Dop A R X) := fun X hX =>
  isSkew_sub' (HamiltonsCubic.Results.br_isSkew_real _ _ hA (hR X hX))
    (hR _ (HamiltonsCubic.Results.br_isSkew_real _ _ hA hX))

/-- The polarised mixed form, `P(X, Y) = F₄(R,S,X,Y) + F₄(R,S,Y,X) + F₄(S,R,X,Y) + F₄(S,R,Y,X)`. -/
noncomputable def Pm (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) (X Y : Matrix ι ι ℝ) : ℝ :=
  F4 R S X Y + F4 R S Y X + F4 S R X Y + F4 S R Y X

theorem Pm_lin (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (hS : IsLinOp S) (X : Matrix ι ι ℝ) (c : ℝ)
    (Y Y' : Matrix ι ι ℝ) : Pm R S X (c • Y + Y') = c * Pm R S X Y + Pm R S X Y' := by
  unfold Pm; rw [F4_zeta R S hR, F4_eta, F4_zeta S R hS, F4_eta]; ring

/-- A linear functional read on the `φ` expansion of a skew matrix. -/
theorem lin_expand (L : Matrix ι ι ℝ → ℝ) (hL : ∀ c Y Y', L (c • Y + Y') = c * L Y + L Y') (W : Matrix ι ι ℝ)
    (hW : IsSkew W) : L W = (1 / 2) * ∑ i, ∑ j, inner2 W (phi i j) * L (phi i j) := by
  have h0 : L 0 = 0 := by have := hL 1 0 0; simp at this; linarith
  let f : Matrix ι ι ℝ →ₗ[ℝ] ℝ :=
    { toFun := L
      map_add' := fun Y Y' => by have := hL 1 Y Y'; simpa using this
      map_smul' := fun c Y => by have := hL c Y 0; simp [h0] at this; simpa using this }
  have h := congrArg f (skew_expand W hW)
  simp only [map_smul, map_sum, smul_eq_mul] at h
  exact h.symm

/-- **The mixed half of `∘` paired against a bivector** is the polarised form: `⟨mixOp R S X, W⟩ = ½ P(X, W)`. -/
theorem mixOp_pair (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (hS : IsLinOp S) (X W : Matrix ι ι ℝ)
    (hW : IsSkew W) : inner2 (mixOp R S X) W = (1 / 2) * Pm R S X W := by
  have hexp := lin_expand (Pm R S X) (Pm_lin R S hR hS X) W hW
  have hp : ∀ Y, (1 / 2) * (mixSym R S (X + Y) - mixSym R S X - mixSym R S Y) = (1 / 2) * Pm R S X Y :=
    fun Y => mixSym_polar R S hR hS X Y
  unfold mixOp
  simp only [inner2_smul_l', inner2_sum_l', hp]
  rw [hexp]
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [inner2_comm (phi i j) W]; ring

/-- The unnormalised pairing `∑ ⟨F φ, G φ⟩`. -/
noncomputable def Jd (F G : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ := ∑ i, ∑ j, inner2 (F (phi i j)) (G (phi i j))

/-- The mixed half of `T`, `∑ P(φ, r φ)`. -/
noncomputable def Mx (R S r : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ := ∑ i, ∑ j, Pm R S (phi i j) (r (phi i j))

/-- **`T = ¼(Jordan(p,q) + Jordan(q,p) + ½ mix)`** at linear `p, q` and a bivector-valued `r`. -/
theorem foxTri_split (p q r : Matrix ι ι ℝ → Matrix ι ι ℝ) (hp : IsLinOp p) (hq : IsLinOp q)
    (hr : ∀ X, IsSkew X → IsSkew (r X)) :
    foxTri p q r = (1 / 4) * (Jd (fun Z => p (q Z)) r + Jd (fun Z => q (p Z)) r + (1 / 2) * Mx p q r) := by
  have hpt : ∀ i j, inner2 (foxProd p q (phi i j)) (r (phi i j)) = (1 / 2) * (inner2 (p (q (phi i j))) (r (phi i j))
      + inner2 (q (p (phi i j))) (r (phi i j)) + (1 / 2) * Pm p q (phi i j) (r (phi i j))) := by
    intro i j
    rw [foxProd_eq p q hp hq, inner2_smul_l', inner2_add_l', inner2_add_l',
      mixOp_pair p q hp hq _ _ (hr _ (phi_isSkew i j))]
  unfold foxTri innerOp Jd Mx
  simp only [hpt, ← Finset.mul_sum, Finset.sum_add_distrib]
  ring

theorem Jd_inv (A : Matrix ι ι ℝ) (hA : IsSkew A) (p q r : Matrix ι ι ℝ → Matrix ι ι ℝ) (hp : IsLinOp p)
    (hq : IsLinOp q) (hr : IsLinOp r) :
    Jd (fun Z => Dop A p (q Z)) r + Jd (fun Z => p (Dop A q Z)) r + Jd (fun Z => p (q Z)) (Dop A r) = 0 := by
  have h := pair_skew A hA (fun Z => p (q Z)) r (linOp_comp _ _ hp hq) hr
  have e : ∀ Z, Dop A (fun Z => p (q Z)) Z = Dop A p (q Z) + p (Dop A q Z) := fun Z => by
    unfold Dop; rw [linOp_sub p hp]; abel
  simp only [e, inner2_add_l', Finset.sum_add_distrib] at h
  unfold Jd; linarith

theorem G_inv (A : Matrix ι ι ℝ) (hA : IsSkew A) (R S r : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hS : IsLinOp S) (hr : IsLinOp r) :
    ∑ i, ∑ j, (F4 (Dop A R) S (phi i j) (r (phi i j)) + F4 R (Dop A S) (phi i j) (r (phi i j))
      + F4 R S (phi i j) (Dop A r (phi i j))) = 0 := by
  have hrot := basis_rot A hA (fun u w => F4 R S u (r w)) (fun c X Y Z => F4_eta R S c X Y (r Z))
    (fun c X Y Z => by simp only [hr.1, hr.2]; exact F4_zeta R S hR c X (r Y) (r Z))
  have e : ∀ i j, F4 (Dop A R) S (phi i j) (r (phi i j)) + F4 R (Dop A S) (phi i j) (r (phi i j))
      + F4 R S (phi i j) (Dop A r (phi i j))
      = -(F4 R S (br A (phi i j)) (r (phi i j)) + F4 R S (phi i j) (r (br A (phi i j)))) := by
    intro i j
    have h := F4_invariance A hA (phi i j) (r (phi i j)) R S hR hS
    have hz : Dop A r (phi i j) = (-1 : ℝ) • r (br A (phi i j)) + br A (r (phi i j)) := by unfold Dop; module
    rw [hz, F4_zeta R S hR]; linarith
  simp only [e, Finset.sum_neg_distrib, hrot, neg_zero]

theorem H_inv (A : Matrix ι ι ℝ) (hA : IsSkew A) (R S r : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hS : IsLinOp S) (hr : IsLinOp r) :
    ∑ i, ∑ j, (F4 (Dop A R) S (r (phi i j)) (phi i j) + F4 R (Dop A S) (r (phi i j)) (phi i j)
      + F4 R S (Dop A r (phi i j)) (phi i j)) = 0 := by
  have hrot := basis_rot A hA (fun u w => F4 R S (r u) w)
    (fun c X Y Z => by simp only [hr.1, hr.2]; exact F4_eta R S c (r X) (r Y) Z)
    (fun c X Y Z => F4_zeta R S hR c (r X) Y Z)
  have e : ∀ i j, F4 (Dop A R) S (r (phi i j)) (phi i j) + F4 R (Dop A S) (r (phi i j)) (phi i j)
      + F4 R S (Dop A r (phi i j)) (phi i j)
      = -(F4 R S (r (br A (phi i j))) (phi i j) + F4 R S (r (phi i j)) (br A (phi i j))) := by
    intro i j
    have h := F4_invariance A hA (r (phi i j)) (phi i j) R S hR hS
    have hz : Dop A r (phi i j) = (-1 : ℝ) • r (br A (phi i j)) + br A (r (phi i j)) := by unfold Dop; module
    rw [hz, F4_eta]; linarith
  simp only [e, Finset.sum_neg_distrib, hrot, neg_zero]

theorem Mx_inv (A : Matrix ι ι ℝ) (hA : IsSkew A) (p q r : Matrix ι ι ℝ → Matrix ι ι ℝ) (hp : IsLinOp p)
    (hq : IsLinOp q) (hr : IsLinOp r) :
    Mx (Dop A p) q r + Mx p (Dop A q) r + Mx p q (Dop A r) = 0 := by
  have g1 := G_inv A hA p q r hp hq hr
  have g2 := G_inv A hA q p r hq hp hr
  have h1 := H_inv A hA p q r hp hq hr
  have h2 := H_inv A hA q p r hq hp hr
  unfold Mx Pm
  simp only [Finset.sum_add_distrib] at *
  linarith

/-- **THE FOX TRILINEAR FORM IS `ad`-INVARIANT**: for skew `A`, linear `p, q, r` with `r` bivector-valued,
`T(Dp, q, r) + T(p, Dq, r) + T(p, q, Dr) = 0`, where `D R = [ad A, R]`. This is L101's `hder` for `T = foxTri`. -/
theorem foxTri_hder (A : Matrix ι ι ℝ) (hA : IsSkew A) (p q r : Matrix ι ι ℝ → Matrix ι ι ℝ) (hp : IsLinOp p)
    (hq : IsLinOp q) (hr : IsLinOp r) (hrs : ∀ X, IsSkew X → IsSkew (r X)) :
    foxTri (Dop A p) q r + foxTri p (Dop A q) r + foxTri p q (Dop A r) = 0 := by
  rw [foxTri_split _ _ _ (Dop_lin A p hp) hq hrs, foxTri_split _ _ _ hp (Dop_lin A q hq) hrs,
    foxTri_split _ _ _ hp hq (Dop_skew A hA r hrs)]
  have j1 := Jd_inv A hA p q r hp hq hr
  have j2 := Jd_inv A hA q p r hq hp hr
  have m := Mx_inv A hA p q r hp hq hr
  linarith

/-- **`D` is skew for `innerOp`**: `⟨DF, G⟩ + ⟨F, DG⟩ = 0`. This is L101's `hskew` for `D = [ad A, ·]`. -/
theorem innerOp_Dop_skew (A : Matrix ι ι ℝ) (hA : IsSkew A) (F G : Matrix ι ι ℝ → Matrix ι ι ℝ) (hF : IsLinOp F)
    (hG : IsLinOp G) : innerOp (Dop A F) G = -innerOp F (Dop A G) := by
  have h := pair_skew A hA F G hF hG
  simp only [Finset.sum_add_distrib] at h
  unfold innerOp; linarith

/-- **THE ORBIT TANGENT IS A `½`-EIGENVECTOR** (L25's equivariance step). On a class `C` of operators that is
closed under `D = [ad A, ·]` and consists of linear bivector-valued maps, if `u` is critical in the sense
`T(u, u, r) = θ⟨u, r⟩` for `r ∈ C`, then `T(Du, u, r) = (θ/2)⟨Du, r⟩` for `r ∈ C`: `Du` is an eigenvector of
`L_u` with eigenvalue `θ/2`, so of `L_e = L_u/θ` with eigenvalue `½`. -/
theorem orbit_half (A : Matrix ι ι ℝ) (hA : IsSkew A) (u : Matrix ι ι ℝ → Matrix ι ι ℝ) (hu : IsLinOp u) (θ : ℝ)
    (C : (Matrix ι ι ℝ → Matrix ι ι ℝ) → Prop) (hC : ∀ r, C r → IsLinOp r ∧ ∀ X, IsSkew X → IsSkew (r X))
    (hCD : ∀ r, C r → C (Dop A r)) (hcrit : ∀ r, C r → foxTri u u r = θ * innerOp u r) :
    ∀ r, C r → foxTri (Dop A u) u r = (θ / 2) * innerOp (Dop A u) r := by
  intro r hr
  have h := foxTri_hder A hA u u r hu hu (hC r hr).1 (hC r hr).2
  rw [foxTri_comm u (Dop A u) r, hcrit _ (hCD r hr)] at h
  have hs := innerOp_Dop_skew A hA u r hu (hC r hr).1
  rw [show innerOp u (Dop A r) = -innerOp (Dop A u) r by linarith] at h
  linarith

end HamiltonsCubic.OrbitDeriv
