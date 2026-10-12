# REVIEW r1222: I117 batch 33 (PSD reduction, Lemmas A, B, C)

Log: [agent_logs/r1222.log](../agent_logs/r1222.log). Block audited: [2026-09-26-I73-class-ceiling.md](2026-09-26-I73-class-ceiling.md), section "Batch 33". Analysis first, screens of seconds on constructed objects only.

| claim | verdict | one-line reason |
|---|---|---|
| C1 Lemma A | CONFIRMED | expansion, termwise AM-GM, criticality and the PSD min-norm idempotent all check; the cited screen log does not reproduce from the committed script |
| C2 Lemma B | CONFIRMED | in C's eigenframe C#C is the stated positive sum of rank-one projectors; perfect compact subalgebra is semisimple; restriction and extension by zero both preserve idempotency |
| C3 reduction | CONFIRMED | both directions of the min-norm characterisation hold, cross terms vanish, the induced Casimir is scalar; one slip ("least norm" for least norm squared) |
| C4 two-block evidence | CONFIRMED | relations, equations, unique positive root and Jacobian spectrum all reproduced; (iii) is a weak screen |
| C5 Lemma C | PLAUSIBLE | every inequality and the equality case are right and the Lean matches, but "U is equivalent to the trace bound on simple h" proves U only for simple h, while U and the reduction need semisimple h; also the s_- remark covers only the face h = so(n) |
| C6 obstacle | REFUTED as worded | pairing with I gives tr C <= c tr C^2, a lower bound on the norm; the true statement is that no spectral pairing bounds tr C from below |

## C1, Lemma A

- F(X) = (1/2) sum f_abc f_a'b'c' X_aa' X_bb' X_cc' agrees with <X#X, X> on symmetric X (expanded from the brief's formula for <(A#B)h,h> with h = X b_gamma, h' = b_gamma). Substituting X = sum sigma_k u_k v_k^T gives the stated triple sum exactly. |X^T| = sum sigma u u^T and |X| = sum sigma v v^T give the two squared sums, and ab <= (a^2+b^2)/2 with weights sigma_k sigma_l sigma_m >= 0 gives the bound. The Frobenius norms agree.
- Consequence: F(X) <= max(F(|X^T|), F(|X|)) with both PSD of norm ||X||, so sup over symmetric X equals sup over the PSD cone and is attained there (compactness). A PSD maximiser is a global maximiser on the symmetric sphere, so the Lagrange condition gives X#X = kappa X (grad F = 3 X#X). Every nonzero idempotent has ||C||^2 = F(C) <= kappa ||C||^3, so ||C|| >= 1/kappa, and C = X/kappa attains it: the min-norm idempotent can be taken PSD. The sigma_k remark is right: sigma_k^2 = I, so |sigma_k| = I.
- Lean: [weighted_amgm](../lean/HamiltonsCubic/Results/I117PsdReduction.lean) states exactly the termwise step. The file compiles clean (lake env lean, exit 0, no warnings).
- Finding (provenance, minor): [agent_logs/screen_I117_psd.log](../agent_logs/screen_I117_psd.log) part (a) reads -9.000e+00 at n = 5, 6, 7. The committed [screen_I117_psd_reduction.py](../scripts/misc/screen_I117_psd_reduction.py), rerun at n = 5, prints -2.356e+02. My own copy gives -1130 and -4323 at n = 6, 7. The prose's "ratio at least 4" matches neither printout. The inequality is proved by hand, so no claim depends on the screen, but the logged line came from a different version of the script. Part (b) reproduces exactly at n = 5.

## C2, Lemma B

- Take the orthonormal basis b to be C's eigenframe, sigma = 0 on the kernel. Then <(C#C)h,h> = (1/2) sum sigma_a sigma_b <[v_a,v_b],h>^2, so C#C is PSD with range span{[v_i,v_j]} = [V,V]. C#C = C gives [V,V] = V. A subalgebra of compact so(n) is reductive (centre plus semisimple), and perfect removes the centre.
- Restriction: on h in V the sum runs over V's frame only and the brackets stay in V, so (C#C)|_V = C|_V #_V C|_V. The converse also holds: a PD idempotent on a subalgebra, extended by zero, is a PSD idempotent of g by the same formula. C3 uses this.

## C3, the reduction

- min ||C||^2 over nonzero idempotents of g is 1/kappa^2 (C1), and it is attained on PSD idempotents. These correspond one to one with pairs (h semisimple subalgebra, PD idempotent of h's own #) by C2 and its converse. Both directions hold.
- Simple ideals of h are orthogonal in any invariant metric: <[x,y],z> = -<y,[x,z]> = 0 for x, y in h_i and z in h_j, and h_i = [h_i,h_i]. Cross terms: Pi_i # Pi_j pairs brackets [u,v] with u in h_i and v in h_j, which vanish. Casimir: <(Pi_i#Pi_i)h,h> = (1/2) ||ad_h restricted to h_i||_HS^2 = -(1/2) Killing_i(h,h), which is a scalar multiple of the restricted invariant metric on simple h_i. So C_h = sum Pi_i/c_i satisfies C_h # C_h = C_h and ||C_h||^2 = sum d_i/c_i^2.
- The L256 step is consistent: M(h_i) = 2 c_i d_i, so the given bound reads d_i/c_i^2 >= N/(n-2)^2. U therefore implies H for n >= 9, with equality at h = so(n).
- Slip: "1/kappa_n^2 is the least norm" should read "least norm squared", since ||C|| = 1/kappa.
- Wording: "the PSD cone has a single interior candidate per subalgebra" states U as a fact. It is conjectural.

## C4, two-block evidence

- P_k # P_mix = ((k-1)/2) P_mix: for h = e_i wedge e_p in mix, (1/2) sum over the so(k) frame of ||[b, h]||^2 counts the k-1 generators containing i. SO(k) x SO(n-k) acts irreducibly on mix, and only scalars among symmetric operators commute with it. P_mix # P_mix = (n-k) P_k + k P_{n-k} follows from expanding I#I = (n-2)I. The mix component is zero because [mix, mix] lies in so(k) + so(n-k). The three scalar equations follow.
- Eliminating c^2 between the a and b equations, with b linear in a from the c-branch, gives a polynomial of degree at most 2 in a. Its only admissible root (a, b, c^2 > 0) is 1/(n-2) at every k for n = 5, 6, 7, 8, 9, 10, 12, 20, a wider set than the claimed n = 9, 12. At k = 1 the a-equation is spurious because P_1 = 0, and its positive root is still 1/(n-2).
- Jacobian: I built the operator Y -> (2/(n-2)) I#Y - Y on Sym at n = 5, 6, 7, 8. Eigenvalues are 1, -2/(n-2), -1-2/(n-2), 4/(n-2)-1 with multiplicities 1, dim S^2_0 R^n, dim Weyl, dim Lambda^4 (at n = 5: 1, 14, 35, 5). The only zero is on Lambda^4 at n = 6, so the implicit function theorem gives isolation for n != 6.
- (iii) reproduces at n = 5. It is weak: at n = 6, 7 Newton never reaches I/(n-2) itself, so it would have missed a second PD idempotent just as easily. The block labels it a screen, which is correct.
- Extra screen (so(4), which has two isomorphic ideals where cross-ideal mixing is most plausible): Newton from 300 random PD starts. The only PD idempotent found was I/2 (62 hits). The other limits were 0, Lambda^2_+-/2, so(3)-type Pi (eigenvalue 1, norm^2 3) and indefinite points.

## C5, Lemma C

- Correct as written: <C#C, C^{-1}> = sum_k (1/2) sum_ij c_ijk lambda_i lambda_j / lambda_k = <C, C^{-1}> = d. Symmetrising over the cyclic orderings and applying the three-ratio inequality gives d >= (1/2) sum c_ijk lambda_k = c tr C. Equality holds iff lambda is constant on every positive triple. For the connectivity step, the classes of the relation "share a positive triple" give a split S, S' with no positive triple meeting both. Then span(S) is closed under brackets and commutes with span(S'), so it is an ideal. Simplicity then gives C = lambda I, and lambda = 1/c. The C^{-2} pairing with AM-GM (product of the three ratios is 1) gives tr C^{-1} >= cd. The arithmetic d/c - s_- = 2(n-1)/(n-2) checks.
- Lean: [three_ratio](../lean/HamiltonsCubic/Results/I117PsdReduction.lean) and trace_le_of_pairing match the prose. The file uses cyclic invariance, which is weaker than and implied by full symmetry. The row sums sit over the last slot, and the pairing identity is a hypothesis. The equality case stays in prose, as the file's docstring says.
- **Gap 1 (the finding).** "Hence U is equivalent to a one-sided trace bound: every PD idempotent on a simple h has tr C >= d/c." The argument uses I#I = cI, so it covers only simple h. U, and the reduction's use of it, range over semisimple subalgebras (so(4), so(k) + so(n-k), and so on). A PD idempotent there could mix ideals, and the text never excludes this. The trace bound on simple algebras therefore does not give U, and does not give H. Repair (checked by hand): set K = I#I = sum c_i Pi_i. The same pairing gives d >= sum_k lambda_k <K u_k, u_k> = tr(CK), with equality iff lambda is constant on each eigenframe component. Each component spans an ideal J, a sum of simple ideals, and C = mu_J Pi_J there with mu_J^2 K|_J = mu_J, which forces equal c_i on J and C = sum Pi_i/c_i. So on semisimple h, **U is equivalent to tr(CK) >= d for every PD idempotent**. The simple-case trace bound is the special case K = cI. The so(4) screen above finds no cross-ideal PD idempotent, so the conclusion looks right. The written chain skipped this step.
- **Gap 2 (wording).** "On so(n) itself H needs less than U: tr C >= s_-" holds only for the face h = so(n). Batch 30's identity covers every idempotent with s >= s_-. PSD idempotents on proper subalgebras have small trace (Lambda^2_+/2 inside so(9) has tr 3/2 < s_- = 20/7), so batch 30 leaves them uncovered, and H still needs U, or the tr(CK) bound, on every proper semisimple subalgebra. The sentence should name the face.

## C6, the obstacle

- **Refuted as worded.** Witness: pair C#C = C with I. The diagonal identity (C#C)_kk = (1/2) sum_ij c_ijk lambda_i lambda_j and lambda_i lambda_j <= (lambda_i^2 + lambda_j^2)/2 give tr C <= c tr C^2 = c ||C||^2. This bounds the norm from below, which is the direction H needs, with equality at every sum Pi_i/c_i, Lambda^2_+/2 included. It holds for every symmetric idempotent, since the step needs no positivity.
- **What is true.** Pairing with C^p and applying Muirhead to the exponent triple (1,1,p) gives, with M_q = tr C^q (M_0 = d), M_q >= c M_{q+1} for q <= 0 (Lemma C at q = 0, tr C^{-1} >= cd at q = -1) and M_q <= c M_{q+1} for q >= 1 (the witness at q = 1). Only single-variable exponent vectors reduce to spectral sums through the row sums, so these are all the pure spectral pairings. None of them bounds M_1 = tr C from below, and chaining them cannot either, because each relates consecutive moments in a fixed direction. The corrected obstacle: **pairings give tr C <= d/c and ||C||^2 >= tr C/c, so H on a simple face follows from tr C >= d/c, and no pairing supplies that lower bound.** "The AM-GM step runs one way" should be replaced: the direction flips with p, and it never lands on a lower bound for M_1.

## Screens run (all seconds, scratchpad)

- Lemma A bound at n = 5, 6, 7, and the committed screen rerun at n = 5.
- Two-block admissible roots at n = 5..10, 12, 20, all k.
- The Jacobian spectrum at I/(n-2), n = 5..8.
- so(4) Newton, 300 PD starts.
- Lean compile of I117PsdReduction.lean.
