# Verifier v277, Lemma L3: the balanced product W* as a local maximum of P on the unit sphere of the Weyl space at even n at least 8, its transverse constant, and the n = 6 and n at least 12 remarks

Cold brief ([BRIEF_L03.md](BRIEF_L03.md)): no prior verdict was read. No numerical work was done, every value below is exact, and no script was written or run. Log: [agent_logs/verify-L03-v277.log](../agent_logs/verify-L03-v277.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | At W*, every even n at least 8: Riemannian Hessian is 6θ(L_e − ½Id) on W⊥, zero exactly on the orbit tangent, and L_e − ½ is negative definite on the orbit-normal part of W⊥ | CONFIRMED |
| C2 | θ = P(W*) > 0, the hypothesis of L24 that turns "L_e − ½ negative" into "Hessian negative" | HYPOTHESIS-DEBT |
| C3 | Hence W* is a local maximum on the unit sphere, strict transverse to the orbit (second-order sufficiency modulo the orbit) | GAP |
| C4a | Transverse Hessian ≤ −6θ/(n−2) follows from the ten values of L27 at p = q = n/2 | CONFIRMED AS ALGEBRA |
| C4b | The constant is derived in the proof on file | HYPOTHESIS-DEBT |
| C5 | "Not merely within D_n": the Hessian statement covers every direction of W⊥ in the full Weyl space | CONFIRMED |
| C6 | n = 6 is false: nine Hessian null directions transverse to the orbit carry P upward at cubic order | HYPOTHESIS-DEBT |
| C7 | "n at least 12 is about which of two local maxima wins globally" | HYPOTHESIS-DEBT |
| C8a | Schur mechanism derives L3 (via L27's multiplicity-free decomposition) | CONFIRMED |
| C8b | The same mechanism derives the analogous statement at the CP²-type competitor | HYPOTHESIS-DEBT |
| C9 | Lean file: types the scope arithmetic (n = 6 is L27's exclusion, p, q ≥ 4 lies in L27's scope) and the x³ example, with L3 itself unstated | CONFIRMED AS ALGEBRA |

**Summary.** The spectral content of L3 is right and the constant −6θ/(n−2) is exactly right (sharp, with a tie at n = 8), but the proof stops at the Hessian, never writes the step from a transverse-definite Hessian to a local maximum, never derives its own constant, and never establishes θ(W*) > 0, on which the direction of the whole conclusion depends.

## 0. Conventions, fixed once

- 𝒲_n = Weyl_n with the Frobenius inner product, Q(W) = W² + W^#, P(W) = ⟨W, Q(W)⟩, X∘Y = ½(Q(X+Y) − Q(X) − Q(Y)). A critical point on the unit sphere S satisfies Q(W) = θW, θ = P(W).
- e = W/θ, L_e = e∘(·). T_W S = W⊥ (orthogonal complement of W in 𝒲_n).
- m = n/2, W* = W_{m,m}, the unit Weyl tensor of S^m × S^m, n even.
- 𝒪 = O(n)·W*, the orbit, T𝒪 ⊂ W⊥ its tangent at W* (inside W⊥ because O(n) acts orthogonally, so the orbit lies in S).
- N = the orthogonal complement of T𝒪 inside W⊥: "transverse to the orbit" is read as "in N".
- "Local maximum" is read as: there is a neighbourhood U of W* in S with P ≤ θ on U. "Strictly so transverse to its orbit" is read as: P < θ on U \ 𝒪. "Transverse Hessian ≤ c" is read as: Hess(X, X) ≤ c|X|² for all X ∈ N.
- The neighbourhood U may depend on n. No uniformity in n is stated, and none is checked.
- Givens: L24 and L27 as quoted in Passages C and D, taken as stated. Only their hypotheses at W* and the match of their use are checked.

## 1. Hypothesis inventory

Quotation check: Passages A, B, C, D match the cited source lines verbatim ([second-order.md](../findings/second-order.md) lines 31-35, 41, 49, 57-59, 63, 65; [results.md](../results.md) lines 114, 154, 320, 404; [nondegeneracy.md](../findings/nondegeneracy.md) lines 496-498, 511-518). Only those lines were displayed.

| Source | Hypothesis | Holds at W*? | Used by the proof? | Satisfiable? |
|---|---|---|---|---|
| L3 statement | n even | yes, by fiat | yes, defines W* | yes |
| L3 statement | n ≥ 8 | yes, by fiat | yes, gives m ≥ 4 | yes |
| L24 (Passage C, statement) | W critical | presupposed by L27's statement (e is defined at W_{p,q} and the orbit is a critical manifold), and not argued in Passage A | yes | yes |
| L24 (Passage C, statement) | θ = P(W) > 0 | **not established in Passages A to D** (Section 3) | yes: the sign of the Hessian is the sign of θ times that of L_e − ½ | yes for one of ±W* (Section 3) |
| L24 (results.md line 320) | θ ≠ 0 | presupposed by L27 (e defined) | the formula needs only this | yes |
| L24, inequality part | W a local maximiser | not applicable | **not used** (the proof uses only the Hessian formula, so no circularity) | n/a |
| L27 | p, q ≥ 3 | p = q = m ≥ 4 | yes | yes |
| L27 | (p, q) ≠ (3, 3) | m ≥ 4 | yes | yes |
| L27 | n = p + q (no padding) | m + m = n | yes, silently (Passage A does not mention it) | yes |
| Unstated, used | θ(W*) > 0 | not on file in the passages | yes | yes for one sign |
| Unstated, used | a Hessian negative definite on N and zero on T𝒪, at a point whose orbit is a compact critical submanifold, gives a local maximum strict off the orbit (Morse–Bott sufficiency) | a true standard theorem, neither stated nor cited | yes: it is the only route from the last line of the proof to the statement | yes |
| Unstated, used for the constant | the full list of ten L_e values (from L27's proof, Passage D lines 511-518), beyond L27's statement, which gives only λ_max and where it is attained | given in the brief | yes for C4 only | yes |

## 2. C1, the Hessian at W* (CONFIRMED)

Derivation, link by link.

1. L24 at W* (hypotheses: critical, θ ≠ 0, both presupposed by L27's statement at W_{m,m}) gives Hess_S P = 6θ(L_e − ½Id) on W⊥, with L_e self-adjoint and W⊥ invariant.
2. L27 at (p, q) = (m, m), m ≥ 4: p, q ≥ 3, (m, m) ≠ (3, 3), n = p + q, all hold. Conclusion: λ_max(L_e|W⊥) = ½, attained exactly on T𝒪, dim E(½) = pq = m² = dim 𝒪.
3. E(½) ∩ W⊥ = T𝒪 is L_e-invariant, so N is L_e-invariant, and L_e|N is self-adjoint with every eigenvalue < ½ (finite dimension, λ_max over W⊥ attained only on T𝒪).
4. Hence 6(L_e − ½)|T𝒪 = 0 and (L_e − ½)|N is negative definite.

Passage A's instantiation "at p = q = n/2 ≥ 4" is correct. The step "negative definite transverse to the orbit" silently multiplies by θ and needs θ > 0: that is C2.

## 3. C2, θ(W*) > 0 (HYPOTHESIS-DEBT)

**Located.** Passage A: "Lemma L24 gives Hess_S P = 6θ(L_e − ½Id) ... so at p = q = n/2 ≥ 4 the Hessian is negative definite transverse to the orbit". L24's statement (Passage C line 57) is conditioned on "a critical point with θ = P(W) > 0". No passage verifies θ > 0 at W*. L27's statement fixes λ_max of L_e, which is blind to the sign of θ.

**Exhibited.** The sign is load-bearing, shown exactly. P is a cubic form and Q is quadratic, so P(−W) = −P(W) and Q(−W) = Q(W) = θW = (−θ)(−W). So −W* is critical with θ' = −θ, and e' = (−W*)/(−θ) = e: the same L_e, the same ten values. The Hessian at −W* is 6(−θ)(L_e − ½), the negative of the one at W*. Also −W* is outside 𝒪 in general, since −Id ∈ O(n) acts trivially on 4-tensors. So whichever of ±W* has P < 0 is a transverse local **minimum**, and every sentence of L3 is true for exactly one of the two. The lemma's W* is "the normalised Weyl tensor of that product", a sign fixed by geometry, and the passages never say which sign has P > 0.

**Charitable reading.** Passage A's opening line refers to "the known diagonal-case proof", which presumably shows W* to be a local maximum within D_n. With θ ≠ 0 and L_e having values below ½ on some D_n directions, that would force θ > 0. That proof is not quoted, so it cannot be checked here. The charitable reading makes the debt dischargeable, and it does not discharge it.

**Finding.** HYPOTHESIS-DEBT. What would have to be proved: P(W*) > 0 for the W* the lemma names. Alternatively, as a correction of hypotheses: W* is defined as the one of ±W_{m,m} with P > 0, which exists because P(W_{m,m}) ≠ 0 (e is defined in L27).

## 4. C3, from the Hessian to a local maximum (GAP)

**Located.** Passage A's proof ends "so at p = q = n/2 ≥ 4 the Hessian is negative definite transverse to the orbit and zero along it. □". The statement claims "a local maximum of P on the unit sphere of 𝒲_n ... and strictly so transverse to its O(n)-orbit". No sentence goes from the first to the second. Passage B says only "by Lemmas L24 and L27".

**Exhibited.** A Hessian condition at a single point is a pointwise second-order fact. The step to a neighbourhood statement needs a sufficiency theorem. The failure mode this guards against is the one the Lean file itself records: x³ at 0, where second-order information alone decides nothing. Here the Hessian has a kernel (T𝒪, dimension m²), so the elementary "negative definite Hessian gives strict local max" does not apply as stated. The version that applies is the Morse–Bott form: 𝒪 is a compact submanifold of critical points (P is O(n)-invariant and W* is critical), the kernel of the Hessian equals T𝒪 (L27: dim E(½) = pq = dim 𝒪), and the normal Hessian is negative definite (C1 plus C2). That theorem is standard and gives exactly "local maximum, strict off 𝒪". It is neither stated nor cited.

**Charitable reading.** L27's conclusion is literally "S^p × S^q is Morse–Bott nondegenerate", and a reader who knows the Morse–Bott lemma supplies the last line automatically. This makes the gap small and closable by one citation. It does not make the step written, and the brief's rule is that the missing argument is reported, not supplied.

**Finding.** GAP. What closes it: state the Morse–Bott sufficiency (nondegenerate critical submanifold with negative definite normal Hessian is a local maximum set, strict off the submanifold) with a citation or a proof, and note its three hypotheses at 𝒪 (compact critical submanifold; kernel = T𝒪; normal Hessian negative definite, which needs C2).

## 5. C4, the constant −6θ/(n−2)

### 5.1 C4a, the algebra (CONFIRMED AS ALGEBRA)

The ten values of Passage D at p = q = m, restricted to N (that is, removing ⟨W⟩ with value 1 and T𝒪 = ℝ^p ⊗ ℝ^q with value ½):

- λ_m = (m−2)/(2(m−1)) on S²₀(ℝ^m), on each of the two such summands.
- +μ on Λ² ⊗ Λ².
- −μ on S²₀ ⊗ S²₀.
- 0 on the remaining four.

From ½ − μ = ((p−2)(q−2) − 1)/(2(p−1)(q−1)) at p = q = m:

½ − μ = ((m−2)² − 1)/(2(m−1)²) = (m−3)(m−1)/(2(m−1)²) = (m−3)/(2(m−1)), so μ = 1/(m−1) > 0.

Gaps below ½:

- ½ − λ_m = ((m−1) − (m−2))/(2(m−1)) = 1/(2(m−1)).
- ½ − μ = (m−3)/(2(m−1)).
- ½ − (−μ) = ½ + 1/(m−1).
- ½ − 0 = ½.

Compare the two smallest candidates: (m−3) − 1 = m − 4 ≥ 0 for m ≥ 4, with equality exactly at m = 4. Also 1/(2(m−1)) ≤ ½ for m ≥ 2. So the smallest gap on N is 1/(2(m−1)) = 1/(n−2), and

Hess(X, X) = 6θ⟨(L_e − ½)X, X⟩ ≤ 6θ · (−1/(n−2)) |X|² = −6θ/(n−2) |X|² for X ∈ N, when θ > 0.

The bound is sharp: equality holds on S²₀(ℝ^m) ⊗ (trivial) and its mirror, which are nonzero (dimension m(m+1)/2 − 1 ≥ 9). **Tie at n = 8** (m = 4): λ_4 = 2/6 = ⅓ and μ = 1/3, both giving 6θ(⅓ − ½) = −θ = −6θ/6. The tie changes the multiplicity of the top transverse eigenvalue and leaves the bound unchanged. For m ≥ 5 the S²₀ summands alone attain it.

The constant uses the full ten-value list from L27's proof. L27's statement supplies only λ_max = ½ and where it is attained, which gives "negative definite" but no number.

### 5.2 C4b, whether it is written (HYPOTHESIS-DEBT)

**Located.** Passage A line 33: "with transverse Hessian ≤ −6θ/(n−2)". The proof (line 35) derives only "negative definite". Passage B drops the constant from both results.md versions.

**Exhibited.** No line of Passage A computes a second eigenvalue, compares μ with λ_m, or mentions the n = 8 tie.

**Charitable reading.** The constant is three lines of algebra from a quoted given (5.1), and it is correct. The statement still asserts a number the proof on file does not produce.

**Finding.** HYPOTHESIS-DEBT on the record as written. What would have to be written: the comparison of 5.1 (the transverse maximum is λ_m = (m−2)/(2(m−1)), since μ = 1/(m−1) ≤ λ_m iff m ≥ 4, equal at m = 4), plus θ > 0.

## 6. C5, "not merely within D_n" (CONFIRMED)

L24 is stated on the unit sphere of Weyl_n and L27's decomposition is of the full space (its over-counting remarks at q ≤ 2 are dimension counts against Weyl_n). So C1 covers all of W⊥ ⊂ 𝒲_n, and the proof sees every direction that leaves D_n. The claim is confirmed at the level of the Hessian. Its upgrade to a local maximum inherits C2 and C3.

## 7. C6, n = 6 (HYPOTHESIS-DEBT)

**Located.** Passage B line 114: "At n = 6 the statement is false, that is L27's excluded (3,3), where nine Hessian null directions transverse to the orbit carry P upward at cubic order". Line 404: "At n = 6 it is false".

**What the passages do give.** L27's statement at (3,3): μ = ½, dim E(½) = 18 against an orbit of 9. So at (3,3), with m = 3, Λ² ⊗ Λ² (dimension 3·3 = 9) joins the ½-eigenspace, and there are nine transverse Hessian null directions. That part stands on the given.

**Exhibited gap.** A null Hessian direction proves nothing about maximality in either direction: this is exactly the Lean file's x³ point. "False" requires a curve in S through W* along which P > θ. The passages contain no computation of the cubic term on Λ² ⊗ Λ², no curve, and no value.

**Charitable reading.** The claim is plausible, and the record may hold the computation elsewhere. Within the brief it is asserted without an argument.

**Does L3 use it?** No. L3's statement starts at n = 8 and its proof never refers to n = 6. The n = 6 sentence is a boundary remark, and its debt does not propagate into L3.

**Finding.** HYPOTHESIS-DEBT. What would have to be proved: a unit X ∈ Λ²(ℝ³) ⊗ Λ²(ℝ³) ⊂ N at W_{3,3} with T(X, X, X) = ⟨X∘X, X⟩ ≠ 0, together with the reduction that at a critical point with a transverse Hessian kernel, a nonzero cubic term on that kernel gives P > θ along ±X.

## 8. C7, "n ≥ 12 is about which of two local maxima wins globally" (HYPOTHESIS-DEBT)

**Located.** Passage A line 41 and Passage B line 404.

**Exhibited.** The sentence names a second local maximum at n ≥ 12 (by Passage B line 114, presumably the CP²-type competitor). No passage defines it, shows it is critical, or shows it is a local maximum. The half "not about W* losing local maximality" is what L3 gives for even n ≥ 12, subject to C2 and C3.

**Charitable reading.** It is a signpost to other results, and L3's proof does not use it. The parity is unstated ("n ≥ 12" where W* exists only at even n). The charitable reading "even n ≥ 12" is plainly intended, so that point is withdrawn in 13.

**Finding.** HYPOTHESIS-DEBT for the existence of a second local maximum at n ≥ 12, which is outside L3. There is no bearing on L3's verdict.

## 9. C8, the Schur remark

**C8a (CONFIRMED).** L27's statement: "Each of the ten summands is O(p)×O(q)-irreducible and their Young labels are distinct, so the decomposition is multiplicity-free and L_e is scalar on each". That is Schur's lemma applied to the O(p)×O(q)-equivariant L_e, and it is how C1 obtains "attained exactly on the orbit tangent". The remark correctly describes the mechanism behind L3.

**C8b (HYPOTHESIS-DEBT).** "The analogous statement at the CP²-type competitor": no passage states it or argues it, and Schur's lemma supplies only scalarity, never the values that decide the sign. Outside L3, no bearing on its verdict.

## 10. C9, the Lean file (CONFIRMED AS ALGEBRA)

[L3.lean](../lean/HamiltonsCubic/Results/L3.lean), read in full, with [L126.lean](../lean/HamiltonsCubic/Results/L126.lean) lines 62 and 65 for the two scope definitions (L27scope p q := 3 ≤ p ∧ 3 ≤ q ∧ ¬(p = 3 ∧ q = 3); L126scope p q := p = 2 ∨ q = 2 ∨ (p = 3 ∧ q = 3)).

| Theorem | Proves | Correct? |
|---|---|---|
| three_three_excluded | ¬ L27scope 3 3 | yes |
| three_three_in_L126 | L126scope 3 3 | yes |
| even_eight_in_scope | 4 ≤ p → 4 ≤ q → L27scope p q | yes. The bridge from "even n ≥ 8, p = q = n/2" to 4 ≤ p, q is left to the reader (trivial) |
| cubic_not_max | 0 < ε → 0 < ε³ over ℚ | yes |
| semidefinite_insufficient | ∃ f : ℚ → ℚ, f 0 = 0 ∧ ∀ ε > 0, f 0 < f ε | yes. It says nothing about derivatives, so "semidefinite" appears only in the docstring |

**Does it state or prove L3?** No. No Weyl tensor, no P, no Hessian, no sphere, no orbit, no local maximum, no constant. It formalises the integer scope bookkeeping and the one-variable example behind the necessary/sufficient distinction. The verdict applies to what it types.

## 11. Standing item 2, quantifier order and scope

- **Which n:** even n ≥ 8, each n separately. No uniformity of the neighbourhood in n is claimed.
- **Neighbourhood:** a neighbourhood of W* in S, equivalently of 𝒪 by invariance.
- **Strict or non-strict:** P ≤ θ near W*, with strict inequality off 𝒪. The constant is non-strict and attained (5.1).
- **Transverse to what:** to T𝒪 inside T_{W*}S = W⊥, with the complement taken in the full 𝒲_n.
- **No finding** beyond C2 and C3. Passage A's quantifiers match L27's "for every p, q ≥ 3, (p, q) ≠ (3, 3)" instantiated at p = q.

## 12. Standing item 3, edges, and item 7, falsifiers sought

| Edge / claim | Result | Falsifying object and what was done |
|---|---|---|
| n = 8 | No finding. (4, 4) is inside L27's scope. ½ − μ = 3/18 = 1/6 > 0. Constant −θ, attained on S²₀ and on Λ² ⊗ Λ² (tie) | A transverse eigenvalue of L_e in (⅓, ½) at m = 4. The ten values contain none |
| n = 6 | Outside L3. C6 | See C6 |
| odd n | No finding. W* = S^{n/2} × S^{n/2} is undefined, and the statement restricts to even n | none needed |
| padded object near W* | Candidate withdrawn (13) | A tensor with nonzero kernel in every neighbourhood of W* |
| C1 | CONFIRMED | X ∈ N with ⟨L_e X, X⟩ ≥ ½|X|². Excluded by L27 at (m, m), whose hypotheses were checked |
| C2 | HYPOTHESIS-DEBT | W* with P(W*) < 0. The exact sign flip W → −W shows such an object is a transverse local minimum with identical L_e. The sign of P(W*) is not available from the passages without supplying the curvature computation, which was not done |
| C3 | GAP | A curve in S through W* with P > θ. By the Morse–Bott theorem, none exists under C1 and C2. No x³-type object is available because the transverse kernel is zero (L27) |
| C4 | CONFIRMED AS ALGEBRA / HYPOTHESIS-DEBT | A transverse value in ((m−2)/(2(m−1)), ½). The list was checked exhaustively in 5.1 |
| C6, C7, C8b | HYPOTHESIS-DEBT | Named in their sections. No closed-form object is on file either way |

## 13. Withdrawn candidates

Each is recorded as located / exhibited / charitable reading / reason withdrawn.

1. **Circularity through L24's local-maximiser hypothesis.**
   - Located: L24's "Hence if W is a local maximiser".
   - Exhibited: using that conclusion to prove maximality would be circular.
   - Charitable reading: Passage A invokes only L24's Hessian formula, which assumes criticality and θ ≠ 0.
   - Withdrawn: no circularity.
2. **Two versions of L24 (θ > 0 at second-order.md line 57, θ ≠ 0 at results.md line 320).**
   - Located: both lines.
   - Exhibited: the hypotheses differ.
   - Charitable reading: the Hessian formula holds for θ ≠ 0, and the sign enters only when the conclusion is read.
   - Withdrawn as an L24 inconsistency. The sign issue is kept as C2.
3. **The n = 8 tie breaks the constant.**
   - Located: Passage A line 33.
   - Exhibited: λ_4 = μ = ⅓.
   - Charitable reading: equal gaps give the same bound.
   - Withdrawn (5.1).
4. **Orbit dimension or tangent mismatch.**
   - Located: "zero along it".
   - Exhibited: if the stabiliser were larger than O(p)×O(q), then dim 𝒪 < pq and E(½) ⊋ T𝒪.
   - Charitable reading: L27, a given, states dim E(½) = pq = dim(orbit) and "attained exactly on the orbit tangent".
   - Withdrawn: the kernel equals T𝒪 by the given.
5. **Padded object near W*.**
   - Located: brief attack item 10.
   - Exhibited: L27 requires n = p + q, and padded W_{p,q} (p + q < n) are degenerate.
   - Charitable reading: the set {W : ι_v W = 0 for some unit v} is closed (compactness of the unit sphere in ℝ^n). W* = W_{m,m} with 2m = n is the no-padding case of L27's own hypothesis, so a neighbourhood of W* in S avoids that set. Also, by the Morse–Bott property, 𝒪 is isolated among critical points.
   - Withdrawn: no padded object lies in every neighbourhood of W*.
6. **Lean docstring, "No sharpening of a necessary condition reaches a sufficient one" ([L3.lean line 19](../lean/HamiltonsCubic/Results/L3.lean#L19) and [line 53](../lean/HamiltonsCubic/Results/L3.lean#L53)).**
   - Exhibited: read literally, this contradicts L3's own mechanism, since definiteness on N is a sharpening of semidefiniteness and is sufficient (Morse–Bott).
   - Charitable reading: "it" is the n = 6 diagonalisation, which cannot be sharpened because the null directions exist there.
   - Withdrawn: the docstring is about n = 6.
7. **Lean docstring, "a Lemma everywhere else" ([line 8](../lean/HamiltonsCubic/Results/L3.lean#L8)).**
   - Exhibited: read literally, it covers n = 4 and odd n, which L3 does not state.
   - Charitable reading: it summarises the lemma's own range (even n, with n = 6 the only exception to "n ≥ 6"), and the Lean content claims nothing at other n.
   - Withdrawn.
8. **"n ≥ 12" without parity (Passage A line 41).**
   - Exhibited: W* does not exist at odd n.
   - Charitable reading: the context is even n.
   - Withdrawn.
9. **Motivation line speaks of "criticality", the lemma of maximality (Passage A line 33).**
   - Exhibited: criticality of W* in 𝒲_n is not argued in A.
   - Charitable reading: L27's statement presupposes criticality at W_{p,q} in the full space, and the line is motivation rather than a claim.
   - Withdrawn.

## 14. Gap between proven and stated (standing item 4)

- **Proven on the givens:** C1, the spectral statement (with θ ≠ 0), and C5.
- **Stated but not proven in Passage A:**
  - the local maximum and strict transversality: C3, the Morse–Bott step;
  - the direction of the Hessian: C2, θ > 0;
  - the constant: C4b.
- **Passage B:** repeats A without the constant ("by Lemmas L24 and L27") and adds three claims with no argument in the passages (C6, C7, C8b). None of them is used by L3's proof.

## Overall verdict: GAP

The mathematics checked is correct: the transverse spectrum at W* on the givens, and the sharp constant −6θ/(n−2) with the n = 8 tie. The written proof is incomplete in three places:

- **The step to a neighbourhood statement:** from "Hessian negative definite transverse to the orbit, zero along it" to "local maximum, strict off the orbit" (the Morse–Bott sufficiency) is not written.
- **The sign of θ:** θ(W*) > 0 is a hypothesis of L24 never established at W*. It decides between local maximum and local minimum, as the exact sign flip W → −W shows.
- **The constant:** stated but not derived.

Nothing is refuted. The n = 6, n ≥ 12 and CP² remarks are HYPOTHESIS-DEBT outside the lemma.
