# Reviewer 76, Gate 2 on the three commits since d657dcc

Same brief as [Reviewer 75](REVIEW_r75.md), independently. Own $Q$ agrees with [review_r30_core.py](../scripts/review_r30_core.py) to $5.3\times10^{-15}$.

**Agrees with R75 on every verdict.** Both independently found the same refutation of the target and the same gradedness defect.

| # | claim | verdict |
|---|---|---|
| 1 | frame-independent diagonality | (a),(b) **CONFIRMED as proofs**; (c) confirmed, but the silence is **avoidable** |
| 2 | the correction to Reviewer 74 | **CONFIRMED**, in every part |
| 3 | the coverage census | **REFUTED**, three independent counts |
| 4 | $\mathbb{CP}^m$ below threshold | **CONFIRMED**, closed form re-derived |
| 5 | "no band point exceeds $\sqrt{3/2}$" | **REFUTED, and it takes the B-band target with it** |

## The headline: the target is false, with an exact witness

Built $W$ for $S^5\times S^7$ over $\mathbb Q$ and computed $Q(W)=W^2+W^\#$ exactly: **every off-diagonal entry of $Q(W)$ is exactly $0$, and $Q(W)_{aa}/W_{aa}=\tfrac{11}{35}$ for all 66 entries.** Hence $\theta^2=\tfrac{264}{175}$ and $\theta^2-\tfrac32=\tfrac3{350}>0$.

Same closed form as R75. Band membership is $pq<\lfloor n^2/4\rfloor$, i.e. **exactly $p\ne q$**. With $p=s-1$, $q=s+1$, $n=2s$ the target fails iff $s^3-7s^2+7s-3>0$, i.e. **at every $n\ge12$**:

| $n$ | 8 | 10 | **12** | 14 | 16 | 20 | 24 |
|---|---|---|---|---|---|---|---|
| $\theta$ | 1.1155 | 1.1859 | **1.2282** | 1.2569 | 1.2778 | 1.3061 | 1.3246 |
| $\theta/\theta_0(n)$ | 0.9295 | 0.9882 | **0.9937** | 0.9962 | 0.9976 | 0.9988 | 0.9993 |

$\theta^2\to2$, so **no constant below $\sqrt2$ bounds $\theta$ on the band**, unrepairable by enlarging the constant. Padding carries the witness to odd $n$. **$n\ge12$ is exactly where the target was wanted**, since $\sqrt{3/2}<\theta_0(n)$ first holds there. The target is false on its entire domain of usefulness.

## The census, refuted three ways

**(i) It omits the band points that matter**, not one unbalanced sphere product at $n\ge12$, precisely the family that breaks the target.

**(ii) "Covered by B1" is a different inequality from the target.** B1's grant is $\sup\{\theta:S=0,\text{diagonal}\}<\theta_0(n)$, strictly weaker than $\sqrt{3/2}$ at every $n\ge12$. $S^5\times S^7$ proves it: **B1-covered and above the threshold.** So the B1 column cannot ever deliver the band target; "zero uncovered" is bookkeeping in the wrong currency. Same for H, whose conclusion is a classification, not a bound.

**(iii) The gradedness test is unjustified at the four rows with a kernel**, and the census's own falsifier fires. Taking $\mathfrak h=\mathfrak m^\perp$: $S_{\mathfrak{mhh}}=32,144,96,24$ at $\mathbb{CP}^2{+}\mathbb{CP}^2$, $\mathbb{CP}^3{+}\mathbb{CP}^3$, $\mathbb{CP}^2{}^{\times3}$, padded $\mathbb{CP}^3$, **none graded**. So **padded $\mathbb{CP}^3$ loses H, is non-diagonal (proved), has $\dim E(1)=1$: no B1, no B2, no H.** A band point covered by none of the three.

## Claim 1(c): the silence is avoidable

The top eigenspace of $\mathbb{CP}^k\oplus\cdots\oplus\mathbb{CP}^k$ is the span of the $r$ block Kähler forms, which have **disjoint supports** and rank $2k$ each, so every nonzero combination has rank $\ge2k\ge4>2$, no decomposable, hence non-diagonal, proved. ($\min\sigma_3$ over 4000 random unit elements: $0.500$, $0.415$, $0.408$.)

It also built $T_k(W):=-\sum_a\lambda_a^kX_a^2$, basis-independent within eigenspaces and diagonal in any frame diagonalising $W$; when some $T_k$ has simple spectrum the frame is unique and the test is necessary-and-sufficient. Refutes diagonality at random Weyl tensors, silent at $\mathbb{CP}^m$, $C_5$ and sphere products where all $T_k$ are scalar.

## Outside the brief

- **The band is asymptotically extremal, not merely "nearly tight".** $\theta/\theta_0(n)$ along $S^{n/2-1}\times S^{n/2+1}$ runs $0.9937,0.9976,0.9988,0.9997,0.99996$ at $n=12,16,20,30,60$. It presses against Conjecture A itself.
- **The "two horns, not a slope" picture is wrong.** The middle contains points at $\dim\mathfrak m=\lfloor n^2/4\rfloor-1$ with $\theta$ within $0.07\%$ of the cap horn. There is no gap between middle and cap in either coordinate.
- **The $C_5$ blow-up is not the load-bearing point** [plan.md](../plan.md) names, it sits at $\theta=0.671$, under $55\%$ of the threshold. The real one is $S^5\times S^7$ at $1.228$, which the diagonal grant does not bound below $\sqrt{3/2}$ at all.
- **28 catalogued band points exceed $\sqrt{3/2}$** in $6\le n\le24$, max $1.324617$ at $S^{11}\times S^{13}$, $8.2\%$ *above* the recorded ceiling, not $3.2\%$ below.
- [b_frame_independent_diagonality.py](../scripts/b_frame_independent_diagonality.py)'s `verdict` has a dead branch (both remaining returns are `'undetermined'`). Cosmetic.
