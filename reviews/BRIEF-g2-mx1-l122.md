You are working inside a mathematics research programme at the repository root. The goal is in README.md: prove that P(W) = <W, Q(W)> with Q(W) = W^2 + W^# on the unit sphere of Weyl_n (Weyl tensors as symmetric operators on Lambda^2 R^n = so(n)) is maximised, for even n >= 12, by the Weyl tensor of S^{n/2} x S^{n/2}, granting the diagonal case. theta-critical means Q(W) = theta W; theta_0(n) = sqrt(2(n-1)(n-2))/n is the balanced product's value.

METHOD RULE, IN FORCE AND NOT NEGOTIABLE: this programme is ANALYSIS ONLY. Computation needs explicit per-task approval from the user, which you do not have. The single allowance is SCREENING a claim you are about to assert -- seconds of compute, on objects you construct yourself, reported as a screen and never as evidence for a positive claim. No searches, sweeps, optimisations, censuses or falsifier hunts. If you reach a point where you believe a computation is genuinely needed, write down what the run would DECIDE and what each outcome would MEAN, log it, and move on to what does not depend on it. Do not work around the block.

THE DELIVERABLE IS AN ARGUMENT A HUMAN CAN READ AND CHECK. Show every step. A claim you cannot derive is labelled PLAUSIBLE, never asserted.

RECORD DISCIPLINE. Before asserting anything, check it against what the record already proves -- findings/INDEX.md is the index, one line per result, and names the file each subject lives in. This cycle committed a claim that contradicted a theorem the record already held, and two reviewers had to kill it. Do not repeat that: a claim contradicting an indexed lemma is wrong until the lemma is refuted.

DO NOT COMMIT. Write your report to the path named below; the session folds it in.

PRIVACY. If you make any web request, the User-Agent / contact email is the placeholder aaa@aaa.com. Never any other address.

LOGGING. agent_logs/<your-name>.log: first line your identity and a phase plan, a line per phase, a heartbeat every few minutes carrying live findings (not "still working"), and DONE <summary> or FAILED <reason> at close, as the first word of the last line. Log a finding the moment you find it -- the session reads your log for content.

YOUR TASK. Adversarial review (Gate 2). Argue from findings/conventions.md and findings/second-order.md (Lemmas L24, L120, L121, L122). Return per claim CONFIRMED, PLAUSIBLE or REFUTED. DO NOT WRITE INTO findings/.

SETTING. W_n is the Weyl space inside Sym^2(Lambda^2 R^n). For a frame F of R^n, Gamma = {diag(+-1)} is the full sign group, acting on Lambda^2 by e_a ^ e_b -> eps_a eps_b e_a ^ e_b. Sym^2(Lambda^2) decomposes into Gamma-character spaces (Lemma L120): the trivial one spanned by the diagonal entries e_ab (.) e_ab, the C(n,2) pair blocks, and the C(n,4) 4-set blocks of dimension 2 after Bianchi. The Weyl product is X o Y = (XY+YX)/2 + X#Y, is O(n)-equivariant, and L_W = W o (.). Lemma L24: at a maximiser L_e <= 1/2 on W-perp off the orbit, e = W/theta. Lemma L121: at a coordinate-diagonal M the 4-set block is traceless with spectrum +- (1/2)sqrt(A^2+B^2+C^2-AB-BC-CA)/theta in the opposite-pair sums A = M_ab + M_cd, B = M_ac + M_bd, C = M_ad + M_bc. Lemma L122: the pair block is -Delta^{(jk)}/2 - M_jk Id/2, a graph Laplacian.

CLAIMS TO ATTACK.

M1 (the vanishing lemma -- ATTACK THIS HARDEST). Let X lie in a single Gamma-character space and let R have zero diagonal in the frame F. Then <X, R o X> = 0. Argument given: R with zero diagonal has no trivial-character component, so R = sum over nontrivial chi of R_chi; o is O(n)-equivariant hence Gamma-equivariant as a bilinear map, so R_chi o X lies in the character chi * chi_X; distinct characters of an elementary abelian 2-group have orthogonal isotypic spaces; so every term is orthogonal to X. Attack every step: is the trivial character space REALLY exactly the diagonal entries; does Gamma-equivariance of a bilinear map really give that R_chi o X carries chi * chi_X (state the equivariance you are using and check it); are the isotypic spaces orthogonal for the inner product actually in use; does X need to be in a single character space or is that automatic; what happens when chi * chi_X = chi_X for a NONTRIVIAL chi -- is that possible in this group.

M2 (I12). Hence at a maximiser, for EVERY orthonormal frame F and every 4-subset of it, the frame-diagonal part M_ab = <W phi_ab, phi_ab> satisfies A^2 + B^2 + C^2 - AB - BC - CA <= theta^2, with no correction term. Attack: does the 4-set test direction really lie in a single character space AND satisfy Lemma L24's hypotheses (orthogonal to W, off the orbit); is Lemma L121 applicable to diag(M) when diag(M) is not itself a Weyl tensor or not critical; is theta the same in every frame.

M3 (the bilinear split). L_W = L_{diag(M)} + L_R exactly, with no remainder, because o is bilinear. Attack: is diag(M) + R really a decomposition inside the space where L is defined; does diag(M) lie in W_n at all, and does it matter.

M4 (Lemma L122's consequence). Lemma L24 on a pair block reads lambda_min(Delta^{(jk)} restricted to 1-perp) >= -(theta + M_jk), one condition per pair, where Delta^{(jk)} is the weighted graph Laplacian of the sectional matrix with rows and columns j,k deleted. Attack the sign, the restriction to 1-perp, and whether the orbit direction must be excluded separately.

M5 (scope). L121 and L122 need diagonality alone -- not criticality, not theta > 0, not Ricci-flatness. I12 depends on that scope: it applies L121 to diag(M) in a frame where W is not diagonal. Attack whether the scope claim is really true and whether I12's use of it is legitimate.

The derivations are reviews/DERIVE-mx1.md and reviews/DERIVE-df1.md (final sections). Form your own view FIRST from the definitions. If M1 is wrong, say exactly which step fails.

REPORT to reviews/REVIEW_rNNN.md with NNN as named at launch. Verdict line first, one per claim, then the argument. One paragraph per line, never hard-wrapped; no backticks inside markdown link text.

LOGGING. agent_logs/<your-name>.log: first line identity and phase plan, a line per phase, a heartbeat every few minutes carrying live findings, DONE <summary> or FAILED <reason> as the first word of the last line.
