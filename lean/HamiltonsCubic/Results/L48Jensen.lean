import Mathlib
import HamiltonsCubic.Results.ReducibleConvexity
import HamiltonsCubic.Results.L48Decomp

set_option linter.style.longLine false

/-!
# L48's reducible minimum, assembled: Jensen, the monotonicity in `k`, and the bound at the operator

[findings/problem.md](../../../findings/problem.md), Lemma L48: *"Since $f$ is convex ..., Jensen
minimises $\sum f$ at the balanced split at fixed $k$ and fixed $\sum n_a=n$ ... And
$k\,f(n/k)=\frac{kn}{8(n-k)}$ increases in $k$ ... over $k\ge2$ ... So at even $n$ the reducible
minimum sits at the balanced product, where $\lVert W\rVert^2=\frac{n^2}{8(n-1)(n-2)}$."*
[ReducibleConvexity.lean](ReducibleConvexity.lean) proves `f`'s two-point convexity and
[L48Decomp.lean](L48Decomp.lean) the decomposition `‖W‖² = Σ_a ‖W_a‖² + B`. This file assembles them:

* `f_convexOn`: `f` is `ConvexOn` on `(1, ∞)`;
* `jensen`: over any nonempty finite family of sizes `> 1`, `k f(n/k) ≤ Σ_a f(n_a)`, from
  `ConvexOn.map_sum_le` at equal weights `1/k`;
* `k_f_eq`, `k_mono`: `k f(n/k) = kn/(8(n-k))`, strictly increasing in `k` on `0 < k < n`;
* `two_split_B`: `2 f(n/2) - n/(8(n-1)) = n²/(8(n-1)(n-2))`;
* `B_ge`: at `k ≥ 2` factors of sizes `≥ 2`, `B = Σ_a f(n_a) - n/(8(n-1)) ≥ n²/(8(n-1)(n-2))`, the
  sizes relaxed to reals as the block does;
* `L48_reducible_bound`: at the product's curvature operator (L48Decomp's hypotheses, `ρ = ½`, at
  least two factors), `normSq W ≥ n²/(8(n-1)(n-2))`, through `Σ_i 1/(8(p_i-1)) = Σ_a f(n_a)` by
  grouping the indices by factor;
* `L48_attained`: the balanced product of two constant-curvature factors attains it.
-/

namespace HamiltonsCubic.L48Jensen

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.ReducibleConvexity HamiltonsCubic.L48Decomp
  HamiltonsCubic.L56Weyl

/-- **`f` is convex on `(1, ∞)`.** -/
theorem f_convexOn : ConvexOn ℝ (Set.Ioi 1) f :=
  ⟨convex_Ioi 1, fun x hx y hy a b ha hb hab => by
    simpa only [smul_eq_mul] using f_two_point hx hy ha hb hab⟩

/-- **Jensen at equal weights**: `k f(n/k) ≤ Σ_a f(n_a)`. -/
theorem jensen {κ : Type*} (t : Finset κ) (ht : t.Nonempty) (m : κ → ℝ) (hm : ∀ a ∈ t, 1 < m a) :
    (t.card : ℝ) * f ((∑ a ∈ t, m a) / t.card) ≤ ∑ a ∈ t, f (m a) := by
  have hk : (0 : ℝ) < t.card := by exact_mod_cast ht.card_pos
  have h := f_convexOn.map_sum_le (t := t) (w := fun _ => 1 / (t.card : ℝ)) (p := m)
    (fun _ _ => by positivity) (by rw [Finset.sum_const, nsmul_eq_mul]; field_simp)
    (fun a ha => hm a ha)
  simp only [smul_eq_mul, ← Finset.mul_sum] at h
  have e : 1 / (t.card : ℝ) * ∑ a ∈ t, m a = (∑ a ∈ t, m a) / t.card := by ring
  rw [e] at h
  calc (t.card : ℝ) * f ((∑ a ∈ t, m a) / t.card)
      ≤ (t.card : ℝ) * (1 / t.card * ∑ a ∈ t, f (m a)) := mul_le_mul_of_nonneg_left h hk.le
    _ = ∑ a ∈ t, f (m a) := by field_simp

/-- `k f(n/k) = kn/(8(n-k))`. -/
theorem k_f_eq {k n : ℝ} (hk : 0 < k) (hkn : k < n) : k * f (n / k) = k * n / (8 * (n - k)) := by
  unfold f
  have h1 : n - k ≠ 0 := by linarith
  have h2 : n / k - 1 = (n - k) / k := by field_simp
  rw [h2]
  field_simp

/-- **`k f(n/k)` increases strictly in `k`** on `0 < k < n`. -/
theorem k_mono {k k' n : ℝ} (hk : 0 < k) (hkk : k < k') (hkn : k' < n) :
    k * f (n / k) < k' * f (n / k') := by
  rw [k_f_eq hk (by linarith), k_f_eq (by linarith) hkn]
  have h1 : 0 < n - k := by linarith
  have h2 : 0 < n - k' := by linarith
  rw [div_lt_div_iff₀ (by positivity) (by positivity)]
  have hn : 0 < n := by linarith
  have key : k * n * (8 * (n - k')) - k' * n * (8 * (n - k)) = -(8 * (n * n * (k' - k))) := by ring
  have hpos : 0 < n * n * (k' - k) := mul_pos (mul_pos hn hn) (by linarith)
  linarith

/-- **The two-factor value**: `2 f(n/2) - n/(8(n-1)) = n²/(8(n-1)(n-2))`. -/
theorem two_split_B {n : ℝ} (hn : 2 < n) :
    2 * f (n / 2) - n / (8 * (n - 1)) = n ^ 2 / (8 * (n - 1) * (n - 2)) := by
  rw [k_f_eq (by norm_num) hn]
  have h1 : n - 1 ≠ 0 := by linarith
  have h2 : n - 2 ≠ 0 := by linarith
  field_simp
  ring

/-- **The reducible minimum**: at `k ≥ 2` factors of sizes `≥ 2`,
`Σ_a f(n_a) - n/(8(n-1)) ≥ n²/(8(n-1)(n-2))`. -/
theorem B_ge {κ : Type*} (t : Finset κ) (hk : 2 ≤ t.card) (m : κ → ℝ) (hm : ∀ a ∈ t, 2 ≤ m a) :
    (∑ a ∈ t, m a) ^ 2 / (8 * ((∑ a ∈ t, m a) - 1) * ((∑ a ∈ t, m a) - 2)) ≤
      ∑ a ∈ t, f (m a) - (∑ a ∈ t, m a) / (8 * ((∑ a ∈ t, m a) - 1)) := by
  set n := ∑ a ∈ t, m a with hn
  have hkR : (2 : ℝ) ≤ t.card := by exact_mod_cast hk
  have hne : t.Nonempty := Finset.card_pos.mp (by omega)
  have hn2k : 2 * (t.card : ℝ) ≤ n := by
    have := Finset.sum_le_sum hm
    simpa [Finset.sum_const, nsmul_eq_mul, mul_comm] using this
  have hJ := jensen t hne m (fun a ha => by linarith [hm a ha])
  have hmono : 2 * f (n / 2) ≤ (t.card : ℝ) * f (n / t.card) := by
    rcases eq_or_lt_of_le hkR with h | h
    · rw [← h]
    · exact (k_mono (by norm_num) h (by linarith)).le
  rw [← two_split_B (by linarith)]
  linarith

/-- **L48's bound at the product's curvature operator**: with every factor Einstein at `ρ = ½`,
at least two factors of size `≥ 2`, the Weyl summand of any split has
`normSq W ≥ n²/(8(n-1)(n-2))`. -/
theorem L48_reducible_bound {ι : Type*} [Fintype ι] [DecidableEq ι] {κ : Type*} [DecidableEq κ]
    (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsa : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hb : ∀ i j k l, bianchi R i j k l = 0)
    (hE : ∀ a b, Ric R a b = (1 / 2) * (if a = b then 1 else 0))
    (β : ι → κ) (hbs : ∀ i, 2 ≤ bs β i) (h2 : 2 ≤ (Finset.univ.image β).card)
    (hmix : ∀ i j, β i ≠ β j → R (phi i j) = 0)
    (W K : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeylOp W)
    (hK : ∀ R', IsLinOp R' → (∀ a b, Ric R' a b = 0) → innerOp K R' = 0)
    (hsplit : ∀ X, R X = W X + K X) :
    (Fintype.card ι : ℝ) ^ 2 / (8 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2))
      ≤ normSq W := by
  set t := Finset.univ.image β with ht
  -- factor sizes
  set m : κ → ℝ := fun a => ((Finset.univ.filter fun i => β i = a).card : ℝ) with hmdef
  have hcardι : 2 ≤ Fintype.card ι := by
    obtain ⟨i, -⟩ : ∃ i, i ∈ (Finset.univ : Finset ι) := by
      have : (Finset.univ : Finset ι).Nonempty := by
        by_contra h
        rw [Finset.not_nonempty_iff_eq_empty] at h
        simp [ht, h] at h2
      exact this
    have := hbs i
    unfold bs at this
    exact this.trans (Finset.card_le_univ _)
  have hdec := normSq_decomp R hR hskew hsa hb (1 / 2) hE β hbs hcardι hmix W K hW hK hsplit
  have hWf : 0 ≤ Wfac R β (1 / 2) := by
    unfold Wfac
    refine mul_nonneg (by norm_num) (Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => ?_)
    split_ifs
    · rw [inner2_eq_sum]
      exact mul_nonneg (by norm_num)
        (Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _)
    · exact le_refl 0
  rw [B_half] at hdec
  -- group the per-index sum by factor
  have hmaps : ∀ i ∈ (Finset.univ : Finset ι), β i ∈ t := fun i _ => by simp [ht]
  have hgroup : ∑ i, 1 / (8 * ((bs β i : ℝ) - 1)) = ∑ a ∈ t, f (m a) := by
    rw [← Finset.sum_fiberwise_of_maps_to hmaps]
    refine Finset.sum_congr rfl fun a ha => ?_
    have hfib : ∀ i ∈ Finset.univ.filter (fun i => β i = a), (bs β i : ℝ) = m a := by
      intro i hi
      rw [Finset.mem_filter] at hi
      have e : bs β i = (Finset.univ.filter fun j => β j = a).card := by unfold bs; rw [hi.2]
      rw [e]
    rw [Finset.sum_congr rfl fun i hi => by rw [hfib i hi], Finset.sum_const, nsmul_eq_mul]
    obtain ⟨i0, -, rfl⟩ := Finset.mem_image.mp (by rw [← ht]; exact ha)
    have hm2 : (2 : ℝ) ≤ m (β i0) := by
      have := hbs i0; unfold bs at this; simp only [hmdef]; exact_mod_cast this
    unfold f
    have : m (β i0) - 1 ≠ 0 := by linarith
    field_simp
    all_goals simp only [hmdef]
  have hsum : ∑ a ∈ t, m a = (Fintype.card ι : ℝ) := by
    simp only [hmdef]
    rw [← Nat.cast_sum, ← Finset.card_eq_sum_card_fiberwise hmaps, Finset.card_univ]
  have hm2 : ∀ a ∈ t, 2 ≤ m a := fun a ha => by
    obtain ⟨i0, -, rfl⟩ := Finset.mem_image.mp (by rw [← ht]; exact ha)
    have := hbs i0; unfold bs at this; simp only [hmdef]; exact_mod_cast this
  have hB := B_ge t h2 m hm2
  rw [hsum] at hB
  rw [hdec, hgroup]
  linarith

/-- **The bound is attained** at the balanced product of two constant-curvature factors: when every
factor has size `n/2` and `R φ_ij = c_i φ_ij` within each factor, `normSq W = n²/(8(n-1)(n-2))`. -/
theorem L48_attained {ι : Type*} [Fintype ι] [DecidableEq ι] [Nonempty ι] {κ : Type*} [DecidableEq κ]
    (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsa : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hb : ∀ i j k l, bianchi R i j k l = 0)
    (hE : ∀ a b, Ric R a b = (1 / 2) * (if a = b then 1 else 0))
    (β : ι → κ) (hbs : ∀ i, 2 ≤ bs β i) (hbal : ∀ i, 2 * bs β i = Fintype.card ι)
    (hmix : ∀ i j, β i ≠ β j → R (phi i j) = 0)
    (hconst : ∀ i j, β j = β i → R (phi i j) = cb β (1 / 2) i • phi i j)
    (W K : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeylOp W)
    (hK : ∀ R', IsLinOp R' → (∀ a b, Ric R' a b = 0) → innerOp K R' = 0)
    (hsplit : ∀ X, R X = W X + K X) :
    normSq W =
      (Fintype.card ι : ℝ) ^ 2 / (8 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2)) := by
  obtain ⟨i₀⟩ := ‹Nonempty ι›
  have hcardι : 2 ≤ Fintype.card ι := by
    have := hbal i₀; have := hbs i₀; omega
  have hdec := normSq_decomp R hR hskew hsa hb (1 / 2) hE β hbs hcardι hmix W K hW hK hsplit
  rw [B_half, (Wfac_eq_zero_iff R β (1 / 2)).mpr hconst, zero_add] at hdec
  have hp : ∀ i, (bs β i : ℝ) = (Fintype.card ι : ℝ) / 2 := fun i => by
    have := hbal i
    have : (2 : ℝ) * bs β i = Fintype.card ι := by exact_mod_cast this
    linarith
  simp only [hp, Finset.sum_const, Finset.card_univ, nsmul_eq_mul] at hdec
  rw [hdec]
  have hn4 : (4 : ℝ) ≤ Fintype.card ι := by
    have := hp i₀
    have h2 : (2 : ℝ) ≤ bs β i₀ := by exact_mod_cast hbs i₀
    linarith
  have h1 : (Fintype.card ι : ℝ) - 1 ≠ 0 := by linarith
  have h2 : (Fintype.card ι : ℝ) - 2 ≠ 0 := by linarith
  have h3 : (Fintype.card ι : ℝ) / 2 - 1 ≠ 0 := by linarith
  field_simp
  ring

end HamiltonsCubic.L48Jensen
