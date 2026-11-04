# Gate 2 brief (two readers): positive sharp-eigenoperators on g₂ that are not scalar, and the second-order reduction of I122's maximality form

**This round checks an argument, so it has two readers working independently.** The two-weight algebra is typed in Lean. The Lie-theoretic inputs, the counterexample's construction and the second-order reduction exist only in prose and in one screen. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: read, compare and derive from definitions. Computation is allowed to check a value or refute a step, the smallest that does it: seconds, or a bounded construction stated in advance in your log. No sweeps, no censuses, no open-ended hunts for further solutions.

## The context, verbatim from [the working note](2026-09-28j-I122-step4.md)

## The statement and what it was for

The [audit note](2026-09-28-I121-MG-audit.md)'s steps 1 to 3 (Gate 2 [r1818](REVIEW_r1818.md), [r1819](REVIEW_r1819.md)) put the maximiser of $T(G)=\langle G^\#,G\rangle$ over positive unit $G$ on $\mathfrak{so}(m)$ at a positive $G$ with $G^\#=\lambda G$ and full range on one simple subalgebra $\mathfrak h$. **Step 4 as stated**: such a $G$ is scalar. With it, the Lie table gives $\sup T=\max\{\tfrac2{\sqrt3},\tfrac{m-2}{\sqrt{\binom m2}}\}$.

## The block under review, verbatim from the same note

## Step 4 is false: $\mathfrak g_2\supset\mathfrak{su}(3)$ (derived, checked)

- **Two weights on an isotropy-irreducible pair.** For a simple $\mathfrak k\subset\mathfrak h$ with $\mathfrak m=\mathfrak k^\perp$ irreducible under $\mathfrak k$, and $G=aP_{\mathfrak k}+bP_{\mathfrak m}$, the rows are constant on each part by Schur. Put $\kappa$ for $\mathfrak k$'s Casimir on itself in $\mathfrak h$'s metric, so $\kappa/C=h^\vee_{\mathfrak k}/(j\,h^\vee_{\mathfrak h})$, $j$ the Dynkin index. Counting triples with one index in $\mathfrak k$ and two in $\mathfrak m$ gives $c_1=2d_{\mathfrak k}(C-\kappa)/d_{\mathfrak m}$ for the mixed pairs landing in $\mathfrak m$ and $c_2=C-c_1$ for $[\mathfrak m,\mathfrak m]_{\mathfrak m}$. The $\mathfrak m$ row fixes $2\lambda=ac_1+bc_2$, and the $\mathfrak k$ row then reads, in $r=b/a$, $$(C-\kappa)r^2-c_2r+(\kappa-c_1)=0,$$ with the scalar root $r=1$ and a second root $r_2=\frac{\kappa-c_1}{C-\kappa}$. **So a positive non-scalar solution exists exactly when $\frac\kappa C>\frac{2d_{\mathfrak k}}{d_{\mathfrak h}+d_{\mathfrak k}}$.** A symmetric pair has $c_2=0$ and $r_2=-1$.
- **The boundary and a crossing.** $\mathfrak g_2\subset\mathfrak{so}(7)$ has $\kappa/C=\tfrac45=\tfrac{2\cdot14}{21+14}$ exactly, so $r_2=0$ (the $\mathfrak g_2$-supported solution). **$\mathfrak{su}(3)\subset\mathfrak g_2$ (long roots, $j=1$) has $\kappa/C=\tfrac34>\tfrac{16}{22}$**, $c_1=\tfrac23C$, $c_2=\tfrac13C$, and $r_2=\tfrac13$: **$G=P_{\mathfrak{su}(3)}+\tfrac13P_{\mathfrak m}$ is a positive definite, non-scalar sharp-eigenoperator on the simple algebra $\mathfrak g_2$**, $\lambda=\tfrac{28}9$ in the record's units ($I^\#I=5I$ on $\mathfrak{so}(7)$).
- **Checked by construction** ([screen_I122_g2_su3.py](../scripts/misc/screen_I122_g2_su3.py), seconds): $\mathfrak g_2$ as the stabiliser of the 3-form in $\mathfrak{so}(7)$ (dimension $14$), $\mathfrak{su}(3)$ as the stabiliser of $e_7$ in it (dimension $8$), and the record's $\#$ from $\mathfrak{so}(7)$'s structure constants. The residual $\lVert G^\#G-\lambda G\rVert$ is $5\times10^{-15}$ at $r=\tfrac13$ and $9\times10^{-15}$ at $r=1$, against $0.05$ to $1.3$ elsewhere on the family.
- **Its value is below the scalar's**: $\langle G^\#,G\rangle/\lVert G\rVert^3=1.0568$ at $r=\tfrac13$ against $1.0690=\tfrac4{\sqrt{14}}$ at $r=1$, the table's $\mathfrak g_2$ value. On the screen's grid along the family, $r=\tfrac13$ is a local minimum of $T$ and $r=1$ a local maximum.
- **Families where the scalar is the only solution**, by hand: a symmetric pair with two weights, $\mathfrak u(2)\subset\mathfrak{su}(3)$ with three weights ($\mathfrak{su}(2)$, $\mathfrak u(1)$, $\mathbb C^2$), and $\mathfrak{su}(3)$ with weights constant on the Cartan and on each root plane.
- **A screen of the full critical set is uninformative** ([screen_I122_step4_falsifier.py](../scripts/misc/screen_I122_step4_falsifier.py)): least squares on $\mathfrak{so}(5)$ to $\mathfrak{so}(7)$, in $G=hh^{\mathsf T}$ and in $G=e^S$ with the residual scaled by $1/\lambda$, converges only to rank-deficient solutions, several at the scalar values of proper subalgebras ($\lambda=\tfrac1{\sqrt3}$, $\tfrac2{\sqrt6}$, $\tfrac3{\sqrt{10}}$, and $\tfrac1{5\sqrt3}$ at the principal $\mathfrak{so}(3)\subset\mathfrak{so}(5)$), and never to the scalar itself, so it cannot see full-range saddles.

## What I122 now needs

**The maximality form of step 4**: on a simple $\mathfrak h$, no positive full-range $G$ has $T(G)$ above the largest value the table gives for $\mathfrak h$ and its simple subalgebras. The $\mathfrak g_2$ solution satisfies it. *A proof must use maximality, second order or global, since the critical equation admits non-scalar full-range solutions.* R55's abandon condition fired as written. I122's conjectured supremum stands.

**It reduces to one inequality, through the second-order condition.** At a maximiser of $T$ on the unit sphere with full range on $\mathfrak h$, the Hessian gives $\langle G^\#X,X\rangle\le\tfrac\lambda2\lVert X\rVert^2$ for $X\perp G$. Along $X=I_{\mathfrak h}-tG$, $t=\mathop{\mathrm{tr}}G$, with $\mathop{\mathrm{tr}}(G^\#I)=\tfrac12Ct$ and $\langle G^\#I,G\rangle=\lambda t$, this reads $$\lambda\ \ge\ \frac{Ct}{N+t^2},\qquad N=\dim\mathfrak h,$$ with equality at the scalar $G=I/\sqrt N$. **So step 4's maximality form follows from the reverse inequality $\lambda(N+t^2)\le Ct$ at every full-range positive sharp-eigenoperator, with equality only at the scalar.** The $\mathfrak g_2$ saddle satisfies it strictly ($C=\kappa_{\mathfrak g_2}=8$ in the record's units, $t=3.397$, $1.0568<1.064$), so the second-order test along $I$ rejects it. *Unproved.* **Screened on the abstract two-weight family** (a grid over $d_{\mathfrak k},d_{\mathfrak m}<200$ and $\kappa/C$, realisable or not): it holds at every point with $0<r_2<1$, about $3.75$ million of them, and fails at points with $r_2>1$, which need $\kappa/C>\tfrac12+\tfrac{d_{\mathfrak k}}{2\dim\mathfrak h}$. *So a proof, or a counterexample, turns on whether a full-range solution can weight $\mathfrak m$ above $\mathfrak k$.*

## Givens, quoted from the record

- **Hamilton's sharp in the record's normalisation** ([conventions.md](../findings/conventions.md), the audit note's convention line): $(A^\#B)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}A_{\gamma\varepsilon}B_{\delta\zeta}$ with $c$ the structure constants of $\mathfrak{so}(m)$ in the orthonormal basis $e_{ij}=E_{ij}-E_{ji}$ (norm $\tfrac12\mathop{\mathrm{tr}}X^{\mathsf T}Y$), so $I^\#I=(m-2)I$ and every nonzero $c$ is $\pm1$.
- **Steps 1 to 3 of I122** (Gate 2 [r1818](REVIEW_r1818.md), [r1819](REVIEW_r1819.md)): a maximiser of $T(G)=\langle G^\#,G\rangle$ over positive unit $G$ on $\mathfrak{so}(m)$ satisfies $G^\#=\lambda G$, its range is a semisimple subalgebra, and the supremum is attained on one simple subalgebra $\mathfrak h$. The table: $\mathfrak g_2$ on $\mathbb R^7$ gives $\tfrac4{\sqrt{14}}=1.069$.
- **Dynkin index and dual Coxeter numbers**: $h^\vee(\mathfrak{su}(3))=3$, $h^\vee(\mathfrak g_2)=4$, $h^\vee(\mathfrak{so}(7))=5$, and the long-root $\mathfrak{su}(3)\subset\mathfrak g_2$ and $\mathfrak g_2\subset\mathfrak{so}(7)$ both have index $1$.

## Items

1. **The two-weight rows.** For a simple $\mathfrak k\subset\mathfrak h$ with $\mathfrak m=\mathfrak k^\perp$ irreducible under $\mathfrak k$: are the rows constant on each part, is $\kappa/C=h^\vee_{\mathfrak k}/(j\,h^\vee_{\mathfrak h})$ in $\mathfrak h$'s metric, is $c_1=2d_{\mathfrak k}(C-\kappa)/d_{\mathfrak m}$, and does the $\mathfrak k$ row reduce to the stated quadratic with roots $1$ and $r_2$? Is the existence criterion right, and $r_2=-1$ at a symmetric pair?
2. **The $\mathfrak g_2$ example.** Do $\kappa/C=\tfrac34$, $c_1=\tfrac23C$, $r_2=\tfrac13$ and $\lambda=\tfrac{28}9$ hold? Is $\mathfrak m$ irreducible under $\mathfrak{su}(3)$ as a real representation, and do the rows stay constant on it (it is of complex type)? Reproduce $G^\#G=\lambda G$ at $r=\tfrac13$ from your own construction of $\mathfrak g_2\subset\mathfrak{so}(7)$.
3. **Its value.** Is $\langle G^\#,G\rangle/\lVert G\rVert^3=1.0568$ at $r=\tfrac13$ against $1.0690$ at $r=1$, and is the latter the table's $\mathfrak g_2$ value?
4. **The boundary case and the families.** Is $\mathfrak g_2\subset\mathfrak{so}(7)$ exactly on the criterion's boundary? Check at least one of the three families claimed to force the scalar.
5. **The second-order reduction.** At a maximiser with full range on $\mathfrak h$, is $X=I_{\mathfrak h}-tG$ an admissible direction, are $\mathop{\mathrm{tr}}(G^\#I)=\tfrac12Ct$ and $\langle G^\#I,G\rangle=\lambda t$ right, and does $\lambda\ge Ct/(N+t^2)$ follow, with equality at the scalar? Does the $\mathfrak g_2$ saddle fail it with the stated numbers ($C=\kappa_{\mathfrak g_2}$ being the right constant on $\mathfrak h=\mathfrak g_2$)?
6. **Scope.** Does the block claim anything its evidence does not give, in particular about the screen of the full critical set, the abstract two-weight screen of the reduced inequality, or the reduced inequality itself, which it calls unproved?

## Lean table

| claim | declaration |
|---|---|
| the two-weight rows force $b=a$ or $b(C-\kappa)=a(\kappa-c_1)$ | `two_weight_roots` |
| at $\kappa=\tfrac34C$, $c_1=\tfrac23C$, $b=a/3$ solves the rows and is the second root | `g2_su3_root` |
| Schur constancy, $\kappa/C=h^\vee_{\mathfrak k}/(jh^\vee_{\mathfrak h})$, the triple count for $c_1$ | none: the layer carries no Lie-algebra classification data, item 1 checks them by hand |
| the construction of $\mathfrak g_2$ and the exact solution | none: a numerical construction, item 2 reproduces it |
| the second-order reduction $\lambda\ge Ct/(N+t^2)$ | none: stated on positive operators on an abstract simple $\mathfrak h$, which the layer does not model, item 5 checks it |

File: [I122TwoWeight.lean](../lean/HamiltonsCubic/Results/I122TwoWeight.lean). Screen: [screen_I122_g2_su3.py](../scripts/misc/screen_I122_g2_su3.py) (build your own objects rather than importing it).
