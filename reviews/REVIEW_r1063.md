# REVIEW r1063: I110's substitution, the norm half, and the corner's position

Reviewer `r1063`, Gate 2, adversarial. Target: the last section of [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), heading "I110'S SUBSTITUTION, THE NORM HALF: THE CORNER SITS EXACTLY ON THE BOUNDARY OF REALISABILITY", 2026-09-21.

Log: [agent_logs/r1063-i110-substitution.log](../agent_logs/r1063-i110-substitution.log). Analysis by hand throughout, with one arithmetic screen of objects this review constructs.

## Verdicts

| claim | verdict | one line |
|---|---|---|
| D1 pinning tight at the corner | CONFIRMED, reasoning corrected | true as an identity from the corner's definition, and the stated route through $u_{\mathrm{lo}}$ is the identity read backwards |
| D2 top eigenvector, $\beta=0$ | CONFIRMED, strengthened | $\tfrac{\sqrt3}2u_a$ is the EXACT top eigenvalue of $L_{q_a}$ on the Bianchi plane at every $q_a$, never an unattained bound |
| D3 each $\nu_a$ determined up to sign by $D$ | CONFIRMED, sharpened | the correspondence is a bijection of directions, so $q_a$ is equally determined by $\nu_a$, and both are pinned to explicit shapes |
| D4 $\theta-\sqrt3u_{\mathrm{lo}}=s$ exactly | CONFIRMED | radical identity, and it is the record's own [gram_boundary_eq](../lean/HamiltonsCubic/Results/I110Deficit.lean) in another spelling |
| D5 both sides have norm $N_a$ | CONFIRMED as arithmetic, gloss REFUTED | the two quantities are not independently computed: the agreement is $\tau=\tau_{\max}$ restated |
| D6 saturation plus cyclic parallelism | CONFIRMED | the chain is the right one, $\tau$ equals the endpoint by the block equation itself, and symmetry of $T$ carries it to all three pairs |
| D7 attainable, so the corner is on the boundary of realisability | **REFUTED** | the corner's own forced $D$ fails the $\mathcal D_n$ equation, $P(D)=-0.130190$ against a required $+0.172853$ |
| D8 what remains is $D$-compatibility | CONFIRMED as a list, REFUTED as "open" | the Gram bound saturates at the corner, so $D$ is unique and every condition D8 names is decidable in closed form, and one of them fails |

## D2, the load-bearing step: $\tfrac{\sqrt3}2u_a$ is attained, always

**The brief's question has a clean answer and it favours the claim.** [L121](../findings/second-order.md) gives the block eigenvalues as $\pm\tfrac12\sqrt E$ with $E=A^2+B^2+C^2-AB-BC-CA$, and $\Pi_Q$'s coordinates $(x,y,z)$ at $x+y+z=0$ give $A=2x$, $B=2y$, $C=2z$ and $u^2=2(x^2+y^2+z^2)$. Then $E=4\big[\sum x^2-\sum xy\big]=6\sum x^2=3u^2$, so

$$e_a=\tfrac12\sqrt{E}=\tfrac{\sqrt3}2u_a\quad\text{identically, for every }q_a .$$

**So [L220](../findings/second-order.md)'s step 5 is Rayleigh's inequality with the exact operator norm on the right**, and the equality case is a genuine eigenvector condition rather than an unreachable one. A second route confirms it: writing $w=a+\omega b+\omega^2c$ and $\xi=x+\omega y+\omega^2z$ with $\omega=e^{2\pi i/3}$, the operator is the antilinear map $w\mapsto\bar\xi\bar w$, whose singular value is $\lvert\xi\rvert=\sqrt{\tfrac32\sum x^2}=\tfrac{\sqrt3}2u$.

**The antilinear form also settles D3 in both directions.** The $+e$ eigenline of $w\mapsto\bar\xi\bar w$ has argument $-\tfrac12\arg\xi$, so the map from the direction of $q_a$ in $\Pi_{Q_a}$ to the line of $\nu_a$ in $V_{Q_a}$ is a bijection. $D$ determines $\nu_a$ up to sign, which is D3, and $\nu_a$ determines $q_a$ outright, which D3 does not say and which is what makes the corner checkable.

**The equivalent statement without coordinates**: $q_a=u_a\widehat{\nu_a\circ\nu_a}$ at tightness, because $q\mapsto\langle\nu\circ\nu,q\rangle$ is linear of norm $\lVert\nu\circ\nu\rVert=\tfrac{\sqrt3}2N$ and is maximised only along $\nu\circ\nu$.

## D1, true but derived backwards

**At the corner $\lvert\langle L_{q_a}\nu_a,\nu_a\rangle\rvert=\tfrac{\sqrt3}2u_aN_a$ holds, and nothing is inferred from a chain.** G5's identity gives the left side as $\tfrac\theta2N_a-\tau=\tfrac{s^2}2(\theta-s)$ once $\tau=\tfrac12s^3$, and $u_a=u_{\mathrm{lo}}=(\theta-s)/\sqrt3$ gives the right side the same value. Both are active constraints of the relaxation at its corner, so the equality is the corner's definition rather than a consequence of it.

**The note's wording has the implication pointing the wrong way.** $u_{\mathrm{lo}}$ was DEFINED by solving $\tfrac{\sqrt3}2uN_a=\tfrac\theta2N_a-\tau$ at $\tau=\tau_{\max}$, so "at the corner $u_a=u_{\mathrm{lo}}$, so the pinning inequality is TIGHT" reads as a derivation and is a restatement. The verdict is CONFIRMED because the conclusion is right and load-bearing, and the correction is that D1 imports $\tau=\tau_{\max}$, which the sentence never names.

**Sign check, since D2's "TOP" depends on it.** $\tfrac\theta2N_a-\tau=+0.082787>0$ at the corner, so the eigenvalue is $+e_a$ and "top" is correct. Had the corner taken $\tau$ at the negative end of G6, $u_{\mathrm{lo}}$ would read $(\theta+s)/\sqrt3$, which is not G7's value.

## D5, an equality that could not have come out otherwise

**The two numbers are one number.** Under D1 and D2 the block equation's left side has norm $(\theta-2e_a)\sqrt{N_a}=2\tau/\sqrt{N_a}$, using G5's identity alone. Setting that against the right side gives $\lVert\nu_b\circ\nu_c\rVert=\tau/\sqrt{N_a}$, and the product bound $\lVert\nu_b\circ\nu_c\rVert\le\tfrac12\sqrt{N_bN_c}$ then reads $\tau\le\tfrac12\sqrt{N_aN_bN_c}$, which is G6 itself. **So "the two agree on the nose" is G6 saturated, which the corner assumes.**

**The sentence to correct is the closing one**, "which is what an exact equality between two independently computed quantities means". They are not independent. What the section does establish is that the norm half produces no CONTRADICTION at the corner, which is worth having and is a weaker statement than the one made.

## D6, confirmed, and the parallelism is cheaper than the argument given

**The chain is the right one and $\tau$ reaches its end.** From $2\nu_1\circ\nu_2=s\nu_3$ the pairing gives $\tau=\tfrac s2N_3=\tfrac12s^3=\tfrac12\sqrt{N_1N_2N_3}$, so $\tau$ equals G6's bound rather than merely being under it, and saturating a two-link chain does force both links.

**All three pairs saturate, by symmetry rather than by repetition.** $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric, so $\tau=\langle\nu_2\circ\nu_3,\nu_1\rangle=\langle\nu_3\circ\nu_1,\nu_2\rangle$ and the same chain runs at each. **The parallelism needs no chain at all**: the block equation's left side is a multiple of $\nu_a$, so $\nu_b\circ\nu_c\parallel\nu_a$ is immediate. The chain argument is redundant, not wrong.

## D7, REFUTED: the corner's $D$ is forced, and it fails the $\mathcal D_n$ equation

**Step 1, the block shapes are pinned to explicit vectors.** The product bound's equality case is $a_1=a_2=0$ with $\lvert b\rvert=\lvert c\rvert$, which Bianchi supplies, so in signed coordinates $\nu_a\propto(0,1,-1)$ with the zero on the pairing that separates $Q_a$'s two shared pairs. That is the file's own [line 275](2026-09-14-I104-tau-positive.md). Re-derived here: equality in $a_1^2a_2^2+2B_1B_2\le2S_1S_2$ needs $a_1^2a_2^2+2a_1^2B_2+2B_1a_2^2=0$, and with both blocks nonzero that forces $a_1=a_2=0$.

**Step 2, each $q_a$ is then pinned too, with its SIGN.** $L_{q}\nu=e\nu$ at $\nu=(0,1,-1)$ forces $y=z$ and $e=y-x$, so $x=-2y$ and $e=3y$, and $e>0$ selects $y>0$:

$$q_a\propto(-2,1,1),\qquad\text{the }-2\text{ on the pairing where }\nu_a\text{ vanishes.}$$

Confirmed three independent ways: the matrix, the antilinear form, and $\nu\circ\nu$ computed from $\langle\nu\circ\nu,q\rangle=2\nu^{\mathsf T}M_q\nu=-6x$, which gives $\nu\circ\nu=(-2,1,1)$ at $\nu=(0,1,-1)$ with $\lVert\nu\circ\nu\rVert=\sqrt{12}=\tfrac{\sqrt3}2N$, reproducing the record's own constant. The orientation convention of G4 is checked against [L127](../findings/second-order.md)'s recorded eigenvector: at $S^m\times S^m$ the $(2,2)$ block has $q\propto(2,-1,-1)$ and top eigenvector $(2,-1,-1)$, which the same matrix reproduces.

**Step 3, $D$ is then UNIQUE.** $\lVert q_1+q_2+q_3\rVert^2=3u^2+2\cdot3\cdot\tfrac13u^2=5u^2$, so $g=\tfrac35\sum_aq_a$ satisfies $P_{\Pi_{Q_a}}g=q_a$ and $\lVert g\rVert^2=\tfrac95u^2$. At the corner $u_{\mathrm{lo}}^2=\tfrac59t$, hence $\lVert g\rVert^2=t$ EXACTLY. Any other $D$ with the same projections is $g+h$ with $h\perp\mathrm{span}(\Pi_{Q_a})$, so $\lVert D\rVert^2=t+\lVert h\rVert^2$ and $\lVert D\rVert^2=t$ forces $h=0$. **This holds at every $n\ge6$**, since $h$ supported outside the six indices is still orthogonal to the three planes.

**Step 4, the $\mathcal D_n$ equation fails.** Pairing $D\circ D+\sum_a\nu_a\circ\nu_a=\theta D$ with $D$, and using $\nu_a\circ\nu_a\in\Pi_{Q_a}$ together with G5's identity,

$$P(D)=\theta\big(t-\tfrac N2\big)+3\tau=+0.172853 .$$

The forced $D$ has $K_{ij}=K_{kl}=K_{mp}=-4\delta$ and $\delta$ on the twelve cross pairs, $\delta=\tfrac{\sqrt3}{10}u_{\mathrm{lo}}$, and the diagonal cubic $P=\sum_{a<b}K_{ab}^3+3\sum_{\triangle}K_{ab}K_{bc}K_{ca}$ ([L226's item 1(b)](../findings/second-order.md)) gives $P(D)=-300\delta^3=-0.9\sqrt3\,u_{\mathrm{lo}}^3=-0.130190$. **The sign is wrong and the gap is $0.303$, twenty times the $0.0148$ deficit the corner is priced at.**

**So the corner is not on the boundary of the realisable set, it is outside it.** D7's own premise concedes the point: attainability was established for the $\tau$-maximising configuration in isolation, which constrains the three $\nu_a$ and says nothing about whether any admissible $D$ carries them. The forced $D$ exists, is unique, and does not.

**The mechanism is geometric and worth naming.** $P$ on $\Pi_Q$ is $18xyz$, maximal at the $S^2\times S^2$ shape $(2,-1,-1)$ and minimal at $(-2,1,1)$. The criticality equation needs $P(D)$ positive, while the block tightness forces every $q_a$ onto the $P$-minimising shape. The two pull opposite ways and the corner is where they are asked to hold at once.

## The consequence for I104, which is larger than the section

**The corner sits in the $x_i<0$ regime that [the file dismissed](2026-09-14-I104-tau-positive.md).** The shared-channel coefficient of $q_a$ is its coefficient on the pairing separating the two shared pairs, which is the pairing where $\nu_a$ vanishes and where $q_a$ carries $-2$. Normalised, it is $-\tfrac1{\sqrt3}=-0.577350$, at the ceiling in magnitude and negative in sign, while $\max(x,y,z)=+\tfrac1{2\sqrt3}=0.288675$.

**Two sentences of the record need the sign.**

- *[r1059](REVIEW_r1059.md)'s pricing*, "the forcing $S_2\ge0.190268$ gives $\max(x,y,z)\ge0.575579$ against $\tfrac1{\sqrt3}$". The forcing is on $\lvert c\rvert$, and the forced shape has $\max(x,y,z)=0.288675$. $S_2=3c^2=u_{\mathrm{lo}}^2=0.191066$ is satisfied with $c<0$.
- *The Gram-attainment paragraph*, "Attainment puts $D$ along $G_e$'s top eigenvector, which is $(1,1,1)$ ... so $\alpha_i=1$ gives $x_i=\tfrac1{\sqrt3}$". $-(1,1,1)$ is in the same eigenline and attains the same bound. The explicit $D$ above attains $\sum_au_a^2=\tfrac53t$ exactly with all three $\alpha_i$ negative, so the branch is real and the paragraph picks one of two without saying so.

**What that is worth.** The file prices the $x_i<0$ regime at a loss of $0.2505$ in step 8's link, seventeen times the $0.0148$ deficit, and sets it aside "because the chain is not worst there". That reason is about the relaxation's argmin, and the argmin is the point this review shows to be infeasible. **The requirement the file states for a successor, a step LOSSY AT THE BINDING CORNER ITSELF, is met by a step the file already has**, once the corner's own sign is used. This is a route, not a proof: it is exact at $s=s_*$ and needs a quantitative neighbourhood to close the case.

## D8, the list is right and the question is not open

**Every condition D8 names is now in closed form.** The three $\nu_a$ are $(0,1,-1)$ in their blocks, the three $q_a$ are $(-2,1,1)$ at norm $u_{\mathrm{lo}}$, the pairwise cosines $\langle\hat q_a,\hat q_b\rangle$ come out at $+\tfrac13$ for all three pairs rather than being an assumption, $D$ is unique, and the $\mathcal D_n$ equation reduces to $D\circ D=\kappa D$ with $\kappa=\theta-\tfrac{5\sqrt3N_a}{6u_{\mathrm{lo}}}=0.502539$, whose contraction with $D$ already fails. **So D8's "what remains" is settled in the negative rather than left open.**

*A wording note on D8: "mutual cosines $(\tfrac13,0)$" are the PRINCIPAL cosines of the two planes, a rank-one overlap, and are not the cosines between the $q_a$ vectors, which are all $+\tfrac13$ here. The file records the naming trap, and a reader of D8 alone would not see it.*

## Vacuity, asked of each claim

**D1 and D5 are the two that would look the same if empty, and D5 is.** D1 is a restatement of the corner's definition whose value is entirely as D2's premise. D5 is an identity in $\tau=\tau_{\max}$ and could not have failed. D2 would have been vacuously true and catastrophic in meaning had $\tfrac{\sqrt3}2u_a$ been unattained, since tightness would then be impossible and the corner infeasible for that reason instead. It is attained, so D2 is substantive. D4 is arithmetic. D6 and D7 carry real content and D7 is false.

## Lean column

| claim | declaration | statement against prose |
|---|---|---|
| D4 | [coeff_at_uLo](../lean/HamiltonsCubic/Results/I110Deficit.lean) | WEAKER than D4. It is `theta - √3 * uLo s = s` for EVERY real `s`, which unfolds `uLo s = (theta - s)/√3` and cancels. It carries no corner content, and D4's "both sides are $\tfrac{\sqrt6+\sqrt{10}}{12}$" needs `s = sStar`, which the statement does not mention |
| D5 | [block_norms_agree](../lean/HamiltonsCubic/Results/I110Deficit.lean) | WEAKER than its name and its docstring. The statement is `(theta - √3 * uLo s) * √(s^2) = s^2`, the LEFT side's norm alone. Nothing about $2\lVert\nu_b\circ\nu_c\rVert$, the product bound, or an agreement appears in it. The docstring asserts the product bound saturated and "sits exactly on the boundary of realisability rather than inside it", which is D7 and is refuted above |

The file compiles clean, `exit 0`, with no `sorry` and no `native_decide`. [gram_boundary_eq](../lean/HamiltonsCubic/Results/I110Deficit.lean), `36*sStar^2 - 6√6*sStar - 1 = 0`, is exactly the equation this review re-derived as $u_{\mathrm{lo}}^2=\tfrac59t$, so the corner IS the Gram-saturation point as a matter of algebra.

**Typability of the untyped claims in this layer.**

- **D1 typeable now**, as the scalar identity $\tfrac\theta2N-\tau=\tfrac{\sqrt3}2u_{\mathrm{lo}}N$ at $\tau=\tfrac12s^3$, $N=s^2$. Pure real arithmetic, no tensor.
- **D2 and D3 need the block**, so not in this layer: they quantify over $L_{q_a}$ on a 2-plane. The eigenvalue half, $e=\tfrac{\sqrt3}2u$, IS typeable as $E=3u^2$ on the three real coordinates at $x+y+z=0$, and that is the part worth having.
- **D4 and D5 are typed**, with the gaps above.
- **D6 not typeable here**, it needs the trilinear form's symmetry.
- **D7 REFUTED, and its refutation is typeable in pieces**: $\lVert\tfrac35\sum q_a\rVert^2=\tfrac95u^2$ from the Gram matrix, and $P(D)=-0.9\sqrt3u^3$ against $\theta(t-\tfrac N2)+3\tau$, both real arithmetic once the shapes are fixed.
- **D8 not a single statement**, and its two halves split the same way.

## Reach

**What these findings ARE about.** The eight claims of one section, read against G1 to G8 as given, plus the two Lean statements named. The refutation of D7 is exact arithmetic at the single point $s=s_*=\tfrac{\sqrt6+\sqrt{10}}{12}$ on the equal-$N_a$ diagonal with $\tau$ at G6's bound, under the givens that the corner has $u_a=u_{\mathrm{lo}}$ in all three blocks and that the product bound's equality case is $a_a=0$.

**What they are NOT about.** They do not close [I104](../plan.md)'s $\tau>0$ case. The $0.2505$ figure is the record's and is quoted, not re-derived. The argument is pointwise at the corner and says nothing quantitative about a neighbourhood, so the step from "the corner is infeasible" to "the deficit is recoverable" is a route with a named gap. Nothing here bears on unequal $N_a$, on $\tau<0$, or on any stratum outside two four-sets sharing two indices.

**Read only by r1063, and flagged as such.**

- The identity $e_a=\tfrac{\sqrt3}2u_a$ and the antilinear form of $L_{q}$. Both are one-line checks and the first is implicit in [L121](../findings/second-order.md), but neither is written anywhere on the record.
- The forcing $q_a\propto(-2,1,1)$ and therefore the SIGN of the shared-channel coefficient at the corner. This is the finding that contradicts two recorded sentences, and it had one reader.
- The uniqueness of $D$ at the corner and $P(D)=-0.9\sqrt3u_{\mathrm{lo}}^3$. Screened once by arithmetic on the six-index configuration this review builds, which reproduces $\lVert D\rVert^2=t$, $u_a=u_{\mathrm{lo}}$, the three cosines $\tfrac13$ and zero row sums, all to machine precision. **A screen of a derivation, and the derivation is what stands.**

**The one thing a second reader should attack first**: that $\nu_a$ must be the TOP rather than the bottom eigenvector. Everything downstream flips sign with it, and it rests on $\tfrac\theta2N_a-\tau>0$ at the corner, which is $\theta>s$.
