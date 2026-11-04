# VERIFY_v185, Lemma L17, first-order protection at the rival maximizer

**Cold read of [BRIEF_L17.md](BRIEF_L17.md), against [conventions.md](../findings/conventions.md), [route-a.md](../findings/route-a.md), [results.md](../results.md), [problem.md](../findings/problem.md) and [ATTEMPTS.md](../ATTEMPTS.md).** **No numerical work of any kind was done**, no script, no Sage, no evaluation; every number below is exact arithmetic on rationals and square roots, carried out by hand as a screen of a claim being recorded, which is the one allowance the programme's analysis-only rule leaves open. Log: [agent_logs/verify-L17-v185.log](../agent_logs/verify-L17-v185.log).

## Claim table

| # | claim as the record states it | verdict |
| --- | --- | --- |
| 1 | $\mathrm{Alt}(u_-)=a\star$ with $a=\tfrac1{3\sqrt6}$, and $\delta^2(u)=\tfrac19$ | **CONFIRMED**, re-derived from scratch, both exact |
| 2 | $d^+\delta^2(u;H)=-2aF(H)$, $F(H)=H_{22}+H_{33}+\mathop{\mathrm{tr}}(\Pi_{ASD}(P_0HP_0)_-)$ | **CONFIRMED**, derived in full, §3 |
| 3 | ingredient (a): smooth branch $=-2a(H_{22}+H_{33})$ by Daleckii–Krein | **CONFIRMED** |
| 4 | ingredient (b): kink branch $=2\langle\mathrm{Alt}(W_-),(P_0HP_0)_-\rangle$, with $\mathrm{Alt}(W_-)\vert_{\ker W}=-a\Pi_{ASD}$ | **CONFIRMED** |
| 5 | ingredient (c): Jensen compression $\mathop{\mathrm{tr}}(\Pi_{ASD}(P_0HP_0)_-)\ge\mathop{\mathrm{tr}}(B_-)$ | **CONFIRMED**, and it needs no imported theorem, §5 gives a four-line elementary proof |
| 6 | ingredient (d): Bianchi forces $H_{11}+H_{22}+H_{33}=\mathop{\mathrm{tr}}(B)$; tangency forces $2H_{11}=H_{22}+H_{33}$ | **CONFIRMED**, both, and both are load-bearing |
| 7 | $F\ge\tfrac23\mathop{\mathrm{tr}}(B_+)+\tfrac13\mathop{\mathrm{tr}}(B_-)\ge0$, hence $d^+\delta^2\le0$, dimension-free | **CONFIRMED** at every $n\ge4$ |
| 8 | $\{F=0\}=\{H:\Pi_{ASD}H\Pi_{\ker u}=0\}$, a linear subspace | **CONFIRMED**, both inclusions proved, §6 |
| 9 | the three families named in the block's prose are the equality set | **REFUTED**, as the block's own audit line says, but **the prose was never repaired and still asserts it** |
| 10 | $\mathop{\mathrm{codim}}\{F=0\}\le186$ at $n=12$; at least $1451$ of $1637$ | **CONFIRMED**, the count is $6+180=186$ exactly, §7 |
| 11 | $d^+\Phi=2a\kappa_nF$, so the conclusion needs $\kappa_n\le0$ and is **not** dimension-free | **CONFIRMED**, and it also silently needs $u$ critical, §8 |
| 12 | $\Theta_{11}=1.21716<\sqrt{3/2}<1.24838=\Theta_{13}$, odd-$n$ formula with its square root | **CONFIRMED**, $\Theta_{11}^2=\tfrac{40}{27}$, $\Theta_{13}^2=\tfrac{120}{77}$ |
| 13 | the crossover still lands at $n\ge12$ under the corrected $\Theta_n$ | **CONFIRMED**, from $n^2-13n+18>0$ at odd $n$ and $n^2-12n+8>0$ at even $n$, but the block's two-value display does not establish it, §9 |
| 14 | the canonical entry carries a citable statement | **BROKEN**, [results.md](../results.md) L17 is a heading over a bare pointer; §1 supplies what a consumer may cite |
| 15 | "the mixed flat directions need a Hessian comparison, verified numerically but not yet proven" | **HYPOTHESIS-DEBT, but not L17's**, it is a forward reference to the second-order programme, §10 |
| 16 | ATTEMPTS' auxiliary "$F$ is convex and 1-homogeneous, so directed subgradient descent certifies the sign globally" | **UNVERIFIED, non-load-bearing**, 1-homogeneity holds; convexity does not follow from the scalar convexity of $x_-$, §11 |

**Verdict in one line: the mathematics of L17 is correct and I re-derived all four ingredients independently, but the record that carries it is not citable, the canonical entry states nothing, the argument lives only in a notebook, the block's prose still asserts an equality set its own audit line refutes, and two hypotheses the proof consumes ($u$ critical, and $H$ Bianchi) are never stated where the lemma is stated.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $\mathcal W_n$, $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$, "$10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$".
- "**$\mathrm{Alt}$ is the ORTHOGONAL PROJECTION of $S^2(\Lambda^2)$ onto $\Lambda^4$**, carrying its $\tfrac13$: $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$. So $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$, $\mathrm{Alt}$ is self-adjoint and idempotent, and $\mathrm{Alt}(H)=0$ for every $H$ satisfying the first Bianchi identity, in particular for every Weyl tensor. **Inside $\Lambda^2\mathbb R^4$, $\Lambda^4$ is one-dimensional and $\mathrm{Alt}$ is the projection onto the Hodge star $\star=\Pi_{SD}-\Pi_{ASD}$, with $\lVert\star\rVert^2=6$.**"
- "**The sign of $W_-$ is $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$, the POSITIVE-SEMIDEFINITE magnitude of the negative part.** … it is the only sign under which $\mathrm{Alt}(u_-)=+a\star$ with $a=\tfrac1{3\sqrt6}>0$ at the $\mathbb{CP}^2$-type competitor, under which $\mathrm{Alt}(W_-)\rvert_{\ker W}=-a\Pi_{ASD}$, and under which [Lemma L17]'s $d^+\delta^2=-2aF$ with $F\ge0$ comes out."
- "$\Theta_n$ | the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, **the square root was missing here until 2026-09-04**".
- "$\theta_0(n)$ | **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.**"
- "$\Pi$ | **the letter carries four unrelated objects and they must be read from context.**"
- Setting, [route-a.md:198](../findings/route-a.md): "$u=W_{\mathcal S^4(\alpha)}$ the $\mathbb{CP}^2$-type competitor of unit norm, $\theta^*=P(u)=\sqrt{3/2}$ … $\Phi=P-\kappa_n\delta^2$ with $\kappa_n=9(\sqrt{3/2}-\theta_0(n))<0$ for $n\ge12$."

## 1. What a consumer may cite, because the canon supplies nothing

[results.md](../results.md) lines 677–679 are, in full, a heading and `**Proof:** [route-a.md](findings/route-a.md)`. The block at [route-a.md:71](../findings/route-a.md) is six audit blockquotes over one paragraph of prose. The argument is in [ATTEMPTS.md](../ATTEMPTS.md)'s Result 6, a notebook. **No file on the record carries a statement of L17 with quantifiers, hypotheses and a conclusion.** The pointer is circular exactly as the block's second blockquote says.

This is what I verified, and it is the form in which the result should be written down:

> **Lemma L17.** Let $n\ge4$ and let $u\in\mathcal W_n$ be the unit-norm $\mathbb{CP}^2$-type competitor $\mathcal S^4(\alpha)$ zero-padded into $\mathbb R^n$, with distinguished $4$-plane $V\subset\mathbb R^n$, $\Lambda^2V=\Lambda^+\oplus\Lambda^-$, and $\hat\omega_1,\hat\omega_2,\hat\omega_3$ the orthonormal self-dual forms diagonalising $u$. Write $a=\tfrac1{3\sqrt6}$, $P_0=\Pi_{\ker u}$, $\Pi_{ASD}$ for the projection onto $\Lambda^-$, $B=\Pi_{ASD}H\Pi_{ASD}$, and $\delta^2(W)=\lVert\mathrm{Alt}(W_-)\rVert^2$ in the sign convention above. Then for every $H\in\mathcal W_n$ with $\langle H,u\rangle=0$:
>
> **(i)** $\displaystyle d^+\delta^2(u;H)=-2a\,F(H),\qquad F(H)=H_{22}+H_{33}+\mathop{\mathrm{tr}}\big(\Pi_{ASD}(P_0HP_0)_-\big).$
>
> **(ii)** $\displaystyle F(H)\;\ge\;\tfrac23\mathop{\mathrm{tr}}(B_+)+\tfrac13\mathop{\mathrm{tr}}(B_-)\;\ge\;0$, hence $d^+\delta^2(u;H)\le0$, **at every $n\ge4$, with no dimension hypothesis.**
>
> **(iii)** $F(H)=0\iff\Pi_{ASD}H\,\Pi_{\ker u}=0$. The equality set is therefore a **linear subspace** of $T_uS\cap\mathcal W_n$, of codimension at most $6+3(\dim\ker u-3)$; at $n=12$ that is $186$, leaving at least $1451$ of the $1637$ dimensions of $T_uS$.
>
> **(iv)** If in addition $u$ is a critical point of $P$ on the unit sphere, which it is, at every $n\ge4$, by [problem.md](../findings/problem.md) item 4, then with $\Phi=P-\kappa_n\delta^2$, $\;d^+\Phi(u;H)=2a\kappa_nF(H)$. Hence $d^+\Phi(u;\cdot)\le0$ **iff** $\kappa_n\le0$, which for $\kappa_n=9(\sqrt{3/2}-\Theta_n)$ holds exactly for $n\ge12$; for $n\le11$ the same formula gives $d^+\Phi>0$ wherever $F>0$.

## 2. Hypothesis inventory

| hypothesis | stated where | used where | verdict |
| --- | --- | --- | --- |
| $H\in\mathcal W_n$, i.e. $\mathrm{Alt}(H)=0$ (first Bianchi) | ATTEMPTS Result 6, "for every $H\in\mathcal W_n$" | ingredient (d), the SD/ASD trace balance | **stated and load-bearing.** §12 exhibits $H=-\star$, a tangent symmetric operator that is not Weyl and has $F<0$ |
| $\langle H,u\rangle=0$ (tangency) | ATTEMPTS Result 6 | ingredient (d), $2H_{11}=H_{22}+H_{33}$ | **stated and load-bearing** |
| $\lVert H\rVert=1$ | ATTEMPTS Result 6 | nowhere | **stated and never used.** Both sides of (i) are $1$-homogeneous in $H$; the normalisation is inert |
| $u$ is a critical point of $P\vert_S$ | **nowhere in the L17 block or in ATTEMPTS Result 6** | the step from $d^+\delta^2\le0$ to $d^+\Phi=2a\kappa_nF$ | **used and never stated.** True on the record ([problem.md](../findings/problem.md) items 4 and 6, and [route-a.md:198](../findings/route-a.md)'s $\theta^*=P(u)$), so this is a statement defect rather than a mathematical one |
| $\ker u\supseteq\Lambda^-$ | implicit | ingredients (b), (c), and the $\{F=0\}$ characterisation | **used and never stated.** Immediate from $u$'s construction, but it is what makes $\Pi_{ASD}P_0=\Pi_{ASD}$, which every later line silently uses |
| $\kappa_n\le0$ | route-a.md:198 as an assertion about $n\ge12$ | the $\Phi$ conclusion only | **stated, load-bearing, correctly flagged** by the landscape entry's italic correction |
| $n\ge12$ | landscape entry, block prose | only through $\kappa_n\le0$ | **stated; not needed for (i)–(iii)** |
| $\delta^2$ directionally differentiable at $u$ | not stated | (i) | **used and never stated.** Holds: $x\mapsto x_-$ is locally Lipschitz and piecewise analytic, so the induced matrix function is directionally differentiable at every symmetric argument |
| Hansen–Pedersen / Jensen's operator inequality | ATTEMPTS ingredient (c) | the compression step | **cited but not needed**, §5 replaces it with elementary matrix algebra, which sidesteps the unitality question the brief warns about |

## 3. The one-sided derivative, derived

**Set-up.** $u=\tfrac1{\sqrt6}\big(2\hat\omega_1\hat\omega_1^{\mathsf T}-\hat\omega_2\hat\omega_2^{\mathsf T}-\hat\omega_3\hat\omega_3^{\mathsf T}\big)$. Norm $\tfrac16(4+1+1)=1$; trace $\tfrac1{\sqrt6}(2-1-1)=0$. So $\mathop{\mathrm{spec}}(u)=\{2/\sqrt6,\,-1/\sqrt6,\,-1/\sqrt6\}$ on $\Lambda^+$ and $0$ on $\ker u=\Lambda^-\oplus R$, where $R=\Lambda^2\mathbb R^n\ominus\Lambda^2V$. **The kernel is where everything happens, and it grows with $n$.**

**$a$, from the definition of $\mathrm{Alt}$.** $u_-=\tfrac12(\lvert u\rvert-u)=\tfrac1{\sqrt6}(\hat\omega_2\hat\omega_2^{\mathsf T}+\hat\omega_3\hat\omega_3^{\mathsf T})$. Since $\mathrm{Alt}$ is the orthogonal projection onto $\mathbb R\star$ inside $S^2(\Lambda^2V)$ and $\lVert\star\rVert^2=6$,
$$\mathrm{Alt}(u_-)=\frac{\langle u_-,\star\rangle}{6}\,\star=\frac{\mathop{\mathrm{tr}}(u_-)}{6}\star=\frac{2/\sqrt6}{6}\star=\frac1{3\sqrt6}\star=a\star,$$
using $\star=+1$ on $\Lambda^+$, where $u_-$ is supported. Then $\delta^2(u)=a^2\lVert\star\rVert^2=\tfrac{6}{9\cdot6}=\tfrac19$, **the record's $\delta^2=1/9$, recovered exactly, and independent of $n$ because $\mathrm{Alt}$ acts entrywise and $u_-$ has all four indices in $V$.**

**$\mathrm{Alt}(u_-)$ on the kernel.** $a\star$ is $+a$ on $\Lambda^+$, $-a$ on $\Lambda^-$, and **zero on $R$**, again because $\mathrm{Alt}(u_-)$ has all indices in $V$. So $\mathrm{Alt}(u_-)\vert_{\ker u}=-a\Pi_{ASD}$, which is ingredient (b)'s claim, and the vanishing on $R$ is precisely why the padded flat sits in $\{F=0\}$.

**The derivative.** $\delta^2(W)=\lVert\mathrm{Alt}(W_-)\rVert^2$ and $\mathrm{Alt}$ is a self-adjoint idempotent, so with $A:=\mathrm{Alt}(u_-)=a\star$,
$$d^+\delta^2(u;H)=2\big\langle\mathrm{Alt}(u_-),\,\mathrm{Alt}\big(d^+W_-[H]\big)\big\rangle=2\big\langle A,\,d^+W_-[H]\big\rangle.$$
Along the sphere curve $t\mapsto\cos t\,u+\sin t\,H$ the velocity is $H$ and the $O(t^2)$ radial term does not reach first order, so the ray and the sphere give the same $d^+$.

Split $d^+W_-[H]$ over $u$'s spectral decomposition.

**(a) The nonzero block.** On the span of $\hat\omega_1,\hat\omega_2,\hat\omega_3$ the eigenvalues are simple-or-degenerate but **nonzero**, so $f(x)=x_-$ is real-analytic near each and Daleckii–Krein applies: $\big(Df(u)[H]\big)_{ij}=f^{[1]}(\lambda_i,\lambda_j)H_{ij}$. **$A=a\star$ is diagonal in this eigenbasis** (it is $+a$ on all of $\Lambda^+$, $-a$ on all of $\Lambda^-$, $0$ on $R$) so every off-diagonal divided-difference term pairs to zero against $A$, which is exactly ATTEMPTS' "every eigenvector-rotation term pairs to zero". What survives is
$$\sum_{i=1}^{3}A_{ii}f'(\lambda_i)H_{ii}=a\big[0\cdot H_{11}+(-1)H_{22}+(-1)H_{33}\big]=-a(H_{22}+H_{33}),$$
since $f'=0$ at $\lambda_1=2/\sqrt6>0$ and $f'=-1$ at $\lambda_2=\lambda_3=-1/\sqrt6<0$. Doubling gives $-2a(H_{22}+H_{33})$: **ingredient (a) confirmed.**

**(b) The kernel block, the kink.** On $\ker u$ the eigenvalues of $u+tH$ are, to first order, $t\mu_k$ with $\mu_k\in\mathop{\mathrm{spec}}(P_0HP_0)$ and eigenvectors the corresponding eigenvectors of $P_0HP_0$ (first-order degenerate perturbation theory; the coupling to $\Lambda^+$ enters the kernel eigenvalues at $O(t^2)$ and so does not reach $d^+$). Hence $\big(W_-\big)\big\vert_{\ker u}=t\,(P_0HP_0)_-+o(t)$, and the contribution is
$$2\big\langle A,(P_0HP_0)_-\big\rangle=2\mathop{\mathrm{tr}}\!\big(A\vert_{\ker u}(P_0HP_0)_-\big)=-2a\mathop{\mathrm{tr}}\!\big(\Pi_{ASD}(P_0HP_0)_-\big).$$
**Ingredient (b) confirmed, including the sign.** Note the mixed $\Lambda^+$–$\ker u$ divided-difference terms also pair to zero against the diagonal $A$, so nothing is double-counted.

**Summing:** $d^+\delta^2(u;H)=-2a\big[H_{22}+H_{33}+\mathop{\mathrm{tr}}(\Pi_{ASD}(P_0HP_0)_-)\big]=-2aF(H)$. **Claim 2 confirmed.**

**What the non-smoothness costs.** Exactly one term: the kink branch. Were $\delta^2$ smooth at $u$ the derivative would be $-2a(H_{22}+H_{33})$ alone, and that is **sign-indefinite**, take any Weyl $H$ with $H_{22}+H_{33}<0$, which the constraints permit. The whole of $F\ge0$ is bought by the kink term, which is $\ge0$ always and which the Bianchi balance then dominates. **The large kernel is not an obstacle the proof works around; it is the entire mechanism**, and the proof's structure (smooth branch plus zero-mode sliver), is the correct handling of it.

## 4. The reduction to Jensen, do the two structural facts do the work claimed?

**Bianchi.** $\star$, read as an element of $S^2(\Lambda^2)$, is $\star_{(ij)(kl)}=\epsilon_{ijkl}$ on $V$, totally antisymmetric, so $\star\in\Lambda^4$ and $\mathrm{Alt}(\star)=\star$. For $H$ Weyl, $\mathrm{Alt}(H)=0$, so
$$\langle H,\star\rangle=\langle H,\mathrm{Alt}\star\rangle=\langle\mathrm{Alt}H,\star\rangle=0.$$
Reading $\langle H,\star\rangle=\mathop{\mathrm{tr}}(H\star)$ blockwise, $\star$ being $+1$ on $\Lambda^+$, $-1$ on $\Lambda^-$, $0$ on $R$:
$$H_{11}+H_{22}+H_{33}-\mathop{\mathrm{tr}}(B)=0.$$
**Confirmed: the first Bianchi identity is exactly an SD/ASD trace balance on the distinguished $4$-plane, and it does the work claimed.**

**Tangency.** $0=\langle H,u\rangle=\tfrac1{\sqrt6}(2H_{11}-H_{22}-H_{33})$, so $2H_{11}=H_{22}+H_{33}$. **Confirmed: unit-norm tangency fixes the remaining diagonal entry against the balance, and it does the work claimed.** Substituting, $\tfrac32(H_{22}+H_{33})=\mathop{\mathrm{tr}}(B)$, i.e. $H_{22}+H_{33}=\tfrac23\mathop{\mathrm{tr}}(B)$.

**Neither fact is decorative.** Drop Bianchi and §12's witness kills the inequality. Drop tangency and $H_{11}$ is free, so $H_{22}+H_{33}$ is unrelated to $\mathop{\mathrm{tr}}(B)$ and the chain has no first term.

## 5. The compression step, and the imported-theorem trap

ATTEMPTS cites "Jensen's trace inequality (Hansen–Pedersen, $f(x)=x_-$)". The brief warns that one route here died on a cited theorem assuming a unital algebra. **Here the citation is safe but also unnecessary**, and I record the elementary replacement so no consumer has to check Hansen–Pedersen's hypotheses against $\mathcal W_n$.

Write $C=P_0HP_0$, $\Pi=\Pi_{ASD}$, and note $\Pi P_0=\Pi$ since $\Lambda^-\subseteq\ker u$, so $\Pi C\Pi=\Pi H\Pi=B$. For any $Z$ with $0\le Z\le\Pi$:
$$-\mathop{\mathrm{tr}}(CZ)=\mathop{\mathrm{tr}}(C_-Z)-\mathop{\mathrm{tr}}(C_+Z)\le\mathop{\mathrm{tr}}(C_-Z)\le\mathop{\mathrm{tr}}(C_-\Pi),$$
the last step because $C_-\succeq0$ and $Z\le\Pi$. Now $\mathop{\mathrm{tr}}(B_-)=\max\{-\mathop{\mathrm{tr}}(BY):0\le Y\le\Pi\}$ (the variational characterisation of the negative part, on the space $\Lambda^-$), and $-\mathop{\mathrm{tr}}(BY)=-\mathop{\mathrm{tr}}(C\,\Pi Y\Pi)$ with $0\le\Pi Y\Pi\le\Pi$. Hence
$$\mathop{\mathrm{tr}}(B_-)\le\mathop{\mathrm{tr}}(\Pi C_-)=\mathop{\mathrm{tr}}\!\big(\Pi_{ASD}(P_0HP_0)_-\big).$$
**Ingredient (c) confirmed, with no operator-convexity, no unitality, and no imported theorem.** (Hansen–Pedersen would also apply: the inclusion $\Lambda^-\hookrightarrow\ker u$ is an isometry, so $V^*V=I$ and $f(x)=x_-$ is convex with $f(0)=0$. But the elementary route is what I checked.)

**The chain.** With $\mathop{\mathrm{tr}}(B)=\mathop{\mathrm{tr}}(B_+)-\mathop{\mathrm{tr}}(B_-)$ in the record's sign convention,
$$F\;\ge\;\tfrac23\mathop{\mathrm{tr}}(B)+\mathop{\mathrm{tr}}(B_-)\;=\;\tfrac23\mathop{\mathrm{tr}}(B_+)-\tfrac23\mathop{\mathrm{tr}}(B_-)+\mathop{\mathrm{tr}}(B_-)\;=\;\tfrac23\mathop{\mathrm{tr}}(B_+)+\tfrac13\mathop{\mathrm{tr}}(B_-)\;\ge\;0.$$
**Claim 7 confirmed. Nothing in this chain mentions $n$: $d^+\delta^2(u;\cdot)\le0$ holds at every $n\ge4$, which is what the landscape entry's correction says is dimension-free.**

## 6. The equality set, both inclusions

**$\Leftarrow$.** Suppose $\Pi_{ASD}H\Pi_{\ker u}=0$. Then $B=\Pi_{ASD}H\Pi_{ASD}=(\Pi_{ASD}H\Pi_{\ker u})\Pi_{ASD}=0$, using $\Pi_{\ker u}\Pi_{ASD}=\Pi_{ASD}$; and $\Pi_{ASD}C=\Pi_{ASD}HP_0=0$, so $\Lambda^-\subseteq\ker C\subseteq\ker C_-$ and $\mathop{\mathrm{tr}}(\Pi_{ASD}C_-)=0$. Since $B=0$ gives $\mathop{\mathrm{tr}}(B)=0$ and hence $H_{22}+H_{33}=\tfrac23\mathop{\mathrm{tr}}(B)=0$, we get $F=0$.

**$\Rightarrow$.** Suppose $F=0$. The chain forces $\mathop{\mathrm{tr}}(B_+)=\mathop{\mathrm{tr}}(B_-)=0$, so $B=0$; and then $F=\mathop{\mathrm{tr}}(\Pi_{ASD}C_-)=0$ with $C_-\succeq0$, $\Pi_{ASD}\succeq0$, so $\Pi_{ASD}C_-=0$, i.e. $\Lambda^-\subseteq\ker C_-=E_{\ge0}(C)$. $E_{\ge0}(C)$ is $C$-invariant and $C\vert_{E_{\ge0}}\succeq0$; for $v\in\Lambda^-$, $\langle v,Cv\rangle=\langle v,Bv\rangle=0$, and a positive semidefinite operator kills every vector on which its quadratic form vanishes, so $Cv=0$. Thus $C\Pi_{ASD}=0$, hence $\Pi_{ASD}C=0$, hence $\Pi_{ASD}H\Pi_{\ker u}=\Pi_{ASD}P_0HP_0=\Pi_{ASD}C=0$.

**Claim 8 confirmed. $\{F=0\}$ is the kernel of the linear map $H\mapsto\Pi_{ASD}H\Pi_{\ker u}$ intersected with $T_uS\cap\mathcal W_n$, a linear subspace, as the audit says.**

**Claim 9, the block's prose is still wrong.** The three families are sufficient: the orbit tangents have $P_0HP_0=0$ identically; the hyper-Kähler tangents are supported on $\Lambda^+$; the padded $\mathcal W_{n-4}$ is supported on $R$, where both $B$ and $\Pi_{ASD}HP_0$ vanish. They are not exhaustive, every $H$ supported in the $\Lambda^+\times\ker u$ off-diagonal block has $B=0$, $P_0HP_0=0$ and zero SD diagonal, so $F=0$; that is the audit's "every mixed $E$–$K$ direction". **But the block's closing paragraph, three lines below its own refuting blockquote, still reads "with the equality cases being the competitor's own orbit, its hyper-Kähler rotations, and … every Weyl tensor of the complementary $\mathbb R^{n-4}$".** A consumer reading the prose rather than the audit banner gets the refuted claim. **This is the record's live defect and it is a repair, not a re-audit.**

## 7. The codimension count

At $n=12$: $\dim\mathcal W_{12}=\tfrac{12\cdot9\cdot13\cdot14}{12}=1638$, so $\dim T_uS=1637$ ✔. $\dim\Lambda^2\mathbb R^{12}=66$, $\dim\Lambda^+=3$, so $\dim\ker u=63$, split as $\Lambda^-$ ($3$) $\oplus\,R$ ($60$).

The map $H\mapsto\Pi_{ASD}H\Pi_{\ker u}$ records the $\Lambda^-\times\Lambda^-$ block, which is **symmetric** ($6$ independent entries) and the $\Lambda^-\times R$ block, $3\times60=180$ entries. Total target dimension
$$6+180=186.$$
So $\mathop{\mathrm{codim}}\{F=0\}\le186$, with "$\le$" the honest form because the map is restricted to the Bianchi- and tangency-constrained $T_uS\cap\mathcal W_{12}$ and its rank there is not established. Hence $\{F=0\}$ holds at least $1637-186=1451$ dimensions, and $1451/1637=0.8863\ldots$, **"about $89\%$" ✔. Claim 10 confirmed, and the arithmetic is exact.**

**The consequence the block states correctly and which matters most:** on $89\%$ of directions $d^+\Phi=0$, an equality, so first-order protection decides nothing there and the entire content is pushed to second order.

## 8. The dimension dependence

$u$ being critical for $P\vert_S$, $dP\vert_{T_uS}=0$, so $d^+\Phi(u;H)=-\kappa_n\,d^+\delta^2(u;H)=2a\kappa_nF(H)$. With $a>0$ and $F\ge0$: **$d^+\Phi\le0$ for all $H$ iff $\kappa_n\le0$.** Claim 11 confirmed, and so is the landscape entry's italic correction, "in any dimension" was self-contradictory, the dimension-free statement is $d^+\delta^2\le0$.

$\kappa_n=9(\sqrt{3/2}-\theta_0(n))\le0\iff\theta_0(n)^2\ge\tfrac32\iff 4(n-1)(n-2)\ge3n^2\iff n^2-12n+8\ge0\iff n\ge6+2\sqrt7=11.2915\ldots$ ✔, the record's crossover.

Screen of the boundary values, exact: $\theta_0(12)^2=\tfrac{220}{144}=1.52\overline{7}>\tfrac32$, giving $\kappa_{12}=9(1.224745-1.236033)=-0.101592$, matching [route-a.md:219](../findings/route-a.md)'s $\lvert\kappa_{12}\rvert=0.10159$. $\theta_0(11)^2=\tfrac{180}{121}=1.48760<\tfrac32$, so $\kappa_{11}=+0.0456>0$ and the sign genuinely reverses at $n=11$. **The claimed escape below the crossover is the same formula read with the other sign, and it is correct.**

## 9. The crossover under the corrected $\Theta_n$

Odd $n$: $\Theta_n^2=\dfrac{2(n-1)(n-3)}{(n+1)(n-2)}$.

- $n=11$: $\dfrac{2\cdot10\cdot8}{12\cdot9}=\dfrac{160}{108}=\dfrac{40}{27}=1.481481\ldots$, and $\sqrt{40/27}=1.217161\ldots$ **✔ the block's $1.21716$.**
- $n=13$: $\dfrac{2\cdot12\cdot10}{14\cdot11}=\dfrac{240}{154}=\dfrac{120}{77}=1.5584415\ldots$, and $\sqrt{120/77}=1.2483756\ldots$ **✔ the block's $1.24838$, and it matches [results.md:222](../results.md)'s $\Theta_{13}=1.2483756$ to seven figures.**
- $\sqrt{3/2}=1.2247448\ldots$, so $\Theta_{11}<\sqrt{3/2}<\Theta_{13}$ ✔. **Claim 12 confirmed, and the square root is present.**

**Claim 13, the conclusion is right, the display does not establish it.** Two values at $n=11$ and $n=13$ establish a crossover only with monotonicity, and they say nothing about $n=12$, which is even and governed by $\theta_0$. The correct statement is the pair of polynomial inequalities:

- even $n$: $\theta_0(n)^2>\tfrac32\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.2915$;
- odd $n$: $\Theta_n^2>\tfrac32\iff 4(n-1)(n-3)>3(n+1)(n-2)\iff n^2-13n+18>0\iff n>\tfrac{13+\sqrt{97}}2=11.4244$.

Both give the integer threshold $n\ge12$, so under the corrected $\Theta_n$ the crossover still lands at $n\ge12$ ✔. **This is already a numbered result**, [problem.md](../findings/problem.md) item 1 states both roots and says "The integer threshold $n\ge12$ is reproduced exactly at both parities, see [Lemma L2](../findings/problem.md)". **The L17 block does not cite it**, so its survival claim rests, as written, on two evaluated square roots. **Finding: a citation gap, not a mathematical gap.**

**And the sign conclusion is robust to which constant $\kappa_n$ is pinned to.** Under $\theta_0(n)$ the odd-$n$ threshold is $n>11.2915$, so odd $n\ge13$; under $\Theta_n$ it is $n>11.4244$, so odd $n\ge13$ again. **$\kappa_n\le0$ holds for exactly $n\ge12$ under either pinning**, which is why L17 survives the repair while [Lemma L134](../findings/second-order.md)'s odd-$n$ thresholds (which use the *value* of $\kappa_n$, not its sign), do move. [LEDGER.md:300](../findings/LEDGER.md) prices this correctly.

**Residual exposure, flagged not adjudicated.** [route-a.md:198](../findings/route-a.md) still defines $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ and [results.md:672](../results.md)'s Conjecture L16 entry still states the bound against $\theta_0(n)$, while [results.md:222](../results.md)'s landscape entry states it against $\Theta_n$. **Two constants of the same name live in one route.** L17's sign conclusion survives both; its consumers may not.

## 10. The admitted debt, stated exactly

The block's closing sentence: *"What remains at this point is second-order: the mixed flat directions need a Hessian comparison, verified numerically but not yet proven."*

**What is owed, precisely:** for every $H\in\{F=0\}$ that is neither an orbit/hyper-Kähler tangent (where $\Phi$ is constant) nor supported on $\Lambda^2\mathbb R^{n-4}$ (the padded flat, cleared with the $18\times$ margin), prove
$$\tfrac12\mathop{\mathrm{Hess}}(P\vert_S)_u[H,H]-\kappa_n\,c_2(H)\;\le\;0,\qquad c_2(H)=\tfrac12\tfrac{d^2}{dt^2}\Big\vert_{t=0^+}\delta^2(\cos t\,u+\sin t\,H),$$
equivalently, via [Lemma L134](../findings/route-a.md)(b), $c_2(H)\le\theta^*/(2\lvert\kappa_n\rvert)$, whose binding value as $n\to\infty$ is $0.3591$.

**Three things must be said about it.**

1. **It is not L17's debt.** L17 claims first-order protection; its statement is $d^+\Phi\le0$, and that is fully proven above with no numerical input. The quoted sentence is a forward reference to the second-order programme. **A consumer may cite L17 as a proven lemma; the debt attaches to local maximality, which L17 does not assert.**
2. **"Verified numerically but not yet proven" is an open hypothesis and must be labelled one wherever it is consumed.** It is correctly labelled here.
3. **The debt is larger than the sentence suggests.** "The mixed flat directions" reads as a residual sliver, but §7 shows $\{F=0\}$ is $\ge1451$ of $1637$ dimensions at $n=12$, of which the padded flat is $\dim\mathcal W_8=300$ and the orbit is $\dim SO(12)-\dim(U(2)\times SO(8))=66-(4+28)=34$. **The two cleared families together span at most $334$ directions; the mixed part is the overwhelming majority of the equality set.** The prose's "large flat rather than a handful of symmetry directions" describes the padded flat, and the same sentence should describe the mixed part, which is larger still.

## 11. The auxiliary convexity claim, flagged, not adjudicated

ATTEMPTS asserts "$F$ is convex and $1$-homogeneous on the tangent space, so directed subgradient descent certifies the sign globally".

- **$1$-homogeneity: confirmed.** $H\mapsto H_{22}+H_{33}$ is linear, $(P_0(sH)P_0)_-=s(P_0HP_0)_-$ for $s>0$.
- **Convexity: not established by anything on file.** $x\mapsto x_-$ is convex as a scalar function, and $X\mapsto\mathop{\mathrm{tr}}(X_-)$ inherits that; but $X\mapsto\mathop{\mathrm{tr}}(\Pi X_-)$ for a **proper** projection $\Pi$ does not, because $x\mapsto x_-$ is not *operator* convex (the operator convex functions on $\mathbb R$ are the quadratics), and the weighted trace $\mathop{\mathrm{tr}}(Af(X))$ inherits convexity from $f$ only for $A$ a multiple of the identity or $f$ operator convex. The variational bound of §5 gives $\mathop{\mathrm{tr}}(\Pi X_-)\ge\sup\{-\mathop{\mathrm{tr}}(XZ):0\le Z\le\Pi\}$ with the supremum generally **not** attained, so it supplies a lower envelope rather than a convexity proof.

**Reported as UNVERIFIED rather than as a discrepancy**, under the three-part protocol: I can locate it and argue the opposite, but I did not produce a closed-form pair $(X,Y)$ violating it, and producing one is exactly the kind of search this loop does not run. **It is non-load-bearing**: §5 proves $F\ge0$ and §6 characterises $\{F=0\}$ outright, neither using convexity. The claim's only role is to license a numerical certificate, and that certificate is superseded by the closed-form characterisation.

## 12. The traps, each by name

**$\ker W\ne0$, and what the argument does at a padded object.** Answered in §3. The kernel is the mechanism, not an obstruction; padding into $\mathbb R^n$ enlarges $\ker u$ by $R$, on which $\mathrm{Alt}(u_-)$ vanishes identically because $\mathrm{Alt}$ acts entrywise and $u_-$ has all indices in $V$. So the sliver term reads only the $\Lambda^-$ corner of a kernel of dimension $\binom n2-3$, no matter how large $n$ is. **This is also exactly why the padded flat is in $\{F=0\}$, and why $\delta^2(u)=1/9$ at every $n$.** Nothing degenerates as $n$ grows.

**The boundary of every stated range, and the smallest admissible dimension.** $n=12$: $\kappa_{12}=-0.1016<0$ strictly, so the boundary case is genuinely inside the range, not at equality. $n=11$: $\kappa_{11}>0$ and the conclusion reverses, as the record says. **The first-order statement (i)–(iii) is valid down to $n=4$**, where $R=0$, $\ker u=\Lambda^-$ and $\{F=0\}=\{B=0\}$ has codimension $\le6$ in a $9$-dimensional $T_uS$, a case the block never mentions and where the equality set is a *minority* of directions, inverting the $89\%$ headline. **No error; a range the block leaves unstated.**

**Odd $n$.** §9. Handled correctly in conclusion, under-argued in the block, already proven at [Lemma L2](../findings/problem.md).

**A claim proven on a subfamily and used in general.** Claim 9: the three families are a subfamily of $\{F=0\}$ and the block's prose presents them as the whole. **This is the defect, it is already audited, and it is still on the page.**

**A hypothesis stated but never used.** $\lVert H\rVert=1$, inert, both sides being $1$-homogeneous. Harmless.

**A step using a hypothesis never stated.** Three: $u$ critical (needed for (iv), true on the record, stated nowhere near L17); $\Lambda^-\subseteq\ker u$ (needed everywhere, obvious, stated nowhere); directional differentiability of $\delta^2$ (needed for (i), true, stated nowhere). **All three are true. None is written down where the lemma is stated, which is the same failure as the missing statement itself.**

**A universal claim with no witness.** "$\inf F=0$ is attained" is witnessed in closed form by §6: every $H$ with $\Pi_{ASD}H\Pi_{\ker u}=0$, and concretely by any orbit tangent or any padded $\mathcal W_{n-4}$ element. **No unwitnessed universal claim found.**

**An imported theorem whose hypotheses were never checked.** Hansen–Pedersen. §5. The unitality worry the brief raises (the one that killed a route because $\mathcal W_n$ has no unit), **does not bite here**, because the compression is by an isometry $\Lambda^-\hookrightarrow\ker u$ acting on the algebra of symmetric operators on $\Lambda^2\mathbb R^n$, which does have a unit; $\mathcal W_n$ enters only as the source of the Bianchi constraint, never as the ambient algebra of the operator inequality. **And §5 removes the dependence entirely.**

**Symbol collisions.** Checked against [conventions.md](../findings/conventions.md), which itself warns that $\Pi$ "carries four unrelated objects".

| symbol | collision found | status |
| --- | --- | --- |
| $\kappa$ | **LIVE AND UNTABLED.** [conventions.md:117](../findings/conventions.md) fixes "the algebra's Killing constant $\kappa_n=(2n-1)(n-1)/4$", $63.25$ at $n=12$. L17's $\kappa_n=9(\sqrt{3/2}-\theta_0(n))=-0.1016$ at $n=12$. **Same symbol, opposite sign, factor $\sim600$, and conventions.md tables the $B$, $M$ and $\mu$ collisions but not this one.** Both appear inside [second-order.md](../findings/second-order.md) |
| $\Pi$ | L17 uses $\Pi_{ASD}$, $\Pi_{SD}$, $\Pi_{\ker u}$, a **fifth** family of senses, none of the four tabled. Subscripted throughout, so unambiguous in practice, but the table does not cover them |
| $P_0$ vs $\Pi_{\ker u}$ | **the same object under two symbols across the two files a consumer must read together**, ATTEMPTS writes $P_0$, the route-a.md audit blockquote writes $\Pi_{\ker u}$. Also collides with $P$, the cubic form, and with $P_0HP_0$ read as a triple product of cubic forms |
| $u$ | **LIVE.** [conventions.md:31](../findings/conventions.md)'s $\Pi$ row uses $u$ for "the orbit acceleration", with $\Pi u=u+\lVert z\rVert^2W$; L17 and [route-a.md:198](../findings/route-a.md) use $u$ for the base point $W_{\mathcal S^4(\alpha)}$. **Same letter, two objects, one of them in the very row that warns about $\Pi$** |
| $F$ | **LIVE AND UNTABLED.** L17's scalar functional $F(H)$; $F_u$ at [route-a.md:24,26,91](../findings/route-a.md); "the four $F_\lambda$ spectra" in L20's audit; and **$F$ as a frame index** at [conventions.md:23](../findings/conventions.md) ("$t=t_F$ … per frame"). Four unrelated uses |
| $a$ | L17's scalar $\tfrac1{3\sqrt6}$; an index in $K_{ab}$; a subalgebra element in conventions.md's Killing-constant row. Contextually clear, minor |
| $B$ | L17's $B=\Pi_{ASD}H\Pi_{ASD}$ **is a third meaning** on top of the two conventions.md already flags as live ("THE LETTER $B$ MEANS TWO THINGS, live"), the $\mathfrak{so}(n)$ Killing form and sym3-blocks.md's. Not tabled |

**None of these collisions makes L17 wrong. All of them make it misreadable, and $\kappa$, $u$, $F$ and $B$ are untabled in the file whose whole purpose is to table them.**

## 13. What would falsify it, and what I did to look

**The object.** A tangent direction $H$ at $u$ with $F(H)<0$, that is, a curvature tensor whose sliver of anti-self-dual mass entering $\ker u$ is *smaller* than $-\tfrac32$ times its own self-dual diagonal deficit, so that $\delta^2$ increases to first order and $\Phi$ increases with it whenever $\kappa_n<0$.

**What I did.** I did not search. I derived the sharp chain in §5, which shows that any such $H$ must violate one of exactly two identities, and then asked which identity is the fragile one.

**What I found.** Both identities are exactly tight, and the failure mode is completely localised in **Bianchi**. Explicitly: take $H=-\star$, the negated Hodge star of $V$, extended by zero. It is symmetric, and it is tangent, $\langle-\star,u\rangle=-\tfrac1{\sqrt6}(2-1-1)=0$. Its diagonal is $H_{11}=H_{22}=H_{33}=-1$, so $H_{22}+H_{33}=-2$; and $P_0HP_0=+\Pi_{ASD}$, which is positive semidefinite, so $(P_0HP_0)_-=0$ and the sliver term vanishes. Hence
$$F(-\star)=-2+0=-2\;<\;0,\qquad d^+\delta^2(u;-\star)=+\tfrac{4}{3\sqrt6}>0.$$
**So the falsifier exists as a symmetric operator and is excluded by exactly one thing: $\mathrm{Alt}(-\star)=-\star\ne0$, so it is not a Weyl tensor.** It sits at the extreme opposite corner of the Bianchi constraint, it is $-1$ times the very form the Bianchi identity says $H$ must be orthogonal to.

**This is the strongest positive statement I can make about L17.** The first Bianchi identity is not a technical convenience in this proof; it is the entire separation between the lemma and its explicit counterexample, and it is used at full strength. Within $\mathcal W_n$ the chain of §5 is exact and no falsifier can exist.

## Verdict

**PROVEN, hypotheses corrected.**

The mathematics is right and I rebuilt every step of it: $a=\tfrac1{3\sqrt6}$, $\delta^2(u)=\tfrac19$, the Daleckii–Krein smooth branch, the degenerate-perturbation kink branch, the compression (by elementary means, retiring the imported theorem), the Bianchi/tangency balance, the sharp chain $F\ge\tfrac23\mathop{\mathrm{tr}}B_++\tfrac13\mathop{\mathrm{tr}}B_-\ge0$, the equality-set characterisation in both directions, the count $6+180=186$, and both crossover polynomials. **The first-order statement is dimension-free and holds from $n=4$; the $\Phi$ conclusion needs $\kappa_n\le0$ and therefore $n\ge12$, at both parities and under either pinning of $\kappa_n$.**

**The corrections owed to the record, in order of severity:**

1. **[results.md](../results.md) L17 must carry a statement.** §1 supplies one. As it stands the canonical entry is a heading over a pointer and nothing is citable.
2. **The block's closing prose still asserts the refuted equality set**, three lines below the blockquote refuting it. Replace "the equality cases being the competitor's own orbit, its hyper-Kähler rotations, and … every Weyl tensor of the complementary $\mathbb R^{n-4}$" with the iff of §6.
3. **Three consumed hypotheses are unstated**: $u$ critical, $\Lambda^-\subseteq\ker u$, and directional differentiability of $\delta^2$. All true; none written.
4. **The survival-of-the-repair display should cite [Lemma L2](../findings/problem.md)**, which proves both parities, rather than standing on two evaluated square roots.
5. **$\kappa$, $u$, $F$ and $B$ are live collisions absent from [conventions.md](../findings/conventions.md)'s collision table**, and $\kappa_n$ is the dangerous one: two objects of the same name differing by a factor of $600$ and a sign, both live inside [second-order.md](../findings/second-order.md).
6. **ATTEMPTS' convexity of $F$ is unverified** and should be marked so, or deleted, the closed-form characterisation of §6 makes the subgradient certificate it licenses redundant.

**None of these touches the truth of the lemma. All of them touch whether a reader can use it.**
