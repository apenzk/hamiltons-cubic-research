# Review r478, Lemma L18

**Verdict: REFUTED as stated.** Two of the block's own load-bearing sentences are contradicted by the record that supplies its argument: "the answer is **one** exactly-priced term" undercounts the defect entries, and "**granting that cross-term bound** … the chain gives" names one grant where the record's own honest hypothesis list has two. The mathematics underneath is real and partly proof-grade, but the statement as written is not a Lemma.

**Label it deserves:** split. The pricing half, the $\tfrac32$-Gram identity, $D(R)\succeq0$, and the $24\delta^2\lambda_{\max}$ ceiling on $J_4$, is a **Lemma**, unconditional and pointwise. The dichotomy half is an **Observation**, conditional on $J_5\ge0$ off the commuting class *and* on the E-track certificate.

*Twin brief; [REVIEW_r477.md](REVIEW_r477.md) deliberately unread.*

---

## 1. The block does not contain its proof, and the pointer chain is circular

[findings/problem.md](../findings/problem.md) lines 262–272 are headed "canonical statement and proof". They contain **four prose paragraphs and not one displayed equation**, no identity, no inequality, no derivation. Every neighbouring block in the same file ([Step 2(a)–(c)](../findings/problem.md), [Step 1](../findings/problem.md), [Step 3](../findings/problem.md)) carries real displayed mathematics; L18 alone does not.

The pointer is worse than absent, it is circular. [results.md:650](../results.md) ends the L18 entry with `**Proof:** [problem.md](findings/problem.md)`, and problem.md's block carries **no pointer onward**. A reader following the canon lands on prose and stops.

**Where the argument actually is:** [ATTEMPTS.md](../ATTEMPTS.md), section *"Lifting Jäger's §3.3 in trace form"* (line 860), Results 1–13. That section is substantial and mostly good. **Nothing in either L18 block names it.**

## 2. "L18" names two different theorems in the same file

[findings/problem.md:403](../findings/problem.md) states, in a blockquote, **"Lemma L18 (unconditional). For every $n\ge12$, no maximizer of $P$ on $\mathrm{Weyl}^1_n$ lies within angular distance $0.5748$ of $SO(n).W_{\mathbb{CP}^2}$"**, with a proof. That is not the lifting lemma. It is **[Lemma L20](../findings/route-a.md)**, per [findings/INDEX-results.md](../findings/INDEX-results.md) row 20 and [results.md](../results.md)'s own L20 entry, which restates it verbatim including the $0.5748$.

The stale label has propagated:

| location | text | should read |
| --- | --- | --- |
| [problem.md:403](../findings/problem.md) | "Lemma L18 (unconditional)" | Lemma L20 |
| [problem.md:401, :411](../findings/problem.md) | "the conditional form of Lemma L18", "combining … with Lemma L18" | Lemma L20 |
| [ATTEMPTS.md:2696](../ATTEMPTS.md) | "the single remaining gap between Lemma L18 and a complete proof" ($\alpha\le\tfrac13$) | Lemma L20, gap since closed by [L21](../findings/route-a.md) |
| [ATTEMPTS.md:3431](../ATTEMPTS.md) | "the same $\mathcal D_n$ projection [Lemma L18](../findings/problem.md)(b)" | Step 2(b) of the candidate diagonal theorem |

The last one is the sharpest: [ATTEMPTS.md:3415](../ATTEMPTS.md) already records *"there is no 'Lemma L18(b)', the formula is Step 2(b) of the candidate diagonal theorem, a different result"*, and line 3431 sixteen lines later cites `Lemma L18(b)` anyway. **A correction was written and not applied.**

## 3. "The middle chapters", the completeness claim fails, in the L15 shape

The block asserts two things about scope:

> Its **two** departures from the diagonal case are now pinned. … The answer is **one** exactly-priced term. … §§3.4 and 3.5 then lift at **no cost at all**.

**The two departures are right.** They are (i) the Bianchi correction and (ii) $X_{\mathrm{inv}}\succeq0$, which is exactly the pair [Observation L15](../findings/problem.md) was repaired to name. That attack fails.

**"One exactly-priced term" is wrong.** [ATTEMPTS.md:910](../ATTEMPTS.md), Result 10(a): *"**Lemma 3.3.1 is not defect-free**, via 3.2.2 it becomes $r^2\ge\hat\theta\,\mathrm{scal}-24\delta^2$, partially offset through 3.2.3's $\Lambda^4$ term ($-6.4\delta^2$ at $n=12$)"*. That is a **second** $24\delta^2$ entry, inside §3.3, plus a third $-6.4\delta^2$ offset, three defect entries where the block counts one. [ATTEMPTS.md:892](../ATTEMPTS.md) Result 7 does say "the single additive penalty", but Result 10(a) is later and supersedes it; L18 froze the earlier count.

**Enumerating what is lifted, against what is not:**

| Jäger item | status in the record | in L18's claim? |
| --- | --- | --- |
| §3.3 master identity (Lemma 3.3.4 skeleton) | exact identity, **verified at 12 critical points**; hand derivation asserted, never written | yes |
| §3.3 $J_4$ price, $D(R)=\tfrac32\sum\mathrm{Alt}\cdot\mathrm{Alt}\succeq0$ | **proven twice** (exact integer + Reviewer 9 symbolic) | yes |
| §3.3 $J_5\ge0$ | granted; proven only on $[H,W]=0$ | named as the grant |
| **Lemma 3.3.1** | **not defect-free**, Result 10(a) | **absent** |
| Lemma 3.3.5 lifted | discharged, Result 11 | absent (fine, it is L19's) |
| §3.4: 3.4.1, 3.4.2, 3.4.3, 3.4.6, 3.4.8, 3.4.9–11 | **proven** to lift, no defect cost | yes |
| **Lemma 3.4.7** (the assembly) | *"spot-verified numerically"*, Result 7, **unproven** | swept into "lift at no cost at all" |
| §3.5 (3.5.1–3.5.6) | a **textual audit** of the extraction, not a proof | yes |
| **§3.2** (Lemma 3.2.2, Cor. 3.2.6) | carries its own $+24\delta^2$; L15's territory | outside "middle chapters", but the chain consumes it |
| **§3.6** | consumes 3.2.2; defect re-enters; **needs evenness and $\theta_0(n)$** | outside, so the sphere-product conclusion is not L18's |

So "§§3.4 and 3.5 then lift at no cost at all" is true of the *defect* cost and false of the *proof* status: **Lemma 3.4.7's lift is a spot-check.** [results.md:224](../results.md)'s canon summary repeats it as "§§3.4–3.5 lift free".

## 4. "The defect cost quantified", the constant is right, the operative penalty is not the one stated

**The $24$ checks out.** $\mathop{\mathrm{tr}}D=6\lVert\mathrm{Alt}R\rVert^2$ from the $\tfrac32$-Gram form; $\mathrm{Alt}(W)=0$ for a Weyl operator and $\lvert W\rvert=W+2W_-$ give $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$, so $\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=4\delta^2$ and $6\cdot4=24$. Consistent with [conventions.md](../findings/conventions.md)'s $\mathrm{Alt}$ normalisation and with $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$. **Pointwise, not critical-points-only** ($D(R)\succeq0$ holds for every symmetric $R$) so the record has not confused the two here.

**But the chain's penalty carries a factor the block drops.** [ATTEMPTS.md:892](../ATTEMPTS.md) Result 7 states it as

$$\frac{J_4-J_5}{\sqrt{1-e^2}}\;\le\;\frac{24\,\delta^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))}{\sqrt{1-e^2}} .$$

The L18 block writes the numerator only, *"it costs at most $24\lVert\mathrm{Alt}(W_-)\rVert^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$"*, and never mentions $e$, never bounds it, and then draws the dichotomy, which needs the divided form. $1/\sqrt{1-e^2}\ge1$ always and is unbounded as $e\to1$. **The stated cost is the §3.3-level cost; the dichotomy runs on the §3.5-level cost.** The record's own diagnosis confirms the amplified version is what bites: at Fox *"the penalty $p=(J_4-J_5)/r^2=0.8165$ makes the lifted 3.3.6 ceiling on $\mathop{\mathrm{tr}}S^4$ vacuous"* ([ATTEMPTS.md:908](../ATTEMPTS.md)).

## 5. The threshold is stated in a symbol the record never defines

The canonical conclusion reads *"scalar curvature at least $(n+1)\tilde\theta_0(n)$"*, and the hypothesis is $\theta\ge\tilde\theta_0(n)$. **$\tilde\theta_0(n)$ is defined nowhere**, not in [conventions.md](../findings/conventions.md), not in [INDEX-values.md](../findings/INDEX-values.md), not at any of its five occurrences in [ATTEMPTS.md](../ATTEMPTS.md) (612, 631, 801, 892), and a sixth symbol $\hat\theta_0$ appears at ATTEMPTS 786 and 910. Three tildes and hats for the threshold family, one of them load-bearing in a canonical statement.

*Screen (seconds, objects I constructed; reported as a screen):* taking $\tilde\theta_0(n)=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ gives $(n+1)\tilde\theta_0(8)=10.2470$, matching Result 9's *"a required $10.25$ at $n=8$"*, and $\tilde\theta_0(13)=1.2483756$, which is **digit-for-digit the $\Theta_{13}$ of the [Conjecture L16](../findings/problem.md) audit**. So $\tilde\theta_0$ is [conventions.md](../findings/conventions.md)'s odd-$n$ $\Theta_n$ formula extended to all $n$, a second unregistered symbol for a quantity the conventions file already names. conventions.md warns about exactly this ("It has appeared under two symbols inside one file"), and its $\Theta_n$ row was itself repaired today.

Screened and clean: $\theta_0(12)-\sqrt{3/2}=0.0112882$, matching the block's window "$0.011$"; $c(12)\approx1.0\times10^{-3}$ matches Result 11's corrected $1.0008\times10^{-3}$.

## 6. What it assumes that is unproved, the hypothesis list is short by one

The block says: *"**Granting that cross-term bound** off the class where it is already proven, the chain gives …"*. One grant.

The record's own count is two:

- [ATTEMPTS.md:912](../ATTEMPTS.md), Result 11: *"the Result-10 dichotomy now rests on $J_5\ge0$ **and the E-track certificate** alone."*
- [findings/LEDGER.md:25](../findings/LEDGER.md): *"**Two grants remain in the lifted chain.** $J_5\ge0$ off the commuting class … And an independent audit of the E-track certificate."*
- [findings/LEDGER.md:39](../findings/LEDGER.md) row: **"The E-track certificate | Single-author since inception; never audited."**

And $c(n)$ is *"explicit from the E-track margins"*, so the block's headline number, "about $1.0\times10^{-3}$", is produced by the never-audited certificate. **The quantification the title advertises rests on the grant the statement omits.** [routes.md:29](../routes.md) (R17) also lists only two owed steps and likewise omits the certificate; [findings/LEDGER.md](../findings/LEDGER.md) is the only place that gets it right.

Tracing the rest of the inputs:

| input | traces to |
| --- | --- |
| $D(R)\succeq0$, constant $\tfrac32$ | **proved**, two independent proofs (Result 2) |
| $\lambda_{\max}(\mathrm{Ric})\le r\,v^{1/4}$, scal floor, $\lVert W_-\rVert^2\ge c_W$ | **proved** by Reviewer 10 |
| lifted Lemma 3.3.5 | **proved**, Result 11 (single-run agent, unreviewed) |
| $J_5\ge0$ on $[H,W]=0$; the isotropy argument | **proved**, Result 13 Theorem B′, but *"Single-run agent result, unreviewed; the review is owed and deferred"* |
| $J_5\ge0$ off the commuting class | **grant** |
| E-track certificate | **grant, never audited** |
| Lemma 3.4.7 lift | **spot-check only** |
| §3.5 lift | **textual audit** |
| master identity at every critical point | **12-point verification** + an unwritten hand derivation |

The block's "**provably** vanishes at every named critical point, an isotropy argument forces the relevant operators to commute there" **is accurate**: Result 13's Theorem B′ ($h=\mathrm{Ric}(\lvert W\rvert)$ isotropy-invariant, hence scalar on each isotypic factor, so $H=h\wedge2\,\mathrm{id}$ acts by $(c_k+c_l)\mathrm{Id}$ on each preserved sector) is a real proof. That attack fails, but the proof is unreviewed.

## 7. The record holds a fence post against what the block claims it delivers

The block closes: *"the quantitative split **Conjecture L16 needs**."* The record says otherwise, twice, in the vocabulary of the route rather than by identifier:

- [ATTEMPTS.md:908](../ATTEMPTS.md), Result 10: *"the small-scal branch closes for $\delta^2\lesssim1.2\times10^{-3}$ and is **silent at Fox-sized defect**."* [Conjecture L16](../findings/problem.md)'s content is precisely its equality at the competitor, $\delta^2=\tfrac19$, where the chain says nothing.
- [ATTEMPTS.md](../ATTEMPTS.md), Result 12(c): *"**chain-tightening is retired as a route to the core**: the lifted chain closes only $\theta\in(1.2337,\theta_0)$ at $\delta^2=0$ shrinking to nothing by $\delta^2\approx2\times10^{-3}$, **a permanent ceiling** (Jäger's $x\le2$ fails beyond), not a work item."*
- [Lemma L19](../findings/problem.md), in the same file six paragraphs down: *"the lifted chain goes vacuous once the defect exceeds roughly a thousandth, so tightening it cannot reach the core."*

**L18 claims to supply what L16 needs; L19, sitting below it in the same file, records that it cannot.** The block's own last sentence half-concedes this ("nothing lossy will finish it") without retracting the claim.

## 8. Would it be true vacuously?

Not vacuously false, but very nearly empty. At $n=12$ the hypothesis $\theta\ge\tilde\theta_0(12)=1.234130$ admits a $\theta$-band of width $0.0019$ below $\theta_0(12)=1.236033$, and the chain closes only $\theta\in[1.23368,\theta_0)$ at zero defect, collapsing by $\delta^2\approx2\times10^{-3}$. Fox, at $\theta=1.224745$, **does not satisfy the hypothesis at all**. The only catalogued point that does is the balanced sphere product, which satisfies the first branch trivially. The dichotomy is a genuine constraint on hypothetical points, but it excludes by hypothesis every known point it would need to exclude.

## 9. Citers, and whether the use is inside the hypotheses

| citer | statement | inside hypotheses? |
| --- | --- | --- |
| [results.md:224](../results.md) | *"The chain splits every critical point above the threshold into large scalar curvature or defect bounded away from zero."* | **No.** Stated flatly, no grant, no threshold named, no $c(n)$, no $e$. The canon is the worst offender. |
| [results.md:644–650](../results.md) | full block, then `**Proof:** problem.md` | **No**, the pointer is circular (§1). |
| [results.md:67](../results.md) | *"its Lemma L18 cross-term bound is unproven on the non-commuting remainder"* | **Yes**, correct and honest. |
| [routes.md:29](../routes.md) (R17) | owes $J_5\ge0$ and the global closure | **Partly**, omits the E-track certificate. |
| [plan.md:135](../plan.md) (I11) | asks what I11's identity says about $J_5$ | Yes, a question, not a use. |
| [ATTEMPTS.md:3431](../ATTEMPTS.md) | "Lemma L18(b)" | **No**, cites a result that does not exist (§2). |
| [findings/LEDGER.md:266](../findings/LEDGER.md) | L18 takes from L15 "the identity and the definition of $\delta^2$" | **Yes**, correct, the identity is confirmed and is [Lemma L131](../findings/isotropy-cap.md) polarised, so the L15 relabelling costs L18 nothing. |

## 10. Repairs

1. **Move the argument's address into the block.** One line: *"Argument: [ATTEMPTS.md](../ATTEMPTS.md), 'Lifting Jäger's §3.3 in trace form', Results 1–13."* Until then the heading "canonical statement and proof" is false, and this is the failure mode that withdrew three results today.
2. **Rename the four stale L18s to L20**, and fix [ATTEMPTS.md:3431](../ATTEMPTS.md)'s "L18(b)" to "Step 2(b)", the correction is already written at line 3415.
3. **State both grants.** "Granting $J_5\ge0$ off the commuting class **and the E-track certificate**, the chain gives …"; and mark $c(n)$ as certificate-derived.
4. **Register $\tilde\theta_0(n)$ in [conventions.md](../findings/conventions.md)**, or replace it by $\Theta_n$ throughout, they are the same formula. Fold $\hat\theta_0$ into whichever survives.
5. **Correct the count**: "one exactly-priced term" → the §3.3 workhorse's price, plus Lemma 3.3.1's own $24\delta^2$ via 3.2.2 and 3.2.3's favourable $-6.4\delta^2$.
6. **Carry the $1/\sqrt{1-e^2}$** into the stated cost, or say explicitly that the quoted $24\delta^2\lambda_{\max}$ is the §3.3-level price and the chain uses the divided form.
7. **Qualify "§§3.4 and 3.5 lift at no cost at all"**, 3.4.7's lift is a spot-check, §3.5's is a textual audit.
8. **Withdraw "the quantitative split Conjecture L16 needs"**, which [L19](../findings/problem.md) and Result 12(c) contradict; replace with what is true: the split holds on $\delta^2\lesssim2\times10^{-3}$ and is silent at the competitor's defect.
9. **Relabel**: pricing half → Lemma; dichotomy half → Observation, conditional on two grants.

## 11. The hypotheses it actually needs

> **Observation L18 (dichotomy half).** Assume (a) $J_5\ge0$ at critical points off the class $[H,W]=0$, and (b) the E-track certificate. Then for every critical point $W$ with $\lVert W\rVert=1$ and $\theta\ge\tilde\theta_0(n)=\Theta_n$, either $\mathop{\mathrm{scal}}(\lvert W\rvert)\ge(n+1)\Theta_n$ or $\delta^2\ge c(n)>0$, with $c(12)=1.0008\times10^{-3}$. The chain is silent for $\delta^2\gtrsim2\times10^{-3}$.
>
> **Lemma L18 (pricing half; unconditional, pointwise).** For every symmetric $R$ on $\Lambda^2\mathbb R^n$, $D(R)=\tfrac32\sum_{k,l,m}\mathrm{Alt}(R)_{iklm}\mathrm{Alt}(R)_{jklm}\succeq0$ and $\mathop{\mathrm{tr}}D=6\lVert\mathrm{Alt}R\rVert^2$; hence at any $W$, $J_4\le24\,\delta^2\,\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$, sharp at the $\mathbb{CP}^2$-type competitor.
