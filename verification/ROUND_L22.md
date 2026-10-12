# Round L22, the estimate the localization theorem needs

**Id:** L22 · **Date:** 2026-09-07 · **Verifiers:** v203, v204, v205 · **Brief:** [BRIEF_L22.md](BRIEF_L22.md)

## Sources, verbatim

| passage | source |
|---|---|
| the canonical entry | [results.md](../results.md) lines 725-729 |
| the landscape statement | [results.md](../results.md) line 236 |
| a summary line elsewhere | [results.md](../results.md) line 41 |
| the block | [findings/route-a.md](../findings/route-a.md) lines 534-564 |

## The findings from phase 0

**The block states its own circularity and the record keeps consuming it.** *"Both branches use the sphere-product value as their constant, so the estimate is conditional on the conjecture at critical points past $n=12$."* **This programme's goal is that conjecture.** The landscape line repeats the charge; the summary line at [results.md](../results.md) line 41 says the neighbourhood is closed *"conditional on"*, the round must decide whether what remains is a theorem, a conditional statement with a usable hypothesis, or an assumption of the conclusion.

**A note is interpolated into the middle of a sentence.** The block's last paragraph opens *"**Where a large-$n$ test belongs.** The ratio of"*, then an italic note about the display above intervenes, then the sentence resumes *"the true value to the requirement peaks near $\alpha=0.23$"*. **The paragraph cannot be read in file order**, and the note is the annotation habit this audit has recorded at [L21](ROUND_L21.md) arriving mid-sentence.

**The label was changed and the consumers were not checked.** The block carries `Observation`, which on this record asserts numerical verification at the dimensions named and nothing more. **[L20](../findings/route-a.md) and the tube argument cite it**, and whether they cite it as a measurement is the round's question.

## What the verifiers are asked beyond the standing list

Whether the reduction to $\gamma_{\max}(\alpha)<\frac{3-5\alpha}{\sqrt3}$ is exact and follows from $f'(\varphi)=3\sin\varphi\,\tilde f(\varphi)$ with $\tilde f(\pi/6)=(5\alpha+\sqrt3\gamma-3)/4$; whether *"the configuration is forced"* ($W_2$ entirely in $\ker F_u$ with $s^2=3\varepsilon$ an **equality**), is derived or asserted; whether the hard-case trust-region reduction is legitimate and its value $V(t)$ correct, including the breakpoint $t^*=\sqrt{30}/8$ and the threshold $\alpha^*=32/141$; **whether the two branches genuinely cover complementary intervals with no gap**, the one place a numerical margin of $+0.0074$ and an $n\to\infty$ limit are doing the work; and whether the conditionality is removable or is an assumption of the programme's conclusion.

**And the standing question**: what may a consumer cite from a block labelled `Observation`, whose load-bearing vanishing is measured at three dimensions and whose two dimensions above those are checked by zero-padding.

## Adjudication

**Verdicts: [v203](VERIFY_v203.md), [v204](VERIFY_v204.md), [v205](VERIFY_v205.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, repaired, impact `CONTAINED`.** Unanimous, and the three converged on the same reading of what the block's constant actually is.

**The mathematics is better than the record believed, and all three verifiers rebuilt it.** Each derived the reduction to $\gamma_{\max}(\alpha)<\frac{3-5\alpha}{\sqrt3}$ from $\tilde f(\pi/6)=(5\alpha+\sqrt3\gamma-3)/4$; each obtained $V(t)$, $t^*=\sqrt{30}/8$ and $\alpha^*=32/141$ **without the trust-region import**, from self-adjointness and $M_{W_1}\hat q=0$ alone. *The import's hypotheses do hold (this is not a repeat of the unital-algebra failure) and it is dispensable.* One verifier derived the borderline as an identity, $g_1(\alpha)=(1+\alpha)\sqrt{1-2\alpha}$ equalling $4/(3\sqrt3)$ at $\alpha=\tfrac13$ and only there.

| id | step attacked | mechanism | support | outcome |
|---|---|---|---|---|
| **C1** | the reduction and every printed constant | independent re-derivation, three times | 3/3 | `CONFIRMED` |
| **C2** | the trust-region import | hypotheses unchecked against the object | 3/3 | `CONFIRMED` as sound **and eliminable** |
| **C3** | what the constant stands for | $\sup\{P(K):K\in\ker F_u\}$ at one critical point | 3/3 | `CONFIRMED`, named in the block |
| **C4** | *"$V=\min$ of the two"* | false above $t^*$ | 2/3 | **`REFUTED`**, struck in three files |
| **C5** | *"this one covers $\alpha\ge0.2270$"* | conflates $\alpha^*$ with a coverage endpoint | 2/3 | **`REFUTED`**, and it closes the record's own standing flag |
| **C6** | the overlap at large $n$ | no closed form for either endpoint, monotonicity asserted | 3/3 | `GAP`, stated as unchecked |
| **C7** | $c_0=1$ | asserted; the equality $s^2=3\varepsilon$ rests wholly on it | 3/3 | `HYPOTHESIS-DEBT` |
| **C8** | $\sqrt{5/6}$ and $\tfrac23$ | measured at $n=10$, below the range they cap | 1/3 | `CONFIRMED`, and padding runs the wrong way |
| **C9** | the padding sentence | attached to the vanishing; padding re-reports the datum | 2/3 | `BROKEN`, rewritten |
| **C10** | the circularity's extent | the block names one use; there are three | 2/3 | `CONFIRMED` |
| **C11** | the brief's own premise | that L20 and the tube argument consume L22 | 3/3 | **`REFUTED`**, see below |

### C5, and it closes a flag the record raised against itself

The block carried its own note that *"the two figures do not sit together as printed"*, $0.223$ against $32/141$. **They were never comparable.** $\alpha^*=32/141$ is where $V$'s two branches meet (the point below which $B>0$) and reading it as where the frontier branch stops covering is what manufactured the inconsistency. *The $+0.0074$ is a margin in $\gamma$ at the handover.* **The flag is struck along with the sentence that caused it.**

**What replaces it is weaker than what stood, and that is the honest position.** One verifier derived Nienhaus's branch in closed form, reproduced $0.3223$ at $n=12$ and $0.2350$ at $n=100$ to five decimals, and put the frontier's reach near $0.197$ against his $0.2261$, no gap. **That derivation stays in its report.** *A verifier may read an imported theorem at source; the record adopting the closed form it produced would be new mathematics arriving under a check's letterhead.* The block now says the overlap is unchecked and names what would close it.

### C11, and the brief carried the error into the round

**Nothing on the record consumes this block.** [Lemma L20](../findings/route-a.md) *is* the tube argument and takes neither L22 nor L102; the record says so in four places. **The brief asserted the opposite and made that misdescription a fifth time**, written by the round, from the summary line at [results.md](../results.md) line 41, which named L21's debt as L22's and bundled a block nothing cites into a chain. *All three verifiers caught it independently, which is what three cold readers are for.* Line 41 and the landscape line are rewritten; **the blast radius of everything owed here is nil**, and the block's value is that it closes Nienhaus's open estimate on its own terms.

### The circularity, decided

**The constant is $\sup\{P(K):K\in\ker F_u,\lVert K\rVert=1\}\le\theta_0(n)$**, a bound on a proper subspace at one critical point. *Strictly weaker than Conjecture A, and carrying its inequality half where it is used*; the branch tolerates a constant about $4\%$ above $\sqrt2$, so it is load-bearing rather than a formality. **The frontier branch is a genuine conditional. The block's claim that this is the estimate's only debt to the conjecture is false**: Nienhaus's §4.5 standing sentence and his Theorem 4.19's second case invoke it again, so discharging L22's own dependence would not make the composite unconditional. Both are now in the block.

### What is not repaired here

**C7 and C6 need new mathematics and are filed in [plan.md](../plan.md).** $c_0=1$ and $\lambda=\tfrac23$ have no derivation anywhere, and $\alpha^*$ moves with the second; neither coverage endpoint has a closed form. **The cheap route both verifiers named is filed with them**, the frontier branch reduces to positivity of one cubic at a single constant, covering every $n\ge12$ at both parities, where the record uses two data points and an extrapolation.

