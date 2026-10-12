You are working inside a mathematics research programme at the repository root. The goal is in README.md: prove that P(W) = <W, Q(W)> with Q(W) = W^2 + W^# on the unit sphere of Weyl_n (Weyl tensors as symmetric operators on Lambda^2 R^n = so(n)) is maximised, for even n >= 12, by the Weyl tensor of S^{n/2} x S^{n/2}, granting the diagonal case. theta-critical means Q(W) = theta W; theta_0(n) = sqrt(2(n-1)(n-2))/n is the balanced product's value.

METHOD RULE, IN FORCE AND NOT NEGOTIABLE: this programme is ANALYSIS ONLY. Computation needs explicit per-task approval from the user, which you do not have. The single allowance is SCREENING a claim you are about to assert -- seconds of compute, on objects you construct yourself, reported as a screen and never as evidence for a positive claim. No searches, sweeps, optimisations, censuses or falsifier hunts. If you reach a point where you believe a computation is genuinely needed, write down what the run would DECIDE and what each outcome would MEAN, log it, and move on to what does not depend on it. Do not work around the block.

THE DELIVERABLE IS AN ARGUMENT A HUMAN CAN READ AND CHECK. Show every step. A claim you cannot derive is labelled PLAUSIBLE, never asserted.

RECORD DISCIPLINE. Before asserting anything, check it against what the record already proves -- findings/INDEX.md is the index, one line per result, and names the file each subject lives in. This cycle committed a claim that contradicted a theorem the record already held, and two reviewers had to kill it. Do not repeat that: a claim contradicting an indexed lemma is wrong until the lemma is refuted.

DO NOT COMMIT. Write your report to the path named below; the session folds it in.

PRIVACY. If you make any web request, the User-Agent / contact email is the placeholder aaa@aaa.com. Never any other address.

LOGGING. agent_logs/<your-name>.log: first line your identity and a phase plan, a line per phase, a heartbeat every few minutes carrying live findings (not "still working"), and DONE <summary> or FAILED <reason> at close, as the first word of the last line. Log a finding the moment you find it -- the session reads your log for content.

YOUR TASK. Adversarial review (Gate 2). The central claim is a closed form found by COMPUTATION and never proved -- your first job is to prove it or refute it from the definitions. Argue from findings/conventions.md and findings/second-order.md (Lemmas L24, L120, L121). Return per claim CONFIRMED, PLAUSIBLE or REFUTED. DO NOT WRITE INTO findings/.

SETTING. so(n) acts on Lambda^2 R^n; coordinate bivectors e_ab = e_a ^ e_b. A DIAGONAL Weyl operator M has the e_ab as eigenvectors, with sectional entries M_ab. The Weyl product is X o Y = (XY + YX)/2 + X#Y, where # is polarised from Hamilton's sharp; the definition of record is (W^#)_{alpha beta} = -tr(A_alpha W A_beta W)/2 with A_alpha = ad(v_alpha) acting on Lambda^2, implemented in scripts/lib/adversarial_check1.py as Q_full. Polarised: (M # X)_{alpha beta} = -[tr(A_alpha M A_beta X) + tr(A_alpha X A_beta M)]/4. L_M = M o (.). Lemma L120: at a diagonal critical point L_M is block diagonal over the sign characters, with C(n,2) PAIR blocks {j,k} of dimension n-3 inside W_n, spanned before the Ricci cut by f_i = e_{ji} (.) e_{ki} for i not in {j,k}.

CLAIMS TO ATTACK.

K1 (the closed form -- PROVE OR REFUTE IT). In the basis f_i, the pair block {j,k} of L_M is
   L[i,i] = (M_ji + M_ki)/2 - M_jk/4,      L[i,m] = sigma_i sigma_m M_im / 4  for i != m,
with sigma_i = (-1)^([i<j] + [i<k]) an orientation sign (e_{ji} means e_j ^ e_i whether or not j < i). Equivalently, in the sigma-oriented basis the block equals (1/2)diag(M_ji + M_ki) - (M_jk/4)Id + (1/4)M^{(jk)}, where M^{(jk)} is the hollow submatrix of M on the indices other than j and k. The session verified this to 9e-16 over 222 blocks (all pairs at n = 5,6,7,8, three random diagonal M each) but did NOT prove it. Derive it from the structure constants. The symmetrised half (MX + XM)/2 contributing (M_ji + M_ki)/2 on the diagonal is already done by hand; what is owed is that M# supplies -M_jk/4 on the diagonal and the off-diagonal term.

K2 (the orbit check). The orbit direction in this block is x_i = sigma_i(M_ji - M_ki), and it must be an eigenvector of L_M with eigenvalue theta/2 at a critical point. Test the closed form against this: does K1 give that eigenvalue? If not, K1 is wrong.

K3 (the sphere-product check). At S^p x S^q the within-factor pair blocks must have top eigenvalue (p-2)/(2(p-1)) for L_e = L_M/theta, the value r345 and r346 located there. Test K1 against it.

K4 (the consequence). If K1 holds, the second-order criterion on a pair block is a spectral condition on an (n-2)x(n-2) submatrix of the sectional matrix M -- nothing beyond M is needed. Attack: is the Ricci cut from n-2 to n-3 compatible with reading the block this way; does the criterion apply on the whole block or only off the orbit direction.

K5 (scope). The claim is stated for a diagonal Weyl operator. Attack: does it need criticality, or only diagonality; does it need theta > 0; what happens when a pair block's orbit direction vanishes.

The derivation is reviews/DERIVE-df1.md, final section. Form your own view FIRST from the definitions. If you reach a different closed form, say so explicitly and give the disagreeing entry.

REPORT to reviews/REVIEW_rNNN.md with NNN as named at launch. Verdict line first, one per claim, then the argument. One paragraph per line, never hard-wrapped; no backticks inside markdown link text.

LOGGING. agent_logs/<your-name>.log: first line identity and phase plan, a line per phase, a heartbeat every few minutes carrying live findings, DONE <summary> or FAILED <reason> as the first word of the last line.
