# Verifier v174, Lemma L31, the bracket cap characterised, both directions and the equality case

I read [BRIEF_L31.md](BRIEF_L31.md) cold and checked the block at [stratum-two-negative.md:417-438](../findings/stratum-two-negative.md#L417) against [conventions.md](../findings/conventions.md). Every derivation below is by hand from the definitions; every constant is exact. **No numerical work was done** (no script, no Sage, no evaluation), in keeping with the programme's analysis-only rule; the two decimals that appear ($s^2=(0.5,0.3,0.2)$, and the record's own measured $\lVert XY\rVert_F=1$) are read as the exact rationals $(1/2,3/10,1/5)$ and as a quoted figure of the record, never as evidence. Log: [agent_logs/verify-L31-v174.log](../agent_logs/verify-L31-v174.log).

## The claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | The root-system identity $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$, exactly, with an admissible real maximiser | **PROVEN** |
| 1a | The short-root family $i(\pm s_i)$ is present exactly at odd $n$, and cannot beat $(s_1+s_2)^2$ | **CONFIRMED, the block's eigenvalue list is parity-blind, harmlessly** |
| 1b | The identity at the smallest dimensions: $n=2$ | **FALSE AT $n=2$, vacuous for L31, scope note owed** |
| 2 | Cauchy–Schwarz: $\sum_is_i^2=1$ gives $(s_1+s_2)^2\le2$, equality only at $s_1=s_2=1/\sqrt2$, rest zero, rank $4$ | **PROVEN, and the normalisation is the record's** |
| 3 | Both inequalities of the two-step chain are equalities simultaneously | **TRUE, but the block never shows the chain is tight** |
| 3a | Columns of $Y$ in $X$'s top singular subspace, $=\mathrm{im}\,X$ since the nonzero singular values coincide | **PROVEN** |
| 3b | $\mathrm{im}\,Y\subseteq\mathrm{im}\,X$ | **PROVEN** |
| 3c | $XY=-YX$ from the triangle step with $\lVert XY\rVert_F=\lVert YX\rVert_F$ | **PROVEN** |
| 4 | "and symmetrically" gives $\mathrm{im}\,X=\mathrm{im}\,Y$ | **PROVEN, and redundant, a dimension count already closes it** |
| 5 | The converse: $X^2=Y^2=-P_V/2$, $[X,Y]=2XY$, $\lVert[X,Y]\rVert^2=\operatorname{tr}(Y^{\mathsf T}Y)=2$ | **PROVEN in the record's normalisation** |
| 6 | The recorded correction: $s^2=(0.5,0.3,0.2)$ kills the $4s_1^2$ route, and the replacement avoids the flaw | **CONFIRMED, needs $n\ge6$ (unstated)** |
| 7 | L31 delivers [L29](../findings/stratum-two-negative.md#L69)'s clause *"equality forces the support to have $r=4$"*, in three lines | **CONFIRMED, the chain closes** |
| 8 | The three conditions are independent; the biconditional is non-vacuous | **CONFIRMED, both witnesses constructed in closed form** |
| 9 | Orthogonality of $X,Y$ is used somewhere | **UNUSED, implied by the conclusion, so harmless** |
| 10 | The anchor `#lemma-l31--the-pair-cap` at [results.md:451](../results.md#L451) | **DEAD** |

## Summary

**Lemma L31 is PROVEN (statement, both directions, and the equality case) and it does deliver the clause [results.md:451](../results.md#L451) reassigned to it; what the block owes is one line of norm conversion, a parity qualifier, and an $n\ge6$ note, none of which touch the mathematics.**

## 0. Conventions, fixed once

Three norms appear in one proof, so the conversion is fixed before anything else. From [conventions.md](../findings/conventions.md), quoted:

> **A skew matrix's norm**, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}X)$, singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_i s_i^2=1$. Equivalent to $\operatorname{tr}(v^2)=-2$ above.

> **The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.** The inner product is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix.

> **The $\Lambda^2$ and $n\times n$ Frobenius pairings differ by a factor $2$.** Two reviewers once disagreed on a value for exactly this reason.

So the bare $\lVert\cdot\rVert$ of L31 is the half-trace norm, and for every $A\in\mathfrak{so}(n)$,

$$\lVert A\rVert^2=\tfrac12\lVert A\rVert_F^2,\qquad\text{i.e.}\qquad \lVert A\rVert_F=\sqrt2\,\lVert A\rVert .$$

The $s_i$ are indexed **once per singular-value pair** (the "angles") so $\lVert X\rVert=1$ reads $\sum_is_i^2=1$ with the sum over pairs. This is exactly what the Cauchy–Schwarz step consumes; under the other reading (the full singular-value list with repeats) the sum is $2$ and the step would give $(s_1+s_2)^2\le4$, so the constant $2$ of the lemma rests on this convention and on no other.

The convention table also records the two live collisions this block sits in. $P$ is *"the cubic form $\langle W,Q(W)\rangle$"* in the same table, against the block's $P_V$ for the orthogonal projector onto $V$; and $r$ *"is the support dimension at line 33 and the second parameter of $W_4$ at line 166"* inside this very file. Neither is ambiguous in context here (the subscript disambiguates $P_V$, and $r$ appears only in the consumer clause) but both are noted.

Numeric consequences, fixed once and used throughout section 3:

| quantity | half-trace | Frobenius / operator |
| --- | --- | --- |
| $\lVert X\rVert=\lVert Y\rVert=1$ | $1$ | $\lVert X\rVert_F=\lVert Y\rVert_F=\sqrt2$ |
| $\lVert[X,Y]\rVert^2=2$ | $2$ | $\lVert[X,Y]\rVert_F=2$ |
| $X$ of rank $4$, all $s_i=1/\sqrt2$ |, | $\lVert X\rVert_{\rm op}=s_1=1/\sqrt2$ |

## 1. The hypothesis inventory

**A pass with no inventory is not a pass, so here is the full list, and what the written proof does with each.**

| hypothesis | where stated | used where | verdict |
| --- | --- | --- | --- |
| $X,Y\in\mathfrak{so}(n)$, real skew-symmetric | statement | throughout, normal form, $YX=(XY)^{\mathsf T}$, $X^{\mathsf T}X=-X^2$ | **used, essential** |
| $\lVert X\rVert=1$ under the half-trace norm | "orthonormal" | Cauchy–Schwarz step, as $\sum_is_i^2=1$ | **used, essential** |
| $\lVert Y\rVert=1$ | "orthonormal" | the $\max_{\lVert Y\rVert=1}$ quantifier, and the converse's $\operatorname{tr}(Y^{\mathsf T}Y)=2$ | **used, essential** |
| $\langle X,Y\rangle=0$ | "orthonormal" | **nowhere** | **UNUSED, see §9** |
| a dimension restriction on $n$ | *none stated* | none needed | **correctly absent, see §1b** |
| $Y$ has rank $4$ with all $s_i=1/\sqrt2$ | statement, and the italic derivation note | the symmetrisation of §4, via $\lVert Y\rVert_{\rm op}=1/\sqrt2$ | **derived, then used** |
| $\mathrm{im}\,X=\mathrm{im}\,Y=:V$ | statement | the converse, as the *same* $V$ in $X^2=Y^2=-P_V/2$ and in $P_VY=Y$ | **used, essential** |
| $XY=-YX$ | statement | the converse, as $[X,Y]=2XY$ | **used, essential** |

Nothing is imported beyond the root-space decomposition of $\mathfrak{so}(n)$, whose own hypotheses are checked in §1a.

## 2. The root-system identity, §1 of the table

**What the block writes.** *"The roots of $\mathfrak{so}(n)$ give $\mathrm{ad}_X$ the eigenvalues $i(\pm s_i\pm s_j)$ and $i(\pm s_i)$ for the angles $s_i$ of $X$, so $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$ exactly."*

**Quantifier order.** The maximum is over $Y$ at fixed $X$; $s_1\ge s_2\ge\cdots\ge0$ are $X$'s angles alone. Both sides of the identity are functions of $X$ only, and the half-trace form is $\mathrm{Ad}(O(n))$-invariant, so both sides are conjugation-invariant and $X$ may be put in block normal form without loss.

**The upper bound.** The half-trace form is invariant, $\langle[X,Y],Z\rangle=-\langle Y,[X,Z]\rangle$, so $\mathrm{ad}_X$ is skew-adjoint on the real space $\mathfrak{so}(n)$ and $-\mathrm{ad}_X^2$ is symmetric positive semidefinite with

$$\lVert[X,Y]\rVert^2=\langle-\mathrm{ad}_X^2\,Y,\,Y\rangle .$$

The maximum over the unit sphere is therefore the top eigenvalue of $-\mathrm{ad}_X^2$, which is $\max|\lambda|^2$ over the eigenvalues $\lambda$ of $\mathrm{ad}_X$ on the complexification. Putting $X$ in a Cartan subalgebra, every skew matrix is $O(n)$-conjugate to $\bigoplus_i s_i J$ (plus a zero row and column at odd $n$), and those blocks span a Cartan subalgebra, $\mathrm{ad}_X$ acts on the root space $\mathfrak g_\alpha$ by $\alpha(X)$ and on the Cartan by $0$. The root values are $i(\pm s_i\pm s_j)$ (type $D_m$ and $B_m$ alike) and, at odd $n$ only, $i(\pm s_i)$. Since $s_i\le s_1\le s_1+s_2$, the largest modulus over all of these is $s_1+s_2$, so $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2\le(s_1+s_2)^2$.

**The lower bound, with a real admissible maximiser, exhibited.** Write $\varphi_{ab}=E_{ab}-E_{ba}$, which is orthonormal under the half-trace form ([conventions.md](../findings/conventions.md): *"$\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal"*). Take $X=s_1\varphi_{12}+s_2\varphi_{34}+\cdots$ and set

$$Y_1=\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24}),\qquad Y_2=\tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23}),$$

both real, skew, and of norm $1$, hence admissible. From $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$ one gets $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$, $[\varphi_{12},\varphi_{24}]=\varphi_{14}$, $[\varphi_{34},\varphi_{13}]=-\varphi_{14}$, $[\varphi_{34},\varphi_{24}]=\varphi_{23}$, and therefore

$$[X,Y_1]=\tfrac1{\sqrt2}\big(-s_1\varphi_{23}-s_1\varphi_{14}-s_2\varphi_{14}-s_2\varphi_{23}\big)=-(s_1+s_2)\,Y_2,$$

of norm exactly $s_1+s_2$. So the bound is attained and the identity is an **equality, not merely an upper bound**, with the maximiser real, skew, unit-norm and lying in $\mathfrak{so}(n)$ for every $n\ge4$.

**What the forward direction actually needs** is only the $\le$ half. The exactness is more than the proof consumes, so it is a strengthening rather than a load-bearing step.

### 1a. The short-root family, and the block's parity-blind list

**Present exactly at odd $n$.** $\mathfrak{so}(2m)$ is type $D_m$ with roots $\pm e_i\pm e_j$ only; $\mathfrak{so}(2m+1)$ is type $B_m$ and adds $\pm e_i$. The block writes the two families as one unconditional list.

**Located** at [line 34-35](../findings/stratum-two-negative.md#L34). **Exhibited**: at $n=4$, $\dim\mathfrak{so}(4)=6=2+4$, the $2$ being the Cartan and the $4$ the roots $\pm e_1\pm e_2$; four short-root spaces would force $\dim\ge10$. Concretely, at $X=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$ the spectrum of $\mathrm{ad}_X$ is $\{\pm i\sqrt2,\,0,0,0,0\}$, and $is_1=i/\sqrt2$ is not in it. **Argued the opposite**: the sentence is fairly read as the union of the root values across both parities, which is how [conventions.md](../findings/conventions.md) records the same ambiguity elsewhere (*"$D_p$ carries opposite senses four lines apart), the roots of $\mathfrak{so}(m)$ in the proof, where the short roots must be included, and the long roots only in the scope paragraph"*.

**Verdict: a real imprecision, inconsequential.** The maximum is unaffected in either parity, because $s_1\le s_1+s_2$ with equality only when $s_2=0$, the rank-$2$ case, where the identity still reads correctly as $s_1^2$.

### 1b. The boundary of every stated range

| $n$ | rank-$4$ orthonormal pairs | the identity $\max=(s_1+s_2)^2$ | L31 |
| --- | --- | --- | --- |
| $2$ | none, $\dim\mathfrak{so}(2)=1$, no pair at all | **false**: $\mathrm{ad}_X\equiv0$ so $\max=0$, while $s_1=1$ gives $(s_1+s_2)^2=1$ | **vacuous**, both sides false |
| $3$ | none | true: type $B_1$, $\max=s_1^2=1$, and the formula reads $s_1^2$ with $s_2=0$ | vacuous; $\lVert[X,Y]\rVert^2=1<2$ for every orthonormal pair |
| $4$ | **the smallest**, $\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$ and $\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24})$ | true: type $D_2$, no short roots, $\max=(s_1+s_2)^2=2$ | **non-vacuous, both directions live** |
| $5$ | yes, inside $\mathbb R^4\subset\mathbb R^5$ | true: type $B_2$, both root families, short roots do not beat | fine; the odd case is covered by §1a |
| $\ge6$ | yes | true | fine |

**The $n=2$ failure is real and inconsequential.** *Located*: the identity as quoted, [line 35](../findings/stratum-two-negative.md#L35). *Exhibited*: $X=\varphi_{12}\in\mathfrak{so}(2)$ has $\lVert X\rVert=1$, $s_1=1$, and $\mathrm{ad}_X=0$, so the two sides read $0$ and $1$. *Argued the opposite*: $\mathfrak{so}(2)$ is abelian and has no root system, so the sentence's own premise is absent there and the sentence is not asserting anything about $n=2$; and L31's hypothesis of an orthonormal *pair* is unsatisfiable in a one-dimensional space. **Verdict: a scope note owed on the identity, no defect in L31.**

**No $n$-restriction is needed and the block correctly states none.** At $n\le3$ both sides of the biconditional are false, so it holds vacuously; from $n=4$ both are live.

### 1c. Degenerate $X$ or $Y$, the $\ker W\ne0$ trap, in this lemma's form

The trap here is low-rank $X$ or $Y$, which is the generic situation at large $n$ since $\lVert X\rVert=1$ puts no lower bound on the rank. **The argument handles it without a case split.** If $X$ has rank $2$ then $s_2=0$ and $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=s_1^2=1<2$, so equality is impossible; the same for any profile with $s_1^2+s_2^2<1$. $X=0$ or $Y=0$ is excluded by $\lVert X\rVert=\lVert Y\rVert=1$. The one place degeneracy could have bitten (the "top singular subspace is all of $\mathrm{im}\,X$" step of §3a), is protected because by then the rank is already pinned at $4$ with all four singular values equal. **Nothing found.**

## 3. The Cauchy–Schwarz step, §2 of the table

$(s_1+s_2)^2\le2(s_1^2+s_2^2)\le2\sum_is_i^2=2$. The first is Cauchy–Schwarz on $(1,1)\cdot(s_1,s_2)$, with equality iff $s_1=s_2$; the second has equality iff $s_i=0$ for all $i\ge3$. Together: $2s_1^2=1$, so $s_1=s_2=1/\sqrt2$ and everything else vanishes, giving $\operatorname{rank}X=2\cdot2=4$ with all four nonzero singular values $1/\sqrt2$. Exactly as written.

**The normalisation is the record's.** $\sum_is_i^2=1$ *is* what $\lVert X\rVert=1$ means here, per the quoted bullet of §0, the sum runs over pairs. This is the factor-of-two the brief flags, and it comes out right: had $s$ ranged over the full singular-value list the sum would be $2$ and the bound $4$, and the lemma's constant would be wrong. **Nothing found.**

## 4. The two-step chain and its three conclusions, §3 of the table

**The chain is tight, and the block never says why.** This is the one place where the three norms have to be reconciled, and the block reconciles them nowhere. Doing it from §0: at this point in the proof $\operatorname{rank}X=4$ with all $s_i=1/\sqrt2$ is already in hand, so

$$\lVert[X,Y]\rVert_F=\sqrt2\cdot\sqrt{\lVert[X,Y]\rVert^2}=\sqrt2\cdot\sqrt2=2,\qquad 2\lVert X\rVert_{\rm op}\lVert Y\rVert_F=2\cdot\tfrac1{\sqrt2}\cdot\sqrt2=2 .$$

The two ends of $\lVert[X,Y]\rVert_F\le\lVert XY\rVert_F+\lVert YX\rVert_F\le2\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ therefore both equal $2$, so **both inequalities are equalities simultaneously, forced, not merely possible.** The record's own development copy at [line 279](../findings/stratum-two-negative.md#L279) reports $\lVert XY\rVert_F=\lVert X\rVert_{\rm op}\lVert Y\rVert_F=1$ *"exactly"*, which is the same arithmetic read off the other side and corroborates the conversion.

**This is a documentation debt, not a gap.** The step is true and I verified it rather than assumed it; what the block owes is the one line above, and [conventions.md](../findings/conventions.md) names precisely this hazard, *"The $\Lambda^2$ and $n\times n$ Frobenius pairings differ by a factor $2$. Two reviewers once disagreed on a value for exactly this reason."*

### 3a and 3b. The columns of $Y$, and $\mathrm{im}\,Y\subseteq\mathrm{im}\,X$

Equality in the *second* inequality splits into $\lVert XY\rVert_F=\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ and $\lVert YX\rVert_F=\lVert X\rVert_{\rm op}\lVert Y\rVert_F$, since each is separately at most $\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ and their sum is twice it. Writing $y_1,\dots,y_n$ for the columns of $Y$,

$$\lVert XY\rVert_F^2=\sum_j\lVert Xy_j\rVert^2\le s_1^2\sum_j\lVert y_j\rVert^2=\lVert X\rVert_{\rm op}^2\lVert Y\rVert_F^2,$$

with equality term by term, so every $y_j$ lies in the top singular subspace of $X$. Since all four nonzero singular values of $X$ coincide, that subspace is the full column space of $X$; and $X$ skew makes column space $=$ row space $=\mathrm{im}\,X$. Hence $\mathrm{im}\,Y\subseteq\mathrm{im}\,X$. **Both conclusions follow, and the "since the nonzero singular values coincide" clause is genuinely load-bearing**, without it the top singular subspace could be a proper subspace of $\mathrm{im}\,X$ and the inclusion would say less.

### 3c. $XY=-YX$

$Y X=(X^{\mathsf T}Y^{\mathsf T})^{\mathsf T}$, more directly, $(YX)^{\mathsf T}=X^{\mathsf T}Y^{\mathsf T}=(-X)(-Y)=XY$, so $YX=(XY)^{\mathsf T}$ and $\lVert YX\rVert_F=\lVert XY\rVert_F$ **automatically**, for any skew pair. Setting $A=XY$ and $B=YX$, equality in $\lVert A-B\rVert_F=\lVert A\rVert_F+\lVert B\rVert_F$ is Cauchy–Schwarz equality with the sign $\langle A,-B\rangle_F=\lVert A\rVert_F\lVert B\rVert_F$, hence $-B=cA$ with $c>0$ once $A\ne0$; and $\lVert A\rVert_F=\lVert B\rVert_F$ gives $c=1$, so $YX=-XY$. The side condition $A\ne0$ holds because $\lVert XY\rVert_F=\lVert X\rVert_{\rm op}\lVert Y\rVert_F=1$. **Follows as written.**

## 5. The symmetrisation, §4 of the table

*"and symmetrically"* means: run §3a–3b with the roles of $X$ and $Y$ exchanged, using $\lVert[Y,X]\rVert_F=\lVert[X,Y]\rVert_F=2$ and $\lVert Y\rVert_{\rm op}=1/\sqrt2$, to get $\mathrm{im}\,X\subseteq\mathrm{im}\,Y$ and hence equality.

**What it needs** is the rank-$4$-with-equal-singular-values conclusion **for $Y$**, without which $\lVert Y\rVert_{\rm op}$ is unknown and the swapped chain is not tight. The block supplies it in the statement paragraph, *"The rank is derived for $X$ and follows for $Y$ by the symmetry of the bracket in its two arguments"*, and that is sound: $\lVert[Y,X]\rVert^2=\lVert[X,Y]\rVert^2=2$, so §2 and §3 apply verbatim with the arguments exchanged. **The ingredient is present, though it sits outside the proof paragraph that consumes it.**

**And the symmetrisation is redundant.** $\mathrm{im}\,Y\subseteq\mathrm{im}\,X$ with both images of dimension $4$ already forces equality. So this conclusion has two independent routes and is the most robust clause in the lemma.

## 6. The converse, §5 of the table

Assume the right-hand side. Rank $4$ with all singular values $1/\sqrt2$ and $\mathrm{im}\,X=\mathrm{im}\,Y=:V$ gives $X^{\mathsf T}X=\tfrac12P_V$, i.e. $-X^2=\tfrac12P_V$, so $X^2=Y^2=-P_V/2$ as the block writes; and $\lVert X\rVert^2=\tfrac12\operatorname{tr}(\tfrac12P_V)=\tfrac{\dim V}4=1$ recovers $\dim V=4$, consistent.

$[X,Y]=XY-YX=XY-(-XY)=2XY$, **which is exactly the anticommuting hypothesis and nothing more.** Then, using $P_VY=Y$ (from $\mathrm{im}\,Y\subseteq V$),

$$\lVert[X,Y]\rVert^2=4\lVert XY\rVert^2=4\cdot\tfrac12\operatorname{tr}\!\big(Y^{\mathsf T}X^{\mathsf T}XY\big)=2\operatorname{tr}\!\big(Y^{\mathsf T}\cdot\tfrac12P_V\cdot Y\big)=\operatorname{tr}(Y^{\mathsf T}Y)=2\lVert Y\rVert^2=2 .$$

**The trace does evaluate to $2$ in the record's normalisation**, $\operatorname{tr}(Y^{\mathsf T}Y)=2\lVert Y\rVert^2$, and $\lVert Y\rVert=1$. Every step of the block's one-line converse checks, and it is an identity valid for all such $X,Y$, **not a check at one object**. The consistency of the right-hand side with the "orthonormal" hypothesis also holds automatically: anticommuting skew $X,Y$ have $\operatorname{tr}(XY)=\operatorname{tr}(YX)=-\operatorname{tr}(XY)=0$, so $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(XY)=0$.

## 7. The recorded correction, §6 of the table

**The counterexample is valid.** $s^2=(1/2,3/10,1/5)$ sums to $5/10+3/10+2/10=1$ exactly, has $s_1^2=1/2\ge1/2$, and has three nonzero angles, so $\operatorname{rank}X=6$. The inference "$\lVert[X,Y]\rVert^2\le4s_1^2$ and the cap force rank $4$" therefore fails. **It requires $n\ge6$, which the block does not say**, three angles do not fit below $\mathfrak{so}(6)$. The parallel copy at [line 273](../findings/stratum-two-negative.md#L273) adds a second profile $(0.6,0.3,0.1)$ and the further remark that $4s_1^2$ reads $4$ at rank $2$ against a true maximum of $1$; both agree with the canonical block.

**The replacement genuinely avoids the flaw.** The new route bounds $\lVert[X,Y]\rVert^2\le(s_1+s_2)^2$, which is at most $4s_1^2$ since $s_2\le s_1$, and is strictly smaller whenever $s_2<s_1$. On the counterexample profile itself, $(s_1+s_2)^2\le2(s_1^2+s_2^2)=2\cdot\tfrac45=\tfrac85<2$, so the profile is excluded outright by the replacement, no square roots needed. The flaw in the old route was that $s_1^2\ge\tfrac12$ is a one-coordinate condition that says nothing about the tail; the replacement's Cauchy–Schwarz constrains $s_1,s_2$ and the tail together, which is exactly the missing content.

**Provenance nit.** The block closes *"Gate 2 passed, the repair supplied by the review"* with no review number, where every neighbouring block cites one. The repair is [REVIEW_r58](../reviews/REVIEW_r58.md) (both the counterexample and the root-system replacement appear there verbatim); the Gate 2 pair is [r543](../reviews/REVIEW_r543.md) and [r544](../reviews/REVIEW_r544.md), named in [INDEX-results.md](../findings/INDEX-results.md) but not in the block.

## 8. Does L31 deliver L29's clause?, §7 of the table

[results.md:451](../results.md#L451) credits L31 with *"equality forces the support to have $r=4$"*, in three lines. The chain [L29](../findings/stratum-two-negative.md#L69)'s block states is: *"equality forces $T_{1,N-1,N}=2$, hence $\lVert[v_{N-1},v_N]\rVert^2=2$, hence $\operatorname{im}v_2=\operatorname{im}v_3$ of dimension $4$, hence $r=4$ through Ricci-flatness."* Each link:

1. **$T_{1,N-1,N}=2$.** L29's only inequality is $3T_{1,N-1,N}\lambda_1ab\le6\lambda_1ab$. With one positive and two negative eigenvalues, $\lambda_1>0$ and $a,b>0$, so $\lambda_1ab\ne0$ and equality in $\theta$ forces $T_{1,N-1,N}=2$. **Holds.**
2. **$\lVert[v_{N-1},v_N]\rVert^2=2$.** By the pair cap in the form [conventions.md](../findings/conventions.md) records (*"The pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$"*) and $T\ge0$, we get $2=T_{1,N-1,N}\le\sum_\gamma T_{N-1,N,\gamma}=\lVert[v_{N-1},v_N]\rVert^2\le2$. **Holds.**
3. **L31 applies.** $v_{N-1},v_N$ are eigenvectors of $W$ as an operator on $\Lambda^2$, so they are orthonormal in the $\Lambda^2$ inner product $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, **which is exactly L31's norm**, so the constant $2$ transports without a conversion. L31 then gives $\mathrm{im}\,v_{N-1}=\mathrm{im}\,v_N$ of dimension $4$. **Holds.**
4. **$r=4$.** Ricci-flatness reads $\lambda_1v_1v_1^{\mathsf T}=a\,v_2v_2^{\mathsf T}+b\,v_3v_3^{\mathsf T}$ with all terms positive semidefinite and $a,b>0$, so $\mathrm{im}\,v_1=\mathrm{im}\,v_2+\mathrm{im}\,v_3=\mathrm{im}\,v_2$, of dimension $4$; and the support is exactly $\mathrm{im}\,v_1$. **Holds.**

**Verdict: L31 delivers the clause, at every $n$ and with no numerics, in the lines the record claims.** Two notes that do not disturb it:

- **A notation slip in the chain.** It opens with $v_{N-1},v_N$ and closes with $\operatorname{im}v_2=\operatorname{im}v_3$, the same two vectors under this file's other indexing for the one-positive stratum. Unambiguous, but it is a third live index convention alongside the collisions [conventions.md](../findings/conventions.md) already tables for this file.
- **The two sites disagree about what L31 closes.** [L29](../findings/stratum-two-negative.md#L69)'s block says L31 closes *"the converse, that equality forces that spectrum"* and then gives a chain terminating at $r=4$; [results.md:451](../results.md#L451) splits the two correctly, assigning the spectrum to L29's own $f(t)$ equality case and only $r=4$ to L31. **results.md is the accurate site**; L29's block conflates the two, and only the $r=4$ half is L31's.

### 8a. An impact note on the consumer, outside L31

[stratum-two-negative.md:35](../findings/stratum-two-negative.md#L35) is headed *"The equality clause, closed"* and then says the characterisation *"forces $\mathrm{im}\,v_2=\mathrm{im}\,v_3$ of dimension $4$, hence $r=4$, so the iff is **equivalent to**: no full-support rank-$3$ signature-$(1,2)$ element of $\mathrm{Weyl}_r$ exists for even $r\ge6$"*, hedged on numerics at $r=6,8,10$ with $r\ge12$ untested. **The first half makes the second half vacuous**: if $r=4$ is forced, there is nothing at $r\ge6$ to exclude. This is a stale hedge in the development section, surviving the repair that removed the need for it. **It is a defect of the consumer's prose, not of L31**, and I record it only because it is the sentence a reader chasing L31's closure lands on.

## 9. The remaining named traps

- **A hypothesis stated but never used, found.** *Orthogonality* of $X$ and $Y$ is never used, in either direction. The forward direction runs on $\lVert X\rVert=\lVert Y\rVert=1$ alone; the converse derives $\langle X,Y\rangle=0$ from anticommuting (§6). So L31 holds verbatim with "unit-norm" in place of "orthonormal", and orthogonality is a **consequence** of either side rather than a hypothesis. *Argued the opposite*: "orthonormal" is the standing phrase for such pairs across the stratum arguments, where the $v_\alpha$ are eigenvectors and orthogonality is free, so the word costs nothing and matches the consumers. **Harmless, and worth a sentence.**
- **A step using a hypothesis never stated, found, three.** The chain's tightness needs the norm conversion of §0 (§4); the symmetrisation needs $\lVert Y\rVert_{\rm op}=1/\sqrt2$, stated in the statement paragraph rather than the proof (§5); and the identity silently sets $s_2=0$ when $X$ has a single angle (§2). All three are true and all three are unwritten.
- **A claim proven on a subfamily and used in general, nothing found.** The root-space step is valid for every $X\in\mathfrak{so}(n)$, singular or regular, since every skew matrix conjugates into a Cartan subalgebra and $\mathrm{ad}_X$ acts on $\mathfrak g_\alpha$ by $\alpha(X)$ regardless. I checked the three live consumers, [:208](../findings/stratum-two-negative.md#L208) (*"the sum has rank exactly $4$"*: $X^{\mathsf T}X+Y^{\mathsf T}Y=\tfrac12P_V+\tfrac12P_V=P_V$, rank $4$, correct), [:269](../findings/stratum-two-negative.md#L269) (*"at $n=8$ would make the common kernel $4$-dimensional"*: $V^\perp$ in $\mathbb R^8$ has dimension $4$, correct), and [:281](../findings/stratum-two-negative.md#L281), and each uses the general statement.
- **A universal claim with no witness, nothing found.** The right-hand side is realised: $X=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$ and $Y=\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24})$ in $\mathfrak{so}(4)$, and their paddings at every $n\ge4$. This is the maximiser of §2 at $s_1=s_2=1/\sqrt2$, so both directions have the same witness.
- **A biconditional whose converse is checked at one object, nothing found.** §6 is an identity in $X,Y$.
- **An imported theorem whose hypotheses were never checked, checked, and it survives.** The only import is the root-space decomposition. Its hypotheses (a Cartan subalgebra containing $X$, and the root values), hold at every $n\ge3$; $\mathfrak{so}(4)$ is not simple but is still type $D_2$ and reductive, so the decomposition stands; $\mathfrak{so}(2)$ is abelian and has no roots, which is the $n=2$ failure of §1b. No unital-algebra hazard of the kind that killed the earlier route arises here.
- **Symbol collisions, three, all benign in context.** $P$ (the cubic form, tabled) against $P_V$ (the projector); $r$ (the support dimension, and $W_4$'s second parameter in the same file) against the consumer clause's $r=4$; and $s$ as the per-pair angle against the full singular-value list, the last is the one that would change the constant, and §0 fixes it. $X,Y,V$ carry no competing sense inside this block. **The three norms are the sharper hazard and are handled in §0 and §4.**

### 9a. Withdrawn candidates

- **"The eigenvalue list $i(\pm s_i)$ is false at even $n$."** Located and exhibited at $n=4$ (§1a), but the charitable reading (a union across parities), is what [conventions.md](../findings/conventions.md) records the record itself doing elsewhere, and the maximum is unaffected either way. **Withdrawn as a defect; kept as an imprecision.**
- **"The two-step chain is asserted tight without proof, so the equality analysis is a gap."** Located at [line 37](../findings/stratum-two-negative.md#L37) and the tightness is genuinely unwritten, but it is true and I derived it from the record's own conventions in one line, and the record's development copy reports the same figure. A missing line of arithmetic in a step that holds is a documentation debt. **Withdrawn as a gap; kept as a debt.**
- **"$\mathrm{im}\,X=\mathrm{im}\,Y$ rests on an unproved symmetrisation."** The reverse inclusion has a second route through the dimension count (§5), so even a failure of the symmetry argument would leave the conclusion standing. **Withdrawn.**

### 9b. One documentation defect, live

**The anchor at [results.md:451](../results.md#L451) is dead.** The sentence reassigning the clause writes `[Lemma L31](../findings/fence-posts.md#post-f31-the-sharp-target-is-not-freely-described-and-n-cannot-be-smuggled-in-as-a-trace)`, while the heading is `Lemma L31, the bracket cap, characterised`, whose anchor is `#lemma-l31--the-bracket-cap-characterised`. **It sits on exactly the sentence the reassignment is made in**, the same pattern [REVIEW_r544](../reviews/REVIEW_r544.md) reported for the two in-file links, and the same pattern [INDEX-results.md](../findings/INDEX-results.md) records as *"Two dead anchors sat on exactly the sentences that closure is reached through"* in the past tense. This third one is live.

## 10. What would falsify it, and what I did to look

**It is a biconditional, so there are two falsifiers.**

**Forward falsifier**: a unit pair $X,Y\in\mathfrak{so}(n)$ with $\lVert[X,Y]\rVert^2=2$ but failing any one of, $\operatorname{rank}X=4$ with all $s_i=1/\sqrt2$, the same for $Y$, $\mathrm{im}\,X=\mathrm{im}\,Y$, $XY=-YX$. **No such object can exist**, and the reason is that §2 and §3 leave no freedom: $\lVert[X,Y]\rVert^2\le(s_1+s_2)^2\le2$ collapses the singular-value profile to a point, and the chain then collapses the geometry. Any candidate must have some $s_i>0$ with $i\ge3$, or $s_1\ne s_2$, and either makes $(s_1+s_2)^2<2$ strictly. I looked at the natural place, the rank-$6$ profiles the correction paragraph itself names, $s^2=(1/2,3/10,1/5)$ and $(3/5,3/10,1/10)$, and both give $(s_1+s_2)^2\le2(s_1^2+s_2^2)=8/5$ and $9/5$ respectively, under $2$ in each case.

**Converse falsifier**: an anticommuting pair, both rank $4$ with all singular values $1/\sqrt2$ and equal images, whose bracket has $\lVert[X,Y]\rVert^2\ne2$. §6 is an identity under those hypotheses, so none exists.

**The sharpest near-miss I could build, and it is not a falsifier.** $X=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$ and $Y'=\tfrac1{\sqrt2}(\varphi_{12}-\varphi_{34})$ in $\mathfrak{so}(4)$ are orthonormal, both of rank $4$ with all singular values $1/\sqrt2$, and $\mathrm{im}\,X=\mathrm{im}\,Y'=\mathbb R^4$ (**three of the four conditions**) yet $[\varphi_{12},\varphi_{34}]=0$ makes $[X,Y']=0$, so $\lVert[X,Y']\rVert^2=0$. They commute rather than anticommute, $XY'=Y'X=\tfrac12(P_{34}-P_{12})\ne0$. **This confirms the conjunction is irredundant** (dropping the anticommuting clause would break the converse outright) and it is the witness [INDEX-results.md](../findings/INDEX-results.md) alludes to as *"a commuting pair meeting all but one"*.

**How I looked.** By hand, in closed form: the explicit maximiser of §2 at general $(s_1,s_2)$; the four boundary dimensions $n=2,3,4,5$ of §1b; the two rank-$6$ profiles above; and the commuting self-dual/anti-self-dual pair. **Nothing numerical was run**, and the search was structural rather than exhaustive, the root-plus-Cauchy–Schwarz collapse is what makes an exhaustive search unnecessary, since it leaves a single singular-value profile to check.

## Verdict

**PROVEN.**

Both directions close, the equality case is complete, and the biconditional is non-vacuous with an explicit witness from $n=4$ upward. The four items owed are presentational and are listed here so they can be discharged without reopening the mathematics: the norm conversion that makes the two-step chain tight (§4); the parity qualifier on the short-root family (§1a); the $n\ge6$ note on the correction's counterexample (§7); and the dead anchor at [results.md:451](../results.md#L451) (§9b). The clause [results.md:451](../results.md#L451) reassigned to L31 is delivered (§8), and one stale hedge in the consumer at [stratum-two-negative.md:35](../findings/stratum-two-negative.md#L35) is now vacuous and should be retired (§8a).
