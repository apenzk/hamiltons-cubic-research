# Reviewer 320, the kernel cycle: the subalgebra collapse, post F40, and the four-failure synthesis

*Adversarial Gate 2 audit. Every number below comes from an implementation built from the definitions in [scripts/reviewers/r320/](../scripts/reviewers/r320/) (structure constants, the sharp map, the Weyl space, the critical-point solver), with no import from the repository's own library and no reliance on its prose. Validation of the rebuild: $\kappa=\sum_{b,c}c_{abc}^2=2(n-2)$ and $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ at $n=4,\dots,8$; $\dim\mathrm{Weyl}_n=10,35,84,168,300$ at $n=4,\dots,8$, matching $n(n+1)(n+2)(n-3)/12$; $Q$ preserves $\mathrm{Weyl}_n$ to $2.7\times10^{-16}$.*

---

## P1, the subalgebra collapse and its reach: **CONFIRMED**

### What reproduces

Lemma L23's two closed forms hold exactly at every critical member I built, and fail exactly where the member is not critical.

| $\mathfrak h$ | $n$ | $r$ | $\theta$ measured | $\frac2n\sqrt{rN/(N-r)}$ | residual | $\lVert\mathrm{Ric}\rVert_\infty$ | $S_{\mathfrak{mmm}}$ measured | closed form | cap |
|---|---|---|---|---|---|---|---|---|---|
| $\mathfrak{so}(3)^{\oplus2}$ | 6 | 6 | 1.054093 | 1.054093 | $3.6\times10^{-16}$ | $10^{-16}$ | 0.0000 | 0.0000 | 6 |
| $\mathfrak{so}(4)^{\oplus2}$ | 8 | 12 | 1.145644 | 1.145644 | $3.3\times10^{-16}$ | $10^{-17}$ | 0.0000 | 0.0000 | 12 |
| $\mathfrak{so}(6)^{\oplus2}$ | 12 | 30 | 1.236033 | 1.236033 | $4.9\times10^{-16}$ | $10^{-16}$ | 0.0000 | 0.0000 | 30 |
| $\mathfrak{so}(3)^{\oplus3}$ | 9 | 9 | 0.769800 | 0.769800 | $2.1\times10^{-16}$ | $10^{-16}$ | 162.0000 | 162.0000 | 15.75 |
| $\mathfrak{so}(4)^{\oplus3}$ | 12 | 18 | 0.829156 | 0.829156 | $1.8\times10^{-16}$ | $10^{-17}$ | 384.0000 | 384.0000 | 30 |
| $\mathfrak{so}(2)^{\oplus3}$ | 6 | 3 | 0.645497 | 0.645497 | $2.1\times10^{-16}$ | 0 | 48.0000 | 48.0000 | 6 |
| $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ | 8 | 13 |, | 1.231530 | $1.1\times10^{-1}$ | $4.7\times10^{-1}$ | 0.0000 | **$-15$** | 12 |
| $\mathfrak{so}(4)\oplus\mathfrak{so}(6)$ | 10 | 21 |, | 1.254990 | $6.8\times10^{-2}$ | $3.6\times10^{-1}$ | 0.0000 | **$-19.2$** | 20 |

The reach claim reproduces to the digit. At $n=8$, $S^4\times S^4$ has **two** eigenvalues and $\theta=1.145644=\theta_0(8)$; $S^3\times S^5$ and $S^2\times S^6$ have **three**, sit outside the family, and carry $S_{\mathfrak{mmm}}(E_-)=5.0\times10^{-29}$ and $7.3\times10^{-29}$ at $\theta=1.115547$ and $0.986013$. The window arithmetic checks: $r^\star=29.70$ against a cap of $30$ at $n=12$, and $121.17$ against $132$ at $n=24$.

### Is the collapse a genuine consequence, or nearly a tautology?

**Nearly a tautology, as the record now says, and the record's wording is exactly right.** Given the two closed forms, $S_{\mathfrak{mmm}}$ is affine in $r$ with its single root at $r=n(n-2)/4$, and $\theta(r)=\frac2n\sqrt{rN/(N-r)}$ is strictly increasing on $(0,N)$; each of the three equivalences is one line. All the content sits in the $S_{\mathfrak{mmm}}$ closed form, which is a real derivation.

### The collapse has a second proof that never touches the $S_{\mathfrak{mmm}}$ formula, and I did not find it in the record

$S_{\mathfrak{mmm}}=0$ says $\langle[\mathfrak m,\mathfrak m],\mathfrak m\rangle=0$, i.e. $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, i.e. $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair. **Every symmetric subalgebra of $\mathfrak{so}(n)$ sits at or above the cap:**

$$\mathfrak{so}(p)\oplus\mathfrak{so}(q):\quad r-\tfrac{n(n-2)}4=\tfrac{(p-q)^2}4\ \ge0,\qquad \mathfrak u(m)\subset\mathfrak{so}(2m):\quad r-\tfrac{n(n-2)}4=m>0,$$

with equality only at the balanced split. Verified for every symmetric subalgebra at every even $n\le20$. So $\{S=0\}$ forces $r\ge$ cap from the Lie theory while Lemma L23's sum-of-squares forces $r\le$ cap from criticality, and the two pinch. This is a cleaner statement of what the collapse is: **two inequalities of opposite sign meeting, not one formula having a root.**

### Is there a point in the family with $S_{\mathfrak{mmm}}=0$ and $\theta<\theta_0(n)$?

**No, and the reason is worth recording, because the danger runs the other way.** By the pinch above, $S=0$ inside the family forces $r=$ cap and $\theta=\theta_0$ exactly. What sits at $S_{\mathfrak{mmm}}=0$ off criticality is *above* $\theta_0$, not below: $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$ would give $1.231530$ and $\mathfrak u(4)\subset\mathfrak{so}(8)$ would give $1.527525$, both against $\theta_0(8)=1.145644$. They are excluded by criticality alone, measured $\lVert\mathrm{Ric}\rVert_\infty=0.47$ and criticality residual $1.1\times10^{-1}$, and Lemma L23's own $S_{\mathfrak{mmm}}$ formula refuses them by returning $-15$, a negative value for a sum of squares. **So criticality is load-bearing in the collapse and the record's statement of it should not be read as a fact about subalgebras alone.**

### One assertion in the reach paragraph that is asserted rather than shown, and does not matter

"The subalgebra family is exactly the two-eigenvalue points." The inclusion that the argument uses ($W_{\mathfrak h}$ has two eigenvalues) is immediate. The converse (a two-eigenvalue critical point has $E_+$ a subalgebra), is not shown anywhere I could find, and if it failed the family would be *smaller*, so the "much smaller than the graded points" conclusion is safe either way.

**Unasked finding:** $E_+$ being a subalgebra is *not* what distinguishes the family. I measured the leak $\lVert\Pi_{E_+^\perp}[E_+,E_+]\rVert^2$ and it is zero not only at the two-eigenvalue points ($S^4\times S^4$, $\mathfrak{so}(3)^{\oplus3}$) but also at three-eigenvalue points outside the family: $1.4\times10^{-14}$ of a total $66.0$ at $S^3\times S^5$, and of $48.0$ at $\mathbb{CP}^3$. The eigenvalue **count** is the characteristic, not closure of $E_+$ under bracket.

---

## P2, post F40: the counterexamples stand, and no repair in $\dim E_+$ can exist

**Verdict: the negative claim is CONFIRMED. One supporting sentence is REFUTED. The repair question is answered, and the answer is that the only surviving repair is a bound the record has already closed.**

### The counterexamples reproduce exactly

| point | $n$ | $\theta$ | $r=\dim E_+$ | $\ker W$ | bound $\frac2n\sqrt{rN/(N-r)}$ | holds |
|---|---|---|---|---|---|---|
| $W_{\mathbb{CP}^2}$ | 4 | 1.224745 | 1 | 3 of 6 | 0.547723 | **no** |
| padded $W_{\mathbb{CP}^2}$ | 8 | 1.224745 | 1 | 25 of 28 | 0.254588 | **no** |
| padded $W_{\mathbb{CP}^2}$ | 10 | 1.224745 | 1 | 42 of 45 | 0.202260 | **no** |
| padded $W_{\mathbb{CP}^2}$ | 12 | 1.224745 | 1 | 63 of 66 | 0.167944 | **no** |
| $S^3\times S^5$ | 8 | 1.115547 | 13 | 0 | 1.231530 | yes |
| $S^5\times S^7$ | 12 | 1.228239 | 31 | 0 | 1.274288 | yes |
| $S^4\times S^4$ | 8 | 1.145644 | 12 | 0 | 1.145644 | equality |

All at criticality residual $\le1.6\times10^{-14}$. The record's four figures, $1.224745$, $0.254588$, $0.167944$, $0.548$, are all confirmed.

### The strongest fact here: the bound has the wrong monotonicity in $n$, so **every** critical point is a counterexample once padded far enough

Zero-padding $W\in\mathrm{Weyl}_{n_0}$ into $\mathrm{Weyl}_n$ preserves criticality, $\theta$ and $\dim E_+$ exactly (I measured the criticality residual unchanged to the digit across each row below) while the proposed bound behaves like $\tfrac2n\sqrt r$ and decays to $0$.

| seed | $n_0$ | $\theta$ | $r$ | bound at $n_0$ | at $n_0{+}2$ | at $n_0{+}4$ | at $n_0{+}6$ |
|---|---|---|---|---|---|---|---|
| $S^3\times S^3$ | 6 | 1.054093 | 6 | 1.054093 (=) | 0.690849 | 0.526235 | 0.428174 |
| $S^4\times S^4$ | 8 | 1.145644 | 12 | 1.145644 (=) | 0.809040 | 0.638285 | 0.531129 |
| $\mathbb{CP}^3$ | 6 | 1.054093 | 9 | 1.581139 | 0.910465 | 0.670820 | 0.538028 |
| $\mathbb{CP}^2$ | 4 | 1.224745 | 1 | 0.547723 | 0.345033 | 0.254588 | 0.202260 |

**So this is not a fact about $\mathbb{CP}^2$ and not even a fact about the kernel.** Padding is $\theta$- and $r$-preserving and $n$-raising, so any valid bound $f_n(\dim E_+)$ must be **non-decreasing in $n$ at fixed $r$**; the proposed one is asymptotically $\tfrac2n\sqrt r$, strictly decreasing. Every critical point on the catalogue, the balanced sphere products included, breaks it at large enough $n$, $S^4\times S^4$ already at $n=10$. The record's "$\dim E_+$ then measures the support rather than the space" is pointing at this and stops one step short of it.

### And "so padding is not the cause" is too strong

**Every zero-padding of every critical point I tested breaks the bound**, not just $\mathbb{CP}^2$'s:

| padded point | $n$ | $\theta$ | $r$ | $\ker$ | bound | holds |
|---|---|---|---|---|---|---|
| $S^2\times S^2\hookrightarrow n{=}6$ | 6 | 0.866025 | 2 | 9 of 15 | 0.506370 | **no** |
| $S^2\times S^2\hookrightarrow n{=}8$ | 8 | 0.866025 | 2 | 22 of 28 | 0.366900 | **no** |
| $S^3\times S^3\hookrightarrow n{=}8$ | 8 | 1.054093 | 6 | 13 of 28 | 0.690849 | **no** |
| $S^3\times S^3\hookrightarrow n{=}10$ | 10 | 1.054093 | 6 | 30 of 45 | 0.526235 | **no** |
| $S^4\times S^4\hookrightarrow n{=}12$ | 12 | 1.145644 | 12 | 38 of 66 | 0.638285 | **no** |

So padding **is** a sufficient cause, and a completely generic one; $W_{\mathbb{CP}^2}$ at $n=4$ shows only that it is not the *only* cause, since a kernel can arise without it. The common factor across every counterexample is $\ker W\ne0$, but by the monotonicity argument above that is a *symptom*: the kernel is how a point built in $\mathrm{Weyl}_{n_0}$ comes to be read with the $n$ and $N$ of a larger space.

### The anatomy: post F40's bound is $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ with a linear-algebra step bolted on

On the subalgebra family, $\lambda_{\min}=-\tfrac rNc=-\sqrt{r/(N(N-r))}$ and $N=\tfrac{n(n-1)}2$, so

$$\frac2n\sqrt{\frac{rN}{N-r}}\;=\;(n-1)\sqrt{\frac{r}{N(N-r)}}\;=\;(n-1)\lvert\lambda_{\min}\rvert\qquad\text{identically.}$$

Confirmed to $10^{-9}$ at every family member. So the proposed extension factors into two independent claims:

1. **$\theta\le(n-1)\lvert\lambda_{\min}\rvert$.** This is **true at every critical point, kernel or not**, and it is the record's own $\Pi$-bound from [bounds.md](../findings/bounds.md). Rebuilt from scratch here: with $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2\ge0$ I measure $\sum_\gamma g_\gamma=4(n-1)$ exactly on $\mathrm{Weyl}_6$ and $\mathrm{Weyl}_8$ (at critical *and* non-critical points) and $4\theta=\sum_{\mathfrak m}\lvert\lambda_\gamma\rvert g_\gamma-\sum_{\mathfrak p}\lambda_\gamma g_\gamma$ to $10^{-15}$ at twelve points. Bounding $\lvert\lambda_\gamma\rvert\le\lvert\lambda_{\min}\rvert$ and dropping the second (non-negative) sum gives it in two lines. Kernel directions contribute $0$ to both sides, which is why the kernel cannot break it.
2. **$\lvert\lambda_{\min}\rvert\le\sqrt{r/(N(N-r))}$ with $r=\dim E_+$.** This is a statement about traceless unit-norm symmetric matrices with no curvature in it at all, and it is **false as soon as $W$ has a kernel**, because $N-r$ then counts kernel directions as negative ones. At $W_{\mathbb{CP}^2}$, $\lvert\lambda_{\min}\rvert=1/\sqrt6=0.408248$ against $\sqrt{1/30}=0.182574$.

**The whole failure is in step 2, and step 2 is not a fact about curvature.**

### Repairs, tested

| candidate | verdict |
|---|---|
| $N\to\mathop{\mathrm{rank}}W$ | **fails.** $\frac2n\sqrt{r\,s/(s-r)}$, $s=r_++r_-$: $0.612372$ at $\mathbb{CP}^2$ ($n{=}4$), $0.306186$ at $n{=}8$, against $\theta=1.224745$. Also fails at every padded sphere product. |
| $r\to N-\dim E_-$ | **valid on the catalogue but vacuous.** It agrees with post F40 on the family, and off it the kernel joins $r$, giving $7.659417$ at padded $W_{\mathbb{CP}^2}$, $n{=}12$. |
| any $\theta\le f(\dim E_+)$ | **impossible**, proved below. |
| restrict to $\ker W=0$ | **survives every test, and is empty of content**, see below. |
| $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ | **holds, is a theorem, and is already closed in the record as a tautology.** |

**What any bound $f_n(\dim E_+)$ must satisfy, and what that kills.** By padding, $f_n(r)\ge\sup\{\theta:\ W\in\mathrm{Weyl}_{n_0},\ n_0\le n,\ \dim E_+(W)=r\}$, so $f_n$ is non-decreasing in $n$, which alone rules out Lemma L23's shape and every rescaling of it that keeps the $\tfrac2n$ prefactor, the rank normalisation included. It also forces $f_n(1)\ge\sqrt{3/2}=1.224745$ at every $n\ge4$, against Lemma L23's $f_n(1)=\tfrac2n\sqrt{N/(N-1)}=0.167944$ at $n=12$. For $n\le11$ that is already fatal to usefulness, since $\sqrt{3/2}>\theta_0(n)$ there. **Post F40's note that "the rank is the candidate replacement and is untested" should be closed: rank is tested here and fails, and the monotonicity argument closes the whole shape.** *What is not closed, and I say so rather than overclaim:* for $n\ge12$ a bound $f_n(r)$ with $f_n(1)=\sqrt{3/2}<\theta_0(n)$ is not excluded by anything I found, it would just have nothing to do with Lemma L23.

**The $\ker W=0$ restriction survives, and says nothing.** I found no counterexample: not on the catalogue, not in a targeted hunt maximising $\theta$ subject to $\dim E_+\le5$ and $\le3$ ($n{=}6$) and $\le11$ ($n{=}8$), which converged to padded $W_{\mathbb{CP}^2}$ on every one of $73$ starts, that is, the hunt for a low-$\dim E_+$ high-$\theta$ point *produces a kernel* rather than a counterexample. Two facts make the survival hollow:

- The bound is below $\theta_0(n)$ exactly when $r<n(n-2)/4$, the same cap. At every $\ker W=0$ catalogued point **outside** the family, $r\ge$ cap, so the bound sits above $\theta_0(n)$ and asserts strictly less than Conjecture A: $1.231530$ at $S^3\times S^5$, $1.274288$ at $S^5\times S^7$, $1.581139$ at $\mathbb{CP}^3$, $1.527525$ at $\mathbb{CP}^4$ and $S^2\times S^6$.
- Where it does bite (inside the family), it is an equality, i.e. Lemma L23 itself.

So "it holds at every catalogued point with trivial kernel" is true and carries no information: it is either an equality or weaker than the conjecture, at every point tested.

**And the mechanism behind the positive half is a property of the catalogue, not a theorem.** At every padding-free catalogued point I measured $\theta=(n-1)\lvert\lambda_{\min}\rvert$ **exactly**, ratio $1.000000000$ at all eleven sphere products, at $\mathbb{CP}^{3,4,5}$, and at every Casimir member. At $33$ generic critical points at $n=6$ with $\ker W=0$ and $\dim E_+\in\{4,\dots,7\}$, produced by a constrained solve rather than picked from a list, the same ratio runs $0.0861$ to $0.4108$ and reaches $1$ **never**. So the equality is a property of the high-$\theta$ symmetric points, which is what [bounds.md](../findings/bounds.md) already says about $\Pi/4=\theta$, and post F40's positive half inherits its truth from that equality plus a flatness fact about the negative spectrum, not from any general mechanism. Those $33$ points also violate nothing: $\theta$ there runs $0.132$ to $0.582$ against bounds of $0.79$ to $1.29$.

### What is worth keeping

**Lemma L23's cap is the $\Pi$-tautology restricted to the two-eigenvalue points.** That single sentence explains both halves of post F40 at once: why the bound is exactly saturated at the balanced sphere products (there $\Pi/4=\theta$, and $r$ determines $\lambda_{\min}$), and why the extension cannot travel (off two eigenvalues, $r$ stops determining $\lambda_{\min}$). It also says the honest thing about the repair: the only version that survives is $\theta\le(n-1)\lvert\lambda_{\min}\rvert$, which [bounds.md](../findings/bounds.md) has already closed as "the target restated". **Closing post F40's route costs nothing, because the route was the closed one wearing a dimension.**

---

## P3, the kernel synthesis

### (a) the gradedness screen goes vacuous, **CONFIRMED**

At padded $W_{\mathbb{CP}^2}$ all four traces over $E_\pm$ are exactly zero while the splitting spans almost nothing:

| $n$ | $\dim\mathfrak{so}(n)$ | $\dim E_+$ | $\dim E_-$ | $\ker$ | $S_{\mathfrak{mmm}}$ | $S_{\mathfrak{mpp}}$ | $S_{\mathfrak{ppm}}$ | $S_{\mathfrak{ppp}}$ |
|---|---|---|---|---|---|---|---|---|
| 4 | 6 | 1 | 2 | 3 | 0 | 0 | 0 | 0 |
| 8 | 28 | 1 | 2 | 25 | 0 | 0 | 0 | 0 |
| 10 | 45 | 1 | 2 | 42 | 0 | 0 | 0 | 0 |
| 12 | 66 | 1 | 2 | 63 | 0 | 0 | 0 | 0 |

The screen reports on three dimensions of a sixty-six-dimensional algebra. Exact zeros, not small ones, there is nothing in the sum to be nonzero.

### (b) sense (C) does not imply sense (A) at $W_{\mathbb{CP}^2}$, $n=4$, **CONFIRMED**

$W_{\mathbb{CP}^2}$ commutes with $\mathrm{Ad}(J)$ to $0.0$ exactly, where $J$ is the standard complex structure on $\mathbb R^4$; $\mathrm{Ad}(J)$ has eigenvalues $(+1)^4,(-1)^2$, its fixed set is $\mathfrak u(2)$, and the off-diagonal block of $W$ across that splitting is $0.0$. So (C) holds for the symmetric pair $(\mathfrak{so}(4),\mathfrak u(2))$. Meanwhile $\dim E_+\oplus E_-=1+2=3<6=\dim\mathfrak{so}(4)$, so (A) fails on a dimension count alone. Kernel $3$ of $6$, as claimed.

### (c) "$\Delta=0\Rightarrow\mathrm{ad}(\mathfrak p)$-equivariant", **the substance is CONFIRMED, the statement is REFUTED twice**

*First correction.* $\Delta=\sum_{\gamma\in E_+}\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$, so "$\Delta=0\Rightarrow\mathrm{ad}(E_+)\subseteq\mathfrak k(W)$" is **true by definition** and cannot be unsound anywhere. What is unsound off $\ker W=0$ is the step *after* it in [bounds.md](../findings/bounds.md), identifying $\mathfrak p=E_+$ with the isotropy of a symmetric pair and applying Schur. At padded $W_{\mathbb{CP}^2}$ that step has nothing to work with: $\dim E_+=1$.

*Second correction, and it moves the diagnosis.* "Equivariant for no symmetric subalgebra" is **false at the unpadded $W_{\mathbb{CP}^2}$**. I computed the full symmetry algebra $\mathfrak k(W)=\{x:[\mathrm{ad}(x),W]=0\}$ by singular values: at $n=4$ it has dimension **4 and equals $\mathfrak u(2)$**, I verified $\max_{x\in\mathfrak u(2)}\lVert[\mathrm{ad}(x),W]\rVert=1.8\times10^{-17}$, and $(\mathfrak{so}(4),\mathfrak u(2))$ *is* a symmetric pair. The claim only becomes true after padding: $\dim\mathfrak k(W)=10,19,32$ at $n=8,10,12$, matching $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$ exactly, which is not a symmetric subalgebra of $\mathfrak{so}(n)$. At $n=8,10$ a dimension count settles it (the smallest symmetric subalgebras are $\mathfrak{so}(4)^{\oplus2}$ at $12$ and $\mathfrak{so}(5)^{\oplus2}$ at $20$, both larger); at $n=12$ it does **not** ($\mathfrak{so}(6)^{\oplus2}$ has dimension $30\le32$) and one needs the structure: $\mathfrak{so}(8)$ contains no two commuting $\mathfrak{so}(6)$'s, and the remaining $\mathfrak u(2)$ is $4$-dimensional, so neither $\mathfrak{so}(6)^{\oplus2}$ nor $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ embeds in $\mathfrak u(2)\oplus\mathfrak{so}(8)$. *That gap in the $n=12$ argument is worth recording: the record's phrasing invites a dimension count that does not close.*

**So (c)'s discriminating variable is padding, not the kernel.** The $n=4$ point carries a kernel of $3$ in $6$ and satisfies the property the padded points violate.

### (d) post F40's bound breaks there, **CONFIRMED as a failure, but the cause is not the kernel**

Established in P2: written as $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ the statement holds at every critical point including all the kernel-carrying ones. The kernel is a sufficient way to break the *substitution* $\lvert\lambda_{\min}\rvert\to\sqrt{r/(N(N-r))}$, not the reason the bound is wrong.

### The synthesis, tested as a claim, **REFUTED as stated; a sharper reading offered**

**Two of the four are the same fact, and it is a definition rather than a discovery.** Sense (A) sign-gradedness *asks* that $E_+\oplus E_-=\mathfrak{so}(n)$; the $E_\pm$-only screen sums over the same span. "$\ker W\ne0$" and "the sign splitting does not span" are the same statement written twice. So (a) and (b) are one observation, not two corroborations, and calling it a *cause* overstates it: it is what sense (A) means.

**The other two have different discriminating variables.** (c) separates on padding, the unpadded $W_{\mathbb{CP}^2}$ has a kernel and satisfies the claim. (d) separates on a dimension standing in for an eigenvalue, repair that and the kernel is harmless.

**The sharpest common cause I can defend, covering all four:** every one of the four instruments reads $W$ through $E_+$ alone or through $E_+\oplus E_-$, and at $W_{\mathbb{CP}^2}$ those are **one** and **three** dimensions of an algebra of dimension up to $66$. Whether the missing dimensions get called the kernel (a, b), padding (c), or a dimension standing in for an eigenvalue (d) is a property of the instrument, not of the point. Stated as a rule a successor can use:

> An instrument that quantifies over $E_+$ or $E_+\oplus E_-$ owes a hypothesis on $\dim E_+$ (or $\dim E_+ +\dim E_-$) relative to $N$, not on the kernel. The two coincide at $W_{\mathbb{CP}^2}$ and would part company at a trivial-kernel point with $\dim E_+=1$, which nothing on the catalogue rules out.

That is a strictly stronger rule than "state your behaviour on the kernel", because it also catches (c) and (d), which the kernel version does not.

**One clause of the synthesis needs narrowing.** "All four were invisible while the record worked with sphere products, which have $\ker W=0$" is true of sphere products (I verified $\ker W=0$ at all eleven I built) but the kernel-free part of the catalogue is wider than that: $\mathbb{CP}^3,\mathbb{CP}^4,\mathbb{CP}^5$ all have $\ker W=0$ ($r_++r_-=N$), as do all the Casimir members. The single kernel-carrying family on the catalogue is $\mathbb{CP}^2$ and its paddings.

---

## Found while auditing, not asked about

- **$\theta$ collides across families at $n=8$**: $\theta(\mathbb{CP}^4)=\theta(S^2\times S^6)=0.986013$ exactly, with the same $(\dim E_+,\dim E_-)=(16,12)$; and $\theta(\mathbb{CP}^3)=\theta(S^3\times S^3)=\theta_0(6)$. The record carries the second; I did not find the first. Both points are critical at $\le1.5\times10^{-15}$ and their $S_{\mathfrak{mmm}}(E_-)$ differ ($4.1\times10^{-29}$ vs $7.3\times10^{-29}$, both zero), so this is a value coincidence needing a check against [Reviewer 111](REVIEW_r111.md)'s "isospectral $\ne$ same orbit" warning before either is treated as the other.
- **$\perp$-sums are critical iff the summands share $\theta$.** For $W=W_1\oplus W_2$ on $\mathbb R^{n_1}\oplus\mathbb R^{n_2}$, the mixed block of $W^\#$ vanishes identically because $[\Lambda^2\mathbb R^{n_1},\Lambda^2\mathbb R^{n_2}]=0$, so $Q(W)=\theta W$ reduces to the two block equations with a common $\theta$. Every such point has $\ker W\supseteq\mathbb R^{n_1}\otimes\mathbb R^{n_2}$, which is why the $\perp$-sum construction can never supply the trivial-kernel witness P2 wants.
- **$\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2$ holds on all of $\mathrm{Weyl}_n$, not only at critical points**, measured $20.00000$ at $n=6$ and $28.00000$ at $n=8$ on random non-critical Weyl tensors. [bounds.md](../findings/bounds.md) says "constant on $\mathcal W_n$"; this confirms it independently and is worth having, since the $\Pi$-bound's proof uses only that plus $g\ge0$ plus the $-4\theta$ identity.
