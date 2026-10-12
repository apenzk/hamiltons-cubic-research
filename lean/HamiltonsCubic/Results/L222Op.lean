import Mathlib
import HamiltonsCubic.Results.L120Hess
import HamiltonsCubic.Results.L120Blocks
import HamiltonsCubic.Results.L219Prod
import HamiltonsCubic.Results.L24Eigen
import HamiltonsCubic.Results.WeylTraceOperator
import HamiltonsCubic.Results.L24Restrict

set_option linter.style.longLine false

/-!
# L222 on `𝒲ₙ`: the pair-block subalgebra, its criticality equations and the pinning

[findings/second-order.md](../../../findings/second-order.md), Lemma L222: *let $\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$.
(1) $\mathcal S_{jk}$ is a subalgebra. (3) If $W=D+\nu$ is a unit critical point with $\nu\ne0$, then
$\langle D,\hat g\rangle=\theta/\sqrt3$ for $\hat g=G_x/\lVert G_x\rVert$, $G_x=\nu\circ\nu$.* [L222Statement.lean](L222Statement.lean)
checks the polynomial cores. Here the operator level, with $\mathcal D_n$ the sign-fixed operators (character $1$) and
$V_{jk}$ the operators of character $\varepsilon_j\varepsilon_k$, the two summands of [L120](L120Decomp.lean)'s decomposition:

* `block2`, `foxProd2_char2`: a product of operators of sign characters $c$ and $d$ has character $cd$, the
  automorphism property of the sign group (`foxProd_act`);
* `char_split_zero`: an operator of character $1$ plus one of character $\varepsilon_j\varepsilon_k$ vanishes only when both do;
* **`Sjk_mul`**, `Sjk_mul_weyl`: $\mathcal S_{jk}$ is closed under $\circ$, and with $\mathcal W_n$'s closure so is $\mathcal S_{jk}\cap\mathcal W_n$ (item 1's subalgebra clause);
* **`Sjk_crit`**: at $W=D+\nu$ with $Q(W)=\theta W$, $Q(D)+Q(\nu)=\theta D$ and $2\,D\circ\nu=\theta\nu$;
* **`Sjk_pin`**: at self-adjoint $D,\nu$ in addition, $\langle D,\nu\circ\nu\rangle=\tfrac\theta2\lVert\nu\rVert^2$, and with item 2's norm
  $\lVert\nu\circ\nu\rVert^2=\tfrac34\lVert\nu\rVert^4$ at $\nu\ne0$, $\langle D,\hat g\rangle=\theta/\sqrt3$ (item 3's pinning, conditional on item 2's norm);
* **`crit_pair`**: at a critical self-adjoint $D$, $\theta\langle D,G\rangle=\langle L_GD,D\rangle$ for every self-adjoint $G$ (item 6).
-/

namespace HamiltonsCubic.L222Op

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Characters multiply under the product**, on the extensions. -/
theorem block2 (M X : CurvLin ι) (c d : (ι → ℝ) → ℝ)
    (hM : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) M = c ε • M)
    (hX : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) X = d ε • X)
    (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) (Z : Matrix ι ι ℝ) :
    signMat ε * foxProd (fun A => M A) (fun A => X A) ((signMat ε)ᵀ * Z * signMat ε) * (signMat ε)ᵀ
      = (c ε * d ε) • foxProd (fun A => M A) (fun A => X A) Z := by
  obtain ⟨hg, hg'⟩ := signMat_orth ε hε
  rw [← foxProd_act (signMat ε) hg hg' M X Z, hM ε hε, hX ε hε, foxProd_smul_left']
  have hMl : IsLinOp (fun A => M A) := ⟨fun _ _ => map_add M _ _, fun _ _ => map_smul M _ _⟩
  have hXl : IsLinOp (fun A => X A) := ⟨fun _ _ => map_add X _ _, fun _ _ => map_smul X _ _⟩
  have e : (fun A => (d ε • X) A) = fun A => d ε • X A := by funext A; rfl
  rw [e, foxProd_smul_right _ _ _ hMl hXl, smul_smul]

/-- **A product of operators of sign characters `c` and `d` has character `c d`.** -/
theorem foxProd2_char2 {c d : (ι → ℝ) → ℝ} {a v : CurvOp2 ι} (ha : SignChar c a) (hv : SignChar d v) :
    SignChar (fun ε => c ε * d ε) (foxProd2 a v) := by
  intro ε hε Z hZ
  have hM : ∀ ε' : ι → ℝ, (∀ i, ε' i * ε' i = 1) → act (signMat ε') (extendL a) = c ε' • extendL a :=
    fun ε' hε' => act_extendL (ha ε' hε')
  have hX : ∀ ε' : ι → ℝ, (∀ i, ε' i * ε' i = 1) → act (signMat ε') (extendL v) = d ε' • extendL v :=
    fun ε' hε' => act_extendL (hv ε' hε')
  have key := block2 (extendL a) (extendL v) c d hM hX ε hε Z
  have e1 : extend (foxProd2 a v) ((signMat ε)ᵀ * Z * signMat ε)
      = foxProd (extend a) (extend v) ((signMat ε)ᵀ * Z * signMat ε) :=
    (extend_apply (foxProd2 a v) ⟨_, skew_conj hZ⟩).trans
      (foxProd_extend a v ⟨_, skew_conj hZ⟩).symm
  have e2 : extend (foxProd2 a v) Z = foxProd (extend a) (extend v) Z :=
    (extend_apply (foxProd2 a v) ⟨Z, hZ⟩).trans (foxProd_extend a v ⟨Z, hZ⟩).symm
  rw [e1, e2]
  exact key

theorem hasChar_add {c : ℝ} {S : Matrix ι ι ℝ} {R R' : CurvOp2 ι} (h : HasChar c S R) (h' : HasChar c S R') :
    HasChar c S (R + R') := by
  intro Z hZ
  rw [extend_add, extend_add, Matrix.mul_add, Matrix.add_mul, h Z hZ, h' Z hZ, smul_add]

theorem signChar_add {c : (ι → ℝ) → ℝ} {R R' : CurvOp2 ι} (h : SignChar c R) (h' : SignChar c R') :
    SignChar c (R + R') := fun ε hε => hasChar_add (h ε hε) (h' ε hε)

theorem signChar_smul {c : (ι → ℝ) → ℝ} {R : CurvOp2 ι} (h : SignChar c R) (r : ℝ) : SignChar c (r • R) :=
  fun ε hε => hasChar_smul (h ε hε) r

theorem signChar_congr {c c' : (ι → ℝ) → ℝ} {R : CurvOp2 ι} (h : SignChar c R)
    (hc : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → c ε = c' ε) : SignChar c' R := fun ε hε => by
  rw [← hc ε hε]; exact h ε hε

/-- The pair character squares to `1`. -/
theorem pairChar_sq {j k : ι} (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) : setChar {j, k} ε * setChar {j, k} ε = 1 := by
  unfold setChar
  rw [← Finset.prod_mul_distrib]
  exact Finset.prod_eq_one fun i _ => hε i

/-- **An operator of character `1` plus one of character `ε_j ε_k` vanishes only when both do.** -/
theorem char_split_zero {j k : ι} (hjk : j ≠ k) {A B : CurvOp2 ι} (hA : SignChar (fun _ => 1) A)
    (hB : SignChar (setChar {j, k}) B) (h : A + B = 0) : A = 0 ∧ B = 0 := by
  have hAB : A = (-1 : ℝ) • B := by
    have e : A = (A + B) + (-1 : ℝ) • B := by module
    rw [e, h]; module
  set ε : ι → ℝ := Results.sgn j with hεdef
  have hε : ∀ i, ε i * ε i = 1 := fun i => Results.sgn_mul_self j i
  have hχ : setChar {j, k} ε = -1 := by
    rw [setChar_pair hjk, hεdef]
    simp [Results.sgn, Ne.symm hjk]
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

/-- **`𝒮_jk = 𝒟ₙ ⊕ V_jk`**, as operators of character `1` plus operators of character `ε_j ε_k`. -/
def InSjk (j k : ι) (R : CurvOp2 ι) : Prop :=
  ∃ D ν : CurvOp2 ι, SignChar (fun _ => 1) D ∧ SignChar (setChar {j, k}) ν ∧ R = D + ν

/-- **L222 (1), the subalgebra clause**: `𝒮_jk` is closed under `∘`. -/
theorem Sjk_mul {j k : ι} {x y : CurvOp2 ι} (hx : InSjk j k x) (hy : InSjk j k y) : InSjk j k (foxProd2 x y) := by
  obtain ⟨D, ν, hD, hν, rfl⟩ := hx
  obtain ⟨D', ν', hD', hν', rfl⟩ := hy
  refine ⟨foxProd2 D D' + foxProd2 ν ν', foxProd2 D ν' + foxProd2 ν D', ?_, ?_, ?_⟩
  · refine signChar_add (signChar_congr (foxProd2_char2 hD hD') fun ε _ => by ring)
      (signChar_congr (foxProd2_char2 hν hν') fun ε hε => pairChar_sq ε hε)
  · exact signChar_add (signChar_congr (foxProd2_char2 hD hν') fun ε _ => by ring)
      (signChar_congr (foxProd2_char2 hν hD') fun ε _ => by ring)
  · rw [foxProd2_add_left, foxProd2_add_right, foxProd2_add_right]
    abel

/-- **L222's criticality on `𝒮_jk`**: at `W = D + ν` with `Q(W) = θW`, `Q(D) + Q(ν) = θD` and `2 D∘ν = θν`. -/
theorem Sjk_crit {j k : ι} (hjk : j ≠ k) {D ν : CurvOp2 ι} (hD : SignChar (fun _ => 1) D)
    (hν : SignChar (setChar {j, k}) ν) {θ : ℝ} (hQ : Qop2 (D + ν) = θ • (D + ν)) :
    Qop2 D + Qop2 ν = θ • D ∧ (2 : ℝ) • foxProd2 D ν = θ • ν := by
  have hA : SignChar (fun _ => 1) (Qop2 D + Qop2 ν + (-1 : ℝ) • (θ • D)) := by
    rw [← foxProd2_self, ← foxProd2_self]
    refine signChar_add (signChar_add ?_ ?_) (signChar_smul (signChar_smul hD _) _)
    · exact signChar_congr (foxProd2_char2 hD hD) fun ε _ => by ring
    · exact signChar_congr (foxProd2_char2 hν hν) fun ε hε => pairChar_sq ε hε
  have hB : SignChar (setChar {j, k}) ((2 : ℝ) • foxProd2 D ν + (-1 : ℝ) • (θ • ν)) :=
    signChar_add (signChar_smul (signChar_congr (foxProd2_char2 hD hν) fun ε _ => by ring) _)
      (signChar_smul (signChar_smul hν _) _)
  have hsum : (Qop2 D + Qop2 ν + (-1 : ℝ) • (θ • D)) + ((2 : ℝ) • foxProd2 D ν + (-1 : ℝ) • (θ • ν)) = 0 := by
    have e := L219Prod.Qop2_add D ν
    rw [hQ] at e
    calc (Qop2 D + Qop2 ν + (-1 : ℝ) • (θ • D)) + ((2 : ℝ) • foxProd2 D ν + (-1 : ℝ) • (θ • ν))
        = (Qop2 D + Qop2 ν + (2 : ℝ) • foxProd2 D ν) + (-1 : ℝ) • (θ • (D + ν)) := by module
      _ = θ • (D + ν) + (-1 : ℝ) • (θ • (D + ν)) := by rw [← e]
      _ = 0 := by module
  obtain ⟨h1, h2⟩ := char_split_zero hjk hA hB hsum
  refine ⟨?_, ?_⟩
  · calc Qop2 D + Qop2 ν = (Qop2 D + Qop2 ν + (-1 : ℝ) • (θ • D)) + θ • D := by module
      _ = θ • D := by rw [h1]; module
  · calc (2 : ℝ) • foxProd2 D ν = ((2 : ℝ) • foxProd2 D ν + (-1 : ℝ) • (θ • ν)) + θ • ν := by module
      _ = θ • ν := by rw [h2]; module

/-- **L222 (3), the pinning**: `⟨D, ν∘ν⟩ = (θ/2)‖ν‖²`, and with item 2's norm `‖ν∘ν‖² = ¾‖ν‖⁴` at `ν ≠ 0`,
`⟨D, ĝ⟩ = θ/√3` for `ĝ = ν∘ν/‖ν∘ν‖`. -/
theorem Sjk_pin {j k : ι} (hjk : j ≠ k) {D ν : CurvOp2 ι} (hD : SignChar (fun _ => 1) D)
    (hν : SignChar (setChar {j, k}) ν) (hDs : IsSelfAdjoint2 D) (hνs : IsSelfAdjoint2 ν) {θ : ℝ}
    (hQ : Qop2 (D + ν) = θ • (D + ν)) :
    innerOp2 D (Qop2 ν) = θ / 2 * normSq2 ν ∧
      (normSq2 (Qop2 ν) = 3 / 4 * normSq2 ν ^ 2 → ν ≠ 0 →
        innerOp2 D (Qop2 ν) / Real.sqrt (normSq2 (Qop2 ν)) = θ / Real.sqrt 3) := by
  obtain ⟨-, h2⟩ := Sjk_crit hjk hD hν hQ
  have hpin : innerOp2 D (Qop2 ν) = θ / 2 * normSq2 ν := by
    rw [← innerOp2_foxProd2_self hDs hνs]
    have e : foxProd2 D ν = (θ / 2) • ν := by
      calc foxProd2 D ν = (1 / 2 : ℝ) • ((2 : ℝ) • foxProd2 D ν) := by module
        _ = (θ / 2) • ν := by rw [h2]; module
    rw [e, innerOp2_smul_left]
    rfl
  refine ⟨hpin, fun hG hν0 => ?_⟩
  have hs : 0 < normSq2 ν := by
    rcases (normSq2_nonneg ν).lt_or_eq with h | h
    · exact h
    · exact absurd (normSq2_eq_zero h.symm) hν0
  have hsq : Real.sqrt (normSq2 (Qop2 ν)) = Real.sqrt 3 / 2 * normSq2 ν := by
    rw [hG, show (3 / 4 : ℝ) * normSq2 ν ^ 2 = (Real.sqrt 3 / 2 * normSq2 ν) ^ 2 by
      rw [mul_pow, div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)]; ring]
    exact Real.sqrt_sq (by positivity)
  rw [hsq, hpin]
  have h3 : 0 < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  field_simp

/-- **L222 (1) on `𝒲ₙ`**: `𝒮_jk ∩ 𝒲ₙ` is closed under `∘`, `𝒲ₙ` being closed under it (`isWeyl2_foxProd2`). -/
theorem Sjk_mul_weyl {j k : ι} {x y : CurvOp2 ι} (hx : InSjk j k x) (hy : InSjk j k y) (hxW : IsWeyl2 x)
    (hyW : IsWeyl2 y) : InSjk j k (foxProd2 x y) ∧ IsWeyl2 (foxProd2 x y) :=
  ⟨Sjk_mul hx hy, isWeyl2_foxProd2 hxW hyW⟩

/-- **L222 (6)**: at a self-adjoint `D` with `Q(D) = θD`, `θ⟨D, G⟩ = ⟨L_G D, D⟩` for every self-adjoint `G`, in particular
`G = G_x = ν∘ν`, by the total symmetry of `⟨x∘y, z⟩`. -/
theorem crit_pair {D G : CurvOp2 ι} (hDs : IsSelfAdjoint2 D) (hGs : IsSelfAdjoint2 G) {θ : ℝ} (hQ : Qop2 D = θ • D) :
    θ * innerOp2 D G = innerOp2 (foxProd2 G D) D := by
  rw [innerOp2_foxProd2_self hGs hDs, hQ, innerOp2_smul_right, innerOp2_comm]

end HamiltonsCubic.L222Op
