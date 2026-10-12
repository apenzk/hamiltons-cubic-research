import Mathlib

set_option linter.style.longLine false

/-!
# I117's Lemma E: the idempotents of `a P_k + b P_p` on a symmetric pair

[reviews/2026-09-26-I73-class-ceiling.md](../../../reviews/2026-09-26-I73-class-ceiling.md), batch 37, Lemma E: for a
symmetric pair `𝔤 = 𝔨 ⊕ 𝔭` of a compact simple `𝔤` with `I # I = cI` and a single Casimir value `c_k` on `𝔨`, the idempotents
among `C = a P_k + b P_p` are `0`, `P_k / c_k`, `I / c` and `σ / c`, `σ = P_k - P_p`.

**`SymmetricPair`** carries the proof's inputs as data on any real module with a symmetric bilinear `#`: the three
block relations `P_k # P_k = c_k P_k`, `P_k # P_p = α P_p`, `P_p # P_p = β P_k`, and `I # I = cI` read on each block,
`2α = c` and `c_k + β = c`. **`idempotent_iff`** is the lemma's conclusion from them. *The first relation is the single
Casimir value on `𝔨`, and the other two follow from the bracket supports with `I # I = cI`. That step is the Lie
theory, and enters as the structure's fields.*
-/

namespace HamiltonsCubic.I117

/-- The data Lemma E's proof uses: `#` symmetric bilinear, and the block relations. -/
structure SymmetricPair (E : Type*) [AddCommGroup E] [Module ℝ E] where
  sharp : E →ₗ[ℝ] E →ₗ[ℝ] E
  sharp_symm : ∀ x y, sharp x y = sharp y x
  Pk : E
  Pp : E
  c : ℝ
  ck : ℝ
  α : ℝ
  β : ℝ
  kk : sharp Pk Pk = ck • Pk
  kp : sharp Pk Pp = α • Pp
  pp : sharp Pp Pp = β • Pk
  trace_p : 2 * α = c
  trace_k : ck + β = c
  indep : LinearIndependent ℝ ![Pk, Pp]

namespace SymmetricPair

variable {E : Type*} [AddCommGroup E] [Module ℝ E] (S : SymmetricPair E)

/-- `C # C` for `C = a P_k + b P_p`. -/
theorem sharp_C (a b : ℝ) :
    S.sharp (a • S.Pk + b • S.Pp) (a • S.Pk + b • S.Pp)
      = (a ^ 2 * S.ck + b ^ 2 * S.β) • S.Pk + (a * b * S.c) • S.Pp := by
  simp only [map_add, map_smul, LinearMap.add_apply, LinearMap.smul_apply, S.kk, S.kp, S.pp,
    S.sharp_symm S.Pp S.Pk, smul_smul]
  rw [← S.trace_p]
  module

/-- **Lemma E**: with `c`, `c_k`, `β` nonzero, `a P_k + b P_p` is `#`-idempotent exactly at `(0, 0)`, `(1/c_k, 0)`,
`(1/c, 1/c)` and `(1/c, -1/c)`. -/
theorem idempotent_iff (hc : S.c ≠ 0) (hck : S.ck ≠ 0) (hβ : S.β ≠ 0) (a b : ℝ) :
    S.sharp (a • S.Pk + b • S.Pp) (a • S.Pk + b • S.Pp) = a • S.Pk + b • S.Pp ↔
      (a = 0 ∧ b = 0) ∨ (a = 1 / S.ck ∧ b = 0) ∨ (a = 1 / S.c ∧ b = 1 / S.c) ∨ (a = 1 / S.c ∧ b = -1 / S.c) := by
  rw [sharp_C]
  have hcoef : (a ^ 2 * S.ck + b ^ 2 * S.β) • S.Pk + (a * b * S.c) • S.Pp = a • S.Pk + b • S.Pp ↔
      a ^ 2 * S.ck + b ^ 2 * S.β = a ∧ a * b * S.c = b := by
    constructor
    · intro h
      have := LinearIndependent.pair_iff.mp S.indep (a ^ 2 * S.ck + b ^ 2 * S.β - a) (a * b * S.c - b)
        (by rw [sub_smul, sub_smul]; rw [← sub_eq_zero] at h; rw [← h]; abel)
      constructor <;> linarith [this.1, this.2]
    · rintro ⟨h1, h2⟩; rw [h1, h2]
  rw [hcoef]
  have hβc : S.β = S.c - S.ck := by linarith [S.trace_k]
  constructor
  · rintro ⟨h1, h2⟩
    by_cases hb : b = 0
    · subst hb
      have : a * (a * S.ck - 1) = 0 := by nlinarith
      rcases mul_eq_zero.mp this with ha | ha
      · left; exact ⟨ha, rfl⟩
      · right; left; refine ⟨?_, rfl⟩; field_simp; linarith
    · have ha : a = 1 / S.c := by
        have : b * (a * S.c - 1) = 0 := by linarith
        rcases mul_eq_zero.mp this with h | h
        · exact absurd h hb
        · field_simp; linarith
      subst ha
      have hb2 : b ^ 2 = 1 / S.c ^ 2 := by
        rw [hβc] at h1
        have hsub : S.c - S.ck ≠ 0 := by rw [← hβc]; exact hβ
        field_simp at h1 ⊢
        have : (S.c - S.ck) * (b ^ 2 * S.c ^ 2 - 1) = 0 := by nlinarith
        rcases mul_eq_zero.mp this with h | h
        · exact absurd h hsub
        · linarith
      have : (b - 1 / S.c) * (b + 1 / S.c) = 0 := by ring_nf; rw [hb2]; ring
      rcases mul_eq_zero.mp this with h | h
      · right; right; left; exact ⟨rfl, by linarith⟩
      · right; right; right; refine ⟨rfl, ?_⟩; rw [neg_div]; linarith
  · rintro (⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩)
    · simp
    · refine ⟨?_, by ring⟩; field_simp; ring
    · rw [hβc]; constructor <;> field_simp <;> ring
    · rw [hβc]; constructor <;> field_simp <;> ring

end SymmetricPair

end HamiltonsCubic.I117
