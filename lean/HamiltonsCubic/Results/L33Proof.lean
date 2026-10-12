import HamiltonsCubic.Results.L33Statement
import HamiltonsCubic.Results.L81Proof
import HamiltonsCubic.Results.L41Statement

/-!
# L33, proved

[L33Statement.lean](L33Statement.lean) carries the definitions and the splitting; the proof needs
[L81](L81Proof.lean)'s centraliser criterion, which imports more than the statement file should, so
the three theorems that rest on it live here, in the statement's namespace.
-/

set_option linter.style.longLine false
set_option linter.unusedVariables false

namespace HamiltonsCubic.L33Statement

open HamiltonsCubic.RealLayer Matrix HamiltonsCubic.L41Statement.Frame

variable {m : ℕ}

theorem inner2_self_eq_zero' {X : Matrix (Fin m) (Fin m) ℝ} (h : inner2 X X = 0) : X = 0 := by
  rw [inner2_eq_sum] at h
  have h' : ∑ a, ∑ b, X a b * X a b = 0 := by linarith
  have hnn : ∀ a ∈ (Finset.univ : Finset (Fin m)), 0 ≤ ∑ b, X a b * X a b :=
    fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _
  ext a b
  have h1 := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp h' a (Finset.mem_univ a)
  have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun b _ => mul_self_nonneg (X a b))).mp h1 b (Finset.mem_univ b)
  simpa using mul_self_eq_zero.mp h2

theorem inner2_self_pos {X : Matrix (Fin m) (Fin m) ℝ} (h : X ≠ 0) : 0 < inner2 X X :=
  lt_of_le_of_ne (inner2_self_nonneg X) (fun h' => h (inner2_self_eq_zero' h'.symm))

theorem scaled_of_multiple {x : Matrix (Fin m) (Fin m) ℝ} (h : HamiltonsCubic.L81Statement.MultipleOfRankFour x) :
    IsScaledComplexStructure x := by
  obtain ⟨c, J, hc, ⟨-, hJ3, hJr⟩, rfl⟩ := h
  refine ⟨by rw [Matrix.rank_smul_of_mem_nonZeroDivisors _ (mem_nonZeroDivisors_of_ne_zero hc), hJr], c, hc, ?_⟩
  simp only [Matrix.smul_mul, Matrix.mul_smul, smul_smul, hJ3, smul_neg]
  rw [← neg_smul]; congr 1; ring

/-- **L33.** At every `m ≠ 3`: if `W ∈ 𝒲_m` has a one-dimensional eigenspace on one side,
exactly one eigenvalue counted with multiplicity, and that eigenvector is not a multiple of a
complex structure on a `4`-dimensional subspace, then `W = 0`.

*The `m ≠ 3` is [Lemma L32](../../../findings/isotropy-cap.md)'s sharp hypothesis, which the
block's later note identifies with this step's; `𝒲₃ = 0` there in any case.*

**Proved.** *Write `W = λ x⊗x/|x|² + W'` with `W'` positive semidefinite on all bivectors (the
minority hypothesis) and `W'x = 0`. `A(W) = 2W` ([L41](L41Statement.lean)'s `aW2`) at `u ∈ 𝔠 = 𝔷(x) ∩ x^⊥`
kills the `x`-part, so `W'u = 0` and `W'[u,y] = 0` for every `y`; hence the image of `W'` lies in
`𝔷(𝔠) ∩ 𝔠^⊥`, which is `ℝx` by [L81](L81Proof.lean) since `x` is no scaled complex structure, and is
orthogonal to `x`, so `W' = 0`. Then `W = λ x⊗x/|x|²` has scalar curvature `2λ < 0`, against
Ricci-flatness.* -/
theorem L33 {m : ℕ} (hm : m ≠ 3) (W : Matrix (Fin m) (Fin m) ℝ → Matrix (Fin m) (Fin m) ℝ)
    (hW : IsWeyl W) (x : Matrix (Fin m) (Fin m) ℝ) (lam : ℝ)
    (hmin : MinoritySide W x lam) (hexc : ¬ IsScaledComplexStructure x) :
    W = fun _ => 0 := by
  exfalso
  obtain ⟨hx, hx0, hlam, heig, hpsd⟩ := hmin
  set n2 := inner2 x x with hn2
  have hn2p : 0 < n2 := inner2_self_pos hx0
  have hlin1 : ∀ (Y : Matrix (Fin m) (Fin m) ℝ) (t : ℝ), IsSkew Y → W (t • Y) = t • W Y := by
    intro Y t hY
    have := weyl_lin hW (Finset.univ : Finset (Fin 1)) (fun _ => t) (fun _ => Y) (fun _ => hY)
    simpa using this
  have hadd : ∀ Y Z : Matrix (Fin m) (Fin m) ℝ, IsSkew Y → IsSkew Z → W (Y + Z) = W Y + W Z :=
    fun Y Z hY hZ => W_add hW Y Z hY hZ
  have hsym : ∀ Y Z, IsSkew Y → IsSkew Z → inner2 (W Y) Z = inner2 Y (W Z) := fun Y Z hY hZ => hW.2.1 Y Z hY hZ
  -- the positive part `b`
  set b : Matrix (Fin m) (Fin m) ℝ → Matrix (Fin m) (Fin m) ℝ → ℝ :=
    fun Y Z => inner2 (W Y) Z - lam * inner2 Y x * inner2 Z x / n2 with hb
  have hxs : ∀ Y, inner2 x Y = inner2 Y x := fun Y => inner2_comm x Y
  have hbpsd : ∀ Y, IsSkew Y → 0 ≤ b Y Y := by
    intro Y hY
    set t := inner2 Y x / n2
    have hy : IsSkew (Y - t • x) := by
      unfold IsSkew at *; rw [Matrix.transpose_sub, Matrix.transpose_smul, hY, hx, smul_neg]; abel
    have hyx : inner2 (Y - t • x) x = 0 := by
      rw [inner2_comm, inner2_sub_right, inner2_smul_right, inner2_comm x Y]; simp only [t]; field_simp; ring
    have h0 := hpsd _ hy hyx
    have hWy : W (Y - t • x) = W Y - t • (lam • x) := by
      rw [sub_eq_add_neg, hadd _ _ hY (by unfold IsSkew at *; rw [Matrix.transpose_neg, Matrix.transpose_smul, hx]; simp),
        ← neg_smul, hlin1 _ _ hx, heig, sub_eq_add_neg, neg_smul]
    rw [hWy] at h0
    simp only [inner2_sub_right, inner2_smul_right] at h0
    have e1 : inner2 (W Y - t • lam • x) Y = inner2 (W Y) Y - t * lam * inner2 x Y := by
      rw [inner2_comm, inner2_sub_right, inner2_smul_right, inner2_smul_right, inner2_comm Y (W Y), inner2_comm Y x]; ring
    have e2 : inner2 (W Y - t • lam • x) x = inner2 (W Y) x - t * lam * n2 := by
      rw [inner2_comm, inner2_sub_right, inner2_smul_right, inner2_smul_right, inner2_comm x (W Y)]; ring
    rw [e1, e2] at h0
    have hWYx : inner2 (W Y) x = lam * inner2 Y x := by rw [hsym Y x hY hx, heig, inner2_smul_right]
    rw [hWYx, hxs] at h0
    simp only [hb, t] at h0 ⊢
    have : inner2 (W Y) Y - lam * inner2 Y x * inner2 Y x / n2 = inner2 (W Y) Y - inner2 Y x / n2 * lam * inner2 Y x -
        inner2 Y x / n2 * (lam * inner2 Y x - inner2 Y x / n2 * lam * n2) := by field_simp; ring
    rw [this]; exact h0
  have hbsym : ∀ Y Z, IsSkew Y → IsSkew Z → b Y Z = b Z Y := by
    intro Y Z hY hZ
    simp only [hb]; rw [hsym Y Z hY hZ, inner2_comm Y (W Z)]; ring
  have hbexp : ∀ Y Z (t : ℝ), IsSkew Y → IsSkew Z → b (Y + t • Z) (Y + t • Z) = b Y Y + 2 * t * b Y Z + t ^ 2 * b Z Z := by
    intro Y Z t hY hZ
    have hZt : IsSkew (t • Z) := by unfold IsSkew at *; rw [Matrix.transpose_smul, hZ, smul_neg]
    simp only [hb]
    rw [hadd _ _ hY hZt, hlin1 _ _ hZ]
    have hr : ∀ A, inner2 A (Y + t • Z) = inner2 A Y + t * inner2 A Z := fun A => by
      rw [inner2_comm, inner2_add_l, inner2_smul_l, inner2_comm Y, inner2_comm Z]
    have e1 : inner2 (W Y + t • W Z) (Y + t • Z)
        = inner2 (W Y) Y + 2 * t * inner2 (W Y) Z + t ^ 2 * inner2 (W Z) Z := by
      rw [inner2_add_l, inner2_smul_l, hr, hr]
      have : inner2 (W Z) Y = inner2 (W Y) Z := by rw [hsym Z Y hZ hY, inner2_comm]
      rw [this]; ring
    have e2 : inner2 (Y + t • Z) x = inner2 Y x + t * inner2 Z x := by rw [inner2_add_l, inner2_smul_l]
    rw [e1, e2]; field_simp; ring
  have hbker : ∀ Y, IsSkew Y → b Y Y = 0 → ∀ Z, IsSkew Z → b Y Z = 0 := by
    intro Y hY h0 Z hZ
    have hlz := HamiltonsCubic.L31Statement.Proof.lin_zero (a := 2 * b Y Z) (b := b Z Z) (fun t => by
      have hYt : IsSkew (Y + t • Z) := by
        unfold IsSkew at *; rw [Matrix.transpose_add, Matrix.transpose_smul, hY, hZ, smul_neg]; abel
      have := hbpsd _ hYt
      rw [hbexp Y Z t hY hZ, h0] at this; linarith)
    linarith
  -- `c`: skew, orthogonal to `x`, commuting with `x`
  have hcx : ∀ u, IsSkew u → inner2 x u = 0 → br x u = 0 → b u u = 0 ∧ ∀ y, IsSkew y → ∀ Z, IsSkew Z → b (br u y) Z = 0 := by
    intro u hu hxu hbru
    have hux : inner2 u x = 0 := by rw [inner2_comm]; exact hxu
    have hbrux : br u x = 0 := by unfold br at *; rw [← neg_sub, hbru, neg_zero]
    have hxterm : ∀ y, IsSkew y → inner2 (br u y) x = 0 := fun y hy => by
      rw [adinv x hu hy, hbrux]; simp [inner2]
    have haw := aW2 hW u hu
    have hsplit : ∀ Y, inner2 (W Y) Y = b Y Y + lam * inner2 Y x * inner2 Y x / n2 := by
      intro Y; simp only [hb]; ring
    have hphi : ∀ i j, IsSkew (br u (phi i j)) := fun i j => br_skew hu (phi_isSkew i j)
    simp only [hsplit, hxterm _ (phi_isSkew _ _), hux, mul_zero, zero_mul, zero_div, add_zero] at haw
    have hnn : ∀ i ∈ (Finset.univ : Finset (Fin m)), 0 ≤ ∑ j, b (br u (phi i j)) (br u (phi i j)) :=
      fun i _ => Finset.sum_nonneg fun j _ => hbpsd _ (hphi i j)
    have hS := Finset.sum_nonneg hnn
    have hbu := hbpsd u hu
    have huu : b u u = 0 := by nlinarith
    refine ⟨huu, fun y hy Z hZ => ?_⟩
    have hsum0 : ∑ i, ∑ j, b (br u (phi i j)) (br u (phi i j)) = 0 := by nlinarith
    have hij : ∀ i j, b (br u (phi i j)) (br u (phi i j)) = 0 := fun i j => by
      have h1 := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hsum0 i (Finset.mem_univ i)
      exact (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => hbpsd _ (hphi i j))).mp h1 j (Finset.mem_univ j)
    have hk : ∀ i j, b (br u (phi i j)) Z = 0 := fun i j => hbker _ (hphi i j) (hij i j) Z hZ
    -- linearity in the bracket argument
    have hexp : br u y = ∑ a, ∑ c, ((1 / 2) * inner2 y (phi a c)) • br u (phi a c) := by
      conv_lhs => rw [phi_expand y hy]
      unfold br
      simp only [Matrix.mul_sum, Matrix.sum_mul, Matrix.mul_smul, Matrix.smul_mul, ← Finset.sum_sub_distrib,
        ← smul_sub]
    have hWexp : W (br u y) = ∑ a, ∑ c, ((1 / 2) * inner2 y (phi a c)) • W (br u (phi a c)) := by
      rw [hexp]; exact weyl_lin2 hW _ _ hphi
    have hWZ : ∀ i j, inner2 (W (br u (phi i j))) Z = 0 := fun i j => by
      have := hk i j; simp only [hb, hxterm _ (phi_isSkew i j), mul_zero, zero_mul, zero_div, sub_zero] at this
      exact this
    simp only [hb, hxterm y hy, mul_zero, zero_mul, zero_div, sub_zero]
    rw [hWexp, inner2_sum_l]
    refine Finset.sum_eq_zero fun a _ => ?_
    rw [inner2_sum_l]
    refine Finset.sum_eq_zero fun c _ => ?_
    rw [inner2_smul_l, hWZ, mul_zero]
  -- `L81`: `𝔷(𝔠) ∩ 𝔠^⊥ = ℝx`
  have hL := HamiltonsCubic.L81Statement.L81 hm x hx hx0
  have hnotmul : ¬ HamiltonsCubic.L81Statement.MultipleOfRankFour x := fun h => hexc (scaled_of_multiple h)
  have hxz : x ∈ HamiltonsCubic.L81Statement.zPerp x := HamiltonsCubic.SkewCentraliser.x_mem_zPerp hx
  have hdim1 : Module.finrank ℝ (HamiltonsCubic.L81Statement.zPerp x) = 1 := by
    rcases hL.2 with h | h
    · exact h
    · exact absurd (hL.1.mp (by omega)) hnotmul
  have hspan : Submodule.span ℝ {x} = HamiltonsCubic.L81Statement.zPerp x := by
    apply Submodule.eq_of_le_of_finrank_le
    · rw [Submodule.span_le, Set.singleton_subset_iff]; exact hxz
    · rw [hdim1, finrank_span_singleton hx0]
  -- every `V = W z - (λ⟨z,x⟩/|x|²) x` is zero
  have hV : ∀ z, IsSkew z → W z = (lam * inner2 z x / n2) • x := by
    intro z hz
    set V := W z - (lam * inner2 z x / n2) • x with hVdef
    have hVs : IsSkew V := by
      have h1 := hW.1 z hz
      unfold IsSkew at *; rw [hVdef, Matrix.transpose_sub, Matrix.transpose_smul, h1, hx, smul_neg]; abel
    have hmem : V ∈ HamiltonsCubic.L81Statement.zPerp x := by
      refine ⟨hVs, fun w hw => ?_, fun w hw => ?_⟩
      · obtain ⟨hws, hwx, hwb⟩ := hw
        obtain ⟨-, hk⟩ := hcx w hws hwx hwb
        have hy : ∀ y, IsSkew y → inner2 (br w y) V = 0 := by
          intro y hy
          have hwyx : inner2 (br w y) x = 0 := by
            rw [adinv x hws hy]
            have : br w x = 0 := by
              have := hwb; unfold HamiltonsCubic.L81Statement.br at this; unfold br; rw [← neg_sub, this, neg_zero]
            rw [this]; simp [inner2]
          have := hk y hy z hz
          simp only [hb, hwyx, mul_zero, zero_mul, zero_div, sub_zero] at this
          rw [hVdef, inner2_sub_right, inner2_smul_right, hwyx, mul_zero, sub_zero, ← hsym _ _ (br_skew hws hy) hz]
          exact this
        have hbwV : br w V = 0 := by
          have := hy (br w V) (br_skew hws hVs)
          rw [adinv V hws (br_skew hws hVs)] at this
          exact inner2_self_eq_zero' (by linarith)
        show HamiltonsCubic.L81Statement.br V w = 0
        unfold HamiltonsCubic.L81Statement.br; unfold br at hbwV; rw [← neg_sub, hbwV, neg_zero]
      · obtain ⟨hws, hwx, hwb⟩ := hw
        obtain ⟨hww, -⟩ := hcx w hws hwx hwb
        have hbw := hbker w hws hww z hz
        have hwxR : inner2 x w = 0 := hwx
        have hwx' : inner2 w x = 0 := by rw [inner2_comm]; exact hwxR
        simp only [hb, hwx', mul_zero, zero_mul, zero_div, sub_zero] at hbw
        show inner2 V w = 0
        rw [hVdef, inner2_comm, inner2_sub_right, inner2_smul_right, hwx', mul_zero, sub_zero,
          ← hsym w z hws hz]
        exact hbw
    rw [← hspan] at hmem
    obtain ⟨t, ht⟩ := Submodule.mem_span_singleton.mp hmem
    have hVx : inner2 V x = 0 := by
      rw [inner2_comm, hVdef, inner2_sub_right, inner2_smul_right, inner2_comm x (W z), hsym z x hz hx, heig,
        inner2_smul_right, ← hn2, inner2_comm z x]
      field_simp; ring
    rw [← ht, inner2_smul_l] at hVx
    have ht0 : t = 0 := (mul_eq_zero.mp hVx).resolve_right hn2p.ne'
    rw [ht0, zero_smul] at ht
    exact (sub_eq_zero.mp ht.symm)
  -- the trace
  have hric : ∑ a, HamiltonsCubic.RealLayer.Ric W a a = 2 * lam := by
    unfold HamiltonsCubic.RealLayer.Ric
    simp only [fun a c => hV (phi a c) (phi_isSkew a c), inner2_smul_l]
    have hp := parseval x x hx hx
    rw [← hn2] at hp
    have : ∑ a, ∑ c, lam * inner2 (phi a c) x / n2 * inner2 x (phi a c)
        = lam / n2 * (∑ a, ∑ c, inner2 x (phi a c) * inner2 x (phi a c)) := by
      rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun a _ => ?_
      rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun c _ => ?_
      rw [inner2_comm (phi a c) x]; ring
    rw [this]
    have h2 : ∑ a, ∑ c, inner2 x (phi a c) * inner2 x (phi a c) = 2 * n2 := by linarith
    rw [h2]; field_simp
  have h0 : ∑ a, HamiltonsCubic.RealLayer.Ric W a a = 0 := Finset.sum_eq_zero fun a _ => hW.2.2.2 a a
  linarith

/-- **The lemma is an emptiness statement**: under its hypotheses no such `W` exists at all,
since `W = 0` contradicts `W x = λ x` with `λ < 0` and `x ≠ 0`. -/
theorem L33_no_such_W {m : ℕ} (hm : m ≠ 3)
    (W : Matrix (Fin m) (Fin m) ℝ → Matrix (Fin m) (Fin m) ℝ) (hW : IsWeyl W)
    (x : Matrix (Fin m) (Fin m) ℝ) (lam : ℝ) (hmin : MinoritySide W x lam)
    (hexc : ¬ IsScaledComplexStructure x) : False := by
  obtain ⟨hskew, hx0, hlam, heig, hpsd⟩ := hmin
  have hzero := L33 hm W hW x lam ⟨hskew, hx0, hlam, heig, hpsd⟩ hexc
  rw [hzero] at heig
  have : lam • x = 0 := heig.symm
  rcases smul_eq_zero.mp this with h | h
  · exact absurd h (ne_of_lt hlam)
  · exact hx0 h

/-- **The "in particular" clause.** At even `m ≥ 6` a nondegenerate minority-side eigenvector
forces `W = 0`, so no `W ≠ 0`, in particular no rank-`3` one, has such an eigenvector.

*Nondegenerate means `det x ≠ 0`, hence `rank x = m ≥ 6`, so the rank-`4` exception cannot
apply: that is the whole of the deduction, and it is why `m ≥ 6` is sharp.* -/
theorem L33_nondegenerate {m : ℕ} (h6 : 6 ≤ m) (heven : Even m)
    (W : Matrix (Fin m) (Fin m) ℝ → Matrix (Fin m) (Fin m) ℝ) (hW : IsWeyl W)
    (x : Matrix (Fin m) (Fin m) ℝ) (lam : ℝ) (hmin : MinoritySide W x lam)
    (hdet : x.det ≠ 0) : W = fun _ => 0 := by
  have hrank : x.rank = m := by
    have hu : IsUnit x := (Matrix.isUnit_iff_isUnit_det x).mpr (isUnit_iff_ne_zero.mpr hdet)
    rw [Matrix.rank_of_isUnit x hu]
    simp
  refine L33 (by omega) W hW x lam hmin ?_
  rintro ⟨hr, -⟩
  rw [hrank] at hr
  omega

end HamiltonsCubic.L33Statement
