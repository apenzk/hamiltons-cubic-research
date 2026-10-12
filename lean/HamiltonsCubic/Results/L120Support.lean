import Mathlib
import HamiltonsCubic.Results.L120Decomp

set_option linter.style.longLine false

/-!
# L120, which blocks are nonzero: $\lvert t\rvert\in\{0,2,4\}$

[L120Decomp.lean](L120Decomp.lean) splits $W^\perp$ over all index sets $t$, the block of $t$ carrying the sign
character $\varepsilon\mapsto\prod_{i\in t}\varepsilon_i$. The record's decomposition has blocks at $t=\varnothing$,
the pairs and the four-sets only ([findings/second-order.md](../../../findings/second-order.md), Lemma L120). This
file proves that every other block is zero, on `CurvOp2`:

* `coord_char`: a nonzero coordinate $\langle V\varphi_{ab},\varphi_{cd}\rangle$ of an operator with character $c$
  forces $c(\varepsilon)=\varepsilon_a\varepsilon_b\varepsilon_c\varepsilon_d$ at every sign vector;
* `block_card`: so an operator on $\Lambda^2$ with character $\prod_{i\in t}\varepsilon_i$ is zero unless
  $\lvert t\rvert\in\{0,2,4\}$, the global flip $\varepsilon=-\mathbf 1$ making $\lvert t\rvert$ even and a single
  flip outside $\{a,b,c,d\}$ putting $t$ inside it;
* `comp_zero`: the isotypic components of `L120Decomp` vanish off $\lvert t\rvert\in\{0,2,4\}$.
-/

namespace HamiltonsCubic.L120Support

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.L120Decomp

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **A nonzero coordinate fixes the character**: `c ε = ε_a ε_b ε_c ε_d`. -/
theorem coord_char {c : (ι → ℝ) → ℝ} {V : CurvOp2 ι} (hV : SignChar c V) {a b p q : ι}
    (hx : inner2 (applyPhi V a b) (phi p q) ≠ 0) (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) :
    c ε = ε a * ε b * ε p * ε q := by
  have h1 := char_phi hε (hV ε hε) a b
  have e := Results.inner2_conj (signMat ε) (applyPhi V a b) (phi p q)
  rw [h1, signConj_phi, FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_right] at e
  have hx' : c ε * (ε a * ε b) = ε p * ε q := mul_right_cancel₀ hx e
  have hab := sq_sign ε hε a b
  calc c ε = c ε * (ε a * ε b) * (ε a * ε b) := by rw [mul_assoc, hab, mul_one]
    _ = ε a * ε b * ε p * ε q := by rw [hx']; ring

/-- An operator on `Λ²` with every coordinate zero is zero. -/
theorem eq_zero_of_coords {V : CurvOp2 ι} (h : ∀ a b p q, inner2 (applyPhi V a b) (phi p q) = 0) : V = 0 := by
  apply normSq2_eq_zero
  have hz : ∀ a b, applyPhi V a b = 0 := by
    intro a b
    ext p q
    have e := inner2_phi (applyPhi V a b) (V ⟨phi a b, phi_mem_skewSub a b⟩).2 p q
    rw [h a b p q] at e
    simp only [Matrix.zero_apply]
    linarith
  unfold normSq2 innerOp2
  simp [hz, inner2_eq_sum]

omit [Fintype ι] in
theorem card_four_le (a b p q : ι) : ({a, b, p, q} : Finset ι).card ≤ 4 := by
  have h1 := Finset.card_insert_le a ({b, p, q} : Finset ι)
  have h2 := Finset.card_insert_le b ({p, q} : Finset ι)
  have h3 := Finset.card_insert_le p ({q} : Finset ι)
  rw [Finset.card_singleton] at h3
  omega

/-- **Only the blocks at `|t| ∈ {0, 2, 4}` are nonzero.** -/
theorem block_card {t : Finset ι} {V : CurvOp2 ι} (hV : SignChar (setChar t) V) (h0 : V ≠ 0) :
    t.card = 0 ∨ t.card = 2 ∨ t.card = 4 := by
  obtain ⟨a, b, p, q, hx⟩ : ∃ a b p q, inner2 (applyPhi V a b) (phi p q) ≠ 0 := by
    by_contra hall
    push Not at hall
    exact h0 (eq_zero_of_coords hall)
  -- evenness, from the global flip
  have heven : Even t.card := by
    have h := coord_char hV hx (fun _ => -1) (fun _ => by norm_num)
    simp only [setChar, Finset.prod_const] at h
    norm_num at h
    exact (neg_one_pow_eq_one_iff_even (by norm_num)).mp h
  -- `t ⊆ {a, b, p, q}`, from single flips
  have hsub : t ⊆ {a, b, p, q} := by
    intro m hm
    by_contra hout
    simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hout
    obtain ⟨ha, hb, hp, hq⟩ := hout
    have h := coord_char hV hx (fun i => if i = m then -1 else 1) (fun i => by beta_reduce; split_ifs <;> norm_num)
    simp only [setChar, Finset.prod_ite_eq', if_pos hm, if_neg (Ne.symm ha), if_neg (Ne.symm hb),
      if_neg (Ne.symm hp), if_neg (Ne.symm hq)] at h
    norm_num at h
  have hle := (Finset.card_le_card hsub).trans (card_four_le a b p q)
  obtain ⟨r, hr⟩ := heven
  omega

/-- **The isotypic components of `W^⊥` vanish off `|t| ∈ {0, 2, 4}`.** -/
theorem comp_zero (t : Finset ι) (R : CurvOp2 ι) (h : IsWeyl2 R)
    (ht : ¬ (t.card = 0 ∨ t.card = 2 ∨ t.card = 4)) : comp t R h = 0 := by
  by_contra h0
  exact ht (block_card (comp_char t R h) h0)

end HamiltonsCubic.L120Support
