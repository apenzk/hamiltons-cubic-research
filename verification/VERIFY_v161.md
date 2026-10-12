# Verifier v161, Lemma L34, full support with two negative eigenvalues at $m=6$ and $m=8$

I read [BRIEF_L34.md](BRIEF_L34.md) cold and worked from the definitions in [conventions.md](../findings/conventions.md), rebuilding both exhibited objects in closed form before comparing them with anything the record says about them. **No numerical work was done. Every value below is exact**: the spectra come out of a $2\times2$ characteristic polynomial and a block decomposition, and $\theta$ comes out of the polarisation of $P$ over the two summands, each term evaluated in surds. The one place a decimal appears is where I round a surd to compare it against a decimal the record printed. Log: [agent_logs/verify-L34-v161.log](../agent_logs/verify-L34-v161.log).

## Claim table

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | **The statement.** For $m=6$ and $m=8$ there is $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues and $\dim U=m$ | **CONFIRMED** |
| 2 | $m=8$: spectrum $\{-1/\sqrt3\,(\times2),\ 1/(2\sqrt3)\,(\times4)\}$, $\theta=-\sqrt3/2$ | **CONFIRMED, exact** |
| 3 | $m=6$: spectrum $(-3,-1,1,1,1,1)/\sqrt{14}$, $\theta=-1.030865$ | **CONFIRMED, exact**, closed form $-27\sqrt{14}/98$ |
| 4 | $\operatorname{tr}W^\#=-1$ at both witnesses | **CONFIRMED**, and it is an identity at every unit $\mathrm{Weyl}_n$ element |
| 5 | "Both defining conditions are linear, so the sum is a $\mathrm{Weyl}_m$ element whatever the planes do" | **CONFIRMED** |
| 6 | "each summand contributes exactly one negative eigenvalue" | **BROKEN at the $m=6$ witness**, the conclusion "exactly two" survives |
| 7 | "the support is the union of the planes" | **CONCLUSION CONFIRMED, JUSTIFICATION FALSE** at $m=6$ |
| 8 | $\dim U=m$ at each witness, for every admissible choice of $v_{N-1},v_N$ | **CONFIRMED** |
| 9 | $q,r>0$ | **HYPOTHESIS USED, NEVER STATED** in the canonical block |
| 10 | $q=r=q'=r'$, which is what the two recorded spectra require | **SPECIFICATION MISSING** from the Construction |
| 11 | "Why the recorded equivalence fails", the displayed Ricci identity | **CONFIRMED**, and it needs $m\ge6$, which is unstated |
| 12 | Silence at $m\ge10$ | **CONFIRMED, forced**, $\dim U\le8<m$ |
| 13 | "isotropy-cap.md records $+0.6259$ for the same family, a conflict this block does not resolve" | **NOT A CONFLICT**, two members of one family, both lower bounds |
| 14 | [isotropy-cap.md](../findings/isotropy-cap.md): orthogonal planes are "the special shape both recorded witnesses happen to have" | **BROKEN**, the $m=6$ witness's planes overlap and $P$ is not additive on it |
| 15 | Provenance: "the duplication having been resolved on 2026-09-06" | **BROKEN**, [results.md](../results.md) still carries the Construction byte-identical |
| 16 | The landscape bullet's two clauses | **QUANTIFIER DEFECT** in the first, **HYPOTHESIS-DEBT** in the second |
| 17 | $+0.485408612$, $+0.115574271$, $+0.6259$, and the $m\ge10$ convex screen | **HYPOTHESIS-DEBT**, measured, not derived |
| 18 | [L33](../findings/stratum-two-negative.md)'s citation of the $m=8$ witness | **HOLDS UNDER ONE READING ONLY**; L33's repair does not depend on it |
| 19 | Symbol collisions on $q$, $r$, $U$, $N$ | **UNTABLED**; $q$ and $r$ each carry two senses inside one file |

## One-line summary

**The existence claim is true and both exhibited objects reproduce every recorded number exactly**, I rebuilt them from the definitions and got $(-3,-1,1,1,1,1)/\sqrt{14}$ with $\theta=-27\sqrt{14}/98=-1.0308648$ and $\{-1/\sqrt3(\times2),1/(2\sqrt3)(\times4)\}$ with $\theta=-\sqrt3/2$, while two of the Construction's four sentences are false as mechanisms at the very witness they are written for, one load-bearing hypothesis on $q,r$ is never stated, and three bookkeeping claims in the block's own margins are refuted by the files they point at.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md):

> | $\mathcal W_n$ | the space of algebraic Weyl curvature operators on $\mathbb R^n$ |
> | $Q(W)$ | Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself |
> | $P(W)$ | the cubic form $\langle W,Q(W)\rangle$ |
> | $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$ |
> | $N$ | $\binom n2=\dim\Lambda^2\mathbb R^n$ |

> **The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.** The inner product is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix. *Applying the $\tfrac12$ at the operator level instead inflates every $\theta$ by $\sqrt2$*, and has cost a cycle.

> - **A bivector's norm**, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal

> **$\#$ and $\mathrm{Ric}$, and why they belong here.** $\#$ is the halved Böhm–Wilking product ($vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$) and $\mathrm{Ric}$ is the adjoint of $\cdot\wedge\mathrm{id}$

> - **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, the inner product being ad-invariant; so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide.

> - **Padding commutes with $Q$**, and preserves both the norm and $\theta$. The stratum reduction turns on this.

> | $T$, third sense | **the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$**

> - **The Killing marginal** … in the general form $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for any $v\in\mathfrak{so}(n)$ at any $n\ge2$

And from [stratum-two-negative.md](../findings/stratum-two-negative.md) itself, the two things the L34 block consumes without restating:

> $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$

> On $\mathbb R^4$ the self-dual forms are complex structures, and $W_4(q,r)=-(q+r)\,w_1\otimes w_1+q\,w_2\otimes w_2+r\,w_3\otimes w_3$ lies in $\mathrm{Weyl}_4$ with signature $(2,1)$; its negative is the base-case family at $\theta=+\sqrt{3/2}$

> $P=9(\det W^++\det W^-)$ on $\mathrm{Weyl}_4$ gives $\max P=\sqrt{3/2}$, on record and proved

## 1. The hypothesis inventory

**What the statement asserts.** Two things, at each of two fixed dimensions: membership $W\in\mathrm{Weyl}_m$, and the pair of spectral facts (exactly two negative eigenvalues; $\dim U=m$). There is no antecedent, this is a pure existence claim, so the whole burden is on the two exhibited objects and nothing can be vacuously satisfied.

| hypothesis | what it requires | where stated | used by the written proof? |
| --- | --- | --- | --- |
| $W\in\mathrm{Weyl}_m$ | the first Bianchi identity, and Ricci-flatness (trace-free Ricci **and** zero scalar); both linear conditions on $S^2(\Lambda^2\mathbb R^m)$, cutting out an $O(m)$-invariant subspace | [conventions.md](../findings/conventions.md), [README.md](../README.md) | **yes**, and correctly, see §5 |
| $W_4(q,r)\in\mathrm{Weyl}_4$ | $w_1,w_2,w_3$ an orthonormal basis of $\Lambda^+\mathbb R^4$, each of unit norm under the half-trace pairing | line 166 of [stratum-two-negative.md](../findings/stratum-two-negative.md), 215 lines above the L34 block | **yes**, silently |
| $q,r>0$ | the summand's signature is $(2,1)$, i.e. **one** negative eigenvalue | nowhere in the L34 block; recoverable only from the phrase "signature $(2,1)$" in the L33 block of the same file, and from the landscape bullet in [results.md](../results.md) | **yes, load-bearing**, see §9 |
| $q=r$, and the same parameter in both copies | the two recorded spectra | **nowhere** | **yes**, see §10 |
| the plane configuration | orthogonal complementary 4-planes at $m=8$; 4-planes meeting in a 2-plane at $m=6$ | in the Construction | yes |
| $\dim U=m$ with $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$ | $v_{N-1},v_N$ the two lowest eigenvectors read as skew matrices, the ordering being descending, as [L35](../findings/stratum-two-negative.md)'s $\lambda_1>0>-a\ge-b$ and its $T_{1,N-1,N}$ fix | in the Statement | yes |
| padding preserves membership, norm and $\theta$ | [conventions.md](../findings/conventions.md) | quoted above | yes |

**Imported results, and whether their hypotheses were checked.**

- $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, hypothesis is $n=4$ exactly, satisfied by each summand before padding. Cleared.
- $P=9(\det W^++\det W^-)$ on $\mathrm{Weyl}_4$, used by me, not by the block, and its hypothesis $n=4$ is satisfied at each summand. Cleared.
- [Lemma L33](../findings/stratum-two-negative.md), cited in "Why the recorded equivalence fails". Its hypothesis is a **one-dimensional** eigenspace on one side, counted with multiplicity, and its exception is a complex-structure multiple on a 4-plane. The block's use is legitimate at $m\ge6$ and fails at $m=4$; see §11. **The witnesses themselves do not satisfy L33's hypothesis** (the $m=8$ witness has a 2-dimensional negative eigenspace and a 4-dimensional positive one) and the block does not claim they do.
- The Weitzenböck identity $\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2=2W$, from the L33 block. I use it in §4 to derive $\operatorname{tr}W^\#$. Its hypotheses are the first Bianchi identity (load-bearing) and Ricci-flatness (deletes the correction), both of which the witnesses satisfy by §5.
- **The unital-algebra trap the brief names does not arise here.** No theorem about $\mathcal W_n$ as an algebra is imported into this block; the only algebra used is $\mathfrak{so}(m)$ with its bracket, which needs no unit.

## 2. The $m=8$ witness, rebuilt cold

Take $V_1=\langle e_1,e_2,e_3,e_4\rangle$ and $V_2=\langle e_5,e_6,e_7,e_8\rangle$, orthogonal and complementary in $\mathbb R^8$. On each, write the self-dual basis in the orthonormal bivectors $\varphi_{ab}$:

$$u_1=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34}),\quad u_2=\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24}),\quad u_3=\tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23}),$$

and $z_1,z_2,z_3$ the same on $e_5,\dots,e_8$. Put $A=q(-2u_1u_1^{\mathsf T}+u_2u_2^{\mathsf T}+u_3u_3^{\mathsf T})$ and $B$ the same in the $z$'s, that is, $W_4(q,r)$ at $q=r$.

**The spectrum.** $\Lambda^2V_1\perp\Lambda^2V_2$ and $\langle u_i,z_j\rangle=0$ for every $i,j$, so the eigenvalues of $A+B$ are the union: $-2q$ twice and $q$ four times, with $\binom82-6=22$ zeros. Then $\lVert W\rVert^2=2(4q^2)+4q^2=12q^2$, so unit norm is $q=1/(2\sqrt3)$ and $-2q=-1/\sqrt3$. **The recorded spectrum $\{-1/\sqrt3\,(\times2),\ 1/(2\sqrt3)\,(\times4)\}$ is exactly right**, and it sums to zero and squares to $2\cdot\tfrac13+4\cdot\tfrac1{12}=1$.

**$\theta$.** Write $P(X)=\operatorname{tr}(X^3)+\langle X,X\#X\rangle$. Both cubics polarise, and $\langle X,Y\#Z\rangle$ is fully symmetric, so

$$P(A+B)=P(A)+P(B)+3\big[\operatorname{tr}(A^2B)+\operatorname{tr}(AB^2)\big]+3\big[\langle B,A^\#\rangle+\langle A,B^\#\rangle\big].$$

Here $AB=0$ because $\operatorname{im}B\subseteq\Lambda^2V_2\subseteq\ker A$, so the first bracket vanishes. $A^\#$ is supported on $\Lambda^2V_1$ because $\Lambda^2V_1=\mathfrak{so}(V_1)$ is a subalgebra, so $\langle B,A^\#\rangle=0$, and likewise $\langle A,B^\#\rangle=0$. **So $P$ is additive here, and the reason is that $\mathfrak{so}(V_1)$ and $\mathfrak{so}(V_2)$ commute**, $[u_i,z_j]=0$ for orthogonal complementary planes, which kills $A\#B$ outright. With $\lVert A\rVert=\lVert B\rVert=1/\sqrt2$ and $\theta$ at each normalised summand equal to $-\sqrt{3/2}$ (the negative of the base-case family, $P$ being odd, and padding preserving $\theta$),

$$\theta(W)=P(A)+P(B)=2\cdot\Big(\tfrac1{\sqrt2}\Big)^3\big(-\sqrt{3/2}\big)=-\frac{\sqrt{3/2}}{\sqrt2}=-\frac{\sqrt3}2 .$$

**Recorded $-\sqrt3/2$ confirmed**, $=-0.8660254$, matching the $-0.866025$ in the [isotropy-cap.md](../findings/isotropy-cap.md) copy's table.

**$\dim U$.** The negative eigenvalue $-1/\sqrt3$ has multiplicity $2$, so $v_{N-1},v_N$ is a *choice* of orthonormal basis of $\operatorname{span}(u_1,z_1)$. For $x=au_1+bz_1$ with $a,b\ne0$ the matrix $x$ is block-diagonal with four nonzero $2\times2$ blocks, hence $\operatorname{im}x=\mathbb R^8$; and at most one member of an orthonormal basis of that plane can have $a=0$ or $b=0$. **So $\dim U=8$ for every admissible choice**, and the definition of $U$ is unambiguous here even though it names particular eigenvectors.

## 3. The $m=6$ witness, rebuilt cold

Take $V_1=\langle e_1,e_2,e_3,e_4\rangle$ and $V_2=\langle e_3,e_4,e_5,e_6\rangle$, meeting in the 2-plane $\langle e_3,e_4\rangle$. Self-dual bases:

$$u_1=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34}),\ u_2=\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24}),\ u_3=\tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23});$$
$$z_1=\tfrac1{\sqrt2}(\varphi_{34}+\varphi_{56}),\ z_2=\tfrac1{\sqrt2}(\varphi_{35}-\varphi_{46}),\ z_3=\tfrac1{\sqrt2}(\varphi_{36}+\varphi_{45}).$$

**The Gram matrix.** The only index pair shared by the two lists is $\{3,4\}$, and it appears only in $u_1$ and $z_1$. So $\langle u_1,z_1\rangle=\tfrac12$ and every other cross pairing is $0$. This single overlap is the whole of the interaction.

Set $A=q(-2u_1u_1^{\mathsf T}+u_2u_2^{\mathsf T}+u_3u_3^{\mathsf T})$ and $B=q(-2z_1z_1^{\mathsf T}+z_2z_2^{\mathsf T}+z_3z_3^{\mathsf T})$, and $W=A+B$.

**The spectrum.** $u_2,u_3,z_2,z_3$ are orthonormal and orthogonal to everything else, and each is annihilated by the other summand, so each is an eigenvector at $q$, four eigenvalues $q$. The plane $S=\operatorname{span}(u_1,z_1)$ is invariant: $Wu_1=-2qu_1-qz_1$ and $Wz_1=-2qz_1-qu_1$. Orthonormalise $S$ by $f_1=u_1$, $f_2=\tfrac2{\sqrt3}z_1-\tfrac1{\sqrt3}u_1$; then

$$W|_S=q\begin{pmatrix}-\tfrac52&-\tfrac{\sqrt3}2\\[2pt]-\tfrac{\sqrt3}2&-\tfrac32\end{pmatrix},\qquad \operatorname{tr}=-4q,\quad \det=q^2\Big(\tfrac{15}4-\tfrac34\Big)=3q^2,$$

so $\lambda^2+4q\lambda+3q^2=0$ and $\lambda=-q,-3q$. **The spectrum is $\{-3q,-q,q,q,q,q\}$ with nine zeros**; $\sum\lambda^2=14q^2=1$ fixes $q=1/\sqrt{14}$, giving $(-3,-1,1,1,1,1)/\sqrt{14}$. **Recorded spectrum confirmed**, trace zero, norm one.

**The bracket algebra of one summand.** Writing $I=\sqrt2u_1$, $J=\sqrt2u_2$, $K=\sqrt2u_3$ as skew matrices, $I^2=J^2=K^2=-\mathrm{Id}_{V_1}$ and $[I,J]=-2K$ cyclically, so $[u_i,u_j]=-\sqrt2\,\epsilon_{ijk}u_k$ and $\lVert[u_i,u_j]\rVert^2=2$ for every $i\ne j$, the saturated pair cap the file records for $\Lambda^+$. Hence, with $\alpha=(-2q,q,q)$,

$$A^\#=2\big[\alpha_2\alpha_3\,u_1u_1^{\mathsf T}+\alpha_1\alpha_3\,u_2u_2^{\mathsf T}+\alpha_1\alpha_2\,u_3u_3^{\mathsf T}\big]=2q^2\big[u_1u_1^{\mathsf T}-2u_2u_2^{\mathsf T}-2u_3u_3^{\mathsf T}\big].$$

Two independent checks pin this: $\operatorname{tr}A^\#=2q^2(1-2-2)=-6q^2=-\lVert A\rVert^2$, which is §4's identity; and $\langle A,A^\#\rangle=-12q^3$ against $\operatorname{tr}A^3=-6q^3$ gives $P(A)=-18q^3$, which is exactly $9\det W^+=9(-2q)(q)(q)$ from the $\mathrm{Weyl}_4$ closed form. Equivalently $\theta$ at the normalised summand is $-18q^3/(6q^2)^{3/2}=-3/\sqrt6=-\sqrt{3/2}$, as the record states.

**$\theta$.** Every cross term reduces to the single overlap $\langle u_1,z_1\rangle^2=\tfrac14$, because $A^\#$, $B^\#$, $A^2$ and $B^2$ are all diagonal in their own eigen-bivectors:

- $\operatorname{tr}(A^2B)=(4q^2)(-2q)\tfrac14=-2q^3$, and $\operatorname{tr}(AB^2)=-2q^3$;
- $\langle B,A^\#\rangle=(2q^2)(-2q)\tfrac14=-q^3$, and $\langle A,B^\#\rangle=-q^3$.

So $P(W)=2(-18q^3)+3(-4q^3)+3(-2q^3)=-54q^3$, and at $q=1/\sqrt{14}$, $\lVert W\rVert=1$:

$$\theta=-\frac{54}{14\sqrt{14}}=-\frac{27\sqrt{14}}{98}=-1.03086478\ldots$$

**The recorded $-1.030865$ is this surd correctly rounded.** The block prints a decimal where a clean closed form exists; the closed form is $-27\sqrt{14}/98$, and I recommend it be recorded.

**$\dim U$.** The negative eigenvalues are distinct, so $v_{14},v_{15}$ are pinned up to sign. At $-3q$: $v_{15}=(u_1+z_1)/\sqrt3=\tfrac1{\sqrt6}(\varphi_{12}+2\varphi_{34}+\varphi_{56})$, which has three nonzero $2\times2$ blocks, so $\operatorname{im}v_{15}=\mathbb R^6$ already. At $-q$: $v_{14}=u_1-z_1=\tfrac1{\sqrt2}(\varphi_{12}-\varphi_{56})$, of rank $4$ and image $\langle e_1,e_2,e_5,e_6\rangle$. Hence $\dim U=6$. **Confirmed.**

## 4. $\operatorname{tr}W^\#$

The brief asks for this explicitly. It is not a free parameter: **for every $W\in\mathcal W_n$, $\operatorname{tr}W^\#=-\lVert W\rVert^2$.** Since $\mathrm{ad}(v_\alpha)$ is skew-adjoint, $\lVert[v_\alpha,v_\beta]\rVert^2=-\langle v_\beta,\mathrm{ad}(v_\alpha)^2v_\beta\rangle$, so with the halved $\#$,

$$\operatorname{tr}W^\#=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\lVert[v_\alpha,v_\beta]\rVert^2=-\tfrac12\sum_\beta\lambda_\beta\Big\langle v_\beta,\Big(\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2\Big)v_\beta\Big\rangle=-\sum_\beta\lambda_\beta^2=-\lVert W\rVert^2,$$

using the L33 block's identity $\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2=2W$, whose hypotheses are first Bianchi and Ricci-flatness. So $\operatorname{tr}W^\#=-1$ at both unit witnesses, which is what [r549](../reviews/REVIEW_r549.md) and [r550](../reviews/REVIEW_r550.md) recovered. I verified it independently at $m=6$ two ways: $\operatorname{tr}A^\#=\operatorname{tr}B^\#=-6q^2=-3/7$ from the explicit $A^\#$ above, and $\operatorname{tr}(A\#B)=-\langle A,B\rangle=-q^2=-1/14$ by polarising the identity across the three Weyl elements $A$, $B$, $A+B$, giving $-3/7-3/7-2/14=-1$.

**Its evidential weight is limited, and worth saying.** Because it is an identity at every Weyl tensor, recovering $\operatorname{tr}W^\#=-1$ tests only that the constructed object is in $\mathrm{Weyl}_m$ with unit norm, it cannot distinguish this witness from any other, and it is not a check on the spectrum or on $\theta$.

## 5. "Both defining conditions are linear, so the sum is a $\mathrm{Weyl}_m$ element whatever the planes do"

**Confirmed, and the argument is complete.** The two conditions are the first Bianchi identity and Ricci-flatness; the brief asks whether both are linear "in the sense used", and they are, each is the vanishing of a fixed linear map out of $S^2(\Lambda^2\mathbb R^m)$, so $\mathrm{Weyl}_m$ is a linear subspace and closed under addition. The step the sentence leaves implicit is that each *padded* summand lies in $\mathrm{Weyl}_m$: padding onto an arbitrary 4-plane is the standard padding composed with an element of $O(m)$, and $\mathrm{Weyl}_m$ is $O(m)$-invariant, so this holds for any plane. That is the whole content of "whatever the planes do", and it is right.

Concretely for the summands: $W_4(q,r)$ has $W^+=\operatorname{diag}(-(q+r),q,r)$ and $W^-=0$, so its $\Lambda^4$ component is $\operatorname{tr}W^+-\operatorname{tr}W^-=0$ (first Bianchi in dimension $4$) and its $\Lambda^+\otimes\Lambda^-$ block, which carries the trace-free Ricci, is zero, while $\operatorname{tr}W=0$ kills the scalar. Both conditions hold, and $\mathrm{Alt}(W)=0$ survives padding componentwise.

## 6. "Each summand contributes exactly one negative eigenvalue", BROKEN at the $m=6$ witness

**1. Located.** The Construction's second sentence, in both [results.md](../results.md) and [stratum-two-negative.md](../findings/stratum-two-negative.md): "each summand contributes exactly one negative eigenvalue, and the support is the union of the planes."

**2. Exhibited.** At the $m=6$ witness the summand $A$ has its single negative eigenvalue $-2q=-2/\sqrt{14}$ at $u_1$. But $u_1$ is not an eigenvector of $W$ ($Wu_1=-2qu_1-qz_1$) and $-2/\sqrt{14}$ is not in $\operatorname{spec}(W)=\{-3q,-q,q^{\times4}\}$. Neither negative eigenvalue of the sum is contributed by either summand: they are $-3q$ and $-q$, at $(u_1+z_1)/\sqrt3$ and $u_1-z_1$, both genuinely mixed. **The sentence is a statement about a direct sum, and the $m=6$ witness is not one.** This is the brief's "claim proven on a subfamily and used in general": it is literally true at $m=8$, where the supports are orthogonal, and false at $m=6$, where they are not.

**3. The opposite argued.** The charitable reading is that "contributes one" is an inertia bookkeeping claim rather than an eigenvalue claim, that each summand contributes one to the *count*. Under that reading the upper half is a theorem: $n_-(A+B)\le n_-(A)+n_-(B)=2$ by subadditivity of negative inertia, so the sum never has more than two negative eigenvalues however the planes sit. But the lower half (that the count is exactly two, not one or zero), does not follow from it, and "exactly" is the word the statement needs. At the two witnesses I settled it from the rebuilt spectra directly: $\{-3q,-q\}$ at $m=6$ and $-1/\sqrt3$ twice at $m=8$. **So the conclusion stands at both witnesses and the sentence offered for it does not.**

## 7. "The support is the union of the planes", conclusion right, justification false at $m=6$

**1. Located.** Same sentence.

**2. Exhibited.** At $m=6$, $\operatorname{im}v_{14}=\langle e_1,e_2,e_5,e_6\rangle$, which is contained in neither $V_1=\langle e_1,e_2,e_3,e_4\rangle$ nor $V_2=\langle e_3,e_4,e_5,e_6\rangle$, and is not a subset of their union. The other image, $\operatorname{im}v_{15}$, is all of $\mathbb R^6$, larger than either plane. So $U$ is not built out of the planes in the way the sentence says.

**3. The opposite argued.** Read "the union" as "the span of the union", the only reading under which the phrase names a subspace at all, and the *conclusion* $U=\operatorname{span}(V_1\cup V_2)$ is true at both witnesses, I verified it in §2 and §3. What is available in general is only the containment $U\subseteq V_1+V_2$, since every eigen-bivector lies in $\Lambda^+(V_1)+\Lambda^+(V_2)\subseteq\Lambda^2(V_1+V_2)$; equality is a fact about the particular configuration and needs the computation. **So the finding is that the block asserts as a general mechanism something that is a per-witness computation, and it is that containment, not the equality, that the general argument gives.** The equality is what §12 then uses, correctly, to conclude silence at $m\ge10$.

## 8. $\ker W\ne0$, what the padding does to every step

The brief names this as a trap and it is a real feature of both objects: **the rank of $W$ is $6$ at both witnesses**, so $\ker W$ has dimension $\binom62-6=9$ at $m=6$ and $\binom82-6=22$ at $m=8$. Step by step:

- **The statement is untouched.** "Exactly two negative eigenvalues" counts strict negatives; zeros are neither negative nor positive, and $\dim U$ is built only from the negative eigenvectors. Both claims are stable under a large kernel.
- **The eigenvector labels are unambiguous.** With the descending order, $v_{N-1},v_N$ are the two most negative, and the $22$ or $9$ zeros sit strictly above them. No ordering ambiguity reaches $U$.
- **The signature label is loose.** $W_4(q,r)$ is called signature $(2,1)$; as an operator on the $6$-dimensional $\Lambda^2\mathbb R^4$ its inertia is $(2,1,3)$. The record consistently means the inertia of the nonzero part, and no step uses more, but the phrase is the same one that would be wrong if a step ever counted eigenvalues rather than signs.
- **Screens that die on a kernel are not invoked.** [conventions.md](../findings/conventions.md) warns that the gradedness slack $S(W)$ "is vacuous when $\ker W\ne0$"; the L34 block uses no such screen, so the warning does not bite. The one place a kernel could have mattered ($\operatorname{tr}W^\#=-\lVert W\rVert^2$), is insensitive to it, since zero eigenvalues drop out of both sides.
- **The interaction with [L30](../findings/stratum-two-negative.md) is consistent.** L30 concludes that $\dim U<n$ forces at least $n-1$ zero eigenvalues; these witnesses have $\dim U=m$ and are therefore outside its hypothesis, so their large kernels are no contradiction. L30 is one-directional and nothing here tests its converse.

## 9. $q,r>0$, a hypothesis used but never stated

**1. Located.** "Pad two copies of $W_4(q,r)$ onto 4-planes of $\mathbb R^m$ and add." No condition on $q,r$ appears anywhere in the L34 block, in either copy of it.

**2. Exhibited.** Take $q=2$, $r=-1$. Then $W_4(2,-1)=-1\cdot w_1\otimes w_1+2\,w_2\otimes w_2-1\cdot w_3\otimes w_3$ has spectrum $\{-1,2,-1\}$ (**two** negative eigenvalues, signature $(1,2)$) and is still a perfectly good element of $\mathrm{Weyl}_4$, since $S^2_0(\Lambda^+)$ imposes only $\operatorname{tr}W^+=0$. Padding two such copies onto orthogonal 4-planes of $\mathbb R^8$ gives a $\mathrm{Weyl}_8$ element with **four** negative eigenvalues, and the statement's "exactly two" fails. So the Construction as literally written does not produce the claimed object.

**3. The opposite argued.** A reader of [stratum-two-negative.md](../findings/stratum-two-negative.md) in file order meets the definition of $W_4(q,r)$ 215 lines earlier with the words "signature $(2,1)$" attached, and signature $(2,1)$ does pin $q,r>0$ up to relabelling. That rescues the findings copy for a linear reader. **It does not rescue [results.md](../results.md)**, whose canonical block reproduces the Construction with no definition of $W_4(q,r)$ anywhere near it, the only mention of "signature-$(2,1)$" in that file is in the landscape bullet, 330 lines earlier. The finding survives: **the hypothesis is load-bearing, and it is stated in neither canonical block.**

## 10. $q=r$, the recorded spectra are of one member of a family the Construction leaves open

The Construction says "two copies of $W_4(q,r)$" and then prints spectra. Both recorded spectra require $q=r$ **and** the same parameter in both copies: at $m=8$ with $q\ne r$ the union of the two normalised triples is $\{-(q+r),q,r,-(q'+r'),q',r'\}$, which is $\{-1/\sqrt3\,(\times2),1/(2\sqrt3)\,(\times4)\}$ only when $q=r=q'=r'$; at $m=6$ the four unmixed eigenvalues are $q,r,q',r'$, and their being equal is what makes the recorded spectrum have a fourfold $+1/\sqrt{14}$. Neither the Statement nor the Construction says so. The values are recoverable by reverse-engineering the printed spectrum, which is why this is a specification gap rather than a break, but a reader instructed to "pad two copies of $W_4(q,r)$" and check the answer will not land on the printed numbers unless told.

## 11. "Why the recorded equivalence fails", the displayed identity checked

The displayed line is

$$\sum_{\lambda_\alpha>0}\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=b\,yy^{\mathsf T}+c\,zz^{\mathsf T}.$$

**The identity is correct, including the notation.** Ricci-flatness is the PSD identity $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ recorded in the same file; for skew $v$ one has $vv^{\mathsf T}=-v^2=v^{\mathsf T}v$, so writing it with $vv^{\mathsf T}$ changes nothing, and moving the two negative terms across gives exactly the display with $-b,-c$ the negative eigenvalues at $y,z$.

**The one-positive case.** Every term is positive semidefinite, so $\operatorname{im}(v_1v_1^{\mathsf T})=\operatorname{im}(b\,yy^{\mathsf T})+\operatorname{im}(c\,zz^{\mathsf T})$, i.e. $\operatorname{im}v_1=\operatorname{im}y+\operatorname{im}z=U$. **The block's "forces $U=\operatorname{im}v_1$" is an equality and it is right**, not merely a containment. Then $\dim U=m$ makes $v_1$ nondegenerate, and [L33](../findings/stratum-two-negative.md) applies with the positive eigenspace one-dimensional.

**Where it needs a dimension bound the block does not state.** L33's exception is a complex-structure multiple on a 4-dimensional subspace. A nondegenerate $v_1$ on $\mathbb R^m$ falls outside the exception only for $m\ge6$; at $m=4$ a full-rank $v_1$ *is* such a multiple, and the exception is realised, $-W_4(q,r)$ has spectrum $(q+r,-q,-r)$, one positive eigenvalue at a rank-$4$ eigenvector, $\dim U=4=m$, and it is not zero. **So the sentence "full support means a nondegenerate eigenvector and Lemma L33 applies" is true at $m\ge6$ and false at $m=4$, and carries no dimension restriction.** The block's own subject is $m\ge6$, so nothing downstream breaks; the clause is simply unhypothesised.

**"Constrains no rank at all", with several positives, correct.** The display bounds only the *total* image of the positive side, and puts no bound on any individual $v_\alpha$. Both witnesses realise exactly that: four positive eigenvectors, each of rank $4$, whose images together fill $\mathbb R^m$. The gap the block describes is real and the witnesses do occupy it.

## 12. $m\ge10$, the boundary of the range, and odd $m$

**Silence at $m\ge10$ is forced, not merely unattempted.** Every eigen-bivector of $A+B$ lies in $\Lambda^+(V_1)+\Lambda^+(V_2)\subseteq\Lambda^2(V_1+V_2)$, so $U\subseteq V_1+V_2$ and $\dim U\le8$. At $m\ge10$ that is $<m$, and $W$ is then a padding of a $\mathrm{Weyl}_{\dim U}$ element. **The construction cannot be pushed to $m\ge10$ by any choice of the two planes or of $q,r$**, the obstruction is the count $4+4=8$, and the block's word "silent" understates it: this family is *provably* incapable there. That matters for §14, because it is the whole reason B0's question stays open above $m=8$.

**Odd $m$ and the small end are not addressed.** The construction visibly makes sense at $m=5$ and $m=7$ (two 4-planes meeting in a 3-plane, or a line), and [isotropy-cap.md](../findings/isotropy-cap.md) reports a $\theta$ value "at $m=7$" for this family, which presupposes an $m=7$ witness with the same properties. **No such witness is stated anywhere**, and I did not look for one, searching for further witnesses is outside what this loop permits. The lemma's title claims $m=6$ and $m=8$ and delivers them; the record's use of an $m=7$ number is a claim with no witness on file. At $m=4$ the claim would be trivially different ($\dim U=4=m$ from a single copy), and at $m=5$ nothing is on file.

## 13. The claimed conflict with $+0.6259$, there is no conflict

The block writes: $\theta=+0.485408612$ *"(measured, not derived, and [isotropy-cap.md](../findings/isotropy-cap.md) records $+0.6259$ for the same family, a conflict this block does not resolve)"*. I read the passage at source. It says:

> **exact** witnesses at $\theta=+0.485408612$ ($m=6$) and $+0.115574271$ ($m=8$), both with two negative eigenvalues and $\dim U=m$, from 4-planes in **general position** (Reviewer 60); random general-position draws reach $+0.6259$ at $m=6$ and $+0.2650$ at $m=7$.

**The two figures are the same quantity ($\theta$ at $m=6$ on the two-padded-$W_4$ family in general position), evaluated at different members of it.** One is a single exhibited witness; the other is the best value found in a sample of random draws. Both are lower bounds on the family's supremum, and a sample beating a named witness contradicts nothing, because $+0.485408612$ was never claimed to be a maximum: the sentence says the family "reach[es]" it. **So the recorded conflict is not one**, and the block's parenthesis overstates the situation.

What *is* wrong is smaller and different: the L34 block's phrasing "4-planes in general position keep the cross term and reach $\theta=+0.485408612$ at $m=6$" reads as though general position determined a value. It does not, $\theta$ varies over the configuration and over $q,r$, and the $+0.6259$ draw is the record's own demonstration of that. **The correct reading of both numbers is existential, and the block should say so instead of flagging a contradiction.**

## 14. What is refuted, and what survives

**Refuted.** [plan.md](../plan.md) had recorded item B0 as closing iff *no element of $\mathrm{Weyl}_m$ with $\dim\mathfrak m\le2$ has $\dim U=m$*, and had recorded the rank-3 question as an equivalent form of it. Two things go:

1. **The equivalence.** It holds only at one positive eigenvalue, for the reason checked in §11, the Ricci identity pins $U=\operatorname{im}v_1$ there and constrains nothing when the positive side has several eigenvalues.
2. **The statement itself, at $m=6$ and $m=8$.** The two witnesses are elements of $\mathrm{Weyl}_m$ with $\dim\mathfrak m=2$ and $\dim U=m$. The universal statement is therefore false as recorded.

**What survives, stated precisely.**

- **The refutation reaches exactly $m=6$ and $m=8$ and no further.** By §12 this family provably cannot reach $m\ge10$, so the recorded statement is untested by it at every dimension from $10$ up, which is where the stratum argument actually needed it, the chain's overshoot sitting at $n=12$. A reader who takes "the descent statement B0 rested on is refuted" as covering $n\ge12$ is reading more than the lemma gives.
- **The conclusion $\sup\theta\le\sqrt{3/2}$ on the stratum is not touched.** L34 removes a proof, not a theorem. The block says so, and now points at [L35](../findings/stratum-two-negative.md) as the replacement, the current text reads "is **closed** by [Lemma L35] below rather than differently proved", whereas the [isotropy-cap.md](../findings/isotropy-cap.md) copy still ends "So B0's conclusion is now unproved rather than differently proved". **The two copies of this block now disagree about the current status of B0's conclusion.** I make no finding on which is right (L35's own status is a separate row) but the divergence is a fact about the record.
- **[L33](../findings/stratum-two-negative.md) is not damaged by any of this.** L34 constrains only how L33 is read; see §15.

## 15. L34 as a constraint on L33's reading

The L33 block says: "Counted as *one distinct value at any multiplicity*, a witness sits already in $\mathrm{Weyl}_4$ … [Lemma L34] supplies a second witness at $m=8$."

**Checked, and it holds under one reading of L33's exception clause only.** At the $m=8$ witness the negative side is the single distinct value $-1/\sqrt3$ at multiplicity $2$ (and the positive side the single value $1/(2\sqrt3)$ at multiplicity $4$), so the distinct-value reading is in force on either side. L33's exception speaks of "that eigenvector", which is well defined only when the eigenspace is a line. With a 2-plane of eigenvectors here, two readings are available:

| reading of "that eigenvector" | does the $m=8$ witness refute the distinct-value reading of L33? |
| --- | --- |
| the generic member of the eigenspace | **yes**, $au_1+bz_1$ with $a,b\ne0$ has rank $8$ and is no complex-structure multiple on a 4-plane, yet $W\ne0$ |
| some member of the eigenspace | **no**, $u_1$ and $z_1$ are each complex structures on a 4-plane, so the exception applies and nothing is refuted |

This is the division [INDEX-results.md](../findings/INDEX-results.md) records between [r549](../reviews/REVIEW_r549.md) and [r550](../reviews/REVIEW_r550.md), and I reach the same fork independently. **The point that matters is that L33's repair does not depend on the fork**: its primary witness is the $\mathrm{Weyl}_4$ element $W^+=W^-=\operatorname{diag}(2,-1,-1)$, whose $+2$ eigenspace contains $(w_1^++w_1^-)\propto\varphi_{12}$ of rank $2$, and a rank-$2$ bivector is not a complex-structure multiple on a 4-dimensional subspace under *any* reading of the clause. So L33's note stands on its own witness, and citing L34 alongside it adds an ambiguity rather than strength.

## 16. The landscape bullet

> - **Lemma L34 (landscape). Full support with two negative eigenvalues, at $m=6$ and $m=8$.** Two padded signature-$(2,1)$ $\mathrm{Weyl}_4$ tensors on 4-planes sum to a $\mathrm{Weyl}_m$ element with $\dim U=m$, refuting the descent statement B0 rested on. In general position they reach $\theta=+0.485$.

Two defects, of different kinds.

**Quantifier scope in the first clause.** As written, "Two padded … tensors on 4-planes sum to a $\mathrm{Weyl}_m$ element with $\dim U=m$" is universal in the planes and in $m$: it says any such pair does this. That is **false at $m\ge10$** for every pair, by §12, and false at $m=6,8$ for pairs sharing a 3-plane. The title restores $m\in\{6,8\}$ for a reader who reads it as a hypothesis, but the sentence's own quantifier is wrong, and the canonical statement it summarises is existential ("there is a $W$"), not universal. **The bullet asserts a different kind of claim from the one the record cites.** The bullet also carries the one hypothesis the canonical block drops, "signature-$(2,1)$", which is the reverse of the usual direction of loss.

**The second clause is a measured value promoted into a landscape statement.** "In general position they reach $\theta=+0.485$" names no dimension, gives no witness, and drops the *"measured, not derived"* tag that the findings block attaches to the same number. Under this loop's rules a measured value is an open hypothesis; here it appears in [results.md](../results.md) with nothing marking it as one. It also states as characteristic of general position a value the record's own $+0.6259$ shows is not characteristic.

## 17. The third copy, and what it has diverged into, [isotropy-cap.md](../findings/isotropy-cap.md)

**1. Located.** In the paragraph "Corrected: these witnesses do not all have $\theta\le0$": "**The clause is safe only for orthogonal planes**, where the two $\Lambda^2$ summands are orthogonal and $P$ is additive, which is the special shape both recorded witnesses happen to have, and presumably how the error survived."

**2. Exhibited.** The table two lines above, in the same block, lists the $m=6$ witness as "overlapping in a 2-plane". At that witness the two summands are **not** Frobenius-orthogonal, $\langle A,B\rangle=\alpha_1\beta_1\langle u_1,z_1\rangle^2=(-2q)(-2q)\tfrac14=q^2=\tfrac1{14}\ne0$, and $P$ is **not** additive on it: $P(A)+P(B)=-36q^3$ against the true $P(A+B)=-54q^3$, a cross term of $-18q^3$, one third of the total. **So the sentence's explanation of "how the error survived" is false of one of the two witnesses it names**, and the actual reason $\theta\le0$ held at $m=6$ is the opposite of the one given: the cross term there is negative and *deepens* $\theta$ from $-0.6873$ to $-1.0309$.

**3. The opposite argued.** "Safe" can be read as "guaranteed", and it is true that orthogonality is what *guarantees* additivity; that reading leaves the first half of the sentence standing. It does not touch the trailing clause "which is the special shape both recorded witnesses happen to have", which is a factual claim about the two witnesses and is contradicted by the block's own table. No reading rescues it.

**This is a divergence between copies, not a shared error.** The canonical L34 block in [stratum-two-negative.md](../findings/stratum-two-negative.md) contains no such sentence. The block records the isotropy-cap copy as "an unlinked copy of this block"; it is now an unlinked copy that has drifted into a false statement about the canonical witnesses.

### 17a. Withdrawn, "additive only over Frobenius-orthogonal supports"

The L34 block writes "$P$ is cubic and additive only over Frobenius-orthogonal supports". I suspected this is imprecise: what my §2 derivation actually uses is that $\mathfrak{so}(V_1)$ and $\mathfrak{so}(V_2)$ commute, and separately I checked that $\langle A,B\rangle=0$ can hold while individual overlaps $\langle u_i,z_j\rangle$ do not vanish, in which case additivity would need re-deriving. **Withdrawn under step 2 of the protocol**: exhibiting such a configuration in closed form needs a search over plane pairs, which this loop reserves, and the one family I could write down by hand (two 4-planes sharing a 2-plane, with the complex structures aligned across the shared plane) has $\langle A,B\rangle=\alpha_1\beta_1/4$, of fixed sign and never zero. Recorded as an imprecision, not as a defect.

## 18. Provenance, "the duplication having been resolved on 2026-09-06" is false

**1. Located.** The italic note opening the L34 block: "**The first clause of the note that stood here survives against git, results.md did hold the only copy, and the second is now true, the duplication having been resolved on 2026-09-06**: that file carried the whole construction byte-identical and then points at the file duplicating it."

**2. Exhibited.** As of today [results.md](../results.md) lines 483–489 still carry the Statement **and** the whole Construction, and then say "**Proof:** [stratum-two-negative.md](../findings/stratum-two-negative.md)". I compared the two Construction paragraphs after whitespace normalisation: **identical, 512 characters each.** The duplication the note declares resolved is exactly the duplication that is still there, and the sentence's own second half describes the unresolved state in the present tense ("points at the file duplicating it").

**3. The opposite argued.** "The duplication" might mean the [isotropy-cap.md](../findings/isotropy-cap.md) copy rather than the [results.md](../results.md) one, but the same sentence ends by saying isotropy-cap "also holds an unlinked copy of this block", so that copy is explicitly recorded as unresolved too. And `git log` since 2026-09-05 shows no commit touching this block's duplication. Neither reading makes the claim true.

This matters beyond bookkeeping: §17 is a live demonstration that a third copy has already diverged into a false sentence, and a note asserting the copies were consolidated is the thing that stops the next reader from checking them against each other.

## 19. Symbol collisions

Checked against [conventions.md](../findings/conventions.md), which tables neither $q$, $r$, $U$, nor $W_4$.

| symbol | senses in play | status |
| --- | --- | --- |
| $q$ | an eigenvalue parameter of $W_4(q,r)$; **and** the Weitzenböck curvature term $q(R)\omega$ in the L33 block, 215 lines above, in the same file | **live collision, untabled** |
| $r$ | an eigenvalue parameter of $W_4(q,r)$; **and** the support dimension, "the support of $W$ is exactly $\operatorname{im}v_1$, of even dimension $r$" and "the induction runs down to $n=r$", both in the same file | **live collision, untabled** |
| $U$ | $\operatorname{im}v_{N-1}+\operatorname{im}v_N$ in L34 and in L30's statement; **and** $\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha$, the redefinition L30's own margin calls "the repair … one line" | two senses in one file; **they agree at L34's witnesses**, which have exactly two negative eigenvalues, so nothing here breaks |
| $N$ | $\binom n2$ per conventions, read at $n=m$ here | consistent; the substitution is unambiguous |
| $m$ vs $n$ | L34 works at $m$, L30/L35 at $n$, same object | consistent |
| $W_4(q,r)$ | defined identically in two files and tabled in neither, contrary to the record's own rule that a convention is quoted rather than restated | **two copies, currently in agreement**; the definition omits $\lVert w_i\rVert=1$, which the record's half-trace pairing supplies and which the printed spectra retroactively confirm |

## 20. Index hygiene

Neither $-\sqrt3/2$ at $m=8$ nor $-27\sqrt{14}/98$ at $m=6$ appears in [INDEX-values.md](../findings/INDEX-values.md). That file's only $\sqrt3/2$ row sits at $n=8$ against a different point, $(+\mathrm{Fox})\oplus(-\mathrm{Fox})$, and [second-order.md](../findings/second-order.md) carries $+\sqrt3/2$ at "$S^2\times S^2$ padded, two null coordinates" with the gloss "$\sqrt3/2=\sqrt{3/2}/\sqrt2$ is the harmonic-square value of two equal pieces", **the same mechanism that produces L34's $m=8$ value**, one level down, with $\Lambda^\pm$ in place of the two 4-planes. No conflict: the index states it holds $\theta$ at critical points, and L34's witnesses are not claimed to be critical. Recorded so the next reader who greps $0.866025$ knows why it appears twice.

## Verdict

**PROVEN, hypotheses corrected.**

The existence claim is true at both dimensions. I rebuilt both objects from the definitions, and every number the block prints is exactly right: $(-3,-1,1,1,1,1)/\sqrt{14}$ with $\theta=-27\sqrt{14}/98=-1.0308648$, and $\{-1/\sqrt3\,(\times2),1/(2\sqrt3)\,(\times4)\}$ with $\theta=-\sqrt3/2$, both of unit norm, both with $\dim U=m$, both with $\operatorname{tr}W^\#=-1$. The corrections the hypotheses need are: **$q,r>0$**, stated nowhere and load-bearing (§9); **$q=r=q'=r'$**, which the recorded spectra require and the Construction does not say (§10); and **$m\ge6$** on the L33 citation (§11). Two of the Construction's sentences are false as mechanisms at the $m=6$ witness, "each summand contributes exactly one negative eigenvalue" (§6) and "the support is the union of the planes" (§7), while their conclusions hold there by the explicit spectra.

**Attached HYPOTHESIS-DEBT, none of it inside the statement.** What would have to be proved for the block's margins to be evidence rather than record: (i) $\theta=+0.485408612$ at $m=6$ and $+0.115574271$ at $m=8$, both marked measured and not derived; (ii) $+0.6259$ at $m=6$ and $+0.2650$ at $m=7$, the second presupposing an $m=7$ witness that is stated nowhere; (iii) "at $m\ge10$ … a structured convex screen finds every rank class infeasible and a one-parameter deformation shows the margin reaching zero only where the support degenerates", which is presented as fact with no tag and is the only thing standing where §12 shows this family provably cannot go.

**Three defects outside the statement, each cleared through all three steps of the protocol:** the isotropy-cap copy's claim that both recorded witnesses have orthogonal planes (§17, BROKEN); the provenance note's claim that the results.md duplication was resolved (§18, BROKEN); and the landscape bullet's universal quantifier plus its untagged $+0.485$ (§16). One candidate was **withdrawn**: "additive only over Frobenius-orthogonal supports" (§17a), because exhibiting the failure needs a search this loop reserves.

## What would falsify the statement, and what I did to look for it

**This is an existence claim, so falsifying it means proving no such $W$ exists**, a proof that every $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues has $\dim U<m$, at $m=6$ or at $m=8$. Since I exhibited two such $W$ in closed form and verified every defining condition on them, no such proof can exist unless one of my objects fails a hypothesis. So the falsification I actually hunted was of my own construction, at the four places it could break:

1. **Membership.** Checked directly, not inherited: each summand has $W^-=0$ and $W^+$ trace-free, so its $\Lambda^4$ component and its trace-free Ricci block both vanish; padding preserves both; $\mathrm{Weyl}_m$ is a linear subspace, so the sum is in it. Independently, $\operatorname{tr}W^\#=-1$ came out at both witnesses, and that identity holds only under first Bianchi and Ricci-flatness.
2. **The eigenvalue count.** The $m=6$ spectrum is the root of an explicit quadratic, $\lambda^2+4q\lambda+3q^2$, with roots $-q,-3q$, two negatives, and the discriminant $4q^2>0$ rules out a coincidence that would hide a third. The $m=8$ count is a direct sum. Subadditivity of negative inertia caps both at two independently.
3. **$\dim U$.** Computed from the eigenvectors as skew matrices, not from the planes: $(u_1+z_1)/\sqrt3$ has three nonzero $2\times2$ blocks at $m=6$, and every orthonormal basis of the degenerate negative plane at $m=8$ has at least one member of rank $8$.
4. **Normalisation.** The one place a factor could hide, per [conventions.md](../findings/conventions.md)'s live $\sqrt2$ trap. Both norms were computed under the half-trace pairing, $\lVert\varphi_{ab}\rVert=1$, and both cross-checked: $\sum\lambda^2=1$ at each witness, and $\theta$ at a single normalised summand came out $-\sqrt{3/2}$ by two independent routes, $\operatorname{tr}A^3+\langle A,A^\#\rangle$ and the $\mathrm{Weyl}_4$ closed form $9\det W^+$.

**No numerical work of any kind was done.** I ran one comparison of two paragraphs of prose for byte-identity, which decides §18 and touches no mathematics. I did not search for further witnesses, did not repair any gap I found, and did not attempt the $m=5$, $m=7$ or $m\ge10$ questions the block leaves open.
