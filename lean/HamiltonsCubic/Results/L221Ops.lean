import Mathlib
import HamiltonsCubic.Results.BlockSub
import HamiltonsCubic.Results.L120Support
import HamiltonsCubic.Results.L24Restrict

set_option linter.style.longLine false

/-!
# L221 on the operators: the four-character split of criticality, and disjoint blocks multiply to zero

[findings/second-order.md](../../../findings/second-order.md), Lemma L221 (b), step 1: *the characters trivial on
$\ker\chi_{Q_1}\cap\ker\chi_{Q_2}$ are $\{1,\chi_{Q_1},\chi_{Q_2},\chi_{Q_3}\}$, $Q_3=Q_1\triangle Q_2$, so $\mathcal S$ is a subalgebra and
criticality splits into $D\circ D+\sum_i\nu_i\circ\nu_i=\theta D$ and $2D\circ\nu_i+2\nu_j\circ\nu_k=\theta\nu_i$ for $\{i,j,k\}=\{1,2,3\}$. With
$\nu_3=0$ the $\chi_{Q_3}$ equation forces $\nu_1\circ\nu_2=0$.* (a): *$\chi_{Q_i}\chi_{Q_j}$ for $i\ne j$ is the character of an
eight-element set, which no block carries, so $\nu_i\circ\nu_j=0$.*

* `setChar_symmDiff`: $\chi_t\chi_u=\chi_{t\triangle u}$ on sign vectors;
* `klein_zero`: four operators of characters $1,\chi_1,\chi_2,\chi_3$ summing to zero all vanish, given three sign vectors on
  which $(\chi_1,\chi_2,\chi_3)$ take the values $(-1,1,-1)$, $(1,-1,-1)$ and $(-1,-1,1)$;
* **`L221b_split`**: at non-nested $Q_1,Q_2$ and $W=D+\nu_1+\nu_2+\nu_3$ with $Q(W)=\theta W$, the four equations of step 1;
* **`L221b_tau_zero`**: with $\nu_3=0$, $\nu_1\circ\nu_2=0$;
* **`disjoint_prod_zero`**: at disjoint four-sets, $\nu_1\circ\nu_2=0$ for any $\nu_i$ of characters $\chi_{Q_i}$, Weyl or not (L221 (a)).
-/

namespace HamiltonsCubic.L221Ops

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L120Decomp HamiltonsCubic.L222Op HamiltonsCubic.BlockSub

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Characters multiply by symmetric difference** on sign vectors. -/
theorem setChar_symmDiff (t u : Finset ι) (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) :
    setChar t ε * setChar u ε = setChar (symmDiff t u) ε := by
  unfold setChar
  rw [← Finset.prod_inter_mul_prod_diff t u, ← Finset.prod_inter_mul_prod_diff u t, Finset.inter_comm u t,
    symmDiff_def, Finset.sup_eq_union, Finset.prod_union disjoint_sdiff_sdiff]
  have h : (∏ i ∈ t ∩ u, ε i) * (∏ i ∈ t ∩ u, ε i) = 1 := by
    rw [← Finset.prod_mul_distrib]; exact Finset.prod_eq_one fun i _ => hε i
  calc (∏ i ∈ t ∩ u, ε i) * (∏ i ∈ t \ u, ε i) * ((∏ i ∈ t ∩ u, ε i) * ∏ i ∈ u \ t, ε i)
      = ((∏ i ∈ t ∩ u, ε i) * (∏ i ∈ t ∩ u, ε i)) * ((∏ i ∈ t \ u, ε i) * ∏ i ∈ u \ t, ε i) := by ring
    _ = (∏ i ∈ t \ u, ε i) * ∏ i ∈ u \ t, ε i := by rw [h, one_mul]

theorem extend_zero' (Y : Matrix ι ι ℝ) : extend (0 : CurvOp2 ι) Y = 0 := by
  unfold extend
  simp

/-- **Four operators of characters `1, χ₁, χ₂, χ₃` summing to zero all vanish.** -/
theorem klein_zero {c₁ c₂ c₃ : (ι → ℝ) → ℝ} {A₀ A₁ A₂ A₃ : CurvOp2 ι} (h₀ : SignChar (fun _ => 1) A₀)
    (h₁ : SignChar c₁ A₁) (h₂ : SignChar c₂ A₂) (h₃ : SignChar c₃ A₃)
    {ε δ ζ : ι → ℝ} (hε : ∀ i, ε i * ε i = 1) (hδ : ∀ i, δ i * δ i = 1) (hζ : ∀ i, ζ i * ζ i = 1)
    (e₁ : c₁ ε = -1) (e₂ : c₂ ε = 1) (e₃ : c₃ ε = -1) (d₁ : c₁ δ = 1) (d₂ : c₂ δ = -1) (d₃ : c₃ δ = -1)
    (z₁ : c₁ ζ = -1) (z₂ : c₂ ζ = -1) (z₃ : c₃ ζ = 1)
    (hsum : A₀ + A₁ + A₂ + A₃ = 0) : A₀ = 0 ∧ A₁ = 0 ∧ A₂ = 0 ∧ A₃ = 0 := by
  have hS : ∀ Y : Matrix ι ι ℝ, extend A₀ Y + extend A₁ Y + extend A₂ Y + extend A₃ Y = 0 := fun Y => by
    rw [← extend_add, ← extend_add, ← extend_add, hsum, extend_zero']
  -- conjugate the relation by a sign matrix
  have hconj : ∀ (κ : ι → ℝ), (∀ i, κ i * κ i = 1) → ∀ Z : Matrix ι ι ℝ, IsSkew Z →
      extend A₀ Z + c₁ κ • extend A₁ Z + c₂ κ • extend A₂ Z + c₃ κ • extend A₃ Z = 0 := by
    intro κ hκ Z hZ
    have e := congrArg (fun M => signMat κ * M * (signMat κ)ᵀ) (hS ((signMat κ)ᵀ * Z * signMat κ))
    simp only [Matrix.mul_add, Matrix.add_mul, Matrix.mul_zero, Matrix.zero_mul] at e
    rw [h₀ κ hκ Z hZ, h₁ κ hκ Z hZ, h₂ κ hκ Z hZ, h₃ κ hκ Z hZ, one_smul] at e
    exact e
  have key : ∀ Z : Matrix ι ι ℝ, IsSkew Z →
      extend A₀ Z = 0 ∧ extend A₁ Z = 0 ∧ extend A₂ Z = 0 ∧ extend A₃ Z = 0 := by
    intro Z hZ
    have f0 := hS Z
    have f1 := hconj ε hε Z hZ
    have f2 := hconj δ hδ Z hZ
    have f3 := hconj ζ hζ Z hZ
    rw [e₁, e₂, e₃] at f1
    rw [d₁, d₂, d₃] at f2
    rw [z₁, z₂, z₃] at f3
    set a₀ := extend A₀ Z
    set a₁ := extend A₁ Z
    set a₂ := extend A₂ Z
    set a₃ := extend A₃ Z
    refine ⟨?_, ?_, ?_, ?_⟩
    · calc a₀ = (1 / 4 : ℝ) • ((a₀ + a₁ + a₂ + a₃) + (a₀ + (-1 : ℝ) • a₁ + (1 : ℝ) • a₂ + (-1 : ℝ) • a₃)
            + (a₀ + (1 : ℝ) • a₁ + (-1 : ℝ) • a₂ + (-1 : ℝ) • a₃) + (a₀ + (-1 : ℝ) • a₁ + (-1 : ℝ) • a₂ + (1 : ℝ) • a₃)) := by
            module
        _ = 0 := by rw [f0, f1, f2, f3]; module
    · calc a₁ = (1 / 4 : ℝ) • ((a₀ + a₁ + a₂ + a₃) - (a₀ + (-1 : ℝ) • a₁ + (1 : ℝ) • a₂ + (-1 : ℝ) • a₃)
            + (a₀ + (1 : ℝ) • a₁ + (-1 : ℝ) • a₂ + (-1 : ℝ) • a₃) - (a₀ + (-1 : ℝ) • a₁ + (-1 : ℝ) • a₂ + (1 : ℝ) • a₃)) := by
            module
        _ = 0 := by rw [f0, f1, f2, f3]; module
    · calc a₂ = (1 / 4 : ℝ) • ((a₀ + a₁ + a₂ + a₃) + (a₀ + (-1 : ℝ) • a₁ + (1 : ℝ) • a₂ + (-1 : ℝ) • a₃)
            - (a₀ + (1 : ℝ) • a₁ + (-1 : ℝ) • a₂ + (-1 : ℝ) • a₃) - (a₀ + (-1 : ℝ) • a₁ + (-1 : ℝ) • a₂ + (1 : ℝ) • a₃)) := by
            module
        _ = 0 := by rw [f0, f1, f2, f3]; module
    · calc a₃ = (1 / 4 : ℝ) • ((a₀ + a₁ + a₂ + a₃) - (a₀ + (-1 : ℝ) • a₁ + (1 : ℝ) • a₂ + (-1 : ℝ) • a₃)
            - (a₀ + (1 : ℝ) • a₁ + (-1 : ℝ) • a₂ + (-1 : ℝ) • a₃) + (a₀ + (-1 : ℝ) • a₁ + (-1 : ℝ) • a₂ + (1 : ℝ) • a₃)) := by
            module
        _ = 0 := by rw [f0, f1, f2, f3]; module
  have zero_of : ∀ A : CurvOp2 ι, (∀ Z : Matrix ι ι ℝ, IsSkew Z → extend A Z = 0) → A = 0 := fun A h =>
    ContinuousLinearMap.ext fun X => Subtype.ext (by rw [← extend_apply, h _ X.2]; rfl)
  exact ⟨zero_of _ fun Z hZ => (key Z hZ).1, zero_of _ fun Z hZ => (key Z hZ).2.1,
    zero_of _ fun Z hZ => (key Z hZ).2.2.1, zero_of _ fun Z hZ => (key Z hZ).2.2.2⟩

theorem signChar_zero (c : (ι → ℝ) → ℝ) : SignChar c (0 : CurvOp2 ι) := fun ε _ Z _ => by
  rw [extend_zero', extend_zero', Matrix.mul_zero, Matrix.zero_mul, smul_zero]

/-- **L221 (b), step 1**: at non-nested `Q₁, Q₂` (witnessed by `c ∈ Q₁ \ Q₂` and `e ∈ Q₂ \ Q₁`), `Q₃ = Q₁ ∆ Q₂`, and
`W = D + ν₁ + ν₂ + ν₃` with `D` of character `1` and `ν_i` of character `χ_{Q_i}`, `Q(W) = θW` splits into
`D∘D + Σ ν_i∘ν_i = θD` and `2 D∘ν_i + 2 ν_j∘ν_k = θν_i`. -/
theorem L221b_split {Q₁ Q₂ : Finset ι} {c e : ι} (hc₁ : c ∈ Q₁) (hc₂ : c ∉ Q₂) (he₂ : e ∈ Q₂) (he₁ : e ∉ Q₁)
    {D ν₁ ν₂ ν₃ : CurvOp2 ι} (hD : SignChar (fun _ => 1) D) (h₁ : SignChar (setChar Q₁) ν₁)
    (h₂ : SignChar (setChar Q₂) ν₂) (h₃ : SignChar (setChar (symmDiff Q₁ Q₂)) ν₃) {θ : ℝ}
    (hQ : Qop2 (D + ν₁ + ν₂ + ν₃) = θ • (D + ν₁ + ν₂ + ν₃)) :
    foxProd2 D D + foxProd2 ν₁ ν₁ + foxProd2 ν₂ ν₂ + foxProd2 ν₃ ν₃ = θ • D ∧
      (2 : ℝ) • foxProd2 D ν₁ + (2 : ℝ) • foxProd2 ν₂ ν₃ = θ • ν₁ ∧
      (2 : ℝ) • foxProd2 D ν₂ + (2 : ℝ) • foxProd2 ν₁ ν₃ = θ • ν₂ ∧
      (2 : ℝ) • foxProd2 D ν₃ + (2 : ℝ) • foxProd2 ν₁ ν₂ = θ • ν₃ := by
  set Q₃ := symmDiff Q₁ Q₂ with hQ₃
  have sq : ∀ t : Finset ι, ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → setChar t ε * setChar t ε = 1 :=
    fun t ε hε => setChar_sq t ε hε
  have c23 : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → setChar Q₂ ε * setChar Q₃ ε = setChar Q₁ ε := fun ε hε => by
    rw [setChar_symmDiff _ _ ε hε, hQ₃, symmDiff_comm Q₁ Q₂, symmDiff_symmDiff_cancel_left]
  have c13 : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → setChar Q₁ ε * setChar Q₃ ε = setChar Q₂ ε := fun ε hε => by
    rw [setChar_symmDiff _ _ ε hε, hQ₃, symmDiff_symmDiff_cancel_left]
  have c12 : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → setChar Q₁ ε * setChar Q₂ ε = setChar Q₃ ε := fun ε hε => by
    rw [setChar_symmDiff _ _ ε hε]
  have hA₀ : SignChar (fun _ => 1)
      (foxProd2 D D + foxProd2 ν₁ ν₁ + foxProd2 ν₂ ν₂ + foxProd2 ν₃ ν₃ + (-1 : ℝ) • (θ • D)) := by
    refine signChar_add (signChar_add (signChar_add (signChar_add ?_ ?_) ?_) ?_) (signChar_smul (signChar_smul hD _) _)
    · exact signChar_congr (foxProd2_char2 hD hD) fun _ _ => by ring
    · exact signChar_congr (foxProd2_char2 h₁ h₁) fun ε hε => sq Q₁ ε hε
    · exact signChar_congr (foxProd2_char2 h₂ h₂) fun ε hε => sq Q₂ ε hε
    · exact signChar_congr (foxProd2_char2 h₃ h₃) fun ε hε => sq Q₃ ε hε
  have hA₁ : SignChar (setChar Q₁) ((2 : ℝ) • foxProd2 D ν₁ + (2 : ℝ) • foxProd2 ν₂ ν₃ + (-1 : ℝ) • (θ • ν₁)) :=
    signChar_add (signChar_add (signChar_smul (signChar_congr (foxProd2_char2 hD h₁) fun _ _ => by ring) _)
      (signChar_smul (signChar_congr (foxProd2_char2 h₂ h₃) c23) _)) (signChar_smul (signChar_smul h₁ _) _)
  have hA₂ : SignChar (setChar Q₂) ((2 : ℝ) • foxProd2 D ν₂ + (2 : ℝ) • foxProd2 ν₁ ν₃ + (-1 : ℝ) • (θ • ν₂)) :=
    signChar_add (signChar_add (signChar_smul (signChar_congr (foxProd2_char2 hD h₂) fun _ _ => by ring) _)
      (signChar_smul (signChar_congr (foxProd2_char2 h₁ h₃) c13) _)) (signChar_smul (signChar_smul h₂ _) _)
  have hA₃ : SignChar (setChar Q₃) ((2 : ℝ) • foxProd2 D ν₃ + (2 : ℝ) • foxProd2 ν₁ ν₂ + (-1 : ℝ) • (θ • ν₃)) :=
    signChar_add (signChar_add (signChar_smul (signChar_congr (foxProd2_char2 hD h₃) fun _ _ => by ring) _)
      (signChar_smul (signChar_congr (foxProd2_char2 h₁ h₂) c12) _)) (signChar_smul (signChar_smul h₃ _) _)
  have hexp := hQ
  rw [← foxProd2_self] at hexp
  simp only [foxProd2_add_left, foxProd2_add_right] at hexp
  rw [foxProd2_comm ν₁ D, foxProd2_comm ν₂ D, foxProd2_comm ν₃ D, foxProd2_comm ν₂ ν₁, foxProd2_comm ν₃ ν₁,
    foxProd2_comm ν₃ ν₂] at hexp
  have hsum : (foxProd2 D D + foxProd2 ν₁ ν₁ + foxProd2 ν₂ ν₂ + foxProd2 ν₃ ν₃ + (-1 : ℝ) • (θ • D))
      + ((2 : ℝ) • foxProd2 D ν₁ + (2 : ℝ) • foxProd2 ν₂ ν₃ + (-1 : ℝ) • (θ • ν₁))
      + ((2 : ℝ) • foxProd2 D ν₂ + (2 : ℝ) • foxProd2 ν₁ ν₃ + (-1 : ℝ) • (θ • ν₂))
      + ((2 : ℝ) • foxProd2 D ν₃ + (2 : ℝ) • foxProd2 ν₁ ν₂ + (-1 : ℝ) • (θ • ν₃)) = 0 := by
    calc _ = (foxProd2 D D + foxProd2 D ν₁ + foxProd2 D ν₂ + foxProd2 D ν₃ +
            (foxProd2 D ν₁ + foxProd2 ν₁ ν₁ + foxProd2 ν₁ ν₂ + foxProd2 ν₁ ν₃) +
            (foxProd2 D ν₂ + foxProd2 ν₁ ν₂ + foxProd2 ν₂ ν₂ + foxProd2 ν₂ ν₃) +
            (foxProd2 D ν₃ + foxProd2 ν₁ ν₃ + foxProd2 ν₂ ν₃ + foxProd2 ν₃ ν₃))
          + (-1 : ℝ) • (θ • (D + ν₁ + ν₂ + ν₃)) := by module
      _ = θ • (D + ν₁ + ν₂ + ν₃) + (-1 : ℝ) • (θ • (D + ν₁ + ν₂ + ν₃)) := by rw [hexp]
      _ = 0 := by module
  have hε := Results.sgn_mul_self c
  have hδ := Results.sgn_mul_self e
  have hζ : ∀ i, Results.sgn c i * Results.sgn e i * (Results.sgn c i * Results.sgn e i) = 1 := fun i => by
    calc Results.sgn c i * Results.sgn e i * (Results.sgn c i * Results.sgn e i)
        = (Results.sgn c i * Results.sgn c i) * (Results.sgn e i * Results.sgn e i) := by ring
      _ = 1 := by rw [Results.sgn_mul_self, Results.sgn_mul_self, one_mul]
  have hc₃ : c ∈ Q₃ := by rw [hQ₃, Finset.mem_symmDiff]; exact Or.inl ⟨hc₁, hc₂⟩
  have he₃ : e ∈ Q₃ := by rw [hQ₃, Finset.mem_symmDiff]; exact Or.inr ⟨he₂, he₁⟩
  obtain ⟨z₀, z₁, z₂, z₃⟩ := klein_zero (c₁ := setChar Q₁) (c₂ := setChar Q₂) (c₃ := setChar Q₃)
    (ε := Results.sgn c) (δ := Results.sgn e) (ζ := fun i => Results.sgn c i * Results.sgn e i)
    hA₀ hA₁ hA₂ hA₃ hε hδ hζ
    (by rw [setChar_sgn, if_pos hc₁]) (by rw [setChar_sgn, if_neg hc₂]) (by rw [setChar_sgn, if_pos hc₃])
    (by rw [setChar_sgn, if_neg he₁]) (by rw [setChar_sgn, if_pos he₂]) (by rw [setChar_sgn, if_pos he₃])
    (by rw [setChar_mul, setChar_sgn, setChar_sgn, if_pos hc₁, if_neg he₁]; norm_num)
    (by rw [setChar_mul, setChar_sgn, setChar_sgn, if_neg hc₂, if_pos he₂]; norm_num)
    (by rw [setChar_mul, setChar_sgn, setChar_sgn, if_pos hc₃, if_pos he₃]; norm_num) hsum
  refine ⟨?_, ?_, ?_, ?_⟩
  · calc _ = (foxProd2 D D + foxProd2 ν₁ ν₁ + foxProd2 ν₂ ν₂ + foxProd2 ν₃ ν₃ + (-1 : ℝ) • (θ • D)) + θ • D := by
          module
      _ = θ • D := by rw [z₀]; module
  · calc _ = ((2 : ℝ) • foxProd2 D ν₁ + (2 : ℝ) • foxProd2 ν₂ ν₃ + (-1 : ℝ) • (θ • ν₁)) + θ • ν₁ := by module
      _ = θ • ν₁ := by rw [z₁]; module
  · calc _ = ((2 : ℝ) • foxProd2 D ν₂ + (2 : ℝ) • foxProd2 ν₁ ν₃ + (-1 : ℝ) • (θ • ν₂)) + θ • ν₂ := by module
      _ = θ • ν₂ := by rw [z₂]; module
  · calc _ = ((2 : ℝ) • foxProd2 D ν₃ + (2 : ℝ) • foxProd2 ν₁ ν₂ + (-1 : ℝ) • (θ • ν₃)) + θ • ν₃ := by module
      _ = θ • ν₃ := by rw [z₃]; module

/-- **L221 (b), step 1's last clause**: with `ν₃ = 0`, `ν₁ ∘ ν₂ = 0`, so `τ = ⟨ν₁∘ν₂, ν₃⟩ = 0`. -/
theorem L221b_tau_zero {Q₁ Q₂ : Finset ι} {c e : ι} (hc₁ : c ∈ Q₁) (hc₂ : c ∉ Q₂) (he₂ : e ∈ Q₂) (he₁ : e ∉ Q₁)
    {D ν₁ ν₂ : CurvOp2 ι} (hD : SignChar (fun _ => 1) D) (h₁ : SignChar (setChar Q₁) ν₁)
    (h₂ : SignChar (setChar Q₂) ν₂) {θ : ℝ} (hQ : Qop2 (D + ν₁ + ν₂ + 0) = θ • (D + ν₁ + ν₂ + 0)) :
    foxProd2 ν₁ ν₂ = 0 := by
  obtain ⟨-, -, -, h4⟩ := L221b_split hc₁ hc₂ he₂ he₁ hD h₁ h₂ (signChar_zero _) hQ
  have hz : foxProd2 D (0 : CurvOp2 ι) = 0 := by
    have e : (0 : CurvOp2 ι) = (0 : ℝ) • (0 : CurvOp2 ι) := by module
    calc foxProd2 D (0 : CurvOp2 ι) = foxProd2 D ((0 : ℝ) • (0 : CurvOp2 ι)) := congrArg (foxProd2 D) e
      _ = (0 : ℝ) • foxProd2 D (0 : CurvOp2 ι) := foxProd2_smul_right _ _ _
      _ = 0 := by module
  rw [hz] at h4
  calc foxProd2 ν₁ ν₂ = (1 / 2 : ℝ) • ((2 : ℝ) • (0 : CurvOp2 ι) + (2 : ℝ) • foxProd2 ν₁ ν₂) := by module
    _ = 0 := by rw [h4]; module

/-- **L221 (a), the off-diagonal products**: at disjoint four-sets, `ν₁ ∘ ν₂ = 0` for `ν_i` of characters `χ_{Q_i}`,
their product carrying the character of an eight-element set, which no nonzero operator carries (`block_card`). -/
theorem disjoint_prod_zero {Q₁ Q₂ : Finset ι} (hdis : Disjoint Q₁ Q₂) (hc₁ : Q₁.card = 4) (hc₂ : Q₂.card = 4)
    {ν₁ ν₂ : CurvOp2 ι} (h₁ : SignChar (setChar Q₁) ν₁) (h₂ : SignChar (setChar Q₂) ν₂) :
    foxProd2 ν₁ ν₂ = 0 := by
  have hX : SignChar (setChar (Q₁ ∪ Q₂)) (foxProd2 ν₁ ν₂) :=
    signChar_congr (foxProd2_char2 h₁ h₂) fun ε hε => by
      rw [setChar_symmDiff _ _ ε hε, hdis.symmDiff_eq_sup, Finset.sup_eq_union]
  by_contra h0
  have hcard := HamiltonsCubic.L120Support.block_card hX h0
  rw [Finset.card_union_of_disjoint hdis, hc₁, hc₂] at hcard
  omega

end HamiltonsCubic.L221Ops
