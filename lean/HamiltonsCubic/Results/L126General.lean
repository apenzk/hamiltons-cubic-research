import HamiltonsCubic.Results.L126DF
import HamiltonsCubic.Results.L121

set_option linter.style.longLine false

/-!
# L126's clause at a general diagonal `M`: a four-set block meets the `½`-eigenspace of `L_e` exactly when `Σ = θ²`

[findings/second-order.md](../../../findings/second-order.md), Lemma L126: *"`ker DF(M)` is the `½`-eigenspace of
`L_e`, which by Lemma L121 a four-set block meets exactly when `Σ_{ijkl} = θ²`"*, at a diagonal `M`. The theorem
below takes `θ` as a free positive real, and when `θ = P(M)`, so that `L_e = M∘/θ`, its condition `M ∘ v = (θ/2) v`
on a Bianchi vector `v = x a + y b + z c` is `L_e v = ½ v`:

* **`G_eigen_iff`**: on triples, `G` has an eigenvector in `𝟏^⊥` with eigenvalue `θ > 0` exactly when `D = θ²`;
* **`span_coords`**: `x a + y b + z c` sends `φ_ij`, `φ_ki`, `φ_il` to `x φ_kl`, `y φ_jl`, `z φ_jk`, so the coordinates
  are read off the operator;
* **`general_meets_iff`**: at a symmetric weight `w`, four distinct indices and `θ > 0`, some nonzero Bianchi vector of
  the four-set span has `M ∘ v = (θ/2) v` on every bivector exactly when `A² + B² + C² − AB − BC − CA = θ²`.
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.FourSet

/-- **`G` has an eigenvector in `𝟏^⊥` with eigenvalue `θ > 0` exactly when `D = θ²`.** -/
theorem G_eigen_iff (A B C θ : ℝ) (hθ : 0 < θ) :
    (∃ x : ℝ × ℝ × ℝ, x.1 + x.2.1 + x.2.2 = 0 ∧ x ≠ 0 ∧ Gv A B C x = (θ * x.1, θ * x.2.1, θ * x.2.2))
      ↔ D A B C = θ ^ 2 := by
  constructor
  · rintro ⟨x, hx, hne, heig⟩
    have h2 := G_sq_perp A B C hx
    rw [heig, Gv_smul, heig] at h2
    obtain ⟨x1, x2, x3⟩ := x
    simp only [Prod.mk.injEq] at h2
    obtain ⟨e1, e2, e3⟩ := h2
    by_contra hD
    have hD' : θ * θ - D A B C ≠ 0 := by intro h; apply hD; nlinarith
    apply hne
    have z1 : x1 = 0 := by
      have : (θ * θ - D A B C) * x1 = 0 := by linarith
      exact (mul_eq_zero.mp this).resolve_left hD'
    have z2 : x2 = 0 := by
      have : (θ * θ - D A B C) * x2 = 0 := by linarith
      exact (mul_eq_zero.mp this).resolve_left hD'
    have z3 : x3 = 0 := by
      have : (θ * θ - D A B C) * x3 = 0 := by linarith
      exact (mul_eq_zero.mp this).resolve_left hD'
    simp [z1, z2, z3]
  · intro hD
    -- `x = G u + θ u` is an eigenvector whenever it is nonzero
    have key : ∀ u : ℝ × ℝ × ℝ, u.1 + u.2.1 + u.2.2 = 0 →
        let x : ℝ × ℝ × ℝ := ((Gv A B C u).1 + θ * u.1, (Gv A B C u).2.1 + θ * u.2.1, (Gv A B C u).2.2 + θ * u.2.2)
        x.1 + x.2.1 + x.2.2 = 0 ∧ Gv A B C x = (θ * x.1, θ * x.2.1, θ * x.2.2) := by
      intro u hu x
      have hp := G_preserves_perp A B C hu
      have hsq := G_sq_perp A B C hu
      refine ⟨by simp only [x]; linear_combination hp + θ * hu, ?_⟩
      obtain ⟨u1, u2, u3⟩ := u
      simp only [Gv, Prod.mk.injEq, D] at hsq hD hp ⊢
      simp only [x, Gv]
      obtain ⟨s1, s2, s3⟩ := hsq
      refine ⟨?_, ?_, ?_⟩
      · linear_combination s1 + u1 * hD
      · linear_combination s2 + u2 * hD
      · linear_combination s3 + u3 * hD
    obtain ⟨p1, e1⟩ := key (1, -1, 0) (by norm_num)
    obtain ⟨p2, e2⟩ := key (0, 1, -1) (by norm_num)
    by_cases h1 : ((Gv A B C (1, -1, 0)).1 + θ * 1, (Gv A B C (1, -1, 0)).2.1 + θ * -1,
        (Gv A B C (1, -1, 0)).2.2 + θ * 0) = (0 : ℝ × ℝ × ℝ)
    · by_cases h2 : ((Gv A B C (0, 1, -1)).1 + θ * 0, (Gv A B C (0, 1, -1)).2.1 + θ * 1,
          (Gv A B C (0, 1, -1)).2.2 + θ * -1) = (0 : ℝ × ℝ × ℝ)
      · exfalso
        have a1 := congrArg Prod.fst h1
        have a3 := congrArg (fun q : ℝ × ℝ × ℝ => q.2.2) h1
        have b1 := congrArg Prod.fst h2
        have b2 := congrArg (fun q : ℝ × ℝ × ℝ => q.2.1) h2
        simp only [Gv] at a1 a3 b1 b2
        simp at a1 a3 b1 b2
        linarith
      · exact ⟨_, p2, h2, e2⟩
    · exact ⟨_, p1, h1, e1⟩

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The coordinates are read off the operator**: `x a + y b + z c` sends `φ_ij`, `φ_ki`, `φ_il` to `x φ_kl`, `y φ_jl`,
`z φ_jk`. -/
theorem span_coords {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
    (x y z : ℝ) :
    let S : CurvOp ι := fun Y => x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y
      + z • rk2 (phi i l) (phi j k) Y
    S (phi i j) = x • phi k l ∧ S (phi k i) = y • phi j l ∧ S (phi i l) = z • phi j k := by
  intro S
  simp only [S, rk2, inner2_phi_phi]
  refine ⟨?_, ?_, ?_⟩ <;>
  simp [hij, hik, hil, hjk, hjl, hkl, hij.symm, hik.symm, hil.symm, hjk.symm, hjl.symm, hkl.symm]

omit [Fintype ι] in
theorem phi_entry {p q : ι} (hpq : p ≠ q) (c : ℝ) : (c • phi p q) q p = c := by
  simp [phi, hpq, hpq.symm]

/-- **L126'S CLAUSE AT A GENERAL DIAGONAL `M`**: at a symmetric weight, four distinct indices and `θ > 0`, some nonzero
Bianchi vector `v` of the four-set span has `M ∘ v = (θ/2) v` on every bivector exactly when
`Σ = A² + B² + C² − AB − BC − CA = θ²`. At `θ = P(M)` the condition is `L_e v = ½ v` with `e = M/θ`. -/
theorem general_meets_iff (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k)
    (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) (θ : ℝ) (hθ : 0 < θ) :
    (∃ x y z : ℝ, x + y + z = 0 ∧ (x, y, z) ≠ (0 : ℝ × ℝ × ℝ) ∧ ∀ X : Matrix ι ι ℝ, IsSkew X →
        foxProd (diagOp w) (fun Y => x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y
          + z • rk2 (phi i l) (phi j k) Y) X
        = (θ / 2) • (x • rk2 (phi i j) (phi k l) X + y • rk2 (phi k i) (phi j l) X + z • rk2 (phi i l) (phi j k) X))
      ↔ D (w i j + w k l) (w i k + w j l) (w i l + w j k) = θ ^ 2 := by
  set A := w i j + w k l
  set B := w i k + w j l
  set C := w i l + w j k
  rw [← G_eigen_iff A B C θ hθ]
  constructor
  · rintro ⟨x, y, z, hs, hne, h⟩
    refine ⟨(x, y, z), hs, hne, ?_⟩
    have ev : ∀ X, IsSkew X → (1 / 2 : ℝ) • ((A * x + C * y + B * z) • rk2 (phi i j) (phi k l) X
        + (C * x + B * y + A * z) • rk2 (phi k i) (phi j l) X + (B * x + A * y + C * z) • rk2 (phi i l) (phi j k) X)
        = (θ / 2) • (x • rk2 (phi i j) (phi k l) X + y • rk2 (phi k i) (phi j l) X + z • rk2 (phi i l) (phi j k) X) := by
      intro X hX
      rw [← fourSet_span w hw hij hik hil hjk hjl hkl hX x y z]; exact h X hX
    obtain ⟨c1, -, -⟩ := span_coords hij hik hil hjk hjl hkl (A * x + C * y + B * z) (C * x + B * y + A * z) (B * x + A * y + C * z)
    obtain ⟨d1, -, -⟩ := span_coords hij hik hil hjk hjl hkl x y z
    obtain ⟨-, c2, -⟩ := span_coords hij hik hil hjk hjl hkl (A * x + C * y + B * z) (C * x + B * y + A * z) (B * x + A * y + C * z)
    obtain ⟨-, d2, -⟩ := span_coords hij hik hil hjk hjl hkl x y z
    obtain ⟨-, -, c3⟩ := span_coords hij hik hil hjk hjl hkl (A * x + C * y + B * z) (C * x + B * y + A * z) (B * x + A * y + C * z)
    obtain ⟨-, -, d3⟩ := span_coords hij hik hil hjk hjl hkl x y z
    simp only at c1 d1 c2 d2 c3 d3
    have e1 := congrArg (fun Mx : Matrix ι ι ℝ => Mx l k) (ev _ (phi_isSkew i j))
    have e2 := congrArg (fun Mx : Matrix ι ι ℝ => Mx l j) (ev _ (phi_isSkew k i))
    have e3 := congrArg (fun Mx : Matrix ι ι ℝ => Mx k j) (ev _ (phi_isSkew i l))
    simp only [c1, d1, c2, d2, c3, d3, phi_entry hkl, phi_entry hjl, phi_entry hjk, Matrix.smul_apply,
      smul_eq_mul] at e1 e2 e3
    simp only [Gv, Prod.mk.injEq]
    refine ⟨?_, ?_, ?_⟩
    · have := phi_entry hkl 1; simp at this; nlinarith [e1]
    · have := phi_entry hjl 1; simp at this; nlinarith [e2]
    · have := phi_entry hjk 1; simp at this; nlinarith [e3]
  · rintro ⟨⟨x, y, z⟩, hs, hne, heig⟩
    refine ⟨x, y, z, hs, hne, fun X hX => ?_⟩
    rw [fourSet_span w hw hij hik hil hjk hjl hkl hX x y z]
    simp only [Gv, Prod.mk.injEq] at heig
    obtain ⟨g1, g2, g3⟩ := heig
    rw [g1, g2, g3]
    module

end HamiltonsCubic.L126Assembly
