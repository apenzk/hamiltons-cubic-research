# Jin 2026, Local Maxima of the Entrywise ℓ₄ Norm on the Orthogonal Group

- **Link**: [arXiv:2607.12431](https://arxiv.org/abs/2607.12431) (v2)
- **Author**: Dian Jin
- **Submitted** 14 July 2026, revised 30 July 2026
- **Retrieved** 2026-09-21

## What it was consulted for

[I106b](../../plan.md)'s open content, typed as `zero_diag_critical_is_isSignedPerm` in [I106bFace.lean](../../lean/HamiltonsCubic/Results/I106bFace.lean): *every zero-diagonal critical point of `⟨A, Q ∘ Q⟩` over `O(k)` is a signed permutation matrix*.

## The verdict

**It settles the same SHAPE of question on the same manifold with the same parametrisation, and its objective is not ours.** Jin maximises `‖Q‖₄⁴ = Σ qᵢⱼ⁴`, which is `⟨R, R⟩` for `R = Q ∘ Q`, QUADRATIC in the orthostochastic matrix. R28's value is `⟨A, R⟩` with `A` fixed of rank two, LINEAR in `R`. So the theorem does not transfer as a citation.

**What does transfer is the method and the precedent.** Jin characterises *all* stationary points rather than only the maxima, showing every non-signed-permutation stationary point carries an explicit rank-two tangent direction of strictly positive second variation, by a maximum-entry pivot on `Q^⊙2` with the full Riemannian Hessian evaluated exactly at a largest non-unit squared entry. **That is the analysis I106b's statement needs, done for a neighbouring objective**, and it handles the cases the screen cannot see: zeros, repeated magnitudes, reducible support, and Hadamard-type stationary points.

**What it does not cover**: the zero-diagonal restriction, which is I106b's whole subject and is absent there, and any weighted objective.

## What the search also returned

The criticality condition for a linear functional `F(U) = Σ Sᵢⱼ Uᵢⱼ` on `O(N)` is that `S Uᵀ` be symmetric, which is the same shape as [asym_factor](../../lean/HamiltonsCubic/Results/I106bFace.lean)'s condition and corroborates the derivation independently of this record.
