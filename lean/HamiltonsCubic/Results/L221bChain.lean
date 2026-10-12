import Mathlib
import HamiltonsCubic.Results.L221bRay
import HamiltonsCubic.Results.L221Statement

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L221 (b), the per-block chain: `(5/6) θ² ≤ 1 − N/2 + N_i` on a block with `ν_i ≠ 0`

[findings/second-order.md](../../../findings/second-order.md), Lemma L221 (b), steps 2 and 4: *the pinning inequality
$u_i=\lVert q_i\rVert\ge\theta/\sqrt3$ whenever $\nu_i\ne0$*, and *pairing the $\mathcal D_n$ equation with $q_i$ …
$\theta u_i-\tfrac{u_i^2}{2\sqrt3}\le\tfrac1{\sqrt3}\big(1-\tfrac N2+N_i\big)$ … so $u_i\ge\theta/\sqrt3$ gives
$\tfrac56\theta^2\le1-\tfrac N2+N_i$.*

* **`block_chain`**: on one block `V_Q` with `ν ≠ 0`, from the `𝒟ₙ` equation `D ∘ D + ν ∘ ν + P_j + P_k = θ D` (the other
  blocks' squares), the pinning pairing `2⟨D ∘ ν, ν⟩ + 2τ = θ ‖ν‖²` with `τ ≤ 0`, cross bounds
  `⟨P_j, q⟩² ≤ (1/9) ‖P_j‖² ‖q‖²` on `Π_Q` with `‖P_j‖² = ¾ N_j²`, and the norm `‖D‖² + ‖ν‖² + N_j + N_k = 1`, at
  `3θ² ≥ 1`: `(5/6) θ² ≤ 1 − N/2 + ‖ν‖²`, through `rayleigh_sq`, `step7` and `step8` at `θ' = √3 ‖q‖`, and `per_block`,
  its arithmetic isolated as `chain_real`;
* `cross_helper`: an angle identity `⟨Π_Q(x, …), Π_{Q'}(x', …)⟩ = x x'` gives the cross bound for `ν' ∘ ν'`, through `Q_nu`;
* **`L221b_bound`**: L221 (b), `θ² ≤ 6/5` at `Q₁ = {a,b,c,d}`, `Q₂ = {a,b,e,f}`, `Q₃ = {c,d,e,f}` with two nonzero blocks and
  `τ ≤ 0`, through `L221b_split`, the symmetry of `τ`, the characters' orthogonality, `block_chain` on each nonzero block and
  `sum_two`, `sum_three`.
-/

namespace HamiltonsCubic.L221bChain

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent HamiltonsCubic.FourProd
  HamiltonsCubic.L222Op HamiltonsCubic.FourPi HamiltonsCubic.FourStep4 HamiltonsCubic.FourStep5 HamiltonsCubic.FrameOp2
  HamiltonsCubic.FrameLayer HamiltonsCubic.L224Norm HamiltonsCubic.L224Cubic HamiltonsCubic.ItemFour HamiltonsCubic.PairNorm
  HamiltonsCubic.L224Rank HamiltonsCubic.FourStep67 HamiltonsCubic.FourStep8 HamiltonsCubic.BlockSub HamiltonsCubic.FourL220

variable {n : ℕ} {i j k l : Fin n}

/-- A square bound gives the value bound: `X² ≤ Y²`, `0 ≤ Y` give `X ≤ Y`. -/
theorem le_of_sq_le {X Y : ℝ} (h : X ^ 2 ≤ Y ^ 2) (hY : 0 ≤ Y) : X ≤ Y := by
  by_contra hc
  push Not at hc
  nlinarith [mul_self_lt_mul_self hY hc]

/-- **The chain's arithmetic**, every operator quantity replaced by a real. -/
theorem chain_real {θ Ni Nj Nk u s F Pq κ Cj Ck R : ℝ} (hs3 : s ^ 2 = 3) (hs0 : 0 < s) (hθ : 0 < θ)
    (hNi : 0 < Ni) (hNj : 0 ≤ Nj) (hNk : 0 ≤ Nk) (hu0' : 0 ≤ u)
    (hF1 : θ * Ni / 2 ≤ F) (hF2 : F ^ 2 ≤ 3 / 4 * u ^ 2 * Ni ^ 2)
    (hpair : Pq + κ + F + Cj + Ck = θ * u ^ 2) (h7 : 6 * Pq ≤ (s * u) ^ 3) (h8 : 3 * κ ≤ s * u * R)
    (hCj : Cj ^ 2 ≤ 1 / 9 * (3 / 4 * Nj ^ 2) * u ^ 2) (hCk : Ck ^ 2 ≤ 1 / 9 * (3 / 4 * Nk ^ 2) * u ^ 2)
    (hR : R = 1 - Ni - Nj - Nk - u ^ 2) (hR0 : 0 ≤ R) (hθs : 1 ≤ s * θ) :
    5 / 6 * θ ^ 2 ≤ 1 - (Ni + Nj + Nk) / 2 + Ni := by
  have hFle : F ≤ s / 2 * u * Ni := by
    refine le_of_sq_le ?_ (mul_nonneg (mul_nonneg (by linarith) hu0') hNi.le)
    have e : (s / 2 * u * Ni) ^ 2 = 3 / 4 * u ^ 2 * Ni ^ 2 := by rw [mul_pow, mul_pow, div_pow, hs3]; ring
    rw [e]; exact hF2
  have hpinu : θ ≤ s * u := by
    have h2 : θ * Ni ≤ s * u * Ni := by linarith
    exact le_of_mul_le_mul_right h2 hNi
  have hu0 : 0 < u := by
    rcases hu0'.lt_or_eq with h | h
    · exact h
    · rw [← h, mul_zero] at hpinu; linarith
  have hcross : ∀ C N : ℝ, 0 ≤ N → C ^ 2 ≤ 1 / 9 * (3 / 4 * N ^ 2) * u ^ 2 → C ≤ s / 6 * u * N := by
    intro C N hN h
    refine le_of_sq_le ?_ (mul_nonneg (mul_nonneg (by linarith) hu0') hN)
    have e : (s / 6 * u * N) ^ 2 = 1 / 9 * (3 / 4 * N ^ 2) * u ^ 2 := by rw [mul_pow, mul_pow, div_pow, hs3]; ring
    rw [e]; exact h
  have hcj := hcross Cj Nj hNj hCj
  have hck := hcross Ck Nk hNk hCk
  have hsu3 : (s * u) ^ 3 = 3 * s * u ^ 3 := by
    have : (s * u) ^ 3 = s ^ 2 * s * u ^ 3 := by ring
    rw [this, hs3]
  rw [hsu3] at h7
  have hA : θ * u ^ 2 ≤ s * u ^ 3 / 2 + s * u / 3 * R + s / 2 * u * Ni + s / 6 * u * (Nj + Nk) := by
    rw [← hpair]; linarith [h8, hcj, hck, hFle, h7]
  have hAu : θ * u ^ 2 ≤ u * (s / 3 * (u ^ 2 / 2 + (1 - (Ni + Nj + Nk) / 2 + Ni))) := by
    have e1 : s * u ^ 3 / 2 + s * u / 3 * R + s / 2 * u * Ni + s / 6 * u * (Nj + Nk)
        = u * (s / 3 * (u ^ 2 / 2 + (1 - (Ni + Nj + Nk) / 2 + Ni))) := by rw [hR]; ring
    linarith
  have hdiv : θ * u ≤ s / 3 * (u ^ 2 / 2 + (1 - (Ni + Nj + Nk) / 2 + Ni)) := by
    have e2 : θ * u ^ 2 = u * (θ * u) := by ring
    rw [e2] at hAu
    exact le_of_mul_le_mul_left hAu hu0
  have hss : s * s = 3 := by rw [← sq]; exact hs3
  have hinv : 1 / s = s / 3 := by
    rw [div_eq_div_iff hs0.ne' (by norm_num)]; linarith
  have hchain : θ * u ≤ u ^ 2 / (2 * s) + (1 - (Ni + Nj + Nk) / 2 + Ni) / s := by
    have e3 : u ^ 2 / (2 * s) + (1 - (Ni + Nj + Nk) / 2 + Ni) / s
        = (u ^ 2 / 2 + (1 - (Ni + Nj + Nk) / 2 + Ni)) * (1 / s) := by ring
    rw [e3, hinv]
    linarith
  have hu1 : u ≤ 1 := by
    have hu21 : u ^ 2 ≤ 1 ^ 2 := by rw [hR] at hR0; nlinarith
    exact le_of_sq_le hu21 zero_le_one
  exact HamiltonsCubic.L221Statement.per_block θ u s (Ni + Nj + Nk) Ni hs3 hs0 hθ hpinu hu1 hθs hchain

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **L221 (b)'s per-block chain.** -/
theorem block_chain {D ν Pj Pk : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hD : SignChar (fun _ => 1) D)
    (hνW : IsWeyl2 ν) (hν : SignChar (setChar {i, j, k, l}) ν) (hν0 : ν ≠ 0) {θ τ Nj Nk : ℝ} (hθ : 0 < θ)
    (hsplit : foxProd2 D D + foxProd2 ν ν + Pj + Pk = θ • D)
    (hpin : 2 * innerOp2 (foxProd2 D ν) ν + 2 * τ = θ * normSq2 ν) (hτ : τ ≤ 0)
    (hPj : ∀ x y z : ℝ, x + y + z = 0 →
      innerOp2 Pj (coordOp (PiQ i j k l x y z)) ^ 2 ≤ 1 / 9 * normSq2 Pj * normSq2 (coordOp (PiQ i j k l x y z)))
    (hPk : ∀ x y z : ℝ, x + y + z = 0 →
      innerOp2 Pk (coordOp (PiQ i j k l x y z)) ^ 2 ≤ 1 / 9 * normSq2 Pk * normSq2 (coordOp (PiQ i j k l x y z)))
    (hPjn : normSq2 Pj = 3 / 4 * Nj ^ 2) (hPkn : normSq2 Pk = 3 / 4 * Nk ^ 2) (hNj : 0 ≤ Nj) (hNk : 0 ≤ Nk)
    (hnorm : normSq2 D + normSq2 ν + Nj + Nk = 1) (hθs : 3 * θ ^ 2 ≥ 1) :
    5 / 6 * θ ^ 2 ≤ 1 - (normSq2 ν + Nj + Nk) / 2 + normSq2 ν := by
  obtain ⟨x, y, z, r, hs, rfl, hrW, hr, hperp⟩ := proj_PiQ hij hik hil hjk hjl hkl hDW hD
  obtain ⟨s, hs3, hs0⟩ : ∃ s : ℝ, s ^ 2 = 3 ∧ 0 < s := ⟨Real.sqrt 3, Real.sq_sqrt (by norm_num), Real.sqrt_pos.mpr (by norm_num)⟩
  have hNi : 0 < normSq2 ν := by
    rcases (normSq2_nonneg ν).lt_or_eq with h | h
    · exact h
    · exact absurd (normSq2_eq_zero h.symm) hν0
  obtain ⟨u, hu2, hu0'⟩ : ∃ u : ℝ, u ^ 2 = normSq2 (coordOp (PiQ i j k l x y z)) ∧ 0 ≤ u :=
    ⟨Real.sqrt _, Real.sq_sqrt (normSq2_nonneg _), Real.sqrt_nonneg _⟩
  have hqW : IsWeyl2 (coordOp (PiQ i j k l x y z)) := by
    rw [coordOp_eq_restrict (PiQ_weight hij hik hil hjk hjl hkl hs)]; exact isWeyl2_restrict _
  have hqs := hqW.isSelfAdjoint2
  have hrs := hrW.isSelfAdjoint2
  have hνs := hνW.isSelfAdjoint2
  have hLr := Lr_zero hij hik hil hjk hjl hkl hrW hr hperp hνW hν
  have hr0 : innerOp2 (foxProd2 r ν) ν = 0 := by
    rw [hLr]
    have h := innerOp2_add_left (0 : CurvOp2 (Fin n)) 0 ν
    have h00 : (0 : CurvOp2 (Fin n)) + 0 = 0 := add_zero (0 : CurvOp2 (Fin n))
    rw [h00] at h
    linarith
  have hDν : innerOp2 (foxProd2 (coordOp (PiQ i j k l x y z) + r) ν) ν
      = innerOp2 (foxProd2 (coordOp (PiQ i j k l x y z)) ν) ν := by
    rw [HamiltonsCubic.RealLayer.foxProd2_add_left, innerOp2_add_left, hr0, add_zero]
  rw [hDν] at hpin
  have hray := HamiltonsCubic.L221bRay.rayleigh_sq hij hik hil hjk hjl hkl hs hνW hν
  rw [← hu2] at hray
  have hqq : foxProd2 (coordOp (PiQ i j k l x y z)) (coordOp (PiQ i j k l x y z))
      = coordOp (PiQ i j k l (x * x + y * z + z * y) (y * y + z * x + x * z) (z * z + x * y + y * x)) :=
    PiQ_mul hij hik hil hjk hjl hkl x y z x y z
  have hqrq : innerOp2 (foxProd2 (coordOp (PiQ i j k l x y z)) r) (coordOp (PiQ i j k l x y z)) = 0 := by
    rw [foxProd2_comm, inner_fox_move hrs hqs hqs, hqq]
    exact hperp _ _ _ (PiQ_closed hs hs)
  have hνν : innerOp2 (foxProd2 ν ν) (coordOp (PiQ i j k l x y z))
      = innerOp2 (foxProd2 (coordOp (PiQ i j k l x y z)) ν) ν := by
    rw [innerOp2_comm, ← inner_fox_move hqs hνs hνs]
  have hrq : innerOp2 r (coordOp (PiQ i j k l x y z)) = 0 := hperp x y z hs
  have hP : Pcubic2 (coordOp (PiQ i j k l x y z))
      = innerOp2 (foxProd2 (coordOp (PiQ i j k l x y z)) (coordOp (PiQ i j k l x y z))) (coordOp (PiQ i j k l x y z)) := by
    rw [Pcubic2_eq_innerOp2, ← foxProd2_self, innerOp2_comm]
  have hpair := congrArg (fun T => innerOp2 T (coordOp (PiQ i j k l x y z))) hsplit
  simp only [innerOp2_add_left, innerOp2_smul_left, hrq, add_zero] at hpair
  have hDD : foxProd2 (coordOp (PiQ i j k l x y z) + r) (coordOp (PiQ i j k l x y z) + r)
      = foxProd2 (coordOp (PiQ i j k l x y z)) (coordOp (PiQ i j k l x y z))
        + (2 : ℝ) • foxProd2 (coordOp (PiQ i j k l x y z)) r + foxProd2 r r := by
    rw [foxProd2_self, L219Prod.Qop2_add, foxProd2_self, foxProd2_self]; abel
  rw [hDD, innerOp2_add_left, innerOp2_add_left, innerOp2_smul_left, hqrq, hνν, ← hP] at hpair
  have hsu : 3 * normSq2 (coordOp (PiQ i j k l x y z)) = (s * u) ^ 2 := by rw [mul_pow, hs3, hu2]
  have hsu0 : 0 ≤ s * u := mul_nonneg hs0.le hu0'
  have h7 := step7 hij hik hil hjk hjl hkl hs hsu0 hsu
  have h8 := step8 hij hik hil hjk hjl hkl hs hsu0 hsu hrW hr hperp
  have hcj := hPj x y z hs
  have hck := hPk x y z hs
  rw [hPjn, ← hu2] at hcj
  rw [hPkn, ← hu2] at hck
  have hqr : normSq2 (coordOp (PiQ i j k l x y z) + r) = normSq2 (coordOp (PiQ i j k l x y z)) + normSq2 r := by
    unfold normSq2
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_comm (coordOp (PiQ i j k l x y z)) r, hrq]
    ring
  rw [hqr] at hnorm
  refine chain_real hs3 hs0 hθ hNi hNj hNk hu0' (by linarith) hray ?_ h7 h8 hcj hck ?_
    (normSq2_nonneg r) (by
      refine le_of_sq_le ?_ (mul_nonneg hs0.le hθ.le)
      rw [mul_pow, hs3]; linarith)
  · rw [hu2]; unfold normSq2; linarith
  · rw [hu2]; linarith
end

/-- `‖0‖² = 0`. -/
theorem normSq2_zero' : normSq2 (0 : CurvOp2 (Fin n)) = 0 := by
  unfold normSq2
  have h := innerOp2_add_left (0 : CurvOp2 (Fin n)) 0 0
  have h00 : (0 : CurvOp2 (Fin n)) + 0 = 0 := add_zero (0 : CurvOp2 (Fin n))
  rw [h00] at h
  linarith

/-- **A cross bound from an angle identity**: when `⟨Π_{Q}(x,y,z), Π_{Q'}(x',y',z')⟩ = x x'`, the square `ν' ∘ ν'` of a `χ_{Q'}`
operator has `⟨ν' ∘ ν', q⟩² ≤ (1/9) ‖ν' ∘ ν'‖² ‖q‖²` at every `q ∈ Π_Q`. -/
theorem cross_helper {p q r s p' q' r' s' : Fin n} (h1 : p ≠ q) (h2 : p ≠ r) (h3 : p ≠ s) (h4 : q ≠ r) (h5 : q ≠ s)
    (h6 : r ≠ s) (h1' : p' ≠ q') (h2' : p' ≠ r') (h3' : p' ≠ s') (h4' : q' ≠ r') (h5' : q' ≠ s') (h6' : r' ≠ s')
    (hang : ∀ x y z x' y' z' : ℝ,
      innerOp2 (coordOp (PiQ p q r s x y z)) (coordOp (PiQ p' q' r' s' x' y' z')) = x * x')
    {ν : CurvOp2 (Fin n)} (hW : IsWeyl2 ν) (hν : SignChar (setChar {p', q', r', s'}) ν) :
    ∀ x y z : ℝ, x + y + z = 0 →
      innerOp2 (foxProd2 ν ν) (coordOp (PiQ p q r s x y z)) ^ 2
        ≤ 1 / 9 * normSq2 (foxProd2 ν ν) * normSq2 (coordOp (PiQ p q r s x y z)) := by
  intro x y z hs
  obtain ⟨α, β, rfl⟩ := four_eq_sig h1' h2' h3' h4' h5' h6' hW hν
  rw [foxProd2_self, HamiltonsCubic.FourEq.Q_nu h1' h2' h3' h4' h5' h6' α β, innerOp2_comm, hang,
    normSq2_PiQ h1' h2' h3' h4' h5' h6', normSq2_PiQ h1 h2 h3 h4 h5 h6]
  have hc := HamiltonsCubic.L221bRay.cross_sq hs (x' := 2 * α ^ 2 - (-β) ^ 2 - (β - α) ^ 2)
    (y' := 2 * (-β) ^ 2 - (β - α) ^ 2 - α ^ 2) (z' := 2 * (β - α) ^ 2 - α ^ 2 - (-β) ^ 2) (by ring) rfl rfl rfl
  linarith

section Final
variable {a b c d e f : Fin n} (hab : a ≠ b) (hac : a ≠ c) (had : a ≠ d) (hae : a ≠ e) (haf : a ≠ f)
  (hbc : b ≠ c) (hbd : b ≠ d) (hbe : b ≠ e) (hbf : b ≠ f) (hcd : c ≠ d) (hce : c ≠ e) (hcf : c ≠ f)
  (hde : d ≠ e) (hdf : d ≠ f) (hef : e ≠ f)
include hab hac had hae haf hbc hbd hbe hbf hcd hce hcf hde hdf hef

/-- **L221 (b) on the operators**: at `Q₁ = {a,b,c,d}`, `Q₂ = {a,b,e,f}` sharing two indices and `Q₃ = Q₁ ∆ Q₂ = {c,d,e,f}`,
every unit critical point `W = D + ν₁ + ν₂ + ν₃` of `P` with `D` of character `1`, `ν_i` of character `χ_{Q_i}`, at least
two `ν_i ≠ 0`, `τ = ⟨ν₁ ∘ ν₂, ν₃⟩ ≤ 0` and `θ > 0` has `θ² ≤ 6/5`. -/
theorem L221b_bound {D ν₁ ν₂ ν₃ : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hD : SignChar (fun _ => 1) D)
    (hW1 : IsWeyl2 ν₁) (h1 : SignChar (setChar {a, b, c, d}) ν₁)
    (hW2 : IsWeyl2 ν₂) (h2 : SignChar (setChar {a, b, e, f}) ν₂)
    (hW3 : IsWeyl2 ν₃) (h3 : SignChar (setChar {c, d, e, f}) ν₃) {θ : ℝ} (hθ : 0 < θ)
    (hQ : Qop2 (D + ν₁ + ν₂ + ν₃) = θ • (D + ν₁ + ν₂ + ν₃)) (hunit : normSq2 (D + ν₁ + ν₂ + ν₃) = 1)
    (hτ : innerOp2 (foxProd2 ν₁ ν₂) ν₃ ≤ 0)
    (htwo : (ν₁ ≠ 0 ∧ ν₂ ≠ 0) ∨ (ν₁ ≠ 0 ∧ ν₃ ≠ 0) ∨ (ν₂ ≠ 0 ∧ ν₃ ≠ 0)) : θ ^ 2 ≤ 6 / 5 := by
  -- the four equations
  have hsd : symmDiff ({a, b, c, d} : Finset (Fin n)) {a, b, e, f} = {c, d, e, f} := by
    ext x
    simp only [Finset.mem_symmDiff, Finset.mem_insert, Finset.mem_singleton]
    grind
  have hc1 : c ∈ ({a, b, c, d} : Finset (Fin n)) := by simp
  have hc2 : c ∉ ({a, b, e, f} : Finset (Fin n)) := by simp [Ne.symm hac, Ne.symm hbc, hce, hcf]
  have he2 : e ∈ ({a, b, e, f} : Finset (Fin n)) := by simp
  have he1 : e ∉ ({a, b, c, d} : Finset (Fin n)) := by simp [Ne.symm hae, Ne.symm hbe, Ne.symm hce, Ne.symm hde]
  have h3' : SignChar (setChar (symmDiff ({a, b, c, d} : Finset (Fin n)) {a, b, e, f})) ν₃ := by rw [hsd]; exact h3
  obtain ⟨hDeq, hE1, hE2, hE3⟩ := HamiltonsCubic.L221Ops.L221b_split hc1 hc2 he2 he1 hD h1 h2 h3' hQ
  have s1 := hW1.isSelfAdjoint2
  have s2 := hW2.isSelfAdjoint2
  have s3 := hW3.isSelfAdjoint2
  -- `τ` is symmetric
  set τ := innerOp2 (foxProd2 ν₁ ν₂) ν₃ with hτdef
  have t1 : innerOp2 (foxProd2 ν₂ ν₃) ν₁ = τ := by rw [innerOp2_comm, ← inner_fox_move s1 s2 s3]
  have t2 : innerOp2 (foxProd2 ν₁ ν₃) ν₂ = τ := by
    rw [inner_fox_move s1 s3 s2, foxProd2_comm ν₃ ν₂, ← inner_fox_move s1 s2 s3]
  -- the pinning pairings
  have pin : ∀ {μ A : CurvOp2 (Fin n)}, (2 : ℝ) • foxProd2 D μ + (2 : ℝ) • A = θ • μ → innerOp2 A μ = τ →
      2 * innerOp2 (foxProd2 D μ) μ + 2 * τ = θ * normSq2 μ := by
    intro μ A h hA
    have := congrArg (fun T => innerOp2 T μ) h
    simp only [innerOp2_add_left, innerOp2_smul_left, hA] at this
    unfold normSq2; linarith
  have p1 := pin hE1 t1
  have p2 := pin hE2 t2
  have p3 := pin hE3 rfl
  -- the norm, the components being orthogonal
  open HamiltonsCubic.L221aChain in
  have o : ∀ {s t : Finset (Fin n)} {A B : CurvOp2 (Fin n)} (z : Fin n), SignChar (setChar s) A →
      SignChar (setChar t) B → z ∈ s → z ∉ t → innerOp2 A B = 0 ∧ innerOp2 B A = 0 := by
    intro s t A B z hA hB hzs hzt
    have hAB := char_orth hA hB (flip_sq z) (by rw [setChar_flip, setChar_flip, if_pos hzs, if_neg hzt]; norm_num)
    exact ⟨hAB, by rw [innerOp2_comm]; exact hAB⟩
  have oD : ∀ {s : Finset (Fin n)} {B : CurvOp2 (Fin n)} (z : Fin n), SignChar (setChar s) B → z ∈ s →
      innerOp2 D B = 0 ∧ innerOp2 B D = 0 := by
    intro s B z hB hzs
    have hDB := char_orth hD hB (HamiltonsCubic.L221aChain.flip_sq z)
      (by rw [HamiltonsCubic.L221aChain.setChar_flip, if_pos hzs]; norm_num)
    exact ⟨hDB, by rw [innerOp2_comm]; exact hDB⟩
  have ha1 : a ∈ ({a, b, c, d} : Finset (Fin n)) := by simp
  have ha2 : a ∈ ({a, b, e, f} : Finset (Fin n)) := by simp
  have hc3 : c ∈ ({c, d, e, f} : Finset (Fin n)) := by simp
  have ha3 : a ∉ ({c, d, e, f} : Finset (Fin n)) := by simp [hac, had, hae, haf]
  obtain ⟨o1, o1'⟩ := oD a h1 ha1
  obtain ⟨o2, o2'⟩ := oD a h2 ha2
  obtain ⟨o3, o3'⟩ := oD c h3 hc3
  obtain ⟨o12, o12'⟩ := o c h1 h2 hc1 hc2
  obtain ⟨o13, o13'⟩ := o a h1 h3 ha1 ha3
  obtain ⟨o23, o23'⟩ := o a h2 h3 ha2 ha3
  have hnorm : normSq2 D + normSq2 ν₁ + normSq2 ν₂ + normSq2 ν₃ = 1 := by
    rw [← hunit]
    unfold normSq2
    simp only [innerOp2_add_left, innerOp2_add_right, o1, o1', o2, o2', o3, o3', o12, o12', o13, o13', o23, o23']
    ring
  have N1 := normSq2_nonneg ν₁
  have N2 := normSq2_nonneg ν₂
  have N3 := normSq2_nonneg ν₃
  -- the small-`θ` case
  by_cases hθs : 3 * θ ^ 2 ≥ 1
  swap
  · push Not at hθs; linarith
  -- the three blocks
  have b1 : ν₁ ≠ 0 → 5 / 6 * θ ^ 2 ≤ 1 - (normSq2 ν₁ + normSq2 ν₂ + normSq2 ν₃) / 2 + normSq2 ν₁ := fun h0 =>
    HamiltonsCubic.L221bChain.block_chain hab hac had hbc hbd hcd hDW hD hW1 h1 h0 hθ hDeq p1 hτ
      (cross_helper hab hac had hbc hbd hcd hab hae haf hbe hbf hef
        (fun x y z x' y' z' => HamiltonsCubic.L221bRay.angle12 hab hac had hae haf hbc hbd hbe hbf hcd hce hcf hde hdf hef
          x y z x' y' z') hW2 h2)
      (cross_helper hab hac had hbc hbd hcd hcd hce hcf hde hdf hef
        (fun x y z x' y' z' => HamiltonsCubic.L221bRay.angle13 hab hac had hae haf hbc hbd hbe hbf hcd hce hcf hde hdf hef
          x y z x' y' z') hW3 h3)
      (HamiltonsCubic.L221bRay.nunu_normSq hab hae haf hbe hbf hef hW2 h2)
      (HamiltonsCubic.L221bRay.nunu_normSq hcd hce hcf hde hdf hef hW3 h3) N2 N3 (by linarith) hθs
  have hDeq2 : foxProd2 D D + foxProd2 ν₂ ν₂ + foxProd2 ν₁ ν₁ + foxProd2 ν₃ ν₃ = θ • D := by rw [← hDeq]; abel
  have hDeq3 : foxProd2 D D + foxProd2 ν₃ ν₃ + foxProd2 ν₁ ν₁ + foxProd2 ν₂ ν₂ = θ • D := by rw [← hDeq]; abel
  have b2 : ν₂ ≠ 0 → 5 / 6 * θ ^ 2 ≤ 1 - (normSq2 ν₂ + normSq2 ν₁ + normSq2 ν₃) / 2 + normSq2 ν₂ := fun h0 =>
    HamiltonsCubic.L221bChain.block_chain hab hae haf hbe hbf hef hDW hD hW2 h2 h0 hθ hDeq2 p2 hτ
      (cross_helper hab hae haf hbe hbf hef hab hac had hbc hbd hcd
        (fun x y z x' y' z' => by
          rw [innerOp2_comm, HamiltonsCubic.L221bRay.angle12 hab hac had hae haf hbc hbd hbe hbf hcd hce hcf hde hdf hef]
          ring) hW1 h1)
      (cross_helper hab hae haf hbe hbf hef hcd hce hcf hde hdf hef
        (fun x y z x' y' z' => HamiltonsCubic.L221bRay.angle23 hab hac had hae haf hbc hbd hbe hbf hcd hce hcf hde hdf hef
          x y z x' y' z') hW3 h3)
      (HamiltonsCubic.L221bRay.nunu_normSq hab hac had hbc hbd hcd hW1 h1)
      (HamiltonsCubic.L221bRay.nunu_normSq hcd hce hcf hde hdf hef hW3 h3) N1 N3 (by linarith) hθs
  have b3 : ν₃ ≠ 0 → 5 / 6 * θ ^ 2 ≤ 1 - (normSq2 ν₃ + normSq2 ν₁ + normSq2 ν₂) / 2 + normSq2 ν₃ := fun h0 =>
    HamiltonsCubic.L221bChain.block_chain hcd hce hcf hde hdf hef hDW hD hW3 h3 h0 hθ hDeq3 p3 hτ
      (cross_helper hcd hce hcf hde hdf hef hab hac had hbc hbd hcd
        (fun x y z x' y' z' => by
          rw [innerOp2_comm, HamiltonsCubic.L221bRay.angle13 hab hac had hae haf hbc hbd hbe hbf hcd hce hcf hde hdf hef]
          ring) hW1 h1)
      (cross_helper hcd hce hcf hde hdf hef hab hae haf hbe hbf hef
        (fun x y z x' y' z' => by
          rw [innerOp2_comm, HamiltonsCubic.L221bRay.angle23 hab hac had hae haf hbc hbd hbe hbf hcd hce hcf hde hdf hef]
          ring) hW2 h2)
      (HamiltonsCubic.L221bRay.nunu_normSq hab hac had hbc hbd hcd hW1 h1)
      (HamiltonsCubic.L221bRay.nunu_normSq hab hae haf hbe hbf hef hW2 h2) N1 N2 (by linarith) hθs
  -- sum over the nonzero blocks
  have z : ∀ {μ : CurvOp2 (Fin n)}, μ = 0 → normSq2 μ = 0 := fun h => by rw [h]; exact normSq2_zero'
  by_cases z1 : ν₁ = 0 <;> by_cases z2 : ν₂ = 0 <;> by_cases z3 : ν₃ = 0
  all_goals first
    | (exfalso; rcases htwo with ⟨h, h'⟩ | ⟨h, h'⟩ | ⟨h, h'⟩ <;> contradiction)
    | skip
  all_goals first
    | (have e1 := z z1
       exact HamiltonsCubic.L221Statement.sum_two θ (normSq2 ν₂ + normSq2 ν₃) (normSq2 ν₂) (normSq2 ν₃) rfl
         (by linarith [b2 z2]) (by linarith [b3 z3]))
    | (have e2 := z z2
       exact HamiltonsCubic.L221Statement.sum_two θ (normSq2 ν₁ + normSq2 ν₃) (normSq2 ν₁) (normSq2 ν₃) rfl
         (by linarith [b1 z1]) (by linarith [b3 z3]))
    | (have e3 := z z3
       exact HamiltonsCubic.L221Statement.sum_two θ (normSq2 ν₁ + normSq2 ν₂) (normSq2 ν₁) (normSq2 ν₂) rfl
         (by linarith [b1 z1]) (by linarith [b2 z2]))
    | exact HamiltonsCubic.L221Statement.sum_three θ (normSq2 ν₁ + normSq2 ν₂ + normSq2 ν₃) (normSq2 ν₁) (normSq2 ν₂)
         (normSq2 ν₃) rfl (by linarith) (by linarith [b1 z1]) (by linarith [b2 z2]) (by linarith [b3 z3])

end Final

end HamiltonsCubic.L221bChain
