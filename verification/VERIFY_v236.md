# Verifier v236, Lemma L45: the ten-triple census, the (Y,Y,W) coupling and its constant, the W-parity two-sided bound, the classification against Xu Lemma 2.8 and Huisken, and the Lean statement L45Statement.lean

The brief ([BRIEF_L45.md](BRIEF_L45.md)) was read cold. No numerical work was done, every value below is exact and obtained by hand in closed form, and no scripts were written. The Lean file was read, not built. Log: [agent_logs/verify-L45-v236.log](../agent_logs/verify-L45-v236.log).

**Independence disclosure.** Two exposures happened while checking quotations, both recorded in the log at the time. Displaying [target.md](../findings/target.md) lines 735-775 to check Passage A also showed the Gate 2 blockquotes at lines 744-757 above it. A grep for the string "1,3,3,6" also hit [INDEX-results.md](../findings/INDEX-results.md) line 60. Every verdict below was derived from the definitions and the filed sources, and one of them (the vanisher mechanisms, section 2) disagrees with those blockquotes.

| # | Claim | Verdict |
|---|---|---|
| 1 | Ten distinct triples, five vanish identically and five survive, survivor multiplicities 1,3,1,3,1, and the displayed five-term expansion | CONFIRMED (for n at least 4, total symmetry of T cited) |
| 2 | Every vanishing triple has a mechanism in the argument or its cited sources | CONFIRMED |
| 3 | (Y,Y,W) equals 3/(n-2) times the pairing of W with Ric0 wedge Ric0, weight 3 times trilinear value 1/(n-2) | CONFIRMED (in the BW08 normalisation of Ric0 and wedge) |
| 4 | Against the slice exactly one new coupling appears | CONFIRMED (read as: one new surviving triple containing W) |
| 5 | Omega0 is invariant under W to -W, and the criterion at both signs gives the two-sided bound and RHS_even - LHS_even at least 0 | CONFIRMED (RHS_even and RHS_odd read as the W-parity parts) |
| 6 | The expansion agrees term for term with Xu Lemma 2.8 eq. (2.34), which Xu attributes to Huisken | CONFIRMED |
| 7 | Passage E types the reflection argument, the parity facts and the census | GAP (slice_odd types its own hypothesis) |
| 8 | Boundary cases: n = 3 and 4, Y = 0, W = 0, c at most 0, ker W nonzero | CONFIRMED (n = 3 lies outside "five survive") |
| K2 | The written chain "Xu Prop 2.7 plus BW08 Lemma 2.2 determine every one of the ten triples" | HYPOTHESIS-DEBT discharged at source: BW08 eq. (5) is used and uncited |

**What the round should do:** record L45 as PROVEN (hypotheses corrected), naming BW08 eq. (5) in the argument, stating n at least 4 for the census, defining RHS_even and RHS_odd, fixing the normalisation of Ric0 and wedge, and repairing or deleting the Lean theorem slice_odd.

## 0. Conventions, fixed once

- so(n) is identified with Lambda^2 R^n. The inner product on operators is tr(R S), and I is the identity on Lambda^2, so the norm of I squared is n(n-1)/2.
- The wedge is BW08's: (A wedge B)(x wedge y) = (1/2)(Ax wedge By + Bx wedge Ay). So id wedge id = I and, for diagonal A = diag(a_i), A wedge B is diagonal on e_i wedge e_j with eigenvalue (a_i b_j + a_j b_i)/2.
- Ric is BW08's (no factor 1/2), lambda-bar = tr Ric / n, Ric0 = Ric - lambda-bar id. BW08 eq. (3): R_I = lambda-bar/(n-1) I and R_Ric0 = 2/(n-2) Ric0 wedge id. So c = lambda-bar/(n-1).
- Phi(R) = R^2 + R#, with # as BW08 eq. (4). Phi(A,B) = (1/2)(AB + BA) + A # B, which is Xu's Q(A,B). T(A,B,C) = the pairing of A with Phi(B,C). BW08 eq. (5) gives tri(R1,R2,R3) = 2 T(R3,R1,R2) and states tri is totally symmetric.
- Beitz's ric (her Definition 1.1.10, read at source) is one half of BW08's Ric. The brief's equivalent form of Omega0, (n-2)/n times the norm of R_W squared at most the norm of R_I squared with tr R positive, holds with Beitz's ric. With BW08's Ric the sublevel F at most 4/(n-2) carries an additional Ric0 term. L45 uses only the W-evenness of Omega0, which holds in both.
- The slice is Y = 0 (the Einstein slice of L43).
- Survive means "not identically zero on the space of algebraic curvature operators at the given n".

Closed-form test object used below, n = 4: A = diag(1,1,-1,-1), Y = R_Ric0 = A wedge id, W = A wedge A + (1/3) I. On the basis e12, e34, e13, e14, e23, e24: Y has eigenvalues 1, -1, 0, 0, 0, 0 and W has eigenvalues 4/3, 4/3, -2/3, -2/3, -2/3, -2/3. W is Weyl: Ric(A wedge A) = -A^2 = -id (BW08, proof of Lemma 2.2) and Ric(I/3) = ((n-1)/3) id = id, and both summands satisfy Bianchi. For an operator diagonal in this basis, BW08's proof of Lemma 2.2 gives (R^2 + R#)_ij = R_ij^2 + sum over k not in {i,j} of R_ik R_jk.

## Hypothesis inventory (standing item 1)

| Source | Hypotheses at source | Object it is applied to | Holds | Used by the proof |
|---|---|---|---|---|
| Statement L45 | R an algebraic curvature operator (implicit in "R = cI + Y + W"), n unstated | general R | n must be at least 3 for the decomposition and 1/(n-2), at least 4 for W to exist and for "five survive" | yes |
| Xu Prop 2.7 (1) | R, S in the span of I | Phi(I,I) | yes | kills (I,I,Y) and the (I,I,W) instance pairing W with Phi(I) |
| Xu Prop 2.7 (2) | R in span I, S in span Ric0 | Phi(I,Y) | yes | kills the ordered instances of (I,I,Y) and (I,Y,W) that pair I or W with Phi(I,Y) |
| Xu Prop 2.7 (3) | R in span I, S Weyl | Phi(I,W) | yes (it is W + W # I = 0, BW08 Lemma 2.1) | kills every triple containing both I and W |
| Xu Prop 2.7 (4) | R, S Weyl | Phi(W) | yes, given that Phi preserves Bianchi, which Xu's proof uses silently (Hamilton) | kills (Y,W,W) and (I,W,W) instances with Phi(W) |
| Xu Prop 2.7 (5) | R in span Ric0, S Weyl | Phi(Y,W) | yes. Xu's proof of (5) itself uses the symmetry of tri | kills (Y,W,W) instance with Phi(Y,W), gives RHS_odd in span Ric0 |
| Xu Lemma 2.6 / BW08 Lemma 2.2 | R in SB^2 of Ricci type | Y (lambda-bar = 0) and cI (Ric0 = 0) | yes, both are of Ricci type | gives (Phi(Y))_W = (1/(n-2))(Ric0 wedge Ric0)_W and Phi(cI) = c^2 (n-1) I |
| Xu Lemma 2.8 eq. (2.34) | stated for R in S^2(so(n)), used with the SB^2 decomposition | general R in SB^2 | yes (the statement's S^2 is read as SB^2, which its proof uses) | classification only |
| BW08 Lemma 2.1 | R in SB^2 | I, Y, W | yes | through Xu (1)-(3) |
| BW08 eq. (5) | R1, R2, R3 in S^2(so(n)) | all components | yes | **used and not cited in the L45 argument** (see K2) |
| BW08 eq. (6) | orthonormal Ricci eigenbasis | Phi(R) | yes | underlies Xu (2.26), which gives ric of Phi(W) = 0 |
| Huisken, proof of Theorem 3.3 | Riemann tensor of a metric, pointwise algebra | attribution only | read at source, see section 6 | no |
| Beitz Lemma 2.3.4 (for "the criterion") | as filed | not used by L45 itself, the lemma is conditional on "demanding the criterion" | not checked, outside the lemma | no |

Used but unstated: total symmetry of T (BW08 eq. (5), also Xu (2.33)), the scope n at least 4, and the normalisation of Ric0 and wedge.

## 1. The census (attack 1)

Write R = cI + Y + W. By bilinearity the pairing of R with Phi(R) is the sum over the 27 ordered triples (A,B,C) of components of T(A,B,C). Phi(B,C) is symmetric in B and C by construction. Folding the 27 ordered triples into 10 multisets of size three with weights 3!/(i! j! k!) requires T to be totally symmetric, which BW08 eq. (5) supplies (read at source: tr(2(R1 # R2) R3) is written as a sum symmetric in all three slots).

The ten multisets and their weights: (I,I,I) 1, (Y,Y,Y) 1, (W,W,W) 1, (I,I,Y) 3, (I,I,W) 3, (I,Y,Y) 3, (I,W,W) 3, (Y,Y,W) 3, (Y,W,W) 3, (I,Y,W) 6. Total 27 = 3^3.

Values of the five survivors:
- (I,I,I): c^3 times the pairing of I with Phi(I). BW08 Lemma 2.2 with Ric0 = 0 and lambda-bar = c(n-1) gives Phi(cI) = c^2 (n-1) I, so the term is c^3 (n-1) times the norm of I squared. Matches.
- (I,Y,Y), weight 3: 3c times the pairing of I with Phi(Y). Value: BW08 Lemma 2.2 eigenvalues of Phi(Y) are lambda_i lambda_j/(n-2) + (S2 - lambda_i^2 - lambda_j^2)/(n-2)^2 with S1 = 0, S2 = |Ric0|^2. Summing over i < j gives -S2/(2(n-2)) + S2 (n-1)/(2(n-2)) = S2/2. So the term is 3c |Ric0|^2 / 2, nonzero whenever c and Ric0 are nonzero. At the test object the pairing of I with Phi(Y) is 1 + 1 = 2 = |A|^2/2.
- (Y,Y,Y), weight 1: the pairing of Y with Phi(Y). Same eigenvalues give -2 S3/(n-2)^2 with S3 = tr Ric0^3. Nonzero for Ric0 = diag(3,-1,-1,-1) at n = 4 (S3 = 24).
- (Y,Y,W), weight 3: 3 times the pairing of W with Phi(Y). See section 3. At the test object it is 8.
- (W,W,W), weight 1: the pairing of W with Q(W). At the test object Q(W) has eigenvalue (4/3)^2 + 2(2/3)^2 = 8/3 on e12 and (2/3)^2 + 2(4/3)(-2/3) = -4/3 on e13, so Q(W) = 2W and the term is 2 times the norm of W squared = 32/3.

Survivor weights 1,3,1,3,1 in the display order (I,I,I), (I,Y,Y), (Y,Y,Y), (Y,Y,W), (W,W,W), summing to 9. Vanisher weights 3,3,6,3,3, summing to 18. The only weight-6 multiset (I,Y,W) is a vanisher. The displayed five-term expansion and the W-even and W-odd underbraces are correct (the first three terms contain no W, the last two are of degree 1 and 3 in W).

Verdict: CONFIRMED, with total symmetry of T as a named input and n at least 4 (section 8).

## 2. A mechanism for every vanishing triple (attack 2)

Each ordered instance can be killed without total symmetry, from Xu Prop 2.7 plus the orthogonality of the three summands:

| Multiset | Ordered instances (A paired with Phi(B,C)) | Mechanism |
|---|---|---|
| (I,I,Y) | Y with Phi(I,I); I with Phi(I,Y) | Phi(I) in span I (Xu (1)), orthogonal to Y; Phi(I,Y) in span Ric0 (Xu (2)), orthogonal to I |
| (I,I,W) | W with Phi(I,I); I with Phi(I,W) | Xu (1) and orthogonality; Phi(I,W) = 0 (Xu (3)) |
| (I,Y,W) | I with Phi(Y,W); Y with Phi(I,W); W with Phi(I,Y) | Xu (5) and orthogonality; Xu (3); Xu (2) and orthogonality |
| (I,W,W) | I with Phi(W); W with Phi(I,W) | Xu (4) and orthogonality; Xu (3) |
| (Y,W,W) | Y with Phi(W); W with Phi(Y,W) | Xu (4) and orthogonality; Xu (5) and orthogonality |

With total symmetry, Xu (3) alone kills the three multisets containing both I and W, which is what Passage D's "every I-W pairing, by Xu (3)" says. (I,I,Y) and (Y,W,W) contain no I-W pair. Their mechanisms are Xu (1) and Xu (4) with orthogonality, which are items of the Proposition that Passage D cites as determining "every one of the ten distinct triples". The mechanism is therefore located in a cited source, though the text itemises only the I-W case.

Total symmetry: not needed for vanishing, needed for the survivors' coefficients (section 1 and K2).

Verdict: CONFIRMED.

## 3. The value of (Y,Y,W) (attack 3)

Y = R_Ric0 is in SB^2 and of Ricci type with lambda-bar = 0, and Ric0(Y) = Ric0(R) because Ric(W) = 0 and Ric(cI) is a multiple of id. BW08 Lemma 2.2, second identity (read at source): (R^2 + R#)_W = (1/(n-2)) (Ric0 wedge Ric0)_W. Hence the trilinear value T(W,Y,Y) = pairing of W with Phi(Y) = (1/(n-2)) pairing of W with Ric0 wedge Ric0, the projection dropping against W by orthogonality. The multinomial weight of (Y,Y,W) is 3. So 3/(n-2) = weight 3 times trilinear value 1/(n-2).

Closed-form check at the test object (n = 4). Phi(Y)_12 = 1^2 + y_13 y_23 + y_14 y_24 = 1, Phi(Y)_34 = 1, Phi(Y)_13 = y_12 y_32 + y_14 y_34 = 0, Phi(Y)_14 = 0. So the pairing of W with Phi(Y) is 4/3 + 4/3 = 8/3. A wedge A = W - I/3, so the pairing of W with A wedge A is the norm of W squared = 16/3, and (1/(n-2)) times it is 8/3. They agree.

Normalisations needed: BW08's wedge and BW08's Ric (section 0). If Ric0 is read as the traceless part of Beitz's ric (one half of BW08's), Ric0 wedge Ric0 scales by 1/4 and the constant reads 12/(n-2). Passages A to D never define Ric0 or wedge. Passage D derives the constant from BW08 Lemma 2.2, which fixes BW08's normalisation, so the statement is correct in that normalisation (candidate W3 in section 12.2).

Verdict: CONFIRMED in the BW08 normalisation.

## 4. "Exactly one new coupling" (attack 4)

On the slice (Y = 0) the survivors are (I,I,I) and (W,W,W). Off the slice three further survivors appear: (I,Y,Y) = 3c |Ric0|^2/2, (Y,Y,Y) = -2 tr Ric0^3/(n-2)^2 and (Y,Y,W). All three are absent from the slice. Against the count "new surviving triples" the number is three. Against "new mixed triples" it is two, since (I,Y,Y) mixes I and Y. Against "new surviving triples that contain W together with another summand" it is one: the W-mixed multisets off the slice are (I,Y,W), (Y,W,W), (Y,Y,W), and only (Y,Y,W) survives. The same sentence in Passage A continues "every I-W pairing vanishes", and the display places (Y,Y,W) in the W-odd part, which supports the third reading. Recorded as withdrawn candidate W1.

Verdict: CONFIRMED under the reading "one new surviving triple containing W". The wording should say so.

## 5. The parity argument (attack 5)

- Omega0 invariance. The norm of R squared is the norm of cI + Y squared plus the norm of W squared by orthogonality. ric(R) = ric(cI + Y) and tr R = c n(n-1)/2 do not depend on W. Hence F(cI + Y - W) = F(cI + Y + W) and scal is unchanged, so cI + Y - W lies in Omega0 (and on its boundary) exactly when cI + Y + W does. In the brief's equivalent form the clauses read the norm of W and R_I only. This holds in both ric normalisations.
- LHS parity. Section 1.
- RHS parity. F(R) is W-even. ric(R) is W-independent. Phi(R) = Phi(cI + Y) + 2c Phi(I,W) + 2 Phi(Y,W) + Phi(W). The second term is 0 (Xu (3)), ric of the fourth is 0 (Xu (4) and (2.26)), and the third is linear in W and lies in span Ric0 (Xu (5)). So RHS = F(R) times the pairing of ric R with ric Phi(cI+Y), which is W-even, plus F(R) times the pairing of ric R with 2 ric Phi(Y,W), which is W-odd. Passage D writes "the only W-dependent piece of ric(Phi(R)) is 2 Phi(Y,W)", which should read ric(2 Phi(Y,W)), a notational slip with no mathematical effect.
- RHS_odd is genuinely nonzero. For S in span Ric0, S = (2/(n-2)) Ric(S) wedge id, so the pairing of Y with S is (1/(n-2)) the pairing of Ric0 with Ric(S). Hence the pairing of Ric(R) with Ric(Phi(Y,W)) is (n-2) T(Y,Y,W) = the pairing of W with Ric0 wedge Ric0, which is 16/3 at the test object. So RHS(W) and RHS(-W) differ there.
- Definitions. **RHS_even and RHS_odd are defined nowhere in Passages A to D.** LHS_even and LHS_odd are fixed by the underbraces. Passage D describes the parities of the RHS pieces in words. Because RHS_odd is nonzero, the symbols carry content (candidate W2).
- The bound. With g_even(W) = (g(W) + g(-W))/2 and g_odd(W) = (g(W) - g(-W))/2 for each side, the criterion at +W reads Le + Lo at most Re + Ro and at -W reads Le - Lo at most Re - Ro. Subtracting orders gives Lo - Ro at most Re - Le and Ro - Lo at most Re - Le, so the absolute value of Lo - Ro is at most Re - Le. Adding gives Le at most Re. Both follow from the two instances alone. The parity analysis of the pieces is needed only to identify LHS_odd and RHS_odd concretely.
- The lemma is conditional: it assumes the criterion at both signs. It does not assert that invariance of Omega0 supplies the criterion at interior points. Whatever set the criterion is demanded on (Omega0 or its boundary), that set is W-sign invariant, so the second instance is available.

Verdict: CONFIRMED, with RHS_even and RHS_odd to be defined as the W-parity parts.

## 6. Classification against Xu Lemma 2.8 and the attribution to Huisken (attack 6)

Xu eq. (2.34), read at source: the pairing of Q(R) with R = n/(2(n-1)) lambda-bar^3 + 3/(2(n-1)) lambda-bar |Ric0|^2 + 3/(n-2) pairing of Ric0 wedge Ric0 with W - 2/(n-2)^2 pairing of (Ric0^2)_0 with Ric0 + pairing of Q(W) with W. Passage D quotes it correctly.

Term match with c = lambda-bar/(n-1):
- (I,I,I): c^3 (n-1) n(n-1)/2 = n lambda-bar^3/(2(n-1)). Matches.
- (I,Y,Y): 3c |Ric0|^2/2 = 3 lambda-bar |Ric0|^2/(2(n-1)). Matches.
- (Y,Y,W): 3/(n-2), matches.
- (Y,Y,Y): -2 S3/(n-2)^2 (section 1). Xu's term pairs traceless Ric0 with (Ric0^2)_0, which equals tr Ric0^3 = S3. Matches.
- (W,W,W): matches.

Passage D's order "(I,I,I), (I,Y,Y), (Y,Y,W), (Y,Y,Y), (W,W,W)" is Xu's order, correct. Xu's proof groups by the second slot ((2.36), (2.37), (2.41)) and uses the symmetry of tri. Its multiplicity bookkeeping (1 + 2 copies of (I,Y,Y), 2 + 1 copies of (Y,Y,W)) checks.

Attribution. Xu writes that the identity "was derived by Huisken in his proof of the Theorem 3.3 in [16]" and "was not written down as an independent lemma". Passage D reports exactly this. Huisken's proof of Theorem 3.3 (journal page 53, read from the PDF because the text extraction is garbled) decomposes the cubic 2 R R R + (1/2) R R R by pairing with U, V and W separately, in terms of scalar curvature R, S = |Rc|^2 and the traceless Ricci tensor. The U line is 2/(n(n-1)) R S, the V line carries R(S - R^2/n), the cubic in the traceless Ricci tensor and a W term with 4/(n-2), and the W line carries W W W terms and a W term with 2/(n-2). Once collected, this is the same five-term identity (the two W-Ricci terms total 6/(n-2) in his normalisation of the cubic). Passage C's "the expansion is Huisken's, term for term" is exact only after collection, since Huisken's single U term R S straddles (I,I,I) and one copy of (I,Y,Y) (candidate W4).

Verdict: CONFIRMED.

## 7. The Lean statement, Passage E (attack 7, standing item 5)

The brief's Passage E matches [L45Statement.lean](../lean/HamiltonsCubic/Results/L45Statement.lean) byte for byte (diff clean). The file has 156 newline-terminated lines, and the brief says 157, which does not matter.

| Theorem | What it types | Hypotheses exclude something? | Verdict |
|---|---|---|---|
| two_sided | from Le + Lo at most Re + Ro and Le - Lo at most Re - Ro, the absolute value of Lo - Ro is at most Re - Le. Directions correct | yes, non-vacuous | CONFIRMED AS ALGEBRA |
| even_gap_nonneg | 0 at most Re - Le from the same two | yes | CONFIRMED AS ALGEBRA |
| cubic_odd | for Q even, the pairing of -x with Q(-x) is minus the pairing of x with Q(x) | yes (excludes non-even Q) | CONFIRMED AS ALGEBRA |
| slice_odd | from hP : for all x, P(-x) = -P x, conclude P(-x) = -P x. Proof term hP x | the hypothesis is the conclusion | **GAP**, finding K1 |
| omega0_sign_symmetric | for every predicate phi on reals, phi applied to the norm of -W iff phi applied to the norm of W. This is norm_neg | no hypotheses. "Omega0 reads the norm of W only" is built into the shape phi of the norm of W, not proved | CONFIRMED AS ALGEBRA |
| ten_triples | 10 triples in Fin 4 cubed with coordinate sum 3 (C(5,2) = 10) | none | CONFIRMED |
| five_and_five, degrees | the two defined lists have length 5, are jointly duplicate-free, and have degree 3 | none | CONFIRMED. Which triples vanish is a definition, not a theorem, as the docstring says |
| survivor_weights, vanisher_weights, no_survivor_has_weight_six, weights_partition | 1,3,1,3,1, then 3,3,6,3,3, sums 9 and 18. Natural-number division is exact on degree-3 triples | none | CONFIRMED |
| coupling_split | 3/(x-2) = 3 (1/(x-2)) for x not 2 | hx is unused, both sides are 0 at x = 2 in Lean, so it excludes nothing needed | CONFIRMED AS ALGEBRA. It does not type that 1/(n-2) is the trilinear value, and the file header says so |

The header's claim "Three parts, all of them free of the curvature layer and all proved here" is accurate apart from slice_odd, whose docstring claims a fact about the slice ("W_n is linear and the cubic is odd on it") that the statement does not carry. The header's quotation that results.md records "1,3,3,6" is a verbatim quote of the correction block. [results.md](../results.md) line 382 now carries 1,3,1,3,1 (candidate W5).

## 8. The boundary (attack 8, standing item 3)

- **n = 2.** so(2) is one-dimensional, Ric0 = 0, and 1/(n-2) and Omega0's 4/(n-2) are undefined. Outside every definition in play.
- **n = 3.** The span of Weyl operators is {0}, so W = 0. The expansion and the bound hold trivially. The odd part and RHS_odd vanish, and the bound reduces to the criterion. But (Y,Y,W) and (W,W,W) vanish identically, so only three triples survive and "five vanish, five survive" is false at n = 3 (candidate W6). The brief's definitions place the decomposition at n at least 4.
- **n = 4.** Everything holds. The test object shows all five survivors nonzero or checkable in closed form: (I,Y,Y) = 3c (4)/2 = 6c, (Y,Y,W) = 8 and (W,W,W) = 32/3. (Y,Y,Y) = 0 at this A, and A = diag(3,-1,-1,-1) gives S3 = 24. BW08 proves Lemma 2.1 on the Weyl span at n = 4 directly and embeds for n at least 5.
- **Odd n.** No parity-of-n input appears anywhere. No finding.
- **Y = 0.** (I,Y,Y), (Y,Y,Y), (Y,Y,W) and RHS_odd vanish. Direct evaluation: ric Phi(cI) = c^2 (n-1) ric I, so RHS = F(R) c (n-1) |ric(cI)|^2 = c(n-1)(c^2 |I|^2 + |W|^2), and RHS_even - LHS_even = c(n-1)|W|^2. The bound is the absolute value of the pairing of W with Q(W) at most c(n-1)|W|^2. This is L43's bridge in two-sided form, which is equivalent to the one-sided form on the slice because the cubic is odd. Passage D's consistency check holds.
- **W = 0.** Both odd parts vanish, and the bound is the criterion. No finding.
- **c at most 0.** tr R = c n(n-1)/2, so Omega0 forces c positive, and no criterion is demanded. The identity holds for every c. At Y = 0, c negative and W nonzero, RHS_even - LHS_even = c(n-1)|W|^2 is negative, consistent with such R lying outside Omega0. No finding.
- **ker W nonzero (zero-padded Weyl).** Zero padding from R^4 to R^n keeps W Weyl (the BW08 embedding). Every step is pointwise block algebra with no rank or kernel input. No finding.

## 9. Quantifier order and scope (standing item 2)

The identity: for every n at least 4 and every algebraic curvature operator R = cI + Y + W, the five-term expansion holds, each vanisher is zero, and the survivors are not identically zero. The bound: for every such R for which the criterion is demanded at cI + Y + W and at cI + Y - W (both are in Omega0 together), the two-sided bound holds with parity parts evaluated at that R. No quantifier is exchanged. The only unstated scope is n at least 4. No finding beyond that.

## 10. Proven against stated and used (standing item 4)

- Proven: the expansion (given BW08 eq. (5)), the value of (Y,Y,W), the W-sign invariance of Omega0, the two-sided bound and RHS_even - LHS_even at least 0 as consequences of the criterion at both signs.
- Stated beyond what is proven: none mathematically. Passage C's closing sentence ("a bookkeeping identity ... proves no case of the conjecture by itself") correctly bounds the claim. RHS_even is never evaluated, so the bound is not usable as an estimate until it is.
- Used downstream (Passage D's blockquote): "What a general-Ric0 proof still owes is a bound on LHS_odd - RHS_odd". This is consistent. The inequality is a consequence of assuming the criterion, so it cannot serve as a premise toward proving the criterion.

## 11. The falsifying object (standing item 7)

- For the census: an algebraic curvature operator at some n at least 4 at which one of the five named vanishers is nonzero, or at which a survivor's coefficient differs from 1,3,1,3,1. Searched by deriving each ordered instance from Xu Prop 2.7 at source (section 2) and evaluating every survivor on the closed-form n = 4 object. None exists: each vanisher is zero by a block fact holding for all R.
- For the constant: an R with the pairing of W with Phi(Y) different from (1/(n-2)) times the pairing of W with Ric0 wedge Ric0. Searched by BW08 Lemma 2.2 at source and the test object (8/3 on both sides). None exists in BW08's normalisation. In Beitz's normalisation the constant is 12/(n-2).
- For the bound: an R with the criterion at both signs and the bound failing. Impossible: the bound is the linear consequence in section 5.
- For the Lean: slice_odd is the object that fails its docstring, since it proves its hypothesis (K1).

## 12. Findings, three-step record

### 12.1 Kept

**K1. The Lean theorem slice_odd types its own hypothesis.**
1. Locate. Passage E, file line 94 (brief line 146): `theorem slice_odd (P : V → ℝ) (hP : ∀ x : V, P (-x) = -P x) (x : V) : P (-x) = -P x := hP x`, with docstring "P(-W) = -P(W) on the slice ... W_n is linear and the cubic is odd on it".
2. Exhibit. The conclusion is hP instantiated at x, and the proof term is hP x. For any V and any P : V → ℝ the theorem is (for all x, phi(x)) implies phi(x). It mentions no slice, no Q and no cubic, and does not connect P to cubic_odd. It carries no information about L45.
3. Opposite reading. It might be a documentation anchor meant to name the fact. But the header states that all parts are "proved here" and the docstring asserts oddness "on the slice", which the statement does not carry. The fact it names is already typed by cubic_odd with P(x) the pairing of x with Q(x). No reading gives it content. Kept. Repair: state it as a corollary of cubic_odd with P defined, or delete it.

**K2. The written chain omits a load-bearing import, total symmetry of T (BW08 eq. (5)).**
1. Locate. [problem.md](../findings/problem.md) line 76: "Xu Prop 2.7 plus BW08 Lemma 2.2 ... determine every one of the ten distinct triples", and the coefficients 3c and 3 in the display at line 78.
2. Exhibit. Let pi denote orthogonal projection onto span Ric0 and, for t real, Phi'(A,B) = Phi(A,B) + t pi(Y_A W_B + W_B Y_A + Y_B W_A + W_A Y_B), with Y_A and W_A the Ric0 and Weyl parts. Phi' is symmetric bilinear and agrees with Phi whenever either argument has no Weyl part or no Ric0 part, and in the (Ric0, Weyl) block it adds an element of span Ric0. So Phi' satisfies Xu Prop 2.7 (1)-(5), BW08 Lemma 2.1 and BW08 Lemma 2.2 verbatim. Yet the pairing of R with Phi'(R) minus the pairing of R with Phi(R) is 2t times the pairing of Y with YW + WY, which is 4t tr(Y^2 W). At the n = 4 test object this is 4t (4/3 + 4/3) = 32t/3, which is nonzero, and it sits in the (Y,Y,W) coefficient. The cited facts do not determine the expansion. What fixes it is total symmetry, which Phi' breaks.
3. Opposite reading. Xu states the symmetry of tri as (2.33) immediately before Prop 2.7 and uses it in the proof of item (5). BW08 eq. (5) is cited four lines earlier in the same file (line 72), where it is called "not load-bearing" for the on-slice collapse. A reader following the citation finds the missing input on the same page, and it holds for the objects. So the lemma is true and the argument is complete at source, but the written chain names the wrong set of inputs. This is kept as a hypothesis correction, not a mathematical defect: name BW08 eq. (5) as load-bearing off the slice.

### 12.2 Withdrawn

**W1. "Exactly one new coupling" undercounts.** (1) Passage A (target.md line 763) and Passage C (results.md line 382), "the only coupling absent from the slice is the triple (Y,Y,W)". (2) (I,Y,Y) = 3c |Ric0|^2/2 (6c at the test object) is a mixed I-Y survivor absent from the slice. (3) The same sentence goes on to "every I-W pairing vanishes", and the display puts (Y,Y,W) in the W-odd part, so "coupling" reads as "coupling to W". Under that reading the count is exactly one. Withdrawn. Wording correction advised.

**W2. RHS_even and RHS_odd are undefined.** (1) Passage A (target.md line 763) and Passage C (results.md line 382). (2) RHS_odd is nonzero (16/3 times 2F in BW08's normalisation at the test object), so the choice of split changes the inequality. The split RHS_odd := 0 gives a different claim, which does not follow from the two instances. (3) Passage D (problem.md line 82) describes the W-parity of every RHS piece, which fixes the parity split uniquely, and with that split the bound follows (section 5). Withdrawn. A definition should be written into the statement.

**W3. The constant depends on an unfixed normalisation.** (1) "3/(n-2) pairing of W with Ric0 wedge Ric0", and neither Ric0 nor wedge is defined in A to D, while the criterion's ric is Beitz's (section 0). (2) With Ric0 the traceless part of Beitz's ric the constant is 12/(n-2). (3) The statement writes capital Ric0, and the derivation cites BW08 Lemma 2.2, whose Ric and wedge are fixed at source. Xu (2.34) uses the same. Withdrawn. Normalisation note advised.

**W4. "The expansion is Huisken's, term for term."** (1) Passage C line 382. (2) Huisken's page 53 groups by U, V, W pairing, and his single U term 2/(n(n-1)) R S expands to 2/(n-1)(n lambda-bar^3 + lambda-bar |Ric0|^2), straddling two census terms. (3) Read as "the identity is Huisken's, and it matches the five-term display term for term", which is Xu's attribution plus the check in section 6, it holds. Passage D's own wording is the careful one. Withdrawn.

**W5. The Lean header quotes results.md as carrying "1,3,3,6".** (1) File lines 29-32 and the survivor_weights docstring. (2) results.md line 382 carries 1,3,1,3,1 and contains no "1,3,3,6". (3) The header is a marked verbatim quotation of the correction block recording the canon's earlier state, which is accurate history. Withdrawn.

**W6. "Five survive" fails at n = 3.** (1) Passage C line 382. (2) At n = 3 the Weyl span is {0}, so (Y,Y,W) and (W,W,W) are identically zero and three survive. (3) The brief's definitions set the decomposition R = cI + Y + W at n at least 4, and the programme's n is at least 4 throughout. The identity itself holds at n = 3. Withdrawn as a defect, recorded as scope to be stated.

## Overall verdict

**PROVEN (hypotheses corrected).** The census, the five-term expansion, the (Y,Y,W) constant, the Omega0 reflection and the two-sided bound are all correct and agree with Xu eq. (2.34). The corrections to write into the statement and argument are: n at least 4, BW08 eq. (5) as a load-bearing input (K2), RHS_even and RHS_odd defined as W-parity parts, the BW08 normalisation of Ric0 and wedge, and "one new coupling" read as a coupling to W. On the Lean side, slice_odd (K1) is a GAP: it types its hypothesis and should be derived from cubic_odd or deleted.
