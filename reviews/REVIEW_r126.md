# Review r126, the vertex equation, the $v\otimes v$ pairing, and fence post F29

Adversarial review of the three claims in [target.md](../findings/target.md) §"The diagonal proof's ENGINE lifts to any critical point", plus the $N_{ik}$ method claim in [random_control.py](../scripts/random_control.py). Derivations checked on paper first; numerics independently reconstructed (own Weyl generator, own $\#$ implementation, own $\mathbb{CP}^m$ and $S^p\times S^q$ builders) before any repo script was read.

---

## Verdicts

| claim | verdict |
|---|---|
| 1. The vertex equation | **Upheld**, with one wording correction, the $D$ term is not produced by it |
| 2. The pairing | **Upheld**, and true in a strictly stronger form than recorded |
| 3. The closure (fence post F29) | **Conclusion right, mechanism wrong.** Both cited corrections fail as stated, and both fail *at the cited evidence*. The post should be rewritten, not deleted |
| $N_{ik}=\lvert W\rvert^2I/n$ at $n=4$ only | **Upheld**, with a sharper discriminator available |

---

## 1. The vertex equation, upheld

The $(ab),(ab)$ entry of $W^2$ in the coordinate basis is $\sum_{c<d}W_{abcd}W_{cdab}=K_{ab}^2+R_{ab}$, so the diagonal of $Q(W)=\lambda W$ is the boxed equation. The sum rule is immediate: $\sum_{a<b}(K_{ab}^2+R_{ab})=\mathop{\mathrm{tr}}(W^2)=\lVert W\rVert^2=1$ and $\sum_{a<b}K_{ab}^2=t/2$, hence $\sum R=1-t/2$.

Reproduced at residual $\le 8.3\times10^{-17}$ at twelve exactly-constructed critical points ($S^3\!\times\!S^3$, $S^4\!\times\!S^4$, $S^6\!\times\!S^6$, $S^4\!\times\!S^8$, $\mathbb{CP}^{2\ldots5}$, and non-diagonal critical points reached by flowing $W\mapsto Q(W)/\lVert Q(W)\rVert$ from random Weyl tensors at $n=6$). The control behaves: at a *non*-critical Weyl tensor the vertex residual is $0.04$–$0.20$.

**No projector is needed and the record is right not to use one.** $\Phi$ preserves Ricci-flatness ([BW08](../references/boehm-wilking-2008-space-forms/) eq. (6)) and the first Bianchi identity, so $Q(W)$ is already Weyl and the Lagrange condition on the unit sphere of $\langle W\rangle$ is $Q(W)=\lambda W$ verbatim. This was the first attack tried and it fails.

**The one correction: "including the $D$ term" is a mis-statement.** The vertex equation lives only on $a\ne b$, there is no $(aa)$ two-plane. At a diagonal point $H_{ab}:=(W^\#)_{abab}=\langle A^a,A^b\rangle=(K^2)_{ab}$ (the Jäger/Poljsak diagonal $\#$-formula, reproduced here at $2.8\times10^{-17}$), so the vertex equation *is* the $a\ne b$ part of $M^{\circ2}+M^2=\theta M+\mathop{\mathrm{diag}}(s)$ from [diagonal-half.md](../findings/diagonal-half.md). The $D=\mathop{\mathrm{diag}}(s_a)$ term is the $a=b$ part, which the vertex equation never sees and which holds tautologically because $K$ is hollow: $(K^{\circ2})_{aa}=0$, $(K^2)_{aa}=s_a$, $\lambda K_{aa}=0$. So the identification is correct **off the diagonal of the matrix equation**, and $D$ is a remainder the vertex equation does not derive.

---

## 2. The pairing, upheld, and stronger than recorded

The $\#$-formula holds with the convention $R^\#_{ijkl}=\sum_{pq}(R_{ipkq}R_{jplq}-R_{iplq}R_{jpkq})$, **no factor $2$**, fixed independently here by reproducing $Q(W)=\theta_0(n)W$ exactly at $S^{n/2}\times S^{n/2}$ for $n=6,8,12$ with $\theta_0=\sqrt{2(n-1)(n-2)}/n$. Residual on $(W^\#)_{abab}=\langle A^a,A^b\rangle-\sum_{pq}W_{apbq}W_{bpaq}$: $\le 2.8\times10^{-16}$, and it is an identity for *every* Weyl tensor, critical or not.

Three details the record leaves implicit, all checked:

- $\sum_{pq}W_{apbq}W_{bpaq}=\mathop{\mathrm{tr}}\big((B^{ab})^2\big)$ because $B^{ab}_{qp}=W_{aqbp}=W_{bpaq}$. $B^{ab}$ is **not** symmetric off the diagonal locus, which is exactly why its trace-square is unsigned.
- Extending both sums from $a\ne b$ to all $a,b$ is free: $H_{aa}=\lVert A^a\rVert^2-\lVert A^a\rVert^2=0$ and $K_{aa}=0$.
- $\mathop{\mathrm{diag}}(G)_p=\sum_a v_aW_{apap}=(Kv)_p$ in one line, for every $W$ and every $v$. Residual $2.8\times10^{-17}$.

**The identity is true for every unit $v$, not only for eigenvectors:**

$$\lambda\,(v^{\mathsf T}Kv)=\lVert Kv\rVert^2+\lVert G_{\text{off}}\rVert^2+v^{\mathsf T}\hat Rv+\Big[v^{\mathsf T}K^{\circ2}v-\textstyle\sum_{ab}v_av_b\mathop{\mathrm{tr}}\big((B^{ab})^2\big)\Big],$$

residual $\le 5.6\times10^{-17}$ at random unit $v$ at non-diagonal critical points, $n=5,6,7$. Eigenvector-ness is used **only** to replace $\lVert Kv\rVert^2$ by $\mu_K^2$ and $v^{\mathsf T}Kv$ by $\mu_K$. At a diagonal point it collapses to $\theta\mu_1=\mu_1^2+u^{\mathsf T}M^{\circ2}u-\sum_is_iu_i^2$, which is [diagonal-half.md](../findings/diagonal-half.md) line 86 term for term.

---

## 3. The closure, the conclusion survives, the mechanism does not

The post's mechanism is *"both corrections are non-negative and both add: $\lVert G_{\text{off}}\rVert^2\ge0$ and $R\ge0$."* Three independent breaks, in increasing severity.

### 3a. $\lVert G_{\text{off}}\rVert^2$ is exactly zero at the cited evidence

| point | $\lVert G_{\text{off}}\rVert^2$ | $v^{\mathsf T}\hat Rv$ | bracket | $\lambda\mu_K-\mu_K^2$ |
|---|---|---|---|---|
| $\mathbb{CP}^2$ | $0$ | $+0.083333$ | $+0.250000$ | $+0.333333$ |
| $\mathbb{CP}^3$ | $0$ | $+0.104167$ | $+0.170833$ | $+0.275000$ |
| $\mathbb{CP}^4$ | $0$ | $+0.097222$ | $+0.121825$ | $+0.219048$ |
| $\mathbb{CP}^5$ | $0$ | $+0.087500$ | $+0.093056$ | $+0.180556$ |

$\mathbb{CP}^3$ and $\mathbb{CP}^4$ are the two numbers the post quotes ($\lambda\mu_K=0.5$ vs $0.225$; $0.333$ vs $0.114$, both reproduced exactly). At both, the term the post names as the driver contributes **nothing**, and the excess is carried by the bracket, which the post does not mention. This is internally inconsistent with the record's own next section, which already flags $\lVert G\rVert^2=\mu_K^2$ as a symmetric-sample artefact.

### 3b. $\sum_{ab}R_{ab}v_av_b$ is not signed, the entrywise inequality does not survive the pairing

$R_{ab}\ge0$ entrywise is true. But $K\mathbf1=0$, so $\mu_K\ne0$ forces $v\perp\mathbf1$, hence $v$ has mixed signs, and the quadratic form of a hollow entrywise-nonnegative matrix restricted to $\mathbf1^\perp$ is typically **negative**, the model case $\hat R=J-I$ gives $v^{\mathsf T}\hat Rv=-\lvert v\rvert^2$. Measured:

- Random Weyl tensors, top eigenvector: negative in $99\%$ ($n=5,6$) and $100\%$ ($n=7,8$) of $300$ draws each, down to $-0.234$.
- **Genuine non-diagonal critical points** ($n=6$, $\lambda=\sqrt{3/2}$, Ricci residual $8\times10^{-17}$): $-0.006415$ and $-0.000245$ in two of eight.
- $\mathbb{CP}^3$, $\mathbb{CP}^4$ with the bottom eigenvector: $-0.138889$, $-0.116667$.

### 3c. The bracket is unsigned, and it is the term that flips

| locus | bracket |
|---|---|
| $S^3\!\times\!S^3$, $S^4\!\times\!S^4$, $S^6\!\times\!S^6$, $S^4\!\times\!S^8$ | $-0.266667$, $-0.214286$, $-0.151515$, $-0.143182$ |
| $\mathbb{CP}^{2,3,4,5}$ | $+0.250000$, $+0.170833$, $+0.121825$, $+0.093056$ |
| non-diagonal critical, $n=6$ | $-0.008398$ to $+0.108806$ |
| $\mathbb{CP}^2$ in a $K=0$ frame | $-0.421231$ to $-0.181694$ |

On the whole diagonal locus the bracket is the *engine*, it equals $-\mu_1^2/n$ to nine digits at every attracting diagonal critical point found at $n=6,8,10,12$, which is precisely what makes $\theta=\tfrac{n-1}{n}\mu_1$ hold there. Off the locus it flips positive and, at the cited $\mathbb{CP}^m$, exceeds the $R$-term. **The sign flip that kills the argument lives in the bracket, not in two non-negative additions.**

### 3d. An analytic refutation, no sampling involved

At $\mathbb{CP}^2$ ($n=4$) and $\mathbb{CP}^4$ ($n=8$) there is an orthonormal frame in which the vertex matrix **vanishes identically**. Construction: $K_{ab}=3s\,(J_{ab}^2-\tfrac1{n-1})$ for the Fubini–Study Weyl tensor, so $K=0$ iff $J\circ J$ is the uniform hollow matrix, i.e. iff $\sqrt{n-1}\,J$ is a **skew conference matrix of order $n$**, which exists at $n=4$ and $n=8$ (Paley, $q=7$). Rotating there gives $\lVert K\rVert_F^2 = 3.9\times10^{-32}$ and $6.3\times10^{-32}$ while $\lVert Q(W)-\lambda W\rVert\le1.1\times10^{-15}$, i.e. still exactly critical.

In such a frame the identity reads, **for every $v$**,

$$0=\lVert G_{\text{off}}\rVert^2+v^{\mathsf T}\hat Rv+\text{bracket},\qquad \lVert G_{\text{off}}\rVert^2>0 ,$$

so $v^{\mathsf T}\hat Rv+\text{bracket}=-\lVert G_{\text{off}}\rVert^2<0$ identically. The two corrections **cannot** both be non-negative. Measured at $\mathbb{CP}^2$: $\lVert G_{\text{off}}\rVert^2=0.202598$, $v^{\mathsf T}\hat Rv=+0.094804$, bracket $=-0.297402$, sum $-3.4\times10^{-17}$.

---

## 4. What the correct closure is, a frame-free norm budget

$K$ is symmetric with $K\mathbf1=0$, so on $\mathbf1^\perp$ (dimension $n-1$) it is trace-free with Frobenius square $t$, giving

$$\mu_1\ \le\ \sqrt{\tfrac{t(n-2)}{n-1}},\qquad t=2-2\textstyle\sum R\ \le\ 2 .$$

Therefore **any** bound of the shape $\lambda\le c\,\mu_1$ yields $\lambda\le c\sqrt{t(n-2)/(n-1)}$, which reaches $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ only when $c^2t\le 2(n-1)^2/n^2$. At the diagonal constant $c=\tfrac{n-1}{n}$ this forces $t=2$ exactly, i.e. $\sum R=0$, i.e. the coordinate-diagonal locus, with equality throughout.

The cap is attained, so nothing is being thrown away: at every balanced sphere product $\mu_1=\sqrt{t(n-2)/(n-1)}$ and $\lambda=\tfrac{n-1}{n}\mu_1$ to $2\times10^{-16}$, with $K$'s spectrum the extremal profile (one $\mu_1$, $n-2$ equal negatives, one $0$) already recorded at [ATTEMPTS.md](../ATTEMPTS.md) line 312, the two facts had simply never been combined.

Off the locus the required constant blows up, and it stays blown up after optimising the frame:

| point | $t$ | $\mu_1$ | $\lambda/\mu_1$ | $\tfrac{n-1}{n}$ | best-frame floor $\lambda/\sqrt{t_{\max}(n-2)/(n-1)}$ |
|---|---|---|---|---|---|
| $S^6\!\times\!S^6$ | $2.000$ | $1.348400$ | $0.9167$ | $0.9167$ | $0.9167$ |
| $\mathbb{CP}^3$ | $0.750$ | $0.474342$ | $2.2222$ | $0.8333$ | $1.3608$ |
| $\mathbb{CP}^4$ | $0.600$ | $0.338062$ | $2.9167$ | $0.8750$ | $1.3749$ |
| $\mathbb{CP}^5$ | $0.500$ | $0.263523$ | $3.6000$ | $0.9000$ | $1.4230$ |
| $\mathbb{CP}^2$, $K=0$ frame | $0$ | $0$ | $+\infty$ | $0.7500$ | $+\infty$ |

**$t_{\max}$ over frames is attained at the natural frame for every $\mathbb{CP}^m$, and this is a theorem, not a search.** With $X:=J\circ J$, $X$ is hollow, symmetric and doubly stochastic in any frame, and $t=9s^2\big(\sum_{a\ne b}x_{ab}^2-\tfrac n{n-1}\big)$; since $\sum x_{ab}^2\le\sum x_{ab}=n$ with equality iff every $x_{ab}\in\{0,1\}$, the maximum is exactly the frames in which $J$ is a perfect matching, the natural ones. Confirmed: best of $4000$ random frames gives $0.6997$ against $t_{\max}=0.750000$ at $\mathbb{CP}^3$, $0.3872$ against $0.600000$ at $\mathbb{CP}^4$.

So the honest statement is: **the top-eigenvector pairing can deliver $\theta_0(n)$ only where $t=2$, and $t=2$ is the diagonal locus.** One Cauchy–Schwarz step, frame-independent, no sign analysis, no numerics.

---

## Answers to (a)–(d)

**(a) Is the bracket signed? No.** Range measured $-0.421231$ to $+0.250000$ across critical points and frames; negative on the entire diagonal locus, positive on the entire $\mathbb{CP}^m$ family, and of *larger* magnitude than the $R$-term at $\mathbb{CP}^{2,3,4,5}$. The "both corrections add" reading is therefore over-broad twice over: one of the two named corrections is zero at the cited evidence, and the unnamed third term is the dominant one there.

**(b) Is the top eigenvector load-bearing? Not for the identity; only for the sign of $v^{\mathsf T}Kv$.** The identity holds for every unit $v$ (residual $10^{-17}$). Converting it into an *upper* bound on $\lambda$ requires dividing by $q=v^{\mathsf T}Kv$, which reverses the inequality when $q<0$. Since $K$ is trace-free and nonzero, $\mu_{\min}<0$, so the bottom eigenvector gives $\lambda\mu_{\min}<0<\mu_{\min}^2$ **automatically**, the "below" orientation for free and with no content, yielding only $\lambda\ge\mu_{\min}$, a negative lower bound. Confirmed at $\mathbb{CP}^3$ ($\lambda\mu-\mu^2=-0.433333$) and $\mathbb{CP}^4$ ($-0.314286$): the sign does flip, and it buys nothing. The bottom eigenvector cannot produce a usable orientation; a general $v$ is admissible but strictly weaker, since $\lVert Kv\rVert^2\ge(v^{\mathsf T}Kv)^2$ with equality exactly at eigenvectors.

**(c) Does the argument need $\mu_K>0$, and is that guaranteed? It needs it, and it is not guaranteed.** $\mu_K>0$ iff $K\ne0$, and $K$ can be exactly zero at a genuine critical point in a legitimate orthonormal frame, §3d, $\mathbb{CP}^2$ and $\mathbb{CP}^4$ via skew conference matrices, $\lVert K\rVert_F^2\sim10^{-32}$. There $t=0$, $\sum R=1$, and the pairing degenerates to a constraint among the corrections with $\lambda$ absent entirely. The route is not merely closed at those frames; it is **vacuous**.

**(d) Is fence post F29 too strong? Yes as stated, and simultaneously too weak as a diagnosis.**

- *Too strong.* It closes one contraction of the vertex equation, pairing with $v\otimes v$ for $v$ a $K$-eigenvector, aiming at $\lambda\le c\mu_K$. The vertex equation is $\binom n2$ scalar equations and admits any weighting $\sum_{a\ne b}P_{ab}(\cdot)$; one such weighting *is* the diagonal proof (the vertex equation in a frame where $R=0$). Another, $P=\mathbf1\mathbf1^{\mathsf T}$, gives $\mathop{\mathrm{tr}}(W^\#)=-\lVert W\rVert^2$, verified at $10^{-12}$ for every Weyl tensor and vacuous, since it follows from $\langle I,W\#W\rangle=\langle W,W\#I\rangle=-\lVert W\rVert^2$ ([BW08](../references/boehm-wilking-2008-space-forms/) Lemma 2.1) with no criticality used. So "every route through the vertex equation" is not what has been closed.
- *Too weak.* The post attributes the failure to the sign of two corrections at one frame at two points, when the real obstruction is a frame-free norm budget: $\mu_1$ collapses off the diagonal locus because $t=2-2\sum R$ does, and $\lambda$ does not. That diagnosis is a one-line Cauchy–Schwarz argument (§4), needs no numerics, covers **every** frame and every constant $c$, and explains why the diagonal case is the exact equality case rather than a lucky one. Anyone reading the present post would go looking for a bound on $\lVert G_{\text{off}}\rVert^2$ and $R$, which is the wrong target.

**Recommendation: rewrite fence post F29, keep the verdict.** Replace "the obstruction is not looseness but orientation" with the budget statement, drop the claim that $R$ and $\lVert G_{\text{off}}\rVert^2$ are both non-negative contributions, name the bracket as the term that flips, and record the $K=0$ frames as the sharpest form of the closure.

---

## Method audit, $N_{ik}=\sum_{mpq}W_{impq}W_{kmpq}$

**Upheld.** With $\lvert W\rvert^2=\sum_{ijkl}W_{ijkl}^2=4$ at $\lVert W\rVert_{\Lambda^2}=1$:

| $n$ | max deviation of $N$ from $\lvert W\rvert^2I/n$, random Weyl |
|---|---|
| $4$ | $6.9\times10^{-17}$, $2.2\times10^{-16}$, $2.2\times10^{-16}$ |
| $5$ | $0.135$, $0.177$, $0.208$ |
| $6$ | $0.146$, $0.153$, $0.186$ |
| $7$ | $0.147$, $0.165$, $0.100$ |
| $8$ | $0.097$, $0.063$, $0.126$ |

Exact at $n=4$ for every Weyl tensor (the classical $C_{ipqr}C_{jpqr}=\tfrac14\delta_{ij}\lvert C\rvert^2$) and failing from $n=5$ at $15$–$35\%$ relative. The identification and the threshold are both correct.

**One sharpening worth folding in.** The [random_control.py](../scripts/random_control.py) header says the claim "holds at every $S^k\times S^k$" and needs a *random* tensor to break. The real discriminator is finer: it is whether the isotropy group acts irreducibly on $\mathbb R^n$. It holds exactly at $\mathbb{CP}^3$, $\mathbb{CP}^4$, $S^3\!\times\!S^3$ (deviation $\le1.1\times10^{-16}$), and **fails at $S^4\!\times\!S^8$**, a catalogue point, with $\mathop{\mathrm{spec}}(N)=\{0.15^{(8)},0.70^{(4)}\}$ and deviation $0.367$. So one unbalanced product from the existing catalogue would have caught it. The lesson stands but is stronger as "a catalogue of *irreducible* points cannot test an equivariant claim", and the cheap fix is to keep an anisotropic point in the catalogue, not only to sample randomly.

---

## Errors self-caught during this review

An early search for diagonal critical points flowed $W\mapsto Q(W)/\lVert Q(W)\rVert$ without re-projecting onto the Ricci-flat space each step. From diagonal starts (a measure-zero, unstable set), the iterate escaped to the clique idempotents of the *full* curvature algebra ($\lambda=1$, $2/\sqrt3$, $\sqrt{3/2}$: rank-one two-forms and $\mathfrak{so}(k)$ subalgebras), which are not Weyl, and appeared to give diagonal counterexamples to $\lambda\le\tfrac{n-1}n\mu_1$ at $n=6\ldots9$. **Retracted.** Re-run inside the diagonal locus with row-sum reprojection, every converged point has residual $\le1.1\times10^{-16}$ and satisfies $\lambda=\tfrac{n-1}n\mu_1$ with gap $\le6.7\times10^{-16}$. The points reached from *random Weyl* starts were checked and are Ricci-flat to $8.3\times10^{-17}$; all numbers above them stand.

That re-run leaves a lead rather than a finding: at every **attracting** diagonal critical point at $n=6,8,10,12$ the bracket equals $-\mu_1^2/n$ to nine digits, so $\theta=\tfrac{n-1}n\mu_1$ holds with *equality*, not inequality. Since [diagonal-half.md](../findings/diagonal-half.md) records strictness at the $C_5$ blow-up (a saddle, which a gradient flow will not find), the equality is at best a property of the local maxima, and is flagged as attractor-restricted, not claimed.
