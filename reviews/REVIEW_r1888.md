# REVIEW r1888: I117, sp(k)'s torus system, the s/d decoupling and the equal-weight theorem (reader one of two)

Brief: [BRIEF_I117_spk_torus.md](BRIEF_I117_spk_torus.md). Note: [2026-09-28l-I117-g2-torus.md](2026-09-28l-I117-g2-torus.md). Log: [r1888-i117-spk.log](../agent_logs/r1888-i117-spk.log).

**Verdict: every item holds. The torus system is right at every k, the s/d rewrite and the trace identity are exact, and the equal-weight theorem is correct step by step. Two wording corrections (the word "decouples", and the neighbourhood in "near I/c"), none affecting a conclusion.**

| item | claim | verdict |
|---|---|---|
| 1 | the torus system at general k | CONFIRMED |
| 2 | the s/d decoupling, invariance of d = 0, positivity | CONFIRMED, one wording correction |
| 3 | the trace identity and the vanishing criterion near I/c | CONFIRMED, the neighbourhood made explicit |
| 4 | the equal-weight theorem, steps 1 to 7 | CONFIRMED |
| 5 | scope | CONFIRMED |

## Method

Every item was first read and rederived by hand from C_k's root system. The one computation was the bounded construction stated in advance in the log: sp(k) for k = 2, 3 built as the commutant of right quaternion multiplication in so(8) and so(12), orthonormalised in ½ tr XᵀY, with the sharp taken from its own structure constants. The torus is the centraliser of a random element and the root planes are eigenspaces of ad(h)² for a generic torus element h. The run took 21 seconds and imports nothing from [screen_I117_sp3_torus.py](../scripts/misc/screen_I117_sp3_torus.py).

## Item 1: the torus system

- **Root lengths.** Numerically, I#I = (k+1)I holds to 4e-15 at k = 2, 3, and the root planes have |α|² = 2 (k of them) and 1 (k(k−1) of them). By hand, long length 2 forces |ε|² = ½, that is ε_i = f_i/√2 with f orthonormal. The block embedding sp(k′) ⊂ sp(k) is an isometry for ½ tr XᵀY, so the lengths do not depend on k.
- **Mixed coefficients.** Numerically, at k = 3: short plus short onto short is ¼ (12 incidences), short plus short onto long is ½ (6), long plus short onto short is ½ (12). The residual of P_α#P_β against the sum of its plane components is 2.5e-15, every nonzero component sits on a γ with ±α±β = γ, and no product has a Cartan part. A#A = 0, A#P_α = ½(αᵀAα)P_α and P_α#P_α = ααᵀ hold to 6e-15.
- **The coefficients are forced at every k by I#I = cI.** On a long plane 2ε_i the count is 2 + (k−1)·2x_ssl = k+1, so x_ssl = ½. On a short plane ε_i−ε_j it is 1 + 2·2x_ls + (k−2)·2·2x_sss = k+1, which at k = 2 gives x_ls = ½ and at k = 3 gives x_sss = ¼. Since every triple of roots involves at most three indices, it lives in a block sp(3), so the k = 3 values hold at every k. That x_ls equals x_ssl is the total symmetry of the S/4 rule, which this count confirms independently.
- **Cartan block.** A = Σ w_α² ααᵀ with (2ε_i)(2ε_i)ᵀ = 2 f_i f_iᵀ and (ε_i±ε_j)(ε_i±ε_j)ᵀ = ½(f_i±f_j)(f_i±f_j)ᵀ gives a_i = 2u_i² + ½Σ_j(p_ij² + q_ij²) and A_ij = ½(q_ij² − p_ij²), as stated.
- **Rows.** The plane-γ row is w_γ(1 − γᵀAγ) = Σ over unordered pairs of 2·coef·w_α w_β. For 2ε_i, γᵀAγ = 2a_i and the pairs are {ε_i−ε_j, ε_i+ε_j} at ½, giving u_i(1−2a_i) = Σ_j p_ij q_ij. For ε_i∓ε_j, γᵀAγ = m_ij ∓ A_ij = X^∓_ij. The long-short pairs are {2ε_i, ε_i±ε_j} and {2ε_j, ε_i±ε_j} at ½, giving (u_i+u_j) times the partner weight. The short-short pairs per l ∉ {i, j} are {ε_i−ε_l, ε_l−ε_j} and {ε_i+ε_l, ε_j+ε_l} for the difference row, and {ε_i−ε_l, ε_j+ε_l} and {ε_i+ε_l, ε_j−ε_l} for the sum row, at ¼ each, which gives the stated ½Σ_l terms. Every sign is positive since S is a sum of squares.
- **Aside, outside the items.** Setting u = 0, the substitution C = 2C′ carries the system with lengths 1 and coefficient ¼ to one with lengths 2 and coefficient ½ exactly (the Cartan equation, the linear terms and the quadratic terms all scale consistently at λ = 2). That supports the remark that the u-free part is so(2k)'s torus system, assuming L271's system has that table, which I did not re-derive.

## Item 2: the decoupling

- With p = (s+d)/2 and q = (s−d)/2: p² + q² = (s²+d²)/2, pq = (s²−d²)/4 and q² − p² = −sd. So X^∓ = m ± ½sd, and a_i and the long row are as stated.
- Adding the p- and q-rows gives s(1 − m − ½d²) on the left, (u_i+u_j)s and ½Σ_l s_il s_jl on the right. Subtracting gives d(1 − m − ½s²), −(u_i+u_j)d and ½Σ_l d_il d_jl. Both identities are exact.
- **d = 0 is invariant.** Every term of the d-rows carries a factor d, so d = 0 satisfies them identically. Structurally, p = q on every pair is the fixed set of the sign changes ε_j ↦ −ε_j, which are Weyl elements realised in Sp(k), so the sector is #-closed and forces A diagonal, consistent with A_ij = −½ s_ij d_ij = 0.
- **Positivity.** C is positive definite exactly when every plane weight and A are. p, q > 0 is s > |d|, and u > 0 makes A = Σ w² ααᵀ ≥ 2 Σ u_i² f_i f_iᵀ positive definite. So positive definiteness is u > 0 and s > |d|, as stated.
- **Correction (wording).** "Decouples" is right for the quadratic sums, which separate into Σ ss and Σ dd. The two halves still meet through m_ij (a_i carries s² and d²), through the ½d² and ½s² terms and through the long rows. A reader should take "decouples" to mean that the bilinear sums split and that d = 0 is invariant.

## Item 3: the trace identity

- Moving −(u_i+u_j)d to the left gives B_ij d_ij = ½Σ_l d_il d_jl. Multiplying by d_ij and summing over **ordered** pairs i ≠ j gives Σ B_ij d_ij² = ½ tr D³, with D symmetric and zero on the diagonal. Over unordered pairs the right side would be ¼ tr D³, so the ordered sum is the one meant.
- For B ≥ β > 0: β tr D² ≤ ½ tr D³ ≤ ½ λ_max tr D², since λ³ ≤ λ_max λ² for every eigenvalue once λ_max ≥ 0, which holds for a nonzero traceless D. So λ_max ≥ 2β. Gershgorin with zero diagonal gives λ_max ≤ max_i Σ_j |d_ij|, and |d_ij| < s_ij on each nonempty row makes the maximum strictly below max_i Σ_j s_ij. The criterion 2 min B ≥ max_i Σ_j s_ij ⇒ D = 0 follows. It needs no separate positivity of B, since the right side is positive.
- **At I/c**: a_i = 2/c² + (k−1)·(1/c²) = 1/c, so m = 1/c, and B = 1 − 1/c − 2/c² + 2/c = 1 + 1/c − 2/c², above 1 for k ≥ 2. The row sums are 2(k−1)/c = 2 − 4/c.
- **Correction (neighbourhood).** The claim holds in this sense: the set where 2 min B > max_i Σ_j s_ij is open in the weights (u, s, d) and contains I/c, so every positive solution in it has d = 0. The margin at I/c is 2B − (2 − 4/c) = 6/c − 4/c² = (6c−4)/c², which shrinks like 6/k. So the neighbourhood is a stated open set rather than a ball of fixed radius, and its size at I/c degrades with k. Combined with item 4 this makes I/c the unique positive solution in that set.

## Item 4: the equal-weight theorem

- **Step 1.** With d = 0, ¼r_i = a_i − 2u_i² and u_i − 2u_i a_i = a_i − 2u_i² give (u_i − a_i)(1 + 2u_i) = 0, so a_i = u_i, and r_i = 4u_i(1−2u_i). Since r_i > 0 for k ≥ 2, u_i < ½ strictly. The note's "a_i ≤ ½" is also strict, from the long row with Σ_j p_ij q_ij > 0.
- **Step 2.** With m_ij = ½(u_i+u_j), the s-row reads ½(S²)_ij = s_ij(1 − (3/2)(u_i+u_j)), and S's zero diagonal makes (S²)_ij the sum over l ∉ {i, j}. The diagonal is step 1. Both sides of S² = 2S − 3(US+SU) + 4U − 8U² agree entry by entry.
- **Step 3.** T² = S² + 3(SU+US) − 2S + 9U² − 6U + I, and substituting step 2 leaves U² − 2U + I = (I−U)². Checked by hand.
- **Step 4.** [T, T²] = 0 gives T_ij((1−u_j)² − (1−u_i)²) = 0, and T_ij = s_ij > 0 on every off-diagonal pair gives |1−u_i| = |1−u_j|. Only u_i + u_j ≠ 2 is needed to drop the absolute values, and u < ½ from step 1 is available at this point. So all u_i are equal.
- **Step 5.** T² = (1−u)²I with 1−u > 0 makes T/(1−u) a symmetric involution, so T = (1−u)(2Π − I) with Π an orthogonal projection. Π_ii = u/(1−u) is constant and positive, and Π_ij = s_ij/(2(1−u)) > 0.
- **Step 6.** Π has nonnegative entries, so for unit x in its range ⟨|x|, Π|x|⟩ ≥ ⟨x, Πx⟩ = 1 ≥ ⟨|x|, Π|x|⟩, and equality puts |x| in the range. Then |x|_i = Π_ii|x|_i + Σ_{j≠i} Π_ij|x|_j, so a zero coordinate of |x| would force all others to vanish. Hence x has no zero coordinate. The constant sign step is compressed in the note: it follows because x⁺ = (x + |x|)/2 is in the range, and if x had both signs, x⁺ would be a nonzero range vector with a zero coordinate. A two-dimensional range contains a nonzero vector with a zero coordinate, so rank Π ≤ 1, and Π ≠ 0 since its off-diagonal is positive. Correct, and elementary.
- **Step 7.** Π = vvᵀ with v > 0 and constant v_i² gives Π = J/k. Then 3u − 1 = (1−u)(2/k − 1) gives u = 1/(k+1), and s = T_ij = (1−u)·2/k = 2/(k+1), so p = q = 1/(k+1). As a cross-check, Π_ii = u/(1−u) = 1/k. With a_i = u = 1/c and A_ij = 0, this is I/c.
- For k = 1 there are no s-weights. The system is u(1 − 4u²) = 0, whose positive root is ½ = 1/(k+1), so the statement holds there too.

## Item 5: scope

The block claims uniqueness on the sector p = q at every k, which item 4 proves. It claims the d-half only near I/c, which item 3 proves in the sense given there. It records the global d-half as open and calls the full uniqueness a conjecture. So the block claims what it shows. The one sharpening I would add is the neighbourhood statement from item 3, so a later citation does not read "near I/c" as a k-uniform radius.
