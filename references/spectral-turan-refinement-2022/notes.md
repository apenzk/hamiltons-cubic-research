# Notes, Li–Peng, arXiv:2204.09194 (read pp. 1–3; proof sections skimmed for method)

## The statements (verbatim, with hypotheses)

**Theorem 1.1 (Nosal, 1970; equality case Nikiforov).** *Let $G$ be a graph with $m$ edges. If $G$ is triangle-free, then $\lambda(G)\le\sqrt m$, equality iff $G$ is a complete bipartite graph* (isolated vertices ignored)., p. 3, eq. (2).

Spectral Mantel in two lines from it: Rayleigh gives $2m/n\le\lambda(G)$, so $m\le\lfloor n^2/4\rfloor$ (Mantel); conversely Mantel plus Theorem 1.1 gives $\lambda(G)\le\sqrt{\lfloor n^2/4\rfloor}=\lambda(K_{\lfloor n/2\rfloor,\lceil n/2\rceil})$., p. 3.

**Nikiforov 2002** (from Motzkin–Straus): $K_{r+1}$-free with $m$ edges $\Rightarrow\lambda\le\sqrt{2m(1-1/r)}$, p. 3, eq. (4). **Wilf 1986**: $\lambda\le(1-1/r)n$, eq. (3).

**Theorem 1.2 (Nikiforov, 2007, spectral Turán).** *$G$ on $n$ vertices, $K_{r+1}$-free $\Rightarrow\lambda(G)\le\lambda(T_r(n))$, equality iff $G=T_r(n)$.*, p. 3.

Lin–Ning–Wu 2021 refine Theorem 1.1 for non-bipartite triangle-free graphs; this paper gives alternative proofs of both and extends to non-$r$-partite $K_{r+1}$-free graphs. Keywords name the method: **Zykov symmetrization**.

## The proof shapes that would transfer

- **Nosal's walk count**: $\lambda^2\le$ (number of length-2 walks weighted by the Perron vector) and triangle-freeness kills the closing term, leaving $m$. The transfer target: square the criticality identity and count bracket-walks; $S_{\mathfrak{mmm}}=0$ kills the $\mathfrak{mmm}$ triangle term in $\langle v,W^\#v\rangle=\tfrac12\sum_{a,b}\lambda_a\lambda_bc_{1ab}^2$.
- **Zykov symmetrization**: replace a vertex's neighbourhood by a copy of another's, monotone in the objective, preserving $K_{r+1}$-freeness, terminating at complete multipartite. The transfer target: a move on Weyl operators, defined from $W$'s own eigendata, monotone in $\theta$ on $\{S=0\}$, terminating at the balanced product. Exact at the extremum by construction, so post 34's no-lossy-step demand is met by the method's shape rather than fought.

## The standing obstruction the transfer must clear (this record's own)

Fence post 10: marginal relaxations of the bracket tensor $T_{abc}=c_{abc}^2$ cannot bound $P$, the LP over all recorded marginal constraints returns $1.6059$ against $\theta_0(6)=1.0541$. So a Nosal-type count that uses only marginals of $T$ will fail; the transfer must consume frame-realizability, which is exactly what the eigenbasis identity carries and the LP did not.
