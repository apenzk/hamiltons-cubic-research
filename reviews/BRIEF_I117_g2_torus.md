# Gate 2 brief (two readers): positive-definite #-idempotents on g₂'s torus family

**This round checks an argument, so it has two readers working independently.** The product table, the stabiliser argument and the Weyl-invariant solve are prose, and the reflection-type solve is an exact machine computation. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: derive from definitions. Computation is allowed to check a value or refute a step, the smallest that does it: seconds, or a bounded exact solve stated in advance in your log. **The full six-variable system (409 complex solutions) is out of scope**: do not attempt its enumeration.

## The note under review, verbatim from [its file](2026-09-28l-I117-g2-torus.md)

# I117, R48 on $\mathfrak g_2$'s torus family

*Working note for [I117](../plan.md), route [R48](../routes.md) (U$_{\mathrm s}'$ on the torus family of every compact simple $\mathfrak h$), by the manager's decision of 2026-09-28k. $\mathfrak g_2$ is one of the families R48 lists as remaining ([R48 note](2026-09-27-R48-torus-families.md), Open). Nothing here is numbered.*

## What H asks of $\mathfrak g_2$

By [L270](../findings/second-order.md) (3), statement H at $n\ge9$ needs, of a stable positive-definite $\#$-idempotent $C$ on a simple $\mathfrak h\subseteq\mathfrak{so}(n)$, only $\lVert C\rVert^2\ge N/(n-2)^2$, which U$_{\mathrm s}'$'s $\lVert C\rVert^2\ge d/c^2$ implies through [L256](../findings/second-order.md). On $\mathfrak g_2$ (index one in $\mathfrak{so}(7)$), $d=14$ and $c=4$, so $d/c^2=\tfrac78$, against $N/(n-2)^2=\tfrac{36}{49}=0.735$ at $n=9$ and less above.

## The family

A maximal torus of $G_2$ has rank two. The operators on $\mathfrak g_2$ commuting with it are a symmetric $2\times2$ block on the Cartan $\mathfrak t$ and one scalar on each of the six positive root planes: **a nine-dimensional family, closed under $\#$ by equivariance.**

## Screen: its positive-definite idempotents (seconds, [g2 torus screen](../scripts/misc/screen_I117_g2_torus.py))

Least squares on $C^\#C=C$ over the family from $300$ positive starts near $I/c$, with $\mathfrak g_2$ built as the stabiliser of the 3-form in $\mathfrak{so}(7)$ and the record's $\#$ restricted to it ($c=4$ recovered). Stability is the top eigenvalue of $X\mapsto C^\#X$ on $C^\perp$ in all of $\mathop{\mathrm{Sym}}^2\mathfrak g_2$ ([L264](../findings/second-order.md) (1)).

| $\lVert C\rVert^2$ | top eigenvalue on $C^\perp$ | reading |
|---|---|---|
| $0.875=\tfrac78$ | $0.4167=\tfrac5{12}$ | $I/4$, stable |
| $0.887039=\tfrac{746}{841}$ | $0.566$ | [L263](../findings/second-order.md)'s $SO(4)\subset G_2$ idempotent, unstable |
| $0.895408=\tfrac{351}{392}$ | $0.5357=\tfrac{15}{28}$ | L263's $SU(3)\subset G_2$ idempotent, unstable |
| $0.895440$ | $0.5361$ | not on the record, unstable |

**On the screen, $I/4$ is the only stable member, and every member has $\lVert C\rVert^2\ge\tfrac78$**, so U$_{\mathrm s}$, and with it U$_{\mathrm s}'$, holds on the family as far as $300$ starts see. *A screen: a proof needs the family's solutions exactly.*

## The family's algebra, exactly (derived, the constants read off the construction)

Write $C=A+\sum_\alpha w_\alpha P_\alpha$ over the six positive root planes, $A$ on the Cartan, and fix $\mathfrak g_2$'s roots with $\lvert\alpha\rvert^2=2$ long and $\tfrac23$ short in the record's metric. Then $A^\#A=0$ (the Cartan is abelian), $A^\#P_\alpha=\tfrac12(\alpha^{\mathsf T}A\alpha)P_\alpha$, $P_\alpha^\#P_\alpha=\alpha\alpha^{\mathsf T}$ on the Cartan, and a mixed product $P_\alpha^\#P_\beta$ is $\tfrac12P_\gamma$ on each root $\gamma=\pm\alpha\pm\beta$, except that two short roots give $\tfrac23$ on the short one. So $C^\#C=C$ is $A=\sum_\alpha w_\alpha^2\alpha\alpha^{\mathsf T}$ together with, for each positive root $\gamma$, $$w_\gamma\Big(1-\sum_\alpha w_\alpha^2(\alpha\cdot\gamma)^2\Big)=\sum_{\{\alpha,\beta\}}2\,\mathrm{coef}^\gamma_{\alpha\beta}\,w_\alpha w_\beta ,$$ six cubic equations with rational coefficients ($(\alpha\cdot\gamma)^2\in\{4,1,0\}$ among long and mixed pairs, $\{\tfrac49,\tfrac19\}$ among short). $A$ is positive definite whenever the weights are nonzero, since the roots span the Cartan. **Positive-definite torus-invariant idempotents are the positive solutions $w\in\mathbb R_{>0}^6$.**

- **On the Weyl-invariant weights** (long $x$, short $y$) the system is $x(1-6x^2-2y^2)=x^2+y^2$ and $1-2x^2-\tfrac23y^2=2x+\tfrac43y$, whose positive solutions are exactly $(\tfrac14,\tfrac14)$, which is $I/4$, and $(\tfrac9{28},\tfrac3{28})$, which is L263's. *Solved exactly; the other two roots have $x=-\tfrac12$.*
- The $SO(4)$ idempotent and the fourth screened one break the Weyl symmetry, so the full list needs the six-variable system ([solve_I117_g2_torus.py](../scripts/misc/solve_I117_g2_torus.py)). **Its ideal is zero-dimensional with $409$ complex solutions counted with multiplicity** (Singular through Sage, $1.2$ s). Eliminating to one variable and isolating real roots did not finish in the bounded time ($20$ and $10$ minutes), so **the exact enumeration is a long run and waits**. *What it would decide: whether the four screened members are all the positive ones, which with their norms and stabilities settles U$_{\mathrm s}$ on this family.*
- **What an analytic route needs instead.** U$_{\mathrm s}'$ asks only that no member is lighter than $I/4$. With $y_L=\sum_{\text{long}}w^2$ and $y_S=\sum_{\text{short}}w^2$, $\lVert C\rVert^2=\lVert A\rVert^2+2(y_L+y_S)\ge\tfrac12(2y_L+\tfrac23y_S)^2+2(y_L+y_S)$, equality at $I/4$, so a lower bound on the root masses $y_L,y_S$ from the six equations would do, as [L270](../findings/second-order.md) (4) does on $\mathfrak{so}(2m)$'s torus with $\lVert C\rVert^2\ge4y^2/m+2y$.

## Exact on every symmetric type (derived and solved)

- **The stabiliser types.** $G_2$'s Weyl group acts on the six root planes through $S_3$, its longest element $-1$ fixing every plane, and it permutes the three long and the three short planes compatibly, each long root orthogonal to one short root. So a solution's stabiliser on the planes is $S_3$, a reflection (fixing one orthogonal long–short pair and swapping the other two pairs), or trivial; a three-cycle is transitive on each triple and forces the uniform weights.
- **$S_3$**: the Weyl-invariant section above, two positive solutions.
- **A reflection** ([solve_I117_g2_torus_reflection.sage](../scripts/misc/solve_I117_g2_torus_reflection.sage), seconds): with $x$ on the fixed long plane, $y$ on the fixed short one, $z$ and $u$ on the swapped pairs, the system is four cubics with $53$ complex solutions, $31$ real, and **exactly four positive ones**:

| $(x,z,u,y)$ | $\lVert C
Vert^2$ | identified |
|---|---|---|
| $(\tfrac14,\tfrac14,\tfrac14,\tfrac14)$ | $\tfrac78$ | $I/4$ |
| $(\tfrac9{28},\tfrac9{28},\tfrac3{28},\tfrac3{28})$ | $\tfrac{351}{392}$ | L263's $SU(3)$ |
| $(\tfrac{11}{29},\sqrt{\tfrac{77}{1682}},\sqrt{\tfrac{77}{1682}},\tfrac5{29})$ | $\tfrac{746}{841}$ | L263's $SO(4)$ |
| $(0.338753,0.311979,0.109157,0.105290)$, $x$ of degree $6$ | $0.895439$ | new, the screen's fourth |

- **So every positive-definite torus-invariant idempotent on $\mathfrak g_2$ with a nontrivial stabiliser is one of these four**, each with $\lVert C\rVert^2\ge\tfrac78$, equality only at $I/4$. **U$_{\mathrm s}'$ holds exactly on them.** The trivial-stabiliser type is empty on a $3300$-start screen of the six-weight system, and its exact exclusion is the full system's enumeration, which waits.
- *Stability* (the screen's top eigenvalues $\tfrac5{12}$, $0.566$, $\tfrac{15}{28}$, $0.536$) separates $I/4$ from the other three, which U$_{\mathrm s}'$ does not need.

## Lean, and what kind of result this is

**The layer carries $\mathfrak g_2$'s bracket**: `L263_blocks` in [L263Blocks.lean](../lean/HamiltonsCubic/Results/L263Blocks.lean) computes the $SU(3)\subset G_2$ blocks by kernel `decide` over the octonion table. **Untyped here**: the torus family's product table (the constants $\tfrac12$, $\tfrac23$, $\alpha\alpha^{\mathsf T}$ and $\tfrac12\alpha^{\mathsf T}A\alpha$ above) and the two exact solves. The Weyl-invariant solve is two equations by hand; the reflection-type solve is an exact algebraic computation (four cubics, degree-6 algebraic numbers), so that row is a machine result rather than a derivation. *The commit that added the symmetric-type section said the layer had no $\mathfrak g_2$ structure constants and called the whole a derivation; both are corrected here.*

## Givens, quoted from the record

- **Hamilton's sharp** in the record's normalisation: $(A^\#B)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}A_{\gamma\varepsilon}B_{\delta\zeta}$, $c$ the structure constants of $\mathfrak{so}(m)$ in the orthonormal basis $e_{ij}=E_{ij}-E_{ji}$ (inner product $\tfrac12\mathop{\mathrm{tr}}X^{\mathsf T}Y$), so $I^\#I=(m-2)I$. A $\#$-idempotent is $C^\#C=C$.
- **[L263](../findings/second-order.md)** (Gate 2 r1555, r1556): at $SU(3)\subset G_2$, $C=\tfrac9{28}P_{\mathfrak{su}(3)}+\tfrac3{28}P_{\mathfrak p}$ is a positive-definite idempotent on $\mathfrak g_2$ other than $I/4$, squared norm $\tfrac{351}{392}$; and at the symmetric pair $SO(4)\subset G_2$, $\tfrac{11}{29}P_L+\tfrac5{29}P_S+\sqrt{77/1682}\,P_{\mathfrak p}$, squared norm $\tfrac{746}{841}$.
- **[L264](../findings/second-order.md) (1)**: stability of an idempotent $C$ is $\langle C^\#H,H\rangle\le\tfrac12\lVert H\rVert^2$ for $H\perp C$ in $\mathop{\mathrm{Sym}}^2\mathfrak h$. **[L270](../findings/second-order.md) (3)**: U$_{\mathrm s}'$, every stable positive-definite idempotent on a compact simple $\mathfrak h$ has $\lVert C\rVert^2\ge d/c^2$.

## Items

1. **The family.** Is the commutant of a maximal torus of $G_2$ in $\mathop{\mathrm{Sym}}^2\mathfrak g_2$ exactly a symmetric $2\times2$ block on the Cartan plus one scalar per positive root plane (nine dimensions), and is it closed under $\#$?
2. **The product table.** Are $A^\#A=0$, $A^\#P_\alpha=\tfrac12(\alpha^{\mathsf T}A\alpha)P_\alpha$, $P_\alpha^\#P_\alpha=\alpha\alpha^{\mathsf T}$, and the mixed products ($\tfrac12$, and $\tfrac23$ for two short roots onto a short one) right, with $\lvert\alpha\rvert^2=2$ and $\tfrac23$ in the record's metric? Check from $\mathfrak g_2$'s structure constants, by hand or by your own construction.
3. **The system.** Does $C^\#C=C$ reduce to $A=\sum w_\alpha^2\alpha\alpha^{\mathsf T}$ and the six cubics, with positive definiteness exactly $w>0$?
4. **The stabiliser types.** Is the Weyl group's action on the six planes through $S_3$, compatibly on long and short with each long root orthogonal to one short, so that the stabiliser of a solution is $S_3$, a reflection or trivial?
5. **The two exact solves.** The Weyl-invariant positive solutions are exactly $I/4$ and $(\tfrac9{28},\tfrac3{28})$; the reflection-invariant ones are exactly the four in the table. Reproduce the second with your own exact solve (Sage is available as `sage`, with Singular), and check the identifications with L263 and the norms.
6. **Scope.** Does the note claim more than it shows, in particular about the trivial-stabiliser type (screened only) or about stability?

## Lean table

| claim | declaration |
|---|---|
| $\mathfrak g_2$'s bracket, the $SU(3)$ blocks | `L263_blocks` in [L263Blocks.lean](../lean/HamiltonsCubic/Results/L263Blocks.lean), on the record, not under review |
| the torus family and its product table | none: untyped, item 2 checks it |
| the two exact solves | none: the Weyl-invariant one by hand, the reflection one an exact machine solve, item 5 reproduces it |
