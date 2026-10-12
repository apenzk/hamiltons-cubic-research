import Mathlib
import HamiltonsCubic.Results.RootSlots
import HamiltonsCubic.Results.WeylTraceSchur
import HamiltonsCubic.Results.KyFanPackaging

/-!
# L240, piece (b): the slot basis of `-ad_X²` for a general normal form

[SevenFrameGap.lean](SevenFrameGap.lean)'s `seven_frame_lemma` carries one `sorry`, split on
2026-09-25 into five pieces ([lean/INDEX.md](../../INDEX.md), row L240). This file builds
piece (b): for `X = ∑ₐ sₐ φ_{pₐ qₐ}` in normal form, the slot bivectors are eigenvectors of
`-ad_X²`. *Orthogonality of the slot types is here for basis bivectors and pair combinations (steps 5 to 7);
the family `slotφ` itself is orthonormal (`slot_orthonormal`, step 9d), and completeness, which
`kyFan_eigen` needs, is `slot_complete`, through `transfer_expansion`. **`slot_kyFan` is piece (b), done.***
[RootSlots.lean](RootSlots.lean) proves the eigen relations for two blocks; the passage to many
blocks rests on the lemma below, that basis bivectors on disjoint indices commute.

**Step 1**: `br_phi_disjoint`. **Step 2**: the Jacobi identity and `slot_plus_general`, the
"plus" slot's eigen relation at a general normal form. **Step 3**: `block_disj`, `reduce_two`
and the other five slots of a block pair (`slot_null_general` needs a second block, `k ≥ 2`; `cartan_null` in step 9c covers every `k`).
**Step 4**: the kernel slots `φ_{p_a w}` and `φ_{q_a w}` at an index outside every block.
**Step 5**: the four slot vectors of a block pair have Gram matrix `2·I`.
**Step 6**: slot vectors of different block pairs are orthogonal.
**Step 7**: the Cartan, kernel and free-free slots are orthogonal to every other slot.
**Step 8a**: each cross-block basis bivector is a combination of its pair's four slots.
**Step 8b**: an orthonormal family inside a set that any family on the same index set expands,
expands it too (`transfer_expansion`), so completeness needs no dimension count.
**Step 9a**: every index is exactly one of: the `p`-side of a block, the `q`-side of a block,
or free (`classify`).
**Step 9b**: the block of an index as a function (`blockOf`) with its specification.
**Step 9c**: the slot family on the ordered pairs `i < j` and its eigenvalues (`slotφ`, `slotμ`),
with `cartan_null` (the Cartan slot is null at every `k`) and the orientation helper
`negAd_phi_swap`, and the eigen relation `slot_eigen`.
**Step 9d**: orthonormality of `slotφ`, by cases on `IsCross`: (A) two non-cross slots
(`slot_orth_nn`), (B) a non-cross slot against a cross one (`slot_orth_nc`), (C) two cross slots through
`pairSlot_orth_same` and `pairSlot_orth_diff`, assembled in `slot_orth_cc`; **`slot_orthonormal`: the
family `slotφ` is orthonormal.**
-/

open HamiltonsCubic.RealLayer Matrix

namespace HamiltonsCubic.L240SlotBasis

set_option linter.unusedSectionVars false

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Basis bivectors on disjoint index pairs commute.** -/
theorem br_phi_disjoint {a b c d : ι} (hac : a ≠ c) (had : a ≠ d) (hbc : b ≠ c) (hbd : b ≠ d) :
    br (phi a b) (phi c d) = 0 := by
  ext u v
  simp [br, phi, sub_mul, mul_sub, hac, had, hbc, hbd, hac.symm, had.symm, hbc.symm, hbd.symm]

/-- **Jacobi**, in derivation form. -/
theorem br_jacobi (A B C : Matrix ι ι ℝ) : br A (br B C) = br (br A B) C + br B (br A C) := by
  simp only [br, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_assoc]; abel

theorem br_sum_left {k : ℕ} (f : Fin k → Matrix ι ι ℝ) (Z : Matrix ι ι ℝ) :
    br (∑ c, f c) Z = ∑ c, br (f c) Z := by
  simp only [br, Finset.sum_mul, Finset.mul_sum, Finset.sum_sub_distrib]

/-- **A normal form**: `2k` distinct indices `p c, q c` and weights `s c`. -/
structure NormalForm (ι : Type*) (k : ℕ) where
  p : Fin k → ι
  q : Fin k → ι
  s : Fin k → ℝ
  hp : Function.Injective p
  hq : Function.Injective q
  hpq : ∀ a b, p a ≠ q b

/-- The skew matrix a normal form describes, `X = ∑_c s_c φ_{p_c q_c}`. -/
noncomputable def NormalForm.X {k : ℕ} (N : NormalForm ι k) : Matrix ι ι ℝ :=
  ∑ c, N.s c • phi (N.p c) (N.q c)

/-- **Only two blocks see a matrix the other blocks commute with.** -/
theorem br_X_two {k : ℕ} (N : NormalForm ι k) {a b : Fin k} (hab : a ≠ b) (Z : Matrix ι ι ℝ)
    (hZ : ∀ c, c ≠ a → c ≠ b → br (phi (N.p c) (N.q c)) Z = 0) :
    br N.X Z = br (N.s a • phi (N.p a) (N.q a) + N.s b • phi (N.p b) (N.q b)) Z := by
  rw [NormalForm.X, br_sum_left, RootSlots.brL_add, RootSlots.brL_smul, RootSlots.brL_smul]
  simp only [RootSlots.brL_smul]
  rw [Finset.sum_eq_add a b hab]
  · intro c _ hc; rw [hZ c hc.1 hc.2, smul_zero]
  · intro h; exact absurd (Finset.mem_univ a) h
  · intro h; exact absurd (Finset.mem_univ b) h

/-- **The plus slot at a general normal form**: `φ_{p_a p_b} − φ_{q_a q_b}` has eigenvalue
`(s_a + s_b)²` under `-ad_X²`. -/
theorem slot_plus_general {k : ℕ} (N : NormalForm ι k) {a b : Fin k} (hab : a ≠ b) :
    -br N.X (br N.X (phi (N.p a) (N.p b) - phi (N.q a) (N.q b))) =
      (N.s a + N.s b) ^ 2 • (phi (N.p a) (N.p b) - phi (N.q a) (N.q b)) := by
  have hpa := N.hp.ne hab; have hqa := N.hq.ne hab
  set Y := phi (N.p a) (N.p b) - phi (N.q a) (N.q b) with hY
  set Xab := N.s a • phi (N.p a) (N.q a) + N.s b • phi (N.p b) (N.q b) with hXab
  -- every other block is disjoint from the four indices of blocks a, b
  have disj : ∀ c, c ≠ a → c ≠ b → ∀ i j, (i = N.p a ∨ i = N.q a ∨ i = N.p b ∨ i = N.q b) →
      (j = N.p a ∨ j = N.q a ∨ j = N.p b ∨ j = N.q b) →
      br (phi (N.p c) (N.q c)) (phi i j) = 0 := by
    intro c hca hcb i j hi hj
    have h1 : ∀ x, (x = N.p a ∨ x = N.q a ∨ x = N.p b ∨ x = N.q b) → N.p c ≠ x := by
      rintro x (rfl | rfl | rfl | rfl)
      · exact N.hp.ne hca
      · exact N.hpq c a
      · exact N.hp.ne hcb
      · exact N.hpq c b
    have h2 : ∀ x, (x = N.p a ∨ x = N.q a ∨ x = N.p b ∨ x = N.q b) → N.q c ≠ x := by
      rintro x (rfl | rfl | rfl | rfl)
      · exact fun h => N.hpq a c h.symm
      · exact N.hq.ne hca
      · exact fun h => N.hpq b c h.symm
      · exact N.hq.ne hcb
    exact br_phi_disjoint (h1 i hi) (h1 j hj) (h2 i hi) (h2 j hj)
  have hcY : ∀ c, c ≠ a → c ≠ b → br (phi (N.p c) (N.q c)) Y = 0 := by
    intro c hca hcb
    rw [hY, RootSlots.brR_sub, disj c hca hcb _ _ (Or.inl rfl) (Or.inr (Or.inr (Or.inl rfl))),
      disj c hca hcb _ _ (Or.inr (Or.inl rfl)) (Or.inr (Or.inr (Or.inr rfl))), sub_zero]
  have hcX : ∀ c, c ≠ a → c ≠ b → br (phi (N.p c) (N.q c)) Xab = 0 := by
    intro c hca hcb
    rw [hXab, RootSlots.brR_add, RootSlots.brR_smul, RootSlots.brR_smul,
      disj c hca hcb _ _ (Or.inl rfl) (Or.inr (Or.inl rfl)),
      disj c hca hcb _ _ (Or.inr (Or.inr (Or.inl rfl))) (Or.inr (Or.inr (Or.inr rfl))),
      smul_zero, smul_zero, add_zero]
  have hcXY : ∀ c, c ≠ a → c ≠ b → br (phi (N.p c) (N.q c)) (br Xab Y) = 0 := by
    intro c hca hcb
    rw [br_jacobi, hcX c hca hcb, hcY c hca hcb]
    simp [br]
  rw [br_X_two N hab Y hcY, br_X_two N hab _ hcXY]
  exact RootSlots.slot_plus (N.hpq a a) hpa (N.hpq a b) (fun h => N.hpq b a h.symm) hqa
    (N.hpq b b) (N.s a) (N.s b)

/-- The four indices of blocks `a` and `b`. -/
def NormalForm.four {k : ℕ} (N : NormalForm ι k) (a b : Fin k) (i : ι) : Prop :=
  i = N.p a ∨ i = N.q a ∨ i = N.p b ∨ i = N.q b

/-- **Every other block is disjoint from blocks `a`, `b`.** -/
theorem block_disj {k : ℕ} (N : NormalForm ι k) {a b c : Fin k} (hca : c ≠ a) (hcb : c ≠ b)
    {i j : ι} (hi : N.four a b i) (hj : N.four a b j) : br (phi (N.p c) (N.q c)) (phi i j) = 0 := by
  have h1 : ∀ x, N.four a b x → N.p c ≠ x := by
    rintro x (rfl | rfl | rfl | rfl)
    · exact N.hp.ne hca
    · exact N.hpq c a
    · exact N.hp.ne hcb
    · exact N.hpq c b
  have h2 : ∀ x, N.four a b x → N.q c ≠ x := by
    rintro x (rfl | rfl | rfl | rfl)
    · exact fun h => N.hpq a c h.symm
    · exact N.hq.ne hca
    · exact fun h => N.hpq b c h.symm
    · exact N.hq.ne hcb
  exact br_phi_disjoint (h1 i hi) (h1 j hj) (h2 i hi) (h2 j hj)

/-- **`-ad_X²` acts through blocks `a`, `b` alone on anything the other blocks commute with.** -/
theorem reduce_two {k : ℕ} (N : NormalForm ι k) {a b : Fin k} (hab : a ≠ b) (Y : Matrix ι ι ℝ)
    (hcY : ∀ c, c ≠ a → c ≠ b → br (phi (N.p c) (N.q c)) Y = 0) :
    -br N.X (br N.X Y) =
      -br (N.s a • phi (N.p a) (N.q a) + N.s b • phi (N.p b) (N.q b))
        (br (N.s a • phi (N.p a) (N.q a) + N.s b • phi (N.p b) (N.q b)) Y) := by
  set Xab := N.s a • phi (N.p a) (N.q a) + N.s b • phi (N.p b) (N.q b) with hXab
  have hcX : ∀ c, c ≠ a → c ≠ b → br (phi (N.p c) (N.q c)) Xab = 0 := by
    intro c hca hcb
    rw [hXab, RootSlots.brR_add, RootSlots.brR_smul, RootSlots.brR_smul,
      block_disj N hca hcb (Or.inl rfl) (Or.inr (Or.inl rfl)),
      block_disj N hca hcb (Or.inr (Or.inr (Or.inl rfl))) (Or.inr (Or.inr (Or.inr rfl))),
      smul_zero, smul_zero, add_zero]
  have hcXY : ∀ c, c ≠ a → c ≠ b → br (phi (N.p c) (N.q c)) (br Xab Y) = 0 := by
    intro c hca hcb
    rw [br_jacobi, hcX c hca hcb, hcY c hca hcb]
    simp [br]
  rw [br_X_two N hab Y hcY, br_X_two N hab _ hcXY]

/-- Two basis bivectors on the four indices: the other blocks commute with their difference and sum. -/
theorem hc_pair {k : ℕ} (N : NormalForm ι k) {a b : Fin k} {i j i' j' : ι}
    (hi : N.four a b i) (hj : N.four a b j) (hi' : N.four a b i') (hj' : N.four a b j') (ε : ℝ) :
    ∀ c, c ≠ a → c ≠ b → br (phi (N.p c) (N.q c)) (phi i j + ε • phi i' j') = 0 := by
  intro c hca hcb
  rw [RootSlots.brR_add, RootSlots.brR_smul, block_disj N hca hcb hi hj,
    block_disj N hca hcb hi' hj', smul_zero, add_zero]

section slots
variable {k : ℕ} (N : NormalForm ι k) {a b : Fin k} (hab : a ≠ b)
include hab

private theorem ne_facts : N.p a ≠ N.q a ∧ N.p a ≠ N.p b ∧ N.p a ≠ N.q b ∧ N.q a ≠ N.p b ∧
    N.q a ≠ N.q b ∧ N.p b ≠ N.q b :=
  ⟨N.hpq a a, N.hp.ne hab, N.hpq a b, fun h => N.hpq b a h.symm, N.hq.ne hab, N.hpq b b⟩

/-- **The second plus slot**, `φ_{p_a q_b} + φ_{q_a p_b}`, eigenvalue `(s_a + s_b)²`. -/
theorem slot_plus2_general :
    -br N.X (br N.X (phi (N.p a) (N.q b) + phi (N.q a) (N.p b))) =
      (N.s a + N.s b) ^ 2 • (phi (N.p a) (N.q b) + phi (N.q a) (N.p b)) := by
  obtain ⟨h1, h2, h3, h4, h5, h6⟩ := ne_facts N hab
  have hc := hc_pair N (a := a) (b := b) (Or.inl rfl) (Or.inr (Or.inr (Or.inr rfl)))
    (Or.inr (Or.inl rfl)) (Or.inr (Or.inr (Or.inl rfl))) 1
  simp only [one_smul] at hc
  rw [reduce_two N hab _ hc]
  exact RootSlots.slot_plus2 h1 h2 h3 h4 h5 h6 (N.s a) (N.s b)

/-- **The minus slot**, `φ_{p_a p_b} + φ_{q_a q_b}`, eigenvalue `(s_a − s_b)²`. -/
theorem slot_minus_general :
    -br N.X (br N.X (phi (N.p a) (N.p b) + phi (N.q a) (N.q b))) =
      (N.s a - N.s b) ^ 2 • (phi (N.p a) (N.p b) + phi (N.q a) (N.q b)) := by
  obtain ⟨h1, h2, h3, h4, h5, h6⟩ := ne_facts N hab
  have hc := hc_pair N (a := a) (b := b) (Or.inl rfl) (Or.inr (Or.inr (Or.inl rfl)))
    (Or.inr (Or.inl rfl)) (Or.inr (Or.inr (Or.inr rfl))) 1
  simp only [one_smul] at hc
  rw [reduce_two N hab _ hc]
  exact RootSlots.slot_minus h1 h2 h3 h4 h5 h6 (N.s a) (N.s b)

/-- **The second minus slot**, `φ_{p_a q_b} − φ_{q_a p_b}`, eigenvalue `(s_a − s_b)²`. -/
theorem slot_minus2_general :
    -br N.X (br N.X (phi (N.p a) (N.q b) - phi (N.q a) (N.p b))) =
      (N.s a - N.s b) ^ 2 • (phi (N.p a) (N.q b) - phi (N.q a) (N.p b)) := by
  obtain ⟨h1, h2, h3, h4, h5, h6⟩ := ne_facts N hab
  have hc := hc_pair N (a := a) (b := b) (Or.inl rfl) (Or.inr (Or.inr (Or.inr rfl)))
    (Or.inr (Or.inl rfl)) (Or.inr (Or.inr (Or.inl rfl))) (-1)
  simp only [neg_one_smul, ← sub_eq_add_neg] at hc
  rw [reduce_two N hab _ hc]
  exact RootSlots.slot_minus2 h1 h2 h3 h4 h5 h6 (N.s a) (N.s b)

/-- **The Cartan slot** `φ_{p_a q_a}` is null. -/
theorem slot_null_general :
    -br N.X (br N.X (phi (N.p a) (N.q a))) = (0 : ℝ) • phi (N.p a) (N.q a) := by
  obtain ⟨h1, h2, h3, h4, h5, h6⟩ := ne_facts N hab
  have hc := hc_pair N (a := a) (b := b) (Or.inl rfl) (Or.inr (Or.inl rfl))
    (Or.inl rfl) (Or.inr (Or.inl rfl)) 0
  simp only [zero_smul, add_zero] at hc
  rw [reduce_two N hab _ hc]
  exact RootSlots.slot_null1 h1 h2 h3 h4 h5 h6 (N.s a) (N.s b)

end slots

/-- An index outside every block. -/
def NormalForm.Free {k : ℕ} (N : NormalForm ι k) (w : ι) : Prop := ∀ c, N.p c ≠ w ∧ N.q c ≠ w

/-- **Only block `a` sees a matrix every other block commutes with.** -/
theorem br_X_one {k : ℕ} (N : NormalForm ι k) (a : Fin k) (Z : Matrix ι ι ℝ)
    (hZ : ∀ c, c ≠ a → br (phi (N.p c) (N.q c)) Z = 0) :
    br N.X Z = br (N.s a • phi (N.p a) (N.q a)) Z := by
  rw [NormalForm.X, br_sum_left, RootSlots.brL_smul]
  simp only [RootSlots.brL_smul]
  rw [Finset.sum_eq_single a]
  · intro c _ hc; rw [hZ c hc, smul_zero]
  · intro h; exact absurd (Finset.mem_univ a) h

/-- **The kernel slot** `φ_{p_a w}`, `w` free, has eigenvalue `s_a²`. -/
theorem slot_kernel_general {k : ℕ} (N : NormalForm ι k) (a : Fin k) {w : ι} (hw : N.Free w) :
    -br N.X (br N.X (phi (N.p a) w)) = N.s a ^ 2 • phi (N.p a) w := by
  have hpq := N.hpq a a
  have hpw := (hw a).1; have hqw := (hw a).2
  -- other blocks commute with φ_{p_a w} and with φ_{q_a w}
  have hc : ∀ x, (x = N.p a ∨ x = N.q a) → ∀ c, c ≠ a → br (phi (N.p c) (N.q c)) (phi x w) = 0 := by
    rintro x (rfl | rfl) c hca
    · exact br_phi_disjoint (N.hp.ne hca) (hw c).1 (fun e => N.hpq a c e.symm) (hw c).2
    · exact br_phi_disjoint (N.hpq c a) (hw c).1 (N.hq.ne hca) (hw c).2
  have h1 : br (phi (N.p a) (N.q a)) (phi (N.p a) w) = phi (N.q a) w := by
    rw [br_phi_phi]; simp [hpw, hqw, Ne.symm hpq]
  have h2 : br (phi (N.p a) (N.q a)) (phi (N.q a) w) = -phi (N.p a) w := by
    rw [br_phi_phi]; simp [hpq, hpw, hqw]
  rw [br_X_one N a _ (hc _ (Or.inl rfl))]
  have hz : ∀ c, c ≠ a → br (phi (N.p c) (N.q c)) (br (N.s a • phi (N.p a) (N.q a)) (phi (N.p a) w)) = 0 := by
    intro c hca
    rw [RootSlots.brL_smul, h1, RootSlots.brR_smul, hc _ (Or.inr rfl) c hca, smul_zero]
  rw [br_X_one N a _ hz, RootSlots.brL_smul, RootSlots.brL_smul, h1, RootSlots.brR_smul, h2]
  simp only [smul_neg, neg_neg, smul_smul, sq]

/-- The same `X` read with `p`, `q` exchanged and the weights negated. -/
def NormalForm.swap {k : ℕ} (N : NormalForm ι k) : NormalForm ι k :=
  ⟨N.q, N.p, fun c => -N.s c, N.hq, N.hp, fun a b h => N.hpq b a h.symm⟩

theorem swap_X {k : ℕ} (N : NormalForm ι k) : N.swap.X = N.X := by
  simp only [NormalForm.X, NormalForm.swap]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [phi_swap, neg_smul, smul_neg, neg_neg]

/-- **The `q`-side kernel slot** `φ_{q_a w}`, `w` free, has eigenvalue `s_a²`. -/
theorem slot_kernel_q {k : ℕ} (N : NormalForm ι k) (a : Fin k) {w : ι} (hw : N.Free w) :
    -br N.X (br N.X (phi (N.q a) w)) = N.s a ^ 2 • phi (N.q a) w := by
  have hw' : N.swap.Free w := fun c => ⟨(hw c).2, (hw c).1⟩
  have h := slot_kernel_general N.swap a hw'
  rw [swap_X] at h
  simpa [NormalForm.swap, neg_sq] using h

/-- **Two free indices give a null slot.** -/
theorem slot_free_null {k : ℕ} (N : NormalForm ι k) {w w' : ι} (hw : N.Free w) (hw' : N.Free w') :
    -br N.X (br N.X (phi w w')) = (0 : ℝ) • phi w w' := by
  have h0 : br N.X (phi w w') = 0 := by
    rw [NormalForm.X, br_sum_left]
    refine Finset.sum_eq_zero fun c _ => ?_
    rw [RootSlots.brL_smul, br_phi_disjoint (hw c).1 (hw' c).1 (hw c).2 (hw' c).2, smul_zero]
  rw [h0]; simp [br]

/-! ## Step 5: orthogonality inside a block pair -/

theorem i2_subL (A B C : Matrix ι ι ℝ) : inner2 (A - B) C = inner2 A C - inner2 B C := by
  simp [inner2, Matrix.transpose_sub, Matrix.sub_mul, Matrix.trace_sub]; ring
theorem i2_addL (A B C : Matrix ι ι ℝ) : inner2 (A + B) C = inner2 A C + inner2 B C := by
  simp [inner2, Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring
theorem i2_subR (A B C : Matrix ι ι ℝ) : inner2 A (B - C) = inner2 A B - inner2 A C := by
  simp [inner2, Matrix.mul_sub, Matrix.trace_sub]; ring
theorem i2_addR (A B C : Matrix ι ι ℝ) : inner2 A (B + C) = inner2 A B + inner2 A C := by
  simp [inner2, Matrix.mul_add, Matrix.trace_add]; ring

section pairgram
variable {k : ℕ} (N : NormalForm ι k) {a b : Fin k} (hab : a ≠ b)
include hab

/-- The four slot vectors of blocks `a`, `b`, unnormalised. -/
noncomputable def S1 := phi (N.p a) (N.p b) - phi (N.q a) (N.q b)
noncomputable def S2 := phi (N.p a) (N.q b) + phi (N.q a) (N.p b)
noncomputable def S3 := phi (N.p a) (N.p b) + phi (N.q a) (N.q b)
noncomputable def S4 := phi (N.p a) (N.q b) - phi (N.q a) (N.p b)

/-- **The Gram matrix of the four slot vectors is `2·I`.** -/
theorem pair_gram :
    inner2 (S1 N (a := a) (b := b)) (S1 N (a := a) (b := b)) = 2 ∧
    inner2 (S2 N (a := a) (b := b)) (S2 N (a := a) (b := b)) = 2 ∧
    inner2 (S3 N (a := a) (b := b)) (S3 N (a := a) (b := b)) = 2 ∧
    inner2 (S4 N (a := a) (b := b)) (S4 N (a := a) (b := b)) = 2 ∧
    inner2 (S1 N (a := a) (b := b)) (S2 N (a := a) (b := b)) = 0 ∧
    inner2 (S1 N (a := a) (b := b)) (S3 N (a := a) (b := b)) = 0 ∧
    inner2 (S1 N (a := a) (b := b)) (S4 N (a := a) (b := b)) = 0 ∧
    inner2 (S2 N (a := a) (b := b)) (S3 N (a := a) (b := b)) = 0 ∧
    inner2 (S2 N (a := a) (b := b)) (S4 N (a := a) (b := b)) = 0 ∧
    inner2 (S3 N (a := a) (b := b)) (S4 N (a := a) (b := b)) = 0 := by
  obtain ⟨h1, h2, h3, h4, h5, h6⟩ := ne_facts N hab
  simp only [S1, S2, S3, S4, i2_subL, i2_addL, i2_subR, i2_addR, HamiltonsCubic.Results.inner2_phi_phi]
  simp [h1, h2, h3, h4, h5, h6, Ne.symm h1, Ne.symm h2, Ne.symm h3, Ne.symm h4, Ne.symm h5,
    Ne.symm h6]
  norm_num

end pairgram

/-! ## Step 6: different block pairs are orthogonal -/

/-- Membership in block `c`. -/
def NormalForm.InBlk {k : ℕ} (N : NormalForm ι k) (c : Fin k) (x : ι) : Prop := x = N.p c ∨ x = N.q c

theorem same_block {k : ℕ} (N : NormalForm ι k) {a c : Fin k} {x : ι}
    (ha : N.InBlk a x) (hc : N.InBlk c x) : a = c := by
  rcases ha with rfl | rfl <;> rcases hc with h | h
  · exact N.hp h
  · exact absurd h (N.hpq a c)
  · exact absurd h.symm (N.hpq c a)
  · exact N.hq h

/-- Basis bivectors on different unordered index pairs are orthogonal. -/
theorem phi_orth {i j k l : ι} (h1 : ¬(i = k ∧ j = l)) (h2 : ¬(i = l ∧ j = k)) :
    inner2 (phi i j) (phi k l) = 0 := by
  rw [HamiltonsCubic.Results.inner2_phi_phi]; simp [h1, h2]

/-- **Two slot bivectors from different ordered block pairs are orthogonal.** -/
theorem cross_phi {k : ℕ} (N : NormalForm ι k) {a b c d : Fin k} (hab : a < b) (hcd : c < d)
    (hne : (a, b) ≠ (c, d)) {x y x' y' : ι} (hx : N.InBlk a x) (hy : N.InBlk b y)
    (hx' : N.InBlk c x') (hy' : N.InBlk d y') : inner2 (phi x y) (phi x' y') = 0 := by
  apply phi_orth
  · rintro ⟨rfl, rfl⟩
    exact hne (Prod.ext (same_block N hx hx') (same_block N hy hy'))
  · rintro ⟨rfl, rfl⟩
    have h1 := same_block N hx hy'; have h2 := same_block N hy hx'
    subst h1; subst h2; exact absurd (hab.trans hcd) (lt_irrefl _)

/-- **Any two-term combinations of slot bivectors from different pairs are orthogonal.** -/
theorem cross_comb {k : ℕ} (N : NormalForm ι k) {a b c d : Fin k} (hab : a < b) (hcd : c < d)
    (hne : (a, b) ≠ (c, d)) {x1 y1 x2 y2 x1' y1' x2' y2' : ι}
    (hx1 : N.InBlk a x1) (hy1 : N.InBlk b y1) (hx2 : N.InBlk a x2) (hy2 : N.InBlk b y2)
    (hx1' : N.InBlk c x1') (hy1' : N.InBlk d y1') (hx2' : N.InBlk c x2') (hy2' : N.InBlk d y2')
    (ε δ : ℝ) :
    inner2 (phi x1 y1 + ε • phi x2 y2) (phi x1' y1' + δ • phi x2' y2') = 0 := by
  have hs : ∀ (A B : Matrix ι ι ℝ) (c : ℝ), inner2 (c • A) B = c * inner2 A B := by
    intro A B c; simp [inner2, Matrix.transpose_smul, Matrix.trace_smul]; ring
  have hs' : ∀ (A B : Matrix ι ι ℝ) (c : ℝ), inner2 A (c • B) = c * inner2 A B := by
    intro A B c; simp [inner2, Matrix.trace_smul]; ring
  rw [i2_addL, i2_addR, i2_addR, hs, hs, hs', hs',
    cross_phi N hab hcd hne hx1 hy1 hx1' hy1', cross_phi N hab hcd hne hx1 hy1 hx2' hy2',
    cross_phi N hab hcd hne hx2 hy2 hx1' hy1', cross_phi N hab hcd hne hx2 hy2 hx2' hy2']
  ring

/-! ## Step 7: Cartan, kernel and free-free slots against the rest -/

section step7
variable {k : ℕ} (N : NormalForm ι k)

theorem free_ne_blk {c : Fin k} {x w : ι} (hx : N.InBlk c x) (hw : N.Free w) : x ≠ w := by
  rcases hx with rfl | rfl
  · exact (hw c).1
  · exact (hw c).2

/-- **Cartan against a pair slot.** -/
theorem cartan_pair {c a b : Fin k} (hab : a < b) {x y : ι} (hx : N.InBlk a x) (hy : N.InBlk b y) :
    inner2 (phi (N.p c) (N.q c)) (phi x y) = 0 := by
  have hp : N.InBlk c (N.p c) := Or.inl rfl
  have hq : N.InBlk c (N.q c) := Or.inr rfl
  apply phi_orth
  · rintro ⟨h1, h2⟩
    have e1 := same_block N hp (h1 ▸ hx); have e2 := same_block N hq (h2 ▸ hy)
    exact absurd (e1.symm.trans e2 ▸ hab) (lt_irrefl _)
  · rintro ⟨h1, h2⟩
    have e1 := same_block N hp (h1 ▸ hy); have e2 := same_block N hq (h2 ▸ hx)
    exact absurd (e2.symm.trans e1 ▸ hab) (lt_irrefl _)

/-- **Two different Cartan slots.** -/
theorem cartan_cartan {c d : Fin k} (hcd : c ≠ d) :
    inner2 (phi (N.p c) (N.q c)) (phi (N.p d) (N.q d)) = 0 := by
  apply phi_orth
  · rintro ⟨h1, _⟩; exact hcd (N.hp h1)
  · rintro ⟨h1, _⟩; exact N.hpq c d h1

/-- **A kernel slot against any bivector on two block indices.** -/
theorem kernel_blk {c a b : Fin k} {x w x' y' : ι} (_hx : N.InBlk c x) (hw : N.Free w)
    (hx' : N.InBlk a x') (hy' : N.InBlk b y') : inner2 (phi x w) (phi x' y') = 0 := by
  apply phi_orth
  · rintro ⟨_, h⟩; exact free_ne_blk N hy' hw h.symm
  · rintro ⟨_, h⟩; exact free_ne_blk N hx' hw h.symm

/-- **Two kernel slots on different index pairs.** -/
theorem kernel_kernel {c d : Fin k} {x w x' w' : ι} (hx : N.InBlk c x) (_hw : N.Free w)
    (_hx' : N.InBlk d x') (hw' : N.Free w') (hne : ¬(x = x' ∧ w = w')) :
    inner2 (phi x w) (phi x' w') = 0 := by
  apply phi_orth hne
  rintro ⟨h, _⟩; exact free_ne_blk N hx hw' h

/-- **A free-free slot against a bivector with a block index.** -/
theorem free_blk {c : Fin k} {w w' x y : ι} (hw : N.Free w) (hw' : N.Free w')
    (hx : N.InBlk c x) : inner2 (phi w w') (phi x y) = 0 := by
  apply phi_orth
  · rintro ⟨h, _⟩; exact free_ne_blk N hx hw h.symm
  · rintro ⟨_, h⟩; exact free_ne_blk N hx hw' h.symm

end step7

/-! ## Step 8a: the pair slots span the cross-block bivectors -/

section step8a
variable {k : ℕ} (N : NormalForm ι k) (a b : Fin k)

theorem span_pp : phi (N.p a) (N.p b) =
    (1/2 : ℝ) • (S1 N (a := a) (b := b) + S3 N (a := a) (b := b)) := by
  simp only [S1, S3]; module
theorem span_qq : phi (N.q a) (N.q b) =
    (1/2 : ℝ) • (S3 N (a := a) (b := b) - S1 N (a := a) (b := b)) := by
  simp only [S1, S3]; module
theorem span_pq : phi (N.p a) (N.q b) =
    (1/2 : ℝ) • (S2 N (a := a) (b := b) + S4 N (a := a) (b := b)) := by
  simp only [S2, S4]; module
theorem span_qp : phi (N.q a) (N.p b) =
    (1/2 : ℝ) • (S2 N (a := a) (b := b) - S4 N (a := a) (b := b)) := by
  simp only [S2, S4]; module

end step8a

/-! ## Step 8b: expansion transfers between orthonormal families on one index set -/

section step8b
variable {E : Type*} [AddCommGroup E] [Module ℝ E]

/-- **Transfer of the expansion.** If `φ` expands every vector of `S` (no orthonormality needed),
and `b` is orthonormal on the same finite index set with each `b k ∈ S`, then `b` expands every
vector of `S`. The change of basis `R k l = B (φ l) (b k)` has `R Rᵀ = 1`, hence `Rᵀ R = 1`. -/
theorem transfer_expansion (B : LinearMap.BilinForm ℝ E)
    {κ : Type*} [Fintype κ] [DecidableEq κ] (φ b : κ → E)
    (hb : ∀ k l, B (b k) (b l) = if k = l then 1 else 0)
    (S : E → Prop) (hexp : ∀ y, S y → y = ∑ k, B (φ k) y • φ k) (hbS : ∀ k, S (b k)) :
    ∀ y, S y → y = ∑ k, B (b k) y • b k := by
  set R : Matrix κ κ ℝ := fun k l => B (φ l) (b k) with hR
  have hbexp : ∀ k, b k = ∑ l, R k l • φ l := fun k => hexp (b k) (hbS k)
  -- B (φ-combination) y through the expansion
  have hBsum : ∀ (c : κ → ℝ) (y : E), B (∑ l, c l • φ l) y = ∑ l, c l * B (φ l) y := by
    intro c y; simp [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, smul_eq_mul]
  have hRRt : R * R.transpose = 1 := by
    ext k k'
    have h := hb k k'
    rw [hbexp k, hBsum, ] at h
    have h2 : ∀ l, B (φ l) (b k') = R k' l := fun l => rfl
    simp only [h2] at h
    simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply]
    rw [← h]
  have hRtR : R.transpose * R = 1 := mul_eq_one_comm.mp hRRt
  intro y hy
  have hc : ∀ k, B (b k) y = ∑ l, R k l * B (φ l) y := by
    intro k; rw [hbexp k, hBsum]
  calc y = ∑ m, B (φ m) y • φ m := hexp y hy
    _ = ∑ m, (∑ l, (R.transpose * R) m l * B (φ l) y) • φ m := by
        rw [hRtR]; simp [Matrix.one_apply]
    _ = ∑ k, B (b k) y • b k := by
        simp only [hc, Matrix.mul_apply, Matrix.transpose_apply]
        conv_rhs => arg 2; ext k; rw [hbexp k, Finset.smul_sum]
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun m _ => ?_
        simp only [smul_smul, ← Finset.sum_smul]
        congr 1
        simp only [Finset.sum_mul]
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun l _ => ?_
        refine Finset.sum_congr rfl fun k _ => ?_
        ring

end step8b

/-! ## Index equalities, as simp lemmas for the orthogonality assembly -/

section idx
variable {k : ℕ} (N : NormalForm ι k)

@[simp] theorem p_eq_p_iff {a b : Fin k} : N.p a = N.p b ↔ a = b := N.hp.eq_iff
@[simp] theorem q_eq_q_iff {a b : Fin k} : N.q a = N.q b ↔ a = b := N.hq.eq_iff
@[simp] theorem p_eq_q_false {a b : Fin k} : N.p a = N.q b ↔ False := ⟨N.hpq a b, False.elim⟩
@[simp] theorem q_eq_p_false {a b : Fin k} : N.q a = N.p b ↔ False :=
  ⟨fun h => N.hpq b a h.symm, False.elim⟩

theorem p_ne_free {a : Fin k} {w : ι} (hw : N.Free w) : N.p a ≠ w := (hw a).1
theorem q_ne_free {a : Fin k} {w : ι} (hw : N.Free w) : N.q a ≠ w := (hw a).2

end idx

/-! ## Step 9a: classifying an index -/

section step9a
variable {k : ℕ} (N : NormalForm ι k)

/-- **Every index is the `p`-side of a block, the `q`-side of a block, or free.** -/
theorem classify (x : ι) :
    (∃ c, N.p c = x) ∨ (∃ c, N.q c = x) ∨ N.Free x := by
  by_cases hp : ∃ c, N.p c = x
  · exact Or.inl hp
  by_cases hq : ∃ c, N.q c = x
  · exact Or.inr (Or.inl hq)
  push Not at hp hq
  exact Or.inr (Or.inr fun c => ⟨hp c, hq c⟩)

/-- The three cases are exclusive: no index is both a `p`-side and a `q`-side. -/
theorem p_ne_q_side {x : ι} {a b : Fin k} (ha : N.p a = x) (hb : N.q b = x) : False :=
  N.hpq a b (ha.trans hb.symm)

/-- A block index is not free. -/
theorem p_not_free {x : ι} {a : Fin k} (ha : N.p a = x) (hx : N.Free x) : False :=
  (hx a).1 ha

theorem q_not_free {x : ι} {a : Fin k} (ha : N.q a = x) (hx : N.Free x) : False :=
  (hx a).2 ha

end step9a

/-! ## Step 9b: the block of an index, as a function -/

section step9b
variable {k : ℕ} (N : NormalForm ι k)

open Classical in
/-- The block an index lies in, if any. -/
noncomputable def NormalForm.blockOf (x : ι) : Option (Fin k) :=
  if h : ∃ c, N.p c = x ∨ N.q c = x then some (Classical.choose h) else none

theorem blockOf_spec {x : ι} {c : Fin k} (h : N.blockOf x = some c) : N.p c = x ∨ N.q c = x := by
  unfold NormalForm.blockOf at h
  split_ifs at h with hx
  · cases h; exact Classical.choose_spec hx

theorem blockOf_of_p (c : Fin k) : N.blockOf (N.p c) = some c := by
  have hx : ∃ c', N.p c' = N.p c ∨ N.q c' = N.p c := ⟨c, Or.inl rfl⟩
  unfold NormalForm.blockOf
  rw [dif_pos hx]
  congr 1
  rcases Classical.choose_spec hx with h | h
  · exact N.hp h
  · exact absurd h.symm (N.hpq c _)

theorem blockOf_of_q (c : Fin k) : N.blockOf (N.q c) = some c := by
  have hx : ∃ c', N.p c' = N.q c ∨ N.q c' = N.q c := ⟨c, Or.inr rfl⟩
  unfold NormalForm.blockOf
  rw [dif_pos hx]
  congr 1
  rcases Classical.choose_spec hx with h | h
  · exact absurd h (N.hpq _ c)
  · exact N.hq h

theorem blockOf_none {x : ι} (h : N.blockOf x = none) : N.Free x := by
  unfold NormalForm.blockOf at h
  split_ifs at h with hx
  push Not at hx
  exact fun c => ⟨(hx c).1, (hx c).2⟩

/-- **The converse**: a free index has no block. -/
theorem blockOf_free {x : ι} (hx : N.Free x) : N.blockOf x = none := by
  cases h : N.blockOf x with
  | none => rfl
  | some c =>
      rcases blockOf_spec N h with h' | h'
      · exact absurd h' (hx c).1
      · exact absurd h' (hx c).2

end step9b

/-! ## Step 9c: the slot family on the index pairs, and its eigenvalues -/

section step9c
variable {ι : Type*} [Fintype ι] [DecidableEq ι] [LinearOrder ι] {k : ℕ} (N : NormalForm ι k)

/-- The pair slot of blocks `c < d` read at the index pair `x ∈ c`, `y ∈ d`: one of `S₁,…,S₄`
by the `p`/`q` roles of `x` and `y`, before normalisation. -/
noncomputable def pairSlot (c d : Fin k) (x y : ι) : Matrix ι ι ℝ :=
  if N.p c = x then (if N.p d = y then S1 N (a := c) (b := d) else S2 N (a := c) (b := d))
  else (if N.q d = y then S3 N (a := c) (b := d) else S4 N (a := c) (b := d))

/-- Its eigenvalue: `(s_c + s_d)²` on `S₁, S₂`, `(s_c − s_d)²` on `S₃, S₄`. -/
noncomputable def pairMu (c d : Fin k) (x : ι) : ℝ :=
  if N.p c = x then (N.s c + N.s d) ^ 2 else (N.s c - N.s d) ^ 2

open Classical in
/-- **The slot at the index pair `i < j`.** Cross-block pairs get their normalised pair slot;
every other pair (Cartan, kernel, free-free) keeps `φ_{ij}`. -/
noncomputable def slotφ (ij : {x : ι × ι // x.1 < x.2}) : Matrix ι ι ℝ :=
  match N.blockOf ij.1.1, N.blockOf ij.1.2 with
  | some a, some b =>
      if a = b then phi ij.1.1 ij.1.2
      else if a < b then (Real.sqrt 2)⁻¹ • pairSlot N a b ij.1.1 ij.1.2
      else (Real.sqrt 2)⁻¹ • pairSlot N b a ij.1.2 ij.1.1
  | _, _ => phi ij.1.1 ij.1.2

open Classical in
/-- **Its eigenvalue.** -/
noncomputable def slotμ (ij : {x : ι × ι // x.1 < x.2}) : ℝ :=
  match N.blockOf ij.1.1, N.blockOf ij.1.2 with
  | some a, some b =>
      if a = b then 0
      else if a < b then pairMu N a b ij.1.1 else pairMu N b a ij.1.2
  | some a, none => N.s a ^ 2
  | none, some b => N.s b ^ 2
  | none, none => 0

theorem negAd_smul (X Y : Matrix ι ι ℝ) (c : ℝ) :
    -br X (br X (c • Y)) = c • (-br X (br X Y)) := by
  rw [RootSlots.brR_smul, RootSlots.brR_smul, smul_neg]

/-- **The Cartan slot is null at every `k`**, with no second block needed. -/
theorem cartan_null (a : Fin k) : br N.X (phi (N.p a) (N.q a)) = 0 := by
  rw [NormalForm.X, br_sum_left]
  refine Finset.sum_eq_zero fun c _ => ?_
  rw [RootSlots.brL_smul]
  by_cases hca : c = a
  · subst hca; simp [br]
  · rw [br_phi_disjoint (N.hp.ne hca) (N.hpq c a) (fun h => N.hpq a c h.symm) (N.hq.ne hca),
      smul_zero]

/-- The eigen relation of a basis bivector `φ_{xy}`, read off by orientation. -/
theorem negAd_phi_swap (X : Matrix ι ι ℝ) (x y : ι) (μ : ℝ)
    (h : -br X (br X (phi y x)) = μ • phi y x) : -br X (br X (phi x y)) = μ • phi x y := by
  rw [phi_swap y x, RootSlots.brR_neg, RootSlots.brR_neg, neg_neg, smul_neg, ← h, neg_neg]

/-- **Every branch of `pairSlot` is an eigenvector with eigenvalue `pairMu`**, whatever the roles. -/
theorem pairSlot_eigen {c d : Fin k} (hcd : c ≠ d) (x y : ι) :
    -br N.X (br N.X (pairSlot N c d x y)) = pairMu N c d x • pairSlot N c d x y := by
  unfold pairSlot pairMu
  split_ifs <;> simp only [S1, S2, S3, S4]
  · exact slot_plus_general N hcd
  · exact slot_plus2_general N hcd
  · exact slot_minus_general N hcd
  · exact slot_minus2_general N hcd

/-- **The Cartan slot in either orientation is null.** -/
theorem cartan_eigen (a : Fin k) {x y : ι} (hx : N.p a = x ∨ N.q a = x)
    (hy : N.p a = y ∨ N.q a = y) (hxy : x ≠ y) :
    -br N.X (br N.X (phi x y)) = (0 : ℝ) • phi x y := by
  rcases hx with rfl | rfl <;> rcases hy with h | h
  · exact absurd h hxy
  · subst h; rw [cartan_null]; simp [br]
  · subst h; rw [phi_swap, RootSlots.brR_neg, cartan_null]; simp [br]
  · exact absurd h hxy

/-- **The eigen relation of the whole slot family.** -/
theorem slot_eigen (ij : {x : ι × ι // x.1 < x.2}) :
    -br N.X (br N.X (slotφ N ij)) = slotμ N ij • slotφ N ij := by
  obtain ⟨⟨i, j⟩, hij⟩ := ij
  have hne : i ≠ j := ne_of_lt hij
  cases hbi : N.blockOf i with
  | none =>
    cases hbj : N.blockOf j with
    | none =>
      simp only [slotφ, slotμ, hbi, hbj]
      exact slot_free_null N (blockOf_none N hbi) (blockOf_none N hbj)
    | some b =>
      simp only [slotφ, slotμ, hbi, hbj]
      apply negAd_phi_swap
      rcases blockOf_spec N hbj with h | h
      · subst h; exact slot_kernel_general N b (blockOf_none N hbi)
      · subst h; exact slot_kernel_q N b (blockOf_none N hbi)
  | some a =>
    cases hbj : N.blockOf j with
    | none =>
      simp only [slotφ, slotμ, hbi, hbj]
      rcases blockOf_spec N hbi with h | h
      · subst h; exact slot_kernel_general N a (blockOf_none N hbj)
      · subst h; exact slot_kernel_q N a (blockOf_none N hbj)
    | some b =>
      simp only [slotφ, slotμ, hbi, hbj]
      by_cases hab : a = b
      · subst hab; simp only [if_true]
        exact cartan_eigen N a (blockOf_spec N hbi) (blockOf_spec N hbj) hne
      · simp only [hab, if_false]
        by_cases hlt : a < b
        · simp only [hlt, if_true]
          rw [negAd_smul, pairSlot_eigen N hab, smul_comm]
        · simp only [hlt, if_false]
          rw [negAd_smul, pairSlot_eigen N (Ne.symm hab), smul_comm]

theorem i2_smul_smul (c : ℝ) (A B : Matrix ι ι ℝ) : inner2 (c • A) (c • B) = c ^ 2 * inner2 A B := by
  simp [inner2, Matrix.transpose_smul, Matrix.trace_smul, smul_eq_mul]; ring

/-- **The normalised pair slots have `inner2`-norm `1`**: `(1/√2)²·2 = 1`. The off-diagonal zeros are
`pair_gram`'s, unnormalised. -/
theorem pair_orthonormal {a b : Fin k} (hab : a ≠ b) :
    inner2 ((Real.sqrt 2)⁻¹ • S1 N (a := a) (b := b)) ((Real.sqrt 2)⁻¹ • S1 N (a := a) (b := b)) = 1 ∧
    inner2 ((Real.sqrt 2)⁻¹ • S2 N (a := a) (b := b)) ((Real.sqrt 2)⁻¹ • S2 N (a := a) (b := b)) = 1 ∧
    inner2 ((Real.sqrt 2)⁻¹ • S3 N (a := a) (b := b)) ((Real.sqrt 2)⁻¹ • S3 N (a := a) (b := b)) = 1 ∧
    inner2 ((Real.sqrt 2)⁻¹ • S4 N (a := a) (b := b)) ((Real.sqrt 2)⁻¹ • S4 N (a := a) (b := b)) = 1 := by
  obtain ⟨g1, g2, g3, g4, -⟩ := pair_gram N hab
  have hs : ((Real.sqrt 2)⁻¹) ^ 2 * 2 = 1 := by
    rw [inv_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)]; norm_num
  refine ⟨?_, ?_, ?_, ?_⟩ <;> rw [i2_smul_smul] <;>
    first | rw [g1, hs] | rw [g2, hs] | rw [g3, hs] | rw [g4, hs]

/-- A pair is **cross-block** when its two indices lie in different blocks. -/
def IsCross (ij : {x : ι × ι // x.1 < x.2}) : Prop :=
  ∃ a b, N.blockOf ij.1.1 = some a ∧ N.blockOf ij.1.2 = some b ∧ a ≠ b

/-- **Off the cross-block pairs the slot is the basis bivector itself.** -/
theorem slotφ_of_not_cross (ij : {x : ι × ι // x.1 < x.2}) (h : ¬ IsCross N ij) :
    slotφ N ij = phi ij.1.1 ij.1.2 := by
  obtain ⟨⟨i, j⟩, hij⟩ := ij
  simp only [IsCross, not_exists, not_and] at h
  unfold slotφ
  cases hbi : N.blockOf i with
  | none => simp_all
  | some a =>
    cases hbj : N.blockOf j with
    | none => simp_all
    | some b =>
      have hab : a = b := by
        by_contra hne; exact h a b hbi hbj hne
      subst hab; simp_all

/-- **Orthonormality, case (A): two basis bivectors on ordered pairs.** With `i < j` and `k < l`,
the swapped coincidence is impossible, so `inner2 φ_{ij} φ_{kl} = [ij = kl]`. -/
theorem phi_orthonormal_ordered (ij kl : {x : ι × ι // x.1 < x.2}) :
    inner2 (phi ij.1.1 ij.1.2) (phi kl.1.1 kl.1.2) = if ij = kl then 1 else 0 := by
  obtain ⟨⟨i, j⟩, hij⟩ := ij
  obtain ⟨⟨k, l⟩, hkl⟩ := kl
  rw [HamiltonsCubic.Results.inner2_phi_phi]
  have hswap : ¬(i = l ∧ j = k) := by
    rintro ⟨rfl, rfl⟩; exact absurd (hij.trans hkl) (lt_irrefl _)
  simp only [hswap, if_false, sub_zero]
  by_cases h : i = k ∧ j = l
  · obtain ⟨rfl, rfl⟩ := h; simp
  · rw [if_neg h, if_neg]
    intro he
    apply h
    have := congrArg Subtype.val he
    simp only [Prod.mk.injEq] at this
    exact this

/-- **Case (A) for the slot family**: two non-cross slots are orthonormal. -/
theorem slot_orth_nn (ij kl : {x : ι × ι // x.1 < x.2}) (hij : ¬ IsCross N ij)
    (hkl : ¬ IsCross N kl) :
    inner2 (slotφ N ij) (slotφ N kl) = if ij = kl then 1 else 0 := by
  rw [slotφ_of_not_cross N ij hij, slotφ_of_not_cross N kl hkl]
  exact phi_orthonormal_ordered ij kl

theorem blockOf_of_inBlk {c : Fin k} {x : ι} (hx : N.InBlk c x) : N.blockOf x = some c := by
  rcases hx with rfl | rfl
  · exact blockOf_of_p N c
  · exact blockOf_of_q N c

/-- A non-cross pair is orthogonal to every bivector on two different blocks. -/
theorem phi_orth_of_not_cross (ij : {x : ι × ι // x.1 < x.2}) (hnc : ¬ IsCross N ij)
    {c d : Fin k} (hcd : c ≠ d) {x y : ι} (hx : N.InBlk c x) (hy : N.InBlk d y) :
    inner2 (phi ij.1.1 ij.1.2) (phi x y) = 0 := by
  apply phi_orth
  · rintro ⟨h1, h2⟩
    exact hnc ⟨c, d, h1 ▸ blockOf_of_inBlk N hx, h2 ▸ blockOf_of_inBlk N hy, hcd⟩
  · rintro ⟨h1, h2⟩
    exact hnc ⟨d, c, h1 ▸ blockOf_of_inBlk N hy, h2 ▸ blockOf_of_inBlk N hx, Ne.symm hcd⟩

/-- **A non-cross pair is orthogonal to every pair slot.** -/
theorem phi_orth_pairSlot (ij : {x : ι × ι // x.1 < x.2}) (hnc : ¬ IsCross N ij)
    {c d : Fin k} (hcd : c ≠ d) (x y : ι) :
    inner2 (phi ij.1.1 ij.1.2) (pairSlot N c d x y) = 0 := by
  have o := fun {u v : ι} (hu : N.InBlk c u) (hv : N.InBlk d v) =>
    phi_orth_of_not_cross N ij hnc hcd hu hv
  have pc : N.InBlk c (N.p c) := Or.inl rfl
  have qc : N.InBlk c (N.q c) := Or.inr rfl
  have pd : N.InBlk d (N.p d) := Or.inl rfl
  have qd : N.InBlk d (N.q d) := Or.inr rfl
  unfold pairSlot
  split_ifs <;> simp only [S1, S2, S3, S4, i2_subR, i2_addR, o pc pd, o qc qd, o pc qd, o qc pd] <;>
    norm_num

theorem i2_smulR (c : ℝ) (A B : Matrix ι ι ℝ) : inner2 A (c • B) = c * inner2 A B := by
  simp [inner2, Matrix.trace_smul, smul_eq_mul]; ring

/-- **Orthonormality, case (B)**: a non-cross slot is orthogonal to every cross slot. -/
theorem slot_orth_nc (ij kl : {x : ι × ι // x.1 < x.2}) (hij : ¬ IsCross N ij)
    (hkl : IsCross N kl) : inner2 (slotφ N ij) (slotφ N kl) = 0 := by
  rw [slotφ_of_not_cross N ij hij]
  obtain ⟨c, d, hc, hd, hcd⟩ := hkl
  unfold slotφ
  rw [hc, hd]
  simp only [hcd, if_false]
  split_ifs
  · rw [i2_smulR, phi_orth_pairSlot N ij hij hcd, mul_zero]
  · rw [i2_smulR, phi_orth_pairSlot N ij hij (Ne.symm hcd), mul_zero]

theorem i2_comm (A B : Matrix ι ι ℝ) : inner2 A B = inner2 B A := by
  unfold inner2; rw [← Matrix.trace_transpose, Matrix.transpose_mul, Matrix.transpose_transpose]

set_option maxHeartbeats 1000000 in
/-- **Two pair slots of one block pair**: `inner2 = 2` when the index roles agree and `0` otherwise. -/
theorem pairSlot_orth_same {a b : Fin k} (hab : a ≠ b) {x y x' y' : ι}
    (hx : N.InBlk a x) (hy : N.InBlk b y) (hx' : N.InBlk a x') (hy' : N.InBlk b y') :
    inner2 (pairSlot N a b x y) (pairSlot N a b x' y') = if x = x' ∧ y = y' then 2 else 0 := by
  have hba : b ≠ a := Ne.symm hab
  rcases hx with rfl | rfl <;> rcases hy with rfl | rfl <;>
    rcases hx' with rfl | rfl <;> rcases hy' with rfl | rfl <;>
    simp only [pairSlot, S1, S2, S3, S4, p_eq_p_iff, q_eq_q_iff, p_eq_q_false, q_eq_p_false,
      if_true, if_false, i2_subL, i2_addL, i2_subR, i2_addR,
      HamiltonsCubic.Results.inner2_phi_phi, hab, hba, and_true, true_and, and_false, false_and,
      and_self] <;> norm_num

/-- **Pair slots of different ordered block pairs are orthogonal.** -/
theorem pairSlot_orth_diff {a b c d : Fin k} (hab : a < b) (hcd : c < d) (hne : (a, b) ≠ (c, d))
    (x y x' y' : ι) : inner2 (pairSlot N a b x y) (pairSlot N c d x' y') = 0 := by
  have H : ∀ {u v u' v' : ι}, N.InBlk a u → N.InBlk b v → N.InBlk c u' → N.InBlk d v' →
      inner2 (phi u v) (phi u' v') = 0 :=
    fun hu hv hu' hv' => cross_phi N hab hcd hne hu hv hu' hv'
  have pa : N.InBlk a (N.p a) := Or.inl rfl
  have qa : N.InBlk a (N.q a) := Or.inr rfl
  have pb : N.InBlk b (N.p b) := Or.inl rfl
  have qb : N.InBlk b (N.q b) := Or.inr rfl
  have pc : N.InBlk c (N.p c) := Or.inl rfl
  have qc : N.InBlk c (N.q c) := Or.inr rfl
  have pd : N.InBlk d (N.p d) := Or.inl rfl
  have qd : N.InBlk d (N.q d) := Or.inr rfl
  unfold pairSlot
  split_ifs <;>
    simp only [S1, S2, S3, S4, i2_subL, i2_addL, i2_subR, i2_addR,
      H pa pb pc pd, H pa pb pc qd, H pa pb qc pd, H pa pb qc qd,
      H pa qb pc pd, H pa qb pc qd, H pa qb qc pd, H pa qb qc qd,
      H qa pb pc pd, H qa pb pc qd, H qa pb qc pd, H qa pb qc qd,
      H qa qb pc pd, H qa qb pc qd, H qa qb qc pd, H qa qb qc qd] <;> norm_num

/-- **A cross slot is the normalised pair slot of its ordered block pair.** -/
theorem slotφ_of_cross (ij : {x : ι × ι // x.1 < x.2}) (h : IsCross N ij) :
    ∃ c d x y, c < d ∧ N.InBlk c x ∧ N.InBlk d y ∧
      ((x = ij.1.1 ∧ y = ij.1.2) ∨ (x = ij.1.2 ∧ y = ij.1.1)) ∧
      slotφ N ij = (Real.sqrt 2)⁻¹ • pairSlot N c d x y := by
  obtain ⟨⟨i, j⟩, hij⟩ := ij
  obtain ⟨a, b, ha, hb, hab⟩ := h
  have hia : N.InBlk a i := by
    rcases blockOf_spec N ha with h | h
    · exact Or.inl h.symm
    · exact Or.inr h.symm
  have hjb : N.InBlk b j := by
    rcases blockOf_spec N hb with h | h
    · exact Or.inl h.symm
    · exact Or.inr h.symm
  rcases lt_or_gt_of_ne hab with hlt | hgt
  · refine ⟨a, b, i, j, hlt, hia, hjb, Or.inl ⟨rfl, rfl⟩, ?_⟩
    unfold slotφ; simp only [ha, hb, hab, hlt, if_false, if_true]
  · refine ⟨b, a, j, i, hgt, hjb, hia, Or.inr ⟨rfl, rfl⟩, ?_⟩
    unfold slotφ
    simp only [ha, hb, hab, if_false, not_lt.mpr hgt.le, if_false]

/-- A pair is determined by its two indices up to orientation, and orientation by `i < j`. -/
theorem pair_eq_of_mem {ij kl : {x : ι × ι // x.1 < x.2}}
    (h : (ij.1.1 = kl.1.1 ∧ ij.1.2 = kl.1.2) ∨ (ij.1.1 = kl.1.2 ∧ ij.1.2 = kl.1.1)) : ij = kl := by
  obtain ⟨⟨i, j⟩, hij⟩ := ij; obtain ⟨⟨k, l⟩, hkl⟩ := kl
  rcases h with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · simp only at h1 h2; subst h1; subst h2; rfl
  · simp only at h1 h2; subst h1; subst h2; exact absurd (hij.trans hkl) (lt_irrefl _)

/-- **Orthonormality, case (C), assembled**: two cross slots are orthonormal. -/
theorem slot_orth_cc (ij kl : {x : ι × ι // x.1 < x.2}) (h1 : IsCross N ij) (h2 : IsCross N kl) :
    inner2 (slotφ N ij) (slotφ N kl) = if ij = kl then 1 else 0 := by
  obtain ⟨c, d, x, y, hcd, hx, hy, hor, he⟩ := slotφ_of_cross N ij h1
  obtain ⟨c', d', x', y', hcd', hx', hy', hor', he'⟩ := slotφ_of_cross N kl h2
  rw [he, he', i2_smul_smul]
  have hs : ((Real.sqrt 2)⁻¹) ^ 2 = 1 / 2 := by
    rw [inv_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)]; norm_num
  rw [hs]
  by_cases hsame : (c, d) = (c', d')
  · obtain ⟨rfl, rfl⟩ := Prod.mk.inj hsame
    rw [pairSlot_orth_same N (ne_of_lt hcd) hx hy hx' hy']
    have hdc : d ≠ c := ne_of_gt hcd
    have key : (x = x' ∧ y = y') ↔ ij = kl := by
      constructor
      · rintro ⟨rfl, rfl⟩
        apply pair_eq_of_mem
        rcases hor with ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> rcases hor' with ⟨f1, f2⟩ | ⟨f1, f2⟩
        · exact Or.inl ⟨e1.symm.trans f1, e2.symm.trans f2⟩
        · exact Or.inr ⟨e1.symm.trans f1, e2.symm.trans f2⟩
        · exact Or.inr ⟨e2.symm.trans f2, e1.symm.trans f1⟩
        · exact Or.inl ⟨e2.symm.trans f2, e1.symm.trans f1⟩
      · rintro rfl
        -- x and x' both lie in block c among the pair's two indices; y lies in block d ≠ c
        have hxx : x = x' := by
          by_contra hne
          have hy_c : N.InBlk c y := by
            rcases hor with ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> rcases hor' with ⟨f1, f2⟩ | ⟨f1, f2⟩
            · exact absurd (e1.trans f1.symm) hne
            · rw [e2, ← f1]; exact hx'
            · rw [e2, ← f1]; exact hx'
            · exact absurd (e1.trans f1.symm) hne
          exact hdc (same_block N hy hy_c)
        subst hxx
        refine ⟨rfl, ?_⟩
        rcases hor with ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> rcases hor' with ⟨f1, f2⟩ | ⟨f1, f2⟩
        · exact e2.trans f2.symm
        · exact absurd (same_block N hy (e2 ▸ f1 ▸ e1 ▸ hx)) hdc
        · exact absurd (same_block N hy (e2 ▸ f1 ▸ e1 ▸ hx)) hdc
        · exact e2.trans f2.symm
    by_cases hk : ij = kl
    · rw [if_pos (key.mpr hk), if_pos hk]; norm_num
    · rw [if_neg (fun h => hk (key.mp h)), if_neg hk]; norm_num
  · rw [pairSlot_orth_diff N hcd hcd' hsame, mul_zero]
    have hne : ij ≠ kl := by
      rintro rfl
      apply hsame
      rcases hor with ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> rcases hor' with ⟨f1, f2⟩ | ⟨f1, f2⟩
      · rw [same_block N hx (e1 ▸ f1 ▸ hx'), same_block N hy (e2 ▸ f2 ▸ hy')]
      · exact absurd ((same_block N hx (e1 ▸ f2 ▸ hy')).symm ▸ (same_block N hy (e2 ▸ f1 ▸ hx')) ▸ hcd')
          (lt_asymm hcd)
      · exact absurd ((same_block N hx (e1 ▸ f2 ▸ hy')).symm ▸ (same_block N hy (e2 ▸ f1 ▸ hx')) ▸ hcd')
          (lt_asymm hcd)
      · rw [same_block N hx (e1 ▸ f1 ▸ hx'), same_block N hy (e2 ▸ f2 ▸ hy')]
    rw [if_neg hne]

/-- **The slot family is orthonormal.** -/
theorem slot_orthonormal (ij kl : {x : ι × ι // x.1 < x.2}) :
    inner2 (slotφ N ij) (slotφ N kl) = if ij = kl then 1 else 0 := by
  by_cases h1 : IsCross N ij <;> by_cases h2 : IsCross N kl
  · exact slot_orth_cc N ij kl h1 h2
  · have hne : ij ≠ kl := by rintro rfl; exact h2 h1
    rw [i2_comm, slot_orth_nc N kl ij h2 h1, if_neg hne]
  · have hne : ij ≠ kl := by rintro rfl; exact h1 h2
    rw [slot_orth_nc N ij kl h1 h2, if_neg hne]
  · exact slot_orth_nn N ij kl h1 h2

/-- **A skew matrix expands in the basis bivectors over ordered pairs.** From `skew_expand`'s double
sum: the `(k,l)` and `(l,k)` terms agree and the diagonal ones vanish. -/
theorem phi_expand_ordered (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    X = ∑ ij : {x : ι × ι // x.1 < x.2}, inner2 (phi ij.1.1 ij.1.2) X • phi ij.1.1 ij.1.2 := by
  have hsk : ∀ a b, X b a = -X a b := fun a b => by
    have := congrFun (congrFun hX a) b
    simpa [Matrix.transpose_apply, Matrix.neg_apply] using this
  have hc : ∀ k l, inner2 (phi k l) X = X l k := by
    intro k l; rw [i2_comm, HamiltonsCubic.Results.inner2_phi_eq, hsk l k]; ring
  set G : ι × ι → Matrix ι ι ℝ := fun x => X x.2 x.1 • phi x.1 x.2 with hG
  have hsub : ∑ ij : {x : ι × ι // x.1 < x.2}, inner2 (phi ij.1.1 ij.1.2) X • phi ij.1.1 ij.1.2 =
      ∑ x ∈ Finset.univ.filter (fun x : ι × ι => x.1 < x.2), G x := by
    rw [Finset.sum_subtype (p := fun x : ι × ι => x.1 < x.2)
      (Finset.univ.filter (fun x : ι × ι => x.1 < x.2)) (by intro x; simp) G]
    exact Finset.sum_congr rfl fun ij _ => by rw [hc]
  rw [hsub]
  have hfull : X = (1 / 2 : ℝ) • ∑ x : ι × ι, G x := by
    have hs := HamiltonsCubic.Results.skew_expand X hX
    rw [← Fintype.sum_prod_type'] at hs
    exact hs
  have hswap : ∀ x : ι × ι, G x.swap = G x := by
    rintro ⟨a, b⟩
    simp only [hG, Prod.swap_prod_mk, hsk a b, phi_swap a b, neg_smul, smul_neg]
  have hdiag : ∀ x : ι × ι, x.1 = x.2 → G x = 0 := by
    rintro ⟨a, b⟩ h; simp only at h; subst h; simp [hG, phi_self]
  have hnot : ∑ x ∈ Finset.univ.filter (fun x : ι × ι => ¬ x.1 < x.2), G x =
      ∑ x ∈ Finset.univ.filter (fun x : ι × ι => x.1 < x.2), G x := by
    have h1 : ∑ x ∈ Finset.univ.filter (fun x : ι × ι => x.2 < x.1), G x =
        ∑ x ∈ Finset.univ.filter (fun x : ι × ι => ¬ x.1 < x.2), G x := by
      apply Finset.sum_subset
      · intro x hx
        simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hx ⊢
        exact not_lt.mpr hx.le
      · intro x hx hx'
        simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hx hx'
        exact hdiag x (le_antisymm (not_lt.mp hx') (not_lt.mp hx))
    rw [← h1]
    apply Finset.sum_equiv (Equiv.prodComm ι ι)
    · intro x; simp [Equiv.prodComm]
    · intro x _; simp only [Equiv.prodComm_apply]; exact (hswap x).symm
  conv_lhs => rw [hfull]
  rw [← Finset.sum_filter_add_sum_filter_not Finset.univ (fun x : ι × ι => x.1 < x.2), hnot]
  rw [← two_smul ℝ, smul_smul]; norm_num

theorem isSkew_sub {A B : Matrix ι ι ℝ} (hA : IsSkew A) (hB : IsSkew B) : IsSkew (A - B) := by
  unfold IsSkew at *; rw [Matrix.transpose_sub, hA, hB]; abel
theorem isSkew_add {A B : Matrix ι ι ℝ} (hA : IsSkew A) (hB : IsSkew B) : IsSkew (A + B) := by
  unfold IsSkew at *; rw [Matrix.transpose_add, hA, hB]; abel
theorem isSkew_smul (c : ℝ) {A : Matrix ι ι ℝ} (hA : IsSkew A) : IsSkew (c • A) := by
  unfold IsSkew at *; rw [Matrix.transpose_smul, hA, smul_neg]

theorem pairSlot_isSkew (c d : Fin k) (x y : ι) : IsSkew (pairSlot N c d x y) := by
  unfold pairSlot
  split_ifs <;> simp only [S1, S2, S3, S4] <;>
    first
    | exact isSkew_sub (phi_isSkew _ _) (phi_isSkew _ _)
    | exact isSkew_add (phi_isSkew _ _) (phi_isSkew _ _)

/-- **Every slot is skew.** -/
theorem slotφ_isSkew (ij : {x : ι × ι // x.1 < x.2}) : IsSkew (slotφ N ij) := by
  unfold slotφ
  split
  · split_ifs
    · exact phi_isSkew _ _
    · exact isSkew_smul _ (pairSlot_isSkew N _ _ _ _)
    · exact isSkew_smul _ (pairSlot_isSkew N _ _ _ _)
  · exact phi_isSkew _ _

set_option maxHeartbeats 800000 in
/-- **Completeness: the slot family expands every skew matrix.** -/
theorem slot_complete (Y : Matrix ι ι ℝ) (hY : IsSkew Y) :
    Y = ∑ ij, inner2 (slotφ N ij) Y • slotφ N ij := by
  have hb : ∀ k l, KyFanPackaging.inner2Form (slotφ N k) (slotφ N l) = if k = l then 1 else 0 := by
    intro k l; rw [KyFanPackaging.inner2Form_apply]; exact slot_orthonormal N k l
  have hexp : ∀ y, IsSkew y →
      y = ∑ ij : {x : ι × ι // x.1 < x.2},
        KyFanPackaging.inner2Form (phi ij.1.1 ij.1.2) y • phi ij.1.1 ij.1.2 := by
    intro y hy
    simp only [KyFanPackaging.inner2Form_apply]
    exact phi_expand_ordered y hy
  have h := transfer_expansion (E := Matrix ι ι ℝ) (κ := {x : ι × ι // x.1 < x.2})
    KyFanPackaging.inner2Form (fun ij => phi ij.1.1 ij.1.2) (slotφ N) hb IsSkew hexp
    (slotφ_isSkew N) Y hY
  simp only [KyFanPackaging.inner2Form_apply] at h
  exact h

theorem negAdSq_slot (ij : {x : ι × ι // x.1 < x.2}) :
    KyFanPackaging.negAdSq N.X (slotφ N ij) = slotμ N ij • slotφ N ij :=
  slot_eigen N ij

/-- **L240 piece (b): Ky Fan at a general normal form.** For orthonormal skew `y₁,…,y_r`,
`∑ⱼ ⟨yⱼ, -ad_X² yⱼ⟩ ≤ r·c + ∑ₖ max(μₖ − c, 0)` over the slot eigenvalues `μ = slotμ`. -/
theorem slot_kyFan {r : ℕ} (y : Fin r → Matrix ι ι ℝ) (hyS : ∀ j, IsSkew (y j))
    (hy : ∀ i j, inner2 (y i) (y j) = if i = j then 1 else 0) (c : ℝ) :
    ∑ j, inner2 (y j) (-br N.X (br N.X (y j))) ≤ r * c + ∑ ij, max (slotμ N ij - c) 0 := by
  have hb : ∀ k l, KyFanPackaging.inner2Form (slotφ N k) (slotφ N l) = if k = l then 1 else 0 := by
    intro k l; rw [KyFanPackaging.inner2Form_apply]; exact slot_orthonormal N k l
  have hy' : ∀ i j, KyFanPackaging.inner2Form (y i) (y j) = if i = j then 1 else 0 := by
    intro i j; rw [KyFanPackaging.inner2Form_apply]; exact hy i j
  have hspan : ∀ j, y j = ∑ k, KyFanPackaging.inner2Form (slotφ N k) (y j) • slotφ N k := by
    intro j; simp only [KyFanPackaging.inner2Form_apply]; exact slot_complete N (y j) (hyS j)
  have h := HamiltonsCubic.Results.kyFan_eigen KyFanPackaging.inner2Form
    (fun x y => KyFanPackaging.inner2Form_symm x y) (fun x => KyFanPackaging.inner2Form_pos x)
    (slotφ N) hb (KyFanPackaging.negAdSq N.X) (slotμ N) (negAdSq_slot N) y hy' hspan c
  have e : ∀ Z, KyFanPackaging.negAdSq N.X Z = -br N.X (br N.X Z) := fun Z => rfl
  simpa only [KyFanPackaging.inner2Form_apply, e] using h

end step9c

end HamiltonsCubic.L240SlotBasis
