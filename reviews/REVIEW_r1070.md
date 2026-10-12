# REVIEW_r1070: the codimension-one claim at $f<1$, and the constraint the shape angle already carries

**Reviewer r1070**, cold brief, on the last two sections of [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md). Log: [agent_logs/r1070-codim.log](../agent_logs/r1070-codim.log). *Analysis with screening only, everything below is either an identity checked symbolically or a root-find at 30 to 40 digits on objects the file already carries.*

## Verdicts

| claim | what it says | verdict |
|---|---|---|
| M1 | the surviving $(s,f)$ table, Gram floor against deficit floor | **CONFIRMED**, both columns reproduce to seven digits by bisection |
| M2 | both ends pinch $f\to1$, by different mechanisms | **CONFIRMED**, with one scope note: the deficit is zero at the lower end, so the configurations surviving there have nothing to close |
| M3 | $\beta\le6.3125^\circ$ over the surviving set | **REFUTED.** The maximiser is not in the surviving set: it sits on the deficit floor and uses a $u$ at which $F(u)=+0.0074991$, so the chain already closes there. The bound over the surviving set is $\beta\le5.4755^\circ$ |
| M4 | at $f<1$ the shape is unconstrained, the forcing is codimension one, no perturbation bound can exist | **REFUTED.** The eigenframe is a rigid function of the shape rather than a free frame, the shared-pair coefficient IS a shape coordinate, and the record's own Gram identity is therefore a constraint on the three shape angles. A perturbation bound exists, is explicit, and closes the $-$ branch outright over two thirds of the surviving range |
| M5 | what remains is the full cyclic vector system | **CONFIRMED**, and the count is tighter than the file states it: six scalar equations in six angles, so the system is zero-dimensional rather than underdetermined |

---

## M4, the central refutation: the eigenframe IS the shape, one for one

**The claim's load-bearing sentence is "fixes $\nu$'s angle RELATIVE TO $L_q$'s eigenframe and says nothing about where that frame sits".** *It treats the eigenframe's position as a datum independent of $q$'s shape.* **It is not independent. It is the shape, at half the rate.**

**Derived from [L121](../findings/second-order.md) alone.** Take the signed-coordinate basis of $\mathbf1^\perp$

$$v_1=\tfrac1{\sqrt2}(0,1,-1),\qquad v_2=\tfrac1{\sqrt6}(2,-1,-1),$$

and parametrise $q$'s shape on its circle by $(x,y,z)=\tfrac u{\sqrt3}\big(\cos\psi,\cos(\psi-\tfrac{2\pi}3),\cos(\psi+\tfrac{2\pi}3)\big)$, which is forced, $\Pi_Q$ being two-dimensional with $\lVert q\rVert^2=2(x^2+y^2+z^2)$. Then with $A=2x$, $B=2y$, $C=2z$ and $A+B+C=0$, L121's $G$ restricts to

$$L_q\big|_{\mathbf1^\perp}\ =\ \frac{\sqrt3\,u}{2}\begin{pmatrix}-\cos\psi&-\sin\psi\\-\sin\psi&\cos\psi\end{pmatrix}\quad\text{in }(v_1,v_2),$$

a reflection scaled by $e=\tfrac{\sqrt3}2u$. **Its top eigenvector sits at angle $\gamma=\tfrac\pi2+\tfrac\psi2$ from $v_1$.** *So the eigenframe turns at exactly half the shape's rate, and the shape circle maps bijectively onto the full projective circle of in-plane directions.*

**Three consequences, each fatal to a different part of M4.**

- **The frame's position and the shape are the same unknown.** Any statement about where $\nu$ points, in the plane's own fixed basis, transfers to $\psi$ with a factor of two and back. "Says nothing about where that frame sits" reads as though a datum were missing. Nothing is missing, the datum is $\psi$.
- **A perturbation bound in the shape is exactly a perturbation bound on $\gamma$**, so $\delta\psi=2\,\delta\gamma$ converts one into the other with no loss. M4's "there is nothing to bound, because the quantity to be bounded is free" fails at the first step.
- **[I110](../plan.md)'s forcing reproduces as $\psi=\pi$.** At $\psi=\pi$ the shape is $(-2,1,1)$ and the top eigenvector is $(0,1,-1)$, and at $\psi=0$ the shape is $(2,-1,-1)$ and the top eigenvector is $(2,-1,-1)$. *Checked against L121's matrix at twenty-five shape angles and three norms, every identity to $10^{-12}$.* **So the file's "$+$ branch" and "$-$ branch" are the two antipodal points $\psi=0$ and $\psi=\pi$ of one circle**, which is what makes the question a perturbation question rather than a dichotomy.

**And the gain is a function of $\psi$ in closed form.** With $\tilde\psi$ the reduction of $\psi$ into $[-\tfrac\pi3,\tfrac\pi3]$ modulo $\tfrac{2\pi}3$,

$$\frac{\max(x,y,z)}{u}=\frac{\cos\tilde\psi}{\sqrt3},\qquad\text{gain factor}\ \ g(\psi)=\frac1{\sqrt3}\big(1-\cos\tilde\psi\big)\in\Big[0,\tfrac1{2\sqrt3}\Big],$$

*zero at $\psi\in\{0,\pm\tfrac{2\pi}3\}$ and maximal at $\psi\in\{\pi,\pm\tfrac\pi3\}$.* **At $s_*$ this gives $\tfrac1{2\sqrt3}u(t-u^2)=0.0192874$, the file's own corner figure, so the parametrisation is calibrated against the record.**

## M4, the constraint the claim did not look for: the shared-pair coefficient is a shape coordinate

**$x_a$ is not a separate quantity from $q_a$'s shape. It is $\tfrac u{\sqrt3}\cos\psi_a$.** *The file derives, four sections above the claim, that $\Pi_{Q_a}$ and $\Pi_{Q_b}$ share exactly the one pairing slot and that only three numbers $x_1,x_2,x_3$ appear across all three overlaps. Those three numbers are the first coordinates of the three shapes.*

**So [r1059](REVIEW_r1059.md)'s forcing, which the file carries and cites, is a constraint on the three shape angles.** Substituting $x_a=\tfrac u{\sqrt3}\cos\psi_a$ into the joint-system identity $\sum_au_a^2\le t-\tfrac32\sum_ax_a^2+\tfrac9{10}(\sum_ax_a)^2$ gives, with $c_a=\cos\psi_a$ and $u_a=u$ on the equal diagonal,

$$\Phi(c)\ :=\ \tfrac3{10}\Big(\sum_ac_a\Big)^2-\tfrac12\sum_ac_a^2\ \ \ge\ \ K,\qquad K\ =\ 3-\frac t{u^2}.$$

**$\Phi=0.4p^2-\tfrac12\lVert c_\perp\rVert^2$ with $p=\mathbf1^{\mathsf T}c/\sqrt3$, so it is maximised at $c=\pm(1,1,1)$ with value $\tfrac65$**, which is the Gram cap $u^2\le\tfrac59t$ restated. *That is the same statement read at the shape rather than at the norm, and it is what M4 asserts does not exist.*

**Two exact corollaries, both one line from the quadratic.**

- **Coordinatewise confinement.** $\Phi(c)\ge K$ with $\sum_ac_a>0$ forces $\min_ac_a\ge3-\sqrt{10-5K}$, by maximising $\Phi$ over the other two coordinates, which lands on the box corner $c_2=c_3=1$. The mirror statement holds on $\sum_ac_a<0$.
- **The mixed shape is gone.** $c_a=-\tfrac12$, the OTHER zero of the gain, needs $K\le-\tfrac{9}{20}$ on the positive branch and $K\le\tfrac34$ on the negative one, and $K\ge0.5441$ everywhere on the surviving set. **So mixed-sign triples are excluded outright, and $\psi_a=\pm\tfrac{2\pi}3$ is excluded on the positive branch at every point of the surviving set.**

**The numbers, over the surviving set, computed at its WEAKEST point** ($f\to1^-$ and $u=u_{\mathrm{lo}}$, where $K$ is smallest, so these are the infima):

| $s$ | $K$ | $\lvert\psi_a\rvert$ allowed on the $+$ branch | min over the $-$ branch of $\max_ag(\psi_a)$ | $g$ needed | ratio |
|---|---|---|---|---|---|
| $0.3600$ | $0.5480$ | $\le72.21^\circ$ | $0.013711$ | $0.001178$ | $11.6$ |
| $0.3800$ | $0.6171$ | $\le68.25^\circ$ | $0.021863$ | $0.021300$ | $1.026$ |
| $0.4200$ | $0.8191$ | $\le55.25^\circ$ | $0.057146$ | $0.077293$ | $0.739$ |
| $0.4400$ | $0.9579$ | $\le44.17^\circ$ | $0.094838$ | $0.120706$ | $0.786$ |
| $0.4600$ | $1.1267$ | $\le24.45^\circ$ | $0.174020$ | $0.186697$ | $0.932$ |
| $s_*=0.467647$ | $1.1999$ | $\le0.77^\circ$ | $0.284802$ | $0.222567$ | $1.280$ |

*The $-$ branch column is exact rather than sampled: minimising $\max_ag$ subject to $\Phi\ge K$ puts every $c_a$ at the same value, so the optimum solves $\tfrac65\cos^2(\tfrac{2\pi}3+\alpha)=K$ and the bound is $\tfrac1{\sqrt3}(1-\cos\alpha)$.*

**WHAT THIS DECIDES.**

- **"$q_a$'s shape is unconstrained" is FALSE.** On the positive branch the shape angle is confined to $\lvert\psi_a\rvert\le72.2^\circ$ at the loosest and $0.77^\circ$ at $s_*$, and the confinement is continuous in $K$ rather than switched off at $f<1$.
- **"The gain has no lower bound" is FALSE on the $-$ branch and TRUE on the $+$ branch.** On the negative branch the Gram system alone gives a strictly positive lower bound which CLOSES the block for $s\le0.380969$ and for $s\ge0.463562$, and falls short by at worst $26\%$ in between, at $s\approx0.42$. *That is a perturbation bound of exactly the kind the claim declares impossible, and it is within a quarter of closing two thirds of the range with no eigenvector argument at all.*
- **"The forcing is codimension one" is the wrong frame.** What is codimension one is [I110](../plan.md)'s SIGN choice, not the forcing. The shape stays pinned near an antipodal pair $\{\psi=0,\psi=\pi\}$ at every $f$, and only the choice between them is lost when the product equality goes.
- **So I111 is the $+$ branch and nothing else.** The one shape with all three gains at zero is $\psi_1=\psi_2=\psi_3=0$, $c=(1,1,1)$, which is the unique point of $\{1,-\tfrac12\}^3$ with $\Phi\ge K$. *I110 excludes it at $f=1$, since $\beta=0$ there would make $\nu\propto(2,-1,-1)$ against the product equality's $(0,1,-1)$. Off $f=1$ nothing on the record excludes it yet.*

## M4, the two further constraints, and what each is worth

**The $\mathcal D_n$ equation has a scalar shadow the claim never mentions, and it is a hard equality.** Pairing $D\circ D+\sum_a\nu_a\circ\nu_a=\theta D$ with $D$, and using $\langle\nu_a\circ\nu_a,D\rangle=\langle L_{q_a}\nu_a,\nu_a\rangle=\tfrac\theta2N_a-\tau$, gives

$$P(D)\ =\ \theta t-\tfrac32\theta s^2+3\tau,$$

**so $P(D)$ is a FUNCTION of $(s,f)$ alone**, $0.172866$ at $s_*$, which is [r1063](REVIEW_r1063.md)'s figure reproduced here from the equation rather than taken from it. *On the positive branch at Gram saturation the forced $D$ gives $P(D)=+0.9\sqrt3u^3=+0.130190$, short by $0.0427$, against the negative branch's $-0.130190$, short by $0.303$.* **This is a route and not a closure**, because off $s_*$ the Gram bound is slack and $D$ is no longer forced. *It is named here because it is the third constraint the claim omits and it is the one that scales with the branch.*

**The vector block equation does pin $\nu_a$'s direction, and the inverse exists.** $\theta-2L_{q_a}$ has eigenvalues $\theta\mp\sqrt3u$ on the plane, and $u\le\tfrac12$ across the surviving set against $\theta/\sqrt3=0.7071$, so the smaller eigenvalue is at least $\theta-\tfrac{\sqrt3}2=0.3587>0$. **So $\nu_a=(\theta-2L_{q_a})^{-1}(2\nu_b\circ\nu_c)$ exactly, at every point of the surviving set**, and the direction of each $\nu_a$ is a function of the other two and of $q_a$. *M4 treats $\eta_a$ and $\psi_a$ as jointly free within one block, which is right in isolation and wrong in the cycle.*

## M5, and the count is better than the file states it

**CONFIRMED, and sharpened.** The unknowns on the equal diagonal, with $N_a$, $u_a$, $t$ and $\tau$ fixed by $(s,f)$, are three shape angles $\psi_a$ and three direction angles $\eta_a$, six in all. The three block equations live in two-dimensional planes, so they are six scalar equations. **The system is square, not underdetermined**, which is stronger than the file's "overdetermined by three" at the corner and stronger than M4's reading of it as free. *The two scalar shadows the file uses, the pairing and the norm, are two of the six per block pair, and what is discarded is the direction half, which is exactly the branch information.*

## M3, refuted

**The reported maximiser is outside the surviving set, and by the file's own definition of it.** At $s=0.432160$, $f=0.901459$:

| quantity | value | reading |
|---|---|---|
| deficit floor $f_d$ at this $s$ | $0.9014593669$ | the reported $f$ IS the floor, so $d=-4.2\times10^{-8}$ |
| $u_{\mathrm{lo}}$ | $0.4821858264$ | |
| $F=0$ root | $0.4821857588$ | BELOW $u_{\mathrm{lo}}$, so no $u$ survives at this $(s,f)$ |
| band top | $0.4941334068$ | this is the $u$ the file reports as $0.494133$ |
| Gram cap | $0.4942520742$ | the file reports the maximiser as "essentially ON" this |
| $F$ at the $u$ used | $+0.0074991$ | positive, so the chain CLOSES there |

**Two separate defects.** *First, the constraint that caps $u$ at that point is the band top, not the Gram cap, and the two agreeing to four digits there is a coincidence of that $s$.* **Second and decisive, the file's own survival condition is $F(u)<0$ at the actual $u$, which it states three sections earlier as "the chain fails on the whole sub-interval where $F(u)<0$", and the reported maximiser violates it.**

**The corrected figure.** Imposing $u\le\min(\text{Gram cap},\ u_{F=0},\ \text{band top})$,

$$\beta\ \le\ 5.4755^\circ\qquad\text{at }s=0.444591,\ f=0.935953,\ u=0.475521,$$

**where the Gram cap does genuinely bind**, the three caps being $0.475521$, $0.475565$ and $0.475531$. *So the file's remark about the Gram cap is right about the corrected maximiser and wrong about the one it reports.* **The maximiser lying on a $u$ boundary is NOT an artefact**: $\cos2\beta=u_{\mathrm{lo}}(f)/u$ is strictly increasing in $u$, so the maximum is on the $u$ boundary by monotonicity, and all three caps are exact constraints rather than estimates. *What was an artefact is which boundary, and whether the point survives at all.*

## M1, confirmed

**Both floor columns reproduce by bisection at forty digits**, from $d(s,f)=-F\big(s,f,u_{\mathrm{lo}}(f)\big)$ with the file's own $F$:

| $s$ | Gram floor, recomputed | file | deficit floor, recomputed | file |
|---|---|---|---|---|
| $0.35882$ | $0.5946041851$ | $0.594602$ | $0.9998272076$ | $0.999828$ |
| $0.40000$ | $0.7344888379$ | $0.734489$ | $0.9384990890$ | $0.938499$ |
| $0.44000$ | $0.8838228267$ | $0.883823$ | $0.8936023953$ | $0.893602$ |
| $0.46000$ | $0.9664651086$ | $0.966465$ | $0.8753637731$ | $0.875364$ |
| $0.46765$ | $1.0000121310$ | $1.000000$ | $0.8690197456$ | $0.869022$ |

*Controls that reproduce: $s_{\mathrm{lo}}=0.358719467607$, $s_*=0.467647283579$, and the deficit at $s_*$ is $0.01487303427$ against the record's $0.0148730$.* **One nit.** At $s=0.46765$ the Gram floor is $1.0000121>1$, so that row's surviving set is EMPTY rather than a point, and the table prints the floor as $1.000000$. *The exact endpoint is $s_*=0.4676473$, and the table's last row is a shade past it.*

## M2, confirmed with a scope note

**Both mechanisms check out and they are genuinely different objects.** At the top, $u_{\mathrm{lo}}(f)\le\sqrt{5t/9}$ forces $f\to1$ because the two sides meet at $s_*$. At the bottom, $d(s,f)>0$ forces $f\to1$ because $d\big(s_{\mathrm{lo}},1\big)=0$. *The one is a cap on $u$ and the other a sign condition on a cubic in $u$, so "different mechanisms" is right.*

**The scope note the section owes.** At the lower end the deficit itself vanishes, $d=2.1\times10^{-4}$ at $s=0.36$ against $0.0149$ at $s_*$. **So the configurations that survive near $s_{\mathrm{lo}}$ have almost nothing left to close**, and the pinch there is a statement about a shrinking deficit rather than about a tightening constraint. *The $-$ branch row of the table above makes the same point from the other side: the ratio there is $11.6$.*

## Lean

**Nothing here is typed, and the corrections are more typable than the claims.**

| claim | could it be typed |
|---|---|
| M1 | The Gram floor is the algebraic equivalence $u_{\mathrm{lo}}(f)\le\sqrt{5t/9}\iff f\ge(\theta-\sqrt{5t/3})/s$, typable outright beside [band_width](../lean/HamiltonsCubic/Results/I111Branch.lean). The deficit floor's NUMERIC value is a cubic root and wants interval arithmetic |
| M2 | Typable as two identities at defined roots, that the Gram floor equals $1$ at $s_*$ and the deficit floor equals $1$ at $s_{\mathrm{lo}}$ |
| M3 | The identity $\cos2\beta=u_{\mathrm{lo}}(f)/u$ is typable now, it is the pairing equation divided by $eN$. The numeric maximum is not, and the REFUTATION is, as the single inequality $F\big(s,f,\text{band top}\big)>0$ at the reported point |
| M4 | **Typable in full and with no decision procedure.** The restriction $L_q\vert_{\mathbf1^\perp}=e\,R(\psi)$, the coordinate $x=\tfrac u{\sqrt3}\cos\psi$, the eigenvector at $\gamma=\tfrac\pi2+\tfrac\psi2$, the gain factor $\tfrac1{\sqrt3}(1-\cos\tilde\psi)$, and the two corollaries of $\Phi(c)\ge K$ are all finite algebra over an ordered field |
| M5 | The dimension count is typable as a statement, that the block equation lives in a two-dimensional space so three of them are six scalars. The solvability question is not a Lean object |

## Reach

**What I checked.** Every identity in the M4 section symbolically and then numerically against L121's matrix at twenty-five shape angles and three norms, to $10^{-12}$. M1's five rows and both endpoints by bisection at forty digits. M3's caps and the corrected maximiser at thirty digits on a $600\times400$ grid with a local polish. The $-$ branch minimax against an independent coarse grid over $[-1,1]^3$, which agrees with the exact formula from above, as it must.

**What I did NOT check, and it bounds the verdicts.**

- **The Gram identity itself is taken from the record** ([r1059](REVIEW_r1059.md) and the 2026-09-16 section), not re-derived here. My contribution is that its $x_a$ is a shape coordinate and what follows, so if that identity is wrong the M4 refutation's second half goes with it. *The first half, the eigenframe being the shape, rests on L121 alone and is independent of it.*
- **Everything is on the equal-$N_a$ diagonal with a COMMON $u$**, which is the file's frame. *Unequal $u_a$ changes $\Phi\ge K$ into $\sum_a u_a^2\Phi$-shaped form and the confinement numbers move.*
- **The $P(D)$ route is named and not pursued.** Turning it into an exclusion needs an upper bound on $P(D)$ over the diagonal tensors with the three projections pinned, which is an optimisation of unknown cost and is NOT started here, per the standing rule.
- **The $+$ branch is open and this review does not close it.** What it does is remove every other escape, so what I111 owes is one question: does the cyclic vector system admit $\psi_1=\psi_2=\psi_3=0$ at some $f<1$ on the surviving set. *That is M5's system, and M5 is right that it is what is left.*
