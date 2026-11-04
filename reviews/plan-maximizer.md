# plan-maximizer, what maximality adds to criticality

Region: second-order and global information at a maximizer of $P$ on the unit sphere of $\mathcal W_n$. Record read: README, plan.md, routes.md (whole), results.md (whole), findings/INDEX*, conventions.md, second-order.md, nondegeneracy.md, target.md (Δ and $L_W$ sections), diagonal-half.md (Lemmas 68/99, Observation L98), ungraded-slack.md, fence posts 6, 27, 34–42, ATTEMPTS.md entries 124/125/F4/I19, references/INDEX.md and the Krasnov–Tkachev notes. Filed under budget close: item I10 carries one UNSCREENED sub-step, marked.

Conventions used below. $W$ unit, $Q(W)=\theta W$, $e=W/\theta$ the idempotent, $L_e=L_W/\theta$ on $e^\perp$; Lemma L24 (KT Prop 6.6): a maximizer has $\lambda_{\max}(L_e|_{e^\perp})=\tfrac12$ exactly, the orbit tangent inside $E(\tfrac12)$; excess $=\dim A(\tfrac12)-\dim(\text{orbit})$ (Lemma L51, post F37). $\Delta$ is the symmetry defect of conventions.md line 22, never Morse–Bott nondegeneracy. Two normalisation traps the executor must fix at the balanced product before trusting any number: the $\Lambda^2$ pairing is half the $n\times n$ Frobenius one (conventions.md lines 34–38), and the diagonal-locus Rayleigh form is stated in the $n\times n$ normalisation (diagonal-half.md line 147).

## Section 1, advance items, sorted by value

### I12 (value 4), the four-index certificate leaves the diagonal locus: at a maximizer every frame's diagonal part obeys a 4-tuple inequality

**Theorem it would produce.** We would be able to state that if $W$ is a maximizer then for every orthonormal frame of $\mathbb R^n$, with $M_{ab}=\langle W\varphi_{ab},\varphi_{ab}\rangle$ its frame-diagonal part, and every four distinct indices $a,b,c,d$:
$$\frac{M_{ac}+M_{ad}+M_{bc}+M_{bd}-2M_{ab}-2M_{cd}-\theta c^2/2}{4\theta\,(1-c^2/8)}\le\frac12,\qquad c=\langle N,W\rangle,\ N=uv^{\mathsf T}+vu^{\mathsf T},\ u=e_a-e_b,\ v=e_c-e_d,$$
(all in the $n\times n$ normalisation; the executor fixes the constant so that the balanced product gives exactly $\tfrac12$ with $a,b$ in one block and $c,d$ in the other at $q=3$, see step 5), and hence that every critical point violating it in some frame, whether diagonal or not, is excluded from the maximizer set. On the diagonal locus this is exactly Lemma L99's hand-checkable family, which certifies 10 of the 13 catalogued $\Delta>0$ diagonal points; off the locus it is new.

**Route.**
1. From diagonal-half.md line 149 (combinatorial proof of diagonal invariance: for frame-diagonal $R,S$, $(R\#S)_{\alpha\beta}\ne0$ forces $\alpha=\beta$): show that for frame-diagonal $N$ and ARBITRARY $W\in\mathcal W_n$, $\langle N,W\circ N\rangle$ depends only on the diagonal part $M$ of $W$ in that frame. Domain: all of $\mathcal W_n$, no criticality. Identity to derive (an hour): $\langle N,WN+NW\rangle=2\sum_\alpha N_\alpha^2 M_\alpha$ because $N$ is diagonal; $\langle N,W\#N\rangle$ involves only $W_{\beta\beta}$ entries because the bracket of two coordinate bivectors sharing one index is a coordinate bivector. Conclude $\langle N,L_WN\rangle=R_M(N)$ with $R_M(N)=\sum_{ij}M_{ij}N_{ij}^2+\mathop{\mathrm{tr}}(MN^2)$, the form diagonal-half.md line 147 proves on the locus.
2. Remove the admissibility constraint by projection: for any $N\perp$ nothing, $N'=N-cW$ with $c=\langle N,W\rangle$ satisfies $\langle N',L_WN'\rangle=\langle N,L_WN\rangle-\theta c^2$ and $\|N'\|^2=\|N\|^2-c^2$, using only $L_WW=W\circ W=\theta W$ (criticality, Lemma L0's setting). Zero row sums of $N$ (Ricci-flatness of the direction) hold for $uv^{\mathsf T}+vu^{\mathsf T}$ by inspection.
3. Evaluate $R_M$ on the family: $\sum_{ij}M_{ij}N_{ij}^2=2(M_{ac}+M_{ad}+M_{bc}+M_{bd})$, $N^2=2uu^{\mathsf T}+2vv^{\mathsf T}$ so $\mathop{\mathrm{tr}}(MN^2)=-4(M_{ab}+M_{cd})$, $\|N\|_F^2=8$. This reproduces Lemma L99's quotient $(M_{ac}+M_{ad}+M_{bc}+M_{bd}-2M_{ab}-2M_{cd})/(4\theta)$ WITHOUT using criticality of $M$, the point of the item: the formula never needed the diagonal locus, only that $N$ is frame-diagonal.
4. Apply Lemma L24 (domain: any local maximizer with $\theta>0$): the projected Rayleigh quotient is $\le\tfrac12$. That is the displayed inequality.
5. Screen by hand at the balanced product $S^q\times S^q$ (unit, vertex entries $-q/(q-1)$ within blocks, $1$ across, then normalised): with $a,b\in P$, $c,d\in Q$, $c=0$ and the quotient equals $1/(q-1)$, exactly $\tfrac12$ at $q=3$ (an $E(\tfrac12)$ direction of $S^3\times S^3$, consistent with its excess 9), $\tfrac13$ at $q=4$ (equal to Lemma L27's $\lambda_2=\tfrac12-\tfrac1{2(M-1)}$ there), $>\tfrac12$ at $q=2$ (the $p=2$ violation of nondegeneracy.md). Any constant that fails these three is wrong.
6. Off the locus: express the certificate's reach. $R_M$ is linear in $M$, so the best frame is the frame minimising off-diagonal mass (diagonality.md line 17, frame-minimal mass, never the constructor's frame). State the theorem in the form "a maximizer's frame-minimal diagonal part $M$ satisfies the 4-tuple inequality for every quadruple".
7. Link to $\Delta$: on the locus Lemma L68 gives $\Delta=0$ iff the positive graph is a union of twin cliques; show that a non-twin-clique positive graph always contains a quadruple with $M_{ac}+M_{ad}+M_{bc}+M_{bd}-2M_{ab}-2M_{cd}>2\theta$ OR identify the three exceptions of Observation L98 as exactly the quadruple-free ones. This sub-step is where the item's promotion to "no maximizer has $\Delta>0$" lives; it is combinatorial and hand-checkable at $n\le12$.

**Grade.** closes 2 (the theorem, with step 7, closes the $\{\Delta>0\}$ half of the $S=0$ stratum, the named open step V3/R10; without step 7 it is a sub-step, 1) × attackable 2 (the diagonal half of the route is spent and works (10 of 13) and R10's stall trigger "every object the route could name is equivariant" is cleared because a frame-diagonal $N$ is a non-equivariant test direction, exactly what R10's clearance criterion asks for; the off-locus lift and step 7 are untried) × margin 1 (off-locus cushion 1.107× at $\theta\approx1.08$ (r305 witnesses $\lambda_{\max}$ 0.6089, 0.5628, 0.5535); on the locus the floor $1+\tfrac1{2(n-3)(n-4)}$ is 2× above $\tfrac12$, but the family's quotient shrinks with the diagonal mass, so slack is real and finite) × analytic 1 (ends in a 4-tuple inequality on a matrix) $=4$.

**Fence-post screen.** Quantity bounded: $\lambda_{\max}(L_e)$ from below, by a Rayleigh quotient at an explicit frame-diagonal direction; information: the diagonal part of $W$ in one frame. Grep over findings/ for "diagonal part|frame-diagonal|Rayleigh": hits only inside diagonal-half.md (the locus formula, line 147; the invariance proof, line 149; the off-diagonal row-mass $F$ at line 276), the Rayleigh quotient at a diagonal $N$ for a NON-diagonal $W$ appears nowhere. R10's closure (equivariant blindness) names the mechanism it kills; this direction is frame-dependent, so R10 narrows but does not kill. Post F37 is irrelevant (no orbit-tangent claim). No recorded negative.

**Record screen.** Nearest: Lemma L99 and Observation L98 (diagonal-half.md 140–200), the same family, proved only for diagonal critical $M$ with the criticality of $M$ used in the derivation; the difference is that I12 shows the quotient formula needs no criticality of $M$ and so applies to the diagonal part of any critical $W$, with the projection correction $c$.

**Falsifier.** BLOCKED screen (seconds, on the three r305 witness points the record already stores): evaluate the certificate in their frame-minimal frame over all quadruples. Outcome "no quadruple exceeds $\tfrac12$" at all three: the item survives only on the locus and its neighbourhood, value falls to 2 and the theorem becomes a fence post ("the four-index family is blind at diagonal mass below $x$"). Outcome "some quadruple exceeds": the first hand-checkable exclusion of a non-diagonal critical point, worth recording as a lemma at once.

**Consumes / unblocks.** Consumes Lemma L24, Lemma L68, Lemma L99, diagonal-half.md line 149. Unblocks the R10 re-opening (its clearance criterion is met by construction) and gives R15's diagonal families a certificate that survives perturbation off the locus.

### I25 (value 3), the maximizer's spectral half-plane

**Theorem it would produce.** We would be able to state that at every maximizer with $n\ge5$, with $\lambda_{\max}>0>\lambda_{\min}$ the extreme $\Lambda^2$-eigenvalues of $W$: (i) $(n-2)\lambda_{\max}-|\lambda_{\min}|\ge\theta_0(n)$, with equality only at the balanced product; (ii) $|\lambda_{\min}|\le(n-2)\lambda_{\max}-\theta_0(n)$ and $\lambda_{\max}\ge\theta_0(n)(n-2)/((n-2)^2-1)$; (iii) $W$ has at least three negative eigenvalues; (iv) the number of positive eigenvalues is at least $1/(\lambda_{\max}((n-1)\lambda_{\max}-\theta_0(n)))$.

**Route.**
1. Lemma L70 (domain: every critical point, the deficiency identity $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D/|\lambda_{\min}|$, $D\ge0$) plus the competitor bound $\theta\ge\theta_0(n)$ at a maximizer (the balanced product is on the sphere): (i) in one line. Equality forces $D=0$ and $\theta=\theta_0$; Lemma L71 (domain $n\ge5$) turns that into the balanced product.
2. Lemma L73 (domain: all of $\mathcal W_n$): $\lambda_{\max}\le(n-2)|\lambda_{\min}|$. Combine with (i) for both halves of (ii).
3. Lemma L35 (domain: every $W$, dimension-free): at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}<\theta_0(n)$ for $n\ge12$; hence (iii) at a maximizer for $n\ge12$.
4. Trace-freeness and unit norm ($\sum\lambda=0$, $\sum\lambda^2=1$ in the $\Lambda^2$ normalisation): $1\le(\lambda_{\max}+|\lambda_{\min}|)\sum_{\lambda>0}\lambda$ and $\sum_{\lambda>0}\lambda\le N_+\lambda_{\max}$; insert (ii) for (iv).
5. Screen at the balanced product in the record's normalisation (Lemma L70 is verified there): (i) must be equality, (iii) holds with $\binom{q}{2}\cdot2$ negative eigenvalues.

**Grade.** closes 1 (a necessary condition on the maximizer's spectrum; it names no route's missing step) × attackable 3 (every sub-step is a filed lemma, the combination untried) × margin 1 (the half-plane is saturated exactly on the conjecture's equality set and nowhere else, by Lemma L71) × analytic 1 $=3$.

**Fence-post screen.** Quantity: the pair $(\lambda_{\min},\lambda_{\max})$ of a maximizer, bounded from $\theta\ge\theta_0$ and Lemmas 70/73/35. Grep "eliminate before reducing|spectral quantity|2.30": R14's closure says a bound on $\theta$ through $(\theta,\lambda_{\min},\lambda_{\max})$ ceilings at 2–2.3×$\theta_0$; I25 runs the inequality the other way (from $\theta\ge\theta_0$ to the spectrum), which R14 never attempted and which post F34/40 do not touch. No recorded negative.

**Record screen.** Nearest: Lemma L70 and Lemma L73 (results.md 556, 568). Difference: those are identities and inequalities at every critical point or every $W$; I25 is the first statement that uses $\theta\ge\theta_0(n)$, which holds only at a maximizer.

**Falsifier.** A catalogued high-$\theta$ non-maximizer (padded $W_{\mathbb{CP}^2}$ at $n=12$, $\theta=\sqrt{3/2}$) must FAIL (i), if it satisfies (i) the half-plane is too wide to be interesting and the item is worth a one-line remark only. Hand check: its spectrum is $(2,-1,-1)/\sqrt6$ padded, so $(n-2)\lambda_{\max}-|\lambda_{\min}|=(2(n-2)-1)/\sqrt6$, which at $n=12$ is $8.57>\theta_0(12)=1.236$: it PASSES. So (i) excludes nothing in the catalogue; the item's worth is (iii) and the equality characterisation. Graded accordingly at 3, no higher.

**Consumes / unblocks.** Nothing consumed beyond filed lemmas. Feeds the verification loop (the record has no maximizer-only statement yet) and the diagonal-families route R15 as a filter.

## Section 2, build items

### I10 (value 3, one sub-step UNSCREENED), tube exclusion around the padded $\mathbb{HP}^2$ orbit by Lemma L20's bootstrap

**Theorem it would produce.** We would be able to state that for $n\ge12$ no maximizer lies within angular distance $r$ of $SO(n).W_{\mathbb{HP}^2}$ (padded), $r$ explicit, by the mechanism of Lemma L20: inside the tube the exact cubic expansion about a local maximum with a transverse spectral gap forces $\max P\le\theta(\mathbb{HP}^2)=\sqrt{56/45}<\theta_0(n)$.

**Route.**
1. Lemma L20's proof (route-a.md) has three inputs: the orbit is a Morse–Bott nondegenerate local maximum with $\lambda_{\max}=\tfrac12$ exactly (target.md's saturating-set table gives this for $\mathbb{HP}^2$ and its padding, Observation L9 for strict local maximality); a transverse eigenvalue bound $\alpha<\tfrac12$ (Lemma L21's analogue); the inner trust-region estimate (Lemma L22), which is orbit-independent in form.
2. UNSCREENED: derive the transverse $\lambda_{\max}$ of $L_e$ at $\mathbb{HP}^2$ by Casimir arithmetic on the $Sp(2)Sp(1)$-isotypes of $e^\perp$ (the R12 template). This is the heavy step; if the gap is below the $1/3$ of Lemma L21 the trust-region frontier must be re-derived.
3. Run Lemma L22's two branches with $\theta^*$ replaced by $\sqrt{56/45}$ and $\alpha$ by the step-2 value; read off $r$.
4. Repeat for the unbalanced products $S^p\times S^q$, $p,q\ge3$, whose gap is $\tfrac1{2(M-1)}$ (Lemma L27): the radius decays like $1/n$ and the value ratio tends to 1, so record the family as a fence post rather than a theorem.

**Grade.** closes 1 (removes a tube; the complement is Conjecture D, R4 closed) × attackable 3 (the mechanism is proved once and untried elsewhere) × margin 1 ($\sqrt{56/45}/\theta_0(12)=0.90$; shrinks to 0 along the sphere-product family) × analytic 1 $=3$.

**Fence-post screen.** Quantity: $\max P$ on a tube, from a cubic expansion and a spectral gap. Grep "tube|localis|Conjecture D": R4 closed because Nienhaus's flip is structural at $\alpha=1/3$ and a successor "must not rest on $W_{\mathbb{CP}^2}$ remaining the maximizer"; I10 rests on nothing about $\mathbb{CP}^2$. No recorded negative for other orbits.

**Record screen.** Nearest: Lemma L20 (results.md 654). Difference: the orbit.

**Falsifier.** Step 2 returning a transverse eigenvalue at or above $\tfrac12$ off the orbit (positive excess) kills the item and contradicts the saturating-set table's "excess 0" for padded $\mathbb{HP}^2$, that would be a verification-loop finding worth more than the item.

**Consumes / unblocks.** Consumes Lemmas 20–22, Observation L9. Unblocks nothing named; produces a fence post per orbit.

## Section 3, decisive tests

### I30 (done by hand; a fence post), the extremal-idempotent calculus cannot exclude excess at a maximizer

**Statement.** In the two-dimensional metrised commutative algebra defined by the cubic $P(x,y)=x^3+\tfrac32xy^2$, the point $e=(1,0)$ is an idempotent ($T(e,e,\cdot)=\nabla P(e)/3=(1,0)$), it is the GLOBAL maximum of $P$ on the unit circle ($P(\cos t,\sin t)=\cos t\,(1+\tfrac12\sin^2t)$, derivative $-\tfrac32\sin^3t$), $L_e$ has eigenvalue exactly $\tfrac12$ on $e^\perp$ (Hessian of $P$ at $e$ is $\mathop{\mathrm{diag}}(6,3)$), the symmetry group is trivial so the orbit tangent is $0$ and the excess is $1$, the third-order term vanishes ($P(0,1)=0$), and the fourth-order term is $-\tfrac38\theta<0$ with $b=\Pi(f\circ f)=0$ for $f=(0,1)$, so the $B^+$ inequality of Lemma L51 holds strictly. Every identity of Lemma L24, Lemma L51 and post F37 is satisfied at a degenerate global maximizer.

**Consequence (what it is worth).** Any proof that a maximizer of Hamilton's cubic is Morse–Bott nondegenerate (the missing object of R11 and the "value-localised nondegeneracy" R12 wants), must use structure specific to $\mathcal W_n$ (the trace identities of Lemma L51's neighbours, the bracket, or Ricci-flatness). Proposed as a fence post: "nondegeneracy of a maximizer is not a consequence of the extremal-idempotent calculus; witness $x^3+\tfrac32xy^2$". Grade of the underlying advance item ("every maximizer is nondegenerate"): closes 1 × attackable 1 (plan.md line 49: five attacks failed on the excess question; the route must be invented with Weyl-specific input) × margin 1 × analytic 1 $=1$; not proposed as an item.

## Considered and rejected

- **Third moment / any moment count at a maximizer (candidate (a), and the Morse-type counts of the brief's item (iii)).** Post F6: the moment bound is the exact optimum of its own moment problem, 49.7× short at $n=12$; the third moment is not universal from $n=6$ (two independent cubic invariants); "the moment method stops at two". Adding $\lambda\le\tfrac12$ at a maximizer to the trace budget $\sum\lambda_i^2=\kappa_W/\theta^2\le n^2(2n-1)/(8(n-2))$ yields only lower bounds on eigenvalue counts ($N_-\gtrsim d^2/n^2$ with $d\ge\dim$ orbit), all far inside $\dim\mathcal W_n\sim n^4/12$. Killed.
- **$E(1)$ simple, $\circ$-indecomposability (candidate (b)).** On record: Lemma L24's "with 1 simple" gives $\dim E(1)=1$, which is Lemma L66 by a second proof. The sharper hand lemma (a maximizer's $E(1)$ contains no idempotent other than $0,e$: $f$ idempotent in $E(1)$ gives $g=e-f$ idempotent with $f\circ g=0$, a $\circ$-splitting) is a corollary already implied, and the fusion rule beyond the orbit needs positive excess, which by I30 the calculus cannot produce and which no Weyl point exhibits (post F37, R11). Dropped.
- **Morse–Bott / mountain-pass count limiting the maximizer's isotropy (brief item (iii)).** Morse–Bott inequalities on $S^{D-1}$ with $P_t=1+t^{D-1}$ bound the number of critical orbits from below; the maximum orbit's contribution $t^{D-1-\dim C}P_t(C)$ is cancelled against paired orbits ($P$ odd), so the theory constrains counts, never which orbit is the maximum. Equivariant refinements change the ground ring, not this. Record grep "Morse|mountain": only routes.md line 33. Killed by structure, no fence post needed.
- **"Must a maximizer be $\Delta>0$" (brief item (iv)).** The record's $\Delta$ is the symmetry defect; the wanted statement is the opposite ($\Delta=0$ at a maximizer with $S=0$, i.e. V3), which I12 attacks. On the Morse–Bott reading, I30 answers: the calculus cannot decide it.

## Where the region stands

Maximality's local content is exhausted on the record: Lemma L24 ($\lambda_{\max}=\tfrac12$ exactly), Lemma L51 and post F37 (third and fourth order are identities on the orbit tangent), and I30 shows the calculus alone cannot force the excess to vanish, so the second-order route has nothing further to give without Weyl-specific input. Its global content ($\theta\ge\theta_0(n)$ and the bootstrap of Lemma L20), has been used exactly once each; I25 and I10 spend them a second time, for a spectral half-plane and a tube, neither of which closes a named step. The one item with reach is I12, because it converts the diagonal locus's only working violation certificate into a frame-dependent, non-equivariant test that R10's closure explicitly asked for and never received.

## Doubtful record claims (verification-loop candidates)

- second-order.md 287–301: "$E(1)$ is a subalgebra" is measured (leakage $5\times10^{-15}$), never proved; the text around it reads as if proved.
- ungraded-slack.md: $S=0$ is a hypothesis of the target band and the record nowhere proves $S=0$ at a maximizer; several passages in target.md use "at a maximizer, $S=0$" as if established.
- diagonal-half.md 155: the padded $S^4\times S^4$ at $n=9$ is "disconnected by the record's own criterion" yet has $\lambda_{\max}=0.5714$; Lemma L99's hypothesis (admissible $N$ with $\mathcal LN=\theta N$) must exclude paddings explicitly, and results.md's statement of Lemma L99 should say so.
- results.md Lemma L24's statement omits the hypothesis $\theta>0$ (KT's extremal idempotent), on which the sign of the Hessian $6\theta(L_e-\tfrac12)$ depends.
- The saturating-set table (target.md 548–632) lists padded $\mathbb{HP}^2$ at $n=10,12$ with excess 0 on numerical evidence; I10's step 2 would prove or refute it.
- r305's two off-diagonal $\Delta>0$ witnesses are approximate critical points (residual $10^{-11}$); their $\lambda_{\max}$ values 0.5628 and 0.5535 sit within $0.06$ of $\tfrac12$, so the "cushion 1.107×" is a numerical, not a proved, margin.
