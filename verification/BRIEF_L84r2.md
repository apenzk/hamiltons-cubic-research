# Brief, round L84

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict on this result is included.**

## Passage A, the heading and statement ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 38 and 42)

#### Lemma L84, Casimir separation is forced, the pair $(C_2,C_4)$ with $C_4$ a quartic generator separates all $24$

**Statement.** Let $C_2$ be the quadratic Casimir of $\mathfrak{so}(5)$ and $C_4$ a central element of degree four in $U(\mathfrak{so}(5))$ with $C_4\notin\mathbb R[C_2]$. Then the pair of eigenvalues $\big(\chi_\lambda(C_2),\chi_\lambda(C_4)\big)$ determines every dominant $B_2$ weight $\lambda$, and in particular separates the $24$ labels of Observation L83. *It is an $SO(5)$ statement about labels, and it does not depend on that table's multiplicities.*

## Passage B, the proof section ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 44-50)

## Separation of the blocks, which is a theorem

The degree-two Casimir takes **$21$** distinct values across the $24$ blocks, $24$ less the three colliding pairs: $(4,1)$ with $(3,3)$ at $30$, $(4,3)$ with $(5,0)$ at $40$, and $(5,4)$ with $(6,2)$ at $60$.

**Proof.** By the Harish-Chandra isomorphism a central element $z$ acts on $V_\lambda$ by $\gamma(z)(\ell)$, $\ell=\lambda+\rho$, $\rho=(\tfrac32,\tfrac12)$, where $\gamma(z)$ is a $W(B_2)$-invariant polynomial, $\gamma$ is injective, and the $W(B_2)$-invariants are $\mathbb R[p_2,p_4]$ with $p_{2k}(\ell)=\ell_1^{2k}+\ell_2^{2k}$. So $\chi_\lambda(C_2)=p_2(\ell)-\tfrac52=c_2(\lambda)$, and $\gamma(C_4)=a\,p_4+b\,p_2^2+c\,p_2+d$ with $a\ne0$, since $a=0$ would put $\gamma(C_4)$ in $\gamma(\mathbb R[C_2])$ and, $\gamma$ being injective, $C_4$ in $\mathbb R[C_2]$. Hence $\big(\chi_\lambda(C_2),\chi_\lambda(C_4)\big)$ determines $\big(p_2(\ell),p_4(\ell)\big)$. For a dominant weight $\ell_1>\ell_2>0$, so $e_1=p_2$ and $e_2=(p_2^2-p_4)/2$ recover $\{\ell_1^2,\ell_2^2\}$ as a multiset, hence $\ell$ and $\lambda$. $\square$ **No quartic generator is distinguished, and every one serves.** On the three pairs $p_4$ reads $7361/8$ against $4481/8$, $8521/8$ against $14281/8$, and $17561/8$ against $25625/8$.

**The generator condition is needed.** $C_2^2$ is a central element of degree four lying in $\mathbb R[C_2]$, and it separates none of the three colliding pairs, reading $(30,900)$ on both $(4,1)$ and $(3,3)$.

## Passage C, the canonical statement ([results.md](../results.md) line 289, landscape, and lines 977 and 979, detail)

- **Lemma L84 (landscape). Casimir separation is forced.** $C_2$ and any quartic central generator $C_4\notin\mathbb R[C_2]$ together separate every dominant $B_2$ weight, through the Harish-Chandra isomorphism onto $\mathbb R[p_2,p_4]$. On the $24$ labels of Observation L83, $C_2$ alone takes $21$ values.

##### Lemma L84, Casimir separation is forced

Let $C_2$ be the quadratic Casimir of $\mathfrak{so}(5)$ and $C_4$ a central element of degree four not in $\mathbb R[C_2]$. Then $\big(\chi_\lambda(C_2),\chi_\lambda(C_4)\big)$ determines the dominant weight $\lambda$: the Harish-Chandra isomorphism carries both to $W(B_2)$-invariants of $\ell=\lambda+\rho$, in which $\chi_\lambda(C_4)$ carries $p_4$ with a nonzero coefficient, and $\ell_1>\ell_2>0$ lets $(p_2,p_4)$ recover $\ell$. The condition is needed: $C_2^2$ reads $(30,900)$ on both $(4,1)$ and $(3,3)$. On the $24$ labels of Observation L83, $c_2$ takes $21$ values with collisions at $30$, $40$ and $60$, which $p_4$ separates. The separation holds for every dominant weight and does not depend on the table's multiplicities.

## Passage D, the $24$-block table, a given ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 23-32)

## The 24 blocks

The dimension and Casimir columns are arithmetic on the highest weights: the Weyl dimension formula for $B_2$ is a product of four linear factors, and $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$. The weight list and the multiplicities come from the character computation. [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py).

| mult | blocks (highest weight, dimension) | unknowns |
|---|---|---|
| $4$ | $(4,2)_{220}$, $(2,2)_{35}$ | $20$ |
| $3$ | $(3,2)_{105}$ | $6$ |
| $2$ | $(5,2)_{390}$, $(4,3)_{231}$, $(4,4)_{165}$, $(4,1)_{154}$, $(3,1)_{81}$, $(4,0)_{55}$, $(2,1)_{35}$, $(3,0)_{30}$, $(2,0)_{14}$ | $27$ |
| $1$ | $(6,6)_{455}$, $(6,4)_{810}$, $(6,3)_{770}$, $(6,2)_{625}$, $(6,0)_{140}$, $(5,4)_{429}$, $(5,3)_{455}$, $(5,1)_{260}$, $(5,0)_{91}$, $(3,3)_{84}$, $(1,0)_{5}$, $(0,0)_{1}$ | $12$ |

## Passage E, the Lean files, declarations with docstrings removed ([L84Statement.lean](../lean/HamiltonsCubic/Results/L84Statement.lean), [L84.lean](../lean/HamiltonsCubic/Results/L84.lean))

```lean
import Mathlib
import HamiltonsCubic.Results.L83

set_option linter.style.longLine false

namespace HamiltonsCubic.L84Statement

open HamiltonsCubic.Blocks

def ell1 (a : ℕ) : ℚ := (a : ℚ) + 3 / 2

def ell2 (b : ℕ) : ℚ := (b : ℚ) + 1 / 2

def p2 (a b : ℕ) : ℚ := ell1 a ^ 2 + ell2 b ^ 2

def p4 (a b : ℕ) : ℚ := ell1 a ^ 4 + ell2 b ^ 4

def c2Q (a b : ℕ) : ℚ := (a : ℚ) * (a + 3) + (b : ℚ) * (b + 1)

theorem rho_strictly_dominant {a b : ℕ} (hab : b ≤ a) : 0 < ell2 b ∧ ell2 b < ell1 a := by
  have : (b : ℚ) ≤ (a : ℚ) := by exact_mod_cast hab
  constructor
  · unfold ell2; positivity
  · unfold ell1 ell2; linarith

theorem p2_eq_c2_add (a b : ℕ) : p2 a b = c2Q a b + 5 / 2 := by
  unfold p2 c2Q ell1 ell2; ring

private theorem sq_eq_of_pos {x y : ℚ} (hx : 0 < x) (hy : 0 < y) (h : x ^ 2 = y ^ 2) : x = y := by
  have hfac : (x - y) * (x + y) = 0 := by linear_combination h
  rcases mul_eq_zero.mp hfac with h' | h'
  · linarith
  · linarith

theorem pair_separates {l1 l2 m1 m2 : ℚ} (hl2 : 0 < l2) (hl : l2 < l1) (hm2 : 0 < m2)
    (hm : m2 < m1) (h2 : l1 ^ 2 + l2 ^ 2 = m1 ^ 2 + m2 ^ 2)
    (h4 : l1 ^ 4 + l2 ^ 4 = m1 ^ 4 + m2 ^ 4) : l1 = m1 ∧ l2 = m2 := by
  have hl1 : 0 < l1 := lt_trans hl2 hl
  have hm1 : 0 < m1 := lt_trans hm2 hm
  have hprod : l1 ^ 2 * l2 ^ 2 = m1 ^ 2 * m2 ^ 2 := by nlinarith [h2, h4]
  have hd1 : 0 < l1 ^ 2 - l2 ^ 2 := by nlinarith
  have hd2 : 0 < m1 ^ 2 - m2 ^ 2 := by nlinarith
  have hdiff : (l1 ^ 2 - l2 ^ 2) ^ 2 = (m1 ^ 2 - m2 ^ 2) ^ 2 := by nlinarith [h2, hprod]
  have hdd : l1 ^ 2 - l2 ^ 2 = m1 ^ 2 - m2 ^ 2 := sq_eq_of_pos hd1 hd2 hdiff
  have hs1 : l1 ^ 2 = m1 ^ 2 := by linarith
  have hs2 : l2 ^ 2 = m2 ^ 2 := by linarith
  exact ⟨sq_eq_of_pos hl1 hm1 hs1, sq_eq_of_pos hl2 hm2 hs2⟩

theorem casimir_pair_separates {a b a' b' : ℕ} (hab : b ≤ a) (hab' : b' ≤ a')
    (h2 : p2 a b = p2 a' b') (h4 : p4 a b = p4 a' b') : a = a' ∧ b = b' := by
  obtain ⟨hl2, hl⟩ := rho_strictly_dominant hab
  obtain ⟨hm2, hm⟩ := rho_strictly_dominant hab'
  obtain ⟨e1, e2⟩ := pair_separates hl2 hl hm2 hm h2 h4
  constructor
  · have : (a : ℚ) = (a' : ℚ) := by unfold ell1 at e1; linarith
    exact_mod_cast this
  · have : (b : ℚ) = (b' : ℚ) := by unfold ell2 at e2; linarith
    exact_mod_cast this

theorem quartic_shift_still_separates (α β γ : ℚ) {a b a' b' : ℕ} (hab : b ≤ a) (hab' : b' ≤ a')
    (h2 : p2 a b = p2 a' b')
    (h4 : p4 a b + α * p2 a b ^ 2 + β * p2 a b + γ
        = p4 a' b' + α * p2 a' b' ^ 2 + β * p2 a' b' + γ) : a = a' ∧ b = b' := by
  refine casimir_pair_separates hab hab' h2 ?_
  rw [h2] at h4
  linarith

theorem alpha_half_collides :
    p4 2 2 + (-1/2 : ℚ) * p2 2 2 ^ 2 = 18 ∧ p4 1 0 + (-1/2 : ℚ) * p2 1 0 ^ 2 = 18 ∧
      c2Q 2 2 = 16 ∧ c2Q 1 0 = 4 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> · simp only [p4, p2, c2Q, ell1, ell2]; norm_num

theorem sq_same_fibres {x y : ℚ} (hx : 0 ≤ x) (hy : 0 ≤ y) : x ^ 2 = y ^ 2 ↔ x = y := by
  constructor
  · intro h
    have hfac : (x - y) * (x + y) = 0 := by linear_combination h
    rcases mul_eq_zero.mp hfac with h' | h'
    · linarith
    · nlinarith
  · intro h; rw [h]

theorem c2Q_nonneg (a b : ℕ) : 0 ≤ c2Q a b := by
  unfold c2Q; positivity

def c2N (B : Block) : ℕ := B.a * (B.a + 3) + B.b * (B.b + 1)

theorem c2_distinct_21 : (table.map c2N).dedup.length = 21 := by decide

theorem three_collisions :
    c2N ⟨4, 1, 2⟩ = 30 ∧ c2N ⟨3, 3, 1⟩ = 30 ∧
      c2N ⟨4, 3, 2⟩ = 40 ∧ c2N ⟨5, 0, 1⟩ = 40 ∧
      c2N ⟨5, 4, 1⟩ = 60 ∧ c2N ⟨6, 2, 1⟩ = 60 := by decide

theorem p4_splits_the_collisions :
    p4 4 1 ≠ p4 3 3 ∧ p4 4 3 ≠ p4 5 0 ∧ p4 5 4 ≠ p4 6 2 := by
  refine ⟨?_, ?_, ?_⟩ <;> · unfold p4 ell1 ell2; norm_num

theorem p4_collision_values :
    p4 4 1 = 7361 / 8 ∧ p4 3 3 = 4481 / 8 ∧ p4 4 3 = 8521 / 8 ∧ p4 5 0 = 14281 / 8 ∧
      p4 5 4 = 17561 / 8 ∧ p4 6 2 = 25625 / 8 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> · unfold p4 ell1 ell2; norm_num

end HamiltonsCubic.L84Statement
```

```lean
import HamiltonsCubic.Results.L83
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

namespace HamiltonsCubic.Casimir

open HamiltonsCubic.Blocks

def c2 (B : Block) : ℕ := B.a * (B.a + 3) + B.b * (B.b + 1)

theorem collision_sixty : c2 ⟨5, 4, 1⟩ = 60 ∧ c2 ⟨6, 2, 1⟩ = 60 := by
  constructor <;> decide

theorem collision_forty : c2 ⟨5, 0, 1⟩ = 40 ∧ c2 ⟨4, 3, 2⟩ = 40 := by
  constructor <;> decide

theorem collision_thirty : c2 ⟨4, 1, 2⟩ = 30 ∧ c2 ⟨3, 3, 1⟩ = 30 := by
  constructor <;> decide

theorem c2_distinct : (table.map c2).dedup.length = 21 := by decide

theorem three_merges : table.length - (table.map c2).dedup.length = 3 := by decide

theorem no_triple :
    ((table.map c2).dedup.filter (fun v => 2 < (table.map c2).count v)).length = 0 := by
  decide

theorem colliding_values :
    ((table.map c2).dedup.filter (fun v => 1 < (table.map c2).count v)) = [60, 40, 30] := by
  decide

theorem rho_norm_sq : (3 / 2 : ℚ) ^ 2 + (1 / 2 : ℚ) ^ 2 = 5 / 2 := by norm_num

theorem rho_strictly_decreasing : (0 : ℚ) < 1 / 2 ∧ (1 / 2 : ℚ) < 3 / 2 := by
  constructor <;> norm_num

theorem c2_nonneg (B : Block) : 0 ≤ c2 B := Nat.zero_le _

theorem c2_sq_distinct : (table.map (fun B => c2 B * c2 B)).dedup.length = 21 := by decide

theorem sq_injective_nat {x y : ℕ} (h : x * x = y * y) : x = y := by
  nlinarith [h, Nat.zero_le x, Nat.zero_le y]

theorem single_quartic_worse : 18 < 21 ∧ 21 < 24 := by
  constructor <;> decide

end HamiltonsCubic.Casimir
```

## Definitions

- $B_2$ weights are written $\lambda=ae_1+be_2=(a,b)$, dominant when $a\ge b\ge0$ are integers, with $\rho=(\tfrac32,\tfrac12)$ and $\ell=\lambda+\rho$. $W(B_2)$ is the group of signed permutations of $(\ell_1,\ell_2)$. $\chi_\lambda(z)$ is the scalar by which a central $z\in U(\mathfrak{so}(5))$ acts on the irreducible $V_\lambda$.
- The Harish-Chandra isomorphism is a classical theorem the passages cite by name. Where a step uses it, say which statement of it the step needs.
- **This loop does no numerical work.** A claim supported only by a run is `HYPOTHESIS-DEBT`. Screening a claim by hand on an object you construct is allowed, and is reported as a screen, never as evidence for a positive claim. Evaluating a stated closed form at a listed label by hand is checking.

## What to attack, beyond the standing list

1. **The statement's hypotheses**: what "a central element of degree four" means in $U(\mathfrak{so}(5))$, $C_4\notin\mathbb R[C_2]$, and "determines every dominant $B_2$ weight".
2. **The Harish-Chandra step**: the $\rho$-shift, injectivity of $\gamma$, the invariants $\mathbb R[p_2,p_4]$, and $\chi_\lambda(C_2)=p_2(\ell)-\tfrac52=c_2(\lambda)$ against Passage D's $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$ and the normalisation of $C_2$.
3. **$\gamma(C_4)=a\,p_4+b\,p_2^2+c\,p_2+d$ with $a\ne0$**: whether every invariant of degree at most four has this form, and whether $a=0$ puts $C_4$ in $\mathbb R[C_2]$.
4. **Recovering $\lambda$**: $e_1=p_2$, $e_2=(p_2^2-p_4)/2$, the multiset $\{\ell_1^2,\ell_2^2\}$, and "$\ell_1>\ell_2>0$" at every dominant weight.
5. **The collision claims**: $21$ distinct values of $c_2$ on Passage D's $24$ labels with exactly the three named pairs, and the six $p_4$ values, each by hand.
6. **"The generator condition is needed"**: $C_2^2$ as a central element of degree four in $\mathbb R[C_2]$, "separates none of the three colliding pairs", and the reading $(30,900)$.
7. **Passage C against Passages A and B**: every clause, "any quartic central generator", and "$C_2$ alone takes $21$ values".
8. **Passage E against Passages A to C**: what `casimir_pair_separates` states, over which weights, and what stands outside the file.
9. **The boundary**: $\lambda=(0,0)$, $b=0$, $a=b$, and $SO(5)$ labels against $O(5)$.
