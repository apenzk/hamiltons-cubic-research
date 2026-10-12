# Review r963: Gate 2 on batches 34 and 35, the I104 Gram exhaustion, and I106a's first piece

**Brief**: [BRIEF_debt_batches34_35_I104_I106a.md](BRIEF_debt_batches34_35_I104_I106a.md). **Log**: [agent_logs/r963-debt.log](../agent_logs/r963-debt.log).

Adversarial Gate 2 audit of four independent blocks. Everything below was derived from the brief's definitions and re-derived independently of the scripts under review. The numerics are screens of claims recorded here, each a few seconds on objects reconstructed from the record's own parametrisation.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | Batch 34's display $\mu\le2\beta\lvert\hat U\rvert/\sqrt6+\langle V,C\rangle/\lvert V\rvert^2$ holds at every critical point with $V\ne0$ | CONFIRMED |
| 2 | It is not a bound in any useful sense, being the Rayleigh inequality rearranged | CONFIRMED |
| 3 | $\langle V,C\rangle\ge0$ at a global maximum, and it is implied by batch 18 alone, hence adds nothing | CONFIRMED, and strengthened |
| 4 | $\langle V,C\rangle$ takes both signs at critical points, the two values $+65.52$ and $-18345.79$ | CONFIRMED |
| 5 | $\mu T-P_3=\Phi/2$ identically, so batch 20's "comparison of two numbers" reading was circular | CONFIRMED |
| 6 | Batch 35's three rows: the points, the fields commuting, $\Phi$ at each point and the diagonal maximum | CONFIRMED |
| 7 | The anti-correlation: tightness in the multiplier bounds does not track tightness in value | PLAUSIBLE, two corrections |
| 8 | The witness argument is sound, so optimiser quality cannot threaten batch 35's conclusion | CONFIRMED |
| 9 | I104: the cross-Gram has rank one and the principal cosines are exactly $(\tfrac13,0)$ | CONFIRMED, one phrasing correction |
| 10 | I104: the parity constraint admits only the $\lambda_{\max}=\tfrac53$ patterns, and $\sum u_i^2\le\tfrac53t$ is attained | CONFIRMED, the parity step is superfluous |
| 11 | I104: therefore the Gram route is exhausted, not lossy, and the note's own recommendation is refuted | **REFUTED as stated** |
| 12 | I106a: $(ab-xy-zw)^2=4xyzw$ from column orthogonality alone, with bistochasticity and positivity genuinely unused | CONFIRMED |
| 13 | I106a: the bridge, and that the source's signs are the signs of $u,v,t$ | CONFIRMED with a correction |

**The round's largest result is outside the table.** *Part C's converse, which the note and the Lean file both carry as the standing debt that decides whether R28 is exact, is TRUE and takes five lines.* It is proved below, with no appeal to the source's iff, and it should be recorded and typed.

---

# Part C, I106a's first piece

## Claim 12, CONFIRMED

The three lines are right and the hypothesis count is right. With $u=q_{00}q_{01}$, $v=q_{10}q_{11}$, $t=q_{20}q_{21}$ and $u+v+t=0$: $ab=(q_{20}q_{21})^2=t^2=(u+v)^2$, $xy=u^2$, $zw=v^2$, so $ab-xy-zw=2uv$ and $4xyzw=4u^2v^2=(2uv)^2$. Nothing else enters. Positivity is not used even implicitly, because no square root is taken: $x,\dots,b$ are *defined* as the entrywise squares and $u,v,t$ are signed products of matrix entries. Bistochasticity is not used, and neither is any relation among the third column's entries.

**One scope note the record should carry.** The identity is a fact about six *products of entries*, not about six free reals: $(ab-xy-zw)^2=4xyzw$ is false for general reals satisfying no relation, and the hypothesis that carries it is $\sqrt{xy}\pm\sqrt{zw}\pm\sqrt{ab}=0$ in disguise. [orthostochastic_eq](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean) states it correctly in the $q$ variables, so the Lean layer is exact where the prose sentence "a fact about any real matrix with two orthogonal columns" is merely true.

## Claim 13, CONFIRMED with a correction

The bridge is arithmetic and checks: $(1-x-z)(1-y-w)-xy-zw=1-x-y-z-w+xw+yz$. [bridge](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean) states exactly this, and [orthostochastic_poly](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean) assumes only the two column sums rather than full bistochasticity, which matches the prose.

**The correction.** "The source's sign choices $\varepsilon_1,\varepsilon_2$ are exactly the signs of $u$, $v$ and $t$" counts three signs into two slots. The source's relation is $\sqrt{xy}+\varepsilon_1\sqrt{zw}+\varepsilon_2\sqrt{ab}=0$ with $\sqrt{xy}=\lvert u\rvert$, $\sqrt{zw}=\lvert v\rvert$ and $\sqrt{ab}=\lvert t\rvert$. Dividing $u+v+t=0$ by $\operatorname{sgn}u$ gives
$$\varepsilon_1=\operatorname{sgn}(uv),\qquad\varepsilon_2=\operatorname{sgn}(ut),$$
the RELATIVE signs. When $u=0$ the relation reads $\lvert v\rvert=\lvert t\rvert$ and $\varepsilon_1$ is free with $\varepsilon_2=-\varepsilon_1$. Write it as the relative signs and the sentence is exactly true.

## The converse, PROVED, and the debt is dischargeable

**Proposition.** Let $B$ be a $3\times3$ bistochastic matrix with $(b_{31}b_{32}-b_{11}b_{12}-b_{21}b_{22})^2=4\,b_{11}b_{12}b_{21}b_{22}$. Then $B=Q^{\circ2}$ for some $Q\in SO(3)$.

**Proof.** Put $s_i=\sqrt{b_{i1}b_{i2}}\ge0$, real because the entries are nonnegative. The hypothesis is $(s_3^2-s_1^2-s_2^2)^2=(2s_1s_2)^2$, so $s_3^2=(s_1+s_2)^2$ or $s_3^2=(s_1-s_2)^2$, that is $s_3=s_1+s_2$ or $s_3=\lvert s_1-s_2\rvert$. In either case there are signs $\varepsilon\in\{\pm1\}^3$ with $\varepsilon_1s_1+\varepsilon_2s_2+\varepsilon_3s_3=0$, namely $(1,1,-1)$ in the first case and $(1,-1,-1)$ or $(-1,1,-1)$ in the second. Set
$$c_1=\big(\sqrt{b_{11}},\sqrt{b_{21}},\sqrt{b_{31}}\big),\qquad c_2=\big(\varepsilon_1\sqrt{b_{12}},\varepsilon_2\sqrt{b_{22}},\varepsilon_3\sqrt{b_{32}}\big).$$
Then $c_1\cdot c_2=\sum_i\varepsilon_is_i=0$, and $\lvert c_1\rvert^2=\lvert c_2\rvert^2=1$ by the first two COLUMN sums. Take $c_3=c_1\times c_2$, so $Q=(c_1,c_2,c_3)\in SO(3)$ and its ROWS are unit, giving $q_{i3}^2=1-b_{i1}-b_{i2}=b_{i3}$ by the row sums. Hence $Q^{\circ2}=B$. $\square$

**What this settles, and what it costs.** *R28's maximum over the variety is the true maximum and not an upper bound*, on this factor. The proof needs neither Au-Yeung and Poon nor any case analysis beyond the single $\pm$ from the square root, and it is self-contained: the source's iff is re-proved rather than cited.

**The hypothesis count reverses between the two directions, and that is the finding worth recording.** The forward direction uses one linear relation and neither positivity nor bistochasticity. The converse uses BOTH: positivity so that $s_i$ is real, the two column sums so that $c_1,c_2$ are unit, and the three row sums so that the third column squares correctly. **So the source is not over-hypothesised, it is stating the direction that needs the hypotheses**, and the block's "the source states this with more hypotheses" is true only of the half it proved.

**Where the signs reappear.** The polynomial form is genuinely sign-free forwards. Backwards the $\pm$ of the square root is exactly the choice between $s_3=s_1+s_2$ and $s_3=\lvert s_1-s_2\rvert$, which is the source's $\varepsilon$, so the case analysis the block says is unnecessary is unnecessary forwards and is one line backwards.

**Screened as well as proved.** $133086$ bistochastic points sampled ON the variety (by solving the equation for $w$ at random $x,y,z$ and keeping the nonnegative branches, so not sampled from $O(3)$) were all realised as $Q^{\circ2}$ by the construction above, none failing. That is a control on the proof rather than its evidence, and it is a strictly larger and better-targeted sample than the note's $60$.

## Lean

`orthostochastic_eq`, `bridge` and `orthostochastic_poly` say what the prose says, checked statement against prose line by line. **The converse should now be typed**: `Real.sqrt`, `Matrix.det` and the cross product are all in Mathlib, the sign case split is a `rcases` on `sq_eq_sq'`, and the only real work is the row-orthonormality step, which is `Matrix.mem_orthogonalGroup` plus `Real.sq_sqrt` on nonnegative entries.

---

# Part B, the I104 Gram exhaustion

## Claim 9, CONFIRMED, with one phrasing correction

$\Pi_{Q_1}$ and $\Pi_{Q_2}$ are supported on the pairs inside $Q_1$ and inside $Q_2$, so they share exactly the pairs inside $Q_1\cap Q_2=\{i,j\}$, which is the single pair $ij$. The rigidity the block names is real and is forced by $Q_3=Q_1\triangle Q_2$: the two pairs $Q_1$ shares with the others are $ij$ and $kl$, which are the two halves of ONE of the three perfect matchings of $Q_1$, and the pattern gives both the same entry $x_1$. The same holds at $Q_2$ with $\{ij,mp\}$ and at $Q_3$ with $\{kl,mp\}$. So each plane has a single shared channel, $\langle q_a,q_b\rangle=x_ax_b$ factors through one functional per plane, and the cross-Gram has rank one.

The nonzero principal cosine is $\max\lvert x\rvert^2$ over unit patterns. With $x+y+z=0$ and $2(x^2+y^2+z^2)=1$, $y^2+z^2\ge\tfrac12(y+z)^2=\tfrac12x^2$ gives $x^2\le\tfrac13$, attained at $y=z=-x/2$, so the cosines are $(\tfrac13,0)$ exactly. **Verified explicitly** at $n=6$ on the six orthonormal basis patterns: cross-Gram singular values $(0.333333,0)$, and the row sums of every pattern vanish, so $x+y+z=0$ IS the $\mathcal D_n$ membership condition rather than a normalisation.

**The correction.** "Exactly $(\tfrac13,0)$ rather than 'at most $\tfrac13$'" conflates two different quantities. The principal cosine of the PLANE PAIR is exactly $\tfrac13$. The realised cosine of the actual projections is $\langle\hat q_1,\hat q_2\rangle=\tfrac13\cos\phi_1\cos\phi_2$, where $\phi_a$ is the angle of $q_a$ to $\hat e_a$ inside $\Pi_a$, and that is strictly below $\tfrac13$ at every shape but one. **L221 step 3's "at most $\tfrac13$" is therefore the correct statement about the objects the chain uses, and it is not superseded.**

## Claim 10, CONFIRMED, and the parity step is superfluous

$\hat f_a$ is orthogonal to every other plane, since $\langle\hat f_a,q_b\rangle=x_a(\hat f_a)x_b(q_b)=0$. So the $6\times6$ Gram splits as $G_e\oplus I_3$, and $\sum_a\lVert P_aD\rVert^2=\langle(\sum_aP_a)D,D\rangle\le\lambda_{\max}(G_6)\,t$ because $\sum_aP_a=BB^{\mathsf T}$ shares its nonzero spectrum with $G_6=B^{\mathsf T}B$. Explicitly at $n=6$ the Gram is unit diagonal with $\tfrac13$ on the three $e$ pairs and zero elsewhere, spectrum $(\tfrac23,\tfrac23,1,1,1,\tfrac53)$, and $D$ along the top eigenvector gives $\sum u_i^2/t=1.6666667$. **Attainment independently confirmed.**

The parity argument is correct. The three cosines multiply to $(x_1x_2x_3)^2>0$, so the signed triangle is unfrustrated, and a $3\times3$ unit-diagonal matrix with off-diagonals $\pm\tfrac13$ has $\lambda_{\max}=\tfrac53$ when the edge signs multiply to $+1$ and $\tfrac43$ when they multiply to $-1$, since the signed triangle's adjacency has spectrum $(2,-1,-1)$ or $(-2,1,1)$ by sign switching. **It is also unnecessary.** Orienting each $\hat e_a$ so that its shared-channel coordinate is $+1/\sqrt3$ makes all three cosines $+\tfrac13$ outright, which is what the explicit Gram shows. The parity is the switching-invariant form of that choice, so the block reaches a true conclusion by a longer route than the geometry needs.

## Claim 11, REFUTED as stated

**What survives.** The scalar inequality $\sum_iu_i^2\le\lambda\,t$ holds with $\lambda=\tfrac53$ and with no smaller $\lambda$, because $\tfrac53$ is attained. *That part is exact, it is proved, and it closes the question of the constant for good.*

**What does not survive is the word "exhausted" and the refutation of the recommendation.** Three independent reasons.

- **The recommendation named a system and the block delivered one scalar.** The [$\tau>0$ note](2026-09-14-I104-tau-positive.md) asks for "the coupling between blocks through $D$, the Gram system of the three pattern projections". The system is available in closed form from the same rank-one geometry. With $q_a=\alpha_a\hat e_a+\beta_a\hat f_a$, $u_a^2=\alpha_a^2+\beta_a^2$ and $G_e^{-1}=\tfrac32I-\tfrac3{10}J$, minimality of the $e$-part gives
$$t\ \ge\ \sum_a\beta_a^2+\tfrac32\sum_a\alpha_a^2-\tfrac3{10}\Big(\sum_a\alpha_a\Big)^2,\qquad\langle q_a,q_b\rangle=\tfrac13\alpha_a\alpha_b .$$
That constrains the three $u_a$ JOINTLY against $t$ and against the realised cosines. Maximising $\sum u_a^2$ over it returns $\tfrac53t$, which is the block's bound, and that is one consequence of the system rather than the system. **Whether the system closes the $0.02$ is untested, so the recommendation is open rather than refuted.**
- **The bound was never binding where the chain fails.** At the note's most permissive surviving configuration, $N_a=0.134$, $u_a=0.496$, $t=0.598$, one has $\sum u_a^2/t=1.234$, so the Gram inequality is slack by $0.26$ there. The $\tfrac53$ is attained at a DIFFERENT $D$, one lying wholly in the three $e$-channels with $\beta_a=0$ and nothing outside $\Sigma$. **Exactness of a worst case over all $D$ says nothing about the configuration that survives**, and the note's own diagnosis, that the $\tfrac13$ "is a worst case over shapes, attained only at shapes the pinning does not select", is untouched by claim 9: the realised cosine is $\tfrac13\cos\phi_1\cos\phi_2$ and remains shape-dependent.
- **The block's own last sentence continues the route it declares closed.** "The slack is that $r_i=D-q_i$ still carries the other two patterns' components, **confined by the rank-one structure to the single $\hat e_i$ channel**" is the Gram system being fed into $\kappa_i$. That is the recommended treatment doing work, one sentence after being pronounced dead.

**What I would put in its place.** *The scalar Gram bound $\sum u_i^2\le\tfrac53t$ is exact and attained, so the constant cannot be improved and the $0.02$ will not come from improving it.* **The Gram system is not spent**: it survives as the joint constraint displayed above and as the rank-one confinement of $r_i$ to the $\hat e_i$ channel, which is the form in which it should now be carried into the $\kappa_i$ estimate. The heading "The Gram route is EXHAUSTED" should read "The Gram CONSTANT is exact", and the two sentences corrected in place above it should be restored with that scope.

## Lean

Claims 9 and 10 could be carried, and the cheapest useful piece is the linear algebra with the combinatorics as hypotheses: the $3\times3$ matrix $I+\tfrac13(J-I)$ has top eigenvalue $\tfrac53$ with eigenvector $(1,1,1)$, and $\sum_a\lVert P_aD\rVert^2\le\lambda_{\max}\lVert D\rVert^2$ for projections whose Gram is that matrix. Claim 11 is a claim about what a class of arguments can achieve and is not a Lean statement at all, which is part of why it should be worded as a fact about one constant.

---

# Part A, batches 34 and 35

## Claim 1, CONFIRMED

Pairing the $V$ equation $C=\mu V-\beta\{\hat U,V\}$ with $V$ and using $\operatorname{tr}(V\{\hat U,V\})=2\operatorname{tr}(\hat UV^2)$ gives $\mu\lvert V\rvert^2=2\beta\operatorname{tr}(\hat UV^2)+\langle V,C\rangle$. Since $\operatorname{tr}(\hat UV^2)=\langle\mathcal L_{\hat U}V,V\rangle$ and $\beta=\tfrac94>0$, batch 18's cap gives the display, dividing by $\lvert V\rvert^2>0$. **The cap itself re-screened**: over $4000$ random traceless symmetric $\hat U$, the top eigenvalue of $\mathcal L_{\hat U}$ compressed to the five-dimensional traceless symmetric space equals $\lvert\hat U\rvert/\sqrt6$ to $1.8\cdot10^{-15}$, an equality rather than an inequality.

## Claim 2, CONFIRMED

Substituting the pairing back into the display gives $0\le2\beta\big(\lvert\hat U\rvert/\sqrt6-\operatorname{tr}(\hat UV^2)/\lvert V\rvert^2\big)$. **The display is EQUIVALENT to the Rayleigh inequality, not merely implied by it**, which is a sharper statement than the block makes and supports its verdict rather than weakening it.

## Claim 3, CONFIRMED, and the block understates its own case in one direction while overstating it in another

The implication is two lines and no more. $\langle V,C\rangle=\mu\lvert V\rvert^2-2\beta\operatorname{tr}(\hat UV^2)\ge\mu\lvert V\rvert^2-2\beta(\lvert\hat U\rvert/\sqrt6)\lvert V\rvert^2\ge0$, the first step by the Rayleigh cap and the second by batch 18. So the corollary carries nothing the record did not have.

**"Implied by batch 18 alone" is slightly generous to the criticism**: it also needs the $V$ pairing, which is criticality, and the Rayleigh cap. The honest form is "implied by batch 18 and the same pairing the display came from", which is if anything a stronger statement of the redundancy.

**And the corollary excludes nothing, which the block does not say.** At batch 35's three survivors $\langle V,C\rangle$ is $+1520.89$, $+18345.79$ and $+524459203$, all positive. *The necessary condition is satisfied at every point that presses on the node*, so it is not merely redundant in derivation, it is empty in use.

## Claim 4, CONFIRMED

Reconstructing batch 28's points from the record's own parametrisation ($\hat U=\operatorname{diag}(3,1,-4)$, $V$ with diagonal $(a_1,a_2,-a_1-a_2)$, $V_{12}=0$, $V_{13}=V_{23}=1$) and refining $\mu$ from the quadratic rather than from its printed five decimals:

| $\mu$ | $\langle V,C\rangle$ | record |
|---|---|---|
| $-6.06130353$ | $+65.5198$ | $+65.52$ |
| $-24.43869647$ | $-18345.7886$ | $-18345.79$ |

Both exact. **The convention was recovered rather than assumed**: the $(1,2)$ entry of $[A,C]$ comes out as $-\tfrac{81}{16}(a_1D_2-a_2D_1)$ with $D_2=2u_1+u_2$ and $D_1=u_1+2u_2$, which is batch 28's $7a_1=5a_2$ at this spectrum, so the reconstruction is pinned by the record's own reported identity.

**Batch 29's quadratic re-derived symbolically as a control.** Eliminating $a_1^2,a_2^2$ between the other two commutator entries and imposing $a_1D_2=a_2D_1$ gives a quadratic in $\mu$ whose coefficients are exactly the record's $(c_2,c_1,c_0)$ multiplied by the common factor $u_1-u_2$, which vanishes only on the degenerate spectrum the case excludes. Its roots reproduce $762.38453018$, $5.61546982$, $11.60059515$, $7.39940485$, $24.43869647$ and $-6.06130353$.

## Claim 5, CONFIRMED

From the two pairings, $\Phi=\alpha\operatorname{tr}\hat U^3+\beta\operatorname{tr}(\hat UV^2)+\langle\hat U,A\rangle+\langle V,C\rangle=3\mu\lvert\hat U\rvert^2+\mu\lvert V\rvert^2-2P_3=2\mu T-2P_3$, using $2T=3\lvert\hat U\rvert^2+\lvert V\rvert^2$. So $\mu T-P_3=\Phi/2$ identically at every critical point, and the correction batch 34 made to batch 20 is right: comparing $\mu T-P_3$ between two points IS comparing $\Phi$.

**What the identity does give, since the brief asks.** The replacement wording is informative and is not circular in the same way. *A priori $\Phi$ has four terms of which two involve the fields, and the identity says those two are determined by $\mu$, $T$ and $P_3$.* Concretely $\langle\hat U,A\rangle+\langle V,C\rangle=2\mu T-3P_3$, an elimination of the fields rather than a restatement of $\Phi$. **The circularity is in the USE, not in the identity**: the identity cannot rank two configurations, because obtaining $\mu$ and $P_3$ at either one requires solving for it. Both this and the block's wording are right, and they answer different questions.

## Claim 6, CONFIRMED

Every entry of batch 35's table reproduced from the reconstructed points, with $\mu$ taken at the record's printed precision so that the comparison is of the same objects:

| spectrum | $T$ | $\Phi$ | best diagonal | ratio |
|---|---|---|---|---|
| $(1,-3,2)$ | $178.2407$ | $2143.11342$ | $3290.15974$ | $1.53522$ |
| $(-1,-3,4)$ | $645.4986$ | $19982.01753$ | $28862.02427$ | $1.44440$ |
| $(19,-20,1)$ | $350181.3948$ | $526210564.038$ | $577574913.538$ | $1.09761$ |

$\Phi$ was computed twice, once from its definition with $A$ and $C$ at their Lagrange forms and once from $2\mu T-2P_3$, agreeing to all printed digits, so claim 5 doubles as the control on claim 6. The best diagonal came from $400$ random restarts of a constrained maximisation of $\alpha\sum p_i^3+\beta\sum p_iq_i^2+\sum p_iA_i+\sum q_iC_i$ at $\tfrac32\lvert p\rvert^2+\tfrac12\lvert q\rvert^2=T$ in the fields' common frame, reached independently of the filed script, and the three ratios match to five decimals.

**The fields do commute.** $C$ is diagonal in $A$'s eigenframe to $4.5\cdot10^{-7}$, $4.8\cdot10^{-7}$ and $2.3\cdot10^{-9}$ at the printed $\mu$, and with $\mu$ refined from the quadratic the residual $\lVert[A,C]\rVert_{\max}$ falls to $4.6\cdot10^{-13}$, $3.6\cdot10^{-12}$ and $1.2\cdot10^{-7}$, matching the record's stated range of $4\cdot10^{-12}$ to $2\cdot10^{-7}$. **Relative to $\lVert A\rVert\lVert C\rVert$ all three are between $10^{-17}$ and $10^{-19}$**, which is the figure the record should quote, since the absolute residual at $(19,-20,1)$ is large only because the fields there are of size $10^{5}$.

## Claim 7, PLAUSIBLE, with two corrections

The numbers are right and the ordering is monotone across the three points: multiplier margins $1.012$, $1.018$, $7.213$ against value ratios $1.53522$, $1.44440$, $1.09761$.

- **A transposition in the prose.** "The two points that clear the multiplier bounds by one per cent lose the value comparison by $44\%$ and $54\%$" names $(1,-3,2)$ first and $(-1,-3,4)$ second in the sentence before, but their ratios are $1.535$ and $1.444$, so read in the order given the numbers are swapped. It should be "$54\%$ and $44\%$".
- **The trend is a two-cluster contrast, and the third cluster has a known independent cause.** The two tight-$\mu$ points sit almost on top of each other in both coordinates, so the anti-correlation rests entirely on the contrast with $(19,-20,1)$. That point is $n=19$ of the family $(n,-(n+1),1)$ whose $1.09$ floor **batch 29 already explained as a degenerate corner rather than as non-commutativity**, and the reconstruction confirms the signature: $\lVert K\rVert/(\lvert\hat U\rvert\lvert V\rvert)=0.0017$ and $\lvert V\rvert/\lvert\hat U\rvert=30.3$ there, against $0.109$ and $4.74$, and $0.069$ and $6.83$, at the other two. **So the value margin at the tight end is small for the reason batch 29 recorded, not for a reason the multiplier margin fails to see.**

*The conclusion "nearness in the second-order conditions says nothing about nearness in value" survives both corrections, since one clean counter-ordering suffices to refute a claimed correlation.* What does not survive is reading the three rows as a trend.

## Claim 8, CONFIRMED

The logic is sound and the block states it correctly. The comparison is an existential: some configuration diagonal in the fields' common frame, at the same $T$ and against the same $A$ and $C$, has larger $\Phi$ than the critical point, so the point is not a global maximum. A local optimum of the diagonal problem is a witness for that existential and a better optimiser only raises the witness's value. **The two conditions the argument actually depends on are the ones the block checks**: that the point is a critical point of the block problem, which is $[A,C]=0$, and that the competitor lies on the same constraint surface. Both hold. *The residual exposure is arithmetic in evaluating $\Phi$ at the two configurations, and the independent reproduction above removes it.*

## Lean

- Claims 1 and 3 could be carried as inequalities once $\lambda_{\max}(\mathcal L_{\hat U})=\lvert\hat U\rvert/\sqrt6$ is typed, which is the only real work and is a finite-dimensional eigenvalue computation on the traceless symmetric $3\times3$ matrices.
- **Claim 2 is the one worth typing and is not obvious that it can be**, because it is an equivalence rather than an implication: given the $V$ pairing, the display holds if and only if the Rayleigh inequality holds. Typed that way it records the emptiness as a theorem instead of as prose.
- Claim 5 is already typed as `value_at_critical`, and $\mu T-P_3=\Phi/2$ follows from it by `linarith`.
- **Claim 8's logic should be typed and is two lines**: if some admissible configuration has strictly larger $\Phi$, the point is not a global maximum. That is the load-bearing step of batch 35, and typing it separates the argument from the three numbers.
- Claims 4, 6 and 7 are numerical and should not be typed.

---

# What I would change in the record

1. **Record the Part C converse as a proposition and type it.** It discharges the debt that [I106aOrthostochastic.lean](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean) and the [note](2026-09-16-I106a-orthostochastic.md) both name as standing, and it decides that R28's maximum over this variety is exact rather than an upper bound. Add with it the observation that the hypothesis count reverses: positivity and both sets of sums are used backwards, so the source is stating the direction that needs them.
2. **Replace "the signs of $u$, $v$ and $t$" with the relative signs** $\varepsilon_1=\operatorname{sgn}(uv)$, $\varepsilon_2=\operatorname{sgn}(ut)$, and note that $u=0$ leaves $\varepsilon_1$ free with $\varepsilon_2=-\varepsilon_1$.
3. **Rewrite I104's heading and conclusion.** "The Gram CONSTANT is exact" in place of "The Gram route is EXHAUSTED", with the joint constraint $t\ge\sum\beta_a^2+\tfrac32\sum\alpha_a^2-\tfrac3{10}(\sum\alpha_a)^2$ recorded as what the system carries beyond the scalar, and the two recommending sentences restored with that scope. Note also that the realised cosine is $\tfrac13\cos\phi_1\cos\phi_2$, so L221 step 3's "at most $\tfrac13$" stands.
4. **Add to batch 34 that its corollary is empty in use**, since $\langle V,C\rangle$ is positive at all three of batch 35's survivors.
5. **Fix batch 35's "$44\%$ and $54\%$" to "$54\%$ and $44\%$"**, and scope the anti-correlation as a contrast between two clusters whose tight member is the family batch 29 already explained.
6. **Quote batch 35's $[A,C]$ residuals relative to $\lVert A\rVert\lVert C\rVert$**, where they are $10^{-17}$ to $10^{-19}$ uniformly, rather than absolutely, where the spread across three orders of magnitude is an artefact of scale.
