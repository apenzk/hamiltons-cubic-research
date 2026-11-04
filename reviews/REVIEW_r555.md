# Review r555, Lemma L54, the two diagonals and rigidity at $t=2$

Reviewer r555, independent adversarial audit. Target: `Lemma L54, the two diagonals, and rigidity at $t=2$` in [findings/bispectral.md](../findings/bispectral.md), together with the section `Both-sided Schur–Horn and the vertex-matrix budget are the SAME wall` that the block points at.

Analysis only: computation requires per-task approval this reviewer does not have. Anything reported as a screen is a screen, never evidence for a positive claim.

Status: COMPLETE. Overall, the lemma is true, its numbered block is refuted as written and repaired by one clause; the audit's substantive result is D4, that the record's cap on $\mu$ is strictly slack at every odd $n$ and the odd-$n$ shortfall it calls permanent closes.

## Conventions fixed before deriving

Read [conventions.md](../findings/conventions.md) in full. What it supplies, and what it does not.

| symbol | what conventions.md fixes | status for L54 |
| --- | --- | --- |
| pairing on $\Lambda^2$ | $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal | fixed |
| pairing on $S^2_0$ |, | **absent**; forced to plain Frobenius by $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$ having norm $1$ |
| $\mathring W$ | Li's $iklj$: $(\mathring Wh)_{ij}=\sum_{kl}W_{iklj}h_{kl}$ | fixed, and load-bearing for the sign of the $\varphi$-diagonal |
| $K$, $t$ | $K$ symmetric hollow, $K_{ab}=W_{abab}$; $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$, the **ordered** sum | fixed |
| $\mu$, $\omega$ | $\mu=\mathop{\mathrm{spec}}(M)$ on $\Lambda^2$ at $\lVert M\rVert_F=1$, $\omega=\mathop{\mathrm{spec}}(\mathring W)$; $\sum\mu^2=1$, $\sum\omega^2=3$ | fixed, with a live collision, see D5 |
| $\theta_0(n)$ | $\theta_0(n)^2=2(n-1)(n-2)/n^2$ | fixed |
| $\Theta_n$ | the **diagonal** maximum; $=\theta_0(n)$ at even $n$, $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd | fixed |
| $M(n)$, $W5$ | global maximum of $P$ on the unit sphere; $\Theta_n\le M(n)$ | fixed, and unused by L54 |
| $\{\varphi_{ij},\psi_k\}$ |, | **absent from conventions.md**, and this is a finding (F1) |

**F1, the Nienhaus–Petersen–Wink basis is named in the lemma and defined in no conventions row.** It is recoverable: [bispectral.md](../findings/bispectral.md) lines 41 and 234 give $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$ and cite NPW Prop 3.10, and [the reference notes](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md) quote the proposition in full. Recoverable is weaker than fixed, and the whole of the defect below is a question about which basis the symbol $\psi_k$ names.

**F2, a symbol collision the conventions table creates.** conventions.md's $\varphi_{ab}=E_{ab}-E_{ba}$ is a **bivector** in $\Lambda^2$; L54's $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$ is a **symmetric** tensor in $S^2_0$. Both appear in the one sentence of L54, of the two different spaces, and only the phrase "of $S^2_0$" separates them.

## The two diagonals, rebuilt from the definitions, CONFIRMED

Neither identity is quoted below; both are derived from Li's $iklj$ order.

**The $\varphi$-diagonal.** Put $h=\varphi_{ab}=(E_{ab}+E_{ba})/\sqrt2$, so $h_{kl}=(\delta_{ka}\delta_{lb}+\delta_{kb}\delta_{la})/\sqrt2$. Then $(\mathring Wh)_{ab}=(W_{aabb}+W_{abab})/\sqrt2=K_{ab}/\sqrt2$, the first term dying on antisymmetry in the first pair, and $(\mathring Wh)_{ba}=(W_{baba}+W_{bbaa})/\sqrt2=K_{ab}/\sqrt2$. Hence $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle=\tfrac1{\sqrt2}\big(K_{ab}/\sqrt2+K_{ab}/\sqrt2\big)=K_{ab}$. **CONFIRMED.** *The index order is what fixes the sign: in the order $ikjl$ the surviving term is $W_{abba}=-K_{ab}$, so the same computation returns $-K$. The record is in Li's order, so $+K$ is right for it.*

**The $\psi$-block.** Put $h=\mathop{\mathrm{diag}}(v)$, $h'=\mathop{\mathrm{diag}}(w)$, both traceless. Then $(\mathring Wh)_{ij}=\sum_kW_{ikkj}v_k$ and $\langle\mathring Wh,h'\rangle=\sum_{i,k}W_{ikki}v_kw_i=-\sum_{i,k}K_{ik}v_kw_i=-w^{\mathsf T}Kv$, using $W_{ikki}=-W_{ikik}=-K_{ik}$ and $W_{iiii}=0$. So the compression of $\mathring W$ to the traceless diagonal subspace is exactly $-K\vert_{\mathbf1^\perp}$. **CONFIRMED**, and it is an operator identity, carrying no basis with it.

**The $\Lambda^2$ diagonal.** $\langle M\varphi_{ab},\varphi_{ab}\rangle=W_{abab}=K_{ab}$ under the half-trace pairing conventions.md fixes, which is the definition of the curvature operator. **CONFIRMED.**

**Hypotheses each identity actually needs.** The $\varphi$-diagonal needs the pair symmetries alone. The $\psi$-block needs the pair symmetries alone. **Neither needs $K\mathbf1=0$, hollowness, or Ricci-flatness**, those enter only at the norm count below.

**F3, answering the brief's question (6): the claim is a theorem and the record has only a citation and a measurement.** [bispectral.md](../findings/bispectral.md) offers NPW Prop 3.10 for the $\varphi$ half and "checked at random Weyl tensors, $n=5,6,7$, to $2\times10^{-16}$" plus [run_both_diagonals.py](../scripts/runs/run_both_diagonals.py) for the $\psi$ half. The four lines above settle both at every $n$ and every $W$. **The label Lemma is now earned; before this it was earned by proxy.**

## The norm count, CONFIRMED, and its hypotheses named

$\sum d_\varphi^2=\sum_{a<b}K_{ab}^2=\tfrac12\sum_{a\ne b}K_{ab}^2=t/2$. **The brief's worry that this needs $\sum_aK_{aa}^2=0$ is answered by the definition rather than by a hypothesis**: conventions.md defines $K$ as *hollow* and $t$ as the sum over $a\ne b$, and hollowness is forced anyway by $W_{aaaa}=0$.

$\sum_i\lambda_i(-K\vert_{\mathbf1^\perp})^2=\mathop{\mathrm{tr}}(K^2)-0=\lVert K\rVert_F^2=t$, **and this half does need $K\mathbf1=0$**, it is what puts $K$'s missing eigenvalue at $0$ rather than at some $\lambda\ne0$ that $\mathop{\mathrm{tr}}(K^2)$ would then have to be debited by. $K\mathbf1=0$ is automatic on $\mathcal W_n$: total trace-freeness gives $\sum_kW_{ikjk}=0$, and $i=j$ is $\sum_kK_{ik}=0$.

So $\sum d^2=\tfrac t2+t=\tfrac32t$, **for the eigenvector reading of $d_\psi$, and for that reading only.** That qualifier is the defect below.

## D1, REFUTED as written, REPAIRED: the block names a basis in which its own norm identity is false

**The claim.** "In the Nienhaus–Petersen–Wink basis $\{\varphi_{ij},\psi_k\}$ of $S^2_0$ ... Consequently $\sum d_\varphi^2=t/2$ and $\sum d^2=\tfrac32t$ for the full $S^2_0$ diagonal $d$."

**The NPW basis is an explicit basis of the frame, carrying no dependence on $W$.** [Prop 3.10](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md), quoted from the paper: $\psi_k\propto\big({-}(n{-}k)\,e^k\otimes e^k+\sum_{l>k}e^l\otimes e^l\big)$, $k=1,\dots,n-1$, a staircase basis of the traceless diagonal matrices, determined by the ordered frame $e_1,\dots,e_n$ and nothing else. In that basis $d_{\psi_k}=-\psi_k^{\mathsf T}K\psi_k$ is a **diagonal entry** of $-K\vert_{\mathbf1^\perp}$, so $\sum_kd_{\psi_k}^2\le\lVert K\rVert_F^2=t$ with equality **exactly when $K$ is diagonal in that basis**. The block's $\sum d^2=\tfrac32t$ therefore holds in the named basis only for the $K$ that the named basis happens to diagonalise.

**Witness, at $n=4$, coordinate-diagonal, $t=2$, the exact configuration the rigidity clause is about.** Take the diagonal Weyl tensor with sectional matrix

$$K=\tfrac12\begin{pmatrix}0&1&-1&0\\1&0&0&-1\\-1&0&0&1\\0&-1&1&0\end{pmatrix},$$

hollow, symmetric, $K\mathbf1=0$, and $\sum_{a<b}K_{ab}^2=1$, so $\lVert W\rVert=1$ and $t=\lVert K\rVert_F^2=2$. Its NPW $\psi$-vectors at $n=4$ are $(-3,1,1,1)/\sqrt{12}$, $(0,-2,1,1)/\sqrt6$, $(0,0,-1,1)/\sqrt2$, giving

$$d_\psi=\big(0,\ -\tfrac12,\ +\tfrac12\big),\qquad \textstyle\sum d_\psi^2=\tfrac12\quad\text{against the required } t=2 .$$

Hence $\sum d^2=\tfrac t2+\tfrac12=\tfrac32$, **half of the claimed $\tfrac32t=3$**. The eigenvalues of $K$ are $(1,0,0,-1)$, so the eigenvector reading gives $\sum d_\psi^2=2=t$ and $\sum d^2=3$ as the section intends. *Every number above is a three-line hand computation; a screen reproduced $\sum d^2=1.5$ against $3.0$ and is corroboration, not the evidence.*

**Why the failure is guaranteed at $t=2$ rather than accidental.** For coordinate-diagonal $W$ the operator is $(\mathring Wh)_{ij}=K_{ij}h_{ij}$ off the diagonal and $(\mathring Wh)_{ii}=-\sum_kK_{ik}h_{kk}$ on it. So the $\varphi$'s **are** eigenvectors, but the $\psi$-block is $-K\vert_{\mathbf1^\perp}$ with $K$ hollow and nonzero, and **a hollow nonzero matrix is never diagonal in the frame's own basis**. The named basis therefore fails to diagonalise the $\psi$-block at every $t=2$ point of every dimension, and $t=2$ is the only place the block uses the identity.

**REPAIR, one clause.** The section already has it: "*Taking the $\psi$'s as $K$'s eigenvectors on $\mathbf1^\perp$*", and "*$d_\psi=-\{\text{eigenvalues of }K\text{ on }\mathbf1^\perp\}$*". The block must say the same, the $\psi_k$ are an orthonormal **eigenbasis of $K$ on $\mathbf1^\perp$**, which is a $W$-dependent choice inside the frame, and Schur–Horn is untouched by the change because $\omega\succ d$ holds for the diagonal in *any* orthonormal basis.

**What survives.** Everything, once the clause is in. The two operator identities (D-free), $\sum d_\varphi^2=t/2$ (basis-free, the $\varphi$'s being fixed), and the rigidity, see D2.

**Verdict D1: REFUTED as stated, REPAIRED by naming the eigenbasis.** It is a defect of the numbered block and of its copy in [results.md](../results.md) line 728, not of the section, which states the adapted choice correctly.

## D2, the rigidity step is CONFIRMED, and the record proves it the long way round

**The brief's question (1): which reading, and is the stronger one true?** Both readings are true, and the stronger one is the cheaper.

- **Multiset reading.** $x\succ y$ with $\sum x_i^2=\sum y_i^2$ gives $x^\downarrow=y^\downarrow$, by the equality case of Karamata against the strictly convex $u\mapsto u^2$. So $\mu$ and $d_\varphi$ agree as multisets, and $\omega$ and $d$ agree as multisets. **CONFIRMED.**
- **Vector reading.** For a symmetric $A$ with diagonal $d$ in an orthonormal basis, $\sum_id_i^2=\lVert A\rVert_F^2$ **is** the vanishing of every off-diagonal entry. So at $t=2$, $\sum d_\varphi^2=1=\lVert M\rVert_F^2$ makes $M$ diagonal in the $\varphi$-basis, and $\sum d^2=3=\lVert\mathring W\rVert_F^2$ makes $\mathring W$ diagonal in $\{\varphi_{ij},\psi_k\}$; the diagonal is then the spectrum entry for entry. **The stronger reading is true, and it needs neither Schur–Horn nor Karamata**, one line from the Frobenius norm.

**So the block's "forcing $\mu=d_\varphi$ and $\omega=d$ outright" is right, and understated.** *The record reaches it through majorization plus strict convexity, which is a detour: majorization is what makes the inequality $\sum d^2\le\sum\omega^2$ available in general, but at $t=2$ the equality is read straight off $\lVert\mathring W\rVert_F^2$.* **CONFIRMED.**

**One consequence worth stating, because the block does not.** The vector reading says the $t=2$ rigidity is exactly "$\mathring W$ is diagonal in the $W$-adapted NPW basis", which for the $\psi$-block means $K$ diagonal in the $\psi$'s, **which is why D1's repair is forced rather than cosmetic**: in the unadapted NPW basis the conclusion is false about a true statement.

## D3, the frame quantifier, and an unnamed dependency

**$t$ is per-frame and the block mixes the two readings.** [conventions.md](../findings/conventions.md) warns in bold: "*$t$ IS PER-FRAME UNLESS SAID OTHERWISE ... Write $t_F$ when the frame is fixed and $t=\max_Ft_F$ when it is not.*" L54 writes $\sum d^2=\tfrac32t$, where $K$, $d$, $d_\varphi$ are all built in one frame and $t$ must be $t_F$; then "with equality exactly when $W$ is coordinate-diagonal in **some** frame", which is the extremal reading $\max_Ft_F$. **The two are used in one sentence under one symbol.** The conclusion survives ($t_F=2$ for some $F$ and $\max_Ft_F=2$ are equivalent, and the rigidity is then run in that $F$) but the sentence as written is the trap conventions.md names. *Repair: $t_F$ throughout, and "$\max_Ft_F\le2$ with equality exactly when $W$ is coordinate-diagonal in some frame; in such a frame $t_F=2$".*

**L54 is not a leaf.** Its rigidity clause consumes $t\le2$ with its equality case, which is **[Lemma L94](../findings/bispectral.md)**, "$\kappa^2\le2\lVert M\rVert_F^2$, with equality exactly when $W$ is coordinate-diagonal in some frame", $\kappa^2=\max_F\lVert K(F)\rVert_F^2$, Gate 2 confirmed. **L54's block names neither L94 nor conventions.md for it**, so a reader meets the input as an assertion. *Re-derived here, both directions: $\lVert\mathop{\mathrm{diag}}_\varphi M\rVert^2\le\lVert M\rVert_F^2$ with equality iff every off-diagonal $\varphi$-entry vanishes, which is coordinate-diagonality in that frame; $\max_F$ is attained, $O(n)$ being compact. **CONFIRMED**, and the record's one-line proof is the right one.* *Aside: conventions.md calls this step "Cauchy–Schwarz", where it is the weaker fact that a subsum of squares is at most the full sum, harmless, and a mislabel.*

**Quantifiers, settled.** The two operator identities and $\sum d_\varphi^2=t/2$ hold **for every $n\ge4$, every $W\in\mathcal W_n$, every orthonormal frame**, no criticality, no Ricci-flatness beyond what $\mathcal W_n$ carries, no dimension restriction. The $\psi$-half of the norm count adds $K\mathbf1=0$, which $\mathcal W_n$ supplies. The rigidity clause adds $t_F=2$.

## D4, REFUTED: "its reach is EVEN $n$, and the shortfall at odd $n$ is permanent"

This is the section's own headline, [bispectral.md](../findings/bispectral.md) line 282. **The cap it bounds is correct; the permanence is false, the identification with the cited external proof is false at every odd $n$, and the estimate the record's chief consumer actually takes is the one the section says it cannot supply.**

### The cap itself, CONFIRMED, re-derived cold

$\mu:=-\omega_{\min}$. The bottom unit eigenvector $h$ of $\mathring W$ is traceless symmetric, so in its own eigenframe $F$ it is $\mathop{\mathrm{diag}}(v)$ with $\sum v_i=0$, $\sum v_i^2=1$, and by the $\psi$-block identity derived above $\omega_{\min}=\langle\mathring Wh,h\rangle=-v^{\mathsf T}K^Fv$, hence $\mu=v^{\mathsf T}K^Fv\le\mu_1(K^F)$. With $\lambda_1\ge\dots\ge\lambda_{n-1}$ the spectrum of $K^F$ on $\mathbf1^\perp$: $\sum\lambda_i=0$, $\sum\lambda_i^2=t_F$, so $\lambda_1^2=\big(\sum_{i\ge2}\lambda_i\big)^2\le(n-2)(t_F-\lambda_1^2)$, giving $\mu_1(K^F)\le\sqrt{t_F(n-2)/(n-1)}\le\sqrt{2(n-2)/(n-1)}$, using $t_F\le2$ frame by frame. **CONFIRMED**, both the bound and the equality case ($\lambda_2=\dots=\lambda_{n-1}$).

### The record's cap **cannot be attained at odd $n$**, proved

**Take the equality case seriously.** $\mu_1(K)=\sqrt{t(n-2)/(n-1)}$ forces $\lambda_2=\dots=\lambda_{n-1}=-\lambda/(n-2)$ with $\lambda=\lambda_1>0$, and forces the top eigenvalue simple (multiplicity $\ge2$ would give $\lambda=-\lambda/(n-2)$, so $\lambda=0$ and $t=0$). Writing $u$ for the unit top eigenvector, $u\perp\mathbf1$,

$$K=\lambda\,\frac{n-1}{n-2}\,uu^{\mathsf T}-\frac{\lambda}{n-2}\Big(I-\tfrac1nJ\Big),\qquad\text{so}\qquad K_{aa}=\frac{\lambda(n-1)}{n-2}\Big(u_a^2-\frac1n\Big).$$

**$K$ is hollow**, so $u_a^2=1/n$ for every $a$, so $u=\varepsilon/\sqrt n$ with $\varepsilon\in\{\pm1\}^n$; **and $u\perp\mathbf1$ then reads $\sum_a\varepsilon_a=0$, which is impossible at odd $n$.** At even $n$ it is exactly the balanced sign vector, and substituting gives $K_{ab}=\lambda/(n-2)$ within blocks and $-\lambda/n$ across, **the two-block sectional pattern of $S^{n/2}\times S^{n/2}$**, whose row sums cancel identically.

**So the section's numerical remark ("*$\mu$ attaining the cap exactly at the balanced ones*"), is a theorem, and it comes with the parity.** The cap is strictly slack at every odd $n$, by compactness of $\{K\in\mathcal D_n:\lVert K\rVert_F^2\le2\}$. *The section reads its own shortfall as a property of $\Theta_n$; it is a property of the cap.*

### The exact maximum, and it closes the odd case

**The step that loses at odd $n$ is that the eigenvalue argument throws hollowness away**, using only $\mathop{\mathrm{tr}}K=0$ and $K\mathbf1=0$. Keep it. $K^F$ lies in the **vertex space** $\mathcal D_n=\{K\text{ symmetric, hollow},K\mathbf1=0\}$ that [conventions.md](../findings/conventions.md) already names, so with $P$ the orthogonal projection of symmetric matrices onto $\mathcal D_n$,

$$\mu=\langle K^F,vv^{\mathsf T}\rangle=\langle K^F,P(vv^{\mathsf T})\rangle\le\lVert K^F\rVert_F\,\lVert P(vv^{\mathsf T})\rVert_F=\sqrt{t_F}\,\lVert P(vv^{\mathsf T})\rVert_F .$$

**And $\lVert P(vv^{\mathsf T})\rVert_F$ is closed-form.** For $\lVert v\rVert=1$, $v\perp\mathbf1$, solving $P(vv^{\mathsf T})_{ab}=v_av_b-\alpha_a-\alpha_b$ ($a\ne b$) against hollowness and zero row sums gives $\alpha_a=\big(\tfrac1{2n-2}-v_a^2\big)/(n-2)$ and

$$\lVert P(vv^{\mathsf T})\rVert_F^2=\langle vv^{\mathsf T},P(vv^{\mathsf T})\rangle=1+\frac1{(n-1)(n-2)}-\frac{n}{n-2}\,M_4(v),\qquad M_4(v)=\sum_av_a^4 .$$

*Checked against the even-$n$ extremiser: at $v=\varepsilon/\sqrt n$, $M_4=1/n$ and the expression collapses to $(n-2)/(n-1)$, reproducing the record's cap; and building $P(vv^{\mathsf T})$ entrywise there gives $1/(n-1)$ within blocks, $-(n-2)/(n(n-1))$ across, whose Frobenius norm is $(n-2)/(n-1)$ by direct count. The two routes agree.*

**So the whole parity question is one scalar**: $\min\{M_4(v):\lVert v\rVert=1,\sum v_a=0\}$. At even $n$ it is $1/n$, attained at the balanced sign vector, and the two caps coincide, **which is why the loss is invisible at even $n$**. At odd $n$ the sign vector is inadmissible and $M_4>1/n$ strictly, so the cap improves.

**With the two-value vector** ($k=\tfrac{n+1}2$ entries at $x$, $\tfrac{n-1}2$ at $y$, $\sum v=0$, $\lVert v\rVert=1$) one gets $M_4=\dfrac{n}{k(n-k)}-\dfrac3n=\dfrac{n^2+3}{n(n^2-1)}$, and substituting,

$$\mu^2\ \le\ 2\Big(1+\tfrac1{(n-1)(n-2)}-\tfrac{n}{n-2}\cdot\tfrac{n^2+3}{n(n^2-1)}\Big)=\frac{2n^2(n-3)}{(n-2)(n^2-1)}=\Big(\frac{n}{n-1}\Theta_n\Big)^2 ,$$

the last equality by direct substitution of $\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}$. **Equivalently $\tfrac{n-1}n\mu\le\Theta_n$ at odd $n$, exactly the shortfall the section calls permanent, and it closes.** *Numerator check: $(n-2)(n^2-1)+(n+1)-(n^2+3)=n^3-3n^2=n^2(n-3)$.*

**Status of each piece.** The identity for $\lVert P(vv^{\mathsf T})\rVert_F^2$, the equality analysis forcing even $n$, and the two-value evaluation are **derived here and checkable by hand**. The one step that needs the minimality of $M_4$ over *all* admissible $v$ is supplied by the literature the record already holds (see below) and a screen over $n=4,\dots,13$ agreed with the two-value value to $3\times10^{-7}$. *That screen is a screen and is not evidence for the bound.*

### The document the section cites already proves the odd case

an outside progress report (unpublished, held in the private record) carries a **parity-sensitive fourth-moment lemma**, marked proved, stating exactly $M_4(v)\ge1/n$ at even $n$ and $\ge\tfrac{n^2+3}{n(n^2-1)}$ at odd $n$, with the equality cases, proved by a three-coordinate smoothing reduction to two values and the same $M_4=\tfrac n{k(n-k)}-\tfrac3n$. It then states the general second-kind projection estimate as $\boxed{\tfrac{n-1}n\mu\le\Theta_n\lvert W\rvert}$ **at both parities**, with $\lvert Z(h)\rvert^2=\tfrac{n^2-3n+3}{2(n-1)(n-2)}-\tfrac{n}{2(n-2)}M_4(v)$, *which is one half of the $\lVert P(vv^{\mathsf T})\rVert_F^2$ derived above, since $\tfrac{n^2-3n+3}{(n-1)(n-2)}=1+\tfrac1{(n-1)(n-2)}$.* **Two routes, built without reference to one another, giving the same function of $M_4$.**

**Three consequences for the record.**

1. **"which is exactly the second-kind projection estimate ... that [the external report] proves at its line 601" ([bispectral.md](../findings/bispectral.md) line 280) is FALSE at every odd $n$.** Line 601 is the *even* branch; the report's projection estimate is the $\Theta_n$ form, strictly stronger at odd $n$. The record identifies its weaker statement with the stronger one.
2. **"the shortfall at odd $n$ is permanent" is REFUTED**, and so is "*something other than the $\lVert K^F\rVert_F^2\le2$ budget must supply it there*", the budget supplies it, once hollowness is kept.
3. **A consumer is outside the record's hypotheses.** [target.md](../findings/target.md) line 266 runs the dichotomy $\mathrm{CD}_n$ on "*the reported projection estimate $\tfrac{n-1}n\mu\le\Theta_n$*". At odd $n$ that is **not** what bispectral.md proves, and the record nowhere flags that the consumer is drawing on the external document rather than on its own cap. *The answer is that the stronger form is true, but the record must prove or cite it, not inherit it silently through a false identification.*

**Verdict D4: REFUTED, with the repair derived.** The remedy is one substitution: bound $\mu$ by Cauchy–Schwarz against $\mathcal D_n$ rather than by a Rayleigh quotient followed by an eigenvalue-spread estimate.

## D5, the pointer reaches only half the argument

The block says "*the argument is in this file under 'Both-sided Schur–Horn and the vertex-matrix budget are the SAME wall'*". That section, [bispectral.md](../findings/bispectral.md) lines 254–296, carries the two diagonal identities, $\sum d^2=\tfrac32t$, and the cap. **The rigidity clause (the half the lemma's title advertises), is at line 305, under the *next* heading**, "Both-sided Schur–Horn: the two diagonals rebuilt, and a first attempt that does NOT settle it". A reader following the pointer finds the diagonals and stops one section short of the rigidity. *Repair: name both headings, or move the rigidity paragraph.*

## D6, the section's explanation of the basis sensitivity is backwards

> "*A reimplementation that picked the wrong basis inside $K$'s degenerate eigenspaces fails to reproduce the identity, which is a fact about that basis choice and not about $d$.*"

**Inside a degenerate eigenspace the choice cannot matter.** If $K\vert_{\mathbf1^\perp}$ restricted to an eigenspace $E_\lambda$ is $\lambda\,\mathrm{Id}$, then $\psi^{\mathsf T}K\psi=\lambda$ for **every** unit $\psi\in E_\lambda$, so every orthonormal basis of $E_\lambda$ returns the same diagonal entries. What breaks the identity is a basis vector that **mixes different eigenspaces**, which is exactly what the fixed NPW $\psi$'s do, and D1's $n=4$ witness is the demonstration. **The sentence names the one basis freedom that is harmless and misses the one that is fatal**, and it is the sentence a reader would consult to learn what hypothesis $\sum d^2=\tfrac32t$ needs.

## D7, "identically in $n$" against "at EVEN $n$ only": the brief's question (5), settled

**The identity is unconditional.** $\tfrac{n\theta_0(n)}{n-1}=\tfrac{\sqrt{2(n-1)(n-2)}}{n-1}=\sqrt{\tfrac{2(n-2)}{n-1}}$, for every $n\ge3$, no parity anywhere. **So "identically in $n$" is right and "at EVEN $n$ only" is wrong as written**, the section is conflating an algebraic identity that always holds with a relevance that holds at even $n$ only, exactly as the brief suspects.

**The mechanical cause is visible in the source.** The bolded "**at EVEN $n$ only**" and its paragraph were inserted between the display and the sentence that completes it, leaving "*since $\theta_0(n)$ is the value [conventions.md](../findings/conventions.md) fixes*" stranded as a fragment beginning with "since". *Repair: move the parity paragraph after the completing clause and open it "What is parity-dependent is whether $\theta_0(n)$ is the value to beat".*

**The inserted arithmetic is correct.** $\mathrm{cap}^2\big/\big(\tfrac n{n-1}\Theta_n\big)^2=\tfrac{2(n-2)}{n-1}\cdot\tfrac{(n-1)(n+1)(n-2)}{2n^2(n-3)}=\tfrac{(n-2)^2(n+1)}{n^2(n-3)}=\tfrac{n^3-3n^2+4}{n^3-3n^2}$, $>1$ for $n>3$. **CONFIRMED**, and by D4 the right reading of that ratio is that the cap is slack at odd $n$ rather than that the target is out of reach.

## D8, the $\mu$ collision, live inside this one section

[conventions.md](../findings/conventions.md) flags that "*$\mu$ carries two meanings thirty lines apart in bispectral.md*". **Both are in the section under audit, and a third joins them.**

| line | expression | meaning |
| --- | --- | --- |
| 252, 305 | $\mu\succ d_\varphi$, $\sum\mu^2=1$ | the $\Lambda^2$ **spectrum** |
| 258, 272–280 | $\mu=-\omega_{\min}$, $\mu\le\sqrt{2(n-2)/(n-1)}$ | the **scalar** bottom of $\mathring W$ |
| 258, 272 | $\mu_1(K)$, $\mu_1(K^F)$ | the top **eigenvalue of $K$** |

**L54's own sentence uses the first; the cap four lines above it uses the second.** The lemma is comprehensible only because $\succ$ forces the spectral reading. *This is not a new defect, it is the collision conventions.md already tables, but the audit confirms it is unrepaired at the site the table names, and it now spans three objects rather than two.*

## Retractions, checked, and one is incomplete

| retraction the section carries | complete? |
| --- | --- |
| "*the earlier claim here that $\mu$ is uncapped was FALSE*" | **complete.** No occurrence of the uncapped claim survives in [findings/](../findings/), [results.md](../results.md) or [plan-verification.md](../plan-verification.md); plan-verification.md line 130 quotes the cap in its proved form. |
| "*the earlier denial here was wrong*", that $d$ is a genuine $\mathring W$ diagonal | **complete** in the file; the denial appears nowhere. |
| "*the two spectra do not couple usefully through a shared frame*" (Lemma L52's heading) | **flagged rather than fixed**, at line 73 and in [LEDGER.md](../findings/LEDGER.md) line 329 and [INDEX-results.md](../findings/INDEX-results.md) row 52. The heading still states the refuted claim; a reader who greps headings gets the false version. |
| the parity restriction added by reviewer 132 | **INCOMPLETE, and D4 is why.** It was added as a scope limit; it is a defect of the cap, and it left line 280's identification with the external proof standing and [target.md](../findings/target.md) line 266's consumer unexamined. |

*One further parity marker for whoever repairs this: [Lemma L93](../findings/bispectral.md) at line 347 is "sharp at even $n$" with "a perfect-matching extremiser", a perfect matching, like a balanced sign vector, does not exist at odd $n$. **The same mechanism, and possibly the same slack.** Recorded as a lead, not a claim.*

## What cites it, and whether the use is inside the hypotheses

Grepped on the statement rather than the identifier, `d_\varphi`, `\succ d`, `\prec \mu`, `3t/2`, `\tfrac32t`, the NPW basis phrase, and "projection estimate".

| site | what it takes | inside the hypotheses? |
| --- | --- | --- |
| [bispectral.md](../findings/bispectral.md) 41, 87 and [results.md](../results.md) 712 | $K\prec\mu$, $K'\prec\omega$ from the frame dictionary | **yes**, majorization alone, true in any orthonormal basis. *But all three write $K=(W_{ijij})_{i<j}$, the unordered index-set form conventions.md warns reads as $\sum K^2=t/2$.* |
| [bispectral.md](../findings/bispectral.md) 152 | $\omega\succ d$ cuts the relaxation $2.947$ | **yes**, majorization only |
| [bispectral.md](../findings/bispectral.md) 234 | $\omega\succ d$ "for the diagonal $d$ in that basis" | **yes**, and it is the one site that correctly declines to claim $\sum d^2=\tfrac32t$ |
| [bispectral.md](../findings/bispectral.md) 258 | $-d_{\min}=\max\{\max_{a<b}(-K_{ab}),\mu_1(K)\}$, hence $\mu\ge\mu_1(K)$ | **yes in context, no from the block.** It reads $d_\psi$ as $K$'s eigenvalues; in the fixed NPW basis $\min d_\psi>-\mu_1(K)$ in general and the chain fails |
| [bispectral.md](../findings/bispectral.md) 305 | the rigidity, run from $\sum d^2=3t/2$ | **yes in context**, the $\psi$'s are declared eigenvectors two bullets above |
| [results.md](../results.md) 728, [report/sections/06b-bispectral.tex](../report/sections/06b-bispectral.tex) 131 | the block verbatim | **no**, D1 travelled with it, into the report |
| [results.md](../results.md) 252 | "at $t=2$ both majorizations are equalities" | conclusion true; the route it names is D1's |
| [target.md](../findings/target.md) 266 | $\tfrac{n-1}n\mu\le\Theta_n$ | **no at odd $n$**, see D4(3). The record proves the $\theta_0(n)$ form only |
| [plan-verification.md](../plan-verification.md) 130 | $\mu\le\sqrt{2(n-2)/(n-1)}=1.3484$ at $n=12$ | **yes**, even $n$, where the two caps agree |

**No consumer uses the vector reading of $\mu=d_\varphi$** in a way the weaker multiset reading would not support; by D2 the vector reading is true anyway.

## Verdicts

| # | defect | verdict |
| --- | --- | --- |
|, | $\varphi$-diagonal of $\mathring W$ is $K$; $\psi$-block is $-K\vert_{\mathbf1^\perp}$; $\varphi$-diagonal of $M$ is $K$ | **CONFIRMED**, derived from Li's $iklj$ order, every $n\ge4$ and every $W\in\mathcal W_n$ |
|, | $\sum d_\varphi^2=t/2$ | **CONFIRMED**; needs hollowness, which is in the definition |
| D1 | $\sum d^2=\tfrac32t$ "in the Nienhaus–Petersen–Wink basis" | **REFUTED as stated, REPAIRED.** $n=4$ witness at $t=2$ gives $\tfrac32$ against $3$. The $\psi_k$ must be an eigenbasis of $K$ on $\mathbf1^\perp$ |
| D2 | rigidity at $t=2$, both readings | **CONFIRMED**, and the vector reading is the cheaper one |
| D3 | $t$ per-frame against extremal; $t\le2$ as an unnamed input | **REPAIRED**, write $t_F$, and cite [Lemma L94](../findings/bispectral.md), re-derived here |
| D4 | "its reach is EVEN $n$, and the shortfall at odd $n$ is permanent" | **REFUTED.** The cap's equality case forces $n$ even; Cauchy–Schwarz against $\mathcal D_n$ gives $\tfrac{n-1}n\mu\le\Theta_n$ at odd $n$; the cited external document already proves it |
| D5 | the block's pointer | **REPAIRED**, the rigidity is one heading further on |
| D6 | "wrong basis inside $K$'s degenerate eigenspaces" | **REFUTED**, the degenerate case is the harmless one |
| D7 | "identically in $n$" vs "at EVEN $n$ only" | **REFUTED**: the identity is unconditional; the relevance is not. The wrong sentence is "**at EVEN $n$ only**" |
| D8 | $\mu$ in three meanings inside the section | **CONFIRMED** as a live collision |
| F1 | the NPW basis defined in no conventions row | **finding** |
| F2 | $\varphi$ meaning a bivector in conventions.md and a symmetric tensor in L54 | **finding** |
| F3 | the $\varphi$-diagonal claim rested on a citation plus a script | **repaired here** by derivation |

### Overall

**Lemma L54 is TRUE and its numbered block is REFUTED as written.** The mathematics is sound in the section; the block, and the two copies of it in [results.md](../results.md) and [report/sections/06b-bispectral.tex](../report/sections/06b-bispectral.tex), name a basis in which their own norm identity is false, and they fail in it precisely at the $t=2$ point the lemma is about. **One clause repairs all three.** Everything else the block asserts is confirmed, and two of its steps are now proved rather than measured.

**The audit's substantive result is D4**, which is about the section rather than the block: the record's unconditional cap on $\mu$ is **sharp at even $n$ and strictly slack at every odd $n$**, because the eigenvalue-spread step discards the hollowness of $K$. Restoring it, one Cauchy–Schwarz against the vertex space $\mathcal D_n$ that [conventions.md](../findings/conventions.md) already defines, yields $\tfrac{n-1}n\mu\le\Theta_n$ at both parities, which is the form [target.md](../findings/target.md)'s dichotomy has been consuming all along.

### The computation this audit did not run, and what it would decide

Everything above is derived except one scalar: that $\min\{\sum_av_a^4:\lVert v\rVert=1,\sum_av_a=0\}$ equals $\tfrac{n^2+3}{n(n^2-1)}$ at odd $n$ rather than merely being bounded above by it. **The record already holds a proof**, the parity-sensitive fourth-moment lemma of an outside progress report (unpublished, held in the private record), by a three-coordinate smoothing reduction to two values, so the open work is to **transcribe and audit that half-page**, not to compute anything. *Were it wanted numerically instead, a sweep would decide only whether a three-valued critical point beats the two-valued one, and a negative result would still be a screen. It is not needed.* **No computation is requested.**
