# REVIEW r1943: I124 batch 9, the single pair-character branch

Log: [agent_logs/r1943-i124-pairchar.log](../agent_logs/r1943-i124-pairchar.log). Section reviewed: batch 9 of [2026-09-28q-I124-ascent.md](2026-09-28q-I124-ascent.md).

**Verdict.** The derivation is correct at every link and the Lean is sound and non-vacuous. The branch it closes is already closed on the record, more strongly, by [L224](../findings/second-order.md) (no R = 0 hypothesis, no criticality), and the pattern of nu o nu is [L222](../findings/second-order.md) item 2. Classify as agreement with L224 and L222, with the support statement under R = 0 as the one new fact. The "Owed" line should drop the coupled single-pair-character branch.

| # | claim | verdict |
|---|---|---|
| 1 | pattern of nu o nu | CONFIRMED (on the record as L222 item 2, G_x, Lean `Q_nuX`) |
| 2 | diagonal Q, no multiplier | CONFIRMED, citation to correct |
| 3 | three row families | CONFIRMED |
| 4 | two distinct values, elimination | CONFIRMED |
| 5 | support on four vectors, bound | CONFIRMED (u = 0 unused) |
| 6 | screens | CONFIRMED as screens, third one weak at support 2 |
| 7 | Lean pair_char_supp | CONFIRMED |
| 8 | on the record already? | subsumed by L224 for I124's purpose |

## 1. The pattern

By hand, with f_i = phi_ji phi_ki^T + phi_ki phi_ji^T and nu o nu = nu^2 + nu#nu, # through structure constants normalised by I#I = (n-2)I:

- nu^2: f_i f_i' = 0 for i != i', f_i^2 = phi_ji phi_ji^T + phi_ki phi_ki^T. So x_i^2 on (j,i) and (k,i), nothing else.
- nu#nu at (j,k): the pairs (phi_je, phi_ek) contribute -x_e^2 each after the factor 1/2, total -s.
- nu#nu at (i,i'): four ordered terms of x_i x_i', times 1/2, give 2 x_i x_i'. At (j,i) no term survives (the partner of phi_je is phi_ke, never of the form phi_e'i).
- Row sums vanish: row j is sum x_i^2 - s = 0, row i is 2x_i^2 + 2x_i(-x_i) = 0.

This is exactly L222 item 2 (G_x, K_ja = K_ka = x_a^2, K_jk = -|x|^2, K_ab = 2 x_a x_b), kernel-checked as `Q_nuX` in [PairSquare.lean](../lean/HamiltonsCubic/Results/PairSquare.lean). The note derives it afresh and should cite L222.

## 2. Q on the diagonal locus

Correct: for diagonal X with vertex matrix M, (X#X)_{PP} = (1/2) sum c_{P gamma delta}^2 M_gamma M_delta = (M^2)_ab at P = ab, off-diagonal entries of X#X vanish since a pair (gamma, delta) fixes [gamma, delta] up to sign. So Q(M)_ab = M_ab^2 + (M^2)_ab for a != b, exactly, and since Q preserves Weyl tensors no Ricci multiplier can appear. **Correction to the citation**: the "multiplier vanishes" paragraph of [diagonal-half.md](../findings/diagonal-half.md) concerns the Euler-Lagrange equation of P on the constrained diagonal locus. The formula used here is the product itself, which the record states as L222's proof item 2 ("reduces to (S^2)_ab on diagonal tensors") and L224 step 2 ("the diagonal product (A o A)_pq = A_pq^2 + sum_c A_pc A_cq"). Cite those.

## 3. The rows (recomputed)

- (j,k): s^2 + sum_i x_i^4 = -mu s, so mu = -(s^2 + sum x^4)/s. Matches.
- (j,i): x_i^4 + [(-s)x_i^2 + sum_{i' != i} x_i'^2 (2 x_i' x_i)] = mu x_i^2, i.e. -x_i^4 - s x_i^2 + 2 x_i sigma_3 = mu x_i^2. Dividing by -x_i gives x_i^3 + (s + mu) x_i - 2 sigma_3 = 0. Matches, and the row is empty at x_i = 0.
- (i,i') with u = x_i, v = x_i': M_ii'^2 = 4u^2v^2, (M^2)_ii' = M_ij M_ji' + M_ik M_ki' + sum_{e} M_ie M_ei' = 2u^2v^2 + 4uv(s - u^2 - v^2). Total 6u^2v^2 + 4uv(s - u^2 - v^2) = 2 mu uv, so mu = 3uv + 2s - 2(u^2 + v^2) at uv != 0. Matches. At uv = 0 both sides vanish.

## 4. The elimination

- x != 0 (nu is unit) with sum x = 0 has a positive and a negative entry, which are two distinct nonzero values u != v at two indices. Repeated values elsewhere are irrelevant: the argument needs one such pair only, and s >= u^2 + v^2 holds for any two distinct indices.
- Subtracting the two cubics and dividing by u - v: u^2 + uv + v^2 + s + mu = 0. With the (i,i') row: 3s = u^2 - 4uv + v^2. Then s >= u^2 + v^2 gives 2(u + v)^2 <= 0, so v = -u and s = u^2 + v^2, forcing every other x_i to vanish.
- The (j,k) row is not used. It is consistent on the solution: s = 2u^2, sum x^4 = 2u^4 give mu = -3u^2, and the (i,i') row gives -3u^2 + 4u^2 - 4u^2 = -3u^2. The cubic holds with sigma_3 = 0. So the branch is non-empty in the algebra (padded W_CP2, batch 5).

## 5. The conclusion

- Support: nu on phi_{j i1}, phi_{k i1}, phi_{j i2}, phi_{k i2}, and A proportional to M on the pairs of {j,k,i1,i2}. So W is supported on Lambda^2 of a coordinate 4-plane and is padded from R^4 (so(4) is a subalgebra, so Q(W) stays there and theta is unchanged). theta <= M(4) = sqrt(3/2) < theta_0(n) at n >= 12, which is also batch 8's |U| <= 5 clause.
- The hypothesis Q(A) = pA enters only through batch 8's formula A = b^2 pi_D(nu o nu)/(a(theta - ap)), and only proportionality A ∝ M (any nonzero constant c, with mu = cp) is used. **u = 0 is not needed**, neither is batch 6 (1)'s q = 0.
- Cross-check against L224's equality case, which the argument must not contradict: a (j,k)-rotation of an L57 maximiser lies in D_n + V_jk with theta = Theta_n. There pi_D W has a swap-odd part (not proportional to the swap-even G_x) unless the angle is 45 degrees, and at 45 degrees E_ja = (alpha_A + gamma)/2 differs from the proportional value, so R != 0 at those points and batch 9 does not apply. Consistent.

## 6. Screens

The parent's screen script is not in the repository, so I rebuilt the first two independently at n = 6 (seconds, a screen, not evidence): I#I = 4I holds; Q(nu) for a random pair-character x has zero off-diagonal part and diagonal equal to M(x) to 4e-16; Q on a random Ricci-flat diagonal tensor matches M^{o2} + M^2 to 2e-15, with zero off-diagonal part. The note's first two screens test exactly the claims they are attached to. The third is weaker than it reads: every Ricci-flat x of support 2 is (u, -u), so "R = 0 at support 2" samples the theorem's own solution, and only the supports 3 to 6 test anything (they agree).

## 7. Lean

`HamiltonsCubic.I124Circle.pair_char_supp` in [I124Circle.lean](../lean/HamiltonsCubic/Results/I124Circle.lean) states exactly the table's claim (sigma there is the prose sigma_3, the cubic written with 2 sigma). `#print axioms` gives propext, Classical.choice, Quot.sound. Non-vacuity: (u, v, s, mu, sigma) = (1, -1, 2, -3, 0) satisfies every hypothesis, and an application of the theorem to it compiles (scratch file, exit 0). The file carries no witness for this theorem, only for `circle_descent`. Worth adding.

## 8. Record search and classification

- **[L224](../findings/second-order.md) closes this branch, stronger.** Its statement: every unit W in D_n + V_jk has P(W) <= Theta_n, with equality exactly at (j,k)-rotations of L57 maximisers. Batch 9's W = aA + b nu has A in D_n and nu in the pair-character space, which is V_jk, so theta = P(W) <= Theta_n with no R = 0 hypothesis and no criticality. With theta >= Theta_n, W is a rotation of a diagonal maximiser, hence diagonal in another frame, and is excluded from I124's non-diagonal range.
- **The ascent note already had this in view**: batch 6's "Where it sits" bullet says "one pair block is capped at Theta_n by L224", and the [I121 note](2026-09-28-I121-MG-audit.md) line 65 lists L224 among the four cases the record bounds. Batch 6's "What it leaves" and batch 9 then treat the pair character as open, which contradicts that bullet.
- **The pattern** is L222 item 2 with Lean `Q_nuX`.
- **New**: the support statement itself (R = 0 with nu in one pair character forces x = (u, -u) on two indices, so W is padded from R^4), an exact algebraic description of the R = 0 locus in D_n + V_jk that L224 does not state. Its I124 consequence is subsumed.

**Corrections owed in the note.**

1. Classify batch 9 as agreement with L224 (the value bound) and L222 item 2 (the pattern), with the support clause as new.
2. "What it gives" should read: a non-diagonal critical point with theta >= Theta_n has nu over at least two sign characters **in both branches** for a single pair character by L224, and in the R = 0 branch by batch 6 (2) for a four-set. The "Owed" line should drop the single-pair-character part of the coupled branch. Whether L220 closes the single four-set coupled branch too is outside this brief and should be checked against L220's hypotheses.
3. Replace the diagonal-half.md citation in the proof with L222's proof item 2 or L224 step 2.
4. Batch 6's "What it leaves" first clause should be amended the same way.
