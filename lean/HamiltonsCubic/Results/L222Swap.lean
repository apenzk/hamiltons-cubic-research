import Mathlib
import HamiltonsCubic.Results.L222Op
import HamiltonsCubic.Results.L219GenOps
import HamiltonsCubic.Results.L120Ident
import HamiltonsCubic.Results.L24Restrict

set_option linter.style.longLine false

/-!
# L222 (3), the odd part: every Weyl operator of character $\varepsilon_j\varepsilon_k$ is swap-even, and $2L_{D^+}D^-=\theta D^-$

[findings/second-order.md](../../../findings/second-order.md), Lemma L222 (3): *if $W=D+\nu$ is a unit critical point with
$\nu\ne0$, then $2L_{D^+}D^-=\theta D^-$*, with $\sigma$ swapping $j$ and $k$ and $D=D^++D^-$ its even and odd parts.
[L222Op.lean](L222Op.lean) supplies the characters. Here the swap:

* `swapM`, `swapM_orth`, `swapM_entry`, `swapM_phi`, `signMat_swapM`: the permutation matrix $M$ of $(j\,k)$, with
  $(MAM^{\mathsf T})_{pq}=A_{s p,s q}$, $M\varphi_{ab}M^{\mathsf T}=\varphi_{s a,s b}$ and $\mathrm{diag}(\varepsilon)M=M\,\mathrm{diag}(\varepsilon\circ s)$;
* `extend_rotR`, `hasChar_rotR_swap`, `signChar_rotR_swap`, `pairChar_swap`: $\sigma=$ `rotR M` carries a sign character
  $c$ to $c\circ s$, so it keeps the characters $1$ and $\varepsilon_j\varepsilon_k$;
* `act_pairMap`, **`pair_swap_even`**: $\sigma$ fixes each $\varphi_{ji}\odot\varphi_{ki}$, so through [L120Ident.lean](L120Ident.lean)'s
  `pair_block_iff` every Weyl operator of character $\varepsilon_j\varepsilon_k$ is $\sigma$-even;
* `ops_orth`: L219's identities $Q(b)+Q(c)=\theta b$, $2\,b\circ c=\theta c$ at any orthogonal frame change;
* **`Sjk_odd`**: at Weyl $D$ of character $1$ and $\nu$ of character $\varepsilon_j\varepsilon_k$ with $Q(D+\nu)=\theta(D+\nu)$,
  $2\,D^+\circ D^-=\theta D^-$ and $\nu\circ D^-=0$;
* `Sjk_nu_odd_zero`: $\nu\circ D^-=0$ on all of $\mathcal S_{jk}\cap\mathcal W_n$, critical or not, $\nu\circ D^-$ being swap-even by
  its character and swap-odd by the automorphism property.
-/

namespace HamiltonsCubic.L222Swap

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.FrameOp2 HamiltonsCubic.L222Op HamiltonsCubic.L121Block
  HamiltonsCubic.FamilyLayer HamiltonsCubic.FrameLayer

variable {n : ℕ}

/-- **The permutation matrix of the transposition `(j k)`**, `M e_b = e_{s b}`. -/
def swapM (j k : Fin n) : Matrix (Fin n) (Fin n) ℝ := Matrix.of fun a b => if a = Equiv.swap j k b then 1 else 0

theorem swapM_apply (j k a b : Fin n) : swapM j k a b = if a = Equiv.swap j k b then 1 else 0 := rfl

theorem swapM_T (j k : Fin n) : (swapM j k)ᵀ = swapM j k := by
  ext a b
  rw [transpose_apply, swapM_apply, swapM_apply]
  congr 1
  apply propext
  constructor
  · intro h; rw [h, Equiv.swap_apply_self]
  · intro h; rw [h, Equiv.swap_apply_self]

theorem swapM_sq (j k : Fin n) : swapM j k * swapM j k = 1 := by
  ext a b
  simp only [mul_apply, swapM_apply, mul_ite, mul_one, mul_zero, one_apply]
  rw [Finset.sum_ite_eq' Finset.univ (Equiv.swap j k b)]
  simp only [Finset.mem_univ, if_true, Equiv.swap_apply_self]

theorem swapM_orth (j k : Fin n) : IsOrth (swapM j k) := by
  refine ⟨?_, ?_⟩ <;> rw [swapM_T, swapM_sq]

theorem swapM_entry (j k : Fin n) (A : Matrix (Fin n) (Fin n) ℝ) (p q : Fin n) :
    (swapM j k * A * (swapM j k)ᵀ) p q = A (Equiv.swap j k p) (Equiv.swap j k q) := by
  rw [swapM_T]
  have hc : ∀ c : Fin n, (p = Equiv.swap j k c) ↔ (c = Equiv.swap j k p) := fun c => by
    constructor <;> intro h <;> rw [h, Equiv.swap_apply_self]
  simp only [mul_apply, swapM_apply, hc, ite_mul, one_mul, zero_mul, mul_ite, mul_one, mul_zero,
    Finset.sum_ite_eq', Finset.mem_univ, if_true]

theorem swapM_phi (j k a b : Fin n) :
    swapM j k * phi a b * (swapM j k)ᵀ = phi (Equiv.swap j k a) (Equiv.swap j k b) := by
  ext p q
  rw [swapM_entry]
  simp only [phi, Matrix.sub_apply, single_apply, Equiv.swap_apply_eq_iff]

theorem signMat_swapM (j k : Fin n) (ε : Fin n → ℝ) :
    signMat ε * swapM j k = swapM j k * signMat (ε ∘ Equiv.swap j k) := by
  ext a b
  simp only [signMat, diagonal_mul, mul_diagonal, swapM_apply, Function.comp]
  by_cases h : a = Equiv.swap j k b
  · rw [if_pos h, h]; ring
  · rw [if_neg h]; ring

/-- `extend` of a frame change, on skew inputs. -/
theorem extend_rotR (U : Matrix (Fin n) (Fin n) ℝ) (V : CurvOp2 (Fin n)) {Z : Matrix (Fin n) (Fin n) ℝ}
    (hZ : IsSkew Z) : extend (rotR U V) Z = U * extend V (Uᵀ * Z * U) * Uᵀ := by
  have e1 := extend_apply (rotR U V) ⟨Z, hZ⟩
  have e2 := extend_apply V (cU U ⟨Z, hZ⟩)
  rw [cU_coe] at e2
  rw [e1, rotR_coe, e2]

/-- **The swap carries a sign character to its swapped character.** -/
theorem hasChar_rotR_swap (j k : Fin n) {c : ℝ} {ε : Fin n → ℝ} {V : CurvOp2 (Fin n)}
    (h : HasChar c (signMat (ε ∘ Equiv.swap j k)) V) : HasChar c (signMat ε) (rotR (swapM j k) V) := by
  intro Z hZ
  set M := swapM j k with hMdef
  set S' := signMat (ε ∘ Equiv.swap j k) with hS'
  have hSM : signMat ε * M = M * S' := signMat_swapM j k ε
  have hMS : Mᵀ * (signMat ε)ᵀ = S'ᵀ * Mᵀ := by rw [← transpose_mul, ← transpose_mul, hSM]
  rw [extend_rotR _ _ (skew_conj hZ), extend_rotR _ _ hZ]
  have hin : Mᵀ * ((signMat ε)ᵀ * Z * signMat ε) * M = S'ᵀ * (Mᵀ * Z * M) * S' := by
    calc Mᵀ * ((signMat ε)ᵀ * Z * signMat ε) * M = (Mᵀ * (signMat ε)ᵀ) * Z * (signMat ε * M) := by
          simp only [Matrix.mul_assoc]
      _ = (S'ᵀ * Mᵀ) * Z * (M * S') := by rw [hMS, hSM]
      _ = S'ᵀ * (Mᵀ * Z * M) * S' := by simp only [Matrix.mul_assoc]
  rw [hin]
  have key := h (Mᵀ * Z * M) (skew_conj hZ)
  calc signMat ε * (M * extend V (S'ᵀ * (Mᵀ * Z * M) * S') * Mᵀ) * (signMat ε)ᵀ
      = (signMat ε * M) * extend V (S'ᵀ * (Mᵀ * Z * M) * S') * (Mᵀ * (signMat ε)ᵀ) := by
        simp only [Matrix.mul_assoc]
    _ = M * (S' * extend V (S'ᵀ * (Mᵀ * Z * M) * S') * S'ᵀ) * Mᵀ := by
        rw [hSM, hMS]; simp only [Matrix.mul_assoc]
    _ = M * (c • extend V (Mᵀ * Z * M)) * Mᵀ := by rw [key]
    _ = c • (M * extend V (Mᵀ * Z * M) * Mᵀ) := by rw [Matrix.mul_smul, Matrix.smul_mul]

theorem signChar_rotR_swap (j k : Fin n) {c : (Fin n → ℝ) → ℝ} {V : CurvOp2 (Fin n)} (h : SignChar c V)
    (hc : ∀ ε : Fin n → ℝ, (∀ i, ε i * ε i = 1) → c (ε ∘ Equiv.swap j k) = c ε) :
    SignChar c (rotR (swapM j k) V) := fun ε hε => by
  have h1 := h (ε ∘ Equiv.swap j k) (fun i => hε _)
  rw [hc ε hε] at h1
  exact hasChar_rotR_swap j k h1

theorem pairChar_swap {j k : Fin n} (hjk : j ≠ k) (ε : Fin n → ℝ) :
    setChar {j, k} (ε ∘ Equiv.swap j k) = setChar {j, k} ε := by
  rw [setChar_pair hjk, setChar_pair hjk]
  simp only [Function.comp, Equiv.swap_apply_left, Equiv.swap_apply_right]
  ring

/-- **The swap fixes the pair summand**: each `φ_{ji} ⊙ φ_{ki}` goes to `φ_{ki} ⊙ φ_{ji}`. -/
theorem act_pairMap {j k : Fin n} (c : Fin n → ℝ) : act (swapM j k) (pairMap j k c) = pairMap j k c := by
  set M := swapM j k with hMdef
  have hMo := swapM_orth j k
  refine LinearMap.ext fun Z => ?_
  rw [act_apply]
  show M * pairLin j k c (HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) (Mᵀ * Z * M)) * Mᵀ
    = pairLin j k c (HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) Z)
  have hsk : HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) (Mᵀ * Z * M)
      = Mᵀ * HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) Z * M := by
    show (1 / 2 : ℝ) • (Mᵀ * Z * M - (Mᵀ * Z * M)ᵀ) = Mᵀ * ((1 / 2 : ℝ) • (Z - Zᵀ)) * M
    rw [transpose_mul, transpose_mul, transpose_transpose, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_sub,
      Matrix.sub_mul]
    simp only [Matrix.mul_assoc]
  rw [hsk]
  set Y := HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) Z
  rw [pairLin_apply, pairLin_apply, Finset.mul_sum, Finset.sum_mul]
  refine Finset.sum_congr rfl fun i hi => ?_
  obtain ⟨hji, hki⟩ := (Finset.mem_filter.mp hi).2
  have p1 : M * phi j i * Mᵀ = phi k i := by
    rw [swapM_phi, Equiv.swap_apply_left, Equiv.swap_apply_of_ne_of_ne (Ne.symm hji) (Ne.symm hki)]
  have p2 : M * phi k i * Mᵀ = phi j i := by
    rw [swapM_phi, Equiv.swap_apply_right, Equiv.swap_apply_of_ne_of_ne (Ne.symm hji) (Ne.symm hki)]
  have hMT : Mᵀ = M := swapM_T j k
  have q1 : inner2 (phi k i) (Mᵀ * Y * M) = inner2 (phi j i) Y := by
    have e := FrameLayer.inner2_conj hMo (phi j i) Y
    rw [hMT] at e p1
    rw [hMT, ← e, p1]
  have q2 : inner2 (phi j i) (Mᵀ * Y * M) = inner2 (phi k i) Y := by
    have e := FrameLayer.inner2_conj hMo (phi k i) Y
    rw [hMT] at e p2
    rw [hMT, ← e, p2]
  unfold rk2
  rw [q1, q2, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_add, Matrix.add_mul, Matrix.mul_smul, Matrix.smul_mul,
    Matrix.mul_smul, Matrix.smul_mul, p1, p2]
  module

/-- **Every Weyl operator of character `ε_j ε_k` is swap-even**: the swap `σ` of `j` and `k` fixes it. -/
theorem pair_swap_even {j k : Fin n} (hjk : j ≠ k) {V : CurvOp2 (Fin n)} (hV : IsWeyl2 V)
    (h : SignChar (setChar {j, k}) V) : rotR (swapM j k) V = V := by
  obtain ⟨c, -, he⟩ := Submodule.mem_map.mp ((HamiltonsCubic.L120Ident.pair_block_iff hjk V hV).mp h)
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  have e1 := extend_rotR (swapM j k) V X.2
  rw [extend_apply] at e1
  rw [e1, ← extend_apply V X]
  have := congrArg (fun L : CurvLin (Fin n) => L (X : Matrix (Fin n) (Fin n) ℝ)) (act_pairMap (j := j) (k := k) c)
  simp only [act_apply] at this
  rw [he] at this
  exact this

/-- **L219's operator identities at any orthogonal frame change** `σ = rotR U`, with `b, c = ½(W ± σW)`. -/
theorem ops_orth {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W) {θ : ℝ}
    (hQ : Qop2 W = θ • W) :
    Qop2 ((1 / 2 : ℝ) • (W + rotR U W)) + Qop2 ((1 / 2 : ℝ) • (W - rotR U W)) = θ • ((1 / 2 : ℝ) • (W + rotR U W)) ∧
      (2 : ℝ) • foxProd2 ((1 / 2 : ℝ) • (W + rotR U W)) ((1 / 2 : ℝ) • (W - rotR U W))
        = θ • ((1 / 2 : ℝ) • (W - rotR U W)) := by
  set b : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (W + rotR U W) with hbdef
  set c : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (W - rotR U W) with hcdef
  have hbc : b + c = W := by rw [hbdef, hcdef]; module
  have hbmc : b - c = rotR U W := by rw [hbdef, hcdef]; module
  have hσ : Qop2 (rotR U W) = θ • rotR U W := by rw [L219GenOps.Qop2_rotR hU hW, hQ, LinearMap.map_smul]
  have E1 : θ • (b + c) = Qop2 b + Qop2 c + (2 : ℝ) • foxProd2 b c := by rw [← L219Prod.Qop2_add, hbc, hQ]
  have E2 : θ • (b - c) = Qop2 b + Qop2 c - (2 : ℝ) • foxProd2 b c := by rw [← L219Prod.Qop2_sub, hbmc, hσ]
  refine ⟨?_, ?_⟩
  · calc Qop2 b + Qop2 c
        = (1 / 2 : ℝ) • ((Qop2 b + Qop2 c + (2 : ℝ) • foxProd2 b c) + (Qop2 b + Qop2 c - (2 : ℝ) • foxProd2 b c)) := by
          module
      _ = (1 / 2 : ℝ) • (θ • (b + c) + θ • (b - c)) := by rw [← E1, ← E2]
      _ = θ • b := by module
  · calc (2 : ℝ) • foxProd2 b c
        = (1 / 2 : ℝ) • ((Qop2 b + Qop2 c + (2 : ℝ) • foxProd2 b c) - (Qop2 b + Qop2 c - (2 : ℝ) • foxProd2 b c)) := by
          module
      _ = (1 / 2 : ℝ) • (θ • (b + c) - θ • (b - c)) := by rw [← E1, ← E2]
      _ = θ • c := by module

/-- **L222 (3), the odd part**: at a critical `W = D + ν` on `𝒮_jk`, with `D^±` the even and odd parts of `D` under the
swap `σ` of `j` and `k`, `2 L_{D^+} D^- = θ D^-`, and `ν ∘ D^- = 0`. -/
theorem Sjk_odd {j k : Fin n} (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν) {θ : ℝ} (hQ : Qop2 (D + ν) = θ • (D + ν)) :
    (2 : ℝ) • foxProd2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) ((1 / 2 : ℝ) • (D - rotR (swapM j k) D))
        = θ • ((1 / 2 : ℝ) • (D - rotR (swapM j k) D)) ∧
      foxProd2 ν ((1 / 2 : ℝ) • (D - rotR (swapM j k) D)) = 0 := by
  have hW := isWeyl2_add hDW hνW
  obtain ⟨-, hops⟩ := ops_orth (swapM_orth j k) (D + ν) hW hQ
  have hσν : rotR (swapM j k) ν = ν := pair_swap_even hjk hνW hν
  have hσW : rotR (swapM j k) (D + ν) = rotR (swapM j k) D + ν := by rw [LinearMap.map_add, hσν]
  rw [hσW] at hops
  set σD := rotR (swapM j k) D with hσDdef
  set Dp : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (D + σD) with hDpdef
  set Dm : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (D - σD) with hDmdef
  have hb : (1 / 2 : ℝ) • (D + ν + (σD + ν)) = Dp + ν := by rw [hDpdef]; module
  have hc : (1 / 2 : ℝ) • (D + ν - (σD + ν)) = Dm := by rw [hDmdef]; module
  rw [hb, hc, foxProd2_add_left] at hops
  have hσD : SignChar (fun _ => 1) σD := signChar_rotR_swap j k hD fun _ _ => rfl
  have hDp : SignChar (fun _ => 1) Dp := signChar_smul (signChar_add hD hσD) _
  have hDm : SignChar (fun _ => 1) Dm := by
    have h1 := signChar_add hD (signChar_smul hσD (-1))
    rw [show D + (-1 : ℝ) • σD = D - σD by module] at h1
    exact signChar_smul h1 _
  have hA : SignChar (fun _ => 1) ((2 : ℝ) • foxProd2 Dp Dm + (-1 : ℝ) • (θ • Dm)) :=
    signChar_add (signChar_smul (signChar_congr (foxProd2_char2 hDp hDm) fun _ _ => by ring) _)
      (signChar_smul (signChar_smul hDm _) _)
  have hB : SignChar (setChar {j, k}) ((2 : ℝ) • foxProd2 ν Dm) :=
    signChar_smul (signChar_congr (foxProd2_char2 hν hDm) fun _ _ => by ring) _
  have hsum : ((2 : ℝ) • foxProd2 Dp Dm + (-1 : ℝ) • (θ • Dm)) + (2 : ℝ) • foxProd2 ν Dm = 0 := by
    calc ((2 : ℝ) • foxProd2 Dp Dm + (-1 : ℝ) • (θ • Dm)) + (2 : ℝ) • foxProd2 ν Dm
        = (2 : ℝ) • (foxProd2 Dp Dm + foxProd2 ν Dm) + (-1 : ℝ) • (θ • Dm) := by module
      _ = θ • Dm + (-1 : ℝ) • (θ • Dm) := by rw [hops]
      _ = 0 := by module
  obtain ⟨h1, h2⟩ := char_split_zero hjk hA hB hsum
  refine ⟨?_, ?_⟩
  · calc (2 : ℝ) • foxProd2 Dp Dm = ((2 : ℝ) • foxProd2 Dp Dm + (-1 : ℝ) • (θ • Dm)) + θ • Dm := by module
      _ = θ • Dm := by rw [h1]; module
  · calc foxProd2 ν Dm = (1 / 2 : ℝ) • ((2 : ℝ) • foxProd2 ν Dm) := by module
      _ = 0 := by rw [h2]; module

/-- **`ν ∘ D^- = 0` on all of `𝒮_jk ∩ 𝒲ₙ`, critical or not**: `ν ∘ D^-` has character `ε_j ε_k`, so it is swap-even
(`pair_swap_even`), and it is swap-odd since `σ` is an automorphism of `∘` fixing `ν` and negating `D^-`. -/
theorem Sjk_nu_odd_zero {j k : Fin n} (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν) :
    foxProd2 ν ((1 / 2 : ℝ) • (D - rotR (swapM j k) D)) = 0 := by
  have hM := swapM_orth j k
  set σD := rotR (swapM j k) D with hσDdef
  set Dm : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (D - σD) with hDmdef
  have hσDW : IsWeyl2 σD := rotR_isWeyl2 hM hDW
  have hDmW : IsWeyl2 Dm := by
    have e : Dm = (1 / 2 : ℝ) • (D + (-1 : ℝ) • σD) := by rw [hDmdef]; module
    rw [e]; exact isWeyl2_smul _ (isWeyl2_add hDW (isWeyl2_smul _ hσDW))
  have hσσ : rotR (swapM j k) σD = D := by
    rw [hσDdef, L219GenOps.rotR_comp, swapM_sq, L219GenOps.rotR_one]
  have hσDm : rotR (swapM j k) Dm = -Dm := by
    have e : Dm = (1 / 2 : ℝ) • D + (-(1 / 2) : ℝ) • σD := by rw [hDmdef]; module
    rw [e, LinearMap.map_add, LinearMap.map_smul, LinearMap.map_smul, hσσ]
    module
  have hσν : rotR (swapM j k) ν = ν := pair_swap_even hjk hνW hν
  have hDm : SignChar (fun _ => 1) Dm := by
    have hσD : SignChar (fun _ => 1) σD := signChar_rotR_swap j k hD fun _ _ => rfl
    have h1 := signChar_add hD (signChar_smul hσD (-1))
    rw [show D + (-1 : ℝ) • σD = D - σD by module] at h1
    exact signChar_smul h1 _
  have hX : SignChar (setChar {j, k}) (foxProd2 ν Dm) :=
    signChar_congr (foxProd2_char2 hν hDm) fun _ _ => by ring
  have heven := pair_swap_even hjk (isWeyl2_foxProd2 hνW hDmW) hX
  rw [← L219GenOps.foxProd2_rotR hM hνW hDmW, hσν, hσDm] at heven
  have hneg : foxProd2 ν (-Dm) = (-1 : ℝ) • foxProd2 ν Dm := by
    rw [show -Dm = (-1 : ℝ) • Dm by module, foxProd2_smul_right]
  rw [hneg] at heven
  have h2 : (2 : ℝ) • foxProd2 ν Dm = 0 := by
    calc (2 : ℝ) • foxProd2 ν Dm = foxProd2 ν Dm - (-1 : ℝ) • foxProd2 ν Dm := by module
      _ = 0 := by rw [heven]; module
  calc foxProd2 ν Dm = (1 / 2 : ℝ) • ((2 : ℝ) • foxProd2 ν Dm) := by module
    _ = 0 := by rw [h2]; module

end HamiltonsCubic.L222Swap
