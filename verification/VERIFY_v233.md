# Verifier v233, Lemma L43: the slice collapse of the a = 0 invariance criterion, the boundary constant c(n-1) = θ₀(n), the direction of Beitz Lemma 2.3.4, and the Lean file L43Statement.lean

The brief was cold: I worked from [BRIEF_L43.md](BRIEF_L43.md), the source lines it cites, the two reference folders and the Lean files, and opened no round file, review, ledger or other agent's log. No numerical work was done. Every value is exact and derived by hand in closed form. No scripts were written, and the Lean file was read, not built. Log: [agent_logs/verify-L43-v233.log](../agent_logs/verify-L43-v233.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The collapse on the slice: Φ(cI+W) = c²(n-1)I + Φ(W), the cross terms vanish, ‖ric I‖² cancels, and G(cI+W) ≤ 0 ⟺ ⟨W,Q(W)⟩ ≤ c(n-1)‖W‖² at every slice point with c ≠ 0 ("an identity on the whole slice", Passage A) | CONFIRMED |
| 2a | Passage A's display ⟨W,Q(W)⟩ ≤ θ₀(n)‖W‖³ as the criterion at the points of ∂Ω₀ on the slice | CONFIRMED |
| 2b | Passages B and C: the criterion "on Ω₀" / "at a = 0" collapses to ⟨W,Q(W)⟩ ≤ c(n-1)‖W‖² "with/where c(n-1) = θ₀(n)" | REFUTED AS STATED (true exactly on ∂Ω₀ at ‖W‖ = 1) |
| 3 | ∂Ω₀ meets the slice at one ratio c/‖W‖ = (1/n)√(2(n-2)/(n-1)), and tr R > 0 selects the positive root | CONFIRMED |
| 4a | Imported facts: BW08 Lemma 2.1, BW08 eq. (6), Beitz p. 96 (Remark 6.3.10), Φ preserving Bianchi, Hamilton's scalar identity, conventions across the two sources | CONFIRMED |
| 4b | The direction invariance ⇒ dF_R(Φ(R)) ≤ 0: Passage D "Lemma 2.3.4 supplies only the converse; it holds via d/dt scal = 2‖ric‖² > 0" | REFUTED AS STATED (the source's first clause is that direction, and D's substitute argument proves something else) |
| 4c | Passage E: that direction is "the first clause of Beitz's Lemma 2.3.4, whose hypotheses check" | CONFIRMED (hypotheses corrected): the clause's premise is invariance of all sublevel sets, and the one-level form used is what the source's proof establishes |
| 5 | Title claim "demands θ₀(n) and nothing weaker" | CONFIRMED, scoped: a necessary condition for invariance of Ω₀, on the slice |
| 6 | Lean, Passage F: the typed statements | CONFIRMED AS ALGEBRA |
| 6b | Lean, the account of what is NOT typed ("RealLayer has ... no Φ") | REFUTED AS STATED (minor: RealLayer defines Qop, Hamilton's map R² + R#) |
| 7 | Range edges: n = 3, 4, odd n, n = 6 + 2√7, c ≤ 0, W = 0, ker W ≠ 0 | CONFIRMED |
| 8 | "Three verifiers, [ROUND_L43-arg](../verification/ROUND_L00r2.md), so the bound demanded is" | REFUTED AS STATED (not a sentence, and link text and target disagree) |
| 9 | Passage C side clause "The cone has three endpoints" | REFUTED AS STATED (minor wording) |

**What the round should do:** keep the proof, write "on ∂Ω₀ at ‖W‖ = 1" (or the homogeneous θ₀(n)‖W‖³ form with "on ∂Ω₀") into Passages B and C, replace Passage D's sentence on Lemma 2.3.4 with the first clause read levelwise through its proof, and fix the two link texts.

## 0. Conventions, fixed once

- Λ² = Λ²ℝⁿ with ⟨R,S⟩ = tr(R∘S) on self-adjoint endomorphisms (Beitz Remark 1.1.7, diss_beitz.txt line 442), which is the record's inner2 = ½tr(XᵀY) on bivectors (BW08: −½tr(AB)). Write N := dim Λ² = n(n-1)/2, so ‖I‖² = N. *Beitz uses the letter N for dim Aₙ = n²(n²-1)/12. Below, N always means dim Λ².*
- Aₙ = algebraic curvature tensors (Bianchi), Beitz Definition 1.1.5. Aₙ = ⟨I⟩ ⊕ ⟨Ric₀⟩ ⊕ W orthogonally (Beitz Lemma 1.1.14 for n ≥ 4, BW08 §1).
- Beitz's ric carries a factor ½ against BW08 (Beitz Definition 1.1.10), and scal(R) = tr(R) (Beitz Remark 1.1.11). By Beitz (1.5)/(6.30), ‖ric I‖² = n(n-1)²/4 = ((n-1)/2)·N. Only ric's linearity and ric(I) ∝ id are used below, so the factor never enters.
- Φ(R) = R² + R#, Φ(A,B) = ½(AB+BA) + A#B, so Φ(R) = Φ(R,R) and Q(W) = Φ(W).
- F(R) = ‖R‖²/‖ric R‖² on C := {scal > 0} ⊂ Aₙ (open, and ric ≠ 0 there since tr ric = scal). Ω_a = C ∩ F⁻¹((−∞, 4/(n-2+4a)]). G(R) := dF_R(Φ(R)).
- The slice: R = cI + W, W ∈ W. On it R ∈ C ⟺ c > 0, since scal(R) = tr R = cN.
- p := ⟨W,Q(W)⟩, w := ‖W‖, ρ := ‖ric I‖² > 0, c_∂(n) := (1/n)√(2(n-2)/(n-1)), θ₀(n) = √(2(n-1)(n-2))/n.

## 1. Hypothesis inventory

| Imported fact | Hypotheses at source | Object it is applied to | Check | Used? |
|---|---|---|---|---|
| BW08 Lemma 2.1 (txt lines 216–231): R + R#I = (n-1)R_I + ((n-2)/2)R_Ric₀, ⟨W⟩ in the kernel | R ∈ S²_B(so(n)). Decomposition stated for n ≥ 4, kernel proved at n = 4 and pushed to n ≥ 5 by the embedding of Weyl operators | R = I (gives Φ(I) = I + I#I = (n-1)I) and R = W (gives W#I = −W) | I, W ∈ S²_B. At n = 3 the Weyl summand is 0 and nothing is applied | Yes, load-bearing |
| The same eigenvalues in Beitz's own convention, (6.29) (txt line 5653): d/ds Φ(I+sR) = 2(R + I#R) = 2(n-1)R_I + (n-2)R_ric₀, citing [BW08, Lemma 2.1] | R ∈ Aₙ | Settles that the map R ↦ R#I in Beitz's Φ, the Φ in the criterion, has the eigenvalues n-2, (n-4)/2, −1 of BW08's. Beitz herself imports Lemma 2.1 into her Φ | Checks | Yes, as the convention bridge |
| BW08 eq. (6) (txt line 203): Ric(R²+R#)_ij = Σ_k Ric_kk R_kijk, e_i an orthonormal eigenbasis of Ric | R ∈ S²_B | R = W: Ric(W) = 0, so every orthonormal basis is an eigenbasis and the right side is 0 | Checks. The sign flip against the record (notes.md) is invisible at Ric = 0 | Only its trace, scal(Φ(W)) = 0, is load-bearing |
| Hamilton's scalar identity, Beitz Example 2.3.5 (txt lines 1497–1512): scal(R² + R#) = 2‖ric(R)‖², via [Ham86] | R ∈ Aₙ | R = W, giving scal(Φ(W)) = 0 | Checks, in Beitz's convention. It agrees with the trace of eq. (6) | Yes, load-bearing (Passage A's "Hamilton's scalar identity") |
| Φ maps Aₙ to Aₙ (Bianchi preserved) | Beitz Remark 2.3.2 (txt lines 1392–1400) asserts it: "Φ : Aₙ → Aₙ is the map ... R² + R#". BW08 states the ODE on S²_B | Needed for Lemma 2.3.4's hypothesis Φ : V → V with V = Aₙ | Sourced at Beitz Remark 2.3.2. Passage D calls it "standard Hamilton fact" without citing it | Needed for Lemma 2.3.4 only. The collapse itself needs only ⟨I,Φ(W)⟩ = tr Φ(W) = scal Φ(W) and ⟨id, ric Φ(W)⟩, both 0 by the line above |
| Beitz p. 96–97, Remark 6.3.10 (txt lines 5448–5468): Ω₀ = {((n-2)/n)‖R_W‖² ≤ ‖R_I‖² and tr R > 0} | n ≥ 3, a ∈ [0, n/4], via Remark 1.1.16 | Slice point cI + W: ‖R_I‖² = c²N, ‖R_W‖² = w² | Checks. Quoted faithfully in Passage D | Yes, for the boundary ratio |
| Beitz Lemma 2.3.4 (txt lines 1470–1476) | V a vector space, Φ : V → V locally Lipschitz, C ⊆ V open, F : C → ℝ smooth. Clause 1 premise: "the sublevel sets of F are invariant" | V = Aₙ, Φ quadratic (locally Lipschitz, Beitz Remark 2.3.2), C = {scal > 0} open, F smooth on C since ‖ric‖ > 0 there | V, Φ, C, F check. The clause-1 premise quantifies over every sublevel set, while the conjecture's a = 0 member supplies one. The proof (lines 1477–1483) uses only the sublevel set at level a := F(v) | Yes, for "demands" (Passage A's last line, Passage E) |
| BW08 eq. (5), symmetry of tri | none beyond S²(so(n)) | not needed | Passage C calls it a theorem and not a hypothesis of the collapse, which is right | No |
| ‖I‖² = N | Beitz Remark 1.1.7 (trace on Λ²) | I | Checks, and matches Beitz ‖R_I‖² = 2scal²/(n(n-1)) at R = cI: 2c²N²/(n(n-1)) = c²N | Yes |

**Used but unstated in the statement (A, B, C):** (i) c ≠ 0 for the collapse, supplied on Ω₀ by scal > 0. (ii) R ∈ ∂Ω₀ and ‖W‖ = 1 for c(n-1) = θ₀(n) (section 2b). (iii) The one-level form of Lemma 2.3.4's first clause for "demands" (section 4c). Bianchi preservation is named in Passage D line 70 and is at source.

## 2. Claim 1 and claims 2a, 2b: the collapse and its two forms

### 2.1 The criterion as an explicit inequality

For R ∈ C, the quotient rule on F = ‖R‖²/‖ric R‖² with ric linear gives

G(R) = 2(⟨R,Φ(R)⟩‖ric R‖² − ‖R‖²⟨ric R, ric Φ(R)⟩)/‖ric R‖⁴,

so, since ‖ric R‖⁴ > 0, G(R) ≤ 0 ⟺ ⟨R,Φ(R)⟩ ≤ F(R)⟨ric R, ric Φ(R)⟩. This is Beitz's (2.3) at the point R. The "invariance criterion at a = 0" is this inequality at the points where invariance of Ω₀ tests it, R ∈ ∂Ω₀ ∩ C, where F(R) = 4/(n-2) (section 4c).

### 2.2 The collapse, link by link

1. Bilinearity: Φ(cI+W) = c²Φ(I) + 2cΦ(I,W) + Φ(W). Follows from R#S = S#R (BW08 txt line 187, Beitz Definition 1.1.17 "symmetric bilinear").
2. Φ(I) = I² + I#I = I + (n-2)I = (n-1)I. Lemma 2.1 at R = I, where R_I = I, R_Ric₀ = 0.
3. Φ(I,W) = ½(IW + WI) + I#W = W + W#I = 0. Lemma 2.1 kernel, and (6.29) in Beitz's convention.
4. Hence Φ(cI+W) = c²(n-1)I + Φ(W). **Passage D's bridge identity: follows.**
5. ⟨R,Φ(R)⟩ = c³(n-1)N + c²(n-1)⟨W,I⟩ + c⟨I,Φ(W)⟩ + p. Here ⟨W,I⟩ = tr W = 0 (W ⊥ ⟨I⟩), and ⟨I,Φ(W)⟩ = tr Φ(W) = scal Φ(W) = 2‖ric W‖² = 0. So ⟨R,Φ(R)⟩ = c³(n-1)N + p. **Follows.** Passage D's justification "because Φ(W) is again Weyl" is correct and stronger than needed.
6. ‖R‖² = c²N + w². ric R = c·ric I (ric W = 0). ric Φ(R) = c²(n-1)ric I + ric Φ(W).
7. ⟨ric R, ric Φ(R)⟩ = c³(n-1)ρ + c⟨ric I, ric Φ(W)⟩. Since ric I is a multiple of id, the second term is a multiple of tr ric Φ(W) = scal Φ(W) = 0. So ⟨ric R, ric Φ(R)⟩ = c³(n-1)ρ, and ‖ric R‖² = c²ρ.
8. F(R)⟨ric R, ric Φ(R)⟩ = ((c²N + w²)/(c²ρ))·c³(n-1)ρ = c³(n-1)N + c(n-1)w². **ρ = ‖ric I‖² cancels between F and the pairing: follows.**
9. Substituting, for every slice point with c ≠ 0:

G(cI+W) = 2(p − c(n-1)w²)/(c²ρ).

So G(cI+W) ≤ 0 ⟺ ⟨W,Q(W)⟩ ≤ c(n-1)‖W‖², the c³(n-1)N term common to both sides, "leaving exactly ⟨W,Q(W)⟩ − c(n-1)‖W‖² and nothing else" (up to the positive factor 2/(c²ρ)). **Claim 1: CONFIRMED**, on the whole slice minus c = 0, where F and G are undefined (section 7).

### 2.3 Claim 2a: Passage A's display on ∂Ω₀

On ∂Ω₀ ∩ C ∩ slice, section 3 gives c = c_∂(n)·w, so c(n-1)w² = (n-1)c_∂(n)·w³ = θ₀(n)w³ by the identity (n-1)c_∂(n) = θ₀(n) (section 3). So there the criterion reads p ≤ θ₀(n)‖W‖³, homogeneous of degree 3 and valid at every scale on the cone. **CONFIRMED** at ∂Ω₀.

### 2.4 Claim 2b: the scope of "c(n-1) = θ₀(n)" in Passages B and C

The identity c(n-1) = θ₀(n) holds exactly when c = c_∂(n), that is, on ∂Ω₀ with ‖W‖ = 1. Off ∂Ω₀, or on ∂Ω₀ at ‖W‖ ≠ 1, the constant in the collapsed criterion is c(n-1) ≠ θ₀(n).

**Candidate 2b-i (Passage B, "collapses Böhm–Wilking's criterion on Ω₀ to ⟨W,Q(W)⟩ ≤ c(n-1)‖W‖² with c(n-1) = θ₀(n) exactly").**

1. Location: [results.md](../results.md) line 100, quoted in the brief as Passage B.
2. Closed-form failure at n = 4. Λ² = Λ⁺ ⊕ Λ⁻, two commuting so(3) ideals, and an algebraic Weyl operator is W⁺ ⊕ W⁻ with W± symmetric and trace-free. Take W⁺ = t·diag(2,−1,−1) in an orthonormal basis e₁, e₂, e₃ of Λ⁺ with [e_i,e_j] = ±μe_k cyclically, and W⁻ = 0. From BW08 (4), for diagonal A, B on Λ⁺: (A#B)₁₁ = ½μ²(a₂b₃ + a₃b₂), cyclically, and Λ⁻ contributes nothing to Λ⁺ entries since [Λ⁺,Λ⁻] = 0. Lemma 2.1 at R = I gives I#I = (n-2)I = 2I, so μ² = 2. Consistency: (W#I)₁₁ = a₂ + a₃ = −a₁, which is W#I = −W. Then (W#W)_ii = 2a_ja_k, so ⟨W,W#⟩ = 6a₁a₂a₃ = 12t³, tr W³ = Σa_i³ = 6t³, and ⟨W,Q(W)⟩ = 18t³ with ‖W‖² = 6t². At t = 1/√6: ‖W‖ = 1, ⟨W,Q(W)⟩ = 3/√6 = √(3/2). Now θ₀(4) = √12/4 = √3/2, c_∂(4) = (1/4)·√(4/3) = 1/(2√3). Take R = (1/√3)I + W, so c = 2c_∂(4). Membership: ((n-2)/n)‖W‖² = 1/2 ≤ c²N = (1/3)·6 = 2, and tr R > 0, so R ∈ int Ω₀ ⊂ Ω₀. Here c(n-1) = 3/√3 = √3 ≠ √3/2 = θ₀(4). The criterion at R is √(3/2) ≤ √3, which HOLDS, while ⟨W,Q(W)⟩ ≤ θ₀(4)‖W‖² reads √(3/2) ≤ √3/2, which FAILS. So "on Ω₀ ... with c(n-1) = θ₀(n)" is false at this point of Ω₀.
3. Most charitable reading: "on Ω₀" means on its boundary, and W is tacitly unit because the collapsed inequality is invariant under R ↦ λR (both sides scale as λ³). The boundary reading contradicts the words "on Ω₀", and the normalisation appears nowhere in Passage B. The failure survives.

**Candidate 2b-ii (Passage C, "at a = 0 the whole condition collapses to ⟨W,Q(W)⟩ ≤ c(n-1)‖W‖², where c(n-1) = θ₀(n)").**

1. Location: [results.md](../results.md) line 370, quoted in the brief as Passage C. Passage C opens with "Write R = cI + W on the Einstein slice", c free.
2. Closed-form failure: the same R = (1/√3)I + W at n = 4 is on the slice with c(n-1) = √3 ≠ θ₀(4). Even under the reading "at a = 0" = on ∂Ω₀, the point R' = 2((1/(2√3))I + W) = (1/√3)I + 2W lies on ∂Ω₀ (((n-2)/n)·4 = 2 = c²N) with c(n-1) = √3 ≠ θ₀(4).
3. Most charitable reading: "at a = 0" names the boundary ∂Ω₀ and c is the boundary scalar at unit W, as Passage D spells out ("Normalising ‖W‖ = 1, the ∂Ω₀ constraint ... gives c = ..."). This makes the clause true, but both conditions have to be imported from Passage D, and Passage E's own remark "‖W‖ = 1 is what makes the criterion's inequality homogeneous" confirms the normalisation is load-bearing and absent from C. The failure survives as a statement defect.

**Verdict 2b: REFUTED AS STATED.** The mathematics is intact: Passage D states both conditions, Passage A's homogeneous display is right on ∂Ω₀, and the demanded constant is unchanged because the boundary is where the demand is strongest (section 5). The fix is to the wording of B and C: "on ∂Ω₀, at ‖W‖ = 1" or the θ₀(n)‖W‖³ form.

### 2.5 Withdrawn candidates for claims 1 and 2

**W-1. Passage A's first sentence "On the slice R_ric₀ = 0 the invariance criterion at a = 0 collapses ... to ⟨W,Q(W)⟩ ≤ θ₀(n)‖W‖³".**

1. Location: [problem.md](../findings/problem.md) lines 598–601.
2. Read literally as a claim at every slice point, the n = 4 point R = (1/√3)I + W of 2b-i is a slice point where the criterion holds and the display fails.
3. Charitable reading: "the invariance criterion at a = 0" is the criterion for invariance of Ω₀, tested at ∂Ω₀ (section 4c). Passage A's own third paragraph supplies this ("∂Ω₀ meets the slice at one ratio c/‖W‖, so each unit W is tested against θ₀(n)"), and its second paragraph puts the whole-slice identity on the c(n-1) form. The display is homogeneous, so no normalisation is needed. **Withdrawn**: the reading is supported by the passage's own text.

**W-2. "The collapse is an identity on the whole slice" fails at c = 0.**

1. Location: [problem.md](../findings/problem.md) line 603.
2. At R = W (c = 0), ric R = 0, so F and G are undefined.
3. Charitable reading: the criterion is defined only where F is, and Ω₀ excludes c = 0 by scal > 0. **Withdrawn.**

## 3. Claim 3: the boundary ratio and the root

On the slice, Remark 6.3.10's a = 0 form reads ((n-2)/n)w² ≤ c²N, with boundary ((n-2)/n)w² = c²·n(n-1)/2, that is c² = 2(n-2)w²/(n²(n-1)). Its roots are c = ±(w/n)√(2(n-2)/(n-1)) = ±c_∂(n)·w. The clause tr R = cN > 0 selects the positive root, so for W ≠ 0 the ratio c/‖W‖ on ∂Ω₀ ∩ C is the single value c_∂(n). Then

c_∂(n)·(n-1) = ((n-1)/n)√(2(n-2)/(n-1)) = √((n-1)²·2(n-2)/(n-1))/n = √(2(n-1)(n-2))/n = θ₀(n),

using n-1 > 0. Squares: 2(n-2)(n-1)/n² on both sides. **CONFIRMED.**

The lower-nappe aside (Passage A line 606, Passage D line 65): F(−R) = F(R) since ric is linear, and the collapse of section 2.2 holds for c < 0, so at c = −c_∂(n)w it reads p ≤ −θ₀(n)w³. Correct as algebra.

The Einstein-slice paragraph: R_ric₀ = 0 is Einstein, Ricci-flat adds c = 0, and on the closure of Ω₀ at c = 0 the inequality gives ((n-2)/n)w² ≤ 0, so w = 0 for n ≥ 3. Correct.

**Withdrawn W-3. "The clause is in the source's own definition and convexity forces it independently" (Passage A line 606).**

1. Location: quoted.
2. −Ω₀ = {F ≤ 4/(n-2), scal < 0} is the image of the convex set Ω₀ under the linear map R ↦ −R, so it is convex too. Convexity alone does not select scal > 0 over scal < 0.
3. Charitable reading: "it" is a one-nappe clause. The double cone is not convex (on the slice, the midpoint of c_∂I + W and −c_∂I + W is W, which is outside both nappes), so convexity forces discarding a nappe, and the sign is then fixed by the source's definition cited in the same sentence. **Withdrawn**, not load-bearing.

**Withdrawn W-4. "False at every sphere product" for the lower nappe.**

1. Location: Passage A line 606.
2. S¹ × S^(n-1) is conformally flat, so its Weyl part is 0, and 0 ≤ −θ₀(n)·0 holds.
3. Charitable reading: the aside concerns unit W, and a zero Weyl tensor has no unit normalisation. Nothing in L43 rests on the aside. **Withdrawn.**

## 4. Claims 4a to 4c: imports against source, and the gap between proven and stated

### 4a. Imported facts

All read at source, see the inventory in section 1. BW08 Lemma 2.1 and eq. (6) are quoted faithfully in Passage D's table. Beitz Remark 6.3.10's Ω₀ is quoted faithfully, including the tr R > 0 clause. The convention hazard between the two sources is closed at source: Beitz's (6.29) states R + I#R = (n-1)R_I + (n-2)R_ric₀/2 for her Φ and cites [BW08, Lemma 2.1] for it, so W#I = −W holds for the Φ inside her criterion. Hamilton's scalar identity is at Beitz Example 2.3.5. **CONFIRMED.** *No finding:* Φ preserving Bianchi is sourced at Beitz Remark 2.3.2, and the collapse needs only scal Φ(W) = 0, which Passage D's neighbouring paragraph ([problem.md](../findings/problem.md) line 72) also says.

### 4b. Passage D on the direction of Lemma 2.3.4

1. Location: [problem.md](../findings/problem.md) line 70: "the bridge needs invariance ⇒ G ≤ 0, where Beitz Lemma 2.3.4 supplies only the converse; it holds via d/dt scal = 2‖ric‖² > 0".
2. The source (diss_beitz.txt lines 1470–1472) reads: "If the sublevel sets of F are invariant under (2.2), then for all v ∈ C we have that dF_v(Φ(v)) ≤ 0." That is invariance ⇒ G ≤ 0, stated as the FIRST clause, and the converse follows it ("Conversely, if F satisfies (2.3) ..."). So "supplies only the converse" is false at source. The substitute argument proves something else: d/dt scal = 2‖ric‖² ≥ 0 gives invariance of {scal ≥ a} (Example 2.3.5), which is the extra hypothesis "C is additionally invariant" in the converse's last sentence. It says nothing about the sign of dF_R(Φ(R)) at a boundary point.
3. Charitable reading: the sentence intends "the direction needed is available, and C's invariance holds by the scalar identity". The first half contradicts the words "only the converse", and the second half is not an argument for the direction named. **REFUTED AS STATED.** Impact: none on the conclusion, since the source supplies the direction (4c).

### 4c. Passage E: "the first clause ... whose hypotheses check"

The structural hypotheses check (section 1). The clause's premise, "the sublevel sets of F are invariant", covers every level a, while what Passage E and Passage A's last line use is invariance of the single sublevel set Ω₀ (level 4/(n-2)). The Böhm–Wilking conjecture (Remark 6.3.15) asserts invariance only for levels in [2/(n-1), 4/(n-2)]. Beitz's proof of the clause (lines 1477–1483) sets a := F(v) and uses only invariance of F⁻¹((−∞,a]), so it proves the one-level form: if F⁻¹((−∞,a]) is invariant and F(v) = a, then dF_v(Φ(v)) ≤ 0. The one-level form is at source in the proof. **CONFIRMED (hypotheses corrected):** cite the proof's one-level step, since the statement's premise does not check for Ω₀ alone. *Side note, not a finding on L43:* Passage E's link text "[Beitz](findings/problem.md)" names Beitz and points at problem.md.

### Gap between proven and stated (standing item 4)

- Proven: the whole-slice identity G(cI+W) = 2(p − c(n-1)w²)/(c²ρ) for c ≠ 0, the boundary constant (n-1)c_∂(n) = θ₀(n), and, with 4c, the necessary condition "Ω₀ invariant ⇒ ⟨W,Q(W)⟩ ≤ θ₀(n)‖W‖³ for every Weyl W".
- Stated beyond that: B and C attach c(n-1) = θ₀(n) to the criterion without ∂Ω₀ and ‖W‖ = 1 (section 2.4).
- Not claimed and not proven, correctly: the converse (the bound ⇒ invariance), anything off the slice (Passage C defers to L45), and sharpness (Passage D's odd-n paragraph, outside the statement).
- **Claim 9, Passage C "The cone has three endpoints".** (1) [results.md](../results.md) line 370. (2) The family is indexed by a ∈ [0, n/4], which has two endpoints, and the sentence goes on to name one ("the degenerate end a → n/4"). (3) Charitable reading: the three regimes of Remark 6.3.10 (a > n/4 empty, a = n/4 a ray, a = 0), which Passage D tabulates. Those are regimes, one of them empty, and not endpoints. **REFUTED AS STATED**, wording only. The rest of the clause checks: Lemma 6.3.16 (txt line 5631) carries no restriction on n beyond the section's n ≥ 3.

## 5. Claim 5: "demands θ₀(n) and nothing weaker"

Quantifier order. Fix n ≥ 4 and a Weyl W ≠ 0. Its unique boundary point is R_W := c_∂(n)‖W‖·I + W ∈ ∂Ω₀ ∩ C (section 3). If Ω₀ is invariant, the one-level first clause (4c) gives G(R_W) ≤ 0, which by section 2 is ⟨W,Q(W)⟩ ≤ θ₀(n)‖W‖³. Quantifying over all W: invariance of Ω₀ ⇒ sup_{W≠0} ⟨W,Q(W)⟩/‖W‖³ ≤ θ₀(n).

"Nothing weaker" quantifies over the constant K in "⟨W,Q(W)⟩ ≤ K‖W‖³ for all W": each W is tested at exactly one boundary point, so the demand is K = θ₀(n) and not some K > θ₀(n). At interior slice points c > c_∂(n)‖W‖, the demand c(n-1)‖W‖² > θ₀(n)‖W‖³ is weaker, so the demand of the criterion over all of Ω₀ ∩ slice is still exactly θ₀(n). The normalisation is free, since the boundary form is homogeneous. **CONFIRMED**, as a necessary condition for invariance of Ω₀ restricted to the slice. It asserts neither the bound nor its sharpness, and it says nothing about R_ric₀ ≠ 0.

## 6. Claims 6, 6b: the Lean file (Passage F)

The file on disk is identical to the brief's quotation (compared line by line against the brief). It contains no `sorry` tactic: the one occurrence of the word is in the prose "there is no `sorry`". I did not build it.

| Theorem | Binders and hypotheses | Typed conclusion | Faithful to its docstring? |
|---|---|---|---|
| boundary_equation | n : ℝ, 3 ≤ n | (n-2)/n = boundaryC n ^ 2 * (n(n-1)/2) ∧ 0 < boundaryC n | Yes. The equation is ((n-2)/n)‖W‖² = c²‖I‖² at ‖W‖ = 1, ‖I‖² = N, in the right direction, and positivity with the fixed c² determines the positive root |
| collapse_constant | n : ℝ, 3 ≤ n | boundaryC n * (n-1) = theta0 n | Yes, section 3's identity |
| criterion_forms_agree | n : ℝ, 3 ≤ n, W : Matrix ι ι ℝ → Matrix ι ι ℝ, normSq W = 1, norm W = 1 | (Pcubic W ≤ boundaryC n * (n-1) * normSq W) ↔ (Pcubic W ≤ theta0 n * norm W ^ 3) | Yes as algebra. Both inequalities are ≤ in the same direction, and Pcubic = ⟨W, W² + W#⟩ is ⟨W,Q(W)⟩ (Pcubic_eq_inner_Qop in WeylReal.lean). Three observations, none a defect: W carries no IsWeyl or linearity hypothesis, so the equivalence is a rewriting valid for any W. The real n is not tied to Fintype.card ι, so θ₀(n) is not bound to W's dimension. The hypothesis norm W = 1 is implied by normSq W = 1 (norm = √normSq). The theorem types the ∂Ω₀, ‖W‖ = 1 case, which is exactly where the two forms agree (section 2.4) |
| lower_nappe_is_different | n : ℝ, 3 ≤ n | −θ₀(n) < 0 ∧ 0 < θ₀(n) | Yes as typed. It does not type "load-bearing", only the sign of the two constants, which is what its docstring says |
| theta0_four | none | theta0 4 = √12/4 | Yes: √(2·3·2)/4 = √12/4 = √3/2 |

The file's "What is NOT typed" account is right that the collapse is absent and that nothing asserts the bound. **Claim 6: CONFIRMED AS ALGEBRA.**

**Candidate 6b ("RealLayer has Pcubic and normSq but no Φ, no I, and no decomposition").**

1. Location: [L43Statement.lean](../lean/HamiltonsCubic/Results/L43Statement.lean), module docstring, "What is NOT typed here".
2. [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) lines 188–190 define `Qop R = compOp R + sharpOp R`, docstring "Hamilton's map Q(R) = R² + R#", together with `Ric` and `IsWeyl`. So Φ(R) for a single operator R is in the layer.
3. Charitable reading: "no Φ" means no polarised Φ(A,B) and no identity operator I, which the collapse needs, and WeylReal's own docstrings leave open whether sharpOp is R# for non-linear inputs. That is true, but it is not what "no Φ" says. **REFUTED AS STATED**, minor. The decision to leave the collapse untyped stands.

## 7. Claim 7: range edges

- **n = 3.** W = 0 in dimension 3, the slice is {cI}, F(cI) = N/ρ = 2/(n-1) = 1 < 4 = 4/(n-2), so the slice lies in int Ω₀ and ∂Ω₀ ∩ slice ∩ C is empty. The collapse reads 0 ≤ 0. Vacuous, not false. θ₀(3) = 2/3. Lean's 3 ≤ n admits it harmlessly.
- **n = 4.** θ₀(4) = √3/2, c_∂(4) = 1/(2√3), and the witness of section 2.4 lives here. Lemma 2.1's kernel is proved directly at n = 4.
- **Odd n.** No step of sections 2 to 5 uses the parity of n. The odd-n sharpness values in Passage D are outside the statement. As algebra, 2(n-1)(n-3)/((n-2)(n+1)) < 2(n-1)(n-2)/n² ⟺ (n-3)n² < (n-2)²(n+1) ⟺ n³ − 3n² < n³ − 3n² + 4, true for all n > 3. The quoted values at n = 11, 13, 15 evaluate to 160/108 = 40/27, 240/154 = 120/77 and 336/208 = 21/13.
- **n = 6 + 2√7.** θ₀(n) < √(3/2) ⟺ 4(n-1)(n-2) < 3n² ⟺ n² − 12n + 8 < 0 ⟺ 6 − 2√7 < n < 6 + 2√7. Since 25 < 28 < 36, 11 < 6 + 2√7 < 12, so among integers n ≥ 4 this is 4 ≤ n ≤ 11 and equality never occurs. This is L44 content quoted in D, and it checks.
- **c ≤ 0.** c = 0: F undefined (W-2). c < 0: outside C, the collapse holds as algebra, and it is the lower nappe (section 3).
- **W = 0.** R = cI with c > 0 is interior (F = 2/(n-1) < 4/(n-2) for n ≥ 3). Both forms read 0 ≤ 0, and no boundary point has W = 0 except the apex, which is outside C.
- **ker W ≠ 0 (zero-padded).** A padded Weyl tensor lies in W at the ambient n (the embedding BW08's own proof of Lemma 2.1 uses), so W#I_n = −W with the ambient I_n. Eq. (6) and the scalar identity need only Ric(W) = 0. ‖I‖² = N is ambient. No step sees the kernel. The operator cI + W with padded W is on ∂Ω₀ at c = c_∂(n)‖W‖, and W itself (c = 0) is not, as Passage D says.

**CONFIRMED.**

## 8. Claim 8: the "Three verifiers" sentence

1. Location: [problem.md](../findings/problem.md) line 65: "... *at n = 12, R = −c₀I + W_{S⁶×S⁶} sits on its boundary.* **Three verifiers, [ROUND_L43-arg](../verification/ROUND_L00r2.md)**, so the bound demanded is $$c(n-1) = ... = θ₀(n).$$"
2. "Three verifiers, ROUND_L43-arg, so the bound demanded is" has no verb in its first part: a provenance tag is spliced between an italic aside and the "so" clause that continues the derivation. The link text names a round "L43-arg", and the target is ROUND_L00r2.md. A directory listing of verification/ shows no file named ROUND_L43-arg. Under the independence rule I did not open ROUND_L00r2.md, so whether it contains an L43 argument round is unchecked.
3. Charitable reading: a bold provenance label ("three verifiers checked this, see that round") is house style, and the target may hold the round under an internal label. Even so, the sentence does not parse, and the text names a file other than the one linked. **REFUTED AS STATED.**

## 9. Standing item 7: the falsifying object, and the search

- **For the collapse:** a Weyl W and c > 0 with G(cI+W) ≤ 0 and ⟨W,Q(W)⟩ > c(n-1)‖W‖², or the reverse. Section 2.2 derives G(cI+W) = 2(p − c(n-1)w²)/(c²ρ) as an identity, so no such object exists. I searched by reading every link against its source and its convention.
- **For the constant:** a point of ∂Ω₀ ∩ C ∩ slice with c(n-1) ≠ θ₀(n)‖W‖. Section 3's root computation excludes it.
- **For "demands":** an invariant Ω₀ with G > 0 at a boundary point. Beitz's one-level proof of clause 1 excludes it.
- **For the canonical wording (B, C):** a point of Ω₀, or of ∂Ω₀ at ‖W‖ ≠ 1, where c(n-1) ≠ θ₀(n). Exhibited in closed form at n = 4 (section 2.4): W⁺ = diag(2,−1,−1)/√6, W⁻ = 0, with R = (1/√3)I + W (interior) and R' = (1/√3)I + 2W (boundary).

## Overall verdict

**PROVEN (hypotheses corrected).** The collapse is an exact identity on the slice, the boundary constant is θ₀(n), and every import checks at source, including the convention bridge through Beitz (6.29). Three conditions must be written where the record omits or misstates them:

- Passages B and C: "on ∂Ω₀ at ‖W‖ = 1" for c(n-1) = θ₀(n).
- Passage D line 70: invariance ⇒ G ≤ 0 comes from Lemma 2.3.4's first clause, read one level at a time through its proof, and not from the scalar identity.
- Passage E: "whose hypotheses check" holds for that one-level form.

Wording defects, no mathematical consequence: the Lean file's "no Φ", C's "three endpoints", and the ROUND_L43-arg sentence and link.

*Other sessions' files in the working tree, left alone and not part of this commit:* lean/HamiltonsCubic/Results/L49Statement.lean, lean/INDEX.md, plan-lean.md (staged during this round, then committed elsewhere), .claude/skill-proposals.md (modified, unstaged at commit time). Quotations of the record (claim rows 4b and section 4b) keep the record's own punctuation.
