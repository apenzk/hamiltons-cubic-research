import HamiltonsCubic.Results.L7Record
import HamiltonsCubic.Results.EigenFrameExist
import HamiltonsCubic.Results.L70Symmetric

set_option linter.style.longLine false

/-!
# L107, the `Π`-bound `θ ≤ (n−1)|λ_min|`, at a critical point, in the eigenframe

[findings/bounds.md](../../../findings/bounds.md), Lemma L107: *with `μ_a = T_{a••}/2(n−2)` and `X = (λ_b+λ_c)/2`,
`Y = λ_bλ_c`, the pointwise facts `Y ≤ X²` and `(X − λ_min)(λ_max − X) ≥ 0` and the two row moments give
`λ_a(θ − λ_a) ≤ −(λ_min + λ_max)λ_a − (n−2)λ_min λ_max` for every `a`, and at `a = argmax` division by
`λ_max > 0` leaves `θ ≤ (n−1)|λ_min|`.*

In an orthonormal eigenframe, with `c_{γab} = ⟨[v_γ, v_a], v_b⟩`:

- row (A) is `killing_frame`, `∑ c² = 2(n−2)`; row (B) is `aW2_frame` and `aW2_mid`, `∑ λ_b c² = ∑ λ_a c² = −2λ_γ`;
  row (C) is `crit_frame`, `½ ∑ λ_aλ_b c² = θλ_γ − λ_γ²` at a critical point;
- `L107_row`: **`λ_γ(θ − λ_γ) ≤ −(λ_min + λ_max)λ_γ − (n−2)λ_min λ_max` at every `γ`**;
- `L107_frame`: **`θ ≤ (n−1)(−λ_min)`** at `γ` with `λ_γ = λ_max > 0`, and `L107_exists` in the spectral-theorem
  eigenframe of every critical linear Weyl operator.

- `L107_every`, `L107_every_exists`: **the record's `g`-route, the bound at every Weyl `W`**, `P(W) ≤ (n−1)(−λ_min)‖W‖²`,
  from L41's `first_identity`, `second_identity` and `g_γ ≥ 0`, no criticality.

- `L119_every`: [L119](../../../findings/bounds-relaxations.md)'s sharpened bound `4P ≤ |λ_min| ∑_{λ<0} g − λ_𝔭^min ∑_{λ>0} g`
  at every Weyl `W`, from the same identity;
- `L108_every`: [L108](../../../findings/bounds.md)'s Cauchy–Schwarz bound `16P² ≤ 4(n−1)‖W‖² G₂`, i.e. `|θ| ≤ ½√((n−1)G₂)`
  at unit norm, at every Weyl `W`;
- `gMass_neg`, `G2_neg`: `g` and `G₂` are even in `W`, the frame of `−W` being that of `W` with eigenvalues negated;
- `L108_eq_of_const`: `λ` constant on `supp(g)` gives `16P² = 4(n−1)‖W‖²G₂`, L108's equality clause in squared form;
- `L107_every_eq`: **L107's equality case**, `P = (n−1)(−λ_min)‖W‖²` iff `supp(g) ⊆ E_min`.
-/

namespace HamiltonsCubic.L41Statement

open HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement.Frame HamiltonsCubic.L7Frame

variable {ι : Type} [Fintype ι] [DecidableEq ι] {Γ : Type} [Fintype Γ] [DecidableEq Γ]

/-- **L107's row inequality** at a critical point, every `γ`. -/
theorem L107_row {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W)
    (hWl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      W (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • W (x k))
    (hsk : ∀ X, IsSkew X → IsSkew (W X)) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical W θ)
    (m M : ℝ) (hlo : ∀ a, m ≤ lam a) (hhi : ∀ a, lam a ≤ M) (γ : Γ) :
    lam γ * (θ - lam γ) ≤ -(m + M) * lam γ - ((Fintype.card ι : ℝ) - 2) * (m * M) := by
  have hC := crit_frame hWl hsk hf θ hc γ
  have hA := killing_frame hW hf γ
  have hB1 := aW2_frame hW hf γ
  have hB2 := aW2_mid hW hf γ
  -- `ω_{abγ}² = c_{γab}²`
  have hω : ∀ a b, omegaF v a b γ ^ 2 = cst v γ a b ^ 2 := fun a b => by
    have : omegaF v a b γ = cst v a b γ := rfl
    rw [this, ← cst_cyclic hf]
  simp only [hω] at hC
  -- the pointwise bound, weighted
  have hpt : ∀ a b, lam a * lam b * cst v γ a b ^ 2
      ≤ ((m + M) * ((lam a + lam b) / 2) - m * M) * cst v γ a b ^ 2 := by
    intro a b
    apply mul_le_mul_of_nonneg_right _ (sq_nonneg _)
    have h1 : lam a * lam b ≤ ((lam a + lam b) / 2) ^ 2 := by nlinarith [sq_nonneg (lam a - lam b)]
    have h2 : 0 ≤ ((lam a + lam b) / 2 - m) * (M - (lam a + lam b) / 2) := by
      apply mul_nonneg <;> linarith [hlo a, hlo b, hhi a, hhi b]
    nlinarith
  have hsum : ∑ a, ∑ b, lam a * lam b * cst v γ a b ^ 2
      ≤ ∑ a, ∑ b, ((m + M) * ((lam a + lam b) / 2) - m * M) * cst v γ a b ^ 2 :=
    Finset.sum_le_sum fun a _ => Finset.sum_le_sum fun b _ => hpt a b
  have hR : ∑ a, ∑ b, ((m + M) * ((lam a + lam b) / 2) - m * M) * cst v γ a b ^ 2
      = (m + M) / 2 * (∑ a, ∑ b, lam a * cst v γ a b ^ 2 + ∑ a, ∑ b, lam b * cst v γ a b ^ 2)
        - m * M * ∑ a, ∑ b, cst v γ a b ^ 2 := by
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  rw [hR, hA, hB1, hB2] at hsum
  nlinarith [hsum, hC]

/-- **L107, the `Π`-bound**: `θ ≤ (n−1)(−λ_min)` at a critical point, read at the row of `λ_max > 0`. -/
theorem L107_frame {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W)
    (hWl : ∀ {κ : Type} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ), (∀ k, IsSkew (x k)) →
      W (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • W (x k))
    (hsk : ∀ X, IsSkew X → IsSkew (W X)) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical W θ)
    (m M : ℝ) (hlo : ∀ a, m ≤ lam a) (hhi : ∀ a, lam a ≤ M) (γ : Γ) (hγ : lam γ = M) (hM : 0 < M) :
    θ ≤ ((Fintype.card ι : ℝ) - 1) * (-m) := by
  have h := L107_row hW hWl hsk hf θ hc m M hlo hhi γ
  rw [hγ] at h
  have : M * θ ≤ M * (((Fintype.card ι : ℝ) - 1) * (-m)) := by nlinarith
  exact le_of_mul_le_mul_left this hM

/-- **L107 at every Weyl `W`, by the record's `g`-route**: `g_γ = ‖[ad(v_γ), W]‖² ≥ 0`, `∑ g_γ = 4(n−1)‖W‖²` and
`∑ λ_γ g_γ = −4P(W)` give `P(W) ≤ (n−1)(−λ_min)‖W‖²`, with no criticality. -/
theorem L107_every {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (m : ℝ) (hlo : ∀ a, m ≤ lam a) :
    Pcubic W ≤ ((Fintype.card ι : ℝ) - 1) * (-m) * normSq W := by
  have h1 := first_identity hW hf
  have h2 := second_identity hW hf
  have hg : ∀ γ, 0 ≤ gMass W (v γ) := fun γ => by
    rw [pw17 hW hf]
    exact Finset.sum_nonneg fun α _ => Finset.sum_nonneg fun β _ => mul_nonneg (sq_nonneg _) (sq_nonneg _)
  have hle : m * ∑ γ, gMass W (v γ) ≤ ∑ γ, lam γ * gMass W (v γ) := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun γ _ => mul_le_mul_of_nonneg_right (hlo γ) (hg γ)
  rw [h1, h2] at hle
  nlinarith

/-- **L119, the sharpened `λ`-weighted bound, at every Weyl `W`**: with `λ_min ≤ λ` on the spectrum and `c ≤ λ` on its
strictly positive part `𝔭`, `4P(W) ≤ |λ_min| ∑_{λ<0} g − c ∑_{λ>0} g`, the record's `M` and `Δ`; no criticality. -/
theorem L119_every {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (m c : ℝ) (hlo : ∀ a, m ≤ lam a) (hc : ∀ a, 0 < lam a → c ≤ lam a) :
    4 * Pcubic W ≤ (-m) * (∑ γ ∈ Finset.univ.filter (fun γ => lam γ < 0), gMass W (v γ))
      - c * (∑ γ ∈ Finset.univ.filter (fun γ => 0 < lam γ), gMass W (v γ)) := by
  have h2 := second_identity hW hf
  have hg : ∀ γ, 0 ≤ gMass W (v γ) := fun γ => by
    rw [pw17 hW hf]
    exact Finset.sum_nonneg fun α _ => Finset.sum_nonneg fun β _ => mul_nonneg (sq_nonneg _) (sq_nonneg _)
  have hpt : ∀ γ, (if lam γ < 0 then m * gMass W (v γ) else 0) + (if 0 < lam γ then c * gMass W (v γ) else 0)
      ≤ lam γ * gMass W (v γ) := by
    intro γ
    by_cases h1 : lam γ < 0
    · rw [if_pos h1, if_neg (by linarith)]
      nlinarith [hlo γ, hg γ]
    · rw [if_neg h1]
      by_cases h2 : 0 < lam γ
      · rw [if_pos h2]; nlinarith [hc γ h2, hg γ]
      · rw [if_neg h2]; have : lam γ = 0 := by linarith
        rw [this]; simp
  have hsum := Finset.sum_le_sum fun γ (_ : γ ∈ Finset.univ) => hpt γ
  rw [Finset.sum_add_distrib, h2, ← Finset.sum_filter, ← Finset.sum_filter, ← Finset.mul_sum,
    ← Finset.mul_sum] at hsum
  linarith

/-- **L108, the Cauchy–Schwarz bound, at every Weyl `W`**: `16 P(W)² ≤ 4(n−1)‖W‖² · G₂` with `G₂ = ∑ λ² g`, which at unit
norm is `|θ| ≤ ½ √((n−1) G₂)`; the sign-free form, no criticality. -/
theorem L108_every {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) :
    16 * Pcubic W ^ 2 ≤ 4 * ((Fintype.card ι : ℝ) - 1) * normSq W * ∑ γ, lam γ ^ 2 * gMass W (v γ) := by
  have h1 := first_identity hW hf
  have h2 := second_identity hW hf
  have hg : ∀ γ, 0 ≤ gMass W (v γ) := fun γ => by
    rw [pw17 hW hf]
    exact Finset.sum_nonneg fun α _ => Finset.sum_nonneg fun β _ => mul_nonneg (sq_nonneg _) (sq_nonneg _)
  -- Cauchy–Schwarz with weights `g`: `(∑ λ g)² ≤ (∑ g)(∑ λ² g)`
  have hcs2 : (∑ γ, lam γ * gMass W (v γ)) ^ 2 ≤ (∑ γ, gMass W (v γ)) * ∑ γ, lam γ ^ 2 * gMass W (v γ) := by
    have := Finset.sum_mul_sq_le_sq_mul_sq Finset.univ (fun γ => Real.sqrt (gMass W (v γ)))
      (fun γ => lam γ * Real.sqrt (gMass W (v γ)))
    have e1 : ∀ γ, Real.sqrt (gMass W (v γ)) * (lam γ * Real.sqrt (gMass W (v γ))) = lam γ * gMass W (v γ) :=
      fun γ => by rw [← mul_assoc, mul_comm (Real.sqrt _) (lam γ), mul_assoc, Real.mul_self_sqrt (hg γ)]
    have e2 : ∀ γ, Real.sqrt (gMass W (v γ)) ^ 2 = gMass W (v γ) := fun γ => Real.sq_sqrt (hg γ)
    have e3 : ∀ γ, (lam γ * Real.sqrt (gMass W (v γ))) ^ 2 = lam γ ^ 2 * gMass W (v γ) := fun γ => by
      rw [mul_pow, Real.sq_sqrt (hg γ)]
    simp only [e1, e2, e3] at this
    exact this
  rw [h1, h2] at hcs2
  nlinarith [hcs2]

/-- **L113's two moment inequalities for the record's `g`**: with `m_k = ∑ λ^k g`, Cauchy–Schwarz `m₁² ≤ m₀ m₂`, and the
support bound `m₂ ≤ (a+b) m₁ − ab m₀` whenever `a ≤ λ ≤ b` on the spectrum. -/
theorem g_moments {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (a b : ℝ) (ha : ∀ γ, a ≤ lam γ) (hb : ∀ γ, lam γ ≤ b) :
    (∑ γ, lam γ * gMass W (v γ)) ^ 2 ≤ (∑ γ, gMass W (v γ)) * ∑ γ, lam γ ^ 2 * gMass W (v γ) ∧
      ∑ γ, lam γ ^ 2 * gMass W (v γ)
        ≤ (a + b) * ∑ γ, lam γ * gMass W (v γ) - a * b * ∑ γ, gMass W (v γ) := by
  have hg : ∀ γ, 0 ≤ gMass W (v γ) := fun γ => by
    rw [pw17 hW hf]
    exact Finset.sum_nonneg fun α _ => Finset.sum_nonneg fun β _ => mul_nonneg (sq_nonneg _) (sq_nonneg _)
  constructor
  · have := Finset.sum_mul_sq_le_sq_mul_sq Finset.univ (fun γ => Real.sqrt (gMass W (v γ)))
      (fun γ => lam γ * Real.sqrt (gMass W (v γ)))
    have e1 : ∀ γ, Real.sqrt (gMass W (v γ)) * (lam γ * Real.sqrt (gMass W (v γ))) = lam γ * gMass W (v γ) :=
      fun γ => by rw [← mul_assoc, mul_comm (Real.sqrt _) (lam γ), mul_assoc, Real.mul_self_sqrt (hg γ)]
    have e2 : ∀ γ, Real.sqrt (gMass W (v γ)) ^ 2 = gMass W (v γ) := fun γ => Real.sq_sqrt (hg γ)
    have e3 : ∀ γ, (lam γ * Real.sqrt (gMass W (v γ))) ^ 2 = lam γ ^ 2 * gMass W (v γ) := fun γ => by
      rw [mul_pow, Real.sq_sqrt (hg γ)]
    simp only [e1, e2, e3] at this
    exact this
  · have h0 : 0 ≤ ∑ γ, (lam γ - a) * (b - lam γ) * gMass W (v γ) :=
      Finset.sum_nonneg fun γ _ => mul_nonneg (mul_nonneg (by linarith [ha γ]) (by linarith [hb γ])) (hg γ)
    have e : ∑ γ, (lam γ - a) * (b - lam γ) * gMass W (v γ)
        = (a + b) * ∑ γ, lam γ * gMass W (v γ) - a * b * ∑ γ, gMass W (v γ) - ∑ γ, lam γ ^ 2 * gMass W (v γ) := by
      simp only [Finset.mul_sum, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun γ _ => by ring
    linarith

/-- `g` is even in `W`: `g_γ(−W) = g_γ(W)`. -/
theorem gMass_neg (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (x : Matrix ι ι ℝ) :
    gMass (fun X => -W X) x = gMass W x := by
  unfold gMass innerOp commOp adOp
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  have e : br x (-W (phi i j)) - -W (br x (phi i j)) = -(br x (W (phi i j)) - W (br x (phi i j))) := by
    unfold br; simp only [Matrix.mul_neg, Matrix.neg_mul]; abel
  rw [e]; unfold inner2; rw [Matrix.transpose_neg, Matrix.neg_mul, Matrix.mul_neg, neg_neg]

/-- **`G₂ = ∑ λ² g` is even in `W`**: the frame of `W` is a frame of `−W` with eigenvalues `−λ`, and `g` and `λ²` are
unchanged. -/
theorem G2_neg {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ} (hf : EigenFrame W v lam) :
    EigenFrame (fun X => -W X) v (fun γ => -lam γ) ∧
      ∑ γ, (-lam γ) ^ 2 * gMass (fun X => -W X) (v γ) = ∑ γ, lam γ ^ 2 * gMass W (v γ) := by
  refine ⟨⟨hf.skew, hf.orthonormal, fun γ => by simp only [hf.eigen γ, neg_smul], hf.complete⟩, ?_⟩
  exact Finset.sum_congr rfl fun γ _ => by rw [gMass_neg, neg_sq]

/-- **L108's equality in the direction the block keeps**: if `λ` is constant on `supp(g)`, then
`16 P(W)² = 4(n−1)‖W‖² G₂`. -/
theorem L108_eq_of_const {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (c : ℝ) (hc : ∀ γ, gMass W (v γ) ≠ 0 → lam γ = c) :
    16 * Pcubic W ^ 2 = 4 * ((Fintype.card ι : ℝ) - 1) * normSq W * ∑ γ, lam γ ^ 2 * gMass W (v γ) := by
  have h1 := first_identity hW hf
  have h2 := second_identity hW hf
  have e1 : ∀ γ, lam γ * gMass W (v γ) = c * gMass W (v γ) := fun γ => by
    by_cases h : gMass W (v γ) = 0
    · rw [h]; ring
    · rw [hc γ h]
  have e2 : ∀ γ, lam γ ^ 2 * gMass W (v γ) = c ^ 2 * gMass W (v γ) := fun γ => by
    by_cases h : gMass W (v γ) = 0
    · rw [h]; ring
    · rw [hc γ h]
  have m1 : ∑ γ, lam γ * gMass W (v γ) = c * ∑ γ, gMass W (v γ) := by
    simp only [e1, ← Finset.mul_sum]
  have m2 : ∑ γ, lam γ ^ 2 * gMass W (v γ) = c ^ 2 * ∑ γ, gMass W (v γ) := by
    simp only [e2, ← Finset.mul_sum]
  rw [m2, h1]
  rw [h2, h1] at m1
  have : Pcubic W = -(c * (4 * ((Fintype.card ι : ℝ) - 1) * normSq W)) / 4 := by linarith
  rw [this]; ring

/-- **L107's equality case**: at `m = λ_min` (attained or not), `P(W) = (n−1)(−m)‖W‖²` iff `g` is supported where
`λ = m`, i.e. `supp(g) ⊆ E_min`. -/
theorem L107_every_eq {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame W v lam) (m : ℝ) (hlo : ∀ a, m ≤ lam a) :
    Pcubic W = ((Fintype.card ι : ℝ) - 1) * (-m) * normSq W ↔ ∀ γ, gMass W (v γ) ≠ 0 → lam γ = m := by
  have h1 := first_identity hW hf
  have h2 := second_identity hW hf
  have hg : ∀ γ, 0 ≤ gMass W (v γ) := fun γ => by
    rw [pw17 hW hf]
    exact Finset.sum_nonneg fun α _ => Finset.sum_nonneg fun β _ => mul_nonneg (sq_nonneg _) (sq_nonneg _)
  have hterm : ∀ γ, 0 ≤ (lam γ - m) * gMass W (v γ) := fun γ => mul_nonneg (by linarith [hlo γ]) (hg γ)
  have hsum : ∑ γ, (lam γ - m) * gMass W (v γ)
      = -4 * Pcubic W - m * (4 * ((Fintype.card ι : ℝ) - 1) * normSq W) := by
    rw [← h1, ← h2, Finset.mul_sum, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun γ _ => by ring
  constructor
  · intro hP γ hγ
    have h0 : ∑ γ, (lam γ - m) * gMass W (v γ) = 0 := by rw [hsum, hP]; ring
    have := (Finset.sum_eq_zero_iff_of_nonneg fun γ _ => hterm γ).mp h0 γ (Finset.mem_univ γ)
    rcases mul_eq_zero.mp this with h | h
    · linarith
    · exact absurd h hγ
  · intro hsupp
    have h0 : ∑ γ, (lam γ - m) * gMass W (v γ) = 0 := Finset.sum_eq_zero fun γ _ => by
      by_cases h : gMass W (v γ) = 0
      · rw [h, mul_zero]
      · rw [hsupp γ h, sub_self, zero_mul]
    rw [hsum] at h0; linarith

end HamiltonsCubic.L41Statement

namespace HamiltonsCubic.EigenFrameExist

open HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement HamiltonsCubic.SecondKind

variable {n : ℕ}

/-- **L107 at every critical linear Weyl operator**, in the spectral-theorem eigenframe: with `λ_min ≤ μ ≤ λ_max` on
the spectrum of `M` and `λ_max > 0` attained, `θ ≤ (n−1)(−λ_min)`. -/
theorem L107_exists (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical W θ) (m M : ℝ)
    (hlo : ∀ j, m ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ M)
    (γ : Pairs n) (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = M) (hM : 0 < M) :
    θ ≤ ((n : ℝ) - 1) * (-m) := by
  have h := L107_frame hW.2 (fun s' c x hx => R_lin W hW.1 s' c x hx) hW.2.1
    (eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1) θ hc m M hlo hhi γ hγ hM
  simpa [Fintype.card_fin] using h

/-- **L107 at every linear Weyl operator of unit norm**, in the spectral-theorem eigenframe: `θ ≤ (n−1)(−λ_min)`. -/
theorem L107_every_exists (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (hn : normSq W = 1) (m : ℝ) (hlo : ∀ j, m ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j) :
    theta W ≤ ((n : ℝ) - 1) * (-m) := by
  have h := L107_every hW.2 (eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1) m hlo
  rw [hn, mul_one] at h
  rw [HamiltonsCubic.FamilyLayer.theta_of_unit W hn]
  simpa [Fintype.card_fin] using h

end HamiltonsCubic.EigenFrameExist
