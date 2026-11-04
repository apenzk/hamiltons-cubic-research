# REVIEW r1662: L274, J1 at Q = 0 (a degree-refined traceless cubic bound)

Log: [agent_logs/r1662.log](../agent_logs/r1662.log)

Cold Gate 2 review of [second-order.md](../findings/second-order.md)'s L274, on the analysis-only footing: every step below was re-derived by hand. No numerical screen was run. The one machine check is a compile of [L274.lean](../lean/HamiltonsCubic/Results/L274.lean).

**Overall: CONFIRMED WITH GAPS.** The chain (1) to (6) is correct and closes to the stated constant. The gaps are unstated routine facts and one ambiguous sentence in *What it gives*, and none affects the inequality.

| claim | verdict |
|---|---|
| Step (1) | CONFIRMED |
| Step (2) | CONFIRMED |
| Step (3) | CONFIRMED |
| Step (4) | CONFIRMED (Lean-proved as L274_simplex, see the Lean row) |
| Step (5) | CONFIRMED WITH GAPS (G1, G2) |
| Step (6) | CONFIRMED |
| Equality at J − I, containment, J1 translation | CONFIRMED WITH GAPS (G3) |
| What it gives | CONFIRMED WITH GAPS (G4, G5) |
| Lean statement L274_bound | CONFIRMED (matches the block, see below) |

## Step by step

**(1).** With zero diagonal, $\mathop{\mathrm{tr}}W^3=\sum_{i\ne j}W_{ij}(W^2)_{ij}$ and $(W^2)_{ij}=\sum_{k\ne i,j}W_{ik}W_{kj}$, the terms $k=i$ and $k=j$ vanishing because $W_{ii}=W_{jj}=0$. Cauchy–Schwarz over $k$ gives $|(W^2)_{ij}|\le\sqrt{(D_i-x_{ij})(D_j-x_{ij})}$, since $\sum_{k\ne i,j}W_{ik}^2=D_i-x_{ij}$. A vertex with $D_i=0$ has every $x_{ij}=0$ and contributes nothing. Correct.

**(2).** For $x_{ij}>0$ both $D_i,D_j>0$, and $x_{ij}(D_i-x_{ij})(D_j-x_{ij})=x_{ij}(1-p_{ij})(1-p_{ji})D_iD_j$. Terms with $x_{ij}=0$ (non-edges and every pair at an isolated vertex) are zero on both sides, so the undefined $p$ there carries weight zero. Cauchy–Schwarz over ordered pairs $i\ne j$ with $a_{ij}=\sqrt{x_{ij}(1-p_{ij})(1-p_{ji})}$, $b_{ij}=\sqrt{D_iD_j}$: $\sum a_{ij}^2=S\,\mathbb E_{x/S}[(1-p_{ij})(1-p_{ji})]$ and $\sum_{i\ne j}D_iD_j=S^2-\sum D_i^2$. Correct. The statement divides by $\sqrt S$, so it presumes $W\ne0$, while the Lean form multiplies through and covers $W=0$ (G3).

**(3).** AM–GM termwise, and $\mathbb E[(1-p_{ji})^2]=\mathbb E[(1-p_{ij})^2]$ by relabelling, since $x_{ij}=x_{ji}$. Then $\mathbb E[(1-p_{ij})^2]=\sum_i\frac{D_i}S\sum_jp_{ij}(1-p_{ij})^2=\sum_i\pi_ih(p_{i\cdot})$ over rows with $D_i>0$, each $p_{i\cdot}$ a probability vector on the $n=m-1$ indices $j\ne i$. Correct.

**(4).** With $s_2=\sum p_k^2$, $s_3=\sum p_k^3$: $\text{RHS}-h=\frac1n\big((n+1)s_2-ns_3-1\big)=\frac1n\sum_kp_k(1-p_k)(np_k-1)$, so the claimed equivalence holds. The identity with $n\sum(p_k-\frac1n)^2(1-\frac1n-p_k)$ is right. At most one coordinate exceeds $1-\frac1n$, since two would sum to more than $2-\frac2n\ge1$. In the bad case the others satisfy $p_k\le1-a$, so $1-\frac1n-p_k\ge a-\frac1n\ge0$. Cauchy–Schwarz gives $\sum_{k\ne1}(p_k-\frac1n)^2\ge(a-\frac1n)^2/(n-1)$. Then $(a-\frac1n)^2\big[(1-\frac1n-a)+\frac{a-1/n}{n-1}\big]=(a-\frac1n)^2\frac{n-2}{n-1}(1-a)$, checked by hand. Correct, and the Lean proof follows exactly this route.

**(5).** At $S=1$ (the expectation and $\pi$ are degree 0, so the normalisation is free, but the step does not say so), $\sum_i\pi_i\sum_jp_{ij}^2=\sum_i\sum_jx_{ij}^2/D_i$ over $D_i>0$. Engel's form of Cauchy–Schwarz over $i$ gives $\sum_ix_{ij}^2/D_i\ge D_j^2/\sum_{i\ne j,\,x_{ij}>0}D_i$, and the denominator is at most $1-D_j$. The step reads "by Cauchy–Schwarz over $i$" and leaves this denominator relaxation unstated (**G1**). Domain: $D_j=\sum_{i\ne j}x_{ij}\le\sum_{i\ne j}D_i=1-D_j$, so $D_j\le\frac12<1$. The step uses $D_j<1$ without saying why (**G2**). Convexity holds because $\psi''(t)=2/(1-t)^3-2\frac{n^2-1}{n^2}\ge\frac2{n^2}>0$ on $[0,1)$. Jensen over all $m=n+1$ vertices with uniform weight is legitimate, including $D_j=0$, since $0$ is in the domain. $(n+1)\psi(\frac1{n+1})=\frac1n-\frac{n-1}{n^2}=\frac1{n^2}$, so the bound $(1+(n^2-1)\sum\pi_i^2)/n^2$ is right. At $S=1$, $\pi_j=D_j$.

**(6).** The coefficient of $\sum_jp_{ij}^2$ in (4) is $-\frac{n-1}n<0$, so a lower bound from (5) is the right direction. $\sum_i\pi_i\big[(\frac{n-1}n)^2+\frac{n-1}{n^2}\big]=\frac{n-1}n$. Hence $\mathbb E\le\frac{n-1}n\big(1-\frac{1+(n^2-1)\Sigma}{n^2}\big)=\frac{(n-1)^2(n+1)}{n^3}(1-\Sigma)$, with $\Sigma=\sum\pi_i^2$. This equals $K_m^2=m(m-2)^2/(m-1)^3$. Closing (2): $\sqrt{S K_m^2(S^2-\sum D_i^2)/S^2}\sqrt{S^2-\sum D_i^2}=K_m(S^2-\sum D_i^2)/\sqrt S$. Correct. Step (4) needs $n\ge2$, which is $m\ge3$.

## Equality, containment, translation to J1

- $W=J-I$: $\mathop{\mathrm{tr}}W^3=(m-1)^3-(m-1)=m(m-1)(m-2)$, $S=m(m-1)$, $S^2-\sum D_i^2=m(m-1)^3$, and the right side is $\frac{\sqrt m(m-2)}{(m-1)^{3/2}}\cdot\frac{m(m-1)^3}{\sqrt{m(m-1)}}=m(m-1)(m-2)$. Equality holds.
- Containment: $\sum D_i^2\ge S^2/m$ gives right side $\le K_m\frac{m-1}mS^{3/2}=\frac{m-2}{\sqrt{m(m-1)}}S^{3/2}$. **G3 (wording):** this recovers the traceless cubic bound for zero-diagonal $W$. For a general traceless symmetric matrix it needs one more sentence: such a matrix is orthogonally similar to a zero-diagonal one, and $\mathop{\mathrm{tr}}W^3$, $\lVert W\rVert$ are orthogonal invariants. The statement should also say $W\ne0$ (or take the multiplied form, as the Lean does).
- J1 at $Q=0$: L271 gives $d_i=\sum_l(U_{il}^2+V_{il}^2)=\frac12\sum_l(P_{il}^2+Q_{il}^2)$, so $d_i=D_i/2$ at $Q=0$. $A_\mu$ has diagonal $d$ and off-diagonal $-P_{ij}Q_{ij}=0$, so $g^2=\sum d_i^2=\sum D_i^2/4$. With $S=2$: $T=\frac12\mathop{\mathrm{tr}}P^3\le\frac{K_m(4-\sum D_i^2)}{2\sqrt2}=\sqrt2K_m(1-g^2)=\lambda_m(1-g^2)$, and $\sqrt2K_m=\frac{\sqrt{2m}(m-2)}{(m-1)^{3/2}}=\lambda_m$. That is J1 at $Q=0$. Correct.

## What it gives

- **Pointwise use of L273 (3): correct in the prose.** L273 (3)'s proof uses J1 only at the $(P,Q)$ of the $X$ at hand, after rescaling to $b=1$, and rescaling preserves $Q=0$. (1) supplies $g\ge1/\sqrt m$, which (2) needs. So for $m\ge5$, H holds at every torus-invariant $X$ with $U=V$, that is $\mu_{\varepsilon_i+\varepsilon_j}=\mu_{\varepsilon_i-\varepsilon_j}$ for all pairs. L274 allows arbitrary real $W$, so negative weights are covered. The uniform point has $U=V$. **G4:** the Lean form [L273_J1_implies_H](../lean/HamiltonsCubic/Results/I117Statements.lean) takes J1 as a hypothesis over all $(U,V)$ on the root sphere, so this restricted corollary rests on prose. It needs either a pointwise variant of that theorem or a note that the restriction is prose.
- **G5 (ambiguity):** "At the $\Lambda^2_+$ edge every step but Jensen in (5) is an equality" directly follows a sentence about the $2m\times2m$ cocktail-party matrix. It is true for L274 applied to $W=P$ (a single edge, $P_{12}=1/\sqrt2$): with $S=1$, $D_1=D_2=\frac12$, and step (5)'s denominator $D_2=1-D_1$ is tight. The [working note](2026-09-27-I117-J1.md), line 55, means this reading. On the cocktail-party matrix at the same point ($V=0$, $U_{12}$ only, two disjoint edges, $D=\frac14$ at four vertices, $S=1$) step (5)'s relaxation is strict: $\sum_ix_{ij}^2/D_i=\frac14$ against $D_j^2/(1-D_j)=\frac1{12}$. So "every step but Jensen" is false on that matrix. The sentence should name $W=P$.
- The cocktail-party screens ($m=4$ to $8$, the $0.05$ failure of $\sqrt{d_id_j}$ pairing) were not re-run, since they are screens on the analysis-only footing. They are reported as screens and carry no positive claim, which is right.

## Lean

- [L274_bound](../lean/HamiltonsCubic/Results/L274.lean) is the block's inequality multiplied by $\sqrt S$. $(m-1)^{3/2}$ is written as $(m-1)\sqrt{m-1}$, and $S$ and $\sum_iD_i^2$ are spelled out from the entries. The hypotheses are $3\le m$, $W^{\mathsf T}=W$ and a zero diagonal. It is equivalent to the block for $S>0$ and trivially true at $S=0$. The equality clause and the containment are left out, which the header's scope allows.
- L274_simplex states step (4) in its $\sum p(1-p)(np-1)\ge0$ form, and the proof follows the prose case split. `lake env lean HamiltonsCubic/Results/L274.lean` compiles in about 17 s. Its only warning is `declaration uses sorry` at line 96, which is L274_bound. L274_simplex is sorry-free.
