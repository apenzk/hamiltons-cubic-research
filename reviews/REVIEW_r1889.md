# REVIEW r1889: I117, sp(k)'s torus system and the equal-weight uniqueness theorem (reader two of two)

Brief: [BRIEF_I117_spk_torus.md](BRIEF_I117_spk_torus.md). Note: [2026-09-28l-I117-g2-torus.md](2026-09-28l-I117-g2-torus.md). Log: [r1889-i117-spk.log](../agent_logs/r1889-i117-spk.log).

**Verdict: every item holds at every k. The torus system is right for all k (derived by hand, then checked on my own construction of sp(k) at k = 2, 3, 4), the s/d decoupling and the trace identity are exact, and the equal-weight theorem's seven steps each follow from the one above. One precision note on the so(2k) identification, affecting no conclusion.**

| item | claim | verdict |
|---|---|---|
| 1 | the torus system at general k | CONFIRMED |
| 2 | the s/d decoupling, invariance of d = 0, positivity | CONFIRMED |
| 3 | the trace identity and the local d-sector criterion | CONFIRMED, the neighbourhood made explicit below |
| 4 | the equal-weight theorem, steps 1 to 7 | CONFIRMED |
| 5 | scope | CONFIRMED, with one precision note |

## Method

I read the chain by hand first and derived each item from the givens. For item 1 I then built sp(k) myself as the commutant in so(4k) of right multiplication by the quaternions i and j on ℍ^k, orthonormalised in the metric ½ tr XᵀY, took the torus spanned by left multiplication by i on each quaternion coordinate, found the root planes as eigenspaces of ad(h)² for a generic torus element, and compared the full product C#C at a random family point (random symmetric Cartan block A, random positive u, p, q) with the note's rows. The script is my own and imports nothing from [screen_I117_sp3_torus.py](../scripts/misc/screen_I117_sp3_torus.py). The runs took about two seconds in total, at k = 2, 3, 4 as stated in advance in the log.

## Item 1: the torus system at general k

- **Root lengths are forced by c.** In any compact simple algebra with I#I = cI in this metric, Σ over positive roots of ααᵀ equals cI on the Cartan (the Killing form is 2c times the metric). For C_k with orthogonal ε_i of common squared length λ, the positive roots 2ε_i and ε_i ± ε_j give Σ ααᵀ = (4 + 2(k − 1))λ Σ ε̂_iε̂_iᵀ = 2cλ·I, so λ = ½ for every k. Hence |2ε_i|² = 2 and |ε_i ± ε_j|² = 1, and ε_i = f_i/√2 in orthonormal Cartan coordinates.
- **The mixed coefficients are forced by I#I = cI.** Each coefficient depends only on the rank-two subsystem holding the triple, and the metric's normalisation (λ = ½) is the same at every k, so the coefficients are k-independent. Reading I#I = cI off the table: a long plane 2ε_i has the k − 1 pairs {ε_i − ε_j, ε_i + ε_j}, so c = 2 + 2(k − 1)·coef, which gives ½. A short plane ε_i − ε_j has two long-short pairs {2ε_i, ε_i + ε_j}, {2ε_j, ε_i + ε_j} and 2(k − 2) short-short pairs, so c = 1 + 2(2·½ + 2(k − 2)·coef), which gives ¼. The ¼ is also the so(2m) value ½ rescaled by the ratio of squared root lengths (1 in sp(k) against 2 in so(2m)), since squared structure constants scale with |α|² under a change of metric.
- **Cartan block.** Σ w_α² ααᵀ gives 2u_i² on the diagonal from the long roots and ½p², ½q² from each short pair, with off-diagonal ½(q² − p²). This is the note's a_i and A_ij.
- **The three rows.** With γᵀAγ equal to 2a_i on 2ε_i and to X∓ on ε_i ∓ ε_j, and each unordered pair entering as 2·coef·w_αw_β, the long row picks up p_ij q_ij, the p-row picks up (u_i + u_j)q_ij and ½(p_il p_jl + q_il q_jl), and the q-row (u_i + u_j)p_ij and ½(p_il q_jl + q_il p_jl). These are the note's rows.
- **Construction.** At k = 2, 3, 4:
  - I#I = cI with c = 3, 4, 5, to an error below 1e-14.
  - The ad(h)² eigenvalues sit exactly at the predicted root values, and the torus and the root planes sum to the identity.
  - C#C at the random point matches the rows (with the general-A form of X±) to 2e-15, 1e-14 and 1e-13 against entries of size 3 to 6.
  - At k = 4 every row has two summation indices l, so the short-short coefficient is tested with several terms per row.

## Item 2: decoupling, invariance, positivity

- With q² − p² = −sd, X∓ = m ± ½sd, so pX⁻ + qX⁺ = ms + ½sd² and pX⁻ − qX⁺ = md + ½s²d. The sum and the difference of the p- and q-rows are then the note's s-row and d-row exactly, the right-hand sides combining to ½Σ s_il s_jl and ½Σ d_il d_jl with sign −(u_i + u_j) on the d-row.
- The long row is Σ pq = ¼Σ(s² − d²), and a_i = 2u_i² + ¼Σ(s² + d²).
- **d = 0 is invariant**: every d-row vanishes identically at d = 0, and the long and s-rows close in (u, s). The uniform point satisfies the s-row: 2k/c² on both sides.
- **Positivity.** The family is Sym²(t) plus one scalar per root plane (the root planes of C_k are pairwise inequivalent torus modules), so C is positive definite exactly when A and every weight are. At a solution A = Σ w²ααᵀ, positive definite once u > 0 since the long roots span t. So positivity is u > 0 and p, q > 0, which is s > |d|.

## Item 3: the trace identity and the criterion

- The d-row is B_ij d_ij = ½(D²)_ij for i ≠ j. Multiplying by d_ij and summing over ordered pairs gives Σ B d² = ½ Σ_{i≠j} d_ij(D²)_ij = ½ tr D³, the diagonal term vanishing since D_ii = 0.
- tr D³ = Σ λ³ ≤ λ_max Σ λ² = λ_max Σ d², so D ≠ 0 with B ≥ β > 0 gives λ_max ≥ 2β. The Gershgorin bound λ_max ≤ max_i Σ_j |d_ij| is strictly below max_i Σ_j s_ij because |d| < s entrywise and each row has at least one off-diagonal entry (k ≥ 2). So 2 min B ≥ max_i Σ_j s_ij forces D = 0. When min B ≤ 0 the hypothesis fails on its own, since the row sums are positive.
- At the uniform point m = u = 1/c and s = 2/c give B = 1 + 1/c − 2/c² and row sums 2(k − 1)/(k + 1) = 2 − 4/c. **The margin 2B − (row sum) is 6/c − 4/c² > 0**, and both sides are continuous in (u, s, d). So the claim holds as stated, on the explicit set of positive solutions where 2 min B ≥ max_i Σ_j s_ij, which contains an open neighbourhood of I/c. With item 4 this makes I/c an isolated positive solution.
- The remark that the crude bound a_i < ½ decides neither side globally is accurate: it gives B > ½ − ½ max s², and the resulting sufficient condition max s² + max row sum ≤ 1 already fails at I/c for k = 2 (4/9 + 2/3 > 1).

## Item 4: the equal-weight theorem

1. **a_i = u_i.** With d = 0 the long row u(1 − 2a) = r/4 and a = 2u² + r/4 give u + 2u² = a(1 + 2u), so a = u. The long row's left side is non-negative with u > 0, so a_i ≤ ½ and hence u_i ≤ ½ (strictly below for k ≥ 2, where r_i > 0).
2. **Matrix equation.** m = ½(u_i + u_j), so the s-row is ½(S²)_ij = s_ij(1 − (3/2)(u_i + u_j)). The diagonal (S²)_ii = r_i = 4u_i − 8u_i². Both are read off 2S − 3(US + SU) + 4U − 8U² entrywise.
3. **Square completion.** With T = S + 3U − I, T² = S² + 3(US + SU) − 2S + 9U² − 6U + I, and substituting step 2 leaves U² − 2U + I = (I − U)². I expanded this by hand.
4. **Equal u.** T commutes with its square, so T_ij((1 − u_j)² − (1 − u_i)²) = 0. T_ij = s_ij > 0, and u ≤ ½ (step 1, available here) keeps 1 − u positive, so u_i = u_j.
5. **Projection.** T² = (1 − u)²I with T symmetric makes T/(1 − u) a symmetric involution, so T = (1 − u)(2Π − I) with Π an orthogonal projection, Π_ii = u/(1 − u) constant and Π_ij = s_ij/(2(1 − u)) > 0.
6. **Rank one.** For a unit x in the range, ⟨|x|, Π|x|⟩ ≥ ⟨x, Πx⟩ = 1 because only off-diagonal terms change and Π_ij > 0. Since ⟨y, Πy⟩ ≤ |y|² with equality exactly on the range, |x| is in the range, and the equality forces x_ix_j ≥ 0 on every pair, so x has constant sign. A zero coordinate x_i would give 0 = Σ_{j≠i} Π_ij x_j with a constant-sign x, forcing x = 0. Any two-dimensional range contains a nonzero vector with a zero coordinate, so the rank is at most one, and it is at least one because Π has nonzero entries. The argument uses no sign condition on the diagonal.
7. **Value.** Π = xxᵀ with x_i² constant gives x = 1/√k and Π = J/k. Then u/(1 − u) = 1/k gives u = 1/(k + 1), the same as the note's 3u − 1 = (1 − u)(2/k − 1), and s = 2(1 − u)/k = 2/(k + 1), so p = q = 1/(k + 1), a = u and A_ij = 0, which is I/c.

## Item 5: scope

- The block labels global uniqueness a conjecture, calls the d-half's global step open, and its *What it gives* claims only the equal-weight sector at every k plus the d-half near I/c. That matches what is shown.
- **Precision note.** "Without the u's this is so(2k)'s torus system" holds after the rescaling (p, q) = 2(U, V), which turns the s- and d-rows into [L271](../findings/second-order.md)'s P and Q equations exactly, with a_i = 2d_i^{L271}. The identification is formal: at u = 0 the long rows force Σ_j p_ij q_ij = 0, which no positive point satisfies. I suggest writing "up to the rescaling (p, q) = 2(U, V)".
- The block's heading still says the system was "read off the construction at k = 3". Item 1 now supports it at every k, and I suggest the heading say so once both readers agree.
