# Gate 2 brief: is the fourth-shape lever the record's own higher-variation calculus, and is it vacuous where R28 needs it?

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the working note this block was drawn from, do not import the scripts under review, and do not read the other reviewer's report. Your independence comes from your implementation, not from your instructions.

**This round audits a CLASSIFICATION and a VACUITY claim, and they fail differently.** The classification says a newly found lever is an old apparatus transported from another functional. The vacuity claim says that lever has no hypothesis to act on at three specific points. A classification can be right in its correspondence and wrong in what it carries across, which is the failure mode that already fired here once.

## The setting, as a given

$\hat U,V$ are real traceless symmetric $3\times3$ matrices, and

$$\Phi(\hat U,V)=\alpha\mathop{\mathrm{tr}}\hat U^3+\beta\mathop{\mathrm{tr}}(\hat UV^2)+\langle\hat U,A\rangle+\langle V,C\rangle,\qquad\alpha=\tfrac{15}4,\ \beta=\tfrac94,$$

with $T=\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2$ the constraint. The Lagrange fields, **given and not under review**, are $A\equiv3\mu\hat U-3\alpha\hat U^2-\beta V^2$ and $C\equiv\mu V-\beta\{\hat U,V\}$, each up to a multiple of $I$. **$A$ and $C$ are FIXED matrices in $\Phi$**, not functions of the point at which $\Phi$ is evaluated.

**Given, from batch 21, verbatim from the record.** At every local maximum, for all traceless symmetric $X,Y$ with $3\mathop{\mathrm{tr}}(\hat UX)+\mathop{\mathrm{tr}}(VY)=0$,
$$6\alpha\mathop{\mathrm{tr}}(\hat UX^2)+4\beta\mathop{\mathrm{tr}}(XVY)+2\beta\mathop{\mathrm{tr}}(\hat UY^2)\ \le\ \mu\big(3\lvert X\rvert^2+\lvert Y\rvert^2\big).$$

**Given, the great-circle identity, validated at $2.3\cdot10^{-13}$ over $4000$ critical points.** Along $\gamma(\theta)=\cos\theta\,p+\sin\theta\,Z$ with $Z$ tangent and $\lVert Z\rVert=\lVert p\rVert$, writing $c=\cos\theta$, $s=\sin\theta$, $p=(\hat U,V)$ and $Z=(X,Y)$,

$$\Phi(\gamma(\theta))-\Phi(p)=-\tfrac12\Phi(p)(c-1)^2(c+2)+\tfrac12cs^2Q(Z)+s^3\big(\Xi(Z)-S(Z)\big),$$

where **$Q$ is batch 21's expression INCLUDING its $-\mu(3\lvert X\rvert^2+\lvert Y\rvert^2)$ term**, $\Xi(Z)=\alpha\mathop{\mathrm{tr}}X^3+\beta\mathop{\mathrm{tr}}(XY^2)$ is the cubic form at the direction, and $S(Z)=-(\langle A,X\rangle+\langle C,Y\rangle)$, checked to $1.1\cdot10^{-13}$.

**Given, from batch 33**: $\Phi$ VARIES along the conjugation orbit $X=[\Omega,\hat U]$, $Y=[\Omega,V]$, through the term $\langle\hat U,A\rangle+\langle V,C\rangle$.

**Given, from batch 35**: three non-commuting critical points clear batch 18, batch 21 and batch 33's orbit bound together, $(1,-3,2)$ with $\mu=11.60060$, $(-1,-3,4)$ with $\mu=24.43870$, and $(19,-20,1)$ with $\mu=762.38453$.

**Given, the record's own higher-variation calculus, quoted verbatim from [second-order.md](../findings/second-order.md), reviewers 287 and 288.** This is stated for a DIFFERENT functional: $P$ on $\mathcal W_n$, with $T(x,y,z)=\langle x\circ y,z\rangle$ fully symmetric, $W$ a unit critical point, $\theta=P(W)>0$, $L_W$ the multiplication operator, $B:=\tfrac\theta2-L_W$, and $A(\tfrac12):=\ker B\cap W^\perp$.

> for $z\in A(\tfrac12)$ of unit norm, $w\perp W$, and $\gamma=x/\lvert x\rvert$ with $x(t)=W+tz+\tfrac{t^2}2w$,
> $$[t^3]\,P(\gamma)=T(z,z,z),\qquad [t^4]\,P(\gamma)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}8 .$$

> **The CHORDAL quartic, the coefficient in the parameter of $x=W+tz$, is $-\tfrac92\langle L_Wz,z\rangle+\tfrac{15}8\theta$**, hence $-\tfrac{3\theta}8$ on the whole null cone of $B$, not only on eigenvectors.

> **The orbit identity, which is what makes the apparatus vacuous along the orbit.** Differentiating $Q(e^{tX}\!\cdot\!W)=\theta\,e^{tX}\!\cdot\!W$ twice, with $z=X\!\cdot\!W$ and $u=X^2\!\cdot\!W$: $B\,u=z\circ z$, and the first derivative gives $L_Wz=\tfrac\theta2z$, so **the orbit tangent lies in $A(\tfrac12)$ with no hypothesis at all**. Three consequences, none needing maximality: $T(z,z,z)=0$ on the orbit tangent; the fusion rule holds there [...]

> **And the third-order content is the excess alone.** Applying the derivation to $L_Wz_1=\tfrac\theta2z_1$ gives $(X\!\cdot\!W)\circ z_1=B(Dz_1)$, so $T(X\!\cdot\!W,z_1,z_2)=\langle Dz_1,Bz_2\rangle=0$ for all $z_1,z_2\in A(\tfrac12)$. Splitting $z=o+e$ into orbit and excess parts, every term with an orbit factor dies and $T(z,z,z)=T(e,e,e)$.

## The block under review, quoted verbatim from disk

> **The ladder, extracted exactly by series from the validated identity** rather than by finite differences: $[\theta^2]$ is $Q/2$, batch 21. $[\theta^3]$ is $\Xi-S$, unconditionally. $[\theta^4]$ is $-\tfrac38\Phi_0-\tfrac5{12}Q$, hence $-\tfrac38\Phi_0$ at $Q=0$. $[\theta^5]$ is $-(\Xi-S)/2$.
>
> *The $\theta^4$ coefficient is slightly MORE informative than r971 stated, carrying $-\tfrac5{12}Q$ as well, and it needs only $Q=0$ rather than $Q=0$ and $\Xi=S$ together.*
>
> **The correspondence is exact, and the constant is the tell.** The record's jet gives $[t^3]P(\gamma)=T(z,z,z)$ at $z\in\ker B$, a degenerate direction, and records that its chordal quartic is $-\tfrac{3\theta}8$ *"on the whole null cone of $B$, not only on eigenvectors"*. **Here it is $-\tfrac38\Phi_0$ on the null cone $Q=0$**: same constant, same hypothesis, and $T(z,z,z)$ is the cubic form at the direction, which is $\Xi$. *So the fourth shape is that calculus transported, not a new apparatus.*
>
> **1. The orbit-vacuity does NOT transfer to the block problem.** [...] *That rests on $P$ being $O(n)$-INVARIANT, so that $Q(e^{tX}W)=\theta e^{tX}W$ can be differentiated.* **Here the fields $A$ and $C$ are FIXED**, so conjugating $(\hat U,V)$ alone is not a symmetry of $\Phi$, which is why batch 33 records $\Phi$ as varying along the orbit. *Checked directly: at the three survivors $\max\lvert H(\text{orbit})\rvert$ is $5.4\cdot10^3$, $4.9\cdot10^4$ and $2.1\cdot10^9$, nowhere near zero.* **So that sentence is withdrawn**, and the transfer holds only for the parts that do not use invariance. What does transfer is that the third-order content is the EXCESS alone.
>
> **2. The lever has no hypothesis to act on at the three survivors.** Its condition $\Xi(Z)=S(Z)$ applies at a DEGENERATE direction, where $Q(Z)=0$. **At all three surviving non-commuting critical points the second variation is NONDEGENERATE on the $9$-dimensional tangent space, $\dim\ker H=0$**, so no such direction exists there.
>
> | spectrum | tangent dim | $\dim\ker H$ | $\max\lvert H(\text{orbit})\rvert$ |
> |---|---|---|---|
> | $(1,-3,2)$ | $9$ | $0$ | $5.4467\cdot10^3$ |
> | $(-1,-3,4)$ | $9$ | $0$ | $4.9261\cdot10^4$ |
> | $(19,-20,1)$ | $9$ | $0$ | $2.0678\cdot10^9$ |
>
> **What this leaves.** *The lever is real, and it is vacuous exactly where R28 needs it*, since the points R28 must exclude carry no degenerate direction. **So R28 reopens on the lever's existence and does not advance on it at these points.**

## The claims to attack

| # | claim | kind |
|---|---|---|
| 1 | The ladder is exactly $[\theta^2]=Q/2$, $[\theta^3]=\Xi-S$, $[\theta^4]=-\tfrac38\Phi_0-\tfrac5{12}Q$, $[\theta^5]=-(\Xi-S)/2$ | mathematics |
| 2 | $[\theta^4]$ needs only $Q=0$, and is therefore strictly more informative than a version needing $Q=0$ and $\Xi=S$ together | mathematics |
| 3 | The block problem's $-\tfrac38\Phi_0$ on $\{Q=0\}$ and the record's $-\tfrac{3\theta}8$ on the null cone of $B$ are the same constant under the same hypothesis | mathematics |
| 4 | Hence the fourth shape IS the record's higher-variation calculus transported, rather than a new apparatus | a classification |
| 5 | The record's ORBIT-VACUITY does not transfer, because $A$ and $C$ are fixed and conjugation is not a symmetry of $\Phi$ | mathematics |
| 6 | The record's "third-order content is the EXCESS alone" DOES transfer | mathematics |
| 7 | The tangent space to the constraint surface at such a point is $9$-dimensional | mathematics |
| 8 | At all three survivors the second variation is nondegenerate there, $\dim\ker H=0$, so no direction with $Q(Z)=0$ exists | numerical |
| 9 | Therefore the lever is vacuous at exactly the points R28 must exclude, and R28 reopens on its existence without advancing on it | about a route |

## The Lean declarations, one row per claim

Every claim has a row. A cell names the declaration that types it, or the reason none can exist. File: [I106Criticality.lean](../lean/HamiltonsCubic/Results/I106Criticality.lean).

| # | Lean |
|---|---|
| 1 | `great_circle_expansion` types the expansion as a ring identity in $c$ and $s$ over the entries, from which the coefficients are read. The reparametrisation to a power series in $\theta$ is NOT typed: the base layer carries no series object |
| 2 | none: a comparison between this block's coefficient and a sentence in [r971](REVIEW_r971.md), which is a statement about two texts rather than about matrices |
| 3 | none: it identifies constants across TWO functionals, and the record's $P$ on $\mathcal W_n$, its $L_W$ and its $B$ have no counterpart in this file's layer |
| 4 | none: a claim about what an apparatus IS, which is not a proposition about matrices |
| 5 | `orbit_second_order_form` gives the block problem's second variation along the orbit tangent explicitly, so the claim is that this expression is not identically zero. The record's invariance derivation has no counterpart to type |
| 6 | none: it quantifies over a splitting of $\ker B$ into orbit and excess parts, and neither $\ker B$ nor that splitting is a type in this layer |
| 7 | `constraint_expansion` types the single linear tangency condition. That it cuts the $10$-dimensional space of traceless symmetric pairs down to $9$ is a RANK statement, and rank is not typed here |
| 8 | none: a kernel dimension at three numerically reconstructed points is not a proposition. `second_variation_expansion` types the form whose kernel is being measured |
| 9 | none: a claim about what a route can and cannot reach, which is not a proposition |

## What to do

1. **Claim 1 is the load-bearing algebra and you should re-extract it, not check it.** Expand the given identity in $\theta$ yourself, symbolically, and report every coefficient through $[\theta^5]$. Say whether the block's four are right, and whether it has stopped one order too early.
2. **Claim 3 is where a reader is most likely to nod, and it is the classification's whole evidence.** Two functionals on two different spaces produce the same rational number. Ask whether that is a correspondence or a coincidence: is there a reason a cubic-plus-linear functional restricted to a great circle must give $-\tfrac38$ of its own value, independent of the algebra? **If the constant is forced by the parametrisation alone, the "tell" tells nothing**, and claim 4 loses its support.
3. **Claim 6 is the one this brief most wants attacked.** The block WITHDREW the orbit-vacuity transfer on the ground that it uses $O(n)$-invariance, and in the same breath kept the excess-splitting transfer. Read the record's quoted proof of the splitting: **does it use the orbit identity $Bu=z\circ z$, or $L_Wz=\tfrac\theta2z$, or anything else derived from invariance?** If it does, claim 6 falls for exactly the reason claim 5 stands, and the block has drawn the line in the wrong place.
4. **Claim 7 is checkable by hand.** Count the dimension of traceless symmetric $3\times3$ pairs and subtract the constraint. Say what you get, and whether $9$ is right.
5. **Claim 8 is reproducible and you should reproduce it**, rebuilding the three points from the criticality system rather than trusting the figures. The second variation must be restricted to the tangent space through a genuine orthonormal basis of it; a projection that keeps more vectors than the dimension manufactures a kernel. Report $\dim\ker H$ and say what the smallest singular value actually is, since "nondegenerate" at $10^{-9}$ and at $10^{-1}$ are different findings.
6. **Claim 9 asks about REACH.** Three points is three points. Say what the claim is entitled to: vacuous at these three, or vacuous on the stratum, and whether the block's wording overstates it.
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.** Claim 5 in particular: a second variation that is nonzero along the orbit is unsurprising if it is nonzero along nearly every direction, so say whether the orbit is distinguished at all here.

**The most useful thing you can do is decide whether claim 6 survives claim 5.** The block kept one half of a transfer and withdrew the other in the same paragraph, and if both halves rest on invariance then the classification carries nothing across and claim 4 is decoration.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim, and any run finishing in a few minutes on objects already in hand. **What waits**: a sweep over a parameter range, a census of a family, an optimisation whose cost is unknown before it starts. *The test is whether you can say in advance what it will cost and what it will decide.*

**Report.** Write `reviews/REVIEW_r<N>.md`. **Commit a skeleton in your first phase**: the title, the claim table with every verdict `NOT REACHED`, and the log path. Update one row per phase. **Commit that file by path only**, never `git add -A` and never `git commit -a`. **Never amend.**

**Do not write to [reviews/INDEX.md](INDEX.md).** The parent files every row after the last report lands, so neither reviewer publishes verdicts where the other will read them.

**Log** to `agent_logs/<task-name>.log`: first line carrying your PID and phase plan, a line at every phase transition, a heartbeat at least every 3 minutes carrying live state, and a closing line that **OPENS** with `DONE ` or `FAILED `, after at most a timestamp, as the last line written to the file.
