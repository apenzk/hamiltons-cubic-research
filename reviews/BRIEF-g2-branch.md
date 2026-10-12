You are working inside a mathematics research programme at the repository root. The goal is in README.md: prove that P(W) = <W, Q(W)> with Q(W) = W^2 + W^# on the unit sphere of Weyl_n (Weyl tensors as symmetric operators on Lambda^2 R^n = so(n)) is maximised, for even n >= 12, by the Weyl tensor of S^{n/2} x S^{n/2}, granting the diagonal case. theta-critical means Q(W) = theta W; theta_0(n) = sqrt(2(n-1)(n-2))/n is the balanced product's value.

METHOD RULE, IN FORCE AND NOT NEGOTIABLE: this programme is ANALYSIS ONLY. Computation needs explicit per-task approval from the user, which you do not have. The single allowance is SCREENING a claim you are about to assert -- seconds of compute, on objects you construct yourself, reported as a screen and never as evidence for a positive claim. No searches, sweeps, optimisations, censuses or falsifier hunts. If you reach a point where you believe a computation is genuinely needed, write down what the run would DECIDE and what each outcome would MEAN, log it, and move on to what does not depend on it. Do not work around the block.

THE DELIVERABLE IS AN ARGUMENT A HUMAN CAN READ AND CHECK. Show every step. A claim you cannot derive is labelled PLAUSIBLE, never asserted.

RECORD DISCIPLINE. Before asserting anything, check it against what the record already proves -- findings/INDEX.md is the index, one line per result, and names the file each subject lives in. This cycle committed a claim that contradicted a theorem the record already held, and two reviewers had to kill it. Do not repeat that: a claim contradicting an indexed lemma is wrong until the lemma is refuted.

DO NOT COMMIT. Write your report to the path named below; the session folds it in.

PRIVACY. If you make any web request, the User-Agent / contact email is the placeholder aaa@aaa.com. Never any other address.

LOGGING. agent_logs/<your-name>.log: first line your identity and a phase plan, a line per phase, a heartbeat every few minutes carrying live findings (not "still working"), and DONE <summary> or FAILED <reason> at close, as the first word of the last line. Log a finding the moment you find it -- the session reads your log for content.

YOUR TASK. Adversarial review (Gate 2). Argue from findings/bounds-relaxations.md (Lemma L104, the two multiplier families, the classification tables) and findings/bounds.md (Lemmas L70, L71, L73, the Pi-bound). Return per claim CONFIRMED, PLAUSIBLE or REFUTED. DO NOT WRITE INTO findings/.

SETTING. Theta-critical W in W_n, unit norm, three distinct eigenvalues nu_1 > nu_2 > nu_3 with multiplicities m_i >= 3, kernel-free, theta > 0. Tracelessness forces nu_1 > 0 > nu_3. Lemma L104 reduces the pinned class to ten variables t_ijk with feasible dimension 4; a vertex has at least four t_ijk zero. Two multiplier families act on each row's three equations (A_i),(B_i),(C_i): the FOUR-TYPE family phi(x) = (x - nu_a)(x - nu_b), and the DOUBLE-ROOT family phi(x) = (x - nu_r)^2 which annihilates every type containing r and leaves three. A nonzero right-hand side forbids the surviving type-set, hence every four-subset containing it.

CLAIMS TO ATTACK.

S1 (the general right-hand sides). For the double-root family, rhs/2 = (n-2)nu_r^2 - nu_i^2 + 2 nu_i nu_r + nu_i theta; for the four-type family, rhs = 2 nu_i[(n-1)nu_j + theta]. Verify both forms independently from (A_i),(B_i),(C_i).

S2 (the classification). Free of any hypothesis: {122,123,133} always; one of {223,233,333} (when rho_1 > n/(n-2)) or {111,112,122} (when rho_1 < sqrt(n-1) - 1) at n >= 7; and the four-type {123,133,223,233}, whose rhs is nu_3 times a positive. Five of the nine double roots and four of the six four-type identities need the sign of nu_2; one of each needs Pi strict. The PAIR CUT is NOT free -- it is nu_1[(n-1)nu_2 + theta]. Attack every row of this classification.

S3 (the chain). The hypothesis-free chain is 210 -> 209 -> 202 -> 195, tightening to 173 under nu_2 > 0 and 130 under Pi-strictness. Recount independently. Note two earlier figures were wrong: r359 reported 192 counting nu_2-dependent identities as free, and the session first recounted 201 using a wrong free set.

S4 (the branch). The sign of nu_2 is undetermined -- tracelessness gives only nu_1 > 0 > nu_3, and Lemma L35 does not reach it at d=3 since a negative nu_2 leaves m_2 + m_3 >= 6 negative eigenvalues. The nu_2 < 0 branch costs exactly ONE identity, i = r = 2, whose rhs becomes rho_2[(n-1)rho_2 - theta] and vanishes at theta = (n-1)|nu_2|. Attack: is the sign really undetermined, is it exactly one identity, and does anything else in the classification flip when nu_2 < 0?

S5 (the repair). Adding second-Pi-strictness, theta != (n-1)|nu_2|, restores that identity and makes the branches agree, replacing a sign assumption by a non-degeneracy condition. Attack: is second-Pi-strictness a legitimate hypothesis or does it secretly exclude the cases of interest; what does Lemma L71 actually say about Pi-saturation and does it transfer to the middle eigenvalue.

The derivation is the last three sections of findings/bounds-relaxations.md. Form your own view FIRST from the definitions. NOTE: five screens in this session could not have failed; if you run any check, state first what outcome would falsify the claim.

REPORT to reviews/REVIEW_rNNN.md with NNN as named at launch. Verdict line first, one per claim, then the argument. One paragraph per line, never hard-wrapped; no backticks inside markdown link text.

LOGGING. agent_logs/<your-name>.log: first line identity and phase plan, a line per phase, a heartbeat every few minutes carrying live findings, DONE <summary> or FAILED <reason> as the first word of the last line.
