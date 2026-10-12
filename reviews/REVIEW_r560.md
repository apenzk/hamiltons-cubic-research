# Review r560, Lemma L51 (the variation calculus is an identity along a critical orbit)

Reviewer r560, independent adversarial audit of one result: [Lemma L51](../findings/second-order.md#L185), canonical block at [second-order.md:185](../findings/second-order.md#L185). Everything below was derived from [conventions.md](../findings/conventions.md) and the block's own hypotheses; the record was treated as unverified. **Analysis only, no computation was run.** The one arithmetic screen I did use (the two-dimensional cubic of [plan-maximizer.md:81](plan-maximizer.md#L81)) was done by hand and is reported as a screen, not as evidence.

**Overall verdict: CONFIRMED on the mathematics, REPAIRED on four points of statement.** Both identities, all four consequences and the attribution survive an independent rebuild. Four defects are in how the block states what it proves, one of them ("satisfied by $u$") an outright false line whose conclusion is nevertheless correct. Two further defects were found adjacent to the block.

## 0. Structure, the heading is honest and the proof is in the block

The heading promises "the canonical statement"; the block carries **Statement** and **Argument**, and the Argument is a proof rather than a pointer. This is not one of the blocks whose argument lives elsewhere. The same content appears three more times, the running derivation at [second-order.md:143](../findings/second-order.md#L143), [post F37](../findings/fence-posts.md#L289), and the headline at [results.md:246](../results.md#L246) with the restatement at [results.md:700](../results.md#L700), and all four agree on the mathematics.

## 1. The rebuild, and what each step consumes

Written from the definitions, with $Q(x)=x\circ x$ (so $W\circ W=Q(W)$ follows from $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ by homogeneity, [conventions.md](../findings/conventions.md)).

| step | derivation | consumes |
| --- | --- | --- |
| $\circ$ is $G$-equivariant | $P\circ g=P$ polarises to $T(gx,gy,gz)=T(x,y,z)$; with $g$ orthogonal this gives $gx\circ gy=g(x\circ y)$ | orthogonality of the action, $G$-invariance of $P$ |
| the whole orbit is critical | $Q(e^{tX}W)=e^{tX}Q(W)=\theta\,e^{tX}W$ | the above, plus $Q(W)=\theta W$ |
| $L_Wz=\tfrac\theta2z$ | $\tfrac{d}{dt}Q(W(t))=2W\circ\dot W$ at $t=0$ | one derivative; **no** self-adjointness, **no** $\theta>0$ |
| $Bu=z\circ z$ | $\tfrac{d^2}{dt^2}Q(W(t))=2\dot W\circ\dot W+2W\circ\ddot W=\theta u$ | two derivatives; same |
| orbit tangent $\subseteq A(\tfrac12)$ | $Bz=0$, and $z=XW\perp W$ because $X$ is skew | skewness of $\mathfrak g$ |
| fusion rule | $\langle z\circ z,y\rangle=\langle Bu,y\rangle=\langle u,By\rangle=0$ on $\ker B$ | **$B$ self-adjoint**, i.e. $T(x,y,z)=T(x,z,y)$ |
| $T(z,z,z)=0$ | the fusion rule at $y=z$, since $z\in\ker B$ | as above |

**Every line reproduces the block.** I re-derived $T(z,z,z)=0$ a second way, with nothing in common with the first: differentiating $P(e^{tX}W)\equiv\theta$ three times gives $6T(z,z,z)+18T(W,z,u)+3T(W,W,X^3W)=0$, and $\langle z,u\rangle=0$ (from the third derivative of $\lVert W(t)\rVert^2\equiv1$, with $\langle W,X^3W\rangle=-\langle z,u\rangle$) kills the last two terms.

**The jet, rebuilt from scratch.** With $x(t)=W+tz+\tfrac{t^2}2w$, $w\perp W$, $z\in\ker B$, and $s=\lVert z\rVert^2$:

$$[t^3]\,P(x/\lvert x\rvert)=T(z,z,z),\qquad [t^4]\,P(x/\lvert x\rvert)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac38\theta s^2 .$$

The $t^3$ line needs $Bz=0$: for general $z$ the coefficient is $T(z,z,z)-3\langle Bz,w\rangle$. The $t^4$ constant comes out of $3\langle L_Wz,z\rangle\cdot(-\tfrac32 s)+\tfrac{15}8\theta s^2=(-\tfrac{18}8+\tfrac{15}8)\theta s^2$. **At $s=1$ this is the block's display exactly**, see D3 for the missing $s$.

**Hypotheses that are not used.** Compactness of $G$ never enters: a single one-parameter group of orthogonal $P$-preserving maps suffices, and any subgroup of $O(V)$ has compact closure anyway, so "compact" is free rather than load-bearing. $\theta>0$ is not needed for either identity; it is needed for $\ker B\subseteq W^\perp$, for the strictness of the quartic, and for reading $B\vert_{W^\perp}\succeq0$ as $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$.

## D1, REPAIRED. "$B\succeq0$" is unsatisfiable as written; the hypothesis is $B\vert_{W^\perp}\succeq0$

$L_WW=W\circ W=Q(W)=\theta W$, so

$$BW=\big(\tfrac\theta2-L_W\big)W=-\tfrac\theta2\,W .$$

At $\theta>0$ the radial direction is a **strictly negative** eigenvector of $B$, so $B\succeq0$ on the whole space holds at no critical point of the kind the Statement quantifies over. Read literally, the fourth clause is vacuously true and carries nothing.

**The intended reading is $B\vert_{W^\perp}\succeq0$, and the block's own machinery says so.** The corrector $w$ is restricted to $W^\perp$; $B$ preserves $W^\perp$ (self-adjoint, with $W$ an eigenvector); and the stationarity condition is written with a projection, $Bw=\Pi(z\circ z)$. Equivalently $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$, which is [Lemma L24](../results.md)'s conclusion.

**No consumer is misled**, the record already uses the restricted reading everywhere it matters. [second-order.md:169](../findings/second-order.md#L169) says the $C_5$ blow-up fails "$B\succeq0$", and the table at [second-order.md:173](../findings/second-order.md#L173) gives the reason as $\lambda_{\max}/\theta=1.206011$, a statement about $W^\perp$. The defect is confined to the canonical Statement, and to its copies at [results.md:706](../results.md#L706) and [post F37](../findings/fence-posts.md#L297).

**Repair:** write $B\vert_{W^\perp}\succeq0$ in all three copies, with the parenthetical "equivalently $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$".

## D2, REPAIRED. "satisfied by $u$" is false under the block's own $w\perp W$; the stationary corrector is $\Pi u=u+\lVert z\rVert^2W$

The Argument reads: *"a concave quadratic in $w$ whose stationarity condition is $Bw=\Pi(z\circ z)$, satisfied by $u$."* Both halves of that fail for $u$, by two computations that need nothing but skewness:

- **$u\notin W^\perp$.** $\langle u,W\rangle=\langle X^2W,W\rangle=-\langle XW,XW\rangle=-\lVert z\rVert^2\ne0$. So $u$ is outside the domain the display quantifies over.
- **$Bu\ne\Pi(z\circ z)$.** $\langle z\circ z,W\rangle=T(z,z,W)=\langle L_Wz,z\rangle=\tfrac\theta2\lVert z\rVert^2$, which is nonzero at $\theta>0$, so $\Pi(z\circ z)=z\circ z-\tfrac\theta2\lVert z\rVert^2W$ is strictly different from $Bu=z\circ z$.

**The correct corrector is $\Pi u$**, and it works exactly:

$$B(\Pi u)=B\big(u+\lVert z\rVert^2W\big)=z\circ z-\tfrac\theta2\lVert z\rVert^2W=\Pi(z\circ z).$$

**A second route reaches the same conclusion and explains why.** The curve $x(t)/\lvert x(t)\rvert$ has second derivative $w-\lVert z\rVert^2W$ at $t=0$, while the orbit $e^{tX}W$ has $u$; matching them forces $w=u+\lVert z\rVert^2W=\Pi u$. That also shows why $w$ may be taken perpendicular with no loss, as [second-order.md:137](../findings/second-order.md#L137) asserts: adding $cW$ to $w$ leaves $w-(\lVert z\rVert^2+c)W$ unchanged.

**The conclusion the line supports is nonetheless correct.** I verified "supremum $=0$" by a route sharing nothing with the block's:

1. For $f=P\vert_{S}$ with $df_W=0$, the fourth derivative along a spherical curve $y$ is $d^4f(y_1^4)+6d^3f(y_1,y_1,y_2)+3d^2f(y_2,y_2)+4d^2f(y_1,y_3)$. The Hessian is $-6B$ on $W^\perp$ and $Bz=0$, so the $y_3$ term dies and the $y_4$ term dies with $df_W=0$: **the quartic depends only on the spherical $2$-jet.**
2. The orbit's spherical $2$-jet is $(z,u)$ and $P\equiv\theta$ along it, so the quartic at the matching corrector is $0$.
3. Independently, evaluating the block's own quadratic at its stationary point gives $\tfrac34\langle\Pi(z\circ z),\Pi u\rangle-\tfrac38\theta\lVert z\rVert^4$, and $\langle\Pi(z\circ z),\Pi u\rangle=\langle z\circ z,u\rangle+\tfrac\theta2\lVert z\rVert^4$. Differentiating $P(e^{tX}W)\equiv\theta$ four times gives $36\langle z\circ z,u\rangle+18\langle L_Wu,u\rangle-9\theta\lVert u\rVert^2=0$, which collapses to $18\langle z\circ z,u\rangle=0$. **So the value is $\tfrac34\cdot\tfrac\theta2\lVert z\rVert^4-\tfrac38\theta\lVert z\rVert^4=0$**, and the equivalent form $\langle b,B^{+}b\rangle=\theta/2$ follows at $\lVert z\rVert=1$.

**Repair:** *"satisfied by $\Pi u=u+\lVert z\rVert^2W$, since $\langle u,W\rangle=-\lVert z\rVert^2$."* The narrative copies at [second-order.md:147](../findings/second-order.md#L147) and [post F37](../findings/fence-posts.md#L297) display no equation and survive under the radial-freedom remark, but would read better with the same correction.

## D3, REPAIRED. The jet display's constant silently assumes $\lVert z\rVert=1$

The general constant is $-\tfrac38\theta\lVert z\rVert^4$. The running version at [second-order.md:135](../findings/second-order.md#L135) states "for $z\in A(\tfrac12)$ **of unit norm**"; the canonical Statement's Argument at [second-order.md:197](../findings/second-order.md#L197) states only $w\perp W$, while its $z=X\!\cdot\!W$ carries no normalisation at all, $X$ ranges over the whole Lie algebra. The supremum-$=0$ conclusion is scale-invariant (both terms carry $\lVert z\rVert^4$), so nothing downstream moves; the display is what is wrong. The same display is quoted at [ELIM-secondorder.md:188](ELIM-secondorder.md#L188).

**Repair:** add "with $\lVert z\rVert=1$" to the Argument, or write the constant as $-\tfrac38\theta\lVert z\rVert^4$.

## D4, REPAIRED. "already a theorem at the points where it was measured" over-claims for padded $W_{\mathbb{CP}^2}$

**The equivalence itself is correct.** $\mathrm{Hess}(P\vert_S)=6\theta(L_e-\tfrac12)=-6B$ on $W^\perp$, so $\ker\mathrm{Hess}=A(\tfrac12)$; the orbit tangent sits inside it by L51's own first clause; so excess $=0$ is exactly $\ker\mathrm{Hess}=T_W\mathcal O$, which is Morse–Bott nondegeneracy. The scope note is right about that.

**The coverage claim is not.** The block lists six points and says nondegeneracy was "already a theorem" at them; [post F37](../findings/fence-posts.md#L299) says "already proved at all six points".

| point | covered by a theorem? |
| --- | --- |
| $S^4\times S^4$, $S^6\times S^6$, $S^5\times S^7$ | **yes**, [Lemma L27](../findings/nondegeneracy.md#L457), $p,q\ge3$ with $(p,q)\ne(3,3)$ |
| padded $W_{\mathbb{CP}^2}$ at $n=8,10,12$ | **no**, measurement only |

[Lemma L28](../findings/nondegeneracy.md#L504) is stated for $\mathbb{CP}^m$ at $m\ge3$ **in its native $\mathrm{Weyl}_{2m}$**, so it reaches neither $m=2$ nor any padding. What the record actually has is [nondegeneracy.md](../findings/nondegeneracy.md)'s RESULT 1, two reviewers measuring $\ker\mathrm{Hess}=$ orbit at $n=6,8,10$, a different dimension list from the block's, and a measurement. **Nor can nondegeneracy be transported by padding**, because [second-order.md:155](../findings/second-order.md#L155) records that padding manufactures excess: $S^2\times S^4$ goes from excess $0$ natively to $8$ and $16$ when padded.

This matters because the scope note is what keeps the negative conclusion honest, it is the sentence that says the measurements re-derive a known theorem. Half of them do.

**Repair:** *"a theorem at the sphere products by [Lemma L27](../findings/nondegeneracy.md), and a measurement at padded $W_{\mathbb{CP}^2}$"*.

## D5, adjacent defect, outside the block. The orbit dimension $18$ holds only at $n=8$

[second-order.md:251](../findings/second-order.md#L251) reads *"Morse–Bott nondegenerate at $n=8,10,12$ ($\dim E(\tfrac12)=\dim(\text{orbit})=18$)"*. The stabiliser of padded $W_{\mathbb{CP}^2}$ in $\mathfrak{so}(n)$ is $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$, so

$$\dim\mathcal O=\binom n2-4-\binom{n-4}2=18,\ 26,\ 34\quad\text{at }n=8,10,12 .$$

The record's own $n=6$ figure confirms the formula: $15-4-1=10$, matching RESULT 1's "$10=10$ at $n=6$". So the parenthetical is right at $n=8$ and wrong at the other two. This is the line the L51 block's dimension list draws on.

## D6, $\Pi$ is defined nowhere on the record

$\Pi$ carries the whole content of the stationarity condition and appears in [second-order.md:149](../findings/second-order.md#L149), [second-order.md:201](../findings/second-order.md#L201) and [plan-maximizer.md:81](plan-maximizer.md#L81), always as the orthogonal projection onto $W^\perp$, but [conventions.md](../findings/conventions.md) has no row for it, and the block does not define it. The same letter is used for other projections in the same file: $\Pi_{V'}$ at [second-order.md:793](../findings/second-order.md#L793), $\Pi_{SD}$ in the $\mathrm{Alt}$ row of [conventions.md](../findings/conventions.md), and "$\Pi$-saturation … the $\Pi$-bound" at [second-order.md:757](../findings/second-order.md#L757), which is a different object again. Given that D2 turns on precisely what $\Pi$ projects onto, this is a load-bearing omission.

A related note: [conventions.md](../findings/conventions.md) carries a live warning that "THE LETTER $B$ MEANS TWO THINGS", naming the Killing form and [sym3-blocks.md](../findings/sym3-blocks.md)'s variant. **L51's $B=\tfrac\theta2-L_W$ is a third**, and it is the one that runs through [second-order.md](../findings/second-order.md), [fence-posts.md](../findings/fence-posts.md) and [results.md](../results.md). The block defines it locally, so nothing is wrong; the conventions row is incomplete.

## 2. "None of this uses maximality", true, and worth one added clause

**Verdict: the sentence is literally true of all four conclusions, and misleading about the fourth.**

- The first three consequences follow from equivariance and criticality alone. Confirmed by the rebuild.
- The fourth is a **conditional**, and its hypothesis $B\vert_{W^\perp}\succeq0$ is strictly weaker than maximality: $S^3\times S^3$ satisfies it ([second-order.md:173](../findings/second-order.md#L173) records $-9.5\times10^{-16}$) and is not a local maximum. So the clause genuinely does not assume maximality.
- **But on this record the guard is certified in exactly two ways**: by [Lemma L24](../results.md) at a maximiser, or by measuring $\lambda_{\max}$ at a named point. There is no third. So a reader who takes "none of this uses maximality" as licensing the fourth clause at an arbitrary critical point is wrong, and the $C_5$ blow-up is the counterexample the file already carries.

**Recommended clause:** *"None of this uses maximality; the guard on the fourth clause is weaker than maximality but is, on this record, established only by [Lemma L24](../results.md) at a maximiser or by direct measurement."*

**No consumer takes the fourth clause without the guard.** [second-order.md:171](../findings/second-order.md#L171) lists $B\succeq0$ as one of three requirements and names it "second order"; [second-order.md:169](../findings/second-order.md#L169) explicitly refuses to apply the derived corollary at the $C_5$ blow-up "because the derivation assumes $B\succeq0$, which fails there". [plan-maximizer.md:81](plan-maximizer.md#L81) applies the $B^{+}$ inequality to a **non-orbit** direction and correctly gets strict inequality rather than equality.

## 3. The two quartic numbers, different objects, and the block does not say so

**Both numbers are correct, and they are the same function of $w$ at two arguments.** From the jet, $[t^4]=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac38\theta$:

| object | curve | value |
| --- | --- | --- |
| the "geodesic quartic coefficient" | $w=0$, the great circle through $W$ and $z$ | $-\tfrac38\theta$ |
| the "supremum over correctors" | $w$ free in $W^\perp$, attained at $\Pi u$ | $0$ |

So $-\tfrac38\theta<0$ is the no-corrector value and $0$ is the optimised one, and the inequality between them is exactly what "supremum" means. The brief's arithmetic is confirmed: $-\tfrac92\cdot\tfrac\theta2+\tfrac{15}8\theta=-\tfrac38\theta$.

**Two sub-checks, both passing.**

- *The formula.* $-\tfrac92\langle L_Wz,z\rangle+\tfrac{15}8\theta$ is the quartic coefficient of $t\mapsto P\big((W+tz)/\lvert W+tz\rvert\big)$, the radially projected straight line. The **arc-length** geodesic $\cos t\,W+\sin t\,z$ gives $\tfrac78\theta-\tfrac52\langle L_Wz,z\rangle$ instead; the two agree under $t=\tan\tau$, which is why both return $-\tfrac38\theta$ on the null cone. The word "geodesic" names the right curve and the wrong parametrisation, and the quartic coefficient is parametrisation-dependent, worth one word, since no number moves.
- *"on the whole null cone of $B$, not only on eigenvectors"* ([second-order.md:139](../findings/second-order.md#L139)) is **correct and is a real strengthening**: substituting $\langle L_Wz,z\rangle=\tfrac\theta2-\langle Bz,z\rangle$ gives $-\tfrac38\theta+\tfrac92\langle Bz,z\rangle$ at $\lVert z\rVert=1$, which is $-\tfrac38\theta$ on $\{\langle Bz,z\rangle=0\}$, strictly larger than $\ker B$.
- *The sign fix.* $\partial^4f/\partial z^4\vert_c=-9\theta\lvert c\rvert^{-4}$ checks out: $4!\times(-\tfrac38\theta)=-9\theta$ at $\lvert c\rvert=1$, and degree-zero homogeneity supplies $\lvert c\rvert^{-4}$.

**Recommended:** say "at $w=0$" beside the geodesic coefficient. A reader meeting $0$ and $-3\theta/8$ four lines apart currently has to reconstruct the relation.

## 4. Full symmetry of $T$, available, and genuinely load-bearing

The fusion rule needs $\langle Bu,y\rangle=\langle u,By\rangle$, hence $L_W$ self-adjoint, hence $T(x,y,z)=T(x,z,y)$. **In L51 this is a stated hypothesis**, so the step is licensed. It is also what makes $\lambda_{\max}$ well defined in the guard, and what makes $B$ preserve $W^\perp$, used twice more in D1 and D2.

The instantiation at $\mathcal W_n$ is inside the hypotheses: $O(n)$ acts orthogonally, $P=\langle W,Q(W)\rangle$ is invariant, and total symmetry of $T$ is proved in [Lemma L24](../findings/second-order.md#L62)'s Argument (the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$, the $\#$ part by the total antisymmetry of the structure constants). I checked the consumers by grepping the statement rather than the identifier; none applies the abstract lemma in a setting where either hypothesis is unverified.

## 5. The Statement understates its own file

[second-order.md:149](../findings/second-order.md#L149) proves the stronger fusion rule with **one** orbit slot: differentiating $L_{W(t)}z_1(t)=\tfrac\theta2z_1(t)$ along $z_1(t)=e^{tX}z_1$ gives $z\circ z_1=B(Xz_1)$, hence $T(X\!\cdot\!W,z_1,z_2)=\langle Xz_1,Bz_2\rangle=0$ for **all** $z_1,z_2\in A(\tfrac12)$. The eigenspace transports as $A_{1/2}(gW)=g\,A_{1/2}(W)$, so the curve exists with no smoothness argument. The canonical Statement's $\langle z\circ z,y\rangle=0$ is the two-orbit-slot special case. Not a defect; the canonical block should carry the stronger form, since it is the one that yields "the third-order content is the excess alone".

## 6. Attribution, correct on every point checked

| claim | check |
| --- | --- |
| KT Proposition 6.6 is the second-order eigenvalue bound, i.e. [Lemma L24](../results.md) | ✓ [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) quotes 6.6 verbatim: $\sigma(c)\subset(-\infty,\tfrac12]$ at an extremal idempotent, $1$ simple |
| KT Proposition 6.7 is the third-order fusion rule | ✓ notes quote it verbatim: $\langle z^2;z\rangle=0$ on $A_c(\tfrac12)$, i.e. $A_c(\tfrac12)A_c(\tfrac12)\subset A_c(\tfrac12)^\perp$ |
| 6.6 derived here independently before the source was found | ✓ consistent with [second-order.md:21](../findings/second-order.md#L21) and the L24 block |
| the sign "left open in the source" | ✓ the notes flag exactly this: "$\partial^4f/\partial z^4\vert_c\ge0$ as printed, check the sign against the maximum convention" |
| [arXiv:1801.00617](https://arxiv.org/abs/1801.00617) | ✓ resolves 200 to *Variety of idempotents in nonassociative algebras*, matching the reference folder |

The record's own notes answered every question, so I did not go to the source beyond confirming the identifier.

## 7. The negative conclusion, and how strong it is

*"A route through this calculus must consume directions of $A(\tfrac12)$ transverse to the orbit."* **Confirmed, and unconditional**, it is the contrapositive of the four clauses, each of which is an identity on the orbit tangent with no hypothesis beyond criticality.

*"Excess is $0$ at every local maximum on record."* True of the catalogue as recorded, subject to D4 on how three of the six are known and to D5 on the dimensions.

*"Until one is exhibited, this calculus constrains nothing."* This is the right strength, weaker than the "vacuous outright" reading the scope note says was refuted at Gate 2, and it does not claim the calculus is closed. [Post F37](../findings/fence-posts.md#L299)'s "the live sub-question is whether a maximiser can be degenerate" states the residue correctly.

**A screen supporting the block's caution, reported as a screen.** The two-dimensional algebra of [plan-maximizer.md:81](plan-maximizer.md#L81), $P(x,y)=x^3+\tfrac32xy^2$, is a **global** maximum at $e=(1,0)$ with $\theta=1$, $L_e=\tfrac12$ on $e^\perp$, trivial symmetry, excess $1$, and a satisfied fusion rule. I checked every one of those by hand: $P(\cos t,\sin t)=\cos t(1+\tfrac12\sin^2t)$ with derivative $-\tfrac32\sin^3t$; $f\circ f=\tfrac12e_1=\tfrac\theta2W$, so $b=\Pi(f\circ f)=0$ and the quartic is $-\tfrac38\theta$, strict. This is a degenerate global maximum satisfying every identity of L24 and L51, and it shows the fourth clause's "$=0$" is genuinely a statement about **orbit** directions and fails for excess directions. It is a screen on an object I constructed for the purpose, not evidence about $\mathcal W_n$.

## 8. Norm and convention check

- The $\circ$ product, $e=W/\theta$ and $L_e$ are quoted from [conventions.md](../findings/conventions.md); the block writes $L_W=\theta L_e$, defines it locally, and the $\tfrac12$ in $A(\tfrac12)$ is the $L_e$-eigenvalue, consistent with $\ker(\tfrac\theta2-L_W)$. No mismatch.
- The $\tfrac12$-at-the-$\Lambda^2$-level pairing never enters: L51 is abstract and uses only that the space is Euclidean. It is therefore immune to the normalisation trap that has cost this programme cycles.
- Warning [W5](../findings/INDEX-traps.md) does not bite: the block never refers to $\Theta_n$ or to a global maximum by value.
- $A(\tfrac12)=\ker B\cap W^\perp$ is redundant at $\theta>0$, since $BW=-\tfrac\theta2W\ne0$ forces $\ker B\perp W$. Harmless, and the intersection is the right definition at $\theta=0$.

## Verdicts

| # | defect | verdict |
| --- | --- | --- |
|, | $L_Wz=\tfrac\theta2z$ and $Bu=z\circ z$ | **CONFIRMED**, rebuilt from the definitions |
|, | orbit tangent $\subseteq A(\tfrac12)$, $T(z,z,z)=0$, the fusion rule | **CONFIRMED**, the third re-derived by a second independent route |
|, | fourth-order supremum $=0$ | **CONFIRMED**, re-derived twice, once with nothing in common with the block's argument |
|, | attribution to KT Props 6.6 and 6.7; the $\partial^4f$ sign | **CONFIRMED** |
|, | excess $=0$ $\iff$ Morse–Bott nondegeneracy | **CONFIRMED** |
| D1 | "$B\succeq0$" unqualified, unsatisfiable at $\theta>0$ | **REPAIRED**, read $B\vert_{W^\perp}\succeq0$ |
| D2 | "satisfied by $u$" ($u\notin W^\perp$ and $Bu\ne\Pi(z\circ z)$ | **REPAIRED**), the corrector is $\Pi u=u+\lVert z\rVert^2W$ |
| D3 | the jet constant $-\tfrac{3\theta}8$ needs $\lVert z\rVert=1$ | **REPAIRED**, general form $-\tfrac38\theta\lVert z\rVert^4$ |
| D4 | "already a theorem at the points where it was measured" | **REPAIRED**, theorem at the sphere products, measurement at padded $W_{\mathbb{CP}^2}$ |
| D5 | [second-order.md:251](../findings/second-order.md#L251)'s orbit dimension $18$ at $n=8,10,12$ | **REFUTED**, $18,26,34$; the record's own $n=6$ figure of $10$ fixes the formula |
| D6 | $\Pi$ undefined anywhere; $B$ is a third meaning of a letter [conventions.md](../findings/conventions.md) already warns about | **REPAIRED**, add a row |
|, | "None of this uses maximality" | **CONFIRMED as literally true**; one clause recommended, since the guard is only ever certified by [Lemma L24](../results.md) at a maximiser |

**Overall: CONFIRMED.** Lemma L51 is a correct theorem and its argument is sound. Nothing downstream moves: the two identities, the fusion rule, the supremum and the negative conclusion all stand, and the four repairs are to how the block states its hypotheses rather than to what it proves. D5 is a numerical error adjacent to the block and should be fixed where it sits.

## Note on independence

Reviewer r559 works the identical brief. I did not open their report or their log. Two lines of [REVIEW_r559.md](REVIEW_r559.md) appeared incidentally in the output of a repository-wide grep whose exclusion pattern missed the path; every derivation above, including $\Pi u$, the $W$-component identity $\langle z\circ z,W\rangle=\tfrac\theta2\lVert z\rVert^2$, and $\langle z\circ z,u\rangle=0$, was on paper before that grep ran, and I read nothing further of that file.
