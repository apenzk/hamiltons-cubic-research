# Verifier v162, Lemma L34, full support with two negative eigenvalues at $m=6$ and $m=8$

I read [BRIEF_L34.md](BRIEF_L34.md) cold and worked from [conventions.md](../findings/conventions.md) and the definitions the record quotes, rebuilding both exhibited objects by hand in an explicit coordinate frame before comparing them with what the block records. **No numerical work was done. No script, no Sage, no Python, no floating-point evaluation was run; every value below is exact, and the decimals are printed only to line up against the record's own printed decimals.** Log: [agent_logs/verify-L34-v162.log](../agent_logs/verify-L34-v162.log).

## Claim table

| # | claim, as written | verdict |
|---|---|---|
| 1 | **The canonical statement.** For $m=6$ and $m=8$ there is a $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues and $\dim U=m$ | **PROVEN** |
| 2 | $m=8$, orthogonal planes: spectrum $\{-1/\sqrt3\ (\times2),\ 1/(2\sqrt3)\ (\times4)\}$ and $\theta=-\sqrt3/2$ | **CONFIRMED, EXACT** |
| 3 | $m=6$, planes meeting in a 2-plane: spectrum $(-3,-1,1,1,1,1)/\sqrt{14}$ and $\theta=-1.030865$ | **CONFIRMED, EXACT**, the closed form is $\theta=-27\sqrt{14}/98$ |
| 4 | $\mathop{\mathrm{tr}}W^\#=-\lVert W\rVert^2$ at both witnesses | **CONFIRMED, EXACT**, $-12$ and $-14$ |
| 5 | "Both defining conditions are linear, so the sum is a $\mathrm{Weyl}_m$ element whatever the planes do" | **HOLDS**, with one unstated step: that padding preserves membership |
| 6 | "each summand contributes exactly one negative eigenvalue" as the reason the sum has exactly two | **NON SEQUITUR at the $m=6$ witness**; the conclusion holds, by the exhibited spectrum |
| 7 | "the support is the union of the planes" as the reason $\dim U=m$ | **NON SEQUITUR**; the conclusion holds, by a reason the block does not give |
| 8 | $q,r>0$; $q=r$; the choice of self-dual direction at $m=6$ | **HYPOTHESES USED AND NEVER STATED**, supplied in §6 |
| 9 | "Why the recorded equivalence fails", the displayed Ricci identity and both inferences | **CORRECT** |
| 10 | The refutation: L34 kills the descent statement B0 rested on | **HOLDS at $m=6,8$**; [L30](../findings/stratum-two-negative.md) itself is untouched |
| 11 | "[isotropy-cap.md](../findings/isotropy-cap.md) records $+0.6259$ for the same family, a conflict this block does not resolve" | **NO CONFLICT EXISTS**, the two figures are different quantities |
| 12 | Landscape bullet: "In general position they reach $\theta=+0.485$" | **BROKEN**, contradicted by three of the record's own figures |
| 13 | $+0.485408612$ and $+0.115574271$, marked *measured, not derived* | **HYPOTHESIS-DEBT**, no argument on file |
| 14 | "the construction is silent at $m\ge10$" | **CORRECT**, and understated: it is also silent at $m=5,7$, where $m=7$ is inside its reach |
| 15 | [isotropy-cap.md](../findings/isotropy-cap.md): orthogonal planes are "the special shape both recorded witnesses happen to have" | **BROKEN**, false of the $m=6$ witness, whose planes overlap and whose summands pair to $1$ |
| 16 | $\ker W\ne0$ at both witnesses | **CHECKED, HARMLESS**, every step survives it |
| 17 | Symbol collisions: $U$, $N$, $q$, $r$ | **THREE LIVE**, one of them inside the same file |

## One-line summary

**The existence statement is true and both exhibited objects are exactly as recorded, I rebuilt each in closed form and reproduced both spectra, both $\theta$ values and both $\mathop{\mathrm{tr}}W^\#$, while two of the three reasons the construction paragraph gives are non sequiturs whose conclusions happen to hold, three hypotheses the construction uses are stated nowhere, the "conflict" the block records against [isotropy-cap.md](../findings/isotropy-cap.md) does not exist, and the landscape bullet's $+0.485$ is contradicted by the record's own figures.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md) rather than restated.

- $\mathcal W_n$ is "the space of algebraic Weyl curvature operators on $\mathbb R^n$"; $N$ is "$\binom n2=\dim\Lambda^2\mathbb R^n$".
- $Q(W)$ is "Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself"; $P(W)$ is "the cubic form $\langle W,Q(W)\rangle$"; $\theta$ is "$P(W)/\lVert W\rVert^3$".
- $T$, third sense: "the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$", and the $\circ$ product is "$X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$".
- "$\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$".
- "**The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.** The inner product is $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix."
- "A bivector's norm, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal".
- "$W$ is the operator on $\Lambda^2$, where $\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}(W^2)=1$."
- "**Padding commutes with $Q$**, and preserves both the norm and $\theta$. The stratum reduction turns on this."
- "**Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**… so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide."
- $\mathfrak m$: "**$\mathfrak m$ carries three incompatible senses across the record**, this one, [Lemma L36](../findings/isotropy-cap.md)'s whole negative eigenspace, and [target.md](../findings/target.md)'s symmetric-pair odd part, so read it from context." The refuted B0 statement uses the second.
- $\Theta_6=\theta_0(6)$ from "$\theta_0(n)^2=2(n-1)(n-2)/n^2$", and $M(n)$ is "**the global maximum** of $P$ on the unit sphere of $\mathcal W_n$… $M=\sqrt{3/2}$ against $\Theta_4=0.866$ and $\Theta_6=1.0541$".

Two objects the statement needs are **not** in that file and are quoted from where the record does define them:

- $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, [stratum-two-negative.md:31](../findings/stratum-two-negative.md).
- $W_4(q,r)=-(q+r)\,w_1\otimes w_1+q\,w_2\otimes w_2+r\,w_3\otimes w_3$, which "lies in $\mathrm{Weyl}_4$ with signature $(2,1)$ and a full-rank minority eigenvector; its negative is the B0 base-case family at $\theta=+\sqrt{3/2}$", [isotropy-cap.md:343](../findings/isotropy-cap.md), repeated at [stratum-two-negative.md:166](../findings/stratum-two-negative.md).
- $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$ is defined inline in the statement itself and, identically, inside [Lemma L30](../findings/stratum-two-negative.md)'s block, with the eigenvalues ordered $\lambda_1\ge\dots\ge\lambda_N$.

## 1. Hypothesis inventory

**A pass with no inventory is not a pass, so here is the whole of it.**

### 1a. What the statement asserts, and what it needs

| item | what it requires | is it stated in the block? | is it used? |
|---|---|---|---|
| $W\in\mathrm{Weyl}_m$ | symmetry as an operator on $\Lambda^2\mathbb R^m$ with the pair symmetries, first Bianchi, Ricci-flatness, three linear conditions | asserted, argued from linearity | yes |
| "exactly two negative eigenvalues" | the count of negative eigenvalues of $W$ as an operator on $\Lambda^2\mathbb R^m$, with multiplicity | stated | yes |
| $\dim U=m$ | $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$, $N=\binom m2$, images of the two bottom eigenvectors read as skew $m\times m$ matrices | stated | yes |
| $m\in\{6,8\}$ | two 4-planes must span $\mathbb R^m$ | stated | yes |

The statement is **purely existential**, there are no antecedent hypotheses on $W$ to check, only two objects to exhibit. So the whole burden is that the two exhibited objects satisfy every clause, which §2 and §3 discharge.

### 1b. What the construction needs and does not say

| needed | where the record has it | in L34's block? |
|---|---|---|
| $q>0$ and $r>0$ | [stratum-two-negative.md:31](../findings/stratum-two-negative.md), "for every $q,r>0$" | **no** |
| padding a $\mathrm{Weyl}_4$ element into $\mathbb R^m$ lands in $\mathrm{Weyl}_m$ | [conventions.md](../findings/conventions.md), "Padding commutes with $Q$"; [lean/INDEX.md](../lean/INDEX.md) row L34 | **no**, the block argues only that the *sum* of two members is a member |
| $q=r$, without which neither recorded spectrum comes out | nowhere | **no** |
| the alignment of the two negative self-dual directions at $m=6$ | nowhere | **no** |
| the negative eigenvector of each summand is a **complex structure**, so its image is the whole 4-plane | [lean/INDEX.md](../lean/INDEX.md) row L34, [L34k.lean](../lean/HamiltonsCubic/Results/L34k.lean) | **no**, and this is the only thing that delivers $\dim U=m$ |

### 1c. Every result imported, and whether its hypotheses were checked against the object

| imported | its hypotheses | met? |
|---|---|---|
| [L33](../findings/stratum-two-negative.md), one eigenvalue of one sign forces $W=0$ | a **one-dimensional** eigenspace on one side, "exactly one eigenvalue counted *with multiplicity*", the eigenvector not a complex-structure multiple on a 4-plane | **Deliberately not met, and that is the point.** L34's witnesses have a two-dimensional negative eigenspace at $m=8$ and two distinct negative eigenvalues at $m=6$, so both sit outside L33's hypothesis. L34 constrains L33's *reading* (it shows the hypothesis is not vacuous restriction), without contradicting it. L33 survives intact. |
| $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ | none beyond $n=4$ | met |
| $W_4(q,r)$ has signature $(2,1)$ | $q,r>0$ | met at $q=r=1$, unstated |
| [L31](../findings/stratum-two-negative.md), the bracket cap characterised | orthonormal $X,Y$ with $\lVert[X,Y]\rVert^2=2$ iff both rank $4$, singular values $1/\sqrt2$, images agree | **not imported by the block**, but it is satisfied by the self-dual pairs I use, and §3 records that as an independent cross-check |
| [L30](../findings/stratum-two-negative.md), the descent at $\dim U<n$ | $\dim U<n$ | **not met at either witness, which is exactly what L34 exhibits.** L30 is conditional and is untouched; what L34 refutes is the claim that its hypothesis always holds in the two-negative stratum. |

**No hypothesis is stated and left unused.** Both defects run the other way: hypotheses used and not stated (row 1b).

## 2. The $m=8$ witness, rebuilt cold

Take $V_1=\langle e_1,e_2,e_3,e_4\rangle$ and $V_2=\langle e_5,e_6,e_7,e_8\rangle$, orthogonal 4-planes of $\mathbb R^8$. Write $\varphi_{ab}=E_{ab}-E_{ba}$, so $\lVert\varphi_{ab}\rVert^2=\tfrac12\mathop{\mathrm{tr}}(\varphi^{\mathsf T}\varphi)=1$ and $\{\varphi_{ab}\}_{a<b}$ is orthonormal, as [conventions.md](../findings/conventions.md) fixes. The self-dual basis of $\Lambda^+(V_1)$ is

$$a=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34}),\qquad c=\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24}),\qquad d=\tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23}),$$

each of unit norm, and $b,c',d'$ the same on $V_2$ with indices $5,6,7,8$.

### 2a. The bracket relation, and its check against L31

From $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$,

$$[a,c]=\tfrac12\big([\varphi_{12},\varphi_{13}]-[\varphi_{12},\varphi_{24}]+[\varphi_{34},\varphi_{13}]-[\varphi_{34},\varphi_{24}]\big)=\tfrac12\big(-\varphi_{23}-\varphi_{14}-\varphi_{14}-\varphi_{23}\big)=-\sqrt2\,d,$$

so $\lVert[a,c]\rVert^2=2$ and the triple $\{a,c,d\}$ is an $\mathfrak{su}(2)$ with all three brackets of squared norm $2$. That reproduces the record's "every orthonormal pair there brackets to norm-squared $2$" and it satisfies [L31](../findings/stratum-two-negative.md)'s equality characterisation exactly: $a$ and $c$ anticommute, both have rank $4$ with all four singular values $1/\sqrt2$, and $\mathrm{im}\,a=\mathrm{im}\,c=V_1$.

### 2b. The summand, its $\#$, and its $P$

Take $q=r=1$, so $W_1=-2\,aa^{\mathsf T}+cc^{\mathsf T}+dd^{\mathsf T}$ on $\Lambda^2V_1$ and zero elsewhere. Using $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$ and summing over **ordered** pairs,

$$W_1^\#=2\lambda_a\lambda_c\,dd^{\mathsf T}+2\lambda_c\lambda_d\,aa^{\mathsf T}+2\lambda_d\lambda_a\,cc^{\mathsf T}=-4\,dd^{\mathsf T}+2\,aa^{\mathsf T}-4\,cc^{\mathsf T}.$$

Then $\mathop{\mathrm{tr}}W_1^\#=-4+2-4=-6=-\lVert W_1\rVert^2$, which is the record's $\mathop{\mathrm{tr}}(W^\#)=-\lVert W\rVert^2$, an independent confirmation that the padded $W_4(1,1)$ really is in $\mathcal W_m$, since that identity holds "because $Q$ preserves the trace-free Weyl space". And

$$P(W_1)=\mathop{\mathrm{tr}}W_1^3+\langle W_1,W_1^\#\rangle=(-8+1+1)+\big((-2)(2)+(1)(-4)+(1)(-4)\big)=-6-12=-18,$$

against $\lVert W_1\rVert^3=6^{3/2}$, giving $\theta(W_1)=-18/6^{3/2}=-\sqrt{3/2}$. That is the record's "its negative is the B0 base-case family at $\theta=+\sqrt{3/2}$", confirmed independently: $W_4(1,1)=-W_{\mathbb{CP}^2}$ padded.

### 2c. The sum

$\Lambda^2V_1\perp\Lambda^2V_2$, since no basis bivector has indices in both planes, so $\langle W_1,W_2\rangle=0$ and $\lVert W\rVert^2=6+6=12$. The spectrum is the union of the two: $\{-2,-2,1,1,1,1\}$ together with $22$ zeros in the remaining $28-6$ dimensions of $\Lambda^2\mathbb R^8$. Normalising by $\sqrt{12}$,

$$\mathop{\mathrm{spec}}(W)/\lVert W\rVert=\{-2/\sqrt{12}\ (\times2),\ 1/\sqrt{12}\ (\times4)\}=\{-1/\sqrt3\ (\times2),\ 1/(2\sqrt3)\ (\times4)\}. \qquad\textbf{Confirmed.}$$

Norm check: $2\cdot\tfrac13+4\cdot\tfrac1{12}=\tfrac23+\tfrac13=1$. Trace check: $-2/\sqrt3+4/(2\sqrt3)=0$.

$P$ is additive here. $W_1^2$ and $W_1^\#$ are both supported on $\Lambda^2V_1$ (the second because $\mathfrak{so}(V_1)$ is a subalgebra, so every bracket stays inside), hence $\langle Q(W_1),W_2\rangle=0$ and likewise with the roles swapped, so $P(W)=P(W_1)+P(W_2)=-36$ and

$$\theta=\frac{-36}{12^{3/2}}=\frac{-3}{\sqrt{12}}=-\frac{\sqrt3}{2}.\qquad\textbf{Confirmed, exactly.}$$

$\mathop{\mathrm{tr}}W^\#$: $[\mathfrak{so}(V_1),\mathfrak{so}(V_2)]=0$ so $W_1\#W_2=0$, and $\mathop{\mathrm{tr}}W^\#=-6-6=-12=-\lVert W\rVert^2$. **Confirmed.**

### 2d. $\dim U=8$, checked rather than taken on trust

$-1/\sqrt3$ has multiplicity $2$, so $v_{27},v_{28}$ are merely *some* orthonormal basis of $\mathrm{span}(a,b)$ and the claim must survive every choice. $a$ is a complex structure on $V_1$: as a skew matrix it is $\tfrac1{\sqrt2}$ times a block-diagonal pair of $2\times2$ rotations on $\{e_1,e_2\}$ and $\{e_3,e_4\}$, hence invertible on $V_1$ and $\mathrm{im}\,a=V_1$; likewise $\mathrm{im}\,b=V_2$. Any $\alpha a+\beta b$ with both coefficients nonzero is block-diagonal with all four blocks nonzero, hence of rank $8$. So for any basis $\{v_{27},v_{28}\}$ of the eigenplane, either one member already has full image, or the pair is $\{a,b\}$ up to scale and $\mathrm{im}\,a+\mathrm{im}\,b=V_1\oplus V_2$. **$U=\mathbb R^8$ in every case.** $\dim U=8=m$. **Confirmed.**

## 3. The $m=6$ witness, rebuilt cold

Take $V_1=\langle e_1,e_2,e_3,e_4\rangle$ and $V_2=\langle e_3,e_4,e_5,e_6\rangle$, meeting in the 2-plane $\langle e_3,e_4\rangle$. With the order-preserving identification of each plane with $\mathbb R^4$,

$$a=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34}),\quad c=\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24}),\quad d=\tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23}),$$
$$b=\tfrac1{\sqrt2}(\varphi_{34}+\varphi_{56}),\quad c'=\tfrac1{\sqrt2}(\varphi_{35}-\varphi_{46}),\quad d'=\tfrac1{\sqrt2}(\varphi_{36}+\varphi_{45}).$$

### 3a. The overlap, in closed form

Reading off coefficients in the orthonormal $\{\varphi_{ij}\}$: the only nonzero pairing between the two triples is

$$\langle a,b\rangle=\tfrac12\langle\varphi_{12}+\varphi_{34},\ \varphi_{34}+\varphi_{56}\rangle=\tfrac12,$$

every other cross pairing being zero. So $\Lambda^+(V_1)$ and $\Lambda^+(V_2)$ meet only at $0$, and their correlation matrix in these bases is $\mathop{\mathrm{diag}}(\tfrac12,0,0)$.

### 3b. The spectrum

With $q=r=1$ on both planes, $W=W_1+W_2$ with $W_1=-2aa^{\mathsf T}+cc^{\mathsf T}+dd^{\mathsf T}$ and $W_2=-2bb^{\mathsf T}+c'c'^{\mathsf T}+d'd'^{\mathsf T}$. Since $c,d,c',d'$ are mutually orthonormal and orthogonal to $S:=\mathrm{span}(a,b)$, the operator splits: eigenvalue $1$ on each of $c,d,c',d'$, and $-2(aa^{\mathsf T}+bb^{\mathsf T})$ on $S$. For unit $a,b$ with $\langle a,b\rangle=\tfrac12$, the vectors $a\pm b$ are eigenvectors of $aa^{\mathsf T}+bb^{\mathsf T}$ with eigenvalues $1\pm\tfrac12$, so $-2(aa^{\mathsf T}+bb^{\mathsf T})$ has eigenvalues $-3$ and $-1$. Hence

$$\mathop{\mathrm{spec}}(W)=\{-3,-1,1,1,1,1\}\ \cup\ \{0^{\times9}\}\ \text{ in }\ \Lambda^2\mathbb R^6\ (\dim 15).$$

$\lVert W\rVert^2=9+1+4=14$, so normalised the spectrum is $(-3,-1,1,1,1,1)/\sqrt{14}$. **Confirmed.** Trace $-3-1+4=0$; norm $14/14=1$.

The norm is also reachable the other way, which is a cross-check on $\langle a,b\rangle$: $\lVert W_1+W_2\rVert^2=6+6+2\langle W_1,W_2\rangle$ with $\langle W_1,W_2\rangle=\mathop{\mathrm{tr}}(W_1W_2)=(-2)(-2)\langle a,b\rangle^2=1$, giving $14$.

### 3c. $\theta$, in closed form

The cross terms are live here, so I compute them. $W_1^2=4aa^{\mathsf T}+cc^{\mathsf T}+dd^{\mathsf T}$ and, from §2b, $W_1^\#=2aa^{\mathsf T}-4cc^{\mathsf T}-4dd^{\mathsf T}$. Since $c,d\perp\mathop{\mathrm{supp}}W_2$ and $\langle a,W_2a\rangle=-2\langle a,b\rangle^2=-\tfrac12$,

$$\langle W_1^2,W_2\rangle=4\big(-\tfrac12\big)=-2,\qquad \langle W_1^\#,W_2\rangle=2\big(-\tfrac12\big)=-1,\qquad \langle Q(W_1),W_2\rangle=-3.$$

The configuration is invariant under the involution $e_1\leftrightarrow e_5,\ e_2\leftrightarrow e_6$ fixing $e_3,e_4$, which sends $a\mapsto b$, $c\mapsto-c'$, $d\mapsto-d'$ and so exchanges $W_1$ and $W_2$; the direct computation gives the same, $\langle W_2^2,W_1\rangle=-2$ and $\langle W_2^\#,W_1\rangle=-1$. Therefore

$$P(W)=P(W_1)+P(W_2)+3\langle Q(W_1),W_2\rangle+3\langle Q(W_2),W_1\rangle=-18-18-9-9=-54,$$

$$\theta=\frac{-54}{14^{3/2}}=-\frac{27}{7\sqrt{14}}=-\frac{27\sqrt{14}}{98}=-1.0308648\ldots$$

which is the record's $-1.030865$ to every printed digit. **Confirmed, exactly, and the closed form $-27\sqrt{14}/98$ is new to the record, the block prints only the decimal.**

$\mathop{\mathrm{tr}}W^\#$: polarising $\mathop{\mathrm{tr}}(X^\#)=-\lVert X\rVert^2$ gives $\mathop{\mathrm{tr}}(X\#Y)=-\langle X,Y\rangle$, so $\mathop{\mathrm{tr}}W^\#=-6-6+2(-1)=-14=-\lVert W\rVert^2$. **Confirmed.**

### 3d. $\dim U=6$

Here $-3$ and $-1$ are simple, so $v_{15}\propto a+b$ and $v_{14}\propto a-b$ are canonical. As skew matrices,

$$a+b=\tfrac1{\sqrt2}\big(\varphi_{12}+2\varphi_{34}+\varphi_{56}\big),\qquad a-b=\tfrac1{\sqrt2}\big(\varphi_{12}-\varphi_{56}\big).$$

$a+b$ is block-diagonal with all three $2\times2$ blocks nonzero, hence rank $6$ and $\mathrm{im}(a+b)=\mathbb R^6$ on its own. So $\dim U=6=m$, with $\mathrm{im}(a-b)=\langle e_1,e_2,e_5,e_6\rangle$ contributing nothing further. **Confirmed.**

### 3e. A screen, reported as a screen

$-W$ at $m=6$ lies in $\mathrm{Weyl}_6$ with $\theta=+1.0308648$, which must sit below $M(6)=\sqrt{3/2}=1.2247\ldots$ and below nothing else; it does, and it also sits below $\Theta_6=1.0541$. Nothing here is offered as evidence for a positive claim; it is a consistency screen on the arithmetic and it passes.

## 4. "Both defining conditions are linear", the argument, and what it leaves out

**The two conditions are first Bianchi and Ricci-flatness**, alongside the pair symmetries that make $W$ an operator on $\Lambda^2$ at all. First Bianchi is $\mathrm{Alt}(W)=0$, and [conventions.md](../findings/conventions.md) fixes $\mathrm{Alt}$ as "the ORTHOGONAL PROJECTION of $S^2(\Lambda^2)$ onto $\Lambda^4$", a linear map, so its kernel is a subspace. Ricci-flatness is $\mathrm{Ric}(W)=0$ with $\mathrm{Ric}$ "the adjoint of $\cdot\wedge\mathrm{id}$", again linear. So $\mathrm{Weyl}_m$ is a linear subspace and is closed under addition **with no hypothesis relating the summands**, which is precisely what "whatever the planes do" needs. **The argument is complete for what it argues, and both conditions are linear in the sense used.**

**What it does not argue is that each padded summand is in $\mathrm{Weyl}_m$ to begin with.** That is a separate fact and it is not in the block. It is one line: extending $W_{ijkl}$ by zero outside $V$, first Bianchi holds because all four indices lie in $V$ or all three terms vanish, and $\widetilde{\mathrm{Ric}}_{ik}=\sum_j\widetilde W_{ijkj}$ is the $V$-internal Ricci when $i,k\in V$ and zero otherwise. The record has it at [conventions.md](../findings/conventions.md) ("Padding commutes with $Q$") and at [lean/INDEX.md](../lean/INDEX.md) row L34, machine-checked. **Recorded as an unstated step, not a defect.** I independently confirmed it holds for these objects in §2b, where the padded $W_4(1,1)$ satisfies $\mathop{\mathrm{tr}}W_1^\#=-\lVert W_1\rVert^2$.

## 5. The two non sequiturs

### 5a. "each summand contributes exactly one negative eigenvalue"

**Located.** [stratum-two-negative.md:380](../findings/stratum-two-negative.md), the construction paragraph, offered as the reason the sum has exactly two.

**The failure, concretely.** The inference is valid only when the two summands are Frobenius-orthogonal, which is exactly what the $m=6$ witness is not: §3a gives $\langle a,b\rangle=\tfrac12$ and §3b gives $\langle W_1,W_2\rangle=1\ne0$. At that witness the two negative directions genuinely mix, neither $-3$ nor $-1$ is an eigenvalue of either summand, and neither eigenvector lies in either summand's support. The eigenvalues $-2,-2$ of the two summands become $-3,-1$ in the sum. **So no eigenvalue of the sum is "contributed by" a summand at the very witness the sentence is written to cover.**

**The most charitable reading.** Read as "each summand *has* exactly one negative eigenvalue" the premise is true (given $q,r>0$), and the inference to "at most two" then goes through by a real argument the block does not give: writing $W_i=N_i+P_i$ with $N_i$ rank-one negative definite and $P_i$ positive semidefinite, $W=(N_1+N_2)+(P_1+P_2)$ with $N_1+N_2$ negative semidefinite of rank at most $2$, so $n_-(W)\le n_-(N_1+N_2)+n_-(P_1+P_2)\le2$. **That gets "at most two" in general and never "exactly two".** Exactness has to be read off a spectrum, and both spectra are printed in the same sentence, so the statement is safe.

**Verdict: the reason is a non sequitur at the $m=6$ witness; the conclusion holds by the exhibited spectra.** Repair is one clause: replace it with "the negative parts sum to a rank-$\le2$ negative semidefinite operator, so $n_-\le2$; the exhibited spectra give equality".

### 5b. "the support is the union of the planes", offered where $\dim U=m$ is needed

**Located.** Same sentence. The block's only support for $\dim U=m$.

**The failure, concretely.** The support of $W$ and $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$ are different objects, and $U\subseteq\mathop{\mathrm{supp}}W$ can be strict. **The record carries the witness in the same file**: [stratum-two-negative.md:212](../findings/stratum-two-negative.md) exhibits $\mathrm{pad}_{V_1}(W_{\mathbb{CP}^2})+\mathrm{pad}_{V_2}(W_{\mathbb{CP}^2})$ on $\mathbb R^8$ (the sign-flip of L34's own $m=8$ object), whose support is all of $\mathbb R^8$ while "$U$ built from two of them has $\dim U=4<8$". So "support $=$ union of planes" demonstrably does not deliver $\dim U=m$.

Two secondary points on the same phrase: the union of two planes is not a subspace, and what is meant is their **span**; and $N$ is $\binom m2$ here while [conventions.md](../findings/conventions.md) tables $N=\binom n2$, so the statement runs its index convention in $n$ while its dimension is $m$.

**The most charitable reading.** With **exactly** two negative eigenvalues, $U$ is the sum of the images of the whole negative eigenspace, and one can ask whether that forces $U=\mathop{\mathrm{supp}}W$. It does not follow from the block's sentence either way; what actually delivers it is that each summand's negative eigenvector is a self-dual form on its 4-plane, hence a complex structure, hence invertible on that plane. **That reason exists on the record, [lean/INDEX.md](../lean/INDEX.md) row L34, "the negative eigenvector is a complex structure, so `-a` inverts it and it has no kernel, hence its image is the whole 4-plane", and it is not in the block.** The same row records "Also owed: `dim U = m` and the `θ` values".

**Verdict: the reason is a non sequitur; the conclusion holds, and I verified it directly at both witnesses in §2d and §3d.** Repair is one clause.

## 6. The three unstated hypotheses, and what the block's phrasing over-claims

**$q,r>0$.** Without it $W_4(q,r)$ need not have signature $(2,1)$: at $q>0>r$ with $q+r>0$ the signature is $(1,2)$ and each summand carries two negative eigenvalues, so the count fails. The block never says it; [stratum-two-negative.md:31](../findings/stratum-two-negative.md) does, thirty-eight lines above L33's block and three hundred above L34's.

**$q=r$.** Neither recorded spectrum comes out at a general $(q,r)$: the four positive eigenvalues at $m=6$ are $q_1,r_1,q_2,r_2$ and the recorded value is $1,1,1,1$. The block prints spectra it can only get at $q=r$ and never names the parameter.

**The alignment at $m=6$, and here the block's phrasing is over-claimed.** "Planes meeting in a 2-plane at $m=6$ give $(-3,-1,1,1,1,1)/\sqrt{14}$" reads as a universal over such configurations, and it is false as one. At $q=r$ each summand is fixed by its negative self-dual direction alone, and §3a shows the overlap of the two directions ranges over $[-\tfrac12,\tfrac12]$. The recorded spectrum is the endpoint $+\tfrac12$. **A closed-form counterexample at the other extreme:** keep $W_1=-2aa^{\mathsf T}+cc^{\mathsf T}+dd^{\mathsf T}$ but let the second copy be negative on $c'$ instead, $W_2'=-2c'c'^{\mathsf T}+bb^{\mathsf T}+d'd'^{\mathsf T}$. Then $S=\mathrm{span}(a,b)$ carries $-2aa^{\mathsf T}+bb^{\mathsf T}$, whose matrix in the orthonormal basis $\{a,\ 2(b-\tfrac12a)/\sqrt3\}$ is $\begin{pmatrix}-7/4&\sqrt3/4\\\sqrt3/4&3/4\end{pmatrix}$, with trace $-1$ and determinant $-3/2$, hence eigenvalues $(-1\pm\sqrt7)/2$. The full spectrum is $\{-2,\ (-1-\sqrt7)/2,\ (-1+\sqrt7)/2,\ 1,1,1\}$, of squared norm $11$, still with **exactly two negative eigenvalues** but not the recorded spectrum.

So the statement survives, the recorded spectrum is realised by the order-preserving identification of each plane with $\mathbb R^4$, which is the obvious reading and the one I used, but **the sentence asserts of every such pair of planes what holds of one alignment**. That is this record's own listed trap, a claim proven on a subfamily and stated in general, running here in the direction that costs the block precision rather than truth.

## 7. "Why the recorded equivalence fails", the displayed identity checked

**The identity.** In an eigenbasis $W=\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}$ on $\Lambda^2$, the Ricci contraction is $\mathrm{Ric}(W)_{ik}=\sum_j W_{ijkj}=\sum_\alpha\lambda_\alpha\sum_j(v_\alpha)_{ij}(v_\alpha)_{kj}=\big(\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}\big)_{ik}$, each $v_\alpha v_\alpha^{\mathsf T}=-v_\alpha^2$ positive semidefinite. So Ricci-flatness is $\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=0$, and with exactly two negatives $-b,-c$ at $y=v_{N-1}$, $z=v_N$ this is

$$\sum_{\lambda_\alpha>0}\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=b\,yy^{\mathsf T}+c\,zz^{\mathsf T}.\qquad\textbf{The displayed identity is correct.}$$

It also reproduces the file's own one-positive form $\lambda_1v_1v_1^{\mathsf T}=a\,v_2v_2^{\mathsf T}+b\,v_3v_3^{\mathsf T}$ at [stratum-two-negative.md:33](../findings/stratum-two-negative.md), which is a second anchor on the sign and the normalisation.

**The one-positive inference.** All terms positive semidefinite, so the image of a sum is the sum of images: $\mathrm{im}\,v_1=\mathrm{im}(byy^{\mathsf T}+czz^{\mathsf T})=\mathrm{im}\,y+\mathrm{im}\,z=U$. **Equality, not merely containment, the block's "forces $U=\mathrm{im}\,v_1$" is right.** Then $\dim U=m$ gives $v_1$ of full rank, the positive eigenspace is one-dimensional, and a full-rank bivector on $\mathbb R^m$ with $m\ge6$ is no complex-structure multiple on a 4-plane, so [L33](../findings/stratum-two-negative.md) applies and gives $W=0$. **Correct, and L33's hypotheses are met at that reading.**

**The several-positives inference.** "Constrains no rank at all" is slightly loose: the identity still says the span of the positive eigenvectors' images equals $U$. What it no longer does is constrain any **single** eigenvector's rank, which is what the rank-3 question needed, and that is plainly what the sentence means. **Both witnesses make it concrete**: at $m=8$ the four positive eigenvectors $c,d,c',d'$ each have rank $4$, none is nondegenerate, and yet $\dim U=8$. **The claim is correct as intended; the phrase would read better as "constrains no eigenvector's rank".**

## 8. What is refuted, and what survives, stated exactly

**Refuted.** The statement [plan.md](../plan.md) recorded B0 as closing iff (*no element of $\mathrm{Weyl}_m$ with $\dim\mathfrak m\le2$ has $\dim U=m$*), is **false at $m=6$ and $m=8$**, by the two objects rebuilt above. Since it was recorded as a universal over $m$, one dimension suffices to refute it, and there are two. ($\mathfrak m$ here is [isotropy-cap.md](../findings/isotropy-cap.md)'s sense, the whole negative eigenspace; [conventions.md](../findings/conventions.md) warns the letter carries three.)

**Also refuted:** the recorded *equivalence* of that statement with the rank-3 question. §7 shows the equivalence holds at one positive eigenvalue and fails beyond it.

**Untouched, and the block does not claim otherwise.**

- **[L33](../findings/stratum-two-negative.md) stands.** L34's witnesses sit outside its hypothesis, not against its conclusion. [LEDGER.md:997](../findings/LEDGER.md) records the same reading, and that L34's role in the L33 repair is corroborative.
- **[L30](../findings/stratum-two-negative.md) stands.** L30 is conditional on $\dim U<n$; L34 exhibits points where that hypothesis fails, which is not a counterexample to L30 but a limit on where it can be invoked.
- **The conclusion $\sup\theta\le\sqrt{3/2}$ on the stratum stands, by a different proof.** The descent was its proof and is gone; [stratum-two-negative.md:397](../findings/stratum-two-negative.md) records it as "**closed** by [Lemma L35](../findings/stratum-two-negative.md) below rather than differently proved". **The block's own closing sentence is therefore current and correct, and [isotropy-cap.md:360](../findings/isotropy-cap.md)'s "So B0's conclusion is now unproved rather than differently proved" is the stale copy.**

## 9. The claimed conflict, read at source

**The block records:** "$+0.485408612$ *(measured, not derived, and [isotropy-cap.md](../findings/isotropy-cap.md) records $+0.6259$ for the same family, a conflict this block does not resolve)*".

**The passage cited, read at source** ([isotropy-cap.md:358](../findings/isotropy-cap.md)): "**exact** witnesses at $\theta=+0.485408612$ ($m=6$) and $+0.115574271$ ($m=8$)… from 4-planes in **general position** (Reviewer 60); random general-position draws reach $+0.6259$ at $m=6$ and $+0.2650$ at $m=7$."

**The two figures are not the same quantity.** $+0.485408612$ is $\theta$ at one exhibited witness; $+0.6259$ is the largest value found over random draws, that is, a sampled lower bound on the family's supremum. A sample maximum exceeding a named witness is the expected relation between them, not a contradiction. **There is no conflict to resolve, and the resolution is inside the sentence the block cites.** I concur with phase 0's finding 1.

**The most charitable reading, which is where the real defect is.** If "reach" in the block means *attains as a maximum*, then there is tension, but the tension is with the block's own word, not between the two files. Under that reading the record refutes it three times over, and §10 says so.

## 10. The landscape bullet, BROKEN

**The claim** ([results.md:154](../results.md)): "In general position they reach $\theta=+0.485$."

**Three figures on this record exceed it, all for this family.**

| figure | source | what it is |
|---|---|---|
| $+0.6259$ at $m=6$ | [isotropy-cap.md:358](../findings/isotropy-cap.md) | maximum of random **general-position** draws, the same restriction the bullet names |
| $+1.2238$ at $m=8$ | [ATTEMPTS.md:2102](../ATTEMPTS.md) | numerical witnesses of the same construction |
| $\sqrt{3/2}=1.2247\ldots$ | [stratum-two-negative.md:399](../findings/stratum-two-negative.md), [isotropy-cap.md:362](../findings/isotropy-cap.md) | the family's measured supremum at $m=6,8,10,12$, attained by collapsing onto a single padded summand |

**So "reach" is wrong at any reading of it as an attained maximum**, and the first row is inside the bullet's own "general position" restriction, so the escape of reading $0.6259$ as unrestricted is closed. What is true is that $+0.485408612$ is *one* exhibited general-position value, and the family's supremum is $\sqrt{3/2}$.

**And it is a different kind of claim from the statement above it.** The canonical statement is existential at two named dimensions and is proven. The landscape bullet appends a claim about what a family reaches in general position, which is neither existential nor proven, and it is put where a reader takes it for part of the lemma. **The two should not sit under one number.**

## 11. Two values with no derivation, HYPOTHESIS-DEBT

$+0.485408612$ ($m=6$) and $+0.115574271$ ($m=8$) are marked *measured, not derived* inside the block. **They have no argument on file. That is the finding, full stop.**

What would have to be proved to discharge them: that the specific general-position configuration each was measured at yields those $\theta$ in closed form, which, given §3c, is a finite algebraic computation of the same shape, needing only the two planes' relative position written down. **The configurations are not recorded anywhere I could find, so the values cannot be rebuilt from the record at all.** Neither value enters the statement, so neither threatens it; both are cited in the landscape bullet, which §10 already finds broken.

## 12. The traps, answered by name

**$\ker W\ne0$.** Both witnesses are padded and both kernels are large: $9$ of $15$ dimensions at $m=6$, $22$ of $28$ at $m=8$. Every step survives it, and I checked each rather than assuming.

- *The eigenvalue indexing.* $v_{N-1},v_N$ is meant to name the two negative eigenvectors; with $\lambda_1\ge\dots\ge\lambda_N$ the zeros sort **above** the negatives, so with exactly two negatives $v_{N-1},v_N$ are them at both witnesses, kernel or no kernel. At $m=6$, $\lambda_{14}=-1/\sqrt{14}$ and $\lambda_{15}=-3/\sqrt{14}$; at $m=8$, $\lambda_{27}=\lambda_{28}=-1/\sqrt3$. **Clear.**
- *The count "exactly two negative".* Counted on $\Lambda^2\mathbb R^m$ with multiplicity, zeros excluded. **Clear.**
- *$\dim U$.* Computed from the negative eigenvectors' images as skew matrices; the kernel of $W$ on $\Lambda^2$ plays no part. **Clear.**
- *Membership in $\mathrm{Weyl}_m$.* Linear conditions, indifferent to the kernel. **Clear.**
- *The one place it would bite is not used here.* [conventions.md](../findings/conventions.md) flags "$S(W)$ the gradedness slack. **Read [W4](../findings/INDEX-traps.md) before using it**: the screen is vacuous when $\ker W\ne0$". L34 does not use $S$. **Clear.**
- *One reading it does complicate.* "The support is the union of the planes" is about the tensor's support in $\mathbb R^m$, while $W$ has a large kernel on $\Lambda^2$; the two are unrelated and the block uses one word for the first. Noted at §5b.

**The boundary of every stated range.** $m\ge10$: the construction spans at most $V_1+V_2$, of dimension at most $8$, and $U\subseteq V_1+V_2$, so $\dim U\le8<m$. **The block's admission of silence is correct.** [LEDGER.md:1001](../findings/LEDGER.md) strengthens the reason to a fact about the whole family via L33, which I did not re-derive and do not rely on. The refutation therefore covers $m=6,8$ only, enough, since the refuted statement was universal in $m$, but **it leaves the statement possibly true at $m\ge10$, and [isotropy-cap.md:370](../findings/isotropy-cap.md)'s convex screen is evidence, not proof, that it is.**

**The smallest admissible dimension.** $\mathrm{Weyl}_m=0$ at $m\le3$, so $m=4$ and $m=5$ are the low end. At $m=4$ a single $W_4(q,r)$ has one negative eigenvalue and $\dim U=4$, so it is not a witness; two copies would have to be a $\Lambda^+$ and a $\Lambda^-$ piece, which the block does not consider. **Not claimed, not checked here.**

**Odd $m$.** The block claims $m=6,8$ and is silent at $m=5,7$. **At $m=7$ the construction works unchanged and the block's own framing hides it**: take $V_1=\langle e_1,\dots,e_4\rangle$ and $V_2=\langle e_4,\dots,e_7\rangle$, meeting in a line. No basis bivector has both indices in $\{1,2,3,4\}\cap\{4,5,6,7\}=\{4\}$, so $\Lambda^2V_1\perp\Lambda^2V_2$; $W_1^2$ and $W_1^\#$ stay in $\Lambda^2V_1$, so the cross terms vanish exactly as at $m=8$; the spectrum is the union $\{-2,-2,1,1,1,1\}$, $\lVert W\rVert^2=12$, $\theta=-\sqrt3/2$, and $U=V_1+V_2=\mathbb R^7$. **The record already carries an $m=7$ figure for this family** ($+0.2650$, [isotropy-cap.md:358](../findings/isotropy-cap.md)), so the omission is in the statement's scope rather than in anyone's knowledge. This is recorded as a scope observation; it is not offered as a new lemma and I did not go looking for further witnesses beyond answering the brief's "odd $m$" question.

**A claim proven on a subfamily and used in general.** §6: the $m=6$ spectrum is stated of "planes meeting in a 2-plane" and holds of one alignment, with a closed-form configuration at the other extreme giving a different spectrum.

**A hypothesis stated but never used.** **None found.** The statement is existential with no antecedent hypotheses, and every clause it does carry is used.

**A step using a hypothesis never stated.** Three, at §6: $q,r>0$, $q=r$, and the $m=6$ alignment. A fourth at §4: that padding preserves membership.

**A universal claim with no witness.** "Both defining conditions are linear, so the sum is a $\mathrm{Weyl}_m$ element whatever the planes do" is universal and is **proved** (§4). "Each summand contributes exactly one negative eigenvalue" is universal and is a **non sequitur as an inference** (§5a).

**An existence claim whose witness does not satisfy the hypotheses.** **Checked and cleared.** Both witnesses satisfy every clause: membership (§2b, §4), exactly two negative eigenvalues (§2c, §3b), $\dim U=m$ (§2d, §3d).

**An imported theorem whose hypotheses were never checked against the object.** Inventoried at §1c. The one that matters is [L33](../findings/stratum-two-negative.md), and the block's use of it is confined to the one-positive case where its hypothesis genuinely holds. **No unital-algebra-style mismatch found here.** [L31](../findings/stratum-two-negative.md) is not imported, and I checked it holds of the self-dual pairs anyway (§2a) as a cross-check on my frame.

**Symbol collisions.** Three live, and [conventions.md](../findings/conventions.md) tables none of them.

| symbol | the collision | where |
|---|---|---|
| $r$ | the eigenvalue parameter of $W_4(q,r)$ against "the support of $W$ is exactly $\mathrm{im}\,v_1$, **of even dimension $r$**" | both in [stratum-two-negative.md](../findings/stratum-two-negative.md), lines 33 and 380 |
| $q$ | the eigenvalue parameter of $W_4(q,r)$ against the Weitzenböck term $q(R)$ | **inside one block**, [stratum-two-negative.md:142](../findings/stratum-two-negative.md) carries $q(R)\omega$ and line 166 carries $W_4(q,r)$ |
| $N$ | $N=\binom n2$, as tabled, against $N_v:=2\,v\otimes v-\mathrm{ad}(v)^2$ | [stratum-two-negative.md:139](../findings/stratum-two-negative.md) against the L34 statement's $v_{N-1},v_N$ |
| $U$ | **no collision found**, but $U$ is tabled nowhere in [conventions.md](../findings/conventions.md) and is defined inline in two blocks; [LEDGER.md:1796](../findings/LEDGER.md) records that [L30](../findings/stratum-two-negative.md)'s two readings of $U$ once produced two verdicts on one statement. At L34's witnesses the two readings agree, there being exactly two negative eigenvalues. **Checked and cleared.** |
| $\mathrm{Weyl}_m$ | an untabled synonym for [conventions.md](../findings/conventions.md)'s $\mathcal W_n$, and $N$ is tabled in $n$ while the statement runs in $m$ | minor |

## 13. A defect in the third copy, [isotropy-cap.md](../findings/isotropy-cap.md)

**Located.** [isotropy-cap.md:358](../findings/isotropy-cap.md): "**The clause is safe only for orthogonal planes**, where the two $\Lambda^2$ summands are orthogonal and $P$ is additive, **which is the special shape both recorded witnesses happen to have**, and presumably how the error survived."

**The failure, concretely.** The table four lines above, in the same file, records the $m=6$ witness's planes as "overlapping in a 2-plane". They are not orthogonal, their $\Lambda^2$ summands are not orthogonal (§3b gives $\langle W_1,W_2\rangle=1$) and $P$ is not additive there: §3c gives $P(W)=-54$ against $P(W_1)+P(W_2)=-36$, the cross terms carrying $-18$. Equivalently, additivity would predict $\theta=\theta_A/\sqrt2=-\sqrt3/2=-0.866$, and the recorded and rebuilt value is $-27\sqrt{14}/98=-1.0309$. **The sentence is false of one of the two witnesses it names, and the file's own table says so.**

**The most charitable reading.** If "the same special shape" meant only "$\theta\le0$" rather than "orthogonal planes", the sentence would be true but would then assert nothing, since the whole clause under repair is $\theta\le0$. If it meant "both witnesses were built from a symmetric alignment", that is true but is not what "orthogonal" says, and it is not what makes $P$ additive. **No reading the words support rescues it.**

**Consequence.** Small: the correction it belongs to (that overlapping planes admit $\theta>0$), is right, and the $m=6$ witness happens to have $\theta<0$ anyway. But the sentence offers an explanation of "how the error survived" that is false, and a reader takes from it that the $m=6$ planes are orthogonal.

### 13a. Withdrawn candidate, the provenance note

I considered reporting the block's provenance note ("the duplication having been resolved on 2026-09-06") against the fact that [results.md:483](../results.md) still carries the construction byte-identical. **Withdrawn**: I cannot clear step 2 of the protocol. The record's own convention is that a canonical statement sits in [results.md](../results.md) and points at its proof in [findings/](../findings/), which is exactly the shape here, and [LEDGER.md:1001](../findings/LEDGER.md) already records the note's status as "half true" from an earlier audit. Reporting it again would be re-litigating a settled ledger row on a reading I cannot pin. **Reported as withdrawn, not as a defect.**

## 14. Verdict

# PROVEN, hypotheses corrected

**The statement is true and I rebuilt both witnesses from the definitions in closed form.** At $m=8$: two copies of $W_4(1,1)$ on orthogonal 4-planes, spectrum $\{-1/\sqrt3\,(\times2),\,1/(2\sqrt3)\,(\times4)\}$, $\theta=-\sqrt3/2$, $\mathop{\mathrm{tr}}W^\#=-12$, $\dim U=8$ under every basis of the degenerate eigenplane. At $m=6$: two copies on planes meeting in $\langle e_3,e_4\rangle$ under the order-preserving identification, spectrum $(-3,-1,1,1,1,1)/\sqrt{14}$, $P=-54$, $\theta=-27\sqrt{14}/98=-1.0308648\ldots$, $\mathop{\mathrm{tr}}W^\#=-14$, $\dim U=6$. **Every printed value in the statement is exactly right.**

"Hypotheses corrected" rather than plain "proven" because the construction paragraph is not a proof of what it says as it stands, and four things must be added before it is:

1. **$q,r>0$, and $q=r$**, without which neither printed spectrum is the object's.
2. **The alignment at $m=6$**, the printed spectrum is one of a one-parameter family of outcomes, and §6 exhibits another in closed form.
3. **The negative-count reason**, which is a non sequitur at the $m=6$ witness (§5a); the repair is the rank-$\le2$ inertia argument plus the exhibited spectra.
4. **The $\dim U=m$ reason**, which is a non sequitur (§5b); the repair is that each summand's negative eigenvector is a complex structure on its plane, a line the record already holds at [lean/INDEX.md](../lean/INDEX.md) and the block does not.

**Separately, and not part of the statement's verdict:** the landscape bullet's "In general position they reach $\theta=+0.485$" is **BROKEN** (§10); the "conflict" the block records against [isotropy-cap.md](../findings/isotropy-cap.md) does not exist (§9); the two *measured, not derived* values are **HYPOTHESIS-DEBT** with their configurations unrecoverable from the record (§11); and [isotropy-cap.md:358](../findings/isotropy-cap.md)'s "both recorded witnesses" sentence is false of the $m=6$ witness (§13).

## 15. What would falsify the statement, and what I did to look for it

**The statement is existential, so falsifying it means proving that no $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues has $\dim U=m$, at $m=6$ or at $m=8$.** A proof of that shape would have to be an obstruction argument: the natural one is the route [isotropy-cap.md:370](../findings/isotropy-cap.md) reports for $m\ge10$, a convex feasibility screen over rank classes of the two negative eigenvectors, showing the class $(4,4)$ with equal singular values is the only near-feasible one and then closing it.

**What I did.** I attacked it from the other side, since one valid witness ends the question: I rebuilt both objects from the definitions rather than from the record's description of them, and checked every clause independently, membership through the linear conditions and through the independent identity $\mathop{\mathrm{tr}}W^\#=-\lVert W\rVert^2$; the count from the exact spectra rather than from the summands; $\dim U$ from the images of the eigenvectors as skew matrices rather than from the support. **Every check passed, and two of them (the $m=6$ spectrum and its $\theta$) came out as exact closed forms the record prints only as decimals.** I also looked for the falsifier where it would most likely hide (at the overlapping-plane witness, where the block's own reasoning breaks) and found the conclusion holds there even though the reason does not.

**Where a falsifier could still live, and it is not at $m=6$ or $m=8$.** The screen [isotropy-cap.md:370](../findings/isotropy-cap.md) reports is "exhaustive over all 19 admissible rank classes" at $m=10$ and every one infeasible, which is the shape a real obstruction at $m\ge10$ would take. **That is where the statement's converse would have to be argued, and this round says nothing about it.** I ran nothing numerical; the screen is quoted, not repeated.
