# Review r397, the orbit vector is **not** an approximate $M$-eigenvector, and the spectral bound is vacuous

*Gate 2, adversarial, on the last two sections of [ATTEMPTS.md](../ATTEMPTS.md) (2026-09-02, "The orbit vector is an $M$-eigenvector up to a constant" and "The relation is exact on all of $[n]$"). Analysis only; every number below was derived by hand first and then screened on matrices built for the purpose. **The screen is a screen**, it agrees with the hand derivation to the last printed digit and is reported as corroboration of an analytic argument, never as evidence on its own.*

## Verdict table

| # | Claim | Verdict |
| --- | --- | --- |
| **6** | **L129 bounds $\operatorname{dist}(T,\operatorname{spec}M)$ below, so $\lVert o\rVert$ is bounded above** | **VACUOUS, unconditionally.** The bound's right-hand side is **always at least $4\times$** the one-line Cauchy–Schwarz cap $\lVert\tilde o\rVert^2\le2(s_j+s_k)$, and it bounds a quantity [Lemma L68](../findings/diagonal-half.md) already gives **exactly**. It never beats L68 and it never beats Cauchy–Schwarz. Proof below, no cases |
| **1** | $M\tilde o-T\tilde o$ is **constant** on $I$ | **FALSE.** The exact residual is $-\tilde o_a(M_{aj}+M_{ak}+M_{jk})$, which varies with $a$. The derivation equivocates between $\sum_{b\in I}$ and $\sum_{b\in[n]}$: $\sum_{b\in I}M_{ib}=-M_{ij}-M_{ik}\ne0$ |
| **2** | $c=(s_j-s_k)/(n-2)$, with $(M\tilde o)_j=(M^2)_{jk}-s_j$, $(M\tilde o)_k=s_k-(M^2)_{jk}$ | **CORRECT ARITHMETIC, WRONG STATUS.** All three values check. But $c$ is the **mean** of the residual over $I$, not its value. Proved independently below: $\sum_{a\in I}\tilde o_a(M_{aj}+M_{ak})=s_k-s_j$ |
| **3** | The boxed exact relation $M\tilde o=T\tilde o+c\mathbf1+r_je_j+r_ke_k$ | **FALSE on $I$, CORRECT at $j,k$.** $r_j,r_k$ verified. The $c\mathbf1$ term is wrong. The printed consistency check is **circular** (it is the equation that defined $c$) and its stated value is wrong: $\mathbf1^\top$ of both sides gives $0$, not $-cn$ |
| **4** | The twin-pair check | **CORRECT AND WORTHLESS.** Every step verifies by hand, but a twin pair has $\tilde o\vert_I=0$, so it is precisely the configuration where the disputed term vanishes identically. The only verification performed had **zero discriminating power** |
| **5** | $\lVert\tilde o\rVert^2=s_j+s_k-2\theta M_{jk}+2M_{jk}^2$ | **CORRECT.** Verified from the definitions. The rest of claim 5 inherits the failure of claim 3: the printed $B$ is **strictly stronger** than what is true, and is not implied by it |
|, | **Novelty** | **NOT NEW where it is true.** The on-$I$ relation is [post F47](../findings/second-order.md) rearranged in one line. Genuinely new: the boundary values, $c$, and the false constancy claim |

---

## 6. The framing, the bound is vacuous, and here is the proof

Write $M_{jk}=-\mu$ with $\mu>0$ (the only sign for which [Lemma L129](../findings/diagonal-half.md) says anything), $\sigma=s_j+s_k$, $T=\theta-\mu$.

### What L129 actually supplies

L129 says $\operatorname{spec}(M)\cap(0,\theta]=\varnothing$. It does **not** say the spectrum is far from $T$. Two facts cap what can be extracted:

- **$0\in\operatorname{spec}(M)$ always**, since $M\mathbf1=0$. So $\operatorname{dist}(T,\operatorname{spec}M)\le T=\theta-\mu$ at every pure critical point, with no exceptions.
- **An eigenvalue may sit at $\theta+\varepsilon$** for any $\varepsilon>0$ without violating L129, and by [L129's own corollary (i)](../findings/diagonal-half.md) one always sits above $\theta$. So $\operatorname{dist}(T,\operatorname{spec}M)$ may be as small as $\mu+\varepsilon$.

Hence the *sharp* consequence of L129 is
$$D_{\text{guar}}:=\min(\theta-\mu,\ \mu)\ \le\ \operatorname{dist}(T,\operatorname{spec}M),$$
and no spectrum-free argument can improve it, because the spectrum $\{0,\ \theta+\varepsilon,\ \text{negatives}\}$ realises it. In particular **$D_{\text{guar}}\le\mu$ and $D_{\text{guar}}\le\theta/2$ always.**

### The bound is always at least four times weaker than one line of Cauchy–Schwarz

The claimed bound is $\lVert\tilde o\rVert^2\le B^2/D_{\text{guar}}^2$ with, after simplifying $r_j+r_k=-cn$,
$$B^2=c^2n+2c(r_j+r_k)+r_j^2+r_k^2=(s_j+2\mu^2)^2+(s_k+2\mu^2)^2+\frac{(s_j-s_k)^2}{n-2}.$$

Now three elementary steps.

1. **QM–AM:** $B^2\ \ge\ \tfrac12\big[(s_j+2\mu^2)+(s_k+2\mu^2)\big]^2=\tfrac12(\sigma+4\mu^2)^2$.
2. **AM–GM:** $(\sigma+4\mu^2)^2\ \ge\ 16\sigma\mu^2$, so $B^2\ge8\sigma\mu^2$.
3. **$D_{\text{guar}}\le\mu$**, so $B^2/D_{\text{guar}}^2\ \ge\ B^2/\mu^2\ \ge\ 8\sigma$.

Against this, the trivial cap, no criticality, no L129, no spectral theory, just $\lVert M_k-M_j\rVert^2\le2\lVert M_k\rVert^2+2\lVert M_j\rVert^2$, reads $\lVert\tilde o\rVert^2\le2\sigma$. Therefore
$$\boxed{\ \frac{B^2}{D_{\text{guar}}^2}\ \ge\ 8\sigma\ =\ 4\cdot(2\sigma)\ \ge\ 4\,\lVert\tilde o\rVert^2\ }$$
**at every pure critical point and every pair, with no hypotheses beyond the setup.** The spectral bound overshoots the truth by a factor of at least $4$ in $\lVert\tilde o\rVert^2$, and it is at least $4\times$ weaker than a Cauchy–Schwarz step that uses none of the machinery.

### And it is bounding a quantity that is already known exactly

This is the sharper objection. **L68 is an identity, not an inequality**: $\lVert\tilde o\rVert^2=s_j+s_k-2\theta M_{jk}+2M_{jk}^2$ exactly, in the variables $s_j,s_k,M_{jk},\theta$. The printed $B$ is a function of $s_j,s_k,M_{jk},\theta,n$, the *same* data. So the "bound on $\lVert o^{(jk)}\rVert$" is not a bound on $\lVert o^{(jk)}\rVert$ at all; it is at best an inequality among five quantities one of which it purports to constrain. **The stated payoff ("$\lVert o^{(jk)}\rVert$ is bounded above"), is empty by construction.** The section's own closing sentence, *"the first bound in this item that comes from the record's spectral gap"*, describes a bound on something L68 pins to the last digit.

### The small-$\lvert M_{jk}\rvert$ regime the brief suspected

Confirmed, and it is the generic regime. As $\mu\to0^+$ with $\sigma$ fixed, $D_{\text{guar}}=\mu\to0$ while $B^2\to s_j^2+s_k^2+(s_j-s_k)^2/(n-2)>0$, so the bound reads $\lVert\tilde o\rVert\le O(1/\mu)\to\infty$. It degrades exactly where cross pairs live: $\mu=\theta/(n-1)$ on the sphere-product family, so $\mu\to0$ as $n$ grows and the bound degrades like $n$. At $S^5\times S^{43}$ it returns $\lVert\tilde o\rVert\le13.78$ against the exact value $0.662$, a factor of $21$.

### $T>0$, and the $M_{jk}>0$ side

- **$T>0$ is not free, but it is provable in the band**, and the section never noticed it needed an argument. Criticality gives $(M^2)_{jk}=M_{jk}(\theta-M_{jk})=-\mu(\theta+\mu)$, and Cauchy–Schwarz on the rows gives $\lvert(M^2)_{jk}\rvert\le\sqrt{s_js_k}\le\sigma/2\le1$. So $\mu^2+\theta\mu-1\le0$, i.e. $\mu\le\tfrac12\big(\sqrt{\theta^2+4}-\theta\big)$, which is $<\theta$ exactly when $\theta>1/\sqrt2$. **In the band ($\theta$ near $\sqrt{3/2}$) $T>0$ holds; below $\theta=1/\sqrt2$ nothing rules out $T\le0$, where L129 is silent entirely.**
- **$T\le\theta$ iff $M_{jk}\le0$**, trivially. For $M_{jk}>0$, $T>\theta$ sits **outside** the forbidden window and L129 gives nothing: the spectrum is unconstrained above $\theta$, so $\operatorname{dist}(T,\operatorname{spec}M)$ can be arbitrarily small and the bound is contentless. This is not hypothetical, [post F48](../findings/second-order.md)'s padded witness has $T=\theta$ with an eigenvalue just above it.

**So the mechanism reaches only $M_{jk}<0$ with $\theta>1/\sqrt2$, and there it is vacuous.**

---

## 1–3. Re-derivation from the definitions

### The exact identity, in two lines

For $a\in I$, $(M\tilde o)_a=\sum_bM_{ab}(M_{kb}-M_{jb})=(M^2)_{ak}-(M^2)_{aj}$. Both pairs $(a,k)$ and $(a,j)$ are off-diagonal, so criticality applies to each:
$$(M\tilde o)_a=\theta(M_{ak}-M_{aj})-(M_{ak}^2-M_{aj}^2)=\tilde o_a\big(\theta-M_{aj}-M_{ak}\big)\qquad(a\in I).$$
Subtracting $T\tilde o_a=(\theta+M_{jk})\tilde o_a$ gives the **exact residual**
$$\boxed{\ (M\tilde o)_a-T\tilde o_a=-\,\tilde o_a\big(M_{aj}+M_{ak}+M_{jk}\big)\qquad(a\in I).\ }$$

This is manifestly **$a$-dependent**. Claim 1 is false.

### Where the derivation breaks

The section writes: *"Zero row sums kill the first half of each bracket, $\sum_bM_{ib}=0$."* [r396](REVIEW_r396.md)'s identity was derived from [post F47](../findings/second-order.md)'s $\widetilde No=To$ on $I$, so **its sums run over $b\in I$**, where
$$\sum_{b\in I}M_{ib}=-M_{ij}-M_{ik}\ \ne\ 0 .$$
The zero-row-sum kills the bracket only over $b\in[n]$, a different sum, with a different value. The step silently swaps one for the other. Written out, $\sum_{b\in I}M_{ib}(o_i-o_b)=-To_i$ (true, and equivalent to F47), whereas $\sum_{b\in[n]}M_{ib}(\tilde o_i-\tilde o_b)=-(M\tilde o)_i=-To_i+\tilde o_i(M_{ij}+M_{ik}+M_{jk})$. **The discarded term is exactly the residual the claim asserts away.**

### $c$ is the mean, and the section's own computation proves it

The value of $c$ checks, and the way it checks identifies its status. Summing the exact residual over $I$:
$$\sum_{a\in I}\tilde o_aM_{aj}=(M^2)_{jk}-s_j+M_{jk}^2,\qquad \sum_{a\in I}\tilde o_aM_{ak}=s_k-(M^2)_{jk}-M_{jk}^2,$$
(each from the full-$[n]$ sum minus the $a=j$ and $a=k$ terms), so $\sum_{a\in I}\tilde o_a(M_{aj}+M_{ak})=s_k-s_j$, and with $\sum_{a\in I}\tilde o_a=0$,
$$\sum_{a\in I}\big[(M\tilde o)_a-T\tilde o_a\big]=s_j-s_k\ \Longrightarrow\ \text{mean}=\frac{s_j-s_k}{n-2}=c .$$
**The section's $c$ is right, and it is the average of a non-constant quantity.** Summing over $I$ is the only operation the derivation performs, so it could never have detected the difference.

### Two side corrections

- **$\sum_{a\in I}\tilde o_a=0$ holds, but the stated reason is incomplete.** $M\mathbf1=0$ gives $\mathbf1^\top\tilde o=0$ over all of $[n]$; the $I$-sum vanishes because $\tilde o_j+\tilde o_k=M_{jk}-M_{jk}=0$, which is hollowness and symmetry. Conclusion correct, justification short by a step.
- **The printed consistency check fails twice.** $\mathbf1^\top M\tilde o=0$ and $\mathbf1^\top(T\tilde o+c\mathbf1+r_je_j+r_ke_k)=cn+(r_j+r_k)=cn-cn=0$. Both sides give **$0$, not $-cn$**. And the check is **circular** (it is the equation that defined $c$) so it has no power to detect the error even stated correctly.

### What survives at $j$ and $k$

Both boundary values verify exactly. $(M\tilde o)_j=(M^2)_{jk}-(M^2)_{jj}=(M^2)_{jk}-s_j$ and $T\tilde o_j=\theta M_{jk}+M_{jk}^2$, and criticality $(M^2)_{jk}=\theta M_{jk}-M_{jk}^2$ gives $\rho_j:=(M\tilde o)_j-T\tilde o_j=-s_j-2M_{jk}^2$; symmetrically $\rho_k=s_k+2M_{jk}^2$. So the **repaired** identity is
$$M\tilde o=T\tilde o+d+\rho_je_j+\rho_ke_k,\qquad d_a=-\tilde o_a(M_{aj}+M_{ak}+M_{jk})\ \text{on }I,\quad d_j=d_k=0,$$
with $\sum_{a\in I}d_a=s_j-s_k$. **The printed relation is this one with $d$ replaced by its mean.**

### Consequence for claim 5: the printed inequality is *stronger* than the true one

By Cauchy–Schwarz, $\sum_{a\in I}d_a^2\ge(\sum_ad_a)^2/(n-2)=(s_j-s_k)^2/(n-2)$, so
$$\lVert M\tilde o-T\tilde o\rVert^2=\sum_{a\in I}d_a^2+\rho_j^2+\rho_k^2\ \ge\ B^2,$$
**with equality exactly when $d$ is constant on $I$, i.e. exactly when claim 1 holds.** So $B$ is the Cauchy–Schwarz *minimum* of the true defect given its mean: the printed $B$ discards the residual's variance. The correct inequality is $\operatorname{dist}(T,\operatorname{spec}M)\lVert\tilde o\rVert\le\lVert M\tilde o-T\tilde o\rVert$, and the printed one asserts the strictly smaller ceiling $B$. **It is not implied by the correct one and it is not proved.** I have no falsifier for the printed inequality itself, but that is because it is far too weak to be violated, which is the vacuity result above, not evidence for the identity.

### "Approximate eigenvector" overstates it

At the six points below the true defect runs $31\%$–$48\%$ of $T\lVert\tilde o\rVert$. A vector whose residual is a third of the leading term is not an approximate eigenvector in any usable sense.

---

## 4. The twin-pair check, verified by hand, and it tests nothing

At a twin pair, $M_{ja}=M_{ka}$ for all $a\in I$, so $\tilde o=M_{jk}(e_j-e_k)$ and $\lVert o\vert_I\rVert^2=0$. L68 then gives $s_j+s_k=2\theta M_{jk}$, and $s_j=s_k$ by twinness, so $s_j=s_k=\theta M_{jk}$, which forces **$M_{jk}>0$** and hence $T>\theta$, outside L129's window. Then $c=0$, $\rho_k=-\rho_j=M_{jk}(\theta+2M_{jk})$.

Left side: $M(e_j-e_k)$ has entries $M_{aj}-M_{ak}=-\tilde o_a=0$ for $a\in I$, $-M_{jk}$ at $j$, $+M_{jk}$ at $k$, so $M(e_j-e_k)=-M_{jk}(e_j-e_k)$ and $M\tilde o=-M_{jk}^2(e_j-e_k)$.
Right side at $j$: $(\theta+M_{jk})M_{jk}-\theta M_{jk}-2M_{jk}^2=-M_{jk}^2$; at $k$: $+M_{jk}^2$. Equal. $\square$

**Every step is correct.** But $\tilde o$ vanishes on $I$, so $d\equiv0$ there and $B$ equals the true defect identically. **The check is performed at the unique configuration where the disputed term is zero by construction.** It confirms the boundary bookkeeping and says nothing about the claim it was offered to support.

---

## The counterexample, exact and by hand

Take the two-block family on $P\sqcup Q$, $\lvert P\rvert=p$, $\lvert Q\rvert=q$, $n=p+q$: $M_{ab}=\alpha$ inside $P$, $\beta$ inside $Q$, $\gamma$ across. Zero row sums force $(p-1)\alpha=-q\gamma$ and $(q-1)\beta=-p\gamma$; off-diagonal criticality on the three block types reduces to $(p-1)\alpha^2+q\gamma^2=\theta\alpha$, its $Q$-mirror, and $\gamma+(p-1)\alpha+(q-1)\beta=\theta$. Substituting the row sums, the third gives $\gamma=-\theta/(n-1)$ and the first two become identities. **So with $g:=\theta/(n-1)$: $\gamma=-g$, $\alpha=qg/(p-1)$, $\beta=pg/(q-1)$, $\theta=(n-1)g$, for every $p,q$**, the diagonal critical points of the sphere-product family, and $\operatorname{tr}M^2=2$ fixes $g$.

For a cross pair $j\in P$, $k\in Q$ (so $M_{jk}=\gamma<0$, the regime L129 reaches):
$$\tilde o_a=\gamma-\alpha=-\tfrac{(n-1)g}{p-1}\ (a\in P\setminus j),\qquad \tilde o_a=\beta-\gamma=\tfrac{(n-1)g}{q-1}\ (a\in Q\setminus k),$$
$$d_a=-\tilde o_a(\alpha+2\gamma)\ (a\in P\setminus j),\qquad d_a=-\tilde o_a(\beta+2\gamma)\ (a\in Q\setminus k).$$

**At $S^5\times S^7$** ($p=5$, $q=7$, $n=12$, $\theta=11g=1.228239$): $\alpha=\tfrac74g$, $\beta=\tfrac56g$, $\tilde o=-\tfrac{11}4g$ on the four $P$-indices and $+\tfrac{11}6g$ on the six $Q$-indices, and
$$d_a=-\tfrac{11}{16}g^2\ \text{(four times)},\qquad d_a=+\tfrac{77}{36}g^2\ \text{(six times)},\qquad \text{mean}=\tfrac{121}{120}g^2=c .$$
$-0.6875g^2$ against $+2.138889g^2$, mean $1.008333g^2$. **The residual takes two values of opposite sign; the claimed constant is their average.** $\square$

**At $S^6\times S^6$** ($\theta=11g=1.236033$, the programme's equality case): $s_j=s_k$ so $c=0$, while $d=\mp\tfrac{44}{25}g^2$ on the two halves. **The claimed constant is $0$ and the residual is nowhere $0$.**

### Screen

Six members of the family, built for this review; off-diagonal criticality residual $\le2.2\times10^{-16}$ and $\operatorname{tr}M^2=2$ to $10^{-12}$ at each. Every column below was derived by hand above and is reproduced digit for digit.

| $(p,q)$ | $n$ | $\theta$ | $c$ | residual on $I$ | $\lVert\tilde o\rVert$ $=$ L68 | $B$ | true defect | $D_{\text{guar}}$ | bound gives $\lVert\tilde o\rVert\le$ | trivial cap $\sqrt{2\sigma}$ |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| $(6,6)$ | 12 | 1.236033 | 0 | $-0.022222\ \ldots\ +0.022222$ | 0.797724 | 0.271415 | 0.280364 | 0.112367 | **2.4154** | 0.8165 |
| $(5,7)$ | 12 | 1.228239 | 0.012571 | $-0.008571\ \ldots\ +0.026667$ | 0.808397 | 0.301916 | 0.306812 | 0.111658 | **2.7039** | 0.8418 |
| $(5,43)$ | 48 | 1.263631 | 0.007852 | $+0.001521\ \ldots\ +0.074317$ | 0.662310 | 0.370551 | 0.395805 | 0.026886 | **13.7824** | 0.8594 |
| $(4,8)$ | 12 | 1.201561 | 0.027500 | $+0.026786\ \ldots\ +0.029167$ | 0.843424 | 0.396372 | 0.396387 | 0.109233 | **3.6287** | 0.9220 |
| $(3,9)$ | 12 | 1.141798 | 0.048889 | $+0.024074\ \ldots\ +0.148148$ | 0.914529 | 0.579785 | 0.600651 | 0.103800 | **5.5856** | 1.0750 |
| $(7,11)$ | 18 | 1.286796 | 0.006899 | $-0.002706\ \ldots\ +0.012662$ | 0.673066 | 0.207884 | 0.210004 | 0.075694 | **2.7464** | 0.7025 |

Four readings, all of which match the analysis:

- **The residual is non-constant at all six**, and the mean equals $c$ at all six to machine precision.
- **$\lVert\tilde o\rVert$ equals the L68 value at all six**, claim 5's norm identity stands.
- **$B<$ true defect at all six**, as the Cauchy–Schwarz argument requires.
- **The bound exceeds the trivial cap at all six**, by factors $3.0$, $3.2$, $16.0$, $3.9$, $5.2$, $3.9$ in the norm, i.e. $9$ to $257$ in the square, comfortably above the guaranteed $4$.

*The recovered $\theta$ values $1.236033$ and $1.228239$ are the record's $1.236031$ ($S^6\times S^6$) and $1.228239$ ($S^5\times S^7$) from [INDEX-values.md](../findings/INDEX-values.md), which is the independent check that the construction is the right family.*

---

## Novelty

**The true content is [post F47](../findings/second-order.md) rewritten.** F47 records $\widetilde No=To$ on $I$ with $\widetilde N=M^{(jk)}+\operatorname{diag}(u+v)$, $u_a=M_{aj}$, $v_a=M_{ak}$. Since $(M\tilde o)_a=(M^{(jk)}o)_a-M_{jk}o_a$ for $a\in I$, the two statements are related by one line of algebra:
$$(M\tilde o)_a=To_a-(u_a+v_a+M_{jk})o_a=\tilde o_a(\theta-M_{aj}-M_{ak}),$$
which is the exact identity derived above. **Moving the diagonal shift from one side to the other adds no information**, so the framing *"not merely an eigenvector of the compressed $\widetilde N$; it is an approximate eigenvector of $M$ itself"* describes the same fact twice, and the second description is the weaker one, $\widetilde No=To$ is exact, $M\tilde o\approx T\tilde o$ is not even approximately true.

Genuinely absent from [findings/](../findings/): the extension $\tilde o$ to all of $[n]$, the boundary values $(M\tilde o)_j$, $(M\tilde o)_k$, and the constant $c=(s_j-s_k)/(n-2)$, searched for the extension, the constant and the $(n-2)$ denominator across [findings/](../findings/) and [ATTEMPTS.md](../ATTEMPTS.md), with hits only in the section under review. **All three are two-line consequences of hollowness and criticality, and the only one carrying a claim beyond bookkeeping is the false one.**

---

## What is worth keeping

1. **The exact identity $(M\tilde o)_a=\tilde o_a(\theta-M_{aj}-M_{ak})$ on $I$.** Clean, and it says the interesting thing plainly: on $I$, $M$ acts on $\tilde o$ **diagonally**, with the multiplier read off two rows. It belongs as a remark under [post F47](../findings/second-order.md), which it restates.
2. **The boundary values $\rho_j=-s_j-2M_{jk}^2$ and $\rho_k=s_k+2M_{jk}^2$**, and $\sum_{a\in I}d_a=s_j-s_k$. Correct, elementary, previously unrecorded.
3. **The fence.** A successor should not re-open this: *at every pure critical point and every pair with $M_{jk}<0$, any bound on $\lVert\tilde o\rVert$ derived from L129 plus the residual's mean is at least $4\times$ weaker in the square than $\lVert\tilde o\rVert^2\le2(s_j+s_k)$, and $\lVert\tilde o\rVert^2$ is in any case an identity by L68.* The obligation [r395](REVIEW_r395.md) and [r396](REVIEW_r396.md) both named (**L68 prices the norm, $\Sigma$ needs the entry-spread**), is untouched by this section, which spends its effort on the norm.
4. **$T>0$ needs $\theta>1/\sqrt2$**, provable from criticality and Cauchy–Schwarz as above. Worth recording wherever $T=\theta+M_{jk}$ is used with a sign assumption.

## What must be withdrawn

The boxed relation $M\tilde o=T\tilde o+c\mathbf1+r_je_j+r_ke_k$, the sentence *"the residual vanishes identically on $I$, so the whole statement is exact on $[n]$"*, the "approximate eigenvector of $M$" framing, and the whole final section's payoff, including the suggestion that an exact eigenvector at $T$ would force $M_{jk}\ge0$ at every pair, which rests on the withdrawn relation.
