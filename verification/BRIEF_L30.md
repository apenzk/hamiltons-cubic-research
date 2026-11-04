# Brief for round L30

**Verbatim extracts. Nothing here is paraphrased. Where the record states the same thing twice, both are given unlabelled.**

## A. The canonical entry, results.md lines 461-465

```markdown
##### Lemma L30, a small negative eigenspace forces a small support

Let $W\in\mathrm{Weyl}_n$ have at most two negative eigenvalues, with negative eigenvectors $v_{N-1},v_N$ read as skew matrices, and set $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$. If $\dim U<n$ then $W$ vanishes on $u\wedge u^\perp$ for every $u\perp U$, and $W$ is a padding of a $\mathrm{Weyl}_{\dim U}$ tensor with the same norm and the same $\theta$.

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)
```

## B. The landscape statement, results.md line 146

```markdown
- **Lemma L30 (landscape). A small negative eigenspace forces a small support.** Ricci-flatness is the positive-semidefinite identity $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$, so every eigenvector **with nonzero eigenvalue** has its image in $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$. When $\dim U<n$ the tensor is a padding of a $\mathrm{Weyl}_{\dim U}$ one, in a single step.
```

## C. The block, findings/stratum-two-negative.md lines 214-241

```markdown
#### Lemma L30, a small negative eigenspace forces a small support

> **FIVE REPAIRS ARE RECORDED AROUND THIS BLOCK.** * The block's \"Gate 2 passed\" clause was contradicted by [INDEX-results.md](INDEX-results.md)'s own row, which recorded no verdict until now.*
>
> **\"At most two\" is inert to the argument and load-bearing only to the block's definition of $U$.** With $U:=\sum_{\lambda_\alpha<0}\mathop{\mathrm{im}}v_\alpha$ over **all** negative eigenvectors, the block's own three steps give the conclusion verbatim for **any number** of negative eigenvalues, with $\dim U=n-1$ admitted and no step degrading. *Left as written, the count is necessary*: $\mathrm{pad}_{V_1}(W_{\mathbb{CP}^2})+\mathrm{pad}_{V_2}(W_{\mathbb{CP}^2})$ on $\mathbb R^8$ has four negative eigenvalues, and $U$ built from two of them has $\dim U=4<8$ while $W(e_5\wedge e_6)\ne0$ for $e_5\perp U$. **The repair is the redefinition, and it is one line.**
>
> **\"With the same norm and the same $\theta$\" was asserted and never proved, and it is the clause the lemma exists for**, it is what lets a bound proved at $\dim U$ govern every $n$. Two lines: the norm from orthonormality, and $\theta$ because $\Lambda^2U=\mathfrak{so}(U)$ is a Lie subalgebra, which is what keeps $W^\#$ inside. *a prior audit's Claim 2 step 6 carried this proof, and the block was written from that review without it.*
>
> **Scope: $n=5,6,7,8$.** The block lists $6,7,8$ and omits $n=5$; the development form $34$ lines above says *\"below $n=9$\"*, which wrongly includes $n=4$ where $\dim U=n$. **Each version has one endpoint wrong.** And *\"$v_\alpha u=0$ for all $\alpha$\"* holds only for $\lambda_\alpha\ne0$.

*Moved here from [results.md](../results.md) on 2026-08-31. **The \"only copy\" clause is true of the proof text and false of the argument**: at the move's parent this file already held the padding conclusion word for word, with a proof by a second route under the equivalent hypothesis $U^\perp=\ker v_{N-1}\cap\ker v_N$, today the development-form section $34$ lines above. The second clause holds: results.md carries the statement and points here.*

Needed because the sharp stratum's members turn out to be paddings, and that is what lets a bound proved
in low dimension govern every $n$.

**Statement.** Let $W\in\mathrm{Weyl}_n$ have at most two negative eigenvalues, with negative eigenvectors
$v_{N-1},v_N$ read as skew matrices, and set $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$. If $\dim U<n$ then
$W$ vanishes on $u\wedge u^\perp$ for every $u\perp U$, and $W$ is a padding of a $\mathrm{Weyl}_{\dim U}$
tensor with the same norm and the same $\theta$.

**Proof.** $\mathrm{Ric}(W)(x,x)=\sum_\alpha\lambda_\alpha\|v_\alpha x\|^2$, so Ricci-flatness is exactly
$\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$, an identity among positive semidefinite
matrices. Hence the positive and negative sides are the same matrix, whose image is contained in $U$, and
every eigenvector with nonzero eigenvalue has its image inside $U$. For $u\perp U$ this gives
$v_\alpha u=0$ **for every $\alpha$ with $\lambda_\alpha\ne0$**, *it can fail at a kernel eigenvector, as $e_9\wedge e_{10}$ shows at padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{10}$*, and those are the only $\alpha$ the sum reaches, so $W(u\wedge w)=0$ for every $w$. The restriction to
$\Lambda^2(U)$ is Ricci-flat because the terms of $\mathrm{Ric}$ involving directions outside $U$ vanish
with $W$. $\square$

```
