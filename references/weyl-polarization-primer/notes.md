# Polarization and restitution, Darondeau, Florence, Kolev

**L. Darondeau, M. Florence, B. Kolev, *Weyl's Polarization in Classical Invariant Theory: A Primer, with Worked Examples*, [arXiv:2606.24023](https://arxiv.org/abs/2606.24023)** (23 June 2026). A reading of Weyl's *The Classical Groups* alongside Kraft–Procesi and Olver, worked concretely over $\mathbb{R}$ for $GL(n)$, $SL(n)$, $O(n)$, $SO(n)$.

Found while searching for what governs **restriction of invariants to the diagonal**, the operation the record calls the degree-3 diagonal $W\mapsto W\otimes W\otimes W$. The classical name for it is **restitution**, and it has been understood since Weyl.

## The two theorems this programme needs

> **Theorem I.2.1 (complete polarization).** Every homogeneous $f\in\mathbb{R}[V]$ of degree $d$ is *uniquely* associated to a symmetric multilinear form $\mathcal{P}_d(f)\in\mathrm{Sym}^d(V^*)$, and $f$ is recovered by evaluating on the diagonal: $f(v)=\mathcal{P}_d(f)(v,\dots,v)$.

> **Remark I.2.2 (restitution, and what its kernel is).** For multilinear $F:V^d\to\mathbb{R}$, evaluation on the diagonal $\mathcal{R}_d(F)$ is homogeneous of degree $d$. Then $\mathcal{P}_d(\mathcal{R}_d(F))$ **agrees with $F$ if and only if $F$ is already symmetric**, so $\mathcal{P}_d\circ\mathcal{R}_d$ is a **projection onto the symmetric multilinear forms**.

> **Remark I.2.4.** Because the group acts *diagonally* on $V^d$, both $\mathcal{P}_d$ and $\mathcal{R}_d$ and the projector $\mathcal{P}_d\circ\mathcal{R}_d$ **commute with the $G$-action**. So all of this is available equivariantly, block by block.

Theorem I.2.7 extends it to several representations and multi-degrees, with the same conclusion on the multi-diagonal.

## What it does NOT say about obligation (i)

*This section first claimed the theorems above settled the record's rank-2 collapse. r265 and r266 refute that independently; the citations above are verbatim, the inference from them was not.*

**The map the record measured is a composite**, and Remark I.2.2 governs only half of it:

$$V^{\otimes12}\ \xrightarrow{\ \text{restrict domain}\ }\ \mathrm{Weyl}_n^{\otimes3}\ \xrightarrow{\ \mathcal{R}_3\ }\ \text{degree-3 functions of }W.$$

Restitution is the **second** arrow, and on it nothing symmetric is lost, which is true and **vacuous** here. On **three independent** Weyl slots the invariant multilinear forms already have dimension $2$ at $n=6$ and $n=7$, the same $2$ as on the diagonal. So the non-symmetric complement is **$0$-dimensional** and Remark I.2.2 accounts for **$0$ of the $10{,}393$**.

**The whole collapse is the first arrow**, the passage from $V^{\otimes4}$ to the Weyl subspace, with its antisymmetries, pair symmetry, first Bianchi identity and tracelessness. **A Weyl tensor is not a generic element of $V^{\otimes4}$**, and no polarization statement crosses that gap.

*The symmetrised reformulation this note first proposed is decidable and false: the $\gamma_D$ are a basis permuted by $S_3$, so the symmetrised span is an orbit count of $1{,}779$, restricting to rank $2$.*

**What the source is still good for:** it names the operation, gives the equivariance in Remark I.2.4, and settles the second arrow completely. That is worth having filed; it is not a route to obligation (i).
