# Review r964: the Gate 2 debt, batches 34 and 35, the I104 Gram exhaustion, I106a's first piece

Reviewer r964, adversarial Gate 2 audit against [BRIEF_debt_batches34_35_I104_I106a.md](BRIEF_debt_batches34_35_I104_I106a.md). Every number below was reproduced from the definitions in the brief, by my own solve, without importing any script under review.

Log: [agent_logs/r964-debt.log](../agent_logs/r964-debt.log)

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | Batch 34's display holds at every critical point with $V\ne0$ | CONFIRMED |
| 2 | It is not a bound in any useful sense, being the Rayleigh inequality rearranged | CONFIRMED |
| 3 | $\langle V,C\rangle\ge0$ at a global maximum, implied by batch 18 alone | CONFIRMED, one word corrected |
| 4 | $\langle V,C\rangle$ takes both signs at critical points, $+65.52$ and $-18345.79$ | CONFIRMED to the digit |
| 5 | $\mu T-P_3=\Phi/2$ identically, so batch 20's reading was circular | CONFIRMED |
| 6 | Batch 35's three rows | CONFIRMED, trailing digits over-precise |
| 7 | The anti-correlation | PLAUSIBLE, scope narrowed |
| 8 | The witness argument is sound | CONFIRMED, and it does not cover claim 7 |
| 9 | I104: cross-Gram rank one, principal cosines exactly $(\tfrac13,0)$ | CONFIRMED, with the reason supplied |
| 10 | I104: parity admits only $\lambda_{\max}=\tfrac53$, and the bound is attained | CONFIRMED |
| 11 | I104: the Gram route is exhausted, the note's recommendation refuted | **REFUTED** |
| 12 | I106a: the equation from column orthogonality alone | CONFIRMED, framing corrected |
| 13 | I106a: the bridge, and the source's signs | CONFIRMED, signs restated |

**Two things outside the thirteen rows.** The Part C converse, named in the brief as the debt that decides whether R28 is exact, **is true, and it has a paragraph-long proof that never cites the source**. And claim 11's refutation of the note's own recommendation does not hold: the Gram *system* is strictly stronger than the scalar bound the block computed, and the route the note recommended twice is still open.

---

## Part C: the converse is TRUE, and R28 is exact

### The proof

Let $B$ be bistochastic with $(ab-xy-zw)^2=4xyzw$. Put $U=\sqrt{xy}$, $V=\sqrt{zw}$, $T=\sqrt{ab}$, all real and non-negative because $B\ge0$. The equation says $(T^2-U^2-V^2)^2=(2UV)^2$, so $T^2=(U+V)^2$ or $T^2=(U-V)^2$, and since $T\ge0$ this is $T=U+V$ or $T=\lvert U-V\rvert$. In every case one of $U,V,T$ is the sum of the other two, so there are signs with $U+\varepsilon_1V+\varepsilon_2T=0$.

Now build $Q$. Take $c_1=(\sqrt x,\sqrt z,\sqrt a)$ and $c_2=(\sqrt y,\varepsilon_1\sqrt w,\varepsilon_2\sqrt b)$. Both are unit vectors, because $B$'s first two column sums are $1$, and $\langle c_1,c_2\rangle=U+\varepsilon_1V+\varepsilon_2T=0$. Let $c_3=c_1\times c_2$. Then $Q=(c_1\,c_2\,c_3)$ is orthogonal, and $Q^{\circ2}$ agrees with $B$ in its first two columns by construction. Its third column agrees too: $Q$'s rows are unit, so $(Q^{\circ2})_{i2}=1-B_{i0}-B_{i1}$, which is $B_{i2}$ because $B$'s rows sum to $1$. Hence $B=Q^{\circ2}$ with $Q$ orthogonal. $\square$

**This is a converse in both available senses.** It settles the polynomial's exactness on the bistochastic variety without appealing to Au-Yeung and Poon at all, so it is independent of the source rather than a restatement of it. Read the other way it also proves the source's hard direction. The step that uses positivity is the passage from the squared equation to $T=U+V$ or $T=\lvert U-V\rvert$, and the step that uses bistochasticity is the unit length of $c_1$ and $c_2$ plus the recovery of the third column. Those are exactly the two hypotheses block C observes the forward direction does not need, which is the right way to read its own observation: the hypotheses are not surplus, they are where the converse lives.

*Screened before recording*: 3000 bistochastic points sampled on the variety, all 3000 realised as $Q^{\circ2}$ by this construction, 0 failures, in 0.6 seconds. The screen is a check on the construction, and the proof above is what carries the claim.

**Consequence for the route.** R28's maximum over the variety is the true maximum over the orthostochastic set, not an upper bound. The standing debt named in [I106aOrthostochastic.lean](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean)'s header is discharged.

### Claims 12 and 13

**Claim 12 CONFIRMED on the mathematics.** With $u=q_{00}q_{01}$, $v=q_{10}q_{11}$, $t=q_{20}q_{21}$ and $u+v+t=0$, $ab-xy-zw=(u+v)^2-u^2-v^2=2uv$ and $4xyzw=(2uv)^2$. Screened at $20000$ random matrices whose first two columns are orthogonal and neither normalised nor positive, with the entrywise squares off the bistochastic set entirely: relative residual at most $10^{-15}$. Positivity is genuinely unused, including implicitly, because no square root appears anywhere in the derivation. The $\sqrt{\cdot}$ of the source is replaced by the products $u,v,t$, which are signed reals.

**The framing is what I would change.** "What this proves that the source states with more hypotheses" reads as though the source over-assumed. The source states an **iff**, and the block proves its easy direction. The hypotheses it drops are precisely the ones the hard direction needs, as the proof above shows. The honest sentence is that the *forward* inclusion is a polynomial identity valid on all of $M_3(\mathbb R)$ with two orthogonal columns, while the *reverse* inclusion needs positivity and the column sums.

**Claim 13 CONFIRMED with the signs restated.** The bridge is correct: on a bistochastic matrix $a=1-x-z$ and $b=1-y-w$ from the first two column sums, and $ab-xy-zw=1-x-y-z-w+xw+yz$. The sign sentence is imprecise. Dividing $u+v+t=0$ by $\mathop{\mathrm{sgn}}(u)$ gives $\lvert u\rvert+\mathop{\mathrm{sgn}}(uv)\lvert v\rvert+\mathop{\mathrm{sgn}}(ut)\lvert t\rvert=0$, so $\varepsilon_1=\mathop{\mathrm{sgn}}(u)\mathop{\mathrm{sgn}}(v)$ and $\varepsilon_2=\mathop{\mathrm{sgn}}(u)\mathop{\mathrm{sgn}}(t)$. The $\varepsilon$ are **relative** signs, the sign pattern of $(u,v,t)$ modulo a global flip, which is why two of them carry three signs. Written as "the signs of $u$, $v$ and $t$" the count does not add up and the reader cannot reconstruct the correspondence.

### The Lean file against the prose

`orthostochastic_eq`, `bridge` and `orthostochastic_poly` each say what the prose says. The hypothesis of `orthostochastic_eq` is the single linear relation and nothing else, so the docstring's "no bistochasticity, no positivity" is carried by the statement rather than merely asserted beside it. `orthostochastic_poly`'s `ha`, `hb` encode the first two column sums and nothing more, which matches the bridge's prose. No mismatch found.

---

## Part B: claims 9 and 10 stand, claim 11 falls

### Claim 9 CONFIRMED, and the block leaves out the reason

$\Pi_{Q_1}$ and $\Pi_{Q_2}$ meet in the single pair $Q_1\cap Q_2$, so $\langle q_1,q_2\rangle=x_1x_2$ and the cross-Gram is rank one, with the one non-zero principal cosine $\tfrac13$ because $\lvert x\rvert\le\tfrac1{\sqrt3}$ at unit norm. Verified on explicit patterns at $n=6$: singular values $(0.33333333,0)$ for all three pairs, matrix rank 1.

**The step the block states without justifying is the one its parity argument depends on.** Each plane meets *two* others, so at first sight it has two shared channels, and the block's "$\hat e$ the shared channel" quietly assumes one. It is one, and here is why: $Q_1\cap Q_2$ and $Q_1\cap Q_3$ are **complementary** pairs inside $Q_1$, since $Q_3=Q_1\triangle Q_2$ forces $Q_1\setminus Q_2\subset Q_3$. The pattern gives complementary pairs the same entry, so both shared pairs of $\Pi_{Q_1}$ carry the same coordinate $x_1$. That is what makes $x_i$ a well-defined function of $q_i$ rather than of a labelling, and it is what makes the parity argument labelling-free. **I would add this sentence to the block**, because without it claim 10 reads as an artefact of a choice.

### Claim 10 CONFIRMED

Orient each $\hat e_i$ by $x>0$. Then $\langle\hat e_i,\hat e_j\rangle=\tfrac13$ for all three pairs, $G_e=\tfrac23I+\tfrac13J$ with spectrum $\{\tfrac53,\tfrac23,\tfrac23\}$, computed on the explicit patterns. Flipping one $\hat e_i$ flips two off-diagonals, so the sign pattern matters only through its parity: even parity is diagonally similar to all-plus and gives $\lambda_{\max}=\tfrac53$, odd parity gives $\tfrac43$. The parity is forced, because the product of the three cosines is $(x_1x_2x_3)^2\ge0$, and by the previous paragraph that product is an invariant of the configuration rather than of a labelling. So the $\tfrac43$ patterns are indeed unreachable, and the parity does work against the bound.

**Attainment CONFIRMED independently.** $D=\hat e_1+\hat e_2+\hat e_3$ has $\lVert D\rVert^2=5$, each $q_i=\tfrac53\hat e_i$, and $\sum u_i^2/t=\tfrac53$ to $10^{-15}$. It is admissible: each pattern is hollow with row sums $x+y+z=0$, so $\Pi_{Q_a}\subset\mathcal D_n$, and $\mathcal D_n$ is a linear space, so the sum lies in it. Checked directly, row sums $<10^{-12}$.

### Claim 11 REFUTED

The block proves something true and then draws a conclusion that does not follow. What is true: **$\sum u_i^2\le\tfrac53t$ cannot be improved as a bound in $t$ alone**. What does not follow: that the Gram *system* is exhausted. The system carries strictly more, and the extra is not small.

**The exact system.** Let $\hat f_i$ span $\ker(x)$ inside $\Pi_{Q_i}$. Then $\hat f_i$ is orthogonal to the whole of the other two planes, because its shared entries vanish, so $\hat f_1,\hat f_2,\hat f_3$ are mutually orthogonal and orthogonal to every $\hat e_j$ (verified numerically, all such products $0$ to $10^{-16}$). With $\alpha_i=\langle D,\hat e_i\rangle=\sqrt3\,x_i$ and $\beta_i=\langle D,\hat f_i\rangle$, we have $u_i^2=\alpha_i^2+\beta_i^2$, and the component of $D$ in $\mathop{\mathrm{span}}(\hat e)$ has squared norm $\alpha^{\mathsf T}G_e^{-1}\alpha$ with $G_e^{-1}=\tfrac32I-\tfrac3{10}J$. Hence $t\ge\alpha^{\mathsf T}G_e^{-1}\alpha+\lvert\beta\rvert^2$, with equality exactly when $D\in\Sigma=\Pi_1+\Pi_2+\Pi_3$, and

$$\sum_iu_i^2\ \le\ t\;-\;\tfrac32\sum_ix_i^2\;+\;\tfrac9{10}\Big(\sum_ix_i\Big)^2 ,$$

**an identity on $\Sigma$.** Maximising its right side over $x$ returns $\tfrac53t$ at $x_1=x_2=x_3$, which is exactly the block's bound and exactly its attaining configuration. So the block computed the maximum of this inequality over one direction and reported it as the inequality.

*Screened*: the identity holds to $1.5\cdot10^{-15}$ over 6000 random $D\in\Sigma$, and the inequality holds over 4000 random $D\in\mathcal D_6$ where it is on average $0.665\,t$ **tighter** than $\tfrac53t$, worst case $0.099\,t$ tighter.

**What that does to the note's failing region.** Since $(\sum x_i)^2\le3\sum x_i^2$, the display gives the necessary condition

$$\sum_ix_i^2\ \ge\ \tfrac56\Big(\sum_iu_i^2-t\Big),$$

with equality only when the three $x_i$ are equal. At the note's own most permissive surviving configuration, $N_1=N_2=N_3=0.134$, $t=0.598$, $u_i=0.496$, $\sum u_i^2=0.738$, this forces $\sum x_i^2\ge0.1167$ against a maximum of $\sum u_i^2/3=0.246$, that is each $q_i$ at least $69\%$ aligned with its own shared channel and all three nearly equal. **The scalar bound carries none of this.** It reports a slack of $0.2586$ there and stops.

**So the conclusion to withdraw is "exhausted".** The right statement is that the Gram route's *scalar corollary in $t$ alone* is exact and cannot be improved, which is a real and useful finding. Whether the Gram *system*, which is the alignment condition above read against the pinning and against $\tau$, closes the $0.02$ is an open question that the block did not ask. The note's twice-stated recommendation of a Gram-system treatment is therefore **not refuted**, and the in-place corrections that struck those two sentences should be reverted.

*One of my own predictions here was refuted by my own screen and is not stated above*: I expected mixed signs among the $x_i$ to force $\sum u_i^2\le t$, and the screen returned $1.103\,t$, so the sign pattern alone carries nothing. The alignment condition, which the screen supports, is what survives.

---

## Part A: batches 34 and 35

**Reconstruction.** The brief's data determine the points. At $\hat U=\mathop{\mathrm{diag}}(3,1,-4)$ with $w_1=w_2=1$, $w_3=0$ the commutator has $\lVert K\rVert_F=\sqrt{2(49+25)}=12.16553$, matching batch 28 exactly, so I solved $[A,C]=0$ for $(a_1,a_2,\mu)$ by Newton from 4000 random starts and recovered all four roots. Batch 35's second row is the *same point with $\hat U$ negated*: $(-1,-3,4)$ is a permutation of $-(3,1,-4)$, and $\hat U\mapsto-\hat U$ sends $\mu\mapsto-\mu$ and $C\mapsto-C$. That is a consistency check the record does not draw and it holds to every digit.

### Claims 1, 2, 3, 5

**Claim 1 CONFIRMED.** The $V$ pairing $\mu\lvert V\rvert^2=2\beta\mathop{\mathrm{tr}}(\hat UV^2)+\langle V,C\rangle$ follows from $C=\mu V-\beta\{\hat U,V\}$ and $\mathop{\mathrm{tr}}(V\{\hat U,V\})=2\mathop{\mathrm{tr}}(\hat UV^2)$, and the Rayleigh cap is exact. I checked the cap is an *identity* rather than an estimate: $\lambda_{\max}(\mathcal L_{\hat U})$ on traceless symmetric equals $\lvert\hat U\rvert/\sqrt6$ for every traceless $\hat U$, including the off-diagonal sector, where the eigenvalues $-u_k/2$ never win because $3u_{\min}^2\le2\lvert\hat U\rvert^2$. Screened over 3000 random $\hat U$ by building the full $5\times5$ operator: largest excess $2.7\cdot10^{-15}$.

**Claim 2 CONFIRMED.** Multiply through by $\lvert V\rvert^2$ and substitute the pairing: the display collapses to $2\beta\mathop{\mathrm{tr}}(\hat UV^2)\le2\beta(\lvert\hat U\rvert/\sqrt6)\lvert V\rvert^2$, which is the Rayleigh inequality and nothing else. *One word*: it **is** a bound, and a true one. What it is not is an *a priori* bound, because $\langle V,C\rangle/\lvert V\rvert^2$ is not controlled by anything outside the equation it came from. I would write "not an a priori bound" rather than "not a bound".

**Claim 3 CONFIRMED, and it is two lines.** $\langle V,C\rangle=\mu\lvert V\rvert^2-2\beta\mathop{\mathrm{tr}}(\hat UV^2)\ge\lvert V\rvert^2\big(\mu-2\beta\lvert\hat U\rvert/\sqrt6\big)\ge0$, the first step by Rayleigh and the second by batch 18. It also survives $V=0$ trivially. *One word*: "implied by batch 18 alone" should read "by batch 18 together with the same pairing and the same Rayleigh step", which are the display's own two ingredients. That is the block's point and the phrase as written slightly overstates it. The logical relation is exactly as the block says otherwise: the corollary is the display combined with batch 18, hence a consequence, hence no new input.

**Claim 5 CONFIRMED.** $\Phi=2\mu T-2P_3$ is the sum of the two pairings minus $\Phi$, so $\mu T-P_3=\Phi/2$ is that identity halved. Verified at all fourteen reconstructed critical points, residual $\le7\cdot10^{-12}$. **On the brief's second line of attack**: what batch 20's identity genuinely gives is the *elimination of the fields*, that $\Phi$ at a critical point is a function of $\mu$, $T$ and $P_3$ alone. That is informative and it is not circular. What is circular is using $\mu T-P_3$ as a *comparison* between configurations, since it is $\Phi/2$ and so compares nothing new. The block's replacement wording is therefore right, provided it says the fields drop out of the *value*, which is a statement about $\Phi$, and does not claim that $\mu$, $T$ and $P_3$ are independently available.

### Claim 4 CONFIRMED to the digit

Solving $[A,C]=0$ independently and evaluating $\langle V,C\rangle=\mu\lvert V\rvert^2-2\beta\mathop{\mathrm{tr}}(\hat UV^2)$:

| point | $\mu$ | $\langle V,C\rangle$ | record |
|---|---|---|---|
| $(3,1,-4)$, small root | $-6.061304$ | $+65.51984$ | $+65.52$ |
| $(3,1,-4)$, large root | $-24.438696$ | $-18345.78863$ | $-18345.79$ |

Both match. The qualitative content is also secure for a reason the block does not give: with $\hat U$ and $V$ both diagonal in one frame, $A$ and $C$ are automatically diagonal for *any* $\mu$, so critical points with $\langle V,C\rangle$ of either sign exist in abundance and the sign change needs no exhibit. A negative value is consistent, since $\langle V,C\rangle<0$ forces $\mu<2\beta\lvert\hat U\rvert/\sqrt6$ and so certifies that the point fails batch 18, which both of these do.

### Claim 6 CONFIRMED, with the printed precision corrected

I reproduced the whole table: my own Newton solve for the points, my own check that $C$ is diagonal in $A$'s eigenframe, and my own projected-gradient maximiser over configurations diagonal in that frame at the same $T$, from 200 random starts.

| spectrum | $\mu$ mine | $T$ mine | $\Phi$ mine | best diagonal mine | ratio mine | ratio record |
|---|---|---|---|---|---|---|
| $(1,-3,2)$ | $11.600595$ | $178.24056$ | $2143.11070$ | $3290.15600$ | $1.53522$ | $1.53522$ |
| $(-1,-3,4)$ | $24.438696$ | $645.49843$ | $19982.00695$ | $28862.00930$ | $1.44440$ | $1.44440$ |
| $(19,-20,1)$ | $762.384530$ | $350181.39498$ | $526210564.39230$ | $577574913.91962$ | $1.09761$ | $1.09761$ |

$[A,C]$ residuals $6\cdot10^{-13}$, $7\cdot10^{-12}$ and $2\cdot10^{-7}$, and $C$ off-diagonal in $A$'s frame at most $5\cdot10^{-11}$, both in the band the block reports. The diagonal configuration wins at all three, and my maximiser found the same optimum the record's did.

**What to correct: the table prints more digits than the points carry.** My $\Phi$ differs from the record's by $-0.00264$, $-0.00849$ and $+0.36983$, and in each case the difference is $2\mu\,\Delta T$ for the $\Delta T$ between my $T$ and the record's rounded $T$, which is the envelope derivative $\mathrm d\Phi/\mathrm dT=2\mu$ of batch 20's own identity. So the two runs agree on the same point to the precision the point is converged to, and the last four or five digits of $\Phi$ and of the best diagonal are noise. **I would print $\Phi$ to the precision $[A,C]$ supports**, which at the third row is about nine significant figures, not fifteen.

### Claim 7 PLAUSIBLE, scope narrowed

The premise checks out. I recomputed batch 33's orbit bound from its own form $Q(\Omega)\ge0$ as a generalised eigenvalue problem in the three skew parameters, independently of the record:

| spectrum | $\mu$ | batch 18 | batch 21 | orbit | binding | $\mu/\text{binding}$ |
|---|---|---|---|---|---|---|
| $(1,-3,2)$ | $11.60060$ | $6.8739$ | $11.25$ | $11.4602$ | $11.4602$ | $1.0122$ |
| $(-1,-3,4)$ | $24.43870$ | $9.3675$ | $11.25$ | $24.0097$ | $24.0097$ | $1.0179$ |
| $(19,-20,1)$ | $762.38453$ | $50.7124$ | $75$ | $105.6927$ | $105.6927$ | $7.2132$ |

Batch 33's $11.274$, $-12.529$, $97.950$ and $105.693$ all reproduce. So "one per cent" and "a factor of seven" are right, and they are margins against the **orbit** bound, which is the binding one at all three. *Neither the block nor the brief says which bound binds*, and against the two the brief does supply, batches 18 and 21, the second point clears by $117\%$ rather than by one per cent. **I would name the orbit bound in the sentence**, because as written the claim is unverifiable from the block.

**Three reasons the conclusion is narrower than stated.**

1. **Three points.** An anti-correlation across three observations, two of which are nearly tied on one axis, supports "the loosest point on the multiplier bounds is the tightest on value" and not "nearness in the second-order conditions says nothing about nearness in value".
2. **A scale confound the block does not address.** $T$ is $178$, $645$ and $350181$. $\Phi$ is not homogeneous, its field terms being linear where its internal terms are cubic, and at the third point $\langle V,C\rangle=5.24\cdot10^8$ out of $\Phi=5.26\cdot10^8$, so that row is field-dominated in a way the other two are not. The ordering of the ratios tracks $T$ as faithfully as it tracks the multiplier margin, and three points cannot separate the two.
3. **The ratios are optimiser-dependent, which is the next claim.**

### Claim 8 CONFIRMED, and it does not cover claim 7

The witness logic is sound for what it is asked to protect. Any feasible diagonal configuration at the same $T$ whose value exceeds $\Phi$ at the point proves that *some* diagonal configuration beats it, and a better optimiser raises the diagonal value, so the conclusion "the diagonal wins" is monotone in optimiser quality. My independent maximiser agreeing to nine significant figures is further evidence the optimum is genuine.

**But the block deploys it one claim too far.** It appears under batch 35's conclusions as though it immunises the section, and claim 7 is built from the *ratios*, which a better optimiser changes. Each ratio can only rise, and they are $1.535$, $1.444$ and $1.098$, so an optimiser that underperformed at the third row by ten per cent would reverse the anti-correlation outright. **The witness argument protects the win and not the margins**, and the block should say so where it makes the anti-correlation the finding.

---

## What I would change in the record

1. **[2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), the "Gram route is EXHAUSTED" section: withdraw "exhausted" and restore the two struck recommendations.** Replace with the exact system $\sum u_i^2\le t-\tfrac32\sum x_i^2+\tfrac9{10}(\sum x_i)^2$, an identity on $\Sigma$, and the necessary condition $\sum x_i^2\ge\tfrac56(\sum u_i^2-t)$ it implies. Keep the finding that the scalar corollary in $t$ alone is exact, which is real. State that whether the system closes the $0.02$ is open.
2. **Same section: add the complementarity sentence.** $Q_1\cap Q_2$ and $Q_1\cap Q_3$ are complementary in $Q_1$, so both carry $x_1$. Without it the single shared channel, and therefore the parity argument, looks like a choice of labels.
3. **[2026-09-15-I106-m3-derivation.md](2026-09-15-I106-m3-derivation.md) batch 34: "it is not a bound" to "it is not an a priori bound", and "implied by batch 18 alone" to "implied by batch 18 with the display's own two ingredients".** Both are the block's own meaning stated accurately.
4. **Batch 35: name the orbit bound as the binding one** in the anti-correlation sentence, and **print $\Phi$ and the best diagonal to the precision $[A,C]$ supports**.
5. **Batch 35: scope the witness argument** to the win, and say that the anti-correlation's margins are optimiser-dependent.
6. **[I106aOrthostochastic.lean](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean) header and the I106a note: the converse is no longer a standing debt.** Record the construction above, and with it that R28's maximum over the variety is exact.
7. **I106a block C: restate the signs** as $\varepsilon_1=\mathop{\mathrm{sgn}}(u)\mathop{\mathrm{sgn}}(v)$, $\varepsilon_2=\mathop{\mathrm{sgn}}(u)\mathop{\mathrm{sgn}}(t)$, and reframe "more hypotheses" as the forward direction needing fewer while the reverse needs exactly those.

## Could Lean carry these

| claim | Lean |
|---|---|
| 1, 2, 3, 5 | **Yes, and 5 is a `ring`/`linarith` one-liner** once the two pairings are hypotheses. 1 and 3 need $\lambda_{\max}(\mathcal L_{\hat U})=\lvert\hat U\rvert/\sqrt6$, which is a real piece of work: the clean route is the $2\times2$ traceless restriction to the diagonal sector plus $3u_{\min}^2\le2\lvert\hat U\rvert^2$ for the off-diagonal sector. |
| 4, 6, 7 | **No, and they should not be.** Numerical exhibits. |
| 8 | The witness *schema* is typeable as "a feasible point bounds a supremum below", a `le_csSup`. The instance is numerical. |
| 9, 10 | **Yes**, as finite-dimensional linear algebra over an explicit six-index model: the rank-one factorisation, $G_e=\tfrac23I+\tfrac13J$, its spectrum, and the parity are all `Matrix` and `decide`-scale facts once the patterns are written down. |
| 11 | The **exact system** is typeable and worth typing, being the inequality above. "Exhausted" is not a mathematical statement and could not have been typed, which is part of why it went unchecked. |
| 12, 13 | Typed already, and the statements match the prose. **The converse is now typeable**: `∃ Q, Q ∈ Matrix.orthogonalGroup (Fin 3) ℝ ∧ Q ∘ Q = B`, with the construction above as the witness. |

## Method

Everything here was derived from the brief's definitions and checked by my own code. Runs: four screens, the longest 27 seconds, all on objects constructed for the check. No sweep, no census, no unbounded search. Where a number was needed, it was the smallest that did the job: batch 28's two points for claim 4, one configuration of the note's own grid for claim 11, and 3000 constructed points for the Part C converse, whose proof stands without them.
