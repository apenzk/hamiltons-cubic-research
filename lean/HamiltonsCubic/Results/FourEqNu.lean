import Mathlib
import HamiltonsCubic.Results.FourEq

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L220's equality points, listed: `q` and `ν` at `θ² = 3/2`

[findings/second-order.md](../../../findings/second-order.md), Lemma L220: *with equality exactly at padded
$W_{\mathbb{CP}^2}$ on $Q$.* Step 9: *Equality forces $r=0$, $\lVert\nu\rVert^2=\tfrac12$ and the $S^2\times S^2$ shape, and
conversely $q=t(2,-1,-1)$, $\nu=\pm t(2,-1,-1)$ with $t^2=\tfrac1{24}$ satisfies both equations of step 3.*

[FourEq.lean](FourEq.lean)'s `L220_eq_shape` fixes `q` up to the three placements of the entry `2t`, `t = θ/6`. Here the
eigen-equation `2q ∘ ν = θν`, paired with `σ_A` through `fox_pair`, fixes `ν` in each placement, the pairing with `σ_B` giving
the same line since each placement's `2 × 2` system has rank one (r1841 O4):

| `q = Π_Q(x, y, z)` | `ν` |
| --- | --- |
| `t(2, -1, -1)` | `2u σ_A + u σ_B` |
| `t(-1, 2, -1)` | `u σ_A + 2u σ_B` |
| `t(-1, -1, 2)` | `u σ_A - u σ_B` |

with `u² = t²`, so `u = ±t`. The first row is the record's `ν = ±t(2, -1, -1)` in `nu_sq`'s signed coordinates.

* `pair_nu`: `⟨ν, σ_A⟩ = 4a - 2b`, `⟨ν, σ_B⟩ = -2a + 4b`, `‖ν‖² = 4a² - 4ab + 4b²` at `ν = a σ_A + b σ_B`;
* **`L220_eq_points`**: every equality point of `L220_bound` is one of the three rows;
* `nu_mem'`, **`converse_gen`**: `q = Π_Q(x, y, z)` and `ν = a σ_A + b σ_B` satisfy both equations of step 3 and
  `Q(q + ν) = θ(q + ν)` once six scalar identities hold, with `‖q + ν‖² = 2(x² + y² + z²) + 4a² − 4ab + 4b²`;
* **`converse_rows`**: every row of the table, at `θ = 6t`, `u² = t²`, is critical with `‖q + ν‖² = 24t²`, so the three rows
  are exactly the equality points (r1841 O3).
-/

namespace HamiltonsCubic.FourEqNu

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent HamiltonsCubic.FourProd
  HamiltonsCubic.L222Op HamiltonsCubic.FourPi HamiltonsCubic.FourStep4 HamiltonsCubic.FourStep5 HamiltonsCubic.L224Rank
  HamiltonsCubic.PairNorm HamiltonsCubic.FrameOp2 HamiltonsCubic.FrameLayer HamiltonsCubic.FourStep67
  HamiltonsCubic.FourStep8 HamiltonsCubic.FourL220 HamiltonsCubic.BlockSub HamiltonsCubic.FourEq

variable {n : ℕ} {i j k l : Fin n}

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- The Gram data of `ν = a σ_A + b σ_B`. -/
theorem pair_nu (a b : ℝ) :
    innerOp2 (a • sig4 i k j l + b • sig4 i j k l) (sig4 i k j l) = 4 * a - 2 * b ∧
      innerOp2 (a • sig4 i k j l + b • sig4 i j k l) (sig4 i j k l) = -2 * a + 4 * b ∧
      normSq2 (a • sig4 i k j l + b • sig4 i j k l) = 4 * a ^ 2 - 4 * a * b + 4 * b ^ 2 := by
  have gA := norm_sig hik hjl hij hil (Ne.symm hjk) hkl
  have gB := norm_sig hij hkl hik hil hjk hjl
  have gAB := inner_AB hij hik hil hjk hjl hkl
  unfold normSq2 at gA gB ⊢
  refine ⟨?_, ?_, ?_⟩
  · rw [innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, gA, innerOp2_comm (sig4 i j k l), gAB]; ring
  · rw [innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, gAB, gB]; ring
  · simp only [innerOp2_add_left, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_right]
    rw [gA, gB, gAB, innerOp2_comm (sig4 i j k l), gAB]
    ring

/-- **L220's equality points**: at `θ² = 3/2`, `t = θ/6`, the pair `(D, ν)` is one of `(Π_Q(2t,-t,-t), 2uσ_A + uσ_B)`,
`(Π_Q(-t,2t,-t), uσ_A + 2uσ_B)`, `(Π_Q(-t,-t,2t), uσ_A - uσ_B)` with `u² = t²`. -/
theorem L220_eq_points {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hD : SignChar (fun _ => 1) D) (hνW : IsWeyl2 ν)
    (hν : SignChar (setChar {i, j, k, l}) ν) (hν0 : ν ≠ 0) {θ : ℝ} (hθ : 0 < θ)
    (hQ : Qop2 (D + ν) = θ • (D + ν)) (hunit : normSq2 (D + ν) = 1) (heq : θ ^ 2 = 3 / 2) :
    ∃ u : ℝ, u ^ 2 = (θ / 6) ^ 2 ∧
      ((D = coordOp (PiQ i j k l (2 * (θ / 6)) (-(θ / 6)) (-(θ / 6))) ∧
          ν = (2 * u) • sig4 i k j l + u • sig4 i j k l) ∨
        (D = coordOp (PiQ i j k l (-(θ / 6)) (2 * (θ / 6)) (-(θ / 6))) ∧
          ν = u • sig4 i k j l + (2 * u) • sig4 i j k l) ∨
        (D = coordOp (PiQ i j k l (-(θ / 6)) (-(θ / 6)) (2 * (θ / 6))) ∧
          ν = u • sig4 i k j l + (-u) • sig4 i j k l)) := by
  obtain ⟨x, y, z, hDq, hsh, hN⟩ := L220_eq_shape hij hik hil hjk hjl hkl hDW hD hνW hν hν0 hθ hQ hunit heq
  have hs : x + y + z = 0 := by rcases hsh with ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ <;> rw [h1, h2, h3] <;> ring
  -- the eigen-equation with `D = q`
  subst hDq
  obtain ⟨-, hDν⟩ := L220_split hD hν hQ
  obtain ⟨a, b, rfl⟩ := four_eq_sig hij hik hil hjk hjl hkl hνW hν
  obtain ⟨pA, pB⟩ := fox_pair hij hik hil hjk hjl hkl hs a b
  obtain ⟨gA, gB, gN⟩ := pair_nu hij hik hil hjk hjl hkl a b
  have eA := congrArg (fun T => innerOp2 T (sig4 i k j l)) hDν
  have eB := congrArg (fun T => innerOp2 T (sig4 i j k l)) hDν
  simp only [innerOp2_smul_left] at eA eB
  rw [pA, gA] at eA
  rw [pB, gB] at eB
  rw [gN] at hN
  have ht2 : (θ / 6) ^ 2 = 1 / 24 := by rw [div_pow, heq]; norm_num
  have hθ6 : θ = 6 * (θ / 6) := by ring
  set t := θ / 6 with htdef
  have ht : 0 < t := by positivity
  rcases hsh with ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ <;> rw [h1, h2, h3] at eA eB <;> rw [hθ6] at eA eB
  · -- `a = 2b`
    have hab : a = 2 * b := by
      have : t * (a - 2 * b) = 0 := by linear_combination (-1 / 12 : ℝ) * eA
      rcases mul_eq_zero.mp this with h | h
      · linarith
      · linarith
    refine ⟨b, by rw [ht2]; subst hab; nlinarith, Or.inl ⟨by rw [h1, h2, h3], by rw [hab]⟩⟩
  · -- `b = 2a`
    have hab : b = 2 * a := by
      have : t * (b - 2 * a) = 0 := by linear_combination (1 / 24 : ℝ) * eA
      rcases mul_eq_zero.mp this with h | h
      · linarith
      · linarith
    refine ⟨a, by rw [ht2]; subst hab; nlinarith, Or.inr (Or.inl ⟨by rw [h1, h2, h3], by rw [hab]⟩)⟩
  · -- `b = -a`
    have hab : b = -a := by
      have : t * (b + a) = 0 := by linear_combination (-1 / 12 : ℝ) * eA
      rcases mul_eq_zero.mp this with h | h
      · linarith
      · linarith
    refine ⟨a, by rw [ht2]; subst hab; nlinarith, Or.inr (Or.inr ⟨by rw [h1, h2, h3], by rw [hab]⟩)⟩

/-- `ν = a σ_A + b σ_B` is Weyl of character `χ_Q`. -/
theorem nu_mem' (a b : ℝ) :
    IsWeyl2 (a • sig4 i k j l + b • sig4 i j k l) ∧
      SignChar (setChar {i, j, k, l}) (a • sig4 i k j l + b • sig4 i j k l) :=
  ⟨isWeyl2_add (isWeyl2_smul _ (sig_weyl hik hjl hij hil (Ne.symm hjk) hkl))
      (isWeyl2_smul _ (sig_weyl hij hkl hik hil hjk hjl)),
    signChar_add (signChar_smul (sigA_char hij hik hil hjk hjl hkl) _) (signChar_smul (sigB_char hij hik hil hjk hjl hkl) _)⟩

/-- **The converse from six scalar identities**: `q = Π_Q(x, y, z)`, `x + y + z = 0`, and `ν = a σ_A + b σ_B` satisfy
`q ∘ q + ν ∘ ν = θ q`, `2 q ∘ ν = θ ν` and `Q(q + ν) = θ(q + ν)` once the pattern of `q ∘ q + ν ∘ ν` is `θ(x, y, z)` and the
pairings of `2q ∘ ν − θν` with `σ_A`, `σ_B` vanish. -/
theorem converse_gen {x y z θ a b : ℝ} (hs : x + y + z = 0)
    (h1 : x * x + y * z + z * y + (2 * a ^ 2 - (-b) ^ 2 - (b - a) ^ 2) = θ * x)
    (h2 : y * y + z * x + x * z + (2 * (-b) ^ 2 - (b - a) ^ 2 - a ^ 2) = θ * y)
    (h3 : z * z + x * y + y * x + (2 * (b - a) ^ 2 - a ^ 2 - (-b) ^ 2) = θ * z)
    (hA : 2 * (a * (2 * x + 2 * z - 4 * y) + b * (2 * x + 2 * y - 4 * z)) = θ * (4 * a - 2 * b))
    (hB : 2 * (a * (2 * x + 2 * y - 4 * z) + b * (2 * y + 2 * z - 4 * x)) = θ * (-2 * a + 4 * b)) :
    foxProd2 (coordOp (PiQ i j k l x y z)) (coordOp (PiQ i j k l x y z))
        + foxProd2 (a • sig4 i k j l + b • sig4 i j k l) (a • sig4 i k j l + b • sig4 i j k l)
        = θ • coordOp (PiQ i j k l x y z) ∧
      (2 : ℝ) • foxProd2 (coordOp (PiQ i j k l x y z)) (a • sig4 i k j l + b • sig4 i j k l)
        = θ • (a • sig4 i k j l + b • sig4 i j k l) ∧
      Qop2 (coordOp (PiQ i j k l x y z) + (a • sig4 i k j l + b • sig4 i j k l))
        = θ • (coordOp (PiQ i j k l x y z) + (a • sig4 i k j l + b • sig4 i j k l)) ∧
      normSq2 (coordOp (PiQ i j k l x y z) + (a • sig4 i k j l + b • sig4 i j k l))
        = 2 * (x ^ 2 + y ^ 2 + z ^ 2) + (4 * a ^ 2 - 4 * a * b + 4 * b ^ 2) := by
  set q := coordOp (PiQ i j k l x y z) with hqdef
  set ν := a • sig4 i k j l + b • sig4 i j k l with hνdef
  have hw := PiQ_weight hij hik hil hjk hjl hkl hs
  have hqW : IsWeyl2 q := by rw [hqdef, coordOp_eq_restrict hw]; exact isWeyl2_restrict _
  have hq1 : SignChar (fun _ => 1) q := by
    rw [hqdef, coordOp_eq_restrict hw]
    exact (L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hw, rfl⟩
  obtain ⟨hνW, hν⟩ := nu_mem' hij hik hil hjk hjl hkl a b
  have hD : foxProd2 q q + foxProd2 ν ν = θ • q := by
    rw [hqdef, PiQ_mul hij hik hil hjk hjl hkl, foxProd2_self, hνdef, Q_nu hij hik hil hjk hjl hkl, ← coordOp_add,
      ← coordOp_smul']
    congr 1
    rw [PiQ_add', PiQ_smul']
    congr 1 <;> first | linear_combination h1 | linear_combination h2 | linear_combination h3
  have hV : (2 : ℝ) • foxProd2 q ν = θ • ν := by
    obtain ⟨pA, pB⟩ := fox_pair hij hik hil hjk hjl hkl hs a b
    obtain ⟨gA, gB, -⟩ := pair_nu hij hik hil hjk hjl hkl a b
    have hEW : IsWeyl2 ((2 : ℝ) • foxProd2 q ν + (-θ) • ν) :=
      isWeyl2_add (isWeyl2_smul _ (isWeyl2_foxProd2 hqW hνW)) (isWeyl2_smul _ hνW)
    have hEc : SignChar (setChar {i, j, k, l}) ((2 : ℝ) • foxProd2 q ν + (-θ) • ν) :=
      signChar_add (signChar_smul (Dnu_char hq1 hν) _) (signChar_smul hν _)
    have hE := Vq_zero hij hik hil hjk hjl hkl hEW hEc ?_ ?_
    · have e : (2 : ℝ) • foxProd2 q ν - θ • ν = (2 : ℝ) • foxProd2 q ν + (-θ) • ν := by module
      exact sub_eq_zero.mp (e.trans hE)
    · rw [innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, hνdef, pA, gA]
      linarith
    · rw [innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, hνdef, pB, gB]
      linarith
  refine ⟨hD, hV, ?_, ?_⟩
  · rw [L219Prod.Qop2_add, ← foxProd2_self q, ← foxProd2_self ν, hV, hD]
    module
  · have hqν : innerOp2 q ν = 0 := inner_char_four hqW hνW hq1 hν
    have hN := (pair_nu hij hik hil hjk hjl hkl a b).2.2
    rw [← hνdef] at hN
    have hQn : normSq2 q = 2 * (x ^ 2 + y ^ 2 + z ^ 2) := by rw [hqdef, normSq2_PiQ hij hik hil hjk hjl hkl]
    clear_value q ν
    unfold normSq2 at hN hQn ⊢
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_comm ν q, hqν, hN, hQn]
    ring

/-- **Every row is an equality point** (r1841 O3): at `θ = 6t`, `u² = t²`, each of the three pairs `(q, ν)` is critical
with `Q(q + ν) = 6t (q + ν)` and `‖q + ν‖² = 24t²`. -/
theorem converse_rows (t u : ℝ) (hu : u ^ 2 = t ^ 2) :
    (Qop2 (coordOp (PiQ i j k l (2 * t) (-t) (-t)) + ((2 * u) • sig4 i k j l + u • sig4 i j k l))
        = (6 * t) • (coordOp (PiQ i j k l (2 * t) (-t) (-t)) + ((2 * u) • sig4 i k j l + u • sig4 i j k l)) ∧
      normSq2 (coordOp (PiQ i j k l (2 * t) (-t) (-t)) + ((2 * u) • sig4 i k j l + u • sig4 i j k l)) = 24 * t ^ 2) ∧
    (Qop2 (coordOp (PiQ i j k l (-t) (2 * t) (-t)) + (u • sig4 i k j l + (2 * u) • sig4 i j k l))
        = (6 * t) • (coordOp (PiQ i j k l (-t) (2 * t) (-t)) + (u • sig4 i k j l + (2 * u) • sig4 i j k l)) ∧
      normSq2 (coordOp (PiQ i j k l (-t) (2 * t) (-t)) + (u • sig4 i k j l + (2 * u) • sig4 i j k l)) = 24 * t ^ 2) ∧
    (Qop2 (coordOp (PiQ i j k l (-t) (-t) (2 * t)) + (u • sig4 i k j l + (-u) • sig4 i j k l))
        = (6 * t) • (coordOp (PiQ i j k l (-t) (-t) (2 * t)) + (u • sig4 i k j l + (-u) • sig4 i j k l)) ∧
      normSq2 (coordOp (PiQ i j k l (-t) (-t) (2 * t)) + (u • sig4 i k j l + (-u) • sig4 i j k l)) = 24 * t ^ 2) := by
  refine ⟨?_, ?_, ?_⟩
  · obtain ⟨-, -, hQ, hN⟩ := converse_gen hij hik hil hjk hjl hkl (x := 2 * t) (y := -t) (z := -t) (θ := 6 * t)
      (a := 2 * u) (b := u) (by ring) (by linear_combination 6 * hu) (by linear_combination (-3) * hu)
      (by linear_combination (-3) * hu) (by ring) (by ring)
    exact ⟨hQ, by rw [hN]; linear_combination 12 * hu⟩
  · obtain ⟨-, -, hQ, hN⟩ := converse_gen hij hik hil hjk hjl hkl (x := -t) (y := 2 * t) (z := -t) (θ := 6 * t)
      (a := u) (b := 2 * u) (by ring) (by linear_combination (-3) * hu) (by linear_combination 6 * hu)
      (by linear_combination (-3) * hu) (by ring) (by ring)
    exact ⟨hQ, by rw [hN]; linear_combination 12 * hu⟩
  · obtain ⟨-, -, hQ, hN⟩ := converse_gen hij hik hil hjk hjl hkl (x := -t) (y := -t) (z := 2 * t) (θ := 6 * t)
      (a := u) (b := -u) (by ring) (by linear_combination (-3) * hu) (by linear_combination (-3) * hu)
      (by linear_combination 6 * hu) (by ring) (by ring)
    exact ⟨hQ, by rw [hN]; linear_combination 12 * hu⟩

end

end HamiltonsCubic.FourEqNu
