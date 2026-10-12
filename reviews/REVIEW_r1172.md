# r1172: L244 row (A) in the record's variables, in Lean

Brief: [2026-09-25-rowA-gate2-brief.md](2026-09-25-rowA-gate2-brief.md). Declaration: rowMass_total in [L244RowA.lean](../lean/HamiltonsCubic/Results/L244RowA.lean). Record statement: the per-vector rows in [second-order.md](../findings/second-order.md) (line 305 fixes $b_{ab}(x)=\tfrac12\sum_{\gamma\in E_a,\delta\in E_b}\langle[\psi_\gamma,\psi_\delta],x\rangle^2$ with $\psi$ an orthonormal basis adapted to $W$'s eigenspaces $E_a$).

## Verdicts

| item | verdict |
|---|---|
| 1. rowMass_total states row (A) summed over all classes, basisFam correct | PLAUSIBLE: the identity and the reindexing are CONFIRMED, the reach to the record's $b_{ab}$ needs one untyped step |
| 2. the L244 row of [lean/INDEX.md](../lean/INDEX.md) claims only this | REFUTED in part: "in the record's variables" and "split by class through rowMass_split" overstate the reach, correction below |
| 3. build and axiom audit | CONFIRMED |

## Item 1

- **The identity is right.** rowMass with $\psi=\varphi=$ the basis $\{\varphi_{ij}\}_{i<j}$ is $\tfrac12\sum_{k,l}\langle[\varphi_k,\varphi_l],x\rangle^2$. The inner product is inner2 $=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ from [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), under which $\varphi_{ij}$ ($i<j$) is orthonormal, and phi_expand_ordered supplies the completeness hypothesis hexp. The value $(n-2)\langle x,x\rangle$ matches the record's row (A) at unit $x$ and is homogeneous in $x$, so the statement for every skew $x$ is the right generalisation. Screen by hand at $n=3$, $x=\varphi_{12}$: $\tfrac12(\lVert[\varphi_{13},x]\rVert^2+\lVert[\varphi_{23},x]\rVert^2)=\tfrac12(1+1)=1=(3-2)\cdot1$.
- **basisFam is the full basis, reindexed correctly.** It is $k\mapsto\varphi$ at $(\text{equivFin}(\text{Pairs }n))^{-1}(k)$, a bijection from Fin of the card onto the pairs $i<j$, and the proof's step e1 moves the sum across it with Equiv.sum_comp. The first slot is indexed by Fin only because rowMass requires Fin $r$ there.
- **The class split reaches labellings of the coordinate basis only.** rowMass_split gives $\text{rowMass}=\sum_b\text{bMass}$ for a labelling cls of the same family $\varphi$ that rowMass_total fixes, the coordinate basis $\varphi_{ij}$. The record's $b_{ab}$ is a sum over an orthonormal basis adapted to $W$'s eigenspaces, and at a general $W$ those eigenspaces are spanned by no subset of $\{\varphi_{ij}\}$. So $\sum_{a,b}b_{ab}(x)=(n-2)\langle x,x\rangle$ in the record's variables follows from rowMass_total together with one step the layer lacks: $\text{rowMass}\,\psi\,\psi\,x=\text{rowMass}\,(\text{basisFam }n)\,\varphi\,x$ for any orthonormal complete skew family $\psi$.
- **That step is short and uses only what is typed.** rowMass_eq applies with $\varphi:=\psi$ (hexp from $\psi$'s completeness) and gives $\tfrac12\sum_\gamma\lVert[\psi_\gamma,x]\rVert^2$. Expanding each $\lVert[\psi_\gamma,x]\rVert^2$ in the coordinate basis, moving ad across the inner product (inner2_br_skew), and expanding again in $\psi$ gives $\tfrac12\sum_k\lVert[\varphi_k,x]\rVert^2$, which is the coordinate side. The step is a double Parseval swap, i.e. the basis independence of $\operatorname{tr}(-\mathrm{ad}_x^2)$.

## Item 2

The L244 row's clause "row (A) in the record's variables is PROVED: rowMass_total ..., with $\psi,\varphi$ the full basis $\varphi_{ij}$, $i<j$ (split by class through rowMass_split)" names the coordinate basis honestly, and the row's "Not typed" list already carries "the construction of $\psi$, $\varphi$, cls from $W$'s eigenspaces". The overclaim is the pairing of "the record's variables" with the parenthetical, which reads as if rowMass_split delivers $\sum_{a,b}b_{ab}$ at $W$'s eigenspaces. Suggested wording for the clause:

> **row (A) at the coordinate basis is PROVED**: rowMass_total in L244RowA.lean, $\tfrac12\sum_{k,l}\langle[\varphi_k,\varphi_l],x\rangle^2=(n-2)\langle x,x\rangle$ for skew $x$ over the basis $\varphi_{ij}$, $i<j$. The record's form $\sum_{a,b}b_{ab}(x)$ over an eigenspace-adapted orthonormal basis needs, in addition, the basis independence of $\tfrac12\sum_\gamma\lVert[\psi_\gamma,x]\rVert^2$ over orthonormal complete skew families (a double Parseval swap from rowMass_eq and inner2_br_skew, untyped), and the construction of that basis from $W$ (already listed as not typed).

Alternatively the one-lemma gap can be closed in Lean, after which the present wording stands.

## Item 3

- lake build HamiltonsCubic.Results.L244RowA from lean/: "Build completed successfully (8743 jobs)", exit 0, no errors and no sorry. One style warning: line 31 exceeds 100 characters.
- python3 scripts/misc/axiom_audit.py --only L244RowA: "1/1 clean -- resting on the standard three alone".
