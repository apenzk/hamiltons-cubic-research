# Review r606, Lemma L19 (the rest of the diagonal proof lifts, the top orbits are rigid, the remaining gap sharpens)

Reviewer r606, independent adversarial audit of `Lemma L19` at [problem.md:373](../findings/problem.md#L373), with its glance entry at [results.md:226](../results.md#L226) and its detail entry at [results.md:650](../results.md#L650). Worked from [conventions.md](../findings/conventions.md) and the definitions. Analysis-only footing: **no run of any kind was made**, and nothing below rests on one. The other reviewer's report on this brief was not opened.

**Overall verdict: THERE IS NO CHECKABLE STATEMENT.** The block is a five-paragraph status report. It contains no proposition, no hypothesis, no quantifier over $n$, no displayed inequality, no $\square$, **no link, and no reference to any numbered result**, the strings `L`-number, `Result`, `Conjecture` and `Observation` do not occur in it once. Nothing was lost in the move: the pre-move copy is the same five paragraphs. Graded clause by clause, one of the three headline claims is a `Lemma`, one is an `Observation` mislabelled, and one is not a claim at all.

## Verdicts

| # | item | verdict |
| --- | --- | --- |
| 1 | is there a statement? | **NO**, narrative only; a Lemma with no proposition can be neither true nor false |
| 2 | is there a proof? | **NO**, and none was lost in the move, see §2 |
| 3 | the provenance note, first half ("results.md held the only copy") | **TRUE**, unlike [L1](../findings/problem.md#L414) and [L11](../findings/nondegeneracy.md#L434), the pre-move [problem.md](../findings/problem.md) carried nothing on this |
| 4 | the provenance note, second half ("that file now carries the statement") | **FALSE**, [results.md:650](../results.md#L650) carries paragraph 1 verbatim and a bare `Proof: problem.md`; the two files defer to each other for the half neither has |
| 5 | "the rest of the diagonal proof lifts" | **CONFIRMED in substance**, uncited, and the summary omits two live grants, see §3.1 |
| 6 | "the top orbits are rigid" | **`Observation`, not `Lemma`**, support is exact arithmetic at $n=8,12,14$; and "every sphere pair" is **false without the $(3,3)$ exclusion**, see §3.2 |
| 7 | "the remaining gap sharpens" | **NOT A CLAIM**, it names no sharpened quantity; and the glance entry's "strictly weaker than Conjecture L16" is **unestablished in either direction**, see §3.3 |
| 8 | the localization core, as stated | **GAP**, "close" carries no metric, no radius and no quantifier order; the reduction is a matched pair, not "outright", see §4 |
| 9 | "goes vacuous once the defect exceeds roughly a thousandth" | **DEFECT**, conflates two thresholds of [ATTEMPTS.md](../ATTEMPTS.md) Result 10 that differ by $\approx33\times$; conclusion survives, see §3.3 |
| 10 | does the "COMPLETE" sub-section belong to L19? | **NO**, it belongs to [Lemma L57](../findings/problem.md#L527); it is orphaned prose sitting under the wrong block, see §5 |
| 11 | is "COMPLETE" inconsistent with L19's "remaining gap"? | **NO logical conflict** (different theorems), **YES a reading conflict**, see §5 |
| 12 | does anything in L19 turn on $\theta_0(n)$ vs $\Theta_n$? | **NO**, see §6 |

## 1. What the statement of Lemma L19 is

There is none. Writing the block out as a proposition is not possible without inventing hypotheses, and the exercise is worth doing precisely to show where it fails.

The five paragraphs are: (i) two inequalities lift; (ii) the endgame is frame-free and the defect is "priced"; (iii) top orbits are rigid; (iv) the open core is a localization statement; (v) two routes are closed. Of these, (i)–(iii) are *reports on the status of other arguments*, (iv) describes what is **open**, and (v) is a pair of negative results. **A block whose content is a status report cannot carry the label `Lemma`, and the heading's promise of a "canonical statement and proof" is unmet on both halves.**

The nearest thing to a proposition anywhere in the record is the glance entry at [results.md:226](../results.md#L226), and it is three narrative sentences with no quantifier over $n$ either.

## 2. Was the proof lost in the move? No, checked, not assumed

The move is `a9e4b8c0` (*"refactor(results): the proofs move to findings, results.md states and points"*, 2026-08-31). `git show a9e4b8c0^:results.md` puts the block at line 775 of the pre-move file, and it is **the same five paragraphs, word for word, with no proof**. The diff on [findings/problem.md](../findings/problem.md) adds exactly those five paragraphs and nothing else. The contrast is instructive: the same commit moved L44, L47 and L48, and each of those arrived with a "**Statement and argument**" and a $\square$.

The first half of the provenance note is therefore honest, `git show a9e4b8c0^:findings/problem.md` has no block on this subject, so results.md really did hold the only copy. **This is the eighth provenance note audited on this file and the second to come back clean.**

The second half is false. The note says *"That file now carries the statement and points here."* [results.md:650](../results.md#L650) carries the heading, **paragraph 1 of this same block verbatim**, and `**Proof:** [problem.md](findings/problem.md)`, a file-level pointer with no anchor, into a 550-line file. So results.md points here for a proof that does not exist, and the block points back there for a statement that does not exist. **Neither file has either half, and each note asserts the other file has it.**

## 3. The three headline claims, graded separately

### 3.1 "The rest of the diagonal proof lifts", true in substance, cited nowhere, and the summary is short

The block names no result. Reconstructed, the referent is [ATTEMPTS.md](../ATTEMPTS.md) **Result 11**, which discharges the lifted Jäger Lemma 3.3.5 grant. That result is real and the "sharp at a family I had not noticed before: the critical operator of a product of $n/2$ two-spheres" is its stated equality family. **Lifts from the diagonal locus $\mathcal D_n$ to every Ricci-flat $W\ne0$** (Result 11's own hypothesis list is "uses only $\mathrm{Ric}(W)=0$), no Bianchi, no criticality", which is what the block's "needs nothing beyond positive semidefiniteness and the value of its Ricci contraction" is describing.

Three things the block's wording conceals, each behind a hedge:

- **"replaced outright by an unconditional one"**, the replacement carries the *weaker* constant $4(n-1-\nu_0)$ in place of Jäger's $4(n-2)$, which cost $7.4\%$ of $c(12)$ ($1.081\times10^{-3}\to1.0008\times10^{-3}$). Result 11 says in its own words that the sharp $n-2$ constant "remains a conjecture". "Outright" is doing the work of hiding a quantified loss.
- **"more cleanly than expected"** (Result 11 is marked "Single-run agent result, unreviewed), end-of-batch adversarial review pending".
- **"the defect enters the whole lifted argument at exactly one place, and that place is priced"**, "priced" does resolve to a genuine bound, but only by reading [Lemma L18](../findings/problem.md#L276) a hundred lines above, which states the cost as $24\lVert\mathrm{Alt}(W_-)\rVert^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$. What "exactly one place" omits is that the *positivity* departure is a second and separate entry point, and its grant $J_5\ge0$ is discharged only on the commuting class. [ATTEMPTS.md](../ATTEMPTS.md) Result 11's closing line is explicit: *"the Result-10 dichotomy now rests on $J_5\ge0$ and the E-track certificate alone."* **Two grants are open and the block's summary of what remains mentions neither.**

**Verdict: the mathematics is sound and belongs to a result the block does not name. The clause as written overstates it in three places.**

### 3.2 "The top orbits are rigid", an `Observation`, and "every sphere pair" is false as written

The block: *"At every high-value critical orbit (the rival maximizer and every sphere pair, in the dimensions that matter), the degenerate directions of the second variation are exactly the directions along the orbit, established in exact integer arithmetic. Each orbit is therefore nondegenerate and isolated in the critical set: nothing branches off it."*

The support is [ATTEMPTS.md](../ATTEMPTS.md) Result 12(a): *"For 19 orbits (Fox and every sphere split at $n=8,12,14$, plus $\mathbb{HP}^2$/$\mathbb{HP}^3$ at $n=12$), the radical of the second variation equals the orbit tangent space, proven in exact integer arithmetic."*

- **The dimensions "that matter" are $n=8,12,14$.** That is a verification at three named dimensions in exact arithmetic. Under the record's literal labelling, **a claim established at named dimensions is an `Observation`**. The block calls it "proven rather than computed", which conflates *exact* with *general*: exact integer arithmetic removes the numerical threshold, not the dimension quantifier.
- **"every sphere pair" is false without a scope.** [Lemma L11](../findings/nondegeneracy.md#L434), corrected 2026-09-04, states: *"For $p,q\ge3$ with $(p,q)\ne(3,3)$, $S^p\times S^q$ is Morse–Bott nondegenerate… **The single degenerate case is $(3,3)$**"*, kernel $18$ against an orbit of $9$. And $S^3\times S^3$ at $n=6$ is the balanced sphere product there, i.e. a high-value orbit at that $n$. Result 12(a) itself records *"the $n=6$ $(3,3)$ accidental degeneracy is correctly reported inconclusive"*. **The hedge "in the dimensions that matter" is the only thing standing between this clause and a counterexample the record holds in two places.** That is not a hedge a `Lemma` may carry; the exclusion belongs in the statement.
- **The sphere-pair half has since been upgraded to a real theorem that the block does not cite.** [Lemma L26](../findings/nondegeneracy.md#L78) supplies the closed form $\mu=\frac{n-2}{2(p-1)(q-1)}$ with $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, and [Lemma L27](../findings/nondegeneracy.md#L457) with [nondegeneracy.md:750](../findings/nondegeneracy.md#L750) then gives it **unconditionally in $p,q$**. So this half *is* a `Lemma`, via an argument L19 neither names nor knows about, and with an exception L19 does not state.
- **The rival-maximizer half has no dimension-free proof.** [Lemma L28](../findings/nondegeneracy.md#L504) covers $\mathbb{CP}^m$ only for $m\ge3$, and $m=2$ is the rival maximizer. So that half rests on Result 12(a)'s certificates at $n=8,12,14$ alone, an `Observation`.

**A near-miss worth recording, since it is the kind of error this pair exists to catch.** [nondegeneracy.md:454](../findings/nondegeneracy.md#L454) reads *"the Kähler family $\mathfrak{su}(m)$ and **the two-block plateau at the rival maximizer** are graded and Morse–Bott **degenerate**"*, which parses as a flat refutation of this clause. It is not: [nondegeneracy.md:423](../findings/nondegeneracy.md#L423) defines the Fox plateau as $(W_1+W_2)/\sqrt2$ on two disjoint $4$-blocks, at $\theta=0.866025=\sqrt{3/2}/\sqrt2$, **not** the rival maximizer, whose value is $\sqrt{3/2}$. The same sentence's own next clause confirms it (*"every known exception sits at value at most $1.054$, below the rival maximizer's $\sqrt{3/2}$"*). **The prose at [nondegeneracy.md:454](../findings/nondegeneracy.md#L454) should read "the two-block plateau built from the rival maximizer's blocks"**, as written it says the rival maximizer is degenerate, which is the opposite of what the record holds.

### 3.3 "The remaining gap sharpens", sharpens to nothing stated

The heading promises a sharpening. The body supplies a *reshaping*: the open core "becomes a localization statement". **No quantity is named that is smaller than it was, and no before/after pair is given.** A gap that changes shape is not a gap that shrinks, and the clause as headed is not a claim.

Two attached facts, both checkable, one defective:

- **"general finiteness arguments for critical values carry constants far too large"** resolves to [post F4](../findings/fence-posts.md#L160) (*the second post so numbered; see item 7 below*), *"Łojasiewicz constants are astronomically large"*, whose body in the file is the fragment `, so the Łojasiewicz route cannot produce a usable separation.`, beginning with a comma. **The fence post has lost its statement**, so the only support for this half of the clause is a heading. (Incidental to L19; flagged because L19's pointer lands there.) Note also that the record's *live* route at [ungraded-slack.md:192](../findings/ungraded-slack.md#L192) is itself a finiteness argument, finiteness of connected components via Łojasiewicz/Tarski–Seidenberg, which carries no constant at all. The two are compatible, but L19's blanket "general finiteness arguments" reads as closing the route the record is pursuing.
- **"the lifted chain goes vacuous once the defect exceeds roughly a thousandth"**, **DEFECT.** [ATTEMPTS.md](../ATTEMPTS.md) Result 10 carries two distinct thresholds: the chain *closes* for $\delta^2\lesssim1.2\times10^{-3}$, and it *goes vacuous* for $d\gtrsim0.04$, "because Jäger's $x\le2$ hypothesis fails". Between them the chain is neither closing nor vacuous. L19 attaches "vacuous" to the closure number, off by $\approx33\times$. [Post F5](../findings/fence-posts.md#L162) states the same fact correctly (*"Chain-tightening caps at $\delta^2\lesssim10^{-3}$"*) so the record has the right word and L19 uses the wrong one. **The conclusion survives**: Fox sits at $\delta^2=1/9\approx0.111>0.04$, so the chain is genuinely vacuous at the defect that matters and "tightening it cannot reach the core" stands.

**On the glance entry.** [results.md:226](../results.md#L226) closes *"What is left is strictly weaker than Conjecture L16."* This is **unestablished in either direction**. [Conjecture L16](../findings/problem.md#L333) is the value bound $P\le\Theta_n+\kappa_n\delta^2$; the remaining statement is the localization claim of §4. L16 does not imply localization (a value bound says nothing about where critical points sit), and localization does not imply L16 (it yields $P\le\Theta_n$ at critical points, not the penalised refinement at every $W$). **Both imply Conjecture A; neither implies the other, so "strictly weaker" compares two incomparable statements.** [r473](REVIEW_r473.md) read this sentence as "a comparison, not a dependence" and was right about the logic; the comparison itself is what fails.

## 4. The open core: the localization claim, stated precisely, and whether rigidity finishes it

The block: *"every critical point at or above the rival maximizer's value lies close to one of these rigid orbits, which the rigidity then finishes outright."*

**Stated precisely, this is:**

> For each $n\ge12$ there is $\varepsilon_n>0$ such that every $W\in\mathrm{Crit}(P)$ on the unit sphere of $\mathcal W_n$ with $P(W)\ge\sqrt{3/2}$ satisfies $d\big(W,\ \mathcal O_n\big)<\varepsilon_n$, where $d$ is angular distance in $\mathcal W_n$ and $\mathcal O_n=SO(n).W_{\mathbb{CP}^2}\ \cup\ \bigcup_{p+q=n}SO(n).W_{S^p\times S^q}$.

**Everything in that display is supplied by me, not by the block.** The block gives no metric, no $\varepsilon$, no quantifier order, and does not say which orbits "these" are.

**Does rigidity finish it, granting localization? Only with a matching condition the block does not state.** Morse–Bott nondegeneracy of an orbit $\mathcal O_i$ gives a punctured neighbourhood free of critical points, i.e. a radius $r_i>0$ with $\mathrm{Crit}(P)\cap B(\mathcal O_i,r_i)=\mathcal O_i$. The conclusion $W\in\mathcal O_n$ then follows from $d(W,\mathcal O_n)<\varepsilon_n$ **only if $\varepsilon_n\le\min_i r_i$**. So:

1. **The reduction is a matched pair, not a free implication.** Localization must be proved with an $\varepsilon_n$ below an isolation radius. **Nowhere in the record is any $r_i$ made explicit**, nondegeneracy is proved as a kernel-equals-orbit-tangent statement, which gives isolation qualitatively and no radius at all. So the "which the rigidity then finishes outright" is a claim about two constants of which one has never been computed and the other never defined. **"Outright" is the hedge.**
2. **The orbit list must be exhaustive above the threshold**, and that exhaustiveness is not separately available, [post F9](../findings/fence-posts.md#L171) records that "the critical set is exponentially large and mostly symmetry-free", and [graded-half.md](../findings/graded-half.md) has withdrawn its exhaustiveness claim. As phrased, the localization statement quietly *contains* the exhaustiveness (it says every high-value critical point is near one of *these*), which is legitimate but means the localization statement is doing strictly more work than the word "localization" suggests.
3. **At $n\ge12$ the rigidity inputs are available for the orbits named**, $(3,3)$ is out of range and [Lemma L11](../findings/nondegeneracy.md#L434)'s only exception is $(3,3)$, so the *qualitative* half of the finish is sound. It is the uniformity, exactly as the brief anticipated, that is missing.

**Is it presented as proven, as a plan, or as a conjecture?** As a **plan**: "the open core becomes a localization statement". The block is honest here. **The label on the record is not.** [results.md:226](../results.md#L226) files it as `Lemma L19 (lifting)` and [problem.md:373](../findings/problem.md#L373) heads it `Lemma L19, … canonical statement and proof`. **A block whose substantive content is a description of what remains open is filed under the record's label for a proved result.**

## 5. The "COMPLETE" sub-section belongs to Lemma L57, not to L19

[problem.md:388](../findings/problem.md#L388), *"So the all-$n$ diagonal theorem is COMPLETE"*, is a sibling `####`, so it is formally a separate block. Its content settles the ownership: "Steps 1, 2 and 3" are the three steps of the CANDIDATE at [problem.md:246](../findings/problem.md#L246), whose proofs sit at [line 258](../findings/problem.md#L258) (step 2), [line 313](../findings/problem.md#L313) (step 3) and [line 357](../findings/problem.md#L357) (step 1), and whose canonical block is **[Lemma L57](../findings/problem.md#L527)**, 139 lines below. **None of it is about L19**, which concerns the *off*-diagonal lift.

- **No logical inconsistency with L19's "remaining gap"**, the diagonal theorem is the granted sub-problem, L19's gap is the general conjecture. **But a serious reading inconsistency**: the two sit adjacent at the same heading level with no transition, and a reader following results.md's bare `Proof: problem.md` for L19 lands at line 373 and reads straight into "COMPLETE".
- **The sub-section contradicts itself inside one paragraph.** It asserts *"uniqueness holds at $n=4$ as well"* and, four lines later, *"(up to sign and permutation, **uniquely for $n\ge5$**)"*. One of the two is wrong. (The arithmetic in the $n=4$ sentence is right and easy to misread: $\Theta_4^2=2\cdot3\cdot2/16=3/4$, so $\Theta_4=\sqrt3/2$, the bare $\sqrt3/2$, not $\sqrt{3/2}$.)
- **It contradicts its own file 142 lines above on whether Gate 2 has run.** [Line 246](../findings/problem.md#L246) heads the candidate *"Gate 2 owed"* and adds *"none audited"*; [line 392](../findings/problem.md#L392) asserts *"Two independent Gate 2 proofs of the one lemma that was open"*, **naming no reviewer and giving no link**, where every other Gate 2 assertion in this file cites r-numbers.
- **Its closing sentence is stale, and the file settles it 31 lines above.** *"$\textit{Superseded:}$**Step 1 is the record's own Dirichlet-energy step** … what is owed there is only the cross-check that the two statements coincide"*, but [problem.md:357](../findings/problem.md#L357), *"Step 1 is PROVED, and it IS the record's own Dirichlet inequality"*, carries the full derivation of $\lambda\le\frac{n-1}n\mu$ ending in $\square$ and identifies the two statements as the same. The debt is discharged directly above the sentence that records it. (The italic/bold run `*Superseded:***Step 1` is also a broken markdown join with no space.)

## 6. The $\theta_0(n)\to\Theta_n$ correction does not reach L19

Per the brief's note, checked and reported: **nothing in L19 turns on the target constant.** Its own threshold is the *rival maximizer's* value $\sqrt{3/2}$, which is parity-free. The one place a constant enters is "roughly a thousandth", computed at $n=12$ against $\theta_0(12)=\sqrt{55}/6=1.236033$, and $n=12$ is even, so $\Theta_{12}=\theta_0(12)$ and the figure is unchanged. **No repair is owed to L19 on that account.** ([Conjecture L16](../findings/problem.md#L333) and the "COMPLETE" sub-section, which do turn on it, already carry $\Theta_n$.)

## What is owed, and whether it is reachable

1. **Write a statement, or relabel.** The block has none, and the heading promises one. Either L19 acquires a proposition or it is redesignated, the honest designation for paragraphs (i)–(iii) is a status note pointing at [ATTEMPTS.md](../ATTEMPTS.md) Results 11 and 12(a), and for paragraphs (iv)–(v) a `Conjecture` plus two fence posts. **Reachable immediately; it is an editorial act, not a mathematical one.**
2. **Split the rigidity clause.** The sphere-pair half is a `Lemma` and should cite [L26](../findings/nondegeneracy.md#L78)/[L27](../findings/nondegeneracy.md#L457) with the $p,q\ge3$, $(p,q)\ne(3,3)$ scope in the statement. The rival-maximizer half is an `Observation` at $n=8,12,14$. **Reachable.**
3. **Repair the two false or misleading sentences**: the provenance note's second half (results.md carries no statement), and "goes vacuous once the defect exceeds roughly a thousandth" (that is the *closure* threshold; vacuity is at $\approx0.04$). **Reachable.**
4. **Withdraw "strictly weaker than Conjecture L16"** from [results.md:226](../results.md#L226), or supply the implication. The two statements are incomparable as far as I can establish. **Reachable as a withdrawal.**
5. **State the localization claim with its $\varepsilon_n$, and state the isolation radii it must sit below.** Until some $r_i$ is bounded from below, "rigidity finishes it" is a plan with an unquantified constant on each side. **This one is genuine mathematics, and it is the real content of the open core**, the missing quantity is an explicit lower bound on the isolation radius of a Morse–Bott orbit, which the Hessian spectra at [L26](../findings/nondegeneracy.md#L78)/[L28](../findings/nondegeneracy.md#L504) plausibly reach. Reachable in principle; not reachable by editing.
6. **Move the "COMPLETE" sub-section under [Lemma L57](../findings/problem.md#L527)**, resolve the $n=4$/$n\ge5$ uniqueness contradiction, and reconcile "Gate 2 owed" at [line 246](../findings/problem.md#L246) with "two independent Gate 2 proofs" at [line 392](../findings/problem.md#L392), the latter naming its reviewers. **Reachable.**
7. **Incidental, outside L19, three items flagged for whoever owns those files**: [fence-posts.md](../findings/fence-posts.md) carries **two posts numbered F4**, [line 70](../findings/fence-posts.md#L70), "Moduli do not preclude bounds", and [line 160](../findings/fence-posts.md#L160), "Łojasiewicz constants are astronomically large"; that second F4's body has lost its opening and begins with a comma; and [nondegeneracy.md:454](../findings/nondegeneracy.md#L454)'s "the two-block plateau at the rival maximizer" states, as written, that the rival maximizer is degenerate, the plateau is a distinct point at $\theta=0.866025$.

## Method note

Analysis only, per the standing rule stated in the brief. **No computation of any kind was run**, including no screen: every number quoted above was read out of the record and checked by hand ($\Theta_4^2=3/4$, $\theta_0(12)^2=220/144=55/36$, $\sqrt{3/2}/\sqrt2=0.866025$, $\tfrac12-\mu$ sign at $(3,3)$ and at $\min(p,q)=2$). The provenance question was settled with `git show` on `a9e4b8c0` and a distinctive-phrase grep, as the brief directed. Nothing in this report would change under any run I could have made.
