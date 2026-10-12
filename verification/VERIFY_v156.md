# Verifier v156, Lemma L24, the Hessian identity $6\theta(L_e-\tfrac12\mathrm{Id})$, the bound $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$, its sharpness, its scope at $\theta\le0$, and the Krasnov–Tkachev import

I read [BRIEF_L24.md](BRIEF_L24.md) cold, worked from the definitions in [conventions.md](../findings/conventions.md), and re-derived every step of the block at [second-order.md](../findings/second-order.md) lines 50–73 by hand. **No numerical work of any kind was done: no script, no Sage, no Python, no floating-point evaluation.** Every value below is exact ($\sqrt3/2$, $\sqrt{3/2}$, $\tfrac12$, $1$) and every witness is exhibited in closed form from the record's own conventions and structure. Where I quote a decimal it is a quotation of the record, marked as such, and it is never load-bearing. Krasnov–Tkachev Proposition 6.6 and its equation (56) were read at source in [references/krasnov-tkachev-2018-idempotent-variety/](https://arxiv.org/abs/1801.00617), not from the notes and not from memory. Log: [agent_logs/verify-L24-v156.log](../agent_logs/verify-L24-v156.log).

## The claim table

| # | Claim attacked | Verdict | Reason |
| --- | --- | --- | --- |
| 1 | $\nabla P=3Q(W)$ and the ambient second differential is $6\theta L_e$ | **CONFIRMED** | total symmetry of $T$ re-derived for both the $W^2$ and $\#$ halves |
| 2 | The multiplier contributes $-3\theta\,\mathrm{Id}$, leaving $6\theta(L_e-\tfrac12\mathrm{Id})$ | **CONFIRMED** | independent great-circle expansion returns $-3\theta+6\theta\langle L_eH,H\rangle$ exactly |
| 3 | "The Hessian of $P$ restricted to the unit sphere" = the Riemannian Hessian | **CONFIRMED AS ALGEBRA** | the two readings differ by exactly $-3\theta\,\mathrm{Id}$; the argument's own multiplier step picks the Riemannian one, as do lines 11 and 39 of the same file |
| 4 | $\lambda_{\max}\le\tfrac12$ needs $\theta>0$ in the direction claimed | **CONFIRMED** | $\theta>0$ enters once, at the division by $6\theta$, and the sense is the stated one |
| 5 | $L_e$ is self-adjoint ($\mathcal W_n$ is a Euclidean metrised algebra) | **CONFIRMED** | $\tfrac14(\operatorname{tr}XYZ+\operatorname{tr}YXZ)$ is fully symmetric; the $\#$ half by [r285](../reviews/REVIEW_r285.md) Claim 1's index form, re-checked |
| 6 | $W^\perp$ is $L_e$-invariant, so the restriction is an operator | **CONFIRMED** | $L_ee=e$ by criticality plus self-adjointness |
| 7 | $1$ is a simple eigenvalue of $L_e$ at a maximiser | **CONFIRMED** | immediate from the bound and $L_ee=e$ |
| 8 | No $\circ$-orthogonal splitting into critical pieces, and criticality cannot be dropped | **CONFIRMED** | $e\circ A_j=\tfrac{a_j}\theta Q(A_j)$ closes, and criticality of $W$ forces the constant to be $\theta/a_j$ |
| 9 | Sharpness: orbit directions are exact $\tfrac12$-eigenvectors by equivariance (**first repair**) | **CONFIRMED** | differentiating $Q(gW)=gQ(W)$ gives $2L_W\delta_vW=\theta\,\delta_vW$; and $\delta_vW\perp W$ |
| 10 | The orbit is never a point | **CONFIRMED** | $\mathcal W_n$ carries no $O(n)$-invariant vector at every $n\ge4$, $n=4$ included |
| 11 | "[Lemma L32](../findings/isotropy-cap.md)'s stabilizers shrink that multiplicity without reaching zero" | **REFUTED AS STATED** | L32 is about a bivector's double centraliser, not a Weyl tensor's isotropy; and L32 is itself carried as REFUTED AS STATED. Sharpness survives without it |
| 12 | The inequality does **not** reverse at negative $\theta$ (**second repair**) | **CONFIRMED** | $Q$ even, $P$ odd $\Rightarrow$ $-W$ critical with $-\theta$, $e(-W)=e(W)$, $(-W)^\perp=W^\perp$; the number is literally the same |
| 13 | At $n=4$, $S^2\times S^2$ is a saddle with $\lambda_{\max}(L_e\vert_{W^\perp})=1$ | **CONFIRMED** | closed form: $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ is $\circ$-orthogonal, $\theta=2\cdot2^{-3/2}\sqrt{3/2}=\sqrt3/2$, and $L_e$ has a $1$-eigenvector $W^+-W^-$ in $W^\perp$ |
| 14 | "$\theta>0$ … at a maximiser it is **automatic**" | **REFUTED AS STATED** | the argument given ($P$ odd, $\max_SP\ge\sqrt{3/2}$) proves it at a **global** maximiser only; at a local maximiser the block's own supplement reaches $\theta\ge0$ and **$\theta=0$ is never treated** |
| 15 | The chordal-curve argument ruling out a local maximiser with $\theta<0$ | **CONFIRMED AS ALGEBRA, HYPOTHESIS-DEBT** | the arithmetic closes ($-\tfrac92\cdot\tfrac\theta2+\tfrac{15}8\theta=-\tfrac38\theta$), but it invokes [Lemma L51](../findings/second-order.md) inside the branch $\theta<0$ while L51's own statement hypothesises $\theta>0$ |
| 16 | K-T Prop 6.6's hypotheses hold of $(\mathcal W_n,\circ,\langle\cdot,\cdot\rangle)$, **including that no unit is required** | **CONFIRMED at source** | Definition at kt-1801.00617.txt:969–974 asks only for (48) and positive definiteness; the proof of 6.6 uses only $c^2=c$, self-adjointness and $D^2f(c)\le0$ |
| 17 | The paper's $2L_c-1\le c\otimes c$ is a misprint for the projector form | **CONFIRMED** | substituting $x=c$ into (56) by hand gives $\tfrac13D^2f(c)=\big[2L_c-\mathrm{Id}-(c\otimes c)/\lVert c\rVert^2\big]/\lVert c\rVert$ |
| 18 | "The statement is Proposition 6.6" | **REFUTED AS STATED** | K-T Definition 6.4 fixes *extremal* as a **global** maximum point; the record's own [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) says "local maximum", which the source does not |
| 19 | [second-order.md](../findings/second-order.md) line 28: "at $\mathfrak u(2)\subset\mathfrak{so}(4)$, $\theta=-0.866$ and the inequality reverses (Reviewer 27)" | **REFUTED, AND LIVE** | this is verbatim the claim L24's own block, thirteen lines below, declares "refuted three ways"; it stands unamended in the file's introductory paragraph |
| 20 | [bounds-relaxations.md](../findings/bounds-relaxations.md) line 286: "$\lambda_{\max}(L_e\vert_{\mathcal D})=1$ there … $\lambda_{\max}(M)=\theta$ exactly, at every global maximiser" | **REFUTED AS STATED** | it restates, unqualified, the very step the [Lemma L115](../findings/bounds-relaxations.md) block eighteen lines above marks as L24 applied outside its own space |
| 21 | [results.md](../results.md) line 242: "$\tfrac12$ attained by orbit directions at every critical point" | **REFUTED AS STATED** | needs $\theta\ne0$, since $e=W/\theta$; the canonical block says "nonzero critical point", which is not the same restriction |
| 22 | $\ker W\ne0$ breaks something | **no finding** | nothing in the derivation touches $\ker W$; the $n=4$ global maximiser $W_{\mathbb{CP}^2}$ itself has a $3$-dimensional kernel |

## One-line summary

**The mathematics of L24 is correct and both Gate 2 repairs hold, but the file's own introductory paragraph still carries, verbatim and unamended, the $\mathfrak u(2)$/$\theta=-0.866$ claim that the canonical block thirteen lines below declares refuted three ways, and the Scope paragraph's "$\theta>0$ is automatic at a maximiser" is established for a global maximiser only, with the $\theta=0$ branch untreated.**

## 0. Conventions, fixed once

Quoted, not restated, from [conventions.md](../findings/conventions.md):

- $Q(W)$, "Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself".
- $P(W)$, "the cubic form $\langle W,Q(W)\rangle$".
- $\theta$, "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- "**The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it."
- "**\"Critical point\" is $Q(W)=\theta W$**, the first-order condition on $\{\lVert W\rVert=1\}$."
- "$\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$".
- "**The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.** The inner product is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level".
- "**Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**".
- "**Padding commutes with $Q$**, and preserves both the norm and $\theta$."
- $M(n)$, "**the global maximum** of $P$ on the unit sphere of $\mathcal W_n$ … $M(n)>0$ at every $n\ge4$, padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$ … $M=\sqrt{3/2}$ against $\Theta_4=0.866$".
- $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$, "$10$ at $n=4$".
- $\Pi$, sense (i), "the orthogonal projection onto $W^\perp$, at whichever unit $W$ is in play".
- $B$, "$B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point, so $A(\tfrac12)=\ker B$".
- $\Phi$, sense (iii), "$\Phi(M)=M^{\circ2}+M^2$, the criticality map **on the diagonal locus**, whose derivative is [L24]'s operator restricted there".

## 1. The hypothesis inventory

**A pass with no inventory is not a pass**, so here is the full list, each hypothesis against the object it is applied to and against whether the written proof uses it.

### 1.1 Hypotheses the statement carries

| hypothesis | stated where | used where | status |
| --- | --- | --- | --- |
| $W$ is a critical point, $Q(W)=\theta W$ | statement, explicit | twice, in the multiplier step ($\nabla P\parallel W$) and in $L_ee=e$, which is what makes $W^\perp$ invariant | **used, and needed twice** |
| $\lVert W\rVert=1$ | **never written**; forced by "$\theta=P(W)$" against the convention $\theta=P(W)/\lVert W\rVert^3$, and by "the unit sphere" | used throughout, the multiplier $\mu=3\theta/2$ and the $-3\theta\,\mathrm{Id}$ both assume it | **implicit but forced.** [Lemma L125](../findings/second-order.md) states it explicitly ("of unit norm"); L24 does not. No defect, since the convention closes it |
| $\theta=P(W)>0$ | statement, explicit | once, dividing $\mathrm{Hess}\le0$ by $6\theta$; and implicitly to define $e=W/\theta$ | **used.** See §5 for what "automatic" does and does not cover |
| $W$ is a **maximizer** (not merely critical) | statement, explicit, and only for the second half | only for $\mathrm{Hess}\le0$ | **used, and it is exactly the hypothesis whose loss is the record's recurring citation error** |
| **local** versus **global** maximiser | never distinguished | the proof uses only local maximality | **statement under-claims its own proof.** See §8 |
| restriction to $W^\perp$ | statement, explicit | the tangent space of the sphere at $W$ *is* $W^\perp$; and $e^\perp=W^\perp$ since $e\parallel W$ | **used** |
| $n\ge4$ | nowhere | only through $\mathcal W_n\ne0$ and, for the sharpness clause, the absence of an $O(n)$-invariant vector | **no finding.** $\mathcal W_3=0$, so $n\ge4$ is not a restriction but the domain |

**No hypothesis is stated and unused.** Every one of the four written hypotheses is consumed. The one hypothesis the proof needs and the statement does not print is $\lVert W\rVert=1$, and the record's own convention for $\theta$ supplies it.

### 1.2 Hypotheses of every theorem the proof imports

| import | its hypotheses | checked against the object | verdict |
| --- | --- | --- | --- |
| **[Lemma L51](../findings/second-order.md)**, variation calculus along a critical orbit | "$W$ a unit critical point of $P$ on the sphere with $Q(W)=\theta W$, **$\theta>0$**"; a compact group acting orthogonally leaving $P$ invariant | the Scope paragraph applies it inside the branch **$\theta<0$** | **hypothesis violated as stated.** §6 |
| **[Lemma L32](../findings/isotropy-cap.md)**, a bivector's centraliser collapses to a line | $x\in\mathfrak{so}(m)$ nonzero, and (per the block's own correction) $\mathfrak c=\mathfrak z(x)\cap x^\perp\ne0$ | the object in L24's sentence is the isotropy of a **Weyl tensor** under $O(n)$, not a bivector | **the import names no applicable object.** §4.2 |
| **[Lemma L125](../findings/second-order.md)**, L24 off $W^\perp$ | maximiser $W$ of unit norm with $\theta>0$ | cited only for the sentence "the restriction is a genuine operator rather than a compression" | **satisfied**, and the citation is decorative, the invariance is proved in place, one clause earlier |
| **[r285](../reviews/REVIEW_r285.md) Claim 1**, $\#$ is fully trilinearly symmetric | none beyond total antisymmetry of $c_{abc}$; explicitly "on all of $\mathrm{Sym}^2(\Lambda^2)$, no Bianchi, no trace-freeness, no criticality" | $\mathcal W_n\subset\mathrm{Sym}^2(\Lambda^2)$ | **satisfied, with room to spare** |
| **Krasnov–Tkachev Prop 6.6** | $A$ a **Euclidean metrised algebra**, associativity of the form, $\langle xy;z\rangle=\langle x;yz\rangle$ (48), plus positive definiteness. **Finite-dimensional, over $\mathbb R$. No unit.** $c$ an **extremal** idempotent, Definition 6.4, a global maximum point | $(\mathcal W_n,\circ,\langle\cdot,\cdot\rangle)$: commutative by construction ($\circ$ is a polarisation), metrised by §3, Euclidean since the $\Lambda^2$ pairing is positive definite, closed under $\circ$ because $Q$ preserves $\mathcal W_n$ | **hypotheses satisfied, and unitality is genuinely not among them.** But "extremal" is *global*: §8 |

### 1.3 The unital question, answered by name

The brief asks this by name because a route here already died on it. **K-T Proposition 6.6 does not need a unit.** The definition at kt-1801.00617.txt:969–974 is exactly two conditions,

> "they obey a non-trivial bilinear form $\langle x;y\rangle$ which associates with multiplication, i.e. $\langle xy;z\rangle=\langle x;yz\rangle$ for all $x,y,z\in A$, (48) … We say that $A$ is a Euclidean metrised algebra if the bilinear form $\langle x;y\rangle$ is positive definite."

and the proof of 6.6 consumes only $c^2=c$, the self-adjointness of $L_c$ that (48) supplies, and $D^2f(c)\le0$. No unit appears in Definition 6.4, Proposition 6.3, or the proof of 6.6. $\mathcal W_n$ has no unit, a unit $u$ would give $L_u=\mathrm{Id}$, hence $\operatorname{tr}L_u=\dim\mathcal W_n>0$ against the record's $\operatorname{tr}L_x\equiv0$, and would also force the orbit directions of any critical point to be simultaneously $1$- and $\tfrac12$-eigenvectors. **[fence-posts.md](../findings/fence-posts.md) line 189 already places L24 on the correct side of that line and is right to.** What *does* need the unit is Tkachev's minimal-algebra characterisation, and the record correctly bars that route.

### 1.4 The object is an algebra of the right kind, checked, not assumed

$\circ$ maps $\mathcal W_n\times\mathcal W_n\to\mathcal W_n$ because all three terms of $\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ lie in $\mathcal W_n$ by the convention that $Q$ preserves it. Commutativity is immediate from that formula. Metrisation is §3 below. So the algebra hypothesis is not inherited from the literature; it is verified against this object.

## 2. The Hessian identity, re-derived without the multiplier

The statement asserts $\mathrm{Hess}\,(P|_S)_W=6\theta(L_e-\tfrac12\mathrm{Id})$. The block's argument goes through a Lagrange multiplier. I did it a second way, along great circles, because a multiplier computation is where a factor hides.

Let $\lVert W\rVert=1$, $H\perp W$, $\lVert H\rVert=1$, and take the geodesic $\gamma(t)=\cos t\,W+\sin t\,H$, which stays on the unit sphere. With $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ fully symmetric and $P(X)=T(X,X,X)$,

$$P(\gamma(t))=\cos^3t\;P(W)+3\cos^2t\sin t\;T(W,W,H)+3\cos t\sin^2t\;T(W,H,H)+\sin^3t\;P(H).$$

Criticality kills the second term outright: $T(W,W,H)=\langle Q(W),H\rangle=\theta\langle W,H\rangle=0$. Differentiating twice at $t=0$, using $\tfrac{d^2}{dt^2}\cos^3t\big|_0=-3$, $\tfrac{d^2}{dt^2}\big[3\cos t\sin^2t\big]\big|_0=6$ and $\tfrac{d^2}{dt^2}\sin^3t\big|_0=0$,

$$\frac{d^2}{dt^2}P(\gamma)\Big|_{t=0}=-3\theta+6\,\langle W\circ H,H\rangle=-3\theta+6\theta\,\langle L_eH,H\rangle=6\theta\Big(\langle L_eH,H\rangle-\tfrac12\Big).$$

Since great circles are the geodesics of the round sphere, this second derivative **is** the Riemannian Hessian's quadratic form. **The identity is exactly as printed, the $-3\theta$ comes from the curve's own curvature rather than from any convention, and no multiplier is needed to obtain it.** The block's route, $\mu$ from $3Q(W)=\mu\cdot2W$, so $\mu=3\theta/2$ and $D^2\mathcal L=6\theta L_e-2\mu\,\mathrm{Id}=6\theta L_e-3\theta\,\mathrm{Id}$, returns the same operator. Both the factor $6\theta$ and the $-3\theta\,\mathrm{Id}$ are confirmed.

**Riemannian or ambient?** The brief asks. They differ, and by exactly the disputed term: the ambient Hessian restricted to $W^\perp$ is $6\theta L_e|_{W^\perp}$, while the Riemannian one is $6\theta(L_e-\tfrac12\mathrm{Id})|_{W^\perp}$. The statement's phrase alone does not settle it; **the argument does** ("the constraint $\lVert W\rVert^2=1$ contributes $-3\theta\,\mathrm{Id}$ through its multiplier"), and so does the same file at line 11 ("verified through the geodesic second derivative") and at line 39 ("this being the Riemannian Hessian"). No finding, but the statement would be one word better for saying "Riemannian".

**A typing imprecision, recorded and not escalated.** As printed, "The Hessian … is $6\theta(L_e-\tfrac12\mathrm{Id})$" gives an operator on all of $\mathcal W_n$, while the Hessian lives only on $W^\perp$; read literally at $Y=W$ it returns $3\theta\ne0$ for an object that has no radial direction. [Lemma L125](../findings/second-order.md)'s own blockquote, "**THE EQUALITY AT $Y=W$ CERTIFIES NOTHING.** It is the radial direction of a degree-zero homogeneous function, identically zero at *any* point", already fences this, so it is a wording matter, not a defect.

**Then the bound.** $W$ a maximiser gives $\tfrac{d^2}{dt^2}P(\gamma)|_0\le0$, hence $6\theta(\langle L_eH,H\rangle-\tfrac12)\le0$ for every unit $H\in W^\perp$. **At $\theta>0$ this divides to $\langle L_eH,H\rangle\le\tfrac12$, in the stated direction**; at $\theta<0$ the division reverses it. So the brief's question (whether $\theta>0$ is needed in the direction claimed), is answered yes, and the block's "enters at exactly one place" is exact.

## 3. Self-adjointness, and $W^\perp$-invariance

The bound is a statement about $\lambda_{\max}$, which needs a real spectrum, which needs self-adjointness, which is the metrised property. The block gives it in two halves and both close.

**The $W^2$ half.** $\circ$'s operator part is $X\circ_1Y=\tfrac12(XY+YX)$, and with the record's $\Lambda^2$-level pairing $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^{\mathsf T}B)=\tfrac12\operatorname{tr}(AB)$ on symmetric operators,

$$\langle X\circ_1Y,Z\rangle=\tfrac14\big(\operatorname{tr}(XYZ)+\operatorname{tr}(YXZ)\big).$$

The two terms are the two cyclic classes of $\operatorname{tr}(XYZ)$, so their sum is invariant under every permutation of $X,Y,Z$: under $X\leftrightarrow Z$, $\operatorname{tr}(ZYX)=\operatorname{tr}(YXZ)$ and $\operatorname{tr}(YZX)=\operatorname{tr}(XYZ)$, and the sum is unchanged. **Fully symmetric**, and the block's phrase "the symmetrisation of $\operatorname{tr}(XYZ)$" is exact.

**The $\#$ half.** The block's reason is "permuting the arguments permutes the slots of both totally antisymmetric $c$'s, sign $(-1)^2$", attributed to [r285](../reviews/REVIEW_r285.md) Claim 1. Read at source, that claim gives the index form
$$\langle X\#Y,Z\rangle=\tfrac12\sum c_{pqa}\,c_{rsb}\,X_{pr}\,Y_{qs}\,Z_{ab},$$
in which the two structure constants' first indices are contracted through $X$, second through $Y$, third through $Z$. A transposition of the three slots in both $c$'s permutes $(X,Y,Z)$ and multiplies by $(-1)^2=+1$. **Confirmed, and r285 flags the load-bearing half correctly**: it is the slot-1-to-slot-3 transposition, not the free $X\leftrightarrow Y$ one, that the gradient step needs.

**A subtlety the block glides over and which does not bite.** $X\circ_1Y$ and $X\#Y$ need not individually lie in $\mathcal W_n$ even when $X,Y$ do; only their sum is guaranteed to. This is harmless: each half is a fully symmetric trilinear form on the *ambient* $\mathrm{Sym}^2(\Lambda^2)$, and symmetry of a trilinear form is inherited by restriction to any subspace. r285's "on all of $\mathrm{Sym}^2(\Lambda^2)$, no Bianchi, no trace-freeness" is exactly the width needed. No finding.

**$W^\perp$-invariance.** $L_ee=e\circ e=Q(e)=Q(W)/\theta^2=\theta W/\theta^2=e$, so $\mathbb Re$ is invariant; $L_e$ self-adjoint then carries the orthogonal complement, since $\langle L_eX,e\rangle=\langle X,L_ee\rangle=\langle X,e\rangle=0$. **Confirmed**, and $e^\perp=W^\perp$ because $e\parallel W$.

**$1$ is simple.** With $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12<1$ and $L_ee=e$, the $1$-eigenspace is exactly $\mathbb Re$. **Confirmed**, and note that this half is the one that needs maximality, since the $\le\tfrac12$ does.

**The $\circ$-orthogonal-splitting clause.** With $W=\sum_ia_iA_i$ and the $A_i$ mutually $\circ$-orthogonal, $e\circ A_j=\tfrac1\theta\sum_ia_iA_i\circ A_j=\tfrac{a_j}\theta A_j\circ A_j=\tfrac{a_j}\theta Q(A_j)$, exactly as printed. This equals $A_j$ only if $Q(A_j)\propto A_j$ (the block's necessary condition) and criticality of $W$ then pins the constant: $\theta\sum_ia_iA_i=Q(W)=\sum_ia_i^2Q(A_i)$ forces $Q(A_i)=(\theta/a_i)A_i$ whenever $a_i\ne0$. So with two nonzero critical pieces, $\operatorname{span}(A_1,A_2)$ lies in the $1$-eigenspace of $L_e$, which meets $W^\perp$ in a line, giving $\lambda_{\max}(L_e|_{W^\perp})=1>\tfrac12$. **Confirmed, including the block's insistence that criticality of the pieces cannot be dropped.** I did not audit the comparative claim "strictly weaker than [Lemma L66](../findings/support-dichotomy.md)"; the record's own [LEDGER.md](../findings/LEDGER.md) warns that "an ordering between two results is among the least reliable things a block asserts", and that ordering is outside this brief.

## 4. Sharpness, the first repair, checked

The block's repaired sharpness reads: "the orbit directions are exact $\tfrac12$-eigenvectors by equivariance, attained at every nonzero critical point because $\mathcal W_n$ carries no $O(n)$-invariant vector, so the orbit is never a point and [Lemma L32]'s stabilizers shrink that multiplicity without reaching zero."

### 4.1 The equivariance step establishes sharpness, CONFIRMED

$Q$ is $O(n)$-equivariant: the action on $\Lambda^2$ is by conjugation, $W^2$ conjugates, and $\#$ is built from the $\mathrm{Ad}$-invariant bracket. Let $g_t=\exp(t\,\mathrm{ad}\,v)$ act, and write $\delta_vW=\tfrac{d}{dt}\big|_0(g_t\cdot W)$. Differentiating $Q(g_t\cdot W)=g_t\cdot Q(W)$ at $t=0$, with $DQ(W)[H]=2\,W\circ H$ from the polarisation,

$$2\,W\circ(\delta_vW)=\delta_v\big(Q(W)\big)=\theta\,\delta_vW\quad\Longrightarrow\quad L_e(\delta_vW)=\tfrac12\,\delta_vW.$$

And $\delta_vW\in W^\perp$ because $\langle \delta_vW,W\rangle=\tfrac12\tfrac{d}{dt}\big|_0\lVert g_t\cdot W\rVert^2=0$, the action being orthogonal. **So every orbit direction is an exact $\tfrac12$-eigenvector lying in $W^\perp$, and $\lambda_{\max}(L_e|_{W^\perp})\ge\tfrac12$ at every critical point with $\theta\ne0$.** Together with the bound at a maximiser this gives equality. **Sharpness is established, and the replacement for the withdrawn "$\langle e,L_ee\rangle=1$" does the work the withdrawn line failed to do**, the withdrawn line was about the direction $W$ itself and said nothing about $W^\perp$, which is the emptiness the block correctly names.

**"The orbit is never a point", CONFIRMED.** The orbit degenerates to a point exactly when $\delta_vW=0$ for all $v$, i.e. when $W$ is $SO(n)$-fixed, i.e. when $W$ is an invariant vector. $\mathcal W_n$ carries none at any $n\ge4$: it is a nontrivial irreducible $O(n)$-module for $n\ge5$, and at $n=4$ it splits as $\mathcal W^+\oplus\mathcal W^-$ with both summands nontrivial ($\mathrm{Sym}^2_0(\Lambda^\pm)$). Since $\lVert W\rVert=1\ne0$, the tangent is nonzero. **The smallest admissible dimension is covered.**

### 4.2 The Lemma L32 citation, REFUTED AS STATED

**Step 1, locate it.** [second-order.md](../findings/second-order.md) line 64: "so the orbit is never a point and **[Lemma L32](isotropy-cap.md)'s stabilizers shrink that multiplicity without reaching zero**."

**Step 2, exhibit the failure.** L32's statement is "Let $x\in\mathfrak{so}(m)$ be nonzero and $\mathfrak c=\mathfrak z(x)\cap x^\perp$. Then $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$, except when $x$ is a multiple of a complex structure on a $4$-dimensional subspace." It quantifies over **bivectors** and computes a **double centraliser**. The object L24's sentence needs is $\mathfrak{stab}(W)=\{v\in\mathfrak{so}(n):\delta_vW=0\}$, the isotropy of a **Weyl tensor**, whose codimension is the orbit dimension and hence the multiplicity floor at $\tfrac12$. Concretely at $W_{\mathbb{CP}^2}$, $n=4$: the isotropy is $\mathfrak u(2)\subset\mathfrak{so}(4)$, of dimension $4$ in a $6$-dimensional algebra, so the orbit has dimension $2$ and the $\tfrac12$-multiplicity is at least $2$. L32 makes no statement about any of those numbers. And L32 is itself carried on the record as **"REFUTED AS STATED: A HYPOTHESIS IS MISSING"** (it needs $\mathfrak c\ne0$), so the sentence cites a refuted result for a claim that result does not make.

**Step 3, argue the opposite.** The most charitable reading is that "stabilizers" gestures at the general fact that a larger isotropy gives a smaller orbit and hence a smaller $\tfrac12$-multiplicity floor, and that L32 is offered as an instance of isotropy being constrained. Even under that reading the clause carries no load: **the sentence's whole content ("the orbit is never a point", hence multiplicity $\ge1$), is delivered by the immediately preceding clause about invariant vectors, and the L32 clause could be deleted with no loss.** So this is a spurious citation rather than a broken step.

**Impact: none on sharpness.** Recorded so that the next reader does not go looking in [isotropy-cap.md](../findings/isotropy-cap.md) for a multiplicity statement that is not there, and does not propagate a refuted lemma's number.

## 5. Scope at $\theta\le0$, the second repair holds; "automatic" does not

### 5.1 The $\pm\theta$ refutation, CONFIRMED, derived independently

The block's refutation of the old "the inequality reverses at negative $\theta$" is: "$Q$ is even and $P$ odd, so $e(-W)=e(W)$ and $(-W)^\perp=W^\perp$: $\lambda_{\max}(L_e|_{W^\perp})$ is *the same number* at $\pm\theta$, and no witness of any kind can separate the sign." **I derived this from scratch and it holds.**

$Q$ is quadratic, so $Q(-W)=Q(W)$. Hence $P(-W)=\langle-W,Q(W)\rangle=-P(W)$: $P$ is odd. If $W$ is critical of unit norm with $Q(W)=\theta W$, then

$$Q(-W)=Q(W)=\theta W=(-\theta)\,(-W),$$

so $-W$ is critical of unit norm with $\theta'=-\theta$, and

$$e(-W)=\frac{-W}{\theta'}=\frac{-W}{-\theta}=\frac W\theta=e(W),\qquad (-W)^\perp=W^\perp.$$

**The operator $L_e$ and the subspace $W^\perp$ are literally identical at $W$ and at $-W$**, so $\lambda_{\max}(L_e|_{W^\perp})$ is one real number attached to the antipodal pair, and no object can exhibit a value at $\theta<0$ that differs from its value at $\theta>0$. The refutation is correct as written.

**Consistency check, which the block does not print and which I ran because a sign symmetry this strong invites a hidden contradiction.** If $W$ is a local maximiser with $\theta>0$ then $-W$ is a local minimiser with $\theta'=-\theta<0$; the second-order condition there is $\mathrm{Hess}\ge0$, i.e. $6\theta'(L_e-\tfrac12)\ge0$, and dividing by the *negative* $6\theta'$ gives $L_e-\tfrac12\le0$ on $W^\perp$, the **same** inequality. The two readings agree, as the symmetry requires. Likewise the parenthetical claim that a local maximiser with $\theta<0$ would satisfy $\lambda_{\min}\ge\tfrac12$ is right: $\mathrm{Hess}\le0$ divided by a negative $6\theta$ gives $L_e-\tfrac12\ge0$; and the gloss "being this theory read at the local minimiser $-W$" is right too, since the antipode of such a point is a local minimiser with $\theta>0$, where $\mathrm{Hess}\ge0$ gives $\lambda_{\min}\ge\tfrac12$ directly.

### 5.2 The chordal-curve argument, the arithmetic closes

The Scope paragraph's supplement: "Along the chordal curve through an orbit direction the second- and third-order coefficients vanish unconditionally by [Lemma L51], leaving $-\tfrac38\theta\lVert z\rVert^4$ as the leading term; a local maximum needs it $\le0$, hence $\theta\ge0$."

The second-order coefficient vanishes because the orbit direction is an exact $\tfrac12$-eigenvector (§4.1), so $6\theta(\langle L_ez,z\rangle-\tfrac12)=0$. The third-order coefficient is $T(z,z,z)$, zero along the orbit because $P$ is constant there. The quartic coefficient is L51's own: "the **chordal** quartic coefficient is $-\tfrac92\langle L_Wz,z\rangle+\tfrac{15}8\theta$", which on the null cone of $B=\tfrac\theta2-L_W$, where $\langle L_Wz,z\rangle=\tfrac\theta2$ at $\lVert z\rVert=1$, evaluates to

$$-\tfrac92\cdot\tfrac\theta2+\tfrac{15}8\theta=-\tfrac{18}8\theta+\tfrac{15}8\theta=-\tfrac38\theta. \checkmark$$

L51's cross-check also closes: its great-circle coefficient $\tfrac78\theta-\tfrac52\langle L_Wz,z\rangle$ gives $\tfrac78\theta-\tfrac54\theta=-\tfrac38\theta$ on the same cone, and the difference between the two expressions is $-2\langle L_Wz,z\rangle+\theta=2\langle Bz,z\rangle$, exactly as L51 states. **A local maximum needs $-\tfrac38\theta\le0$, hence $\theta\ge0$.** The arithmetic is right and the conclusion drawn from it is right.

### 5.3 "$\theta>0$ … at a maximiser it is **automatic**", REFUTED AS STATED

**Step 1, locate it.** Scope paragraph, [second-order.md](../findings/second-order.md) line 68: "$\theta>0$ enters at exactly one place … and at a maximiser it is **automatic**, since $P$ is odd and $\max_SP\ge\sqrt{3/2}$ at every $n\ge4$. **A *local* maximiser with $\theta<0$ does not exist, so that branch is empty.**"

**Step 2, exhibit the failure.** The argument offered ($P$ odd, so $\max_SP>0$, and in fact $\ge\sqrt{3/2}$ by padded $W_{\mathbb{CP}^2}$), bounds $P$ **at the global maximiser only**. It says nothing whatever about a local maximiser, whose value of $P$ is unconstrained by $\max_SP$. The block evidently knows this, since it then adds the chordal argument for local maximisers; but that argument's conclusion is $\theta\ge0$, not $\theta>0$, and **the failure is concrete at the parameter value $\theta=0$: the leading term $-\tfrac38\theta\lVert z\rVert^4$ is identically zero there, so the curve yields no contradiction and the case is untreated.** The record does not exclude it elsewhere either: the same file records that "$\mathrm{Weyl}_n^{\mathbb C}$ contains nonzero **2-nilpotents**", and a real 2-nilpotent ($Q(W)=0$ at $\lVert W\rVert=1$) is precisely a critical point with $\theta=0$. No line on the record rules one out over $\mathbb R$, and at such a point $e=W/\theta$ does not exist, so L24 says nothing at all.

**Step 3, argue the opposite.** The most charitable reading is that "maximiser" throughout the Scope paragraph means the *global* maximiser of Conjecture A, for which $\theta\ge\sqrt{3/2}>0$ is genuinely automatic and the whole issue evaporates; the local-maximiser sentence is then an aside covering the one adjacent case someone had raised. That reading rescues the paragraph, **but it is inconsistent with how the record uses L24**, which is at local maxima and in the contrapositive (§8), and it is inconsistent with the block's own decision to spend an argument on local maximisers at all. There is also a second, sharper tension: [LEDGER.md](../findings/LEDGER.md) line 377 records the verdict "**$\theta>0$ is redundant at a maximiser** … the hypothesis is surplus, not missing", on exactly the $P$-is-odd argument. If $\theta>0$ were surplus, the chordal argument would be unnecessary; the record holds both positions.

**Verdict.** The clause is true of a global maximiser and unestablished for a local one, where only $\theta\ge0$ is proved. **No damage to the lemma**, whose statement carries $\theta>0$ as an explicit hypothesis. The correct scope sentence names the global case for "automatic", the local case for "$\theta\ge0$", and $\theta=0$ as open.

### 5.4 What would close it, `HYPOTHESIS-DEBT`, named exactly

**To be proved:** *$\mathcal W_n$ contains no real $W$ with $\lVert W\rVert=1$ and $Q(W)=0$ that is a local maximiser of $P$ on the unit sphere*, or, more simply, *no real 2-nilpotent in $\mathcal W_n$ at $n\ge4$*. I do not supply this argument; naming it is the whole of my output here.

## 6. The L51 import at $\theta<0$, `HYPOTHESIS-DEBT`

**Step 1, locate it.** The Scope paragraph applies [Lemma L51](../findings/second-order.md) inside the branch it is trying to empty, namely $\theta<0$. L51's own **Statement** reads: "let $W$ be a unit critical point of $P$ on the sphere with $Q(W)=\theta W$, **$\theta>0$**".

**Step 2, exhibit the failure.** The object is a hypothetical local maximiser with $\theta<0$. At that object L51's stated hypothesis is false by construction of the branch. This is the brief's named trap (an imported theorem whose hypotheses were never checked against the object) and it is exact rather than rhetorical: the conclusion "$\theta\ge0$" is *derived from* a lemma that assumes $\theta>0$, which read literally is circular.

**Step 3, argue the opposite.** The clauses actually consumed are (i) the orbit direction is an exact $\tfrac12$-eigenvector, and (ii) the chordal quartic coefficient is $-\tfrac92\langle L_Wz,z\rangle+\tfrac{15}8\theta$, evaluated on the null cone. Neither derivation uses the sign of $\theta$: (i) is the differentiated equivariance of §4.1, which needs only $\theta\ne0$ to divide into $L_e$; (ii) is an exact jet of a cubic. L51's own positivity-dependent remark ("$B|_{W^\perp}\succeq0$ licenses only the word *supremum*"), is not among the clauses used. **So the mathematics survives; what is missing is a line saying so.** The record itself notes the shape of this in its own commentary on L51 ("None of this uses maximality"), but the *sign* hypothesis is a separate matter and is nowhere discharged.

**Verdict: the step is sound and the citation is not licensed as written.** The debt is one sentence, either restate L51 at $\theta\ne0$, or say in the Scope paragraph that the clauses invoked are sign-free. I do not write either; naming them is the finding.

## 7. The edges of every range

| edge | what the statement says there | verdict |
| --- | --- | --- |
| **smallest admissible $n$** | $n=4$, $\dim\mathcal W_4=10$. Everything closes: metrised, no invariant vector, orbit nonzero | **no finding.** $n=3$ is not an edge, since $\mathcal W_3=0$ |
| **$n=4$, where $\mathcal W_4$ splits** | see §7.1, the block's own $\lambda_{\max}=1$ saddle claim, confirmed in closed form | **CONFIRMED**, and it is the best witness on the record that the bound fails at a mere critical point |
| **odd $n$** | nothing in the derivation distinguishes parity; $\Theta_n$'s odd/even split never enters | **no finding** |
| **$\theta=0$** | $e=W/\theta$ undefined; hypothesis fails; the chordal supplement is silent | **finding, §5.3** |
| **$\theta<0$** | covered, and the inequality does not reverse | **CONFIRMED, §5.1** |
| **$\ker W\ne0$** | see §7.2 | **no finding** |
| **local vs global maximiser** | see §8 | **finding** |

### 7.1 $n=4$: $S^2\times S^2$, in closed form

The block asserts: "the point is a **saddle**: $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ is a $\circ$-orthogonal sum, so $\lambda_{\max}(L_e|_{W^\perp})=1$ there." I checked every link.

**The sum is $\circ$-orthogonal.** For $X\in\mathcal W^+$, $Y\in\mathcal W^-$: $X$ acts on $\Lambda^+$ and vanishes on $\Lambda^-$, and conversely, so $XY=YX=0$ and the operator half of $X\circ Y$ vanishes. For the $\#$ half, $(X\#Y)_{ab}=\tfrac12c_{apq}c_{brs}X_{pr}Y_{qs}$ needs $p,r\in\Lambda^+$ and $q,s\in\Lambda^-$, hence a structure constant $c_{apq}$ with one index in each factor of $\mathfrak{so}(4)=\mathfrak{su}(2)^+\oplus\mathfrak{su}(2)^-$, and $[\Lambda^+,\Lambda^-]=0$, so every such $c$ vanishes. **$\mathcal W^+\circ\mathcal W^-=0$.**

**The value $\sqrt3/2$ is forced, and it is $S^2\times S^2$'s.** $S^2\times S^2$ is Kähler for both orientations, so both $W^\pm$ are nonzero and each is of $\mathbb{CP}^2$ type in its own $5$-dimensional factor; by symmetry $\lVert W^\pm\rVert^2=\tfrac12$. Writing $W^\pm=2^{-1/2}\hat W^\pm$ with $\hat W^\pm$ unit and $Q(\hat W^\pm)=\sqrt{3/2}\,\hat W^\pm$ (the value [conventions.md](../findings/conventions.md) records as $M(4)=\sqrt{3/2}=\theta(W_{\mathbb{CP}^2})$),

$$P(W)=P(W^+)+P(W^-)=2\cdot2^{-3/2}\sqrt{3/2}=\frac{\sqrt{3/2}}{\sqrt2}=\frac{\sqrt3}2,$$

and $Q(W^\pm)=\tfrac12Q(\hat W^\pm)=2^{-1/2}\sqrt{3/2}\,W^\pm$, so $Q(W)=\theta W$ with the *same* $\theta=\sqrt3/2$ on both pieces, $W$ is critical. **This reproduces the record's $\Theta_4=0.866$ exactly and in closed form**, and it confirms the block's second refutation point: $0.866=\sqrt3/2$ belongs to $S^2\times S^2$, while $\mathfrak u(2)$ is $W_{\mathbb{CP}^2}$'s isotropy at $\pm\sqrt{3/2}=\pm1.2247$. The two are different numbers attached to different points.

**And $\lambda_{\max}=1$ exactly.** $L_e$ preserves each factor, and on $\mathcal W^+$ it acts as $L_{\hat e^+}$: for $Y\in\mathcal W^+$, $e\circ Y=W^+\circ Y/\theta=\big(2^{-1/2}\sqrt{3/2}/\theta\big)L_{\hat e^+}Y=L_{\hat e^+}Y$, the constant being $1$ precisely because $\theta=2^{-1/2}\sqrt{3/2}$. Since $\hat W^+$ is the maximiser of the $5$-dimensional algebra $\mathcal W^+$, L24 applied *inside that factor* gives spectrum $\{1\}\cup[\,\cdot,\tfrac12]$; the same on $\mathcal W^-$. So $\operatorname{spec}L_e$ has $1$ with multiplicity $2$, spanned by $W^+$ and $W^-$, whose intersection with $W^\perp$ is the line through $W^+-W^-$. **$\lambda_{\max}(L_e|_{W^\perp})=1$, exactly, and the point is a saddle.** The block is right in every part.

This is also the closed-form answer to the brief's item 4: **a citation of L24's bound at a mere critical point is refuted by an object the record already owns.**

### 7.2 $\ker W\ne0$, asked by name, and it does not bite

**What the statement says at a padded object.** Padding commutes with $Q$ and preserves $\theta$ (convention), so a padded critical point is critical with the same $\theta$, and $e$, $L_e$, $W^\perp$ are all defined. Nothing in §2, §3 or §4 mentions $\ker W$, refers to $W^{-1}$, or divides by an eigenvalue of $W$; the only division anywhere is by $\theta$, which the hypothesis makes nonzero. **The lemma is therefore insensitive to $\ker W$, and this is checkable rather than hoped for: the $n=4$ global maximiser $W_{\mathbb{CP}^2}$ has $\ker W\supseteq\Lambda^-$, of dimension $3$ in a $6$-dimensional $\Lambda^2$, and the lemma holds there with $\lambda_{\max}=\tfrac12$ attained on the orbit.** So the record's recurring obstruction is met head-on by the very object that certifies $M(4)$.

**Where padding *does* matter, and it is a citation matter.** L24's bound needs local maximality. The record holds padded $W_{\mathbb{CP}^2}$ to be a local maximum by measurement, and [Lemma L51](../findings/second-order.md)'s own note says that measurement "stop[s] at $n=10$" and that "[Lemma L28](../findings/nondegeneracy.md) is stated at $m\ge3$ in **native** dimension, and padding manufactures excess elsewhere". **So invoking L24's cap at padded $W_{\mathbb{CP}^2}$ for $n\ge11$ rests on an unproved local maximality.** That is a hypothesis on the *consumer*, not a defect in L24, and I record it rather than repair it.

### 7.3 One object from each structured family the record names

| family | object | what L24 says there | consistent? |
| --- | --- | --- | --- |
| $\mathcal W_4$ split | $S^2\times S^2$ | $\lambda_{\max}=1$, not a maximiser | **yes**, §7.1 |
| $\mathbb{CP}^m$ | $W_{\mathbb{CP}^2}$ at $n=4$ | maximiser, $\lambda_{\max}=\tfrac12$ on the orbit, $\ker W\ne0$ | **yes** |
| $\mathbb{CP}^m$ | $\mathbb{CP}^3$ at $n=6$ (record: $\lambda_{\max}=\tfrac58$), $\mathbb{CP}^4$ at $n=8$ ($0.6$) | both exceed $\tfrac12$ ⟹ neither is a local maximum | **yes**, and both are critical points where the bound fails, again refuting any critical-point reading |
| sphere products | $S^3\times S^3$ at $n=6$ | $\lambda_{\max}=\tfrac12$ exactly, yet the record calls it "a degenerate saddle, not a local maximum" | **yes**, and it shows the bound is **necessary and not sufficient**, so no converse may be read out of it |
| sphere products | $S^{n/2}\times S^{n/2}$, even $n\ge8$ | $\lambda_{\max}=\tfrac12$ attained exactly on the orbit; local max by L24's *identity* plus [L27](../findings/nondegeneracy.md) | **yes**, and this is the one legitimate use of the identity half |
| padded | padded $W_{\mathbb{CP}^2}$ | $\ker W\ne0$ and large; statement holds; local maximality unproved above $n=10$ | **yes**, §7.2 |
| diagonal | coordinate-diagonal $W$, $e\in\mathcal D_n$ | L24 restricted to $W^\perp\cap\mathcal D_n$, a necessary condition on a subspace, hence weaker and safe | **yes**; [diagonal-half.md](../findings/diagonal-half.md) line 153 flags the $N\perp W$ trap itself |
| subalgebra-Casimir | bi-invariant $\mathfrak{su}(3)$; the $C_5$ blow-up | record: $\lambda_{\max}/\theta=1.206$ at the blow-up ⟹ not a local max | **yes** |

**Random objects would have seen none of the first four rows**, which is the brief's point; each is a structured critical point where the bound's conclusion is false and the hypothesis is absent.

## 8. The gap between what is proven and what is used

### 8.1 The statement says "maximizer"; the proof proves the local version; consumers use the local version

The written argument is $\mathrm{Hess}\le0$ at a maximiser, which is a **local** condition, the great-circle expansion of §2 sees only a neighbourhood. So the proof establishes:

> if $W$ is a **local** maximiser with $\theta>0$ then $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$.

The statement says "maximizer" without qualification, and its own prior-art paragraph attributes it to a proposition about *extremal* idempotents, which K-T define as global maximum points (§8.2). The record then splits:

- **local reading**, used in the contrapositive: [graded-half.md](../findings/graded-half.md) line 343, "Every graded critical point with $\Delta>0$ has $\lambda_{\max}>\tfrac12$, hence by [Lemma L24] is not a **local** maximum"; [nondegeneracy.md](../findings/nondegeneracy.md) line 547, "$\lambda_{\max}=\tfrac58>\tfrac12$ says it is no **local** maximiser"; [bounds.md](../findings/bounds.md) line 123 likewise.
- **global reading**, used positively: [bounds-relaxations.md](../findings/bounds-relaxations.md) line 286 ("at a **global maximiser**"; the same file's L115 block observes the discrepancy explicitly), "**The quantifier is right for the wrong reason**: L24 holds at *local* maximisers, so the block's argument would prove more than its heading".

**Verdict: the statement under-claims its own proof, and two consumers read it at two different strengths.** Nothing downstream is broken, because the proof supports the stronger (local) reading that the contrapositive consumers take. **The repair is one word ("local maximizer") and I do not write it.**

### 8.2 The prior-art attribution over-reaches by exactly the same word, and the reference notes misstate the source

**Step 1, locate it.** The block: "**Prior art, this is not new.** The statement is Proposition 6.6 of Krasnov–Tkachev … an extremal idempotent satisfies $\sigma(L_c|_{c^\perp})\subseteq(-\infty,\tfrac12]$". And [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md): "'Extremal idempotent' = the idempotent associated to a **local maximum** of $\langle x,x^2\rangle$ on the unit sphere".

**Step 2, exhibit the failure.** Read at source, Definition 6.4 says: "An idempotent $c\in V(u)$ constructed in the course of proof of Proposition 6.3 will be called extremal. **In other words, the set of extremal idempotents coincide with the set of suitably normalized global maximum points** of the (degree zero homogeneous) function $\langle x;x^2\rangle\langle x;x\rangle^{-3/2}$." Proposition 6.3's proof takes $y$ at which $u$ "attains its global maximum value" on $S$. **The paper's "extremal" is a global maximum**, and the record's notes say local. The consequence for the attribution is that Proposition 6.6 as *stated* is a global-maximiser statement, so L24 in its local form is **not** Proposition 6.6, it is what Proposition 6.6's *proof* gives, since that proof consumes only $D^2f(c)\le0$.

**Step 3, argue the opposite.** Charitably, the notes' author may have meant "the local condition is all the proof uses", which is true and is a better sentence. And the credit assignment is unaffected either way: the argument is the same argument, and the record is right to give the credit. **So this is a mis-description of the source rather than a wrong attribution**, but it is the kind of mis-description that later licenses "the literature already proves it at a local maximum", which the literature, as printed, does not.

### 8.3 A live restatement of a step the record has already ruled a GAP

**Step 1, locate it.** [bounds-relaxations.md](../findings/bounds-relaxations.md) line 286, under "#### And that settles what the route is worth": "Lemma L24 … says every eigenvalue off $W$ is at most $\tfrac12$ at a **global maximiser**, so $\lambda_{\max}(L_e|_{\mathcal D})=1$ there and $\lambda_{\max}(M)=\theta$ **exactly, at every global maximiser**."

**Step 2, exhibit the failure.** Eighteen lines above, the [Lemma L115](../findings/bounds-relaxations.md) block carries the Gate 2 verdict: "**[LEMMA L24] IS APPLIED OUTSIDE ITS OWN SPACE.** Its cap lives on $\mathcal W_n\cap W^\perp$; $\lambda_{\max}(M)$ maximises over the whole eigenframe-diagonal algebra $\mathcal D$, whose elements are generically neither trace-free nor Bianchi", and states that the repair is complete **only on the diagonal locus**, leaving "a cap on $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})$, which is nowhere on the record". Line 286 asserts the unrepaired conclusion at *every* global maximiser, with no locus restriction. The step it needs is exactly the flagged one: $\mathcal D\not\subseteq\mathcal W_n$, so L24 caps nothing on $\mathcal D\setminus\mathcal W_n$. The "$=1$" also comes from the radial direction $e\in\mathcal D$, which [Lemma L125](../findings/second-order.md)'s blockquote fences as certifying nothing.

**Step 3, argue the opposite.** The charitable reading is that this prose section predates the L115 block and was left as narrative. That is likely true and does not help a reader, who meets an unqualified claim below the block that qualifies it. **Verdict: a live unqualified restatement of a step the record has already graded GAP.** Outside L24 itself; recorded because the brief asks for the citations.

### 8.4 The landscape line's quantifier

[results.md](../results.md) line 242: "with $\tfrac12$ attained by orbit directions **at every critical point**." The canonical block says "at every **nonzero** critical point", and even that is one step short: the orbit-direction argument of §4.1 divides by $\theta$ to reach $L_e$, so the correct quantifier is **every critical point with $\theta\ne0$**. Minor, and recorded because results.md line 242 is the line a consumer reads.

## 9. The live refuted sentence, the finding of this round

**Step 1, locate it exactly.** [findings/second-order.md](../findings/second-order.md), line 28, in the opening section "Second-order optimality: a necessary condition on maximizers", which is the file's own introduction to the criterion:

> "This is the one constraint on the unknown maximizer that no earlier attack imposed; every previous inequality was first-order. **The hypothesis $\theta>0$ is load-bearing, at $\mathfrak u(2)\subset\mathfrak{so}(4)$, $\theta=-0.866$ and the inequality reverses (Reviewer 27).**"

**Step 2, exhibit the failure.** This is, word for word and witness for witness, the claim that the canonical L24 block **in the same file** declares refuted:

> "**The first version claimed the inequality reverses at $\mathfrak u(2)\subset\mathfrak{so}(4)$ with $\theta=-0.866$, and that is refuted three ways.** … *Gate 2, [r488](../reviews/REVIEW_r488.md) and [r490](../reviews/REVIEW_r490.md), independently.* **The claim originates in [Reviewer 27](../reviews/REVIEW_r27.md)** and stood on that audit alone."

Same object, same value, same attribution to Reviewer 27. All three refutations I checked independently and all three hold:

1. **No witness can separate the sign.** §5.1: $e(-W)=e(W)$ and $(-W)^\perp=W^\perp$, so $\lambda_{\max}(L_e|_{W^\perp})$ takes one value on the antipodal pair. A sentence asserting an object at which the inequality reverses asserts something no object can do.
2. **The label is wrong.** §7.1: $\pm\sqrt3/2=\pm0.866$ is $S^2\times S^2$'s value, derived here in closed form; $\mathfrak u(2)$ is $W_{\mathbb{CP}^2}$'s isotropy, at $\pm\sqrt{3/2}=\pm1.2247$.
3. **The point is a saddle.** §7.1: $\lambda_{\max}(L_e|_{W^\perp})=1$ there, so no second-order condition of either sign is in force, and the point witnesses nothing about maximisers.

**Step 3, argue the opposite.** The sentence's first clause ("the hypothesis $\theta>0$ is load-bearing"), is **true**, and the canonical block agrees with it ("$\theta>0$ enters at exactly one place, dividing by $6\theta$"). So a maximally charitable reading keeps the first clause and reads the rest as an illustration. But the rest is not an illustration; it names an object, a value and a reviewer, and asserts that at that object the concluded inequality fails in the stated direction. That assertion is false three ways over. **The charitable reading rescues seven words and not the sentence.**

**Why it matters more than its length.** It sits in the *introductory* paragraph of the file that houses L24, above the canonical block, and a reader who takes the criterion from the top of the file (which is what an introduction is for), carries away a refuted witness with a reviewer's name on it. The record's own [conventions.md](../findings/conventions.md) opens with the rule this violates: "**a convention restated in two files is a convention that will disagree with itself**"; here one file disagrees with itself thirteen lines apart. **The repair is a deletion, and I do not perform it.**

## 10. Krasnov–Tkachev, read at source

### 10.1 Proposition 6.6, and its hypotheses against $\mathcal W_n$

Verbatim from kt-1801.00617.txt:1051–1053:

> "**Proposition 6.6.** Let $A$ be a Euclidean metrised algebra. Then for any extremal idempotent $c$ there holds $\sigma(c)\subset(-\infty,\tfrac12]$. In particular, $1$ is a simple eigenvalue of $L_c$."

Its proof consumes: $c^2=c$; self-adjointness of $L_c$, which (48) gives; the invariance of $\mathbb Rc$ and hence of $c^\perp$; and $D^2f(c)\le0$. **No unit, no associativity, no genericity, no power-associativity.** The hypotheses are checked against $\mathcal W_n$ in §1.2 and §1.3 and all hold; the notation matches, since $c=e=W/\theta$ under their normalisation $c=y/k$ with $y^2=ky$, and $c^\perp=e^\perp=W^\perp$. **The import is legitimate.**

**One reading point.** "$\sigma(c)$" must mean $\sigma(L_c|_{c^\perp})$, since $L_cc=c$ puts $1$ in $\sigma(L_c)$ and $1\notin(-\infty,\tfrac12]$; the block's rendering "$\sigma(L_c|_{c^\perp})\subseteq(-\infty,\tfrac12]$" is the right one, and the paper's own concluding sentence ("$1$ is a simple eigenvalue of $L_c$") confirms it.

### 10.2 The $c\otimes c$ misprint, re-derived from (56), independently

The record's [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) claims the printed "$2L_c-1\le c\otimes c$" drops a factor $\lVert c\rVert^{-2}$. I substituted $x=c$ into the paper's own (56) by hand rather than take the note. With $c^2=c$ and $\langle c^2;c\rangle=\langle c;c\rangle=\lvert c\rvert^2$, the four terms of the numerator of (56) are

$$2\lvert c\rvert^4L_c,\qquad -\lvert c\rvert^2\cdot\lvert c\rvert^2\,\mathrm{Id},\qquad -3\lvert c\rvert^2\big(c\otimes c+c\otimes c\big),\qquad +5\lvert c\rvert^2\,c\otimes c,$$

summing to $2\lvert c\rvert^4L_c-\lvert c\rvert^4\mathrm{Id}-\lvert c\rvert^2\,c\otimes c$ over $\lvert c\rvert^5$, that is

$$\tfrac13D^2f(c)=\frac1{\lvert c\rvert}\Big[2L_c-\mathrm{Id}-\frac{c\otimes c}{\lVert c\rVert^2}\Big].$$

**Confirmed, exactly as the note states.** $D^2f(c)\le0$ therefore gives $2L_c-\mathrm{Id}\le P_c$, the orthogonal projector onto $\mathbb Rc$, which vanishes on $c^\perp$. And the printed form is genuinely false, not merely unnormalised: testing it at $y=c$ gives $\langle(2L_c-\mathrm{Id})c,c\rangle=\lvert c\rvert^2$ against $\langle c,c\rangle^2=\lvert c\rvert^4$, so it asserts $\lvert c\rvert^2\le\lvert c\rvert^4$, false whenever $\lvert c\rvert<1$. **The record's misprint diagnosis is CONFIRMED by a route independent of the two reviewers who found it, and L24 is unaffected**, since the projector form is what the conclusion on $c^\perp$ needs.

*One narrowing.* The note's "In this project $c=W/\theta$ has $\lVert c\rVert=1/\theta<1$" needs $\theta>1$, which holds at maximisers ($\theta\ge\sqrt{3/2}$) and not at every critical point. Immaterial to the argument; recorded for precision.

## 11. Symbol collisions, checked by sense

[conventions.md](../findings/conventions.md) records several letters carrying multiple senses. Per the brief, which sense each L24 step needs:

| symbol | senses on the record | sense L24 needs | status |
| --- | --- | --- | --- |
| $\Pi$ | four; (i) projection onto $W^\perp$ | not used in the L24 block; used in L51's corrector $\Pi u$, in sense (i) | **consistent** |
| $B$ | three; here $B=\tfrac\theta2\mathrm{Id}-L_W$ | only via L51, in the tabled sense | **consistent** |
| $\Phi$ | four; (iii) "$\Phi(M)=M^{\circ2}+M^2$ … whose derivative is L24's operator restricted there" | the table already names L24 in the right sense | **consistent** |
| $M$ | $M(n)$ the global max; the sectional matrix; L119's scalar; L115's diagonal-algebra $M$ | the Scope paragraph needs $M(n)$; [bounds-relaxations.md](../findings/bounds-relaxations.md) needs the fourth | **consistent, and the record already flags the fourth as untabled** |
| $L$ | $L_e$, $L_W=\theta L_e$, $L_M$, $\mathcal L$ | L24 uses $L_e$; [LEDGER.md](../findings/LEDGER.md) line 818 uses $L_M$ with the cap $\theta/2$, which is $L_W=\theta L_e$ rescaled and is consistent | **consistent** |
| $T$ | $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$ (tabled); $T=\tfrac{2\sqrt2}3A$, the cap on $t$ (tabled); the operator $T$ on $\mathrm{Sym}(\mathfrak{so}(n))$ in [isotropy-cap.md](../findings/isotropy-cap.md); **and L24's/L51's trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$** | the trilinear form | **finding: L24's sense is not in the table**, though three others are. Nothing miscarries here, the three tabled senses are scalars or an operator and could not be confused with a trilinear form in this block, but the letter is one of the record's densest and the table is short one row |
| $e$ | $e=W/\theta$; frame vectors $e_i$; bivectors $e_{12}$ | $W/\theta$ | **consistent**; the collision is visible from context |

## 12. Candidates I withdrew, with the reason

Recorded so the next verifier does not spend an adjudication on them.

**(a) "$\lVert W\rVert=1$ is an unstated hypothesis."** *Withdrawn at step 3.* The statement writes $\theta=P(W)$, and [conventions.md](../findings/conventions.md) fixes $\theta=P(W)/\lVert W\rVert^3$; the two together force $\lVert W\rVert=1$, and "the unit sphere" says it again. The convention closes it, which is what the convention is for.

**(b) "The Hessian identity is a type error, since $6\theta(L_e-\tfrac12\mathrm{Id})$ is defined on all of $\mathcal W_n$."** *Withdrawn at step 3.* The argument says "leaving $6\theta(L_e-\tfrac12\mathrm{Id})$ **on the tangent space**", and [Lemma L125](../findings/second-order.md) fences the $Y=W$ reading in bold. A wording matter with an explicit fence already on it.

**(c) "The sharpness clause needs $\theta>0$ and says only 'nonzero critical point'."** *Withdrawn as a duplicate.* It is the same observation as §8.4 and is recorded there once, against the results.md line where it actually reaches a consumer.

**(d) "Criticality is a redundant hypothesis, being implied by maximality."** *Withdrawn at step 1.* It is redundant for the *bound*, but the statement's first sentence is the Hessian identity, which is asserted at a critical point that need not be a maximiser and which two consumers ([Lemma L3](../findings/second-order.md), [route-a.md](../findings/route-a.md) line 213) use in exactly that generality. The hypothesis is load-bearing for the half it is attached to.

**(e) "L24 is used to *prove* local maximality at [Lemma L3](../findings/second-order.md), which is a converse error."** *Withdrawn at step 2.* L3's proof uses L24's **identity** half (unconditional at a critical point), together with [Lemma L27](../findings/nondegeneracy.md)'s exact eigenvalue and multiplicity, which is what upgrades a semidefinite Hessian to a Morse–Bott maximum. The block even says so in its own blockquote: "**[Lemma L24] alone does not suffice**: it is necessary *at a maximiser*, and $W^*$ is not known to be one. L27 does the work." No error.

**(f) "[bounds.md](../findings/bounds.md) line 109 applies L24 at a critical point."** *Withdrawn at step 1.* That line is the record of a caught error, not an instance of it: "This record used the conclusion as a fact about **critical points**, under which no second-order test could ever fail". It is a correct diagnosis, correctly placed.

## 13. What would break it, and what I did to look

**The falsifier.** L24 is false iff there exists a **local maximiser $W$ of $P$ on the unit sphere of $\mathcal W_n$, some $n\ge4$, with $\theta=P(W)>0$, carrying a unit $Z\perp W$ such that $\langle Z,e\circ Z\rangle>\tfrac12$.** By §2 such a $Z$ makes $\tfrac{d^2}{dt^2}P(\cos t\,W+\sin t\,Z)\big|_0=6\theta(\langle L_eZ,Z\rangle-\tfrac12)>0$, so $P$ strictly increases along a curve through $W$ inside the sphere, contradicting local maximality. **The object therefore cannot exist unless the identity of §2 is itself wrong**, which narrows the hunt to exactly three places: the total symmetry of $T$ (which delivers $\nabla P=3Q(W)$), the coefficient $6$ on the second differential, and the $-3$ from the curve's curvature.

**What I did to look for it.**

- Re-derived the second differential twice by disjoint routes, the Lagrangian multiplier the block uses, and a great-circle expansion that needs no multiplier at all, and got the same operator. A discrepancy between those two is where a factor would show.
- Checked the total symmetry of $T$ in both halves from the definitions, and read [r285](../reviews/REVIEW_r285.md) Claim 1's index form at source rather than citing it; its load-bearing transposition is the one the gradient step needs.
- Tested the statement at every structured family the record names (§7.3), taking the two $n=4$ points in **closed form**: $W_{\mathbb{CP}^2}$, where the bound holds with $\ker W$ of dimension $3$, and $S^2\times S^2$, where $\lambda_{\max}=1$ exactly and the point is a saddle. The second is the strongest available witness that only maximality (not criticality), makes the bound true, and I derived its $\theta=\sqrt3/2$ from the $\circ$-orthogonal splitting rather than quoting it.
- Pushed on every edge: $n=4$, odd $n$, $\theta=0$, $\theta<0$, $\ker W\ne0$, local versus global. **Only $\theta=0$ came back uncovered, and it is uncovered in the Scope paragraph rather than in the lemma**, whose hypothesis excludes it.
- Read Krasnov–Tkachev §6 at source and re-derived (56) at $x=c$ by hand, to check both that the import's hypotheses hold of $\mathcal W_n$ (including, by name, that no unit is required) and that the paper's printed inequality is the misprint the record says it is.

**No such object was found, and the search says why one cannot exist without breaking the identity.** The identity was checked twice by independent routes and closes both times.

## Verdict

**PROVEN, hypotheses corrected.**

The mathematics of Lemma L24 is correct. The Hessian identity, the factor $6\theta$, the $-3\theta\,\mathrm{Id}$, the direction of the division by $6\theta$, the self-adjointness, the $W^\perp$-invariance, the simplicity of $1$, the $\circ$-orthogonal-splitting clause, and **both** of the block's twice-repaired passages (the equivariance route to sharpness and the $\pm\theta$ refutation), all hold under independent derivation. The Krasnov–Tkachev import is legitimate, its unitality hypothesis does not exist, and the record's misprint diagnosis is confirmed from the paper's own equation (56).

The corrections owed are to hypotheses and to citations, not to the argument:

1. **Delete or repair [second-order.md](../findings/second-order.md) line 28.** It carries verbatim the $\mathfrak u(2)$/$\theta=-0.866$ claim that the canonical block thirteen lines below declares refuted three ways. This is the round's actionable finding.
2. **"$\theta>0$ … automatic at a maximiser" holds for a global maximiser.** For a local one the block's own supplement reaches $\theta\ge0$, and $\theta=0$ is untreated. `HYPOTHESIS-DEBT`: *no real 2-nilpotent of $\mathcal W_n$ is a local maximiser.*
3. **[Lemma L51](../findings/second-order.md) is invoked inside $\theta<0$ while its statement hypothesises $\theta>0$.** The clauses used are sign-free; no line says so. `HYPOTHESIS-DEBT`: one sentence, either in L51's statement or in the Scope paragraph.
4. **The [Lemma L32](../findings/isotropy-cap.md) citation in the sharpness sentence is a non sequitur** and points at a result itself carried as REFUTED AS STATED. Sharpness is unaffected; the clause is deletable.
5. **The statement says "maximizer" where its proof gives "local maximizer"**, and consumers already split on the two readings; the prior-art attribution over-reaches in the other direction, since K-T's "extremal" is Definition 6.4's **global** maximum and the reference notes say "local".
6. **[bounds-relaxations.md](../findings/bounds-relaxations.md) line 286 restates, unqualified, the step the [Lemma L115](../findings/bounds-relaxations.md) block eighteen lines above grades a GAP**, and [results.md](../results.md) line 242's "at every critical point" should read "$\theta\ne0$".

I have written none of these repairs.
