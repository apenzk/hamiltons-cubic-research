# REVIEW r1931: I124 batch 7, orbit tangents of the diagonal part in the closed branch

Log: [agent_logs/r1931-i124-orbit.log](../agent_logs/r1931-i124-orbit.log). Section reviewed: [2026-09-28q-I124-ascent.md](2026-09-28q-I124-ascent.md), batch 7. Footing: analysis only. No computation was run, and every verdict below is a derivation by hand.

**Verdict: the identity and the ascent criterion are CONFIRMED. Three corrections are owed. The kernel remark's factor needs a direction. The screen's supremum is exactly 1 and is attained, by directions where X.A is parallel to X.W, so the saturation carries no information. The generalised-eigenvalue reading is well posed only because frame maximality at second order kills a cross term, which the note should say.**

Notation: F(v) = T(W,v,v) - (theta/2)|v|^2, with bilinear form B(u,v) = T(W,u,v) - (theta/2)<u,v>. N(X) = <X.nu, X.A> and D(X) = |X.A|^2 on so(n).

| # | claim | verdict |
|---|---|---|
| 1 | X.A perp W | CONFIRMED |
| 2 | first and second derivatives of equivariance | CONFIRMED (needs only Q(A) = pA, and it is F37's pair of identities read at the critical point A) |
| 3 | the nu-pairing step | CONFIRMED |
| 4 | displayed identity and criterion | CONFIRMED |
| 5 | kernel remark | CONFIRMED with correction: F(X.nu) = (a^2/b^2) F(X.A), and X.nu perp W holds |
| 6 | screen at W_CP2 | PLAUSIBLE as a screen, corrected: the supremum is exactly 1 and is attained, on orbit tangents of W |
| 7 | "What it leaves" | CONFIRMED with correction: well posed on so(n)/stab(A) because second-order frame maximality forces the cross term to vanish, and that condition also gives the lower bound N >= -(a/b)D |
| 8 | on the record already? | partly: links 1-2 are F37 applied at A, while the pairing with nu in the closed branch and the resulting test are new |

## 1. X.A perp W

<X.A, A> = 0 because X acts skew-adjointly. <X.A, nu> = 0 is the frame's first-order condition. So <X.A, W> = a<X.A, A> + b<X.A, nu> = 0. The direction is a legitimate tangent to the unit sphere at W because so(n) preserves the Weyl space. When X lies in stab(A), X.A = 0 and both sides of the identity vanish, which is consistent with the identity.

## 2. The two derivatives

Take g_t = exp(tX). Then Q(g_t A) = (g_t A) o (g_t A) = p g_t A.

- At t = 0 the first derivative is 2 A o (X.A) = p X.A.
- The second derivative is 2 (X^2.A) o A + 2 (X.A) o (X.A) = p X^2.A, which gives (X.A) o (X.A) = (p/2) X^2.A - A o (X^2.A).

Both identities use only Q(A) = pA, the equivariance of the product and its bilinear symmetry. They do not use A o nu = r nu, the frame condition, or a and b. This is [post F37](../findings/fence-posts.md)'s pair of identities, L_W z = (theta/2) z and B u = z o z, applied at the critical point A with p in place of theta. F37 already notes that no maximality is used and that p may have either sign.

## 3. The nu-pairing

<nu, A o Y> = T(A, nu, Y) = <A o nu, Y> = r<nu, Y> uses the closed-branch hypothesis A o nu = r nu, so <nu, (X.A) o (X.A)> = (p/2 - r)<nu, X^2.A>. Skew-adjointness gives <nu, X.(X.A)> = -<X.nu, X.A>, so the result is (r - p/2)<X.nu, X.A>. The signs are right.

## 4. The identity and the criterion

T(W, X.A, X.A) = a<A o X.A, X.A> + b<nu, (X.A) o (X.A)> = (ap/2)|X.A|^2 + b(r - p/2) N(X). The D-component of criticality, theta a = a^2 p + b^2 r, gives theta - ap = b^2 r/a with a > 0. Subtracting (theta/2)|X.A|^2 yields the displayed identity. Dividing by b > 0 gives the ascent test (r - p/2) N(X) > (br/2a) D(X). Both steps are exact.

## 5. The kernel remark

- **X.W lies in the kernel of B on the whole space.** Differentiating Q(g_t W) = theta g_t W once gives W o (X.W) = (theta/2) X.W, so B(X.W, v) = 0 for every v.
- **X.nu is perp W.** <X.nu, W> = a<X.nu, A> + b<X.nu, nu> = -a<nu, X.A> + 0, which is 0 by the first-order condition.
- **The factor has a direction.** Write X.nu = (X.W - a X.A)/b. The cross and square terms in X.W drop out, so F(X.nu) = (a^2/b^2) F(X.A). Equivalently F(X.A) = (b^2/a^2) F(X.nu).
- **Correction.** The note's "up to the factor b^2/a^2" is right only in the second reading. The note should write the equation out.
- **What the remark means.** Modulo the kernel, X.A is congruent to -(b/a) X.nu. So the X.nu test is the same test, with nothing new in it.

## 6. The screen at W_CP2 (n = 4)

Batch 5 gives a = b = 1/sqrt2 and p = r, so the threshold br/(2a(r - p/2)) = r/(2 * r/2) = 1 is correct. The supremum can be computed in closed form.

**The Lambda+/- model.**

- so(4) splits as su(2)+ + su(2)-, and each factor acts on S^2_0(R^3) by commutator.
- W_CP2 is (M, 0) with M proportional to diag(2,-1,-1) in the Lambda+ basis adapted to the frame.
- The coordinate-diagonal space D is {(K, K) : K diagonal traceless}.
- So pi_D W = (M/2, M/2), which gives a^2 = 1/2. Then A is proportional to (M, M) and nu to (M, -M), with equal norms.

**The ratio.** For X = (X+, X-), X.A is proportional to ([X+,M], [X-,M]) and X.nu to ([X+,M], -[X-,M]). This gives

N/D = (|[X+,M]|^2 - |[X-,M]|^2) / (|[X+,M]|^2 + |[X-,M]|^2) <= 1.

**When the ratio equals 1.** Equality holds exactly when [X-,M] = 0 and [X+,M] != 0, for example X in su(2)+ outside the stabiliser. So the supremum is exactly 1 and is attained. Random X carry an su(2)- component, which is why sampling found only 0.9965.

**Correction on "saturated".** At the maximisers X.nu = X.A, so X.W = (a+b) X.A lies in the orbit tangent of W, where F vanishes identically. The saturation therefore comes from the kernel, and the test is equality there by the same mechanism as F37. The same holds in general: whenever X.nu = lambda X.A, then X.A lies in span(X.W), F(X.A) = 0, and the ratio lambda equals the threshold exactly. "As lambda_max = 1/2 requires" is right in that W_CP2 has no ascent (batch 5), which forces ratio <= 1. The attainment is forced by the kernel.

On the identity check to 5e-14: the identity is proved in 1-4, so a numerical match is expected, and I accept it as a screen.

## 7. "What it leaves"

**The sign reading is right.**

- If r > p/2, ascent needs sup N/D > br/(2a(r - p/2)).
- If r < p/2, ascent needs inf N/D < br/(2a(r - p/2)), which is negative when r > 0.
- If r = p/2, ascent needs r < 0.

"Beyond the threshold on the side of r - p/2's sign" states exactly this.

**The quotient must be stated.** D vanishes on stab(A), and N is not a function on so(n)/stab(A). For S in stab(A), N(X0 + tS) = N(X0) + t<S.nu, X0.A>, since N(S) = <S.nu, S.A> = 0. If that cross term were nonzero, the ratio would be unbounded in both directions, so any r != p/2 would ascend. In a maximal frame the cross term vanishes, by the second-order frame condition, derived below.

**The second-order frame condition.** Let f(t) = |pi_D(g_t W)|^2.

- f'(0) = -2ab<X.A, nu>. Here pi_D(X.S) = 0 for every diagonal S, because rotating a diagonal tensor moves its diagonal entries by 2u = 0.
- f''(0) = 2|pi_D X.W|^2 - 2a<X.A, X.W>.
- f''(0) <= 0 reads b^2 |pi_D X.nu|^2 <= a^2 D(X) + ab N(X). Equivalently, N(X) >= (b/a)|pi_D X.nu|^2 - (a/b) D(X).

**Consequences.**

- Setting X = S in stab(A) gives pi_D S.nu = 0.
- Then X = X0 + tS makes the right side independent of t while the left side is linear in t. So <S.nu, X0.A> = 0.
- The pencil (N, D) is therefore well defined on so(n)/stab(A), and D is positive definite there. The generalised eigenvalues are finite and bounded below by -a/b. The value -a/b is attained on stab(W) when that is not contained in stab(A).
- This is the pairwise-rotation inequality (eq:secondvar) of the outside archive's maximal-frame report (an outside report archive (unpublished, held in the private record) around line 984), written for general X.

**Recommendation.** State the pencil on so(n)/stab(A) and cite the second-order frame condition. Also note that this condition bounds the ratio from below, which bears on the r < p/2 side (inf N/D >= -a/b), and leaves the r > p/2 side, where the I104 configurations sit (tau = r > 0), unconstrained by frame maximality.

## 8. Record search

- **Already on the record.** [Post F37](../findings/fence-posts.md) derives the first and second derivatives of equivariance for a critical point W: z = X.W, u = X^2.W, L_W z = (theta/2) z, B u = z o z. Links 1-2 are that post read at A. The orbit tangent of W in the 1/2-eigenspace is also derived in [second-order.md](../findings/second-order.md) (around lines 855 and 935) and underlies L24's sharpness. Batch 7's claim that X.W is in the kernel of the form is that fact.
- **Partial overlap.** The outside archive's maximal-frame report has the frame's first- and second-variation conditions for pair rotations (unaudited, entered through the audit (unpublished, held in the private record)). Its second-variation condition is a special case of the frame inequality in section 7.
- **Not on the record.** I found no evaluation of T(W, X.A, X.A) paired against nu in the closed branch, and no one-ratio test. The [I121 note](2026-09-28-I121-MG-audit.md) mentions an "orbit line" only in the pair-block table (line 93), where the first-order condition removes it. [L284](../findings/second-order.md) and L120-L123 carry the closed branch and the character blocks, but not this second variation.
- **Conclusion.** The combination is new. It should cite F37 for the two derivatives.

DONE
