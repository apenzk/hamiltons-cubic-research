# Verifier v155, Lemma L24, the Hessian identity $6\theta(L_e-\tfrac12\mathrm{Id})$, the maximiser bound $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, its sharpness, the simplicity of $1$, and the scope paragraph's two repairs

I read [BRIEF_L24.md](BRIEF_L24.md) cold, worked from the definitions in [conventions.md](../findings/conventions.md), and re-derived every step of the block at [second-order.md](../findings/second-order.md) lines 50–73 rather than reading it for plausibility. **No numerical work of any kind was done**: every value below is exact (a fraction, a square root, or a closed-form eigenvalue) and the two places where the record's own measured numbers are quoted are labelled as the record's, never as evidence I supply. Krasnov–Tkachev Proposition 6.6 and its equation (56) were read at source in [kt-1801.00617.txt](https://arxiv.org/abs/1801.00617), not from memory. Log: [agent_logs/verify-L24-v155.log](../agent_logs/verify-L24-v155.log).

## The claim table

| # | claim attacked | verdict | reason |
| --- | --- | --- | --- |
| 1 | $\nabla P=3Q(W)$ and $D^2P=6\theta L_e$ | **CONFIRMED** | $P(x)=T(x,x,x)$ with $T$ fully symmetric gives both coefficients exactly |
| 2 | The Hessian of $P|_S$ is $6\theta(L_e-\tfrac12\mathrm{Id})$; the multiplier contributes $-3\theta\,\mathrm{Id}$ | **CONFIRMED** | $2\mu=3\theta$ from $\nabla P=3\theta W$; the Riemannian route gives the same $-3\theta$ from $\mathrm{II}(V,V)=-\lVert V\rVert^2W$ |
| 3 | $L_e$ is self-adjoint ($T$ fully symmetric) | **CONFIRMED** | $W^2$ part is the symmetrisation of $\operatorname{tr}(XYZ)$; $\#$ part by the slot-$1$/slot-$3$ transposition, sign $(-1)^2$, re-derived by hand |
| 4 | $W^\perp$ is $L_e$-invariant, so the restriction is an operator | **CONFIRMED** | $L_eW=W$ by criticality plus self-adjointness; proved in situ, not imported |
| 5 | $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$ at a maximiser, and $\theta>0$ is what fixes the direction | **CONFIRMED** | dividing $6\theta(L_e-\tfrac12)\preceq0$ by $6\theta$ preserves the sense exactly when $\theta>0$ |
| 6 | Sharpness: orbit directions are exact $\tfrac12$-eigenvectors, and the orbit is never a point | **CONFIRMED** | $2W\circ z=\theta z$ from differentiating $Q(gW)=gQ(W)$; $z\perp W$; $\mathcal W_n$ has no trivial $O(n)$-summand at any $n\ge4$ |
| 7 | $1$ is a simple eigenvalue of $L_e$ at a maximiser, and the $\circ$-orthogonal-splitting corollary | **CONFIRMED** | $\mathcal W_n=\mathbb Re\oplus W^\perp$, $L_ee=e$, everything on $W^\perp$ at most $\tfrac12<1$; the pieces are forced independent |
| 8 | The refutation of "the inequality reverses at negative $\theta$" | **CONFIRMED** | $Q$ even, $P$ odd $\Rightarrow$ $e(-W)=e(W)$ and $(-W)^\perp=W^\perp$, so it is one number, not two |
| 9 | "A *local* maximiser with $\theta<0$ does not exist", via the chordal curve and [Lemma L51](../findings/second-order.md) | **CONFIRMED AS ALGEBRA** | the quartic coefficient $-\tfrac38\theta\lVert z\rVert^4$ is right, but **L51 is cited outside its own stated hypothesis $\theta>0$** |
| 10 | "$\theta>0$ … at a maximiser it is **automatic**" | **REFUTED AS STATED** | the written argument ($P$ odd, $\max_SP\ge\sqrt{3/2}$) reaches the **global** maximiser only; at a local maximiser the record's own chordal argument delivers $\theta\ge0$ and nothing on file excludes $\theta=0$ |
| 11 | "This is Krasnov–Tkachev Proposition 6.6", and the notes' gloss of *extremal idempotent* | **REFUTED AS STATED** | KT's Definition 6.4 and the remark after it make an extremal idempotent a **global** maximum of minimal norm; [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) glosses it as a **local** maximum, and the record's own $S^4\times S^4$ at $n=8$ is the witness |
| 12 | The unitality trap: does KT Prop 6.6 need a unit? | **CONFIRMED** (no trap) | "Euclidean metrised algebra" is (48) plus positive-definiteness; $\mathcal W_n$ with $\circ$ satisfies both and needs no unit |
| 13 | The KT misprint call in [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) | **CONFIRMED** | substituting $x=c$, $c^2=c$ into (56) gives $\tfrac13D^2f(c)=[2L_c-\mathrm{Id}-(c\otimes c)/\lVert c\rVert^2]/\lVert c\rVert$ |
| 14 | The [Lemma L32](../findings/isotropy-cap.md) citation in the sharpness clause | **REFUTED AS STATED** | L32 is marked REFUTED AS STATED in its own block, and it bounds a **bivector's** double centraliser, not the stabiliser of a Weyl tensor; the clause is decorative and sharpness survives without it |
| 15 | "The Hessian of $P$ restricted to the unit sphere" | **CONFIRMED**, wording defective | the intended parse (Riemannian Hessian of $P|_S$) is right; the other available parse is false by exactly $3\theta\,\mathrm{Id}$ |

## The one-line summary

**L24's mathematics is right in every clause I could reach, the identity, the factor, the bound, the sharpness, the simplicity of $1$ and the $\pm\theta$ refutation all close by hand, and every finding is in the apparatus around it: a citation of [Lemma L51](../findings/second-order.md) outside L51's own $\theta>0$, a citation of the refuted [Lemma L32](../findings/isotropy-cap.md), an unclosed $\theta=0$ branch at a *local* maximiser that [LEDGER.md](../findings/LEDGER.md) records as closed, and a Krasnov–Tkachev extraction note that turns their global maximum into a local one.**

## 0. Conventions, fixed once

Quoted, not restated.

- **The $\circ$ product**, from [conventions.md](../findings/conventions.md): *"$X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it."*
- **$\theta$**: *"$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$."*
- **Criticality**: *"'Critical point' is $Q(W)=\theta W$, the first-order condition on $\{\lVert W\rVert=1\}$."*, so unit norm is carried by the word "critical point", which is the only place L24's statement gets it.
- **$Q$ and $P$**: *"$Q(W)$ Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself"*, *"$P(W)$ the cubic form $\langle W,Q(W)\rangle$"*.
- **$M(n)$**: *"the global maximum of $P$ on the unit sphere of $\mathcal W_n$ … $M(n)>0$ at every $n\ge4$, padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$"*, and *"Distinct from $\Theta_n$, which is the diagonal maximum … strictly at $n=4$ and $n=6$, where $M=\sqrt{3/2}$ against $\Theta_4=0.866$."*
- **$\Pi$**, sense (i): *"the orthogonal projection onto $W^\perp$, at whichever unit $W$ is in play"*, the sense [Lemma L51](../findings/second-order.md) takes.
- **$B$**: *"$B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point, so $A(\tfrac12)=\ker B$ … $B\succeq0$ is only ever readable on $W^\perp$."*
- **Structure constants**: *"$c_{abc}=\langle[v_a,v_b],v_c\rangle$ are totally antisymmetric"*, the whole of claim 3 below.
- **Padding**: *"Padding commutes with $Q$, and preserves both the norm and $\theta$."*

## 1. Hypothesis inventory

### 1a. The hypotheses L24's own statement carries

| hypothesis | where it is used | verdict |
| --- | --- | --- |
| $W$ is a **critical point** ($Q(W)=\theta W$, $\lVert W\rVert=1$) | $L_eW=W$, hence $W^\perp$ invariant, hence $\lambda_{\max}(L_e|_{W^\perp})$ is a spectrum and not a numerical range; also $e\circ e=e$ and the sharpness clause | **used**, and *not* needed by the Hessian identity itself (§2), and redundant inside the "if $W$ is a maximizer" sentence, where it follows from first-order optimality |
| $\theta=P(W)>0$ | (i) $\theta\ne0$ for $e=W/\theta$ to exist at all; (ii) the **sign**, to divide $6\theta(L_e-\tfrac12)\preceq0$ by $6\theta$ | **used, in two places, and the block says "exactly one place"**, see §7 |
| $W$ is a **maximizer** (not merely critical) | the only place $\mathrm{Hess}\preceq0$ enters | **used, and load-bearing**; the sharpness and identity clauses do not need it |
| restriction to $W^\perp$ | the tangent space of the sphere at $W$; also where $c\otimes c$ dies in KT's route | **used** |
| $\lVert W\rVert=1$ | never written in L24's statement; inherited from [conventions.md](../findings/conventions.md)'s definition of "critical point" | **used implicitly**; [Lemma L125](../findings/second-order.md) writes it explicitly, L24 does not |
| local versus global maximiser | nowhere (the word "maximizer" is unqualified | **not stated, and consumers split on it**), §6 |

### 1b. The hypotheses of every theorem the proof imports

| import | its hypotheses | checked against the object? |
| --- | --- | --- |
| [r285](../reviews/REVIEW_r285.md) Claim 1, total symmetry of $\#$ | $c_{abc}$ totally antisymmetric; $X,Y,Z$ **symmetric** operators on $\Lambda^2$ | **yes**, both hold on $\mathcal W_n$; I re-derived the identity independently (§3) |
| $Q$ preserves $\mathcal W_n$ | needed for $\circ$ to be an algebra product on $\mathcal W_n$ at all | **yes**, and it is tabled in [conventions.md](../findings/conventions.md) under $Q$ and again under $\Phi$ (ii); [r285](../reviews/REVIEW_r285.md) calls it *"Claim 1's structural check, which the record uses everywhere without stating"* |
| [Lemma L125](../findings/second-order.md) | at a maximiser of unit norm with $\theta>0$ | **not a dependency**, L24 proves the invariance in situ and the pointer is decorative; L125's own proof runs the other way (§9, withdrawn) |
| [Lemma L32](../findings/isotropy-cap.md) | $x\in\mathfrak{so}(m)$ nonzero, and (per its own refutation banner), $\mathfrak c=\mathfrak z(x)\cap x^\perp\ne0$ | **no.** The object L24 applies it to is the stabiliser of a *Weyl tensor*, which L32 says nothing about; and L32 is marked **REFUTED AS STATED**. §8 |
| [Lemma L51](../findings/second-order.md) | *"a unit critical point of $P$ on the sphere with $Q(W)=\theta W$, $\theta>0$"* | **no**, the scope paragraph applies it precisely at $\theta<0$. §5 |
| Krasnov–Tkachev Prop 6.6 | $A$ a **Euclidean metrised algebra** (associative form (48), positive definite); $c$ an **extremal idempotent**, i.e. a normalised **global** maximum of $\langle x,x^2\rangle\lVert x\rVert^{-3}$ | **partly.** The algebra hypotheses hold and need no unit (§10); the *extremal* hypothesis is global and the record's extraction note reads it as local (§11) |
| "$\mathcal W_n$ carries no $O(n)$-invariant vector" | none stated | **asserted in the block, supported elsewhere in the same file** (*"$\mathrm{Weyl}_n$ is an irreducible $O(n)$-module"*), and at $n=4$ by the block's own $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ |

### 1c. Hypotheses the written proof uses without stating

- **$P(W)\ne0$ rather than criticality** is what the Hessian identity actually needs (§2). The block does not separate them, so a reader cannot see that [route-a.md:213](../findings/route-a.md)'s use of the identity at a bare critical point is legitimate for a reason the block never gives.
- **Linear independence of the pieces** in the $\circ$-orthogonal-splitting corollary. It is forced (§4d), and the block does not say so.

## 2. The Hessian identity, the factor $6\theta$, and the $-3\theta\,\mathrm{Id}$, CONFIRMED, two independent ways

Write $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, fully symmetric by §3, so $P(x)=T(x,x,x)$ and

$$P(x+tV)=P(x)+3t\,T(x,x,V)+3t^2\,T(x,V,V)+t^3T(V,V,V).$$

Hence $\nabla P=3Q(x)$ and $D^2P(x)=6L_x$, which at a critical point of unit norm is $6\theta L_e$ because $L_x=\theta L_e$. Both of the block's ambient coefficients are exact.

**Route A, the multiplier.** Maximising $P$ subject to $\lVert W\rVert^2=1$ gives $\nabla P=2\mu W$, and $\nabla P=3Q(W)=3\theta W$, so $\mu=\tfrac32\theta$. The Hessian of $\mathcal L=P-\mu(\lVert W\rVert^2-1)$ is $6\theta L_e-2\mu\,\mathrm{Id}=6\theta L_e-3\theta\,\mathrm{Id}=6\theta(L_e-\tfrac12\mathrm{Id})$. **The block's $-3\theta\,\mathrm{Id}$ is right, and it is $2\mu$, not $\mu$.**

**Route B, the Riemannian Hessian, which needs no multiplier.** For the unit sphere $S\subset\mathcal W_n$ the second fundamental form is $\mathrm{II}(V,V)=-\lVert V\rVert^2W$, so for any smooth $f$, $\mathrm{Hess}_Sf(V,V)=D^2f(V,V)+\langle\nabla f,\mathrm{II}(V,V)\rangle$. With $f=P$ and $\langle\nabla P,W\rangle=3\langle Q(W),W\rangle=3P(W)=3\theta$,

$$\mathrm{Hess}_SP(V,V)=6\langle L_WV,V\rangle-3\theta\lVert V\rVert^2=6\theta\big\langle(L_e-\tfrac12\mathrm{Id})V,V\big\rangle .$$

**The two routes agree, so the brief's suspicion of a Riemannian-versus-ambient mismatch does not fire.** Note what Route B shows and the block does not: the identity holds at *every* unit $W$ with $P(W)\ne0$, critical or not. Criticality is what upgrades $L_e|_{W^\perp}$ from a compression to an operator, which is exactly what the block's own next sentence says.

### 2a. Finding, the phrase "the Hessian of $P$ restricted to the unit sphere" carries two parses and one of them is false

1. **Located.** The statement line, identically in [results.md](../results.md) and [second-order.md](../findings/second-order.md): *"The Hessian of $P$ restricted to the unit sphere of $\mathrm{Weyl}_n$ is $6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$."*
2. **The failure, concretely.** Read as *"[the Hessian of $P$] restricted to the unit sphere"* the claim is $6\theta L_e|_{W^\perp}=6\theta(L_e-\tfrac12\mathrm{Id})$, which is false by $3\theta\,\mathrm{Id}$ at every critical point with $\theta\ne0$. The witness is closed-form and is the block's own object: on an orbit direction $z$, the first operator returns $6\theta\cdot\tfrac12=3\theta\ne0$ and the second returns $0$.
3. **The opposite.** Read as *"the Hessian of [$P$ restricted to the unit sphere]"* (the Riemannian Hessian), it is exactly Route B and is correct; the proof's next clause (*"the constraint … contributes $-3\theta\,\mathrm{Id}$ through its multiplier"*) settles the parse, and [Lemma L3](../findings/second-order.md)'s proof reads it that way explicitly (*"this being the Riemannian Hessian"*), as does [route-a.md:213](../findings/route-a.md) with $\mathrm{Hess}(P|_S)_u$.

**Verdict: a wording defect, not a mathematical one.** It is worth fixing precisely because the wrong parse is the one a reader reconstructs when checking a consumer in isolation.

## 3. Self-adjointness of $L_e$, CONFIRMED, re-derived

$L_e$ is self-adjoint iff $T$ is fully symmetric, and $T$ is fully symmetric iff each of the two pieces of $Q$ is.

- **The $W^2$ piece.** Its polarisation is $\tfrac12(XY+YX)$, and $\langle\tfrac12(XY+YX),Z\rangle=\tfrac12\big(\operatorname{tr}(XYZ)+\operatorname{tr}(YXZ)\big)$. The six permutations of $\operatorname{tr}(XYZ)$ take exactly two values, $\operatorname{tr}(XYZ)$ and $\operatorname{tr}(XZY)$, each three times by cyclicity; the displayed sum is their average. **It is literally the full symmetrisation**, which is the block's claim.
- **The $\#$ piece.** In the form [r285](../reviews/REVIEW_r285.md) Claim 1 records, $\langle X\#Y,Z\rangle=\tfrac12c_{pqa}c_{rsb}X_{pr}Y_{qs}Z_{ab}$. Under $X\leftrightarrow Z$ relabel $p\leftrightarrow a$ and $r\leftrightarrow b$: the expression becomes $\tfrac12c_{aqp}c_{bsr}X_{ab}Y_{qs}Z_{pr}$, and $c_{aqp}=-c_{pqa}$, $c_{bsr}=-c_{rsb}$, so the two signs cancel and the value is the $X\leftrightarrow Z$ transpose of the original. **The block's "sign $(-1)^2$" is exactly this, and the transposition it needs is the hard one**, r285 says so in terms (*"the load-bearing half is the slot-$1$-to-slot-$3$ transposition, not the easy $X\!\leftrightarrow\!Y$ one"*).

Both pieces require $X,Y,Z$ **symmetric** as operators on $\Lambda^2$, which every algebraic curvature operator is. No hypothesis is missing here.

## 4. The bound, the sharpness, and the simplicity of $1$

### 4a. The bound, CONFIRMED, and $\theta>0$ points the right way

At a maximiser the second-order necessary condition is $\mathrm{Hess}_SP\preceq0$ on $T_WS=W^\perp$, i.e. $6\theta(L_e-\tfrac12\mathrm{Id})\preceq0$ there. Dividing by $6\theta$ preserves the sense **iff $\theta>0$**; at $\theta<0$ it would give $\lambda_{\min}(L_e|_{W^\perp})\ge\tfrac12$. The block's *"$\theta>0$ enters at exactly one place, dividing by $6\theta$"* names the right place, with the caveat in §7.

### 4b. $W^\perp$ is invariant, CONFIRMED, and proved in situ

$L_eW=e\circ W=\theta(e\circ e)=\theta e=W$; for $Z\perp W$, $\langle L_eZ,W\rangle=\langle Z,L_eW\rangle=\langle Z,W\rangle=0$. This uses criticality (through $e\circ e=Q(e)=Q(W)/\theta^2=e$) and §3, nothing else.

### 4c. Sharpness, CONFIRMED, and the repair does establish it

The replacement argument is: *"the orbit directions are exact $\tfrac12$-eigenvectors by equivariance, attained at every nonzero critical point because $\mathcal W_n$ carries no $O(n)$-invariant vector, so the orbit is never a point."* Checked in three parts.

- **Exact $\tfrac12$-eigenvectors.** $Q$ is $O(n)$-equivariant, so $Q(g\cdot W)=g\cdot Q(W)$. Differentiate at $g=\mathrm{id}$ along $A\in\mathfrak{so}(n)$ with $z=A\cdot W$: the left side is $DQ_W[z]=2W\circ z$, the right is $A\cdot(\theta W)=\theta z$. So $W\circ z=\tfrac\theta2z$, i.e. $L_ez=\tfrac12z$ **exactly**, with no maximality and no positivity.
- **$z$ lies in $W^\perp$**, since the action is orthogonal and $A$ skew: $\langle A\cdot W,W\rangle=0$. This is what the failed *"$\langle e,L_ee\rangle=1$"* argument never had, that quantity is the radial direction, and the block's own withdrawal note ($\lVert e\rVert^2=\theta^{-2}$) is correct.
- **The orbit is never a point.** $z=0$ for every $A$ would make $W$ an $O(n)$-invariant vector of $\mathcal W_n$. At $n\ge5$ the file's own *"$\mathrm{Weyl}_n$ is an irreducible $O(n)$-module"* forbids it (an irreducible module with a nonzero invariant vector is trivial, and $\dim\mathcal W_n\ge35$ there). At $n=4$ the block's own $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ does it: each summand is $\mathrm{Sym}^2_0$ of the three-dimensional $\mathfrak{so}(3)$-module, carrying no trivial summand, and $O(4)$ interchanges the two.

So $\tfrac12\in\operatorname{spec}(L_e|_{W^\perp})$ at every critical point with $\theta\ne0$, and at a maximiser the bound makes it the maximum. **The bound is sharp and the repair holds.**

### 4d. $1$ is simple, and the splitting corollary, CONFIRMED

$\mathcal W_n=\mathbb Re\oplus W^\perp$ is $L_e$-invariant with $L_ee=e$, so $\operatorname{spec}(L_e)=\{1\}\cup\operatorname{spec}(L_e|_{W^\perp})\subseteq\{1\}\cup(-\infty,\tfrac12]$ and $1$ is simple.

The corollary: with $W=\sum_ia_iA_i$, the $A_i$ pairwise $\circ$-orthogonal and each critical, $e\circ A_j=\tfrac{a_j}\theta Q(A_j)$, the block's identity, correct. Criticality of $W$ then forces $Q(A_j)=(\theta/a_j)A_j$ for each $a_j\ne0$, so $L_eA_j=A_j$. Two such pieces are **linearly independent**, because $A_2=cA_1$ with $Q(A_1)\ne0$ contradicts $A_1\circ A_2=cQ(A_1)=0$; hence $\dim E(1)\ge2$, contradicting simplicity. **The block's insistence that criticality of the pieces cannot be dropped is correct**, and the independence step it omits is forced rather than assumed.

## 5. The scope paragraph, first half: the $\theta<0$ branch

### 5a. The refutation of "the inequality reverses", CONFIRMED, and I checked the reasoning myself as instructed

$Q$ is quadratic homogeneous, so $Q(-W)=Q(W)$: **even.** $P(-W)=\langle-W,Q(-W)\rangle=-P(W)$: **odd.** If $Q(W)=\theta W$ then $Q(-W)=\theta W=(-\theta)(-W)$, so $-W$ is critical with parameter $-\theta$, and

$$e(-W)=\frac{-W}{-\theta}=\frac W\theta=e(W),\qquad (-W)^\perp=W^\perp .$$

So $\lambda_{\max}(L_e|_{W^\perp})$ takes the *same value* at $W$ and at $-W$, and no object can separate the two signs. The block's claim is exactly right. Consistency check on the two second-order readings: at $W$ (a maximiser, $\theta<0$) the condition is $6\theta(L_e-\tfrac12)\preceq0$, giving $\lambda_{\min}\ge\tfrac12$; at $-W$ (then a minimiser, $-\theta>0$) it is $6(-\theta)(L_e-\tfrac12)\succeq0$, giving the same $\lambda_{\min}\ge\tfrac12$. **The block's parenthetical (that the surviving $\lambda_{\min}$ statement "is this theory read at the local minimiser $-W$"), is correct.**

### 5b. The chordal argument, CONFIRMED AS ALGEBRA, but it cites [Lemma L51](../findings/second-order.md) outside L51's own hypothesis

The claim is: along the chordal curve through an orbit direction the second- and third-order coefficients vanish, leaving $-\tfrac38\theta\lVert z\rVert^4$, so a local maximum forces $\theta\ge0$.

The arithmetic closes. L51 records the chordal quartic coefficient as $-\tfrac92\langle L_Wz,z\rangle+\tfrac{15}8\theta$; on a unit orbit direction $L_Wz=\tfrac\theta2z$, so it is $-\tfrac94\theta+\tfrac{15}8\theta=-\tfrac38\theta$, matching the scope paragraph's homogeneous $-\tfrac38\theta\lVert z\rVert^4$. The $t^2$ coefficient is $-\tfrac34\langle Bz,z\rangle=0$ since $z\in\ker B$, and the $t^3$ coefficient is $T(z,z,z)=\langle z\circ z,z\rangle=0$ by the fusion rule at $y=z$. With $[t^2]=[t^3]=0$ and $[t^4]=-\tfrac38\theta>0$ at $\theta<0$, $P$ strictly increases in both directions along the curve, so $W$ is not a local maximum.

**Finding, by the three-step protocol.**

1. **Located.** The sentence *"Along the chordal curve through an orbit direction the second- and third-order coefficients vanish unconditionally by [Lemma L51], leaving $-\tfrac38\theta\lVert z\rVert^4$"*, applied at $\theta<0$.
2. **The failure, concretely.** L51's canonical statement reads *"let $W$ be a unit critical point of $P$ on the sphere with $Q(W)=\theta W$, **$\theta>0$**"*. Every object the scope paragraph feeds it has $\theta<0$, so the citation is outside the cited lemma's stated range, the record's most-repeated failure mode, in the same block that repairs two others.
3. **The opposite.** L51's proof of the three consumed facts uses no positivity: $L_Wz=\tfrac\theta2z$ and $Bu=z\circ z$ come from differentiating equivariance twice, the fusion rule from self-adjointness of $B$, and the quartic coefficient from the jet. So the conclusion survives; what fails is the citation, and the repair is either a hypothesis widened in L51 to $\theta\ne0$ or a sentence in L24 saying which of L51's clauses it takes and why they are sign-free. **I am not writing that repair.**

## 6. The scope paragraph, second half: "$\theta>0$ is automatic at a maximiser", REFUTED AS STATED, and it is a HYPOTHESIS-DEBT

1. **Located.** *"$\theta>0$ … at a maximiser it is **automatic**, since $P$ is odd and $\max_SP\ge\sqrt{3/2}$ at every $n\ge4$."* And, downstream of it, [LEDGER.md:377](../findings/LEDGER.md): *"$\theta>0$ is redundant at a maximiser | $P$ is odd, so $\max_{\lVert W\rVert=1}P>0$ | **holds.** … the hypothesis is surplus, not missing."*
2. **The failure, concretely.** The quoted argument is about $\max_SP$, the **global** maximum. It says nothing at a *local* maximiser, and the record consumes L24 at local maximisers throughout: [graded-half.md:343](../findings/graded-half.md) (*"hence by Lemma L24 is not a local maximum"*), [nondegeneracy.md:547](../findings/nondegeneracy.md) (*"$\lambda_{\max}=\tfrac58>\tfrac12$ says it is no local maximiser"*), [Lemma L3](../findings/second-order.md). At a local maximiser, the record's own chordal argument (§5b) delivers only $\theta\ge0$, and **the $\theta=0$ branch has no argument on file**. At $\theta=0$ the object $e=W/\theta$ does not exist, so L24 is not merely unproved there, it is unstatable, and a consumer arguing "not a local maximum" by contraposition needs $\theta=0$ excluded, not assumed away.
3. **The opposite.** The charitable reading is that "maximiser" in the scope paragraph means the global one, in which case the sentence is true and the ledger row is true of that reading. That reading is available, but it is not the reading the consumers take, and the ledger row states the conclusion without the qualifier.

**HYPOTHESIS-DEBT, stated exactly.** *To be proved: a local maximiser of $P$ on the unit sphere of $\mathcal W_n$ has $P(W)\ne0$.* Until it is, either L24's $\theta>0$ is a genuine hypothesis that every local-maximiser consumer must discharge at its own object, or the debt is discharged once and cited. I note only that this same file two headings below carries $\operatorname{tr}(L_x)=0$ and $\operatorname{tr}(L_xL_y)=\kappa_W\langle x,y\rangle$ with $\kappa_W=(2n-1)(n-1)/4\ne0$, which is where a repair would be attempted; **whether they close it is not this check's to assert, and I have not written the argument.**

### 6a. Related finding, the statement never says *local* or *global* maximiser, and the record reads it both ways

[bounds-relaxations.md:286](../findings/bounds-relaxations.md) reads it as global: *"says every eigenvalue off $W$ is at most $\tfrac12$ at a **global maximiser**"*. [graded-half.md:343](../findings/graded-half.md), [nondegeneracy.md:547](../findings/nondegeneracy.md) and [Lemma L3](../findings/second-order.md) read it as local. The proof supports the **local** reading (the second-order necessary condition is all it uses), so the local readers are safe and the global reader is merely weaker than entitled, **no consumer is broken, and the statement is underspecified in the one direction that would have broken them if the proof had gone the other way.** The word to add is "local".

## 7. "$\theta>0$ enters at exactly one place", imprecise

$\theta\ne0$ enters a second, earlier place: $e=W/\theta$ does not exist without it, so the whole statement (including the sharpness clause and $L_ee=e$), is conditioned on it. The block's sentence is right about the *sign* and wrong about the count. Small, and it is the sentence a reader consults when asking whether §6's $\theta=0$ branch matters.

### 7a. And the sharpness clause's "every nonzero critical point" should read "every critical point with $\theta\ne0$"

A critical point with $Q(W)=0$ is nonzero and carries no $e$. Same edge, same one-word repair.

## 8. The [Lemma L32](../findings/isotropy-cap.md) citation, REFUTED AS STATED

1. **Located.** *"…so the orbit is never a point and [Lemma L32](isotropy-cap.md)'s stabilizers shrink that multiplicity without reaching zero."*
2. **The failure, concretely, twice over.** (i) L32's own block opens with **"REFUTED AS STATED: A HYPOTHESIS IS MISSING"**, with the witness $x=e_{12}\in\mathfrak{so}(3)$ and the missing hypothesis $\mathfrak c\ne0$, so L24 cites a lemma the record marks refuted. (ii) L32 is a statement about $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ for a **bivector** $x\in\mathfrak{so}(m)$; the multiplicity in L24's sentence is $\dim\mathfrak{so}(n)-\dim\operatorname{stab}(W)$ for a **Weyl tensor** $W$, an object L32 never mentions. The two are not related by any step written down.
3. **The opposite.** The clause is not load-bearing: sharpness needs only that some orbit direction is nonzero, which the preceding clause supplies from the absence of an invariant vector. Read as colour ("stabilisers can be large but not everything"), the sentence is harmless; read as a citation, it points at a refuted result about the wrong object. **The correct action is to delete the citation, not to repair it, and sharpness is untouched either way.**

## 9. Withdrawn candidates

- **Circularity between L24 and [Lemma L125](../findings/second-order.md).** L24's proof says the invariance of $W^\perp$ *"is [Lemma L125] one heading below"*, and L125's proof concludes *"the statement collapses to $\langle Z,L_eZ\rangle\le\tfrac12\lVert Z\rVert^2$, **L24, in both directions**"*. **Withdrawn**: L24 proves the invariance in place from $L_ee=e$ and self-adjointness and imports nothing, so the pointer is decorative and the dependency runs one way only. I checked L125's algebra while I was there and it closes: with $\lVert W\rVert=1$ and $Y=aW+Z$, $a=\langle W,Y\rangle$, the left side is $a^2+\langle Z,L_eZ\rangle$ and the right is $a^2+\tfrac12\lVert Z\rVert^2$, so the two statements are equivalent as claimed.
- **A Riemannian-versus-ambient mismatch in the Hessian.** **Withdrawn as a mathematical defect**, the two routes agree exactly (§2). Retained only as the wording finding §2a.
- **$\ker W\ne0$ breaking the statement.** **Withdrawn**: no hypothesis of L24 mentions the kernel, and the proof consumes only criticality, the algebra and $\theta>0$, all of which [conventions.md](../findings/conventions.md)'s *"padding commutes with $Q$, and preserves both the norm and $\theta$"* carries across a padding unchanged. The record's own padded application is consistent, [stratum-two-negative.md:302](../findings/stratum-two-negative.md) rearranges $C=3\langle E,L_{\mathrm{pad}}E\rangle-\tfrac32\theta_{\mathrm{pad}}$ into $C\le0\iff\langle E,L_eE\rangle\le\tfrac12$, which is L24 restricted to the padding-leaving directions, and its table sits at exactly $\tfrac12$ at $n=8,10,12$ (**the record's numbers, quoted as the record's**). What the padded case *does* show is that $\lVert W\rVert=1$, unstated in L24's statement, is the only normalisation under which the bound's $\tfrac12$ is the right constant, and that comes in through "critical point" per [conventions.md](../findings/conventions.md).
- **$n=4$ as a counterexample.** **Withdrawn**, and the block's own $n=4$ paragraph is correct. If $W=A+B$ with $A\in\mathcal W^+$, $B\in\mathcal W^-$ both nonzero and $W$ critical, then $\mathcal W^+\circ\mathcal W^-=0$ (the operator product vanishes because $W^\pm$ live on complementary summands of $\Lambda^2\mathbb R^4$, and $X\#Y=0$ because $[\Lambda^+,\Lambda^-]=0$ makes every mixed $c_{ijk}$ vanish), so $Q(A)=\theta A$ and $Q(B)=\theta B$ separately, $a=A/\theta$ and $b=B/\theta$ are idempotents, $L_e=\mathrm{Id}$ on $\operatorname{span}(a,b)$, and $W^\perp$ meets that plane in a line: $\lambda_{\max}(L_e|_{W^\perp})=1$. **This is a saddle and not a counterexample**, because $M(4)=\sqrt{3/2}=1.2247>0.866=\theta(S^2\times S^2)$ by [conventions.md](../findings/conventions.md)'s own $M(n)$ row. The block's label correction ($\mathfrak u(2)$ is $W_{\mathbb{CP}^2}$'s isotropy at $\pm\sqrt{3/2}$; $0.866$ belongs to $S^2\times S^2$) is consistent with $\theta_0(4)^2=2\cdot3\cdot2/16=3/4$.
- **The unitality trap.** **Withdrawn**: read at source, KT's Definition of a Euclidean metrised algebra is (48), $\langle xy;z\rangle=\langle x;yz\rangle$, plus positive-definiteness of the form. **No unit appears anywhere in the definition or in Proposition 6.6's proof**, and Proposition 6.1 makes every cubic form's $V(u)$ commutative automatically. $\mathcal W_n$ with $\circ$ satisfies both: commutative by construction, and metrised by the total symmetry of $T$ re-derived in §3. [fence-posts.md:189](../findings/fence-posts.md) already scopes this correctly (*"the parts of that literature not needing a unit"*). **This is the one place the brief expected a hypothesis failure and there is none.**
- **The odd-$n$ and small-$n$ edges.** **Withdrawn**: no step of L24 is dimension-dependent. The smallest admissible dimension is $n=4$ ($\dim\mathcal W_4=10$, and $\dim\mathcal W_3=0$), handled above; odd $n$ enters nowhere, since neither $\theta_0(n)$ nor $\Theta_n$ (the two quantities with an odd/even split), appears in L24 or its proof. The only $n$-dependent input is $\max_SP\ge\sqrt{3/2}$ at $n\ge4$, and that is used solely in the scope paragraph refuted for other reasons in §6.

## 10. Krasnov–Tkachev Proposition 6.6, read at source

The paper's statement, from [kt-1801.00617.txt](https://arxiv.org/abs/1801.00617): *"Let $A$ be a Euclidean metrised algebra. Then for any extremal idempotent $c$ there holds $\sigma(c)\subset(-\infty,\tfrac12]$. In particular, $1$ is a simple eigenvalue of $L_c$."* Its proof is the same two lines as the record's: $D^2f(c)\preceq0$ for $f(x)=\langle x^2;x\rangle/\lvert x\rvert^3$, then $c\otimes c$ dies on $c^\perp$.

**The misprint call is CONFIRMED from the paper's own equation (56).** Substituting $x=c$ with $c^2=c$, so $\langle c^2;c\rangle=\lVert c\rVert^2$, the numerator of (56) is

$$2\lVert c\rVert^4L_c-\lVert c\rVert^4\mathrm{Id}-6\lVert c\rVert^2\,c\otimes c+5\lVert c\rVert^2\,c\otimes c=\lVert c\rVert^4\Big(2L_c-\mathrm{Id}-\frac{c\otimes c}{\lVert c\rVert^2}\Big),$$

so $\tfrac13D^2f(c)=\big[2L_c-\mathrm{Id}-(c\otimes c)/\lVert c\rVert^2\big]/\lVert c\rVert$, and the printed $2L_c-1\le c\otimes c$ is missing $\lVert c\rVert^{-2}$ exactly as [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) says. On this project's objects $\lVert c\rVert=1/\theta<1$ whenever $\theta>1$, so the printed form is the false one and the projector form is the true one, **the extraction note is right, and it is right for the reason it gives.**

**Normalisation match.** KT set $c=y/k$ where $y^2=ky$ at the maximum; here $Q(W)=\theta W$ and $e=W/\theta$, so $e$ *is* their $c$, $e\circ e=e$, and $\lVert e\rVert=1/\theta$, which is their remark that extremal idempotents are the minimal-norm ones. There is no factor discrepancy between the two multiplications: both fix the scale by idempotency.

## 11. The one imported hypothesis that fails: "extremal idempotent" is a GLOBAL maximum

1. **Located.** [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md): *"'Extremal idempotent' = the idempotent associated to a **local maximum** of $\langle x,x^2\rangle$ on the unit sphere."* The L24 block sends the reader to that file by name (*"see [the notes]"*).
2. **The failure, concretely.** KT's Definition 6.4 defines an extremal idempotent as one *"constructed in the course of proof of Proposition 6.3"* (that proof takes the **global** maximum of $u$ on the compact sphere) and the very next sentence says *"the set of extremal idempotents coincide with the set of suitably normalized **global maximum** points"*, from which they deduce $\lVert c\rVert\le\lVert c_1\rVert$ **for every idempotent $c_1$**. A local maximum has no such property, and the record supplies the witness in closed form: by [Lemma L3](../findings/second-order.md) the balanced product $S^4\times S^4$ is a local maximum at $n=8$ with $\theta_0(8)^2=2\cdot7\cdot6/8^2=21/16$, so its idempotent has $\lVert c\rVert^2=16/21$; padded $W_{\mathbb{CP}^2}$ is an idempotent of the same algebra with $\theta^2=3/2$ and $\lVert c_1\rVert^2=2/3<16/21$. **A local maximum that is not of minimal norm is not extremal in KT's sense**, so the gloss is refuted on this record's own objects.
3. **The opposite.** Two charitable readings, and neither rescues the sentence. (i) The *conclusion* of Prop 6.6 does extend to local maxima, because its proof consumes only $D^2f(c)\preceq0$, true, and it is exactly why this project's independent derivation is the stronger statement. (ii) The gloss cites Tkachev's survey Proposition 2.5 alongside; **that paper is not in [references/](../references/), so the citation cannot be checked here and is a lead, not a citation.** Neither reading changes what KT's Definition 6.4 says.

**Consequence for L24, stated precisely.** Nothing in L24's derivation depends on KT (the block is explicit that the result was derived independently) so the lemma is untouched. What is touched is the prior-art paragraph and the landscape line in [results.md](../results.md): *"This is Krasnov–Tkachev's Proposition 6.6"* is an identification of a **local**-maximiser statement with a **global**-maximiser theorem. The honest form is that Prop 6.6 is the global case and this record proves the local one by the same argument. **This is the brief's "imported theorem whose hypotheses were never checked against the object" trap, firing on the definition rather than on the algebra.**

## 12. Symbol collisions

- **$T$.** L24 and [Lemma L51](../findings/second-order.md) both use $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, the algebra's structure tensor. [conventions.md](../findings/conventions.md) tables $T_{abc}=c_{abc}^2$ under *"Structure constants"* and a second sense $T=\tfrac{2\sqrt2}3A$ in the [L35](../findings/stratum-two-negative.md) row, **the L24 sense is a third and is tabled nowhere**, while the file's own rule is that a convention is quoted, never restated. L24 defines it inline, so no step misreads it; the exposure is a consumer meeting $\lVert T\rVert^2=\kappa_WD$ in the same file and reaching for $c_{abc}^2$.
- **$B$.** Used by L51 in [conventions.md](../findings/conventions.md)'s sense ($B=\tfrac\theta2\mathrm{Id}-L_W$), not the Killing form. Correct sense, correctly.
- **$\Pi$.** L51's corrector uses sense (i), the projection onto $W^\perp$. Correct sense.
- **$e$**, **$L$**, **$\theta$**, **$Q$**, **$P$**: single-sensed throughout the block and matching [conventions.md](../findings/conventions.md).
- **$\lambda_{\max}$ of what.** The block writes $L_e|_{W^\perp}$; consumers write $L_e|_{e^\perp}$ ([target.md:550](../findings/target.md), [bounds.md:123](../findings/bounds.md)) and $L_M|_{W^\perp}\le\theta/2$ ([LEDGER.md:818](../findings/LEDGER.md)). All three are the same statement ($e=W/\theta$ gives $e^\perp=W^\perp$, and $L_W=\theta L_e$ converts the third), **no finding**, but three spellings of one bound is how a factor gets lost.

## 13. The gap between what is proven and what is used, the consumer sweep

I read every citation of L24 in [findings/](../findings/), [results.md](../results.md), [plan.md](../plan.md) and [ATTEMPTS.md](../ATTEMPTS.md), and classified them by which clause they consume.

| use | consumers | verdict |
| --- | --- | --- |
| the **Hessian identity** at a bare critical point | [Lemma L3](../findings/second-order.md), [route-a.md:213](../findings/route-a.md), [diagonal-half.md:124](../findings/diagonal-half.md) | **legitimate**, the identity needs $P(W)\ne0$ and not maximality (§2), though the block never says so |
| the **sharpness clause** at a bare critical point | [graded-half.md:231](../findings/graded-half.md), [LEDGER.md:897](../findings/LEDGER.md) (*"the orbit directions are exact $\tfrac12$-eigenvectors at **every** nonzero critical point"*) | **legitimate**, proved by equivariance alone, and [results.md](../results.md)'s landscape line carries the clause so consumers have a home for it |
| the **bound** by contraposition, to deny *local* maximality | [graded-half.md:343](../findings/graded-half.md), [nondegeneracy.md:547](../findings/nondegeneracy.md), [bounds.md:123](../findings/bounds.md) | **legitimate on the local reading**, which is the reading the proof supports, see §6a |
| the **bound** at a *global* maximiser only | [bounds-relaxations.md:286](../findings/bounds-relaxations.md) | **weaker than entitled**, harmless |
| the **bound** at a **non-critical** point | flagged and corrected on the record already: [target.md:608](../findings/target.md) (*"computed at **non-critical** operators … where Lemma L24 has no content"*), [fence-posts.md:7](../findings/fence-posts.md) | **the record caught its own** |
| the **bound off $W^\perp$** | flagged and corrected already: [bounds-relaxations.md:272](../findings/bounds-relaxations.md) (*"LEMMA L24 IS APPLIED OUTSIDE ITS OWN SPACE"*), [diagonal-half.md:153](../findings/diagonal-half.md) (*"L24 needs $N\perp W$, and only the row sums were checked"*), [LEDGER.md:568](../findings/LEDGER.md) | **the record caught its own**, three times |
| the **premise inverted**, conclusion used as a fact about critical points | flagged already: [bounds.md:109](../findings/bounds.md) (*"that is a logical error rather than an overreach"*) | **the record caught its own** |

**No live misuse found.** Every trap the brief named as a citation risk (at a mere critical point, off $W^\perp$), is already on the record with a correction attached. The one exposure that is *not* recorded anywhere is §6: the consumers denying **local** maximality inherit the unclosed $\theta=0$ branch, and none of them says so.

## 14. What would falsify it, and what I did to look

**The falsifier is a local maximiser $W$ of $P$ on the unit sphere of $\mathcal W_n$, with $\theta=P(W)>0$, carrying a direction $Z\perp W$ with $\langle Z,L_eZ\rangle>\tfrac12\lVert Z\rVert^2$.** Because the lemma is a two-line consequence of the second-order necessary condition and the identity of §2, such an object exists only if the Hessian identity is wrong; so the hunt reduces to finding a critical point where $\mathrm{Hess}_SP\ne6\theta(L_e-\tfrac12\mathrm{Id})$, or a maximiser where $W^\perp$ fails to be the tangent space or fails to be $L_e$-invariant.

What I tried, all in closed form and with no computation:

- **$n=4$, both chambers.** $W=A+B$ across the $\mathcal W^+\oplus\mathcal W^-$ split, where $\lambda_{\max}(L_e|_{W^\perp})=1$ exactly. It is a critical point and not a maximiser, since $M(4)=\sqrt{3/2}>\theta_0(4)=\sqrt3/2$. **No falsifier; the block's own $n=4$ paragraph is what this is.**
- **$\ker W\ne0$**, the padded family: padded $W_{\mathbb{CP}^2}$ in $\mathcal W_n$ for $n>4$. Padding preserves $Q$, the norm and $\theta$, so criticality, self-adjointness and invariance all transfer; the $\tfrac12$ on the padding-leaving directions is what the record measures and it is consistent. **No falsifier.**
- **$\theta<0$**, via $-W$ at any maximiser. Refuted structurally: $e$ and $W^\perp$ are literally unchanged. **No falsifier can exist here**, this is the block's own strongest repair and it holds.
- **$\theta=0$**, i.e. $Q(W)=0$. Here the statement has no $e$ and no content; it is excluded by hypothesis, and §6 is the debt this leaves at a local maximiser. **Not a falsifier of L24; a hole in the claim that L24's hypothesis is free.**
- **The structured families the record names**, diagonal (via [diagonal-half.md](../findings/diagonal-half.md)'s $\mathcal L$ form of the same operator), sphere products ($\lambda_{\max}=\tfrac12$ attained on the orbit tangent by [Lemma L27](../findings/nondegeneracy.md), consistent), $\mathbb{CP}^m$ ($\lambda_{\max}=\tfrac58>\tfrac12$ at $\mathbb{CP}^3$, correctly reported as *not a local maximiser*), subalgebra-Casimir and torus points. **Every one is either consistent with the bound or already recorded as a non-maximiser because it violates the bound**, which is the lemma being used, not tested.
- **A local maximiser whose $\tfrac12$-eigenspace exceeds the orbit** ("excess"), which is where a falsifier would have to hide if one existed. [Lemma L51](../findings/second-order.md) records that **no local maximum with positive excess has ever been exhibited**. That is an absence, not a proof, and it is the right place for the next attack, but a falsifier there would refute Morse–Bott nondegeneracy, not L24.

## Verdict

**PROVEN, hypotheses corrected.**

The statement is true and its proof closes: the Hessian identity, the factor $6\theta$, the multiplier's $-3\theta\,\mathrm{Id}$, the direction of the division by $6\theta$, the self-adjointness, the invariance of $W^\perp$, the sharpness by equivariance and the simplicity of $1$ each check by hand, and both of the block's previous repairs, the $\tfrac12$-eigenvector replacement for the false *"$\langle e,L_ee\rangle=1$"*, and the $Q$-even/$P$-odd refutation of the sign reversal, are correct for the reasons given.

The corrections owed are these, none of them touching the mathematics of the bound:

1. **HYPOTHESIS-DEBT** (§6): *a local maximiser of $P$ on the unit sphere has $P(W)\ne0$* has no argument on file. The scope paragraph and [LEDGER.md:377](../findings/LEDGER.md) both call $\theta>0$ automatic on a global-maximiser argument, while the consumers apply L24 at local maximisers.
2. **The [Lemma L51](../findings/second-order.md) citation is outside L51's own $\theta>0$** (§5b). The conclusion survives; the citation needs widening or a sentence naming the sign-free clauses.
3. **The [Lemma L32](../findings/isotropy-cap.md) citation is to a REFUTED-AS-STATED lemma about the wrong object** (§8). Delete it; sharpness does not use it.
4. **The Krasnov–Tkachev extraction note turns a global maximum into a local one** (§11), and the prior-art identification inherits that. The record's L24 is the stronger, local statement.
5. **Wording:** "maximizer" should read *local maximiser* (§6a); "the Hessian of $P$ restricted to the unit sphere" admits a false parse (§2a); "$\theta>0$ enters at exactly one place" undercounts (§7); "every nonzero critical point" should read *every critical point with $\theta\ne0$* (§7a); and $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ belongs in [conventions.md](../findings/conventions.md), where $T$ already carries two other senses (§12).
