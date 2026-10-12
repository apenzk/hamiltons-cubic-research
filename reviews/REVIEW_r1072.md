# Review r1072, the pinning/$\tau$ trade-off and posts F74, F75

**Scope.** The section "THE PINNING SUM AND $\tau$ TRADE OFF EXACTLY" of [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), plus posts F74 and F75 of [fence-posts.md](../findings/fence-posts.md), and [I111Tradeoff.lean](../lean/HamiltonsCubic/Results/I111Tradeoff.lean).

**Log.** `agent_logs/r1072-tradeoff.log`. **Screens only**, seconds of arithmetic on the closed forms the record already carries, per [analysis-only.md](../.claude/rules/analysis-only.md).

| claim | statement | verdict |
|---|---|---|
| C1 | $a=\sum_a g_a$ and $P(N)=6\tau$ | **CONFIRMED** |
| C2 | $\sum_a g_a+3\tau=\tfrac12\theta(1-t)$ | **CONFIRMED, and VACUOUS as new content** |
| C3 | $g_a=\tfrac12N(\theta-fs)$, and the ceiling test returns $u\ge u_{\mathrm{lo}}(f)$ exactly | **CONFIRMED**, two citation defects |
| C4 | $P(D)=\tfrac32\theta t-\tfrac12\theta+3\tau$ | **CONFIRMED** |
| C5 | F74's exclusion shares and the $n\le8$ / $n\ge9$ split | **REFUTED in part**, headline survives |
| C6 | F75's redundancy, and the collapse at $\psi_a\equiv0$ | redundancy **CONFIRMED** with a missing hypothesis; collapse **PLAUSIBLE** |
| C7 | invertibility margin $0.2132$ at the Gram cap | **REFUTED** |

## C1, the two collapses: CONFIRMED

**Both halves hold, and each needs exactly one hypothesis beyond total symmetry of $T$.**

- **Cross terms in $a$.** $T(D,\nu_a,\nu_b)=\langle D,\nu_a\circ\nu_b\rangle$, and $\circ$ is $\Gamma$-equivariant, so $\nu_a\circ\nu_b$ lies in the $\chi_{Q_a}\chi_{Q_b}$ component. The hypothesis is that this character is NONTRIVIAL, which holds because $Q_a\ne Q_b$ as sets. Membership of $V_{Q_c}$ is more than the argument needs: orthogonality to $\mathcal D_n$ follows from nontriviality alone, $\mathcal D_n$ being the trivial component by [L120](../findings/second-order.md).
- **Repeated indices in $P(N)$.** $\chi_{Q_a}^2=1$, so $\nu_a\circ\nu_a$ sits in the trivial component, which kills $T(\nu_a,\nu_a,\nu_b)$ for every $b$, $a$ included. [L220](../findings/second-order.md) step 2 computes the stronger $\nu\circ\nu\in\Pi_Q$ explicitly. The six distinct-index terms are each $\tau$ by full symmetry, so $P(N)=6\tau$.

**Neither half needs $\mathcal S$ to be a subalgebra**, only the character grading. The record's prose is right on both counts.

## C2, the trade-off line: CONFIRMED as algebra, VACUOUS as new content

**The identity holds**, by two independent routes that agree: substituting C1 into [second-order.md](../findings/second-order.md)'s $\theta(1-t)=2a+P(N)$, and summing the three block equations paired with their own $\nu_a$.

**BUT THE RECORD ALREADY CARRIES A STRICTLY STRONGER STATEMENT, AND HAS SINCE 2026-09-14.** [L221](../findings/second-order.md)(b) step 2 reads, verbatim, $\langle L_{q_i}\nu_i,\nu_i\rangle=\tfrac\theta2N_i-\tau$ in this exact three-block setting. **C2 is that identity summed over $i$**, so it carries no information the record lacked, and the per-block form implies it while it does not imply the per-block form. *The section's own framing locates the novelty in "what those quantities ARE once $N$ is split by character", but $g_i=\tfrac\theta2N_i-\tau$ IS what they are, and it is L221's, not this section's.* **The section's later sentence, that off the equal-$N_i$ diagonal the identity is weaker than three per-block pinning bounds, understates the case: it is weaker than three per-block pinning IDENTITIES the same lemma proves.**

*What survives as genuinely this section's is the reading of $a$ and $P(N)$ themselves, which is C1 and is used again in C4.*

## C3, the closed form and the no-new-exclusion conclusion: CONFIRMED, with two citation defects

**The arithmetic is right.** On the equal-$N_i$ diagonal $g_a=\tfrac\theta2s^2-\tfrac f2s^3=\tfrac12N(\theta-fs)$, and since $u_{\mathrm{lo}}(f)=(\theta-fs)/\sqrt3$ this is $\tfrac{\sqrt3}2Nu_{\mathrm{lo}}(f)$ identically. Testing against $g_a\le\tfrac{\sqrt3}2uN$ therefore returns $u\ge u_{\mathrm{lo}}(f)$, the pinning constraint, and no new exclusion. **Corner value reproduced: $g_a=0.0827863430597$ against [r1062](REVIEW_r1062.md)'s $0.08278634$.**

**The ceiling is a genuine bound, and the brief's doubt is unfounded** *for a reason worth stating*: $e=\tfrac{\sqrt3}2u$ is an identity, the top eigenvalue of $L_{q_a}$ on the two-dimensional traceless $V_{Q_a}$, and $g_a\le eN_a$ is the Rayleigh comparison against it, sharp exactly when $\nu_a$ is the top eigenvector. *So the ceiling is real and C3's conclusion stands.*

**Defect 1, the step numbers are wrong, in the section, in F75's neighbourhood and in the Lean docstring.** *[L220](../findings/second-order.md) step 7 is $P(q)\le\tfrac{\sqrt3}2\lVert q\rVert^3$ and step 8 is $\kappa\le\tfrac1{\sqrt3}\lVert q\rVert\lVert r\rVert^2$, and this file names them that way four sections earlier.* **The pinning ceiling $g_a\le\tfrac{\sqrt3}2u_aN_a$ is L221(b) step 2 resting on L220 step 5, and the ceiling on the cross term is the product bound $\lvert\tau\rvert\le\tfrac12\sqrt{N_1N_2N_3}$, which is no step of L220 at all.** *A reader following "step 7's ceiling" arrives at a different inequality.*

**Defect 2, "checked at four points of the window, agreeing to machine precision" screens a tautology.** *$g_a=\tfrac{\sqrt3}2Nu_{\mathrm{lo}}(f)$ is an algebraic identity in $(s,f)$, so the four points test the arithmetic of the evaluation and nothing else.* **Recording it as numerical agreement invites the reading that two independent quantities were found to coincide.**

## C4, $P(D)$ in closed form: CONFIRMED

$\theta t=P(D)+a$ with $a=\sum g_a=\tfrac\theta2(1-t)-3\tau$ gives $P(D)=\tfrac32\theta t-\tfrac12\theta+3\tau$. **Corner value reproduced: $P(D)=0.1728528442275$ against the recorded $+0.172853$.** *The "no reference to $D$'s shape" reading is correct and is the one thing in the section that the per-block identity of C2 does not already give in another form.*

## C5, post F74: REFUTED in part, and the correction runs in the record's FAVOUR

**The direction is right.** A point dies when the forced $P(D)/t^{3/2}$ exceeds $\Theta_n$; the ratio is increasing in $f$ (coefficient $\tfrac32s^3>0$), so what governs is the ratio at the LOWEST admissible $f$. **F74's warning against reading the maximum is sound as far as it goes.**

**THE FLOOR IS THE WRONG ONE.** *F74 minimises over $f\ge f_{\mathrm{Gram}}(s)=(\theta-\sqrt{5t/3})/s$ alone. The surviving set also requires $d(s,f)>0$, and this file's own $(s,f)$ table shows the deficit floor is the HIGHER of the two for every $s$ below $0.4405$:* at $s=0.35882$ Gram needs $f\ge0.5946$ while $d>0$ needs $f\ge0.9998$. **A configuration with $d\le0$ is one the chain already closes, so including it in the minimisation prices the route against points that do not exist.**

**Corrected table**, the excluded share of the window $(0.358719467607,\,0.467647283579]$ under $f\ge\max(f_{\mathrm{Gram}},f_{d>0})$:

| $n$ | $6$ | $7$ | $8$ | $9$ | $10$ | $11$ | $12$ |
|---|---|---|---|---|---|---|---|
| $\Theta_n$ | $1.054093$ | $1.095445$ | $1.145644$ | $1.171080$ | $1.200000$ | $1.217161$ | $1.236033$ |
| F74's share | $58.1\%$ | $41.4\%$ | $10.3\%$ | $0$ | $0$ | $0$ | $0$ |
| **corrected share** | $\mathbf{65.6\%}$ | $\mathbf{56.5\%}$ | $\mathbf{41.4\%}$ | $\mathbf{30.8\%}$ | $\mathbf{13.7\%}$ | $0$ | $0$ |

*Two routes agree to the digit: bisection on the crossing at 30 dps, and a $20000$-point grid count giving $65.60,\ 56.49,\ 41.41,\ 30.77,\ 13.68,\ 0$. F74's own row reproduces exactly under the Gram-floor rule, which is how the rule was identified.*

**So "NOTHING at $n\ge9$" is FALSE**: the route excludes nearly a third of the window at $n=9$ and a seventh at $n=10$.

**AND THE $0.13\%$ NEAR-MISS AT $n=11$ IS REAL.** *F74 calls it manufactured by reading the maximum. It is not.* **The window's lower endpoint is by definition the root of $d(s,1)=0$, so the admissible $f$ there pinches to $1$ and the minimum over $f$ COINCIDES with the maximum.** The supremum of the forced ratio over the window is $1.2155859$ under both rules, against $\Theta_{11}=1.2171612$, short by $0.1294\%$. *F74's own sentence, that the maximum sits where the deficit vanishes and there is nothing left to close, is true at the endpoint and false immediately inside it: one tenth of the way in, at $s=0.3696$, the correct floor still gives $1.2047$.*

**WHAT SURVIVES, AND IT IS THE HEADLINE.** *The route still excludes nothing at $n=11$, and $n\ge12$ is settled, so it cannot reach the open case.* **It also fails to close any $n$ outright**, $65.6\%$ being its best. *The "falls from $1.1572$ to $0.8570$, a factor of $1.35$" should read from $1.2156$ to $0.8570$, a factor of $1.42$.*

## C6, post F75: redundancy CONFIRMED with a hypothesis missing, collapse PLAUSIBLE

**The redundancy is real and the algebra is one line.** $\theta t=P(D)+a$ and $\theta(1-t)=2a+P(N)$ SUM to $\theta=P(D)+3a+P(N)$, and $\lVert W\rVert=1$ makes the left side $\theta\lVert W\rVert^2$. *So given $P(W)=\theta$ each follows from the other.*

**BUT THE POST NAMES TWO INPUTS AND NEEDS THREE.** *$P(W)=P(D)+3T(D,D,N)+3a+P(N)$, so the sum of the two shadows is $P(W)$ only because $T(D,D,N)=\langle D\circ D,N\rangle=0$.* **That is character orthogonality again, the same fact C1 rests on, and it is unstated.** *Without it the two shadows differ by $3T(D,D,N)$ and neither implies the other.* **The repair is half a clause and the conclusion is unaffected.**

**One wording defect.** *"The shadow that reads as an independent equation on top of the six is the sixth of them, resummed". It is the SUM OF THREE of them, the parallel component of each block equation, not a single one.*

**The collapse at $\psi_1=\psi_2=\psi_3=0$: PLAUSIBLE, and the invariance is asserted rather than shown.** *Equal shape angles fix the three $q_a$ up to each block's own signed basis. The three $\nu_a$ directions are separate unknowns on which $\psi_a\equiv0$ says nothing, and $\nu_b\circ\nu_c$ is not invariant under rotating the $\nu$'s independently.* **So "that configuration is invariant under the cyclic rotation of the blocks" needs the $\nu$-angles equal as well**, which is part of the symmetric ansatz rather than a consequence of $\psi_a\equiv0$. *The cyclic automorphism does exist, a $3$-cycle on the six indices carrying $Q_1\to Q_3\to Q_2\to Q_1$, and invariance of $D$ under it is a further condition on $D$ beyond its three shape angles.* **Stated as an ansatz the reduction is sound, and the post's conclusion, that counting equations cannot exclude the point, holds under either reading.**

## C7, the invertibility margin: REFUTED

**The recomputation reproduces the arithmetic and refuses the bound.** $\theta-\sqrt3u$ is decreasing in $u$, and $\theta-\sqrt3\sqrt{5t/9}=\theta-\sqrt{5t/3}$ is increasing in $s$, so its minimum over the window is at the lower edge: $0.2131775803$ at $s=0.358719$ with $\sqrt{5t/9}=0.5840286$. **Every figure in F75 checks out. The $u$-ceiling it uses does not.**

**Defect 1, the per-block cap needs a symmetry nobody has assumed.** *The Gram bound is $\sum_au_a^2\le\tfrac53t$, a JOINT constraint. Dividing by three to get $u\le\sqrt{5t/9}$ assumes $u_1=u_2=u_3$, which the equal-$N_i$ diagonal does not supply: equal $N_a$ and a common $\tau$ force $g_a$ equal, not $u_a$ equal.* **The honest per-block consequence is $u_a^2\le\tfrac53t-2u_{\mathrm{lo}}^2$**, using only $u_b,u_c\ge u_{\mathrm{lo}}$. *At $s=0.358719$ with $f=1$ that is $u_a\le0.7233729$, ABOVE the singular value $\theta/\sqrt3=0.7071068$ at which $\theta-2L_{q_a}$ has a kernel.* **So on the leftmost $8.59\%$ of the window, $s<0.3680810$, the Gram system alone does NOT establish invertibility**, and F75's "invertible throughout the surviving set, margin $0.2132$" is not supported by the constraint it cites.

**Defect 2, and it rescues the conclusion by restoring the number F75 discarded.** *The surviving set caps $u$ far tighter than Gram does, through the chain's own condition: survival needs $F(u_a)<0$ for every block, and $F$ is increasing on $[u_{\mathrm{lo}},\sqrt t\,]$ by this file's own two-discriminant argument, so $u_a<u_{F=0}(s,f)$.* **$F$ increases in $f$ and $u_{F=0}$ therefore decreases in $f$, so the supremum of $u$ over the whole surviving set sits at the deficit floor, where $u_{F=0}=u_{\mathrm{lo}}(f_{\mathrm{floor}})$, and that supremum is $\tfrac12$, approached as $s\to0.358719^+$.** Hence

$$\theta-\sqrt3\,u\;>\;\theta-\tfrac{\sqrt3}2\;=\;0.3587194676\qquad\text{throughout the surviving set.}$$

**SO $0.3587$ WAS THE RIGHT MARGIN AND $0.2132$ IS THE LOOSE ONE.** *F75 reads the coincidence correctly as an identity, $\theta-\sqrt3u_{\mathrm{lo}}(f)=fs$, equal to $s$ at $f=1$, and then draws the wrong conclusion from it.* **The endpoint value is not "the window's lower endpoint wearing the appearance of a margin": it is the infimum of the margin, and it equals the endpoint because the supremum of $u$ is attained at the same pinch where $f\to1$ and $d\to0$.** *A post written to stop a constant being quoted at the end of a range that flatters it replaced a sharp constant with one that is both looser and, on its own stated grounds, unproved.*

**The conclusion "both are positive, so the system is square either way" stands**, on Defect 2's route rather than on Gram.

## The Lean layer

**[I111Tradeoff.lean](../lean/HamiltonsCubic/Results/I111Tradeoff.lean) is honest about its scope and its four theorems are what they say.** *`a_eq_sum_g` and `P_N_eq_six_tau` are the abstract content of C1 over a totally symmetric trilinear form; `tradeoff` and `PD_closed_form` are `linarith` over four reals with the record's two relations as hypotheses, so they type the arithmetic of C2 and C4 and not the mathematics.*

**The hypotheses are the right ones and none is vacuous.** *`hDab` is $T(D,\nu_a,\nu_b)=0$, `haaa` is $T(\nu_a,\nu_a,\nu_a)=0$ and `haab` is $T(\nu_a,\nu_a,\nu_b)=0$, and each is what character orthogonality delivers in the four-set setting.* **The file does not establish that the setting satisfies them, and its own docstring says so.**

**One defect: the module docstring names "the three hypotheses `hDab`, `haab` and `hPnu`", and `hPnu` occurs nowhere in the file.** *The third hypothesis is `haaa`.*

**Typable and not typed**, in rising order of cost: C6's redundancy, which is linear algebra over four scalars and needs only $T(D,D,N)=0$ added as a hypothesis; C3's closed form and its equivalence to $u\ge u_{\mathrm{lo}}(f)$, arithmetic over the regime constants; C7's corrected margin, once the $u$-ceiling is stated as $u<u_{F=0}$.

## What a repair owes

- **F74's table and its rule**, replaced by the corrected shares above, with the floor stated as $f\ge\max(f_{\mathrm{Gram}},f_{d>0})$ and the $n=11$ near-miss recorded as real rather than manufactured.
- **F75's margin sentence**, restoring $0.3587$ with the $u_{F=0}$ ceiling as its ground, and dropping the claim that Gram alone gives invertibility.
- **F75's redundancy paragraph**, adding $\langle D\circ D,N\rangle=0$ to the two inputs it names, and "the sum of three of them" for "the sixth of them".
- **The trade-off section**, attributing the per-block identity to [L221](../findings/second-order.md)(b) step 2, correcting "step 7" and "step 8", and dropping the four-point numerical check of an identity.
