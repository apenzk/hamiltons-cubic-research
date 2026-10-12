import Mathlib
import HamiltonsCubic.Results.FourStep67
import HamiltonsCubic.Results.ItemFour
import HamiltonsCubic.Results.PairNorm
import HamiltonsCubic.Results.L224Rank

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L220 step 8 on the operators, the coupling bound `3κ ≤ θ‖r‖²`

[findings/second-order.md](../../../findings/second-order.md), Lemma L220:
*8. The coupling. For unit $\hat q=(x,y,z)$ and $r\perp\Pi_Q$, split $r$ into its $Q$-internal entries $p,p',a',b',c',d'$ on the
pairs $ij,kl,ik,jl,il,jk$, its columns $c_m=(r_{am})_{a\in Q}$ for $m\notin Q$, and the rest. Then
$2\langle L_{\hat q}r,r\rangle=2[x(p^2+p'^2)+y(a'^2+b'^2)+z(c'^2+d'^2)]+2\Sigma+\sum_mc_m^{\mathsf T}\hat qc_m$ … Orthogonality to $\Pi_Q$
is $p+p'=a'+b'=c'+d'=:s$, so $\Sigma=s^2(x+y+z)=0$, and $\hat q$ has spectrum $\{0,2x,2y,2z\}$ on $\mathbb R^Q$. So
$\kappa\le\max(x,y,z)\lVert q\rVert\lVert r\rVert^2\le\tfrac1{\sqrt3}\lVert q\rVert\lVert r\rVert^2=\tfrac\theta3\lVert r\rVert^2$.*

A Weyl `r` of character `1` is `coordOp w` for a weight `w`, and `κ = ⟨r ∘ r, q⟩` expands by the columns of `w`.

* `col_bound`: the spectrum of `q` on `ℝ^Q`, `½ cᵀ K c ≤ M |c|²` for `M ≥ 0, x, y, z` at `x + y + z = 0`;
* `kappa_expand`: `κ = x(p² + p'²) + y(a'² + b'²) + z(c'² + d'²) + ∑_m ½ c_mᵀ K c_m`, the sum over every column;
* `kappa_le`: `κ ≤ M‖r‖²` under `p + p' = a' + b' = c' + d'`, the columns `m ∈ Q` carrying the cross term `Σ = 0`;
* **`step8`**: at `x + y + z = 0`, `θ ≥ 0`, `3‖q‖² = θ²` and `r` Weyl of character `1` orthogonal to `Π_Q`,
  `3κ ≤ θ‖r‖²`, which is `theta_sq_le`'s `hκ`.
-/

namespace HamiltonsCubic.FourStep8

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent HamiltonsCubic.FourProd
  HamiltonsCubic.L222Op HamiltonsCubic.FourPi HamiltonsCubic.FourStep4 HamiltonsCubic.FourStep5 HamiltonsCubic.FrameOp2
  HamiltonsCubic.FrameLayer HamiltonsCubic.L224Norm HamiltonsCubic.L224Cubic HamiltonsCubic.ItemFour HamiltonsCubic.PairNorm
  HamiltonsCubic.L224Rank

variable {n : ℕ} {i j k l : Fin n}

/-- **The spectrum of `q` on `ℝ^Q`**: `K` has eigenvalues `0, 2x, 2y, 2z` on `(1,1,1,1)`, `(1,1,-1,-1)`, `(1,-1,1,-1)`,
`(1,-1,-1,1)`, so `½ cᵀ K c ≤ M |c|²`. -/
theorem col_bound {x y z M : ℝ} (hs : x + y + z = 0) (hx : x ≤ M) (hy : y ≤ M) (hz : z ≤ M) (hM : 0 ≤ M)
    (c1 c2 c3 c4 : ℝ) :
    x * (c1 * c2 + c3 * c4) + y * (c1 * c3 + c2 * c4) + z * (c1 * c4 + c2 * c3)
      ≤ M * (c1 ^ 2 + c2 ^ 2 + c3 ^ 2 + c4 ^ 2) := by
  have hz' : z = -x - y := by linarith
  subst hz'
  have key : M * (c1 ^ 2 + c2 ^ 2 + c3 ^ 2 + c4 ^ 2)
      - (x * (c1 * c2 + c3 * c4) + y * (c1 * c3 + c2 * c4) + (-x - y) * (c1 * c4 + c2 * c3))
      = M * ((c1 + c2 + c3 + c4) / 2) ^ 2 + (M - x) * ((c1 + c2 - c3 - c4) / 2) ^ 2
        + (M - y) * ((c1 - c2 + c3 - c4) / 2) ^ 2 + (M - (-x - y)) * ((c1 - c2 - c3 + c4) / 2) ^ 2 := by ring
  have h0 := mul_nonneg hM (sq_nonneg ((c1 + c2 + c3 + c4) / 2))
  have h1 := mul_nonneg (sub_nonneg.2 hx) (sq_nonneg ((c1 + c2 - c3 - c4) / 2))
  have h2 := mul_nonneg (sub_nonneg.2 hy) (sq_nonneg ((c1 - c2 + c3 - c4) / 2))
  have h3 := mul_nonneg (sub_nonneg.2 hz) (sq_nonneg ((c1 - c2 - c3 + c4) / 2))
  linarith

/-- The column term of `κ` at `m`, `½ c_mᵀ K c_m` with `c_m = (w_{im}, w_{jm}, w_{km}, w_{lm})`. -/
def colT (i j k l : Fin n) (w : Matrix (Fin n) (Fin n) ℝ) (x y z : ℝ) (m : Fin n) : ℝ :=
  x * (w i m * w j m + w k m * w l m) + y * (w i m * w k m + w j m * w l m) + z * (w i m * w l m + w j m * w k m)

/-- The column norm `|c_m|²`. -/
def colN (i j k l : Fin n) (w : Matrix (Fin n) (Fin n) ℝ) (m : Fin n) : ℝ :=
  w i m ^ 2 + w j m ^ 2 + w k m ^ 2 + w l m ^ 2

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

omit hij hik hil hjk hjl hkl in
theorem mul_self_apply {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) (a b : Fin n) :
    (w * w) a b = ∑ m, w a m * w b m := by
  rw [Matrix.mul_apply]
  exact Finset.sum_congr rfl fun m _ => by rw [hw.symm m b]

/-- **`κ` by columns**: `⟨r ∘ r, q⟩` at `r = coordOp w`, `q = coordOp (Π_Q(x,y,z))`. -/
theorem kappa_expand {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) (x y z : ℝ) :
    innerOp2 (foxProd2 (coordOp w) (coordOp w)) (coordOp (PiQ i j k l x y z))
      = x * (w i j ^ 2 + w k l ^ 2) + y * (w i k ^ 2 + w j l ^ 2) + z * (w i l ^ 2 + w j k ^ 2)
        + ∑ m, colT i j k l w x y z m := by
  have hT : wᵀ = w := by ext a b; rw [Matrix.transpose_apply, hw.symm]
  set b := w ⊙ w + (1 / 2 : ℝ) • (w * w + w * w) with hb
  have hbT : bᵀ = b := by
    rw [hb, Matrix.transpose_add, Matrix.transpose_smul, Matrix.transpose_add, Matrix.transpose_mul, hT]
    congr 1
    ext a c; simp [Matrix.hadamard_apply, hw.symm a c]
  rw [foxProd2_coordOp w w hT hT hw.hollow hw.hollow, innerOp2_comm,
    inner_PiQ hij hik hil hjk hjl hkl x y z b hbT]
  have hb' : ∀ a c, b a c = w a c ^ 2 + ∑ m, w a m * w c m := by
    intro a c
    rw [hb, Matrix.add_apply, Matrix.smul_apply, Matrix.add_apply, Matrix.hadamard_apply, mul_self_apply hw, smul_eq_mul]
    ring
  simp only [hb', colT]
  simp only [Finset.sum_add_distrib, ← Finset.mul_sum]
  ring

/-- The norm by columns: `‖coordOp w‖² ≥` the six internal squares plus `∑_{m ∉ Q} |c_m|²`. -/
theorem norm_ge {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) :
    w i j ^ 2 + w k l ^ 2 + w i k ^ 2 + w j l ^ 2 + w i l ^ 2 + w j k ^ 2
      + ∑ m ∈ ({i, j, k, l} : Finset (Fin n))ᶜ, colN i j k l w m ≤ normSq2 (coordOp w) := by
  have hT : wᵀ = w := by ext a b; rw [Matrix.transpose_apply, hw.symm]
  rw [normSq2_coordOp w hT]
  have e : ∀ a c : Fin n, (if a = c then 0 else w a c ^ 2) = w a c ^ 2 := fun a c => by
    split_ifs with h
    · rw [h, hw.hollow]; ring
    · rfl
  simp only [e]
  set Q : Finset (Fin n) := {i, j, k, l} with hQ
  have hsplit : ∀ f : Fin n → ℝ, ∑ a, f a = ∑ a ∈ Q, f a + ∑ a ∈ Qᶜ, f a := fun f =>
    (Finset.sum_add_sum_compl Q f).symm
  have hQsum : ∀ f : Fin n → ℝ, ∑ a ∈ Q, f a = f i + f j + f k + f l := fun f => by
    rw [hQ, Finset.sum_insert (by simp [hij, hik, hil]), Finset.sum_insert (by simp [hjk, hjl]),
      Finset.sum_insert (by simp [hkl]), Finset.sum_singleton]
    ring
  -- `∑_a ∑_b = ∑_{a ∈ Q} ∑_b + ∑_{a ∉ Q} ∑_b`
  have hA : ∑ a, ∑ c, w a c ^ 2 = ∑ a ∈ Q, ∑ c, w a c ^ 2 + ∑ a ∈ Qᶜ, ∑ c, w a c ^ 2 := hsplit _
  -- rows outside `Q`, restricted to columns in `Q`, are the columns `c_m`
  have hB : ∑ a ∈ Qᶜ, colN i j k l w a ≤ ∑ a ∈ Qᶜ, ∑ c, w a c ^ 2 := by
    refine Finset.sum_le_sum fun a _ => ?_
    rw [hsplit (fun c => w a c ^ 2), hQsum]
    have : 0 ≤ ∑ c ∈ Qᶜ, w a c ^ 2 := Finset.sum_nonneg fun c _ => sq_nonneg _
    simp only [colN, hw.symm a i, hw.symm a j, hw.symm a k, hw.symm a l]
    linarith
  -- rows in `Q`: the internal squares twice, plus the columns `c_m`
  have hC : ∑ a ∈ Q, ∑ c, w a c ^ 2
      = 2 * (w i j ^ 2 + w k l ^ 2 + w i k ^ 2 + w j l ^ 2 + w i l ^ 2 + w j k ^ 2)
        + ∑ m ∈ Qᶜ, colN i j k l w m := by
    rw [hQsum]
    simp only [hsplit (fun c => w _ c ^ 2), hQsum, colN, Finset.sum_add_distrib]
    rw [hw.hollow i, hw.hollow j, hw.hollow k, hw.hollow l, hw.symm j i, hw.symm k i, hw.symm l i, hw.symm k j,
      hw.symm l j, hw.symm l k]
    ring
  rw [hA, hC]
  linarith

/-- **`κ ≤ M‖r‖²`** at `r = coordOp w` orthogonal to `Π_Q`, for `M ≥ 0, x, y, z`. -/
theorem kappa_le {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {x y z M : ℝ} (hs : x + y + z = 0)
    (hx : x ≤ M) (hy : y ≤ M) (hz : z ≤ M) (hM : 0 ≤ M)
    (h1 : w i j + w k l = w i k + w j l) (h2 : w i k + w j l = w i l + w j k) :
    innerOp2 (foxProd2 (coordOp w) (coordOp w)) (coordOp (PiQ i j k l x y z)) ≤ M * normSq2 (coordOp w) := by
  rw [kappa_expand hij hik hil hjk hjl hkl hw]
  set Q : Finset (Fin n) := {i, j, k, l} with hQ
  rw [← Finset.sum_add_sum_compl Q]
  have hQsum : ∀ f : Fin n → ℝ, ∑ a ∈ Q, f a = f i + f j + f k + f l := fun f => by
    rw [hQ, Finset.sum_insert (by simp [hij, hik, hil]), Finset.sum_insert (by simp [hjk, hjl]),
      Finset.sum_insert (by simp [hkl]), Finset.sum_singleton]
    ring
  -- the columns in `Q` carry the cross term `Σ`, zero under orthogonality
  have hint : ∑ m ∈ Q, colT i j k l w x y z m
      = x * (w i k + w j l) * (w i l + w j k) + y * (w i j + w k l) * (w i l + w j k)
        + z * (w i j + w k l) * (w i k + w j l) := by
    rw [hQsum]
    simp only [colT]
    rw [hw.hollow i, hw.hollow j, hw.hollow k, hw.hollow l, hw.symm j i, hw.symm k i, hw.symm l i, hw.symm k j,
      hw.symm l j, hw.symm l k]
    ring
  have hcross : x * (w i k + w j l) * (w i l + w j k) + y * (w i j + w k l) * (w i l + w j k)
      + z * (w i j + w k l) * (w i k + w j l) = 0 := by
    have e1 : w i j + w k l = w i l + w j k := h1.trans h2
    linear_combination (w i l + w j k) ^ 2 * hs + (x * (w i l + w j k) + z * (w i l + w j k)) * h2
      + (y * (w i l + w j k) + z * (w i k + w j l)) * e1
  -- the columns outside `Q` by the spectrum
  have hext : ∑ m ∈ Qᶜ, colT i j k l w x y z m ≤ M * ∑ m ∈ Qᶜ, colN i j k l w m := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun m _ => col_bound hs hx hy hz hM _ _ _ _
  have hN := norm_ge hij hik hil hjk hjl hkl hw
  rw [← hQ] at hN
  have hsq : x * (w i j ^ 2 + w k l ^ 2) + y * (w i k ^ 2 + w j l ^ 2) + z * (w i l ^ 2 + w j k ^ 2)
      ≤ M * (w i j ^ 2 + w k l ^ 2 + w i k ^ 2 + w j l ^ 2 + w i l ^ 2 + w j k ^ 2) := by
    have a1 := mul_le_mul_of_nonneg_right hx (add_nonneg (sq_nonneg (w i j)) (sq_nonneg (w k l)))
    have a2 := mul_le_mul_of_nonneg_right hy (add_nonneg (sq_nonneg (w i k)) (sq_nonneg (w j l)))
    have a3 := mul_le_mul_of_nonneg_right hz (add_nonneg (sq_nonneg (w i l)) (sq_nonneg (w j k)))
    nlinarith
  have hN' := mul_le_mul_of_nonneg_left hN hM
  rw [hint, hcross]
  nlinarith

/-- **L220 (8)**: `3κ ≤ θ‖r‖²`, `κ = ⟨r ∘ r, q⟩`, at `x + y + z = 0`, `θ ≥ 0`, `3‖q‖² = θ²`, and `r` Weyl of character
`1` orthogonal to `Π_Q`. This is `L220Statement.theta_sq_le`'s `hκ`. -/
theorem step8 {x y z θ : ℝ} (hs : x + y + z = 0) (hθ : 0 ≤ θ)
    (ha : 3 * normSq2 (coordOp (PiQ i j k l x y z)) = θ ^ 2) {r : CurvOp2 (Fin n)} (hrW : IsWeyl2 r)
    (hr : SignChar (fun _ => 1) r)
    (hperp : ∀ a b c : ℝ, a + b + c = 0 → innerOp2 r (coordOp (PiQ i j k l a b c)) = 0) :
    3 * innerOp2 (foxProd2 r r) (coordOp (PiQ i j k l x y z)) ≤ θ * normSq2 r := by
  obtain ⟨w, hw, rfl⟩ := (L120Ident.trivial_block_iff r hrW).mp hr
  rw [← coordOp_eq_restrict hw] at hperp ⊢
  have hT : wᵀ = w := by ext a b; rw [Matrix.transpose_apply, hw.symm]
  have horth : ∀ a b c : ℝ, a + b + c = 0 →
      a * (w i j + w k l) + b * (w i k + w j l) + c * (w i l + w j k) = 0 := fun a b c h => by
    have := hperp a b c h
    rwa [innerOp2_comm, inner_PiQ hij hik hil hjk hjl hkl a b c w hT] at this
  have h1 : w i j + w k l = w i k + w j l := by have := horth 1 (-1) 0 (by norm_num); linarith
  have h2 : w i k + w j l = w i l + w j k := by have := horth 0 1 (-1) (by norm_num); linarith
  set M := max x (max y z) with hMdef
  have hx : x ≤ M := le_max_left _ _
  have hy : y ≤ M := (le_max_left y z).trans (le_max_right _ _)
  have hz : z ≤ M := (le_max_right y z).trans (le_max_right _ _)
  have hM : 0 ≤ M := by linarith
  -- `9M² ≤ θ²`, from `3 max² ≤ 2(x² + y² + z²) = ‖q‖²`
  rw [normSq2_PiQ hij hik hil hjk hjl hkl] at ha
  have hM2 : 3 * M ^ 2 ≤ 2 * (x ^ 2 + y ^ 2 + z ^ 2) := by
    rcases max_choice x (max y z) with h | h
    · rw [hMdef, h]; exact L220Statement.pattern_entry_sq_le x y z hs
    · rcases max_choice y z with h' | h'
      · rw [hMdef, h, h']
        have := L220Statement.pattern_entry_sq_le y z x (by linarith); linarith
      · rw [hMdef, h, h']
        have := L220Statement.pattern_entry_sq_le z x y (by linarith); linarith
  have h3M : 3 * M ≤ θ := by nlinarith
  have hk := kappa_le hij hik hil hjk hjl hkl hw hs hx hy hz hM h1 h2
  have hr0 : 0 ≤ normSq2 (coordOp w) := by
    rw [normSq2_coordOp w hT]
    refine mul_nonneg (by norm_num) (Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun c _ => ?_)
    split_ifs <;> positivity
  nlinarith

end

end HamiltonsCubic.FourStep8
