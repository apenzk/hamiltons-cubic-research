import Mathlib
import HamiltonsCubic.Results.L219Op
import HamiltonsCubic.Results.L120Ident

set_option linter.style.longLine false

/-!
# L219's diagonality clause: a Weyl operator is coordinate-diagonal exactly when every coordinate reflection fixes it

[findings/second-order.md](../../../findings/second-order.md), Lemma L219: *$W$ is coordinate-diagonal in an orthonormal frame
exactly when its $\sigma_{e_k}$-odd part vanishes for $k=1,\dots,n-1$, the last reflection being redundant since $-I$ acts
trivially.* In the coordinate frame, on `CurvOp2`:

* `hasChar_of_sig`, `sig_of_hasChar`: $\sigma_{e_k}W=W$ is `HasChar 1 (flip k) W`, the reflection's action on $\Lambda^2$ being
  conjugation of the extension;
* **`diagonal_iff_even`**: a Weyl operator on $\Lambda^2$ is fixed by every coordinate reflection, equivalently has zero
  $\sigma_{e_k}$-odd part $\tfrac12(W-\sigma_{e_k}W)$ for every $k$, exactly when it is `restrict (diagOp w)` for a weight $w$;
  a product of flips is every sign matrix (`act_diag_set`), and [L120Ident.lean](L120Ident.lean)'s `trivial_block_iff` does
  the rest;
* `sig_of_others`, `diagonal_iff_even_but_one`: the record's $n-1$ reflections suffice, $-I$ acting trivially;
* `sig_isWeyl2`, `even_odd_isWeyl2`: the reflection preserves $\mathcal W_n$, so $b,c\in\mathcal W_n$.
-/

namespace HamiltonsCubic.L219Diag

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120HessPair HamiltonsCubic.L120Ident HamiltonsCubic.L219Op HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem hasChar_of_sig (k : ι) (V : CurvOp2 ι) (h : sig k V = V) : HasChar 1 (Results.flip k) V := by
  intro Z hZ
  have e1 := extend_apply V (cS k ⟨Z, hZ⟩)
  rw [cS_coe] at e1
  have e2 := extend_apply V ⟨Z, hZ⟩
  have e3 : ((sig k V ⟨Z, hZ⟩ : skewSub ι) : Matrix ι ι ℝ) = ((V ⟨Z, hZ⟩ : skewSub ι) : Matrix ι ι ℝ) := by rw [h]
  rw [sig_apply, cS_coe] at e3
  show Results.flip k * extend V ((Results.flip k)ᵀ * Z * Results.flip k) * (Results.flip k)ᵀ = (1 : ℝ) • extend V Z
  rw [one_smul, e1, e2, ← e3, flip_T]

theorem sig_of_hasChar (k : ι) (V : CurvOp2 ι) (h : HasChar 1 (Results.flip k) V) : sig k V = V := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  have hX : IsSkew (X : Matrix ι ι ℝ) := X.2
  have e := h (X : Matrix ι ι ℝ) hX
  have e1 := extend_apply V (cS k X)
  rw [cS_coe] at e1
  have e2 := extend_apply V X
  rw [e1, e2, one_smul] at e
  rw [sig_apply, cS_coe]
  rw [flip_T] at e ⊢
  exact e

/-- **The reflection preserves `𝒲ₙ`**: `sig k V` is the restriction of the `O(n)`-translate of `V`'s extension, which
stays in `weylModuleS` (`act_mem`). -/
theorem sig_isWeyl2 (k : ι) {V : CurvOp2 ι} (hV : IsWeyl2 V) : IsWeyl2 (sig k V) := by
  have hB := HamiltonsCubic.L120Decomp.extendL_mem hV
  have hA := act_mem (Results.flip k) (Results.flip_orth k) _ hB
  have hW : IsWeyl (fun X => act (Results.flip k) (extendL V) X) := hA.1
  have e : RealLayer.restrict hW = sig k V := by
    refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
    rw [RealLayer.restrict_apply, act_apply, sig_apply, cS_coe]
    have e1 := extend_apply V (cS k X)
    rw [cS_coe] at e1
    show Results.flip k * extend V ((Results.flip k)ᵀ * (X : Matrix ι ι ℝ) * Results.flip k) * (Results.flip k)ᵀ = _
    rw [e1, flip_T]
  rw [← e]
  exact isWeyl2_restrict hW

/-- **So the even and odd parts of a Weyl operator are Weyl.** -/
theorem even_odd_isWeyl2 (k : ι) {V : CurvOp2 ι} (hV : IsWeyl2 V) :
    IsWeyl2 ((1 / 2 : ℝ) • (V + sig k V)) ∧ IsWeyl2 ((1 / 2 : ℝ) • (V - sig k V)) := by
  have hs := sig_isWeyl2 k hV
  refine ⟨isWeyl2_smul _ (isWeyl2_add hV hs), ?_⟩
  have e : V - sig k V = V + (-1 : ℝ) • sig k V := by module
  rw [e]
  exact isWeyl2_smul _ (isWeyl2_add hV (isWeyl2_smul _ hs))

variable {n : ℕ}

/-- **L219's diagonality clause, in the coordinate frame.** A Weyl operator on `Λ²` has zero `σ_{e_k}`-odd part for every
`k` exactly when it is the diagonal operator of a weight. -/
theorem diagonal_iff_even (V : CurvOp2 (Fin n)) (hV : IsWeyl2 V) :
    (∀ k, (1 / 2 : ℝ) • (V - sig k V) = 0) ↔
      ∃ (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w), V = RealLayer.restrict (diagOp_isWeyl hw) := by
  have hodd : ∀ k, (1 / 2 : ℝ) • (V - sig k V) = 0 ↔ sig k V = V := fun k => by
    constructor
    · intro h
      have hz : V - sig k V = 0 := by
        have e : V - sig k V = (2 : ℝ) • ((1 / 2 : ℝ) • (V - sig k V)) := by module
        rw [e, h]; module
      calc sig k V = V - (V - sig k V) := by module
        _ = V - 0 := by rw [hz]
        _ = V := by module
    · intro h
      rw [h]
      module
  simp only [hodd]
  rw [← trivial_block_iff V hV, signChar_iff_act]
  constructor
  · intro h ε hε
    have hflip : ∀ m, act (Results.flip m) (extendL V) = (fun _ => (1 : ℝ)) m • extendL V := fun m => by
      rw [act_extendL (hasChar_of_sig m V (h m))]
    rw [signMat_eq_diag_set ε hε, act_diag_set _ _ hflip, Finset.prod_const_one]
  · intro h k
    refine sig_of_hasChar k V ?_
    have hs : ∀ i, Results.sgn k i * Results.sgn k i = 1 := Results.sgn_mul_self k
    have e : Results.flip k = signMat (Results.sgn k) := rfl
    intro Z hZ
    have := congrArg (fun L : CurvLin (Fin n) => L Z) (h (Results.sgn k) hs)
    simp only [act_apply, LinearMap.smul_apply] at this
    rw [e]
    exact this

theorem act_neg_one (R : CurvLin (Fin n)) : act (-1 : Matrix (Fin n) (Fin n) ℝ) R = R := by
  apply LinearMap.ext
  intro Z
  simp [act_apply]

theorem act_diag_set_fix (B : CurvLin (Fin n)) (s : Finset (Fin n))
    (h : ∀ m ∈ s, act (Results.flip m) B = B) : act (diagSet s) B = B := by
  induction s using Finset.induction_on with
  | empty =>
      have : diagSet (∅ : Finset (Fin n)) = 1 := by unfold diagSet; simp [Matrix.diagonal_one]
      rw [this, act_one]
  | insert a s ha ih =>
      have hd : diagSet (insert a s) = Results.flip a * diagSet s := by
        unfold diagSet Results.flip
        rw [Matrix.diagonal_mul_diagonal]
        congr 1
        funext i
        by_cases hi : i = a
        · subst hi; simp [ha]
        · simp [hi]
      rw [hd, ← act_comp, ih fun m hm => h m (Finset.mem_insert_of_mem hm), h a (Finset.mem_insert_self a s)]

/-- **The last reflection is redundant**, `−I` acting trivially: fixing every flip but one fixes that one too. -/
theorem sig_of_others (V : CurvOp2 (Fin n)) (k0 : Fin n) (h : ∀ k, k ≠ k0 → sig k V = V) : sig k0 V = V := by
  refine sig_of_hasChar k0 V fun Z hZ => ?_
  have hflip : Results.flip k0 = diagSet Finset.univ * diagSet (Finset.univ.erase k0) := by
    unfold diagSet Results.flip
    rw [Matrix.diagonal_mul_diagonal]
    congr 1
    funext i
    by_cases hi : i = k0
    · subst hi; simp
    · simp [hi]
  have hU : diagSet (Finset.univ : Finset (Fin n)) = -1 := by
    unfold diagSet; ext i j; by_cases hij : i = j <;> simp [Matrix.diagonal_apply, hij]
  have hrest : act (diagSet (Finset.univ.erase k0)) (extendL V) = extendL V :=
    act_diag_set_fix _ _ fun m hm => by
      rw [act_extendL (hasChar_of_sig m V (h m (Finset.ne_of_mem_erase hm))), one_smul]
  have hk0 : act (Results.flip k0) (extendL V) = extendL V := by
    rw [hflip, ← act_comp, hrest, hU, act_neg_one]
  have := congrArg (fun L : CurvLin (Fin n) => L Z) hk0
  simp only [act_apply] at this
  rw [one_smul]
  exact this

/-- **L219's diagonality clause with `n − 1` reflections**: zero `σ_{e_k}`-odd part for every `k ≠ k₀` already makes a
Weyl operator on `Λ²` diagonal. -/
theorem diagonal_iff_even_but_one (V : CurvOp2 (Fin n)) (hV : IsWeyl2 V) (k0 : Fin n) :
    (∀ k, k ≠ k0 → (1 / 2 : ℝ) • (V - sig k V) = 0) ↔
      ∃ (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w), V = RealLayer.restrict (diagOp_isWeyl hw) := by
  rw [← diagonal_iff_even V hV]
  have hodd : ∀ k, (1 / 2 : ℝ) • (V - sig k V) = 0 ↔ sig k V = V := fun k => by
    constructor
    · intro h
      have hz : V - sig k V = 0 := by
        have e : V - sig k V = (2 : ℝ) • ((1 / 2 : ℝ) • (V - sig k V)) := by module
        rw [e, h]; module
      calc sig k V = V - (V - sig k V) := by module
        _ = V - 0 := by rw [hz]
        _ = V := by module
    · intro h
      rw [h]
      module
  simp only [hodd]
  exact ⟨fun h k => if hk : k = k0 then hk ▸ sig_of_others V k0 h else h k hk, fun h k _ => h k⟩

end HamiltonsCubic.L219Diag
