import Mathlib
import HamiltonsCubic.Results.FourStep8
import HamiltonsCubic.Results.BlockSub

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L220 on the operators: `θ ≤ √(3/2)` at a critical point of `𝒮_Q` with a four-set component

[findings/second-order.md](../../../findings/second-order.md), Lemma L220:
*Let $n\ge5$, $Q=\{i,j,k,l\}$, $V_Q$ the four-set block of character $\chi_Q$ and $\mathcal S_Q=\mathcal D_n\oplus V_Q$. Every unit
critical point $W=D+\nu$ of $P$ in $\mathcal S_Q$ with $\nu\in V_Q$, $\nu\ne0$ and $\theta>0$ has $\theta\le\sqrt{3/2}$,
with equality exactly at padded $W_{\mathbb{CP}^2}$ on $Q$.*
*Write $D=q+r$ with $q\in\Pi_Q$, $r\in\mathcal D_n\ominus\Pi_Q$.* … *9. Arithmetic. Steps 6 to 8 give … $\theta^2\le\tfrac32$.
Equality forces $r=0$, $\lVert\nu\rVert^2=\tfrac12$.*

The steps are assembled through [L220Statement.lean](L220Statement.lean)'s `theta_sq_le` and `equality_case`.

* `PiQ_entries`, `proj_PiQ`: the projection of a Weyl `D` of character `1` on `Π_Q`, `D = q + r` with
  `q = Π_Q(x,y,z)`, `x + y + z = 0`, and `r` Weyl of character `1` orthogonal to `Π_Q`;
* **`L220_bound`**: `θ² ≤ 3/2` at a unit critical `W = D + ν`, `D` Weyl of character `1`, `ν ≠ 0` Weyl of character
  `χ_Q`, `θ > 0`;
* **`L220_eq`**: at `θ² = 3/2`, `D ∈ Π_Q` (the orthogonal part `r` vanishes) and `‖ν‖² = 1/2` (r1839 O2).
-/

namespace HamiltonsCubic.FourL220

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent HamiltonsCubic.FourProd
  HamiltonsCubic.L222Op HamiltonsCubic.FourPi HamiltonsCubic.FourStep4 HamiltonsCubic.FourStep5 HamiltonsCubic.FrameOp2
  HamiltonsCubic.FrameLayer HamiltonsCubic.L224Norm HamiltonsCubic.L224Cubic HamiltonsCubic.ItemFour HamiltonsCubic.PairNorm
  HamiltonsCubic.L224Rank HamiltonsCubic.FourStep67 HamiltonsCubic.FourStep8 HamiltonsCubic.BlockSub

variable {n : ℕ} {i j k l : Fin n}

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- The six entries of `Π_Q(x,y,z)` on `Q`. -/
theorem PiQ_entries (x y z : ℝ) :
    PiQ i j k l x y z i j = x ∧ PiQ i j k l x y z k l = x ∧ PiQ i j k l x y z i k = y ∧
    PiQ i j k l x y z j l = y ∧ PiQ i j k l x y z i l = z ∧ PiQ i j k l x y z j k = z := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;>
    simp [PiQ, E2, Matrix.vecMulVec_apply, Pi.single_apply, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik,
      Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl]

/-- **The projection on `Π_Q`**: a Weyl `D` of character `1` is `q + r` with `q = Π_Q(x,y,z)`, `x + y + z = 0`, and `r`
Weyl of character `1` orthogonal to `Π_Q`. -/
theorem proj_PiQ {D : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hD : SignChar (fun _ => 1) D) :
    ∃ x y z : ℝ, ∃ r : CurvOp2 (Fin n), x + y + z = 0 ∧ D = coordOp (PiQ i j k l x y z) + r ∧ IsWeyl2 r ∧
      SignChar (fun _ => 1) r ∧
      ∀ a b c : ℝ, a + b + c = 0 → innerOp2 r (coordOp (PiQ i j k l a b c)) = 0 := by
  obtain ⟨w, hw, rfl⟩ := (L120Ident.trivial_block_iff D hDW).mp hD
  rw [← coordOp_eq_restrict hw]
  set s1 := w i j + w k l
  set s2 := w i k + w j l
  set s3 := w i l + w j k
  set m := (s1 + s2 + s3) / 3
  refine ⟨(s1 - m) / 2, (s2 - m) / 2, (s3 - m) / 2, coordOp (w - PiQ i j k l ((s1 - m) / 2) ((s2 - m) / 2) ((s3 - m) / 2)),
    by ring, ?_, ?_⟩
  · rw [← coordOp_add]; congr 1; abel
  have hs : (s1 - m) / 2 + (s2 - m) / 2 + (s3 - m) / 2 = 0 := by ring
  set P := PiQ i j k l ((s1 - m) / 2) ((s2 - m) / 2) ((s3 - m) / 2) with hPdef
  have hP : IsWeight P := PiQ_weight hij hik hil hjk hjl hkl hs
  have hwP : IsWeight (w - P) := by
    refine ⟨fun a b => ?_, fun a => ?_, fun a => ?_⟩
    · rw [Matrix.sub_apply, Matrix.sub_apply, hw.symm, hP.symm]
    · rw [Matrix.sub_apply, hw.hollow, hP.hollow, sub_zero]
    · simp only [Matrix.sub_apply, Finset.sum_sub_distrib, hw.rowSum, hP.rowSum, sub_zero]
  have hT : (w - P)ᵀ = w - P := by ext a b; rw [Matrix.transpose_apply, hwP.symm]
  refine ⟨?_, ?_, ?_⟩
  · rw [coordOp_eq_restrict hwP]; exact isWeyl2_restrict _
  · rw [coordOp_eq_restrict hwP]
    exact (L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hwP, rfl⟩
  · intro a b c habc
    rw [innerOp2_comm, inner_PiQ hij hik hil hjk hjl hkl a b c _ hT]
    obtain ⟨e1, e2, e3, e4, e5, e6⟩ := PiQ_entries hij hik hil hjk hjl hkl ((s1 - m) / 2) ((s2 - m) / 2) ((s3 - m) / 2)
    simp only [Matrix.sub_apply, hPdef, e1, e2, e3, e4, e5, e6]
    linear_combination m * habc

/-- **L220 on the operators**: a unit critical point `W = D + ν` of `P` in `𝒮_Q`, `D` Weyl of character `1`,
`ν ≠ 0` Weyl of character `χ_Q`, `Q(W) = θW` with `θ > 0`, has `θ² ≤ 3/2`. -/
theorem L220_bound {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hD : SignChar (fun _ => 1) D) (hνW : IsWeyl2 ν)
    (hν : SignChar (setChar {i, j, k, l}) ν) (hν0 : ν ≠ 0) {θ : ℝ} (hθ : 0 < θ)
    (hQ : Qop2 (D + ν) = θ • (D + ν)) (hunit : normSq2 (D + ν) = 1) : θ ^ 2 ≤ 3 / 2 := by
  obtain ⟨x, y, z, r, hs, rfl, hrW, hr, hperp⟩ := proj_PiQ hij hik hil hjk hjl hkl hDW hD
  obtain ⟨hsplit, hDν⟩ := L220_split hD hν hQ
  have heig := Lq_eigen hij hik hil hjk hjl hkl hrW hr hperp hνW hν hDν
  have h5 := step5 hij hik hil hjk hjl hkl hs hνW hν hν0 heig
  have h6 := step6 hij hik hil hjk hjl hkl hs hrW hperp hνW hsplit heig
  have h7 := step7 hij hik hil hjk hjl hkl hs hθ.le h5.symm
  have h8 := step8 hij hik hil hjk hjl hkl hs hθ.le h5.symm hrW hr hperp
  have hN := norm_split (x := x) (y := y) (z := z) hij hik hil hjk hjl hkl hs hrW hr hperp hνW hν
  rw [hunit] at hN
  exact HamiltonsCubic.L220Statement.theta_sq_le θ _ _ _ _ _ hθ (normSq2_nonneg r) (normSq2_nonneg ν) hN.symm
    h5.symm (by linarith) h7 h8

/-- **L220's equality clause on the operators**: at `θ² = 3/2` the orthogonal part `r` vanishes and `‖ν‖² = 1/2`. -/
theorem L220_eq {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hD : SignChar (fun _ => 1) D) (hνW : IsWeyl2 ν)
    (hν : SignChar (setChar {i, j, k, l}) ν) (hν0 : ν ≠ 0) {θ : ℝ} (hθ : 0 < θ)
    (hQ : Qop2 (D + ν) = θ • (D + ν)) (hunit : normSq2 (D + ν) = 1) (heq : θ ^ 2 = 3 / 2) :
    ∃ x y z : ℝ, x + y + z = 0 ∧ D = coordOp (PiQ i j k l x y z) ∧ normSq2 ν = 1 / 2 := by
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
  refine ⟨x, y, z, hs, ?_, hNu⟩
  rw [normSq2_eq_zero hR]
  exact add_zero (coordOp (PiQ i j k l x y z) : CurvOp2 (Fin n))

end

end HamiltonsCubic.FourL220
