# Review r1077, the $\psi_a\equiv0$ ansatz: the counting argument is unsound, and $\psi_a\equiv0$ is EXCLUDED OUTRIGHT

*Gate 2, SECOND READER on a claim that had one. Cold brief. The first second-reader (r1075) died at phase 6 inside a reconstruction of the trilinear form. Log: [agent_logs/r1077-ansatz.log](../agent_logs/r1077-ansatz.log).*

**Contamination discipline, stated because the brief asked for it.** *Not opened at any point: [REVIEW_r1076.md](REVIEW_r1076.md), [REVIEW_r1075.md](REVIEW_r1075.md), post F75 in [fence-posts.md](../findings/fence-posts.md), the 1075 and 1076 rows of [INDEX.md](INDEX.md). Everything below is built from [second-order.md](../findings/second-order.md)'s L24, L120, L121, L220 and L221 and from [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), which does carry r1069's and r1070's conclusions in its own prose and which the brief named as a primary.*

| claim | verdict |
|---|---|
| **A1**, the system is square at $\psi_a\equiv0$, one in one inside the symmetric ansatz and three in three outside | **REFUTED** |
| **A2**, cyclic symmetry is what collapses the three transverse equations | **CONFIRMED as a collapse, REFUTED as a selector of $\psi_a=0$** |
| **A3**, counting cannot exclude $\psi_a\equiv0$, so the exclusion must come from sign or magnitude | **premise REFUTED, conclusion CONFIRMED by other means** |
| **A4**, $\psi_a\equiv0$ lies in the surviving set | **REFUTED** |
| **A5**, $\max f$ at $\psi_a\equiv0$ against the Gram floor | **$f\le1/\sqrt3=0.577350$ against a floor of $0.594604$ at best and $0.891690$ in fact: EXCLUDED OUTRIGHT** |

## The frame, rebuilt from L121 rather than taken

**In the orthonormal basis $\hat w=(2,-1,-1)/\lVert\cdot\rVert$, $\hat p=(0,1,-1)/\lVert\cdot\rVert$ of the Bianchi plane $\mathbf1^\perp$, [L121](../findings/second-order.md)'s $\tfrac12G$ restricted to $\mathbf1^\perp$ is**

$$L_{q}\big|_{\mathbf1^\perp}=\frac{\sqrt3}2u\begin{pmatrix}\cos\psi&-\sin\psi\\-\sin\psi&-\cos\psi\end{pmatrix},\qquad (x,y,z)=\frac u{\sqrt3}\big(\cos\psi,\cos(\psi-\tfrac{2\pi}3),\cos(\psi+\tfrac{2\pi}3)\big).$$

**This is a reflection of modulus $\tfrac{\sqrt3}2u$ whose $+$ eigenvector sits at angle $-\psi/2$ from $\hat w$, so the eigenframe turns at exactly half the shape rate.** *Derived here from $A=2x$, $B=2y$, $C=2z$ and $A+B+C=0$ alone, which is the third independent reproduction the file asks for.* **Calibrated against the one case the record fixes**: $\psi=\pi$ gives $q\propto(-2,1,1)$ and puts the top eigenvector on $(0,1,-1)$, which is [I110](../plan.md)'s forced configuration verbatim.

**And the modulus is [L220 step 5](../findings/second-order.md)'s $E=3\lVert q\rVert^2$ re-derived**, since $\tfrac12\sqrt E=\tfrac{\sqrt3}2u$ falls out of the same two entries.

## The Gram constant $5/3$ is the geometry of one shared slot, and its equality case forces $\psi_a\equiv0$ or $\psi_a\equiv\pi$

**Write $Q_1=P_1\cup P_2$, $Q_2=P_2\cup P_3$, $Q_3=P_1\cup P_3$ for disjoint pairs $P_a$.** *Each of the three overlaps $Q_1\cap Q_2=P_2$, $Q_2\cap Q_3=P_3$, $Q_1\cap Q_3=P_1$ lies in the SAME opposite-pair class of each block it meets, the class this record writes as the $x$ slot.* **So the only nonzero inner products among the six basis vectors $\{\hat w_a,\hat p_a\}$ of the three planes $\Pi_{Q_a}$ are $\langle\hat w_a,\hat w_b\rangle=\tfrac13$**, and the $\hat p_a$ are orthonormal and orthogonal to every $\hat w$.

**Hence $\sum_a\lVert P_{\Pi_a}D\rVert^2\le\lambda_{\max}\big(\sum_a\hat w_a\hat w_a^{\mathsf T}+\sum_a\hat p_a\hat p_a^{\mathsf T}\big)\lVert D\rVert^2$, and the Gram matrix $I+\tfrac13(J-I)$ of the $\hat w$'s has spectrum $\{\tfrac53,\tfrac23,\tfrac23\}$:**

$$\sum_au_a^2\le\tfrac53t,\qquad\text{equality exactly when }D\in\mathbb R\,(\hat w_1+\hat w_2+\hat w_3).$$

**That reproduces the record's Gram constant from the definitions, and it says more than the constant.** *At the cap, $q_a=\tfrac53c\,\hat w_a$, so all three shapes are forced to a COMMON $\psi\in\{0,\pi\}$ with one common sign.* **This is why [I110](../plan.md)'s corner forcing needed no extra argument**, and it reduces the corner to a choice between two shapes rather than to a continuum.

## The bilinear formula: the sign correction is right, and the COORDINATE LABEL on it is wrong

**[The printed formula](2026-09-14-I104-tau-positive.md) is called a formula in signed coordinates. It closes into $V_{Q_3}$ only when its slots are read as RAW pairing components, where first Bianchi is $a-b+c=0$.** With the corrected $+\tfrac12(b_1c_2+c_1b_2)$ on the $(kp,lm)$ slot,

$$\text{out}_a-\text{out}_b+\text{out}_c=\tfrac12\big[a_1a_2-(b_1-c_1)(b_2-c_2)\big]=0\quad\text{whenever }a_k=b_k-c_k,$$

*while the same formula fed signed coordinates returns $\text{out}_a+\text{out}_b+\text{out}_c=a_1a_2\ne0$, which is not a Weyl tensor at all.* **Both mixed readings fail too**, so all-raw is the unique consistent one of the four. **Translated into signed coordinates the product is $\big(\tfrac12A_1A_2,\,-\tfrac12(B_1B_2+C_1C_2),\,-\tfrac12(B_1C_2+C_1B_2)\big)$.**

**The cyclic test the record used is sound and confirms the sign flip, but it does NOT discriminate the convention**: $\tau$ is fully $S_3$-symmetric under either reading. *The record's own surrounding prose is in signed coordinates throughout, since its equality case $a=0$, $b=-c$ is degenerate when read raw, and [I110](../plan.md)'s $\nu\propto(0,1,-1)$ and $q\propto(-2,1,1)$ are signed by construction.* **So the file mixes two conventions across three sentences, and the two give different $\tau$ at the same configuration**, $\tfrac32r^3$ against $\tfrac12r^3$ at $\gamma_a\equiv0$ with $r=\sqrt{N/3}$.

**Everything below is computed under BOTH readings and the verdict is the same under each**, which is why the convention defect does not block the conclusion. *It should still be repaired, because a reader substituting signed coordinates into the printed formula gets $\tau$ wrong by more than a sign.*

**Three calibrations against answers the record already fixes, all passed.** *$\max\lvert\tau\rvert$ over the three Bianchi planes is attained at $\nu_a\propto(0,1,-1)$ and equals $\tfrac12\sqrt{N_1N_2N_3}$ exactly, so $f=1$ is reachable and the product bound is sharp; the maximiser is $\gamma_a\equiv\tfrac{3\pi}2$, which is $\nu_a\propto(0,1,-1)$; and that is [I110](../plan.md)'s $\psi\equiv\pi$ configuration, whose $f$ must be $1$ because the Gram cap binds there.*

## A5, the decisive item: $\psi_a\equiv0$ caps $f$ at $1/\sqrt3$

**$\tau$ is a function of the three $\nu$-angles alone.** *Writing $\nu_a=\sqrt N(\cos\gamma_a\,\hat w_a+\sin\gamma_a\,\hat p_a)$, $f=\tau/(\tfrac12s^3)$ depends on $\gamma_1,\gamma_2,\gamma_3$ and on nothing else. It is not an independent coordinate of the surviving set, which is worth saying because the record's $(s,f)$ parametrisation invites reading it as one.*

**At $\psi_a\equiv0$ the parallel half of each block equation reads $\cos2\gamma_a=u_{\mathrm{lo}}(f)/u$**, the same right-hand side for all three, so the three $\gamma_a$ lie in $\{\gamma,-\gamma,\pi+\gamma,\pi-\gamma\}$ for one common $\gamma$, and $u_{\mathrm{lo}}(f)=(\theta-fs)/\sqrt3>0$ at every $f\le1$ and $s\le s_*$ forces $\gamma<45^\circ$.

**Maximising $f$ over that whole family:**

| reading | $\max f$ at $\psi_a\equiv0$ | attained at |
|---|---|---|
| raw | $1/\sqrt3=\mathbf{0.577350}$ | $\gamma_a\equiv0$, and at the three patterns with two $\gamma_a=\pi$ |
| signed | $\mathbf{0.421595}$ | $\gamma=45^\circ$ |

**Against the Gram floor $f\ge(\theta-\sqrt{5t/3})/s$**, which runs $0.594604$ at $s=0.35882$, $0.734489$ at $s=0.40$, $0.883823$ at $s=0.44$, $0.999999$ at $s_*$, *reproducing the record's own table to six places*. **There is no $(s,\gamma)$ in the surviving range at which $\psi_a\equiv0$ is Gram-feasible, under either reading.** *And the binding floor is not Gram but the deficit: the surviving set needs $f\ge0.891690$, so the true margin is $35\%$ rather than the $3\%$ the Gram test alone shows at the bottom of the range.*

**THE ANSWER TO A5 IS THEREFORE YES, $\psi_a\equiv0$ IS EXCLUDED OUTRIGHT, AND THE EXCLUSION IS A MAGNITUDE ONE ON $\tau$.** *The mechanism in one line: at $\psi_a=0$ the pinning puts $\nu_a$ within $45^\circ$ of $\hat w_a\propto(2,-1,-1)$, and $\tau$ is small there, while the surviving set needs $\tau$ within $11\%$ of its ceiling, which only $\nu_a\propto(0,1,-1)$ supplies.*

**So A4 is REFUTED.** *It fails the Gram condition, and it fails the deficit condition by more.*

**And the exclusion corroborates [I110](../plan.md) from a new direction.** *The Gram cap admits only $\psi_a\equiv0$ and $\psi_a\equiv\pi$, and the first carries $f\le0.577$ while the cap demands $f=1$, so the corner is $\psi_a\equiv\pi$, which is what the eigenvector argument gives. Two independent routes to the same forced shape, the second one fixing the sign of $\tau$ as well.*

## A1 and A3, where the counting goes wrong

**A1 counts the three transverse equations against the three $\nu$-angles. Those angles are already spent.** *Each block equation is a vector equation in a two-dimensional space, and its component ALONG $\nu_a$ is the pinning identity $\cos2\beta_a=u_{\mathrm{lo}}(f)/u$ of [L221](../findings/second-order.md) item 2, which determines $\gamma_a$ from $\psi_a$, $u$ and $f$ up to a four-fold discrete choice.* **The transverse components then arrive with no angle left to satisfy them.** At $\psi_a\equiv0$ the honest count is six equations against $\gamma_1,\gamma_2,\gamma_3,u,s$, **overdetermined by one**, and in the symmetric ansatz two equations against $\gamma,u,s$. *Holding $(s,u)$ at the regime's values instead makes it six against three and two against one.* **Under no convention is it one in one or three in three.**

**A1 is REFUTED.**

**A2 is half right.** *Cyclic symmetry does collapse the three transverse equations to one, and the $3$-cycle is a genuine symmetry of the configuration, realised by the permutation cycling $P_1\to P_2\to P_3$.* **What it does not do is select $\psi_a=0$**: the cyclic locus is $\psi_1=\psi_2=\psi_3=\psi$ for ANY common $\psi$, a one-parameter family containing both $\psi\equiv0$ and [I110](../plan.md)'s $\psi\equiv\pi$. *So the symmetric ansatz is not an argument for looking at $\psi=0$, and $\psi=0$ has to be singled out by the vanishing of the $+$ branch gain, which is what actually does it.*

**A3's premise is REFUTED and its conclusion survives.** *Squareness is a heuristic about complex solution counts and says nothing about real solutions inside an inequality-cut region, so "square" never predicted a solution here. Worse for the premise, the record's own square count is of the FULL system in six angles, and $\psi_1=\psi_2=\psi_3=0$ is three further conditions on its isolated solutions, so naive counting points AT exclusion rather than away from it.* **A3's conclusion, that an exclusion must come from the sign or the magnitude of the solution, is correct, and A5 is that exclusion.**

## What I did not reach

**The bilinear formula is taken from the record, not rebuilt from the Fox product.** *Rebuilding it is the open-ended run the analysis-only rule reserves and the one that killed [r1075](REVIEW_r1075.md), so it was not opened. The three calibrations above are what stands in for it, and the verdict is invariant under the one convention ambiguity I did find.*

**The three transverse equations themselves are never evaluated here.** *They are not needed: the parallel half plus Gram already excludes $\psi_a\equiv0$. If the transverse half is wanted, it reads $\tfrac{\sqrt3}2u\sqrt N\sin2\beta_a=\langle\nu_b\circ\nu_c,\hat n_a\rangle$ with $\hat n_a\perp\nu_a$, and its right-hand side has modulus $\sqrt{\lVert\nu_b\circ\nu_c\rVert^2-\tau^2/N_a}$, a function of the $\gamma$'s alone.*

**The extra degeneracy asked for in the brief is in the Gram geometry, not in the equations.** *The full block symmetry is $S_3$ rather than the $3$-cycle alone, but the load-bearing degeneracy is that all three overlaps occupy one slot, which is what makes the $\hat p_a$ mutually orthogonal and the Gram operator $\tfrac53$ on a single line.*
