# Review r1664: L275 (J1 on the face P = Q, the edge family)

Log: agent_logs/r1664.log

Overall: CONFIRMED WITH GAPS, no step refuted (Lean: statement faithful, file compiles). Every link of the chain was rederived by hand and holds for every m ≥ 4. The gaps are unstated one-line justifications (R_ij ≥ e_ij e_ji, the index set of the Cauchy-Schwarz in step (4)), the equality sentence (both sides vanish at a single edge, so the equality is 0 = 0), and the corollary to H resting on the prose of L273 (3) without the caveat L274 carries.

| claim | verdict | reason in one line |
|---|---|---|
| S1 step (1) row Cauchy-Schwarz | CONFIRMED | identical to L274 (1): zero diagonal removes k = i, j from (U²)_ij, and the row sums over k ≠ i, j are e_ij = D_i − x_ij and e_ji |
| S2 step (2) R_ij ≥ e_ij e_ji and pairing | CONFIRMED WITH GAPS | R_ij − e_ij e_ji = x_ij (e_ij + e_ji) ≥ 0 and R_ij ≥ 0 from x_ij ≤ min(D_i, D_j), both unstated. R_ij = 0 forces e_ij e_ji = 0, so dropping those pairs is right |
| S3 step (3) f = 2ab/(a+b) and symmetrisation | CONFIRMED | a + b = 2(1 − pq)/((1+p)(1+q)) gives the identity, HM ≤ AM, a ≤ 1 − p, and Σ x_ij (1 − p_ij) = S − Σ_i D_i ρ_i = S Σ π_i (1 − ρ_i). Lean L275_pair proves the cleared form |
| S4 step (4) column sum and Cauchy-Schwarz | CONFIRMED WITH GAPS | the rearrangement, the column form at S = 1 and 1/π_i − κ > 0 all hold. Unstated: the Cauchy-Schwarz runs over i with x_ij > 0, whose β_i sum to at most B − β_j since β ≥ 0 |
| S5 step (5) chord, Titu, factorisation | CONFIRMED | chord slope is γ = 2κ/(2 − κ), Titu gives s² over s(1+γs) − Σπ³ − γΣπ⁴, both power bounds lower the denominator, and the factorisation and sign conditions check (Lean L275_close) |
| S6 step (6) closing constant | CONFIRMED | Σ_i π_i² ρ_i = Σ x_ij²/S², so κ(1 − s − Σπ²ρ) = κ ΣR/S², and (2) gives tr U³ ≤ λ_m ΣR/√S |
| S7 range m ≥ 4 and κ = λ_m² | CONFIRMED | κ_m = 2m(m−2)²/(m−1)³ = 2K_m² = λ_m² is increasing (log-derivative (m+2)/(m(m−1)(m−2)) > 0), κ_4 = 32/27 > 4 − 2√2, κ_m < 2 for all m, and κ_3 = 3/4 fails |
| S8 translation to J1 at V = 0, What it gives | CONFIRMED WITH GAPS | L271's definitions give P = Q = U, d_i = D_i, b² = S, g² = ΣD_i² + Σ x_ij², T = tr U³. Gaps: the equality at a single edge is 0 = 0, and "H there" rests on L273 (3) being pointwise, which the Lean L273_J1_implies_H does not provide |
| LEAN fidelity of L275_bound | CONFIRMED | the block's statement with Σ_{i≠j} R_ij written as S² − ΣD_i² − Σ_{i,j} U_ij⁴ (diagonal terms vanish), the same λ_m and hypotheses. File compiles, the only warning the sorry at line 47 |

## Method

The chain was read link by link and each step rederived by hand before anything else. One screen of seconds (sage -python, numpy, 20 000 random sparse symmetric zero-diagonal U at each m = 4 to 8) was run and is reported as a screen only: no violation of the displayed inequality or of step (4)'s claim, the minimum normalised defect being 0 in both, reached at single-edge samples. L275.lean was read in full and compiled with lake env lean.

## S1, step (1)

- tr U³ = Σ_{i≠j} U_ij (U²)_ij with (U²)_ij = Σ_{k≠i,j} U_ik U_kj, and Cauchy-Schwarz over k gives |(U²)_ij| ≤ √(e_ij e_ji). Rows with D_i = 0 contribute 0.

## S2, step (2)

- e_ij e_ji = D_iD_j − x(D_i + D_j) + x², so R_ij − e_ij e_ji = x(D_i + D_j) − 2x² = x(e_ij + e_ji) ≥ 0. The block states R ≥ ee' without this line.
- R_ij ≥ 0 since D_i, D_j ≥ x_ij. R_ij = 0 forces e_ij e_ji = 0, so the term √(x ee') vanishes and the pair drops from both sums consistently.
- Cauchy-Schwarz: Σ √(x ee'/R) √R ≤ √(Σ x ee'/R) √(Σ R).

## S3, step (3)

- For x_ij > 0, ee' = D_iD_j (1−p)(1−q) and R = D_iD_j (1 − pq), so x ee'/R = x f(p, q).
- a + b = 2(1 − pq)/((1+p)(1+q)) and 2ab = 2(1−p)(1−q)/((1+p)(1+q)), so 2ab/(a+b) = f. HM ≤ AM needs a, b ≥ 0 and a + b > 0, which is pq < 1, true when R > 0.
- a = (1−p)/(1+p) ≤ 1 − p for p ∈ [0, 1]. So f ≤ ½(2 − p − q). Lean L275_pair proves 2(1−p)(1−q) ≤ (2−p−q)(1−pq) on p, q ≥ 0, which is the same bound cleared of 1 − pq > 0.
- Σ_{i≠j} x_ij ½(2 − p_ij − p_ji) = Σ x_ij (1 − p_ij) by symmetry of x, and this is S − Σ_i Σ_j x_ij²/D_i = S − Σ_i D_i ρ_i = S Σ_i π_i (1 − ρ_i).

## S4, step (4)

- κ Σ_{i≠j} R_ij / S² = κ(1 − s − Σ_{i,j} x_ij²/S²) and Σ_i π_i² ρ_i = Σ_{i,j} x_ij²/S², so the right side of the claim is κΣR/S². With Σπ_i = 1 the claim rearranges to Σ_i π_i (1 − κπ_i) ρ_i ≥ 1 − κ + κs. Both sides are scale invariant, so S = 1 is a normalisation.
- At S = 1, π_i ρ_i = Σ_j x_ij²/D_i and π_i² ρ_i = Σ_j x_ij², giving Σ_j Σ_i x_ij² (1/π_i − κ) over i with D_i > 0.
- π_i ≤ ½ because S ≥ D_i + Σ_{j≠i} x_ji = 2D_i, and κ < 2 (S7), so κπ_i < 1.
- For fixed j, Cauchy-Schwarz over I_j = {i : x_ij > 0} gives Σ_{i∈I_j} x_ij² w_i ≥ π_j² / Σ_{i∈I_j} β_i with w_i = 1/β_i. I_j excludes j, and β ≥ 0, so Σ_{I_j} β_i ≤ B − β_j. This index set and the drop to B − β_j are unstated. For π_j > 0 the denominator is positive.

## S5, step (5)

- Trivial case: 1 − κ + κs ≤ 0 iff s ≤ 1 − 1/κ.
- t ↦ 1/(1 − κt) is convex on [0, ½] (κ < 2), with values 1 and 2/(2 − κ) at the ends, so the chord is 1 + γt with γ = 2κ/(2 − κ), and β_i ≤ π_i (1 + γπ_i).
- B − β_j = Σ_{i≠j} β_i ≤ 1 − π_j + γ(s − π_j²) =: d_j. Upper bounds on positive denominators lower the fractions.
- Titu: Σ_j π_j²/d_j = Σ (π_j²)²/(π_j² d_j) ≥ s² / (s(1+γs) − Σπ³ − γΣπ⁴). Σπ³ ≥ s² is Cauchy-Schwarz (Σπ^{1/2}π^{3/2})² ≤ Σπ Σπ³, and Σπ⁴ ≥ s³ is Jensen for t³ under the law π. Both enter with a minus sign, so the denominator is at most s + γs² − s² − γs³ = s(1 − s)(1 + γs), which gives s/((1−s)(1+γs)).
- 1 + γs = (2 − κ + 2κs)/(2 − κ). The factorisation s(2−κ) − (κs + 1 − κ)(1−s)(2 − κ + 2κs) = (1 − 2s)((κ−1) − (κ(1−s) − 1)²) is proved by ring in L275_close.
- Signs: s ≤ max π ≤ ½. s ≥ 1 − 1/κ gives κ(1−s) ≤ 1 and s ≤ ½ gives κ(1−s) ≥ κ/2, so (κ(1−s) − 1)² ≤ (1 − κ/2)², and κ − 1 − (1 − κ/2)² = −¼(κ² − 8κ + 8), positive on (4 − 2√2, 4 + 2√2). L275_close takes exactly these hypotheses.

## S6, step (6)

- (3) to (5) give Σ x ee'/R ≤ S Σπ(1−ρ) ≤ Sκ ΣR/S² = κΣR/S. Then (2) gives tr U³ ≤ √(κΣR/S) √(ΣR) = λ_m ΣR/√S, and multiplying by √S gives the statement. At S = 0, U = 0 and both sides are 0.

## S7, range m ≥ 4

- κ_m = 2m(m−2)²/(m−1)³ and K_m² = m(m−2)²/(m−1)³, so κ = 2K_m² = λ_m².
- κ < 2 iff m(m−2)² < (m−1)³ iff m² − m − 1 > 0, true for m ≥ 2. Used for 1/π_i − κ > 0 and the chord on [0, ½].
- The log-derivative 1/m + 2/(m−2) − 3/(m−1) has numerator m + 2 over m(m−1)(m−2), positive, so κ_m increases. κ_4 = 32/27 ≈ 1.1852 > 4 − 2√2 ≈ 1.1716 (exactly: 2√2 > 76/27 since 8 > 5776/729). So κ > 4 − 2√2 for every m ≥ 4, used in the bracket of (5). κ_3 = 3/4 is below, so m ≥ 4 is where the proof's range ends.
- The working note (reviews/2026-09-27-I117-J1.md, line 79) heads the proof "m ≥ 5". The record's m ≥ 4 is the correct range.

## S8, translation to J1 and What it gives

- L271: U_ij = μ_{ε_i−ε_j}, V_ij = μ_{ε_i+ε_j}, P = U + V, Q = U − V, d_i = Σ_l (U_il² + V_il²), (A_μ)_ii = d_i and (A_μ)_ij = −P_ij Q_ij. At V = 0: P = Q = U, d_i = D_i, b² = ½(‖P‖² + ‖Q‖²) = S, g² = ΣD_i² + Σ_{i≠j} x_ij², T = tr U³. At S = 1, 1 − g² = Σ_{i≠j} R_ij and L275 reads T ≤ λ_m(1 − g²), which is J1.
- The Λ²₊ edge is P_12 = Q_12 = 1/√2 (working note line 19), so V = 0 and it lies on the face. There tr U³ = 0 and ΣR = 0: the equality "at a single edge" is 0 = 0, both sides vanishing. At J − I the bound is strict (m = 4: 24√12 against λ_4 · 96, that is 24 against about 30.2 after dividing by √S). The block should say the equality is both sides vanishing.
- "H there for m ≥ 5 by L273 (3)": L273 (3)'s prose proof uses J1 only at the point X, so this holds. The Lean L273_J1_implies_H takes J1 on the whole sphere, and L274's block records that caveat while L275's does not.
- "J1 at mixed (P, Q) is open" agrees with the working note's closing batch.

## LEAN

- L275_bound: hypotheses 4 ≤ m, Uᵀ = U, U_ii = 0. S = Σ_{i,j} U_ij². Right side λ_m (S² − Σ_i D_i² − Σ_{i,j} U_ij⁴) with λ_m = √(2m)(m − 2)/((m − 1)√(m − 1)). Σ_{i≠j} D_iD_j = S² − ΣD_i² and Σ_{i≠j} x_ij² = Σ_{i,j} U_ij⁴ because the diagonal is zero. Faithful.
- L275_pair and L275_close are as described in the block and are proved. lake env lean HamiltonsCubic/Results/L275.lean exits 0 with one warning, the sorry in L275_bound (line 47).
