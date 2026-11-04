# Notes, Richard, Seshadri, *Noncoercive Ricci flow invariant curvature cones*

Transcribed from [richard-seshadri-1308.1190.txt](https://arxiv.org/abs/1308.1190) (`pdftotext -layout`); line references are to that dump. Their $Q$ is Böhm–Wilking's $R^2+R^\#$ (L526–L528 note it differs from Brendle's by a factor 2), the record's convention.

## Lemma 3.1, quoted from Böhm–Wilking (L383–L392, verbatim)

> This lemma is due to Böhm and Wilking ([BW08]). **Lemma 3.1.** • $Q(I)=(n-1)I$. • If $W\in\mathcal W$, $B(W,I)=0$. • If $W\in\mathcal W$ and $R_0\in S^2_0\mathbb R^n\wedge\mathrm{id}$, then $B(R_0,W)\in S^2_0\mathbb R^n\wedge\mathrm{id}$. • If $R_0\in S^2_0\mathbb R^n\wedge\mathrm{id}$, then $B(R_0,I)\in S^2_0\mathbb R^n\wedge\mathrm{id}$.

Here $B$ is the symmetric bilinear form with $B(R,R)=Q(R)$. The second bullet is the polarised form of the record's relation (B), $W^\#I=-W$ read against $W^2$; the record cites it from [boehm-wilking-2008-space-forms](../boehm-wilking-2008-space-forms/notes.md) directly.

## Lemma 4.1, $Q(R)=\lambda R$ at symmetric Einstein spaces (L510–L532, verbatim)

> **Lemma 4.1.** Let $(M^n,g_0)$ be a non negatively curved Einstein symmetric space, then its curvature operator $R$ satisfies $Q(R)=\lambda R$ (3) where $\lambda>0$ is such that $\mathop{\mathrm{Ric}}_{g_0}=\lambda g_0$.

> *Proof.* Since $(M^n,g_0)$ is Einstein, we can use Proposition 3 of [Bre10a] to get that (note that our definition of $Q$ differs from the one used by Brendle by a factor of 2): $\Delta_{g_0}R_{g_0}+2Q(R_{g_0})=\lambda R$. Then, since $g_0$ is symmetric, $R_{g_0}$ is parallel and $\Delta_{g_0}R_{g_0}=0$. This proves that $Q(R_{g_0})=\lambda R_{g_0}$.

Remark 4.2 (L513–L520) notes the equation is $O(n)$-invariant and so is a statement about an algebraic curvature operator. **The printed identity carries a factor error**: with $\Delta R=0$, $\Delta R+2Q(R)=\lambda R$ gives $Q(R)=\tfrac12\lambda R$, false at the unit sphere; the right side must be $2\lambda R$ for the stated conclusion. **The identity at every locally symmetric Einstein metric, either sign, is reached through Hamilton's equation (L258–L264, no compactness) along the explicit homothety $(1-2\lambda t)g$**, which is how the record proves [Lemma L46](../../findings/problem.md); [Bre10a] is not filed.

## Proposition 4.3, the Weyl part is an eigenvector too, and the explicit ODE solution (L534–L556, verbatim)

> **Proposition 4.3.** If $C$ is a Ricci flow invariant cone which contains the curvature operator $R$ of an Einstein symmetric space in its interior, then the Weyl part $R_W$ of $R$ is in $C$.

> *Proof.* By the previous lemma, $Q(R)=\lambda R$. Rescaling $R$, we can assume that $Q(R)=R$. We decompose $R$ along the decomposition (2): $R=R_I+R_W$. Since $B(R_I,R_W)=0$, we have that $R_I+R_W=R=Q(R)=Q(R_I)+Q(R_W)$, which implies that $Q(R_I)=R_I$ and $Q(R_W)=R_W$. Since $R$ is in the interior of $C$, $\bar R=R-\varepsilon I$ is also in $C$ for some $\varepsilon>0$ small enough. Then we have that $Q(\bar R_I)=(1-\varepsilon)\bar R_I$ and $Q(\bar R_W)=\bar R_W$. This allows us to explicitly write the solution to Hamilton's ODE $\frac{d}{dt}\bar R(t)=Q(\bar R(t))$ with initial condition $\bar R(0)=\bar R$, which is defined for $t<1$: $\bar R(t)=\frac{1}{1-(1-\varepsilon)t}\bar R_I+\frac{1}{1-t}\bar R_W$. Since $C$ is Ricci flow invariant, $\bar R(t)$ is in $C$ for all $t\in[0,1)$, and since $C$ is a cone: $(1-t)\bar R(t)=\frac{1-t}{1-(1-\varepsilon)t}\bar R_I+\bar R_W\in C$. Letting $t$ go to 1 and using that $C$ is closed, we have that $\bar R_W=R_W\in C$.

**In the record's notation.** $R=cI+W$ with $c=\lambda/(n-1)$ and $Q(W)=\lambda W$: this is Lemma 46 line for line, with the same input ($B(I,W)=0$, $Q(I)=(n-1)I$) and the same conclusion. What the record can add as a citation is the *consequence*: along Hamilton's ODE from a critical $W$ with $\theta>0$ the solution is $W(t)=W/(1-\theta t)$, a ray, so the Weyl direction of a critical point is a fixed direction of the flow. That is the content of DGK's "obstruction to an evolution towards constant positive sectional curvature" (DGK p. 2), which DGK state without proof and which this Proposition proves.

## Theorem 0.1 and Corollary 0.3 (L78–L83, L107–L110, verbatim)

> **Theorem 0.1.** Let $C\subset S^2_B(\Lambda^2\mathbb R^n)$, $n\ge4$, be a closed, convex, $O(n)$-invariant, Ricci flow invariant curvature cone which contains the identity operator in its interior. If $C\setminus\{0\}$ contains a Ricci flat metric then $C$ is either the whole space $S^2_B(\Lambda^2\mathbb R^n)$ or the cone $C_{\mathrm{Scal}}$.

> **Corollary 0.3.** Let $C\subset S^2_B(\Lambda^2\mathbb R^n)$, $n\ge4$, be a Ricci flow invariant curvature cone which contains the curvature operator of a nontrivial Einstein symmetric space of non-negative scalar curvature, then $C$ is either the whole space $S^2_B(\Lambda^2\mathbb R^n)$ or the cone $C_{\mathrm{Scal}}$.

The Corollary's statement omits "in its interior"; its proof (L560–L563) invokes Proposition 4.3, which needs $R$ interior, so the Corollary is to be read with that hypothesis, and that is how the README states it. Proof route: Proposition 4.3 puts $R_W\ne0$ in $C$, Proposition A.5 (an $O(n)$-invariant convex cone containing a nonzero vector of an irreducible summand contains the summand) puts all of $\mathcal W_n$ in $C$, and Theorem 0.1 finishes. Remark 0.4: in even dimension $C_{\mathrm{Scal}}$ is the only invariant cone containing every nonnegatively-sectionally-curved operator, because $R_{\mathbb{CP}^{n/2}}$ has positive sectional curvature and would be interior.

**For the record.** The conjecture $P(W)\le P(W_{S^{n/2}\times S^{n/2}})$ on the unit sphere is, by [problem.md](../../findings/problem.md)'s cone reading, a statement about the invariant cone $\{s\ge\kappa\lVert W\rVert\}$ family; this Corollary says any such cone finer than $C_{\mathrm{Scal}}$ has every symmetric-space Weyl tensor on its boundary or outside. That is consistent with the record (the balanced product is the extremal boundary point) and is a citable constraint, used already in spirit in [REVIEW_r285](../../reviews/REVIEW_r285.md).

## Theorems 0.5 and 0.6 (L125–L145)

At $n=4$, from any invariant cone $\tilde C$ containing all nonnegative operators, $C=\{R:\tfrac{s}{12}I+W\in\tilde C\}$ is invariant and contains all conformally flat scalar-flat operators; some of these are Wilking cones and some are new (Remark 5.2, from the 2-nonnegative cone). For $n\ge5$, an invariant cone containing a nonzero conformally flat scalar-flat operator and all nonnegative operators is $C_{\mathrm{Scal}}$. These concern the Ricci sector and do not touch $\mathcal W_n$'s critical points.

## What the paper does NOT do

- No classification of solutions of $Q(R)=\lambda R$; the symmetric spaces are the input, never the output.
- No bound on $\lambda/\lVert R_W\rVert$, so nothing on $\theta_0(n)$ or on which symmetric space has the largest $\theta$.
- No mention of the diagonal locus, of Jäger, or of strongly regular graphs; DGK do not cite it and it does not anticipate them.
- Citation count 2 on OpenAlex (2026-09-02), both in the Ricci-flow-cone literature the record already holds ([richard-2014-curvature-cones-ricci-flow](../richard-2014-curvature-cones-ricci-flow/), [wilking-lie-algebraic-cones](../wilking-lie-algebraic-cones/)).
