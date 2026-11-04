# VERIFY_v187, Lemma L17, first-order protection at the rival maximizer

Verifier v187, cold reader on [BRIEF_L17.md](BRIEF_L17.md). **No numerical work was done**: no script, no Sage, no Python, no numeric evaluation. Every value below is closed-form arithmetic done by hand on an object the brief already names, reported as a screen. Log: [agent_logs/verify-L17-v187.log](../agent_logs/verify-L17-v187.log).

## Claim table

| # | claim as the record carries it | verdict |
| --- | --- | --- |
| 1 | $d^+\delta^2(u;H)=-2aF(H)$, $a=\tfrac1{3\sqrt6}$, $\mathrm{Alt}(W_-)=a\star$ | **CONFIRMED**, re-derived in full, §2; $a$ pinned twice, independently |
| 2 | The reduction to Jensen's trace inequality (Hansen–Pedersen, $f(x)=x_-$) | **CONFIRMED, the TRACE form is essential**, §3. $x_-$ is *not* operator convex, so the operator Jensen inequality would fail; the record names the trace form and its hypotheses check |
| 3 | The first Bianchi identity forces an SD/ASD trace balance on the distinguished $4$-plane | **CONFIRMED, and it is exactly $\langle H,\star\rangle=0$**, §3.2, it does the work claimed |
| 4 | "Unit-norm tangency fixes the remaining diagonal entry against it" | **CONFIRMED FOR TANGENCY; $\lVert H\rVert=1$ IS INERT**, §3.3, a stated hypothesis that no step uses |
| 5 | $\{F=0\}=\{H:\Pi_{ASD}H\Pi_{\ker u}=0\}$, a linear subspace | **CONFIRMED, both directions**, §4, and it is exactly the set of directions in which $\delta^2$ is two-sided differentiable |
| 6 | The three prose families are sufficient, not the equality set; mixed $E$–$K$ included | **CONFIRMED** as an inclusion, §4.3, **WITNESS-FREE**: no Weyl tensor with a nonzero $E$–$K$ block is exhibited anywhere on the record |
| 7 | $\mathop{\mathrm{codim}}\{F=0\}\le186$ at $n=12$; $\ge1451$ of $1637$ | **CONFIRMED**, §5, $3\cdot63-3=186$, $1638-1=1637$ |
| 8 | "about $89\%$ of directions" | **MISDESCRIBED**, §5.2, $1451/1637=88.64\%$ is a ratio of *dimensions*; $\{F=0\}$ is a proper subspace and so a **measure-zero** set of directions. Correct as written arithmetically, false as read |
| 9 | $d^+\Phi=2a\kappa_nF$ needs $\kappa_n\le0$; $d^+\delta^2\le0$ is dimension-free | **CONFIRMED, AND IT RESTS ON AN UNSTATED HYPOTHESIS**, §6: $Q(u)=\theta u$. Nowhere stated in either block or in the notebook |
| 10 | $\Theta_{11}=1.21716<\sqrt{3/2}<1.24838=\Theta_{13}$, crossover still at $n\ge12$ | **CONFIRMED** to the digits printed, §7, but the two odd values alone do **not** establish "$n\ge12$"; even $n$ and monotonicity are needed and are stated nowhere |
| 11 | $\kappa_n$ pinned to $\theta_0(n)$ ([problem.md](../findings/problem.md)) vs the block's $\Theta_n$ check | **AMBIGUOUS, HARMLESS TO THE SIGN**, §7.3, the two pinnings differ by $6\%$ at odd $n$ and cross at $n\ge12$ under both |
| 12 | The padded flat is second-order safe "by an $18\times$ margin" | **CONFIRMED AT $n=12$ ONLY**, §8, the number is $n=12$'s and is not so labelled; the structural half ($T(u,H,H)=0$, $-\tfrac32\theta$) re-derives in closed form and is dimension-free |
| 13 | "the mixed flat directions need a Hessian comparison, verified numerically but not yet proven" | **HYPOTHESIS-DEBT**, §9, stated precisely there. It is *not* a step of L17 |
| 14 | The canonical entry and the landscape line as citable statements | **GAP**, §1, **nothing on the record states L17**. §10 supplies what a consumer may cite, assembled from the notebook |
| 15 | Symbols: $\kappa$, $\Phi$, $u$, $a$, $F$, $B$, $\lvert W\rvert$, $t$ | **FIVE LIVE COLLISIONS**, §11, under [conventions.md](../findings/conventions.md)'s *tabled* $\kappa_n=(2n-1)(n-1)/4$ the conclusion "$\kappa_n\le0$" is **false at every $n$**, and L17's $\kappa_n$ is tabled nowhere |

**Summary.** The mathematics is right and re-derives from scratch, the formula, the constant, the Jensen reduction, the equality set, the codimension and the crossover all confirm, but the record carries no statement of L17 anywhere, omits the one hypothesis its headline conclusion needs ($u$ critical), states one it never uses ($\lVert H\rVert=1$), and names its decisive constant with a letter whose tabled meaning falsifies the lemma.

**Verdict: PROVEN, hypotheses corrected.** The corrected statement is §10. The second-order rider carried in the same block is `HYPOTHESIS-DEBT` and must not be cited as part of L17.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $\mathcal W_n$: "the space of algebraic Weyl curvature operators on $\mathbb R^n$"; $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$, "$10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$".
- $\mathrm{Alt}$: "**$\mathrm{Alt}$ is the ORTHOGONAL PROJECTION of $S^2(\Lambda^2)$ onto $\Lambda^4$**, carrying its $\tfrac13$ … So $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$, $\mathrm{Alt}$ is self-adjoint and idempotent, and $\mathrm{Alt}(H)=0$ for every $H$ satisfying the first Bianchi identity, in particular for every Weyl tensor. **Inside $\Lambda^2\mathbb R^4$, $\Lambda^4$ is one-dimensional and $\mathrm{Alt}$ is the projection onto the Hodge star $\star=\Pi_{SD}-\Pi_{ASD}$, with $\lVert\star\rVert^2=6$.**"
- $W_-$: "**The sign of $W_-$ is $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$, the POSITIVE-SEMIDEFINITE magnitude of the negative part.** *This is forced by the rest of the record rather than chosen*: it is the only sign under which $\mathrm{Alt}(u_-)=+a\star$ with $a=\tfrac1{3\sqrt6}>0$ at the $\mathbb{CP}^2$-type competitor, under which $\mathrm{Alt}(W_-)\rvert_{\ker W}=-a\Pi_{ASD}$, and under which [Lemma L17](../findings/route-a.md)'s $d^+\delta^2=-2aF$ with $F\ge0$ comes out."
- $\Theta_n$: "the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, **the square root was missing here until 2026-09-04**".
- $\theta_0(n)$: "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.**"
- $\Pi$: "**the letter carries four unrelated objects and they must be read from context.**" $\Pi_{SD}$, $\Pi_{ASD}$, $\Pi_{\ker u}$ are a **fifth** family, none of the four; they are unambiguous only because $\star=\Pi_{SD}-\Pi_{ASD}$ is fixed in the $\mathrm{Alt}$ bullet above.
- $\delta^2$: from [problem.md](../findings/problem.md), "$\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ the defect from Observation L15", and the penalized statement "$P(W)\le\Theta_n+\kappa_n\delta^2$ on $\{\lvert W\rvert=1\}$".

## Hypothesis inventory

Assembled by reading every step of [ATTEMPTS.md](../ATTEMPTS.md) Result 6 and asking, of each, what it consumes. **S** = stated on the record; **U** = used but never stated; **I** = stated but never used.

| # | hypothesis | status | which step consumes it |
| --- | --- | --- | --- |
| H1 | $u$ is the padded $\mathbb{CP}^2$-type competitor, $u=\tfrac1{\sqrt6}(2\hat\omega_1\hat\omega_1^{\mathsf T}-\hat\omega_2\hat\omega_2^{\mathsf T}-\hat\omega_3\hat\omega_3^{\mathsf T})$ with $\hat\omega_i$ the orthonormal SD Kähler forms of a distinguished $\mathbb R^4\subseteq\mathbb R^n$ | **S** (notebook only) | everything; fixes the $2{:}{-}1{:}{-}1$ spectrum, hence $a$, $\delta^2(u)=\tfrac19$, and $\star\rvert_{\ker u}=-\Pi_{ASD}$ |
| H2 | $H\in\mathcal W_n$, $H$ satisfies the first Bianchi identity | **S** | step (d): $\mathrm{Alt}(H)=0\Rightarrow\langle H,\star\rangle=0$ |
| H3 | $\langle H,u\rangle=0$ (tangency) | **S** | step (d): $2H_{11}=H_{22}+H_{33}$; also kills $dP$ under H6 |
| H4 | $\lVert H\rVert=1$ | **I, INERT** | no step. $F$ is $1$-homogeneous, so the sign conclusion is scale-free |
| H5 | $n\ge4$, so the distinguished $\mathbb R^4$ exists | **U** (implicit) | H1 |
| H6 | $Q(u)=\theta u$ with $\theta=\sqrt{3/2}$ ($u$ is a **critical point** of $P$ on the sphere | **U), LOAD-BEARING** | the *only* place $d^+\Phi=2a\kappa_nF$ comes from. Without it $d^+\Phi=3\langle Q(u),H\rangle+2a\kappa_nF$ |
| H7 | $\kappa_n\le0$ | **S** (in the landscape line, [results.md](../results.md) l.222; **absent** from the [route-a.md](../findings/route-a.md) block's prose, which says only "for every $n\ge12$") | the sign of $d^+\Phi$ |
| H8 | $\Theta_n\ge\sqrt{3/2}$ for **every** $n\ge12$, both parities | **U**, the block checks $n=11,13$ only | H7, via $\kappa_n=9(\sqrt{3/2}-\Theta_n)$ |
| H9 | $\delta^2$'s ambient algebra is $\mathrm{Sym}(\Lambda^2\mathbb R^n)$, **not** $\mathcal W_n$ | **U** | steps (b),(c): $(P_0HP_0)_-$ is not a Weyl tensor. See §11.7, this is where the record's unital-algebra trap would have bitten and does not |

## 1. What is on the record, and what a consumer may cite

Three places carry the name L17 and **none carries a statement**:

- [results.md](../results.md) ll. 677–679, a heading over `**Proof:** route-a.md`. Nothing else.
- [route-a.md](../findings/route-a.md) ll. 71–88, five audit blockquotes and one paragraph of prose. The prose names no quantifier over $H$, no formula for $F$, no value of $a$, no definition of $\Phi$.
- [results.md](../results.md) l. 222, a landscape bullet, prose, with the useful correction that "$d^+\Phi=2a\kappa_nF$ needs $\kappa_n\le0$".

The block's own audit already records the circularity: "**And the pointer is circular**: this block records that the canon now carries the statement and points here, while the canon points here for the argument." That is accurate and I confirm it: following either pointer from the other returns to the start, and the argument is reachable only from the notebook, [ATTEMPTS.md](../ATTEMPTS.md) Result 6.

**Finding (GAP, documentation).** A consumer opening either canonical file cannot recover the lemma. §10 states what may be cited.

## 2. The one-sided derivative, derived

### 2.1 The competitor's spectrum, and $a$

With $\hat\omega_1,\hat\omega_2,\hat\omega_3$ the orthonormal self-dual forms of the distinguished $\mathbb R^4$ and $u=\tfrac1{\sqrt6}(2\hat\omega_1\hat\omega_1^{\mathsf T}-\hat\omega_2\hat\omega_2^{\mathsf T}-\hat\omega_3\hat\omega_3^{\mathsf T})$, the spectrum on $\Lambda^2\mathbb R^n$ is

$$\tfrac2{\sqrt6}\ (\text{mult }1),\qquad -\tfrac1{\sqrt6}\ (\text{mult }2),\qquad 0\ \big(\text{mult }\tbinom n2-3\big),$$

so $\lVert u\rVert^2=(4+1+1)/6=1$ and $\mathop{\mathrm{tr}}_{\Lambda^2}u=(2-1-1)/\sqrt6=0$, the "$2{:}1$ eigenvalue ratio is forced by $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$" of the notebook checks out.

By the quoted $W_-$ convention, $u_-=\tfrac1{\sqrt6}(\hat\omega_2\hat\omega_2^{\mathsf T}+\hat\omega_3\hat\omega_3^{\mathsf T})=\tfrac1{\sqrt6}(\Pi_{SD}-\hat\omega_1\hat\omega_1^{\mathsf T})$, supported in $S^2(\Lambda^2\mathbb R^4)$. Since $\Lambda^4\mathbb R^4=\mathbb R\star$ and $\mathrm{Alt}$ is the orthogonal projection onto $\Lambda^4$,

$$\mathrm{Alt}(u_-)=\frac{\langle u_-,\star\rangle}{\lVert\star\rVert^2}\,\star,\qquad \langle u_-,\star\rangle=\tfrac1{\sqrt6}\mathop{\mathrm{tr}}\!\big[(\Pi_{SD}-\hat\omega_1\hat\omega_1^{\mathsf T})(\Pi_{SD}-\Pi_{ASD})\big]=\tfrac{3-1}{\sqrt6}=\tfrac2{\sqrt6},$$

whence $\mathrm{Alt}(u_-)=\tfrac{2/\sqrt6}{6}\star=\tfrac1{3\sqrt6}\star=a\star$. **$a=\tfrac1{3\sqrt6}$ confirmed**, and with it $\delta^2(u)=a^2\lVert\star\rVert^2=\tfrac6{54}=\tfrac19$, the value the whole penalty is pinned on.

*Second, independent pin.* The notebook's own by-product $\delta^2=\tfrac12\langle\mathrm{Alt}(W_-),\lvert W\rvert\rangle$ gives, with $\lvert u\rvert=\tfrac1{\sqrt6}(2\hat\omega_1\hat\omega_1^{\mathsf T}+\hat\omega_2\hat\omega_2^{\mathsf T}+\hat\omega_3\hat\omega_3^{\mathsf T})$, the value $\tfrac12\cdot a\cdot\tfrac{2+1+1}{\sqrt6}=\tfrac{2a}{\sqrt6}=\tfrac2{18}=\tfrac19$. The two agree, which pins $a$ against a formula that does not use $\lVert\star\rVert^2=6$.

Restricting to $\ker u$: $\ker u$ meets the self-dual $3$-space in $0$ (all three $\hat\omega_i$ carry nonzero eigenvalues) and contains $\Lambda^2_{ASD}\mathbb R^4$ entire, so $\star\rvert_{\ker u}=-\Pi_{ASD}$ and $\mathrm{Alt}(u_-)\rvert_{\ker u}=-a\Pi_{ASD}$, as the convention bullet and step (b) both say.

### 2.2 The two branches

Write $E=\mathop{\mathrm{span}}\{\hat\omega_1,\hat\omega_2,\hat\omega_3\}$, $A=\Lambda^2_{ASD}\mathbb R^4$, $K'=(E\oplus A)^\perp$, so $\ker u=A\oplus K'$ and $P_0=\Pi_{A\oplus K'}$. Since $\delta^2(W)=\lVert\mathrm{Alt}(W_-)\rVert^2$ and $\mathrm{Alt}$ is self-adjoint and idempotent,

$$d^+\delta^2(u;H)=2\big\langle\mathrm{Alt}(u_-),\ d^+u_-(H)\big\rangle=2a\big\langle\star,\ d^+u_-(H)\big\rangle .$$

$\star=\Pi_{SD}-\Pi_{ASD}$ is **block-diagonal for $E\oplus A\oplus K'$**, indeed diagonal in any eigenbasis of $u$ adapted to that splitting, with diagonal $+1$ on $E$, $-1$ on $A$, $0$ on $K'$. Only diagonal entries of $d^+u_-$ survive the pairing.

*(a) Smooth branch.* On the pairs of eigenvalues not both zero, $f(x)=x_-$ has well-defined divided differences and the Daleckii–Krein formula applies entrywise; only the diagonal entries at nonzero eigenvalues reach $\star$, with multiplier $f'(\lambda)$. $f'(2/\sqrt6)=0$ and $f'(-1/\sqrt6)=-1$, so the branch contributes $2a\cdot\big(1\cdot0\cdot H_{11}+1\cdot(-1)H_{22}+1\cdot(-1)H_{33}\big)=-2a(H_{22}+H_{33})$. Every off-diagonal term (the $E$–$E$ rotations *and* the $E$–$K$ tilts), pairs to zero against a block-diagonal $\star$, which is the notebook's "(a) … every eigenvector-rotation term pairs to zero". **Confirmed.**

*(b) Kink branch.* On $\ker u$, first-order degenerate perturbation theory gives eigenvalues $t\mu_k+o(t)$ with $\mu_k=\mathop{\mathrm{spec}}(P_0HP_0\rvert_{\ker u})$, and eigenvectors converging inside $\ker u$ to those of $P_0HP_0$. For $t\to0^+$, $(t\mu_k)_-=t(\mu_k)_-$, so the kernel block of $u_-$ gains $t(P_0HP_0)_-+o(t)$. Pairing: $2\langle\mathrm{Alt}(u_-)\rvert_{\ker u},(P_0HP_0)_-\rangle=-2a\mathop{\mathrm{tr}}\!\big(\Pi_{ASD}(P_0HP_0)_-\big)$. **Confirmed.**

Adding,

$$\boxed{\,d^+\delta^2(u;H)=-2a\,F(H),\qquad F(H)=H_{22}+H_{33}+\mathop{\mathrm{tr}}\!\big(\Pi_{ASD}(P_0HP_0)_-\big).}$$

Normalisation is harmless: $\lVert u+tH\rVert^2=1+t^2$ under H3, and $\delta^2$ is $2$-homogeneous, so the sphere and the affine line agree to first order.

### 2.3 What the non-smoothness costs, answered

It costs two-sidedness, and nothing else. For $t\to0^-$ the kernel block gains $\lvert t\rvert(-P_0HP_0)_-=\lvert t\rvert(P_0HP_0)_+$, so

$$d^-\delta^2(u;H)=2a\,F(-H)=2a\Big[-(H_{22}+H_{33})+\mathop{\mathrm{tr}}\!\big(\Pi_{ASD}(P_0HP_0)_+\big)\Big],$$

and $d^-\!-d^+=2a\mathop{\mathrm{tr}}(\Pi_{ASD}\lvert P_0HP_0\rvert)\ge0$. Three consequences, all confirming the block's prose:

1. $\delta^2$ is a **concave kink** at $u$ in every direction: $d^+\le0$ and $d^-\ge0$ (apply $F\ge0$ to both $H$ and $-H$; $-H$ is also a unit tangent Weyl direction). So $u$ is a first-order local maximum of the defect itself.
2. $\delta^2$ is differentiable at $u$ in direction $H$ **iff** $\Pi_{ASD}(P_0HP_0)=0$, the same set as $\{F=0\}$ by §4. The equality set and the smooth locus of directions coincide.
3. Non-smoothness is where the protection comes from, not an obstacle to it: the penalty enters $\Phi$ as $+\lvert\kappa_n\rvert\delta^2$ (H7), and a concave kink in $\delta^2$ is exactly a downward kink in $\Phi$.

The block's "the kink prices that mass at exactly the rate the deepening gains" is a fair description of $F=\underbrace{\tfrac23\mathop{\mathrm{tr}}B}_{\text{smooth gain}}+\underbrace{\mathop{\mathrm{tr}}(\Pi_{ASD}(P_0HP_0)_-)}_{\text{kink price}}$ after §3.

## 3. The reduction, and its two structural facts

### 3.1 Jensen, and it must be the trace form

The step is (c): $\mathop{\mathrm{tr}}\big(\Pi_{ASD}(P_0HP_0)_-\big)\ge\mathop{\mathrm{tr}}(B_-)$ with $B=\Pi_{ASD}H\Pi_{ASD}$.

Let $C:A\hookrightarrow\ker u$ be the inclusion isometry ($C^*C=\mathrm{id}_A$, legitimate because $A\subseteq\ker u$), $X=P_0HP_0\rvert_{\ker u}$, $f(x)=x_-$. Then $C^*XC=\Pi_{ASD}H\Pi_{ASD}=B$, since $\Pi_{ASD}P_0=\Pi_{ASD}$. The Hansen–Pedersen **trace** Jensen inequality, for $f$ convex on an interval containing $0$ with $f(0)\le0$ and $C$ a contraction, $\mathop{\mathrm{tr}}f(C^*XC)\le\mathop{\mathrm{tr}}\big(C^*f(X)C\big)$, gives exactly $\mathop{\mathrm{tr}}(B_-)\le\mathop{\mathrm{tr}}\big(\Pi_{ASD}(P_0HP_0)_-\big)$.

**Hypotheses checked against the object.** $f(x)=x_-=\max(-x,0)$ is convex on $\mathbb R$ with $f(0)=0\le0$ ✓. $C$ is an isometry, hence a contraction ✓. $X$ is self-adjoint ✓.

**The precision the record gets right and a reader could lose.** The *operator* Jensen inequality is unavailable here: a function operator convex on the whole real line is a polynomial of degree $\le2$, so $x\mapsto x_-$ is **not** operator convex and $f(C^*XC)\preceq C^*f(X)C$ is not on offer. Only the trace version, which needs ordinary convexity, applies. The record writes "Jensen's **trace** inequality (Hansen–Pedersen, $f(x)=x_-$)", correct, and load-bearingly so.

### 3.2 The Bianchi balance, it does the work claimed

$H\in\mathcal W_n$ satisfies the first Bianchi identity, so $\mathrm{Alt}(H)=0$ (conventions). Since $\star$ spans $\Lambda^4\mathbb R^4\subseteq\Lambda^4\mathbb R^n$ we have $\mathrm{Alt}(\star)=\star$, and $\mathrm{Alt}$ is self-adjoint, so

$$\langle H,\star\rangle=\langle H,\mathrm{Alt}\star\rangle=\langle\mathrm{Alt}H,\star\rangle=0 .$$

Expanding $\star=\Pi_{SD}-\Pi_{ASD}$ in the $E\oplus A\oplus K'$ splitting,

$$0=\langle H,\star\rangle=\mathop{\mathrm{tr}}(\Pi_{SD}H\Pi_{SD})-\mathop{\mathrm{tr}}(\Pi_{ASD}H\Pi_{ASD})=(H_{11}+H_{22}+H_{33})-\mathop{\mathrm{tr}}(B).$$

**Confirmed**: this is precisely "a self-dual/anti-self-dual trace balance on the distinguished $4$-plane", it is nothing but $\langle H,\star\rangle=0$, and it is the *only* place $H$'s being a curvature tensor is used. Drop it and the lemma fails: an arbitrary symmetric $H$ can carry $\mathop{\mathrm{tr}}(B)=0$ with $H_{22}+H_{33}<0$, giving $F<0$.

### 3.3 Tangency, and the inert half of the phrase

$\langle H,u\rangle=\tfrac1{\sqrt6}(2H_{11}-H_{22}-H_{33})=0$ gives $2H_{11}=H_{22}+H_{33}$. With §3.2, $\tfrac32(H_{22}+H_{33})=\mathop{\mathrm{tr}}(B)$, i.e.

$$H_{22}+H_{33}=\tfrac23\mathop{\mathrm{tr}}(B).$$

**Confirmed**, and it is *tangency* that does it. The block says "**unit-norm** tangency fixes the remaining diagonal entry"; $\lVert H\rVert=1$ appears in no step of (a)–(d), and $F$ is $1$-homogeneous so the sign statement is scale-free. **H4 is a stated-but-unused hypothesis** (trap: "a hypothesis stated but never used"). Harmless, but it should be dropped from the statement or demoted to a normalisation remark, since a reader may take it for a constraint the proof needs.

### 3.4 The chain

$$F=\tfrac23\mathop{\mathrm{tr}}(B)+\mathop{\mathrm{tr}}\!\big(\Pi_{ASD}(P_0HP_0)_-\big)\ \overset{\text{(c)}}{\ge}\ \tfrac23\mathop{\mathrm{tr}}(B)+\mathop{\mathrm{tr}}(B_-)=\tfrac23\big(\mathop{\mathrm{tr}}B_+-\mathop{\mathrm{tr}}B_-\big)+\mathop{\mathrm{tr}}B_-=\tfrac23\mathop{\mathrm{tr}}(B_+)+\tfrac13\mathop{\mathrm{tr}}(B_-)\ \ge\ 0,$$

using $B=B_+-B_-$ with $B_\pm\succeq0$. **The whole chain confirmed as printed**, coefficients included: the $(\tfrac23,\tfrac13)$ are forced by the $2{:}{-}1{:}{-}1$ spectrum meeting the SD/ASD balance, exactly as the notebook says.

## 4. The equality set

### 4.1 $\Pi_{ASD}H\Pi_{\ker u}=0\Rightarrow F=0$

If $\Pi_{ASD}H\Pi_{\ker u}=0$ then $B=\Pi_{ASD}H\Pi_{ASD}=0$ (as $A\subseteq\ker u$), so $H_{22}+H_{33}=\tfrac23\mathop{\mathrm{tr}}B=0$; and $P_0HP_0$ annihilates $A$, hence so does $(P_0HP_0)_-$ (a spectral function of it), hence the sliver trace vanishes. So $F=0$.

### 4.2 $F=0\Rightarrow\Pi_{ASD}H\Pi_{\ker u}=0$

$F=0$ forces equality throughout §3.4. From the last inequality, $\mathop{\mathrm{tr}}(B_+)=\mathop{\mathrm{tr}}(B_-)=0$, and $B_\pm\succeq0$, so $B=0$. Then $F=\mathop{\mathrm{tr}}(\Pi_{ASD}X_-)$ with $X=P_0HP_0\rvert_{\ker u}$, so $\mathop{\mathrm{tr}}(\Pi_{ASD}X_-)=0$ with $X_-\succeq0$ and $\Pi_{ASD}$ an orthogonal projection; hence $\mathop{\mathrm{tr}}\big((X_-^{1/2}\Pi_{ASD})^*(X_-^{1/2}\Pi_{ASD})\big)=0$, so $X_-\Pi_{ASD}=0$: $A$ lies in the closed span of the eigenvectors of $X$ with eigenvalue $\ge0$, call it $V_+$, and $X$ preserves $V_+$ with $X\rvert_{V_+}\succeq0$. For $v\in A\subseteq V_+$, $\langle Xv,v\rangle=\langle Bv,v\rangle=0$, and a positive semidefinite operator with $\langle Xv,v\rangle=0$ has $Xv=0$. So $X\Pi_{ASD}=0$, i.e. $\Pi_{ASD}P_0HP_0=0$, i.e. $\Pi_{ASD}H\Pi_{\ker u}=0$.

**The characterisation is confirmed, both directions.** It is manifestly a linear condition, closed under $H\mapsto-H$, so $\{F=0\}$ is a **linear subspace** of $T_uS\cap\mathcal W_n$, not merely the convex cone that convexity plus $1$-homogeneity of $F$ would give. The block's headline is right and the prose it corrects was wrong.

*(Vocabulary.* The next blockquote calls the same object "THE CONE". A subspace is a cone, so nothing is false, but the two headings two lines apart name the object differently; "subspace" is the sharper word and should be used in both.)

### 4.3 The three families, and the mixed $E$–$K$ directions

- *Orbit tangents.* The notebook's "$P_0HP_0=0$ identically" places them inside, and $B=0$ follows. Inside ✓.
- *Hyper-Kähler rotations.* "supported on the self-dual space", i.e. $H=\Pi_EH\Pi_E$, so $\Pi_{ASD}H\Pi_{\ker u}=0$. Inside ✓.
- *Padded flat $\mathcal W_{n-4}$.* $H=\Pi_{K'_0}H\Pi_{K'_0}$ with $K'_0=\Lambda^2\mathbb R^{n-4}\subseteq K'$; the $A$-rows vanish. Inside ✓.
- *Mixed $E$–$K$.* If $H$'s only nonzero block is the $E$–$K'$ coupling, its $A$-row is $(A\text{–}E,A\text{–}A,A\text{–}K')=(0,0,0)$, so $\Pi_{ASD}H\Pi_{\ker u}=0$. Inside ✓, and such $H$ lies in none of the three families, so the three are genuinely sufficient-only. **Confirmed.**

**Finding (witness-free universal, minor).** "the subspace also contains every mixed $E$–$K$ direction" is an inclusion of a *linear condition*, established without exhibiting a single $H\in\mathcal W_n$ with a nonzero $E$–$K'$ block. Neither the block, the notebook, nor [r475](../reviews/REVIEW_r475.md) as excerpted produces one. The statement is therefore true and possibly vacuous as far as the record shows. It is not vacuous, the codimension count of §5 forces $\dim\{F=0\}\ge1451$ against the three families' $34+\dim(\text{hK})+300\ll1451$ at $n=12$, so the subspace contains a great deal the three families miss, but that inference is mine, and the record nowhere makes it.

## 5. The codimension

### 5.1 The count confirms

At $n=12$: $\dim\Lambda^2\mathbb R^{12}=66$, $u$ has rank $3$, so $\dim\ker u=63$, of which $\dim A=3$. The condition $\Pi_{ASD}H\Pi_{\ker u}=0$ is a $3\times63$ block of a symmetric operator whose $A\times A$ corner is itself symmetric, so its independent scalar conditions number

$$3\cdot63-\tbinom32=189-3=186 .$$

Imposed on $T_uS\cap\mathcal W_{12}$ they may be dependent, so $\mathop{\mathrm{codim}}\{F=0\}\le186$, **the "$\le$" is correct and necessary**. With $\dim\mathcal W_{12}=\frac{12\cdot9\cdot13\cdot14}{12}=1638$ and one dimension removed by tangency, $\dim T_uS=1637$ and $\dim\{F=0\}\ge1637-186=1451$. **All three numbers confirmed.**

### 5.2 "About $89\%$ of directions", misdescribed

$1451/1637=0.8864$, so "about $89\%$" is arithmetically right **as a ratio of dimensions**. As a statement about directions it is false and the sentence invites exactly that reading ("$1451$ of $T_uS$'s $1637$ dimensions, about $89\%$ of directions"). $\{F=0\}$ is a proper linear subspace of $T_uS$, hence a **measure-zero** subset of the unit sphere of directions: the set of directions on which the protection is an equality has measure $0$, and for Lebesgue-almost every tangent direction $F>0$ strictly.

*Discrepancy protocol.* **Located**: [route-a.md](../findings/route-a.md) l. 81, the blockquote "AND THE CONE IS MOST OF THE TANGENT SPACE". **Exhibited in closed form**: take $H$ with $\Pi_{ASD}H\Pi_{ASD}=B\succ0$ (the notebook's own "engineered $B\succ0$ directions"); then $F\ge\tfrac23\mathop{\mathrm{tr}}(B_+)>0$, and the set of such $H$ is open and non-empty, so $\{F>0\}$ has full measure while $\{F=0\}$ has none. **Argued the opposite**: could "directions" be a licensed shorthand for "dimensions"? The sentence itself makes the substitution in one clause, so the gloss is the author's, not a reader's; and the substitution is exactly the one that turns a true dimension count into a false measure claim. It fails the "argue the opposite" test only as an error of *fact*; as an error of *description* it stands.

**Reported as: WORDING DEFECT, not a broken claim.** The repair is one word: "about $89\%$ of the tangent directions' **dimensions**", or better, "a subspace of codimension at most $186$, large, but still of measure zero among directions".

## 6. Dimension dependence, and the hypothesis nobody stated

The penalized functional is $\Phi=P-\kappa_n\delta^2$, from [Conjecture L16](../findings/problem.md)'s $P\le\Theta_n+\kappa_n\delta^2$; at $u$, $\Phi(u)=\sqrt{3/2}-\kappa_n/9=\Theta_n$ by the pinning. Then along a tangent direction,

$$d^+\Phi(u;H)=dP(u;H)-\kappa_n\,d^+\delta^2(u;H)=dP(u;H)+2a\kappa_nF(H).$$

The record's $d^+\Phi=2a\kappa_nF$ therefore holds **iff $dP(u;H)=0$**. That is true, because $P$ is a cubic form with $dP(u;H)=3\langle Q(u),H\rangle$ and $u$ is a critical point, $Q(u)=\theta u$, so $dP(u;H)=3\theta\langle u,H\rangle=0$ by tangency.

**Finding (unstated load-bearing hypothesis).** H6 (criticality of $u$), is used and stated nowhere: not in the [route-a.md](../findings/route-a.md) block, not in the landscape line, not in the notebook's "**Consequences:** $d^+\Phi\le0$ at $\mathcal S^4(\alpha)$". This is the brief's named trap "a step using [a hypothesis] never stated". It is repairable in one clause, since $Q(u)=\theta u$ with $\theta=\sqrt{3/2}$ is elsewhere on the record, but it must be *in the statement*: a consumer applying "first-order protection" at a non-critical competitor would get a false conclusion.

Given H6, $F\ge0$ and $a>0$:

- $d^+\delta^2=-2aF\le0$ **in every ambient $n\ge4$**, every step of §2 and §3 is dimension-free. **Confirmed dimension-free.**
- $d^+\Phi=2a\kappa_nF\le0$ **iff $\kappa_n\le0$**, genuinely dimension-dependent. **Confirmed**, and the landscape line's correction ("This entry said 'in any dimension', which contradicts itself") is right.

Note the inversion below the crossover is a *consequence*, not a separate result: for $\kappa_n>0$, $d^+\Phi=2a\kappa_nF\ge0$, strictly wherever $F>0$, one formula, two regimes, as the block says.

## 7. The crossover under the corrected $\Theta_n$

### 7.1 The two printed values

Odd $n$: $\Theta_n^2=\dfrac{2(n-1)(n-3)}{(n+1)(n-2)}$ (conventions, with its square root).

- $n=11$: $\Theta_{11}^2=\dfrac{2\cdot10\cdot8}{12\cdot9}=\dfrac{160}{108}=\dfrac{40}{27}=1.481481\ldots$, so $\Theta_{11}=1.2171612\ldots$ → **$1.21716$ confirmed.**
- $n=13$: $\Theta_{13}^2=\dfrac{2\cdot12\cdot10}{14\cdot11}=\dfrac{240}{154}=\dfrac{120}{77}=1.5584415\ldots$, so $\Theta_{13}=1.2483755\ldots$ → **$1.24838$ confirmed** (and it agrees with [results.md](../results.md) l. 220's $\Theta_{13}=1.2483756$ to the last digit).
- $\sqrt{3/2}=1.2247448\ldots$, and $\tfrac{40}{27}<\tfrac32<\tfrac{120}{77}$ since $80<81$ and $240\cdot2>3\cdot154$. **The strict bracket $\Theta_{11}<\sqrt{3/2}<\Theta_{13}$ is confirmed exactly, in rationals, with no numerics.**

### 7.2 But two odd values do not give "$n\ge12$"

The claim needed is H8: $\Theta_n\ge\sqrt{3/2}$ for **every** $n\ge12$, and $<$ for every $n\le11$. The block checks $n=11$ and $n=13$ only, and never mentions even $n$ or monotonicity. The gap is closable and I closed it, but **the record does not state it**:

- Even $n$: $\Theta_n=\theta_0(n)$, $\theta_0(n)^2\ge\tfrac32\iff4(n-1)(n-2)\ge3n^2\iff n^2-12n+8\ge0\iff n\ge6+2\sqrt7=11.2915\ldots$. So $n=12$ ✓ ($\theta_0(12)^2=\tfrac{220}{144}=1.5278$), $n=10$ ✗ ($\tfrac{144}{100}=1.44$). $\theta_0(n)^2=2-\tfrac{6}{n}+\tfrac4{n^2}$ is increasing for $n\ge2$, so every even $n\ge12$ ✓.
- Odd $n$: $\Theta_n^2=\dfrac{2(n-1)(n-3)}{(n+1)(n-2)}=2-\dfrac{2(3n-5)}{(n+1)(n-2)}$, and $\dfrac{3n-5}{(n+1)(n-2)}$ is decreasing for $n\ge3$, so $\Theta_n^2$ is increasing: every odd $n\ge13$ ✓, and $n=11$ ✗, $n\le9$ ✗.

So the crossover is exactly $n\ge12$ under $\Theta_n$. **Claim confirmed; the argument for it is one line the record never writes.** Reported as an unstated step, not a defect.

### 7.3 Which $\kappa_n$? The block and [problem.md](../findings/problem.md) disagree, harmlessly

[problem.md](../findings/problem.md) l. 376 records "*The cost is already priced: $\kappa_n$ is pinned to $\theta_0(n)$ in [L17](../findings/route-a.md) and [L134](../findings/route-a.md), a $6\%$ split at odd $n$*", while the block's own survival check is run against $\Theta_n$. So a consumer cannot tell whether L17's $\kappa_n$ is $9(\sqrt{3/2}-\Theta_n)$ or $9(\sqrt{3/2}-\theta_0(n))$.

**It does not touch the conclusion**, and this is worth recording as a positive: the two pinnings agree at even $n$, and at odd $n$ they have the *same sign* everywhere, because both cross at the same integer,

$$\theta_0(n)^2\ge\tfrac32\iff n\ge11.2915,\qquad \Theta_n^2\ge\tfrac32\iff n\ge12.29\ \text{(odd: } n\ge13),$$

and over the integers with the parity rule both give exactly $\{n\ge12\}$: at $n=11$, $\theta_0(11)^2=\tfrac{180}{121}=1.4876<\tfrac32$ and $\Theta_{11}^2=1.4815<\tfrac32$; at $n=13$, $\theta_0(13)^2=\tfrac{264}{169}=1.5621>\tfrac32$ and $\Theta_{13}^2=1.5584>\tfrac32$. **So $\kappa_n\le0\iff n\ge12$ under either reading.** The ambiguity should still be closed in the statement, since $\lvert\kappa_n\rvert$ itself (which the second-order margins of §8 quote), differs by $6\%$ at odd $n$.

## 8. The second-order rider on the padded flat

Two claims travel with the block: the structural one, and the number.

**The structural one re-derives, dimension-free.** For $H$ supported on $\Lambda^2\mathbb R^{n-4}$ (disjoint coordinate block from the distinguished $\mathbb R^4$): as operators $uH=Hu=0$, so the $W^2$-polarization $\tfrac12(uH+Hu)$ vanishes; and for the halved Böhm–Wilking $\#$ (conventions: $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$), $v\in\mathfrak{so}(4)$ and $w\in\mathfrak{so}(n-4)$ on disjoint blocks commute, so $u\#H=0$. Hence the symmetric trilinear $T(u,H,H)=0$, and along the sphere geodesic $\gamma(t)=\cos t\,u+\sin t\,H$,

$$P(\gamma(t))=\cos^3t\,\theta+3\cos t\sin^2t\;T(u,H,H)+\sin^3t\,P(H)=\theta\big(1-\tfrac32t^2\big)+O(t^3),$$

giving $(P(\gamma)-\theta)/t^2\to-\tfrac32\theta$. With $\theta=\sqrt{3/2}$, $-\tfrac32\theta=-1.83712\ldots$, **the notebook's "prediction $-\tfrac32\theta=-1.837$" confirmed in closed form.** Adding the penalty and the disjoint-block additivity $\delta^2(\gamma)=\cos^2t\cdot\tfrac19+\sin^2t\cdot\delta^2(H)$ gives the reviewer-10 identity

$$\frac{\Phi(\gamma(t))-\Theta_n}{t^2}=-\tfrac32\theta-\kappa_n\big(\delta^2(H)-\tfrac19\big)+O(t),$$

**exactly as printed.** (It also explains the sign of the reported excess: measured $-1.846$ against $-1.837$ needs $\delta^2(H)<\tfrac19$, since $-\kappa_n>0$.)

**The number is $n=12$'s and is not labelled as such.** "safe by an $18\times$ margin" is $3\theta/(2\lvert\kappa_{12}\rvert)$ with $\lvert\kappa_{12}\rvert=9(\theta_0(12)-\sqrt{3/2})=9(1.2360331-1.2247448)=0.101595$, giving $3\cdot1.2247448/(2\cdot0.101595)=18.08$, **confirmed**, and Reviewer 10's $\times4$ sharpening to $72$ from $\delta^2\le\tfrac14$ is likewise arithmetically consistent. But $\lvert\kappa_n\rvert=9(\Theta_n-\sqrt{3/2})$ grows with $n$ toward $9(\sqrt2-\sqrt{3/2})=1.70518$, so the crude ratio $3\theta/(2\lvert\kappa_n\rvert)$ falls to $3.674/3.410=1.077$ as $n\to\infty$. **The "$18\times$" is therefore not a dimension-free margin, and neither block says so.**

*Discrepancy protocol.* **Located**: [route-a.md](../findings/route-a.md) l. 87, "safe by an $18\times$ margin", carrying no quantifier over $n$, inside a paragraph whose neighbouring clause does say "for every $n\ge12$". **Exhibited**: the closed form $3\theta/(2\lvert\kappa_n\rvert)\to1.077$ above. **Argued the opposite**: does the conclusion survive uniformly anyway? Yes, via the exact identity rather than the crude bound, the requirement is $\tfrac32\theta>\lvert\kappa_n\rvert(\delta^2(H)-\tfrac19)$, and with the record's own unconditional $\delta^2\le\tfrac14$ the right side is at most $1.70518\cdot\tfrac5{36}=0.2368$ against $1.83712$, a uniform margin of $7.76\times$ at every $n$. **So the claim is safe at every $n\ge12$ and the quoted figure is not.** Reported as a **SCOPE DEFECT on the number**, not on the conclusion; the dimension-uniform margin is assembled from two facts already on the record and appears on none of them.

## 9. The admitted debt, stated exactly

The block: "*What remains at this point is second-order: the mixed flat directions need a Hessian comparison, verified numerically but not yet proven.*"

**What is owed, precisely.** Let $u$ be the padded competitor at $n\ge12$ and $\{F=0\}=\{H\in T_uS\cap\mathcal W_n:\Pi_{ASD}H\Pi_{\ker u}=0\}$. Off $\{F=0\}$, §6 gives $d^+\Phi<0$ strictly, so those directions are settled at first order. On $\{F=0\}$ the first-order term vanishes identically and second order decides. Two sub-families are settled: the orbit and hyper-Kähler flats, where $\Phi$ is constant; and the padded flat $\mathcal W_{n-4}$, by §8. **What is owed is the remaining sub-family**, every $H\in\{F=0\}$ with a nonzero $E$–$K'$ coupling block, i.e. $\Pi_EH\Pi_{K'}\ne0$, for which one must prove

$$\limsup_{t\to0^+}\frac{\Phi(\gamma_H(t))-\Theta_n}{t^2}\le0,\qquad \gamma_H(t)=\cos t\,u+\sin t\,H,$$

equivalently $T(u,H,H)\le\tfrac{\theta}{2}\lVert H\rVert^2+\tfrac{\kappa_n}{2}\,\partial_t^2\delta^2(\gamma_H)\big\rvert_{0^+}$ under the record's normalisations. **The record has this on "200-direction fans" only.** Under the standing analysis-only rule it stays open, and it is the *only* thing between L17 and local maximality of $\Phi$ at the competitor.

**It is not a step of L17.** L17 is the first-order statement; the debt is the next result's. The block should say so, as written, "What remains at this point" sits in the same paragraph as the lemma and a hasty consumer will read the debt as L17's own last step. *(Trap answered: the block does **not** say "verified numerically but not yet proven" of any step L17 needs.)*

## 10. What a consumer may cite

Assembled from [ATTEMPTS.md](../ATTEMPTS.md) Result 6 with the hypothesis inventory applied. **Nothing of this shape exists on the record**; §1 is the GAP this repairs.

> **Lemma L17 (first-order protection at the rival maximizer).** Let $n\ge4$ and let $u\in\mathcal W_n$ be the zero-padded $\mathbb{CP}^2$-type competitor, $u=\tfrac1{\sqrt6}\big(2\hat\omega_1\hat\omega_1^{\mathsf T}-\hat\omega_2\hat\omega_2^{\mathsf T}-\hat\omega_3\hat\omega_3^{\mathsf T}\big)$ for $\hat\omega_1,\hat\omega_2,\hat\omega_3$ the orthonormal self-dual Kähler forms of a distinguished $\mathbb R^4\subseteq\mathbb R^n$. Let $P_0$ be the orthogonal projection of $\Lambda^2\mathbb R^n$ onto $\ker u$, $\Pi_{ASD}$ the projection onto the anti-self-dual $3$-space of the distinguished $\mathbb R^4$, and $a=\tfrac1{3\sqrt6}$, so that $\mathrm{Alt}(u_-)=a\star$ and $\delta^2(u)=\tfrac19$. Then for every $H\in\mathcal W_n$ with $\langle H,u\rangle=0$:
>
> **(i)** $d^+\delta^2(u;H)=-2a\,F(H)$ with $F(H)=H_{22}+H_{33}+\mathop{\mathrm{tr}}\big(\Pi_{ASD}(P_0HP_0)_-\big)$, where $H_{ii}=\langle\hat\omega_i,H\hat\omega_i\rangle$;
> **(ii)** $F(H)\ge\tfrac23\mathop{\mathrm{tr}}(B_+)+\tfrac13\mathop{\mathrm{tr}}(B_-)\ge0$ for $B=\Pi_{ASD}H\Pi_{ASD}$; hence $d^+\delta^2(u;H)\le0$ **in every ambient dimension**;
> **(iii)** $F(H)=0\iff\Pi_{ASD}H\Pi_{\ker u}=0$, a linear subspace of $T_uS\cap\mathcal W_n$, of codimension at most $3\dim\ker u-3$, at most $186$ at $n=12$, so of dimension at least $1451$ out of $1637$;
> **(iv)** if in addition $Q(u)=\theta u$ with $\theta=\sqrt{3/2}$, then for $\Phi=P-\kappa_n\delta^2$, $d^+\Phi(u;H)=2a\kappa_n F(H)$; so $d^+\Phi(u;H)\le0$ for every tangent $H$ **iff $\kappa_n\le0$**, which holds exactly for $n\ge12$ under either the $\Theta_n$ or the $\theta_0(n)$ pinning of $\kappa_n$, and reverses to $d^+\Phi\ge0$, strictly wherever $F>0$, for $4\le n\le11$.

Changes against what the record implies: $\lVert H\rVert=1$ dropped (inert); $Q(u)=\theta u$ added to (iv) (used, never stated); "in any dimension" confined to (ii); "$89\%$ of directions" replaced by the dimension count; the equality set given as the subspace rather than the three families.

## 11. The traps, each by name

**11.1 $\ker W\ne0$, and what happens at a padded object.** Here the kernel is the mechanism, not an obstruction. At $n=12$, $\dim\ker u=63$ against $\dim\Lambda^2\mathbb R^{12}=66$, and the kernel carries the entire complementary $\Lambda^2\mathbb R^8$ plus the mixed block. The argument's behaviour at a padded object: (i) $\mathrm{Alt}(u_-)$ is unchanged by padding, since $u_-$ is supported in $S^2(\Lambda^2\mathbb R^4)$, so $a$ and $\delta^2(u)=\tfrac19$ are dimension-free, this is what makes the pinning $\kappa_n=9(\sqrt{3/2}-\Theta_n)$ well-posed at every $n$; (ii) the extra kernel enters only through $(P_0HP_0)_-$, and only its $\Pi_{ASD}$-compression is ever read, so padding enlarges $\{F=0\}$ (by the $300$-dimensional $\mathcal W_8$ flat at $n=12$) without touching the inequality; (iii) the derivation needs $\ker u\supseteq A$ and nothing more, which holds already at $n=4$. **No dependence on the kernel being large, and no failure when it is.**

**11.2 The boundary of every stated range; the smallest admissible dimension.** $n=12$ is the boundary and it is strict, not marginal: $\kappa_{12}=-0.1016<0$, so $d^+\Phi\le0$ with equality only on $\{F=0\}$. $n=11$ is on the other side, strictly ($\Theta_{11}^2=\tfrac{40}{27}<\tfrac32$). The real-variable crossover $6+2\sqrt7=11.2915$ sits between them, so no integer is on the boundary and $\kappa_n=0$ occurs at no admissible $n$. The smallest dimension in which the *formula* (i)–(iii) holds is $n=4$; the record's $n\ge12$ is a constraint on (iv) alone, and §10 separates them.

**11.3 Odd $n$.** Checked in §7. The corrected $\Theta_n$ moves $\kappa_n$ at odd $n$ by $6\%$ and moves the crossover not at all. Both odd-$n$ readings of $\kappa_n$ have the same sign at every $n$. The one live residue is which reading L17 uses (§7.3), which matters for the *magnitude* quoted in §8's margin.

**11.4 A claim proven on a subfamily and used in general.** Two candidates, both clean. The $-\tfrac32\theta$ second-order computation is proved for complement-supported $H$ and used only there (§8), correctly scoped; its accompanying *number* is $n=12$'s and is used unscoped, which is §8's finding. The three equality families were used as if they were the equality set, which is exactly what the block's own audit corrects; the correction is right and I confirm it.

**11.5 A hypothesis stated but never used.** $\lVert H\rVert=1$ (§3.3). Also, more mildly, the notebook's "$F$ is convex and $1$-homogeneous" underwrites only a numerical certification procedure ("directed subgradient descent"), never the inequality, which §3.4 proves directly. **I did not verify the convexity of $H\mapsto\mathop{\mathrm{tr}}(\Pi_{ASD}(P_0HP_0)_-)$ and it is not load-bearing**; it should not be cited.

**11.6 A step using a hypothesis never stated.** $Q(u)=\theta u$ (§6), the finding of this round with the widest reach, since every use of L17 as "first-order protection of $\Phi$" silently imports it. Second, smaller: the monotonicity of $\Theta_n$ in each parity (§7.2).

**11.7 An imported theorem whose hypotheses were never checked.** Two imports.
- *Hansen–Pedersen.* Hypotheses checked in §3.1 and they hold. **The named unital-algebra trap does not bite here**, and it is worth saying why: the compression is taken inside $\mathrm{Sym}(\Lambda^2\mathbb R^n)$, a unital matrix algebra, not inside $\mathcal W_n$. $\mathcal W_n$ carries no unit and is not even closed under the operations the step uses, $(P_0HP_0)_-$ is not a Weyl tensor. The argument never needs it to be: Bianchi is consumed on $H$ itself (§3.2) *before* any operator surgery, and everything after is linear algebra on $\Lambda^2$. **This is H9 and it is nowhere stated**; a reader who assumes the calculus stays inside $\mathcal W_n$ will think the step illegal.
- *Daleckii–Krein.* Its hypothesis ($f\in C^1$ on a neighbourhood of the spectrum), **fails**, since $0\in\mathop{\mathrm{spec}}(u)$ and $x\mapsto x_-$ is not differentiable at $0$. The record's citation is therefore loose. It is not wrong in substance: the divided differences $f^{[1]}(\lambda,0)=(f(\lambda)-f(0))/\lambda$ that the mixed $E$–$K$ blocks need are perfectly well defined, the only genuinely non-smooth block is kernel–kernel, and that block is handled separately by degenerate perturbation theory. The correct citation is the one-sided/Lipschitz directional-derivative formula for spectral functions, not DK; the record names DK for the branch where it applies and the perturbation theory for the other, which is the right split with the wrong label on half of it. **Reported as a loose citation, not a gap**, [r476](../reviews/REVIEW_r476.md)'s note that the off-diagonal terms die "**without needing any claim about eigenvector rotations**" is the stronger phrasing and should be the record's.

**11.8 A universal claim with no witness.** $F\ge0$ for all tangent $H$ is universal and its equality set is exhibited, so the sharpness is witnessed. The one witness-free statement is "contains every mixed $E$–$K$ direction" (§4.3).

**11.9 Symbol collisions, five live, one of them fatal to the statement as read.**

| symbol | L17's meaning | the colliding meaning, and where | severity |
| --- | --- | --- | --- |
| $\kappa_n$ | $9(\sqrt{3/2}-\Theta_n)$ or $9(\sqrt{3/2}-\theta_0(n))$, the L16 penalty, **negative for $n\ge12$**; **tabled nowhere** | [conventions.md](../findings/conventions.md): "**The algebra's Killing constant** is $\kappa_n=(2n-1)(n-1)/4$", **positive at every $n$**; also $\kappa^2=\max_Ft_F$ in the $t,\kappa$ row, and $\kappa=2(n-2)$ for $\mathfrak{so}(n)$'s Killing form | **FATAL AS READ.** Under the tabled $\kappa_n$, "$\kappa_n\le0$" is false at every $n$ and L17's conclusion is empty. The one constant the lemma's dimension-dependence turns on is the one constant the conventions file gives an incompatible value for |
| $\Phi$ | the penalized functional $P-\kappa_n\delta^2$ | [conventions.md](../findings/conventions.md) tables **four** unrelated $\Phi$s and this is not among them; sense (ii) is "**Hamilton's map $Q$ itself**", under which "$d^+\Phi=2a\kappa_nF$" is not even type-correct | **HIGH.** The penalized functional has no tabled symbol anywhere |
| $u$ | the competitor $W_{\mathbb{CP}^2}$ | [conventions.md](../findings/conventions.md) $\Pi$ row: "the orbit acceleration $u$ satisfies $\langle u,W\rangle=-\lVert z\rVert^2$, so $u\notin W^\perp$", and note L17 needs $\langle H,u\rangle=0$, the opposite relation | **HIGH**, and self-inflicted: conventions.md itself writes "$\mathrm{Alt}(u_-)=+a\star$ … at the $\mathbb{CP}^2$-type competitor" **in the same file** that tables $u$ as the acceleration. [ATTEMPTS.md](../ATTEMPTS.md) uses $W$ and is clean; the collision entered at the lift |
| $F$ | $F(H)=H_{22}+H_{33}+\mathop{\mathrm{tr}}(\Pi_{ASD}(P_0HP_0)_-)$ | [problem.md](../findings/problem.md), Beitz's $F=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$, in the *same* discussion of L16's cone formulation; and $t_F$'s $F$ = a frame; and $F_u=L(u)$ in [algebra.md](../findings/algebra.md) | **MEDIUM**: four senses, two of them within one page of L17 |
| $\lvert W\rvert$ | the operator absolute value, inside $W_-=\tfrac12(\lvert W\rvert-W)$ | [conventions.md](../findings/conventions.md): "$\lvert W\rvert^2=4\lVert W\rVert_F^2$ relates the two $\Lambda^2$ normalisations"; and [problem.md](../findings/problem.md) states L16 "on $\{\lvert W\rvert=1\}$" | **MEDIUM**, and it sits *inside L17's own defining formula*. $\lvert W\rvert=1$ reads as a norm there and as an operator identity here |
| $a$ | the scalar $\tfrac1{3\sqrt6}$ | [conventions.md](../findings/conventions.md): "$a$ the singular-value vector of $x$" in [isotropy-cap.md](../findings/isotropy-cap.md), a **vector** | LOW (context separates) |
| $B$ | $\Pi_{ASD}H\Pi_{ASD}$ | "**THE LETTER $B$ MEANS TWO THINGS, live**", two Killing forms; plus $b:=z\circ z$, $B^+$ in the orbit calculus | LOW–MEDIUM: L17 makes it a **third** |
| $P_0$, $t$, $\delta$ | kernel projection; curve parameter; the defect | $P$ = the cubic form; $t=t_F=\lVert K\rVert_F^2$; $\delta_A(X)=AX+XA$ in the $\Phi$ row | LOW |

Also unnamed anywhere: the competitor itself carries **four** names across two files, "the $\mathbb{CP}^2$-type competitor", "Fox", "$\mathcal S^4(\alpha)$", "the $P$-positive champion", with the identification made in none of them. And $\Pi_{ASD}$/$\Pi_{SD}$/$\Pi_{\ker u}$ are a fifth family under a letter the conventions file already flags as carrying four.

**11.10 The $W_-$ sign.** The block's own blockquote is correct and I confirm it: $\delta^2$ is a squared norm, hence the same function under either sign convention, so $d^+\Phi\le0$ is convention-free; what flips is the display, and the block is consistently in the record's convention ($W_-\succeq0$, $\mathrm{Alt}(u_-)=+a\star$, $\mathrm{Alt}(W_-)\rvert_{\ker W}=-a\Pi_{ASD}$, $F\ge0$), I used exactly that sign in §2 and it closes.

## 12. What would break it, and what I did to look

**The falsifier.** A single $H\in\mathcal W_n$, $\langle H,u\rangle=0$, with $F(H)<0$. Such an $H$ would break (ii), hence (i)'s usefulness, hence L17 entirely; and because $F$ is $1$-homogeneous, one such $H$ would give a whole ray, and $\{F<0\}$ would be open and non-empty. For (iv) alone the falsifier is weaker: any $n\ge12$ with $\Theta_n<\sqrt{3/2}$, or a competitor that is not critical.

**Where such an $H$ could live.** The chain of §3.4 has exactly three joints, and I attacked each in closed form:

1. *The Jensen compression.* If $\mathop{\mathrm{tr}}(\Pi_{ASD}X_-)<\mathop{\mathrm{tr}}(B_-)$ for some $X$, the chain breaks. I checked Hansen–Pedersen's hypotheses against the object (convexity of $x_-$, $f(0)=0$, $C^*C=\mathrm{id}$) and confirmed that the *operator* form (which would fail, $x_-$ not being operator convex), is not what is used. **No opening.**
2. *The SD/ASD balance.* If some Weyl $H$ had $H_{11}+H_{22}+H_{33}\ne\mathop{\mathrm{tr}}(B)$, $F$ could go negative. But that identity is exactly $\langle H,\star\rangle=0$, which follows from $\mathrm{Alt}(H)=0$, which conventions.md states holds "for every $H$ satisfying the first Bianchi identity, in particular for every Weyl tensor". **No opening**, and this is the joint where a non-Weyl $H$ *does* break the lemma, the falsifier must be a genuine curvature tensor or it proves nothing.
3. *The tangency relation.* $2H_{11}=H_{22}+H_{33}$ is $\langle H,u\rangle=0$ read in $u$'s eigenbasis, an identity, not an estimate. **No opening.**

I also probed the one place the chain is *lossy*, the passage from $\mathop{\mathrm{tr}}(\Pi_{ASD}(P_0HP_0)_-)$ to $\mathop{\mathrm{tr}}(B_-)$ discards the $K'$-directions of the sliver, and found it loses only in the safe direction: the discarded quantity is a trace of a positive semidefinite operator, so it can only raise $F$.

**And for (iv):** I checked $\Theta_n\ge\sqrt{3/2}$ at every $n\ge12$ by proving monotonicity of both parity formulas in closed form (§7.2), and checked the boundary at $n=11$ and $n=12$ exactly in rationals. **No $n\ge12$ escapes.**

**What I did not do.** No numerical search, no sweep, no sampling, the standing analysis-only rule. Every number above is exact rational or radical arithmetic on objects the record already names, done as a screen of a claim I was about to record. A falsifier, if one exists, would have to be exhibited in closed form and would have to break one of the three joints above; I could not construct one, and the three joints are individually airtight.

---

## Verdict

**PROVEN, hypotheses corrected.**

- The formula $d^+\delta^2(u;H)=-2aF(H)$, the constant $a=\tfrac1{3\sqrt6}$, the Jensen reduction, the two structural facts, the chain $F\ge\tfrac23\mathop{\mathrm{tr}}B_++\tfrac13\mathop{\mathrm{tr}}B_-\ge0$, the equality set $\{F=0\}=\{\Pi_{ASD}H\Pi_{\ker u}=0\}$ in both directions, the codimension $\le186$ at $n=12$, and the crossover at $n\ge12$ under the corrected $\Theta_n$: **all re-derived from scratch and all confirmed.**
- **Corrections required in the statement**: add $Q(u)=\theta u$ (used, never stated); drop $\lVert H\rVert=1$ (stated, never used); say which pinning $\kappa_n$ takes; say that $\delta^2$'s calculus runs in $\mathrm{Sym}(\Lambda^2\mathbb R^n)$ and not in $\mathcal W_n$; replace "about $89\%$ of directions" with the dimension count; label the "$18\times$" margin as $n=12$'s.
- **GAP, documentation**: no statement of L17 exists on the record. §10 supplies one.
- **HYPOTHESIS-DEBT, carried in the same block and not part of L17**: the second-order Hessian comparison on the mixed $E$–$K$ directions of $\{F=0\}$, stated precisely in §9. Local maximality of $\Phi$ at the competitor may **not** be cited.
