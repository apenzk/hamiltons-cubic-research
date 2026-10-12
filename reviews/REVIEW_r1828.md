# Review r1828: the small-mass node of (MG), I121

Brief: [BRIEF_I121_smallmass.md](BRIEF_I121_smallmass.md). Log: [agent_logs/r1828-i121-smallmass.log](../agent_logs/r1828-i121-smallmass.log). Sources read: [2026-09-28b-LIT-step8-sweep.md](2026-09-28b-LIT-step8-sweep.md), [2026-09-28b-step8-position.md](2026-09-28b-step8-position.md), [PairIdentity.lean](../lean/HamiltonsCubic/Results/PairIdentity.lean), [check_I121_pair_identity.py](../scripts/misc/check_I121_pair_identity.py), [REVIEW_r1797.md](REVIEW_r1797.md), [bispectral.md](../findings/bispectral.md) (L94, L95), [curvature-invariants.md](../findings/curvature-invariants.md) (L118), [second-order.md](../findings/second-order.md) (L218), [INDEX-values.md](../findings/INDEX-values.md).

Analysis-only footing. Two computations were run, both value checks: the Gate 1 script as shipped, and one reviewer script [r1828_frame_moment.py](../scripts/reviewers/r1828_frame_moment.py) (400 Haar frames at each of $n=8,12,16,20$, seconds).

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | the pair identity and the expansion of $P(W)$ | CONFIRMED, one observation |
| 2 | pair mass $\lVert B_p\rVert^2\le(n-1)t^2$ | CONFIRMED |
| 3 | the bound, Banach's constant, reach $t\ge c\,n^{-1/2}$, beats Schur from $n\approx270$ | CONFIRMED for the bound and Banach, PLAUSIBLE with corrections for the reach |
| 4 | threshold form from $\mathbb{CP}^m$ | CONFIRMED with corrections (normalisation, scope) |
| 5 | averaging identities die by scaling | frame bullet PLAUSIBLE, sectional-moment bullet REFUTED as written (conclusion survives) |
| 6 | four-set sector reading and what the route owes | Phase 3a CONFIRMED, Batch 2's "not a maximiser" REFUTED as a positive claim from a screen, "the regimes meet" PLAUSIBLE only |
| 7 | hypotheses | two unstated or understated uses, listed below |

## 1. The pair identity: CONFIRMED

- **Expansion.** Trilinear expansion of $P(A+B_p+B_f)$ has ten terms. By L120 the characters are: diagonal trivial, pair entry $(ik,jk)$ carries $\varepsilon_i\varepsilon_j$, four-set entry carries $\varepsilon_a\varepsilon_b\varepsilon_c\varepsilon_d$. So $T(A,A,B_p)=T(A,A,B_f)=T(A,B_p,B_f)=0$ and the other seven survive (two pair characters multiply to a pair or four-set character, and two four-set characters sharing two or three indices multiply to a four-set or pair character). The stated seven-term expansion is complete.
- **Pair projection.** $Q(W)=Q(A)+Q(B_p)+Q(B_f)+2L_AB_p+2L_AB_f+2Q(B_p,B_f)$ with $Q(A)$ diagonal and $L_A$ preserving each summand, so $\rho B_p=\pi_pQ(B_f)+\pi_pQ(B_p)+2L_AB_p+2\pi_pQ(B_p,B_f)$ as stated. Pairing with $B_p$ gives the stated expression for $T(B_f,B_f,B_p)$.
- **Substitution**, by hand: $\rho=P(A)+P(B_f)+3\langle L_AB_f,B_f\rangle-2P(B_p)-3\langle L_AB_p,B_p\rangle+3\rho\lVert B_p\rVert^2-3T(B_p,B_p,B_f)$. Matches the text and `pair_identity`.
- **Observation, the Lean note is right.** Without L120, $P(W)-3T(W,W,B_p)=P(A)-2P(B_p)+P(B_f)+3T(A,A,B_f)+3T(A,B_f,B_f)-3T(A,B_p,B_p)-3T(B_p,B_p,B_f)$ identically, and $T(W,W,B_p)=\rho\lVert B_p\rVert^2$ needs only $Q(W)=\rho W$ and the orthogonality of the three parts. So the identity needs only $T(A,A,B_f)=0$, which holds in every frame because $Q$ of a diagonal operator is diagonal. The Gate 1 run reproduces $\lvert\rho-\text{rhs}\rvert=1.1\times10^{-15}$ at $S^4\times S^4$ in a random frame ($t=0.2356$), consistent with this.
- **Also checked**: $A$, $B_p$, $B_f$ are each Weyl, since Bianchi touches only four-set entries and the Ricci contraction splits into a diagonal part from $A$ and an off-diagonal part from $B_p$.

## 2. The pair mass bound: CONFIRMED

- **Factor.** [r1797](REVIEW_r1797.md) O1: under the Hilbert–Schmidt reading $\lVert B_{jk}\rVert^2=2\lVert x\rVert^2\le2\lVert\delta\rVert^2=\tfrac12\sum_i(a_{ji}-a_{ki})^2$. With $A=t\hat A$ and $\hat\delta^{jk}_i=\tfrac12(\hat a_{ji}-\hat a_{ki})$ this is $2t^2\lVert\hat\delta^{jk}\rVert^2$, as stated.
- **The forced sum, proved here exactly.** For fixed $i$ the row $r_j=a_{ij}$ ($j\ne i$) has $n-1$ entries summing to zero (Ricci-flatness of $A$), so $\sum_{j<k,\,j,k\ne i}(r_j-r_k)^2=(n-1)\sum_jr_j^2$. Summing over $i$ gives $2(n-1)\sum_{j<k}a_{jk}^2$, so $\sum_{j<k}\lVert\hat\delta^{jk}\rVert^2=\tfrac14\cdot2(n-1)=\tfrac{n-1}2$ at unit $\hat A$ in the HS normalisation $\lVert A\rVert^2=\sum_{j<k}a_{jk}^2$. The "screened" given is in fact an identity.
- Each pair entry belongs to exactly one pair block, so $\lVert B_p\rVert^2=\sum_{j<k}\lVert B_{jk}\rVert^2\le(n-1)t^2$. The bound needs the one-plane bound's hypothesis, a frame (locally) maximising $t$.

## 3. The bound and its reach

**The bound: CONFIRMED.**

- **Banach.** $T$ is totally symmetric on all self-adjoint operators on $\Lambda^2$ (the $R^2$ part by cyclicity of the trace on symmetric matrices, the $\#$ part by total antisymmetry of the structure constants), hence on the subspace $\mathcal W_n$. $\mathcal W_n$ with HS is a finite-dimensional real Hilbert space, where Kellogg/Banach gives $\lVert T\rVert=\sup_{\lVert X\rVert=1}\lvert P(X)\rvert$, and $\sup\lvert P\rvert=\Theta_n$ because $P$ is odd. So $\lvert T(X,Y,Z)\rvert\le\Theta_n\lVert X\rVert\lVert Y\rVert\lVert Z\rVert$ holds, and $\Theta_n=\rho$ only at a global maximiser. The restriction to $\mathcal W_n$ matters: on the full symmetric space the norm is larger.
- **Term caps.** $P(B_f)\le S_Ff^3$ by definition of $S_F$ (frame-independent by $O(n)$-invariance, and $S_F\ge0$ by oddness). $\pm\langle L_AB,B\rangle\le\tfrac{\sqrt3}2t\lVert B\rVert^2$ for $B\in\mathcal D_n^\perp$ by L218 applied to $A$ and $-A$. $P(A)\le\theta_0t^3$ by L57 at even $n$. $-2P(B_p)\le2\rho p^3$ and $-3T(B_p,B_p,B_f)\le3\rho p^2f$ by Banach. The sweep's $6\rho$ is `small_mass_bound`'s $3\rho+3\rho f$ with $f\le1$, consistent.

**The reach: PLAUSIBLE with corrections.**

- **Arithmetic checks.** Schur's floor is $t^2\ge\tfrac6{(n+1)(n+2)}$, which is $0.181$ at $n=12$ as quoted. $c\,n^{-1/2}>\sqrt6/n$ iff $n>6/c^2$, and $c=\sqrt{0.17/(6\times1.2617)}=0.150$ from the $n=14$ room gives $n>267$, so "$n\approx270$" is right as arithmetic.
- **Correction 1, a dropped first-order term.** "At $t=c\,n^{-1/2}$ the error is about $6\rho c^2+2\rho c^3$" omits $\tfrac{3\sqrt3}2t\,f^2\approx2.6\,c\,n^{-1/2}$, which at $n=270$, $c=0.15$ is $0.024$ against $\delta=0.17$. It lowers $c$ by roughly $7\%$ and moves the crossover to roughly $n\approx300$. Asymptotically harmless.
- **Correction 2, the direction of the screened room.** The ascents give lower bounds on $S_F$, so every "room" in the Batch 2 table is an upper bound on $\delta(n)=\theta_0(n)-S_F(n)$, and the $n=14$ value is unconverged besides. The route also needs $\delta$ at $n\approx270$, while the screened rooms fall ($0.31,0.25,0.20,0.17$). The honest form is: the crossover $n_*$ solves roughly $n_*\approx36\rho/\delta(n_*)$, so $n\approx270$ is a lower estimate, and "it removes the small-mass regime for large $n$" holds only if $\liminf_n\delta(n)>0$, which no screen addresses. The text lists $S_F<\theta_0(n)$ as owed but not the uniform room the asymptotic claim needs.

## 4. Threshold form from $\mathbb{CP}^m$: CONFIRMED with corrections

- **Normalisation.** L94 defines $\kappa^2=\max_F\sum_{a\ne b}W_{abab}(F)^2$ over ordered pairs at $\lVert M\rVert_F=1$, which is $2t^2$ in the brief's normalisation (L54 step (3): $t_F=2\sum_{a<b}M_{(ab),(ab)}^2$). So "maximal-frame diagonal mass $\kappa^2=\tfrac3{m+1}$" should read $t^2=\tfrac{3}{2(m+1)}=\tfrac3{n+2}$. The limit $t\to0$ is unaffected.
- **Bounded below.** The three values alone show decrease, and the lower bound comes from the catalogued closed form $\theta^2(\mathbb{CP}^m)=\tfrac{(m+1)(2m-1)}{3m(m-1)}\to\tfrac23$, so $\theta\ge\sqrt{2/3}$. The text should cite the closed form.
- **Scope.** The argument excludes a bound $P\le F(t)$ with $F$ independent of $n$. At fixed $n$ the maximal-frame $t$ is bounded below by Schur's floor, so "$F_n(t)\to0$" is vacuous and nothing is excluded per $n$ ([bispectral.md](../findings/bispectral.md) under L95 says the same of $\theta\le C\kappa$). The threshold $t_0$ the claim then permits may also depend on $n$, and the route's $t_0=c\,n^{-1/2}$ does.
- **A useful consequence.** $\mathbb{CP}^m$ sits at $t=\sqrt{3/(n+2)}\approx1.73\,n^{-1/2}$, exactly the route's scale, with $\theta\ge\sqrt{2/3}$. So the $n^{-1/2}$ window is populated by critical points of bounded-below value, and a threshold argument there must use $\theta>\sqrt{3/2}$ (or global maximality), which the route does through $S_F$.
- The second Batch 1 bullet (families at or below $\sqrt{3/2}$, $\sup\sqrt{56/45}$, $1.088948$) matches [INDEX-values.md](../findings/INDEX-values.md) exactly. The third (L220, L221 and what stays open) was read against the record only and is PLAUSIBLE.

## 5. The averaging dead ends

**Frame averages: PLAUSIBLE, value-checked.** For any representation $P=\mathbb E_F[c(d_F)]$, $K\ge\theta_0/\mathbb E_F\lVert d_F(W_0)\rVert^3$ at the balanced product, so the best bound is $t\gtrsim(\mathbb E\lVert d_F\rVert^3)^{1/3}$. The claim "$K\sim n^3$" needs $\mathbb E\lVert d_F\rVert^3\asymp(\mathbb E\lVert d_F\rVert^2)^{3/2}$, a concentration statement the text does not make. The elementary bound $\mathbb E\lVert d\rVert^3\le\mathbb E\lVert d\rVert^2$ gives only $K\gtrsim n^2$, hence only "no better than $n^{-2/3}$". The value check ([r1828_frame_moment.py](../scripts/reviewers/r1828_frame_moment.py)) gives $\mathbb E t_F^2=0.0639,0.0324,0.0201,0.0131$ against Schur's $0.0667,0.0330,0.0196,0.0130$ and a moment ratio $\mathbb E t_F^3/(\mathbb E t_F^2)^{3/2}=1.14,1.09,1.07,1.07$ at $n=8,12,16,20$. That is a screen consistent with $K\asymp n^3$, and the order-$n^{-1}$ conclusion is the heuristic reading of it.

**The 3-plane half and the sectional-moment bullet: REFUTED as written, conclusion survives.**

- The written bound "$\theta\lesssim n^6t^3/c_n$ with $c_n\sim n^6/144$" is $\theta\lesssim144\,t^3$, which would give an $n$-free floor $t\gtrsim(\theta/144)^{1/3}$, contradicting "the same order". It is also false: at $\mathbb{CP}^m$, $t^2=\tfrac3{2(m+1)}$ and $\theta\ge\sqrt{2/3}$, so $144t^3<\theta$ once $m\ge47$ (at $m=100$: $144t^3=0.261$ against $\theta=0.823$).
- The correct reading of L118 is $\theta=c_n\Psi_3+\tfrac5{72}\Phi$ with $\lvert\Psi_3\rvert\le t^3$ (checked: $c_6\Psi_3=0.0586$ and $\tfrac5{72}\Phi=0.9955$ sum to $1.0541$ at $S^3\times S^3$), and $\Phi$ bounded only through $\lvert N_{xy}\rvert\le t\,\lvert x\wedge y\rvert^2$ with Gaussian Gram moments of order $n^6$. Both terms give $\theta\lesssim n^6t^3$, hence $t\gtrsim n^{-2}$, **weaker than Schur's $n^{-1}$**, not the same order.
- Likewise the first bullet's "each random frame or 3-plane sees $O(1/n)$ of the curvature" is right for frames but a 3-plane's sectional curvatures are each of order $n^{-2}$, so the 3-plane constant grows like $n^6$ rather than $n^3$.
- **Correction**: "Sectional-curvature moments. $\lvert K\rvert\le t$ in L118's moments gives $\theta\lesssim c_nt^3+\tfrac5{72}\lvert\Phi\rvert$ with $\lvert\Phi\rvert\lesssim n^6t^3$, so $t\gtrsim n^{-2}$, below Schur's order." The route stays dead, more firmly than stated.

## 6. The four-set sector reading

- **Phase 3a: CONFIRMED** as a conditional. $\lVert B_p\rVert^2\le(n-1)t^2\ll1$ at $t^2\ll\tfrac1{n-1}$, and the text correctly leaves the window $n^{-1}\lesssim t\lesssim n^{-1/2}$ open. "L220's and L221's setting" is an approximation: those lemmas concern exact critical points in exact subspaces with one or two four-sets, while $B_f$ spans many and $A+B_f$ is not critical. The text's own next step (a quantitative L220) acknowledges this.
- **Batch 2, "So at $n\le12$ a tensor wholly in the four-set sector is not a maximiser, with room": REFUTED as a positive claim.** Twelve random-start ascents bound $S_F$ from below only. "Not a maximiser" needs $S_F<\Theta_n$, an upper bound, which no row supplies. The screen says only that the ascents found nothing at or above $\theta_0(n)$. [plan.md](../plan.md) line 103 words it correctly ("screened below $\theta_0(n)$"), and the sweep sentence should match it.
- **The $+c_*$ subsector bound $<1.021$** is arithmetically right ($\tfrac{5\sqrt3}{12}\cdot\sqrt2=1.0206$), but it rests on I122's inequality, which [plan.md](../plan.md) records as reduced, Gate 2 passed on the reduction, and proved at $m=4$ only. It is conditional on I122 and should say so.
- **"Where it thins"**: increments $0.115,0.084,0.058$ and rooms $0.312,0.251,0.203,0.171$ recomputed and correct, with $\theta_0(n)$ from $\tfrac{(m-1)(2m-1)}{m^2}$. "Nothing in range suggests it closes" is an extrapolation from four points, the last unconverged, and the rooms fall by $0.061,0.048,0.033$. It is a hedge, and per section 3 the rooms are upper bounds.
- **"Of order $n^{-1/2}$ ... which is where attempt 4's joint bound stops failing" and "the two regimes then meet up to constants": PLAUSIBLE only.** The first sweep's attempt 4 says it fails at small $t$ and "only gives $t\gtrsim n^{-1/2}$", with its bound reaching about $2$ at $n=12$, and the position file gives $t_*\sim n^{-1/2}$ for concentrated diagonal parts only. That the joint bound succeeds just above $c\,n^{-1/2}$ for every diagonal shape is not shown. The owed item (iii) covers the constant but the sentence states the meeting as fact.

## 7. Hypotheses

| hypothesis | where used | stated? |
|---|---|---|
| global maximality ($\rho=\Theta_n$, $\rho\ge\theta_0$) | Banach's constant for $-2P(B_p)$ and $-3T(B_p,B_p,B_f)$, and the contradiction $\rho\ge\theta_0>S_F+\text{err}$ | yes |
| maximal frame | one-plane bound, hence the pair mass | in the Givens, not restated in Phase 3a or Batch 2. The pair identity itself needs no special frame |
| even $n$ | L57 for $P(A)\le\theta_0t^3$ | yes. Odd $n$ (target $\Theta_n<\theta_0$, L57Odd) is not addressed |
| $S_F<\theta_0(n)$ | the exclusion | listed as owed at each even $n\ge12$ |
| $\liminf_n(\theta_0(n)-S_F(n))>0$ | "removes the small-mass regime for large $n$" and the $n\approx270$ crossover | **not stated** (section 3, correction 2) |
| I122's inequality | the $+c_*$ subsector bound | **not stated** as conditional |

## Corrections requested

1. Sectional-moment bullet: replace "$\theta\lesssim n^6t^3/c_n$ ... the same order" with "$\theta\lesssim n^6t^3$, so $t\gtrsim n^{-2}$, below Schur's order". State that a 3-plane sees $O(n^{-2})$ per sectional curvature.
2. $\mathbb{CP}^m$: $t^2=\tfrac{3}{2(m+1)}$ ($\kappa^2=2t^2$), cite the closed form for $\theta\ge\sqrt{2/3}$, and say the exclusion is of $n$-uniform $F$.
3. Batch 2: "a tensor wholly in the four-set sector is not a maximiser" becomes "the ascents found no four-set tensor at or above $\theta_0(n)$", and the room column is marked as an upper bound on $\theta_0-S_F$.
4. The reach: add the dropped $\tfrac{3\sqrt3}2t$ term, and make the large-$n$ claim conditional on a room bounded below uniformly in $n$.
5. The $+c_*$ bound: conditional on I122.
6. "Attempt 4 stops failing at $n^{-1/2}$": state as the hope item (iii) names, and restrict to concentrated diagonal parts as the position file does.

Scripts left: [scripts/reviewers/r1828_frame_moment.py](../scripts/reviewers/r1828_frame_moment.py).
