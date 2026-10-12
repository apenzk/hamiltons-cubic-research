import Mathlib
import HamiltonsCubic.Results.L27Dn
import HamiltonsCubic.Results.L27Four
import HamiltonsCubic.Results.L120Support

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L27 assembled over the sign group: `λ_max(L_e|_{W^⊥}) ≤ 1/2`, and `1/2` only on the cross pairs

[findings/nondegeneracy.md](../../../findings/nondegeneracy.md), Lemma L27: *Let $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$. …
Then $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at $W_{p,q}$, attained exactly on the orbit tangent.* The route is
[L207](../../../findings/nondegeneracy.md)'s: $L_e$ commutes with the sign group, and each isotypic component carries the
eigen-equation ([L27Sector.lean](L27Sector.lean)'s `comp_eigen`), so the value is read off one sector at a time:

* character `1`, orthogonal to `M`: below `1/2` ([L27Dn.lean](L27Dn.lean)'s `dn_sphere`);
* character `ε_j ε_k`: at most `1/2`, and `1/2` only at a cross pair ([L27Pair.lean](L27Pair.lean)'s `pair_sphere`);
* character `χ_Q`: `4c² < θ²`, below `1/2` ([L27Four.lean](L27Four.lean)'s `four_sphere_lt`);
* every other character: zero ([L120Support.lean](L120Support.lean)'s `comp_zero`).

* `card_four`: a four-element set is `{i, j, k, l}` with distinct entries;
* `comp_sector`: the eigen-value bound on one nonzero component;
* **`L27_half`**: at a unit sphere product with `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, every `L_e`-eigenvalue on a nonzero Weyl
  `H ⊥ M` is at most `1/2`, and at `1/2` every nonzero isotypic component of `H` sits on a cross pair `{j, k}`, `j ∈ T`,
  `k ∉ T`.
-/

namespace HamiltonsCubic.L27Main

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly
  HamiltonsCubic.PairSquare HamiltonsCubic.L120Decomp HamiltonsCubic.L222Op HamiltonsCubic.L27Sector

variable {n : ℕ}

theorem card_four {s : Finset (Fin n)} (h : s.card = 4) :
    ∃ i j k l : Fin n, i ≠ j ∧ i ≠ k ∧ i ≠ l ∧ j ≠ k ∧ j ≠ l ∧ k ≠ l ∧ s = {i, j, k, l} := by
  obtain ⟨a, r, har, rfl, hr⟩ := Finset.card_eq_succ.mp h
  obtain ⟨b, c, d, hbc, hbd, hcd, rfl⟩ := Finset.card_eq_three.mp hr
  simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at har
  exact ⟨a, b, c, d, har.1, har.2.1, har.2.2, hbc, hbd, hcd, rfl⟩

/-- **One sector at a time**: on a nonzero isotypic component of an `L_e`-eigenvector orthogonal to `M`, the value is at
most `1/2`, and `1/2` forces the component's character to be a cross pair. -/
theorem comp_sector (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3))
    (t : ℝ) (ht : 0 < t) (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = lam • H)
    (s : Finset (Fin n)) (hs0 : comp s H hHW ≠ 0) :
    lam ≤ 1 / 2 ∧ (lam = 1 / 2 → ∃ j k, j ∈ T ∧ k ∉ T ∧ s = {j, k}) := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  set w := t • sphereWeight T with hwdef
  have hwt : IsWeight w := (sphereWeight_isWeight T hp2 hq2).smul t
  set M := restrict (diagOp_isWeyl hwt) with hMdef
  have hM1 : SignChar (fun _ => 1) M := (HamiltonsCubic.L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hwt, rfl⟩
  have hPθ : Pcubic (diagOp w) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp2 hq2 t) hn
  have hPM : Pcubic2 M = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [hMdef, Pcubic2_restrict (isLinOp_diagOp w) (diagOp_isWeyl hwt), hPθ]
  have hpR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (3 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  set θ := t * ((T.card : ℝ) + Tᶜ.card - 1) with hθdef
  have hθ : 0 < θ := mul_pos ht (by linarith)
  -- `L_e` and `M ∘`
  have hLe : ∀ V : CurvOp2 (Fin n), LeLin M V = θ⁻¹ • foxProd2 M V := fun V => by
    rw [← hPM]; exact foxProd2_smul_left _ _ _
  have hfox : foxProd2 M H = (lam * θ) • H := by
    have h2 := congrArg (fun F => θ • F) (heig.symm.trans (hLe H))
    simp only [smul_smul, mul_inv_cancel₀ hθ.ne', one_smul] at h2
    rw [← h2, mul_comm]
  have hce := comp_eigen hM1 hHW hfox s
  have hcLe : LeLin M (comp s H hHW) = lam • comp s H hHW := by
    rw [hLe, hce, smul_smul]
    congr 1
    field_simp
  have hcW := comp_isWeyl2 s H hHW
  have hcc := comp_char s H hHW
  -- the size of `s`
  have hcard : s.card = 0 ∨ s.card = 2 ∨ s.card = 4 := by
    by_contra hc
    exact hs0 (HamiltonsCubic.L120Support.comp_zero s H hHW hc)
  rcases hcard with h0 | h2 | h4
  · -- the diagonal sector
    have hs : s = ∅ := Finset.card_eq_zero.mp h0
    subst hs
    have hc1 : SignChar (fun _ => 1) (comp ∅ H hHW) :=
      signChar_congr hcc fun ε _ => by simp [setChar]
    have hcp : innerOp2 M (comp ∅ H hHW) = 0 := (comp_perp hM1 ∅ hHW hperp).2
    have hlt := HamiltonsCubic.L27Dn.dn_sphere T hp hq t ht hn hcW hc1 hs0 hcp hcLe
    exact ⟨hlt.le, fun h => absurd h hlt.ne⟩
  · -- a pair sector
    obtain ⟨j, k, hjk, rfl⟩ := Finset.card_eq_two.mp h2
    obtain ⟨hle, hcross⟩ := HamiltonsCubic.L27Pair.pair_sphere T hp2 hq2 t ht hn hjk hcW hcc hs0 hcLe
    refine ⟨hle, fun h => ?_⟩
    rcases hcross h with ⟨hj, hk⟩ | ⟨hj, hk⟩
    · exact ⟨j, k, hj, hk, rfl⟩
    · exact ⟨k, j, hk, hj, Finset.pair_comm j k⟩
  · -- a four-set sector
    obtain ⟨i, j, k, l, hij, hik, hil, hjk, hjl, hkl, rfl⟩ := card_four h4
    have hce' : foxProd2 (I117S.coordOp (t • sphereWeight T)) (comp {i, j, k, l} H hHW)
        = (lam * θ) • comp {i, j, k, l} H hHW := by
      rw [coordOp_eq_restrict hwt]; exact hce
    have htheta : 0 < theta (diagOp (t • sphereWeight T)) := by rw [theta_of_unit _ hn, hPθ]; exact hθ
    have hlt := HamiltonsCubic.L27Four.four_sphere_lt hij hik hil hjk hjl hkl T hp hq hne t ht hn htheta hcW hcc hs0 hce'
    rw [theta_of_unit _ hn, hPθ] at hlt
    have hθ2 : 0 < θ ^ 2 := by positivity
    have h' : θ ^ 2 * (4 * lam ^ 2) < θ ^ 2 * 1 := by nlinarith [hlt]
    have h4 : 4 * lam ^ 2 < 1 := lt_of_mul_lt_mul_left h' hθ2.le
    have hlam : lam < 1 / 2 := by nlinarith
    exact ⟨hlam.le, fun h => absurd h hlam.ne⟩

/-- **L27 at the operators, by the sign group**: at a unit sphere product with `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, every
`L_e`-eigenvalue on a nonzero Weyl `H ⊥ M` is at most `1/2`, and at `1/2` every nonzero isotypic component of `H` sits on a
cross pair `{j, k}`, `j ∈ T`, `k ∉ T`. -/
theorem L27_half (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3))
    (t : ℝ) (ht : 0 < t) (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (hH0 : H ≠ 0) {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = lam • H) :
    lam ≤ 1 / 2 ∧ (lam = 1 / 2 → ∀ s, comp s H hHW ≠ 0 → ∃ j k, j ∈ T ∧ k ∉ T ∧ s = {j, k}) := by
  have hex : ∃ s, comp s H hHW ≠ 0 := by
    by_contra hc
    push Not at hc
    apply hH0
    rw [← sum_comp H hHW]
    exact Finset.sum_eq_zero fun s _ => hc s
  obtain ⟨s, hs⟩ := hex
  exact ⟨(comp_sector T hp hq hne t ht hn hHW hperp heig s hs).1,
    fun h s' hs' => (comp_sector T hp hq hne t ht hn hHW hperp heig s' hs').2 h⟩

end HamiltonsCubic.L27Main
