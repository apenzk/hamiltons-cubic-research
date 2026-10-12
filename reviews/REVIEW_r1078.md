# REVIEW_r1078: Gate 2 on I111's $-$ branch, the max-of-two-bounds closure

**Target.** Commit `bdcf5506` "feat(i111): the $-$ branch closes on the MAXIMUM of two bounds the record already held", working note [2026-09-22-I111-minus-branch.md](2026-09-22-I111-minus-branch.md), Lean file [I111MinusBranch.lean](../lean/HamiltonsCubic/Results/I111MinusBranch.lean).

**Log.** [agent_logs/r1078-minus.log](../agent_logs/r1078-minus.log)

**Footing.** Analysis-only. Everything numerical below is seconds of arithmetic on objects the record already carries, rebuilt from the quoted definitions rather than from the author's code, and reported as a screen.

| Claim | Verdict |
| --- | --- |
| B1 gain $\ge1.0143\cdot$ deficit everywhere, min $1.014293$ at $(0.455838,0.992111,0.446191)$ | **CONFIRMED**, reproduced independently to eight digits, with the load-bearing reading named |
| B2 both inputs on record, each insufficient, only the max is new | **PLAUSIBLE**, both shortfalls reproduce, but "neither reader took the other's" is **wrong**: [r1069](REVIEW_r1069.md) held both |
| B3 the surviving region | **REFUTED as stated**, two constraints missing, one of them load-bearing |
| B4 Gate 1 calibration at the corner | **CONFIRMED** to every digit quoted |
| B5 the Lean file types the structure only | **CONFIRMED on scope, REFUTED on its stated justification** |

---

## B1: CONFIRMED, and the reading it rests on is the max over BLOCKS

**Reproduced from the quoted definitions alone.** Nelder–Mead from $600$ random feasible starts returns $\min=1.01429278$ at $s=0.455838$, $f=0.992111$, $u=0.446191$, the claim's point to six places. The two bounds there are $g_{\mathrm{Gram}}=g_{\mathrm{dir}}=0.161630$, apart by $3.86\cdot10^{-6}$, which is the commit's own $3.9\cdot10^{-6}$. *A deterministic $1200\times200\times200$ sweep of the window returns $1.014880$ in the same basin and nothing lower anywhere, so there is no second basin.* **The individual columns reproduce too**: Gram-only bottoms at $0.737705$ at $s=0.415725$ and direction-only at $0.201853$ at $s=0.445862$.

**The max of two lower bounds is a lower bound, and both are unconditionally valid here.** Three things had to hold and all three do.

- **[r1069](REVIEW_r1069.md)'s premise $h_a\ge f$ holds on the whole region, not just at the pinning-tight locus.** With $g=\theta^2+3u^2-2\sqrt3\,\theta\,u_{\mathrm{lo}}(f)$ and $u_{\mathrm{lo}}=(\theta-fs)/\sqrt3$, the identity $g=\theta^2+(\theta-fs)^2-2\theta(\theta-fs)=f^2s^2$ is exact at $u=u_{\mathrm{lo}}$, and $g$ grows in $u$ thereafter. So $h_a=\sqrt{g/N}\ge f$ everywhere, with equality only at $u=u_{\mathrm{lo}}$, and $f\ge0.8917>1/\sqrt3$ keeps the $\lvert\sin\eta_b\rvert$ branch of $\max_{\nu_c}h$ selected.
- **[r1070](REVIEW_r1070.md)'s equal-$c$ minimiser is right off Gram saturation, by a one-line box argument.** Writing $m_a=-c_a\in[0,1]$ on the $-$ branch, $\Phi=\tfrac3{10}(\sum m)^2-\tfrac12\sum m^2$ is maximised at fixed $\sum m$ by equal coordinates, so $\max_{[0,M]^3}\Phi=1.2M^2$ and $\Phi\ge K$ forces $\max_am_a\ge\sqrt{5K/6}$. *No saturation is used, and the bound lands on the largest $m_a$, which is the one the gain needs.*
- **The two half-rate maps that looked contradictory agree.** [r1069](REVIEW_r1069.md) writes $\gamma_a=-\psi_a/2$ and [r1070](REVIEW_r1070.md) writes $\gamma=\tfrac\pi2+\tfrac\psi2$. The frames are the same two vectors in opposite order, which reverses orientation, and $-\big((\tfrac\pi2+\tfrac\psi2)-\tfrac\pi2\big)=-\tfrac\psi2$. *Both return $\psi=\pi\mapsto\pm(0,1,-1)$ and $\psi=0\mapsto(2,-1,-1)$.*

**THE ONE READING THE CLOSURE DEPENDS ON, AND IT IS NOWHERE STATED IN THE CLAIM.** *The gain is $\max_a g(\psi_a)$, the BEST of the three blocks.* **Under the worst-block reading the closure fails: $\min=0.70665$ at $s=0.443553$, $f=0.966537$, $u=0.460320$**, using [r1070](REVIEW_r1070.md)'s own coordinatewise corollary $\min_ac_a\ge3-\sqrt{10-5K}$ in place of its equal-$c$ optimum. *So the whole $1.43\%$ rests on which quantifier sits over the block index.* **The reading is CORRECT, and the warrant is [L220](../findings/second-order.md) step 6 read through [L221](../findings/second-order.md)**: the scalar chain $P(q_i)+\kappa_i+\tfrac\theta2\lVert\nu_i\rVert^2=\tfrac{\theta^3}3$ is per block, step 8's loss $\kappa_i\le\max(x_i,y_i,z_i)\lVert q_i\rVert\lVert r_i\rVert^2$ is that block's own, and a contradiction at any ONE block excludes the configuration. *On the equal-$N_i$, equal-$u$ ansatz every block carries the same deficit, so the available gain is the largest of the three.* **This belongs in the theorem's statement, because a reader who assumes the minimum over blocks gets $0.707$ and concludes the item is open.**

**Two robustness checks, both in the safe direction.** Replacing $\arccos f$ by the sharper $\arccos\sqrt{g/N}$ that the same chain licenses at $u>u_{\mathrm{lo}}$ raises the minimum to $1.02155$. Imposing the product bound $h\le1$ that B3 omits (below) leaves it at $1.01429278$ exactly, the minimiser having $h=0.99332$.

## B2: the shortfalls are right, the attribution is not

**Both figures reproduce**, $0.7377$ at $s=0.41573$ and $0.2019$ at $s=0.44586$, matching the claim's $26\%$ near $s\approx0.416$ and $80\%$ near $s\approx0.446$.

**But "neither reader took the other's" is false, and the novelty is thinner than the claim prices it.** [r1069](REVIEW_r1069.md) line 45 already carries its own Gram shape constraint, $\sum_a\cos^2\psi_a\ge\dfrac{5(3u^2-t)}{2u^2}$, under the heading "A SECOND constraint M4 does not look for, and it is this file's own". *That is $\sum_am_a^2\ge\tfrac52K$, the Cauchy–Schwarz weakening of [r1070](REVIEW_r1070.md)'s $\Phi(c)\ge K$.* **For the functional the closure actually uses it is not weaker at all**: $\sum m_a^2\le3M^2$ gives $M\ge\sqrt{5K/6}$, the SAME bound on $\max_am_a$ that [r1070](REVIEW_r1070.md)'s equal-$c$ optimum gives, and equality at equal $c$ is exactly where [r1070](REVIEW_r1070.md)'s optimum sits. *So both ingredients of the maximum sat in one review, at its lines 31 and 45, and what [r1069](REVIEW_r1069.md) did not do was convert its line-45 constraint into a gain factor.* **The accurate statement is "one reviewer held both constraints and converted only one of them", rather than "two reviewers each held one".**

*The substantive half of B2 survives: each input is on the record, each is individually short, and no prior commit takes the maximum. The string "their MAXIMUM does" enters the record in `bdcf5506` itself, checked with `git log -S`.*

## B3: REFUTED as stated, two constraints missing

**The region as written is $\{f\ge f_{\mathrm{Gram}}(s),\,u\ge u_{\mathrm{lo}}(f),\,u^2\le5t/9,\,F<0\}$. It does not support B1.**

- **$f\le1$ is absent, and it is load-bearing.** Minimising over the region exactly as B3 writes it returns $0.18280$ at $s=s_*$, $f=1.5$, $u=0.386935$. *The cap is real and the record states it*: $f$ is the product-bound fraction, $\lVert2\nu_b\circ\nu_c\rVert^2=f^2N^2$ against $N_bN_c=N^2$, and the I104 note's own range is $f\in[0.891690,1)$. **It is also what defines B3's own right endpoint**, $s_*$ being the root of $f_{\mathrm{Gram}}(s)=1$. *So the omission is a slip in the statement rather than in the search, and the statement as printed is still false.*
- **The product bound at $u>u_{\mathrm{lo}}$ is absent, and it is strictly tighter than the Gram cap.** $h^2=\big(\theta^2+3u^2-2\sqrt3\,\theta\,u_{\mathrm{lo}}(f)\big)/s^2\le1$ is the same Cauchy–Schwarz that gives $f\le1$, now read at the working $u$. At $s=0.44$, $f=1$ the Gram cap $u\le0.482586$ admits $h=1.1949$, which no configuration attains. **At $f=1$ it collapses the $u$-interval to the single point $u=u_{\mathrm{lo}}$**, since $h=f=1$ already there and $h$ grows in $u$.
- **$f\ge f_{\mathrm{Gram}}(s)$ is redundant.** It is exactly $u_{\mathrm{lo}}(f)\le\sqrt{5t/9}$, so it follows from the other two.

**Neither omission changes the number.** The first because the search evidently capped $f$ at $1$ regardless. The second because a tighter region can only raise a minimum, and the minimiser is interior to it. *The finding is that B3 as printed is not the region B1 was minimised over, and a reader who takes B3 at its word and recomputes gets $0.18$.*

**On the brief's question whether $u^2\le5t/9$ is right per block:** it is the correct reading of $\Phi\le\tfrac65$ under the equal-$u_a$ ansatz that scopes the whole result, and it is a derived consequence rather than an added restriction, so it neither shrinks nor inflates anything. *Off equal $u_a$ the quantity $K=3-t/u^2$ has no definition, which is the scope limit the note already states.*

## B4: CONFIRMED to every digit

At $s_*=(\sqrt6+\sqrt{10})/12$, $f=1$, $u=u_{\mathrm{lo}}(1)$: $-F=0.0148730342707$ against the record's $0.0148730342706614$, gain $u(t-u^2)/(2\sqrt3)=0.0192873726$ against $0.0192874$, ratio $1.2968015$ against [r1067](REVIEW_r1067.md)'s corrected $1.29680145968544$. *Both closed-form endpoints check independently too*, $s_{\mathrm{lo}}=(\sqrt6-\sqrt3)/2=0.358719467607$ and $s_*=0.467647283579$, against [r1069](REVIEW_r1069.md)'s bisected roots at twelve digits, with $f_{\mathrm{Gram}}(s_*)=1$ to sixteen.

**And $F$ is corroborated off the author's word**: [r1069](REVIEW_r1069.md) line 72 states $F(u)=\theta u^2-\frac{u^3}{2\sqrt3}-\frac{u(t+N)}{\sqrt3}-\frac\theta2N+\tau$ independently, which is the quoted $F$ with $t+N=1-2s^2$ and $\tau=\tfrac12fs^3$. *The chain it comes from also checks: $u_{\mathrm{lo}}=(\theta N-2\tau)/(\sqrt3N)$ is [L220](../findings/second-order.md) step 6's $\langle L_{q_a}\nu_a,\nu_a\rangle=\tfrac\theta2N-\tau$ divided by $e=\tfrac{\sqrt3}2u$ at $\cos2\beta=1$, so the $f$ in $\tau$ and the $f$ in the product bound are the same $f$ by construction rather than by coincidence.*

## B5: the scope claim is right, the justification under it is wrong

**[I111MinusBranch.lean](../lean/HamiltonsCubic/Results/I111MinusBranch.lean) does type the structure only and does say so**, and it builds clean, `lake build HamiltonsCubic.Results.I111MinusBranch` completing with exit $0$ and no `sorry`. *Three monotonicity statements and `max_le`, with the minimax explicitly excluded.*

**Its stated reason for typing the monotonicity is false.** The file says the monotonicity is "what licenses checking the closure at the boundary of the region", with the displacement growing "as `f` falls and as `β` grows".

- **The displacement is NOT antitone in $f$ once the pinning identity is imposed.** `displacement_antitone_f` fixes $\beta$, but $\cos2\beta=u_{\mathrm{lo}}(f)/u$ makes $\beta$ a function of $f$, and $u_{\mathrm{lo}}(f)=(\theta-fs)/\sqrt3$ FALLS as $f$ rises, so $\beta$ RISES with $f$. The two effects run opposite and neither dominates.
- **So the minimum is interior in $f$ and no boundary check would find it.** At the minimiser's $s=0.455838$, $u=0.446191$ the admissible $f$ runs over $[0.991404,1]$, and $g_{\mathrm{dir}}$ along it reads $0.168844$ at $f=0.991404$, $0.161422$ at $f=0.992263$ and $0.239851$ at $f=1$. *The ratio is $1.0567$, $1.0149$ and $1.5511$ at those three points.* **Checking the two endpoints returns $1.0567$ and $1.5511$ and misses the minimum entirely.**
- **A smaller slip in the same docstring**: it credits Mathlib's `antitone_arccos` while the proof calls `Real.arccos_le_arccos`.

*The fix is to state what the lemmas are: a decomposition of the gain factor's dependence, useful for a future interval-arithmetic layer. They do not reduce the minimax to a boundary, and the file should stop saying they do.*

---

## What a repair owes

1. **State the block quantifier in the theorem.** The gain is $\max_a g(\psi_a)$, warranted by [L220](../findings/second-order.md) step 6 being per block. Without it the claim is ambiguous between $1.014$ and $0.707$.
2. **Add $f\le1$ and $h\le1$ to B3, and drop $f\ge f_{\mathrm{Gram}}$ as redundant.** The number is unaffected, the printed region is not.
3. **Rewrite the Lean file's middle paragraph.** The monotonicity does not license a boundary check, and the minimiser is interior in $f$.
4. **Correct B2's attribution.** [r1069](REVIEW_r1069.md) held both constraints, at its lines 31 and 45. The new step is converting its line-45 constraint into a gain bound and taking the maximum, which is a smaller step than "combining two reviewers".

*None of the four moves the theorem. B1's number survives every check this round put to it, including a tighter region, a sharper confinement and a dense sweep for a second basin.*
