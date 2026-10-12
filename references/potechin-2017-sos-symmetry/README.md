# Potechin, Sum of squares lower bounds from symmetry and a good story

| | |
| --- | --- |
| **Source** | [Sum of squares lower bounds from symmetry and a good story](https://arxiv.org/abs/1711.11469) |
| **Identifier** | arXiv:1711.11469v3 (2018) |
| **Retrieved** | 2026-09-23 |

## Consulted for

**The pseudoexpectation that proves the odd sharp sextic is not a sum of squares.** This is the single external input to an outside report archive (unpublished, held in the private record), whose two-page argument the record holds as a fence post for odd $n$. Without this paper that argument has no engine.

## Statements that matter

- **Theorem 1.1**, Grigoriev's SOS lower bound for knapsack, re-derived by the paper's machinery: degree $\min\{2\lfloor\min\{k,n-k\}\rfloor+3,\ n\}$ sum-of-squares **fails** to prove the knapsack equations $x_i^2=1$, $\sum_ix_i=k$ infeasible. The bound is tight.
- **Example 3.3** constructs the knapsack pseudoexpectation explicitly by an adversary argument: $\tilde E[\prod_{i\in I}y_i]=(k/2)_{|I|}/n_{|I|}$ in falling factorials, with $y_i=(z_i+1)/2$.
- **The method**, which is what the title means: a pseudoexpectation is built from the symmetry group of the problem plus a consistent "story" an adversary can tell, rather than from an explicit moment matrix, and positivity follows from the representation theory.

## Verdict

**Sound and load-bearing for a statement the record wants to keep, and the degree bound is the part to check.** The outside note applies Theorem 1.1 at degree 12 with $n$ odd and $k=n/2$ formally, the balanced Boolean system $z_i^2=1$, $\sum z_i=0$ having no real solution at odd $n$, and needs the degree bound to cover 12 for every odd $n\ge13$. At $n=13$, $\min\{2\lfloor6\rfloor+3,13\}=13>12$, so it does; the general claim is that $2\lfloor\min\{k,n-k\}\rfloor+3\ge12$ once $n\ge13$, which holds since $\min\{k,n-k\}\ge6$. **That arithmetic checks, and it is the only step of the outside argument that depends on this paper.** Whether the rest of that argument is right is [I113](../../plan.md)'s neighbour and not settled here.
