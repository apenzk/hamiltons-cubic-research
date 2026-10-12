import Mathlib

set_option linter.style.longLine false

/-!
# L140, `‖g₁‖² ≤ 1/4` for every unit Weyl direction

## The record's statement, quoted verbatim from [route-a.md](../../../findings/route-a.md)

> **Statement.** Let $H\in\mathcal W_n$ with $\lVert H\rVert=1$, and let
> $g_1=\mathrm{Alt}\big(\mathcal D_u[H]+D_-\big)$ be the first-order coefficient of
> $\mathrm{Alt}(W_-)$ along $u+tH$, with $D=P_0HP_0$. Then
> $$\boxed{\ \lVert g_1\rVert^2\;\le\;\tfrac14\ }$$

and, from the same block, the division of labour it insists on:

> **What is proved here and what it is combined with, kept apart because both reviewers said the
> first version ran them together.** *Proved here, needing neither the cone nor orthogonality to
> the orbit*: the boxed $\lVert g_1\rVert^2\le\tfrac14$. *Imported*: the identification of $Z$,
> which is [Lemma L135](../../../findings/route-a.md)(c)'s first-order expansion and **is**
> perturbation theory.

and the proof:

> **$\mathrm{Alt}$ is linear, so $g_1=\mathrm{Alt}(Z)=\mathrm{Alt}(Z+\mu H)$ for every scalar
> $\mu$**, and therefore $\lVert g_1\rVert\le\inf_\mu\lVert Z+\mu H\rVert$, $\mathrm{Alt}$ being an
> orthogonal projection. Take $\mu=\tfrac12$. […] the Daleckii–Krein multipliers are […] **every
> one of them in $[-1,0]$**, so $\lvert m+\tfrac12\rvert\le\tfrac12$ entrywise. On the $K\times K$
> block […] the exact value is $Z_{KK}=D_-=\tfrac12(\lvert D\rvert-D)$, and
> $$Z_{KK}+\tfrac12H_{KK}=\tfrac12\big(\lvert D\rvert-D\big)+\tfrac12D=\tfrac12\lvert D\rvert,
> \qquad\big\lVert Z_{KK}+\tfrac12H_{KK}\big\rVert=\tfrac12\lVert D\rVert .$$
> So every block of $Z+\tfrac12H$ has norm at most half the corresponding block of $H$, whence
> $\lVert Z+\tfrac12H\rVert\le\tfrac12\lVert H\rVert=\tfrac12$ and $\lVert g_1\rVert\le\tfrac12$.

## What is typed here

The ambient space is written concretely as `Fin N → Fin N → ℝ` with the Frobenius pairing, `Alt` as
an idempotent self-adjoint linear map on it, and the index set carrying a distinguished subset `K`
the kernel block. `g1_sq_le_quarter` is the boxed statement, **proved**, from exactly the three
inputs the record's proof uses:

* `hm`, the multipliers lie in `[-1, 0]`, which the record's table exhibits and which
  [L138Statement.lean](L138Statement.lean) proves from `f(x) = ½(|x| - x)` alone;
* `hE`, `hKK`, the shape of `Z`: multiplier times `H` off the kernel block, and `D₋` on it;
* `habs`, `‖|D|‖_F = ‖D‖_F` on the kernel block, which [L140Abs.lean](L140Abs.lean)'s `g1_sq_le_quarter_of_sq`
  discharges from `|D|` symmetric with `|D|² = D²` there.

The recentring identity `Z_KK + ½H_KK = ½|D|` is not assumed: it is derived from `hKK` inside the
proof, which is the record's own one-line step.

Also proved: `proj_contract`, that an orthogonal projection is norm-nonincreasing, so the
`inf_μ` step is not assumed either; and `i3_target`, the record's consequence
`c₂ = Δ₂ - 1/9 ≤ 5/36 < 0.3591`.

There is no `sorry`.

## What is NOT typed here

**The identification of `Z` is a hypothesis, not a theorem**, and it is the record's own import
rather than a classical one: `hE` and `hKK` say that the first-order coefficient of `Alt(W₋)` along
`u + tH` has the Daleckii–Krein shape off the kernel and equals `D₋` on it. The Daleckii–Krein
representation is classical; **that the kernel block is exactly `D₋`, with the Schur term entering
only at `t²`, is [Lemma L135](../../../findings/route-a.md)(c) and is Gate 2 owed**. So this file
types the estimate (which is what the record says L140 proves) and takes the object it estimates
as given, which is what the record says L140 imports.

Absent for the same reason: that `H ∈ 𝒲ₙ` forces `Alt H = 0` (the first Bianchi identity), carried
here as the hypothesis `haltH`; and the spectral data of `u` that produces the specific multiplier
table.
-/

namespace HamiltonsCubic.L140Statement

open Finset

variable {N : ℕ}

/-- The ambient space: `N × N` arrays with the Frobenius pairing. -/
abbrev Mat (N : ℕ) := Fin N → Fin N → ℝ

/-! ## The Frobenius pairing -/

/-- The Frobenius inner product. -/
def fip (X Y : Mat N) : ℝ := ∑ i, ∑ j, X i j * Y i j

/-- The squared Frobenius norm. -/
def fn2 (X : Mat N) : ℝ := fip X X

theorem fn2_nonneg (X : Mat N) : 0 ≤ fn2 X := by
  unfold fn2 fip
  exact Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => mul_self_nonneg _

theorem fn2_add (X Y : Mat N) : fn2 (X + Y) = fn2 X + 2 * fip X Y + fn2 Y := by
  simp only [fn2, fip, Pi.add_apply]
  rw [show (∑ i, ∑ j, (X i j + Y i j) * (X i j + Y i j))
      = ∑ i, ((∑ j, X i j * X i j) + 2 * (∑ j, X i j * Y i j) + (∑ j, Y i j * Y i j)) from
    Finset.sum_congr rfl fun i _ => by
      rw [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun j _ => by ring]
  rw [Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.mul_sum]

/-! ## An orthogonal projection is norm-nonincreasing

*The record's "`Alt` being an orthogonal projection" step, proved rather than assumed.* -/

/-- **`‖Alt X‖ ≤ ‖X‖`** for `Alt` idempotent and self-adjoint. -/
theorem proj_contract (Alt : Mat N →ₗ[ℝ] Mat N) (hidem : ∀ X, Alt (Alt X) = Alt X)
    (hsa : ∀ X Y, fip (Alt X) Y = fip X (Alt Y)) (X : Mat N) : fn2 (Alt X) ≤ fn2 X := by
  have hsplit : X = Alt X + (X - Alt X) := by abel
  have hcross : fip (Alt X) (X - Alt X) = 0 := by
    rw [hsa]
    have : Alt (X - Alt X) = 0 := by rw [map_sub, hidem]; abel
    rw [this]
    simp [fip]
  have := fn2_add (Alt X) (X - Alt X)
  rw [← hsplit, hcross] at this
  have hnn := fn2_nonneg (X - Alt X)
  linarith

/-! ## The recentring identity on the kernel block -/

/-- **`D₋ + ½D = ½|D|`**, the record's one-line kernel-block step: the negative part `½(|D| - D)`
recentred by `½D` is `½|D|`. -/
theorem recentre (absD d : ℝ) : (absD - d) / 2 + (1 / 2) * d = (1 / 2) * absD := by ring

/-! ## The lemma -/

/-- **The estimate at any norm**: `‖Alt Z‖² ≤ ¼‖H‖²` under the hypotheses of `g1_sq_le_quarter` less `‖H‖ = 1`. -/
theorem g1_sq_le_quarter_general (Alt : Mat N →ₗ[ℝ] Mat N) (hidem : ∀ X, Alt (Alt X) = Alt X)
    (hsa : ∀ X Y, fip (Alt X) Y = fip X (Alt Y))
    (H Z absD m : Mat N) (K : Finset (Fin N))
    (haltH : Alt H = 0)
    (hm : ∀ i j, -1 ≤ m i j ∧ m i j ≤ 0)
    (hE : ∀ i j, ¬(i ∈ K ∧ j ∈ K) → Z i j = m i j * H i j)
    (hKK : ∀ i j, i ∈ K → j ∈ K → Z i j = (absD i j - H i j) / 2)
    (habs : (∑ i, ∑ j, if i ∈ K ∧ j ∈ K then absD i j ^ 2 else 0)
      = ∑ i, ∑ j, if i ∈ K ∧ j ∈ K then H i j ^ 2 else 0) :
    fn2 (Alt Z) ≤ (1 / 4 : ℝ) * fn2 H := by
  classical
  -- recentring: `Alt Z = Alt (Z + ½H)`, `Alt` being linear with `Alt H = 0`
  have hrec : Alt Z = Alt (Z + (1 / 2 : ℝ) • H) := by
    rw [map_add, map_smul, haltH, smul_zero, add_zero]
  -- the entrywise bound on `Z + ½H`
  have hentry : ∀ i j, (Z + (1 / 2 : ℝ) • H) i j * (Z + (1 / 2 : ℝ) • H) i j
      ≤ (if i ∈ K ∧ j ∈ K then (1 / 4 : ℝ) * absD i j ^ 2 else (1 / 4 : ℝ) * H i j ^ 2) := by
    intro i j
    by_cases hK : i ∈ K ∧ j ∈ K
    · rw [if_pos hK]
      have h : (Z + (1 / 2 : ℝ) • H) i j = (1 / 2 : ℝ) * absD i j := by
        simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul, hKK i j hK.1 hK.2]
        ring
      rw [h]; nlinarith [sq_nonneg (absD i j)]
    · rw [if_neg hK]
      have h : (Z + (1 / 2 : ℝ) • H) i j = (m i j + 1 / 2) * H i j := by
        simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul, hE i j hK]
        ring
      obtain ⟨h1, h2⟩ := hm i j
      have ht : (m i j + 1 / 2) ^ 2 ≤ 1 / 4 := by nlinarith
      rw [h]
      nlinarith [ht, sq_nonneg (H i j)]
  -- summing the entrywise bound
  have hsum : fn2 (Z + (1 / 2 : ℝ) • H)
      ≤ ∑ i, ∑ j, (if i ∈ K ∧ j ∈ K then (1 / 4 : ℝ) * absD i j ^ 2
        else (1 / 4 : ℝ) * H i j ^ 2) := by
    unfold fn2 fip
    exact Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => hentry i j
  -- and the right-hand side is `¼‖H‖²`
  have hsplit : ∀ i j, (if i ∈ K ∧ j ∈ K then (1 / 4 : ℝ) * absD i j ^ 2
        else (1 / 4 : ℝ) * H i j ^ 2)
      = (1 / 4 : ℝ) * (if i ∈ K ∧ j ∈ K then absD i j ^ 2 else 0)
        + (1 / 4 : ℝ) * ((H i j * H i j) - (if i ∈ K ∧ j ∈ K then H i j ^ 2 else 0)) := by
    intro i j
    by_cases hK : i ∈ K ∧ j ∈ K
    · rw [if_pos hK, if_pos hK, if_pos hK]; ring
    · rw [if_neg hK, if_neg hK, if_neg hK]; ring
  have hrhs : (∑ i, ∑ j, (if i ∈ K ∧ j ∈ K then (1 / 4 : ℝ) * absD i j ^ 2
        else (1 / 4 : ℝ) * H i j ^ 2)) = (1 / 4 : ℝ) * fn2 H := by
    rw [show (∑ i, ∑ j, (if i ∈ K ∧ j ∈ K then (1 / 4 : ℝ) * absD i j ^ 2
        else (1 / 4 : ℝ) * H i j ^ 2))
        = ∑ i, ∑ j, ((1 / 4 : ℝ) * (if i ∈ K ∧ j ∈ K then absD i j ^ 2 else 0)
          + (1 / 4 : ℝ) * ((H i j * H i j) - (if i ∈ K ∧ j ∈ K then H i j ^ 2 else 0))) from
      Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => hsplit i j]
    simp only [Finset.sum_add_distrib, ← Finset.mul_sum]
    rw [habs]
    have key : (∑ x, ∑ y, (if x ∈ K ∧ y ∈ K then H x y ^ 2 else 0))
        + (∑ x, ∑ y, (H x y ^ 2 - if x ∈ K ∧ y ∈ K then H x y ^ 2 else 0))
        = ∑ x, ∑ y, H x y ^ 2 := by
      rw [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun x _ => ?_
      rw [← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun y _ => by ring
    simp only [fn2, fip, ← pow_two]
    linarith [key]
  -- assembling
  have hfinal : fn2 (Alt Z) ≤ (1 / 4 : ℝ) * fn2 H := by
    rw [hrec]
    calc fn2 (Alt (Z + (1 / 2 : ℝ) • H)) ≤ fn2 (Z + (1 / 2 : ℝ) • H) :=
          proj_contract Alt hidem hsa _
      _ ≤ _ := hsum
      _ = (1 / 4 : ℝ) * fn2 H := hrhs
  exact hfinal

/-- **L140's boxed statement.** With

* `Alt` an idempotent self-adjoint linear map and `Alt H = 0` (`H` a Weyl tensor);
* `‖H‖² = 1`;
* every multiplier `m i j` in `[-1, 0]`;
* `Z = m ⊙ H` off the kernel block `K × K` and `Z = ½(|D| - H)` on it;
* `‖|D|‖ = ‖D‖` on the kernel block,

one has `‖g₁‖² = ‖Alt Z‖² ≤ 1/4`. -/
theorem g1_sq_le_quarter (Alt : Mat N →ₗ[ℝ] Mat N) (hidem : ∀ X, Alt (Alt X) = Alt X)
    (hsa : ∀ X Y, fip (Alt X) Y = fip X (Alt Y))
    (H Z absD m : Mat N) (K : Finset (Fin N))
    (haltH : Alt H = 0) (hnorm : fn2 H = 1)
    (hm : ∀ i j, -1 ≤ m i j ∧ m i j ≤ 0)
    (hE : ∀ i j, ¬(i ∈ K ∧ j ∈ K) → Z i j = m i j * H i j)
    (hKK : ∀ i j, i ∈ K → j ∈ K → Z i j = (absD i j - H i j) / 2)
    (habs : (∑ i, ∑ j, if i ∈ K ∧ j ∈ K then absD i j ^ 2 else 0)
      = ∑ i, ∑ j, if i ∈ K ∧ j ∈ K then H i j ^ 2 else 0) :
    fn2 (Alt Z) ≤ 1 / 4 := by
  have := g1_sq_le_quarter_general Alt hidem hsa H Z absD m K haltH hm hE hKK habs
  rw [hnorm] at this; linarith

/-! ## The record's consequence -/

/-- **`c₂ = Δ₂ - 1/9 ≤ 5/36`, and `5/36 < 0.3591`**, the record's I3 conclusion, given
[L136](../../../findings/route-a.md)'s `Δ₂ ≤ ‖g₁‖²` and [L135](L135Statement.lean)(a)'s
`c₂ = Δ₂ - 1/9`. -/
theorem i3_target {c Δ g : ℝ} (hdef : c = Δ - 1 / 9) (h136 : Δ ≤ g) (h140 : g ≤ 1 / 4) :
    c ≤ 5 / 36 ∧ (5 : ℝ) / 36 < 0.3591 := by
  constructor
  · rw [hdef]; linarith
  · norm_num

end HamiltonsCubic.L140Statement
