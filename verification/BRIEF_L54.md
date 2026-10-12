# Brief, round L54

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the statement as the findings file carries it ([findings/bispectral.md](../findings/bispectral.md) lines 478 and 480, under the heading at line 476)

*Numbered here on 2026-08-31: the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block. The statement is below; **the argument is in this file under "Both-sided Schur–Horn and the vertex-matrix budget are the SAME wall"**.*

Fix a frame $F$ and take the orthonormal basis $\{\varphi_{ij},\psi_k\}$ of $S^2_0$ in which the $\varphi_{ij}$ are the off-diagonal Nienhaus--Petersen--Wink vectors and **the $\psi_k$ are an eigenbasis of $K$ on $\mathbf1^\perp$**, *the eigenbasis is load-bearing and NPW's own staircase $\psi_k$ will not serve*, being fixed by the frame and carrying no dependence on $W$, so a hollow nonzero $K$ is never diagonal in it. In that basis, the diagonal of $\mathring W$ on the $\varphi$-block is exactly $K$, and the $\psi$-block of $\mathring W$ is exactly $-K$ restricted to $\mathbf1^{\perp}$; the diagonal of $M$ in the $\varphi$-basis of $\Lambda^2$ is exactly $K$ as well. Consequently $\sum d_\varphi^2=t/2$ and $\sum d^2=\tfrac32t$ for the full $S^2_0$ diagonal $d$, and Schur--Horn gives $\mu\succ d_\varphi$ and $\omega\succ d$. **[Lemma L94](../findings/bispectral.md#lemma-l94-kappa2le2lvert-mrvert_f2-with-equality-exactly-when-w-is-coordinate-diagonal-in-some-frame) gives $t_F\le2$, with equality exactly when $W$ is coordinate-diagonal in that frame**, the bound is per-frame, and $\kappa^2=\max_Ft_F$ is where the extremal reading belongs. At $t_F=2$ majorization has equal sums *and* equal norms on both sides, so $\mu^\downarrow=d_\varphi^\downarrow$ and $\omega^\downarrow=d^\downarrow$: **Schur--Horn delivers the sorted vectors and nothing more.** *The equality of the vectors themselves is also true and comes more cheaply*: at $t_F=2$ the Cauchy--Schwarz equality already makes $M$ diagonal in the $\varphi$-basis and $\mathring W$ block-diagonal, whence $\mu=d_\varphi$ and $\omega=d$ as vectors.

## Passage B, the canonical statement, landscape form ([results.md](../results.md) line 330)

- **Lemma L54 (second-order). The two diagonals, and rigidity at $t=2$.** In the Nienhaus–Petersen–Wink basis of $S^2_0$ the $\varphi$-diagonal of $\mathring W$ is $K$, the $\psi$-block is $-K$ on $\mathbf 1^\perp$, and the $\varphi$-diagonal of $M$ is $K$ too; so $\mu\succ d_\varphi$, $\omega\succ d$, and at $t=2$ (coordinate-diagonal in some frame), both majorizations are equalities.

## Passage C, the canonical statement, detail form ([results.md](../results.md) line 1082, under the heading at line 1080)

Fix a frame $F$ and take the orthonormal basis $\{\varphi_{ij},\psi_k\}$ of $S^2_0$ whose $\varphi_{ij}$ are the off-diagonal Nienhaus–Petersen–Wink vectors and **whose $\psi_k$ are an eigenbasis of $K$ on $\mathbf1^\perp$**, NPW's own staircase $\psi_k$ will not serve, being fixed by the frame alone. In that basis the diagonal of the second-kind operator $\mathring W$ on the $\varphi$-block is exactly the sectional vector $K$, the $\psi$-block of $\mathring W$ is exactly $-K$ restricted to $\mathbf 1^\perp$, and the diagonal of $M$ in the $\varphi$-basis of $\Lambda^2$ is $K$ as well. Consequently $\sum d_\varphi^2=t/2$ and $\sum d^2=\tfrac32t$ for the full $S^2_0$ diagonal $d$, and Schur–Horn gives $\mu\succ d_\varphi$ and $\omega\succ d$. [Lemma L94](../findings/bispectral.md) gives $t_F\le2$ with equality exactly when $W$ is coordinate-diagonal **in that frame**, and at $t_F=2$ majorization has equal sums and equal norms on both sides, forcing $\mu^\downarrow=d_\varphi^\downarrow$ and $\omega^\downarrow=d^\downarrow$. The equality of the vectors themselves also holds, by the Cauchy–Schwarz equality that makes $M$ diagonal in the $\varphi$-basis there rather than by Schur–Horn. So both-sided Schur–Horn and the vertex-matrix budget are the same wall, and the shared-frame coupling of Lemma L52 is an identity exactly on the diagonal family.

## Passage D, the argument Passage A points at, its identification paragraph ([findings/bispectral.md](../findings/bispectral.md) line 259, under the heading at line 257)

**What $d$ actually is.** $d=(d_\varphi,d_\psi)$ with $d_\varphi$ the entries $K_{ab}$ and $d_\psi=-\{\text{eigenvalues of }K\text{ on }\mathbf1^\perp\}$ ([run_both_diagonals.py](../scripts/runs/run_both_diagonals.py)). So $\sum d^2=\tfrac t2+t=\tfrac32t=\tfrac32\lVert K\rVert_F^2$ is **pure algebra**, with no diagonality of $\mathring W$ anywhere in it. **And $d$ IS the diagonal of $\mathring W$ in an orthonormal basis of $S^2_0$**, *the earlier denial here was wrong, and it mattered.* In the basis $\{E_{ab}\}\cup\{\operatorname{diag}(v_k)\}$ one has $\langle E_{ab},\mathring WE_{ab}\rangle=K_{ab}$ and $\Pi_{\mathrm{diag}}\mathring W\Pi_{\mathrm{diag}}=-K\vert_{\mathbf1^\perp}$, checked at random Weyl tensors, $n=5,6,7$, to $2\times10^{-16}$. *Gate 2, reviewer 132.* **That identification is the only justification $\omega\succ d$ has** (without it the majorization rests on measurement) and it exposes what the apparatus is: $\omega\succ d$ here is **Cauchy interlacing on one compression**, a single Rayleigh quotient with nothing in it to sharpen. *A reimplementation that picked the wrong basis inside $K$'s degenerate eigenspaces fails to reproduce the identity, which is a fact about that basis choice and not about $d$.*

## Passage E, the given the lemma cites for $t_F\le2$: Lemma L94's statement as its heading states it ([findings/bispectral.md](../findings/bispectral.md) line 217)

#### Lemma L94, $\kappa^2\le2\lVert M\rVert_F^2$, with equality exactly when $W$ is coordinate-diagonal in some frame

## Passage F, the definitions, as the file fixes them ([findings/bispectral.md](../findings/bispectral.md) lines 15 and 75)

Let $M$ be $W$ acting on $\Lambda^2$ with $\lVert M\rVert_F=1$, spectrum $\mu$; let $\mathring W$ be the curvature operator of the second kind on $S^2_0$, spectrum $\omega$, in **Li's convention** $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$ ([arXiv:2112.08465](../references/li-2021-nonnegative-second-kind/README.md) eq. (2.2)). Then

**Statement.** In any orthonormal frame, $M_{(ij),(ij)}=W_{ijij}$ and $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=W_{ijij}$ for $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$. Writing $K$ for the sectional vector and $K'$ for the $\mathring W$ diagonal **in the basis $\{\varphi_{ij},\psi_k\}$ whose $\psi_k$ are an eigenbasis of $K$ on $\mathbf1^\perp$**, a stipulation the frame alone does not supply, since the $\psi$-block carries $O(n-1)$ of further freedom, **Schur's theorem** gives $K\prec\mu$ and $K'\prec\omega$. Majorization alone bounds nothing, $t^3$ being neither convex nor concave; with $\omega_i\ge-m$ and $\mu_i\le M_+$ the functions $t^3+3mt^2$ and $t^3-3M_+t^2$ are respectively convex on $[-m,\infty)$ and concave on $(-\infty,M_+]$, and both diagonals lie in those ranges, giving

## Passage G, the Lean statement ([lean/HamiltonsCubic/Results/L54Statement.lean](../lean/HamiltonsCubic/Results/L54Statement.lean), whole file, 222 lines)

```lean
import Mathlib

set_option linter.style.longLine false

/-!
# L54, the two diagonals, and rigidity at `t = 2`

## The record's statement, verbatim

[bispectral.md](../../../findings/bispectral.md)'s *Lemma L54, the two diagonals, and rigidity at
$t=2$*:

> Fix a frame $F$ and take the orthonormal basis $\{\varphi_{ij},\psi_k\}$ of $S^2_0$ in which the
> $\varphi_{ij}$ are the off-diagonal Nienhaus--Petersen--Wink vectors and **the $\psi_k$ are an
> eigenbasis of $K$ on $\mathbf1^\perp$** --- *the eigenbasis is load-bearing and NPW's own
> staircase $\psi_k$ will not serve*, being fixed by the frame and carrying no dependence on $W$,
> so a hollow nonzero $K$ is never diagonal in it. In that basis, the diagonal of $\mathring W$ on
> the $\varphi$-block is exactly $K$, and the $\psi$-block of $\mathring W$ is exactly $-K$
> restricted to $\mathbf1^{\perp}$; the diagonal of $M$ in the $\varphi$-basis of $\Lambda^2$ is
> exactly $K$ as well. Consequently $\sum d_\varphi^2=t/2$ and $\sum d^2=\tfrac32t$ for the full
> $S^2_0$ diagonal $d$, and Schur--Horn gives $\mu\succ d_\varphi$ and $\omega\succ d$.
> **[Lemma L94](bispectral.md) gives $t_F\le2$, with equality exactly when $W$ is
> coordinate-diagonal in that frame** --- the bound is per-frame, and $\kappa^2=\max_Ft_F$ is
> where the extremal reading belongs. At $t_F=2$ majorization has equal sums *and* equal norms on
> both sides, so $\mu^\downarrow=d_\varphi^\downarrow$ and $\omega^\downarrow=d^\downarrow$:
> **Schur--Horn delivers the sorted vectors and nothing more.** *The equality of the vectors
> themselves is also true and comes more cheaply*: at $t_F=2$ the Cauchy--Schwarz equality already
> makes $M$ diagonal in the $\varphi$-basis and $\mathring W$ block-diagonal, whence
> $\mu=d_\varphi$ and $\omega=d$ as vectors.

## What is typed, and where each input sits

The lemma's conclusion is a **rigidity statement about majorization**: two vectors that majorize
and carry the same `2`-norm have the same sorted vector. That is what is stated below, together
with the norm bookkeeping that supplies the hypothesis at `t_F = 2`.

* **Majorization** is defined here from first principles, equal totals, and every partial sum of
  the majorized vector dominated by some equal-sized partial sum of the majorizer. *Mathlib
  carries no majorization theory, so it is built rather than imported.*
* **Schur–Horn** enters as a named hypothesis. It is the one thing the brief allows into a binder:
  a classical, published theorem (Schur 1923) that a real symmetric matrix's diagonal is
  majorized by its spectrum. The record notes that *"only **Schur's** half of Schur–Horn is used,
  not Horn's"*.
* **`t_F ≤ 2`** is [Lemma L94](L94.lean) of this record, proved there and not here; it is a named
  hypothesis with that provenance, exactly as [L62](L62Statement.lean) consumes
  [L59](L59Statement.lean)'s rank equation.
* **`Σd_φ² = t/2`** is proved below from `K` symmetric and hollow. **`Σd_ψ² = t`**, the record's
  *"Correction 1: `Σd² = (3/2)‖K‖_F², not ½` (a threefold undercount"*), is a hypothesis,
  because it is the spectral identification of the `ψ`-block with `−K|_{1^⊥}`.

## What is NOT typed here

**The whole geometric half.** `W̊` (the curvature operator of the second kind on `S²₀`), the
Nienhaus–Petersen–Wink vectors `φ_{ij}`, the matrix `K(F)`, `M` as `W` acting on `Λ²`, and the
statement that the `φ`-block diagonal of `W̊` *is* `K` have no Lean layer:
[WeylReal.lean](../Base/WeylReal.lean) carries `IsWeyl`, `Qop`, `IsCritical`, `Pcubic`, `theta`
and no second-kind operator, no frames and no spectra. So `μ`, `ω`, `d_φ` and `d` are free real
vectors below, and `K` is a bare symmetric hollow matrix.

**The cheaper route the block records**, that at `t_F = 2` Cauchy–Schwarz equality makes `M`
diagonal in the `φ`-basis, whence `μ = d_φ` and `ω = d` **as vectors** rather than up to sorting
needs `M` and the basis and is absent.

**One `sorry`, and what it is.** The rigidity step itself, *majorization plus equal `2`-norms
forces equal sorted vectors*, is stated in full and left unproved; it is the strict Schur-
convexity of `x ↦ Σxᵢ²`, and Mathlib has neither majorization nor Karamata.

## Convention

`‖M‖_F = 1` in [bispectral.md](../../../findings/bispectral.md)'s normalisation, where
`Σμ² = 1` on `Λ²` and `Σω² = 3` on `S²₀`, and `t = t_F = ‖K(F)‖_F²` **per frame** (with
`κ² = max_F t_F` the extremal reading, which is a different quantity,
[conventions.md](../../../findings/conventions.md) records that the two *"have been swapped"*).
-/

namespace HamiltonsCubic.L54Statement

open Finset

/-! ## Majorization -/

/-- **`x` majorizes `y`**: equal totals, and every partial sum of `y` is dominated by an
equal-sized partial sum of `x`. *This is the standard definition with the sorted partial sums
written as a maximum over subsets, which avoids sorting.* -/
def Majorizes {N : Type*} [Fintype N] [DecidableEq N] (x y : N → ℝ) : Prop :=
  (∑ i, x i = ∑ i, y i) ∧
    ∀ S : Finset N, ∃ T : Finset N, T.card = S.card ∧ ∑ i ∈ S, y i ≤ ∑ i ∈ T, x i

/-- **Two vectors have the same sorted vector** when one is a permutation of the other. -/
def SameSorted {N : Type*} [Fintype N] (x y : N → ℝ) : Prop :=
  ∃ σ : Equiv.Perm N, ∀ i, y i = x (σ i)

/-! ## The rigidity step

*"At `t_F = 2` majorization has equal sums **and** equal norms on both sides."* -/

/-- **RIGIDITY: majorization plus equal `2`-norms forces the same sorted vector.**

**This carries the file's single `sorry`.** What is missing is the strict Schur convexity of
`x ↦ Σxᵢ²`, that a doubly stochastic map strictly decreases the `2`-norm unless it is a
permutation, which Mathlib does not have, majorization itself being absent from it. -/
theorem sameSorted_of_majorizes_of_normSq_eq {N : Type*} [Fintype N] [DecidableEq N]
    (x y : N → ℝ) (hmaj : Majorizes x y) (hnorm : ∑ i, x i ^ 2 = ∑ i, y i ^ 2) :
    SameSorted x y := by
  sorry

/-! ## The norm bookkeeping

`Σd_φ² = t/2` is proved; `Σd_ψ² = t` is the spectral identification and is a hypothesis. -/

/-- **`Σ_{a<b} K_{ab}² = t/2`** for `K` symmetric with zero diagonal and `t = ‖K‖_F²`. *This is
the `φ`-block half of the diagonal, indexed by unordered pairs.* -/
theorem sum_offDiag_sq {n : ℕ} (K : Matrix (Fin n) (Fin n) ℝ)
    (hsym : ∀ a b, K a b = K b a) (hhollow : ∀ a, K a a = 0) :
    ∑ p ∈ Finset.univ.filter (fun p : Fin n × Fin n => p.1 < p.2), K p.1 p.2 ^ 2
      = (∑ a, ∑ b, K a b ^ 2) / 2 := by
  classical
  set f : Fin n × Fin n → ℝ := fun p => K p.1 p.2 ^ 2 with hf
  set A := Finset.univ.filter (fun p : Fin n × Fin n => p.1 < p.2) with hA
  set B := Finset.univ.filter (fun p : Fin n × Fin n => p.2 < p.1) with hB
  set C := Finset.univ.filter (fun p : Fin n × Fin n => p.1 = p.2) with hC
  have hsplit : ∑ a, ∑ b, K a b ^ 2 = ∑ p : Fin n × Fin n, f p := by
    rw [← Finset.univ_product_univ, Finset.sum_product]
  -- The complement of `A` splits into `C` (the diagonal) and `B`.
  have hnotA : Finset.univ.filter (fun p : Fin n × Fin n => ¬ p.1 < p.2) = C ∪ B := by
    ext p
    simp only [hB, hC, Finset.mem_union, Finset.mem_filter, Finset.mem_univ, true_and]
    constructor
    · intro h
      rcases lt_trichotomy p.1 p.2 with h' | h' | h'
      · exact absurd h' h
      · exact Or.inl h'
      · exact Or.inr h'
    · rintro (h | h)
      · rw [h]; exact lt_irrefl _
      · exact not_lt.mpr h.le
  have hdisj : Disjoint C B := by
    refine Finset.disjoint_left.mpr ?_
    intro p hp hp'
    simp only [hB, hC, Finset.mem_filter, Finset.mem_univ, true_and] at hp hp'
    rw [hp] at hp'
    exact lt_irrefl _ hp'
  have hCzero : ∑ p ∈ C, f p = 0 := by
    refine Finset.sum_eq_zero fun p hp => ?_
    simp only [hC, Finset.mem_filter, Finset.mem_univ, true_and] at hp
    have : p.1 = p.2 := hp
    simp [hf, ← this, hhollow p.1]
  -- The two off-diagonal halves agree, by the swap bijection and symmetry of `K`.
  have hAB : ∑ p ∈ A, f p = ∑ p ∈ B, f p := by
    refine Finset.sum_nbij' (fun p => (p.2, p.1)) (fun p => (p.2, p.1)) ?_ ?_ ?_ ?_ ?_
    · intro p hp
      simp only [hA, hB, Finset.mem_filter, Finset.mem_univ, true_and] at hp ⊢
      exact hp
    · intro p hp
      simp only [hA, hB, Finset.mem_filter, Finset.mem_univ, true_and] at hp ⊢
      exact hp
    · intro p _; rfl
    · intro p _; rfl
    · intro p _; simp [hf, hsym]
  have htotal : ∑ p : Fin n × Fin n, f p = ∑ p ∈ A, f p + ∑ p ∈ (C ∪ B), f p := by
    rw [← hnotA]
    exact (Finset.sum_filter_add_sum_filter_not Finset.univ _ f).symm
  rw [hsplit, htotal, Finset.sum_union hdisj, hCzero, ← hAB]
  ring

/-- **`Σd² = (3/2)t`**, the record's *Correction 1*: the `φ`-block contributes `t/2` and the
`ψ`-block contributes `t`, so the full `S²₀` diagonal carries `3t/2`, not `t/2`. *The `ψ`-block
value is the spectral identification of that block with `−K|_{1^⊥}` and is a hypothesis.* -/
theorem sum_full_diag_sq (t sphi spsi : ℝ) (hphi : sphi = t / 2) (hpsi : spsi = t) :
    sphi + spsi = (3 / 2) * t := by
  rw [hphi, hpsi]; ring

/-! ## The lemma at `t_F = 2` -/

/-- **`t_F = 2` makes both norm pairs match**: `Σd_φ² = 1 = Σμ²` and `Σd² = 3 = Σω²`. -/
theorem norms_match_at_two (t sphi spsi : ℝ) (ht : t = 2) (hphi : sphi = t / 2)
    (hpsi : spsi = t) : sphi = 1 ∧ sphi + spsi = 3 := by
  subst ht; rw [hphi, hpsi]; norm_num

/-- **THE LEMMA AT `t_F = 2`.** Schur's half of Schur–Horn gives `μ ≻ d_φ` and `ω ≻ d`; at
`t_F = 2` the `2`-norms agree on both sides; so the sorted vectors agree:
`μ↓ = d_φ↓` and `ω↓ = d↓`. *"Schur–Horn delivers the sorted vectors and nothing more."* -/
theorem rigidity_at_t_two {P Q : Type*} [Fintype P] [DecidableEq P] [Fintype Q] [DecidableEq Q]
    (mu dphi : P → ℝ) (om d : Q → ℝ) (t : ℝ)
    -- Schur (1923), classical and external: a symmetric matrix's diagonal is majorized by its
    -- spectrum.
    (hschur_phi : Majorizes mu dphi) (hschur_full : Majorizes om d)
    -- Lemma L94 of this record, proved there: `t_F ≤ 2`, with equality exactly at
    -- coordinate-diagonal `W`; here read at the equality case.
    (ht : t = 2)
    -- The normalisation `‖M‖_F = 1`, in which `Σμ² = 1` and `Σω² = 3`.
    (hmu : ∑ i, mu i ^ 2 = 1) (hom : ∑ i, om i ^ 2 = 3)
    -- The two diagonals, from the block's own bookkeeping.
    (hdphi : ∑ i, dphi i ^ 2 = t / 2) (hd : ∑ i, d i ^ 2 = (3 / 2) * t) :
    SameSorted mu dphi ∧ SameSorted om d := by
  subst ht
  refine ⟨sameSorted_of_majorizes_of_normSq_eq mu dphi hschur_phi ?_,
    sameSorted_of_majorizes_of_normSq_eq om d hschur_full ?_⟩
  · rw [hmu, hdphi]; norm_num
  · rw [hom, hd]; norm_num

/-! ## Non-vacuity

Majorization is satisfiable, and the rigidity hypothesis is reachable, so nothing above is
empty. -/

/-- **A witness**: a vector majorizes itself, with equal norms, and the sorted vectors agree at
the identity permutation. -/
example {N : Type*} [Fintype N] [DecidableEq N] (x : N → ℝ) :
    Majorizes x x ∧ SameSorted x x :=
  ⟨⟨rfl, fun S => ⟨S, rfl, le_refl _⟩⟩, ⟨Equiv.refl N, fun _ => rfl⟩⟩

/-- **A witness for the hollow symmetric `K`** at `n = 2`: `K = ![![0,1],![1,0]]` has
`t = ‖K‖_F² = 2`, which is exactly the equality case of [L94](L94.lean), and one off-diagonal
pair carrying `1 = t/2`. -/
example :
    (∑ a : Fin 2, ∑ b : Fin 2, (![![0, 1], ![1, 0]] : Matrix (Fin 2) (Fin 2) ℝ) a b ^ 2) = 2 := by
  simp [Fin.sum_univ_two]
  norm_num

end HamiltonsCubic.L54Statement

```

## Definitions beyond Passage F

- A frame $F$ is an orthonormal basis $e_1,\dots,e_n$; $K=K(F)$ is the $n\times n$ symmetric hollow matrix $K_{ab}=W_{abab}$ of sectional curvatures, $t_F=\lVert K(F)\rVert_F^2=\sum_{a\ne b}K_{ab}^2$, and $\kappa(W)=\max_F\lVert K(F)\rVert_F$.
- For real vectors, $x\succ y$ ($x$ majorizes $y$) means equal sums and every sum of the $k$ largest entries of $y$ is at most the sum of the $k$ largest of $x$; $x^\downarrow$ is $x$ sorted decreasingly.

## What to attack, beyond the standing list

1. **The identification**: that in the stated basis the $\varphi$-block diagonal of $\mathring W$ is exactly $K$, the $\psi$-block of $\mathring W$ is exactly $-K$ on $\mathbf1^\perp$, and the $\varphi$-diagonal of $M$ is $K$. **Whether a derivation of each is on file in Passages A to F, or only a check**; whether "block" means the diagonal or the whole compression, and why the $\psi_k$ must be an eigenbasis of $K$.
2. **The sums**: $\sum d_\varphi^2=t/2$ and $\sum d^2=\tfrac32t$, including whether $K\mathbf1=0$ is used and where it comes from.
3. **Schur–Horn**: which half is used, and whether $\mu\succ d_\varphi$ is legitimate when $d_\varphi$ is the diagonal of $M$ in a basis of $\Lambda^2$ and $\omega\succ d$ when $d$ is the diagonal of $\mathring W$ in a basis of $S^2_0$; the lengths of the vectors compared.
4. **The given**: whether Passage E's statement, about $\kappa^2=\max_F t_F$ with equality "in some frame", supplies what Passage A uses, a per-frame $t_F\le2$ with equality "exactly when $W$ is coordinate-diagonal in that frame". **Whether any proof of Passage E is quoted, and whether Passage G's claim that it is "proved there" is borne out.**
5. **The rigidity**: that majorization with equal sums and equal $2$-norms forces equal sorted vectors, at both pairs; and whether "equal norms on both sides" holds at $t_F=2$ given the normalisations $\sum\mu^2=1$, $\sum\omega^2=3$.
6. **The cheaper route**: that at $t_F=2$ a Cauchy–Schwarz equality makes $M$ diagonal in the $\varphi$-basis and $\mathring W$ block-diagonal, whence $\mu=d_\varphi$ and $\omega=d$ as vectors. **Which Cauchy–Schwarz, and whether it is written anywhere.**
7. The canonical forms against the findings form, including Passage B's "(coordinate-diagonal in some frame)" against Passage A's "in that frame".
8. Whether Passage G's Lean statements type what they say, whether its one `sorry` is the claim it names, and whether each named hypothesis excludes anything.
9. The boundary: $n=4$, odd $n$, $t_F=0$, and $\ker W\ne0$.

