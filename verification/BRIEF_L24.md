# Brief for round L24

**Verbatim extracts. Nothing here is paraphrased.**

## A. The canonical statement, from results.md

```markdown
##### Lemma L24, second-order optimality, as an eigenvalue bound on the multiplication operator

Let $W$ be a critical point with $\theta=P(W)>0$, put $e=W/\theta$, and let $L_e=e\circ(\cdot)$ where $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$. The Hessian of $P$ restricted to the unit sphere of $\mathrm{Weyl}_n$ is $6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$. Hence if $W$ is a maximizer,

$$\lambda_{\max}\big(L_e|_{W^\perp}\big)\ \le\ \tfrac12 .$$

**Proof:** [second-order.md](findings/second-order.md)

```

## B. The proof block, from findings/second-order.md lines 50-73

```markdown
#### Lemma L24, second-order optimality as an eigenvalue bound, the canonical statement

*Moved here from [results.md](../results.md) on 2026-08-31. The criterion is stated earlier in this file; what follows is the full statement, argument, scope and attribution, which existed only in that file.*

Needed because every inequality in this programme constrains the unknown maximizer only to first order (through $Q(W)=\theta W$) while a maximizer satisfies more than criticality.

**Statement.** Let $W$ be a critical point with $\theta=P(W)>0$, put $e=W/\theta$, and let $L_e=e\circ(\cdot)$ where $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$. The Hessian of $P$ restricted to the unit sphere of $\mathrm{Weyl}_n$ is $6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$. Hence if $W$ is a maximizer,

$$\lambda_{\max}\big(L_e|_{W^\perp}\big)\ \le\ \tfrac12 .$$

**And $1$ is a simple eigenvalue of $L_e$**, the bound gives it at once, since every eigenvalue off $W$ is at most $\tfrac12$ while $L_ee=e$. This is the half [trap 48](INDEX-traps.md) asks for and [r306](../reviews/REVIEW_r306.md) K1 uses: it says a maximiser admits no $\circ$-orthogonal splitting **into critical pieces**, because such a splitting would put a second idempotent direction in the $1$-eigenspace. **Criticality of the pieces is the hypothesis and it cannot be dropped**: with $W=\sum_ia_iA_i$ and $e=W/\theta$, the $\circ$-orthogonality gives $e\circ A_j=\frac{a_j}\theta Q(A_j)$, which equals $A_j$ only when $Q(A_j)\propto A_j$. **So this route is strictly weaker than [Lemma L66](support-dichotomy.md)**, which needs no criticality, rather than a second proof of it.

**Argument.** $P$ is a cubic form, so $\nabla P=3Q(W)$ and the second differential is $6\,\theta\,L_e$; the constraint $\|W\|^2=1$ contributes $-3\theta\,\mathrm{Id}$ through its multiplier, leaving $6\theta(L_e-\tfrac12\mathrm{Id})$ on the tangent space. Two steps the first version left implicit. **$L_e$ is self-adjoint**, so $\lambda_{\max}$ is defined at all: $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric, the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$ and the $\#$ part because permuting the arguments permutes the slots of both totally antisymmetric $c$'s, sign $(-1)^2$ ([r285](../reviews/REVIEW_r285.md) Claim 1). **And $W^\perp$ is $L_e$-invariant**, since $L_ee=e$ by criticality and self-adjointness then carries the complement, so the restriction is a genuine operator rather than a compression, which is [Lemma L125](#lemma-l125-l24-off-wperp-the-same-statement-in-the-form-the-four-set-application-needs) one heading below.

**Sharpness rests on the orbit directions alone.** $e$ is idempotent ($e\circ e=Q(e)=Q(W)/\theta^2=e$) and the orbit directions are exact $\tfrac12$-eigenvectors by equivariance, attained at every nonzero critical point because $\mathcal W_n$ carries no $O(n)$-invariant vector, so the orbit is never a point and [Lemma L32](isotropy-cap.md)'s stabilizers shrink that multiplicity without reaching zero. $\square$

> **The first version argued sharpness from "$\langle e,L_ee\rangle=1$", and that is false**: $L_ee=e$ gives $\langle e,L_ee\rangle=\lVert e\rVert^2=\theta^{-2}$, which is $0.6545$ at $n=12$. Repaired to $L_ee=e$ the statement is about the direction $W$ itself and says nothing about $W^\perp$, which is the emptiness [Lemma L125](#lemma-l125-l24-off-wperp-the-same-statement-in-the-form-the-four-set-application-needs) warns of. *Gate 2, [r488](../reviews/REVIEW_r488.md) and [r490](../reviews/REVIEW_r490.md) on identical briefs, agreeing.*

**Scope.** $\theta>0$ enters at exactly one place (dividing by $6\theta$ to turn $\mathrm{Hess}\le0$ into the eigenvalue bound) and at a maximiser it is **automatic**, since $P$ is odd and $\max_SP\ge\sqrt{3/2}$ at every $n\ge4$. **A *local* maximiser with $\theta<0$ does not exist, so that branch is empty.** Along the chordal curve through an orbit direction the second- and third-order coefficients vanish unconditionally by [Lemma L51](../findings/second-order.md#lemma-l51-the-variation-calculus-is-an-identity-along-a-critical-orbit-the-canonical-statement), leaving $-\tfrac38\theta\lVert z\rVert^4$ as the leading term; a local maximum needs it $\le0$, hence $\theta\ge0$. **The orbit tangent is never zero**, since $\mathcal W_n$ carries no $O(n)$-invariant vector. *The statement that stood here, that such a maximiser satisfies $\lambda_{\min}(L_e\vert_{W^\perp})\ge\tfrac12$, being this theory read at the local minimiser $-W$, is true and vacuous, and is kept only as the reading at $-W$.*

> **The first version claimed the inequality reverses at $\mathfrak u(2)\subset\mathfrak{so}(4)$ with $\theta=-0.866$, and that is refuted three ways.** $Q$ is even and $P$ odd, so $e(-W)=e(W)$ and $(-W)^\perp=W^\perp$: $\lambda_{\max}(L_e\vert_{W^\perp})$ is *the same number* at $\pm\theta$, and **no witness of any kind can separate the sign**. The label was also wrong, $\mathfrak u(2)$ is $W_{\mathbb{CP}^2}$'s isotropy at $\theta=\pm\sqrt{3/2}=\pm1.2247$, while $0.866$ belongs to $S^2\times S^2$, as [bounds.md](bounds.md)'s own $n=4$ classification records. And the point is a **saddle**: $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ is a $\circ$-orthogonal sum, so $\lambda_{\max}(L_e\vert_{W^\perp})=1$ there. *Gate 2, [r488](../reviews/REVIEW_r488.md) and [r490](../reviews/REVIEW_r490.md), independently.* **The claim originates in [Reviewer 27](../reviews/REVIEW_r27.md)** and stood on that audit alone.

**Prior art, this is not new.** The statement is Proposition 6.6 of [Krasnov–Tkachev, *Variety of idempotents in nonassociative algebras*](https://arxiv.org/abs/1801.00617): in any Euclidean metrised algebra, an extremal idempotent satisfies $\sigma(L_c|_{c^\perp})\subseteq(-\infty,\tfrac12]$ with $1$ simple, proven by the same argument, $D^2f(c)\le0$ for $f(x)=\langle x^2,x\rangle/|x|^3$ gives $2L_c-\mathrm{Id}\le P_c$, the projector onto $\mathbb Rc$ (**the paper prints $c\otimes c$, dropping $\lVert c\rVert^{-2}$; see [the notes](../references/krasnov-tkachev-2018-idempotent-variety/notes.md)**), which vanishes on $c^\perp$. It appears again as Proposition 2.5 of [Tkachev's survey](https://arxiv.org/abs/1901.02765). It was derived here independently and before the literature was found, so the derivation is retained above as confirmation; the credit belongs to those authors. Their framework also identifies the whole setting: $\mathcal W_n$ with the cubic $P$ is an algebra $V(u)$ in their sense, its critical points are that algebra's idempotents, and maximizing $P$ is minimizing $\|c\|$ over them.

```

## C. The landscape statement of the same result, from results.md line 242

```markdown
- **Lemma L24 (second-order). Second-order optimality bounds the multiplication operator.** A maximizer has $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, with $\tfrac12$ attained by orbit directions at every critical point. This is Krasnov–Tkachev's Proposition 6.6, derived here independently before the literature was found; the credit is theirs.
```

## D. Lemma L125, one heading below, which the argument cites

```markdown
#### Lemma L125, L24 off $W^\perp$: the same statement, in the form the four-set application needs

*[r367](../reviews/REVIEW_r367.md) and [r368](../reviews/REVIEW_r368.md), identical briefs, agreeing. **This is not a strengthening of [Lemma L24](#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement) and the first version's claim that it was is withdrawn.***

**At a maximiser $W$ of unit norm with $\theta>0$, for every $Y\in\mathcal W_n$,**
$$\langle Y,L_eY\rangle\ \le\ \tfrac12\lVert Y\rVert^2+\tfrac12\langle W,Y\rangle^2 .$$

**Proof, and why it is [Lemma L24](#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement).** $L_e$ is self-adjoint with $L_eW=W$, so $W^\perp$ is invariant. Split $Y=aW+Z$ with $Z\perp W$: the cross term $2a\langle Z,L_eW\rangle=2a\langle Z,W\rangle$ vanishes, both sides become $a^2+{}$their $Z$-parts, and the statement collapses to $\langle Z,L_eZ\rangle\le\tfrac12\lVert Z\rVert^2$, **L24, in both directions.** $\square$

> **THE EQUALITY AT $Y=W$ CERTIFIES NOTHING.** It is the radial direction of a degree-zero homogeneous function, identically zero at *any* point, using neither maximality nor criticality. *[DERIVE-mx1.md](../reviews/DERIVE-mx1.md)'s "sharp at $X=W$" inherits the same emptiness.*

**What the form is for.** Applied to [Lemma L121](../findings/second-order.md#lemma-l121-the-4-set-block-its-spectrum-and-one-necessary-condition-per-4-subset)'s four-set block it gives $\sqrt\Sigma\le\theta(1+c^2)$ for the unit maximising direction $\hat X$ of the block's Rayleigh quotient, $c=\langle W,\hat X\rangle$, hence
$$\Sigma\le\theta^2(1+c^2)^2,$$
**which is exactly [DERIVE-mx1.md](../reviews/DERIVE-mx1.md)'s projection-corrected bound.** *Corroboration by a second route; the content is L24's and the arrangement is what the four-set application needs.* **And $c$ here is DERIVE-mx1's own $\rho$**, confirmed at Gate 2, not [Lemma L124](../findings/second-order.md#lemma-l124-on-the-half-flat-four-set-family-theta9det-v_-and-theta2letfrac32rho2-with-equality-exactly-at-pm-w_mathbbcp2)'s $\rho$, which is a different quantity.

#### The maximiser's multiplication spectrum: what the moments give, and why they cannot close it

```
