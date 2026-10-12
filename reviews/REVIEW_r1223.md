# REVIEW r1223: I117 batch 33, the PSD reduction of statement H

Log: [agent_logs/r1223.log](../agent_logs/r1223.log). Block audited: [2026-09-26-I73-class-ceiling.md](2026-09-26-I73-class-ceiling.md), section "Batch 33". Screens (seconds each): r1223_c4.py and r1223_ss.py in the session scratchpad.

**Overall: The reduction "U implies H" stands. Two statements around it are too strong, and the named obstacle (C6) is false as worded.**

| claim | verdict |
|---|---|
| C1 Lemma A | CONFIRMED |
| C2 Lemma B | CONFIRMED |
| C3 the reduction | CONFIRMED (one wording slip) |
| C4 two-block evidence | CONFIRMED |
| C5 Lemma C | REFUTED in two sub-claims (the inequality, equality case and tr C^-1 bound are CONFIRMED). "U is equivalent to tr C >= d/c" holds for simple h only. "H needs only tr C >= s_-" omits proper subalgebras |
| C6 the obstacle | REFUTED |

## C1 Lemma A: CONFIRMED

- With the record's # the coordinate form is F(X) = (1/2) sum f_abc f_a'b'c' X_aa' X_bb' X_cc'. I derived this from the (A#B) formula: (X#X)_{c gamma'} = (1/2) sum X_{a alpha} X_{b beta} f_abc f_{alpha beta gamma'}.
- Substituting X_aa' = sum_k sigma_k u_k[a] v_k[a'] gives the triple sum exactly. Then ab <= (a^2+b^2)/2, applied termwise with weights sigma_k sigma_l sigma_m >= 0, gives (F(|X^T|) + F(|X|))/2, where |X^T| = sum sigma u u^T and |X| = sum sigma v v^T.
- For symmetric X, |X^T| = |X|, so F(X) <= F(|X|) with equal Frobenius norm. The sup is therefore attained on the PSD cone.
- A PSD maximiser is a global maximiser on the symmetric sphere and hence Lagrange-critical: X#X = kappa X.
- Every idempotent has F(C)/||C||^3 = 1/||C|| <= kappa. So the PSD C = X/kappa is norm-minimal.
- Lean: weighted_amgm is exactly the termwise step. Its statement matches the prose.

## C2 Lemma B: CONFIRMED

- C wedge C has eigenvectors v_i wedge v_j with eigenvalues sigma_i sigma_j, and it vanishes on every wedge that meets ker C. So C#C = (1/2) sum sigma_i sigma_j |[v_i,v_j]><[v_i,v_j]|, whose range is span{[v_i,v_j]} = [V,V]. (These are rank-one PSD terms, not projectors, but the range argument is unaffected.)
- A subalgebra of compact so(n) carries the restricted invariant metric, so it is reductive, and a perfect one is semisimple.
- The restriction step: C wedge C is supported on Lambda^2 V, so the g-sharp of C equals V's own sharp of C|_V, extended by zero.

## C3 the reduction: CONFIRMED

- **Both directions of the minimum hold.**
  - (<=) The PSD norm-minimal idempotent has support V, a semisimple subalgebra, and C|_V is a PD idempotent of V with the same norm.
  - (>=) A PD idempotent C_h on a subalgebra h, extended by zero, is an idempotent of g. The reason: for y in h-perp, <(C#C)x,y> contains <[b_alpha,b_beta],y> = 0. So ||C_h|| >= 1/kappa.
- **Cross terms vanish.** Pi_i#Pi_j contains [h_i,h_j] = 0.
- **The Casimir is scalar.** Pi_i#Pi_i is supported on [h_i,h_i] = h_i, commutes with Ad(exp h_i), and is symmetric. The adjoint representation of a compact simple algebra is absolutely irreducible (its complexification is simple), so the commutant is R.
- **The value c_i is the one in L256.** c_i computed inside h equals the c_{h_i} of h_i taken as a subalgebra of so(n), and L256 gives d_i/c_i^2 >= N/(n-2)^2 for n >= 9.
- Hence U implies H, with equality at h = so(n).
- **Wording slip.** The block says "1/kappa_n^2 is the least norm of". It should read least norm **squared**.

## C4 two-block evidence: CONFIRMED

- **The # relations are exact.** P_k#P_mix = ((k-1)/2)P_mix, P_mix#P_mix = (n-k)P_k + kP_{n-k}, and P_k#P_k = (k-2)P_k all hold to residual 0 at n = 7, 9 and k = 3, 4.
- **The scalar equations follow from these relations**, and I derived them by hand.
- **Only one positive solution exists.** At n = 9, 12 and every k from 2 to n-2, the exact quadratic has a = b = c = 1/(n-2) as its only positive solution. At k = 1 that solution is forced by hand.
- **The Jacobian eigenvalues match.** At n = 5, 6, 7 they are 1, -2/(n-2), -1-2/(n-2), 4/(n-2)-1, with multiplicities 1, dim Sym^2_0 R^n, dim Weyl, dim Lambda^4 (at n = 7 these are 1, 27, 168, 35).
- **Isolation for n != 6 follows**, since the Jacobian is invertible and the implicit function theorem applies. At n = 6 the Lambda^4 eigenvalue is 0. That makes the Jacobian singular, but it does not show non-isolation, and the block claims none.

## C5 Lemma C: REFUTED in two sub-claims, core CONFIRMED

- **The core argument holds.** The pairing identity, the symmetrisation over c_ijk (totally symmetric), the three-term inequality (ab = y and so on), tr C <= d/c, and tr C^{-1} >= cd (AM-GM on three terms with product 1) all hold.
- **The connectivity argument holds.** A split with no mixed positive triple makes [u_i,u_j] = 0 across the split and keeps brackets inside S, so span S is an ideal.
- **The arithmetic holds.** d/c - s_- = 2(n-1)/(n-2).
- **Lean check.**
  - trace_le_of_pairing assumes only cyclic invariance of c, which is weaker than the prose's full symmetry, and uses it correctly.
  - The row sum, the pairing and the conclusion gamma * sum lam <= D match the prose.
  - three_ratio matches.
  - Compile status: one run of the file took 5.6 s. The visible error was in delta_scalar, an unstaged declaration another session is adding, outside this brief. A clean rerun was blocked by a concurrent Lean process, so this report does not certify the compile.
- **Gap 1: the equivalence is for simple h only.**
  - "Hence U is equivalent to a one-sided trace bound" is proved for simple h. U, and the reduction's minimum, range over semisimple h, where sum_{i,j} c_ijk = 2<K u_k,u_k> with K = oplus c_i Pi_i. That value is not constant on a frame that is not adapted to the ideals.
  - Correction, by the same proof: every PD idempotent on a semisimple h has tr(CK) <= d. Equality holds iff lambda is constant on each connected component, and each component spans a sum of ideals, which forces C = oplus Pi_i/c_i.
  - **So U on semisimple h is equivalent to tr(CK) >= d for every PD idempotent, not to tr C >= d/c.**
  - Screen: Newton from 40 PD starts on su(2)+su(2) with Casimirs (1,1) and (1,4), and on su(2)^3, found only oplus Pi_i/c_i and no off-block mixing. This is consistent with U, and it is a screen, not evidence beyond these cases.
- **Gap 2: "H needs only tr C >= s_- for PD idempotents on g itself" is incomplete.**
  - Batch 30's bound applies to every idempotent on g. The norm-minimal PSD idempotent may be singular (supported on a proper subalgebra), and there the trace bound fails.
  - Witness: Lambda^2_+/2 at n = 9 has tr C = 3/2 < s_- = 20/7, yet ||C||^2 = 3/4 >= 36/49.
  - **The accurate statement: H follows from tr C >= s_- for PD idempotents on so(n), together with U (or just the norm bound) on every proper semisimple subalgebra.**

## C6 the obstacle: REFUTED

- **The claim.** "Every pairing of C#C = C with a function of C yields an upper bound on C's size."
- **Counter-witness: pair with I.** Take the eigenframe of C (any symmetric idempotent on g, any sign).
  - Pairing gives tr C = (1/2) sum c_ijk lambda_i lambda_j.
  - lambda_i lambda_j <= (lambda_i^2 + lambda_j^2)/2 with sum_{j,k} c_ijk = 2c gives **tr C <= c ||C||^2**, that is ||C||^2 >= tr C / c. This is a lower bound on the norm, and the norm is the quantity H bounds from below. Equality holds at I/c.
  - Check at n = 9 on Lambda^2_+/2: 0.214 <= 0.75.
- **Second witness: pair with the spectral projector at lambda_max** (a function of C). For PSD C this gives lambda_max <= c lambda_max^2, so **lambda_max >= 1/c** and tr C >= 1/c.
  - This is a lower bound on the trace from a pairing, although far from d/c.
- **The general pattern.** Pairing with C^p for p >= 0 gives tr C^{p+1} <= c tr C^{p+2}. Each of these fails for tC with t small, so each bounds size from below.
- **Accurate obstacle.** The pairings bound lambda_min <= 1/c <= lambda_max, tr C from above, and ||C||^2 from below by tr C/c. None found gives the needed tr C >= d/c (or tr(CK) >= d on semisimple h), because the lower bounds they give are relative to the trace, or sit on lambda_max rather than on the trace.
