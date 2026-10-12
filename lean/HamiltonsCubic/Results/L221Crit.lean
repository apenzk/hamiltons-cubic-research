import Mathlib
import HamiltonsCubic.Results.SubFermat

set_option linter.style.longLine false

/-!
# L221 (b), step 1 in full: the subalgebra of four characters, and criticality on it

[findings/second-order.md](../../../findings/second-order.md), Lemma L221 (b), step 1: *the characters trivial on
$\ker\chi_{Q_1}\cap\ker\chi_{Q_2}$ are $\{1,\chi_{Q_1},\chi_{Q_2},\chi_{Q_3}\}$, so $\mathcal S$ is a subalgebra and criticality splits into
$D\circ D+\sum_i\nu_i\circ\nu_i=\theta D$ and $2D\circ\nu_i+2\nu_j\circ\nu_k=\theta\nu_i$.* [L221Ops.lean](L221Ops.lean)'s `L221b_split`
proves the split from $Q(W)=\theta W$. Here the two remaining steps:

* `InK`, **`K_mul`**: $\mathcal S=\mathcal D_n\oplus V_{Q_1}\oplus V_{Q_2}\oplus V_{Q_3}$, $Q_3=Q_1\triangle Q_2$, is closed under $\circ$, since
  $\chi_{Q_i}\chi_{Q_j}=\chi_{Q_k}$ for $\{i,j,k\}=\{1,2,3\}$ and $\chi_{Q_i}^2=1$;
* `SK`, `SK_Qop2`: $\mathcal S\cap\mathcal W_n$ as a submodule closed under $Q$;
* **`L221b_step1`**: a local maximiser of $P$ on the unit sphere of $\mathcal S\cap\mathcal W_n$ at non-nested $Q_1,Q_2$ is critical in
  $\mathcal W_n$ with $\theta=P(W)$, and its components satisfy the four equations of step 1.
-/

namespace HamiltonsCubic.L221Crit

open HamiltonsCubic.RealLayer HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.L222Op
  HamiltonsCubic.BlockSub HamiltonsCubic.L221Ops HamiltonsCubic.SubFermat

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`𝒮 = 𝒟ₙ ⊕ V_{Q₁} ⊕ V_{Q₂} ⊕ V_{Q₃}`**, `Q₃ = Q₁ ∆ Q₂`, as a sum of four sign characters. -/
def InK (Q₁ Q₂ : Finset ι) (R : CurvOp2 ι) : Prop :=
  ∃ D ν₁ ν₂ ν₃ : CurvOp2 ι, SignChar (fun _ => 1) D ∧ SignChar (setChar Q₁) ν₁ ∧ SignChar (setChar Q₂) ν₂ ∧
    SignChar (setChar (symmDiff Q₁ Q₂)) ν₃ ∧ R = D + ν₁ + ν₂ + ν₃

/-- **`𝒮` is closed under `∘`.** -/
theorem K_mul {Q₁ Q₂ : Finset ι} {x y : CurvOp2 ι} (hx : InK Q₁ Q₂ x) (hy : InK Q₁ Q₂ y) :
    InK Q₁ Q₂ (foxProd2 x y) := by
  obtain ⟨D, a, b, c, hD, ha, hb, hc, rfl⟩ := hx
  obtain ⟨D', a', b', c', hD', ha', hb', hc', rfl⟩ := hy
  set Q₃ := symmDiff Q₁ Q₂ with hQ₃
  have c23 : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → setChar Q₂ ε * setChar Q₃ ε = setChar Q₁ ε := fun ε hε => by
    rw [setChar_symmDiff _ _ ε hε, hQ₃, symmDiff_comm Q₁ Q₂, symmDiff_symmDiff_cancel_left]
  have c13 : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → setChar Q₁ ε * setChar Q₃ ε = setChar Q₂ ε := fun ε hε => by
    rw [setChar_symmDiff _ _ ε hε, hQ₃, symmDiff_symmDiff_cancel_left]
  have c12 : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → setChar Q₁ ε * setChar Q₂ ε = setChar Q₃ ε := fun ε hε => by
    rw [setChar_symmDiff _ _ ε hε]
  have com : ∀ (f g h : (ι → ℝ) → ℝ), (∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → f ε * g ε = h ε) →
      ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → g ε * f ε = h ε := fun f g h hfg ε hε => by rw [mul_comm]; exact hfg ε hε
  have one : ∀ (f : (ι → ℝ) → ℝ), ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → (fun _ => (1 : ℝ)) ε * f ε = f ε :=
    fun f ε _ => one_mul _
  have one' : ∀ (f : (ι → ℝ) → ℝ), ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → f ε * (fun _ => (1 : ℝ)) ε = f ε :=
    fun f ε _ => mul_one _
  refine ⟨foxProd2 D D' + foxProd2 a a' + foxProd2 b b' + foxProd2 c c',
    foxProd2 D a' + foxProd2 a D' + foxProd2 b c' + foxProd2 c b',
    foxProd2 D b' + foxProd2 b D' + foxProd2 a c' + foxProd2 c a',
    foxProd2 D c' + foxProd2 c D' + foxProd2 a b' + foxProd2 b a', ?_, ?_, ?_, ?_, ?_⟩
  · refine signChar_add (signChar_add (signChar_add ?_ ?_) ?_) ?_
    · exact signChar_congr (foxProd2_char2 hD hD') fun _ _ => by ring
    · exact signChar_congr (foxProd2_char2 ha ha') fun ε hε => setChar_sq Q₁ ε hε
    · exact signChar_congr (foxProd2_char2 hb hb') fun ε hε => setChar_sq Q₂ ε hε
    · exact signChar_congr (foxProd2_char2 hc hc') fun ε hε => setChar_sq Q₃ ε hε
  · refine signChar_add (signChar_add (signChar_add ?_ ?_) ?_) ?_
    · exact signChar_congr (foxProd2_char2 hD ha') (one _)
    · exact signChar_congr (foxProd2_char2 ha hD') (one' _)
    · exact signChar_congr (foxProd2_char2 hb hc') c23
    · exact signChar_congr (foxProd2_char2 hc hb') (com _ _ _ c23)
  · refine signChar_add (signChar_add (signChar_add ?_ ?_) ?_) ?_
    · exact signChar_congr (foxProd2_char2 hD hb') (one _)
    · exact signChar_congr (foxProd2_char2 hb hD') (one' _)
    · exact signChar_congr (foxProd2_char2 ha hc') c13
    · exact signChar_congr (foxProd2_char2 hc ha') (com _ _ _ c13)
  · refine signChar_add (signChar_add (signChar_add ?_ ?_) ?_) ?_
    · exact signChar_congr (foxProd2_char2 hD hc') (one _)
    · exact signChar_congr (foxProd2_char2 hc hD') (one' _)
    · exact signChar_congr (foxProd2_char2 ha hb') c12
    · exact signChar_congr (foxProd2_char2 hb ha') (com _ _ _ c12)
  · simp only [foxProd2_add_left, foxProd2_add_right]
    abel

/-- **`𝒮 ∩ 𝒲ₙ` as a submodule.** -/
def SK (Q₁ Q₂ : Finset ι) : Submodule ℝ (CurvOp2 ι) where
  carrier := {R | IsWeyl2 R ∧ InK Q₁ Q₂ R}
  add_mem' := by
    rintro x y ⟨hxW, D, a, b, c, hD, ha, hb, hc, rfl⟩ ⟨hyW, D', a', b', c', hD', ha', hb', hc', rfl⟩
    exact ⟨isWeyl2_add hxW hyW, D + D', a + a', b + b', c + c', signChar_add hD hD', signChar_add ha ha',
      signChar_add hb hb', signChar_add hc hc', by abel⟩
  zero_mem' := ⟨isWeyl2_zero, 0, 0, 0, 0, signChar_zero _, signChar_zero _, signChar_zero _, signChar_zero _, by abel⟩
  smul_mem' := by
    rintro r x ⟨hxW, D, a, b, c, hD, ha, hb, hc, rfl⟩
    exact ⟨isWeyl2_smul r hxW, r • D, r • a, r • b, r • c, signChar_smul hD r, signChar_smul ha r, signChar_smul hb r,
      signChar_smul hc r, by module⟩

theorem SK_Qop2 (Q₁ Q₂ : Finset ι) : ∀ R ∈ SK Q₁ Q₂, Qop2 R ∈ SK Q₁ Q₂ := by
  rintro _R ⟨hRW, hR⟩
  refine ⟨isWeyl2_Qop2 hRW, ?_⟩
  rw [← foxProd2_self]
  exact K_mul hR hR

/-- **L221 (b), step 1 in full**: a local maximiser of `P` on the unit sphere of `𝒮 ∩ 𝒲ₙ` at non-nested `Q₁, Q₂` is
critical in `𝒲ₙ` with `θ = P(W)`, and its components satisfy step 1's four equations. -/
theorem L221b_step1 {Q₁ Q₂ : Finset ι} {c e : ι} (hc₁ : c ∈ Q₁) (hc₂ : c ∉ Q₂) (he₂ : e ∈ Q₂) (he₁ : e ∉ Q₁)
    {W : CurvOp2 ι} (hW1 : normSq2 W = 1) (hWS : W ∈ SK Q₁ Q₂)
    (hmax : IsLocalMaxOn Pcubic2 {R | normSq2 R = 1 ∧ R ∈ SK Q₁ Q₂} W) :
    Qop2 W = Pcubic2 W • W ∧
      ∃ D ν₁ ν₂ ν₃ : CurvOp2 ι, W = D + ν₁ + ν₂ + ν₃ ∧
        foxProd2 D D + foxProd2 ν₁ ν₁ + foxProd2 ν₂ ν₂ + foxProd2 ν₃ ν₃ = Pcubic2 W • D ∧
        (2 : ℝ) • foxProd2 D ν₁ + (2 : ℝ) • foxProd2 ν₂ ν₃ = Pcubic2 W • ν₁ ∧
        (2 : ℝ) • foxProd2 D ν₂ + (2 : ℝ) • foxProd2 ν₁ ν₃ = Pcubic2 W • ν₂ ∧
        (2 : ℝ) • foxProd2 D ν₃ + (2 : ℝ) • foxProd2 ν₁ ν₂ = Pcubic2 W • ν₃ := by
  have hcrit := crit_sub (SK Q₁ Q₂) (fun R hR => hR.1.isSelfAdjoint2) (SK_Qop2 Q₁ Q₂) hW1 hWS hmax
  refine ⟨hcrit, ?_⟩
  obtain ⟨-, D, ν₁, ν₂, ν₃, hD, h₁, h₂, h₃, hWeq⟩ := hWS
  rw [hWeq] at hcrit
  have hs := L221b_split hc₁ hc₂ he₂ he₁ hD h₁ h₂ h₃ hcrit
  rw [← hWeq] at hs
  exact ⟨D, ν₁, ν₂, ν₃, hWeq, hs⟩

end HamiltonsCubic.L221Crit
