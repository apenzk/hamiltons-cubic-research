# REVIEW r1214: I73 class ceiling, Batch 19 (quartic bound on Pi#Pi)

Log: agent_logs/r1214.log. Claim read verbatim from reviews/2026-09-26-I73-class-ceiling.md, section "Batch 19". Screens were run with sage -python in the session scratchpad, seconds each, and are reported as screens only.

| claim | verdict |
|---|---|
| C1 | CONFIRMED, scope repair: the quadratic-form identity holds for x in V |
| C2 | CONFIRMED |
| C3 | CONFIRMED for so(k) and for simple subalgebras. "Every irreducible subalgebra" must read "every simple subalgebra" |
| C4 | CONFIRMED as an implication. The boxed bound is FALSE at n <= 8 and needs the hypothesis n >= 9 |
| C5 | CONFIRMED, one wording repair on "L256's condition" |
| C6 | CONFIRMED with correction: Sym^2 Lambda^2 has a fourth part Lambda^4, on which I# acts by 2. No violation found at n = 9..12 |

## C1

With L244 extended to Pi = sum v_i v_i^T, <(Pi#Pi)x,y> = (1/2) sum_{ij} <[v_i,v_j],x><[v_i,v_j],y>. For x in V, <x,K_V x> = sum_{ij} <[v_i,v_j],x>^2. Ad-invariance gives <v_i,[x,v_j]> = <x,[v_j,v_i]>, so this equals ||pi_V ad_x pi_V||_HS^2. Summing over x = v_k gives tr K_V = M(V), with M over ordered triples as in L255. For general x the left side is sum <[v_i,v_j],pi_V x>^2, which differs (screen at n = 5,6,7 confirms both). The note should say "for x in V".

## C2

K_V is positive semidefinite with range in V, so tr K_V is a sum of d eigenvalues and (sum lambda)^2 <= d sum lambda^2 = d tr K_V^2. Compression lowers the Frobenius norm: tr K_V^2 = ||pi_V B pi_V||_F^2 <= ||B||_F^2 with B = 2 Pi#Pi. Hence M <= sqrt d * 2||Pi#Pi||_F. Directions correct. The Frobenius norm is the operator trace on End(so(n)), consistent with the control ||I#I||_F = (n-2) sqrt N (81.2404 at n = 12).

## C3

At so(k) in the standard embedding, [v_i,v_j] lies in so(k), so <(Pi#Pi)x,y> vanishes whenever x or y is orthogonal to so(k). On so(k) the form is the I#I = (k-2)I computation of so(k). So Pi#Pi = (k-2)Pi exactly, K_V = 2(k-2) I_V (step one tight), pi_V B pi_V = B (step two tight), M = 2d(k-2). The same holds on any simple subalgebra, whose Killing form is a multiple of the restricted trace form. On a semisimple subalgebra whose ideals carry different Casimir values step one is strict. Example: so(3) on R^3 plus Lambda^2_+ on a disjoint R^4 in so(7) has K_V eigenvalues 2 (x3) and 4 (x3). "Irreducible" should read "simple".

## C4

theta <= M/(2 d^{3/2}) <= 2 sqrt d ||Pi#Pi||_F/(2 d^{3/2}) = ||Pi#Pi||_F/d <= (n-2)/sqrt N = sqrt2 (n-2)/sqrt(n(n-1)). Strictly below theta_0(n) = sqrt(2(n-1)(n-2))/n since the squared ratio is n(n-2)/(n-1)^2 < 1 at every n. Equality at Pi = I is correct.

**Defect: the boxed bound as displayed carries no range of n and is false at n <= 8.** Take V = Lambda^2_+ in so(4) in so(n), d = 3. On an ideal of so(4) the cross brackets vanish, so Pi#Pi = 2 Pi and ||Pi#Pi||_F = 2 sqrt3 = 3.4641. The bound is 3(n-2)/sqrt N: 3.4017 at n = 8, 3.5000 at n = 9. Ratios: 1.0184 at n = 8, 0.9897 at n = 9 (the ascent screen reproduces both). Also d = 2 at n = 5, span of two Lambda^2_+ elements with |[a,b]| = sqrt2: ratio 1.054. This is the same n >= 9 threshold as L256 (sok_beats_su2). The consequence for I73 at n >= 12 stands, but the boxed display should read "for n >= 9" (or n >= 12).

## C5

Pi#Pi = (1/2) sum_{ij} w_ij w_ij^T with w_ij = [v_i,v_j], so ||Pi#Pi||_F^2 = (1/4) sum_{ijkl} <w_ij,w_kl>^2 (screen confirmed). Equivalently Pi#Pi = phi phi^T for phi: Lambda^2 V -> so(n), v_i ^ v_j -> [v_i,v_j], and phi^T phi is the curvature operator of R_V, same nonzero spectrum. R_V(x,y,u,w) = <[x,y],[u,w]> is antisymmetric in each pair and pair-symmetric. The cyclic sum over (x,y,u) equals <[[x,y],u]+[[y,u],x]+[[u,x],y], w> = 0 by Jacobi, so Bianchi holds. Star (pencil u ^ w_i): the brackets are the d(d-1)/2 orthonormal w_i ^ w_j, so Pi#Pi is a projector of that rank and the norm is sqrt(d(d-1)/2). Correct.

Wording: "On subalgebras it is L256's condition" holds literally on simple subalgebras (both read C/(2 sqrt d) <= (n-2)/sqrt N). On a semisimple subalgebra the boxed inequality sum_i (C_i/2)^2 d_i <= (n-2)^2 d^2/N is a different inequality. It follows from L256's per-ideal bound C_i/sqrt d_i <= 2(n-2)/sqrt N and sum d_i^2 <= d^2. Suggested: "on subalgebras it follows from L256's per-ideal bound".

## C6

Monotonicity: for B >= 0, A <= A' gives (A'-A)#B >= 0, so 0 <= Pi#Pi <= I#Pi and tr X^2 <= tr XY <= tr Y^2 for 0 <= X <= Y. So ||Pi#Pi||_F <= ||I#Pi||_F. Correct.

Scalars: screened spectrum of B -> I#B on Sym^2 so(n) at n = 5,6,7 is n-2 (x1), (n-4)/2 (x n(n+1)/2 - 1), -1 (x Weyl dimension n(n+1)(n+2)(n-3)/12), and **2 (x C(n,4))**. A general projector has a Lambda^4 component (it need not satisfy Bianchi), so the note's list of three isotypic parts omits the fourth, where I# acts by 2. Since I# is equivariant and multiplicity free, it still preserves the orthogonal decomposition and ||I#Pi||_F^2 >= (n-2)^2 ||(d/N)I||_F^2 = (n-2)^2 d^2/N. The "wrong way" conclusion is correct.

||.||_F^2 <= ||.||_op tr: tr(Pi#Pi) <= tr(I#Pi) = (n-2)d and ||Pi#Pi||_op <= ||I#I||_op = n-2, giving (n-2)^2 d. Correct and weaker than the target since d <= N.

Refutation attempt (screen): Riemannian ascent of ||Pi#Pi||_F^2 with an analytic gradient (checked against finite differences), four random starts per (n,d), n = 8..12, d in {2,3,4,5,6,8,10,15}, plus three starts at n = 9,10 for d in {7,12,20,28,N-3}. Maximum of ||Pi#Pi||_F sqrt N/((n-2)d) at n >= 9: 0.9897 (n = 9, d = 3, Lambda^2_+), next 0.9719 (n = 9, d = 28, so(8)). At n = 8, d = 3: 1.0184, the counterexample above. No violation at n = 9..12. Local maxima only, not evidence for the bound.

## Lean

Nothing to check: no declaration exists yet for C1-C6.
