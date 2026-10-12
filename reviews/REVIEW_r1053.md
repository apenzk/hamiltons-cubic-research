# REVIEW r1053: the I77 pair-cap commit, the I77 deletion, and the r1052 fold

**Scope**: `4f905725` (I77PairCap.lean, the pair cap declared inert), `c957b09e` (deletion of the withdrawn I77 closure), `33c37661` (the r1052 fold). SOLE reviewer. Analysis-only footing. The one run below is a SCREEN on objects already in hand, reported as a screen.

| # | claim | verdict |
|---|---|---|
| 1 | the four typed statements, and the vertex against the record | **CONFIRMED**, with the framing corrected: `vertex_total_s_free` is the programme's own first EQUALITY, not a property of the vertex |
| 2 | the untyped reduction, ordered pairs to total triple mass | **CONFIRMED**, and stronger than stated: the summed cap is implied at EVERY feasible point, not merely slack at one |
| 3 | "inert", the cap cannot move the optimum at any $s$ or any $n$ | **REFUTED.** The record's own low-branch vertex VIOLATES the cap, and adding it moves the programme's $n=12$ bound from $3.853570$ to $2.42212$ |
| 4 | the AGREEMENT classification against [stratum-two-negative.md](../findings/stratum-two-negative.md) | **CONFIRMED**, and the overlap is UNDERSTATED rather than overstated: all four numbers of the new block pre-exist, including the $6.5$ |
| 5 | the deletion in `c957b09e` | **CONFIRMED** on the bytes and on the absence, with one residue left behind and the heading count is quoted as $73$ when it is $81$ |
| 6 | the r1052 fold in `33c37661` | **PLAUSIBLE.** Applied in substance, but one r1052 finding is DROPPED, one bullet withdrawing more than r1052 asked, one new overreach in W7 |
| 7 | overreach sweep | four further items, all minor beside claim 3 |

---

## Claim 3 first, because it is the one that breaks, and it has spread

**The vertex arithmetic is right and the conclusion drawn from it is false.** The parent aggregated the pair cap in ONE way, over all $N(N-1)$ ordered pairs, found the result implied, and concluded that the cap says nothing in the $t_j$. But the $t_j$ are defined by a partition of the index set, and the pair cap admits THREE aggregations compatible with that partition, all of which land in these very variables.

**The three constraints.** With $A$ the positive level set, $s=\lvert A\rvert$, $p=N-s$, and $T$ totally symmetric ([conventions.md](../findings/conventions.md) line 61), of the six orderings of a distinct triple carrying $j$ indices in $A$, the number whose FIRST TWO entries lie in a named part is $6,2,0$ and so on. Summing [Lemma L31](../findings/stratum-two-negative.md)'s $\sum_\gamma T_{\alpha\beta\gamma}\le2$ over each part of the ordered pair set gives

$$t_3+\tfrac13t_2\ \le\ 2s(s-1),\qquad \tfrac23(t_1+t_2)\ \le\ 4sp,\qquad t_0+\tfrac13t_1\ \le\ 2p(p-1),$$

whose sum is exactly the parent's $\sum_jt_j\le2N(N-1)$. **The parent added the three and threw away the summands.**

**The record's own vertex violates the first, by exact arithmetic and with no run.** [diagonal-half.md](../findings/diagonal-half.md) line 1322 records the low-branch vertex at $n=12$, $s=6$: $t_0=1200$, $t_3=120$. The $AA$ cap allows $2s(s-1)=60$. **$120>60$**, so that point is infeasible under the pair cap and the cap cuts the feasible set.

**Where it binds, in closed form.** On the low branch ($s<N/3$) the vertex is $\{0,3\}$ with $t_3=J/3=2(n-2)s$, so the $AA$ cap reads $2(n-2)s\le2s(s-1)$, that is $s\ge n-1$. **The cap therefore binds on exactly $n/2\le s\le n-2$**, a window nonempty at every $n\ge4$ and sitting inside the admissible range the record itself insists the check must cover.

**SCREEN** (exact rationals over the four-variable vertex enumeration, seconds, objects in hand, reported as a screen). At $n=12$ the uncapped whole-range maximum reproduces the record's own printed $3.853570$ ([diagonal-half.md](../findings/diagonal-half.md) line 1408) to six digits, at $s=6$. **With the three cap constraints added the maximum is $2.42212$, at $s=11$.** Sample: $s=6$ falls $3.8536\to2.1409$, $s=8$ falls $3.1429\to2.3236$, $s=10$ falls $2.6320\to2.4113$, and from $s=11$ upward the two agree exactly, as the $s\ge n-1$ algebra predicts. **At the forced $\{1,3\}$ vertex all three constraints are slack**, so the parent's slackness observation is true where it was made and false as a general statement.

**The record knew.** [diagonal-half.md](../findings/diagonal-half.md) line 1324 already says, in [r864](REVIEW_r864.md)'s repair, that "summing over $\alpha$ in each part turns the pair caps into THREE exact equalities on the $t_j$", which is this same aggregation with $A$-regularity upgrading the inequalities. And line 1408, two paragraphs BELOW the new block, still names the pair cap as "a genuine $T$-inequality this relaxation never used" and lists adding it as one of the three ways out. **The new block contradicts its own neighbour and neither sentence was reconciled.**

**And the consequence is the opposite of inert.** $2.42212<3.0509$, so the pair cap is the single addition that takes the $T$-only relaxation BELOW the record's standing bound at $n=12$. The block that declares it inert is standing on the one route in the paragraph that works.

**Corrections owed**, three places:

- [diagonal-half.md](../findings/diagonal-half.md) line 1406, the "INERT IN THESE VARIABLES" block. What survives is the narrow true statement: *summed over ALL ordered pairs the cap is implied by the marginal equality $\sum_jt_j=2N(n-2)$, so that ONE aggregation is redundant at every feasible point.* The generalisation to "no per-pair information survives the $t_j$ aggregation" is false and the three part-sums are the counterexample.
- [plan.md](../plan.md)'s I77 row, which now reads "**The pair cap is INERT here**, slack by $(n+1)/2$ at the forced vertex, so it is not merely untried" with "**Owed**: a finer variable set keeping per-pair information, which the $t_j$ aggregation destroys". Both clauses are wrong, and the owed line points the item away from the route that improves it. The row also silently dropped "**Route**: a MOMENT PROBLEM with its lower three moments pinned". That route survives at [diagonal-half.md](../findings/diagonal-half.md) line 1335, so the record keeps it, but the plan no longer names it.
- [lean/INDEX.md](../lean/INDEX.md)'s I77 row, which repeats "the per-pair information does not survive the $t_j$ aggregation".

**The Lean file itself needs no change.** Its four propositions are true and its docstring's *arithmetic* is right. What is wrong is the sentence "**What this file types is why the PAIR CAP cannot move that optimum**", which claims for four `ring`-level identities a conclusion about an LP they do not reach.

## Claim 1, the identity: CONFIRMED, with the framing corrected

**The vertex matches the record exactly.** [diagonal-half.md](../findings/diagonal-half.md) line 1318: $t_1=3(n-2)(N-s)$ and $t_3=(n-2)(3s-N)$, feasible exactly when $N/3\le s\le N$. The Lean file takes these as given and says so, in the docstring and in the "**NOT stated**" clause of its [lean/INDEX.md](../lean/INDEX.md) row. Honest.

**All four statements are true and the file elaborates clean**, `lake env lean HamiltonsCubic/Results/I77PairCap.lean`, no output, exit 0, no `sorry` in the source.

- `vertex_total_s_free`: $3(n-2)(N-s)+(n-2)(3s-N)=2N(n-2)$ over $\mathbb Z$, a `ring` identity.
- `two_mul_pred_card`: $2N-2=n^2-n-2=(n-2)(n+1)$.
- `pair_cap_slack`: $2(n-2)\le(n-2)(n+1)$ reduces to $(n-2)(n-1)\ge0$, true at $n\ge2$.
- `vertex_total_le_cap`: immediate from the previous with $N\ge0$.

**The correction is to what `vertex_total_s_free` MEANS.** The prose says the total triple mass is free of $s$ *at I77's forced vertex*. But $\sum_jt_j=2N(n-2)$ is the programme's FIRST EQUALITY CONSTRAINT, holding "at EVERY orthonormal basis of $\mathfrak{so}(n)$" ([diagonal-half.md](../findings/diagonal-half.md) line 1318, from [Lemma L153](../findings/bounds.md) summed over $\alpha$). **The total is $s$-free on the whole feasible set, vertex or not.** The theorem checks that the forced vertex satisfies constraint one, which is a consistency check on the vertex formulas, not a discovery about the vertex. That matters for claim 3: it is why the summed cap is redundant everywhere rather than slack somewhere.

**Minor.** `vertex_total_le_cap`'s `hNpos : 0 ≤ N` is redundant, forced by `hN` and `hn`. The docstring says "**The two facts below are the whole of it**" above four theorems.

## Claim 2, the reduction: CONFIRMED, and the parent understated it

**Each of the three worries the brief names comes out in the parent's favour.**

- **Repeated indices.** $T_{abc}=c_{abc}^2$ with $c$ totally antisymmetric, so $T$ "vanishes when two indices coincide" ([conventions.md](../findings/conventions.md) line 61, stated outright). Hence $\sum_{a\ne b}\sum_cT_{abc}=\sum_{a,b,c}T_{abc}$, and whether the $t_j$ admit repeats is moot.
- **Partition.** The $t_j$ split the ordered triples by how many indices lie in $A$, which is a partition of all ordered triples into four classes, so $\sum_jt_j=\sum_{a,b,c}T_{abc}$.
- **The count.** Ordered pairs with $a\ne b$ number $N(N-1)$, each capped at 2.

So $\sum_jt_j\le2N(N-1)$ is correct, and each ordered distinct triple is indeed counted once.

**Understated.** Since $\sum_jt_j=2N(n-2)$ is an EQUALITY of the programme, the derived inequality is not merely slack at a vertex, it is **implied at every feasible point** and could never have cut anything. The right statement of the true half is a redundancy claim, not a slackness claim, and it needs no vertex at all.

## Claim 4, the agreement: CONFIRMED, and if anything understated

**[stratum-two-negative.md](../findings/stratum-two-negative.md) line 51 carries all of it already**: the mean of $\lVert[v_\alpha,v_\beta]\rVert^2$ as $2(n-2)/(N-1)$, the cancellation $N-1=(n-2)(n+1)/2$ collapsing it to $4/(n+1)$, the values $\tfrac47,\tfrac49,\tfrac4{11},\tfrac4{13}$, **and the ratio against the cap explicitly**: "Against the cap $2$ the chain spends everywhere the ratio is $2/(n+1)$, so the waste widens with $n$, a factor $3.5$ at $n=6$ against $6.5$ at $n=12$."

**Derived independently here**: the mean over ordered pairs is $\frac{1}{N(N-1)}\sum_{a\ne b}S_{ab}=\frac{2N(n-2)}{N(N-1)}=\frac{2(n-2)}{N-1}=\frac4{n+1}$, and the parent's slack $(N-1)/(n-2)=(n+1)/2$ is its reciprocal against the cap $2$. **They are one fact**, and the parent is right that one route is the pair marginal and the other the triple total.

**The classification is not used to dodge novelty, nor stretched to claim any.** If anything the commit message understates: it credits the record with the mean and keeps the ratio step, while the record states the ratio itself and even prints the parent's headline "$6.5$ at $n=12$" verbatim. [diagonal-half.md](../findings/diagonal-half.md) line 1409 gets this right and says the record gives the ratio "in its own words". **So every number in the new block pre-exists.** What it adds is the consequence, which is claim 3, which is false.

## Claim 5, the deletion: CONFIRMED on the arithmetic, one residue, one wrong number

- **761 bytes.** Reproduced exactly: $437449-436688=761$.
- **Headings unchanged.** True, but **not at 73**. `grep -c '^#'` and `grep -cE '^#{1,6} '` both give **81** at `c957b09e^` and at `c957b09e`, while `^#### ` alone gives 72. The check the editing rule asks for was performed and reported with a number nothing reproduces, which is worse than not reporting one, since a later reader comparing against 73 will conclude the file changed.
- **No strikethrough under `findings/`.** Confirmed at the commit (`git grep '~~' c957b09e -- findings/` empty) and at HEAD.
- **Nothing else was lost.** The hunk removes exactly two block-quote paragraphs, the struck headline and the unstruck "closes on the post" conclusion, plus one bare `>` separator. The surviving paragraph is byte-identical up to the appended positive statement, and the paragraphs above and below are untouched context. **The deletion-by-anchor hazard did not fire.**

**The residue.** The surviving paragraph still ends "**The struck text is kept below so the claim and its refutation are read together.**" **Nothing is below.** That sentence was true of the previous revision and is false of this one, and it is the kind of dangling pointer the same commit's own rationale is about. Delete it, or replace it with the chronology pointer that already follows.

## Claim 6, the fold: PLAUSIBLE

**Folded correctly, checked line by line against [r1052](REVIEW_r1052.md).**

| r1052 finding | in the fold |
|---|---|
| claim 8(a), plan.md's "dead below $n=12$" is a regression, $\sqrt{3/2}$ dies AT $n=12$ | **reverted**, and W7 rewritten to say "FAILS INSIDE THE GOAL'S OWN RANGE" |
| claim 5, "TWICE" needs a threshold the paragraph loosened, and $\mathbb{CP}^3$ sits AT $\theta_0(6)$ | **applied**, now "ONCE", with $\mathbb{CP}^3$ refuting "only in its $\ge$ form" |
| claim 8(b), "two rows above" wrong for one witness | **fixed by deletion** of the clause |
| claim 8(c), lean/INDEX.md I104 "IS NOW TYPED, with a named `sorry`" | **retired**, the clause now reads "PROVED" |
| claim 6, L164 padding DOES propagate, failing only because $\theta_0$ rises while padding freezes $\theta$ | **applied**, with the crossover $6+2\sqrt7=11.2915$ |
| claim 6, the absence claim is oversold, post F43's $(30,20,16)$ at $\theta=1.2917$ | **applied**, with "realisability explicitly open" and [I24a](../plan.md) named |
| claim 6, W7 was not updated and is the file a session reads first | **applied**, W7 now carries the $n=6$ failure and the $n\ge12$ question |
| r1052 indexed | **applied** |

**DROPPED, and it is the sharper half of the finding it belongs to.** [r1052](REVIEW_r1052.md) paragraph 99's second reason: *the strict-inequality witness is nearly forced to be absent, because a realised critical point at even $n\ge12$ with $\theta>\theta_0(n)$ refutes Conjecture A outright, so its absence is the conjecture being open rather than evidence for the candidate. **The only genuinely informative case is the boundary**, $\theta=\theta_0(n)$ EXACTLY with $s\ge3$, which is the $\mathbb{CP}^3$ shape and which nothing on the record excludes at $n\ge12$.* That appears nowhere in [diagonal-half.md](../findings/diagonal-half.md), [INDEX-traps.md](../findings/INDEX-traps.md) or [plan.md](../plan.md) after the fold. **It should be folded**: it tells I73 which witness to look for, and the fold instead installed F43, the witness whose absence proves nothing. Also unfolded, all minor: r1052's request to label "five attempts changed only tactics" a self-report, the I67 row's two appends joining without a full stop, and the pre-existing defect that the I104 status cell read `proved` while the file carried a `sorry`.

**Withdrew more than r1052 asked.** The bullet "**THE NARROWING TO n>=12 IS WITHDRAWN**" reads as withdrawing the restriction. [r1052](REVIEW_r1052.md) paragraph 91 says the opposite: "**The restriction to $n\ge12$ is correct and is not too generous**", since [plan.md](../plan.md) states Conjecture A for even $n\ge12$. What r1052 withdrew is the *verb*: "Nothing was narrowed, because the candidate had no content below the crossover to lose." **The record text the commit wrote gets this right** ("AND NOTHING HERE NARROWED TO $n\ge12$, WHICH A FIRST VERSION OF THIS BLOCK CLAIMED") and [plan.md](../plan.md) keeps $n\ge12$ in the owed line. So the defect is in the commit message alone, which is where a later session reads the chronology.

**One NEW overreach introduced.** W7 now reads "**NO RESTRICTION TO $n\ge12$ RESCUES IT**", justified by post F43. **F43's realisability is open**, as the same sentence says. An unrealisable spectrum rescues nothing and refutes nothing, so the bolded claim is stronger than its own evidence. The row confesses to having "been wrong in three directions on these witnesses", and this is the fourth shape of the same move. It should read that no restriction to $n\ge12$ is KNOWN to rescue it, with F43 the open case and [I24a](../plan.md) the decider.

## Claim 7, overreach sweep

Beyond claims 3, 5 and 6:

- **`4f905725` Gate 1 (b), "agreeing at $p=2,3,4,6,7$".** The balanced-product counts satisfy $12\binom p2p+12\binom p3=4p(p-1)(2p-1)=2N(n-2)$ **identically in $p$**, so the five agreements are one algebraic identity evaluated five times. True, and weaker corroboration than five independent checks would be.
- **`4f905725` drops the I77 route from plan.md** ("a MOMENT PROBLEM with its lower three moments pinned") without saying so. The route survives at [diagonal-half.md](../findings/diagonal-half.md) line 1335, so the record loses nothing, but the plan row no longer names it and the replacement "Owed" line is the refuted one.
- **`33c37661`'s "the audit's 19 are exactly the file's 19 theorems"** and the byte-identical signature are [r1052](REVIEW_r1052.md)'s own confirmed findings restated rather than new claims, so no overreach.
- **`33c37661`'s "the crossover 11.2915 recomputed here"** checks: $6+2\sqrt7=11.29150$.

## What a successor should do first

1. **Revert the INERT claim** in the three places above, keeping the narrow redundancy statement about the single all-pairs aggregation.
2. **Add the three part-sums as constraints on the $t_j$** and record the screened consequence, $3.853570\to2.42212$ at $n=12$, as the thing I77 is owed. It needs a Gate 2 round of its own, since the number above is a screen rather than evidence.
3. **Fold [r1052](REVIEW_r1052.md)'s boundary case** into [diagonal-half.md](../findings/diagonal-half.md)'s I73 block: the informative witness is $\theta=\theta_0(n)$ exactly with $s\ge3$ at $n\ge12$.
4. **Delete the dangling "the struck text is kept below"** sentence, and drop the unreproducible heading count from the editing rule's check or fix the pattern it names.
