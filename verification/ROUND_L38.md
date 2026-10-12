# Round L38, two families capped, in closed form and strictly decreasing

**Id:** L38 · **Date:** 2026-09-07 · **Verifiers:** v221, v222, v223 · **Brief:** [BRIEF_L38.md](BRIEF_L38.md)

## Sources, verbatim

| passage | source |
|---|---|
| the canonical entry | [results.md](../results.md) lines 517-521 |
| the landscape statement | [results.md](../results.md) line 162 |
| the block | [findings/ungraded-slack.md](../findings/ungraded-slack.md) lines 244-269 |

## The findings from phase 0

**Six annotations stand above a block the record says has been broken since it was created.** *"The block's closing LaTeX has been broken since it was created, alongside five raw report macros"*, and it still is: the text after the annotations is in `\[…\]` and `\CP^m`, which is the report's syntax and not this record's, so the block does not render where it lives.

**One annotation says the block's pointer is false and was half-false the day it was stamped.** *A pointer wrong from birth is a different defect from one that decayed*, and the round should say which claims the block's proof actually supports.

**Another says half of it duplicates another numbered result** (*"the $\mathbb{CP}^m$ half duplicates Lemma L10), same formula, two numbers, neither…"*. **Two numbered results carrying one formula is a defect of the numbering**, and the round is asked which should hold it.

**And one annotation contradicts the lemma's own headline.** The result is titled *"two families capped"*; the annotation reads *"'CAPPED' DOES NOT MEAN 'BELOW THE TARGET' AT THE FAMILY'S OWN $n$, both families **exceed** $\theta_0$…"*. **Both go to the verifiers unlabelled.**

## What the verifiers are asked beyond the standing list

Whether $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ on $\mathbb{CP}^m$ and $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$ on the $(\mathfrak{su}(m),\mathfrak{so}(m))$ family are exact, and **on what range of $m$ each holds**; whether both are strictly decreasing, and whether the range for that is stated anywhere; whether the two families meet at $m=2$ **and nowhere else**, and whether the $m=2$ identification is right; **in what sense the families are "capped", given that they exceed $\theta_0$ at their own $n$**; and whether $p=\binom m2$ and $q=\binom{m+1}2-1$ are the right dimensions for the pair named.

**And the numbering question**: whether this result and [Lemma L10](../findings/graded-half.md) state the same thing, and if so what each adds.

## Gate 2, after the fact: this round was not a refutation

**[r730](../reviews/REVIEW_r730.md) returns `REFUTED AS A REFUTATION` on this row, and it is right.** *The parent commit already carried the strike verbatim*, the annotation reading *"'CAPPED' DOES NOT MEAN 'BELOW THE TARGET' AT THE FAMILY'S OWN $n$"* was on the record under a prior Gate 2's `CONFIRMED`. **Nothing false was on the record when this round opened.** What the round did was relabel the heading and rewrite the block, and in doing so it **dropped the monotonicity proof**, the derivative numerator $-3(3m^2-2m+1)$ of discriminant $-8$, and the second family's immediate $1+\tfrac2{X-2}$ form. *That content is restored.*

**[r729](../reviews/REVIEW_r729.md) returned `CONFIRMED` on the same row, and the two are not in conflict.** *They answered different questions*: r729 checked whether the strike's mathematics is correct, and it is; r730 checked whether anything false was being struck, and nothing was. **The round's verdict on the lemma stands and its claim to have refuted something does not.**

*The lesson is the audit's own, arriving from outside: a round that finds an annotation stating a defect should check whether the annotation is the record's correction already applied, rather than treating the prose it annotates as live.*

## Adjudication

**Verdicts: [v221](VERIFY_v221.md) and [v222](VERIFY_v222.md) `PROVEN, hypotheses corrected`, [v223](VERIFY_v223.md) `HYPOTHESIS-DEBT`. Round verdict: `PROVEN, hypotheses corrected`, repaired, impact `NARROWS`.** *All three name the same unproved clause; two judged the value claim to carry the row and one judged the debt to. The repair records both, which is what the difference was about.*

**Both closed forms are exact and each was derived three times**, the $\mathbb{CP}^m$ value from Fox's (10.4) at $r=2m$ and the Kähler value from [L39](../findings/target.md)'s symmetric-pair formula, with $p=\binom m2$, $q=\binom{m+1}2-1$ closing at $p+q=m^2-1$, the identity $X-2=(m-1)(m+2)$ exact, monotonicity from a numerator $-3(3m^2-2m+1)$ of discriminant $-8$, and $m^2-3m+2$ confirmed as the meeting polynomial.

| id | step attacked | mechanism | support | outcome |
|---|---|---|---|---|
| **C1** | both closed forms, $p$, $q$, monotonicity, the meeting point | independent re-derivation | 3/3 | `CONFIRMED` |
| **C2** | the headline word *"capped"* | read as *below the target*, false at the small members | 3/3 | **`REFUTED`**, retitled |
| **C3** | the range | $m\ge2$ used and stated for neither family | 3/3 | `CONFIRMED`, stated |
| **C4** | Weyl-ness of the Kähler family | screened at sampled $m$, argued nowhere | 3/3 | **`HYPOTHESIS-DEBT`**, filed |
| **C5** | the pointer | names a section excluding both families by name | 3/3 | `CONFIRMED`, repointed |
| **C6** | duplication with [L10](../findings/graded-half.md) | same formula, and **L10 is strictly stronger** | 3/3 | `CONFIRMED`, recorded |
| **C7** | the Fox-to-Frobenius conversion | applied silently; without it the value is $4\times$ low | 1/3 | `CONFIRMED`, stated |
| **C8** | two columns of L39's table | generic-$m$ data read at $m=3$ and $m=4$ | 2/3 | `CONFIRMED`, **L38's value untouched**, recorded for L39's row |
| **C9** | the broken LaTeX and five raw macros | never rendered since the block was created | 3/3 | `CONFIRMED`, rewritten |
| **C10** | the report's limit row | | 3/3 | **`WITHDRAWN`**, see below |

### C2, and the word was doing real damage

**Screened here, exactly.** For $\mathbb{CP}^m$ against $\theta_0(2m)^2$: $+\tfrac34$ at $m=2$, **exactly $0$ at $m=3$**, $-\tfrac{49}{144}$ at $m=4$. For the Kähler family: $+\tfrac34$, $+\tfrac4{45}$, $-\tfrac{29}{144}$ at $m=2,3,4$. **So both families exceed the target at their own $n$ at the small members, and the $\mathbb{CP}^3$ member sits on it exactly.** *And where the cap is useful (at $n\ge12$, past the crossover), it is attained at padded $W_{\mathbb{CP}^2}$.* **It fences and never separates**, which is precisely what a reader takes "capped" to deny. The title now says what the result is: two families meeting at $W_{\mathbb{CP}^2}$, where both attain $\tfrac32$.

### C4, where the three verdicts differ and the mathematics does not

**Nothing on file puts the Kähler two-eigenvalue point in $\mathcal W_{2m}$ at general $m$**, and [target.md](../findings/target.md) warns the ansatz is generically not a Weyl tensor, three of sixteen pairs passing. *One verifier supplied the mechanism*: [L4](../findings/algebra.md)'s criterion cannot fire here, since $\Lambda^2\mathbb R^m$ appears in $\Lambda^2\mathbb R^{2m}$ with multiplicity three at $\mathfrak k=\mathfrak{so}(m)$. **The value claim survives this and every consumer of the cap does not**, which is the whole of the disagreement between the two labels, and the block now carries both halves.

### C10, withdrawn, and the distinction is the finding

An annotation said the report gives the family's limit as $1$. **One verifier withdrew it against the current text; another confirmed it was true when stamped and repaired since.** *Both are right: the annotation is stale rather than wrong.* **An annotation that has outlived its defect reads exactly like one that never had one**, and this block carried six of them, which is why the round treats every annotation as a claim rather than a finding.

### What is not repaired here

**C4 is filed as [I65](../plan.md).** **C8 belongs to [L39](../findings/target.md)'s own row** and is recorded there rather than acted on: its table tabulates $h^\vee(\mathfrak{so}(m))=m-2$ with $I_\rho=2$, which fails at $m=3$ and at $m=4$ where $\mathfrak{so}(4)$ is not simple, *the product $c=m-2$ survives at both by a doubling argument, so no value moves.*

### One process finding, for the second time

**A verifier staged the whole tree and swept another's report into its commit.** *Content survived and the displaced verdict is carried by a later commit.* This is the second occurrence; [skill-proposals.md](../.claude/skill-proposals.md) entry 59 is rescored.

