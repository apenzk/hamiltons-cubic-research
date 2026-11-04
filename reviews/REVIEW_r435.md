# Review r435, Lemma L142 and Corollary L140.1

*Reviewer r435, 2026-09-03. Cold brief, adversarial. **Analysis only**: no sweep, no search, no census. The one computation below is a **screen** on objects built here (a 200-sample check of an identity and an inequality this report was about to record) and is reported as a screen, never as evidence for a positive claim.*

**Verdicts.**

| claim | verdict |
| --- | --- |
| **(A) [Lemma L142](../findings/bounds.md), the inequality itself** | **CONFIRMED**, re-derived independently, every convention checked against [conventions.md](../findings/conventions.md) |
| **(A) its framing: "the record carries no proved bound at all"** | **REFUTED**, $M(n)\le n-1$ follows in one line from [Lemma L107](../findings/bounds.md), and again from [Lemma L108](../findings/bounds.md). The headline constant is not new. |
| **(A) "the record's numerics put the true supremum near $1.545$"** | **REFUTED**, $1.545$ is the supremum of a *relaxation bound*, not of $P$ |
| **(B)(i) $\tfrac12$-Lipschitz** | **CONFIRMED** as mathematics; its stated input is the wrong lemma |
| **(B)(ii) the arithmetic** | **CONFIRMED** |
| **(B)(iii) the semiconcavity implication** | **CONFIRMED**, including against the $\beta^2$ objection |
| **(B)(iv) $\delta^2=\tfrac14\sum_\Omega\mathop{\mathrm{tr}}(\lvert W\rvert\Omega)^2$** | **CONFIRMED** |
| **(B)(v) "the obstruction does not fire at $u$"** | **REFUTED**, right conclusion, wrong eigenvalue, and a false homogeneity claim |
| **(B)(vi) "what the item actually needs"** | **REFUTED**, the display is the non-uniform statement, and on the class the tube needs it is *already proved* |

---

## (A) Lemma L142

### The mathematics is right, and every convention it leans on checks out

**Row mass.** [conventions.md](../findings/conventions.md) carries $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2$ and $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$, so $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$. **The ordered/unordered trap does not bite here**, and the reason is worth recording: $\beta$ and $\gamma$ run over *basis indices* of $\Lambda^2$, not over index pairs of $\mathbb R^n$, so there is no second reading of the sum to get wrong. The value is forced independently: $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=-\mathop{\mathrm{tr}}(\mathrm{ad}_{v_\alpha}^2)=-B(v_\alpha,v_\alpha)=-(n-2)\mathop{\mathrm{tr}}(v_\alpha^2)=2(n-2)$, using exactly the two normalisations conventions.md fixes ($B=(n-2)\mathop{\mathrm{tr}}(XY)$, $\mathop{\mathrm{tr}}(v^2)=-2$). Checked by hand at $\varphi_{12}$: the bracket is nonzero only against the $2(n-2)$ basis elements sharing exactly one index, each contributing $1$.

**Total symmetry of $T$.** $c_{\alpha\beta\gamma}$ is totally antisymmetric (ad-invariance of the inner product, conventions.md), so $T=c^2$ is totally symmetric and vanishes on repeated indices. Correct.

**The $\tfrac12$.** Pinned by an anchor the lemma does not quote: with $\langle X,X^\#\rangle=\tfrac12\sum T\lambda\lambda\lambda$, the identity operator gives $(\mathrm{Id}^\#)_{\alpha\alpha}=\tfrac12\sum_\gamma\lVert[v_\alpha,v_\gamma]\rVert^2=n-2$, hence $Q(\mathrm{Id})=(n-1)\mathrm{Id}$, Hamilton's normalisation. Drop the $\tfrac12$ and the round sphere stops being a fixed point of the ODE. **The $\tfrac12$ is right, and the headline would read $2n-3$ without it.**

**AM–GM.** $\tfrac12\sum T_{\alpha\beta\gamma}\lvert\lambda_\alpha\lambda_\beta\lambda_\gamma\rvert\le\tfrac16\sum T(\lvert\lambda_\alpha\rvert^3+\lvert\lambda_\beta\rvert^3+\lvert\lambda_\gamma\rvert^3)=\tfrac12\sum T\lvert\lambda_\alpha\rvert^3$, the three sums coincide *because* $T$ is totally symmetric, which is exactly the property established above. Then $\tfrac12\cdot2(n-2)\sum_\alpha\lvert\lambda_\alpha\rvert^3$. Valid.

**The trace step.** $\sum_\alpha\lvert\lambda_\alpha\rvert^3\le\lVert\lambda\rVert_\infty\sum_\alpha\lambda_\alpha^2=\lVert\lambda\rVert_\infty$ needs $\sum\lambda^2=1$, which is conventions.md's $\lVert M\rVert_F=1\Rightarrow\sum\mu^2=1$. Valid, and $\lVert\lambda\rVert_\infty\le1$ follows.

**Screen** (reported as a screen). Against [lib325.py](../scripts/reviewers/r325/lib325.py), an implementation built from the definitions by a different reviewer: at $n=4,5,6$ the row mass is exactly $2(n-2)$, $Q(\mathrm{Id})=(n-1)\mathrm{Id}$, and over $200$ random symmetric traceless unit $X$ per dimension the identity $\langle X,X^\#\rangle=\tfrac12\sum T\lambda\lambda\lambda$ holds to $10^{-8}$ with no violation of either the stated or the sharpened bound.

### Defect 1, the proof proves something strictly stronger and the statement throws it away

The trace step is run twice: first to $\lVert\lambda\rVert_\infty$, then weakened to $1$. Keeping it gives

$$\lvert P(X)\rvert\;\le\;(n-1)\sum_\alpha\lvert\lambda_\alpha\rvert^3\;\le\;(n-1)\lVert\lambda\rVert_\infty ,$$

which is **strictly stronger than the recorded $1+(n-2)\lVert\lambda\rVert_\infty$ at every $X$ with $\lVert\lambda\rVert_\infty<1$**, and equal at the single point where it is $1$. Free, from the lemma's own lines. The "where it is loose" paragraph does not mention it.

### Defect 2, the headline constant is already on the record, twice

The lemma's stated reason for existing is that "**the record carries no proved bound at all**". That is false.

- $\mathcal W_n$ is a linear space and $P$ is an odd cubic, so $\sup_{\lVert X\rVert=1}\lvert P(X)\rvert=\sup_{\lVert X\rVert=1}P(X)$. The sphere is compact and $\nabla P=3Q$, so the supremum is **attained at a critical point** in conventions.md's own sense $Q(W)=\theta W$. Hence $M^*=M(n)$, the I8 constant *is* the conjecture's own quantity, which the lemma never says.
- [Lemma L107](../findings/bounds.md) gives $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ at every critical point, and $\lvert\lambda_{\min}\rvert\le1$ at unit norm. **So $M^*\le n-1$.**
- Independently, [Lemma L108](../findings/bounds.md) gives $\theta\le\tfrac12\sqrt{(n-1)G_2}$ with $G_2=\sum_k\lambda_k^2g_k$, $g_k\ge0$ and $\sum_kg_k=4(n-1)$ fixed on $\mathcal W_n$ ([bounds.md](../findings/bounds.md)). So $G_2\le4(n-1)\lVert\lambda\rVert_\infty^2$ and $\theta\le(n-1)\lVert\lambda\rVert_\infty$, **the same constant, and in fact the same sharpened form as Defect 1**.

What survives as genuinely new is narrower and should be stated as such: L142 is a **pointwise** bound at every $X$, proved without criticality and without the row calculus. It is not a new value for $M^*$, and [plan.md](../plan.md)'s I8 item (which asks for "a crude proved bound" for $M^*$), was already satisfiable from the record.

### Defect 3, the $1.545$ attribution

"The record's numerics put the true supremum near $1.545$." They do not. $1.545$ is the measured supremum of the **relaxation bound** $\lambda_{\max}p+B_5$ ([second-order.md](../findings/second-order.md)), flagged as such by [r133](REVIEW_r133.md), and [plan.md](../plan.md) states it correctly as "a numerical supremum for a related quantity". The true supremum is $M(n)$, which the record's own conjecture places at $\Theta_n<\sqrt2=1.414$, below the figure quoted. **A note that puts the target *above* $\sqrt2$ misdirects the successor the paragraph is written for.**

### Not a defect, but recorded

L142 uses neither the first Bianchi identity, nor Ricci-flatness, nor tracelessness, only $\lVert X\rVert=1$. **It is a bound on all symmetric operators on $\Lambda^2$**, so it cannot see the Weyl constraints, which the record measures at $5.5\%$ of the relaxed supremum. That is the structural reason it is dimension-dependent while the truth is not, and it is a sharper diagnosis than the lemma's own "throwing away everything the structure constants know".

**Verdict (A): CONFIRMED as an inequality; its novelty claim and its numerical annotation are REFUTED.**

---

## (B) Corollary L140.1

### (i) $\tfrac12$-Lipschitz, true, but cited to a lemma that does not say it

**The mathematics is correct**, re-derived here from nothing. $f(x)=\tfrac12(\lvert x\rvert-x)$ is convex, nonincreasing, $1$-Lipschitz and positively homogeneous. Consequences, at an **arbitrary** base point $V$:

- every divided difference $f[\nu_i,\nu_j]$ lies in $[-1,0]$, and $f'(\nu_i)\in\{0,-1\}$ for $\nu_i\ne0$, so centring at $\mu=\tfrac12$ scales every entry by at most $\tfrac12$;
- cross blocks against the kernel give $f(\nu)/\nu\in[-1,0]$, inside the same range;
- on the kernel block, positive homogeneity gives $f(tD)=tf(D)$ exactly, so the one-sided coefficient is $D_-$ and $D_-+\tfrac12D=\tfrac12\lvert D\rvert$ of norm $\tfrac12\lVert D\rVert$;
- $\mathrm{Alt}(H)=0$ for Weyl $H$ licenses the recentring, and $\mathrm{Alt}$ is an orthogonal projection.

The integration is also sound, for a reason the corollary does not give: $W\mapsto W_-$ is the projection onto the PSD cone applied to $-W$, hence nonexpansive in Frobenius norm (Moreau, the record has this at [route-a.md](../findings/route-a.md)), so $t\mapsto\delta(W_2+tH)$ is Lipschitz, hence absolutely continuous, and the fundamental theorem of calculus applies to a function differentiable only a.e. The one-sided bound holds in **both** $\pm H$, both being Weyl, so it bounds $\phi'$ wherever $\phi'$ exists.

**Two defects in the write-up.**

1. **Provenance.** The corollary says "*its input is [Lemma L140](../findings/route-a.md), which passed*". [Lemma L140](../findings/route-a.md) is stated **at $u$ only**, its proof runs on $u$'s spectrum $\tfrac1{\sqrt6}(2,-1,-1)$ and a five-column multiplier table for that spectrum. The every-base-point statement is [Lemma L141](../findings/second-order.md)(a), in a different file, whose **generality claim was REFUTED at Gate 2** ([LEDGER.md](../findings/LEDGER.md) row 141, [r431](REVIEW_r431.md)/[r432](REVIEW_r432.md)) and which was then **repaired in place and not re-reviewed**. The corollary therefore rests on an unreviewed repair while citing a reviewed lemma that does not contain the statement.
2. **One-sidedness is suppressed.** Writing $D(\mathrm{Alt}\,W_-)[H]$ "at every base point" asserts a derivative that does not exist wherever $\ker W\ne0$, and the segments this route cares about (through $u$, through padded tensors) can lie **entirely** inside $\{\det W=0\}$. The repair is short, along a real-analytic segment the eigenvalue branches are analytic, an identically-zero branch forces $H_{K_0K_0}=0$ and contributes nothing, and the rest vanish at finitely many $t$, but the corollary does not make it, and "at every base point" is doing the work.

**Verdict (i): CONFIRMED, with the citation wrong and the regularity argument missing.**

### (ii) The arithmetic, correct

$\delta(u)=\lVert\mathrm{Alt}(u_-)\rVert=a\lVert\star\rVert=\tfrac1{3\sqrt6}\cdot\sqrt6=\tfrac13$, from conventions.md's $a=\tfrac1{3\sqrt6}$ and $\lVert\star\rVert^2=6$. Then $\delta^2-\tfrac19\le(\delta-\tfrac13)(\delta+\tfrac13)\le\tfrac d2\big(\tfrac23+\tfrac d2\big)=\tfrac d3+\tfrac{d^2}4$, trivially true when $\delta<\tfrac13$. And $\lVert W_1-W_2\rVert=2\sin(d/2)\le d$ for unit tensors, so substituting the geodesic distance is legitimate in a bound that increases in $d$. **CONFIRMED.**

### (iii) The semiconcavity implication, correct, including against the objection I expected to kill it

Let $g=f-\tfrac C2\lVert\cdot-u\rVert^2$ be concave on a ball. Concavity gives $g(W)\le g(u)+g'(u;W-u)$, and $g'(u;H)=f'(u;H)$ since the quadratic has vanishing first-order term. With $f'(u;H)\le0$ for every $H$, which is [Lemma L17](../findings/route-a.md)'s $d^+\delta^2=-2aF$, $F\ge0$, stated for *any* direction, one gets $f(W)\le f(u)+\tfrac C2d^2$. The matching of constants is right too: L16$\beta$ wants $c_2\le\beta=\theta^*/(2\lvert\kappa_n\rvert)$ and $\tfrac C2=\beta$ gives $C=\theta^*/\lvert\kappa_n\rvert$, as displayed.

**The attack that fails, recorded because it looks decisive and is not.** [Lemma L135](../findings/route-a.md)(d)'s Gate 2 established that "*a threshold uniform over all of $\{F=0\}$ is false*", the $P$-side margin degrades like $\beta^2$ with the orbit component while $c_2$ need not. A neighbourhood ceiling on $\delta^2$ quantifies over **all** directions, orbit-tangent ones included, so it looks to be proving the false uniform thing. It is not: the tube statement measures every $W$ from **its own nearest orbit point**, at which the direction is automatically orbit-orthogonal ([route-a.md](../findings/route-a.md), L135(d)'s note), and $\delta^2$ is $O(n)$-invariant so semiconcavity at $u$ transfers around $\mathcal O$ with the same constant and radius. **CONFIRMED.**

### (iv) The $\Lambda^4$ formula, correct

$W_+-W_-=W$ and $\mathrm{Alt}(W)=0$ give $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$; $\lvert W\rvert=W_++W_-$ gives $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$, so $\delta=\tfrac12\lVert\mathrm{Alt}(\lvert W\rvert)\rVert$ and the factor $\tfrac14$ is right. $\mathrm{Alt}$ is the orthogonal projection onto $\Lambda^4$ (conventions.md), so $\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=\sum_\Omega\langle\lvert W\rvert,\Omega\rangle^2$ over an orthonormal basis of $\Lambda^4$, and $\langle A,B\rangle=\mathop{\mathrm{tr}}(AB)$ for symmetric pair-matrices in the record's operator-level pairing. Every element of $\Lambda^4\subset S^2(\Lambda^2)$ is symmetric, so $\mathop{\mathrm{tr}}(\lvert W\rvert\Omega)$ is the right pairing. **CONFIRMED.**

### (v) "The obstruction does not fire at $u$", REFUTED

Three separate problems.

1. **It exonerates the wrong degeneracy.** The second-divided-difference obstruction for $\lvert\cdot\rvert$ blows up when eigenvalues coalesce **at the point where $\lvert\cdot\rvert$ is not $C^2$**, which is $0$. The double eigenvalue $-\tfrac1{\sqrt6}$ sits where $\lvert\cdot\rvert$ is affine and is harmless *for that reason*, but it was never the candidate obstruction. **The degeneracy that matters at $u$ is the kernel** (multiplicity $\dim K$ sitting exactly at $0$) and the paragraph clears the harmless one first, which reads as an argument and is not.
2. **"The kernel contributes the exactly homogeneous $t\lvert D\rvert$, whose second derivative in $t$ vanishes" is false.** After orthogonal block-diagonalisation the kernel's effective operator is $t\,D_s(t)$ with $D_s(t)=D-tC^{\!\top}\Lambda^{-1}C+O(t^2)$, so its negative part is $t\,D_-+O(t^2)$ and the $t^2$ term is exactly the Schur term. [Lemma L140](../findings/route-a.md)'s own proof says so, "*the Schur term $C^\top\Lambda^{-1}C$ enters at $t^2$ and a first-order coefficient never sees it*". **(v) is a second-order claim and cannot borrow the first-order excuse.** $\Lambda=\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(2,-1,-1)$ is indefinite, so $C^{\!\top}\Lambda^{-1}C$ carries no free sign either.
3. **The kink's "wrong sign for semiconcavity" is not established at $u$.** The kink enters $d^+\delta^2(u;H)$ and $d^+\delta^2(u;-H)$ with the *same* positive sign, and [Lemma L17](../findings/route-a.md) makes both totals nonpositive; the second-difference test at $u$ therefore reads $\delta^2(u+h)+\delta^2(u-h)-2\delta^2(u)=t\big[d^+\delta^2(u;H)+d^+\delta^2(u;-H)\big]+O(t^2)\le O(t^2)$ **regardless of the kink**. Any genuine failure of semiconcavity must live at base points *near* $u$, where L17 supplies nothing, and the paragraph never mentions them. So the sub-conclusion ("the kink is not an obstruction after all") is right, but by the record's own L17 rather than by the neighbourhood argument (vi) then builds on.

**Verdict (v): REFUTED as written.** What survives: the double eigenvalue is indeed harmless.

### (vi) "What the item therefore actually needs", REFUTED

**The display is the wrong quantifier order, and the prose beside it says so.** The item is written
$$\sup_{\lVert H\rVert=1}\ \limsup_{t\to0^+}\ \frac{\delta^2(\gamma_H(t))-\tfrac19}{t^2}\ \le\ \beta,$$
"**with the supremum outside**", and is then glossed as "*uniformity in $H$ of a per-ray bound*". **Those are different statements, and the display is the non-uniform one.** Uniformity is $\limsup_{t\to0^+}\sup_{\lVert H\rVert=1}(\cdot)\le\beta$, supremum **inside**. A per-ray bound holding for every $H$ gives a radius $t_0(H)$ per ray and no positive infimum over $H$.

**A counterexample, elementary and semialgebraic.** Take $\phi(s)=\max\big(0,1-4(s-1)^2\big)$ and

$$g(x,y)=3\beta\,\phi\!\big(y/x^2\big)\,(x^2+y^2)\ \ (x\ne0),\qquad g(0,y)=0 .$$

$g$ is continuous ($\lvert g\rvert\le3\beta r^2$). Along any fixed ray $y=mx$ with $m\ne0$, $y/x^2=m/x\to\pm\infty$, so $\phi=0$ and $g\equiv0$ in a punctured neighbourhood; along $y=0$, $\phi(0)=0$; along $x=0$, $g=0$. **So every ray gives $\limsup_{t\to0^+}g/t^2=0\le\beta$.** Yet on the parabola $y=x^2$ we have $\phi(1)=1$ and $g=3\beta(x^2+x^4)=3\beta r^2>\beta r^2$ **at every radius**, so no neighbourhood ceiling $g\le\beta r^2$ holds. The symmetry of the direction set and the fact that every point is reached by some ray at $t>0$ are both true and both irrelevant: what fails is not coverage, it is the *rate*, which per-ray limits do not control along curved approaches.

**And the vacuity check lands on top of that.** For $H$ off the cone $\{F=0\}$, $\delta^2(\gamma_H(t))-\tfrac19=-2aF(H)t+O(t^2)$ with $F(H)>0$, so the displayed limsup is $-\infty$. On the cone it is exactly $c_2(H)$, and on $\{F=0\}\cap T_u\mathcal O^\perp$, the class [Lemma L135](../findings/route-a.md)(d) shows is the only one the tube ever needs, [Lemma L140](../findings/route-a.md) with [Lemma L136](../findings/route-a.md) already gives $c_2\le\tfrac5{36}<0.3591\le\beta$. **So the displayed statement, on the class that matters, is something the record has already proved.** It cannot be "what the item actually needs" while the item is open; the open part is precisely the uniformity the display drops. The corollary also silently drops the orbit-orthogonality hypothesis that L135(d)'s Gate 2 recorded as non-removable.

**The kernel-block claim: conclusion right, stated reason false.** "*On the kernel block it cannot [degenerate]: … so no branch radius shrinks there.*" Branch radii on the kernel block **do** shrink: a branch $\omega(t)=t\,d_j+t^2s_j+\dots$ with $d_j\to0^+$ and $s_j<0$ has its first positive zero at $\approx d_j/\lvert s_j\rvert\to0$, and $D=P_0HP_0$ may be singular for unit $H$. What is true is that the estimate **never needs a branch radius**: $\lVert t(D_s)_--tD_-\rVert\le t\lVert D_s-D\rVert\le Ct^2$ with $C$ uniform over $\lVert H\rVert=1$, by nonexpansiveness of $N\mapsto N_-$ and positive homogeneity, exactly the two facts quoted, used to bypass analyticity rather than to establish it. **Repair the sentence, keep the conclusion.**

**Verdict (vi): REFUTED as stated.**

---

## What a successor should take from this

- **(A) stands as an inequality and should be restated at its true strength and its true novelty**: $\lvert P(X)\rvert\le(n-1)\lVert\lambda\rVert_\infty$, pointwise on all symmetric operators on $\Lambda^2$, with the note that the *value* $n-1$ for $M^*$ was already available from [Lemma L107](../findings/bounds.md) and again from [Lemma L108](../findings/bounds.md), and that $M^*=M(n)$ exactly.
- **(B)(i)–(iv) stand.** (i) needs its citation moved to [Lemma L141](../findings/second-order.md)(a) and that lemma's post-repair text needs a Gate 2 of its own.
- **(B)(v) and (vi) are the two paragraphs that tell a successor the route is nearly closed, and both are wrong where it counts.** The genuine open problem is a **uniform-in-$H$** second-order ceiling (supremum inside the limit), with the kernel block already under uniform control by the Lipschitz/homogeneity argument and the $E$-block by a spectral gap bounded away from zero. The paragraph that names the item should name that one.
