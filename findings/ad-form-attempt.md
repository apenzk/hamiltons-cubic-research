# The Cauchy–Schwarz route on $\langle M^\#,M\rangle$, closed, with what it left behind

Route R2 localises $\theta$ in one term: $\theta=\operatorname{tr}(M^3)+\langle M^\#,M\rangle$, with $\langle M^\#,M\rangle=\tfrac12(p_3(\mu)-p_3(\omega))$ from the bi-spectral identity. This file records an attempt to bound that term by Cauchy–Schwarz, **which is closed**, and the results that survive it.

## The closed forms at the balanced sphere product

In $m=n/2$, for the unit-norm Weyl operator, derived and reproduced independently:

$$\operatorname{tr}(M^3)=\frac{1}{m\sqrt{(m-1)(2m-1)}},\qquad
\langle M^\#,M\rangle=\frac{2m-3}{\sqrt{(m-1)(2m-1)}},\qquad
\lVert M^\#\rVert_F=\frac{\sqrt{E}}{\sqrt{m(m-1)}\,(2m-1)}$$

with $E=(2m-1)\big[m(2m-3)^2+m-1\big]$, and $\theta=\theta_0(n)$ **identically in $m$**. *The form above reproduces the measured value to six digits at $n=6,8,12,16$; a $\sqrt m$ under the root would be too large by exactly that factor at every $n$.*

**And $\operatorname{tr}(M^\#)=-1$ for a unit Weyl operator**, verified to $10^{-12}$ at $n=6,8,12$. *(It fails on Bianchi tensors that are not Ricci-flat, which is what distinguishes a Weyl tensor from an algebraic curvature tensor here.)*

## Why the route is closed

**The proposed target was the conjecture verbatim.** $\cos\varphi$ is *defined* as $\langle M^\#,M\rangle/\lVert M^\#\rVert_F$, so "prove $\operatorname{tr}(M^3)+\lVert M^\#\rVert_F\cos\varphi\le\theta_0$" is $\theta\le\theta_0$ with two symbols substituted, [fence post F28](INDEX.md)'s mechanism in a different file. Zero reduction.

**The strengthened form is false, by a theorem rather than a table.** $\operatorname{tr}(M^3)+\lVert M^\#\rVert_F\le\theta_0(n)$ fails at the balanced sphere product at **every even $n\ge4$**, with exact excess $\dfrac{m}{(2m-1)\big(u+\sqrt{u^2+m^2-m}\big)}>0$, $u=m(2m-3)$, asymptotically $\dfrac{1}{8m^2}=\dfrac{1}{2n^2}$.

**And the Cauchy–Schwarz loss is largest AWAY from the tight point**, which is the opposite of what a workable route needs. Riemannian ascent on the unit sphere of $\mathrm{Weyl}_n$ gives $(\operatorname{tr}(M^3)+\lVert M^\#\rVert_F)/\theta_0=1.3403,\,1.2399,\,1.1881,\,\mathbf{1.1564},\,1.1350,\,1.1196$ at $n=6\dots16$. At $n=12$ the maximiser sits at $\theta/\theta_0=0.976$ with $\cos\varphi=0.762$, not extremal at all.

**The spectral split does not rescue it.** $W^\#=W_+^\#+W_-^\#-2\,W_+\#W_-$ is correct algebra, but at $S^m\times S^m$ the two halves have **disjoint support**, so $\lVert W^\#\rVert_F^2$ is Pythagorean and any triangle recombination loses a factor $\to\sqrt2$. Even with exact norms the split returns $1.393\,\theta_0$ at $n=12$; with [Theorem 1 and L2](../scripts/runs/run_frontier_bound_proof.py) as stated it reaches $8.0\,\theta_0$, against a $3.25\times$ baseline.

## What the attempt leaves usable

- **The closed forms above**, which no prior cycle had.
- **The rate**: the excess is $\tfrac1{2n^2}$, so any successor must be sharp to $O(n^{-2})$ *uniformly*, not at one dimension.
- **The convention.** In [run_frontier_bound_proof.py](../scripts/runs/run_frontier_bound_proof.py)'s L3, $\operatorname{tr}$ **is** the ordinary trace ($=\mathrm{scal}/2$), not the scalar-curvature functional. The trap is $A\#B\ne A^\#B$.
- **Fence post F26 fails at its own anchor**, which is [fence-posts.md](fence-posts.md)'s matter.
