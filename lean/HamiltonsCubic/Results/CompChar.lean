import Mathlib
import HamiltonsCubic.Results.L221a

set_option linter.style.longLine false

/-!
# Every character component of a Weyl operator is Weyl

[findings/second-order.md](../../../findings/second-order.md), Lemmas L220 and L221 write a point of $\mathcal S$ as $D+\sum_i\nu_i$ with
$D\in\mathcal D_n$ and $\nu_i\in V_{Q_i}$, both Weyl. [L221Crit.lean](L221Crit.lean)'s `SK` and [L221a.lean](L221a.lean)'s `SM` ask only
that the sum is Weyl. The components are the isotypic projections of L120's decomposition, so they are Weyl as well:

* `proj_add`, `proj_smul`, `proj_zero`, `proj_sum`: the isotypic projector is linear;
* `proj_of_char`: on an operator of character $\chi_u$, `proj t` is the identity at $t=u$ and zero otherwise;
* **`comp_eq_of_split`**: a Weyl $R=A_0+\sum_iA_i$, $A_0$ of character $1$ and $A_i$ of pairwise distinct nonempty characters
  $\chi_{t_i}$, has $A_0=$ `comp ∅ R` and $A_i=$ `comp t_i R`, so every component is Weyl (`split_weyl`);
* **`SK_components`**, **`SM_components`**: the Klein space of L221 (b) and the disjoint-block space of L221 (a) split into Weyl
  components.
-/

namespace HamiltonsCubic.CompChar

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L120Decomp HamiltonsCubic.L120HessPair HamiltonsCubic.L222Op
  HamiltonsCubic.BlockSub HamiltonsCubic.L221Ops HamiltonsCubic.L221Crit HamiltonsCubic.L221a

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}

theorem proj_add (t : Finset ι) (B C : CurvLin ι) : proj t (B + C) = proj t B + proj t C := by
  unfold proj
  simp only [act_add, smul_add, Finset.sum_add_distrib]

theorem proj_smul (t : Finset ι) (c : ℝ) (B : CurvLin ι) : proj t (c • B) = c • proj t B := by
  unfold proj
  have h : ∀ u : Finset ι, chi t u • act (diagSet u) (c • B) = c • (chi t u • act (diagSet u) B) := fun u => by
    rw [act_smul', smul_comm]
  simp only [h, ← Finset.smul_sum]
  rw [smul_comm]

theorem proj_zero (t : Finset ι) : proj t (0 : CurvLin ι) = 0 := by
  have := proj_smul t 0 (0 : CurvLin ι)
  rw [zero_smul, zero_smul] at this
  exact this

theorem proj_sum (t : Finset ι) (s : Finset (Fin m)) (f : Fin m → CurvLin ι) :
    proj t (∑ i ∈ s, f i) = ∑ i ∈ s, proj t (f i) := by
  induction s using Finset.induction_on with
  | empty => rw [Finset.sum_empty, Finset.sum_empty, proj_zero]
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, proj_add, ih]

/-- **`proj t` on an operator of character `χ_u`**: the identity at `t = u`, zero otherwise. -/
theorem proj_of_char {u : Finset ι} {B : CurvLin ι}
    (hB : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) B = setChar u ε • B) (t : Finset ι) :
    proj t B = if t = u then B else 0 := by
  have hne : ∀ s, s ≠ u → proj s B = 0 := by
    intro s hs
    obtain ⟨ε, hε, hp⟩ := setChar_sep hs
    have h1 := proj_signMat s B ε hε
    rw [← proj_act, hB ε hε, proj_smul] at h1
    have hsq : setChar s ε * setChar s ε = 1 := setChar_sq s ε hε
    have h2 : proj s B = (-1 : ℝ) • proj s B := by
      calc proj s B = (setChar s ε * setChar s ε) • proj s B := by rw [hsq, one_smul]
        _ = setChar s ε • (setChar u ε • proj s B) := by rw [h1, smul_smul]
        _ = (setChar s ε * setChar u ε) • proj s B := by rw [smul_smul]
        _ = (-1 : ℝ) • proj s B := by rw [hp]
    calc proj s B = (1 / 2 : ℝ) • (proj s B - (-1 : ℝ) • proj s B) := by module
      _ = 0 := by rw [← h2]; module
  by_cases htu : t = u
  · rw [if_pos htu, htu]
    have hs := sum_proj B
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ u),
      Finset.sum_eq_zero fun s hs => hne s (Finset.ne_of_mem_erase hs), add_zero] at hs
    exact hs
  · rw [if_neg htu]; exact hne t htu

theorem act_char {c : (ι → ℝ) → ℝ} {A : CurvOp2 ι} (h : SignChar c A) (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) :
    act (signMat ε) (extendL A) = c ε • extendL A :=
  act_extendL (h ε hε)

theorem extendL_add (A B : CurvOp2 ι) : extendL (A + B) = extendL A + extendL B :=
  LinearMap.ext fun Z => extend_add A B Z

theorem extendL_zero : extendL (0 : CurvOp2 ι) = 0 :=
  LinearMap.ext fun Z => extend_zero' Z

theorem extendL_sum (s : Finset (Fin m)) (f : Fin m → CurvOp2 ι) : extendL (∑ i ∈ s, f i) = ∑ i ∈ s, extendL (f i) := by
  induction s using Finset.induction_on with
  | empty => rw [Finset.sum_empty, Finset.sum_empty, extendL_zero]
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, extendL_add, ih]

theorem comp_eq {t : Finset ι} {R A : CurvOp2 ι} (hRW : IsWeyl2 R) (h : proj t (extendL R) = extendL A) :
    comp t R hRW = A := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  show proj t (extendL R) (X : Matrix ι ι ℝ) = _
  rw [h]
  exact extend_apply A X

/-- **The character components of a Weyl operator are its isotypic components.** -/
theorem comp_eq_of_split {t : Fin m → Finset ι} (hne : ∀ i, (t i).Nonempty) (hinj : ∀ i j, i ≠ j → t i ≠ t j)
    {R A₀ : CurvOp2 ι} {A : Fin m → CurvOp2 ι} (hRW : IsWeyl2 R) (h₀ : SignChar (fun _ => 1) A₀)
    (hA : ∀ i, SignChar (setChar (t i)) (A i)) (hR : R = A₀ + ∑ i, A i) :
    comp ∅ R hRW = A₀ ∧ ∀ i, comp (t i) R hRW = A i := by
  have h₀' : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) (extendL A₀) = setChar ∅ ε • extendL A₀ :=
    fun ε hε => by rw [act_char h₀ ε hε]; simp [setChar]
  have hA' := fun i => act_char (hA i)
  have hext : extendL R = extendL A₀ + ∑ i, extendL (A i) := by rw [hR, extendL_add, extendL_sum]
  have hne' : ∀ i, t i ≠ ∅ := fun i => Finset.nonempty_iff_ne_empty.mp (hne i)
  refine ⟨comp_eq hRW ?_, fun i => comp_eq hRW ?_⟩
  · rw [hext, proj_add, proj_sum, proj_of_char h₀' ∅, if_pos rfl,
      Finset.sum_eq_zero fun j _ => by rw [proj_of_char (hA' j) ∅, if_neg (Ne.symm (hne' j))], add_zero]
  · rw [hext, proj_add, proj_sum, proj_of_char h₀' (t i), if_neg (hne' i), zero_add,
      ← Finset.add_sum_erase _ _ (Finset.mem_univ i), proj_of_char (hA' i) (t i), if_pos rfl,
      Finset.sum_eq_zero fun j hj => by
        rw [proj_of_char (hA' j) (t i), if_neg (hinj i j (Ne.symm (Finset.ne_of_mem_erase hj)))], add_zero]

/-- **Every component of such a split is Weyl.** -/
theorem split_weyl {t : Fin m → Finset ι} (hne : ∀ i, (t i).Nonempty) (hinj : ∀ i j, i ≠ j → t i ≠ t j)
    {R A₀ : CurvOp2 ι} {A : Fin m → CurvOp2 ι} (hRW : IsWeyl2 R) (h₀ : SignChar (fun _ => 1) A₀)
    (hA : ∀ i, SignChar (setChar (t i)) (A i)) (hR : R = A₀ + ∑ i, A i) :
    IsWeyl2 A₀ ∧ ∀ i, IsWeyl2 (A i) := by
  obtain ⟨e₀, e⟩ := comp_eq_of_split hne hinj hRW h₀ hA hR
  exact ⟨e₀ ▸ comp_isWeyl2 _ _ _, fun i => e i ▸ comp_isWeyl2 _ _ _⟩

/-- **L221 (a)'s space splits into Weyl components.** -/
theorem SM_components {Q : Fin m → Finset ι} (hdis : ∀ i j, i ≠ j → Disjoint (Q i) (Q j)) (hne : ∀ i, (Q i).Nonempty)
    {R : CurvOp2 ι} (hR : R ∈ SM Q) :
    ∃ (D : CurvOp2 ι) (ν : Fin m → CurvOp2 ι), IsWeyl2 D ∧ (∀ i, IsWeyl2 (ν i)) ∧ SignChar (fun _ => 1) D ∧
      (∀ i, SignChar (setChar (Q i)) (ν i)) ∧ R = D + ∑ i, ν i := by
  obtain ⟨hRW, D, ν, hD, hν, hReq⟩ := hR
  have hinj : ∀ i j, i ≠ j → Q i ≠ Q j := fun i j hij h => by
    obtain ⟨p, hp⟩ := hne i
    exact Finset.disjoint_left.mp (hdis i j hij) hp (h ▸ hp)
  obtain ⟨hDW, hνW⟩ := split_weyl hne hinj hRW hD hν hReq
  exact ⟨D, ν, hDW, hνW, hD, hν, hReq⟩

/-- **L221 (b)'s space splits into Weyl components**, at non-nested `Q₁, Q₂`. -/
theorem SK_components {Q₁ Q₂ : Finset ι} {c e : ι} (hc₁ : c ∈ Q₁) (hc₂ : c ∉ Q₂) (he₂ : e ∈ Q₂) (he₁ : e ∉ Q₁)
    {R : CurvOp2 ι} (hR : R ∈ SK Q₁ Q₂) :
    ∃ D ν₁ ν₂ ν₃ : CurvOp2 ι, IsWeyl2 D ∧ IsWeyl2 ν₁ ∧ IsWeyl2 ν₂ ∧ IsWeyl2 ν₃ ∧ R = D + ν₁ + ν₂ + ν₃ := by
  obtain ⟨hRW, D, ν₁, ν₂, ν₃, hD, h₁, h₂, h₃, hReq⟩ := hR
  have hc₃ : c ∈ symmDiff Q₁ Q₂ := Finset.mem_symmDiff.mpr (Or.inl ⟨hc₁, hc₂⟩)
  have he₃ : e ∈ symmDiff Q₁ Q₂ := Finset.mem_symmDiff.mpr (Or.inr ⟨he₂, he₁⟩)
  set t : Fin 3 → Finset ι := ![Q₁, Q₂, symmDiff Q₁ Q₂] with htdef
  set A : Fin 3 → CurvOp2 ι := ![ν₁, ν₂, ν₃] with hAdef
  have hne : ∀ i, (t i).Nonempty := by
    intro i; fin_cases i
    · exact ⟨c, hc₁⟩
    · exact ⟨e, he₂⟩
    · exact ⟨c, hc₃⟩
  have n12 : Q₁ ≠ Q₂ := fun h => hc₂ (h ▸ hc₁)
  have n13 : Q₁ ≠ symmDiff Q₁ Q₂ := fun h => he₁ (h ▸ he₃)
  have n23 : Q₂ ≠ symmDiff Q₁ Q₂ := fun h => hc₂ (h ▸ hc₃)
  have hinj : ∀ i j, i ≠ j → t i ≠ t j := by
    intro i j hij
    fin_cases i <;> fin_cases j <;> first | exact absurd rfl hij | exact n12 | exact n13 | exact n23 | exact Ne.symm n12 | exact Ne.symm n13 | exact Ne.symm n23
  have hA : ∀ i, SignChar (setChar (t i)) (A i) := by
    intro i; fin_cases i
    · exact h₁
    · exact h₂
    · exact h₃
  have hsum : R = D + ∑ i, A i := by
    rw [hReq, Fin.sum_univ_three]
    simp only [hAdef, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two]
    abel
  obtain ⟨hDW, hAW⟩ := split_weyl hne hinj hRW hD hA hsum
  exact ⟨D, ν₁, ν₂, ν₃, hDW, hAW 0, hAW 1, hAW 2, hReq⟩

end HamiltonsCubic.CompChar
