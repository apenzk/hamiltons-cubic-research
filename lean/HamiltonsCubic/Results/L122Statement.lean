import Mathlib

set_option linter.style.longLine false

/-!
# L122, the pair block is a Kirchhoff matrix of the deleted sectional matrix

## The record's statement, verbatim

> #### Lemma L122, the pair block is a graph Laplacian of the sectional matrix
>
> **Let $M$ be a coordinate-diagonal Weyl operator with sectional matrix $M_{ab}$, and fix a pair
> $\{j,k\}$. In the basis $f_i=e_{ji}\odot e_{ki}$, $i\notin\{j,k\}$, the pair block of $L_M$ is**
> $$L\big|_{\{j,k\}}\;=\;\tfrac12\Big[\operatorname{diag}\big(M_{ji}+M_{ki}\big)-M_{jk}\,\mathrm{Id}+M^{(jk)}\Big]\;=\;-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\,\mathrm{Id},$$
> **where $M^{(jk)}$ is the hollow submatrix of $M$ on the indices other than $j,k$, and
> $\Delta^{(jk)}$ is the Kirchhoff matrix of *that deleted matrix*, $\operatorname{diag}(\text{its
> row sums})-M^{(jk)}$, with degrees $-(M_{ij}+M_{ik})$. The Ricci cut on this block is exactly
> $\sum_ix_i=0$, that matrix's own $\mathbf 1^\perp$.**
>
> **The three claims here have three different hypotheses.** The bracketed form needs
> **diagonality alone**. The Laplacian rewriting needs in addition $\sum_bM_{ib}=0$ for every
> $i\notin\{j,k\}$, which is $n-2$ of the $n$ Ricci conditions, rows $j$ and $k$ never entering.
> **And the inequality below needs $M$ to be a maximiser**, since that is what Lemma L24 requires.
>
> > **"Graph Laplacian" also overreaches**, the weights are signed,
> > $\operatorname{tr}\Delta^{(jk)}=2M_{jk}$ forces a negative eigenvalue when $M_{jk}<0$, and the
> > lemma's own content is that $\lambda_{\min}<0$; only symmetry and $\Delta\mathbf1=0$ are used,
> > so Matrix-Tree, Cheeger and Perron do not transfer.
>
> **Consequently Lemma L24 on the non-diagonal directions is a spectral condition on these
> Kirchhoff matrices, at every coordinate-diagonal *maximiser*,** one per pair:
> $$\lambda_{\min}\Big(\Delta^{(jk)}\Big|_{\mathbf 1^\perp}\Big)\;\ge\;-\big(\theta+M_{jk}\big)\qquad\text{for every pair }\{j,k\}.$$

[second-order.md](../../../findings/second-order.md), Lemma L122.

## What this file states, and with which hypothesis where

The record's own scope split is reproduced exactly, one theorem per clause:

* `degree_eq`, the degrees are `-(M_{ij} + M_{ik})`. Needs Ricci at row `i` and hollowness.
* `block_eq_kirchhoff`, the two forms of the block agree, entry by entry on the block indices.
  Needs the degree identity, hence the `n-2` Ricci rows `i ∉ {j,k}`; rows `j` and `k` never enter.
* `kirchhoff_row_sum`, `Δ𝟙 = 0`, the Ricci cut being `∑ x_i = 0`. Needs hollowness alone.
* `kirchhoff_trace`, `tr Δ = 2 M_{jk}`, the record's reason that "graph Laplacian" overreaches.
  **This one does spend Ricci rows `j` and `k`**, and says so.
* `lambda_min_bound`, the spectral condition, in Rayleigh-quotient form. Lemma L24's cap enters
  as an explicit hypothesis `hcap`, legitimately because L24 is **classical and external**:
  Proposition 6.6 of Krasnov–Tkachev, *Variety of idempotents in nonassociative algebras*. The
  record's maximiser hypothesis is spent on that cap and on nothing else.

**The record's warning that the inequality is false without the maximiser hypothesis is honoured**:
`lambda_min_bound` derives the bound *from* `hcap` and asserts nothing at a critical point that is
not a maximiser, the padded `S⁶ × S⁶` witness the record exhibits.

The block is indexed by `Fin n` with all statements restricted to `Sset j k = univ \ {j,k}`, so
"the hollow submatrix on the indices other than `j,k`" is literally the restriction of `M`.

## What is NOT typed here

**That this matrix *is* the pair block of `L_M`** is proved in [L122Block.lean](L122Block.lean)
(`pairBlock`, in the basis `f_i = φ_ji ⊙ φ_ki`), and [L122Pair.lean](L122Pair.lean) proves the
common norm `√2` of the `f_i` (`pair_gram`) and that the Ricci cut on the block is `∑ x_i = 0`
(`pair_ricciFlat_iff`). Here `Lb` is the record's displayed matrix.

**Proved elsewhere**: that the orbit direction `x_i = M_{ki} - M_{ji}` is an `L_M`-eigenvector at
`θ/2`, in [L122Orbit.lean](L122Orbit.lean) (`orbit_eigen`), through criticality. **Also absent**: the
within-factor top eigenvalue `(p-2)/(2(p-1))`, and the withdrawn halved form.
-/

namespace HamiltonsCubic.L122Statement

open Finset

variable {n : ℕ}

/-- The block's index set: every index other than `j` and `k`. -/
def Sset (j k : Fin n) : Finset (Fin n) := Finset.univ \ {j, k}

theorem mem_Sset {j k i : Fin n} : i ∈ Sset j k ↔ i ≠ j ∧ i ≠ k := by
  simp [Sset]

/-- **The degree of `i` in the deleted matrix**: the row sum of `M^{(jk)}`. -/
def deg (M : Matrix (Fin n) (Fin n) ℝ) (j k i : Fin n) : ℝ := ∑ m ∈ Sset j k, M i m

/-- **`Δ^{(jk)}`**, the Kirchhoff matrix of the deleted matrix: `diag(row sums) - M^{(jk)}`.
*`M` is hollow, so no diagonal entry of `M` enters.* -/
def Kirch (M : Matrix (Fin n) (Fin n) ℝ) (j k : Fin n) : Matrix (Fin n) (Fin n) ℝ :=
  fun i m => if i = m then deg M j k i else -M i m

/-- **The record's bracketed form of the pair block**,
`½[diag(M_{ji} + M_{ki}) - M_{jk} Id + M^{(jk)}]`. -/
noncomputable def Lb (M : Matrix (Fin n) (Fin n) ℝ) (j k : Fin n) : Matrix (Fin n) (Fin n) ℝ :=
  fun i m => if i = m then (1 / 2) * (M j i + M k i - M j k) else (1 / 2) * M i m

/-- Ricci-flatness of a coordinate-diagonal Weyl operator, as a condition on the sectional
matrix: every row sums to zero. -/
def RicciFlat (M : Matrix (Fin n) (Fin n) ℝ) : Prop := ∀ a, ∑ b, M a b = 0

/-- The sectional matrix is hollow. -/
def Hollow (M : Matrix (Fin n) (Fin n) ℝ) : Prop := ∀ a, M a a = 0

/-! ## The degrees -/

/-- **The degrees are `-(M_{ij} + M_{ik})`.** *This is the step the Laplacian rewriting needs, and
it spends exactly the Ricci row `i`.* -/
theorem degree_eq (M : Matrix (Fin n) (Fin n) ℝ) (j k i : Fin n) (hjk : j ≠ k)
    (hR : ∑ b, M i b = 0) : deg M j k i = -(M i j + M i k) := by
  have hsub : ({j, k} : Finset (Fin n)) ⊆ Finset.univ := Finset.subset_univ _
  have h := Finset.sum_sdiff_eq_sub (f := fun m => M i m) hsub
  unfold deg Sset
  rw [h, hR, Finset.sum_pair hjk]
  ring

/-! ## The two forms of the block agree -/

/-- **The record's identity, entry by entry on the block**:
`½[diag(M_{ji}+M_{ki}) - M_{jk}Id + M^{(jk)}] = -½Δ^{(jk)} - ½M_{jk}Id`.

*It needs the `n-2` Ricci rows `i ∉ {j,k}` and symmetry, and nothing else, rows `j` and `k` never
enter.* -/
theorem block_eq_kirchhoff (M : Matrix (Fin n) (Fin n) ℝ) (j k : Fin n) (hjk : j ≠ k)
    (hsym : ∀ a b, M a b = M b a)
    (hR : ∀ i, i ∈ Sset j k → ∑ b, M i b = 0)
    (i m : Fin n) (hi : i ∈ Sset j k) :
    Lb M j k i m
      = -(1 / 2) * Kirch M j k i m - (1 / 2) * M j k * (if i = m then 1 else 0) := by
  by_cases h : i = m
  · subst h
    have hd := degree_eq M j k i hjk (hR i hi)
    simp only [Lb, Kirch, if_true, hd, hsym j i, hsym k i]
    ring
  · simp only [Lb, Kirch, if_neg h]
    ring

/-! ## `Δ𝟙 = 0`, and the trace -/

/-- **`Δ^{(jk)}𝟙 = 0`**: every row of the Kirchhoff matrix sums to zero on the block. *Hollowness
is the whole hypothesis.* -/
theorem kirchhoff_row_sum (M : Matrix (Fin n) (Fin n) ℝ) (j k i : Fin n)
    (hhol : Hollow M) (hi : i ∈ Sset j k) :
    ∑ m ∈ Sset j k, Kirch M j k i m = 0 := by
  have hsplit : ∑ m ∈ Sset j k, Kirch M j k i m
      = ∑ m ∈ (Sset j k).erase i, Kirch M j k i m + Kirch M j k i i :=
    (Finset.sum_erase_add _ _ hi).symm
  have hoff : ∑ m ∈ (Sset j k).erase i, Kirch M j k i m
      = -∑ m ∈ (Sset j k).erase i, M i m := by
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun m hm => ?_
    have : i ≠ m := (Finset.ne_of_mem_erase hm).symm
    simp [Kirch, this]
  have hrow : ∑ m ∈ (Sset j k).erase i, M i m = deg M j k i - M i i := by
    have h := Finset.sum_erase_add (Sset j k) (fun m => M i m) hi
    unfold deg
    linarith [h]
  have hkii : Kirch M j k i i = deg M j k i := by simp [Kirch]
  rw [hsplit, hoff, hrow, hkii, hhol i]
  ring

/-- **`tr Δ^{(jk)} = 2 M_{jk}`**, the record's reason that "graph Laplacian" overreaches: a
negative `M_{jk}` forces a negative eigenvalue. *Unlike the rewriting, this clause does spend the
Ricci rows `j` and `k`.* -/
theorem kirchhoff_trace (M : Matrix (Fin n) (Fin n) ℝ) (j k : Fin n) (hjk : j ≠ k)
    (hsym : ∀ a b, M a b = M b a) (hhol : Hollow M) (hR : RicciFlat M) :
    ∑ i ∈ Sset j k, Kirch M j k i i = 2 * M j k := by
  have hdiag : ∀ i ∈ Sset j k, Kirch M j k i i = -(M i j + M i k) := by
    intro i _
    simp only [Kirch]
    exact degree_eq M j k i hjk (hR i)
  rw [Finset.sum_congr rfl hdiag]
  have hsub : ({j, k} : Finset (Fin n)) ⊆ Finset.univ := Finset.subset_univ _
  have hj : ∑ i ∈ Sset j k, M i j = -M k j := by
    have h := Finset.sum_sdiff_eq_sub (f := fun i => M i j) hsub
    have hcol : ∑ i, M i j = 0 := by
      rw [Finset.sum_congr rfl (fun i _ => hsym i j)]; exact hR j
    unfold Sset
    rw [h, hcol, Finset.sum_pair hjk, hhol j]
    ring
  have hk : ∑ i ∈ Sset j k, M i k = -M j k := by
    have h := Finset.sum_sdiff_eq_sub (f := fun i => M i k) hsub
    have hcol : ∑ i, M i k = 0 := by
      rw [Finset.sum_congr rfl (fun i _ => hsym i k)]; exact hR k
    unfold Sset
    rw [h, hcol, Finset.sum_pair hjk, hhol k]
    ring
  rw [Finset.sum_neg_distrib, Finset.sum_add_distrib, hj, hk, hsym k j]
  ring

/-! ## The spectral condition, one per pair -/

/-- The Rayleigh numerator of a matrix on the block. -/
def quadS (A : Matrix (Fin n) (Fin n) ℝ) (j k : Fin n) (x : Fin n → ℝ) : ℝ :=
  ∑ i ∈ Sset j k, ∑ m ∈ Sset j k, x i * A i m * x m

/-- `‖x‖²` on the block. -/
def nrmS (j k : Fin n) (x : Fin n → ℝ) : ℝ := ∑ i ∈ Sset j k, x i * x i

/-- The Ricci cut on the block: `∑_i x_i = 0`. -/
def OnCut (j k : Fin n) (x : Fin n → ℝ) : Prop := ∑ i ∈ Sset j k, x i = 0

/-- **The block's quadratic form, in the Kirchhoff form.** -/
theorem quadS_Lb (M : Matrix (Fin n) (Fin n) ℝ) (j k : Fin n) (hjk : j ≠ k)
    (hsym : ∀ a b, M a b = M b a) (hR : ∀ i, i ∈ Sset j k → ∑ b, M i b = 0)
    (x : Fin n → ℝ) :
    quadS (Lb M j k) j k x = -(1 / 2) * quadS (Kirch M j k) j k x - (1 / 2) * M j k * nrmS j k x := by
  have hdelta : ∀ i ∈ Sset j k,
      ∑ m ∈ Sset j k, x i * (if i = m then (1 : ℝ) else 0) * x m = x i * x i := by
    intro i hi
    rw [Finset.sum_eq_single i (fun m _ hm => by simp [Ne.symm hm]) (fun h => absurd hi h)]
    simp
  have key : ∀ i ∈ Sset j k, ∑ m ∈ Sset j k, x i * Lb M j k i m * x m
      = -(1 / 2) * (∑ m ∈ Sset j k, x i * Kirch M j k i m * x m)
        - (1 / 2) * M j k * (x i * x i) := by
    intro i hi
    have hc : ∀ m ∈ Sset j k, x i * Lb M j k i m * x m
        = -(1 / 2) * (x i * Kirch M j k i m * x m)
          - (1 / 2) * M j k * (x i * (if i = m then (1 : ℝ) else 0) * x m) := by
      intro m _
      rw [block_eq_kirchhoff M j k hjk hsym hR i m hi]; ring
    rw [Finset.sum_congr rfl hc, Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.mul_sum,
      hdelta i hi]
  unfold quadS nrmS
  rw [Finset.sum_congr rfl key, Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.mul_sum]

/-- **L122's spectral condition.** With Lemma L24's cap on this block, the Kirchhoff matrix's
Rayleigh quotient on the Ricci cut is bounded below by `-(θ + M_{jk})`, which is
`λ_min(Δ^{(jk)}|_{𝟙^⊥}) ≥ -(θ + M_{jk})`.

*`hcap` is the classical Krasnov–Tkachev cap, in `L_M` units. It is the whole of what the record's
maximiser hypothesis supplies, and the record's own witness, padded `S⁶ × S⁶`, critical and
Ricci-flat and not a maximiser, is exactly a point where `hcap` fails.* -/
theorem lambda_min_bound (M : Matrix (Fin n) (Fin n) ℝ) (j k : Fin n) (θ : ℝ) (hjk : j ≠ k)
    (hsym : ∀ a b, M a b = M b a) (hR : ∀ i, i ∈ Sset j k → ∑ b, M i b = 0)
    (hcap : ∀ x : Fin n → ℝ, OnCut j k x → quadS (Lb M j k) j k x ≤ (θ / 2) * nrmS j k x)
    (x : Fin n → ℝ) (hx : OnCut j k x) :
    -(θ + M j k) * nrmS j k x ≤ quadS (Kirch M j k) j k x := by
  have h := hcap x hx
  rw [quadS_Lb M j k hjk hsym hR x] at h
  linarith

/-! ## A witness, so the hypotheses are not empty

*The zero sectional matrix is hollow, symmetric and Ricci-flat, and the cap holds at `θ = 0`.* -/

example : Hollow (0 : Matrix (Fin n) (Fin n) ℝ) ∧ RicciFlat (0 : Matrix (Fin n) (Fin n) ℝ) ∧
    (∀ a b : Fin n, (0 : Matrix (Fin n) (Fin n) ℝ) a b = (0 : Matrix (Fin n) (Fin n) ℝ) b a) := by
  refine ⟨fun a => rfl, fun a => by simp, fun a b => rfl⟩

end HamiltonsCubic.L122Statement
