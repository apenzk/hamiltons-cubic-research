# Gate 2 brief: four owed results, batches 34 and 35, the I104 Gram exhaustion, and I106a's first piece

You are auditing **four independent blocks** that have accumulated on the Gate 2 debt ledger undispatched. They are separate subjects and you may take them in any order. **Work from the definitions below and from your own derivations. Do not import the code under review.** Your job is to break the claims.

## The standing rule you inherit

**This programme is on an analysis-only footing.** A long or open-ended run (a sweep over a parameter range, a census of a family, an optimisation whose cost is unknown before it starts, a falsifier hunt with no bound on where it looks) is not yours to open. What is permitted: **screening a claim you are about to record**, and any run that finishes in a few minutes on objects already in hand. Where a number is needed to refute a claim, compute the smallest one that does the job and say why an argument could not replace it.

---

# Part A, the block problem: batches 34 and 35

## Setting

Real symmetric traceless $3\times3$ $\hat U,V$. $\{X,Y\}=XY+YX$, $K=[\hat U,V]$, $\langle X,Y\rangle=\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$.
$$\Phi=\alpha\mathop{\mathrm{tr}}\hat U^3+\beta\mathop{\mathrm{tr}}(\hat UV^2)+\langle\hat U,A\rangle+\langle V,C\rangle,\qquad\alpha=\tfrac{15}4,\ \beta=\tfrac94,$$
maximised subject to $T=\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2$ fixed, $A$ and $C$ symmetric and diagonal in one frame $F$.

**Given (batch 10).** At a critical point, $A\equiv3\mu\hat U-3\alpha\hat U^2-\beta V^2$ and $C\equiv\mu V-\beta\{\hat U,V\}$, each up to an added multiple of $I$.

**Given (batch 20), the boxed identity.** Pairing each Lagrange equation with its own variable gives $3\alpha\mathop{\mathrm{tr}}\hat U^3+\beta\mathop{\mathrm{tr}}(\hat UV^2)+\langle\hat U,A\rangle=3\mu\lvert\hat U\rvert^2$ and $2\beta\mathop{\mathrm{tr}}(\hat UV^2)+\langle V,C\rangle=\mu\lvert V\rvert^2$, whence $\Phi=2\mu T-2P_3$ with $P_3=\alpha\mathop{\mathrm{tr}}\hat U^3+\beta\mathop{\mathrm{tr}}(\hat UV^2)$.

**Given (batch 18).** At every global maximum $\mu\ge2\beta\lvert\hat U\rvert/\sqrt6$, from $\lambda_{\max}(\mathcal L_{\hat U})=\lvert\hat U\rvert/\sqrt6$ on traceless symmetric matrices, $\mathcal L_{\hat U}V=\tfrac12(\hat UV+V\hat U)$.

**Given (post F69).** *A condition on the Lagrange fields can be criticality restated, so a proposed maximality input is tested by substituting that field's own form.* Three instances recorded before batch 34.

**Given (batch 29 and r961).** At $w_3=0$, $w_1=w_2$, eliminating $a_1,a_2$ leaves a quadratic in $\mu$ with $u_3=-u_1-u_2$, $D_1=u_2-u_3$, $D_2=u_1-u_3$ and $c_2=-16u_3D_1D_2$, $c_1=32D_1D_2(4u_1^2+7u_1u_2+4u_2^2)$, $c_0=-9u_3(u_1^2+u_1u_2+u_2^2)(40u_1^2+100u_1u_2+40u_2^2+9)$. Batch 28 gives $a_1D_2=a_2D_1$ there. r961 found three points clearing batch 18, batch 21 ($\mu\ge\alpha\lvert u_{\min}\rvert$) and batch 33's orbit bound together.

## Block A1, batch 34, quoted verbatim

> **What was tried.** Batch 20 owes an upper bound on $\mu$, and its own second pairing looks like it supplies one. That pairing is $\mu\lvert V\rvert^2=2\beta\mathop{\mathrm{tr}}(\hat UV^2)+\langle V,C\rangle$, and batch 18's Jordan spectrum caps the Rayleigh quotient, $\mathop{\mathrm{tr}}(\hat UV^2)=\langle\mathcal L_{\hat U}V,V\rangle\le(\lvert\hat U\rvert/\sqrt6)\lvert V\rvert^2$, giving
> $$\mu\ \le\ \frac{2\beta\lvert\hat U\rvert}{\sqrt6}+\frac{\langle V,C\rangle}{\lvert V\rvert^2}\qquad\text{at every critical point with }V\ne0 .$$
> **It is true, and it is not a bound**, because the term that carries it is the field pairing, and $C$ is defined by the very equation the bound came from. *Rearranged, the display is the Rayleigh inequality and nothing more.* **This is post F69 for a fourth time**, now reached from the other direction: not a condition on the fields being criticality restated, but a bound whose only non-trivial term is a field pairing.
>
> **The corollary it does give, and why that is not new either.** Against batch 18's lower bound the two pin $\mu$ from both sides at a global maximum and force $\langle V,C\rangle\ge0$ there. *That is a genuine necessary condition and it is not vacuous, since $\langle V,C\rangle=\mu\lvert V\rvert^2-2\beta\mathop{\mathrm{tr}}(\hat UV^2)$ takes both signs at critical points: at batch 28's two points it is $+65.52$ and $-18345.79$.* **But it is implied by batch 18 alone**, since $\mu\ge2\beta\lvert\hat U\rvert/\sqrt6$ and the same Rayleigh step give $\langle V,C\rangle\ge0$ in two lines, so it is strictly weaker than the bound it was derived from and adds nothing to the record.
>
> **Gate 1.** $\mu T-P_3=\Phi/2$ follows from batch 20's boxed identity by arithmetic, and was checked symbolically; the Rayleigh cap was screened over $20000$ random traceless symmetric pairs with the largest value of $\mathop{\mathrm{tr}}(\hat UV^2)-(\lvert\hat U\rvert/\sqrt6)\lvert V\rvert^2$ coming out $-6.3\cdot10^{-3}$.

*The block also corrected batch 20 in place, on the ground that $\mu T-P_3=\Phi/2$ makes "a comparison of two numbers per point rather than of configurations" circular.*

## Block A2, batch 35, quoted verbatim

> **The comparison, and the result.** At each point the fields are fixed by the Lagrange forms, $[A,C]=0$ holds to between $4\cdot10^{-12}$ and $2\cdot10^{-7}$, and $\Phi$ at the point is compared with the best configuration diagonal in the fields' common frame at the same total norm:
>
> | spectrum | $\mu$ | $T$ | $\Phi$ at the point | best diagonal | ratio |
> |---|---|---|---|---|---|
> | $(1,-3,2)$ | $11.60060$ | $178.2407$ | $2143.11334$ | $3290.15950$ | $1.53522$ |
> | $(-1,-3,4)$ | $24.43870$ | $645.4986$ | $19982.01544$ | $28862.02037$ | $1.44440$ |
> | $(19,-20,1)$ | $762.38453$ | $350181.3948$ | $526210564.02247$ | $577574913.51612$ | $1.09761$ |
>
> **The diagonal configuration wins at all three**, so the lever survives its hardest test to date.
>
> **The finding is the anti-correlation, not the win.** *The two points that clear the multiplier bounds by one per cent lose the value comparison by $44\%$ and $54\%$, while the point that clears those bounds by a factor of seven is the TIGHTEST on value at $1.098$.* **So nearness in the second-order conditions says nothing about nearness in value.**
>
> **Why the optimiser's quality cannot threaten this.** The claim is that SOME diagonal configuration beats each point, so a local optimum is a **witness** and a better one would only widen the margin.

---

# Part B, the four-set strata: the I104 Gram exhaustion

## Setting

$\Pi_Q\subset\mathcal D_n$ is the plane of sectional matrices supported on a four-set $Q$, with $K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$, $x+y+z=0$, unit when $2(x^2+y^2+z^2)=1$. $Q_1,Q_2$ share two indices, $Q_3=Q_1\triangle Q_2$. $D\in\mathcal D_n$, $q_i$ its projection on $\Pi_{Q_i}$, $u_i=\lVert q_i\rVert$, $t=\lVert D\rVert^2$.

**Given (L221 step 3).** Unit patterns on $Q_i$ and $Q_j$ share exactly one pair, whose entry $x$ satisfies $3x^2\le2(x^2+y^2+z^2)=1$, so $\lvert\langle\hat q_i,\hat q_j\rangle\rvert\le\tfrac13$.

**Given (the note's own screen, before this block).** The three scalar chains fail on a region whose worst shortfall is $0.02$, at $N_1=N_2=N_3=0.268$ with $\tau$ at its bound $0.069$; and a Gram bound $\sum_iu_i^2\le(1+\tfrac23)t$ was screened and found not to close it. **The note twice recommended a Gram-system treatment as the fix.**

## Block B, quoted verbatim

> **The cross-plane geometry is rigid.** $\Pi_{Q_1}$ and $\Pi_{Q_2}$ share exactly one matrix entry, the pair $ij$, and likewise $kl$ for $(Q_1,Q_3)$ and $mp$ for $(Q_2,Q_3)$. So $\langle q_1,q_2\rangle=x_1x_2$ factors through a single linear functional on each plane: **the cross-Gram has rank one, and the principal cosines are exactly $(\tfrac13,0)$** rather than "at most $\tfrac13$".
>
> **What the joint system then gives.** Writing $q_i=\alpha_i\hat e_i+\beta_i\hat f_i$ with $\hat e$ the shared channel and $\hat f$ orthogonal to every other plane, $\sum_iu_i^2\le\lambda_{\max}(G_e)\,t$ with $G_e$ the $3\times3$ matrix of unit diagonal and off-diagonals $\pm\tfrac13$.
>
> **The parity constraint works AGAINST the bound.** The three cosines are $x_1x_2$, $x_1x_3$, $x_2x_3$, whose product is $(x_1x_2x_3)^2\ge0$, so an even number of them are negative. *The odd sign patterns give $\lambda_{\max}=\tfrac43$ and are geometrically impossible; every admissible pattern gives $\tfrac53$.* **And $\sum u_i^2\le\tfrac53t$ is attained**, at $D$ along $G_e$'s top eigenvector.
>
> **So the route recommended twice above is closed.** The Gram treatment returns exactly the $(1+\tfrac23)t$ that the screen above already found insufficient by $0.02$, and it cannot be improved, because the geometry it rests on is exact rather than estimated.

---

# Part C, I106a's first piece: the orthostochastic variety's equation

## Setting

For $Q$ a real $3\times3$ matrix, $Q^{\circ2}$ is the entrywise square. Au-Yeung and Poon, carried by Bengtsson, Ericsson, Kuś, Tadej and Życzkowski section 3: for a **bistochastic** matrix $\begin{pmatrix}x&y&\star\\z&w&\star\\a&b&\star\end{pmatrix}$, it is orthostochastic if and only if $(\sqrt x,\sqrt z,\sqrt a)$ and $(\sqrt y,\pm\sqrt w,\pm\sqrt b)$ are orthogonal for some choice of signs, i.e. $\sqrt{xy}+\varepsilon_1\sqrt{zw}+\varepsilon_2\sqrt{ab}=0$.

## Block C, quoted verbatim

> **The derivation, three lines, and it uses only the orthogonality of two columns.** Put $u=q_{00}q_{01}$, $v=q_{10}q_{11}$, $t=q_{20}q_{21}$ for the entrywise products of the first two columns of $Q$. Orthogonality of those columns is $u+v+t=0$. The entrywise squares are $xy=u^2$, $zw=v^2$ and $ab=t^2=(u+v)^2$, so
> $$ab-xy-zw=(u+v)^2-u^2-v^2=2uv,\qquad 4xyzw=4u^2v^2=(2uv)^2,$$
> and therefore $(ab-xy-zw)^2=4xyzw$. **The source's sign choices $\varepsilon_1,\varepsilon_2$ are exactly the signs of $u$, $v$ and $t$**, which is why the polynomial form carries none and why no case analysis is needed.
>
> **What this proves that the source states with more hypotheses.** *Bistochasticity is never used, positivity is never used, and no relation among the remaining three entries is used.*
>
> **The bridge to the published form.** On a bistochastic matrix the column sums give $a=1-x-z$ and $b=1-y-w$, and then $ab-xy-zw=1-x-y-z-w+xw+yz$, so the equation reads $(1-x-y-z-w+xw+yz)^2=4xyzw$.
>
> **What is NOT proved.** *The converse: that the equation cuts out the orthostochastic matrices rather than a larger set.* Screened only: of $60$ bistochastic points sampled ON the variety, none failed to be realisable as $Q^{\circ2}$ under some sign pattern.

---

## The claims, and your verdict on each

| # | claim | verdict |
|---|---|---|
| 1 | Batch 34's display $\mu\le2\beta\lvert\hat U\rvert/\sqrt6+\langle V,C\rangle/\lvert V\rvert^2$ holds at every critical point with $V\ne0$ | |
| 2 | It is not a bound in any useful sense, being the Rayleigh inequality rearranged | |
| 3 | $\langle V,C\rangle\ge0$ at a global maximum, and it is implied by batch 18 alone, hence adds nothing | |
| 4 | $\langle V,C\rangle$ takes both signs at critical points, the two values $+65.52$ and $-18345.79$ | |
| 5 | $\mu T-P_3=\Phi/2$ identically, so batch 20's "comparison of two numbers" reading was circular | |
| 6 | Batch 35's three rows: the points, the fields commuting, $\Phi$ at each point and the diagonal maximum | |
| 7 | The anti-correlation: tightness in the multiplier bounds does not track tightness in value | |
| 8 | The witness argument is sound, so optimiser quality cannot threaten batch 35's conclusion | |
| 9 | I104: the cross-Gram has rank one and the principal cosines are exactly $(\tfrac13,0)$ | |
| 10 | I104: the parity constraint admits only the $\lambda_{\max}=\tfrac53$ patterns, and $\sum u_i^2\le\tfrac53t$ is attained | |
| 11 | I104: therefore the Gram route is exhausted, not lossy, and the note's own recommendation is refuted | |
| 12 | I106a: $(ab-xy-zw)^2=4xyzw$ from column orthogonality alone, with bistochasticity and positivity genuinely unused | |
| 13 | I106a: the bridge, and that the source's signs are the signs of $u,v,t$ | |

## What to attack hardest

1. **Claim 3 is the one that decides whether batch 34 says anything.** If $\langle V,C\rangle\ge0$ is *not* implied by batch 18, the block has understated its own result. Derive the implication yourself and say whether it is two lines.
2. **Claim 5's consequence.** If $\mu T-P_3=\Phi/2$, ask what batch 20's identity *does* give, and whether the block's replacement wording (that the fields drop out, leaving $\mu,T,P_3$) is itself informative or also circular.
3. **Claim 10's parity argument.** The step "the three cosines are $x_1x_2,x_1x_3,x_2x_3$, whose product is a square" is the whole of it. Check it is not an artefact of a particular labelling of the shared pairs, and that the $\tfrac43$ patterns really cannot occur.
4. **Claim 11 is a refutation of the record's own recommendation**, so it carries the heavier burden. Verify the attainment claim independently, and ask whether "exhausted" is the right word or whether a Gram treatment with the $\hat f$ components used differently could still do better.
5. **Claim 12's hypothesis count.** The block claims the source assumes more than it needs. Verify that no step uses bistochasticity or positivity, including implicitly through $\sqrt{\cdot}$ being real, and say whether the polynomial identity is genuinely sign-free or whether the signs reappear in the converse.
6. **The converse in Part C is the debt that matters.** Say whether it is true, and if you can settle it either way that is worth more than everything else in Part C.

## Lean, one row per claim

*This table replaces a sentence that read "Parts A and B are typed nowhere", which named eight untyped claims at once and passed the eye. A blank here is a blocker, not a note.*

| # | claim | Lean |
|---|---|---|
| 1 | batch 34's display | none: an inequality at critical points, and the layer has no constraint surface |
| 2 | it is not a bound in any useful sense | none: a judgement about usefulness, not a proposition |
| 3 | $\langle V,C\rangle\ge0$ at a global maximum | none: quantifies over maximisers |
| 4 | $\langle V,C\rangle$ takes both signs | none: two numerical evaluations |
| 5 | $\mu T-P_3=\Phi/2$ | `value_at_critical`, which gives $\Phi=2\mu T-2P_3$; the claim is arithmetic from it |
| 6 | batch 35's three rows | none: numerical, a witness computation |
| 7 | the anti-correlation | none: numerical |
| 8 | the witness argument is sound | none: a statement about method, not about objects |
| 9 | I104, rank one and cosines exactly $(\tfrac13,0)$ | **TYPEABLE, NOT TYPED**: a finite computation on explicit patterns at $n=8$ |
| 10 | I104, parity and $\lambda_{\max}=\tfrac53$ attained | **TYPEABLE, NOT TYPED**: a $3\times3$ eigenvalue statement |
| 11 | I104, the Gram route is exhausted | none: a conclusion about a route |
| 12 | I106a's equation from column orthogonality | `orthostochastic_eq` |
| 13 | I106a's bridge, and the signs | `bridge`, `orthostochastic_poly` |

**Rows 9 and 10 are the honest cost of this round**: both could have been settled by the kernel before you were spent on them. **Do not treat a successful build as evidence that a declaration says what the block claims**: compare statement against prose and report any mismatch.

## Deliverables

Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per row, with corrections, and what you would change in the record.

**Commit a skeleton report in your first phase and update it**, rather than writing one at the end: the first commit is the title, the claim table with every verdict `NOT REACHED`, and your log path. **Do not write to `reviews/INDEX.md`**, which the parent writes after every report of the round has landed. **Commit only your own report path**, `git commit -m <msg> -- reviews/REVIEW_rN.md`: a previous round's reviewer swept in its counterpart's report and the parent's brief by committing without a path.

**Log** to `agent_logs/<your task name>.log`: first line with your PID and phase plan, a line at every phase transition, a heartbeat at least every three minutes carrying live state, and a closing `DONE <summary>` or `FAILED <reason>` as the last line written, with that word opening the line.
