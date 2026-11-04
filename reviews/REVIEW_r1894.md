# REVIEW r1894: sp(k)'s torus system as two square completions

Log: [agent_logs/r1894-sp-blocks.log](../agent_logs/r1894-sp-blocks.log)

Verdict: the section is correct. Two statements should be tightened, and none of the defects is load-bearing: (a) the converse direction of "equivalent" is true but is typed nowhere, and the Lean module docstring leaves it off the "Not typed" list; (b) attempt 3's sentence "this needs less of $\lambda_{\max}(D)$ than attempt 1" holds near uniform data only. The note also leaves $u_i<\tfrac12$ unstated, though the chain uses it.

| # | claim | verdict |
|---|---|---|
| 1 | TorusRows states the rows; plus_block, minus_block state the identities; axioms | CONFIRMED |
| 2 | "Equivalent" (converse) | CONFIRMED mathematically; untyped, gap in the Lean record only |
| 3 | Weight-graph bullet | CONFIRMED (diagonal: $f_{xx}=2+a_i$, the $a$-definition) |
| 4 | Row-sum bullet | CONFIRMED |
| 5 | Attempt 1's inequality | CONFIRMED (the $\lambda_{\max}(D)$ lower bound needs $D\ne0$) |
| 6 | Attempt 3 chain | CONFIRMED for the boxed conclusion; the comparison sentence is PLAUSIBLE only near uniform data |
| 7 | Hermitian-pair remark | CONFIRMED |
| 8 | Attempts 1 and 2 as obstacles | two sentences are asserted without an argument, both PLAUSIBLE (details below) |

## 1. Lean statement

- `TorusRows` matches the note field by field. `ha` is $a_i=2u_i^2+\tfrac12\sum_j(p_{ij}^2+q_{ij}^2)$ and `hlong` is $u_i(1-2a_i)=\sum_jp_{ij}q_{ij}$. `hp` is $p_{ij}(1-X^-_{ij})$ with $X^-=\tfrac12(a_i+a_j)-\tfrac12(q^2-p^2)$, and `hq` is the same with $X^+$. Every sum runs over all of `Fin k`, and `diagP`/`diagQ` make that agree with the note's sums. Symmetry and the zero diagonal are hypotheses.
- `plus_block` states $(P+Q+\mathop{\mathrm{diag}}(a+2u-1))^2=\mathop{\mathrm{diag}}(1-2u+a^2)-(P+Q)\circ(P-Q)\circ(P-Q)$, which is the note's first identity. `minus_block` states the second with $\mathop{\mathrm{diag}}(a-2u-1)$ and $D\circ S\circ S$. Both match.
- `#print axioms` on a scratch copy, run with `lake env lean`, returns `[propext, Classical.choice, Quot.sound]` for both.

## 2. The converse

- The `linear_combination` certificates are exact ring identities. Entry $(i,i)$ of plus is $-2(E_a+E_{\rm long})$ and entry $(i,i)$ of minus is $-2(E_a-E_{\rm long})$. Off the diagonal the entries are $-2(E_p+E_q)$ and $-2(E_p-E_q)$. Here $E_\bullet$ is the row's left side minus its right side.
- The $2\times2$ system is invertible, so given symmetric $P,Q$ with zero diagonal, the two identities imply `ha`, `hlong`, `hp` and `hq`. The word "equivalent" is therefore correct, with two provisos. First, the identities encode the $a$-definition as well, so the rows side has to include it (the proof sentence says so, but the statement lists only long, $p$ and $q$ rows). Second, symmetry and the zero diagonal are standing hypotheses.
- Gap: nothing downstream in the section uses the converse, since attempts 1 to 3 use the forward direction only. The gap is in the record. The Lean docstring at [SpTorusBlocks.lean:9](../lean/HamiltonsCubic/Results/SpTorusBlocks.lean#L9) says "are equivalent" and its "Not typed" line omits the converse. The fix is to add the converse there, or to type it, which takes a four-line `linear_combination` with coefficients $\pm\tfrac14$ per entry.

## 3. Weight graph

- Write $M=P+A_d$ and $N=Q+2U$. Then $\hat W^2=\begin{pmatrix}M^2+N^2&MN+NM\\ MN+NM&M^2+N^2\end{pmatrix}$.
- $(M^2+N^2)_{ij}$ for $i\ne j$ is $\sum_l(p_{il}p_{jl}+q_{il}q_{jl})+(a_i+a_j)p_{ij}+2(u_i+u_j)q_{ij}$, which the $p$-row turns into $2(1+A_{ij})p_{ij}$.
- $(MN+NM)_{ij}$ for $i\ne j$ is $\sum_l(p_{il}q_{jl}+q_{il}p_{jl})+2(u_i+u_j)p_{ij}+(a_i+a_j)q_{ij}$, which the $q$-row turns into $2(1-A_{ij})q_{ij}$.
- $(MN+NM)_{ii}=2\sum_lp_{il}q_{il}+4a_iu_i$, which the long row turns into $2u_i=\hat W_{ii'}$. So $f=1$ on long edges.
- On the diagonal, $(M^2+N^2)_{ii}=a_i^2+2(a_i-2u_i^2)+4u_i^2=(2+a_i)a_i$. So $f_{xx}=2+a_i$, which is the $a$-definition. The bullet omits it, and it matches neither pattern: it is not $2(1\pm A_{ii})$.
- Positivity: every off-diagonal entry is one of $p_{ij}$, $q_{ij}$ or $2u_i$, all $>0$.
- Split: the orthogonal matrix $\tfrac1{\sqrt2}\begin{pmatrix}I&I\\I&-I\end{pmatrix}$ conjugates $\hat W$ to $\mathop{\mathrm{diag}}(S+A_d+2U,\;D+A_d-2U)$, and the identities are the squares of these blocks minus $I$. Screen: $(S+A_d+2U)^2_{ij}=2s+2A_{ij}d=2s-sd^2$, since $A_{ij}=-\tfrac12s_{ij}d_{ij}$. Subtracting $2s$ reproduces $-S\circ D\circ D$.

## 4. Row sums

- From the diagonals: $\sum_js_{ij}^2=1-2u+a^2-(a+2u-1)^2=2(a+u)(1-2u)$ and $\sum_jd_{ij}^2=1+2u+a^2-(a-2u-1)^2=2(a-u)(1+2u)$. Both are correct.
- Since $1+2u_i>0$, it follows that $a_i\ge u_i$, with equality iff $\sum_jd_{ij}^2=0$ iff row $i$ of $D$ vanishes. CONFIRMED.

## 5. Attempt 1

- The $(D^2)_{ij}$ and $(S^2)_{ij}$ forms follow from the off-diagonal entries of the identities with $G=\mathop{\mathrm{diag}}(g)$ and $H=\mathop{\mathrm{diag}}(h)$, where $A_d-2U-I=-G$ and $A_d+2U-I=-H$. Also $h=g-4u$. CONFIRMED.
- Lower bound: $\mathop{\mathrm{tr}}D^3=\sum_{i\ne j}d_{ij}^2(g_i+g_j-s_{ij}^2)=2\sum B_{ij}d_{ij}^2$ (consistent with the given identity). This is $\ge\min(g_i+g_j-s_{ij}^2)\lVert D\rVert_F^2$. Also $\sum\lambda^3\le\lambda_{\max}\sum\lambda^2$. Together they give $\lambda_{\max}(D)\ge\min_{i\ne j}(g_i+g_j-s_{ij}^2)$ **provided $D\ne0$**. The note leaves this proviso unstated, and the bound is used only to reach a contradiction from $D\ne0$, so the omission is harmless.
- $\lambda_{\max}(D)<\rho(S)$: $|d_{ij}|<s_{ij}$ entrywise and $S$ is irreducible for $k\ge2$, so $\rho(D)\le\rho(|D|)<\rho(S)$ by Perron–Frobenius/Wielandt. CONFIRMED.
- Upper bound: with $B_+=S-H$ and $Sv=\rho v$, $v^{\mathsf T}B_+^2v=\lVert B_+v\rVert^2=\sum(\rho-h_i)^2v_i^2$. The identity then gives the displayed equality. The right side is $\le0$ because $S\circ D\circ D\ge0$ entrywise and $v>0$. A positively weighted average $\le0$ has a term $\le0$, so $\rho\le h_i+\sqrt{1-2u_i+a_i^2}$ for some $i$. The square root is real because $u_i<\tfrac12$ (see 6). CONFIRMED.

## 6. Attempt 3

- $Z=G-D=-(D-G)$, and $(D-G)$ is the second block's matrix $D+A_d-2U-I$. So $Z^2=X$, and the sign has no effect on the square. The sign does fix which spectral condition appears, and the boxed statement uses $Z=G-D$ consistently.
- $Z^2-R^2=(R+E)^2-R^2=RE+ER+E^2=RE+EZ$. CONFIRMED.
- $\langle F,RE+EZ\rangle_F=\langle RF+FZ,E\rangle_F$ because $R$ and $Z$ are symmetric. The operator is $R\otimes I+I\otimes Z$ with eigenvalues $r_i+\zeta_j$, where $\zeta_j$ is an eigenvalue of $Z$ (the note's $z_j$ is otherwise undefined). CONFIRMED.
- If $\min r+\lambda_{\min}(Z)>0$, then $\lVert E\rVert_F\le\lVert D\circ S\circ S\rVert_F/(\min r+\lambda_{\min}Z)$, from $RE+EZ=-D\circ S\circ S$. CONFIRMED.
- $E=(G-R)-D$, whose diagonal is $G-R$ and whose off-diagonal is $-D$. So $\lVert E\rVert_F^2=\lVert D\rVert_F^2+\sum(g_i-r_i)^2\ge\lVert D\rVert_F^2$. CONFIRMED.
- $\lVert D\circ S\circ S\rVert_F\le\max s^2\lVert D\rVert_F$ holds entrywise. It follows that $\lVert D\rVert_F(1-\max s^2/(\min r+\lambda_{\min}Z))\le0$, and under the boxed hypothesis the bracket is positive, so $D=0$. The boxed hypothesis also implies the positivity condition. CONFIRMED.
- $a_i<\tfrac12$ for $k\ge2$: $u_i(1-2a_i)=\sum_jp_{ij}q_{ij}>0$ and $u_i>0$. CONFIRMED.
- $\sum_js_{ij}^2<1-4u_i^2$: this step multiplies $a_i+u_i<\tfrac12+u_i$ by $2(1-2u_i)$, which requires $u_i<\tfrac12$. **The note does not state this.** It does follow from the hypotheses, since $u_i\le a_i<\tfrac12$ by the row-sum bullet and the previous item (or from $\sum_js_{ij}^2>0$). A clause should be added. With it, $\max s^2\le\max_i\sum_js_{ij}^2<1<\min r$, because $r_i^2=1+2u_i+a_i^2>1$. The threshold is therefore negative, and $D\preceq G$ gives $\lambda_{\min}(Z)\ge0$. CONFIRMED.
- $r_i\ge g_i$: $r_i^2-g_i^2=2(1+2u_i)(a_i-u_i)\ge0$ and $r_i>0$. CONFIRMED.
- "This needs less of $\lambda_{\max}(D)$ than attempt 1": this is PLAUSIBLE only near uniform data and is false as a general comparison. Attempt 3's sufficient condition in $\lambda_{\max}$ form is $\lambda_{\max}(D)<\min_ig_i+\min_ir_i-\max s^2$. Attempt 1's threshold is $\min_{i\ne j}(g_i+g_j-s_{ij}^2)$. With uniform $g,r,s$ the first is larger because $r\ge g$. With one small $g_1$ and $\min r=r_1<g_j$ (for example $g_1=0.5$, $r_1=1.1$, $g_j=1.5$), attempt 1's threshold is the larger. This is an arithmetic screen on unconstrained numbers and makes no claim about solutions. Correction: restrict the sentence to "near uniform $g$ and $r$", or drop it. "Closes against $\rho(S)$ in the same regime" is heuristic and carries no argument.

## 7. Hermitian pair

- The Cartan subalgebra $\mathfrak h$ lies in $\mathfrak u(k)$, so $C|_{\mathfrak h}=\alpha\,\mathrm{Id}$ and the off-diagonal $A_{ij}=0$. The compact roots are $\varepsilon_i-\varepsilon_j$, so $p=\alpha$, while $\varepsilon_i+\varepsilon_j$ and $2\varepsilon_i$ lie in $\mathfrak p$, so $q=u=\beta$.
- The idempotent rows give $A_{ij}=\tfrac12(\beta^2-\alpha^2)$, which must equal $0$. With positive weights this gives $\alpha=\beta$, which is $p=q$ and falls under L285. CONFIRMED.

## 8. Unargued sentences in attempts 1 and 2

- Attempt 1, "separate at $I/c$ with margin of order $\tfrac6c$": no computation is shown. Screen: at the uniform point $p=q=u=a=\tfrac1{k+1}=\tfrac1c$, the row sum forces $u=1/(k+1)$. The lower bound is $2+2u-4u^2$ and the upper bound is $2-4u$, so the margin is $6u-4u^2=\tfrac6c-\tfrac4{c^2}$. PLAUSIBLE, and the order is right. "Cross when $u_i$ is small": at $u\to0$ the gap is $\approx-a-s^2<0$. PLAUSIBLE.
- Attempt 2, "This excludes $D\ne0$ when the factor's spread and the row sums are small": this is stated as a result, with no quantifiers and no argument. An argument does exist in outline. $D^2=D\circ F+\mathop{\mathrm{diag}}(\sigma)$ holds exactly, which bounds $\lambda^2-2\lambda$ and gives clustering. $\mathop{\mathrm{tr}}D=0$ then rules out eigenvalues near $2$. Finally $\lVert\mathrm{off}(D^2)\rVert_F\ge\min F\,\lVert D\rVert_F$ and $\lVert D^2\rVert_F\le\lVert D\rVert_2\lVert D\rVert_F$ give $D=0$ once $\lVert D\rVert_2<\min F$. PLAUSIBLE. It should be labelled as a sketch.
- The closing bullet: $\sum d^2/\sum s^2=(a-u)(1+2u)/((a+u)(1-2u))\to1$ requires both $a\gg u$ and $u$ small. The $p$/$q$ imbalance follows from $\sum_j4p_{ij}q_{ij}=4u_i(1-2a_i)$, which is small. PLAUSIBLE, and it holds in a weighted sense ("most pairs").

## Corrections owed

1. Say that "equivalent" includes the $a$-definition among the rows, and add the converse to the "Not typed" line at [SpTorusBlocks.lean:14](../lean/HamiltonsCubic/Results/SpTorusBlocks.lean#L14), or type it.
2. Attempt 3: add "$u_i\le a_i<\tfrac12$" before the bound $\sum_js_{ij}^2<1-4u_i^2$.
3. Attempt 3: restrict "needs less of $\lambda_{\max}(D)$ than attempt 1" to near-uniform data.
4. Attempt 1: add "for $D\ne0$" to the $\lambda_{\max}(D)$ lower bound.
5. Optionally, state the weight-graph diagonal $f_{xx}=2+a_i$.
