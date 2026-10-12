# Bachoc, Ehler, Tight p-fusion frames, transcribed

> **Definition 2.1.** Let $\{V_j\}_{j=1}^n\subset\mathcal G^d$ and let $\{\omega_j\}_{j=1}^n$ be a collection of positive weights. Then $\{(V_j,\omega_j)\}_{j=1}^n$ is called a fusion frame if there are positive constants $A$ and $B$ such that $A\lVert x\rVert^2\le\sum_{j=1}^n\omega_j\lVert P_{V_j}(x)\rVert^2\le B\lVert x\rVert^2$ for all $x\in\mathbb R^d$. If $A=B$, then $\{(V_j,\omega_j)\}_{j=1}^n$ is called a tight fusion frame.

*Section 2, p. 3. In case $A=B$ and all weights $1$, $\{V_j\}$ is simply a tight fusion frame; the subspaces are assumed nontrivial.*

**The remark that carries the mechanism** (Section 2, same page): *the standard inner product between self-adjoint operators is $\langle P,Q\rangle=\mathrm{trace}(PQ)$; if $x$ is on the unit sphere then $\lVert P_V(x)\rVert^2=\langle P_x,P_V\rangle$ with $P_x$ the projection onto the line $\mathbb Rx$, so the fusion frame condition is equivalent to $A\le\langle P_x,\sum_j\omega_jP_{V_j}\rangle\le B$.* **So the upper bound is attained exactly when $x$ is an eigenvector of the frame operator $\sum_j\omega_jP_{V_j}$ for its largest eigenvalue $B$.**

**What the record's object is in these terms.** The three pattern planes $\Pi_{Q_i}$ with weights $1$, $x=D/\sqrt t$, and the bound $\sum_iu_i^2\le\tfrac53t$ is the upper frame inequality with $B=\tfrac53$. *The paper's Section 3.1 recalls the simplex bound of Conway, Hardin and Sloane and Section 3.2 generalises it; the equality case for equidimensional subspaces is an equichordal tight fusion frame.*

**Cites**: Conway, Hardin, Sloane [16] for the simplex bound; Kutyniok, Pezeshki, Calderbank, Liu [34] for the loss-minimisation motivation.
