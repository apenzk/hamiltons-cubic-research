# Review r1590: L272 (the Perron root of P + diag d on the torus family)

Log: agent_logs/r1590.log

| claim | verdict | reason in one line |
|---|---|---|
| P1 L272 (1) the matrix form | CONFIRMED | $X^2=P^2+PD+DP+D^2$ with $P_{ii}=0$ gives off-diagonal $(P^2)_{ij}+P_{ij}(d_i+d_j)=X_{ij}-2P_{ij}Q_{ij}^2$ by L271's $P$ equation, diagonal $\pi_i+d_i^2$, and $x=\sum_{i<j}P_{ij}=\tfrac12\mathbf 1^{\mathsf T}P\mathbf 1$ |
| P2 L272 (2) d_i >= rho - 1, equality off S | CONFIRMED | Perron step valid at every row. $\pi_i+\sum_lQ_{il}^2=2d_i$. $(d-\rho+1)(d+\rho)=d^2+d-\rho^2+\rho$ settles every sign of $\rho-1$. Rows off $S$ are equalities |
| P3 L272 (3) x <= m/2, equality only at I/c | CONFIRMED | Rayleigh at $\mathbf 1$ for symmetric $X$. Equality forces every $d_i=\rho-1$, hence $\pi_i\ge2d_i$, hence every row of $Q$ vanishes, then L271 (3) |
| P4 L272 (4) the support of (X - rho)(X + rho - 1) | CONFIRMED | $(X-\rho)(X+\rho-1)=X^2-X-(\rho^2-\rho)I$. Support in $S\times S$ gives rank at most $\lvert S\rvert$, and $\ker f(X)$ is the sum of eigenspaces with $f(\lambda)=0$ (count with multiplicity) |
| P5 L272 what it gives and screens | CONFIRMED | $q$ formula follows from L271 (1). $q\ge m(\rho^2-\rho)$ from (2)'s intermediate inequality. $I/c$ has $d_i=1/c$, $\rho=1+1/c$, $q=m(2m-1)/c^2$. Screen at $m=4$ agrees |
| LEAN fidelity | CONFIRMED | each declaration states what the table says, hypotheses are the inputs the prose supplies, none assumes its conclusion. One cosmetic docstring point |

## Method

Read the stated chain link by link against L271 (2) and L271 (1), (3) as given, then derived each part by hand. L271's full statement was read from findings/second-order.md (the brief's quotation is truncated), and nothing else of the author's was read. One screen, seconds long: the L271 system at $m=4$ solved by fsolve from 400 random positive seeds, keeping solutions with residual below $10^{-11}$ and all $U,V>0$. It is reported as a screen and is no part of any verdict's argument.

## P1: part (1)

With $D=\mathop{\mathrm{diag}}d$ and $P$ symmetric with zero diagonal, $X^2=P^2+PD+DP+D^2$. For $i\ne j$: $(X^2)_{ij}=(P^2)_{ij}+P_{ij}(d_i+d_j)$, and L271's first equation rewrites $(P^2)_{ij}=P_{ij}-P_{ij}(d_i+d_j)-2P_{ij}Q_{ij}^2$, so $(X^2)_{ij}=P_{ij}-2P_{ij}Q_{ij}^2=X_{ij}-2(P\circ Q\circ Q)_{ij}$. On the diagonal $(PD+DP)_{ii}=2P_{ii}d_i=0$, so $(X^2)_{ii}=\pi_i+d_i^2$ and $(X^2-X)_{ii}=\pi_i+d_i^2-d_i$. The positive roots are $\varepsilon_i\pm\varepsilon_j$ with $i<j$, so $x=\sum_{i<j}(U_{ij}+V_{ij})=\sum_{i<j}P_{ij}=\tfrac12\mathbf 1^{\mathsf T}P\mathbf 1$.

## P2: part (2)

- Entrywise bound. The off-diagonal correction is $-2P_{ij}Q_{ij}^2\le0$ because $P_{ij}>\lvert Q_{ij}\rvert\ge0$ (L271 (2), positive definiteness), and the diagonal holds with equality for $\delta_i=\pi_i+d_i^2-d_i$. The sign is right. The written proof asserts $P\circ Q\circ Q\ge0$ without naming $P>0$ as its source (minor presentational point).
- Perron–Frobenius applies: $d_i\ge0$ and $P_{ij}>0$ off the diagonal. For $w>0$, $(X^2w)_i=\rho^2w_i\le(Xw)_i+\delta_iw_i=(\rho+\delta_i)w_i$, and $w_i>0$ gives $\rho^2-\rho\le\delta_i$ at every row. Only $w_j\ge0$ is needed for the sum and $w_i>0$ for the division.
- $\pi_i+\sum_lQ_{il}^2=\sum_l(P_{il}^2+Q_{il}^2)=2\sum_l(U_{il}^2+V_{il}^2)=2d_i$, so $\pi_i\le2d_i$ and $\rho^2-\rho\le d_i^2+d_i$.
- $d_i^2+d_i-(\rho^2-\rho)=(d_i-\rho+1)(d_i+\rho)$ and $d_i+\rho>0$ (with $\rho>0$, $d_i\ge0$), so $d_i\ge\rho-1$ whatever the sign of $\rho-1$.
- For $i\notin S$ every $Q_{ij}=0$, so every entry of row $i$ of the bound is an equality, $\rho^2-\rho=\delta_i$, $\pi_i=2d_i$, hence $\rho^2-\rho=d_i^2+d_i$ and $d_i=\rho-1$.

## P3: part (3)

$X$ is real symmetric, so $\rho\ge\mathbf 1^{\mathsf T}X\mathbf 1/m=(\sum_id_i+2x)/m$. With $\sum_id_i\ge m(\rho-1)$ this gives $2x\le m$. At $I/c$, $\mu\equiv1/c$ on $m(m-1)$ positive roots with $c=2(m-1)$, so $x=m/2$. Equality: $\sum_id_i=m(\rho-1)$ with each term at least $\rho-1$ forces $d_i=\rho-1$, so $d_i^2+d_i=\rho^2-\rho\le\pi_i+d_i^2-d_i$, so $\pi_i\ge2d_i$, and with $\pi_i\le2d_i$ every $\sum_lQ_{il}^2=0$. Then $Q=0$ and L271 (3) gives $I/c$. Every link holds.

## P4: part (4)

$(X-\rho)(X+\rho-1)=X^2-X-(\rho^2-\rho)I$. Its diagonal is $\pi_i+d_i^2-d_i-(\rho^2-\rho)$, zero off $S$ by the equality case of (2). Its off-diagonal is $-2P_{ij}Q_{ij}^2$, nonzero only when $Q_{ij}\ne0$, which puts both $i$ and $j$ in $S$ since $Q$ is symmetric. So the matrix has rank at most $\lvert S\rvert$. For symmetric $X$ the kernel of $f(X)$ is the sum of the eigenspaces with $f(\lambda)=0$, so at least $m-\lvert S\rvert$ eigenvalues, counted with multiplicity, lie in $\{\rho,1-\rho\}$. Since $\rho$ is simple (Perron), at least $m-\lvert S\rvert-1$ of them equal $1-\rho$. That sharpening is optional.

## P5: what it gives

- $\lVert A\rVert^2=\sum_id_i^2+\sum_{i\ne j}P_{ij}^2Q_{ij}^2$ from $A_{ii}=d_i$ and $A_{ij}=-P_{ij}Q_{ij}$. $\tfrac12(\lVert P\rVert^2+\lVert Q\rVert^2)=\tfrac12\sum_i2d_i=\sum_id_i$. So $q$ is as stated.
- $q\ge\sum_i(d_i^2+d_i)\ge m(\rho^2-\rho)$, using the intermediate inequality of (2).
- At $I/c$: $d_i=2(m-1)/c^2=1/c$, $q=m(1+c)/c^2=m(2m-1)/c^2$, and $\rho=1/c+2(m-1)/c=1+1/c$. With $r=\rho-1\in(-1,\infty)$, $r(r+1)\ge\tfrac1c(\tfrac1c+1)$ exactly when $r\ge1/c$. So "exactly when $\rho\ge1+1/c$" is right. The quoted thresholds $1.10$ to $1.17$ are $1+1/c$ for $m=6,5,4$.
- Screen (seconds, $m=4$, L271 system, 400 seeds): every positive solution found had $\min_i(d_i-\rho+1)$ within $10^{-11}$ of $0$ with equality exactly off $S$, $\lvert S\rvert\in\{2,3\}$, $x\in\{1.4744,1.4749,1.7208\}<2$, $\rho\in\{1.0188,1.0189,1.0833\}<1.1667$, $q\ge m(\rho^2-\rho)$, $(X-\rho)(X+\rho-1)$ zero off $S\times S$ to $10^{-11}$, and the eigenvalue count met (for $\lvert S\rvert=2$, $1-\rho=-0.0833$ appears twice beside $\rho$). This agrees with the record's screen description. It is a screen and is no evidence for the positive claims.

## LEAN fidelity

- perron_row: hypotheses $w>0$, $Xw=\rho w$ and the entrywise bound with $\delta$ on the diagonal. Conclusion $\rho^2-\rho\le\delta_i$. Faithful. It holds for any positive eigenvector, which is correct and slightly more general. Its docstring also mentions the equality case, which is perron_row_eq's content (cosmetic).
- perron_row_eq: row-$i$ equality gives $\rho^2-\rho=\delta_i$. Faithful.
- perron_d, perron_d_eq: the scalar steps exactly as tabled. perron_d needs only $d\ge0$, and the case $\rho\le0$ is harmless.
- perron_x: two linear hypotheses give $2x\le m$ by linarith. Faithful to the table. The Rayleigh bound and $\sum d\ge m(\rho-1)$ are hypotheses, which the table and the record declare as prose.
- No hypothesis assumes its conclusion. Every hypothesis set is satisfiable, for example at $I/c$ with $w=\mathbf 1$.

## Minor points (no verdict change)

1. The proof of (2) should say $P\circ Q\circ Q\ge0$ comes from $P_{ij}>\lvert Q_{ij}\rvert$.
2. (4)'s count is with multiplicity. Simplicity of $\rho$ sharpens it to at least $m-\lvert S\rvert-1$ eigenvalues equal to $1-\rho$.
3. perron_row's docstring describes perron_row_eq's equality case.
