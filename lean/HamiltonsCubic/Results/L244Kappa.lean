import Mathlib
import HamiltonsCubic.Results.L244Norm
import HamiltonsCubic.Results.FrameInv

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L244 (ii) with the record's `κ_r(x)`, the top-`r` eigenvalue sum of `−ad_x²`

[findings/second-order.md](../../../findings/second-order.md), Lemma L244: *source caps $2\sum_bb_{ab}(x)\le\kappa_{m_a}(x)$*, with
$\kappa_r(x)$ the sum of the top $r$ eigenvalues of $-\mathrm{ad}_x^2$ on $\Lambda^2$. [L244Unit.lean](L244Unit.lean)'s
`L244_ceiling_unit` takes `κ₀`, `κ₂` as bounds on the slot-eigenvalue sums of every normal form of `x`. Here `κ_r(x)` is a
definition, by Ky Fan's maximum principle:

* **`kappa r x`**: the supremum of `∑_γ ‖[x, ψ_γ]‖²` over orthonormal skew families of at most `r` members;
* `le_kappa`: every such family's sum is at most `kappa r x`;
* **`slot_le_kappa`**: at every normal form `x = O N.X Oᵀ`, every set `S` of at most `r` slots has `∑_S μ ≤ kappa r x`, the conjugated
  slot vectors being orthonormal eigenvectors of `−ad_x²` with eigenvalues `μ` (`negAd_conj`);
* **`kappa_le`**: `kappa r x ≤ B` whenever `B` bounds the slot sums over sets of at most `r` slots, by `bracket_cap`; together with
  `slot_le_kappa`, `kappa r x` is the largest sum of at most `r` slot eigenvalues, and `slotμ_nonneg` makes that the top-`r` sum;
* **`L244_i_unit`**: L244 (i), the three per-vector rows and the source caps with `κ_r(x)`, at every unit `x` of every eigenspace;
* `cap_self_kappa`: the self cap at every class size, `m_c = 1` included;
* **`L244_ceiling_kappa`**: `θ ≤ a(n − 5)`, `θ ≤ a(κ_{m₀−1}(x) − 1)`, `θ ≤ a(κ_{m₂}(x) − 3)` at every unit `x` with `W x = −a x`, no
  cap hypotheses left;
* **`L244_ii`**: (ii) as stated, `a = 1/√(2p)` and the ceiling divided by `√(2p)`, at a unit `W`.
-/

namespace HamiltonsCubic.L244Kappa

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.EigenFrameExist
  HamiltonsCubic.SecondKind HamiltonsCubic.L244RowBMass HamiltonsCubic.L244Frame

variable {n : ℕ}

/-- The sums `∑_γ ‖[x, ψ_γ]‖²` over orthonormal skew families of at most `r` members. -/
def kSet (r : ℕ) (x : Matrix (Fin n) (Fin n) ℝ) : Set ℝ :=
  {t | ∃ m, m ≤ r ∧ ∃ ψ : Fin m → Matrix (Fin n) (Fin n) ℝ, (∀ γ, IsSkew (ψ γ)) ∧
    (∀ i j, inner2 (ψ i) (ψ j) = if i = j then 1 else 0) ∧ t = ∑ γ, inner2 (br x (ψ γ)) (br x (ψ γ))}

/-- **`κ_r(x)`**, variationally. -/
noncomputable def kappa (r : ℕ) (x : Matrix (Fin n) (Fin n) ℝ) : ℝ := sSup (kSet r x)

theorem kSet_nonempty (r : ℕ) (x : Matrix (Fin n) (Fin n) ℝ) : (kSet r x).Nonempty :=
  ⟨0, 0, Nat.zero_le _, fun γ => γ.elim0, fun γ => γ.elim0, fun i => i.elim0, by simp⟩

theorem kSet_bdd (r : ℕ) {x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x) : BddAbove (kSet r x) := by
  obtain ⟨k, N, O, -, -, -, hN⟩ := L237Cap.bracket_cap x hx
  refine ⟨∑ ij, max (L240SlotBasis.slotμ N ij) 0, ?_⟩
  rintro t ⟨m, -, ψ, hS, hO, rfl⟩
  have h := hN ψ hS hO 0
  simp only [mul_zero, zero_add, sub_zero] at h
  exact h

/-- Every family of at most `r` members has its sum below `κ_r(x)`. -/
theorem le_kappa {r m : ℕ} (hm : m ≤ r) {x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x) (ψ : Fin m → Matrix (Fin n) (Fin n) ℝ)
    (hS : ∀ γ, IsSkew (ψ γ)) (hO : ∀ i j, inner2 (ψ i) (ψ j) = if i = j then 1 else 0) :
    ∑ γ, inner2 (br x (ψ γ)) (br x (ψ γ)) ≤ kappa r x :=
  le_csSup (kSet_bdd r hx) ⟨m, hm, ψ, hS, hO, rfl⟩

/-- **Ky Fan's upper bound**: `κ_r(x) ≤ B` whenever `B` bounds every sum of at most `r` slot eigenvalues of every normal form. -/
theorem kappa_le {r : ℕ} {x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x) (B : ℝ)
    (hB : ∀ (k : ℕ) (N : L240SlotBasis.NormalForm (Fin n) k) (O : Matrix (Fin n) (Fin n) ℝ),
      O * Oᵀ = 1 → Oᵀ * O = 1 → x = O * N.X * Oᵀ →
      ∀ S : Finset {x : Fin n × Fin n // x.1 < x.2}, S.card ≤ r → ∑ ij ∈ S, L240SlotBasis.slotμ N ij ≤ B) :
    kappa r x ≤ B := by
  refine csSup_le (kSet_nonempty r x) ?_
  rintro t ⟨m, hm, ψ, hS, hO, rfl⟩
  obtain ⟨k, N, O, hO1, hO2, hxO, hN⟩ := L237Cap.bracket_cap x hx
  rcases Nat.eq_zero_or_pos m with h0 | hpos
  · subst h0
    simpa using hB k N O hO1 hO2 hxO ∅ (by simp)
  · obtain ⟨c, hc⟩ := L237Cap.exists_c_topSum (L240SlotBasis.slotμ N) hpos B
      (fun S hS' => hB k N O hO1 hO2 hxO S (hS'.trans hm))
    exact (hN ψ hS hO c).trans hc

/-- The orthogonal frame change `Oᵀ`. -/
theorem isOrth_T {O : Matrix (Fin n) (Fin n) ℝ} (hO1 : O * Oᵀ = 1) (hO2 : Oᵀ * O = 1) :
    HamiltonsCubic.FrameLayer.IsOrth Oᵀ := by
  refine ⟨?_, ?_⟩ <;> simp only [Matrix.transpose_transpose] <;> assumption

/-- **`−ad_x²` on a conjugated slot vector**: at `x = O N.X Oᵀ`, `−[x, [x, O φ_s Oᵀ]] = μ_s O φ_s Oᵀ`. -/
theorem negAd_conj {k : ℕ} (N : L240SlotBasis.NormalForm (Fin n) k) {O x : Matrix (Fin n) (Fin n) ℝ} (hO1 : O * Oᵀ = 1)
    (hO2 : Oᵀ * O = 1) (hxO : x = O * N.X * Oᵀ) (s : {x : Fin n × Fin n // x.1 < x.2}) :
    -br x (br x (O * L240SlotBasis.slotφ N s * Oᵀ)) = L240SlotBasis.slotμ N s • (O * L240SlotBasis.slotφ N s * Oᵀ) := by
  have hU := isOrth_T hO1 hO2
  have e : ∀ A : Matrix (Fin n) (Fin n) ℝ, O * A * Oᵀ = Oᵀᵀ * A * Oᵀ := fun A => by rw [Matrix.transpose_transpose]
  rw [hxO, e N.X, e, HamiltonsCubic.FrameLayer.br_conj hU, HamiltonsCubic.FrameLayer.br_conj hU,
    ← Matrix.neg_mul, ← Matrix.mul_neg, L240SlotBasis.slot_eigen, Matrix.mul_smul, Matrix.smul_mul]

/-- **The slot eigenvalues are nonnegative**, being `‖[N.X, φ_s]‖²`. -/
theorem slotμ_nonneg {k : ℕ} (N : L240SlotBasis.NormalForm (Fin n) k) {O x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x)
    (hO1 : O * Oᵀ = 1) (hO2 : Oᵀ * O = 1) (hxO : x = O * N.X * Oᵀ) (s : {x : Fin n × Fin n // x.1 < x.2}) :
    0 ≤ L240SlotBasis.slotμ N s := by
  have hU := isOrth_T hO1 hO2
  set ψ := O * L240SlotBasis.slotφ N s * Oᵀ
  have hunit : inner2 ψ ψ = 1 := by
    have h := HamiltonsCubic.FrameLayer.inner2_conj hU (L240SlotBasis.slotφ N s) (L240SlotBasis.slotφ N s)
    rw [Matrix.transpose_transpose] at h
    rw [h, L240SlotBasis.slot_orthonormal, if_pos rfl]
  have h := KyFanPackaging.inner2_negAdSq x ψ hx
  change inner2 ψ (-br x (br x ψ)) = _ at h
  rw [negAd_conj N hO1 hO2 hxO s, HamiltonsCubic.L244Unit.i_smul_r, hunit, mul_one] at h
  rw [h]
  exact HamiltonsCubic.RealLayer.inner2_self_nonneg _

/-- **Attainment**: at a normal form of `x`, every set of at most `r` slots has its eigenvalue sum below `κ_r(x)`. -/
theorem slot_le_kappa {r : ℕ} {x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x) {k : ℕ} (N : L240SlotBasis.NormalForm (Fin n) k)
    (O : Matrix (Fin n) (Fin n) ℝ) (hO1 : O * Oᵀ = 1) (hO2 : Oᵀ * O = 1) (hxO : x = O * N.X * Oᵀ)
    (S : Finset {x : Fin n × Fin n // x.1 < x.2}) (hS : S.card ≤ r) :
    ∑ ij ∈ S, L240SlotBasis.slotμ N ij ≤ kappa r x := by
  have hU := isOrth_T hO1 hO2
  let e := S.equivFin
  let ψ : Fin S.card → Matrix (Fin n) (Fin n) ℝ := fun i => O * L240SlotBasis.slotφ N (e.symm i).1 * Oᵀ
  have hψS : ∀ γ, IsSkew (ψ γ) := fun γ => by
    have h := L240SlotBasis.slotφ_isSkew N (e.symm γ).1
    unfold IsSkew at *
    simp only [ψ, Matrix.transpose_mul, Matrix.transpose_transpose, h, Matrix.mul_neg, Matrix.neg_mul, Matrix.mul_assoc]
  have hψO : ∀ i j, inner2 (ψ i) (ψ j) = if i = j then 1 else 0 := fun i j => by
    have h := HamiltonsCubic.FrameLayer.inner2_conj hU (L240SlotBasis.slotφ N (e.symm i).1) (L240SlotBasis.slotφ N (e.symm j).1)
    rw [Matrix.transpose_transpose] at h
    simp only [ψ]
    rw [h, L240SlotBasis.slot_orthonormal]
    have hiff : (e.symm i).1 = (e.symm j).1 ↔ i = j := by rw [Subtype.val_inj, Equiv.apply_eq_iff_eq]
    simp only [hiff]
  have hsum : ∑ γ, inner2 (br x (ψ γ)) (br x (ψ γ)) = ∑ ij ∈ S, L240SlotBasis.slotμ N ij := by
    have hγ : ∀ γ, inner2 (br x (ψ γ)) (br x (ψ γ)) = L240SlotBasis.slotμ N (e.symm γ).1 := fun γ => by
      have h := KyFanPackaging.inner2_negAdSq x (ψ γ) hx
      change inner2 (ψ γ) (-br x (br x (ψ γ))) = _ at h
      rw [← h]
      simp only [ψ]
      rw [negAd_conj N hO1 hO2 hxO, HamiltonsCubic.L244Unit.i_smul_r]
      have := hψO γ γ
      simp only [ψ, if_pos rfl] at this
      rw [this, if_pos trivial, mul_one]
    simp only [hγ]
    rw [← Finset.sum_coe_sort S]
    exact Equiv.sum_comp e.symm (fun s : S => L240SlotBasis.slotμ N s.1)
  rw [← hsum]
  exact le_kappa hS hx ψ hψS hψO

/-- **The self cap at every class size**: at a frame whose class `c` contains `x = ψ_{k₀}`, `2 ∑_b b_cb(x) ≤ κ_{m_c−1}(x)`, including
`m_c = 1`, where `x`'s own row vanishes and the left side is `0` ([r1881](../../../reviews/REVIEW_r1881.md) O1). -/
theorem cap_self_kappa {r K : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (hS : ∀ k, IsSkew (ψ k))
    (hO : ∀ i j, inner2 (ψ i) (ψ j) = if i = j then 1 else 0) (hcomp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (cls : Fin r → Fin K) (c : Fin K) (k₀ : Fin r) (hk₀ : cls k₀ = c) {x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x)
    (hself : ψ k₀ = x) :
    2 * ∑ b, HamiltonsCubic.L244RowA.bAB ψ cls c b x ≤ kappa (Fintype.card {γ // cls γ = c} - 1) x := by
  by_cases h2 : 2 ≤ Fintype.card {γ // cls γ = c}
  · have h := HamiltonsCubic.L244Unit.cap_self_gen ψ hS hO hcomp cls c k₀ hk₀ (kappa (Fintype.card {γ // cls γ = c} - 1) x)
      (fun _ N O hO1 hO2 hxO S hS' => slot_le_kappa hx N O hO1 hO2 (by rw [← hself]; exact hxO) S hS') h2
    rw [hself] at h
    exact h
  · obtain ⟨m, e, he⟩ := HamiltonsCubic.L244Sym.class_equiv cls c k₀ hk₀
    have hcard : Fintype.card {γ // cls γ = c} = m + 1 := by
      rw [← Fintype.card_fin (m + 1)]; exact (Fintype.card_congr e).symm
    have hm : m = 0 := by omega
    subst hm
    rw [← HamiltonsCubic.L244Bridge.rowMass_class ψ cls c e,
      HamiltonsCubic.L244Caps.rowMass_drop_self (fun i => ψ (e i).1) ψ x hx (by rw [he]; exact hself)]
    have hz : HamiltonsCubic.L244Caps.rowMass (fun i : Fin 0 => ψ (e i.succ).1) ψ x = 0 := by
      unfold HamiltonsCubic.L244Caps.rowMass; simp
    rw [hz, mul_zero]
    exact le_csSup (kSet_bdd _ hx) ⟨0, Nat.zero_le _, fun γ => γ.elim0, fun γ => γ.elim0, fun i => i.elim0, by simp⟩

/-- **L244 (ii) with the record's `κ_r(x)`**: at a critical linear Weyl `W` whose spectral eigenframe is labelled by three classes of
values `(−a, 0, a)`, `a > 0`, of sizes `m₀ ≥ 1` and `m₂ ≥ 1` for `−a` and `a`, and every unit bivector `x` with `W x = −a x`,
`θ ≤ a(n − 5)`, `θ ≤ a(κ_{m₀−1}(x) − 1)` and `θ ≤ a(κ_{m₂}(x) − 3)`. -/
theorem L244_ceiling_kappa {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeylOp W) {θ a : ℝ} (ha : 0 < a)
    (hc : IsCritical W θ) (cls : Fin (Fintype.card (Pairs n)) → Fin 3)
    (hcls : ∀ k, evf W hW k = (![-a, 0, a] : Fin 3 → ℝ) (cls k))
    (h0size : 0 < Fintype.card {γ // cls γ = 0}) (h2size : 0 < Fintype.card {γ // cls γ = 2})
    {x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x) (hunit : inner2 x x = 1) (hWx : W x = (-a) • x) :
    θ ≤ a * (n - 5) ∧ θ ≤ a * (kappa (Fintype.card {γ // cls γ = 0} - 1) x - 1) ∧
      θ ≤ a * (kappa (Fintype.card {γ // cls γ = 2}) x - 3) := by
  obtain ⟨⟨k₀, hk₀⟩⟩ : Nonempty {γ // cls γ = 0} := Fintype.card_pos_iff.mp h0size
  have hk : evf W hW k₀ = -a := by rw [hcls, hk₀]; rfl
  set ψ := HamiltonsCubic.L244Unit.ψx hW k₀ x
  have hS := HamiltonsCubic.L244Unit.ψx_skew hW k₀ hx
  have hO := HamiltonsCubic.L244Unit.ψx_orth hW k₀ x
  have hcomp := HamiltonsCubic.L244Unit.ψx_complete hW k₀ hx
  have heig := HamiltonsCubic.L244Unit.ψx_eigen hW k₀ hk hx hWx
  have hself : ψ k₀ = x := HamiltonsCubic.L244Unit.ψx_self hW k₀ hunit
  have hu : inner2 (ψ k₀) (ψ k₀) = 1 := by rw [hself]; exact hunit
  obtain ⟨hA, hB, hC⟩ := HamiltonsCubic.L244Unit.L244_rows_gen hW ha hc ψ (evf W hW) hS hcomp heig cls hcls k₀ hk₀ hu
  have c0 := cap_self_kappa ψ hS hO hcomp cls 0 k₀ hk₀ hx hself
  have c2 := HamiltonsCubic.L244Unit.cap_other_gen ψ hS hO hcomp cls 2 x hx _ h2size
    (fun _ N O hO1 hO2 hxO S hS' => slot_le_kappa hx N O hO1 hO2 hxO S hS')
  rw [← hself] at c0 c2
  simp only [Fin.sum_univ_three] at c0 c2
  have s02 := HamiltonsCubic.L244Sym.bAB_symm ψ cls 0 2 (ψ k₀)
  have s12 := HamiltonsCubic.L244Sym.bAB_symm ψ cls 1 2 (ψ k₀)
  have hnn : ∀ i j, 0 ≤ HamiltonsCubic.L244RowA.bAB ψ cls i j (ψ k₀) := fun i j => by
    unfold HamiltonsCubic.L244RowA.bAB
    exact mul_nonneg (by norm_num) (Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => sq_nonneg _)
  have hK := HamiltonsCubic.L244SymmetricPerVector.per_vector_ceiling n (θ / a + 1) _ _ _ _ _ _ _ _
    (hnn 0 0) (hnn 0 1) (hnn 1 1) (hnn 2 2) hA hB hC c0 (by linarith)
  rw [hself] at hK
  exact HamiltonsCubic.L244SymmetricPerVector.theta_bound n a θ (θ / a + 1) _ _ ha (by field_simp; ring) hK

/-- **L244 (ii) as the record states it**: at a unit critical linear Weyl `W` whose spectral eigenframe is labelled by `(−a, 0, a)`,
`a > 0`, the classes of `−a` and `a` have one size `p`, `a = 1/√(2p)`, and every unit `x` with `W x = −a x` has
`θ ≤ (n − 5)/√(2p)`, `θ ≤ (κ_{p−1}(x) − 1)/√(2p)` and `θ ≤ (κ_p(x) − 3)/√(2p)`, i.e.
`θ ≤ (min(κ_{p−1}(x), κ_p(x) − 2, n − 4) − 1)/√(2p)` (r1882 O3). -/
theorem L244_ii {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeylOp W) {θ a : ℝ} (ha : 0 < a)
    (hc : IsCritical W θ) (hnorm : normSq W = 1) (cls : Fin (Fintype.card (Pairs n)) → Fin 3)
    (hcls : ∀ k, evf W hW k = (![-a, 0, a] : Fin 3 → ℝ) (cls k))
    {x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x) (hunit : inner2 x x = 1) (hWx : W x = (-a) • x) :
    Fintype.card {γ // cls γ = 2} = Fintype.card {γ // cls γ = 0} ∧
      a = 1 / Real.sqrt (2 * Fintype.card {γ // cls γ = 0}) ∧
      θ ≤ (n - 5) / Real.sqrt (2 * Fintype.card {γ // cls γ = 0}) ∧
      θ ≤ (kappa (Fintype.card {γ // cls γ = 0} - 1) x - 1) / Real.sqrt (2 * Fintype.card {γ // cls γ = 0}) ∧
      θ ≤ (kappa (Fintype.card {γ // cls γ = 0}) x - 3) / Real.sqrt (2 * Fintype.card {γ // cls γ = 0}) := by
  obtain ⟨hm, hn⟩ := HamiltonsCubic.L244Norm.L244_mult hW ha.ne' cls hcls
  have hA := HamiltonsCubic.L244Norm.L244_a hW ha hnorm cls hcls
  have hp : 0 < Fintype.card {γ // cls γ = 0} := by
    by_contra h
    have h0 : Fintype.card {γ // cls γ = 0} = 0 := by omega
    rw [hnorm, h0] at hn
    norm_num at hn
  obtain ⟨h1, h2, h3⟩ := L244_ceiling_kappa hW ha hc cls hcls hp (by rw [← hm]; exact hp) hx hunit hWx
  rw [← hm] at h3
  have e : ∀ X : ℝ, a * X = X / Real.sqrt (2 * Fintype.card {γ // cls γ = 0}) := fun X => by rw [hA]; ring
  rw [e] at h1 h2 h3
  exact ⟨hm.symm, hA, h1, h2, h3⟩

/-- **L244 (i) at every unit vector of every eigenspace**: at a critical linear Weyl `W` whose spectral eigenframe is labelled by
classes with values `λ`, and `x` a unit bivector with `W x = λ_c x` where `c` is the class of a frame vector `k₀`, the frame reflected
to start class `c` at `x` has the three per-vector rows at `x`, the source caps `2 ∑_b b_ab(x) ≤ κ_{m_a}(x)` at every nonempty class,
and `2 ∑_b b_cb(x) ≤ κ_{m_c−1}(x)` at every size of `x`'s own class. -/
theorem L244_i_unit {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeylOp W) {θ : ℝ} (hc : IsCritical W θ)
    {K : ℕ} (cls : Fin (Fintype.card (Pairs n)) → Fin K) (lam : Fin K → ℝ) (hcls : ∀ k, evf W hW k = lam (cls k))
    (c : Fin K) (k₀ : Fin (Fintype.card (Pairs n))) (hk₀ : cls k₀ = c)
    {x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x) (hunit : inner2 x x = 1) (hWx : W x = lam c • x) :
    let ψ := HamiltonsCubic.L244Unit.ψx hW k₀ x
    let b := fun i j => HamiltonsCubic.L244RowA.bAB ψ cls i j x
    ∑ i, ∑ j, b i j = n - 2 ∧ ∑ i, ∑ j, lam j * b i j = -lam c ∧
      ∑ i, ∑ j, lam i * lam j * b i j = lam c * (θ - lam c) ∧
      (∀ i, 0 < Fintype.card {γ // cls γ = i} → 2 * ∑ j, b i j ≤ kappa (Fintype.card {γ // cls γ = i}) x) ∧
      2 * ∑ j, b c j ≤ kappa (Fintype.card {γ // cls γ = c} - 1) x := by
  intro ψ b
  have hk : evf W hW k₀ = -(-lam c) := by rw [neg_neg, hcls, hk₀]
  have hWx' : W x = (-(-lam c)) • x := by rw [neg_neg]; exact hWx
  have hS := HamiltonsCubic.L244Unit.ψx_skew hW k₀ hx
  have hO := HamiltonsCubic.L244Unit.ψx_orth hW k₀ x
  have hcomp := HamiltonsCubic.L244Unit.ψx_complete hW k₀ hx
  have heig := HamiltonsCubic.L244Unit.ψx_eigen hW k₀ hk hx hWx'
  have hself : ψ k₀ = x := HamiltonsCubic.L244Unit.ψx_self hW k₀ hunit
  have hWP := HamiltonsCubic.L244Unit.hWP_gen hW ψ (evf W hW) hcomp heig cls lam hcls
  refine ⟨?_, ?_, ?_, fun i hi => ?_, ?_⟩
  · have h := HamiltonsCubic.L244RowA.rowMass_total_any ψ hS hcomp ψ hcomp x hx
    rw [HamiltonsCubic.L244RowA.rowMass_eq_sum_bAB ψ cls, hunit, mul_one] at h
    exact h
  · have h := rowB_mass W hW ψ hS cls lam (HamiltonsCubic.L244Unit.hId_gen ψ hcomp cls) hWP x hx
    rw [hWx, HamiltonsCubic.RealLayer.inner2_smul_left, hunit, mul_one] at h
    exact h
  · have h := rowC_mass W hW ψ hS cls lam hWP x hx
    rw [rowC_critical W hW θ hc x hx (lam c) hWx hunit] at h
    exact h
  · exact HamiltonsCubic.L244Unit.cap_other_gen ψ hS hO hcomp cls i x hx _ hi
      (fun _ N O hO1 hO2 hxO S hS' => slot_le_kappa hx N O hO1 hO2 hxO S hS')
  · exact cap_self_kappa ψ hS hO hcomp cls c k₀ hk₀ hx hself

end HamiltonsCubic.L244Kappa
