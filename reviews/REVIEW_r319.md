### Reviewer 319: the subalgebra collapse, post F40, and the kernel synthesis

**Verdicts.**

| | claim | verdict |
|---|---|---|
| **P1a** | on the subalgebra family $S_{\mathfrak{mmm}}=0\iff r=n(n-2)/4\iff\theta=\theta_0(n)$, and the collapse is "nearly a tautology" | **CONFIRMED, and the record's own hedge is exactly right.** Given criticality, $\theta(r)$ is strictly increasing and $S_{\mathfrak{mmm}}(r)$ strictly decreasing in the single integer $r$, so the three conditions are one condition written three ways. Both closed forms reproduced at **seven** independent critical members, $\theta$ and $S_{\mathfrak{mmm}}$ measured from structure constants rather than read off the formulas. **No family point has $S_{\mathfrak{mmm}}=0$ with $\theta<\theta_0(n)$** |
| **P1b** | the family is exactly the two-eigenvalue points, hence far smaller than the graded points; $S^3\times S^5$ and $S^2\times S^6$ sit outside with $S_{\mathfrak{mmm}}=0$ and $\theta<\theta_0(8)$ | **CONFIRMED to the digit**, $1.115546702$ and $0.986013297$ against $\theta_0(8)=1.145643924$, three eigenvalues each, $S_{\mathfrak{mmm}}=0$ exactly, $\ker W=0$. **"Exactly" is UNDECIDED**: only family $\subseteq$ two-eigenvalue is proved, and the eigen-equation forces strictly less than "$E_+$ is a subalgebra" |
| **P1c** | *(not asked)* what carries the cap | **The criticality hypothesis, not Lie theory.** $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ and $\mathfrak u(m)$ are symmetric pairs with $S_{\mathfrak{mmm}}=0$ genuinely and $r>$ cap; the lemma's formula returns $-15$ and $-48$ there. They fail Ricci-flatness and first Bianchi respectively |
| **P2a** | post F40's headline: the extension $\theta\le\frac2n\sqrt{rN/(N-r)}$ with $r=\dim E_+$ is false | **CONFIRMED**, all three counterexample values reproduced. And it is refutable in one line the record does not give: **the bound dies under zero-padding for every critical point at once** |
| **P2b** | "saturated exactly at the balanced sphere products" | **REFUTED.** Saturated at **every** member of the subalgebra family, maximal tori at $n=6,8,10$, the $\mathfrak{su}(3)$ bi-invariant, $(S^4)^3$ and $(S^3)^4$ at $n=12$, six of eight measured saturations being **ungraded** |
| **P2c** | "it fails badly wherever $\ker W\ne0$" | **REFUTED.** Over $69$ diagonal critical classes at $n=6\ldots9$ the bound fails at $6$ of the $23$ kernel-carrying ones and holds at $17$. A kernel *permits* the failure; it does not cause it |
| **P2d** | is there a repair that holds and is useful? | **The record's named candidate, the rank, is DEAD twice over**, vacuous ($+\infty$) at every kernel-free point and still false at padded $\mathbb{CP}^2$. Two repairs survive: $r:=N-\dim E_-$ (true everywhere tested, inert where needed) and $\theta\le(n-1)\lvert\lambda_{\min}\rvert$, **which is already on file as the $\lambda$-weighted bound**. The $\ker W=0$ restriction survives and **cannot deliver Conjecture A**, exceeding $\theta_0(n)$ at ten kernel-free catalogued points |
| **P3** | the four failures, each | **ALL FOUR CONFIRMED** independently |
| **P3** | $\ker W\ne0$ is the common cause | **CONFIRMED as the trigger, REFINED as the cause.** (a), (b) and (c) are **one fact**, every one of those instruments traces over $E_+\oplus E_-$, and a $\mathbb Z_2$-grading needs that to be all of $\mathfrak{so}(n)$, an exact biconditional. (d) is a different mechanism, eigenvalue **concentration**, for which the kernel is permissive rather than causal |
| **P3** | padding, reducibility, low rank as sharper causes | **ALL REFUTED** by a witness the record does not have: an **unpadded, irreducible, full-support** critical point at $n=6$ with $\ker W=7$ of $15$, at which (a), (c) and (d) all fire |

**The one-line summary.** P1's collapse is real and is a tautology, and the interesting fact underneath it is that the cap is bought by criticality rather than by any property of subalgebras. Post F40 is right to close the route and wrong about *where* the bound saturates and *when* it fails; its own diagnosis, "the kernel", is one of two mechanisms rather than one. And the four-way kernel synthesis is really a three-plus-one: three instruments reporting a single defect, and one broken inequality that the same points happen to trigger.

---

#### What was built

Everything below is re-derived in [scripts/reviewers/r319/](../scripts/reviewers/r319/) from the definitions; no repository script or library is imported and no recorded number was consulted before the corresponding quantity was computed. Log: [agent_logs/r319-kernel.log](../agent_logs/r319-kernel.log).

$\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ via $e_i\wedge e_j\mapsto A_{ij}=E_{ij}-E_{ji}$ with $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^TB)$, so the $A_{ij}$ are orthonormal; $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$ from real matrix brackets; the sharp map as $(W^\#)_{ab}=-\tfrac12\operatorname{tr}(C_aWC_bW)$ with $(C_a)_{\gamma\delta}=c_{a\gamma\delta}$; $Q=W^2+W^\#$, $\theta=\langle W,Q(W)\rangle$ at $\lVert W\rVert=1$. $\mathcal W_n$ is the joint nullspace of first Bianchi and Ricci on symmetric operators.

| calibration | result |
|---|---|
| $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ | exact at $n=4,5,6$ |
| $Q$ preserves $\mathcal W_n$ | residual $2\times10^{-14}$ on random elements of $\mathcal W_6$ |
| $\dim\mathcal W_n$ | $10,84,300,1638$ at $n=4,6,8,12$ |
| balanced sphere products critical | residual $\le3.3\times10^{-16}$ at $n=6,8,10,12$ |
| their values | $1.054092553,\ 1.145643924,\ 1.200000000,\ 1.236033081=\theta_0(n)$ |
| $\sum_\gamma g_\gamma=4(n-1)$ | $20.000000000000$ and $28.000000000000$ at $n=6,8$ |

So the conventions coincide with the record's and nothing below is a convention artefact.

---

#### P1a, the collapse is genuine and is a tautology, and the two closed forms are what carry it

Both closed forms were measured directly, $\theta$ as $\langle W,Q(W)\rangle$, and $S_{\mathfrak{mmm}}=\sum_{a,b,c\in\mathfrak m}c_{abc}^2$ over an orthonormal basis of $\mathfrak m=\mathfrak h^\perp$, never evaluated from the formula.

| $\mathfrak h\subset\mathfrak{so}(n)$ | $r$ | criticality residual | $\theta$ measured | $\theta$ formula | $S_{\mathfrak{mmm}}$ measured | $S_{\mathfrak{mmm}}$ formula |
|---|---|---|---|---|---|---|
| $\mathfrak{so}(3)^{\oplus2}\subset\mathfrak{so}(6)$ | $6$ | $1.7\times10^{-16}$ | $1.054092553$ | $1.054092553$ | $0$ | $0$ |
| $\mathfrak{so}(4)^{\oplus2}\subset\mathfrak{so}(8)$ | $12$ | $3.3\times10^{-16}$ | $1.145643924$ | $1.145643924$ | $0$ | $0$ |
| $\mathfrak{so}(5)^{\oplus2}\subset\mathfrak{so}(10)$ | $20$ | $2.2\times10^{-16}$ | $1.200000000$ | $1.200000000$ | $0$ | $0$ |
| $\mathfrak{so}(2)^{\oplus3}\subset\mathfrak{so}(6)$ | $3$ | $0$ | $0.645497224$ | $0.645497224$ | $48$ | $48$ |
| $\mathfrak{so}(2)^{\oplus4}\subset\mathfrak{so}(8)$ | $4$ | $6.2\times10^{-17}$ | $0.540061725$ | $0.540061725$ | $192$ | $192$ |
| $\mathfrak{so}(2)^{\oplus5}\subset\mathfrak{so}(10)$ | $5$ | $1.3\times10^{-16}$ | $0.474341649$ | $0.474341649$ | $480$ | $480$ |
| $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$ | $8$ | $2.5\times10^{-16}$ | $0.836660027$ | $0.836660027$ | $80$ | $80$ |

Given those, $\theta(r)=\frac2n\sqrt{rN/(N-r)}$ is strictly increasing and $S_{\mathfrak{mmm}}(r)=(N-r)[2(n-2)-4(n-1)r/N]$ is strictly decreasing and affine, both in the single integer $r$. So $\{S_{\mathfrak{mmm}}=0\}$, $\{r=n(n-2)/4\}$ and $\{\theta=\theta_0(n)\}$ are the same condition on one parameter. **The collapse is a tautology given the closed forms; the closed forms are the content.** And since $S_{\mathfrak{mmm}}(r)>0$ strictly for $r<$ cap, **no member has $S_{\mathfrak{mmm}}=0$ with $\theta<\theta_0(n)$.**

**Two scope notes the record's wording does not carry.** For odd $n$ the cap $n(n-2)/4$ is never an integer, so $S_{\mathfrak{mmm}}>0$ at every member and the collapse describes the **empty set**, C2 gains nothing there. And the equality chain "$S_{\mathfrak{mmm}}=0\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\iff\mathbb Z_2$-graded $\iff$ symmetric pair" is sound: $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ and invariance give $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ for free, so $S_{\mathfrak{mmm}}=0$ completes the grading.

#### P1c, the cap is bought by criticality, and the formula is FALSE without it

The most useful thing found under P1. The cap is **not** a statement about subalgebras: $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$ is a subalgebra with $r=13>12$, and $\mathfrak u(m)\subset\mathfrak{so}(2m)$ has $r=m^2>m(m-1)$. Both are **symmetric pairs, so both carry $S_{\mathfrak{mmm}}=0$ genuinely**, measured as exactly $0$. Feeding their $r$ into the lemma's formula returns a **negative sum of squares**:

| Casimir | $r$ | cap | $S_{\mathfrak{mmm}}$ measured | $S_{\mathfrak{mmm}}$ by formula | $\lVert\mathrm{Ric}\rVert$ | max Bianchi | criticality residual |
|---|---|---|---|---|---|---|---|
| $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$ | $13$ | $12$ | $0$ | $\mathbf{-15}$ | $1.04$ | $0$ | $1.1\times10^{-1}$ |
| $\mathfrak{so}(2)\oplus\mathfrak{so}(6)\subset\mathfrak{so}(8)$ | $16$ | $12$ | $0$ | $\mathbf{-48}$ | $1.87$ | $0$ | $3.4\times10^{-1}$ |
| $\mathfrak{so}(4)\oplus\mathfrak{so}(6)\subset\mathfrak{so}(10)$ | $21$ | $20$ | $0$ | $\mathbf{-19.2}$ | $0.93$ | $0$ | $6.9\times10^{-2}$ |
| $\mathfrak u(4)\subset\mathfrak{so}(8)$ | $16$ | $12$ | $0$ | $\mathbf{-48}$ | $5.5\times10^{-16}$ | $0.38$ | $3.4\times10^{-1}$ |
| $\mathfrak u(5)\subset\mathfrak{so}(10)$ | $25$ | $20$ | $0$ | $\mathbf{-80}$ | $4.0\times10^{-16}$ | $0.30$ | $2.7\times10^{-1}$ |

This is the same fact the record states as "(F2) and (F3) are load-bearing", but measured rather than asserted, and it sharpens the instruction: **the $S_{\mathfrak{mmm}}$ closed form may never be quoted for a subalgebra whose Casimir has not first been certified critical**, because off the hypothesis it is not merely unavailable but wrong. *My independent $\langle W,Q(W)\rangle$ at the two non-members returns $1.151371442$ and $1.203765957$, reproducing the record's $1.151371$ and $1.203766$.*

#### P1b, the reach, confirmed to the digit, with one overstated word

| point, $n=8$ | distinct $\Lambda^2$ eigenvalues | $\theta$ | $S_{\mathfrak{mmm}}$ | $\ker W$ | $\dim E_+$ |
|---|---|---|---|---|---|
| $S^4\times S^4$ | $\mathbf 2$ | $1.145643924=\theta_0(8)$ | $0$ | $0$ | $12$ |
| $S^3\times S^5$ | $\mathbf 3$ | $1.115546702$ | $0$ | $0$ | $13$ |
| $S^2\times S^6$ | $\mathbf 3$ | $0.986013297$ | $0$ | $0$ | $16$ |

Every figure in the correction reproduces. The unbalanced products carry $S_{\mathfrak{mmm}}=0$ with $\theta$ strictly below $\theta_0$ and lie outside the family, so $\{S=0\}$ is collapsed on the two-eigenvalue slice and nowhere else.

**"Exactly the two-eigenvalue points" is only proved in one direction.** Family $\Rightarrow$ two eigenvalues is immediate. The converse needs $E_+(W)$ to be a subalgebra at every two-eigenvalue critical point, and the eigen-equation does not force it. Writing $W=v\,\mathrm{Id}+t\Pi$ with $\Pi$ the projector on $V=E_+$, one has the identity (verified to $4\times10^{-15}$)

$$W^\#=v^2(n-2)\mathrm{Id}+vt\,E+\tfrac{t^2}2F,\qquad E_{ab}=\sum_{\gamma\in V,\ \varepsilon}c_{a\gamma\varepsilon}c_{b\gamma\varepsilon},\quad F_{ab}=\sum_{\gamma,\delta\in V}c_{a\gamma\delta}c_{b\gamma\delta},$$

so with $v=-cr/N$, $t=c$ the off-diagonal block of $Q(W)=\theta W$ reads $F_{ab}=\tfrac{2r}NE_{ab}$ for $a\in V$, $b\in V^\perp$, **one linear relation**, strictly weaker than $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, which is $E=F=0$ there. So the converse is a genuine open point, and the extra conditions are *not* the subalgebra property but the requirement that $W^\#$ be scalar on each block. At $r=1$ that is already computable in closed form: $F=0$ identically and $E=-\operatorname{ad}(v)^2$, the off-diagonal condition is vacuous since $\operatorname{ad}(v)v=0$, and criticality reduces to **$\operatorname{ad}(v)^2$ being scalar on $v^\perp$**, that is, $\operatorname{ad}(v)$ a multiple of a complex structure on $\Lambda^2\mathbb R^n\ominus\mathbb Rv$. A Grassmannian search over $E_+$ at $n=6$ found no solution at $r=1$, matching that. *Nothing downstream depends on it: the reach conclusion uses only the easy direction, so the word to change is "exactly" $\to$ "contained in".*

---

#### P2a, the headline holds, and the refutation is far cheaper than the one on record

| point | $n$ | $\dim E_+$ | $\ker W$ | $\theta$ (residual) | post-40 bound |
|---|---|---|---|---|---|
| $W_{\mathbb{CP}^2}$ | $4$ | $1$ | $3$ of $6$ | $1.224744871$ ($3.9\times10^{-16}$) | $\mathbf{0.547723}$ |
| padded $W_{\mathbb{CP}^2}$ | $8$ | $1$ | $25$ of $28$ | $1.224744871$ ($3.4\times10^{-16}$) | $\mathbf{0.254588}$ |
| padded $W_{\mathbb{CP}^2}$ | $12$ | $1$ | $63$ of $66$ | $1.224744871$ ($1.4\times10^{-16}$) | $\mathbf{0.167944}$ |

All three match the record to six digits, the unpadded $n=4$ failure included.

**But padding alone refutes the extension for every critical point simultaneously.** $\theta$ and $\dim E_+$ are both invariant under zero-padding $W$ into a larger $\mathbb R^n$, while the bound is $\frac2n\sqrt{rN/(N-r)}\to\frac2n\sqrt r\to0$. So *every* critical point with $\theta>0$ becomes a counterexample once padded far enough, no $\mathbb{CP}^2$ needed. Verified on witnesses found rather than asserted: padded $S^2\times S^2$ at $\theta=0.866025404$ against $0.506370$ ($n=6$) and $0.424795$ ($n=7$); padded $(S^2)^3$ at $0.645497224$ against $0.534522$ ($n=7$); a padded $n=5$ point at $0.942809042$ against $0.778499$ ($n=6$) and $0.635107$ ($n=7$). **This is the sentence a successor needs**: pad the witness and watch whether the bound moves. Any right-hand side built from dimension counts in $\Lambda^2\mathbb R^n$ dies the same way, and the screen costs nothing.

#### P2b, the saturation clause is REFUTED

Post F40 says the bound is "saturated exactly at balanced sphere products, which are the two-eigenvalue points the lemma was proved on". The two halves of that sentence disagree, and the second is the true one: on the subalgebra family the bound **is** Lemma L23, so it saturates on the whole family. Equality to twelve digits at:

| point | $n$ | $\theta=$ bound | graded? |
|---|---|---|---|
| $S^3\times S^3,\ S^4\times S^4,\ S^5\times S^5,\ S^6\times S^6$ | $6,8,10,12$ | $1.054092553,\ 1.145643924,\ 1.200000000,\ 1.236033081$ | yes |
| maximal torus $\mathfrak{so}(2)^{\oplus n/2}$ | $6,8,10$ | $0.645497224,\ 0.540061725,\ 0.474341649$ | **no** ($S_{\mathfrak{mmm}}=48,192,480$) |
| $(S^4)^3$, $(S^3)^4$ | $12,12$ | $0.829156198,\ 0.638284739$ | **no** |
| $\mathrm{ad}(\mathfrak{su}(3))$ bi-invariant | $8$ | $0.836660027$ | **no** ($S_{\mathfrak{mmm}}=80$) |

So the saturation set is neither the sphere products nor the graded points.

#### P2c, "$\ker W\ne0$" is not when the bound fails

Measured over $69$ diagonal critical classes solved from random starts at $n=6,7,8,9$ (criticality residual $<10^{-11}$):

| population | classes | post-40 fails |
|---|---|---|
| $\ker W=0$ | $46$ | $\mathbf 0$ |
| $\ker W\ne0$ | $23$ | $\mathbf 6$ |

The bound **holds** at $17$ of the $23$ kernel-carrying classes, including an $n=8$ class with $\ker W=7$ of $28$ at $\theta=0.648886$ against a bound of $0.763763$. A kernel is what *permits* the failure, not what produces it, which is the wedge that separates failure (d) from (a)–(c) in P3.

#### P2d, what the bound actually is, and which repairs survive

With $N=n(n-1)/2$ the two expressions are **identically equal** (verified to $8.9\times10^{-16}$ across $n=6\ldots20$, $r=1\ldots N-1$):

$$\frac2n\sqrt{\frac{rN}{N-r}}\;=\;(n-1)\sqrt{\frac r{N(N-r)}},$$

and $\sqrt{r/(N(N-r))}$ is exactly the value $\lvert\lambda_{\min}\rvert$ takes on a trace-free unit-norm **two-eigenvalue** operator with $\dim E_+=r$. **So post F40's bound is the record's own $\lambda$-weighted bound $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ with $\lvert\lambda_{\min}\rvert$ replaced by its two-eigenvalue surrogate.** That is the whole failure: the formula was kept and the hypothesis it encodes was dropped. At padded $W_{\mathbb{CP}^2}$, $n=8$, the surrogate is $\sqrt{1/756}=0.036372$ against a true $\lvert\lambda_{\min}\rvert=0.408248$, a factor $11.2$.

| candidate repair | verdict |
|---|---|
| $r:=\operatorname{rank}W$, **the record's named candidate** | **DEAD twice over.** Vacuous where the original was tight ($\operatorname{rank}=N$ at every kernel-free critical point, so the bound is $+\infty$), and still false where the original failed, $0.645497$ at padded $\mathbb{CP}^2$, $n=6$, against $\theta=1.224745$. It is right at $\mathbb{CP}^2$, $n=4$ ($1.224745$ exactly) by coincidence of $\operatorname{rank}=3$ with $N-\operatorname{rank}=3$ |
| $N:=\operatorname{rank}W$, $r:=\dim E_+$ | fails: $0.306186$ at padded $\mathbb{CP}^2$, $n=8$ |
| restrict to the support ($n\to s$, $N\to\binom s2$) | fails: $0.547723$ at $\mathbb{CP}^2$, $n=4$, which already has full support |
| $r:=N-\dim E_-$, i.e. $\mathfrak h:=(E_-)^\perp$ | **holds everywhere tested** (the structured catalogue and all $69$ diagonal classes) and coincides with the original when $\ker W=0$, so it keeps the entire saturation set. **Inert where it is needed**: $4.769696$ at padded $\mathbb{CP}^2$, $n=8$, and $7.659417$ at $n=12$ |
| $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ | **holds everywhere tested, with equality on the whole structured catalogue.** It is the record's $\theta\le\lvert\lambda_{\min}\rvert(4(n-1)-\Delta-G_0)/4$ at $\Delta=G_0=0$, hence **already proved** |
| the original, restricted to $\ker W=0$ | **holds on everything reachable and cannot serve**, see below |

**The $\ker W=0$ restriction cannot deliver Conjecture A.** The bound exceeds $\theta_0(n)$ at ten kernel-free catalogued points, precisely those with $\dim E_+>n(n-2)/4$:

| point | $n$ | $\dim E_+$ | cap | bound | $\theta_0(n)$ |
|---|---|---|---|---|---|
| $S^2\times S^{10}$ | $12$ | $46$ | $30$ | $2.053452$ | $1.236033$ |
| $S^3\times S^9$ | $12$ | $39$ | $30$ | $1.627313$ | $1.236033$ |
| $S^5\times S^7$ | $12$ | $31$ | $30$ | $1.274288$ | $1.236033$ |
| $S^2\times S^6$ | $8$ | $16$ | $12$ | $1.527525$ | $1.145644$ |
| $S^3\times S^5$ | $8$ | $13$ | $12$ | $1.231530$ | $1.145644$ |

**And it is a conjecture, not a corollary of $\ker W=0$.** For a general trace-free unit symmetric operator on $\mathbb R^{15}$ with $\dim E_+=1$ and no kernel, $\lvert\lambda_{\min}\rvert$ reaches $0.702$ against a surrogate of $0.069$, false by a factor of ten for arbitrary operators. Whatever makes it true on critical Weyl operators is criticality plus the Weyl conditions, so proving it costs what the thing it would be used for costs. *And the $\lambda_{\min}$ form has the same shape*: equality on the structured catalogue, but the ratio $\theta/((n-1)\lvert\lambda_{\min}\rvert)$ falls to $0.004$ across the diagonal classes, so it is tight exactly at the maximiser and enormously loose in the low-$\theta$ region.

---

#### P3, the four failures, verified one at a time

**(a) The gradedness screen returns vacuous zeros. CONFIRMED, and quantified.**

| padded $W_{\mathbb{CP}^2}$ | $\dim E_+$ | $\dim E_-$ | $\dim\ker$ | $S_{\mathfrak{mmm}}$ | $S_{\mathfrak{mpp}}$ | $S_{\mathfrak{ppp}}$ | $S_{\mathfrak{kkk}}$ |
|---|---|---|---|---|---|---|---|
| $n=4$ | $1$ | $2$ | $\mathbf3$ of $6$ | $0$ | $0$ | $0$ | $\mathbf{12}$ |
| $n=8$ | $1$ | $2$ | $\mathbf{25}$ of $28$ | $0$ | $0$ | $0$ | $\mathbf{252}$ |
| $n=12$ | $1$ | $2$ | $\mathbf{63}$ of $66$ | $0$ | $0$ | $0$ | $\mathbf{1164}$ |

The record's $25$ of $28$ and $63$ of $66$ are exact. **The measurement the record does not have is $S_{\mathfrak{kkk}}$**: the bracket mass sitting in the kernel is $12$, $252$, $1164$, the screen reports zero precisely where all the structure is. Controls: at $S^3\times S^5$ and $S^4\times S^4$, $\ker W=0$, the splitting spans, and the same screen is informative ($S_{\mathfrak{ppp}}=66$ and $48$, $S_{\mathfrak{mmp}}=90$ and $96$).

**(b) (C) does not imply (A) at $W_{\mathbb{CP}^2}$, $n=4$. CONFIRMED.** Built the $\mathrm{ad}(\mathfrak u(2))$-commutant inside $\mathcal W_4$ from scratch: $\dim\mathcal W_4=10$ and the invariant subspace is **exactly one-dimensional**, its generator agreeing with the self-dual $W_{\mathbb{CP}^2}$ to $1.1\times10^{-15}$. Spectrum $(0.408248^{\times2},0^{\times3},-0.816497)$, so $\ker W=3$ of $6$ and $E_+\oplus E_-$ is a $3$-plane in a $6$-space. (C) holds by construction; (A) cannot be stated.

**(c) "$\Delta=0\Rightarrow$ equivariant" is unsound off $\ker W=0$. CONFIRMED, and the structure argument can be closed.** $\Delta$ measured as $\sum_{\gamma\in E_+}\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$, calibrated by the sum over *all* $\gamma$ equalling $4(n-1)$ exactly.

| point | $\Delta$ | $\dim\mathfrak k(W)$ | $\mathfrak k(W)$ |
|---|---|---|---|
| $W_{\mathbb{CP}^2}$, $n=4$ | $3.1\times10^{-33}$ | $4$ | $\mathfrak u(2)$ |
| padded, $n=8$ | $1.2\times10^{-32}$ | $10$ | $\mathfrak u(2)\oplus\mathfrak{so}(4)$ |
| padded, $n=12$ | $2.7\times10^{-32}$ | $\mathbf{32}$ | $\mathfrak u(2)\oplus\mathfrak{so}(8)$ |

$\dim\mathfrak k(W)=32$ reproduces the record. $\Delta=0$ there is vacuous in the strongest available sense: $E_+$ is **one**-dimensional, so $\Delta=0$ asserts that a single vector is a symmetry. **The "no symmetric subalgebra" step can be closed outright.** A symmetric subalgebra of $\mathfrak{so}(12)$ is $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=12$ or $\mathfrak u(6)$; $\binom p2+\binom q2$ is minimised at $p=q$, so only $\mathfrak{so}(6)^{\oplus2}$ (dim $30$) and $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ (dim $31$) fit inside $32$ at all, and $\mathfrak u(6)$ has dim $36$. Then $\mathfrak{so}(6)^{\oplus2}$ has rank $6$ against $\operatorname{rank}(\mathfrak u(2)\oplus\mathfrak{so}(8))=5$; and $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ is semisimple, so it lies in the derived algebra $\mathfrak{su}(2)\oplus\mathfrak{so}(8)$ of dimension exactly $31$ and would have to equal it, which fails on simple-factor dimensions ($10,21$ against $3,28$). **None embeds**, the record's conclusion, with no unproved uniqueness claim in it.

**(d) Post F40's bound breaks there. CONFIRMED** (P2 above), with the two corrections recorded there.

---

#### The synthesis, tested rather than restated

**A witness the record does not have.** Padded $W_{\mathbb{CP}^2}$ is simultaneously a padding, reducible, low-rank and small-$\dim E_+$, which confounds every candidate cause. I built a critical point that is **unpadded, irreducible and of full support**, by computing the $\mathfrak{so}(3)_{\mathrm{diag}}$-invariant subspace of $\mathcal W_6$ (dimension $4$ of $84$) and solving there:

> $\theta=\mathbf{1.095445115}=\sqrt{6/5}$ to twelve digits, criticality residual $1.1\times10^{-15}$, $\Lambda^2$-spectrum $(0.456435^{\times3},\ 0^{\times7},\ -0.273861^{\times5})$, the record's $(\tfrac5{24},0,-\tfrac18)$ at multiplicities $3,7,5$, normalised. **Support $=6$ of $6$**, so it is no padding; $\ker W=7$ of $15$; $\dim\mathfrak k(W)=4$.

This is Jensen's second Einstein metric on $S^3\times S^3$, equivalently the $(\mathfrak{su}(3),\mathfrak{so}(3))$ pair. The same run returned $S^3\times S^3$ at $1.054092553$ and $Q_3$ at $0.759554525$, both with $\ker W=0$, as controls.

**Three of the four failures fire there, with no padding and no reducibility in sight.**

| failure | at Jensen's point |
|---|---|
| (a) screen vacuous | $S_{\mathfrak{mmm}}=0$, $S_{\mathfrak{mpp}}=0$ (the same certification padded $\mathbb{CP}^2$ gets), with $S_{\mathfrak{kkk}}=24$ unseen |
| (c) $\Delta=0$ without equivariance | $\Delta=3.0\times10^{-30}$, $\dim\mathfrak k(W)=4$; the smallest symmetric subalgebra of $\mathfrak{so}(6)$ is $\mathfrak{so}(3)^{\oplus2}$ at dimension $6$ (then $\mathfrak{so}(2)\oplus\mathfrak{so}(4)$ at $7$, $\mathfrak u(3)$ at $9$, $\mathfrak{so}(5)$ at $10$), so none embeds |
| (d) post-40 bound | $\mathbf{0.645497}$ against $\theta=1.095445$ |

| candidate common cause | verdict |
|---|---|
| the point is a **padding** | **REFUTED**, Jensen's point has full support and fires (a), (c), (d) |
| **reducibility** | **REFUTED** by the same witness; $\mathfrak{su}(3)$ acts irreducibly on $\mathbb R^6$ |
| **low rank** | **REFUTED as a sharpening.** $\operatorname{rank}<N$ is logically the same predicate as $\ker W\ne0$, and the quantitative reading fails in both directions: Jensen's rank is $8$ of $15$ and everything breaks, while the $n=8$ maximal torus has $\dim E_+=4$ of $28$ and nothing breaks |
| **small $\dim E_+$** | **REFUTED**, $\dim E_+=4$ at the $n=8$ torus with post-40 saturated and the screen sound |
| $\ker W\ne0$ | **survives as the trigger at every point tested** |

**But it is one fact and one coincidence, not four instances of one cause.**

*(a), (b) and (c) are the same statement in three instruments.* The screen, sense (A) and $\Delta$ are each **defined by tracing over the sign splitting** $E_+\oplus E_-$, and a $\mathbb Z_2$-grading requires that splitting to be all of $\mathfrak{so}(n)$. All three therefore say

> the sign splitting of $W$ is a splitting of $\mathfrak{so}(n)$ only when $\ker W=0$,

which is an exact biconditional rather than a correlation, and a single defect in a single construction reported three times because three instruments are built on it. The instruction that follows is sharper than "state your behaviour on the kernel": **any quantity defined by a trace over $E_\pm$ must carry $\dim\ker W$ as a precondition and return *undetermined*, not $0$.**

*(d) is a different mechanism.* Post F40's bound is $(n-1)\sqrt{r/(N(N-r))}$, and that radical is $\lvert\lambda_{\min}\rvert$ **for a two-eigenvalue operator**; the bound fails when $\lvert\lambda_{\min}\rvert$ exceeds its surrogate, which is eigenvalue **concentration**, not a splitting failure. Three pieces of evidence separate the two causes:

- the bound **holds** at $17$ of $23$ kernel-carrying critical classes, so the kernel is permissive rather than causal, whereas the *certification* (a)–(c) offer is void at **every** kernel-carrying point without exception, by the definition of a grading, whatever numbers the screen happens to print;
- (d) is refuted by padding *alone* (the bound $\to0$ while $\theta$ is fixed) whereas (a)–(c) are indifferent to how far a point is padded, the screen being exactly as vacuous at $n=4$ as at $n=12$;
- the repair differs: (a)–(c) are fixed by making one construction kernel-aware, (d) by replacing a surrogate with the quantity it stands for.

**So the synthesis reads better as two causes.** Three of the four are $E_+\oplus E_-\subsetneq\mathfrak{so}(n)$; the fourth is Lemma L23's two-eigenvalue hypothesis being dropped while its formula was kept. The record's closing sentence, "every one of these was invisible while the record worked with sphere products, which all have $\ker W=0$", is correct and is the load-bearing observation; what it under-reports is that a single kernel rule repairs three of them and leaves the fourth exactly as broken.

---

#### Found, not asked for

- **$\theta=(n-1)\lvert\lambda_{\min}\rvert$ is an identity on the structured catalogue and far from one off it.** Exact at all $36$ multi-block sphere products and every subalgebra-family member; across the diagonal critical classes at $n=6\ldots9$ the ratio falls to $0.004$. So the $\lambda_{\min}$ repair is sharp exactly where the conjecture is tight and very loose elsewhere, the right shape for a bound, and the reason it converts Conjecture A into the uncontrolled $\lvert\lambda_{\min}\rvert\le\theta_0(n)/(n-1)$ rather than resolving it.
- **A padding screen costs nothing and would have caught post F40 before it was written.** $\theta$, $\dim E_\pm$, $\ker W$ and the whole spectrum are padding-invariant; $n$, $N$ and every dimension count in $\Lambda^2\mathbb R^n$ are not. Any inequality mixing the two dies under padding. **This screen also flags the $\Delta$ convention already corrected in [bounds.md](../findings/bounds.md)**, so it has caught two things on this record independently.
- **The record's own instruments disagree about padded $W_{\mathbb{CP}^2}$ in a way the kernel explains completely.** $\Delta=0$ and $S_{\mathfrak{mmm}}=S_{\mathfrak{mpp}}=0$ are all computed over a $3$-dimensional subspace of a $66$-dimensional algebra. Every dispute recorded about whether that point is graded is a dispute about $63$ dimensions nobody measured.
