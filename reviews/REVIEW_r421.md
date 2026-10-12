# Reviewer r421, [Lemma L134](../findings/route-a.md), the competitor-side second-order margin

**Verdict: PLAUSIBLE.** Parts (a), (b) and (c) survive every attack in the brief, I re-derived the identification $F_u=\theta^*L_e$, the Hessian normalisation, the padded-flat identity and every number from the definitions, and four independent pins fix the normalisation the brief warned about. **Part (d) is refuted as written**: it quantifies over the whole cone $\{F=0\}$, and on the sub-cone spanned by the orbit tangent space (a) delivers margin $0$ rather than $-\theta^*/2$, so "$c_2\le\tfrac5{36}$ on $\{F=0\}$" does not imply what (d) says it implies. The repair is one sentence the lemma never writes, the reduction to the normal slice of $\mathcal O$, which the sibling item [I2](../plan.md) states explicitly for its own orbit, and with that sentence added the reduction is sound. A second, independent gap is that (b) is a per-direction statement and I3 is a neighbourhood statement; nothing in the lemma supplies uniformity in $H$.

*Analysis-only footing observed. One screen was run, the values of $\theta_0(n)$, $\kappa_n$ and $\theta^*/(2\lvert\kappa_n\rvert)$ at eight dimensions, seconds of arithmetic on numbers I constructed, and it is reported below as a screen. Everything else is derivation.*

| # | claim | verdict |
| --- | --- | --- |
| 1 | $F_u(h)=\tfrac12(uh+hu)+u\#h$ **is** $u\circ h$, hence $F_u=\theta^*L_e$, and the table lists $\operatorname{spec}(L_e)$ | **CONFIRMED**, pinned four independent ways; no factor of $2$ |
| 2 | (a) $\tfrac12\mathrm{Hess}(P\vert_S)_u[H,H]=3\theta^*(\langle L_eH,H\rangle-\tfrac12)$ | **CONFIRMED**, re-derived from the cubic, and the whole curve $t\mapsto P(\gamma(t))$ is exact, not asymptotic |
| 3 | (a) $\le-\theta^*/2$ for every unit $H\perp T_u\mathcal O$, at every $n\ge12$ | **CONFIRMED, with a scope note**, it inherits [Lemma L21](../findings/route-a.md)'s $\tfrac13$, whose four block spectra are floating-point and whose stable-range clause the record itself lists as an open obligation |
| 4 | (b) $\tfrac12\Phi''(0^+)\le-\theta^*/2+\lvert\kappa_n\rvert c_2(H)$ for such $H$ | **CONFIRMED**, and the $O(t^3)$ is legitimate, I supply the Rellich argument the lemma omits |
| 5 | (b) "I3 holds at $H$ as soon as $c_2(H)\le\theta^*/(2\lvert\kappa_n\rvert)$" | **CORRECTED**, true per direction and with strict inequality; the passage from per-direction to a neighbourhood needs uniformity in $H$ that is not supplied |
| 6 | (c) $c_2(H)=\delta^2(H)-\tfrac19$ exactly on the padded flat, and $\langle L_eH,H\rangle=0$ there | **CONFIRMED**, both are provable in three lines each, and I give the proofs the lemma cites rather than states |
| 7 | (c) $\le\tfrac5{36}$, and $\lvert\kappa_n\rvert c_2\le0.2369<\tfrac32\theta^*$ | **CONFIRMED**; the constant $1.70527$ is a typo for $1.7052182$ |
| 8 | (d) I3 reduces to $c_2(H)\le\tfrac5{36}$ **for every $H\in\{F=0\}$** | **REFUTED as written**, the quantifier must be $\{F=0\}\cap T_u\mathcal O^\perp$, and the reduction that makes that suffice is unstated |
| 9 | (d) "the mixed directions are not a separate case" | **REFUTED in the sense that matters**, the orbit tangents live in exactly the mixed blocks the record's mixed-direction runs sampled |
| 10 | (d) "$\tfrac5{36}$ … is exactly what the padded flat attains" | **REFUTED**, the record's own numbers cap the padded flat at $c_2\le0.0139$ at $n=12$ |

---

## 1. The identification $F_u=\theta^*L_e$, confirmed, and pinned four ways

The brief's warning that a factor of $2$ here would change every number is well placed, and the identification survives it.

[conventions.md](../findings/conventions.md) fixes $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ and $L_e=e\circ(\cdot)$. With $Q(X)=X^2+X^\#$ and $\#$ polarised as $X\#Y:=\tfrac12\big((X+Y)^\#-X^\#-Y^\#\big)$,

$$X\circ Y=\tfrac12\big[(XY+YX)+2X\#Y\big]=\tfrac12(XY+YX)+X\#Y,$$

which is [Lemma L20](../findings/route-a.md)'s $F_u$ on the nose. The dangerous rival reading is $F_u=DQ_u$, the honest linearisation, and that would be $DQ_u[h]=uh+hu+2u\#h=2\,u\circ h=2\theta^*L_e$, a clean factor of $2$. Four independent pins exclude it:

- **The orbit value.** Differentiating $Q(g\cdot u)=g\cdot Q(u)=\theta^*g\cdot u$ along $\exp(sA)$ gives $2\,u\circ[A,u]=\theta^*[A,u]$, so $L_e=\tfrac12$ on $T_u\mathcal O$ **universally, at any critical point**. The table's $\tfrac12$ at multiplicity $2+4(n-4)$ therefore forces the normalisation $F_u=u\circ(\cdot)$; under $DQ_u$ the orbit entry would read $1$.
- **The radial value.** $F_uu=u^2+u^\#=Q(u)=\theta^*u$ against $L_ee=e$, and the table's isolated $1$ in the trivial block is exactly that eigenvector.
- **[Lemma L20](../findings/route-a.md)'s own expansion.** $P$ is a cubic with polarisation $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, so $P(\cos\varphi\,u+\sin\varphi\,V)=\cos^3\varphi\,\theta^*+3\cos\varphi\sin^2\varphi\,\langle u\circ V,V\rangle+\sin^3\varphi\,P(V)$ exactly. Matching against L20's $m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$ with $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$ reproduces $F_u=u\circ(\cdot)$ and nothing else.
- **The padded-flat cross-check.** $\langle L_eH,H\rangle=0$ gives $\tfrac12\mathrm{Hess}=-\tfrac32\theta^*=-1.8371$, against the record's independently measured $-1.846$ at $n=12$ ([ATTEMPTS.md](../ATTEMPTS.md), the first-order-protection entry). A factor of $2$ would put the prediction at $-3.674$ or $0$.

So the table's header ($\operatorname{spec}(F_\lambda)/\theta^*$), does list the spectrum of $L_e$, and $\alpha\le\tfrac13$ reads $\langle L_eV,V\rangle\le\tfrac13$. Note also that the record's own $\#$-polarisation warning in the [Lemma L22](../findings/route-a.md) block is consistent with this: $\tfrac12(Q(x+y)-Q(x-y))=2\,x\circ y$, which is the "$2T(x,y,\cdot)$, divide by four" line, and it is the same convention.

## 2. Part (a), the Hessian identity is right, and stronger than stated

[Lemma L24](../findings/second-order.md) is stated at a *critical* point with $\theta>0$ for the identity and only the *maximiser* clause carries $\lambda_{\max}\le\tfrac12$. L134 uses the identity alone, at a point that is not a maximiser for $n\ge12$, and that is within scope. I re-derived it: $\nabla P=3Q(W)$, $D^2P=6L_W$, and the multiplier contributes $-\langle\nabla P,u\rangle\,\mathrm{Id}=-3\theta^*\mathrm{Id}$ on $u^\perp$, giving $6\theta^*(L_e-\tfrac12\mathrm{Id})$.

**The lemma understates its own P-side.** The expansion is not asymptotic. For unit $H\perp u$,

$$P(\cos t\,u+\sin t\,H)=\cos^3t\;\theta^*+3\cos t\sin^2 t\;\theta^*\langle L_eH,H\rangle+\sin^3t\;P(H)$$

holds **exactly for all $t$**, because $T(u,u,H)=\langle Q(u),H\rangle=\theta^*\langle u,H\rangle=0$. The $t^2$ coefficient is $3\theta^*(\langle L_eH,H\rangle-\tfrac12)$ as claimed, and the entire remainder is $\sin^3t\,P(H)$ plus the elementary $\cos^3t$ tail, uniformly bounded in $H$ by $\max P$. This matters for §5: the P-side is uniform in $H$ and only the defect side is not.

**The $\tfrac13$ and its scope.** The four-block table's arithmetic checks out. $\dim\mathcal O=\dim SO(n)-\dim\big(U(2)\times O(n-4)\big)=\tfrac{n(n-1)}2-4-\tfrac{(n-4)(n-5)}2=4n-14$, and the table's $\tfrac12$-multiplicities sum to $2\cdot1+4\cdot(n-4)=4n-14$. Since $T_u\mathcal O\subseteq E(\tfrac12)$ holds universally (§1), equal dimensions give equality, so the lemma's "no non-orbit direction at $\tfrac12$" is a genuine consequence of the table rather than a separate assumption, and the vector block's post-deletion top of $0$ is handled correctly ($0\le\tfrac13$).

*The scope note.* (a)'s proof says the four-block computation reaches $\tfrac13$ "with no multiplicity-free hypothesis and identically in $n$". The first half is right and is [Lemma L21](../findings/route-a.md)'s real contribution. The second half overstates the record: [route-a.md](../findings/route-a.md) says in its own words that "the remaining formal obligation is a proof that the stable range begins at $n-4\ge8$ rather than a check at two dimensions". The four $F_\lambda$ spectra are floating-point diagonalisations of fixed $20,20,6,10$-dimensional matrices, and only the $\tfrac12$-eigenspace identity was ever certified exactly (over a finite field, at $n=6,8,10$). For $n\ge12$ the stable-range hypothesis $n-4\ge8$ is satisfied, and the $n=10$ column agreeing outside it is real evidence, so I do not doubt the $\tfrac13$. But L134 presents an inherited numeric as a theorem, and the same overstatement is repeated verbatim in [ATTEMPTS.md](../ATTEMPTS.md)'s entry for this cycle.

## 3. Part (b), the expansion is legitimate, for a reason the lemma does not give

The brief asks whether a $\lvert t\rvert^3$ or $t^2\log t$ term can appear, given that $\delta^2$ is only one-sided differentiable at $u$. **It cannot, and here is why.** $t\mapsto\gamma(t)=\cos t\,u+\sin t\,H$ is a real-analytic one-parameter family of symmetric operators, so by Rellich's theorem the eigenvalues and an orthonormal eigenbasis can be chosen real-analytic on an interval about $0$. Each branch $\lambda_i(t)$ is either identically zero or has a constant sign on $(0,\varepsilon)$, so $\min(\lambda_i,0)$ agrees on $(0,\varepsilon)$ with a function analytic on $(-\varepsilon,\varepsilon)$. Hence $\gamma(t)_-$, and therefore $\delta^2(\gamma(t))=\lVert\mathrm{Alt}(\gamma(t)_-)\rVert^2$, agrees on $[0,\varepsilon)$ with a real-analytic function. The one-sided Taylor expansion is genuine, $c_2$ exists, and the remainder is $O(t^3)$. **This is a defence, not a defect**, but it is load-bearing and the lemma should carry it, because it is exactly what fails in the multi-parameter setting (see §5).

The geodesic parametrisation drops nothing. $\lVert\gamma(t)\rVert=1$, so $c_2$ as defined is the second-order coefficient along the sphere, and $\tfrac12\mathrm{Hess}(P\vert_S)$ is the matching coefficient for $P$, the $-3\theta^*\mathrm{Id}$ multiplier term is precisely the radial correction the curve's $-\tfrac{t^2}2u$ produces. The two halves are computed in the same parametrisation, which is what (c)'s identity $c_2=\tfrac12\frac{d^2}{dt^2}[\cos^2t/9+\sin^2t\,\delta^2(H)]=\delta^2(H)-\tfrac19$ confirms.

Two corrections to (b) as stated.

- **The inequality must be strict.** "I3 holds at $H$ as soon as $c_2(H)\le\theta^*/(2\lvert\kappa_n\rvert)$" fails at equality, where the $t^2$ coefficient vanishes and the $O(t^3)$ decides. The intended application clears it ($\tfrac5{36}<0.3591$), so this costs nothing, but the sufficient condition is $<$.
- **$\{F=0\}$ is where $d^+\delta^2$ vanishes, and the lemma is right about that.** Since $\Phi=P+\lvert\kappa_n\rvert\delta^2$ for $n\ge12$ and $d(P\vert_S)_u=0$, [Lemma L17](../findings/route-a.md)'s $d^+\Phi\le0$ is $d^+\delta^2\le0$ and its equality cone is $\{d^+\delta^2=0\}$. No objection.

## 4. Part (c), correct, and the two cited by-products both hold as used

The lemma cites the direct-sum rule and $\delta^2\le\tfrac14$ rather than proving them at this point. Both discharge.

- **The block sum.** $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^4\oplus(\mathbb R^4\otimes\mathbb R^{n-4})\oplus\Lambda^2\mathbb R^{n-4}$, and $\cos t\,u+\sin t\,H$ is block-diagonal with the mixed block zero. The negative part of a block-diagonal symmetric operator is the block sum of the negative parts, and $\cos t,\sin t>0$ on $(0,\pi/2)$, so $\gamma(t)_-=\cos t\,u_-\oplus\sin t\,H_-$.
- **$\mathrm{Alt}$ respects the splitting, and the cross term dies.** $\mathrm{Alt}$ of an operator supported in $S^2(\Lambda^2V)$ lands in $\Lambda^4V$. Here $\mathrm{Alt}(u_-)=a\star_{\mathbb R^4}\in\Lambda^4\mathbb R^4$ and $\mathrm{Alt}(H_-)\in\Lambda^4\mathbb R^{n-4}$, and those are orthogonal subspaces of $\Lambda^4\mathbb R^n$. So $\delta^2(t)=\cos^2t\cdot\tfrac19+\sin^2t\cdot\delta^2(H)$ **exactly**, with no cross term, the lemma's "exactly" is earned.
- **$\langle L_eH,H\rangle=0$.** $eH=He=0$ as matrix products (orthogonal blocks), and $e\#H=0$ because $\langle[\gamma,\delta],\cdot\rangle=0$ whenever $\gamma\in\Lambda^2\mathbb R^4$ and $\delta\in\Lambda^2\mathbb R^{n-4}$ commute, every structure constant in the $\#$ contraction vanishes. So $e\circ H=0$, which is stronger than $\langle L_eH,H\rangle=0$ and is the same fact [second-order.md](../findings/second-order.md) records as "$A\circ B=0$ alone makes $Q$ additive".
- **$\delta^2\le\tfrac14$ applies to $H$.** Padding preserves membership in $\mathcal W_n$, the norm, and $\mathrm{Alt}(\cdot_-)$, so a unit Weyl tensor of $\mathbb R^{n-4}$ padded into $\mathbb R^n$ is a unit Weyl tensor with the same $\delta^2$. The quoted bound is unconditional on unit Weyl tensors, so it applies.

**One wrong sentence, in (d) and repeated in [plan.md](../plan.md) and [ATTEMPTS.md](../ATTEMPTS.md).** "$\tfrac5{36}$ is the natural candidate since it is exactly what the padded flat attains." The padded flat attains nothing of the kind. $\tfrac5{36}$ comes from $\delta^2\le\tfrac14$, and the record's own census puts the unconstrained maximum of $\delta^2$ at $0.125$ ($n=8$) and $0.145$ ($n=12$). At $n=12$ the padded flat lives in $\mathcal W_8$, so $c_2\le0.125-\tfrac19=0.0139$, an order of magnitude under $\tfrac5{36}$. Keep $\tfrac5{36}$ as the target if it is convenient; drop the claim that it is attained.

The comparison in (c) is otherwise sound, and worth restating with the right factors: the padded flat clears by $\tfrac32\theta^*/(\lvert\kappa_n\rvert\cdot\tfrac5{36})$, which is $130\times$ at $n=12$ and $7.75\times$ in the limit. That does supersede the $18\times$ figure, it is larger at $n=12$ and, unlike $18\times$, it holds at every $n$.

## 5. Part (d), refuted as written

**The claim.** "I3 is reduced to a single statement about the defect alone: $c_2(H)\le\tfrac5{36}$ for every $H\in\{F=0\}$ … with the $P$-side contributing no further obligation at any $n$."

**Why it fails.** (a) is proved for $H\perp T_u\mathcal O$ and (b) inherits that hypothesis, but (d) quantifies over all of $\{F=0\}$, and [Lemma L17](../findings/route-a.md)'s cone explicitly contains the orbit tangents ("equality holds … which is satisfied by the $O(n)$-orbit, where $P_0HP_0=0$ identically"). On the orbit, $\langle L_eH,H\rangle=\tfrac12$ exactly, so

$$\tfrac12\mathrm{Hess}(P\vert_S)_u[H,H]=3\theta^*(\tfrac12-\tfrac12)=0,$$

and (b)'s sufficient condition becomes $c_2(H)\le0$, not $c_2(H)\le\tfrac5{36}$.

**And the failure is not confined to the orbit itself.** $F$ is convex and $1$-homogeneous on $T_uS$ with $F\ge0$ (the record's own correction to [Lemma L17](../findings/route-a.md)), so $\{F=0\}$ is a convex cone and contains every positive combination of its members. Take $h_{\mathrm{orb}}\in T_u\mathcal O$ and $h_{\mathrm{pad}}$ in the padded flat, both in $\{F=0\}$, and orthogonal, since $T_u\mathcal O$ sits in the $\Lambda^2\mathbb R^4$ and mixed blocks while the padded flat sits in $S^2(\Lambda^2\mathbb R^{n-4})$. Then $H_\varphi=\cos\varphi\,h_{\mathrm{orb}}+\sin\varphi\,h_{\mathrm{pad}}\in\{F=0\}$ is a unit vector with

$$\langle L_eH_\varphi,H_\varphi\rangle=\tfrac{\cos^2\varphi}2,\qquad \tfrac12\mathrm{Hess}(P\vert_S)[H_\varphi,H_\varphi]=-\tfrac32\theta^*\sin^2\varphi,$$

the cross term vanishing because $L_eh_{\mathrm{orb}}=\tfrac12h_{\mathrm{orb}}\perp h_{\mathrm{pad}}$. So the condition I3 actually needs at $H_\varphi$ is

$$c_2(H_\varphi)\;\le\;\frac{3\theta^*}{2\lvert\kappa_n\rvert}\,\sin^2\varphi\;\xrightarrow[\varphi\to0]{}\;0 .$$

A direction-independent bound $c_2\le\tfrac5{36}$ does not imply it. **(d) is therefore false as a reduction**: proving the statement (d) names would not close I3.

**Would this be true vacuously?** No. The family $H_\varphi$ is explicit, one-parameter, and lies in $\{F=0\}$ by convexity; the orbit tangent space has dimension $4n-14$ and the padded flat dimension $300$ at $n=12$, so this is a large piece of the cone, not a corner case.

**The repair, and it is available.** $P$ and $\delta^2$ are both $SO(n)$-invariant, so $\Phi$ is constant on orbits. By the slice theorem every $W$ near $\mathcal O$ is $g\cdot\exp_u(H)$ for some $g\in SO(n)$ and $H$ in the normal space $u^\perp\cap T_u\mathcal O^\perp$, and $\Phi(W)=\Phi(\exp_uH)$. So $\Phi\le\theta_0$ near $\mathcal O$ **iff** it holds along normal geodesics, and those are exactly the directions (a) covers. With that sentence added, (d)'s corrected form reads:

> I3 near $\mathcal O$ reduces to $c_2(H)<\theta^*/(2\lvert\kappa_n\rvert)$ for every unit $H\in\{F=0\}\cap T_u\mathcal O^\perp$.

The record already knows this move: [plan.md](../plan.md)'s sibling item I2 is stated as "nonpositive second variation **on the normal space** of $SO(n)\cdot W^*$". I3's item and L134(d) are the two places the restriction was dropped.

**The propagation.** Two other lines carry the same error and should move with the correction.

- [plan.md](../plan.md)'s I3 item states the target as "$c_2(H)\le\tfrac5{36}$ for every $H$ in the first-order equality cone $\{F=0\}$", same missing intersection.
- [plan.md](../plan.md)'s falsifier line, "a direction in $\{F=0\}$ with $c_2>\theta^*/(2\lvert\kappa_n\rvert)$ at some $n\ge12$ **refutes** Conjecture L16", **is invalid in the opposite direction**, and this one is more dangerous because it would license a false refutation. (a) is an *upper* bound on the Hessian; off the orbit $\langle L_eH,H\rangle$ runs down to $-1$, so $\tfrac12\mathrm{Hess}$ ranges over $[-\tfrac92\theta^*,-\tfrac12\theta^*]$. The true falsification condition is direction-dependent: $\lvert\kappa_n\rvert c_2(H)>3\theta^*\big(\tfrac12-\langle L_eH,H\rangle\big)$. Exceeding $\theta^*/(2\lvert\kappa_n\rvert)$ only removes the sufficient condition.

## 6. "The mixed directions are not a separate case", refuted in the sense that matters

The lemma retires the record's mixed-direction run with: "the record's own framing … was drawn before the $\tfrac13\theta^*$ gap was read as a Hessian bound; the mixed directions are not a separate case."

Under the record's meaning of *mixed* (support meeting both the distinguished $\mathbb R^4$ and its complement), this is right **for the part of that class orthogonal to the orbit**, and that is a real advance. But the orbit tangents are themselves mixed-block objects: $T_u\mathcal O=\mathfrak{so}(4)/\mathfrak{stab}\oplus(\mathbb R^4\otimes\mathbb R^{n-4})$, and for $A$ in the mixed part of $\mathfrak{so}(n)$, $[\rho(A),u]$ couples $\Lambda^2\mathbb R^4$ to $\mathbb R^4\otimes\mathbb R^{n-4}$, precisely the blocks the record's run sampled when it drew directions "with at least $15\%$ of their Frobenius mass in mixed blocks" ([ATTEMPTS.md](../ATTEMPTS.md)). So the class the lemma declares closed is the class in which its own margin degrades to zero, and the sentence retiring the mixed-direction run should say which part of that run it supersedes. With the slice correction of §5 the mixed-block directions transverse to $\mathcal O$ are genuinely covered and the near-orbit ones are genuinely unnecessary, but that is the argument, and the lemma does not make it.

## 7. Per-direction is not a neighbourhood, a second, independent gap

I3 is a statement about a neighbourhood of the competitor (equivalently, about $\limsup_{W\to u}(P-\theta_0)/\delta^2\le\kappa_n$; the two agree at second order, since $(P(\gamma(t))-\theta_0)/\delta^2(\gamma(t))=\kappa_n+9\cdot\tfrac12\Phi''(0^+)\,t^2+O(t^3)$). What (b) delivers is: for each fixed $H$, $\Phi(\gamma_H(t))<\theta_0$ for $t\in(0,\varepsilon_H)$. **A family of punctured intervals with no positive infimum of $\varepsilon_H$ is not a neighbourhood.**

The $P$-side is uniform, §2's expansion is exact with remainder $\sin^3t\,P(H)$, bounded by $\max P$. The defect side is not: §3's analytic branch, and hence the $O(t^3)$ constant, is produced by Rellich for each fixed $H$ and its radius depends on the eigenvalue-crossing structure along that ray. Closing this needs either a uniform third-order bound on $\delta^2$ over the cone, or a semialgebraic/Łojasiewicz argument of the kind [plan.md](../plan.md) already invokes elsewhere. It is not fatal and it is probably routine, but "closes I3 at every $n\ge12$" is not what (a)–(c) plus a pointwise $c_2$ bound would deliver.

## 8. The numbers, one typo, everything else right

*Screen, reported as a screen: $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ and $\kappa_n=9(\theta^*-\theta_0(n))$ evaluated at $n=12,13,14,16,100,10^4$ and in the limit.*

| quantity | lemma | check |
| --- | --- | --- |
| $\theta^*/2$ | $0.6124$ | $0.6123724$ ✓ |
| $\lvert\kappa_{12}\rvert$ | $0.10159$ | $0.1015939$ ✓ |
| $\theta^*/(2\lvert\kappa_{12}\rvert)$ | $6.03$ | $6.02765$ ✓ |
| $\lvert\kappa_n\rvert\uparrow9(\sqrt2-\sqrt{3/2})$ | $1.70527$ | $\mathbf{1.7052182}$, **typo**, and (c)'s $1.7053$ should be $1.7052$ |
| $\theta^*/\big(18(\sqrt2-\sqrt{3/2})\big)$ | $0.3591$ | $0.3591168$ ✓ |
| $\tfrac14-\tfrac19$ | $\tfrac5{36}=0.1389$ | ✓ |
| $\lvert\kappa_\infty\rvert\cdot\tfrac5{36}$ | $0.2369$ | $0.236836$ ✓ (the typo does not propagate past four digits) |
| $\tfrac32\theta^*$ | $1.837$ | $1.8371173$ ✓ |
| $3\theta^*(\tfrac13-\tfrac12)$ | $-\theta^*/2$ | ✓ |

Monotonicity is right: $\theta_0(n)$ increases to $\sqrt2$, so $\lvert\kappa_n\rvert$ increases to $1.7052182$ (never attained) and $\theta^*/(2\lvert\kappa_n\rvert)$ decreases to $0.3591168$ (never attained), $6.03,\,2.71,\,1.84,\,1.21,\,0.404$ at $n=12,13,14,16,100$. So the infimum is the binding case and $c_2\le0.3591$ suffices at every $n$, as (b) says. Every inequality direction in the lemma is correct: $\kappa_n<0$ makes $\Phi=P+\lvert\kappa_n\rvert\delta^2$, so defect growth pushes $\Phi$ **up**, and the requirement is an upper bound on $c_2$.

One phrasing point in (d): "or any bound below $0.3591$" should be "at most $0.3591$", since $\theta^*/(2\lvert\kappa_n\rvert)>0.3591168$ strictly at every finite $n$.

## What I could not break

- The identification $F_u=\theta^*L_e$, under four independent pins (§1).
- The Hessian normalisation, which I re-derived and which the record's own $-1.846$ measurement corroborates (§2).
- The claim that $E(\tfrac12)=T_u\mathcal O$ with no non-orbit direction at $\tfrac12$, the multiplicities do sum to $4n-14$, and $T_u\mathcal O\subseteq E(\tfrac12)$ is universal, so equal dimensions close it (§2).
- (c)'s exactness, including the vanishing of both the $\mathrm{Alt}$ cross term and the trilinear coupling, each of which I proved rather than quoted (§4).
- The one-sidedness worry, which Rellich disposes of along any fixed ray (§3).

## What must change

1. **(d)'s quantifier**: $\{F=0\}\cap T_u\mathcal O^\perp$, with the slice reduction stated as the reason that suffices. Same in [plan.md](../plan.md)'s I3 item.
2. **[plan.md](../plan.md)'s falsifier line**: exceeding $\theta^*/(2\lvert\kappa_n\rvert)$ does not refute Conjecture L16; the condition is $\lvert\kappa_n\rvert c_2(H)>3\theta^*(\tfrac12-\langle L_eH,H\rangle)$.
3. **"exactly what the padded flat attains"**, delete; the padded flat's own $c_2$ is at most $0.0139$ at $n=12$.
4. **$1.70527\to1.7052182$**, and $1.7053\to1.7052$ in (c).
5. **"identically in $n$"** in (a)'s proof, say instead that the four block spectra are fixed finite floating-point computations and that [route-a.md](../findings/route-a.md)'s stable-range clause ($n-4\ge8$) is a stated open obligation, satisfied at every $n\ge12$.
6. **(b)'s sufficient condition is strict**, and per-direction; add the uniformity clause, or restate what (a)–(c) close as "the second variation at $u$" rather than "I3".
7. **The mixed-direction retirement** should name the part of the record's run it supersedes (the orbit-transverse part) rather than the whole.
