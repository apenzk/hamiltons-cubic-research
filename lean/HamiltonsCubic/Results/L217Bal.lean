import Mathlib
import HamiltonsCubic.Results.L3Local
import HamiltonsCubic.Results.L217Le
import HamiltonsCubic.Results.L216Unbal

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L217 corollary (a) on the operators: a global maximiser near the balanced orbit forces `sup P = θ₀(n)`

[findings/second-order.md](../../../findings/second-order.md), Lemma L217, corollary (a): *At $n=2k\ge12$ and $u$ the unit Weyl tensor
of $S^k\times S^k$, [L216]'s corollary gives $\gamma=1/(n-2)$. So if some global maximiser lies within geodesic angle
$\arcsin\frac3{n-2}$ of the balanced orbit, then $\sup P=\theta_0(n)$.*

[L217Le.lean](L217Le.lean)'s `L217_op_Le` proves the value bootstrap with the direction `v`, the orbit-normal condition and the gap as
hypotheses. At the balanced product all three are supplied here, with [L3Local.lean](L3Local.lean)'s orbit machinery in place of the
record's geodesic: the maximiser `U₀` of `U ↦ ⟨U · W^∗, W_{m,m}⟩` gives `cos φ = ⟨U₀ · W^∗, W_{m,m}⟩`, `first_order` puts the
normal part orthogonal to the orbit tangent, and the spectral gap of `L_e` there is `½ − 1/(n − 2)`:

* **`Le_bound_balanced`**: `⟨L_e H, H⟩ ≤ (m − 2)/(2(m − 1)) ‖H‖²` at every Weyl `H ⊥ W_{m,m}` orthogonal to the `½`-eigenvectors;
* **`L217_balanced`**: at `n = 2m`, `m ≥ 4`, a global maximiser `W^∗` of `P` on the unit sphere with some orbit point `U · W^∗`
  at `⟨U · W^∗, W_{m,m}⟩ ≥ √(1 − (3/(n − 2))²)` has `P(W^∗) = θ₀(n)`;
* **`L217_sphere`**: the same at every sphere product `S^p × S^q`, `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, with L216's gap
  `γ_{p,q} = ½ − max(λ_p, λ_q, μ)` ([L216Unbal.lean](L216Unbal.lean)'s `Le_gap_sphere`) and angle `arcsin min(3γ_{p,q}, ½)`;
* **`L217_no_max_near`**: corollary (b), a sphere product below a global maximiser has no orbit point within that angle of it.
-/

namespace HamiltonsCubic.L217Bal

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FrameOp2 HamiltonsCubic.FrameLayer HamiltonsCubic.TensorBridge
  HamiltonsCubic.Results HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L126Assembly HamiltonsCubic.L27Close HamiltonsCubic.L120Eigen HamiltonsCubic.L27Span HamiltonsCubic.L3Local

variable {n : ℕ}

/-- **The spectral gap of `L_e` at the balanced product**, off the `½`-eigenvectors. -/
theorem Le_bound_balanced (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (horb : ∀ K : CurvOp2 (Fin n), IsWeyl2 K →
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K →
      innerOp2 K H = 0) :
    innerOp2 (LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H) H
      ≤ ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) * normSq2 H := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  have hwt := (sphereWeight_isWeight T hp2 hq2).smul t
  set M := restrict (diagOp_isWeyl hwt) with hMdef
  have hMW : IsWeyl2 M := isWeyl2_restrict _
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp2 hq2 t) hn
  have hPM : Pcubic2 M = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [hMdef, Pcubic2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hPθ]
  have hmR : (4 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : ((Tᶜ.card : ℕ) : ℝ) = (T.card : ℝ) := by exact_mod_cast hpq
  have hθ : 0 < t * ((T.card : ℝ) + Tᶜ.card - 1) := mul_pos ht (by rw [hqR]; linarith)
  have ha : normSq2 M = 1 := by rw [hMdef, normSq2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hn]
  have hcrit : Qop2 M = (t * ((T.card : ℝ) + Tᶜ.card - 1)) • M := sphere_isCritical2 T hp2 hq2 t
  have hP0 : Pcubic2 M ≠ 0 := by rw [hPM]; exact hθ.ne'
  set v : weylPerpR M := ⟨(RecCurv.equiv H : RecCurv (Fin n)), hHW, hperp⟩
  have key := HamiltonsCubic.L3Quad.quad_le_of_gap (LeRestr_isSymmetric ha hMW hcrit hP0) (1 / 2)
    (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)))
    (fun w hw μ hμ hne => by
      have hw0 : tanV w ≠ 0 := by
        intro h; apply hw; exact Subtype.ext h
      have he : LeLin M (tanV w) = μ • tanV w := congrArg Subtype.val hμ
      exact HamiltonsCubic.L3Gap.L3_gap_balanced T hp hpq t ht hn w.2.1 w.2.2 hw0 he hne)
    v (fun w hw => horb (tanV w) w.2.1 w.2.2 (congrArg Subtype.val hw))
  have hnorm : ‖v‖ ^ 2 = normSq2 H := RecCurv.norm_sq_eq (v : RecCurv (Fin n))
  have hin : inner ℝ (LeRestr ha hMW hcrit hP0 v) v = innerOp2 (LeLin M H) H := rfl
  rw [hnorm, hin] at key
  exact key

/-- **L217 corollary (a).** At `n = 2m`, `m ≥ 4`, let `W^∗` be a global maximiser of `P` on the unit sphere of `𝒲ₙ`, and suppose some
orbit point `U · W^∗` has `⟨U · W^∗, W_{m,m}⟩ ≥ √(1 − (3/(n − 2))²)`, i.e. `W^∗` lies within geodesic angle `arcsin (3/(n − 2))` of the
balanced orbit. Then `P(W^∗) = P(W_{m,m}) = θ₀(n)`. -/
theorem L217_balanced (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {W : CurvOp2 (Fin n)} (hWW : IsWeyl2 W) (hW1 : normSq2 W = 1)
    (hmax : ∀ R : CurvOp2 (Fin n), IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 W)
    (hnear : ∃ U, IsOrth U ∧ Real.sqrt (1 - (3 / ((T.card : ℝ) + Tᶜ.card - 2)) ^ 2)
      ≤ innerOp2 (rotR U W) (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t)))) :
    Pcubic2 W = Pcubic2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  have hp3 : 3 ≤ T.card := by omega
  have hq3 : 3 ≤ Tᶜ.card := by omega
  have hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3) := by omega
  have hwt : IsWeight (t • sphereWeight T) := (sphereWeight_isWeight T hp2 hq2).smul t
  set M := restrict (diagOp_isWeyl hwt) with hMdef
  have hMW : IsWeyl2 M := isWeyl2_restrict _
  have hcoord : HamiltonsCubic.I117S.coordOp (t • sphereWeight T) = M := HamiltonsCubic.PairSquare.coordOp_eq_restrict hwt
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp2 hq2 t) hn
  have hPM : Pcubic2 M = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [hMdef, Pcubic2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hPθ]
  have hmR : (4 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : ((Tᶜ.card : ℕ) : ℝ) = (T.card : ℝ) := by exact_mod_cast hpq
  have hθ : 0 < t * ((T.card : ℝ) + Tᶜ.card - 1) := mul_pos ht (by rw [hqR]; linarith)
  have ha1 : normSq2 M = 1 := by rw [hMdef, normSq2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hn]
  have hcrit : Qop2 M = (t * ((T.card : ℝ) + Tᶜ.card - 1)) • M := sphere_isCritical2 T hp2 hq2 t
  set D : ℝ := (T.card : ℝ) + Tᶜ.card - 2 with hDdef
  have hD6 : 6 ≤ D := by rw [hDdef, hqR]; linarith
  obtain ⟨U, hU, hUnear⟩ := hnear
  obtain ⟨U₀, hU₀, hmx⟩ := exists_max W M
  set V' := rotR U₀ W with hV'def
  have hV'W : IsWeyl2 V' := rotR_isWeyl2 hU₀ hWW
  have hV'1 : normSq2 V' = 1 := by rw [hV'def, normSq2_rotR hU₀ hWW, hW1]
  have hPV : Pcubic2 W = Pcubic2 V' := (Pcubic2_rotR hU₀ hWW).symm
  set c := innerOp2 V' M with hcdef
  have hc_ge : Real.sqrt (1 - (3 / D) ^ 2) ≤ c := le_trans hUnear (hmx U hU)
  have hc0 : 0 ≤ c := le_trans (Real.sqrt_nonneg _) hc_ge
  set h := V' - c • M with hhdef
  have hhW : IsWeyl2 h := HamiltonsCubic.L214Frame.isWeyl2_sub' hV'W (isWeyl2_smul c hMW)
  have hperp : innerOp2 M h = 0 := by
    rw [hhdef, innerOp2_comm, innerOp2_sub_left', innerOp2_smul_left, show innerOp2 M M = 1 from ha1, ← hcdef]; ring
  have hu : normSq2 h = 1 - c ^ 2 := by
    rw [hhdef, normSq2_sub, hV'1, innerOp2_smul_right, ← hcdef]
    unfold normSq2
    rw [innerOp2_smul_left, innerOp2_smul_right]
    unfold normSq2 at ha1
    rw [ha1]; ring
  have hdecomp : V' = c • M + h := by rw [hhdef]; abel
  have hgen : ∀ q : ↥(T ×ˢ Tᶜ), innerOp2 (crossOrbit T t q) h = 0 := by
    intro q
    obtain ⟨hj, hk⟩ := mem_cross T q
    have hjk : q.1.1 ≠ q.1.2 := fun e => hk (e ▸ hj)
    have hprops := orbitOp_props T hp2 hq2 t ht hn hj hk
    have hOM : innerOp2 (crossOrbit T t q) M = 0 := by
      rw [innerOp2_comm]; exact hprops.2.2.2.1
    have hOV : innerOp2 (crossOrbit T t q) V' = 0 := by
      show innerOp2 (orbitOp T t q.1.1 q.1.2) V' = 0
      rw [orbitOp_eq T t hjk, innerOp2_smul_left]
      have := first_order hwt hWW hU₀ (fun U hU => by rw [hcoord]; exact hmx U hU) hjk
      rw [this]; ring
    rw [hhdef, innerOp2_comm, innerOp2_sub_left', innerOp2_smul_left, innerOp2_comm V', innerOp2_comm M, hOV, hOM]
    ring
  have hspan0 : ∀ K' ∈ Submodule.span ℝ (Set.range (crossOrbit T t)), ∀ X : CurvOp2 (Fin n),
      (∀ q, innerOp2 (crossOrbit T t q) X = 0) → innerOp2 K' X = 0 := by
    intro K' hK' X hX
    have hz : innerOp2 (0 : CurvOp2 (Fin n)) X = 0 := by
      have e := innerOp2_smul_left (0 : ℝ) X X
      rw [zero_mul] at e
      rw [← e]; congr 1; module
    induction hK' using Submodule.span_induction with
    | mem x hx =>
      obtain ⟨q, rfl⟩ := hx
      exact hX q
    | zero => exact hz
    | add x y _ _ hx hy => rw [innerOp2_add_left, hx, hy, add_zero]
    | smul a x _ hx => rw [innerOp2_smul_left, hx, mul_zero]
  have hPV' : Pcubic2 M ≤ Pcubic2 V' := by rw [← hPV]; exact hmax M hMW ha1
  have hu0 : 0 ≤ normSq2 h := innerOp2_self_nonneg h
  clear_value h c V' D
  by_cases hz : normSq2 h = 0
  · have h0 : h = 0 := normSq2_eq_zero hz
    have e : (c - 1) * (c + 1) = 0 := by
      have : 1 - c ^ 2 = 0 := by rw [← hu, hz]
      linear_combination -this
    have hc1 : c = 1 := by
      rcases mul_eq_zero.mp e with h1 | h1
      · linarith
      · linarith
    rw [hPV, hdecomp, h0, hc1]
    congr 1
    module
  · have hpos : 0 < normSq2 h := lt_of_le_of_ne hu0 (Ne.symm hz)
    set s := Real.sqrt (normSq2 h) with hsdef
    have hs0 : 0 < s := Real.sqrt_pos.mpr hpos
    have hs2 : s ^ 2 = normSq2 h := Real.sq_sqrt hu0
    have hcs : c ^ 2 + s ^ 2 = 1 := by rw [hs2, hu]; ring
    -- `s ≤ 3/D`
    have hc2 : 1 - (3 / D) ^ 2 ≤ c ^ 2 := by
      have hr := Real.sqrt_nonneg (1 - (3 / D) ^ 2)
      have hsq : Real.sqrt (1 - (3 / D) ^ 2) ^ 2 ≤ c ^ 2 := pow_le_pow_left₀ hr hc_ge 2
      by_cases hneg : 0 ≤ 1 - (3 / D) ^ 2
      · rwa [Real.sq_sqrt hneg] at hsq
      · push_neg at hneg; nlinarith only [hneg, sq_nonneg c]
    have h3D : 0 ≤ 3 / D := by positivity
    have hs : s ≤ 3 / D := by
      have hss : s ^ 2 ≤ (3 / D) ^ 2 := by linarith only [hcs, hc2]
      exact (pow_le_pow_iff_left₀ hs0.le h3D (by norm_num)).mp hss
    have hshalf : s ≤ 1 / 2 := by
      have : 3 / D ≤ 1 / 2 := by rw [div_le_div_iff₀ (by linarith only [hD6]) (by norm_num)]; linarith only [hD6]
      linarith only [hs, this]
    -- the unit direction
    set v := s⁻¹ • h with hvdef
    have hvW : IsWeyl2 v := isWeyl2_smul _ hhW
    have hv1 : normSq2 v = 1 := by
      rw [hvdef]; unfold normSq2
      rw [innerOp2_smul_left, innerOp2_smul_right]
      have : innerOp2 h h = s ^ 2 := hs2.symm
      rw [this]; field_simp
    have hvu : innerOp2 M v = 0 := by rw [hvdef, innerOp2_smul_right, hperp, mul_zero]
    have hvorb : ∀ K : CurvOp2 (Fin n), IsWeyl2 K → innerOp2 M K = 0 → LeLin M K = (1 / 2 : ℝ) • K → innerOp2 K v = 0 := by
      intro K hKW hKM hKe
      have hspan := (L27_half_span T hp3 hq3 hne t ht hn hKW).mp ⟨hKM, hKe⟩
      have hKh : innerOp2 K h = 0 := hspan0 K hspan h hgen
      rw [hvdef, innerOp2_smul_right, hKh, mul_zero]
    have hgap := Le_bound_balanced T hp hpq t ht hn hvW hvu hvorb
    rw [hv1, mul_one] at hgap
    have hγ : ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) = 1 / 2 - 1 / D := by
      rw [hDdef, hqR, show (T.card : ℝ) + T.card - 2 = 2 * ((T.card : ℝ) - 1) by ring]
      have h1 : (T.card : ℝ) - 1 ≠ 0 := by linarith only [hmR]
      field_simp; ring
    rw [hγ] at hgap
    have hW' : V' = c • M + s • v := by
      rw [hdecomp, hvdef, smul_smul, mul_inv_cancel₀ hs0.ne', one_smul]
    have hmax' : ∀ R : CurvOp2 (Fin n), IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 V' := by
      intro R hRW hR1; rw [← hPV]; exact hmax R hRW hR1
    have hs3 : s ≤ 3 * (1 / D) := by rw [show 3 * (1 / D) = 3 / D by ring]; exact hs
    have hle := HamiltonsCubic.L217Le.L217_op_Le hMW.isSelfAdjoint2 hcrit ha1 hθ hvW hv1 hvu hgap hs0.le hc0 hcs hs3
      hshalf hW' hmax'
    rw [hPV]
    rw [hPM] at hPV' ⊢
    linarith only [hle, hPV']


/-- **L217 at every sphere product off `(3, 3)`**, the lemma behind corollary (b): at `S^p × S^q`, `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, with
L216's gap `γ_{p,q} = ½ − max(λ_p, λ_q, μ)`, a global maximiser `W^∗` within geodesic angle `arcsin min(3γ_{p,q}, ½)` of the orbit has
`P(W^∗) = θ_{p,q}`. -/
theorem L217_sphere (T : Finset (Fin n)) (hp3 : 3 ≤ T.card) (hq3 : 3 ≤ Tᶜ.card) (hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3)) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {W : CurvOp2 (Fin n)} (hWW : IsWeyl2 W) (hW1 : normSq2 W = 1)
    (hmax : ∀ R : CurvOp2 (Fin n), IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 W)
    (hnear : ∃ U, IsOrth U ∧ Real.sqrt (1 - (min (3 * (1 / 2 - HamiltonsCubic.L216Unbal.lamTop (T.card : ℝ) (Tᶜ.card : ℝ))) (1 / 2)) ^ 2)
      ≤ innerOp2 (rotR U W) (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t)))) :
    Pcubic2 W = Pcubic2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  have hwt : IsWeight (t • sphereWeight T) := (sphereWeight_isWeight T hp2 hq2).smul t
  set M := restrict (diagOp_isWeyl hwt) with hMdef
  have hMW : IsWeyl2 M := isWeyl2_restrict _
  have hcoord : HamiltonsCubic.I117S.coordOp (t • sphereWeight T) = M := HamiltonsCubic.PairSquare.coordOp_eq_restrict hwt
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp2 hq2 t) hn
  have hPM : Pcubic2 M = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [hMdef, Pcubic2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hPθ]
  have hmR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp3
  have hqR : (3 : ℝ) ≤ ((Tᶜ.card : ℕ) : ℝ) := by exact_mod_cast hq3
  have hθ : 0 < t * ((T.card : ℝ) + Tᶜ.card - 1) := mul_pos ht (by linarith)
  have ha1 : normSq2 M = 1 := by rw [hMdef, normSq2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hn]
  have hcrit : Qop2 M = (t * ((T.card : ℝ) + Tᶜ.card - 1)) • M := sphere_isCritical2 T hp2 hq2 t
  set r : ℝ := min (3 * (1 / 2 - HamiltonsCubic.L216Unbal.lamTop (T.card : ℝ) (Tᶜ.card : ℝ))) (1 / 2) with hrdef
  have hγ0 : 0 < 1 / 2 - HamiltonsCubic.L216Unbal.lamTop (T.card : ℝ) (Tᶜ.card : ℝ) := by
    have := HamiltonsCubic.L216Unbal.gap_lt_half hmR hqR (fun h => hne ⟨by exact_mod_cast h.1, by exact_mod_cast h.2⟩)
    linarith
  have hr0 : 0 ≤ r := le_min (by linarith) (by norm_num)
  obtain ⟨U, hU, hUnear⟩ := hnear
  obtain ⟨U₀, hU₀, hmx⟩ := exists_max W M
  set V' := rotR U₀ W with hV'def
  have hV'W : IsWeyl2 V' := rotR_isWeyl2 hU₀ hWW
  have hV'1 : normSq2 V' = 1 := by rw [hV'def, normSq2_rotR hU₀ hWW, hW1]
  have hPV : Pcubic2 W = Pcubic2 V' := (Pcubic2_rotR hU₀ hWW).symm
  set c := innerOp2 V' M with hcdef
  have hc_ge : Real.sqrt (1 - r ^ 2) ≤ c := le_trans hUnear (hmx U hU)
  have hc0 : 0 ≤ c := le_trans (Real.sqrt_nonneg _) hc_ge
  set h := V' - c • M with hhdef
  have hhW : IsWeyl2 h := HamiltonsCubic.L214Frame.isWeyl2_sub' hV'W (isWeyl2_smul c hMW)
  have hperp : innerOp2 M h = 0 := by
    rw [hhdef, innerOp2_comm, innerOp2_sub_left', innerOp2_smul_left, show innerOp2 M M = 1 from ha1, ← hcdef]; ring
  have hu : normSq2 h = 1 - c ^ 2 := by
    rw [hhdef, normSq2_sub, hV'1, innerOp2_smul_right, ← hcdef]
    unfold normSq2
    rw [innerOp2_smul_left, innerOp2_smul_right]
    unfold normSq2 at ha1
    rw [ha1]; ring
  have hdecomp : V' = c • M + h := by rw [hhdef]; abel
  have hgen : ∀ q : ↥(T ×ˢ Tᶜ), innerOp2 (crossOrbit T t q) h = 0 := by
    intro q
    obtain ⟨hj, hk⟩ := mem_cross T q
    have hjk : q.1.1 ≠ q.1.2 := fun e => hk (e ▸ hj)
    have hprops := orbitOp_props T hp2 hq2 t ht hn hj hk
    have hOM : innerOp2 (crossOrbit T t q) M = 0 := by
      rw [innerOp2_comm]; exact hprops.2.2.2.1
    have hOV : innerOp2 (crossOrbit T t q) V' = 0 := by
      show innerOp2 (orbitOp T t q.1.1 q.1.2) V' = 0
      rw [orbitOp_eq T t hjk, innerOp2_smul_left]
      have := first_order hwt hWW hU₀ (fun U hU => by rw [hcoord]; exact hmx U hU) hjk
      rw [this]; ring
    rw [hhdef, innerOp2_comm, innerOp2_sub_left', innerOp2_smul_left, innerOp2_comm V', innerOp2_comm M, hOV, hOM]
    ring
  have hspan0 : ∀ K' ∈ Submodule.span ℝ (Set.range (crossOrbit T t)), ∀ X : CurvOp2 (Fin n),
      (∀ q, innerOp2 (crossOrbit T t q) X = 0) → innerOp2 K' X = 0 := by
    intro K' hK' X hX
    have hz : innerOp2 (0 : CurvOp2 (Fin n)) X = 0 := by
      have e := innerOp2_smul_left (0 : ℝ) X X
      rw [zero_mul] at e
      rw [← e]; congr 1; module
    induction hK' using Submodule.span_induction with
    | mem x hx =>
      obtain ⟨q, rfl⟩ := hx
      exact hX q
    | zero => exact hz
    | add x y _ _ hx hy => rw [innerOp2_add_left, hx, hy, add_zero]
    | smul a x _ hx => rw [innerOp2_smul_left, hx, mul_zero]
  have hPV' : Pcubic2 M ≤ Pcubic2 V' := by rw [← hPV]; exact hmax M hMW ha1
  have hu0 : 0 ≤ normSq2 h := innerOp2_self_nonneg h
  clear_value h c V' r
  by_cases hz : normSq2 h = 0
  · have h0 : h = 0 := normSq2_eq_zero hz
    have e : (c - 1) * (c + 1) = 0 := by
      have : 1 - c ^ 2 = 0 := by rw [← hu, hz]
      linear_combination -this
    have hc1 : c = 1 := by
      rcases mul_eq_zero.mp e with h1 | h1
      · linarith
      · linarith
    rw [hPV, hdecomp, h0, hc1]
    congr 1
    module
  · have hpos : 0 < normSq2 h := lt_of_le_of_ne hu0 (Ne.symm hz)
    set s := Real.sqrt (normSq2 h) with hsdef
    have hs0 : 0 < s := Real.sqrt_pos.mpr hpos
    have hs2 : s ^ 2 = normSq2 h := Real.sq_sqrt hu0
    have hcs : c ^ 2 + s ^ 2 = 1 := by rw [hs2, hu]; ring
    -- `s ≤ r`
    have hc2 : 1 - r ^ 2 ≤ c ^ 2 := by
      have hr := Real.sqrt_nonneg (1 - r ^ 2)
      have hsq : Real.sqrt (1 - r ^ 2) ^ 2 ≤ c ^ 2 := pow_le_pow_left₀ hr hc_ge 2
      by_cases hneg : 0 ≤ 1 - r ^ 2
      · rwa [Real.sq_sqrt hneg] at hsq
      · push_neg at hneg; nlinarith only [hneg, sq_nonneg c]
    have hs : s ≤ r := by
      have hss : s ^ 2 ≤ r ^ 2 := by linarith only [hcs, hc2]
      exact (pow_le_pow_iff_left₀ hs0.le hr0 (by norm_num)).mp hss
    have hshalf : s ≤ 1 / 2 := le_trans hs (by rw [hrdef]; exact min_le_right _ _)
    -- the unit direction
    set v := s⁻¹ • h with hvdef
    have hvW : IsWeyl2 v := isWeyl2_smul _ hhW
    have hv1 : normSq2 v = 1 := by
      rw [hvdef]; unfold normSq2
      rw [innerOp2_smul_left, innerOp2_smul_right]
      have : innerOp2 h h = s ^ 2 := hs2.symm
      rw [this]; field_simp
    have hvu : innerOp2 M v = 0 := by rw [hvdef, innerOp2_smul_right, hperp, mul_zero]
    have hvcross : ∀ q, innerOp2 (crossOrbit T t q) v = 0 := by
      intro q; rw [hvdef, innerOp2_smul_right, hgen q, mul_zero]
    have hvorb := HamiltonsCubic.L216Unbal.horb_of_orbit T hp3 hq3 hne t ht hn hvcross
    have hgap := HamiltonsCubic.L216Unbal.Le_gap_sphere T hp3 hq3 t ht hn hvW hv1 hvu hvorb
    have hgap' : innerOp2 (LeLin M v) v ≤ 1 / 2 - (1 / 2 - HamiltonsCubic.L216Unbal.lamTop (T.card : ℝ) (Tᶜ.card : ℝ)) := by
      linarith only [hgap]
    have hW' : V' = c • M + s • v := by
      rw [hdecomp, hvdef, smul_smul, mul_inv_cancel₀ hs0.ne', one_smul]
    have hmax' : ∀ R : CurvOp2 (Fin n), IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 V' := by
      intro R hRW hR1; rw [← hPV]; exact hmax R hRW hR1
    have hs3 : s ≤ 3 * (1 / 2 - HamiltonsCubic.L216Unbal.lamTop (T.card : ℝ) (Tᶜ.card : ℝ)) :=
      le_trans hs (by rw [hrdef]; exact min_le_left _ _)
    have hle := HamiltonsCubic.L217Le.L217_op_Le hMW.isSelfAdjoint2 hcrit ha1 hθ hvW hv1 hvu hgap' hs0.le hc0 hcs hs3
      hshalf hW' hmax'
    rw [hPV]
    rw [hPM] at hPV' ⊢
    linarith only [hle, hPV']


/-- **L217 corollary (b)**: a sphere product `S^p × S^q`, `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, whose value is below that of a global
maximiser `W^∗` has no orbit point within geodesic angle `arcsin min(3γ_{p,q}, ½)` of `W^∗`. -/
theorem L217_no_max_near (T : Finset (Fin n)) (hp3 : 3 ≤ T.card) (hq3 : 3 ≤ Tᶜ.card) (hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3))
    (t : ℝ) (ht : 0 < t) (hn : normSq (diagOp (t • sphereWeight T)) = 1) {W : CurvOp2 (Fin n)} (hWW : IsWeyl2 W)
    (hW1 : normSq2 W = 1) (hmax : ∀ R : CurvOp2 (Fin n), IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 W)
    (hlt : Pcubic2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) < Pcubic2 W)
    (U : Matrix (Fin n) (Fin n) ℝ) (hU : IsOrth U) :
    innerOp2 (rotR U W) (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t)))
      < Real.sqrt (1 - (min (3 * (1 / 2 - HamiltonsCubic.L216Unbal.lamTop (T.card : ℝ) (Tᶜ.card : ℝ))) (1 / 2)) ^ 2) := by
  by_contra hge
  have hge := le_of_not_gt hge
  have := L217_sphere T hp3 hq3 hne t ht hn hWW hW1 hmax ⟨U, hU, hge⟩
  linarith

end HamiltonsCubic.L217Bal
