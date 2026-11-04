# The verification plan

**The queue of correctness rounds, and their verdicts.** One numbered result per round, run by [verification-loop](.claude/skills/verification-loop/SKILL.md). [plan.md](plan.md) is the research loop's task list and this file is the audit's; neither writes to the other.

**Every id below is a number in [findings/INDEX.md](findings/INDEX.md), which owns the numbering, the statement and the file that proves it**, this file carries the queue and the verdicts, and no description of any lemma.

**Checked means one thing: a completed round of three independent analytical verifiers, with every distinct finding adjudicated by two more.** A Gate 2 verdict from the research loop does not check a row; it lowers the row's exposure and moves it down the queue.

**The order is tier 0 first, then by exposure, citations across the record divided by one plus the number of [reviews/](reviews/) files naming the result.** High exposure is load-bearing and thinly checked. Counts are by number, so they miss a result cited by its statement; recount when the queue is re-ranked. Two rules override the order: a dependency is checked before its dependents, and a row marked `UNDECIDED, depends on <id>` re-enters at the top of tier 1.

**In flight:** none. **The loop is paused** at the user's request after L84-r2, with the research loop resumed.

**Last closed:** L84-r2 · `PROVEN` · [ROUND_L84r2](verification/ROUND_L84r2.md).

**Last closed:** L67-r2 · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L67r2](verification/ROUND_L67r2.md).

**Last closed:** L66-r2 · `PROVEN`, impact `CONTAINED` · [ROUND_L66r2](verification/ROUND_L66r2.md).

**Last closed:** L65-r2 · `PROVEN` · [ROUND_L65r2](verification/ROUND_L65r2.md).

**Last closed:** L64-r2 · `PROVEN, hypotheses corrected`, impact `NARROWS` · [ROUND_L64r2](verification/ROUND_L64r2.md).

**Last closed:** L20-r2 · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L20r2](verification/ROUND_L20r2.md).

**Last closed:** L115 · `PROVEN, hypotheses corrected`, impact `NARROWS` · [ROUND_L115](verification/ROUND_L115.md).

**Last closed:** L113 · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L113](verification/ROUND_L113.md).

**Last closed:** L111 · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L111](verification/ROUND_L111.md).

**Last closed:** L101 · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L101](verification/ROUND_L101.md) · v318, v319, v320, adjudicated v321 to v328, **one of four findings confirmed**, the eigenvalue labels defined, $P\equiv0$ on $V_{1/2}$ scoped to $n\ge9$ with its hypotheses, and $0.91$ removed.

**Last closed:** L100 · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L100](verification/ROUND_L100.md) · v311, v312, v313, adjudicated v314, v315 (A1) and v316, v317 (A2), **both findings withdrawn**, the $n=8$ padding step and the exact radius comparison now written.

**Last closed:** L91 · `HYPOTHESIS-DEBT`, narrowed, impact `CONTAINED` · [ROUND_L91](verification/ROUND_L91.md) · v308, v309, v310, **unanimous**, the bound true and its one step sampled, now written.

**Last closed:** L90 · `HYPOTHESIS-DEBT`, narrowed, impact `CONTAINED` · [ROUND_L90](verification/ROUND_L90.md) · v305, v306, v307, **unanimous**, the injectivity algebra and the cap proved and the lower rank a modular measurement, now stated so.

**Last closed:** L89 · `HYPOTHESIS-DEBT`, narrowed, impact `CONTAINED` · [ROUND_L89](verification/ROUND_L89.md) · v302, v303, v304, **unanimous**, the exactness step a theorem and its values two Observations', now stated so.

**Last closed:** L88 · `HYPOTHESIS-DEBT`, narrowed, impact `CONTAINED` · [ROUND_L88](verification/ROUND_L88.md) · v299, v300, v301, **unanimous**, the counts right on L83's table and argued only by a script, now derived by Schur on that table.

**Last closed:** L86 · `HYPOTHESIS-DEBT`, narrowed, impact `NARROWS` · [ROUND_L86](verification/ROUND_L86.md) · v296, v297, v298, **unanimous**, the parity mechanism right, its statement missing that $-I$ acts trivially and its stabiliser granted.

**Last closed:** L85 · `HYPOTHESIS-DEBT`, relabelled, impact `NARROWS` · [ROUND_L85](verification/ROUND_L85.md) · v293, v294, v295, **unanimous**, the $14$ a script output with only degree $2$ argued, now an Observation.

**Last closed:** L84 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L84](verification/ROUND_L84.md) · v290, v291, v292, **unanimous**, separation forced once $C_4$ is a generator, the heading now saying so.

**Last closed:** L83 · `HYPOTHESIS-DEBT`, relabelled, impact `NARROWS` · [ROUND_L83](verification/ROUND_L83.md) · v287, v288, v289, **unanimous**, every number read off a label right and the labels and multiplicities from a run, now an Observation.

**Last closed:** L09 · `HYPOTHESIS-DEBT`, narrowed, impact `NARROWS` · [ROUND_L09](verification/ROUND_L09.md) · v282, v283, v284, then v285 and v286 on the repair, **the triality transfer right and its target never shown to be $\mathbb{HP}^2$**, now stated at $\tau W_{3,5}$ with the identification owed.

**Last closed:** L03 · `GAP`, repaired, impact `NARROWS` · [ROUND_L03](verification/ROUND_L03.md) · v277, v278, v279, then v280 and v281 on the repair, **the Hessian right and the proof stopping at it**, now carried to local maximality and audited `PROVEN`.

**Last closed:** L67 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L67](verification/ROUND_L67.md) · v274, v275, v276, **two splits settled from the record and by derivation**, the spectrum right and its proof now written with every symbol defined.

**Last closed:** L66 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L66](verification/ROUND_L66.md) · v271, v272, v273, **split on one citation and settled from the filed source**, the chain right and $M(n)>0$ now cited to Nienhaus at $n\ge4$.

**Last closed:** L65 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L65](verification/ROUND_L65.md) · v268, v269, v270, **unanimous** with one split settled inline, the seed right at every $n\ge1$ and its pointer, heading and block counts wrong or unargued.

**Last closed:** L64 · `PROVEN, hypotheses corrected`, narrowed, impact `NARROWS` · [ROUND_L64](verification/ROUND_L64.md) · v265, v266, v267, **unanimous**, the three steps right and every claim around them overstated, now a two-part lemma with its hypothesis indexed by degree.

**Last closed:** L63 · `HYPOTHESIS-DEBT`, narrowed and relabelled, impact `NARROWS` · [ROUND_L63](verification/ROUND_L63.md) · v262, v263, v264, **unanimous**, the dimension a Lemma and the census an Observation, as the block's own audit note had graded them.

**Last closed:** L59 · `HYPOTHESIS-DEBT`, narrowed, impact `NARROWS` · [ROUND_L59](verification/ROUND_L59.md) · v259, v260, v261, **unanimous**, the adjunction's algebra right and every object it is stated in defined nowhere.

**Last closed:** L58 · `HYPOTHESIS-DEBT`, repaired and narrowed, impact `CONTAINED` · [ROUND_L58](verification/ROUND_L58.md) · v256, v257, v258, **unanimous**, the mechanism right and every witness asserted, now one witness derived from L46.

**Last closed:** L55 · `HYPOTHESIS-DEBT`, repaired, impact `CONTAINED` · [ROUND_L55](verification/ROUND_L55.md) · v253, v254, v255, **unanimous**, the inequality right, the extremiser's sign and the odd-$n$ strictness wrong as written, and uniqueness asserted in one clause, now proved in Lean.

**Last closed:** L94 · `HYPOTHESIS-DEBT`, repaired, impact `CONTAINED` · [ROUND_L94](verification/ROUND_L94.md) · v250, v251, v252, **unanimous**, the bound and one direction proved and the other resting on an attainment nobody wrote, now proved by compactness in Lean.

**Last closed:** L54 · `GAP`, repaired, impact `CONTAINED` · [ROUND_L54](verification/ROUND_L54.md) · v245, v246, v247, then v248 and v249 on the repair, **the mathematics right and six steps argued nowhere**, each now written and audited `PROVEN` by two fresh verifiers.

**Last closed:** L49 · `GAP`, narrowed, impact `NARROWS` · [ROUND_L49](verification/ROUND_L49.md) · v242, v243, v244, **unanimous**, the characterisation proved and machine-checked and every clause built on it either false as written or argued nowhere.

**Last closed:** L46 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L46](verification/ROUND_L46.md) · v239, v240, v241, **split on one step and settled by derivation**, the cited lemma not covering the stated object and the route written beside it covering it with filed imports.

**Last closed:** L45 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L45](verification/ROUND_L45.md) · v236, v237, v238, the census and coupling rebuilt by hand, the statement omitting the symmetry, dimension and normalisation its proof uses, and a Lean theorem whose conclusion was its hypothesis.

**Last closed:** L43 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L43](verification/ROUND_L43.md) · v233, v234, v235, **unanimous**, the collapse an identity on the whole slice as the block says, and the canon placing its constant off the boundary that forces it.

**Last closed:** L42 · `PROVEN`, repaired, impact `CONTAINED` · [ROUND_L42](verification/ROUND_L42.md) · v230, v231, v232, **unanimous**, the proof untouched and three passages beside it wrong, and the Lean `sorry` under it discharged in the same round.

**Last closed:** L41 · `BROKEN`, repaired, impact `NARROWS` · [ROUND_L41](verification/ROUND_L41.md) · v227, v228, v229, **unanimous**, the mathematics surviving and three clauses of its statement not, with the corrected identities already tabled in the conventions file the canon contradicted.

**Last closed:** L39 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L39](verification/ROUND_L39.md) · v224, v225, v226, **unanimous**, and the round's annotations failed where its prose held: two assert falsehoods, one of them the record's own reason for distrusting the formula, and that reason was circular.

**Last closed:** L38 · `PROVEN, hypotheses corrected`, repaired, impact `NARROWS` · [ROUND_L38](verification/ROUND_L38.md) · v221, v222, v223, **one word in the title denied what the mathematics says**, both families exceeding the target at their own $n$ at the small members and the cap being attained at the conjectured maximiser.

**Last closed:** L01 · `HYPOTHESIS-DEBT`, repaired, impact `CONTAINED` · [ROUND_L01](verification/ROUND_L01.md) · v218, v219, v220, **the row's status was stated five incompatible ways across four files**, and the edge the block named as closing $n=12$ admits the corner it was said to exclude.

**Last closed:** L71 · `PROVEN, hypotheses corrected`, repaired, impact `NARROWS` · [ROUND_L71](verification/ROUND_L71.md) · v215, v216, v217, **the recorded circularity is genuinely rescued**, and the defect is one of two uniqueness routes that the block refutes two clauses after printing it.

**Last closed:** L37 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L37](verification/ROUND_L37.md) · v212, v213, v214, **the first unanimous pass of this run**, on the first block that was a written proof rather than an annotation stack, and it still owed six corrections including a reversed implication.

**Last closed:** L30 · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L30](verification/ROUND_L30.md) · v209, v210, v211, **the proof establishes every clause except the one the lemma exists for**, and the counting hypothesis it was stated with breaks it at both ends.

**Last closed:** L13 · `BROKEN`, repaired, impact `CONTAINED` · [ROUND_L13](verification/ROUND_L13.md) · v206, v207, v208, **a find-and-replace ran through the argument it was correcting**, leaving three consecutive sentences that contradict each other, and the figure it replaced was the better one.

**Last closed:** L22 · `HYPOTHESIS-DEBT`, repaired, impact `CONTAINED` · [ROUND_L22](verification/ROUND_L22.md) · v203, v204, v205, **a flag the record raised against itself is closed by refuting the sentence that caused it**, and the round's own brief was refuted by all three verifiers.

**Last closed:** L21 · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L21](verification/ROUND_L21.md) · v200, v201, v202, **the structural half promoted from measurement to theorem by three independent hand derivations**, and the one unproved input narrowed to a single admissible dimension of evidence.

**Last closed:** L26 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L26](verification/ROUND_L26.md) · v197, v198, v199, the algebra rebuilt three times and unanimous, **the record's own explanation of a past miss refuted**, and a citation misquote repaired that also discharges a debt standing against [ROUND_L27](verification/ROUND_L27.md).

**Last closed:** L48 · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L48](verification/ROUND_L48.md) · v191, v192, v193, the lemma's algebra confirmed and $B$ derived twice, while the Theorem owed a third hypothesis and its equality clause excluded a space that attains the bound. **The round also found a `BROKEN` in [L46](results.md)'s entry.**

**Last closed:** L44 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L44](verification/ROUND_L44.md) · v188, v189, v190, **the debt two verifiers booked does not exist**, the cited lemma stating the needed direction as its first clause while the record's own note paraphrased it one-directionally.

**Last closed:** L17 · `PROVEN, hypotheses corrected`, repaired, impact `NARROWS` · [ROUND_L17](verification/ROUND_L17.md) · v185, v186, v187, unanimous, **the record stated this lemma nowhere**, its argument living in the lab notebook, and its decisive constant sharing a name whose tabled meaning falsifies it.

**Last closed:** L28 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L28](verification/ROUND_L28.md) · v182, v183, v184, **no error anywhere in the block**, and all three of its independent checks weaker than claimed. *The first dispatch, v179–v181, died without filing.*

**Last closed:** L47 · `GAP`, repaired, impact `NARROWS` · [ROUND_L47](verification/ROUND_L47.md) · v176, v177, v178, unanimous, **nothing refuted and every value reproduced by hand**, while the argument for the lemma's whole branch lives in a script and in no prose file.

**Last closed:** L31 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L31](verification/ROUND_L31.md) · v173, v174, v175, **the first result in the audit whose mathematics no verifier touched**; what was wrong was that the half seven consumers cite was not in the statement.

**Last closed:** L11 · `BROKEN`, repaired, impact `PROPAGATES` · [ROUND_L11](verification/ROUND_L11.md) · v170, v171, v172, unanimous, the block contradicted itself in consecutive paragraphs, and **both paragraphs were true of different dimensions**.

**Last closed:** L32 · `GAP`, repaired, impact `NARROWS` · [ROUND_L32](verification/ROUND_L32.md) · v167, v168, v169, two `GAP` against one correction, unanimous on the mathematics, and **the round refuted the diagnosis its own predecessor had written hours earlier**.

**Last closed:** L33 · `GAP`, repaired, impact `NARROWS` · [ROUND_L33](verification/ROUND_L33.md) · v164, v165, v166, two `GAP` against one `PROVEN`, agreeing on every step and splitting only on where one debt is booked.

**Last closed:** L34 · `PROVEN, hypotheses corrected`, repaired, impact `NARROWS` · [ROUND_L34](verification/ROUND_L34.md) · v161, v162, v163, unanimous, both witnesses rebuilt cold by all three, and the two sentences proving the statement are false at its own $m=6$ witness.

**Last closed:** L19 · `WITHDRAWN` before this round opened, propagated · [ROUND_L19](verification/ROUND_L19.md) · no verifiers, the entry carried two Gate 2 verdicts of `NO CHECKABLE STATEMENT` already, and the round's work was the sweep below.

**Last closed:** L05 · `GAP`, repaired, impact `NARROWS` · [ROUND_L05](verification/ROUND_L05.md) · v158, v159, v160, three `GAP`s, the census compares against the balanced product and against nothing else, and its one split settled by derivation rather than by an adjudication pair.

**Last closed:** L24 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L24](verification/ROUND_L24.md) · v155, v156, v157, unanimous, the Hessian identity confirmed by four independent routes, and every defect in the apparatus around it.

**Last closed:** L35 · `GAP`, repaired, impact `NARROWS` · [ROUND_L35](verification/ROUND_L35.md) · v152, v153, v154, two `HYPOTHESIS-DEBT` against one `GAP`, split on whether an absent middle is a missing input or a missing proof.

**Last closed:** L29 · `PROVEN, hypotheses corrected`, repaired, impact `PROPAGATES` · [ROUND_L29](verification/ROUND_L29.md) · v149, v150, v151.

**Last closed:** L69 · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L69](verification/ROUND_L69.md) · v146, v147, v148.

**Last closed:** L08 · `BROKEN`, repaired, impact `PROPAGATES` · [ROUND_L08](verification/ROUND_L08.md) · v143, v144, v145, unanimous.

**Last closed:** L70 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L70](verification/ROUND_L70.md) · v140, v141, v142, unanimous.

**Last closed:** L23 · `PROVEN, hypotheses corrected`, repaired, impact `PROPAGATES` · [ROUND_L23](verification/ROUND_L23.md) · v137, v138, v139.

**Last closed:** L27 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L27](verification/ROUND_L27.md) · v134, v135, v136.

**Last closed:** L36 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L36](verification/ROUND_L36.md) · v131, v132, v133, unanimous.

**Last closed:** L50 · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L50](verification/ROUND_L50.md) · v128, v129, v130, unanimous.

**Last closed:** L18 · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L18](verification/ROUND_L18.md) · v125, v126, v127, unanimous.

**Last closed:** L15 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L15](verification/ROUND_L15.md) · v122, v123, v124, unanimous.

**Last closed:** L20 · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L20](verification/ROUND_L20.md) · v119, v120, v121, unanimous.

**Last closed:** L07 · `BROKEN`, repaired, impact `PROPAGATES` · [ROUND_L07](verification/ROUND_L07.md) · v116, v117, v118.

**Last closed:** L68 · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L68](verification/ROUND_L68.md) · v113, v114, v115, unanimous.

**Last closed:** L52 · `BROKEN`, repaired, impact `PROPAGATES` · [ROUND_L52](verification/ROUND_L52.md) · v110, v111, v112.

**Last closed:** L10 · `BROKEN`, repaired, impact `PROPAGATES` · [ROUND_L10](verification/ROUND_L10.md) · v107, v108, v109, unanimous.

**Last closed:** L04 · `BROKEN`, repaired, impact `PROPAGATES` · [ROUND_L04b](verification/ROUND_L04b.md) · v104, v105, v106.

**Last closed:** L57 · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L57](verification/ROUND_L57.md) · v101, v102, v103, the first dispatch, v98/v99/v100, was lost without filing.

**Last closed:** L02 · `GAP`, repaired, impact `NARROWS` · [ROUND_L02](verification/ROUND_L02.md) · v95, v96, v97 (two `GAP` against one `PROVEN, hypotheses corrected`, split on what a block owes rather than on any value.

**Last closed:** L00 · `GAP`, repaired, impact `NARROWS` · [ROUND_L00](verification/ROUND_L00b.md) · v92, v93, v94, unanimous.

**Last closed:** L43-arg · `GAP`, partly repaired, impact `NARROWS` · [ROUND_L43-arg](verification/ROUND_L00r2.md) · v89, v90, v91.

**Last closed:** L146-r2 · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L146-r2](verification/ROUND_L146r2.md) · v86, v87, v88.

**Last closed:** L149-r2 · `HYPOTHESIS-DEBT`, partly repaired, impact `CONTAINED` · [ROUND_L149-r2](verification/ROUND_L149r2.md) · v81, v82, v83, the kink adjudicated v84, v85.

**Last closed:** L147-r2 · `BROKEN`, repaired, impact `NARROWS` · [ROUND_L147-r2](verification/ROUND_L147r2.md) · v54, v55, v56.

**[ROUND_L147-r2](verification/ROUND_L147r2.md) remains open** at phase 0 with its brief built and **v54, v55, v56 still reserved**, those numbers are permanent addresses and are not reused. *Resuming it starts by dispatching those three.* **Then:** L149-r2, L146-r2.

**Last closed:** L148-r2 · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L148-r2](verification/ROUND_L148r2.md) · v51, v52, v53.

**Last closed:** L145 · `BROKEN`, repaired, impact `NARROWS` · [ROUND_L145](verification/ROUND_L145.md) · v48, v49, v50, unanimous.

**Last closed:** L149-F · impact **`FATAL`** · [ROUND_L149-F](verification/ROUND_L149F.md) · v46, v47.

**Last closed:** L152 · `PROVEN, hypotheses corrected` for the surviving identity, the entry staying `REFUTED AS STATED` · [ROUND_L152](verification/ROUND_L152.md) · v43, v44, v45, unanimous.

**Last closed:** L158 · `GAP`, repaired, impact `CONTAINED` · [ROUND_L158](verification/ROUND_L158.md) · v38, v39, v40, adjudicated v41, v42.

**Last closed:** L157 · `BROKEN`, partly repaired, impact **`FATAL`** · [ROUND_L157](verification/ROUND_L157.md) · v33, v34, v35, D6 adjudicated v36, v37.

**Last closed:** L87 · `GAP`, repaired, impact `NARROWS` · [ROUND_L87](verification/ROUND_L87.md) · v76, v77, v78, adjudicated v79, v80. Every closed round is one line under [Checked](#checked); **Tier C below is the live order.**

## Queue changes

- **2026-09-14, the loop paused after L84-r2 at the user's request.** *Most open boxes are repair audits of results off Problem P's main line, and the user returned the session to the research loop. When the loop resumes, the queue is reordered by relevance to P, with [L21](findings/route-a.md) first, since the L20 tube exclusion rests on its eigenvalue bound.*

- **2026-09-14, L20 requeued by [ROUND_L100](verification/ROUND_L100.md).** *Its printed bracket did not order $\sin(0.5748)$ against $s^*$, and the round replaced it with an exact comparison derived by two adjudicators, which is new text and re-enters unchecked.*
- **2026-09-14, eight ids requeued and a process debt recorded.** *Rounds L64, L65, L66, L67, L84, L88, L89 and L91 wrote new proof text and ticked the id in the same commit, where phase 5 makes a repair a new result that re-enters unchecked; L03 and L09 had their repairs audited by two fresh verifiers and stay checked. **Every round from L64 to L91 also skipped phase 3**, adjudicating no finding with two fresh verifiers, so each confirmed finding in those round files rests on the three original reports alone. That debt is recorded here, and the requeued rounds carry it first.*
- **2026-09-14, the candidate class queued.** *The class named by round L87 lists Gate 2 `GAP` rows whose repair lists were recorded and never applied; its rows had no boxes, so no round would ever reach them. The thirteen Lemmas enter after tier 3 in index order, and the two Observations, L98 and L144, join the hygiene pass.*
- **2026-09-14, L03 and L09 moved from the Observations pass to tier 1 by [ROUND_L67](verification/ROUND_L67.md)'s close.** *The pass checks how a numerically verified claim is cited, and both rows now read Lemma in [INDEX-results.md](findings/INDEX-results.md), L03 proved at every even $n\ge8$ and L09 at $n=8$, so each has a proof to audit and takes a three-verifier round. L03 goes first, being the most cited row.*
- **2026-09-14, L94 queued by [ROUND_L54](verification/ROUND_L54.md).** *L94 had no round, no written proof and a `sorry` for its Lean statement, while L54 rested a step on it. The rule that a dependency is checked before its dependents is met the other way here: L54's repair writes the per-frame bound itself, so L94 is queued to be checked against it rather than ahead of it.*
- **2026-09-07, a duplicate L32 box removed.** *[ROUND_L33](verification/ROUND_L33.md) promoted L32 by inserting a new tick-box at the head of tier 2 rather than moving the existing one, so the queue carried the id twice and the Stop hook read the unticked copy as the next round after L32 had closed.* **A promotion moves a row; it does not add one.**

- **2026-09-07, L32 promoted to the head of the queue by [ROUND_L33](verification/ROUND_L33.md).** *Three verifiers found the same hole in it: its written proof reaches neither branch at corank $1$, the degenerate clause invoking $\mathfrak{so}(\ker x)$ which is zero there, and the root argument failing at odd $m$ where the algebra is $B_p$.* **The rule that a dependency is checked before its dependents applies**, and L33 is not the only consumer. *Its canonical statement also still carries a refuted form while [results.md](results.md) and [report/](report/) carry a different repair.*

- **2026-09-07, L19 closes without a verifier dispatch, and L14 is repaired alongside it.** *The entry already carried two Gate 2 verdicts of `NO CHECKABLE STATEMENT` and is headed `WITHDRAWN` in [problem.md](findings/problem.md); three verifiers have no proposition to attack.* **What was live was the propagation**: [results.md](results.md) headed it `Lemma L19` over a heading with no statement under it and asserted all three bundled claims in its landscape bullet. **Three consecutive rounds had found the same shape, a repair reaching [findings/](findings/) and not [results.md](results.md), so this round swept all ten withdrawn blocks instead of repairing a fourth.** Eight had propagated; L19 and L14 had not, both presenting as an empty heading with a bare proof pointer. *A one-in-five failure rate, which is a defect and not the collapse three instances in a row suggested.*

**L87 entered tier 1 on 2026-09-06 by transfer from round L62**, which found a defect on material that is not L62's argument. The transfer carries the question and no verdict, since no adjudication ran on it.

- **2026-09-05, L152 demoted below L156, L157, L158.** *It is already `REFUTED AS STATED` and superseded; what survives is the single identity $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$, which is the triangle equality on a circle **together with $\lvert\lambda_-\rvert=g_n$**, a theorem, not the definition the entry calls it, since $\mathop{\mathrm{mult}}(\lambda_-)=m^2>m(m-1)$ is what forces $\lambda_+>\lvert\lambda_-\rvert$.* **A round on a refuted entry buys less than a round on a live one**, and L156–L158 all carry claims the chain still uses. *Opening its round did produce one thing: the anchor sweep below.*

- **2026-09-05, the twice-audited entries drop below the never-audited ones.** *L149 closed `GAP` twice across [ROUND_L149](verification/ROUND_L149.md) and [ROUND_L149r](verification/ROUND_L149r.md), five verifiers between them; L146 closed `PROVEN, hypotheses corrected` unanimously.* **Their corrected texts are genuinely unaudited and stay in the queue as `L149-r2` and `L146-r2`, but behind L147, L148, L152, L156, L157 and L158, which have had no verification round at all.** *The marginal reading is worth more where nothing has read yet; a sixth verifier on L149's text buys less than a first on L147's.*

- **2026-09-05, the tube-radius constant chain jumps the queue, at the user's direction.** *L146, L147, L148, L149, L152, L156, L157, L158 are audited as a block before tier 0 resumes.* **The reason is a defect rate, not a suspicion**: every one of the six examined during the research loop on 2026-09-05 carried a defect, [L149](findings/second-order.md)'s twice under different reviewers, and two of them had already passed Gate 2, *so the existing passes checked conclusions and not the direction of intermediate inequalities.* **Tier 0's L00, L02, L57 keep their order and resume after the block.**

## To check

**One box per open result. When its round closes the result leaves this list and its verdict goes under [Checked](#checked) as one line.** Tier 0 is hand-picked (the statements that fix what is being proved) and is the only part of the order not computed.

### Tier 1, load-bearing, cited 8 or more


### Tier 3, leaves, cited 2 or fewer

- [ ] **L64**, *repair audit owed: round L64-r2 restated the $SO$ clause, the finiteness of $k_B(d)$ and post F32's Theorem 2.11 paragraph*
- [ ] **L66**, *repair audit owed: round L66-r2 replaced a run with a closed-form witness*

### Candidate class, Gate 2 `GAP` rows whose repair lists were never applied

*Queued by [ROUND_L09](verification/ROUND_L09.md)'s phase 0 from the candidate class named by round L87, in index order. L02 is already checked, and L53, L59, L61, L63 and L64 closed in their own rounds.*

**Two defects shared by the class, for each round's phase 0.** *Nine of the thirteen have no entry in [results.md](results.md) at all: L84, L88, L90, L91, L100, L101, L111, L113, L115. And the four that do (L83, L85, L86, L89) carry detail headings with their LaTeX lowercased, `\mathrm{sym}^3(\mathcal w_5)` for `\mathrm{Sym}^3(\mathcal W_5)`, `o(5)`, `v_\lambda^h`, a transcription defect in the canon that each round repairs for its own id.*

- [ ] **L88**, *repair audit owed: this session rewrote its proof, which re-enters unchecked*
- [ ] **L89**, *repair audit owed: this session rewrote its proof, which re-enters unchecked*
- [ ] **L91**, *repair audit owed: this session rewrote its proof, which re-enters unchecked*
- [ ] **L100**, *repair audit owed: round L100 wrote its padding step and restated it*
- [ ] **L101**, *repair audit owed: round L101 restated it in three parts*
- [ ] **L111**, *repair audit owed: round L111 restated it with an exact strictness witness*
- [ ] **L113**, *repair audit owed: round L113 restated it with its class written out and a proof*
- [ ] **L115**, *repair audit owed: round L115 narrowed it to what is proved and recorded the rest as open*

### Conjectures, outside the loop until one is proved

**A conjecture has no proof to check.** One enters tier 1 on the day it gets one, and its round is what turns it into a lemma.

- **L06**, **L14**, **L16**, no box: nothing to verify yet.

## Checked

**One line per closed result: the id, the verdict, and the round file, which holds the verifiers, the findings and what changed.**

- **L84-r2** · `PROVEN` · [ROUND_L84r2](verification/ROUND_L84r2.md)
- **L67-r2** · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L67r2](verification/ROUND_L67r2.md)
- **L66-r2** · `PROVEN`, impact `CONTAINED` · [ROUND_L66r2](verification/ROUND_L66r2.md)
- **L65-r2** · `PROVEN` · [ROUND_L65r2](verification/ROUND_L65r2.md)
- **L64-r2** · `PROVEN, hypotheses corrected`, impact `NARROWS` · [ROUND_L64r2](verification/ROUND_L64r2.md)
- **L20-r2** · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L20r2](verification/ROUND_L20r2.md)
- **L115** · `PROVEN, hypotheses corrected`, impact `NARROWS` · [ROUND_L115](verification/ROUND_L115.md)
- **L113** · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L113](verification/ROUND_L113.md)
- **L111** · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L111](verification/ROUND_L111.md)
- **L101** · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L101](verification/ROUND_L101.md)
- **L100** · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L100](verification/ROUND_L100.md)
- **L91** · `HYPOTHESIS-DEBT`, narrowed, impact `CONTAINED` · [ROUND_L91](verification/ROUND_L91.md)
- **L90** · `HYPOTHESIS-DEBT`, narrowed, impact `CONTAINED` · [ROUND_L90](verification/ROUND_L90.md)
- **L89** · `HYPOTHESIS-DEBT`, narrowed, impact `CONTAINED` · [ROUND_L89](verification/ROUND_L89.md)
- **L88** · `HYPOTHESIS-DEBT`, narrowed, impact `CONTAINED` · [ROUND_L88](verification/ROUND_L88.md)
- **L86** · `HYPOTHESIS-DEBT`, narrowed, impact `NARROWS` · [ROUND_L86](verification/ROUND_L86.md)
- **L85** · `HYPOTHESIS-DEBT`, relabelled, impact `NARROWS` · [ROUND_L85](verification/ROUND_L85.md)
- **L84** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L84](verification/ROUND_L84.md)
- **L83** · `HYPOTHESIS-DEBT`, relabelled, impact `NARROWS` · [ROUND_L83](verification/ROUND_L83.md)
- **L09** · `HYPOTHESIS-DEBT`, narrowed, impact `NARROWS` · [ROUND_L09](verification/ROUND_L09.md)
- **L03** · `GAP`, repaired, impact `NARROWS` · [ROUND_L03](verification/ROUND_L03.md)
- **L67** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L67](verification/ROUND_L67.md)
- **L66** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L66](verification/ROUND_L66.md)
- **L65** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L65](verification/ROUND_L65.md)
- **L64** · `PROVEN, hypotheses corrected`, narrowed, impact `NARROWS` · [ROUND_L64](verification/ROUND_L64.md)
- **L63** · `HYPOTHESIS-DEBT`, narrowed and relabelled, impact `NARROWS` · [ROUND_L63](verification/ROUND_L63.md)
- **L59** · `HYPOTHESIS-DEBT`, narrowed, impact `NARROWS` · [ROUND_L59](verification/ROUND_L59.md)
- **L58** · `HYPOTHESIS-DEBT`, repaired and narrowed, impact `CONTAINED` · [ROUND_L58](verification/ROUND_L58.md)
- **L55** · `HYPOTHESIS-DEBT`, repaired, impact `CONTAINED` · [ROUND_L55](verification/ROUND_L55.md)
- **L94** · `HYPOTHESIS-DEBT`, repaired, impact `CONTAINED` · [ROUND_L94](verification/ROUND_L94.md)
- **L54** · `GAP`, repaired, impact `CONTAINED` · [ROUND_L54](verification/ROUND_L54.md)
- **L49** · `GAP`, narrowed, impact `NARROWS` · [ROUND_L49](verification/ROUND_L49.md)
- **L46** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L46](verification/ROUND_L46.md)
- **L45** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L45](verification/ROUND_L45.md)
- **L43** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L43](verification/ROUND_L43.md), [ROUND_L44](verification/ROUND_L44.md)
- **L42** · `PROVEN`, repaired, impact `CONTAINED` · [ROUND_L42](verification/ROUND_L42.md)
- **L29** · `PROVEN, hypotheses corrected`, repaired, impact `PROPAGATES` · [ROUND_L29](verification/ROUND_L29.md)
- **L69** · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L69](verification/ROUND_L69.md)
- **L08** · `BROKEN`, repaired, impact `PROPAGATES` · [ROUND_L08](verification/ROUND_L08.md)
- **L70** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L70](verification/ROUND_L70.md)
- **L23** · `PROVEN, hypotheses corrected`, repaired, impact `PROPAGATES` · [ROUND_L23](verification/ROUND_L23.md), [ROUND_L04](verification/ROUND_L04b.md)
- **L41** · `BROKEN`, repaired, impact `NARROWS` · [ROUND_L41](verification/ROUND_L41.md)
- **L39** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L39](verification/ROUND_L39.md)
- **L38** · `PROVEN, hypotheses corrected`, repaired, impact `NARROWS` · [ROUND_L38](verification/ROUND_L38.md)
- **L01** · `HYPOTHESIS-DEBT`, repaired, impact `CONTAINED` · [ROUND_L01](verification/ROUND_L01.md)
- **L71** · `PROVEN, hypotheses corrected`, repaired, impact `NARROWS` · [ROUND_L71](verification/ROUND_L71.md)
- **L37** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L37](verification/ROUND_L37.md)
- **L30** · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L30](verification/ROUND_L30.md)
- **L13** · `BROKEN`, repaired, impact `CONTAINED` · [ROUND_L13](verification/ROUND_L13.md)
- **L22** · `HYPOTHESIS-DEBT`, repaired, impact `CONTAINED` · [ROUND_L22](verification/ROUND_L22.md)
- **L21** · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L21](verification/ROUND_L21.md)
- **L26** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L26](verification/ROUND_L26.md)
- **L27** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L27](verification/ROUND_L27.md)
- **L36** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L36](verification/ROUND_L36.md)
- **L50** · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L50](verification/ROUND_L50.md)
- **L18** · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L18](verification/ROUND_L18.md)
- **L15** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L15](verification/ROUND_L15.md), [ROUND_L07](verification/ROUND_L07.md)
- **L20** · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L20](verification/ROUND_L20.md)
- **L07** · `BROKEN`, repaired, impact `PROPAGATES` · [ROUND_L07](verification/ROUND_L07.md)
- **L68** · `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED` · [ROUND_L68](verification/ROUND_L68.md)
- **L52** · `BROKEN`, repaired, impact `PROPAGATES` · [ROUND_L52](verification/ROUND_L52.md)
- **L10** · `BROKEN`, repaired, impact `PROPAGATES` · [ROUND_L10](verification/ROUND_L10.md)
- **[INDEX-values.md](findings/INDEX-values.md)'s searchability** and **[bispectral.md](findings/bispectral.md)'s joint-body accounting** · `NARROWS`, repaired directly, entered by a lean-loop round
- **L04** · `BROKEN`, repaired, impact `PROPAGATES` · [ROUND_L04b](verification/ROUND_L04b.md)
- **L57** · `HYPOTHESIS-DEBT`, repaired, impact `NARROWS` · [ROUND_L57](verification/ROUND_L57.md)
- **L02** · `GAP`, repaired, impact `NARROWS` · [ROUND_L02](verification/ROUND_L02.md)
- **L00** · `GAP`, repaired, impact `NARROWS` · [ROUND_L00](verification/ROUND_L00.md), [ROUND_L00b](verification/ROUND_L00b.md)
- **L43-arg** · `GAP`, partly repaired, impact `NARROWS` · [ROUND_L43-arg](verification/ROUND_L00r2.md)
- **L146-r2** · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L146-r2](verification/ROUND_L146r2.md)
- **L149-r2** · `HYPOTHESIS-DEBT`, partly repaired, impact `CONTAINED` · [ROUND_L149-r2](verification/ROUND_L149r2.md)
- **L147-r2** · `BROKEN`, repaired, impact `NARROWS` · [ROUND_L147-r2](verification/ROUND_L147r2.md)
- **L87** · `GAP`, repaired, impact `NARROWS` · [ROUND_L87](verification/ROUND_L87.md)
- **L62** · `PROVEN, hypotheses corrected`, impact `CONTAINED`, one `HYPOTHESIS-DEBT` · [ROUND_L62](verification/ROUND_L62.md)
- **L61** · `PROVEN, hypotheses corrected` for the bound, `BROKEN` for the equality clause, impact `CONTAINED` · [ROUND_L61](verification/ROUND_L61.md)
- **L148-r2** · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L148-r2](verification/ROUND_L148r2.md)
- **L145** · `BROKEN`, repaired, impact `NARROWS` · [ROUND_L145](verification/ROUND_L145.md)
- **L149-F** · the five carried findings, impact `FATAL` · [ROUND_L149-F](verification/ROUND_L149F.md)
- **L152** · `PROVEN, hypotheses corrected` for the surviving identity; the entry stays `REFUTED AS STATED` · [ROUND_L152](verification/ROUND_L152.md)
- **L158** · `GAP`, repaired, impact `CONTAINED` · [ROUND_L158](verification/ROUND_L158.md)
- **L157** · `BROKEN`, partly repaired, impact `FATAL` · [ROUND_L157](verification/ROUND_L157.md)
- **L156** · `GAP`, repaired, impact `NARROWS` · [ROUND_L156](verification/ROUND_L156.md)
- **L148** · `PROVEN, hypotheses corrected`, impact `CONTAINED` · [ROUND_L148](verification/ROUND_L148.md), [ROUND_L147](verification/ROUND_L147.md)
- **L147** · `HYPOTHESIS-DEBT`, impact `NARROWS` · [ROUND_L147](verification/ROUND_L147.md)
- **L149** · `GAP` twice, repaired and corrected · [ROUND_L149](verification/ROUND_L149.md), [ROUND_L149r](verification/ROUND_L149r.md)
- **L146** · `PROVEN, hypotheses corrected`, unanimous · [ROUND_L146](verification/ROUND_L146.md)
- **L35** · round closed: the bound holds and every hand-checkable step reproduces exactly · [ROUND_L35](verification/ROUND_L35.md)
- **L24** · round closed: the theorem is the soundest the audit has read, its identity confirmed four ways · [ROUND_L24](verification/ROUND_L24.md)
- **L32** · round closed: the statement is true and its exception exact · [ROUND_L32](verification/ROUND_L32.md)
- **L05** · round closed: three times this block recorded as open or as measured something the record had proved, twice crediting itself with catching the fault · [ROUND_L05](verification/ROUND_L05.md)
- **L19** · round closed: `WITHDRAWN` in [findings/](findings/) and still standing as a `Lemma` in [results.md](results.md) over an empty heading · [ROUND_L19](verification/ROUND_L19.md)
- **L34** · round closed: the witnesses are right and the argument for them is true at $m=8$ and carried to $m=6$ where it fails · [ROUND_L34](verification/ROUND_L34.md)
- **L33** · round closed: every step correct and the operator identity re-derived twice without the unheld source it cited · [ROUND_L33](verification/ROUND_L33.md)
- **L11** · round closed: two adjacent paragraphs asserting opposite things, each true of a different dimension, with the refuted reading in three of four sites · [ROUND_L11](verification/ROUND_L11.md)
- **L31** · round closed: both directions close and the equality case is complete · [ROUND_L31](verification/ROUND_L31.md)
- **L47** · round closed: every constant and all twelve exceptional rows rebuilt by hand and no falsifier found · [ROUND_L47](verification/ROUND_L47.md)
- **L28** · round closed: the arithmetic is flawless and every one of its three independent supports is thinner than stated · [ROUND_L28](verification/ROUND_L28.md)
- **L17** · round closed: the mathematics re-derives from the definitions three times over · [ROUND_L17](verification/ROUND_L17.md)
- **L44** · round closed: the mathematics rebuilds at every step · [ROUND_L44](verification/ROUND_L44.md)
- **L48** · round closed: the canonical block is a lossy abridgement of a complete argument in another file, dropping six used hypotheses · [ROUND_L48](verification/ROUND_L48.md)
- **L51** · round closed: the block under-claimed and the canon over-conditioned · [ROUND_L51](verification/ROUND_L51.md)
- **L12** · citation-hygiene pass: cited as measured everywhere, the canon saying "measured here and proved nowhere"
- **L25** · citation-hygiene pass: cited as a census everywhere but once: [algebra.md](findings/algebra.md) drew the general identity $\kappa=\theta^2\mathop{\mathrm{tr}}(L_e^2)$ from its value at one point
- **L40** · citation-hygiene pass: cited as measured everywhere, the canon closing "proves nothing about points outside it"
- **L53** · citation-hygiene pass: cited as verified by ascent everywhere, the canon calling its values lower bounds
- **L98** · citation-hygiene pass: its heading stated a census minimum as an equality, now read as measured over the census
- **L144** · citation-hygiene pass: cited as closing the strongly-regular family at every $n$, now scoped to the screened range
- **L56** · citation-hygiene pass: cited as a floor of the named families at the dimensions stated, the report scoping it to products

## Open candidate, a defect class, not yet a finding

**The mis-aimed pointer in L00 may be one of a batch of four.** [problem.md](findings/problem.md) carries four blocks created by the same numbering pass on 2026-08-31, each stating *"the argument is in this file under &lt;heading&gt;"* rather than carrying the argument: results **0, 43, 46 and 57**. Round L00 established by unanimity that result 0's pointer named a section proving something else.

**The other three are unchecked.** One reading suggests result 43's may fail the same way, its pointer names a section about the literature's scope, while the result is a criterion at $a=0$, but **one reader is not a result**, and this is recorded as a candidate rather than a verdict. Each is settled by its own round, and L57 already sits in tier 0.

*What makes this worth a line: the defect is a property of the pass that made the blocks, so finding it once is evidence about the other three in a way an isolated error would not be.*

## Queued findings, mathematics, not structure

**[Lemma L50](findings/bispectral.md)'s remark on the coefficient pair does not match its own display.** *Found independently by [v409](verification/VERIFY_v409.md) and [v410](verification/VERIFY_v410.md) in [ROUND_L67r2](verification/ROUND_L67r2.md).* With $\beta=c\sigma$ the remark writes $\tfrac{2+c}cp_3(\mu)-\tfrac1cp_3(\omega)$, and no $c$ gives the displayed $(\tfrac32,-\tfrac12)$, while $\tfrac{1+c}c$ does at $c=2$. A question for L50's next round.

**A lower bound on the subalgebra family, found by a verifier and not folded in.** $S_{\mathfrak{hhh}}\ge0$ with the first Killing relation forces $r\ge N/(n-1)=n/2$, with equality **exactly when $\mathfrak h$ is abelian**, so the family occupies $[n/2,\,n(n-2)/4]$ rather than $(0,N)$: empty at $n=3$, a single admissible $r$ at $n=4$ and at $n=5$, and no abelian $\mathfrak h$ at odd $n$. *This is new mathematics from a verifier rather than a check of the block, so it is recorded here rather than written into [Lemma L23](findings/ungraded-slack.md); the research loop proves it under Gate 2, where new results belong.* The same verifier notes the maximal torus is a member at even $n$, sitting at the abelian floor, and that its $n=6$ ratio is exactly $\sqrt6/4$, the entry the record prints as $0.612$.

**[L105.lean](lean/HamiltonsCubic/Results/L105.lean) evaluates the subalgebra family's $\theta^2$ at $r=7$ and $r=8$ with $n=6$, above the cap $n(n-2)/4=6$ that [Lemma L23](findings/ungraded-slack.md)'s derivation permits.** Two verifiers found this independently; **there is no Lean row for L23 itself**, and the row named as its extension is the one evaluating out of range. **This is the lean loop's to act on**; what the verification loop owes is the notice.

**[L2.lean](lean/HamiltonsCubic/Results/L2.lean)'s docstring says `𝒲ₙ` and `Q` "do not exist yet", and they do.** [Base/CP2.lean](lean/HamiltonsCubic/Base/CP2.lean) proves the competitor's `θ² = 3/2` at `n = 4` from exactly those two objects, so the file's own account of why its inputs are imported is false about one of them. The odd-parity companion `Θₙ² = 2(n-1)(n-3)/((n-2)(n+1))` is a third import the docstring does not list, and the padding extension it calls unformalised is proved in the block in one clause. **This is the lean loop's to act on**; [lean/INDEX.md](lean/INDEX.md)'s L2 rows were corrected by [ROUND_L02](verification/ROUND_L02.md) and the docstring was left to its owner.

**The third form is out of step with two entries this block corrected, found by the first application of the three-form rule.** *[L156.lean](lean/HamiltonsCubic/Results/L156.lean)'s theorems are true as written and kernel-checked; what has drifted is what they are about.* Its docstring states L156 as **"for $m\ge2$"** with $C(\alpha,\gamma)=(1+\alpha)/(\alpha-\gamma)$ on $\alpha\le D/2$, **the pre-round statement.** [ROUND_L156](verification/ROUND_L156.md) corrected the constant to $\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}$ with $d=\min(\alpha,D-\alpha)$, made the reduced form a consequence rather than the definition, and wrote in a domain, $m\ge2$, $\ker W^*=0$, $W(z)$ affine, $\lVert H\rVert_{op}\le1$, $0<\alpha<D$, $0<\gamma<\min(d,1)$, **none of which the Lean file carries.**

**This is the lean loop's to act on**, that folder being its own. *What the verification loop owes is the notice, and this is it.* **The same check is owed for [L158.lean](lean/HamiltonsCubic/Results/L158.lean)**, whose `kappaSq` and its narrow range were not read against the entry [ROUND_L158](verification/ROUND_L158.md) rewrote.


**[plan.md](plan.md):68 carries the withdrawn $\sigma$-factorisation**, in the words *"factorises out of it, so the three-parameter optimisation is one parameter in closed form"*. [ROUND_L156](verification/ROUND_L156.md) refuted the claim and cleared it from [results.md](results.md) and [findings/INDEX-results.md](findings/INDEX-results.md). **[plan.md](plan.md) is the research loop's file and this loop does not write to it**, so the correction is handed over rather than made.

**Resolved: the second-kind sign.** *[conventions.md](findings/conventions.md) settles it on Li's $iklj$ order, with each published table right in its own order, and [ROUND_L67](verification/ROUND_L67.md) used that convention.*

**Resolved 2026-09-14: the stratum route's closing reason is replaced.** *[stratum-two-negative.md](findings/stratum-two-negative.md)'s "No upper bound on $\lambda_{\max}$ appears" now reads that the field's lower bounds are hypotheses of global theorems whose normaliser vanishes on $\mathrm{Weyl}_n$, by Cheng–Wang's Proposition 2.1, so item (iii) is derived here. The route stays closed.*

## Rounds that did not close

**None open.** *L04, stopped at three of five on 2026-09-02, was rerun and closed in [ROUND_L04b](verification/ROUND_L04b.md).*

## Queue changes, with the reason

**The promotion's premise was reversed by the round it opened: L62's description is the accurate one, and the understatement was L61's, now repaired.** The entry below stands as written, since the promotion was correct in effect.

**L61 and L62 promoted from tier 3 to the top of tier 1 on 2026-09-05, by a [lean-loop](.claude/skills/lean-loop/SKILL.md) round.** [L61](findings/sym3-blocks.md)'s certificate has two halves. The positive-definiteness half is now machine-checked in Lean, exactly over $\mathbb{Q}$ ([lean/HamiltonsCubic/Results/L61.lean](lean/HamiltonsCubic/Results/L61.lean)). The identity half (that the Gram's sextic *is* $F_5$), holds only if evaluation at the 40 solve points is injective on $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, and the support for that injectivity is a **numerical rank read off a singular-value gap** ([run_n5_verify.py](scripts/runs/run_n5_verify.py)). [L62](findings/sym3-blocks.md) describes the weak link as a sampled mod-$p$ rank, which is a different and stronger instrument. **The record understates its own dependency, and the two blocks disagree about what the dependency is.** A concrete defect enters ahead of the exposure order, as a row marked `UNDECIDED` does.

**L01 demoted from tier 0 to tier 3 on 2026-09-01, in [ROUND_L00.md](verification/ROUND_L00.md)'s phase 0.** The tier-0 placement came from [findings/INDEX.md](findings/INDEX.md)'s line calling result 1 *"never audited and load-bearing"*. The file that owns it says the opposite, *"nothing in this project depends on Lemma L1: what it depends on is the grant … it is not worth reviewer time"*, and the index's own status table agrees with the file, the diagonal case being carried by result 57 at every $n\ge4$. **The two lines contradict each other and one is stale**, which is itself a finding of round L00 rather than of any reviewer.

- **2026-09-05, the carried-findings row is renamed `L149-F`.** *It read "F7, F9, F10, F11, F12", which the Stop hook cannot parse as an id, so the hook skipped tier C's last live row and named tier 0's `L00` as next.* **A queue row whose id the tooling cannot read is a row the loop can walk past**, and this one had already sat through six rounds.

- **2026-09-05, L145 promoted above the four `-r2` rows, at the user's direction.** *[ROUND_L149-F](verification/ROUND_L149F.md) refuted L149's boxed $r_n\gtrsim n^{-1-\beta}$ and left $r_n\gtrsim n^{-3/2}$ standing, **which is L145's own order**, so the whole chain's surviving bound is now L145's.* **L145 is the only weight-bearing entry in the block that no round has read**, and its round answers a question the `-r2` rows cannot: whether L146–L158 add anything over L145 at all. *If they do not, auditing their corrected texts polishes passages that carry nothing.*

## Support owed under PROVED results, handed over from [plan.md](plan.md) on 2026-09-13

**These eight were live items of the research plan's section 1, three of them at its graded top, and the rubric's `closes` factor now scores them $0$: each secures a result the record already carries rather than advancing the one statement still open.** *That makes them this loop's work rather than that one's, and they are handed over verbatim, with the result each is owed against named first. Nothing here is a task to derive a NEW claim: each is a recorded result whose support is thinner than its use.*

**They are not queued as rounds.** *A round here is three verifiers on one numbered result, and these are narrower than that: a named gap under a result, with the evidence that stands in for it. Each becomes a round when the queue reaches its result, and the gap below is what that round must settle.*

| result | what is unproved under it | was |
| --- | --- | --- |
| [L47](findings/problem.md) | the two rank-one closed forms' monotonicity, its equality case resting on a five-point scan | I43 |
| [L24](findings/second-order.md) | the $\theta=0$ branch, where $e=W/\theta$ and the whole statement are undefined, **in the record's most cited result** | I45 |
| [L115](findings/bounds-relaxations.md) | any cap at all on $\lambda_{\max}(L_W\vert_{\mathcal W_n^\perp})$, without which it cannot be read over $\mathcal D$ | I49 |
| [L28](findings/nondegeneracy.md) | the charge formula, whose whole content is an eigenvalue table produced by a formula verified at eighteen values and derived nowhere | I50 |
| [L21](findings/route-a.md) | that the four $F_\lambda$ have $m$-free characteristic polynomials, the tube theorem's one unproved input, evidenced at a single admissible dimension | I54 |
| [L171](findings/route-a.md) | $c_0=1$, and $\lambda_{\max}(M_{W_1})=\tfrac23$ from the structure rather than from three readings of one measurement | I57 |
| [L49](findings/target.md) | the eigenframe display $\theta=\sum\lambda^3+3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$ with coefficient $3$ at $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}$ and Böhm–Wilking's $\#$, derived in no quoted passage ([ROUND_L49](verification/ROUND_L49.md)) | ROUND_L49 |
| [L59](findings/sym3-blocks.md) | the concrete pairing and map $\mu$, the identification of $\mathrm{ANN}$ with $\{F:\mathrm{Cat}_F(K,K)=0\}$ by equivariance and averaging, surjectivity of the unrestricted $\mu$, and the reduction from a positive semidefinite certificate to $F_5\in\mathrm{image}(\mu_K)$ ([ROUND_L59](verification/ROUND_L59.md)) | ROUND_L59 |
| [L63](findings/sym3-stability.md) | a source for $\mathcal W_{12}$ being the $D_6$ irreducible of highest weight $(2,2,0,0,0,0)$, and any derivation of the $77/191$ census; the stability argument's imports (Newell–Littlewood, the modification rules, Koike–Terada) are unfiled ([ROUND_L63](verification/ROUND_L63.md)) | ROUND_L63 |
| [L64](findings/fence-posts.md) | a value of $k_B(d)$, the presentation degree of $\{\mathrm{Sym}^d\mathcal W_n^*\}$ over $\{B_n\}$, finite by Levin–Chandrasekaran's Theorem A.5, for any $d\ge1$, and any argument carrying a nonnegativity certificate along the lift ([ROUND_L64](verification/ROUND_L64.md)) | no $n_0$ is known to meet the uniqueness clause, and $k_B(6)\ge24$ |
| [L9](findings/graded-half.md) | that the triality image $\tau W_{3,5}$ of $S^3\times S^5$ is the quaternionic-Kähler Weyl tensor of $\mathbb{HP}^2$, sign included; the record has only the agreement $\theta^2=\tfrac{56}{45}$, which cannot fix the sign ([ROUND_L09](verification/ROUND_L09.md)) | the lemma is stated for $\tau W_{3,5}$ |
| [L83](findings/sym3-blocks.md) | the character identity $\mathrm{ch}\,\mathrm{Sym}^3(V_{(2,2)})=\sum m_\lambda\,\mathrm{ch}\,V_\lambda$ with the twenty-four printed pairs, $\mathcal W_5\cong V_{(2,2)}$ as an $O(5)$-module, and that the cubic invariants are spanned by the two contractions with $\mathop{\mathrm{tr}}(W^3)\not\equiv0$ on $\mathcal W_5$ ([ROUND_L83](verification/ROUND_L83.md)) | the table is an Observation, and L86, L87, L88 and L89 read their counts off it |
| [L85](findings/sym3-blocks.md) | a derivation of $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$, and of the degree-$3$ to degree-$5$ values $1,4,5$; the stable-range values $1,2,7,19,89$ also carry no source ([ROUND_L85](verification/ROUND_L85.md)) | the count is an Observation, and L89 and L91 read the $14$ |
| [L86](findings/sym3-blocks.md) | a derivation of $\mathrm{Stab}_{O(5)}(W_0)$ for padded $W_{\mathbb{CP}^2}$, a source for $F_5(W_0)=0$, the certificate model (an invariant sum of squares with PSD Gram blocks) the orbit reduction assumes, and the rank-one step that makes the unknown count exactly $36$ ([ROUND_L86](verification/ROUND_L86.md)) | the parity rule is proved granting the stabiliser, and only $\ge36$ unknowns |
| [L90](findings/sym3-blocks.md) | the rank $\mathrm{rank}(\mathrm{ev}\circ\mu_K)=13$ over $\mathbb Q$ at the certificate's $40$ points, which is on file only modulo a prime, with the reduction, denominator and point-identity hypotheses that reading needs ([ROUND_L90](verification/ROUND_L90.md)) | the injectivity of evaluation, hence $F_5$ in the image, rests on that rank |
| [L1](findings/problem.md) | whether it stands at all, and its three unwritten steps, its route ending in an interval-arithmetic closure | I63, I64 |

**The eight items as they stood, verbatim, so nothing is lost in the move:**

- [ ] **I43, the two rank-one closed forms are monotone.** *Theorem: $\lVert W\rVert^2(\mathbb{CP}^m)=\frac{3m(m-1)}{4(m+1)(2m-1)}$ and $\lVert W\rVert^2(\mathbb{HP}^m)=\frac{9m(2m+1)(m-1)}{4(m+2)^2(4m-1)}$ increase on $m\ge2$.* Closes [L47](findings/problem.md)'s *"equality only at $\mathbb{CP}^2$"*, which rests on a five-point scan. *A verifier reports the derivative numerators as $3m^2-2m+1$ and $34m^4+56m^3-21m^2+8m+4$; that derivation is unaudited and is a lead, not the item.*

- [ ] **I45, no real $2$-nilpotent of $\mathcal W_n$ is a local maximiser.** *Theorem: exactly that.* Closes the $\theta=0$ branch of [L24](findings/second-order.md), where $e=W/\theta$ and the whole statement are undefined, **the record's most cited result, whose scope argument reaches $\theta>0$ only at a global maximiser** while consumers apply it at local ones.

- [ ] **I49, a cap on $\lambda_{\max}(L_W\vert_{\mathcal W_n^\perp})$.** *Theorem: any bound at all.* [L115](findings/bounds-relaxations.md) needs it to read [L24](findings/second-order.md)'s cap over $\mathcal D$ rather than over $\mathcal W_n\cap W^\perp$, and **it is nowhere on the record**, which is why that lemma's unrestricted form is not citable.

- [ ] **I50, the charge formula, proved rather than checked.** *Theorem: $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ on every $U(m)$-summand of $\mathrm{Weyl}_{2m}$, from the $\sharp$ closed forms.* **[L28](findings/nondegeneracy.md)'s whole content is its eigenvalue table, and the formula producing it is verified at eighteen values and derived nowhere.** *Filed after [ROUND_L28](verification/ROUND_L28.md) demoted the block's other three supports: multiplicity-freeness needed the ledger's hand proof at $m=3$, the two Fox identities pass at $m=2$ on a list carrying a negative dimension, and the second route to $\lambda_{\max}$ takes five of its six inputs from the charge formula itself.*

- [ ] **I54, the four $F_\lambda$ have $m$-free entries.** *Theorem: for every $m\ge5$ the matrices $F_{\mathbf1},F_V,F_{\Lambda^2},F_{S^2_0}$ of [L21](findings/route-a.md) have characteristic polynomials independent of $m$, so the tabulated spectra, and with them $\alpha\le\tfrac13$, hold at every $n\ge9$ rather than at the dimensions sampled.* *Analysis in [route-a.md](findings/route-a.md#i54-the-four-f_lambda-have-m-free-entries).*

- [ ] **I57, $c_0=1$ and $\lambda=\tfrac23$. HALF CLOSED as [Lemma L171](findings/route-a.md#lemma-l171-vt-has-two-constants-not-three-lambdatfrac23-and-t-are-forced-by-a)**, which carries $V(t)$'s closed form and the two independent pins. **Three recorded constants are one measurement**, so their mutual agreement is not evidence. **What stands open is $c_0=1$**, named for what it is: the hypothesis making the problem two-dimensional rather than a constant to derive. *Still owed: $\lambda_{\max}(M_{W_1})=\tfrac23$ from the structure.* **Gate 2 owed on L171.**

- [ ] **I63, number Result 5b, or drop [L1](findings/problem.md). REOPENED on its first branch.** *The second branch was refuted at Gate 2 by both reviewers and the reason is [L172](findings/problem.md): the source's hypothesis is live at $n=12,14$ rather than slack.* **What a numbered result must state is the record's own interval-arithmetic closure of Lemma 3.5.6**, one constraint stated three ways, not three. *And the source owes an induction step it argues nowhere.* Owed by [ROUND_L01](verification/ROUND_L01.md).

- [ ] **I64, [L1](findings/problem.md)'s three unwritten steps, and a certificate at $n=14$.** *Theorem: the reduction to Jäger's expression, the dual construction behind $\varphi$, and a checkable interval certificate, at $n=14$ as well as $n=12$.* *Analysis in [ATTEMPTS.md](ATTEMPTS.md#i64-l1s-three-unwritten-steps-and-a-certificate-at-n14).*
