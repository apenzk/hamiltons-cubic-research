import Mathlib

set_option linter.style.longLine false

/-!
# L54, the two diagonals, and rigidity at `t = 2`

## The record's statement

[bispectral.md](../../../findings/bispectral.md)'s *Lemma L54, the two diagonals, and rigidity at
$t=2$*, items 1 to 4: the two diagonals in a frame, `μ ≻ d_φ` and `ω ≻ d`, `t_F ≤ 2` with its
equality case, and at `t_F = 2` the sorted equalities `μ = d_φ` and `ω = d`.

## What is typed, and where each input sits

The lemma's conclusion is a **rigidity statement about majorization**: two vectors that majorize
and carry the same `2`-norm have the same sorted vector. That is what is stated below, together
with the norm bookkeeping that supplies the hypothesis at `t_F = 2`.

* **Majorization** is defined here from first principles, equal totals, and every partial sum of
  the majorized vector dominated by some equal-sized partial sum of the majorizer. *Mathlib
  carries no majorization theory, so it is built rather than imported.*
* **Schur–Horn** enters as a named hypothesis here. Schur's half is proved in
  [SchurMajor.lean](SchurMajor.lean) (`schur_majorizes`) and instantiated at `M` in
  [L54Schur.lean](L54Schur.lean) (`L54_mu_majorizes`), which discharges `μ ≻ d_φ`.
* **`t_F = 2`** enters as the case hypothesis `ht` only. The per-frame bound `t_F ≤ 2` with its
  equality case is `tF_le` and `tF_eq_iff` in [L54Basis.lean](L54Basis.lean), proved on the
  pair-basis rows directly.
* **`Σd_φ² = t/2`** is proved below from `K` symmetric and hollow. **`Σd_ψ² = t`**, the record's
  *"Correction 1: `Σd² = (3/2)‖K‖_F², not ½` (a threefold undercount"*), is a hypothesis,
  because it is the spectral identification of the `ψ`-block with `−K|_{1^⊥}`.

## Where the geometric half is typed

`M` in the pair basis, `K(F)` and `W̊` are built elsewhere: [SecondKind.lean](SecondKind.lean)
defines `W̊`, [L54Basis.lean](L54Basis.lean) proves the two diagonals, `psi_block` and `t_F ≤ 2`, and
[L54Schur.lean](L54Schur.lean) proves `μ ≻ d_φ`. **Still absent**: `W̊` as a matrix in the basis
`{φ_ab} ∪ {ψ_k}` of `S²₀`, which `ω ≻ d` and the cheaper route to `ω = d` as vectors need, so `ω`
and `d` are free real vectors below. The cheaper route to `μ = d_φ` needs `tF_eq_iff`, `Mpair`, and
that a diagonal symmetric matrix has its diagonal as spectrum, which no file states. Rigidity with
`L54_mu_majorizes` and `sum_mu_sq` reaches the sorted form from proved pieces.

**The rigidity step is proved**, *majorization plus equal `2`-norms forces equal sorted vectors*, by
sorting with `Tuple.sort` and summation by parts, since Mathlib has neither majorization nor Karamata.

## Convention

`‖M‖_F = 1` in [bispectral.md](../../../findings/bispectral.md)'s normalisation, where
`Σμ² = 1` on `Λ²` and `Σω² = 3` on `S²₀`, and `t = t_F = ‖K(F)‖_F²` **per frame** (with
`κ² = max_F t_F` the extremal reading, which is a different quantity,
[conventions.md](../../../findings/conventions.md) records that the two *"have been swapped"*).
-/

namespace HamiltonsCubic.L54Statement

open Finset

/-! ## Majorization -/

/-- **`x` majorizes `y`**: equal totals, and every partial sum of `y` is dominated by an
equal-sized partial sum of `x`. *This is the standard definition with the sorted partial sums
written as a maximum over subsets, which avoids sorting.* -/
def Majorizes {N : Type*} [Fintype N] [DecidableEq N] (x y : N → ℝ) : Prop :=
  (∑ i, x i = ∑ i, y i) ∧
    ∀ S : Finset N, ∃ T : Finset N, T.card = S.card ∧ ∑ i ∈ S, y i ≤ ∑ i ∈ T, x i

/-- **Two vectors have the same sorted vector** when one is a permutation of the other. -/
def SameSorted {N : Type*} [Fintype N] (x y : N → ℝ) : Prop :=
  ∃ σ : Equiv.Perm N, ∀ i, y i = x (σ i)

/-! ## The rigidity step

*"At `t_F = 2` majorization has equal sums **and** equal norms on both sides."* -/

/-! ### The sorting argument -/

/-- **Pairwise domination between equal-sized sets bounds the sums.** -/
theorem sum_le_of_dom {α : Type*} (A B : Finset α) (g h : α → ℝ) (hc : A.card = B.card)
    (hd : ∀ a ∈ A, ∀ b ∈ B, g a ≤ h b) : ∑ a ∈ A, g a ≤ ∑ b ∈ B, h b := by
  rcases A.eq_empty_or_nonempty with hA | hA
  · subst hA
    have hB0 : B = ∅ := Finset.card_eq_zero.mp (by rw [← hc]; rfl)
    subst hB0; simp
  have hB : B.Nonempty := Finset.card_pos.mp (hc ▸ Finset.card_pos.mpr hA)
  set c := A.sup' hA g
  have h1 : ∑ a ∈ A, g a ≤ A.card • c := Finset.sum_le_card_nsmul _ _ _ fun a ha => Finset.le_sup' g ha
  have h2 : B.card • c ≤ ∑ b ∈ B, h b := Finset.card_nsmul_le_sum _ _ _ fun b hb => by
    obtain ⟨a, ha, hac⟩ := Finset.exists_mem_eq_sup' hA g
    rw [show c = g a from hac]; exact hd a ha b hb
  rw [hc] at h1; linarith

/-- The bottom `k` indices of `Fin n`. -/
def bot (n k : ℕ) : Finset (Fin n) := univ.filter (fun i => i.val < k)

theorem sum_bot {n : ℕ} (k : ℕ) (hk : k ≤ n) (f : ℕ → ℝ) :
    ∑ i ∈ bot n k, f i.val = ∑ i ∈ range k, f i := by
  unfold bot
  rw [Finset.sum_filter, Fin.sum_univ_eq_sum_range (fun i => if i < k then f i else 0),
    ← Finset.sum_filter]
  congr 1
  ext i; simp only [mem_filter, mem_range]; omega

theorem card_bot {n : ℕ} (k : ℕ) (hk : k ≤ n) : (bot n k).card = k := by
  have := sum_bot k hk (fun _ => 1)
  simp only [Finset.sum_const, nsmul_eq_mul, mul_one, Finset.card_range] at this
  exact_mod_cast this

/-- **The bottom `k` of a monotone vector sum to at most any `k` of its values.** -/
theorem bot_le {n : ℕ} (f : Fin n → ℝ) (hf : Monotone f) (T : Finset (Fin n)) (k : ℕ) (hk : k ≤ n)
    (hT : T.card = k) : ∑ i ∈ bot n k, f i ≤ ∑ i ∈ T, f i := by
  have hdiff : ∑ i ∈ T, f i - ∑ i ∈ bot n k, f i
      = ∑ i ∈ T \ bot n k, f i - ∑ i ∈ bot n k \ T, f i := by
    have e1 := Finset.sum_inter_add_sum_sdiff T (bot n k) f
    have e2 := Finset.sum_inter_add_sum_sdiff (bot n k) T f
    rw [Finset.inter_comm] at e2
    linarith
  have hcard : (bot n k \ T).card = (T \ bot n k).card := by
    have a1 := Finset.card_sdiff_add_card_inter (bot n k) T
    have a2 := Finset.card_sdiff_add_card_inter T (bot n k)
    rw [Finset.inter_comm] at a2
    rw [card_bot k hk] at a1; omega
  have hdom : ∀ a ∈ bot n k \ T, ∀ b ∈ T \ bot n k, f a ≤ f b := by
    intro a ha b hb
    simp only [bot, mem_sdiff, mem_filter, mem_univ, true_and] at ha hb
    exact hf (Fin.le_iff_val_le_val.mpr (by omega))
  have := sum_le_of_dom _ _ f f hcard hdom
  linarith

theorem rigid_fin {n : ℕ} (x y : Fin n → ℝ) (hmaj : Majorizes x y)
    (hnorm : ∑ i, x i ^ 2 = ∑ i, y i ^ 2) : SameSorted x y := by
  set σ := Tuple.sort x
  set τ := Tuple.sort y
  set xs := x ∘ σ with hxs
  set ys := y ∘ τ with hys
  have mx : Monotone xs := Tuple.monotone_sort x
  have my : Monotone ys := Tuple.monotone_sort y
  have sx : ∑ i, xs i = ∑ i, x i := Equiv.sum_comp σ x
  have sy : ∑ i, ys i = ∑ i, y i := Equiv.sum_comp τ y
  have qx : ∑ i, xs i ^ 2 = ∑ i, x i ^ 2 := Equiv.sum_comp σ (fun i => x i ^ 2)
  have qy : ∑ i, ys i ^ 2 = ∑ i, y i ^ 2 := Equiv.sum_comp τ (fun i => y i ^ 2)
  -- majorization, read on the sorted vectors
  have hbot : ∀ k ≤ n, ∑ i ∈ bot n k, xs i ≤ ∑ i ∈ bot n k, ys i := by
    intro k hk
    set S := (bot n k)ᶜ.map τ.toEmbedding
    obtain ⟨T, hTc, hST⟩ := hmaj.2 S
    set T' := T.map σ.symm.toEmbedding
    have hS : ∑ i ∈ S, y i = ∑ i ∈ (bot n k)ᶜ, ys i := by simp [S, Finset.sum_map, hys]
    have hT : ∑ i ∈ T', xs i = ∑ i ∈ T, x i := by simp [T', Finset.sum_map, hxs]
    have hcT : (T'ᶜ).card = k := by
      rw [Finset.card_compl, Finset.card_map, hTc, Finset.card_map, Finset.card_compl, card_bot k hk,
        Fintype.card_fin]; omega
    have hb := bot_le xs mx (T'ᶜ) k hk hcT
    have c1 := Finset.sum_add_sum_compl T' xs
    have c2 := Finset.sum_add_sum_compl (bot n k) ys
    have c3 := Finset.sum_add_sum_compl T' xs
    linarith [hmaj.1]
  -- summation by parts
  let F : ℕ → ℝ := fun i => if h : i < n then ys ⟨i, h⟩ else 0
  let D : ℕ → ℝ := fun i => if h : i < n then xs ⟨i, h⟩ - ys ⟨i, h⟩ else 0
  have hF : ∀ i : Fin n, F i = ys i := fun i => by simp [F, i.isLt]
  have hD : ∀ i : Fin n, D i = xs i - ys i := fun i => by simp [D, i.isLt]
  have hG : ∀ k ≤ n, ∑ i ∈ range k, D i ≤ 0 := by
    intro k hk
    rw [← sum_bot k hk D]
    simp only [hD, Finset.sum_sub_distrib]
    linarith [hbot k hk]
  have hGn : ∑ i ∈ range n, D i = 0 := by
    rw [← Fin.sum_univ_eq_sum_range]; simp only [hD, Finset.sum_sub_distrib]; linarith [hmaj.1]
  have habel : 0 ≤ ∑ i, ys i * (xs i - ys i) := by
    have e : ∑ i, ys i * (xs i - ys i) = ∑ i ∈ range n, F i • D i := by
      rw [← Fin.sum_univ_eq_sum_range (fun i => F i • D i)]
      simp only [hF, hD, smul_eq_mul]
    rw [e, Finset.sum_range_by_parts, hGn, smul_zero, zero_sub, neg_nonneg]
    refine Finset.sum_nonpos fun i hi => ?_
    rw [Finset.mem_range] at hi
    have hmono : F i ≤ F (i + 1) := by
      simp only [F, dif_pos (show i < n by omega), dif_pos (show i + 1 < n by omega)]
      exact my (Fin.le_iff_val_le_val.mpr (by simp))
    rw [smul_eq_mul]
    exact mul_nonpos_of_nonneg_of_nonpos (by linarith) (hG (i + 1) (by omega))
  -- the squares
  have hsq : ∑ i, (xs i - ys i) ^ 2 = 0 := by
    have e : ∑ i, (xs i - ys i) ^ 2 = ∑ i, xs i ^ 2 - ∑ i, ys i ^ 2 - 2 * ∑ i, ys i * (xs i - ys i) := by
      rw [Finset.mul_sum, ← Finset.sum_sub_distrib, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun i _ => by ring
    have h0 : 0 ≤ ∑ i, (xs i - ys i) ^ 2 := Finset.sum_nonneg fun i _ => sq_nonneg _
    linarith
  have heq : ∀ i, xs i = ys i := by
    intro i
    have := (Finset.sum_eq_zero_iff_of_nonneg (fun i _ => sq_nonneg (xs i - ys i))).mp hsq i (mem_univ i)
    have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
    linarith
  refine ⟨τ.symm.trans σ, fun i => ?_⟩
  have := heq (τ.symm i)
  simp only [hxs, hys, Function.comp_apply, Equiv.apply_symm_apply] at this
  simp only [Equiv.trans_apply]
  exact this.symm

/-- **RIGIDITY: majorization plus equal `2`-norms forces the same sorted vector.**

**PROVED** by the record's Abel-summation argument on sorted vectors: `Tuple.sort` sorts both, `bot_le`
reads majorization as `Σ_{bottom k} x↓ ≤ Σ_{bottom k} y↓`, `Finset.sum_range_by_parts` gives
`Σ y↓ (x↓ - y↓) ≥ 0`, and `Σx² - Σy² = Σ(x↓ - y↓)² + 2Σ y↓(x↓ - y↓)` forces `x↓ = y↓` at equal norms. -/
theorem sameSorted_of_majorizes_of_normSq_eq {N : Type*} [Fintype N] [DecidableEq N]
    (x y : N → ℝ) (hmaj : Majorizes x y) (hnorm : ∑ i, x i ^ 2 = ∑ i, y i ^ 2) :
    SameSorted x y := by
  set e := Fintype.equivFin N
  have hm : Majorizes (x ∘ e.symm) (y ∘ e.symm) := by
    refine ⟨?_, fun S => ?_⟩
    · simpa [Function.comp_apply] using
        (Equiv.sum_comp e.symm x).trans (hmaj.1.trans (Equiv.sum_comp e.symm y).symm)
    · obtain ⟨T, hTc, hST⟩ := hmaj.2 (S.map e.symm.toEmbedding)
      refine ⟨T.map e.toEmbedding, by simpa using hTc, ?_⟩
      simpa [Finset.sum_map] using hST
  have hn : ∑ i, (x ∘ e.symm) i ^ 2 = ∑ i, (y ∘ e.symm) i ^ 2 := by
    simpa [Function.comp_apply] using
      (Equiv.sum_comp e.symm (fun i => x i ^ 2)).trans (hnorm.trans (Equiv.sum_comp e.symm (fun i => y i ^ 2)).symm)
  obtain ⟨π, hπ⟩ := rigid_fin _ _ hm hn
  refine ⟨e.trans (π.trans e.symm), fun i => ?_⟩
  have := hπ (e i)
  simpa using this

/-! ## The norm bookkeeping

`Σd_φ² = t/2` is proved; `Σd_ψ² = t` is the spectral identification and is a hypothesis. -/

/-- **`Σ_{a<b} K_{ab}² = t/2`** for `K` symmetric with zero diagonal and `t = ‖K‖_F²`. *This is
the `φ`-block half of the diagonal, indexed by unordered pairs.* -/
theorem sum_offDiag_sq {n : ℕ} (K : Matrix (Fin n) (Fin n) ℝ)
    (hsym : ∀ a b, K a b = K b a) (hhollow : ∀ a, K a a = 0) :
    ∑ p ∈ Finset.univ.filter (fun p : Fin n × Fin n => p.1 < p.2), K p.1 p.2 ^ 2
      = (∑ a, ∑ b, K a b ^ 2) / 2 := by
  classical
  set f : Fin n × Fin n → ℝ := fun p => K p.1 p.2 ^ 2 with hf
  set A := Finset.univ.filter (fun p : Fin n × Fin n => p.1 < p.2) with hA
  set B := Finset.univ.filter (fun p : Fin n × Fin n => p.2 < p.1) with hB
  set C := Finset.univ.filter (fun p : Fin n × Fin n => p.1 = p.2) with hC
  have hsplit : ∑ a, ∑ b, K a b ^ 2 = ∑ p : Fin n × Fin n, f p := by
    rw [← Finset.univ_product_univ, Finset.sum_product]
  -- The complement of `A` splits into `C` (the diagonal) and `B`.
  have hnotA : Finset.univ.filter (fun p : Fin n × Fin n => ¬ p.1 < p.2) = C ∪ B := by
    ext p
    simp only [hB, hC, Finset.mem_union, Finset.mem_filter, Finset.mem_univ, true_and]
    constructor
    · intro h
      rcases lt_trichotomy p.1 p.2 with h' | h' | h'
      · exact absurd h' h
      · exact Or.inl h'
      · exact Or.inr h'
    · rintro (h | h)
      · rw [h]; exact lt_irrefl _
      · exact not_lt.mpr h.le
  have hdisj : Disjoint C B := by
    refine Finset.disjoint_left.mpr ?_
    intro p hp hp'
    simp only [hB, hC, Finset.mem_filter, Finset.mem_univ, true_and] at hp hp'
    rw [hp] at hp'
    exact lt_irrefl _ hp'
  have hCzero : ∑ p ∈ C, f p = 0 := by
    refine Finset.sum_eq_zero fun p hp => ?_
    simp only [hC, Finset.mem_filter, Finset.mem_univ, true_and] at hp
    have : p.1 = p.2 := hp
    simp [hf, ← this, hhollow p.1]
  -- The two off-diagonal halves agree, by the swap bijection and symmetry of `K`.
  have hAB : ∑ p ∈ A, f p = ∑ p ∈ B, f p := by
    refine Finset.sum_nbij' (fun p => (p.2, p.1)) (fun p => (p.2, p.1)) ?_ ?_ ?_ ?_ ?_
    · intro p hp
      simp only [hA, hB, Finset.mem_filter, Finset.mem_univ, true_and] at hp ⊢
      exact hp
    · intro p hp
      simp only [hA, hB, Finset.mem_filter, Finset.mem_univ, true_and] at hp ⊢
      exact hp
    · intro p _; rfl
    · intro p _; rfl
    · intro p _; simp [hf, hsym]
  have htotal : ∑ p : Fin n × Fin n, f p = ∑ p ∈ A, f p + ∑ p ∈ (C ∪ B), f p := by
    rw [← hnotA]
    exact (Finset.sum_filter_add_sum_filter_not Finset.univ _ f).symm
  rw [hsplit, htotal, Finset.sum_union hdisj, hCzero, ← hAB]
  ring

/-- **`Σd² = (3/2)t`**, the record's *Correction 1*: the `φ`-block contributes `t/2` and the
`ψ`-block contributes `t`, so the full `S²₀` diagonal carries `3t/2`, not `t/2`. *The `ψ`-block
value is the spectral identification of that block with `−K|_{1^⊥}` and is a hypothesis.* -/
theorem sum_full_diag_sq (t sphi spsi : ℝ) (hphi : sphi = t / 2) (hpsi : spsi = t) :
    sphi + spsi = (3 / 2) * t := by
  rw [hphi, hpsi]; ring

/-! ## The lemma at `t_F = 2` -/

/-- **`t_F = 2` makes both norm pairs match**: `Σd_φ² = 1 = Σμ²` and `Σd² = 3 = Σω²`. -/
theorem norms_match_at_two (t sphi spsi : ℝ) (ht : t = 2) (hphi : sphi = t / 2)
    (hpsi : spsi = t) : sphi = 1 ∧ sphi + spsi = 3 := by
  subst ht; rw [hphi, hpsi]; norm_num

/-- **THE LEMMA AT `t_F = 2`.** Schur's half of Schur–Horn gives `μ ≻ d_φ` and `ω ≻ d`; at
`t_F = 2` the `2`-norms agree on both sides; so the sorted vectors agree:
`μ↓ = d_φ↓` and `ω↓ = d↓`. *"Schur–Horn delivers the sorted vectors and nothing more."* -/
theorem rigidity_at_t_two {P Q : Type*} [Fintype P] [DecidableEq P] [Fintype Q] [DecidableEq Q]
    (mu dphi : P → ℝ) (om d : Q → ℝ) (t : ℝ)
    -- Schur (1923), classical and external: a symmetric matrix's diagonal is majorized by its
    -- spectrum.
    (hschur_phi : Majorizes mu dphi) (hschur_full : Majorizes om d)
    -- The case `t_F = 2`, the equality case of the per-frame bound `t_F ≤ 2`.
    (ht : t = 2)
    -- The normalisation `‖M‖_F = 1`, in which `Σμ² = 1` and `Σω² = 3`.
    (hmu : ∑ i, mu i ^ 2 = 1) (hom : ∑ i, om i ^ 2 = 3)
    -- The two diagonals, from the block's own bookkeeping.
    (hdphi : ∑ i, dphi i ^ 2 = t / 2) (hd : ∑ i, d i ^ 2 = (3 / 2) * t) :
    SameSorted mu dphi ∧ SameSorted om d := by
  subst ht
  refine ⟨sameSorted_of_majorizes_of_normSq_eq mu dphi hschur_phi ?_,
    sameSorted_of_majorizes_of_normSq_eq om d hschur_full ?_⟩
  · rw [hmu, hdphi]; norm_num
  · rw [hom, hd]; norm_num

/-! ## Non-vacuity

Majorization is satisfiable, and the rigidity hypothesis is reachable, so nothing above is
empty. -/

/-- **A witness**: a vector majorizes itself, with equal norms, and the sorted vectors agree at
the identity permutation. -/
example {N : Type*} [Fintype N] [DecidableEq N] (x : N → ℝ) :
    Majorizes x x ∧ SameSorted x x :=
  ⟨⟨rfl, fun S => ⟨S, rfl, le_refl _⟩⟩, ⟨Equiv.refl N, fun _ => rfl⟩⟩

/-- **Arithmetic only**: `K = ![![0,1],![1,0]]` has `‖K‖_F² = 2`. *It is not the `K` of any Weyl
tensor, `W₂ = 0` and its row sums are nonzero; it exhibits the norm computation and nothing more.* -/
example :
    (∑ a : Fin 2, ∑ b : Fin 2, (![![0, 1], ![1, 0]] : Matrix (Fin 2) (Fin 2) ℝ) a b ^ 2) = 2 := by
  simp [Fin.sum_univ_two]
  norm_num

end HamiltonsCubic.L54Statement
