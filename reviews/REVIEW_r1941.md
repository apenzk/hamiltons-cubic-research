# REVIEW r1941: I124 batch 8, support reduction to the indices nu touches

Log: [agent_logs/r1941-i124-support.log](../agent_logs/r1941-i124-support.log). Section under review: batch 8 of [2026-09-28q-I124-ascent.md](2026-09-28q-I124-ascent.md). Analysis only, no numerical screen run. One Lean call (axioms of the two cited declarations).

**Verdict: GAP.** The support reduction is correct and is the batch's real content. The $\lvert U\rvert\le6$ clause, and with it the I104 conclusion and the "at least seven" bullet, rests on $M(6)\le\sqrt{3/2}$, which the record asserts but does not prove. What is proved supports $\lvert U\rvert\le5$.

| # | claim | verdict |
|---|---|---|
| 1 | formula for $\hat A$, coefficient positive | CONFIRMED |
| 2 | support of $\pi_D(\nu\circ\nu)$ inside $U$ | CONFIRMED, with a cleaner proof |
| 3 | padding and $\theta$ invariance | CONFIRMED |
| 4 | $M(m)$ at $m=4,5,6$, $\mathcal W_m=0$ at $m\le3$ | REFUTED at $m=6$ (unproved on the record); $m=4$ proved, $m=5$ a machine certificate, $m\le3$ right |
| 5 | I104 configuration, six indices, $R=0$ | PLAUSIBLE: $\lvert U\rvert\le6$ right (equal to 6 iff two blocks are nonzero), $R=0$ is a genuine branch, the conclusion is conditional on $M(6)$, and at $\tau\le0$ it is already [L221](../findings/second-order.md)(b) |
| 6 | the two bullets | REFUTED as stated ("seven" needs $M(6)$), repair below |
| 7 | Lean | CONFIRMED WITH OBSERVATION |
| 8 | record search | the reduction is new, generalising batch 6 (2) |

## 1. The formula and the coefficient: CONFIRMED

The $D$ component of $Q(W)=\theta W$ is $a^2Q(\hat A)+2ab\,\pi_D(\hat A\circ\nu)+b^2\pi_D(\nu\circ\nu)=\theta a\hat A$, and the cross term vanishes because $D\circ D\subseteq D$ gives $\langle\hat A\circ\nu,x\rangle=\langle\hat A\circ x,\nu\rangle=0$ for $x\in D$. With $Q(\hat A)=p\hat A$ this is $b^2\pi_D(\nu\circ\nu)=a(\theta-ap)\hat A$. Here $p=P(\hat A)\le\Theta_n\le\theta$ by L57, and $0<a<1$ because $b>0$. If $p\le0$ then $\theta-ap\ge\theta>0$. If $p>0$ then $ap<p\le\theta$. So the coefficient is strictly positive and the formula holds.

One step the proof leaves tacit: $\pi_D$ of a Weyl tensor is its coordinate-diagonal part. The diagonal part $\sum_{a<b}K_{ab}\varphi_{ab}\varphi_{ab}^{\mathsf T}$ of a Weyl tensor satisfies Bianchi (all four-distinct-index terms vanish), has zero off-diagonal Ricci, and has diagonal Ricci $\sum_bK_{ab}=\mathrm{Ric}_W(a,a)=0$. So it lies in $D$, and $\nu\perp D$ has zero diagonal entries. This is what makes $\nu$'s expansion run over $\varphi_\alpha\odot\varphi_\beta$ with $\alpha\ne\beta$ only, which the definition of $U$ presumes.

## 2. The support claim: CONFIRMED

The written chain is right but loose ("built from $\varphi_\alpha\varphi_\beta^{\mathsf T}\varphi_\gamma\cdots$"). A proof in two lines:

- $\varphi_\alpha\odot\varphi_\beta=\tfrac12\big[(\varphi_\alpha+\varphi_\beta)(\varphi_\alpha+\varphi_\beta)^{\mathsf T}-(\varphi_\alpha-\varphi_\beta)(\varphi_\alpha-\varphi_\beta)^{\mathsf T}\big]$ up to the record's normalisation of $\odot$, so $\nu=\sum_i\epsilon_iv_iv_i^{\mathsf T}$ with every $v_i\in\mathfrak{so}(U)=\Lambda^2\operatorname{span}\{f_i:i\in U\}$.
- $\nu^2=\sum\epsilon_i\epsilon_j\langle v_i,v_j\rangle v_iv_j^{\mathsf T}$ and $\nu\#\nu=\tfrac12\sum\epsilon_i\epsilon_j[v_i,v_j][v_i,v_j]^{\mathsf T}$ by bilinearity of $\#$. $\mathfrak{so}(U)$ is a subalgebra, since $[\varphi_{ab},\varphi_{cd}]$ is zero or $\pm\varphi$ on the symmetric difference, whose indices lie in $\{a,b,c,d\}$. So $Q(\nu)$ maps $\mathfrak{so}(n)$ into $\mathfrak{so}(U)$ and kills $\mathfrak{so}(U)^\perp$.

The bracket question the brief raises has answer no: a bracket of two bivectors in $\mathfrak{so}(U)$ never produces an index outside $U$. So $\pi_D(\nu\circ\nu)$, the diagonal part of $Q(\nu)$, sits on pairs inside $U$, and by item 1 so does $\hat A$. $W=a\hat A+b\nu$ is then an operator on $\mathfrak{so}(U)$ extended by zero. Note the conclusion uses pairs *inside* $U$, a set that can be larger than the set of pairs occurring in $\nu$. That is harmless.

## 3. Padding: CONFIRMED

For $i,j\in U$, $\mathrm{Ric}(i,j)=\sum_kW_{ikjk}$ over all $k\le n$, and a term with $k\notin U$ involves the pair $ik\notin\Lambda^2(U)$, so it vanishes. So the restriction to $\mathbb R^U$ is an algebraic curvature tensor with zero Ricci, a Weyl tensor of $\mathbb R^{\lvert U\rvert}$. $\theta$ is padding-invariant because $Q$ uses only products and brackets inside $\mathfrak{so}(U)$, the defining formula $(vv^{\mathsf T})^\#(ww^{\mathsf T})=\tfrac12[v,w][v,w]^{\mathsf T}$ carrying no $n$. The normalisation $I\#I=(n-2)I$ is a consequence of that formula, not an independent choice. This is the fact [L61](../findings/sym3-blocks.md)'s review states ("$\Lambda^2U=\mathfrak{so}(U)$ is a subalgebra"). Hence $\theta=P(W)\le M(\lvert U\rvert)$, and $M$ is non-decreasing in $m$ by padding.

## 4. The $M(m)$ values: REFUTED at $m=6$

| $m$ | on the record | kind of proof |
|---|---|---|
| $\le3$ | $\mathcal W_m=0$ | classical, right. With $b>0$, $\nu\ne0$ forces $\lvert U\rvert\ge4$ |
| 4 | $M(4)=\sqrt{3/2}$ | a hand proof: $P=9(\det W^++\det W^-)$ on $\mathcal W_4$ ([stratum-two-negative.md:293](../findings/stratum-two-negative.md), and the five-line proof L61's review describes) |
| 5 | $M(5)=\sqrt{3/2}$ | [L61](../findings/sym3-blocks.md): an exact rational SOS certificate plus [L62](../findings/sym3-blocks.md)'s exact rank. A machine certificate, "unverifiable by hand even in principle" per L61's own Gate 2 (r597, r598, GAP on the equality clause, the bound holds) |
| 6 | **only $M(6)\ge\sqrt{3/2}$** | no upper bound on file |

The cited sentence, [bispectral.md:465](../findings/bispectral.md) ("which the record certifies only at $n=4,6$"), points to no certificate at $n=6$. The record contradicts it in three places:

- [REVIEW_r649.md](REVIEW_r649.md): "What is proved is $M(6)\ge\sqrt{3/2}$, by padded $W_{\mathbb{CP}^2}$. The **only** attempted upper bound" is second-order.md's $M(6)\le1.6300$.
- [second-order.md:1118–1120](../findings/second-order.md): that upper bound is withdrawn, the number being an ascent value bounding $\Phi(15)$ from below.
- [bounds.md:609](../findings/bounds.md): "the record also proves only $M(6)\ge\sqrt{3/2}$". And [problem.md:156](../findings/problem.md) calls $W_{\mathbb{CP}^2}$ "the presumed global maximizer for $4\le n\le11$".

[conventions.md](../findings/conventions.md)'s row, [W5](../findings/INDEX-traps.md) and [W5.lean](../lean/HamiltonsCubic/Results/W5.lean) state $M(6)=\sqrt{3/2}$. W5.lean proves only $\theta_0(6)^2<3/2$ and not $M(6)$. Numerics sit near $\sqrt{3/2}$ at $n=6$ ([fence-posts.md](../findings/fence-posts.md) line 5, [stratum-two-negative.md:293](../findings/stratum-two-negative.md)'s chain at $1.224756$), which is evidence and not a bound.

What the batch needs is weaker than equality: $M(6)<\theta_0(n)$ for $n\ge12$, i.e. $M(6)<\theta_0(12)=1.23603$. That is still unproved. **Proved scope: $\lvert U\rvert\le5$ gives $\theta\le\sqrt{3/2}<\theta_0(n)$ at $n\ge12$.**

## 5. I104's configuration: PLAUSIBLE, conditional

- **Six indices.** $V_Q$ is spanned by $\varphi_{ij}\odot\varphi_{kl}$ over the pairings of $Q$, so its indices lie in $Q$. $\lvert Q_1\cap Q_2\rvert=2$ (the case making $Q_1\triangle Q_2$ a four-set) gives $\lvert Q_1\cup Q_2\rvert=6$, and $Q_3\subseteq Q_1\cup Q_2$. So $U\subseteq Q_1\cup Q_2$ and $\lvert U\rvert\le6$, with equality iff at least two $\nu_a$ are nonzero. "Has $\lvert U\rvert=6$" should read "$\le6$". With one nonzero block, $\lvert U\rvert=4$ and batch 6 or L220 applies.
- **$R=0$ is a branch, not automatic.** The $\mathcal D_n$ equation of the configuration is $D\circ D+\sum_a\nu_a\circ\nu_a=\theta D$ ([I104 note](2026-09-14-I104-tau-positive.md) line 357, L221(b) step 1), and $Q(\hat A)=p\hat A$ asks $\sum_a\pi_D(\nu_a\circ\nu_a)\propto D$, which is a constraint. The batch says "its $R=0$ branch", which is correctly scoped. The consequence is strong: on that branch $D$ is supported on the six indices, so the far-region content of I104 (a $D$ spread over all $n$) is absent there.
- **Conditional on $M(6)$.** With only $M(4)$ and $M(5)$ proved, the conclusion "outside I124's range" holds on this branch only given $M(6)<\theta_0(12)$.
- **Overlap with L221(b).** At $\tau\le0$, [L221](../findings/second-order.md)(b) already gives $\theta^2\le\tfrac65$ on the whole configuration with at least two nonzero blocks, with no $R=0$ hypothesis and no $M(6)$. What batch 8 adds for I104 is the branch $R=0$, $\tau>0$, and only conditionally.

## 6. The bullets: REFUTED as stated, repairable

- "At least seven frame indices" needs $M(6)$. On the record as it stands the bullet reads **at least six**.
- The character reading is right: $\varphi_\alpha\odot\varphi_\beta$ with $\alpha\ne\beta$ has character on $\alpha\triangle\beta$, of size 2 or 4. Size 2 is $\alpha=\{i,j\},\beta=\{i,k\}$, touching $i,j,k$. Size 4 is a disjoint pairing of four indices. These are the only two kinds.
- "What it does not reach" omits two cases. It omits $m=6$, while $M(6)$ is open. It also omits the R = 0 points with $\lvert U\rvert\ge12$, including $U$ the whole frame. Those are the generic case, the first bullet's "genuinely spread" points. The list names only $7\le m\le11$ and $R\ne0$. For $\lvert U\rvert\ge12$ the padding cap gives nothing, since $M(m)\ge\theta_0(m)$ there.

## 7. Lean: CONFIRMED WITH OBSERVATION

- [diag_coeff_pos](../lean/HamiltonsCubic/Results/I124Circle.lean) states $0<a(\theta-ap)$ from $0<a<1$, $0<\theta$, $p\le\theta$, which matches the table. The hypotheses are jointly satisfiable (e.g. $a=\tfrac12,\theta=1,p=0$), so it is non-vacuous. The case split on the sign of $p$ is the one in item 1.
- [threshold_pos](../lean/HamiltonsCubic/Results/L2.lean) states $0<n^2-12n+8$ over $\mathbb Z$ for $n\ge12$. It is not literally $\tfrac32<\theta_0(n)^2$, which needs `theta0Sq_sub_three_halves` in the same file and a cast. The table should name both.
- The formula for $\hat A$, the support and padding steps, and all $M(m)$ values are prose, as the table says.
- Axioms: both depend on `propext`, `Classical.choice`, `Quot.sound` only (`#print axioms`, this review). The side example `theta0Sq 12 > 3/2` also compiled.

## 8. Record search

- **The general reduction is new.** Batch 6 (2) is its instance for one four-set, and [L220](../findings/second-order.md) step 2 computes $\nu\circ\nu\in\Pi_Q$ for one block. Neither states the $U$-reduction for arbitrary $\nu$. [support-dichotomy.md](../findings/support-dichotomy.md) is about $\circ$-decomposition, with no padding. [L61](../findings/sym3-blocks.md)'s review notes that "no maximiser has 5-dimensional support" is "a statement the record does not make". Batch 8 at $\lvert U\rvert\le5$ makes the critical-point, $R=0$ version of it.
- **L224** (one pair block, $\sup P=\Theta_n$) needs no padding, and it is compatible: a pair character $\{j,k\}$ touches $j,k$ and every $i$ with $x_i\ne0$, so padding caps it only when $\lvert\operatorname{supp}x\rvert\le3$.
- **The [I121 note](2026-09-28-I121-MG-audit.md)** (lines 64–65) locates $W$ in $\mathcal D_n\oplus\bigoplus V_S$ and lists L220, L221 and L224 as the bounded cases. It has no padding argument.
- **The [I104 note](2026-09-14-I104-tau-positive.md)** works with $D\in\mathcal D_n$ throughout and has no $R=0$ reduction.
- Classification: **new**, generalising batch 6 (2). The I104 corollary at $\tau\le0$ agrees with L221(b), and at $\tau>0$ it is new and conditional on $M(6)$.

## Repair

1. In the statement, replace "$\lvert U\rvert\le6$" by "$\lvert U\rvert\le5$", with the cite: $M(4)$ by hand, $M(5)$ by L61's certificate. Add "and at $\lvert U\rvert=6$ given $M(6)<\theta_0(12)$, which the record does not prove".
2. I104: "$\lvert U\rvert\le6$", and the $R=0$, $\tau>0$ branch is outside I124's range conditionally on $M(6)$. At $\tau\le0$ the configuration is already L221(b).
3. Bullet 1: "at least six" unconditionally, "seven" given $M(6)$.
4. Bullet 2: add $m=6$ and the $R=0$ points with $\lvert U\rvert\ge12$.
5. Fix the record's false sentence at [bispectral.md:465](../findings/bispectral.md) and the $M(6)$ clauses of [conventions.md](../findings/conventions.md), [W5](../findings/INDEX-traps.md) and [W5.lean](../lean/HamiltonsCubic/Results/W5.lean)'s docstring. This trap produced the batch's error, and it will recur.
6. Lean table: name `theta0Sq_sub_three_halves` beside `threshold_pos`.
