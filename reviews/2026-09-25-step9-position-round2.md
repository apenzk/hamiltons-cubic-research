# Step 9 position, 2026-09-25, round 2: (c)'s asymmetric survivors

## The statement a route must reach

[I73](../plan.md)'s (c) at $n=12$: no three-value critical point of $P$ on $\mathcal W_{12}$ has $\theta>\theta_0(12)=\sqrt{220}/12\approx1.23603$. *The threshold is $\theta_0(n)$, not $\sqrt{3/2}$ ([trap W7](../findings/INDEX-traps.md): $S^5\times S^7$ is a three-value critical point at $1.228239$).*

## What the record has, and what it leaves

- **The class-level system** in $(e,m,\tau_{abc},G_{12})$: per-index rows, pair and Ky Fan caps, [L240](../findings/second-order.md)'s seven-frame cap, the Gram constraints, section 5, L235's window, [L243](../findings/second-order.md)'s Gaussian subspace cap for whole and partial classes. **Sound**: [S⁵×S⁷](../scripts/misc/control_S5S7_class_system.py) satisfies every constraint.
- **Not enough**: at $\theta=1.2361$, 190 of 2080 triples survive (a screen, five directions each); 11 symmetric ([R38](../routes.md)'s family), **179 asymmetric**. [L241](../findings/bounds-relaxations.md) and [L242](../findings/bounds-relaxations.md) are exact class points above $\theta_0(12)$; L242 is not realisable, L241's realisability is open.
- **Checked and inert** in class form: L31's common image at L241 (no pair cap tight); Bianchi's $\Lambda^4$ part (implied by row (B) and $\operatorname{Ric}(e)=0$); partial-class Gaussian caps up to frame size $30$.
- **So the ingredient must come from outside the class system**: data the class averages erase (per-index $T_{\alpha\beta\gamma}$, per-element spectra of $\Psi_\alpha$), or a property of an actual Weyl tensor that no averaged relation sees.

## What previous sweeps covered

[2026-09-23](2026-09-23-LIT-step9-sweep.md) and [round 2](2026-09-23-LIT-step9-sweep-round2.md): second-kind curvature operator, Schur–Horn, Kostant, calibrations, Tkachev's idempotents, Z-eigenvectors, Michel, Jordan algebras, symmetric criticality, designs, landscapes, hypergraph Lagrangians. [2026-09-24](2026-09-24-LIT-I73-sweep.md): approximate Clifford relations, DDVV constants, $k$-plane curvature sums. [2026-09-25](2026-09-25-LIT-step9-sweep.md): few-eigenvalue curvature operators, Jacobi realisability, isotropy moment maps.

## What this sweep is asked for

1. **Eigenvalue inequalities for the Lie-algebra square $R^\#$** in terms of $R$'s eigenvalues (Hamilton, Böhm–Wilking, Brendle–Schoen), and whether any sharpen at a critical point $W^2+W^\#=\theta W$.
2. **Critical points of cubic Weyl invariants** ($\int\operatorname{tr}W^3$, $\langle W,W^\#\rangle$) and their classification by spectrum.
3. **Structure-constant moment problems**: which squared-structure-constant arrays $c_{\alpha\beta\gamma}^2$ in an orthonormal basis of $\mathfrak{so}(n)$ are realisable, beyond class averages.
