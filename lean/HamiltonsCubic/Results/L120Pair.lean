import HamiltonsCubic.Results.L127DimOp
import HamiltonsCubic.Results.WeylTraceSchur
import HamiltonsCubic.Results.L120Block
import HamiltonsCubic.Results.L122Weyl

set_option linter.style.longLine false

/-!
# L120's pair summand: the `{j, k}` sign-isotypic Weyl operators are the pair span on its Ricci cut

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: *"`𝒲ₙ = 𝒟ₙ ⊕ ⨁ V_{ijkl} ⊕ ⨁ V_{jk}`, …
the character `ε_j ε_k` on the `n − 2` elements `e_{ij} ⊙ e_{ik}` … one Ricci relation cuts each pair block from
`n − 2` to `n − 3`, first Bianchi being empty there."* This file proves the pair summand's identification. A Weyl
operator `R` (in `weylModuleS`) that transforms under every coordinate flip by the character of `{j, k}`,
`act (flip m) R = (sgn m j · sgn m k) • R`, is:

* **`iso_coord_form`**: supported on the coordinates `R_{jy ky}` up to the index symmetries, `y ∉ {j, k}`, by a parity
  count over the flips;
* **`pairS_mem`**, **`coord_pairS`**, **`pairS_iso`**: conversely the pair-span operator `pairLin j k c` on the Ricci
  cut (precomposed with the skew projection) is in `𝒲ₙ` and is `{j, k}`-isotypic;
* **`pair_isotypic`**: `R` is the pair-span operator `∑_{y ∉ {j,k}} c_y f_y`, `f_y = φ_{jy} ⊙ φ_{ky}`, with
  `c_y = R_{jy ky}` and `∑ c_y = 0`, the Ricci relation;
* **`pair_isotypic_signMat`**: the same from L120's hypothesis, isotypy under the whole sign group `diag(ε)`.

*Criticality and the Fox product play no part*: this is the decomposition of `𝒲ₙ` itself, on `Fin n`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The flip parity a nonzero coordinate of a `{j, k}`-isotypic operator obeys: every index occurs in `(a, b, c, d)`
with the parity it has in `(j, k)`. -/
theorem iso_parity (R : CurvLin ι) {j k : ι} (hiso : ∀ m, act (flip m) R = (sgn m j * sgn m k) • R)
    {a b c d : ι} (hne : coord R a b c d ≠ 0) (m : ι) :
    sgn m a * sgn m b * sgn m c * sgn m d = sgn m j * sgn m k := by
  have h := coord_flip m R a b c d
  rw [hiso m, coord_smul] at h
  exact (mul_right_cancel₀ hne h).symm

/-- The eight positions a `{j, k}`-isotypic coordinate may occupy: `{a, b}` and `{c, d}` are `{j, y}` and `{k, y}` in
some order and orientation, `y ∉ {j, k}`. -/
def PairForm (j k a b c d : ι) : Prop :=
  ∃ y, y ≠ j ∧ y ≠ k ∧
    (((a = j ∧ b = y) ∨ (a = y ∧ b = j)) ∧ ((c = k ∧ d = y) ∨ (c = y ∧ d = k))
      ∨ ((a = k ∧ b = y) ∨ (a = y ∧ b = k)) ∧ ((c = j ∧ d = y) ∨ (c = y ∧ d = j)))

theorem sgn_self' (m : ι) : sgn m m = -1 := if_pos rfl

theorem sgn_ne' {m x : ι} (h : x ≠ m) : sgn m x = 1 := if_neg h

/-- **The core case `a = j`**: a nonzero `{j, k}`-isotypic coordinate `R_{j b c d}` has `b ∉ {j, k}` and
`(c, d) = (k, b)` or `(b, k)`. -/
theorem iso_core (R : CurvLin ι) {j k : ι} (hjk : j ≠ k)
    (hiso : ∀ m, act (flip m) R = (sgn m j * sgn m k) • R) {b c d : ι} (hne : coord R j b c d ≠ 0) :
    b ≠ j ∧ b ≠ k ∧ ((c = k ∧ d = b) ∨ (c = b ∧ d = k)) := by
  have hbj : b ≠ j := fun h => hne (by rw [h]; exact cd_self12 R j c d)
  have hcd : c ≠ d := fun h => hne (by rw [h]; exact cd_self34 R j b d)
  have hkj : k ≠ j := Ne.symm hjk
  have P := iso_parity R hiso hne
  -- at `m = j`: neither `c` nor `d` is `j`
  have Pj := P j
  rw [sgn_self', sgn_ne' hbj, sgn_ne' hkj] at Pj
  have hcj : c ≠ j := by
    intro hc; subst hc
    rw [sgn_self', sgn_ne' (Ne.symm hcd)] at Pj; norm_num at Pj
  have hdj : d ≠ j := by
    intro hd; subst hd
    rw [sgn_self', sgn_ne' hcd] at Pj; norm_num at Pj
  have Pk := P k
  rw [sgn_ne' hjk, sgn_self'] at Pk
  by_cases hbk : b = k
  · -- then `c, d ∉ {j, k}` and the flip at `c` fails
    exfalso
    subst hbk
    rw [sgn_self'] at Pk
    have hck : c ≠ b := by
      intro hc; subst hc; rw [sgn_self', sgn_ne' (Ne.symm hcd)] at Pk; norm_num at Pk
    have hdk : d ≠ b := by
      intro hd; subst hd; rw [sgn_self', sgn_ne' hcd] at Pk; norm_num at Pk
    have Pc := P c
    rw [sgn_ne' (Ne.symm hcj), sgn_ne' (Ne.symm hck), sgn_self', sgn_ne' (Ne.symm hcd)] at Pc
    norm_num at Pc
  · rw [sgn_ne' hbk] at Pk
    refine ⟨hbj, hbk, ?_⟩
    by_cases hck : c = k
    · subst hck
      rw [sgn_self', sgn_ne' (Ne.symm hcd)] at Pk
      -- the flip at `d` forces `d = b`
      have hdk : d ≠ c := Ne.symm hcd
      have Pd := P d
      rw [sgn_ne' (Ne.symm hdj), sgn_ne' (Ne.symm hdk), sgn_self'] at Pd
      by_cases hdb : d = b
      · exact Or.inl ⟨rfl, hdb⟩
      · rw [sgn_ne' (Ne.symm hdb)] at Pd; norm_num at Pd
    · rw [sgn_ne' hck] at Pk
      have hdk : d = k := by
        by_contra hdk; rw [sgn_ne' hdk] at Pk; norm_num at Pk
      subst hdk
      have Pc := P c
      rw [sgn_ne' (Ne.symm hcj), sgn_self', sgn_ne' (Ne.symm hcd)] at Pc
      by_cases hcb : c = b
      · exact Or.inr ⟨hcb, rfl⟩
      · rw [sgn_ne' (Ne.symm hcb)] at Pc; norm_num at Pc

/-- **A nonzero coordinate of a `{j, k}`-isotypic Weyl operator sits in a `PairForm` position.** -/
theorem iso_coord_form (R : CurvLin ι) (hR : R ∈ weylModuleS ι) {j k : ι} (hjk : j ≠ k)
    (hiso : ∀ m, act (flip m) R = (sgn m j * sgn m k) • R) {a b c d : ι} (hne : coord R a b c d ≠ 0) :
    PairForm j k a b c d := by
  have hkj : k ≠ j := Ne.symm hjk
  -- `j` occurs among the four indices
  have hocc : a = j ∨ b = j ∨ c = j ∨ d = j := by
    by_contra h; push Not at h
    have Pj := iso_parity R hiso hne j
    rw [sgn_ne' h.1, sgn_ne' h.2.1, sgn_ne' h.2.2.1, sgn_ne' h.2.2.2, sgn_self', sgn_ne' hkj] at Pj
    norm_num at Pj
  rcases hocc with h | h | h | h
  · have hne' : coord R j b c d ≠ 0 := h ▸ hne
    obtain ⟨hbj, hbk, hcd⟩ := iso_core R hjk hiso hne'
    exact ⟨b, hbj, hbk, Or.inl ⟨Or.inl ⟨h, rfl⟩, hcd⟩⟩
  · have hne' : coord R j a c d ≠ 0 := by rw [← h, cd_sw12]; exact neg_ne_zero.mpr hne
    obtain ⟨haj, hak, hcd⟩ := iso_core R hjk hiso hne'
    exact ⟨a, haj, hak, Or.inl ⟨Or.inr ⟨rfl, h⟩, hcd⟩⟩
  · have hne' : coord R j d a b ≠ 0 := by rw [← h, cd_pair R hR]; exact hne
    obtain ⟨hdj, hdk, hab⟩ := iso_core R hjk hiso hne'
    exact ⟨d, hdj, hdk, Or.inr ⟨hab, Or.inl ⟨h, rfl⟩⟩⟩
  · have hne' : coord R j c a b ≠ 0 := by rw [← h, cd_sw12, cd_pair R hR]; exact neg_ne_zero.mpr hne
    obtain ⟨hcj, hck, hab⟩ := iso_core R hjk hiso hne'
    exact ⟨c, hcj, hck, Or.inr ⟨hab, Or.inr ⟨rfl, h⟩⟩⟩

/-- **A `PairForm` position carries the `{j, k}` character**: its flip sign is `sgn m j · sgn m k`. -/
theorem pairForm_parity {j k a b c d : ι} (h : PairForm j k a b c d) (m : ι) :
    sgn m a * sgn m b * sgn m c * sgn m d = sgn m j * sgn m k := by
  obtain ⟨y, _, _, h⟩ := h
  have hy := sgn_mul_self m y
  rcases h with ⟨hab, hcd⟩ | ⟨hab, hcd⟩ <;>
    rcases hab with ⟨ha, hb⟩ | ⟨ha, hb⟩ <;> rcases hcd with ⟨hc, hd⟩ | ⟨hc, hd⟩ <;> rw [ha, hb, hc, hd] <;>
    linear_combination (sgn m j * sgn m k) * hy

/-- **A Weyl operator vanishing at every `R_{jy ky}` vanishes at every `PairForm` position**, by the index symmetries. -/
theorem pairForm_coord_zero (D : CurvLin ι) (hD : D ∈ weylModuleS ι) {j k a b c d : ι} (h : PairForm j k a b c d)
    (h0 : ∀ y, coord D j y k y = 0) : coord D a b c d = 0 := by
  obtain ⟨y, _, _, h⟩ := h
  have h1 := h0 y
  have key : ∀ a b p q : ι, ((a = j ∧ b = y) ∨ (a = y ∧ b = j)) → ((p = k ∧ q = y) ∨ (p = y ∧ q = k)) →
      coord D a b p q = 0 := by
    rintro a b p q (⟨ha, hb⟩ | ⟨ha, hb⟩) (⟨hp, hq⟩ | ⟨hp, hq⟩) <;> rw [ha, hb, hp, hq]
    · exact h1
    · rw [cd_sw34]; simp [h1]
    · rw [cd_sw12]; simp [h1]
    · rw [cd_sw12, cd_sw34]; simp [h1]
  rcases h with ⟨hab, hcd⟩ | ⟨hab, hcd⟩
  · exact key a b c d hab hcd
  · rw [cd_pair D hD]; exact key c d a b hcd hab

/-- A nonzero pairing of two `φ`'s names the same unordered pair. -/
theorem phi_ip_ne {p q a b : ι} (h : inner2 (phi p q) (phi a b) ≠ 0) : (a = p ∧ b = q) ∨ (a = q ∧ b = p) := by
  rw [inner2_phi_phi] at h
  by_contra hc; push Not at hc
  apply h
  rw [if_neg (fun e => hc.1 e.1.symm e.2.symm), if_neg (fun e => hc.2 e.2.symm e.1.symm)]; ring

variable {n : ℕ}

/-- **The pair-span operator** `Y ↦ ∑_{y ∉ {j,k}} c_y f_y(Y)`, as a linear map. -/
noncomputable def pairLin (j k : Fin n) (c : Fin n → ℝ) : CurvLin (Fin n) where
  toFun Y := ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) Y
  map_add' X Y := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    unfold rk2; rw [ip_add_r, ip_add_r]; module
  map_smul' r X := by
    simp only [RingHom.id_apply, Finset.smul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    unfold rk2; rw [ip_smul_r, ip_smul_r]; module

/-- `pairLin` precomposed with the skew projection is in `𝒲ₙ` on the Ricci cut. -/
theorem pairS_mem {j k : Fin n} (hjk : j ≠ k) (c : Fin n → ℝ)
    (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0) :
    pairLin j k c ∘ₗ HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) ∈ weylModuleS (Fin n) :=
  HamiltonsCubic.WeylModuleSNonzero.comp_skewProj_mem _ (HamiltonsCubic.L126Assembly.pairSpan_isWeyl hjk _ (fun i hi => (Finset.mem_filter.mp hi).2) c hsum)

/-- **The coordinates of the pair-span operator.** -/
theorem coord_pairS (j k : Fin n) (c : Fin n → ℝ) (a b p q : Fin n) :
    coord (pairLin j k c ∘ₗ HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n)) a b p q
      = ∑ x ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c x * (inner2 (phi k x) (phi a b) * inner2 (phi j x) (phi p q)
          + inner2 (phi j x) (phi a b) * inner2 (phi k x) (phi p q)) := by
  unfold coord
  rw [LinearMap.comp_apply, HamiltonsCubic.WeylModuleSNonzero.skewProj_skew _ (phi_isSkew a b)]
  change inner2 (∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) (phi a b)) (phi p q) = _
  rw [ip_sum_l]
  refine Finset.sum_congr rfl fun x _ => ?_
  unfold rk2
  rw [ip_smul_l, ip_add_l, ip_smul_l, ip_smul_l]

/-- At `(j, y, k, y)`, `y ∉ {j, k}`, the pair-span operator's coordinate is `c_y`. -/
theorem coord_pairS_diag {j k : Fin n} (hjk : j ≠ k) (c : Fin n → ℝ) {y : Fin n} (hyj : y ≠ j) (hyk : y ≠ k) :
    coord (pairLin j k c ∘ₗ HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n)) j y k y = c y := by
  rw [coord_pairS]
  have hy : y ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i) := Finset.mem_filter.mpr ⟨Finset.mem_univ _, Ne.symm hyj, Ne.symm hyk⟩
  rw [Finset.sum_eq_single y]
  · simp only [inner2_phi_phi]
    simp [hjk, Ne.symm hjk, hyj, hyk, Ne.symm hyj, Ne.symm hyk]
  · intro x hx hxy
    obtain ⟨hjx, hkx⟩ := (Finset.mem_filter.mp hx).2
    simp only [inner2_phi_phi]
    simp [hjk, Ne.symm hjk, hxy, Ne.symm hjx, Ne.symm hkx]
  · intro h; exact absurd hy h

/-- **The pair-span operator is `{j, k}`-isotypic.** -/
theorem pairS_iso {j k : Fin n} (hjk : j ≠ k) (c : Fin n → ℝ)
    (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0) (m : Fin n) :
    act (flip m) (pairLin j k c ∘ₗ HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n)) = (sgn m j * sgn m k) • (pairLin j k c ∘ₗ HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n)) := by
  have hS := pairS_mem hjk c hsum
  refine eq_of_coord _ _ (act_mem _ (flip_orth m) _ hS) (Submodule.smul_mem _ _ hS) fun a b p q => ?_
  rw [coord_flip, coord_smul]
  by_cases h0 : coord (pairLin j k c ∘ₗ HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n)) a b p q = 0
  · rw [h0, mul_zero, mul_zero]
  · congr 1
    apply pairForm_parity
    rw [coord_pairS] at h0
    obtain ⟨x, hx, hne⟩ := Finset.exists_ne_zero_of_sum_ne_zero h0
    obtain ⟨hjx, hkx⟩ := (Finset.mem_filter.mp hx).2
    have hne' := right_ne_zero_of_mul hne
    by_cases hA : inner2 (phi k x) (phi a b) * inner2 (phi j x) (phi p q) = 0
    · rw [hA, zero_add] at hne'
      exact ⟨x, Ne.symm hjx, Ne.symm hkx, Or.inl ⟨phi_ip_ne (left_ne_zero_of_mul hne'),
        (phi_ip_ne (right_ne_zero_of_mul hne')).imp id id⟩⟩
    · exact ⟨x, Ne.symm hjx, Ne.symm hkx, Or.inr ⟨phi_ip_ne (left_ne_zero_of_mul hA),
        phi_ip_ne (right_ne_zero_of_mul hA)⟩⟩

/-- **L120's pair summand.** A Weyl operator transforming under every flip by the character of `{j, k}` has its
coordinates `c_y = R_{jy ky}` on the Ricci cut `∑_{y ∉ {j,k}} c_y = 0`, and equals the pair-span operator
`∑ c_y φ_{jy} ⊙ φ_{ky}` (precomposed with the skew projection, as every member of `weylModuleS` is). -/
theorem pair_isotypic (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) {j k : Fin n} (hjk : j ≠ k)
    (hiso : ∀ m, act (flip m) R = (sgn m j * sgn m k) • R) :
    ∑ y ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), coord R j y k y = 0
      ∧ R = pairLin j k (fun y => coord R j y k y) ∘ₗ HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) := by
  set s := univ.filter (fun i : Fin n => j ≠ i ∧ k ≠ i) with hsdef
  -- the Ricci relation
  have hsum : ∑ y ∈ s, coord R j y k y = 0 := by
    have h := cd_ric R hR j k
    rw [← Finset.sum_filter_add_sum_filter_not univ (fun i => j ≠ i ∧ k ≠ i)] at h
    have e : (univ : Finset (Fin n)).filter (fun i => ¬ (j ≠ i ∧ k ≠ i)) = {j, k} := by
      ext i; simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_insert, Finset.mem_singleton]
      constructor
      · intro hi; by_contra hc; push Not at hc; exact hi ⟨Ne.symm hc.1, Ne.symm hc.2⟩
      · rintro (rfl | rfl) ⟨h1, h2⟩ <;> simp_all
    rw [e, Finset.sum_pair hjk, cd_self12, cd_self34, add_zero, add_zero] at h
    exact h
  refine ⟨hsum, ?_⟩
  set S := pairLin j k (fun y => coord R j y k y) ∘ₗ HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n)
  have hS := pairS_mem hjk (fun y => coord R j y k y) hsum
  have hD : R - S ∈ weylModuleS (Fin n) := sub_mem hR hS
  have hDiso : ∀ m, act (flip m) (R - S) = (sgn m j * sgn m k) • (R - S) := fun m => by
    rw [act_sub', hiso m, pairS_iso hjk _ hsum m, smul_sub]
  have h0 : ∀ y, coord (R - S) j y k y = 0 := fun y => by
    by_cases hyj : y = j
    · rw [hyj]; exact cd_self12 _ j k j
    by_cases hyk : y = k
    · rw [hyk]; exact cd_self34 _ j k k
    rw [coord_sub, coord_pairS_diag hjk _ hyj hyk, sub_self]
  have hzero : R - S = 0 := cd_ext _ hD fun a b p q => by
    by_contra hne
    exact hne (pairForm_coord_zero _ hD (iso_coord_form _ hD hjk hDiso hne) h0)
  exact sub_eq_zero.mp hzero

/-- **The same, from L120's own hypothesis**: isotypy under the whole diagonal sign group `diag(ε)`, `ε_i = ±1`,
with the character `ε_j ε_k`, restricts to every flip. -/
theorem pair_isotypic_signMat (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) {j k : Fin n} (hjk : j ≠ k)
    (hiso : ∀ ε : Fin n → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) R = (ε j * ε k) • R) :
    ∑ y ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), coord R j y k y = 0
      ∧ R = pairLin j k (fun y => coord R j y k y) ∘ₗ HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) :=
  pair_isotypic R hR hjk fun m => hiso (sgn m) (sgn_mul_self m)

end HamiltonsCubic.Results
