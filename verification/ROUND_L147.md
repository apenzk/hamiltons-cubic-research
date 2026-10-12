# ROUND L147, the tube radius against $\sup\lvert P\rvert$, and the $\Theta(n^{-1})$ ceiling

**Id** L147 · **File** [findings/second-order.md](../findings/second-order.md), lines **1157–1176** · **Opened** 2026-09-05

**Verifiers allocated:** v22, v23, v24. **Phase:** 1, dispatched.

**Why this id.** Tier C, first entry with **no verification round at all**. Three rounds have now leaned on its branch-1 form $(c_p+u^2)/(S+au)$ and on its $\beta\in[0,\tfrac12]$ range without either being audited, *and [ROUND_L149](ROUND_L149.md)'s F12, that "the first is minimised at $w=0$" is false because $u\ne w$ and $f'(0)<0$, attacks this lemma's form rather than L149's.* Its index row records a Gate 2 whose **mechanism was refuted while the inequality survived as an order**, the shape this chain has failed in twice.

**Canonical cross-check.** [results.md](../results.md) carries no L147 entry.

**Carried in from [ROUND_L149](ROUND_L149.md) as a pre-registered question, not a verdict:** whether branch 1's minimiser is $u=0$, and whether $u$ and $w$ are the same variable.

## The brief as dispatched

**Provenance stripped, mathematics verbatim**, per the independence rule.

```
#### Lemma L147, the tube radius tracks $\sup\lvert P\rvert$ on $\beta\in[0,\tfrac12]$, and the route ends at $\Theta(n^{-1})$


> **LEMMA L147.** *With $\sup\lvert P\rvert=\Theta(n^\beta)$,*
> $$r_n\;\gtrsim\;n^{-1-\beta}\qquad\text{on }\beta\in[0,\tfrac12],$$
> *and the route is capped at $\Theta(n^{-1})$. **$\beta=\tfrac12$ gives $n^{-3/2}$ and is confirmed, pinned by the $P$-side branch alone. $\beta=0$ gives $n^{-1}$ and is plausible with an unpinned constant.***

**The admissible range is a closed interval, and that is what makes the ceiling question empty.** $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)\uparrow\sqrt2$ forces $\beta\ge0$; [Lemma L143](bounds.md) forces $\beta\le\tfrac12$. *So the radius lives in $[n^{-3/2},n^{-1}]$ and there is no region in which a ceiling above $n^{-1}$ could bind.* **The first version claimed "no ceiling", which is false four separate ways**, the $P$-side branch caps itself at $c_p/\theta_0\le3/(n-2)$; the corrected quartic branch is $\Theta(n^{-1})$; the validity cap $r_n\le\rho/2$ is $O(g_n)$ on the directions where $\rho=\Theta(g_n)$; and $\beta\ge0$ empties the region regardless.

> **THE SUBSTITUTION $\lVert A''\rVert=O(1)$ IS WRONG BY $\sqrt n$, AND BOTH REVIEWERS DERIVED THE SAME REPLACEMENT.** $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ is a supremum **over the disc**, so it grows with it: $x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm and $\lVert\mathrm{Alt}\rVert\le1$, giving $M=O(\rho)$ and hence
> $$\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)=O(n^{1/2})\quad\text{on the margin summand},$$
> *which returns the record's own $O(n)$ at $\rho=\Theta(g_n)$, as it must.* **$O(1)$ would need $\lVert H\rVert_{op}=O(g_n)$, which is a prior review's actual mechanism; [Lemma L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects) meets only the weaker $o(1)$ wording of that test.*

> **AND IT WAS A QUANTIFIER ERROR.** [Lemma L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects) bounds one summand; the chain's $\lVert A''\rVert$ ranges over all ten of [Lemma L27](nondegeneracy.md)'s. *A single mixed direction with $u\asymp n^{-1/2}$, margin $\Theta(1/n)$ and $\lVert A''\rVert=\Theta(n)$ restores $n^{-3/2}$ at every $\beta$.* **Both reviewers closed the sweep the lemma owed**: $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ by the triangle inequality and $c(H)\gtrsim c_p+w^2$ since $L_e$ is scalar on each summand, uniformly in $w\in[0,1]$. It returns these values and the $\Theta(n^{-1})$ ceiling.

**The chain has two branches, not three.** $f(u)=(c_p+u^2)/(S+au)$ has $f'(0)=-ac_p/S^2<0$, so $u=0$ is **never** its minimum; the minimum is interior at $u^*=(\sqrt{S^2+a^2c_p}-S)/a$ with $f(u^*)=2u^*/a=\Theta(\min(c_p/S,\sqrt{c_p}/a))$, at every $\beta$ and every $a$. *The first version argued the cubic branch collapses to $u=0$ because the denominator is $S+u$, a reason that never uses $a$, and which would erase a prior review's confirmed $n^{-3/2}$ cap.* **So the cubic branch always shadows the quartic, and "both defect branches moved out of the way" is impossible in principle.**

**$\gtrsim$, not $\Theta$.** The chain is an inequality, [Lemma L145](ROUND_L145.md#lemma-l145-the-balanced-orbit-tube-radius-is-thetan-32-and-the-constant-chain-that-gives-it) withdrew its own equality reading, and $\sup\lvert P\rvert$ is bracketed rather than known, so $\beta$ is not an exponent. *The first version wrote $\Theta$, the exact error L145 step 4 had been corrected for two entries earlier.*

```

## Clustering

**v22 `GAP`, v23 `HYPOTHESIS-DEBT`, v24 `GAP`.** *v24 settles the impact the other two left open: the two-forms discrepancy costs **a constant, not an order**.*

**Both agree on the finding that reaches the whole chain**, and the round has reproduced it independently.

| # | finding | state |
|---|---|---|
| **F1** | **The headline $r_n\gtrsim n^{-1-\beta}$ has no derivation on file.** L147 asserts it with *"It returns these values"*; the chain first appears two entries later in [L149](../findings/second-order.md), whose repair is itself unaudited, and the L149 step it would need is the one **L147's own body refutes**. *Reproduced: line 1173 refutes what line 1202 asserts.* | v22, v23 |
| **F2** | **The record carries branch 1 in two incompatible forms, in one file.** $\tfrac{c_p+u^2}{S+au}$ at lines 1173 and 1254; $\tfrac{c_p+w^2}{S}$ at line 1202, which is [L149](../findings/second-order.md)'s own chain display. **[L158](../findings/second-order.md) at line 1282 says in writing that the second is wrong, and the second still stands.** *Verified line by line by the round.* | v22, v23 |
| **F3** | **$u\ne w$.** $u$ is the defect's linear rate, defined at line 1227 (*below* L147) while $w=\lVert H_r\rVert$; the only relation is $u\le Cw$ with $C$ **recorded unknown** at lines 1360 and 1421 | v22, v23 |
| **F4** | **$a$ is never defined or bounded**, yet the headline holds only if $a=O(n^{\beta+1/2})$. At $n=12$, $\beta=0$, $a=n$: $f(u^*)=0.0858$ against the needed $c_p/S=0.3$, a factor $3.498$ growing like $\sqrt n$, **reinstating the $n^{-3/2}$ the entry's own box declares refuted** | v22, v23 |
| **F5** | The $\Theta(n^{-1})$ ceiling is proven only as $O(n^{-1})$ | v22 |
| **F6** | $M=O(\rho)$ rests on a real-symmetric nonexpansiveness argument used under a supremum over a **complex** circle | v22, v23 |

### The pre-registered question, settled both ways by both

$f$ **is** minimised in the interior, exactly as L147 writes it, $u^*=(\sqrt{S^2+a^2c_p}-S)/a$, $f(u^*)=2u^*/a$, every line checking, and $u^*\le\sqrt{c_p}$ so it is always admissible. **And $u$ is not $w$.** *So [ROUND_L149](ROUND_L149.md)'s F12 was right to attack the form and wrong about which lemma owns it: L147's algebra is sound; what fails is L149's display of it.*

### What round 1 missed, and why

**[ROUND_L149](ROUND_L149.md) audited line 1202 and left it standing.** The contradiction lives *between* blocks (L158 refutes a display inside L149) and a brief quoting one block cannot see it. *That is a limitation of the per-lemma brief, not of the verifiers.*

## Adjudications

**None dispatched.** F1–F4 are unanimous or carry closed-form exhibits the round reproduced; F5 and F6 concern a stated justification rather than a conclusion. *Nothing is deleted on one reader's word.*

## Spread and impact

**Impact: `NARROWS`, not `FATAL`**, and that is v24's contribution.

- **The two-forms discrepancy costs a constant.** L147's $\tfrac{c_p+u^2}{S+au}$ is the **valid** lower bound; [L149](../findings/second-order.md)'s $\tfrac{c_p+w^2}{S}$ drops $au$ and so **overstates**. Their infima bracket within a bounded factor, since $a\sqrt{c_p}=O(1)=O(S)$ at $\beta=0$. *Three rounds were spent on a constant.*
- **The $\Theta(n^{-1})$ ceiling is PROVED**, by one of its four stated reasons alone: $c_p/S\le c_p/\theta_0=3/(n-2)$, exact and unconditional in $\beta$. *Reason (b) is unproven and false where read, it needs a **lower** bound on $\lVert A''\rVert$, and [L148](../findings/second-order.md) sets that to zero on the very summand.*
- **The radius $r_n\gtrsim n^{-1-\beta}$ is `HYPOTHESIS-DEBT`.** All three agree it is asserted and not derived here. **It is not refuted**, what is owed is the joint minimisation over $w$, which appears in no entry preceding L147.

**A false instance of "at every $a$", and the conclusion this round drew from it is RETRACTED.** At $a=0$ the minimum **is** $u=0$, and this round inferred from that that [L149](../findings/second-order.md)'s "the first is minimised at $w=0$" is right where applied, withdrawing [ROUND_L149](ROUND_L149.md)'s F12. **[ROUND_L148](ROUND_L148.md) overturns it, three verifiers to nil**: [L148](../findings/second-order.md) pins the **variable** $u$ to zero, not the **coefficient** $a$, and at $u=0$ with $a>0$ the function is *decreasing*, so $w=0$ is where branch 1 is **largest**. *F12 stands; the withdrawal was mine and rested on a reading v24 supplied and this round accepted without deriving.*

**The kernel trap is sprung, with a named witness.** $W_{\mathbb{CP}^2}$ is Morse–Bott nondegenerate ([L28](../findings/nondegeneracy.md)) with $\dim\ker W=3$ (self-dual Einstein, $W\equiv0$ on $\Lambda^2_-$) so $g_n$, $\rho$, $M$ and branches 2–3 **cease to exist there**. *First time in this chain that the record's recurring obstruction has been exhibited on a concrete object rather than noted as a risk.*

| dependent | disposition |
|---|---|
| [L149](../findings/second-order.md)'s chain display | `NARROWED`, its form overstates; the correction is a constant, and the display is corrected to L147's form |
| [L157](../findings/second-order.md), [L158](../findings/second-order.md) | `SURVIVES`, both already carry $\tfrac{c_p+u^2}{S+au}$ |
| [I2](../plan.md), [I33](../plan.md) | `SURVIVES` on the order; the radius they cite carries the debt |

## Outcome

**Verdict: `HYPOTHESIS-DEBT`. Impact `NARROWS`.**

| written in | why |
|---|---|
| **four hypotheses**, base point $W^*$, $n$ even, $n\ge12$, $\ker W^*=0$ | all four used, none stated; the kernel one has a named witness against it at $W_{\mathbb{CP}^2}$ |
| **the ceiling's real proof** | $c_p/S\le c_p/\theta_0=3/(n-2)$, unconditional in $\beta$, one of the four stated reasons carries it, and reason (b) is false where read |
| **the debt itself** | the radius is asserted and derived nowhere; what is owed is the joint minimisation over $w$ |
| **eight summands, not ten** | $\langle W\rangle$ and the orbit are removed by the orthogonality; at ten the margin floor would be $-\tfrac32\theta_0$ |
| **[L149](../findings/second-order.md)'s chain display corrected to L147's form** | the old display drops $au$ and overstates; a constant, not an order |
| **[ROUND_L149](ROUND_L149.md)'s F12 withdrawn in place** | at $a=0$ the minimum **is** $u=0$, and [L148](../findings/second-order.md) makes $a=0$ on both copies, the claim is right where it is applied |

**Nothing was retracted.** The ceiling is stronger than the entry's own four reasons suggested; the radius is owed rather than wrong.

**What four rounds now say about this chain.** Two proofs failed to establish true statements; one true statement had unwritten scope; and this one has a **true ceiling and an underived headline**. *All four defects are invisible to a check that reads the conclusion, which is what the eight Gate 2 reviews before them did.*

**The corrected text is unaudited** and re-enters the queue.
