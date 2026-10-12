import Mathlib
import HamiltonsCubic.Results.L222Op
import HamiltonsCubic.Results.L120Decomp
import HamiltonsCubic.Results.L120Ident
import HamiltonsCubic.Results.WeylTraceZero

set_option linter.style.longLine false

/-!
# The subalgebra `𝒟ₙ ⊕ V_t` of any sign character, and L220's steps 1 and 3

[findings/second-order.md](../../../findings/second-order.md), Lemma L220, step 1: *$\mathcal S_Q=\mathcal D_n\oplus V_Q$ is the fixed
space of $\ker\chi_Q\subset\Gamma$, since the only characters of L120's decomposition trivial on $\ker\chi_Q$ are $1$ and
$\chi_Q$ ... A fixed space of automorphisms is a subalgebra.* Step 3: *$D\circ D+\nu\circ\nu=\theta D$ and $L_D\nu=\tfrac\theta2\nu$.*
[L222Op.lean](L222Op.lean) proves the pair case $t=\{j,k\}$. Every step there uses only $\chi_t^2=1$ and one sign vector with
$\chi_t=-1$, so it holds for every nonempty index set $t$, the four-set $Q$ of L220 among them:

* `setChar_sq`, `setChar_sgn`, `setChar_mul`: $\chi_t^2=1$, $\chi_t(\mathrm{flip}_m)=-1$ exactly when $m\in t$, and $\chi_t$ is multiplicative;
* `char_split_zero_t`: an operator of character $1$ plus one of character $\chi_t$ vanishes only when both do;
* **`S_mul`**, **`S_crit`**: $\mathcal S_t$ is closed under $\circ$, and at $W=D+\nu$ with $Q(W)=\theta W$, $Q(D)+Q(\nu)=\theta D$ and
  $2\,D\circ\nu=\theta\nu$;
* `ker_sep`, `proj_act`, **`fixed_of_S`**, **`comp_zero_of_fixed`**: $\mathcal S_t$ is fixed by $\ker\chi_t$, and a Weyl operator fixed by
  $\ker\chi_t$ has every component of L120's decomposition off $\{\varnothing,t\}$ zero, so it is $D+\nu$ with $D$ diagonal and $\nu\in V_t$;
* **`weyl_fixed_iff`**: $\mathcal S_t\cap\mathcal W_n$ is exactly the fixed space of $\ker\chi_t$ in $\mathcal W_n$, step 1's identification;
* **`L220_sub`**, **`L220_split`**: L220's steps 1 and 3 at a four-set $Q$.
-/

namespace HamiltonsCubic.BlockSub

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L120Decomp HamiltonsCubic.L222Op HamiltonsCubic.L120HessPair

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem setChar_sq (t : Finset ι) (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) : setChar t ε * setChar t ε = 1 := by
  unfold setChar
  rw [← Finset.prod_mul_distrib]
  exact Finset.prod_eq_one fun i _ => hε i

theorem setChar_sgn (t : Finset ι) (m : ι) : setChar t (Results.sgn m) = if m ∈ t then -1 else 1 := by
  unfold setChar Results.sgn
  rw [Finset.prod_ite_eq']

theorem setChar_mul (t : Finset ι) (ε δ : ι → ℝ) : setChar t (fun i => ε i * δ i) = setChar t ε * setChar t δ := by
  unfold setChar
  exact Finset.prod_mul_distrib

/-- **An operator of character `1` plus one of character `χ_t` vanishes only when both do**, at nonempty `t`. -/
theorem char_split_zero_t {t : Finset ι} (ht : t.Nonempty) {A B : CurvOp2 ι} (hA : SignChar (fun _ => 1) A)
    (hB : SignChar (setChar t) B) (h : A + B = 0) : A = 0 ∧ B = 0 := by
  obtain ⟨m, hm⟩ := ht
  have hAB : A = (-1 : ℝ) • B := by
    have e : A = (A + B) + (-1 : ℝ) • B := by module
    rw [e, h]; module
  set ε : ι → ℝ := Results.sgn m with hεdef
  have hε : ∀ i, ε i * ε i = 1 := fun i => Results.sgn_mul_self m i
  have hχ : setChar t ε = -1 := by rw [hεdef, setChar_sgn, if_pos hm]
  have h1 := hA ε hε
  have h2 : HasChar (-1) (signMat ε) A := by
    rw [hAB, ← hχ]; exact hasChar_smul (hB ε hε) _
  have hA0 : A = 0 := by
    refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
    have e1 := h1 (X : Matrix ι ι ℝ) X.2
    have e2 := h2 (X : Matrix ι ι ℝ) X.2
    rw [e1] at e2
    have hz : extend A (X : Matrix ι ι ℝ) = 0 := by
      have : (2 : ℝ) • extend A (X : Matrix ι ι ℝ) = 0 := by
        calc (2 : ℝ) • extend A (X : Matrix ι ι ℝ)
            = (1 : ℝ) • extend A (X : Matrix ι ι ℝ) - (-1 : ℝ) • extend A (X : Matrix ι ι ℝ) := by module
          _ = 0 := by rw [e2]; module
      exact (smul_eq_zero.mp this).resolve_left (by norm_num)
    rw [extend_apply] at hz
    rw [hz]; rfl
  refine ⟨hA0, ?_⟩
  have e : B = A + B - A := by abel
  rw [e, h, hA0]; abel

/-- **`𝒮_t = 𝒟ₙ ⊕ V_t`**, operators of character `1` plus operators of character `χ_t`. -/
def InS (t : Finset ι) (R : CurvOp2 ι) : Prop :=
  ∃ D ν : CurvOp2 ι, SignChar (fun _ => 1) D ∧ SignChar (setChar t) ν ∧ R = D + ν

/-- **`𝒮_t` is closed under `∘`.** -/
theorem S_mul {t : Finset ι} {x y : CurvOp2 ι} (hx : InS t x) (hy : InS t y) : InS t (foxProd2 x y) := by
  obtain ⟨D, ν, hD, hν, rfl⟩ := hx
  obtain ⟨D', ν', hD', hν', rfl⟩ := hy
  refine ⟨foxProd2 D D' + foxProd2 ν ν', foxProd2 D ν' + foxProd2 ν D', ?_, ?_, ?_⟩
  · exact signChar_add (signChar_congr (foxProd2_char2 hD hD') fun ε _ => by ring)
      (signChar_congr (foxProd2_char2 hν hν') fun ε hε => setChar_sq t ε hε)
  · exact signChar_add (signChar_congr (foxProd2_char2 hD hν') fun ε _ => by ring)
      (signChar_congr (foxProd2_char2 hν hD') fun ε _ => by ring)
  · rw [foxProd2_add_left, foxProd2_add_right, foxProd2_add_right]
    abel

/-- **Criticality on `𝒮_t`**: at `W = D + ν` with `Q(W) = θW`, `Q(D) + Q(ν) = θD` and `2 D∘ν = θν`. -/
theorem S_crit {t : Finset ι} (ht : t.Nonempty) {D ν : CurvOp2 ι} (hD : SignChar (fun _ => 1) D)
    (hν : SignChar (setChar t) ν) {θ : ℝ} (hQ : Qop2 (D + ν) = θ • (D + ν)) :
    Qop2 D + Qop2 ν = θ • D ∧ (2 : ℝ) • foxProd2 D ν = θ • ν := by
  have hA : SignChar (fun _ => 1) (Qop2 D + Qop2 ν + (-1 : ℝ) • (θ • D)) := by
    rw [← foxProd2_self, ← foxProd2_self]
    refine signChar_add (signChar_add ?_ ?_) (signChar_smul (signChar_smul hD _) _)
    · exact signChar_congr (foxProd2_char2 hD hD) fun ε _ => by ring
    · exact signChar_congr (foxProd2_char2 hν hν) fun ε hε => setChar_sq t ε hε
  have hB : SignChar (setChar t) ((2 : ℝ) • foxProd2 D ν + (-1 : ℝ) • (θ • ν)) :=
    signChar_add (signChar_smul (signChar_congr (foxProd2_char2 hD hν) fun ε _ => by ring) _)
      (signChar_smul (signChar_smul hν _) _)
  have hsum : (Qop2 D + Qop2 ν + (-1 : ℝ) • (θ • D)) + ((2 : ℝ) • foxProd2 D ν + (-1 : ℝ) • (θ • ν)) = 0 := by
    have e := L219Prod.Qop2_add D ν
    rw [hQ] at e
    calc (Qop2 D + Qop2 ν + (-1 : ℝ) • (θ • D)) + ((2 : ℝ) • foxProd2 D ν + (-1 : ℝ) • (θ • ν))
        = (Qop2 D + Qop2 ν + (2 : ℝ) • foxProd2 D ν) + (-1 : ℝ) • (θ • (D + ν)) := by module
      _ = θ • (D + ν) + (-1 : ℝ) • (θ • (D + ν)) := by rw [← e]
      _ = 0 := by module
  obtain ⟨h1, h2⟩ := char_split_zero_t ht hA hB hsum
  refine ⟨?_, ?_⟩
  · calc Qop2 D + Qop2 ν = (Qop2 D + Qop2 ν + (-1 : ℝ) • (θ • D)) + θ • D := by module
      _ = θ • D := by rw [h1]; module
  · calc (2 : ℝ) • foxProd2 D ν = ((2 : ℝ) • foxProd2 D ν + (-1 : ℝ) • (θ • ν)) + θ • ν := by module
      _ = θ • ν := by rw [h2]; module

/-- **`𝒮_t` is fixed by `ker χ_t`.** -/
theorem fixed_of_S {t : Finset ι} {R : CurvOp2 ι} (hR : InS t R) (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1)
    (hχ : setChar t ε = 1) : HasChar 1 (signMat ε) R := by
  obtain ⟨D, ν, hD, hν, rfl⟩ := hR
  have h2 := hν ε hε
  rw [hχ] at h2
  exact hasChar_add (hD ε hε) h2

/-- **A sign vector in `ker χ_t` separates every other nonempty index set from `t`.** -/
theorem ker_sep {t u : Finset ι} (hu : u.Nonempty) (hut : u ≠ t) :
    ∃ ε : ι → ℝ, (∀ i, ε i * ε i = 1) ∧ setChar t ε = 1 ∧ setChar u ε = -1 := by
  by_cases hsub : u ⊆ t
  · obtain ⟨a, ha⟩ := hu
    obtain ⟨c, hct, hcu⟩ : ∃ c ∈ t, c ∉ u := by
      by_contra hall
      push Not at hall
      exact hut (Finset.Subset.antisymm hsub hall)
    refine ⟨fun i => Results.sgn a i * Results.sgn c i, fun i => ?_, ?_, ?_⟩
    · calc Results.sgn a i * Results.sgn c i * (Results.sgn a i * Results.sgn c i)
          = (Results.sgn a i * Results.sgn a i) * (Results.sgn c i * Results.sgn c i) := by ring
        _ = 1 := by rw [Results.sgn_mul_self, Results.sgn_mul_self, one_mul]
    · rw [setChar_mul, setChar_sgn, setChar_sgn, if_pos (hsub ha), if_pos hct]; norm_num
    · rw [setChar_mul, setChar_sgn, setChar_sgn, if_pos ha, if_neg hcu]; norm_num
  · obtain ⟨m, hmu, hmt⟩ : ∃ m ∈ u, m ∉ t := by
      by_contra hall
      push Not at hall
      exact hsub hall
    refine ⟨Results.sgn m, Results.sgn_mul_self m, ?_, ?_⟩
    · rw [setChar_sgn, if_neg hmt]
    · rw [setChar_sgn, if_pos hmu]

/-- `proj u` commutes with every sign conjugation. -/
theorem proj_act (u : Finset ι) (ε : ι → ℝ) (B : CurvLin ι) :
    proj u (act (signMat ε) B) = act (signMat ε) (proj u B) := by
  unfold proj
  rw [act_smul', act_sum]
  congr 1
  refine Finset.sum_congr rfl fun v _ => ?_
  rw [act_smul', act_comp, act_comp]
  congr 2
  unfold diagSet signMat
  rw [Matrix.diagonal_mul_diagonal, Matrix.diagonal_mul_diagonal]
  congr 1
  funext i
  ring

/-- **A Weyl operator fixed by `ker χ_t` has every component off `{∅, t}` zero.** -/
theorem comp_zero_of_fixed {t u : Finset ι} (hu : u.Nonempty) (hut : u ≠ t) {R : CurvOp2 ι} (hRW : IsWeyl2 R)
    (hfix : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → setChar t ε = 1 → HasChar 1 (signMat ε) R) :
    comp u R hRW = 0 := by
  obtain ⟨ε, hε, hχt, hχu⟩ := ker_sep hu hut
  have hB : act (signMat ε) (extendL R) = extendL R := by
    rw [act_extendL (hfix ε hε hχt), one_smul]
  have h1 := proj_signMat u (extendL R) ε hε
  rw [hχu, ← proj_act, hB] at h1
  have hz : proj u (extendL R) = 0 := by
    have : (2 : ℝ) • proj u (extendL R) = 0 := by
      calc (2 : ℝ) • proj u (extendL R) = proj u (extendL R) - (-1 : ℝ) • proj u (extendL R) := by module
        _ = 0 := by rw [← h1]; module
    exact (smul_eq_zero.mp this).resolve_left (by norm_num)
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  show proj u (extendL R) (X : Matrix ι ι ℝ) = 0
  rw [hz]; rfl

/-- **L220 (1), the subalgebra clause** at `Q = {i, j, k, l}`, a four-set when the indices are distinct: `𝒮_Q = 𝒟ₙ ⊕ V_Q` is closed under `∘`. -/
theorem L220_sub {i j k l : ι} {x y : CurvOp2 ι} (hx : InS {i, j, k, l} x) (hy : InS {i, j, k, l} y) :
    InS {i, j, k, l} (foxProd2 x y) :=
  S_mul hx hy

/-- **L220 (3), the split equation** at `Q = {i, j, k, l}`, a four-set when the indices are distinct: at `W = D + ν` with `Q(W) = θW`, `D∘D + ν∘ν = θD` and
`2 D∘ν = θν`, that is `L_D ν = (θ/2) ν`. -/
theorem L220_split {i j k l : ι} {D ν : CurvOp2 ι} (hD : SignChar (fun _ => 1) D)
    (hν : SignChar (setChar {i, j, k, l}) ν) {θ : ℝ} (hQ : Qop2 (D + ν) = θ • (D + ν)) :
    foxProd2 D D + foxProd2 ν ν = θ • D ∧ (2 : ℝ) • foxProd2 D ν = θ • ν := by
  obtain ⟨h1, h2⟩ := S_crit ⟨i, by simp⟩ hD hν hQ
  rw [← foxProd2_self D, ← foxProd2_self ν] at h1
  exact ⟨h1, h2⟩

/-- **`𝒮_t ∩ 𝒲ₙ` is exactly the fixed space of `ker χ_t` in `𝒲ₙ`**, at nonempty `t`: a Weyl operator is fixed by every
sign vector in `ker χ_t` iff it is `D + ν` with `D` Weyl of character `1` and `ν` Weyl of character `χ_t`, namely
`D = comp ∅ R` and `ν = comp t R`. -/
theorem weyl_fixed_iff {t : Finset ι} (ht : t.Nonempty) {R : CurvOp2 ι} (hRW : IsWeyl2 R) :
    (∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → setChar t ε = 1 → HasChar 1 (signMat ε) R) ↔
      ∃ D ν : CurvOp2 ι, IsWeyl2 D ∧ IsWeyl2 ν ∧ SignChar (fun _ => 1) D ∧ SignChar (setChar t) ν ∧ R = D + ν := by
  constructor
  · intro hfix
    refine ⟨comp ∅ R hRW, comp t R hRW, comp_isWeyl2 _ _ _, comp_isWeyl2 _ _ _,
      signChar_congr (comp_char ∅ R hRW) fun ε _ => by simp [setChar], comp_char t R hRW, ?_⟩
    have hne : (∅ : Finset ι) ≠ t := fun h => by rw [← h] at ht; exact Finset.not_nonempty_empty ht
    rw [← Finset.sum_eq_add (s := Finset.univ) (f := fun u => comp u R hRW) ∅ t hne
      (fun u _ hu => comp_zero_of_fixed (Finset.nonempty_iff_ne_empty.mpr hu.1) hu.2 hRW hfix)
      (fun h => absurd (Finset.mem_univ _) h) (fun h => absurd (Finset.mem_univ _) h)]
    exact (sum_comp R hRW).symm
  · rintro ⟨D, ν, -, -, hD, hν, rfl⟩ ε hε hχ
    exact fixed_of_S ⟨D, ν, hD, hν, rfl⟩ ε hε hχ

end HamiltonsCubic.BlockSub
