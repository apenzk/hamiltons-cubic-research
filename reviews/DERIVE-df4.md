# I29, the per-row hull at the unbalanced sphere products: exact at every row, slack zero

**The question.** [I29](../plan.md) asks for the slack of I24's hull condition on the middle-eigenvalue row at every unbalanced $S^p\times S^q$, and whether the row family's implied bound at a three-eigenvalue diagonal spectrum stays below $\theta_0(n)$ or exceeds it. **Answer: the slack is zero, at every row, and the bound is exactly the true $\theta$, so the family stays alive there.**

**Record search first.** The spectrum is [r338](REVIEW_r338.md) U1, confirmed with its own tracelessness check. The hull condition is [Theorem B of DERIVE-t11](DERIVE-t11.md). Nothing in the record reads the two against each other at $p\ne q$, which is what this note does.

## The spectrum, and the support of each row

In mixed$\,=-1$ units, $n=p+q$ ([r338](REVIEW_r338.md) U1): $\nu_p=\tfrac q{p-1}$ on $\Lambda^2V_p$ with multiplicity $\tbinom p2$, $\nu_q=\tfrac p{q-1}$ on $\Lambda^2V_q$ with multiplicity $\tbinom q2$, and $-1$ on the mixed block with multiplicity $pq$. For $p<q$ these are three distinct values ordered $\nu_p>\nu_q>-1$, so **the middle eigenvalue is $\nu_q$, carried by $\Lambda^2V_q$.**

**The bracket structure makes every row's support a two-point set, and that is the whole argument.** For a product, $[\mathfrak{so}(p),\mathfrak{so}(q)]=0$, $[\mathfrak{so}(p),\mathfrak{so}(p)]\subseteq\mathfrak{so}(p)$ and $[\mathfrak{so}(p),\text{mixed}]\subseteq\text{mixed}$. So for a row $a\in\Lambda^2V_p$ the only pairs $(b,c)$ with $T_{abc}\ne0$ have $b,c$ **both** in $\Lambda^2V_p$ or **both** mixed; the row measure sits on the two pair-points $(\nu_p,\nu_p)$ and $(-1,-1)$, which are the two extremes of its own support. The same holds at a row in $\Lambda^2V_q$ and at a mixed row.

> **A two-point measure on the extremes is exactly the equality case of the chord.** So [Theorem B](DERIVE-t11.md)(i) is an **equality** at every row of every $S^p\times S^q$, and the hull condition has **zero slack** there, not only at the balanced product.

## What the chord returns

At a row in $\Lambda^2V_p$, with $L_a=-1$ and $U_a=\nu_p$, the chord reads $\lambda_a(\theta-\lambda_a)\le-(L_a+U_a)\lambda_a-(n-2)L_aU_a$, i.e. $\nu_p\theta-\nu_p^2\le\nu_p(1-\nu_p)+(n-2)\nu_p$, giving $\theta\le n-1$. **At a row in $\Lambda^2V_q$ the identical computation with $\nu_q$ in place of $\nu_p$ gives the same $\theta\le n-1$**, the $\nu$ cancels, which is why the middle row is no weaker than the extreme one.

> **THEOREM.** *In mixed$\,=-1$ units, $\theta=n-1$ at every $S^p\times S^q$, and the per-row hull condition attains it at every row.*

**Independent check against the record.** At unit norm $\theta=(n-1)/\lVert W\rVert$ with $\lVert W\rVert^2=\tbinom p2\nu_p^2+\tbinom q2\nu_q^2+pq$. At $S^5\times S^7$ this gives $1.228239$, and [target.md](../findings/target.md) records that point at $\theta=1.228239158$ from a built tensor, **agreement, by a route sharing nothing with the construction.** At $p=q$ it returns $\theta_0(n)$ exactly, at $n=12$ and $n=14$.

| $p,q$ | $\theta$ at unit norm | $\theta_0(n)$ |
|---|---|---|
| $2,10$ | $0.994987$ | $1.236033$ |
| $3,9$ | $1.141798$ | $1.236033$ |
| $4,8$ | $1.201561$ | $1.236033$ |
| $5,7$ | $1.228239$ | $1.236033$ |
| $6,6$ | $1.236033$ | $1.236033$ |

## The answer to I29's dichotomy

**The first branch.** The row family's implied bound at these three-eigenvalue diagonal spectra is the true $\theta$, and it is **strictly below $\theta_0(n)$ for $p\ne q$, with equality exactly at $p=q$.** So I24 is alive in the regime I29 was written to test, and there is no fence post here.

**What it does not say.** These are *diagonal* points, and their rows have two-point support precisely because the product structure kills the cross-brackets. **A three-eigenvalue spectrum with full row support is a different object**, [DERIVE-t11](DERIVE-t11.md)'s $n=12$ witness is one, and it passes every row of the hull at $\theta=1.2917>\theta_0(12)$. *So "the hull is exact at every sphere product" and "the hull cannot close $d\ge3$" ([post F43](../findings/INDEX-traps.md)) are both true, and the difference between them is the support of the row measure, not the number of eigenvalues.*

**Gate 2 owed.**
