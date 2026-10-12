# Jin 2026, extraction

Source: [arXiv:2607.12431v2](https://arxiv.org/abs/2607.12431), Dian Jin, National University of Singapore, submitted 14 July 2026, revised 30 July 2026. Page references are to [the text dump](https://arxiv.org/abs/2607.12431).

## The objective and the group

Throughout, `∘` marks entrywise powers, so `Q^∘2 = (q_ij²)` and `Q^∘3 = (q_ij³)`. The objective (§1) is

$$f_r(Q)=\lVert Q\rVert_4^4=\sum_{i,j=1}^r q_{ij}^4,\qquad Q\in O(r).$$

## The numbered statement

> **Theorem 1 (Complete local-maximum classification).** For every integer $r\ge1$, let $f_r(Q)=\sum_{i,j=1}^r q_{ij}^4$, $Q\in O(r)$. Then: (i) $f_r(Q)\le r$, with equality exactly at the signed permutation matrices; (ii) every signed permutation is a strict local maximum (with the usual vacuous isolated-point interpretation when $r=1$); (iii) if $Q$ is stationary and is not a signed permutation, then there is an explicit nonzero skew-symmetric matrix $\Omega$ such that $\frac{d^2}{dt^2}f_r(Qe^{t\Omega})\big|_{t=0}>0$. Consequently, the signed permutation matrices are exactly the local maximizers of $f_r$ on $O(r)$.

Line 98 of the dump. **Hypotheses: none beyond $Q\in O(r)$ and $r\ge1$.** No genericity, no restriction on the support, no dimension parity.

## The first-order condition, which is the reason this source matters here

> $$Q \text{ is stationary} \iff A=Q^{\mathsf T}Q^{\circ3} \text{ is symmetric.}$$

Line 146. The text adds: *"This uses every tangent direction, not merely coordinate rotations."*

**THAT IS OUR CONDITION WITH A STATE-DEPENDENT WEIGHT.** [I106bFace.lean](../../lean/HamiltonsCubic/Results/I106bFace.lean) has `Qᵀ(A ∘ Q)` symmetric for a FIXED `A` of rank two. Jin has `Qᵀ Q^∘3 = Qᵀ(Q^∘2 ∘ Q)`, which is the same expression with `A = Q^∘2`. So the two criticality conditions are one family: ours is the linear-objective member, his the quartic member where the weight is the point's own squared-entry matrix.

Also recorded at line 164, for the coordinate Givens rotation in columns `a, b`:

> $$f'_{ab}(0)=4\sum_i q_{ia}q_{ib}(q_{ia}^2-q_{ib}^2),\qquad f''_{ab}(0)=4\sum_i\left(6q_{ia}^2q_{ib}^2-q_{ia}^4-q_{ib}^4\right).$$

with the note that (1) vanishes for every pair at a stationary point, *"consistently with the full matrix condition above"*, and that the proof does **not** assume coordinate Givens directions suffice.

## The method

Second-order formula (§5): since `Q''(0) = QΩ²`,

$$f_r''(0)=12\sum_{k,l}q_{kl}^2(Q\Omega)_{kl}^2+4\langle Q^{\circ3},Q\Omega^2\rangle_F,$$

and at a stationary point `A = Aᵀ`, so `⟨Q^∘3, QΩ²⟩_F = tr(AΩ²) = −tr(AΩᵀΩ)`.

**The escaping `Ω` is constructed from a largest entry of `Q^∘2`** (§6, flagged at line 121). The abstract states the argument *"is self-contained and handles zeros, repeated magnitudes, reducible support, and Hadamard-type stationary points"*, which are exactly the cases a numerical screen over random starts cannot see.

## What this settles for I106b, and what it does not

**It does not transfer as a citation.** Jin's objective is `⟨R, R⟩` for `R = Q ∘ Q`, quadratic in the orthostochastic matrix. R28's value is `⟨A, R⟩` with `A` fixed of rank two, linear in `R`. A theorem about the quartic says nothing directly about the linear one.

**What transfers is the method, and it is the method I106b's open statement needs.** The statement typed as `zero_diag_critical_is_isSignedPerm` asserts that zero-diagonal critical points are signed permutations. Jin proves the stronger analogue for his objective, classifying *all* stationary points rather than only the maxima, by exhibiting an escaping direction at any non-signed-permutation stationary point. **The pivot is a largest entry of `Q^∘2`**, and `Q^∘2` is precisely the orthostochastic matrix I106b's face is a face of.

**What is absent there**: the zero-diagonal restriction, which is I106b's whole subject, and any weighted objective. A successor adapting this must supply both.

## Citation graph forward

The second-order machinery is the standard Riemannian Hessian on `O(r)`; the paper is self-contained and cites no result this programme would need to chase.
