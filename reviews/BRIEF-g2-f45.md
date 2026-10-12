You are working inside a mathematics research programme at the repository root. The goal is in README.md: prove that P(W) = <W, Q(W)> with Q(W) = W^2 + W^# on the unit sphere of Weyl_n (Weyl tensors as symmetric operators on Lambda^2 R^n = so(n)) is maximised, for even n >= 12, by the Weyl tensor of S^{n/2} x S^{n/2}, granting the diagonal case. theta-critical means Q(W) = theta W; theta_0(n) = sqrt(2(n-1)(n-2))/n is the balanced product's value.

METHOD RULE, IN FORCE AND NOT NEGOTIABLE: this programme is ANALYSIS ONLY. Computation needs explicit per-task approval from the user, which you do not have. The single allowance is SCREENING a claim you are about to assert -- seconds of compute, on objects you construct yourself, reported as a screen and never as evidence for a positive claim. No searches, sweeps, optimisations, censuses or falsifier hunts. If you reach a point where you believe a computation is genuinely needed, write down what the run would DECIDE and what each outcome would MEAN, log it, and move on to what does not depend on it. Do not work around the block.

THE DELIVERABLE IS AN ARGUMENT A HUMAN CAN READ AND CHECK. Show every step. A claim you cannot derive is labelled PLAUSIBLE, never asserted.

RECORD DISCIPLINE. Before asserting anything, check it against what the record already proves -- findings/INDEX.md is the index, one line per result, and names the file each subject lives in. This cycle committed a claim that contradicted a theorem the record already held, and two reviewers had to kill it. Do not repeat that: a claim contradicting an indexed lemma is wrong until the lemma is refuted.

DO NOT COMMIT. Write your report to the path named below; the session folds it in.

PRIVACY. If you make any web request, the User-Agent / contact email is the placeholder aaa@aaa.com. Never any other address.

LOGGING. agent_logs/<your-name>.log: first line your identity and a phase plan, a line per phase, a heartbeat every few minutes carrying live findings (not "still working"), and DONE <summary> or FAILED <reason> at close, as the first word of the last line. Log a finding the moment you find it -- the session reads your log for content.

YOUR TASK. Adversarial review (Gate 2). Argue from findings/bounds-relaxations.md (Lemma L104, the multiplier families, posts F43 and F45) and findings/second-order.md (L121, L123). Return per claim CONFIRMED, PLAUSIBLE or REFUTED. DO NOT WRITE INTO findings/.

STANDING RULE FOR THIS REVIEW. The programme is ANALYSIS ONLY and this cycle has just been pulled up for computational drift. Do not settle any claim below by enumeration. Where a claim is a count, say whether an ARGUMENT is available for it and whether the record's use of it depends on the number or only on its existence. If you run any check at all, state first what outcome would falsify the claim -- six screens in this session could not have failed.

SETTING. At a theta-critical point with three distinct eigenvalues nu_1 > nu_2 > nu_3, all multiplicities >= 3, kernel-free, theta > 0: Lemma L104 reduces the pinned class to ten variables t_ijk on class-multisets, feasible dimension 4, and a vertex has at least four t_ijk zero. A multiplier is a quadratic phi applied to one row's (A_i),(B_i),(C_i); the coefficient it puts on type {i,j,k} is (orbit count) x psi(nu_j,nu_k) with psi the polarisation of phi. A nonzero right-hand side forbids the surviving type-set. Two families: DOUBLE-ROOT phi = (x - nu_r)^2, leaving three surviving types, nine identities; TWO-ROOT phi = (x - nu_a)(x - nu_b), leaving four, nine identities.

CLAIMS TO ATTACK.

U1 (the exhaustion). The nine double roots are the unique maximum-annihilation multipliers, and the three at each row span that row's whole multiplier space -- so the two-root family is a linear combination of them and the eighteen identities are the WHOLE per-row apparatus. Attack: is the span claim right (each row's multiplier space is 3-dimensional; are the three double roots at that row independent)? Does "spans" really imply the two-root identities carry no information beyond the double-root ones, given that the forbidding argument uses each identity's SURVIVING SET rather than its linear content?

U2 (post F45, the floor). Granting every right-hand side nonzero, the eighteen forbidden type-sets still leave supports uncut, so the per-row multiplier method has a floor and cannot close d=3 alone. Attack the ARGUMENT, not the number: is a floor guaranteed to exist, and is the reasoning from "eighteen identities exhaust the apparatus" to "no per-row route can do better" valid? Could a per-row constraint that is not of multiplier form exist?

U3 (the classification). Both families' right-hand sides factor as (a nonzero eigenvalue) x (a bracket (n-1)nu_j + theta), the bracket depending only on j and the factor never obstructing; so j=1 is always nonzero, j=3 vanishes exactly at Pi-saturation, j=2 is the only unresolved case. Verify the factorisation for both families from (A_i),(B_i),(C_i).

U4 (the dichotomy). Either (n-1)nu_2 + theta > 0, so the j=2 identities apply; or it is <= 0, forcing nu_2 < 0 and theta <= (n-1)|nu_2| < (n-1)|nu_3|, i.e. Pi strict, so the j=3 identities apply. No hypothesis on nu_2. Attack: is |nu_2| < |nu_3| really forced, and does the Pi-bound comparison go the right way?

U5 (what the counts are worth). The recorded numbers 194, 178-179 and 141 are enumerations, now labelled as scaffolding rather than findings. Attack: does any recorded CLAIM depend on a specific count rather than on the existence of a floor? If so, name it -- that claim is then computational and should be withdrawn or derived.

The derivations are the last four sections of findings/bounds-relaxations.md. Form your own view FIRST from the definitions.

REPORT to reviews/REVIEW_rNNN.md with NNN as named at launch. Verdict line first, one per claim, then the argument. One paragraph per line, never hard-wrapped; no backticks inside markdown link text.

LOGGING. agent_logs/<your-name>.log: first line identity and phase plan, a line per phase, a heartbeat every few minutes carrying live findings, DONE <summary> or FAILED <reason> as the first word of the last line.
