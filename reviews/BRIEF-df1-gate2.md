You are working inside a mathematics research programme at the repository root. The goal is in README.md: prove that P(W) = <W, Q(W)> with Q(W) = W^2 + W^# on the unit sphere of Weyl_n (Weyl tensors as symmetric operators on Lambda^2 R^n = so(n)) is maximised, for even n >= 12, by the Weyl tensor of S^{n/2} x S^{n/2}, granting the diagonal case. theta-critical means Q(W) = theta W; theta_0(n) = sqrt(2(n-1)(n-2))/n is the balanced product's value.

METHOD RULE, IN FORCE AND NOT NEGOTIABLE: this programme is ANALYSIS ONLY. Computation needs explicit per-task approval from the user, which you do not have. The single allowance is SCREENING a claim you are about to assert -- seconds of compute, on objects you construct yourself, reported as a screen and never as evidence for a positive claim. No searches, sweeps, optimisations, censuses or falsifier hunts. If you reach a point where you believe a computation is genuinely needed, write down what the run would DECIDE and what each outcome would MEAN, log it, and move on to what does not depend on it. Do not work around the block.

THE DELIVERABLE IS AN ARGUMENT A HUMAN CAN READ AND CHECK. Show every step. A claim you cannot derive is labelled PLAUSIBLE, never asserted.

RECORD DISCIPLINE. Before asserting anything, check it against what the record already proves -- findings/INDEX.md is the index, one line per result, and names the file each subject lives in. This cycle committed a claim that contradicted a theorem the record already held, and two reviewers had to kill it. Do not repeat that: a claim contradicting an indexed lemma is wrong until the lemma is refuted.

DO NOT COMMIT. Write your report to the path named below; the session folds it in.

PRIVACY. If you make any web request, the User-Agent / contact email is the placeholder aaa@aaa.com. Never any other address.

LOGGING. agent_logs/<your-name>.log: first line your identity and a phase plan, a line per phase, a heartbeat every few minutes carrying live findings (not "still working"), and DONE <summary> or FAILED <reason> at close, as the first word of the last line. Log a finding the moment you find it -- the session reads your log for content.

YOUR TASK. Adversarial review (Gate 2). BREAK the claims below. Argue from the definitions in findings/conventions.md and findings/second-order.md; read findings/diagonal-half.md for the diagonal locus. Return per claim CONFIRMED, PLAUSIBLE or REFUTED with the correction. DO NOT WRITE INTO findings/.

SETTING. W_n is the Weyl space: symmetric operators on Lambda^2 R^n = so(n) satisfying first Bianchi and Ricci-flatness (trace-free). Gamma = {diag(eps_1..eps_n) : eps_i = +-1, product = 1} is the sign-flip group in SO(n), acting on Lambda^2 by e_i ^ e_j -> eps_i eps_j e_i ^ e_j. A DIAGONAL critical point M is one whose eigenbivectors are the coordinate bivectors e_ij. L_e = e o (.) with e = M/theta and o the Weyl-algebra product; Lemma L24's criterion for a local maximum is L_e <= 1/2 off the orbit.

CLAIMS TO ATTACK.

E1 (the character types). On Sym^2(Lambda^2), the basis element e_ij (.) e_kl carries the Gamma-character eps_i eps_j eps_k eps_l, and exactly three cases occur: {i,j} = {k,l} giving the trivial character (the C(n,2) diagonal entries); {i,j} and {k,l} sharing exactly one index, giving character eps_j eps_k depending only on the unshared pair {j,k}, with n-2 basis elements per pair; and {i,j}, {k,l} disjoint, giving a four-index character with 3 basis elements per 4-subset. Attack: is the case list exhaustive; can two different overlap types give the same character; is Gamma really (Z/2)^{n-1} and does the determinant-one condition change any character; what happens at small n where some case is empty.

E2 (the Weyl cuts, block by block). Imposing first Bianchi and Ricci-flatness: the trivial block becomes the diagonal locus of dimension n(n-3)/2 (hollow symmetric arrays with zero row sums); each 4-set block drops from 3 to 2 by the single Bianchi relation alpha - beta + gamma = 0, with Ricci-flatness EMPTY there; each pair block drops from n-2 to n-3 by one Ricci relation, with Bianchi EMPTY there. Attack each emptiness claim separately -- is Bianchi really empty on the pair block, is Ricci really empty on the 4-set block -- and check the signs in the Bianchi relation.

E3 (the dimension identity). n(n-3)/2 + 2*C(n,4) + (n-3)*C(n,2) = n(n+1)(n+2)(n-3)/12 = dim W_n. Attack: verify independently at several n, and say whether the identity would still hold if one of E2's cuts were wrong -- i.e. how much evidence it actually is.

E4 (block-diagonality). At a diagonal critical point, e = M/theta is Gamma-fixed and o is O(n)-equivariant, so L_e is Gamma-equivariant and preserves each isotypic component; since the components listed are distinct characters, L_e is block-diagonal with one block of size n(n-3)/2, C(n,4) blocks of size 2 and C(n,2) blocks of size n-3. Attack: are the listed components really the ISOTYPIC components (do two different 4-subsets or two different pairs ever carry the SAME character, which would fuse their blocks); is e really Gamma-fixed at every diagonal critical point; does equivariance give block-diagonality or only block-triangularity.

E5 (the consequence). Hence the Hessian of P on the sphere, 6 theta (L_e - 1/2 Id) on W-perp, is block-diagonal the same way, and the largest block a non-diagonal direction can occupy has size n-3. Attack: the Hessian formula's hypotheses; whether W-perp is Gamma-stable; whether the orbit directions sit inside these blocks or across them.

The derivation is at reviews/DERIVE-df1.md. Form your own view FIRST from the definitions, then check its steps.

IF YOU HAVE TIME AFTER THE VERDICTS: derive the 2x2 4-set block in closed form in the six entries M_ij of its 4-subset, and say what it gives at S^p x S^q. That is the next owed step.

REPORT to reviews/REVIEW_rNNN.md with NNN as named at launch. Verdict line first, one per claim, then the argument. One paragraph per line, never hard-wrapped; no backticks inside markdown link text.

LOGGING. agent_logs/<your-name>.log: first line identity and phase plan, a line per phase, a heartbeat every few minutes carrying live findings, DONE <summary> or FAILED <reason> as the first word of the last line.
