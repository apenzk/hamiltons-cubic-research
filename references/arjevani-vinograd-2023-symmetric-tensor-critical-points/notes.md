# Notes, Arjevani–Vinograd, arXiv:2306.07886 (read pp. 1–6; Sections 4–5 skimmed)

## Setting

Decompose a symmetric 3-tensor: minimise $\mathcal L(W)=\|\sum_i\mathbf w_i^{\otimes3}-T\|^2$ over $d\times d$ matrices $W$, target $T=\sum_i\mathbf e_i^{\otimes3}$. The loss is invariant under $S_d\times S_d$ (rows permuted, columns permuted). Global minimisers = the permutation orbit of $I_d$ (Prop 1, via Kruskal identifiability).

## What transfers

1. **Symmetry-breaking families in closed form.** Saddles and minima with proper isotropy subgroups ($\Delta S_d$, $\Delta(S_{d-1}\times S_1)$, $\Delta(S_{d-2}\times S_2)$, …) are constructed as **Puiseux series in $d$**, one family, one formula, valid for every dimension. The record's padding and blow-up families (the $n=7$ point inside $n=8$, the $C_5$-edge family) are the same phenomenon and could be organised the same way.
2. **Hessian spectrum per isotype** (Tables 1–2). At each symmetric critical point the Hessian commutes with the isotropy group, the parameter space splits into isotypes ($\mathfrak t$, the standard rep $\mathfrak s_d$, $\mathfrak s_d\otimes\mathfrak s_d$, two others), and the spectrum is listed as one eigenvalue (plus multiplicity) per isotype. Distinct-eigenvalue count is **independent of $d$** because the isotypic multiplicities are. This is the finite-dimensional Schwahn method ([schwahn-2020-symmetric-space-stability](../schwahn-2020-symmetric-space-stability/)) applied to a cubic-loss landscape.
3. **Index grows with critical value** (their (2.3): $\mathcal L/d\approx\mathrm{Index}/d^2$): across all constructed families, higher loss $\Rightarrow$ more descent directions. The analogue for Conjecture A (higher $\theta$ above $\theta_0$ forces positive index unless the point is the target), is the conjecture's second-order form, and this paper shows the pattern provable family-by-family in a cubic landscape.
4. **Degenerate criticality handled by tangency arcs**: where the Hessian is singular ($\mathfrak C_0$, $\mathfrak C_5$) second-order analysis cannot decide, and they use the curve selection lemma on real-analytic descent curves. The record's constant-Rayleigh $C_5$-edge family (Rayleigh $\equiv2/3$, not an eigenspace) is a degenerate structure of this kind; CSL is the tool the record has never used on it.

## What does not transfer

The identifiability argument (Prop 1) is tensor-rank-specific; nothing in it sees the Weyl constraints. The specific isotype tables are for $S_d$-representations, ours are $H\subseteq\mathrm O(n)$-representations, the method carries, the tables do not.
