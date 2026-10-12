import Mathlib

set_option linter.style.longLine false

/-!
# L52, the shared-frame majorization bound

## The record's statement, quoted verbatim from [bispectral.md](../../../findings/bispectral.md)

> #### Lemma L52, the shared-frame majorization bound, and what its equality clause needs

> *Conventions: [conventions.md](conventions.md). $W\in\mathrm{Weyl}_n$ with $n\ge4$ and
> $\lVert M\rVert_F=1$; $M_+$ is any constant with $\mu_i\le M_+$, $m$ any constant with
> $\omega_i\ge-m$, both frame-independent.*

> **Statement.** In any orthonormal frame, $M_{(ij),(ij)}=W_{ijij}$ and
> $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=W_{ijij}$ for
> $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$. Writing $K$ for the sectional vector and $K'$ for the
> $\mathring W$ diagonal **in the basis $\{\varphi_{ij},\psi_k\}$ whose $\psi_k$ are an eigenbasis of
> $K$ on $\mathbf1^\perp$**, a stipulation the frame alone does not supply, since the $\psi$-block
> carries $O(n-1)$ of further freedom, **Schur's theorem** gives $K\prec\mu$ and $K'\prec\omega$.
> Majorization alone bounds nothing, $t^3$ being neither convex nor concave; with $\omega_i\ge-m$
> and $\mu_i\le M_+$ the functions $t^3+3mt^2$ and $t^3-3M_+t^2$ are respectively convex on
> $[-m,\infty)$ and concave on $(-\infty,M_+]$, and both diagonals lie in those ranges, giving
>
> $$\theta\ \le\ \tfrac32\big[p_3(K)+3M_+(1-p_2(K))\big]-\tfrac12\big[p_3(K')+3m(p_2(K')-3)\big].$$

> **The inequality needs no Karamata.** The majorization here is the special one where $K$ is a
> diagonal and $\mu$ a spectrum, so $K_i=\sum_j\lvert U_{ij}\rvert^2\mu_j$ with
> $(\lvert U_{ij}\rvert^2)$ doubly stochastic, and Jensen gives the bound row by row, summing
> collapses by the column sums, with no Abel summation and no sorting. *The double stochasticity and Schur's theorem are proved
> and kernel-checked in [SchurMajor.lean](../lean/HamiltonsCubic/Results/SchurMajor.lean) […]*

> **The equality clause needs more than the inequality does, and it is not the clause a consumer
> would write.**
>
> - **The "if" half is false without the $\psi$ stipulation above.** […]
> - **The "only if" half follows row by row, by counting, and needs two strictnesses rather than one.** At
>   equality with $g$ strictly convex, Jensen is tight in every row, so $K_i=\mu_j$ wherever $P_{ij}\ne0$ […]

## What is typed here

The inequality, in full, with the route the record insists on, Jensen row by row, no Karamata and
no sorting.

* `cube_jensen`, the one algebraic fact underneath everything: `(as+bu)³ ≤ as³+bu³` for
  `s, u ≥ 0` and `a+b = 1`, via the exact identity `ab(s-u)²((1+a)s+(2-a)u)`.
* `convexOn_cubePlus` / `concaveOn_cubeMinus`, `t³+3mt²` is convex on `[-m,∞)` and `t³-3M₊t²`
  concave on `(-∞,M₊]`, both from `cube_jensen` and nothing else.
* `jensen_rows_convex` / `jensen_rows_concave`, the row-by-row step: for a doubly stochastic `D`
  and `K = D μ`, `∑ f(K i) ≤ ∑ f(μ j)` for convex `f`, and the reverse for concave `f`. **This is
  where the double stochasticity is consumed, and it is the whole of the "no Karamata" claim.**
* `mu_side` and `omega_side`, the two marginal displays
  `p₃(μ) ≤ p₃(K) + 3M₊(1-p₂(K))` and `p₃(ω) ≥ p₃(K') + 3m(p₂(K')-3)`.
* `majorization_bound`, **the lemma's display.**

**Schur's theorem enters as a hypothesis, in the form the record's own proof uses it**: `K i = ∑ j
D i j * μ j` with `D` doubly stochastic. It is classical, and
[SchurMajor.lean](SchurMajor.lean)'s `diag_doublyStochastic` proves it. The bi-spectral identity `θ = (3/2)p₃(μ) - (1/2)p₃(ω)` is
likewise a hypothesis: it is Dai–Fu Lemma 3.3 at `s = 0`, and it is this record's Lemma L50.

Everything below is proved; there is no `sorry`.

## What is typed elsewhere

**The frame dictionary is not typed in this file**, `M_{(ij),(ij)} = W_{ijij}` and
`⟨W̊ φ_{ij}, φ_{ij}⟩ = W_{ijij}` (L52Frame's `Mpair_diag` and `Bw_diag_pair`), and with them the `ψ`-basis
stipulation the record flags as load-bearing, are statements about the second-kind operator `W̊`, carried in [L52Frame.lean](L52Frame.lean) as
`Bw w (ringW R)`. They are what *produces* the two doubly stochastic matrices, and here those matrices are given.

**The equality clause is not typed here.** It is [L52Equality.lean](L52Equality.lean)'s `L52_matrix_eq`,
`L52_matrix_eq_frame` and `L52_matrix_if` on the matrices and [L52RecordEq.lean](L52RecordEq.lean)'s
`L52_record_eq`, `L52_record_if` and `L52_eq_diagonalises` at the record's objects, with
[L52IfPsi.lean](L52IfPsi.lean)'s `coordDiag_frame`, `coordDiag_of_Mpair`, `L52_if_psi` and `L52_if_psi_S20` in the stipulated basis, and
[L52EqS20.lean](L52EqS20.lean)'s `L52_eq_S20` and `S20_basis_diag` for the "only if" half on `S²₀`.
-/

namespace HamiltonsCubic.L52Statement

open Finset

/-! ## The algebraic core -/

/-- **`(as+bu)³ ≤ as³+bu³` on the nonnegative half-line**, the convexity of the cube in the only
form used below. *The proof is the exact identity
`as³+bu³-(as+bu)³ = ab(s-u)²((1+a)s+(2-a)u)`, symmetric under `(s,a) ↔ (u,b)` because
`2-b = 1+a`.* -/
theorem cube_jensen (s u a b : ℝ) (hs : 0 ≤ s) (hu : 0 ≤ u) (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hab : a + b = 1) : (a * s + b * u) ^ 3 ≤ a * s ^ 3 + b * u ^ 3 := by
  have hale : a ≤ 1 := by linarith
  have key : a * s ^ 3 + b * u ^ 3 - (a * s + b * u) ^ 3
      = a * b * (s - u) ^ 2 * ((1 + a) * s + (2 - a) * u) := by
    have hb' : b = 1 - a := by linarith
    subst hb'; ring
  have hnn : 0 ≤ a * b * (s - u) ^ 2 * ((1 + a) * s + (2 - a) * u) :=
    mul_nonneg (mul_nonneg (mul_nonneg ha hb) (sq_nonneg _))
      (by nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ 1 + a) hs,
        mul_nonneg (by linarith : (0:ℝ) ≤ 2 - a) hu])
  linarith

/-- **`t ↦ t³ + 3mt²` is convex on `[-m, ∞)`.** -/
theorem convexOn_cubePlus (m : ℝ) :
    ConvexOn ℝ (Set.Ici (-m)) (fun t : ℝ => t ^ 3 + 3 * m * t ^ 2) := by
  refine ⟨convex_Ici _, ?_⟩
  intro x hx y hy a b ha hb hab
  simp only [smul_eq_mul, Set.mem_Ici] at *
  have hs : (0 : ℝ) ≤ x + m := by linarith
  have hu : (0 : ℝ) ≤ y + m := by linarith
  have hb' : b = 1 - a := by linarith
  subst hb'
  have hc := cube_jensen (x + m) (y + m) a (1 - a) hs hu ha hb (by ring)
  nlinarith [hc]

/-- **`t ↦ t³ - 3M₊t²` is concave on `(-∞, M₊]`.** -/
theorem concaveOn_cubeMinus (Mp : ℝ) :
    ConcaveOn ℝ (Set.Iic Mp) (fun t : ℝ => t ^ 3 - 3 * Mp * t ^ 2) := by
  refine ⟨convex_Iic _, ?_⟩
  intro x hx y hy a b ha hb hab
  simp only [smul_eq_mul, Set.mem_Iic] at *
  have hs : (0 : ℝ) ≤ Mp - x := by linarith
  have hu : (0 : ℝ) ≤ Mp - y := by linarith
  have hb' : b = 1 - a := by linarith
  subst hb'
  have hc := cube_jensen (Mp - x) (Mp - y) a (1 - a) hs hu ha hb (by ring)
  nlinarith [hc]

/-! ## The row-by-row step

*This is where the double stochasticity is consumed: Jensen inside each row, and the column sums
when the rows are added. There is no sorting and no Abel summation.* -/

variable {ι : Type*} [Fintype ι]

/-- **Doubly stochastic**, in the form Schur's theorem supplies. -/
structure DoublyStochastic (D : ι → ι → ℝ) : Prop where
  nonneg : ∀ i j, 0 ≤ D i j
  rows : ∀ i, ∑ j, D i j = 1
  cols : ∀ j, ∑ i, D i j = 1

/-- **Convex Jensen, row by row.** -/
theorem jensen_rows_convex {D : ι → ι → ℝ} (hD : DoublyStochastic D) {s : Set ℝ} {f : ℝ → ℝ}
    (hf : ConvexOn ℝ s f) (mu K : ι → ℝ) (hmem : ∀ j, mu j ∈ s)
    (hK : ∀ i, K i = ∑ j, D i j * mu j) :
    ∑ i, f (K i) ≤ ∑ j, f (mu j) := by
  have hrow : ∀ i, f (K i) ≤ ∑ j, D i j * f (mu j) := by
    intro i
    have := hf.map_sum_le (t := (univ : Finset ι)) (w := D i) (p := mu)
      (fun j _ => hD.nonneg i j) (hD.rows i) (fun j _ => hmem j)
    simpa [hK i, smul_eq_mul] using this
  calc ∑ i, f (K i) ≤ ∑ i, ∑ j, D i j * f (mu j) := Finset.sum_le_sum fun i _ => hrow i
    _ = ∑ j, (∑ i, D i j) * f (mu j) := by
        rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun j _ => by rw [Finset.sum_mul]
    _ = ∑ j, f (mu j) := Finset.sum_congr rfl fun j _ => by rw [hD.cols j, one_mul]

/-- **Concave Jensen, row by row.** -/
theorem jensen_rows_concave {D : ι → ι → ℝ} (hD : DoublyStochastic D) {s : Set ℝ} {f : ℝ → ℝ}
    (hf : ConcaveOn ℝ s f) (mu K : ι → ℝ) (hmem : ∀ j, mu j ∈ s)
    (hK : ∀ i, K i = ∑ j, D i j * mu j) :
    ∑ j, f (mu j) ≤ ∑ i, f (K i) := by
  have hrow : ∀ i, (∑ j, D i j * f (mu j)) ≤ f (K i) := by
    intro i
    have := hf.le_map_sum (t := (univ : Finset ι)) (w := D i) (p := mu)
      (fun j _ => hD.nonneg i j) (hD.rows i) (fun j _ => hmem j)
    simpa [hK i, smul_eq_mul] using this
  calc ∑ j, f (mu j) = ∑ j, (∑ i, D i j) * f (mu j) :=
        Finset.sum_congr rfl fun j _ => by rw [hD.cols j, one_mul]
    _ = ∑ i, ∑ j, D i j * f (mu j) := by
        rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun j _ => by rw [Finset.sum_mul]
    _ ≤ ∑ i, f (K i) := Finset.sum_le_sum fun i _ => hrow i

/-! ## The two marginal displays -/

/-- The power sums. -/
def p2 (x : ι → ℝ) : ℝ := ∑ i, x i ^ 2

/-- The power sums. -/
def p3 (x : ι → ℝ) : ℝ := ∑ i, x i ^ 3

/-- **The `μ` side: `p₃(μ) ≤ p₃(K) + 3M₊(1 - p₂(K))`**, at `p₂(μ) = 1`. -/
theorem mu_side {D : ι → ι → ℝ} (hD : DoublyStochastic D) (mu K : ι → ℝ) (Mp : ℝ)
    (hcap : ∀ j, mu j ≤ Mp) (hK : ∀ i, K i = ∑ j, D i j * mu j) (hp2 : p2 mu = 1) :
    p3 mu ≤ p3 K + 3 * Mp * (1 - p2 K) := by
  have h := jensen_rows_concave hD (concaveOn_cubeMinus Mp) mu K
    (fun j => Set.mem_Iic.mpr (hcap j)) hK
  have e1 : ∑ j, ((mu j) ^ 3 - 3 * Mp * (mu j) ^ 2) = p3 mu - 3 * Mp * p2 mu := by
    simp only [p3, p2, Finset.sum_sub_distrib, Finset.mul_sum]
  have e2 : ∑ i, ((K i) ^ 3 - 3 * Mp * (K i) ^ 2) = p3 K - 3 * Mp * p2 K := by
    simp only [p3, p2, Finset.sum_sub_distrib, Finset.mul_sum]
  rw [e1, e2, hp2] at h
  linarith

/-- **The `ω` side: `p₃(ω) ≥ p₃(K') + 3m(p₂(K') - 3)`**, at `p₂(ω) = 3`. -/
theorem omega_side {D : ι → ι → ℝ} (hD : DoublyStochastic D) (om K' : ι → ℝ) (m : ℝ)
    (hcap : ∀ j, -m ≤ om j) (hK : ∀ i, K' i = ∑ j, D i j * om j) (hp2 : p2 om = 3) :
    p3 K' + 3 * m * (p2 K' - 3) ≤ p3 om := by
  have h := jensen_rows_convex hD (convexOn_cubePlus m) om K'
    (fun j => Set.mem_Ici.mpr (hcap j)) hK
  have e1 : ∑ j, ((om j) ^ 3 + 3 * m * (om j) ^ 2) = p3 om + 3 * m * p2 om := by
    simp only [p3, p2, Finset.sum_add_distrib, Finset.mul_sum]
  have e2 : ∑ i, ((K' i) ^ 3 + 3 * m * (K' i) ^ 2) = p3 K' + 3 * m * p2 K' := by
    simp only [p3, p2, Finset.sum_add_distrib, Finset.mul_sum]
  rw [e1, e2, hp2] at h
  linarith

/-! ## The lemma -/

variable {κ : Type*} [Fintype κ]

/-- **The shared-frame majorization bound.**

`hbispec` is the bi-spectral identity `θ = (3/2)p₃(μ) - (1/2)p₃(ω)`, Dai–Fu Lemma 3.3 at `s = 0`,
this record's Lemma L50. `hDmu` and `hDom` are Schur's theorem in the form the proof uses it: the
two diagonals are doubly stochastic images of the two spectra. `Mp` and `m` are the record's
frame-independent support constants. -/
theorem majorization_bound
    (mu K : ι → ℝ) (om K' : κ → ℝ) (Dmu : ι → ι → ℝ) (Dom : κ → κ → ℝ) (θ Mp m : ℝ)
    (hDmu : DoublyStochastic Dmu) (hDom : DoublyStochastic Dom)
    (hKmu : ∀ i, K i = ∑ j, Dmu i j * mu j) (hKom : ∀ i, K' i = ∑ j, Dom i j * om j)
    (hMp : ∀ j, mu j ≤ Mp) (hm : ∀ j, -m ≤ om j)
    (hp2mu : p2 mu = 1) (hp2om : p2 om = 3)
    (hbispec : θ = (3 / 2) * p3 mu - (1 / 2) * p3 om) :
    θ ≤ (3 / 2) * (p3 K + 3 * Mp * (1 - p2 K)) - (1 / 2) * (p3 K' + 3 * m * (p2 K' - 3)) := by
  have h1 := mu_side hDmu mu K Mp hMp hKmu hp2mu
  have h2 := omega_side hDom om K' m hm hKom hp2om
  rw [hbispec]
  linarith

/-! ## Non-vacuity -/

/-- **A witness for the binder**, so the bound is not vacuous: the `1×1` matrix `(1)` is doubly
stochastic. -/
example : DoublyStochastic (fun _ _ : Unit => (1 : ℝ)) where
  nonneg := by intro i j; norm_num
  rows := by intro i; simp
  cols := by intro j; simp

end HamiltonsCubic.L52Statement
