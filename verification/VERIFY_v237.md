# Verifier v237, L45: the triple census, the vanishing mechanisms, the (Y,Y,W) coupling, the parity bound, the Xu and Huisken classification, and the Lean statement

The brief (verification/BRIEF_L45.md) was read cold. No numerical work was done, no scripts were written, no build was run, and every value below is exact and obtained by hand in closed form. Log: agent_logs/verify-L45-v237.log.

| # | Claim | Verdict |
|---|---|---|
| 1 | Census: ten distinct triples, five vanish identically, five survive with multiplicities 1,3,1,3,1 | CONFIRMED |
| 2 | A mechanism for each of (I,I,Y), (I,I,W), (I,Y,W), (I,W,W), (Y,W,W) | CONFIRMED |
| 3 | (Y,Y,W) equals 3/(n-2) &lt;W, Ric0 ∧ Ric0&gt;, weight 3 times trilinear value 1/(n-2) | CONFIRMED |
| 4 | Against the slice exactly one new coupling appears, and every I-W pairing vanishes | CONFIRMED |
| 5 | Omega0 membership is invariant under W to -W, and the W-parity of every piece of both sides | CONFIRMED |
| 6 | The two-sided bound, and RHS_even - LHS_even &gt;= 0 as a consequence | CONFIRMED |
| 7 | Agreement with Xu Lemma 2.8 eq. (2.34) term for term, and the attribution to Huisken | CONFIRMED |
| 8 | Passage E types what it says | CONFIRMED AS ALGEBRA |

**What the round should do:** close L45 PROVEN, and fix two Lean docstring defects (slice_odd is its own hypothesis, and the header reports a 1,3,3,6 error that results.md no longer carries), with optional wording repairs to the statement (n &gt;= 4 written, "coupling" pinned to the W-dependent triples, the normalisation of ∧ and Ric named).

## 0. Conventions, fixed once

- n &gt;= 4 wherever W appears (the brief's definitions and Xu (2.5) both carry it). SB²(so(n)) is the space of algebraic curvature operators. The inner product is the operator trace, &lt;R,S&gt; = tr(R∘S), so ‖I‖² = n(n-1)/2.
- Wedge and Ricci in the BW08 / Xu normalisation. Xu (2.7): (A∧B)(x∧y) = ½(Ax∧By + Bx∧Ay), so for diagonal h the operator h∧h has eigenvalue λ_iλ_j on e_i∧e_j. Ric(I) = (n-1) id, λ̄ = scal/n, and Xu (2.6): R_I = λ̄/(n-1) I, R_Ric0 = 2/(n-2) Ric0∧id, R_W = W. Hence c = λ̄/(n-1) and Y = 2/(n-2) Ric0∧id, whose Ricci tensor is Ric0 itself.
- Beitz's ric is ½ Ric (Beitz Definition 1.1.10, read at source). This is the ric that makes the brief's two descriptions of Omega0 equivalent (section 5).
- Φ(R) = R² + R#, Φ(A,B) = ½(AB+BA) + A#B, which is Xu's bilinear Q(R,S). T(A,B,C) = &lt;A,Φ(B,C)&gt; = ½ tri(A,B,C) (Xu (2.33), BW08 (5)).
- For operators, &lt;I,S&gt; = tr S = ½ scal(S) (scal sums the sectional values over ordered pairs).
- "Survive" means "not identically zero on the stated space". "Vanish" means identically zero.

## Hypothesis inventory

| Source | Hypotheses at source | Object it is applied to | Check | Used by the proof |
|---|---|---|---|---|
| Xu Prop 2.7 (1)-(5) | R, S in the named summands of SB²(so(n)), decomposition (2.5) for n &gt;= 4 | I, Y, W of an algebraic curvature operator | holds | Yes. D names (3) for the I-W pairings and (5) for ric(Φ(R)). Items (1), (2), (4) are needed for (I,I,Y) and (Y,W,W) and are covered by the citation of the Proposition as a whole |
| Xu Lemma 2.8 (2.34) | stated "For R ∈ S²(so(n))", proved through (2.6), which needs SB² | R = cI+Y+W in SB² | holds (the object satisfies the narrower hypothesis the proof uses) | Used only as corroboration, not in the derivation |
| Xu Lemma 2.6 (2.30)-(2.32) = BW08 Lemma 2.2 | R of Ricci type, R_W = 0 | Y = R_Ric0 (λ̄ = 0), whose Ric0 is Ric0(R) | holds | Yes, the W block (Φ(Y))_W = 1/(n-2)(Ric0∧Ric0)_W |
| BW08 Lemma 2.1 | R ∈ SB²(so(n)) | I (gives Φ(I) = (n-1)I) and W (gives W + W#I = 0, the source of Xu (3)) | holds. Its proof for W is n = 4 plus embedding for n &gt;= 5, which covers zero-padded Weyl tensors | Yes, through Xu (3) and the (I,I,I) coefficient |
| BW08 eq. (5), Xu (2.33) | none (identity on S²(so(n))) | T on the summands | holds | Yes, and **not cited in Passage D**. Needed twice: to group the 27 ordered terms into ten multisets with multinomial weights, and to move I and W into the slots of Φ(I,W) when Xu (3) alone is invoked |
| BW08 eq. (6), Xu (2.26) | R ∈ SB² | W (Ric(Φ(W)) = 0) | holds | Indirectly, inside the proof of Xu (4) |
| Huisken, proof of Theorem 3.3 | Riemannian metric, n &gt;= 3 | none directly | read at source, p. 53 | Attribution only |
| Statement's own hypotheses | R = cI+Y+W, Y = R_ric0. For the bound: cI+Y+W ∈ Omega0 and the criterion demanded at cI+Y+W and cI+Y-W | | | Used but unstated in Passages A-D: n &gt;= 4 (see 1.1, withdrawn), total symmetry of T (above), the normalisation of ∧ and Ric (see 3.3, withdrawn) |

Quantifier order (standing item 2). The identity reads: for every n &gt;= 4, every real c, every Y ∈ ⟨Ric0⟩ and every W ∈ ⟨W⟩. The bound reads: for every such (c,Y,W) with cI+Y+W ∈ Omega0, if the criterion holds at both cI+Y+W and cI+Y-W then the bound holds at that (c,Y,W). Equivalently, if the criterion holds on all of Omega0, the bound holds at every point of Omega0. Both readings are what the passages say. No finding: the scope of "demanding" is correctly conditional, and the bound is nowhere asserted unconditionally.

## 1. Census (claim 1, attack item 1)

**Derivation.** With R = cI+Y+W, trilinearity gives &lt;R,Φ(R)&gt; = Σ T(A,B,C) over the 27 ordered triples (A,B,C) ∈ {cI,Y,W}³. T is symmetric in its last two slots by construction, and in all three by BW08 (5) / Xu (2.33). Grouping by multiset gives the exponent triples (i,j,k) with i+j+k = 3, of which there are C(5,2) = 10, each weighted 3!/(i!j!k!). Weights: (3,0,0) 1, (1,2,0) 3, (0,3,0) 1, (0,2,1) 3, (0,0,3) 1, and (2,1,0) 3, (2,0,1) 3, (1,1,1) 6, (1,0,2) 3, (0,1,2) 3. Sum 9 + 18 = 27.

The surviving terms, each checked against the displayed formula:

- (I,I,I): c³ &lt;I,Φ(I)&gt;. BW08 Lemma 2.1 at R = I gives I + I#I = Ric(I)∧id = (n-1)I, and I² = I, so Φ(I) = (n-1)I. The term is c³(n-1)‖I‖². Matches.
- (I,Y,Y): 3c &lt;I,Φ(Y)&gt;. Matches, weight 3.
- (Y,Y,Y): &lt;Y,Φ(Y)&gt;, weight 1. Matches.
- (Y,Y,W): 3 &lt;W,Φ(Y,Y)&gt; = 3&lt;W,Φ(Y)&gt;. Matches, weight 3.
- (W,W,W): &lt;W,Φ(W)&gt; = &lt;W,Q(W)&gt;, weight 1. Matches.

**Survival, each by a closed-form witness at n = 4** (screens on constructed objects, exact):

- (I,Y,Y). By BW08 Lemma 2.2 / Xu (2.32) at λ̄ = 0, Ric(Φ(Y)) = -2/(n-2)(Ric0²)_0 + |Ric0|²/n id, so scal(Φ(Y)) = |Ric0|² and &lt;I,Φ(Y)&gt; = |Ric0|²/2. Nonzero whenever Ric0 ≠ 0.
- (Y,Y,Y). Take Ric0 = diag(3,-1,-1,-1), |Ric0|² = 12, σ = 3. Y has eigenvalue (λ_i+λ_j)/2: 1 on e_1∧e_k, -1 on e_j∧e_k (j,k &gt;= 2). BW08's eigenvalue formula (Φ(Y))_ij = λ_iλ_j/(n-2) + (nσ - λ_i² - λ_j²)/(n-2)² gives -1 on e_1∧e_k and 3 on e_j∧e_k. So &lt;Y,Φ(Y)&gt; = 3(1)(-1) + 3(-1)(3) = -12, which equals Xu's -2/(n-2)² tr Ric0³ = -½ · 24. Also tr Φ(Y) = -3 + 9 = 6 = |Ric0|²/2, agreeing with the (I,Y,Y) line.
- (Y,Y,W). Take Ric0 = diag(1,1,-1,-1). Ric0∧Ric0 has eigenvalue 1 on e12, e34 and -1 on the other four. Its Ricci is -Ric0² = -id, so its Ric0 part is zero and its I part is -1/3 I. Hence (Ric0∧Ric0)_W has eigenvalue 4/3 on e12, e34 and -2/3 on the rest (traceless, Ricci-free, so Weyl). Independently, BW08's formula with σ = 1 gives Φ(Y) = 1 on e12, e34 and 0 elsewhere, whose W part is 2/3 and -1/3, which is ½(Ric0∧Ric0)_W as Lemma 2.2 says. With W = (Ric0∧Ric0)_W, 3&lt;W,Φ(Y)&gt; = 3(2·(4/3)(2/3) + 4·(2/3)(1/3)) = 8 = 3/(n-2)·‖W‖² = (3/2)(16/3). Nonzero.
- (W,W,W). At n = 4 take W = W⁺ = diag(2,-1,-1) on Λ⁺ and 0 on Λ⁻ (traceless blocks, B = 0, so Weyl). On a Λ⁺ block # acts as k·adj, and I# = (n-2)I = 2I forces k = 2. Then &lt;W,Q(W)&gt; = tr A³ + 2 tr(A adj A) = 6 + 2·3·det A = 18. Since ‖W‖² = 6, this is exactly the equality case of Xu (2.49), |&lt;Q(W),W&gt;| &lt;= (√6/2)‖W‖³ = 18, which corroborates the normalisation. Nonzero.

Vanishing is claim 2.

**No finding** on the census: ten triples, five vanishing identically, five surviving, weights 1,3,1,3,1 on the survivors. Passage C carries 1,3,1,3,1 at source (results.md line 382).

### 1.1 Withdrawn candidate: n &gt;= 4 absent from the statement

1. Location: Passage C, "Let $R=cI+Y+W$ with $Y=R_{\mathrm{ric}_0}$. Of the ten distinct triples ... five survive". No range of n is written in Passages A-D.
2. Failure: at n = 3, SB²(so(3)) has dimension 6 = 1 + 5, so ⟨W⟩ = 0. Then (Y,Y,W) and (W,W,W) vanish identically and only three triples survive. At n = 2 the constant 1/(n-2) is undefined.
3. Charitable reading: W is the Weyl part, which the brief's definitions introduce "for n &gt;= 4", and the imported decomposition Xu (2.5) is stated for n &gt;= 4. The statement inherits that range. **Withdrawn**, with a recommendation to write n &gt;= 4 into the statement.

## 2. A mechanism for every vanishing triple (claim 2, attack item 2)

For each vanisher, every ordered placement dies by an item of Xu Prop 2.7 together with the orthogonality of (2.5):

| Triple | Placement &lt;A,Φ(B,C)&gt; | Mechanism |
|---|---|---|
| (I,I,Y) | &lt;Y,Φ(I,I)&gt;, &lt;I,Φ(I,Y)&gt; | (1) Φ(I,I) ∈ ⟨I⟩ ⊥ Y, and (2) Φ(I,Y) ∈ ⟨Ric0⟩ ⊥ I |
| (I,I,W) | &lt;W,Φ(I,I)&gt;, &lt;I,Φ(I,W)&gt; | (1), and (3) Φ(I,W) = 0 |
| (I,Y,W) | &lt;I,Φ(Y,W)&gt;, &lt;Y,Φ(I,W)&gt;, &lt;W,Φ(I,Y)&gt; | (5) Φ(Y,W) ∈ ⟨Ric0⟩ ⊥ I, then (3), then (2) |
| (I,W,W) | &lt;I,Φ(W,W)&gt;, &lt;W,Φ(I,W)&gt; | (4) Φ(W,W) ∈ ⟨W⟩ ⊥ I, and (3) |
| (Y,W,W) | &lt;Y,Φ(W,W)&gt;, &lt;W,Φ(Y,W)&gt; | (4), and (5) |

Xu's proof of (3) is (2.29): Φ(I,W) = W + W#I = Ric(W)∧id = 0. Xu's proof of (5) uses total symmetry of tri. So total symmetry is used either way: inside Xu (5), or, if one reads Passage D's "by Xu (3)" alone, to bring I and W into the two slots of Φ. It is a published identity (BW08 (5), with its proof sketched there from (4)), so this is a citation omission and not a gap.

**No finding.** Passage D's sentence "Xu Prop 2.7 plus BW08 Lemma 2.2 determine every one of the ten distinct triples" covers all five vanishers. The per-triple assignment is not written in D, and only item (3) is named, but each vanisher has a mechanism in the cited Proposition, as the table shows.

## 3. The value of (Y,Y,W) (claim 3, attack item 3)

**Derivation.** (Y,Y,W) contributes weight 3 times T(W,Y,Y) = &lt;W,Φ(Y)&gt;. W is orthogonal to ⟨I⟩ ⊕ ⟨Ric0⟩, so &lt;W,Φ(Y)&gt; = &lt;W,(Φ(Y))_W&gt;. BW08 Lemma 2.2 (hypothesis: Ricci type) applies to Y, which has λ̄ = 0 and Ricci tensor Ric0(R), and gives (Φ(Y))_W = 1/(n-2)(Ric0∧Ric0)_W. Hence &lt;W,Φ(Y)&gt; = 1/(n-2)&lt;W,Ric0∧Ric0&gt;, and the triple is 3/(n-2)&lt;W,Ric0∧Ric0&gt;.

- The multiplicity is 3 = 3!/(0!2!1!). The trilinear value is 1/(n-2)&lt;W,Ric0∧Ric0&gt;.
- The normalisation needed: ∧ as in Xu (2.7) / BW08, Ric with Ric(I) = (n-1) id, and Y = 2/(n-2) Ric0∧id. The n = 4 witness in section 1 checks the constant through two independent routes (Lemma 2.2's W block and the eigenvalue formula) and gets 8 both ways.
- The identity is quadratic in Ric0, so rescaling Ric changes the constant. With Beitz's ric = ½Ric written in place of Ric0 the constant reads 12/(n-2).

**No finding.**

### 3.3 Withdrawn candidate: the constant is stated without its normalisation

1. Location: Passage B, "$(Y,Y,W)=\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$". Passages A-D fix neither ∧ nor Ric, and the brief's definitions do not either.
2. Failure: in the ric of Beitz Definition 1.1.10 (ric = ½Ric) the same triple equals 12/(n-2)&lt;W,ric0∧ric0&gt;.
3. Charitable reading: Passage D derives the constant from BW08 Lemma 2.2 and quotes Xu (2.34), both of which fix ∧ by (2.7) and Ric without the ½. The constant is correct in the conventions of the sources the argument cites. **Withdrawn**, with a recommendation to name the BW08 normalisation at the statement.

## 4. "Against the slice exactly one new coupling" (claim 4, attack item 4)

**Derivation.** The slice is Y = 0 (Passage D, closing note: "Setting $Y=0$ kills the new coupling"). On it the cubic is c³(n-1)‖I‖² + &lt;W,Q(W)&gt;. Off it, three further survivors appear: (I,Y,Y) = (3c/2)|Ric0|², (Y,Y,Y) = -2/(n-2)² tr Ric0³ and (Y,Y,W). So (I,Y,Y) and (Y,Y,Y) are also absent from the slice. Among the three:

- (Y,Y,Y) involves Y alone.
- (I,Y,Y) is a product of the scalar c and an invariant of Y alone, |Ric0|²/2.
- (Y,Y,W) is the only new triple that involves W, the only new W-odd term, and the only one that is not a product of separately defined invariants of the summands.

Every I-W pairing vanishes: (I,I,W), (I,Y,W), (I,W,W) are in the table of section 2.

**No finding** under the reading Passage D fixes with "one genuinely new coupling". The count is one against W-dependent (equivalently, non-factorising) triples, and three against surviving triples.

### 4.1 Withdrawn candidate: (I,Y,Y) is a second new coupling

1. Location: Passage C, "the only coupling absent from the slice is the triple $(Y,Y,W)$". The neighbouring clause "every I-W pairing vanishes" invites reading "coupling" as any triple mixing two distinct summands.
2. Failure under that reading: (I,Y,Y) mixes I and Y, survives with value 3c|Ric0|²/2 (nonzero at c ≠ 0, Ric0 ≠ 0), and is absent from the slice.
3. Charitable reading: Passage D says "genuinely new coupling", and (I,Y,Y) factors as c·(|Ric0|²/2). It carries no tensor coupling and no W, so it does not enter the parity argument, which is the lemma's use. **Withdrawn.** A one-word repair ("the one new W-coupling") would remove the ambiguity.

## 5. Parity (claim 5, attack item 5)

**Omega0.** Both descriptions in the brief are W-sign invariant.

- Clause tr R &gt; 0: tr R = &lt;I,R&gt; = c‖I‖², independent of W.
- Clause (n-2)/n ‖R_W‖² &lt;= ‖R_I‖²: reads ‖W‖ and c.
- F description: ‖R‖² = ‖R_I‖² + ‖Y‖² + ‖W‖² is W-even, and ric(R) is W-independent because Ric(W) = 0.

The two descriptions agree exactly when ric = ½Ric. With ‖R_I‖² = nλ̄²/(2(n-1)) (Xu (2.10)), ‖Y‖² = |Ric0|²/(n-2) (Xu (2.11)) and ‖ric‖² = ¼(|Ric0|² + nλ̄²), the condition ‖R‖² &lt;= 4/(n-2)‖ric‖² loses its Ric0 terms and becomes ‖W‖² &lt;= n²λ̄²/(2(n-1)(n-2)) = n/(n-2)‖R_I‖². This is a convention remark on the brief's definitions and does not bear on the lemma, which uses only the W-evenness.

**LHS.** (I,I,I), (I,Y,Y), (Y,Y,Y) are W-independent. 3&lt;W,Φ(Y)&gt; is linear in W. &lt;W,Q(W)&gt; is cubic in W (Q is quadratic, so even, and the pairing adds one W).

**RHS = F(R)&lt;ric(R), ric(Φ(R))&gt;.** Φ(cI+Y+W) = c²Φ(I) + Φ(Y) + Φ(W) + 2cΦ(I,Y) + 2cΦ(I,W) + 2Φ(Y,W). Here ric(Φ(W)) = 0 by Xu (4), Φ(I,W) = 0 by Xu (3), and Φ(Y,W) ∈ ⟨Ric0⟩ by Xu (5), linear in W. So ric(Φ(R)) = E + 2 ric(Φ(Y,W)) with E W-independent, and RHS(W) = F(R)&lt;ric R, E&gt; + F(R)&lt;ric R, 2 ric Φ(Y,W)&gt; with F(R) W-even. Passage D's sentence says exactly this.

**Are RHS_even and RHS_odd defined in Passages A-D?** Not by an explicit formula. They are defined canonically as the even and odd parts under W to -W, RHS_even = ½(RHS(W) + RHS(-W)) and RHS_odd = ½(RHS(W) - RHS(-W)), and Passage D's parity sentence identifies them as F(R)&lt;ric R, E&gt; and F(R)&lt;ric R, 2 ric Φ(Y,W)&gt;. Nothing in the bound needs more than the canonical split. RHS_even is never expanded in invariants, so the bound's right-hand side is an unevaluated expression. The statement claims nothing more than this ("a bookkeeping identity ... proves no case of the conjecture by itself", Passage C).

Consistency check at Y = 0 (Passage D): Φ(0,W) = 0, so RHS_odd = 0, and (Y,Y,W) = 0. Confirmed. "Recovers the bridge exactly" names an object outside the brief and was not checked.

**No finding.**

## 6. The two-sided bound (claim 6)

With L_e, L_o, R_e, R_o as above, the criterion at cI+Y+W reads L_e + L_o &lt;= R_e + R_o. At cI+Y-W, which lies in Omega0 by section 5, it reads L_e - L_o &lt;= R_e - R_o. Rearranging the first gives L_o - R_o &lt;= R_e - L_e, and the second gives -(L_o - R_o) &lt;= R_e - L_e, hence |L_o - R_o| &lt;= R_e - L_e. Adding the two gives 2L_e &lt;= 2R_e, so R_e - L_e &gt;= 0 follows and is not an extra hypothesis. F(R) is defined at both points since their scalar curvatures agree.

**No finding.**

## 7. Classification against Xu and Huisken (claim 7, attack item 6)

**Xu Lemma 2.8 (2.34), read at source (Xu lines 516-620).** With c = λ̄/(n-1):

- c³(n-1)‖I‖² = (λ̄³/(n-1)³)(n-1)(n(n-1)/2) = nλ̄³/(2(n-1)). Matches Xu's first term.
- 3c&lt;I,Φ(Y)&gt; = 3λ̄/(n-1) · |Ric0|²/2 = 3λ̄|Ric0|²/(2(n-1)). Matches the second.
- (Y,Y,W) = 3/(n-2)&lt;Ric0∧Ric0,W&gt;. Matches the third.
- (Y,Y,Y) = -2/(n-2)² &lt;(Ric0²)_0,Ric0&gt;. Matches the fourth (Xu (2.39)), and the n = 4 witness of section 1 agrees (-12).
- (W,W,W) = &lt;Q(W),W&gt;. Matches the fifth.

The order in Passage D, (I,I,I), (I,Y,Y), (Y,Y,W), (Y,Y,Y), (W,W,W), is Xu's printed order. Xu's own proof (2.42) assembles 3&lt;Q(R_Ric0),W&gt; as 2 from (2.37) plus 1 from (2.41), the multinomial weight split by contraction slot.

**Huisken, read at source (JDG 21 (1985), p. 53).** Xu line 516: "derived by Huisken in his proof of the Theorem 3.3 in [16]. Since this identity was not written down as an independent lemma". Passage D reports this correctly. On p. 53 Huisken contracts the cubic 2R R R + ½R R R against U, V, W separately. The U contraction gives 2/(n(n-1)) R·S, the V contraction contains 4/(n-2) R̊_ik R̊_jl W^ijkl, and the W contraction contains 2/(n-2) R̊_ik R̊_jl W^ijkl. The same 2 : 1 split of the coupling appears as in Xu (2.37) and (2.41). The identity is there, grouped by contraction slot in tensor normalisation (so R·S appears in place of a pure λ̄³ term), inside the polynomial P of (3.1), which also carries -|Rm|²S.

**No finding.** Passage C's "the expansion is Huisken's, term for term" is exact for Xu (2.34) and holds for Huisken after regrouping. The charitable reading (Huisken's identity, printed term for term by Xu) is what Passage D says. Recorded as a wording note only. The provenance remark "reached here from BW08 Lemma 2.2 rather than copied" cannot be checked from the mathematics. It is immaterial, since Xu (2.31) is BW08 Lemma 2.2 verbatim.

## 8. Passage E, the Lean statement (claim 8, standing item 5, attack item 7)

The file at lean/HamiltonsCubic/Results/L45Statement.lean is identical to Passage E (diffed). No build was run, under the no-computation rule, so "proved here" is taken from the file as written (no sorry appears).

| Theorem | What it types | Binders, direction, exclusions |
|---|---|---|
| two_sided | Le+Lo &lt;= Re+Ro and Le-Lo &lt;= Re-Ro imply abs(Lo-Ro) &lt;= Re-Le | Arbitrary reals. Directions match section 6. Hypotheses exclude nothing that matters. The identification of Le, Lo, Re, Ro with curvature quantities is in the docstring only, as the header says |
| even_gap_nonneg | the same hypotheses imply 0 &lt;= Re-Le | Correct |
| cubic_odd | Q even implies &lt;-x,Q(-x)&gt; = -&lt;x,Q x&gt; | Correct. hQ holds for the real Q (quadratic) but is not discharged, since Q is not in the file |
| slice_odd | from hP : ∀ x, P(-x) = -P x, conclude P(-x) = -P x | **The conclusion is the hypothesis instantiated.** It types nothing (candidate 8.1) |
| omega0_sign_symmetric | φ‖-W‖ ↔ φ‖W‖ for every φ : ℝ → Prop | Hypothesis-free, true of every φ. It types norm_neg. That Omega0 membership is a function of ‖W‖ (and of c, Y) is untyped. Adequate to the docstring, which claims only "its clauses reading ‖W‖ only" |
| ten_triples | 10 elements (i,j,k) ∈ Fin 4³ with i+j+k = 3 | Correct: C(5,2) = 10 |
| five_and_five, degrees | two length-5 lists, jointly duplicate-free, all of degree 3 | Correct. With ten_triples this implies the ten listed triples are all of them, though no theorem states that. Which five survive is by definition of the lists, and the header says so ("Not typed here") |
| survivor_weights, vanisher_weights, no_survivor_has_weight_six, weights_partition | [1,3,1,3,1], [3,3,6,3,3], sums 9 and 18, 9+18 = 27 | Correct. Nat division 3!/(i!j!k!) is exact at degree 3 |
| coupling_split | x ≠ 2 implies 3/(x-2) = weight(0,2,1)·(1/(x-2)) | True, but it types only weight(0,2,1) = 3. hx is unnecessary (in Lean 3/0 = 0 = 3·(1/0)), so the hypothesis excludes x = 2 for no reason. The value of (Y,Y,W) is untyped, as the header says |

### 8.1 Candidate, standing: slice_odd is vacuous

1. Location: `theorem slice_odd (P : V → ℝ) (hP : ∀ x : V, P (-x) = -P x) (x : V) : P (-x) = -P x := hP x`, with docstring "**`P(-W) = -P(W)` on the slice** ... `𝒲ₙ` is linear and the cubic is odd on it."
2. Failure: the hypothesis hP, specialised at x, is the conclusion. The theorem holds for every P satisfying hP and asserts nothing beyond hP. It mentions no slice, no cubic and no 𝒲ₙ. The docstring's claim (the cubic is odd on the slice, so the two-sided bound is empty there) is not typed by it.
3. Charitable reading: it is a named restatement kept for documentation. Even so, a theorem whose hypothesis is its conclusion "says nothing about the lemma" in the sense of attack item 7, and its docstring presents it as a fact about the slice. **Stands**, as a Lean-docstring defect. It does not touch the mathematics of L45, and the true content is already in cubic_odd.

### 8.2 Candidate, standing: the header reports a canon error that the canon no longer carries

1. Location: Lean header, "[results.md] records the survivors as carrying *"multiplicities $1,3,3,6$"*", and the docstring of survivor_weights, "the record's correction to results.md's `1,3,3,6`".
2. Failure: results.md line 382 (Passage C) reads "with multiplicities $1,3,1,3,1$". The quoted text is absent at source.
3. Charitable reading: the header quotes a review block that was correct when written, and the correction has since been applied. The sentence is still in the present tense about the current file, and it is false of it. **Stands**, as a stale docstring. It does not touch any theorem.

Verdict for claim 8: every theorem is true and its inequality directions match the lemma. The file types the reflection arithmetic, the sign-symmetry of norms and the multinomial census, and it declares that the curvature content is untyped. CONFIRMED AS ALGEBRA, with 8.1 and 8.2 to fix.

## 9. Edges of every range (standing item 3, attack item 8)

- **n = 3.** No W, three survivors (1.1, withdrawn by the n &gt;= 4 convention). The identity itself holds with W = 0.
- **n = 4.** Smallest admissible n. 1/(n-2) = ½. Witnesses in section 1 give all five survivors nonzero, including (W,W,W) = 18 at the equality case of Xu (2.49). No finding.
- **Odd n.** Nothing in the argument depends on the parity of n. No finding.
- **Y = 0.** The identity reduces to c³(n-1)‖I‖² + &lt;W,Q(W)&gt;, RHS_odd = 0, and the bound reduces to |&lt;W,Q(W)&gt;| &lt;= RHS_even - LHS_even. That is the criterion over the W-sign-symmetric slice read at both signs, which is why the two-sidedness adds nothing there. No finding.
- **W = 0.** R is of Ricci type, the odd parts vanish, and the bound is the criterion itself. No finding.
- **c &lt;= 0.** The identity holds for every real c. tr R = c‖I‖² &lt;= 0 puts R outside Omega0, so the bound's premise is empty and nothing is asserted. No finding.
- **ker W ≠ 0 (zero-padded Weyl).** Every step is algebraic in W and uses only W ∈ ⟨W⟩. BW08 Lemma 2.1's proof runs through exactly these embedded tensors. No finding.

## 10. The gap between what is proven and what is stated or used (standing item 4)

- Proven: the five-term identity with weights 1,3,1,3,1, the vanishing of the other five, the value 3/(n-2)&lt;W,Ric0∧Ric0&gt; in BW08 normalisation, Omega0's W-sign invariance, the parity split of both sides, and the conditional two-sided bound with R_e &gt;= L_e.
- Stated: the same, with three wording looseness items (n &gt;= 4 unwritten, "coupling" unpinned, normalisation unnamed), all withdrawn under readings the passages support.
- Used downstream (Passage D's closing note): the bound is a consequence of assuming the criterion at both signs. Using it toward a proof of the criterion would be circular. Passage C says it "proves no case of the conjecture by itself", which matches.
- Not proven and not claimed: any evaluation or sign of RHS_even, or any bound on LHS_odd - RHS_odd.

## 11. The falsifying object, and the search (standing item 7)

- **For the identity:** an (n &gt;= 4, c, Y, W) at which &lt;R,Φ(R)&gt; differs from the five-term sum, or a vanisher that is nonzero at some object. Searched by locating a source mechanism for every ordered placement of every vanisher (section 2), and by exact n = 4 witnesses for each surviving term, each checked by two routes (BW08 Lemma 2.2 against the eigenvalue formula, and trace against Xu (2.32), and (W,W,W) against the equality case of Xu (2.49)).
- **For the constant:** a Ricci-type Y with (Φ(Y))_W ≠ 1/(n-2)(Ric0∧Ric0)_W. The diag(1,1,-1,-1) witness agrees.
- **For the parity argument:** a point of Omega0 whose W-reflection leaves Omega0, or a W-odd piece of ric(Φ(R)) outside Φ(Y,W). Both are excluded in closed form (section 5).
- **For the bound:** reals satisfying both criteria and violating the bound. Excluded by the two-line rearrangement (section 6).
- **For the Lean file:** a theorem whose hypotheses carry its conclusion or exclude the intended object. Found: slice_odd (8.1). coupling_split's hx is unneeded but harmless.

None was found for the mathematics.

## Overall verdict

**PROVEN.** The identity, the census, the value of the coupling, the parity argument and the two-sided bound are correct, and each step follows from the statement's hypotheses and from imported theorems whose hypotheses hold for the object. The cited source must include BW08 (5) / Xu (2.33) for total symmetry, which the written argument uses without citing. Two standing Lean-docstring defects (8.1 slice_odd vacuous, 8.2 stale 1,3,3,6 report) and three optional wording repairs (n &gt;= 4, "W-coupling", BW08 normalisation) are for the round to act on. None of them changes the mathematics.
