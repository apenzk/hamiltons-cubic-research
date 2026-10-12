# VERIFY_v186, Lemma L17, first-order protection at the rival maximizer

*Verifier v186, verification loop, round L17. The brief was cold: [BRIEF_L17.md](BRIEF_L17.md) was read before any other file, and every passage attacked below was re-derived from the definitions in [conventions.md](../findings/conventions.md) before being compared with the record. **No numerical work was done**, no script, no Sage, no Python, no floating-point evaluation. The one screen taken is reported as a screen in §9 and is arithmetic on a $2\times2$ matrix built for the purpose. Log: [verify-L17-v186.log](../agent_logs/verify-L17-v186.log).*

## Claim table

| # | claim, as the record states it | verdict |
| --- | --- | --- |
| 1 | $\mathrm{Alt}(u_-)=a\star$ with $a=\tfrac1{3\sqrt6}$, and $\delta^2(u)=\tfrac19$ | **CONFIRMED**, derived in closed form, §2 |
| 2 | $d^+\delta^2(u;H)=-2aF(H)$, $F(H)=H_{22}+H_{33}+\operatorname{tr}(\Pi_{ASD}(P_0HP_0)_-)$ | **CONFIRMED**, derived, §3; independently checked against an exact one-parameter family, §7 |
| 3 | ingredient (a), the smooth branch, "by Daleckii–Krein" | **CONFIRMED AS A VALUE, CITATION INVALID**, DK's hypothesis fails at $0\in\operatorname{spec}(u)$; the theorem that does apply is not cited, §3.3 |
| 4 | ingredient (c), the Jensen/Hansen–Pedersen compression $\operatorname{tr}(\Pi_{ASD}(P_0HP_0)_-)\ge\operatorname{tr}(B_-)$ | **CONFIRMED**, hypotheses checked against the object, §4 |
| 5 | ingredient (d), Bianchi gives $H_{11}+H_{22}+H_{33}=\operatorname{tr}B$ and tangency gives $2H_{11}=H_{22}+H_{33}$ | **CONFIRMED**, each does exactly the work claimed, §5 |
| 6 | the chain $F\ge\tfrac23\operatorname{tr}(B_+)+\tfrac13\operatorname{tr}(B_-)\ge0$ | **CONFIRMED**, §5 |
| 7 | $\{F=0\}=\{H:\Pi_{ASD}H\Pi_{\ker u}=0\}$, a linear subspace | **CONFIRMED FOR $H\in T_uS$; THE DISPLAY DROPS THAT HYPOTHESIS**, closed-form witness $H=u$, §6 |
| 8 | the three families are sufficient, not the equality set; the subspace holds every mixed $E$–$K$ direction | **CONFIRMED**, with a dimension proof that needs no witness, §6.3 |
| 9 | $\operatorname{codim}\{F=0\}\le186$ at $n=12$; at least $1451$ of $1637$ dimensions | **CONFIRMED**, §6.4 |
| 10 | "about $89\%$ of directions" | **REFUTED AS WORDING**, $\{F=0\}$ is a proper subspace, so $0\%$ of directions; $89\%$ is a ratio of dimensions, §6.5 |
| 11 | $d^+\Phi=2a\kappa_nF$, needing $\kappa_n\le0$; dimension-free is $d^+\delta^2\le0$ | **CONFIRMED, ON A HYPOTHESIS STATED NOWHERE IN L17**, the step consumes $Q(u)=\theta^*u$, §8 |
| 12 | $\Theta_{11}=1.21716<\sqrt{3/2}<1.24838=\Theta_{13}$, crossover still at $n\ge12$ | **CONFIRMED; THE DISPLAY OMITS $n=12$ ITSELF**, §10 |
| 13 | the admitted debt, "the mixed flat directions need a Hessian comparison, verified numerically but not yet proven" | **STALE IN BOTH DIRECTIONS**, discharged by L140 modulo owed Gate 2, and understated by two further gaps, §11 |
| 14 | the "$18\times$ margin" for the padded flat | **SUPERSEDED BY THE SAME FILE**, L134(c) retires it, §11.2 |
| 15 | "$F$ is convex … so directed subgradient descent certifies the sign globally" (ATTEMPTS) | **VOID AS WRITTEN**; nothing in L17's chain rests on it, §9 |
| 16 | the canonical entry's content | **STATES NOTHING**, §1 supplies what a consumer may cite |

**Summary in one line.** Every mathematical step of L17 is correct and I re-derived all four of them plus the equality characterisation in closed form; what fails is the record around them, the canonical entry carries no statement, two hypotheses the argument consumes are stated nowhere in it, one imported theorem is cited at an object where its hypothesis fails, one figure and one debt sentence are superseded by lemmas in the same file, and four symbols ($a$, $F$, $\kappa_n$, $u$) collide with tabled objects without being tabled.

**Verdict: PROVEN, hypotheses corrected.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- The defect's sign convention, and it is the load-bearing one here: "**The sign of $W_-$ is $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$, the POSITIVE-SEMIDEFINITE magnitude of the negative part.** *This is forced by the rest of the record rather than chosen*: it is the only sign under which $\mathrm{Alt}(u_-)=+a\star$ with $a=\tfrac1{3\sqrt6}>0$ at the $\mathbb{CP}^2$-type competitor, under which $\mathrm{Alt}(W_-)\rvert_{\ker W}=-a\Pi_{ASD}$, and under which [Lemma L17](../findings/route-a.md)'s $d^+\delta^2=-2aF$ with $F\ge0$ comes out. Under it the Daleckii–Krein multiplier of $x\mapsto x_-$ has every entry in $[-1,0]$".
- The projection that defines the defect: "**$\mathrm{Alt}$ is the ORTHOGONAL PROJECTION of $S^2(\Lambda^2)$ onto $\Lambda^4$**, carrying its $\tfrac13$ … So $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$, $\mathrm{Alt}$ is self-adjoint and idempotent, and $\mathrm{Alt}(H)=0$ for every $H$ satisfying the first Bianchi identity, in particular for every Weyl tensor. **Inside $\Lambda^2\mathbb R^4$, $\Lambda^4$ is one-dimensional and $\mathrm{Alt}$ is the projection onto the Hodge star $\star=\Pi_{SD}-\Pi_{ASD}$, with $\lVert\star\rVert^2=6$.**"
- The pairing, which fixes every constant below: "**The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.** The inner product is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix."
- The dimension: "$\dim\mathcal W_n$ | $\frac{n(n-3)(n+1)(n+2)}{12}$, $10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$".
- The odd-$n$ constant, whose square root the crossover claim turns on: "$\Theta_n$ | the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, **the square root was missing here until 2026-09-04**".
- $\delta^2$ itself is defined at [problem.md](../findings/problem.md) line 376 ("$\delta^2=\|\mathrm{Alt}(W_-)\|^2$ the defect from Observation L15") and not in conventions.md. **The one symbol L17 cannot be read without is tabled nowhere.**

## 1. What a consumer may cite, since the canonical entry states nothing

The canonical entry is a heading over a bare pointer, and the findings block is prose and blockquotes. What the argument actually establishes, and the only form in which it should be cited, is:

> **Lemma L17.** Let $n\ge4$ and let $u\in\mathcal W_n$ be the unit $\mathbb{CP}^2$-type competitor, so that $\Lambda^2\mathbb R^n=E\oplus K$ with $E$ the self-dual $3$-space, $u|_E=\tfrac1{\sqrt6}\operatorname{diag}(2,-1,-1)$ in the orthonormal basis $\hat\omega_1,\hat\omega_2,\hat\omega_3$, and $u|_K=0$; write $K=A\oplus K'$ with $A$ the anti-self-dual $3$-space, $P_0=\Pi_K$, and $a=\tfrac1{3\sqrt6}$. Let $H\in\mathcal W_n$ with $\langle H,u\rangle=0$, and set $B=\Pi_AH\Pi_A$, $D=P_0HP_0$, $F(H)=H_{22}+H_{33}+\operatorname{tr}(\Pi_AD_-)$. Then
>
> 1. $\mathrm{Alt}(u_-)=a\star$ and $\delta^2(u)=\tfrac19$, in every $n\ge4$;
> 2. $d^+\delta^2(u;H)=-2a\,F(H)$;
> 3. $F(H)\ \ge\ \tfrac23\operatorname{tr}(B_+)+\tfrac13\operatorname{tr}(B_-)\ \ge\ 0$, hence $d^+\delta^2(u;H)\le0$ **in every ambient $n\ge4$**;
> 4. $F(H)=0\iff\Pi_AH\Pi_K=0$; this is a linear subspace of $T_uS$, of codimension at most $186$ at $n=12$;
> 5. $u$ is a critical point of $P|_S$ ($Q(u)=\sqrt{3/2}\,u$ at every $n\ge4$) so with $\Phi=P-\kappa_n\delta^2$ one has $d^+\Phi(u;H)=2a\kappa_nF(H)$; consequently $d^+\Phi\le0$ for every $n\ge12$, where $\kappa_n<0$, and $d^+\Phi\ge0$ for $4\le n\le11$, strictly wherever $F>0$.

The hypotheses $\langle H,u\rangle=0$ in (2)–(4) and $Q(u)=\theta^*u$ in (5) are used and are stated in neither the canonical entry, the findings block, nor [ATTEMPTS.md](../ATTEMPTS.md)'s Result 6. They are recovered in §5, §6 and §8. The hypothesis $\lVert H\rVert=1$, which ATTEMPTS does state, is **never used** ($F$ is positively $1$-homogeneous) and is listed as such in the inventory.

## 2. Hypothesis inventory

| hypothesis | where it is stated | where it is used | status |
| --- | --- | --- | --- |
| $H\in\mathcal W_n$, i.e. $H$ satisfies the first Bianchi identity | ATTEMPTS Result 6 | ingredient (d), $\langle H,\star\rangle=0$ | **stated, used, load-bearing** |
| $\langle H,u\rangle=0$ (tangency) | ATTEMPTS Result 6 | ingredient (d), $2H_{11}=H_{22}+H_{33}$; and $F\ge0$; and $\{F=0\}$'s characterisation | **stated in ATTEMPTS, DROPPED in the block's $\{F=0\}$ display** (§6.2) |
| $\lVert H\rVert=1$ | ATTEMPTS Result 6 | nowhere | **stated, never used**, $F$ is $1$-homogeneous |
| $u$ has the spectrum $\tfrac1{\sqrt6}(2,-1,-1)$ on $E$ and $0$ on $K$ | ATTEMPTS Result 6; [route-a.md L135](../findings/route-a.md) | everything | **stated** |
| $Q(u)=\theta^*u$, i.e. $u$ is critical for $P|_S$ | **nowhere in L17**; [problem.md](../findings/problem.md) item 4 and [L2](../findings/problem.md)'s proof carry it; [L134](../findings/route-a.md)'s proof of (b) states it | the step $d^+\Phi=2a\kappa_nF$ and the whole "Consequences" clause | **USED, STATED NOWHERE IN THE LEMMA** (§8) |
| $\kappa_n\le0$ | [results.md](../results.md) line 222 and the block's own crossover bullet | $d^+\Phi\le0$ | **stated** (and it is exactly what makes the conclusion dimension-dependent) |
| $f(x)=x_-$ convex with $f(0)\le0$; the compression is by an isometry | nowhere | ingredient (c), Hansen–Pedersen | **used, unstated; both hold** (§4) |
| the eigenbasis of $\ker u$ is adapted to $A\oplus K'$ | nowhere | "$\mathrm{Alt}(W_-)$ is diagonal in $W$'s eigenbasis" | **used, unstated; harmless** (§3.2) |
| $n\ge4$ | nowhere explicitly | the object exists from $n=4$ | **implicit; the smallest admissible dimension works** (§12) |
| $F$ convex on $T_uS$ | ATTEMPTS Result 6 | only the numerical global certification, which the ledger has already voided | **unproved and not needed** (§9) |

## 3. The one-sided derivative, derived

### 3.1 The base point, and why $a$ is what it is

$u=\tfrac1{\sqrt6}\big(2\hat\omega_1\hat\omega_1^{\mathsf T}-\hat\omega_2\hat\omega_2^{\mathsf T}-\hat\omega_3\hat\omega_3^{\mathsf T}\big)$ has $\lVert u\rVert^2=\tfrac{4+1+1}6=1$ and $\operatorname{tr}_{\Lambda^2}u=\tfrac{2-1-1}{\sqrt6}=0$, in the pairing quoted in §0. Under $W_-=\tfrac12(\lvert W\rvert-W)$,
$$u_-=\tfrac1{\sqrt6}\big(\hat\omega_2\hat\omega_2^{\mathsf T}+\hat\omega_3\hat\omega_3^{\mathsf T}\big).$$
$\Lambda^4$ inside $\Lambda^2\mathbb R^n$ meets $S^2(\Lambda^2\mathbb R^4)$ in the single line $\mathbb R\star$ with $\lVert\star\rVert^2=6$, so $\mathrm{Alt}(u_-)=\tfrac{\langle u_-,\star\rangle}{6}\star$. Since $\star=+1$ on $E$ and $-1$ on $A$ and $0$ elsewhere, $\langle u_-,\star\rangle=\tfrac1{\sqrt6}+\tfrac1{\sqrt6}=\tfrac2{\sqrt6}$, whence
$$\mathrm{Alt}(u_-)=\tfrac{2/\sqrt6}{6}\star=\tfrac1{3\sqrt6}\star=a\star,\qquad \delta^2(u)=a^2\lVert\star\rVert^2=\tfrac6{54}=\tfrac19 .$$
**Both constants are forced, not fitted**, and the record's "verified entrywise exactly" is unnecessary, three lines of algebra give them. The block's claim that $\mathrm{Alt}(W_-)\rvert_{\ker W}=-a\Pi_{ASD}$ is the same computation read on $K$: $\star$ preserves $K=A\oplus K'$, is $-1$ on $A$ and $0$ on $K'$.

*One overstatement.* ATTEMPTS says "the $2{:}1$ eigenvalue ratio is forced by $\operatorname{tr}_{\Lambda^2}W=0$". Tracelessness alone forces $\lambda_1+\lambda_2+\lambda_3=0$; the ratio needs $\lambda_2=\lambda_3$, which comes from the $U(2)$ isotropy and not from the trace. Harmless, since the spectrum is given independently.

### 3.2 The derivative

$\delta^2$ is positively $2$-homogeneous and Lipschitz, so along $\gamma(t)=\cos t\,u+\sin t\,H=u+tH+O(t^2)$ the one-sided derivative equals that along $u+tH$. Since $\lVert\cdot\rVert^2$ is smooth and $\mathrm{Alt}$ is a self-adjoint idempotent with $\mathrm{Alt}(u_-)$ in its range,
$$d^+\delta^2(u;H)=2\big\langle\mathrm{Alt}(u_-),\ \mathcal D\big\rangle=2a\langle\star,\mathcal D\rangle,\qquad \mathcal D:=\tfrac{d}{dt}\Big|_{0^+}(u+tH)_- .$$
$\star$ is **diagonal** in any eigenbasis of $u$ adapted to $E=\langle\hat\omega_1,\hat\omega_2,\hat\omega_3\rangle$, $A$, $K'$, with entries $(+1,+1,+1)$ on $E$, $(-1,-1,-1)$ on $A$, $0$ on $K'$; it is diagonal in the ambient $\Lambda^2\mathbb R^n$ too, because as the $4$-form $e^{1234}$ it has no entry touching an index above $4$. **Hence only the diagonal of $\mathcal D$ survives the pairing**, this is precisely the record's "every eigenvector-rotation term pairs to zero", and it is correct. (The adaptedness of the basis inside the degenerate $0$-eigenspace is needed and is not said; it costs nothing, since a basis adapted to $A\oplus K'$ always exists.)

The blocks of $\mathcal D$, with $f(x)=x_-$, $\alpha=\{\hat\omega_1\}$, $\gamma=\{\hat\omega_2,\hat\omega_3\}$, $\beta=K$:

| block | multiplier | $\star$-entry | contribution to $\langle\star,\mathcal D\rangle$ |
| --- | --- | --- | --- |
| $\alpha\alpha$ | $f'(2/\sqrt6)=0$ | $+1$ | $0$ |
| $\gamma\gamma$ diagonal | $f'(-1/\sqrt6)=-1$ | $+1$ | $-(H_{22}+H_{33})$ |
| $\alpha\gamma$ | $f^{[1]}=\frac{0-1/\sqrt6}{3/\sqrt6}=-\tfrac13$ | $0$ | $0$ |
| $\alpha\beta$ | $0$ | $0$ | $0$ |
| $\gamma\beta$ | $-1$ | $0$ | $0$ |
| $\beta\beta$ | **no multiplier**; the exact block is $(P_0HP_0)_-$ | $-\Pi_A$ on $K$ | $-\operatorname{tr}\big(\Pi_A(P_0HP_0)_-\big)$ |

so $\langle\star,\mathcal D\rangle=-F(H)$ and
$$\boxed{\ d^+\delta^2(u;H)=-2a\,F(H).\ }$$
The multiplier column reproduces [L140](../findings/route-a.md)'s table exactly, which is an independent internal cross-check of the sign convention.

### 3.3 What the non-smoothness costs, and the invalid citation

The $\beta\beta$ entry is the whole of the non-smoothness. $f$ is differentiable everywhere except at $0$, and $0$ is an eigenvalue of $u$ of multiplicity $\binom n2-3$, at $n=12$, $63$ of $66$. Three things follow.

1. **The correct theorem is not Daleckii–Krein.** DK requires $f\in C^1$ on a neighbourhood of $\operatorname{spec}(u)$, and $x\mapsto x_-$ is not differentiable at $0\in\operatorname{spec}(u)$; the multiplier $f^{[1]}(0,0)$ its formula demands does not exist, as [L140](../findings/route-a.md)'s own table concedes ("where the multiplier does not exist because $u$ is degenerate at $0$"). The result that does apply is the directional differentiability of the metric projection onto the positive semidefinite cone (equivalently, the semismoothness of $A\mapsto A_\pm$), whose derivative is exactly the table above, divided differences off the kernel block and $(H_{\beta\beta})_\pm$ on it. **That theorem is cited nowhere on the record.** *Discrepancy protocol.* Located: ATTEMPTS Result 6 ingredient (a), "by Daleckii–Krein", and ingredient (b), "by first-order degenerate perturbation theory". Exhibited: the hypothesis of the named theorem fails at the named object, and "first-order degenerate perturbation theory" is not a theorem about a matrix function's directional derivative. Argued the opposite: the record clearly intends "DK on the blocks where the multipliers exist, plus the kernel block separately", which is true and is what I derived, so this is a citation debt, not a false step. Recorded as such.
2. **The kink is the mechanism, not an obstacle.** $F(H)+F(-H)=\operatorname{tr}\big(\Pi_A\lvert P_0HP_0\rvert\big)\ge0$, the linear part cancelling, so $d^+\delta^2(u;H)+d^+\delta^2(u;-H)\le0$: *both* one-sided slopes can be strictly negative. At a smooth point that is impossible, protection in both $\pm H$ would force the gradient to vanish. **First-order protection in every direction is available only because $\delta^2$ has no derivative at $u$**, and it has none only because $u$ has a kernel.
3. **What is paid for it.** There is no gradient at $u$, so no Lagrange calculus and no two-sided Taylor expansion; the second-order coefficient $c_2$ is itself one-sided, and [L134](../findings/route-a.md) records the consequence, "$\delta^2$ has no third derivative at $u$ at all", so the remainder step that turns a per-direction second-order bound into a neighbourhood statement is not available by differentiation.

## 4. The Jensen step, and the unital-algebra trap

Claim (c): $\operatorname{tr}\big(\Pi_{ASD}(P_0HP_0)_-\big)\ge\operatorname{tr}(B_-)$, $B=\Pi_AH\Pi_A$.

Since $A\subseteq K$, $\Pi_A P_0=\Pi_A$, so $B$ is the compression of $M:=P_0HP_0$ to $A$: $B=C^{*}MC$ for $C:A\hookrightarrow K$ the inclusion, an isometry and a fortiori a contraction. $f(x)=x_-$ is convex on $\mathbb R$ with $f(0)=0\le0$. Hansen–Pedersen's Jensen trace inequality then gives $\operatorname{tr}f(C^*MC)\le\operatorname{tr}\big(C^*f(M)C\big)$, i.e. exactly
$$\operatorname{tr}(B_-)\ \le\ \operatorname{tr}\big(\Pi_AM_-\big).$$
**Both hypotheses are met and neither is stated on the record.** They are cheap, but the convexity-plus-$f(0)\le0$ pair is the whole content of the theorem and a reader cannot check the step without them.

**The named trap is avoided.** The theorem is applied to the algebra of symmetric operators on the finite-dimensional space $K=\ker u$, which is unital with unit $\Pi_K$, it is *not* applied to $\mathcal W_n$, which has no unit. The route that died on that trap does not recur here.

## 5. The two structural facts, each checked against the work it is asked to do

**Bianchi.** $\mathrm{Alt}$ annihilates every Weyl tensor and $\star$ spans $\Lambda^4$ inside $\Lambda^2\mathbb R^4$, so $\langle H,\star\rangle=\langle\mathrm{Alt}(H),\star\rangle=0$. Reading $\star$ diagonally as in §3.2,
$$0=\langle H,\star\rangle=H_{11}+H_{22}+H_{33}-\operatorname{tr}(B).$$
This is exactly "a self-dual/anti-self-dual trace balance on the distinguished $4$-plane", and it does exactly the work claimed: it is the only place the anti-self-dual block $B$ enters the *linear* part of $F$. **Load-bearing and correct.**

**Tangency.** $\langle H,u\rangle=\tfrac1{\sqrt6}(2H_{11}-H_{22}-H_{33})=0$ gives $2H_{11}=H_{22}+H_{33}$. It "fixes the remaining diagonal entry against" the balance, as claimed. *One correction:* the block attributes this to "**unit-norm** tangency"; the unit norm plays no part, only $H\perp u$ does. Eliminating $H_{11}$,
$$H_{22}+H_{33}=\tfrac23\operatorname{tr}(B),\qquad F=\tfrac23\operatorname{tr}(B)+\operatorname{tr}(\Pi_AM_-)\ \ge\ \tfrac23\big(\operatorname{tr}B_+-\operatorname{tr}B_-\big)+\operatorname{tr}(B_-)=\tfrac23\operatorname{tr}B_++\tfrac13\operatorname{tr}B_-\ \ge\ 0 .$$
The $(\tfrac23,\tfrac13)$ pair is therefore the $2{:}1$ trace-free spectrum meeting the Bianchi balance, exactly as the block says. **Chain confirmed.**

## 6. The equality set

### 6.1 The characterisation, both directions

$F=0$ forces both inequalities of §5 to be tight. Tightness of the second gives $\operatorname{tr}B_+=\operatorname{tr}B_-=0$, hence $B_\pm=0$ and $B=0$; tightness of the first then gives $\operatorname{tr}(\Pi_AM_-)=0$, which with $M_-\succeq0$ and $\Pi_A$ an orthogonal projection forces $\Pi_AM_-=0$.

*Forward.* $\Pi_AM=0$ makes $M=0\oplus M'$ on $A\oplus K'$, so $M_-=0\oplus M'_-$ and $B=0$: $F=0$.

*Converse.* With $B=0$, write $M=\begin{pmatrix}0&X\\X^*&Y\end{pmatrix}$ on $A\oplus K'$. $\Pi_AM_-=0$ makes $M_-=0\oplus Z$, so $M_+=M+M_-=\begin{pmatrix}0&X\\X^*&Y+Z\end{pmatrix}$. A positive semidefinite matrix with a vanishing diagonal block has the whole corresponding block-row zero, so $X=0$, i.e. $\Pi_AM=0$.

$$\boxed{\ \{F=0\}=\{H\in T_uS:\ \Pi_{ASD}H\Pi_{\ker u}=0\}\ }$$
**and it is a linear subspace, as the audit says.** ATTEMPTS' "equality iff $B=0$ and the sliver has zero ASD-trace" is the same set, and the audit's claim that ATTEMPTS states the correct iff is confirmed.

### 6.2 The hypothesis the display drops

*Discrepancy protocol, cleared.* **Located:** the block writes the set as $\{H:\Pi_{ASD}H\Pi_{\ker u}=0\}$, unquantified. **Exhibited in closed form:** take $H=u$, a unit Weyl tensor with $\Pi_Au\Pi_K=0$, since $u$ vanishes on $K$ entirely. Then $H_{22}=H_{33}=-\tfrac1{\sqrt6}$ and $D=P_0uP_0=0$, so
$$F(u)=-\tfrac2{\sqrt6}=-0.8164\ldots\ \ne 0,$$
which also shows $F\ge0$ is false without tangency. **Argued the opposite:** ATTEMPTS quantifies over $H$ with $\langle H,W\rangle=0$ and the block's own surrounding prose is about $T_uS$, so the intended reading is $\{H\in T_uS:\cdots\}$, under which §6.1 proves it. **Reported as a display correction**, not as a defect in the mathematics: restore "$H\in T_uS$" to the set-builder.

### 6.3 The three families are sufficient, not the equality set

Each named family lies in the subspace, in one line: the orbit tangents $[\mathrm{ad}(v),u]$ have $P_0HP_0=0$ because $u$ vanishes on $K$; the hyper-Kähler-rotation tangents are supported on $E$, so $H\Pi_K=0$; the padded $\mathcal W_{n-4}$ is supported on $\Lambda^2\mathbb R^{n-4}\subseteq K'\perp A$, so $\Pi_AH=0$. **Confirmed.**

The claim that the subspace also holds **every mixed $E$–$K$ direction** is confirmed with no case work: if $H=\left(\begin{smallmatrix}0&X\\X^*&0\end{smallmatrix}\right)$ on $E\oplus K$ then $P_0HP_0=0$, so $\Pi_AH\Pi_K=0$. **And the "not the equality set" claim needs no witness at all**, §6.4 gives $\dim\{F=0\}\ge1451$ at $n=12$ against the orbit's $34$ and the padded flat's $\dim\mathcal W_8=\tfrac{8\cdot5\cdot9\cdot10}{12}=300$, so the three families cannot span it whatever the hyper-Kähler summand contributes. The record's route (exhibit a fourth family), is weaker than the dimension count it already has in hand.

### 6.4 The codimension

$\Pi_AH\Pi_K$ is a $3\times\dim K$ array; at $n=12$, $\dim\Lambda^2\mathbb R^{12}=66$ and $\dim K=63$, giving $189$ entries, of which the $A\times A$ sub-block is symmetric and so carries $3$ redundancies. **$189-3=186$ independent linear conditions**, hence $\operatorname{codim}\{F=0\}\le186$, the inequality being right, since Bianchi and $H\perp u$ may make some of them dependent on $T_uS$. With $\dim\mathcal W_{12}=\tfrac{12\cdot9\cdot13\cdot14}{12}=1638$ and $\dim T_uS=1637$, the subspace has dimension at least $1637-186=1451$. **Every number in the bullet checks.**

### 6.5 "About $89\%$ of directions" is the wrong noun

*Discrepancy protocol, cleared.* **Located:** [route-a.md](../findings/route-a.md) line 81, "it holds at least $1451$ of $T_uS$'s $1637$ dimensions, **about $89\%$ of directions**". **Exhibited:** $\{F=0\}$ is a *proper* subspace (§7's $H_0$ is a closed-form unit tangent direction with $F(H_0)=\tfrac2{\sqrt6}>0$) so it is a Lebesgue-null set in $T_uS$ and carries measure zero on the unit sphere of directions. The fraction of directions on which the protection is an equality is $0$, not $0.886$. **Argued the opposite:** $1451/1637=0.886$ is a true statement about *dimensions*, which is what the same sentence says four words earlier. So the correction is to the last three words: read "at least $89\%$ of the dimensions". **The substantive consequence runs the block's way and against its rhetoric**: first-order protection is *strict* in almost every direction, and the second-order programme is needed only on a null (though high-dimensional), subspace.

## 7. An exact family that confirms the formula, and exhibits the kink

Let $H_0=\tfrac1{\sqrt6}\big(2\hat\eta_1\hat\eta_1^{\mathsf T}-\hat\eta_2\hat\eta_2^{\mathsf T}-\hat\eta_3\hat\eta_3^{\mathsf T}\big)$ on the anti-self-dual $3$-space $A$, the padded Weyl tensor of $\overline{\mathbb{CP}^2}$. It is a unit Weyl tensor with $\langle H_0,u\rangle=0$ ($E\perp A$), so $H_0\in T_uS$.

*By the formula.* $H_{22}=H_{33}=0$; $D=P_0H_0P_0=H_0$; $D_-=\tfrac1{\sqrt6}(\hat\eta_2\hat\eta_2^{\mathsf T}+\hat\eta_3\hat\eta_3^{\mathsf T})$, so $\operatorname{tr}(\Pi_AD_-)=\tfrac2{\sqrt6}$ and $F(H_0)=\tfrac2{\sqrt6}$, giving $d^+\delta^2=-2a\cdot\tfrac2{\sqrt6}=-\tfrac{4}{3\cdot6}=-\tfrac29$. The chain is tight here: $\operatorname{tr}B_+=\operatorname{tr}B_-=\tfrac2{\sqrt6}$ and $\tfrac23\cdot\tfrac2{\sqrt6}+\tfrac13\cdot\tfrac2{\sqrt6}=\tfrac2{\sqrt6}=F$.

*Directly, with no perturbation theory.* $u+tH_0$ is block-diagonal on $E\oplus A$ with spectrum $\tfrac1{\sqrt6}(2,-1,-1)$ on $E$ and $\tfrac t{\sqrt6}(2,-1,-1)$ on $A$. For every real $t$, $\langle(u+tH_0)_-,\star\rangle=\tfrac2{\sqrt6}-\tfrac{2\lvert t\rvert}{\sqrt6}$, so
$$\delta^2(u+tH_0)=\frac{\big(2(1-\lvert t\rvert)/\sqrt6\big)^2}{6}=\frac{(1-\lvert t\rvert)^2}{9},\qquad d^{\pm}\delta^2=\mp\tfrac29 \ \text{ read as one-sided slopes } -\tfrac29 \text{ in both directions.}$$
**The two agree exactly, at $-\tfrac29$, and they agree for $H_0$ and for $-H_0$ alike**, a closed-form exhibition of the kink, of $F(H_0)=F(-H_0)=\tfrac2{\sqrt6}$, and of the identity $F(H)+F(-H)=\operatorname{tr}(\Pi_A\lvert D\rvert)=\tfrac{2+1+1}{\sqrt6}$ from §3.3. This is the strongest single check available without computation and the record does not contain it.

## 8. The dimension dependence, and the hypothesis it hides

$\Phi=P-\kappa_n\delta^2$, so $d^+\Phi(u;H)=d^+P(u;H)-\kappa_n\,d^+\delta^2(u;H)$. The stated formula $d^+\Phi=2a\kappa_nF$ holds **if and only if $d^+P(u;H)=0$ for every $H\in T_uS$**, i.e. iff $u$ is a critical point of $P|_S$. Neither the block nor ATTEMPTS Result 6 says so anywhere; the "Consequences" clause jumps straight from $d^+\delta^2=-2aF$ to $d^+\Phi\le0$.

The hypothesis is **true and cheap**: $\mathfrak{su}(2)_+$ is a subalgebra of $\mathfrak{so}(4)\subset\mathfrak{so}(n)$, so $u^2$ and $u^{\#}$ are both supported on $E$ and are the same matrices at every $n\ge4$, whence $Q(u)=\sqrt{3/2}\,u$ and $d^+P(u;H)=3\langle Q(u),H\rangle=3\sqrt{3/2}\langle u,H\rangle=0$. The record carries it twice, [problem.md](../findings/problem.md) item 4 ("$Q(W)=\theta W$ holds exactly, with $\theta=\sqrt{3/2}$ independent of $n$") and [L2](../findings/problem.md)'s proof, and [L134](../findings/route-a.md)'s proof of (b) invokes it ("$P$'s first derivative vanishes by criticality"). **It is stated everywhere except in the lemma that consumes it.**

With it, both halves of the brief's dimension question resolve:

- **$d^+\delta^2\le0$ is dimension-free.** Nothing in §3–§5 mentions $n$: the spectrum of $u$, $\star$, $a$, $\delta^2(u)=\tfrac19$, the multiplier table, Bianchi and tangency are identical at every $n\ge4$. **Confirmed.**
- **$d^+\Phi\le0$ is not.** $\kappa_n=9\big(\sqrt{3/2}-\theta_0(n)\big)$ ([route-a.md](../findings/route-a.md) line 198), so $d^+\Phi=2a\kappa_nF$ is $\le0$ exactly when $\kappa_n\le0$. The landscape line at [results.md](../results.md) 222 is therefore right to strike "in any dimension", and its correction is the correct one. Below the crossover the same formula gives $d^+\Phi\ge0$, strictly wherever $F>0$, and §7's $H_0$ is a closed-form direction where $F>0$, so the escape is witnessed rather than asserted.

*One staleness, recorded because it is in the same sentence.* [route-a.md](../findings/route-a.md) line 198 still pins $\kappa_n$ to $\theta_0(n)$ and states $\Phi(u)=\theta_0(n)$, whereas [Conjecture L16](../findings/problem.md) has been restated against $\Theta_n$, under which $\kappa_n=9(\sqrt{3/2}-\Theta_n)$ and $\Phi(u)=\Theta_n$, differing at every odd $n$. **L17 is unaffected**, because it consumes only the sign of $\kappa_n$ and §10 shows the sign is the same under both readings; but the display is in the superseded constant.

## 9. The convexity claim, screened

ATTEMPTS Result 6 asserts "$F$ is convex and $1$-homogeneous on the tangent space, so directed subgradient descent certifies the sign globally". $1$-homogeneity is immediate. Convexity reduces to convexity of $M\mapsto\operatorname{tr}(\Pi M_-)$, and [LEDGER.md](../findings/LEDGER.md) line 314 already records that "**[ATTEMPTS.md](../ATTEMPTS.md)'s convexity claim for $N\mapsto\operatorname{tr}(\Pi N_-)$ is contradicted by a screen; the Hansen–Pedersen step does not need it, so nothing rests on the claim**".

*My own screen, reported as a screen and not as evidence.* On $2\times2$ symmetric matrices with $\Pi=\operatorname{diag}(1,0)$, $N_1=\operatorname{diag}(-1,0)$ and $N_2=\left(\begin{smallmatrix}0&1\\1&0\end{smallmatrix}\right)$ give values $1$ and $\tfrac12$, and their midpoint $\left(\begin{smallmatrix}-1/2&1/2\\1/2&0\end{smallmatrix}\right)$ gives $\lvert\lambda_-\rvert\,v_-^2\approx0.585\le0.75$, consistent with convexity, so this instance neither confirms nor refutes the ledger's screen. I adjudicate nothing.

**What matters is the consequence, and it is one-directional.** The analytic chain of §5 never uses convexity, so $F\ge0$ stands on its own. The sentence that does not stand is the *certification*: "$\inf F=0$ is attained: $F$ is convex and $1$-homogeneous, so directed subgradient descent certifies the sign globally". With convexity in doubt, subgradient descent certifies nothing global, and the attainment claim rests on §6's equality set rather than on that argument. **Recorded as `void as written`, with the lemma unaffected.**

## 10. The crossover under the corrected $\Theta_n$

Using the odd-$n$ formula quoted in §0, with its square root:
$$\Theta_{11}^2=\frac{2\cdot10\cdot8}{12\cdot9}=\frac{160}{108}=1.481481\ldots,\qquad \Theta_{13}^2=\frac{2\cdot12\cdot10}{14\cdot11}=\frac{240}{154}=1.558441\ldots$$
so $\Theta_{11}=1.217161\ldots$ and $\Theta_{13}=1.248375\ldots$ against $\sqrt{3/2}=1.224744\ldots$. **Both printed values are correct to their five decimals and the ordering $\Theta_{11}<\sqrt{3/2}<\Theta_{13}$ holds.**

**The display omits the dimension the claim is about.** "The crossover still lands at $n\ge12$" is a statement about $n=12$, which is even and therefore governed by $\theta_0$, not by the odd formula: $\theta_0(12)^2=\tfrac{2\cdot11\cdot10}{144}=\tfrac{220}{144}=1.5278>\tfrac32$. That value is on the record at [problem.md](../findings/problem.md) line 376 and in [L2](../findings/problem.md)'s proof, but not in this bullet, whose chain steps from $11$ to $13$ over the one integer at issue. Nor is monotonicity beyond $13$ argued here; [L2](../findings/problem.md) supplies it, in the clean form $\theta_0(n)^2-\tfrac32=\tfrac{n^2-12n+8}{2n^2}$ with roots $6\pm2\sqrt7\approx11.29$, and $\Theta_n^2-\tfrac32=\tfrac{n^2-13n+18}{2(n+1)(n-2)}$ with roots $\tfrac{13\pm\sqrt{97}}2\approx11.42$. **No integer lies between $11.29$ and $11.42$, and none sits at either root, so $\kappa_n<0$ for every $n\ge12$ and $\kappa_n>0$ for every $4\le n\le11$, at both parities and under both the $\theta_0$ and the $\Theta_n$ pinning.** The crossover claim is confirmed; the bullet is confirmed as an *incomplete* display of it, and a consumer should cite [L2](../findings/problem.md) rather than this bullet.

## 11. The admitted debt, stated exactly

### 11.1 What is owed

The block's sentence is "the mixed flat directions need a Hessian comparison, verified numerically but not yet proven". **It is stale in both directions.**

*Discharged since.* [L134](../findings/route-a.md) reduces the second-order obligation at $u$ to $c_2(H)\le\theta^*/(2\lvert\kappa_n\rvert)$ on $\{F=0\}\cap T_u\mathcal O^\perp$; [L136](../findings/route-a.md) signs the cross term to give $\Delta_2\le\lVert g_1\rVert^2$ on the cone; [L140](../findings/route-a.md) proves $\lVert g_1\rVert^2\le\tfrac14$ by recentring the Daleckii–Krein multipliers on the midpoint of their range, whence $c_2\le\tfrac5{36}<0.3591$. **A proof now exists where the block says there is none**, and L140 tests it precisely on the mixed/vector isotype the block calls open.

*Understated.* What that chain still owes is **three** things, not the one the block names, and none is a Hessian comparison on the flat:

1. **Gate 2 on [L136](../findings/route-a.md) and on [L140](../findings/route-a.md)**, both blocks say "Gate 2 owed" in their own headnotes. L136's predecessors L137, L138 and L139 were all withdrawn, so the standard of evidence here is not high.
2. **[L134](../findings/route-a.md)'s remainder step**, a per-direction $t^2$ bound is not a neighbourhood statement, and $\delta^2$ has no third derivative at $u$, so the $O(t^3)$ term comes from a Rellich branch whose radius depends on $H$.
3. **The near-cone joint-order gap**, named by r429 and recorded at [L140](../findings/route-a.md): L136's cross-term sign holds on $\{F=0\}$ only, and off it the first-order margin is $O(F)\cdot t$ against a $t^2$ term, so the admissible radius collapses as $F\downarrow0$. **No lemma runs the two orders jointly.**

**None of this touches L17.** L17's own chain is first-order, closed-form, and carries no numerical dependence. The numerical sentence in the block belongs to the second-order programme that the prose folds in around it.

### 11.2 The superseded figure

The block's prose says the padded flat "has since been checked at second order and is safe by an $18\times$ margin". The $18.1$ is $\tfrac{3\theta^*}{2\lvert\kappa_{12}\rvert}$ with $\theta^*=\sqrt{3/2}$ and $\lvert\kappa_{12}\rvert=0.10159$, and ATTEMPTS derives it from an unexplained "at most $2\lvert\kappa_n\rvert$" ceiling on the defect's second-order gain. [L134](../findings/route-a.md), in the same file, says outright that "**(c) supersedes the $18\times$ figure** with an exact identity", $c_2(H)=\delta^2(H)-\tfrac19\le\tfrac5{36}$, from the disjoint-support direct-sum rule. **The L17 block quotes a figure its own file has retired.**

## 12. The traps, each answered by name

| trap | finding |
| --- | --- |
| **$\ker W\ne0$; what the argument does at a padded object** | The kernel is not an obstacle here but the mechanism: it is where $x\mapsto x_-$ is non-differentiable, and §3.3 shows that without the kink no first-order protection in *both* $\pm H$ is possible. At the padded object $\dim\ker u=\binom n2-3$ grows with $n$ while $\Pi_A$ stays $3$-dimensional, so the sliver term $\operatorname{tr}(\Pi_A D_-)$ reads only a fixed $3\times3$ compression however large the padding, which is exactly why the conclusion is $n$-free. **No defect.** |
| **boundary of every stated range** | $\kappa_{12}=9(\sqrt{3/2}-\theta_0(12))=-0.10159\ldots<0$ strictly, and $\kappa_{11}>0$ strictly; no integer sits at a root (§10). The other boundary, $F=0$, is attained on a subspace of dimension $\ge1451$, and the lemma states $\le$ rather than $<$ throughout, correctly. **No defect.** |
| **the smallest admissible dimension** | $n=4$. There $K=A$, $K'=0$, so $M=B$ and the Hansen–Pedersen step is an identity rather than an inequality; the chain degenerates gracefully and $d^+\delta^2\le0$ still holds. The record never states $n\ge4$ and never checks it. **No defect, an unstated scope.** |
| **odd $n$** | The only $n$-dependence is in $\kappa_n$, and §10 checks both parity formulas separately, including the square root that was missing from $\Theta_n$ until 2026-09-04. The first-order lemma itself is parity-blind. **The block's crossover bullet is correct but skips $n=12$** (§10). |
| **proven on a subfamily, used in general** | The proof runs on the SD-supported padded $W_{\mathbb{CP}^2}$, and the statement names $W_{\mathcal S^4(\alpha)}$. [problem.md](../findings/problem.md) item 4 explicitly distinguishes "the literal $\mathbb{CP}^2$ zero-padded into $\mathbb R^n$" from "the actual persistent low-dimensional competitor … identified as Fox's $\mathcal S^4(\alpha)$", while [second-order.md](../findings/second-order.md) line 317 equates them ("Fox $\mathcal S^4(\alpha)=$ padded $W_{\mathbb{CP}^2}$"). **The record contradicts itself on which object $u$ is.** L17's proof commits to the padded-$W_{\mathbb{CP}^2}$ reading (nothing else has the $\tfrac1{\sqrt6}(2,-1,-1)\oplus 0$ spectrum the whole argument runs on) and under that reading everything checks. *Recorded as an identity ambiguity to be resolved in the record, not as a defect in the proof.* |
| **hypothesis stated but never used** | $\lVert H\rVert=1$ (§2): $F$ is $1$-homogeneous, so the normalisation is cosmetic at first order. |
| **step using a hypothesis never stated** | Two. $Q(u)=\theta^*u$, which the whole $\Phi$ conclusion consumes (§8); and $H\in T_uS$, dropped from the $\{F=0\}$ set-builder, with the closed-form counterexample $H=u$ giving $F=-\tfrac2{\sqrt6}$ (§6.2). Also the unstated hypotheses of Hansen–Pedersen (§4) and the adaptedness of the kernel eigenbasis (§3.2). |
| **universal claim with no witness** | The "mixed $E$–$K$ directions" claim is a containment and needs no witness (§6.3), and the stronger "three families are not the equality set" is settled by the dimension count rather than by exhibiting a fourth family. Separately, §7 supplies the witness the record lacks for $F>0$, needed, because without one "$F\ge0$" would be compatible with $F\equiv0$ and the whole first-order story would be vacuous. |
| **imported theorem, hypotheses unchecked** | Hansen–Pedersen: hypotheses checked and met, and the unital-algebra trap avoided because the theorem is applied on $\ker u$, not on $\mathcal W_n$ (§4). Daleckii–Krein: **hypothesis fails at the object** ($x\mapsto x_-$ is not $C^1$ at $0\in\operatorname{spec}(u)$) and the theorem that does apply is cited nowhere (§3.3). |
| **symbol collisions** | §13. |

## 13. Symbol collisions

[conventions.md](../findings/conventions.md) says of $\Pi$ that "**the letter carries four unrelated objects and they must be read from context**" and that "Sense (i) is meant below", sense (i) being the projection onto $W^{\perp}$. **L17 uses none of the four.** Its $\Pi_{ASD}$, $\Pi_{SD}$, $\Pi_{\ker u}$ are subscripted projections onto named subspaces of $\Lambda^2$, a fifth sense, unambiguous in context but absent from the table, and the table's own "sense (i) is meant below" is false for this lemma.

| symbol | L17's object | what it collides with | tabled? |
| --- | --- | --- | --- |
| $a$ | $\tfrac1{3\sqrt6}$, the $\star$-coefficient of $\mathrm{Alt}(u_-)$ | "$a$ the singular-value vector of $x$" in [isotropy-cap.md](../findings/isotropy-cap.md), tabled at conventions.md line 27 | **no** |
| $F$ | the scalar first-order form $F(H)$ | $F_u(h)=u\circ h$ in [L134](../findings/route-a.md)'s own proof; the frame subscript $t=t_F$ at conventions.md line 23; the $F_\lambda$ block spectra at [route-a.md](../findings/route-a.md) line 188, **four senses, three of them inside route-a.md** | **no** |
| $\kappa_n$ | $9(\sqrt{3/2}-\theta_0(n))$, the penalty coefficient | "**The algebra's Killing constant** is $\kappa_n=(2n-1)(n-1)/4$" at conventions.md line 117, *same letter, same subscript, different object, and only the Killing one is tabled*; plus $\kappa^2=\max_Ft_F$ at line 23 and $\kappa:=nc_p$ at [second-order.md](../findings/second-order.md) line 1251, which that file itself flags as colliding "inside the same display" | **no** |
| $u$ | the competitor tensor | "the orbit acceleration $u$ satisfies $\langle u,W\rangle=-\lVert z\rVert^2$", conventions.md line 31, the one place $\Pi$'s sense (i) is explained | **no** |
| $B$ | $\Pi_{ASD}H\Pi_{ASD}$ | $B=\tfrac\theta2\mathrm{Id}-L_W$ at conventions.md line 32, which already announces itself as "a third object under the letter $B$"; **and $B=H_{EE}$ in [L136](../findings/route-a.md), fifty lines below L17 in the same file** | **no** |
| $\theta$ | $\theta^*=P(u)=\sqrt{3/2}$ in the $18\times$ and $-\tfrac32\theta$ displays | the generic $\theta=P(W)/\lVert W\rVert^3$ of conventions.md line 17 | signalled in [route-a.md](../findings/route-a.md) line 198, unsignalled in ATTEMPTS |

**Recommendation:** table $a$, $F$, $u$ and (most urgently), L17's $\kappa_n$, which is the only case where the collision is exact in both letter and subscript with an object that *is* tabled.

## 14. What would falsify it, and what I did to look for it

**The object.** An $H\in\mathcal W_n$ with $\langle H,u\rangle=0$ and $F(H)<0$, equivalently, a tangent direction along which the defect strictly increases to first order at the competitor. Any such $H$ refutes claim (3) of §1 outright, and with it $d^+\Phi\le0$ at every $n\ge12$. A weaker falsifier: an $H\in T_uS$ with $\Pi_AH\Pi_K\ne0$ but $F(H)=0$, or with $\Pi_AH\Pi_K=0$ but $F(H)\ne0$; either breaks the equality characterisation and the $186$.

**Where I looked, all in closed form.**

- *The extremal anti-self-dual direction.* $H_0=$ padded $\overline{\mathbb{CP}^2}$ (§7) is the direction that puts as much negative mass into $A$ as a unit Weyl tensor can, and it is where the chain $F\ge\tfrac23\operatorname{tr}B_++\tfrac13\operatorname{tr}B_-$ is **tight**, so it is the natural place for the bound to fail. It gives $F=+\tfrac2{\sqrt6}$, and the exact family $\delta^2(u+tH_0)=(1-\lvert t\rvert)^2/9$ confirms the sign on both sides.
- *Both signs.* $F(H)+F(-H)=\operatorname{tr}(\Pi_A\lvert P_0HP_0\rvert)\ge0$ makes $F<0$ in *both* directions impossible, so a falsifier must be one-sided, which forces $\operatorname{tr}B$ negative and hands the direction straight back to the chain.
- *The structural entry points.* A falsifier must break one of exactly three steps: Bianchi ($\mathrm{Alt}(H)=0$, unavailable to a Weyl tensor), tangency (which I did break, deliberately, at $H=u$ in §6.2, and it is what produces $F<0$, confirming that tangency is the load-bearing hypothesis and not decoration), or Hansen–Pedersen (whose hypotheses I checked against the object in §4). There is no fourth.
- *The equality characterisation.* Both inclusions are proved in §6.1, the converse turning on the fact that a positive semidefinite matrix with a vanishing diagonal block has that whole block-row zero. A falsifier would need a PSD matrix violating that, which does not exist.
- *The dimension dependence.* A falsifier for the $\Phi$ conclusion would be an $n\ge12$ with $\kappa_n>0$; §10 excludes every one at both parities, the two crossover roots $6+2\sqrt7$ and $\tfrac{13+\sqrt{97}}2$ both lying strictly inside $(11,12)$.

**No falsifier was found, and none was screened numerically.** Everything above is exhibited in closed form or ruled out by an inclusion proof.

## Verdict

**PROVEN, hypotheses corrected.**

The mathematics is correct throughout: $d^+\delta^2(u;H)=-2aF(H)$, the chain $F\ge\tfrac23\operatorname{tr}B_++\tfrac13\operatorname{tr}B_-\ge0$, the equality characterisation $\{F=0\}=\{H\in T_uS:\Pi_AH\Pi_K=0\}$, the codimension $186$ at $n=12$, the dimension-freedom of $d^+\delta^2\le0$, the dimension-dependence of $d^+\Phi\le0$, and the crossover values under the corrected $\Theta_n$ all check, and I re-derived each from the definitions rather than reading it. The corrections owed to the record are:

1. **Give the canonical entry a statement**, §1, with the two hypotheses restored.
2. **State $Q(u)=\sqrt{3/2}\,u$ in the lemma**, since the $\Phi$ conclusion consumes it and it appears only in [problem.md](../findings/problem.md) and in [L134](../findings/route-a.md)'s proof.
3. **Restore "$H\in T_uS$" to the $\{F=0\}$ display**; $H=u$ satisfies the linear condition and has $F=-\tfrac2{\sqrt6}$.
4. **Replace the Daleckii–Krein citation** with the directional-derivative theorem for $A\mapsto A_-$, whose hypotheses the object satisfies; DK's do not.
5. **Fix "$89\%$ of directions" to "$89\%$ of the dimensions"**, $\{F=0\}$ is a null subspace.
6. **Retire the $18\times$ figure** in favour of [L134](../findings/route-a.md)(c), and **rewrite the debt sentence**: the mixed directions are covered by [L140](../findings/route-a.md) modulo its owed Gate 2, and what is actually open is L134's remainder step and the near-cone joint-order gap.
7. **Void ATTEMPTS' subgradient-descent certification of $F\ge0$**; the analytic chain does not need it and the convexity it rests on is already contradicted by a screen on the record.
8. **Table $a$, $F$, $u$ and $\kappa_n$** in [conventions.md](../findings/conventions.md); $\kappa_n$ collides exactly, letter and subscript, with the tabled Killing constant.
