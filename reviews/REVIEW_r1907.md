# REVIEW r1907: sp_trace_ge_two and tilt_beats_theta0 against their prose

Log: agent_logs/r1907-sp-trace-tilt-lean.log. Analysis-only footing: every check below is by hand, and the one Lean run is `#print axioms` on a scratch file.

| # | Claim | Verdict |
|---|---|---|
| 1 | `sp_trace_ge_two` states claim 1 | CONFIRMED |
| 2 | its proof follows the prose, differences harmless | CONFIRMED |
| 3 | `tilt_beats_theta0` states claim 2's comparison | CONFIRMED |
| 4 | axioms | CONFIRMED (standard three only) |
| 5 | prose not covered by either declaration | stated below |

## 1. The statement of sp_trace_ge_two

- **Hypotheses.** `TorusRows P Q u a` (the displayed system, confirmed by r1893 and r1894), `0 < u i` for all i, `0 < P i j` and `0 < Q i j` for i ≠ j, and two distinct indices `i0 ≠ j0`. The working note (line 66) reads positive definiteness as $s>\lvert d\rvert$ and $u>0$, which is exactly $p_{ij},q_{ij}>0$ off the diagonal and $u_i>0$, so no hypothesis exceeds what a positive-definite solution supplies. The distinct pair encodes $k\ge2$ (it forces `Fin k` to have two elements), and it is used only to make the index set nonempty and $M>0$.
- **Conclusion.** `2 ≤ ∑ i, a i + 2 * ∑ i, u i + ∑ i, ∑ j, (P i j + Q i j)`. The double sum runs over all ordered pairs including the diagonal, and `diagP`, `diagQ` make the diagonal terms zero, so it equals $\sum_{i\ne j}(p_{ij}+q_{ij})$. With `symP`, `symQ` each unordered root plane $\varepsilon_i\pm\varepsilon_j$ is counted twice, which is the $2\sum_\alpha w_\alpha$ of $\operatorname{tr}A+2\sum_\alpha w_\alpha$ on the short roots, and $2\sum u_i$ is the same on the long roots $2\varepsilon_i$. The Lean trace is the prose trace.

## 2. The proof against the prose

- **Largest weight.** `Finset.exists_max_image` over ordered pairs of `max (P x y) (Q x y)` picks $M=\max(p_{ij},q_{ij})$ over all short weights, then $M>0$ from $p_{i_0j_0}>0$, and $i\ne j$ since the diagonal is zero. The p-row is used when $M=p_{ij}$, the q-row when $M=q_{ij}$. This is the prose's "largest short weight's row".
- **Row bound.** `rhs_le`, `rhs_le_q` bound the right side of the row by $M\cdot R$, $R=(u_i+u_j)+\tfrac14\sum_l(p_{il}+p_{jl}+q_{il}+q_{jl})$, using $xy\le M(x+y)/2$ termwise and $q_{ij}\le M$ (resp. $p_{ij}\le M$) on the $(u_i+u_j)$ term. Dividing $M(1-X^\mp)\le MR$ by $M>0$ gives $G=R+X^\mp\ge1$ (`hG`).
- **Difference 1, the sum over all l.** The prose's $G$ sums over $l\ne i,j$ and has $u_i^2+u_j^2+p_{ij}^2+\tfrac14\sum_{l\ne i,j}(\text{squares})$ as $X^-$. By hand, $\tfrac12(a_i+a_j)-\tfrac12(q_{ij}^2-p_{ij}^2)$ with the $l=j$ term of row $i$ and the $l=i$ term of row $j$ separated is exactly that, so the Lean `X` is the prose's $X^-$ (and likewise $X^+$). The Lean $R$ adds the $l\in\{i,j\}$ terms $\tfrac12(p_{ij}+q_{ij})$, so the Lean $G$ is the prose's $G$ plus a nonnegative amount. The inequality $G\ge1$ is then weaker and still true, and the cost falls on the comparison below.
- **Difference 2, the factor-two comparison and its slack.** Lean compares with rows $i$ and $j$ only: $\operatorname{tr}C\ge(a_i+a_j)+2(u_i+u_j)+S_i+S_j$ with $S_i=\sum_l(p_{il}+q_{il})$ (`hrows`, `hasum`, `husum`), against $2G=2(u_i+u_j)+\tfrac12(S_i+S_j)+(a_i+a_j)\mp(q_{ij}^2-p_{ij}^2)$. The gap is $\tfrac12(S_i+S_j)\pm(q_{ij}^2-p_{ij}^2)$. In the p case it needs $\tfrac12(S_i+S_j)\ge p_{ij}^2-q_{ij}^2$, which holds since $S_i\ge p_{ij}$, $S_j\ge p_{ji}=p_{ij}$ and $p_{ij}^2\le p_{ij}$ from $p_{ij}^2\le2a_i\le1$ (`hPle`, with $a_i\le\tfrac12$ from the long row and $u_i>0$, `hahalf`). The q case is symmetric with `hQle`. The prose's version ("every weight carries at least twice its part") needs $2p+p^2+2q+q^2\ge2p^2$ at the pair $ij$, true for $p\le2$, so both routes use the same kind of slack and the Lean one is a harmless rearrangement.
- Verdict: the proof follows the prose's structure and each deviation is sound. CONFIRMED.

## 3. The statement of tilt_beats_theta0

- **Substitution.** With $q=2m-4$: $6q^2(q-1)=24(m-2)^2(2m-5)$, $q+2=2(m-1)$, $q+3=2m-1$, $2q-3=4m-11$, so $\rho^2=12(m-2)^2(2m-5)/((m-1)(2m-1)(4m-11))$, which is the Lean right side. The left side is $\theta_0(2m)^2=(2m-1)(m-1)/m^2$ as quoted.
- **Range.** Lean takes real $m\ge4$, which contains every integer $m\ge4$, i.e. every even $n=2m\ge8$, and gives $q\ge4\ge3$ so the stationary point $s=(q+2)(q+3)(q-3)\ge0$ is admissible. The denominators are positive on the range (`h2`).
- **D by hand.** $12m^2(m-2)^2(2m-5)=24m^5-156m^4+336m^3-240m^2$ and $(2m-1)^2(m-1)^2(4m-11)=16m^5-92m^4+184m^3-167m^2+70m-11$, difference $8m^5-64m^4+152m^3-73m^2-70m+11=D$.
- **D(k+4) by hand** (Taylor coefficients at 4): $D(4)=99$, $k$: $10240-16384+7296-584-70=498$, $k^2$: $5120-6144+1824-73=727$, $k^3$: $1280-1024+152=408$, $k^4$: $160-64=96$, $k^5$: $8$. All match the prose.
- Verdict: CONFIRMED. The Lean statement is the comparison of squares, which is what the prose's "$\rho^2>\theta_0^2$" says.

## 4. Axioms

Both `sp_trace_ge_two` and `tilt_beats_theta0` depend on `[propext, Classical.choice, Quot.sound]` only (scratch file importing both modules, `lake env lean`, exit 0). No `sorryAx`, no project axioms.

## 5. What neither declaration covers

- Claim 1: the derivation of `TorusRows` from $C^\#C=C$ and the identification of the trace with $\operatorname{tr}C$ in $\mathfrak{so}(4k)$'s metric are prose (the module docstring says so).
- Claim 2: the value $\rho^2$, the stationary point $s=(q+2)(q+3)(q-3)$, that it is the maximum of the ratio on the tilted family, and $\theta_0(2m)^2$ read off the Weyl line are all untyped. The step from $\rho^2>\theta_0^2$ to $\rho>\theta_0$ needs the cubic positive at the stationary point, also untyped. The Lean theorem is the rational inequality alone, as its docstring states.
