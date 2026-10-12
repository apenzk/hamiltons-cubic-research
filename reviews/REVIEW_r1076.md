# Gate 2 review r1076: the counting argument at the `+` branch's symmetric point

Round: one reader, the second on the $\psi\equiv0$ item [r1074](REVIEW_r1074.md) left owed. Subject: the final paragraph of [post F75](../findings/fence-posts.md), argued from the definitions in [L120, L121, L220 and L221](../findings/second-order.md) and from the product formula reconstructed below.
Log: [agent_logs/r1076-ansatz.log](../agent_logs/r1076-ansatz.log). *Analysis with screening only: exact algebra, plus seconds of grid evaluation on objects constructed here for the screen.*

| claim | subject | verdict |
|---|---|---|
| C1 | the equation/unknown count at $\psi_a\equiv0$ and off it | **REFUTED AS STATED.** Read in the count it cites, the sentence argues the OPPOSITE of the post's conclusion |
| C2 | cyclic symmetry collapses the three perpendicular equations to one | **REFUTED.** The cyclic rotation leaves the common $\psi$ free, so it cannot deliver $\psi=0$. The $(\mathbb Z_2)^3$ of within-pair swaps does, and the post never names it |
| C3 | "square, so generic position predicts a solution" | **PLAUSIBLE in its negative half only.** Counting cannot exclude. Predicting a solution is an overclaim, and this configuration is rigid enough to be evaluated instead of guessed at |
| C4 | $\psi_a\equiv0$ lies in the surviving set | **CONFIRMED that the record excludes nothing there**, and $\psi_a\equiv0$ is the shape with the MOST Gram slack, the only admissible one at $s_*$ |
| C5 | the $\nu$-angles are independent of the shape angles | **REFUTED.** The pinning ties them: $\eta_a=\tfrac\pi2+\tfrac{\psi_a}2\pm\beta$ with $\cos2\beta=u_{\mathrm{lo}}/u$. The freedom left is one SIGN per block |
| C6 | an exclusion must come from sign or magnitude, never from counting | **CONFIRMED, and the exclusion is delivered here.** At $\psi_a\equiv0$ the configuration's own $f$ is at most $1/\sqrt3=0.5773503$, against a Gram floor of at least $0.5942738$ across the whole window |

---

## C2 and the symmetry, taken first because C1 and C6 both rest on it

**The configuration has a real symmetry group and the post names the wrong part of it.** With $\lvert Q_1\cap Q_2\rvert=2$ and $Q_3=Q_1\triangle Q_2$ the six live indices split into three pairs $P_1,P_2,P_3$ with $Q_1=P_1\cup P_2$, $Q_2=P_1\cup P_3$, $Q_3=P_2\cup P_3$. The stabiliser of that configuration inside $S_6$ is $(\mathbb Z_2)^3\rtimes S_3$ of order $48$: the $S_3$ permutes the pairs and rotates the blocks, the $(\mathbb Z_2)^3$ swaps the two indices inside each pair.

**The cyclic rotation cannot deliver $\psi=0$, and this is the refutation.** A cyclically invariant configuration has $\psi_1=\psi_2=\psi_3$, a COMMON value, which is one real unknown and not zero. So inside a purely cyclic ansatz the demand $\psi=0$ is still one extra condition on an otherwise square system, hence overdetermined by one, and the post's own generic-position heuristic then predicts NO solution. *Taken at face value the sentence argues against the conclusion it is offered for.*

**What does deliver it is the within-pair swap, and it lands exactly on $\psi=0$.** Write $\sigma_1$ for the transposition inside $P_1$. On $\Pi_{Q_1}$ and $\Pi_{Q_2}$ it fixes the distinguished pairing and exchanges the other two, so in [L220](../findings/second-order.md)'s coordinates it is $(x,y,z)\mapsto(x,z,y)$, whose fixed line is $(2,-1,-1)$. On $\Pi_{Q_3}$ it is the identity. Taking all three swaps, the fixed locus in the three shape planes is $\psi_a\in\{0,\pi\}$ for every $a$, a DISCRETE set. *In [r1070](REVIEW_r1070.md)'s parametrisation $\psi=0$ is the shape $(2,-1,-1)$ and $\psi=\pi$ is $(-2,1,1)$, so the $+$ and $-$ branches are precisely the two components of this reflection locus, which is why they are antipodal rather than merely opposite.*

**On the block the same swap carries a sign, and that is what makes the ansatz close.** $\sigma_1$ sends $e_{12}\odot e_{34}\mapsto-e_{12}\odot e_{34}$ and exchanges the other two pairing vectors, so on $V_{Q_a}$ it acts as MINUS the coordinate reflection. Each block plane therefore splits into a $+1$ line spanned by $(0,1,-1)$ and a $-1$ line spanned by $w_a=(2,-1,-1)$.

**The span of the three $w_a$ lines with the swap-fixed part of $\mathcal D_n$ is a SUBALGEBRA.** $\sigma_3$ fixes $w_1$, negates $w_2$ and negates $w_3$, so $\sigma_3(w_1\circ w_2)=-(w_1\circ w_2)$, which puts $w_1\circ w_2$ on the $-1$ line of $V_{Q_3}$, that is on $\mathrm{span}(w_3)$. And $w_a\circ w_a$ has $\Pi_{Q_a}$-coordinates $(6,-3,-3)\propto(2,-1,-1)$ by [L220](../findings/second-order.md) step 2's $x=2a^2-b^2-c^2$, which is the $\psi_a=0$ line. *Criticality is the ALGEBRAIC equation $W\circ W=\theta W$, so for $W$ in a subalgebra every component of it transverse to that subalgebra reads $0=0$ and no condition is lost.* **So $\psi_a\equiv0$ is not a codimension-three demand, it is a component of an invariant locus on which the system is square and $\psi_a\equiv0$ holds identically.**

**And the three perpendicular equations there are not one equation, they are none.** Both sides of $(\theta-2L_{q_a})\nu_a=2\nu_b\circ\nu_c$ lie on the $w_a$ line, the left because $w_a$ is an eigenvector of $L_{q_a}$ at $\psi_a=0$ and the right by the character computation above. *The perpendicular component is $0=0$ identically.* **So the post's "one equation in one unknown" inside the ansatz and "three in three" outside it are both wrong, and the count that carries the conclusion is zero equations in zero unknowns.**

## C1: the count, and why the post's version argues the other way

**The honest global count is square and says nothing about $\psi$.** The unknowns on $\mathcal S$ are $D\in\mathcal D_n$ and $\nu_a\in V_{Q_a}$, that is $\dim\mathcal D_n+6$ real numbers, against $\dim\mathcal D_n$ equations from $D\circ D+\sum_a\nu_a\circ\nu_a=\theta D$ and $6$ from the three block equations, each living in a two-dimensional space by [L120](../findings/second-order.md). *Squareness at that level is the generic statement that critical points of a cubic on a sphere are isolated, and it is not a fact about this stratum.*

**[r1070](REVIEW_r1070.md)'s "six equations in six angles" is a DIFFERENT system, and the post inherits its scope silently.** That count freezes $N_a$, $u_a$, $t$ and $\tau$, promotes the three shape angles to unknowns of the BLOCK system, and drops the $\mathcal D_n$ equation entirely apart from one scalar shadow which [F75](../findings/fence-posts.md) itself shows is dependent. *The $\psi_a$ are properties of $D$ and are fixed by the equation that was dropped, so the two counts are not two readings of one system.*

**Inside r1070's own count the three parallel equations are already spent.** Pairing the block equation with $\nu_a$ gives the pinning, which on the equal-$N_i$ diagonal is $\cos2\beta_a=u_{\mathrm{lo}}/u$ and determines each $\eta_a$ from $\psi_a$ up to a sign. So the only continuous unknowns the three PERPENDICULAR equations have left are the three $\psi_a$ themselves. **Fixing $\psi_a\equiv0$ then leaves three equations in zero unknowns, overdetermined by three, which is the very count the post says is unavailable.** *The post's sentence is not a weaker version of the right argument, it is the wrong one, and the reason it does not bite is C2's symmetry rather than anything in the count.*

## C5: REFUTED, the $\nu$-angles are a function of the shape angles up to a sign

**The block equation relates them, and the relation is explicit.** With $\beta_a$ the angle of $\nu_a$ from the top eigenvector of $L_{q_a}\vert_{\mathbf1^\perp}$, the eigenvalues being $\pm\tfrac{\sqrt3}2u$ gives $\langle L_{q_a}\nu_a,\nu_a\rangle=\tfrac{\sqrt3}2u\cos2\beta_a\,N_a$, and [L221](../findings/second-order.md)(b) step 2 sets that equal to $\tfrac\theta2N_a-\tau$. On the equal-$N_i$ diagonal with $\tau=f\cdot\tfrac12s^3$ and $N_a=s^2$ this is
$$\cos2\beta_a\;=\;\frac{\theta-fs}{\sqrt3\,u}\;=\;\frac{u_{\mathrm{lo}}}{u},$$
which is [r1070](REVIEW_r1070.md)'s own M3 identity. **The half-rate map then puts the eigenframe at $\gamma_a=\tfrac\pi2+\tfrac{\psi_a}2$, so $\eta_a=\tfrac\pi2+\tfrac{\psi_a}2\pm\beta$ with $\beta$ a function of $(s,f,u)$ alone.**

**So "the $\nu$-angles are independent of the shape angles" is false, and the correction is one line.** Equal shapes force the three $\nu_a$ to equal angles up to the three signs of $\beta$ and the three signs of $\nu_a$ itself, a discrete choice of at most eight positions and not a free angle apiece. *The clause was folded into [F75](../findings/fence-posts.md) from [r1072](REVIEW_r1072.md) and [r1074](REVIEW_r1074.md) marked it PLAUSIBLE pending this reader. It does not survive.* **The conclusion it was used for, that the collapse is an ansatz, survives for the different reason in C2: the collapse is a symmetry locus, and a solution is not obliged to lie on one.**

## C4: the record excludes nothing there, and $\psi_a\equiv0$ is the most favoured shape

**Under the Gram constraint it is the best point available.** [r1070](REVIEW_r1070.md)'s $\Phi(c)=\tfrac3{10}(\sum_ac_a)^2-\tfrac12\sum_ac_a^2\ge K$ with $c_a=\cos\psi_a$ has $\Phi(1,1,1)=\tfrac65$, its maximum, while $K=3-t/u^2$ runs from $0.548$ to $1.2$ over the surviving set. *So $\psi_a\equiv0$ satisfies the shape constraint with the most slack at every point of the window, and at $s_*$ it is essentially the only admissible shape, the confinement there being $\lvert\psi_a\rvert\le0.77^\circ$.*

**And the three survival conditions are conditions on $(s,f,u)$ rather than on $\psi$.** $f\ge f_{\mathrm{Gram}}(s)$, $d(s,f)>0$ and $F(u)<0$ never mention the shape angle. **So the question F75 answers does arise, and the post is right that nothing on the record closes it.** *What closes it is the configuration's own $f$, below.*

## C6: the conclusion CONFIRMED, and the exclusion it asks for

**The cross-block product, reconstructed here.** The record states $\lVert\nu_1\circ\nu_2\rVert^2=\tfrac12A$ with $A=a_1^2a_2^2+(b_1b_2+c_1c_2)^2+(b_1c_2+c_1b_2)^2$ ([the $\tau$-positive note](2026-09-14-I104-tau-positive.md)) and [r1060](REVIEW_r1060.md) repairs the sign of the third slot to $+\tfrac12(b_1c_2+c_1b_2)$. In $Q_3$'s pairing coordinates that fixes
$$\nu_1\circ\nu_2=\tfrac12\big(-a_1a_2,\;b_1b_2+c_1c_2,\;b_1c_2+c_1b_2\big),$$
**the minus on the first slot being forced rather than chosen**: $(b_1+c_1)(b_2+c_2)=a_1a_2$ under Bianchi, so only that sign lands the product back in $V_{Q_3}$. *Four checks pass: the stated norm, Bianchi closure, [r1060](REVIEW_r1060.md)'s equality case $a_1=a_2=0$, $b=-c$ giving $(0,B,-B)$ parallel to $\nu_3$ with $f=1$ exactly, and full symmetry of $T(\nu_1,\nu_2,\nu_3)=-a_1a_2a_3+b_1b_2b_3+c_1c_2b_3+c_2c_3b_1+c_3c_1b_2$, verified term by term under both transpositions.*

**Then $f$ at $\psi_a\equiv0$ is a function of the three $\beta_a$ alone.** Writing a unit $\nu_a$ at angle $\beta_a$ from the $\psi_a=0$ top eigenvector in the orthonormal frame $\tfrac12(0,1,-1)$, $\tfrac1{2\sqrt3}(2,-1,-1)$ gives coordinates $(A_a,B_a,C_a)=\big(\tfrac2{\sqrt3}\cos\beta_a,\ \sin\beta_a-\tfrac1{\sqrt3}\cos\beta_a,\ -\sin\beta_a-\tfrac1{\sqrt3}\cos\beta_a\big)$ and
$$f\;=\;\frac{2\tau}{\sqrt{N_1N_2N_3}}\;=\;\tfrac14\Big[-A_1A_2A_3+B_1B_2B_3+C_1C_2B_3+C_2C_3B_1+C_3C_1B_2\Big].$$
*Calibration: at $\beta_a\equiv\tfrac\pi2$, which is $\nu_a\propto(0,1,-1)$ and $\psi_a\equiv\pi$, this returns $f=1$ exactly, the product bound's equality case. So the $-$ branch is where $\tau$ is maximal, and the $+$ branch is not.*

**At exact alignment $f=\pm\tfrac1{\sqrt3}$**, the sign being free because flipping one $\nu_a$ leaves $\nu_a\circ\nu_a$ and therefore every $\psi_a$ untouched.

**The pinning confines $\beta$ to $\lvert\beta_a\rvert<45^\circ$.** $u_{\mathrm{lo}}=(\theta-fs)/\sqrt3>0$ throughout, since $fs\le s_*<\theta$, and $u\ge u_{\mathrm{lo}}$, so $\cos2\beta_a=u_{\mathrm{lo}}/u\in(0,1]$.

**On that range the maximum of $f$ is exactly $1/\sqrt3$, at $\beta\equiv0$.** Screened on a $241^3$ grid over $[-45^\circ,45^\circ]^3$ with all eight sign patterns, and on an equal-$\lvert\beta\rvert$ sweep at $0.01^\circ$: $f$ falls monotonically from $0.577350$ at $0^\circ$ to $0.570352$ at $5.4755^\circ$ and $0.500000$ at $30^\circ$. *The unconstrained maximum $f=1$ sits at $\beta\equiv90^\circ$, which the pinning forbids: it would need $u_{\mathrm{lo}}<0$, that is $f>\theta/s\ge2.62$.*

**And the Gram floor alone beats that everywhere on the window.** $f_{\mathrm{Gram}}(s)=(\theta-\sqrt{5t/3})/s$ is strictly increasing on $(s_{\mathrm{lo}},s_*]$, from
$$f_{\mathrm{Gram}}(s_{\mathrm{lo}})=0.5942737976\quad\text{to}\quad f_{\mathrm{Gram}}(s_*)=1,$$
computed at forty digits, against $1/\sqrt3=0.5773502692$. **The tightest margin is $0.0169$, a relative $2.85\%$, at the window's left endpoint, and it widens to $0.42$ at $s_*$.** *The deficit floor is the higher of the two for every $s<0.441973$, so over most of the window the true margin is larger still.*

> **SO THE $+$ BRANCH'S SYMMETRIC POINT IS EXCLUDED, BY THE MAGNITUDE OF $f$.** *This is exactly the shape of exclusion [post F75](../findings/fence-posts.md) says a successor must find, and the post is vindicated in saying counting will not produce it.* **It is a positive claim and it is NOT folded by this review**: it needs its own Gate 2, and the scope below is part of what a reviewer must attack.

**Scope, and what a reviewer of that claim must check.**

- **The product formula is reconstructed, not read off a primary derivation.** Four independent constraints pin it and all four hold, but the record's own presentation of $\nu_1\circ\nu_2$ has already carried one wrong sign ([r1060](REVIEW_r1060.md)), and a second reader should rebuild it from the structure constants rather than from this file.
- **Equal-$N_a$, equal-$u_a$ diagonal only.** Off it [r1061](REVIEW_r1061.md) exhibits $2\tau/N_1>\theta$, where $u_{\mathrm{lo},1}<0$ and the $\lvert\beta_a\rvert<45^\circ$ step fails. *That is the same scope [F75](../findings/fence-posts.md) already carries for the invertibility of $\theta-2L_{q_a}$, and the $(s,f)$ parametrisation IS that ansatz.*
- **It excludes the point $\psi_a\equiv0$ and not yet a neighbourhood.** $f$ is continuous in $(\psi,\beta)$ and the Gram confinement tightens to $\lvert\psi_a\rvert\le0.77^\circ$ at $s_*$, so a bounded optimisation of $f$ over the confined $(\psi,\beta)$ box would extend this from a point to a sub-interval of $s$. **That run is named here and not started**: it is a sweep over a parameter range under the standing rule, and it would be evidence for a positive claim rather than a screen.

## C3: the heuristic, used in the safe direction only

**"Counting cannot exclude" is a legitimate negative and it holds.** The post needs no more than that, and C2 supplies a stronger version of it: the locus is invariant, so the naive codimension-three reading of $\psi_a\equiv0$ is void.

**"Predicts a solution" is an overclaim and this case shows why.** A square polynomial system is routinely inconsistent, and here the ansatz is rigid enough to be evaluated rather than guessed at: it pins $u=u_{\mathrm{lo}}$ exactly, pins $f$ to $1/\sqrt3$, and then fails the Gram floor. *Generic position predicted a solution and there is none.*

## Lean

| claim | status |
|---|---|
| `HamiltonsCubic.I111Tradeoff.cubic_expand` | verified as briefed, and the redundancy it supports is untouched by anything here |
| the counting claim | still not typed, and C2 explains why it resists: the content is that a locus is $\circ$-invariant, which is typable, while "a square system has a solution" is not a theorem to type |
| **newly typable** | $f=1/\sqrt3$ at $\beta\equiv0$ and $f=1$ at $\beta\equiv\tfrac\pi2$ are finite algebra over an ordered field, as is $f_{\mathrm{Gram}}(s_{\mathrm{lo}})>1/\sqrt3$. The maximum of $f$ over $\lvert\beta_a\rvert<45^\circ$ wants a certificate and is not a grid result to type |

## What the parent owes

1. **[fence-posts.md](../findings/fence-posts.md)'s "$\nu$-angles are independent of the shape angles"**, which C5 refutes outright. The pinning is the record's own L221(b) step 2 and it ties them.
2. **The two counts in the same paragraph**, "one equation in one unknown" and "three in three", both replaced: at $\psi_a\equiv0$ the perpendicular equations are identically satisfied.
3. **The cyclic rotation replaced by the within-pair swaps** as the reason the collapse is available, since the rotation alone leaves $\psi$ free and argues the other way.
4. **The $f=1/\sqrt3$ exclusion routed to its own round.** *It closes what F75 says is left of I111's $+$ branch, and it should not enter the record on a reviewer's arithmetic.*
