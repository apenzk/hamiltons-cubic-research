# Review r391, "I18's $\mathcal D_n$ clause is the polarisation of the value formula", Gate 2

*Adversarial review of the last section of [ATTEMPTS.md](../ATTEMPTS.md). Analysis only, per [analysis-only.md](../.claude/rules/analysis-only.md). Every identity below was derived by hand from the definitions before the record was opened; four screens are named where they occur, each seconds of exact or double-precision arithmetic on objects constructed here, and none carries a positive claim on its own.*

## Verdict table

| Claim | Verdict |
| --- | --- |
| **(a)** $F(M)=\tfrac12(\langle M,M^{\circ2}\rangle+\mathop{\mathrm{tr}}M^3)$ under $\tfrac12\mathop{\mathrm{tr}}M^2=1$ | **CONFIRMED**, and it is verbatim [diagonal-half.md](../findings/diagonal-half.md)'s $2\theta=\langle M^{\circ2}+M^2,M\rangle$. Normalisation checks out in both pairings: $\lVert W\rVert^2=\sum_{a<b}M_{ab}^2=\tfrac12\mathop{\mathrm{tr}}M^2$, so the constraint *is* the unit sphere. No factor of $2$ is lost |
| **(b)** $d^2F(X)=3(\langle M,X^{\circ2}\rangle+\mathop{\mathrm{tr}}(MX^2))$, $d^2g(X)=\mathop{\mathrm{tr}}X^2$, $\mu=3\theta/2$ | **CONFIRMED**, every piece. $F$ is homogeneous of degree $3$, so $\nabla F\!\cdot\!M=3F=3\theta$; $g$ quadratic gives $\nabla g\!\cdot\!M=2g=2$ |
| **(c)** $\langle X,L_eX\rangle=\big(\langle M,X^{\circ2}\rangle+\mathop{\mathrm{tr}}(MX^2)\big)/(2\theta)$ | **CONFIRMED, and it is stronger than the derivation offered.** No factor of $2$ hides anywhere. **But** it needs neither criticality, nor $X\perp M$, nor unit norm, it is an identity of the diagonal-locus product, and the Lagrange route proves a special case of it |
| **(d)** the boxed clause, with strict "$<$" | **REFUTED, with an exact counterexample already named in the record.** The box is *strictly stronger* than [Lemma L128](../findings/second-order.md)(ii)'s $\mathcal D_n$ clause and is **not** "the clause". This is the exact defect [r373](REVIEW_r373.md)/[r374](REVIEW_r374.md) corrected in L128 and it is reintroduced here. $X\perp M$ versus $X\perp W$ is right, and is the one hypothesis the section gets right where the record has gone wrong before |
| **(e)** "the value formula polarised term for term", and the $98.18\%$ split "bears on it directly" | **SPLIT. The polarisation reading is accurate as algebra; the $98.18\%$ inference is a non sequitur**, refuted by a screen. The split at $S^6\times S^6$ is $98.18\%$ only in the direction $X\propto M$, the one direction the clause excludes. On the admissible $\mathcal D_n$ directions there it is $92.73\%$ and $54.55\%$ |
| **Novelty** | **REFUTED. All of (a)–(d) is on record in [diagonal-half.md](../findings/diagonal-half.md)**, in the section "The SECOND-ORDER operator also lives in $n\times n$ matrices, and it is the criticality map's own derivative", which prints the Rayleigh form and the $\lambda_{\max}\le\theta/2$ statement by name, and carries the $\Lambda^2$/Frobenius factor $2$ explicitly. The section's own note "screened against findings/ for the two-term form, nothing found" is wrong |

## 1. The conventions, pinned before anything else

$Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, $\theta=P(W)/\lVert W\rVert^3$ with $Q(W)=\theta W$ at a critical point, $e=W/\theta$ ([conventions.md](../findings/conventions.md), [second-order.md](../findings/second-order.md)). The $\tfrac12$ sits at the $\Lambda^2$ level, so on the diagonal locus $\langle X,Y\rangle=\sum_{a<b}X_{ab}Y_{ab}=\tfrac12\mathop{\mathrm{tr}}(XY)$. The section's own $\langle A,B\rangle:=\sum_{a,b}A_{ab}B_{ab}$ is the *Frobenius* pairing, twice the Weyl one, the two appear in the same boxed formula and are never distinguished. **That is the place a factor of $2$ would hide, and it does not: it cancels.** Detail in §4.

**A notation collision the section should repair.** It writes $M\circ M$ and $X\circ X$ for the *entrywise* square while $L_e=e\circ(\cdot)$ uses $\circ$ for the *Weyl algebra product*, and both symbols appear inside the same displayed identity. [diagonal-half.md](../findings/diagonal-half.md)'s own notation is $M^{\circ2}$ for the Hadamard square, and [conventions.md](../findings/conventions.md) exists to stop exactly this.

## 2. (a), confirmed, and re-derived two ways

**From criticality.** Multiply $M_{ij}^2+(M^2)_{ij}=\theta M_{ij}$ by $M_{ij}$ and sum over $i\ne j$. The right side is $\theta\mathop{\mathrm{tr}}M^2=2\theta$; on the left, $\sum_{i\ne j}M_{ij}^3=\langle M,M^{\circ2}\rangle$ because $M$ is hollow, and $\sum_{i\ne j}M_{ij}(M^2)_{ij}=\mathop{\mathrm{tr}}M^3$ for the same reason. Hence $\theta=\tfrac12(\langle M,M^{\circ2}\rangle+\mathop{\mathrm{tr}}M^3)$.

**From the graph functional.** [diagonal-half.md](../findings/diagonal-half.md) gives $\theta(w)=\sum_{a<b}w_{ab}^3+3\sum_{a<b<c}w_{ab}w_{bc}w_{ca}$ at $\sum_{a<b}w_{ab}^2=1$. The first sum is $\tfrac12\langle M,M^{\circ2}\rangle$ and the triangle sum is $\tfrac16\mathop{\mathrm{tr}}M^3$, so $3\times$ it is $\tfrac12\mathop{\mathrm{tr}}M^3$. Same formula.

**And it is already displayed in the record's own preferred form**, [diagonal-half.md](../findings/diagonal-half.md) under "On the diagonal locus the two squares swap roles": $2\theta=\langle M^{\circ2}+M^2,\,M\rangle$. The claim's $F$ is that line divided by $2$.

**The normalisation is consistent and the constraint is the right one.** $g(M)=\tfrac12\mathop{\mathrm{tr}}M^2=\sum_{a<b}M_{ab}^2=\lVert W\rVert^2$, so $g=1$ *is* the unit sphere of the Weyl space, and the record's $\mathop{\mathrm{tr}}M^2=2$ is the same condition. **No factor of $2$ is dropped in (a).**

## 3. (b), confirmed, every piece

$t\mapsto\tfrac12\sum_{a,b}(M+tX)_{ab}^3$ has second derivative $3\sum_{a,b}M_{ab}X_{ab}^2=3\langle M,X^{\circ2}\rangle$. And $\mathop{\mathrm{tr}}(M+tX)^3=\mathop{\mathrm{tr}}M^3+3t\mathop{\mathrm{tr}}(M^2X)+3t^2\mathop{\mathrm{tr}}(MX^2)+t^3\mathop{\mathrm{tr}}X^3$, so the second derivative of $\tfrac12\mathop{\mathrm{tr}}(\cdot)^3$ is $3\mathop{\mathrm{tr}}(MX^2)$. Sum: $d^2F(X)=3(\langle M,X^{\circ2}\rangle+\mathop{\mathrm{tr}}(MX^2))$. **Confirmed.**

$g$ is quadratic, so $d^2g(X)=\mathop{\mathrm{tr}}X^2$. **Confirmed.** $F$ is homogeneous of degree $3$ in $M$ (both terms are) so Euler gives $\nabla F\!\cdot\!M=3F(M)=3\theta$, and $\nabla g\!\cdot\!M=2g(M)=2$ at $g=1$. Contracting $\nabla F=\mu\nabla g$ against $M$ gives $\mu=3\theta/2$. **Confirmed.**

**One dependency the section leaves silent, and it is satisfied.** Reading $\mathrm{Hess}(F|_{\text{sphere}})$ off $d^2F-\mu\,d^2g$ needs the diagonal locus to be totally geodesic in the unit sphere, which it is, $\mathcal D_n$ is a *linear* subspace of $\mathcal W_n$, so its intersection with the sphere is a great subsphere. So the restriction of the Hessian and the Hessian of the restriction agree.

## 4. (c), confirmed, and the derivation understates it

**The Lagrange matching is exact.** $\mathrm{Hess}(F|_S)(X)=3(\langle M,X^{\circ2}\rangle+\mathop{\mathrm{tr}}(MX^2))-\tfrac{3\theta}2\mathop{\mathrm{tr}}X^2$, and [Lemma L24](../findings/second-order.md) gives $6\theta\langle X,L_eX\rangle-3\theta\lVert X\rVert^2$. Since $\lVert X\rVert^2=\tfrac12\mathop{\mathrm{tr}}X^2$, the two subtracted terms are *the same number*, $\tfrac{3\theta}2\mathop{\mathrm{tr}}X^2$. They cancel, leaving $\langle X,L_eX\rangle=(\langle M,X^{\circ2}\rangle+\mathop{\mathrm{tr}}(MX^2))/(2\theta)$. **The $2\theta$ in the denominator is right.**

**L24 itself re-derives cold**, so the match is not two errors agreeing: $P(W)=T(W,W,W)$ for the symmetric trilinear $T(a,b,c)=\langle a,b\circ c\rangle$, so $d^2P(X)=6\langle W,X\circ X\rangle=6\langle X,W\circ X\rangle=6\theta\langle X,L_eX\rangle$, and the unit-sphere correction is $-\langle\nabla P,W\rangle\lVert X\rVert^2=-3\theta\lVert X\rVert^2$.

**The identity is much more general than the route to it.** Write $E=M/\theta$ for $e$'s sectional matrix. The diagonal-locus product is $\pi_{\text{diag}}(A\circ B)_{ij}=A_{ij}B_{ij}+\tfrac12(AB+BA)_{ij}$ for $i\ne j$, forced by the record's own criticality equation $M_{ij}^2+(M^2)_{ij}=\theta M_{ij}$, which is $M\circ M=\theta M$ read in one entry. Then, for any symmetric hollow $E$ and $X$,

$$\langle X,e\circ X\rangle=\tfrac12\Big[\sum_{a,b}E_{ab}X_{ab}^2+\mathop{\mathrm{tr}}(EX^2)\Big],$$

the second term because $\sum_{a\ne b}X_{ab}(EX)_{ab}=\mathop{\mathrm{tr}}(EX^2)$ once the hollow diagonal is accounted for. Substituting $E=M/\theta$ is the claimed identity. **So it needs no criticality of $M$, no $X\perp M$, no unit norm, and $\theta$ appears only as the scale that makes both sides degree-zero.** The section's derivation invokes all three hypotheses and gets a strictly weaker statement.

**Screen 1 (exact rationals, seconds).** At $S^6\times S^6$, $S^5\times S^7$ and $S^4\times S^9$, with $E$ built from [Lemma L27](../findings/nondegeneracy.md)'s block values $\varepsilon_{PP}=q/((p-1)(n-1))$, $\varepsilon_{QQ}=p/((q-1)(n-1))$, $\varepsilon_{PQ}=-1/(n-1)$: $E$ is an exact idempotent of that product with exact zero row sums, and $\theta_0(12)^2=55/36$ reproduces $2(n-1)(n-2)/n^2$ on the nose. On the $\mathcal D_n$ directions $X_{ab}=v_a+v_b$ inside $P$, $-\tfrac{p-2}{q}v_a$ across, $0$ inside $Q$ (with $\sum_Pv=0$) and on $u\otimes w$ across the factors, $L_e$ acts by exactly $\lambda_p=(p-2)/(2(p-1))$ and $-\mu=-(n-2)/(2(p-1)(q-1))$, **[Lemma L127](../findings/second-order.md)'s $\mathcal D_n$ row, reproduced independently**, and the two sides of (c) agree as exact rationals in all nine cases. **Screen 2 (double precision).** At a random *non*-critical $M\in\mathcal D_9$ with a random $X\in\mathcal D_9$ not orthogonal to it, criticality residual $1.48$, the two sides agree to $3.6\times10^{-15}$ at three unrelated values of $\theta$. *Reported as screens; the identity above is the claim.*

## 5. (d), REFUTED as stated, with an exact counterexample the record already names

### The hypothesis $X\perp M$ is right

For $X$ in the diagonal locus, $\langle X,W\rangle_{\mathcal W_n}=\sum_{a<b}X_{ab}M_{ab}=\tfrac12\mathop{\mathrm{tr}}(MX)$, so $X\perp W$ and $X\perp M$ are the same condition. **Correct, and it is the repair [diagonal-half.md](../findings/diagonal-half.md) demands**, that file records a whole family of $\mathcal D_n$ deformations that "certified nothing" because only the row sums were checked and $\langle W,N\rangle$ reached $0.221$.

### The strict inequality is the wrong logical form, and the record says so in a box

[Lemma L128](../findings/second-order.md)(ii) asks that $\tfrac12$ be **absent from the spectrum** of $L_e$ on $\mathcal D_n\cap W^\perp$. The claim's box asserts $\langle X,L_eX\rangle<\tfrac12\lVert X\rVert^2$ for *every* admissible $X$, which is $\lambda_{\max}(L_e|_{\mathcal D_n\cap W^\perp})<\tfrac12$, sufficient for the clause, and **strictly stronger than it**. L128's own box records the correction: *"THE INEQUALITIES IN (ii) ARE EXCLUSIONS OF $\tfrac12$, NOT STRICT BOUNDS… The first version wrote '$L_e$-spectrum $<\tfrac12$' and both reviewers refuted it."* The section reintroduces the refuted form for the $\mathcal D_n$ clause.

**And the reformulation cannot be repaired by writing "$\ne$".** $L_e$ preserves $\mathcal D_n$ ([Lemma L120](../findings/second-order.md)) and is self-adjoint, so the Rayleigh quotient's range on $\mathcal D_n\cap W^\perp$ is the full interval $[\lambda_{\min},\lambda_{\max}]$, a connected sphere's continuous image. If the spectrum straddles $\tfrac12$ without containing it, the *pointwise* statement "$\ne\tfrac12$ for all $X$" is false while the clause holds. **So no quadratic-form inequality in $X$ alone is equivalent to L128(ii); the equivalence needs the unproven extra premise $\lambda_{\max}\le\tfrac12$.** The section's "the clause is one inequality with no $L_e$ in it" is therefore wrong on both counts, the inequality is not the clause, and $L_e$ is still there, in the spectral quantifier the inequality suppresses.

### The counterexample: [Lemma L99](../findings/diagonal-half.md)'s disconnected point

The record already carries a pure critical point where the box fails and the clause holds. By [Lemma L99](../findings/diagonal-half.md), a direct sum of diagonal critical points scaled as $M=\bigoplus_c(\theta/\theta_c)M_c$ is critical, with $\theta=(\sum_c\theta_c^{-2})^{-1/2}$, and the component deformation $N=\sum_ca_cM^{(c)}$ satisfies $\mathcal LN=\theta N$ **exactly**, i.e. $L_eN=N$, and is admissible ($N\perp M$) exactly when $\sum_ca_c\theta_c^{-2}=0$, which two components with opposite signs supply.

**Screen 3 (double precision, seconds).** Two copies of $S^3\times S^3$ padded to $n=12$, scaled by L99: $\theta=0.745355992>0$, $\lVert W\rVert^2=1.000000000000$, off-diagonal criticality residual $1.4\times10^{-17}$. Take $N=M^{(1)}-M^{(2)}$: row sums $5.6\times10^{-17}$, hollow, $\langle N,M\rangle=-4.2\times10^{-17}$, so $N\in\mathcal D_n\cap W^\perp$, $N\ne0$. Then

$$\langle M,N^{\circ2}\rangle+\mathop{\mathrm{tr}}(MN^2)=1.490711985=\mathbf{2}\times\tfrac\theta2\mathop{\mathrm{tr}}N^2 .$$

**The box fails by exactly a factor of two.** **Screen 4.** The full $54$-dimensional $\mathcal D_n$ spectrum of $L_e$ at that point is $\{-0.5,-0.3,-0.15,0,0.25,0.45,0.6,1.0,1.2\}$, $\lambda_{\max}=1.2$, with three values above $\tfrac12$, and **$\tfrac12$ is absent**, nearest neighbour $0.45$. Row sums of $\mathcal L X$ vanish to $1.3\times10^{-16}$, confirming $\mathcal D_n$-invariance. *So at this point L128(ii)'s $\mathcal D_n$ clause holds and the claim's box fails, the separation is not hypothetical.*

**Scope of the counterexample, stated honestly.** $\theta=0.745<\sqrt{3/2}$, so this point is outside [I18](../plan.md)'s band and **I18 itself is untouched**. What falls is the section's claim that the box *is* the clause: the box is stated at "every pure critical point", as is L128(ii), and at this pure critical point they disagree. A correct statement of the clause needs either the band hypothesis carried explicitly with a proof that it forces $\lambda_{\max}\le\tfrac12$ on $\mathcal D_n$ (which is the work, not a corollary) or the eigenvalue form kept.

*A remark that limits the damage and should be recorded with the counterexample: no disconnected point can be in the band. $\theta^{-2}=\sum_c\theta_c^{-2}$ with every $\theta_c\le\Theta_{n_c}<\sqrt2$ forces $\theta<\theta_c/\sqrt2<1$, below $\sqrt{3/2}$. So the witness above is the general shape of the failure and the band is the reason I18 survives it.*

## 6. (e), the algebra is right, the inference from $98.18\%$ is not

**"Polarised term for term" is accurate as algebra.** $F=T(M,M,M)$ for $T(A,B,C)=\tfrac12\sum_{a,b}A_{ab}B_{ab}C_{ab}+\tfrac14(\mathop{\mathrm{tr}}ABC+\mathop{\mathrm{tr}}ACB)$, symmetric in its three slots, and $d^2F(X)=6T(M,X,X)$ returns each term with the same relative weight. So the entrywise summand polarises to the entrywise summand and the trace summand to the trace summand. **Confirmed.**

**The $98.18\%$ inference is a non sequitur, and a screen shows why.** The record's split is a statement about $M$ alone: $\tfrac12\mathop{\mathrm{tr}}M^3\le1.213562$ is the maximum of a function of $M$'s *spectrum* subject to $\mathop{\mathrm{tr}}M=0$, $\mathop{\mathrm{tr}}M^2=2$ and the zero eigenvalue $M\mathbf1=0$ forces, and $S^6\times S^6$ saturates it. **The polarised term $\mathop{\mathrm{tr}}(MX^2)$ is a joint invariant of the pair $(M,X)$, not a spectral invariant of either**, it is unchanged only under *simultaneous* conjugation, which is not a symmetry of $\langle M,X^{\circ2}\rangle$. So the extremal problem that produces $1.213562$ has no analogue one degree lower, and there is nothing for the $98.18\%$ to be inherited by.

**Screen 5 (double precision).** At $S^6\times S^6$, splitting the clause's left side into its entrywise and trace parts:

| direction $X$ | $L_e$ eigenvalue | entrywise | trace | trace share |
| --- | --- | --- | --- | --- |
| $X\propto M$, **excluded by the clause** | $1$ | $+0.02942$ | $+1.58866$ | $\mathbf{98.18\%}$ |
| within-factor, $\mathcal D_n\cap W^\perp$ | $2/5$ | $+14.38293$ | $+183.38236$ | $92.73\%$ |
| cross-factor, $\mathcal D_n\cap W^\perp$ | $-1/5$ | $-202.25996$ | $-242.71195$ | $54.55\%$ |

**The $98.18\%$ reappears in exactly one direction, and it is the radial one the clause throws away**, necessarily, since there the clause's left side *is* the value formula rescaled. On the admissible directions the share is direction-dependent and runs from $54.55\%$ to $92.73\%$; at $S^5\times S^7$ it is $56.36\%$ and $77.58\%$. **So "the same two-term balance survives one differentiation" is false as stated: there is no single balance downstairs.**

## 7. Novelty, REFUTED

[diagonal-half.md](../findings/diagonal-half.md), section "The SECOND-ORDER operator also lives in $n\times n$ matrices, and it is the criticality map's own derivative", already carries the whole of (a)–(d):

- **the operator**: $\mathcal L(N)=M\circ N+\tfrac12(MN+NM)=\tfrac12D\Phi(M)[N]$ with $\Phi(M)=M^{\circ2}+M^2$, and $L_e=\mathcal L/\theta$, the section's (b) and (c) in operator form, obtained as the criticality map's derivative rather than by a Lagrange multiplier;
- **the Rayleigh form, verbatim**: *"The Rayleigh form $\sum_{ij}M_{ij}N_{ij}^2+\mathop{\mathrm{tr}}(MN^2)$ is exact and proved, in the $n\times n$ Frobenius normalisation; the $\Lambda^2$ pairing is half of it"*, which is the boxed identity (c), factor of $2$ included and named;
- **the clause**: *"on the diagonal locus [Lemma L24](../findings/second-order.md) is an explicit small spectral problem: a diagonal local maximum needs $\lambda_{\max}(\mathcal L)\le\tfrac\theta2$ over hollow symmetric $N$ with zero row sums"*, the boxed (d), and with "$\le$" rather than "$<$";
- **the $\mathcal D_n$-invariance** the identity needs, proved combinatorially there and independently by [Lemma L120](../findings/second-order.md).

**The section's attribution line, "screened against [findings/](../findings/) for the two-term form, nothing found", is wrong, and the material is in the very file the section cites for (a)**, two hundred lines above the "swap" line it also cites.

**Three caveats the record attaches and the section drops.**

1. **The restriction is strictly lossy.** [diagonal-half.md](../findings/diagonal-half.md) tabulates the diagonal $\lambda_{\max}$ against the full one: equal at the blow-ups, but $0.375$ against $0.500$ at $S^3\times S^5$ and $0.400$ against $0.500$ at $S^6\times S^6$, and at $S^2\times S^q$ the full space exceeds $\tfrac12$ while the diagonal restriction sees nothing. This is scoped correctly for L128(ii), whose $\mathcal D_n$ clause is genuinely about $\mathcal D_n$, but it forecloses the section's closing suggestion that [Lemma L57](../findings/problem.md)'s machinery on the polarised form would settle more than one of the three clauses.
2. **The operator identity is off by a diagonal.** $M\circ N+\tfrac12(MN+NM)$ carries a diagonal $\langle M_i,N_i\rangle$ that $L_W$ does not; the correct object is $\tfrac12D[\Phi-\mathop{\mathrm{diag}}(s)]$. This is harmless for the *Rayleigh form* ($N$ is hollow, so the diagonal never pairs) which is why the record calls that form exact. Worth stating, because a successor operating on $\mathcal L$ rather than on $\langle N,\mathcal LN\rangle$ meets it.
3. **The reduction carries a factor of two of slack at any maximiser**, since $L_W([A,W])=\tfrac\theta2[A,W]$ for every $A\in\mathfrak{so}(n)$ and those orbit directions lie entirely off $\mathcal D_n$.

**What survives as genuinely new** is small and worth keeping: the Lagrange-multiplier derivation is a second, independent route to the recorded operator identity, and it makes the cancellation of $\lVert X\rVert^2$ transparent, $\mu=3\theta/2$ against L24's $-\tfrac12\mathrm{Id}$ is the same constant twice. **And the generalisation in §4 is new**: the identity is an identity of the diagonal-locus product at *arbitrary* $M,X\in\mathcal D_n$, with $\theta$ a free scale, so it holds off the critical set, which the record's own framing (a derivative *of the criticality map*, verified at critical points) does not say.

## 8. What is owed

| # | Item |
| --- | --- |
| 1 | **Restate the box with "$\ne$" in eigenvector form, or carry the band hypothesis explicitly.** As it stands it is a sufficient condition, refuted as a restatement of the clause by the $n=12$ disconnected point of §5 |
| 2 | **Withdraw the novelty claim** and cite [diagonal-half.md](../findings/diagonal-half.md)'s second-order section; keep the Lagrange route as a second derivation and the off-critical generalisation as the new part |
| 3 | **Withdraw the $98.18\%$ sentence.** The split is a property of the radial direction, which the clause excludes |
| 4 | **Repair the $\circ$ collision**, $M^{\circ2}$ for the Hadamard square, per [conventions.md](../findings/conventions.md) |
| 5 | **The real question the section reached and did not ask**: does $\theta\ge\sqrt{3/2}$ at $n\ge12$ force $\lambda_{\max}(\mathcal L|_{\mathcal D_n\cap W^\perp})\le\tfrac\theta2$? The disconnected counterexample says the band is doing the work, and it is the band that is unexploited. *This is analysis, not computation: the disconnected family is already excluded by $\theta^{-2}=\sum_c\theta_c^{-2}$, so the question is what else can carry an eigenvalue above $\tfrac12$ on $\mathcal D_n$* |
