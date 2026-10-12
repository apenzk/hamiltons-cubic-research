You are working inside a mathematics research programme at the repository root. The goal is in README.md: prove that P(W) = <W, Q(W)> with Q(W) = W^2 + W^# on the unit sphere of Weyl_n (Weyl tensors as symmetric operators on Lambda^2 R^n = so(n)) is maximised, for even n >= 12, by the Weyl tensor of S^{n/2} x S^{n/2}, granting the diagonal case. theta-critical means Q(W) = theta W; theta_0(n) = sqrt(2(n-1)(n-2))/n is the balanced product's value.

METHOD RULE, IN FORCE AND NOT NEGOTIABLE: this programme is ANALYSIS ONLY. Computation needs explicit per-task approval from the user, which you do not have. The single allowance is SCREENING a claim you are about to assert -- seconds of compute, on objects you construct yourself, reported as a screen and never as evidence for a positive claim. No searches, sweeps, optimisations, censuses or falsifier hunts. If you reach a point where you believe a computation is genuinely needed, write down what the run would DECIDE and what each outcome would MEAN, log it, and move on to what does not depend on it. Do not work around the block.

THE DELIVERABLE IS AN ARGUMENT A HUMAN CAN READ AND CHECK. Show every step. A claim you cannot derive is labelled PLAUSIBLE, never asserted.

RECORD DISCIPLINE. Before asserting anything, check it against what the record already proves -- findings/INDEX.md is the index, one line per result, and names the file each subject lives in. This cycle committed a claim that contradicted a theorem the record already held, and two reviewers had to kill it. Do not repeat that: a claim contradicting an indexed lemma is wrong until the lemma is refuted.

DO NOT COMMIT. Write your report to the path named below; the session folds it in.

PRIVACY. If you make any web request, the User-Agent / contact email is the placeholder aaa@aaa.com. Never any other address.

LOGGING. agent_logs/<your-name>.log: first line your identity and a phase plan, a line per phase, a heartbeat every few minutes carrying live findings (not "still working"), and DONE <summary> or FAILED <reason> at close, as the first word of the last line. Log a finding the moment you find it -- the session reads your log for content.

YOUR TASK. Adversarial review (Gate 2). Argue from findings/bounds-relaxations.md (Lemma L104 and the multiplier sections) and findings/bounds.md. Return per claim CONFIRMED, PLAUSIBLE or REFUTED. DO NOT WRITE INTO findings/.

SETTING. At a theta-critical point with d = 3 distinct eigenvalues nu_1 > nu_2 > nu_3, Lemma L104 reduces the pinned class to ten variables t_ijk on class-multisets, with 3d = 9 equalities (A_i),(B_i),(C_i) of rank 3d - 2 = 7 and feasible dimension 4. A vertex has at least four t_ijk zero. A multiplier is a quadratic phi applied to a row's three equations with weights (y^A, y^B, y^C) = the coefficients of phi; the coefficient it produces on type {i,j,k} is (orbit count) times psi(nu_j, nu_k), where psi is the polarisation of phi, psi(x,y) = y^A + y^B (x+y)/2 + y^C xy.

CLAIMS TO ATTACK.

R1 (the double-root family). Taking phi(x) = (x - nu_r)^2 gives psi(x,y) = (x - nu_r)(y - nu_r), which vanishes iff j = r or k = r. So in each row exactly three types survive, and there are nine such identities (three rows times three roots). Attack: is the surviving-type count really three in every one of the nine cases; does any row-root combination degenerate; is psi the correct polarisation.

R2 (the forbidding argument). If all three surviving types vanish then the left side is zero, so the right side must vanish; hence a nonzero right side forbids that three-subset, and therefore all seven four-subsets containing it. Attack the logic and the count of seven.

R3 (the unconditional pair). Three of the nine have right-hand side 2 nu_i[(n-1)nu_i + theta]. At nu_1 > 0 and nu_2 > 0 with theta > 0 these cannot vanish on a kernel-free spectrum, so the three-subsets {122,123,133} and {112,123,233} are forbidden unconditionally. The third, at nu_3 < 0, vanishes exactly when theta = (n-1)|nu_3|, the Pi-bound attained. Attack the arithmetic of each right-hand side and the sign reasoning.

R4 (the cut). Applied to the previously proved 179 supports, the two unconditional three-subsets give 173; all nine would give 130 but six right-hand sides are quadratic in (nu, theta) and are NOT shown nonzero, so 173 is the honest figure. Attack: recount 179 -> 173 -> 130 independently; is the split symmetric pair {113,123,223,333} really surviving the unconditional cut, as the control claims.

R5 (the verification). The identity was checked against Q_full on S^3 x S^4, S^3 x S^5 and S^4 x S^5 -- genuine critical points with three distinct eigenvalues, criticality residual <= 4e-16 -- holding at every row and every double root to 1e-9. Attack: is that check capable of failing, i.e. would a wrong right-hand side have shown up there, or does it follow from (A),(B),(C) at every Weyl tensor regardless? THIS IS THE MOST IMPORTANT QUESTION IN THE BRIEF: three screens earlier in this session could not have detected their own errors.

The derivation is the final two sections of findings/bounds-relaxations.md. Form your own view FIRST from the definitions.

REPORT to reviews/REVIEW_rNNN.md with NNN as named at launch. Verdict line first, one per claim, then the argument. One paragraph per line, never hard-wrapped; no backticks inside markdown link text.

LOGGING. agent_logs/<your-name>.log: first line identity and phase plan, a line per phase, a heartbeat every few minutes carrying live findings, DONE <summary> or FAILED <reason> as the first word of the last line.
