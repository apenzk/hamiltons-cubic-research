# Review r984: Gate 2 on I53, the third orbit identity $\langle Bu,u\rangle=0$

Reviewer r984, cold read from [BRIEF_I53_orbit_identity.md](BRIEF_I53_orbit_identity.md) alone. The findings files and the Lean file under review were left unopened, as the brief directs. Log: [agent_logs/r984-i53-orbit.log](../agent_logs/r984-i53-orbit.log).

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $P(e^{tX}\cdot W)$ constant along the orbit | CONFIRMED |
| 2 | $f^{(4)}(0)$ coefficients $3,24,18,36$ | CONFIRMED |
| 3 | criticality, $T(a,W,W)=\theta\langle a,W\rangle$ | CONFIRMED |
| 4 | first derivative, $T(a,z,W)=\tfrac\theta2\langle a,z\rangle$ | CONFIRMED |
| 5 | second derivative, $T(a,u,W)=\tfrac\theta2\langle a,u\rangle-T(a,z,z)$ | CONFIRMED |
| 6 | $\langle X^4W,W\rangle=\lVert u\rVert^2$, $\langle X^3W,z\rangle=-\lVert u\rVert^2$ | CONFIRMED |
| 7 | $\langle u,z\rangle=0$ | CONFIRMED, gloss corrected |
| 8 | the substitution yields $18\,T(u,z,z)=0$, non-circularly | CONFIRMED, and see F1 |
| 9 | $T(u,z,z)=\langle Bu,u\rangle$ | CONFIRMED |
| 10 | the record's $2$-jet objection does not bite | CONFIRMED, and see F2 |
| 11 | non-vacuity: some critical point carries $z\ne0$, $u\ne0$ | gap CONFIRMED REAL, claim TRUE, witness supplied |

**The conclusion $\langle Bu,u\rangle=0$ is correct and the derivation reaches it without error.** Two findings sit alongside that. **F1**, the headline, is that the target has a three-line proof from infinitesimal invariance that uses neither criticality nor any derivative above the first, which retires claim 2's Lean obligation entirely. **F2** is that the identity is established only for $z$ tangent to the orbit, so the record's "it is the whole of L51's fourth-order clause" holds only if that clause is evaluated at orbit directions.

## Claim 2, the multinomial coefficients, settled two ways

**Route one, the multinomial theorem.** For a trilinear $T$ and a smooth curve $w$, the $n$-fold Leibniz rule over three factors gives

$$\frac{d^n}{dt^n}T(w,w,w)=\sum_{i+j+k=n}\frac{n!}{i!\,j!\,k!}\,T\!\left(w^{(i)},w^{(j)},w^{(k)}\right),$$

the sum running over **ordered** triples. Full symmetry of $T$ then merges the arrangements of each partition of $4$:

| partition | arrangements | $4!/(i!j!k!)$ | total | term |
|---|---|---|---|---|
| $(4,0,0)$ | $3$ | $1$ | $3$ | $T(X^4W,W,W)$ |
| $(3,1,0)$ | $6$ | $4$ | $24$ | $T(X^3W,z,W)$ |
| $(2,2,0)$ | $3$ | $6$ | $18$ | $T(u,u,W)$ |
| $(2,1,1)$ | $3$ | $12$ | $36$ | $T(u,z,z)$ |

**Control, asserted rather than printed.** The coefficients of an $n$-fold trilinear Leibniz expansion sum to $3^n$, because setting every $w^{(i)}$ equal counts all ordered triples. Here $3+24+18+36=81=3^4$, and at order three $3+18+6=27=3^3$. Both assertions hold.

**Route two, by hand from the product rule**, on the scalar surrogate $V=\mathbb R$, $T(a,b,c)=abc$, which is fully symmetric and so exercises exactly the combinatorics under test. Differentiating $f=w^3$:

$$f'''=6w'^3+18ww'w''+3w^2w''',\qquad f''''=3w^2w''''+24ww'w'''+18w\,w''^2+36w'^2w''.$$

The four coefficients are $3,24,18,36$, matching route one term for term. Both routes were also screened symbolically, and the screen asserts the match rather than printing it.

**Verdict: CONFIRMED.** The coefficients are right.

### Does Mathlib reach claim 2, and is it therefore an obligation

**It does not reach it off the shelf, and the obligation is avoidable rather than owed.** What Mathlib carries is [iteratedDeriv_mul](../lean/.lake/packages/mathlib/Mathlib/Analysis/Calculus/IteratedDeriv/Lemmas.lean#L420), a binary Leibniz rule for a normed ring, and [iteratedDerivWithin_smul](../lean/.lake/packages/mathlib/Mathlib/Analysis/Calculus/IteratedDeriv/Lemmas.lean#L255) for a scalar action. For a general bounded bilinear map the only iterated-derivative results are the norm bounds in [Bounds.lean](../lean/.lake/packages/mathlib/Mathlib/Analysis/Calculus/ContDiff/Bounds.lean), such as [ContinuousLinearMap.norm_iteratedFDeriv_le_of_bilinear](../lean/.lake/packages/mathlib/Mathlib/Analysis/Calculus/ContDiff/Bounds.lean#L203), and there is no equality-form multilinear Leibniz and no ternary version of either. Assembling the order-four trilinear expansion would mean two nested applications of a bilinear Leibniz rule that first has to be stated for a general bounded bilinear map, plus the arithmetic of merging arrangements.

**The better reading is that claim 2 should not be formalised at all**, for the reason given under F1.

## Claim 1, constancy along the orbit

Let $g$ be a group element, so $g$ is an isometry and an automorphism of $\circ$. Then

$$T(ga,gb,gc)=\langle ga\circ gb,\,gc\rangle=\langle g(a\circ b),\,gc\rangle=\langle a\circ b,\,c\rangle=T(a,b,c),$$

the second equality by the automorphism property and the third by isometry. Taking $a=b=c=W$ and $g=e^{tX}$ gives $P(e^{tX}\cdot W)=P(W)$ for every $t$.

**Verdict: CONFIRMED.** Preserving the inner product and the product is exactly enough, and nothing further is needed for constancy.

**What the hypothesis carries beyond what the derivation spends.** Constancy of $P$ alone is strictly weaker than the invariance of $T$ just displayed. The derivation quoted in the brief never draws on the stronger form, because the extra content reaches it indirectly through the three given identities: $Q(e^{tX}\cdot W)=\theta\,e^{tX}\cdot W$ holds only because $g$ is an automorphism of $\circ$, so $Q(gW)=gW\circ gW=g(W\circ W)=\theta\,gW$. Since those three are given and out of scope here, claim 1 stands as stated. The differentiated form of the displayed invariance,

$$T(Xa,b,c)+T(a,Xb,c)+T(a,b,Xc)=0\qquad\text{for all }a,b,c,\tag{D}$$

is free from the same hypothesis, and F1 turns on it.

## Claims 3, 4 and 5, the given identities, statements only

These are hypothesis binders and the brief places their content out of scope. The **statements** are correct as transcriptions:

- **Claim 3.** $T(a,W,W)=\langle W\circ W,a\rangle=\langle\theta W,a\rangle=\theta\langle a,W\rangle$, using full symmetry to move $a$ into the slot the pairing exposes. **CONFIRMED.**
- **Claim 4.** $T(a,z,W)=\langle W\circ z,a\rangle=\langle L_Wz,a\rangle=\tfrac\theta2\langle z,a\rangle$. **CONFIRMED.**
- **Claim 5.** $\langle Bu,a\rangle=\tfrac\theta2\langle u,a\rangle-\langle L_Wu,a\rangle=\tfrac\theta2\langle a,u\rangle-T(a,u,W)$, and $\langle z\circ z,a\rangle=T(z,z,a)=T(a,z,z)$. So $Bu=z\circ z$ pairs to $T(a,u,W)=\tfrac\theta2\langle a,u\rangle-T(a,z,z)$, exactly as the brief has it, with no sign or factor slip. **CONFIRMED.**

## Claim 6, the skew-adjointness statements

Skew-adjointness gives $\langle Xa,b\rangle=-\langle a,Xb\rangle$, so each transfer of one $X$ across the pairing costs a sign.

$$\langle X^4W,W\rangle=-\langle X^3W,XW\rangle=+\langle X^2W,X^2W\rangle=\lVert u\rVert^2,$$
$$\langle X^3W,z\rangle=\langle X^3W,XW\rangle=-\langle X^2W,X^2W\rangle=-\lVert u\rVert^2.$$

Two sign flips in the first, one in the second. **Both statements say what the derivation needs, and the sign on the second is right**: it is negative, and that negative sign is what turns the $+24$ coefficient into the $-12\theta\lVert u\rVert^2$ the cancellation requires. Were the sign positive, the $\theta$ terms would read $3+12+9=24\ne0$ and no $\theta$-free conclusion would survive.

**Verdict: CONFIRMED**, statements checked independently of their proofs.

## Claim 7, $\langle u,z\rangle=0$, with the gloss corrected

$\langle X^2W,XW\rangle=-\langle XW,X^2W\rangle$, so the quantity equals its own negative and vanishes. **CONFIRMED.**

**The brief's gloss needs rewording.** It calls this "what makes the THIRD derivative's own relation consistent". Working that relation out, the coefficients are $3,18,6$ and it reads $3T(X^3W,W,W)+18\,T(u,z,W)+6\,T(z,z,z)=0$. Substituting claim 3 at $a=X^3W$ gives $3\theta\langle X^3W,W\rangle=-3\theta\langle u,z\rangle$, and claim 4 at $a=u$ gives $18\cdot\tfrac\theta2\langle u,z\rangle=9\theta\langle u,z\rangle$, so the relation collapses to

$$6\theta\langle u,z\rangle+6\,T(z,z,z)=0.$$

**Both summands vanish independently**: $\langle u,z\rangle=0$ by skewness, and $T(z,z,z)=\langle z\circ z,z\rangle=\langle Bu,z\rangle=\langle u,Bz\rangle=0$ because $B$ is self-adjoint and $Bz=\tfrac\theta2z-L_Wz=0$ by claim 4. The order-three relation is therefore a **consistency check satisfied term by term**, constraining nothing: any coefficients whatever would satisfy it. It is a weak control and should not be cited as a check on the order-four coefficients. The order-four relation does carry content, which is claim 8.

## Claim 8, the extraction, and whether it is circular

**The arithmetic.** Substituting claims 3 and 6 into the first term, claims 4 and 6 into the second, and claim 5 at $a=u$ into the third:

$$\underbrace{3\theta\lVert u\rVert^2}_{(4,0,0)}\;\underbrace{-\,12\theta\lVert u\rVert^2}_{(3,1,0)}\;+\;\underbrace{9\theta\lVert u\rVert^2-18\,T(u,z,z)}_{(2,2,0)}\;+\;\underbrace{36\,T(u,z,z)}_{(2,1,1)}\;=\;0,$$

so $(3-12+9)\,\theta\lVert u\rVert^2+(36-18)\,T(u,z,z)=0$, that is $18\,T(u,z,z)=0$, hence $T(u,z,z)=0$ since $18$ is invertible in $\mathbb R$. The arithmetic is right and matches the derivation under review.

**Is the extraction legitimate?** **Yes.** Each of claims 3, 4 and 5 is an identity quantified over all $a$, and each is used at one specific $a$, which is sound instantiation. The unknown does appear on both sides, once inside $T(u,u,W)$ with weight $18$ and once standing alone with weight $36$, but that is not circularity. The relation is one linear equation in the two scalars $\theta\lVert u\rVert^2$ and $T(u,z,z)$, and after substitution its coefficient vector is $(0,18)$. **A non-zero coefficient on the unknown is exactly what makes the equation informative**, and the two weights being unequal is what leaves that coefficient non-zero.

**The counterfactual the brief asks for.** Suppose the $(2,2,0)$ and $(2,1,1)$ coefficients had both been some common $c$. The unknown then enters with weight $-c+c=0$ and **cancels identically**, leaving

$$\left(3-12+\tfrac c2\right)\theta\lVert u\rVert^2=0.$$

At $c=18$ this reads $0=0$, an empty tautology carrying nothing about $T(u,z,z)$. At $c=36$ it reads $9\theta\lVert u\rVert^2=0$, which is false at both witnesses below, where $\theta\lVert u\rVert^2$ equals $4/3$ and $12$ respectively. So had the coefficients agreed, the argument would have produced either no information or a falsehood, and neither would be the target. **They do not agree**, $18\ne36$, checked in the table under claim 2 and re-derived by hand. The counterfactual was screened symbolically and the screen asserts the cancellation.

**Verdict: CONFIRMED.** The step is sound and not circular.

**But see F1.** $T(u,z,z)=0$ is independently forced, so the relation does not over-determine anything, and the fourth-order route is not the cheapest way to it.

## Claim 9, the restatement, and its direction

$$\langle Bu,u\rangle \;=\; \langle z\circ z,\,u\rangle \;=\; T(z,z,u)\;=\;T(u,z,z),$$

the first step by claim 5 in its vector form $Bu=z\circ z$, the second by the definition of $T$, the third by full symmetry. **The direction is right**, and claim 8 therefore is the item.

**One addition the brief does not ask for but the record needs.** If $B$ has a kernel, $Bu=z\circ z$ does not determine $u$. It does determine $\langle Bu,u\rangle$: for two solutions differing by $k\in\ker B$, $\langle z\circ z,k\rangle=\langle Bu,k\rangle=\langle u,Bk\rangle=0$ by self-adjointness. **The quantity is solution-independent**, so the identity is well posed even where the corrector is not unique.

**Verdict: CONFIRMED.**

## Claim 10, the record's $2$-jet objection

The record objects that the parabolic curve $W+tz+\tfrac{t^2}2u$ is only the orbit's $2$-jet, differing from it at $O(t^3)$ and so contaminating $[t^4]$.

**The objection is answered rather than side-stepped.** The argument differentiates $w(t)=e^{tX}\cdot W$ itself. Its third and fourth derivatives, $X^3W$ and $X^4W$, are not discarded: they are carried explicitly as the $(4,0,0)$ and $(3,1,0)$ terms with weights $3$ and $24$, and then eliminated by claims 3, 4 and 6, which is where the $3\theta\lVert u\rVert^2$ and $-12\theta\lVert u\rVert^2$ come from. The parabolic curve never appears, so its $O(t^3)$ discrepancy has nothing to contaminate. **The contamination is removed, not relocated.**

**Verdict: CONFIRMED**, with F2 attached.

## Claim 11, vacuity

**First, the two conditions in the claim are one condition.** Skew-adjointness gives

$$\langle u,W\rangle=\langle X^2W,W\rangle=-\langle XW,XW\rangle=-\lVert z\rVert^2,$$

so $u=0$ forces $z=0$, and $z=0$ gives $u=Xz=0$. Hence $z\ne0\iff u\ne0$, and a Lean statement carrying both hypotheses carries one. That identity also shows $u\ne0$ concretely rather than by contradiction, since $\langle u,W\rangle\ne0$ whenever $z\ne0$.

**The gap is REAL.** With no witness in the file, nothing in the Lean development rules out every instance being trivial, and the theorem would type-check over an empty hypothesis set. **It is an obligation.**

**The underlying claim is TRUE, and here is a witness that discharges it.** Take $V=\mathbb R^3$ with coordinates $(x,y,s)$, the standard inner product, and the cubic $P(x,y,s)=s(x^2+y^2)$, with $T$ its polarisation and $a\circ b$ defined by $\langle a\circ b,c\rangle=T(a,b,c)$. The circle acting by rotation in $(x,y)$ preserves the inner product and $P$, hence $T$, hence $\circ$, so it acts by isometric automorphisms. Then

$$W=(\sqrt2,0,1),\quad \theta=\tfrac23,\quad X=\begin{pmatrix}0&-1&0\\1&0&0\\0&0&0\end{pmatrix},\quad z=(0,\sqrt2,0),\quad u=(-\sqrt2,0,0),$$

with $W\circ W=\tfrac23W$, both $z$ and $u$ non-zero, and every hypothesis the brief lists satisfied: criticality, $L_Wz=\tfrac\theta2z$, $Bu=z\circ z$, skewness of $X$, and constancy of $P$ along the orbit. The order-four relation closes, $4-16+12+0=0$, and $\langle Bu,u\rangle=T(u,z,z)=0$.

**A second witness, chosen so the vanishing is not an artifact of the first.** In witness one every monomial of $P$ carries the $s$ factor while $z$ and $u$ are $s$-free, so $T(u,z,z)$ vanishes for a reason peculiar to that example. Take instead $V=\mathbb R^4=\mathbb C\oplus\mathbb C$ with the circle acting at weights $1$ and $2$, and $P=\operatorname{Re}\!\left(w_1^2\overline{w_2}\right)$. Then $W=(\sqrt2,0,1,0)$, $\theta=\tfrac23$, $z=(0,\sqrt2,0,2)$, $u=(-\sqrt2,0,-4,0)$, again with every hypothesis satisfied. Here $u$ and $z$ meet every monomial of $P$, and the screen asserts that $T(X^2V,XV,V)$, $T(X^2V,X^2V,V)$ and $T(XV,XV,V)$ are all non-zero as polynomials in the same example while $T(X^2V,XV,XV)$ vanishes identically. **The vanishing belongs to the slot pattern, not to the example.**

**Minimality.** $\dim V=3$ is the smallest possible. On $\mathbb R^2$ the cubics decompose under $SO(2)$ as $H_3\oplus r^2H_1$, carrying weights $\pm3$ and $\pm1$ and therefore no trivial summand, so the only invariant cubic is zero. That forces $P\equiv0$, hence $\circ\equiv0$, hence $\theta=0$ and $B=0$, and the instance degenerates. Any finite group has trivial Lie algebra and gives $X=0$. So witness one is smallest.

**Verdict: the gap is CONFIRMED REAL, the claim is TRUE, and witness one discharges it.**

## F1, the target has a three-line proof that uses no derivative above the first

Differentiate the invariance $T(e^{tX}a,e^{tX}b,e^{tX}c)=T(a,b,c)$ once at $t=0$, which is relation (D) from claim 1:

$$T(Xa,b,c)+T(a,Xb,c)+T(a,b,Xc)=0\qquad\text{for all }a,b,c.$$

Put $a=b=c=z$. Since $Xz=X^2W=u$, full symmetry of $T$ collapses the three terms:

$$3\,T(u,z,z)=0,\qquad\text{so}\qquad T(u,z,z)=0,\qquad\text{so}\qquad \langle Bu,u\rangle=0 .$$

**What this uses**: full symmetry of $T$, the hypothesis that the group acts by isometric automorphisms, and the definitions $z=XW$, $u=Xz$. **What it does not use**: criticality, $L_Wz=\tfrac\theta2z$, $Bu=z\circ z$, skew-adjointness of $X$, the value of $\theta$, and every derivative of order two or higher. The last step alone, translating $T(u,z,z)$ into $\langle Bu,u\rangle$, still needs claim 5 and hence criticality.

**Three consequences for the record.**

- **The Lean obligation named in claim 2 disappears.** No multilinear Leibniz rule is needed, no `iteratedDeriv` on a trilinear map, and no order-four expansion. Relation (D) is a single hypothesis binder of the same shape as `hcrit`, and the proof is two rewrites and a division by $3$. On the same argument `skew_three`, `skew_four` and `inner_u_z_eq_zero` become unnecessary for this result.
- **The record's reading of the $\theta$ cancellation is inverted.** The derivation says the cancellation $3-12+9=0$ "is the whole content", visible as the absence of $\theta$ from the conclusion. The sharper statement is that **$\theta$ was never involved**: the identity holds at every $W$ in $V$ and every $X$ in the Lie algebra, critical or not. The cancellation is the fourth-order route rediscovering that fact, not the source of it.
- **It settles the brief's own vacuity worry in its sharper form.** The brief asks whether the identity is "forced on a quantity that is identically zero for an unrelated reason". It is: $T(X^2V,XV,XV)=0$ for every $V$, by invariance alone. The identity is still a real fact with real content about orbit directions, and $z$ and $u$ are genuinely non-zero, so claim 11 stands. But the content is invariance, and neither criticality nor the fourth-order structure contributes to it.

## F2, the identity is established only for $z$ tangent to the orbit

The record's quoted claim is that this is **the whole of** L51's fourth-order clause, whose value at the stationary corrector is $\tfrac34\langle Bu,u\rangle$.

**That holds only where the clause is evaluated at an orbit direction.** Everything above is proved for $z=XW$ and $u=X^2W$. The hypothesis that carries $z$ into L51 is $L_Wz=\tfrac\theta2z$, which says $z$ lies in the $\tfrac\theta2$-eigenspace of $L_W$. Orbit tangents lie in that eigenspace, but **the eigenspace may be strictly larger than the orbit tangent space**, and for such a $z$ there is no $X$ at all: $u$ is then whatever solves $Bu=z\circ z$, relation (D) has nothing to act on, and the order-four expansion has no curve to differentiate. Nothing proved here applies.

**Why this matters rather than being a technicality.** Orbit directions are the directions along which $P$ is constant by construction, so a fourth-order term vanishing there is close to expected. The directions that decide a strictness or local-maximality argument are precisely the eigenspace directions that are **not** orbit tangents, and those are untouched.

**The correction to make.** Restate the item as: the fourth-order clause vanishes **on orbit directions**. Whether the $\tfrac\theta2$-eigenspace of $L_W$ coincides with the orbit tangent space at the critical points of interest is a separate question, and closing it is what would upgrade this to the whole of the clause.

## Corrections, collected

| where | correction |
|---|---|
| claim 7's gloss | the order-three relation is satisfied term by term and constrains nothing, so it is a consistency check and not a control on the coefficients |
| the derivation's closing sentence | $\theta$ is absent from the conclusion because it never entered, not because $3-12+9=0$ |
| claim 11's two hypotheses | $\langle u,W\rangle=-\lVert z\rVert^2$ makes $z\ne0$ and $u\ne0$ the same condition |
| the Lean file | add the three-dimensional witness, which discharges the vacuity gap |
| the Lean file | (D) as a hypothesis binder replaces the order-four expansion, `skew_three`, `skew_four` and `inner_u_z_eq_zero` |
| the record's framing | scope the claim to orbit directions until the eigenspace question of F2 is settled |

## Screening note

Every numeric statement above was screened symbolically on objects constructed for the purpose, in seconds, with the screens written as assertions rather than printed expectations. **No screen is offered as evidence for a positive claim**: claims 1 to 10 are each established by the derivations given above, and the screens only guard against transcription error. The witnesses of claim 11 are the one place a construction carries weight, and both are exhibited in closed form so they can be checked by hand.
