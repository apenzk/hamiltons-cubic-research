# VERIFY v134, Lemma L27: the ten-summand decomposition, the Schur step, the value $\tfrac12$, and the two exclusions

**Verifier v134, round L27, cold brief.** Checked: the statement and argument at [findings/nondegeneracy.md](../findings/nondegeneracy.md):463–502, the canonical form at [results.md](../results.md):423–427, the landscape line at [results.md](../results.md):140, and the imports the block names. **No numerical work was done. No script was run.** Every dimension, eigenvalue, multiplicity and trace below is an exact hand evaluation, including the full symbolic expansion of the dimension identity in §3 and the five spectrum rows in §7. Log: [agent_logs/verify-L27-v134.log](../agent_logs/verify-L27-v134.log).

## Claim table

| # | Claim, as a consumer reads it | Verdict |
| --- | --- | --- |
| 1 | The ten summands' dimensions sum to $\dim\mathrm{Weyl}_n$ identically in $p,q$ | **PROVEN**, expanded by hand, an exact polynomial identity |
| 2 | The ten Young labels are pairwise distinct for every $p,q\ge3$, so the decomposition is multiplicity-free | **PROVEN** |
| 3 | Schur plus symmetry make $L_e$ a scalar on each summand | **PROVEN, OVER-GENERAL**; every $O(m)$ irreducible is of real type, so symmetry is never called on |
| 4 | The ten values are $1,\tfrac12,\lambda_p,\lambda_q,+\mu,-\mu,0,0,0,0$ | **PROVEN**, with the $-\mu$ resting on the trace identity and $\lambda_m$ on an import |
| 5 | $\operatorname{tr}_{\mathcal W_n}L_e=0$, and the ten values satisfy it identically in $p,q$ | **PROVEN**, verified by hand as an identity, not at sample points |
| 6 | The swapped assignment gives $30,30,48,70$ at $(3,5),(4,4),(5,5),(5,7)$, never zero | **PROVEN**, and the general form is $(n^2-4)/2$ |
| 7 | $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ for $p,q\ge3$, $(p,q)\ne(3,3)$, attained on $\mathbb R^p\otimes\mathbb R^q$ alone | **PROVEN** |
| 8 | $\dim E(\tfrac12)=pq$ | **PROVEN** |
| 9 | $\dim(\text{orbit})=pq$ | **HYPOTHESIS-DEBT at $\min(p,q)\le4$**, the cited source clause carries $k,l\ge5$ |
| 10 | At $(3,3)$: $\mu=\tfrac12$, $\dim E(\tfrac12)=18$, an eigenvalue coincidence and not representation mixing, $\dim\mathrm{Comm}_{O(3)^2}=2$ against $4$ | **PROVEN**, all four numbers re-derived by hand |
| 11 | *"A symbolic solve over all $45$ summand pairs finds it the only such coincidence with $p,q\ge3$"* | **WORDING DEFECT**, false on the plain reading, true on the charitable one |
| 12 | The Nienhaus attribution: Prop 4.6 and the summary display, $O(k)\times O(l)$-irreducible for $k,l\ge3$ | **PROVEN**, quoted verbatim from the local copy |
| 13 | *(named trap)* Three live copies of the refuted $(3,3)$ mechanism, one of which withdraws L27's own headline | **BROKEN, outside the block** |
| 14 | Lean row for L27 | **NONE EXISTS** |

**Summary in one line.** Every mathematical step inside the block verifies exactly by hand, the dimension identity, the trace identity, all five recorded spectrum rows, the $(3,3)$ commutant counts and the exhaustive check that no other summand reaches $\tfrac12$, so the verdict is **PROVEN, hypotheses corrected**, with one narrow debt on $\dim(\text{orbit})=pq$ when $\min(p,q)\le4$, one wording defect inside a citable sentence of the block, and the record's signature failure firing three times in the file that houses the proof.

## 0. Conventions, fixed once

Taken from [results.md](../results.md):701 and used unchanged throughout.

- $Q(X)=X^2+X^\#$; $X\circ Y=\tfrac12\big(Q(X+Y)-Q(X)-Q(Y)\big)$, so $X\circ X=Q(X)$.
- $W$ is a critical point with $\theta=P(W)>0$; $e=W/\theta$; $L_e=e\circ(\cdot)$.
- $T(X,Y,Z)=\langle X,Y\circ Z\rangle$ is **fully symmetric** ([findings/problem.md](../findings/problem.md):114). Hence $L_e$ is self-adjoint: $\langle L_eX,Y\rangle=T(e,X,Y)=\langle X,L_eY\rangle$.
- $\mathrm{Hess}\,P$ on the unit sphere of $\mathrm{Weyl}_n$ is $6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$, so $\ker\mathrm{Hess}=E_{L_e}(\tfrac12)$ inside $W^\perp$.
- Abbreviations used below: $s(m)=\dim S^2_0(\mathbb R^m)=\tfrac{(m+2)(m-1)}2$, $c(m)=\dim\Lambda^2(\mathbb R^m)=\tfrac{m(m-1)}2$, $X(m)=\dim X_m=\tfrac{m(m^2-4)}3$, $W(m)=\dim\mathrm{Weyl}_m=\tfrac{m(m+1)(m+2)(m-3)}{12}$.
- $\lambda_m=\tfrac{m-2}{2(m-1)}$ and $\mu=\tfrac{n-2}{2(p-1)(q-1)}$.

## 1. The hypothesis inventory

### 1a. Hypotheses the block carries in its own statement

| Hypothesis | Where it is used in the written proof |
| --- | --- |
| $p,q\ge3$ | Three separate places: the multiplicity-free claim (*"pairwise distinct for every $p,q\ge3$"*), the positivity of $\tfrac12-\mu$, and (unstated), the existence of the ten summands at all, since $S^2_0(\mathbb R^2)$ leaves $\mathrm{Weyl}_n$ at $p=2$ |
| $(p,q)\ne(3,3)$ | Only in the final display, to make $(p-2)(q-2)-1>0$ |
| $n=p+q$ | Definitional |

### 1b. Hypotheses the block carries implicitly and does not state

| Implicit hypothesis | Status |
| --- | --- |
| $W_{p,q}$ is a critical point with $\theta>0$ | **Holds.** Nienhaus Prop. 2.25, read in the local copy: $\theta_{k,l}=\sqrt2\sqrt{\tfrac{k-1}k\cdot\tfrac{l-1}l\cdot\tfrac{n-1}{n-2}}>0$ for $k,l\ge2$. Needed for $e=W/\theta$ to exist at all |
| $L_e$ is self-adjoint | **Holds and is on file** (§0), used twice in the block: for the division-algebra step and for $E(\tfrac12)$ to be an eigenspace rather than a generalised one. The block says *"symmetric"* without saying where symmetry comes from |
| $L_e$ preserves $\mathrm{Weyl}_n$ | **Asserted numerically only**, [nondegeneracy.md](../findings/nondegeneracy.md):375 records it *"to $1.8\times10^{-15}$"*. Not load-bearing for the trace step as I check it in §5, since the pairing against $e\in\mathrm{Weyl}_n$ absorbs the difference, but the block does not say that |
| $T$ is fully symmetric | **Holds and is on file**, used silently in the trace step (§5) |
| $\mathcal W_n$ is $O(n)$-irreducible and non-trivial | **Holds** for $n\ge5$; $n=p+q\ge6$ here. Stated in the block |

### 1c. Hypotheses of every imported result, checked against the object

| Import | Its own hypotheses | Object it is applied to | Verdict |
| --- | --- | --- | --- |
| **Nienhaus Prop. 4.6**, the $S^2(\mathfrak{so}(n))$ decomposition | *"$k,l\ge5$, $k,l\ne6$"*, read verbatim at [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404):3760 | applied at $p,q\ge3$ | **outside** its hypotheses; see §9 |
| **the summary display** after Prop. 4.6 | *"orthogonal and irreducible under the $SO(k)\times SO(l)$-action for any $k,l\ge5$. Furthermore, it is irreducible under the action of $O(k)\times O(l)$ for any $k,l\ge3$"* | applied at $p,q\ge3$ | **inside** its stated scope for the irreducibility clause; §9 |
| **Nienhaus Remark 4.7(ii)** | *"There is a similar decomposition, if $k,l\le4$"*, a remark, no proof | supplies the existence of the ten-fold splitting at $p$ or $q\in\{3,4\}$ | **a cited assertion, not a proof**; the block says so |
| **Prop. 4.6(b)**, the orbit tangent | inherits $k,l\ge5$, $k,l\ne6$ | applied at $\min(p,q)\in\{3,4\}$ | **outside** its hypotheses, this is the debt of §8 |
| **[Lemma L26](../findings/nondegeneracy.md)** | *"any three-block diagonal operator"*; criticality unused | supplies $+\mu$ on $\Lambda^2\otimes\Lambda^2$ | **inside** |
| **$\lambda_m$ from [second-order.md](../findings/second-order.md):595** | $A$ trace-free in the first block, Ricci-flatness, criticality | supplies $\lambda_m$ on $S^2_0(\mathbb R^m)$ | **inside**, but see §6, the same file carries a live sentence calling the value *"a fit and not a proof"* |
| **the index computation** for $X_p\otimes\mathbb R^q$ | *"No Schur, no irreducibility, no $p,q\ge3$"*; Ricci-flatness once | supplies $0$ on two summands | **inside** |
| **the $\mathrm{Weyl}_p$/$\mathrm{Weyl}_q$ vanishing** | two proofs on file, one via $\Phi(V)=2V$, one via $L_{I_n}\equiv0$ from $\mathrm{Ric}=0$ | supplies $0$ on two summands | **inside** |

### 1d. Which of these the written proof actually uses

The block's chain is: **(i)** the ten-fold decomposition exists and is orthogonal; **(ii)** it is multiplicity-free; **(iii)** $L_e$ is equivariant and symmetric, hence scalar on each summand; **(iv)** the ten values; **(v)** compare them to $\tfrac12$. Of the stated hypotheses, $(p,q)\ne(3,3)$ enters at step (v) only, and $p,q\ge3$ enters at (i), (ii) and (v). **Nothing in the written proof uses criticality except through $\theta>0$ and through the two imported values $\lambda_m$ and $\tfrac12$**, the $\pm\mu$ pair and the four zeros are proved for a general three-block diagonal $e$.

## 2. Pre-registered question 1a, the ten Young labels, pairwise distinct

Under $O(p)\times O(q)$ the ten summands carry these pairs of partitions:

| summand | label | summand | label |
| --- | --- | --- | --- |
| $\langle W\rangle$ | $([0],[0])$ | $S^2_0\otimes S^2_0$ | $([2],[2])$ |
| $\mathrm{Weyl}_p$ | $([2,2],[0])$ | $\Lambda^2\otimes\Lambda^2$ | $([1,1],[1,1])$ |
| $\mathrm{Weyl}_q$ | $([0],[2,2])$ | $X_p\otimes\mathbb R^q$ | $([2,1],[1])$ |
| $\mathbb R^p\otimes\mathbb R^q$ | $([1],[1])$ | $X_q\otimes\mathbb R^p$ | $([1],[2,1])$ |
| $S^2_0(\mathbb R^p)$ | $([2],[0])$ | $S^2_0(\mathbb R^q)$ | $([0],[2])$ |

The ten ordered pairs are pairwise distinct by inspection. What has to be checked beyond inspection is that **distinct labels name non-isomorphic $O(m)$-representations at $m=3$ and $m=4$**, where the labels are close to the boundary $\lambda'_1+\lambda'_2\le m$ and where dimensions collide.

**At $m=3$.** The admissible labels present are $[0],[1],[1,1],[2],[2,1]$, of dimensions $1,3,3,5,5$. The two dimension collisions are exactly the two the block names.
- $[1,1]$ against $[1]$: $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det$. The associated partition of $[1,1]$ replaces the first column length $2$ by $3-2=1$, giving $[1]$. So the two differ precisely by $\det$, and $\det$ is non-trivial on $O(3)$: **non-isomorphic**.
- $[2,1]$ against $[2]$: the associated partition of $[2,1]$ has column lengths $(2,1)\mapsto(1,1)$, i.e. $[2]$. So $X_3\cong S^2_0(\mathbb R^3)\otimes\det$: **non-isomorphic under $O(3)$, isomorphic under $SO(3)$**.
- $[2,2]$ needs $\lambda'_1+\lambda'_2=4>3$, so $\mathrm{Weyl}_3=0$, consistent with $W(3)=\tfrac{3\cdot4\cdot5\cdot0}{12}=0$.

**At $m=4$.** Labels $[0],[1],[1,1],[2],[2,1],[2,2]$, dimensions $1,4,6,9,16,10$, pairwise distinct, so no collision to resolve. $[2,2]$ is self-associated ($\lambda'=(2,2)\mapsto(2,2)$), which is why $\mathrm{Weyl}_4$ is $O(4)$-irreducible and splits only under $SO(4)$; likewise $[1,1]$ and $[2,1]$ at $m=4$.

**Verdict.** The block's *"pairwise distinct for every $p,q\ge3$"* is correct, and the record's own commutant computation ($\mathrm{End}=1$, cross-$\mathrm{Hom}=0$, at $m=3,4$, including $\mathbb R^3$ against $\Lambda^2(\mathbb R^3)$ and $S^2_0$ against $X_3$) is exactly the pair of coincidences the associated-partition argument resolves. **No finding.**

## 3. Pre-registered question 1b, the dimension sum, expanded

The block says the ten dimensions sum to $\dim\mathrm{Weyl}_n$ *"identically in $p,q$"*. Sample points cannot settle an identity in two variables of degree four, so I expanded it.

Write $n=p+q$, $e_2=pq$, $S_2=p^2+q^2=n^2-2e_2$, $S_4=p^4+q^4=S_2^2-2e_2^2$. First,
$$W(n)=\frac{n(n+1)(n+2)(n-3)}{12}=\frac{(n^2+n)(n^2-n-6)}{12}=\frac{n^4-7n^2-6n}{12}.$$

Now $12\times$ each of the ten right-hand terms:

| term | $12\times$ contribution |
| --- | --- |
| $\langle W\rangle$ | $12$ |
| $\mathrm{Weyl}_p+\mathrm{Weyl}_q$ | $S_4-7S_2-6n$ |
| $\mathbb R^p\otimes\mathbb R^q$ | $12e_2$ |
| $S^2_0(\mathbb R^p)+S^2_0(\mathbb R^q)$ | $6S_2+6n-24$ |
| $S^2_0\otimes S^2_0$ | $3(p^2+p-2)(q^2+q-2)=3e_2^2+3e_2n+3e_2-6S_2-6n+12$ |
| $\Lambda^2\otimes\Lambda^2$ | $3e_2(e_2-n+1)=3e_2^2-3e_2n+3e_2$ |
| $X_p\otimes\mathbb R^q+X_q\otimes\mathbb R^p$ | $4e_2(S_2-8)=4e_2S_2-32e_2$ |

Collecting: the constants give $12-24+12=0$; the $n$-terms give $-6n+6n-6n=-6n$; the $e_2n$ terms give $+3e_2n-3e_2n=0$; the $S_2$ terms give $-7S_2+6S_2-6S_2=-7S_2$; the $e_2$ terms give $12+3+3-32=-14$, i.e. $-14e_2$; and $e_2^2$ gives $3+3=6$. So
$$12\cdot\text{RHS}=S_4-7S_2-6n-14e_2+6e_2^2+4e_2S_2.$$
Substituting $S_4=n^4-4n^2e_2+2e_2^2$, $-7S_2=-7n^2+14e_2$ and $4e_2S_2=4e_2n^2-8e_2^2$:
$$12\cdot\text{RHS}=n^4+(-4+4)n^2e_2+(2+6-8)e_2^2-7n^2+(14-14)e_2-6n=n^4-7n^2-6n=12\,W(n).$$

**Verdict: an exact polynomial identity in $p$ and $q$, PROVEN.** The block's *"identically in $p,q$"* is literally true. Spot-checked against the expansion at $(3,3)\to84$, $(3,4)\to168$, $(4,4)\to300$, $(3,5)\to300$, $(3,6)\to495$, $(5,5)\to770$, all exact.

**A consequence the block does not draw, and it matters for §9.** Because the identity is a polynomial identity, it holds at $p=2$ **only with the value $W(2)=-2$**, which is not a dimension: $\dim\mathrm{Weyl}_2=0$. So at $p=2$ the ten named dimensions **overshoot $\dim\mathrm{Weyl}_n$ by exactly $2$**, $86$ against $84$ at $S^2\times S^4$. [nondegeneracy.md](../findings/nondegeneracy.md):682 records this and attributes it to $S^2_0(\mathbb R^2)$ leaving $\mathrm{Weyl}_n$; the arithmetic of the overshoot is $-W(2)=2$, and $\dim S^2_0(\mathbb R^2)=2$ agrees. Either way **the display itself fails at $q=2$**, which is a stronger reason for the exclusion than the one the block gives.

## 4. Pre-registered question 1c, the division-algebra step, and whether symmetry is what makes it work

The block writes: *"a symmetric element of a real division algebra of operators has a real eigenvalue and is therefore a real scalar, which covers $\mathbb R$, $\mathbb C$ and $\mathbb H$ alike"*, with the marginal note *"Symmetry is what does this work; it cannot, as the first version had it, change a representation's type."*

**The step is valid.** Let $V$ be a real irreducible summand, $D=\mathrm{End}_{O(p)\times O(q)}(V)$, a real division algebra by Schur, so $D\in\{\mathbb R,\mathbb C,\mathbb H\}$. Multiplicity-freeness makes $L_e$ preserve $V$, and equivariance puts $L_e\vert_V\in D$. $L_e\vert_V$ is self-adjoint for the invariant inner product, so it has a real eigenvalue $\lambda$; then $L_e\vert_V-\lambda\,\mathrm{Id}\in D$ is singular, and a division algebra has no non-zero singular element, so $L_e\vert_V=\lambda\,\mathrm{Id}$. Correct as written, and the marginal note correctly disowns the earlier non sequitur, which [LEDGER.md](../findings/LEDGER.md):800 also records.

**Does something weaker suffice? Yes, and the weaker thing is what actually holds here.** Every irreducible representation of $O(m)$ is **absolutely irreducible**: the Weyl-module construction realises it over $\mathbb Q$, so $\mathrm{End}_{O(m)}=\mathbb R$ in every case. An outer tensor product of two absolutely irreducibles is absolutely irreducible, so $D=\mathbb R$ for all ten summands and the scalar follows from Schur **with no appeal to symmetry at all**. The record itself supplies the evidence: the commutant computation quoted in the block reports *"every $\mathrm{End}=1$"* at $m=3,4$, which is precisely $D=\mathbb R$.

**Verdict.** The step is **PROVEN but over-general**: the $\mathbb C$ and $\mathbb H$ branches it insures against are empty on this object. Recording it here because the block's own $\mathrm{End}=1$ computation, three paragraphs later, is the fact that makes the insurance unnecessary, and because a consumer who imports *"symmetry is what does this work"* into a setting where the commutant is genuinely $\mathbb C$ or $\mathbb H$ will be relying on the general statement, which is fine, whereas one who reads it as a fact about **this** decomposition will have the wrong picture of why the argument closes. **This is not a defect; it is a scope note.** Symmetry is separately load-bearing for a different reason the block does not name: $E(\tfrac12)$ is an honest eigenspace and $W^\perp$ is $L_e$-invariant only because $L_e$ is self-adjoint.

## 5. The trace identity, verified as an identity

The block's check: $\mathcal W_n$ is $O(n)$-irreducible and non-trivial, $\sum_iQ(V_i)$ is an invariant vector in it, hence $0$, hence $\operatorname{tr}_{\mathcal W_n}L_e=0$.

**The bridge from that to $\operatorname{tr}L_e$ is unstated, and it is the full symmetry of $T$.** For an orthonormal basis $\{V_i\}$ of $\mathcal W_n$,
$$\operatorname{tr}L_e=\sum_i\langle e\circ V_i,V_i\rangle=\sum_iT(e,V_i,V_i)=\Big\langle e,\sum_iV_i\circ V_i\Big\rangle=\Big\langle e,\sum_iQ(V_i)\Big\rangle,$$
using $X\circ X=Q(X)$ and the total symmetry of $T$ ([problem.md](../findings/problem.md):114). $\sum_iQ(V_i)$ is basis-independent, hence $O(n)$-invariant; its $\mathcal W_n$-component is an invariant vector in a non-trivial irreducible and vanishes; and $e\in\mathcal W_n$ kills whatever lies outside. So $\operatorname{tr}L_e=0$. **The conclusion is right; the two steps that carry it, the symmetry of $T$, and the fact that only the $\mathcal W_n$-component of $\sum_iQ(V_i)$ needs to vanish, are both absent from the block.** The second matters because [nondegeneracy.md](../findings/nondegeneracy.md):375 establishes that $L_e$ preserves $\mathcal W_n$ only *"to $1.8\times10^{-15}$"*, i.e. numerically; the argument above does not need it.

**Now the ten values against $\operatorname{tr}L_e=0$, by hand.** The $\pm\mu$ pair contributes
$$\mu\cdot\frac{pq(p-1)(q-1)}4-\mu\cdot\frac{(p+2)(p-1)(q+2)(q-1)}4=\frac{\mu(p-1)(q-1)}4\big[pq-(p+2)(q+2)\big]=-\frac{\mu(p-1)(q-1)(2n+4)}4,$$
and with $\mu=\dfrac{n-2}{2(p-1)(q-1)}$ this is exactly $-\dfrac{(n-2)(n+2)}4=-\dfrac{n^2-4}4$, **the $(p-1)(q-1)$ cancelling identically**. The other contributions are $1$ from $\langle W\rangle$; $\tfrac12\cdot pq$ from the orbit; $\lambda_m\cdot s(m)=\tfrac{m-2}{2(m-1)}\cdot\tfrac{(m+2)(m-1)}2=\tfrac{m^2-4}4$ for $m=p,q$; and $0$ from the remaining four. So
$$\operatorname{tr}L_e=1+\frac{pq}2+\frac{p^2-4}4+\frac{q^2-4}4-\frac{n^2-4}4=1+\frac{pq}2+\frac{p^2+q^2-n^2-4}4=1+\frac{pq}2-\frac{2pq+4}4=0,$$
using $p^2+q^2-n^2=-2pq$. **Identically in $p,q$, PROVEN, not at sample points.**

**Does it force $-\mu$ uniquely?** Yes. Treating the $S^2_0\otimes S^2_0$ value $v$ as the single unknown, $\operatorname{tr}L_e=0$ is linear in $v$ with coefficient $s(p)s(q)$, which is $\ge25$ for $p,q\ge3$ and in particular non-zero. One linear equation, one non-vanishing coefficient, one solution. **PROVEN.**

**Does it force $\lambda_m$ too?** **No, and [LEDGER.md](../findings/LEDGER.md):796 says it does.** That line reads *"$\operatorname{tr}L_e=0$ forces it uniquely, and forces $\lambda_m=\frac{m-2}{2(m-1)}$ with it."* A single scalar equation cannot determine three unknowns $v,\lambda_p,\lambda_q$; and requiring it to hold identically in $p,q$ does not help, because $v$ is a free function of two variables and absorbs any choice of $\lambda$. **The L27 block itself does not make this claim**, it sources $\lambda_m$ to [second-order.md](../findings/second-order.md) and only $-\mu$ to the trace, so the defect is the ledger's, not the block's. Recorded because the ledger is where a reader goes to see why the trace step is legitimate.

**The swap discriminant.** Reversing the two tensor summands flips the sign of the $\pm\mu$ contribution, so the trace becomes $0+2\cdot\tfrac{n^2-4}4=\tfrac{n^2-4}2$. At $(3,5)$ and $(4,4)$, $n=8$: $\tfrac{60}2=30$. At $(5,5)$, $n=10$: $\tfrac{96}2=48$. At $(5,7)$, $n=12$: $\tfrac{140}2=70$. **All four figures in the block are exact**, and the general form shows the stronger fact the block asserts without proof, $\tfrac{n^2-4}2=0$ only at $n=2$, so the swapped assignment is **never** zero for $n\ge6$. **PROVEN, and strengthened from four points to all $n$.**

## 6. The ten values, one at a time, and where each is actually proved

| summand | value | where it comes from | verdict |
| --- | --- | --- | --- |
| $\langle W\rangle$ | $1$ | $L_eW=\tfrac1\theta W\circ W=\tfrac1\theta Q(W)=\tfrac1\theta\theta W=W$. **Two lines, and the block gives none** | derivable from §0 alone |
| $\mathbb R^p\otimes\mathbb R^q$ | $\tfrac12$ | $Q(W_t)=\theta W_t$ along the orbit with $\theta$ constant; differentiating, $2W\circ\dot W=\theta\dot W$, i.e. $2\theta\,L_e\dot W=\theta\dot W$, so $L_e\dot W=\tfrac12\dot W$ | **PROVEN**, the block's line is right |
| $S^2_0(\mathbb R^m)$, $m=p,q$ | $\lambda_m$ | [second-order.md](../findings/second-order.md):595, *"The block closed form is DERIVED"*, Gate 2 r301/r302, with the mixed-entry consistency check $[(n-2)(p-1)-q]/[2(n-1)(p-1)]$ agreeing identically | **PROVEN on file**, but see the trap below |
| $\Lambda^2\otimes\Lambda^2$ | $+\mu$ | [Lemma L26](../findings/nondegeneracy.md), exhibited eigenvector, criticality unused | **PROVEN** |
| $S^2_0\otimes S^2_0$ | $-\mu$ | the trace identity, §5 | **PROVEN**, conditional on the other nine |
| $\mathrm{Weyl}_p,\mathrm{Weyl}_q$ | $0$ | two independent proofs on file | **PROVEN** |
| $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$ | $0$ | the index computation, uniform in $p,q,n$, Ricci-flatness used once, six-case exhaustion, Bianchi twice | **PROVEN** |

**A live contradiction inside the file L27 sends the reader to for $\lambda_m$.** [second-order.md](../findings/second-order.md):595 heads a paragraph **The block closed form is DERIVED**, and gives the derivation: for $A$ trace-free in the first block the Weyl projection leaves a shape $\beta(\alpha_i+\alpha_j)$ on $pp$, $0$ on $qq$, $\gamma\alpha_i$ mixed, subject to $\beta(p-2)+q\gamma=0$, which is one-dimensional and hence forces scalarity, collapsing to $\lambda=\frac{(p-2)(a-c)}{2\theta}=\frac{p-2}{2(p-1)}$. **Four lines later**, [second-order.md](../findings/second-order.md):603 says of the same closed form: *"three points against a two-parameter guess, **which is a fit and not a proof**… Set up and not finished."* And [ATTEMPTS.md](../ATTEMPTS.md):2579 still tabulates *"the closed form $\tfrac{p-2}{2(p-1)}$ | derivation | **fitted from three data points** against a two-parameter guess"*.

*Locate:* [second-order.md](../findings/second-order.md):603 and [ATTEMPTS.md](../ATTEMPTS.md):2579. *Exhibit:* L27 cites *"derived at second-order.md"* with no anchor; a consumer following that pointer and landing on line 603 rather than 595 reads that one of L27's ten values is unproved, and L27's $-\mu$ depends on that value through the trace solve. *Argue the opposite:* the two paragraphs may be describing different objects, the derivation at :595 is about the deformation $H_A$ for $A\in\mathrm{Sym}_0(\mathbb R^p)$, the "fit" paragraph about $L_e\vert_{\mathrm{Sym}_0(\mathbb R^p)}$. **This reading fails**: the Kulkarni–Nomizu image of $\mathrm{Sym}_0(\mathbb R^p)$ *is* the summand $S^2_0(\mathbb R^p)$, both paragraphs display the same closed form $\tfrac{p-2}{2(p-1)}$, and :603 explicitly says what a derivation must explain, namely the $q$-independence that :595 explains by the cancellation $(p+q-2)(p-1)-q=(p-2)(n-1)$. **The candidate survives all three steps: a stale "not a proof" sentence stands beside the proof that closed it, in the file L27 points to.** Impact on L27: **none mathematically** (the derivation exists) but the citation is unsafe as written.

## 7. Pre-registered question 3, is $\tfrac12$ the maximum, or only attained?

**It is the maximum on $W^\perp$, and I can close this by hand over all $p,q$ rather than by the block's symbolic solve.** The ten values reduce to four families, and each is compared to $\tfrac12$ in closed form.

| value | on how many summands | $=\tfrac12$ when | $>\tfrac12$ when |
| --- | --- | --- | --- |
| $1$ | $1$ (but $\langle W\rangle\not\subset W^\perp$ |), | always, and **off $W^\perp$** |
| $\tfrac12$ | $1$, the orbit | always | never |
| $\lambda_m=\tfrac{m-2}{2(m-1)}$ | $2$ | never: $\lambda_m=\tfrac12\iff m-2=m-1$ | never |
| $+\mu$ | $1$ | $(p-2)(q-2)=1$ | $(p-2)(q-2)<1$ |
| $-\mu$ | $1$ | never, $\mu>0$ for $p,q\ge3$ | never |
| $0$ | $4$ | never | never |

For integers $p,q\ge3$ the factors $p-2,q-2$ are positive integers, so $(p-2)(q-2)=1$ forces $p-2=q-2=1$, i.e. $(p,q)=(3,3)$, and $(p-2)(q-2)<1$ is impossible. **So for $p,q\ge3$ with $(p,q)\ne(3,3)$, no summand other than $\mathbb R^p\otimes\mathbb R^q$ reaches or exceeds $\tfrac12$ on $W^\perp$, and $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ attained there alone. PROVEN.**

**What another summand reaching $\tfrac12$ would mean.** $\ker\mathrm{Hess}=E_{L_e}(\tfrac12)$, so a second summand at exactly $\tfrac12$ adds its whole dimension to $\dim E(\tfrac12)$ and the kernel exceeds the orbit, the Morse–Bott criterion fails, which is $(3,3)$. A summand strictly above $\tfrac12$ instead leaves the point nondegenerate but not a maximiser, which is $\min(p,q)=2$. **These are two different failures and the record says so** ([nondegeneracy.md](../findings/nondegeneracy.md):441).

**The $\langle W\rangle$ row deserves naming.** $L_e$ has eigenvalue $1>\tfrac12$ on $\langle W\rangle$. The statement is safe only because it restricts to $W^\perp$, and it does. **A consumer who drops the restriction gets a false statement**, and $\lambda_{\max}(L_e)=1$ at every critical point. The block's ten-value list prints $1$ first without flagging that this one row lives outside the space the statement is about.

### The five recorded spectrum rows, re-derived by hand

Multiplicities: $-\mu$ at $s(p)s(q)$, $+\mu$ at $c(p)c(q)$, $\lambda_m$ at $s(m)$, $\tfrac12$ at $pq$, $1$ simple, $0$ at $W(p)+W(q)+X(p)q+X(q)p$.

| split | $\mu$ | $\lambda_p,\lambda_q$ | reconstructed spectrum | file's row | total |
| --- | --- | --- | --- | --- | --- |
| $3{+}5$ | $\tfrac6{16}=\tfrac38$ | $\tfrac14,\tfrac38$ | $-\tfrac38^{5\cdot14=70}$, $0^{0+35+25+105=165}$, $\tfrac14^{5}$, $\tfrac38^{3\cdot10+14=44}$, $\tfrac12^{15}$, $1^1$ | matches | $300=\dim\mathrm{Weyl}_8$ |
| $4{+}4$ | $\tfrac6{18}=\tfrac13$ | $\tfrac13,\tfrac13$ | $-\tfrac13^{81}$, $0^{10+10+64+64=148}$, $\tfrac13^{36+18=54}$, $\tfrac12^{16}$, $1^1$ | matches | $300$ |
| $3{+}7$ | $\tfrac8{24}=\tfrac13$ | $\tfrac14,\tfrac5{12}$ | $-\tfrac13^{5\cdot27=135}$, $0^{0+168+35+315=518}$, $\tfrac14^5$, $\tfrac13^{3\cdot21=63}$, $\tfrac5{12}^{27}$, $\tfrac12^{21}$, $1^1$ | matches | $770=\dim\mathrm{Weyl}_{10}$ |
| $4{+}6$ | $\tfrac8{30}=\tfrac4{15}$ | $\tfrac13,\tfrac25$ | $-\tfrac4{15}^{9\cdot20=180}$, $0^{10+84+96+256=446}$, $\tfrac4{15}^{6\cdot15=90}$, $\tfrac13^{9}$, $\tfrac25^{20}$, $\tfrac12^{24}$, $1^1$ | matches | $770$ |
| $5{+}5$ | $\tfrac8{32}=\tfrac14$ | $\tfrac38,\tfrac38$ | $-\tfrac14^{196}$, $0^{35+35+175+175=420}$, $\tfrac14^{100}$, $\tfrac38^{28}$, $\tfrac12^{25}$, $1^1$ | matches | $770$ |

**All five rows reproduce exactly, multiplicity by multiplicity, and each total equals $\dim\mathrm{Weyl}_n$.** This is the strongest internal corroboration available without computation: five independent instances of a ten-parameter list, each closing to the right total. **No finding.**

## 8. The orbit-tangent identification, as two separate claims

The statement asserts $\dim E(\tfrac12)=pq=\dim(\text{orbit})$. These are different claims with different supports.

**(a) $\dim E(\tfrac12)=pq$.** Given §2, §3 and §7, $E(\tfrac12)\cap W^\perp$ is exactly the summand $\mathbb R^p\otimes\mathbb R^q$, of dimension $pq$. **PROVEN** for every $p,q\ge3$ with $(p,q)\ne(3,3)$, subject to the decomposition existing there (§9).

**(b) $\dim(\text{orbit})=pq$.** The written proof does **not** derive this. It rests on Nienhaus Prop. 4.6(b), read verbatim in the local copy:

> *"within the space $(\mathbb R^k\otimes\mathbb R^l)_k\oplus(\mathbb R^k\otimes\mathbb R^l)_l$ there is a $k\cdot l$-dimensional subspace, generated by the elements $[\mathrm{ad}_v,W_{S^k\times S^l}]$ for $v\in\mathbb R^k\otimes\mathbb R^l$ that corresponds to the tangent space of $SO(n).W_{S^k\times S^l}$ at $W_{S^k\times S^l}$."*

**Proposition 4.6 carries the hypotheses $k,l\ge5$ and $k,l\ne6$.** The summary display's broader clause covers *irreducibility* at $k,l\ge3$; it says nothing about the orbit tangent. Remark 4.7(ii) covers $k,l\le4$ only as *"a similar decomposition"*, with no orbit-tangent clause. **So for $\min(p,q)\in\{3,4\}$ (which is inside L27's scope, and includes $(3,4),(3,5),(3,6),\dots,(4,4),(4,5),\dots$), the equality $\dim(\text{orbit})=pq$ is cited outside the hypotheses of the only result on file that states it.**

*Locate:* [nondegeneracy.md](../findings/nondegeneracy.md):466–467, *"so $\dim E(\tfrac12)=pq=\dim(\text{orbit})$"*, and the sourcing line at :51. *Exhibit:* at $S^3\times S^7$, $n=10$, the record's own spectrum row gives $\dim E(\tfrac12)=21$; the claim $\dim(\text{orbit})=21$ requires the isotropy algebra of $W_{3,7}$ in $\mathfrak{so}(10)$ to be exactly $\mathfrak{so}(3)\oplus\mathfrak{so}(7)$, and no file states that at $p=3$. *Argue the opposite:* the differentiation argument gives $T_W\mathcal O\subseteq E(\tfrac12)$, hence $\dim(\text{orbit})\le pq$, so what is missing is only the reverse inequality; and $\dim\mathfrak{so}(n)-\dim\mathfrak{so}(p)-\dim\mathfrak{so}(q)=\tfrac{n(n-1)-p(p-1)-q(q-1)}2=\tfrac{2pq}2=pq$ exactly, so the arithmetic is trivial **once the isotropy algebra is known**. **That last step is precisely what is not on file at $\min(p,q)\le4$, and supplying it here is not a verifier's job.**

**Verdict on (b): HYPOTHESIS-DEBT.** What would have to be shown: *the isotropy subalgebra of $W_{p,q}$ in $\mathfrak{so}(n)$ is exactly $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ for $\min(p,q)\in\{3,4\}$*, equivalently, that Prop. 4.6(b) extends below $k,l\ge5$. Everything else in the clause is then arithmetic.

**Note the consequence for the headline.** Morse–Bott nondegeneracy is $\ker\mathrm{Hess}=T_W\mathcal O$. Part (a) plus $T_W\mathcal O\subseteq E(\tfrac12)$ gives $\ker\mathrm{Hess}\supseteq T_W\mathcal O$ with $\dim\ker=pq$; the equality of the two spaces needs (b). **So the debt reaches the word "nondegenerate" at $\min(p,q)\le4$, not merely the parenthetical.** At $p,q\ge5$, which is the range [Lemma L69](../findings/graded-half.md) and the route actually consume, Prop. 4.6(b) applies on its own hypotheses and there is no debt.

## 9. Pre-registered question 2, are the excluded cases excluded for the stated reason?

### $(3,3)$, excluded by the object

$\mu(3,3)=\dfrac{6-2}{2\cdot2\cdot2}=\dfrac48=\dfrac12$ **exactly**, so $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)$, of dimension $c(3)^2=9$, joins the orbit's $9$ and $\dim E(\tfrac12)=18$ against orbit $9$. **Every number in the block's sentence checks.** The trace identity is satisfied there too: $1+\tfrac92+\tfrac54+\tfrac54+\tfrac12\cdot9-\tfrac12\cdot25=1+4.5+1.25+1.25+4.5-12.5=0$.

**And the mechanism the block names is the right one.** Under $O(3)$, $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det$, and $\det$ is non-trivial, so $\Lambda^2(\mathbb R^3)\not\cong\mathbb R^3$. Hence under $O(3)\times O(3)$ the summands $\mathbb R^3\otimes\mathbb R^3$ and $\Lambda^2\otimes\Lambda^2$ are non-isomorphic irreducibles and the commutant of their sum is $\mathbb R\oplus\mathbb R$, **dimension $2$**. Under $SO(3)\times SO(3)$ they become isomorphic, the sum is two copies of one $9$-dimensional irreducible, and the commutant is $M_2(\mathbb R)$, **dimension $4$**. **The block's "$\dim\mathrm{Comm}_{O(3)^2}=2$ against $\dim\mathrm{Comm}_{SO(3)^2}=4$" is exactly right, and it is what licenses "eigenvalue coincidence, not representation mixing": Schur forbids mixing, and the two summands carry $\tfrac12$ independently.**

**Forced by the object, not by the argument.** The point genuinely fails the Morse–Bott criterion at $(3,3)$; no repair of the argument recovers it.

### $q\le2$, excluded by the object, and more sharply than the block says

- **$q=2$.** Three things fail, in increasing severity. *(i)* $\mu(2,q)=\tfrac{n-2}{2(q-1)}>\tfrac12$ since $(p-2)(q-2)=0<1$, so $\lambda_{\max}>\tfrac12$ and the conclusion is false as stated. *(ii)* The ten dimensions **overshoot $\dim\mathrm{Weyl}_n$ by $2$** (§3), so the display is not a decomposition at all. *(iii)* [second-order.md](../findings/second-order.md):753 records that the $\lambda_p$-eigenvector needs $F_1\setminus\{j,k\}$ non-empty, so at $p=2$ the value $\tfrac{p-2}{2(p-1)}=0$ is **not in the spectrum**. **The block gives only reason (i), by way of the final display. Reason (ii) is the decisive one, the argument has no object to run on.**
- **$q=1$.** Worse still: $S^2_0(\mathbb R^1)=0$, $\Lambda^2(\mathbb R^1)=0$, and $X(1)=\tfrac{1\cdot(1-4)}3=-1$, a negative "dimension". The display is meaningless. **No file states this; it is arithmetic from the block's own formulas.**
- **The nondegeneracy question at $q=2$ is separate and the record answers it elsewhere**: [nondegeneracy.md](../findings/nondegeneracy.md):441 records that at $\min(p,q)=2$ the point is *"nondegenerate but not a maximiser"*. **So the exclusion $p,q\ge3$ removes cases where L27's *equality* $\lambda_{\max}=\tfrac12$ fails, not cases where nondegeneracy fails.** A consumer citing L27 for "$S^2\times S^q$ is degenerate" would be wrong, and the L27 statement does not say it is.

### The other edges the brief names

| edge | check |
| --- | --- |
| $(3,4)$ | $\mu=\tfrac5{12}$, $\lambda_3=\tfrac14$, $\lambda_4=\tfrac13$; $\max=\tfrac12$ on the orbit. **Inside scope, conclusion holds.** $\tfrac12-\mu=\tfrac{1\cdot2-1}{2\cdot2\cdot3}=\tfrac1{12}$, which matches [results.md](../results.md):423's *"at $(3,4)$ … the gap is $\tfrac1{12}$"* |
| **odd $n$** | Nothing in the argument uses parity of $n$, $p$ or $q$. $\lambda_m$, $\mu$ and the dimension identity are rational in $p,q$; Nienhaus Prop. 2.25 is explicitly valid for odd $n$. The $(3,4)$ and $(3,7)$ rows above are odd-$n$ instances and reproduce exactly. **No finding.** |
| unbalanced splits | $(3,7)$ and $(4,6)$ reproduce exactly (§7). $(5,7)$ is the swap-discriminant point and gives $70$ exactly. The record's stale *"not proven for the unbalanced splits"* is already struck at [nondegeneracy.md](../findings/nondegeneracy.md):770. **No finding.** |
| $p$ or $q=6$ | **Worth naming, because Prop. 4.6 carries $k,l\ne6$.** That hypothesis attaches to $\Lambda^3(\mathbb R^k)\otimes\mathbb R^l$, which splits under $SO(6)$, and Prop. 4.6(f) places $\Lambda^3(\mathbb R^k)\otimes\mathbb R^l$ **outside** $\mathrm{Weyl}_n$. So it never reaches the ten-summand display, which is why the summary display can say $k,l\ge5$ with no exclusion. **No finding, and the record never had to explain this.** |
| $p=q$ | The stabiliser gains the factor swap, which is an extra component of $O(p)\times O(q)$'s normaliser and contributes nothing to $\mathfrak{so}(n)$, so $\dim(\text{orbit})=pq$ is unaffected. Both $S^2_0$ copies carry the same $\lambda_m$, which the $(4,4)$ and $(5,5)$ rows confirm and which [second-order.md](../findings/second-order.md):1221 records as having cost a factor of $n$ elsewhere. **No finding for L27.** |

### Quantifier order and scope

The statement quantifies $\forall p,q\ge3$ with $(p,q)\ne(3,3)$, then asserts a property of one point $W_{p,q}$ and one operator $L_e$. There is no hidden $\exists$ and no uniformity claim, in particular **the statement claims nothing uniform in $n$**, and the block's $\tfrac12-\mu$ display is a *positivity* statement, not a margin. **Read this way the block is clean**, and the correction at [nondegeneracy.md](../findings/nondegeneracy.md):752, that $\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ is *"the gap to the family-B block, not to the spectrum"*, **does not bite on L27's own display**, which never calls it a spectral gap. Verified against my own table in §7: the true second eigenvalue is $\max\{\lambda_{\max(p,q)},\mu\}$, so the gap is $\min\{\tfrac1{2(M-1)},\tfrac12-\mu\}$ with $M=\max(p,q)$, which is $\tfrac1{2(M-1)}$ except at $(3,4)$, exactly as :752 says.

## 10. Comparing the forms

| form | text | verdict |
| --- | --- | --- |
| **canonical proof**, [nondegeneracy.md](../findings/nondegeneracy.md):463–502 | statement + argument + four supporting boxes | the object checked here |
| **canonical statement**, [results.md](../results.md):423–427 | *"Let $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$. Then $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ at $W_{p,q}$, attained exactly on the orbit tangent, so $\dim E(\tfrac12)=pq=\dim(\text{orbit})$ and $S^p\times S^q$ is Morse–Bott nondegenerate."* | **word-for-word identical** to the block's statement. **No drift.** |
| **landscape line L27**, [results.md](../results.md):140 | *"The isotypic decomposition is multiplicity-free, so Schur makes $L_e$ scalar on each of ten summands and each value is an eigenvalue, not a lower bound. For $p,q\ge3$ other than $(3,3)$, $\lambda_{\max}=\tfrac12$ on the orbit alone."* | **accurate and complete**, and it carries both exclusions |
| **landscape line L11**, [results.md](../results.md):130 | *"…verified at all 36 splits up to $n=14$ and proven in exact arithmetic at eight. The one exception is representation-theoretic rather than dimensional…"* | **two defects**; see §11 |
| **Lean** | **no row exists.** [lean/INDEX.md](../lean/INDEX.md):361 places **L27** in *"out, needs machinery Mathlib does not have"*, under *"branching and isotypic decompositions of $\mathfrak{so}(n)$"* | see below |

**What an L27 Lean row would have to claim, if one were written.** The isotypic content is genuinely out of Mathlib's reach, but **two of the block's steps are arithmetic and are formalisable today**, on the pattern of the existing [L126](../lean/HamiltonsCubic/Results/L126.lean) and [L26](../lean/HamiltonsCubic/Results/L26.lean) rows:

1. **The dimension identity**, that $W(p+q)=1+W(p)+W(q)+pq+s(p)+s(q)+s(p)s(q)+c(p)c(q)+X(p)q+X(q)p$ as polynomials in $\mathbb Q[p,q]$. This is §3, a `ring`-closable identity, and it is the only *proved* content the ten-summand display carries that does not import representation theory.
2. **The $\tfrac12$-comparison**, that for integers $p,q\ge3$, $\max\{\lambda_p,\lambda_q,\mu,-\mu,0\}<\tfrac12$ iff $(p,q)\ne(3,3)$, which reduces to $(p-2)(q-2)>1$ over positive integers, the same factorisation [L126](../lean/HamiltonsCubic/Results/L126.lean) already carries.

The row would then have to say **owed**: the decomposition itself, its multiplicity-freeness, Schur, and $\dim(\text{orbit})=pq$. **I state this as what the row would claim; I have not written it and the record is entitled to leave L27 out of Lean.**

## 11. The named trap, reading each citable claim alone, as a consumer would

The record's signature failure is a correction landing **beside** the statement it corrects. It fires three times here, all in the file that houses L27's proof, and once in [results.md](../results.md).

### 11a. The refuted $(3,3)$ mechanism is still asserted as fact, twice, in [nondegeneracy.md](../findings/nondegeneracy.md)

*Locate.* [nondegeneracy.md](../findings/nondegeneracy.md):129:

> *"At $k=l=3$, $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$ (the orbit's own irrep) so two copies land on $\tfrac\theta2$ and the kernel is $18$ against an orbit of $9$."*

and again at [nondegeneracy.md](../findings/nondegeneracy.md):450, in near-identical words, **six lines after** :444 refutes it:

> *"The block explained the $(3,3)$ exception by $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$. **That isomorphism is true and computes nothing**, it is a coincidence of dimension in three variables, and it identifies neither the eigenvalue nor the second exceptional family."*

*Exhibit.* The isomorphism holds under $SO(3)\times SO(3)$ and **fails under $O(3)\times O(3)$**, by the $\det$-twist computed in §9, which is the group L27 works under. So the sentence at :450 asserts, as the mechanism, a statement that is false for the group in force fifteen lines below it, and the canonical block at :495–499 says the opposite in bold: *"an **eigenvalue coincidence, not representation mixing**"*.

*Argue the opposite.* The charitable reading is that :450's real content is its closing clause (*"the exception is the split rather than the dimension"*) which is true and which $S^2\times S^4$ at $n=6$ supports. **The reading rescues the paragraph's conclusion but not its stated mechanism**, and the mechanism is the part a consumer lifts, because it is the part that reads like an explanation.

**Verdict: confirmed, twice over.**

### 11b. [nondegeneracy.md](../findings/nondegeneracy.md):131 withdraws L27's own headline, unqualified

*Locate.*

> *"So 'no multiplicity-free hypothesis needed' is true and **irrelevant**, the equivariant decomposition organises the computation without proving anything. **Claims presenting Schur as the mechanism are withdrawn.**"*

and at :452, *"the content lies in the representation isomorphism above"*, the isomorphism 11a just refuted.

*Exhibit.* [results.md](../results.md):140, the citable landscape line for L27, reads: *"The isotypic decomposition is multiplicity-free, **so Schur makes $L_e$ scalar on each of ten summands** and each value is an eigenvalue, not a lower bound."* That is a claim presenting Schur as the mechanism, and the sentence at :131 withdraws it without qualification, from 320 lines above the lemma. Read alone (which is how these two sentences reach a consumer, since neither cites the other), **the record withdraws its own Tier-1 lemma's headline.**

*Argue the opposite.* :131's scope is plainly the $(3,3)$ case: *"Even under $O(3)\times O(3)$… the kernel is still $18$: multiplicity-freeness forces a scalar per piece but never forces the scalars apart."* **That argument is correct**, and it is compatible with L27, Schur supplies the scalars, and the closed forms $\lambda_m,\pm\mu$ supply their separation. **The charitable reading holds and the mathematics is untouched.** What survives is the wording: a sentence whose subject is *"claims presenting Schur as the mechanism"* with no restriction to the $(3,3)$ case, sitting in the same file as the lemma whose mechanism is Schur.

**Verdict: confirmed as a wording defect with a live citation hazard, refuted as a mathematical objection.**

### 11c. [results.md](../results.md):130, the L11 landscape line, two defects

*(i)* *"The one exception is representation-theoretic rather than dimensional"*, the same refuted phrasing as 11a, in the line a consumer of L11 reads. It also contradicts the **same bullet's own title**, *"TWO exceptional families, not one"*, three sentences earlier.

*(ii)* *"The Hessian's kernel is exactly the tangent space to the critical orbit, of dimension $k\,l$, **verified at all 36 splits up to $n=14$ and proven in exact arithmetic at eight**."* **This understates the record by a theorem.** L27 proves the statement for **every** $p,q\ge3$ with $(p,q)\ne(3,3)$; L11's line still reports a census. [nondegeneracy.md](../findings/nondegeneracy.md):770 records a correction of exactly this shape being made elsewhere in the file (a stale sentence making a proved result read as owed) and this line was not swept with it.

*Argue the opposite.* L11 and L27 are separate numbered results, and L11's line may be reporting L11's own evidence rather than L27's. **The reading is available**, but the two lines sit ten apart in [results.md](../results.md) and make incompatible claims about the same object, with L11's the weaker of the two and the one that carries the $(3,3)$ explanation.

**Verdict: confirmed.**

### 11d. What I checked and found clean

- **The canonical L27 statement and its landscape line agree word for word on both exclusions.** A consumer reading either alone gets the correct scope.
- **The block's own $\tfrac12-\mu$ display is not a margin claim**, so the :752 margin correction does not reach it (§9).
- **[nondegeneracy.md](../findings/nondegeneracy.md):770 and :682's scope corrections are already folded into the block**, which carries $p,q\ge3$ in its statement.

## 12. The one wording defect inside the block

*Locate.* [nondegeneracy.md](../findings/nondegeneracy.md):499–500:

> *"A symbolic solve over all $45$ summand pairs finds it **the only such coincidence** with $p,q\ge3$, over all $p,q$ rather than a tested range."*

and the second copy at [nondegeneracy.md](../findings/nondegeneracy.md):766, phrased *"finds that **the only coincidence** with $p,q\ge3$"*.

*Exhibit.* $45=\binom{10}2$ is the number of unordered pairs of summands, so on its plain reading the sentence says no two of the ten summands ever share a value at $p,q\ge3$ other than at $(3,3)$. **That is refuted by the record's own spectrum table.** At $(3,5)$, $\lambda_5=\tfrac38$ and $\mu=\tfrac6{16}=\tfrac38$, the same value on $S^2_0(\mathbb R^5)$ and on $\Lambda^2\otimes\Lambda^2$; [nondegeneracy.md](../findings/nondegeneracy.md):693 prints the merged multiplicity $\tfrac38^{44}=30+14$ as the evidence. At $(4,4)$, $\lambda_4=\tfrac13=\mu$, printed as $\tfrac13^{54}=36+18$. And the four zero summands coincide at every $p,q$.

*Argue the opposite.* The antecedent *"it"* is the immediately preceding clause *"$\mu=\tfrac12$ iff $p=q=3$"*, so *"such coincidence"* most naturally means **a coincidence at the value $\tfrac12$**, a non-orbit summand reaching the orbit's eigenvalue. **Under that reading the sentence is true, and §7 proves it by hand over all $p,q$**, without a symbolic solve: $\lambda_m=\tfrac12$ is impossible, $-\mu=\tfrac12$ is impossible, $0=\tfrac12$ is impossible, $1$ lives off $W^\perp$, and $\mu=\tfrac12\iff(p-2)(q-2)=1\iff(p,q)=(3,3)$.

**Verdict: WORDING DEFECT, confirmed on all three steps.** The charitable reading rescues the mathematics, so nothing in L27 is broken. What is defective is that the sentence, read alone by a consumer (which is how it will be read, since it sits in the block's own $(3,3)$ box), asserts a false general statement, and its "$45$ summand pairs" is the detail that pushes the reader toward the false reading. **The repair is one word: "the only coincidence at $\tfrac12$".** *The claim would be better made without the symbolic solve at all: the four-family comparison in §7 is a complete hand proof over all real $p,q\ge3$.*

## 13. The gap between what is proven and what is used, and what a consumer may cite

**May be cited, unconditionally, for $p,q\ge5$:**
- $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ at $W_{p,q}$, attained exactly on $\mathbb R^p\otimes\mathbb R^q$;
- $\dim E(\tfrac12)=pq=\dim(\text{orbit})$, hence $S^p\times S^q$ is Morse–Bott nondegenerate;
- the whole $L_e$ spectrum $\{1,\tfrac12,\lambda_p,\lambda_q,\pm\mu,0\}$ with the multiplicities of §7;
- $\operatorname{tr}L_e=0$ as an identity in $p,q$;
- the gap to the second eigenvalue is $\min\{\tfrac1{2(M-1)},\tfrac12-\mu\}$, $M=\max(p,q)$, **and this equals $\tfrac1{2(M-1)}$ for every $p,q\ge3$ except $(3,4)$**, per [nondegeneracy.md](../findings/nondegeneracy.md):752, which my §7 table confirms.

**May be cited for $3\le\min(p,q)\le4$, $(p,q)\ne(3,3)$, with one caveat:** everything above **except** $\dim(\text{orbit})=pq$ and, through it, the word *"nondegenerate"*. §8 records what is owed.

**May not be cited:**
- **anything at $\min(p,q)\le2$.** The display over-counts by $2$ at $q=2$ and is meaningless at $q=1$. L27 is silent there, and the record's answer lives in [Lemma L126](../findings/second-order.md) and [Lemma L26](../findings/nondegeneracy.md) instead;
- **$(3,3)$**, where $\dim E(\tfrac12)=18$;
- **$\lambda_{\max}(L_e)$ without the restriction to $W^\perp$**, that is $1$, on $\langle W\rangle$;
- **$\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ as a spectral margin.** It is the gap to $+\mu$ alone. L27's own use of it (positivity, nothing more), is correct; a consumer who reads it as *the* margin inherits the defect [nondegeneracy.md](../findings/nondegeneracy.md):752 corrects.

**Where it is used.** [results.md](../results.md):555 ([Lemma L69](../findings/graded-half.md)) consumes L27 at $p,q\ge5$ and quotes the corrected gap $\tfrac1{2(M-1)}$, **inside the clean range, and with the right margin.** [results.md](../results.md):308 ([Lemma L3](../findings/second-order.md)) consumes it at even $n\ge8$, where both factors are $\ge4$, **inside the range where §8's debt still applies at $n=8$, $(4,4)$.** [second-order.md](../findings/second-order.md):809 (Corollary L128.1) consumes it at $p,q\ge3$, $n\ge12$, and explicitly notes it stays clear of $p=2$ *"where it over-counts, $86$ against $84$"*, **correct, and the only consumer on file that names the over-count.**

## 14. What would falsify the statement, and what I did to look for it

**The object that would break it.** Either *(a)* an eleventh $O(p)\times O(q)$-summand of $\mathrm{Weyl}_n$, or two of the ten sharing a Young label, at some $p,q\ge3$, which would let $L_e$ mix and turn the ten values back into Rayleigh bounds; or *(b)* a pair $p,q\ge3$ with $(p,q)\ne(3,3)$ at which some non-orbit summand's eigenvalue equals or exceeds $\tfrac12$.

**What I did.** For *(a)*: expanded the dimension identity symbolically by hand (§3) and found it exact as a polynomial in $p,q$, so no eleventh summand of positive dimension can be hiding in the count; and resolved the two dimension collisions at $m=3$ ($[1,1]$ vs $[1]$, $[2,1]$ vs $[2]$) and confirmed there are none at $m=4$, by the associated-partition rule (§2). For *(b)*: solved each of the four value families against $\tfrac12$ in closed form over all real $p,q$ (§7), finding $\lambda_m=\tfrac12$ and $-\mu=\tfrac12$ and $0=\tfrac12$ unsolvable and $\mu=\tfrac12$ solvable only on the hyperbola $(p-2)(q-2)=1$, whose only integer point with $p,q\ge3$ is $(3,3)$. **No falsifier exists, and the search was exhaustive rather than sampled.**

**The one place a falsifier could still live** is outside the spectral claim: §8's $\dim(\text{orbit})=pq$ at $\min(p,q)\le4$. An isotropy algebra strictly larger than $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ at, say, $W_{3,7}$ would leave $\dim E(\tfrac12)=21$ standing while making the orbit smaller, and the point would then be **degenerate with $\lambda_{\max}$ still $\tfrac12$**, a failure mode neither of the record's two named ones. **I did not look for one computationally and could not have: the record is on an analysis-only footing and this would be a search.** What I did is read every file the record cites for the clause, and Prop. 4.6(b) is the only statement of it.

## 15. Verdict

**PROVEN, hypotheses corrected.**

The spectral content of Lemma L27 is correct and I re-derived every part of it by hand: the dimension identity as an exact polynomial identity, the multiplicity-freeness including both dimension collisions at $m=3$, the Schur step, the trace identity as an identity rather than at sample points, the uniqueness of the $-\mu$ solve, the swap discriminant in general form, all five recorded spectrum rows multiplicity by multiplicity, the $(3,3)$ commutant counts, and the exhaustive comparison of all four value families against $\tfrac12$. **The Nienhaus attribution is accurate and I read it in the local copy rather than from memory**, the summary display's closing sentence says *"irreducible under the action of $O(k)\times O(l)$ for any $k,l\ge3$"*, verbatim, which is exactly what the block claims for it.

**The corrections the block owes its own statement:**

1. **$\dim(\text{orbit})=pq$ is HYPOTHESIS-DEBT at $\min(p,q)\in\{3,4\}$** (§8). What must be shown: the isotropy subalgebra of $W_{p,q}$ in $\mathfrak{so}(n)$ is exactly $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ there. Prop. 4.6(b), the only statement of it on file, carries $k,l\ge5$. **This reaches the word "nondegenerate", not only the parenthetical.**
2. **"the only such coincidence" must read "the only coincidence at $\tfrac12$"** (§12), in both copies. As written it is false, refuted by the record's own $\tfrac38^{44}$ at $(3,5)$ and $\tfrac13^{54}$ at $(4,4)$.
3. **The $q\le2$ exclusion is stronger than the block's reason for it** (§9): the ten dimensions over-count by $2$ at $q=2$, so the display is not a decomposition there, an object-level failure, not just $\mu>\tfrac12$.
4. **Three unstated steps** (§1b, §5): $L_e$ self-adjoint, $T$ fully symmetric, and that only the $\mathcal W_n$-component of $\sum_iQ(V_i)$ needs to vanish. All three hold and are on file; none is in the block.
5. **The division-algebra step is over-general** (§4): every $O(m)$-irreducible is of real type, so $\mathrm{End}=\mathbb R$ throughout and symmetry is never called on for that purpose. The block's own commutant computation reports it.

**And the named trap fires three times, all outside the block** (§11): [nondegeneracy.md](../findings/nondegeneracy.md):129 and :450 still assert the refuted $\Lambda^2\otimes\Lambda^2\cong\mathbb R^3\otimes\mathbb R^3$ mechanism as fact, six lines after :444 refutes it and forty-five lines before the canonical block calls it *"an eigenvalue coincidence, not representation mixing"*; :131 withdraws *"claims presenting Schur as the mechanism"* without restriction, which is L27's own headline at [results.md](../results.md):140; and [results.md](../results.md):130 carries both the refuted phrasing and a census where L27 has a theorem. **A consumer who reads any of those four lines alone is misled about L27, and none of the four cites L27.**
