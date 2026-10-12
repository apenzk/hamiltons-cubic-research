### Reviewer 290: the shared-frame majorization coupling of the two curvature spectra

Reviewer 290, adversarial referee. Primary file under review: [findings/bispectral.md](../findings/bispectral.md), section *"The shared-frame majorization coupling"*. Supporting: [findings/fence-posts.md](../findings/fence-posts.md) post F33, [references/nienhaus-petersen-wink-2022-betti-second-kind/README.md](../references/nienhaus-petersen-wink-2022-betti-second-kind/README.md), [scripts/runs/run_secondkind_sign.py](../scripts/runs/run_secondkind_sign.py), [scripts/weyl.py](../scripts/weyl.py).

**Every number below comes from my own code**, my own Weyl projector, my own $\mathbb{CP}^2$ and product-sphere tensors, my own $\mathring W$, my own frame optimiser, in [scripts/reviewers/r290/](../scripts/reviewers/r290/). [run_f2_majorization.py](../scripts/runs/run_f2_majorization.py) was never imported and never run. $\theta$ is computed from the Dai–Fu contractions $\theta=\alpha/8+\beta/2$, independently of the bi-spectral identity, and the identity is then used only as a cross-check on my pipeline (agreement $\le5\times10^{-15}$ at all seven test points).

| # | Claim | Verdict |
|---|---|---|
| C1 | Both operators carry $W_{ijij}$ on their diagonals in any frame | **CONFIRMED**, by argument and by computation, and the index convention is consistent: Li's $W_{iklj}$ makes $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=+W_{ijij}$ *and* $\operatorname{tr}(\mathring W^3)=\tfrac{\alpha}8-\beta$ *and* the $-\tfrac12$, all three together |
| C2 | $K\prec\mu$ and $K'\prec\omega$ | **CONFIRMED**, with two corrections: only **Schur's** half is used, not Horn's; and $K'$ is not a function of the frame alone, the $\psi$ block carries a further $O(n-1)$ of freedom that moves the bound by $0.61$ at padded $\mathbb{CP}^2$ |
| C3 | The two convexity repairs and the resulting bound | **CONFIRMED** as stated. Both convexity domains, both majorization directions and the resulting inequality are correct; the equality cases are strict. $m$ and $M_+$ read off the true spectra are the *tightest admissible* constants, so the measured numbers are the best case, as claimed |
| C4 | slack $=\tfrac92M_+\lVert M_{\rm off}\rVert^2+\tfrac32m\lVert\mathring W_{\rm off}\rVert^2$ | **REFUTED.** The formula drops $\tfrac32(p_3(K)-p_3(\mu))+\tfrac12(p_3(\omega)-p_3(K'))$, which is $-0.918559$ at padded $\mathbb{CP}^2$ and changes sign on random tensors. True gap there is $2.755676$; the formula returns $3.674235$. The *corollary* (exact iff both operators are diagonal in one shared frame), **survives**, by the strict equality case of Karamata |
| C5 | The measurements | **PLAUSIBLE, with one number mislabelled and one qualification missing.** $\theta=\sqrt{3/2}$, off-masses $\tfrac12$ and $\tfrac32$, bound $3.980421$, exactness at the three products: all reproduced exactly. But "slack $3.674$ **and** a bound of $3.980$" cannot both stand, $1.2247+3.674=4.899$. And the off-masses are **frame-dependent**: a random frame at $n=8$ gives $0.929$ and $2.788$, bound $6.842$. My frame optimiser reaches $2.4$–$3.0\,\theta_0$ on random Weyl tensors, not the $3.0$–$3.8$ reported |
| C6 | "Does not clear post F33" | **REFUTED as stated, and the truth is worse for the route.** The coupling **does** supply information of exactly the kind post F33 demands, it is exact on the diagonal family, where no moment-plus-support bound can be. What it does not do is *help*: at padded $\mathbb{CP}^2$ the one-line bound $\tfrac32(M_++m)=2.4495$ and **post F33's own moment bound $2.3779$ both beat the majorization bound $3.9804$**, and on random Weyl tensors post F33 beats it by a factor $3.5$–$5$ |

---

## The test points, and the check that my pipeline is the record's

Seven points, all built from scratch. Padded $W_{\mathbb{CP}^2}$: the Fubini–Study algebraic curvature tensor $R_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}+J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl}$ on a $4$-block, Weyl-projected in $\mathbb R^4$, then padded by zeros, which stays a Weyl tensor at every $n$, since the padded Ricci contraction vanishes. Products $S^p\times S^q$ at Einstein radii, $(p-1)c_1=(q-1)c_2$. Normalisation throughout: $\lVert M\rVert_F=1$, $M_{(ij),(kl)}=W_{ijkl}$ over $i<j$, $k<l$.

| point | $\theta$ (from $\alpha/8+\beta/2$) | $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ | $\theta_0(n)$ |
|---|---|---|---|
| padded $\mathbb{CP}^2$, $n=4,5,6,8,12,16,24$ | $1.224744871$ at every $n$ | agrees to $\le1.3\times10^{-15}$ |, |
| $S^4\times S^4$ | $1.145643924$ | agrees to $4.4\times10^{-16}$ | $1.145643924$ |
| $S^6\times S^6$ | $1.236033081$ | agrees to $1.3\times10^{-15}$ | $1.236033081$ |
| $S^5\times S^7$ | $1.228239158$ | agrees to $5.1\times10^{-15}$ | $1.236033081$ |

$\sum\mu=0$, $\sum\mu^2=1$, $\sum\omega=0$, $\sum\omega^2=3$ hold to $10^{-15}$ at all seven. The two extremal products land on $\theta_0$ to twelve digits. My pipeline is the record's.

---

## C1, CONFIRMED, and the two conventions are locked together

**By argument.** With $h=\varphi_{ij}$, $h_{kl}=(\delta_{ki}\delta_{lj}+\delta_{kj}\delta_{li})/\sqrt2$, Li's $(\mathring Wh)_{ab}=\sum_{k,l}W_{aklb}h_{kl}$ gives

$$\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=\tfrac12\big(W_{iijj}+W_{ijij}+W_{jiji}+W_{jjii}\big)=\tfrac12\big(0+W_{ijij}+W_{ijij}+0\big)=W_{ijij},$$

the outer terms vanishing by antisymmetry in the first pair. The other half is a definition: $M_{(ij),(ij)}=W_{ijij}$ by construction of $M$. Both hold in **every** orthonormal frame, since nothing in the computation used a choice of frame. This is [Nienhaus–Petersen–Wink Prop 3.10](../references/nienhaus-petersen-wink-2022-betti-second-kind/README.md) and it is right.

**The trap the brief points at does not fire.** The worry is that the index order fixing the $-\tfrac12$ might be the order that *negates* the $\varphi$-diagonal. It is not, the two flip together. Recomputed at $n=6,7$ on random Weyl tensors, my own screen:

| order | $\varphi$-diagonal | $\operatorname{tr}(\mathring W^3)$ | the identity |
|---|---|---|---|
| $W_{iklj}$ (Li) | $+W_{ijij}$, residual $1.4\times10^{-17}$ | $=\tfrac{\alpha}8-\beta$ | $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ |
| $W_{ikjl}$ | $-W_{ijij}$, residual $1.4\times10^{-17}$ | $=\beta-\tfrac{\alpha}8$ | $\theta=\tfrac32p_3(\mu)+\tfrac12p_3(\omega)$ |

Both orders give a symmetric operator with $\operatorname{tr}(\mathring W^2)=3$; the sign flip is a global $\mathring W\mapsto-\mathring W$, so it inverts the cubic term and the diagonal in step. **Li's convention makes both halves of C1 true simultaneously and the $-\tfrac12$ correct.** C1 is CONFIRMED by argument and by computation.

## C2, CONFIRMED, with two corrections

**The mathematics is right.** $\{\varphi_{ij}\}_{i<j}$ is orthonormal in $\langle h,h'\rangle=\operatorname{tr}(hh')$ and traceless; its orthogonal complement inside $S^2_0$ is the traceless *diagonal* matrices, of dimension $n-1$, so $\binom n2+(n-1)=\tfrac{n(n+1)}2-1=\dim S^2_0$ and $\{\varphi_{ij},\psi_k\}$ is a genuine orthonormal basis. $\mathring W$ maps $S^2\to S^2_0$ and kills $g$ on a Weyl tensor, and it is self-adjoint (asymmetry $2.8\times10^{-17}$ in my build). So $K'$ is the full diagonal of a symmetric operator in an orthonormal basis and $K'\prec\omega$; identically $K\prec\mu$. Verified numerically, all partial sums, at every test point and on random tensors in random frames.

**Correction 1: this is Schur's theorem, not Schur–Horn.** Only the necessity half (diagonal $\prec$ spectrum) is used. Horn's converse would be needed to *realise* a prescribed diagonal, which the argument never does. A small thing, but the record should name the theorem it uses.

**Correction 2, and this one has teeth: $K'$ is not determined by the frame.** $K$ is. $K'$ is not: its last $n-1$ entries are the diagonal of $\mathring W$ restricted to the $\psi$ block in whatever orthonormal basis of the traceless diagonals one picks, and different picks give different bounds. At padded $\mathbb{CP}^2$, $n=8$: the Gram–Schmidt basis $e_{11}-e_{22},\dots$ gives bound $4.592793$; the eigenbasis of the block gives $3.980421$. The record's C5 uses the second and calls it "the only basis freedom left", which is a statement of *freedom*, not of *optimality*.

**The freedom is in fact optimally used, and that is provable.** The $d$-dependence of the bound is exactly $-\tfrac12[p_3(d)+3m\,p_2(d)]=-\tfrac12\sum f(d_a)$ with $f(t)=t^3+3mt^2$ convex on $[-m,\infty)$. Schur–Horn (here the *Horn* half is what applies) says the achievable $d$ are exactly those with $d\prec\operatorname{spec}(B)$ for $B$ the $\psi$ block, and Karamata maximises $\sum f(d)$ over that set at $d=\operatorname{spec}(B)$. So diagonalising the $\psi$ block minimises the bound. **This is a correction that strengthens the record**, and it should be recorded, because as written a reader cannot tell whether the reported $3.980$ is the best or an arbitrary member of a family.

## C3, CONFIRMED as stated

Derived independently, in both directions.

- $g(t)=t^3-3M_+t^2$ has $g''(t)=6(t-M_+)\le0$ on $(-\infty,M_+]$, so $g$ is **concave** there and strictly so on the interior. $K\prec\mu$ with $g$ concave gives $\sum g(K)\ge\sum g(\mu)$, i.e. $p_3(K)-3M_+p_2(K)\ge p_3(\mu)-3M_+$, i.e. $p_3(\mu)\le p_3(K)+3M_+(1-p_2(K))$. **Direction correct.**
- $f(t)=t^3+3mt^2$ has $f''(t)=6(t+m)\ge0$ on $[-m,\infty)$, so $f$ is **convex** there. $K'\prec\omega$ gives $\sum f(K')\le\sum f(\omega)$, i.e. $p_3(\omega)\ge p_3(K')+3m(p_2(K')-3)$. **Direction correct.**
- The domain hypotheses are automatic: a diagonal entry of a symmetric operator lies between its extreme eigenvalues, so $K_a\le\max\mu=M_+$ and $K'_a\ge\min\omega=-m$ with no extra assumption.

Numerically, over $40$ random Weyl tensors at $n=5,6,7$ each in a random frame, both one-sided slacks $S_1=p_3(K)+3M_+(1-p_2(K))-p_3(\mu)$ and $S_2=p_3(\omega)-p_3(K')-3m(p_2(K')-3)$ are non-negative: **zero violations**.

**On whether $m$ and $M_+$ "smuggle in the answer".** They are read off the true spectra, so the bound is *a posteriori*, and the record says so. Two observations. First, this is genuinely the most favourable choice: the penalty terms grow in both constants, and $M_+\ge\max\mu$, $m\ge-\min\omega$ are forced by the convexity domains, so no admissible constants are smaller. Second, that is what makes the measured numbers damning rather than merely suggestive, the bound is being scored under maximal charity and still loses a factor $3.2$.

**One structural remark the record does not make, and should.** Expanding the bound, the $\varphi$-block cubic appears as $\tfrac32p_3(K)-\tfrac12p_3(K)=p_3(K)$. **The coupling is precisely the collapse of that coefficient from $\tfrac32$ to $1$.** Everything else in the bound is two independent one-spectrum estimates. That single number is the entire content of "shared frame", and it is worth stating explicitly, because it also shows how little the coupling buys.

## C4, REFUTED as a closed form; the corollary survives

**The correct identity.** With $S_1,S_2\ge0$ as above,

$$\text{bound}-\theta=\tfrac32S_1+\tfrac12S_2=\underbrace{\tfrac92M_+\lVert M_{\rm off}\rVert_F^2+\tfrac32m\lVert\mathring W_{\rm off}\rVert_F^2}_{\text{the two penalty terms}}+\underbrace{\tfrac32\big(p_3(K)-p_3(\mu)\big)+\tfrac12\big(p_3(\omega)-p_3(K')\big)}_{\textbf{dropped by the claim}}.$$

The claim keeps the first bracket and discards the second. There is no reason for the second to vanish: majorization $K\prec\mu$ places no sign constraint whatever on $p_3(K)-p_3(\mu)$, that is the very fact C3 opens with.

**Measured, at padded $W_{\mathbb{CP}^2}$, identically at $n=4,6,8,12,16$:**

| quantity | value |
|---|---|
| $\theta$ | $1.224745$ |
| bound | $3.980421$ |
| **true gap, bound $-\theta$** | $\mathbf{2.755676}$ |
| **claimed closed form $\tfrac92M_+\lVert M_{\rm off}\rVert^2+\tfrac32m\lVert\mathring W_{\rm off}\rVert^2$** | $\mathbf{3.674235}$ |
| $\tfrac32(p_3(K)-p_3(\mu))$ | $-0.459279$ |
| $\tfrac12(p_3(\omega)-p_3(K'))$ | $-0.459279$ |

The discrepancy is $0.918559$, a third of the true gap. **And the error is not one-signed**: over $60$ random Weyl tensors at $n=5,6,7$ in random frames, the claimed formula minus the true gap runs from $-0.3499$ to $+0.3836$. So the claimed expression is neither the gap, nor an upper bound on it, nor a lower bound.

**What survives, and it is the part the route actually uses.** *The bound is exact iff both operators are diagonal in one shared frame* is **true**, and provable without the false closed form. $\text{bound}=\theta$ forces $S_1=S_2=0$ separately, since each is individually non-negative. By Rado, $K$ lies in the convex hull of the permutations of $\mu$; $g$ is strictly concave on $(-\infty,M_+]$ and affine on no non-degenerate subinterval, so $\sum g(K)=\sum g(\mu)$ forces $K$ to be a permutation of $\mu$, Karamata's equality case. Then $p_2(K)=p_2(\mu)=1=\lVert M\rVert_F^2$, so the off-diagonal mass vanishes and $M$ is diagonal in that frame. Identically for $\mathring W$ with the strictly convex $f$ on $[-m,\infty)$. Conversely a shared diagonalising frame gives $K=\mu$, $K'=\omega$ and both slacks zero. **The "iff" is sound; only the closed form is wrong.**

**Fix for [findings/bispectral.md](../findings/bispectral.md).** The sentence *"the two penalty terms are exactly $\text{slack}=\dots$"* should read *"the two penalty terms are exactly $\tfrac92M_+\lVert M_{\rm off}\rVert^2+\tfrac32m\lVert\mathring W_{\rm off}\rVert^2$; the full gap adds $\tfrac32(p_3(K)-p_3(\mu))+\tfrac12(p_3(\omega)-p_3(K'))$, which is $-0.918559$ at padded $\mathbb{CP}^2$ and of either sign in general."* The following sentence, *"the bound degrades linearly in the off-diagonal mass"*, then also needs care: it is a statement about two of four terms.

## C5, the measurements: reproduced, with one mislabel and one missing qualification

**Reproduced exactly, by my own route.**

- Exactness at $S^4\times S^4$, $S^6\times S^6$ and $S^5\times S^7$: bound $-\theta$ is $0$ to $10^{-16}$, both off-masses $0$ to $10^{-16}$. Both operators really are diagonal in the product frame.
- Padded $W_{\mathbb{CP}^2}$: $\lVert M_{\rm off}\rVert^2=0.500000$ and $\lVert\mathring W_{\rm off}\rVert^2=1.500000$, exactly half of each total mass, and **identical at $n=4,5,6,8,12,16,24$**, so the $n$-independence is confirmed. $M_+=m=0.816497$, bound $3.980421$, $\theta=\sqrt{3/2}=1.224745$. Ratio to $\theta_0(12)$: $3.220$, matching the reported "factor $\approx3.2$".

**Mislabel.** "giving slack $3.674$ and a bound of $3.980$" cannot both be true: $1.224745+3.674235=4.898980\ne3.980421$. $3.674235$ is the penalty sum of C4; the gap is $2.755676$. One of the two numbers must be relabelled, and by C4 it is the first.

**Missing qualification: the off-masses are frame-dependent quantities reported without their frame.** At $n=8$, five random frames give $\lVert M_{\rm off}\rVert^2\in[0.883,0.948]$, $\lVert\mathring W_{\rm off}\rVert^2\in[2.649,2.845]$ and bounds $6.517$–$6.976$. The values $\tfrac12$ and $\tfrac32$ belong to the $\mathbb{CP}^2$-adapted frame. Nelder–Mead over $O(n)$ from four starts at $n=6$ and $n=8$ failed to improve on $3.980421$, so the adapted frame is plausibly optimal, but the record asserts the numbers flatly and a reader will take them for frame-invariants. They are not.

**Not reproduced: the random-tensor range.** After frame optimisation my random Weyl tensors give $2.38$–$2.69\,\theta_0$ at $n=6,7,8$, against the reported $3.0$–$3.8$. My optimiser is crude, so it can only be finding *better* frames than the record's, never worse, the direction of the disagreement says the record's figure overstates the loss. It does not change any conclusion, but the interval as printed is not what I measure.

## C6, REFUTED as stated; the correct statement is a sharper negative

**The two readings the brief separates are genuinely different, and the record carries both, in contradiction with itself.** [findings/bispectral.md](../findings/bispectral.md) says in one paragraph *"This is a genuine third piece of information about $\omega$ in the sense post F33 demands"* and, as briefed to me, that it *"does not clear fence post F33"*. Only the first is defensible on the definitions.

**Why it is information of the demanded kind.** [Post F33](../findings/fence-posts.md) asks for *"a third piece of information about $\omega$ beyond its first two moments and a support bound"*. $K'\prec\omega$ is exactly that: it is not a function of $p_1(\omega)$, $p_2(\omega)$ and $\min\omega$, and the proof is that it is *sharp* at $S^6\times S^6$, where any bound built from those three ingredients alone is not, post F33's own optimum sits $0.777$ above $\theta_0$ there. So post F33's stated fence **is** cleared in kind.

**And it buys nothing, which is a different and worse finding.** I recomputed post F33's moment minimum from scratch, minimise $\sum x^3$ subject to $\sum x=0$, $\sum x^2=3$, $x_i\ge-m$ over $N=\tfrac{n(n+1)}2-1$ variables. The optimal configuration is $k$ atoms at $-m$ and the rest at $a=km/(N-k)$ with $km^2N=p_2(N-k)$, giving $p_3^{\min}=-km^3+(N-k)a^3$. My $k$-atom value agrees with post F33's published $9/(16mN)-3m/4$ to machine precision **once the normalisations are reconciled**, post F33 works at $\lvert W\rvert_{4\text{-tensor}}=1$ where $p_2(\omega)=\tfrac34$, this page at $\lVert M\rVert_F=1$ where $p_2(\omega)=3$, a factor $2$ in $W$ and $8$ in the cubic. Post F33's formula is sound; I flag the normalisation because a reader comparing the two pages directly will conclude, wrongly, that padded $\mathbb{CP}^2$ violates it.

Now compare the three lower bounds on $p_3(\omega)$ at padded $W_{\mathbb{CP}^2}$, $n=12$, all with the same charity ($m=0.816497$ read off the true spectrum):

| lower bound on $p_3(\omega)$ | value | gap to the true $p_3(\omega)=-1.224745$ |
|---|---|---|
| **majorization** $p_3(K')+3m(p_2(K')-3)$ | $-3.980421$ | $2.755676$ |
| trivial $-3m$ | $-2.449490$ | $1.224745$ |
| **post F33's moment problem** | $-2.306339$ | $1.081594$ |

And the resulting bounds on $\theta$ itself:

| bound on $\theta$ at padded $\mathbb{CP}^2$, $n=12$ | value | $/\theta_0(12)$ |
|---|---|---|
| majorization coupling | $3.980421$ | $3.220$ |
| one line: $\theta\le\tfrac32p_3(\mu)-\tfrac12p_3(\omega)\le\tfrac32M_++\tfrac32m$ | $2.449490$ | $1.982$ |
| post F33 style, $\tfrac32M_+-\tfrac12p_3^{\min}$ | $2.377915$ | $1.924$ |

**The new information makes the bound worse than the one-line estimate it was meant to improve on.** The one-line bound is $p_3(\mu)\le M_+p_2(\mu)=M_+$ and $p_3(\omega)\ge-m\,p_2(\omega)=-3m$, three lines of algebra using nothing but the support constants, and at the non-diagonal point that C6 correctly identifies as the whole remaining problem it beats the coupling by $1.63\times$. On random Weyl tensors the gap is larger still: at $n=6,8$, frame-optimised majorization gives $2.55$–$2.98$ while the one-line bound gives $1.30$–$1.78$ and post F33's gives $0.54$–$0.79$. **Post F33 wins every one of the six samples by a factor $3.5$–$5$.**

**The corrected statement for the record.** The coupling clears post F33's stated ask, it is a genuine third piece of information about $\omega$, and it is the *only* bound on the record that is exact at the conjectured maximiser. What it fails is a test post F33 did not have to state: it is not a *uniform improvement*, and off the diagonal family it is strictly weaker than both the two-moment bound and the trivial support bound. A route whose only sharp points are the family where the conjecture is already granted, and which is worse than a three-line estimate everywhere else, is refuted as a route, but it is refuted for being weak, not for failing to be new. **These are different verdicts and the record should carry the second one.**

---

## What was established how

- **By argument, from the definitions:** C1 in full (the $\varphi_{ij}$ computation and the frame-independence); C2's basis count, self-adjointness and the Schur/Horn attribution; the optimality of diagonalising the $\psi$ block, via Karamata; all of C3, including both convexity domains, both directions and the automatic domain hypotheses; C4's corrected four-term identity and its equality case; the one-line bound $\theta\le\tfrac32(M_++m)$; the collapse of the $p_3(K)$ coefficient from $\tfrac32$ to $1$; the reading of post F33 in C6.
- **By computation, on my own code in [scripts/reviewers/r290/](../scripts/reviewers/r290/):** the seven test points and their $\theta$; the index-convention screen at $n=6,7$; the majorization checks; $S_1,S_2\ge0$ over $40$ samples; the padded-$\mathbb{CP}^2$ table of C4 at six dimensions; the sign change of the C4 error over $60$ samples; the frame-dependence of the off-masses; the frame-optimised random-tensor ratios; the independent solution of post F33's moment problem and its normalisation reconciliation; the three-bound comparison table.


*Joint section with Reviewer 289, see [REVIEW_r289.md](REVIEW_r289.md).*
