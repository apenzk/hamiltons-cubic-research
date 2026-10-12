# Brief for round L37

**Verbatim extracts. Nothing here is paraphrased. Where the record states the same thing twice, both are given unlabelled.**

## A. The canonical entry, results.md lines 509-513

```markdown
##### Lemma L37, diagonality is decided by a single kernel

For $W\in\mathcal W_n$ and symmetric $A\in\mathrm{Sym}^2(\mathbb R^n)$ let $\delta_A$ act on $\Lambda^2$ by $\delta_A(X)=AX+XA$, and let $\Phi_W(A)=[W,\delta_A]$. Then $W$ is diagonal in some orthonormal frame of $\mathbb R^n$ (every $\varphi_{ij}=e_i\wedge e_j$ an eigenvector) if and only if $\ker\Phi_W$ contains an $A$ whose eigenvalues have pairwise-distinct sums $a_i+a_j$. The test is frame-independent, necessary and sufficient, and carries no information about $\theta$; since the diagonal matrices in any frame supply an $n$-dimensional subspace of $\ker\Phi_W$ when $W$ is diagonal there, $\dim\ker\Phi_W<n$ certifies non-diagonality outright. It is the criterion by which Observation L40 separates the two sides of the critical set.

**Proof:** [target.md](findings/target.md)
```

## B. The landscape statement, results.md line 160

```markdown
- **Lemma L37 (landscape). Diagonality is decided by a single kernel.** Let $\delta_A(X)=AX+XA$ for symmetric $A$ and $\Phi_W(A)=[W,\delta_A]$. Then $W$ is diagonal in some orthonormal frame if and only if some $A\in\ker\Phi_W$ has pairwise-distinct sums $a_i+a_j$; in particular $\dim\ker\Phi_W<n$ certifies non-diagonality with no frame search.
```

## C. A summary-table row, results.md line 16

```markdown
| Diagonality decided by one kernel, frame-free | **Proven** (Lemma L37) |
```

## D. The block, findings/target.md lines 632-648

```markdown
#### Lemma L37, diagonality is decided by a single kernel

*Numbered here on 2026-08-31: the result was numbered in [report/](../report/), and until this audit neither direction was argued anywhere in [findings/](.). **The pointer that stood here named a section about the $(\mathfrak{su}(m),\mathfrak{so}(m))$ Kähler family, whose only contact with this lemma is one parenthesis applying it.** The proof is below.*

For $W\in\Weyl_n$ let $\delta_A(X)=AX+XA$ for symmetric $A$, and let $\Phi_W(A)=[W,\delta_A]$. Then $W$ is diagonal in *some* orthonormal frame if and only if some $A\in\ker\Phi_W$ has pairwise-distinct sums $a_i+a_j$. In particular $\dim\ker\Phi_W<n$ certifies non-diagonality outright. *Diagonal* here means diagonal on the coordinate $2$-planes of the frame.

**Proof.** $\delta_A$ preserves the skew matrices and is the derivation extension $u\wedge v\mapsto Au\wedge v+u\wedge Av$, so in $A$'s eigenframe $\delta_A\varphi_{ij}=(a_i+a_j)\varphi_{ij}$.

*If $W$ is diagonal in some frame $\{f_i\}$*, take $A=\sum_i2^if_if_i^{\mathsf T}$: its sums $2^i+2^j$ are pairwise distinct by uniqueness of binary representations (**so the distinctness is achievable at every $n$ and is never a genericity obstruction**) and $A$ commutes with $W$'s diagonal action, so $A\in\ker\Phi_W$.

*Conversely*, let $A\in\ker\Phi_W$ have pairwise-distinct sums. For $n\ge3$ that forces the $a_i$ themselves distinct, so $\delta_A$ has simple spectrum on $\Lambda^2$ with eigenlines $\mathbb R\varphi_{ij}$; and $[W,\delta_A]=0$ makes $W$ preserve each of them, which is diagonality in $A$'s eigenframe.

*The corollary.* A diagonal $W$ has all $n$ diagonal matrices in $\ker\Phi_W$, so $\dim\ker\Phi_W<n$ excludes diagonality. **It needs neither criticality nor $W\in\mathcal W_n$**, and it is not vacuous, $\dim\ker\Phi_W=1<4$ at $n=4$. $\square$

**The equivalence is decidable at every kernel dimension, and only the corollary is one-directional.** On the linear subspace $\ker\Phi_W$ the distinct-sums condition is the non-vanishing of a polynomial, which therefore either vanishes identically on it or is non-zero on a dense Zariski-open subset, so "some $A$ with distinct sums" is decided outright, including at $\dim\ker\Phi_W=n$ where the corollary says nothing. **This is what makes the residual statement decidable without an $O(n)$ search**, and the record had it only in a script comment.

**The quantifier is load-bearing.** $\mathrm{Id}\in\ker\Phi_W$ always and has all sums equal, so the criterion must ask for *some* $A$ with distinct sums rather than all. **And the test is frame-independent**: $\ker\Phi_{gWg^{-1}}=g(\ker\Phi_W)g^{-1}$, so both the dimension and the distinct-sums clause are $O(n)$-invariant.
```
