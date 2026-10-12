import HamiltonsCubic.Results.L120Block
import HamiltonsCubic.Results.WeylTraceOperator
import HamiltonsCubic.Results.FoxBridge
import HamiltonsCubic.Results.L209WeylClosure
import HamiltonsCubic.Results.L240SlotBasis
import HamiltonsCubic.Results.WeylTraceZero
import HamiltonsCubic.Results.WeylTraceInvariance

set_option linter.style.longLine false

/-!
# L123: a zero-diagonal operator contributes nothing to a single-character Rayleigh quotient

[findings/second-order.md](../../../findings/second-order.md), Lemma L123: *let `Γ = {diag(±1)}` be the full sign group
and `X ∈ Sym²(Λ²)` lie in a single `Γ`-character space. If `R` has zero diagonal in the frame, then `⟨X, R ∘ X⟩ = 0`.*

**Proved by averaging over `Γ`**, which uses the equivariance the block calls load-bearing and no isotypic decomposition:

- `Lpair_act`: `⟨X, (g·R) ∘ X⟩ = ⟨X, R ∘ X⟩` for every sign `g`, from `innerOp_act`, `foxProd_act` and `c(g)² = 1`;
- `avg_phi_zero`, `avg_skew_zero`: **the `Γ`-average `∑_g g·R` vanishes on every bivector** when `R` preserves bivectors
  and has zero diagonal, through the four-sign character sums `sum_four_sign` (a flip of one sign negates every term
  whose index multiset `{k, l, a, c}` has an odd entry, and the remaining terms are the diagonal entries);
- `Lpair_sum`: `⟨X, · ∘ X⟩` is additive, and `foxTri_congr_on_skew` makes it vanish at an operator zero on bivectors;
- `L123`: so `2^n ⟨X, R ∘ X⟩ = ⟨X, (∑_g g·R) ∘ X⟩ = 0`;
- `L123_frame`: **the same in an arbitrary orthonormal frame `O`**, by conjugating to the coordinate frame.

The character hypothesis is stated on all matrices, as in [L120Block.lean](L120Block.lean).
-/

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The sign vector of `b : ι → Bool`. -/
def bsign (b : ι → Bool) (i : ι) : ℝ := if b i then 1 else -1

theorem bsign_sq (b : ι → Bool) (i : ι) : bsign b i * bsign b i = 1 := by
  unfold bsign; split_ifs <;> norm_num

/-- Flip the sign at `x`. -/
def bflip (x : ι) (b : ι → Bool) : ι → Bool := Function.update b x (!b x)

theorem bflip_invol (x : ι) (b : ι → Bool) : bflip x (bflip x b) = b := by
  funext y; unfold bflip; by_cases h : y = x
  · subst h; simp
  · simp [Function.update_of_ne h]

theorem bsign_bflip (x : ι) (b : ι → Bool) (y : ι) :
    bsign (bflip x b) y = if y = x then -bsign b y else bsign b y := by
  unfold bsign bflip; by_cases h : y = x
  · subst h; cases b y <;> simp
  · simp [Function.update_of_ne h, h]

/-- **A sum over sign vectors vanishes when flipping one sign negates the summand.** -/
theorem sum_flip_zero (x : ι) (f : (ι → Bool) → ℝ) (hf : ∀ b, f (bflip x b) = -f b) :
    ∑ b, f b = 0 := by
  have e : ∑ b, f b = ∑ b, f (bflip x b) := by
    let σ : (ι → Bool) ≃ (ι → Bool) := ⟨bflip x, bflip x, bflip_invol x, bflip_invol x⟩
    exact (Equiv.sum_comp σ f).symm
  simp only [hf, Finset.sum_neg_distrib] at e
  linarith

/-- **The four-sign sum** at `k ≠ l`: `∑_b s_k s_l s_a s_c Y_ac = 0` whenever `Y_kl = Y_lk = 0`. -/
theorem sum_four_sign (k l a c : ι) (hkl : k ≠ l) (y : ℝ) (hy : (a = k ∧ c = l) ∨ (a = l ∧ c = k) → y = 0) :
    ∑ b : ι → Bool, bsign b k * bsign b l * bsign b a * bsign b c * y = 0 := by
  by_cases hyz : y = 0
  · simp [hyz]
  have hnot : ¬ ((a = k ∧ c = l) ∨ (a = l ∧ c = k)) := fun h => hyz (hy h)
  -- flip `k` when it occurs an odd number of times, otherwise flip `l`
  by_cases hk : (a = k ↔ c = k)
  · apply sum_flip_zero k
    intro b
    simp only [bsign_bflip, if_pos rfl, if_neg (Ne.symm hkl), ite_true]
    by_cases ha : a = k <;> by_cases hc : c = k
    · simp only [ha, hc, if_true]; ring
    · exact absurd (hk.mp ha) hc
    · exact absurd (hk.mpr hc) ha
    · simp only [if_neg ha, if_neg hc]; ring
  · have hl : a ≠ l ∧ c ≠ l := by
      by_cases ha : a = k
      · have hc : c ≠ k := fun hc => hk ⟨fun _ => hc, fun _ => ha⟩
        refine ⟨fun h => hkl (ha.symm.trans h), fun h => hnot (Or.inl ⟨ha, h⟩)⟩
      · have hc : c = k := by by_contra hc; exact hk ⟨fun h => absurd h ha, fun h => absurd h hc⟩
        refine ⟨fun h => hnot (Or.inr ⟨h, hc⟩), fun h => hkl (hc.symm.trans h)⟩
    apply sum_flip_zero l
    intro b
    simp only [bsign_bflip, if_pos rfl, if_neg hkl, if_neg hl.1, if_neg hl.2, ite_true]; ring

/-- `gᵀ φ_kl g = s_k s_l φ_kl` for a sign matrix. -/
theorem signConj_phi (ε : ι → ℝ) (k l : ι) :
    (signMat ε)ᵀ * phi k l * signMat ε = (ε k * ε l) • phi k l := by
  ext a c
  simp only [signMat, Matrix.diagonal_transpose, Matrix.diagonal_mul, Matrix.mul_diagonal, phi,
    Matrix.sub_apply, Matrix.single_apply, Matrix.smul_apply, smul_eq_mul]
  by_cases h1 : l = a <;> by_cases h2 : k = c <;> by_cases h3 : k = a <;> by_cases h4 : l = c <;>
    simp_all <;> ring

/-- **The sign average of `R` vanishes on every `φ_kl`** when `R` preserves bivectors and has zero diagonal. -/
theorem avg_phi_zero (R : CurvLin ι) (hRs : ∀ Z, IsSkew Z → IsSkew (R Z))
    (hR0 : ∀ i j, inner2 (R (phi i j)) (phi i j) = 0) (k l : ι) :
    (∑ b : ι → Bool, act (signMat (bsign b)) R) (phi k l) = 0 := by
  by_cases hkl : k = l
  · subst hkl
    have : phi k k = (0 : Matrix ι ι ℝ) := by unfold phi; simp
    rw [this, map_zero]
  set Y := R (phi k l) with hY
  have hYs : IsSkew Y := hRs _ (phi_isSkew k l)
  have hYkl : Y k l = 0 := by
    have h := inner2_phi Y hYs k l
    rw [hR0 k l] at h; linarith
  have hYlk : Y l k = 0 := by
    have := congrFun (congrFun hYs k) l
    simp [Matrix.transpose_apply] at this
    linarith
  rw [LinearMap.sum_apply]
  ext a c
  rw [Matrix.sum_apply]
  have e : ∀ b : ι → Bool, (act (signMat (bsign b)) R (phi k l)) a c
      = bsign b k * bsign b l * bsign b a * bsign b c * Y a c := by
    intro b
    rw [act_apply, signConj_phi, map_smul]
    simp only [signMat, Matrix.diagonal_transpose, Matrix.diagonal_mul, Matrix.mul_diagonal,
      Matrix.smul_apply, smul_eq_mul, ← hY]
    ring
  simp only [e, Matrix.zero_apply]
  apply sum_four_sign k l a c hkl
  rintro (⟨rfl, rfl⟩ | ⟨rfl, rfl⟩)
  · exact hYkl
  · exact hYlk

/-- **… and so on every bivector.** -/
theorem avg_skew_zero (R : CurvLin ι) (hRs : ∀ Z, IsSkew Z → IsSkew (R Z))
    (hR0 : ∀ i j, inner2 (R (phi i j)) (phi i j) = 0) (Z : Matrix ι ι ℝ) (hZ : IsSkew Z) :
    (∑ b : ι → Bool, act (signMat (bsign b)) R) Z = 0 := by
  rw [← HamiltonsCubic.RealLayer.skew_expand Z hZ, map_smul, map_sum]
  rw [Finset.sum_eq_zero fun i _ => by
    rw [map_sum]; exact Finset.sum_eq_zero fun j _ => by rw [map_smul, avg_phi_zero R hRs hR0, smul_zero]]
  exact smul_zero _

/-- The Fox product of two linear operators is linear. -/
theorem foxProd_isLinOp' (A B : CurvLin ι) : IsLinOp (foxProd (fun Z => A Z) (fun Z => B Z)) := by
  have hA := isLinOp_of_curvLin A
  have hB := isLinOp_of_curvLin B
  have hAB : IsLinOp ((fun Z => A Z) + fun Z => B Z) :=
    ⟨fun X Y => by simp only [Pi.add_apply, map_add]; abel, fun c X => by simp only [Pi.add_apply, map_smul, smul_add]⟩
  have hQ : ∀ F : Matrix ι ι ℝ → Matrix ι ι ℝ, IsLinOp F → IsLinOp (Qop F) := fun F hF => by
    have hs := sharpOp_isLinOp F hF
    constructor
    · intro X Y; unfold Qop compOp; rw [hF.1, hF.1, hs.1]; abel
    · intro c X; unfold Qop compOp; rw [hF.2, hF.2, hs.2, smul_add]
  have h1 := hQ _ hAB
  have h2 := hQ _ hA
  have h3 := hQ _ hB
  constructor
  · intro X Y; unfold foxProd; rw [h1.1, h2.1, h3.1, ← smul_add]; congr 1; abel
  · intro c X; unfold foxProd; rw [h1.2, h2.2, h3.2, smul_comm, ← smul_sub, ← smul_sub]

/-- `foxProd A B` as a linear map. -/
noncomputable def foxLin (A B : CurvLin ι) : CurvLin ι where
  toFun := foxProd (fun Z => A Z) (fun Z => B Z)
  map_add' := (foxProd_isLinOp' A B).1
  map_smul' := (foxProd_isLinOp' A B).2

/-- The pairing `L(A) = ⟨X, A ∘ X⟩`. -/
noncomputable def Lpair (X A : CurvLin ι) : ℝ := innerOp (fun Z => X Z) (foxProd (fun Z => A Z) (fun Z => X Z))

/-- **`L` is invariant under a sign conjugation of `R` when `X` is isotypic.** -/
theorem Lpair_act (X R : CurvLin ι) (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) (c : ℝ) (hc : c * c = 1)
    (hX : act (signMat ε) X = c • X) : Lpair X (act (signMat ε) R) = Lpair X R := by
  obtain ⟨hg, hg'⟩ := signMat_orth ε hε
  unfold Lpair
  have h1 := innerOp_act hg X (foxLin R X)
  have e1 : (fun Z => act (signMat ε) (foxLin R X) Z)
      = fun Z => c • foxProd (fun A => act (signMat ε) R A) (fun A => X A) Z := by
    funext Z
    rw [act_apply]
    show signMat ε * foxProd (fun A => R A) (fun A => X A) ((signMat ε)ᵀ * Z * signMat ε) * (signMat ε)ᵀ = _
    rw [← foxProd_act (signMat ε) hg hg' R X Z, hX]
    have e : (fun A => (c • X) A) = fun A => c • X A := by funext A; rfl
    rw [e, foxProd_smul_right _ _ _ (isLinOp_of_curvLin _) (isLinOp_of_curvLin X)]
  have e2 : (fun Z => act (signMat ε) X Z) = fun Z => c • X Z := by rw [hX]; funext Z; rfl
  rw [e1, e2] at h1
  have e3 : innerOp (fun Z => c • X Z) (fun Z => c • foxProd (fun A => act (signMat ε) R A) (fun A => X A) Z)
      = c * c * innerOp (fun Z => X Z) (foxProd (fun A => act (signMat ε) R A) (fun A => X A)) := by
    unfold innerOp
    simp only [Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    simp only [inner2_smul_left'', inner2_smul_right'']; ring
  rw [e3, hc, one_mul] at h1
  exact h1.trans rfl

/-- `L` is additive in `A`. -/
theorem Lpair_sum (X : CurvLin ι) (s : Finset (ι → Bool)) (f : (ι → Bool) → CurvLin ι) :
    Lpair X (∑ b ∈ s, f b) = ∑ b ∈ s, Lpair X (f b) := by
  induction s using Finset.induction_on with
  | empty =>
    simp only [Finset.sum_empty]
    unfold Lpair
    have : (fun A => (0 : CurvLin ι) A) = (0 : Matrix ι ι ℝ → Matrix ι ι ℝ) := by funext A; rfl
    rw [this, foxProd_zero_left]
    unfold innerOp; simp [inner2]
  | insert a s ha ih =>
    rw [Finset.sum_insert ha, Finset.sum_insert ha, ← ih]
    unfold Lpair
    set F := foxLin (f a) X
    set G := foxLin (∑ b ∈ s, f b) X
    have e : foxProd (fun A => (f a + ∑ b ∈ s, f b) A) (fun A => X A) = fun Z => (F + G) Z := by
      funext Z; exact foxProd_add_left' _ _ X Z
    rw [e]
    calc innerOp (fun Z => X Z) (fun Z => (F + G) Z) = innerOp (fun Z => (F + G) Z) (fun Z => X Z) :=
          innerOp_comm' X (F + G)
      _ = innerOp (fun Z => F Z) (fun Z => X Z) + innerOp (fun Z => G Z) (fun Z => X Z) := innerOp_add_l F G X
      _ = innerOp (fun Z => X Z) (fun Z => F Z) + innerOp (fun Z => X Z) (fun Z => G Z) := by
          rw [innerOp_comm' F X, innerOp_comm' G X]

/-- **L123**: if `R` preserves bivectors and has zero diagonal in the coordinate frame, and `X` lies in one
character space of the full sign group, then `⟨X, R ∘ X⟩ = 0`. -/
theorem L123 (R X : CurvLin ι) (hRs : ∀ Z, IsSkew Z → IsSkew (R Z)) (hXs : ∀ Z, IsSkew Z → IsSkew (X Z))
    (hR0 : ∀ i j, inner2 (R (phi i j)) (phi i j) = 0) (c : (ι → ℝ) → ℝ)
    (hc : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → c ε * c ε = 1)
    (hX : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) X = c ε • X) :
    innerOp (fun Z => X Z) (foxProd (fun Z => R Z) (fun Z => X Z)) = 0 := by
  set A := ∑ b : ι → Bool, act (signMat (bsign b)) R with hA
  have hinv : ∀ b : ι → Bool, Lpair X (act (signMat (bsign b)) R) = Lpair X R := fun b =>
    Lpair_act X R (bsign b) (bsign_sq b) (c (bsign b)) (hc _ (bsign_sq b)) (hX _ (bsign_sq b))
  have hsum : Lpair X A = (Fintype.card (ι → Bool) : ℝ) * Lpair X R := by
    rw [hA, Lpair_sum]
    simp only [hinv, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  -- `L(A) = 0`, since `A` vanishes on bivectors
  have hA0 : Lpair X A = 0 := by
    unfold Lpair
    show innerOp (fun Z => X Z) (fun Z => foxLin A X Z) = 0
    rw [innerOp_comm' X (foxLin A X)]
    show foxTri (fun Z => A Z) (fun Z => X Z) (fun Z => X Z) = 0
    rw [HamiltonsCubic.TensorBridge.foxTri_congr_on_skew (X' := 0) (Y' := fun Z => X Z) (Z' := fun Z => X Z)
      (fun W hW => by rw [avg_skew_zero R hRs hR0 W hW]; unfold IsSkew; simp) hXs
      (fun W hW => by rw [avg_skew_zero R hRs hR0 W hW]; rfl) (fun _ _ => rfl) (fun _ _ => rfl)]
    unfold foxTri
    rw [foxProd_zero_left]
    unfold innerOp; simp [inner2]
  rw [hA0] at hsum
  have hpos : (0 : ℝ) < Fintype.card (ι → Bool) := by exact_mod_cast Fintype.card_pos
  have := hsum.symm
  rcases mul_eq_zero.mp this with h | h
  · exact absurd h hpos.ne'
  · exact h

/-- **L123 in an arbitrary orthonormal frame** `O`: zero diagonal on the frame bivectors `O φ_ij Oᵀ` and a character
of the frame's sign group `O Γ Oᵀ` give `⟨X, R ∘ X⟩ = 0`, by conjugating to the coordinate frame. -/
theorem L123_frame (O : Matrix ι ι ℝ) (hO : Oᵀ * O = 1) (hO' : O * Oᵀ = 1) (R X : CurvLin ι)
    (hRs : ∀ Z, IsSkew Z → IsSkew (R Z)) (hXs : ∀ Z, IsSkew Z → IsSkew (X Z))
    (hR0 : ∀ i j, inner2 (R (O * phi i j * Oᵀ)) (O * phi i j * Oᵀ) = 0) (c : (ι → ℝ) → ℝ)
    (hc : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → c ε * c ε = 1)
    (hX : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (O * signMat ε * Oᵀ) X = c ε • X) :
    innerOp (fun Z => X Z) (foxProd (fun Z => R Z) (fun Z => X Z)) = 0 := by
  have hT : (Oᵀ)ᵀ * Oᵀ = 1 := by rw [Matrix.transpose_transpose]; exact hO'
  have hT' : Oᵀ * (Oᵀ)ᵀ = 1 := by rw [Matrix.transpose_transpose]; exact hO
  have hskewConj : ∀ Z, IsSkew Z → IsSkew (Oᵀ * Z * O) := fun Z hZ => by
    unfold IsSkew at *; rw [Matrix.transpose_mul, Matrix.transpose_mul, hZ, Matrix.transpose_transpose]; simp [Matrix.mul_assoc]
  have hskewConj' : ∀ Z, IsSkew Z → IsSkew (O * Z * Oᵀ) := fun Z hZ => by
    unfold IsSkew at *; rw [Matrix.transpose_mul, Matrix.transpose_mul, hZ, Matrix.transpose_transpose]; simp [Matrix.mul_assoc]
  set R' := act Oᵀ R
  set X' := act Oᵀ X
  have hR's : ∀ Z, IsSkew Z → IsSkew (R' Z) := fun Z hZ => by
    show IsSkew (Oᵀ * R ((Oᵀ)ᵀ * Z * Oᵀ) * (Oᵀ)ᵀ)
    rw [Matrix.transpose_transpose]; exact hskewConj _ (hRs _ (hskewConj' Z hZ))
  have hX's : ∀ Z, IsSkew Z → IsSkew (X' Z) := fun Z hZ => by
    show IsSkew (Oᵀ * X ((Oᵀ)ᵀ * Z * Oᵀ) * (Oᵀ)ᵀ)
    rw [Matrix.transpose_transpose]; exact hskewConj _ (hXs _ (hskewConj' Z hZ))
  have hR'0 : ∀ i j, inner2 (R' (phi i j)) (phi i j) = 0 := fun i j => by
    show inner2 (Oᵀ * R ((Oᵀ)ᵀ * phi i j * Oᵀ) * (Oᵀ)ᵀ) (phi i j) = 0
    rw [Matrix.transpose_transpose]
    have hc : phi i j = Oᵀ * (O * phi i j * Oᵀ) * O := (conj_cancel O (phi i j) hO).symm
    calc inner2 (Oᵀ * R (O * phi i j * Oᵀ) * O) (phi i j)
        = inner2 (Oᵀ * R (O * phi i j * Oᵀ) * O) (Oᵀ * (O * phi i j * Oᵀ) * O) := by
          conv_lhs => rw [show (phi i j) = Oᵀ * (O * phi i j * Oᵀ) * O from hc]
          rw [← hc]
      _ = inner2 (R (O * phi i j * Oᵀ)) (O * phi i j * Oᵀ) := by
          have := inner2_conj_orth hT (R (O * phi i j * Oᵀ)) (O * phi i j * Oᵀ)
          rwa [Matrix.transpose_transpose] at this
      _ = 0 := hR0 i j
  have act_smul' : ∀ (g : Matrix ι ι ℝ) (a : ℝ) (Y : CurvLin ι), act g (a • Y) = a • act g Y := fun g a Y => by
    apply LinearMap.ext; intro Z; simp only [act_apply, LinearMap.smul_apply, Matrix.mul_smul, Matrix.smul_mul]
  have hX' : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) X' = c ε • X' := fun ε hε => by
    show act (signMat ε) (act Oᵀ X) = c ε • act Oᵀ X
    rw [act_comp, ← act_smul', ← hX ε hε, act_comp]
    congr 1
    rw [← Matrix.mul_assoc, ← Matrix.mul_assoc, hO, Matrix.one_mul]
  have h0 := L123 R' X' hR's hX's hR'0 c hc hX'
  have hinv := innerOp_act hT X (foxLin R X)
  have e : (fun Z => act Oᵀ (foxLin R X) Z) = foxProd (fun Z => R' Z) (fun Z => X' Z) := by
    funext Z
    rw [act_apply]
    show Oᵀ * foxProd (fun A => R A) (fun A => X A) ((Oᵀ)ᵀ * Z * Oᵀ) * (Oᵀ)ᵀ = _
    rw [← foxProd_act Oᵀ hT hT' R X Z]
  rw [e] at hinv
  rw [← h0]
  exact hinv.symm

end HamiltonsCubic.Results
