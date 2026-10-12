# Review r1079: Gate 2 on I111's $-$ branch, the MAXIMUM of two bounds

**Reviewer r1079**, cold brief, on [2026-09-22-I111-minus-branch.md](2026-09-22-I111-minus-branch.md) and the staged [I111MinusBranch.lean](../lean/HamiltonsCubic/Results/I111MinusBranch.lean). Log: [agent_logs/r1079-minus.log](../agent_logs/r1079-minus.log). *Analysis-only footing. Every figure below is an identity checked at forty digits or a bounded evaluation on objects already in hand, minutes of arithmetic in total. No sweep, census or unbounded hunt was opened.*

| claim | what it says | verdict |
|---|---|---|
| B1 | the max of the two bounds beats the deficit everywhere, min ratio $1.014293$ | **CONFIRMED**, with the displayed constant $1.0143$ corrected to $1.0142$ |
| B2 | both inputs on the record, each insufficient, only the max is new | **REFUTED** on novelty, corroborating [r1078](REVIEW_r1078.md) independently. Both shortfall figures CONFIRMED |
| B3 | the surviving region | **PLAUSIBLE**, one constraint of the record's own is missing and one is redundant |
| B4 | Gate 1 calibration at the corner | **CONFIRMED**, to forty digits against a closed form |
| B5 | the Lean file types the structure only | **CONFIRMED as a scoping statement**, and the file carries a FALSE sentence the note has already withdrawn |

---

## B1: the maximum is legitimate, and the number reproduces. The printed CONSTANT does not

**The minimum reproduces independently at every digit.** Built from the quoted definitions alone, coarse grid then Nelder–Mead from $34\times16\times4$ starts:

$$\min\frac{\max(g_{\mathrm{Gram}},g_{\mathrm{dir}})\cdot u(t-u^2)}{-F(s,f,u)}=1.01429278\quad\text{at}\quad s=0.455838,\ f=0.992111,\ u=0.446191,$$

with both bounds equal to $0.161630$ there, $K=1.108179$, $\beta=0.8277^\circ$, $2\arccos f=14.4031^\circ$. *A coarse pass over $s\in[0.30,s_*]$, wider than the claimed window, finds no second basin.*

**THE DISPLAYED THEOREM IS FALSE AS PRINTED, BY $7.2\times10^{-6}$.** *The note and the brief both state $\text{gain}\ge1.0143\cdot(-F)$, and $1.0143$ is $1.014293$ rounded UP, so the inequality fails at its own minimiser: $1.0142928<1.0143$.* **The constant must be rounded down, to $1.0142$ or $1.014$.** *A rounding that goes the wrong way across the inequality it decorates is exactly the defect this margin cannot absorb, the whole claim being $1.4\%$.*

### The max IS legitimate, and here is why, argued from the definitions

**Both are lower bounds on ONE scalar, $\max_a g(\psi_a)$, so their maximum bounds it too.** *The chain is PER BLOCK: the note's parent carries $\kappa_i\le\tfrac{u_i}{\sqrt3}(t-u_i^2)$ for each block separately, and on the equal-$N_i$, equal-$u$ ansatz all three blocks carry the SAME deficit $-F$. One block's gain clearing it is already a contradiction, so the quantity the deficit is measured against is $\max_a$ and not $\min_a$ or an average.* **That is the point at which a max-of-two argument would have collapsed, and it holds.**

**[r1069](REVIEW_r1069.md)'s bound holds for EVERY $a$.** Its input $h_a=\sqrt{g/N}\ge f$ is *exactly* the band's lower edge, not an extra assumption: with $g=\theta^2+3u^2-2\sqrt3\theta u_{\mathrm{lo}}(f)=3u^2-\theta^2+2\theta fs$,

$$g\ge f^2N\iff 3u^2\ge(\theta-fs)^2\iff u\ge u_{\mathrm{lo}}(f),$$

an identity. *So the bound is valid at every $f<1$ on the region and is conditional on nothing the Gram regime violates.* **One step in it is tight rather than comfortable and should be recorded**: concluding $\lvert\sin\eta_b\rvert\ge h_a$ from $\max(\lvert\sin\eta_b\rvert,\lvert\cos\eta_b\rvert/\sqrt3)\ge h_a$ needs $h_a>\tfrac1{\sqrt3}=0.577350$, and the region's infimum of $f$ is $f_{\mathrm{Gram}}(s_{\mathrm{lo}})=0.594604$. *It clears by $3\%$ and by nothing more.*

**[r1070](REVIEW_r1070.md)'s "minimises at $c_1=c_2=c_3$" is a THEOREM, not an ansatz, and it is one line.** Writing $\Phi(c)=\tfrac2{15}(\sum c_a)^2-\tfrac12\lVert c_\perp\rVert^2$, which is the quoted form rearranged, $\Phi$ over any box $[c_-,c_+]^3\subset[-1,0]^3$ is maximised at $c_a=c_-$ throughout, value $\tfrac65c_-^2$. *Since $g$ is monotone in $\lvert c\rvert$ on the $-$ branch, the sublevel set $\{g\le G\}$ is an interval and the binding corner is the all-equal one.* **So $\tfrac65c_-^2\ge K$ and the bound $\tfrac1{\sqrt3}(1-\cos\alpha)$ at $\tfrac65\cos^2(\tfrac{2\pi}3+\alpha)=K$ follow, with $K\le\tfrac65$ supplied by the Gram cap.**

**And the branch dichotomy is FORCED by $\Phi\ge K$ rather than assumed.** $\Phi\ge K$ gives $\lvert\sum_ac_a\rvert\ge\sqrt{15K/2}\ge2.02$ at the region's $K\ge0.5441$, so every $c_a$ lies within $0.02$ of the same sign and mixed triples cannot occur. *At the minimiser's $K=1.108$ it is sharper still, every $c_a\le-0.88$.* **So "the $-$ branch" is a clean partition and the claim's standing dependency is the $+$ branch closure** ([r1076](REVIEW_r1076.md), [r1077](REVIEW_r1077.md)), *which the note names.*

### THE MARGIN IS UNDERSTATED, and the correction is the record's own equality

**$g_{\mathrm{dir}}$ uses $\arccos f$ where the record's equality gives $\arccos\sqrt{g/N}$, which is strictly tighter for every $u>u_{\mathrm{lo}}$.** *$h_a=\sqrt{g/N}$ is an EQUALITY in [r1069](REVIEW_r1069.md)'s derivation and $f$ is merely its value at the band's left endpoint.* Substituting the exact $h_a$:

$$\min\frac{\text{gain}}{\text{deficit}}=1.0215510\quad\text{at}\quad s=0.456404,\ f=0.991393,\ u=0.445906.$$

**So the true margin on the stated inputs is $2.16\%$ and not $1.43\%$**, and the closure has half again as much room as it claims. *Recorded as a strengthening available for free, not as a defect.*

## B2: REFUTED on novelty, CONFIRMED on the two shortfall figures

**Both inputs are inside ONE review, and the withdrawal is already on the note** ([r1078](REVIEW_r1078.md), note line 29). *Corroborated here independently and by a different route than r1078 states it:* [r1069](REVIEW_r1069.md)'s own line reads $\sum_a\cos^2\psi_a\ge\tfrac{5(3u^2-t)}{2u^2}=\tfrac52K$, and $\sum_am_a^2\le3M^2$ with $M=\max_a\lvert c_a\rvert$ gives $M\ge\sqrt{5K/6}$, which is [r1070](REVIEW_r1070.md)'s minimiser $\lvert c\rvert=\sqrt{5K/6}$ *exactly*. **So r1070's Gram bound is two lines of Cauchy–Schwarz from a display r1069 already carries, in the section r1069 titles "A SECOND constraint M4 does not look for, and it is this file's own".**

**The sentence "r1069 named the Gram bound as absent from its own round and left it to a successor" is FALSE.** *r1069's "What a successor should take" names two items, the $\mathcal D_n$ shadow against $\Theta_{12}$ and the three direction equations, and neither is the Gram bound. r1069 DERIVED the Gram confinement and sampled it at three points.* **This is the fifth novelty claim on this item to collapse, and it collapsed the same way as the trade-off identity: the check asked whether the later reader held the earlier one's object, and never the reverse.**

**Both shortfall figures reproduce, so the arithmetic half of B2 stands.**

| bound alone | min ratio, r1079 | at | note / brief |
|---|---|---|---|
| Gram only | $0.737704$ | $s=0.41579$, $f=1$, $u=0.467051$ | $0.7377$ at $0.41591$, "short by $26\%$" |
| direction only | $0.201727$ | $s=0.44572$, $f=0.913572$, $u=0.473753$ | $0.2021$ at $0.44586$, "short by $80\%$" |

## B3: the region is missing a constraint the record derives, and carries a redundant one

**MISSING: the product band's TOP.** The parent file derives $g\le N$ as the vector bound and reads it as the band

$$u_{\mathrm{lo}}(f)^2\ \le\ u^2\ \le\ u_{\mathrm{lo}}(f)^2+\tfrac{s^2(1-f^2)}3,$$

and [r1070](REVIEW_r1070.md)'s M3 correction imposes it explicitly as one of three caps. **B3 lists only the band's floor.** *The omission is conservative, since a larger region can only lower a minimum, and it does not bite: imposing the band top leaves the minimum at $1.01429278$ at the same point, the top being $0.447223$ against $u=0.446191$ there.* **But B3 as a statement of the surviving region is incomplete, and a reader checking the closure against the record will find a cap the closure never mentions.**

**REDUNDANT: $f\ge f_{\mathrm{Gram}}(s)$.** *It is exactly $u_{\mathrm{lo}}(f)\le\sqrt{5t/9}$, so it is implied by $u\ge u_{\mathrm{lo}}(f)$ together with $u^2\le5t/9$.* **Harmless, and worth saying so, because the note's own "a first refinement returned $0$ and was WRONG" blames dropping this floor.** *What that refinement actually dropped was the pair that implies it.*

**CORRECT per block only under equal $u_a$, as the brief suspected.** The underlying statement is $\sum_au_a^2\le\tfrac53t$, and $u^2\le\tfrac59t$ is that at $u_1=u_2=u_3$. *On the ansatz it is right. Off it, it is not the constraint, which is one more reason the scope paragraph is load-bearing.*

**The window's two endpoints are CORRECT, both as closed forms and as limits.** $s_{\mathrm{lo}}=(\sqrt6-\sqrt3)/2=0.3587194676071504$ and $s_*=(\sqrt6+\sqrt{10})/12=0.4676472835792965$ reproduce [r1069](REVIEW_r1069.md)'s bisected values to twelve digits, and at $s_*$ the identity $u_{\mathrm{lo}}(1)=\sqrt{5t/9}$ holds to forty digits. *Checked separately that $\{F<0\}$ is EMPTY below $s_{\mathrm{lo}}$ at seven values down to $s=0.30$, so nothing survives outside the window and the minimisation is not missing a region.*

## B4: CONFIRMED, exactly

**$F$ is the record's, and the check is stronger than a four-digit match.** At $s_*$, $f=1$, $u=u_{\mathrm{lo}}$, at forty digits:

| quantity | r1079 | record |
|---|---|---|
| $-F$ | $0.01487303427066135606433823693$ | $\tfrac{11\sqrt{10}}{486}-\tfrac{5\sqrt6}{216}$, agreeing to $5.7\times10^{-42}$ |
| $u(t-u^2)/(2\sqrt3)$ | $0.019287372552145211$ | $0.0192874$ |
| ratio | $1.2968014596854394$ | $1.2968015$ ([r1068](REVIEW_r1068.md)) |

**So $F$ is not a reconstruction: it agrees with an independently derived CLOSED FORM for the corner deficit, not merely with a printed decimal.** *The gain multiplier likewise, $\lVert q\rVert\lVert r\rVert^2=u(t-u^2)$ with the forced shape's $\max(x,y,z)=\tfrac1{2\sqrt3}$.*

## B5: the scoping is honest, and the file states something the note has withdrawn

**The scoping claim is CONFIRMED.** The module docstring says in terms that the minimax is not typed and names what would be needed, the three theorems are the monotonicity facts and `max_le`, and nothing numeric is asserted. *The file compiles, its `.olean` postdating its source, and it contains no `sorry` and no `native_decide`.* **`gainFactor_antitoneOn` is the right monotonicity**, $\delta\mapsto(1-\cos(\tfrac\pi3-\delta))/\sqrt3$ falling on $[0,\tfrac\pi3]$, which is what licenses evaluating either bound at its largest admissible displacement.

**AND THE FILE CARRIES A FALSE SENTENCE, IN TWO PLACES, WHICH THE NOTE HAS ALREADY CORRECTED.** *Lines 24 to 25 assert the combination is "the ONLY new logical step" and is typed "because the round's whole claim is that nobody had taken it". Lines 69 to 71 repeat it and add the specific falsehood, that r1069 "named the Gram bound as absent from its own round and left it to a successor".* **The note was corrected at 23:40 and the Lean file has not been touched since 23:28, so the withdrawn claim now stands in the Lean layer alone.**

**The repair, which is this session's and not a handoff.** Rewrite both docstrings to say what is true: the combination is typed because it is the step the closure turns on, and both input bounds are [r1069](REVIEW_r1069.md)'s, its Gram confinement being two lines of Cauchy–Schwarz from the bound [r1070](REVIEW_r1070.md) later took. *Leaving it is how a false statement survives in the layer for hours, which this programme has already paid for once.*

## What this review reaches, and what it does not

**Reaches.** That the maximum is a legitimate bound on one scalar and that both inputs hold simultaneously with no conflicting regime, argued from the definitions. That the minimum is $1.01429278$ at the stated point, independently. That the printed constant $1.0143$ is above it. That the novelty claim is false by a second route. That the region omits the band top and that the omission is conservative. That $F$ matches a closed form to forty digits.

**Does NOT reach.** The derivation of $F$ itself from the $\mathcal D_n$ and block equations, which is taken from the record on the strength of the closed-form corner match and of [r1069](REVIEW_r1069.md) and [r1070](REVIEW_r1070.md) reproducing the same $F$ independently. The Gram identity $\sum_au_a^2\le t-\tfrac32\sum_ax_a^2+\tfrac9{10}(\sum_ax_a)^2$, which is [r1059](REVIEW_r1059.md)'s and is assumed here as it is in r1070. Anything off the equal-$N_i$, equal-$u$ ansatz, which the note scopes correctly and which the omission of the band top does not affect.

**Not opened.** Rebuilding the bilinear formula's coordinate convention, which the parent file flags as UNSETTLED and which killed [r1075](REVIEW_r1075.md). *Nothing above depends on it: every quantity used here is a norm, an angle between vectors in one plane, or a scalar the record calibrates at the corner.*
