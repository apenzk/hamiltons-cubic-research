You are working inside a mathematics research programme at the repository root. The goal is in README.md: prove that P(W) = <W, Q(W)> with Q(W) = W^2 + W^# on the unit sphere of Weyl_n (Weyl tensors as symmetric operators on Lambda^2 R^n = so(n)) is maximised, for even n >= 12, by the Weyl tensor of S^{n/2} x S^{n/2}, granting the diagonal case. theta-critical means Q(W) = theta W; theta_0(n) = sqrt(2(n-1)(n-2))/n is the balanced product's value.

METHOD RULE, IN FORCE AND NOT NEGOTIABLE: this programme is ANALYSIS ONLY. Computation needs explicit per-task approval from the user, which you do not have. The single allowance is SCREENING a claim you are about to assert -- seconds of compute, on objects you construct yourself, reported as a screen and never as evidence for a positive claim. No searches, sweeps, optimisations, censuses or falsifier hunts. If you reach a point where you believe a computation is genuinely needed, write down what the run would DECIDE and what each outcome would MEAN, log it, and move on to what does not depend on it. Do not work around the block.

THE DELIVERABLE IS AN ARGUMENT A HUMAN CAN READ AND CHECK. Show every step. A claim you cannot derive is labelled PLAUSIBLE, never asserted.

RECORD DISCIPLINE. Before asserting anything, check it against what the record already proves -- findings/INDEX.md is the index, one line per result, and names the file each subject lives in. This cycle committed a claim that contradicted a theorem the record already held, and two reviewers had to kill it. Do not repeat that: a claim contradicting an indexed lemma is wrong until the lemma is refuted.

DO NOT COMMIT. Write your report to the path named below; the session folds it in.

PRIVACY. If you make any web request, the User-Agent / contact email is the placeholder aaa@aaa.com. Never any other address.

LOGGING. agent_logs/<your-name>.log: first line your identity and a phase plan, a line per phase, a heartbeat every few minutes carrying live findings (not "still working"), and DONE <summary> or FAILED <reason> at close, as the first word of the last line. Log a finding the moment you find it -- the session reads your log for content.

YOUR TASK. Adversarial review (Gate 2) of two derivations. BREAK them. Argue from findings/conventions.md, findings/bounds.md (Lemma L70, L71, L73, the Pi-bound) and findings/bounds-relaxations.md (L104, L105). Return per claim CONFIRMED, PLAUSIBLE or REFUTED with the correction. DO NOT WRITE INTO findings/.

SETTING. W_n is the Weyl space; a theta-critical point has Q(W) = W^2 + W^# = theta W; theta_0(n) = sqrt(2(n-1)(n-2))/n is the balanced sphere product's value. h = lambda_max > 0 and m = |lambda_min| at unit norm. Recorded: Lemma L70 theta <= lambda_min + (n-2) lambda_max; the Pi-bound theta <= (n-1)|lambda_min|; Lemma L71 (saturation rigidity); Lemma L73 the ratio bound. At three distinct eigenvalues Lemma L104 reduces the pinned class to ten variables with feasible dimension 4.

CLAIMS TO ATTACK.

H1 (I25, the lower bounds). At every unit MAXIMISER of P on W_n, n >= 5: m >= theta_0(n)/(n-1) and h >= sqrt(2/((n-1)(n-2))), and both are attained simultaneously and exactly at the balanced sphere product. The proof: a maximiser has theta >= theta_0(n) because the balanced product is a unit competitor; the Pi-bound then gives m >= theta/(n-1), and Lemma L70 gives (n-2)h >= theta + m. Attack: is theta >= theta_0(n) legitimate for a maximiser (is the balanced product really a competitor at every n >= 5, including odd n, and is it unit-norm in the record's convention); are L70 and the Pi-bound unconditional at a maximiser; is the sharpness claim right; does anything break at small n.

H2 (I25, the item's stated form is weaker). The plan item's lambda_max >= theta_0(n)(n-2)/((n-2)^2 - 1) is true but weaker and not sharp -- 0.1249 against 0.1348 at n=12. Attack: is the stated form actually true, and is the comparison right.

H3 (I25, what is NOT derived). The item's claim of at least three negative eigenvalues is not established; the counting gives q >= 1/(m(h+m)), weaker than 3 at the balanced product. Attack: is that honest, or is there a short argument the note missed.

H4 (SP3d, the gradings). A Z_2 x Z_2 grading of so(n) is a pair of commuting involutions, i.e. a splitting R^n = V_1 + V_2 + V_3 + V_4, and the graded pieces are g00 = sum so(V_i), g01 = Hom(V_1,V_2) + Hom(V_3,V_4), g10 = Hom(V_1,V_3) + Hom(V_2,V_4), g11 = Hom(V_1,V_4) + Hom(V_2,V_3). Attack the assignment of Hom spaces to grades, and whether every Z_2 x Z_2 grading arises this way (inner vs outer automorphisms; n = 8 triality).

H5 (SP3d, six zeros). Merging two of the four pieces to get three eigenspaces can be done six ways and EVERY one gives exactly six vanishing types, in one of two patterns. Six against feasible dimension four is a DEGENERATE vertex, the d=3 analogue of the balanced product's degeneracy at d=2. Attack: recompute the vanishing sets yourself using the symmetric condition (a type is nonzero iff some triple of graded pieces drawn from its three eigenspaces sums to zero in the group); is "degenerate vertex" the right word given that passing a grading test is not an LP vertex certificate.

H6 (SP3d, the witness). The multiplicities (30,20,16) of DERIVE-t11's n=12 witness ARE realised by a Z_2 x Z_2 grading, from V-dimensions (0,2,2,8) giving grade dimensions (30,16,16,4) and merging two pieces; eighteen splittings do it. So the earlier exclusion of that witness is withdrawn in its conclusion as well as its argument. Attack the arithmetic and whether a V_i of dimension zero still gives a genuine Z_2 x Z_2 grading.

The derivations are reviews/DERIVE-mx2.md and reviews/DERIVE-sp3d.md. Form your own view FIRST, then check their steps.

REPORT to reviews/REVIEW_rNNN.md with NNN as named at launch. Verdict line first, one per claim, then the argument. One paragraph per line, never hard-wrapped; no backticks inside markdown link text.

LOGGING. agent_logs/<your-name>.log: first line identity and phase plan, a line per phase, a heartbeat every few minutes carrying live findings, DONE <summary> or FAILED <reason> as the first word of the last line.
