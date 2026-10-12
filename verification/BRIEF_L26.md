# Brief for round L26

**Verbatim extracts. Nothing here is paraphrased. The two statements of the binding cases differ; both are given unlabelled.**

## A. The canonical statement, from results.md lines 429-435

```markdown
##### Lemma L26, the dangerous eigenvalue of the two-block spectrum, in closed form

Let $n=p+q$ with $p,q\ge2$, let $\pi$ be a coordinate $2$-plane inside the $p$-block and $\rho$ one inside the $q$-block, and let $X$ be $\phi_\pi\odot\phi_\rho$ with its $\Lambda^4$ component removed. Then $X\in\mathrm{Weyl}_n$, and for the sphere product's $e$,

$$e\circ X=\mu X,\qquad \mu=\frac{n-2}{2(p-1)(q-1)},\qquad \mu\ge\tfrac12\iff(p-2)(q-2)\le1 .$$

So the family reaches $\tfrac12$ exactly at $p=2$, where it gives the recorded excess $\tfrac1{2(n-3)}$, and at $(p,q)=(3,3)$, where it is an equality. For $p,q\ge3$ other than $(3,3)$ and $(3,4)$ the gap is $1/(2\max(p,q)-2)$; at $(3,4)$ this family's own $\mu=\tfrac5{12}$ overtakes $\lambda_{\max(p,q)}$ and the gap is $\tfrac1{12}$.
```

## B. The landscape statement, from results.md line 138

```markdown
- **Lemma L26 (landscape). One eigenvalue family of the sphere-product spectrum, in closed form.** For a 2-plane in each block, the Bianchi-projected product is an eigenvector with $\mu=(n-2)/(2(p-1)(q-1))$, so $\mu\ge\tfrac12$ exactly at $p=2$ and at $(3,3)$. Proved for any three-block diagonal operator; criticality is unused. It bounds $\lambda_{\max}$ from below only.
```

## C. The block in findings/nondegeneracy.md, lines 78-106

```markdown
#### Lemma L26, the dangerous eigenvalue of the two-block spectrum, in closed form, canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31. **The claim once made here, that results.md held the only copy, is false against the commit before the move**: [fence-posts.md](fence-posts.md) already carried this argument.*

Needed because Observation L3's nondegeneracy claim at $S^p\times S^q$ rested on a scan: the eigenvalue that
threatens to reach $\tfrac12$ had been measured split by split, so nothing covered all $n$ at once.

**Statement.** Let $n=p+q$ with $p,q\ge2$, let $\pi$ be a coordinate $2$-plane inside the $p$-block and $\rho$ one
inside the $q$-block, and let $X$ be $\phi_\pi\odot\phi_\rho$ with its $\Lambda^4$ component removed. Then
$X\in\mathrm{Weyl}_n$, and for the sphere product's $e$,
$$e\circ X=\mu X,\qquad \mu=\frac{n-2}{2(p-1)(q-1)},\qquad \mu\ge\tfrac12\iff(p-2)(q-2)\le1 .$$
So the criterion $\mu\ge\tfrac12$ binds at exactly two places, **and they are different places**: at $p=2$, where $\mu$ **exceeds** $\tfrac12$ by $\tfrac1{2(n-3)}$, and at $(p,q)=(3,3)$, where it **equals** it. *Only the equality is degeneracy, [L24](second-order.md)'s kernel is an eigenspace at $\tfrac12$, so the two cases must never be collapsed into a word like "reaches", which reads as attainment once quoted away from this display and inverted [L11](../findings/nondegeneracy.md#lemma-l11-the-two-block-sphere-products-that-are-morsebott-nondegenerate-and-the-two-families-that-are-not) for two revisions.* For $p,q\ge3$ other than $(3,3)$ **and $(3,4)$** the gap is $1/(2\max(p,q)-2)$. **At $(3,4)$ this family's own $\mu=\tfrac5{12}$ overtakes $\lambda_{\max(p,q)}=\tfrac13$**, so the second-largest eigenvalue is $\mu$ and the gap is $\tfrac1{12}$. **And $(3,4)$ is the only such split, by a criterion rather than by a search.** The comparison $\lambda_{\max}<\mu$ clears to $3p+2q-4-pq>0$, which factors as $(p-2)(q-3)<2$; over $q\ge p\ge3$ that admits exactly $(3,3)$ and $(3,4)$, and $(3,3)$ is already an equality case above. So the exception list is closed, and the reason five splits ($(3,5)$, $(4,4)$, $(3,7)$, $(5,5)$, $(4,6)$), missed it is that it is a single lattice point in the region the inequality closes off. *Gate 2, [r527](../reviews/REVIEW_r527.md); the uniqueness is kernel-checked in [L26.lean](../lean/HamiltonsCubic/Results/L26.lean).*

**Argument.** $X$ is supported on the three pairings of four indices, with coefficients $\tfrac23,\tfrac13,-\tfrac13$
and $\|X\|^2=\tfrac43$. In $T_{ab}=\sum_{m,r,t}c_{amr}\varepsilon_r c_{brt}X_{tm}$ the plane $r$ is determined by $a$
and $m$ as the third side of a triangle, so no sum over the ambient index set survives and the verification is
finite. Enumerating every plane type over a universe of the four core indices plus two spare indices in each
block (enough, since a pair of planes spans at most four indices), gives $e\circ X=\mu X$ identically in $p$ and
$q$. Holding the three block values $\varepsilon_{PP},\varepsilon_{QQ},\varepsilon_{PQ}$ as free symbols, the same
computation yields $e\circ X=\lambda X$ for **any** three-block diagonal operator, with
$\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$; criticality enters only through
$Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$, which fixes the three values and collapses $\lambda$ to $\mu$. $\square$

**What it does not reach, and this is the point.** An exhibited eigenvector bounds $\lambda_{\max}$ and one
multiplicity from **below**. The statements nondegeneracy needs, that $(3,3)$ is the *unique* split reaching
$\tfrac12$, and that $\dim E(\tfrac12)=pq$, are upper bounds on the rest of the spectrum, which no eigenvector
supplies. Those rest on the full multiplicity list, which is verified numerically at 44 splits to $n=16$ and
rigorous only at $n\le12$, **which [Lemma L27](../findings/nondegeneracy.md#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof) has since made a theorem at every $p,q\ge3$ with $(p,q)\ne(3,3)$, by the multiplicity-free decomposition rather than by a list**. The bottom-end criterion is **$p,q\ge3$, not $n\ge5$**: the ten dimensions over-count by $2$ at $q=2$ and by $1+p$ at $q=1$, so at $(3,2)$, $n=5$, the sum reads $37$ against $\dim\mathrm{Weyl}_5=35$. Historically: at $(2,2)$ the operator $e$ is non-primitive under the
Hodge splitting of $\Lambda^2(\mathbb R^4)$, the spectrum is $(-1)^4,(\tfrac12)^4,1^2$, and $1$ is not simple.
```
