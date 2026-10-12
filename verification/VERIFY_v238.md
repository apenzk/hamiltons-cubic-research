# Verifier v238, L45: the ten-triple census of the cubic, the (Y,Y,W) coupling, the W-parity two-sided bound, the classification against Xu and Huisken, and the Lean statement file

The brief was cold. No numerical work was done, every value is exact, and no scripts were written: every identity below is derived by hand from the definitions and from the filed sources read at source (Huisken p. 53 read from the PDF page image, since the text extraction is garbled there). No Lean build was run, and the Lean file was read and compared verbatim against Passage E. Log: agent_logs/verify-L45-v238.log.

Independence note: checking the quotation of Passage A at [findings/target.md](../findings/target.md) lines 742-767 displayed lines 744-756, which carry an earlier review's grading of this block. Every derivation below was made from the definitions and the sources, and the verdicts are this verifier's.

| # | Claim | Verdict |
|---|---|---|
| 1 | Census: ten distinct triples, five vanish identically, five survive with multiplicities 1,3,1,3,1, and the displayed expansion | CONFIRMED |
| 2 | A mechanism for each vanisher (I,I,Y), (I,I,W), (I,Y,W), (I,W,W), (Y,W,W) | CONFIRMED |
| 2a | Total symmetry of T is used by the written argument and cited there | GAP (used for the weights 3, cited nowhere in Passage D) |
| 3 | (Y,Y,W) contributes 3/(n-2)&lt;W, Ric0 wedge Ric0&gt;, weight 3 times trilinear value 1/(n-2) | CONFIRMED |
| 4 | Against the slice exactly one new coupling | CONFIRMED (reading: surviving triple joining W to a non-W factor) |
| 5 | Omega_0 membership invariant under W to -W | CONFIRMED |
| 6 | W-parity of every piece of both sides of the criterion | CONFIRMED |
| 6a | RHS_even and RHS_odd defined in Passages A to D | GAP (undefined in A, B, C, and defined in words only in D) |
| 7 | The two-sided bound, and RHS_even - LHS_even >= 0 | CONFIRMED |
| 8 | Classification: Xu Lemma 2.8 eq. (2.34) is the same identity term for term, attributed by Xu to Huisken, and Passage C "the expansion is Huisken's, term for term" | CONFIRMED |
| 9 | Lean: two_sided, even_gap_nonneg, cubic_odd, omega0_sign_symmetric, the census theorems, coupling_split | CONFIRMED AS ALGEBRA |
| 9a | Lean: slice_odd types the on-slice fact its docstring names | GAP (its conclusion is its hypothesis) |
| 10 | Boundary: n = 3, 4, odd n, Y = 0, W = 0, c <= 0, ker W != 0 | CONFIRMED (n >= 3 required and unstated) |
| 11 | Passage C's proof pointer reaches the proof | REFUTED AS STATED ([results.md](../results.md) line 384 links target.md, which carries the statement and no proof) |

Summary for the round: the mathematics is correct, and the round should write n >= 3, the normalisation of wedge and Ric0, and RHS_even, RHS_odd as the W-even and W-odd parts of the right-hand side into the statement, cite BW08 eq. (5) for the weights, repoint the proof link to problem.md, and restate or remove the Lean theorem slice_odd.

## 0. Conventions, fixed once

- V = Lambda^2 R^n, pairing &lt;A,B&gt; = tr(A o B), I the identity, so ||I||^2 = n(n-1)/2. In the orthonormal basis e_i^e_j (i&lt;j) an operator T has matrix entries T_ijkl, so &lt;T,S&gt; = (1/4) sum over all indices of T_ijkl S_ijkl.
- Wedge as in BW08 eq. (3): id^id = I, (A^B)_ijkl = (1/2)(A_ik B_jl + B_ik A_jl - A_il B_jk - B_il A_jk).
- # as in BW08 eq. (4). Phi(R) = R^2 + R^#, Phi(A,B) = (1/2)(AB+BA) + A#B, T(A,B,C) = &lt;A, Phi(B,C)&gt; = (1/2) tri(B,C,A) with tri from BW08 eq. (5).
- Ric is BW08's (Huisken's): Ric(I) = (n-1) id, lambda-bar = tr Ric / n, R_I = (lambda-bar/(n-1)) I, Y = R_Ric0 = (2/(n-2)) Ric0 ^ id (BW08 eq. (3)). So c = lambda-bar/(n-1).
- The lower-case ric inside F is Beitz's, ric = Ric/2. This is forced by F(I) = 2/(n-1) and it is what makes the brief's "equivalently" true (Section 5). The criterion is invariant under rescaling ric, and the parity argument uses no normalisation.
- Two exact facts used repeatedly, derived here from the BW08 Lemma 2.2 diagonal formula. In an eigenbasis of Ric0 with eigenvalues lambda_i (sum lambda_i = 0, p2 = sum lambda_i^2 = |Ric0|^2, p3 = sum lambda_i^3), Y is diagonal with Y_ij = (lambda_i + lambda_j)/(n-2), so ||Y||^2 = sum_{i&lt;j}(lambda_i+lambda_j)^2/(n-2)^2 = (n-2)p2/(n-2)^2 = p2/(n-2).

## Hypothesis inventory

| Source | Hypotheses at source | Object applied to | Holds | Used by the proof |
|---|---|---|---|---|
| Statement (A, C, D) | R = cI + Y + W, Y = R_ric0. No dimension stated. The bound premises: the criterion at cI+Y+W and at cI+Y-W | an algebraic curvature operator in SB^2(so(n)) | n >= 3 is needed for 1/(n-2) and for 4/(n-2), and n >= 4 for W != 0. The brief's definitions say n >= 4 | yes |
| Xu Prop 2.7 (1)-(5) | R, S in the named components of SB^2(so(n)). Its proof uses Xu (2.29) = BW08 Lemma 2.1, Xu (2.26) = BW08 (6), symmetry of tri, and (inside items (4), (5)) that Q maps SB^2 into SB^2, which Xu uses without statement | I, Y, W | yes | (1), (2), (4), (5) for the vanishers and for ric(Phi(R)), with (3) named explicitly |
| Xu Lemma 2.8, eq. (2.34) | stated for R in S^2(so(n)), proved through the decomposition (2.6), which lives on SB^2 | R = cI+Y+W in SB^2 | yes | classification only |
| Xu Lemma 2.6, eq. (2.31) | R of Ricci type | Y | yes | the coupling value (same as BW08 Lemma 2.2) |
| BW08 Lemma 2.1 | R in SB^2 | I (gives Phi(I) = (n-1)I), W (gives W + W#I = 0) | yes | the constant (n-1) of (I,I,I), and Xu (3). Not cited in D, reached through Xu's proof of Prop 2.7 |
| BW08 Lemma 2.2 | R of Ricci type | Y, which is of Ricci type with lambda-bar = 0 and Ric0(Y) = Ric0(R), since Ric(cI) is a multiple of id and Ric(W) = 0 | yes | (Phi(Y))_W = (1/(n-2))(Ric0^Ric0)_W |
| BW08 eq. (5) | tri symmetric in all three slots (proved there from (4)) | T | yes | USED BUT NOT CITED in Passage D: the multiplicities 3 on (I,Y,Y) and (Y,Y,W) need it (Section 2a) |
| BW08 eq. (6) | eigenbasis of Ric | through Xu (2.26) | yes | inside Xu (4) |
| Huisken 1985, proof of Thm 3.3, p. 53 | the pointwise decomposition (1.1) and Bianchi | the cubic 2R R R + (1/2) R R R = 4&lt;R,Phi(R)&gt; | yes | classification only |

Unstated but used: n >= 3, the normalisation of wedge and Ric0 (the value 3/(n-2) is convention-dependent), orthogonality of the decomposition under the trace pairing, and total symmetry of T.

## 1. The census and the expansion

T(R,R,R) = &lt;R,Phi(R)&gt; expands over the 27 ordered triples of summands {cI, Y, W}. Multisets of size 3 over three symbols number C(5,2) = 10, with multinomial weights 3!/(i!j!k!). Grouping ordered triples into multisets with that weight uses total symmetry of T (Section 2a).

Survivors, each value exact:

- (I,I,I), weight 1: Phi(I) = I + I#I, and BW08 Lemma 2.1 at R = I gives I + I#I = Ric(I)^id = (n-1)I. Contribution c^3(n-1)||I||^2.
- (I,Y,Y), weight 3: contribution 3c&lt;I,Phi(Y)&gt;. Value: scal(Phi(Y)) = tr of BW08's third identity at lambda-bar = 0, which is n sigma = p2, and scal(kI) = kn(n-1), so (Phi(Y))_I = (p2/(n(n-1))) I and &lt;I,Phi(Y)&gt; = p2/2. Nonzero whenever Ric0 != 0.
- (Y,Y,Y), weight 1: &lt;Y,Phi(Y)&gt;. From the diagonal formula, Phi(Y)_ij = lambda_i lambda_j/(n-2) + (p2 - lambda_i^2 - lambda_j^2)/(n-2)^2. Using sum_{i&lt;j}(lambda_i+lambda_j) lambda_i lambda_j = -p3, sum_{i&lt;j}(lambda_i+lambda_j) = 0, sum_{i&lt;j}(lambda_i+lambda_j)(lambda_i^2+lambda_j^2) = (n-2)p3, the value is -p3/(n-2)^2 - (n-2)p3/(n-2)^3 = -2p3/(n-2)^2.
- (Y,Y,W), weight 3: Section 3.
- (W,W,W), weight 1: &lt;W,Q(W)&gt;.

Total weight 1+3+1+3+1 = 9. The vanishers carry 3,3,6,3,3 = 18, and 9 + 18 = 27. The displayed expansion in Passages A, C, D is exactly the sum of the five survivors with these weights. The W-parity labels are correct: the first three terms are W-independent, 3&lt;W,Phi(Y)&gt; is linear in W, &lt;W,Q(W)&gt; is cubic.

No finding: the census, the multiplicities 1,3,1,3,1 in Passage C, and the display are correct.

## 2. A mechanism for each vanisher

Each ordered representative is shown to vanish individually, so the vanishing holds without total symmetry. All citations are Xu Prop 2.7 items plus orthogonality of &lt;I&gt;, &lt;Ric0&gt;, &lt;W&gt; under the trace pairing.

| Triple | Ordered forms | Mechanism |
|---|---|---|
| (I,I,Y) | &lt;I,Phi(I,Y)&gt;, &lt;Y,Phi(I)&gt; | Phi(I,Y) in &lt;Ric0&gt; by (2), orthogonal to I. Phi(I) in &lt;I&gt; by (1), orthogonal to Y |
| (I,I,W) | &lt;I,Phi(I,W)&gt;, &lt;W,Phi(I)&gt; | Phi(I,W) = 0 by (3). Phi(I) in &lt;I&gt; by (1) |
| (I,Y,W) | &lt;I,Phi(Y,W)&gt;, &lt;Y,Phi(I,W)&gt;, &lt;W,Phi(I,Y)&gt; | Phi(Y,W) in &lt;Ric0&gt; by (5). Phi(I,W) = 0 by (3). Phi(I,Y) in &lt;Ric0&gt; by (2) |
| (I,W,W) | &lt;I,Q(W)&gt;, &lt;W,Phi(I,W)&gt; | Q(W) in &lt;W&gt; by (4). (3) |
| (Y,W,W) | &lt;Y,Q(W)&gt;, &lt;W,Phi(Y,W)&gt; | (4). (5) |

Located in the written argument: Passage D cites "Xu Prop 2.7" as a whole and names item (3) for the I-W pairings. Items (1), (2), (4), (5) are not named at the vanishers (item (5) is named in the parity paragraph), but they sit in the cited proposition. No finding on the vanishers.

### 2a. Total symmetry of T

Location: Passage D, "Xu Prop 2.7 plus BW08 Lemma 2.2 ... determine every one of the ten distinct triples", followed by the display with coefficients 3.

Failure, in closed form: without total symmetry, the ordered triples of (Y,Y,W) sum to &lt;W,Phi(Y)&gt; + 2&lt;Y,Phi(Y,W)&gt;, and Phi(Y,W) lies in &lt;Ric0&gt; by Xu (5), so &lt;Y,Phi(Y,W)&gt; is not killed by any cited block fact. Equating it to &lt;W,Phi(Y)&gt; is exactly tri(Y,W,Y) = tri(W,Y,Y), BW08 eq. (5). Similarly (I,Y,Y) sums to &lt;I,Phi(Y)&gt; + 2&lt;Y,Phi(I,Y)&gt;. (Consistency: Phi(I,Y) = Y + Y#I = ((n-2)/2)Y by BW08 Lemma 2.1, so &lt;Y,Phi(I,Y)&gt; = ((n-2)/2)(p2/(n-2)) = p2/2 = &lt;I,Phi(Y)&gt;, as symmetry predicts.)

Charitable reading: BW08 eq. (5) is a filed theorem, Xu restates it at (2.33), and problem.md cites it a few lines earlier in the same section. That section cites it as "not load-bearing here" for the slice, which does not cover the off-slice weights. The citation is owed, the mathematics stands. Finding kept as a citation GAP.

## 3. The (Y,Y,W) value

Location: Passage A "the triple (Y,Y,W), equal to 3/(n-2)&lt;W, Ric0^Ric0&gt;".

Derivation: T(W,Y,Y) = &lt;W,Phi(Y)&gt; = &lt;W,(Phi(Y))_W&gt;, since W is orthogonal to &lt;I&gt; and &lt;Ric0&gt;. BW08 Lemma 2.2 second identity (Xu (2.31)) applied to Y gives (Phi(Y))_W = (1/(n-2))(Ric0^Ric0)_W, independent of lambda-bar. So the trilinear value is (1/(n-2))&lt;W,Ric0^Ric0&gt; and the weight is 3, contribution 3/(n-2)&lt;W,Ric0^Ric0&gt;.

Normalisations it needs: wedge with id^id = I and Y = (2/(n-2)) Ric0^id, and Ric with Ric(I) = (n-1)id. In Beitz's ric = Ric/2 the same contribution reads (12/(n-2))&lt;W, ric0^ric0&gt;. In index form, &lt;A^A, W&gt; = (1/2) A_ik A_jl W_ijkl, used in Section 8.

Candidate (wording, "the triple equal to 3/(n-2)"): the trilinear value of the triple is 1/(n-2), not 3/(n-2). Charitable reading: every passage displays the term as 3&lt;W,Phi(Y)&gt;, so "the triple" names its contribution to the expansion. Withdrawn at step 3 (Section 12).

## 4. "Against the slice exactly one new coupling"

The slice is Y = 0 (problem.md's scope paragraph: Conjecture A is the R_ric0 = 0 slice). Counts of survivors absent from the slice:

- surviving triples absent from the slice: three, (I,Y,Y), (Y,Y,Y), (Y,Y,W).
- mixed surviving triples absent from the slice: two, (I,Y,Y) and (Y,Y,W).
- surviving triples joining W to a non-W factor: one, (Y,Y,W). On the slice the only such triples are (I,I,W) and (I,W,W), both vanishers.

The claim is true under the third count, which the same sentence supports ("every I-W pairing vanishes", and the W-odd underbrace). "Coupling" is defined nowhere. The candidate under the first two readings is recorded as withdrawn in Section 12.

## 5. Omega_0 under W to -W

||cI+Y-W||^2 = ||cI+Y+W||^2 by orthogonality, and ric(W) = 0, so ric(R), scal(R) and F(R) are unchanged. Hence both clauses of Omega_0 and the level set F = 4/(n-2) are W-even. This holds in any Ricci normalisation.

The brief's equivalent form holds with ric = Ric/2 only. Exactly: ||R||^2 = c^2 n(n-1)/2 + p2/(n-2) + ||W||^2 and ||Ric||^2 = n lambda-bar^2 + p2 with lambda-bar = (n-1)c. With ric = Ric/2, ||R||^2 <= (4/(n-2))||ric||^2 reduces to ||W||^2 <= (n/(n-2))||R_I||^2, the p2 terms cancelling. With ric = Ric the reduction is ||W||^2 <= (4n(n-1)^2/(n-2) - n(n-1)/2)c^2 + 3p2/(n-2), which reads Ric0. Problem.md's surrounding text fixes Beitz's normalisation, so Passage D's constraint is correct. No finding.

## 6. W-parity of both sides

- LHS: Section 1.
- RHS = F(R)&lt;ric(R), ric(Phi(R))&gt;. F(R) and ric(R) are W-even (Section 5). Phi(R) = Phi(cI+Y) + 2Phi(cI+Y, W) + Q(W). Phi(cI,W) = 0 by Xu (3). ric(Q(W)) = 0 by Xu (4). So ric(Phi(R)) = ric(Phi(cI+Y)) + 2 ric(Phi(Y,W)), the second term linear in W and lying in the Ric0 directions by Xu (5). It is generally nonzero: polarising Xu (2.26) gives Ric(Phi(Y,W)) = (1/2) W-ring(Ric0), since Y-ring applied to Ric(W) = 0 vanishes.
- So RHS_even = F(R)&lt;ric(R), ric(Phi(cI+Y))&gt; and RHS_odd = F(R)&lt;ric(R), 2ric(Phi(Y,W))&gt;, which are exactly the even and odd parts of W to RHS(cI+Y+W).

No finding on the parity. Passage D names Xu (5) and not Xu (3), (4) for "the only W-dependent piece", a citation detail only.

### 6a. Are RHS_even and RHS_odd defined?

Location: Passage A, "|LHS_odd - RHS_odd| <= RHS_even - LHS_even, LHS_odd = 3&lt;W,Phi(Y)&gt; + &lt;W,Q(W)&gt;", and the same in Passage C, the canonical statement. LHS_odd is defined there, LHS_even is defined by the underbrace, RHS_even and RHS_odd are defined in neither, nor in Passage B. Passage D defines them in words only ("the only W-dependent piece of ric(Phi(R)) is 2Phi(Y,W)").

Failure: the canonical inequality has two undefined symbols, so a reader of Passage C alone cannot evaluate it. Charitable reading: the even and odd parts of any function of W are canonical, and Section 6 shows D's words give exactly those. Under that reading the statement is true, so the finding is a statement GAP and the mathematics is unaffected.

## 7. The two-sided bound

Premises for fixed (c,Y,W): the criterion at cI+Y+W, LHS_e + LHS_o <= RHS_e + RHS_o, and at cI+Y-W, which by Sections 1 and 6 reads LHS_e - LHS_o <= RHS_e - RHS_o. The first gives LHS_o - RHS_o <= RHS_e - LHS_e, the second -(LHS_o - RHS_o) <= RHS_e - LHS_e, so |LHS_o - RHS_o| <= RHS_e - LHS_e. Adding the premises gives RHS_e - LHS_e >= 0. The premise at -W is available wherever the criterion is demanded on a W-reflection-invariant set, and Section 5 makes Omega_0 and its boundary such sets.

No finding. The bound is conditional on the criterion at both points, as Passages A and C say ("demanding the criterion at both signs gives").

## 8. Classification against Xu and Huisken, read at source

Xu Lemma 2.8, eq. (2.34), at source (xu-2412.13633.txt lines 516-526): &lt;Q(R),R&gt; = (n/(2(n-1)))lambda-bar^3 + (3/(2(n-1)))lambda-bar|Ric0|^2 + (3/(n-2))&lt;Ric0^Ric0,W&gt; - (2/(n-2)^2)&lt;(Ric0^2)_0,Ric0&gt; + &lt;Q(W),W&gt;. Passage D's quotation matches. Term match with c = lambda-bar/(n-1):

- c^3(n-1) n(n-1)/2 = n lambda-bar^3/(2(n-1)).
- 3c(p2/2) = 3 lambda-bar p2/(2(n-1)).
- (Y,Y,W): Section 3, identical.
- -2p3/(n-2)^2, and &lt;(Ric0^2)_0,Ric0&gt; = tr Ric0^3 = p3.
- &lt;W,Q(W)&gt;.

The order (I,I,I), (I,Y,Y), (Y,Y,W), (Y,Y,Y), (W,W,W) is Xu's. Xu line 516 says the identity "was derived by Huisken in his proof of the Theorem 3.3 in [16]" and "was not written down as an independent lemma". Passage D's attribution matches.

Huisken 1985, p. 53, read from the page image: the cubic 2R_ijkl R_imkn R_jmln + (1/2)R_ijkl R_klmn R_mnij is split by the projection of its first factor into rows U, V, W, with
U-row = (2/(n(n-1))) R S,
V-row = (4/(n(n-1))) R (S - R^2/n) - (8/(n-2)^2) tr Ric0^3 + (4/(n-2)) Ric0_ik Ric0_jl W_ijkl,
W-row = 2WWW + (1/2)WWW + (2/(n-2)) Ric0_ik Ric0_jl W_ijkl,
with R = scal = n lambda-bar and S = |Ric|^2 = p2 + R^2/n. By Xu (2.27) Huisken's cubic is 4&lt;Q(R),R&gt;. Collecting the rows: R^3 coefficient 2/(n^2(n-1)), giving 2n lambda-bar^3/(n-1) = 4 times Xu's first term. R p2 coefficient 2/(n(n-1)) + 4/(n(n-1)) = 6/(n(n-1)), giving 6 lambda-bar p2/(n-1) = 4 times Xu's second. tr Ric0^3: -8/(n-2)^2 = 4 times Xu's. The W coupling 6/(n-2) Ric0_ik Ric0_jl W_ijkl = 4 times (3/(n-2))(1/2) Ric0_ik Ric0_jl W_ijkl = 4 times Xu's (Section 3's index form). The Weyl cubic is 4&lt;Q(W),W&gt;.

Candidate against Passage C's "the expansion is Huisken's, term for term": Huisken's display is organised by first-factor projection, and his W coupling is split 4/(n-2) + 2/(n-2) across two rows, his (I,I,I) and (I,Y,Y) mixed across U and V through S. Charitable reading: after collecting monomials the five terms coincide one to one with the five survivors, up to the global factor 4 of his normalisation. Withdrawn at step 3 (Section 12). Passage D's novelty remark that the parity argument is absent from Xu is a negative claim about a source, screened only by searching Xu's text for a W to -W reflection, none found. It carries no weight in the lemma.

## 9. The Lean statements (Passage E)

The file [lean/HamiltonsCubic/Results/L45Statement.lean](../lean/HamiltonsCubic/Results/L45Statement.lean) matches Passage E verbatim (the brief says 157 lines, wc counts 156 newlines, the content diff is empty).

- two_sided: binders Le Lo Re Ro : R, hplus : Le + Lo <= Re + Ro, hminus : Le - Lo <= Re - Ro, conclusion |Lo - Ro| <= Re - Le. Directions agree with Section 7. Neither hypothesis holds for every quadruple (Le = 1, Lo = Re = Ro = 0 falsifies hplus), so it excludes something and says something. CONFIRMED AS ALGEBRA. The link from the curvature objects to hminus (the parity of Section 6) is untyped, as the module doc says.
- even_gap_nonneg: correct, CONFIRMED AS ALGEBRA.
- cubic_odd: Q : V to V with Q(-x) = Q x gives &lt;-x, Q(-x)&gt; = -&lt;x, Q x&gt;. Correct. The hypothesis excludes non-even Q.
- omega0_sign_symmetric: for every predicate phi on R, phi ||-W|| iff phi ||W||. True by norm_neg. The substantive fact of Section 5, that Omega_0's clauses depend on W only through ||W|| (orthogonality and ric(W) = 0), is assumed by the shape phi ||W|| and not typed. The module doc's "free of the curvature layer" discloses this.
- Census: weight (i,j,k) = 3!/(i!j!k!) in N, exact since the multinomial is an integer. survivors = [(3,0,0),(1,2,0),(0,3,0),(0,2,1),(0,0,3)] = (I,I,I),(I,Y,Y),(Y,Y,Y),(Y,Y,W),(W,W,W), vanishers = [(2,1,0),(2,0,1),(1,1,1),(1,0,2),(0,1,2)] = (I,I,Y),(I,I,W),(I,Y,W),(I,W,W),(Y,W,W), matching Section 1. Weights [1,3,1,3,1] and [3,3,6,3,3], sums 9 and 18, ten_triples over Fin 4 cubed (each exponent at most 3, so Fin 4 suffices) counts 10. Correct. Which list is called "survivors" is by definition, and the module doc states that the identification with the terms of the cubic is untyped. Exhaustiveness (the two lists are all ten triples) follows from ten_triples, degrees and Nodup by counting, and is not a stated theorem.
- coupling_split: hx : x != 2 is unused by the proof (rw, push_cast, ring), and the conclusion 3/(x-2) = 3 * (1/(x-2)) also holds at x = 2 under Lean's division by zero. The hypothesis excludes an object at which the conclusion is still true, so it weakens the theorem harmlessly. The variable is a real x, unconnected to a dimension n >= 3.
- Stale text: the module doc and survivor_weights' docstring say results.md records "1,3,3,6". [results.md](../results.md) line 382 now records 1,3,1,3,1, and "1,3,3,6" occurs nowhere in results.md. The docstrings describe a canon state that no longer exists.

### 9a. slice_odd

Location: `theorem slice_odd (P : V → ℝ) (hP : ∀ x : V, P (-x) = -P x) (x : V) : P (-x) = -P x := hP x`, docstring "P(-W) = -P(W) on the slice, which is the same fact and is why the two-sidedness is empty there: 𝒲ₙ is linear and the cubic is odd on it."

Failure: the conclusion is the hypothesis at x, and the proof term is hP x. For every P the theorem is either vacuous (P not odd) or a restatement (P odd). It mentions no slice, no 𝒲ₙ, no linearity and no two-sidedness.

Charitable reading: the docstring's "which is the same fact" labels it a restatement kept for indexing. The claim "is why the two-sidedness is empty there" is still attached to a statement that types none of it. Finding kept: GAP, the on-slice fact is untyped.

## 10. The boundary

- n = 2: 1/(n-2) and 4/(n-2) are undefined. The statement needs n >= 3 and states no range. The brief's definitions give n >= 4.
- n = 3: &lt;W&gt; = 0, so W = 0 is forced. The expansion holds with its last two terms zero, LHS_odd = RHS_odd = 0, and the bound reduces to RHS_even >= LHS_even, the criterion itself. Nothing breaks.
- n = 4: BW08 Lemma 2.1 is verified directly at n = 4 at source, Xu Prop 2.7 holds, and W to -W flips W+ and W- together. No finding.
- Odd n: no step uses the parity of n. No finding.
- Y = 0: (Y,Y,W) and RHS_odd vanish (Phi(0,W) = 0), LHS_odd = &lt;W,Q(W)&gt;. Consistent with problem.md's remark. No finding.
- W = 0: both odd parts vanish and the bound is the criterion. No finding.
- c <= 0: tr R = c n(n-1)/2 and scal = c n(n-1), so Omega_0 and the domain of F are empty. The expansion is an algebraic identity valid for all c, and the bound's premises are unavailable. No finding.
- ker W != 0 (zero-padded Weyl): no step uses nondegeneracy of W. Xu Prop 2.7 is stated for all of &lt;W&gt;, and BW08's proof of Lemma 2.1 for n >= 5 goes through exactly this padding. No finding.

## 11. The proof pointer

Location: Passage C, [results.md](../results.md) line 384, "**Proof:** [target.md](findings/target.md)".

Failure: [findings/target.md](../findings/target.md) lines 742-767 carry the heading, a set of notes and the statement of Passage A, and line 769 opens Lemma L49. There is no derivation of the census, the coupling or the parity argument there. The argument is Passage D, in [findings/problem.md](../findings/problem.md) lines 76-92.

Charitable reading: the notes at target.md lines 744-756 contain fragments of the argument (the Phi(I,W) = 0 mechanism, the parity remark). They are commentary on the statement and do not derive the display or the bound. Finding kept: REFUTED AS STATED.

## 12. Withdrawn candidates

- "(Y,Y,W) equal to 3/(n-2)" read as the trilinear value. (1) Passage A line 762. (2) T(W,Y,Y) = (1/(n-2))&lt;W,Ric0^Ric0&gt;. (3) Every passage displays 3&lt;W,Phi(Y)&gt;, so "the triple" names its contribution. Withdrawn.
- "exactly one new coupling" read as "one survivor absent from the slice" or "one mixed survivor absent from the slice". (1) Passage A line 762, Passage B, Passage C. (2) Three survivors are absent from the slice, two of them mixed ((I,Y,Y) has value 3c p2/2, nonzero for c != 0, Ric0 != 0). (3) The same sentence's "every I-W pairing vanishes" fixes the reading as couplings of W to the rest, under which the count is one. Withdrawn.
- "the expansion is Huisken's, term for term". (1) Passage C. (2) Huisken p. 53 groups by first-factor projection, the W coupling split across two rows. (3) After collection the five monomials match the five survivors with ratio 4 throughout (Section 8). Withdrawn.
- The brief's Omega_0 "equivalently" as a defect. (1) Brief definitions. (2) With ric = Ric the reduced condition reads Ric0. (3) The record's F uses Beitz's ric = Ric/2, under which the equivalence is exact (Section 5), and the parity argument needs no normalisation. Withdrawn.

## Answers to the fixed list

1. Hypothesis inventory: the table above. Used but unstated: n >= 3, the wedge and Ric0 normalisation, total symmetry of T (BW08 eq. (5)), orthogonality of the decomposition under the trace pairing. Xu's proof of Prop 2.7 uses Bianchi preservation by Q without stating it, a standard fact carried by the source.
2. Quantifier order and scope: the expansion holds for every n >= 3 and every R in SB^2(so(n)), with c, Y, W the components of R. The bound holds for each (c,Y,W) at which the criterion holds at both cI+Y+W and cI+Y-W, and there is no hidden existential. The reflection invariance of Omega_0 holds for all (c,Y,W). No finding beyond the unstated n.
3. Edges: Section 10. The one item is the unstated n >= 3.
4. Proven against stated or used: the display, the census, the coupling, the parity and the bound are proven. Stated but not supplied in the statement: RHS_even, RHS_odd (6a), n >= 3, the normalisation behind 3/(n-2). Cited but not reached: the proof pointer (11). Used but uncited: BW08 eq. (5) (2a). Passage C's closing sentence ("proves no case of the conjecture by itself") is accurate: the bound is conditional on the criterion.
5. Lean: Section 9 and 9a.
6. The brief's attack items: (1) Section 1, no finding. (2) Section 2, mechanisms located, symmetry used for the weights only, GAP 2a on the citation. (3) Section 3, weight 3 times value 1/(n-2), normalisations named. (4) Section 4, true for the W-coupling count, and (I,Y,Y), (Y,Y,Y) are also absent from the slice. (5) Sections 5, 6, 6a, 7: invariance and parity confirmed, RHS_even and RHS_odd undefined in A to C, bound and nonnegativity follow. (6) Section 8, confirmed at source for both Xu and Huisken. (7) Section 9: two_sided and cubic_odd have hypotheses that exclude objects, coupling_split's hypothesis excludes x = 2 needlessly, slice_odd's hypothesis is its conclusion. (8) Section 10.
7. Falsifying object: for the expansion, an (n, c, Y, W) at which one of the listed ordered vanishing terms is nonzero, for instance &lt;Y,Q(W)&gt; != 0, which needs Q(W) to have a Ric0 component. Xu (4) excludes it through Ric(Q(W)) = W-ring(Ric W) = 0. Or a coefficient differing from Huisken's p. 53 collected rows: all five checked at ratio 4. For the bound, a point with cI+Y+W in Omega_0 and cI+Y-W outside, excluded by Section 5, or a W-even W-dependent piece of ric(Phi(R)), which would need ric(Q(W)) != 0, excluded by Xu (4). What was done: every term derived by hand in closed form and every source read at its lines. No falsifier exists within the stated conventions.

## Overall verdict

PROVEN (hypotheses corrected). The corrections: state n >= 3 and the wedge and Ric0 normalisation behind 3/(n-2), define RHS_even and RHS_odd as the W-even and W-odd parts of F(R)&lt;ric(R), ric(Phi(R))&gt; in the canonical statement, cite BW08 eq. (5) for the multiplicities, repoint results.md line 384 to problem.md, and restate or drop the Lean theorem slice_odd and the stale "1,3,3,6" docstrings.
