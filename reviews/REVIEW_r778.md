# Gate 2 review r778, L182, the uniform lower bound on $\lambda F$

**Cold brief.** I worked from [BRIEF-g2-l182.md](BRIEF-g2-l182.md) and nothing else; [findings/](../findings/) was not opened. **No search, sweep, census, optimisation or falsifier hunt was run.** Every load-bearing fact below is exact or exhibited in closed form; the decimal evaluations were done by hand and then confirmed by a seconds-long arithmetic screen of the constants the brief states, run on objects I constructed for that purpose, reported as a screen, never as evidence for a positive claim. Log: [agent_logs/g2-l182-r778.log](../agent_logs/g2-l182-r778.log).

**One correction reached me mid-review** and is answered where it lands: the lemma supplying $F$ has passed Gate 2 with four reviewers, so both inputs the claim uses are audited and only the unused $F(\infty)=0.90304$ is not (§9); and a uniform radius constant was already on the record, so the question is whether this lemma supplies strength or argument (§8b). Everything else in the brief I took as it stood.

## Claim table

| # | What was checked | Verdict |
|---|---|---|
| 1 | Hypothesis inventory (used, stated-and-unused, used-and-unstated) | **FIVE UNSTATED PREMISES** |
| 2 | $2(n-1)(n-2)/n^2=2(1-3u+2u^2)$ | **EXACT** |
| 3 | Monotonicity of $\theta_0^2$ via $u=n^{-1}$; the sign under the substitution | **SOUND, SIGN CORRECT, REVERSAL UNNAMED** |
| 4 | "Decreasing towards $\lambda_\infty$, hence above it" | **SOUND, THE BRIEF'S OBJECTION IS ITSELF FALSE** |
| 5 | $\lambda_\infty F(12)=0.5923041$; direction of the strict inequality | **ARITHMETIC DEFECT, EQUALITY FALSE, DIRECTION RIGHT** |
| 6 | Well-posedness at $n=12$; $n=10$; odd $n$ | **WELL POSED AT 12; ILL POSED, NOT FALSE, AT 10** |
| 7a | $\lambda(12)F(12)=2.4267$ | **OFF BY ONE IN THE LAST PLACE (2.4266)** |
| 7b | $\lambda_\infty F(\infty)=1.3831$ | **CORRECT AS A VALUE** |
| 7c | "$n=12$ best case, the limit worst case" | **REFUTED AS AN ENTAILMENT** |
| 8 | Vacuity / weakness of $0.5923041$ | **SUFFICIENT FOR THE CONCLUSION DRAWN, WEAK BY A FACTOR $2.3$** |
| 8b | Redundancy, given the record already holds a uniform constant | **NOT REDUNDANT, SUPPLIES THE MECHANISM, NOT NEW STRENGTH** |
| 9 | The inherited $F$ debt | **THE LOAD-BEARING INPUT IS AUDITED; THE UNAUDITED ONE IS THE UNUSED ONE** |
| 10 | "No dimension left over" | **TRUE ONLY WITH THE RANGE ATTACHED** |

**Overall: SOUND-CORE, DEFECTIVE-AS-WRITTEN.**

**Actionable in one line:** keep the deduction and record it as the argument for a fact already held rather than as new strength; delete the two endpoint "best/worst case" assertions, one of which is refuted by an $F$ consistent with every given and rests on the only unaudited input; and replace the seven-decimal numeral $0.5923041$ (not an equality, and not safe as a bound once $F(12)$ is read as a five-decimal value), with $\lambda(n)F(n)>0.59230$.

## 0. Conventions, fixed once

- $u=n^{-1}$, $u\in(0,\tfrac1{12}]$ over the claim's range. $g(u):=2(1-3u+2u^2)$, so $\theta_0(n)^2=g(1/n)$, and $\theta_0(n):=+\sqrt{g(1/n)}$ whenever $g\ge0$.
- $c:=\sqrt{3/2}$, $\Lambda(t):=2/\sqrt{9(t-c)}$ for $t>c$, so $\lambda(n)=\Lambda(\theta_0(n))$ and $\lambda_\infty=\Lambda(\sqrt2)$.
- "Decreasing" means strictly decreasing; I flag where strictness is needed.
- Decimals: an unadorned decimal is a screen value, correct in every digit shown. Exact quantities are written as surds or fractions.
- Screen values recorded here, all confirmed to forty digits: $c=1.224744871$, $\sqrt2=1.414213562$, $\theta_0(12)=1.236033081$, $\lambda_\infty=1.531581154$, $\lambda(12)=6.274746787$, $\lambda(14)=3.468871447$, $6+2\sqrt7=11.291502622$.

## Hypothesis inventory

**Stated and used.** The formula $\theta_0(n)^2=2(n-1)(n-2)/n^2$; the definition of $\lambda$; $\theta_0(n)\to\sqrt2$ (used to name $\lambda_\infty$ as the limit); $F(12)=0.38673$; $F(n)>F(12)$ at every even $n\ge14$; the range even $n\ge12$.

**Stated and unused.** $F(n)\to0.90304$ plays no part in the main inequality, it enters only the endpoint assertion $1.3831$, which §7 shows is not entailed. $\theta_0(12)=1.236033$ likewise enters only the endpoint value $2.4267$. So one third of the quoted $F$ given, and one of the two quoted $\theta_0$ values, are inert with respect to the claim.

**Used and unstated, five.**

1. **Positivity for the product step.** Multiplying $\lambda(n)>\lambda_\infty$ by $F(n)\ge F(12)$ requires $\lambda_\infty>0$ and $F(12)>0$. Both hold, and both are silent in the text. They are not decorative: at $n=12$ the second factor is an *equality*, and the whole strictness of the conclusion there rests on $F(12)>0$. Had $F(12)=0$ the display would read $0>0$.
2. **The domain restriction on $\lambda$.** The step "$\theta_0-c$ increases, hence $\lambda$ decreases" is valid only where $\theta_0>c$, i.e. $n>6+2\sqrt7$. The text derives the monotonicity of $\theta_0^2$ "for $n>\tfrac43$" and then chains straight into $\lambda$, over an interval on which $\lambda$ does not exist. The conclusion is unharmed on the claim's range; the written chain carries an unnamed restriction.
3. **$\theta_0^2\ge0$**, needed for $t\mapsto\sqrt t$ to be applied and to be monotone. True for $n\ge2$; at $n=\tfrac43$, the very endpoint the text names, $\theta_0^2=-\tfrac14$.
4. **The monotone-limit fact** (§4): that the limit of a decreasing sequence is its infimum. Used, correct, unnamed.
5. **Continuity of $\Lambda$ at $\sqrt2$**, so that $\theta_0(n)\to\sqrt2$ gives $\lambda(n)\to\Lambda(\sqrt2)=\lambda_\infty$. Immediate since $\sqrt2>c$, but it is the step that makes $\lambda_\infty$ *the limit of $\lambda$* rather than a separately defined number.

## 1. Hypotheses

Covered in the inventory above. The one I would call a genuine defect of statement rather than of style is item 2: the sentence as written asserts a monotonicity of $\lambda$ on $(\tfrac43,\infty)$, where $\lambda$ is real only on $(6+2\sqrt7,\infty)$.

## 2. The algebra, EXACT

$$\frac{2(n-1)(n-2)}{n^2}=\frac{2(n^2-3n+2)}{n^2}=2\left(1-\frac3n+\frac2{n^2}\right)=2(1-3u+2u^2).$$

Identity, valid for every $n\ne0$. Nothing to attack.

## 3. The monotonicity, SOUND, and the brief's paraphrase of it is not what the block says

$g'(u)=2(-3+4u)$, which is exactly what the block writes. $g'(u)<0$ for $u<\tfrac34$: so $g$ is **decreasing in $u$** on $(0,\tfrac34)$.

**The sign, checked twice.** First: $u=1/n$ is a decreasing function of $n$ on $n>0$; $g$ is decreasing in $u$; decreasing-after-decreasing is increasing, so $\theta_0^2$ increases in $n$. Second, independently and without the substitution: $\frac{d}{dn}\left[2-6n^{-1}+4n^{-2}\right]=6n^{-2}-8n^{-3}=\dfrac{2(3n-4)}{n^3}$, positive for $n>\tfrac43$. The two routes agree, and the threshold agrees: $u<\tfrac34\iff n>\tfrac43$ for $n>0$. Both are strict on the whole of $(\tfrac43,\infty)$, so the increase is strict there, and $12,14,16,\dots$ all lie inside.

**On the brief's framing.** Item 3 asks whether "increasing in $u$ on $u<\tfrac34$" translates to "increasing in $n$", it would not; it would give *decreasing* in $n$. But the block does not claim $g$ increases in $u$; it claims $g'<0$ there, which is decrease in $u$. The block has the sign right. What it does not do is *name* the reversal, it writes "negative for $u<\tfrac34$, so $\theta_0^2$ increases in $n$", with the composition step compressed into "so". That is a presentational gap in the exact place a reader would want the step spelled out, and I would have it spelled out, but it is not an error.

$\theta_0$ then increases because $\sqrt{\cdot}$ is increasing on $[0,\infty)$ and $\theta_0^2\ge0$ for $n\ge2$; $\theta_0-c$ increases; $9(\theta_0-c)$ increases and is positive for $n>6+2\sqrt7$; $\sqrt{\;}$ of it increases; and $2/(\cdot)$ decreases. So $\lambda$ strictly decreases on $n>6+2\sqrt7$, subject to the unstated domain restriction of inventory item 2.

## 4. "Decreasing towards $\lambda_\infty$, hence above it", VALID, and it needs no extra fact

The inference is sound as it stands. **For a decreasing sequence the limit is necessarily the infimum**, that is the monotone convergence theorem, not an extra hypothesis: if $a_n$ decreases and $a_n\to L$, then for any $m$ and any $n>m$ we have $a_m>a_n$, and letting $n\to\infty$ gives $a_m\ge L$; strictness follows from $a_m>a_{m+1}\ge L$. So $\lambda(n)>\lambda_\infty$ at every finite $n$ in the range, strictly.

**The brief's objection is itself false.** "A decreasing sequence need not stay above its limit if it is not the infimum" describes an impossible object: a decreasing convergent sequence whose limit is not its infimum does not exist. I looked for one and can state in closed form why none exists, the two-line argument just given. The block's inference is one of the few places in this proof where nothing is owed.

Two conditions the inference *does* need, and has: the decrease must hold at **every** $n$ in the range, not eventually (it does, from $n>6+2\sqrt7$ onward), and $\lambda_\infty$ must be the limit of the same sequence rather than an independently defined constant (inventory item 5).

## 5. The constant, ARITHMETIC DEFECT; the direction is right

**Direction, first.** $\lambda(n)>\lambda_\infty>0$ and $F(n)\ge F(12)>0$ give $\lambda(n)F(n)>\lambda_\infty F(12)$, strictly, at every even $n\ge12$ including $n=12$ where the second factor is an equality. The inequality points the right way and the strictness is real.

**The numeral is not.** Exactly:

| quantity | as written | as it is |
|---|---|---|
| $\lambda_\infty$ | $1.53157$ | $1.531581154$, rounds to $1.53158$ |
| $\lambda_\infty\cdot0.38673$ | $0.5923041$ | $0.5923083795$ |
| $1.53157\cdot0.38673$ |, | $0.5923040661$ |

So the displayed "$\lambda_\infty F(12)=0.5923041$" is **false as an equality**: $0.5923041$ is the product of the *understated* $\lambda_\infty$ with $F(12)$, not the product of $\lambda_\infty$ with $F(12)$. The block has propagated a truncation of its own constant into an assertion of equality four decimals past where that constant is right.

**Whether it is at least safe as a bound depends on how $F(12)=0.38673$ is read.**

- Read as exact, the numeral understates the true right-hand side by $4.3\times10^{-6}$, so $\lambda F>0.5923041$ follows a fortiori. Safe.
- Read as a five-decimal rounding (which is what a value quoted to five decimals is, unless its audit certified a sixth) then $F(12)\in[0.386725,0.386735]$ and $\lambda_\infty F(12)\in[0.5923007,0.5923160]$. **That interval straddles $0.5923041.** The stated bound is then not entailed: for $F(12)$ at the low end, the argument delivers only $\lambda F>0.5923007$, and $0.5923041$ exceeds it.

The honest form supported by the givens is $\lambda_\infty F(12)>0.59230$, hence $\lambda(n)F(n)>0.59230$ at every even $n\ge12$. Seven decimals here are spurious precision from five-decimal inputs, and the direction of the spuriousness is unlucky.

**On the earlier draft.** $0.59233>0.5923084$, so the brief is right that the product does not exceed the old numeral; that draft's inequality was false. The present numeral fixes the sign of the error under the exact reading and leaves it undetermined under the rounded reading, an improvement, not a repair.

## 6. Well-posedness at the edge, WELL POSED AT 12; at $n=10$ the claim has no subject

$\lambda(n)$ is real iff $\theta_0(n)^2>3/2$, i.e. $\dfrac{2(n^2-3n+2)}{n^2}>\dfrac32\iff n^2-12n+8>0\iff n>6+2\sqrt7$ (taking the root above $6$; the other, $6-2\sqrt7=0.7085$, is below the physical range). $6+2\sqrt7=11.291502622$, confirming the crossover the record watches.

**At $n=12$: well posed, with room, and exactly so.** $\theta_0(12)^2=\dfrac{2\cdot11\cdot10}{144}=\dfrac{55}{36}$ and $\dfrac{55}{36}-\dfrac32=\dfrac1{36}>0$, a clean exact certificate that needs no decimals. Hence $\theta_0(12)-c=\dfrac{1/36}{\theta_0(12)+c}=0.011288$, and $\lambda(12)=6.274747$ is finite. The margin is thin in absolute terms but it is a positive rational and cannot be argued away.

**At $n=10$: ill posed, not false.** $\theta_0(10)^2=\dfrac{2\cdot9\cdot8}{100}=1.44<\dfrac32$, so $\theta_0(10)-c=1.2-1.224745<0$ and $\lambda(10)=2/\sqrt{\text{negative}}$ does not exist in $\mathbb R$. The correct statement is that the claim has **no subject** at $n=10$, not that it fails there, a distinction the block should make explicitly, because "at every even $n\ge12$" reads as a choice of convenience when it is in fact forced by the existence of $\lambda$.

**Odd $n$.** $n=11$ gives $\theta_0^2=180/121=1.487603<3/2$: undefined. $n=13$ gives $264/169=1.562130>3/2$: defined, and so is every odd $n\ge13$. So $12$ is the least integer of either parity at which $\lambda$ exists, and the even-$n\ge12$ range is exactly the even part of $\lambda$'s domain. Nothing in the $\lambda$ half of the argument uses parity; the restriction to even $n$ is inherited wholly from the $F$ given, which is quoted only at even $n$. Worth saying in the block, since a reader may take the parity for a property of $\lambda$.

## 7. The two endpoint values, and the "best/worst case" gloss

**$\lambda(12)F(12)$, off by one in the last place.** $\lambda(12)=6.274746787$, so $\lambda(12)F(12)=2.4266328$, which rounds to $\mathbf{2.4266}$, not the stated $2.4267$. The gap, $7\times10^{-5}$, is of the same order as the sensitivity to $F(12)$'s own rounding ($\pm3.1\times10^{-5}$), so $2.4267$ is reachable only at the top of that band while the central value is $2.4266$. Minor, and consequential only for anyone who quotes the digit.

**$\lambda_\infty F(\infty)$, correct.** $1.531581154\times0.90304=1.3830790$, which rounds to $1.3831$. This one is right.

**"Best case" and "worst case", REFUTED AS ENTAILMENTS.** Neither is proved, and the block cannot prove them, because it explicitly and correctly disclaims any monotonicity of the product. Worse than unproved, the second is *refuted* by an object consistent with every given the brief supplies. The givens constrain $F$ only by: $F(12)=0.38673$; $F(n)>F(12)$ for even $n\ge14$; $F(n)\to0.90304$. **No monotonicity of $F$ is given.** So take

$$F(14)=0.3868,$$

which satisfies $F(14)>F(12)$ and constrains nothing else. Then, with $\theta_0(14)^2=\dfrac{2\cdot13\cdot12}{196}=\dfrac{312}{196}$ and $\lambda(14)=3.468871$,

$$\lambda(14)F(14)=3.468871\times0.3868=1.34176\;<\;1.3831.$$

An admissible $F$ therefore puts an interior value of $\lambda F$ **below** the asserted worst case. (The same computation with the crudest admissible value, $F(14)\downarrow F(12)$, gives $1.3415$.) So "the limit is the chain's worst case at $1.3831$" is not a consequence of anything on file; it is an assertion about the true $F$, imported without notice. By the same token "$n=12$ is the best case" has no argument on file, verdict **HYPOTHESIS-DEBT** for that half, and **REFUTED-AS-ENTAILMENT** for the worst-case half.

This does not touch the main claim: $1.3415>0.5923$ with room to spare.

## 8. Vacuity and strength, sufficient, and weak

**Not vacuous.** $0.5923041$ is positive, finite, independent of $n$, and the inequality is strict; the conclusion "bounded away from zero uniformly in $n$" needs exactly a positive uniform constant, and gets one. For the $\Omega(n^{-1})$ radius as stated, the crude product suffices and the conclusion needs nothing more.

**Weak by a factor of $2.34$** against the value the block believes is the infimum ($1.3831$). The looseness is structural and the block is honest about its source: the two factors are bounded at opposite ends of the range ($\lambda$ at $n=\infty$, $F$ at $n=12$) and no $n$ realises both. Any sharpening would have to say something about the product, which is precisely what is disclaimed. So the weakness is the price of not owing a monotonicity proof, and it is the right price to pay for the conclusion drawn.

### 8b. Is the lemma redundant, given that the record already holds $0.1223/n$ uniformly with $K\ge0.13537$?

**No, but its contribution is not the one the block's headline suggests.** If a uniform constant for the radius is already on the record, then the *fact* asserted here (that the constant does not degenerate with $n$), was already held, and this lemma adds no numerical strength; I cannot compare $0.5923041$ against $0.1223$ or $0.13537$ from a cold brief, since the brief gives me no normalisation linking $\lambda F$ to the radius constant, and I decline to guess one. What the lemma supplies is the **argument**, and three parts of it are genuine and are not carried by the bare fact.

1. **It names which monotonicity does the work, and shows that monotonicity is unconditional.** The $\lambda$ half, $\theta_0^2$ increasing in $n$ by an algebraic identity, hence $\lambda$ decreasing, hence $\lambda>\lambda_\infty$ by monotone convergence, imports nothing at all. No lemma, no audited constant, no numerics. A fact recorded as a number does not tell you that half of it is unassailable.
2. **It localises every possible failure.** Because the $\lambda$ half is unconditional, every falsifier of the bound is a counterexample to the single inequality $F(n)>F(12)$ and to nothing else (see the falsifier section). That is a maintenance statement of real value: if $F$'s lemma is ever revised, this is the one clause to recheck, and the $\theta_0$/$\lambda$ machinery need not be reopened.
3. **It shows the crude product is forced rather than lazy.** No monotonicity of $\lambda F$ is available, and §7 shows the givens actively *permit* an interior value below the limiting value $1.3831$. So a reader who tried to sharpen the bound by assuming the product decreases would be assuming something the record does not support, and the block's explicit refusal to claim product monotonicity is, on this evidence, correct rather than merely cautious.

**What follows for how the lemma should be stated.** It should be presented as the argument for a fact already held, not as new strength, and its numeral should not be allowed to read as the record's best constant: it is weaker by a factor $2.3$ than the value the block itself believes, and §5 shows its last three digits are unsupported. Stated that way the lemma is a real contribution. Stated as a fresh bound it would be redundant and would also understate the record.

**The caveat:** the bound is fit only for existence-of-a-constant purposes. Any downstream use that needs a numerically honest constant (a comparison against a competing bound, a threshold dimension, a claim of near-optimality), cannot take $0.5923041$, both because it is a factor $2.3$ off and because §5 shows its last three digits are not supported.

## 9. The inherited debt, what fails if each of the three is wrong

The three quoted facts are not equally load-bearing.

| given | if it is wrong |
|---|---|
| $F(12)=0.38673$ | **Numeral only.** The structural claim $\lambda F>\lambda_\infty F(12)$ is a statement about $F(12)$ whatever its value; only the displayed constant moves. The single thing that must survive is $F(12)>0$, without it the product step loses its strictness at $n=12$ and, if $F(12)\le0$, the "bounded away from zero" conclusion is destroyed outright. |
| $F(n)>F(12)$ for even $n\ge14$ | **Total collapse.** This is the only lower bound on $F$ away from $n=12$. Without it there is no control of $F$ at large $n$ whatever, the second factor is unbounded below, and the uniform positivity has to be re-proved from scratch by some other route. Nothing else in the block substitutes for it. |
| $F(n)\to0.90304$ | **Nothing in the claim.** Unused in the main inequality (inventory, stated-and-unused). Only the endpoint assertion $1.3831$ moves, and §7 shows that assertion is not entailed regardless. |

**Against the corrected picture, this comes out unusually well.** The cold brief described the supplying lemma as itself Gate 2 owed; I am told instead that it has passed with four reviewers, that its composition and every constant were confirmed, and that $F(n)>F(12)$ at every even $n\ge14$ is explicitly among what survived. Both of the inputs the claim actually uses are therefore audited, and **L182 is not a conditional result**, the "collapse" row above is a description of the claim's dependency structure, not of an outstanding risk.

**The one unaudited value is the one the claim does not use.** $F(\infty)=0.90304$ is quoted and inert: the bound needs only $F\ge F(12)$. Three things follow, and the third is the sharp one.

- The main inequality is untouched by the debt that remains.
- The block should say that it quotes $F(\infty)$ for orientation only, so that no reader takes the result to rest on it.
- **The unaudited value is exactly the value propping up the assertion that §7 refutes as an entailment.** The endpoint gloss "the limit is the worst case at $1.3831$" is built from $F(\infty)=0.90304$, and it is neither entailed by the givens nor supported by an audited input. That gloss is the block's weakest sentence twice over, and it is the one to strike.

One asymmetry survives the correction and is worth keeping in view: the collapse case is the *inequality*, the one of the three inputs that is not a number and so can never be checked by any arithmetic screen, only by reading its proof. That its audit was by four reviewers rather than by evaluation is therefore the right kind of assurance for it.

## 10. "No dimension left over", TRUE ONLY WITH THE RANGE ATTACHED

Within the conjecture's range (even $n\ge12$), the claim genuinely leaves no dimension out: every even $n\ge12$ is covered, uniformly, with no "for $n$ sufficiently large" and no finite exceptional set. That is a real property and the phrase earns it there.

Read without the range, the phrase overreaches in two directions. **Downward:** $n\le10$ is left over, and §6 shows the object $\lambda$ does not exist there, so no bound of this shape can ever be extended to it, a permanent limit, not a gap awaiting work. **Sideways:** odd $n\ge13$ is left over, and there $\lambda$ *does* exist; the obstruction is only that $F$ is quoted at even $n$. A reader could reasonably take "no dimension left over" for a statement about all $n\ge12$, which it is not. The fix is one clause: "no dimension left over *within the conjecture's range*".

## What would break it, and what I did to look

**The falsifier of the main claim** is a single even $n\ge12$ with $\lambda(n)F(n)\le\lambda_\infty F(12)$. The structure of the proof localises it completely: since $\lambda(n)>\lambda_\infty$ is strict and unconditional on $n>6+2\sqrt7$, it follows from an algebraic identity and the monotone convergence theorem, with no imported input, any such $n$ must have $F(n)<F(12)\cdot\lambda_\infty/\lambda(n)\le F(12)$. **Every falsifier is a counterexample to the imported $F$ inequality and to nothing else.** The claim is therefore exactly as strong as that import, and no stronger; there is no independent way for it to fail.

**A falsifier of the numeral,** distinct from the above: any true $F(12)$ in $[0.386725,\,0.5923041/\lambda_\infty)=[0.386725,\,0.3867272)$ (consistent with the quoted five decimals), makes the displayed $\lambda F>0.5923041$ unentailed while leaving the theorem $\lambda F>\lambda_\infty F(12)$ intact.

**A falsifier of the endpoint gloss,** exhibited in closed form in §7: $F(14)=0.3868$ satisfies every stated given and yields $\lambda(14)F(14)=1.34176<1.3831$.

**How I looked.** By reading the two inequalities for the weakest $F$ each admits, and by evaluating $\lambda$ in closed form at the range's edge and at the first interior point. No search, sweep, census or optimisation was run; the only compute was the arithmetic screen declared in the standfirst, which confirmed the hand values and produced no claim of its own.

## Overall verdict

**SOUND-CORE, DEFECTIVE-AS-WRITTEN.**

The deductive skeleton holds and holds cleanly: the algebra is an identity, the monotonicity has the right sign under the substitution and survives a second derivation that avoids the substitution entirely, the decreasing-towards-the-limit inference needs no supplement, the multiplication is legitimate, and the claim is well posed at $n=12$ by an exact rational margin of $1/36$.

**The correction moves the standing of the result and leaves the verdict where it was.** L182 is now unconditional rather than conditional (both audited inputs, and a $\lambda$ half that imports nothing) which is a real improvement in status. It repairs none of the three defects, because none of them ever depended on the $F$ debt: they are internal to the block's own arithmetic and its own glosses. If anything the correction sharpens one of them, since the sole unaudited value is precisely the one holding up the refuted worst-case assertion.

Against that, three defects stand in the text as written: the asserted equality $\lambda_\infty F(12)=0.5923041$ is false and, on the natural reading of $F(12)$ as a rounded value, the numeral is not even safe as a bound; the endpoint value $2.4267$ should read $2.4266$; and the "best case / worst case" gloss is unsupported, with its worst-case half refuted by an $F$ consistent with every given.

The imported $F$ inequality remains the single point at which the whole claim could fail (the $\lambda$ half cannot) but it is audited, so that is now a statement about where to look on any future revision rather than an outstanding debt.

Repair is cheap and does not touch the argument: state the bound as $\lambda(n)F(n)>0.59230$, correct $2.4266$, strike the two endpoint glosses or mark them as assertions about the true $F$, add the clause "within the conjecture's range" to the closing sentence, and name the five unstated premises, of which the domain restriction $n>6+2\sqrt7$ on the monotonicity of $\lambda$ is the one a careful reader will stop at.
