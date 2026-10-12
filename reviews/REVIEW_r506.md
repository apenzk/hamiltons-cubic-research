# REVIEW r506, Lemma L2, "exact dimension threshold"

**Target:** [findings/problem.md](../findings/problem.md), `#### Lemma L2` (line 160) to the next heading (line 167).
**Reviewer:** r506, cold brief, analysis-only footing. Every number below was derived by hand from record-quoted inputs first; one exact-rational screen was run afterwards to check the hand arithmetic, and is reported as a screen.
**Parallel reviewer:** r505, same brief. Its log and report were not read.

**VERDICT: CONFIRMED**, the threshold is exactly right and I reprove it in five lines below. **The verdict attaches to the mathematics, not to the block**, which contains no proof, has never contained one, over-claims its own independence, and misnames its competitor. Six repairs are listed at the end.

---

## 0. The block, in full

Lines 160–166 are the whole of it:

> #### Lemma L2 (exact dimension threshold), canonical statement and proof
>
> *Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*
>
> Needed to pin down where the known critical points rank. $n=6+2\sqrt7\approx11.29$ is exactly where the balanced sphere-product overtakes the $\mathbb{CP}^2$-type competitor (Fox's $\mathcal S^4(\alpha)$), derived three independent ways. Reproduces the $n\geq12$ threshold exactly, not just approximately.

That is the entire block. The heading promises a *canonical statement and proof*; the block is a statement, a provenance note, and nothing else.

---

## F1, DECISIVE. The proof does not exist, and never did. The move-note is false.

[results.md:300](../results.md#L300) states L2 and ends **"Proof: [problem.md](../findings/problem.md)"**. [problem.md:162](../findings/problem.md#L162) says the argument was moved out of results.md because that file held *"the only copy"*. **The pointer chain closes on itself**: problem.md holds the identical three sentences and no argument.

I checked whether an argument was lost in the move. It was not, there was never one to lose:

```
$ git show 56848c5e:results.md
230:##### Lemma 2: exact dimension threshold
231:
232:Needed to pin down where the known critical points rank. $n=6+2\sqrt7\approx11.29$ is exactly ...
```

The entry has carried **the same three sentences since results.md was created**, through the `refactor(results): the proofs move to findings` commit (`a9e4b8c0`) and to today. The move-note is a boilerplate line applied uniformly to every relocated block, and **for L2 it asserts something factually untrue**.

Consequence for the label: `Lemma` in [INDEX-results.md](../findings/INDEX-results.md) means *"proven, Gate 1 and Gate 2 passed"*, by that file's own legend. Row 2 reads `| **2** | Lemma | exact dimension threshold | problem.md |`, **bare, with no Gate-2 note and no owed marker**, while [Lemma L48](../findings/problem.md#L219) three blocks below says "Gate 2 passed by four reviewers" explicitly. The block carries nothing a gate could have been run against. This is the same defect the session already recorded at `904db19f` (*"L17's inequality holds, its block carried no proof"*), recurring.

**This is not a claim that the mathematics is wrong. It is right, and §1 proves it.** The defect is that the record's most-cited number has been carried on an assertion for the whole life of the file.

---

## F2, The mathematics, reproved cold. CONFIRMED exactly.

Two inputs, both quoted from the record rather than assumed.

**Input A, the sphere-product value.** [problem.md:227](../findings/problem.md#L227) quotes Nienhaus Proposition 2.25, $\theta_{k,l}=\sqrt2\sqrt{\tfrac{k-1}k\cdot\tfrac{l-1}l\cdot\tfrac{n-1}{n-2}}$ at $k+l=n$. Squaring and rearranging:

$$\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)\,pq}.$$

**This is the brief's closed form, and it agrees.** At $p=q=n/2$: $(p-1)(q-1)=\tfrac{(n-2)^2}4$ and $pq=\tfrac{n^2}4$, so

$$\theta_0(n)^2=\frac{2(n-1)}{n-2}\cdot\frac{(n-2)^2}{n^2}=\frac{2(n-1)(n-2)}{n^2},$$

which is [conventions.md](../findings/conventions.md)'s $\theta_0(n)$ verbatim. **Agrees.**

**Input B, the competitor value, derived without using the number $3/2$.** [nondegeneracy.md:363](../findings/nondegeneracy.md#L363) and [fence post F46](../findings/INDEX-traps.md) give the $n=4$ closed form $P=9(\det W^++\det W^-)$ on $\mathrm{Weyl}_4$. Maximise $9\det W^+$ over trace-free $(a,b,c)$ with $a^2+b^2+c^2=1$: the constrained maximum is $a=b=-t$, $c=2t$ with $6t^2=1$, giving $P=9\cdot2t^3=18/6^{3/2}=3/\sqrt6=\sqrt{3/2}$. Both blocks together give no more, since $s\mapsto s^3$ pushes the mass to one block. So

$$\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}\ \text{ exactly, and the spectrum realising it is }\ (0,0,0,-1,-1,2)/\sqrt6,$$

which is exactly the operator [problem.md:223](../findings/problem.md#L223) names. **The value is $n$-independent**, and the reason is structural rather than numerical: $[\mathfrak{so}(4),\mathfrak{so}(4)]\subseteq\mathfrak{so}(4)$, so for $W$ supported on $\mathfrak{so}(4)$ the sum $\sum c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}W_{\gamma\epsilon}W_{\delta\zeta}$ has every index inside $\mathfrak{so}(4)$ and $W^\#$ is supported there too. Both $\lVert W\rVert$ and $\langle W,Q(W)\rangle$ survive the padding, hence so does $\theta$, [conventions.md](../findings/conventions.md)'s "padding commutes with $Q$", re-derived rather than quoted.

**The crossing.**

$$\theta_0(n)^2\ \ge\ \tfrac32\iff 4(n-1)(n-2)\ge3n^2\iff n^2-12n+8\ge0,\qquad n=\frac{12\pm\sqrt{112}}2=6\pm2\sqrt7,$$

larger root $6+2\sqrt7=11.2915026\ldots$ **Agrees with the block, and with the brief's cross-check.**

---

## F3, Nothing rounds. Both endpoints evaluated by hand.

The excess has a clean closed form, which makes the endpoint check exact rather than numerical:

$$\theta_0(n)^2-\tfrac32=\frac{4(n-1)(n-2)-3n^2}{2n^2}=\frac{n^2-12n+8}{2n^2}.$$

| $n$ | $n^2-12n+8$ | $\theta_0(n)^2$ | vs $3/2$ | excess |
| --- | --- | --- | --- | --- |
| $11$ | $121-132+8=\mathbf{-3}$ | $180/121=1.4876033$ | **below** | $-3/242$ |
| $12$ | $144-144+8=\mathbf{+8}$ | $220/144=55/36=1.5277\overline7$ | **above** | $+1/36$ |

Both strict, both exact rationals, no rounding anywhere. $6+2\sqrt7$ is irrational, so the inequality is **strict at every integer $n$** and the crossing is never attained. **The claim survives.**

*Screen (exact rationals, `fractions.Fraction`, seconds): reproduces the table for $n=6,\dots,16$ even and $7,\dots,15$ odd, and $9\cdot2/6^{3/2}=1.224744871391589=\sqrt{3/2}$. Reported as a screen of hand arithmetic, not as evidence.*

---

## F4, The $\sqrt{3/2}$ versus $\sqrt3/2$ trap: the block is on the right side, and the check is self-certifying.

Take the deflated value $\sqrt3/2$, i.e. $\theta^2=3/4$, instead:

$$\frac{2(n-1)(n-2)}{n^2}\ \ge\ \tfrac34\iff 5n^2-24n+16\ge0,\qquad\text{roots }n=4\ \text{and}\ n=4/5.$$

**A threshold of $n\ge4$, nothing like $12$.** So the polynomial $n^2-12n+8$ *certifies its own normalisation*: only $\theta^2=3/2$ produces it. The block is on the right side of the trap, and cannot be on the wrong one while stating that polynomial.

**A note the record should carry.** The string $\sqrt3/2=0.8660$ has **two legitimate referents** in this record and neither is a deflated $\sqrt{3/2}$: it is $\theta_0(4)$, [problem.md:376](../findings/problem.md#L376), "$\theta=18abc$ has its maximum $\sqrt3/2$ at $S^2\times S^2$ alone", and indeed $\theta_0(4)^2=2\cdot3\cdot2/16=3/4$, and it is the **Fox plateau** $0.866025$ of [nondegeneracy.md:421](../findings/nondegeneracy.md#L421), the two-block sum $W_{\mathbb{CP}^2}\oplus W_{\mathbb{CP}^2}$, which [nondegeneracy.md:363](../findings/nondegeneracy.md#L363) itself calls "a tautology, since the plateau is defined as two $W_{\mathbb{CP}^2}$ blocks". This belongs in [conventions.md](../findings/conventions.md) beside the $B$, $M$ and $\mu$ collisions already tabled there.

---

## F5, The independence question, answered. It is one derivation with three constructions, and the cross-check is not a fourth.

The block's three derivations are **not in the block**. They are at [problem.md:146](../findings/problem.md#L146), in the section *"Named families"*, and the block carries no pointer to them:

> (a) Fox's abstract nonassociative-algebra idempotents, (b) a coordinate-level Tachibana-trick computation, and (c) a from-scratch explicit-tensor construction all derive the identical equation $n^2-12n+8=0$.

**Here is the decomposition that settles independence.** Every route to this threshold has exactly the same shape:

| stage | what it needs | can it differ between routes? |
| --- | --- | --- |
| 1 | a value for the sphere product: $\theta_0(n)^2=2(n-1)(n-2)/n^2$ | **yes**, different constructions of the tensor |
| 2 | a value for the competitor: $\theta^2=3/2$ | **yes**, different constructions of the point |
| 3 | set stage 1 $\ge$ stage 2 and clear denominators | **no**, one line, forced, identical in every route |

**Stage 3 has no independent versions.** Once the two numbers are in hand, $n^2-12n+8\ge0$ is a rearrangement. So *"derived three independent ways"* is true of the **constructions of the two objects** and false of the **derivation of the threshold**, which is single. The sentence does not distinguish these and reads as the stronger claim.

**How independent are (a), (b), (c) even at stages 1–2?** All three must produce $\theta^2=3/2$ for the competitor. (a) *is* Fox's algebra, where $\sqrt{3/2}$ is the idempotent magnitude; (b) and (c) compute it. **Two routes that agree on stage 2 have already agreed on half the equation.** What is genuinely independent is only the *construction* of the two points, worth having, and not what "three independent derivations of the threshold" says.

**Is the brief's cross-check a fourth derivation? No.** It uses the general closed form $\theta(S^p\times S^q)^2$ at $p=q=n/2$ (stage 1) and the value $3/2$ (stage 2), then stage 3. Stage 2 is shared with all three. Stage 1 is what derivation (c) (the from-scratch explicit-tensor construction), produces, and is in any case Nienhaus Proposition 2.25 from the literature. **It is derivation (c) in a different dress, plus the same forced line.** Its real value is different and worth stating: it shows the *general* two-factor formula specialises consistently to $\theta_0$, so the crossover is the balanced member of a one-parameter family rather than an isolated coincidence.

**The one route that is structurally different is not counted among the three.** [Lemma L48](../findings/problem.md#L213) reaches the same polynomial from the symmetric-space census: $\tfrac16\ge\frac{n^2}{8(n-1)(n-2)}\iff n^2-12n+8\ge0$, and says so, *"the same polynomial as the threshold $n=6+2\sqrt7$, which the argument recovers rather than assumes"*. That is a genuinely different mechanism (a dimension bound on $\lVert W\rVert^2$, not a comparison of two $\theta$'s). **But even it shares stage 2**: L47's $\tfrac16$ is $\mathbb{CP}^2$'s norm, and L47's own closing line is *"$\theta\le\sqrt{3/2}$ on every compact irreducible symmetric space, equality only at $\mathbb{CP}^2$"*. The competitor value is common to every route on the record.

**Verdict on independence: the two objects have been constructed several ways; the threshold has been derived once.**

---

## F6, The competitor is misnamed, and the record contradicts itself about which object it is.

L2 writes *"the $\mathbb{CP}^2$-type competitor (Fox's $\mathcal S^4(\alpha)$)"*, in apposition, as one object. The record says they are two:

- [problem.md:149](../findings/problem.md#L149), item 4: *"The literal '$\mathbb{CP}^2$ zero-padded into $\mathbb R^n$' **is not itself the competitor**, it is only an idempotent at $n=4,5$. The actual persistent low-dimensional competitor is ... Fox's $\mathcal S^4(\alpha)$."*
- [problem.md:223](../findings/problem.md#L223): the padded $W_{\mathbb{CP}^2}$ is *"Verified to twelve digits at $n=10,12,14$ with criticality residual $4\times10^{-16}$"*, and [Lemma L44](../findings/problem.md#L189) uses it as a critical witness at every $n$.

**These two lines cannot both be right**, and the contradiction is live in one file. It is **not** load-bearing for L2: the crossing consumes only the *value* $\theta^2=3/2$, which both objects carry at every $n$ and which padding preserves whether or not the padded point is critical. But L2's parenthesis asserts an identification the record elsewhere denies, and a reader taking L2 at face value inherits it.

---

## F7, "Parity-free" is true of the integer and false of the real root. The odd crossover is a different number, and the record does not hold it.

[results.md:88](../results.md#L88) says *"Lemma L2's crossover and Observation L3's Hessian check are parity-free."* The balanced product $S^{n/2}\times S^{n/2}$ **does not exist at odd $n$**. The attained best sphere product is then $S^{(n-1)/2}\times S^{(n+1)/2}$, and the same closed form gives

$$\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)},$$

matching [conventions.md](../findings/conventions.md)'s $\Theta_n$, including the square root that file records as having been missing until 2026-09-04. Setting it $\ge\tfrac32$:

$$4(n-1)(n-3)\ge3(n+1)(n-2)\iff n^2-13n+18\ge0\iff n\ \ge\ \frac{13+\sqrt{97}}2=11.4244289\ldots$$

**A different real crossover, $11.4244$, not $11.2915$.** Checked at both endpoints: $n=11$ gives $121-143+18=-4<0$ and $\Theta_{11}^2=40/27=1.4815<3/2$; $n=13$ gives $169-169+18=+18>0$ and $\Theta_{13}^2=120/77=1.5584>3/2$ (so $\Theta_{13}=1.2483756$, agreeing with [results.md:220](../results.md#L220)).

**The integer conclusion is unharmed**, $12$ is even and $13$ passes, so $n\ge12$ holds at both parities, which is what [results.md:220](../results.md#L220) already says correctly about $\Theta_n$. But *"exact"* and *"parity-free"* in the same record, about the same crossover, are then claims about two different things, and the record states neither the odd polynomial $n^2-13n+18$ nor the odd root anywhere I could find. **This is the only place where L2's own words "exactly" and "parity-free" pull against each other**, and it is repaired by one sentence rather than by any change of value.

---

## F8, The threshold is about a crossing of two known points, not about where the conjecture holds. The block over-reaches; its citations do not.

These are different statements, and the difference is the whole scope of the programme:

| | statement | status |
| --- | --- | --- |
| what L2 proves | for $n\le11$, $\max P\ge\sqrt{3/2}>\theta_0(n)$, so **Conjecture A is false** there | proven (the competitor lies in $\mathcal W_n$ at every $n\ge4$ by padding) |
| what L2 does **not** prove | for $n\ge12$, $\max P=\theta_0(n)$ | **the open conjecture** |

So *"reproduces the $n\ge12$ threshold exactly"* is sound **only** as the necessity half: $12$ is the least integer at which the known obstruction stops obstructing. The block says nothing to scope it that way, and read plainly it invites the sufficiency reading.

**I checked all citations for that conflation and found none.** The genuine numbered-L2 citations are six, and every one keeps the necessity direction:

- [results.md:13](../results.md#L13), *"Threshold $n=6+2\sqrt7$ exact, and $n\ge12$ **necessary** | Proven (Lemmas 2, 43, 44)"*. Correct.
- [results.md:37](../results.md#L37), *"$\theta_0(n)$ crosses $\sqrt{3/2}$ at $n=6+2\sqrt7$ (Lemma L2)"*. Pure crossing. Correct.
- [results.md:112](../results.md#L112), adds *"it says the $\mathbb{CP}^2$-type competitor **genuinely wins below the crossover**"*. Explicitly the necessity half. Correct.
- [results.md:88](../results.md#L88), the parity claim of F7.
- [results.md:300](../results.md#L300) and [problem.md:160](../findings/problem.md#L160), the two copies of the block.

**The over-reach is in the block's wording, not in what the record does with it.**

---

## F9, The "13 citations" count is inflated by a name collision. `L2` names at least three different things.

[isotropy-cap.md:58](../findings/isotropy-cap.md#L58), [:118](../findings/isotropy-cap.md#L118) and [:127](../findings/isotropy-cap.md#L127) use **"Lemma L2"** for a *local proof step of Reviewer 65's route* (*"every $d$-dimensional subspace has $\mu\ge4d^2/n-2d$"*), with no relation to the numbered result. Its sibling "Lemma L1" in the same paragraph likewise collides with numbered [Lemma L1](../findings/problem.md#L400). Further non-citations: `L1`/`L2`/`L3` as per-review claim labels throughout [reviews/INDEX.md](INDEX.md), and *"Theorem 1 and L2"* as **script** labels at [fence-posts.md:259](../findings/fence-posts.md#L259) and [ad-form-attempt.md:25](../findings/ad-form-attempt.md#L25).

[LEDGER.md:266](../findings/LEDGER.md#L266) has already caught one instance of exactly this (*"L2's apparent citation is an artifact of the block scan"*) so the failure mode is known and the collision behind it is not yet fixed. This is the same class as the $B$, $M$ and $\mu$ collisions [conventions.md](../findings/conventions.md) tables, and it defeats standing rule **M14** (*query the record by NUMBER, never by vocabulary*) by making the number itself ambiguous.

---

## F10, A smaller note: the "Mechanism" section's second finding gives $n\ge11$, not $n\ge12$, and the record is honest about it.

[problem.md:133](../findings/problem.md#L133) says *"Two independent findings converge on the same picture"*, the second being Xu's polynomial obstruction $(n+1)(n+2)(n-10)-2$. That is $-2$ at $n=10$ and $+154$ at $n=11$, so it flips at $n=11$, and the text itself says Xu splits *"at $n=10/11$"* while the Beitz/Böhm–Wilking conjecture *"requires the **safer** $n\ge12$"*. **"Safer" is an admission that this route does not produce $12$.** No correction needed (the wording is already honest) but it confirms that the crossover is the *only* thing on the record that yields $12$ exactly, which raises rather than lowers the cost of F1.

---

## Verdict and repairs

**VERDICT: CONFIRMED.** $n=6+2\sqrt7$ is the correct real crossover between the balanced sphere product and the $\theta=\sqrt{3/2}$ competitor; the inequality fails strictly at $n=11$ and holds strictly at $n=12$; $12=\lceil6+2\sqrt7\rceil$ is the correct integer threshold at **both** parities; the value is on the right side of the $\sqrt{3/2}$ trap and certifies its own normalisation. **I reprove the whole thing in §F2–F4 from two record-quoted inputs, which is what the block should have contained.** No witness against the number was found and none exists, the two competing values are exact rationals against $3/2$ at every integer $n$.

Six repairs, in descending order of cost:

1. **Put §F2–F4 in the block.** It is five lines. The `Lemma` label currently rests on nothing, and has since the file was created.
2. **Delete the move-note at [problem.md:162](../findings/problem.md#L162).** It says an argument was moved; `git show 56848c5e:results.md` shows there was none. **Check the other blocks carrying the same boilerplate**, it was applied file-wide, and L2 is unlikely to be the only one where it is false.
3. **Replace "derived three independent ways"** with what is true: *"the two points have been constructed three independent ways; the crossing itself is one forced line, common to all of them."* Add the pointer to [problem.md:146](../findings/problem.md#L146) that the block lacks, and cite [Lemma L48](../findings/problem.md#L213) as the structurally different route that recovers the same polynomial.
4. **Scope the second sentence.** *"Reproduces the $n\ge12$ threshold exactly"* → *"gives $n\ge12$ as **necessary**: below it the competitor beats $\theta_0(n)$ and Conjecture A is false. Sufficiency is the open conjecture."*
5. **Fix the parity sentence at [results.md:88](../results.md#L88)**, and record the odd crossover: $\Theta_n^2\ge\tfrac32\iff n^2-13n+18\ge0\iff n\ge\tfrac{13+\sqrt{97}}2=11.4244$, integer threshold $12$ at both parities.
6. **Two entries for [conventions.md](../findings/conventions.md):** the $\sqrt3/2$ collision of F4 ($\theta_0(4)$ and the Fox plateau, neither a deflated $\sqrt{3/2}$), and the `L1`/`L2` collision of F9. Rename [isotropy-cap.md](../findings/isotropy-cap.md)'s local labels, they are the ones that break rule **M14**.

Unresolved and referred, not a defect of L2: the contradiction of **F6** between [problem.md:149](../findings/problem.md#L149) and [problem.md:223](../findings/problem.md#L223) about whether padded $W_{\mathbb{CP}^2}$ is critical above $n=5$. **L2 does not depend on it** (only the value $\sqrt{3/2}$ is consumed, and padding preserves it either way) but [Lemma L44](../findings/problem.md#L189) uses the padded point *as a critical witness on $\partial\Omega_0$*, and there the answer may matter. **Settling it needs a computation** (evaluating $Q(W)-\theta W$ at the padded point for one $n\ge6$) which this brief does not authorise. What each outcome would mean: if the residual is zero, [problem.md:149](../findings/problem.md#L149) item 4's *"only an idempotent at $n=4,5$"* is false and should be struck; if it is nonzero, [problem.md:223](../findings/problem.md#L223)'s twelve-digit verification and L44's witness both need re-examination. **Stopping here.**
