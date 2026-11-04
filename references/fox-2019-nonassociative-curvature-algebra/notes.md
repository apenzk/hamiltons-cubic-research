# Fox, *The commutative nonassociative algebra of metric curvature tensors*, extraction

Transcribed from [fox-1901.04012.txt](https://arxiv.org/abs/1901.04012) (`pdftotext -layout`); page/line references are to that dump.

## Why it matters here

The algebra $(\mathrm{MC}_W(V^*),*)$ of Weyl curvature tensors is exactly this project's setting: $P(W)=\langle W,Q(W)\rangle$ is its cubic form, **critical points of $P$ on the unit sphere are its idempotents**, and $F_u$ (the linearisation of $Q$ at $u$), **is the multiplication operator $L_*(u)$ of the idempotent $u$**. So the "multiplication table" this project measures between $F_u$-eigenspaces is the Peirce-type decomposition of that algebra, and Fox's structural theorems apply to it directly.

## Theorem 3.1 (L425), simplicity

> "Let $(A,\circ,h)$ be a nontrivial finite-dimensional commutative algebra. If a connected [Lie group acts irreducibly by automorphisms, the algebra is simple.]"

Applied at L174: since $SO(n)$ acts irreducibly on $\mathrm{MC}_W(V^*)$, the algebra $(\mathrm{MC}_W(V^*),*)$ is **simple**.

## Theorem 3.2 (L440), the two identities this project had not used

> "A nontrivial finite-dimensional Euclidean metrized commutative algebra $(A,\circ,h)$ on which a real Lie group $G$ acts irreducibly by isometric automorphisms is exact and Killing metrized with Killing form $\tau_\circ(x,y)=\mathop{\mathrm{tr}}L_\circ(x)L_\circ(y)$ equal to a nonzero multiple of the metric $h$."

Two consequences, both hypotheses satisfied here ($SO(n)$ acts irreducibly by isometric automorphisms):

1. **$\mathop{\mathrm{tr}}L_\circ(x)=0$ for every $x$**, the proof observes $x\mapsto\mathop{\mathrm{tr}}L_\circ(x)$ is $G$-invariant, so its kernel is all of $A$ by irreducibility. Cited at L168.
2. **$\mathop{\mathrm{tr}}\big(L_\circ(x)L_\circ(y)\big)=\kappa\,h(x,y)$** with $\kappa\ne0$, by Schur, since the endomorphism representing $\tau_\circ$ against $h$ is $G$-invariant and self-adjoint.

**Careful with normalisations.** Idempotents here are not unit vectors ($|e|=1/\theta$) so the textbook form "$\kappa=1+\sum\lambda_i^2$" does not apply as written. And Fox's metric is complete contraction, exactly $4\times$ the Frobenius metric used in this project, so $\kappa_{\text{Fox}}=\tfrac14\kappa_{\text{Frob}}$.

**The group is $O(n)$, not $SO(n)$.** At $n=4$ the space of $SO(4)$-invariant symmetric forms on $\mathrm{MC}_W$ is two-dimensional, against one at $n=5,6$, which is why Fox states the hypothesis with $O(n)$. **Theorem 1.3** states both conclusions for this algebra directly and is the right citation.

**Remark 1.4 leaves $\kappa$ uncomputed for $\dim V>4$**, and **Theorem 1.5(2)** supplies the single value $\kappa=21/16$ at $\dim V=4$, the anchor against which any general formula should be checked.

## Idempotents (§10, L167)

> "By Lemma 10.1 there is a nontrivial idempotent $E\in(\mathrm{MC}_W(V^*),*)$."

L250 records that the number of orbits of idempotents is the smallest possible, two, and L257 that eigenvalue $1/2$ of the multiplication endomorphism of a rank-one idempotent "is always at [tained]", the $1/2$ eigenvalue is generic to the setting rather than special to $W_{\mathbb{CP}^2}$, which matches the $\tfrac12\theta^*$-eigenspace being the orbit tangent.

## $\mathcal S^4(\alpha)$ and the hyper-Kähler families

The competitor $\mathcal S^4(\alpha)$ is constructed from the index formulas of §6, and Lemma 10.7(4b) gives the $r\ge8$ hyper-Kähler subalgebra $\mathbb B_r$, genuinely six-dimensional unlike the $r=4$ case. Both families were eliminated in this project; see [findings/INDEX.md](../../findings/INDEX.md).

## What it does not contain

No maximization statement: Fox treats $\langle W,Q(W)\rangle$ in generality and does not address which idempotent maximises it, which is this project's question.

## Lemma 5.7, page 14, which is the source for $Q(\mathcal W_n)\subseteq\mathcal W_n$

**Transcribed 2026-09-10 to close a debt the record had carried in two places.** *[ungraded-slack.md](../../findings/ungraded-slack.md) called it "asserted as a remark on Fox and derived nowhere here", and [README.md](../../README.md) asserts the $\mathrm{Alt}$ and $\mathrm{Ric}$ components with no proof.*

> **Lemma 5.7.** Let $(V,h)$ be a metric vector space. For $X,Y\in\mathrm{MC}(V^*)$,
> $$\rho(X*Y)=\tfrac12\big(X\mathbin{\hat\cdot}_{S^2V^*}(\rho(Y))+Y\mathbin{\hat\cdot}_{S^2V^*}(\rho(X))\big),\qquad s(X*Y)=\langle\rho(X),\rho(Y)\rangle.$$
> In particular, the subspace $\mathrm{MC}_W(V^*)=\ker\rho\subset\mathrm{MC}(V^*)$ is a **subalgebra** of $(\mathrm{MC}(V^*),*)$.
>
> *Proof.* The identities are immediate from (5.4) and Theorem 5.4. $\square$

**All three components the record needs are covered, and by different parts of the statement.** *First Bianchi comes for free: $*$ is defined ON $\mathrm{MC}(V^*)$, the algebraic curvature tensors, so $X*Y$ satisfies it whenever $X$ and $Y$ do.* **Ricci-flatness comes from the first identity**, since $\rho(X)=0$ makes both terms vanish, and **the scalar component from the second**, $s(X*X)=\lvert\rho(X)\rvert^2=0$. *So $Q(\mathcal W_n)\subseteq\mathcal W_n$ is Lemma 5.7 at $X=Y$, under the record's own correspondence $P(W)=\langle W,Q(W)\rangle$ with Fox's cubic form.*

**Lemma 5.8(1), same page, is the converse half and is worth having beside it**: for all $X\in\mathrm{MC}(V^*)$, $s(X*X)\ge0$ with equality **if and only if** $X\in\mathrm{MC}_W(V^*)$, credited there to reference [32]. *So the scalar component of $Q(X)$ vanishes exactly on the Weyl tensors, which makes the containment sharp rather than incidental.*
