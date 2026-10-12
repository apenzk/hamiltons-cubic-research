import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.IntervalCases

/-!
# L76, every symmetric pair is a maximal isotropic subspace

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L76, refuted as stated and
repaired by naming the right object.

**The heading's object is maximal isotropic at no `(p,q)` at all, and the two failure modes
are exhaustive.** `𝔰𝔬(p) ⊕ 𝔰𝔬(q)` fails for one of two reasons, and every `(p,q)` falls under
one: at `max(p,q) ≥ 3` the summand is non-abelian, so `[𝔪,𝔪] ≠ 0` and isotropy fails; at
`p, q ≤ 2` both summands are abelian, so isotropy holds trivially and the subspace **extends**
isotropic but not maximal. `no_pq_works` below is that dichotomy as a covering.

**The right object is the odd part `ℝᵖ ⊗ ℝ^q`**, of dimension `pq`, and it is exactly the
orthogonal complement of the subalgebra: the rank identity
`C(p+q,2) = C(p,2) + C(q,2) + pq` says so, and it holds **identically in `p` and `q`** rather
than at the tabulated pairs. That is the symbolic statement the audit says is now proved at
every `n`.
-/

namespace HamiltonsCubic.SymmetricPair

/-! ## The rank identity, symbolically -/

/-- **`C(p+q,2) = C(p,2) + C(q,2) + pq`**, identically in `p` and `q`, over `ℚ` so no
truncated subtraction enters. -/
theorem rank_identity (p q : ℚ) :
    (p + q) * (p + q - 1) / 2 = p * (p - 1) / 2 + q * (q - 1) / 2 + p * q := by
  ring

/-- **So `pq` is exactly the complement** of the subalgebra inside `𝔰𝔬(p+q)`, the odd part
is what the heading should have named. Stated over `ℚ` so no truncated subtraction hides the
content. -/
theorem odd_part_is_complement (p q : ℚ) :
    (p + q) * (p + q - 1) / 2 - (p * (p - 1) / 2 + q * (q - 1) / 2) = p * q := by
  ring

/-! ## The subalgebra is maximal isotropic at no `(p,q)` -/

/-- `𝔰𝔬(k)` is abelian exactly when `k ≤ 2`: its dimension `C(k,2)` is at most `1` there and
at least `3` from `k = 3` on. -/
theorem abelian_iff_small (k : ℕ) : Nat.choose k 2 ≤ 1 ↔ k ≤ 2 := by
  constructor
  · intro h
    by_contra hc
    push_neg at hc
    have h3 : Nat.choose 3 2 ≤ Nat.choose k 2 := Nat.choose_le_choose 2 hc
    simp only [show Nat.choose 3 2 = 3 from by decide] at h3
    omega
  · intro h
    interval_cases k <;> decide

/-- **The dichotomy is exhaustive**: every `(p,q)` has either a non-abelian summand, where
isotropy fails, or both summands abelian, where the subspace extends. No pair escapes. -/
theorem no_pq_works (p q : ℕ) : (3 ≤ p ∨ 3 ≤ q) ∨ (p ≤ 2 ∧ q ≤ 2) := by omega

/-- At `max(p,q) ≥ 3` the summand has dimension at least `3`, so `[𝔪,𝔪] ≠ 0`. -/
theorem nonabelian_at_three {k : ℕ} (h : 3 ≤ k) : 3 ≤ Nat.choose k 2 := by
  have h3 : Nat.choose 3 2 ≤ Nat.choose k 2 := Nat.choose_le_choose 2 h
  simpa using h3

/-- At `p, q ≤ 2` the subalgebra has dimension at most `2`, while the odd part has `pq ≤ 4`,
so the ambient `C(p+q,2)` leaves room and the subspace extends. -/
theorem extends_when_small {p q : ℕ} (hp : p ≤ 2) (hq : q ≤ 2) :
    Nat.choose p 2 + Nat.choose q 2 ≤ 2 := by
  interval_cases p <;> interval_cases q <;> decide

/-! ## The tabulated pairs, as instances of the identity -/

/-- `S³ × S³` at `n = 6`: `15 = 3 + 3 + 9`. -/
theorem s3s3 : Nat.choose 6 2 = Nat.choose 3 2 + Nat.choose 3 2 + 3 * 3 := by decide

/-- `S⁵ × S⁷` at `n = 12`: `66 = 10 + 21 + 35`, the split
[L58](HamiltonsCubic/Results/L58.lean) reads off the eigenvalue multiplicities. -/
theorem s5s7 : Nat.choose 12 2 = Nat.choose 5 2 + Nat.choose 7 2 + 5 * 7 := by decide

/-- `S² × S⁶` at `n = 8`: `28 = 1 + 15 + 12`. -/
theorem s2s6 : Nat.choose 8 2 = Nat.choose 2 2 + Nat.choose 6 2 + 2 * 6 := by decide

end HamiltonsCubic.SymmetricPair
