# REVIEW r1715: R48 batch 12, the odd L271 and H on the odd torus slice

Log: [agent_logs/r1715.log](../agent_logs/r1715.log). Block under audit: [2026-09-27-R48-torus-families.md](2026-09-27-R48-torus-families.md) batch 12. Lean draft read: the scratchpad `OddTorusDev.lean` (statements with `sorry`).

**Verdict: every link of the chain follows from the one above it and from the givens. No defect found. Two unstated but harmless hypotheses are noted under item 3.**

| # | claim | verdict |
|---|---|---|
| 1 | form of $C$ | CONFIRMED |
| 2 | norm | CONFIRMED |
| 3 | basis formula and vanishing criterion | CONFIRMED (two unstated hypotheses, both satisfied) |
| 4 | steps 1, 2 | CONFIRMED |
| 5 | step 3 | CONFIRMED |
| 6 | step 4 | CONFIRMED |
| 7 | coefficients, sum, check | CONFIRMED |
| 8 | H on the odd slice | CONFIRMED (conditional on the Gate 2 givens L279 and the odd L273 tangency) |
| 9 | exclusions | CONFIRMED (scope stated correctly) |
| 10 | Lean statement fidelity | CONFIRMED |

## Reasons

1. **Form of $C$.** $B_m$'s positive roots $\varepsilon_i\pm\varepsilon_j$, $\varepsilon_i$ are nonzero, pairwise distinct and no one is the negative of another, so the real torus isotypic components are $\mathfrak t$ and the 2-planes $R_\alpha$. A $T$-equivariant symmetric map preserves each. On $R_\alpha$ it commutes with a nontrivial rotation, so it is $aI+bJ$, and symmetry forces $b=0$.
2. **Norm.** $E$ lives on $\mathfrak{so}(2m)$ and $S$ on $\mathfrak p$, which are orthogonal coordinate subspaces, so $\lVert C\rVert^2=\lVert E\rVert^2+\lVert S\rVert^2$. $\lVert S\rVert^2=\sum_i 2w_i^2$ since each $R_{\varepsilon_i}$ is 2-dimensional. L271's $\tfrac12\lVert P\rVert^2+\tfrac12\lVert Q\rVert^2=\lVert U\rVert^2+\lVert V\rVert^2$ by the parallelogram law, with $\lVert U\rVert^2$ over ordered pairs matching $2\mu^2$ per unordered root plane.
3. **Basis formula.** Expanding $\tfrac12\sum_{\beta,\gamma}\langle Y[Xe_\beta,Ze_\gamma],[e_\beta,e_\gamma]\rangle$ gives $\tfrac12\sum X_{\gamma'\beta}Z_{\delta'\gamma}Y_{\nu\mu}c_\mu^{\gamma'\delta'}c_\nu^{\beta\gamma}$: each operator pairs one index of each structure tensor. It equals Hamilton's contraction because $c$ is totally antisymmetric in an orthonormal basis of an ad-invariant inner product, and because $X,Z$ are symmetric (the formula reads $X_{\gamma'\beta}$ where Hamilton reads $X_{\beta\gamma'}$). Neither hypothesis is written, and both hold here ($\tfrac12\mathop{\mathrm{tr}}$ is ad-invariant, $E,S$ are symmetric). The vanishing criterion is immediate: $Y$ sits on $[Xu,Zv]$. Moving $E$ to the middle uses only the full symmetry of $F$ on symmetric operators, and the expansion $F(E+S)=F(E)+3F(E,E,S)+3F(E,S,S)+F(S)$ with $F(E,S,S)=F(S,E,S)$ is correct.
4. **Steps 1, 2.** $[e_a\wedge e_{n},e_b\wedge e_{n}]=\pm e_a\wedge e_b$ with $a,b\le2m$, so $[\mathfrak p,\mathfrak p]\subseteq\mathfrak{so}(2m)$. $\mathfrak{so}(2m)$ is a subalgebra. $S$ is zero on $\mathfrak{so}(2m)$. In step 2 the brackets are $[Eu,Ev]$ and $E$ maps into $\mathfrak{so}(2m)$, which is what is needed.
5. **Step 3.** $Ee_\beta=0$ for $\beta\in\mathfrak p$, so the double sum runs over the coordinate basis of $\mathfrak{so}(2m)$. Brackets, the inner product and $E$ restricted there are those of $\mathfrak{so}(2m)$, so the sum is the $\mathfrak{so}(2m)$ formula term by term. $E|_{\mathfrak{so}(2m)}$ is L271's operator with the same $A,U,V$ (the Lean `extOp (torusOp A U V)` makes the identification literal).
6. **Step 4.** $Se_\beta=w_\beta e_\beta$ on $\mathfrak p$, zero elsewhere, giving the displayed sum. Same-$i$ pairs: bracket $\pm h_i$, 2 ordered pairs, contribution $\tfrac12\cdot2w_i^2A_{ii}$. Cross pairs: $4\times2=8$ ordered pairs per unordered $\{i,j\}$. Checked directly: each coordinate vector of $B_{ij}$ is $(u+v)/\sqrt2$ with $u\in R_{\varepsilon_i-\varepsilon_j}$, $v\in R_{\varepsilon_i+\varepsilon_j}$ unit, so $\langle Ee,e\rangle=\tfrac12(U_{ij}+V_{ij})=\tfrac12P_{ij}$. Contribution $\tfrac12\cdot8\cdot w_iw_j\cdot\tfrac12P_{ij}=2w_iw_jP_{ij}$ per unordered pair, which is $w^{\mathsf T}Pw$ since $P$ has zero diagonal. The sign ambiguity of the bracket is squared away.
7. **Sum and check.** $F(C)=F(E)+3F(S,E,S)$ gives the statement. At $C=I$: $3m(2m-1)+4m(m-1)(m-2)+6m(m-1)=m(4m^2-1)=(2m-1)\dim\mathfrak{so}(2m+1)$, recomputed.
8. **H.** The $A$-terms are $3\langle A,A_\mu\rangle_{\rm Frob}$, and $\lVert A_\mu\rVert^2=\sum(d_i+w_i^2)^2+\sum_{i\ne j}P_{ij}^2Q_{ij}^2=g^2$. $b^2$ is the non-Cartan part of $\lVert C\rVert^2$, so $\lVert C\rVert^3=(a^2+b^2)^{3/2}$ and cubic homogeneity reduces to $b=1$. $b=0$ gives $U=V=w=0$ and $F=0$. L279's hypotheses (symmetric zero-diagonal $U,V$, any $w$) are exactly the slice's. $\Psi_\kappa$ is recomputed: the minimiser satisfies $g=\kappa at$, $t=\sqrt{1+a^2}\ge1$, and $g\mapsto t$ covers all $g\ge0$. $\kappa=(n-2)/\sqrt{\dim\mathfrak{so}(n)}$ at $n=2m+1$ is $(2m-1)/\sqrt{m(2m+1)}$.
9. **Exclusions.** The claim is for $m\ge7$ (odd $n\ge15$), so odd $n\in\{5,\dots,13\}$ stay open, and the batch says so. No positivity is used anywhere (L271's formula and L279 hold for all $A,U,V,w$), so indefinite $C$ are covered. $w=0$ is included.
10. **Lean.** `torusOpOdd = extOp (torusOp A U V) + shortOp w`: `extOp` acts by `torusOp` on the old block and kills every $e_a\wedge e_{\rm none}$ (`restrictL` of such a vector is zero), which is $E$. `shortOp` multiplies the $(a,{\rm none})$ and $({\rm none},a)$ entries by $w_{a.1}$ and kills the old block, which is $S$. `L280_norm` is the batch's norm in the $\lVert U\rVert^2+\lVert V\rVert^2$ form (no `hA`, as in `L271_norm`). `L280_F` is the batch's $F$ term for term, `w i * (U + V) i j * w j` being $w^{\mathsf T}Pw$. `H_torus_slice_odd` takes $m=n+1\ge7$, carries $\kappa$ as $(2m-1)/\sqrt{m(2m+1)}$ and `normSq2 ^ (3/2)` as $\lVert C\rVert^3$ (`normSq2` is $\tfrac12$-trace based, nonnegative).

## Screens (never evidence for a positive claim)

- numpy, $\mathfrak{so}(5)$ and $\mathfrak{so}(7)$, one random $A,U,V,w$ each, $C$ built from the root planes found as kernels of $\mathop{\mathrm{ad}}(h_i+h_j)$ on $B_{ij}$, $F$ from Hamilton's structure-constant formula (sanity $I\#I=(n-2)I$): $F$ and $\lVert C\rVert^2$ agree with the batch's formulas to $10^{-13}$. The $w^{\mathsf T}Pw$ term confirms the $P$ versus $Q$ orientation.
- sympy: $h-\delta^2(c_2+c_3\delta+c_4\delta^2)$ is below $10^{-14}$ at $m=7,10,31$ and three $\delta$, and $c_2-\kappa/m$ is $1.92$ at $m=7$, tending to $\tfrac{3\sqrt2}{2}$.
