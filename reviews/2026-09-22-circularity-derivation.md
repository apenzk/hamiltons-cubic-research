# The circularity in Nienhaus's great-circle estimate, measured: it is a SHELL near the top eigenvalue, not the whole method, 2026-09-22, on Fable

**The question set on Opus: how weak an a-priori bound $P\le c$ suffices to run [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Theorem 4.17's estimate at $n\ge12$?** *Answered here in closed form. The method does not collapse for $c$ above the true maximum; it fails on a shell of $\alpha$ just below the top eigenvalue $\tfrac13$, and the shell's width is an explicit function of $c$.*

## The setup, in Nienhaus's units

For unit $W\perp\mathbb RW_{\mathbb{CP}^2}\oplus T_{W_{\mathbb{CP}^2}}(SO(n)\cdot W_{\mathbb{CP}^2})$, along the great circle $c(\varphi)=\cos\varphi\,W_{\mathbb{CP}^2}+\sin\varphi\,W$,

$$f(\varphi)=\sqrt{\tfrac23}P(c(\varphi))=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma,\qquad\alpha=\sqrt{\tfrac23}\langle Q(W),W_{\mathbb{CP}^2}\rangle\le\tfrac13,\quad\gamma=\sqrt{\tfrac23}P(W),$$

the linear term dead by criticality, the quartic absent because $P$ is cubic, and $\alpha\le\tfrac13$ from Theorem 4.14 at every $n\ge9$. *$f(0)=1$ is $W_{\mathbb{CP}^2}$'s own value.*

## What the a-priori bound gives, for general $C$

**Lemma 1.** *If $f\le C$ on $[0,\pi]$ then $\gamma\le g_C(\alpha):=\min_\varphi\dfrac{C-\cos^3\varphi-3\cos\varphi\sin^2\varphi\,\alpha}{\sin^3\varphi}$, and the minimiser has $x=\cos\varphi_0$ solving $(1-\alpha)x^2-Cx+\alpha=0$, so*

$$x=\frac{C-\sqrt{C^2-4\alpha(1-\alpha)}}{2(1-\alpha)},\qquad g_C(\alpha)=\frac{C-x^3-3x(1-x^2)\alpha}{(1-x^2)^{3/2}}.$$

*Proof.* $g'(\varphi)\cdot\sin^4\varphi=-3\big(C\cos\varphi-\cos^2\varphi-\alpha\sin^2\varphi\big)$, so the stationary condition is $C\cos\varphi=\cos^2\varphi+\alpha\sin^2\varphi$, which is the quadratic. $\square$

**At $C=1$ this is Nienhaus's bound.** The quadratic factors as $(x-1)\big((1-\alpha)x-\alpha\big)$, so $\cos\varphi_0=\alpha/(1-\alpha)$ and $g_1(\alpha)=(1+\alpha)\sqrt{1-2\alpha}$, *the expression the extraction garbles as "$\sqrt{1-2\alpha(1+\alpha)}$".* Typed as `g1_closed_form`.

## Where the monotonicity closes

**Lemma 2.** *$f'(\varphi)=3\sin\varphi\big[(2\alpha-1)\cos^2\varphi-\alpha\sin^2\varphi+\sin\varphi\cos\varphi\,\gamma\big]$. Nienhaus's bracket is increasing in $\varphi$ for $\alpha\le\tfrac13$, and* **that reason needs $\gamma\ge0$** ([r1065](REVIEW_r1065.md): $B'=(1-3\alpha)\sin2\varphi+\gamma\cos2\varphi$ is negative at $\alpha=\tfrac13$ when $\gamma<0$; Nienhaus's own increasing function already carries the nonnegative bound). *Where the bracket is increasing, $f$ is strictly decreasing on $(0,\pi/6)$ iff it is negative at $\pi/6$, which is*

$$\gamma<\frac{3-5\alpha}{\sqrt3}.$$

Typed as `monotone_threshold`.

**THEOREM (derived).** *With input $f\le C$, Theorem 4.17's monotonicity on $(0,\pi/6)$ holds for exactly those $\alpha\le\tfrac13$ with $g_C(\alpha)\le\dfrac{3-5\alpha}{\sqrt3}$.* *The criterion is non-strict ([r1065](REVIEW_r1065.md)), which is why the $C=1$ row has width $0$ and the estimate runs at $\alpha=\tfrac13$ too.*

**At $C=1$ it holds for every $\alpha<\tfrac13$ and is an EQUALITY at $\alpha=\tfrac13$**: $g_1(\tfrac13)=\tfrac43\cdot\tfrac1{\sqrt3}=\dfrac{3-\tfrac53}{\sqrt3}$. *That is why Nienhaus writes "negative for $\alpha<\tfrac13$", strictly, and why Remark 4.18 says the case $\alpha\approx\tfrac13$ is what the estimates do not provide.* Typed as `tight_at_top`.

**For $C>1$ it fails on a shell $(\alpha^*(C),\tfrac13]$ and holds below it**, with $\alpha^*$ decreasing in $C$:

| $C$ | meaning | $\alpha^*(C)$ | shell width in $\alpha$ | cone half-angle |
|---|---|---|---|---|
| $1.0000$ | $W_{\mathbb{CP}^2}$ is the maximum, the $n\le11$ input | $\tfrac13$ | $0$ | $0^\circ$ |
| $1.0092$ | $\sqrt{2/3}\,\theta_0(12)$, **CIRCULAR**, this is the $n=12$ analogue of Conjecture A | $0.322290$ | $0.011044$ | $10.49^\circ$ |
| $1.05$ | | $0.287125$ | $0.046208$ | $21.5^\circ$ |
| $1.10$ | | $0.255321$ | $0.078012$ | $28.2^\circ$ |
| $1.20$ | | $0.204367$ | $0.128967$ | $36.9^\circ$ |
| $\sqrt2$ | $\sqrt{2/3}\cdot\sqrt3$, the record's unproved $M(n)\le\sqrt3$ | $0.115171$ | $0.218163$ | $54.0^\circ$ |

*Computed by bisection at 30 digits ([r1065](REVIEW_r1065.md) and here). **An earlier version of this table was a grid scan reported as a root-find**, drifting $+6$ to $+9.5\times10^{-5}$ on four rows, and gave the $\sqrt2$ row as "about $0.13$, about $0.20$", where $0.13$ in fact lies INSIDE the failure region.*

## What this settles, and the square root is why it settles less than it looks

**The circularity is not essential to the whole method: it is confined to the shell $(\alpha^*(C),\tfrac13]$.** *Theorem 4.14 gives the $\tfrac13$-eigenspace of $F_{W_{\mathbb{CP}^2}}$ explicitly, and $\alpha$ is exactly the Rayleigh quotient of $\sqrt{2/3}F$, so on the shell $W$ is genuinely close to that eigenspace and $\gamma$ there is a cubic on a known subspace.* **That localisation is real** ([r1065](REVIEW_r1065.md) supplies the constant the first version omitted: the gap below $\tfrac13$ is to $0$, so $\alpha\ge\tfrac13-\varepsilon$ forces $\lVert W-W_{1/3}\rVert\le\sqrt{3\varepsilon}$, and the reconstruction reproduces Remark 4.18's $\beta<0.223$ at $n=9$ to three decimals).

**BUT THE SQUARE ROOT UNDOES THE SMALLNESS, AND THE FIRST VERSION OF THIS NOTE MISSED IT.** *A shell of width $0.011$ in $\alpha$ is a cone of half-angle $10.49^\circ$. Nienhaus reports at $n=9$ that he could not close a cone of $\beta<0.223$ radians, which is $12.78^\circ$.* **So the job this leaves is only $1.22$ times tighter than the one its author could not do**, and at the unproved $C=\sqrt2$ it is $54^\circ$, far wider. *The honest reading is that the circularity is LOCATED rather than reduced to something easy.*

**And the $C$ that makes the shell smallest is itself circular.** *$C=1.0092$ is $\sqrt{2/3}\,\theta_0(12)$, the $n=12$ analogue of Conjecture A, so the $10.49^\circ$ figure is what one would get GIVEN the conjecture. The only non-circular input the record has is $M(n)\le\sqrt3$, itself unproved ([post F11](../findings/fence-posts.md)), giving $54^\circ$.*

**What it does NOT settle.** *Theorem 4.19's far part, $d>\pi/6$, is closed by gradient flow to a critical point and then BY CONJECTURE A on that critical point, which is Problem P itself.* **So even a completed tube at $n\ge12$ would remove the competitor's neighbourhood from [R25](../routes.md)'s far region and would not touch [I73](../plan.md).**

## THE CIRCULARITY ENTERS TWICE, AND THIS NOTE MEASURED THE LESSER ENTRY, 2026-09-22

**[r1066](REVIEW_r1066.md).** *Theorem 4.17 is ITSELF conditional on Conjecture A, by the paper's own words opening section 4.5.* **So removing the a-priori entry, which is all this note measures, leaves the other standing.** *And at $n\ge12$ the tube is around $W_{\mathbb{CP}^2}$, which is no longer the maximiser there, so a de-circularised 4.17 locates nothing regardless of $C$.* **That is the ceiling on this note's value, and the first version did not see it.**

**The target to close the shell was also the wrong number.** *"Below $g_C(\tfrac13)$" is no achievement, since $g_C$ is the upper bound the circular input itself supplies.* **What closes the shell is $\gamma<\tfrac4{3\sqrt3}=0.769800$**, the two coinciding only at $C=1$. *And $\sin^2\beta\le1-3\alpha$ gives $\beta\le0.18$ at $C=1.0092$ and $\beta\le0.94$ at $C=\sqrt2$, so a bound on the eigenspace alone bounds nothing.*

**One clause of 4.17 was never measured**, its second conclusion $f(\pi/6)<\sqrt{2/3}\,\Theta$. *Screened by [r1066](REVIEW_r1066.md) at $0.9640$ against $1.0092$, so it is not what breaks first, and it fails by $C=\sqrt2$ at $1.0262$.*

## What is owed

1. The maximum of $\gamma$ on the $\tfrac13$-eigenspace of Theorem 4.14, a cubic on an explicit subspace. *A derivation, from Theorem 4.14's description of that eigenspace.*
2. A proved a-priori $C$. *The record's $M(n)\le\sqrt3$ is a target, not a theorem ([post F11](../findings/fence-posts.md)); at $C=\sqrt2$ the shell is $0.20$ wide, so the eigenspace bound would have to carry a fifth of the range.*
3. Gate 2 on this note.

4. Rename `fderiv`, which shadows Mathlib's own, and connect it to a checked derivative; `monotone_threshold` types a point condition rather than monotonicity, which is where Lemma 2's defect sits ([r1065](REVIEW_r1065.md)).
5. Gate 2's second reader, r1066, was still running when the session stopped. **Its verdict is unread and unfolded.**
