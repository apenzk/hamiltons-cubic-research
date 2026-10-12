import Mathlib

set_option linter.style.longLine false

/-!
# L37, stated as the kernel criterion it is

## The record's statement, verbatim

> For $W\in\Weyl_n$ let $\delta_A(X)=AX+XA$ for symmetric $A$, and let $\Phi_W(A)=[W,\delta_A]$.
> Then $W$ is diagonal in *some* orthonormal frame if and only if some $A\in\ker\Phi_W$ has
> pairwise-distinct sums $a_i+a_j$. In particular $\dim\ker\Phi_W<n$ certifies non-diagonality
> outright. *Diagonal* here means diagonal on the coordinate $2$-planes of the frame.

with, from the same block:

> **It needs neither criticality nor $W\in\mathcal W_n$**, *and neither does the equivalence
> above it, which holds for every linear operator on $\Lambda^2\mathbb R^n$*.

> **The threshold is $n$ because $A$ ranges over $\mathrm{Sym}^2$**; over $\mathrm{Sym}_0$ it would
> be $n-1$, and the two must not be interchanged.

> **The quantifier is load-bearing.** $\mathrm{Id}\in\ker\Phi_W$ always and has all sums equal, so
> the criterion must ask for *some* $A$ with distinct sums rather than all.

> take $A=\sum_i2^if_if_i^{\mathsf T}$: its sums $2^i+2^j$ over $i<j$ are pairwise distinct by
> uniqueness of binary representations, **so the distinctness is achievable at every $n$ and is
> never a genericity obstruction**

> **The two do not imply one another in the other direction**, $A=\mathrm{diag}(0,1,2,3)$ has
> distinct $a_i$ and repeated sums

[target.md](../../../findings/target.md), Lemma L37.

## What this file states

`Λ²ℝⁿ` is modelled as the skew matrices inside `Matrix (Fin n) (Fin n) ℝ`, and `W` as an
endomorphism of the ambient matrix space that preserves them, the record's own scope, *every
linear operator on `Λ²ℝⁿ`*, with no criticality and no `W ∈ 𝒲ₙ`. The coordinate `2`-plane of a
frame `g` is `wedge g i j = fᵢfⱼᵀ - fⱼfᵢᵀ`, and diagonality is that each of these is an
eigenvector of `W`.

**`kerPhi W` is `ker Φ_W` written out**: the symmetric `A` for which `δ_A` commutes with `W` on
every skew matrix. It is a submodule, which is what makes `dim ker Φ_W` meaningful.

**`L37`, the equivalence together with its corollary, is PROVED** in frame coordinates: forward,
the `wedge g i j` span the skew matrices (`Proof.expand`), so a `W` diagonal in a frame commutes with
every `δ_A` diagonal in it; backward, conjugating by the frame turns `[W, δ_A] = 0` into
`(aᵢ+aⱼ)Z = DZ + ZD`, and distinct sums leave `Z ∝ E_ij - E_ji`. The file carries no `sorry`.

**Also proved:** that `δ_A` is the derivation extension and acts on a frame's
coordinate `2`-plane by `aᵢ + aⱼ`, which is the identity both implications run on; that a
diagonalised `A` has the frame's columns as eigenvectors; that `kerPhi W` is a submodule and
contains the identity, whose sums are all equal, the record's reason the quantifier is
load-bearing; the binary witness `aᵢ = 2ⁱ`, whose sums over `i < j` are pairwise distinct at every
`n`; the `diag(0,1,2,3)` witness separating distinct entries from distinct sums; and that the
space of matrices diagonal in a fixed frame has dimension `n`, which is why the threshold is `n`
rather than `n-1`.
-/

namespace HamiltonsCubic.L37

open Matrix Finset

variable {n : ℕ}

/-! ## The objects -/

/-- `δ_A(X) = AX + XA`, the derivation extension of `A` to `Λ²`. -/
def deltaA (A X : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ := A * X + X * A

/-- `δ_A` preserves the skew matrices when `A` is symmetric, so it really is an operator on
`Λ²ℝⁿ`. -/
theorem deltaA_skew {A X : Matrix (Fin n) (Fin n) ℝ} (hA : Aᵀ = A) (hX : Xᵀ = -X) :
    (deltaA A X)ᵀ = -deltaA A X := by
  unfold deltaA
  rw [Matrix.transpose_add, Matrix.transpose_mul, Matrix.transpose_mul, hA, hX]
  simp [Matrix.mul_neg, Matrix.neg_mul]

/-- The `i`-th vector of the frame `g`, its `i`-th column. -/
def frameVec (g : Matrix (Fin n) (Fin n) ℝ) (i : Fin n) : Fin n → ℝ := fun k => g k i

/-- The coordinate `2`-plane `fᵢ ∧ fⱼ`, written as the skew matrix `fᵢfⱼᵀ - fⱼfᵢᵀ`. -/
def wedge (g : Matrix (Fin n) (Fin n) ℝ) (i j : Fin n) : Matrix (Fin n) (Fin n) ℝ :=
  Matrix.of fun a b => g a i * g b j - g a j * g b i

theorem wedge_apply (g : Matrix (Fin n) (Fin n) ℝ) (i j a b : Fin n) :
    wedge g i j a b = g a i * g b j - g a j * g b i := rfl

/-- The coordinate `2`-planes are skew. -/
theorem wedge_skew (g : Matrix (Fin n) (Fin n) ℝ) (i j : Fin n) :
    (wedge g i j)ᵀ = -wedge g i j := by
  ext a b
  simp only [Matrix.transpose_apply, wedge_apply, Matrix.neg_apply]
  ring

/-- **`W` is diagonal in the frame `g`**: every coordinate `2`-plane of `g` is an eigenvector. -/
def IsDiagonalIn (W : Module.End ℝ (Matrix (Fin n) (Fin n) ℝ))
    (g : Matrix (Fin n) (Fin n) ℝ) : Prop :=
  ∀ i j : Fin n, i ≠ j → ∃ c : ℝ, W (wedge g i j) = c • wedge g i j

/-- **`W` is diagonal in *some* orthonormal frame.** -/
def Diagonalizable (W : Module.End ℝ (Matrix (Fin n) (Fin n) ℝ)) : Prop :=
  ∃ g : Matrix (Fin n) (Fin n) ℝ, gᵀ * g = 1 ∧ IsDiagonalIn W g

/-- **`ker Φ_W`**, the symmetric `A` whose `δ_A` commutes with `W` on `Λ²`. -/
def kerPhi (W : Module.End ℝ (Matrix (Fin n) (Fin n) ℝ)) :
    Submodule ℝ (Matrix (Fin n) (Fin n) ℝ) where
  carrier := {A | Aᵀ = A ∧ ∀ X : Matrix (Fin n) (Fin n) ℝ, Xᵀ = -X →
    W (deltaA A X) = deltaA A (W X)}
  add_mem' := by
    rintro A B ⟨hA, hA'⟩ ⟨hB, hB'⟩
    refine ⟨by rw [Matrix.transpose_add, hA, hB], fun X hX => ?_⟩
    have h : deltaA (A + B) X = deltaA A X + deltaA B X := by
      unfold deltaA; rw [Matrix.add_mul, Matrix.mul_add]; abel
    have h2 : deltaA (A + B) (W X) = deltaA A (W X) + deltaA B (W X) := by
      unfold deltaA; rw [Matrix.add_mul, Matrix.mul_add]; abel
    rw [h, h2, map_add, hA' X hX, hB' X hX]
  zero_mem' := by
    refine ⟨by simp, fun X hX => ?_⟩
    simp [deltaA]
  smul_mem' := by
    rintro c A ⟨hA, hA'⟩
    refine ⟨by rw [Matrix.transpose_smul, hA], fun X hX => ?_⟩
    have h : deltaA (c • A) X = c • deltaA A X := by
      unfold deltaA; rw [Matrix.smul_mul, Matrix.mul_smul]; module
    have h2 : deltaA (c • A) (W X) = c • deltaA A (W X) := by
      unfold deltaA; rw [Matrix.smul_mul, Matrix.mul_smul]; module
    rw [h, h2, map_smul, hA' X hX]

theorem mem_kerPhi {W : Module.End ℝ (Matrix (Fin n) (Fin n) ℝ)}
    {A : Matrix (Fin n) (Fin n) ℝ} :
    A ∈ kerPhi W ↔ Aᵀ = A ∧ ∀ X : Matrix (Fin n) (Fin n) ℝ, Xᵀ = -X →
      W (deltaA A X) = deltaA A (W X) := Iff.rfl

/-- **The distinct-sums condition**: `A` is diagonal in some orthonormal frame with entries whose
pairwise sums over `i < j` are all different. -/
def DistinctSums (A : Matrix (Fin n) (Fin n) ℝ) : Prop :=
  ∃ g : Matrix (Fin n) (Fin n) ℝ, gᵀ * g = 1 ∧ ∃ a : Fin n → ℝ,
    A = g * Matrix.diagonal a * gᵀ ∧
      ∀ i j k l : Fin n, i < j → k < l → a i + a j = a k + a l → i = k ∧ j = l

/-! ## `δ_A` on a frame's coordinate `2`-planes

*The record: "in `A`'s eigenframe `δ_A φᵢⱼ = (aᵢ + aⱼ) φᵢⱼ`". Both directions of the equivalence
run on this identity, and it is proved here.* -/

/-- **The columns of an orthonormal frame are eigenvectors of a matrix diagonalised by it.** -/
theorem mulVec_frameVec {g : Matrix (Fin n) (Fin n) ℝ} (hg : gᵀ * g = 1) (a : Fin n → ℝ)
    (i : Fin n) :
    (g * Matrix.diagonal a * gᵀ).mulVec (frameVec g i) = a i • frameVec g i := by
  have h1 : ∀ d : Fin n, (∑ c, g c d * g c i) = if d = i then (1 : ℝ) else 0 := by
    intro d
    have h := congrFun (congrFun hg d) i
    simpa [Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply] using h
  have expand : ∀ k c : Fin n, (g * Matrix.diagonal a * gᵀ) k c = ∑ d, (g k d * a d) * g c d := by
    intro k c
    simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.diagonal_apply, mul_ite, mul_zero,
      Finset.sum_ite_eq', Finset.mem_univ, if_true]
  funext k
  simp only [Matrix.mulVec, dotProduct, frameVec, Pi.smul_apply, smul_eq_mul, expand]
  have step : ∀ c : Fin n, (∑ d, (g k d * a d) * g c d) * g c i
      = ∑ d, (g k d * a d) * (g c d * g c i) := by
    intro c
    rw [Finset.sum_mul]
    exact Finset.sum_congr rfl fun d _ => by ring
  rw [Finset.sum_congr rfl (fun c _ => step c), Finset.sum_comm]
  have step2 : ∀ d : Fin n, (∑ c, (g k d * a d) * (g c d * g c i))
      = (g k d * a d) * (if d = i then (1 : ℝ) else 0) := by
    intro d
    rw [← Finset.mul_sum, h1 d]
  rw [Finset.sum_congr rfl (fun d _ => step2 d)]
  simp
  ring

/-- **`δ_A(fᵢ ∧ fⱼ) = (aᵢ + aⱼ)(fᵢ ∧ fⱼ)`** for `A` symmetric with `A fᵢ = aᵢ fᵢ`, stated in the
eigenvector form both implications use. -/
theorem deltaA_wedge {A g : Matrix (Fin n) (Fin n) ℝ} (hA : Aᵀ = A) (a : Fin n → ℝ) (i j : Fin n)
    (hi : A.mulVec (frameVec g i) = a i • frameVec g i)
    (hj : A.mulVec (frameVec g j) = a j • frameVec g j) :
    deltaA A (wedge g i j) = (a i + a j) • wedge g i j := by
  have hiE : ∀ b, ∑ c, A b c * g c i = a i * g b i := by
    intro b
    have := congrFun hi b
    simpa [Matrix.mulVec, dotProduct, frameVec] using this
  have hjE : ∀ b, ∑ c, A b c * g c j = a j * g b j := by
    intro b
    have := congrFun hj b
    simpa [Matrix.mulVec, dotProduct, frameVec] using this
  have hsym : ∀ b c, A c b = A b c := fun b c => congrFun (congrFun hA b) c
  ext p q
  simp only [deltaA, Matrix.add_apply, Matrix.mul_apply, wedge_apply, Matrix.smul_apply,
    smul_eq_mul]
  have h1 : ∑ c, A p c * (g c i * g q j - g c j * g q i)
      = a i * g p i * g q j - a j * g p j * g q i := by
    have : ∑ c, A p c * (g c i * g q j - g c j * g q i)
        = (∑ c, A p c * g c i) * g q j - (∑ c, A p c * g c j) * g q i := by
      rw [Finset.sum_mul, Finset.sum_mul, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun c _ => by ring
    rw [this, hiE p, hjE p]
  have h2 : ∑ c, (g p i * g c j - g p j * g c i) * A c q
      = a j * g p i * g q j - a i * g p j * g q i := by
    have : ∑ c, (g p i * g c j - g p j * g c i) * A c q
        = g p i * (∑ c, A q c * g c j) - g p j * (∑ c, A q c * g c i) := by
      rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_sub_distrib]
      refine Finset.sum_congr rfl fun c _ => ?_
      rw [hsym c q]; ring
    rw [this, hjE q, hiE q]; ring
  rw [h1, h2]; ring

/-! ## The quantifier, and the two witnesses -/

/-- **`Id ∈ ker Φ_W` always**, `δ_Id = 2·Id` is central. -/
theorem one_mem_kerPhi (W : Module.End ℝ (Matrix (Fin n) (Fin n) ℝ)) : (1 : Matrix (Fin n) (Fin n) ℝ) ∈ kerPhi W := by
  refine ⟨Matrix.transpose_one, fun X hX => ?_⟩
  have h : deltaA (1 : Matrix (Fin n) (Fin n) ℝ) X = (2 : ℝ) • X := by
    simp [deltaA, two_smul]
  have h2 : deltaA (1 : Matrix (Fin n) (Fin n) ℝ) (W X) = (2 : ℝ) • W X := by
    simp [deltaA, two_smul]
  rw [h, h2, map_smul]

/-- **And its sums are all equal**, so it never satisfies the distinct-sums clause once there is
more than one pair, which is the record's reason the criterion must ask for *some* `A` rather
than for all. -/
theorem one_sums_equal (a : Fin n → ℝ) (ha : ∀ i, a i = 1) (i j k l : Fin n) :
    a i + a j = a k + a l := by rw [ha i, ha j, ha k, ha l]

/-- **The binary witness: `2ⁱ + 2ʲ` over `i < j` are pairwise distinct**, so distinctness is
achievable at every `n` and is never a genericity obstruction. -/
theorem pow_two_sums_distinct {i j k l : ℕ} (hij : i < j) (hkl : k < l)
    (h : 2 ^ i + 2 ^ j = 2 ^ k + 2 ^ l) : i = k ∧ j = l := by
  have hik : i = k := by
    by_contra hne
    rcases Nat.lt_or_ge i k with hlt | hge
    · have h1 : (2 : ℕ) ^ (i + 1) ∣ 2 ^ j := pow_dvd_pow 2 hij
      have h2 : (2 : ℕ) ^ (i + 1) ∣ 2 ^ k := pow_dvd_pow 2 hlt
      have h3 : (2 : ℕ) ^ (i + 1) ∣ 2 ^ l := pow_dvd_pow 2 (by omega)
      have h4 : (2 : ℕ) ^ (i + 1) ∣ 2 ^ i := by
        have : (2 : ℕ) ^ i = (2 ^ k + 2 ^ l) - 2 ^ j := by omega
        rw [this]
        exact Nat.dvd_sub (Nat.dvd_add h2 h3) h1
      have := Nat.le_of_dvd (by positivity) h4
      have hlt2 : (2 : ℕ) ^ i < 2 ^ (i + 1) := by
        exact Nat.pow_lt_pow_right (by norm_num) (by omega)
      omega
    · have hkl' : k < i := by omega
      have h1 : (2 : ℕ) ^ (k + 1) ∣ 2 ^ l := pow_dvd_pow 2 hkl
      have h2 : (2 : ℕ) ^ (k + 1) ∣ 2 ^ i := pow_dvd_pow 2 hkl'
      have h3 : (2 : ℕ) ^ (k + 1) ∣ 2 ^ j := pow_dvd_pow 2 (by omega)
      have h4 : (2 : ℕ) ^ (k + 1) ∣ 2 ^ k := by
        have : (2 : ℕ) ^ k = (2 ^ i + 2 ^ j) - 2 ^ l := by omega
        rw [this]
        exact Nat.dvd_sub (Nat.dvd_add h2 h3) h1
      have := Nat.le_of_dvd (by positivity) h4
      have hlt2 : (2 : ℕ) ^ k < 2 ^ (k + 1) := by
        exact Nat.pow_lt_pow_right (by norm_num) (by omega)
      omega
  subst hik
  refine ⟨rfl, ?_⟩
  have : (2 : ℕ) ^ j = 2 ^ l := by omega
  exact Nat.pow_right_injective (le_refl 2) this

/-- **`diag(0,1,2,3)` has distinct entries and repeated sums**, so the two conditions do not imply
one another in that direction: `0 + 3 = 1 + 2`. -/
theorem distinct_entries_repeated_sums :
    ∃ a : Fin 4 → ℝ, Function.Injective a ∧
      ∃ i j k l : Fin 4, i < j ∧ k < l ∧ (i, j) ≠ (k, l) ∧ a i + a j = a k + a l := by
  refine ⟨fun i : Fin 4 => (i.val : ℝ), ?_, 0, 3, 1, 2, by decide, by decide, by decide, ?_⟩
  · intro x y hxy
    have hr : ((x.val : ℝ)) = ((y.val : ℝ)) := hxy
    have hn : (x.val : ℕ) = y.val := by exact_mod_cast hr
    exact Fin.ext hn
  · norm_num

/-! ## The threshold is `n`

*"The threshold is `n` because `A` ranges over `Sym²`; over `Sym₀` it would be `n-1`, and the two
must not be interchanged." The matrices diagonal in a fixed orthonormal frame form an
`n`-dimensional space, and that is the space the corollary counts.* -/

/-- The matrices diagonal in the frame `g`, as the range of `a ↦ g diag(a) gᵀ`. -/
noncomputable def diagIn (g : Matrix (Fin n) (Fin n) ℝ) :
    (Fin n → ℝ) →ₗ[ℝ] Matrix (Fin n) (Fin n) ℝ where
  toFun a := g * Matrix.diagonal a * gᵀ
  map_add' a b := by
    show g * Matrix.diagonal (a + b) * gᵀ = g * Matrix.diagonal a * gᵀ + g * Matrix.diagonal b * gᵀ
    rw [show Matrix.diagonal (a + b) = Matrix.diagonal a + Matrix.diagonal b from
      (Matrix.diagonal_add a b).symm, Matrix.mul_add, Matrix.add_mul]
  map_smul' c a := by
    show g * Matrix.diagonal (c • a) * gᵀ = c • (g * Matrix.diagonal a * gᵀ)
    rw [Matrix.diagonal_smul, Matrix.mul_smul, Matrix.smul_mul]

/-- **The space of matrices diagonal in a fixed orthonormal frame has dimension `n`.** -/
theorem finrank_diagIn {g : Matrix (Fin n) (Fin n) ℝ} (hg : gᵀ * g = 1) :
    Module.finrank ℝ (LinearMap.range (diagIn g)) = n := by
  have key : ∀ M : Matrix (Fin n) (Fin n) ℝ, gᵀ * (g * M * gᵀ) * g = M := by
    intro M
    have hrw : gᵀ * (g * M * gᵀ) * g = (gᵀ * g) * M * (gᵀ * g) := by
      simp only [Matrix.mul_assoc]
    rw [hrw, hg, Matrix.one_mul, Matrix.mul_one]
  have hinj : Function.Injective (diagIn g) := by
    intro a b hab
    have h : g * Matrix.diagonal a * gᵀ = g * Matrix.diagonal b * gᵀ := hab
    have h3 : gᵀ * (g * Matrix.diagonal a * gᵀ) * g = gᵀ * (g * Matrix.diagonal b * gᵀ) * g := by
      rw [h]
    rw [key, key] at h3
    exact Matrix.diagonal_injective h3
  rw [LinearMap.finrank_range_of_inj hinj]
  simp

/-! ## The proof, in frame coordinates

*Every skew `X` expands as `½ ∑ (gᵀXg)ᵢⱼ (fᵢ ∧ fⱼ)` (`expand`), and conjugating by the frame turns
`δ_A` for `A = g · diag a · gᵀ` into `Z ↦ DZ + ZD` (`conj_delta`). Forward, a frame diagonalising `W`
puts every such `A` in `ker Φ_W` (`diag_mem_kerPhi`), and `aᵢ = 2ⁱ` has distinct sums; backward, the
eigen-equation `(aᵢ+aⱼ)Z = DZ + ZD` with distinct sums forces `Z ∝ E_ij - E_ji` (`backward`).* -/

namespace Proof

/-- The elementary skew matrix `E_ij - E_ji`. -/
def S (i j : Fin n) : Matrix (Fin n) (Fin n) ℝ := Matrix.single i j 1 - Matrix.single j i 1

theorem wedge_eq (g : Matrix (Fin n) (Fin n) ℝ) (i j : Fin n) : wedge g i j = g * S i j * gᵀ := by
  ext a b
  simp [wedge_apply, S, Matrix.mul_apply, Matrix.sub_apply, Matrix.single_apply, Matrix.transpose_apply,
    sub_mul, mul_sub, Finset.sum_sub_distrib, ite_and, Finset.sum_ite_eq, Finset.sum_ite_eq', ite_mul, zero_mul]

theorem conj_back {g : Matrix (Fin n) (Fin n) ℝ} (hg : gᵀ * g = 1) (M : Matrix (Fin n) (Fin n) ℝ) :
    g * (gᵀ * M * g) * gᵀ = M := by
  have hg' : g * gᵀ = 1 := mul_eq_one_comm.mp hg
  simp only [← Matrix.mul_assoc, hg', Matrix.one_mul]
  rw [Matrix.mul_assoc, hg', Matrix.mul_one]

/-- `Σ_ij C_ij (f_i ∧ f_j) = g C gᵀ - g Cᵀ gᵀ`. -/
theorem sum_wedge (g C : Matrix (Fin n) (Fin n) ℝ) :
    ∑ i, ∑ j, C i j • wedge g i j = g * C * gᵀ - g * Cᵀ * gᵀ := by
  ext a b
  simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, wedge_apply, Matrix.sub_apply,
    Matrix.mul_apply, Matrix.transpose_apply, mul_sub, Finset.sum_sub_distrib, Finset.sum_mul]
  congr 1
  · conv_rhs => rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  · exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring

/-- **Every skew matrix expands in a frame's coordinate planes.** -/
theorem expand {g : Matrix (Fin n) (Fin n) ℝ} (hg : gᵀ * g = 1) {X : Matrix (Fin n) (Fin n) ℝ}
    (hX : Xᵀ = -X) : X = (1 / 2 : ℝ) • ∑ i, ∑ j, (gᵀ * X * g) i j • wedge g i j := by
  rw [sum_wedge, conj_back hg]
  have : (gᵀ * X * g)ᵀ = -(gᵀ * X * g) := by
    rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hX]
    simp [Matrix.mul_assoc]
  rw [this, Matrix.mul_neg, Matrix.neg_mul, conj_back hg, sub_neg_eq_add]
  ext a b; simp [Matrix.add_apply]; ring

/-- The linear map `δ_A`. -/
def deltaL (A : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ →ₗ[ℝ] Matrix (Fin n) (Fin n) ℝ where
  toFun := deltaA A
  map_add' X Y := by unfold deltaA; rw [Matrix.mul_add, Matrix.add_mul]; abel
  map_smul' c X := by unfold deltaA; simp [smul_add]

/-- **A frame in which `W` is diagonal puts every `g · diag a · gᵀ` into `ker Φ_W`.** -/
theorem diag_mem_kerPhi (W : Module.End ℝ (Matrix (Fin n) (Fin n) ℝ)) {g : Matrix (Fin n) (Fin n) ℝ}
    (hg : gᵀ * g = 1) (hdiag : IsDiagonalIn W g) (a : Fin n → ℝ) :
    g * Matrix.diagonal a * gᵀ ∈ kerPhi W := by
  classical
  let lam : Fin n → Fin n → ℝ := fun i j => if h : i ≠ j then Classical.choose (hdiag i j h) else 0
  have hlam : ∀ i j, W (wedge g i j) = lam i j • wedge g i j := by
    intro i j
    by_cases h : i ≠ j
    · simp only [lam, dif_pos h]; exact Classical.choose_spec (hdiag i j h)
    · push Not at h; subst h
      have : wedge g i i = 0 := by ext a b; simp [wedge_apply, mul_comm]
      simp [this]
  set A := g * Matrix.diagonal a * gᵀ with hA
  have hAsym : Aᵀ = A := by
    rw [hA, Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose,
      Matrix.diagonal_transpose, Matrix.mul_assoc]
  have hdw : ∀ i j, deltaA A (wedge g i j) = (a i + a j) • wedge g i j := fun i j =>
    deltaA_wedge hAsym a i j (mulVec_frameVec hg a i) (mulVec_frameVec hg a j)
  refine ⟨hAsym, fun X hX => ?_⟩
  set Y := gᵀ * X * g
  have hXe := expand hg hX
  have e1 : deltaA A X = (1 / 2 : ℝ) • ∑ i, ∑ j, (Y i j * (a i + a j)) • wedge g i j := by
    conv_lhs => rw [hXe]
    change deltaL A _ = _
    simp only [map_smul, map_sum, deltaL, LinearMap.coe_mk, AddHom.coe_mk, hdw, smul_smul]
    rfl
  have e2 : W X = (1 / 2 : ℝ) • ∑ i, ∑ j, (Y i j * lam i j) • wedge g i j := by
    conv_lhs => rw [hXe]
    simp only [map_smul, map_sum, hlam, smul_smul]
    rfl
  rw [e1, e2]
  change W _ = deltaL A _
  simp only [map_smul, map_sum, deltaL, LinearMap.coe_mk, AddHom.coe_mk, hlam, hdw, smul_smul]
  congr 1
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring_nf


theorem conj_delta {g : Matrix (Fin n) (Fin n) ℝ} (hg : gᵀ * g = 1) (a : Fin n → ℝ)
    (M : Matrix (Fin n) (Fin n) ℝ) :
    gᵀ * deltaA (g * Matrix.diagonal a * gᵀ) M * g
      = Matrix.diagonal a * (gᵀ * M * g) + (gᵀ * M * g) * Matrix.diagonal a := by
  unfold deltaA
  have e1 : gᵀ * (g * Matrix.diagonal a * gᵀ * M) * g = (gᵀ * g) * Matrix.diagonal a * (gᵀ * M * g) := by
    simp only [Matrix.mul_assoc]
  have e2 : gᵀ * (M * (g * Matrix.diagonal a * gᵀ)) * g = (gᵀ * M * g) * Matrix.diagonal a * (gᵀ * g) := by
    simp only [Matrix.mul_assoc]
  rw [Matrix.mul_add, Matrix.add_mul, e1, e2, hg, Matrix.one_mul, Matrix.mul_one]

/-- **Distinct sums force diagonality.** -/
theorem backward (W : Module.End ℝ (Matrix (Fin n) (Fin n) ℝ))
    (hW : ∀ X : Matrix (Fin n) (Fin n) ℝ, Xᵀ = -X → (W X)ᵀ = -W X) {A : Matrix (Fin n) (Fin n) ℝ}
    (hA : A ∈ kerPhi W) (hd : DistinctSums A) : Diagonalizable W := by
  obtain ⟨hAs, hcomm⟩ := hA
  obtain ⟨g, hg, a, rfl, hdist⟩ := hd
  refine ⟨g, hg, fun i j hij => ?_⟩
  have heig : deltaA (g * Matrix.diagonal a * gᵀ) (W (wedge g i j)) = (a i + a j) • W (wedge g i j) := by
    have := hcomm (wedge g i j) (wedge_skew g i j)
    rw [deltaA_wedge hAs a i j (mulVec_frameVec hg a i) (mulVec_frameVec hg a j), map_smul] at this
    exact this.symm
  set M := W (wedge g i j)
  have hMs : Mᵀ = -M := hW _ (wedge_skew g i j)
  set Z := gᵀ * M * g with hZdef
  have hZ : Matrix.diagonal a * Z + Z * Matrix.diagonal a = (a i + a j) • Z := by
    rw [← conj_delta hg a M, heig, Matrix.mul_smul, Matrix.smul_mul]
  have hZs : ∀ k l, Z l k = -Z k l := by
    intro k l
    have hZt : Zᵀ = -Z := by
      rw [hZdef, Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hMs]
      simp [Matrix.mul_assoc]
    have := congrFun (congrFun hZt k) l
    simpa [Matrix.transpose_apply] using this
  have hent : ∀ k l, (a k + a l) * Z k l = (a i + a j) * Z k l := by
    intro k l
    have := congrFun (congrFun hZ k) l
    simp only [Matrix.add_apply, Matrix.diagonal_mul, Matrix.mul_diagonal, Matrix.smul_apply,
      smul_eq_mul] at this
    linarith
  have hpair : ∀ k l, k ≠ l → a k + a l = a i + a j → (k = i ∧ l = j) ∨ (k = j ∧ l = i) := by
    intro k l hkl hs
    rcases lt_or_gt_of_ne hkl with h1 | h1 <;> rcases lt_or_gt_of_ne hij with h2 | h2
    · exact Or.inl (hdist k l i j h1 h2 hs)
    · obtain ⟨e1, e2⟩ := hdist k l j i h1 h2 (by linarith); exact Or.inr ⟨e1, e2⟩
    · obtain ⟨e1, e2⟩ := hdist l k i j h1 h2 (by linarith); exact Or.inr ⟨e2, e1⟩
    · obtain ⟨e1, e2⟩ := hdist l k j i h1 h2 (by linarith); exact Or.inl ⟨e2, e1⟩
  have hZform : Z = Z i j • S i j := by
    ext k l
    simp only [Matrix.smul_apply, S, Matrix.sub_apply, Matrix.single_apply, smul_eq_mul]
    by_cases hkl : k = l
    · subst hkl
      have h0 : Z k k = 0 := by have := hZs k k; linarith
      have n1 : ¬ (i = k ∧ j = k) := fun ⟨h1, h2⟩ => hij (h1.trans h2.symm)
      have n2 : ¬ (j = k ∧ i = k) := fun ⟨h1, h2⟩ => hij (h2.trans h1.symm)
      simp [h0, n1, n2]
    · by_cases hs : a k + a l = a i + a j
      · rcases hpair k l hkl hs with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
        · simp [hij]
        · simp [hij, Ne.symm hij, hZs k l]
      · have hz : Z k l = 0 := by
          have h' : (a k + a l - (a i + a j)) * Z k l = 0 := by linarith [hent k l]
          rcases mul_eq_zero.mp h' with h | h
          · exact absurd (by linarith) hs
          · exact h
        have n1 : ¬ (i = k ∧ j = l) := fun ⟨h1, h2⟩ => hs (by rw [h1, h2])
        have n2 : ¬ (j = k ∧ i = l) := fun ⟨h1, h2⟩ => hs (by rw [← h1, ← h2, add_comm])
        simp [hz, n1, n2]
  refine ⟨Z i j, ?_⟩
  calc M = g * Z * gᵀ := (conj_back hg M).symm
    _ = Z i j • (g * S i j * gᵀ) := by conv_lhs => rw [hZform]
                                       rw [Matrix.mul_smul, Matrix.smul_mul]
    _ = Z i j • wedge g i j := by rw [wedge_eq]

theorem criterion' (W : Module.End ℝ (Matrix (Fin n) (Fin n) ℝ))
    (hW : ∀ X : Matrix (Fin n) (Fin n) ℝ, Xᵀ = -X → (W X)ᵀ = -W X) :
    (Diagonalizable W ↔ ∃ A ∈ kerPhi W, DistinctSums A) ∧
      (Module.finrank ℝ (kerPhi W) < n → ¬ Diagonalizable W) := by
  refine ⟨⟨fun ⟨g, hg, hdiag⟩ => ?_, fun ⟨A, hA, hd⟩ => backward W hW hA hd⟩, ?_⟩
  · refine ⟨_, diag_mem_kerPhi W hg hdiag (fun i => (2 : ℝ) ^ (i : ℕ)), g, hg,
      fun i => (2 : ℝ) ^ (i : ℕ), rfl, fun i j k l hij hkl h => ?_⟩
    have h' : 2 ^ (i : ℕ) + 2 ^ (j : ℕ) = 2 ^ (k : ℕ) + 2 ^ (l : ℕ) := by
      simp only at h; exact_mod_cast h
    obtain ⟨e1, e2⟩ := pow_two_sums_distinct (Fin.lt_def.mp hij) (Fin.lt_def.mp hkl) h'
    exact ⟨Fin.ext e1, Fin.ext e2⟩
  · rintro hlt ⟨g, hg, hdiag⟩
    have hle : LinearMap.range (diagIn g) ≤ kerPhi W := by
      rintro _ ⟨a, rfl⟩
      exact diag_mem_kerPhi W hg hdiag a
    have := Submodule.finrank_mono hle
    rw [finrank_diagIn hg] at this
    omega

end Proof

/-! ## The lemma

*Both implications, and the corollary that counts dimensions, are stated together so the record's
statement can be diffed against one Lean proposition.* -/

/-- **L37.** For every linear operator `W` on `Λ²ℝⁿ`: `W` is diagonal in some orthonormal frame
if and only if some `A ∈ ker Φ_W` has pairwise-distinct sums; and `dim ker Φ_W < n` certifies
non-diagonality.

**Proved** (`Proof.criterion'`): forward through `Proof.diag_mem_kerPhi` with the binary sums,
backward through `Proof.backward`, and the corollary because `diagIn g` is an `n`-dimensional
subspace of `ker Φ_W` whenever `W` is diagonal in `g`.

Neither criticality nor `W ∈ 𝒲ₙ` appears, exactly as the record records. -/
theorem diagonality_criterion (W : Module.End ℝ (Matrix (Fin n) (Fin n) ℝ))
    (hW : ∀ X : Matrix (Fin n) (Fin n) ℝ, Xᵀ = -X → (W X)ᵀ = -W X) :
    (Diagonalizable W ↔ ∃ A ∈ kerPhi W, DistinctSums A) ∧
      (Module.finrank ℝ (kerPhi W) < n → ¬ Diagonalizable W) :=
  Proof.criterion' W hW

end HamiltonsCubic.L37
