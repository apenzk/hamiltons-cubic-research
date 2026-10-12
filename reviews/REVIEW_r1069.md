# Review r1069: the codimension-one claim at $f<1$, in [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md)

Log: [agent_logs/r1069-codim.log](../agent_logs/r1069-codim.log). Brief: break M1 to M5, with M4 the target. Analysis-only footing, and every number below is a screen on objects already in hand, seconds of arithmetic, reported as a screen.

| Claim | Verdict |
|---|---|
| M1, the surviving set in $(s,f)$ | CONFIRMED |
| M2, both ends pinch $f$ to $1$ by different mechanisms | CONFIRMED |
| M3, $\beta\le6.3125^\circ$ | PLAUSIBLE, the value and the maximiser corrected |
| M4, the shape is unconstrained and the forcing is codimension one | **REFUTED** |
| M5, what remains is the full cyclic vector system | CONFIRMED, and it understates what two of those equations already give |

## M4 is REFUTED: the norm equation's LEFT side carries the shape, and pins it

**The claim reads the block equation's norm as a scalar band in $u$. It is an equality whose left side is a function of the OTHER two blocks' directions.** Writing $\nu_a$ at angle $\eta_a$ in its Bianchi plane on the basis $\big(\tfrac1{\sqrt6}(2,-1,-1),\tfrac1{\sqrt2}(0,1,-1)\big)$, with slot one the shared channel, the norm of $(\theta-2L_{q_a})\nu_a=2\nu_b\circ\nu_c$ reads

$$4\lVert\nu_b\circ\nu_c\rVert^2=N\,g,\qquad g=\theta^2+3u^2-2\sqrt3\,\theta\,u_{\mathrm{lo}}(f),$$

so with $h_a:=\lVert\nu_b\circ\nu_c\rVert\big/\tfrac12\sqrt{N_bN_c}$ the equality is $h_a=\sqrt{g/N}$. **The file's own band came from replacing the left side by its bound $N_bN_c$, which is $h_a\le1$.** *That replacement is where M4's freedom comes from, and it is a relaxation of an equation, not the equation.*

**A lemma, derived here, that makes the left side a constraint on $\nu_b$ alone.** In the bilinear formula's coordinates the map $\nu_c\mapsto2\nu_b\circ\nu_c$ is $M$ with $M=\operatorname{diag}(a_1)\oplus\begin{pmatrix}b_1&c_1\\c_1&b_1\end{pmatrix}$, so $M^{\mathsf T}M$ has eigenvector $(1,0,0)$ at $a_1^2$, $(0,1,1)$ at $(b_1+c_1)^2=a_1^2$ by Bianchi, and $(0,1,-1)$ at $(b_1-c_1)^2$. The Bianchi plane $\mathbf1^\perp$ is spanned by $(2,-1,-1)=2(1,0,0)-(0,1,1)$ and $(0,1,-1)$, so it is invariant and

$$\max_{\nu_c}h=\max\Big(\lvert\sin\eta_b\rvert,\ \tfrac1{\sqrt3}\lvert\cos\eta_b\rvert\Big).$$

*Screened against a direct maximisation over the partner circle at nine values of $\eta_b$, agreeing to eight places.*

**Consequence 1, the $+$ branch is EXCLUDED across the whole surviving set.** On the band $g\ge f^2N$, so $h_a\ge f$, and $\min_sf_{\min}(s)=0.891861$, comfortably above $\tfrac1{\sqrt3}=0.577350$. So $\lvert\sin\eta_a\rvert\ge f$ for every block, which is $\lvert\eta_a-\tfrac\pi2\rvert\le\arccos f$. *At $\eta_a=0$ the largest $h$ any partner can supply is $\tfrac1{\sqrt3}$, so a block near the $+$ branch cannot satisfy its own block equation at any $f$ on the surviving set.* **[I110](../plan.md)'s branch conclusion therefore persists off $f=1$, which M4 says nothing can establish.**

**Consequence 2, a PERTURBATION BOUND in exactly the quantity M4 declares free.** [L121](../findings/second-order.md) gives $L_{q_a}=\tfrac12G$ with $A=2x$, $B=2y$, $C=2z$ ([L220](../findings/second-order.md) step 5), so on $\mathbf1^\perp$ the eigenframe turns at half the rate of the shape: with $q_a$'s unit shape $\tfrac1{\sqrt3}\big(\cos\psi_a,\cos(\psi_a-\tfrac{2\pi}3),\cos(\psi_a+\tfrac{2\pi}3)\big)$, the top eigenvector sits at angle $\gamma_a=-\psi_a/2$. *Checked at six values of $\psi$ to $10^{-31}$, together with the tracelessness and $e=\tfrac{\sqrt3}2u$.* With $\eta_a=\gamma_a\pm\beta$ this gives $\psi_a=-2\eta_a\pm2\beta$, hence

$$\boxed{\ \lvert\psi_a-\pi\rvert\ \le\ 2\arccos f+2\beta\ }$$

**which is continuous, vanishes as $f\to1$, and returns $q_a\propto(-2,1,1)$ exactly there.** *So the forcing is not codimension one: it degrades off $f=1$ with a computed modulus, and "no perturbation bound in $\beta$ can exist" is false as stated. What is true is the weaker thing M4 conflated with it, that $\beta$ alone is not the right modulus. The modulus is $(\arccos f,\beta)$.*

**Consequence 3, the gain has a lower bound.** $\max(x,y,z)=\tfrac1{\sqrt3}\cos\big(\tfrac\pi3-\lvert\psi-\pi\rvert\big)$ near the $-$ branch, so the gain is

$$\tfrac1{\sqrt3}\Big(1-\cos\big(\tfrac\pi3-\lvert\psi_a-\pi\rvert\big)\Big)u(t-u^2)\ >\ 0\quad\text{whenever}\quad\arccos f+\beta<30^\circ,$$

which on the surviving set is $f>\cos(30^\circ-\beta)$, satisfied wherever $f>0.9157$. **"The gain has no lower bound" is refuted outright.**

### A SECOND constraint M4 does not look for, and it is this file's own

**The joint Gram system bounds each shape independently of the block equation.** The identity four sections above M1 is $t\ge\sum_a\beta_a^2+\tfrac32\sum_a\alpha_a^2-\tfrac3{10}(\sum_a\alpha_a)^2$, and Cauchy–Schwarz on the last term gives $\sum_a\alpha_a^2\ge\tfrac52\big(\sum_au_a^2-t\big)$, which is [r1059](REVIEW_r1059.md)'s forcing $\sum_ax_i^2\ge(3u^2-t)/1.2$ under $\alpha=\sqrt3x$. Since $\alpha_a=u_a\cos\psi_a$, at equal $u_a$ this reads

$$\sum_a\cos^2\psi_a\ \ge\ \frac{5(3u^2-t)}{2u^2},$$

**a lower bound on how aligned each $q_a$ is with its shared channel, hence a confinement of the shape angle.** *At the Gram cap $3u^2=\tfrac53t$ the right side is exactly $3$, so every $\cos^2\psi_a=1$ and the shape is forced to $\psi_a\in\{0,\pi\}$ EXACTLY, at every $f$.* **Combined with consequence 1, which kills $\psi_a=0$, the shape is forced to $(-2,1,1)$ on the whole Gram-cap surface and not only at $f=1$.** *The file uses this same forcing on the $+$ branch three sections earlier, so M4 contradicts its own file.*

*Sample of the confinement, screened: at $s=0.44$, $f=0.893602$, $u=u_{\mathrm{lo}}$ it permits $7.17^\circ$; at $s=0.40$, $f=0.938499$, $u=u_{\mathrm{lo}}$ it permits $33.34^\circ$; at any $u$ on the Gram cap it permits $0^\circ$.*

### A THIRD constraint M4 does not mention: the $\mathcal D_n$ equation

**Contracting $D\circ D+\sum_a\nu_a\circ\nu_a=\theta D$ with $D$ turns every term into something the record already pins.** $\langle\nu_a\circ\nu_a,D\rangle=\langle L_{q_a}\nu_a,\nu_a\rangle=\tfrac\theta2N_a-\tau$, so on the equal diagonal

$$P(D)\ =\ \theta t-\tfrac{3\theta}2N+3\tau\ =\ \theta-\tfrac{9\theta}2s^2+\tfrac32fs^3,$$

**an exact required value of $P(D)$ at every $(s,f)$, not only at the corner.** *It reproduces [r1063](REVIEW_r1063.md)'s two corner figures: $0.17285403$ required against the forced $-0.9\sqrt3u_{\mathrm{lo}}^3=-0.13018976$, matching that section to eight places.*

| $s$ | $f$ | $P(D)$ required | $\lVert D\rVert^3$ | $P(D)/\lVert D\rVert^3$ |
|---|---|---|---|---|
| $0.35880$ | $0.9999$ | $0.5845071$ | $0.4808695$ | $1.2155212$ |
| $0.40000$ | $0.95$ | $0.4341286$ | $0.3749773$ | $1.1577462$ |
| $0.44000$ | $0.90$ | $0.2727455$ | $0.2714138$ | $1.0049067$ |
| $s_*$ | $1$ | $0.1728540$ | $0.2016898$ | $0.8570290$ |

**The ceiling the record already holds is $\Theta_n$**, $\Theta_n^2=\tfrac{2(n-1)(n-2)}{n^2}$ at even $n$ ([L2](../findings/problem.md)), with $\Theta_4=\tfrac{\sqrt3}2$ reproducing [L220](../findings/second-order.md) step 7's constant at the padded $S^2\times S^2$, which fixes the normalisation. **At $n=12$ that is $\Theta_{12}=1.2360331$ against a required $1.2155212$ at the low-$s$ end, a margin of $1.7\%$, before the three forced $q_a$ are imposed at all.** *That is a live and unexamined line rather than a closure, and it is named here so it is not lost.*

## M1: CONFIRMED, and the table is a root-find

**All five rows reproduce by bisection at $25$ digits, from the closed forms alone.** The Gram column needs no root-find at all, being $f\ge(\theta-\sqrt{5t/3})/s$ in closed form. The deficit column is the root of $d(s,f)=-F(u_{\mathrm{lo}}(f),s,f)=0$ with

$$F(u)=\theta u^2-\frac{u^3}{2\sqrt3}-\frac{u(t+N)}{\sqrt3}-\frac\theta2N+\tau,$$

bisected to $200$ halvings.

| $s$ | Gram, r1069 | deficit, r1069 | width, r1069 | file |
|---|---|---|---|---|
| $0.35882$ | $0.5946041851$ | $0.9998272076$ | $0.0001727924$ | matches |
| $0.40000$ | $0.7344888379$ | $0.9384990890$ | $0.0615009100$ | matches |
| $0.44000$ | $0.8838228267$ | $0.8936023953$ | $0.1063976047$ | matches |
| $0.46000$ | $0.9664651086$ | $0.8753637731$ | $0.0335348914$ | matches |
| $0.46765$ | $1.0000121310$ | $0.8690197456$ | $-1.2131\cdot10^{-5}$ | file prints $1$ and $0$ |

**The last row's discrepancy is the file's own rounding of $s_*$ and not an error.** Bisecting $(\theta-\sqrt{5t/3})/s=1$ gives $s_*=0.467647283579$, where the width is exactly $0$. *The lower endpoint likewise: $d(s,1)=0$ at $s=0.358719467607$, against the file's $0.358719$.* **At $s_*$ the three quantities coincide to twelve digits**, $u_{\mathrm{lo}}(1)=\sqrt{5t/9}=0.437110496$.

## M2: CONFIRMED

The two mechanisms are distinct and each is visible in the columns above. At $s_*$ the Gram column reaches $1$ while the deficit column sits at $0.869$, so the Gram cap alone closes the window. At $s_{\mathrm{lo}}$ the deficit column reaches $1$ while the Gram column sits at $0.595$, so the deficit alone closes it. **The widest point is near $s=0.44$ at $0.106$, as printed.**

## M3: the value and the maximiser are both slightly off, and the active boundary is misnamed

**Refined by nested ternary search on $(s,f)$ with $u$ at the top of its band:**

| quantity | file | r1069 |
|---|---|---|
| $\beta_{\max}$ | $6.3125^\circ$ | $6.3166682^\circ$ |
| $s$ | $0.432160$ | $0.4322466$ |
| $f$ | $0.901459$ | $0.9013703$ |
| $u$ | $0.494133$ | $0.4941258$ |

*The file's point is a feasible near-optimum, $0.004^\circ$ short, so its sixth digit is not its own.* **The bound $\beta\le6.32^\circ$ that [r1067](REVIEW_r1067.md) reported survives, and the file's sharpening to $6.3125^\circ$ does not.**

**On the brief's question of a boundary artefact: it is a boundary optimum, necessarily, and the file names the wrong boundary.** $\beta=\tfrac12\arccos(u_{\mathrm{lo}}/u)$ is increasing in $u$, so the maximiser is always at the top of the band, and the two caps there are the product band $u^2\le u_{\mathrm{lo}}^2+\tfrac13s^2(1-f^2)$ and the Gram cap $\sqrt{5t/9}$. **At the true maximiser the two caps COINCIDE to nine digits, both $0.494125849$, so the optimum is the corner where they cross and both are active.** At the file's point only the band cap is active, $0.494133407$ against a Gram cap of $0.494252074$, so "essentially on the Gram cap" names a constraint that is slack there by $1.2\cdot10^{-4}$.

**And the band cap is exactly $g=N$, which is $h_a=1$, which forces $\nu_b,\nu_c\propto(0,1,-1)$.** *So M3's own maximiser sits where the product-norm equality M4 declares gone at $f<1$ holds EXACTLY. The equality is governed by $g=N$, not by $f=1$, and $f<1$ weakens it only to $h_a\ge f$.* **That is the single sentence of M4 that does the most damage, and it is wrong on the file's own extremal point.**

## M5: CONFIRMED as a statement, and it understates the two conditions it sets aside

The count is right: three vector equations in two-dimensional planes are six scalar equations, and the pairing and the norm are two of them per block. **What M5 misses is that the norm is not a scalar shadow of the system, it is an equality coupling three blocks**, and section one above extracts the whole branch exclusion and the perturbation bound from it without touching the remaining three equations. *So the residue M5 points at is the three DIRECTION equations, which is a smaller debt than the section claims.*

## What the refutation does NOT do

**It does not close [I111](../plan.md).** Screening the derived bound at its worst case over the band, the gain-to-deficit ratio falls below one for $s\gtrsim0.424$ and bottoms at $0.202$ near $s=0.4459$, where the permitted displacement reaches $52.7^\circ$. *So the bound $2\arccos f+2\beta$ is real but loose, and the honest statement of I111 is quantitative rather than structural.*

**The sharper screen, under a symmetric ansatz only.** Solving $h(\eta,\eta)=\sqrt{g/N}$ for the common direction gives an exact displacement rather than a bound, and at $s=0.44$ it exceeds what the Gram confinement permits at every $f$ tried, which would exclude those configurations. *The ansatz $\eta_1=\eta_2=\eta_3$ is an assumption and is not on the record, so this is flagged as a screen and claimed as nothing more.*

## Lean

**Nothing here is typed**, and [width_is_product_bound](../lean/HamiltonsCubic/Results/I111Branch.lean) and [band_width](../lean/HamiltonsCubic/Results/I111Branch.lean) cover the previous section's refutation, confirmed by reading the file.

| claim | typeable | shape it would take |
|---|---|---|
| M1 | yes | $d(s,f)$ and the Gram bound as `Real` definitions, each row a bracketing pair discharged by `norm_num` at rational endpoints, no `native_decide` |
| M2 | yes | two closed-form endpoint statements, $\theta-s_*=\sqrt{5t_*/3}$ at an algebraic $s_*$ and $d(s,f)\le0$ below a rational $f$ |
| M3 | the bound, yes; the argmax, awkwardly | $\beta\le6.32^\circ$ follows from $\cos2\beta\ge u_{\mathrm{lo}}/u_{\mathrm{cap}}$ and monotonicity, all one-variable, while the exact maximiser needs the corner where two caps cross, a two-equation system |
| M4's refutation | yes, cleanly | the spectral lemma is an explicit $3\times3$ symmetric eigen-decomposition with the three eigenvectors written down, $\gamma=-\psi/2$ is a $2\times2$ traceless identity, and $\lvert\psi-\pi\rvert\le2\arccos f+2\beta$ is arithmetic on top |
| M5 | no | a scoping remark about a system rather than a proposition, beyond the six-equation count, which is $\dim V_{Q_a}=2$ from [L120](../findings/second-order.md) and is already partly in the layer |

**The piece worth typing first is M4's spectral lemma**, $\max_{\nu_c}h=\max(\lvert\sin\eta\rvert,\lvert\cos\eta\rvert/\sqrt3)$, because it carries the branch exclusion on its own and needs no numerics at all.

## Reach

**What this review reaches.** The block equation's norm is an equality whose left side is a function of two other blocks' directions, and running it per block pins those directions to within $\arccos f$ of $(0,1,-1)$, excludes the $+$ branch everywhere on the surviving set, and yields $\lvert\psi_a-\pi\rvert\le2\arccos f+2\beta$. Two further constraints, the Gram system's lower bound on $\sum_a\cos^2\psi_a$ and the $\mathcal D_n$ equation's exact $P(D)$, bear on the same shape and are absent from M4.

**What it does not reach.** Whether I111 closes. The derived bound is loose over roughly the upper half of the surviving $s$-range, and nothing here evaluates the three direction equations, which is M5's residue and remains the open object.

**What a successor should take.** Two items, in order. First, the $\mathcal D_n$ scalar shadow against $\Theta_n$ at $n=12$, a margin of $1.7\%$ at the low-$s$ end before the three forced $q_a$ enter, which is a bounded analytic question with a named ceiling. Second, the three direction equations under the shape parameterisation fixed here, $\psi_a=-2\eta_a\pm2\beta$ with $\lvert\eta_a-\tfrac\pi2\rvert\le\arccos f$, where the unknowns are now three angles in a bounded box rather than three free frames.

**Standing rule.** Analysis only. Every figure above is a screen on objects already in hand and takes seconds. No sweep, census or unbounded hunt was opened, and the symmetric-ansatz exclusion is flagged as a screen rather than recorded as a result.
