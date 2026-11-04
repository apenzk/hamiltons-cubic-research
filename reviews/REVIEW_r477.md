# REVIEW r477, Lemma L18

**Status: REFUTED as labelled and as stated (the priced term is confirmed), see verdict.**

Claim under audit: Lemma L18 in [findings/problem.md](../findings/problem.md), "the diagonal proof's middle chapters, lifted with the defect cost quantified".

Findings appended below as reached.

## Findings

### F1, the block is prose only; the header "canonical statement and proof" is false, and the pointer chain dead-ends

[findings/problem.md](../findings/problem.md) lines 262–270 are the whole of L18: four paragraphs, **no displayed equation, no derivation, no $\square$**. Every neighbouring block in the same file (L2, L44, L47, L48, L1, L20-as-"L18", steps 1/2/3) carries displayed algebra and a QED. L18 does not.

The pointer chain is worse than absent:

| file | what it says | where it sends you |
| --- | --- | --- |
| [results.md](../results.md) line 649 | "**Proof:** [problem.md](findings/problem.md)" | problem.md |
| [findings/problem.md](../findings/problem.md) line 264 | "*Moved here from results.md, where the argument was the only copy. That file now carries the statement and points here.*" | nowhere |

So results.md points at problem.md for the proof, and problem.md's own note asserts the argument arrived with the move. **It did not.** The argument (the master identity, the Gram identity, $J_4$, $J_5$, the block decomposition), lives only in [ATTEMPTS.md](../ATTEMPTS.md) §"Lifting Jäger's §3.3 in trace form" (line 860 ff.), and **neither the L18 block nor its results.md entry cites ATTEMPTS.md at all.** A reader following the record's own pointers reaches prose and stops.

This is the exact failure mode that withdrew three results today.

### F2, a MISSING HYPOTHESIS: the E-track certificate, never audited, and the block's own number rests on it

The block grants exactly one thing: *"Granting that cross-term bound off the class where it is already proven, the chain gives: …"*. The record says the honest list is **two**.

- [ATTEMPTS.md](../ATTEMPTS.md) Result 10: *"The dichotomy's honest hypothesis list is therefore: $J_5\ge0$, lifted 3.3.5, and **the E-track certificate**."*
- [ATTEMPTS.md](../ATTEMPTS.md) Result 11, after discharging 3.3.5: *"the Result-10 dichotomy now rests on $J_5\ge0$ **and the E-track certificate** alone."*
- [findings/LEDGER.md](../findings/LEDGER.md), open gaps: *"**Two grants remain in the lifted chain.** $J_5\ge0$ off the commuting class … **And an independent audit of the E-track certificate.**"*
- [findings/LEDGER.md](../findings/LEDGER.md), Gate 2 debt table: **"The E-track certificate | Single-author since inception; never audited"**, and that table's own preamble says *"A claim on this list is cited nowhere as settled."*
- [references/jaeger-2016-diagonal-case/notes.md](../references/jaeger-2016-diagonal-case/notes.md) line 41 says the same: *"Two grants remain open, $J_5\ge0$ off the commuting class, and an independent audit of the E-track certificate."*

**The second grant is not incidental to the displayed conclusion, it produces its number.** [ATTEMPTS.md](../ATTEMPTS.md) Result 7: *"$\delta^2\ge c(n)>0$ with $c(n)$ **explicit from the E-track margins**"*. So the block's headline constant, "computed at $n=12$ to be about $1.0\times10^{-3}$", is the output of a certificate the ledger records as single-author and never audited. **The one quantitative claim in "the defect cost quantified" carries a hypothesis the block does not state.**

Neither [results.md](../results.md) line 649's L18 entry nor its summary line 224 mentions either grant; line 224 states the dichotomy flat, with no conditionality at all. Line 67 flags the cross-term grant only. **The E-track certificate appears nowhere in the canon's account of L18.**

### F3, "the middle chapters" is short, and the record says by how much

The block's enumeration is: §3.3 priced by one term, *"§§3.4 and 3.5 then lift at no cost at all."* Three things fall outside it.

**(a) §3.2 is a second priced entry point, and §3.3 has a second one of its own.** [Observation L15](../findings/problem.md) prices §3.2's master inequality at $+24\|\mathrm{Alt}(W_-)\|^2$, the *same* constant, a *different* inequality. And [ATTEMPTS.md](../ATTEMPTS.md) Result 10, by-product (a), flagged separately for exactly this reason: **"Lemma 3.3.1 is not defect-free, via 3.2.2 it becomes $r^2\ge\hat\theta\,\mathrm{scal}-24\delta^2$, partially offset through 3.2.3's $\Lambda^4$ term ($-6.4\delta^2$ at $n=12$)."** Jäger's Lemma 3.3.1 sits inside §3.3 and is distinct from Lemma 3.3.4, whose $J_4$ is the block's "one exactly-priced term". So the assembled chain carries **at least three** $\delta^2$ terms, 3.2.2's, 3.3.1's (net of 3.2.3's offset), and 3.3.4's $J_4$, where the block says one. This is the same shape of over-claim that refuted [Observation L15](../findings/problem.md) today ("one obstruction" where the record names two), one lemma later in the same lifting argument.

**(b) §3.4 does not lift free of *open work*, only free of *defect cost*.** [ATTEMPTS.md](../ATTEMPTS.md) Result 8's own closing line: *"§3.4 is now lifted with proofs rather than evidence, and **the remaining bookkeeping is the frame-free Lemma 3.4.7 assembly plus §3.6**."* Result 7 supports Lemma 3.4.7 by *"spot-verified numerically"* at the balanced spheres and Fox. So one link of §3.4 stands on a handful of point checks. "At no cost at all" reads as "established"; it is not.

**(c) The enumeration has been short before, on this exact argument.** Result 10 records Reviewer 10 *"adding one grant this list missed"*, the lifted Lemma 3.3.5, *"whose thesis proof is diagonal-specific and which is load-bearing for $c(12)$"*. It was discharged in Result 11, but only with the weaker constant $4(n-1-\nu_0)$ in place of Jäger's $4(n-2)$, which is why $c(12)$ fell to $92.6\%$ of the granted value. A list that has already been found short once, by an outside reviewer, is not evidence that it is complete now.

### F4, the constants check out; the sharpness attribution and the evidence base do not quite

**The two constants are right.** $D(R)=\tfrac32\sum_{k,l,m}\mathrm{Alt}(R)_{iklm}\mathrm{Alt}(R)_{jklm}$ is Result 2's identity, proven twice ([ATTEMPTS.md](../ATTEMPTS.md): exact integer arithmetic plus Brauer stability, and Reviewer 9's dummy-relabelling proof). $D\succeq0$ is automatic as a Gram form, so $J_4\le\lambda_{\max}(\mathrm{Ric})\mathop{\mathrm{tr}}D$, and $\mathop{\mathrm{tr}}D=6\|\mathrm{Alt}(R)\|^2$. With $|W|=W+2W_-$ and $\mathrm{Alt}(W)=0$ for a Weyl tensor ([conventions.md](../findings/conventions.md)), $\mathrm{Alt}(|W|)=2\,\mathrm{Alt}(W_-)$, so $\mathop{\mathrm{tr}}D(|W|)=6\cdot4\delta^2=24\delta^2$. **The $\tfrac32$ and the $24$ are both correct, and $\delta^2$ is Conjecture L16's own scalar.**

**The cost is stated at critical points, correctly.** The master identity needs $Q(W)=\theta W$; the bound $J_4\le24\delta^2\lambda_{\max}$ needs only $D\succeq0$ and so is pointwise. The block's "at every critical point in every frame" is the right reading of the record and does not confuse the two.

**"Saturated exactly by the $\mathbb{CP}^2$-type competitor" is right but under-stated.** Result 3's equality condition is *"exactly when $\mathrm{Ric}$ is $\lambda_{\max}$ times the identity on $D$'s support"*, which holds at $\mathcal S^4(\alpha)$ (Fox, the competitor) **and at QK $\mathbb{HP}^2$**. "Exactly" names one point where the record names a condition met at two.

**"Generic saddle points" is one dimension.** The block says the identity is verified *"on the named families and on generic saddle points alike"*. Result 5's honest note: *"the $n=8$ generic-saddle search (15 L-BFGS starts) converged to nothing below the residual tolerance, **so the generic population is $n=6$ only**."*

**The isotropy claim survives.** *"an isotropy argument forces the relevant operators to commute there"* is supported: [ATTEMPTS.md](../ATTEMPTS.md) Result 13, Theorem B$'$, hand-proves $[H,W]=0$ at every named critical point from $h=\mathrm{Ric}(|W|)$ being isotropy-invariant. That attack fails. Two caveats the block omits: Result 13 is marked *"Single-run agent result, unreviewed; the review is owed and deferred"*, and its script's *"parts 5–7 did not"* complete.

### F5, an identifier collision: [problem.md](../findings/problem.md) contains two disjoint "Lemma L18"s, and one of them is the canon's L20

Lines 401–411 of the same file, under §"Nienhaus Theorem 4.19 is conditional on Conjecture A", say "Lemma L18" three times, including a displayed

> **Lemma L18 (unconditional).** For every $n\ge12$, no maximizer of $P$ on $\mathrm{Weyl}^1_n$ lies within angular distance $0.5748$ of $SO(n).W_{\mathbb{CP}^2}$.

That statement is **[Lemma L20](../results.md)** in the canon, verbatim ("no maximizer of $P$ on the unit sphere of $\mathcal W_n$ lies within angular distance $0.5748$ of the orbit $SO(n).W_{\mathbb{CP}^2}$", results.md line 656). It has nothing to do with lifting Jäger's chain. Consequences:

- A reader searching [problem.md](../findings/problem.md) for "Lemma L18" finds the tube theorem, complete with a proof, before finding the real L18, which has none, the strongest possible way to mislead about F1.
- Line 401's sentence *"The conditional form of Lemma L18 took 4.19's conclusion as a hypothesis"* is **false of the actual L18**, which takes nothing from Nienhaus 4.19.
- The canon's L20 entry has already been corrected three times for wrong dependency descriptions ([r463](REVIEW_r463.md), [r464](REVIEW_r464.md)); a stale second name for it in the findings file is exactly how a fourth happens.

### F6, $\tilde\theta_0(n)$ carries the block's threshold and is defined nowhere in the record

The displayed conclusion is written in $\tilde\theta_0(n)$ twice, the threshold cleared, and the scalar floor $(n+1)\tilde\theta_0(n)$. The symbol is **absent from [conventions.md](../findings/conventions.md) and from [INDEX-values.md](../findings/INDEX-values.md)**, and conventions.md's opening rule is that a block needing a convention not there adds it there. [r473](REVIEW_r473.md) flagged this against this same block; it is unrepaired.

Worse, the symbol carries two readings inside [ATTEMPTS.md](../ATTEMPTS.md) alone:

| line | reading |
| --- | --- |
| 612 | the **diagonal maximum at odd $n$**, "equal to $\theta_0(n)$ at every even $n$ … and to $\tilde\theta_0(n)$ at every odd $n$" |
| 631 | **Jäger's weaker chapter hypothesis**, "runs §§3.2–3.5 under the weaker hypothesis $\theta\ge\tilde\theta_0(n)$ … only at the end … $\theta\ge\theta_0(n)$" |

L18 needs the second reading (it is the threshold §§3.3–3.5 run under, and Result 10 quotes both $c(12)$ variants, $1.081\times10^{-3}$ at $\theta\ge\tilde\theta_0(12)$ against $1.223\times10^{-3}$ at $\theta\ge\theta_0(12)$, the smaller constant belongs to the weaker hypothesis, so $\tilde\theta_0<\theta_0$).

*Screened, reported as a screen and not as evidence:* $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$, [conventions.md](../findings/conventions.md)'s freshly-repaired odd-$n$ $\Theta_n$, gives $1.234130$ at $n=12$ against $\theta_0(12)=1.236033$, and $1.248376$ at $n=13$, matching conventions.md's quoted $\Theta_{13}=1.2483756$. **If the two symbols are the same function, the record is carrying one quantity under two names across three files**, the failure conventions.md flags for $\kappa_n$ ("has appeared under two symbols inside one file"). Whether they coincide is not decidable from inside the record; the definition is owed either way.

### F7, the fence post is already on the record, and it is a ceiling on exactly this chain

Searched by quantity, the defect floor $c(n)$ and the chain's $\theta$-coverage, not by identifier.

- [ATTEMPTS.md](../ATTEMPTS.md) Result 12(c): *"**chain-tightening is retired as a route to the core**: $\Theta$-coverage measurements show the lifted chain closes only $\theta\in(1.2337,\theta_0)$ at $\delta^2=0$ shrinking to nothing by $\delta^2\approx2\times10^{-3}$, **a permanent ceiling** (Jäger's $x\le2$ fails beyond), not a work item."*
- Result 10 gives the mechanism: *"for $d\gtrsim0.04$ the chain goes vacuous because Jäger's $x\le2$ hypothesis fails"*, and *"the small-scal branch closes for $\delta^2\lesssim1.2\times10^{-3}$ and **is silent at Fox-sized defect**."*
- [Lemma L19](../findings/problem.md) states the post in one clause: *"the lifted chain goes vacuous once the defect exceeds roughly a thousandth, so tightening it cannot reach the core."*
- **[Post F56](../findings/INDEX-traps.md)** fences the open grant itself: the polarised scal identity returns $J_5$ at every argument built from $W$'s spectral parts, so that whole family of routes to $J_5\ge0$ is closed.

**Would it be true vacuously?** No, both branches are inhabited (Result 12(c) puts the zero-defect $(5,7)$ split inside the window, and Fox sits at $\delta^2=1/9$). But it is close to *useless*, and the block's own last paragraph half-says so. *Screened:* $c(12)/(1/9)=0.90\%$. The dichotomy's defect floor is **under one percent of the live competitor's defect**, so it excludes no catalogued point that was not already excluded. [results.md](../results.md) line 224's *"defect bounded away from zero"* reads as a substantive gap; the number is $10^{-3}$ against $1/9$.

### F8, dependency trace, and what clears

| input | status |
| --- | --- |
| the $\tfrac32$ Gram identity, $D\succeq0$, $\mathop{\mathrm{tr}}D=6\|\mathrm{Alt}\|^2$ | **proved twice** (exact integer arithmetic + Brauer stability; Reviewer 9's relabelling proof). Clears. |
| the master identity at critical points | machine-verified at 12 points, "derivable by hand from the established compressions". **No written derivation in [findings/](../findings/).** |
| lifted Lemmas 3.4.6, 3.4.3, 3.4.8 | **proved** (Result 8), no Bianchi, no diagonality. Clears. |
| lifted Lemma 3.3.5 | **proved** (Result 11), with the weaker constant $4(n-1-\nu_0)$. Clears, at a cost of $7.4\%$ of $c(12)$. |
| $[H,W]=0$ at named critical points | **proved** (Result 13, Theorem B$'$, isotropy). Clears, but Result 13 is *"single-run agent result, unreviewed"*. |
| $J_5\ge0$ off the commuting class | **OPEN.** The block grants it. |
| **the E-track certificate** | **OPEN and never audited**, and the block does not name it (F2). |
| frame-free Lemma 3.4.7 assembly | **OPEN**, "remaining bookkeeping", numerically spot-verified only (F3b). |
| [Observation L15](../findings/problem.md) | L18 takes only the identity and the definition of $\delta^2$, both confirmed and equal to [Lemma L131](../findings/isotropy-cap.md) polarised ([LEDGER.md](../findings/LEDGER.md) line 266). **The relabel does not demote L18.** Clears. |
| [Conjecture L16](../findings/problem.md) | L18 is *motivated* by L16 and does not consume it. Clears, no circularity. |

L18 does not rest on a Conjecture. It rests on **two open grants and one open assembly**, of which the canon names one.

### F9, a minor inconsistency the audit turned up

[findings/LEDGER.md](../findings/LEDGER.md) records the $J_5$ grant's evidence as *"worst ratio $3.93\times10^{-2}$"* over 20 points; [ATTEMPTS.md](../ATTEMPTS.md) Result 13 records *"worst ratio $|\mathrm{cross}|/J_5^{\mathrm{diag}}=0.159$ at an $n=5$ point"*, four times larger. One of the two is stale. It changes no conclusion, but the ledger is the file a reader consults for how safe a grant is.

---

## Verdict: REFUTED as labelled and as stated; the priced term itself is CONFIRMED

**The mathematics of the headline survives every attack I could mount on it.** The $\tfrac32$ and the $24$ are correct and I re-derived the $24=6\times4$ from $\mathrm{Alt}(|W|)=2\,\mathrm{Alt}(W_-)$; the Gram form is a theorem with two proofs; the cost is correctly stated at critical points rather than confused with a pointwise statement; the isotropy argument for the cross term's vanishing is real and hand-proved; $c(12)\approx1.0\times10^{-3}$ is the post-discharge number and matches Result 11 to the digit given. **I could not break the priced term.**

**What is refuted is the block.**

1. **It has no proof, and its pointers dead-end** (F1). The header says "canonical statement and proof"; there are four paragraphs of prose. [results.md](../results.md) sends the reader to [problem.md](../findings/problem.md), whose own note claims the argument arrived with the 2026-08-31 move. It did not, it is in [ATTEMPTS.md](../ATTEMPTS.md) §"Lifting Jäger's §3.3 in trace form", cited by neither.
2. **Its hypothesis list is incomplete in the canon** (F2). The E-track certificate (*"single-author since inception; never audited"*), is load-bearing for the very constant the block quantifies, and appears in no statement of L18 anywhere.
3. **"The middle chapters" is short** (F3): §3.2's own $24\delta^2$, Lemma 3.3.1's $-24\delta^2$ net of 3.2.3's offset, and the open Lemma 3.4.7 assembly. The block says "one exactly-priced term" and "§§3.4 and 3.5 lift at no cost at all".

**The label it deserves.** A statement resting on two open grants and one open assembly is not a Lemma. **Observation L18 (conditional)**, with the hypotheses written out:

> *At every critical point of $P$ with $\theta\ge\tilde\theta_0(n)$, granting (i) $J_5\ge0$ off the commuting class, (ii) the E-track certificate, and (iii) the frame-free Lemma 3.4.7 assembly, either $\mathop{\mathrm{scal}}(|W|)\ge(n+1)\tilde\theta_0(n)$ or $\delta^2\ge c(n)$, with $c(12)=1.0008\times10^{-3}$.*

The **unconditional** content that should keep the `Lemma` label is narrower and is worth stating on its own: *the Bianchi correction to Jäger's §3.3 is a PSD Gram form in $\mathrm{Alt}(R)$ with constant $\tfrac32$, so $J_4\le24\,\delta^2\,\lambda_{\max}(\mathrm{Ric}(|W|))$, with equality when $\mathrm{Ric}$ is $\lambda_{\max}$ on $D$'s support.* That is proved, dimension-free, and independent of every open grant.

**Repairs owed, in order:** cite [ATTEMPTS.md](../ATTEMPTS.md) from both L18 blocks, or move the argument; add the E-track certificate to the hypothesis list in [problem.md](../findings/problem.md), [results.md](../results.md) lines 224 and 646, and [INDEX-results.md](../findings/INDEX-results.md) row 18; rename the stale "Lemma L18" at [problem.md](../findings/problem.md) lines 401–411 to **L20**; define $\tilde\theta_0(n)$ in [conventions.md](../findings/conventions.md) and reconcile it with $\Theta_n$; downgrade the label.

**Status: closed.**
