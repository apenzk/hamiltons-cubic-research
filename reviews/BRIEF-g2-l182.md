# Gate 2 brief, L182, the uniform lower bound on $\lambda F$

**Cold brief. Work from what is below and nothing else.** Do not read [findings/](../findings/) for the answer.

## The standing rule you inherit

**This programme is on an ANALYSIS-ONLY footing.** Computation requires the user's approval for a specific task and you do not have it. **Permitted without asking: screening a claim you are about to record, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim.** Reserved and forbidden: searches, sweeps, optimisations, censuses, falsifier hunts. **A refutation must be exhibited in closed form or it is not a refutation.**

## Constants and givens, everything the checklist below names

- $\theta_0(n)^2=\dfrac{2(n-1)(n-2)}{n^2}$, and $\theta_0(12)=1.236033$, $\theta_0(n)\to\sqrt2=1.414214$.
- $\sqrt{3/2}=1.224745$. The conjecture's range is even $n\ge12$; the crossover the record watches is $n=6+2\sqrt7=11.2915$.
- $\lambda(n)=\dfrac{2}{\sqrt{9\big(\theta_0(n)-\sqrt{3/2}\big)}}$, and $\lambda_\infty=\dfrac{2}{\sqrt{9(\sqrt2-\sqrt{3/2})}}=1.53157$.
- **Given (quoted from a lemma you are not asked to check, and which is itself Gate 2 owed):** $F(12)=0.38673$; $F(n)>F(12)$ at every even $n\ge14$; $F(n)\to0.90304$.
- The quantity of interest is the product $\lambda(n)F(n)$, which is the constant in a radius bound of order $n^{-1}$.

## The claim

$$\lambda(n)\,F(n)\;>\;\lambda_\infty\,F(12)\;=\;0.5923041\qquad\text{at every even }n\ge12.$$

**So the constant is bounded away from zero uniformly in $n$, and the $\Omega(n^{-1})$ radius holds at every even $n\ge12$ with no dimension left over.**

**Proof as written.**

*$\lambda$ decreases and exceeds its limit.* $\theta_0(n)^2=2\big(1-3n^{-1}+2n^{-2}\big)$; as a function of $u=n^{-1}$ its derivative is $2(-3+4u)$, negative for $u<\tfrac34$, so $\theta_0^2$ increases in $n$ for $n>\tfrac43$. Hence $\theta_0-\sqrt{3/2}$ increases, $\lambda$ decreases, and being decreasing towards $\lambda_\infty$ it satisfies $\lambda(n)>\lambda_\infty$ at every finite $n$.

*$F$ is bounded below by its value at the smallest dimension.* The given records $F(12)=0.38673$ with $F(n)>F(12)$ at every even $n\ge14$, so $F(n)\ge F(12)$ throughout.

*Multiply.* $\lambda F>\lambda_\infty F(12)$. **No monotonicity of the product $\lambda F$ is used or claimed**, a decreasing function times an increasing one need not be monotone, which is exactly why the crude product of the two separate bounds is taken.

**The block also asserts** that $n=12$ is the chain's best case at $\lambda F=2.4267$ and the limit its worst at $1.3831$.

## What to attack, and answer every item in writing

**Silence is not a verdict.** Answer each explicitly, including where you found nothing.

1. **Every hypothesis**, of the claim and of anything imported. Used, stated-and-unused, used-and-unstated.
2. **The algebra $\dfrac{2(n-1)(n-2)}{n^2}=2(1-3n^{-1}+2n^{-2})$.** Verify it.
3. **The monotonicity.** Is the derivative-in-$u$ argument valid, and does "increasing in $u$ on $u<\tfrac34$" translate correctly to "increasing in $n$"? *The substitution reverses direction and that is where such an argument usually breaks.* **Check the sign twice.**
4. **"Decreasing towards $\lambda_\infty$, hence above it".** Is that inference valid, or does it need the limit to be approached from above as a separate fact? **A decreasing sequence need not stay above its limit if it is not the infimum, is it?**
5. **The arithmetic of the constant.** $\lambda_\infty=1.53157$ and $F(12)=0.38673$: is the product really $0.5923041$, and is the strict inequality in the right direction? *An earlier draft of this block wrote $0.59233$, which the product does not exceed.*
6. **$\lambda$'s definition at the range's edge.** $\lambda$ requires $\theta_0(n)>\sqrt{3/2}$, which fails below the crossover $6+2\sqrt7=11.2915$. **Is the claim well posed at $n=12$, and what happens at $n=10$?** Odd $n$ too.
7. **The two endpoint values.** $\lambda(12)F(12)=2.4267$ and $\lambda_\infty F(\infty)=1.3831$, check both, and check whether "best case" and "worst case" are entailed by anything proved, or are assertions.
8. **Is the bound vacuous or trivially weak?** $0.5923041$ against a true infimum that may be $1.3831$. Does the crude bound suffice for the stated conclusion, and does the conclusion need more?
9. **The inherited debt.** $F$'s value, its monotonicity and its limit are quoted, not derived. **State precisely what fails if any of the three is wrong.**
10. **Overreach.** Does "no dimension left over" follow, given the claim is about even $n\ge12$ only?

**Name what would break it.** End by naming the object or value that, if it existed, would falsify the claim, and say what you did to look for it.

**Do not supply a missing argument.** Where a claim has no proof on file the finding is *"this claim has no argument on file"*, verdict `HYPOTHESIS-DEBT`.

## Output

`reviews/REVIEW_r<N>.md`: title; standfirst saying the brief was cold and **no numerical work was done, every value exact**, with your log path; **the claim table before any prose**, verdicts in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections with derivations in full; the overall verdict. **Use your own verdict vocabulary, the fold records your word, not a kinder one.**

Log to `agent_logs/g2-l182-r<N>.log` with PID, a line per phase, live state at every tool round, and a closing `DONE <verdict>`.

**Commit your report alone. Do NOT edit [reviews/INDEX.md](INDEX.md), the fold writes every row after both reports land, so that neither of you reads the other's verdict.** If the commit gate refuses an unindexed report, say so and leave the report uncommitted rather than indexing it.
