# Verifier v170, Lemma L11, the two-block sphere products that are Morse–Bott nondegenerate

Read cold from the definitions. **No numerical work was done**: no script, no Sage, no floating point, no re-run of the 36-split sweep or of the exact arithmetic at eight splits. Every value below is exact rational arithmetic carried by hand from the closed forms already on file, and every dimension is a polynomial evaluated at a named pair. Where the record's own computations are cited they are cited as recorded computations and never as proof. Log: [agent_logs/verify-L11-v170.log](../agent_logs/verify-L11-v170.log).

## The claim table

| # | Claim, as written | Where | Verdict |
| --- | --- | --- | --- |
| 1 | $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ follows from $\mu=\frac{n-2}{2(p-1)(q-1)}$ with $n=p+q$ | [nondegeneracy.md](../findings/nondegeneracy.md) L11 proof box | **PROVEN** |
| 2 | $\mu<\tfrac12$ exactly when $(p-2)(q-2)>1$; among $p,q\ge2$ this fails only at $\min(p,q)=2$ and at $(3,3)$ | same | **PROVEN** |
| 3 | At $p=2$, $\mu=\tfrac12+\frac1{2(n-3)}$ is **strictly above** $\tfrac12$ | L11 corrected statement | **PROVEN** |
| 4 | $\mu>\tfrac12$ costs maximality, not nondegeneracy | L11 corrected statement | **PROVEN** |
| 5 | "the dangerous eigenvalue **reaches** $\tfrac12$ at $p=2$ … which is degeneracy" | L11 second paragraph | **BROKEN** |
| 6 | "degenerate at $\min(p,q)=2$" | [results.md](../results.md) L393 header, L130 landscape, [INDEX-results.md](../findings/INDEX-results.md) row 11 | **BROKEN** |
| 7 | "at $\min(p,q)=2$ … the point is **nondegenerate** but not a maximiser" | L11 proof box | **HYPOTHESIS-DEBT** |
| 8 | $S^2\times S^4$ spectrum $1,\tfrac12,0,\tfrac13,\pm\tfrac23$ with $\tfrac12$ at multiplicity $pq=8$, exactly the orbit | L11 corrected statement | **HYPOTHESIS-DEBT**, values right, multiplicity unproven |
| 9 | Nondegenerate for $p,q\ge3$, $(p,q)\ne(3,3)$, kernel $=$ orbit tangent of dimension $pq$ | L11 corrected statement | **PROVEN at $n=p+q$**, with one inherited debt |
| 10 | Orbit dimension is $pq$ | throughout | **PROVEN**, at every $p,q\ge1$ |
| 11 | $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$ "is true and computes nothing" | L11 "WHAT WAS REFUTED" box | **PROVEN** |
| 12 | The same isomorphism is "the orbit's own representation, so two copies land on the same eigenvalue" | L11 trailing prose, [nondegeneracy.md:450](../findings/nondegeneracy.md) | **BROKEN** |
| 13 | "That isomorphism holds for no other $(k,l)$" | same | **PROVEN as stated, MISLEADING as glossed**, the dimension coincidence has a second solution $(2,5)$ |
| 14 | Kernel $18$ against an orbit of $9$ at $(3,3)$ | L11 trailing prose | **PROVEN** |
| 15 | "Verified at all 36 splits with $k,l\ge2$ up to $n=14$" | L11 trailing prose | **BROKEN as written**, the 36 include $(3,3)$, which the next paragraph calls the exception |
| 16 | "at eight of them, including $(4,4),(3,5),(5,5),(3,7),(6,6),(5,7)$ and $(3,9)$" | L11 trailing prose | **BROKEN**, seven named against "eight"; the omitted eighth is $(2,6)$, the one split that bears on the dispute |
| 17 | The statement holds at padded sphere products, $\ker W\ne0$ | nowhere qualified | **GAP**, no ambient dimension is stated and the proof covers only $n=p+q$ |
| 18 | "$S^7\times S^7$ at $n=14$ rests on floating point" | L11 trailing prose | **STALE**, L27 settles $(7,7)$ symbolically at $\tfrac12-\mu=\tfrac13$ |
| 19 | "Such an orbit is isolated in the critical set" | L11 trailing paragraph | **HYPOTHESIS-DEBT**, asserted; [second-order.md:803](../findings/second-order.md) says so in those words |
| 20 | The Kähler family and the two-block plateau are graded and degenerate; a value-localised version survives by fiat | L11 trailing paragraph | **CLEARED** (candidate contradiction with [L28](../findings/nondegeneracy.md) withdrawn, different family) |
| 21 | Symbol hygiene: $\mu$, $p$, $q$, $k$, $l$, $n$ | [conventions.md](../findings/conventions.md) | **GAP**, L11's $\mu$ is a fourth untabled meaning; $p$ collides with a prime six lines above the block |

## One line

**The mathematics says $\min(p,q)=2$ is *not* degenerate, so the 2026-09-04 corrected paragraph wins the internal contradiction and the refuted clause still stands, unamended, in three of the four places L11 is written down; but the corrected paragraph's own replacement claim, that $p=2$ is nondegenerate, commits at $p=2$ exactly the lower-bound-for-upper-bound error [L26](../findings/nondegeneracy.md) warns against, and has no proof on file.**

## 0. Conventions, fixed once

Quoted, not restated.

The object and the cubic, from [conventions.md](../findings/conventions.md):

> | $\mathcal W_n$ | the space of algebraic Weyl curvature operators on $\mathbb R^n$ |
> | $\dim\mathcal W_n$ | $\frac{n(n-3)(n+1)(n+2)}{12}$, $10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$ |
> | $Q(W)$ | Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself |
> | $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$ |

The multiplication operator, from the same file:

> - **The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it.

Padding, from the same file:

> - **Padding commutes with $Q$**, and preserves both the norm and $\theta$. The stratum reduction turns on this.

**Morse–Bott nondegeneracy is defined not in [conventions.md](../findings/conventions.md) but in [nondegeneracy.md:48](../findings/nondegeneracy.md)**, and that is the definition L11 turns on:

> A critical point is *Morse–Bott nondegenerate* when $\ker(\mathrm{Hess})$ equals the tangent space to the critical orbit through it, the standard definition.

The bridge from that kernel to the eigenvalue $\tfrac12$, from [second-order.md:39](../findings/second-order.md):

> [Lemma L24](../findings/second-order.md) gives $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ on the tangent space, this being the Riemannian Hessian, the constraint's $-3\theta\,\mathrm{Id}$ being what produces the $\tfrac12$.

The orbit tangent, from [nondegeneracy.md:56](../findings/nondegeneracy.md):

> $$T_{W_{S^k\times S^l}}\,SO(n).W_{S^k\times S^l}\;\cong\;\mathbb R^k\otimes\mathbb R^l,\qquad \dim=k\,l.$$

## 1. The hypothesis inventory

**What each imported result assumes, and which of those assumptions the written proof of L11 actually uses.**

| Import | Its own hypotheses | Used by L11's written proof? |
| --- | --- | --- |
| The Morse–Bott definition, [nondegeneracy.md:48](../findings/nondegeneracy.md) | a critical point; a critical *orbit* through it | **Yes**, and it is the whole content of "nondegenerate" |
| $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$, attributed to [L24](../findings/second-order.md) | $\theta\ne0$, it carries the division by $6\theta$ *and* the definition of $e=W/\theta$, "**two places, not one**" | **Yes, silently.** Without it, "$\mu=\tfrac12$" and "kernel" are unrelated statements. $\theta(W_{p,q})>0$ holds by the closed form $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ at [graded-half.md:441](../findings/graded-half.md), so the hypothesis is met and **L24's owed middle branch, a local maximiser at $\theta=0$, does not reach L11** |
| [L24](../findings/second-order.md) proper: $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$ | a **local maximiser** with $\theta\ne0$ | **No.** L11 imports only the normalisation identity, not the bound. This is correct and worth saying: L11 is not entitled to L24's inequality, since $W_{p,q}$ is not known to be a maximiser, and it does not use it |
| [L26](../findings/nondegeneracy.md) closed form | $n=p+q$ with **$p,q\ge2$**; $\pi$ a coordinate $2$-plane inside the $p$-block and $\rho$ one inside the $q$-block | **Yes**, and the range hypothesis is load-bearing, see §5 |
| [L27](../findings/nondegeneracy.md) | **$p,q\ge3$ and $(p,q)\ne(3,3)$**; the ten-summand $O(p)\times O(q)$ decomposition; irreducibility of each summand; pairwise-distinct Young labels; $n=p+q$ | **Yes** for the positive half. **Its range hypothesis is violated** by the corrected statement's $S^2\times S^4$ appeal, see §4 |
| Nienhaus Prop. 4.6, orbit-tangent identification | stated in [L26](../findings/nondegeneracy.md)'s Sources "for $p,q\ge5$" | **Yes.** L27 extends to $p,q\ge3$ by "exact $O(m)$-commutant computation at $m=3,4$", so **the pairs with a factor $3$ or $4$ rest on a recorded computation, not on the source** |
| [L128](../findings/second-order.md) / [Corollary L128.1](../findings/second-order.md) | explicitly "**Assume $p,q\ge3$** … *at $p=2$ it over-counts, $86$ against $84$ at $S^2\times S^4$*" | **Cited** by the corrected statement as "says the same and is right". It does say the same about $\mu\ne\tfrac12$; it says the **opposite** about whether $p=2$ is covered |

**A hypothesis stated but never used.** The corrected statement's "$(p,q)\ne(3,3)$" is used; "$p,q\ge3$" is used. I found no idle hypothesis in the L11 block itself. Its *proof box*, however, states a range it then leaves: "among $p,q\ge2$" is the range of the criterion, while the conclusion it draws at $\min(p,q)=2$ is drawn from [L27](../findings/nondegeneracy.md), whose range is $p,q\ge3$.

**A step using a hypothesis never stated.** Two. First, $\theta>0$, above. Second, and load-bearing: the inference from "$\mu\ne\tfrac12$" to "the kernel is the orbit tangent" needs *multiplicity-freeness of the decomposition at the pair in question*, which is stated in [L27](../findings/nondegeneracy.md) for $p,q\ge3$ and stated to be **false** at $p=2$. The corrected statement's $S^2\times S^4$ sentence uses it without stating it.

## 2. The closed form, derived rather than copied

The block gives the pair
$$\mu=\frac{n-2}{2(p-1)(q-1)},\qquad \tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}.$$
I derive the second from the first. With $n=p+q$ and $p,q\ge2$ the denominator $2(p-1)(q-1)$ is positive, so

$$\tfrac12-\mu=\frac{(p-1)(q-1)-(n-2)}{2(p-1)(q-1)}=\frac{(pq-p-q+1)-(p+q-2)}{2(p-1)(q-1)}=\frac{pq-2p-2q+3}{2(p-1)(q-1)},$$

and independently $(p-2)(q-2)-1=(pq-2p-2q+4)-1=pq-2p-2q+3$. The two numerators are the same polynomial. **Claim 1 is PROVEN.**

**Sign, exactly.** The denominator being positive throughout $p,q\ge2$, the sign of $\tfrac12-\mu$ is the sign of $(p-2)(q-2)-1$:

- **positive** ($\mu<\tfrac12$) iff $(p-2)(q-2)>1$;
- **zero** ($\mu=\tfrac12$) iff $(p-2)(q-2)=1$, which over integers $p,q\ge2$ forces $p-2=q-2=1$, i.e. $(3,3)$ alone, the other integer factorisation $(-1)(-1)$ needs $p=q=1$, outside the range;
- **negative** ($\mu>\tfrac12$) iff $(p-2)(q-2)<1$, which over integers $p,q\ge2$ means $(p-2)(q-2)=0$, i.e. $\min(p,q)=2$.

So among $p,q\ge2$ the criterion fails exactly on $\{\min(p,q)=2\}\cup\{(3,3)\}$, and it fails in two arithmetically different ways. **Claim 2 is PROVEN, and it is proven *with* the distinction the block draws.**

**At $p=2$ in closed form.** Setting $p=2$, $q=n-2$:
$$\mu=\frac{n-2}{2\cdot1\cdot(n-3)}=\frac{n-2}{2(n-3)}=\frac{(n-3)+1}{2(n-3)}=\tfrac12+\frac1{2(n-3)},$$
strictly greater than $\tfrac12$ at every $n\ge5$ (so at every $q\ge3$), and equal to $1$ at $n=4$, $q=2$. **Claim 3 is PROVEN.**

**At $p=1$.** The closed form has $(p-1)$ in the denominator and is undefined. This is not a removable singularity to be filled by a limit: [L26](../findings/nondegeneracy.md)'s eigenvector is "$X$ … $\phi_\pi\odot\phi_\rho$" with "$\pi$ a coordinate $2$-plane inside the $p$-block", and $\mathbb R^1$ contains no $2$-plane, so **the eigenvector does not exist at $p=1$ and there is nothing for $\mu$ to be the eigenvalue of.** L26's stated hypothesis $p,q\ge2$ is therefore used, not decorative. The criterion read formally at $p=1$ gives $(1-2)(q-2)=2-q$, which is $>1$ only for $q<1$; so the formal reading also declines every $q\ge2$, agreeing with the divergence $\mu\to+\infty$. L26 records the independent failure at the bottom end ("the ten dimensions over-count by $2$ at $q=2$ and by $1+p$ at $q=1$") so **$p=1$ is outside every hypothesis in play and L11 says nothing there. Checked and cleared.**

## 3. The disputed inference: what an eigenvalue strictly above $\tfrac12$ costs

**What degeneracy requires.** By the definition quoted in §0, degeneracy at $W$ means $\ker(\mathrm{Hess})\supsetneq T_W\mathcal O$. By the normalisation $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$ with $\theta>0$,
$$\ker(\mathrm{Hess}_SP)=\ker\!\big(L_e-\tfrac12\mathrm{Id}\big)\big|_{W^\perp}=E(\tfrac12)\cap W^\perp .$$
**Degeneracy therefore requires the value $\tfrac12$ to be attained off the orbit tangent, the value itself, not a neighbourhood of it, and not the threshold $\ge\tfrac12$.**

**What $\mu>\tfrac12$ gives instead.** On the summand carrying $\mu$, $\mathrm{Hess}_SP=6\theta(\mu-\tfrac12)>0$. A strictly positive Hessian direction transverse to the orbit says the point is **not a local maximiser**. It contributes **nothing** to the kernel, because $\mu\ne\tfrac12$. So an eigenvalue strictly above $\tfrac12$ off the orbit costs maximality and leaves nondegeneracy untouched. **Claim 4 is PROVEN.**

**So which of the two paragraphs is right.** The second paragraph reads:

> [Lemma L26] records that the dangerous eigenvalue **reaches** $\tfrac12$ at $p=2$ with excess $\tfrac1{2(n-3)}>0$, a direction outside the orbit carrying the orbit's own eigenvalue, which is degeneracy.

This is **self-refuting in its own sentence**. An "excess $\tfrac1{2(n-3)}>0$" is precisely the statement $\mu-\tfrac12>0$, i.e. $\mu\ne\tfrac12$; a direction whose eigenvalue differs from $\tfrac12$ does not carry "the orbit's own eigenvalue". The word "reaches" is inherited from [L26](../findings/nondegeneracy.md)'s own phrasing ("the family **reaches** $\tfrac12$ exactly at $p=2$, where it gives the recorded excess") where it means *reaches the threshold $\mu\ge\tfrac12$*, the quantity L26's displayed criterion actually characterises ("$\mu\ge\tfrac12\iff(p-2)(q-2)\le1$"). Reading "reaches" as "attains the value" is the conflation the corrected statement names. **Claim 5 is BROKEN, and the corrected paragraph's diagnosis of why is exact.**

I did not decide this by date stamp. It is decided by the arithmetic of §2: $\tfrac12+\frac1{2(n-3)}\ne\tfrac12$ for every $n\ge5$.

**Two independent corroborations, both already on the record and neither requiring a run.** [Lemma L126](../findings/second-order.md)'s own box states the same distinction in the same words, "[Lemma L24](../findings/second-order.md) needs $\ge\tfrac12$, and under *that* reading the four-set row's 'only at $(3,3)$' is false at $\min(p,q)=2$, where $\mu_{2,q}>\tfrac12$", and [second-order.md:918](../findings/second-order.md) uses "$\mu_{2,4}=\tfrac23$ as its witness" for exactly the distinction between "$\tfrac12$ is not an eigenvalue" and "spectrum $\le\tfrac12$". My §4 recomputes $\mu_{2,4}=\tfrac23$ from the closed form and agrees.

### 3.1 The refuted clause is still standing in three of the four places L11 is written

The correction lives in one bordered paragraph of one block. It has not reached:

| Location | Text still on file | Status |
| --- | --- | --- |
| [results.md](../results.md) line 393, the canonical statement | "degenerate at $\min(p,q)=2$ and at $(3,3)$" | **BROKEN** |
| [results.md](../results.md), the landscape entry | "**TWO exceptional families, not one** … was false at $\min(p,q)=2$, where [Lemma L26](../findings/nondegeneracy.md) records the dangerous eigenvalue reaching $\tfrac12$ with excess $\tfrac1{2(n-3)}>0$" | **BROKEN**, and it propagates the same "reaching … with excess" conflation |
| [INDEX-results.md](../findings/INDEX-results.md) row 11 | "**two exceptional families, not one**, the old statement being false at $\min(p,q)=2$" | **BROKEN** |
| [nondegeneracy.md](../findings/nondegeneracy.md) L11 block, second paragraph | as quoted above | **BROKEN** |

**Claim 6 is BROKEN.** The programme's canonical statement of L11 asserts a degeneracy that the closed form refutes. This is the finding with the widest blast radius in this round, because the canonical statement is what other blocks cite.

## 4. The $S^2\times S^4$ spectrum, rebuilt cold

The corrected paragraph offers this as the settling witness:

> at $S^2\times S^4$ the spectrum is $1,\tfrac12,0,\tfrac13,\pm\tfrac23$, with $\tfrac12$ at multiplicity $pq=8$, exactly the orbit.

**The values.** Substituting $p=2$, $q=4$, $n=6$ into [L27](../findings/nondegeneracy.md)'s ten values:

| summand | formal dimension at $(2,4)$ | $L_e$ | value |
| --- | --- | --- | --- |
| $\langle W\rangle$ | $1$ | $1$ | $1$ |
| $\mathrm{Weyl}_2$ | $\frac{2(2-3)(3)(4)}{12}=-2$ | $0$ | $0$ |
| $\mathrm{Weyl}_4$ | $\frac{4(1)(5)(6)}{12}=10$ | $0$ | $0$ |
| $\mathbb R^2\otimes\mathbb R^4$, the orbit tangent | $8$ | $\tfrac12$ | $\tfrac12$ |
| $S^2_0(\mathbb R^2)$ | $2$ | $\lambda_2=\frac{0}{2}$ | $0$ |
| $S^2_0(\mathbb R^4)$ | $9$ | $\lambda_4=\frac{2}{6}$ | $\tfrac13$ |
| $S^2_0\otimes S^2_0$ | $18$ | $-\mu$ | $-\tfrac23$ |
| $\Lambda^2\otimes\Lambda^2$ | $1\cdot6=6$ | $+\mu$ | $+\tfrac23$ |
| $X_2\otimes\mathbb R^4$ | $\frac{2(4-4)}{3}\cdot4=0$ | $0$ | $0$ |
| $X_4\otimes\mathbb R^2$ | $\frac{4(16-4)}{3}\cdot2=32$ | $0$ | $0$ |

with $\mu=\frac{6-2}{2\cdot1\cdot3}=\tfrac46=\tfrac23$ and $\lambda_m=\frac{m-2}{2(m-1)}$. **The listed value set $1,\tfrac12,0,\tfrac13,\pm\tfrac23$ is exactly right as a formal substitution.** The formal dimensions sum to $1-2+10+8+2+9+18+6+0+32=84=\dim\mathcal W_6$, and the trace is
$$1\cdot1+8\cdot\tfrac12+9\cdot\tfrac13+18\cdot(-\tfrac23)+6\cdot(+\tfrac23)=1+4+3-12+4=0,$$
so **the trace identity [L27](../findings/nondegeneracy.md) uses as its self-check passes at $(2,4)$.**

**And that is exactly why it looks right and is not proved.** The polynomial $\dim\mathcal W_m$ returns $-2$ at $m=2$, where the true $\dim\mathrm{Weyl}_2=0$. The **genuine** dimensions of the ten listed spaces therefore sum to $86$, not $84$:
$$1+0+10+8+2+9+18+6+0+32=86 .$$
So **the list is not a decomposition of $\mathcal W_6$ at $(2,4)$**, it over-counts by exactly $2$, which is the discrepancy [L27](../findings/nondegeneracy.md) states ("the ten dimensions over-counting by $2$ at $q=2$ … at every $n$") and which [Corollary L128.1](../findings/second-order.md) states in the same numbers ("*at $p=2$ it over-counts, $86$ against $84$ at $S^2\times S^4$*"). The trace check cannot detect the over-count, because the fictitious summand carries $L_e=0$ and so contributes nothing to $\operatorname{tr}L_e$ in either reading, which is why a passing check here is worth nothing.

**What the multiplicity claim would need.** At least one listed summand fails to sit inside $\mathcal W_6$ as listed, or two of them overlap; nothing on file says which. Until that is settled:

- $E(\tfrac12)\supseteq T_W\mathcal O$, of dimension $8$, holds, this is structural, from differentiating $Q(W_t)=\theta W_t$ along the orbit, and needs no decomposition;
- $E(\tfrac12)\subseteq T_W\mathcal O$ **does not follow**, because multiplicity-freeness is what makes $L_e$ a scalar on each piece, and it is unavailable here.

This is precisely the error [L26](../findings/nondegeneracy.md) warns against in its own words: *"An exhibited eigenvector bounds $\lambda_{\max}$ and one multiplicity from **below**. The statements nondegeneracy needs … are upper bounds on the rest of the spectrum, which no eigenvector supplies."* The corrected paragraph commits it at $p=2$, the one range where the tool that supplies the upper bound is declared inoperative. **Claim 8 is HYPOTHESIS-DEBT: the values are right, the multiplicity is unproven.**

**So the witness does not settle the dispute.** It settles half of it, the half it was aimed at. $\mu_{2,4}=\tfrac23\ne\tfrac12$ shows the $\Lambda^2\otimes\Lambda^2$ direction contributes no kernel, which refutes claim 5. It does not show that nothing *else* at $(2,4)$ attains $\tfrac12$, which is what "nondegenerate" asserts. **Claim 7 is HYPOTHESIS-DEBT:** what would have to be proved is *the $O(2)\times O(4)$ isotypic decomposition of $\mathcal W_6$ (the true one, of dimension $84$), together with the value of $L_e$ on each of its summands*; equivalently, at general $q$, the $O(2)\times O(q)$ decomposition of $\mathcal W_{q+2}$ and its $L_e$ values.

**The record's own evidence points the same way, and I record it as recorded computation only.** [nondegeneracy.md:377](../findings/nondegeneracy.md) states "The whole $S^2\times S^k$ family for $k=2,\ldots,8$ is nondegenerate at its own dimension"; the exact-arithmetic list at [nondegeneracy.md:424](../findings/nondegeneracy.md) includes $(2,6)$ among the eight, and [nondegeneracy.md:428](../findings/nondegeneracy.md) explains why the mod-$p$ inequality chain settles *nondegeneracy* specifically ("mod-$p$ bounds the kernel from above"). **That is corroboration of the corrected paragraph's conclusion and is not a proof of it**, and I neither re-ran nor extended it.

## 5. The edge of every range

- **$p=1$.** Outside every hypothesis; see §2. The eigenvector does not exist, $\mu$ is undefined, and [L27](../findings/nondegeneracy.md)'s dimension count over-counts by $1+p$. **Cleared, nothing claimed.**
- **$p=2$.** §§3–4. The criterion places it correctly ($\mu>\tfrac12$); the conclusion drawn from that placement is right for maximality and unproven for nondegeneracy.
- **$(3,3)$.** §6. $(p-2)(q-2)=1$ exactly, $\mu=\tfrac12$, degenerate. The block, [L27](../findings/nondegeneracy.md) and [L126](../findings/second-order.md) agree.
- **$(2,4)$ at $n=6$.** §4. The 86-against-84 count is where the decomposition fails, and I reproduced it from the dimension polynomials alone.
- **$(3,4)$, odd $n=7$.** $\mu=\frac{5}{2\cdot2\cdot3}=\tfrac5{12}<\tfrac12$, and $\tfrac12-\mu=\frac{(1)(2)-1}{12}=\tfrac1{12}$, matching [L26](../findings/nondegeneracy.md)'s stated gap. L26's claim that $\mu$ overtakes $\lambda_{\max(p,q)}=\lambda_4=\tfrac13$ here is right ($\tfrac5{12}>\tfrac13$), and its factored criterion $(p-2)(q-3)<2$ is met ($1\cdot1=1$). At $(3,5)$ the criterion gives $1\cdot2=2$, not $<2$, and indeed $\mu=\frac{6}{2\cdot2\cdot4}=\tfrac38=\lambda_5$ exactly, equality, consistent. **Neither disturbs nondegeneracy**, since both have $\mu<\tfrac12$. Odd $n$ raises nothing here: L11's statement is indexed by $(p,q)$, not by $n$, and every odd $n\ge7$ split with $p,q\ge3$ sits inside L27's range.
- **The top of the range.** L11's statement has **no upper bound on $p,q$**, while the trailing prose's evidence stops at $n=14$. That gap is closed by [L27](../findings/nondegeneracy.md), whose $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ is symbolic in $p,q$, so the "proven on a subfamily, used in general" trap is **present in the prose and closed by the lemma below it**. It is not closed at $p=2$, where L27 does not reach; there the only evidence is a sweep to $n=14$ and exact arithmetic at one split, under a claim with no upper bound. **Recorded as part of claim 7's debt.**
- **$\ker W\ne0$: padded sphere products.** §7.

## 6. The $(3,3)$ exception: which of the two accounts is the mechanism

The block says one thing in a bordered box and the opposite in its trailing prose.

> **Box:** "That isomorphism is true and computes nothing, it is a coincidence of dimension in three variables, and it identifies neither the eigenvalue nor the second exceptional family."

> **Prose:** "At $k=l=3$ one has $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$ (the orbit's own representation) so two copies land on the same eigenvalue and the kernel is $18$ against an orbit of $9$."

**The box is right.** The argument is settled by the group the decomposition is taken under. [L27](../findings/nondegeneracy.md)'s summands are irreducible under **$O(p)\times O(q)$**, and under $O(3)$,
$$\Lambda^2(\mathbb R^3)\;\cong\;\mathbb R^3\otimes\det\;\not\cong\;\mathbb R^3,$$
since $-\mathrm{Id}\in O(3)$ acts by $+1$ on $\Lambda^2(\mathbb R^3)$ and by $-1$ on $\mathbb R^3$. Hence, under $O(3)\times O(3)$,
$$\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\;\cong\;(\mathbb R^3\boxtimes\mathbb R^3)\otimes(\det\boxtimes\det)\;\not\cong\;\mathbb R^3\boxtimes\mathbb R^3 .$$
The isomorphism the prose invokes exists only after passing to $SO(3)\times SO(3)$, where the two $\det$ twists become trivial, and the argument is not conducted there. [L27](../findings/nondegeneracy.md) states the measurement that confirms it: "$\dim\mathrm{Comm}_{O(3)^2}=2$ against $\dim\mathrm{Comm}_{SO(3)^2}=4$, so Schur permits no mixing and the two summands carry $\tfrac12$ separately." Two non-isomorphic summands that happen to carry the same scalar is an **eigenvalue coincidence**, and no isomorphism forces it; what forces it is $(3-2)(3-2)-1=0$ in the closed form. The block's own "Schur is not the mechanism" paragraph says the same thing a second time ("multiplicity-freeness forces one scalar per piece but never forces the scalars apart") and then contradicts itself in its last clause, "the content lies in the representation isomorphism above". **Claims 11 PROVEN, 12 BROKEN.** The trailing prose is stale against three separate passages in its own file.

**The uniqueness claim, and a witness that sharpens the box.** "That isomorphism holds for no other $(k,l)$" is **true read as an isomorphism**: for $k,l\ge3$ the tensor-factor structure forces $\Lambda^2(\mathbb R^k)\cong\mathbb R^k$, which under $SO(k)$ holds only at $k=3$. But read as the *dimension coincidence* the box says it really is, uniqueness fails:
$$\tbinom k2\tbinom l2=kl\iff (k-1)(l-1)=4\iff (k,l)\in\{(3,3),(2,5),(5,2)\}.$$
$(2,5)$ has the same dimension coincidence ($1\cdot10=10=2\cdot5$) and is **not** degenerate: $\mu_{2,5}=\frac{7-2}{2\cdot1\cdot4}=\tfrac58\ne\tfrac12$, and $S^2\times S^5$ is inside the family [nondegeneracy.md:377](../findings/nondegeneracy.md) records as nondegenerate at its own dimension. **So a closed-form witness confirms the box's verdict from the other side: the dimension coincidence occurs elsewhere without producing degeneracy, hence it cannot be the mechanism.** Claim 13.

**The count.** $\dim(\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3))=3\cdot3=9$ and $\dim(\mathbb R^3\otimes\mathbb R^3)=9$; both carry $\tfrac12$ at $(3,3)$, giving $\dim E(\tfrac12)=18$ against $\dim\mathcal O=pq=9$, excess $9$. **Claim 14 PROVEN**, and it is the same $9$ that [nondegeneracy.md:409](../findings/nondegeneracy.md) reports surviving every padding of $S^3\times S^3$.

**Orbit dimension, at every split.** The stabiliser of $W_{p,q}$ in $O(n)$ contains $O(p)\times O(q)$, whose extra swap component at $p=q$ is discrete, so
$$\dim\mathcal O=\tbinom n2-\tbinom p2-\tbinom q2=pq\quad\text{identically in }p,q .$$
So the "$\dim=pq$" in the statement is right at $p=1$, $p=2$, $(3,3)$, $(2,4)$ and every large pair alike, **it is the one quantity in the block that needs no range hypothesis at all.** Claim 10 PROVEN.

## 7. $\ker W\ne0$: padded sphere products, and the ambient dimension nobody states

**The trap is live here, and it is a scope defect rather than a false theorem.**

Every form of L11 on file names the object as "$S^p\times S^q$" and **never names the ambient dimension**. [L26](../findings/nondegeneracy.md) fixes "$n=p+q$" inside its own statement and [L27](../findings/nondegeneracy.md) decomposes $\mathrm{Weyl}_n$ at $n=p+q$, so **the written proof establishes the conclusion at the native dimension only.** But [conventions.md](../findings/conventions.md) records that "**Padding commutes with $Q$**, and preserves both the norm and $\theta$", and [nondegeneracy.md:409](../findings/nondegeneracy.md) records that "every critical point pads to a critical point with the same $\theta$ and the same $S$", so the zero-padded $W_{p,q}$ in $\mathcal W_{n'}$, $n'>p+q$, is a critical point that any reader would call $S^p\times S^q$, with $\ker W\ne0$ by construction.

At those points the record's own statements are:

| padded object | what the record reports | bears on L11's range? |
| --- | --- | --- |
| $S^3\times S^3$ padded to $n=8,\ldots,14$ | "keeps excess $9$ … including odd $n$" ([nondegeneracy.md:409](../findings/nondegeneracy.md)) | no, $(3,3)$ is already excluded |
| $S^2\times S^k$, $k=2,\ldots,8$, at every padding | "nondegenerate natively but degenerate at every larger $n$", excess $q(n-n_0)$ ([nondegeneracy.md:377](../findings/nondegeneracy.md), [:409](../findings/nondegeneracy.md)) | no, outside $p,q\ge3$, **but it is the standing proof that padding *creates* degeneracy** |
| $S^4\times S^4$ padded $8\to10$; $S^5\times S^5$ padded $10\to12$; $S^6\times S^6$ padded $12\to14$; $S^6\times S^7$ padded $13\to14$ | $\dim E(\tfrac12)=$ orbit, and *equal* rather than equidimensional ([nondegeneracy.md:367](../findings/nondegeneracy.md), [:369](../findings/nondegeneracy.md)) | **yes**, all inside $p,q\ge3$, all clean |
| $S^3\times S^q$, $q\ge4$, padded | nothing on file | **yes, untested and unproven** |

**So the finding is precise.** No counterexample to L11 exists among padded objects on the record inside $p,q\ge3$, $(p,q)\ne(3,3)$, the balanced $\ge4$ paddings are reported clean. But (i) the statement as written admits the padded reading and its proof does not cover it, and (ii) the neighbouring $S^2\times S^k$ family shows the padded reading is not automatically inherited, so the omission is not harmless boilerplate. **Claim 17 is a GAP**: what would have to be proved is that $E(\tfrac12)$ at the padded $W_{p,q}$ in $\mathcal W_{n'}$ is still $pq$-dimensional, i.e. that the $\mathfrak{so}(n'-n)$-inflated orbit and the new $\mathcal W_{n'}$ directions contribute no further $\tfrac12$. The cheap repair, which I do not apply, is to write "$n=p+q$" into the statement.

**One related trap cleared.** [nondegeneracy.md:371](../findings/nondegeneracy.md) records that any padding of a seed from $n_0$ has $\min|\lambda-\tfrac12|=\frac1{2(n_0-1)}$ independent of the target dimension, so no *uniform-in-$n$* spectral gap is available. L11 makes no uniform-gap claim, so nothing in L11 rests on one. **Checked, nothing found.**

## 8. The two census sentences

**"Verified at all 36 splits with $k,l\ge2$ up to $n=14$."** The count is right: splits with $2\le k\le l$ and $k+l=n$ number $1,1,2,2,3,3,4,4,5,5,6$ for $n=4,\ldots,14$, summing to $36$. **And $(3,3)$ is one of the 36**, the very split the next paragraph calls the exception, where the kernel is $18$ against an orbit of $9$. As written, the sentence asserts the kernel identity at a split where the block itself denies it. *Argued the other way:* the charitable reading is "the census covered 36 splits and the identity held except where noted below", which the following paragraph does supply. I therefore report this as a **wording defect that makes the block self-contradictory on its face** rather than as a false measurement, but it is a defect that survived into a canonical block, and the same sentence also silently asserts the identity across every $\min=2$ split, which is the disputed family. **Claim 15.**

**"at eight of them, including $(4,4)$, $(3,5)$, $(5,5)$, $(3,7)$, $(6,6)$, $(5,7)$ and $(3,9)$."** Seven splits are named under the word "eight". The source paragraph six lines above, [nondegeneracy.md:424](../findings/nondegeneracy.md), gives the list as "$(4,4),(3,5),(2,6)$; $(5,5),(3,7)$; $(6,6),(5,7),(3,9)$", eight, grouped $3+2+3$ for $n=8,10,12$. **The omitted eighth is $(2,6)$**, and it is the only split in the exact-arithmetic list with $\min(p,q)=2$, hence the only exact evidence on file bearing on the family this round is about. Dropping it from the list is not a neutral abbreviation. Separately, **both** paragraphs claim exactness "over $\mathbb Q$ at $n=6$" while the grouped list attaches no $n=6$ split to that clause; the $n=6$ splits are $(2,4)$ and $(3,3)$, and [nondegeneracy.md:428](../findings/nondegeneracy.md) explains that $(3,3)$ is exactly where mod-$p$ was insufficient and $\mathbb Q$ was needed, so the $\mathbb Q$ entry most likely certifies *degeneracy* at $(3,3)$, which is not one of "them". **Claim 16.**

**"$S^7\times S^7$ at $n=14$ rests on floating point."** True when written, stale now: $(7,7)$ has $\tfrac12-\mu=\frac{(5)(5)-1}{2\cdot6\cdot6}=\frac{24}{72}=\tfrac13>0$ and $p,q\ge3$ with $(p,q)\ne(3,3)$, so [L27](../findings/nondegeneracy.md) (five lines below), proves it symbolically. The sentence leaves the record's flagship $n=14$ case reading as unproven. **Claim 18, STALE.** ([nondegeneracy.md:769](../findings/nondegeneracy.md) records that this exact species of staleness was already caught once in this file.)

## 9. Imported theorems whose hypotheses were checked against the object

The named trap is a cited theorem assuming a *unital* algebra where $\mathcal W_n$ has no unit. **I looked for its analogue here and found one of the same shape, milder.**

- **Nienhaus Proposition 4.6.** [L26](../findings/nondegeneracy.md)'s Sources say it "supplies the $SO(p)\times SO(q)$ decomposition … **for $p,q\ge5$**". L11's range is $p,q\ge3$. [L27](../findings/nondegeneracy.md) is explicit that the shortfall is filled by hand: "The multiplicity-freeness at $p,q\le4$, asserted rather than proved in the source, is supplied by exact $O(m)$-commutant computation at $m=3,4$: every $\mathrm{End}=1$ and every cross-$\mathrm{Hom}=0$". **So every pair of L11's range with a factor $3$ or $4$ (including $(3,4)$, $(3,5)$, $(4,4)$ and the whole $(3,q)$ and $(4,q)$ families), inherits a recorded exact computation in place of a citation.** That is honestly declared and correctly scoped; it is nonetheless a computation, and this loop does not verify computations. **HYPOTHESIS-DEBT, inherited, declared, low severity.**
- **A group mismatch that matters and is handled.** Nienhaus decomposes under $SO(p)\times SO(q)$; L27's Schur step needs irreducibility under $O(p)\times O(q)$, and §6 shows the two groups give different answers at $(3,3)$, under $SO(3)^2$ the pair *is* isomorphic and Schur would permit mixing. L27 states the $O$-version and measures the commutant dimensions on both sides. **Checked and cleared; the block does not confuse the two.**
- **[L24](../findings/second-order.md)'s maximiser hypothesis.** Not imported; see §1. **Cleared.**
- **The "real division algebra" step in [L27](../findings/nondegeneracy.md).** L27 itself notes the generality is unused, "every $O(m)$-irreducible is of real type, so the commutant is $\mathbb R$ throughout". **Cleared.**

## 10. Symbol collisions

[conventions.md](../findings/conventions.md)'s own rule is that "**definitions and conventions are quoted, never restated**", and that file already carries a warning about this letter:

> **$\mu$ CARRIES TWO MEANINGS THIRTY LINES APART IN [bispectral.md](../findings/bispectral.md), AND A THIRD IN [target.md](../findings/target.md).**

- **$\mu$ is a fourth meaning, untabled.** [conventions.md](../findings/conventions.md) defines "$\mu=\operatorname{spec}(M)$ on $\Lambda^2$ at $\lVert M\rVert_F=1$", a *spectrum*, not a scalar. L11 and L26's $\mu$ is the scalar by which $L_e$ acts on $\Lambda^2(\mathbb R^p)\otimes\Lambda^2(\mathbb R^q)$. It appears nowhere in [conventions.md](../findings/conventions.md). **GAP, claim 21.**
- **$p$ collides with a prime, six lines above the block.** The box immediately preceding L11 writes "$k\,l=\mathrm{rank}_p(\text{orbit})\le\mathrm{rank}_{\mathbb Q}(\text{orbit})\le\mathrm{nullity}_{\mathbb Q}\le\mathrm{nullity}_p=k\,l$" and "modulo two primes", with $p$ a prime, while the L11 statement three paragraphs later uses $p$ for a sphere dimension. The file evidently switches to $(k,l)$ in that region to free the letter, which is a reasonable local fix; the collision is nonetheless live within one screen.
- **$(p,q)$ and $(k,l)$ name the same objects inside one block without a word saying so.** The bordered paragraphs use $(p,q)$; the trailing prose uses $(k,l)$ for the identical splits. A reader arriving at "For $S^k\times S^l$ the common value is $k\,l$" has no statement that $k=p$.
- **$n$.** Consistent throughout as $p+q$ in the bordered paragraphs; the trailing prose's "up to $n=14$" and "at the same $n=6$" agree. **Cleared.**
- **The Morse–Bott definition itself is not in [conventions.md](../findings/conventions.md)**, contrary to that file's stated purpose; it lives at [nondegeneracy.md:48](../findings/nondegeneracy.md). Since the whole dispute in §3 is over what "degenerate" requires, this is the definition most worth having in one quotable place.

## 11. Withdrawn candidates

Three candidates cleared the first step of the protocol and failed a later one. They are recorded here so that a later reader does not re-open them.

### 11.1 WITHDRAWN, "the Kähler family is degenerate" contradicts [L28](../findings/nondegeneracy.md)

The block's trailing paragraph says "the Kähler family $\mathfrak{su}(m)$ and the two-block plateau … are graded and Morse–Bott degenerate, with kernel excesses of $5$, $9$, $14$, $20$ and $16$", while [L28](../findings/nondegeneracy.md) proves "$\mathbb{CP}^m$ is Morse–Bott nondegenerate … **With no exception**, unlike the sphere products". These look flatly opposed. **They are not the same family.** [second-order.md:317](../findings/second-order.md) names it as "$\mathfrak{su}(m)$ Kähler at $0.8290\,\theta_0(12)$, the degenerate family with excess $5,9,14,20$ at $m=3,4,5,6$", and [target.md:385](../findings/target.md) identifies it as "the $(\mathfrak{su}(m),\mathfrak{so}(m))$ Kähler family", distinct from the $\mathfrak u(m)$-invariant $W_{\mathbb{CP}^m}$ of L28. The excesses fit $\tfrac{m(m+1)}2-1$ at $m=3,4,5,6$, indexing that family and not L28's. **Withdrawn at step 2: no concrete failure can be exhibited, because the two statements are about different objects.** The one residue worth a line: the paragraph names the family only as "$\mathfrak{su}(m)$", one letter away from L28's subject, in a file where L28 sits sixty lines below.

The rest of that paragraph checks out as written. "Every known exception sits at value at most $1.054$, below the rival maximizer's $\sqrt{3/2}$" is consistent with [nondegeneracy.md:559](../findings/nondegeneracy.md), and its conclusion is correctly labelled: the value-localised version survives **"by fiat"**, the exceptions are *excluded by hypothesis*, not disposed of. That self-description is accurate and I record it as such rather than as a defect. It does, however, mean the intended use of L11 (every graded critical point nondegenerate, hence the graded set a union of components), is stated in the same paragraph to be **false**, so L11's consumer is a value-localised hypothesis, not the crux as originally framed.

### 11.2 WITHDRAWN, "$\mathrm{Weyl}_2=-2$ makes the trace identity fail at $(2,4)$"

The natural suspicion is that the fictitious $-2$ corrupts [L27](../findings/nondegeneracy.md)'s $\operatorname{tr}L_e=0$ self-check. It does not: that summand carries $L_e=0$, so the trace is $0$ under both the formal and the genuine reading, as computed in §4. **Withdrawn at step 2.** The observation survives in inverted form and is stronger that way, *the check passes at a pair where the decomposition is false*, so passing it is no evidence of the decomposition.

### 11.3 WITHDRAWN, "$(2,2)$ falsifies the kernel identity"

[L26](../findings/nondegeneracy.md) records that at $(2,2)$ "the operator $e$ is non-primitive under the Hodge splitting of $\Lambda^2(\mathbb R^4)$, the spectrum is $(-1)^4,(\tfrac12)^4,1^2$, and $1$ is not simple". The multiplicities sum to $10=\dim\mathcal W_4$, and $\dim E(\tfrac12)=4=pq=\dim\mathcal O$, so the kernel identity **holds** at $(2,2)$ even though the eigenvalue $1$ is not simple there. **Withdrawn at step 2: no failure to exhibit.** Worth one line only because $(2,2)$ is inside the 36-split census and outside every stated range.

## The verdict

**BROKEN.**

Not because the mathematics of the nondegeneracy theorem is wrong (the positive half stands) but because the statement of L11 that the rest of the record cites asserts a degeneracy that the record's own closed form refutes, and it still asserts it in three of the four places L11 is written down.

Read per claim:

| Part of L11 | Verdict |
| --- | --- |
| Nondegenerate for $p,q\ge3$, $(p,q)\ne(3,3)$, at $n=p+q$, kernel $=$ orbit tangent of dimension $pq$ | **PROVEN**, by [L27](../findings/nondegeneracy.md), carrying one declared inherited debt: multiplicity-freeness at $p,q\in\{3,4\}$ rests on exact commutant computation rather than on Nienhaus, whose range is $p,q\ge5$ |
| Degenerate at $(3,3)$, kernel $18$ against orbit $9$ | **PROVEN**, by $(3-2)(3-2)-1=0$; the mechanism is an eigenvalue coincidence between two **non-isomorphic** $O(3)\times O(3)$-summands |
| "Degenerate at $\min(p,q)=2$", [results.md](../results.md) L393, [results.md](../results.md) L130, [INDEX-results.md](../findings/INDEX-results.md) row 11, and the block's second paragraph | **BROKEN.** $\mu=\tfrac12+\frac1{2(n-3)}>\tfrac12$, so the direction does not carry $\tfrac12$ and contributes no kernel. The cited "excess $>0$" is itself the refutation |
| "Nondegenerate at $\min(p,q)=2$", the block's corrected paragraph and proof box | **HYPOTHESIS-DEBT.** True of the $\Lambda^2\otimes\Lambda^2$ direction; unproven of the point, because the upper bound on the rest of the spectrum comes from a decomposition that is false at $p=2$ by $86$ against $84$ |
| The $(3,3)$ mechanism, trailing prose | **BROKEN**, contradicted by [L27](../findings/nondegeneracy.md), by the block's own box, and by its own "Schur is not the mechanism" paragraph |
| Ambient dimension | **GAP**, unstated everywhere, proven only at $n=p+q$, and the adjacent $S^2\times S^k$ family shows padding can destroy the property |

**What I did not do.** I supplied no missing argument, repaired nothing, and ran nothing. The $S^2\times S^4$ multiplicity, the $(2,q)$ decomposition, the padded case and the $m=3,4$ commutants are named as debts, not filled.

## What would break the conclusion I reach

**The conclusion I am defending is the positive half: for $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$, $\dim E(\tfrac12)=pq$ and the Hessian kernel is exactly the orbit tangent.**

**The object that would falsify it** is a pair $(p,q)$ with $p,q\ge3$, $(p,q)\ne(3,3)$, together with an element $Y\in\mathcal W_{p+q}$ orthogonal to $W_{p,q}$ and to the orbit tangent $\mathbb R^p\otimes\mathbb R^q$, satisfying $e\circ Y=\tfrac12 Y$. Concretely it would have to be one of:

1. **a second summand of [L27](../findings/nondegeneracy.md)'s ten whose value is $\tfrac12$.** I checked all ten in closed form. $\tfrac12-\lambda_m=\frac{(m-1)-(m-2)}{2(m-1)}=\frac1{2(m-1)}>0$ at every $m\ge2$, so neither $S^2_0$ summand reaches it; $-\mu=\tfrac12$ would need $\mu=-\tfrac12$, impossible since $\mu>0$ throughout $p,q\ge2$; the four zero summands are $\tfrac12$ away; $1$ on $\langle W\rangle$ is removed by the restriction to $W^\perp$, which [L27](../findings/nondegeneracy.md) flags as load-bearing; and $+\mu=\tfrac12$ is exactly $(p-2)(q-2)=1$, i.e. $(3,3)$ alone. **None exists.**
2. **an eleventh summand, i.e. a failure of the ten-term decomposition at some $p,q\ge3$.** The dimensions sum to $\dim\mathcal W_n$ identically in $p,q$ as a polynomial identity, and the identity is only *violated* where a summand's polynomial dimension differs from its true one, which happens exactly where $\dim\mathcal W_m$ goes negative, at $m=2$ ($-2$) and $m=1$ ($-1-p$ in L27's accounting). At $m\ge3$ the polynomial is non-negative and the count is honest. **I looked at the bottom edge and found the failure sits below L11's range, not inside it.**
3. **a failure of multiplicity-freeness at some $p,q\ge3$, letting $L_e$ mix two summands and produce $\tfrac12$ off the orbit.** This is the live one. It is a citation for $p,q\ge5$ and a computation at $m=3,4$; I verified that the $(3,3)$ near-miss is genuinely a near-miss under $O(3)\times O(3)$ (commutant $2$, not $4$) and that the dimension coincidence $\binom k2\binom l2=kl$ has only the solutions $(3,3)$ and $(2,5)$, the latter outside the range and nondegenerate. **I found no candidate inside $p,q\ge3$, and I state plainly that I checked the coincidence, not the commutant.**
4. **a padded $S^p\times S^q$ with $p,q\ge3$, $(p,q)\ne(3,3)$, degenerate in a larger ambient.** Here the search is genuinely incomplete: the record reports balanced $\ge4$ paddings and $S^6\times S^7$ clean, and reports nothing at all for padded $(3,q)$ with $q\ge4$. **That is where I would look next, and it is where I stopped, since looking further would require a run.**

**How I looked.** By reading the ten values as closed forms in $p,q$ and testing each against $\tfrac12$ symbolically; by solving $(p-2)(q-2)=1$ and $(k-1)(l-1)=4$ over the integers; by recomputing every dimension in the $(2,4)$ table from the polynomials; and by reading [L26](../findings/nondegeneracy.md), [L27](../findings/nondegeneracy.md), [L28](../findings/nondegeneracy.md), [L126](../findings/second-order.md) and [L128](../findings/second-order.md) at source. No sweep, no sample, no arithmetic that was not exact.
