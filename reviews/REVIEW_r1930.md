# REVIEW r1930: I124 batch 7, orbit tangents of the diagonal part in the closed branch

Log: [agent_logs/r1930-i124-orbit.log](../agent_logs/r1930-i124-orbit.log). Section under review: batch 7 of [2026-09-28q-I124-ascent.md](2026-09-28q-I124-ascent.md). Footing: analysis only, with one seconds-long screen on a model built here, reported as a screen.

**Verdict: the identity and the ascent criterion are CONFIRMED. Two wordings need correcting: the kernel remark's factor, and the screen's "as lambda_max = 1/2 requires", since the saturation comes from X.A being an orbit tangent of W itself.**

| # | claim | verdict |
|---|---|---|
| 1 | X.A perp W in the maximal frame | CONFIRMED |
| 2 | first and second derivatives of equivariance | CONFIRMED (needs only Q(A) = pA and the polarised equivariance) |
| 3 | the nu-component step | CONFIRMED |
| 4 | displayed identity and ascent criterion | CONFIRMED |
| 5 | kernel remark for X.nu | CONFIRMED in substance, wording corrected |
| 6 | screen at W_CP2 | CONFIRMED as a screen. The supremum is exactly 1 and attained. The explanation is corrected |
| 7 | "What it leaves" generalised-eigenvalue reading | CONFIRMED, with two additions (well-posedness, the case r = p/2) and the maximal-frame hypothesis restored |
| 8 | record search | CLASSIFIED: the technique is on record at W, and its use at the diagonal part is new |

## 1. X.A perp W

<X.A, A> = 0 because X acts skew-adjointly. <X.A, nu> = 0 is the maximal frame's first-order condition: d/dt |pi_D(e^{tX}W)|^2 at t = 0 is 2<pi_D W, X.W> = 2ab<A, X.nu> = -2ab<X.A, nu>, using <A, X.A> = 0. So X.A is perpendicular to W = aA + b nu. The hypothesis b > 0 plays no role here.

## 2. The two derivatives

Polarising Q(gx) = gQ(x) gives g(x o y) = gx o gy for every g in O(n), since o is the symmetric bilinear form belonging to Q (Q(x) = x o x, which the second variation 6(T(W,v,v) - theta/2) and Q(W) = theta W fix). Along g = e^{tX}:

- first order: 2 A o (X.A) = X.Q(A) = p X.A. This needs only Q(A) = pA.
- second order: 2(X.A) o (X.A) + 2 A o (X^2.A) = X^2.Q(A) = p X^2.A. This also needs only Q(A) = pA.

Both displayed identities follow. Neither uses A o nu = r nu, the first-order frame condition or the criticality of W. The second is the record's orbit identity B u = z o z ([second-order.md](../findings/second-order.md), "The orbit identity") with W replaced by the diagonal critical point A.

## 3. The nu-component

<nu, A o y> = T(A, y, nu) = <A o nu, y> = r<nu, y> by full symmetry of T and A o nu = r nu. So <nu, (X.A) o (X.A)> = (p/2 - r)<nu, X^2.A>. Skew-adjointness gives <nu, X^2.A> = -<X.nu, X.A>, hence (r - p/2)<X.nu, X.A>. Signs correct.

## 4. The identity and the criterion

T(W, X.A, X.A) = a<A o X.A, X.A> + b<nu, (X.A) o (X.A)> = (ap/2)|X.A|^2 + b(r - p/2)<X.nu, X.A>. From theta a = a^2 p + b^2 r and a > 0, theta - ap = b^2 r/a, so the coefficient of |X.A|^2 after subtracting theta/2 is -(b^2 r)/(2a). Dividing by b > 0 gives the criterion as written. When X.A = 0 both sides vanish and the strict inequality correctly fails.

An equivalent form, derived here and offered for the note (it removes nu): since b X.nu = X.W - a X.A,

  F(X.A) = (r - p/2)<X.W, X.A> - (theta/2 + a(r - p))|X.A|^2,

with F(v) = T(W,v,v) - (theta/2)|v|^2.

## 5. The kernel remark

- X.nu is perpendicular to W: <X.nu, nu> = 0 by skewness and <X.nu, A> = -<nu, X.A> = 0 by the first-order condition.
- X.W is in the kernel of the bilinear form B(u,v) = T(W,u,v) - (theta/2)<u,v> on all of W-perp, since W o (X.W) = (theta/2) X.W by the first derivative at W. So B(X.W, u) = 0 for every u, not only F(X.W) = 0.
- X.A = (X.W - b X.nu)/a, so F(X.A) = (b^2/a^2) F(X.nu), that is F(X.nu) = (a^2/b^2) F(X.A). Screened: agreement to 3e-15 on 200 random X (section 6).

**Correction of wording.** "The same holds with X.nu in place of X.A, up to the factor b^2/a^2" reads as if X.nu could be substituted into the displayed identity, which is false (the right side keeps |X.A|^2). The accurate statement: F(X.nu) = (a^2/b^2) F(X.A), so X.nu ascends exactly when X.A does, by the same criterion in X.A's quantities. **Consequence worth recording:** the orbit tangents of nu are those of A modulo the kernel, so they supply no second test.

## 6. The screen at W_CP2

Screen (seconds, model built here, [scr.py](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d3790d3b-3383-4c5d-9548-46ea15965c86/scratchpad/r1930/scr.py) in the scratchpad): at n = 4, Weyl = Sym^2_0(R^3) + Sym^2_0(R^3), so(4) = so(3) + so(3) acting by conjugation, Q(M,N) = (M^2 - tr(M^2)/3, N^2 - tr(N^2)/3), which is the unique equivariant quadratic map up to scale, and every checked quantity is scale-free. W = (M0, 0) with M0 = diag(2,-1,-1)/sqrt6. The coordinate diagonal D is {(M,M) : M diagonal traceless}, so A = (M0, M0)/sqrt2, nu = (M0, -M0)/sqrt2, a = b = 1/sqrt2, p = r, q = 0, matching batch 5. The identity holds to 3e-15 over 200 random X, the random maximum of the ratio is 0.983 (another seed than the author's 0.9965), and the threshold is br/(2a(r - p/2)) = 1.

**The supremum is exactly 1 and attained, by hand.** With X = (X+, X-), X.A = ([X+,M0], [X-,M0])/sqrt2 and X.nu = ([X+,M0], -[X-,M0])/sqrt2, so the ratio is (s - t)/(s + t) with s = |[X+,M0]|^2, t = |[X-,M0]|^2. It is at most 1, with equality exactly when [X-, M0] = 0 and [X+, M0] is nonzero, for instance X- = 0. Then X.nu = X.A and X.W = (a + b) X.A (screened to 2e-16, with F(X.A) = -7e-16).

**Correction of the explanation.** "The test is saturated there, as lambda_max = 1/2 requires" is imprecise. lambda_max(L_e on W-perp) = 1/2 (no ascent) forces ratio <= threshold, which is the inequality half. The saturation comes from something else: for X in so(3)+ the tangent X.A is an orbit tangent of W, which lies in the kernel. Suggested text: "sup = 1 exactly, attained where X.A is parallel to X.W (X in the self-dual so(3)), so the test meets W's own orbit directions there and is otherwise strict".

## 7. The generalised-eigenvalue reading

Write N(X) = <X.nu, X.A> and D(X) = |X.A|^2 on so(n), with tau* = br/(2a(r - p/2)).

- **Well-posedness, added.** D is positive semidefinite with kernel the stabiliser algebra h of A. N vanishes bilinearly against h: for X in h and any Y, <X.nu, Y.A> = -<nu, XY.A> = -<nu, [X,Y].A> - <nu, YX.A> = -<nu, [X,Y].A> = 0 by the first-order condition. So both forms descend to so(n)/h, D is definite there, and the extreme generalised eigenvalues exist and are attained. The note should state this, since otherwise the ratio could be unbounded.
- **Sign condition.** With r > 0 (so br/(2a) > 0): if r > p/2, ascent iff lambda_max(N, D) > tau* > 0. If r < p/2, ascent iff lambda_min(N, D) < tau* < 0. "Beyond tau* on the side of r - p/2's sign" says exactly this. **Added:** at r = p/2 the criterion reads 0 > (br/2a)|X.A|^2, so no orbit tangent of A ascends, and the test is empty there. Batch 2's bound r >= a theta/(1 + a) does not exclude r < p/2.
- **Hypotheses.** The bullet drops "in a frame maximising |pi_D W|", which claims 1 and 5 need. "Above theta_0" plays no role in the implication itself. It belongs to the owed step.

## 8. Record search

- The second-derivative identity is the record's orbit identity ([second-order.md](../findings/second-order.md), "The orbit identity", B u = z o z with z = X.W) and [post F37](../findings/fence-posts.md) (vacuity on the orbit tangent of W), there at W and here at the diagonal critical point A. [L266](../findings/second-order.md) (1) is the idempotent analogue (F vanishes on orbit tangents of C) and lives on the idempotent's own form, where batch 7 uses W's.
- The I121 note ([2026-09-28-I121-MG-audit.md](2026-09-28-I121-MG-audit.md)) uses the maximal frame's first-order condition to remove "the orbit line" in the pair block, and does not evaluate W's second variation on X.A.
- Batch 1 of the note itself names the family. Searches for X.A inside W's second variation across findings/ and the 2026-09-2x notes found nothing else.
- **Classified: new application of a recorded identity.** It should cite the orbit identity and post F37 as its source.
