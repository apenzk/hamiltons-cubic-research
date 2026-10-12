# Gate 2, Reviewer 139: the Schur constant, the Peirce invariant, and the 1/2-multiplicity

Cold review of commits `1a1f28c`, `cf820f0`, `ef8843e` and `7953321`, all touching [findings/second-order.md](../findings/second-order.md). Sources read directly: [Fox 2019](https://arxiv.org/abs/1901.04012), the block-decomposition section of [findings/fence-posts.md](../findings/fence-posts.md), and a web search on Peirce-multiplicity bounds. [scripts/](../scripts/) was not read at any point. Everything numerical below was recomputed here in exact rationals from the stated definitions; the two symbolic results were derived before any number was printed.

## Verdicts

| claim | verdict |
|---|---|
| **A**, $\operatorname{tr}(L_xL_y)=\kappa_n\langle x,y\rangle$ by Schur, $\kappa_n=(n-1)(2n-1)/4$ | **CONFIRMED**, premise sound. The *identity* is [Fox](../references/fox-2019-nonassociative-curvature-algebra/) Theorem 1.3, already in this file. The *constant* was **fitted, not derived**, in these commits, Fox's Remark 1.4 leaves it open above $\dim V=4$. **Now derived here at every even $n\ge6$**, with a route to all $n$ |
| **B**, $\operatorname{tr}(L_x)=0$ | **CONFIRMED**, unconditionally, and the record's own one-line argument is complete |
| **C**, $\theta^2\sum\lambda^2=\kappa_n$, cross-checked at $S^m\times S^m$ | **CONFIRMED and UPGRADED**: closed symbolically here as an identity in $m$, discharging the open item the commit itself flagged. The corroboration is **genuine, not circular** |
| **D**, the Cauchy–Schwarz bound | **CONFIRMED as algebra**, but **OVERSTATED as to its inputs**: "the rest at most $\tfrac12$" is listed as a hypothesis and is **never used** |
| **E**, $R(n)=n^2(2n-1)/(8(n-2))$ | **CONFIRMED**, exact |
| **F**, the retraction | **CORRECT to retract**, and **OVERSTATED in the replacement**. Three defects: a wrong threshold (hence wrong miss factors and a **reversed trend**), an unflagged internal contradiction on $\operatorname{mult}(\tfrac12)$ at $S^3\times S^3$, and the discarding of a fence post that **survives** 137's refutation |

**Single most load-bearing defect: the retraction demoted a nearly unconditional fence post to "a bound nobody has", when this record already contains the bound for the entire sphere-product family.** Fix in §F.4.

---

## A. The Schur premise, and where the constant actually comes from

**The premise holds, and $n\ge5$ is not the honest scope, $n\ge4$ is.** $\mathrm{Weyl}_n$ is the $O(n)$-module of Young label $[2,2]$. Every complex-irreducible representation of $O(n)$ is of real type, so $[2,2]$ is absolutely irreducible over $\mathbb R$ and the commutant is $\mathbb R$. Restricting to $SO(n)$, a partition splits only when it has exactly $n/2$ rows; $[2,2]$ has two rows, so it splits at $n=4$ alone and stays $SO(n)$-irreducible for every $n\ge5$. This matches the record's measured commutants exactly ($1$ at $n=5\ldots10$, $2$ at $n=4$). $Q$ is equivariant under the full $O(n)$ including reflections, conjugation by a determinant $-1$ element is still a Lie-algebra automorphism of $\mathfrak{so}(n)$, so $\#$ is $O(n)$-equivariant, hence Schur applies over $O(n)$ at $n=4$ too, and the identity survives there. **Claim A's premise is not in danger at any $n\ge4$, and the brief's worry about a larger commutant is answered by the real-type property of $O(n)$, not by the numerics.**

**But the identity is not new, and the commit message says it is.** [Fox 2019](https://arxiv.org/abs/1901.04012) Theorem 1.3 states exactly $\tau_*(X,Y)=\operatorname{tr}L_*(X)L_*(Y)=\kappa\langle\cdot,\cdot\rangle$ on the Weyl subalgebra with $\kappa>0$, together with trace-freeness of the multiplication endomorphisms. [findings/second-order.md](../findings/second-order.md) already carries this three sections further down, *"these identities are Fox's Theorem 1.3, already recorded in this file, and were re-derived unwittingly"*, and records the Gate 2 landing by Reviewers 28 and 29 across $n=4\ldots13$. Commit `1a1f28c` presents the same identity as derived in that commit, at four dimensions, with no mention of the section below it. **The commit message overstates novelty and understates the verification range already on file.**

**The constant is the genuinely open part, and the brief's suspicion is exactly right.** Fox Remark 1.4, read directly: *"When $\dim V>4$, Theorem 1.3 does not give the value of the positive constant $\kappa$ such that $\tau_*=\kappa\langle\cdot,\cdot\rangle$. To calculate $\kappa$ it would suffice to calculate the eigenvalues on $MC_W(V_*)$ of the operator $\hat E$ associated with a nonzero idempotent."* Fox supplies $21/16$ at $\dim V=4$ only. So $\kappa_n=(n-1)(2n-1)/4$ answers a question the literature leaves open, and in these commits it is a fit to four numerically computed values, checked at those same four values. **That is not a derivation, and the record should not have boxed it as one.**

### A.1 The constant, derived, at every even $n\ge6$

The route is the one Fox names: take a single idempotent whose full multiplication spectrum is known. This record has one, unconditionally. [findings/fence-posts.md](../findings/fence-posts.md) proves, for $S^p\times S^q$ with $p,q\ge3$, that Nienhaus's ten-summand decomposition is multiplicity-free, so $L_e$ is a **scalar** on each summand, and it supplies every scalar. At $p=q=m$ the ten summands collapse to

| summand | eigenvalue | dimension |
|---|---|---|
| $\langle W\rangle$ | $1$ | $1$ |
| $\mathbb R^m\otimes\mathbb R^m$ | $\tfrac12$ | $m^2$ |
| $S^2_0(\mathbb R^m)$, two copies | $\lambda_m=\tfrac{m-2}{2(m-1)}$ | $(m+2)(m-1)$ |
| $\Lambda^2\otimes\Lambda^2$ | $+\mu=\tfrac1{m-1}$ | $\binom m2^2$ |
| $S^2_0\otimes S^2_0$ | $-\mu$ | $\big(\tfrac{(m-1)(m+2)}2\big)^2$ |
| $\mathrm{Weyl}_m$ twice, $X_m\otimes\mathbb R^m$ twice | $0$ | the remainder |

**The bookkeeping closes exactly**, which I checked before using it: the named multiplicities plus $2\dim\mathrm{Weyl}_m+2m\dim X_m$ equal $\dim\mathrm{Weyl}_{2m}$ identically in $m$, both sides being $m(m+2)(5m^2-10m-3)/6$ for the zero block. So the list is complete, not merely consistent.

Summing squares symbolically,

$$\sum_{\lambda\in\operatorname{spec}L_e}\lambda^2\;=\;1+\frac{m^2}4+\frac{(m-2)^2(m+2)}{4(m-1)}+\frac{m^2}4+\frac{(m+2)^2}4\;=\;\frac{m^2(4m-1)}{4(m-1)}\qquad\text{identically in }m,$$

and $\theta_0(2m)^2=\dfrac{(2m-1)(m-1)}{m^2}$, so

$$\kappa_{2m}\;=\;\theta_0(2m)^2\sum\lambda^2\;=\;\frac{(2m-1)(4m-1)}4\;=\;\frac{(n-1)(2n-1)}4,\qquad n=2m .$$

**This is a derivation, not a fit.** Its three inputs, Fox's existence theorem, the record's unconditional block spectrum, and $\theta(S^m\times S^m)=\theta_0(2m)$, are all independent of the four-point numerical sweep. It covers every even $n\ge6$, including $n=6$ where the $m=3$ eigenvalue collision changes the multiplicities but not $\sum\lambda^2$.

### A.2 How to close the odd $n$, and it is a short argument

$\kappa_nN(n)=\lVert\mu_n\rVert^2$ with $\mu_n(x,y,z)=\langle x\circ y,z\rangle$, Fox writes this identity out at his line 448. $\mu_n$ is a fixed universal contraction network built from two curvature tensors and the Weyl projector, whose coefficients are rational in $n$, so $\lVert\mu_n\rVert^2$ evaluates as a closed Brauer diagram in dimension $n$ and is a **rational function of $n$** in the stable range, this record already holds [graphical-calculus-stable-invariants-2024](../references/graphical-calculus-stable-invariants-2024/) for exactly that lemma. $N(n)$ is a polynomial. Hence $\kappa_n$ is rational in $n$, agrees with $(n-1)(2n-1)/4$ at infinitely many even $n$ by §A.1, and two rational functions agreeing at infinitely many points coincide. **Writing that lemma down turns $\kappa_n$ into a theorem at every $n$ and settles Fox's Remark 1.4 outright.** That is a better use of a cycle than any further sweep.

## B. $\operatorname{tr}(L_x)=0$

**CONFIRMED**, and the record's argument is complete as stated: $\operatorname{tr}(L_x)=\langle x,\tau\rangle$ with $\tau=\sum_kB_k\circ B_k$, which is an $O(n)$-invariant vector in $\mathrm{Weyl}_n$; the module is irreducible and nontrivial, so it carries no invariant vector and $\tau=0$. It rests on irreducibility and equivariance only, no criticality, no $\theta>0$, no dimension restriction beyond $\mathrm{Weyl}_n\ne0$. It is also Fox Theorem 1.3, and again it predates the commit.

## C. The Peirce spectrum as a complete invariant

**Not circular.** The two sides of the table have disjoint provenance. The left side is the record's block spectrum, derived from Nienhaus's isotypic decomposition, Schur on each multiplicity-free summand, and the `sharp_bilin` identity, none of which mentions $\kappa$. The right side is $\kappa_n$ from a fit at $n=5,6,7,8$, of which $n=5$ and $n=7$ are odd and so cannot have come from a balanced product at all. The brief's suspicion that $\theta_0(2m)$ and the six families share a computation is correct in the weak sense that both describe the same geometry, but $\kappa_n$ does not, and $\kappa_n$ is the only thing the table tests. **Genuine corroboration.**

**And it is now an identity.** The commit flags *"closing this symbolically would upgrade the check to an identity; six points is corroboration rather than proof."* §A.1 closes it: $\sum\lambda^2=m^2(4m-1)/(4(m-1))=\kappa_{2m}/\theta_0(2m)^2$ for all $m$, with zero difference. **That open item can be struck from the record**, and the direction of the arrow reversed, the table is better read as deriving $\kappa$ than as checking it.

## D. The Cauchy–Schwarz bound

**The algebra is right.** One eigenvalue at $1$, $M$ at $\tfrac12$, the remaining $K=N-1-M$ summing to $-(1+M/2)$ by trace-freeness, Cauchy–Schwarz giving $\sum_{\text{rest}}\lambda^2\ge(1+M/2)^2/K$. Hence

$$\operatorname{tr}(L_e^2)\ \ge\ L(n,M):=1+\frac M4+\frac{(1+M/2)^2}{N-1-M},$$

monotone increasing in $M$, so substituting the orbit dimension $D\le M$ is valid and weaker. Verified against the record's numbers: $L(6,15)=5.8125$, $L(8,28)=8.8303$, matching the table to the printed digits.

**Two scope defects.**

1. **"The rest at most $\tfrac12$" is listed as an input in all four commits and is never used.** The bound consumes only $\lambda=1$ simple, $M$ eigenvalues at $\tfrac12$, trace zero, and Cauchy–Schwarz. Naming an unused hypothesis makes the fence post look better supported than it is, it suggests the Peirce constraint has been spent when it has not.
2. **The record writes $D$ (orbit dimension) where $M=\operatorname{mult}(\tfrac12)$ is both correct and stronger.** The retraction fixes this, but §1a1f28c's headline "short by a factor of $3.4$" is computed at $D=9$ when the true $M$ at $S^3\times S^3$ is $18$; at $M=18$ the bound reads $L(6,18)=7.0385$ against $12.375$, so $\theta^2\le1.9536$ against a truth of $1.1111$, short by $1.76$, not $3.4$. **The advertised weakness of the method is itself overstated by nearly a factor of two, and at the one point the record measures.**

**Where the factor of four actually comes from, and it is not "the rest at most $\tfrac12$".** At $S^m\times S^m$ the second moment splits into four families whose shares each tend to exactly $\tfrac14$:

| family | contribution | share as $m\to\infty$ |
|---|---|---|
| $\mathbb R^m\otimes\mathbb R^m$ at $\tfrac12$ | $m^2/4$ | $1/4$ |
| $S^2_0(\mathbb R^m)$ at $\lambda_m$ | $(m-2)^2(m+2)/(4(m-1))$ | $1/4$ |
| $\Lambda^2\otimes\Lambda^2$ at $+\mu$ | $m^2/4$ | $1/4$ |
| $S^2_0\otimes S^2_0$ at $-\mu$ | $(m+2)^2/4$ | $1/4$ |

**The moment method sees the first row and nothing else, so it recovers exactly a quarter of $\operatorname{tr}(L_e^2)$, and the factor of four is that quarter.** This is sharper than the record's "the real spectrum is far more spread", and it is prescriptive: closing the gap requires lower bounds on the multiplicities at $\lambda_m$ and at $\pm\mu$ (three more Peirce families) and no amount of sharpening the Cauchy–Schwarz remainder will substitute.

## E. The target $R(n)$

$R(n)=\kappa_n/\theta_0(n)^2=\frac{(n-1)(2n-1)}4\cdot\frac{n^2}{2(n-1)(n-2)}=\frac{n^2(2n-1)}{8(n-2)}$. **CONFIRMED**, and every value in both tables reproduces in exact rationals: $12.375$, $20$, $29.6875$, $41.4$, $108.33$, $644.53$, $10075.76$. Note the consistency check the record does not draw: $R(6)=12.375$ is *exactly* the measured $\operatorname{tr}(L_e^2)$ at $S^3\times S^3$, because the balanced product attains $\theta_0$. The sphere products sit on the fence, not inside it.

## F. The retraction

### F.1 It is right to retract

$M\ge\dim\mathcal O$ is an inequality, and $M=18>15=\dim O(6)$ at $S^3\times S^3$ breaks the cap outright, not merely the orbit bound but the Lie-algebra bound. `ef8843e`'s "proved, not measured" was false. **The retraction's core is correct and the speed of it is to the record's credit.**

### F.2 But the threshold it substitutes is the wrong one

The retraction asserts *"the method closes whenever $M\gtrsim4R(n)$"* and builds its table and its miss factors on $4R$. The actual threshold is $M^*(n)$, the least $M$ with $L(n,M)\ge R(n)$, and it is materially smaller:

| $n$ | $6$ | $8$ | $10$ | $12$ | $20$ | $50$ | $200$ |
|---|---|---|---|---|---|---|---|
| $4R(n)$ as used | $49.5$ | $80.0$ | $118.8$ | $165.6$ | $433.3$ | $2578.1$ | $40303.0$ |
| true $M^*(n)$ | $29$ | $60$ | $100$ | $147$ | $416$ | $2562$ | $40287$ |
| overstatement | $71\%$ | $33\%$ | $19\%$ | $12.7\%$ | $4.2\%$ | $0.6\%$ | $0.04\%$ |

At $n=12$ (the dimension where the conjecture bites), the retraction inflates the requirement by $13\%$. **The consequence is that its headline measurement is wrong, and its trend is backwards.** The reported miss factors $5.00$, $4.60$, $4.33$ at $n=8,12,20$ are $4R/m^2$; the true $M^*/m^2$ is

| $n$ | $6$ | $8$ | $10$ | $12$ | $16$ | $20$ | $24$ |
|---|---|---|---|---|---|---|---|
| $M$ at $S^{n/2}\times S^{n/2}$ | $18$ | $16$ | $25$ | $36$ | $64$ | $100$ | $144$ |
| $M^*/M$ | $1.61$ | $3.75$ | $4.00$ | $4.08$ | $4.16$ | $4.16$ | $4.15$ |

**The miss factor rises from $3.75$ and settles just above $4$; it does not "shrink slowly" from $5.00$.** The limit is $4$ exactly, which §D explains structurally, the $\tfrac12$-family carries one of four equal quarters. The retraction's version has the right order of magnitude for the wrong reason and reports a decay that is not there.

### F.3 An internal contradiction it does not flag

The retraction refutes the cap using $\operatorname{mult}(\tfrac12)=18$ at $S^3\times S^3$, and two sentences later states *"at sphere products $\operatorname{mult}(\tfrac12)=m^2$"*, which is $9$ at the same point. **Both statements are true and the record already knows why**, [findings/fence-posts.md](../findings/fence-posts.md) proves $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, so $\mu=\tfrac12$ if and only if $p=q=3$, and the extra $\binom32^2=9$ dimensions at $m=3$ are an eigenvalue collision. Leaving the two numbers side by side unreconciled reads as an error even though it is not one, and it hides the fact that matters, which is F.4.

### F.4 The fence post that survives, and which the retraction threw away

**$M^*(n)>\dim O(n)$ at every $n$, with the ratio tending to $2$ from above:**

| $n$ | $6$ | $8$ | $12$ | $20$ | $50$ | $200$ | $400$ |
|---|---|---|---|---|---|---|---|
| $M^*/\dim O(n)$ | $1.93$ | $2.14$ | $2.23$ | $2.19$ | $2.09$ | $2.02$ | $2.01$ |

Write $M=\dim\mathcal O+X$ with $X$ the **accidental** $\tfrac12$-excess. Since $\dim\mathcal O\le\dim O(n)$ always, the moment method is dead at every critical point with $X\le\dim O(n)$, in particular **at every Morse–Bott nondegenerate critical point**, where $X=0$. And [findings/fence-posts.md](../findings/fence-posts.md) proves, unconditionally and by a symbolic solve over all $45$ summand pairs, that $X=0$ at **every** $S^p\times S^q$ with $p,q\ge3$ except $(3,3)$, where $X=9$ against a requirement of $M^*(6)=29$.

So the honest fence post is not "dead if $\operatorname{mult}(\tfrac12)\le\dim O(n)$, a hypothesis 137 refuted". It is:

> **The moment method closes only against a critical point whose $\tfrac12$-eigenspace exceeds its orbit tangent by more than $\dim O(n)$, an accidental multiplicity of order $n^2$, roughly twice $\dim\mathfrak{so}(n)$, with none of it group-generated. The record's own theorem shows the excess is zero across the entire two-parameter sphere-product family bar one provably unique point, where it falls short by a further factor of three.**

That is nearly unconditional, it is immune to 137's counterexample, and it is a far stronger statement than "a conditional and a measurement". **The retraction over-corrected: having found the cap unproved, it declared the sub-target to be "a $\tfrac12$-multiplicity bound nobody has" while the record already holds that bound for every point in the family it can compute.** Note also the group-theoretic direction of travel: a *large* orbit means a *small* stabiliser, so symmetry cannot manufacture the required $X$, the requirement is for an accident twice the size of the whole orthogonal Lie algebra.

### F.5 The structural reason the method cannot be repaired

Two facts, both derived here and then checked numerically.

**(i) The upper bound on $M$ the brief asks for exists, is one line, and points the wrong way.** From $\operatorname{tr}(L_e^2)\ge1+M/4$,

$$M\ \le\ 4\Big(\frac{\kappa_n}{\theta^2}-1\Big),$$

at every critical point. At a hypothetical counterexample $\theta>\theta_0$ gives $M<4(R-1)$. So being a counterexample **already implies** $M<M^*$: the contrapositive of the method is not an extra constraint on counterexamples, it is a restatement of them. Any theorem of the form "$\theta>\theta_0\Rightarrow M\ge M^*$" therefore proves $\operatorname{tr}(L_e^2)\ge R$ *en route*, and is strictly stronger than the conclusion it is being recruited to establish.

**(ii) The trace-zero half of the method contributes an additive constant.** Solving $L(n,M^*)=R$ asymptotically: the remainder term $t=(1+M/2)^2/(N-1-M)$ at $M\approx4R\approx n^2$ with $N\approx n^4/12$ tends to $(n^2/2)^2/(n^4/12)=3$, so $M^*=4R-4-4t=4R-16+o(1)$. Measured: $4R-M^*$ is $16.04$ at $n=200$ and $16.01$ at $n=400$, with $t=3.045$ and $3.022$. **The whole apparatus of trace-freeness plus Cauchy–Schwarz buys $16$ dimensions of multiplicity out of a requirement of $\sim n^2$.** The method is not a two-moment method at all; it is the single inequality $\operatorname{tr}(L_e^2)\ge1+\operatorname{mult}(\tfrac12)/4$, plus $16$.

Together: sharpening the remainder is worthless, and the only live quantity is the $\tfrac12$-multiplicity, which §D shows carries exactly a quarter of the second moment at the one family where it can be computed.

## Literature

**On $\kappa_n$.** [Fox 2019](../references/fox-2019-nonassociative-curvature-algebra/) has the identity (Theorem 1.3) and explicitly leaves the constant open above $\dim V=4$ (Remark 1.4), giving $21/16$ at $\dim V=4$ under his normalisation. **No closed form for $\kappa_n$ at general $n$ is in the literature.** The record's value therefore answers a stated open question, which makes §A.2 worth the cycle. Fox's line 448 also supplies the identity $\kappa\dim A=\lVert\mu\rVert^2$ that §A.2 runs on.

**On bounding $\operatorname{mult}(\tfrac12)$.** The relevant body of work is [Tkachev, the universality of one half](https://arxiv.org/abs/1808.03808) and the Hsiang/axial-algebra literature. There **is** a multiplicity-constancy theorem there, in a Hsiang algebra every idempotent has the same spectrum, inside $\{-1,-\tfrac12,\tfrac12,1\}$, with multiplicities independent of the idempotent, but it **does not transfer**: $\mathrm{Weyl}_n$'s Peirce spectrum varies from point to point ($\pm\tfrac1{m-1}$ and $\tfrac{m-2}{2(m-1)}$ at the balanced product, $\tfrac12+\tfrac1{2(n-3)}$ at $S^2\times S^{n-2}$, $\tfrac{m+2}{2(m+1)}$ on the $\mathfrak u(m)$ family), so it is not a Hsiang algebra and $\operatorname{mult}(\tfrac12)$ is **not an algebra invariant here**. **Consequence for the sub-target: no point-independent upper bound on $M$ can exist, so the search should be for a point-dependent one, and §F.5(i) is the only such bound available, and it is the wrong way round.** [Krasnov–Tkachev](../references/krasnov-tkachev-2018-idempotent-variety/)'s $n-1$ Peirce syzygies remain scoped out by non-genericity, as the record already records.

## Localising the disagreement in [scripts/](../scripts/)

Read only after the above was written. **None of the four commits carries a script**, and no file under [scripts/](../scripts/) computes $R(n)$, $L(n,M)$, or the threshold $M^*$, the search for the moment-method tables returns nothing. So the two tables in `ef8843e` and `7953321` and the miss factors in the retraction have no committed provenance, which is consistent with the $4R$-for-$M^*$ substitution in F.2 being an ad-hoc slip rather than a reproducible calculation. The $\kappa_n$ sweep likewise has no script attached to these commits, though earlier $\kappa_W$ work by Reviewers 28 and 29 is referenced in the file. **Every number in this review was recomputed from the definitions in exact rationals, independently of any script.**

## What would fix it

Three items, in order of value.

1. **Rewrite the fence post as F.4**, conditional on the accidental $\tfrac12$-excess rather than on the total multiplicity, with the record's own $(p,q)$ theorem as its evidence. This recovers most of `ef8843e`'s force without its false cap.
2. **Record F.5(ii)**: the method is $\operatorname{tr}(L_e^2)\ge1+M/4$ plus an additive $16$, so no work on the remainder term can help. This closes a whole class of follow-ups.
3. **Prove $\kappa_n$ at odd $n$ by §A.2's rationality argument**, and strike claim C's open item, which §A.1 has closed.

Corrections owed in [findings/second-order.md](../findings/second-order.md): the miss factors $5.00/4.60/4.33$ and the word "shrinking" (F.2), the $3.4\times$ headline computed at $D=9$ instead of $M=18$ (D.2), the unused "rest at most $\tfrac12$" hypothesis (D.1), the unreconciled $18$-versus-$m^2$ pair (F.3), and the attribution of A and B, which are Fox's and are already in the same file.
