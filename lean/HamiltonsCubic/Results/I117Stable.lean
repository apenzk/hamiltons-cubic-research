import HamiltonsCubic.Results.I117Sharp

set_option linter.style.longLine false
set_option linter.unusedSectionVars false


/-!
# The spectral bound behind L265's stability clause, in four indices

[second-order.md](../../../findings/second-order.md)'s L265 says `I/(n - 2)` is stable on `𝔰𝔬(n)` for `n ≥ 7`:
`I # ·` is at most `(n - 2)/2` on the traceless part of `Sym²(Λ²)`. Written through the four-index array
`T a b c d` of a self-adjoint operator (antisymmetric in each pair, symmetric under the pair swap), the form
`⟨I # H, H⟩` is a multiple of `P + ‖Ric T‖²` with `P = Σ T_{abcd} T_{acdb}`, and `‖H‖²` the same multiple of
`‖T‖²/2`. This file proves the four-index inequality

* **`stab_ineq`**: `4 (P + ‖Ric T‖²) ≤ (n - 2) ‖T‖²` whenever `Σ_{ab} T_{abab} = 0` and `n ≥ 6`,

from two squares. With `S` the cyclic sum `T_{abcd} + T_{acdb} + T_{adbc}` (three times the `Λ⁴` part) and
`Q = Ric ∧ g`, `‖S‖² = 3⟨T, S⟩` (`cyc_sq`), `⟨X, Q⟩ = 4⟨Ric X, Ric T⟩` for every pair-antisymmetric `X`
(`kn_pair`), `Ric S = 0` and `Ric Q = (n - 2) Ric T` at zero trace. Then `‖(n - 2)(T - S/3) - Q‖² ≥ 0` reads
`(n - 2)(‖T‖² - ⟨T, S⟩/3) ≥ 4‖Ric T‖²`, and with `⟨T, S⟩ ≥ 0` the bound follows for `n - 2 ≥ 4`.
-/

namespace HamiltonsCubic.I117T

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The four-fold sum. -/
def S4 (f : ι → ι → ι → ι → ℝ) : ℝ := ∑ a, ∑ b, ∑ c, ∑ d, f a b c d

theorem S4_add (f g : ι → ι → ι → ι → ℝ) :
    S4 (fun a b c d => f a b c d + g a b c d) = S4 f + S4 g := by
  simp only [S4, Finset.sum_add_distrib]

theorem S4_sub (f g : ι → ι → ι → ι → ℝ) :
    S4 (fun a b c d => f a b c d - g a b c d) = S4 f - S4 g := by
  simp only [S4, Finset.sum_sub_distrib]

theorem S4_smul (r : ℝ) (f : ι → ι → ι → ι → ℝ) : S4 (fun a b c d => r * f a b c d) = r * S4 f := by
  simp only [S4, Finset.mul_sum]

theorem S4_nonneg {f : ι → ι → ι → ι → ℝ} (h : ∀ a b c d, 0 ≤ f a b c d) : 0 ≤ S4 f :=
  Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => Finset.sum_nonneg fun c _ =>
    Finset.sum_nonneg fun d _ => h a b c d

theorem S4_congr {f g : ι → ι → ι → ι → ℝ} (h : ∀ a b c d, f a b c d = g a b c d) : S4 f = S4 g := by
  simp only [S4, h]

/-- **The cyclic relabelling of the last three slots.** -/
theorem S4_cyc (f : ι → ι → ι → ι → ℝ) : S4 (fun a b c d => f a c d b) = S4 f := by
  unfold S4
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [Finset.sum_comm]

/-- **The pair swap relabelling.** -/
theorem S4_pairs (f : ι → ι → ι → ι → ℝ) : S4 (fun a b c d => f c d a b) = S4 f := by
  unfold S4
  calc ∑ a, ∑ b, ∑ c, ∑ d, f c d a b = ∑ a, ∑ c, ∑ d, ∑ b, f c d a b :=
        Finset.sum_congr rfl fun a _ => by
          rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun c _ => Finset.sum_comm
    _ = ∑ c, ∑ d, ∑ a, ∑ b, f c d a b := by
        rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun c _ => Finset.sum_comm

/-- **The swap of the first two slots.** -/
theorem S4_swap12 (f : ι → ι → ι → ι → ℝ) : S4 (fun a b c d => f b a c d) = S4 f := by
  unfold S4; rw [Finset.sum_comm]

/-- **The swap of the last two slots.** -/
theorem S4_swap34 (f : ι → ι → ι → ι → ℝ) : S4 (fun a b c d => f a b d c) = S4 f := by
  unfold S4
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_comm

/-- **The swap of the middle two slots.** -/
theorem S4_swap23 (f : ι → ι → ι → ι → ℝ) : S4 (fun a b c d => f a c b d) = S4 f := by
  unfold S4
  exact Finset.sum_congr rfl fun a _ => Finset.sum_comm

theorem S4_neg (f : ι → ι → ι → ι → ℝ) : S4 (fun a b c d => - f a b c d) = - S4 f := by
  simp only [S4, Finset.sum_neg_distrib]

/-- Antisymmetric in each pair. -/
structure IsPairAnti (T : ι → ι → ι → ι → ℝ) : Prop where
  a1 : ∀ a b c d, T b a c d = - T a b c d
  a2 : ∀ a b c d, T a b d c = - T a b c d

/-- Antisymmetric in each pair and symmetric under the pair swap: a self-adjoint operator on `Λ²`. -/
structure IsPairT (T : ι → ι → ι → ι → ℝ) : Prop extends IsPairAnti T where
  s : ∀ a b c d, T c d a b = T a b c d

/-- The Ricci contraction `Ric(T)_{bd} = Σ_p T_{pbpd}`. -/
def ricT (T : ι → ι → ι → ι → ℝ) (b d : ι) : ℝ := ∑ p, T p b p d

/-- The cyclic sum over the last three slots, `S = T_{abcd} + T_{acdb} + T_{adbc}`. -/
def cycT (T : ι → ι → ι → ι → ℝ) (a b c d : ι) : ℝ := T a b c d + T a c d b + T a d b c

/-- The Kulkarni–Nomizu product `ρ ∧ g`. -/
def knT (ρ : ι → ι → ℝ) (a b c d : ι) : ℝ :=
  (if a = c then ρ b d else 0) - (if a = d then ρ b c else 0) - (if b = c then ρ a d else 0)
    + (if b = d then ρ a c else 0)

/-- `P = Σ T_{abcd} T_{acdb}`. -/
def pT (T : ι → ι → ι → ι → ℝ) : ℝ := S4 fun a b c d => T a b c d * T a c d b

/-- `‖T‖² = Σ T_{abcd}²`. -/
def nT (T : ι → ι → ι → ι → ℝ) : ℝ := S4 fun a b c d => T a b c d ^ 2

/-- `‖Ric T‖²`. -/
def rT (T : ι → ι → ι → ι → ℝ) : ℝ := ∑ b, ∑ d, ricT T b d ^ 2

variable {T : ι → ι → ι → ι → ℝ}

/-- **`‖Ric T‖²` as a four-fold sum.** -/
theorem rT_eq (T : ι → ι → ι → ι → ℝ) : rT T = S4 (fun a b c d => T a b a d * T c b c d) := by
  have e : rT T = S4 (fun b d p q => T p b p d * T q b q d) := by
    unfold rT ricT S4
    simp only [sq, Finset.sum_mul_sum]
  rw [e, (S4_pairs _).symm]
  exact S4_swap23 (fun a b c d => T a b a d * T c b c d)

/-- **`⟨T, S⟩ = ‖T‖² + 2P`.** -/
theorem inner_cyc (hT : IsPairT T) : S4 (fun a b c d => T a b c d * cycT T a b c d) = nT T + 2 * pT T := by
  have h3 : S4 (fun a b c d => T a b c d * T a d b c) = pT T := by
    rw [← S4_cyc]; unfold pT; exact S4_congr fun a b c d => by ring
  have e : S4 (fun a b c d => T a b c d * cycT T a b c d)
      = nT T + pT T + S4 (fun a b c d => T a b c d * T a d b c) := by
    unfold nT pT cycT; rw [← S4_add, ← S4_add]; exact S4_congr fun a b c d => by ring
  rw [e, h3]; ring

/-- **`‖S‖² = 3⟨T, S⟩`**: `S/3` is the orthogonal projection onto the totally antisymmetric part. -/
theorem cyc_sq (hT : IsPairT T) : S4 (fun a b c d => cycT T a b c d ^ 2) = 3 * (nT T + 2 * pT T) := by
  have n2 : S4 (fun a b c d => T a c d b ^ 2) = nT T := S4_cyc (fun a b c d => T a b c d ^ 2)
  have n3 : S4 (fun a b c d => T a d b c ^ 2) = nT T := by
    rw [← n2]; exact S4_cyc (fun a b c d => T a c d b ^ 2)
  have p13 : S4 (fun a b c d => T a b c d * T a d b c) = pT T := by
    rw [← S4_cyc]; unfold pT; exact S4_congr fun a b c d => by ring
  have p23 : S4 (fun a b c d => T a c d b * T a d b c) = pT T := S4_cyc (fun a b c d => T a b c d * T a c d b)
  have e : S4 (fun a b c d => cycT T a b c d ^ 2)
      = nT T + S4 (fun a b c d => T a c d b ^ 2) + S4 (fun a b c d => T a d b c ^ 2)
        + 2 * pT T + 2 * S4 (fun a b c d => T a b c d * T a d b c)
        + 2 * S4 (fun a b c d => T a c d b * T a d b c) := by
    unfold nT pT cycT; simp only [← S4_smul, ← S4_add]; exact S4_congr fun a b c d => by ring
  rw [e, n2, n3, p13, p23]; ring

/-- **`S` is antisymmetric in each pair.** -/
theorem cyc_anti (hT : IsPairT T) : IsPairAnti (cycT T) where
  a1 a b c d := by
    unfold cycT
    rw [hT.a1 a b c d, ← hT.s b c d a, hT.a1 a d b c, hT.s a c b d, hT.a2 a c d b]; ring
  a2 a b c d := by
    unfold cycT
    rw [hT.a2 a b c d, hT.a2 a d b c, hT.a2 a c d b]; ring

/-- **`Ric S = 0`.** -/
theorem ric_cyc (hT : IsPairT T) (b d : ι) : ricT (cycT T) b d = 0 := by
  unfold ricT cycT
  have h0 : ∀ p, T p p d b = 0 := fun p => by have := hT.a1 p p d b; linarith
  have hs : ∀ p, T p d b p = - T p b p d := fun p => by rw [hT.a2, hT.s]
  simp only [h0, hs, add_zero, Finset.sum_add_distrib, Finset.sum_neg_distrib]; ring

/-- **The contraction against `ρ ∧ g`**: `⟨X, ρ ∧ g⟩ = 4⟨Ric X, ρ⟩` for every pair-antisymmetric `X`. -/
theorem kn_pair {X : ι → ι → ι → ι → ℝ} (hX : IsPairAnti X) (ρ : ι → ι → ℝ) :
    S4 (fun a b c d => X a b c d * knT ρ a b c d) = 4 * ∑ i, ∑ j, ricT X i j * ρ i j := by
  have t1 : S4 (fun a b c d => X a b c d * (if a = c then ρ b d else 0)) = ∑ i, ∑ j, ricT X i j * ρ i j := by
    unfold S4 ricT
    simp only [mul_ite, mul_zero, Finset.sum_ite_irrel, Finset.sum_const_zero, Finset.sum_ite_eq, Finset.mem_univ,
      if_true, Finset.sum_mul]
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun b _ => Finset.sum_comm
  have t2 : S4 (fun a b c d => X a b c d * (if a = d then ρ b c else 0)) = - ∑ i, ∑ j, ricT X i j * ρ i j := by
    have h := S4_swap34 (fun a b c d => X a b c d * (if a = d then ρ b c else 0))
    rw [← h, ← t1, ← S4_neg]; exact S4_congr fun a b c d => by rw [hX.a2]; ring
  have t3 : S4 (fun a b c d => X a b c d * (if b = c then ρ a d else 0)) = - ∑ i, ∑ j, ricT X i j * ρ i j := by
    have h := S4_swap12 (fun a b c d => X a b c d * (if b = c then ρ a d else 0))
    rw [← h, ← t1, ← S4_neg]; exact S4_congr fun a b c d => by rw [hX.a1]; ring
  have t4 : S4 (fun a b c d => X a b c d * (if b = d then ρ a c else 0)) = ∑ i, ∑ j, ricT X i j * ρ i j := by
    have h := S4_swap12 (fun a b c d => X a b c d * (if b = d then ρ a c else 0))
    have h' := S4_swap34 (fun a b c d => X b a c d * (if a = d then ρ b c else 0))
    rw [← h, ← h', ← t1]; exact S4_congr fun a b c d => by rw [hX.a1, hX.a2]; ring
  have e : S4 (fun a b c d => X a b c d * knT ρ a b c d)
      = S4 (fun a b c d => X a b c d * (if a = c then ρ b d else 0))
        - S4 (fun a b c d => X a b c d * (if a = d then ρ b c else 0))
        - S4 (fun a b c d => X a b c d * (if b = c then ρ a d else 0))
        + S4 (fun a b c d => X a b c d * (if b = d then ρ a c else 0)) := by
    rw [← S4_sub, ← S4_sub, ← S4_add]; unfold knT; exact S4_congr fun a b c d => by ring
  rw [e, t1, t2, t3, t4]; ring

/-- **`ρ ∧ g` is antisymmetric in each pair.** -/
theorem kn_anti (ρ : ι → ι → ℝ) : IsPairAnti (knT ρ) where
  a1 a b c d := by unfold knT; ring
  a2 a b c d := by unfold knT; ring

/-- **`Ric(ρ ∧ g) = (n - 2)ρ`** at zero trace. -/
theorem ric_kn (ρ : ι → ι → ℝ) (htr : ∑ p, ρ p p = 0) (b d : ι) :
    ricT (knT ρ) b d = ((Fintype.card ι : ℝ) - 2) * ρ b d := by
  unfold ricT knT
  simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib, if_true, Finset.sum_ite_eq, Finset.sum_ite_eq',
    Finset.mem_univ, Finset.sum_const, Finset.card_univ, nsmul_eq_mul, Finset.sum_ite_irrel, htr,
    Finset.sum_const_zero]
  split_ifs <;> ring

/-- **L265's four-index bound**: `4(P + ‖Ric T‖²) ≤ (n - 2)‖T‖²` at zero trace, `n ≥ 6`. -/
theorem stab_ineq (hT : IsPairT T) (htr : ∑ a, ∑ b, T a b a b = 0) (hn : 6 ≤ Fintype.card ι) :
    4 * (pT T + rT T) ≤ ((Fintype.card ι : ℝ) - 2) * nT T := by
  set m : ℝ := (Fintype.card ι : ℝ) - 2 with hm
  have hm4 : 4 ≤ m := by rw [hm]; have : (6 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
                         linarith
  have hρtr : ∑ p, ricT T p p = 0 := by
    unfold ricT; rw [Finset.sum_comm]; exact htr
  set X := nT T + 2 * pT T with hX
  have hY := cyc_sq hT
  have hXS := inner_cyc hT
  have hTQ : S4 (fun a b c d => T a b c d * knT (ricT T) a b c d) = 4 * rT T := by
    rw [kn_pair hT.toIsPairAnti]; unfold rT; simp only [sq]
  have hSQ : S4 (fun a b c d => cycT T a b c d * knT (ricT T) a b c d) = 0 := by
    rw [kn_pair (cyc_anti hT)]; simp [ric_cyc hT]
  have hQQ : S4 (fun a b c d => knT (ricT T) a b c d ^ 2) = 4 * m * rT T := by
    have := kn_pair (kn_anti (ricT T)) (ricT T)
    simp only [ric_kn (ricT T) hρtr] at this
    rw [show (fun a b c d => knT (ricT T) a b c d ^ 2) = fun a b c d => knT (ricT T) a b c d * knT (ricT T) a b c d from
      funext fun a => funext fun b => funext fun c => funext fun d => sq _, this]
    unfold rT; simp only [hm, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_; ring
  -- the square
  have hsq := S4_nonneg (f := fun a b c d => (m * (T a b c d - cycT T a b c d / 3) - knT (ricT T) a b c d) ^ 2)
    (fun a b c d => sq_nonneg _)
  have e : S4 (fun a b c d => (m * (T a b c d - cycT T a b c d / 3) - knT (ricT T) a b c d) ^ 2)
      = m ^ 2 * nT T - (2 * m ^ 2 / 3) * S4 (fun a b c d => T a b c d * cycT T a b c d)
        + (m ^ 2 / 9) * S4 (fun a b c d => cycT T a b c d ^ 2)
        - 2 * m * S4 (fun a b c d => T a b c d * knT (ricT T) a b c d)
        + (2 * m / 3) * S4 (fun a b c d => cycT T a b c d * knT (ricT T) a b c d)
        + S4 (fun a b c d => knT (ricT T) a b c d ^ 2) := by
    unfold nT; simp only [← S4_smul, ← S4_add, ← S4_sub]; exact S4_congr fun a b c d => by ring
  rw [e, hXS, hY, hTQ, hSQ, hQQ] at hsq
  have hYn : 0 ≤ S4 (fun a b c d => cycT T a b c d ^ 2) := S4_nonneg fun a b c d => sq_nonneg _
  rw [hY] at hYn
  have hr : 0 ≤ rT T := by unfold rT; positivity
  have hm0 : 0 < m := by linarith
  -- m (N - X/3) ≥ 4 ‖Ric‖²
  have h1 : 4 * rT T ≤ m * (nT T - X / 3) := by
    have : m * (4 * rT T) ≤ m * (m * (nT T - X / 3)) := by rw [hX]; nlinarith
    exact le_of_mul_le_mul_left this hm0
  have hX0 : 0 ≤ X := by rw [hX]; linarith
  have h2 : 0 ≤ nT T - X / 3 := by nlinarith
  nlinarith [mul_nonneg (by linarith : (0 : ℝ) ≤ m - 4) hX0]

end HamiltonsCubic.I117T

/-!
# L265 on `𝔰𝔬(n)`: `I # ·` and the stability of `I/(n - 2)`

[second-order.md](../../../findings/second-order.md)'s L265, on `𝔰𝔬(n)`: `I # I = (n - 2)I`, `I # W = -W` on Weyl
operators, and `I/(n - 2)` is stable for `n ≥ 7`. The Weyl clause is [I117Sharp.lean](I117Sharp.lean)'s
`L265_weyl_clause`. The stability clause is proved here through the four-index array `T a b c d = (H φ_{cd})_{ab}`
of a self-adjoint `H`:

* **`normSq2_tOf`**, **`innerOp2_id_tOf`**: `‖H‖² = ¼‖T‖²` and `⟨H, I⟩ = -½ Σ_{ab} T_{abab}`;
* **`Ftri_id_tOf`**: `F(I, H, H) = ½(P + ‖Ric T‖²)`, `P = Σ T_{abcd} T_{acdb}`, from `Φ(H; I, H)` and the bracket
  table `br_phi_phi`;
* **`innerOp2_sharpB_eq_Ftri`**: `⟨H, C # H⟩ = F(C, H, H)` at self-adjoint `H`, which ties the polarised `sharpB` of
  the first two clauses to the `Ftri` of the third;
* **`L265_I_sharp`**: the three clauses, stability from `stab_ineq` below.

What the file leaves to the record: the scalars `(n - 4)/2` on `Sym²₀` and `2` on `Λ⁴` as operator statements (they
are ring identities in [I117LemmaF.lean](I117LemmaF.lean)'s `so_sharp_scalars`), the strictness of the stability for
`n ≥ 7` (the inequality is proved with `≤`, and holds already at `n ≥ 6`), and the general compact simple `𝔥`.
-/

namespace HamiltonsCubic.I117S

open HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge Matrix Finset HamiltonsCubic.I117T

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The four-index array of an operator on `Λ²`: `T a b c d = (H φ_{cd})_{ab}`. -/
noncomputable def tOf (H : CurvOp2 ι) (a b c d : ι) : ℝ := applyPhi H c d a b

theorem applyPhi_skew (H : CurvOp2 ι) (c d a b : ι) : applyPhi H c d b a = - applyPhi H c d a b := by
  have hs : IsSkew (applyPhi H c d) := (H ⟨phi c d, phi_mem_skewSub c d⟩ : skewSub ι).2
  have := congrFun (congrFun hs a) b
  simpa [Matrix.transpose_apply] using this

theorem applyPhi_swap (H : CurvOp2 ι) (c d : ι) : applyPhi H d c = - applyPhi H c d := by
  have e : (⟨phi d c, phi_mem_skewSub d c⟩ : skewSub ι) = -⟨phi c d, phi_mem_skewSub c d⟩ :=
    Subtype.ext (by rw [Submodule.coe_neg]; exact phi_swap c d)
  unfold applyPhi; rw [e, map_neg]; rfl

theorem tOf_isPairT {H : CurvOp2 ι} (hH : IsSelfAdjoint2 H) : IsPairT (tOf H) where
  a1 a b c d := applyPhi_skew H c d a b
  a2 a b c d := by unfold tOf; rw [applyPhi_swap]; rfl
  s a b c d := by
    unfold tOf
    have h1 := inner2_phi (applyPhi H a b) (H ⟨phi a b, phi_mem_skewSub a b⟩).2 c d
    have h2 := inner2_phi (applyPhi H c d) (H ⟨phi c d, phi_mem_skewSub c d⟩).2 a b
    have h3 := hH ⟨phi a b, phi_mem_skewSub a b⟩ ⟨phi c d, phi_mem_skewSub c d⟩
    rw [inner2_comm (phi a b : Matrix ι ι ℝ)] at h3
    change inner2 (applyPhi H a b) (phi c d) = inner2 (applyPhi H c d) (phi a b) at h3
    linarith

theorem inner2_self_sum (X : Matrix ι ι ℝ) : inner2 X X = (1 / 2) * ∑ a, ∑ b, X a b ^ 2 := by
  unfold inner2
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, sq]
  rw [Finset.sum_comm]

/-- **`‖H‖² = ¼ Σ T²`.** -/
theorem normSq2_tOf (H : CurvOp2 ι) : normSq2 H = (1 / 4) * nT (tOf H) := by
  unfold normSq2 innerOp2 nT
  simp only [inner2_self_sum]
  rw [← S4_pairs]
  unfold S4 tOf
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ =>
    Finset.sum_congr rfl fun d _ => ?_
  ring

/-- **`⟨H, I⟩ = -½ Σ T_{abab}`.** -/
theorem innerOp2_id_tOf (H : CurvOp2 ι) : innerOp2 H idOp = -(1 / 2) * ∑ a, ∑ b, tOf H a b a b := by
  unfold innerOp2 tOf
  have e : ∀ i j, inner2 (applyPhi H i j) (applyPhi (idOp : CurvOp2 ι) i j) = - applyPhi H i j i j := fun i j =>
    inner2_phi (applyPhi H i j) (H ⟨phi i j, phi_mem_skewSub i j⟩).2 i j
  simp only [e, Finset.sum_neg_distrib]; ring

theorem phiTri_H_id_H (H : CurvOp2 ι) :
    phiTri H idOp H = -(1/4) * ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι,
      inner2 (br (applyPhi H i j) (applyPhi H k l)) (br (phi i j) (phi k l)) := by
  unfold phiTri; rfl

theorem inner2_br_phi (H : CurvOp2 ι) (i j k l p q : ι) :
    inner2 (br (applyPhi H i j) (applyPhi H k l)) (phi p q) = - br (applyPhi H i j) (applyPhi H k l) p q :=
  inner2_phi _ (br_mem_skewSub (H ⟨phi i j, phi_mem_skewSub i j⟩).2 (H ⟨phi k l, phi_mem_skewSub k l⟩).2) p q

theorem br_neg_l (X Y : Matrix ι ι ℝ) : br (-X) Y = - br X Y := by
  unfold br; rw [Matrix.neg_mul, Matrix.mul_neg]; abel

theorem br_neg_r (X Y : Matrix ι ι ℝ) : br X (-Y) = - br X Y := by
  unfold br; rw [Matrix.neg_mul, Matrix.mul_neg]; abel

/-- **The first collapsed term**: `Σ_{ijl} [A_{ij}, A_{il}]_{jl} = -(P + ‖Ric T‖²)`, `A_{ij} = H φ_{ij}`. -/
theorem br_term (H : CurvOp2 ι) (hH : IsSelfAdjoint2 H) :
    ∑ i, ∑ j, ∑ l, br (applyPhi H i j) (applyPhi H i l) j l = -(pT (tOf H) + rT (tOf H)) := by
  have hT := tOf_isPairT hH
  have ha : S4 (fun i j l m => applyPhi H i j j m * applyPhi H i l m l) = - rT (tOf H) := by
    rw [rT_eq, ← S4_swap12, ← S4_neg]
    refine S4_congr fun i j l m => ?_
    show tOf H i m j i * tOf H m l j l = -(tOf H i j i m * tOf H l j l m)
    rw [hT.s j i i m, hT.a1 i j i m, hT.s j l m l, hT.a1 l j m l, hT.a2 l j l m]; ring
  have hb : S4 (fun i j l m => applyPhi H i l j m * applyPhi H i j m l) = pT (tOf H) := by
    unfold pT; rw [← S4_swap23]
    refine S4_congr fun i j l m => ?_
    show tOf H l m i j * tOf H m j i l = tOf H i j l m * tOf H i l m j
    rw [hT.s i j l m, hT.s i l m j]
  unfold S4 at ha hb
  simp only [br, Matrix.sub_apply, Matrix.mul_apply, Finset.sum_sub_distrib]
  linarith

/-- **`Φ(H; I, H) = -(P + ‖Ric T‖²)`.** -/
theorem phiTri_H_id_H_eq (H : CurvOp2 ι) (hH : IsSelfAdjoint2 H) :
    phiTri H idOp H = -(pT (tOf H) + rT (tOf H)) := by
  rw [phiTri_H_id_H]
  simp only [br_phi_phi, i2_add_r, i2_sub_r', i2_smul_r]
  simp only [inner2_br_phi]
  simp only [ite_mul, one_mul, zero_mul, Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_ite_irrel,
    Finset.sum_const_zero, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  have e2 : ∑ x, ∑ y, ∑ z, br (applyPhi H x y) (applyPhi H z y) x z
      = ∑ i, ∑ j, ∑ l, br (applyPhi H i j) (applyPhi H i l) j l := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => ?_
    rw [applyPhi_swap H i j, applyPhi_swap H i l, br_neg_l, br_neg_r, neg_neg]
  have e3 : ∑ x, ∑ y, ∑ z, br (applyPhi H x y) (applyPhi H z x) y z
      = - ∑ i, ∑ j, ∑ l, br (applyPhi H i j) (applyPhi H i l) j l := by
    simp only [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => ?_
    rw [applyPhi_swap H i l, br_neg_r, Matrix.neg_apply]
  have e4 : ∑ x, ∑ y, ∑ z, br (applyPhi H x y) (applyPhi H y z) x z
      = - ∑ i, ∑ j, ∑ l, br (applyPhi H i j) (applyPhi H i l) j l := by
    rw [Finset.sum_comm]
    simp only [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => ?_
    rw [applyPhi_swap H i j, br_neg_l, Matrix.neg_apply]
  simp only [Finset.sum_neg_distrib, e2, e3, e4, br_term H hH]
  ring

/-- **`F(I, H, H) = ½(P + ‖Ric T‖²)`.** -/
theorem Ftri_id_tOf (H : CurvOp2 ι) (hH : IsSelfAdjoint2 H) :
    Ftri idOp H H = (1 / 2) * (pT (tOf H) + rT (tOf H)) := by
  unfold Ftri
  rw [phiTri_rotate idOp_isSelfAdjoint2 H H, phiTri_rotate hH H idOp, phiTri_H_id_H_eq H hH]
  ring

/-- **The polarised product against `F`**: `⟨H, C # H⟩ = F(C, H, H)` at self-adjoint `H`. -/
theorem innerOp2_sharpB_eq_Ftri (C H : CurvOp2 ι) (hH : IsSelfAdjoint2 H) :
    innerOp2 H (sharpB C H) = Ftri C H H := by
  have e : innerOp2 H (sharpB C H) = (1/2) * (Ftri (C + H) (C + H) H - Ftri C C H - Ftri H H H) := by
    rw [Ftri_sharp, Ftri_sharp, Ftri_sharp]
    unfold sharpB
    rw [innerOp2_smul_right, innerOp2_comm, innerOp2_sub_left, innerOp2_sub_left,
      innerOp2_comm (sharpMapCL (C + H)), innerOp2_comm (sharpMapCL C), innerOp2_comm (sharpMapCL H)]
  rw [e, Ftri_add_left, Ftri_add_mid, Ftri_add_mid, Ftri_symm12 hH (A := H) (B := C)]
  ring

/-- **L265 on `𝔰𝔬(n)`**: `I # ·` is `(n - 2)` on `I` and `-1` on Weyl operators, and `I/(n - 2)` is stable for
`n ≥ 7`. *Stability is `stab_ineq` read through `tOf`: at `⟨H, I⟩ = 0`, `F(I, H, H) = ½(P + ‖Ric T‖²)` and
`‖H‖² = ¼‖T‖²`, so `F(I/(n - 2), H, H) ≤ ½‖H‖²` is `4(P + ‖Ric T‖²) ≤ (n - 2)‖T‖²`.* -/
theorem L265_I_sharp (hn : 7 ≤ Fintype.card ι) :
    sharpB (idOp : CurvOp2 ι) idOp = ((Fintype.card ι : ℝ) - 2) • idOp ∧
    (∀ W : CurvOp2 ι, IsWeyl2 W → sharpB idOp W = (-1 : ℝ) • W) ∧
    IsStable ((1 / ((Fintype.card ι : ℝ) - 2)) • (idOp : CurvOp2 ι)) := by
  have hm : (0 : ℝ) < (Fintype.card ι : ℝ) - 2 := by
    have : (7 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
    linarith
  refine ⟨?_, fun W hW => L265_weyl_clause W hW, ?_⟩
  · unfold sharpB
    rw [show (idOp : CurvOp2 ι) + idOp = (2 : ℝ) • idOp from ContinuousLinearMap.ext fun X => Subtype.ext (by simp [two_smul]), sharpMapCL_smul, sharpMapCL_id]
    module
  · intro H hH hHC
    rw [innerOp2_smul_right] at hHC
    have hI : innerOp2 H idOp = 0 := by
      rcases mul_eq_zero.mp hHC with h | h
      · exact absurd h (by positivity)
      · exact h
    have htr : ∑ a, ∑ b, tOf H a b a b = 0 := by
      have := innerOp2_id_tOf H; rw [hI] at this; linarith
    have key := stab_ineq (tOf_isPairT hH) htr (by omega)
    rw [Ftri_smul_left, Ftri_id_tOf H hH, normSq2_tOf]
    rw [show 1 / ((Fintype.card ι : ℝ) - 2) * (1 / 2 * (pT (tOf H) + rT (tOf H)))
        = (1 / 2 * (pT (tOf H) + rT (tOf H))) / ((Fintype.card ι : ℝ) - 2) by ring, div_le_iff₀ hm]
    nlinarith [key]

end HamiltonsCubic.I117S
