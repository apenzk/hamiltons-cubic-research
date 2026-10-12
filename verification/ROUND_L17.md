# ROUND_L17, first-order protection at the rival maximizer

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `NARROWS`. **Verifiers:** v185, v186, v187.

## Sources, verbatim

| what | where |
|---|---|
| Canonical entry | [results.md](../results.md) lines 677–679, **a heading and a proof pointer, and nothing else** |
| Landscape statement | [results.md](../results.md) line 222 |
| The block | [route-a.md](../findings/route-a.md) lines 71–88 |
| The argument | [ATTEMPTS.md](../ATTEMPTS.md) Result 6, at line 823, **a notebook** |
| Brief | [BRIEF_L17.md](BRIEF_L17.md) |

## The finding from phase 0: a diagnosed circular pointer, still live

**Its own audit of 2026-09-04 recorded**: *"THIS BLOCK SAID 'CANONICAL STATEMENT AND PROOF' AND CARRIED NEITHER … **And the pointer is circular**: this block records that the canon now carries the statement and points here, while the canon points here for the argument."*

**Three days later both halves of that circle are intact.** [results.md](../results.md) line 677 is a heading over a bare `**Proof:**` pointer, *the same shape as L19 and L14, which this audit withdrew earlier today, except that L17 is live*, and the block still carries prose rather than a statement. **The argument is in [ATTEMPTS.md](../ATTEMPTS.md), which is the lab notebook and is read chronologically.**

*The audit that found this called it the "third occurrence today of a heading promising a proof that is not below it". It repaired none of the three.*

## What the verifiers are asked beyond the standing list

Whether $d^+\delta^2(u;H)=-2aF(H)$ is right and what it needs; whether the reduction to Jensen's trace inequality closes; whether the two structural facts named, the first Bianchi identity forcing a self-dual/anti-self-dual trace balance on the distinguished $4$-plane, and unit-norm tangency fixing the remaining diagonal entry, do the work claimed; whether $\{F=0\}=\{H:\Pi_{ASD}H\Pi_{\ker u}=0\}$, and whether it really holds $\sim89\%$ of directions at $n=12$; and **whether the crossover claim survives the corrected odd-$n$ $\Theta_n$**, which the block asserts with $\Theta_{11}=1.21716<\sqrt{3/2}<1.24838=\Theta_{13}$.

**And the standing question for this shape**: what a consumer may cite when the canonical entry states nothing.

## Clustering, all three in, all `PROVEN, hypotheses corrected`, unanimous

**`PROVEN, hypotheses corrected`.** *All four ingredients rebuilt cold and landing on the record's formula.* $a=\tfrac1{3\sqrt6}$ and $\delta^2(u)=6a^2=\tfrac19$ exactly at every $n$; the smooth branch by Daleckii–Krein, every rotation term pairing to zero; the kink branch by first-order degenerate perturbation, **with $\mathrm{Alt}(u_-)$ zero on the padded part, which is why padding is harmless**; and the chain closing at $F\ge\tfrac23\operatorname{tr}(B_+)+\tfrac13\operatorname{tr}(B_-)\ge0$. **Both structural facts do exactly the work claimed.**

### The falsifier, and what the Bianchi identity is buying

**$H=-\star$ is symmetric and tangent, with $F=-2<0$ and $d^+\delta^2>0$.** It is excluded by exactly one thing: $\mathrm{Alt}(-\star)\ne0$, **so it is not a Weyl tensor.** *The first Bianchi identity is the entire separation between this lemma and an explicit counterexample, and it is used at full strength.*

| id | finding | support |
|---|---|---|
| **P1** | **nothing is citable.** [results.md](../results.md)'s L17 is a heading over a bare pointer; the verifier's §1 supplies the statement with its quantifiers | v185 |
| **P2** | **the refuted equality set is still on the page**, the closing prose asserts the three families **three lines below the block's own blockquote refuting them.** *A repair, not a re-audit* | v185 |
| **P3** | **three consumed hypotheses unstated**: $u$ critical, $\Lambda^-\subseteq\ker u$, and differentiability of $\delta^2$. All true, none written where the lemma is stated | v185 |
| **P4** (**AND IT FALSIFIES THE LEMMA AS TABLED** | **$\kappa_n$ carries two live meanings**), the Killing constant $\tfrac{(2n-1)(n-1)}4=63.25$ and L17's $-0.1016$ at $n=12$, *same name, opposite sign, a factor of $600$, both inside [second-order.md](../findings/second-order.md)*. **Under [conventions.md](../findings/conventions.md)'s TABLED $\kappa_n$ the conclusion "$\kappa_n\le0$" is false at every $n$, and L17's $\kappa_n$ is tabled nowhere**, so a reader consulting the convention table to resolve the symbol is handed a false lemma. *Four more collisions beside it: $u$, $\Phi$, $F$ in four senses, and a third $B$* | v185, v187 |
| **P6** | **the $89\%$ reading is wrong even though the arithmetic is right.** $1451/1637=88.64\%$ is a ratio of **dimensions**; $\{F=0\}$ is a proper subspace and therefore a **measure-zero** set of directions. *"About $89\%$ of directions" and "most of the tangent space" are both false as read* | v187 |
| **P7** | **$\lVert H\rVert=1$ is inert** (a stated hypothesis no step uses) while **$Q(u)=\theta u$, which the headline conclusion needs, is stated in neither block nor notebook**, *without it the derivative is $3\langle Q(u),H\rangle+2a\kappa_nF$ rather than $2a\kappa_nF$*, and **every consumer of "first-order protection" imports it silently** | v185, v187 |
| **P8** | **the equality-set inclusion is witness-free**: the audit says $\{F=0\}$ contains every mixed $E$–$K$ direction, and **no Weyl tensor with a nonzero $E$–$K$ block is exhibited anywhere on the record** | v187 |
| **P9** | the $18\times$ second-order margin on the padded flat **is $n=12$'s alone and is not so labelled**, *on the crude bound it falls to $1.08$ as $n\to\infty$, though the exact identity with $\delta^2\le\tfrac14$ holds it above $7.7\times$ uniformly.* The structural half, $T(u,H,H)=0$ and $-\tfrac32\theta$, re-derives in closed form and is dimension-free | v187 |
| **P10** | the two odd values alone **do not establish "$n\ge12$"**: even $n$ and monotonicity are needed and are stated nowhere | v187 |
| **P11** | **Daleckii–Krein is cited loosely**, $x_-\notin C^1$ at $0\in\operatorname{spec}(u)$, so *the split into branches is right and the label on half of it is not* | v187 |
| **P12** | **where the calculus lives is unstated**: the compression runs in $\mathrm{Sym}(\Lambda^2\mathbb R^n)$ and not in $\mathcal W_n$, **Bianchi being consumed on $H$ before any operator surgery**, *which is also why the unital trap cannot bite* | v187 |
| **P5** | [ATTEMPTS.md](../ATTEMPTS.md)'s auxiliary *"$F$ is convex and $1$-homogeneous, so directed subgradient descent certifies the sign globally"* **does not follow**, $x_-$ is convex but not *operator* convex. **Non-load-bearing**, the equality set being characterised outright | v185 |

**Cleared.** The codimension count is exactly $6+180=186$, so $1451$ of $1637$, $88.6\%$. $\Theta_{11}^2=\tfrac{40}{27}$ and $\Theta_{13}^2=\tfrac{120}{77}$, and **the crossover holds at $n\ge12$ under either pinning**, from $n^2-12n+8>0$ at even $n$ and $n^2-13n+18>0$ at odd, *so L17 survives L16's repair while L134's thresholds genuinely move.* **On the Jensen step the two verifiers are complementary rather than opposed**: one retires the Hansen–Pedersen citation, the compression following in four lines from $0\le Z\le\Pi$ and $C_-\succeq0$; the other confirms the citation and notes **the TRACE form is essential**, since $x_-$ is not operator convex and the operator Jensen inequality would fail. *The citation is correct and unnecessary.* **Either way the unitality trap never arises.** **The block's admitted debt is not L17's**, it attaches to local maximality, which L17 never asserts.

## Adjudication

**Verdict `PROVEN, hypotheses corrected`, repaired. Impact `NARROWS`.** Three verifiers, one verdict, **and each re-derived all four ingredients from the definitions rather than reading them.** The formula, the constant pinned twice independently, the Jensen reduction, both inclusions of the equality set, the codimension and the crossover all confirm. **The mathematics is right and the record carrying it was not citable.**

### Nothing on the record stated this lemma

The canonical entry was a heading over a bare pointer; the block was prose under blockquotes; **the argument lived in [ATTEMPTS.md](../ATTEMPTS.md)'s Result 6, which is the lab notebook.** *Its own audit diagnosed the circular pointer on 2026-09-04, called it the third such heading that day, and repaired none of the three.* **The statement and the proof are now in the block, and the canonical entry carries the statement.**

### What the Bianchi identity is buying

**$H=-\star$ is symmetric and tangent, with $F=-2<0$ and $d^+\delta^2>0$, and is excluded by one thing only: $\mathrm{Alt}(-\star)\ne0$, so it is not a Weyl tensor.** *Bianchi is the entire separation between this lemma and an explicit counterexample, and it is used at full strength.*

### The symbol collision was worse than a collision

**Under [conventions.md](../findings/conventions.md)'s tabled $\kappa_n$ (the Killing constant, positive at every $n$), the conclusion "$\kappa_n\le0$" is false everywhere**, and L17's penalty $\kappa_n$ was tabled nowhere. *Same letter, same subscript, opposite sign, a factor of six hundred, both live in one file.* **Now tabled, with the failure spelled out.**

### The repairs, all applied

| finding | what changed |
|---|---|
| P1 | the canonical entry states the lemma, with its hypotheses and the measure-zero caveat |
| P2 | the refuted three-families prose is **gone**, replaced by the equality set with both inclusions and the note that no mixed $E$–$K$ witness exists anywhere |
| P3, P7 | criticality stated, with what the derivative reads without it; tangency stated, with $H=u$ as the witness; **$\lVert H\rVert=1$ recorded as inert** |
| P4 | $\kappa_n$ tabled in [conventions.md](../findings/conventions.md) against the Killing constant, with the false reading named |
| P6 | the size stated as a dimension ratio and the set as measure zero, in both files |
| P11, P12 | Daleckii–Krein's failure at $x_-$ recorded, the four-line compression given in place of the citation, and the calculus located in $\mathrm{Sym}(\Lambda^2\mathbb R^n)$, *which is why no unital hypothesis can bite* |
| P9, P10 | the $18\times$ margin labelled $n=12$'s with its asymptotics, and **both it and the numerical debt recorded as superseded by [L134](../findings/second-order.md) and [L140](../findings/second-order.md) in that same file**; the crossover cites [L2](../findings/problem.md)'s two polynomials rather than two odd values |
| P5 | [ATTEMPTS.md](../ATTEMPTS.md)'s convexity claim recorded as void and non-load-bearing |
| new | the kink exhibited: at padded $\overline{\mathbb{CP}^2}$, $\delta^2(u+tH_0)=(1-\lvert t\rvert)^2/9$ exactly, both one-sided slopes $-\tfrac29$ |

### Escalated

**The record contradicts itself on which object $u$ is**, [problem.md](../findings/problem.md) distinguishes padded $W_{\mathbb{CP}^2}$ from Fox's $\mathcal S^4(\alpha)$ while [second-order.md](../findings/second-order.md) equates them. *L17's proof commits to the padded reading; nothing else has the spectrum it runs on.* **That is a question about two other blocks and is queued.**
