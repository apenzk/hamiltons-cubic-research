# Brief, round L94

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the statement as the findings file carries it ([findings/bispectral.md](../findings/bispectral.md) line 217, the heading of its block)

#### Lemma L94, $\kappa^2\le2\lVert M\rVert_F^2$, with equality exactly when $W$ is coordinate-diagonal in some frame

*Location facts, so the items are answerable: the block under this heading is one further paragraph, which records a review and writes no proof; **[results.md](../results.md) carries no canonical entry for L94**.*

## Passage B, a per-frame statement and proof on file in the same file ([findings/bispectral.md](../findings/bispectral.md) lines 480, 484 and 493, inside the block of another lemma)

**Statement.** Let $W\in\mathrm{Weyl}_n$, $n\ge4$, act on $\Lambda^2$ as $M$ with $\lVert M\rVert_F=1$ and spectrum $\mu$, and let $\mathring W$ be its curvature operator of the second kind on $S^2_0$ in Li's convention, with spectrum $\omega$. Fix a frame $F$, let $K=K(F)$, $K_{ab}=W_{abab}$, and $t_F=\sum_{a\ne b}K_{ab}^2$. Take the orthonormal basis $\{\varphi_{ab}\}_{a<b}\cup\{\psi_k\}_{k<n}$ of $S^2_0$ with $\varphi_{ab}=(e_a\odot e_b)/\sqrt2$ and $\psi_k=\operatorname{diag}(v_k)$ for an orthonormal **eigenbasis** $\{v_k\}$ of $K$ on $\mathbf1^\perp$, and let $d_\varphi$, $d_\psi$, $d=(d_\varphi,d_\psi)$ be the diagonal entries of $M$ in the pair basis $\{e_a\wedge e_b\}$ and of $\mathring W$ in this basis. Then:

3. $t_F\le2$, with equality exactly when $W$ is coordinate-diagonal in $F$.

*(3)* $t_F=2\sum_{a<b}M_{(ab),(ab)}^2\le2\lVert M\rVert_F^2=2$, with equality exactly when every off-diagonal entry of $M$ in the pair basis of $F$ vanishes, which is $W$ coordinate-diagonal in $F$. *[Lemma L94](../findings/bispectral.md#lemma-l94-kappa2le2lvert-mrvert_f2-with-equality-exactly-when-w-is-coordinate-diagonal-in-some-frame) is the maximum of this over frames.*

## Passage C, the Lean statement and proof ([lean/HamiltonsCubic/Results/L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean), whole file, 470 lines)

```lean
import Mathlib

set_option linter.style.longLine false

/-!
# L94, `κ² ≤ 2‖M‖_F²`, with equality exactly at coordinate-diagonal

## The record's statement, quoted verbatim from [bispectral.md](../../../findings/bispectral.md)

> **Gate 2 landed, Reviewers 101 and 102, agreeing.** $\kappa(W):=\max_F\lVert K(F)\rVert_F$ over
> orthonormal frames is $O(n)$-invariant, satisfies $\kappa^2\le2\lVert M\rVert_F^2$, *the norm
> must be $\lVert M\rVert_F$, not the $4$-tensor norm, or the bound is slack by a factor $4$*,
> with equality **iff $W$ is coordinate-diagonal in some frame**, which both reviewers proved in
> one line.

## How the statement is set up here

`W` is an algebraic curvature tensor on `ℝⁿ` written in coordinates, with the two antisymmetries,
pair symmetry, the first Bianchi identity and tracelessness, the last being what makes it a *Weyl*
tensor rather than a general curvature tensor. A frame is an orthonormal matrix `R`, `rotate R W`
is `W` read in that frame, and `K(R)ₐb = (rotate R W) a b a b` is the sectional-curvature matrix
the record's `κ` maximises over.

**`‖M‖_F` is the norm of the curvature *operator* on `Λ²`**, so it sums `W a b c d ^ 2` over
`a < b` and `c < d`, one term per pair of `2`-forms. `normM2` is written that way rather than as a
quarter of the `4`-tensor sum, which is the record's norm-choice warning built into the definition
instead of stated beside it.

`kappaSq` is `κ²` as the record defines it, a supremum over frames; `kappaSq_le_of_forall` shows the
frame-wise bound gives the `κ` form, the frame set being nonempty because the identity is a frame.

## The proof

**`kappa_sq_le_and_equality` is proved, with no `sorry`, and it uses only the two antisymmetries**:
pair symmetry, Bianchi and tracelessness are carried in `IsWeyl` and not consumed.

* **Invariance.** `normM2` is a quarter of the full `4`-tensor sum (`normM2_quarter`), and that sum
  is unchanged by a frame acting one slot at a time (`full4_rotate`), each slot being an orthogonal
  map on vectors (`norm_preserved`, from rows orthonormal giving columns orthonormal).
* **The bound.** In the frame, `‖K‖_F² = 2 Σ_{a<b} W'_{abab}²` (`frobK_eq`), the diagonal of the
  operator on `Λ²`, and that is at most `‖M‖_F²` of the rotated tensor (`diag_le_normM2`).
* **The equality case.** `normM2` splits into the diagonal plus the off-diagonal pair sum
  (`normM2_split`); equality kills every off-diagonal term, which is coordinate-diagonality in that
  frame (`coordDiag_of_offDiag_zero`), and conversely.

The equality clause is stated as `(∃ frame attaining) ↔ (∃ frame in which W is coordinate-diagonal)`,
so the attainment of the record's `max` by compactness of the frame group is not needed here and is
not typed.
-/

namespace HamiltonsCubic.L94Statement

open Finset Matrix

variable {n : ℕ}

/-! ## The objects -/

/-- A `4`-tensor on `ℝⁿ` in coordinates. -/
abbrev Tensor4 (n : ℕ) := Fin n → Fin n → Fin n → Fin n → ℝ

/-- An **algebraic curvature tensor**: antisymmetric in each pair, symmetric under pair exchange,
and satisfying the first Bianchi identity. -/
structure IsAlgCurv (W : Tensor4 n) : Prop where
  antisym12 : ∀ a b c d, W a b c d = -W b a c d
  antisym34 : ∀ a b c d, W a b c d = -W a b d c
  pairSym : ∀ a b c d, W a b c d = W c d a b
  bianchi : ∀ a b c d, W a b c d + W a c d b + W a d b c = 0

/-- A **Weyl tensor**: an algebraic curvature tensor whose Ricci contraction vanishes. -/
structure IsWeyl (W : Tensor4 n) : Prop extends IsAlgCurv W where
  traceless : ∀ b d, ∑ a, W a b a d = 0

/-- An **orthonormal frame**, as the rows of an orthogonal matrix. -/
def IsFrame (R : Fin n → Fin n → ℝ) : Prop :=
  ∀ a b, ∑ i, R a i * R b i = if a = b then 1 else 0

/-- `W` read in the frame `R`. -/
def rotate (R : Fin n → Fin n → ℝ) (W : Tensor4 n) : Tensor4 n :=
  fun a b c d => ∑ i, ∑ j, ∑ k, ∑ l, R a i * R b j * R c k * R d l * W i j k l

/-- `‖K(R)‖_F²`, the squared Frobenius norm of the sectional-curvature matrix
`K(R)ₐb = W(eₐ, e_b, eₐ, e_b)` in the frame `R`. -/
def frobK (R : Fin n → Fin n → ℝ) (W : Tensor4 n) : ℝ :=
  ∑ a, ∑ b, (rotate R W a b a b) ^ 2

/-- `‖M‖_F²`, the squared Frobenius norm of the curvature **operator** on `Λ²`, one term per
ordered pair of `2`-forms, which is the norm the record's warning insists on. -/
def normM2 (W : Tensor4 n) : ℝ :=
  ∑ a, ∑ b, ∑ c, ∑ d, if a < b ∧ c < d then W a b c d ^ 2 else 0

/-- `W` is **coordinate-diagonal**: every component vanishes except those whose index pairs
coincide as sets, so the only surviving components are the sectional curvatures. -/
def CoordinateDiagonal (W : Tensor4 n) : Prop :=
  ∀ a b c d, ¬((a = c ∧ b = d) ∨ (a = d ∧ b = c)) → W a b c d = 0

/-- `κ²(W) = max_F ‖K(F)‖_F²`, written as a supremum over frames. -/
noncomputable def kappaSq (W : Tensor4 n) : ℝ :=
  sSup {c : ℝ | ∃ R : Fin n → Fin n → ℝ, IsFrame R ∧ c = frobK R W}

/-! ## The frame set is nonempty -/

/-- **The identity is a frame**, so `kappaSq` is a supremum of a nonempty set. -/
theorem isFrame_id : IsFrame (n := n) (fun a i => if a = i then (1 : ℝ) else 0) := by
  intro a b
  by_cases h : a = b
  · subst h; simp
  · rw [if_neg h]
    refine Finset.sum_eq_zero fun i _ => ?_
    simp only []
    by_cases h1 : a = i
    · have h2 : ¬ (b = i) := by rintro rfl; exact h h1
      simp [h1, h2]
    · simp [h1]

/-- **The frame-wise bound gives the `κ` form.** `κ²` being a supremum over a nonempty set, a bound
holding at every frame bounds it. -/
theorem kappaSq_le_of_forall (W : Tensor4 n) {B : ℝ}
    (h : ∀ R : Fin n → Fin n → ℝ, IsFrame R → frobK R W ≤ B) : kappaSq W ≤ B := by
  refine csSup_le ⟨frobK (fun a i => if a = i then (1 : ℝ) else 0) W,
    ⟨_, isFrame_id, rfl⟩⟩ ?_
  rintro c ⟨R, hR, rfl⟩
  exact h R hR

/-- The full `4`-tensor sum of squares. -/
def full4 (W : Tensor4 n) : ℝ := ∑ a, ∑ b, ∑ c, ∑ d, W a b c d ^ 2

/-- Rows orthonormal gives columns orthonormal, for a square matrix. -/
theorem cols_of_rows (R : Fin n → Fin n → ℝ) (hR : IsFrame R) (i j : Fin n) :
    ∑ a, R a i * R a j = if i = j then 1 else 0 := by
  have h1 : (Matrix.of R) * (Matrix.of R)ᵀ = 1 := by
    ext a b
    simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.of_apply, Matrix.one_apply]
    exact hR a b
  have h2 : (Matrix.of R)ᵀ * (Matrix.of R) = 1 := mul_eq_one_comm.mp h1
  have := congrFun (congrFun h2 i) j
  simpa [Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply] using this

/-- An orthonormal frame preserves the squared norm of a vector. -/
theorem norm_preserved (R : Fin n → Fin n → ℝ) (hR : IsFrame R) (x : Fin n → ℝ) :
    ∑ a, (∑ i, R a i * x i) ^ 2 = ∑ i, x i ^ 2 := by
  have hc := cols_of_rows R hR
  calc ∑ a, (∑ i, R a i * x i) ^ 2
      = ∑ a, ∑ i, ∑ j, (R a i * R a j) * (x i * x j) := by
        refine Finset.sum_congr rfl fun a _ => ?_
        rw [sq, Finset.sum_mul_sum]
        refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
        ring
    _ = ∑ i, ∑ j, (∑ a, R a i * R a j) * (x i * x j) := by
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun i _ => ?_
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [Finset.sum_mul]
    _ = ∑ i, x i ^ 2 := by
        simp only [hc]
        refine Finset.sum_congr rfl fun i _ => ?_
        simp [sq]

/-! ## Reordering four-fold sums -/

theorem move_in4 (G : Fin n → Fin n → Fin n → Fin n → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, G a b c d = ∑ b, ∑ c, ∑ d, ∑ a, G a b c d := by
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [Finset.sum_comm]

theorem move_in3 (G : Fin n → Fin n → Fin n → ℝ) :
    ∑ b, ∑ c, ∑ d, G b c d = ∑ c, ∑ d, ∑ b, G b c d := by
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [Finset.sum_comm]

theorem move_in2 (G : Fin n → Fin n → ℝ) :
    ∑ c, ∑ d, G c d = ∑ d, ∑ c, G c d := Finset.sum_comm

/-! ## One slot at a time -/

def rot1 (R : Fin n → Fin n → ℝ) (W : Tensor4 n) : Tensor4 n := fun a b c d => ∑ i, R a i * W i b c d
def rot2 (R : Fin n → Fin n → ℝ) (W : Tensor4 n) : Tensor4 n := fun a b c d => ∑ i, R b i * W a i c d
def rot3 (R : Fin n → Fin n → ℝ) (W : Tensor4 n) : Tensor4 n := fun a b c d => ∑ i, R c i * W a b i d
def rot4 (R : Fin n → Fin n → ℝ) (W : Tensor4 n) : Tensor4 n := fun a b c d => ∑ i, R d i * W a b c i

theorem full4_rot1 (R) (hR : IsFrame R) (W : Tensor4 n) : full4 (rot1 R W) = full4 W := by
  unfold full4 rot1
  rw [move_in4, move_in4 (fun a b c d => W a b c d ^ 2)]
  exact Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ =>
    Finset.sum_congr rfl fun d _ => norm_preserved R hR (fun i => W i b c d)

theorem full4_rot2 (R) (hR : IsFrame R) (W : Tensor4 n) : full4 (rot2 R W) = full4 W := by
  unfold full4 rot2
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [move_in3, move_in3 (fun b c d => W a b c d ^ 2)]
  exact Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ =>
    norm_preserved R hR (fun i => W a i c d)

theorem full4_rot3 (R) (hR : IsFrame R) (W : Tensor4 n) : full4 (rot3 R W) = full4 W := by
  unfold full4 rot3
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
  rw [move_in2, move_in2 (fun c d => W a b c d ^ 2)]
  exact Finset.sum_congr rfl fun d _ => norm_preserved R hR (fun i => W a b i d)

theorem full4_rot4 (R) (hR : IsFrame R) (W : Tensor4 n) : full4 (rot4 R W) = full4 W := by
  unfold full4 rot4
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun c _ => norm_preserved R hR (fun i => W a b c i)

theorem rotate_eq (R : Fin n → Fin n → ℝ) (W : Tensor4 n) :
    rotate R W = rot1 R (rot2 R (rot3 R (rot4 R W))) := by
  funext a b c d
  simp only [rotate, rot1, rot2, rot3, rot4, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  ring

theorem full4_rotate (R) (hR : IsFrame R) (W : Tensor4 n) : full4 (rotate R W) = full4 W := by
  rw [rotate_eq, full4_rot1 R hR, full4_rot2 R hR, full4_rot3 R hR, full4_rot4 R hR]

/-! ## Antisymmetry survives the rotation -/

theorem rotate_antisym12 (R : Fin n → Fin n → ℝ) (W : Tensor4 n) (hW : IsAlgCurv W) (a b c d : Fin n) :
    rotate R W a b c d = -rotate R W b a c d := by
  simp only [rotate, ← Finset.sum_neg_distrib]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  rw [hW.antisym12 j i k l]; ring

theorem rotate_antisym34 (R : Fin n → Fin n → ℝ) (W : Tensor4 n) (hW : IsAlgCurv W) (a b c d : Fin n) :
    rotate R W a b c d = -rotate R W a b d c := by
  simp only [rotate, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  rw [hW.antisym34 i j l k]; ring

/-! ## `‖M‖_F²` is a quarter of the full sum -/

theorem normM2_quarter (X : Tensor4 n) (h12 : ∀ a b c d, X a b c d = -X b a c d)
    (h34 : ∀ a b c d, X a b c d = -X a b d c) : 4 * normM2 X = full4 X := by
  have hz1 : ∀ a c d, X a a c d = 0 := fun a c d => by linarith [h12 a a c d]
  have hz2 : ∀ a b c, X a b c c = 0 := fun a b c => by linarith [h34 a b c c]
  have hpt : ∀ a b c d, X a b c d ^ 2 =
      (if a < b ∧ c < d then X a b c d ^ 2 else 0) + (if b < a ∧ c < d then X a b c d ^ 2 else 0)
      + (if a < b ∧ d < c then X a b c d ^ 2 else 0) + (if b < a ∧ d < c then X a b c d ^ 2 else 0) := by
    intro a b c d
    by_cases hab : a = b
    · subst hab; simp [hz1]
    by_cases hcd : c = d
    · subst hcd; simp [hz2]
    split_ifs <;> first | (exfalso; omega) | ring
  -- the four indicator sums are each normM2 X, by renaming and antisymmetry squared
  have s1 : ∑ a, ∑ b, ∑ c, ∑ d, (if b < a ∧ c < d then X a b c d ^ 2 else 0) = normM2 X := by
    unfold normM2
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
      Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
    rw [h12 b a c d]; simp only [neg_sq]
  have s2 : ∑ a, ∑ b, ∑ c, ∑ d, (if a < b ∧ d < c then X a b c d ^ 2 else 0) = normM2 X := by
    unfold normM2
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
    rw [h34 a b d c]; simp only [neg_sq]
  have s3 : ∑ a, ∑ b, ∑ c, ∑ d, (if b < a ∧ d < c then X a b c d ^ 2 else 0) = normM2 X := by
    rw [← s2]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
      Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
    rw [h12 b a c d]; simp only [neg_sq]
  unfold full4
  rw [Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => hpt a b c d]
  simp only [Finset.sum_add_distrib]
  rw [s1, s2, s3]
  unfold normM2
  ring

/-! ## The frame-wise bound -/

theorem frobK_eq (R : Fin n → Fin n → ℝ) (W : Tensor4 n) (hW : IsAlgCurv W) :
    frobK R W = 2 * ∑ a, ∑ b, (if a < b then rotate R W a b a b ^ 2 else 0) := by
  have hz : ∀ a, rotate R W a a a a = 0 := fun a => by linarith [rotate_antisym12 R W hW a a a a]
  have hsym : ∀ a b, rotate R W b a b a = rotate R W a b a b := fun a b => by
    rw [rotate_antisym12 R W hW b a b a, rotate_antisym34 R W hW a b b a]; ring
  have hpt : ∀ a b, rotate R W a b a b ^ 2 = (if a < b then rotate R W a b a b ^ 2 else 0)
      + (if b < a then rotate R W a b a b ^ 2 else 0) := by
    intro a b
    by_cases h : a = b
    · subst h; simp [hz]
    split_ifs <;> first | (exfalso; omega) | ring
  have hswap : ∑ a, ∑ b, (if b < a then rotate R W a b a b ^ 2 else 0)
      = ∑ a, ∑ b, (if a < b then rotate R W a b a b ^ 2 else 0) := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [hsym a b]
  unfold frobK
  rw [Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => hpt a b]
  simp only [Finset.sum_add_distrib]
  rw [hswap]; ring

theorem diag_le_normM2 (X : Tensor4 n) :
    ∑ a, ∑ b, (if a < b then X a b a b ^ 2 else 0) ≤ normM2 X := by
  unfold normM2
  refine Finset.sum_le_sum fun a _ => Finset.sum_le_sum fun b _ => ?_
  by_cases hab : a < b
  · rw [if_pos hab]
    have hsingle : (∑ d, if a < b ∧ a < d then X a b a d ^ 2 else 0)
        ≤ ∑ c, ∑ d, if a < b ∧ c < d then X a b c d ^ 2 else 0 :=
      Finset.single_le_sum (f := fun c => ∑ d, if a < b ∧ c < d then X a b c d ^ 2 else 0)
        (fun c _ => Finset.sum_nonneg fun d _ => by split_ifs <;> positivity) (Finset.mem_univ a)
    have hsingle2 : (if a < b ∧ a < b then X a b a b ^ 2 else 0)
        ≤ ∑ d, if a < b ∧ a < d then X a b a d ^ 2 else 0 :=
      Finset.single_le_sum (f := fun d => if a < b ∧ a < d then X a b a d ^ 2 else 0)
        (fun d _ => by split_ifs <;> positivity) (Finset.mem_univ b)
    rw [if_pos ⟨hab, hab⟩] at hsingle2
    linarith
  · rw [if_neg hab]
    exact Finset.sum_nonneg fun c _ => Finset.sum_nonneg fun d _ => by split_ifs <;> positivity

theorem frame_bound (R : Fin n → Fin n → ℝ) (hR : IsFrame R) (W : Tensor4 n) (hW : IsAlgCurv W) :
    frobK R W ≤ 2 * normM2 W := by
  have h1 := frobK_eq R W hW
  have h2 := diag_le_normM2 (rotate R W)
  have h3 := normM2_quarter (rotate R W) (rotate_antisym12 R W hW) (rotate_antisym34 R W hW)
  have h4 := normM2_quarter W hW.antisym12 hW.antisym34
  have h5 := full4_rotate R hR W
  nlinarith

/-! ## The equality case -/

theorem normM2_split (X : Tensor4 n) :
    normM2 X = (∑ a, ∑ b, (if a < b then X a b a b ^ 2 else 0))
      + ∑ a, ∑ b, ∑ c, ∑ d, (if a < b ∧ c < d ∧ ¬(c = a ∧ d = b) then X a b c d ^ 2 else 0) := by
  have hpt : ∀ a b c d, (if a < b ∧ c < d then X a b c d ^ 2 else 0)
      = (if a < b ∧ c < d ∧ (c = a ∧ d = b) then X a b c d ^ 2 else 0)
        + (if a < b ∧ c < d ∧ ¬(c = a ∧ d = b) then X a b c d ^ 2 else 0) := by
    intro a b c d
    by_cases h : c = a ∧ d = b
    · simp [h]
    · simp [h]
  have hdiag : ∀ a b, (∑ c, ∑ d, (if a < b ∧ c < d ∧ (c = a ∧ d = b) then X a b c d ^ 2 else 0))
      = if a < b then X a b a b ^ 2 else 0 := by
    intro a b
    by_cases hab : a < b
    · rw [if_pos hab]
      rw [Finset.sum_eq_single a]
      · rw [Finset.sum_eq_single b]
        · simp [hab]
        · intro d _ hd; simp [hd]
        · simp
      · intro c _ hc
        exact Finset.sum_eq_zero fun d _ => by simp [hc]
      · simp
    · rw [if_neg hab]
      exact Finset.sum_eq_zero fun c _ => Finset.sum_eq_zero fun d _ => by simp [hab]
  unfold normM2
  rw [Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => hpt a b c d]
  simp only [Finset.sum_add_distrib]
  rw [Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => hdiag a b]

theorem coordDiag_of_offDiag_zero (X : Tensor4 n) (h12 : ∀ a b c d, X a b c d = -X b a c d)
    (h34 : ∀ a b c d, X a b c d = -X a b d c)
    (hoff : ∀ a b c d, a < b → c < d → ¬(c = a ∧ d = b) → X a b c d = 0) :
    CoordinateDiagonal X := by
  intro a b c d hnot
  rcases lt_trichotomy a b with hab | hab | hab <;> rcases lt_trichotomy c d with hcd | hcd | hcd
  · exact hoff a b c d hab hcd (fun h => hnot (Or.inl ⟨h.1.symm, h.2.symm⟩))
  · subst hcd; linarith [h34 a b c c]
  · rw [h34]; rw [hoff a b d c hab hcd (fun h => hnot (Or.inr ⟨h.1.symm, h.2.symm⟩))]; simp
  · subst hab; linarith [h12 a a c d]
  · subst hab; linarith [h12 a a c d]
  · subst hab; linarith [h12 a a c d]
  · rw [h12]; rw [hoff b a c d hab hcd (fun h => hnot (Or.inr ⟨h.2.symm, h.1.symm⟩))]; simp
  · subst hcd; linarith [h34 a b c c]
  · rw [h12, h34]; rw [hoff b a d c hab hcd (fun h => hnot (Or.inl ⟨h.2.symm, h.1.symm⟩))]; simp

theorem equality_iff (W : Tensor4 n) (hW : IsAlgCurv W) :
    (∃ R : Fin n → Fin n → ℝ, IsFrame R ∧ frobK R W = 2 * normM2 W) ↔
      ∃ R : Fin n → Fin n → ℝ, IsFrame R ∧ CoordinateDiagonal (rotate R W) := by
  have key : ∀ R, IsFrame R → normM2 (rotate R W) = normM2 W := fun R hR => by
    have h3 := normM2_quarter (rotate R W) (rotate_antisym12 R W hW) (rotate_antisym34 R W hW)
    have h4 := normM2_quarter W hW.antisym12 hW.antisym34
    have h5 := full4_rotate R hR W
    linarith
  constructor
  · rintro ⟨R, hR, heq⟩
    refine ⟨R, hR, ?_⟩
    set X := rotate R W with hX
    have hsplit := normM2_split X
    have hfrob := frobK_eq R W hW
    have hk := key R hR
    have hoffsum : (∑ a, ∑ b, ∑ c, ∑ d,
        (if a < b ∧ c < d ∧ ¬(c = a ∧ d = b) then X a b c d ^ 2 else 0)) = 0 := by
      rw [← hX] at hfrob; linarith
    have hnn : ∀ a b c d, 0 ≤ (if a < b ∧ c < d ∧ ¬(c = a ∧ d = b) then X a b c d ^ 2 else 0) :=
      fun a b c d => by split_ifs <;> positivity
    refine coordDiag_of_offDiag_zero X (rotate_antisym12 R W hW) (rotate_antisym34 R W hW) ?_
    intro a b c d hab hcd hne
    have h1 := (Finset.sum_eq_zero_iff_of_nonneg fun a _ =>
      Finset.sum_nonneg fun b _ => Finset.sum_nonneg fun c _ => Finset.sum_nonneg fun d _ =>
        hnn a b c d).mp hoffsum a (Finset.mem_univ a)
    have h2 := (Finset.sum_eq_zero_iff_of_nonneg fun b _ =>
      Finset.sum_nonneg fun c _ => Finset.sum_nonneg fun d _ => hnn a b c d).mp h1 b (Finset.mem_univ b)
    have h3 := (Finset.sum_eq_zero_iff_of_nonneg fun c _ =>
      Finset.sum_nonneg fun d _ => hnn a b c d).mp h2 c (Finset.mem_univ c)
    have h4 := (Finset.sum_eq_zero_iff_of_nonneg fun d _ => hnn a b c d).mp h3 d (Finset.mem_univ d)
    rw [if_pos ⟨hab, hcd, hne⟩] at h4
    exact pow_eq_zero_iff (two_ne_zero) |>.mp h4
  · rintro ⟨R, hR, hdiag⟩
    refine ⟨R, hR, ?_⟩
    set X := rotate R W with hX
    have hsplit := normM2_split X
    have hfrob := frobK_eq R W hW
    have hk := key R hR
    have hoffsum : (∑ a, ∑ b, ∑ c, ∑ d,
        (if a < b ∧ c < d ∧ ¬(c = a ∧ d = b) then X a b c d ^ 2 else 0)) = 0 := by
      refine Finset.sum_eq_zero fun a _ => Finset.sum_eq_zero fun b _ =>
        Finset.sum_eq_zero fun c _ => Finset.sum_eq_zero fun d _ => ?_
      split_ifs with h
      · obtain ⟨hab, hcd, hne⟩ := h
        have : X a b c d = 0 := hdiag a b c d (by
          rintro (⟨rfl, rfl⟩ | ⟨rfl, rfl⟩)
          · exact hne ⟨rfl, rfl⟩
          · exact absurd (hab.trans hcd) (lt_irrefl _))
        simp [this]
      · rfl
    rw [← hX] at hfrob
    linarith

/-! ## The lemma -/

/-- **L94, in full.** For a Weyl tensor `W`:

* `‖K(R)‖_F² ≤ 2‖M‖_F²` at every orthonormal frame `R`, which is `κ² ≤ 2‖M‖_F²` through
  `kappaSq_le_of_forall`; and
* the bound is **attained at some frame iff `W` is coordinate-diagonal in some frame**.

*Proved from the frame-wise bound and the split of `‖M‖_F²` into diagonal and off-diagonal parts.* -/
theorem kappa_sq_le_and_equality (W : Tensor4 n) (hW : IsWeyl W) :
    (∀ R : Fin n → Fin n → ℝ, IsFrame R → frobK R W ≤ 2 * normM2 W) ∧
      ((∃ R : Fin n → Fin n → ℝ, IsFrame R ∧ frobK R W = 2 * normM2 W) ↔
        ∃ R : Fin n → Fin n → ℝ, IsFrame R ∧ CoordinateDiagonal (rotate R W)) :=
  ⟨fun R hR => frame_bound R hR W hW.toIsAlgCurv, equality_iff W hW.toIsAlgCurv⟩

/-- **The `κ` form of the first half**, once the lemma is in hand. -/
theorem kappaSq_le (W : Tensor4 n) (hW : IsWeyl W) : kappaSq W ≤ 2 * normM2 W :=
  kappaSq_le_of_forall W (kappa_sq_le_and_equality W hW).1

/-! ## The hypotheses are not empty -/

/-- The zero tensor is a Weyl tensor, so `IsWeyl` is inhabited at every `n`. -/
example : IsWeyl (fun _ _ _ _ => (0 : ℝ) : Tensor4 n) where
  antisym12 := by intros; norm_num
  antisym34 := by intros; norm_num
  pairSym := by intros; rfl
  bianchi := by intros; norm_num
  traceless := by intros; simp

/-- And it is coordinate-diagonal, so the equality clause's right-hand side is inhabited too,
consistently with `κ² = 0 = 2‖M‖_F²` there. -/
example : CoordinateDiagonal (fun _ _ _ _ => (0 : ℝ) : Tensor4 n) := fun _ _ _ _ _ => rfl

end HamiltonsCubic.L94Statement

#print axioms HamiltonsCubic.L94Statement.kappa_sq_le_and_equality

```

## Definitions

- $W\in\mathrm{Weyl}_n$ acts on $\Lambda^2\mathbb R^n$ as $M$; $\lVert M\rVert_F$ is the Frobenius norm of that operator in an orthonormal basis of $\Lambda^2$, one term per ordered pair of basis $2$-forms.
- A frame $F$ is an orthonormal basis of $\mathbb R^n$; $K(F)_{ab}=W(e_a,e_b,e_a,e_b)$; $t_F=\lVert K(F)\rVert_F^2=\sum_{a\ne b}K(F)_{ab}^2$; $\kappa(W)=\max_F\lVert K(F)\rVert_F$.
- $W$ is coordinate-diagonal in $F$ when its operator on $\Lambda^2$ is diagonal in the pair basis $\{e_a\wedge e_b\}_{a<b}$ of $F$.

## What to attack, beyond the standing list

1. **Whether any proof of Passage A is written in the findings file**, and whether Passage B supplies one: the per-frame bound, its equality case, and the passage from them to Passage A's $\kappa$ form.
2. **$\kappa$ as a maximum**: that it is attained, by what argument (compactness of the frame group, continuity of $F\mapsto t_F$), and that it is $O(n)$-invariant. *The direction "$\kappa^2=2\lVert M\rVert_F^2\Rightarrow W$ coordinate-diagonal in some frame" needs a frame attaining the maximum; say whether that is argued anywhere quoted.*
3. **The norm and the pair count**: that the bound holds with $\lVert M\rVert_F$ and the ordered-pair $t_F$, and what it becomes with the $4$-tensor norm or unordered pairs.
4. **Passage C against Passage A**: its `frobK` (all ordered $(a,b)$, $a=b$ included), `normM2` (ordered pairs of $2$-forms, $a<b$ and $c<d$), `kappaSq` as a supremum, the equality clause stated as existence of an attaining frame rather than as $\kappa^2=2\lVert M\rVert_F^2$, and which hypotheses of `IsWeyl` the proof uses.
5. **Passage B's scope**: its statement is for $n\ge4$ and $\lVert M\rVert_F=1$; whether the bound and equality case as Passage A states them need either.
6. The boundary: $n=2,3$ (where $\mathrm{Weyl}_n=0$), $W=0$, $n=4$.

