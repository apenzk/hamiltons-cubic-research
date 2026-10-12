import Mathlib
import HamiltonsCubic.Results.L27Sector
import HamiltonsCubic.Results.PairIdent
import HamiltonsCubic.Results.L127Le
import HamiltonsCubic.Results.L127Dim

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L27's pair sector: `L_e` on a character-`ε_j ε_k` component at a sphere product

[findings/nondegeneracy.md](../../../findings/nondegeneracy.md), Lemma L207: *For a pair with one index in each factor the
block has two eigenvalues, $0$ with multiplicity $n-4$ and $\tfrac12$ exactly once.* The within-factor pairs carry
$0$, $\lambda_m$ and $-\mu$ ([L127Le.lean](L127Le.lean)'s `within_LeLin_spectrum`).

[L120Ident.lean](L120Ident.lean)'s `pair_block_iff` writes a Weyl operator of character `ε_j ε_k` as `pairMap j k c` on the Ricci
cut, and `pairMap`'s underlying `pairLin` is [L127Le.lean](L127Le.lean)'s `pairVec` by definition, so the pair-block spectra
of [L127Le.lean](L127Le.lean) apply to every such component:

* **`pair_eq_pairVec`**: a Weyl `V` of character `ε_j ε_k` is `restrictLin (pairVec j k c)` with `c` on the Ricci cut, and
  `V ≠ 0` gives a nonzero coefficient;
* `pairVec_comm`: `pairVec j k c = pairVec k j c`;
* **`pair_sphere`**: at a unit sphere product, an `L_e`-eigenvalue `λ` on a nonzero character-`ε_j ε_k` component has
  `λ ≤ 1/2`, and `λ = 1/2` only at a cross pair, one index in each factor.
-/

namespace HamiltonsCubic.L27Pair

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.I117S HamiltonsCubic.FrameOp2
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly

variable {n : ℕ} {j k : Fin n}

/-- **A character-`ε_j ε_k` component on the pair span.** -/
theorem pair_eq_pairVec (hjk : j ≠ k) {V : CurvOp2 (Fin n)} (hVW : IsWeyl2 V) (hV : SignChar (setChar {j, k}) V) :
    ∃ c : Fin n → ℝ, ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0 ∧
      V = restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X) := by
  obtain ⟨c, hc, he⟩ := Submodule.mem_map.mp ((HamiltonsCubic.L120Ident.pair_block_iff hjk V hVW).mp hV)
  rw [mem_ker_blockSums1] at hc
  refine ⟨c, hc.2, ContinuousLinearMap.ext fun X => Subtype.ext ?_⟩
  have e := congrArg (fun L : CurvLin (Fin n) => L (X : Matrix (Fin n) (Fin n) ℝ)) he
  rw [← extend_apply V X]
  show extendL V (X : Matrix (Fin n) (Fin n) ℝ) = pairVec j k c (X : Matrix (Fin n) (Fin n) ℝ)
  rw [← e]
  show pairLin j k c (HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) (X : Matrix (Fin n) (Fin n) ℝ)) = _
  rw [HamiltonsCubic.WeylModuleSNonzero.skewProj_skew _ X.2]
  rfl

/-- A nonzero operator on the pair span has a nonzero coefficient. -/
theorem pairVec_ne {c : Fin n → ℝ}
    (h0 : restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X) ≠ 0) :
    ∃ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c q ≠ 0 := by
  by_contra hcon
  push Not at hcon
  apply h0
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  show pairVec j k c (X : Matrix (Fin n) (Fin n) ℝ) = 0
  unfold pairVec
  exact Finset.sum_eq_zero fun i hi => by rw [hcon i hi, zero_smul]

/-- `pairVec` is symmetric in its pair. -/
theorem pairVec_comm (c : Fin n → ℝ) : pairVec j k c = pairVec k j c := by
  funext Y
  unfold pairVec
  have hf : univ.filter (fun i => j ≠ i ∧ k ≠ i) = univ.filter (fun i => k ≠ i ∧ j ≠ i) := by
    ext i; simp [and_comm]
  rw [hf]
  refine Finset.sum_congr rfl fun i _ => ?_
  unfold rk2
  rw [add_comm]

/-- **L27's pair sector at a sphere product**: an `L_e`-eigenvalue on a nonzero Weyl component of character `ε_j ε_k` is at
most `1/2`, and equals `1/2` only when exactly one of `j, k` lies in `T`. -/
theorem pair_sphere (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) (hjk : j ≠ k) {V : CurvOp2 (Fin n)} (hVW : IsWeyl2 V)
    (hV : SignChar (setChar {j, k}) V) (hV0 : V ≠ 0) {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t))) V = lam • V) :
    lam ≤ 1 / 2 ∧ (lam = 1 / 2 → (j ∈ T ∧ k ∉ T) ∨ (j ∉ T ∧ k ∈ T)) := by
  obtain ⟨c, hsum, rfl⟩ := pair_eq_pairVec hjk hVW hV
  have hne := pairVec_ne hV0
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hmu : 0 ≤ ((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)) := by
    apply div_nonneg <;> nlinarith
  have hlp : ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) < 1 / 2 := by
    rw [div_lt_iff₀ (by linarith)]; linarith
  have hlq : ((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1)) < 1 / 2 := by
    rw [div_lt_iff₀ (by linarith)]; linarith
  by_cases hj : j ∈ T <;> by_cases hk : k ∈ T
  · -- within `T`
    rcases within_LeLin_spectrum T hp hq t ht hn hj hk hjk c hsum hne lam heig with h | h | h
    · exact ⟨by rw [h]; norm_num, fun h' => by rw [h] at h'; norm_num at h'⟩
    · exact ⟨by rw [h]; exact hlp.le, fun h' => by rw [h] at h'; linarith⟩
    · exact ⟨by rw [h]; linarith, fun h' => by rw [h] at h'; linarith⟩
  · -- cross, `j ∈ T`
    rcases cross_LeLin_spectrum T hp hq t ht hn hj hk c hsum hne lam heig with h | h
    · exact ⟨by rw [h]; norm_num, fun _ => Or.inl ⟨hj, hk⟩⟩
    · exact ⟨by rw [h], fun _ => Or.inl ⟨hj, hk⟩⟩
  · -- cross, `k ∈ T`
    have e : pairVec j k c = pairVec k j c := pairVec_comm c
    have hf : univ.filter (fun i => j ≠ i ∧ k ≠ i) = univ.filter (fun i => k ≠ i ∧ j ≠ i) := by
      ext i; simp [and_comm]
    rw [hf] at hsum hne
    have heig' : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t)))
        (restrictLin (pairVec_lin k j c) (fun X _ => pairVec_skew k j c X))
        = lam • restrictLin (pairVec_lin k j c) (fun X _ => pairVec_skew k j c X) := by
      have hv : restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X)
          = restrictLin (pairVec_lin k j c) (fun X _ => pairVec_skew k j c X) :=
        ContinuousLinearMap.ext fun X => Subtype.ext (by
          show pairVec j k c (X : Matrix (Fin n) (Fin n) ℝ) = pairVec k j c (X : Matrix (Fin n) (Fin n) ℝ)
          rw [e])
      rw [← hv]; exact heig
    rcases cross_LeLin_spectrum T hp hq t ht hn hk hj c hsum hne lam heig' with h | h
    · exact ⟨by rw [h]; norm_num, fun _ => Or.inr ⟨hj, hk⟩⟩
    · exact ⟨by rw [h], fun _ => Or.inr ⟨hj, hk⟩⟩
  · -- within `Tᶜ`
    rcases within_LeLin_spectrum_out T hp hq t ht hn hj hk hjk c hsum hne lam heig with h | h | h
    · exact ⟨by rw [h]; norm_num, fun h' => by rw [h] at h'; norm_num at h'⟩
    · exact ⟨by rw [h]; exact hlq.le, fun h' => by rw [h] at h'; linarith⟩
    · exact ⟨by rw [h]; linarith, fun h' => by rw [h] at h'; linarith⟩

end HamiltonsCubic.L27Pair
