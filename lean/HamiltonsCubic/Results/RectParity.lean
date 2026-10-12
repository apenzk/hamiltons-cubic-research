import Mathlib
import HamiltonsCubic.Results.RectOp
import HamiltonsCubic.Results.L222Swap
import HamiltonsCubic.Results.FourProd

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false
set_option linter.unusedSectionVars false

/-!
# The rectangle identity's mixed terms vanish by parity

[reviews/2026-09-28d-I121-smallmass-direct.md](../../../reviews/2026-09-28d-I121-smallmass-direct.md), *The rectangle identity*:
$\tau=\langle\nu_{12}\circ\nu_{13},\nu_{23}\rangle=\tfrac32J_{12}J_{13}J_{23}+4X_{12}X_{13}X_{23}$ for $\nu_{ab}\in V_{Q_{ab}}$ with coordinates
$(J_{ab},X_{ab})$ relative to the pairing $(e_a|e_b)$, raw entries $a=W_{ij,kl}$, $b=W_{ik,jl}$, $c=W_{il,jk}$, $J=a$, $X=\tfrac12(b+c)$.

On the block $\{i,j,k,l\}$ with pairing $(ij|kl)$ the pure-`X` direction is the matched sandwich `sig4 i j k l`, raw $(0,1,1)$, and
the pure-`J` direction is `sig4 i k j l + ½ sig4 i j k l`, raw $(1,\tfrac12,-\tfrac12)$. The transposition $i\leftrightarrow j$
inside an edge carries `sig4 i k j l` to `sig4 i l j k`, so by `sig_sum` it negates the `J`-direction and fixes the `X`-direction,
and it fixes every block not meeting $\{i,j\}$. Since `∘` and `⟨,⟩` are equivariant, a triple product odd under one transposition
vanishes, and every mixed monomial is odd under $i\leftrightarrow j$ or $k\leftrightarrow l$:

* `swap_Smat`, `Smat_comm`, `sandOp_comm`, `rot_sig4`: a transposition acts on sandwiches by relabelling;
* `tau_inv`, **`parity_zero`**: `τ` is invariant under an orthogonal frame, so a triple with sign product `−1` has `τ = 0`;
* `Jd`, `Xd`: the two directions of a block relative to its matched pairing;
* `Jd_swap_left`, `Jd_swap_right`, `Xd_swap_left`, `Xd_swap_right`, `swap_fix`: their transformation laws;
* **`rect_reduce`**: $\tau(J_{12}\,Jd+X_{12}\,Xd,\;\dots)=\tau_{JJJ}\,J_{12}J_{13}J_{23}+4X_{12}X_{13}X_{23}$, with
  $\tau_{JJJ}=\tau(Jd_{12},Jd_{13},Jd_{23})$ the one constant left.
-/

namespace HamiltonsCubic.RectParity

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.L222Op HamiltonsCubic.L221Ops HamiltonsCubic.L224Rot
  HamiltonsCubic.FrameOp2 HamiltonsCubic.FrameLayer HamiltonsCubic.FourStep5 HamiltonsCubic.L222Swap HamiltonsCubic.RectOp
  HamiltonsCubic.FourProd

variable {n : ℕ}

theorem swap_Smat (a b x y : Fin n) :
    swapM a b * Smat x y * (swapM a b)ᵀ = Smat (Equiv.swap a b x) (Equiv.swap a b y) := by
  ext p q
  rw [swapM_entry]
  simp only [Smat, Matrix.of_apply, Equiv.swap_apply_eq_iff]

theorem Smat_comm (x y : Fin n) : Smat x y = Smat y x := by
  ext p q; simp only [Smat, Matrix.of_apply]; congr 1; apply propext; tauto

theorem sandOp_comm (A B : Matrix (Fin n) (Fin n) ℝ) (hA : Aᵀ = A) (hB : Bᵀ = B) :
    sandOp A B hA hB = sandOp B A hB hA := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [sandOp_coe, sandOp_coe, add_comm]

theorem sig4_swap_pairs (w x y z : Fin n) : sig4 w x y z = sig4 y z w x := by
  unfold sig4; exact sandOp_comm _ _ _ _

theorem sig4_comm_first (w x y z : Fin n) : sig4 w x y z = sig4 x w y z := by
  unfold sig4; exact sandOp_congr _ _ _ _ (Smat_comm w x) rfl

theorem sig4_comm_second (w x y z : Fin n) : sig4 w x y z = sig4 w x z y := by
  unfold sig4; exact sandOp_congr _ _ _ _ rfl (Smat_comm y z)

/-- **A transposition relabels a sandwich.** -/
theorem rot_sig4 (a b w x y z : Fin n) :
    rotR (swapM a b) (sig4 w x y z)
      = sig4 (Equiv.swap a b w) (Equiv.swap a b x) (Equiv.swap a b y) (Equiv.swap a b z) := by
  unfold sig4
  rw [rotR_sandOp _ _ _ _ _ (conj_sym _ _ (Smat_T w x)) (conj_sym _ _ (Smat_T y z))]
  exact sandOp_congr _ _ _ _ (swap_Smat a b w x) (swap_Smat a b y z)

/-- **`τ` is frame-invariant.** -/
theorem tau_inv {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {A B C : CurvOp2 (Fin n)} (hA : IsWeyl2 A)
    (hB : IsWeyl2 B) (hC : IsWeyl2 C) :
    innerOp2 (foxProd2 (rotR U A) (rotR U B)) (rotR U C) = innerOp2 (foxProd2 A B) C := by
  rw [L219GenOps.foxProd2_rotR hU hA hB, innerOp2_rotR hU (isWeyl2_foxProd2 hA hB) hC]

/-- **Parity**: under a frame acting by signs `εA, εB, εC` with `εA εB εC = −1`, `τ = 0`. -/
theorem parity_zero {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {A B C : CurvOp2 (Fin n)} (hA : IsWeyl2 A)
    (hB : IsWeyl2 B) (hC : IsWeyl2 C) {εA εB εC : ℝ} (eA : rotR U A = εA • A) (eB : rotR U B = εB • B)
    (eC : rotR U C = εC • C) (hε : εA * εB * εC = -1) : innerOp2 (foxProd2 A B) C = 0 := by
  have h := tau_inv hU hA hB hC
  rw [eA, eB, eC, foxProd2_smul_left, foxProd2_smul_right, innerOp2_smul_left, innerOp2_smul_left,
    innerOp2_smul_right] at h
  have : (εA * εB * εC) * innerOp2 (foxProd2 A B) C = innerOp2 (foxProd2 A B) C := by linear_combination h
  rw [hε] at this
  linarith

/-- The pure-`J` direction of the block `{w, x, y, z}` relative to the pairing `(wx|yz)`, raw coordinates `(1, ½, −½)`. -/
noncomputable def Jd (w x y z : Fin n) : CurvOp2 (Fin n) := sig4 w y x z + (1 / 2 : ℝ) • sig4 w x y z

/-- The pure-`X` direction, the matched sandwich, raw coordinates `(0, 1, 1)`. -/
noncomputable def Xd (w x y z : Fin n) : CurvOp2 (Fin n) := sig4 w x y z

section
variable {w x y z : Fin n} (hwx : w ≠ x) (hwy : w ≠ y) (hwz : w ≠ z) (hxy : x ≠ y) (hxz : x ≠ z) (hyz : y ≠ z)
include hwx hwy hwz hxy hxz hyz

theorem Jd_weyl : IsWeyl2 (Jd w x y z) :=
  isWeyl2_add (sig_weyl hwy hxz hwx hwz (Ne.symm hxy) hyz)
    (isWeyl2_smul _ (sig_weyl hwx hyz hwy hwz hxy hxz))

theorem Xd_weyl : IsWeyl2 (Xd w x y z) := sig_weyl hwx hyz hwy hwz hxy hxz

/-- **`w ↔ x` negates the `J`-direction.** -/
theorem Jd_swap_left : rotR (swapM w x) (Jd w x y z) = (-1 : ℝ) • Jd w x y z := by
  unfold Jd
  rw [LinearMap.map_add, LinearMap.map_smul, rot_sig4, rot_sig4]
  simp only [Equiv.swap_apply_left, Equiv.swap_apply_right,
    Equiv.swap_apply_of_ne_of_ne (Ne.symm hwy) (Ne.symm hxy), Equiv.swap_apply_of_ne_of_ne (Ne.symm hwz) (Ne.symm hxz)]
  rw [sig4_swap_pairs x y w z, ← sig4_comm_first w x y z]
  have hC : sig4 w z x y = -(sig4 w y x z + sig4 w x y z) := by
    rw [sig_sum hwx hwy hwz hxy hxz hyz]; module
  rw [hC]; module

/-- **`y ↔ z` negates the `J`-direction.** -/
theorem Jd_swap_right : rotR (swapM y z) (Jd w x y z) = (-1 : ℝ) • Jd w x y z := by
  unfold Jd
  rw [LinearMap.map_add, LinearMap.map_smul, rot_sig4, rot_sig4]
  simp only [Equiv.swap_apply_left, Equiv.swap_apply_right,
    Equiv.swap_apply_of_ne_of_ne hwy hwz, Equiv.swap_apply_of_ne_of_ne hxy hxz]
  rw [← sig4_comm_second w x y z]
  have hC : sig4 w z x y = -(sig4 w y x z + sig4 w x y z) := by
    rw [sig_sum hwx hwy hwz hxy hxz hyz]; module
  rw [hC]; module

/-- `w ↔ x` fixes the `X`-direction. -/
theorem Xd_swap_left : rotR (swapM w x) (Xd w x y z) = (1 : ℝ) • Xd w x y z := by
  unfold Xd
  rw [rot_sig4, one_smul]
  simp only [Equiv.swap_apply_left, Equiv.swap_apply_right,
    Equiv.swap_apply_of_ne_of_ne (Ne.symm hwy) (Ne.symm hxy), Equiv.swap_apply_of_ne_of_ne (Ne.symm hwz) (Ne.symm hxz)]
  exact (sig4_comm_first w x y z).symm

/-- `y ↔ z` fixes the `X`-direction. -/
theorem Xd_swap_right : rotR (swapM y z) (Xd w x y z) = (1 : ℝ) • Xd w x y z := by
  unfold Xd
  rw [rot_sig4, one_smul]
  simp only [Equiv.swap_apply_left, Equiv.swap_apply_right,
    Equiv.swap_apply_of_ne_of_ne hwy hwz, Equiv.swap_apply_of_ne_of_ne hxy hxz]
  exact (sig4_comm_second w x y z).symm

end

/-- A transposition off the block fixes its sandwiches. -/
theorem sig4_fix {a b w x y z : Fin n} (hw : w ≠ a ∧ w ≠ b) (hx : x ≠ a ∧ x ≠ b) (hy : y ≠ a ∧ y ≠ b)
    (hz : z ≠ a ∧ z ≠ b) : rotR (swapM a b) (sig4 w x y z) = sig4 w x y z := by
  rw [rot_sig4, Equiv.swap_apply_of_ne_of_ne hw.1 hw.2, Equiv.swap_apply_of_ne_of_ne hx.1 hx.2,
    Equiv.swap_apply_of_ne_of_ne hy.1 hy.2, Equiv.swap_apply_of_ne_of_ne hz.1 hz.2]

theorem Jd_fix {a b w x y z : Fin n} (hw : w ≠ a ∧ w ≠ b) (hx : x ≠ a ∧ x ≠ b) (hy : y ≠ a ∧ y ≠ b)
    (hz : z ≠ a ∧ z ≠ b) : rotR (swapM a b) (Jd w x y z) = (1 : ℝ) • Jd w x y z := by
  unfold Jd
  rw [LinearMap.map_add, LinearMap.map_smul, sig4_fix hw hy hx hz, sig4_fix hw hx hy hz, one_smul]

theorem Xd_fix {a b w x y z : Fin n} (hw : w ≠ a ∧ w ≠ b) (hx : x ≠ a ∧ x ≠ b) (hy : y ≠ a ∧ y ≠ b)
    (hz : z ≠ a ∧ z ≠ b) : rotR (swapM a b) (Xd w x y z) = (1 : ℝ) • Xd w x y z := by
  unfold Xd; rw [sig4_fix hw hx hy hz, one_smul]

section
variable {i j k l m p : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (him : i ≠ m) (hip : i ≠ p) (hjk : j ≠ k)
  (hjl : j ≠ l) (hjm : j ≠ m) (hjp : j ≠ p) (hkl : k ≠ l) (hkm : k ≠ m) (hkp : k ≠ p) (hlm : l ≠ m) (hlp : l ≠ p)
  (hmp : m ≠ p)
include hij hik hil him hip hjk hjl hjm hjp hkl hkm hkp hlm hlp hmp

/-- **The rectangle identity up to one constant**: with `ν_ab = J_ab · Jd + X_ab · Xd` on each block relative to its matched
pairing, `τ = τ_JJJ J₁₂J₁₃J₂₃ + 4 X₁₂X₁₃X₂₃`, every mixed term vanishing by parity under `i ↔ j` or `k ↔ l`. -/
theorem rect_reduce (J₁₂ X₁₂ J₁₃ X₁₃ J₂₃ X₂₃ : ℝ) :
    innerOp2 (foxProd2 (J₁₂ • Jd i j k l + X₁₂ • Xd i j k l) (J₁₃ • Jd i j m p + X₁₃ • Xd i j m p))
        (J₂₃ • Jd k l m p + X₂₃ • Xd k l m p)
      = innerOp2 (foxProd2 (Jd i j k l) (Jd i j m p)) (Jd k l m p) * (J₁₂ * J₁₃ * J₂₃) + 4 * (X₁₂ * X₁₃ * X₂₃) := by
  have oij : IsOrth (swapM i j) := swapM_orth i j
  have okl : IsOrth (swapM k l) := swapM_orth k l
  have J12 := Jd_weyl hij hik hil hjk hjl hkl
  have J13 := Jd_weyl hij him hip hjm hjp hmp
  have J23 := Jd_weyl hkl hkm hkp hlm hlp hmp
  have X12 := Xd_weyl hij hik hil hjk hjl hkl
  have X13 := Xd_weyl hij him hip hjm hjp hmp
  have X23 := Xd_weyl hkl hkm hkp hlm hlp hmp
  -- the transformation laws
  have a1 := Jd_swap_left hij hik hil hjk hjl hkl
  have a2 := Jd_swap_right hij hik hil hjk hjl hkl
  have a3 := Xd_swap_left hij hik hil hjk hjl hkl
  have a4 := Xd_swap_right hij hik hil hjk hjl hkl
  have b1 := Jd_swap_left hij him hip hjm hjp hmp
  have b3 := Xd_swap_left hij him hip hjm hjp hmp
  have c2 := Jd_swap_left hkl hkm hkp hlm hlp hmp
  have c4 := Xd_swap_left hkl hkm hkp hlm hlp hmp
  have b5 : rotR (swapM k l) (Jd i j m p) = (1 : ℝ) • Jd i j m p :=
    Jd_fix ⟨hik, hil⟩ ⟨hjk, hjl⟩ ⟨Ne.symm hkm, Ne.symm hlm⟩ ⟨Ne.symm hkp, Ne.symm hlp⟩
  have b6 : rotR (swapM k l) (Xd i j m p) = (1 : ℝ) • Xd i j m p :=
    Xd_fix ⟨hik, hil⟩ ⟨hjk, hjl⟩ ⟨Ne.symm hkm, Ne.symm hlm⟩ ⟨Ne.symm hkp, Ne.symm hlp⟩
  have c5 : rotR (swapM i j) (Jd k l m p) = (1 : ℝ) • Jd k l m p :=
    Jd_fix ⟨Ne.symm hik, Ne.symm hjk⟩ ⟨Ne.symm hil, Ne.symm hjl⟩ ⟨Ne.symm him, Ne.symm hjm⟩ ⟨Ne.symm hip, Ne.symm hjp⟩
  -- the six mixed terms
  have z1 : innerOp2 (foxProd2 (Jd i j k l) (Jd i j m p)) (Xd k l m p) = 0 :=
    parity_zero okl J12 J13 X23 a2 b5 c4 (by norm_num)
  have z2 : innerOp2 (foxProd2 (Jd i j k l) (Xd i j m p)) (Jd k l m p) = 0 :=
    parity_zero oij J12 X13 J23 a1 b3 c5 (by norm_num)
  have z3 : innerOp2 (foxProd2 (Jd i j k l) (Xd i j m p)) (Xd k l m p) = 0 :=
    parity_zero oij J12 X13 X23 a1 b3 (Xd_fix ⟨Ne.symm hik, Ne.symm hjk⟩ ⟨Ne.symm hil, Ne.symm hjl⟩
      ⟨Ne.symm him, Ne.symm hjm⟩ ⟨Ne.symm hip, Ne.symm hjp⟩) (by norm_num)
  have z4 : innerOp2 (foxProd2 (Xd i j k l) (Jd i j m p)) (Jd k l m p) = 0 :=
    parity_zero oij X12 J13 J23 a3 b1 c5 (by norm_num)
  have z5 : innerOp2 (foxProd2 (Xd i j k l) (Jd i j m p)) (Xd k l m p) = 0 :=
    parity_zero oij X12 J13 X23 a3 b1 (Xd_fix ⟨Ne.symm hik, Ne.symm hjk⟩ ⟨Ne.symm hil, Ne.symm hjl⟩
      ⟨Ne.symm him, Ne.symm hjm⟩ ⟨Ne.symm hip, Ne.symm hjp⟩) (by norm_num)
  have z6 : innerOp2 (foxProd2 (Xd i j k l) (Xd i j m p)) (Jd k l m p) = 0 :=
    parity_zero okl X12 X13 J23 a4 b6 c2 (by norm_num)
  have x4 : innerOp2 (foxProd2 (Xd i j k l) (Xd i j m p)) (Xd k l m p) = 4 :=
    tau_matched hij hik hil him hip hjk hjl hjm hjp hkl hkm hkp hlm hlp hmp
  simp only [HamiltonsCubic.RealLayer.foxProd2_add_left, foxProd2_add_right, foxProd2_smul_left, foxProd2_smul_right,
    innerOp2_add_left, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_right, z1, z2, z3, z4, z5, z6, x4]
  ring
end

end HamiltonsCubic.RectParity
