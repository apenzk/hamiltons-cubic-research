import Mathlib
import HamiltonsCubic.Results.FourL220

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L220's equality case on the operators: the `S² × S²` shape and the converse

[findings/second-order.md](../../../findings/second-order.md), Lemma L220, step 9: *Equality forces $r=0$,
$\lVert\nu\rVert^2=\tfrac12$ and the $S^2\times S^2$ shape, and conversely $q=t(2,-1,-1)$, $\nu=\pm t(2,-1,-1)$ with
$t^2=\tfrac1{24}$ satisfies both equations of step 3 at $\theta=\sqrt{3/2}$, which is padded $W_{\mathbb{CP}^2}$.*
Step 7: *$x+y+z=0$ gives $(x^2+y^2+z^2)^3\ge54x^2y^2z^2$ … equality at the $S^2\times S^2$ shape.*

The signed coordinates of $\nu$ are `nu_sq`'s: $\nu=a\,\sigma_A+(-b)\,\sigma_B$, so the record's $\nu=u(2,-1,-1)$ is
$2u\,\sigma_A+u\,\sigma_B$.

* `disc_identity`: $(x^2+y^2+z^2)^3-54x^2y^2z^2=2\big((x-y)(y-z)(z-x)\big)^2$ at $x+y+z=0$;
* `shape`: $x+y+z=0$, $x^2+y^2+z^2=6t^2$, $xyz=2t^3$, $t>0$ force $(x,y,z)$ to be a permutation of $t(2,-1,-1)$;
* **`L220_eq_shape`**: at $\theta^2=\tfrac32$, $D=\Pi_Q(x,y,z)$ with $(x,y,z)$ a permutation of $\tfrac\theta6(2,-1,-1)$, and
  $\lVert\nu\rVert^2=\tfrac12$;
* `Q_nu`, `fox_pair`, `Vq_zero`: $\nu\circ\nu$ on the pairing basis, $\langle q\circ\nu,\sigma_A\rangle$ and
  $\langle q\circ\nu,\sigma_B\rangle$ in closed form, and an element of $V_Q$ orthogonal to $\sigma_A,\sigma_B$ is zero;
* **`converse`**: $q=\Pi_Q(2t,-t,-t)$ and $\nu=2u\,\sigma_A+u\,\sigma_B$ with $u^2=t^2$ satisfy $q\circ q+\nu\circ\nu=6t\,q$,
  $2q\circ\nu=6t\,\nu$ and $Q(q+\nu)=6t\,(q+\nu)$, with $\lVert q+\nu\rVert^2=24t^2$;
* **`L220_witness`**: a unit $W=D+\nu$, $\nu\ne0$, with $Q(W)=\sqrt{3/2}\,W$, so `L220_bound` has an instance and its
  bound is attained.
-/

namespace HamiltonsCubic.FourEq

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent HamiltonsCubic.FourProd
  HamiltonsCubic.L222Op HamiltonsCubic.FourPi HamiltonsCubic.FourStep4 HamiltonsCubic.FourStep5 HamiltonsCubic.L224Rank
  HamiltonsCubic.PairNorm HamiltonsCubic.FrameOp2 HamiltonsCubic.FrameLayer HamiltonsCubic.FourStep67
  HamiltonsCubic.FourStep8 HamiltonsCubic.FourL220 HamiltonsCubic.BlockSub

variable {n : ℕ} {i j k l : Fin n}

/-- `Π_Q` is additive in its values. -/
theorem PiQ_add' (a b c a' b' c' : ℝ) :
    PiQ i j k l a b c + PiQ i j k l a' b' c' = PiQ i j k l (a + a') (b + b') (c + c') := by
  ext p q
  simp only [PiQ, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]
  ring

/-- `Π_Q` is homogeneous in its values. -/
theorem PiQ_smul' (s a b c : ℝ) : s • PiQ i j k l a b c = PiQ i j k l (s * a) (s * b) (s * c) := by
  ext p q
  simp only [PiQ, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]
  ring

/-- **The discriminant on the pattern plane.** -/
theorem disc_identity (x y z : ℝ) (h : x + y + z = 0) :
    (x ^ 2 + y ^ 2 + z ^ 2) ^ 3 - 54 * (x * y * z) ^ 2 = 2 * ((x - y) * (y - z) * (z - x)) ^ 2 := by
  have hz : z = -x - y := by linarith
  subst hz; ring

/-- One case of `shape`: `x = y` forces `x = y = -t`, `z = 2t`. -/
theorem shape_case {x z t : ℝ} (ht : 0 < t) (hs : x + x + z = 0) (h2 : x ^ 2 + x ^ 2 + z ^ 2 = 6 * t ^ 2)
    (h3 : x * x * z = 2 * t ^ 3) : x = -t ∧ z = 2 * t := by
  have hz : z = -2 * x := by linarith
  subst hz
  have hcube : (x + t) * ((x - t / 2) ^ 2 + 3 / 4 * t ^ 2) = 0 := by linear_combination (-1 / 2 : ℝ) * h3
  have hpos : 0 < (x - t / 2) ^ 2 + 3 / 4 * t ^ 2 := by positivity
  have hx : x = -t := by
    rcases mul_eq_zero.mp hcube with h | h
    · linarith
    · linarith
  exact ⟨hx, by rw [hx]; ring⟩

/-- **The `S² × S²` shape**: `x + y + z = 0`, `x² + y² + z² = 6t²` and `xyz = 2t³` at `t > 0` force `(x, y, z)` to be a
permutation of `t(2, -1, -1)`. -/
theorem shape {x y z t : ℝ} (ht : 0 < t) (hs : x + y + z = 0) (h2 : x ^ 2 + y ^ 2 + z ^ 2 = 6 * t ^ 2)
    (h3 : x * y * z = 2 * t ^ 3) :
    (x = 2 * t ∧ y = -t ∧ z = -t) ∨ (x = -t ∧ y = 2 * t ∧ z = -t) ∨ (x = -t ∧ y = -t ∧ z = 2 * t) := by
  have hd := disc_identity x y z hs
  rw [h2, h3] at hd
  have h0 : ((x - y) * (y - z) * (z - x)) ^ 2 = 0 := by nlinarith
  rcases mul_eq_zero.mp (pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h0) with h | h
  · rcases mul_eq_zero.mp h with h | h
    · -- `x = y`
      have hxy : y = x := by linarith
      obtain ⟨hx, hz⟩ := shape_case (x := x) (z := z) ht (by rw [hxy] at hs; exact hs) (by rw [hxy] at h2; exact h2)
        (by rw [hxy] at h3; exact h3)
      exact Or.inr (Or.inr ⟨hx, by rw [hxy, hx], hz⟩)
    · -- `y = z`
      have hyz : z = y := by linarith
      obtain ⟨hy, hx⟩ := shape_case (x := y) (z := x) ht (by linarith) (by rw [hyz] at h2; linarith)
        (by rw [hyz] at h3; linear_combination h3)
      exact Or.inl ⟨hx, hy, by rw [hyz, hy]⟩
  · -- `z = x`
    have hzx : z = x := by linarith
    obtain ⟨hx, hy⟩ := shape_case (x := x) (z := y) ht (by linarith) (by rw [hzx] at h2; linarith)
      (by rw [hzx] at h3; linear_combination h3)
    exact Or.inr (Or.inl ⟨hx, hy, by rw [hzx, hx]⟩)

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **L220's equality case, the shape**: at `θ² = 3/2`, `D = Π_Q(x, y, z)` with `(x, y, z)` a permutation of
`(θ/6)(2, -1, -1)`, and `‖ν‖² = 1/2`. -/
theorem L220_eq_shape {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hD : SignChar (fun _ => 1) D) (hνW : IsWeyl2 ν)
    (hν : SignChar (setChar {i, j, k, l}) ν) (hν0 : ν ≠ 0) {θ : ℝ} (hθ : 0 < θ)
    (hQ : Qop2 (D + ν) = θ • (D + ν)) (hunit : normSq2 (D + ν) = 1) (heq : θ ^ 2 = 3 / 2) :
    ∃ x y z : ℝ, D = coordOp (PiQ i j k l x y z) ∧
      ((x = 2 * (θ / 6) ∧ y = -(θ / 6) ∧ z = -(θ / 6)) ∨ (x = -(θ / 6) ∧ y = 2 * (θ / 6) ∧ z = -(θ / 6)) ∨
        (x = -(θ / 6) ∧ y = -(θ / 6) ∧ z = 2 * (θ / 6))) ∧ normSq2 ν = 1 / 2 := by
  obtain ⟨x, y, z, r, hs, rfl, hrW, hr, hperp⟩ := proj_PiQ hij hik hil hjk hjl hkl hDW hD
  obtain ⟨hsplit, hDν⟩ := L220_split hD hν hQ
  have heig := Lq_eigen hij hik hil hjk hjl hkl hrW hr hperp hνW hν hDν
  have h5 := step5 hij hik hil hjk hjl hkl hs hνW hν hν0 heig
  have h6 := step6 hij hik hil hjk hjl hkl hs hrW hperp hνW hsplit heig
  have h7 := step7 hij hik hil hjk hjl hkl hs hθ.le h5.symm
  have h8 := step8 hij hik hil hjk hjl hkl hs hθ.le h5.symm hrW hr hperp
  have hN := norm_split (x := x) (y := y) (z := z) hij hik hil hjk hjl hkl hs hrW hr hperp hνW hν
  rw [hunit] at hN
  obtain ⟨hR, hNu⟩ := HamiltonsCubic.L220Statement.equality_case θ _ _ _ _ _ hθ (normSq2_nonneg r)
    (normSq2_nonneg ν) hN.symm h5.symm (by linarith) h7 h8 heq
  -- step 7 is tight: `6 P(q) = θ³`
  rw [hR] at h8
  have hθ3 : θ ^ 3 = 3 / 2 * θ := by rw [pow_succ, heq]
  have htight : 6 * Pcubic2 (coordOp (PiQ i j k l x y z)) = θ ^ 3 := by
    rw [hNu] at h6
    nlinarith
  rw [P_PiQ_zero hij hik hil hjk hjl hkl hs] at htight
  rw [normSq2_PiQ hij hik hil hjk hjl hkl] at h5
  have ht : 0 < θ / 6 := by positivity
  have hsh := shape ht hs (by nlinarith) (by nlinarith)
  refine ⟨x, y, z, ?_, hsh, hNu⟩
  rw [normSq2_eq_zero hR]
  exact add_zero (coordOp (PiQ i j k l x y z) : CurvOp2 (Fin n))

/-- **`ν ∘ ν` on the pairing basis**: `Q(x σ_A + y σ_B) = Π_Q(2a² - b² - c², …)` at `(a, b, c) = (x, -y, y - x)`. -/
theorem Q_nu (x y : ℝ) :
    Qop2 (x • sig4 i k j l + y • sig4 i j k l) = coordOp (PiQ i j k l (2 * x ^ 2 - (-y) ^ 2 - (y - x) ^ 2)
      (2 * (-y) ^ 2 - (y - x) ^ 2 - x ^ 2) (2 * (y - x) ^ 2 - x ^ 2 - (-y) ^ 2)) := by
  rw [Q_lin hij hik hil hjk hjl hkl, ← Wcomb_pattern hij hik hil hjk hjl hkl]
  unfold Wcomb
  rw [coordOp_add, coordOp_add, coordOp_smul', coordOp_smul', coordOp_smul', HamiltonsCubic.ItemFour.coordOp_sub,
    HamiltonsCubic.ItemFour.coordOp_sub]

/-- **`q ∘ ν` against the pairing basis**: at `q = Π_Q(x, y, z)`, `x + y + z = 0`, and `ν = a σ_A + b σ_B`,
`⟨q ∘ ν, σ_A⟩ = a(2x + 2z - 4y) + b(2x + 2y - 4z)` and `⟨q ∘ ν, σ_B⟩ = a(2x + 2y - 4z) + b(2y + 2z - 4x)`. -/
theorem fox_pair {x y z : ℝ} (hs : x + y + z = 0) (a b : ℝ) :
    innerOp2 (foxProd2 (coordOp (PiQ i j k l x y z)) (a • sig4 i k j l + b • sig4 i j k l)) (sig4 i k j l)
        = a * (2 * x + 2 * z - 4 * y) + b * (2 * x + 2 * y - 4 * z) ∧
      innerOp2 (foxProd2 (coordOp (PiQ i j k l x y z)) (a • sig4 i k j l + b • sig4 i j k l)) (sig4 i j k l)
        = a * (2 * x + 2 * y - 4 * z) + b * (2 * y + 2 * z - 4 * x) := by
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
  have mAB : innerOp2 q (foxProd2 sA sB) = 2 * x + 2 * y - 4 * z := by
    have := congrArg (innerOp2 q) hfox
    rw [innerOp2_smul_right] at this
    have e2 : innerOp2 q (coordOp (W4 i l j k) - coordOp (W4 i k j l) - coordOp (W4 i j k l))
        = innerOp2 q (coordOp (W4 i l j k)) - innerOp2 q (coordOp (W4 i k j l)) - innerOp2 q (coordOp (W4 i j k l)) := by
      rw [innerOp2_comm, innerOp2_sub_left', innerOp2_sub_left', innerOp2_comm _ q, innerOp2_comm _ q, innerOp2_comm _ q]
    rw [e2, mA, mB, mC] at this
    linarith
  constructor
  · rw [inner_fox_move hqs hνs hAW.isSelfAdjoint2, HamiltonsCubic.RealLayer.foxProd2_add_left, foxProd2_smul_left,
      foxProd2_smul_left, foxProd2_self, foxProd2_comm sB sA, innerOp2_add_right, innerOp2_smul_right,
      innerOp2_smul_right, hQA, mA, mAB]
  · rw [inner_fox_move hqs hνs hBW.isSelfAdjoint2, HamiltonsCubic.RealLayer.foxProd2_add_left, foxProd2_smul_left,
      foxProd2_smul_left, foxProd2_self, innerOp2_add_right, innerOp2_smul_right, innerOp2_smul_right, hQB, mB, mAB]

/-- **The pairing basis separates `V_Q`**: a Weyl `E` of character `χ_Q` orthogonal to `σ_A` and `σ_B` is zero. -/
theorem Vq_zero {E : CurvOp2 (Fin n)} (hEW : IsWeyl2 E) (hE : SignChar (setChar {i, j, k, l}) E)
    (hA : innerOp2 E (sig4 i k j l) = 0) (hB : innerOp2 E (sig4 i j k l) = 0) : E = 0 := by
  obtain ⟨a, b, rfl⟩ := four_eq_sig hij hik hil hjk hjl hkl hEW hE
  have gA := norm_sig hik hjl hij hil (Ne.symm hjk) hkl
  have gB := norm_sig hij hkl hik hil hjk hjl
  have gAB := inner_AB hij hik hil hjk hjl hkl
  unfold normSq2 at gA gB
  rw [innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, gA, innerOp2_comm (sig4 i j k l), gAB] at hA
  rw [innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, gAB, gB] at hB
  have ha : a = 0 := by linarith
  have hb : b = 0 := by linarith
  rw [ha, hb]; module

/-- `ν = 2u σ_A + u σ_B` is Weyl of character `χ_Q`. -/
theorem nu_mem (u : ℝ) :
    IsWeyl2 ((2 * u) • sig4 i k j l + u • sig4 i j k l) ∧
      SignChar (setChar {i, j, k, l}) ((2 * u) • sig4 i k j l + u • sig4 i j k l) :=
  ⟨isWeyl2_add (isWeyl2_smul _ (sig_weyl hik hjl hij hil (Ne.symm hjk) hkl))
      (isWeyl2_smul _ (sig_weyl hij hkl hik hil hjk hjl)),
    signChar_add (signChar_smul (sigA_char hij hik hil hjk hjl hkl) _) (signChar_smul (sigB_char hij hik hil hjk hjl hkl) _)⟩

/-- `‖2u σ_A + u σ_B‖² = 12u²`. -/
theorem norm_nu (u : ℝ) : normSq2 ((2 * u) • sig4 i k j l + u • sig4 i j k l) = 12 * u ^ 2 := by
  have gA := norm_sig hik hjl hij hil (Ne.symm hjk) hkl
  have gB := norm_sig hij hkl hik hil hjk hjl
  have gAB := inner_AB hij hik hil hjk hjl hkl
  unfold normSq2 at gA gB ⊢
  simp only [innerOp2_add_left, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_right]
  rw [gA, gB, gAB, innerOp2_comm (sig4 i j k l), gAB]
  ring

/-- **L220's converse on the operators**: `q = Π_Q(2t, -t, -t)` and `ν = 2u σ_A + u σ_B` with `u² = t²` satisfy both
equations of step 3 at `θ = 6t`, so `W = q + ν` is critical with `Q(W) = 6t W`, and `‖W‖² = 24t²`. -/
theorem converse (t u : ℝ) (hu : u ^ 2 = t ^ 2) :
    foxProd2 (coordOp (PiQ i j k l (2 * t) (-t) (-t))) (coordOp (PiQ i j k l (2 * t) (-t) (-t)))
        + foxProd2 ((2 * u) • sig4 i k j l + u • sig4 i j k l) ((2 * u) • sig4 i k j l + u • sig4 i j k l)
        = (6 * t) • coordOp (PiQ i j k l (2 * t) (-t) (-t)) ∧
      (2 : ℝ) • foxProd2 (coordOp (PiQ i j k l (2 * t) (-t) (-t))) ((2 * u) • sig4 i k j l + u • sig4 i j k l)
        = (6 * t) • ((2 * u) • sig4 i k j l + u • sig4 i j k l) ∧
      Qop2 (coordOp (PiQ i j k l (2 * t) (-t) (-t)) + ((2 * u) • sig4 i k j l + u • sig4 i j k l))
        = (6 * t) • (coordOp (PiQ i j k l (2 * t) (-t) (-t)) + ((2 * u) • sig4 i k j l + u • sig4 i j k l)) ∧
      normSq2 (coordOp (PiQ i j k l (2 * t) (-t) (-t)) + ((2 * u) • sig4 i k j l + u • sig4 i j k l)) = 24 * t ^ 2 := by
  have hs : 2 * t + -t + -t = 0 := by ring
  set q := coordOp (PiQ i j k l (2 * t) (-t) (-t)) with hqdef
  set ν := (2 * u) • sig4 i k j l + u • sig4 i j k l with hνdef
  have hw := PiQ_weight hij hik hil hjk hjl hkl hs
  have hqW : IsWeyl2 q := by rw [hqdef, coordOp_eq_restrict hw]; exact isWeyl2_restrict _
  have hq1 : SignChar (fun _ => 1) q := by
    rw [hqdef, coordOp_eq_restrict hw]
    exact (L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hw, rfl⟩
  obtain ⟨hνW, hν⟩ := nu_mem hij hik hil hjk hjl hkl u
  -- the `𝒟ₙ` equation
  have hA : foxProd2 q q + foxProd2 ν ν = (6 * t) • q := by
    rw [hqdef, PiQ_mul hij hik hil hjk hjl hkl, foxProd2_self, hνdef, Q_nu hij hik hil hjk hjl hkl, ← coordOp_add,
      ← coordOp_smul']
    congr 1
    rw [PiQ_add', PiQ_smul']
    congr 1 <;> first | linear_combination (6 : ℝ) * hu | linear_combination (-3 : ℝ) * hu
  -- the `V_Q` equation, through the pairing basis
  have hB : (2 : ℝ) • foxProd2 q ν = (6 * t) • ν := by
    have gA := norm_sig hik hjl hij hil (Ne.symm hjk) hkl
    have gB := norm_sig hij hkl hik hil hjk hjl
    have gAB := inner_AB hij hik hil hjk hjl hkl
    unfold normSq2 at gA gB
    obtain ⟨pA, pB⟩ := fox_pair hij hik hil hjk hjl hkl hs (2 * u) u
    have hEW : IsWeyl2 ((2 : ℝ) • foxProd2 q ν + (-(6 * t)) • ν) :=
      isWeyl2_add (isWeyl2_smul _ (isWeyl2_foxProd2 hqW hνW)) (isWeyl2_smul _ hνW)
    have hEc : SignChar (setChar {i, j, k, l}) ((2 : ℝ) • foxProd2 q ν + (-(6 * t)) • ν) :=
      signChar_add (signChar_smul (Dnu_char hq1 hν) _) (signChar_smul hν _)
    have hE := Vq_zero hij hik hil hjk hjl hkl hEW hEc ?_ ?_
    · have e : (2 : ℝ) • foxProd2 q ν - (6 * t) • ν = (2 : ℝ) • foxProd2 q ν + (-(6 * t)) • ν := by module
      exact sub_eq_zero.mp (e.trans hE)
    · rw [innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, hνdef, pA, innerOp2_add_left, innerOp2_smul_left,
        innerOp2_smul_left, gA, innerOp2_comm (sig4 i j k l), gAB]
      ring
    · rw [innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, hνdef, pB, innerOp2_add_left, innerOp2_smul_left,
        innerOp2_smul_left, gAB, gB]
      ring
  refine ⟨hA, hB, ?_, ?_⟩
  · rw [L219Prod.Qop2_add, ← foxProd2_self q, ← foxProd2_self ν, hB, hA]
    module
  · have hqν : innerOp2 q ν = 0 := inner_char_four hqW hνW hq1 hν
    have hN := norm_nu hij hik hil hjk hjl hkl u
    rw [← hνdef] at hN
    have hQn : normSq2 q = 12 * t ^ 2 := by rw [hqdef, normSq2_PiQ hij hik hil hjk hjl hkl]; ring
    clear_value q ν
    unfold normSq2 at hN hQn ⊢
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_comm ν q, hqν, hN, hQn, hu]
    ring

/-- **`L220_bound` has an instance, and its bound is attained**: a unit `W = D + ν` with `D` Weyl of character `1`,
`0 ≠ ν` Weyl of character `χ_Q` and `Q(W) = √(3/2) W`, at `t = u = √(3/2)/6`. -/
theorem L220_witness :
    ∃ D ν : CurvOp2 (Fin n), IsWeyl2 D ∧ SignChar (fun _ => 1) D ∧ IsWeyl2 ν ∧ SignChar (setChar {i, j, k, l}) ν ∧
      ν ≠ 0 ∧ Qop2 (D + ν) = Real.sqrt (3 / 2) • (D + ν) ∧ normSq2 (D + ν) = 1 := by
  set t := Real.sqrt (3 / 2) / 6 with htdef
  have ht2 : t ^ 2 = 1 / 24 := by
    rw [htdef, div_pow, Real.sq_sqrt (by norm_num)]; norm_num
  have hs : 2 * t + -t + -t = 0 := by ring
  have hw := PiQ_weight hij hik hil hjk hjl hkl hs
  obtain ⟨hνW, hν⟩ := nu_mem hij hik hil hjk hjl hkl t
  obtain ⟨-, -, hQ, hN⟩ := converse hij hik hil hjk hjl hkl t t rfl
  have h6 : 6 * t = Real.sqrt (3 / 2) := by rw [htdef]; ring
  refine ⟨coordOp (PiQ i j k l (2 * t) (-t) (-t)), (2 * t) • sig4 i k j l + t • sig4 i j k l, ?_, ?_, hνW, hν, ?_,
    by rw [← h6]; exact hQ, by rw [hN, ht2]; norm_num⟩
  · rw [coordOp_eq_restrict hw]; exact isWeyl2_restrict _
  · rw [coordOp_eq_restrict hw]
    exact (L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hw, rfl⟩
  · intro h0
    have hn := norm_nu hij hik hil hjk hjl hkl t
    rw [h0, ht2] at hn
    have : normSq2 (0 : CurvOp2 (Fin n)) = 0 := by
      have h := innerOp2_smul_left (0 : ℝ) (0 : CurvOp2 (Fin n)) 0
      unfold normSq2; rw [zero_mul] at h; convert h using 2; module
    linarith

end

end HamiltonsCubic.FourEq
