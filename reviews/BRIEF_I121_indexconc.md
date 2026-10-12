# Gate 2 brief (two readers): the $\Lambda^2$ loss of the $E$ route bounded by the index concentration of $W$

**This round checks an argument, so it has two readers working independently.** One step (the coordinate formula for the record's $\#$) exists only in prose. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: read, compare and derive from definitions; compute only to check a value or refute a step, the smallest computation that does it (seconds). No sweeps.

## The block under review, verbatim from [the working note](2026-09-28d-I121-smallmass-direct.md)

## The $\Lambda^2$ loss is the index concentration of $W$ (derived, Gate 2 owed)

*The $E$ route's first loss is $\theta p_3(\lambda)\le1$. Weighting [L198](../findings/bounds.md)'s rows instead of capping them bounds it by how concentrated $W$ is on few directions, a quantity the value controls.*

- **The rows, weighted.** L198's row $k$ reads $2\lambda_k(\theta-\lambda_k)=\sum_{\alpha,\gamma}c_{\alpha k\gamma}^2\lambda_\alpha\lambda_\gamma$. Multiplying by $\tfrac12\lambda_k^2$ and summing gives $\theta p_3(\lambda)=p_4(\lambda)+\tfrac12S$ with $S=\sum c^2_{k\alpha\gamma}\lambda_k^2\lambda_\alpha\lambda_\gamma$.
- **The two terms.** $p_4\le\max(\lambda_{\max}^2,\lambda_{\min}^2)\le1/\theta^2$, both extremes being below $1/\theta$ by L198's two displays. And since $c^2\ge0$ is symmetric in $\alpha,\gamma$, $\lambda_\alpha\lambda_\gamma\le\tfrac12(\lambda_\alpha^2+\lambda_\gamma^2)$ gives $\tfrac12S\le\tfrac12\sum_{k,\alpha}\lambda_k^2\lambda_\alpha^2\lVert[\varphi_k,\varphi_\alpha]\rVert^2=\operatorname{tr}(G^\#G)$ with $G=W^2\succeq0$.
- **The commutator mass is the index concentration.** In any frame, $(G^\#G)_{ij,ij}=\sum_{k\ne i,j}(G_{ik,ik}G_{jk,jk}-G_{ik,jk}^2)\le\sum_kR_{ik}R_{jk}$ with $R_{ik}=\lVert Me_{ik}\rVert^2$, so $\operatorname{tr}(G^\#G)\le\tfrac12\sum_kr_k^2$, where $r_k=\sum_iR_{ik}=\tfrac12N_{kk}$ and $N_{ik}=\sum_{m,p,q}W_{impq}W_{kmpq}$ is [target.md](../findings/target.md)'s positive-semidefinite contraction, of trace $4$ at unit norm. Hence $\operatorname{tr}(G^\#G)\le\tfrac18\lVert N\rVert_F^2$.
- **So at every unit critical point,** with $E\le C_n t_{\max}$ from the section above, $$\theta^2\ \le\ \frac3{2\theta^2}+\frac3{16}\lVert N\rVert_F^2+\theta\,C_n\,t_{\max},\qquad C_n=\tfrac32\sqrt{\tfrac{2(n-2)}{n-1}} .$$ It sharpens $\theta^2\le\tfrac32+\theta E$ whenever $\lVert N\rVert_F^2<8(1-\theta^{-2})$. $\lVert N\rVert_F^2\ge\tfrac{16}n$ always, with equality exactly when $N$ is isotropic, which holds at every $\mathbb{CP}^m$, every balanced product and every Weyl tensor at $n=4$.
- **Screened** ([screen_I121_index_concentration.py](../scripts/misc/screen_I121_index_concentration.py), seconds): at $S^3\times S^3$, $\mathbb{CP}^3$, $\mathbb{CP}^4$ and random Weyl tensors at $n=6,8$, $\tfrac12S\le\operatorname{tr}(G^\#G)\le\tfrac12\sum r_k^2\le\tfrac18\lVert N\rVert_F^2$ in every case, and $\theta p_3-p_4=\tfrac12S$ is $0.033$ at the product and $0.050$ to $0.057$ at $\mathbb{CP}^3$, $\mathbb{CP}^4$.
- **What it gives at isotropic $N$** (the index-spread tensors, $\lVert N\rVert_F^2=\tfrac{16}n$): a critical point at $\theta\ge\theta_0$ has

| $n$ | $14$ | $20$ | $30$ | $60$ | $100$ |
|---|---|---|---|---|---|
| $t_{\max}^2\ge$ | $0.029$ | $0.064$ | $0.097$ | $0.134$ | $0.150$ |
| $\mathbb{CP}^m$'s $\tfrac3{n+2}$ | $0.188$ | $0.136$ | $0.094$ | $0.048$ | $0.029$ |

  against $0.0013$ and $0.022$ at $n=14$ and $100$ from $\theta p_3\le1$. **From $n=30$ the band below the $\mathbb{CP}^m$ scale is empty for index-spread tensors.** *So the band splits by $\lVert N\rVert_F$: spread tensors are cleared up to a threshold rising to about $0.17$ in $t_{\max}^2$, and what remains is a critical point concentrated on few directions, a new node.*

## Givens, quoted from the record

- **L198** ([bounds.md](../findings/bounds.md), Gate 2 r840, r841): **Statement.** *At every critical point of unit norm,* $$\lvert\lambda_k(\theta-\lambda_k)\rvert\le1-\lambda_k^2\ \text{ at every }k,\qquad\text{hence}\qquad \boxed{\ \theta\,\lambda_{\max}\le1\ }\quad\text{and}\quad\theta\le\frac1{\lvert\lambda_{\min}\rvert}-2\lvert\lambda_{\min}\rvert .$$

**Proof.** *Read (C) at a fixed $k$ as a quadratic form $\lambda^{\mathsf T}T^{(k)}\lambda=2\lambda_k(\theta-\lambda_k)$ at $T^{(k)}_{\alpha\gamma}=T_{\alpha k\gamma}$.* **$T$ IS HOLLOW**: the structure constant is totally antisymmetric, so $T$ vanishes whenever two of its three indices agree, and $T^{(k)}$ therefore has zero row $k$, zero column $k$ and zero diagonal ([StructureSquare.lean](../lean/HamiltonsCubic/Base/StructureSquare.lean)). *So the form sees $\lambda$ only off index $k$, of square norm $1-\lambda_k^2$, and the pair cap $\sum_\gamma T_{\alpha k\gamma}\le2$ bounds it by $2(1-\lambda_k^2)$.* **At $k$ the top index this is $\theta\lambda_{\max}\le1$; at $k$ the bottom index the sign runs the other way and gives the second display.** $\square$
- **The sharp** (the record's normalisation): $I^\#I=(n-2)I$, $\langle W^\#,W\rangle=\tfrac12\sum\lambda_k\lambda_l\lambda_mc_{klm}^2$ over an orthonormal eigenbasis $\varphi_k$ of $M$ on $\Lambda^2$, with $c_{klm}=\langle[\varphi_k,\varphi_l],\varphi_m\rangle$ totally antisymmetric, and at a diagonal operator $(D^\#D)_{ij,ij}=\sum_ka_{ik}a_{jk}$.
- **$E\le C_nt_{\max}$**, $C_n=\tfrac32\sqrt{2(n-2)/(n-1)}$, at every unit Weyl tensor, $E=P-\tfrac32\operatorname{tr}M^3$ (Gate 2 r1861, r1865, in Lean as `E_le_tmax_sharp`), and $\theta=\tfrac32p_3(\lambda)+E$ at a unit critical point (L50).
- **$N$** ([target.md](../findings/target.md)): $N_{ik}=\sum_{m,p,q}W_{impq}W_{kmpq}\succeq0$, $\operatorname{tr}N=\lvert W\rvert^2=4$ at unit $\Lambda^2$ norm, and $N=I$ at $n=4$ for every Weyl tensor (the classical identity).

## Items

1. **The weighted rows.** Does $\theta p_3=p_4+\tfrac12S$ follow from L198's row identity as quoted, with $S$ as defined?
2. **$p_4\le1/\theta^2$.** Do L198's two displays give $\lambda_{\max}\le1/\theta$ and $\lvert\lambda_{\min}\rvert\le1/\theta$ at every unit critical point with $\theta>0$?
3. **The sign drop.** Is $\tfrac12S\le\operatorname{tr}(G^\#G)$ with $G=W^2$, in the record's normalisation of $\#$ and of the bracket norm $\lVert[\varphi_k,\varphi_\alpha]\rVert^2=\sum_\gamma c_{k\alpha\gamma}^2$?
4. **The coordinate formula and the index bound.** Is $(G^\#G)_{ij,ij}=\sum_{k\ne i,j}(G_{ik,ik}G_{jk,jk}-G_{ik,jk}^2)$ for a symmetric $G$ in the record's normalisation (check it against $I^\#I=(n-2)I$ and the diagonal case), and do $\operatorname{tr}(G^\#G)\le\tfrac12\sum_kr_k^2\le\tfrac18\lVert N\rVert_F^2$ follow, with $r_k=\tfrac12N_{kk}$? Mind the ordered-versus-unordered pair conventions in $R_{ik}=\lVert Me_{ik}\rVert^2$ and in the trace over $i<j$.
5. **The combined inequality and its table.** Does the display follow from 1 to 4 and the givens? Check the table's thresholds (isotropic $N$, $\lVert N\rVert_F^2=16/n$) with one line of Python, and whether "$N$ is isotropic at every $\mathbb{CP}^m$ and balanced product" holds.
6. **Scope.** Is "from $n=30$ the band below the $\mathbb{CP}^m$ scale is empty for index-spread tensors" stated at the strength the argument gives (exactly isotropic $N$), and is the split by $\lVert N\rVert_F$ described correctly?
7. **Classification.** Grep the record (findings/, reviews/, results.md) for this chain, in particular any bound on $\theta p_3$ by $p_4$, on $\operatorname{tr}((W^2)^\#W^2)$, or on $\lVert N\rVert_F$. Is it already there under another name?

## Lean table

| claim | declaration |
|---|---|
| L198's rows weighted by $\lambda_k^2$ | none: L198's row identity is partial in Lean ([lean/INDEX.md](../lean/INDEX.md) row "L198 (statement)"), item 1 checks the step by hand |
| $p_4\le m^2p_2$ when $\lvert\lambda_k\rvert\le m$ | `p4_le` |
| the sign drop | `weighted_sign_drop` |
| the coordinate formula for $G^\#G$ | none: the record's $\#$ in coordinates is untyped here, item 4 |
| the index step | `rowsum_sq_le` |
| the combined inequality | `theta_sq_le` |

File: `lean/HamiltonsCubic/Results/IndexConcentration.lean` (to be committed with the block). Screen: `scripts/misc/screen_I121_index_concentration.py`.
