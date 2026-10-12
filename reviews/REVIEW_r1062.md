# Review r1062: I110's substitution, the norm half

Adversarial Gate 2 review of the last section of [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), heading "I110'S SUBSTITUTION, THE NORM HALF: THE CORNER SITS EXACTLY ON THE BOUNDARY OF REALISABILITY".

Log: [agent_logs/r1062-i110-substitution.log](../agent_logs/r1062-i110-substitution.log). Analysis only, every number below is seconds of arithmetic on the corner already in radicals.

## Verdicts

| claim | verdict | in one line |
|---|---|---|
| D1 the pinning is tight at the corner | CONFIRMED | true, and it is true by the construction of the lower end rather than discovered |
| D2 top eigenvector, $e_a=\tfrac{\sqrt3}2u_a$, $\beta=0$ | CONFIRMED, and stronger | $\tfrac{\sqrt3}2u_a$ is an identity for every $q_a\in\Pi_{Q_a}$, attained at every shape |
| D3 each $\nu_a$ determined up to sign by $D$ | CONFIRMED | a correct implication whose hypothesis Finding 1 shows is unrealisable |
| D4 $\theta-\sqrt3u_{\mathrm{lo}}=s$ exactly | CONFIRMED, near-vacuous | definitional unfolding of $u_{\mathrm{lo}}=(\theta-s)/\sqrt3$, true at every $s$ |
| D5 both norms are $N_a$ | PLAUSIBLE, framing corrected | one side is an equality and the other a ceiling, and their coincidence restates $\tau=\tfrac12\sqrt{N_1N_2N_3}$ |
| D6 corner forces G6 saturated plus the parallelism | CONFIRMED in substance | the parallelism is immediate from the block equation, and the saturation restates an input |
| D7 attainable, so the norm half says FEASIBLE | **REFUTED** | D2 and D6 together force $P(q_a)$ to its FLOOR, and the chain's own identity then fails by $0.130$ |
| D8 what remains is $D$-compatibility alone | **REFUTED as posed** | the $D$ is unique rather than free, and its remaining condition is now settled NO |

## Finding 1, the refutation of D7: D2 and D6 jointly put $P(q_a)$ at its minimum, and the criticality identity then breaks by nine times the deficit

**The note's two load-bearing conclusions are each correct and are incompatible with the equation they were derived from.**

**The lemma.** *Let $q\in\Pi_Q$ be nonzero and let $\nu\in V_Q$ be a top eigenvector of $L_q$ on the Bianchi plane which also has a vanishing signed coordinate. Then $q$'s pattern is the negative of the $S^2\times S^2$ shape and $P(q)=-\tfrac{\sqrt3}2\lVert q\rVert^3$, the MINIMUM of $P$ over the circle of shapes at that norm.*

**Proof.** Take the vanishing coordinate first, so $\nu\propto(0,1,-1)$ under $a+b+c=0$. By [L121](../findings/second-order.md) the matrix of $L_q$ in the pairing basis is $\tfrac12G$ with $A=2x$, $B=2y$, $C=2z$. Then $G(0,1,-1)^{\mathsf T}=(C-B,\;B-A,\;A-C)^{\mathsf T}$, so $(0,1,-1)$ is an eigenvector exactly when $B=C$, that is $y=z$, which with $x+y+z=0$ gives the pattern $y\,(-2,1,1)$. Its eigenvalue under $L_q$ is $\tfrac12(B-A)=3y$, so TOP requires $y>0$ and the pattern is $(-2,1,1)$ up to a positive scale. Then $P(q)=18xyz=-36y^3$ while $\lVert q\rVert^2=2(x^2+y^2+z^2)=12y^2$, so $\tfrac{\sqrt3}2\lVert q\rVert^3=36y^3$ and $P(q)=-\tfrac{\sqrt3}2\lVert q\rVert^3$. The other two choices of vanishing coordinate give $(1,-2,1)$ and $(1,1,-2)$ by the same two lines and the same value of $P$, so the conclusion does not depend on which slot the equality case picks. $\square$

**Both hypotheses are the note's own.** D2 makes $\nu_a$ the top eigenvector of $L_{q_a}$. D6 saturates the product bound, whose equality case [this file derives](2026-09-14-I104-tau-positive.md) as $a_1=a_2=0$ with $\lvert b\rvert=\lvert c\rvert$, and the coordinate that vanishes is unique for nonzero blocks: $2S_1S_2-A\ge a_1^2a_2^2+2a_1^2B_2+2a_2^2B_1$ with $B_i=b_i^2+c_i^2$, which vanishes only at $a_1=a_2=0$ once $\nu_1$ and $\nu_2$ are nonzero. So the corner has $P(q_a)=-\tfrac{\sqrt3}2u_a^3$ for all three blocks.

**What that does to the chain.** Pairing G1's $\mathcal D_n$ equation with $q_a$ is an identity, not an estimate:

$$\theta u_a^2\;=\;P(q_a)+\langle L_{q_a}r_a,r_a\rangle+\Big(\tfrac\theta2N_a-\tau\Big)+\sum_{b\ne a}\langle\nu_b\circ\nu_b,q_a\rangle .$$

The record's $F$, which is [chainF](../lean/HamiltonsCubic/Results/I110Deficit.lean#L68) verbatim, bounds the first term ABOVE by $+\tfrac{\sqrt3}2u_a^3$. Its $u^3$ coefficient $-1/(2\sqrt3)$ is exactly $-\tfrac{\sqrt3}2$ from that step plus $+\tfrac1{\sqrt3}$ from the coupling bound, and rebuilding $F$ from the four terms reproduces [deficit](../lean/HamiltonsCubic/Results/I110Deficit.lean#L77) at the corner to $10^{-16}$, so the reading is fixed. Substituting the forced value in place of the bound moves $F$ by $\sqrt3u^3$:

$$F(u_{\mathrm{lo}})=-0.0148730,\qquad F(u_{\mathrm{lo}})+\sqrt3\,u_{\mathrm{lo}}^3=+0.1297823 .$$

A positive value of the corrected $F$ is a contradiction, so no critical point sits at the corner.

**The other two terms give nothing back, which is the part that makes this decisive rather than suggestive.** At the forced configuration each is EXACTLY at the ceiling the chain assigns it, so the whole of the flip survives.

| term at the corner | exact value | the chain's ceiling |
|---|---|---|
| pinning $\tfrac\theta2N_a-\tau$ | $0.08278634$ | $\tfrac{\sqrt3}2u_aN_a=0.08278634$ |
| cross $\sum_{b\ne a}\langle\nu_b\circ\nu_b,q_a\rangle$ | $0.05519090$ | $\tfrac{u_a}{2\sqrt3}(N-N_a)=0.05519090$ |
| $P(q_a)$ | $-0.07232765$ | $+\tfrac{\sqrt3}2u_a^3=+0.07232765$ |

The cross term is exact because $\nu_b\circ\nu_b$ has pattern $\beta^2(-2,1,1)$ by [L220's step 2](../findings/second-order.md) when $\nu_b=(0,\beta,-\beta)$, and $\beta^2=N_b/4$, so its overlap with $q_a$ on the single shared pair is $(-2\beta^2)x_a=+\tfrac{u_aN_b}{2\sqrt3}$ once $x_a<0$. The sign that makes the eigenvector condition work is the sign that makes the cross term maximal.

**Read as a demand on the coupling, the margin is a factor of four.** Solving the identity for the one term left free gives $\langle L_{q_a}r_a,r_a\rangle=0.1683570$ against $\lVert r_a\rVert^2=t-u_a^2=0.1528525$, a Rayleigh quotient of $1.1014$, while [L220's step 8](../findings/second-order.md) caps it at $\tfrac{u_a}{\sqrt3}\lVert r_a\rVert^2=0.0385747$.

**And step 8's own shape factor reinforces it.** The bound is $\max(x,y,z)\lVert q\rVert\lVert r\rVert^2$ over the UNIT pattern, which at $(-2,1,1)/(2\sqrt3)$ is $\tfrac1{2\sqrt3}$ rather than $\tfrac1{\sqrt3}$, halving the cap to $0.0192874$ and raising the factor to $8.7$. *This one rests on r1062's reading of step 8's maximisation and is offered as reinforcement rather than as load.*

**So the corner is INFEASIBLE, not on the boundary.** The heading's "exactly on the boundary of realisability" reads the coincidence of two block-level norms as a statement about the realisable set, when the norms it compares are both quantities in the blocks and neither is a test of $D$.

**The independent corroboration, which is where the note's own Gram reading enters.** G7's identity $u_{\mathrm{lo}}^2=\tfrac59t$ puts the corner on the Gram ceiling $\sum u_a^2\le\tfrac53t$, and [this file's Gram section](2026-09-14-I104-tau-positive.md) shows attainment forces $\beta_a=0$ with the $\alpha_a$ equal, so every $q_a$ is at the $\pm(2,-1,-1)$ shape. That fixes the shape from the diagonal side and leaves only the sign, and Finding 1's lemma fixes the sign to the branch with $P<0$. *The two routes to the shape agree, which is why the flip cannot be argued away as a coordinate choice.*

## Finding 2, on D1 and D2: both hold, and D2 holds more strongly than the note claims

**D2's eigenvalue is an identity rather than an attained bound, which is the brief's question answered in the strongest direction.** [L220's step 5](../findings/second-order.md) computes $E=4(x^2+y^2+z^2-xy-yz-zx)=6(x^2+y^2+z^2)=3\lVert q\rVert^2$ using $x+y+z=0$, so $L_q$ on the Bianchi plane has eigenvalues $\pm\tfrac12\sqrt{3}\,\lVert q\rVert$ for EVERY $q\in\Pi_Q$. The value $\tfrac{\sqrt3}2u_a$ therefore depends on $q_a$ through its norm alone and is attained at every shape. Restricting a traceless symmetric operator to a 2-plane leaves eigenvalues $\pm e_a$, so equality in the Rayleigh bound forces $\beta=0$, and the top branch is selected because $\tfrac\theta2N_a-\tau=0.0827863>0$ at the corner.

**D1 is true and is true by construction.** $u_{\mathrm{lo}}$ is DEFINED as the value at which G5's inequality closes on the equal diagonal with $\tau$ at the product bound: $\tfrac{\sqrt3}2u\,N_a=\tfrac\theta2N_a-\tau$ rearranges to $\sqrt3u=\theta-2\tau/N_a=\theta-s$. So $u_a=u_{\mathrm{lo}}$ gives equality directly rather than through a chain, and the brief's weaker reading does not arise. *Two inputs carry it, and the note states neither at this point: the equal diagonal, and $\tau$ exactly at G6's bound. Below the bound the required lower end on $u_a$ RISES, so $u_a=u_{\mathrm{lo}}$ also forces $\tau$ to the bound, which is why D6's conclusion has no room in it.*

## Finding 3, on D4, D5 and D6: three restatements presented as three coincidences

**D4 is an unfolding.** $\theta-\sqrt3u_{\mathrm{lo}}=\theta-(\theta-s)=s$ holds at every $s$ and uses nothing about the corner. [coeff_at_uLo](../lean/HamiltonsCubic/Results/I110Deficit.lean#L271) states it correctly and universally in $s$, which is the honest form. The prose's "Verified in radicals: both sides are $\tfrac{\sqrt6+\sqrt{10}}{12}$" presents a definitional identity as a numerical check, and evaluating both sides at $s=s_*$ can only agree.

**D5 compares an equality with a ceiling.** The left norm is $(\theta-2e_a)\sqrt{N_a}=2\tau/\sqrt{N_a}$, and on the equal diagonal with $\tau=\tfrac12s^3$ that is $s^2$. The right side's $N_a$ is $\max 2\lVert\nu_b\circ\nu_c\rVert$, not its value. Their coincidence is algebraically EQUIVALENT to $\tau=\tfrac12\sqrt{N_1N_2N_3}$ and carries no information beyond it, so "they agree exactly" overstates a substitution. *What is substantive is the forcing: the block equation then leaves $\lVert\nu_b\circ\nu_c\rVert$ no choice but the ceiling.*

**D6's "forces both links at once" is sound and is not needed for the parallelism.** Saturating $\tau\le\lVert\nu_1\circ\nu_2\rVert\lVert\nu_3\rVert\le\tfrac12\sqrt{N_1N_2}\sqrt{N_3}$ does force both, and $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ being fully symmetric carries it to all three groupings, so the cyclic statement follows. But the block equation $(\theta-2e_a)\nu_a=2\nu_b\circ\nu_c$ already exhibits $\nu_b\circ\nu_c$ as a multiple of $\nu_a$ the moment D2 makes $\nu_a$ an eigenvector, so the parallelism needs no chain argument at all.

**And $\tau$ at G6's bound is an input to the corner rather than an output.** G7 defines the corner on the equal diagonal with $\tau$ at that bound, so "the corner FORCES G6 saturated" restates the definition. *The reading that survives is the one the deficit supports: $\partial d/\partial f=+0.1056$ at $f=1$, so the deficit is increasing in $\tau$ and the worst configuration sits at the bound. That is a derivation and the note has it earlier in the file, which makes the later sentence a restatement rather than a second result.*

## Finding 4, on D8: the $D$ it leaves open is unique, and the question it leaves open is now answered

**D8 lists the right conditions and mis-prices them.** Gram attainment at the corner forces $\beta_a=0$ and the $\alpha_a$ equal, and $\lambda_{\max}$ of the sum of the three plane projections is $\tfrac53$ with a SIMPLE top eigenspace, so $D$ is determined up to one overall sign. Finding 1's lemma then fixes that sign. So the first of D8's two conditions is satisfiable and leaves no freedom, rather than being an open search over admissible $D$.

**The second condition is what fails**, and it fails through the $q_a$-pairing of the very equation D8 names. So D8's "what remains" is a complete list and the answer to it is negative.

## Sign conventions, checked against G8

**The corrected $(kp,lm)$ sign is used consistently and is load-bearing exactly once.** D7's attainability needs it: $\max\lvert\tau\rvert/\sqrt{S_1S_2S_3}=\sqrt2$ with $N_a=2S_a$ gives $\max\lvert\tau\rvert/\sqrt{N_1N_2N_3}=\sqrt2/2^{3/2}=\tfrac12$, matching G6 on the nose, while the printed sign's $\sqrt6/3$ would give $1/(2\sqrt3)$ and put the corner's $\tau$ out of reach. D5's $\lVert\nu_1\circ\nu_2\rVert^2=\tfrac12A$ carries the coefficient squared and is sign-free. Finding 1 uses [L220's step 2](../findings/second-order.md) for $\nu\circ\nu$ within one block and never the cross-block bilinear form, so it stands under either sign.

## Lean column

| claim | declaration | does the statement carry the claim |
|---|---|---|
| D4 | [coeff_at_uLo](../lean/HamiltonsCubic/Results/I110Deficit.lean#L271) | YES, and more generally than the prose, at every $s$ |
| D5 | [block_norms_agree](../lean/HamiltonsCubic/Results/I110Deficit.lean#L281) | NO |

**[block_norms_agree](../lean/HamiltonsCubic/Results/I110Deficit.lean#L281) type-checks and is not the claim.** Its statement is $(\theta-\sqrt3\,u_{\mathrm{lo}}(s))\sqrt{s^2}=s^2$ for $s\ge0$, which after [coeff_at_uLo](../lean/HamiltonsCubic/Results/I110Deficit.lean#L271) is $s\cdot s=s^2$. The right-hand side of the block equation appears nowhere in it: no $\nu$, no $\nu_b\circ\nu_c$, no product bound, no $N_b$, no corner. Its docstring asserts the whole of D5, D6 and D7, including "It sits exactly on the boundary of realisability rather than inside it", none of which the statement reaches. **The docstring should be cut back to what the statement says**, the more so now that its last sentence is refuted.

The file elaborates clean, exit 0, no `sorry` and no `native_decide`.

**Typeability of the untyped claims, in this layer.**

- **D1, D4 and D5 are already scalar** and need nothing new. D1 is the equality $\tfrac{\sqrt3}2u_{\mathrm{lo}}s^2=\tfrac\theta2s^2-\tfrac12s^3$, one `field_simp` away.
- **D2 and D3 need the 3-by-3 $G$ and its restriction**, so they type in a matrix layer rather than this one. They are small: $G$ is explicit, the Bianchi subspace is $\mathbf1^\perp$, and the eigenvalue claim is $\det(G|_{\mathbf1^\perp})=-e^2$ with $e=\tfrac{\sqrt3}2u$. Worth typing, because Finding 1's lemma is the same computation and it is the step the whole section turns on.
- **D6 and D7 need the Fox product on $V_{Q_a}$** and do not type here.
- **D8 is a statement about what is open** and is not a mathematical claim to type.
- **Finding 1's arithmetic typing is immediate**: $\theta u^2+\tfrac{\sqrt3}2u^3-\tfrac{u}{\sqrt3}(t-u^2)-(\tfrac\theta2N_a-\tau)-\tfrac{u}{2\sqrt3}(N-N_a)>0$ at $u=u_{\mathrm{lo}}(s_*)$ is a polynomial inequality in the same surds [deficit_at_sStar](../lean/HamiltonsCubic/Results/I110Deficit.lean#L258) already handles.

## Vacuity

**Each claim tested against what it would look like if it said nothing.** D4 and D5 fail that test in the form the prose gives them, for the reasons in Finding 3. D1 passes only once the two inputs it hides are stated. D2 passes and is stronger than advertised. D6's first half restates the corner's definition and its second half is a real forcing. D3 is a true implication about a configuration that does not exist, which is the sharpest form of vacuity in the section: it is correct and it describes nothing. D7 and D8 are the two that carry real content, and both of them change.

## Reach

**What these findings ARE about.** The eight claims D1 to D8 as written in the last section of [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), read against the givens G1 to G8, [L120](../findings/second-order.md), [L121](../findings/second-order.md), [L220](../findings/second-order.md) and [L221](../findings/second-order.md), and against the statements in [I110Deficit.lean](../lean/HamiltonsCubic/Results/I110Deficit.lean).

**What they are NOT about.** They settle the corner and nothing wider. The surviving region of I104's $\tau>0$ case is an interval in $s$ below $s_*$ on which the admissible $u$-interval is nondegenerate, and Finding 1 speaks only at the endpoint where that interval collapses to a point and both the pinning and the Gram bound are active. *The natural next question, how far below $s_*$ the argument survives by continuity, is a parameter sweep and r1062 opened no such run.* Nothing here revisits G1 to G8 themselves, the derivation of the deficit's cubic, the unequal-$N_a$ scope, or the corrected bilinear sign, all of which r1062 took as given.

**What had only r1062 as a reader, and should get a second.**

- **Finding 1's lemma and the flip of $P(q_a)$.** It is two lines of linear algebra and a numerical check, and it refutes a same-day claim, so it wants an independent derivation rather than a reproduction of r1062's arithmetic.
- **The reconstruction of $F$ from the four terms of the $q_a$-pairing identity.** It matches [chainF](../lean/HamiltonsCubic/Results/I110Deficit.lean#L68) to $10^{-16}$ at the corner, which is strong evidence and is not a proof that the record's $F$ was assembled that way.
- **The exactness of the cross term at its ceiling**, which rests on r1062's own computation of $\nu_b\circ\nu_b$'s pattern from [L220's step 2](../findings/second-order.md) and on the unordered-pair inner product convention.
- **The step-8 shape factor of $\tfrac1{2\sqrt3}$**, flagged in Finding 1 as reinforcement and not relied on.

**The recommendation.** *Withdraw D7 and rewrite the section's heading and its closing paragraph around the exclusion, since the same two claims that were offered as evidence of feasibility are what exclude the point.* The result is worth more than the claim it replaces: the corner that carried the whole $0.0148$ deficit is gone, and the open question narrows from "is the corner feasible" to "how far below $s_*$ does the flip survive".
