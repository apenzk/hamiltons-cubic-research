# Transcription notes

Read on 2026-09-23 for one purpose: whether the degree bound cited by the outside odd non-SOS note is real and covers degree 12 at every odd $n\ge13$. Theorem 1.1, Example 3.3 and the surrounding definitions were read; the paper's other applications, the MOD 2 principle and the Tseitin and planted-clique material, were **not transcribed**.

## The statement the record depends on

**Theorem 1.1 (Grigoriev's SOS lower bound for knapsack).** Degree $\min\{2\lfloor\min\{k,n-k\}\rfloor+3,\ n\}$ SOS fails to refute
$$x_i^2-x_i=0\ (1\le i\le n),\qquad \sum_{i=1}^nx_i-k=0.$$
The paper notes the bound is tight, and credits Grigoriev, deriving it here as an illustration of the symmetry method.

## The pseudoexpectation, Example 3.3

Built by an adversary who is asked for one variable at a time and answers with the conditional probability of a uniformly random $k$-subset: $\tilde E[y_i]=k/n$, $\tilde E[y_iy_j]=k(k-1)/(n(n-1))$, and in general $\tilde E[\prod_{i\in I}y_i]=(k)_{|I|}/(n)_{|I|}$ with $(a)_r=a(a-1)\cdots(a-r+1)$. **At $k=n/2$ with $n$ odd this is a formal object**: no $k$-subset of that size exists, which is exactly why the system is infeasible and the functional is not an expectation. It is nonetheless a valid degree-bounded pseudoexpectation, which is the content of the theorem.

## The degree check, done here

The outside note needs degree 12 covered for every odd $n\ge13$. With $k=n/2$ formally, $\min\{k,n-k\}=n/2\ge6.5$, so $\lfloor\cdot\rfloor\ge6$ and $2\cdot6+3=15>12$, while the second branch is $n\ge13>12$. **So the bound covers degree 12 at every odd $n\ge13$, as the note claims.** The note's own reductions $\equiv_4$ and $\equiv_6$ then keep every product it forms inside degree 12, which is checked in the note and not here.

## A caution carried from the paper

The functional is degree-bounded. **Every identity the outside argument uses must be a bounded-degree consequence of the two equations**, which the note states as its $\equiv_d$ convention and respects. A reader tempted to substitute a higher-degree identity loses the whole argument, and the paper's framing makes that easy to miss.
