# Review r738, Lemma L163, [L37](../findings/target.md)'s two witnesses in closed form

*Gate 2, cold from the definitions, on [findings/target.md](../findings/target.md)'s [L163](../findings/target.md). Everything below was rebuilt from $\delta_A(X)=AX+XA$ and $\Phi_W(A)=[W,\delta_A]$; the record's scripts were not imported. Exact rational arithmetic throughout, and every numerical statement is a screen of a claim already proved by hand, never evidence for one.*

## Verdicts

| Item | Verdict |
|---|---|
| (a) the exchange claim, $\delta_{A_0}$ maps $\Lambda^+\to\Lambda^-$ and back for every trace-free symmetric $A_0$ | **CONFIRMED**, on a basis, with $\beta$ in closed form |
| (a) the Sylvester step, and $W^+$ invertible at $W_{\mathbb{CP}^2}$ | **CONFIRMED**; spectrum $(4,-2,-2)$ on $\Lambda^+$, $W^-=0$ |
| (a) as an equality, both inclusions | **CONFIRMED**, and it **generalises to $\ker\Phi_{W_{\mathbb{CP}^m}}=\mathbb R\,\mathrm{Id}$ at every $m\ge2$**, by an argument that does not use $\Lambda^\pm$ |
| (b) the inequality itself | **CONFIRMED as true**, and **strict**, witness inside the record's own supply, strict by $7$ |
| (b) *"reproduces three rows exactly"* | **REFUTED.** A lower bound derives no value; the third row is **vacuous**, being $\dim\ker\Phi_W\ge1$, true of every operator |
| *"$11>8$ while being non-diagonal"* | **REFUTED as argued.** The non-diagonality is asserted, L37's corollary is inapplicable there by construction, and L163 cites nothing. It is **provable in one line**, two ways, and neither line is in the block |
| the $n=12$ prediction $37$ | **CONFIRMED**, and upgradeable from a bound to an exact value |
| the displayed commutator's lower-left block | sign defect: it is $W^-\beta-\beta W^+$, so the matrix as printed is self-adjoint where $[W,\delta]$ is skew-adjoint |
| block-diagonality of $W$ on $\Lambda^\pm$ | **owed.** It is where part (a) consumes $\mathrm{ric}=0$, and it is the one hypothesis L37 itself does not need |

**The headline.** The lemma's mathematics is sound and its arithmetic is right. What is wrong is the **form of (b)**: it is an inequality where the consumer needs an equality, and the block's own claim to have replaced three measurements does not survive that. The exact kernel is available in three lines and is given below.

## 1. The exchange claim, CONFIRMED, and $\beta$ is diagonal

Let $A_0$ be trace-free symmetric on $\mathbb R^4$. Diagonalise it as $A_0=g\mathop{\mathrm{diag}}(a_1,\dots,a_4)g^{\mathsf T}$ with $g\in SO(4)$; a sign flip on one column makes $\det g=+1$ without disturbing the diagonalisation, so this costs nothing. Since $\delta_{gAg^{\mathsf T}}=\Lambda^2(g)\,\delta_A\,\Lambda^2(g)^{-1}$ and $\Lambda^2(g)$ preserves $\Lambda^\pm$ for $g\in SO(4)$, it is enough to check the diagonal case. With $\omega^\pm_1=e_{12}\pm e_{34}$, $\omega^\pm_2=e_{13}\mp e_{24}$, $\omega^\pm_3=e_{14}\pm e_{23}$ and $\delta_{A_0}e_{ij}=(a_i+a_j)e_{ij}$:

$$\delta_{A_0}\omega^+_1=(a_1+a_2)e_{12}+(a_3+a_4)e_{34}=(a_1+a_2)\,\omega^-_1,$$

using $a_3+a_4=-(a_1+a_2)$, and identically $\delta_{A_0}\omega^+_2=(a_1+a_3)\omega^-_2$, $\delta_{A_0}\omega^+_3=(a_1+a_4)\omega^-_3$. So the map is not merely *into* the sum: in the paired bases $\beta$ is **diagonal**, $\beta=\mathop{\mathrm{diag}}(a_1+a_2,\,a_1+a_3,\,a_1+a_4)$.

**Trace-freeness is exactly what does it**, and the block's trace split is therefore load-bearing rather than cosmetic: $\delta_{\mathrm{Id}}=2\,\mathrm{Id}_{\Lambda^2}$ is diagonal, so an $A$ with trace has a diagonal part in $\delta_A$ and the matrix is not off-diagonal.

**What would have happened if it only mapped into the sum.** $\delta_{A_0}$ would carry blocks $\alpha^\pm$ on $\Lambda^\pm$, $[W,\delta_{A_0}]$ would carry $[W^\pm,\alpha^\pm]$ on the diagonal, and those vanish on the whole commutant of $W^\pm$, at $W_{\mathbb{CP}^2}$, where $W^-=0$, the entire $\Lambda^-$ block would be free. Sylvester touches only the off-diagonal blocks and would say nothing about them. **The claim is the crux and it holds.**

**Falsifier.** A trace-free symmetric $A_0$ with $\langle\delta_{A_0}\omega^+_i,\omega^+_j\rangle\ne0$ for some $i,j$. The closed form above forbids it.

## 2. Sylvester, and the spectrum at $W_{\mathbb{CP}^2}$, CONFIRMED

$\beta W^+-W^-\beta=0$ is a Sylvester equation with the two coefficient matrices real symmetric, so their spectra are real and disjointness over $\mathbb C$ is disjointness over $\mathbb R$; $\beta=0$ follows. At $W^-=0$ the condition collapses to $0\notin\mathop{\mathrm{spec}}(W^+)$, so invertibility of $W^+$ is exactly enough and Sylvester is not needed, $\beta W^+=0$ with $W^+$ invertible is one line.

I built the Fubini–Study curvature operator from the tensor $R(X,Y,Z,T)=\langle X,T\rangle\langle Y,Z\rangle-\langle X,Z\rangle\langle Y,T\rangle+\langle JX,T\rangle\langle JY,Z\rangle-\langle JX,Z\rangle\langle JY,T\rangle-2\langle JX,Y\rangle\langle JZ,T\rangle$ (holomorphic sectional curvature $4$; it returns $K=1+3\langle JX,Y\rangle^2$, so the normalisation is pinned by the formula itself) and subtracted the Einstein shift $\mathop{\mathrm{scal}}/(n(n-1))=2(m+1)/(2m-1)$. The Weyl operator of $\mathbb{CP}^m$ on $\Lambda^2\mathbb R^{2m}$ then has exactly three eigenvalues,

$$a=\frac{4(m^2-1)}{2m-1}\ \text{on}\ \mathbb R\omega,\qquad b=\frac{2m-4}{2m-1}\ \text{on}\ \mathfrak{su}(m),\qquad c=-\frac{2(m+1)}{2m-1}\ \text{on}\ \mathfrak m,$$

at multiplicities $1$, $m^2-1$, $m(m-1)$, summing to zero identically. **They are pairwise distinct at every $m\ge2$**: $a=b$ needs $4(m^2-1)=2m-4$, $a=c$ needs $4(m^2-1)=-2(m+1)$, $b=c$ needs $4m=2$.

At $m=2$ this reads $(4,0,0,0,-2,-2)$, that is $2\times$ the record's $(2,-1,-1,0,0,0)$ at [fence-posts.md](../findings/fence-posts.md), with $\mathfrak{su}(2)=\Lambda^-$ carrying the zero and $\mathbb R\omega\oplus\mathfrak m=\Lambda^+$ carrying $(4,-2,-2)$. **So $W^-=0$ and $W^+$ is invertible, in the record's own normalisation.** *The choice of which summand is $\Lambda^+$ is an orientation convention; the argument is symmetric in the two and does not care.*

Screened exactly: $\dim\ker(W-\lambda)$ at $\lambda=a,b,c$ returns $1,3,2$ at $m=2$ and $1,8,6$ at $m=3$, over $\mathbb Q$.

**Falsifier.** A zero in $\mathop{\mathrm{spec}}(W^+)$ at $W_{\mathbb{CP}^2}$, or $W^-\ne0$. Both are excluded by the eigenvalue list, which is derived rather than measured.

## 3. Part (a) is an equality, CONFIRMED, and it generalises off $n=4$

$\supseteq$ is $\delta_{\mathrm{Id}}=2\,\mathrm{Id}_{\Lambda^2}$. $\subseteq$: $\beta=0$ forces $\delta_{A_0}=0$ ($\delta_{A_0}$ being self-adjoint, its only other block is $\beta^*$), and then $a_1+a_2=a_1+a_3=a_1+a_4=0$ with $\sum a_i=0$ gives $a_1=\dots=a_4=0$. **Both inclusions hold and the statement is an equality.**

**But the proof is tied to $n=4$ and does not have to be.** The following covers every $\mathbb{CP}^m$ at once and is shorter.

> **Claim.** $\ker\Phi_{W_{\mathbb{CP}^m}}=\mathbb R\,\mathrm{Id}_{2m}$ for every $m\ge2$.
>
> **Proof.** $\delta_A$ commutes with $W$, so it preserves each of the three eigenspaces of §2. Preserving $\mathbb R\omega$ means $AJ+JA=\mu J$; right-multiplying by $J$ gives $A-JAJ=\mu\,\mathrm{Id}$, and $A-JAJ=2A^+$ where $A^\pm$ are the parts of $A$ commuting and anticommuting with $J$ (both symmetric, since $(JAJ)^{\mathsf T}=JAJ$). So $A=\tfrac\mu2\mathrm{Id}+A^-$. Now $\delta_{A^-}$ carries $\mathfrak u(m)$ into $\mathfrak m$: for $XJ=JX$ skew, $(A^-X+XA^-)J=-J(A^-X+XA^-)$. Since $\mathfrak{su}(m)\subseteq\mathfrak u(m)$ and $\mathfrak u(m)\cap\mathfrak m=0$, preserving the $\mathfrak{su}(m)$ eigenspace forces $A^-X+XA^-=0$ for every $X\in\mathfrak{su}(m)$. For two such $X,Y$ this gives both $A^-[X,Y]=[X,Y]A^-$ and $A^-[X,Y]=-[X,Y]A^-$, so $[X,Y]A^-=0$; $\mathfrak{su}(m)$ is simple for $m\ge2$, so $[\mathfrak{su}(m),\mathfrak{su}(m)]=\mathfrak{su}(m)$ contains invertible elements and $A^-=0$. $\square$

Screened exactly: $\dim\ker\Phi_{W_{\mathbb{CP}^2}}=1$ and $\dim\ker\Phi_{W_{\mathbb{CP}^3}}=1$ over $\mathbb Q$.

**This matters for §5.** The block claims the unpadded rows $1,1,1,1$ as a third reproduced row and gets them from (b), where they are vacuous. They are a *theorem*, and it is this one.

## 4. The exact kernel of a zero-padding, and where (b) is strict

Write $\mathbb R^n=\mathbb R^m\oplus V$, $k=\dim V=n-m$, $\Lambda^2\mathbb R^n=U_1\oplus U_2\oplus U_3$ with $U_1=\Lambda^2\mathbb R^m$, $U_2=\mathbb R^m\otimes V$, $U_3=\Lambda^2V$, and $A=\begin{pmatrix}P&C\\C^{\mathsf T}&B\end{pmatrix}$. Reading $\delta_A(u\wedge v)=Au\wedge v+u\wedge Av$ off the splitting, $\delta_A$ has $\delta_{13}=\delta_{31}=0$, $\delta_{11}=\delta_P$, and $\delta_{12}(u\wedge w)=u\wedge Cw$. With $W=W_0\oplus0$ block-diagonal and $W_2=W_3=0$, the commutator's blocks are $[W_0,\delta_{11}]$, $W_0\delta_{12}$, $-\delta_{12}^*W_0$ and six zeros. Setting

$$K(W_0):=\{c\in\mathbb R^m:\ W_0(c\wedge x)=0\ \ \forall x\in\mathbb R^m\},$$

the three surviving conditions are $P\in\ker\Phi_{W_0}$, $\mathop{\mathrm{im}}C\subseteq K(W_0)$, and nothing at all on $B$. Hence

$$\boxed{\ \dim\ker\Phi_{W_0\oplus0}\;=\;\dim\ker\Phi_{W_0}\;+\;\binom{k+1}2\;+\;k\,\dim K(W_0).\ }$$

L163's display is this with $P$ cut down to $\mathbb R\,\mathrm{Id}_m$ and $C$ set to zero. **It is an equality exactly when $\ker\Phi_{W_0}=\mathbb R\,\mathrm{Id}_m$ and $K(W_0)=0$, and strict otherwise.**

**A strict witness, from the record's own supply.** Take $W_0=W_{\mathbb{CP}^2}\oplus0$ on $\Lambda^2\mathbb R^6$ (a zero-padding is a Weyl tensor, so this is admissible under (b) as written) and pad it to $n=8$, so $m=6$, $k=2$. Then $\dim\ker\Phi_{W_0}=4$ and $K(W_0)$ is the $2$-plane of padding directions, giving $4+3+2\cdot2=11$, against L163's $1+\binom32=4$. **Strict, by $7$.** *A second family: any $W_0$ with $\dim\ker\Phi_{W_0}>1$, $W_0=0$ being the extreme.* Screened exactly at $n=6,8$: $4$ and $11$.

**And $K(W_{\mathbb{CP}^m})=0$ at every $m\ge2$**, which is what makes the record's own rows tight. For $c\ne0$, $\langle c\wedge Jc,\omega\rangle=\lvert c\rvert^2\ne0$, so $c\wedge Jc\notin\omega^\perp$; since $a\ne0$, $\ker W_{\mathbb{CP}^m}\subseteq\omega^\perp$, so $W_{\mathbb{CP}^m}(c\wedge Jc)\ne0$. Screened exactly: $\dim K=0$ at $m=2$ and $m=3$.

**Falsifier.** An $A\in\ker\Phi_{W_0\oplus0}$ outside the boxed description, or a padded example where the boxed count and a direct rank computation disagree. Direct exact rank computation of $\Phi_W$ on $\mathop{\mathrm{Sym}}^2\mathbb R^n$ returns $4$, $11$ and $4$ at the three catalogued paddings, matching the box in each.

## 5. *"Three rows the record held as measurements now follow from the formula"*, REFUTED

A lower bound derives no value. Read literally, (b) says $\ge11$, $\ge4$, $\ge1$; that the table's entries coincide with the bounds is consistent with the bounds and is not implied by them. Three separate points:

- **The third row is vacuous.** At $n=m$ the display reads $\dim\ker\Phi_{W_0}\ge1+\binom12=1$, which is $\mathrm{Id}\in\ker\Phi_W$, true of every linear operator on $\Lambda^2\mathbb R^n$ whatsoever. It reproduces $1,1,1,1$ in the sense that it is compatible with any four positive integers. **It is not a row.**
- **The $\mathbb{CP}^3$ row is not independent of the $\mathbb{CP}^2$ row.** Under the bound as stated it is the same one-line count with $(m,k)=(6,2)$ and consumes no property of $W_{\mathbb{CP}^3}$ at all. Under the exact formula it *does* become a derivation, but only once $\ker\Phi_{W_{\mathbb{CP}^3}}=\mathbb R\,\mathrm{Id}$ and $K=0$ are in hand, which §3 and §4 supply and L163 does not.
- **What is actually derivable is stronger than what is claimed**, and comes out of the box: for every $m\ge2$ and every $n\ge2m$, $\dim\ker\Phi_{W_{\mathbb{CP}^m}\oplus0}=1+\binom{n-2m+1}2$ **exactly**. That is the statement that replaces the three rows, and it settles the fourth as well.

## 6. The $n=12$ prediction, CONFIRMED, and it is exact

$1+\binom92=37$. The arithmetic is right, and by §4 the value is an equality rather than a floor, since $K(W_{\mathbb{CP}^2})=0$ and $\ker\Phi_{W_{\mathbb{CP}^2}}=\mathbb R\,\mathrm{Id}$ are properties of $W_0$ alone and do not move with $n$. **Falsifier:** an exact rank computation at $n=12$ returning anything other than $37$.

## 7. Non-diagonality, REFUTED as argued, and provable in one line

This is where the lemma's stated form fails its consumer.

**L37's corollary cannot deliver it, by construction.** The corollary reads *"$\dim\ker\Phi_W<n$ certifies non-diagonality"*, and the whole point of the witness is that $11>8$. So at padded $W_{\mathbb{CP}^2}$ the corollary is silent, which [target.md](../findings/target.md) already records at the block on Reviewer 75's test: *"Implementing only the dimension corollary was not enough, that wrongly called padded $W_{\mathbb{CP}^2}$ diagonal"*. **L163 asserts *"while being non-diagonal"* and argues nothing, cites nothing, and a lower bound on the kernel is the wrong direction to argue it from**, a larger kernel makes diagonality easier, not harder.

**The exact kernel supplies it immediately.** By §3 and §4, $\ker\Phi_{W_{\mathbb{CP}^2}\oplus0}=\{a\,\mathrm{Id}_4\oplus B:\ a\in\mathbb R,\ B\in\mathop{\mathrm{Sym}}(V)\}$ exactly. Every such $A$ has the eigenvalue $a$ at multiplicity at least $4$, so the sum $2a$ occurs $\binom42=6$ times among the $a_i+a_j$. **No element of the kernel has pairwise-distinct sums, so by L37's equivalence $W$ is diagonal in no orthonormal frame.** The same line gives it for padded $W_{\mathbb{CP}^m}$ at every $m\ge2$ and every $n\ge2m$, the multiplicity being $2m\ge4$.

**A second, independent line.** $\mathbb R\omega$ is a *simple* eigenspace of $W_{\mathbb{CP}^m}$ (eigenvalue $a$, multiplicity $1$), padding does not change that, and $\omega\wedge\omega\ne0$, so that eigenspace contains no decomposable bivector. That is the Plücker obstruction of [diagonality.md](../findings/diagonality.md), which the record carries **as a measurement**, $\min\lVert\omega\wedge\omega\rVert=0.50$ at padded $W_{\mathbb{CP}^2}$, discharged exactly, for the whole family, in one sentence.

**So the witness is real; L163 is not the thing that establishes it.** Either line above closes the gap, and the first uses only L37 and the exact kernel.

**Falsifier.** An $A\in\ker\Phi_{W_{\mathbb{CP}^2}\oplus0}$ with pairwise-distinct sums $a_i+a_j$. The boxed kernel description forbids one.

*A remark on the choice of $n=8$.* The corollary's hypothesis already fails at $n=7$, where $1+\binom42=7=n$, so the smallest padding at which the corollary is silent is $n=7$ rather than $n=8$; $n=8$ is the smallest at which the kernel strictly exceeds $n$. Both are witnesses to one-directionality and the block does not say which reading it wants.

## 8. Two smaller defects in the proof of (a)

- **The lower-left block carries a sign.** $[W,\delta_{A_0}]$ is skew-adjoint, both factors being self-adjoint, so with $(1,2)$ block $W^+\beta^*-\beta^*W^-$ the $(2,1)$ block is $W^-\beta-\beta W^+$, the *negative* of that block's adjoint. The display prints $\beta W^+-W^-\beta$, which makes the printed matrix self-adjoint. **The kernel is unaffected and the conclusion stands.**
- **$W=W^+\oplus W^-$ is asserted, not argued.** A general symmetric operator on $\Lambda^2\mathbb R^4$ has an off-diagonal $\Lambda^+\to\Lambda^-$ block; for an algebraic curvature operator that block *is* the trace-free Ricci, and it vanishes because $W$ is a Weyl tensor. **This is where part (a) consumes $\mathrm{ric}=0$**, worth stating, because L37 immediately above it makes a point of needing *"neither criticality nor $W\in\mathcal W_n$"*, and (a) as written silently reintroduces the second. *The argument of §3 needs no such hypothesis and would be the cleaner replacement.*

## 9. What L37 actually consumes, and the adjudication that produced this

L37 has two open debts and they are not the same shape.

| Debt | What discharges it | What L163 supplies |
|---|---|---|
| the corollary is not vacuous | any $W$ with $\dim\ker\Phi_W<n$; $\dim\ker\Phi_{W_{\mathbb{CP}^2}}=1<4$ does it | (a), which gives more than needed, harmless |
| the corollary runs one way only | a $W$ with $\dim\ker\Phi_W\ge n$ **and** a proof it is non-diagonal | (b) gives the first half; **the second half is where the whole witness lives, and it is missing** |

[ROUND_L37](../verification/ROUND_L37.md) records what the three verifiers had: *"padded $W_{\mathbb{CP}^2}$ at $n=8$ with $\dim\ker\Phi_W=1+\binom52=11>8$ while non-diagonal, reproducing a second measured value analytically"*, **an equality at one object**. [plan.md](../plan.md)'s I61 says the adjudication kept *"the general padding form"* and discarded the rest as *"the same argument at one object"*.

**The generalisation is where the content was lost.** Widening from $W_{\mathbb{CP}^2}$ to an arbitrary $W_0$ forces the equality down to an inequality, because $\ker\Phi_{W_0}$ and $K(W_0)$ are unknown in general, and the inequality is the one form of the statement from which non-diagonality cannot be argued. **This is the failure mode the mode itself carries**: the most general of three survived, and it is not the one the consumer needs. §4 shows the generality did not have to be paid for, the exact formula is as general as the bound and strictly more informative.

## Recommended repairs

1. **Replace (b)'s display with the boxed identity of §4**, with $K(W_0)$ defined. It is the same length, it is general, and it makes every downstream number exact.
2. **Add the corollary**: $\dim\ker\Phi_{W_{\mathbb{CP}^m}\oplus0}=1+\binom{n-2m+1}2$ for all $m\ge2$, $n\ge2m$, which returns $1$, $4$, $11$, $37$ and settles $\mathbb{CP}^3,\mathbb{CP}^4,\mathbb{CP}^5$ properly.
3. **Add the non-diagonality argument of §7** (one sentence, from L37's own distinct-sums clause) and strike *"while being non-diagonal"* as a bare assertion.
4. **Replace the proof of (a) with §3's**, or keep it and add the missing $W=W^+\oplus W^-$ line together with its $\mathrm{ric}=0$ hypothesis; fix the sign in the lower-left block.
5. **Restate the box above L163**: *"Three rows the record held as measurements now follow from the formula"* is false of the stated form and true of the repaired one. Under the repair the honest count is **four values plus a whole family**, not three rows.

*Screens: exact rational construction of the Fubini–Study curvature operator at $m=2,3$, exact eigenvalue multiplicities, exact $\dim K$, and exact $\dim\ker\Phi_W$ by integer-pivot elimination at $n=4,6,8$. All confirm claims proved above by hand; none is offered as evidence for one.*
