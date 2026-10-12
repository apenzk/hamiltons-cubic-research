import HamiltonsCubic.Base.Bivectors
import HamiltonsCubic.Base.Curvature

/-!
# B2, the padding map between dimensions

Padding a bivector from `ℝᵐ` into `ℝᵐ ⊕ ℝᵏ` is the block matrix
`[[X, 0], [0, 0]]`, and the two claims the record leans on are that it preserves
the **inner2** and the **bracket**.

**Why it is a `B` row.** [L30](../Results/L30.lean)'s descent, [L44](../Results/L44.lean)'s
carry of `θ(W_{ℂP²})` off `n = 4`, and the witnesses of
[L34](../Results/L34.lean) all need a map between two dimensions.
[L30](../Results/L30.lean) could only state the subalgebra fact inside one
dimension, where *"the same norm"* is definitional rather than content. Here it
is content.

**Bound**: padding into a direct summand, which is every coordinate subspace up
to a permutation of the frame. A general injection is not built.
-/

namespace HamiltonsCubic.Base

open Matrix

variable {m k : Type*} [Fintype m] [DecidableEq m] [Fintype k] [DecidableEq k]

-- `inner2` from [Bivectors.lean](Bivectors.lean) is already generic in the index
-- type, so no second inner2 is defined here.

/-- Padding by zero into a direct summand. -/
def pad (X : Matrix m m ℚ) : Matrix (m ⊕ k) (m ⊕ k) ℚ := Matrix.fromBlocks X 0 0 0

@[simp] theorem pad_transpose (X : Matrix m m ℚ) : (pad (k := k) X)ᵀ = pad Xᵀ := by
  unfold pad
  rw [Matrix.fromBlocks_transpose]
  simp

/-- **Padding is multiplicative**, which is the whole of the block structure. -/
@[simp] theorem pad_mul (X Y : Matrix m m ℚ) :
    pad (k := k) X * pad (k := k) Y = pad (X * Y) := by
  unfold pad
  rw [Matrix.fromBlocks_multiply]
  simp

theorem trace_pad (X : Matrix m m ℚ) : (pad (k := k) X).trace = X.trace := by
  unfold pad Matrix.trace
  rw [Fintype.sum_sum_type]
  simp [Matrix.fromBlocks]

/-- **Padding preserves the inner2**, the *same norm* half of L30's clause,
here as content rather than as a definitional identity. -/
theorem pairing_pad (X Y : Matrix m m ℚ) :
    inner2 (pad (k := k) X) (pad (k := k) Y) = inner2 X Y := by
  unfold inner2
  rw [pad_transpose, pad_mul, trace_pad]

/-- **Padding preserves the bracket**, so `W#` stays inside, which is the `θ`
half of the same clause. -/
theorem pad_br (X Y : Matrix m m ℚ) :
    pad (k := k) X * pad (k := k) Y - pad (k := k) Y * pad (k := k) X
      = pad (X * Y - Y * X) := by
  rw [pad_mul, pad_mul]
  unfold pad
  ext i j
  cases i <;> cases j <;> simp [Matrix.fromBlocks]

/-- Padding is additive, so it carries `𝒲` linearly. -/
theorem pad_add (X Y : Matrix m m ℚ) :
    pad (k := k) (X + Y) = pad (k := k) X + pad (k := k) Y := by
  unfold pad
  ext i j
  cases i <;> cases j <;> simp [Matrix.fromBlocks]

/-! ## B3, padding at the operator level

A curvature operator is a map on bivectors, so padding it means padding its
input and output. The bridge that makes the `Λ²` structure transfer is that
padding takes a basis bivector to a basis bivector of the summand.
-/

/-- **The bridge.** Padding a basis bivector gives the basis bivector on the
summand, so the `Λ²` structure transfers rather than needing to be rebuilt. -/
theorem pad_phi (i j : m) : pad (k := k) (phi i j) = phi (Sum.inl i) (Sum.inl j) := by
  unfold pad phi
  ext a b
  cases a <;> cases b <;>
    simp [Matrix.fromBlocks, Matrix.single_apply, Sum.inl.injEq]

/-- Padding an operator: restrict, apply, pad back. -/
def padOp (R : Matrix m m ℚ → Matrix m m ℚ) :
    Matrix (m ⊕ k) (m ⊕ k) ℚ → Matrix (m ⊕ k) (m ⊕ k) ℚ :=
  fun X => pad (R X.toBlocks₁₁)

/-- **The padded operator agrees with the original on padded input**, which is
what makes it an extension rather than a new object. -/
@[simp] theorem padOp_pad (R : Matrix m m ℚ → Matrix m m ℚ) (X : Matrix m m ℚ) :
    padOp (k := k) R (pad X) = pad (R X) := by
  unfold padOp pad
  rw [Matrix.toBlocks_fromBlocks₁₁]

/-- And padding an operator is additive in the operator, so a sum of padded
operators is the padding of the sum on each summand, the linearity L34's
construction uses. -/
theorem padOp_add (R S : Matrix m m ℚ → Matrix m m ℚ) (X : Matrix (m ⊕ k) (m ⊕ k) ℚ) :
    padOp (k := k) (fun Y => R Y + S Y) X = padOp (k := k) R X + padOp (k := k) S X := by
  unfold padOp
  rw [pad_add]

/-- **The projection lemma.** Pairing a padded matrix against anything sees only
the `(1,1)` block, which is what makes all three Weyl conditions transfer
through `padOp`. -/
theorem pairing_pad_left (A : Matrix m m ℚ) (Y : Matrix (m ⊕ k) (m ⊕ k) ℚ) :
    inner2 (pad (k := k) A) Y = inner2 A Y.toBlocks₁₁ := by
  unfold inner2 pad
  rw [← Matrix.fromBlocks_toBlocks Y, Matrix.fromBlocks_transpose]
  simp only [Matrix.transpose_zero, Matrix.fromBlocks_multiply, Matrix.zero_mul,
    Matrix.mul_zero, add_zero, zero_add, Matrix.toBlocks_fromBlocks₁₁]
  rw [Matrix.trace]
  rw [Fintype.sum_sum_type]
  simp [Matrix.fromBlocks, Matrix.trace, Matrix.diag]

/-- **The projection lemma on the right slot.** -/
theorem pairing_pad_right (X : Matrix (m ⊕ k) (m ⊕ k) ℚ) (B : Matrix m m ℚ) :
    inner2 X (pad (k := k) B) = inner2 X.toBlocks₁₁ B := by
  unfold inner2 pad
  rw [← Matrix.fromBlocks_toBlocks X, Matrix.fromBlocks_transpose]
  simp only [Matrix.fromBlocks_multiply, Matrix.mul_zero, Matrix.zero_mul,
    add_zero, zero_add, Matrix.toBlocks_fromBlocks₁₁]
  rw [Matrix.trace, Fintype.sum_sum_type]
  simp [Matrix.fromBlocks, Matrix.trace, Matrix.diag]

/-- A skew matrix's diagonal block is skew, so the restriction lands where the
symmetry hypothesis can be used. -/
theorem toBlocks₁₁_isSkew {X : Matrix (m ⊕ k) (m ⊕ k) ℚ} (hX : IsSkew X) :
    IsSkew X.toBlocks₁₁ := by
  unfold IsSkew Matrix.toBlocks₁₁ at *
  ext i j
  have := congrFun (congrFun hX (Sum.inl i)) (Sum.inl j)
  simpa using this

/-- **Symmetry transfers through padding.** With both projection lemmas, an
operator self-adjoint on bivectors stays self-adjoint after padding, the last
clause `IsWeylOf` needs to survive `padOp`. -/
theorem padOp_symm (R : Matrix m m ℚ → Matrix m m ℚ)
    (hR : ∀ A B, IsSkew A → IsSkew B → inner2 (R A) B = inner2 A (R B))
    {X Y : Matrix (m ⊕ k) (m ⊕ k) ℚ} (hX : IsSkew X) (hY : IsSkew Y) :
    inner2 (padOp (k := k) R X) Y = inner2 X (padOp (k := k) R Y) := by
  unfold padOp
  rw [pairing_pad_left, pairing_pad_right,
    hR _ _ (toBlocks₁₁_isSkew hX) (toBlocks₁₁_isSkew hY)]

/-! ## The Weyl conditions through `padOp`

Every clause reduces the same way: by the left projection lemma each term is a
pairing of restrictions, and a basis bivector restricts to a basis bivector when
both its indices lie in the summand and to `0` otherwise.
-/

/-- A basis bivector restricts to a basis bivector, or to nothing. -/
theorem toBlocks_phi_inl (a c : m) :
    (phi (Sum.inl a) (Sum.inl c) : Matrix (m ⊕ k) (m ⊕ k) ℚ).toBlocks₁₁ = phi a c := by
  rw [← pad_phi]
  unfold pad
  rw [Matrix.toBlocks_fromBlocks₁₁]

theorem toBlocks_phi_inr (a : m) (c : k) :
    (phi (Sum.inr c) (Sum.inl a) : Matrix (m ⊕ k) (m ⊕ k) ℚ).toBlocks₁₁ = 0 := by
  unfold phi Matrix.toBlocks₁₁
  ext i j
  simp [Matrix.single_apply]

theorem toBlocks_phi_inr_inr (c d : k) :
    (phi (Sum.inr c) (Sum.inr d) : Matrix (m ⊕ k) (m ⊕ k) ℚ).toBlocks₁₁ = 0 := by
  unfold phi Matrix.toBlocks₁₁
  ext i j
  simp [Matrix.single_apply]

/-- **Every `padOp` term is a pairing of restrictions.** -/
theorem inner2_padOp (R : Matrix m m ℚ → Matrix m m ℚ)
    (X Y : Matrix (m ⊕ k) (m ⊕ k) ℚ) :
    inner2 (padOp (k := k) R X) Y = inner2 (R X.toBlocks₁₁) Y.toBlocks₁₁ := by
  unfold padOp
  rw [pairing_pad_left]

@[simp] theorem inner2_zero_right {ι : Type*} [Fintype ι] (X : Matrix ι ι ℚ) :
    inner2 X 0 = 0 := by simp [inner2]

@[simp] theorem inner2_zero_left {ι : Type*} [Fintype ι] (Y : Matrix ι ι ℚ) :
    inner2 (0 : Matrix ι ι ℚ) Y = 0 := by simp [inner2]

theorem toBlocks_phi_inl_inr (a : m) (c : k) :
    (phi (Sum.inl a) (Sum.inr c) : Matrix (m ⊕ k) (m ⊕ k) ℚ).toBlocks₁₁ = 0 := by
  unfold phi Matrix.toBlocks₁₁
  ext i j
  simp [Matrix.single_apply]

/-- **Ricci-flatness survives padding.** The `inl` terms reproduce `RicOf R`; the
`inr` terms die because one of the two restrictions is `0`. -/
theorem RicOf_padOp (R : Matrix m m ℚ → Matrix m m ℚ) (hR0 : R 0 = 0)
    (hRic : ∀ a b, RicOf R a b = 0) (a b : m ⊕ k) :
    RicOf (padOp (k := k) R) a b = 0 := by
  unfold RicOf
  rw [Fintype.sum_sum_type]
  have hz : ∀ (u v : m ⊕ k), (phi v u : Matrix (m ⊕ k) (m ⊕ k) ℚ).toBlocks₁₁ = 0 →
      inner2 (padOp (k := k) R (phi u v)) (phi v u) = 0 := by
    intro u v h
    rw [inner2_padOp, h, inner2_zero_right]
  cases a with
  | inl a' =>
    cases b with
    | inl b' =>
      have h2 : ∀ c : k, inner2 (padOp (k := k) R (phi (Sum.inl a') (Sum.inr c)))
          (phi (Sum.inl b') (Sum.inr c)) = 0 := by
        intro c
        simp only [inner2_padOp, toBlocks_phi_inl_inr, inner2_zero_right]
      have h1 : ∀ c : m, inner2 (padOp (k := k) R (phi (Sum.inl a') (Sum.inl c)))
          (phi (Sum.inl b') (Sum.inl c)) = inner2 (R (phi a' c)) (phi b' c) := by
        intro c
        simp only [inner2_padOp, toBlocks_phi_inl]
      rw [Finset.sum_congr rfl fun c _ => h1 c, Finset.sum_congr rfl fun c _ => h2 c,
        Finset.sum_const_zero, add_zero]
      exact hRic a' b'
    | inr b'' =>
      have hall : ∀ (c : m ⊕ k), inner2 (padOp (k := k) R (phi (Sum.inl a') c))
          (phi (Sum.inr b'') c) = 0 := by
        intro c
        cases c with
        | inl c' => simp only [inner2_padOp, toBlocks_phi_inr, inner2_zero_right]
        | inr c'' => simp only [inner2_padOp, toBlocks_phi_inr_inr, inner2_zero_right]
      rw [Finset.sum_congr rfl fun c _ => hall (Sum.inl c),
        Finset.sum_congr rfl fun c _ => hall (Sum.inr c)]
      simp
  | inr a'' =>
    have hall : ∀ (c : m ⊕ k), inner2 (padOp (k := k) R (phi (Sum.inr a'') c))
        (phi b c) = 0 := by
      intro c
      cases c with
      | inl c' => simp only [inner2_padOp, toBlocks_phi_inr, hR0, inner2_zero_left]
      | inr c'' => simp only [inner2_padOp, toBlocks_phi_inr_inr, hR0, inner2_zero_left]
    rw [Finset.sum_congr rfl fun c _ => hall (Sum.inl c),
      Finset.sum_congr rfl fun c _ => hall (Sum.inr c)]
    simp

/-- **First Bianchi survives padding.** Sixteen cases over the four indices: all
`inl` reproduces `bianchiOf R`, and any `inr` index kills each of the three
terms through one restriction or the other. -/
theorem bianchiOf_padOp (R : Matrix m m ℚ → Matrix m m ℚ) (hR0 : R 0 = 0)
    (hB : ∀ a b c d, bianchiOf R a b c d = 0) (i j p q : m ⊕ k) :
    bianchiOf (padOp (k := k) R) i j p q = 0 := by
  unfold bianchiOf
  simp only [inner2_padOp]
  cases i <;> cases j <;> cases p <;> cases q <;>
    simp only [toBlocks_phi_inl, toBlocks_phi_inl_inr, toBlocks_phi_inr,
      toBlocks_phi_inr_inr, hR0, inner2_zero_left, inner2_zero_right,
      add_zero, zero_add] <;>
    first
      | rfl
      | exact hB _ _ _ _

/-- **So `𝒲` survives padding**, every clause. -/
theorem IsWeylOf_padOp (R : Matrix m m ℚ → Matrix m m ℚ) (hR0 : R 0 = 0)
    (hR : IsWeylOf R) : IsWeylOf (padOp (k := k) R) := by
  obtain ⟨hs, hb, hr⟩ := hR
  exact ⟨fun X Y hX hY => padOp_symm R hs hX hY,
    bianchiOf_padOp R hR0 hb, RicOf_padOp R hR0 hr⟩

/-! ## The second summand

L34 pads onto **two** planes. At `m = 8` with orthogonal planes those are the two
summands, so the second padding is the mirror of the first.
-/

/-- Padding into the second summand. -/
def pad₂ (Y : Matrix k k ℚ) : Matrix (m ⊕ k) (m ⊕ k) ℚ := Matrix.fromBlocks 0 0 0 Y

def padOp₂ (S : Matrix k k ℚ → Matrix k k ℚ) :
    Matrix (m ⊕ k) (m ⊕ k) ℚ → Matrix (m ⊕ k) (m ⊕ k) ℚ :=
  fun X => pad₂ (S X.toBlocks₂₂)

theorem pad₂_phi (c d : k) : pad₂ (m := m) (phi c d) = phi (Sum.inr c) (Sum.inr d) := by
  unfold pad₂ phi
  ext a b
  cases a <;> cases b <;> simp [Matrix.fromBlocks, Matrix.single_apply, Sum.inr.injEq]

theorem toBlocks₂₂_phi_inr (c d : k) :
    (phi (Sum.inr c) (Sum.inr d) : Matrix (m ⊕ k) (m ⊕ k) ℚ).toBlocks₂₂ = phi c d := by
  rw [← pad₂_phi]
  unfold pad₂
  rw [Matrix.toBlocks_fromBlocks₂₂]

theorem toBlocks₂₂_phi_inl (a b : m) :
    (phi (Sum.inl a) (Sum.inl b) : Matrix (m ⊕ k) (m ⊕ k) ℚ).toBlocks₂₂ = 0 := by
  unfold phi Matrix.toBlocks₂₂; ext i j; simp [Matrix.single_apply]

theorem toBlocks₂₂_phi_inl_inr (a : m) (c : k) :
    (phi (Sum.inl a) (Sum.inr c) : Matrix (m ⊕ k) (m ⊕ k) ℚ).toBlocks₂₂ = 0 := by
  unfold phi Matrix.toBlocks₂₂; ext i j; simp [Matrix.single_apply]

theorem toBlocks₂₂_phi_inr_inl (a : m) (c : k) :
    (phi (Sum.inr c) (Sum.inl a) : Matrix (m ⊕ k) (m ⊕ k) ℚ).toBlocks₂₂ = 0 := by
  unfold phi Matrix.toBlocks₂₂; ext i j; simp [Matrix.single_apply]

theorem inner2_pad₂_left (B : Matrix k k ℚ) (Y : Matrix (m ⊕ k) (m ⊕ k) ℚ) :
    inner2 (pad₂ (m := m) B) Y = inner2 B Y.toBlocks₂₂ := by
  unfold inner2 pad₂
  rw [← Matrix.fromBlocks_toBlocks Y, Matrix.fromBlocks_transpose]
  simp only [Matrix.transpose_zero, Matrix.fromBlocks_multiply, Matrix.zero_mul,
    Matrix.mul_zero, add_zero, zero_add, Matrix.toBlocks_fromBlocks₂₂]
  rw [Matrix.trace, Fintype.sum_sum_type]
  simp [Matrix.fromBlocks, Matrix.trace, Matrix.diag]

theorem inner2_padOp₂ (S : Matrix k k ℚ → Matrix k k ℚ)
    (X Y : Matrix (m ⊕ k) (m ⊕ k) ℚ) :
    inner2 (padOp₂ (m := m) S X) Y = inner2 (S X.toBlocks₂₂) Y.toBlocks₂₂ := by
  unfold padOp₂; rw [inner2_pad₂_left]

theorem bianchiOf_padOp₂ (S : Matrix k k ℚ → Matrix k k ℚ) (hS0 : S 0 = 0)
    (hB : ∀ a b c d, bianchiOf S a b c d = 0) (i j p q : m ⊕ k) :
    bianchiOf (padOp₂ (m := m) S) i j p q = 0 := by
  unfold bianchiOf
  simp only [inner2_padOp₂]
  cases i <;> cases j <;> cases p <;> cases q <;>
    simp only [toBlocks₂₂_phi_inr, toBlocks₂₂_phi_inl, toBlocks₂₂_phi_inl_inr,
      toBlocks₂₂_phi_inr_inl, hS0, inner2_zero_left, inner2_zero_right,
      add_zero, zero_add] <;>
    first
      | rfl
      | exact hB _ _ _ _

theorem RicOf_padOp₂ (S : Matrix k k ℚ → Matrix k k ℚ) (hS0 : S 0 = 0)
    (hRic : ∀ a b, RicOf S a b = 0) (a b : m ⊕ k) :
    RicOf (padOp₂ (m := m) S) a b = 0 := by
  unfold RicOf
  rw [Fintype.sum_sum_type]
  cases a <;> cases b <;>
    simp only [inner2_padOp₂, toBlocks₂₂_phi_inr, toBlocks₂₂_phi_inl,
      toBlocks₂₂_phi_inl_inr, toBlocks₂₂_phi_inr_inl, hS0, inner2_zero_left,
      inner2_zero_right, Finset.sum_const_zero, add_zero, zero_add] <;>
    first
      | rfl
      | exact hRic _ _

end HamiltonsCubic.Base
