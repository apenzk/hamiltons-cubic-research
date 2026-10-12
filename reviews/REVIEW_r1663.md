# Review r1663: L274 (J1 at Q = 0, a degree-refined traceless cubic bound)

Log: agent_logs/r1663.log

Overall: CONFIRMED WITH MINOR GAPS (Lean: statement faithful, file compiles). Every step of the chain was rederived by hand and holds. The gaps are unstated justifications (D_j < 1 in step (5), uniqueness of the large coordinate in step (4), the S = 0 case of the displayed quotient) and one phrase in *What it gives* that names the Λ²₊ edge, a Q ≠ 0 point, in a Q = 0 lemma.

| claim | verdict | reason in one line |
|---|---|---|
| S1 step (1) row Cauchy-Schwarz | CONFIRMED | zero diagonal removes k = i, j from (W²)_ij, row sums over k ≠ i, j are D_i − x_ij and D_j − x_ij, and D_i = 0 rows contribute 0 |
| S2 step (2) pairing | CONFIRMED | Cauchy-Schwarz over ordered pairs i ≠ j with a_ij = 0 off the edge set and b_ij = √(D_iD_j) over all pairs, and Σ_{i≠j} x_ij = S since the diagonal is zero |
| S3 step (3) symmetrisation | CONFIRMED | AM-GM holds for all reals, x_ij = x_ji makes the edge law symmetric, and E[(1 − p_ij)²] = Σ_i π_i h(p_i·) with p_i· on the n = m − 1 points j ≠ i |
| S4 step (4) simplex inequality | CONFIRMED WITH GAPS | identity and case split correct and proved in Lean (L274_simplex). The record's sentence omits that at most one coordinate exceeds 1 − 1/n (two would sum to more than 2 − 2/n ≥ 1) |
| S5 step (5) Cauchy-Schwarz plus Jensen | CONFIRMED WITH GAPS | correct. D_j < 1 is needed and unstated, and holds as D_j ≤ S/2 because S ≥ D_j + Σ_{i≠j} x_ij = 2D_j |
| S6 step (6) algebra and closing | CONFIRMED | (n−1)/n · (1 − (1 + (n²−1)Σπ²)/n²) = (n+1)(n−1)²/n³ · (1 − Σπ²) = K_m²(1 − Σπ²), and the closing gives K_m (S² − ΣD²)/√S |
| S7 equality at J − I, containment, translation to J1 | CONFIRMED WITH GAPS | all three rederived. The displayed quotient is undefined at W = 0 (the Lean form multiplied by √S is the right statement, or add S > 0) |
| S8 What it gives | CONFIRMED WITH GAPS | L273 (3)'s proof is pointwise in X, so J1 at Q = 0 gives H at every torus-invariant X with Q = 0 for m ≥ 5. The Λ²₊ edge sentence must be read at its Q = 0 shadow (a single edge W), and the cocktail-party screen claims are screens and were not checked |
| LEAN fidelity of L274_bound | CONFIRMED | statement is the block's inequality multiplied by √S with the stated hypotheses and constant. The file compiles, the one warning being the sorry in L274_bound (line 96), and L274_simplex compiles clean |

## Method

The chain was read link by link and each step rederived by hand before anything else. One screen of seconds (sage -python, numpy, 20 000 random sparse symmetric zero-diagonal W at each m = 3 to 8) was run and is reported as a screen only: no violation (worst normalised defect (lhs − rhs)/S^{3/2} = −9.8e−5), and the defect at J − I is 0 to within 3e−14. The L274 file was read in full and compiled with lake env lean.

## S1, step (1)

- tr W³ = Σ_{i,j} W_ij (W²)_ji, and the i = j terms vanish with W_ii = 0. (W²)_ij = Σ_k W_ik W_kj with k = i and k = j killed by the zero diagonal.
- Cauchy-Schwarz over k ∉ {i, j}: Σ_{k≠i,j} W_ik² = D_i − x_ij − W_ii² = D_i − x_ij, same for j. Then W_ij (W²)_ij ≤ |W_ij| |(W²)_ij| ≤ √(x_ij (D_i − x_ij)(D_j − x_ij)). Sign of W plays no role.
- D_i = 0 makes row i zero, and every term with that i is 0 on both sides.

## S2, step (2)

- For x_ij > 0 both D_i, D_j > 0, and x(D_i − x)(D_j − x) = x(1 − p_ij)(1 − p_ji) D_i D_j. For x_ij = 0 the term is 0 and a_ij := 0.
- Cauchy-Schwarz over ordered pairs i ≠ j: Σ a_ij b_ij ≤ (Σ a_ij²)^{1/2} (Σ b_ij²)^{1/2}. Σ a_ij² = Σ_{i≠j} x_ij (1 − p_ij)(1 − p_ji) = S · E under the edge law x_ij/S, a probability law on ordered pairs because Σ_{i≠j} x_ij = Σ_i D_i = S. Σ b_ij² = Σ_{i≠j} D_i D_j = S² − Σ D_i² including non-edges and zero-degree vertices. Non-edges are handled correctly.

## S3, step (3)

- (1 − p)(1 − p') ≤ ½(1 − p)² + ½(1 − p')² is (p − p')² ≥ 0.
- x_ij = x_ji, so under the edge law (i, j) and (j, i) are equidistributed and E[(1 − p_ji)²] = E[(1 − p_ij)²]. Then E[(1 − p_ij)²] = Σ_i (D_i/S) Σ_{j≠i} p_ij (1 − p_ij)² = Σ_i π_i h(p_i·), sum over D_i > 0, each p_i· a probability vector on the n = m − 1 indices j ≠ i (zeros included). m ≥ 3 gives n ≥ 2 as step (4) needs.

## S4, step (4)

- Equivalence: with q = Σ p², r = Σ p³, h = 1 − 2q + r and the right side is (n − 1)(1 − q)/n. The inequality becomes (n + 1)q − nr − 1 ≥ 0, which is Σ p(1 − p)(np − 1). Matches.
- Identity: p(1 − p)(np − 1) = n (p − c)²(1 − c − p) + n c(1 − c)(p − c), c = 1/n, and the last term sums to 0. Matches.
- Case split: two coordinates above 1 − 1/n would sum above 2 − 2/n ≥ 1, so at most one. The record's "unless one p_1 = a" leaves this unstated (the working note states it). Minor.
- Bound: Σ_{k≥2} (p_k − c)² ≥ (a − c)²/(n − 1) by Cauchy-Schwarz, times (a − c) ≥ 0, plus (a − c)²(1 − c − a): the bracket is [(n − 1)(1 − c − a) + a − c]/(n − 1) = (n − 2)(1 − a)/(n − 1) using nc = 1. Non-negative since a ≤ 1 and n ≥ 2. The record's expression drops the overall factor n, harmless for the sign.
- L274_simplex proves exactly Σ_k p_k (1 − p_k)(n p_k − 1) ≥ 0 under p ≥ 0, Σ p = 1, n ≥ 2, by this route.

## S5, step (5)

- Σ_i π_i Σ_j p_ij² is invariant under W ↦ tW, so S = 1 is a normalisation, with D_j = π_j.
- Σ_i π_i Σ_j p_ij² = Σ_i Σ_j x_ij²/D_i = Σ_j Σ_{i: D_i>0} x_ij²/D_i. Engel's form of Cauchy-Schwarz over i ≠ j with D_i > 0: at least D_j²/Σ_{i≠j, D_i>0} D_i ≥ D_j²/(1 − D_j), using Σ_i x_ij = D_j by symmetry.
- The division needs D_j < 1, which the record does not say. It holds: S ≥ D_j + Σ_{i≠j} D_i ≥ D_j + Σ_{i≠j} x_ij = 2D_j, so D_j ≤ ½. D_j = 0 gives 0 ≥ 0. Minor gap.
- ψ(t) = t²/(1 − t) − ((n² − 1)/n²) t², and t²/(1 − t) = 1/(1 − t) − 1 − t has second derivative 2/(1 − t)³ ≥ 2 > 2(n² − 1)/n². Convex on [0, 1).
- Jensen over all m = n + 1 vertices, zero-degree ones included, with mean 1/(n + 1): (n + 1)ψ(1/(n + 1)) = (n + 1)[1/(n(n + 1)) − (n − 1)/(n²(n + 1))] = 1/n². So the bound is (1 + (n² − 1) Σ π_i²)/n². Matches.

## S6, step (6)

- Σ π_i h(p_i·) ≤ Σ π_i (n − 1)(1 − Σ_j p_ij²)/n = ((n − 1)/n)(1 − Σ_i π_i Σ_j p_ij²), since Σ π_i = 1 over the D_i > 0 vertices.
- ≤ ((n − 1)/n)(n² − 1)(1 − Σπ²)/n² = (n + 1)(n − 1)²/n³ (1 − Σπ²). K_m² = m(m − 2)²/(m − 1)³ = (n + 1)(n − 1)²/n³. Matches.
- Closing: √(S E) ≤ K_m √(S(1 − ΣD²/S²)) = K_m √((S² − ΣD²)/S), times √(S² − ΣD²) gives K_m (S² − ΣD²)/√S. Needs S > 0.

## S7, equality, containment, translation

- J − I: D_i = n, S = mn, spectrum n, −1 (n times), tr W³ = n³ − n = mn(n − 1). Right side K_m (m²n² − mn²)/√(mn) = [√m (n − 1)/n^{3/2}] · √m n^{5/2} = m n (n − 1). Equality.
- Containment: ΣD² ≥ S²/m gives S² − ΣD² ≤ S² n/m, and K_m n/m = (m − 2)/√(m(m − 1)). Correct.
- Translation (from L271's statement): Q = 0 is U = V, i.e. μ_{εi+εj} = μ_{εi−εj}. Then P = 2U is symmetric with zero diagonal, d_i = Σ_l (U² + V²)_il = ½ Σ_l P_il² = D_i/2, b² = ½‖P‖² = 1 gives S = 2, (A_μ)_ij = −P_ij Q_ij = 0 so g² = Σ d_i² = ΣD²/4, and T = ½ tr P³. L274 at S = 2: ½ tr P³ ≤ K_m (4 − ΣD²)/(2√2) = √2 K_m (1 − g²). √2 K_m = √(2m)(m − 2)/(m − 1)^{3/2} = λ_m. J1 exactly.
- Gap: the displayed statement divides by √S and is undefined at W = 0. Add S > 0, or state it multiplied through as the Lean does.

## S8, What it gives

- L273 (3)'s proof bounds F(X) ≤ 3ag + λ_m(1 − g²) ≤ 3ag + Ψ_κ(g) ≤ κ‖X‖³ using J1 only at X's own (P, Q), with A arbitrary. The case b = 0 (P = Q = 0, which has Q = 0) is handled there separately. So J1 at Q = 0 gives H at every torus-invariant X with μ_{εi+εj} = μ_{εi−εj} for all i < j, m ≥ 5. L274 needs only m ≥ 3, and the threshold is L273 (2)'s. The uniform point has Q = 0 (U = V = u(J − I)). CONFIRMED.
- "At the Λ²₊ edge every step but Jensen in (5) is an equality": the Λ²₊ edge is P_12 = Q_12 = 1/√2, which has Q ≠ 0 and so lies outside L274's setting. Read at its P-part, the single edge W = w(e_12 + e_21), checked by hand: tr W³ = 0 and step (1)'s right side is 0. Step (2)'s Cauchy-Schwarz is 0 = 0. p_12 = p_21 = 1 makes step (3) an equality. h(1, 0, …) = 0 equals step (4)'s bound. Step (5)'s Cauchy-Schwarz gives ½ = ½ at each of the two vertices. Jensen is strict, with the slack K_m²/2 of step (6). True in that reading, and the sentence should name the single-edge W. Minor wording.
- The cocktail-party row bound, the bound T ≤ ½(Γ(P) + Γ(Q)) and the 0.05 failure of the √(d_i d_j) pairing are presented as screens. This review did not check them and they carry no weight in the lemma. "J1 at Q ≠ 0 is open" is a status claim.

## LEAN fidelity

- L274_bound: hypotheses m ≥ 3, Wᵀ = W, W i i = 0. Conclusion trace(W·W·W) · √(Σ_{i,j} W_ij²) ≤ √m (m − 2)/((m − 1)√(m − 1)) · ((Σ_{i,j} W_ij²)² − Σ_i (Σ_j W_ij²)²). (m − 1)√(m − 1) = (m − 1)^{3/2}, the subtractions are in ℝ, D_i is the row sum. For S > 0 this is the block's inequality multiplied by √S, and at S = 0 it reads 0 ≤ 0. Faithful, and the proof is sorry as the table says.
- L274_simplex: as in S4.
- Compile: `lake env lean HamiltonsCubic/Results/L274.lean` from lean/, 28 s, one warning, "declaration uses sorry" at line 96 (L274_bound). No errors, so L274_simplex is proved as the record says.
