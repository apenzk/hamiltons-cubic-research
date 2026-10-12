# Gate 2 review r242, A2, the rationality of the certificate data

Reviewer 242, on claims **2, 4 and 5** of Gate 2 brief 26. Claims 1 and 3 are reviewer 241's, run concurrently and independently. Commits under review: 4676381 (primary), 848d184, 0eb360f, 0df3dff. Primary file: [scripts/runs/run_a2_rational_data.py](../scripts/runs/run_a2_rational_data.py). Plan item: [plan.md](../plan.md) A2.

| # | Claim | Verdict |
|---|-------|---------|
| 2 | The four ingredients are exhaustive | **REFUTED**, two structural ingredients are missing, and field closure cannot reach either |
| 4 | The screen is a genuine holdout | **REFUTED as a test, upheld as arithmetic**, the holdout is an identity forced by construction, and the screen never meets the 1/(n−2) or 1/(n−1) two thirds of its own claim |
| 5 | Deferring root-freeness to A5 is sound | **CONFIRMED, with one correction and one new obligation**, sound for the fit; A2 supplies no degree bound, and its root-freeness demand is stronger than the theorem needs |

Scripts: [scripts/reviewers/r242/](../scripts/reviewers/r242/). All arithmetic exact, [Fraction](https://docs.python.org/3/library/fractions.html#fractions.Fraction) and [sympy](https://docs.sympy.org/latest/index.html), no floating point anywhere in the verdicts.

---

## Claim 2, REFUTED. The four ingredients are not exhaustive

A2's argument is: every datum is built from diagram pairings, trace removal, block projection and the target; each is rational; rational functions are a field; therefore the data lies in Q(n). The inference is valid and the premise is not. **Field closure covers exactly the steps that are field operations, and the pipeline contains steps that are not.** Each of the following is a case distinction on whether a polynomial in n vanishes, or a search whose output is not a formula in n at all, and closure under +, −, ×, ÷ says nothing about either.

### Missing ingredient 5, the choice of an independent subset, and its determinant

[plan.md](../plan.md) section 2 item 1 expresses each covariant in the diagram spanning set **by solving against the diagram Gram**, and names the completed blocks' *nullities* as the check, so the spanning set is known to be dependent and the solve must first pick a maximal independent subset S, then invert Gram_S. Every coordinate the solve returns carries det Gram_S(n) in its denominator.

[r242_claim2_basis_determinant.py](../scripts/reviewers/r242/r242_claim2_basis_determinant.py) exhibits this on the smallest honest instance in the problem, the three-term curvature decomposition B = W + KN(E,g)/(n−2) + scal·KN(g,g)/(2n(n−1)). Every Gram entry is computed exactly at n = 4…20, reconstructed as a polynomial in n from the low dimensions and confirmed on the rest:

```
G[0][0] = 869/24        G[0][1] = 343/8         G[0][2] = 0
G[1][1] = 343(n-2)/8    G[1][2] = 0             G[2][2] = 8n(n-1)

det Gram_S(n) = 343 n (n-1) (869 n - 2767) / 24
```

The factor **869n − 2767 is none of n, n−1, n−2 or a Casimir difference**, it is assembled from the input tensor's own numbers, not from the machinery's coefficients, and A2's ingredient list has no slot for it.

Where such a factor's roots can sit is the sharper question, and the honest answer strengthens rather than weakens the finding. det Gram_S is the determinant of a Gram of real tensors, so it is non-negative wherever the covariants exist, and Cauchy–Schwarz pins this instance's root below n = 4. The danger is therefore not an arbitrary root but a **dimension-dependent syzygy**, a linear relation among the chosen covariants holding at one n and failing at the next. This problem demonstrably has them: [plan.md](../plan.md) A1 records that the SO(n) invariant count drops 92 → 89 between n = 12 and n = 13, and that "the degree-6 mechanism admits identities valid to n = 12 and violated at 13". A1's stability theorem fixes the *dimension* at 89 on [12, ∞); it does not fix *which* 89 diagrams are independent there, and a subset chosen at n = 12 may degenerate at some larger n.

**Stated positively, the obligation is a uniformity lemma:** one independent subset S, one basis of each multiplicity space, valid at every n ≥ 12 at once, or, equivalently, det Gram_S(n) added to A5's Sturm list as one more polynomial to certify. This is cheap and in the same currency as everything else on that list. It is simply absent.

### Missing ingredient 6, the certificate point is a search result, not a formula

This is the deeper one. A2 proves the **data** is rational in n. A4 fits the **solution**. Nothing yet connects them.

[run_n5_sdp.py](../scripts/runs/run_n5_sdp.py) states the route the port inherits: "solve the affine system over Q to get the 22-dimensional family of candidate Grams, **find an interior point numerically, round it to rationals**, and then VERIFY exactly". A4 runs that at n = 12, 14, 16, 18 and fits the four results as rational functions. But an interior point found by a floating-point solve and then rounded is not a function of n: four independent roundings inside four semialgebraic feasible sets have **no reason whatever to lie on a common rational curve**. The feasible set at each n is 22-dimensional at n = 5 and far larger at n = 12; the fit is being asked to interpolate four arbitrary points of four different high-dimensional bodies.

The repair is nameable and is the natural next derivation: **make the point a formula rather than a search result.** Select it as the solution of an n-uniform linear system, the affine constraints together with a fixed active set and the forced kernel at the extremiser orbit, the same active set at every n. Then B(n) solves a linear system with entries rational in n, so B(n) ∈ Q(n) by Cramer, and A2's closure argument reaches it. Until that selection is specified, "fit entries as rational functions" is fitting a curve through points that need not lie on one.

### Missing ingredients 7 and 8, carried by the n = 5 front end, should the port take it

The intended n ≥ 12 route is the diagram route ([plan.md](../plan.md) section 2 items 1–2), so these bite only if the highest-weight front end is ported too. They are named because A3 says "the pipeline the n = 5 proof validated end to end".

- **A normalisation.** [run_n5_assemble.py:293](../scripts/runs/run_n5_assemble.py#L293) divides every multiplicity-Gram entry by `q00`, the norm of one distinguished vector of one distinguished copy, guarded only by an assert that it is nonzero mod p. As a function of n that normaliser is a new denominator with no theorem behind it.
- **An unresolved real structure.** The highest-weight vectors are built over **Q(i)**, not Q ([run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py)), by diagonalising the adjoint Cartan action (an eigenvector computation) and intersecting raising-operator kernels by echelon with pivot selection. [run_n5_assemble.py:585–607](../scripts/runs/run_n5_assemble.py#L585) records reviewer 204's finding that the 89 = 65 + 24 split is a correct count under a *wrong labelling*: which 24 directions are gauge is not the "im" coordinates of this basis, and the real structure on each multiplicity space has never been computed. A real basis is a further n-dependent choice, and PSD (the whole point of the certificate), is a statement about a real form.
- **A basis choice on top of that.** The adapted basis is a BFS lowering-word list with leading-term reduction ([run_n5_adapted.py](../scripts/runs/run_n5_adapted.py)), and stage 3 inverts the adapted-basis matrix once per weight, asserting non-singularity rather than proving it. Each such determinant is another unnamed denominator.

### Missing ingredient 9, an n-dependent rank fact the orbit cut already rests on

[run_n12_unknowns.py](../scripts/runs/run_n12_unknowns.py) cuts 477 unknowns down by deleting one multiplicity from every spherical block, and closes with its own warning: "CONDITIONAL: this assumes every evaluation map is nonzero, which at n=5 took reviewer 178's mod-p rank argument. Unproved at n=12, so [the reduced count] is a LOWER bound on the unknowns." Non-vanishing of an evaluation map is a rank statement about an n-dependent matrix, a fifth kind of ingredient, decided by whether a polynomial in n vanishes, and settled at n = 5 only by a computation. It sits outside all four of A2's, and the shape of the SDP A4 fits depends on it.

### What claim 2 does survive

The four ingredients A2 names are all genuinely rational, the closure inference is valid, and [findings/brauer-pairing.md](../findings/brauer-pairing.md)'s monomial theorem is the correct numerator half. **A2 proves what it proves.** The refutation is of exhaustiveness only: the list is missing the steps that pick coordinates and pick a point, and those are precisely the steps closure cannot see.

---

## Claim 4, REFUTED as a test. The holdout is an identity, and two thirds of the claim is unexercised

### The holdout cannot fail

[r242_claim4_screen.py](../scripts/reviewers/r242/r242_claim4_screen.py), part (A), computes ⟨S,S⟩ and tr S for the screen's padded tensor at n = 4…12 and finds them **literally identical at every dimension**:

```
    n      <S,S>          tr S       <S~,S~>
    4    502681/9216     709/48      0
    5    502681/9216     709/48      502681/46080
    ...
   12    502681/9216     709/48      502681/13824
```

So ⟨S̃,S̃⟩ = ⟨S,S⟩ − (tr S)²/n is a − b/n by one line of algebra, with a and b **fixed before any dimension is chosen**. The three "held out" dimensions confirm that Python's [Fraction](https://docs.python.org/3/library/fractions.html#fractions.Fraction) arithmetic works. They carry no information about the certificate machinery's n-dependence, which is what the screen's docstring claims for them.

Sharper still: the fit recovers b = 4a exactly, because n = 4 is the accidental dimension-4 identity W_iabc W_jabc = (|W|²/4)δ_ij, at which ⟨S̃,S̃⟩ vanishes. **One of the two fit points is a special value of the very identity being fitted**, and the two-point fit has one genuine degree of freedom, not two.

### The 1/(n−2) plant the brief asked for, and the screen's teeth

Part (B) plants A − B/(n−2) at the same scale as the real datum and fits a − b/n through n = 4,5, through n = 5,6, and through the A4 sample pair n = 12,14. **Every fit misses every held-out dimension**, all seven of them, in all three cases. So the screen does have teeth. It was simply never pointed at anything with them.

### The machinery's own denominator is 1/(n−2), and the screen never meets it

The screen calls the Weyl projector `wp` exactly once, at n = 4, then pads. Its 1/(n−2) and 1/(2n(n−1)) coefficients are therefore **evaluated at n = 4 and at no other dimension**, the trace-removal machinery A2's ingredient 3 is about never runs at any n the screen tests.

[r242_claim4_denominator.py](../scripts/reviewers/r242/r242_claim4_denominator.py) runs `wp` **at** dimension n on a padded raw tensor, so trace removal executes there, and reconstructs the companion scalar in closed form from nine dimensions, confirmed on all seventeen:

```
<W(n), W(n)> = (869 n - 2767) / (24 (n - 2))
```

A pure 1/(n−2): the 1/n and 1/(2n(n−1)) parts cancel and the Weyl-decomposition coefficient survives alone, root at n = 2. This is the brief's planted datum produced by the machinery rather than by hand, and the shipped screen's a − b/n, fitted at n = 4,5, **misses all fifteen held-out dimensions**. Part (C) of the first script shows the same for ⟨S̃,S̃⟩ itself under the same treatment.

### What claim 4 does survive

A2's ingredient 3 is *corroborated*: the denominator n−2 is real and shows up in closed form. What fails is the screen's evidential claim. A screen whose data is n-independent by construction tests the arithmetic, not the derivation, and one that evaluates its own projector at a single dimension cannot see the 1/(n−1) and 1/(n−2) two thirds of what it is screening.

---

## Claim 5, CONFIRMED, with one correction and one new obligation

### The deferral is sound for the fit

A4 needs its denominators nonzero **at the sample points** n = 12, 14, 16, 18, since a datum whose denominator vanishes there does not exist and the solve returns nothing. For the denominators A2 names this is already discharged without A5: n, n−1, n−2 are nonzero at every n ≥ 12, and A2's own text has the Casimir differences nonzero at every **integer** n ≥ 12 by the separation theorem ([run_casimir_separation.py](../scripts/runs/run_casimir_separation.py) derives it from Harish-Chandra power sums rather than measuring it). Integer nonvanishing is exactly what sample points need. The real-interval statement is what only A5 supplies, and only the *conclusion* ("specialises to every n at once"), needs it. **A4 can proceed before A5.**

The denominators claim 2 adds are not covered by that theorem, but they are self-announcing at the sample points: a singular Gram_S or a vanishing normaliser makes the solve fail visibly rather than silently. That is an operational safeguard, not a proof, and it is enough for A4.

### The new obligation: A2 proves membership and no degree bound

Membership in a field is not finiteness. A rational function p/q with deg p = d₁, deg q = d₂ has d₁ + d₂ + 1 free parameters, so **four samples determine it only for d₁ + d₂ ≤ 3**. A2 bounds neither degree: the monomial theorem caps the *diagram* numerator at n⁶, but certificate entries are block projections carrying n, n−1, n−2, the Casimir differences and (claim 2) the basis-choice determinant.

[r242_claim5_degree_bound.py](../scripts/reviewers/r242/r242_claim5_degree_bound.py) exhibits two rational functions,

```
f(n) = (3n + 5) / (n(n-2))
g(n) = f(n) + (n-12)(n-14)(n-16)(n-18) / (n(n-1)(n-2)(n-3))
```

**agreeing exactly at all four A4 sample dimensions** (41/120, 47/168, 53/224, 59/288) and differing at n = 13, 20, 22, 24. Both are legal members of Q(n) under every word of A2's derivation. Only a degree bound separates them.

What rescues A4 is its second half, verifying μ_n(B(n)) = G_{μ,n} *as an identity in n in the Brauer ring* is a check, not a fit, so a wrong guess is rejected rather than believed. The four-point fit is a heuristic proposal followed by a proof, which is sound. What it is not is a **determination**: with no degree bound there is no bound on how many proposals must be tried, and no guarantee four samples ever produce the right one. Deriving that bound is A2's natural next obligation, and the ingredients for it are already in hand.

### The correction: root-freeness is stronger than the theorem needs

A2 requires every denominator root-free on the real interval [12, ∞). The theorem being proved concerns **even integers** n ≥ 12, and [Sturm's theorem](https://en.wikipedia.org/wiki/Sturm%27s_theorem) isolates real roots as well as counting them. A denominator with a root at, say, 13.7 therefore does not sink A5: split [12, ∞) at the isolated roots and run the sign check on each piece. The obligation is **sign-constancy on the subintervals carrying the even integers**, which is weaker than root-freeness and decidable by the same machinery. A2 is conservative here rather than wrong, and the weaker form is what A5 should be asked for, it is what a denominator like det Gram_S, which is a Gram determinant and hence non-negative where it is defined, will actually satisfy.

---

## What this review asks A2 to add

1. **A uniformity lemma**, one independent subset of the diagram spanning set, one basis of each multiplicity space, valid at every n ≥ 12 simultaneously, or det Gram_S(n) on A5's checklist.
2. **A selection rule for the certificate point** that is a formula in n (a fixed active set plus the forced kernel, solved by Cramer), replacing "find an interior point numerically and round it".
3. **A degree bound** on the numerators and denominators of B(n)'s entries, without which A4's four-point fit is a proposal rather than a determination.
4. **A screen that evaluates the Weyl projector at more than one dimension**, so the 1/(n−1) and 1/(n−2) parts of ingredient 3 are exercised; [r242_claim4_denominator.py](../scripts/reviewers/r242/r242_claim4_denominator.py) is a working one.
5. **Sign-constancy on subintervals**, in place of root-freeness on [12, ∞), as the statement A5 is asked to certify.
