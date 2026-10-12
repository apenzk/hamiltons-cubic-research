# Verifier v279, Lemma L3: local maximality of the balanced product in Weyl_n at even n >= 8, its transverse constant, its n = 6 and n >= 12 remarks, and its Lean file

The brief ([BRIEF_L03.md](BRIEF_L03.md)) was cold: no prior verdict on this result was read. No numerical work was done, every value below is exact, and no script was written or run. Each quotation was checked against only its cited source lines (all verbatim). Log: [agent_logs/verify-L03-v279.log](../agent_logs/verify-L03-v279.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | L24 applies at W*: W* is a critical point with theta = P(W*) > 0 | HYPOTHESIS-DEBT |
| 2 | L27 applies at p = q = n/2 >= 4 and gives a Riemannian Hessian negative definite transverse to the O(n)-orbit and zero along it | CONFIRMED |
| 3 | That Hessian condition gives a local maximum of P on the unit sphere of W_n, strict transverse to the orbit | GAP |
| 4 | Transverse Hessian <= -6 theta/(n-2) | CONFIRMED AS ALGEBRA |
| 5 | "Not merely within D_n" | CONFIRMED |
| 6 | n = 6: the statement is false, nine transverse Hessian null directions carry P upward at cubic order | HYPOTHESIS-DEBT |
| 7 | "n >= 12 is about which of two local maxima wins globally" | HYPOTHESIS-DEBT |
| 8 | "The Schur mechanism that derives the analogous statement at the CP^2-type competitor is what derives this one" | HYPOTHESIS-DEBT |
| 9a | The Lean theorems of L3.lean, as integer and rational arithmetic | CONFIRMED AS ALGEBRA |
| 9b | L3.lean states or proves Lemma L3 | REFUTED |

**Summary.** The spectral half of L3 is sound and its constant follows exactly from L27's ten values, but the written proof stops at the Hessian (second-order sufficiency modulo the orbit is never invoked) and nothing on file gives P(W*) > 0, on which the direction of the conclusion depends.

## 0. Conventions, fixed once

- W_n = Weyl_n with the Frobenius inner product. Q(W) = W^2 + W^#, P(W) = <W, Q(W)>, X o Y = (Q(X+Y) - Q(X) - Q(Y))/2, T(X,Y,Z) = <X o Y, Z>.
- S denotes the unit sphere of W_n. A critical point satisfies Q(W) = theta W with theta = P(W). For theta != 0, e = W/theta and L_e = e o (.).
- m = n/2 and W* = W_{m,m}, the unit-norm Weyl tensor of S^m x S^m. "Orbit" means the O(n)-orbit O = O(n).W* in S, and V_orb = T_{W*}O, the orbit tangent inside W*^perp = T_{W*}S. "Transverse" means the orthogonal complement N of V_orb in W*^perp.
- The ten values of L27 (Passage D): 1 on <W>; 1/2 on R^p (x) R^q; lambda_k = (k-2)/(2(k-1)) on S^2_0(R^k) for k in {p, q}; +mu on Lambda^2 (x) Lambda^2; -mu on S^2_0 (x) S^2_0; 0 on the remaining four. L27 also gives 1/2 - mu = ((p-2)(q-2) - 1)/(2(p-1)(q-1)).
- Riemannian Hessian of P on S at a critical point (L24, Passage C): Hess = 6 theta (L_e - Id/2) on W^perp.

## Hypothesis inventory

| Source | Hypothesis | Used by L3? | Holds at W*? | Satisfiable? |
|---|---|---|---|---|
| L3 statement | n even, n >= 8 | yes, to put p = q = n/2 >= 4 | by assumption | yes |
| L24 | W critical, Q(W) = theta W | yes | carried by L27's given (its value 1 on <W> is Q(W) = theta W), not argued in Passage A | yes |
| L24 | theta = P(W) > 0 | yes, and load-bearing for the sign of the conclusion | **no argument on file** (Section 1) | yes: theta != 0 is presupposed by L27 (e = W/theta), so exactly one of +W*, -W* satisfies it |
| L24 | "local maximiser", for the bound lambda_max <= 1/2 | no: L3 uses only the Hessian formula, which is correct (using the bound would be circular) | not needed | n/a |
| L24 (via L125) | W^perp is L_e-invariant, L_e self-adjoint | yes, to split W^perp into V_orb and N | given | yes |
| L27 | p, q >= 3 | yes | p = q = m >= 4 | yes |
| L27 | (p,q) != (3,3) | yes | m >= 4 | yes |
| L27 | n = p + q (unpadded) | yes | 2m = n | yes |
| L27 conclusion | lambda_max(L_e on W^perp) = 1/2 attained exactly on V_orb, dim E(1/2) = pq = dim O | yes | given | n/a |
| Unstated | P is O(n)-invariant, so O consists of critical points with P = theta | yes, implicitly, for "zero along the orbit" to mean what sufficiency needs | yes (Definitions) | yes |
| Unstated | O is a compact embedded submanifold of S | yes, implicitly, in "transverse to its orbit" | yes (orbit of a compact group acting smoothly) | yes |
| Unstated | Second-order sufficiency modulo a critical orbit (Morse-Bott) | yes, it is the step from Hessian to local maximum | not cited or argued (Section 3) | its hypotheses all hold here |

## 1. L24 at W*: criticality and theta > 0

**What Passage A uses.** "Lemma L24 gives Hess_S P = 6 theta (L_e - Id/2) on the tangent space" (second-order.md line 41). L24 (Passage C, line 57) is stated for "a critical point with theta = P(W) > 0".

**Criticality.** Passage A does not argue that W* is critical in W_n. The given L27 does carry it: the value 1 on <W> means L_e W = Q(W)/theta = W, that is Q(W) = theta W, and L27's own proof differentiates "Q(W_t) = theta W_t along the orbit" (nondegeneracy.md line 512). Taking L27 as given, criticality with theta != 0 at W_{m,m} is available. The chain uses it without saying so, which is a presentation point and no finding.

**theta > 0.** Candidate finding, three-step record.

1. *Locate.* L24's hypothesis "theta = P(W) > 0" (second-order.md line 57). Passage A (line 41) and Passage B (results.md lines 114, 404) never establish P(W*) > 0, and neither does L27 (its statement and values are invariant under W -> -W: L_{-W/(-theta)} = L_{W/theta}). Line 33's "the known diagonal-case proof" is an unquoted, uncited source.
2. *Exhibit.* The sign decides the conclusion. Replace W* by -W*: it is critical with value -theta, L_e is unchanged, so Hess = 6(-theta)(L_e - Id/2) has the opposite sign on N. With the same L27 spectrum, whichever of +W*, -W* has negative P is a local minimum strict transverse to its orbit, and "transverse Hessian <= -6 theta/(n-2)" reads as a positive lower bound. The chain as written proves "the one of +W*, -W* with positive P is a local maximum" and cannot tell which one that is.
3. *Opposite reading.* The word "normalised" in the definition of W* could absorb a sign convention choosing P(W*) > 0. Under that reading the mathematics holds for the positive-P representative, but the identification with the geometric product S^{n/2} x S^{n/2} (the lemma's title and statement) is then an assertion about which sign that is, still with no argument on file. The candidate survives.

**Finding (HYPOTHESIS-DEBT).** What would have to be proved: P(W_{m,m}) > 0 for the Weyl tensor of the round product, with a citation or derivation placed in or before L3. Satisfiability is not in doubt (theta != 0 by L27), so the defect is at most a sign identification, never a failure of the local-maximum mechanism.

## 2. L27 at W*, and the Hessian's shape

**Hypotheses.** p = q = m = n/2. For even n >= 8, m >= 4, so p, q >= 3, (p,q) != (3,3), and n = p + q. All hold. Passage A's paraphrase of L27 omits "n = p + q", but applies it at p = q = n/2, where it holds.

**Derivation.** Take theta > 0 (Section 1). By L24/L125, L_e is self-adjoint on W*^perp. By L27, the eigenvalue 1/2 has eigenspace exactly V_orb, and every other eigenvalue on W*^perp is < 1/2 (this is what "lambda_max = 1/2 attained exactly on the orbit tangent" means for a self-adjoint operator). Self-adjointness makes N = V_orb^perp (inside W*^perp) invariant and spanned by eigenvectors with eigenvalues < 1/2. Hence Hess = 6 theta (L_e - Id/2) is 0 on V_orb and negative definite on N. The "orbit tangent" is the O(n)-orbit tangent, of dimension pq, which is the R^p (x) R^q summand (so(n) = so(p) + so(q) + R^p (x) R^q, the first two stabilising W*), consistent with dim E(1/2) = pq.

**Verdict: CONFIRMED**, conditional on theta > 0.

## 3. From the Hessian to a local maximum

**The written chain.** The proof (line 41) ends: "so at p = q = n/2 >= 4 the Hessian is negative definite transverse to the orbit and zero along it. [square]". The statement concludes "is a local maximum of P on the unit sphere ... and strictly so transverse to its O(n)-orbit". Passage B (line 114) attributes the conclusion to "Lemmas L24 and L27". L24 is a necessary condition. L27 is a spectrum. Neither states sufficiency.

Candidate finding, three-step record.

1. *Locate.* The step from the last clause of line 41 to "local maximum" in line 35 has no argument and no citation.
2. *Exhibit.* The bare implication "Hessian negative definite transverse to a curve and zero along it implies local maximum" is false in general. Take f(x, y) = -x^2 + y^3 on R^2 at the origin: the Hessian is diag(-2, 0), negative definite transverse to the y-axis and zero along it, yet f(0, eps) = eps^3 > 0 for every eps > 0. So the conclusion needs more than the Hessian: the null directions must be tangent to a submanifold of critical points on which P is constant, with the transverse definiteness uniform along it.
3. *Opposite reading.* Every extra hypothesis holds here. P is O(n)-invariant (Definitions), so O is a manifold of critical points with P = theta. O is a compact embedded submanifold. The null space of the Hessian is exactly T O (L27's "Morse-Bott nondegenerate"), and by equivariance the normal Hessian at g.W* is conjugate to that at W*, so its top eigenvalue is -6 theta/(n-2) uniformly. The Morse-Bott lemma then gives a neighbourhood U of W* in S with P(X) < theta for X in U outside O. So the conclusion is true and standard. The candidate survives as a gap in the written proof, because the charitable reading supplies a theorem that the proof neither cites nor argues, and the Lean file's own docstring (lines 16-19) singles out "reading a necessary condition as sufficient" as the error this lemma is prone to.

**Finding (GAP).** What would close it: a cited second-order sufficiency theorem modulo a critical orbit (the Morse-Bott lemma), with its three hypotheses checked at W* as in step 3. No new mathematics is needed. "Strict transverse to the orbit" is then read correctly as P(X) < P(W*) for X in a neighbourhood of W* in S minus O.

## 4. The constant -6 theta/(n-2)

The proof on file never computes it: line 41 says "negative definite" and stops. The algebra from L27's values at p = q = m, done exactly here:

- lambda_m: 1/2 - lambda_m = ((m-1) - (m-2))/(2(m-1)) = 1/(2(m-1)).
- +mu: 1/2 - mu = ((m-2)^2 - 1)/(2(m-1)^2) = (m-3)(m-1)/(2(m-1)^2) = (m-3)/(2(m-1)). So mu = 1/(m-1) > 0.
- -mu: 1/2 + mu = (m+1)/(2(m-1)).
- 0: 1/2 = (m-1)/(2(m-1)).

The transverse gaps 1/2 - lambda over N are therefore {1, m-3, m+1, m-1}/(2(m-1)). For m >= 4 the least numerator is 1, **tied with m - 3 exactly at m = 4 (n = 8)** and strictly smaller for m >= 5. The largest transverse Hessian eigenvalue is 6 theta (-1/(2(m-1))) = -3 theta/(m-1) = -6 theta/(n-2), attained on S^2_0(R^m) (nonempty, dimension m(m+1)/2 - 1), and at n = 8 also on Lambda^2 (x) Lambda^2. At n = 8 it equals -theta.

**Verdict: CONFIRMED AS ALGEBRA**, with theta > 0 from Section 1. The gap between stated and written is the computation itself, which is absent from Passage A.

## 5. "Not merely within D_n"

The Hessian of Section 2 acts on the whole of W*^perp = T_{W*}S in W_n, and L27's ten summands decompose all of Weyl_n (its own statement speaks of the ten dimensions counting Weyl_n, line 496). No restriction to D_n enters the argument, so directions leaving D_n are covered by the same spectral bound. **Verdict: CONFIRMED**, subject to Sections 1 and 3.

## 6. n = 6

Passage B (line 114): "At n = 6 the statement is false, that is L27's excluded (3,3), where nine Hessian null directions transverse to the orbit carry P upward at cubic order."

- *The count.* L27 (line 496): at (3,3), mu = 1/2, dim E(1/2) = 18 against an orbit of 9. So there are exactly 18 - 9 = 9 null directions in N, matching dim Lambda^2(R^3) (x) Lambda^2(R^3) = 9. The count is CONFIRMED AS ALGEBRA.
- *"Carry P upward at cubic order" and "false".* Candidate finding. (1) Locate: line 114 and line 404 ("At n = 6 it is false"). (2) Exhibit: a semidefinite Hessian with null directions outside the orbit is consistent with a local maximum (for example f(x, y) = -x^2 - y^4 at the origin, Hessian diag(-2, 0), a strict local maximum), so the nine null directions alone decide nothing, and no passage exhibits a curve along which P - theta has a positive cubic term. L27's exclusion is a statement that its spectral conclusion fails, which is weaker than the lemma failing. (3) Opposite reading: the phrase may summarise a computation elsewhere in the record, but none is quoted or cited in the brief. The candidate survives.
- **Finding (HYPOTHESIS-DEBT).** What would have to be proved: a curve in S through W_{3,3}, tangent to one of the nine transverse null directions, along which P - theta has a nonzero cubic term (then of positive sign in one of the two orientations). **L3 does not use this** for n >= 8. It is a separate stated claim of the canonical text.

## 7. "n >= 12 is about which of two local maxima wins globally"

1. *Locate.* second-order.md line 49 and results.md line 404, both introduced by "So", as consequences of L3.
2. *Exhibit.* L3 supplies one local maximum. The second local maximum (Passage B's "CP^2-type competitor", line 114) is neither defined nor proved in any passage, so the "So" draws a two-maximum conclusion from a one-maximum lemma. The sentence also drops evenness: for odd n >= 13, W* = S^{n/2} x S^{n/2} does not exist.
3. *Opposite reading.* The half "not about W* losing local maximality" does follow from L3 (with Sections 1 and 3) for even n >= 12, and the context of the sentence is even n, which dissolves the odd-n point (withdrawn, Section 11). The existence of the second local maximum at every even n >= 12 is not dissolved.

**Finding (HYPOTHESIS-DEBT).** What would have to be proved: that the CP^2-type competitor is a local maximum of P on S at every even n >= 12 (or a citation to the result that proves it). The remark is not used by L3's proof.

## 8. The Schur remark

"The Schur mechanism that derives the analogous statement at the CP^2-type competitor is what derives this one." The "this one" half is consistent with the chain: L27 (line 154) rests on a multiplicity-free decomposition on which L_e is scalar by Schur's lemma, and L3 inherits that through L27. The comparison half asserts that a result at an object not defined in the brief uses the same mechanism, and no passage states or argues the analogous result. **Finding (HYPOTHESIS-DEBT)**, unused by L3. What would have to be proved or cited: the analogous local-maximum statement at the CP^2-type competitor, derived through a multiplicity-free decomposition.

## 9. The Lean file

[L3.lean](../lean/HamiltonsCubic/Results/L3.lean), read in full, with L27scope and L126scope read from L126.lean lines 62 and 65: L27scope p q := 3 <= p and 3 <= q and not (p = 3 and q = 3), L126scope p q := p = 2 or q = 2 or (p = 3 and q = 3).

| Theorem | Type | Correct? |
|---|---|---|
| three_three_excluded | not L27scope 3 3 | yes |
| three_three_in_L126 | L126scope 3 3 | yes |
| even_eight_in_scope | for integers p, q with 4 <= p, 4 <= q, L27scope p q | yes |
| cubic_not_max | 0 < eps implies (0 : Q) < eps^3 | yes |
| semidefinite_insufficient | exists f : Q -> Q, f 0 = 0 and f 0 < f eps for all eps > 0 | yes |

- **9a, CONFIRMED AS ALGEBRA.** Each theorem is a true statement about integers or rationals, proved by unfolding, omega, positivity or norm_num.
- **9b, REFUTED.** No theorem mentions Weyl_n, Q, P, a Hessian, an orbit, or a local maximum. even_eight_in_scope does not mention n, evenness, or p = q = n/2. semidefinite_insufficient does not mention a second derivative (its f = x^3 illustrates the docstring, but the typed statement is only "some f increases from 0"). The file states and proves scope arithmetic and an illustration, and neither states nor proves Lemma L3.

## 10. Edges of every range

- **n = 8.** m = 4: in L27's scope ((4,4) != (3,3)), 1/2 - mu = 3/18 = 1/6 = 1/2 - lambda_4, the tie of Section 4. Constant -theta. No finding.
- **n = 6.** Excluded from the statement. Section 6.
- **n = 4, 2.** p = q <= 2, where L27 (line 496) says the decomposition itself is false. Excluded from the statement. No finding.
- **Odd n.** W* is undefined and the statement is restricted to even n. No finding for the statement (Section 7 for the n >= 12 sentence).
- **Kernel of W nonzero (padded objects).** A screen, from quoted facts only. The kernel of W* (vectors v with the contraction of W* by v zero) is invariant under the stabiliser, which contains O(m) x O(m), so it is 0, R^m (first factor), R^m (second factor), or R^n. R^n forces W* = 0, contradicting theta != 0. If it contained one factor, W* would be an O(m)-invariant Weyl tensor on the other R^m, hence 0, because Weyl carries no invariant vector under its full orthogonal group (Passage C, line 65, applied at dimension m). So W* has trivial kernel. The set of Weyl tensors with nonzero kernel is closed (the unit sphere of R^n is compact), so some neighbourhood of W* in S contains no padded object, and the local statement never meets L27's excluded padded case. No finding.

## 11. Withdrawn candidates

- **Odd n in "n >= 12 is about ...".** (1) Located at line 49 and line 404, no evenness in the sentence. (2) At odd n, W* does not exist. (3) Charitable reading: the sentence continues a lemma stated for even n, and "W* losing local maximality" only parses at even n. Withdrawn at step 3.
- **Lean docstring "a Lemma everywhere else" (L3.lean line 9).** (1) Located. (2) Read literally it covers n = 2, 4 and odd n. (3) Charitable reading: "everywhere else" within the lemma's stated range of even n. Withdrawn at step 3.
- **Lean docstring "No sharpening of a necessary condition reaches a sufficient one" (lines 19, 53-54).** (1) Located. (2) As general mathematics it is false: the necessary condition "Hessian <= 0" sharpened to "Hessian negative definite modulo a critical orbit" is sufficient, which is exactly how Section 3 closes at n >= 8. (3) Charitable reading: the surrounding text concerns the n = 6 diagonalisation, where the semidefinite condition is all there is and no refinement of that computation yields sufficiency. The text is prose, typed by no theorem. Withdrawn at step 3.
- **L24's use as a necessary bound would be circular.** (1) L24 is quoted as "Hence if W is a local maximiser, lambda_max <= 1/2". (2) Using it to conclude local maximality would assume the conclusion. (3) Passage A uses only the Hessian formula, which L24 states for every critical point with theta > 0. Withdrawn at step 2: no failure is exhibited.

## 12. Standing items, answered

1. **Hypothesis inventory.** The table above. Used but unstated: O(n)-invariance making O a critical manifold, O compact embedded, and Morse-Bott sufficiency (Section 3). Not established: theta > 0 (Section 1). All hypotheses are satisfiable.
2. **Quantifier order and scope.** For each even n >= 8, a neighbourhood U of W* in S (not in W_n, not in D_n) with P <= theta on U, strict on U minus O. "Transverse" is the orthogonal complement of V_orb inside W*^perp. The constant bound is non-strict and attained. No finding beyond Section 3.
3. **Edges.** Section 10. No finding.
4. **Proven versus stated or used.** Proven on file: the Hessian's shape (Section 2). Stated beyond it: local maximality (GAP, Section 3), the constant (unwritten, confirmed as algebra, Section 4), P(W*) > 0 (debt, Section 1), n = 6 falsity (debt, Section 6), a second local maximum at n >= 12 (debt, Section 7), the Schur comparison (debt, Section 8). Passages A and B agree with each other on the statement, except that B's detail line omits the constant and A's line 49 and B's line 404 carry the same unsupported "So".
5. **Lean.** Section 9: states neither the lemma nor its proof.
6. **Attack items, numbered as in the brief.**
   1. Sufficiency modulo the orbit: true by the Morse-Bott lemma, whose hypotheses hold, but the proof asserts it without argument or citation. GAP (Section 3).
   2. L24 at W*: criticality carried by L27's given, theta > 0 not established anywhere on file. HYPOTHESIS-DEBT (Section 1).
   3. L27 at W*: all hypotheses hold at p = q = n/2 >= 4, and "attained exactly on the orbit tangent" is used correctly to split W*^perp. CONFIRMED (Section 2).
   4. The constant: follows exactly, with the tie between S^2_0(R^m) and Lambda^2 (x) Lambda^2 at n = 8, and is not written in the proof. CONFIRMED AS ALGEBRA (Section 4).
   5. "Not merely within D_n": the argument is on all of W*^perp. CONFIRMED (Section 5).
   6. n = 6: the nine is exact, "upward at cubic order" and "false" have no argument on file, and L3 does not use them. HYPOTHESIS-DEBT (Section 6).
   7. n >= 12: the second local maximum has no argument on file. HYPOTHESIS-DEBT (Section 7).
   8. Schur remark: consistent for L3 via L27, the comparison is unsupported and unused. HYPOTHESIS-DEBT (Section 8).
   9. Lean: scope arithmetic and an x^3 illustration, all correct, none stating L3. Section 9.
   10. Boundary: n = 8 in scope with a tie, odd n outside, padded objects excluded from a neighbourhood of W*. No finding (Section 10).
7. **Falsifying objects and the search.**
   - Claims 2 and 4: an eigenvector of L_e in N with eigenvalue >= 1/2, or > 1/2 - 1/(2(m-1)). Searched by recomputing every gap from L27's ten values in closed form. None exists given L27.
   - Claim 3: a point of S arbitrarily near W*, off O, with P >= theta. Excluded by the Morse-Bott lemma once its hypotheses (checked in Section 3) hold. The model f = -x^2 + y^3 shows why the hypotheses are needed.
   - Claim 1: a proof that P(W_{m,m}) < 0 for the round product, which would turn L3 into a local-minimum statement. Searched the quoted passages for any sign argument. None on file in either direction.
   - Claim 6: an exhibited curve at W_{3,3} with positive cubic term, which would confirm, or a proof that the nine null directions are tangent to a larger critical manifold with constant P, which would refute. Neither is on file.
   - Claim 7: a local maximality proof at the CP^2-type competitor for even n >= 12, or a direction in which P increases there. Neither is on file.
   - Claim 9b: any theorem in L3.lean whose type involves Weyl tensors or P. Read the whole file. None exists.

## Overall verdict: HYPOTHESIS-DEBT

The mechanism is right: at every even n >= 8, L24 and L27 give a Hessian that is zero on the orbit and at most -6 theta/(n-2) transverse, and with the Morse-Bott lemma that makes W* a local maximum strict off its orbit. Two things on the page stop it from being PROVEN. First, the proof never makes the step from Hessian to local maximum (GAP, closable by citation). Second, P(W*) > 0, which fixes whether the conclusion is a maximum or a minimum, has no argument on file (HYPOTHESIS-DEBT). The canonical text's n = 6 falsity, its second local maximum at n >= 12 and its Schur comparison are further unsupported claims, and none is used by the lemma. L3.lean does not formalise the lemma.
