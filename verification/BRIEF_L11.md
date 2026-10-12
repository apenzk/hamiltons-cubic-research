# Brief for round L11

**Verbatim extracts. Nothing here is paraphrased. Two of these passages contradict each other; both are given unlabelled.**

## A. The canonical statement, from results.md lines 393-395

```markdown
##### Lemma L11, nondegenerate for $p,q\ge3$ with $(p,q)\ne(3,3)$; degenerate at $\min(p,q)=2$ and at $(3,3)$

**Proof:** [nondegeneracy.md](findings/nondegeneracy.md)
```

## B. The landscape statement, from results.md line 130

```markdown
- **Lemma L11 (landscape). $S^p\times S^q$ is Morse–Bott nondegenerate for $p,q\ge3$ with $(p,q)\ne(3,3)$, TWO exceptional families, not one.** *This read "every two-block sphere product except $S^3\times S^3$" and was false at $\min(p,q)=2$, where [Lemma L26](findings/nondegeneracy.md) records the dangerous eigenvalue reaching $\tfrac12$ with excess $\tfrac1{2(n-3)}>0$.* The Hessian's kernel is exactly the tangent space to the critical orbit, of dimension $k\,l$, verified at all 36 splits up to $n=14$ and proven in exact arithmetic at eight. The one exception is representation-theoretic rather than dimensional, and the rival maximizer satisfies the same identity.
```

## C. The index row, from findings/INDEX-results.md line 26

```markdown
| **11** | Lemma | **Gate 2: STATEMENT REFUTED AND CORRECTED, MECHANISM REPLACED** ([r461](../reviews/REVIEW_r461.md), [r462](../reviews/REVIEW_r462.md)). nondegenerate for $p,q\ge3$ with $(p,q)\ne(3,3)$, **two exceptional families, not one**, the old statement being false at $\min(p,q)=2$; proof now runs through [L26](nondegeneracy.md)'s closed form and [L27](nondegeneracy.md) | [nondegeneracy.md](nondegeneracy.md) |
```

## D. The block in findings/nondegeneracy.md, lines 434-452

```markdown
#### Lemma L11, the two-block sphere products that are Morse–Bott nondegenerate, and the two families that are not

> **STATEMENT, CORRECTED 2026-09-04.** *For $p,q\ge3$ with $(p,q)\ne(3,3)$, $S^p\times S^q$ is Morse–Bott nondegenerate: the Hessian kernel is exactly the orbit tangent, of dimension $pq$.* **The single degenerate case is $(3,3)$.** *A correction recorded here on 2026-09-04 named $\min(p,q)=2$ as a second degenerate family, and that is wrong: at $p=2$, $\mu=\frac{n-2}{2(n-3)}=\tfrac12+\frac1{2(n-3)}$ is **strictly above** $\tfrac12$, which costs the point its **maximality** and not its nondegeneracy, degeneracy needs the value $\tfrac12$ itself, and at $S^2\times S^4$ the spectrum is $1,\tfrac12,0,\tfrac13,\pm\tfrac23$, with $\tfrac12$ at multiplicity $pq=8$, exactly the orbit. The conflation was of $\mu\ge\tfrac12$ failing with $\mu=\tfrac12$ holding.* **[Lemma L128](second-order.md) says the same and is right.** *Gate 2, [r538](../reviews/REVIEW_r538.md).*

> **THE OLD STATEMENT NAMED ONLY $S^3\times S^3$ AND WAS FALSE AT $p=2$.** *[Lemma L26](../findings/nondegeneracy.md#lemma-l26-the-dangerous-eigenvalue-of-the-two-block-spectrum-in-closed-form-canonical-statement-and-proof), sixty lines above it in this file, records that the dangerous eigenvalue **reaches** $\tfrac12$ at $p=2$ with excess $\tfrac1{2(n-3)}>0$*, a direction outside the orbit carrying the orbit's own eigenvalue, which is degeneracy.

> **PROOF, REPLACING THE REFUTED MECHANISM.** [Lemma L26](../findings/nondegeneracy.md#lemma-l26-the-dangerous-eigenvalue-of-the-two-block-spectrum-in-closed-form-canonical-statement-and-proof) gives the closed form
> $$\mu=\frac{n-2}{2(p-1)(q-1)},\qquad \tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)},$$
> so $\mu<\tfrac12$ **exactly when $(p-2)(q-2)>1$**, which among $p,q\ge2$ fails only at $\min(p,q)=2$ and at $(3,3)$, **and the two failures are different failures**: at $(3,3)$, $\mu=\tfrac12$ and the point is degenerate; at $\min(p,q)=2$, $\mu>\tfrac12$ and the point is nondegenerate but not a maximiser. [Lemma L27](../findings/nondegeneracy.md#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof) then shows that in the remaining range $\tfrac12$ is attained on the orbit tangent alone, so $\dim E(\tfrac12)=pq$ and the point is nondegenerate. $\square$

> **WHAT WAS REFUTED, AND WHY IT LOOKED RIGHT.** *[r461](../reviews/REVIEW_r461.md) and [r462](../reviews/REVIEW_r462.md), independently.* The block explained the $(3,3)$ exception by $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$. **That isomorphism is true and computes nothing**, it is a coincidence of dimension in three variables, and it identifies neither the eigenvalue nor the second exceptional family. *The closed form above finds both.*

*Moved here from [results.md](../results.md) on 2026-08-31. **The claim once made here, that results.md held the only copy, is false against the commit before the move**: this file already carried a block for this result.*

At each such point the kernel of the Hessian equals the tangent space to the critical orbit exactly, no flat direction beyond the orbit, along which the potential is constant anyway. For $S^k\times S^l$ the common value is $k\,l$, matching the orbit tangent space $\mathbb{R}^k\otimes\mathbb{R}^l$ that Nienhaus identifies in closed form. Verified at all 36 splits with $k,l\ge2$ up to $n=14$, and established in **exact arithmetic** (over $\mathbb{Q}$ at $n=6$ and modulo two primes at $n=8,10,12$), at eight of them, including $(4,4)$, $(3,5)$, $(5,5)$, $(3,7)$, $(6,6)$, $(5,7)$ and $(3,9)$. Clearing the denominators makes the eigenvalue an integer and the kernel an integer linear system, so no numerical threshold enters. $S^7\times S^7$ at $n=14$ rests on floating point.

**The exception is $(3,3)$, and it is representation-theoretic rather than dimensional.** At $k=l=3$ one has $\Lambda^2(\mathbb{R}^3)\otimes\Lambda^2(\mathbb{R}^3)\cong\mathbb{R}^3\otimes\mathbb{R}^3$ (the orbit's own representation) so two copies land on the same eigenvalue and the kernel is $18$ against an orbit of $9$. That isomorphism holds for no other $(k,l)$, and $S^2\times S^4$ at the same $n=6$ is nondegenerate, so the exception is the split rather than the dimension.

**Schur is not the mechanism.** Even under $O(3)\times O(3)$, where the isotypic decomposition *is* multiplicity-free, the kernel is still $18$: multiplicity-freeness forces one scalar per piece but never forces the scalars apart. So the equivariant decomposition organises the computation without proving the result, and the content lies in the representation isomorphism above.
```
