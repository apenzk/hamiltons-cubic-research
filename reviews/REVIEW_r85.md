# Reviewer 85, Gate 2 on the $\mathbb{HP}^m$ closed form

**No numerical checking was used.** Exact symbolic algebra in $m$, or hand derivation from Killing forms. No operators built, nothing sampled, no integer evaluation as evidence.

**Headline: the closed form is correct, every step survives, and steps 3 and 4, the hard ones, are unnecessary.**

| Step | Verdict |
|---|---|
| 1. Petersen–Stanfield input | **CONFIRMED**, and re-derived without the paper |
| 2. Weyl projection, $\mathrm{scal}=2\mathop{\mathrm{tr}}R$ | **CONFIRMED** |
| 3. Multinomial and vanishing $S$-blocks | **CONFIRMED** |
| 4. Block masses and $S_{333}$ | **CONFIRMED**; the brief's suspected premise does not exist |
| The closed form | **CONFIRMED**, reproduced from an independent chain, difference $0$ |

## Steps 1–4

The eigenvalues were re-derived from the symmetric pair alone: $R=\iota\circ\iota^*$, so on each simple ideal it is the scalar $t_i=\langle\cdot,\cdot\rangle_{\mathfrak{so}(4m)}/B|_{\mathfrak k_i}$. With $\mathfrak g=\mathfrak{sp}(m{+}1)$: $\mathfrak{sp}(1)$ acts by **right** quaternion multiplication ($t_1=m/(2(m+2))$), $\mathfrak{sp}(m)$ by **left** ($t_2=1/(2(m+2))$), and $t_3=0$ by Ambrose–Singer. **Absolute normalisation included, not just the ratio.** Cross-check: $\mathop{\mathrm{tr}}R=m$, $\mathrm{scal}=2m$, $\mathrm{Ric}=\tfrac12g$, the universal Einstein constant of the Killing metric.

Block masses verified **without index bookkeeping**, as $c_{\mathfrak k}=(-\mathrm{Killing}_{\mathfrak k})/\langle\cdot,\cdot\rangle_{\rm ambient}$: $c_{\mathfrak{sp}(1)}=8/(2m)=4/m$, $c_{\mathfrak{sp}(m)}=4(m+1)/2=2(m+1)$. At $m=1$ both describe $\mathfrak{sp}(1)$ on $\mathbb R^4$ and both return $4$.

**$S_{333}$ does not rest on $[\mathfrak{sp}(1),\mathfrak m]\subseteq\mathfrak m$.** Summing the marginal identity over $a\in$ block 3 uses only total symmetry of $T$ and the five zeros of step 3. (The premise is true anyway, since $\mathfrak m=\mathfrak h^\perp$ for the $\mathrm{ad}$-invariant form, but it is not load-bearing.)

## The theorem, and it makes steps 3 and 4 redundant

The rebuild returned $\mathrm{num}=\tfrac12\mathrm{den}$ **identically**. That is not a coincidence.

> **Theorem.** Let $R$ be the curvature operator of a locally symmetric Einstein space, $\mathrm{Ric}=\lambda g$, and $W=R-cI$ with $c=\lambda/(n-1)$. Then $\mathbf{Q(W)=\lambda W}$, so $W$ is critical, and $\theta(W/\lVert W\rVert)=\lambda/\lVert W\rVert$.

Four lines: (i) $Q(R)=\lambda R$ for locally symmetric Einstein, since $\nabla R=0\Rightarrow\Delta R=0$ and the metric shrinks homothetically under Ricci flow, verified blockwise for $\mathbb{HP}^m$, which *re-derives* $c_{\mathfrak{sp}(1)}=4/m$ and $c_{\mathfrak{sp}(m)}=2(m+1)$ **with no Dynkin index anywhere**; (ii) $Q(I)=(n-1)I$ since $I^\#=(n-2)I$; (iii) $B(X,Y,Z)=\langle X\circ Y,Z\rangle$ totally symmetric collapses both $P(W)$ and $\lambda\lVert W\rVert^2$ to the same expression; (iv) the classical $R\#I=2\lambda I-2R$ gives $R\circ I=\lambda I$, hence $Q(W)=\lambda W$.

**Consequence.** $\lambda=\tfrac12$ for *every* compact irreducible symmetric space in Petersen–Stanfield's normalisation, so

$$\theta=\frac1{2\lVert W\rVert},\qquad \lVert W\rVert^2=\sum_id_i(\lambda_i-c)^2+\Big(N-\sum d_i\Big)c^2 .$$

$\theta$ is a **quadratic** functional of their published tables. No structure constants, no $S$-blocks, no $S_{333}$, no Casimir dictionary, no dual Coxeter numbers.

| space | theorem | record |
|---|---|---|
| $\mathbb{HP}^m$ | $\frac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}$ | identical |
| $\mathbb{CP}^m$ | $\frac{(m+1)(2m-1)}{3m(m-1)}$ | identical |
| $\mathrm{Gr}_{\mathbb C}(2,2)$ | $14/27\to0.720082300$ | $0.720082300$ |
| $\mathrm{Gr}_{\mathbb C}(2,3)$ | $275/774\to0.596068081$ | $0.596068081$ |
| $\mathrm{Gr}_{\mathbb C}(p,q)$ | $\frac{(p+q)^2(2pq-1)}{pq(4p^2q^2-p^2-q^2-2)}$ | **new** |

## The reformulation worth taking

With $\lambda=\tfrac12$, **Conjecture A restricted to compact symmetric spaces is exactly**

$$\lVert W\rVert^2\ \ge\ \tfrac16\quad\text{for every compact irreducible symmetric space with its Killing metric,}$$

with equality **exactly at $\mathbb{CP}^2$**, since $\lVert W\rVert^2_{\mathbb{CP}^m}=\frac{3m(m-1)}{4(m+1)(2m-1)}$ is $\tfrac16$ at $m=2$. **A finite check over Cartan's list against a quadratic quantity**, strictly easier than the cubic sharp-term route, and where the next cycle should go.

## The third family is a different object

The $(\mathfrak{su}(m),\mathfrak{so}(m))$ points have $W$ supported on $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$ and zero outside, so $R=W+cI$ would be $c\ne0$ on $\mathfrak{hol}^\perp$, **impossible for a symmetric space**. They are Ricci-flat Kähler *algebraic* curvature operators, not Weyl parts of symmetric metrics. What covers all three is weaker and half-recorded already (Reviewer 15): each $W$ is the **unique** unit $\mathfrak h$-invariant Weyl tensor for its $\mathfrak h\subseteq\mathfrak{so}(n)$, so criticality is forced by equivariance rather than solved for.

## WRONG vs OVERSTATED

**WRONG:** nothing in the claim. The "cubic has no real root" line was false (discriminant $-157464<0$, one negative real root) and is already corrected in the working tree; my computation agrees with the correction.

**OVERSTATED:** (1) "literature first supplied the input", it supplied a convenience; the eigenvalues are a two-line ratio of Killing forms. (2) **The index rule is stated inconsistently**: $c=2h^\vee/I$ in the script against $c=4h^\vee/I_\rho$ in [plan.md](../plan.md), with unstated and differing conventions, right numbers, unusable rule, and it is the very error the plan warns about. (3) "$S_{333}$ vanishes at $m=2$ and only there", the factorisation carries $(m-1)$ and $(m+1)$ too, so it holds only on the intended range $m\ge2$. (4) Framing steps 3 and 4 as the substance: they are the error-prone part *and* redundant, so the two-attempt $S_{333}$ episode was risk the derivation never needed to run.
