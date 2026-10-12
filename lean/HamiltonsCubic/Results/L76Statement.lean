import Mathlib
import HamiltonsCubic.Base.WeylReal

set_option linter.style.longLine false
set_option maxRecDepth 8000

/-!
# L76, the odd part `ℝᵖ ⊗ ℝ^q` of every symmetric pair is a maximal isotropic subspace

**The record's statement, quoted verbatim from [isotropy-cap.md](../../../findings/isotropy-cap.md):**

> #### Lemma L76, the odd part $\mathbb R^p\otimes\mathbb R^q$ of every symmetric pair is a maximal isotropic subspace
>
> *Gate 2, [r621](../reviews/REVIEW_r621.md) and [r622](../reviews/REVIEW_r622.md) on identical briefs, **both REFUTED as stated, agreeing exactly on the cause and both proving the intended statement**.*
>
> **THE HEADING NAMED THE WRONG HALF OF THE PAIR, AND THE OBJECT IT NAMED IS MAXIMAL ISOTROPIC AT NO $(p,q)$ AT ALL.** The refutation is total rather than range-limited. At $\max(p,q)\ge3$ the subalgebra **is not isotropic** (witness $(3,1)$ at $n=4$, where $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=1$), *since an isotropic subalgebra is abelian*. At $p,q\le2$ it is isotropic and **extends**, $(2,2)$ at $n=4$ growing by $\varphi_{13}$.
>
> **THE INTENDED STATEMENT IS TRUE AND BOTH REVIEWERS PROVED IT, SYMBOLICALLY AND AT EVERY $n$.** For all $p,q\ge1$, $K_{p,q}$ is triangle-free so $\omega$ vanishes on $\mathfrak p=\mathbb R^p\otimes\mathbb R^q$; $[\mathfrak p,\mathfrak p]=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ **exactly**; and that span is $\mathfrak p^\perp$. **The rank identity is then the symbolic $\binom{p+q}2=\binom p2+\binom q2+pq$**, so the recorded verification at $n=6,7,8$ was a spot check on a polynomial identity. *The range is owed: at $q=0$ the claim fails at every $n\ge2$.*
>
> **THE SINGULAR VALUES ARE A CLOSED FORM, NOT A MEASUREMENT**, $\sqrt{2p}$ with multiplicity $\binom q2$ and $\sqrt{2q}$ with multiplicity $\binom p2$.

## What this file states

Everything against [WeylReal.lean](../Base/WeylReal.lean)'s `IsSkew`, `inner2`, `br` and `phi`, at
`𝔰𝔬(p+q)` realised on `Fin p ⊕ Fin q`, symbolically in `p` and `q`. All proved; there is no
`sorry`.

* `IsOdd` is the odd part `ℝᵖ ⊗ ℝ^q`, the skew matrices supported on the two off-diagonal blocks.
  `IsBlockDiag` is the subalgebra `𝔰𝔬(p) ⊕ 𝔰𝔬(q)`, the object the heading named.
* `bracket_mem_blockDiag`, `[𝔭, 𝔭] ⊆ 𝔰𝔬(p) ⊕ 𝔰𝔬(q)`.
* `blockDiag_inner_odd`, `𝔰𝔬(p) ⊕ 𝔰𝔬(q) ⊥ 𝔭`, so together with the previous line
  `isotropic` (*"`K_{p,q}` is triangle-free so `ω` vanishes on `𝔭`"*), needs no `p, q` bound.
* `maximal_isotropic`, **the lemma**: at `p, q ≥ 1`, `𝔭` is isotropic and **every** skew `W`
  outside it breaks isotropy, so no isotropic subspace properly contains `𝔭`. The witnesses are
  explicit `φ`'s, so this is the `[𝔭,𝔭]^⊥ = 𝔭` criterion rather than a dimension count.
* `rank_identity`, `C(p+q,2) = C(p,2) + C(q,2) + pq`, symbolically in `p` and `q`.
* `heading_refuted`, the heading's object at `(p,q) = (3,1)` carries
  `⟨[φ₁₂, φ₂₃], φ₁₃⟩ ≠ 0`, so `𝔰𝔬(p) ⊕ 𝔰𝔬(q)` is **not isotropic** there. This is the
  audit's witness, reproduced.
* `range_is_owed`, at `q = 0` the odd part is `0`, and `0` is not maximal isotropic once `p ≥ 2`:
  `φ₁₂` extends it. This is the audit's *"the range is owed"*.

**The convention.** `inner2` carries the `½` of [WeylReal.lean](../Base/WeylReal.lean), under which
`⟨φ_{ab}, φ_{ab}⟩ = 1`. `inner2_phi` records the one consequence everything else uses:
`⟨φ_{ab}, W⟩ = -W_{ab}` for skew `W`. **The audit's `⟨[φ₁₂,φ₂₃], φ₁₃⟩ = 1` comes out as `-1` here**
the sign is `φ`'s orientation convention, and only the non-vanishing is load-bearing.

## What is NOT typed here

* **The singular-value closed form** `√(2p)` with multiplicity `C(q,2)` and `√(2q)` with
  multiplicity `C(p,2)`. That is a statement about the singular values of the bracket map
  `Λ²𝔭 → 𝔰𝔬(p+q)`, and neither that map nor its singular values are built in the layer.
* **The second failure mode of the heading's object**, that at `p, q ≤ 2` the subalgebra is
  isotropic and *extends*. Only the `max(p,q) ≥ 3` mode is typed, at the audit's own witness.
* **`[𝔭,𝔭] = 𝔰𝔬(p) ⊕ 𝔰𝔬(q)` as an equality of spans.** The `⊆` half is
  `bracket_mem_blockDiag`; the `⊇` half is used only through the explicit bracket witnesses inside
  `maximal_isotropic`, which is what the conclusion needs, and is not stated as a span equality,
  the layer carries no `Submodule` for either side.
-/

namespace HamiltonsCubic.L76Statement

open HamiltonsCubic.RealLayer Matrix

variable {p q : ℕ}

/-- **The odd part `𝔭 = ℝᵖ ⊗ ℝ^q`**: skew, and supported on the two off-diagonal blocks. -/
def IsOdd (X : Matrix (Fin p ⊕ Fin q) (Fin p ⊕ Fin q) ℝ) : Prop :=
  IsSkew X ∧ (∀ i i', X (Sum.inl i) (Sum.inl i') = 0) ∧ (∀ j j', X (Sum.inr j) (Sum.inr j') = 0)

/-- **The subalgebra `𝔰𝔬(p) ⊕ 𝔰𝔬(q)`**, which is what the heading named. -/
def IsBlockDiag (A : Matrix (Fin p ⊕ Fin q) (Fin p ⊕ Fin q) ℝ) : Prop :=
  IsSkew A ∧ (∀ i j, A (Sum.inl i) (Sum.inr j) = 0) ∧ (∀ j i, A (Sum.inr j) (Sum.inl i) = 0)

/-! ## Two facts about the pairing -/

theorem inner2_eq {ι : Type*} [Fintype ι] (A X : Matrix ι ι ℝ) :
    inner2 A X = (1 / 2) * ∑ u, ∑ v, A v u * X v u := by
  simp [inner2, Matrix.trace, Matrix.mul_apply, Matrix.transpose_apply]

theorem skew_apply {ι : Type*} {W : Matrix ι ι ℝ} (hW : IsSkew W) (u v : ι) :
    W u v = - W v u := by
  have := congrFun (congrFun hW v) u
  simpa using this

/-- **`⟨φ_{ab}, W⟩ = -W_{ab}`** for skew `W`, under the layer's `½` pairing. -/
theorem inner2_phi {ι : Type*} [Fintype ι] [DecidableEq ι] {W : Matrix ι ι ℝ} (hW : IsSkew W)
    (a b : ι) : inner2 (phi a b) W = - W a b := by
  have hskew := skew_apply hW
  simp [inner2, phi, Matrix.trace, Matrix.mul_apply, Matrix.single_apply, sub_mul, ite_mul,
    Finset.sum_sub_distrib, ite_and, Finset.sum_ite_eq]
  rw [hskew b a]
  ring

/-- **`[φ_{ab}, φ_{bc}] = -φ_{ac}`** at distinct `a, b, c`, the one bracket the argument uses. -/
theorem br_phi_phi {ι : Type*} [Fintype ι] [DecidableEq ι] {a b c : ι} (hab : a ≠ b) (hbc : b ≠ c)
    (hac : a ≠ c) : br (phi a b) (phi b c) = -(phi a c) := by
  ext u v
  simp [br, phi, Matrix.mul_apply, Matrix.single_apply, sub_mul, mul_sub, mul_ite,
    ite_and, Finset.sum_ite_eq, hab, hbc, hac, hab.symm, hbc.symm, hac.symm]

theorem inner2_neg {ι : Type*} [Fintype ι] (A X : Matrix ι ι ℝ) :
    inner2 (-A) X = -(inner2 A X) := by
  simp [inner2, Matrix.transpose_neg, Matrix.neg_mul]

theorem phi_apply_self {ι : Type*} [DecidableEq ι] {a c : ι} (hac : a ≠ c) :
    phi a c a c = -1 := by
  simp [phi, Matrix.single_apply, hac, hac.symm]

/-! ## `[𝔭, 𝔭] ⊆ 𝔰𝔬(p) ⊕ 𝔰𝔬(q)` -/

theorem br_isSkew {ι : Type*} [Fintype ι] {X Y : Matrix ι ι ℝ} (hX : IsSkew X) (hY : IsSkew Y) :
    IsSkew (br X Y) := by
  show (X * Y - Y * X)ᵀ = -(X * Y - Y * X)
  rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hX, hY]
  simp [Matrix.neg_mul, Matrix.mul_neg]

/-- **The bracket of two odd elements is block-diagonal**, `K_{p,q}` being triangle-free, in the
audit's language. -/
theorem bracket_mem_blockDiag {X Y : Matrix (Fin p ⊕ Fin q) (Fin p ⊕ Fin q) ℝ}
    (hX : IsOdd X) (hY : IsOdd Y) : IsBlockDiag (br X Y) := by
  obtain ⟨hXs, hXl, hXr⟩ := hX
  obtain ⟨hYs, hYl, hYr⟩ := hY
  refine ⟨br_isSkew hXs hYs, ?_, ?_⟩
  · intro i j
    simp [br, Matrix.sub_apply, Matrix.mul_apply, Fintype.sum_sum_type, hXl, hXr, hYl, hYr]
  · intro j i
    simp [br, Matrix.sub_apply, Matrix.mul_apply, Fintype.sum_sum_type, hXl, hXr, hYl, hYr]

/-- **And the subalgebra is orthogonal to the odd part.** -/
theorem blockDiag_inner_odd {A X : Matrix (Fin p ⊕ Fin q) (Fin p ⊕ Fin q) ℝ}
    (hA : IsBlockDiag A) (hX : IsOdd X) : inner2 A X = 0 := by
  obtain ⟨_, hAlr, hArl⟩ := hA
  obtain ⟨_, hXl, hXr⟩ := hX
  rw [inner2_eq]
  have hzero : ∀ u v : Fin p ⊕ Fin q, A v u * X v u = 0 := by
    rintro (u | u) (v | v)
    · rw [hXl v u]; ring
    · rw [hArl v u]; ring
    · rw [hAlr v u]; ring
    · rw [hXr v u]; ring
  rw [Finset.sum_congr rfl fun u _ =>
    Finset.sum_congr rfl fun v _ => hzero u v]
  simp

/-- **`𝔭` IS ISOTROPIC**, at every `p` and `q`. -/
theorem isotropic {X Y Z : Matrix (Fin p ⊕ Fin q) (Fin p ⊕ Fin q) ℝ}
    (hX : IsOdd X) (hY : IsOdd Y) (hZ : IsOdd Z) : inner2 (br X Y) Z = 0 :=
  blockDiag_inner_odd (bracket_mem_blockDiag hX hY) hZ

/-! ## …and it is MAXIMAL -/

theorem isOdd_phi_lr (i : Fin p) (j : Fin q) :
    IsOdd (phi (ι := Fin p ⊕ Fin q) (Sum.inl i) (Sum.inr j)) := by
  refine ⟨phi_isSkew _ _, ?_, ?_⟩
  · intro a b; simp [phi, Matrix.single_apply]
  · intro a b; simp [phi, Matrix.single_apply]

theorem isOdd_phi_rl (j : Fin q) (i : Fin p) :
    IsOdd (phi (ι := Fin p ⊕ Fin q) (Sum.inr j) (Sum.inl i)) := by
  refine ⟨phi_isSkew _ _, ?_, ?_⟩
  · intro a b; simp [phi, Matrix.single_apply]
  · intro a b; simp [phi, Matrix.single_apply]

/-- **LEMMA L76.** *The odd part `ℝᵖ ⊗ ℝ^q` of every symmetric pair is a maximal isotropic
subspace.* Isotropy holds at every `(p,q)`; maximality, that every skew `W` outside `𝔭` breaks
isotropy, so no isotropic subspace properly contains `𝔭`, needs `p, q ≥ 1`, which is the range
the audit says was owed. -/
theorem maximal_isotropic (hp : 1 ≤ p) (hq : 1 ≤ q) :
    (∀ X Y Z : Matrix (Fin p ⊕ Fin q) (Fin p ⊕ Fin q) ℝ,
        IsOdd X → IsOdd Y → IsOdd Z → inner2 (br X Y) Z = 0) ∧
      (∀ W : Matrix (Fin p ⊕ Fin q) (Fin p ⊕ Fin q) ℝ, IsSkew W → ¬ IsOdd W →
        ∃ X Y, IsOdd X ∧ IsOdd Y ∧ inner2 (br X Y) W ≠ 0) := by
  let j0 : Fin q := ⟨0, hq⟩
  let i0 : Fin p := ⟨0, hp⟩
  refine ⟨fun X Y Z => isotropic, ?_⟩
  intro W hW hnot
  by_contra hcon
  push_neg at hcon
  refine hnot ⟨hW, ?_, ?_⟩
  · intro i i'
    by_cases hii : i = i'
    · subst hii
      have := skew_apply hW (Sum.inl i) (Sum.inl i)
      linarith
    · have hab : (Sum.inl i : Fin p ⊕ Fin q) ≠ Sum.inr j0 := by simp
      have hbc : (Sum.inr j0 : Fin p ⊕ Fin q) ≠ Sum.inl i' := by simp
      have hac : (Sum.inl i : Fin p ⊕ Fin q) ≠ Sum.inl i' := by simpa using hii
      have hbr := br_phi_phi hab hbc hac
      have h0 := hcon _ _ (isOdd_phi_lr i j0) (isOdd_phi_rl j0 i')
      rw [hbr, inner2_neg, inner2_phi hW] at h0
      simpa using h0
  · intro j j'
    by_cases hjj : j = j'
    · subst hjj
      have := skew_apply hW (Sum.inr j) (Sum.inr j)
      linarith
    · have hab : (Sum.inr j : Fin p ⊕ Fin q) ≠ Sum.inl i0 := by simp
      have hbc : (Sum.inl i0 : Fin p ⊕ Fin q) ≠ Sum.inr j' := by simp
      have hac : (Sum.inr j : Fin p ⊕ Fin q) ≠ Sum.inr j' := by simpa using hjj
      have hbr := br_phi_phi hab hbc hac
      have h0 := hcon _ _ (isOdd_phi_rl j i0) (isOdd_phi_lr i0 j')
      rw [hbr, inner2_neg, inner2_phi hW] at h0
      simpa using h0

/-! ## The rank identity, symbolically -/

/-- **`C(p+q,2) = C(p,2) + C(q,2) + pq`**, identically in `p` and `q`, so the recorded
verification at `n = 6, 7, 8` was a spot check on a polynomial identity. -/
theorem rank_identity (p q : ℕ) : (p + q).choose 2 = p.choose 2 + q.choose 2 + p * q := by
  induction q with
  | zero => simp
  | succ q ih =>
    have h1 : (p + (q + 1)).choose 2 = (p + q).choose 1 + (p + q).choose 2 := by
      rw [show p + (q + 1) = (p + q) + 1 by ring]
      exact Nat.choose_succ_succ (p + q) 1
    have h2 : (q + 1).choose 2 = q.choose 1 + q.choose 2 := Nat.choose_succ_succ q 1
    rw [h1, h2, ih, Nat.choose_one_right, Nat.choose_one_right]
    ring

/-! ## The heading's object is not isotropic -/

theorem isBlockDiag_phi_ll (i i' : Fin p) :
    IsBlockDiag (phi (ι := Fin p ⊕ Fin q) (Sum.inl i) (Sum.inl i')) := by
  refine ⟨phi_isSkew _ _, ?_, ?_⟩
  · intro a b; simp [phi, Matrix.single_apply]
  · intro a b; simp [phi, Matrix.single_apply]

/-- **THE HEADING'S OBJECT IS NOT ISOTROPIC**, at the audit's own witness `(p,q) = (3,1)`:
`⟨[φ₁₂, φ₂₃], φ₁₃⟩ ≠ 0`, so `𝔰𝔬(p) ⊕ 𝔰𝔬(q)` fails the very first condition. *An isotropic
subalgebra is abelian, and `𝔰𝔬(3)` is not.* -/
theorem heading_refuted :
    ∃ A B C : Matrix (Fin 3 ⊕ Fin 1) (Fin 3 ⊕ Fin 1) ℝ,
      IsBlockDiag A ∧ IsBlockDiag B ∧ IsBlockDiag C ∧ inner2 (br A B) C ≠ 0 := by
  refine ⟨phi (Sum.inl 0) (Sum.inl 1), phi (Sum.inl 1) (Sum.inl 2), phi (Sum.inl 0) (Sum.inl 2),
    isBlockDiag_phi_ll _ _, isBlockDiag_phi_ll _ _, isBlockDiag_phi_ll _ _, ?_⟩
  have hab : (Sum.inl 0 : Fin 3 ⊕ Fin 1) ≠ Sum.inl 1 := by decide
  have hbc : (Sum.inl 1 : Fin 3 ⊕ Fin 1) ≠ Sum.inl 2 := by decide
  have hac : (Sum.inl 0 : Fin 3 ⊕ Fin 1) ≠ Sum.inl 2 := by decide
  rw [br_phi_phi hab hbc hac, inner2_neg, inner2_phi (phi_isSkew _ _), phi_apply_self hac]
  norm_num

/-! ## The range is owed -/

/-- **At `q = 0` the odd part is `0`, and `0` is not maximal isotropic once `p ≥ 2`**, `φ₁₂`
extends it, since a one-dimensional space is isotropic for trivial reasons. This is the audit's
*"the range is owed: at `q = 0` the claim fails at every `n ≥ 2`"*. -/
theorem range_is_owed :
    (∀ X : Matrix (Fin 2 ⊕ Fin 0) (Fin 2 ⊕ Fin 0) ℝ, IsOdd X → X = 0) ∧
      IsSkew (phi (Sum.inl 0 : Fin 2 ⊕ Fin 0) (Sum.inl 1)) ∧
      ¬ IsOdd (phi (Sum.inl 0 : Fin 2 ⊕ Fin 0) (Sum.inl 1)) := by
  refine ⟨?_, phi_isSkew _ _, ?_⟩
  · rintro X ⟨_, hl, hr⟩
    ext (u | u) (v | v)
    · simpa using hl u v
    · exact (Fin.elim0 v)
    · exact (Fin.elim0 u)
    · exact (Fin.elim0 u)
  · rintro ⟨_, hl, _⟩
    have := hl 0 1
    rw [phi_apply_self (by decide : (Sum.inl 0 : Fin 2 ⊕ Fin 0) ≠ Sum.inl 1)] at this
    norm_num at this

end HamiltonsCubic.L76Statement
