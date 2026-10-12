# Verifier v163, Lemma L34, full support with two negative eigenvalues at $m=6$ and $m=8$

The brief was cold: both exhibited objects were rebuilt from the definitions in [conventions.md](../findings/conventions.md) and from $W_4(q,r)$ as [stratum-two-negative.md](../findings/stratum-two-negative.md) writes it, without reading the prior reviews of this row until the derivations were finished. **No numerical work was done. Nothing was executed, no script, no Sage, no Python, no floating-point evaluation.** Every spectrum, every structure constant, every trace and every $\theta$ below is exact rational or exact surd arithmetic done by hand; the two decimal figures that appear are conversions of closed forms I derived, given so they can be compared with the record's printed digits. Log: [agent_logs/verify-L34-v163.log](../agent_logs/verify-L34-v163.log).

## Claim table

| # | claim, as the record states it | verdict |
| --- | --- | --- |
| 1 | **Statement at $m=6$**: $\exists W\in\mathrm{Weyl}_6$ with exactly two negative eigenvalues and $\dim U=6$ | **CONFIRMED**, witness rebuilt in closed form |
| 2 | **Statement at $m=8$**: the same at $m=8$ | **CONFIRMED**, witness rebuilt in closed form |
| 3 | $m=8$ spectrum $\{-1/\sqrt3\,(\times2),\ 1/(2\sqrt3)\,(\times4)\}$ | **CONFIRMED at $q=r$ only**, false for the construction's other parameters |
| 4 | $m=8$ value $\theta=-\sqrt3/2$ | **CONFIRMED, exactly**, $P=-36$, $\lVert W\rVert^2=12$ |
| 5 | $m=6$ spectrum $(-3,-1,1,1,1,1)/\sqrt{14}$ | **CONFIRMED at one alignment only**, needs $q=r$ *and* an unstated frame condition |
| 6 | $m=6$ value $\theta=-1.030865$ | **CONFIRMED, and the closed form is $-27/(7\sqrt{14})$**, the record carries only the decimal |
| 7 | "Both defining conditions are linear, so the sum is a $\mathrm{Weyl}_m$ element whatever the planes do" | **TRUE BUT INCOMPLETE**, linearity is right; the step it rests on, that each *padded* summand is in $\mathrm{Weyl}_m$, is never taken |
| 8 | "each summand contributes exactly one negative eigenvalue" | **FALSE AT THE $m=6$ WITNESS**, the count survives, the attribution does not |
| 9 | "the support is the union of the planes", as the reason for $\dim U=m$ | **FALSE AT THE $m=6$ WITNESS**, it gives the wrong inclusion, and the conclusion holds for a different reason |
| 10 | the parameters $q,r$ | **HYPOTHESIS USED BUT NEVER STATED**, both displayed spectra require $q=r$ |
| 11 | "planes meeting in a 2-plane at $m=6$" | **HYPOTHESIS USED BUT NEVER STATED**, the phrase underdetermines the configuration |
| 12 | $\dim U=m$ at each witness | **CONFIRMED** in closed form at both |
| 13 | "Why the recorded equivalence fails", the displayed Ricci-flatness identity | **CONFIRMED**, both halves |
| 14 | "[isotropy-cap.md](../findings/isotropy-cap.md) records $+0.6259$ for the same family, a conflict this block does not resolve" | **NO CONFLICT EXISTS**, the two figures are the same quantity at different points of one family |
| 15 | landscape bullet, "In general position they reach $\theta=+0.485$" | **DEFECTIVE**, the block's hedge is stripped, and the cited file's own larger figure contradicts it |
| 16 | [isotropy-cap.md](../findings/isotropy-cap.md), "the special shape both recorded witnesses happen to have" | **FALSE**, the $m=6$ witness's summands are not Frobenius-orthogonal, $\langle A,B\rangle=1$ |
| 17 | "the duplication having been resolved on 2026-09-06" | **FALSE**, [results.md](../results.md) still carries the whole construction |
| 18 | $+0.485408612$, $+0.115574271$, $+0.6259$, and the $m\ge10$ convex screen | **HYPOTHESIS-DEBT**, all measured, none derived |
| 19 | L34's citation inside [L33](../findings/stratum-two-negative.md)'s multiplicity note | **CONFIRMED**, the $m=8$ witness does what that note asks of it |
| 20 | $\ker W\ne0$ | **HARMLESS TO L34**, but "full support" is a statement about $U$, not about $\ker W$, and the two are far apart here |
| 21 | symbol collisions | **$q$ AND $r$ EACH CARRY TWO SENSES IN THIS ONE FILE**, neither tabled |
| 22 | [b0_full_support_witness.py](../scripts/lib/b0_full_support_witness.py) docstring, "Every such witness has theta <= 0" | **REFUTED BY THE RECORD ITSELF**, and still standing |

## One-line summary

**The statement is true and both witnesses check out exactly**, I recovered $\theta=-\sqrt3/2$ at $m=8$ and the previously-undisplayed closed form $\theta=-27/(7\sqrt{14})$ at $m=6$, **but two of the construction's three stated reasons are false at the $m=6$ witness, and both displayed spectra rest on parameter and frame conditions the record never writes down.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

> $Q(W)$ | Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself

> $P(W)$ | the cubic form $\langle W,Q(W)\rangle$

> $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$

> $N$ | $\binom n2=\dim\Lambda^2\mathbb R^n$

> **A skew matrix's norm**, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}X)$, singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_i s_i^2=1$.

> **A bivector's norm**, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal

> **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, the inner product being ad-invariant; so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide.

> **Sums over pairs are over ORDERED pairs** unless the line says otherwise.

> **Padding commutes with $Q$**, and preserves both the norm and $\theta$. The stratum reduction turns on this.

> $\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$

The eigen-expansion of the cubic is quoted from [Lemma L29](../findings/stratum-two-negative.md)'s own proof, which is where every consumer of it in this file reads it:

> In an eigenbasis, $\langle W,W^\#\rangle=\tfrac12\sum T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ with $T=c'^2$ nonnegative and totally symmetric.

and the norm normalisation from the same proof, which pins $\lVert W\rVert^2=\sum_\alpha\lambda_\alpha^2$:

> Trace-freeness gives $\lambda_1=a+b$ and unit norm $(a+b)^2+a^2+b^2=1$

I calibrated both against the record's own anchor before using them: at padded $W_{\mathbb{CP}^2}$, spectrum $(2,-1,-1)/\sqrt6$, they give $\operatorname{tr}W^3=6/6^{3/2}$ and $\langle W,W^\#\rangle=3\cdot2\cdot2/6^{3/2}$, summing to $18/6^{3/2}=\sqrt{3/2}$, the value [L29](../findings/stratum-two-negative.md) records. The conventions are the ones the proofs commit to.

## 1. Hypothesis inventory

**A pass with no inventory is not a pass, so here is the full list, with what the written proof actually uses.**

### 1.1 What $\mathrm{Weyl}_m$ membership requires

Three conditions, all linear in $W\in S^2(\Lambda^2\mathbb R^m)$:

| # | condition | linear? | used in the block? |
| --- | --- | --- | --- |
| (W1) | pair symmetry, $W$ is a symmetric operator on $\Lambda^2$ | yes | assumed silently |
| (W2) | first Bianchi, $\mathrm{Alt}(W)=0$ | yes | **counted as one of "both defining conditions"** |
| (W3) | Ricci-flatness, $\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=0$, equivalently $\operatorname{Ric}(W)=0$ | yes | **counted as the other** |

**The block names neither.** It says only "*Both defining conditions are linear*". Two readings are available and they are not the same condition: (W3) as stated, or the weaker $\operatorname{tr}W=0$. Only (W3) is enough (a trace-free non-Ricci-flat operator on $\Lambda^2$ is not a Weyl operator) and (W3) is what the witnesses actually satisfy, which I verify at §5.3. Under either reading linearity holds, so the ambiguity costs nothing here; it costs a reader the ability to check.

### 1.2 What $W_4(q,r)$ is, and what $q,r$ must satisfy

From [stratum-two-negative.md](../findings/stratum-two-negative.md), the L33 block, quoted:

> On $\mathbb R^4$ the self-dual forms are complex structures, and $W_4(q,r)=-(q+r)\,w_1\otimes w_1+q\,w_2\otimes w_2+r\,w_3\otimes w_3$ lies in $\mathrm{Weyl}_4$ with signature $(2,1)$

So $\{w_1,w_2,w_3\}$ is an orthonormal basis of $\Lambda^+\mathbb R^4$, each $w_i$ a unit complex structure, and $W_4(q,r)$ has $\Lambda^2\mathbb R^4$-spectrum $\{-(q+r),\,q,\,r,\,0,0,0\}$, the three zeros being $\Lambda^-$.

**What $q,r$ must satisfy is stated nowhere.** From the sentence's own content, $q,r>0$ is needed for signature $(2,1)$ (i.e. exactly one negative eigenvalue); $q+r>0$ is needed for the negative eigenvalue to be negative. Nothing pins them further. **Both of L34's displayed spectra require $q=r$, and the $m=6$ one requires $q=r$ in both copies with the same value.** This is a hypothesis the proof uses and never states, §4.

Membership in $\mathrm{Weyl}_4$: $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, and $W_4(q,r)$ lies in $S^2(\Lambda^+)$ with coefficient sum $-(q+r)+q+r=0$, hence in $S^2_0(\Lambda^+)$. (W2) holds because each $w_i\wedge w_i$ is the same volume form for self-dual $w_i$, so the $\Lambda^4$ component is proportional to the coefficient sum; (W3) holds because $w_iw_i^{\mathsf T}=\tfrac12 I$ for a unit complex structure, so $\sum_i c_i w_iw_i^{\mathsf T}=\tfrac12(\sum c_i)I=0$. **The block imports this decomposition and cites it nowhere.**

### 1.3 What $\dim U=m$ means

The statement's own definition: $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$, with $N=\binom m2$. Two things it presupposes and does not say:

- **an eigenvalue ordering.** The indices $N-1,N$ pick the *last two* of $N$ eigenvalues, so the ordering must be descending for $v_{N-1},v_N$ to be the two negative eigenvectors. [conventions.md](../findings/conventions.md) tables $N$ but not the ordering. **The $m=6$ claim is order-sensitive**: under an ascending reading, $v_{N-1},v_N$ would be two of the four $+1/\sqrt{14}$ eigenvectors, and a choice of two whose images are both $V_A$ gives $\dim U=4\ne6$. The descending reading is unambiguously the record's, [L29](../findings/stratum-two-negative.md) writes $\lambda_1>0>-a\ge-b$ and calls the negatives $v_{N-1},v_N$, so I read it that way throughout, and the claim is true under it.
- **the identification of a $\Lambda^2$ eigenvector with a skew matrix**, so that $\mathrm{im}\,v$ means anything. Untabled, but forced by [conventions.md](../findings/conventions.md)'s skew-matrix norm bullet.

### 1.4 The results imported

| import | hypotheses | checked against the object? |
| --- | --- | --- |
| $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ | $m=4$ | uncited in the block; verified in §1.2 |
| padding a $\mathrm{Weyl}_4$ element into $\mathrm{Weyl}_m$ preserves membership | none | **not taken as a step**, see §3 |
| [conventions.md](../findings/conventions.md)'s "Padding commutes with $Q$, and preserves both the norm and $\theta$" | none | this is about $Q$ and $\theta$, **not about membership**; it cannot discharge the step above |
| [L33](../findings/stratum-two-negative.md) | exactly one eigenvalue on one side, counted with multiplicity; that eigenvector not a $4$-plane complex-structure multiple | **cited in the motivation only, and never used**, correctly, since both witnesses have two negatives and sit outside its hypothesis |
| the $m\ge10$ "structured convex screen" and "one-parameter deformation" | unstated | **imported with no citation at all**, §9 |

**A hypothesis stated but never used.** There is none in the statement: $m\in\{6,8\}$ is used, and the rest of the statement is conclusion. **A step using a hypothesis never stated**: two, $q=r$ and the $m=6$ frame alignment, both at §4.

### 1.5 [L33](../findings/stratum-two-negative.md), whose reading this result is cited to constrain

> **Statement.** Let $W\in\mathrm{Weyl}_m$ have a **one-dimensional** eigenspace on one side, exactly one eigenvalue counted *with multiplicity*. If that eigenvector is not a multiple of a complex structure on a $4$-dimensional subspace, then $W=0$.

L34's role there is the note that follows it: *"[Lemma L34] supplies a second witness at $m=8$"*, a witness to L33 being false under the *distinct-value* reading. §8 checks that it does.

## 2. The $m=8$ witness, rebuilt

**Configuration.** $V_A=\langle e_1,e_2,e_3,e_4\rangle$, $V_B=\langle e_5,e_6,e_7,e_8\rangle$, orthogonal. Write $E_{ij}$ for the skew matrix with $+1$ at $(i,j)$ and $-1$ at $(j,i)$; $\lVert E_{ij}\rVert=1$ under the half-trace pairing, and $\{E_{ij}\}_{i<j}$ is orthonormal. The unit self-dual forms of $V_A$ are

$$w^A_1=\tfrac1{\sqrt2}(E_{12}+E_{34}),\qquad w^A_2=\tfrac1{\sqrt2}(E_{13}-E_{24}),\qquad w^A_3=\tfrac1{\sqrt2}(E_{14}+E_{23}),$$

and $w^B_i$ the same on $V_B$. Take $A=W_4(1,1)$ on $V_A$ and $B=W_4(1,1)$ on $V_B$, i.e.

$$A=-2P_{w^A_1}+P_{w^A_2}+P_{w^A_3},\qquad B=-2P_{w^B_1}+P_{w^B_2}+P_{w^B_3},\qquad W=A+B .$$

**Spectrum.** The six bivectors are mutually orthonormal ($V_A\perp V_B$ gives disjoint index sets), so $W$ is already diagonal in them:

$$\operatorname{spec}W=\{-2,-2,1,1,1,1\}\cup\{0^{\times22}\},\qquad \lVert W\rVert^2=4+4+1+1+1+1=12 .$$

Normalising, $-2/\sqrt{12}=-1/\sqrt3$ at multiplicity $2$ and $1/\sqrt{12}=1/(2\sqrt3)$ at multiplicity $4$. **This is the recorded spectrum, exactly.**

**Structure constants.** $[E_{12},E_{13}]=-E_{23}$, $[E_{12},E_{24}]=E_{14}$, $[E_{34},E_{13}]=-E_{14}$, $[E_{34},E_{24}]=E_{23}$, from $[E_{ij},E_{jk}]=E_{ik}$. Hence

$$[w^A_1,w^A_2]=\tfrac12\big(-E_{23}-E_{14}-E_{14}-E_{23}\big)=-(E_{14}+E_{23})=-\sqrt2\,w^A_3 ,$$

so $c_{123}^A=-\sqrt2$, $T^A_{123}=2$ and $\lVert[w^A_1,w^A_2]\rVert^2=2$, the pair cap saturated, as [L29](../findings/stratum-two-negative.md) says every orthonormal pair in $\Lambda^+\cong\mathfrak{su}(2)$ does. The same holds for each pair, and every cross bracket $[w^A_i,w^B_j]$ vanishes on disjoint index sets.

**The cubic.** $\operatorname{tr}W^3=2(-8+1+1)=-12$. For $\langle W,W^\#\rangle$ each unordered triple carries $6$ ordered permutations, so the $\tfrac12$ becomes a $3$:

$$\langle W,W^\#\rangle=3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma=3\big[2\cdot(-2)\cdot1\cdot1\big]\times2\ \text{copies}=-24 .$$

$$P(W)=-12-24=-36,\qquad \theta=\frac{-36}{12^{3/2}}=\frac{-3}{\sqrt{12}}=-\frac{\sqrt3}2 .$$

**This is the recorded value, exactly.**

**Independent cross-check.** $\operatorname{tr}W^\#=\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta\lVert[v_\alpha,v_\beta]\rVert^2$. Within each copy the three pairs give $(-2)(1)(2)+(-2)(1)(2)+(1)(1)(2)=-6$; cross pairs vanish; total $-12=-\lVert W\rVert^2$. The identity $\operatorname{tr}W^\#=-\lVert W\rVert^2$ holds because $Q$ preserves $\mathcal W_n$, so this is a necessary condition on Weyl membership and the witness passes it. Normalised, $\operatorname{tr}W^\#=-1$, which is what [INDEX-results.md](../findings/INDEX-results.md) row 34 records the previous two reviewers recovering.

**$\dim U=8$.** The eigenvalue $-1/\sqrt3$ has a two-dimensional eigenspace $\langle w^A_1,w^B_1\rangle$. Each $w^A_1=\tfrac1{\sqrt2}(E_{12}+E_{34})$ has rank $4$ with image $V_A$; $w^B_1$ has image $V_B$; so $U=V_A\oplus V_B=\mathbb R^8$. **The degeneracy does not spoil this**: any basis $\cos\phi\,w^A_1+\sin\phi\,w^B_1$, $-\sin\phi\,w^A_1+\cos\phi\,w^B_1$ of the eigenspace consists of block-diagonal skew matrices whose images sum to $\mathbb R^8$ for every $\phi$ (at $\phi\notin\tfrac\pi2\mathbb Z$ each single one already has rank $8$). $\dim U=8=m$ at every admissible choice. **CONFIRMED.**

## 3. Weyl membership, the linearity step, and the step it hides

The block's whole membership argument is one clause: *"Both defining conditions are linear, so the sum is a $\mathrm{Weyl}_m$ element whatever the planes do."*

**The linearity is correct.** (W2) is $\mathrm{Alt}(W)=0$ and (W3) is $\operatorname{Ric}(W)=0$; both are the vanishing of a linear map on $S^2(\Lambda^2\mathbb R^m)$, so $\mathrm{Weyl}_m$ is a linear subspace and closed under addition with no hypothesis relating the summands. So "*whatever the planes do*" is exactly right, and it is the strongest thing in the block.

**The step it rests on is missing.** Linearity gives $A+B\in\mathrm{Weyl}_m$ only once $A\in\mathrm{Weyl}_m$ and $B\in\mathrm{Weyl}_m$. $A$ is not $W_4(q,r)$; it is $W_4(q,r)$ *padded* into $\mathbb R^m$, and the block never establishes that padding preserves membership. It cannot borrow [conventions.md](../findings/conventions.md)'s padding bullet, which asserts only that padding commutes with $Q$ and preserves the norm and $\theta$, three statements, none of them membership.

The step is one line and is available: for $W$ supported on $V\subseteq\mathbb R^m$, $\mathrm{Alt}(W)_{ijkl}$ vanishes unless all four indices lie in $V$, where it is the $\Lambda^4V$ component of a $\mathrm{Weyl}_4$ element and hence zero; and $\operatorname{Ric}(W)_{ij}=\sum_kW_{ikjk}$ vanishes unless $i,j\in V$, where it is the $\mathrm{Weyl}_4$ Ricci and hence zero. **I record this as the missing step, not as a repair, supplying it is not mine to do.** The same clause appears verbatim in [isotropy-cap.md](../findings/isotropy-cap.md) as "*Weyl membership needs no check beyond the arithmetic, both conditions being linear*", with the same omission.

Verdict on claim 7: **TRUE BUT INCOMPLETE.**

## 4. The $m=6$ witness, rebuilt, and the two hypotheses the record does not state

### 4.1 The configuration the spectrum requires

**"Planes meeting in a 2-plane" does not determine the answer.** Take $V_A=\langle e_1,e_2,e_5,e_6\rangle$ and $V_B=\langle e_3,e_4,e_5,e_6\rangle$, meeting in $\langle e_5,e_6\rangle$. Their self-dual forms, at orientation $o_1,o_2\in\{\pm1\}$:

$$w^A_1=\tfrac{E_{12}+o_1E_{56}}{\sqrt2},\quad w^A_2=\tfrac{E_{15}-o_1E_{26}}{\sqrt2},\quad w^A_3=\tfrac{E_{16}+o_1E_{25}}{\sqrt2},$$
$$w^B_1=\tfrac{E_{34}+o_2E_{56}}{\sqrt2},\quad w^B_2=\tfrac{E_{35}-o_2E_{46}}{\sqrt2},\quad w^B_3=\tfrac{E_{36}+o_2E_{45}}{\sqrt2}.$$

The only non-orthogonality among these six is $\langle w^A_1,w^B_1\rangle=o_1o_2/2=:c$, since $E_{56}$ is the only basis bivector common to $\Lambda^2V_A$ and $\Lambda^2V_B$. So the six are linearly independent, $W$ has rank $6$, and $\ker W$ has dimension $15-6=9$.

**Two choices are now free and the record fixes neither.** Which self-dual form carries the negative coefficient in each summand, and the values $q,r$. Taking $q=r=1$ in both, so that $A=-3P_{a}+\Pi_A$ with $\Pi_A$ the orthogonal projection onto $\Lambda^+(V_A)$ and $a$ the chosen negative eigenvector, and similarly for $B$:

| choice of $a,b$ | resulting unnormalised spectrum |
| --- | --- |
| $a=w^A_1$, $b=w^B_1$ | $(-3,-1,1,1,1,1)$, **the recorded one**, $\lVert W\rVert^2=14$ |
| $a=w^A_1$, $b=w^B_2$ | $\big(-2,\tfrac{-1-\sqrt7}2,\tfrac{-1+\sqrt7}2,1,1,1\big)$, $\lVert W\rVert^2=12$ |
| $a=w^A_2$, $b=w^B_2$ | $(-2,-2,\tfrac32,\tfrac12,1,1)$, $\lVert W\rVert^2=\tfrac{25}2$ |

All three have exactly two negative eigenvalues, and only the first has the recorded spectrum. **So "planes meeting in a 2-plane at $m=6$ give $(-3,-1,1,1,1,1)/\sqrt{14}$" is false read as written**, and true read existentially. And a further condition is hidden in my choice of $V_A,V_B$: I placed them so that $V_A\ominus(V_A\cap V_B)\perp V_B\ominus(V_A\cap V_B)$. Two 4-planes in $\mathbb R^6$ meeting in a 2-plane are a positive-dimensional family with nontrivial principal angles, and [isotropy-cap.md](../findings/isotropy-cap.md) records that the general member of that family has $\theta>0$, so the special relative position is load-bearing and unstated.

### 4.2 The recorded case, in closed form

Write $x=w^A_1$, $y=w^B_1$, $\langle x,y\rangle=c=\pm\tfrac12$, $T=\langle x,y\rangle$-plane $=\operatorname{span}(x,y)$ and $R=\operatorname{span}(w^A_2,w^A_3,w^B_2,w^B_3)$, which is orthonormal and orthogonal to $T$. Then

$$W=\Pi_A+\Pi_B-3(P_x+P_y).$$

On $R$: $P_x,P_y$ vanish and $\Pi_A+\Pi_B$ acts as the identity, so $W|_R=\mathrm{Id}_R$, **eigenvalues $1,1,1,1$.**

On $T$: $\Pi_A|_T=P_x|_T$ and $\Pi_B|_T=P_y|_T$, so $W|_T=-2(P_x+P_y)|_T$. For unit $x,y$ with $\langle x,y\rangle=c$, the operator $P_x+P_y$ on $\operatorname{span}(x,y)$ has eigenvalues $1\pm|c|$, at eigenvectors $x\pm\operatorname{sgn}(c)y$. With $|c|=\tfrac12$: eigenvalues $\tfrac32$ and $\tfrac12$, so

$$W|_T\ \text{has eigenvalues}\ -3\ \text{and}\ -1 .$$

$$\operatorname{spec}W=(-3,-1,1,1,1,1)\cup\{0^{\times9}\},\qquad \lVert W\rVert^2=9+1+4=14 .$$

**The recorded spectrum, exactly, and it does not depend on the orientation signs, only on $|c|=\tfrac12$.**

Take $o_1=o_2=1$, so $c=\tfrac12$. The eigenvectors are

$$u_1=\tfrac{x+y}{\sqrt3}=\tfrac{E_{12}+E_{34}+2E_{56}}{\sqrt6}\ (\lambda=-3),\qquad u_2=x-y=\tfrac{E_{12}-E_{34}}{\sqrt2}\ (\lambda=-1),$$
$$u_3=w^A_2,\ u_4=w^A_3,\ u_5=w^B_2,\ u_6=w^B_3\ (\lambda=+1).$$

Norms: $\lVert x+y\rVert^2=2+2c=3$ and $\lVert x-y\rVert^2=2-2c=1$, so both are units as written.

### 4.3 The structure constants, all of them

Only triples inside $\{u_1,\dots,u_6\}$ contribute, the rest of the eigenbasis being kernel. Using $[E_{ij},E_{jk}]=E_{ik}$ throughout:

$$[u_1,u_3]=\tfrac1{\sqrt{12}}\big(-E_{25}-E_{16}-2E_{16}-2E_{25}\big)=-\tfrac{3}{\sqrt{12}}(E_{16}+E_{25})=-\tfrac3{\sqrt6}\,u_4,$$
$$[u_1,u_5]=\tfrac1{\sqrt{12}}\big(-E_{45}-E_{36}-2E_{36}-2E_{45}\big)=-\tfrac3{\sqrt6}\,u_6,$$
$$[u_2,u_3]=\tfrac12\big(-E_{25}-E_{16}\big)=-\tfrac1{\sqrt2}\,u_4,\qquad [u_2,u_5]=\tfrac12\big(E_{45}+E_{36}\big)=+\tfrac1{\sqrt2}\,u_6,$$
$$[u_3,u_4]=-(E_{12}+E_{56})=-\sqrt2\,x,\qquad [u_5,u_6]=-(E_{34}+E_{56})=-\sqrt2\,y,$$
$$[u_1,u_2]=0\quad(E_{12},E_{34},E_{56}\ \text{pairwise commute}).$$

Every cross bracket between $\{u_3,u_4\}$ and $\{u_5,u_6\}$ leaves the span: $[u_3,u_5]=-\tfrac12(E_{13}+E_{24})$, $[u_3,u_6]=\tfrac12(E_{23}-E_{14})$, $[u_4,u_5]=\tfrac12(E_{14}-E_{23})$ up to sign, $[u_4,u_6]=-\tfrac12(E_{13}+E_{24})$, none of $E_{13},E_{14},E_{23},E_{24}$ appears in any $u_\alpha$, so **all these triples carry $T=0$.**

Total antisymmetry checks out as a control: $x=(\sqrt3u_1+u_2)/2$ from the two displayed eigenvectors, so $\langle[u_3,u_4],u_1\rangle=-\sqrt2\cdot\tfrac{\sqrt3}2=-\tfrac{\sqrt6}2=-\tfrac3{\sqrt6}=\langle[u_1,u_3],u_4\rangle$ ✔, and $\langle[u_3,u_4],u_2\rangle=-\tfrac{\sqrt2}2=-\tfrac1{\sqrt2}=\langle[u_2,u_3],u_4\rangle$ ✔.

So the complete list of nonvanishing $T$ on the support is

$$T_{134}=T_{156}=\tfrac96=\tfrac32,\qquad T_{234}=T_{256}=\tfrac12,$$

everything else zero.

### 4.4 The cubic, and the closed form the record does not carry

$$\operatorname{tr}W^3=-27-1+1+1+1+1=-24 .$$

$$\langle W,W^\#\rangle=3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma =3\Big[\tfrac32(-3)+\tfrac12(-1)+\tfrac32(-3)+\tfrac12(-1)\Big]=3(-10)=-30 .$$

$$P(W)=-24-30=-54,\qquad \boxed{\ \theta=\frac{-54}{14^{3/2}}=-\frac{54}{14\sqrt{14}}=-\frac{27}{7\sqrt{14}}\ }$$

$27/(7\sqrt{14})=27/26.191601707\ldots=1.0308648\ldots$, which is the recorded $-1.030865$ to every printed digit. **CONFIRMED, and the record carries only the decimal, the closed form is $-27/(7\sqrt{14})$, equivalently $-\tfrac{27\sqrt{14}}{98}$.**

### 4.5 Two independent controls on the $m=6$ witness

**Control 1, $\operatorname{tr}W^\#=-\lVert W\rVert^2$.** The bracket norms are $\lVert[u_1,u_j]\rVert^2=\tfrac32$ for $j\in\{3,4,5,6\}$; $\lVert[u_2,u_j]\rVert^2=\tfrac12$ for the same four; $\lVert[u_3,u_4]\rVert^2=\lVert[u_5,u_6]\rVert^2=2$; $\lVert[u_3,u_5]\rVert^2=\cdots=\lVert[u_4,u_6]\rVert^2=\tfrac12$ for the four cross pairs; $\lVert[u_1,u_2]\rVert^2=0$. Then

$$\operatorname{tr}W^\#=\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta\lVert[v_\alpha,v_\beta]\rVert^2 =0+4(-3)(\tfrac32)+4(-1)(\tfrac12)+2+2+4(\tfrac12)=-18-2+2+2+2=-14 ,$$

which is $-\lVert W\rVert^2$ exactly, and $-1$ after normalisation. ✔

**Control 2, Ricci-flatness, coefficient by coefficient.** With $d_i=e_ie_i^{\mathsf T}$ and $u u^{\mathsf T}=-u^2$:

$$u_1u_1^{\mathsf T}=\tfrac16(d_1+d_2+d_3+d_4+4d_5+4d_6),\qquad u_2u_2^{\mathsf T}=\tfrac12(d_1+d_2+d_3+d_4),$$
$$u_3u_3^{\mathsf T}+u_4u_4^{\mathsf T}=d_1+d_2+d_5+d_6,\qquad u_5u_5^{\mathsf T}+u_6u_6^{\mathsf T}=d_3+d_4+d_5+d_6 .$$

$$\sum_\alpha\lambda_\alpha u_\alpha u_\alpha^{\mathsf T}=-\tfrac12(d_1{+}d_2{+}d_3{+}d_4{+}4d_5{+}4d_6)-\tfrac12(d_1{+}d_2{+}d_3{+}d_4)+(d_1{+}d_2{+}d_5{+}d_6)+(d_3{+}d_4{+}d_5{+}d_6)=0 ,$$

every coefficient vanishing: $-\tfrac12-\tfrac12+1=0$ at $d_1,\dots,d_4$ and $-2+1+1=0$ at $d_5,d_6$. **The witness is Ricci-flat, exactly, and (W2) follows from linearity once §3's missing step is supplied.** ✔

**Control 3, the norm decomposes as it must.** $\lVert A\rVert^2=\lVert B\rVert^2=4+1+1=6$, and $\lVert W\rVert^2=14$, so $\langle A,B\rangle=1$. Independently, $\Pi_A$ acts as $P_x$ on $B$'s span, so $\operatorname{tr}(AB)=\operatorname{tr}\big((-3P_x+P_x)(-3P_y+P_y)\big)=4\operatorname{tr}(P_xP_y)=4c^2=1$ ✔. **This is the number §7 turns on.**

### 4.6 $\dim U=6$

$$u_1=\tfrac1{\sqrt6}(E_{12}+E_{34}+2E_{56})$$

is block-diagonal with three $2\times2$ blocks of coefficients $1,1,2$, all nonzero, hence rank $6$: $\mathrm{im}\,u_1=\mathbb R^6$ already. $u_2=\tfrac1{\sqrt2}(E_{12}-E_{34})$ has rank $4$ with $\mathrm{im}\,u_2=\langle e_1,e_2,e_3,e_4\rangle$. So $U=\mathbb R^6$ and $\dim U=6=m$. **CONFIRMED.**

Both eigenvalues are simple, so there is no basis freedom to worry about here.

## 5. "Each summand contributes exactly one negative eigenvalue", and the support claim

### 5.1 The count survives overlap; the attribution does not

**What is true.** If $A$ has $p$ negative eigenvalues it is positive semidefinite on a subspace of codimension $p$; intersecting the two such subspaces gives codimension $\le p+q$, on which $A+B\succeq0$. So $n_-(A+B)\le n_-(A)+n_-(B)=2$ **whatever the planes do**. That is a genuine one-line argument and it is not in the block.

**What is false.** *"Each summand contributes exactly one negative eigenvalue"* asserts an attribution, and at the $m=6$ witness there is none to make. Each summand's negative eigenvalue is $-2$ at eigenvector $w^A_1$ or $w^B_1$; the sum's negative eigenvalues are $-3$ and $-1$ at $\tfrac{x+y}{\sqrt3}$ and $x-y$. **Neither value nor either eigenvector belongs to a summand.** Nor does the lower bound $n_-\ge2$ follow from the summands, it follows only from the exhibited spectrum, which is where I got it.

**Locate.** Line 382 of [stratum-two-negative.md](../findings/stratum-two-negative.md), the copy at [results.md](../results.md) line 487, and a third at [isotropy-cap.md](../findings/isotropy-cap.md) line 347 in the form "*exactly two negative eigenvalues, one per summand*".

**Exhibit.** $q=r=1$, $V_A=\langle e_1,e_2,e_5,e_6\rangle$, $V_B=\langle e_3,e_4,e_5,e_6\rangle$, negative eigenvectors $w^A_1,w^B_1$: sum spectrum $(-3,-1,1,1,1,1)$ against summand spectra $(-2,1,1)$ each.

**Argue the opposite.** The most charitable reading is that "contributes" means "contributes to the count", i.e. $n_-\le1$ per summand and the counts add. That reading is defensible for the $\le$ direction and is what makes the sentence salvageable, but it does not give $n_-\ge2$, which is the half the existence claim needs, and it is not what "the spectrum is $(-3,-1,1,1,1,1)$" is derived from anywhere on the record. **The candidate survives all three gates.**

### 5.2 "The support is the union of the planes"

This is the block's only reason for $\dim U=m$, and it is the wrong inclusion. $W$ is supported in $V_A+V_B$, so $U\subseteq V_A+V_B$; the claim needs $U\supseteq V_A+V_B$, which the sentence does not touch.

**And at the $m=6$ witness it is false even as a description.** $\mathrm{im}\,u_2=\langle e_1,e_2,e_3,e_4\rangle$, which is neither $V_A=\langle e_1,e_2,e_5,e_6\rangle$ nor $V_B$ nor any union of the planes. [lean/INDEX.md](../lean/INDEX.md) row L34 states the reason explicitly ("*The support is the union of the planes because a complex structure has no kernel*") and that reason is sound at $m=8$, where the negative eigenvectors *are* the padded complex structures $w^A_1,w^B_1$, and inapplicable at $m=6$, where they are the mixtures $x\pm y$ and $u_2$ is not a complex structure on either plane.

**The conclusion is true for a different reason**, given in §4.6: $u_1$ alone has rank $6$. **Argue the opposite**: one could read "support" as the support of $W$ rather than $U$, in which case the sentence is true and simply irrelevant to the claim. Either way it does not carry $\dim U=m$. **The candidate survives all three gates.**

### 5.3 The error the record already diagnosed, left in place next door

[isotropy-cap.md](../findings/isotropy-cap.md) withdrew a third clause of this same sentence (that all such witnesses have $\theta\le0$), with the diagnosis:

> **The clause is safe only for orthogonal planes**, where the two $\Lambda^2$ summands are orthogonal and $P$ is additive, which is the special shape both recorded witnesses happen to have, and presumably how the error survived.

**Two sibling clauses in the same sentence have exactly the same defect and were not corrected**: the eigenvalue attribution (§5.1) and the support claim (§5.2). Both are properties of the orthogonal case exported to the overlapping one.

## 6. The claimed conflict at $+0.6259$

The block says $\theta$ reaches $+0.485408612$ at $m=6$, *"(measured, not derived, and [isotropy-cap.md](../findings/isotropy-cap.md) records $+0.6259$ for the same family, a conflict this block does not resolve)"*. I read that passage at source. It says:

> **exact** witnesses at $\theta=+0.485408612$ ($m=6$) and $+0.115574271$ ($m=8$), both with two negative eigenvalues and $\dim U=m$, from 4-planes in **general position** (Reviewer 60); random general-position draws reach $+0.6259$ at $m=6$ and $+0.2650$ at $m=7$.

**They are the same quantity ($\theta$ at an $m=6$ member of the padded-two-4-plane family), evaluated at two different points, and there is no conflict.** $+0.485408612$ is presented as the value at one exhibited witness; $+0.6259$ as the largest value a set of random draws reached. A sampled maximum exceeding one exhibited point is ordinary; it says only that the exhibited witness is not the family maximum. **Nothing needs resolving.**

**The block's own word creates the appearance.** It writes that general-position planes *"reach $\theta=+0.485408612$"*, and "reach" reads as attainment of a maximum, under which the two figures would contradict. The source does not say that. **The defect is the block's, in importing "reach" and then flagging a conflict it manufactured.**

**Argue the opposite.** If Reviewer 60's $+0.485408612$ were the *maximum over general position*, the word "exact" could be read as "the exact optimum" rather than "an exactly-representable witness", then $+0.6259$ from random draws would indeed contradict it. That reading is available from the word "exact" alone, so I do not report the block's flag as simply wrong; I report that **the conflict is real only under a reading the source does not support, and the two files should be made to say which.** Under the plain reading there is no conflict.

**Both figures are HYPOTHESIS-DEBT either way.** Neither is derived. Under the standing analysis-only rule they are open hypotheses and neither may be cited as evidence for anything. §9.

## 7. "Why the recorded equivalence fails", the displayed identity

The block writes:

> With one positive eigenvalue, Ricci-flatness forces $U=\mathrm{im}\,v_1$, so full support means a nondegenerate eigenvector and Lemma L33 applies. With several positive eigenvalues it reads $\sum_{\lambda_\alpha>0}\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=b\,yy^{\mathsf T}+c\,zz^{\mathsf T}$ and constrains no rank at all.

**The identity is correct.** Ricci-flatness is $\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=0$; splitting by sign and writing the two negative eigenvectors as $y,z$ with eigenvalues $-b,-c$ gives exactly the display. It is the same identity [L29](../findings/stratum-two-negative.md) uses at one positive eigenvalue, and I verified it holds at the $m=6$ witness coefficient by coefficient in §4.5.

**The one-positive half is correct and complete.** Each $v_\alpha v_\alpha^{\mathsf T}=-v_\alpha^2\succeq0$, so $\lambda_1v_1v_1^{\mathsf T}=byy^{\mathsf T}+czz^{\mathsf T}$ gives $\mathrm{im}\,v_1=\mathrm{im}\,y+\mathrm{im}\,z=U$, the image of a sum of positive semidefinite matrices being the sum of their images, so **both** inclusions hold, not just the easy one. Then $\dim U=m$ makes $v_1$ full rank, hence not a complex structure on a $4$-plane once $m\ge6$, and [L33](../findings/stratum-two-negative.md) applies with its multiplicity-one hypothesis genuinely met. ✔

**"Constrains no rank at all" is a claim of vacuousness and is established only by the witnesses.** As a statement about the identity it is not proved anywhere, it is proved by exhibiting a solution with $\dim U=m$, which is what L34 does. So the two halves of the block are load-bearing on each other in the right order, and the sentence is honest, though "constrains no rank" overstates what an identity can be shown not to do. **CONFIRMED, with that caveat.**

## 8. What is refuted and what survives

**Refuted.** The statement [plan.md](../plan.md) recorded B0 as closing on, quoted from [isotropy-cap.md](../findings/isotropy-cap.md): *"no element of $\mathrm{Weyl}_m$ with $\dim\mathfrak m\le2$ has $\dim U=m$"*, is false at $m=6$ and at $m=8$, by the two witnesses I rebuilt. Also refuted: the recorded equivalence between that statement and the rank-3 question, which §7 shows holds only at one positive eigenvalue.

**What survives, precisely.**

- **[L33](../findings/stratum-two-negative.md) is untouched.** Its hypothesis is one eigenvalue on one side *counted with multiplicity*. The $m=6$ witness has two distinct negative values; the $m=8$ witness has one distinct value at multiplicity two. **Neither is in L33's hypothesis**, so neither refutes it, and the block does not claim they do.
- **L34's citation inside L33's multiplicity note is sound.** That note needs a witness to L33's falsity under the *distinct-value* reading. At $m=8$ there is one distinct negative value, $-1/\sqrt3$, at a two-dimensional eigenspace; the generic element $\cos\phi\,w^A_1+\sin\phi\,w^B_1$ of that eigenspace has rank $8$ and is not a complex structure on a $4$-dimensional subspace; and $W\ne0$. **CONFIRMED.** ([findings/LEDGER.md](../findings/LEDGER.md) already records that this role is corroborative (the primary witness for the L33 repair is the $\mathrm{Weyl}_4$ one) and that reading is right: at $m=8$ the two padded summands $w^A_1,w^B_1$ *are* L33's exception, so the witness bites only under the existential reading of "that eigenvector".)
- **[L35](../findings/stratum-two-negative.md)'s cap is untouched.** $\theta=-\sqrt3/2$ and $\theta=-27/(7\sqrt{14})=-1.0309$ are both below $\sqrt{3/2}=1.2247$, as are the recorded positive general-position figures. As a consistency check only, $-W$ at $m=6$ is a $\mathrm{Weyl}_6$ element with $\theta=+27/(7\sqrt{14})=1.03086$, below $\Theta_6=\sqrt{10}/3=1.05409$ and below $M(6)=\sqrt{3/2}$. No collision anywhere.
- **B0's conclusion is unproved rather than refuted**, which is what [isotropy-cap.md](../findings/isotropy-cap.md)'s closing section already says.

## 9. The traps, each answered by name

### 9.1 $\ker W\ne0$

**Both witnesses are massively degenerate.** At $m=8$, $\operatorname{rank}W=6$ against $N=28$: $\dim\ker W=22$. At $m=6$, $\operatorname{rank}W=6$ against $N=15$: $\dim\ker W=9$. Even the unpadded $W_4(q,r)$ has a $3$-dimensional kernel, $\Lambda^-\mathbb R^4$.

What that does to each step:

| step | effect of $\ker W\ne0$ |
| --- | --- |
| Weyl membership | none, (W1)–(W3) are linear and blind to rank |
| the spectra | none, the kernel contributes the recorded zeros, uncounted in both displays |
| $\operatorname{tr}W^3$ and $\langle W,W^\#\rangle$ | none, a kernel index kills its term in both, which is why §2 and §4.4 sum over six indices and not $N$ |
| $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$ | **it makes the index convention matter.** With $22$ (resp. $9$) zeros in the middle of the spectrum, $v_{N-1},v_N$ are the two negatives only under descending order. §1.3 |
| $S(W)$, the gradedness slack | [conventions.md](../findings/conventions.md)'s $S(W)$ row warns *"the screen is vacuous when $\ker W\ne0$"*. **L34 does not use $S(W)$**, so nothing here is affected, but any consumer that feeds these witnesses to a slack screen gets nothing. |
| the pair-cap and deficit machinery of [L29](../findings/stratum-two-negative.md)/[L31](../findings/stratum-two-negative.md)/[L35](../findings/stratum-two-negative.md) | **L34 uses none of it**, so the kernel's effect on $\sum_\beta\epsilon_{\alpha\beta}=2(N-n+1)$ never reaches this block |

**And one thing the degeneracy does mean, worth saying because the words invite the other reading**: "full support" here is $\dim U=m$, a statement about two eigenvectors' images in $\mathbb R^m$. It is *not* full rank of $W$ on $\Lambda^2$, and at both witnesses $W$ is as far from full rank as it could be while having six nonzero eigenvalues. Any consumer reading "full support" as nondegeneracy of $W$ will be wrong.

### 9.2 The boundary of every stated range

- **$m\ge10$.** The block admits it: *"two 4-planes span at most eight dimensions, so the construction is silent at $m\ge10$"*. That is correct and correctly stated. **What follows it is not covered by anything on the record**: *"where a structured convex screen finds every rank class infeasible and a one-parameter deformation shows the margin reaching zero only where the support degenerates"*, an imported numerical result with **no citation in the block, no reviewer, no script link, and no hedge**. It is HYPOTHESIS-DEBT. It is not load-bearing for L34's statement, which claims $m=6,8$ only.
- **The smallest admissible dimension.** $m=6$ is the smallest even $m\ge6$ and is claimed. At $m=4$ the two 4-planes coincide and the sum is a single $\mathrm{Weyl}_4$ element; the construction says nothing and neither does L34. Untouched, and correctly out of scope.
- **Odd $m$.** L34 claims nothing at odd $m$. Two 4-planes overlapping in a 3-plane span $\mathbb R^5$ and in a 1-plane span $\mathbb R^7$, so the construction is not structurally barred there, and [isotropy-cap.md](../findings/isotropy-cap.md) records draws at $m=7$. **The record makes no odd-$m$ claim, so there is nothing to check and nothing wrong, but the scope of L34 is two even dimensions and no more, which the landscape bullet's "In general position they reach $\theta=+0.485$" obscures by naming no dimension at all.**

### 9.3 A claim proven on a subfamily and used in general

**Found, twice, in one sentence**, §5.1 and §5.2. The eigenvalue attribution and the support description are properties of the orthogonal, $m=8$ configuration, asserted for the construction at large and false at the block's own $m=6$ witness. **This is the third instance of exactly this error in the same sentence**, the first (the $\theta\le0$ clause) having been caught and corrected in [isotropy-cap.md](../findings/isotropy-cap.md) while these two were left standing.

### 9.4 A hypothesis stated but never used, and a step using a hypothesis never stated

- **Stated but never used**: none. The statement's only hypothesis is $m\in\{6,8\}$, used.
- **Used but never stated**: **two.** (i) $q=r$, in both summands and with the same value, required by both displayed spectra, §4.1 and §2. The record introduces the letters $q,r$ in $W_4(q,r)$ and then never pins them anywhere; a reader who takes $q=2,r=\tfrac12$ (which the script itself runs, at [b0_full_support_witness.py](../scripts/lib/b0_full_support_witness.py) line 85) gets a different spectrum. (ii) the $m=6$ frame alignment, that each summand's negative eigenvector is the self-dual form carrying the shared 2-plane's bivector, and the special relative position of the two 4-planes, §4.1. **Both live only in a script's `itertools.permutations` search, in a file the block does not link.**

### 9.5 A universal claim with no witness, and an existence claim whose witness fails the hypotheses

- **A universal claim with no witness**: the construction sentence is written universally ("*Orthogonal planes at $m=8$ give…*", "*planes meeting in a 2-plane at $m=6$ give…*") and is false read that way, §4.1. **Read existentially, which the statement above it is, both are true.** The defect is grammatical and it hides §9.4's two hypotheses.
- **The converse, a witness failing the hypotheses**: **checked and cleared at both dimensions.** Each witness is in $\mathrm{Weyl}_m$ (Ricci-flatness verified exactly at $m=6$ in §4.5, and at $m=8$ the summands are unmixed padded $\mathrm{Weyl}_4$ elements; (W2) from linearity once §3's step is supplied), has exactly two negative eigenvalues (exhibited spectra), and has $\dim U=m$ (§2 and §4.6). $\operatorname{tr}W^\#=-\lVert W\rVert^2$ passes at both as an independent necessary condition.

### 9.6 An imported theorem whose hypotheses were never checked

**Three imports go uncited in the block**, and none of them fails:

| import | status |
| --- | --- |
| $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, and self-dual forms are complex structures | **true, uncited**; checked in §1.2 |
| padding preserves $\mathrm{Weyl}$ membership | **true, and not taken as a step at all**; §3. [conventions.md](../findings/conventions.md)'s padding bullet does not cover it |
| the $m\ge10$ convex screen and one-parameter deformation | **uncited, unhedged, measured**; §9.2 |

**No import here has an unmet hypothesis**, I looked specifically for the failure mode the brief names, an imported theorem whose hypotheses the object does not satisfy, and found none. The failure mode present instead is imports with no source.

### 9.7 Symbol collisions

- **$U$.** Not in [conventions.md](../findings/conventions.md)'s table at all. Defined inline by the statement, which is enough for self-containment, but it presupposes an eigenvalue ordering the record fixes nowhere and which the $m=6$ claim depends on, §1.3.
- **$N$.** Tabled as $\binom n2$. Used here at dimension $m$, so $N=\binom m2$, i.e. $15$ and $28$. Consistent, but note that the same file writes the two negative eigenvectors as $v_{N-1},v_N$ in [L29](../findings/stratum-two-negative.md)'s statement and as $v_2,v_3$ eleven lines later in its equality clause, **two index schemes for one pair of objects, in one block.**
- **$q$, a live collision inside this file, 24 lines apart.** At line 142 of [stratum-two-negative.md](../findings/stratum-two-negative.md), $q$ is the **Weitzenböck curvature operator**: *"$q(R)\omega=\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric}-2\mathring R\omega$"*. At line 166 of the same file, $q$ is a **positive scalar parameter** of $W_4(q,r)$. Neither is tabled.
- **$r$, a second live collision in the same file.** At line 33, $r$ is the **support dimension**: *"the support of $W$ is exactly $\mathrm{im}\,v_1$, of even dimension $r$"*, and the whole equality clause runs on "*at $r=4$*", "*even $r\ge6$*", "*$r\ge12$ untested*". At line 166, $r$ is the **second scalar parameter** of $W_4(q,r)$. Neither is tabled. A reader arriving at L34 from L29 will read $W_4(q,r)$ as a Weyl tensor on $\mathbb R^r$.

## 10. Cross-file defects found while checking

### 10.1 The landscape bullet strips the hedge and is contradicted by its own source

[results.md](../results.md) line 154:

> In general position they reach $\theta=+0.485$.

The block states the same number with two qualifications the bullet drops: *"measured, not derived"*, and the flagged conflict. **A reader of the landscape line has no way to know the figure is an unverified measurement.** It also names no dimension, the block's $+0.485408612$ is $m=6$ and its companion $+0.115574271$ is $m=8$, and, on the record's own source, understates: [isotropy-cap.md](../findings/isotropy-cap.md) says draws reach $+0.6259$ at $m=6$. **DEFECTIVE.**

### 10.2 [isotropy-cap.md](../findings/isotropy-cap.md)'s "both recorded witnesses" is false

> **The clause is safe only for orthogonal planes**, where the two $\Lambda^2$ summands are orthogonal and $P$ is additive, which is the special shape **both recorded witnesses** happen to have

**Locate.** [isotropy-cap.md](../findings/isotropy-cap.md) line 358, seven lines below that file's own table at line 351, whose $m=6$ row reads "*overlapping in a 2-plane*".

**Exhibit.** At the $m=6$ witness $\langle A,B\rangle=1\ne0$ (§4.5, Control 3), so the summands are not Frobenius-orthogonal; and $P(A+B)=-54$ against $P(A)+P(B)=-18-18=-36$, so $P$ is not additive there. The cross term is $-18$, it happens to be negative, which is *why* that witness has $\theta\le0$ despite the overlap, and it is nothing to do with orthogonality.

**Argue the opposite.** "The special shape" might mean something other than plane-orthogonality, but the same sentence defines it as "*where the two $\Lambda^2$ summands are orthogonal*", and I have exhibited $\langle A,B\rangle=1$. No charitable reading survives. **The candidate clears all three gates.** The correct statement is that the $m=8$ witness is safe by additivity and the $m=6$ one is safe by a cross term that happens to be negative.

### 10.3 The script's docstring still asserts a refuted claim

[b0_full_support_witness.py](../scripts/lib/b0_full_support_witness.py) lines 25–28:

> WHAT SURVIVES. Every such witness has theta <= 0, because each summand does

This is exactly the clause [isotropy-cap.md](../findings/isotropy-cap.md) withdrew, with exactly the reasoning it identified as the error (additivity assumed off Frobenius-orthogonal supports). **It stands uncorrected in the one file that holds the witnesses' parameters.** Same file, line 31: "*or a witness with theta > 0*" is listed as a **falsifier**, when such witnesses are now on the record at $+0.1384$, $+0.485408612$ and $+0.6259$.

### 10.4 The block's own duplication note is false against the file it names

> the second is now true, the duplication having been resolved on 2026-09-06: that file carried the whole construction byte-identical and then points at the file duplicating it

**[results.md](../results.md) line 487 still carries the whole construction paragraph**, identical in content to the block's, followed by "*Proof: [stratum-two-negative.md](../findings/stratum-two-negative.md)*". The duplication is not resolved, and **three copies stand today**, [stratum-two-negative.md](../findings/stratum-two-negative.md) lines 380–384, [results.md](../results.md) line 487, and [isotropy-cap.md](../findings/isotropy-cap.md) lines 347–353 in table form, the last still unlinked as the block says. Documentation, not mathematics, but the block asserts a state of the record that the record contradicts.

## 11. Withdrawn candidates

**Withdrawn, "the $m=6$ eigenvalue count depends on the frame choice, so 'exactly two' is unsafe."** I checked all three inequivalent alignments at $q=r=1$ (§4.1) and every one has exactly two negative eigenvalues; and §5.1 gives a general argument that the count is at most two whatever the planes do. **Reason for withdrawal: the claim fails gate 2, I could not exhibit a configuration where the count differs.**

**Withdrawn, "$\dim U$ is ill-defined at $m=8$ because the negative eigenvalue is degenerate."** The eigenspace is $\langle w^A_1,w^B_1\rangle$ and every orthonormal basis of it gives $U=\mathbb R^8$ (§2). **Reason for withdrawal: gate 2, no choice of basis makes the claim fail.**

**Withdrawn, "the block's $\theta$ values are inconsistent with [L35](../findings/stratum-two-negative.md)'s cap."** Both are negative and every recorded positive figure for the family is below $\sqrt{3/2}$. **Reason for withdrawal: gate 1, there is no step at which the two meet.**

**Withdrawn, "$\operatorname{tr}W^\#=-\lVert W\rVert^2$ fails at the $m=6$ witness because of the overlap."** It holds exactly, §4.5. **Reason for withdrawal: gate 2, the arithmetic closes at $-14$.**

## 12. What would falsify the statement, and what I did to look for it

**L34 is existential, so falsifying it means proving that no $W\in\mathrm{Weyl}_m$ has exactly two negative eigenvalues and $\dim U=m$, at $m=6$ or at $m=8$.** Any of the following would do it: a theorem forcing $U\subsetneq\mathbb R^m$ whenever $\dim\mathfrak m\le2$; an extension of [L33](../findings/stratum-two-negative.md) to two-dimensional minority eigenspaces without an exception at these dimensions; or a demonstration that one of the two exhibited objects is not in $\mathrm{Weyl}_m$, or has a different eigenvalue count, or has $\dim U<m$.

What I did to look for it:

1. **Rebuilt both objects from the definitions in closed form** and computed their full spectra by hand, §2 and §4.2–4.4. If either rebuild is right, no such proof can exist.
2. **Checked $\mathrm{Weyl}_m$ membership independently of the block's linearity clause.** Ricci-flatness at the $m=6$ witness verified coefficient by coefficient against the six diagonal generators, §4.5, Control 2. First Bianchi from the coefficient sum of $W_4(q,r)$ vanishing, §1.2.
3. **Ran two structural controls that a non-Weyl object would fail**: $\operatorname{tr}W^\#=-\lVert W\rVert^2$ at both witnesses, and the norm decomposition $\lVert W\rVert^2=\lVert A\rVert^2+\lVert B\rVert^2+2\langle A,B\rangle$ against an independent computation of $\langle A,B\rangle$.
4. **Checked $\dim U$ from the eigenvectors rather than from the block's "union of the planes"** at both dimensions, and checked the degenerate case at $m=8$ over the whole eigenspace.
5. **Searched the record for any result that would contradict the statement**, [L33](../findings/stratum-two-negative.md) (hypothesis not met by either witness), [L35](../findings/stratum-two-negative.md) (a $\theta$ cap, silent on support), [L82](../findings/isotropy-cap.md) (equality clause already refuted, and its lever "information-free at every $m\le9$"). **None contradicts it.**
6. **Attacked the one place where the ordering convention could flip the answer**, the ascending reading of $v_{N-1},v_N$, under which $\dim U=4$ at $m=6$, §1.3, and confirmed the record's own usage in [L29](../findings/stratum-two-negative.md) fixes the descending reading.

I did not search for further witnesses, did not attempt an independent proof of the statement, and repaired nothing. **No numerical work was done.**

## Verdict

**PROVEN, hypotheses corrected.**

The statement is true at both dimensions and both exhibited objects survive a cold rebuild: their spectra, their $\theta$ values, their Weyl membership and their $\dim U$ all check exactly, and the $m=6$ value has the closed form $-27/(7\sqrt{14})$ that the record carries only as a decimal. **What must be written into the block for the proof to be followable:**

1. **$q=r$**, in both summands and with the same value, used by both displayed spectra, stated nowhere.
2. **The $m=6$ frame condition**, each summand's negative eigenvector is the self-dual form carrying the shared 2-plane's bivector, and the two 4-planes are in the special relative position with orthogonal complements. "Planes meeting in a 2-plane" does not determine the spectrum.
3. **The padded-summand membership step**, without which the (correct) linearity clause carries nothing.
4. **"Each summand contributes exactly one negative eigenvalue" replaced** by what is true whatever the planes do, the count is at most two by the codimension argument, and exactly two by the exhibited spectra. At $m=6$ neither negative eigenvalue nor either eigenvector belongs to a summand.
5. **"The support is the union of the planes" replaced** by the reason that actually holds: at $m=8$ each padded complex structure has image its own plane; at $m=6$ the top negative eigenvector $\tfrac1{\sqrt6}(E_{12}+E_{34}+2E_{56})$ has rank $6$ on its own, while the second has image a 4-plane that is neither of the two.
6. **The manufactured conflict at $+0.6259$ withdrawn** (the two figures are one quantity at two points of one family), with both figures kept marked as measured.

Separately, and outside L34's own statement: the landscape bullet at [results.md](../results.md) line 154 must recover the block's hedge and its dimension; [isotropy-cap.md](../findings/isotropy-cap.md)'s "the special shape both recorded witnesses happen to have" is false and should be corrected to name the $m=6$ witness's negative cross term; and [b0_full_support_witness.py](../scripts/lib/b0_full_support_witness.py)'s docstring still asserts the $\theta\le0$ clause the record withdrew.
