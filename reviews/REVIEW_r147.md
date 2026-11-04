# Gate 2, reviewer r147, the padding repair, the 145/146 split, the fence-post downgrade

Cold review of [plan.md](../plan.md) item 1 after `2fc13f6`, `5d992c5` and `dc57609`. Derivation only; no machinery rebuilt, no script run. Every number below is either read off the record or checked by hand in one line.

## Verdict

| claim | verdict |
|---|---|
| 1. the padding repair | **the inference is sound but the repair is defensive**, and its stated rationale rests on one inert premise and one the record contradicts |
| 2. the 145/146 split | **the arithmetic is right and the resolution is wrong**, 145 rescues something that was never at risk, and the split is a scope confusion rather than a disagreement |
| 3. the fence-post downgrade | **correct on the mathematics, incomplete in its bookkeeping**, it refuted a claim and left two live copies of it |

**The finding that outranks all three:** on the record's own ascent data, **(G) is false at $n=6,8,10$**. Padded $W_{\mathbb{CP}^2}$ is not merely an ungraded critical point there, it is the *global maximiser*, and it is ungraded. So (G) as [plan.md](../plan.md) states it, with no dimension restriction, is refuted below the crossover, and the crossover is therefore load-bearing inside any proof of (G) rather than an escape hatch bolted on after one.

## Claim 1, the padding repair

### What is sound

The literal inference is valid and trivially so. The witness is padded; a statement quantified over unpadded points does not see it. Nothing wrong there.

"Unpadded" is also a legitimate predicate: $W$ is padded iff it annihilates some vector of $\mathbb R^n$, which is $O(n)$-invariant, closed, and of positive codimension. A restriction to unpadded points is not vacuous or ill-formed.

### Does the restriction empty the target? No, and the record already answers the question [plan.md](../plan.md) records as open

The current "Where to restart" section asks: *of the 155 ungraded critical points at $n=6$ behind the $[1.17,96.3]$ range, how many are unpadded?* [nondegeneracy.md](../findings/nondegeneracy.md) answers it in three separate places, with no computation needed:

- **Twenty-four points at $n=6$, explicitly kernel-free and unpadded.** "Twenty-four points across three cones have $S_{\mathfrak{mmm}}$ at $10^{-30}$ and $S_{\mathfrak{hhm}}$ nonzero, $17.0000$ at the smallest-gap one, $\theta=0.104886$. They are slack-zero, ungraded, and carry **no kernel and no padding**." Critical at residual $\le10^{-12}$.
- **Clebsch at $n=16$**, $\dim\mathfrak m=40$, $S=0$ exactly, criticality residual $3\times10^{-18}$, ungraded by the two-eigenvalue law; Petersen and the rest reach $\dim\mathfrak m=1100$. Native dimension, no padding.
- **A third class at $n=8$**, 228 of 300 Levenberg–Marquardt starts, critical companions carrying 12–73% of their mass on cross-block planes, classified by $W_A\circ W_B=0$ rather than by disjoint support.

And the 155 themselves are almost certainly unpadded, by an argument the record supplies: padded points carry an exact kernel and padding *creates* $E(\tfrac12)$ degeneracy, while a residual-cutoff Newton converges to nondegenerate zeros, "every graded point at $n=6$ is a degenerate zero of the criticality equation, and every ungraded one found is nondegenerate". The padded locus is a proper subvariety; random-start Newton does not land on it.

**So the restriction has real support and the evidence base survives it.** That is the one piece of good news this cycle, and the plan does not have it.

### Why the repair is nonetheless defensive

**(i) The stated rationale is half inert.** "$\{S=0\}$ is closed under padding while gradedness is not" is offered as the principle. But the statement being repaired is *$W$ ungraded and critical $\Rightarrow\lambda_{\max}(L_e|_{W^\perp})\ge c>\tfrac12$*, there is **no $S=0$ hypothesis in it**. The closure of $\{S=0\}$ under padding bears on item 2's target, not on this one. Only the second half ("gradedness is not closed under padding") does any work, and it is a statement about one construction, not a principle.

**(ii) The premise that carries the asymmetry is contradicted by the record.** `5d992c5` justifies the choice with *"padding destroys gradedness while leaving the second-order spectrum intact"*. [nondegeneracy.md](../findings/nondegeneracy.md) says the opposite in a headline: **"Padding does not preserve nondegeneracy"**, the $S^2\times S^k$ family is nondegenerate natively and degenerate at every larger $n$ with excess growing linearly, $4(n-4)$ for $S^2\times S^2$; $S^3\times S^3$ keeps excess $9$ from $n=6$ to $14$. Nondegeneracy here *is* a statement about $\mathop{\mathrm{spec}}(L_e)$ ($\dim E(\tfrac12)$ against the orbit) so padding moves the second-order spectrum, by an amount growing with the padding dimension. The repair needs padding to be the cause of the ungradedness *and not* of the $\lambda_{\max}=\tfrac12$; the record supports it changing both.

**(iii) The paragraph undercuts itself in two lines.** "The evidence behind the target was $\lambda_{\max}\in[1.17,96.3]$ … a Gate 2 objection had already flagged that a constant uniform in $n$ contradicts the fence … **The witness supplies what that objection lacked.**" The witness is padded. Under the restriction adopted one paragraph earlier it is out of scope, so it supplies nothing about the restricted statement. You cannot both exclude a point from a target's scope and cite it as evidence about that target.

**(iv) The principled repair was available and was not considered.** The gap theorem's only use is *maximiser $\Rightarrow$ graded*, and every global maximiser satisfies $\theta\ge\theta_0(n)$, because $S^{n/2}\times S^{n/2}$ is an admissible competitor. Adding $\theta\ge\theta_0(n)$ to the hypotheses is therefore non-circular, sufficient for (G), and excludes the witness at **every $n\ge12$**, $\sqrt{3/2}=1.2247449$ against $\theta_0(12)=1.2360331$, with no support hypothesis at all. It is a restriction anyone would have written before seeing the falsifier, which is the definition of principled.

[plan.md](../plan.md) rejects only the *dimension* restriction, and is right to: padded $W_{\mathbb{CP}^2}$ exists at $n=12$, so restricting to $n\ge12$ leaves the witness alive. But the option set it then considers is $\{$dimension, support$\}$, the **value** restriction never appears. Its cost is visible and explains the omission: under $\theta\ge\theta_0(n)$ the $[1.17,96.3]$ base at $n=6$ (mostly low-$\theta$ points, the 24 clean ones at $\theta=0.104886$) goes out of scope and the target loses its evidence. Choosing the restriction that preserves the evidence over the one that follows from the object of study is example-driven reasoning, the failure mode this same file names as the programme's recurring cause of retractions.

### "A leak that grows with $n$", which reading, and does it matter

**Both readings are true at once and they are not alternatives.** Gradedness is a property of the pair $(W,\mathbb R^n)$, not of an abstract tensor, so padded $W_{\mathbb{CP}^2}$ in $\mathbb R^n$ *is* genuinely ungraded for $n\ge5$; $S_{\mathfrak{hhm}}=4(n-4)$ is an honest measurement of a real defect. "Manufactured by padding" names the *mechanism* and cannot mean "spurious", there is no third state in which the point is not really ungraded.

**The distinction therefore does not matter for (G), and something else does.** What decides whether the point belongs in the hypothesis class is not the cause of its ungradedness but whether the class should contain it. For (G) it should not, and the reason is the value crossover, not the leak formula.

### "The witness stands at $n=5$ alone" is false, and it is on the record twice

[plan.md](../plan.md) and [second-order.md](../findings/second-order.md) both carry it, sourced to a construction at $n=6,7$ that came out non-critical (residuals $2\times10^{-1}$, $8\times10^{-2}$). That construction is described as *zero-padded-then-projected*, and the projection is the bug. [nondegeneracy.md](../findings/nondegeneracy.md) proves the opposite in one line:

> **Padding is a critical-point-preserving operation, exactly.** … $Q$ commutes with padding bit for bit, $\max|Q_n(\mathrm{pad}\,W)-\mathrm{pad}\,Q_{n_0}(W)|=0.0$ at $n=8,10,12,14$, because $[\Lambda^2\mathbb R^{n_0},\Lambda^2\mathbb R^{n_0}]\subseteq\Lambda^2\mathbb R^{n_0}$ forces $W^{\#}$ back into the block. **So every critical point pads to a critical point with the same $\theta$ and the same $S$.**

[problem.md](../findings/problem.md) confirms it for this point specifically: padded $W_{\mathbb{CP}^2}$ verified to twelve digits at $n=10,12,14$ with criticality residual $4\times10^{-16}$. [target.md](../findings/target.md) says it a third time. A padded tensor is *already* in $\mathrm{Weyl}_n$ and needs no projection; projecting it is what produced the $n=6,7$ residuals.

**Consequence:** the witness is an exact ungraded critical point at every $n\ge5$, including $n\ge12$. The sentence in [second-order.md](../findings/second-order.md) that "the target it defined survives only if restricted to $n\ge12$" is wrong, that version is refuted by the same witness padded to $n=12$.

## The finding that reframes item 1, (G) itself fails below the crossover

Three things already on the record combine:

1. $\lambda_{\max}(L_e|_{W^\perp})\ge\tfrac12$ at **every** critical point, orbit directions being exact $\tfrac12$-eigenvectors ([reviews/INDEX.md](INDEX.md), Reviewer 27).
2. Unconstrained ascent from 60 starts at each of $n=6,8,10,12$ **reaches $\sqrt{3/2}$ below $n=12$** and $\theta_0(12)$ at $n=12$ ([second-order.md](../findings/second-order.md)).
3. Padded $W_{\mathbb{CP}^2}$ sits at $\sqrt{3/2}$ and is ungraded from $n=5$, with $S_{\mathfrak{hhm}}=8$ at $n=6$ ([nondegeneracy.md](../findings/nondegeneracy.md)).

So at $n=6,8,10$ the best point the project can reach is an **ungraded** one, and it attains the universal second-order floor exactly, as a global maximiser must. On the record's own evidence, **the global maximiser at $n\le11$ is ungraded and (G) is false there.**

That changes what the falsification means. The witness does not refute a critical-point statement while (G) looks on from a safe distance; it refutes (G) itself everywhere (G) is false, and (G) becomes true at $n\ge12$ for exactly one reason, $\theta_0(n)$ overtakes $\sqrt{3/2}$ at $n=6+2\sqrt7$. **Any proof of (G) must consume that crossover**, since (G) has no proof valid at $n=10$. Restricting the support instead routes around the only structural fact the record holds about (G).

The arithmetic, checked by hand: $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ (from $\tfrac{n-1}n\mu\le\theta_0$ with $\mu\le\sqrt{2(n-2)/(n-1)}$), giving $1.054093$ at $n=6$ and $1.2360331$ at $n=12$; $\theta_0(n)=\sqrt{3/2}$ solves $n^2-12n+8=0$, i.e. $n=6\pm2\sqrt7$, so $11.2915$. All as recorded.

## Claim 2, the 145/146 split

**The arithmetic is right.** $\theta$ is padding-invariant (proved, not merely observed: $(\mathrm{pad}\,W)^{\#}=\mathrm{pad}(W^{\#})$, so $Q$ commutes with padding and $\theta$ is carried across unchanged). The crossover is $6+2\sqrt7$. The witness is strictly below $\theta_0(n)$ from $n=12$. All confirmed above.

**The resolution is wrong, and the split was not a disagreement.** Reviewer 145's conclusion (the witness is not a global maximiser at $n\ge12$, so (G) is not refuted there), is true, but *no falsification of a critical-point lemma could ever refute a maximiser statement*. (G) was never at risk from this witness at $n\ge12$; 145 rescued a statement that was not under attack, and the plan records the rescue as the resolution.

146's reading (the collapse leaves item 1 without an escape hatch), is about the **route**, and it is correct: the gap theorem must quantify over critical points, because restricting it to maximisers makes it circular ($\lambda_{\max}\le\tfrac12$ at a maximiser is the input; "a maximiser is graded" is the output). So the falsified statement is exactly the one (G) needs, and the maximiser/critical distinction gives it no relief whatever.

**Is the distinction an escape hatch?** Not as a statement, it is true. As a move, yes: resolving the split "in favour of 145" moved the entire load onto the padding repair without anyone noticing that it had moved. That is why claim 1 is load-bearing, and why it is under-supported.

The plan's own banner already says the honest thing, *"the ITEM is alive; every METHOD named for it is closed"*. The paragraph "**BUT IT DOES NOT REACH (G), AND ITEM 1 SURVIVES**" says more than that, and given the section above it says something false: below the crossover the witness *does* reach (G).

## Claim 3, the fence-post downgrade

**Not an over-correction. Three of the four points are sound, one is contestable, and the bookkeeping is unfinished.**

| point | assessment |
|---|---|
| the $n^4$ count measures the wrong thing | **sound.** $S_2=\kappa_n/\theta^2$ is a function of $\theta$, so it is pinned rather than free data; a fibre dimension says nothing about whether a scalar projection separates two sets. |
| slack at feasible points is not evidence | **premise contestable**, see below. The second half ($A_n\ge B_n$ with $\deg A>\deg B$ has a growing ratio for free) is correct and by itself enough. |
| the obstruction is directional, and this is fence post F6 | **sound.** $e=W/\theta$ makes $\mathop{\mathrm{spec}}(L_e)$ and $\mathop{\mathrm{spec}}(L_W)$ the same set up to scale, so [post F6](../findings/fence-posts.md) ("spectral moments of $L_W$ are the wrong invariants") and this post are one statement. |
| "holds at every localizing order" is false | **sound and decisive.** PSD is every principal minor, and the minor omitting index $0$ carries no $m_0\sim n^4$ entry. Orders $k\ge2$ need $m_4,\dots,m_{2k+1}$ against three moments on record. |

**The contestable premise.** The sentence being refuted says the localizing matrix "excludes no $\theta>\theta_0(n)$ at any $n$, with slack $1.93,\dots,7.12$". Its plain reading is that the slack was evaluated *at* $\theta>\theta_0(n)$, i.e. at would-be counterexamples; the downgrade asserts it was evaluated at sphere products. One of the two is wrong and `dc57609` settles it by assertion. Either horn costs something: if the slack was measured at $\theta>\theta_0$, the bullet is wrong; if at sphere products, then the **closure** of the full moment problem one paragraph above rests on the same non-evidence and should have been downgraded with it. I cannot settle which without running the localizing computation, and running it is out of scope for this review.

**The surviving scale statement is sound but is not new.** $\mathop{\mathrm{tr}}L_e^2=\kappa_n/\theta^2=\Theta(n^2)$ over $\Theta(n^4)$ eigenvalues gives RMS $\Theta(1/n)$ against a fence at $\tfrac12$, correct. But [second-order.md](../findings/second-order.md) already carries it far above: *"the deficit is structural, $\kappa_W/\theta_0^2\sim n^2/4$ against a forced $\sum\lambda^2\sim\mathrm{orb}/4\sim n^2/8$."* Same comparison, same exponent, same file. A sharper form is available and is what should be recorded: with $\dim E(\tfrac12)\ge\mathrm{orb}=n^2/4$ at the conjectured maximiser, the pinned part alone contributes $n^2/16$ of the $\approx n^2/4$ total, so **the second moment is saturated by the orbit directions and carries almost no information about the rest of the spectrum**, which is the directional obstruction stated quantitatively, rather than a scale heuristic.

**The unfinished bookkeeping.** `dc57609` downgraded the claim in [second-order.md](../findings/second-order.md) and left two live copies elsewhere: [plan.md](../plan.md)'s closed-methods table still reads *"the full moment problem | closed, slack grows like $n^2$, the wrong direction for $n\ge12$"*, and the prose above it still reads *"its slack grows like $n^2$"*. [plan.md](../plan.md)'s own rule is that it carries no mathematics the index already holds; here it carries mathematics the index has retracted.

## Answers

### (a) Is item 1 in better or worse shape than before this cycle?

**Worse, and the rewritten "Where to restart" section is more honest than the item-1 body it sits above.** Ledger:

- **Gained:** one method correctly closed (the every-order localizing claim, well refuted); the crossover arithmetic confirmed; a correct identification of a fourth telling of post F6.
- **Lost:** the gap theorem is falsified and stays falsified; the maximiser rescue is inert against the route; the padding rescue rests on a premise the record contradicts; and the falsification is *wider* than recorded, since padding preserves criticality exactly and the witness therefore stands at every $n\ge5$, not at $n=5$ alone.
- **Newly visible:** (G) is false below the crossover on the record's own evidence, so the destination is dimension-restricted and any proof must use $n\ge12$ essentially.
- **Unrecorded good news:** the restriction does not empty the target, the record holds unpadded ungraded critical points at $n=6$, $8$ and $16$.

### (b) Anything recorded as new that the record already holds

Four this cycle:

1. **"The falsifier's ungradedness is manufactured by padding"**, [nondegeneracy.md](../findings/nondegeneracy.md) states it verbatim ("Its ungradedness at larger $n$ is manufactured by padding"), and records the *same fragility objection as already answered* by the 24 kernel-free ungraded points at $n=6$: "The record's only prior witness … was padded $W_{\mathbb{CP}^2}$, which both Gate 2 reviewers called fragile precisely because its ungradedness is manufactured by padding. **That objection is now answered.**" `2fc13f6` reinstates the objection as a repair without engaging the witnesses that answered it.
2. **"$\theta$ is padding-invariant"** (`5d992c5`), [nondegeneracy.md](../findings/nondegeneracy.md): "Padding leaves $\theta$ unchanged", and [target.md](../findings/target.md) gives the proof.
3. **The surviving scale statement** (`dc57609`), already in the same file as "the deficit is structural, $\kappa_W/\theta_0^2\sim n^2/4$ against a forced $\sum\lambda^2\sim\mathrm{orb}/4$".
4. **The $[1.17,96.3]$ sweep** is quoted in item 1 as "the evidence behind the target" while dropping the conclusion its own author attached to it in [reviews/INDEX.md](INDEX.md): *"The criterion detects **non-maximality, not gradedness**."* Read with that caveat, the sweep says the 155 points are not maximisers at $n=6$ (which they are not, since the maximiser there is the witness) and the sole ungraded *maximiser* on record sits at exactly $\tfrac12$. The evidence base points the other way from the target it is cited for.

### (c) Principled or defensive?

**Defensive.** It is well-formed and non-vacuous, so it is not empty rhetoric, but it was adopted after the falsification, its stated principle is inert for the statement it repairs, its working premise is contradicted by the record, and a restriction that follows from the object of study ($\theta\ge\theta_0(n)$) was available and unexamined. The decisive tell is that the material to *test* the restricted statement was already on the record (24 kernel-free ungraded critical points at $n=6$, Clebsch at $n=16$) and the plan restricted instead of testing, recording as open a question the record answers.

## Disagreements with the record, stated explicitly

1. **"The witness stands at $n=5$ alone; a padded construction built here at $n=6,7$ is not critical"** ([plan.md](../plan.md), [second-order.md](../findings/second-order.md)), **false.** Padding preserves criticality exactly, proved in [nondegeneracy.md](../findings/nondegeneracy.md) and verified for this point at $n=10,12,14$ in [problem.md](../findings/problem.md). The $n=6,7$ residuals came from padding *then projecting*; a padded tensor is already in $\mathrm{Weyl}_n$.
2. **"Padding … leav[es] the second-order spectrum intact"** (`5d992c5`), **false as stated.** [nondegeneracy.md](../findings/nondegeneracy.md): "Padding does not preserve nondegeneracy", with $E(\tfrac12)$ excess growing linearly in the padding dimension.
3. **"The target … survives only if restricted to $n\ge12$"** ([second-order.md](../findings/second-order.md)), **false**, by (1): the $n\ge12$ version is refuted by the same witness padded to $n=12$.
4. **"A global maximiser of $P$ … is graded"** with no dimension restriction ([plan.md](../plan.md)), **false at $n=6,8,10$** on the record's own ascent data. (G) needs $n\ge12$ in its statement.
5. **"The witness supplies what that objection lacked"** ([plan.md](../plan.md)), inconsistent with the restriction adopted in the preceding paragraph, which puts the witness out of scope.
6. **[plan.md](../plan.md) still carries "the full moment problem (closed), slack grows like $n^2$"** in two places after `dc57609` downgraded exactly that claim.

## What to do instead

- **State (G) with $n\ge12$** and treat the crossover as part of its content. (G) is false below it; a proof that does not use $n\ge12$ cannot exist.
- **Repair the gap theorem by value, not by support:** *ungraded, critical, and $\theta\ge\theta_0(n)$ $\Rightarrow\lambda_{\max}>\tfrac12$*. Non-circular, sufficient for (G), kills the witness at every $n$ in scope, and needs no claim about padding.
- **Test rather than restrict.** Compute $\lambda_{\max}(L_e|_{W^\perp})$ at the 24 kernel-free ungraded critical points at $n=6$ and at Clebsch at $n=16$. Those are the honest falsifier hunt for the restricted target, and they are already built.
- **Fix the two false sentences** about the witness standing at $n=5$ alone before either is cited again; the falsification is wider than the record says.

*r147, Gate 2. Derivation only, no script run, no machinery rebuilt.*
