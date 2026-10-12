# Reviewer r422, Gate 2 on Lemma L134

**Verdict: PLAUSIBLE.** Parts (a), (b) and (c) survive a rebuild from the definitions; part (d) is **false as written** and the correction changes what the next item has to prove. The lemma's headline (*the $P$-side is done and I3 reduces to one bound on the defect*), is right in substance and wrong in scope: the reduction holds on the normal slice, not on all of $\{F=0\}$.

*Worked under the analysis-only rule ([.claude/rules/analysis-only.md](../.claude/rules/analysis-only.md)). One arithmetic screen was run (five lines evaluating $\theta_0(n)$, $\kappa_n$ and the three quoted thresholds) because the claims under review are decimal figures and no argument decides a rounding. Everything else here is derivation.*

## The claim list and the per-claim verdict

| claim | verdict |
| --- | --- |
| (a) $\tfrac12\mathrm{Hess}(P\vert_S)_u[H,H]=3\theta^*(\langle L_eH,H\rangle-\tfrac12)\le-\theta^*/2$ for $H\perp T_u\mathcal O$ | **CONFIRMED**, with one caveat the lemma drops |
| (b) $\tfrac12\Phi''(0^+)\le-\theta^*/2+\lvert\kappa_n\rvert c_2$, threshold $\theta^*/(2\lvert\kappa_n\rvert)$, $6.03\to0.3591$ | **CONFIRMED** as an inequality; three hypothesis/strictness corrections |
| (c) padded flat: $c_2=\delta^2(H)-\tfrac19\le\tfrac5{36}$, $\langle L_eH,H\rangle=0$, margin $\tfrac32\theta^*$ | **CONFIRMED**, every step, from the definitions |
| (d) I3 reduces to $c_2\le\tfrac5{36}$ on $\{F=0\}$, the $P$-side owing nothing further | **REFUTED as stated**; repairable, and the repair rewrites the next item |
| the numbers | **CONFIRMED** except $0.2369$ (is $0.2368$) and $1.7053$ (is $1.7052$) |

## 1. The identification $F_u=\theta^*L_e$, no factor of two, and the normalisation is genuinely pinned

The polarisation is correct as written. With $\#$ extended to the symmetric bilinear map $X\#Y=\tfrac12((X+Y)^\#-X^\#-Y^\#)$, so that $X\#X=X^\#$, one has $Q(X+Y)-Q(X)-Q(Y)=XY+YX+2X\#Y$, hence $X\circ Y=\tfrac12(XY+YX)+X\#Y$. That is exactly the $F_u$ of [Lemma L20](../findings/route-a.md), so $F_u=u\circ(\cdot)=\theta^*L_e$.

Both normalisation checks the lemma cites hold, and a third is available on the record's own table.

- $F_uu=u^2+u^\#=Q(u)=\theta^*u$, using criticality. So $L_ee=e$.
- The universal $\tfrac12$ on the orbit is a one-line consequence of equivariance rather than an observation: differentiating $Q(g\!\cdot\!u)=g\!\cdot\!Q(u)=\theta^*g\!\cdot\!u$ along $g=\exp(tA)$ gives $DQ_u([A,u])=\theta^*[A,u]$, and $DQ_u=2F_u$ because $Q$ is quadratic, so $F_u[A,u]=\tfrac12\theta^*[A,u]$. This is also why [Lemma L24](../findings/second-order.md)'s remark that "the orbit directions are exact $\tfrac12$-eigenvectors" needs no hypothesis beyond criticality.
- The table itself settles the normalisation independently: its trivial block lists $1$ with multiplicity $1$, which can only be $u$, so the column really is $\operatorname{spec}(F_\lambda)/\theta^*$ and not a half or double of it. The record's separate statement $\ker(6F_u-3\theta^*)=T_u(SO(n).u)$ reads the same way.

**This attack fails.** A factor of two anywhere would break all three checks at once, and the record's own factor-of-two trap (the $\tfrac12(Q(x+y)-Q(x-y))=2T$ note further down [route-a.md](../findings/route-a.md)) is a different polarisation from the one used here.

The Hessian identity is also independently re-derivable, and I did so rather than trusting the citation. Along $\gamma(t)=\cos t\,u+\sin t\,H$ with $\lVert H\rVert=1$, $H\perp u$, the cubic form gives exactly $P(\gamma)=\theta^*\cos^3t+3\cos t\sin^2t\,\langle F_uH,H\rangle+\sin^3t\,P(H)$, whose $t^2$ coefficient is $-\tfrac32\theta^*+3\theta^*\langle L_eH,H\rangle=3\theta^*(\langle L_eH,H\rangle-\tfrac12)$. That is (a)'s left-hand side.

**One citation check the brief asked for, and it passes.** [Lemma L24](../findings/second-order.md) states the Hessian identity under *criticality with $\theta>0$* and only the eigenvalue bound under *maximality*. L134 uses the identity and calls $u$ critical, which is inside L24's domain. This matters because $u$ is **not** a maximiser for $n\ge12$; had the identity been stated at maximisers, the citation would have been the record's own named fence-post error ([fence-posts.md](../findings/fence-posts.md): "Lemma L24 read off non-critical points"). It is not.

## 2. The $\tfrac13$ bound's scope, right for $n\ge12$, but the lemma drops the record's own caveat

The four-block computation does give $\lambda_{\max}(L_e)\le\tfrac13$ on $u^\perp\cap T_u\mathcal O^\perp$, and the internal arithmetic is consistent.

- Multiplicities sum correctly inside each block: $2+6+6+3+2+1=20$ (trivial), $4+12+4=20$ (vector), $2+3+1=6$ ($\Lambda^2$), $6+1+3=10$ ($S^2_0$).
- $\dim V_\lambda$ are the right functions of $n$: $n-4$, $\binom{n-4}2$, $\tfrac{(n-4)(n-3)}2-1$, matching $6/8/10$, $15/28/45$, $20/35/54$ at $n=10/12/14$.
- Deleting $\mathbb Ru$ (the single $1$) and the orbit (the $\tfrac12$'s) leaves top $\tfrac13$ in the trivial, $\Lambda^2$ and $S^2_0$ blocks and top $0$ in the vector block. The vector block's $0$ is handled correctly, and $0\le\tfrac13$, so it does not weaken the bound. The bound is attained, in three blocks.
- $L_e$ is self-adjoint and both $\mathbb Ru$ and $T_u\mathcal O$ are eigenspaces, so $u^\perp\cap T_u\mathcal O^\perp$ is $L_e$-invariant and the Rayleigh bound $\langle L_eH,H\rangle\le\tfrac13$ follows from the spectral statement. No extra hypothesis is smuggled in there.

**Correction 1, the caveat.** L134's proof of (a) says the computation "reaches it with no multiplicity-free hypothesis and identically in $n$". The first half is right and is the real advance over Nienhaus Theorem 4.14, whose Schur step needs multiplicity-freeness. The second half is stronger than what [route-a.md](../findings/route-a.md) itself claims twelve lines above L134: *"The remaining formal obligation is a proof that the stable range begins at $n-4\ge8$ rather than a check at two dimensions."* The blocks were computed at $n=10,12,14$; of those only $12$ and $14$ lie in the asserted stable range, and $n=10$ is offered as corroboration. So (a) at $n\ge16$ rests on (i) the stability of the $SO(n-4)$-decomposition of $\bigotimes^{k\le4}\mathbb R^{n-4}$ for $n-4\ge8$, which is standard, and (ii) the $n$-independence of the operators $F_\lambda$ themselves, which is an observation at three dimensions rather than a derivation, $\#$ contracts over all $n$ indices, so $n$-independence of the blocks is the thing to prove, not to assume. **(a) should carry that obligation explicitly**, since L134 is the row at which the $\tfrac13$ figure is being promoted from a tube estimate to a Hessian bound "at every $n$".

This is not vacuous: it is the only place where L134's "identically in $n$" claim could fail, and Nienhaus's independent route ($n\ge9$) is gapped in a different place, so the two do not cover each other.

## 3. Whether the orbit is the whole $\tfrac12$-eigenspace, yes here, and the record is right to make a point of it

The lemma needs no non-orbit direction at $\tfrac12$, because a $\tfrac12$-direction off the orbit would carry $\tfrac12\mathrm{Hess}=0$ and destroy (a). The counting works.

$$\operatorname{mult}(\tfrac12\theta^*)=\underbrace{2\cdot\dim V_{\mathrm{triv}}}_{2\cdot1}+\underbrace{4\cdot\dim V_{\mathrm{vec}}}_{4(n-4)}=4n-14=\dim T_u\mathcal O,$$

so the brief's worry ("$\tfrac12$ with multiplicity $2$ and multiplicity $4$, do these sum to $4n-14$?") dissolves once the $\dim V_\lambda$ factor is carried: the vector type occurs $n-4$ times. And $\dim T_u\mathcal O=4n-14$ is itself derivable rather than measured, $\mathfrak{so}(4)/\mathfrak{stab}_4$ has dimension $6-4=2$ ($u$ is self-dual with spectrum $\propto(2,-1,-1)$, so its $SO(4)$-stabiliser is $SO(2)\times SO(3)_-$), and $\mathbb R^4\otimes\mathbb R^{n-4}$ contributes $4(n-4)$, with $\mathfrak{so}(n-4)$ stabilising. Since $T_u\mathcal O\subseteq E(\tfrac12\theta^*)$ always, equal dimensions force equality, block by block.

**This is load-bearing and the record knows it.** [second-order.md](../findings/second-order.md) records the general relation as an *inequality*, $\operatorname{mult}(\tfrac12)\ge\dim\mathcal O$, with $S^3\times S^3$ as the witness where it is strict ($18$ against $9$). So the coincidence at $u$ is a fact about $u$, supplied by the block table, and it inherits §2's caveat along with everything else the table supplies.

## 4. Step (b)'s expansion, the inequality is right; three corrections to the statement

**The expansion is legitimate, and one-sidedness costs nothing.** $\gamma(t)$ is real-analytic in one real parameter, so by Rellich's theorem the eigenvalues and spectral projections of $\gamma(t)$ admit analytic branches through $t=0$. For small $t>0$ the set of branches that are negative is constant, so $\gamma(t)_-$ (and therefore $\delta^2(\gamma(t))=\lVert\mathrm{Alt}(\gamma(t)_-)\rVert^2$), is real-analytic on $(0,\varepsilon)$ with a one-sided analytic extension to $0$. **There is no $t^2\log t$ term and no genuine $\lvert t\rvert^3$ obstruction**, and $c_2$ is a bona fide one-sided second derivative. The lemma asserts the expansion without this; the justification is short and should be in the proof, because "one-sided" is exactly the thing a reader will stop at.

The geodesic parametrisation introduces nothing the lemma drops. $P(\gamma)$ is exactly cubic, and its $t^3$ coefficient is $P(H)$, which is bounded and harmless whenever the $t^2$ coefficient is strictly negative.

**Correction 2, hypotheses missing from the display.** As displayed, (b) carries neither $H\perp T_u\mathcal O$ (needed to substitute (a)) nor $H\in\{F=0\}$ (needed to kill the linear term). Both appear only in the proof. Given that (d) is read off (b), the omission is what lets (d) over-reach; see §6.

**Correction 3, strictness.** "I3 holds at $H$ as soon as $c_2\le\theta^*/(2\lvert\kappa_n\rvert)$" should be a strict inequality, or should say that at equality the $t^3$ term decides. At equality the second-order coefficient is $0$ and the expansion gives no sign.

**Correction 4, the remainder is $o(t^2)$, not $O(t^3)$, unless the Rellich argument is made.** Written with the analyticity in hand, $O(t^3)$ is correct; written as it stands, the honest symbol is $o(t^2)$. Either is enough for the conclusion at strict inequality.

**The threshold's direction is right.** $\theta_0(n)^2=2(1-3/n+2/n^2)$ is increasing in $n$, so $\lvert\kappa_n\rvert=9(\theta_0(n)-\theta^*)$ increases to $9(\sqrt2-\sqrt{3/2})$ and $\theta^*/(2\lvert\kappa_n\rvert)$ decreases to its limit. "The limit being the binding case" is correct, and the limit is a supremum never attained, so a bound $c_2\le0.3591$ suffices at every finite $n\ge12$.

## 5. Step (c), confirmed at every step, with one overstatement in the surrounding prose

Every ingredient checks out from the definitions, and two of them are stronger than the lemma's citation of them.

- **The block structure.** $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^4\oplus(\mathbb R^4\otimes\mathbb R^{n-4})\oplus\Lambda^2\mathbb R^{n-4}$, and $u$, $H$ occupy the first and third summands as operators, killing everything else. So $\gamma(t)$ is block-diagonal with a zero middle block, and for $t\in(0,\pi/2)$ both coefficients are positive, giving $\gamma(t)_-=\cos t\,u_-\oplus\sin t\,H_-$. **Alt respects the splitting for the trivial reason**, it is linear, and the Bianchi cyclic sum permutes the first three indices among themselves, so it preserves each index-support. Hence $\mathrm{Alt}(\gamma_-)=\cos t\,\mathrm{Alt}(u_-)+\sin t\,\mathrm{Alt}(H_-)$ with the two summands orthogonal, and $\delta^2(t)=\cos^2t\cdot\tfrac19+\sin^2t\cdot\delta^2(H)$ exactly. So $c_2=\delta^2(H)-\tfrac19$. The direct-sum rule is genuinely applicable here; the brief's doubt does not bite.
- **$\delta^2\le\tfrac14$ is elementary and applies to the padded $H$.** For Bianchi $W$, $\mathrm{Alt}(W)=0$ and $\lvert W\rvert=W_++W_-$ give $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$, so $\delta^2=\tfrac14\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2\le\tfrac14\lVert W\rVert^2=\tfrac14$ since $\mathrm{Alt}$ is an orthogonal projection. Padding preserves norm, Ricci-flatness, Bianchi and $\mathrm{Alt}$, so the bound transfers verbatim to a unit Weyl tensor of $\mathbb R^{n-4}$ sitting in $\mathrm{Weyl}_n$. $\tfrac14-\tfrac19=\tfrac5{36}$.
- **$\langle L_eH,H\rangle=0$ is provable, not merely plausible.** $uH=Hu=0$ because each operator annihilates the other's range, and $u\#H=0$ because $\mathfrak{so}(4)$ and $\mathfrak{so}(n-4)$ are commuting subalgebras of $\mathfrak{so}(n)$: in [ATTEMPTS.md](../ATTEMPTS.md)'s form $\langle(A\#B)\phi,\psi\rangle=-\tfrac14[\operatorname{tr}(\mathrm{ad}(\phi)A\,\mathrm{ad}(\psi)B)+\ldots]$, every composite $\mathrm{ad}(\phi)\,u\,\mathrm{ad}(\psi)\,H$ vanishes case by case on the three summands. So $T(u,H,H)=0$ and the margin is $\tfrac32\theta^*=1.8371$, as claimed.
- **This also recovers the record's earlier figure exactly.** [ATTEMPTS.md](../ATTEMPTS.md)'s Result 6 addendum already carries $(\Phi(t)-\theta_0)/t^2=-\tfrac32\theta-\kappa_{12}(\delta^2(H)-\tfrac19)$ per direction, "to truncation precision". (c) is that identity with the truncation removed, so "supersedes the $18\times$ figure" is fair.

**Correction 5, "$\tfrac5{36}$ is exactly what the padded flat attains" is false.** The sentence is in "What is left", and [plan.md](../plan.md)'s I3 item repeats it as the reason $\tfrac5{36}$ is the candidate. $\tfrac5{36}$ is what the *unconditional ceiling* $\delta^2\le\tfrac14$ yields; what the padded flat attains is $\max\{\delta^2:H\in\mathrm{Weyl}_{n-4},\lVert H\rVert=1\}-\tfrac19$, and [ATTEMPTS.md](../ATTEMPTS.md) records those maxima as $0.125$ at ambient $8$ and $0.145$ at ambient $12$, so the padded flat attains about $0.014$ at $n=12$ and $0.034$ at $n=16$, an order of magnitude under $\tfrac5{36}$. The candidate $\tfrac5{36}$ is a defensible target because it is the ceiling, and [Lemma L135](../findings/route-a.md) states the reason correctly ($\Delta_2\le\tfrac14$ *is* the ceiling asked of a coefficient). L134's wording should match L135's.

## 6. Step (d), REFUTED as stated: the orbit-component directions are not covered

This is the finding. (a) is hypothesised on $H\perp T_u\mathcal O$; (d) drops the hypothesis and quantifies over all $H\in\{F=0\}$. The two are not the same set, and the gap between them is exactly where the $P$-side margin lives.

**The quantitative statement.** $L_e$ is self-adjoint on $u^\perp$ and $T_u\mathcal O$ is precisely its $\tfrac12$-eigenspace there (§3), so $T_u\mathcal O$ and its complement in $u^\perp$ are both $L_e$-invariant and the cross term vanishes. Writing a unit $H\in T_uS$ as $H=aH_{\mathcal O}+bH_\perp$ with $a^2+b^2=1$,

$$\langle L_eH,H\rangle=\tfrac12a^2+b^2\langle L_eH_\perp,H_\perp\rangle\le\tfrac12a^2+\tfrac13b^2=\tfrac12-\tfrac{b^2}6,$$

$$\tfrac12\mathrm{Hess}(P\vert_S)_u[H,H]\;\le\;-\,b^2\,\frac{\theta^*}2,\qquad b^2=\lVert\Pi_{T_u\mathcal O^\perp}H\rVert^2 .$$

**So the $P$-side margin is not uniform over $\{F=0\}$; it is proportional to the squared normal component, and it vanishes on the orbit.** The sufficient condition of (b) becomes $c_2(H)\le b^2\,\theta^*/(2\lvert\kappa_n\rvert)$, which at $b=0$ reads $c_2(H)\le0$.

**And the orbit tangents are inside $\{F=0\}$.** [Lemma L17](../findings/route-a.md) names its equality set as the competitor's own orbit, the hyper-Kähler rotations and the padded flat; [ATTEMPTS.md](../ATTEMPTS.md)'s Result 6 records $F$ vanishing to $10^{-13}$ on explicitly constructed orbit tangents. So the failure set is non-empty and is exactly the set the lemma's own first-order input singles out, the finding is not vacuous.

**The consequence for (d).** Grant its hypothesis in full: $c_2(H)\le\tfrac5{36}$ for every $H\in\{F=0\}$. At $H\in T_u\mathcal O$ the conclusion (b) then delivers is $\tfrac12\Phi''(0^+)\le0+\lvert\kappa_n\rvert\cdot\tfrac5{36}\le+0.2368$, which is positive and decides nothing. **The stated reduction is therefore not sufficient**, and the sentence "the $P$-side contributing no further obligation at any $n$" is the part that fails: at orbit-component directions the $P$-side contributes no *margin*, so the whole obligation lands on $c_2$ at a threshold of $0$ rather than $\tfrac5{36}$.

**The same applies to the retirement of the mixed-direction case.** The record's "mixed directions" ([ATTEMPTS.md](../ATTEMPTS.md), the $100$-direction run) are those whose support meets both the distinguished $4$-plane and its complement, and $4(n-4)$ of the orbit's $4n-14$ dimensions are precisely the $\mathbb R^4\otimes\mathbb R^{n-4}$ block, i.e. the orbit is *inside* the mixed region. So the claim in "What this replaces" that "the mixed directions are not a separate case", and [ATTEMPTS.md](../ATTEMPTS.md)'s "there is no mixed-direction case", are wrong in the same way: (a) supersedes the fans at mixed directions *orthogonal to the orbit*, and says nothing at mixed directions with an orbit component. The lemma's own earlier sentence ("(a) … holds in every direction off the orbit"), is the correct scope, and (d) contradicts it.

**Two repairs, both short, and they say different things about the next item.**

- **Repair A, the slice.** $\Phi=P-\kappa_n\delta^2$ is $SO(n)$-invariant, since $P$ is and $\delta^2$ is ($W\mapsto W_-$ and $\mathrm{Alt}$ are $O(n)$-equivariant, $\lVert\cdot\rVert$ invariant). By the slice theorem a neighbourhood of $u$ is $SO(n)\cdot S_\varepsilon$ for a geodesic slice $S_\varepsilon$ normal to $\mathcal O$, and the slice's geodesics through $u$ are exactly the curves $\cos t\,u+\sin t\,H$ with $H\perp T_u\mathcal O$. So $\Phi\le\theta_0$ near $u$ follows from the slice alone, and **the honest reduced obligation is $c_2(H)\le\tfrac5{36}$ on $\{F=0\}\cap T_u\mathcal O^\perp$**, strictly weaker than what (d) asks for. (d) over-claims and over-asks at once.
- **Repair B, direct.** On a pure orbit direction the coefficient is nonpositive for a recorded reason. With $H_{\mathcal O}=[A,u]$ of unit norm, $\gamma(t)=\exp(tA)u+\tfrac{t^2}2V+O(t^3)$ with $V=-u-[A,[A,u]]$, and $\langle V,u\rangle=0$ because $\langle[A,[A,u]],u\rangle=-\lVert[A,u]\rVert^2=-1$. Since $\delta^2$ is constant on the orbit, $c_2(H_{\mathcal O})=\tfrac12\,(d^+\delta^2)_u[V]$, and [ATTEMPTS.md](../ATTEMPTS.md)'s Result 3 records $\delta^2(t)\approx\tfrac19-c\lvert t\rvert$ *in every tangent direction* ($u$ is a local maximiser of the defect on $S$) so $(d^+\delta^2)_u[V]\le0$ and $c_2(H_{\mathcal O})\le0$.

Repair A is the one to take, because it also shrinks the target set. Either way, **(d) as printed should be withdrawn and restated on $\{F=0\}\cap T_u\mathcal O^\perp$**, with the invariance step written down.

## 7. A second gap in (d): the passage from a direction to a radius

(b) is a statement about one direction's second-order coefficient. I3, as [plan.md](../plan.md) defines the scenario constants, is a *local* statement, "α and β make the two local scenarios explicit radii". Converting a direction-wise negative second-order coefficient into $\Phi\le\theta_0$ on a ball requires the $o(t^2)$ remainder to be uniform over the direction sphere, and $\Phi$ is not $C^2$ at $u$: the branch structure of $\gamma(t)_-$ changes with $H$, and [Lemma L135](../findings/route-a.md) already names the mechanism, the derivative of $N\mapsto N_-$ at $D=P_0HP_0$ "exists only where $D$ is nonsingular on $K$". Near such $H$ the third-order control degrades, so uniformity is a real obligation rather than a formality.

**The record holds the sibling item to this standard and this one to a lower one.** [plan.md](../plan.md)'s I2 is stated *with an explicit radius*, and its one remaining sub-step (iii) is exactly "the third-order remainder, hence the radius $r_n$". L134(d) claims I3 "is reduced to a single statement about the defect alone" with no analogue of (iii) anywhere. **(d) should name the remainder step as a second outstanding obligation**, and it is harder on the β side than on the α side, since $\delta^2$ has no third derivative at $u$ to bound.

One thing that does *not* need extra work, worth recording positively: the two-sided requirement is free. If $F(-H)>0$ then the first order already gives $d^+\Phi<0$ along $-H$, so only $H$ with $F(H)=F(-H)=0$ need a second-order argument, and those are covered by the same statement applied twice.

## 8. The numbers

Screened by direct evaluation of $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ and $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$.

| quantity | lemma | computed | verdict |
| --- | --- | --- | --- |
| $\theta^*/2$ | $0.6124$ | $0.61237244$ | correct |
| $\lvert\kappa_{12}\rvert$ | $0.10159$ | $0.10159390$ | correct |
| $\theta^*/(2\lvert\kappa_{12}\rvert)$ | $6.03$ | $6.02765$ | correct |
| $\sup_n\lvert\kappa_n\rvert=9(\sqrt2-\sqrt{3/2})$ | $1.705218$ | $1.70521822$ | correct |
| $\theta^*/(18(\sqrt2-\sqrt{3/2}))$ | $0.3591$ | $0.35911676$ | correct |
| $\tfrac14-\tfrac19$ | $\tfrac5{36}=0.1389$ | $0.13888889$ | correct |
| $\tfrac32\theta^*$ | $1.837$ | $1.83711731$ | correct |
| $\lvert\kappa_n\rvert\cdot\tfrac5{36}$ in (c) | $1.7053\cdot\tfrac5{36}=0.2369$ | $0.2368359$ | **both digits off** |

**Correction 6.** In (c), $1.7053$ should be $1.7052$ and $0.2369$ should be $0.2368$. The proof of (b) already carries the corrected $1.705218$, so (c) is out of step with its own proof. Nothing depends on it, the comparison is against $1.8371$ and the margin is a factor of $7.76$, but the two displays should agree.

Every inequality direction checks out: $\lvert\kappa_n\rvert$ increases in $n$ so the threshold decreases and the limit binds; $0.2368<0.6124<1.8371$; and $\tfrac5{36}$ clears the asymptotic threshold $0.3591$ by a factor of $2.59$.

## Corrections, collected

1. **(a)**, add the stable-range obligation: the four-block spectra are computed at $n=10,12,14$ and the $n$-independence of the blocks $F_\lambda$ (as against the $SO(n-4)$-decomposition) is observed rather than derived. [route-a.md](../findings/route-a.md) carries this caveat twelve lines above L134; L134's proof drops it.
2. **(b)**, carry $H\perp T_u\mathcal O$ and $H\in\{F=0\}$ into the displayed statement.
3. **(b)**, make the threshold inequality strict, or say the $t^3$ term decides at equality.
4. **(b)**, justify the $t^2$ expansion by Rellich analyticity of the one-parameter family $\gamma(t)$; without it the remainder is $o(t^2)$.
5. **(c) / "What is left" / [plan.md](../plan.md)**, $\tfrac5{36}$ is the unconditional ceiling $\delta^2\le\tfrac14$ minus $\tfrac19$, and the padded flat attains about $0.014$ at $n=12$. [Lemma L135](../findings/route-a.md) states the reason for the target correctly; L134 should match it.
6. **(c)**, $1.7053\to1.7052$, $0.2369\to0.2368$.
7. **(d), withdraw and restate.** The reduction holds on $\{F=0\}\cap T_u\mathcal O^\perp$, by $SO(n)$-invariance and the slice theorem; on all of $\{F=0\}$ it is false, because $\tfrac12\mathrm{Hess}(P\vert_S)_u[H,H]\le-b^2\theta^*/2$ with $b$ the normal component, and $T_u\mathcal O\subseteq\{F=0\}$.
8. **(d)**, add the remainder/radius obligation, the analogue of I2's sub-step (iii), and note it is harder here because $\delta^2$ is only one-sided at $u$.
9. **Downstream.** [ATTEMPTS.md](../ATTEMPTS.md)'s "there is no mixed-direction case" and L134's "the mixed directions are not a separate case" both need the same repair, the orbit lives inside the mixed block, so mixed directions with an orbit component are precisely what (a) does not reach. And [plan.md](../plan.md)'s falsifier clause ("a direction in $\{F=0\}$ with $c_2>\theta^*/(2\lvert\kappa_n\rvert)$ refutes [Conjecture L16](../findings/problem.md)") is the same conflation read backwards: $\theta^*/(2\lvert\kappa_n\rvert)$ comes from an *upper* bound on the $P$-side, so exceeding it refutes nothing on its own.

## What survives

The lemma's substantive advance stands. The $\tfrac13\theta^*$ spectral gap really is $\lambda_{\max}(L_e)\le\tfrac13$ off the orbit, [Lemma L24](../findings/second-order.md) really does turn that into $\tfrac12\mathrm{Hess}(P\vert_S)_u\le-\theta^*/2$ there, uniformly in $n$, and the padded flat really does close in closed form with an exact identity replacing the measured $18\times$. That is a bound where the record had three numerical fans, and it is the right kind of object. What it does not yet do is reduce I3 to one inequality: it reduces the *normal* directions to one inequality, and leaves the invariance step and the remainder step to be written.
