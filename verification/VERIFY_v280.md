# Verifier v280, L03 repair: the balanced product W* at even n >= 8 as a strict local maximum of P transverse to its orbit, the Hessian bound -6θ/(n-2) and its attainment, and the n = 6 and closing scope lines

The brief ([BRIEF_L03_repair.md](BRIEF_L03_repair.md)) was read cold. No numerical work was done, every value below is exact, and no scripts were written or run. Log: [agent_logs/verify-L03-v280.log](../agent_logs/verify-L03-v280.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Criticality of W* with θ = θ_{m,m} > 0 from Proposition 2.25, and the sign argument | CONFIRMED |
| 2 | The values of L_e on W*⊥ quoted from L27 at p = q = m, μ = 1/(m-1), λ_m - μ = (m-4)/(2(m-1)), Hess ≤ -6θ/(n-2) on N with equality on S²₀(ℝ^m) | CONFIRMED |
| 3 | From the Hessian to a neighbourhood U of O with P < θ on U \ O (tubular neighbourhood, Taylor, transport, ρ') | CONFIRMED |
| 4 | The statement (local maximum at W*, strict transverse to O, Hessian bound attained) is what the proof reaches | CONFIRMED |
| 5a | The n = 6 paragraph as a statement of scope | CONFIRMED |
| 5b | The closing line "So at n ≥ 12 the balanced product is a strict local maximum transverse to its orbit" as a statement of scope | REFUTED AS STATED |
| 6 | Boundary: n = 8, the tie at m = 4, the attaining normal directions, v = 0 | CONFIRMED |

Summary: the statement and its proof (lines 37-49) are correct link by link for every even n ≥ 8, and the only defect is the closing line 53, which gives the range as n ≥ 12 where the lemma proves even n ≥ 8.

## 0. Conventions, fixed once

- Σ is the unit sphere of 𝒲_n with the Frobenius inner product, T(X,Y,Z) = ⟨X∘Y, Z⟩ is the symmetric trilinear form with P(W) = T(W,W,W) and X∘X = Q(X).
- m = n/2, θ = P(W*), e = W*/θ, L_e = e∘(·). O is the O(n)-orbit of W*, N is the orthogonal complement of T_{W*}O in T_{W*}Σ = W*⊥.
- "Hess ≤ c on N" is read as Hess(v,v) ≤ c|v|² for all v ∈ N.
- c := 3θ/(n-2) = 3θ/(2(m-1)), so the Hessian bound is -2c and the Taylor coefficient is -c.
- The quotation of Passage A was checked against [findings/second-order.md](../findings/second-order.md) lines 37-53 only, Passage C against [findings/nondegeneracy.md](../findings/nondegeneracy.md) lines 496-498 and 511-518 and [results.md](../results.md) line 154, Passage D against [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) lines 19-23. All match the brief verbatim.

## 1. Hypothesis inventory

| Source | Hypothesis | Where the proof meets it | Holds? |
|---|---|---|---|
| Statement | n even, n ≥ 8 | m = n/2 is an integer ≥ 4, needed for L27 at p = q = m | Yes |
| Statement | W* unit, the Weyl tensor of S^{n/2}×S^{n/2}, P(W*) > 0 | selects the sign, θ > 0 | Yes, by Prop. 2.25 (θ_{m,m} > 0) |
| Prop. 2.25 | the object is W_{S_{k,l}} with n = k + l | applied at k = l = m | Yes, under the identification below |
| Prop. 2.25 | output Q(W) = θW and P(W) = θ | these give θ|W|² = P(W) = θ, so |W| = 1 since θ ≠ 0, and ∇P = 3Q(W) = 3θW is normal to Σ, so W is critical on Σ | Yes |
| L24 | W critical, θ = P(W) > 0 | at W*, θ = θ_{m,m} > 0 | Yes |
| L24 | only the Hessian formula is used, the "Hence" clause (which needs a local maximiser) is not used | "the Riemannian Hessian at W* is 6θ(L_e - ½Id)" | Correct use |
| L27 | p, q ≥ 3, (p,q) ≠ (3,3), n = p + q | p = q = m ≥ 4, n = 2m | Yes |
| Tubular neighbourhood theorem | compact embedded submanifold of a Riemannian manifold | O is the orbit of the compact Lie group O(n) acting smoothly and isometrically on Σ, hence a compact embedded submanifold | Yes (standard fact about compact group orbits, see 7.1) |
| Taylor's theorem, Lagrange remainder to order 3 | f of class C³ on a convex set containing the segment [0,v] | f(v) = P(cos|v| W* + sin|v| v/|v|) is real-analytic on N, the closed ball of radius ρ/2 is convex and compact | Yes |
| Transport step | each g ∈ O(n) is an isometry of Σ preserving P and O | given in Definitions (O(n) acts orthogonally, P invariant) | Yes |

Used but unstated:
- The identification of W* (the unit Weyl tensor of S^{n/2}×S^{n/2}) with Nienhaus's W_{S_{m,m}} and with L27's W_{m,m}. The passage writes θ = θ_{m,m} and "L27 at p = q = m" without saying so. Read charitably this is notation (S_{k,l} the Einstein product S^k×S^l, which at k = l has equal radii), and no candidate arises, since the sign-independence of e (section 2) makes the L27 values independent of which of ±W is meant.
- That the orbit tangent T_{W*}O equals the summand ℝ^m⊗ℝ^m. This is inside L27 as given ("attained exactly on the orbit tangent, so dim E(½) = pq = dim(orbit)").

## 2. Claim 1, criticality and sign

Derivation. Proposition 2.25 at k = l = m, n = 2m:

θ_{m,m} = √2 · √( ((m-1)/m)² · (n-1)/(n-2) ) = √2 · ((m-1)/m) · √((n-1)/(n-2)),

since (m-1)/m > 0. This is the displayed value, and it is > 0 for m ≥ 2. Criticality: P(W) = ⟨W, Q(W)⟩ = θ|W|² and P(W) = θ ≠ 0 give |W| = 1, and the ambient gradient 3Q(W) = 3θW is radial, so its tangential part vanishes.

Sign. Q is quadratic, so Q(-W) = Q(W) = θW = (-θ)(-W) and P(-W) = ⟨-W, Q(W)⟩ = -θ. So -W* is critical with multiplier -θ, and e' = (-W*)/(-θ) = e. The ambient second differential at -W* is 6T(-W*, ·, ·) = -6θ L_e and the constraint term is -3P(-W*) Id = +3θ Id, so the Hessian at -W* is -6θ(L_e - ½Id). The Hessian changes sign with θ, exactly as written, so -W* has Hessian ≥ +6θ/(n-2) on N. The proof applies L24 only at W*, where its hypothesis θ > 0 holds.

No finding: the value, the positivity, criticality and the sign remark all check.

## 3. Claim 2, the Hessian paragraph

Values quoted from L27 at p = q = m, against Passage C: 1 on ⟨W⟩ (not in W*⊥), ½ on ℝ^m⊗ℝ^m and only there, λ_m = (m-2)/(2(m-1)) on each S²₀(ℝ^m), +μ on Λ²⊗Λ², -μ on S²₀⊗S²₀, 0 on the remaining four. Count: 1 + 1 + 2 + 1 + 1 + 4 = 10 summands. Every quoted value matches.

μ. From ½ - μ = ((p-2)(q-2) - 1)/(2(p-1)(q-1)) at p = q = m:

μ = ½ - ((m-2)² - 1)/(2(m-1)²) = ((m-1)² - (m-2)² + 1)/(2(m-1)²) = ((2m-3) + 1)/(2(m-1)²) = 2(m-1)/(2(m-1)²) = 1/(m-1).

Comparison. λ_m - μ = (m-2)/(2(m-1)) - 2/(2(m-1)) = (m-4)/(2(m-1)), which is ≥ 0 for m ≥ 4 and = 0 exactly at m = 4. The other values off the orbit tangent are 0 and -μ = -1/(m-1) < 0, and λ_m > 0 for m ≥ 3. So the largest value of L_e on W*⊥ off ℝ^m⊗ℝ^m is λ_m.

Orthogonality. L_e is self-adjoint (L24) and W*⊥ is L_e-invariant (L24), so its eigenspaces in W*⊥ for distinct eigenvalues are orthogonal. E(½) ∩ W*⊥ = ℝ^m⊗ℝ^m = T_{W*}O (L27), so N is the sum of the eigenspaces of L_e|_{W*⊥} with eigenvalue ≠ ½, and for v ∈ N, ⟨L_e v, v⟩ ≤ λ_m|v|².

Constant. ½ - λ_m = ((m-1) - (m-2))/(2(m-1)) = 1/(2(m-1)). Hence Hess(v,v) = 6θ⟨(L_e - ½)v, v⟩ ≤ 6θ(λ_m - ½)|v|² = -3θ/(m-1) |v|² = -6θ/(2m-2) |v|² = -6θ/(n-2) |v|², using θ > 0 to keep the direction of the inequality. On T_{W*}O the Hessian is 6θ(½ - ½) = 0.

Attainment. Each S²₀(ℝ^m) has dimension m(m+1)/2 - 1 ≥ 9 > 0, lies in N (eigenvalue λ_m ≠ ½, ≠ 1), and there Hess(v,v) = -6θ/(n-2)|v|² exactly.

No finding: every value, both identities, the "nowhere else" claim (a restatement of L27), the constant and its attainment check.

## 4. Claim 3, from the Hessian to a local maximum

Link 1, O and P on it. O = O(n)·W* is the orbit of a compact Lie group acting smoothly, hence a compact embedded submanifold of Σ. P(gW*) = P(W*) = θ by invariance.

Link 2, tubular neighbourhood. For a compact embedded submanifold of a Riemannian manifold, the normal exponential map restricted to {(x,v) : v ⊥ T_xO, |v| < ρ} is, for some ρ > 0, a diffeomorphism onto an open neighbourhood of O. Hypotheses hold by Link 1.

Link 3, f and its first two derivatives. f(v) = P(exp_{W*} v) on N is smooth. f(0) = P(W*) = θ. df(0) = dP(W*) ∘ d(exp_{W*})(0) = dP(W*)|_N = 0, since W* is critical on Σ. For v ∈ N, t ↦ exp_{W*}(tv) is a geodesic γ, so d²/dt² P(γ(t)) at t = 0 equals Hess P(v,v) + dP(γ̈ covariant) = Hess P(v,v). Polarisation gives d²f(0) = Hess P restricted to N.

Link 4, Taylor. The closed ball B̄ of radius ρ/2 in N is compact and convex, and d³f is continuous, so a finite K ≥ sup over B̄ and unit u of |d³f(ξ)[u,u,u]| exists. For |v| ≤ ρ/2, Lagrange's form gives ξ ∈ [0,v] with

f(v) = θ + 0 + ½ Hess(v,v) + (1/6) d³f(ξ)[v,v,v] ≤ θ - (3θ/(n-2))|v|² + (K/6)|v|³ ≤ θ - c|v|² + K|v|³.

The displayed inequality holds, with room (the factor 1/6 is discarded).

Link 5, transport. For g ∈ O(n), g is an isometry of Σ with g(O) = O, so g∘exp_{W*} = exp_{gW*}∘dg and dg maps T_{W*}O onto T_{gW*}O and N onto the normal space at gW*, preserving norms. Every normal vector w at x = gW* is g v with v = g⁻¹w ∈ N and |v| = |w|, and P(exp_x w) = P(g exp_{W*} v) = P(exp_{W*} v) = f(v). So P(exp_x w) ≤ θ - c|w|² + K|w|³ for |w| ≤ ρ/2 at every x ∈ O, with the same K. The choice of g among those with gW* = x does not matter.

Link 6, ρ'. With K > 0 and 0 < |v| < ρ' = min(ρ/2, c/K): |v| ≤ ρ/2 so Link 4 applies, and -c|v|² + K|v|³ = |v|²(K|v| - c) < |v|²(K·c/K - c) = 0. So f(v) < θ. (If a bound K = 0 were chosen the quotient is undefined, see 7.2.)

Link 7, U. U is the image under the tubular diffeomorphism of the open set {(x,v) : |v| < ρ'} with ρ' < ρ, so U is open in Σ and contains O (v = 0). A point y ∈ U \ O is exp_x v for some x ∈ O and normal v with |v| < ρ', and v ≠ 0 since v = 0 gives y = x ∈ O. By Links 5 and 6, P(y) < θ.

Quantifier order (item 2 of the fixed list). ρ is chosen from O alone. K is chosen from f, that is from W*, N and ρ. ρ' is chosen from ρ, K, θ, n. U is defined from ρ'. None of ρ, K, ρ', U depends on the point of O: ρ is uniform by the tubular theorem, and the bound with K is carried to every x ∈ O by Link 5.

No finding: every link follows from the one above and from the givens and standard theorems with their hypotheses met.

## 5. Claim 4, what is proven against what is stated

Stated: (a) W* is a local maximum of P on Σ, (b) some neighbourhood U of O in Σ has P < P(W*) on U \ O, (c) the Hessian transverse to O is at most -6θ/(n-2) and the bound is attained, with "not merely within 𝒟_n" as emphasis.

Proven: (b) is Link 7. (a) follows from (b): U is an open set containing W* with P ≤ θ on U (equality on O ∩ U, strict inequality off O), so W* is a local maximum on Σ, and a fortiori on Σ ∩ 𝒟_n. The maximum is non-strict at W* itself because dim O = m² > 0 and P ≡ θ on O, which is what "strictly so transverse to its orbit" says. (c) is section 3.

No finding: the gap between proven and stated is empty.

## 6. Claim 5, the n = 6 paragraph and the closing line

### 6.1 The n = 6 paragraph (5a)

At n = 6, m = 3 and (3,3) is L27's excluded pair. μ = 1/(m-1) = ½, consistent with ½ - μ = ((1)² - 1)/(2·4) = 0. dim Λ²(ℝ³)⊗Λ²(ℝ³) = 9 and dim ℝ³⊗ℝ³ = 9, so dim E(½) = 18 against an orbit of dimension pq = 9, leaving 9 null directions of the Hessian in N. The Hessian on N is then ≤ 0 with a nontrivial kernel, so the second-order test is inconclusive. "Whether P rises along them is a third-order question, turning on whether P is nonzero on that null space": along the geodesic in a unit null direction v, symmetry of T gives

P(cos t W* + sin t v) = θcos³t + 3cos²t sin t ⟨Q(W*),v⟩ + 3cos t sin²t θ⟨L_e v,v⟩ + sin³t P(v) = θ cos t (1 + ½sin²t) + sin³t P(v),

using ⟨Q(W*),v⟩ = θ⟨W*,v⟩ = 0 and ⟨L_e v,v⟩ = ½. The first term is θ - (3/8)θt⁴ + O(t⁶), so P rises along that geodesic for one sign of t exactly when P(v) ≠ 0. The paragraph's wording is confirmed as a statement about the null directions. The paragraph makes no claim that P ≡ 0 on the null space would settle local maximality at n = 6 (see 7.3), and it asserts nothing at n = 6 beyond "decides nothing".

No finding on 5a.

### 6.2 The closing line (5b), finding F1

(1) Location. [findings/second-order.md](../findings/second-order.md) line 53: "So at $n\ge12$ the balanced product is a strict local maximum transverse to its orbit, and what remains open is whether it is the global one."

(2) Concrete failure. The statement on line 37 and the proof cover every even n ≥ 8, that is m ≥ 4, which includes n = 8 (m = 4, the tie, section 8) and n = 10 (m = 5, λ_5 - μ = 1/8 > 0). The line summarising the section ("So ...") gives the range as n ≥ 12, which omits n = 8 and n = 10, where the lemma proves exactly the property the line names, and it drops the parity condition, so read literally it speaks of "the balanced product" at odd n ≥ 13, where S^{n/2}×S^{n/2} does not exist.

(3) Most charitable reading. Read as a corollary over even n, "at even n ≥ 12 the property holds" is true, since it is a special case of the statement, and it does not literally assert failure at n = 8, 10. This reading makes the sentence true but does not make it a correct statement of scope, which is what it is placed as (a concluding "So" after the n = 6 boundary paragraph, pairing the range with "what remains open"). A reader of that line alone would infer that the local question is settled only from n = 12 and open at n = 8 and 10, which contradicts line 37.

Verdict: REFUTED AS STATED as a statement of scope. The correct range is even n ≥ 8. The mathematics of lines 37-49 is unaffected.

## 7. Withdrawn candidates

### 7.1 "O is a compact submanifold" is asserted without argument

(1) Line 47: "$\mathcal O$ is a compact submanifold of $\Sigma$". (2) The tubular theorem needs an embedded submanifold, and the passage cites nothing for it. (3) Charitable reading: an orbit of a smooth action of a compact Lie group is a closed embedded submanifold diffeomorphic to O(n)/Stab(W*), a standard fact at the same level as the tubular theorem the brief admits. Withdrawn: the step is standard and its hypotheses (compact group, smooth linear action preserving Σ) hold.

### 7.2 ρ' is undefined if K = 0

(1) Line 49: "$\rho'=\min\big(\rho/2,\,3\theta/((n-2)K)\big)$". (2) If the chosen bound is K = 0 the quotient is undefined. (3) Charitable reading: "a bound K" is any upper bound, and any bound may be replaced by a larger positive one without affecting the Taylor inequality. Withdrawn.

### 7.3 "third-order question" understates the n = 6 problem

(1) Line 51: "Whether $P$ rises along them is a third-order question, turning on whether $P$ is nonzero on that null space." (2) Local maximality with a degenerate Hessian is not decided by the cubic term on the null space alone when that term vanishes: mixed cubic terms coupling a null direction with N's negative directions enter at fourth order along curved paths. (3) Charitable reading, and the literal one: the sentence speaks of P rising "along them", the null directions, and the exact expansion in 6.1 shows that along each null geodesic this is decided by P(v) ≠ 0. The sentence is a scope remark, not a claim that n = 6 reduces to the sign of P on the null space. Withdrawn.

### 7.4 "with equality on S²₀(ℝ^m)" is incomplete at m = 4

(1) Line 45: "with equality on $S^2_0(\mathbb R^m)$". (2) At m = 4, μ = λ_4 = 1/3, so equality also holds on Λ²⊗Λ² and on sums with it. (3) The line claims equality on S²₀(ℝ^m), which is true, and does not claim "only there". The statement asks only that the bound be attained. Withdrawn.

### 7.5 The Nienhaus object and the L27 object are identified without comment

(1) Line 41 writes θ = θ_{m,m} for W*, line 43 applies L27 "at p = q = m". (2) The brief's givens do not define S_{k,l} or state that W_{S_{m,m}} is W_{m,m} of L27. (3) Charitable reading: S_{k,l} is the product S^k×S^l in n = k + l dimensions and W_{p,q} its Weyl tensor, which is the passage's plain meaning. The L27 values depend on e only, which is the same for ±W, so no sign ambiguity can enter. Withdrawn as notation.

## 8. Claim 6, the boundary

- n = 8, m = 4: L27 applies ((4,4) ≠ (3,3)). ½ - μ = (4 - 1)/(2·9) = 1/6, μ = 1/3, λ_4 = 2/6 = 1/3, so λ_4 = μ, the tie. The tie changes the attaining set (7.4) but not the maximum off the orbit, and ½ - 1/3 = 1/6 > 0 keeps the orbit tangent the only ½-eigenspace. Hess ≤ 6θ(1/3 - 1/2) = -θ = -6θ/6 = -6θ/(n-2). θ_{4,4} = √2·(3/4)·√(7/6) > 0.
- The attaining normal directions: for m ≥ 5, exactly S²₀(ℝ^m)⊕S²₀(ℝ^m) (both factors), since λ_m > μ > 0 > -μ there. For m = 4, S²₀(ℝ^4)⊕S²₀(ℝ^4)⊕Λ²(ℝ^4)⊗Λ²(ℝ^4).
- v = 0: f(0) = θ, excluded from the strict inequality by 0 < |v| in Link 6, and matched on the other side by U \ O corresponding to v ≠ 0 in Link 7.
- n = 6 is outside the statement (section 6.1).

No finding.

## 9. Falsifiers sought

| Claim | Object that would falsify it | What was done |
|---|---|---|
| 1 | a sign convention making θ_{m,m} the value of P at -W_{S_{m,m}}, or |W_{S_{m,m}}| ≠ 1 | derived |W| = 1 from Q(W) = θW and P(W) = θ with θ ≠ 0 |
| 2 | an eigenvalue of L_e on W*⊥ off ℝ^m⊗ℝ^m that is ≥ λ_m and > λ_m, or = ½ | compared all ten L27 values in closed form for m ≥ 4 |
| 3 | a normal vector v ≠ 0 at some x ∈ O with |v| < ρ' and P(exp_x v) ≥ θ | checked each link, including uniformity of K in x via the isometry g |
| 4 | a point of U \ O without a representation exp_x v, v ≠ 0 | U is the tubular image, v = 0 lands in O |
| 5b | an even n in the proven range excluded by the closing line | n = 8 and n = 10 exhibited |
| 6 | m = 4 with ½ - μ ≤ 0 or λ_4 ≥ ½ | exact values 1/6 and 1/3 |

## 10. Overall verdict

PROVEN. The statement on line 37 is proven by lines 39-49 for every even n ≥ 8, with every hypothesis of Proposition 2.25, L24, L27, the tubular neighbourhood theorem and Taylor's theorem met where applied. One scope defect outside the proof: the closing line 53 states the range as n ≥ 12 (and omits parity) where the lemma proves even n ≥ 8 (F1, REFUTED AS STATED).
