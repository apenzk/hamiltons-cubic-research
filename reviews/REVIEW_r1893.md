# REVIEW r1893: sp(k)'s torus system as two square completions

Reviewer r1893, Gate 2, one of two independent readers. Log: [agent_logs/r1893-sp-blocks.log](../agent_logs/r1893-sp-blocks.log). Analysis-only footing: every verdict below rests on a hand derivation. The only machine check is `lake env lean` on a scratch copy of [SpTorusBlocks.lean](../lean/HamiltonsCubic/Results/SpTorusBlocks.lean) with `#print axioms` appended. No numerical screen was run (numpy is absent and the algebra is exact).

**Verdict: the section is correct.** No link is refuted. The corrections are one unstated but derivable step in attempt 3, one comparison sentence without an argument, attempt 2's "this excludes" and the "open regime" characterisation (both prose heuristics stated as results), and a sign detail in the Hermitian remark.

| # | claim | verdict |
|---|---|---|
| 1 | TorusRows, plus_block, minus_block, axioms | CONFIRMED |
| 2 | "equivalent" (converse) | CONFIRMED (word correct, converse untyped, minor gap) |
| 3 | weight-graph bullet | CONFIRMED (diagonal factor $2+a_i$ unstated) |
| 4 | row-sum bullet | CONFIRMED |
| 5 | attempt 1 inequality | CONFIRMED |
| 6 | attempt 3 chain | CONFIRMED (unstated step $u_i<\tfrac12$ derivable; the comparison with attempt 1 is unargued) |
| 7 | Hermitian-pair remark | CONFIRMED (the idempotent gives $\alpha^2=\beta^2$, and positivity gives $\alpha=\beta$) |
| 8 | attempts 1 and 2 as obstacles | PLAUSIBLE (two sentences state results without an argument) |

## 1. Lean against the statement

- `TorusRows` has symmetric $P,Q$ with zero diagonal, `ha` equal to the $a_i$ definition, `hlong` equal to the long row, and `hp`/`hq` equal to the $p$- and $q$-rows with $X^\mp_{ij}=\tfrac12(a_i+a_j)\mp\tfrac12(q_{ij}^2-p_{ij}^2)$. The sums run over all of `Fin k`. With zero diagonal, the $l=i$ and $l=j$ terms in the $p$/$q$ rows are the same as in the note. $A_{ij}$ appears only through $q^2-p^2$, as in the note.
- `plus_block`: $(P+Q+\operatorname{diag}(a+2u-1))^2=\operatorname{diag}(1-2u+a^2)-(P+Q)\circ(P-Q)\circ(P-Q)$. This is $(S+A_d+2U-I)^2=\dots-S\circ D\circ D$ exactly. `minus_block` is the second identity exactly.
- `#print axioms`: both depend on `[propext, Classical.choice, Quot.sound]` only. The scratch copy compiles with no errors.

## 2. "Equivalent"

- The proofs close each entry with `linear_combination`. This is an exact polynomial identity: (block residual) $= -2\,$(ha residual) $\mp 2\,$(hlong residual) on the diagonal, and $-2\,$(hp) $\mp 2\,$(hq) off it, with the upper sign for `plus_block`. The coefficient matrix $\begin{pmatrix}-2&-2\\-2&2\end{pmatrix}$ is invertible. So, given symmetry and zero diagonal (used in `hSS`/`hDD`), the two identities together give back `ha`, `hlong`, `hp` and `hq`, one by one.
- The word "equivalent" is therefore correct. It is slightly stronger than the prose: the identities also imply the definition of $a_i$, which the statement lists only among the proof's ingredients. The missing Lean direction is a small typing gap and no mathematical gap. It would take the same `linear_combination` calls, with sum and difference.
- "Whose diagonals vanish" (of $S\circ D\circ D$, $D\circ S\circ S$) holds because $S,D$ have zero diagonal.

## 3. Weight-graph bullet

With $A=P+A_d$ and $B=Q+2U$, $\hat W=\begin{pmatrix}A&B\\B&A\end{pmatrix}$.

- **Positivity.** The off-diagonal entries are $p_{ij}$ and $q_{ij}$ ($i\ne j$), plus $2u_i$ on $(+\varepsilon_i,-\varepsilon_i)$. All are positive at a positive solution. $\hat W$'s diagonal is $a_i$.
- **Split.** $(x\pm y)/\sqrt2$ block-diagonalises this to $A+B=S+A_d+2U$ and $A-B=D+A_d-2U$. The blocks of the Statement are these minus $I$. CONFIRMED.
- **$P$-edges** ($x=+\varepsilon_i,y=+\varepsilon_j$). $(A^2+B^2)_{ij}=(P^2+Q^2)_{ij}+(a_i+a_j)p_{ij}+2(u_i+u_j)q_{ij}$. The $p$-row turns this into $p_{ij}(2-2X^-_{ij}+a_i+a_j)=2(1+A_{ij})p_{ij}$.
- **$Q$-edges.** $(AB+BA)_{ij}=(PQ+QP)_{ij}+2(u_i+u_j)p_{ij}+(a_i+a_j)q_{ij}$. The $q$-row turns this into $2(1-A_{ij})q_{ij}$.
- **Long edges.** $(AB+BA)_{ii}=2\sum_lp_{il}q_{il}+4a_iu_i$. The long row turns this into $2u_i$, so $f=1$.
- **Diagonal** (unstated in the bullet). $(\hat W^2)_{xx}=\sum_l(p_{il}^2+q_{il}^2)+4u_i^2+a_i^2=2a_i+a_i^2$. So $f_{xx}=2+a_i$, which is the $a_i$ definition. The bullet should say that the diagonal carries the $a$-definition with factor $2+a_i$, so that the reading covers all four row types.
- The first sub-claim also holds. At $D=0$, step 1 gives $a=u$, so the first block is $S+3U-I$ with square $(I-U)^2$, which is L285 step (3) with $S=2P$. The second block's diagonal is $2(a_i-u_i)(1+2u_i)=0$, which is step (1).

## 4. Row-sum bullet

- $\sum_js_{ij}^2=\sum(p^2+q^2)+2\sum pq=(2a_i-4u_i^2)+2u_i(1-2a_i)=2(a_i+u_i)(1-2u_i)$.
- $\sum_jd_{ij}^2=(2a_i-4u_i^2)-2u_i(1-2a_i)=2(a_i-u_i)(1+2u_i)$.
- Since $1+2u_i>0$, it follows that $a_i\ge u_i$, with equality iff $\sum_jd_{ij}^2=0$, that is, iff row $i$ of $D$ vanishes. CONFIRMED.
- By-product used in item 6: at $k\ge2$, $\sum_js_{ij}^2>0$ and $a_i+u_i>0$ force $u_i<\tfrac12$.

## 5. Attempt 1

- The first block is $S-H$, $H=\operatorname{diag}(h)$, $h_i=1-2u_i-a_i$. Let $v$ be $S$'s Perron vector. $S$ is nonnegative and irreducible with positive off-diagonal entries ($k\ge2$), so $v>0$.
- $(S-H)v=((\rho-h_i)v_i)_i$, so $v^{\mathsf T}(S-H)^2v=\sum_i(\rho-h_i)^2v_i^2$. The displayed identity follows, and $-v^{\mathsf T}(S\circ D\circ D)v\le0$ because $S\circ D\circ D\ge0$ entrywise and $v\ge0$.
- Some $i$ therefore has $(\rho-h_i)^2\le1-2u_i+a_i^2$, so $\rho\le h_i+\sqrt{1-2u_i+a_i^2}\le\max_i(\cdot)$. CONFIRMED.
- The companion bounds also hold.
  - $\lambda_{\max}(D)\le\rho(\lvert D\rvert)<\rho(S)$ holds, because $\lvert d_{ij}\rvert<s_{ij}$ entrywise and $S$ is irreducible.
  - $\lambda_{\max}(D)\ge\min_{i\ne j}F_{ij}$ at $D\ne0$, with $F_{ij}=g_i+g_j-s_{ij}^2=2B_{ij}$, follows from $\operatorname{tr}D^3=\sum_{i\ne j}F_{ij}d_{ij}^2$ and $\operatorname{tr}D^3\le\lambda_{\max}\lVert D\rVert_F^2$.
- The off-diagonal forms $(D^2)_{ij}=d_{ij}(g_i+g_j-s_{ij}^2)$ and $(S^2)_{ij}=s_{ij}(h_i+h_j-d_{ij}^2)$ come directly from the blocks. $h=g-4u$ holds.
- **Margin at $I/c$.** Here $u=p=q=a=\tfrac1c$, $c=k+1$. This gives $\min F=2+\tfrac2c-\tfrac4{c^2}$ and $\max(h+\sqrt{\cdot})=2-\tfrac4c$ (which equals $\rho(S)$ there). The margin is $\tfrac6c-\tfrac4{c^2}$, so "order $\tfrac6c$" is CONFIRMED.

## 6. Attempt 3

- **$Z^2=X$.** The second block's matrix is $M=D+A_d-2U-I=D-G$, so $Z=G-D=-M$ and $Z^2=M^2=X$. The sign does not affect the square. It is the right choice for the $\lambda_{\min}$ hypothesis: at $D=0$, $a=u$ gives $Z=G=\operatorname{diag}(1+u_i)=R$.
- **$Z^2-R^2=RE+EZ$.** $R(Z-R)+(Z-R)Z=Z^2-R^2$. CONFIRMED.
- **Self-adjointness.** $\langle F,RE+EZ\rangle=\langle RF+FZ,E\rangle$, using $R,Z$ symmetric. The map is $R\otimes I+I\otimes Z$, with eigenvalues $r_i+z_j$ on $e_iw_j^{\mathsf T}$. CONFIRMED.
- **Chain.**
  - $RE+EZ=X-R^2=-D\circ S\circ S$ (the diagonal terms cancel exactly).
  - If $\mu:=\min_ir_i+\lambda_{\min}(Z)>0$, then $\lVert E\rVert_F\le\lVert D\circ S\circ S\rVert_F/\mu\le\max s_{ij}^2\,\lVert D\rVert_F/\mu$.
  - $E=(G-R)-D$ has off-diagonal part $-D$, so $\lVert D\rVert_F\le\lVert E\rVert_F$.
  - Hence $D\ne0$ forces $\mu\le\max s_{ij}^2$. The boxed hypothesis $\lambda_{\min}(Z)>\max s^2-\min r$ contradicts this and implies $\mu>0$. CONFIRMED.
- **$a_i<\tfrac12$ for $k\ge2$.** The long row gives $u_i(1-2a_i)=\sum_jp_{ij}q_{ij}>0$ with $u_i>0$. CONFIRMED.
- **$\sum_js_{ij}^2<1-4u_i^2$.** This multiplies $2(a_i+u_i)<1+2u_i$ by $1-2u_i$, which needs $1-2u_i>0$. The note does not state this, but it follows from item 4's by-product ($\sum_js_{ij}^2=2(a_i+u_i)(1-2u_i)>0$). **Correction: add "and the row sum being positive gives $u_i<\tfrac12$".** Nothing beyond the hypotheses is assumed.
- $1<\min r_i$ holds since $u_i>0$, and $\max_{ij}s_{ij}^2\le\max_i\sum_js_{ij}^2<1$. So the threshold is negative. "In particular wherever $D\preceq G$" holds, because then $\lambda_{\min}(Z)\ge0$. CONFIRMED.
- **$\sqrt{1+2u_i+a_i^2}\ge g_i$.** This holds exactly: $r_i^2-g_i^2=2(a_i-u_i)(1+2u_i)=(D^2)_{ii}\ge0$, a neater reason worth recording.
- **"This needs less of $\lambda_{\max}(D)$ than attempt 1" is unargued, and false as a general comparison.**
  - Attempt 3 gives $D\ne0\Rightarrow\lambda_{\max}(D)\ge\min g+\min r-\max s^2$.
  - Attempt 1 gives $\lambda_{\max}(D)\ge\min_{i\ne j}(g_i+g_j-s_{ij}^2)$.
  - Neither dominates. Attempt 1's pairwise minimum couples $g$ and $s^2$ on the same pair, and it can exceed attempt 3's bound when $\max s^2$ sits on a pair with large $g$.
  - **Correction**: state the comparison as a heuristic, or restrict it to the case where it holds. "Closes against $\rho(S)$ in the same regime" is prose without an argument.

## 7. Hermitian-pair remark

- The Cartan subalgebra lies in $\mathfrak u(k)$, so $C=\alpha P_{\mathfrak u(k)}+\beta P_{\mathfrak p}$ has $A=\alpha I$ with $p_{ij}=\alpha$ and $q_{ij}=u_i=\beta$.
- The idempotent's Cartan rows need $A_{ij}=\tfrac12(\beta^2-\alpha^2)=0$. This gives $\alpha^2=\beta^2$, and $\alpha=\beta$ on the positive cone, where $\alpha=-\beta$ is excluded.
- At the face $\beta=0$ this forces $\alpha=0$. CONFIRMED, with the wording correction "$\alpha^2=\beta^2$, so $\alpha=\beta$ at a positive point".

## 8. Attempts 1 and 2 as obstacles

- Attempt 1 is framed as an obstacle, and its quantitative claims hold (item 5). "Cross when $u_i$ is small against $a_i$ and $s_{ij}^2$" is a heuristic, which is acceptable in an obstacle note.
- **Attempt 2 states a result without an argument**: "This excludes $D\ne0$ when the factor's spread and the row sums are small". The clustering near $\{0,2\}$ and $\operatorname{tr}D=0$ do not by themselves exclude a small $D\ne0$.
  - A completion would argue that with $F\approx2$ one has $2D\approx D^2-\operatorname{diag}(D^2)$, so $\lVert D\rVert\lesssim\lVert D\rVert^2$, and hence $D=0$ or $D$ is large. That needs explicit constants.
  - **Correction**: mark it "(sketch)" or supply the bound.
- The "open regime" bullet's "$\sum_jd_{ij}^2$ nearly equals $\sum_js_{ij}^2$ when $a\gg u$" is right: the difference is $4u_i(1-2a_i)$. The claims that none of the three bounds reaches the faces, and that the system degenerates to $\mathfrak u(k)$'s there, are prose without an argument. They are presented as the open problem, which is acceptable.
