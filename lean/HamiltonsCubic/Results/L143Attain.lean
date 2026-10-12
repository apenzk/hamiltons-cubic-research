import Mathlib
import HamiltonsCubic.Results.WeylMaximiser
import HamiltonsCubic.Results.SphereCurve
import HamiltonsCubic.Results.L143Assembly
import HamiltonsCubic.Results.EigenFrameExist

set_option linter.style.longLine false

/-!
# L143: `sup |P|` on the unit Weyl sphere is attained at a critical point

[findings/bounds.md](../../../findings/bounds.md), Lemma L143, bounds `sup |P|` by bounding `θ` at
critical points, which needs the supremum of `|P|` to be attained at a critical point
([r1469](../../../reviews/REVIEW_r1469.md)); the row owes it. [WeylMaximiser.lean](WeylMaximiser.lean)'s
`L24_nonvacuous` gives a maximiser `a` of `P` on the unit Weyl sphere, critical (`Q(a) = P(a) a`) with
`P(a) ≥ √(3/2)`. Since `P` is cubic, `P(-R) = -P(R)`, and `-R` is again a unit Weyl tensor, so the
same `a` maximises `|P|`:

* `sup_abs_attained`: at `n ≥ 4` some unit Weyl `a` is critical, has `P(a) > 0`, and satisfies
  `|P(R)| ≤ P(a)` for every unit Weyl `R`;
* `sup_abs_le_of_critical`: so a bound `P(a) ≤ Θ` at every critical point of the unit Weyl sphere
  gives `|P(R)| ≤ Θ` everywhere on it, the passage L143's block takes from critical points to
  `sup |P|`;
* `L143_headline`: with the second-order bound granted at each critical point's spectral frame,
  `|P| ≤ 1 + √(n − 2)` on the unit Weyl sphere, the bridge from `CurvOp2` to `EigenFrame` included;
* `second_order_pointwise`, `L143_unconditional`: the second-order bound holds at every unit Weyl
  eigenframe, so **`|P| ≤ 1 + √(n − 2)` on the unit Weyl sphere at every `n ≥ 4`, unconditionally**.
-/

namespace HamiltonsCubic.L143Attain

open HamiltonsCubic.RealLayer

variable {n : ℕ}

theorem neg_mem_weylSphereSet {R : CurvOp2 (Fin n)} (hR : R ∈ weylSphereSet (Fin n)) :
    (-1 : ℝ) • R ∈ weylSphereSet (Fin n) := by
  refine ⟨?_, isWeyl2_smul (-1) hR.2⟩
  rw [normSq2_smul, hR.1]
  norm_num

/-- **`sup |P|` is attained at a critical point**, with the maximiser of `P` itself. -/
theorem sup_abs_attained (hn : 4 ≤ n) :
    ∃ a : CurvOp2 (Fin n), a ∈ weylSphereSet (Fin n) ∧ Qop2 a = Pcubic2 a • a ∧
      0 < Pcubic2 a ∧ ∀ R ∈ weylSphereSet (Fin n), |Pcubic2 R| ≤ Pcubic2 a := by
  obtain ⟨a, hna, hWa, hmax, hcrit, hθ, -⟩ := L24_nonvacuous hn
  have hpos : 0 < Pcubic2 a := lt_of_lt_of_le (Real.sqrt_pos.mpr (by norm_num)) hθ
  refine ⟨a, ⟨hna, hWa⟩, hcrit, hpos, fun R hR => abs_le.mpr ⟨?_, hmax hR⟩⟩
  have h := hmax (neg_mem_weylSphereSet hR)
  simp only [Set.mem_ofPred_eq] at h
  rw [Pcubic2_smul] at h
  linarith

/-- **From critical points to `sup |P|`**: a bound at every critical point of the unit Weyl sphere
bounds `|P|` on all of it. -/
theorem sup_abs_le_of_critical (hn : 4 ≤ n) (Θ : ℝ)
    (hcrit : ∀ R ∈ weylSphereSet (Fin n), Qop2 R = Pcubic2 R • R → Pcubic2 R ≤ Θ) :
    ∀ R ∈ weylSphereSet (Fin n), |Pcubic2 R| ≤ Θ := by
  obtain ⟨a, ha, hc, -, hall⟩ := sup_abs_attained hn
  exact fun R hR => (hall R hR).trans (hcrit a ha hc)

open HamiltonsCubic.TensorBridge HamiltonsCubic.EigenFrameExist HamiltonsCubic.SecondKind

/-- The spectrum of a Weyl `CurvOp2` operator, through its extension's spectral frame. -/
noncomputable def evOf (R : CurvOp2 (Fin n)) (h : IsWeyl2 R) : Pairs n → ℝ :=
  (Mpair_isHermitian (extend R) (isLinOp_extend R) (isWeyl_extend h).1
    (isWeyl_extend h).2.1).eigenvalues

/-- Its spectral frame, the matrix layer's `frameVec` of the extension. -/
noncomputable def vOf (R : CurvOp2 (Fin n)) (h : IsWeyl2 R) : Pairs n → Matrix (Fin n) (Fin n) ℝ :=
  frameVec (extend R) (isLinOp_extend R) (isWeyl_extend h).1 (isWeyl_extend h).2.1

/-- **L143's headline, granting the second-order bound at critical points** ([r1701](../../../reviews/REVIEW_r1701.md)
G1): if every critical point `R` of the unit Weyl sphere has `P(R) ≤ λ_max p + B₅` in its spectral
frame, then `|P| ≤ 1 + √(n − 2)` on the whole sphere. The bridge from `CurvOp2` to the matrix
layer's `EigenFrame` is `isWeyl_extend`, `eigenFrame_exists` and `normSq_frame`. -/
theorem L143_headline (hn : 4 ≤ n)
    (hso : ∀ R (hR : R ∈ weylSphereSet (Fin n)), Qop2 R = Pcubic2 R • R →
      ∃ amax, Pcubic2 R ≤ evOf R hR.2 amax * HamiltonsCubic.L143.posMass (evOf R hR.2)
        + (1 / 2) * Real.sqrt (∑ a, (∑ b, ∑ c,
          HamiltonsCubic.L41Statement.Frame.cst (vOf R hR.2) a b c ^ 2 * |evOf R hR.2 b|
            * |evOf R hR.2 c|) ^ 2)) :
    ∀ R ∈ weylSphereSet (Fin n), |Pcubic2 R| ≤ 1 + Real.sqrt ((n : ℝ) - 2) := by
  refine sup_abs_le_of_critical hn _ fun R hR hc => ?_
  obtain ⟨amax, h⟩ := hso R hR hc
  have hW := isWeyl_extend hR.2
  have hf := eigenFrame_exists (extend R) (isLinOp_extend R) hW.1 hW.2.1
  have hunit : ∑ a, evOf R hR.2 a ^ 2 = 1 := by
    have e := HamiltonsCubic.L41Statement.Frame.normSq_frame hW hf
    rw [normSq_extend, hR.1] at e
    exact e.symm
  have := HamiltonsCubic.L143.L143_of_second_order hW hf hunit amax (Pcubic2 R) h
  simpa [Fintype.card_fin] using this

/-- **The second-order bound, pointwise** ([r1702](../../../reviews/REVIEW_r1702.md) O2): at every
unit Weyl eigenframe and any index `amax` of the largest eigenvalue, `P ≤ λ_max p + B₅`.
`tr W³ = Σ λ³ ≤ λ_max p` termwise, and `⟨W, W#⟩ = ½ Σ_γ λ_γ S_γ ≤ ½ Σ |λ_γ| X_γ ≤ ½ √(Σ X²)` by
Cauchy–Schwarz at `Σ λ² = 1`. -/
theorem second_order_pointwise {ι Γ : Type*} [Fintype ι] [DecidableEq ι] [Fintype Γ] [DecidableEq Γ]
    {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hW : IsWeyl W) (hf : HamiltonsCubic.L41Statement.EigenFrame W v lam)
    (hunit : ∑ a, lam a ^ 2 = 1) (amax : Γ) (hmax : ∀ b, lam b ≤ lam amax) :
    Pcubic W ≤ lam amax * HamiltonsCubic.L143.posMass lam
      + (1 / 2) * Real.sqrt (∑ a, (∑ b, ∑ c,
        HamiltonsCubic.L41Statement.Frame.cst v a b c ^ 2 * |lam b| * |lam c|) ^ 2) := by
  unfold Pcubic
  rw [HamiltonsCubic.L41Statement.Frame.trCube_frame hW hf,
    HamiltonsCubic.L41Statement.Frame.sharpPair_T hW hf]
  set cst := HamiltonsCubic.L41Statement.Frame.cst v
  -- the cubic trace
  have h1 : ∑ γ, lam γ ^ 3 ≤ lam amax * HamiltonsCubic.L143.posMass lam := by
    unfold HamiltonsCubic.L143.posMass
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun γ _ => ?_
    split_ifs with h
    · nlinarith [hmax γ, sq_nonneg (lam γ)]
    · have h' := not_lt.mp h
      nlinarith [sq_nonneg (lam γ)]
  -- the sharp pairing
  set X : Γ → ℝ := fun a => ∑ b, ∑ c, cst a b c ^ 2 * |lam b| * |lam c| with hX
  have h2a : ∑ γ, ∑ α, ∑ β, lam γ * lam α * lam β * cst γ α β ^ 2 ≤ ∑ γ, |lam γ| * X γ := by
    refine Finset.sum_le_sum fun γ _ => ?_
    rw [hX, Finset.mul_sum]
    refine Finset.sum_le_sum fun α _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun β _ => ?_
    have := le_abs_self (lam γ * lam α * lam β * cst γ α β ^ 2)
    rw [abs_mul, abs_mul, abs_mul, abs_of_nonneg (sq_nonneg (cst γ α β))] at this
    linarith
  have h2b : ∑ γ, |lam γ| * X γ ≤ Real.sqrt (∑ a, X a ^ 2) := by
    have cs := Finset.sum_mul_sq_le_sq_mul_sq Finset.univ (fun γ => |lam γ|) X
    simp only [sq_abs, hunit, one_mul] at cs
    exact le_trans (le_abs_self _) (Real.abs_le_sqrt cs)
  linarith

variable (n) in
/-- A pair index, nonempty from `n ≥ 2`. -/
theorem pairs_nonempty (hn : 2 ≤ n) : Nonempty (Pairs n) :=
  ⟨⟨(⟨0, by omega⟩, ⟨1, by omega⟩), by simp [Fin.lt_def]⟩⟩

/-- **L143, unconditionally**: `|P| ≤ 1 + √(n − 2)` on the unit Weyl sphere at every `n ≥ 4`, the
second-order bound holding pointwise (`second_order_pointwise`). -/
theorem L143_unconditional (hn : 4 ≤ n) :
    ∀ R ∈ weylSphereSet (Fin n), |Pcubic2 R| ≤ 1 + Real.sqrt ((n : ℝ) - 2) := by
  refine L143_headline hn fun R hR _ => ?_
  have hW := isWeyl_extend hR.2
  have hf := eigenFrame_exists (extend R) (isLinOp_extend R) hW.1 hW.2.1
  have hunit : ∑ a, evOf R hR.2 a ^ 2 = 1 := by
    have e := HamiltonsCubic.L41Statement.Frame.normSq_frame hW hf
    rw [normSq_extend, hR.1] at e
    exact e.symm
  have := pairs_nonempty n (by omega)
  obtain ⟨amax, -, hmax⟩ := Finset.exists_max_image Finset.univ (evOf R hR.2) Finset.univ_nonempty
  refine ⟨amax, ?_⟩
  have := second_order_pointwise hW hf hunit amax (fun b => hmax b (Finset.mem_univ b))
  rwa [Pcubic_extend] at this

end HamiltonsCubic.L143Attain
