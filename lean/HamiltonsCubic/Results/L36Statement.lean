import Mathlib
import HamiltonsCubic.Results.L15Statement
import HamiltonsCubic.Results.L77Statement
import HamiltonsCubic.Results.FrameExtension

/-!
# L36, `S = 0` caps the negative eigenspace at `⌊n²/4⌋`, PROVED

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L36, quoted verbatim (the block's
inline correction of its own bridging clause is reproduced, since it is part of the statement):

> **Statement.** Let `𝔪 ⊆ 𝔰𝔬(n)` satisfy `⟨[u,v],w⟩ = 0` for all `u,v,w ∈ 𝔪`, *isotropic*.
> **The bridging clause needs two things the statement omitted**: the vanishing quantity is
> `S_𝔪𝔪𝔪`, not the analytic slack `S(W)` that conventions.md resolves unsubscripted `S` to; and
> `W` must be **critical** […]. Then `dim 𝔪 ≤ ⌊n²/4⌋`, **with equality attained by the mixed
> planes `𝔪 ≅ ℝᵖ ⊗ ℝᵠ` at `p = ⌈n/2⌉`**, of dimension `pq`, which is `n²/4` at even `n` and
> `(n²-1)/4` at the odd split, so **sharpness holds at both parities**. Sharp, every `n ≥ 3`, no
> genericity hypothesis.

**What [L36.lean](L36.lean) already carries and this file does not repeat**: the parity identity
`⌈n/2⌉·⌊n/2⌋ = ⌊n²/4⌋`, the shortfall of the refuted maximiser `𝔰𝔬(p) ⊕ 𝔰𝔬(q)`, and the witness
`⟨[φ₀₁, φ₁₂], φ₀₂⟩ ≠ 0` showing that maximiser is not even admissible. **What that file never
states is the cap**, which its own docstring records as *"owed"*. The cap and its equality clause
are typed here.

## How it is proved

The record's chain of three steps, every step now machine-checked, in `HamiltonsCubic.L36Proof`:

1. **`mu_le`, the Killing block identity**: the orthonormal basis of `𝔪` is completed to a frame
   by [FrameExtension.lean](FrameExtension.lean), [L41Statement.lean](L41Statement.lean)'s Killing
   row `∑ c_{xab}² = 2(n-2)` holds on it, and isotropy kills the `𝔪𝔪𝔪` constants, leaving
   `2μ + γ = 2(n-2)d` with `γ` a sum of squares, so `μ ≤ (n-2)d`.
2. **`mu_ge`, `μ ≥ 4d²/n - 2d`, WITHOUT the Casimir on `Sym(𝔰𝔬(n))`.** With `P` the projector onto
   `𝔪`, `μ = tr(M²) + XX(P)` for `M = ∑ e_a²`; Cauchy–Schwarz gives `tr(M²) ≥ (tr M)²/n = 4d²/n`,
   and [L15Statement.lean](L15Statement.lean)'s `Alt` expansion `6‖Alt P‖² = ½∑m² + XX(P)` with
   `‖P‖² = d` gives `XX(P) ≥ -2d`.
3. **`cap`** chains them, as `cap_from_masses` below does at the scalar level.

The equality clause is `blockOff`, the skew matrices vanishing on both diagonal blocks at
`p = ⌈n/2⌉`: the bracket of two such matrices is block-diagonal and so pairs to zero with a third,
the triangle-freeness of the complete bipartite graph, and its dimension is `p(n-p) = ⌊n²/4⌋`.

## Two things about the types

**`n ^ 2 / 4` is `ℕ`-division, and floor is what the record means**, `n²/4` at even `n` and
`(n²-1)/4` at odd. That is the one place truncation is intended rather than a hazard.

**`𝔪` is a subspace and not a subalgebra.** The record's refuted first version named a
subalgebra, and an isotropic subalgebra is abelian, so nothing here may close `𝔪` under `br`.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L36Statement

open Matrix

variable {n : ℕ}

/-- The `Λ²` inner product `⟨X, Y⟩ = ½ tr(Xᵀ Y)`, the normalisation
[conventions.md](../../../findings/conventions.md) fixes. *The cap statement is invariant under
rescaling this pairing, since it is a vanishing condition; the `½` is carried so the file agrees
with [Bivectors.lean](../Base/Bivectors.lean).* -/
noncomputable def inner2 (X Y : Matrix (Fin n) (Fin n) ℝ) : ℝ := (1 / 2) * (Xᵀ * Y).trace

/-- The bracket on `𝔰𝔬(n)`. -/
def br (X Y : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ := X * Y - Y * X

/-- A subspace of skew-symmetric matrices: `𝔪 ⊆ 𝔰𝔬(n)`. -/
def SkewSub (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) : Prop := ∀ A ∈ m, Aᵀ = -A

/-- **Isotropic**: `⟨[u,v],w⟩ = 0` for all `u, v, w ∈ 𝔪`. This is the vanishing of `S_𝔪𝔪𝔪`, the
Cartan three-form restricted to `𝔪`, *not* the analytic slack `S(W)`, which the block records
as the reading its first version wrongly invited. -/
def Isotropic (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) : Prop :=
  ∀ u ∈ m, ∀ v ∈ m, ∀ w ∈ m, inner2 (br u v) w = 0

/-! ## The step of the proof that is arithmetic, proved

*The record names `γ` explicitly and says why: read instead as the residual `2(n-2)d - 2μ`, the
identity is a tautology and `γ ≥ 0` restates the conclusion. So `γ ≥ 0` is a hypothesis here and
is where the content of step 1 sits.* -/

/-- **The chain, isolated.** From the Killing block identity `2μ + γ = 2(n-2)d` with `γ ≥ 0`, and
the universal lower bound `μ ≥ 4d²/n - 2d`, the cap `d ≤ n²/4` follows by arithmetic alone. -/
theorem cap_from_masses {N d mu gamma : ℝ} (hN : 0 < N) (hd : 0 < d)
    (hKilling : 2 * mu + gamma = 2 * (N - 2) * d) (hgamma : 0 ≤ gamma)
    (hCasimir : 4 * d ^ 2 / N - 2 * d ≤ mu) :
    d ≤ N ^ 2 / 4 := by
  have hmu : mu ≤ (N - 2) * d := by linarith
  have h1 : 4 * d ^ 2 / N ≤ N * d := by
    have := le_trans hCasimir hmu
    linarith
  rw [div_le_iff₀ hN] at h1
  nlinarith

/-- **And the intermediate inequality the chain passes through**, `μ ≤ (n-2)d`, which is the
whole of what isotropy buys: it makes `‖P⊥[e_a,e_b]‖² = ‖[e_a,e_b]‖²`, so the `𝔥𝔥𝔪` mass `γ` is
available as a sum of squares. -/
theorem mu_le {N d mu gamma : ℝ} (hKilling : 2 * mu + gamma = 2 * (N - 2) * d)
    (hgamma : 0 ≤ gamma) : mu ≤ (N - 2) * d := by linarith

/-! ## The hypotheses are inhabited, and non-trivially

A single line is isotropic for a reason that carries no information, `[u,v] = 0` when `u` and
`v` are collinear, but it does show the `∃` clause of the statement below is asking for
something the smaller cases already deliver. -/

/-- **Every line through a skew matrix is isotropic**, so the hypotheses of L36 are satisfied by
a subspace of dimension `1`. -/
theorem line_isotropic (X : Matrix (Fin n) (Fin n) ℝ) :
    Isotropic (Submodule.span ℝ {X}) := by
  intro u hu v hv w _
  rw [Submodule.mem_span_singleton] at hu hv
  obtain ⟨a, rfl⟩ := hu
  obtain ⟨b, rfl⟩ := hv
  have : br (a • X) (b • X) = 0 := by
    unfold br
    rw [Matrix.smul_mul, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_smul]
    rw [smul_smul, smul_smul, mul_comm a b]
    simp
  rw [this]
  unfold inner2
  simp

/-- **At `n = 3` the cap reads `d ≤ 2`**, which is `⌊9/4⌋`, the parity value the record checks,
and the dimension at which its own `-2` eigenvalue argument is unavailable because `𝒲₃ = 0`. -/
theorem cap_at_three : (3 : ℕ) ^ 2 / 4 = 2 := by norm_num

end HamiltonsCubic.L36Statement

namespace HamiltonsCubic.L36Proof

open HamiltonsCubic.RealLayer Matrix

variable {n d : ℕ}

/-- `‖[A,B]‖² = tr(A²B²) - tr(ABAB)` on skew matrices. -/
theorem brnorm (A B : Matrix (Fin n) (Fin n) ℝ) (hA : IsSkew A) (hB : IsSkew B) :
    inner2 (br A B) (br A B) = ((A * A) * (B * B)).trace - (A * (B * (A * B))).trace := by
  unfold inner2 br
  unfold IsSkew at hA hB
  rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hA, hB]
  simp only [Matrix.neg_mul, Matrix.mul_neg, neg_neg, Matrix.sub_mul, Matrix.mul_sub, Matrix.trace_sub,
    Matrix.mul_assoc]
  have t1 : (B * (A * (B * A))).trace = (A * (B * (A * B))).trace := by
    rw [Matrix.trace_mul_comm B, Matrix.mul_assoc, Matrix.mul_assoc]
  have t2 : (B * (A * (A * B))).trace = ((A * A) * (B * B)).trace := by
    rw [Matrix.trace_mul_comm B, Matrix.mul_assoc, Matrix.mul_assoc, ← Matrix.mul_assoc A A]
  have t3 : (A * (B * (B * A))).trace = ((A * A) * (B * B)).trace := by
    rw [Matrix.trace_mul_comm A, Matrix.mul_assoc, Matrix.mul_assoc, ← Matrix.mul_assoc B B,
      Matrix.trace_mul_comm]
  rw [t1, t2, t3, ← Matrix.mul_assoc A A (B * B)]
  ring

/-- `tr(ABAB) = -Σ A_ij A_kl B_ik B_lj` for skew `A`. -/
theorem trABAB (A B : Matrix (Fin n) (Fin n) ℝ) (hA : IsSkew A) :
    (A * (B * (A * B))).trace = -∑ i, ∑ j, ∑ k, ∑ l, A i j * A k l * (B i k * B l j) := by
  have hA' : ∀ p q, A q p = -A p q := fun p q => by
    have := congrFun (congrFun hA p) q; simpa [Matrix.transpose_apply] using this
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Finset.mul_sum, ← Finset.sum_neg_distrib]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl fun r _ =>
    Finset.sum_congr rfl fun s _ => by rw [hA' p q]; ring


theorem sum_pull {α β : Type*} [Fintype α] [Fintype β] (G : α → β → β → β → β → ℝ) :
    ∑ a, ∑ i, ∑ j, ∑ k, ∑ l, G a i j k l = ∑ i, ∑ j, ∑ k, ∑ l, ∑ a, G a i j k l := by
  calc ∑ a, ∑ i, ∑ j, ∑ k, ∑ l, G a i j k l = ∑ i, ∑ a, ∑ j, ∑ k, ∑ l, G a i j k l := Finset.sum_comm
    _ = ∑ i, ∑ j, ∑ a, ∑ k, ∑ l, G a i j k l := Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ i, ∑ j, ∑ k, ∑ a, ∑ l, G a i j k l :=
        Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_comm
    _ = ∑ i, ∑ j, ∑ k, ∑ l, ∑ a, G a i j k l := Finset.sum_congr rfl fun i _ =>
        Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => Finset.sum_comm

section Proj
variable {e : Fin d → Matrix (Fin n) (Fin n) ℝ}

/-- The orthogonal projector onto the span of an orthonormal family. -/
noncomputable def P (e : Fin d → Matrix (Fin n) (Fin n) ℝ) (X : Matrix (Fin n) (Fin n) ℝ) :
    Matrix (Fin n) (Fin n) ℝ := ∑ a, inner2 (e a) X • e a

theorem P_skew (hs : ∀ a, IsSkew (e a)) (X : Matrix (Fin n) (Fin n) ℝ) : IsSkew (P e X) :=
  HamiltonsCubic.L41Statement.Frame.isSkew_sum _ _ _ hs

theorem inner_P (hon : ∀ a b, inner2 (e a) (e b) = if a = b then 1 else 0) (Y : Matrix (Fin n) (Fin n) ℝ) :
    inner2 (P e Y) (P e Y) = ∑ a, inner2 (e a) Y ^ 2 := by
  unfold P
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, HamiltonsCubic.L41Statement.Frame.inner2_sum_r]
  simp only [HamiltonsCubic.L41Statement.Frame.inner2_smul_r, hon, mul_ite, mul_one, mul_zero,
    Finset.sum_ite_eq, Finset.mem_univ, if_true]
  ring

theorem normSq_P (hs : ∀ a, IsSkew (e a)) (hon : ∀ a b, inner2 (e a) (e b) = if a = b then 1 else 0) :
    normSq (P e) = d := by
  unfold normSq innerOp
  simp only [inner_P hon]
  have h1 : ∀ a, (1 / 2) * ∑ i, ∑ j, inner2 (e a) (phi i j) ^ 2 = 1 := fun a => by
    have := HamiltonsCubic.L41Statement.Frame.parseval (e a) (e a) (hs a) (hs a)
    rw [hon a a, if_pos rfl] at this
    simpa [sq] using this
  have hsw : ∑ i, ∑ j, ∑ a, inner2 (e a) (phi i j) ^ 2 = ∑ a, ∑ i, ∑ j, inner2 (e a) (phi i j) ^ 2 := by
    calc _ = ∑ i, ∑ a, ∑ j, inner2 (e a) (phi i j) ^ 2 := Finset.sum_congr rfl fun i _ => Finset.sum_comm
      _ = _ := Finset.sum_comm
  rw [hsw, Finset.mul_sum]
  simp only [h1, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, mul_one]

theorem XX_P (hs : ∀ a, IsSkew (e a)) :
    HamiltonsCubic.L15Statement.Proof.XX (P e) = ∑ i, ∑ j, ∑ k, ∑ l, ∑ a, ∑ b,
      e a i j * e a k l * (e b i k * e b l j) := by
  unfold HamiltonsCubic.L15Statement.Proof.XX
  have hent : ∀ i j k l, P e (phi i j) k l = -∑ a, e a i j * e a k l := by
    intro i j k l
    unfold P
    rw [Matrix.sum_apply, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Matrix.smul_apply, smul_eq_mul, inner2_phi _ (hs a)]
    ring
  simp only [hent]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
    Finset.sum_congr rfl fun l _ => ?_
  rw [neg_mul_neg, Finset.sum_mul_sum]

theorem S2_eq (hs : ∀ a, IsSkew (e a)) :
    ∑ a, ∑ b, (e a * (e b * (e a * e b))).trace = -HamiltonsCubic.L15Statement.Proof.XX (P e) := by
  simp only [trABAB _ _ (hs _)]
  rw [XX_P hs]
  simp only [Finset.sum_neg_distrib]
  congr 1
  calc _ = ∑ a, ∑ i, ∑ j, ∑ k, ∑ l, ∑ b, e a i j * e a k l * (e b i k * e b l j) :=
        Finset.sum_congr rfl fun a _ => sum_pull (fun b i j k l => e a i j * e a k l * (e b i k * e b l j))
    _ = _ := sum_pull (fun a i j k l => ∑ b, e a i j * e a k l * (e b i k * e b l j))

/-- **The universal lower bound on the bracket mass, `μ ≥ 4d²/n - 2d`**, from L15's `Alt`
expansion applied to the projector onto the span. -/
theorem mu_ge (hs : ∀ a, IsSkew (e a)) (hon : ∀ a b, inner2 (e a) (e b) = if a = b then 1 else 0)
    (hn : 0 < n) :
    4 * (d : ℝ) ^ 2 / n - 2 * d ≤ ∑ a, ∑ b, inner2 (br (e a) (e b)) (br (e a) (e b)) := by
  simp only [brnorm _ _ (hs _) (hs _), Finset.sum_sub_distrib]
  rw [S2_eq hs]
  set M : Matrix (Fin n) (Fin n) ℝ := ∑ a, e a * e a with hM
  have hMM : ∑ a, ∑ b, ((e a * e a) * (e b * e b)).trace = (M * M).trace := by
    rw [hM, Finset.sum_mul]
    simp only [Finset.mul_sum, Matrix.trace_sum]
  have hsq : ∀ a, (e a * e a).trace = -2 := fun a => by
    have h := hon a a
    rw [if_pos rfl] at h
    unfold inner2 at h
    rw [hs a, Matrix.neg_mul, Matrix.trace_neg] at h
    linarith
  have htr : M.trace = -2 * d := by
    rw [hM, Matrix.trace_sum]
    simp [hsq, mul_comm]
  have hsym : ∀ i j, M j i = M i j := by
    intro i j
    have hMt : Mᵀ = M := by
      rw [hM, Matrix.transpose_sum]
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [Matrix.transpose_mul, hs a, neg_mul_neg]
    have := congrFun (congrFun hMt i) j
    simpa [Matrix.transpose_apply] using this
  have hCS : M.trace ^ 2 ≤ n * (M * M).trace := by
    have h1 : (M * M).trace = ∑ i, ∑ j, M i j ^ 2 := by
      simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply]
      exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [hsym i j]; ring
    have h2 : ∑ i, M i i ^ 2 ≤ ∑ i, ∑ j, M i j ^ 2 := Finset.sum_le_sum fun i _ =>
      Finset.single_le_sum (f := fun j => M i j ^ 2) (fun j _ => sq_nonneg _) (Finset.mem_univ i)
    have h3 := sq_sum_le_card_mul_sum_sq (s := Finset.univ) (f := fun i => M i i)
    simp only [Finset.card_univ, Fintype.card_fin] at h3
    rw [h1]
    have : M.trace = ∑ i, M i i := rfl
    rw [this]
    nlinarith [h2, h3]
  have hXX : -2 * (d : ℝ) ≤ HamiltonsCubic.L15Statement.Proof.XX (P e) := by
    have h1 := HamiltonsCubic.L15Statement.Proof.alt_eq (R := P e) (fun X _ => P_skew hs X)
    have h2 := HamiltonsCubic.L15Statement.Proof.normSq_eq (R := P e) (fun X _ => P_skew hs X)
    have h3 := HamiltonsCubic.AltLayer.altNormSq_nonneg (P e)
    rw [normSq_P hs hon] at h2
    linarith
  rw [hMM]
  have hn' : (0 : ℝ) < n := by exact_mod_cast hn
  have h4 : 4 * (d : ℝ) ^ 2 / n ≤ (M * M).trace := by
    rw [div_le_iff₀ hn']
    rw [htr] at hCS
    nlinarith [hCS]
  linarith

end Proj


open HamiltonsCubic.L41Statement.Frame in
/-- **The upper bound `μ ≤ (n-2)d` for an isotropic orthonormal family**, from the Killing row on
a completed frame. -/
theorem mu_le {e : Fin d → Matrix (Fin n) (Fin n) ℝ} (hs : ∀ a, IsSkew (e a))
    (hon : ∀ a b, inner2 (e a) (e b) = if a = b then 1 else 0)
    (hiso : ∀ a b c, inner2 (br (e a) (e b)) (e c) = 0) :
    ∑ a, ∑ b, inner2 (br (e a) (e b)) (br (e a) (e b)) ≤ ((n : ℝ) - 2) * d := by
  classical
  obtain ⟨r, g, hgs, hgon, heg, hcomp⟩ := HamiltonsCubic.FrameExtension.extend_frame e hs hon
  let v : Fin d ⊕ Fin r → Matrix (Fin n) (Fin n) ℝ := Sum.elim e g
  have hge : ∀ c a, inner2 (g c) (e a) = 0 := fun c a => by rw [inner2_comm]; exact heg a c
  have hf : HamiltonsCubic.L41Statement.EigenFrame (fun _ => (0 : Matrix (Fin n) (Fin n) ℝ)) v
      (fun _ => 0) := by
    refine ⟨?_, ?_, fun γ => by simp, fun X hX => ?_⟩
    · rintro (a|c); exacts [hs a, hgs c]
    · rintro (a|c) (b|c') <;> simp [v, hon, hgon, heg, hge]
    · rw [Fintype.sum_sum_type]; exact hcomp X hX
  have hiso0 : ∀ a b b', cst v (Sum.inl a) (Sum.inl b) (Sum.inl b') = 0 := fun a b b' => hiso a b b'
  have hkill : ∀ a, ∑ α, ∑ β, cst v (Sum.inl a) α β ^ 2 = 2 * ((n : ℝ) - 2) := fun a => by
    have := killing_frame HamiltonsCubic.L77Proof.zero_weyl hf (Sum.inl a)
    simpa using this
  have hmu_a : ∀ a b, inner2 (br (e a) (e b)) (br (e a) (e b))
      = ∑ c, cst v (Sum.inl a) (Sum.inl b) (Sum.inr c) ^ 2 := by
    intro a b
    have := brnorm_frame hf (Sum.inl a) (Sum.inl b)
    rw [Fintype.sum_sum_type] at this
    simp only [hiso0, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, Finset.sum_const_zero,
      zero_add] at this
    exact this
  have hsplit : ∀ a, ∑ α, ∑ β, cst v (Sum.inl a) α β ^ 2
      = 2 * ∑ b, ∑ c, cst v (Sum.inl a) (Sum.inl b) (Sum.inr c) ^ 2
        + ∑ c, ∑ c', cst v (Sum.inl a) (Sum.inr c) (Sum.inr c') ^ 2 := by
    intro a
    simp only [Fintype.sum_sum_type, hiso0, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow,
      Finset.sum_const_zero, zero_add, Finset.sum_add_distrib]
    have hswap : ∑ c, ∑ b, cst v (Sum.inl a) (Sum.inr c) (Sum.inl b) ^ 2
        = ∑ b, ∑ c, cst v (Sum.inl a) (Sum.inl b) (Sum.inr c) ^ 2 := by
      rw [Finset.sum_comm]
      exact Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => (T23 hf _ _ _).symm
    rw [hswap]; ring
  have hT : 0 ≤ ∑ a, ∑ c, ∑ c', cst v (Sum.inl a) (Sum.inr c) (Sum.inr c') ^ 2 :=
    Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => sq_nonneg _
  have htot : ∑ a : Fin d, ∑ α, ∑ β, cst v (Sum.inl a) α β ^ 2 = 2 * ((n : ℝ) - 2) * d := by
    simp only [hkill, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]; ring
  simp only [hsplit, Finset.sum_add_distrib, ← Finset.mul_sum] at htot
  simp only [hmu_a]
  nlinarith [htot, hT]


/-- **Every subspace of `𝔰𝔬(n)` has an `inner2`-orthonormal basis indexed by `Fin (dim 𝔪)`.** -/
theorem exists_onb (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) (hm : ∀ A ∈ m, IsSkew A) :
    ∃ e : Fin (Module.finrank ℝ m) → Matrix (Fin n) (Fin n) ℝ, (∀ a, e a ∈ m) ∧ (∀ a, IsSkew (e a)) ∧
      (∀ a b, inner2 (e a) (e b) = if a = b then 1 else 0) := by
  classical
  open HamiltonsCubic.FrameExtension in
  let T : SkewSp (Fin n) →ₗ[ℝ] Matrix (Fin n) (Fin n) ℝ :=
    { toFun := toM, map_add' := toM_add, map_smul' := toM_smul }
  let m' : Submodule ℝ (HamiltonsCubic.FrameExtension.SkewSp (Fin n)) := m.comap T
  have hinj : Function.Injective T := HamiltonsCubic.FrameExtension.toM_injective
  have hmap : m'.map T = m := by
    ext A
    constructor
    · rintro ⟨x, hx, rfl⟩; exact hx
    · intro hA
      refine ⟨HamiltonsCubic.FrameExtension.ofM A (hm A hA), ?_, ?_⟩
      · show T _ ∈ m; exact hA
      · rfl
  have hdim : Module.finrank ℝ m' = Module.finrank ℝ m := by
    rw [← hmap]; exact LinearEquiv.finrank_eq (Submodule.equivMapOfInjective T hinj m')
  let b := stdOrthonormalBasis ℝ m'
  refine ⟨fun a => HamiltonsCubic.FrameExtension.toM ((b (Fin.cast hdim.symm a) : m') :
      HamiltonsCubic.FrameExtension.SkewSp (Fin n)), fun a => ?_, fun a => ?_, fun a c => ?_⟩
  · exact (b (Fin.cast hdim.symm a)).2
  · exact HamiltonsCubic.FrameExtension.toM_skew _
  · have := orthonormal_iff_ite.mp b.orthonormal (Fin.cast hdim.symm a) (Fin.cast hdim.symm c)
    rw [Submodule.coe_inner, HamiltonsCubic.FrameExtension.inner_def] at this
    rw [this]
    simp [Fin.cast_inj]

/-- **The cap: an isotropic subspace of `𝔰𝔬(n)` has dimension at most `⌊n²/4⌋`.** -/
theorem cap (hn : 3 ≤ n) (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) (hm : ∀ A ∈ m, IsSkew A)
    (hiso : ∀ u ∈ m, ∀ v ∈ m, ∀ w ∈ m, inner2 (br u v) w = 0) :
    Module.finrank ℝ m ≤ n ^ 2 / 4 := by
  obtain ⟨e, hem, hes, heon⟩ := exists_onb m hm
  have hlow := mu_ge hes heon (by omega)
  have hup := mu_le hes heon (fun a b c => hiso _ (hem a) _ (hem b) _ (hem c))
  have hn' : (0 : ℝ) < n := by exact_mod_cast (by omega : 0 < n)
  have key : (4 : ℝ) * Module.finrank ℝ m ≤ (n : ℝ) ^ 2 := by
    have h1 : 4 * (Module.finrank ℝ m : ℝ) ^ 2 / n ≤ n * Module.finrank ℝ m := by linarith
    rw [div_le_iff₀ hn'] at h1
    rcases Nat.eq_zero_or_pos (Module.finrank ℝ m) with h0 | hpos
    · rw [h0]; simp
    · have hd : (0 : ℝ) < Module.finrank ℝ m := by exact_mod_cast hpos
      nlinarith
  rw [Nat.le_div_iff_mul_le (by norm_num)]
  have : (Module.finrank ℝ m * 4 : ℝ) ≤ (n ^ 2 : ℝ) := by linarith
  exact_mod_cast this


/-! ## Attainment: the block off-diagonal skew matrices -/

/-- The mixed planes `ℝᵖ ⊗ ℝᵠ` inside `𝔰𝔬(n)`: skew matrices vanishing on both diagonal blocks. -/
def blockOff (n p : ℕ) : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ) where
  carrier := {A | IsSkew A ∧ ∀ i j : Fin n, (i.val < p ↔ j.val < p) → A i j = 0}
  add_mem' := by
    rintro A B ⟨hA, hA'⟩ ⟨hB, hB'⟩
    refine ⟨HamiltonsCubic.FrameExtension.skew_add' hA hB, fun i j h => ?_⟩
    simp [hA' i j h, hB' i j h]
  zero_mem' := ⟨by unfold IsSkew; simp, fun _ _ _ => rfl⟩
  smul_mem' := by
    rintro c A ⟨hA, hA'⟩
    exact ⟨HamiltonsCubic.FrameExtension.skew_smul' c hA, fun i j h => by simp [hA' i j h]⟩

theorem blockOff_isotropic (p : ℕ) : ∀ u ∈ blockOff n p, ∀ v ∈ blockOff n p, ∀ w ∈ blockOff n p,
    inner2 (br u v) w = 0 := by
  rintro u ⟨-, hu⟩ v ⟨-, hv⟩ w ⟨-, hw⟩
  have hprod : ∀ (X Y : Matrix (Fin n) (Fin n) ℝ), (∀ i j : Fin n, (i.val < p ↔ j.val < p) → X i j = 0) →
      (∀ i j : Fin n, (i.val < p ↔ j.val < p) → Y i j = 0) →
      ∀ i j : Fin n, ¬ (i.val < p ↔ j.val < p) → (X * Y) i j = 0 := by
    intro X Y hX hY i j hij
    rw [Matrix.mul_apply]
    refine Finset.sum_eq_zero fun k _ => ?_
    by_cases hik : (i.val < p ↔ k.val < p)
    · rw [hX i k hik, zero_mul]
    · rw [hY k j (by tauto), mul_zero]
  have hterm : ∀ i j : Fin n, ((u * v) j i - (v * u) j i) * w j i = 0 := by
    intro i j
    by_cases hji : (j.val < p ↔ i.val < p)
    · rw [hw j i hji, mul_zero]
    · rw [hprod u v hu hv j i hji, hprod v u hv hu j i hji, sub_self, zero_mul]
  have htr : ((u * v - v * u)ᵀ * w).trace = 0 := by
    simp only [Matrix.trace, Matrix.diag]
    refine Finset.sum_eq_zero fun i _ => ?_
    rw [Matrix.mul_apply]
    refine Finset.sum_eq_zero fun j _ => ?_
    rw [Matrix.transpose_apply, Matrix.sub_apply]
    exact hterm i j
  unfold inner2 br
  rw [htr, mul_zero]

/-- The upper-right index pairs. -/
abbrev UR (n p : ℕ) := {q : Fin n × Fin n // q.1.val < p ∧ p ≤ q.2.val}

theorem card_UR {p : ℕ} (hp : p < n) : Fintype.card (UR n p) = p * (n - p) := by
  classical
  rw [Fintype.card_subtype, ← Finset.univ_product_univ,
    Finset.filter_product (fun i : Fin n => i.val < p) (fun j : Fin n => p ≤ j.val), Finset.card_product]
  have h1 : (Finset.univ.filter fun i : Fin n => i.val < p) = Finset.Iio ⟨p, hp⟩ := by
    ext i; simp [Fin.lt_def]
  have h2 : (Finset.univ.filter fun j : Fin n => p ≤ j.val) = Finset.Ici ⟨p, hp⟩ := by
    ext i; simp [Fin.le_def]
  rw [h1, h2, Fin.card_Iio, Fin.card_Ici]

theorem finrank_blockOff {p : ℕ} (hp : p < n) : Module.finrank ℝ (blockOff n p) = p * (n - p) := by
  classical
  let f : blockOff n p →ₗ[ℝ] (UR n p → ℝ) :=
    { toFun := fun A q => A.1 q.1.1 q.1.2
      map_add' := fun _ _ => rfl
      map_smul' := fun _ _ => rfl }
  have hinj : Function.Injective f := by
    rw [← LinearMap.ker_eq_bot, LinearMap.ker_eq_bot']
    intro A hA
    have hz : ∀ q : UR n p, A.1 q.1.1 q.1.2 = 0 := fun q => congrFun hA q
    have hsk : ∀ i j, A.1 j i = -A.1 i j := fun i j => by
      have := congrFun (congrFun A.2.1 i) j; simpa [Matrix.transpose_apply] using this
    apply Subtype.ext
    ext i j
    show A.1 i j = 0
    by_cases h : (i.val < p ↔ j.val < p)
    · exact A.2.2 i j h
    · by_cases hi : i.val < p
      · have hj : ¬ j.val < p := fun hj => h ⟨fun _ => hj, fun _ => hi⟩
        exact hz ⟨(i, j), hi, by show p ≤ j.val; omega⟩
      · have hj : j.val < p := by
          by_contra hj; exact h ⟨fun hi' => absurd hi' hi, fun hj' => absurd hj' hj⟩
        rw [hsk j i, hz ⟨(j, i), hj, by show p ≤ i.val; omega⟩, neg_zero]
  have hsurj : Function.Surjective f := by
    intro c
    refine ⟨⟨∑ q : UR n p, c q • (Matrix.single q.1.1 q.1.2 1 - Matrix.single q.1.2 q.1.1 1), ?_, ?_⟩, ?_⟩
    · unfold IsSkew
      rw [Matrix.transpose_sum, ← Finset.sum_neg_distrib]
      refine Finset.sum_congr rfl fun q _ => ?_
      rw [Matrix.transpose_smul, Matrix.transpose_sub, Matrix.transpose_single, Matrix.transpose_single,
        ← smul_neg, neg_sub]
    · intro i j hij
      rw [Matrix.sum_apply]
      refine Finset.sum_eq_zero fun q _ => ?_
      have h1 := q.2.1; have h2 := q.2.2
      simp only [Matrix.smul_apply, Matrix.sub_apply, Matrix.single_apply, smul_eq_mul]
      have e1 : ¬ (q.1.1 = i ∧ q.1.2 = j) := fun ⟨a, b⟩ => by subst a; subst b; omega
      have e2 : ¬ (q.1.2 = i ∧ q.1.1 = j) := fun ⟨a, b⟩ => by subst a; subst b; omega
      simp [e1, e2]
    · funext q
      show (∑ r : UR n p, c r • (Matrix.single r.1.1 r.1.2 (1 : ℝ) - Matrix.single r.1.2 r.1.1 1) :
        Matrix (Fin n) (Fin n) ℝ) q.1.1 q.1.2 = c q
      rw [Matrix.sum_apply, Finset.sum_eq_single q]
      · have hq1 := q.2.1; have hq2 := q.2.2
        have hne : q.1.2 ≠ q.1.1 := fun h => by rw [h] at hq2; omega
        simp [Matrix.single_apply, hne]
      · intro r _ hrq
        have hr1 := r.2.1; have hr2 := r.2.2; have hq1 := q.2.1; have hq2 := q.2.2
        simp only [Matrix.smul_apply, Matrix.sub_apply, Matrix.single_apply, smul_eq_mul]
        have e1 : ¬ (r.1.1 = q.1.1 ∧ r.1.2 = q.1.2) := fun ⟨a, b⟩ =>
          hrq (Subtype.ext (Prod.ext a b))
        have e2 : ¬ (r.1.2 = q.1.1 ∧ r.1.1 = q.1.2) := fun ⟨a, b⟩ => by
          rw [← a] at hq1; omega
        simp [e1, e2]
      · intro h; exact absurd (Finset.mem_univ q) h
  rw [LinearEquiv.finrank_eq (LinearEquiv.ofBijective f ⟨hinj, hsurj⟩), Module.finrank_fintype_fun_eq_card,
    card_UR hp]

theorem mixed_count (n : ℕ) : (n + 1) / 2 * (n - (n + 1) / 2) = n ^ 2 / 4 := by
  obtain ⟨k, rfl | rfl⟩ := Nat.even_or_odd' n
  · have h1 : (2 * k + 1) / 2 = k := by omega
    have h2 : (2 * k) ^ 2 = 4 * (k * k) := by ring
    rw [h1, h2, Nat.mul_div_cancel_left _ (by norm_num)]
    have : 2 * k - k = k := by omega
    rw [this]
  · have h1 : (2 * k + 1 + 1) / 2 = k + 1 := by omega
    have h2 : (2 * k + 1) ^ 2 = 1 + 4 * (k * k + k) := by ring
    rw [h1, h2, Nat.add_mul_div_left _ _ (by norm_num)]
    have : 2 * k + 1 - (k + 1) = k := by omega
    rw [this]
    norm_num
    ring

end HamiltonsCubic.L36Proof

namespace HamiltonsCubic.L36Statement

variable {n : ℕ}

/-! ## The statement itself -/

/-- **L36.** At every `n ≥ 3`: every isotropic subspace of `𝔰𝔬(n)` has dimension at most
`⌊n²/4⌋`, and that bound is attained.

**Both clauses are proved**: the cap by `L36Proof.cap` from the two mass bounds `mu_le` and
`mu_ge`, the attainment by the mixed planes `L36Proof.blockOff` at `p = ⌈n/2⌉`, of dimension
`p(n-p) = ⌊n²/4⌋` (`mixed_count`).

*The record's own "what it does not reach" applies to the equality **case** rather than to
attainment: forcing `𝔪⊥` to be a subalgebra at equality is complete only at even `n`. Attainment
itself holds at both parities, which is what is stated.* -/
theorem L36 (hn : 3 ≤ n) :
    (∀ m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ),
        SkewSub m → Isotropic m → Module.finrank ℝ m ≤ n ^ 2 / 4) ∧
      (∃ m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ),
        SkewSub m ∧ Isotropic m ∧ Module.finrank ℝ m = n ^ 2 / 4) := by
  refine ⟨fun m hm hiso => HamiltonsCubic.L36Proof.cap hn m hm hiso,
    HamiltonsCubic.L36Proof.blockOff n ((n + 1) / 2), fun A hA => hA.1,
    HamiltonsCubic.L36Proof.blockOff_isotropic _, ?_⟩
  rw [HamiltonsCubic.L36Proof.finrank_blockOff (by omega), HamiltonsCubic.L36Proof.mixed_count]

end HamiltonsCubic.L36Statement
