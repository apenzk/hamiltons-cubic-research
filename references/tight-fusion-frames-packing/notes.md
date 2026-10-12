# Notes on tight fusion frames, the simplex bound and the equi-isoclinic refinement

## Casazza–Fickus, arXiv:1708.08879, the statements transcribed

**Definitions, section 2.** For $M$ subspaces $\{U_j\}$ of dimension $c$ in a $d$-dimensional Hilbert space over $\mathbb R$ or $\mathbb C$, $\Phi_j$ is the $d\times c$ synthesis operator of an orthonormal basis of $U_j$ and $P_j=\Phi_j\Phi_j^*$ the orthogonal projection. The family is a **tight fusion frame** when $\sum_jP_j=\alpha I$ for some $\alpha>0$; taking traces gives $\alpha d=Mc$, so $\alpha=\frac{Mc}d$ necessarily.

**Theorem 5.1, the simplex bound.**
$$\max_{j\ne j'}\lVert\Phi_j^*\Phi_{j'}\rVert^2_{\mathrm{Fro}}\;\ge\;\frac{c(Mc-d)}{d(M-1)},$$
with equality if and only if $\{U_j\}$ is an **equi-chordal tight fusion frame**, namely both (i) $\sum_jP_j=\alpha I$ and (ii) the Frobenius norms of the off-diagonal cross-Gramians are all equal.

**The equi-isoclinic refinement.** $\{U_j\}$ is **equi-isoclinic** when there is $\sigma^2\ge0$ with $\Phi_{j'}^*\Phi_j\Phi_j^*\Phi_{j'}=\sigma^2I$ for all $j\ne j'$, equivalently $P_{j'}P_jP_{j'}=\sigma^2P_{j'}$. Such a family is necessarily equi-chordal, and then $\alpha=\frac{Mc}d$ and $\sigma^2=\frac{Mc-d}{d(M-1)}$.

> **THE ADDENDUM ABOVE OVERSTATES THE SOURCE, AND [r889](../../reviews/REVIEW_r889.md) caught it.** *Equi-isoclinity does force equi-chordality, but $\alpha=\frac{Mc}d$ and $\sigma^2=\frac{Mc-d}{d(M-1)}$ additionally need TIGHTNESS, which Theorem 5.2 lists separately.* **Witness: three coplanar lines at $60^\circ$ in $\mathbb R^3$ are equi-isoclinic at $\sigma^2=\tfrac14$ while the formula would predict $0$**, the family not being tight. *The icosahedral configuration supplies its own tightness, so the check that used these formulas there stands.*

**At $c=1$** both notions collapse to equiangular tight frames, since the induced $2$-norm and the Frobenius norm agree on a $1\times1$ matrix. **Provenance**: the $c>1$ simplex bound is Conway, Hardin and Sloane, resting on Rankin's optimal sphere packings; the authors also cite Dhillon, Heath, Strohmer and Tropp, and Kutyniok, Pezeshki, Calderbank and Liu.

## What it means in this record's notation

$\lVert\Phi_j^*\Phi_{j'}\rVert^2_{\mathrm{Fro}}=\operatorname{tr}(P_jP_{j'})$, which for eigenplanes is the bridge quantity $S_{\alpha\beta}=\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\lVert[\omega_\alpha,\omega_\beta]\rVert^2$. So with $c=2$ and $d=n$ the bound is
$$\max_{\alpha\ne\beta}S_{\alpha\beta}\;\ge\;\frac{2(2M-n)}{n(M-1)} .$$
**And the record's per-index relation $\sum_{\beta\ne\alpha}S_{\alpha\beta}=2(\kappa-1)$, with $\kappa=2M/n$ at a tight frame, has mean $\frac{2(2M/n-1)}{M-1}=\frac{2(2M-n)}{n(M-1)}$ over the $M-1$ partners.** *Identical, so the simplex bound is that relation read as max at least mean, and the equality case is isotropy.*

## Kutyniok, Pezeshki, Calderbank and Liu, arXiv:0709.2340

Read for the same bound in its original packing setting: chordal distance, fusion frames and Grassmannian packings, with the simplex bound appearing nine times and the isoclinic notion three. **Nothing in it is consumed by this record beyond the bound already transcribed above**, and its dimension-reduction application needs a probabilistic model this problem does not have.
