# Review r578, Lemma L79, the $\mathcal A$ eigenvalue theorem

Reviewer r578, cold brief, analysis only. Report opened before any mathematics; verdicts appended as reached. The block audited is [isotropy-cap.md:208–221](../findings/isotropy-cap.md), read with the two sections above it (the $\Lambda^4$/Ricci pairing that produces $\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2=2W$) and the [Lemma L131](../findings/isotropy-cap.md) block below it, which is where the block's proof actually lives.

## Verdict

**CONFIRMED, the four eigenvalues are exact at every $m\ge3$, in the record's normalisation**, by two routes sharing no step with the block's (a direct computation of three summands plus a trace, and the Casimir identity $\mathcal A=\tfrac12\mathrm{Cas}-2(m-2)$). **Six defects around them, none touching the numbers**: one load-bearing (the pairing is unnamed and the constants are pairing-dependent), two new degeneracy findings ($m=8$ inside the table, $m=4$ half-stated), one uncorrected sign defect in the same file that a previous reviewer already flagged, one missing argument, one notational.

| # | defect | verdict |
|---|---|---|
| D1 | the block names no pairing, and all four constants halve under the other one | **CONFIRMED**, repair supplied, unapplied |
| D2 | at $m=8$ the table's own eigenvalues collide: $S^2_0$ and $\Lambda^4$ both carry $-4$ | **CONFIRMED**, new |
| D3 | the $m=4$ degeneracies are half-stated, and the $SO(4)$ hazard is understated | **CONFIRMED**, new |
| D4 | "$\mathrm{Weyl}_n$ is $\mathcal A$'s $-2$ eigenspace" contradicts the table, 100 lines below it | **CONFIRMED**, still live after [r464](REVIEW_r464.md) |
| D5 | the constants are attributed, not argued, anywhere in the block | **CONFIRMED**, derivation supplied |
| D6 | the Weitzenböck line mixes an operator with an argument, in three files | **CONFIRMED**, cosmetic |

## What the block leans on that is undefined in it

- **$\varphi_g$ and $W_{gh}$.** The basis is never named in the block. [conventions.md](../findings/conventions.md) fixes it, $\varphi_{ab}=E_{ab}-E_{ba}$, orthonormal under $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, and this is exactly the datum the constants depend on (D1).
- **That $\mathcal A$ maps $S^2(\Lambda^2)$ to itself.** "Eigenvalue on a summand of $\mathrm{Sym}^2(\Lambda^2)$" does not typecheck until one knows $\mathcal A(W)$ is again symmetric. It is: with $W$ symmetric, $\mathcal A(W)=\tfrac12\sum W_{gh}(\mathrm{ad}_g\mathrm{ad}_h+\mathrm{ad}_h\mathrm{ad}_g)$ and each $\mathrm{ad}_g$ is skew-adjoint. Unstated.
- **The decomposition itself**, which four summands, and how $S^2_0$ and $\Lambda^4$ sit inside $S^2(\Lambda^2)$. The $S^2_0$ embedding is $S\mapsto\rho(S)$, $\rho(S)(x\wedge y)=\tfrac12(Sx\wedge y+x\wedge Sy)$; the eigenvalue is independent of how that map is normalised, so nothing breaks, but the block never says which map it means.
- **Multiplicity-freeness.** Schur gives a scalar on an irreducible summand only when that summand occurs once. $S^2(\Lambda^2)$ is multiplicity-free under $O(m)$, which is what makes the step work, and is precisely what fails under $SO(4)$ (D3).
- **$\mathrm{Weyl}_m$ against $\mathcal W_n$.** The block writes $\mathrm{Weyl}_m$ for [conventions.md](../findings/conventions.md)'s $\mathcal W_n$; the dimension it quotes is the same polynomial.

## (1) The decomposition closes, as a polynomial identity, not at samples

With $N=\binom m2$ and the four dimensions $\tfrac{m(m+1)(m+2)(m-3)}{12}$, $\tfrac{m(m+1)}2-1$, $1$, $\binom m4$, the $\mp1$ cancel and, over the denominator $24$,

$$\big(2m^4-14m^2-12m\big)+\big(12m^2+12m\big)+\big(m^4-6m^3+11m^2-6m\big)=3m^4-6m^3+9m^2-6m,$$

so the sum is $\tfrac{m(m-1)(m^2-m+2)}8=\tfrac{N(N+1)}2=\dim S^2(\Lambda^2\mathbb R^m)$ identically in $m$. **CONFIRMED as an identity.** No summand is missing, so no omitted summand can carry an eigenvalue the table omits.

*Where it stops being a decomposition*: the Weyl dimension is negative at $m=2$, so the identity is formal there and the statement needs $m\ge3$.

## (2) The trace, derived from the definition and cheaper than the block's route

Write $A_g=\mathrm{ad}(\varphi_g)$ and $c_{ghk}=\langle[\varphi_g,\varphi_h],\varphi_k\rangle$, totally antisymmetric ([conventions.md](../findings/conventions.md)). The kernel of $\mathcal A$ on $V\otimes V$ is $T^{gh}_{pq}=(A_gA_h)_{pq}$, and the trace over the symmetric part is $\tfrac12\sum_{p,q}\big(T^{pq}_{pq}+T^{pq}_{qp}\big)$. The first sum vanishes term by term, since $(A_p)_{pr}=c_{prp}=0$; the second is $\sum_{p,q,r}c_{prq}c_{qpr}=\sum c_{prq}^2$ by cyclic invariance. Hence

$$\operatorname{tr}\mathcal A=\tfrac12\lVert c\rVert^2 .$$

Each triangle $\{i,j\},\{j,k\},\{i,k\}$ contributes six ordered triples with $c^2=1$, so $\lVert c\rVert^2=6\binom m3=m(m-1)(m-2)$ and

$$\boxed{\operatorname{tr}\mathcal A=\binom m2(m-2)}$$

which is the brief's value, and matches $\sum\dim\times$eigenvalue from the table: $2A-4C=m^3-3m^2$, and adding $-(m-4)(B-1)-2(m-2)$ gives $\tfrac{m^3-3m^2+2m}2$. **The table passes its own trace test at every $m$, not at samples.**

**The record already held this.** [conventions.md](../findings/conventions.md)'s Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(m-2)$ is $\lVert c\rVert^2=2(m-2)N$, so $\operatorname{tr}\mathcal A$ is the marginal times $N/2$, the identity sat one file away from the block that needed it, which is the pattern the brief warns about.

## (2b) The trace pins the Weyl row, and a second route proves all four

Three eigenvalues fall out directly, and the fourth is then forced by the trace.

**$\mathbb R\cdot\mathrm{Id}$.** $\mathcal A(\mathrm{Id})=\sum_gA_g^2$, whose trace is $-\lVert c\rVert^2=-m(m-1)(m-2)$; divided by $\dim\Lambda^2=\binom m2$ this is $-2(m-2)$. **$-2(m-2)$ confirmed**, and it is [conventions.md](../findings/conventions.md)'s Killing marginal restated.

**$S^2_0$.** For $S=\mathrm{diag}(s_1,\dots,s_m)$, $\rho(S)$ is diagonal with entry $\tfrac{s_i+s_j}2$ on $\varphi_{ij}$. Taking $h=\varphi_{12}$, the only non-vanishing brackets are $[\varphi_{12},\varphi_{1j}]=-\varphi_{2j}$ and $[\varphi_{12},\varphi_{2j}]=\varphi_{1j}$ for $j\ge3$, so

$$\operatorname{tr}\big(\rho(S)\mathrm{ad}(h)^2\big)=-\tfrac12\Big[(m-2)(s_1+s_2)+2\textstyle\sum_{j\ge3}s_j\Big] .$$

With $S$ traceless the bracket is $(m-4)(s_1+s_2)$, against $\langle\rho(S)h,h\rangle=\tfrac{s_1+s_2}2$. **$-(m-4)$ confirmed.** The same line at $S=\mathrm{Id}$ returns $-2(m-2)$, so the two rows cross-check each other.

**$\Lambda^4$.** Take $R=\varphi_{12}\odot\varphi_{34}-\varphi_{13}\odot\varphi_{24}+\varphi_{14}\odot\varphi_{23}$ and $h=\varphi_{12}+\varphi_{34}$, so $Rh=h$ and $\langle Rh,h\rangle=2$. Computing $\mathrm{ad}(h)^2\varphi_{24}=2\varphi_{13}-2\varphi_{24}$ and $\mathrm{ad}(h)^2\varphi_{23}=-2\varphi_{23}-2\varphi_{14}$ gives $\operatorname{tr}(R\,\mathrm{ad}(h)^2)=2[0-2-2]=-8$. **$-4$ confirmed**, using only four indices, so it holds already at $m=4$.

**$\mathrm{Weyl}_m$.** The trace now forces it: $\lambda_{\mathcal W}\dim\mathcal W=\binom m2(m-2)+(m-4)\big(\tfrac{m(m+1)}2-1\big)+2(m-2)+4\binom m4=2\dim\mathcal W$, so **$+2$** whenever $\dim\mathcal W>0$, i.e. $m\ge4$.

The quadratic form each of these consumes is one identity: $\mathrm{ad}$ is skew-adjoint and $A_gh=-\mathrm{ad}(h)\varphi_g$, whence

$$\langle\mathcal A(R)h,h\rangle=\operatorname{tr}\big(R\,\mathrm{ad}(h)^2\big).$$

**A second, independent route to all four.** The same identity applied to $\sum_gA_gRA_g$ gives the *same* quadratic form, and both operators are symmetric, so

$$\mathcal A(R)=\sum_g A_g\,R\,A_g .$$

Expanding the derivation action $\rho(x)R=[\mathrm{ad}(x),R]$ and using $\sum_gA_g^2=-2(m-2)$,

$$\mathrm{Cas}(R)=-\sum_g\big[A_g,[A_g,R]\big]=4(m-2)R+2\,\mathcal A(R),\qquad\text{i.e.}\qquad \boxed{\mathcal A=\tfrac12\mathrm{Cas}-2(m-2)\,\mathrm{Id}} .$$

With $\mathrm{Cas}=\langle\lambda,\lambda+2\rho\rangle$ normalised by the adjoint value $2(m-2)$, the highest weights $2\varepsilon_1+2\varepsilon_2$, $2\varepsilon_1$, $0$, $\varepsilon_1+\varepsilon_2+\varepsilon_3+\varepsilon_4$ give $\mathrm{Cas}=4m-4,\ 2m,\ 0,\ 4m-16$ and hence $\mathcal A=+2,\ -(m-4),\ -2(m-2),\ -4$. **All four rows confirmed a second time, by a route sharing no step with the first.** This also validates "the Casimir on $\Lambda^4$" as [L131](../findings/isotropy-cap.md)(i)'s route past the gap [ATTEMPTS.md](../ATTEMPTS.md) identifies (Böhm–Wilking's Lemma 2.1 reaches only the Bianchi summands, and $\Lambda^4\cap S^2_B=0$), and it is [r518](REVIEW_r518.md)'s $T=2(n-2)-\tfrac12\mathrm{Cas}$ with the sign the table demands.

*Screen (seconds, on objects built for the purpose, evidence for nothing):* assembling $\mathcal A$ on $S^2(\Lambda^2)$ at $m=3,\dots,8$ reproduces $\mathcal A(R)=\sum_gA_gRA_g$ to $4\times10^{-15}$, the trace $\binom m2(m-2)$, and the spectra with multiplicities $(+2,-(m-4),-2(m-2),-4)$, including both degeneracies below.

## D1, the constants are pairing-dependent and the block names no pairing

**CONFIRMED, and it is the one load-bearing defect.** $\mathcal A$ scales as $1/s$ under $\langle\cdot,\cdot\rangle\mapsto s\langle\cdot,\cdot\rangle$: the trace derivation above returns $\operatorname{tr}\mathcal A=\binom m2(m-2)\kappa^2$ for $\varphi_g=\kappa(E_{ij}-E_{ji})$, so under plain Frobenius ($\kappa=1/\sqrt2$) every entry of the table halves, $+1$, $-\tfrac{m-4}2$, $-(m-2)$, $-2$. The table is true in exactly one normalisation, and the block states none.

[conventions.md](../findings/conventions.md) fixes it, $\lVert\varphi_{ab}\rVert^2=1$ under $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, "the one every result uses", and the trace identity above independently pins the table to that choice, so **there is no error, only an unstated hypothesis**. [r471](REVIEW_r471.md) reached the same conclusion and recommended naming the pairing at this line; the recommendation was not applied. Under [conventions.md](../findings/conventions.md)'s own rule that a file needing a convention cites it, the repair is one clause:

> The map $\mathcal A(W)=\sum_{g,h}W_{gh}\,\mathrm{ad}(\varphi_g)\mathrm{ad}(\varphi_h)$, in the pairing of [conventions.md](conventions.md) under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal, is linear and $O(m)$-equivariant …

## D2, the $m=8$ residue is inside the table, and it is not the one the block records

**CONFIRMED, new.** The block's parenthesis handles one $m=8$ hazard: $SO(8)$-equivariance would license two scalars on $\Lambda^4_\pm$, and $O(8)$-equivariance gives one. That correction is right, the Hodge star reverses with orientation, so a reflection swaps $\Lambda^4_\pm$ and $\Lambda^4\mathbb R^8$ is $O(8)$-irreducible. **A second $m=8$ coincidence sits in the eigenvalues themselves and is unrecorded**: $-(m-4)=-4$ exactly at $m=8$, so $S^2_0$ and $\Lambda^4$ share an eigenvalue and $\mathcal A$'s $-4$ eigenspace has dimension $35+70=105$ rather than $\binom 84=70$. The screen returns multiplicity $105$ at $m=8$, as predicted.

Solving the six coincidences: the four values are pairwise distinct at every $m\ge5$ **except $m=8$**, and at $m=4$ two of them collide (D3). So the table separates the summands at $m=5,6,7$ and at $m\ge9$, and at no other dimension, which matters because $m=8$ is one of the programme's test dimensions and because a table of eigenvalues invites the backward reading.

*Impact traced: nil today.* Every citation site I graded uses the forward direction (summand $\Rightarrow$ eigenvalue): [stratum-two-negative.md:138](../findings/stratum-two-negative.md), [results.md:442](../results.md), [bounds.md:237](../findings/bounds.md), [bounds-relaxations.md:110](../findings/bounds-relaxations.md), [target.md:327](../findings/target.md), [target.md:687](../findings/target.md), [fence-posts.md:402](../findings/fence-posts.md) all consume $\mathcal A(W)=2W$ on $\mathcal W_n$; [r470](REVIEW_r470.md) and [r414](REVIEW_r414.md) consume the $\Lambda^4$ and $\mathrm{Ric}_0$ rows forward. The one backward-reading sentence on the record is [L131](../findings/isotropy-cap.md)(ii), and it is about $+2$, which collides with nothing at any $m\ge3$. **The residue is a gap in the statement, not damage downstream.**

## D3, the $m=4$ degeneracies are half-stated, and the $SO(4)$ hazard is understated

**CONFIRMED, new.** At $m=4$ the table degenerates twice, and the block records neither:

- $-2(m-2)=-4$ **coincides with the $\Lambda^4$ value**, so the $-4$ eigenspace is $\mathbb R\cdot\mathrm{Id}\oplus\Lambda^4\mathbb R^4$, two dimensional (screen: multiplicity $2$).
- $-(m-4)=0$, so **$\mathcal A$ has a nine-dimensional kernel at $m=4$**. Any downstream use of the form "$\mathcal A$ is invertible" or "$\mathcal A$ determines the summand" is false there. I found no such use, but the block says nothing either way.

**And the recorded $SO$-versus-$O$ hazard is weaker than the truth at $m=4$.** The block says $SO(m)$ "licenses … two scalars on $\mathrm{Weyl}$ at $m=4$". It licenses more: $\mathbb R\cdot\mathrm{Id}$ and $\Lambda^4\mathbb R^4$ are **isomorphic** as $SO(4)$-representations (both trivial) so $S^2(\Lambda^2\mathbb R^4)$ is not multiplicity-free under $SO(4)$ and Schur permits an equivariant map to **mix** them, not merely to scale them separately. $O(4)$ separates them by the determinant character, which is what makes "scalar on each summand" true. So the hedging list is incomplete in the way the brief anticipates: the count of things $SO$ licenses at $m=4$ is two scalars on $\mathrm{Weyl}_4$ **and** a two-dimensional commutant on the trivial isotypic.

*The equivariance claim itself is correct.* Conjugation by any $A\in O(m)$ is a Lie-algebra automorphism with $\mathrm{ad}(AXA^{-1})=\mathrm{Ad}_A\,\mathrm{ad}(X)\,\mathrm{Ad}_A^{-1}$, and $\sum_{g,h}W_{gh}(\cdot)$ is basis-free, so $\mathcal A$ is $O(m)$-equivariant with reflections included. **CONFIRMED**, and the correction as applied to the block is complete: the surviving $SO$ readings elsewhere ([ATTEMPTS.md:3901](../ATTEMPTS.md), [r412](REVIEW_r412.md)) are records of the defect rather than uses of it, and the $m=8$ instance of the standing rule in [L71](../findings/bounds.md) (the $\mathrm{Aut}$-versus-$SO(8)$-conjugacy question for the balanced involution), is repaired in both its copies, [bounds.md:468](../findings/bounds.md) and [results.md:568](../results.md).

## D4, a sign defect in the same file, still live after a previous reviewer flagged it

**CONFIRMED.** [isotropy-cap.md:314](../findings/isotropy-cap.md), inside [L131](../findings/isotropy-cap.md)(ii), reads *"$\mathrm{Weyl}_n$ is $\mathcal A$'s $-2$ eigenspace" IS $W\#I=-W$*. By the table 100 lines above, and by both of my derivations, $\mathcal A=+2$ on $\mathrm{Weyl}_m$; the $-2$ belongs to $T=2(\,\cdot\,\#I)=-\mathcal A$. The sentence is right about the content and wrong about the letter. [r464](REVIEW_r464.md) recorded exactly this and the repair was not applied, a file that contradicts its own table is the cheapest kind of defect for a reader to trip over.

*The same slip in one more place*: [ATTEMPTS.md:3901](../ATTEMPTS.md) writes "L79's table $(2n-4,n-4,-2,4)$", which is $-1$ times L79's table listed in a different summand order, it is $T$'s table, unlabelled as such.

*The characterisation itself is sound once the sign is fixed*: $+2$ collides with $-(m-4)$ only at $m=2$ and with $-2(m-2)$ only at $m=1$, so "$\mathcal W_m$ is $\mathcal A$'s $+2$ eigenspace" holds at every $m\ge3$.

## D5, the argument for the constants is not in the block

**CONFIRMED.** The block supplies equivariance and Schur, then says *"the four constants are exact (Reviewers 60 and 61)"*. That is an attribution, not an argument, and [L131](../findings/isotropy-cap.md)(i)'s route, Böhm–Wilking's Lemma 2.1 plus the Casimir on $\Lambda^4$, lives in a different block and is stated as a consequence rather than written out. The trace identity of §2 and the Casimir identity of §2b are each a self-contained repair; the second is four lines and proves all four rows at once, with no citation and no measurement.

## D6, the Weitzenböck line mixes an operator with an argument

**CONFIRMED, cosmetic.** *"Bianchi alone already gives $\mathcal A(R)=2R-(\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric})$"* has a free $\omega$ on one side only. It reads correctly as the operator $\omega\mapsto2R\omega-(\mathrm{Ric}\,\omega+\omega\,\mathrm{Ric})$, i.e. $\mathcal A(R)=2R-\mathrm{Ric}^*(\mathrm{Ric}\,R)$ with $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$ as [L131](../findings/isotropy-cap.md) and [r412](REVIEW_r412.md) fix it. Three copies carry the loose form: [isotropy-cap.md:219](../findings/isotropy-cap.md), [results.md:444](../results.md), [stratum-two-negative.md:146](../findings/stratum-two-negative.md).

## (5) What Bianchi does and what Ricci-flatness does, both halves derived

**Both CONFIRMED, and the block's account is exact rather than approximate.**

*Bianchi does the structural work.* On $S^2_B$ the operator $R\mapsto2R-\mathrm{Ric}^*(\mathrm{Ric}\,R)$ has eigenvalue $2$ on $\mathcal W$ (where $\mathrm{Ric}=0$), $2-2(m-1)=-2(m-2)$ on $\mathrm{Id}$ (where $\mathrm{Ric}=(m-1)\mathrm{Id}$), and $2-(m-2)=-(m-4)$ on $\rho(S_0)$ (where $\mathrm{Ric}(\rho(S))=\tfrac{m-2}2S$ and $\mathrm{Ric}^*$ acts on $2$-forms as $\omega\mapsto h\omega+\omega h$). Three summands, three matches: **membership in $S^2_B$ alone gives the classical form**, with Ricci-flatness used nowhere.

*Ricci-flatness alone fails, and by exactly the stated mechanism.* $\mathrm{Ric}$ annihilates $\Lambda^4$ (the contraction $\sum_iR_{ijil}$ of a totally antisymmetric tensor vanishes) and is injective on $\mathbb R\oplus S^2_0$, so $\ker\mathrm{Ric}=\mathcal W\oplus\Lambda^4$, on which $\mathcal A$ carries **two** eigenvalues, $+2$ and $-4$. So "$\mathcal A(R)=2R$ for Ricci-flat $R$" is false, and the sharp statement is $\mathcal A(R)=2R-6\,\mathrm{Alt}(R)$ there, $\mathrm{Alt}$ being the projection onto $\Lambda^4$ ([conventions.md](../findings/conventions.md)). That is [L131](../findings/isotropy-cap.md)'s general form $\mathcal A(R)=2R-\mathrm{Ric}^*(\mathrm{Ric}\,R)-6\,\mathrm{Alt}(R)$, which my four eigenvalues reproduce row by row, so the table and the general-$R$ identity are one statement, and the record holds them in two files that do not connect them.

**The hedging list is complete on this point** (the first of the session's hedging lists to survive, on my reading), *provided* it is read as "Bianchi suffices for the Weitzenböck form", which is what the three-summand check establishes. [bounds.md:237](../findings/bounds.md) states the downstream consequence correctly: $\mathcal A(W)=2W$ consumes Bianchi **and** Ricci-flatness, and Ricci-flatness alone does not give it.

## (3) The quantifier

**$m\ge3$, with two rows empty at $m=3$ and the block silent about all of it.**

| $m$ | status |
|---|---|
| $2$ | $\mathfrak{so}(2)$ is abelian, $\mathcal A=0$; the Weyl dimension formula returns $-2$, so the decomposition is formal only |
| $3$ | $\mathrm{Weyl}_3=0$ and $\Lambda^4\mathbb R^3=0$; the surviving rows are $+1$ on $S^2_0$ and $-2$ on $\mathbb R\cdot\mathrm{Id}$, both confirmed by the derivations above, which never assume $m\ge4$ |
| $4$ | all four rows nonempty; two collisions and a nine-dimensional kernel (D3) |
| $5,6,7$ | four distinct eigenvalues; the table separates the summands |
| $8$ | $S^2_0$ and $\Lambda^4$ share $-4$ (D2) |
| $\ge9$ | four distinct eigenvalues |

## (4)–(6) Citations, and what the record already knew

**Thirty-nine mentions, graded by statement rather than by identifier** (searching $\mathcal A(W)=2W$, $\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2=2W$, $\#I$, $2(n-2)$ and $-4$ on $\Lambda^4$). Every use is the forward direction on $\mathcal W_n$ or on one named summand, hence inside the hypotheses at every $m$; none reads an eigenvalue backwards to a summand, so **neither degeneracy damages a downstream result today**. The one citation defect found is the sign slip of D4, in [isotropy-cap.md:314](../findings/isotropy-cap.md) and [ATTEMPTS.md:3901](../ATTEMPTS.md).

**Three facts settling this lemma sat inside the record already**, in the pattern the brief names:

1. [conventions.md](../findings/conventions.md)'s Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(m-2)$ **is** the $\mathbb R\cdot\mathrm{Id}$ row, and $\tfrac N2$ times it is $\operatorname{tr}\mathcal A$.
2. [bounds-relaxations.md:110](../findings/bounds-relaxations.md) carries the Casimir values $4(n-1)$ on $\mathcal W_n$, $2n$ on $\mathrm{Sym}^2_0$ and $0$ on the scalar, which are exactly $2(\mathcal A+2(n-2))$ on those three summands, so that file and this table are the same operator read twice.
3. [r518](REVIEW_r518.md)'s $T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$ is $-\mathcal A$, i.e. the identity of §2b, derived in a review of a different lemma in the same file.

## Repairs recommended, none applied

1. Name the pairing in the block's first sentence, quoting [conventions.md](../findings/conventions.md) (D1), the only repair the constants' truth depends on.
2. Add one sentence after the table: *the four values are pairwise distinct at every $m\ge5$ except $m=8$, where $S^2_0$ and $\Lambda^4$ share $-4$; at $m=4$, $\mathbb R\cdot\mathrm{Id}$ and $\Lambda^4$ share $-4$ and $\mathcal A$ vanishes on $S^2_0$* (D2, D3).
3. Extend the $SO$-versus-$O$ parenthesis at $m=4$ to say that $\mathbb R\cdot\mathrm{Id}$ and $\Lambda^4\mathbb R^4$ are isomorphic $SO(4)$-representations, so $SO(4)$-Schur permits mixing rather than a second scalar (D3).
4. Fix "$-2$" to "$+2$" at [isotropy-cap.md:314](../findings/isotropy-cap.md), and label [ATTEMPTS.md:3901](../ATTEMPTS.md)'s table as $T$'s (D4).
5. Put §2b's four-line Casimir derivation in the block, replacing the attribution (D5).
6. Give the Weitzenböck line its operator form in all three files (D6).

## Method note

Analysis only throughout, per the standing rule. The one machine run was a screen (seconds, on an $\mathcal A$ built from scratch for the purpose at $m=3,\dots,8$), used to check claims already derived by hand, and it is evidence for nothing above.
