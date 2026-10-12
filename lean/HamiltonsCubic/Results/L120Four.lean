import HamiltonsCubic.Results.L120PairSign
import HamiltonsCubic.Results.L126GenBridge

set_option linter.style.longLine false

/-!
# L120's four-set summand: the `{i, j, k, l}` sign-isotypic Weyl operators are the four-set span on its Bianchi cut

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: *"a four-index character on the three
pairings of a `4`-subset … first Bianchi cuts each `4`-set block from `3` to `2` by the single relation among the three
pairings, Ricci-flatness being empty there."* A Weyl operator `R` (in `weylModuleS`) that transforms under every flip by
`sgn m i · sgn m j · sgn m k · sgn m l`, at distinct `i, j, k, l`, is:

* **`four_coord_form`**: supported on the coordinates at the three pairings `ij|kl`, `ik|jl`, `il|jk`, in either order
  and orientation, by a parity count over the flips;
* **`four_isotypic`**: the four-set span operator `x a + y b + z c` of [L126GenBridge.lean](L126GenBridge.lean)'s
  `spanVec`, `a = φ_{ij} ⊙ φ_{kl}`, `b = φ_{ki} ⊙ φ_{jl}`, `c = φ_{il} ⊙ φ_{jk}`, with `x = R_{ijkl}`, `y = −R_{ikjl}`,
  `z = R_{iljk}` and `x + y + z = 0`, the first Bianchi relation;
* **`fourS_mem`**, **`fourS_iso`**, **`fourS_iso_signMat`**: conversely the four-set span operator on the Bianchi cut is
  in `𝒲ₙ` and is isotypic, under the flips and under the whole sign group `Γ`;
* **`fourSummand_mem`**, **`fourSummand_finrank`**: the range of `fourMap`, the Bianchi cut parametrised by `(x, y)`, is
  exactly the `Γ`-isotypic members of `weylModuleS` with character `ε_i ε_j ε_k ε_l`, and has dimension `2`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `(a, b, c, d)` places the pair `{p, q}` first and `{r, s}` second, in either orientation. -/
def PP (p q r s a b c d : ι) : Prop := ((a = p ∧ b = q) ∨ (a = q ∧ b = p)) ∧ ((c = r ∧ d = s) ∨ (c = s ∧ d = r))

/-- The twenty-four positions a `{i, j, k, l}`-isotypic coordinate may occupy: a pairing of the four indices, either pair
first, either orientation. -/
def FourForm (i j k l a b c d : ι) : Prop :=
  PP i j k l a b c d ∨ PP k l i j a b c d ∨ PP i k j l a b c d ∨ PP j l i k a b c d ∨ PP i l j k a b c d
    ∨ PP j k i l a b c d

/-- The flip parity a nonzero coordinate of a four-set-isotypic operator obeys. -/
theorem four_parity (R : CurvLin ι) {i j k l : ι}
    (hiso : ∀ m, act (flip m) R = (sgn m i * sgn m j * sgn m k * sgn m l) • R)
    {a b c d : ι} (hne : coord R a b c d ≠ 0) (m : ι) :
    sgn m a * sgn m b * sgn m c * sgn m d = sgn m i * sgn m j * sgn m k * sgn m l := by
  have h := coord_flip m R a b c d
  rw [hiso m, coord_smul] at h
  exact (mul_right_cancel₀ hne h).symm

/-- Each of the four indices occurs among `a, b, c, d`. -/
theorem four_occurs (R : CurvLin ι) {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l)
    (hiso : ∀ m, act (flip m) R = (sgn m i * sgn m j * sgn m k * sgn m l) • R)
    {a b c d : ι} (hne : coord R a b c d ≠ 0) : i = a ∨ i = b ∨ i = c ∨ i = d := by
  by_contra h; push Not at h
  have P := four_parity R hiso hne i
  rw [sgn_ne' (Ne.symm h.1), sgn_ne' (Ne.symm h.2.1), sgn_ne' (Ne.symm h.2.2.1), sgn_ne' (Ne.symm h.2.2.2), sgn_self',
    sgn_ne' (Ne.symm hij), sgn_ne' (Ne.symm hik), sgn_ne' (Ne.symm hil)] at P
  norm_num at P

/-- **A nonzero coordinate of a four-set-isotypic operator sits in a `FourForm` position.** -/
theorem four_coord_form (R : CurvLin ι) {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k)
    (hjl : j ≠ l) (hkl : k ≠ l)
    (hiso : ∀ m, act (flip m) R = (sgn m i * sgn m j * sgn m k * sgn m l) • R)
    {a b c d : ι} (hne : coord R a b c d ≠ 0) : FourForm i j k l a b c d := by
  have hab : a ≠ b := fun h => hne (by rw [h]; exact cd_self12 R b c d)
  have hcd : c ≠ d := fun h => hne (by rw [h]; exact cd_self34 R a b d)
  have hiso' : ∀ m, act (flip m) R = (sgn m j * sgn m i * sgn m k * sgn m l) • R := fun m => by
    rw [hiso m]; ring_nf
  have hiso'' : ∀ m, act (flip m) R = (sgn m k * sgn m i * sgn m j * sgn m l) • R := fun m => by
    rw [hiso m]; ring_nf
  have hiso''' : ∀ m, act (flip m) R = (sgn m l * sgn m i * sgn m j * sgn m k) • R := fun m => by
    rw [hiso m]; ring_nf
  have oi := four_occurs R hij hik hil hiso hne
  have oj := four_occurs R (Ne.symm hij) hjk hjl hiso' hne
  have ok := four_occurs R (Ne.symm hik) (Ne.symm hjk) hkl hiso'' hne
  have ol := four_occurs R (Ne.symm hil) (Ne.symm hjl) (Ne.symm hkl) hiso''' hne
  unfold FourForm PP
  rcases oi with rfl | rfl | rfl | rfl <;> rcases oj with rfl | rfl | rfl | rfl <;>
    rcases ok with rfl | rfl | rfl | rfl <;> rcases ol with rfl | rfl | rfl | rfl <;>
    first
    | contradiction
    | simp only [true_and, and_true, true_or, or_true, and_self]

omit [Fintype ι] in
/-- **A `FourForm` position carries the four-set character.** -/
theorem fourForm_parity {i j k l a b c d : ι} (h : FourForm i j k l a b c d) (m : ι) :
    sgn m a * sgn m b * sgn m c * sgn m d = sgn m i * sgn m j * sgn m k * sgn m l := by
  unfold FourForm PP at h
  rcases h with ⟨hab, hcd⟩ | ⟨hab, hcd⟩ | ⟨hab, hcd⟩ | ⟨hab, hcd⟩ | ⟨hab, hcd⟩ | ⟨hab, hcd⟩ <;>
    rcases hab with ⟨ha, hb⟩ | ⟨ha, hb⟩ <;> rcases hcd with ⟨hc, hd⟩ | ⟨hc, hd⟩ <;> rw [ha, hb, hc, hd] <;> ring

/-- A Weyl operator vanishing at `(p, q, r, s)` vanishes at every position placing `{p, q}` and `{r, s}`, in either
order and orientation. -/
theorem pp_coord_zero (D : CurvLin ι) (hD : D ∈ weylModuleS ι) {p q r s : ι} (h0 : coord D p q r s = 0) {a b c d : ι}
    (h : PP p q r s a b c d ∨ PP r s p q a b c d) : coord D a b c d = 0 := by
  have key : ∀ a b c d : ι, PP p q r s a b c d → coord D a b c d = 0 := by
    rintro a b c d ⟨(⟨ha, hb⟩ | ⟨ha, hb⟩), (⟨hc, hd⟩ | ⟨hc, hd⟩)⟩ <;> rw [ha, hb, hc, hd]
    · exact h0
    · rw [cd_sw34]; simp [h0]
    · rw [cd_sw12]; simp [h0]
    · rw [cd_sw12, cd_sw34]; simp [h0]
  rcases h with h | h
  · exact key a b c d h
  · rw [cd_pair D hD]; exact key c d a b ⟨h.2, h.1⟩

/-- **A Weyl operator vanishing at the three pairing coordinates `R_{ijkl}`, `R_{ikjl}`, `R_{iljk}` vanishes at every
`FourForm` position.** -/
theorem fourForm_coord_zero (D : CurvLin ι) (hD : D ∈ weylModuleS ι) {i j k l : ι} (hA : coord D i j k l = 0)
    (hB : coord D i k j l = 0) (hC : coord D i l j k = 0) {a b c d : ι} (h : FourForm i j k l a b c d) :
    coord D a b c d = 0 := by
  rcases h with h | h | h | h | h | h
  · exact pp_coord_zero D hD hA (Or.inl h)
  · exact pp_coord_zero D hD hA (Or.inr h)
  · exact pp_coord_zero D hD hB (Or.inl h)
  · exact pp_coord_zero D hD hB (Or.inr h)
  · exact pp_coord_zero D hD hC (Or.inl h)
  · exact pp_coord_zero D hD hC (Or.inr h)

variable {n : ℕ}

/-- **The four-set span operator** `x a + y b + z c`, as a linear map. -/
noncomputable def fourLin (i j k l : Fin n) (x y z : ℝ) : CurvLin (Fin n) where
  toFun Y := HamiltonsCubic.L126Assembly.spanVec i j k l x y z Y
  map_add' X Y := (HamiltonsCubic.L126Assembly.spanVec_lin i j k l x y z).1 X Y
  map_smul' r X := (HamiltonsCubic.L126Assembly.spanVec_lin i j k l x y z).2 r X

/-- The four-set span operator, precomposed with the skew projection. -/
noncomputable abbrev fourS (i j k l : Fin n) (x y z : ℝ) : CurvLin (Fin n) :=
  fourLin i j k l x y z ∘ₗ HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n)

/-- The four-set span operator on the Bianchi cut is in `𝒲ₙ`. -/
theorem fourS_mem {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) {x y z : ℝ} (hs : x + y + z = 0) : fourS i j k l x y z ∈ weylModuleS (Fin n) :=
  HamiltonsCubic.WeylModuleSNonzero.comp_skewProj_mem _
    (HamiltonsCubic.L126Assembly.spanVec_isWeyl hij hik hil hjk hjl hkl hs)

/-- **The coordinates of the four-set span operator.** -/
theorem coord_fourS (i j k l : Fin n) (x y z : ℝ) (a b p q : Fin n) :
    coord (fourS i j k l x y z) a b p q
      = x * (inner2 (phi k l) (phi a b) * inner2 (phi i j) (phi p q) + inner2 (phi i j) (phi a b) * inner2 (phi k l) (phi p q))
        + y * (inner2 (phi j l) (phi a b) * inner2 (phi k i) (phi p q) + inner2 (phi k i) (phi a b) * inner2 (phi j l) (phi p q))
        + z * (inner2 (phi j k) (phi a b) * inner2 (phi i l) (phi p q) + inner2 (phi i l) (phi a b) * inner2 (phi j k) (phi p q)) := by
  unfold coord
  rw [LinearMap.comp_apply, HamiltonsCubic.WeylModuleSNonzero.skewProj_skew _ (phi_isSkew a b)]
  change inner2 (HamiltonsCubic.L126Assembly.spanVec i j k l x y z (phi a b)) (phi p q) = _
  unfold HamiltonsCubic.L126Assembly.spanVec rk2
  simp only [ip_add_l, ip_smul_l]

/-- The three pairing coordinates of the four-set span operator are `x`, `−y`, `z`. -/
theorem coord_fourS_pairings {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) (x y z : ℝ) :
    coord (fourS i j k l x y z) i j k l = x ∧ coord (fourS i j k l x y z) i k j l = -y
      ∧ coord (fourS i j k l x y z) i l j k = z := by
  refine ⟨?_, ?_, ?_⟩ <;> rw [coord_fourS] <;> simp only [inner2_phi_phi] <;>
    simp [hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl]

/-- A nonzero coordinate of the four-set span operator sits in a `FourForm` position. -/
theorem fourS_form {i j k l : Fin n} (x y z : ℝ) {a b p q : Fin n} (h0 : coord (fourS i j k l x y z) a b p q ≠ 0) :
    FourForm i j k l a b p q := by
  rw [coord_fourS] at h0
  unfold FourForm PP
  have t : ∀ {u v u' v' : Fin n}, inner2 (phi u v) (phi a b) * inner2 (phi u' v') (phi p q) ≠ 0 →
      ((a = u ∧ b = v) ∨ (a = v ∧ b = u)) ∧ ((p = u' ∧ q = v') ∨ (p = v' ∧ q = u')) := fun h =>
    ⟨phi_ip_ne (left_ne_zero_of_mul h), phi_ip_ne (right_ne_zero_of_mul h)⟩
  by_contra hc
  apply h0
  have z1 : inner2 (phi k l) (phi a b) * inner2 (phi i j) (phi p q) = 0 := by
    by_contra h; exact hc (Or.inr (Or.inl (t h)))
  have z2 : inner2 (phi i j) (phi a b) * inner2 (phi k l) (phi p q) = 0 := by
    by_contra h; exact hc (Or.inl (t h))
  have z3 : inner2 (phi j l) (phi a b) * inner2 (phi k i) (phi p q) = 0 := by
    by_contra h
    obtain ⟨h1, h2⟩ := t h
    exact hc (Or.inr (Or.inr (Or.inr (Or.inl ⟨h1, h2.symm⟩))))
  have z4 : inner2 (phi k i) (phi a b) * inner2 (phi j l) (phi p q) = 0 := by
    by_contra h
    obtain ⟨h1, h2⟩ := t h
    exact hc (Or.inr (Or.inr (Or.inl ⟨h1.symm, h2⟩)))
  have z5 : inner2 (phi j k) (phi a b) * inner2 (phi i l) (phi p q) = 0 := by
    by_contra h; exact hc (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (t h))))))
  have z6 : inner2 (phi i l) (phi a b) * inner2 (phi j k) (phi p q) = 0 := by
    by_contra h; exact hc (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (t h))))))
  rw [z1, z2, z3, z4, z5, z6]; ring

/-- **The four-set span operator on the Bianchi cut is four-set isotypic.** -/
theorem fourS_iso {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) {x y z : ℝ} (hs : x + y + z = 0) (m : Fin n) :
    act (flip m) (fourS i j k l x y z) = (sgn m i * sgn m j * sgn m k * sgn m l) • fourS i j k l x y z := by
  have hS := fourS_mem hij hik hil hjk hjl hkl hs
  refine eq_of_coord _ _ (act_mem _ (flip_orth m) _ hS) (Submodule.smul_mem _ _ hS) fun a b p q => ?_
  rw [coord_flip, coord_smul]
  by_cases h0 : coord (fourS i j k l x y z) a b p q = 0
  · rw [h0, mul_zero, mul_zero]
  · rw [fourForm_parity (fourS_form x y z h0) m]

/-- **L120's four-set summand.** A Weyl operator transforming under every flip by the character of `{i, j, k, l}`, at
distinct indices, has `x = R_{ijkl}`, `y = −R_{ikjl}`, `z = R_{iljk}` on the Bianchi cut `x + y + z = 0`, and equals the
four-set span operator `x a + y b + z c` (precomposed with the skew projection). -/
theorem four_isotypic (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) {i j k l : Fin n} (hij : i ≠ j)
    (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
    (hiso : ∀ m, act (flip m) R = (sgn m i * sgn m j * sgn m k * sgn m l) • R) :
    coord R i j k l + -coord R i k j l + coord R i l j k = 0
      ∧ R = fourS i j k l (coord R i j k l) (-coord R i k j l) (coord R i l j k) := by
  have hs : coord R i j k l + -coord R i k j l + coord R i l j k = 0 := by
    have h := cd_bianchi R hR i j k l
    rw [cd_sw34 R i k l j] at h
    linarith
  refine ⟨hs, ?_⟩
  set S := fourS i j k l (coord R i j k l) (-coord R i k j l) (coord R i l j k)
  have hS := fourS_mem hij hik hil hjk hjl hkl hs
  have hD : R - S ∈ weylModuleS (Fin n) := sub_mem hR hS
  have hDiso : ∀ m, act (flip m) (R - S) = (sgn m i * sgn m j * sgn m k * sgn m l) • (R - S) := fun m => by
    rw [act_sub', hiso m, fourS_iso hij hik hil hjk hjl hkl hs m, smul_sub]
  obtain ⟨cA, cB, cC⟩ := coord_fourS_pairings hij hik hil hjk hjl hkl (coord R i j k l) (-coord R i k j l)
    (coord R i l j k)
  have hA : coord (R - S) i j k l = 0 := by rw [coord_sub, cA, sub_self]
  have hB : coord (R - S) i k j l = 0 := by rw [coord_sub, cB, neg_neg, sub_self]
  have hC : coord (R - S) i l j k = 0 := by rw [coord_sub, cC, sub_self]
  have hzero : R - S = 0 := cd_ext _ hD fun a b p q => by
    by_contra hne
    exact hne (fourForm_coord_zero _ hD hA hB hC (four_coord_form _ hij hik hil hjk hjl hkl hDiso hne))
  exact sub_eq_zero.mp hzero

omit [Fintype ι] [DecidableEq ι] in
/-- **A `FourForm` position carries `ε_i ε_j ε_k ε_l`** under any diagonal sign matrix. -/
theorem fourForm_parity_sign (ε : ι → ℝ) {i j k l a b c d : ι} (h : FourForm i j k l a b c d) :
    ε a * ε b * ε c * ε d = ε i * ε j * ε k * ε l := by
  unfold FourForm PP at h
  rcases h with ⟨hab, hcd⟩ | ⟨hab, hcd⟩ | ⟨hab, hcd⟩ | ⟨hab, hcd⟩ | ⟨hab, hcd⟩ | ⟨hab, hcd⟩ <;>
    rcases hab with ⟨ha, hb⟩ | ⟨ha, hb⟩ <;> rcases hcd with ⟨hc, hd⟩ | ⟨hc, hd⟩ <;> rw [ha, hb, hc, hd] <;> ring

/-- **The four-set span operator on the Bianchi cut is `Γ`-isotypic** with character `ε_i ε_j ε_k ε_l`. -/
theorem fourS_iso_signMat {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) {x y z : ℝ} (hs : x + y + z = 0) (ε : Fin n → ℝ) (hε : ∀ i, ε i * ε i = 1) :
    act (signMat ε) (fourS i j k l x y z) = (ε i * ε j * ε k * ε l) • fourS i j k l x y z := by
  have hS := fourS_mem hij hik hil hjk hjl hkl hs
  refine eq_of_coord _ _ (act_mem _ (signMat_orth ε hε).1 _ hS) (Submodule.smul_mem _ _ hS) fun a b p q => ?_
  rw [coord_sign, coord_smul]
  by_cases h0 : coord (fourS i j k l x y z) a b p q = 0
  · rw [h0, mul_zero, mul_zero]
  · rw [fourForm_parity_sign ε (fourS_form x y z h0)]

/-- **The four-set summand at L120's own hypothesis**, forward: `Γ`-isotypy restricts to the flips. -/
theorem four_isotypic_signMat (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) {i j k l : Fin n} (hij : i ≠ j)
    (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
    (hiso : ∀ ε : Fin n → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) R = (ε i * ε j * ε k * ε l) • R) :
    coord R i j k l + -coord R i k j l + coord R i l j k = 0
      ∧ R = fourS i j k l (coord R i j k l) (-coord R i k j l) (coord R i l j k) :=
  four_isotypic R hR hij hik hil hjk hjl hkl fun m => hiso (sgn m) (sgn_mul_self m)

/-- The four-set span operator on the Bianchi cut, parametrised by `(x, y)`, `z = −x − y`, linear in `(x, y)`. -/
noncomputable def fourMap (i j k l : Fin n) : (ℝ × ℝ) →ₗ[ℝ] CurvLin (Fin n) where
  toFun v := fourS i j k l v.1 v.2 (-v.1 - v.2)
  map_add' v w := by
    apply LinearMap.ext; intro Y
    simp only [LinearMap.add_apply, LinearMap.comp_apply, Prod.fst_add, Prod.snd_add]
    change HamiltonsCubic.L126Assembly.spanVec i j k l _ _ _ _ = HamiltonsCubic.L126Assembly.spanVec i j k l _ _ _ _
      + HamiltonsCubic.L126Assembly.spanVec i j k l _ _ _ _
    unfold HamiltonsCubic.L126Assembly.spanVec
    module
  map_smul' r v := by
    apply LinearMap.ext; intro Y
    simp only [LinearMap.smul_apply, LinearMap.comp_apply, Prod.smul_fst, Prod.smul_snd, smul_eq_mul,
      RingHom.id_apply]
    change HamiltonsCubic.L126Assembly.spanVec i j k l _ _ _ _ = r • HamiltonsCubic.L126Assembly.spanVec i j k l _ _ _ _
    unfold HamiltonsCubic.L126Assembly.spanVec
    module

/-- **The four-set summand, characterised**: the range of `fourMap` is exactly the Weyl operators transforming under
every diagonal sign matrix by `ε_i ε_j ε_k ε_l`. -/
theorem fourSummand_mem {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) (R : CurvLin (Fin n)) :
    R ∈ LinearMap.range (fourMap i j k l)
      ↔ R ∈ weylModuleS (Fin n)
        ∧ ∀ ε : Fin n → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) R = (ε i * ε j * ε k * ε l) • R := by
  constructor
  · rintro ⟨v, rfl⟩
    have hs : v.1 + v.2 + (-v.1 - v.2) = 0 := by ring
    exact ⟨fourS_mem hij hik hil hjk hjl hkl hs, fun ε hε => fourS_iso_signMat hij hik hil hjk hjl hkl hs ε hε⟩
  · rintro ⟨hR, hiso⟩
    obtain ⟨hs, hEq⟩ := four_isotypic_signMat R hR hij hik hil hjk hjl hkl hiso
    refine ⟨(coord R i j k l, -coord R i k j l), ?_⟩
    change fourS i j k l (coord R i j k l) (-coord R i k j l) (-(coord R i j k l) - -coord R i k j l) = R
    rw [show -(coord R i j k l) - -coord R i k j l = coord R i l j k by linarith]
    exact hEq.symm

/-- **The four-set summand has dimension `2`**: `fourMap` is injective, reading `x` and `−y` back as the coordinates
`R_{ijkl}` and `R_{ikjl}`. -/
theorem fourSummand_finrank {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) : Module.finrank ℝ (LinearMap.range (fourMap i j k l)) = 2 := by
  have hinj : Function.Injective (fourMap i j k l) := by
    intro v w h
    have e1 := congrArg (fun F : CurvLin (Fin n) => coord F i j k l) h
    have e2 := congrArg (fun F : CurvLin (Fin n) => coord F i k j l) h
    change coord (fourS i j k l _ _ _) i j k l = coord (fourS i j k l _ _ _) i j k l at e1
    change coord (fourS i j k l _ _ _) i k j l = coord (fourS i j k l _ _ _) i k j l at e2
    rw [(coord_fourS_pairings hij hik hil hjk hjl hkl _ _ _).1, (coord_fourS_pairings hij hik hil hjk hjl hkl _ _ _).1]
      at e1
    rw [(coord_fourS_pairings hij hik hil hjk hjl hkl _ _ _).2.1,
      (coord_fourS_pairings hij hik hil hjk hjl hkl _ _ _).2.1] at e2
    exact Prod.ext e1 (neg_inj.mp e2)
  rw [LinearMap.finrank_range_of_inj hinj, Module.finrank_prod, Module.finrank_self]

end HamiltonsCubic.Results
