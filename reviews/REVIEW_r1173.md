# REVIEW r1173: row (A) at any complete skew family in Lean

Brief: [2026-09-25-rowA-any-gate2-brief.md](2026-09-25-rowA-any-gate2-brief.md). File under review: [L244RowA.lean](../lean/HamiltonsCubic/Results/L244RowA.lean). Record statement: [second-order.md, L244](../findings/second-order.md#lemma-l244-the-per-vector-ceiling-on-a-symmetric-three-value-critical-point). Analysis only, no numerical screen was needed.

## Verdicts

| item | verdict |
|---|---|
| 1. statements, completeness at W's eigenbasis | **CONFIRMED** |
| 2. the L244 row of lean/INDEX.md | **CONFIRMED**, with three additions to its untyped list |
| 3. build and axiom audit | **CONFIRMED** |

## Item 1

- **parseval** states $\langle Y,Y\rangle=\sum_k\langle\varphi_k,Y\rangle^2$ for skew $Y$ from the expansion hypothesis alone. The claim as briefed, with no weakening. The hypothesis is satisfiable (the coordinate family satisfies it, see `hbexp` in the same file), so the statement is non-vacuous.
- **bracket_sum_indep** states equality of $\sum_\gamma\lVert[x,\psi_\gamma]\rVert^2$ over any two skew families that expand every skew matrix, for skew $x$. The proof is the double Parseval swap through ad-invariance (`inner2_br_skew` in [L209FoxClosure.lean](../lean/HamiltonsCubic/Results/L209FoxClosure.lean)) and `br_isSkew` supplies the skewness of $[x,\psi_\gamma]$ that Parseval needs. Matches the claim exactly.
- **rowMass_total_any** states `rowMass ψ φ x = (n − 2)⟨x, x⟩` for $\psi$ a skew family indexed by `Fin r` expanding every skew matrix, $\varphi$ any family expanding every skew matrix, $x$ skew. It is slightly stronger than briefed: $\varphi$ carries no skewness hypothesis, and the conclusion holds at every skew $x$, which gives the record's $n-2$ at unit $x$. It reduces to `rowMass_total` (the coordinate case) through `rowMass_eq` on both sides, `br_sq_swap` and `bracket_sum_indep`.
- **Completeness at W's eigenbases.** The record's inner product is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ ([conventions.md](../findings/conventions.md), the $\lVert\cdot\rVert$ row), the same as `inner2`. $W$ is self-adjoint on $\Lambda^2=\mathfrak{so}(n)$, so its eigenspaces are mutually orthogonal and span $\mathfrak{so}(n)$, and the union of orthonormal bases of the $E_a$ is an orthonormal basis of $\mathfrak{so}(n)$. For an orthonormal basis $\{\psi_k\}$ of the skew matrices the expansion $Y=\sum_k\langle\psi_k,Y\rangle\psi_k$ holds for every skew $Y$, so `hψS`, `hψ` and `hφ` all hold with $\varphi=\psi$ that basis enumerated by `Fin r`, $r=n(n-1)/2$. The record defines $b_{ab}(x)=\tfrac12\sum_{\gamma\in E_a,\delta\in E_b}\langle[\psi_\gamma,\psi_\delta],x\rangle^2$, so `rowMass ψ ψ x` is $\sum_{a,b}b_{ab}(x)$ by partitioning the finite double sum. Nothing further is needed for row (A) in bracket form. The identity $b_{ab}(x)=\langle B_{ab}x,x\rangle$ stays untyped, as the INDEX row already says.
- Build warnings for this module are style only: long lines, unused simp arguments, and an unused `DecidableEq` section instance in four declarations. None touches a statement.

## Item 2

The L244 row of [lean/INDEX.md](../lean/INDEX.md) claims `parseval`, `bracket_sum_indep` and `rowMass_total_any` as above, keeps the lemma **partial**, and claims nothing beyond these declarations. One wording point: the row says "for $\psi$ any complete skew family", and $\varphi$ in Lean needs completeness only, a harmless understatement.

What remains untyped between these declarations and `per_vector_ceiling`'s hypotheses in [L244SymmetricPerVector.lean](../lean/HamiltonsCubic/Results/L244SymmetricPerVector.lean):

- **hA** ($b_{00}+b_{11}+b_{22}+2(b_{01}+b_{02}+b_{12})=n-2$). Three bookkeeping steps, none in the INDEX row's untyped list: (a) the split of `rowMass` on the $\psi$ side into per-eigenspace families (`rowMass_split` splits only the $\varphi$ side, and `bMass` sums $\gamma$ over the whole of $\psi$); (b) the symmetry $b_{ab}=b_{ba}$, from $[\psi_\gamma,\psi_\delta]=-[\psi_\delta,\psi_\gamma]$, which the coefficient 2 in `hA` uses; (c) the normalisation $\langle x,x\rangle=1$. Plus the construction of the eigenbasis and `cls` from $W$, already listed. **Recommendation**: add (a), (b), (c) to the row's "Not typed" list.
- **hB** and **hC**: wholly untyped. They are the weighted rows, resting on $I\#W=-W$ and the operator identity $W^\#=\theta W-W^2$ paired with $x\in E_0$, which the row already lists as entering as hypotheses.

## Item 3

- `lake build HamiltonsCubic.Results.L244RowA` from `lean/`: **Build completed successfully (8743 jobs)**, exit 0, no errors, no `sorry` in the file.
- `python3 scripts/misc/axiom_audit.py --only L244RowA`: **6/6 clean, resting on the standard three alone**.

## Correction

No declaration is wrong. The single correction is to the INDEX row's untyped list for `hA`: the $\psi$-side split, the symmetry $b_{ab}=b_{ba}$ and the unit normalisation.
