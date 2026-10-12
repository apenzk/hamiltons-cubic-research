import Mathlib

set_option linter.style.longLine false

/-!
# L112, `λ` is a `-1/(n-2)`-eigenvector of a symmetric hollow doubly stochastic matrix

## The record's statement, quoted verbatim from [bounds.md](../../../findings/bounds.md)

> #### Lemma L112, $\lambda$ is a $-\tfrac1{n-2}$-eigenvector of a symmetric hollow doubly stochastic matrix, of which Lemma L73 is the one-index shadow

> Set $S_{ab}:=\sum_cT_{abc}$, symmetric, nonnegative, hollow. Then (A) makes its rows sum to
> $2(n-2)$ and (B) gives $S\lambda=-2\lambda$, so **the complete pair-level content of the row
> calculus is: $\lambda$ is a $-\tfrac1{n-2}$-eigenvector of a symmetric hollow doubly stochastic
> matrix.** *Lemma L73 is its one-index shadow, and a subset-sum family follows immediately and is
> unexplored.*

with the Gate 2 verdict, which confirms the lemma and refutes the sentence after it:

> **THE UNIFICATION CLAIM IS REFUTED, [r649] and [r650] on identical briefs, both REFUTING it,
> while both CONFIRM the lemma itself.** *The doubly stochastic statement is correct and was
> rebuilt cold in four lines; [Lemma L73](bounds.md) **is** genuinely its one-index shadow, the
> $k=1$ case of $-\lambda/(n-2)\prec\lambda$.*
>
> **THE "SO" IS A NON SEQUITUR: $\theta$ IS INVISIBLE TO THIS SYSTEM.** Relations (A) and (B), all
> the matrix is built from, **do not contain $\theta$**, so nothing derived from them can bound
> it.

and the shadow itself, from the same file:

> **LEMMA L73.** *At **every** $W\in\mathcal W_n$ (critical or not), the spectrum alone satisfies
> $-(n-2)\lambda_{\max}\le\lambda_a\le(n-2)\lvert\lambda_{\min}\rvert$ for every $a$*

## What is typed here

* `Smat` and `Smat_symm`, `Smat_nonneg`, `Smat_hollow`, the matrix `S_{ab} = ∑_c T_{abc}` built
  from the tensor, and the three structural properties the record reads off `T`.
* `hatS_doublyStochastic`, the normalised `Ŝ = S/(2(n-2))` is doubly stochastic **in Mathlib's
  own sense** (`Matrix.doublyStochastic`), from the row sums `2(n-2)` and the symmetry of `S`.
* `hatS_hollow`, and it is hollow.
* `hatS_eigenvector`, `Ŝ λ = -λ/(n-2)`, which is the lemma's headline.
* `L73_one_index_shadow`, `L73_abs_form`, the shadow, derived from the doubly stochastic
  structure alone: `-(n-2)λ_max ≤ λ_a ≤ (n-2)|λ_min|` for every `a`. *Criticality is in no
  hypothesis*, matching the record's "at every `W ∈ 𝒲ₙ`, critical or not".
* `witness`, a symmetric hollow doubly stochastic matrix with an eigenvector at `-1/(n-2)`,
  so the hypothesis set below is not empty.

Everything is proved; there is no `sorry`.

## What is NOT typed here

**Relations (A) and (B) are hypotheses, not theorems.** `∑_b S_{ab} = 2(n-2)` is the Killing-form
row marginal ([Lemma L153](../../../findings/bounds.md), and
[Böhm–Wilking](../../../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1 for the
second), and `S λ = -2λ` is Ricci-flatness with first Bianchi. Both are statements about the
tensor `T = c²` of a Weyl operator, and [WeylReal.lean](../Base/WeylReal.lean) carries no structure
constants and no `Λ²` eigenbasis, so neither can be stated against it, they enter as named
hypotheses on abstract data.

**The majorization statement `-λ/(n-2) ≺ λ` is not typed, only its `k = 1` case.** The record
identifies L73 as that case; the full majorization would need doubly stochastic matrices to be
connected to the majorization order, which is a separate development.

**The pair cap `Ŝ_{ab} ≤ 1/(n-2)` is not typed.** The record calls it this lemma's one
constructive consequence, but it does not follow from nonnegativity, symmetry, hollowness and the
row sums alone, a symmetric hollow doubly stochastic matrix can have an entry as large as `1`,
so whatever supplies it is not in the hypothesis set here.

**"`θ` is invisible to this system" is not typed.** It is a statement about which symbols occur in
the relations rather than about their solutions, and the file reflects it only by carrying no `θ`.
-/

namespace HamiltonsCubic.L112Statement

open Finset Matrix

variable {κ : Type*} [Fintype κ]

/-! ## The matrix `S`, and what `T` gives it -/

/-- `S_{ab} = ∑_c T_{abc}`. -/
def Smat (T : κ → κ → κ → ℝ) : Matrix κ κ ℝ := fun a b => ∑ c, T a b c

/-- **`S` is symmetric**, from the symmetry of `T` in its first two slots. -/
theorem Smat_symm {T : κ → κ → κ → ℝ} (hsym : ∀ a b c, T a b c = T b a c) :
    ∀ a b, Smat T a b = Smat T b a := by
  intro a b
  unfold Smat
  exact Finset.sum_congr rfl fun c _ => hsym a b c

/-- **`S` is nonnegative**, from `T ≥ 0`. -/
theorem Smat_nonneg {T : κ → κ → κ → ℝ} (hpos : ∀ a b c, 0 ≤ T a b c) :
    ∀ a b, 0 ≤ Smat T a b :=
  fun a b => Finset.sum_nonneg fun c _ => hpos a b c

/-- **`S` is hollow**, from `T` vanishing on repeated indices. -/
theorem Smat_hollow {T : κ → κ → κ → ℝ} (hrep : ∀ a c, T a a c = 0) :
    ∀ a, Smat T a a = 0 := by
  intro a
  unfold Smat
  simp [hrep]

/-! ## The normalised matrix is doubly stochastic, and `λ` is its `-1/(n-2)`-eigenvector -/

/-- `Ŝ = S / (2(n-2))`. -/
noncomputable def hatS (S : Matrix κ κ ℝ) (n : ℝ) : Matrix κ κ ℝ :=
  Matrix.of fun a b => S a b / (2 * (n - 2))

/-- **`Ŝ` IS DOUBLY STOCHASTIC**, in Mathlib's sense: nonnegative with all row and all column sums
equal to `1`. The column sums come from the symmetry of `S`, the row sums from relation (A). -/
theorem hatS_doublyStochastic [DecidableEq κ] {S : Matrix κ κ ℝ} {n : ℝ}
    (hn : 0 < n - 2)
    (hnonneg : ∀ a b, 0 ≤ S a b)
    (hsym : ∀ a b, S a b = S b a)
    (hrow : ∀ a, ∑ b, S a b = 2 * (n - 2)) :
    hatS S n ∈ doublyStochastic ℝ κ := by
  have h2 : (2 : ℝ) * (n - 2) ≠ 0 := by positivity
  rw [mem_doublyStochastic_iff_sum]
  refine ⟨fun a b => div_nonneg (hnonneg a b) (by positivity), fun a => ?_, fun b => ?_⟩
  · simp only [hatS, Matrix.of_apply]
    rw [← Finset.sum_div, hrow a, div_self h2]
  · simp only [hatS, Matrix.of_apply]
    rw [← Finset.sum_div]
    rw [Finset.sum_congr rfl fun a (_ : a ∈ Finset.univ) => hsym a b, hrow b, div_self h2]

omit [Fintype κ] in
/-- **`Ŝ` is hollow.** -/
theorem hatS_hollow {S : Matrix κ κ ℝ} {n : ℝ} (hhollow : ∀ a, S a a = 0) :
    ∀ a, hatS S n a a = 0 := by
  intro a; simp only [hatS, Matrix.of_apply, hhollow a]; simp

/-- **THE HEADLINE: `λ` is a `-1/(n-2)`-eigenvector of `Ŝ`**, from relation (B)'s `S λ = -2λ`. -/
theorem hatS_eigenvector {S : Matrix κ κ ℝ} {lam : κ → ℝ} {n : ℝ}
    (hn : 0 < n - 2)
    (heig : ∀ a, ∑ b, S a b * lam b = -2 * lam a) :
    ∀ a, ∑ b, hatS S n a b * lam b = -(1 / (n - 2)) * lam a := by
  intro a
  have h2 : (2 : ℝ) * (n - 2) ≠ 0 := by positivity
  have hne : (n : ℝ) - 2 ≠ 0 := ne_of_gt hn
  have hstep : ∀ b, hatS S n a b * lam b = (S a b * lam b) / (2 * (n - 2)) := by
    intro b; simp only [hatS, Matrix.of_apply]; ring
  rw [Finset.sum_congr rfl fun b _ => hstep b, ← Finset.sum_div, heig a]
  field_simp

/-! ## Lemma L73, the one-index shadow -/

/-- **LEMMA L73, DERIVED AS THE ONE-INDEX SHADOW.** Each entry of `Ŝλ` is an average of the
entries of `λ`, so `-λ_a/(n-2)` lies between `λ_min` and `λ_max`, which is
`-(n-2)λ_max ≤ λ_a ≤ -(n-2)λ_min`. *Neither criticality nor `θ` appears, matching the record's
quantifier: this holds at every `W ∈ 𝒲ₙ`.* -/
theorem L73_one_index_shadow {S : Matrix κ κ ℝ} {lam : κ → ℝ} {n lmin lmax : ℝ}
    (hnonneg : ∀ a b, 0 ≤ S a b)
    (hrow : ∀ a, ∑ b, S a b = 2 * (n - 2))
    (heig : ∀ a, ∑ b, S a b * lam b = -2 * lam a)
    (hmin : ∀ b, lmin ≤ lam b) (hmax : ∀ b, lam b ≤ lmax) :
    ∀ a, -((n - 2) * lmax) ≤ lam a ∧ lam a ≤ -((n - 2) * lmin) := by
  intro a
  have hlow : lmin * ∑ b, S a b ≤ ∑ b, S a b * lam b := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun b _ => by
      rw [mul_comm (S a b) (lam b)]
      exact mul_le_mul_of_nonneg_right (hmin b) (hnonneg a b)
  have hhigh : ∑ b, S a b * lam b ≤ lmax * ∑ b, S a b := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun b _ => by
      rw [mul_comm (S a b) (lam b)]
      exact mul_le_mul_of_nonneg_right (hmax b) (hnonneg a b)
  rw [hrow a, heig a] at hlow hhigh
  constructor <;> linarith

/-- **The shadow as the record boxes it**, `-(n-2)λ_max ≤ λ_a ≤ (n-2)|λ_min|`, once `λ_min < 0`. -/
theorem L73_abs_form {S : Matrix κ κ ℝ} {lam : κ → ℝ} {n lmin lmax : ℝ}
    (hnonneg : ∀ a b, 0 ≤ S a b)
    (hrow : ∀ a, ∑ b, S a b = 2 * (n - 2))
    (heig : ∀ a, ∑ b, S a b * lam b = -2 * lam a)
    (hmin : ∀ b, lmin ≤ lam b) (hmax : ∀ b, lam b ≤ lmax)
    (hneg : lmin < 0) :
    ∀ a, -((n - 2) * lmax) ≤ lam a ∧ lam a ≤ (n - 2) * |lmin| := by
  intro a
  obtain ⟨h1, h2⟩ := L73_one_index_shadow hnonneg hrow heig hmin hmax a
  rw [abs_of_neg hneg]
  exact ⟨h1, by linarith⟩

/-! ## A witness, so that the hypothesis set is not empty

*This exhibits data satisfying every hypothesis above; it is not a Weyl tensor, and no claim is
made that it comes from one.* -/

/-- `S = 2(J - I)` on three indices with `λ = (1, -1, 0)`, at `n = 4`: symmetric, hollow,
nonnegative, with row sums `2(n-2) = 4` and `Sλ = -2λ`, so `Ŝλ = -λ/2 = -λ/(n-2)`. -/
theorem witness :
    (∀ a b, (0 : ℝ) ≤ (Matrix.of fun a b : Fin 3 => if a = b then (0 : ℝ) else 2) a b) ∧
      (∀ a b, (Matrix.of fun a b : Fin 3 => if a = b then (0 : ℝ) else 2) a b
        = (Matrix.of fun a b : Fin 3 => if a = b then (0 : ℝ) else 2) b a) ∧
      (∀ a, (Matrix.of fun a b : Fin 3 => if a = b then (0 : ℝ) else 2) a a = 0) ∧
      (∀ a, ∑ b, (Matrix.of fun a b : Fin 3 => if a = b then (0 : ℝ) else 2) a b
        = 2 * ((4 : ℝ) - 2)) ∧
      (∀ a, ∑ b, (Matrix.of fun a b : Fin 3 => if a = b then (0 : ℝ) else 2) a b
        * (fun c : Fin 3 => if c = 0 then (1 : ℝ) else if c = 1 then -1 else 0) b
        = -2 * (fun c : Fin 3 => if c = 0 then (1 : ℝ) else if c = 1 then -1 else 0) a) := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩
  · intro a b; fin_cases a <;> fin_cases b <;> norm_num
  · intro a b; fin_cases a <;> fin_cases b <;> norm_num
  · intro a; fin_cases a <;> norm_num
  · intro a; fin_cases a <;> simp [Fin.sum_univ_three] <;> ring
  · intro a; fin_cases a <;> simp [Fin.sum_univ_three]

end HamiltonsCubic.L112Statement
