You are working inside a mathematics research programme at the repository root. The goal is in README.md: prove that P(W) = <W, Q(W)> with Q(W) = W^2 + W^# on the unit sphere of Weyl_n (Weyl tensors as symmetric operators on Lambda^2 R^n = so(n)) is maximised, for even n >= 12, by the Weyl tensor of S^{n/2} x S^{n/2}, granting the diagonal case. theta-critical means Q(W) = theta W; theta_0(n) = sqrt(2(n-1)(n-2))/n is the balanced product's value.

METHOD RULE, IN FORCE AND NOT NEGOTIABLE: this programme is ANALYSIS ONLY. Computation needs explicit per-task approval from the user, which you do not have. The single allowance is SCREENING a claim you are about to assert -- seconds of compute, on objects you construct yourself, reported as a screen and never as evidence for a positive claim. No searches, sweeps, optimisations, censuses or falsifier hunts. If you reach a point where you believe a computation is genuinely needed, write down what the run would DECIDE and what each outcome would MEAN, log it, and move on to what does not depend on it. Do not work around the block.

THE DELIVERABLE IS AN ARGUMENT A HUMAN CAN READ AND CHECK. Show every step. A claim you cannot derive is labelled PLAUSIBLE, never asserted.

RECORD DISCIPLINE. Before asserting anything, check it against what the record already proves -- findings/INDEX.md is the index, one line per result, and names the file each subject lives in. This cycle committed a claim that contradicted a theorem the record already held, and two reviewers had to kill it. Do not repeat that: a claim contradicting an indexed lemma is wrong until the lemma is refuted.

DO NOT COMMIT. Write your report to the path named below; the session folds it in.

PRIVACY. If you make any web request, the User-Agent / contact email is the placeholder aaa@aaa.com. Never any other address.

LOGGING. agent_logs/<your-name>.log: first line your identity and a phase plan, a line per phase, a heartbeat every few minutes carrying live findings (not "still working"), and DONE <summary> or FAILED <reason> at close, as the first word of the last line. Log a finding the moment you find it -- the session reads your log for content.

YOUR TASK. Adversarial review (Gate 2). Argue from findings/conventions.md and findings/second-order.md (Lemmas L24, L120, L121, L123). Return per claim CONFIRMED, PLAUSIBLE or REFUTED. DO NOT WRITE INTO findings/.

SETTING. W is a unit maximiser of P on the Weyl space W_n. For an orthonormal frame F of R^n, M_ab = <W phi_ab, phi_ab> is the frame-diagonal part and R = W - diag(M). Lemma L24: <X, L_e X> <= 1/2 for X in W-perp off the orbit, e = W/theta. Lemma L120: Sym^2(Lambda^2) splits into sign-characters -- the trivial one being exactly the diagonal entries, plus C(n,2) pair blocks and C(n,4) 4-set blocks -- and complementary characters FUSE on the determinant-one sign group at n = 4, 6, 8, so the full sign group is used. Lemma L123: if X lies in a single character space and R has zero diagonal then <X, R o X> = 0. For a 4-subset write A = M_ab + M_cd, B = M_ac + M_bd, C = M_ad + M_bc and Sigma = A^2 + B^2 + C^2 - AB - BC - CA. Lemma L121 gives Sigma <= theta^2 at a coordinate-diagonal critical point. The record's vertex matrix is K = (W_abab) with budget t = ||K||_F^2 <= 2, t = 2 iff W is coordinate-diagonal in some frame; write t_F for that quantity computed in the frame F.

CLAIMS TO ATTACK.

I1 (the corrected criterion). Off the eigenframe Lemma L24's hypothesis X perp W FAILS, since <X,W> = <X,R> is generally nonzero. The corrected statement is <X, L_e X> <= (1 + c^2)/2 with c = <X,W>, sharp at X = W. Attack the derivation of the (1+c^2)/2 form, whether it needs L_e W = W or L_e W = theta W, and whether "sharp at X = W" is right.

I2 (the mass budget). The 4-set planes of distinct 4-subsets lie in distinct sign-characters, hence are mutually orthogonal, so the sum of rho^2 = <X,W>^2 over the C(n,4) subsets is at most ||W||^2 = 1 in every frame. Attack: are the planes really pairwise orthogonal (two different 4-subsets can share three indices -- do they still carry different characters); does the Bianchi cut from 3 to 2 dimensions preserve this; does the n = 4, 6, 8 fusion break it and is the n >= 9 restriction the right repair.

I3 (the unconditional corollary). rho^2 <= 1 always, so Sigma <= 4 theta^2 at every 4-subset of every frame at a maximiser. Attack the chain from I1 and I2 to this.

I4 (the sharpened corollary). rho = <X,R> <= ||R|| since X has zero diagonal, and ||W||^2 = ||diag(M)||^2 + ||R||^2, so with t_F = 2||diag(M)||^2 one gets rho^2 <= 1 - t_F/2 and Sigma <= theta^2 (2 - t_F/2)^2. At t_F = 2 the factor is 1 and this is exactly Lemma L121; at t_F = 0 it is 4. Attack: is t_F = 2||diag(M)||^2 the right relation to the record's t; is the decomposition orthogonal in the normalisation in use; is the t_F = 2 end really L121 or only formally so.

I5 (the soundness condition). Because (2 - t_F/2)^2 DECREASES in t_F, substituting the record's extremal t (a maximum over frames, so t >= t_F) would assert a STRONGER and unjustified bound -- at the extreme exactly the uncorrected Sigma <= theta^2 that I1 refutes. So the corollary must be read with the frame's own t_F, and this is soundness rather than sharpness. Attack this reasoning.

The derivation is reviews/DERIVE-mx1.md. Form your own view FIRST from the definitions.

REPORT to reviews/REVIEW_rNNN.md with NNN as named at launch. Verdict line first, one per claim, then the argument. One paragraph per line, never hard-wrapped; no backticks inside markdown link text.

LOGGING. agent_logs/<your-name>.log: first line identity and phase plan, a line per phase, a heartbeat every few minutes carrying live findings, DONE <summary> or FAILED <reason> as the first word of the last line.
