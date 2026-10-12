# Conti, Rossi, Construction of nice nilpotent Lie groups

| | |
| --- | --- |
| **Source** | [Construction of nice nilpotent Lie groups](https://arxiv.org/abs/1803.09248) · [J. Algebra 525 (2019) 311–340](https://doi.org/10.1016/j.jalgebra.2019.01.017) |
| **Identifier** | arXiv:1803.09248v3, 15 Feb 2019 |
| **Retrieved** | 2026-09-01 |

## Consulted for

Plan item [T6](../../plan.md), the realizability half: which combinatorial supports carry an actual Lie algebra, and what the Jacobi identity costs once the magnitudes are fixed and only signs remain free. Read alongside [Payne](../payne-2010-soliton-metrics/notes.md), which supplies the squared-structure-constant side.

## Statements that matter

- **Proposition 1.3**, the Jacobi identity for a labeled diagram is $\sum_{I,J}c_Ic_J\,a(E_{IJ})=0$, a system of **quadratic** equations in the structure constants.
- **Condition (N4)**, a consequence of Jacobi at the level of the **diagram alone**: no four distinct nodes $i,j,k,v$ with exactly one of three named arrows a double arrow. Equivalent to Payne's "no quadruples of multiplicity one"; in Gram-matrix terms, double arrows are the $-1$ entries.
- **Remark 1.8 / §2.4**, where the diagram has no double arrows, "*the Jacobi identity follows automatically from the definition of nice diagram*". Jacobi is then vacuous on the values.
- **The normalization**, the diagonal group $D_n$ normalizes most structure constants to $\pm1$; after that, "*for $n\le8$ these equations reduce to linear equations*", and only $20$ of the dimension-$9$ diagrams keep genuinely quadratic equations, of which $5$ have no admissible solution.
- **Example 1.4**, an explicit surviving Jacobi equation, $c_{123}c_{347}+c_{246}c_{617}+c_{415}c_{527}=0$: three signed products summing to zero.

## Verdict

**Realizability is decided by the support first and by signs second, and there is no closed characterization, it is settled by algorithm.** The paper is the state of the art on "which nonnegative data arise as structure constants", and its answer is an enumeration to dimension $9$ with a C++ implementation, not a criterion. For T6 the load-bearing content is negative and precise: **once the support is admissible, everything Jacobi still demands is a cancellation among signed products**, invisible to the magnitudes.
