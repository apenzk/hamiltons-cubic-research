# Review r432, Lemma L141 (adversarial)

*Reviewer r432, 2026-09-03, cold brief. Target: [Lemma L141](../findings/second-order.md) in [second-order.md](../findings/second-order.md), read against [Lemma L133](../findings/second-order.md), [Lemma L24](../findings/second-order.md), [Lemma L27](../findings/nondegeneracy.md), [Lemma L140](../findings/route-a.md) and [conventions.md](../findings/conventions.md).*

**Standing rule inherited and observed.** This programme is on the analysis-only footing of [analysis-only.md](../.claude/rules/analysis-only.md). Every verdict below rests on a derivation done by hand. Seven **screens** were run (seconds of compute on random symmetric matrices and on scalar formulas built for the purpose), solely to check claims I was about to record. They are reported as screens and are never offered as evidence for a positive claim.

## Verdict table

| Claim | Verdict |
| --- | --- |
| **L141(a)**, $\lVert D(\mathrm{Alt}\,W_-)_V[H]\rVert\le\tfrac12\lVert H\rVert$ at every $V$ where the spectral parts are differentiable | **CONFIRMED.** The inequality is true, the proof is valid, and the constant is attained by $\lVert DW_-[H]+\tfrac12H\rVert$ |
| **L141(a)**, the multiplier of $f(x)=\tfrac12(\lvert x\rvert-x)$ has every entry in $[-1,0]$ | **CONFIRMED** for every pair of nonzero eigenvalues and for every pair with exactly one zero. **Undefined on the $\ker\times\ker$ block**, which the hypothesis silently excludes |
| **L141(a)**, the entrywise-to-Frobenius step | **CONFIRMED**, and convention-robust: any positive multiple of the Frobenius inner product on $S^2\Lambda^2$ gives the same constant |
| **L141(a)**, $\mathrm{Alt}(H)=0$ by first Bianchi, $\mathrm{Alt}$ an orthogonal projection | **CONFIRMED**, though [conventions.md](../findings/conventions.md) defines neither $\mathrm{Alt}$ nor the sign of $W_-$ |
| **The title**, "at every critical point" | **REFUTED.** The hypothesis holds only where $0\notin\operatorname{spec}_{\Lambda^2}(V)$. It excludes the competitor and every padded critical point |
| **"It holds at the competitor … by the same three lines"** | **REFUTED.** The three lines break on the $\ker\times\ker$ block, where the derivative is nonlinear in $H$ and no multiplier exists. [Lemma L140](../findings/route-a.md) needed a separate exact computation there, so (a) does not contain L140 |
| **The sign convention of $f$** | **COLLISION, non-fatal.** L141 takes $W_-=\tfrac12(\lvert W\rvert-W)$; [Lemma L133](../findings/second-order.md), fifty lines above in the same file, takes $W_-=\min(W,0)$. The centring $\mu=+\tfrac12$ is correct only in L141's convention and is $3\times$ wrong in L133's |
| **L141(b)**, $Q(H)\le-c_n\lVert H\rVert^2$ with $c_n=2.464\,\theta_0(n)/(n-2)$ | **CONFIRMED as a conclusion**, conditional on L24, L27 and L133, and with the rounding of every constant in the safe direction |
| **L141(b)**, the spectral input, $\tfrac12\mathrm{Hess}\le-3\theta_0/(n-2)\lVert H\rVert^2$ | **CONFIRMED.** L27's off-orbit maximum is $\lambda_m=\tfrac{m-2}{2(m-1)}$ for every $m\ge5$, and $\lambda_m-\tfrac12=-\tfrac1{n-2}$ |
| **L141(b)**, the pencil input, $\lvert\kappa_n^{\mathrm{Hess}}\rvert\ge5.598\lvert\kappa_n\rvert$, used in the direction stated | **CONFIRMED.** The ratio decreases monotonically from $49.27$ to $5.598076$; $5.598$ is a rounding down, hence safe |
| **L141(b)**, the sign of $\kappa_n$ | **CONFIRMED.** $\kappa_n<0$ exactly from $n=12$, and $-\kappa_n d^2$ enters as a positive quantity in both bounds. No collision |
| **L141(b)**, "the worst case is where they cross" | **REFUTED at $n=12$.** There $\sigma^*=0.652$, far outside the range $\sigma\le\tfrac14$ that (a) supplies and outside the true range $\sigma\le\tfrac29$ at $W^*$. The conclusion survives *a fortiori*; the stated mechanism does not |
| **L141(b)**, "the first bound decreases in $\sigma$" | **REFUTED.** It increases in $\sigma$. The max-of-min conclusion is unaffected |
| **"$\sigma\le\tfrac14$ … is what makes the crossing argument in (b) finite"** | **REFUTED.** The crossing argument is finite with no bound on $\sigma$ at all, because the pencil bound tends to $-\infty$. Part (a) is load-bearing for nothing in part (b) |
| **Is $Q\le-c_n\lVert H\rVert^2$ what the tube needs?** | **CONFIRMED as the right direction**, and **OVERSTATED as a tube.** It is a per-direction second-order statement; the third-order remainder the lemma itself owes is what turns it into a radius |
| **Vacuity** | **NOT VACUOUS.** $D(\mathrm{Alt}\,W_-)[H]\ne0$ at $W^*$, and $c_n>0$ for every $n\ge12$, though $c_n=\Theta(1/n)$ |

---

## 1. The convention, pinned first, because it is the named root cause of the earlier refutation

The record uses two opposite definitions of $W_-$, and both appear in [second-order.md](../findings/second-order.md).

- [Lemma L133](../findings/second-order.md) Step 1 says "$W^*_-$ is a **negative** multiple of the projector onto the mixed planes", and Step 2 gives the Daleckii–Krein function as $f(t)=t\cdot\mathbf1_{t<0}=\min(t,0)$, with multipliers $1$ on $(-,-)$, $0$ on $(+,+)$ and $c=\tfrac{m-1}{2m-1}>0$ on mixed pairs. That is $W_-=\min(W,0)$, negative semidefinite, multipliers in $[0,1]$.
- [Lemma L141](../findings/second-order.md)(a) states $f(x)=\tfrac12(\lvert x\rvert-x)=\max(-x,0)$, multipliers in $[-1,0]$. That is $W_-=\tfrac12(\lvert W\rvert-W)$, positive semidefinite, the **negative** of L133's object.

I recomputed the mixed multiplier from L141's $f$ by hand: with $\lambda_+=mk$, $\lambda_-=-(m-1)k$ and $\lambda_+-\lambda_-=(2m-1)k$,
$$f^{[1]}(\lambda_+,\lambda_-)=\frac{0-(-\lambda_-)}{\lambda_+-\lambda_-}=\frac{\lambda_-}{\lambda_+-\lambda_-}=-\frac{m-1}{2m-1}=-c,$$
against L133's $+c$. The two are exact negatives, confirming the collision rather than a transcription slip.

**It does not change any number in the lemma**, because both $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ and $d(H)^2=\lVert D(\mathrm{Alt}\,W_-)[H]\rVert^2$ are norms, invariant under $W_-\mapsto-W_-$. The lemma's own remark ("the same in either sign convention"), is correct as a statement about the *constant*.

**It does change the proof as written.** The centring $\mu=+\tfrac12$ is correct only for L141's $f$. *Screened*: on $400$ random invertible symmetric $V$ with random symmetric $H$, $\lVert DW_-[H]+\tfrac12H\rVert/\lVert H\rVert$ reaches $0.500000000$ in L141's convention and $1.500000$ in L133's, a factor of three, in the direction that would break the claim. [Lemma L140](../findings/route-a.md) states both conventions and both centrings explicitly and is safe; L141 compresses that to one sentence and states only one of them, in the convention its own file does not use elsewhere.

**A record defect that is upstream of this.** [conventions.md](../findings/conventions.md) (whose stated purpose is that "definitions and conventions are quoted, never restated"), carries **no row for $\mathrm{Alt}$ and no row for the sign of $W_-$**. These are precisely the two conventions that collided in [r425](REVIEW_r425.md)/[r426](REVIEW_r426.md) and that collide again here. $\mathrm{Alt}$ is defined only in passing, in [problem.md](../findings/problem.md) ("the projection onto $\Lambda^4$") and in [route-a.md](../findings/route-a.md) ("an orthogonal projection"). **Two rows in [conventions.md](../findings/conventions.md) would have prevented three cycles of this.**

## 2. Part (a): the multiplier, recomputed for a general pair

With $f(x)=\tfrac12(\lvert x\rvert-x)$, so $f\equiv0$ on $[0,\infty)$ and $f(x)=-x$ on $(-\infty,0)$, the divided differences are:

| pair $(\lambda,\nu)$ | $f^{[1]}(\lambda,\nu)$ | in $[-1,0]$? |
| --- | --- | --- |
| both $>0$, distinct | $0$ | yes |
| both $>0$, equal | $f'(\lambda)=0$ | yes |
| both $<0$, distinct | $(-\lambda+\nu)/(\lambda-\nu)=-1$ | yes |
| both $<0$, equal | $f'(\lambda)=-1$ | yes |
| $\lambda>0>\nu$ | $\nu/(\lambda-\nu)=-\lvert\nu\rvert/(\lambda+\lvert\nu\rvert)$ | yes, in $(-1,0)$ |
| $\lambda>0$, $\nu=0$ | $0$ | yes |
| $\lambda<0$, $\nu=0$ | $-\lambda/\lambda=-1$ | yes |
| $\lambda=\nu=0$ | $f'(0)$ **does not exist** | **undefined** |

**So the range claim is right, and there is exactly one gap: the $\ker\times\ker$ block.** *Screened*: over $400$ random invertible symmetric $V$ the observed multiplier range was exactly $[-1,0]$, and the Daleckii–Krein derivative matched a central finite difference of $A\mapsto\tfrac12(\lvert A\rvert-A)$ to $3.2\times10^{-9}$.

**The entrywise-to-Frobenius step is genuine, not an operator/entrywise confusion.** $V$ is symmetric on $\Lambda^2$, so it has an orthonormal eigenbasis there; in that basis $DW_-[H]_{ab}=m_{ab}H_{ab}$ and $(\tfrac12H)_{ab}=\tfrac12H_{ab}$, so $\lvert(DW_-[H]+\tfrac12H)_{ab}\rvert=\lvert m_{ab}+\tfrac12\rvert\,\lvert H_{ab}\rvert\le\tfrac12\lvert H_{ab}\rvert$ with $m_{ab}+\tfrac12\in[-\tfrac12,\tfrac12]$. Squaring and summing is the Frobenius norm, which is orthonormal-basis independent. The lemma's phrase "at most half the corresponding entry" should read "at most half in absolute value"; that is wording, not content. The step is also **convention-robust**: replacing the inner product on $S^2\Lambda^2$ by any positive multiple scales both sides equally, so [conventions.md](../findings/conventions.md)'s live $\tfrac12$-placement trap cannot reach this constant.

**$\mathrm{Alt}(H)=0$ is correct.** $S^2\Lambda^2=\mathcal{ACT}\oplus\Lambda^4$ with $\mathrm{Alt}$ the orthogonal projection onto $\Lambda^4$, and a tensor satisfies the first Bianchi identity exactly when its $\Lambda^4$ part vanishes. [Lemma L133](../findings/second-order.md) confirms it in coordinates: in the signed four-set coordinates first Bianchi reads $x+y+z=0$ and $\mathrm{Alt}$ is the projection onto $\mathbf1$, so $\mathrm{Alt}(H)=0$ on the nose. Orthogonality of the projection then gives $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$, which is the last step.

**The bound is attained at the pre-$\mathrm{Alt}$ stage.** *Screened*: $\max\lVert DW_-[H]+\tfrac12H\rVert/\lVert H\rVert=0.500000000$ over the same $400$ trials, so the recentring itself has no slack. Whatever slack $\tfrac12$ has, it is $\mathrm{Alt}$'s own, which is the same reading [Lemma L140](../findings/route-a.md) records.

**Verdict on the inequality: CONFIRMED**, under the hypothesis as literally stated.

## 3. The hypothesis excludes the case the lemma claims to cover

The lemma's own commentary says: "**No spectral data of the base point enters**, so it holds at the competitor, where the spectrum is degenerate, exactly as at the balanced product … and by the same three lines." **That is false in three ways.**

- **The competitor is outside the hypothesis.** $u=W_{\mathcal S^4(\alpha)}$ has spectrum $\tfrac1{\sqrt6}(2,-1,-1)$ on $E$ and $0$ on $K$, [Lemma L140](../findings/route-a.md)'s own table. [Lemma L133](../findings/second-order.md)'s closing paragraph says the same thing: the competitor is "where $W$ has a kernel and $\delta^2$ has a kink". With $0\in\operatorname{spec}(u)$, $W\mapsto W_-$ is **not differentiable at $u$**, so "the spectral parts are differentiable at $V$" is exactly the hypothesis that excludes it.
- **The derivative is not even linear there, so the symbol $D(\mathrm{Alt}\,W_-)_V[H]$ has no referent.** *Screened*: at $V=\operatorname{diag}(2,-1,0,0)$ and random symmetric $H$, the two one-sided derivatives satisfy $\lVert d^++d^-\rVert=0.88\ne0$, and the $K$-block of $d^+$ equals $(P_0HP_0)_-$ to $1.2\times10^{-6}$, a positively homogeneous, non-additive function of $H$.
- **The three lines do not extend.** [Lemma L140](../findings/route-a.md) needed a *separate, non-Daleckii–Krein* clause for exactly this block: $Z_{KK}=D_-$ with $D=P_0HP_0$, whence $Z_{KK}+\tfrac12H_{KK}=\tfrac12\lvert D\rvert$ and $\lVert Z_{KK}+\tfrac12H_{KK}\rVert=\tfrac12\lVert D\rVert$. *Screened*: that identity is an exact equality, $0.440756=0.440756$. L141(a) contains no such clause.

**So the relation between L141(a) and [Lemma L140](../findings/route-a.md) is the reverse of the one claimed.** L140 is not a special case of L141(a) (its base point violates L141(a)'s hypothesis) and L141(a) is L140's argument **with the one hard block deleted**, restated at base points where that block is empty. The header's "(a) is [Lemma L140](../findings/route-a.md)'s recentring stated once, for every base point rather than only at the competitor" should read: *for every base point at which $W_-$ is differentiable, which is where the recentring alone suffices*.

**The title is likewise wrong.** "The defect's derivative is a $\tfrac12$-contraction at every critical point" fails at every critical point with a kernel, which includes the competitor and **every padded critical point** the record uses, [conventions.md](../findings/conventions.md)'s own row for $S(W)$ carries the warning that the gradedness screen "is vacuous when $\ker W\ne0$", so kernels are common rather than exceptional here.

**The repair is available and is one clause.** State (a) for the one-sided directional derivative at every $V$, with the $\ker\times\ker$ block handled by L140's exact identity $\lVert(P_0HP_0)_-+\tfrac12P_0HP_0\rVert=\tfrac12\lVert P_0HP_0\rVert$; then the constant $\tfrac12$ does hold at every base point, which is the statement the title wants. As it stands, the general statement is the one thing (a) does not prove.

## 4. Part (b): the two inputs, checked from their own sources

**The spectral input is correct, and reaches into [Lemma L27](../findings/nondegeneracy.md)'s proof rather than its statement.** L27's *statement* delivers only $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$, attained on the orbit tangent. The $\lambda_m$ bound comes from the ten summand values in its *argument*: $1$ on $\langle W\rangle$, $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$ (the orbit), $\lambda_m=\tfrac{m-2}{2(m-1)}$ on each $S^2_0(\mathbb R^m)$, $\pm\mu$ on the two tensor summands, $0$ on the remaining four. At $p=q=m$,
$$\mu=\tfrac12-\frac{(m-2)^2-1}{2(m-1)^2}=\tfrac12-\frac{m-3}{2(m-1)}=\frac1{m-1}=\frac2{n-2},$$
matching [Lemma L133](../findings/second-order.md)'s $\mu_{m,m}$ independently. Comparing, $\lambda_m>\mu\iff m>4$, and $n=2m\ge12$ gives $m\ge6$, so the off-orbit maximum is $\lambda_m$. The hypotheses $p,q\ge3$ and $(p,q)\ne(3,3)$ are satisfied with room. **CONFIRMED.**

**The normalisation is correct.** [Lemma L24](../findings/second-order.md) gives $\mathrm{Hess}(P|_S)=6\theta_0(L_e-\tfrac12\mathrm{Id})$ on $(W^*)^\perp$, so $\tfrac12\mathrm{Hess}[H,H]=3\theta_0\big(\langle L_eH,H\rangle-\tfrac12\lVert H\rVert^2\big)\le3\theta_0(\lambda_m-\tfrac12)\lVert H\rVert^2$, and $\lambda_m-\tfrac12=-\tfrac1{2(m-1)}=-\tfrac1{n-2}$, giving $-\tfrac{3\theta_0}{n-2}\lVert H\rVert^2$. **CONFIRMED.**

**The pencil input is correct and used in the right direction.** Both $\kappa_n^{\mathrm{Hess}}$ and $\kappa_n$ are negative for $n\ge12$, so
$$\kappa_n^{\mathrm{Hess}}-\kappa_n=-\lvert\kappa_n^{\mathrm{Hess}}\rvert+\lvert\kappa_n\rvert\le-5.598\lvert\kappa_n\rvert+\lvert\kappa_n\rvert=-4.598\lvert\kappa_n\rvert,$$
which needs the ratio bounded **below**, and that is what [Lemma L133](../findings/second-order.md) supplies. *Screened*: the ratio is monotone decreasing over $n=12,14,\dots,10^6$, from $49.274$ to $5.598108$, against the exact limit $\tfrac{27\sqrt2/4}{9(\sqrt2-\sqrt{3/2})}=5.598076$. Since $5.598$ is a **rounding down** of the infimum, the inequality is safe; so is $2.464<3\cdot4.598/5.598=2.464094$. **Both roundings go the safe way**, worth recording, because either one rounded the other way would have made $c_n$ an overclaim.

**The sign of $\kappa_n$ is handled correctly at every appearance.** $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ and $\theta_0(12)=1.236033>\sqrt{3/2}=1.224745$, so $\kappa_n<0$ for $n\ge12$; *screened*, $\theta_0(10)=1.2$ and $\theta_0(11)=1.219673$ both sit **below** $\sqrt{3/2}$, so the $n\ge12$ hypothesis is load-bearing and is applied where it must be. Then $-\kappa_n d^2=+\lvert\kappa_n\rvert d^2>0$, and both displayed bounds carry it with a plus sign. **No sign collision in (b)**, which is the one place I expected to find the earlier chain's defect and did not.

## 5. The crossing argument: the conclusion holds, the stated mechanism fails at $n=12$

Write $\sigma=d(H)^2/\lVert H\rVert^2$ and
$$B_1(\sigma)=-\frac{3\theta_0}{n-2}+\lvert\kappa_n\rvert\sigma,\qquad B_2(\sigma)=-4.598\lvert\kappa_n\rvert\sigma,$$
so $Q(H)/\lVert H\rVert^2\le\min\big(B_1(\sigma),B_2(\sigma)\big)$ and a uniform bound is $\sup_\sigma\min(B_1,B_2)$.

- **The monotonicity is misstated.** The lemma says "the first bound decreases in $\sigma$ and the second increases in $-\sigma$". $B_1$ **increases** in $\sigma$ and $B_2$ decreases. The conclusion that $\min$ is maximised at the crossing is nevertheless right, and for the corrected reason: an increasing function and a decreasing one have their pointwise minimum maximised where they meet.
- **The arithmetic is right.** $B_1(\sigma^*)=B_2(\sigma^*)$ gives $\sigma^*=\tfrac{3\theta_0}{5.598\lvert\kappa_n\rvert(n-2)}$ and the common value $-\tfrac{4.598}{5.598}\cdot\tfrac{3\theta_0}{n-2}=-\tfrac{2.4641\,\theta_0}{n-2}$. **CONFIRMED.**
- **The crossing is infeasible at $n=12$.** *Screened*: $\sigma^*=0.6520$ at $n=12$, against $\sigma\le\tfrac14$ from (a) and against the sharper $\sigma\le\tfrac29$ that [Lemma L133](../findings/second-order.md) Step 2 already gives at $W^*$, its own $\lVert\mathrm{Alt}\,DW_-[H]\rVert^2=\tfrac\gamma3x^2$ against $\lVert H\rVert^2=\gamma(x^2+y^2+z^2)$ with $x+y+z=0$ maximises at $y=z=-\tfrac x2$, giving $\tfrac{x^2/3}{3x^2/2}=\tfrac29$. So at $n=12$ the two bounds never cross inside the admissible range, and "the worst case is where they cross" is **false there**. The *conclusion* survives, because $B_1$ is increasing and $\sigma_{\max}<\sigma^*$ forces $B_1(\sigma_{\max})<B_1(\sigma^*)=-c_n$: numerically $B_1(\tfrac29)=-0.34823<-0.30456=-c_{12}$. **The stated $c_{12}$ is valid and not tight.**
- **$n=12$ is the only such $n$.** *Screened*: $\sigma^*=0.1695,\,0.0971,\,0.0522,\,0.0050$ at $n=14,16,20,100$, all below $\tfrac29$, so from $n\ge14$ the crossing is genuinely attainable and $c_n$ is the honest worst case.
- **Both bounds are genuinely needed.** *Screened*: $B_1(\tfrac14)=-0.345,\,-0.232,\,-0.148,\,-0.031,\,+0.199$ at $n=12,14,16,20,40$. The spectral bound alone, even with (a)'s $\sigma\le\tfrac14$, stops being negative around $n\approx22$, so [Lemma L133](../findings/second-order.md) is doing real work at large $n$ and the two-regime structure is not decorative.

**"$\sigma\le\tfrac14$ … is what makes the crossing argument in (b) finite" is false.** $B_2(\sigma)\to-\infty$ as $\sigma\to\infty$, so $\sup_\sigma\min(B_1,B_2)$ is finite over $[0,\infty)$ with no bound on $\sigma$ whatever. What a bound on $\sigma$ actually does is **improve** $c_n$ at small $n$, the opposite role from the one claimed. **Part (a) is load-bearing for nothing in part (b)**, and the sharper input at $W^*$ is $\tfrac29$ from L133 rather than $\tfrac14$ from (a).

## 6. Is $Q\le-c_n\lVert H\rVert^2$ what the tube needs?

**The direction is right.** [Conjecture L16](../findings/problem.md) asks for $\Phi=P-\kappa_n\delta^2\le\theta_0(n)$, and $\Phi(W^*)=\theta_0$ with $D\Phi|_S=0$ at $W^*$ (criticality for $P$; $\delta^2$ vanishing to second order for the penalty). So $\Phi-\theta_0=t^2Q(H)+O(t^3)$ along $\cos t\,W^*+\sin t\,H$, and the tube needs $Q$ **negative** definite, quantitatively, to beat the remainder. That is exactly what (b) states. **CONFIRMED.**

**The restriction to $T_{W^*}\mathcal O^\perp$ is correct and necessary.** $\Phi$ is $O(n)$-invariant and $W^*$ is critical for it, so $T_{W^*}\mathcal O$ lies in the Hessian's kernel and there are no orbit-to-normal cross terms; $Q(H)=Q(H^\perp)$. The bound therefore cannot be upgraded to $Q(H)\le-c_n\lVert H\rVert^2$ on all of $T_{W^*}S$, and the lemma does not try to.

**"Definiteness with an explicit constant" is not a tube.** This is a per-direction second-order coefficient. The lemma says so in its closing paragraph (the third-order remainder $C$ is owed, with $r_n=c_n/C$) so the honest reading is *the transverse second-order margin at the balanced orbit*, and the title's "definite with an explicit constant" is accurate while any reading of the claim as a neighbourhood statement is not. Same gap [r428](REVIEW_r428.md) recorded on the competitor side.

## 7. Vacuity

**(a) is not vacuous.** $D(\mathrm{Alt}\,W_-)[H]\ne0$ for Weyl $H$: [Lemma L133](../findings/second-order.md) Step 2 computes $\mathrm{Alt}\,DW_-[H]=-\tfrac x3\mathbf1$ on every $(2,2)$-split four-set block, nonzero whenever $x\ne0$. And the recentring itself is tight, *screened* at exactly $0.5$, so the $\tfrac12$ is not an artefact of a lossy step. **What it is not is sharp for the composite**: at $W^*$ the true maximum of $\lVert D(\mathrm{Alt}\,W_-)[H]\rVert/\lVert H\rVert$ is $\sqrt{2/9}=0.4714$, so $\mathrm{Alt}$ absorbs the rest.

**(b) is not vacuous, and it decays.** $c_n=2.464\theta_0(n)/(n-2)>0$ for every $n\ge12$, taking values $0.3046,\,0.2591,\,0.2254,\,0.1790,\,0.0350$ at $n=12,14,16,20,100$. Since $\theta_0\to\sqrt2$, $c_n\sim3.485/n$. The lemma flags this itself. It is a real constant, not a vanishing one, but any tube built on it shrinks with $n$ unless the third-order constant shrinks too.

## 8. What I would have the record change

- **Add two rows to [conventions.md](../findings/conventions.md)**: the sign of $W_-$, and $\mathrm{Alt}$ as the orthogonal projection $S^2\Lambda^2\to\Lambda^4$. The collision in §1 is the third cycle these two have cost.
- **Restate L141(a)'s hypothesis honestly**, or extend it with [Lemma L140](../findings/route-a.md)'s $\ker\times\ker$ clause and the one-sided derivative. Either is a small edit; leaving it as it is means the title, the "no spectral data enters" remark and the "holds at the competitor" remark are all false against the lemma's own statement.
- **Drop the claim that (a) is what makes (b) finite**, and record instead that $W^*$'s own $\sigma\le\tfrac29$ comes free from [Lemma L133](../findings/second-order.md) Step 2 and is the sharper input.
- **Fix the monotonicity sentence** in (b), and add the $n=12$ caveat: the crossing is outside the admissible range there, and $c_{12}$ holds because $B_1$ is increasing rather than because the bounds cross.
