# VERIFY_v203, Observation L22, cold read

**Standfirst.** The brief [BRIEF_L22.md](BRIEF_L22.md) was read cold, before any other file. **No numerical work was done**, no script, no Sage, no Python, no numeric evaluation. Every figure below that is not a closed form was obtained by hand arithmetic on an object I constructed to screen a claim I was about to record, is labelled **[screen]** where it appears, and is never offered as evidence for a positive claim. Log at [agent_logs/verify-L22-v203.log](../agent_logs/verify-L22-v203.log).

## Claim table

| # | claim, as the record states it | verdict |
| --- | --- | --- |
| 1 | $f'(\varphi)=3\sin\varphi\,\tilde f(\varphi)$ with $\tilde f(\pi/6)=(5\alpha+\sqrt3\gamma-3)/4$, so the required estimate is $\gamma_{\max}(\alpha)<\frac{3-5\alpha}{\sqrt3}$ | **CORRECT, derived independently from the source; the word "exactly" carries one unstated hypothesis** |
| 2 | at $\alpha=\tfrac13$ the right side is $4/(3\sqrt3)$, and this is what Nienhaus's own bound returns, borderline by construction | **CORRECT, and sharper than the record knows: I derived $g_1(\alpha)=(1+\alpha)\sqrt{1-2\alpha}$ in closed form and $g_1(\tfrac13)=4/(3\sqrt3)$ exactly** |
| 3 | the maximiser has $W_2$ **entirely** in $\ker F_u$ ($c_0=1$) | **GAP, asserted, never derived, and the block's own table gives the force that pushes $c_0$ off $1$** |
| 4 | $s^2=3\varepsilon$ an equality | **CORRECT AND FREE, it is forced by the exact $\alpha$-identity once $c_0=1$; it is not an extra assumption, and it is not in tension with Gate 2's "$s$ ranges over an interval"** |
| 5 | $M_{W_1}\cdot\Pi_{\ker}Q(W_1)=0$ makes the inner problem a hard-case trust-region problem, globally solvable | **CORRECT, AND THE IMPORT IS UNNECESSARY, the frontier follows in four lines from self-adjointness alone; no trust-region theorem is needed and none is cited** |
| 6 | $V(t)$, $t^*=\tfrac34\sqrt{5/6}=\sqrt{30}/8$, $\alpha^*=32/141$, $A$ pinned at $\sqrt{5/6}$ | **ALL FOUR EXACT, I re-derived $V$, $t^*$ and $\alpha^*$ from scratch; the frontier is the ellipse arc $\tfrac{A^2}{5/6}+\tfrac{B}{2/3}=1$, and every printed value on it checks** |
| 7 | "$V=\min$ of the two [branches]" | **BROKEN, false as an identity; the correct reason for tangency is the one in the same sentence, and this clause spoils it. Propagated to [ATTEMPTS.md](../ATTEMPTS.md), [lean/INDEX.md](../lean/INDEX.md) and [L22.lean](../lean/HamiltonsCubic/Results/L22.lean)** |
| 8 | "this one covers $\alpha\ge0.2270$ at every $n$", i.e. $\alpha^*$ is the frontier branch's coverage endpoint | **BROKEN, $\alpha^*$ is where $V$'s two branches meet, not where the bound stops covering. The bound is valid and strong for every $\alpha\in(0,\tfrac13)$** |
| 9 | Nienhaus's bound reaches $\alpha\le0.3223$ at $n=12$ and $0.2350$ at $n=100$, falling with $n$ | **CORRECT, I derived his branch in closed form and both figures are its endpoint to five decimals [screen]** |
| 10 | the branches overlap for every $n\ge12$, worst margin $+0.0074$ at $\alpha\approx0.223$ in the limit | **THE FIGURE IS RIGHT AND THE PRIOR AUDIT'S OBJECTION TO IT IS REFUTED**, $+0.0074$ at $\alpha\approx0.2228$ is exactly $\min_\alpha\max(\text{margin}_N,\text{margin}_F)$ at $c=2/\sqrt3$ [screen]. **The overlap itself is HYPOTHESIS-DEBT: monotonicity in $n$ is unproved on the record** |
| 11 | the vanishing is verified at $n=12,14,16$; $n=20,24$ checked by zero-padding, "which gives monotonicity in $n$ as a lower bound" | **THE MECHANISM IS STATED CORRECTLY AND ITS DIRECTION IS USELESS**, padding bounds the two constants from *below*, and the estimate needs them from *above*. The scope paragraph does not say this |
| 12 | "Both branches use the sphere-product value as their constant, so the estimate is conditional on the conjecture at critical points past $n=12$" | **UNDERSTATED. The theorem being repaired assumes Conjecture A twice more, in places the block never names**, Nienhaus §4.5's standing sentence and Theorem 4.19's second case |
| 13 | the composite: "Theorem 4.17's estimate is repaired for all $n\ge12$" | **ASSUMPTION OF THE CONCLUSION at $n\ge12$, in the strict sense, not merely conditional** |

**One line.** The mathematics inside this block is better than the record believes, the reduction, the borderline, the frontier, $t^*$, $\alpha^*$ and the $+0.0074$ margin are all exactly right and I re-derived every one of them from scratch, but the block asserts its one optimisation step ($c_0=1$) without argument, mislabels $\alpha^*$ as a coverage endpoint (which is what generated the record's standing "the two figures do not sit together" flag, itself now refuted), and repairs a theorem whose own standing hypothesis at $n\ge12$ is Conjecture A, so the composite assumes the conclusion.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- **The competitor and its linearisation**, *"$u=W_{\mathbb{CP}^2}$ padded to unit norm, $\theta^*=P(u)=\sqrt{3/2}$, $F_u(h)=\tfrac12(uh+hu)+u\#h$ … **$\alpha$ in [L21](../findings/route-a.md) and [L20](../findings/route-a.md) is $\sqrt{2/3}\langle F_uV,V\rangle$**, a Rayleigh quotient transverse to $\mathbb Ru$ and the orbit, not the $\alpha$ parametrising the competitor family $W_{\mathcal S^4(\alpha)}$ in the same file."*
- **The trilinear form**, *"the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$"*. **This total symmetry is load-bearing three separate times below** and is cited at none of them.
- **The sphere-product constant**, *"$\theta_0(n)$ … **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** It is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$ … **The gloss 'the value at the balanced sphere product' stood here until 2026-09-04 and is what regrew [L0](../findings/problem.md)'s refuted constant**; the target of Problem P is $\Theta_n$."*
- **Padding**, *"Padding commutes with $Q$, and preserves both the norm and $\theta$."* This is the whole content of the $n=20,24$ claim and is checked against it in §6.
- **$t$, and $K$**, *"$K$ is the symmetric hollow $n\times n$ **sectional matrix**, $K_{ab}=W_{abab}$ … and $t=\lVert K\rVert_F^2$ … Then $t\le2$"*. **L22 uses both letters for different objects**; see §8.
- **The $\circ$ product**, *"$X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$"*.

## The hypothesis inventory

Everything the block's conclusion rests on, with where each is discharged. **A pass with no inventory is not a pass**; this is the inventory.

| # | hypothesis | stated in the block? | discharged where |
| --- | --- | --- | --- |
| H1 | $T$ is totally symmetric | **no** | [conventions.md](../findings/conventions.md); used in the $f(\varphi)$ expansion, in $\langle F_uW,W\rangle=T(u,W,W)$, and in the self-adjointness of $M_{W_1}$ |
| H2 | $f'(\varphi)=3\sin\varphi\,\tilde f(\varphi)$ and $\tilde f(\pi/6)=(5\alpha+\sqrt3\gamma-3)/4$ | asserted | **derived here, §1**, from [Nienhaus](../references/nienhaus-2023-second-best-einstein/) L4728–4745 |
| H3 | $\tilde f$ is increasing on $(0,\pi/6)$ | **no** | needed for "the estimate required is **exactly**"; Nienhaus supplies it, the block does not, §1 |
| H4 | $\alpha\le\tfrac13$ | asserted ("for every $\alpha<\tfrac13$") | [Lemma L21](../findings/route-a.md); *and [results.md](../results.md):41 still calls this an undischarged condition* |
| H5 | the splitting $(\mathbb Ru\oplus T_u\mathcal O)^\perp=V_{1/3}\oplus V_{\le0}$ | **no** (assumed by "Writing $W=\cos\beta W_1+\sin\beta W_2$") | route-a.md's Remark 4.18 paragraph, from Nienhaus Thm 4.14(a),(b) + Rmk 4.16 |
| H6 | $P\equiv0$ on $V_{1/3}$; $T(W_1,W_1',N)=0$; $T(W_1,K,N)=0$ | **no** | the $n=10$ table, 50 lines up. **Without all three the reduction to two couplings $A,B$ is false**, and the block claims to "stand alone" |
| H7 | $\mu_N\in[-1,-\tfrac16]$ | **no** | the earlier derivation. **Stated there and then never used**, since $c_0=1$ removes the $N$ channel, see §3 |
| H8 | the maximiser has $c_0=1$ | asserted | **nowhere. §3.** |
| H9 | $\sup T(W_1,W_1,K)=\sqrt{5/6}$ and $\sup T(W_1,K,K)=2/3$, both $n$-independent | asserted | measured at $n=10$; the first has a closed form resting on a further measured claim ($\max\lVert Q(x)\rVert=1$ on $V_{1/3}$). **Neither is measured at $n=12,14,16$** |
| H10 | $M_{W_1}\Pi_{\ker}Q(W_1)=0$ for **every** $W_1\in V_{1/3}$ | asserted, with a residual | [Observation L102](../findings/route-a.md): 40 random draws at $n=12$, fewer at $14,16$ |
| H11 | $M_{W_1}$ is self-adjoint on $\ker F_u$ | **no** | follows from H1. **$M_{W_1}$ is defined nowhere on the record**, §8 |
| H12 | both suprema in H9 are attained at the same $W_1^*$ | asserted | nowhere. **Needed only for "the frontier is exact", not for the bound**, §4 |
| H13 | $\sup\{P(K):K\in\ker F_u,\lVert K\rVert=1\}\le\theta_0(n)$ | as "the sphere-product value" | **Conjecture A. §7.** |
| H14 | $\max\{P(W):W\in\mathrm{Weyl}^1_n\}\le\theta_0(n)$, over the whole sphere | **no** | **Conjecture A again**, and this one is Nienhaus's, not the block's, §7 |
| H15 | Nienhaus's branch endpoint falls with $n$ | asserted from three values | nowhere. **§5 gives the closed form that would discharge it** |

## 1. The reduction, derived in full, and it is right

The block asserts two things and derives neither. Both are in the source, at [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404):4728–4745, and I derived them from the definition rather than reading them off.

Nienhaus sets $f(\varphi)=\sqrt{2/3}\,P(\cos\varphi\,u+\sin\varphi\,W)$ for unit $W\perp\mathbb Ru\oplus T_u\mathcal O$. Expanding the cubic by H1,

$$f(\varphi)=\cos^3\varphi\cdot\sqrt{\tfrac23}P(u)+3\cos^2\varphi\sin\varphi\cdot\sqrt{\tfrac23}T(u,u,W)+3\cos\varphi\sin^2\varphi\cdot\sqrt{\tfrac23}T(u,W,W)+\sin^3\varphi\cdot\sqrt{\tfrac23}P(W).$$

The first coefficient is $\sqrt{2/3}\,\theta^*=\sqrt{2/3}\sqrt{3/2}=1$. The second vanishes: $Q(u)=\theta^*u$ at the critical point $u$, so $T(u,u,W)=\langle Q(u),W\rangle=\theta^*\langle u,W\rangle=0$. The third is $\alpha$ and the fourth $\gamma$ **by the conventions' own definitions**, note that $\sqrt{2/3}\langle F_uW,W\rangle=\sqrt{2/3}T(u,W,W)$ needs H1 and nothing else. So

$$f(\varphi)=\cos^3\varphi+3\alpha\cos\varphi\sin^2\varphi+\gamma\sin^3\varphi,$$

which is the source's display verbatim. Differentiating,

$$f'(\varphi)=-3\cos^2\varphi\sin\varphi+3\alpha(2\cos^2\varphi\sin\varphi-\sin^3\varphi)+3\gamma\sin^2\varphi\cos\varphi=3\sin\varphi\big[(2\alpha-1)\cos^2\varphi-\alpha\sin^2\varphi+\gamma\sin\varphi\cos\varphi\big].$$

Substituting $\sin^2=1-\cos^2$ and $2\sin\varphi\cos\varphi=\sin2\varphi$,

$$\tilde f(\varphi)=(3\alpha-1)\cos^2\varphi+\tfrac12\gamma\sin2\varphi-\alpha .$$

At $\varphi=\pi/6$: $\cos^2=\tfrac34$ and $\sin(\pi/3)=\tfrac{\sqrt3}2$, so

$$\tilde f(\pi/6)=\tfrac34(3\alpha-1)+\tfrac{\sqrt3}4\gamma-\alpha=\frac{9\alpha-3-4\alpha+\sqrt3\gamma}{4}=\frac{5\alpha+\sqrt3\gamma-3}{4}.$$

**Exactly the block's expression.** And $\tilde f(\pi/6)<0\iff\sqrt3\gamma<3-5\alpha\iff\gamma<\frac{3-5\alpha}{\sqrt3}$, so the block's identification of the required estimate is correct.

**The one correction: "exactly" is one hypothesis short.** What the displayed estimate delivers is $f'(\pi/6)<0$, a single point. Theorem 4.17 needs $f'<0$ on the whole of $(0,\pi/6)$, and the bridge is that $\tilde f$ is *increasing* there, which is H3, Nienhaus's own next sentence, and absent from the block. It is not free: $\tilde f'(\varphi)=(1-3\alpha)\sin2\varphi+\gamma\cos2\varphi$, whose second term needs $\gamma\ge0$ on $(0,\pi/6)$ where $\cos2\varphi>0$. So the honest form of the claim is *"the estimate required is $\gamma_{\max}(\alpha)<\frac{3-5\alpha}{\sqrt3}$ together with $\gamma\ge0$"*, or with $\gamma$ replaced by its own upper bound before $\tilde f$ is formed, as the source does. **Benign at the parameters in play and wrong as a use of the word "exactly".**

## 2. The borderline at $\alpha=\tfrac13$, correct, and the record does not know how correct

$(3-5\cdot\tfrac13)/\sqrt3=(3-\tfrac53)/\sqrt3=\tfrac43/\sqrt3=\frac4{3\sqrt3}$. That much is arithmetic. **The load-bearing half of the sentence is that this is "precisely what his own bound returns", and I checked it against the source rather than believing it.**

Nienhaus bounds $\gamma$ by minimising $g_c(\varphi)=\dfrac{c-\cos^3\varphi-3\alpha\cos\varphi\sin^2\varphi}{\sin^3\varphi}$ over $\varphi$, the inequality $\gamma\le g_c(\varphi)$ being a rearrangement of $f(\varphi)\le c$; his $c$ is $1$, i.e. $\max P\le\sqrt{3/2}$. Writing $u=\cos\varphi$ and $N(u)=c+(3\alpha-1)u^3-3\alpha u$, $D(u)=(1-u^2)^{3/2}$, stationarity $N'D-ND'=0$ reduces, after dividing by $3(1-u^2)^{1/2}$, to

$$\big[(3\alpha-1)u^2-\alpha\big](1-u^2)+u\big[c+(3\alpha-1)u^3-3\alpha u\big]=0\ \Longleftrightarrow\ (1-\alpha)u^2-cu+\alpha=0 .$$

**At $c=1$ this factors as $\big((1-\alpha)u-\alpha\big)(u-1)=0$, giving $\cos\varphi_0=\frac{\alpha}{1-\alpha}$, the source's own value**, which is the check that my stationarity condition is his. Substituting $x=\frac\alpha{1-\alpha}$ into $N$ gives $N=1-3x^2+2x^3=(1-x)^2(1+2x)$ and $D=\big((1-x)(1+x)\big)^{3/2}$, so

$$g_1(\alpha)=\frac{(1-x)^{1/2}(1+2x)}{(1+x)^{3/2}}=(1+\alpha)\sqrt{1-2\alpha}.$$

At $\alpha=\tfrac13$ this is $\tfrac43\cdot\tfrac1{\sqrt3}=\frac4{3\sqrt3}$, **equal to the requirement, exactly, and only there**: at $\alpha=0$ it is $1$ against a requirement of $\sqrt3$. So *"borderline by construction, so the larger constant forced above $n=11$ breaks it, and only near $\alpha=1/3$"* is correct in every clause, and the equality is an identity rather than a numerical coincidence.

*The extraction renders $g_1$ as $\sqrt{1-2\alpha(1+\alpha)}$, which is $\tfrac13$ at $\alpha=\tfrac13$ and would make the sentence false. **It is an OCR fault (the $(1+\alpha)$ has fallen inside the radical**) and a reader checking the block against the transcript rather than against the derivation will conclude the block is wrong. Recorded here so the next reader does not pay for it twice.*

## 3. "The configuration is forced", the equality is free, and the forcing is not

Two claims are welded together in one sentence and they have opposite standing.

**The $\alpha$-identity, which I re-derived.** With $W=\cos\beta\,W_1+\sin\beta\,W_2$, $W_1\in V_{1/3}$, $W_2=c_0K+c_-N$ and $c_0^2+c_-^2=1$, the cross term $\langle F_uW_1,W_2\rangle=\tfrac13\theta^*\langle W_1,W_2\rangle$ vanishes, so $\langle F_uW,W\rangle=\cos^2\beta\cdot\tfrac13\theta^*+s^2c_-^2\mu_N\theta^*$ and, multiplying by $\sqrt{2/3}=1/\theta^*$,

$$\alpha=\frac{1-s^2}{3}+s^2c_-^2\mu_N .$$

**At $c_0=1$ the second term is absent and this reads $\varepsilon:=\tfrac13-\alpha=\tfrac{s^2}3$, i.e. $s^2=3\varepsilon$ identically.** So the brief's suspicion, that an equality is a much stronger claim than the inequality $s^2\le6\varepsilon/(3-c_0^2)$ recorded upstream, resolves in the record's favour: **the equality is a consequence of $c_0=1$, not an independent assertion**, and it is not in conflict with Gate 2 Reviewer 19's correction that *"$s$ ranges over an interval rather than sitting at an endpoint"*, which is a statement about the general-$c_0$ problem. The debt is entirely in $c_0=1$.

**And $c_0=1$ is asserted.** The block says *"the maximiser has $W_2$ lying entirely in $\ker F_u$"*; the upstream block says *"Its maximiser is always $c_0=1$"*. **Neither carries an argument, and the sentence immediately before the upstream assertion says the two effects "pull against each other".** Worse, the block's own table supplies the force pushing $c_0$ off $1$: the $3\cos\beta\sin^2\beta$ coefficient of the cubic is

$$T(W_1,W_2,W_2)=c_0^2\,T(W_1,K,K)+2c_0c_-\,T(W_1,K,N)+c_-^2\,T(W_1,N,N)\le\tfrac23c_0^2+\sqrt{\tfrac23}\,c_-^2,$$

and $\sqrt{2/3}=0.8165$ **exceeds** $2/3$. So that term is maximised at $c_0=0$, while the leading term and the constraint both favour $c_0=1$. This is a genuine two-sided optimisation and the record settles it by fiat.

**What is actually true, to leading order.** As $\varepsilon\to0$ the objective is $3sc_0A+O(s^2)$ with $s^2\le6\varepsilon/(2+c_-^2)$, so the leading term is proportional to $\sqrt{(1-\rho)/(2+\rho)}$ in $\rho=c_-^2$, whose derivative is $-3/(2+\rho)^2<0$: **$c_0=1$ wins near $\alpha=\tfrac13$, and that much is a proof.** Away from $\tfrac13$ nothing is proved. *[screen]* At $\varepsilon=15/141$ (i.e. $\alpha=\alpha^*$) hand evaluation of the lossy bound at $\rho=0,\,0.2,\,1$ gives $1.835$, $1.668$, $0.601$, consistent with $c_0=1$; three points on one $\varepsilon$ establish nothing and are reported only as the screen that stopped me writing a counterexample.

**The finding.** `GAP`. What would have to be proved: *for every $\varepsilon\in(0,\tfrac13]$ the joint maximum over $(\rho,\mu_N,K,N,W_1)$ of $3\cos^2\beta\sin\beta\sqrt{1-\rho}\,A+3\cos\beta\sin^2\beta\,[(1-\rho)B+\rho\,T(W_1,N,N)]+\sin^3\beta\,P(W_2)$, subject to $\varepsilon=s^2(\tfrac13-\rho\mu_N)$, is attained at $\rho=0$.* Until that is on file, the closed-form frontier of §4 is the value of a *restricted* problem and is not an upper bound for the estimate.

## 4. The frontier, every printed value re-derived, and the trust-region import is not needed

**What $M_{W_1}$ must be.** The symbol is defined nowhere in [findings/](../findings/) or [conventions.md](../findings/conventions.md), as [Observation L102](../findings/route-a.md)'s audit already records and as I confirmed by search. The only reading under which the block's sentences are all well formed is the self-adjoint operator on $\ker F_u$ representing the quadratic form $K\mapsto T(W_1,K,K)$, i.e. $M_{W_1}=\Pi_{\ker}\circ(W_1\circ\,\cdot\,)|_{\ker F_u}$, self-adjoint by H1. **The undefined symbol carries two readings and the difference matters**: $M_{W_1}q=0$ with $M$ projected is weaker than $W_1\circ q=0$ unprojected. **The derivation needs only the weaker one**, so the ambiguity resolves in the record's favour, but it resolves by luck, not by writing.

**The frontier, in four lines.** Write $q=\Pi_{\ker}Q(W_1)$, so that $A=T(W_1,W_1,K)=\langle q,K\rangle$ for $K\in\ker F_u$, and $B=T(W_1,K,K)=\langle M_{W_1}K,K\rangle$. The quantity the outer problem needs is $V(t)=\max\{A+tB:\lVert K\rVert=1\}$, I verified this reading against the block's own data points below. Decompose $K=\alpha_1\hat q+K^\perp$ with $K^\perp\perp q$. Since $M_{W_1}q=0$,

$$\langle M_{W_1}K,K\rangle=\langle M_{W_1}K^\perp,K^\perp\rangle\le\lambda_{\max}\lVert K^\perp\rVert^2=\lambda(1-\alpha_1^2),$$

and **equality is attainable because $q\in\ker M_{W_1}$ forces $q\perp E_{\lambda_{\max}}$ whenever $\lambda_{\max}\ne0$**, by self-adjointness. So with $a=\lVert q\rVert$ and $x=\alpha_1\in[-1,1]$,

$$V(t)=\max_{x\in[-1,1]}\big[a\,x+\lambda t\,(1-x^2)\big],\qquad a=\sqrt{5/6},\quad\lambda=\tfrac23 .$$

The stationary point is $x=\frac{a}{2\lambda t}$, which enters $[-1,1]$ exactly when $t\ge\frac{a}{2\lambda}=\frac{\sqrt{5/6}}{4/3}=\tfrac34\sqrt{\tfrac56}$. **That is $t^*$, on the nose**, and $\big(\tfrac34\big)^2\cdot\tfrac56=\tfrac{15}{32}=\tfrac{30}{64}=\big(\tfrac{\sqrt{30}}8\big)^2$, so the two printed forms of $t^*$ agree. Below $t^*$ the maximum sits at $x=1$, giving $V=a=\sqrt{5/6}$ with $B=0$, **which is the block's "$B=0$ exactly, with $A$ pinned at $\sqrt{5/6}$"**. Above $t^*$,

$$V(t)=\frac{a^2}{4\lambda t}+\lambda t=\frac{5/6}{(8/3)t}+\frac{2t}3=\frac5{16t}+\frac{2t}3 .$$

**Both branches of the printed $V$, and the breakpoint, out of one line of calculus.**

**The frontier curve, and the block's two data points.** Eliminating $x$: $A=a x$, $B=\lambda(1-x^2)$, so

$$\frac{A^2}{5/6}+\frac{B}{2/3}=1 .$$

Its endpoints are $(A,B)=(\sqrt{5/6},0)$ and $(0,\tfrac23)$, **the block's two measured suprema are exactly the two axis intercepts of one ellipse arc**, which is the structural fact the block never states. At $t=\tfrac34$: $x=\frac{a}{2\lambda t}=\frac{\sqrt{5/6}}{1}=\sqrt{5/6}$, so $A=a x=\tfrac56$ and $B=\lambda(1-\tfrac56)=\tfrac19$, **the printed exact values**. At $t=0.9$: $A=\frac{a^2}{2\lambda t}=\frac{5/6}{1.2}=\tfrac{25}{36}$ and $B=\tfrac23-\frac{5}{16\cdot0.81}=0.280864$, **the printed values again** *[screen for the decimal]*. **Every number on the frontier checks.**

**$\alpha^*=32/141$, derived.** With $c_0=1$: $s^2=3\varepsilon=1-3\alpha$ and $\cos^2\beta=1-s^2=3\alpha$, so $t^2=\tan^2\beta=\frac{1-3\alpha}{3\alpha}$. Setting $t^2=\tfrac{15}{32}$ gives $32(1-3\alpha)=45\alpha$, i.e. $141\alpha=32$:

$$\alpha^*=\tfrac{32}{141}=0.2269504\ldots$$

**Exact, and it consumes the $s^2=3\varepsilon$ equality of §3, if $c_0<1$ were admissible, $t$ would not be a function of $\alpha$ at all and $\alpha^*$ would not be defined.** This is the sharpest form of §3's gap: the block's own headline constant is undefined without the step it does not prove.

**The imported theorem, checked against the object.** The block says the vanishing *"makes the inner maximisation over $K$ a hard-case trust-region problem and so globally solvable"*. **No theorem is named and no source is cited, so there are no hypotheses to check against a statement**, which is itself the finding the brief asks for. Checking the standard result anyway (Forsythe–Golub / Gay / Moré–Sorensen: a quadratic-plus-linear objective on a Euclidean ball or sphere in a finite-dimensional real inner-product space, with the "hard case" being the linear term orthogonal to the extreme eigenspace): the hypotheses do hold here, finite dimension, $M_{W_1}$ self-adjoint by H1, the constraint the unit sphere of $\ker F_u$, and $M_{W_1}q=0$ giving $q\perp E_{\lambda_{\max}}$, **so this is not a repeat of the unital-algebra failure the brief warns of.** But the citation buys nothing: the derivation above uses only self-adjointness and one variable. **The right repair is to delete the import and print the four lines.**

**One claim in this paragraph is not needed and is not proved.** *"Its value is monotone in both constants and both suprema are attained at the same $W_1$"*. Monotonicity is immediate ($V$ increases in $a$ and in $\lambda$) and **that alone makes $V$ an upper bound, which is all the estimate uses**. Joint attainment (H12) is what would make the block's stronger claims (*"the frontier is exact, not estimated"*, *"the true maximum rather than an estimate"*), true, and it is asserted nowhere with an argument. **The load-bearing direction is safe; the boast is the unproved part.**

**And the tangency clause is false as written.** The block: *"the constant branch is the minimum of the other, since $a/t+bt$ with $a=\tfrac5{16}$, $b=\tfrac23$ minimises at $t^2=a/b=\tfrac{15}{32}$ … with minimum value squared $4ab=\tfrac56$, **so $V=\min$ of the two** and a minimum has zero slope."* The first half is right: $\min_t(a/t+bt)=2\sqrt{ab}=\sqrt{5/6}$ at $t^2=a/b=\tfrac{15}{32}$, and $4ab=4\cdot\tfrac5{16}\cdot\tfrac23=\tfrac56$. **The clause "$V=\min$ of the two" does not follow and is false.** Because $\tfrac5{16t}+\tfrac{2t}3\ge\sqrt{5/6}$ for *every* $t$, $\min\{\sqrt{5/6},\,\tfrac5{16t}+\tfrac{2t}3\}\equiv\sqrt{5/6}$, whereas $V(t)=\tfrac5{16t}+\tfrac{2t}3$ for $t>t^*$. Closed-form failure at a rational point: **at $t=1$, $\min=\sqrt{5/6}$ while $V(1)=\tfrac5{16}+\tfrac23=\tfrac{47}{48}$, and $\tfrac{47}{48}>\sqrt{5/6}$ since $47^2\cdot6=13254>5\cdot48^2=11520$.** No max reading rescues it either: $\max\{\sqrt{5/6},g(t)\}=g(t)$ everywhere, wrong below $t^*$. **The correct statement is that $V$ glues a constant to $g$ at $g$'s own minimiser, hence is $C^1$ there**, which the same sentence's own reason ("a minimum has zero slope") already delivers. *The false clause is reproduced verbatim in [ATTEMPTS.md](../ATTEMPTS.md):4541, in [lean/INDEX.md](../lean/INDEX.md):229 and in the docstring of [L22.lean](../lean/HamiltonsCubic/Results/L22.lean); none of that file's theorems states it, so the Lean check is unaffected.*

## 5. The two branches, is there a gap between $0.2270$ and the falling bound?

**No. And the reason there is no gap is that $\alpha^*$ is not the frontier branch's coverage endpoint, which is what the record says it is.**

**The bound that produces the headline numbers is nowhere on the record.** Assembling it from the block's own pieces, with $c_0=1$, $c=\cos\beta$, $s=\sin\beta$, $t=s/c$, $P(W_1)=0$ by H6:

$$\gamma=\sqrt{\tfrac23}\,P(W)=\sqrt{\tfrac23}\big[3c^2sA+3cs^2B+s^3P(K)\big]=\sqrt{\tfrac23}\big[3c^3t\,(A+tB)+s^3P(K)\big]\le\sqrt{\tfrac23}\big[3c^3t\,V(t)+s^3\theta_0(n)\big],$$

with $c^2=3\alpha$ and $s^2=1-3\alpha$ from §3. **This is not the $\gamma_{\text{coupled}}$ the record displays**: that one charges $\sup A$ and $\sup B$ separately and is exactly the lossy bound the frontier was introduced to replace, *[screen]* at $\alpha=0.223$ and $\theta_0=\sqrt2$ it returns $1.5226$ against a requirement of $1.0883$, so it covers nothing there. **The frontier bound is the block's real object and the block never writes it down.** Everything the block claims about coverage is a claim about a display that does not exist on the record.

**Nienhaus's branch, in closed form.** From §2, his branch covers $\alpha$ exactly when $\min_\varphi g_c(\varphi)<\frac{3-5\alpha}{\sqrt3}$, with $c=\sqrt{2/3}\,\theta_0(n)$, the same constant, which is what makes the block's *"both branches use the sphere-product value"* true, and with the minimiser the root in $[0,1]$ of $(1-\alpha)u^2-cu+\alpha=0$. *That $c$ is $\sqrt{2/3}\theta_0(n)$ and not something else is confirmed by [Observation L103](../findings/route-a.md)'s own headline, $c_{12}=1.009216785$: $\sqrt{2/3}\cdot\theta_0(12)=\sqrt{2/3}\sqrt{220/144}$ reproduces it.*

*[screen, hand arithmetic on the two closed forms above, reported as a screen and not as evidence]*

| $n$ | $c=\sqrt{2/3}\theta_0(n)$ | Nienhaus branch endpoint | frontier branch endpoint | record's figure |
| --- | --- | --- | --- | --- |
| $12$ | $1.009217$ | $\alpha\approx0.3223$ | far below $0.19$ | $0.3223$ ✓ |
| $100$ | $1.137365$ | $\alpha\approx0.2350$ |, | $0.2350$ ✓ |
| $\infty$ | $2/\sqrt3=1.154701$ | $\alpha\approx0.2261$ | $\alpha\approx0.197$ | "$\alpha\ge0.2270$" ✗ |

**Both of the record's Nienhaus figures are reproduced to five decimals by a formula I derived from the source, so those two figures are sound.** The third column is the news: the frontier bound is valid for every $\alpha\in(0,\tfrac13)$, and in the limit it still clears the requirement at $\alpha=0.20$ (margin $+0.00088$) while failing at $\alpha=0.19$ (margin $-0.0016$). **So the frontier branch reaches roughly $0.197$, well below Nienhaus's limiting $0.2261$, and the two intervals overlap on $[0.197,\,0.2261]$ with no gap anywhere.**

**And the record's own standing flag is refuted.** The block, [ATTEMPTS.md](../ATTEMPTS.md):4541 and [lean/INDEX.md](../lean/INDEX.md):229 all record that *"the worst-margin point is stated below its own branch"*, $0.223<32/141$, and leave it flagged. **The margin figure is right and the coverage claim is wrong.** $\min_\alpha\max(\text{margin}_N,\text{margin}_F)$ at $c=2/\sqrt3$ sits where the two margins cross: *[screen]* at $\alpha=0.22$ they are $+0.0134$ and $+0.0067$, at $\alpha=0.223$ they are $+0.0069$ and $+0.0074$, so they cross at $\alpha\approx0.2228$ with common value $\approx+0.00738$. **That is the record's "$+0.0074$ at $\alpha\approx0.223$ in the limit", to four decimals, and it is exactly the right quantity for an interval-covering claim to report.** The flag closes with one repair: **delete "covers $\alpha\ge0.2270$" and say instead that $\alpha^*=32/141$ is where $V$'s branches meet.**

**What remains a debt is the "for every $n\ge12$".** All three of the above are limit or spot values. The record itself books this: *"the overlap claim rests on an $n\to\infty$ limit with margin $+0.0074$ and no monotonicity proof"*. **The debt is smaller than it looks.** $g_c(\varphi)$ is manifestly increasing in $c$ at fixed $\varphi$, so $\min_\varphi g_c$ is; $\theta_0(n)^2=2(n-1)(n-2)/n^2$ has $\frac{d}{dn}\theta_0^2=\frac{2(3n-4)}{n^3}>0$; and the requirement $\frac{3-5\alpha}{\sqrt3}$ carries no $n$. Hence Nienhaus's covered set shrinks with $n$ and $c_n\uparrow2/\sqrt3$, so the limit case dominates every $n$. **I am not supplying this as a repair, one step is still missing, that the covered set is a down-set in $\alpha$ so that "endpoint" is even well defined**, but I am naming exactly what would have to be written: *(i) $\{\alpha:\min_\varphi g_{c}(\varphi)<\tfrac{3-5\alpha}{\sqrt3}\}$ is an interval unbounded below, (ii) it decreases in $c$, (iii) $c_n$ increases in $n$ with supremum $2/\sqrt3$, (iv) the same three for the frontier branch's $\theta_0(n)$.* That is `HYPOTHESIS-DEBT`, not `GAP`: the statement is elementary and the closed forms for it are in this report.

**The lower end of the parameter range is stated nowhere, and it is not empty.** The requirement is *"for every $\alpha<\tfrac13$"*, and $\alpha=\sqrt{2/3}\langle F_uW,W\rangle$ reaches $-1$ on the most negative eigenspace, so **negative $\alpha$ is in scope**. Under $c_0=1$, $\alpha=\frac{1-s^2}3\ge0$: **the frontier branch's configuration cannot realise $\alpha<0$ at all**, so the whole of $\alpha\in[-1,0)$ falls to Nienhaus's branch, where the record checks nothing and where the stationary root of $(1-\alpha)u^2-cu+\alpha=0$ leaves $[0,1]$. **"The two branches cover complementary intervals" is checked only at their upper crossing.** This is the boundary the trap list asks about and it is the one nobody has looked at.

## 6. The measured input, and what zero-padding can establish

**Padding is exact, and I checked the mechanism rather than trusting it.** Conventions: *"Padding commutes with $Q$, and preserves both the norm and $\theta$."* Since $u$ is itself padded and $F_u(h)=\tfrac12(uh+hu)+u\#h$, $F_u^{(m)}$ preserves the padded copy of $\mathcal W_{12}$ and restricts there to $F_u^{(12)}$; being self-adjoint it preserves the orthogonal complement too, so eigenspaces split and $\Pi_{\ker}^{(m)}(\text{padded }x)=\text{padded }\Pi_{\ker}^{(12)}x$. And $\langle M^{(m)}_{W_1}q,y\rangle=T(W_1,q,y)=\langle W_1\circ q,y\rangle=0$ for $y$ orthogonal to the padded copy, because $W_1\circ q$ is padded. **So the identity does transfer exactly, and every $T$-value with it.**

**What that establishes, and what it does not.**

- It establishes that the *configurations* measured at $n=12$ exist at $n=14,16,20,24$ with the same $A$, $B$, $q$, $M$. **This bounds $\sup T(W_1,W_1,K)$ and $\sup T(W_1,K,K)$ from BELOW.**
- **The estimate needs them bounded from ABOVE**: $V(t)$ is built from $a=\sqrt{5/6}$ and $\lambda=2/3$ as *suprema*, and $V$ is increasing in both. **So padding supplies evidence in precisely the direction the estimate cannot use.** The block's *"which gives monotonicity in $n$ as a lower bound"* states the mechanism correctly and never says that a lower bound is useless here. **That is the defect in the scope paragraph: not an error, an omission that inverts the reader's impression.**
- It establishes nothing about $M_{W_1}\Pi_{\ker}Q(W_1)=0$ for the $W_1$ that are *new* at $m>12$. $\dim V_{1/3}$ and $\dim\ker F_u$ both grow with $n$; padding samples the pullback of a fixed finite-dimensional slice, a set of measure zero in the sphere the claim quantifies over. **"Dimensions $20$ and $24$ are checked by zero-padding" reads as the dimensions being checked; one configuration in each is.** Upstream, [Observation L102](../findings/route-a.md) says *"the $n=12$ **pair**"* (singular) so the record contains the correct wording and the block does not use it.

**The claimed dimensions.** The block heads itself *"at $n=12,14,16$"*, and its own opening quote already records that this is true of [Observation L102](../findings/route-a.md) alone: the two suprema H9 are the $n=10$ table, and $P\equiv0$ on $V_{1/3}$ with the two zero couplings are the same table. **So the four inputs the reduction needs are measured at $n=10$, and the one input the frontier needs is measured at $n=12,14,16$; no single dimension carries all five.** *This is the trap the brief names (a claim proven on a subfamily and used in general) and here it is worse than usual, because the subfamilies are different for different inputs and the block's heading names only one of them.*

## 7. The circularity, which quantity, what would suffice, and what a consumer may cite

### 7.1 Exactly which quantity the sphere-product value stands in for

**Two distinct quantities, in the two branches, and the block's single sentence covers them as if they were one.**

- **In the frontier branch** it is the last term, $s^3P(K)\le s^3\theta_0(n)$ with $K$ a unit vector of $\ker F_u$. So the quantity is $$\Gamma_{\ker}(n):=\sup\{P(K):K\in\ker F_u,\ \lVert K\rVert=1\}.$$ **A bound on a proper subspace.**
- **In Nienhaus's branch** it is the constant $c$ in $f(\varphi)\le c$, an inequality asserted along the whole geodesic $\cos\varphi\,u+\sin\varphi\,W$, so the quantity is $$M(n)=\max\{P(W):\lVert W\rVert=1\}$$ over the **whole** unit sphere, the object [conventions.md](../findings/conventions.md) tables as $M(n)$. This is Conjecture A's own constant; $M(n)$ is attained at a critical point by compactness, so bounding it is bounding $P$ at critical points, which is the conjecture.

**The block's *"both branches use the sphere-product value as their constant"* is therefore true and hides the asymmetry that matters: one branch needs a subspace bound, the other needs the global one.**

### 7.2 What weaker statement would suffice

**The frontier branch has real room.** *[screen]* At the worst point $\alpha\approx0.223$ in the limit, the third term's coefficient is $\sqrt{2/3}\,s^3=0.15548$ and the margin is $+0.00744$, so that branch alone tolerates $\Gamma_{\ker}\le1.4621$ against $\sqrt2=1.41421$, **a non-sharp bound, with $3.4\%$ of slack, on a proper subspace.** A reader who proved $\Gamma_{\ker}(n)\le1.46$ would discharge the frontier branch's whole dependence without going near Conjecture A. *And there is a natural candidate: Nienhaus's Proposition 4.11 puts a $\mathrm{Weyl}_{n-4}$ summand in the complement of $\mathbb Ru\oplus T_u\mathcal O$, so the honest open question is whether $\Gamma_{\ker}(n)\le\Theta_{n-4}$, or any bound below $1.46$.*

**The composite has almost none.** Nienhaus's branch is the binding one. *[screen]* Raising $c$ from $2/\sqrt3=1.15470$ to $1.161$ drives his margin at $\alpha=0.223$ to zero while the frontier's is still $+0.0063$, so the overlap survives up to $c\approx1.161$, i.e.

$$M(n)\ \le\ 1.161/\sqrt{2/3}\ \approx\ 1.422\qquad\text{against the conjectured }\Theta_n\uparrow\sqrt2=1.41421 .$$

**A slack of about $0.55\%$.** So the honest statement of the hypothesis is: *the estimate holds at every $n\ge12$ provided $M(n)\le1.42$*, which is formally weaker than Conjecture A and is within six parts in a thousand of it. **"A hypothesis a reader could discharge independently" is technically true and practically empty.**

### 7.3 Theorem, conditional statement, or assumption of the conclusion

**Assumption of the conclusion, and for a reason the block never states.**

I read Nienhaus §4.5 rather than the block's account of it. The section opens ([the extraction](https://arxiv.org/abs/2311.02404):4685–4691):

> "We prove the following theorem … Here we frequently use Conjecture A. More explicitely, we use the statement that $\max\{P(W)\mid W\in\mathrm{Weyl}_n,\lVert W\rVert=1\}=\sqrt{\tfrac32}$ and that this maximum is only achieved by $W_{\mathbb{CP}^2}$ in dimensions between 8 and 12."

**Theorem 4.17's standing hypothesis is Conjecture A, in the strong form "$\max P=\sqrt{3/2}$ with a unique maximiser".** At $n\ge12$ that statement is *false* ($\theta_0(12)^2=\tfrac{220}{144}>\tfrac32$) which is why the theorem is stated for $10\le n\le11$. The repair replaces the false constant with $\theta_0(n)$, i.e. **substitutes Conjecture A's conclusion at $n\ge12$ for a hypothesis that fails there.**

And Theorem 4.19, the consumer, does it again independently ([the extraction](https://arxiv.org/abs/2311.02404):4859–4860):

> "2nd case. $W(t_0)\notin SO(n).W_{\mathbb{CP}^2}$: Then we find that $P(W)\le P(W(t_0))\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ **by Conjecture A**."

**So the chain L22 → Thm 4.17 → Thm 4.19 consumes Conjecture A at $n\ge12$ in three places, of which the block names one.** Its conclusion ($P(W)\le\Theta_n$ for $W$ outside the tube), *is* Conjecture A restricted to a region. **Discharging L22's own $\Gamma_{\ker}$ dependence would not make the composite unconditional**, because §4.5's standing sentence and 4.19's second case are not L22's to repair.

**The three copies of the claim do not agree, and none of them is right.**

| where | what it says | verdict |
| --- | --- | --- |
| [results.md](../results.md):725–729 | *"For every $n\ge12$ that estimate holds"*, with no condition in the body at all | **the worst copy.** Universal, unhedged, and the heading's "$n=12,14,16$" is the only brake |
| [results.md](../results.md):236 | conditional on Conjecture A *"and therefore circular against this programme's goal"* | **nearest to right, and still understated**, it names one of the three uses |
| [results.md](../results.md):41 | *"conditional on the eigenvalue bound $\alpha\le\tfrac13$"* | **names the wrong condition.** $\alpha\le\tfrac13$ is [Lemma L21](../findings/route-a.md)'s, structural at $n\ge9$; the condition that binds L22 is the constant, not the eigenvalue bound |
| [route-a.md](../findings/route-a.md):534–564 | heading restricted to $n=12,14,16$; proof text claims *"They overlap for **every** $n\ge12$"* and closes with $\square$ | **a QED on a paragraph resting on H8, H9, H10, H12, H13, H14 and H15** |

### 7.4 What a consumer may legitimately cite

- **May cite:** the closed forms. $\tilde f(\pi/6)=(5\alpha+\sqrt3\gamma-3)/4$ and the resulting requirement (§1); $g_1(\alpha)=(1+\alpha)\sqrt{1-2\alpha}$ and the $\alpha=\tfrac13$ borderline (§2); $V(t)$, $t^*=\sqrt{30}/8$ and the ellipse frontier $\tfrac{A^2}{5/6}+\tfrac B{2/3}=1$ **conditional on H9 and H10** (§4); and $\alpha^*=32/141$ **conditional additionally on H8** (§4).
- **May cite as conditional:** *"if $M(n)\le1.42$ for every $n\ge12$, and if H8, H9, H10 hold at those $n$, then Nienhaus's Theorem 4.17 extends past $n=11$."*
- **May NOT cite:** anything of the form "the estimate holds for every $n\ge12$", or any use of L22 as a step toward Conjecture A at $n\ge12$. **The chain assumes the conclusion.**
- **On the two named consumers.** [Lemma L20](../findings/route-a.md) does **not** consume L22, the record now says so at [results.md](../results.md):48 and 725, [LEDGER.md](../findings/LEDGER.md):222 records the correction, and [Observation L102](../findings/route-a.md)'s own blast-radius note says *"nothing cites L22"*. **The brief's premise that "Lemma L20 and the tube argument both consume this block" is contradicted by the record**, and I found no consumer of L22 anywhere in [findings/](../findings/) or [results.md](../results.md). **Blast radius: nil.** *Which is also the strongest reason the circularity has not yet cost anything.*

## 8. The traps, each answered by name

**Silence is not a verdict, so every item is answered, including the ones where I found nothing.**

**$\ker W\ne0$ and padded objects.** *Live, and it does not bite where feared.* $u$ is padded $W_{\mathbb{CP}^2}$ and has enormous kernel; two of the five claimed dimensions ($20$, $24$) are paddings. §6 shows the padding is exact and that its evidential direction is wrong for this estimate. **[Trap W4](../findings/INDEX-traps.md), the vacuity of the gradedness screen at $\ker W\ne0$, is not invoked anywhere in this block**, I looked for $S(W)$ and it does not appear. **No finding there.**

**The boundary of every stated range.**

| boundary | verdict |
| --- | --- |
| $\varphi=\pi/6$ | **clean.** $f$ decreasing on $(0,\pi/6]$, $\tilde f(\pi/6)<0$ strict, requirement strict. The interval's open lower end is where H3 is needed (§1) |
| $\alpha=\tfrac13$ | **clean, and better than claimed.** $s=0$, $W=W_1$, $\gamma=\sqrt{2/3}P(W_1)=0$ by H6 against a requirement of $0.7698$. The estimate holds *at* the excluded endpoint |
| $\alpha=\alpha^*$ | **clean.** At $t=t^*$ the stationary point is $x=1$ exactly, so $B=0$ and $A=\sqrt{5/6}$, and the block's closed condition "$B=0$ exactly for $\alpha\ge\alpha^*$" has the right inclusion |
| $t=t^*$ | **clean.** The two branches of $V$ agree in value and derivative; §4 |
| $n=12$ | **inherited ambiguity.** $\theta_0(n)=\sqrt{3/2}$ at $n^2-12n+8=0$, i.e. $n=6+2\sqrt7=11.2915\ldots$, so $n\ge12$ is exactly $n>6+2\sqrt7$ over the integers and the block's "the larger constant forced above $n=11$" is right. **But Nienhaus's own standing sentence says the maximum is achieved only by $W_{\mathbb{CP}^2}$ "in dimensions between 8 and 12"**, which is false at $n=12$ where $\theta_0(12)>\sqrt{3/2}$; the record inherits the phrase without flagging it |
| **the lower end of $\alpha$** | **NOT CLEAN, and stated nowhere.** §5: $\alpha$ reaches $-1$, the frontier configuration cannot realise $\alpha<0$, and neither branch is checked there |
| the crossover $n=6+2\sqrt7$ | **correct and unstated.** The block says "above $n=11$" and never gives the algebraic threshold; $6+2\sqrt7$ appears nowhere in the block |

**A claim proven on a subfamily and used in general.** **Three, and they are on different subfamilies.** H9's two suprema and H6's three vanishings: $n=10$, used at $n\ge12$. H10: $n=12,14,16$ by 40 random draws, used at every $n\ge12$ and over an entire sphere. H8: never proved anywhere, used at every $\varepsilon$. **The block's heading names $n=12,14,16$, which is the subfamily of exactly one of the five inputs.**

**A hypothesis stated but never used.** **H7.** $\mu_N\in[-1,-\tfrac16]$ is stated in the upstream derivation and carries the inequality $s^2\le6\varepsilon/(3-c_0^2)$; at $c_0=1$ the $N$ channel vanishes and the identity gives the equality directly, so $\mu_N$'s range does no work in the final bound. **It becomes load-bearing again the moment H8 is questioned**, which is where §3's repair would put it.

**A step using one never stated.** **Four: H1, H3, H6, H11.** The worst is **H6**, the block claims to *"stand alone"* and its central move, *"both couplings $A$ and $B$ are evaluated at one and the same pair"*, is false without three vanishings that live fifty lines away in a table measured at a dimension the block never mentions.

**A universal claim with no witness.** **Two.** *"For every $W_1$ in the eigenspace, $M_{W_1}\cdot\Pi_{\ker}Q(W_1)=0$"*, an uncountable claim on 40 draws at one dimension. *"Its maximiser is always $c_0=1$"*, a claim over an interval of $\varepsilon$, with no derivation and no computed witness either.

**An imported theorem whose hypotheses were never checked.** **The trust-region result is named by phrase and cited by nothing**, so there is no hypothesis list to check, that is the finding. §4 checks the standard statement against the object anyway and finds every hypothesis met, so **this is not the unital-algebra failure**; the import is simply unnecessary, the frontier following from self-adjointness in four lines.

**Symbol collisions in [conventions.md](../findings/conventions.md).**

| symbol | L22's sense | the collision |
| --- | --- | --- |
| $\alpha$ | $\sqrt{2/3}\langle F_uW,W\rangle$ | **consistent with the table's line 63**, which explicitly separates it from the $W_{\mathcal S^4(\alpha)}$ family parameter in the same file. **No finding, but the block restates the definition instead of quoting it**, which is the practice conventions.md exists to forbid |
| $\gamma$ | $\sqrt{2/3}P(W)$ | **untabled.** The table's two senses are $S^{\mathrm{ord}}_{\mathfrak{mhh}}-S^{\mathrm{ord}}_{\mathfrak{mmm}}$ (line 20) and [L35](../findings/stratum-two-negative.md)'s cubic coefficient (line 39). **L22's is a third and it is the file's most-used letter** |
| $t$ **and** $K$ | $t=\tan\beta\in[0,\infty)$; $K$ a unit vector of $\ker F_u\subset\mathcal W_n$ | **the record's most serious collision here.** The table pairs the same two letters as $K$ the sectional matrix and $t=\lVert K\rVert_F^2\le2$, **a squared Frobenius norm capped at $2$ against an unbounded tangent, and a matrix against a Weyl operator.** A reader comparing $t^*=0.685$ with the tabled $t\le2$ is comparing nothing |
| $M$ | $M_{W_1}$, the quadratic form of $T(W_1,\cdot,\cdot)$ on $\ker F_u$ | **defined nowhere on the record** (confirmed independently of [Observation L102](../findings/route-a.md)'s note), and colliding with the table's sectional matrix $M$ and with $M(n)=\max P$, **the latter being the very quantity §7 shows this block assumes.** Two readings, projected and unprojected; §4 |
| $A$, $B$ | $T(W_1,W_1,K)$, $T(W_1,K,K)$ | **untabled.** $B$ already carries the Killing form, $\tfrac\theta2\mathrm{Id}-L_W$, [L48](../findings/problem.md)'s partition scalar and [sym3-blocks.md](../findings/sym3-blocks.md)'s pairing; $A$ carries $\lambda_1$. **A fifth and a second sense** |
| $V$ | $V(t)$, the frontier value | collides with $V_{1/3}$, $V_{\le0}$, $V_\lambda$ **inside the same block** |
| $\varepsilon$, $s$, $c$ | $\tfrac13-\alpha$; $\sin\beta$; $c_0,c_-,\cos\beta,c_n$ | $\varepsilon$ against the table's bracket deficit; $s$ against singular values; **$c$ carries four objects inside this one block** |
| $m$ | absent from L22, **and that is itself the finding** | conventions line 62: *"$m$ carries two objects inside [route-a.md](../findings/route-a.md) … the complementary dimension $n-4$ … and $\sqrt{2/3}\max P$, the attained maximum, in the tube proof's own bootstrap."* **$\sqrt{2/3}\max P$ is exactly L22's constant $c_n$, written under a different letter in the same file.** *The two blocks use one quantity in opposite ways, [Lemma L20](../findings/route-a.md) bootstraps on it as attained, L22 assumes a value for it*, and nothing on the record says they are the same object. **The neighbouring [Observation L102](../findings/route-a.md) then uses $m$ for the ambient dimension ("$m=14,16,20,24$"), a third sense** |
| $\Pi$ | $\Pi_{\ker}$ | a fifth sense of the table's four, but subscripted. **No finding** |
| $\theta^*$, $F_u$ | as tabled | **consistent. No finding** |

**Two further textual defects found while reading.**

- **The block's last paragraph is broken in half by an editorial note.** *"The ratio of"* / *[italic note about the display standing alone]* / *"the true value to the requirement peaks near $\alpha=0.23$"*, one sentence with a note wedged inside it, at [route-a.md](../findings/route-a.md):556–563.
- **And that figure contradicts its own upstream copy twice over.** [route-a.md](../findings/route-a.md):523 says the peak *"sits at $\alpha\approx0.23$"*; :527, four lines later in the same block, says it *"peaks near $\alpha=0.25$ … A claim for large $n$ should be tested at $\alpha=0.25$"*; :563 in L22 says $0.23$. **Same quantity, two values, three sites.** *[screen] my §5 reconstruction puts the binding point at $\alpha\approx0.2228$, consistent with neither, which is a further reason to treat all three as unsourced.*

## 9. The discrepancy protocol

Three tests on each candidate: located exactly, exhibited concretely in closed form, and argued against. **Two survive; three were withdrawn.**

**Reported.**

1. **"$V=\min$ of the two" is false.** *Located:* [route-a.md](../findings/route-a.md):552, and verbatim in [ATTEMPTS.md](../ATTEMPTS.md):4541, [lean/INDEX.md](../lean/INDEX.md):229 and [L22.lean](../lean/HamiltonsCubic/Results/L22.lean)'s docstring. *Exhibited:* at $t=1$, $\min\{\sqrt{5/6},\tfrac{47}{48}\}=\sqrt{5/6}$ while $V(1)=\tfrac{47}{48}$, and $\tfrac{47}{48}>\sqrt{5/6}$ because $6\cdot47^2=13254>5\cdot48^2=11520$, **rational, no root taken.** *Argued against:* the charitable reading, that "the constant branch is the minimum value of the other", is the sentence's own first half and is true; the clause "so $V=\min$ of the two" is a separate assertion about a function and no reading makes it hold, since $\max$ fails below $t^*$ and $\min$ fails above. **Stands. Impact: cosmetic**, the tangency it purports to explain is delivered by the same sentence's correct half, and no theorem in [L22.lean](../lean/HamiltonsCubic/Results/L22.lean) states it.
2. **"This one covers $\alpha\ge0.2270$ at every $n$" is false.** *Located:* [route-a.md](../findings/route-a.md):552 and the "the frontier bound | covers | $\alpha\ge32/141$" table row at :518. *Exhibited:* $\alpha^*$ is derived in §4 as the solution of $\tan^2\beta=t^{*2}$, i.e. the point where $V$'s branches meet; the bound $\gamma\le\sqrt{2/3}[3c^3tV(t)+s^3\theta_0(n)]$ is defined and finite for every $\alpha\in(0,\tfrac13)$ and is *smaller* below $\alpha^*$ than the requirement, *[screen]* margin $+0.0067$ at $\alpha=0.22$ and $+0.00088$ at $\alpha=0.20$, both below $\alpha^*$. *Argued against:* if $\alpha^*$ were meant as "where $B$ stops vanishing", the sentence would not say "covers", and the neighbouring table's column heading is literally "covers". **Stands. Impact: it is the sole source of the record's standing "the two figures do not sit together" flag**, which §5 closes.

**Withdrawn.**

3. **"the equality $s^2=3\varepsilon$ contradicts Gate 2's correction that $s$ ranges over an interval".** *Withdrawn at test three:* §3 shows the equality is forced by the exact $\alpha$-identity once $c_0=1$, and the Gate 2 correction is about the general-$c_0$ problem. **Not a discrepancy; the debt is $c_0=1$ alone.**
4. **"Nienhaus's $\gamma$-bound does not return $4/(3\sqrt3)$ at $\alpha=\tfrac13$".** *Withdrawn at test two:* the extraction's $\sqrt{1-2\alpha(1+\alpha)}$ gives $\tfrac13$, but §2's derivation from his own stationarity condition gives $(1+\alpha)\sqrt{1-2\alpha}$, which gives $\tfrac4{3\sqrt3}$ exactly. **The fault is in the OCR, not the record.**
5. **"the frontier branch does not reach $\alpha=0.223$, so the branches leave a gap".** *Withdrawn at test three:* it is refuted by the same closed form that produced it, the frontier reaches to $\approx0.197$ in the limit. **Reported instead as candidate 2, whose failure is the coverage sentence rather than the mathematics.**

## 10. What would break it, and what I did to look

**The falsifying object.** A unit $W\in(\mathbb Ru\oplus T_u\mathcal O)^\perp$ at some $n\ge12$ with $\alpha(W)<\tfrac13$ and $\gamma(W)\ge\frac{3-5\alpha(W)}{\sqrt3}$. Equivalently, by §1, a $W$ for which $f'(\pi/6)\ge0$ along the geodesic from $u$.

**Where I looked.**

- **At the endpoints of every stated range**, as tabled in §8. $\alpha\to\tfrac13$ gives $\gamma\to0$ against a requirement of $0.7698$; $\alpha=\alpha^*$ and $t=t^*$ are interior to both branches' coverage. **Nothing there.**
- **At $c_0<1$**, which is the one place the record's own table supplies a force against its own claim: $\sup T(W_1,N,N)=\sqrt{2/3}>2/3=\sup T(W_1,K,K)$. §3's leading-order argument closes it near $\alpha=\tfrac13$ and a hand screen at $\alpha=\alpha^*$ went the record's way at $\rho\in\{0,0.2,1\}$. **I could not build a counterexample and I could not close it either. This is the live GAP.**
- **Below $\alpha=0$**, where the frontier configuration does not exist and Nienhaus's stationary root leaves $[0,1]$. **This is where I would look next and I could not settle it without computation, which this loop does not do.** Naming it is the finding.
- **At $n$ outside every measured dimension**, for the second falsifier: a $W_1\in V_{1/3}$ at $n\ge18$ with $M_{W_1}\Pi_{\ker}Q(W_1)\ne0$. **Padding cannot produce one and cannot exclude one** (it only ever produces $W_1$ pulled back from $n=12$) so the evidence is silent by construction at exactly the dimensions the claim ranges over. *[Observation L102](../findings/route-a.md) records the residual separation narrowing between $n=12$ and $n=16$; the direction is the one that matters and three figures fix no trend.*
- **At the imported theorem**, per the route that died on a unital algebra. **The trust-region hypotheses hold at this object.** Nothing there.

**What I did not do.** I ran nothing. Every decimal above is hand arithmetic on a closed form derived in this report, labelled **[screen]**, and none of it is offered as evidence for a positive claim. **The two suprema $\sqrt{5/6}$ and $2/3$ and the vanishing $M_{W_1}q=0$ are measurements, and whether they have an argument on file is the question I was asked; producing a better measurement would not have answered it.**

## Verdict

# `HYPOTHESIS-DEBT`

**The block is not a theorem, and it is not a conditional statement a reader could discharge.** It is a correct piece of closed-form analysis, better than the record believes, since §§1–4 re-derive every printed constant from scratch and §5 refutes the record's own standing objection to its margin figure, resting on **eight hypotheses it does not state, one it states and never proves, and two it cannot own because they are Nienhaus's.**

**The debts, in the order a repair should take them.**

1. **H8, $c_0=1$.** `GAP`. Asserted, never derived, contradicted in tendency by the block's own table, and **load-bearing for $\alpha^*$ itself**, which is undefined without it. §3 states exactly what must be proved.
2. **H13/H14, the constant.** The frontier branch needs $\Gamma_{\ker}(n)=\sup\{P(K):K\in\ker F_u\}\le1.46$, a non-sharp bound on a proper subspace, with real slack. **Nienhaus's branch needs $M(n)\le1.42$ over the whole sphere, which is Conjecture A to within $0.55\%$.** And §7.3: the theorem being repaired assumes Conjecture A twice more, at [the extraction](https://arxiv.org/abs/2311.02404):4685–4691 and :4859–4860. **The composite assumes its conclusion at $n\ge12$ and no repair inside L22 can change that.**
3. **H15, monotonicity in $n$.** `HYPOTHESIS-DEBT`, and small: §5 gives the closed forms and the three-line argument, wanting only that the covered set is a down-set in $\alpha$.
4. **H9, H10, H12, the measurements.** $n=10$ for four inputs and $n=12,14,16$ for one; padding at $n=20,24$ bounds the constants from below where the estimate needs them from above.
5. **Two false sentences**, both reported under §9 and both repairable in one line each: *"$V=\min$ of the two"* and *"covers $\alpha\ge0.2270$"*. **The second is worth repairing first**, since removing it closes a flag standing in three files.

**What the record should say instead of its four disagreeing copies.** *Observation L22, at $n=12,14,16$, and conditional on $\max P\le\theta_0(n)$ at $n\ge12$: the closed-form frontier $\tfrac{A^2}{5/6}+\tfrac B{2/3}=1$, the value $V(t)$ with $t^*=\sqrt{30}/8$, and the branch meeting $\alpha^*=32/141$. Whether the two branches cover $\alpha<\tfrac13$ at every $n$ turns on an unproved optimisation step and on a hypothesis that is Conjecture A at $n\ge12$, so **the block cannot be cited toward Conjecture A**.* **Blast radius nil**: nothing on the record consumes L22, [Lemma L20](../findings/route-a.md) least of all.
