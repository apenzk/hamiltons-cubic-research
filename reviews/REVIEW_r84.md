# Reviewer 84, Gate 2 on the three claimed derivations (cfdfb21, 1427bf4, d1427f6)

**No numerical checking was used.** Nothing sampled, no operator built, no spectrum computed, no formula evaluated at a data point. Hand algebra throughout; sympy only as a symbolic simplifier in the free symbols $p,q,k$.

| Claim | Verdict |
|---|---|
| 1, dual-weight lemma | **CONFIRMED as a proof.** One sentence of the correction note is itself wrong |
| 2 (balanced families | **OVERSTATED**), statement true, "proof" is a fit |
| 3 (unbalanced families | **OVERSTATED and redundant**), the unconditional proof was already in the same file |

## Claim 1, confirmed, and one sentence must go

The LP pair, the cap value $2$ (from $\lVert\mathrm{ad}_X\rVert_{\rm op}\le\sqrt2$, with $T_{\alpha\alpha\gamma}=0$ making "over $\gamma\notin\{\alpha,\beta\}$" and "over all $\gamma$" agree), the feasibility threshold $c\ge H/3$, and the strict monotonicity $\partial H/\partial\lambda_a>0$ are all correct.

**Sharpness is genuine but the record's argument is incomplete**, it gives the upper bound twice. The maximiser is $t_{\alpha\beta\gamma}=2/(k-2)$, whose pair marginal is exactly $2$ and whose total is $\binom k3\frac2{k-2}=k(k-1)/3$.

**The correction paragraph under-corrects.** It rightly says the recorded $\mu\ge2/\sum\lambda^{-1}$ was $3\times$ too large, then adds *"the prose gloss 'at least the harmonic mean of the triple' is the correct reading."* **It is not.** $\mu\ge H$ is $\tfrac92$ times the true threshold and matches neither the recorded formula ($2H/3$) nor the truth ($2H/9$). With $\mu=h$ the dual gives $3M\le\tfrac92h(s^2-u)$, four and a half times weaker than the boxed lemma. The lemma is true; the *new* derivation is what establishes it. **That sentence should go.**

## The derivation the record owed, supplied here

Deriving the whole $L_e$ spectrum from scratch. $W^*=\alpha P_{\mathfrak a}-\gamma P_{\mathfrak m}+\beta P_{\mathfrak b}$; criticality with $\theta=(n-1)/(pq)$ is an identity, not a check. $P$ is cubic, so $\mathrm{Hess}\,P=6F_W$ and the constrained Hessian is $6F_W-3\theta$: **$c=6\lambda-3$ is a change of variables, not a discovery.**

Splitting $B(W,X)=-\tfrac12\sum_c w_cA_cXA_c$ by block and using $\sum_{c\in\mathfrak a}A_cXA_c=\tfrac12(\mathrm{Cas}_pX+K_pX+XK_p)$, the block constants collapse ($d(\mathfrak a)=d(\mathfrak m)=d(\mathfrak b)=1-\tfrac1{n-1}$), leaving

$$\boxed{\ \lambda=1-\frac{\mathrm{Cas}_p}{4(p-1)}-\frac{\mathrm{Cas}_q}{4(q-1)},\qquad c=3-\frac{3\,\mathrm{Cas}_p}{2(p-1)}-\frac{3\,\mathrm{Cas}_q}{2(q-1)}\ }$$

for every $SO(p)\times SO(q)$-isotypic component. **This derives the record's standing assertion that each Casimir block carries exactly one Hessian eigenvalue, it is a cancellation, not an observation.** Every family follows from standard Casimir values, and $c=0$ on the orbit tangent becomes an identity: $\frac{\mathrm{Cas}_p(V_1)}{p-1}+\frac{\mathrm{Cas}_q(V_2)}{q-1}=1+1=2$.

Completeness comes from $S^2\Lambda^2V\ominus\Lambda^4V\ominus S^2V$; the ten summand dimensions sum to $\dim\mathrm{Weyl}_n$ identically in $p,q$. Family C is $\mathrm{Weyl}_p\oplus\mathrm{Weyl}_q\oplus[2,1]_p\otimes V_2\oplus V_1\otimes[2,1]_q$, all at $-3$, so $c_C=-3$ is **correct rather than lucky**.

## The substantive gap a fit cannot see

In the ambient $S^2\Lambda^2V$ two further families have vanishing $c$:

| family | $c$ | vanishes at |
|---|---|---|
| $\Lambda^4V_1$ | $3(7-p)/(p-1)$ | $p=7$ |
| $\Lambda^3V_1\otimes V_2$ | $3(4-p)/(p-1)$ | $p=4$ |

**Both are removed by the first Bianchi identity**, each occurs once in $S^2\Lambda^2V$ and once in $\Lambda^4V$, so multiplicity zero in $\mathrm{Weyl}_n$. **Had either survived, $S^7\times S^q$ and $S^4\times S^q$ would be degenerate and the theorem false.** Nothing in either commit rules them out, *because a list obtained by fitting recorded rows cannot know what is missing from the rows.*

## Claims 2 and 3, statements true, proofs absent

All families, dimensions, the $k=4$ merge and the $k=3$ kernel confirmed symbolically. The $18$ is recovered independently as multiplicity $2$ of $V_1\otimes V_2$ in $\mathrm{Weyl}_6$, since $\Lambda^2\mathbb R^3\cong\mathbb R^3$ makes $\Lambda^2\otimes\Lambda^2$ the orbit-tangent type at $(3,3)$.

But the text derives nothing: match one row to get an identity, assert four closed forms, observe they reproduce three tabulated rows, set them to zero. The cited origin file is a numerical diagonaliser whose `__main__` runs exactly $n=8,10,12$, **the three rows**. *A fit that extrapolates is still a fit.* Two things it cannot supply: why the family list is **complete**, and why $\dim A$ is one number when it is two inequivalent irreps sharing an eigenvalue on the diagonal.

**Bibliographic finding:** three paragraphs below the replaced text, predating the commit, the same statement is already proved unconditionally by the route reconstructed here, Nienhaus Prop 4.6's ten-summand decomposition (identical list, $X_m=[2,1]_m$, $\dim=m(m^2-4)/3$), multiplicity-freeness, Schur, plus index proofs. Checked against `d1427f6^`. **The ledger entry "the unbalanced case is now proved too" should be withdrawn.**

**The $p=2$ edge.** $S^2\times S^q$ *is* in scope and *is* nondegenerate, the master formula survives ($\mathfrak{so}(2)$ weights give $\mathrm{Cas}=0,1,4$, matching $2(p-2),p-1,2p$ at $p=2$), $c_B=3/(q-1)>0$, and $\dim E(\tfrac12)=2q=pq$. But **$S^2_0(\mathbb R^p)$ drops out of $\mathrm{Weyl}_n$ entirely at $p=2$**, which is exactly why the ten dimensions overshoot by $2$; with it removed they match identically in $q$. And $c_B>0$ means $S^2\times S^q$ is not a local maximum, a live exception the blanket sentence hides.

## The two extra questions

- **$c=0$ and Morse–Bott: one direction only.** $\ker\mathrm{Hess}=$ orbit tangent $\Rightarrow$ nondegenerate, which is what the isolation argument needs. The converse fails: at $(3,3)$ the kernel is $18$ against orbit $9$, showing the *criterion* fails, not that the point is degenerate. **Calling $S^3\times S^3$ "the failure" is a mild overstatement in both commits.** Orbit dimension really is $pq$: $A\mapsto[A,W^*]$ is equivariant with irreducible source, so injective or zero, and zero would make $W^*$ an $SO(n)$-invariant Weyl tensor.
- **Does the exception fall out of the proof?** In the record, **no**, it is fitted along with everything else, and the fit is blind to the $p=4$ and $p=7$ families. In the derivation above, yes.
