import Mathlib
import HamiltonsCubic.Results.L268Rep
import HamiltonsCubic.Results.SuTorus
import HamiltonsCubic.Results.TorusEmbed

set_option linter.style.longLine false

/-!
# L283's converse: the torus-invariant operators of so(2k) supported on su(k)

[findings/second-order.md](../../../findings/second-order.md), Lemma L283 says `torusOp A U 0` with `A 𝟙 = 0` is supported
on $\mathfrak{su}(k)\subset\mathfrak{so}(2k)$ ([SuTorus.lean](SuTorus.lean): it kills every bivector anticommuting
with $J$, and kills $J$), and its *What it gives* reads these as all of $\mathfrak{su}(k)$'s torus-invariant operators.
Inside $\mathfrak{so}(2k)$ this file proves that converse:

* `rootS2_anti`: the root vectors of $\varepsilon_i+\varepsilon_j$ anticommute with $J$ (`Jm`);
* `mulVec_one_of_kills_J`: `torusOp A U V` kills $J$ only if $A\mathbf 1=0$;
* `su_rep`: a torus-invariant self-adjoint $C$ that kills every bivector anticommuting with $J$ and kills $J$ is
  `torusOp A U 0` with $A$ symmetric, $U$ pair weights and $A\mathbf 1=0$, through [L268Rep.lean](L268Rep.lean)'s `L268_rep`;
* `H_su_op`: L283's bound $F(C)\le\kappa_{2M}\lVert C\rVert^3$ at every such $C$, $k\le M$, $M\ge7$.

The cubic form here is $\mathfrak{so}(2k)$'s. Two steps stay with the record, the layer carrying no intrinsic
$\mathfrak{su}(k)$: that an operator on $\mathfrak{su}(k)$ invariant under $SU(k)$'s torus extends by zero to one on
$\mathfrak{so}(2k)$ invariant under $SO(2k)$'s torus (the hypothesis `hT` here), and that its cubic form is
$\mathfrak{su}(k)$'s own.
-/

namespace HamiltonsCubic.SuRep

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.L268Rep HamiltonsCubic.SuTorus

variable {m : ℕ}

local notation "SK" => skewSub (Fin m × Fin 2)
local notation "MM" => Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ

/-- **The root vectors of `ε_i + ε_j` anticommute with `J`.** -/
theorem rootS2_anti (i j : Fin m) (hij : i ≠ j) :
    ((rootS i j 2 : SK) : MM) * Jm = -(Jm * ((rootS i j 2 : SK) : MM)) := by
  ext ⟨a, s⟩ ⟨b, t⟩
  rw [mul_Jm, Matrix.neg_apply, Jm_mul]
  simp only [rootS, Submodule.coe_smul, Submodule.coe_sub, I117S.phiS, Matrix.smul_apply, Matrix.sub_apply, phi,
    Matrix.single_apply, smul_eq_mul, Prod.mk.injEq]
  fin_cases s <;> fin_cases t <;> simp [J2_00, J2_01, J2_10, J2_11] <;> (try split_ifs) <;> simp_all

/-- The Cartan block's row sums are read off `C J`. -/
theorem mulVec_one_of_kills_J (A U V : Matrix (Fin m) (Fin m) ℝ) (h : torusOp A U V ⟨Jm, Jm_mem⟩ = 0) :
    A.mulVec (fun _ => 1) = 0 := by
  funext i
  have h1 := congrArg (fun X : SK => (X : MM) (i, 0) (i, 1)) h
  simp only [torusOp, LinearMap.coe_toContinuousLinearMap', LinearMap.coe_mk, AddHom.coe_mk, skewPartM,
    Submodule.coe_zero, Matrix.zero_apply] at h1
  have hs : ∑ k, A i k * Jm (k, 1) (k, 0) = (A.mulVec (fun _ => 1)) i := by
    simp [Jm, J2_10, Matrix.mulVec, dotProduct]
  simp only [Matrix.smul_apply, Matrix.sub_apply, Matrix.transpose_apply, torusMat, if_true, hs, J2_01, J2_10,
    smul_eq_mul] at h1
  show (A.mulVec (fun _ => 1)) i = 0
  linarith

/-- **L283's converse: every torus-invariant symmetric operator on `𝔰𝔬(2k)` supported on `𝔰𝔲(k)` is
`torusOp A U 0` with `A 𝟙 = 0`.** Supported on `𝔰𝔲(k)` is: `C` kills every bivector anticommuting with `J`, and
`C J = 0`. -/
theorem su_rep (C : CurvOp2 (Fin m × Fin 2)) (hT : ∀ x, derOp (cartS x) C = 0)
    (hsa : ∀ X Y : SK, inner2 ((C X : SK) : MM) (Y : MM) = inner2 (X : MM) ((C Y : SK) : MM))
    (hanti : ∀ X : SK, (X : MM) * Jm = -(Jm * (X : MM)) → C X = 0) (hJ : C ⟨Jm, Jm_mem⟩ = 0) :
    C = torusOp (Aof C) (Uof C) 0 ∧ (Aof C)ᵀ = Aof C ∧ IsPairWeights (Uof C) ∧ (Aof C).mulVec (fun _ => 1) = 0 := by
  obtain ⟨hrep, hA, hU, hV⟩ := L268_rep C hT hsa
  have hV0 : Vof C = 0 := by
    ext i j
    by_cases hij : i = j
    · subst hij; simp [Vof]
    · simp only [Vof, if_neg hij, Matrix.zero_apply]
      rw [hanti _ (rootS2_anti i j hij)]
      simp [inner2]
  rw [hV0] at hrep
  refine ⟨hrep, hA, hU, ?_⟩
  apply mulVec_one_of_kills_J (Aof C) (Uof C) 0
  rw [← hrep]; exact hJ

/-- **L283's bound at every torus-invariant symmetric operator supported on `𝔰𝔲(k)`**, `k = j + 1 ≤ M`, `M ≥ 7`. -/
theorem H_su_op (M : ℕ) (hM : 7 ≤ M) (j : ℕ) (hj : j + 1 ≤ M) (C : CurvOp2 (Fin (j + 1) × Fin 2))
    (hT : ∀ x, derOp (cartS x) C = 0)
    (hsa : ∀ X Y : skewSub (Fin (j + 1) × Fin 2),
      inner2 ((C X : skewSub (Fin (j + 1) × Fin 2)) : Matrix (Fin (j + 1) × Fin 2) (Fin (j + 1) × Fin 2) ℝ)
          (Y : Matrix (Fin (j + 1) × Fin 2) (Fin (j + 1) × Fin 2) ℝ)
        = inner2 (X : Matrix (Fin (j + 1) × Fin 2) (Fin (j + 1) × Fin 2) ℝ)
          ((C Y : skewSub (Fin (j + 1) × Fin 2)) : Matrix (Fin (j + 1) × Fin 2) (Fin (j + 1) × Fin 2) ℝ))
    (hanti : ∀ X : skewSub (Fin (j + 1) × Fin 2), (X : Matrix (Fin (j + 1) × Fin 2) (Fin (j + 1) × Fin 2) ℝ) * Jm
      = -(Jm * (X : Matrix (Fin (j + 1) × Fin 2) (Fin (j + 1) × Fin 2) ℝ)) → C X = 0)
    (hJ : C ⟨Jm, Jm_mem⟩ = 0) :
    Ftri C C C ≤ HamiltonsCubic.TorusEmbed.kapE M * (normSq2 C) ^ ((3 : ℝ) / 2) := by
  obtain ⟨hrep, hA, hU, -⟩ := su_rep C hT hsa hanti hJ
  rw [hrep]
  exact H_su_slice M hM j hj _ _ hA hU

end HamiltonsCubic.SuRep
