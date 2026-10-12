import HamiltonsCubic.Results.L131Sharp
import HamiltonsCubic.Results.FoxBridge
import HamiltonsCubic.Base.SharpDiag

set_option linter.style.longLine false

/-!
# L131's table on diagonal representatives: `·#I` has eigenvalues `-1`, `(n-4)/2`, `n-2`

[isotropy-cap.md](../../../findings/isotropy-cap.md), Lemma L131: `𝒜 = -2(·#I)`, and its consequence (i) is the table
of `·#I` on the three summands of the algebraic curvature operators, which the record does not print. On the
coordinate-diagonal representatives the table is a computation:

* **`sharpCross_diag`**: `(diagOp u) # (diagOp v)` acts on `φ_{ab}` by `½((uv)_{ab} + (vu)_{ab})`, from
  [SharpDiag.lean](../Base/SharpDiag.lean)'s `sharpOp_diagOp`;
* **`sharpCross_diag_id`**: `(diagOp u) # I` acts on `φ_{ab}` by `½(r_a + r_b) - u_{ab}`, with `r` the row sums of `u`,
  the identity agreeing with `diagOp (J - I)` on bivectors;
* **`eig_weyl`**, **`eig_ricci`**, **`eig_scalar`**: on a diagonal Weyl weight (`r = 0`) the eigenvalue is `-1`, on
  `u_{ab} = h_a + h_b` with `Σ h = 0` (the Kulkarni–Nomizu `h ∧ g`, the Ricci summand's diagonal representatives) it
  is `(n-4)/2`, and on `u = J - I` (the identity, the scalar summand) it is `n - 2`.

The fourth entry, `#I = 2` on `Λ⁴`, which has no diagonal representative, is [L131Four.lean](L131Four.lean)'s
`sharpCross_four_id` on the four-set representatives. The first-slot linearity of `#` and the lift of these entries
to every bivector are [L131Lin.lean](L131Lin.lean) and [L131Whole.lean](L131Whole.lean). *Not typed*: that the
four-set elements over `i < j < k < l` span `Λ⁴` (checked by hand); and that `S²₀` is spanned by the frame images of
its diagonal representatives `h ∧ g`, which is what carries its entry off the diagonal locus.
-/

namespace HamiltonsCubic.L131Diag

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`(diagOp u) # (diagOp v)` on `φ_{ab}`**. -/
theorem sharpCross_diag (u v : Matrix ι ι ℝ) (hu : ∀ p q, u p q = u q p) (hv : ∀ p q, v p q = v q p)
    (hhu : ∀ a, u a a = 0) (hhv : ∀ a, v a a = 0) (a b : ι) :
    sharpCross (diagOp u) (diagOp v) (phi a b) = ((1 / 2) * ((u * v) a b + (v * u) a b)) • phi a b := by
  unfold sharpCross
  have hadd : diagOp u + diagOp v = diagOp (u + v) := by
    funext X; ext i j; simp [diagOp, add_mul]
  rw [hadd, sharpOp_diagOp (u + v) (fun p q => by simp [hu p q, hv p q]) (fun a => by simp [hhu a, hhv a]),
    sharpOp_diagOp u hu hhu, sharpOp_diagOp v hv hhv, ← sub_smul, ← sub_smul, smul_smul]
  congr 1
  simp only [add_mul, mul_add, Matrix.add_apply]
  ring

/-- The weight of the identity on bivectors: `1` off the diagonal. -/
def jw : Matrix ι ι ℝ := fun a b => if a = b then 0 else 1

omit [Fintype ι] in
theorem diagOp_jw_skew {X : Matrix ι ι ℝ} (hX : IsSkew X) : diagOp jw X = X := by
  ext a b
  simp only [diagOp, Matrix.of_apply, jw]
  split_ifs with h
  · subst h
    have := congrFun (congrFun hX a) a
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith
  · ring

/-- **`(diagOp u) # I` on `φ_{ab}`**: `½(r_a + r_b) - u_{ab}` with `r` the row sums. -/
theorem sharpCross_diag_id (u : Matrix ι ι ℝ) (hu : ∀ p q, u p q = u q p) (hhu : ∀ a, u a a = 0) (a b : ι) :
    sharpCross (diagOp u) (fun X => X) (phi a b)
      = ((1 / 2) * ((∑ c, u a c) + (∑ c, u b c)) - u a b) • phi a b := by
  have hjs : ∀ p q, (jw : Matrix ι ι ℝ) p q = jw q p := fun p q => by simp only [jw, eq_comm]
  have hjh : ∀ p, (jw : Matrix ι ι ℝ) p p = 0 := fun p => by simp [jw]
  -- on bivectors the identity is `diagOp jw`
  have hdskew : ∀ X, IsSkew X → IsSkew (diagOp u X) := fun X hX => by
    unfold IsSkew diagOp; ext i j
    have := congrFun (congrFun hX i) j
    simp only [Matrix.transpose_apply, Matrix.neg_apply, Matrix.of_apply] at this ⊢
    rw [hu j i, this]; ring
  have hcongr : sharpCross (diagOp u) (fun X => X) (phi a b) = sharpCross (diagOp u) (diagOp jw) (phi a b) := by
    unfold sharpCross
    have hskew : ∀ X, IsSkew X → IsSkew ((diagOp u + (fun X => X) : Matrix ι ι ℝ → Matrix ι ι ℝ) X) := fun X hX => by
      have h1 := hdskew X hX
      show IsSkew (diagOp u X + X)
      unfold IsSkew at h1 hX ⊢; rw [Matrix.transpose_add, h1, hX]; abel
    have e1 : sharpOp (diagOp u + (fun X => X) : Matrix ι ι ℝ → Matrix ι ι ℝ) (phi a b)
        = sharpOp (diagOp u + diagOp jw) (phi a b) :=
      HamiltonsCubic.TensorBridge.sharpOp_congr_on_skew hskew
        (fun X hX => by change diagOp u X + X = diagOp u X + diagOp jw X; rw [diagOp_jw_skew hX]) _ (phi_isSkew a b)
    have e2 : sharpOp (fun X : Matrix ι ι ℝ => X) (phi a b) = sharpOp (diagOp jw) (phi a b) :=
      HamiltonsCubic.TensorBridge.sharpOp_congr_on_skew (fun X hX => hX)
        (fun X hX => (diagOp_jw_skew hX).symm) _ (phi_isSkew a b)
    rw [e1, e2]
  rw [hcongr, sharpCross_diag u jw hu hjs hhu hjh]
  congr 1
  have h1 : (u * (jw : Matrix ι ι ℝ)) a b = (∑ c, u a c) - u a b := by
    simp only [Matrix.mul_apply, jw, mul_ite, mul_zero, mul_one]
    rw [Finset.sum_ite, Finset.sum_const_zero, zero_add, Finset.filter_ne' , Finset.sum_erase_eq_sub (Finset.mem_univ b)]
  have h2 : ((jw : Matrix ι ι ℝ) * u) a b = (∑ c, u b c) - u a b := by
    simp only [Matrix.mul_apply, jw, ite_mul, zero_mul, one_mul]
    rw [Finset.sum_ite, Finset.sum_const_zero, zero_add, Finset.filter_ne, Finset.sum_erase_eq_sub (Finset.mem_univ a)]
    rw [show (∑ c, u c b) = ∑ c, u b c from Finset.sum_congr rfl fun c _ => hu c b, hu a b]
  rw [h1, h2]; ring

/-- **The Weyl summand, eigenvalue `-1`**: at a diagonal weight with zero row sums, `(diagOp u) # I = -diagOp u` on
`φ_{ab}`. -/
theorem eig_weyl (u : Matrix ι ι ℝ) (hu : ∀ p q, u p q = u q p) (hhu : ∀ a, u a a = 0) (hr : ∀ a, ∑ c, u a c = 0)
    (a b : ι) : sharpCross (diagOp u) (fun X => X) (phi a b) = (-1 : ℝ) • diagOp u (phi a b) := by
  rw [sharpCross_diag_id u hu hhu a b, hr a, hr b, diagOp_phi u hu, smul_smul]
  congr 1; ring

/-- The Kulkarni–Nomizu weight `(h ∧ g)_{ab} = h_a + h_b` off the diagonal. -/
def knw (h : ι → ℝ) : Matrix ι ι ℝ := fun a b => if a = b then 0 else h a + h b

/-- **The Ricci summand, eigenvalue `(n-4)/2`**: at `u = h ∧ g` with `Σ h = 0`, `(diagOp u) # I = ((n-4)/2) diagOp u`
on `φ_{ab}`. -/
theorem eig_ricci (h : ι → ℝ) (hsum : ∑ c, h c = 0) (a b : ι) :
    sharpCross (diagOp (knw h)) (fun X => X) (phi a b)
      = (((Fintype.card ι : ℝ) - 4) / 2) • diagOp (knw h) (phi a b) := by
  have hs : ∀ p q, knw h p q = knw h q p := fun p q => by
    unfold knw; by_cases hpq : p = q
    · subst hpq; rfl
    · rw [if_neg hpq, if_neg (Ne.symm hpq)]; ring
  have hh : ∀ p, knw h p p = 0 := fun p => by simp [knw]
  have hr : ∀ p, ∑ c, knw h p c = ((Fintype.card ι : ℝ) - 2) * h p := fun p => by
    have e : ∀ c, knw h p c = (h p + h c) - if p = c then h p + h c else 0 := fun c => by
      by_cases hpc : p = c
      · subst hpc; simp [knw]
      · simp [knw, hpc]
    have : ∑ c, knw h p c = ∑ c, (h p + h c) - (h p + h p) := by
      rw [Finset.sum_congr rfl (fun c _ => e c), Finset.sum_sub_distrib, Finset.sum_ite_eq]; simp
    rw [this, Finset.sum_add_distrib, hsum, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]; ring
  rw [sharpCross_diag_id _ hs hh a b, hr a, hr b, diagOp_phi _ hs, smul_smul]
  by_cases hab : a = b
  · subst hab; simp [phi]
  · congr 1; simp only [knw, if_neg hab]; ring

/-- **The scalar summand, eigenvalue `n - 2`**: `I # I = (n-2) I` on `φ_{ab}`, the identity being `diagOp jw` there. -/
theorem eig_scalar (a b : ι) :
    sharpCross (diagOp jw) (fun X => X) (phi a b) = ((Fintype.card ι : ℝ) - 2) • diagOp jw (phi a b) := by
  have hjs : ∀ p q, (jw : Matrix ι ι ℝ) p q = jw q p := fun p q => by simp only [jw, eq_comm]
  have hjh : ∀ p, (jw : Matrix ι ι ℝ) p p = 0 := fun p => by simp [jw]
  have hr : ∀ p, ∑ c, (jw : Matrix ι ι ℝ) p c = (Fintype.card ι : ℝ) - 1 := fun p => by
    have e : ∀ c, (jw : Matrix ι ι ℝ) p c = 1 - if p = c then 1 else 0 := fun c => by
      by_cases hpc : p = c
      · subst hpc; simp [jw]
      · simp [jw, hpc]
    rw [Finset.sum_congr rfl (fun c _ => e c), Finset.sum_sub_distrib, Finset.sum_ite_eq]; simp
  rw [sharpCross_diag_id jw hjs hjh a b, hr a, hr b, diagOp_phi jw hjs, smul_smul]
  by_cases hab : a = b
  · subst hab; simp [phi]
  · congr 1; simp only [jw, if_neg hab]; ring

end HamiltonsCubic.L131Diag
