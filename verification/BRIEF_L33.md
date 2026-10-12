# Brief for round L33

**Verbatim extracts. Nothing here is paraphrased.**

## A. The canonical statement, from results.md lines 471-478

```markdown
##### Lemma L33, one eigenvalue of one sign forces the tensor to vanish

Let $W\in\mathrm{Weyl}_m$ have a **one-dimensional** eigenspace on one side, exactly one eigenvalue counted *with multiplicity*. If that eigenvector is not a multiple of a complex structure on a $4$-dimensional subspace, then $W=0$. In particular no rank-$3$ $\mathrm{Weyl}_m$ tensor at even $m\ge6$ has a nondegenerate minority-side eigenvector.

**The identity the proof runs on.** Pairing the first Bianchi identity against $u\otimes u$ for arbitrary skew $u$, the term $\operatorname{tr}(u^2v_\alpha^2)$ that appears is annihilated by Ricci-flatness, leaving an operator identity on $\mathfrak{so}(m)$:

$$\sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2=2W,\qquad\text{i.e.}\qquad \sum_\alpha\lambda_\alpha N_{v_\alpha}=0,\quad N_v:=2\,v\otimes v-\mathrm{ad}(v)^2 .$$

```

## B. The landscape statement, from results.md line 152

```markdown
- **Lemma L33 (landscape). One eigenvalue of one sign forces the tensor to vanish.** If $W\in\mathrm{Weyl}_m$ has a **one-dimensional** eigenspace on one side, exactly one eigenvalue counted *with multiplicity* and that eigenvector is not a complex-structure multiple on a $4$-plane, then $W=0$. This answers the question item B0 had been reduced to; the padded $\mathrm{Weyl}_4$ family is the only boundary case.
```

## C. The block in findings/stratum-two-negative.md, lines 119-160

```markdown
#### Lemma L33, one eigenvalue of one sign forces the tensor to vanish, canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31, the duplication resolved on 2026-09-06. **The note that once stood here, that results.md held the only copy, is false**: immediately before the move a complete duplicate, statement and proof, sat in [isotropy-cap.md](isotropy-cap.md), and results.md still carries two argument paragraphs rather than the statement alone. Both reviewers established this independently against git.*

Needed because item B0 had been reduced to exactly this question, and two independent searches over $520$
starts had failed to settle it either way.

**Statement.** Let $W\in\mathrm{Weyl}_m$ have a **one-dimensional** eigenspace on one side, exactly one eigenvalue counted *with multiplicity*. If that eigenvector is not
a multiple of a complex structure on a $4$-dimensional subspace, then $W=0$. In particular no rank-$3$
$\mathrm{Weyl}_m$ tensor at even $m\ge6$ has a nondegenerate minority-side eigenvector.

> **"Exactly one eigenvalue of one sign" was ambiguous, and the lemma is FALSE under the other reading.** Counted as *one distinct value at any multiplicity*, a witness sits already in $\mathrm{Weyl}_4$: $W^+=W^-=\operatorname{diag}(2,-1,-1)$ has spectrum $(2,2,-1,-1,-1,-1)$, its $+2$ eigenspace contains a rank-$2$ element that is no complex structure, and $W\ne0$. [Lemma L34](../findings/stratum-two-negative.md#lemma-l34-full-support-with-two-negative-eigenvalues-at-m6-and-m8-canonical-statement-and-proof) supplies a second witness at $m=8$. **This file's own convention counts with multiplicity, so the statement was correct in place**, and it is quoted in [results.md](../results.md) and in the report, where that convention does not travel. *Gate 2, [r511](../reviews/REVIEW_r511.md) and [r512](../reviews/REVIEW_r512.md) on identical briefs, both CONFIRMED, each building the witness independently.*
>
> **The exception is realised and complete**, checked by cases on the degenerate ranks by both reviewers with no second family, unlike [Lemma L11](route-a.md), whose single stated exception this audit found to be two. **And [Lemma L32](isotropy-cap.md)'s missing hypothesis never reaches here**: $\mathfrak c=0$ would force $m\le3$, where $\mathrm{Weyl}_m=0$, so L33 is unconditional. *Three true clauses were dropped in the move, notably that the result covers odd $m$ and degenerate minority eigenvectors.*

**The identity the proof runs on.** Pairing the first Bianchi identity against $u\otimes u$ for arbitrary skew
$u$, the term $\operatorname{tr}(u^2v_\alpha^2)$ that appears is annihilated by Ricci-flatness, leaving an
operator identity on $\mathfrak{so}(m)$:

$$\sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2=2W,\qquad\text{i.e.}\qquad
\sum_\alpha\lambda_\alpha N_{v_\alpha}=0,\quad N_v:=2\,v\otimes v-\mathrm{ad}(v)^2 .$$

**This is classical and is cited, not claimed.** It is the Weitzenböck curvature term on 2-forms,
$q(R)\omega=\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric}-2\mathring R\omega$, from the Lichnerowicz
Laplacian ([Besse, *Einstein Manifolds*, §1.143](https://link.springer.com/book/10.1007/978-3-540-74311-8)),
specialised to Ricci-flat curvature; [Petersen–Wink Proposition 1.6](https://arxiv.org/abs/1908.09958) gives
the eigenbasis rewriting and not the evaluation. **First Bianchi is the load-bearing hypothesis**, it alone
gives $\mathcal A(R)=2R-(\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric})$, while Ricci-flatness only
deletes the correction, and fails on its own because $\Lambda^4$ is itself Ricci-flat and carries eigenvalue
$-4$ rather than $+2$.

**What is new is the splitting.** $\mathrm{ad}(v)$ is skew-adjoint on $\mathfrak{so}(m)$, so
$\langle u,N_vu\rangle=2\langle v,u\rangle^2+\|[v,u]\|^2$ and each $N_v$ is positive semidefinite with
$\ker N_v=v^\perp\cap\mathfrak z(v)$. The identity is therefore a balance of positive semidefinite operators
between the two halves of the spectrum.

**Proof.** Rescale so the identity reads $N_x=\sum_iN_{y_i}$, $x$ the minority-side eigenvector. All terms
being positive semidefinite, $\ker N_x\subseteq\bigcap_i\ker N_{y_i}$: the space
$\mathfrak c=\mathfrak z(x)\cap x^\perp$ commutes with every $y_i$ and is orthogonal to each. So every
$y_i\in\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$ by [Lemma L32](isotropy-cap.md), **whose hypothesis $\mathfrak c\ne0$ holds here**, while $y_i\perp x$; hence every
$y_i=0$, $W=\pm x\otimes x$, and Ricci-flatness forces $x=0$. $\square$

```
