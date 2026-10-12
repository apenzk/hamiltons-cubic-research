import Mathlib
import HamiltonsCubic.Results.L221aChain

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L220's step 5 as a Rayleigh bound: `⟨q ∘ ν, ν⟩² ≤ ¾ ‖q‖² ‖ν‖⁴` on `V_Q`

[findings/second-order.md](../../../findings/second-order.md), Lemma L221 (b), step 2: *L220's step 4 gives
$\langle D\circ\nu_i,\nu_i\rangle=\langle L_{q_i}\nu_i,\nu_i\rangle$ … With L220's step 5 and $\tau\le0$:
$\tfrac{\sqrt3}2u_iN_i\ge\tfrac\theta2N_i$.* L220's step 5 is typed in [FourStep5.lean](FourStep5.lean) for an eigenvector of
`L_q` on `V_Q`. (b) uses it as a bound on the quadratic form, `⟨L_q ν, ν⟩ ≤ (√3/2) ‖q‖ ‖ν‖²`, at every `ν ∈ V_Q`:

* `nunu_normSq`, `‖ν ∘ ν‖² = ¾ ‖ν‖⁴` on `V_Q`, (b)'s step 3; `cross_sq` and `angle12`, `angle13`, `angle23`, the cross terms
  at `Q₁ = (a, b, c, d)`, `Q₂ = (a, b, e, f)`, `Q₃ = (c, d, e, f)`, each pairing of `Π_{Q_i}` with `Π_{Q_j}` being the product of
  the shared pair's entries, so `⟨p, q⟩² ≤ (1/9) ‖p‖² ‖q‖²`, (b)'s `|⟨q̂_i, q̂_j⟩| ≤ ⅓`;
* **`rayleigh_sq`**: at `q = Π_Q(x, y, z)`, `x + y + z = 0`, and `ν` Weyl of character `χ_Q`,
  `⟨q ∘ ν, ν⟩² ≤ ¾ ‖q‖² ‖ν‖⁴`. With `ν = a σ_A + b σ_B` the three quantities are `−6(y a² − 2(x + y) a b + x b²)`,
  `2(x² + y² + z²)` and `4(a² − a b + b²)`, and the gap is the square `(x(u − 2v) + y(2u − v))²` with
  `u = b² − 2ab`, `v = a² − 2ab`, through the identity `u² − uv + v² = (a² − ab + b²)²`.
-/

namespace HamiltonsCubic.L221bRay

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent HamiltonsCubic.FourProd
  HamiltonsCubic.L222Op HamiltonsCubic.FourPi HamiltonsCubic.FourStep4 HamiltonsCubic.FourStep5 HamiltonsCubic.FrameOp2
  HamiltonsCubic.FrameLayer HamiltonsCubic.L224Norm HamiltonsCubic.L224Cubic HamiltonsCubic.ItemFour HamiltonsCubic.PairNorm
  HamiltonsCubic.L224Rank HamiltonsCubic.FourStep67 HamiltonsCubic.FourStep8 HamiltonsCubic.BlockSub HamiltonsCubic.FourL220

variable {n : ℕ} {i j k l : Fin n}

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **L220's step 5 as a Rayleigh bound on `V_Q`.** -/
theorem rayleigh_sq {x y z : ℝ} (hs : x + y + z = 0) {ν : CurvOp2 (Fin n)} (hνW : IsWeyl2 ν)
    (hν : SignChar (setChar {i, j, k, l}) ν) :
    innerOp2 (foxProd2 (coordOp (PiQ i j k l x y z)) ν) ν ^ 2
      ≤ 3 / 4 * normSq2 (coordOp (PiQ i j k l x y z)) * normSq2 ν ^ 2 := by
  obtain ⟨a, b, rfl⟩ := four_eq_sig hij hik hil hjk hjl hkl hνW hν
  set q := coordOp (PiQ i j k l x y z) with hqdef
  set sA := sig4 i k j l with hsA
  set sB := sig4 i j k l with hsB
  have hqW : IsWeyl2 q := by
    rw [hqdef, coordOp_eq_restrict (PiQ_weight hij hik hil hjk hjl hkl hs)]; exact isWeyl2_restrict _
  have hqs : IsSelfAdjoint2 q := hqW.isSelfAdjoint2
  have hAW : IsWeyl2 sA := sig_weyl hik hjl hij hil (Ne.symm hjk) hkl
  have hBW : IsWeyl2 sB := sig_weyl hij hkl hik hil hjk hjl
  have hνs : IsSelfAdjoint2 (a • sA + b • sB) := (isWeyl2_add (isWeyl2_smul _ hAW) (isWeyl2_smul _ hBW)).isSelfAdjoint2
  have hQA : Qop2 sA = coordOp (W4 i k j l) := Q_sig hik hjl hij hil (Ne.symm hjk) hkl
  have hQB : Qop2 sB = coordOp (W4 i j k l) := Q_sig hij hkl hik hil hjk hjl
  have hQC : Qop2 (sig4 i l j k) = coordOp (W4 i l j k) := Q_sig hil hjk hij hik (Ne.symm hjl) (Ne.symm hkl)
  have hfox : (2 : ℝ) • foxProd2 sA sB = coordOp (W4 i l j k) - coordOp (W4 i k j l) - coordOp (W4 i j k l) := by
    have hAB : Qop2 (sA + sB) = coordOp (W4 i l j k) := by
      rw [hsA, hsB, sig_sum hij hik hil hjk hjl hkl,
        show -(sig4 i l j k) = (-1 : ℝ) • sig4 i l j k by module, Qop2_smul, hQC]
      norm_num
    have h2 := L219Prod.Qop2_add sA sB
    rw [hAB, hQA, hQB] at h2
    rw [h2]; abel
  have mA := M_A hij hik hil hjk hjl hkl x y z
  have mB := M_B hij hik hil hjk hjl hkl x y z
  have mC := M_C hij hik hil hjk hjl hkl x y z
  have mAB : innerOp2 q (foxProd2 sA sB)
      = ((2 * x + 2 * y - 4 * z) - (2 * x + 2 * z - 4 * y) - (2 * y + 2 * z - 4 * x)) / 2 := by
    have := congrArg (innerOp2 q) hfox
    rw [innerOp2_smul_right] at this
    have e2 : innerOp2 q (coordOp (W4 i l j k) - coordOp (W4 i k j l) - coordOp (W4 i j k l))
        = innerOp2 q (coordOp (W4 i l j k)) - innerOp2 q (coordOp (W4 i k j l)) - innerOp2 q (coordOp (W4 i j k l)) := by
      rw [innerOp2_comm, innerOp2_sub_left', innerOp2_sub_left', innerOp2_comm _ q, innerOp2_comm _ q, innerOp2_comm _ q]
    rw [e2, mA, mB, mC] at this
    linarith
  have gA := norm_sig hik hjl hij hil (Ne.symm hjk) hkl
  have gB := norm_sig hij hkl hik hil hjk hjl
  have gAB := inner_AB hij hik hil hjk hjl hkl
  -- the form: `⟨q ∘ ν, ν⟩ = ⟨q, ν ∘ ν⟩`
  have hF : innerOp2 (foxProd2 q (a • sA + b • sB)) (a • sA + b • sB)
      = a ^ 2 * (2 * x + 2 * z - 4 * y) + 2 * a * b * innerOp2 q (foxProd2 sA sB) + b ^ 2 * (2 * y + 2 * z - 4 * x) := by
    rw [inner_fox_move hqs hνs hνs, foxProd2_self, L219Prod.Qop2_add, Qop2_smul, Qop2_smul, hQA, hQB,
      foxProd2_smul_left, foxProd2_smul_right, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_right,
      innerOp2_smul_right, innerOp2_smul_right, innerOp2_smul_right, mA, mB, innerOp2_smul_right]
    ring
  have hN : normSq2 (a • sA + b • sB) = 4 * (a ^ 2 - a * b + b ^ 2) := by
    unfold normSq2 at gA gB ⊢
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_left,
      innerOp2_smul_left, innerOp2_smul_left, innerOp2_smul_right, innerOp2_smul_right, innerOp2_smul_right,
      innerOp2_smul_right, gA, gB, gAB, innerOp2_comm sB sA, gAB]
    ring
  have hQn := normSq2_PiQ hij hik hil hjk hjl hkl x y z
  rw [hF, mAB, hN, hQn]
  have hz : z = -x - y := by linarith
  subst hz
  have key : ∀ u v K : ℝ, u ^ 2 - u * v + v ^ 2 = K ^ 2 →
      3 * (x * u + y * v) ^ 2 ≤ 4 * K ^ 2 * (x ^ 2 + x * y + y ^ 2) := by
    intro u v K hK
    nlinarith [sq_nonneg (x * (u - 2 * v) + y * (2 * u - v))]
  have hK : (b ^ 2 - 2 * a * b) ^ 2 - (b ^ 2 - 2 * a * b) * (a ^ 2 - 2 * a * b) + (a ^ 2 - 2 * a * b) ^ 2
      = (a ^ 2 - a * b + b ^ 2) ^ 2 := by ring
  have h := key _ _ _ hK
  nlinarith [h]

/-- **`‖ν ∘ ν‖² = ¾ ‖ν‖⁴` on `V_Q`**, (b)'s step 3 at the operators. -/
theorem nunu_normSq {ν : CurvOp2 (Fin n)} (hνW : IsWeyl2 ν) (hν : SignChar (setChar {i, j, k, l}) ν) :
    normSq2 (foxProd2 ν ν) = 3 / 4 * normSq2 ν ^ 2 := by
  obtain ⟨a, b, rfl⟩ := four_eq_sig hij hik hil hjk hjl hkl hνW hν
  have hAW : IsWeyl2 (sig4 i k j l) := sig_weyl hik hjl hij hil (Ne.symm hjk) hkl
  have hBW : IsWeyl2 (sig4 i j k l) := sig_weyl hij hkl hik hil hjk hjl
  have gA := norm_sig hik hjl hij hil (Ne.symm hjk) hkl
  have gB := norm_sig hij hkl hik hil hjk hjl
  have gAB := inner_AB hij hik hil hjk hjl hkl
  have hN : normSq2 (a • sig4 i k j l + b • sig4 i j k l) = 4 * (a ^ 2 - a * b + b ^ 2) := by
    unfold normSq2 at gA gB ⊢
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_left,
      innerOp2_smul_left, innerOp2_smul_left, innerOp2_smul_right, innerOp2_smul_right, innerOp2_smul_right,
      innerOp2_smul_right, gA, gB, gAB, innerOp2_comm (sig4 i j k l) (sig4 i k j l), gAB]
    ring
  rw [foxProd2_self, HamiltonsCubic.FourEq.Q_nu hij hik hil hjk hjl hkl a b, normSq2_PiQ hij hik hil hjk hjl hkl, hN]
  ring

end

/-- **Cross terms against `Π_Q`**: `⟨p, q⟩² ≤ (1/9) ‖p‖² ‖q‖²` whenever `⟨p, q⟩ = x x'` for the leading entries of
`q = Π(x, y, z)`, `p = Π(x', y', z')` with zero sums, the shared pair being the `x`-slot of both. -/
theorem cross_sq {x y z x' y' z' I N N' : ℝ} (hs : x + y + z = 0) (hs' : x' + y' + z' = 0) (hI : I = x * x')
    (hN : N = 2 * (x ^ 2 + y ^ 2 + z ^ 2)) (hN' : N' = 2 * (x' ^ 2 + y' ^ 2 + z' ^ 2)) :
    I ^ 2 ≤ 1 / 9 * N * N' := by
  have h1 := HamiltonsCubic.L220Statement.pattern_entry_sq_le x y z hs
  have h2 := HamiltonsCubic.L220Statement.pattern_entry_sq_le x' y' z' hs'
  subst hI hN hN'
  have e : (x * x') ^ 2 = x ^ 2 * x' ^ 2 := by ring
  rw [e]
  have hx : 0 ≤ x ^ 2 := sq_nonneg x
  have hx' : 0 ≤ x' ^ 2 := sq_nonneg x'
  nlinarith [mul_le_mul h1 h2 (by positivity) (by positivity)]

section Config
variable {a b c d e f : Fin n} (hab : a ≠ b) (hac : a ≠ c) (had : a ≠ d) (hae : a ≠ e) (haf : a ≠ f)
  (hbc : b ≠ c) (hbd : b ≠ d) (hbe : b ≠ e) (hbf : b ≠ f) (hcd : c ≠ d) (hce : c ≠ e) (hcf : c ≠ f)
  (hde : d ≠ e) (hdf : d ≠ f) (hef : e ≠ f)
include hab hac had hae haf hbc hbd hbe hbf hcd hce hcf hde hdf hef

/-- `Q₁ = (a, b, c, d)` against `Q₂ = (a, b, e, f)`: the shared pair `ab` is the `x`-slot of both. -/
theorem angle12 (x y z x' y' z' : ℝ) :
    innerOp2 (coordOp (PiQ a b c d x y z)) (coordOp (PiQ a b e f x' y' z')) = x * x' := by
  rw [inner_PiQ hab hac had hbc hbd hcd x y z _ (HamiltonsCubic.L221aChain.PiQ_transpose x' y' z')]
  have hc : c ∉ ({a, b, e, f} : Finset (Fin n)) := by simp [Ne.symm hac, Ne.symm hbc, hce, hcf]
  have hd : d ∉ ({a, b, e, f} : Finset (Fin n)) := by simp [Ne.symm had, Ne.symm hbd, hde, hdf]
  have := (PiQ_entries hab hae haf hbe hbf hef x' y' z').1
  simp only [HamiltonsCubic.L221aChain.PiQ_zero_off hc, HamiltonsCubic.L221aChain.PiQ_zero_off' hc,
    HamiltonsCubic.L221aChain.PiQ_zero_off' hd, this]
  ring

/-- `Q₁ = (a, b, c, d)` against `Q₃ = (c, d, e, f)`: the shared pair `cd` is the `x`-slot of both. -/
theorem angle13 (x y z x' y' z' : ℝ) :
    innerOp2 (coordOp (PiQ a b c d x y z)) (coordOp (PiQ c d e f x' y' z')) = x * x' := by
  rw [inner_PiQ hab hac had hbc hbd hcd x y z _ (HamiltonsCubic.L221aChain.PiQ_transpose x' y' z')]
  have ha : a ∉ ({c, d, e, f} : Finset (Fin n)) := by simp [hac, had, hae, haf]
  have hb : b ∉ ({c, d, e, f} : Finset (Fin n)) := by simp [hbc, hbd, hbe, hbf]
  have := (PiQ_entries hcd hce hcf hde hdf hef x' y' z').1
  simp only [HamiltonsCubic.L221aChain.PiQ_zero_off ha, HamiltonsCubic.L221aChain.PiQ_zero_off hb, this]
  ring

/-- `Q₂ = (a, b, e, f)` against `Q₃ = (c, d, e, f)`: the shared pair `ef` is the `x`-slot (as `kl`) of both. -/
theorem angle23 (x y z x' y' z' : ℝ) :
    innerOp2 (coordOp (PiQ a b e f x y z)) (coordOp (PiQ c d e f x' y' z')) = x * x' := by
  rw [inner_PiQ hab hae haf hbe hbf hef x y z _ (HamiltonsCubic.L221aChain.PiQ_transpose x' y' z')]
  have ha : a ∉ ({c, d, e, f} : Finset (Fin n)) := by simp [hac, had, hae, haf]
  have hb : b ∉ ({c, d, e, f} : Finset (Fin n)) := by simp [hbc, hbd, hbe, hbf]
  have := (PiQ_entries hcd hce hcf hde hdf hef x' y' z').2.1
  simp only [HamiltonsCubic.L221aChain.PiQ_zero_off ha, HamiltonsCubic.L221aChain.PiQ_zero_off hb, this]
  ring

end Config

end HamiltonsCubic.L221bRay
