# Reviewer 124, the $Z(v)$ projection and the fourth-moment lemma, both parities

Target: the three steps of the all-$n$ diagonal theorem, [item 1 of plan.md](../plan.md), as written in [problem.md](../findings/problem.md). Five claims, five verdicts. Numerics in [run_r124_fourth_moment.py](../scripts/runs/run_r124_fourth_moment.py), which asserts every statement below that a machine can assert.

| # | Claim | Verdict |
|---|---|---|
| 1 | $Z(v)\in\mathcal D_n$ | **CONFIRMED** |
| 2 | $Z(v)$ is the orthogonal projection of $(v_iv_j)$ | **CONFIRMED** |
| 3 | Even $n$: $\sum v^4\ge1/n$, sharp, equality forced two-valued | **CONFIRMED** |
| 4 | Odd $n$: $\min\sum v^4=\frac{n^2+3}{n(n^2-1)}$ at the $\big(\tfrac{n-1}2,\tfrac{n+1}2\big)$ split | **CONFIRMED, closed here, proof below** |
| 5 | Odd equality case: $Z(v)\parallel$ vertex matrix of $S^{(n-1)/2}\times S^{(n+1)/2}$ | **CONFIRMED** for $n\ge5$ |

**The headline: claim 4 is closed.** The smoothing argument the source asserts and never supplies is not needed. Lagrange bounds the value count at three; the two-value branch has a closed form; and the three-value branch collapses to a *one-parameter-free* family indexed by the multiplicities alone, on which the objective is a single explicit rational function of $(m_1,m_2,m_3)$ bounded below by $\tfrac1{n-1}$ through a polynomial identity with nonnegative coefficients. No screen, no numerics in the logic.

## 1. $Z(v)\in\mathcal D_n$, CONFIRMED

Symmetry and hollowness are definitional. For the row sums the sharp statement is the *unconditional* identity, which is worth recording because it also answers question (a):

$$\sum_{j\ne i}Z_{ij}=\Big(\sum_k v_k\Big)v_i+\frac{\sum_k v_k^2-1}{n-2}\qquad\text{for every }v\in\mathbb R^n .$$

Derivation: $\sum_{j\ne i}v_iv_j=v_i(s-v_i)$ with $s=\sum v$; $\sum_{j\ne i}\frac{v_i^2+v_j^2}{n-2}=\frac{(n-1)v_i^2+(q-v_i^2)}{n-2}=v_i^2+\frac q{n-2}$ with $q=\sum v^2$; and the constant contributes $-\frac1{n-2}$. The $v_i^2$ terms cancel, leaving the display. Setting $s=0$, $q=1$ gives $0$, which is exactly the claimed computation. The claimed proof is correct as written.

## 2. $Z(v)$ is the orthogonal projection, CONFIRMED

Two things must hold, and both do. The residual is $(v_iv_j)-Z_{ij}=a_i+a_j+c$ with $a_i=-v_i^2/(n-2)$ and $c=\frac1{(n-1)(n-2)}$, a term-by-term identity, no hypothesis used. And for any $T\in\mathcal D_n$,

$$\sum_{i<j}(a_i+a_j+c)T_{ij}=\tfrac12\sum_{i\ne j}(a_i+a_j+c)T_{ij}=\sum_i a_i\sum_{j\ne i}T_{ij}+\tfrac c2\sum_i\sum_{j\ne i}T_{ij}=0 .$$

The two halves (residual $\perp\mathcal D_n$, and $Z\in\mathcal D_n$), are exactly what characterises the orthogonal projection onto a subspace, so the conclusion follows. Verified numerically to $2\times10^{-15}$ against random $T\in\mathcal D_n$ at $n=5,\dots,12$.

A gauge remark that the record should carry, since it is the first thing a careful reader will trip on: the pair $(a,c)$ is *not* unique, because $a_i\mapsto a_i+t$, $c\mapsto c-2t$ leaves $a_i+a_j+c$ fixed. The canonical $c=0$ representative is $a_i=\big(r_i-\tfrac R{2n-2}\big)/(n-2)$ with $r_i$ the row sums of the array being projected and $R=\sum_i r_i$; at $t=\frac1{2(n-1)(n-2)}$ that is the stated pair. Nothing is wrong, but the stated pair is one of a line of them.

## 3. Even $n$, CONFIRMED, and the equality case is forced

Cauchy–Schwarz on $(v_i^2)$ against $\mathbf1$ gives $1=(\sum v_i^2)^2\le n\sum v_i^4$. Equality holds **iff** $(v_i^2)$ is parallel to $\mathbf1$, i.e. every $v_i^2=1/n$, i.e. $v_i=\pm1/\sqrt n$; and then $\sum v=0$ forces exactly $n/2$ of each sign, which needs $n$ even and is realisable there. So at even $n$ the bound is attained and the equality set is *precisely* the balanced $\pm1/\sqrt n$ vectors, one orbit under permutation, with the global sign flip already inside that orbit.

This answers question (c) in the strong direction: **forced, not merely permitted.** The "iff" in the Cauchy–Schwarz equality condition does all of it, so no smoothing argument is needed and none is hidden. The claim is exactly right.

## 4. Odd $n$, CONFIRMED, and here is the proof

**Lemma.** Let $n\ge5$ be odd and $v\in\mathbb R^n$ with $\sum v_i=0$, $\sum v_i^2=1$. Then

$$\sum_i v_i^4\ \ge\ \frac{n^2+3}{n(n^2-1)},$$

with equality **iff**, up to permutation and a global sign, $v$ has $\tfrac{n-1}2$ entries equal to $+\sqrt{\tfrac{n+1}{n(n-1)}}$ and $\tfrac{n+1}2$ entries equal to $-\sqrt{\tfrac{n-1}{n(n+1)}}$.

### Step 1, at most three values, and the roots sum to zero

The feasible set is the compact smooth $(n-2)$-sphere $\{\sum v=0\}\cap\{\sum v^2=1\}$. The constraint gradients $\mathbf1$ and $2v$ are linearly independent at every feasible point, since $v\parallel\mathbf1$ together with $\sum v=0$ forces $v=0$. So LICQ holds everywhere and a minimiser satisfies $4v_i^3=\alpha+2\beta v_i$ for all $i$: every coordinate is a root of

$$4X^3-2\beta X-\alpha=0 .$$

At most three distinct values. **And the cubic is depressed** (no $X^2$ term) so *if all three roots are used*, they sum to zero. That relation is the whole engine of step 3 and it is what the record's "up to four values" bookkeeping throws away; see the remark at the end of this section.

### Step 2, the two-value branch, in closed form

Values $r_1\ne r_2$ with multiplicities $p,q=n-p$. Then $pr_1+qr_2=0$ gives $r_2=-pr_1/q$, and $pr_1^2+qr_2^2=1$ gives $r_1^2=\frac q{np}$, $r_2^2=\frac p{nq}$. Hence

$$\sum v^4=\frac{q^2}{n^2p}+\frac{p^2}{n^2q}=\frac{p^3+q^3}{n^2pq}=\frac{n^2-3pq}{npq}=\frac n{pq}-\frac3n .$$

Strictly decreasing in $pq$. Over integers $p+q=n$ with $n$ odd, $pq\le\frac{n^2-1}4$ with equality only at $\{p,q\}=\{\tfrac{n-1}2,\tfrac{n+1}2\}$, and there the value is $\frac{4n}{n^2-1}-\frac3n=\frac{n^2+3}{n(n^2-1)}$. (At even $n$, $pq\le n^2/4$ gives $1/n$, matching claim 3.)

### Step 3, the three-value branch is a finite family with no free parameter

Let $v$ take exactly three values $r_1,r_2,r_3$ with multiplicities $m=(m_1,m_2,m_3)$, $\sum m_i=n$, $m_i\ge1$. Two linear conditions hold: $r_1+r_2+r_3=0$ from the depressed cubic, and $\sum m_ir_i=0$ from the constraint.

*If $m$ is not constant*, $\mathbf1$ and $m$ are independent, so the solution space of those two equations is exactly one-dimensional and is spanned by

$$u=\mathbf1\times m=(m_3-m_2,\;m_1-m_3,\;m_2-m_1).$$

Thus $r=\lambda u$, and $\sum m_ir_i^2=1$ fixes $\lambda^2=1/M_2$. The objective is therefore a function of the multiplicities alone:

$$\sum v^4=G(m):=\frac{M_4}{M_2^{\,2}},\qquad M_2=\sum_i m_iu_i^2,\quad M_4=\sum_i m_iu_i^4 .$$

$G$ is manifestly invariant under relabelling the three blocks, since permuting the labels permutes the coordinates of $u$ the same way.

*If $m$ is constant* ($3\mid n$), the two conditions coincide and $r$ is free subject to $e_1(r)=0$. There $p_4(r)=2e_2^2=\tfrac12p_2(r)^2$ identically, so $\sum v^4=\tfrac n3\cdot\tfrac12(3/n)^2=\tfrac3{2n}$, a constant. And $\tfrac3{2n}>\tfrac{n^2+3}{n(n^2-1)}\iff n^2>9$, true for $n\ge5$.

### Step 4, the inequality that kills the three-value branch

**Sub-lemma.** For all reals $a,b,c\ge1$ with $n=a+b+c$ and $u=(c-b,a-c,b-a)$,

$$(n-1)\,M_4\ \ge\ M_2^{\,2},\qquad\text{i.e.}\qquad G\ge\frac1{n-1},$$

with equality exactly when $\{a,b,c\}=\{1,m,m\}$ (or in the degenerate $a=b=c$, where $M_2=0$).

*Proof.* Both sides are symmetric, so order $a\le b\le c$ and set $s=a-1\ge0$, $x=b-a\ge0$, $y=c-b\ge0$, giving $u=(y,-(x+y),x)$ and $n=3+3s+2x+y$. Expanding,

$$(n-1)M_4-M_2^{\,2}=2s^2\big(x^2{+}xy{+}y^2\big)^2+s\big(x^2{+}xy{+}y^2\big)A(x,y)+y^2(2x{+}y)B(x,y)$$

with

$$A=2x^3+3x^2y+2x^2+5xy^2+2xy+2y^3+2y^2,\qquad B=2x^3+3x^2y+2x^2+xy^2+2xy+2y^2 .$$

All $24$ monomials on the right have positive coefficients, so the whole expression is $\ge0$ on $s,x,y\ge0$. For equality: the $s^0$ term forces $y=0$; at $y=0$ the remainder is $2sx^4(s+x+1)$, which vanishes iff $s=0$ or $x=0$. So equality means $y=0$ with either $a=1$ (the $\{1,m,m\}$ family) or $x=0$ (the degenerate $a=b=c$). $\square$

The expansion is a two-line symbolic computation, reproduced with its factorisation in part B of [run_r124_fourth_moment.py](../scripts/runs/run_r124_fourth_moment.py). An equivalent reading, for anyone who wants the structure rather than the expansion: with $t_i=u_i^2$, Lagrange's identity gives $nM_4-M_2^2=\sum_{i<j}m_im_j(t_i-t_j)^2$, and since $u_i+u_j=-u_k$ one has $(t_i-t_j)^2=t_k(u_i-u_j)^2$; the sub-lemma is then $\sum_{i<j}m_im_jt_k(u_i-u_j)^2\ge M_4$.

### Step 5, assembling

$\frac1{n-1}>\frac{n^2+3}{n(n^2-1)}\iff n(n+1)>n^2+3\iff n>3$. So for odd $n\ge5$ every three-value critical point sits strictly above the two-value optimum, the one-value case is infeasible ($v=0$), and the minimum is the step-2 value, attained only at the $\big(\tfrac{n-1}2,\tfrac{n+1}2\big)$ two-value vector. $\blacksquare$

### Why the real relaxation cannot do this, and where integrality enters

Worth recording so nobody looks for a slicker parity-free argument. As a statement about *real* $a,b,c\ge0$, $\inf G=1/n$, approached at $(a,b,c)\to(0,\tfrac n2,\tfrac n2)$, indeed $G(0,b,c)=\frac n{bc}-\frac3n$ is the two-value formula. The lemma is false without integrality, exactly as expected of a parity-sensitive statement. What the proof actually consumes is only $m_i\ge1$ (three-value branch) and $pq\le\frac{n^2-1}4$ (two-value branch). Both are integrality, and nothing stronger is needed.

### The record's "up to four values" accounting is strictly weaker

[problem.md](../findings/problem.md) reports the per-block system $4s^3-2\nu s\mp\mu=0$ with up to two positive roots per block, hence up to four values. That is a valid but lossy bookkeeping of the same Lagrange system: splitting by sign discards the fact that the *three* roots of one depressed cubic sum to zero, which is precisely the relation that turns the three-value case into a zero-dimensional family. Replace it with the $\le3$-values statement.

## 5. The odd equality case, CONFIRMED

At the extremiser, $a^2=\frac{n+1}{n(n-1)}$, $b^2=\frac{n-1}{n(n+1)}$, so $ab=\frac1n$ exactly, and

$$Z_{aa}=\frac n{(n-1)(n-2)},\qquad Z_{bb}=\frac{n(n-3)}{(n-1)(n-2)(n+1)},\qquad Z_{ab}=-\frac{n(n-3)}{(n-1)(n-2)(n+1)} .$$

So $Z_{ab}=-Z_{bb}$, and $\frac{Z_{aa}}{Z_{ab}}=-\frac{n+1}{n-3}$, $\frac{Z_{bb}}{Z_{ab}}=-1$, identically in $n$, verified symbolically with $n$ a positive symbol, both differences simplifying to $0$. This supplies the cross value the record left as "(the cross value)".

**And there is a one-line reason it had to come out this way**, which is better than the computation. The subspace of $\mathcal D_n$ whose members are constant on the three blocks (sizes $p=\tfrac{n-1}2$, $q=\tfrac{n+1}2$) is cut out by two independent equations,

$$(p-1)x+qz=0,\qquad (q-1)y+pz=0,$$

on the three block values $(x,y,z)$, hence is one-dimensional, with solution $x:y:z=-\frac{n+1}{n-3}:-1:1$. $Z(v)$ at the extremiser is block-constant and lies in $\mathcal D_n$, so it *must* be proportional to the vertex matrix of $S^{(n-1)/2}\times S^{(n+1)/2}$, the claimed values solve those two equations exactly. The explicit triple above is then a consistency check rather than the argument. The same remark upgrades the even case in [problem.md](../findings/problem.md) part (c) from computation to structure.

*Caveat.* The statement needs $n\ge5$: at $n=3$ both $Z_{bb}$ and $Z_{ab}$ vanish, the ratio is $0/0$, and $-\frac{n+1}{n-3}$ is undefined.

## The chain does deliver $\Theta_n$

Feeding the two minima into $\lvert Z\rvert^2=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v^4$ (re-verified to $10^{-16}$ at $n=5,\dots,12$) and then into $\lambda^2\le\big(\tfrac{n-1}n\big)^2\cdot4\lvert Z\rvert^2$:

| parity | $\lvert Z\rvert^2_{\max}$ | resulting $\Theta_n^2$ |
|---|---|---|
| even | $\dfrac{n-2}{2(n-1)}$ | $\dfrac{2(n-1)(n-2)}{n^2}$ |
| odd | $\dfrac{n^2(n-3)}{2(n-1)(n-2)(n+1)}$ | $\dfrac{2(n-1)(n-3)}{(n+1)(n-2)}$ |

Both match the claimed constants symbolically in $n$. So with step 1 (the record's Dirichlet-energy step, which carries its own proof in [diagonal-half.md](../findings/diagonal-half.md)), **step 2 and step 3 are now both proved at every $n\ge5$, both parities.**

## Answers to the three side questions

**(a) Is claim 2's orthogonality purely formal?** Yes, entirely. Neither $\sum v=0$ nor $\sum v^2=1$ enters: the residual identity $(v_iv_j)-Z_{ij}=a_i+a_j+c$ is term-by-term, and $a_i+a_j+c\perp\mathcal D_n$ uses only the row-sum condition on $T$. Confirmed numerically on unconstrained random $v$, where the inner products stay at $10^{-15}$ while $Z$'s row sums run to $10^{0}$. **What needs the hypotheses is claim 1**, and it needs both, exactly: the row sum is $\big(\sum v\big)v_i+\frac{\sum v^2-1}{n-2}$, which vanishes for all $i$ (at $n\ge3$, generic $v$) iff $\sum v=0$ and $\sum v^2=1$. Off that set $Z$ leaves $\mathcal D_n$ and is not the projection of anything.

**(b) Is the odd equality case unique?** Yes for $n\ge5$, up to permutation and global sign. Two-value points are strictly ordered by $pq$, which is strictly unimodal in the integer $p$ and uniquely maximised by the unordered pair $\{\tfrac{n-1}2,\tfrac{n+1}2\}$, so no other multiplicity split ties. Within that split, $r_1^2$ and $r_2^2$ are determined, and the two sign choices are related by the global flip. Three-value points are strictly above by step 4. **The one exception is $n=3$**, where $\sum v^4=\tfrac12$ on the *entire* constraint set (with $e_1=0$, $p_4=2e_2^2=\tfrac12p_2^2$), so the closed form is right but every feasible $v$ is an equality case.

**(c) Is the even equality case forced two-valued?** Forced. Cauchy–Schwarz equality is an iff, giving $v_i^2\equiv1/n$; the sign pattern is then pinned by $\sum v=0$ to a balanced split. There is no freedom left to smooth away.

## What is owed after this review

Nothing on steps 2 and 3. The remaining debt in [item 1](../plan.md) is the cross-check that step 1 as stated coincides with the Dirichlet-energy step in [diagonal-half.md](../findings/diagonal-half.md), a reconciliation, not a derivation.
