# Verifier v157, Lemma L24: the Hessian identity $6\theta(L_e-\tfrac12\mathrm{Id})$, the maximiser bound $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, the simplicity of $1$, the sharpness repair, the negative-$\theta$ scope repair, and the Krasnov–Tkachev attribution

Cold read of [BRIEF_L24.md](BRIEF_L24.md), worked from the definitions in [findings/conventions.md](../findings/conventions.md) and from [Krasnov–Tkachev](https://arxiv.org/abs/1801.00617) at source. **No numerical work of any kind was done: no script, no Sage, no evaluation. Every value below is exact and every witness is exhibited in closed form.** The programme's analysis-only rule ([.claude/rules/analysis-only.md](../.claude/rules/analysis-only.md)) was in force throughout, and its screening allowance was not used either, nothing here needed it. Log: [agent_logs/verify-L24-v157.log](../agent_logs/verify-L24-v157.log).

## The claim table

| # | claim attacked | verdict | reason |
| --- | --- | --- | --- |
| 1 | $\mathrm{Hess}(P\vert_S)_W=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$ | **CONFIRMED** | multiplier $\mu=\tfrac32\theta$ gives $-3\theta\,\mathrm{Id}$; three independent routes agree, including Krasnov–Tkachev's own equation (56) |
| 2 | $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$ at a maximiser | **CONFIRMED** | $\theta>0$ is used exactly once, dividing by $6\theta$, and in the direction claimed |
| 3 | $L_e$ self-adjoint; $W^\perp$ is $L_e$-invariant | **CONFIRMED** | $T$ fully symmetric by the two-part argument the block gives, each part re-derived |
| 4 | $1$ is a simple eigenvalue of $L_e$ | **CONFIRMED** | forced by claim 2; and maximality is not droppable, $S^2\times S^2$ at $n=4$ is a closed-form witness |
| 5 | no maximiser splits $\circ$-orthogonally into critical pieces | **CONFIRMED AS ALGEBRA** | criticality forces $a_i\mu_i=\theta$, putting every piece at eigenvalue $1$; the block is right that criticality cannot be dropped |
| 6 | the sharpness repair, orbit directions are exact $\tfrac12$-eigenvectors | **CONFIRMED** | differentiating $O(n)$-equivariance; the tangent lies in $W^\perp$ and is nonzero |
| 7 | …its citation of [Lemma L32](../findings/isotropy-cap.md) | **REFUTED** | L32 is about a bivector's centraliser in $\mathfrak{so}(m)$, says nothing about $\mathfrak k(W)$ for $W\in\mathcal W_n$, and is itself flagged REFUTED AS STATED in its own file |
| 8 | the scope repair, no witness separates the sign of $\theta$ | **CONFIRMED** | $Q$ even and $P$ odd give $e(-W)=e(W)$ and $(-W)^\perp=W^\perp$, so it is literally the same operator |
| 9 | no local maximiser has $\theta<0$ | **CONFIRMED AS ALGEBRA** | the chordal quartic $-\tfrac38\theta\lVert z\rVert^4$ recomputed from [Lemma L51](../findings/second-order.md)'s own coefficient; **but the citation reaches outside L51's stated hypothesis $\theta>0$** |
| 10 | [findings/second-order.md](../findings/second-order.md) line 19, "at $\mathfrak u(2)\subset\mathfrak{so}(4)$, $\theta=-0.866$ and the inequality reverses" | **REFUTED, and live** | it is the exact claim its own file refutes fifty-one lines below, still standing unretracted in the section a reader meets first |
| 11 | unit norm as a hypothesis of the canonical statement | **CONFIRMED, hypothesis unstated** | the identity is false at $\lVert W\rVert=2$ under the statement's literal reading; recovered only from conventions.md's definition of "critical point" |
| 12 | Krasnov–Tkachev Prop. 6.6's hypotheses against $\mathcal W_n$ with $\circ$ | **CONFIRMED** | metrised and Euclidean both hold; **unitality is not a hypothesis of 6.6**, so the trap that killed the other route does not bite here |
| 13 | [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md)'s "extremal idempotent = local maximum" | **REFUTED** | Definition 6.4 and the proof of Proposition 6.3 both say *global* maximum, and the minimal-norm consequence the same paragraph quotes needs globality |
| 14 | Krasnov–Tkachev's printed conclusion $\sigma(c)\subset(-\infty,\tfrac12]$ | **REFUTED AS PRINTED** | a **second** misprint, distinct from the $c\otimes c$ one on file: the paper's own p. 5 convention has $1\in\sigma(c)$ |
| 15 | $\ker W\ne0$ / padded objects | **no finding** | L24 never touches $W$'s action on $\Lambda^2$; $\ker W$ is invisible to every step |
| 16 | $n=4$, the smallest admissible dimension, odd $n$ | **no finding** | no step carries a dimension or a parity |
| 17 | $\theta=0$ | **scope gap, outside the lemma** | $e$ is undefined there, and the block's own argument closes only the $\theta<0$ branch for local maximisers |
| 18 | the 55 citations | **no live unflagged misuse found** | both historical misuse patterns (at a critical point, and off $W^\perp$), are flagged in place at the sites where they occurred |

## The one-line summary

The lemma is proven and both of its previous repairs hold, but three things around it are wrong: the file's own criterion section still carries the sign claim the same file refutes, the sharpness clause cites a lemma that is both irrelevant to it and refuted as stated, and the Krasnov–Tkachev notes misstate "extremal" as a local maximum where the source says global.

## 0. Conventions, fixed once

Quoted from [findings/conventions.md](../findings/conventions.md), not restated:

> $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$

> **The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it.

> **"Critical point" is $Q(W)=\theta W$**, the first-order condition on $\{\lVert W\rVert=1\}$.

> $M(n)$ | **the global maximum** of $P$ on the unit sphere of $\mathcal W_n$ […] Distinct from $\Theta_n$, which is the *diagonal* maximum

> **Padding commutes with $Q$**, and preserves both the norm and $\theta$.

> $B$ | $B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point, so $A(\tfrac12)=\ker B$

The last two matter below at items 15 and 9 respectively.

## 1. The hypothesis inventory

**A pass with no inventory is not a pass, so here it is in full.**

### 1a. Hypotheses the statement carries

| hypothesis | stated? | used? | where |
| --- | --- | --- | --- |
| $W$ is a critical point, $Q(W)=\theta W$ | yes | **yes** | $e\circ e=e$; $L_eW=W$; the multiplier value $\mu=\tfrac32\theta$ |
| $\theta=P(W)$, i.e. $\theta>0$ | yes | **yes, once** | dividing $\mathrm{Hess}\preceq0$ by $6\theta$; and $\theta\ne0$ for $e$ to exist |
| $\lVert W\rVert=1$ | **no** | **yes, twice** | "$\theta=P(W)$" is the unit-norm reading of conventions.md's $\theta$; and the sphere's second fundamental form carries $1/r$, see §7 |
| $W$ is a *maximiser* (not merely critical) | yes | **yes** | $\mathrm{Hess}\preceq0$; **not** used for the Hessian identity itself, which is a criticality statement |
| the restriction to $W^\perp$ | yes, in the conclusion | **yes** | the identity is a statement about $T_WS=W^\perp$ only; it is false read on all of $\mathcal W_n$ |
| $n\ge4$ | no | no | nothing in the argument sees $n$; at $n\le3$, $\dim\mathcal W_n=0$ and the lemma is vacuous |
| global vs local maximiser | not distinguished | **local suffices** | only $\mathrm{Hess}\preceq0$ is consumed, which a local maximum supplies |

### 1b. Hypotheses of every theorem the proof imports

| import | its hypotheses | met by the object? |
| --- | --- | --- |
| [Lemma L51](../findings/second-order.md)'s variation calculus (used in **Scope**) | "$T$ fully symmetric, $G$ compact acting orthogonally leaving $P$ invariant, $W$ a unit critical point, **$\theta>0$**" | **the sign hypothesis is violated by the very use**: the Scope paragraph invokes L51 precisely to rule out $\theta<0$. The three facts consumed are sign-free in L51's own proof, so the mathematics survives; the citation does not. §9 |
| [Lemma L32](../findings/isotropy-cap.md) (used in **Sharpness**) | "$x\in\mathfrak{so}(m)$ nonzero, $\mathfrak c=\mathfrak z(x)\cap x^\perp$", plus the missing $\mathfrak c\ne0$ its own file records | **not met, and not applicable**: the object at hand is $W\in\mathcal W_n$ and the quantity is $\dim\mathfrak k(W)$. §7 |
| [Lemma L125](../findings/second-order.md) (cross-referenced) | "$W$ a maximiser **of unit norm** with $\theta>0$" | met; and note it states the norm hypothesis L24 omits |
| the self-adjointness argument attributed to [r285](../reviews/REVIEW_r285.md) Claim 1 | full symmetry of $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ | met; re-derived independently in §3 |
| [Krasnov–Tkachev Prop. 6.6](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) | $A$ a Euclidean metrised algebra; $c$ an **extremal** idempotent | metrised and Euclidean met (§11); **extremal is a global-maximum hypothesis in the source**, and the record uses L24 at local maxima (§12) |
| "$\mathcal W_n$ carries no $O(n)$-invariant vector" |, | true, but the step needs the $SO(n)$ statement; that is also true, so the conclusion stands. §8 |
| "$\max_SP\ge\sqrt{3/2}$ at every $n\ge4$" | padding preserves $\theta$; $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$ | met, and correctly written as $\max_SP$ rather than $\Theta_n$, trap W5 avoided |

### 1c. Hypotheses used but never stated

Two, and both are real: **$\lVert W\rVert=1$** (§7) and **$\theta\ne0$ for $e$ to be defined at all**, the Scope paragraph's "$\theta>0$ enters at exactly one place" accounts for the *sign* and silently omits that non-vanishing is a second, prior use.

### 1d. Hypotheses stated and never used

**None in the statement.** In the argument, the citation of [Lemma L32](../findings/isotropy-cap.md) is the reverse defect, a citation carrying no load and pointing at the wrong theorem (§7).

## 2. The Hessian identity, and the multiplier

$P(W)=\langle W,Q(W)\rangle=T(W,W,W)$ with $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, since $X\circ X=\tfrac12(Q(2X)-2Q(X))=Q(X)$. Full symmetry of $T$ (§3) gives

$$\nabla P(W)=3\,W\circ W=3Q(W),\qquad D^2P(W)[X,X]=6\,T(W,X,X)=6\langle L_WX,X\rangle,$$

and $L_W=\theta L_e$ because $e=W/\theta$. So the **ambient** Hessian is $6\theta L_e$, which is what the block says.

**The multiplier.** Criticality on $\{\lVert W\rVert^2=1\}$ reads $3Q(W)=2\mu W$; with $Q(W)=\theta W$ this forces $\mu=\tfrac32\theta$. The Lagrangian $P-\mu(\lVert W\rVert^2-1)$ then has Hessian $6\theta L_e-2\mu\,\mathrm{Id}=6\theta L_e-3\theta\,\mathrm{Id}$. **The block's $-3\theta\,\mathrm{Id}$ is exact.**

**The same number by the second fundamental form**, which is the reading the file commits to elsewhere. For the unit sphere with outward normal $W$, $\mathrm{II}(X,X)=-\lVert X\rVert^2W$, so

$$\mathrm{Hess}_S P(X,X)=D^2P(W)[X,X]+\langle\nabla P(W),\mathrm{II}(X,X)\rangle=6\theta\langle L_eX,X\rangle-3P(W)\lVert X\rVert^2=6\theta\big\langle(L_e-\tfrac12\mathrm{Id})X,X\big\rangle$$

for $X\in W^\perp$, using $P(W)=\theta$ at unit norm. The two routes agree.

**Which Hessian is meant.** The brief asks whether "the Hessian of $P$ restricted to the unit sphere" is the Riemannian Hessian or the restriction of the ambient one. It must be the **Riemannian** one: the ambient Hessian of the cubic $P$ is $6\theta L_e$ with no $-\tfrac12$, so the other reading makes the displayed identity false. The file settles it explicitly at [Lemma L3](../findings/second-order.md)'s proof, "on the tangent space, **this being the Riemannian Hessian**, the constraint's $-3\theta\,\mathrm{Id}$ being what produces the $\tfrac12$", and the grammar of "the Hessian of ($P$ restricted to the sphere)" reads the same way. **No finding on the reading**; one precision note in §7 on the missing "on the tangent space" in the canonical statement.

## 3. Self-adjointness, and $W^\perp$ invariant

Both halves of the block's argument close.

**The $W^2$ part.** With $X\circ Y\supset\tfrac12(XY+YX)$ and the pairing a multiple of $\mathop{\mathrm{tr}}$, that part of $T$ is $\tfrac12(\mathop{\mathrm{tr}}(XYZ)+\mathop{\mathrm{tr}}(YXZ))$. Cyclicity gives $\mathop{\mathrm{tr}}(XYZ)=\mathop{\mathrm{tr}}(YZX)=\mathop{\mathrm{tr}}(ZXY)$ and $\mathop{\mathrm{tr}}(YXZ)=\mathop{\mathrm{tr}}(XZY)=\mathop{\mathrm{tr}}(ZYX)$, so the sum is the average over all six permutations: **fully symmetric**, exactly as the block claims ("the symmetrisation of $\mathop{\mathrm{tr}}(XYZ)$").

**The $\#$ part.** $\langle X\#Y,Z\rangle$ contracts $X$, $Y$, $Z$ against $c_{ace}c_{bdf}$ with the structure constants totally antisymmetric ([conventions.md](../findings/conventions.md): "**Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**"). Transposing two arguments transposes one index pair in each $c$, sign $(-1)^2=+1$. **Fully symmetric**, and the block's "sign $(-1)^2$" is the whole of it.

Hence $\langle L_eX,Y\rangle=T(e,X,Y)=T(e,Y,X)=\langle X,L_eY\rangle$, so $\lambda_{\max}$ is defined. And $L_eW=\theta L_ee=\theta(e\circ e)=\theta Q(e)=\theta\,Q(W)/\theta^2=W$, so self-adjointness carries $W^\perp$ to itself. Both steps are as written.

*This is also the check that $\mathcal W_n$ with $\circ$ is a metrised algebra in Krasnov–Tkachev's sense; §11 completes that against the source.*

## 4. The bound, and where $\theta>0$ acts

At a maximiser (local suffices) $\mathrm{Hess}_SP\preceq0$ on $W^\perp$, i.e. $6\theta(L_e-\tfrac12\mathrm{Id})\preceq0$ there. Dividing by the **positive** number $6\theta$ preserves the sense and gives $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$. At $\theta<0$ the same division reverses it to $\lambda_{\min}(L_e\vert_{W^\perp})\ge\tfrac12$, which is what the block's surviving italic sentence says. **The sign is used in the direction claimed and nowhere else.** No finding.

## 5. Simplicity of $1$, and why maximality cannot be dropped

Given the bound: any $Y$ with $L_eY=Y$ splits as $aW+Z$, $Z\in W^\perp$; $L_e$ preserves both summands, so $L_eZ=Z$ with $Z\in W^\perp$ contradicts $\le\tfrac12$ unless $Z=0$. The $1$-eigenspace is $\mathbb RW$. **Correct as written.**

**And a closed-form witness that maximality is load-bearing here**, which also answers the brief's $n=4$ item. Take $W=W^++W^-$ at $S^2\times S^2$, the record's $n=4$ critical point at $\theta=0.866$. $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ is a $\circ$-orthogonal sum: for $X\in\mathcal W^+$, $Y\in\mathcal W^-$ the block-diagonal supports give $XY=YX=0$, and $X\#Y$ contracts $c_{ace}$ with $c\in\Lambda^+$ and $e\in\Lambda^-$, which vanishes because $[\Lambda^+,\Lambda^-]=0$ in $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$. Hence $Q(W)=Q(W^+)+Q(W^-)$ with the summands in their own factors, and criticality forces $Q(W^\pm)=\theta W^\pm$ separately. Then

$$Z:=W^+-W^-\ \Longrightarrow\ L_WZ=Q(W^+)-Q(W^-)=\theta Z,\quad\text{i.e.}\quad L_eZ=Z,$$

and $\langle Z,W\rangle=\lVert W^+\rVert^2-\lVert W^-\rVert^2=0$ by the factor-exchange symmetry of $S^2\times S^2$. So $\lambda_{\max}(L_e\vert_{W^\perp})\ge1$ and $1$ is **not** simple at this critical point. **A citation of L24 at a mere critical point is refuted by this object**, in closed form, at the smallest admissible dimension.

*One precision note on the block's own footnote, which asserts equality:* the structural argument yields $\ge1$, which is all the footnote needs (the point is a saddle). The equality clause "$\lambda_{\max}(L_e\vert_{W^\perp})=1$ there" additionally asserts that nothing in the remaining eight dimensions exceeds $1$, and that has no argument on file. It is not load-bearing for anything the footnote concludes.

## 6. The $\circ$-orthogonal-splitting corollary

Let $W=\sum_ia_iA_i$ with $A_i\circ A_j=0$ for $i\ne j$ and each $A_i$ critical, $Q(A_i)=\mu_iA_i$. Then $Q(W)=\sum_ia_i^2Q(A_i)=\sum_ia_i^2\mu_iA_i$, and criticality $Q(W)=\theta W$ gives $a_i^2\mu_i=\theta a_i$, hence $a_i\mu_i=\theta$ at every $i$ with $a_i\ne0$. Therefore $e\circ A_i=\tfrac{a_i}\theta Q(A_i)=\tfrac{a_i\mu_i}\theta A_i=A_i$: **every piece sits at eigenvalue $1$**. The pieces are independent ($\mu_1\langle A_1,A_2\rangle=\langle Q(A_1),A_2\rangle=\langle A_1,A_1\circ A_2\rangle=0$), so $k\ge2$ contradicts simplicity. **The block's derivation is exact and its insistence that criticality of the pieces cannot be dropped is correct**, the step $e\circ A_j=\tfrac{a_j}\theta Q(A_j)$ needs nothing, and only $Q(A_j)\propto A_j$ turns it into an eigenvector. Its comparison to [Lemma L66](../findings/support-dichotomy.md) (whose statement quantifies over unit $A_i$ with no criticality), is therefore right: this route is strictly weaker.

## 7. FINDING, the sharpness repair holds, but its citation of Lemma L32 does not

**The repair itself is confirmed.** Differentiating the $O(n)$-equivariance $Q(gW)=gQ(W)$ along $g=e^{tA}$, $A\in\mathfrak{so}(n)$, at a critical point gives $2\,W\circ z=\theta z$ for $z=\mathcal L_AW$, i.e. $L_Wz=\tfrac\theta2z$, i.e. $L_ez=\tfrac12z$ once $\theta\ne0$. And $\langle z,W\rangle=0$ because the action is orthogonal. So orbit directions are exact $\tfrac12$-eigenvectors **lying in $W^\perp$**, which is what sharpness needs and what the refuted "$\langle e,L_ee\rangle=1$" version could never deliver, that quantity is $\lVert e\rVert^2=\theta^{-2}$ and concerns the direction $W$ itself. **The replacement establishes sharpness; the previous refutation is correctly discharged.**

### The discrepancy, in three steps

**1. Located.** The sharpness paragraph, [findings/second-order.md](../findings/second-order.md) line 67: "…so the orbit is never a point and **[Lemma L32](../findings/isotropy-cap.md)'s stabilizers shrink that multiplicity without reaching zero**."

**2. The failure, concretely.** L32's statement is: "Let $x\in\mathfrak{so}(m)$ be nonzero and $\mathfrak c=\mathfrak z(x)\cap x^\perp$. Then $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$…". It quantifies over **bivectors**. The object here is a Weyl tensor $W\in\mathcal W_n$ and the quantity is $\dim\{\mathcal L_AW:A\in\mathfrak{so}(n)\}=\dim\mathfrak{so}(n)-\dim\mathfrak k(W)$. L32 contains no statement about $\mathfrak k(W)$ for any $W\in\mathcal W_n$. Concretely, at padded $W_{\mathbb{CP}^2}$ the record's own datum ([findings/diagonality.md](../findings/diagonality.md) line 71) is $\mathfrak k=\mathfrak u(2)\oplus\mathfrak{so}(n-4)$; nothing in L32 produces, bounds or constrains that algebra. **And L32 is flagged REFUTED AS STATED in its own file** ("**REFUTED AS STATED: A HYPOTHESIS IS MISSING** […] **WHAT IT NEEDS IS $\mathfrak c\ne0$**") so the sharpness clause of the record's most-cited lemma leans on a refuted result.

**3. The opposite argued.** The most charitable reading is that "L32's stabilizers" is shorthand for "stabilisers are proper subgroups, so orbits are positive-dimensional". L32 does not say that either, and no hypothesis the author might have meant repairs the mismatch of object. The load-bearing fact (that the orbit tangent is nonzero), comes entirely from the preceding clause about invariant vectors, and the multiplicity claim ($\mathop{\mathrm{mult}}(\tfrac12)\ge\dim\mathcal O>0$) is immediate from that clause alone.

**Consequence.** The sharpness conclusion **survives intact**; the repair owed is the deletion of the L32 citation, which is a non sequitur pointing at a refuted lemma. This is precisely the brief's "a hypothesis stated but never used" in its mirror form.

## 8. The invariant-vector step needs $SO(n)$, and gets it, withdrawn as a discrepancy

**Located.** "attained at every nonzero critical point because $\mathcal W_n$ carries no $O(n)$-invariant vector, **so the orbit is never a point**", and the same sentence again in the Scope paragraph.

**Why it is not quite the stated fact.** $O(n)$ is disconnected. "The orbit is not a point" follows from the $O(n)$ statement, but the quantity actually used is the orbit **tangent** $\mathcal L_AW$, whose vanishing for all $A\in\mathfrak{so}(n)$ says $W$ is $SO(n)$-invariant, a weaker conclusion than $O(n)$-invariance, so the $O(n)$ statement does not close it. A configuration $SO(n)$-invariant but not $O(n)$-invariant would have a two-point orbit and zero tangent.

**Argued the opposite, and it wins.** No such object exists: $\mathcal W_n$ is $SO(n)$-irreducible and nontrivial for $n\ge5$, and at $n=4$ it is $\mathcal W^+\oplus\mathcal W^-$ with each summand $\cong\mathrm{Sym}^2_0(\mathbb R^3)$, nontrivial and irreducible under $SO(3)$. The record concurs at [findings/second-order.md](../findings/second-order.md), "$\mathcal W_n$ is absolutely irreducible of real type **already under $SO(n)$** from $n=5$, with $n=4$ returning $2$ as a control".

**Withdrawn**, with the reason: step 2 of the protocol cannot be met, no object exhibits the failure, and the true $SO(n)$ statement is on the record one file away. Recorded so the next verifier does not spend an adjudication here.

## 9. The negative-$\theta$ scope: the refutation is right, and the surviving claim holds, with a citation defect

**The refutation of the sign-reversal claim is confirmed, and by exactly the reasoning the block gives.** $Q(-W)=(-W)^2+(-W)^\#=W^2+W^\#=Q(W)$, so $Q$ is even; $P(-W)=\langle-W,Q(W)\rangle=-P(W)$, so $P$ is odd and $\theta(-W)=-\theta(W)$. Hence

$$e(-W)=\frac{-W}{-\theta}=\frac W\theta=e(W),\qquad (-W)^\perp=W^\perp,$$

so $L_{e(-W)}\vert_{(-W)^\perp}$ and $L_{e(W)}\vert_{W^\perp}$ are **the same operator**, not merely operators with the same spectrum. **No witness of any kind can separate the sign**, exactly as the block says. Confirmed.

**The surviving claim (no local maximiser with $\theta<0$), closes too.** At a critical point take an orbit direction $z=\mathcal L_AW$; by §7, $L_Wz=\tfrac\theta2z$, so $z\in\ker B$ for $B=\tfrac\theta2\mathrm{Id}-L_W$, and the second-order coefficient along the chordal curve vanishes; the third vanishes by $T(z,z,z)=0$. [Lemma L51](../findings/second-order.md) records the chordal quartic coefficient as $-\tfrac92\langle L_Wz,z\rangle+\tfrac{15}8\theta$; at a unit $z$ on the null cone of $B$ this is $-\tfrac92\cdot\tfrac\theta2+\tfrac{15}8\theta=-\tfrac{18}8\theta+\tfrac{15}8\theta=-\tfrac38\theta$, which is the block's $-\tfrac38\theta\lVert z\rVert^4$ by quartic homogeneity. **The arithmetic closes exactly.** A local maximum needs it $\le0$, hence $\theta\ge0$, and $z\ne0$ by §8.

### The citation defect, in three steps

**1. Located.** The Scope paragraph cites L51 for the vanishing of the second and third coefficients and for the quartic value, in an argument whose entire purpose is the case $\theta<0$. **L51's Statement reads**: "let $W$ be a unit critical point of $P$ on the sphere with $Q(W)=\theta W$, **$\theta>0$**".

**2. The failure.** The lemma is applied at parameter values its own statement excludes. Nothing else on the record states these three facts without the sign hypothesis.

**3. The opposite argued, and it largely wins.** L51's *proof* of the three consumed facts is sign-free: $L_Wz=\tfrac\theta2z$ and $Bu=z\circ z$ come from differentiating equivariance, $T(z,z,z)=0$ from the fusion rule via self-adjointness of $B$, and the jet coefficients from the exact expansion. $\theta>0$ is consumed in L51 only for the final clause "at $\theta>0$ the fourth-derivative inequality is automatically strict" and for the $B\succeq0$ readings.

**Verdict: CONFIRMED AS ALGEBRA, with a hypothesis-citation defect.** The repair owed is one clause in L51's scope recording that the orbit identities and the exact jet hold at every $\theta\ne0$, not new mathematics, a statement of what its own proof already covers. Until that clause exists, the record's exclusion of the $\theta<0$ branch rests on a lemma cited outside its stated hypotheses.

## 10. FINDING, the file's criterion section still carries the claim the file refutes

**1. Located.** [findings/second-order.md](../findings/second-order.md) line 19, in the opening criterion section, the passage a reader meets before the canonical block:

> This is the one constraint on the unknown maximizer that no earlier attack imposed; every previous inequality was first-order. **The hypothesis $\theta>0$ is load-bearing, at $\mathfrak u(2)\subset\mathfrak{so}(4)$, $\theta=-0.866$ and the inequality reverses (Reviewer 27).**

**2. The failure.** This is verbatim the claim that the same file refutes fifty-one lines below, at line 70, in the quoted box the brief instructed me to check: "**The first version claimed the inequality reverses at $\mathfrak u(2)\subset\mathfrak{so}(4)$ with $\theta=-0.866$, and that is refuted three ways.**" The refutation is correct (§9). The earlier sentence carries no retraction, no cross-reference and no marker of any kind. It is wrong on all three counts the box names: the inequality does not reverse in any way a witness could see; the label $\mathfrak u(2)$ belongs to $W_{\mathbb{CP}^2}$ at $\theta=\pm\sqrt{3/2}$, not to $0.866$; and the $0.866$ point is a saddle, which §5 re-derives here in closed form.

**3. The opposite argued.** The most charitable reading is that line 19 means only "the *hypothesis* $\theta>0$ is load-bearing", which is true in the weak sense that dividing by $6\theta$ needs the sign. But the sentence does not stop there, it names an object, a value, a direction of failure and a source, and every one of those is refuted at line 70. There is no reading on which the em-dash clause survives.

**Consequence.** A reader who stops at the criterion section, which the file itself presents as the entry point, "what is here is the criterion in the context that produced it", takes away a refuted statement. This is a live defect in the most-cited block on the record, in the position most likely to be read.

## 11. Krasnov–Tkachev Proposition 6.6, read at source

Read from [kt-1801.00617.txt](https://arxiv.org/abs/1801.00617), §6, not from the notes.

**The hypotheses, by name.**

- *Metrised*: "$\langle xy;z\rangle=\langle x;yz\rangle$ for all $x,y,z\in A$" (their (48)). **Met** by $\mathcal W_n$ with $\circ$, this is §3's full symmetry of $T$.
- *Euclidean*: the form is positive definite. **Met**, the $\Lambda^2$ inner product.
- *Commutative*: automatic, "the trilinear form $u(x,y,z)$ is symmetric, hence the algebra $V(u)$ is always commutative". **Met**.
- *The algebra is $V(u)$ for a cubic form*: their $6u(x)=\langle x;x^2\rangle$ and $\langle xy;z\rangle=u(x,y,z)$. **Met with $u=P/6$**, and their product is exactly this record's $\circ$: $x^2=Q(x)$, so their idempotent normalisation $c=y/k$ with $y^2=ky$ is $c=W/\theta=e$ verbatim.
- **Unital: NOT a hypothesis of Proposition 6.6.** Nothing in §6.1 or §6.2 requires a unit; the proof uses only $c^2=c$, self-adjointness of $L_c$, and $D^2f(c)\le0$. **The trap that killed the other route does not bite here**, and [findings/fence-posts.md](../findings/fence-posts.md) line 189 already draws the line in the right place, "the extremal spectral bound […] which is this project's Lemma L24. The dividing line is exactly unitality". Confirmed against source. Unitality is a §4.2 hypothesis, and §4.2 is not what L24 imports.

**Their factor, re-derived, and it reproduces the record's.** Substituting $x=c$, $c^2=c$, $\langle c^2;c\rangle=\lVert c\rVert^2$ into their equation (56) gives numerator $2\lVert c\rVert^4L_c-\lVert c\rVert^4\mathrm{Id}-\lVert c\rVert^2\,c\otimes c$, hence

$$\tfrac13D^2f(c)=\frac{2L_c-\mathrm{Id}-(c\otimes c)/\lVert c\rVert^2}{\lVert c\rVert}\ \Longrightarrow\ D^2f(c)=6\theta\Big(L_e-\tfrac12\mathrm{Id}-\tfrac12P_e\Big),\qquad\lVert c\rVert=\theta^{-1},$$

which on $e^\perp=W^\perp$ is **exactly $6\theta(L_e-\tfrac12\mathrm{Id})$**. So the record's factor is confirmed a third time, from the source's own second derivative, and the notes' misprint finding (that the printed "$2L_c-1\le c\otimes c$" drops $\lVert c\rVert^{-2}$), is **independently confirmed**: it is the projector $P_c=(c\otimes c)/\lVert c\rVert^2$ that appears, and at $\lVert c\rVert=1/\theta<1$ the printed form fails at $y=c$.

## 12. FINDING, the notes misstate "extremal idempotent" as a local maximum

**1. Located.** [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md): "'Extremal idempotent' = the idempotent associated to a **local maximum** of $\langle x,x^2\rangle$ on the unit sphere (their (19); Tk 1901.02765 Prop 2.5)."

**2. The failure.** The source says global, twice. Definition 6.4: "An idempotent $c\in V(u)$ constructed in the course of proof of Proposition 6.3 will be called extremal", and that proof reads "Since $u$ is continuous as a function on $S$, it attains its **global maximum** value there". The paper then restates it: "the set of extremal idempotents coincide with the set of suitably normalized **global maximum** points of the (degree zero homogeneous) function $\langle x;x^2\rangle\langle x;x\rangle^{-3/2}$". **The very next consequence the same notes paragraph quotes ("extremal idempotents have the minimal possible norm among all idempotents"), is a global statement and is false for a merely local maximum**, so the paragraph is inconsistent with itself. Separately, the pointer "(their (19))" is wrong: equation (19) is the Euler–Jacobi syzygy $\sum_{c\in\mathrm{Idm}(A)}c/\chi_c(\tfrac12)=0$ in §4, unrelated to the definition, which is Definition 6.4.

**3. The opposite argued.** Krasnov–Tkachev's *proof* of 6.6 consumes only $D^2f(c)\le0$, which a local maximum supplies, so the proposition extends verbatim; and the notes cite Tkachev's survey Prop. 2.5, which I have not read and which may state the local form. **So the mathematics is unaffected.** What is affected is the attribution and the licence: the record applies L24 at points that are only *local* maxima, [Lemma L3](../findings/second-order.md)'s use, "no $S^2\times S^q$ is a local maximum", padded $W_{\mathbb{CP}^2}$ at $n=8,10,12$, and Proposition 6.6 **as stated** does not reach them. The record's own $\mathrm{Hess}\preceq0$ derivation does, which is one more reason the block is right to retain it. The repair owed is one clause in the notes: extremal is global in the source, and the local form is what this record's derivation supplies.

## 13. FINDING, a second misprint in Proposition 6.6, and the record silently repairs it

**1. Located.** [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) quotes the proposition verbatim and correctly: "for any extremal idempotent $c$ there holds $\sigma(c)\subset(-\infty,\tfrac12]$. In particular, $1$ is a simple eigenvalue of $L_c$."

**2. The failure, in the source's own terms.** The paper defines $\sigma(x)$ as "the set of (in general complex) roots of the characteristic equation $\chi_x(t)=0$ counting multiplicity […] the Peirce spectrum of $x$", over the **whole** algebra, and states three lines later: "Then $t=1$ is an obvious eigenvalue of $L_c$ (corresponding to $c$), **thus $1\in\sigma(c)$**." So under the paper's own convention $\sigma(c)\subset(-\infty,\tfrac12]$ is **false for every nonzero idempotent**, and self-contradictory with the proposition's own second sentence. The intended and proven statement is $\sigma(L_c\vert_{c^\perp})\subseteq(-\infty,\tfrac12]$, the proof establishes "$2L_c-1\le0$ **there**", on $c^\perp$.

**3. The opposite argued.** One could read $\sigma(c)$ in 6.6 as the Peirce spectrum on $c^\perp$ by local convention. Nothing in §6.2 announces such a change, and §2's definition is explicit and global; so this is a misprint in the same proposition as the $c\otimes c$ one, not a second convention.

**Consequence, and it is small but worth the line.** The record renders it correctly everywhere, [second-order.md](../findings/second-order.md), [fence-posts.md](../findings/fence-posts.md) and [bounds-relaxations.md](../findings/bounds-relaxations.md) all write $\sigma(L_c\vert_{c^\perp})$, so **no downstream claim is affected**. What is owed is one line in the notes recording that the "verbatim" quotation is internally inconsistent with the paper's p. 5 convention, so that a future reader who checks the quotation against the source does not conclude the record misquoted it.

## 14. The traps, answered by name

**$\ker W\ne0$.** *No finding.* Every step of L24 lives in $\mathcal W_n$ and none inspects $W$ as an operator on $\Lambda^2$: criticality, $e\circ e=e$, self-adjointness of $L_e$, the multiplier, and the division by $6\theta$ are all blind to $\ker W$. At a padded object the statement says exactly what it says at any other: $\iota W$ is critical in $\mathcal W_m$ with the same $\theta$ (conventions.md: "**Padding commutes with $Q$**, and preserves both the norm and $\theta$"), and the bound holds **if $\iota W$ is a maximiser in the larger space**, a hypothesis about $\mathcal W_m$, not about $\mathcal W_n$. That is the only padding hazard, and it is a hypothesis-checking duty on the consumer, not a defect here. Note the contrast with [ungraded-slack.md](../findings/ungraded-slack.md)'s $S(W)$, whose screen conventions.md marks vacuous at $\ker W\ne0$: **L24 has no such degeneracy**.

**The boundary of every stated range.** The smallest admissible dimension is $n=4$ ($\dim\mathcal W_n=\tfrac{n(n-3)(n+1)(n+2)}{12}=0$ at $n=3$, so the algebra is the zero algebra and $P\equiv0$, L24 vacuous, and Krasnov–Tkachev's Prop. 6.3 explicitly excludes it). At $n=4$ every step holds, and §5 exhibits the $n=4$ object that shows the maximiser hypothesis is not removable. **Odd $n$**: no step carries a parity; the odd/even split that afflicts $\Theta_n$ and $\theta_0(n)$ never enters, and the block correctly writes $\max_SP$ rather than $\Theta_n$ in its one numerical appeal. **$\theta=0$**: see §15.

**A claim proven on a subfamily and used in general.** *No finding.* L24 is proved for an arbitrary Euclidean metrised algebra, no diagonality, no gradedness, no symmetry assumption, no dimension. It is if anything the reverse case: a general claim whose *consumers* sometimes restrict it (to $\mathcal D_n$ at [diagonal-half.md](../findings/diagonal-half.md)), and those restrictions are flagged in place.

**A hypothesis stated but never used.** In the statement, none. In the argument, the L32 citation is the mirror defect, §7.

**A step using a hypothesis never stated.** Two, §15 (unit norm) and the unremarked need for $\theta\ne0$ before any sign question arises.

**A universal claim with no witness.** L24 is conditional, so the check is that no structured family supplies a maximiser violating it. Taking one from each family the record names: $W_{\mathbb{CP}^2}$ at $n=4$ is the global maximiser ($M(4)=\sqrt{3/2}$ by conventions.md) and sits at equality; padded $W_{\mathbb{CP}^2}$ is a local maximum and sits at equality; the sphere products $S^p\times S^q$ with $p,q\ge3$, $(p,q)\ne(3,3)$ attain $\tfrac12$ exactly on the orbit tangent; $S^3\times S^3$, $\mathbb{CP}^3$ at $n=6$, $S^2\times S^q$ for every $q$, the $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ subalgebra-Casimir point at $\theta=1.088948$, and $S^2\times S^2$ at $n=4$ all exceed $\tfrac12$ **and are all recorded as non-maxima**. *Every one of those figures except the last is a numerical datum on the record and is treated here as an open hypothesis, not as evidence.* The last is derived in closed form in §5, and it is consistent: it exceeds the bound and it is a saddle. **No family supplies a candidate falsifier.**

**An imported theorem whose hypotheses were never checked.** Checked by name in §11 (Krasnov–Tkachev: metrised ✓, Euclidean ✓, unital (**not required**), §12 (extremal = global, and the record uses local), §7 (L32), hypotheses not merely unchecked but inapplicable), §9 (L51, cited outside its stated $\theta>0$).

**Symbol collisions.** Checked against [conventions.md](../findings/conventions.md)'s table. $B$: L51 uses $B=\tfrac\theta2\mathrm{Id}-L_W$, the sense the table records, distinct from the Killing form and from [sym3-blocks.md](../findings/sym3-blocks.md)'s. $\Pi$: L51 uses sense (i), the projection onto $W^\perp$, which is the sense the corrector $\Pi u=u+\lVert z\rVert^2W$ requires. $\Phi$: L24's operator appears as sense (iii) at [diagonal-half.md](../findings/diagonal-half.md), correctly labelled. $A(\tfrac12)$: L51 writes $\ker B\cap W^\perp$ and conventions.md writes $\ker B$; these agree, because $L_W$ preserves $\mathbb RW$ and $BW=-\tfrac\theta2W\ne0$ at $\theta\ne0$, so $\ker B\subseteq W^\perp$ automatically. **The one collision that could change a number is $L_e$ against $L_W=\theta L_e$**: the bound is $\tfrac12$ for the first and $\tfrac\theta2$ for the second, and a citation that mixed them would be wrong by a factor $\theta$. Every citation I read uses the right one, [LEDGER.md](../findings/LEDGER.md) lines 818 and 831 and [diagonal-half.md](../findings/diagonal-half.md) line 145 all state the $\tfrac\theta2$ form against $L_W$. *No finding on collisions.*

## 15. The unstated unit-norm hypothesis

**1. Located.** "Let $W$ be a critical point with $\theta=P(W)>0$", in both the [results.md](../results.md) statement and the [second-order.md](../findings/second-order.md) one. Neither says $\lVert W\rVert=1$. The neighbouring [Lemma L125](../findings/second-order.md) does say it: "At a maximiser $W$ **of unit norm** with $\theta>0$".

**2. The failure, concretely.** Take a unit maximiser $W$ and put $W'=2W$. Read literally, the statement sets $\theta'=P(W')=8\theta$ and $e'=W'/\theta'=e/4$; then $e'\circ e'=Q(e)/16=e/16\ne e'$, so $e'$ is not idempotent, and the Riemannian Hessian of $P$ on the sphere of radius $2$ at $W'$ is $6L_{W'}-\tfrac{3P(W')}{4}\mathrm{Id}=12L_W-6\theta\,\mathrm{Id}$, whereas the claimed $6\theta'(L_{e'}-\tfrac12\mathrm{Id})$ is $6L_W-24\theta\,\mathrm{Id}$. **The identity is false at $\lVert W\rVert\ne1$ under the statement's own reading.**

**3. The opposite argued, and it wins.** [conventions.md](../findings/conventions.md) defines $\theta=P(W)/\lVert W\rVert^3$, so writing "$\theta=P(W)$" *is* an assertion of unit norm; and the same file defines "**'Critical point' is $Q(W)=\theta W$**, the first-order condition on $\{\lVert W\rVert=1\}$", which states it outright. The hypothesis is therefore carried by the conventions the statement is entitled to quote.

**Verdict: CONFIRMED, with a precision note rather than a defect.** Two clauses would remove all doubt and match the sibling lemma: "of unit norm" in the statement, and "on the tangent space" on the Hessian identity, the latter because as an operator on all of $\mathcal W_n$ the identity is false at $X=W$, where it returns $3\theta W$ while the Riemannian Hessian is not defined off $W^\perp$. [Lemma L125](../findings/second-order.md)'s own box already warns about exactly this reading: "**THE EQUALITY AT $Y=W$ CERTIFIES NOTHING.**"

## 16. $\theta=0$, and local against global

**$\theta=0$.** At a critical point with $\theta=0$ the element $e=W/\theta$ does not exist, so **L24 is not false there, it is undefined**, and its hypothesis $\theta>0$ excludes it cleanly. The gap is in the Scope paragraph rather than the lemma: its two sentences establish (i) $\theta>0$ automatically at a **global** maximiser, by $P$ odd and $\max_SP\ge\sqrt{3/2}$, and (ii) no **local** maximiser has $\theta<0$. Together these leave the branch "local maximiser with $\theta=0$" untouched, where the chordal quartic $-\tfrac38\theta\lVert z\rVert^4$ degenerates to $0$ and decides nothing. *This claim has no argument on file and I do not supply one:* **`HYPOTHESIS-DEBT`, that no local maximiser of $P$ on the unit sphere has $\theta=0$, or else that the Scope paragraph's "at a maximiser it is automatic" be read as global-only.** Nothing downstream appears to depend on it, since every consumer works at a point with a recorded positive $\theta$.

**Local against global.** L24's own derivation consumes only $\mathrm{Hess}\preceq0$, so it is a **local**-maximum theorem, and the record uses it that way. Its source, Proposition 6.6, is stated for global maxima (§12). The record's block is therefore right to keep its own derivation rather than lean on the attribution, and the word "maximizer" in the statement should be read as "local maximiser", which is the stronger and the intended reading. *No finding beyond §12's repair to the notes.*

## 17. The citation audit, 55 sites, the two named misuses

**A citation applying the bound at a mere critical point.** The pattern occurred and is **flagged in place**, at [findings/bounds.md](../findings/bounds.md) line 109: "**The premise was misread here, and that is a logical error rather than an overreach.** [Lemma L24](../findings/second-order.md) says *if $W$ is a maximizer then $\lambda_{\max}\le\tfrac12$*. This record used the conclusion as a fact about **critical points**". The same discipline appears at [second-order.md](../findings/second-order.md) line 1371 ("L24 gives $\Sigma\le\theta^2$ at maximisers; [I18](../plan.md) ranges over **pure critical points**") and at [ATTEMPTS.md](../ATTEMPTS.md) line 2985. **I found no live unflagged instance.** The citations that do invoke L24 at a non-maximiser invoke only the *Hessian identity* clause, which needs criticality alone, [route-a.md](../findings/route-a.md) line 213 and [second-order.md](../findings/second-order.md) lines 797 and 911 are all of this kind, and all are legitimate.

**A citation applying it off $W^\perp$.** Also occurred, also flagged, twice: [bounds-relaxations.md](../findings/bounds-relaxations.md) line 272 ("**LEMMA L24 IS APPLIED OUTSIDE ITS OWN SPACE.** Its cap lives on $\mathcal W_n\cap W^\perp$") and [diagonal-half.md](../findings/diagonal-half.md) line 153 ("**Lemma L24 needs $N\perp W$, and only the row sums were checked**"), with [ATTEMPTS.md](../ATTEMPTS.md) line 2897 recording the same for I12. **No live unflagged instance found.**

**The sharpness clause's reach.** Several sites quote L24 for "the orbit directions are exact $\tfrac12$-eigenvectors at *every* nonzero critical point" ([graded-half.md](../findings/graded-half.md) line 231, [LEDGER.md](../findings/LEDGER.md) line 897, [results.md](../results.md) line 242). That **is** what the block's sharpness paragraph claims, and §7 confirms it, with the one caveat that "nonzero critical point" should read "critical point with $\theta\ne0$", since $e$ does not exist otherwise. Small, and shared by the block itself.

## 18. What would falsify the statement, and what I did to look for it

**The object.** A local maximiser $W$ of $P$ on the unit sphere of $\mathcal W_n$, with $\theta=P(W)>0$, carrying some $Z\perp W$ with $\langle L_eZ,Z\rangle>\tfrac12\lVert Z\rVert^2$. Equivalently, and more usefully: any object at which the chain $\nabla P=3Q(W)$ → $\mu=\tfrac32\theta$ → $\mathrm{Hess}_S=6\theta(L_e-\tfrac12\mathrm{Id})$ breaks, which means either $\circ$ failing to be metrised on $\mathcal W_n$ (so that $\lambda_{\max}$ is not even defined), or a normalisation under which the constraint's contribution is not $-3\theta\,\mathrm{Id}$.

**What I did.** I re-derived the multiplier by two routes and matched both against Krasnov–Tkachev's own equation (56) evaluated at $c$, and the three agree exactly (§2, §11), the factor cannot be wrong by a normalisation, because the third route runs in the source's normalisation rather than this record's. I re-derived full symmetry of $T$ separately on the $W^2$ part and the $\#$ part (§3), which is where a metrised-algebra failure would have to live. I then tested the *statement* against one object from each structured family the record names (§14), and against the two edges the record most often falls off, $n=4$ with its self-dual splitting, where I constructed in closed form the eigenvector $Z=W^+-W^-$ at eigenvalue $1$ and confirmed it lies in $W^\perp$, and padded objects with $\ker W\ne0$, where no step of the argument sees the kernel. **The $n=4$ object is the closest thing to a falsifier that exists, and it is not one: it violates the bound and is a saddle, so it refutes the weakened statement at a critical point and confirms the stated one.** No candidate falsifier of L24 as stated survived.

## Verdict

**PROVEN, hypotheses corrected.**

The mathematics of Lemma L24 is correct: the Hessian identity, the bound, self-adjointness, the invariance of $W^\perp$, the simplicity of $1$, the splitting corollary, the sharpness repair and the negative-$\theta$ scope repair all close, and the Krasnov–Tkachev import's hypotheses are met, unitality among them by not being required. **The most heavily cited result on the record survives a cold attack intact.**

Four repairs are owed, none of them to the derivation:

1. **Delete the refuted sentence at [second-order.md](../findings/second-order.md) line 19**, it asserts what line 70 refutes, unmarked, in the section the file offers as its entry point. §10.
2. **Delete the citation of [Lemma L32](../findings/isotropy-cap.md) from the sharpness paragraph**, it names a theorem about bivector centralisers to support a claim about $\dim\mathfrak k(W)$, and that theorem is itself REFUTED AS STATED. The sharpness conclusion needs nothing from it. §7.
3. **Record in [Lemma L51](../findings/second-order.md)'s scope that its orbit identities and exact jet hold at every $\theta\ne0$**, L24's own Scope paragraph already consumes them at $\theta<0$, outside L51's stated hypothesis. §9.
4. **Correct two lines in [the Krasnov–Tkachev notes](../references/krasnov-tkachev-2018-idempotent-variety/notes.md)**, "extremal idempotent" is a *global* maximum in Definition 6.4 (and the pointer "(their (19))" is to an unrelated syzygy), and the verbatim $\sigma(c)\subset(-\infty,\tfrac12]$ contradicts the paper's own $1\in\sigma(c)$, a second misprint alongside the $c\otimes c$ one already on file. §12, §13.

And one debt, carried rather than repaired: **`HYPOTHESIS-DEBT`, no argument on file excludes a local maximiser with $\theta=0$**, where $e$ and hence the whole statement are undefined. The Scope paragraph closes $\theta<0$ and asserts $\theta>0$ at a *global* maximiser; the remaining branch is untouched. §16.
