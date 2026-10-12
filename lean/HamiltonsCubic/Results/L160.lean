import HamiltonsCubic.Results.SkewCentraliser

set_option linter.style.longLine false

/-!
# L160, the mixed summand dies exactly off `m = 3`

[isotropy-cap.md](../../../findings/isotropy-cap.md), Lemma L160: for nonzero `x ∈ 𝔰𝔬(m)` with `V = im x`,
`K = ker x` and `𝔠 = 𝔷(x) ∩ x^⊥`, the mixed summand `Hom(K, V)` contributes nothing to `𝔷(𝔠) ∩ 𝔠^⊥`
**if and only if `m ≠ 3`**.

The two mechanisms the block names are [SkewCentraliser.lean](SkewCentraliser.lean)'s, split there by the
number of planes of `x` rather than by `dim K`:

* **two or more planes** (`rank x ≥ 4`): the torus elements `a_l R_j - a_j R_l` lie in `𝔠`, and commuting with
  them kills the plane-kernel entries, `kernel_two`. This is the block's *`𝔠_V` has trivial common kernel*;
* **one plane** (`rank x = 2`): a kernel rotation `rot z z'` lies in `𝔠`, and it needs a second kernel
  direction whenever `K ≠ 0`, `kernel_one`. At rank two `dim K = m - 2`, so the one failing case is
  `dim K = 1`, which is `m = 3`. At `m = 2` the kernel is zero and there is nothing to kill. This is the
  block's *`𝔰𝔬(K)` fixes no vector*.

Proved here:

* **`L160_support`**: at `m ≠ 3`, every `y ∈ 𝔷(𝔠) ∩ 𝔠^⊥` kills `ker x`, so `y ∈ 𝔰𝔬(V)`, with no mixed and no
  kernel-kernel part;
* **`cc_three`**, **`L160_three`**: at `m = 3`, `𝔠 = 0` for every nonzero `x`, so `𝔷(𝔠) ∩ 𝔠^⊥ = 𝔰𝔬(3)`, and
  it carries an element moving `ker x`;
* **`L160`**: the two together, `m ≠ 3` if and only if the mixed summand dies at every skew `x`.

The displayed identity `𝔷(𝔠) ∩ 𝔠^⊥ = 𝔷_{𝔰𝔬(V)}(𝔠_V) ∩ 𝔠_V^{⊥_V}` is `L160_identity` in
[L160Identity.lean](L160Identity.lean), whose inclusion into `𝔰𝔬(V)` is `L160_support` here.
-/

namespace HamiltonsCubic.MixedSummand

open Matrix Module HamiltonsCubic.SkewNormalForm HamiltonsCubic.SkewCentraliser HamiltonsCubic.L81Statement

variable {m : ℕ} {x : Matrix (Fin m) (Fin m) ℝ}

/-- `ker x` is the orthogonal complement of the planes. -/
theorem inK_of_ker (N : NF x) (hx : Skew x) {z : Fin m → ℝ} (hz : x *ᵥ z = 0) : InK N z := by
  intro j
  have hu := co_skew hx z (N.u j)
  have hw := co_skew hx z (N.w j)
  unfold co at hu hw
  rw [hz, dotProduct_zero, x_u N, dotProduct_smul, smul_eq_mul] at hu
  rw [hz, dotProduct_zero, x_w N, dotProduct_neg, dotProduct_smul, smul_eq_mul] at hw
  have ha := (N.apos j).ne'
  refine ⟨?_, ?_⟩
  · have : N.a j * (z ⬝ᵥ N.u j) = 0 := by linarith
    rw [dotProduct_comm]; exact (mul_eq_zero.mp this).resolve_left ha
  · have : N.a j * (z ⬝ᵥ N.w j) = 0 := by linarith
    rw [dotProduct_comm]; exact (mul_eq_zero.mp this).resolve_left ha

/-- **The mixed entries die off `m = 3`**, by `kernel_two` at two or more planes and `kernel_one` at one. -/
theorem mixed_zero (hx : Skew x) (hm : m ≠ 3) (N : NF x) {y : Matrix (Fin m) (Fin m) ℝ} (hy : y ∈ zPerp x)
    (j : Fin N.k) {z : Fin m → ℝ} (hz : InK N z) : co y (N.u j) z = 0 ∧ co y (N.w j) z = 0 := by
  by_cases h2 : 2 ≤ N.k
  · obtain ⟨l, hjl⟩ := exists_other h2 j
    exact kernel_two N hy hjl hz
  · exact kernel_one N hy hx hm (by have := j.2; omega) j hz

/-- **L160, the reduction**: at `m ≠ 3`, every `y ∈ 𝔷(𝔠) ∩ 𝔠^⊥` kills `ker x`. With `y` skew this puts `y`
in `𝔰𝔬(im x)`: no mixed part and no kernel-kernel part. -/
theorem L160_support (hx : Skew x) (hm : m ≠ 3) {y : Matrix (Fin m) (Fin m) ℝ} (hy : y ∈ zPerp x)
    {z : Fin m → ℝ} (hz : x *ᵥ z = 0) : y *ᵥ z = 0 := by
  obtain ⟨N⟩ := nf_exists hx
  have hzK := inK_of_ker N hx hz
  have hall : ∀ p, co y p z = 0 := by
    intro p
    rw [show p = proj N p + (p - proj N p) by abel, co_add_l, kernel_kernel N hy hx (kp_inK N p) hzK, add_zero]
    simp only [proj, co_sum_l, co_add_l, co_smul_l, (mixed_zero hx hm N hy _ hzK).1,
      (mixed_zero hx hm N hy _ hzK).2, mul_zero, add_zero, Finset.sum_const_zero]
  have := hall (y *ᵥ z)
  unfold co at this
  exact dotProduct_self_eq_zero.mp this

/-! ## `m = 3` -/

section Three

variable (N : NF x)

theorem u_ne (j : Fin N.k) : N.u j ≠ 0 := fun h => by have := N.uu j j; simp [h] at this
theorem w_ne (j : Fin N.k) : N.w j ≠ 0 := fun h => by have := N.ww j j; simp [h] at this

/-- In `ℝ³`, one plane: `2k ≤ 3` and `x ≠ 0` give `k = 1`. -/
theorem k_eq_one (hm : m = 3) (hx0 : x ≠ 0) : N.k = 1 := by
  have h1 : 0 < N.k := by
    by_contra h
    apply hx0
    rw [N.eq]
    exact Finset.sum_eq_zero fun l _ => absurd l.2 (by omega)
  have h2 := (V_li N).fintype_card_le_finrank
  simp only [Fintype.card_sum, Fintype.card_fin, Module.finrank_fin_fun] at h2
  omega

/-- In `ℝ³` with one plane, `ker x` is a line: two kernel vectors are proportional. -/
theorem K_line (hm : m = 3) (hk : N.k = 1) {z z' : Fin m → ℝ} (hz : InK N z) (hz' : InK N z') (hz0 : z ≠ 0) :
    z' = ((z ⬝ᵥ z') / (z ⬝ᵥ z)) • z := by
  set j : Fin N.k := ⟨0, by omega⟩
  have hzz : z ⬝ᵥ z ≠ 0 := fun h => hz0 (dotProduct_self_eq_zero.mp h)
  set d := z' - ((z ⬝ᵥ z') / (z ⬝ᵥ z)) • z with hd
  have hdz : z ⬝ᵥ d = 0 := by
    rw [hd, dotProduct_sub, dotProduct_smul, smul_eq_mul]; field_simp; ring
  have hdu : N.u j ⬝ᵥ d = 0 := by rw [hd, dotProduct_sub, dotProduct_smul, (hz' j).1, (hz j).1]; simp
  have hdw : N.w j ⬝ᵥ d = 0 := by rw [hd, dotProduct_sub, dotProduct_smul, (hz' j).2, (hz j).2]; simp
  by_contra hne
  have hd0 : d ≠ 0 := fun h => hne (by rw [hd] at h; exact sub_eq_zero.mp h)
  have huw := N.uw j j
  have hwu : N.w j ⬝ᵥ N.u j = 0 := by rw [dotProduct_comm]; exact huw
  have e1 := (hz j).1
  have e2 := (hz j).2
  have e3 : z ⬝ᵥ N.u j = 0 := by rw [dotProduct_comm]; exact e1
  have e4 : z ⬝ᵥ N.w j = 0 := by rw [dotProduct_comm]; exact e2
  have e5 : d ⬝ᵥ N.u j = 0 := by rw [dotProduct_comm]; exact hdu
  have e6 : d ⬝ᵥ N.w j = 0 := by rw [dotProduct_comm]; exact hdw
  have e7 : d ⬝ᵥ z = 0 := by rw [dotProduct_comm]; exact hdz
  have := orth_card ![N.u j, N.w j, z, d]
    (fun i => by fin_cases i <;> simp [u_ne, w_ne, hz0, hd0])
    (fun i l hil => by
      fin_cases i <;> fin_cases l <;> first | exact absurd rfl hil | assumption)
  omega

/-- **At `m = 3`, `𝔠 = 0`** for every nonzero skew `x`: the centraliser of a rotation of `ℝ³` inside
`𝔰𝔬(3)` is the line through it, and `𝔠` is its orthogonal complement there. -/
theorem cc_three (hx : Skew x) (hm : m = 3) (hx0 : x ≠ 0) {c : Matrix (Fin m) (Fin m) ℝ} (hc : c ∈ cc x) :
    c = 0 := by
  obtain ⟨hcs, hci, hcb⟩ := hc
  obtain ⟨N⟩ := nf_exists hx
  have hk := k_eq_one N hm hx0
  have hsub : ∀ i j : Fin N.k, i = j := fun i j => by
    have : Subsingleton (Fin N.k) := by rw [hk]; infer_instance
    exact Subsingleton.elim _ _
  have hT : br c (T N N.a) = 0 := by
    rw [← x_eq_T N]; unfold br at hcb ⊢; rw [← neg_eq_zero, neg_sub, hcb]
  have huw : ∀ j, co c (N.u j) (N.w j) = 0 := by
    intro j
    have h := inner2_T N hcs N.a
    rw [← x_eq_T N, inner2_comm', hci, eq_comm, neg_eq_zero,
      Finset.sum_eq_single j (fun l _ hl => absurd (hsub l j) hl) (by simp)] at h
    exact (mul_eq_zero.mp h).resolve_left (N.apos j).ne'
  have hVK : ∀ j z, InK N z → co c (N.u j) z = 0 ∧ co c (N.w j) z = 0 := by
    intro j z hz
    obtain ⟨h1, h2⟩ := torus_K N hT j hz
    exact ⟨(mul_eq_zero.mp h2).resolve_left (N.apos j).ne', (mul_eq_zero.mp h1).resolve_left (N.apos j).ne'⟩
  apply recon N c
  · intro j l
    rw [hsub l j]
    refine ⟨co_self hcs _, huw j, by rw [co_skew hcs, huw j, neg_zero], co_self hcs _⟩
  · exact hVK
  · intro j z hz
    exact ⟨by rw [co_skew hcs, (hVK j z hz).1, neg_zero], by rw [co_skew hcs, (hVK j z hz).2, neg_zero]⟩
  · intro z z' hz hz'
    by_cases hz0 : z = 0
    · subst hz0; exact co_zero_l c z'
    rw [K_line N hm hk hz hz' hz0, co_smul_r, co_self hcs, mul_zero]

end Three

/-- **L160 at `m = 3`**: for every nonzero skew `x`, `𝔷(𝔠) ∩ 𝔠^⊥` carries an element moving `ker x`, so the
mixed summand contributes. -/
theorem L160_three (hx : Skew x) (hm : m = 3) (hx0 : x ≠ 0) :
    ∃ y ∈ zPerp x, ∃ z : Fin m → ℝ, x *ᵥ z = 0 ∧ y *ᵥ z ≠ 0 := by
  obtain ⟨N⟩ := nf_exists hx
  have hk := k_eq_one N hm hx0
  set j : Fin N.k := ⟨0, by omega⟩
  obtain ⟨z, hz0, hz⟩ := exists_perp ![N.u j, N.w j] (by omega)
  have hzK : InK N z := fun i => by
    have : i = j := by
      have : Subsingleton (Fin N.k) := by rw [hk]; infer_instance
      exact Subsingleton.elim _ _
    subst this; exact ⟨hz 0, hz 1⟩
  have hc : ∀ c ∈ cc x, c = 0 := fun c hc => cc_three hx hm hx0 hc
  refine ⟨rot (N.u j) z, ⟨rot_skew _ _, fun c hc' => ?_, fun c hc' => ?_⟩, z, ?_, ?_⟩
  · rw [hc c hc']; unfold br; simp
  · rw [hc c hc']; unfold inner2; simp
  · rw [x_eq_T N]; exact T_K N N.a hzK
  · rw [rot_mulVec, (hzK j).1, zero_smul, zero_sub, neg_ne_zero]
    exact smul_ne_zero (fun h => hz0 (dotProduct_self_eq_zero.mp h)) (u_ne N j)

/-- **L160.** The mixed summand `Hom(ker x, im x)` contributes nothing to `𝔷(𝔠) ∩ 𝔠^⊥` at every skew `x` **if
and only if `m ≠ 3`**. The statement asks that `y` kill `ker x` outright, which also removes the kernel-kernel
part. That part dies at every `m` by `kernel_kernel`, so the stronger form and the block's are equivalent. -/
theorem L160 : m ≠ 3 ↔ ∀ x : Matrix (Fin m) (Fin m) ℝ, Skew x → ∀ y ∈ zPerp x, ∀ z, x *ᵥ z = 0 → y *ᵥ z = 0 := by
  refine ⟨fun hm x hx y hy z hz => L160_support hx hm hy hz, fun h hm => ?_⟩
  subst hm
  set x : Matrix (Fin 3) (Fin 3) ℝ := rot (Pi.single 0 1) (Pi.single 1 1)
  have hx0 : x ≠ 0 := by
    intro h0
    have := congrArg (fun M => M 1 0) h0
    simp [x, rot, vecMulVec] at this
  obtain ⟨y, hy, z, hz, hyz⟩ := L160_three (rot_skew _ _) rfl hx0
  exact hyz (h x (rot_skew _ _) y hy z hz)

end HamiltonsCubic.MixedSummand
