# Gate 2, Reviewer 122, the LOSS identity and the dichotomy branch

Cold audit of the chain "$\lambda\mu=\mu^2-\mathrm{LOSS}$", worked on paper first and only then checked against an implementation written from scratch in this review (no project script was read before the algebra was done). Conventions fixed independently: $\Lambda^2$ carries $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}(AB)$, $\{e_i\wedge e_j\}_{i<j}$ is orthonormal, $W_{ijkl}=\langle W(e_k\wedge e_l),e_i\wedge e_j\rangle$, and $\lVert W\rVert_F=1$ as an operator on $\Lambda^2$.

## Verdicts on steps 1–7

| step | verdict |
|---|---|
| 1 | **Correct**, and it needs one fact the chain never states, see "Q(W) is automatically Ricci-flat" below |
| 2 | **Correct.** Rederived in full; residual $\le3\times10^{-17}$ at $n=4,5,6$ |
| 3 | **Correct**, with a live normalisation trap: $\mathop{\mathrm{tr}}N=4$, not $1$ |
| 4 | **Correct, normalisation included.** Pinned three independent ways |
| 5 | **Correct**, and it holds at *every* eigenvector, not only the bottom |
| 6 | **Correct as algebra, misleading as a reduction.** $\mathrm{LOSS}=\mu(\mu-\lambda)$ is a tautology |
| 7 | **First half is a theorem**, proved here for all $p,q$. **Second half correct** |

---

### Step 1, correct, and it rests on an unstated fact

$R\mapsto\mathring R$ is linear, the substitution is legitimate, and pairing at a unit $h$ gives $\lambda\mu=-\langle(W^2)^{\!\circ}h,h\rangle-\langle(W^\#)^{\!\circ}h,h\rangle$. Two remarks.

**The unstated fact.** Step 1 substitutes $Q(W)=\lambda W$. Criticality of $\theta$ on the unit sphere of $\mathrm{Weyl}_n$ gives only $\Pi_{\mathrm{Weyl}}Q(W)=\lambda W$, and $\Pi_{\mathrm{Weyl}}$ does **not** commute with $R\mapsto\mathring R$. The chain is saved by a fact it never mentions: for a Weyl tensor $W$, $Q(W)$ is automatically Ricci-flat, so the projection is the identity there. Measured $\lvert\mathrm{Ric}(Q(W))\rvert_\infty\le7\times10^{-17}$ on random Weyl tensors at $n=4,5,6,7$. Worth a line in the record, because without it the whole chain has a hole at its first move.

**$h$ need not be an eigenvector for step 1**; setting $\mu:=-\langle\mathring Wh,h\rangle$ for any unit $h$ keeps step 1 verbatim. Eigenvector-ness is spent only in step 5.

### Step 2, correct

Rederived independently. $(W^2)_{ijkl}=\tfrac12\sum_{pq}W_{ijpq}W_{pqkl}$ is right in this convention, and $\langle(W^2)^{\!\circ}h,h\rangle=\tfrac12\sum_{pq}\mathop{\mathrm{tr}}((u^{pq}h)^2)$. The commutator step is right: with $S=[A,h]$ symmetric and $K=\{A,h\}$ antisymmetric, $SS^{\mathsf T}+KK^{\mathsf T}=S^2-K^2=-2(Ah^2A+hA^2h)$, so $\lVert S\rVert^2+\lVert K\rVert^2=-4\mathop{\mathrm{tr}}(A^2h^2)=4\lVert Ah\rVert^2$, and eliminating $K$ gives $\mathop{\mathrm{tr}}((Ah)^2)=\tfrac12\lVert[A,h]\rVert^2+\mathop{\mathrm{tr}}(A^2h^2)$. Since $\sum_{pq}(u^{pq})^2=-N$, the boxed form follows. Residual $\le3\times10^{-17}$.

### Step 3, correct, and the trap is the normalisation

$N_{ik}=\langle v_i,v_k\rangle$ with $(v_i)_{mpq}=W_{impq}$, so $N\succeq0$, a Gram matrix, no more. But **$\mathop{\mathrm{tr}}N=\sum_{ijkl}W_{ijkl}^2=4\lVert W\rVert_F^2=4$** under the stated normalisation, so "$\mathop{\mathrm{tr}}N=\lvert W\rvert^2$" is true only when $\lvert W\rvert^2$ means the four-index sum. Anyone who reads it as $\lVert W\rVert_F^2=1$ loses a factor of four in $\lambda_{\max}(N)$. Verified $\mathop{\mathrm{tr}}N=4.000000$ at every point measured.

The withdrawal of "$N$ is a multiple of the identity" is right for $n\ge5$ and **wrong for $n=4$**: see the disagreement below.

Nothing downstream in the chain leans on the withdrawn claim.

### Step 4, correct, and the normalisation is the one to keep

The component formula $(W^\#)_{ijkl}=\sum_{pq}(W_{ipkq}W_{jplq}-W_{iplq}W_{jpkq})$ was checked against three independent anchors, all agreeing:

1. **Structure constants.** Building $c_{\alpha\gamma\zeta}=\langle[\phi_\alpha,\phi_\gamma],\phi_\zeta\rangle$ in the orthonormal $\Lambda^2$ basis and forming $\tfrac12\,c_{\alpha\gamma\zeta}c_{\beta\delta\eta}R_{\gamma\delta}R_{\zeta\eta}$ reproduces the component formula exactly (max difference $0.0$).
2. **The classical 3-manifold ODE.** With $R=\mathop{\mathrm{diag}}(x,y,z)$ on $\mathfrak{so}(3)$, the formula gives $R^\#=\mathop{\mathrm{diag}}(yz,zx,xy)$, Hamilton's $\dot x=x^2+yz$.
3. **Criticality of $\mathbb{CP}^2$.** On $\Lambda^2_+$ with $W^+=a\,\mathrm{diag}(2,-1,-1)$, this sharp gives $Q(W)=3a^2\,\mathrm{diag}(2,-1,-1)=3a\,W$, i.e. $\lambda=3/\sqrt6=\sqrt{3/2}$. The doubled sharp gives $\mathrm{diag}(5,-1,-1)a^2$, which is not proportional to $W$, so $\mathbb{CP}^2$ would not even be critical.

**The trap for anyone re-deriving it**: the *raw* Hamilton sum $c_{\alpha\gamma\zeta}c_{\beta\delta\eta}R_{\gamma\delta}R_{\zeta\eta}$ in this basis is **twice** the stated sharp, it yields $2(n-2)\mathrm{Id}$ at $R=\mathrm{Id}$, not $(n-2)\mathrm{Id}$. The factor $\tfrac12$ is mandatory. (Brendle's $Q$ is a further factor of two the other way: $Q_{\mathrm{Brendle}}=2(W^2+W^\#)$ in these conventions.)

Given that normalisation, the identity $\langle(W^\#)^{\!\circ}h,h\rangle=\sum_{pq}[\mathop{\mathrm{tr}}((C^{pq}h)^2)-\langle C^{pq},h\rangle^2]$ follows by direct index bookkeeping and checks to $1.1\times10^{-16}$.

### Step 5, correct, and it does not need the bottom

$C^{pq}_{ij}=W_{ipjq}=-W_{pijq}$ gives $\langle C^{pq},h\rangle=-(\mathring Wh)_{pq}$ for any symmetric $h$. That is criticality-free and bottom-free. Any eigenvector with $\mathring Wh=\nu h$ gives $\sum_{pq}\langle C^{pq},h\rangle^2=\nu^2$.

### Step 6, correct algebra, but it reduces nothing

Everything checks. The problem is what the step claims to have achieved.

**$\mathrm{LOSS}=\mu^2-\lambda\mu=\mu(\mu-\lambda)$ identically at every critical point**, read straight off the boxed identity. So:

- $\mathrm{LOSS}$ carries **no information beyond $\lambda$ and $\mu$**. Every measured $\mathrm{LOSS}$ in the record's table is $\mu^2-\lambda\mu$ computed the long way.
- "$\mathrm{LOSS}\ge\mu^2/n$" and "$\lambda\le\tfrac{n-1}n\mu$" are not two statements one of which implies the other; they are one statement written twice. The equivalence in step 6 is a division by $\mu$, and that is the whole of it.
- The value of the three-term decomposition is therefore **entirely as a proof strategy**, not as a reduction of the problem. The record's phrasing "what is owed is now one explicit inequality … in terms of three concrete quantities" is fair only in that sense.

Also: dividing by $\mu$ needs $\mu>0$. That is available (since $\mathop{\mathrm{tr}}\mathring W=0$ on $S^2_0$ and $\mathring W\ne0$, the spectrum has a negative eigenvalue), but the chain does not say so.

**And as a standalone lemma "$\mathrm{LOSS}\ge\mu^2/n$" is false**, step 7 supplies the counterexample itself. The brief handed to this review states step 6 without the dichotomy's other branch; [target.md](../findings/target.md) states $\mathrm{CD}_n$ correctly. A reviewer briefed from the chain alone would declare the route dead at step 7 and be wrong about which route.

### Step 7, the sphere-product equality is a theorem; here is the proof

**Reduction.** For $S^p\times S^q$ with equal curvature, $\Lambda^2(\mathbb R^n)=\Lambda^2V_1\oplus(V_1\wedge V_2)\oplus\Lambda^2V_2$, and $W$ is a scalar on each piece. Writing $P$ for the projection onto $V_1$: the curvature operator is $\Pi_1+\Pi_3$ (because $P\varowedge P'=\Pi_2$ as an operator, checked by hand), $\mathrm{Ric}_0=\tfrac{p-q}n(qP-pP')$, and $A\varowedge g$ acts as the derivation extension of $A$. Hence

$$w_1=\frac{2q(q-1)}{(n-1)(n-2)},\qquad w_2=-\frac{2(p-1)(q-1)}{(n-1)(n-2)},\qquad w_3=\frac{2p(p-1)}{(n-1)(n-2)} .$$

**The sharp on each piece**, from counting which brackets $[e_{\alpha\beta},e_{\gamma\zeta}]$ are nonzero and in which pieces $\gamma,\zeta$ sit:

$$(W^\#)_1=(p-2)w_1^2+q\,w_2^2,\qquad (W^\#)_2=(p-1)w_1w_2+(q-1)w_2w_3,\qquad (W^\#)_3=(q-2)w_3^2+p\,w_2^2 .$$

(Sanity: $q=0$, $w_1=1$ gives $(W^\#)_1=n-2$, the sphere.)

**The second-kind eigenvector.** $\mathring Wh=\sum_i w_i\sum_{a\in i}\phi_ah\phi_a$, and for diagonal $h$, $\phi h\phi=-h_{\beta\beta}E_{\alpha\alpha}-h_{\alpha\alpha}E_{\beta\beta}$. With $h_0\propto qP-pP'$ this gives $\mathring Wh_0=\nu h_0$, $\nu=-(p-1)w_1+p\,w_2=q\,w_2-(q-1)w_3$ (the two expressions agree identically).

**The conclusion, symbolically for all $p,q$** (sympy, exact rational arithmetic in $p,q$):

- $Q_i-\lambda w_i=0$ for $i=1,2,3$ identically, **every** $S^p\times S^q$ with equal factor curvature is critical, for all $p,q\ge2$;
- $\lVert W\rVert^2=\dfrac{2pq(p-1)(q-1)}{(n-1)(n-2)}$, $\ \theta_{\mathrm{raw}}=\dfrac{4pq(p-1)^2(q-1)^2}{(n-1)(n-2)^2}$;
- $\theta_{\mathrm{raw}}+\dfrac{n-1}n\,\nu\,\lVert W\rVert^2=0$ **identically**.

The last line is exactly $\lambda=\tfrac{n-1}n\mu$ after normalisation, i.e. $\mathrm{LOSS}=\mu^2/n$. **So step 7's first claim is a theorem, not a coincidence of the tested cases**, balanced or not, even or odd $n$, all $p,q\ge2$. Independent brute-force tensor computation agrees at $(p,q)\in\{(2,2),(2,3),(3,3),(2,4),(3,4),(4,4),(2,5),(2,6),(2,7),(3,5),(3,6),(4,4),(5,5)\}$ to $\le6\times10^{-15}$.

**Second claim: confirmed.** Padded $W_{\mathbb{CP}^2}$ at $n=4,5,6,8,12$: $\lambda=\sqrt{3/2}$ to $2\times10^{-16}$, $\mu=2/\sqrt6=0.816497$, $\mathrm{LOSS}=-1/3$ exactly, identity residual $\le4\times10^{-16}$.

---

## Answers to (a)–(d)

### (a) Any eigenvector works; the top gives nothing

Step 5 needs only $\mathring Wh=-\mu h$. Verified at eigenvectors $\#0$–$\#3$ of padded $\mathbb{CP}^2$ and of every sphere product: identity residual $\le9\times10^{-16}$ at each.

At the top of the spectrum $\mu<0$, so dividing $\lambda\mu=\mu^2-\mathrm{LOSS}$ by $\mu$ **reverses** the inequality: $\mathrm{LOSS}\ge\mu^2/n$ becomes $\lambda\ge\tfrac{n-1}n\mu$, whose right-hand side is negative, vacuous. The bottom eigenvector is needed only for the sign of $\mu$; minimality itself is never used. Any eigenvector with $\mu>0$ serves, and the *largest* $\mu$ gives the strongest bound, which is why the bottom one is the right choice.

Two consequences the chain does not draw:

- The identity at every eigenvector says $\mathrm{LOSS}(h)=\nu^2+\lambda\nu$ **depends only on the eigenvalue**. The three-term expression must collapse to that on every eigenvector, a free consistency test on any future bound.
- Summing over an orthonormal eigenbasis of $S^2_0$: $\sum_a\mathrm{LOSS}(h_a)=\lVert\mathring W\rVert_F^2=\tfrac34\lvert W\rvert^2=3$. So $\mathrm{LOSS}\ge\mu^2/n$ can never fail on average; it can only fail at the bottom, which is exactly where $\mathbb{CP}^2$ puts it.

### (b) Criticality enters once, and the identity survives without it

Criticality is used **only** in the substitution. Steps 2, 4 and 5 are all criticality-free. The correct non-critical statement is

$$\mathrm{LOSS}=\mu^2+\langle Q(W)^{\!\circ}h,h\rangle$$

for **every** Weyl tensor $W$ and **every** $\mathring W$-eigenvector $h$. Verified at random *non*-critical Weyl tensors, $n=4,5,6$, over all eigenvectors: residual $\le1.2\times10^{-15}$ (criticality residual of those $W$: $0.53$–$0.90$).

So the record's control ("it correctly fails at a non-critical Weyl tensor"), is testing the $\lambda\mu$ form, not the identity. The identity itself never fails; what fails is the replacement $\langle Q(W)^{\!\circ}h,h\rangle\to-\lambda\mu$. Stating it in the criticality-free form is strictly better: it separates the algebra (always true) from the hypothesis (one substitution).

### (c) A theorem, proved above, for all $p,q$

See step 7. The proof is three scalars, a structure-constant count, and one symbolic identity. It also yields, as by-products, that every equal-curvature $S^p\times S^q$ is critical for all $p,q\ge2$, and that $\lambda(S^p\times S^p)\nearrow\sqrt2$.

### (d) No counterexample found, but the route has no slack left anywhere

**First, the framing.** The brief's step 6 is one branch of $\mathrm{CD}_n$. Because $\mathrm{LOSS}=\mu(\mu-\lambda)$, a point refuting the route is exactly a critical $W$ with

$$\lambda>\sqrt{3/2}\quad\text{and}\quad\lambda>\tfrac{n-1}n\mu ,$$

i.e. a counterexample to $\mathrm{CD}_n$. Padded $\mathbb{CP}^2$ is **not** one: it has $\mathrm{LOSS}<\mu^2/n$ but $\lambda=\sqrt{3/2}$ exactly, saturating the other branch.

**Search.** None found. Details in the "searches run" section below.

**But four structural facts say the route is a very narrow needle.**

**(d1) $\mathrm{CD}_n$ is an equality on both of its branches' extremal families.** Measured gap $\lambda-\max\{\sqrt{3/2},\tfrac{n-1}n\mu\}$:

| point | $\lambda$ | $\mu$ | $\tfrac{n-1}n\mu$ | gap |
|---|---|---|---|---|
| $S^2\!\times\!S^2$ | $0.866025$ | $1.154701$ | $0.866025$ | $-3.6\times10^{-1}$ (first branch slack) |
| $S^6\!\times\!S^6$ | $1.236033$ | $1.348400$ | $1.236033$ | $\mathbf{-6.7\times10^{-16}}$ |
| padded $\mathbb{CP}^2$ | $1.224745$ | $0.816497$ | $\tfrac{n-1}n(0.8165)$ | $\mathbf{+2.2\times10^{-16}}$ |

A dichotomy tight on both branches admits **no lossy step anywhere** in a proof of it.

**(d2) The follow-on estimate in [target.md](../findings/target.md) is exactly maximally lossy.** The record writes "dropping the commutator mass, $-\langle(W^2)^{\!\circ}h,h\rangle\le\tfrac12\mathop{\mathrm{tr}}(Nh^2)\le\tfrac12\lambda_{\max}(N)$". Term-by-term measurement of $\mathrm{LOSS}=\underbrace{\tfrac14\sum\lVert[u,h]\rVert^2}_{\mathrm{comm}}+\underbrace{\sum\mathop{\mathrm{tr}}((Ch)^2)}_{C}\underbrace{-\tfrac12\mathop{\mathrm{tr}}(Nh^2)}_{N}$:

| point | comm | $C$ | $N$ | $\mathrm{LOSS}$ | $\mu^2/n$ |
|---|---|---|---|---|---|
| $S^2\!\times\!S^2$ | $+0.33333$ | $+0.50000$ | $-0.50000$ | $0.33333$ | $0.33333$ |
| $S^3\!\times\!S^3$ | $+0.26667$ | $+0.33333$ | $-0.33333$ | $0.26667$ | $0.26667$ |
| $S^5\!\times\!S^5$ | $+0.17778$ | $+0.20000$ | $-0.20000$ | $0.17778$ | $0.17778$ |
| $S^6\!\times\!S^6$ | $+0.15152$ | $+0.16667$ | $-0.16667$ | $0.15152$ | $0.15152$ |
| $S^3\!\times\!S^5$ | $+0.20317$ | $+0.32778$ | $-0.32778$ | $0.20317$ | $0.20317$ |
| padded $\mathbb{CP}^2$ | $+0.33333$ | $-0.16667$ | $-0.50000$ | $-0.33333$ | $\mu^2/n$ |

**At every sphere product measured, $C=-N$ exactly, so $\mathrm{LOSS}$ *is* the commutator mass, and the commutator mass *is* $\mu^2/n$.** Dropping it discards one hundred per cent of the margin on the very family where the branch has to be an equality. The estimate is valid; it cannot possibly close the branch it is aimed at.

**(d3) $\mu$ is capped, so the second branch can only ever deliver so much.** From $\lVert\mathring W\rVert_F^2=\tfrac34\lvert W\rvert^2=3$ (verified $3.000000000$ at $n=4$–$7$) and $\mathop{\mathrm{tr}}\mathring W|_{S^2_0}=0$ with $D=\tfrac{n(n+1)}2-1$:

$$\mu\le\sqrt{3(D-1)/D}<\sqrt3 ,$$

so $\mathrm{CD}_n\Rightarrow\lambda\le\sqrt3$ unconditionally. Free, weak, but it bounds what the second branch can ever be worth.

**(d4) In $n=4$ the second branch is provably vacuous, the dichotomy adds nothing in the one dimension where the target is a theorem.** For $n=4$, with $a_1,a_2,a_3$ and $b_1,b_2,b_3$ the eigenvalues of $W^\pm$ on $\Lambda^2_\pm$:

$$\mathop{\mathrm{spec}}(\mathring W|_{S^2_0})=\{-(a_i+b_j)\}_{i,j=1}^3,\qquad \theta=9(\det A+\det B),$$

both verified to $10^{-16}$ on random $n=4$ Weyl tensors. Hence $\mu=a_{\max}+b_{\max}\le\sqrt{2/3}(s_a+s_b)\le 2/\sqrt3$ with $s_a^2+s_b^2=1$, so

$$\tfrac{n-1}n\mu\le\tfrac34\cdot\tfrac2{\sqrt3}=\tfrac{\sqrt3}2=0.866025<\sqrt{3/2}.$$

Numerical maximisation of $\mu$ over unit $\mathrm{Weyl}_4$ returns $1.154701=2/\sqrt3$, matching. So $\mathrm{CD}_4$ collapses to "$\lambda\le\sqrt{3/2}$" with the second branch never able to fire. The mechanism the dichotomy adds is untested in the only dimension where the answer is known.

**Where the second branch *is* reachable.** Numerically $\max\mu$ over unit $\mathrm{Weyl}_n$ tracks the best sphere product exactly, $1.154701$ ($n{=}4$), $1.178511$ ($n{=}5$), $1.264911$ ($n{=}6$), $1.278019$ ($n{=}7$), matching $\mu(S^2\!\times\!S^2)$, $\mu(S^2\!\times\!S^3)$, $\mu(S^3\!\times\!S^3)$, $\mu(S^3\!\times\!S^4)$, always far below $\sqrt{3(D-1)/D}$. Taking $\max\mu=\mu(\text{best product})$ and using the closed form of $\mu(p,q)$, the second branch can fire only where $\mu>\tfrac n{n-1}\sqrt{3/2}$:

| $n$ | best $(p,q)$ | $\lambda$ | $\mu$ | $\tfrac n{n-1}\sqrt{3/2}$ | branch reachable |
|---|---|---|---|---|---|
| 4 | $(2,2)$ | $0.866025$ | $1.154701$ | $1.632993$ | no |
| 7 | $(3,4)$ | $1.095445$ | $1.278019$ | $1.428869$ | no |
| 10 | $(5,5)$ | $1.200000$ | $1.333333$ | $1.360828$ | no |
| 11 | $(5,6)$ | $1.217161$ | $1.338877$ | $1.347219$ | no |
| **12** | $(6,6)$ | $1.236033$ | $1.348400$ | $1.336085$ | **yes** |
| 16 | $(8,8)$ | $1.280869$ | $1.366260$ | $1.306395$ | yes |
| 24 | $(12,12)$ | $1.325498$ | $1.383128$ | $1.277995$ | yes |

**So the second branch is inert for $n\le11$ and first fires at $n=12$**, exactly where the diagonal record first crosses $\sqrt{3/2}$, which is the same event. At $n=4$ this is proved (d4); at $5\le n\le11$ it rests on $\max\mu=\mu(\text{best product})$, which is numerical. Either way, $\mathrm{CD}_n$'s second branch does work only on the diagonal locus that the target already excludes by hypothesis. **That is the sharpest thing to say against the route: the mechanism it adds has, on every point anyone has produced, exactly zero work to do.**

**Verdict on (d).** $\mathrm{LOSS}\ge\mu^2/n$ is *not* plausibly provable as stated, it is false, and known to be. $\mathrm{CD}_n$ is not refuted, but it is an equality on both branches, its named estimate is maximally lossy on the branch it targets, and its second branch is provably inert at $n=4$ and numerically inert through $n=7$. The route is honest bookkeeping around an inequality that has not moved.

---

## What the chain does not mention

1. **$\mathrm{LOSS}=\mu(\mu-\lambda)$**, the decomposition is a rewriting of $\mu^2-\lambda\mu$, not a reduction. This is the single most important omission.
2. **$Q(W)$ is Ricci-flat whenever $W$ is** (residual $\le7\times10^{-17}$, $n=4$–$7$). Without it, "criticality gives $Q(W)=\lambda W$" is not the criticality condition, and step 1 has a projection hole.
3. **$W^2$ and $W^\#$ individually violate the first Bianchi identity**, only their sum is an algebraic curvature tensor. Measured Bianchi defect $1.2\times10^{-2}$–$6.1\times10^{-2}$ at random Weyl tensors, equal and opposite for the two pieces, versus $\le2\times10^{-17}$ for $Q(W)$. So neither $(W^2)^{\!\circ}$ nor $(W^\#)^{\!\circ}$ is the second-kind operator *of* anything, and no bound quoted for curvature operators of the second kind applies to either piece separately. (The quadratic forms are still legitimate: $T\mapsto\mathring T$ turns out to be self-adjoint on $S^2$ for pair-symmetric $T$ regardless, asymmetry exactly $0$, checked at $n=4,5,6$ on pair-symmetric tensors with Bianchi defect up to $1.3$.)
4. **The sharp needs the explicit $\tfrac12$** relative to the raw structure-constant sum; the raw sum is twice the stated $W^\#$.
5. **$\mathop{\mathrm{tr}}N=4$, not $1$**, under $\lVert W\rVert_F=1$.
6. **$\lVert\mathring W\rVert_F^2=3$ and $\mathop{\mathrm{tr}}(\mathring W^3)=\langle W,W^2\rangle-2\langle W,W^\#\rangle$**, hence $\theta=\tfrac12\!\left(3\langle W,W^2\rangle-\mathop{\mathrm{tr}}(\mathring W^3)\right)$, residuals $\le7\times10^{-16}$ at $n=4$–$8$. These are **already in the record** ([bispectral.md](../findings/bispectral.md), Dai–Fu Lemma 3.3 at $s=0$), but the chain never connects to them, although they bound the very $\mu$ the chain's second branch needs.
7. **The $n=4$ closed forms** in (d4): $\mathop{\mathrm{spec}}(\mathring W)=\{-(a_i+b_j)\}$ and $\theta=9(\det A+\det B)$. I did not find these in [target.md](../findings/target.md).
8. $\mu>0$ is needed to divide in step 6; it holds, but should be said.

## Disagreements with [target.md](../findings/target.md)

| claim in the record | this review |
|---|---|
| "$N$ … is a multiple of the identity only when $W$ has the symmetry to force it, **false** at padded $W_{\mathbb{CP}^2}$ and at random Weyl tensors" | **Wrong at $n=4$.** In dimension four $N=\tfrac14\lvert W\rvert^2 I$ for *every* Weyl tensor, the classical identity $C_{ipqr}C_{jpqr}=\tfrac14\lvert C\rvert^2\delta_{ij}$. Measured deviation $\le4\times10^{-16}$ at five random $\mathrm{Weyl}_4$ tensors and at $\mathbb{CP}^2$ itself ($\lambda_{\max}(N)=1=\mathop{\mathrm{tr}}N/4$). The counterexamples are $n\ge5$ only (deviations $0.196$ at $n{=}5$, $0.156$ at $n{=}6$, $0.088$ at $n{=}7$). The claim should read "$n\ge5$" |
| "$\mathop{\mathrm{tr}}N=\lvert W\rvert^2$, both checked" | True only for the four-index reading; $=4$, not $1$, under the file's own $\lVert W\rVert=1$. Worth disambiguating in place |
| "*So the whole route now rests on the $\#$ term alone*" (after dropping the commutator mass) | The commutator mass is not a spare term: it **is** all of $\mathrm{LOSS}$ at every sphere product, and equals $\mu^2/n$ there. Dropping it forfeits the second branch entirely on its own extremal family. See (d2) |
| "$\mathrm{LOSS}$ … with every term explicit in $W$ and $h$ and no inequality yet spent" | Accurate, but it should say that $\mathrm{LOSS}=\mu(\mu-\lambda)$ so the identity is a rewriting; otherwise the table of measured $\mathrm{LOSS}$ values reads as independent evidence when it is arithmetic |
| "Equality at every sphere product, balanced or not, even or odd $n$" | Now **proved** for all $p,q$, not just measured. Upgrade the claim |

The brief handed to this reviewer stated step 6 as a standalone lemma and omitted the target's $S=0$ and non-diagonal hypotheses. [target.md](../findings/target.md) has both right. The gap is in the brief, not the record.

## Searches run

**Zero-padded $W_{\mathbb{CP}^m}$, $m=2\dots6$, three paddings each**, all critical to $\le6\times10^{-16}$, $\lambda$ and $\mu$ invariant under padding, $\mathrm{LOSS}<0<\mu^2/n$ at every one, so the second branch never holds anywhere on this family:

| | $\mathbb{CP}^2$ | $\mathbb{CP}^3$ | $\mathbb{CP}^4$ | $\mathbb{CP}^5$ | $\mathbb{CP}^6$ |
|---|---|---|---|---|---|
| $\lambda$ | $1.224745$ | $1.054093$ | $0.986013$ | $0.948683$ | $0.924962$ |
| $\mu$ | $0.816497$ | $0.474342$ | $0.338062$ | $0.263523$ | $0.216225$ |
| $\mathrm{LOSS}$ | $-0.333333$ | $-0.275000$ | $-0.219048$ | $-0.180556$ | $-0.153247$ |
| gap | $-2\times10^{-16}$ | $-0.171$ | $-0.239$ | $-0.276$ | $-0.300$ |

This reproduces the record's "$\mathbb{CP}^m$ … $\sqrt{3/2}$ only" row and sharpens it: only $\mathbb{CP}^2$ sits *on* the first branch; the rest are strictly inside.

**Perturbed sphere products**, $n=10,12,14$. Starting from $W_0+\varepsilon P$ with $P$ random Weyl and $\varepsilon\in\{10^{-3},3\times10^{-2},0.15\}$, ascent returns to $\theta(S^p\times S^p)$ to nine digits every time ($1.200000000$, $1.236033081$, $1.261680124$; $\lVert X-W_0\rVert\le0.025$). So $S^p\times S^p$ is a local maximum of $\theta$ over the *whole* Weyl space, not merely inside the diagonal locus, $\theta$ cannot be driven above the diagonal record by leaving the diagonal locus near those points. That closes the most natural place to look for a non-diagonal point above $\sqrt{3/2}$.

**Random critical points.** Gradient flow (ascent and descent) plus a residual-shrinking polish, from random starts in $\mathrm{Weyl}_n$, $n=4,5,6,7$; 257 of 300 runs converged to $\lVert Q(W)-\theta W\rVert\le10^{-9}$. **Zero violations of $\mathrm{CD}_n$; $\max\lambda=1.224744871=\sqrt{3/2}$ at every $n$.** Honest caveat: the converged points collapse to just **two** distinct $(\lambda,\mu)$ orbits at every $n$, $\pm W_{\mathbb{CP}^2}$ ($\lambda=\pm\sqrt{3/2}$, $\mu=0.8165$ / $0.4082$, off-diagonal mass $0.15$–$0.33$). The flow never even lands on a sphere product. So this is evidence about the basins of the flow, not a census of critical points; a saddle above $\sqrt{3/2}$ would not be found this way.

**$\mu$-maximisation** over unit $\mathrm{Weyl}_n$, $n=4$–$7$, 12 starts each, reported in (d4).

## Recommendations

1. Add "$\mathrm{LOSS}=\mu(\mu-\lambda)$" to the boxed identity in [target.md](../findings/target.md), so the table of measured values is read as arithmetic rather than as evidence.
2. Record the criticality-free form $\mathrm{LOSS}=\mu^2+\langle Q(W)^{\!\circ}h,h\rangle$, valid at every Weyl tensor and every $\mathring W$-eigenvector; it separates the algebra from the hypothesis and makes the "control" test say what it means.
3. Add the Ricci-flatness of $Q(W)$ as a stated lemma; step 1 needs it.
4. Correct the $N$-is-not-scalar claim to $n\ge5$, and disambiguate $\mathop{\mathrm{tr}}N$.
5. Promote the sphere-product equality from measurement to theorem with the three-scalar proof above.
6. Retire "the whole route now rests on the $\#$ term alone", the commutator mass is the entire margin on the sphere-product branch.


*Joint section with Reviewer 121, see [REVIEW_r121.md](REVIEW_r121.md).*
