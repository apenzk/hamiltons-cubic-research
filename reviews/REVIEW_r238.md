# REVIEW r238 -- Gate 2, brief24 (A1 canonical-lift reduction)

Reviewer 238. Commit under review: fb10569, [run_a1_canonical_lift.py](../scripts/runs/run_a1_canonical_lift.py).
Assigned claims: 6 (priority), 4, 5. (Reviewer 237 runs 1, 2, 3 concurrently.)

## Verdict table

| # | Claim | Verdict |
|---|-------|---------|
| 6 | Universal degree-6 count for (Sym^6 W_n)^{O(n)} = 89? | **SETTLED: it is 89.** The certificate base is n = 12 and the k_B >= 24 obstruction is dead |
| 4 | The two corollaries (wrong base costs search time only; free-index worry dissolves) | **(a) UPHELD, and stronger than stated -- but it cites the wrong half of the verification. (b) OVERSTATED -- the worry is relocated into the pairing, not dissolved; witness with an exact factor of n** |
| 5 | The degree-3 screen tests the mechanism, or a Lovelock collapse | **HALF AND HALF, and the missing half is the load-bearing one.** The climb is a real dimension-driven collapse, exactly reproduced exactly; the *freeze* is forced by the column ceiling, and the screen passes on a planted family for which fact (ii) is outright false |

**Bottom line.** The owed check comes back the way A1 hoped: **the universal degree-6 count is 89**, computed two independent ways, so the certificate base is n = 12 and the k_B >= 24 obstruction no longer binds the route. The two corollaries and the screen fare less well. Corollary (a) is true, and for a cleaner reason than the file gives, but the sentence supporting it names only half the certificate. Corollary (b) is overstated: contracting the covariants' free indices does not land the check inside the grammar r232 audited, and a bare metric on the free indices produces an exact factor of n. The screen exhibits a genuine dimension-driven collapse and then reports a freeze that its two columns made inevitable, and it passes a planted family for which fact (ii) is false.

## Findings

### Claim 6 -- the owed check. The universal count is 89. SETTLED.

**dim (Sym^6 W_n)^{O(n)} = 89 for every n >= 24, hence for every n >= 12.** The sequence the record measured -- 88, 88, 89, 89, 89 at n = 10, 11, 12, 13, 15 -- reaches its universal value at n = 12 and never moves again. A1's equivalence therefore fires with n_0 = 12: the lift is canonical from 12, and the B_n route's k_B >= 24 is not needed to place the base.

**How it was computed**, in [universal_count.py](../scripts/reviewers/r238/universal_count.py) (output: [out_universal_count.txt](../scripts/reviewers/r238/out_universal_count.txt)), from two classical facts and nothing read from this repo:

1. The stable character of the Weyl module is Littlewood's omega_(2,2) = s_(2,2) - s_(2), so Sym^k of it has character h_k[omega_(2,2)].
2. Littlewood's restriction rule, valid for ell(lambda) <= n/2, gives the multiplicity of the trivial O-rep in s_lambda as c^lambda_{(), delta} summed over even delta -- which is **1 exactly when every part of lambda is even, and 0 otherwise**.

So the universal count is the sum of the Schur coefficients of h_k[omega_(2,2)] over all-even partitions, i.e. the Hall pairing with sum_{lambda even} s_lambda = prod_{i<=j}(1 - x_i x_j)^{-1} = exp( sum_m (p_m^2 + p_{2m})/(2m) ). Both factors are built in the **power-sum basis** with exact `Fraction` arithmetic, so the degree-24 Schur expansion -- the step that makes this expensive -- is never taken. The whole run is under a second.

Every constituent of h_k[omega_(2,2)] has at most 2k rows, so the restriction rule applies for n >= 4k. The number is the value at every n >= 4k = 24; the record's own padding-monotonicity then squeezes n = 12 through 23 to the same 89, since 89 is attained at 12 and cannot exceed the ceiling above.

**What makes this more than one number.** The routine also returns the whole degree sequence, and it is an independent reproduction of the record's finite-n table:

| k | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|
| universal (this run, n >= 4k) | 0 | 1 | 2 | 7 | 19 | **89** |
| record's n = 12 values | -- | 1 | 2 | 7 | 19 | 89 |

Five agreements from a method that shares no code and no machinery with the coset/Weyl-integration route that produced the record's row. The k = 3 entry independently matches [reviewer 224](REVIEW_r224.md)'s omega-basis table, whose empty-partition multiplicity is 2. Two internal sanity gates also pass: `<s_(2), H> = 1` against `<s_(1,1), H> = 0` pins the even-partition pairing, and omega_(2,2) evaluated at p_k -> 12 returns 1638 = dim Weyl_12, pinning the character.

**Independently cross-checked in Sage.** [xcheck_sage.sage](../scripts/reviewers/r238/xcheck_sage.sage) takes the plethysm with Sage's own `h[k].plethysm(s[2,2]-s[2])`, expands in the Schur basis in full (degree 24 included) and sums the even-partition coefficients directly. It reproduces 0, 1, 2, 7, 19, **89** ([out_xcheck_sage.txt](../scripts/reviewers/r238/out_xcheck_sage.txt)) -- a different implementation of the plethysm, a different basis, and the same answer.

**Consequence for the route.** The open question [plan.md](../plan.md) recorded -- that "89 for all n >= 12" was an observation over three dimensions with the first fundamental theorem guaranteeing stability only from n >= 4k = 24 -- is now closed at the top end rather than by squeeze alone. The stable value *is* 89, so the measured 89s at n = 12, 13, 15 are the stable value and not a coincidence below threshold. Combined with monotonicity, dim is constant on [12, infinity).

### Claim 4 -- the two corollaries

#### (a) "A wrong guess at the base costs search time, never correctness." UPHELD, and the reason is better than the one given.

**The mechanism is that a too-low base is a RELAXATION, and the file has the ingredient without using it.** The certificate condition is that the residual `sum B_ij D_ij - G` lies in `ker eps_{n_0}`. Fact (ii) says `ker eps_n` is contained in `ker eps_{n_0}` for n >= n_0, so **the base has the largest kernel and therefore the weakest condition**. Searching at a too-low base optimises over a superset of the universal feasible set: no valid certificate is ever excluded, only spurious ones admitted, and the spurious ones die at A4's formal check. That is exactly "search time, never correctness", and it is a one-line consequence of the containment the file already states.

**The same direction makes the route's own falsifier safe, which the file does not notice.** [plan.md](../plan.md)'s stated killer is "the n=12 SDP is infeasible". Because n = 12 is the relaxation, infeasible at the base implies infeasible universally -- so a negative verdict at the base is sound too, not merely a failed search. Had fact (ii) run the other way, that falsifier would prove nothing.

**Two things the corollary as written does not carry.**

1. **It names only A4, and A4 is half the certificate.** The theorem A wants is `mu_n(B(n)) = G_{mu,n}` identically in n **and** `B(n) >= 0 for all n >= 12`. A4 delivers the identity; the PSD half is A5, Sturm on the minor numerators. The corollary's argument -- "the final verification is an identity in the universal ring, an identity there specialises to every n at once" -- reaches the identity only. Were A5 absent, a `B(n)` PSD at the four fit dimensions and indefinite at n = 20 would pass every check the corollary invokes, and that is a correctness failure produced by where the search sat. The corollary is true; the sentence supporting it is not sufficient for it. It should read "A4 and A5".
2. **"Specialises to every n at once" needs the entries to be defined at every n.** A4's entries are fitted in Q(n), not Q[n]. An identity between rational functions is an identity in the field, and its specialisation at an integer where a denominator vanishes is undefined -- `(n-20)/(n-20) = 1` is a perfectly good identity in Q(n) and says nothing at n = 20. The side condition is that no fitted denominator has a root at an integer in [12, infinity), it is finitely checkable, and it is not stated anywhere.

**And for the choice actually at issue, the corollary is now moot.** With claim 6 settled, base 12 and base 24 present the *identical* linear system: the same 477 unknowns, by the block-table stability theorem whose threshold is exactly 12, against the same 89 constraints, by the universal count. There is no wrong guess left to cost anything.

#### (b) "The covariant free-index worry dissolves ... the check lives among complete contractions, where the no-free-loop lemma is audited." OVERSTATED. The worry is relocated, not dissolved.

Witness: [claim4_corollaries.py](../scripts/reviewers/r238/claim4_corollaries.py) ([output](../scripts/reviewers/r238/out_claim4.txt)). An exact integer Weyl tensor is built on R^4 -- antisymmetry, pair symmetry, first Bianchi and trace-freeness all verified -- and zero-padded into n = 4, 5, 6, 7, 8, 10, 12, the padding r232 checked stays Weyl. Three pairings of degree-3 covariants, in `Fraction` arithmetic:

| pairing | value across n = 4 ... 12 |
|---|---|
| `<P, Q>`, both pure-Weyl diagram covariants | `10246401/16384` at every n -- **constant** |
| `<P, M>`, pure against metric-carrying | `10246401/4096` at every n -- **constant** |
| `<M, M>`, both metric-carrying, `M_ab = g_ab * I3(W)` | **`n * I3^2`, verified exactly at all seven dimensions -- linear in n** |

**Why the audited lemma does not reach the third row.** [r232](REVIEW_r232.md)'s grammar is explicit and its proof turns on it: a degree-d complete-contraction diagram has exactly 4d slots, four per Weyl factor, and D is a perfect matching *of those slots*; a free delta-loop "would need an edge joining two endpoints of the same delta, i.e. a slot belonging to no tensor. There is no such slot." A bare metric on a covariant's free indices **is** a delta whose endpoints belong to no tensor, and contracting two covariants that each carry one closes precisely the excluded loop: `g_ab g_ab = delta^a_a = n`. So the passage to complete contractions is real -- the free indices do get contracted -- but it lands in a strictly larger grammar than the one that was audited, and in that larger grammar the factor of n is realisable, as the third row shows.

**The record already says so, in the sentence next door.** [plan.md](../plan.md) A2: *"Every Gram entry of two diagram covariants is a closed Brauer diagram, valued a polynomial in n"*, and section 2 item 2 asks for *"the Brauer pairing matrix as polynomials in n. Closed-diagram evaluation with loop-counting."* Loop counting is the free-loop phenomenon, named, expected, and budgeted for. The corollary says the same objects are covered by a lemma whose content is that no loop can occur. **Both sentences cannot describe the same objects**, and the file offers no criterion separating them.

**What would actually close it**, and it is close to hand: the corollary is correct exactly when every covariant in the spanning set used is a *pure-Weyl* diagram covariant, with no bare metric on the free indices -- the first row above. An irreducible covariant is traceless, so a bare metric on two free indices cannot survive in it; but the diagrammization step (section 2, item 1) expresses each covariant "in the diagram spanning set", and a *spanning set* for O(n) covariants must include metric-carrying diagrams, whose individual Gram entries then do carry n. The claim that survives is therefore conditional: *the check lives among complete contractions of Weyl factors only, hence is n-independent, provided the covariant spanning set is restricted to metric-free diagrams* -- a restriction that has to be justified, since it is a restriction of a spanning set. As written, "dissolves" claims an unconditional result the audited lemma does not supply.

**Scope note.** This is a statement about the *reason* offered, not a refutation of the route. n-dependent Gram entries are not fatal -- A2 plans for them and A4 verifies in the Brauer ring with n formal, where polynomial-in-n entries are ordinary. What fails is the corollary's claim that the worry is *gone*.

### Claim 5 -- the screen. Half of the mechanism, and the wrong half.

Scripts: [claim5_screen.py](../scripts/reviewers/r238/claim5_screen.py) ([output](../scripts/reviewers/r238/out_claim5_screen.txt)), [claim5_plants.py](../scripts/reviewers/r238/claim5_plants.py) ([output](../scripts/reviewers/r238/out_claim5_plants.txt)). Neither touches the file under review; the screen's three asserts are reproduced structurally and driven with mutated inputs.

**What the new screen fixed, and it is a real fix.** The climb is genuine and survives exact arithmetic. Recomputing the two cubic contraction classes over `Fraction` on integer Weyl tensors -- no floating-point rank tolerance anywhere -- gives rank 1 at n = 4 and n = 5, rank 2 at n = 6 and n = 7. That is the classical Lovelock-type dimension-dependent identity, and the record's own count `dim (Sym^3 W_n)^O` = 1 at n = 5, 2 at n >= 6 (the universal value confirmed at 2 under claim 6 above) says it is exactly that. The degree-2 version this replaced showed nothing; this one shows a relation dying. So the author's diagnosis of their own first screen was right, and the replacement is a strict improvement.

**But the freeze -- the half the reduction actually needs -- is structurally forced.** The matrix has one column per diagram, and there are two diagrams. Once the climb assert has forced `vals[-1] = 2`, the freeze assert `vals[-1] == vals[-2]` can only fail if the rank were still 1 at n = 10 and 2 at n = 12. Enumerating every rank sequence over the seven dimensions the screen visits: 33 survive the first two asserts and the freeze assert rejects 8 of them -- **24% discriminating power, and it falls out of the column count, not out of the mathematics.** The same enumeration at K = 10 columns rejects 59%. The point of fact (iii) is that the rank stops climbing *because it has reached the universal value*; the miniature stops climbing because it has run out of columns. Those are different events and the screen cannot tell them apart. At degree 6 the ceiling is the number of diagrams (184), the universal value is 89, and the gap between the two is the entire question -- exactly the gap the miniature does not model.

**And the screen passes on a family for which fact (ii) is false.** Fact (ii) -- `ker eps_n` contained in `ker eps_{n_0}` -- is a statement about **subspaces**; the screen compares integers. In the miniature the kernel at n = 4 and n = 5 is a line in a 2-dimensional space, so nesting is the sharp and testable statement "the same line". Measured: both are `q1 : q2 = -1/2 : 1` to 5e-16, so fact (ii) does hold for the real diagrams -- and the screen never looks.

Plant P4 exploits that. Replace the second diagram by `q2 + n*q1` -- an explicitly n-dependent contraction, precisely what a detached delta-loop contributes, and r232's own control for that phenomenon scaled as `46416*n`. The rank sequence is **unchanged**, `[1, 1, 2, 2, 2, 2, 2]`, and all three asserts pass. Yet the kernel line is `-(n + 1/2) : 1`, measured as `-4.5 : 1` at n = 4 and `-5.5 : 1` at n = 5: **different lines, so `ker eps_5` is not contained in `ker eps_4` and fact (ii) fails outright** -- while the screen prints "the mechanism of the reduction, visible".

That is the finding. The screen exhibits fact (iii)'s *consequence* (a nondecreasing rank) and is blind to fact (ii)'s *content* (nesting kernels), which is the step claim 1 identifies as load-bearing and the step a wrong padding convention would break. A one-line addition would close it: at each n with a nontrivial kernel, check the kernel subspace is contained in the base's.

**The three planted assert violations all fire as intended.**

| plant | mutation | ranks | assert fired |
|---|---|---|---|
| P1 | dimensions visited in reverse order | `[2,2,2,2,2,1,1]` | monotone (and climb) |
| P2 | dimension list starts at n = 6, above the collapse | `[2,2,2,2,2]` | climb |
| P2' | second diagram replaced by a multiple of the first | `[1,1,1,1,1,1,1]` | climb |
| P3 | dimension list truncated at n = 6, at the climb | `[1,1,2]` | freeze |
| **P4** | second diagram replaced by `q2 + n*q1` | `[1,1,2,2,2,2,2]` | **none -- passes, and fact (ii) is false for it** |

So the asserts are live, not decorative -- the author's own note that the earlier version's asserts "check arithmetic it does not depend on" does not apply here. They are live and they guard the wrong perimeter.

**Verdict.** The screen tests the mechanism's *first* half -- that a dimension-driven relation exists and dies -- and does so honestly with a genuine Lovelock collapse. It does not test the second half, and the freeze it reports is an artefact of having two columns. Its closing sentence, "at and above it the kernel is pinned and the lift from that base is canonical", asserts something about kernels that nothing in the run measures.

## Recommendations to the record

1. **[plan.md](../plan.md), the 89.** Retire "the first fundamental theorem guarantees stability only from n >= 4k = 24" as an open edge on the invariant count. The stable value is now computed and it *is* 89, so the measured 89s at n = 12, 13, 15 are the stable value, and padding monotonicity closes [12, 24) from below. The count is 89 on [12, infinity) as a theorem, not an observation over three dimensions.
2. **A1's owed item is discharged.** The file's "OWED, one finite exact check" is done, and the answer is the favourable branch: base n_0 = 12, post F32's k_B >= 24 stands as a statement about the B_n routing and does not bind route A.
3. **Corollary (a), one word.** "The certificate's final verification (plan item A4)" should read "(plan items A4 and A5)"; the PSD half is where a base-dependent error would actually survive an identity check. Add the side condition that no fitted denominator vanishes at an integer in [12, infinity).
4. **Corollary (b), rewrite as conditional.** "Dissolves" should become "is confined to the pairing, and vanishes exactly on the metric-free part of the covariant spanning set". Then either justify restricting the spanning set to metric-free diagrams, or keep A2's polynomial-in-n Gram entries and drop the appeal to the no-free-loop lemma -- the two are inconsistent as stated.
5. **The screen, one addition.** At each n where the kernel is nontrivial, check the kernel **subspace** against the base's. Two lines, and it is the only part of the run that would test fact (ii) rather than its consequence. Plant P4 is the regression case.
