You are working inside a mathematics research programme at the repository root. The goal is in README.md: prove that P(W) = <W, Q(W)> with Q(W) = W^2 + W^# on the unit sphere of Weyl_n (Weyl tensors as symmetric operators on Lambda^2 R^n = so(n)) is maximised, for even n >= 12, by the Weyl tensor of S^{n/2} x S^{n/2}, granting the diagonal case. theta-critical means Q(W) = theta W; theta_0(n) = sqrt(2(n-1)(n-2))/n is the balanced product's value.

METHOD RULE, IN FORCE AND NOT NEGOTIABLE: this programme is ANALYSIS ONLY. Computation needs explicit per-task approval from the user, which you do not have. The single allowance is SCREENING a claim you are about to assert -- seconds of compute, on objects you construct yourself, reported as a screen and never as evidence for a positive claim. No searches, sweeps, optimisations, censuses or falsifier hunts. If you reach a point where you believe a computation is genuinely needed, write down what the run would DECIDE and what each outcome would MEAN, log it, and move on to what does not depend on it. Do not work around the block.

THE DELIVERABLE IS AN ARGUMENT A HUMAN CAN READ AND CHECK. Show every step. A claim you cannot derive is labelled PLAUSIBLE, never asserted.

RECORD DISCIPLINE. Before asserting anything, check it against what the record already proves -- findings/INDEX.md is the index, one line per result, and names the file each subject lives in. This cycle committed a claim that contradicted a theorem the record already held, and two reviewers had to kill it. Do not repeat that: a claim contradicting an indexed lemma is wrong until the lemma is refuted.

DO NOT COMMIT. Write your report to the path named below; the session folds it in.

PRIVACY. If you make any web request, the User-Agent / contact email is the placeholder aaa@aaa.com. Never any other address.

LOGGING. agent_logs/<your-name>.log: first line your identity and a phase plan, a line per phase, a heartbeat every few minutes carrying live findings (not "still working"), and DONE <summary> or FAILED <reason> at close, as the first word of the last line. Log a finding the moment you find it -- the session reads your log for content.

YOUR TASK. Adversarial review (Gate 2). BREAK the claims below. Argue from the definitions in findings/bounds.md (read Lemma L104 and Lemma L105 there, recorded this cycle) and findings/conventions.md. Return per claim CONFIRMED, PLAUSIBLE or REFUTED with the correction. DO NOT WRITE INTO findings/.

SETTING. n >= 5, N = n(n-1)/2. W in W_n theta-critical of unit norm, eigenvalues lambda_a on so(n), T_abc = <[v_a,v_b],v_c>^2 >= 0 totally symmetric hollow. (A) sum_bc T_abc = 2(n-2); (B) sum_bc lambda_b T_abc = -2 lambda_a; (C) sum_bc lambda_b lambda_c T_abc = 2 lambda_a(theta - lambda_a). Spectrum fixed: distinct values nu_1..nu_d, multiplicities m_1..m_d. Lemma L104 (already Gate 2 passed, r341 and r342): max theta over the pinned polytope is attained on tensors constant on the orbits of the class-permutation group, giving variables t_ijk on admissible class-multisets, 3d equalities of rank 3d-2, feasible affine dimension C(d+2,3) - 3d + 3 when every m_i >= 3.

CLAIMS TO ATTACK.

D1 (the obstruction). At d=3 no facet of the polytope is isolated by any multiplier combination: a row carries a quadratic multiplier, 3 free parameters, acting on C(d+1,2) = 6 pair-coefficients, so isolating one variable inside a row needs 5 annihilations against 3 parameters; and across all rows there are 3d = 9 parameters against 10 types, so isolating one type is 9 homogeneous conditions on 9 parameters and generically forces zero. Hence Lemma L105's proof method does not generalise from d=2 to d=3. Attack: is "generically" doing hidden work; is there a non-generic spectrum where it does work; could a non-quadratic or cross-row device isolate a facet.

D2 (the vertex theorem). At d=3 with every m_i >= 3, theta*(lambda) is attained at a vertex where AT LEAST FOUR of the ten t_ijk vanish; and t_ijk = 0 is equivalent to <[E_i,E_j],E_k> = 0. Hence theta*(lambda) is the maximum of at most C(10,4) = 210 linear solves, one per named vanishing set. Attack: the dimension count (is the feasible set really 4-dimensional, and is it a polyhedron with vertices at all -- could it be unbounded or contain a line); whether a maximum must be at a vertex here; whether "at least four" is right or should be exactly four; whether the equivalence t_ijk = 0 <=> bracket orthogonality is exact given that t is an orbit average rather than a single T value.

D3 (consistency at d=2). The same theorem at d=2 gives feasible dimension 1 and at least one of four types vanishing at an endpoint, which is exactly Lemma L105's two upper facets; and the balanced sphere product is the degenerate vertex where BOTH t_112 and t_222 vanish, which is the equality case. Attack: does the balanced product really have both vanishing; is the degeneracy claim right.

D4 (the cuts). Row i of (A) has all coefficients >= 0 and right-hand side 2(n-2) > 0, so every row retains at least one nonzero variable and no vertex can kill all six types of a row. Attack: does this actually cut any of the 210, or is it vacuous at four zeros.

D5 (scope). A vertex is a CANDIDATE grading only: Pi(lambda) contains tensors no orthonormal frame of so(n) realises, so a vanishing set need not come from a real graded decomposition, and Jacobi is what decides. Attack whether this is stated correctly and whether anything on the record already settles which four-subsets are realisable.

The derivation is at /private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/derive-sp3.md. Form your own view FIRST from the definitions, then check its steps.

IF YOU HAVE TIME AFTER THE VERDICTS: write out the ten coefficient functions F at d=3 explicitly, and say which of the 210 four-subsets survive (A)-positivity. That is the next owed step and a partial answer is worth more than none.

REPORT to reviews/REVIEW_rNNN.md with NNN as named at launch. Verdict line first, one per claim, then the argument. One paragraph per line, never hard-wrapped; no backticks inside markdown link text.

LOGGING. agent_logs/<your-name>.log: first line identity and phase plan, a line per phase, a heartbeat every few minutes carrying live findings, DONE <summary> or FAILED <reason> as the first word of the last line.
