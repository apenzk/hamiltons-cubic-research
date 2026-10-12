# REVIEW r874: the sharp bound $\lVert\mathrm{Alt}(A)\rVert\le\sqrt{(m-1)/(3m)}\operatorname{tr}A$ on a positive semidefinite operator, and the ruling between the $m$-form and the $n$-form

*The brief was cold: I read the brief and [L204AltBound.lean](../lean/HamiltonsCubic/Results/L204AltBound.lean) and nothing else of the record. No numerical work beyond screening was done, every value reported here is exact (rational or a named surd), and the screens are reported as screens and never as evidence for a positive claim. The derivations below are by hand and the screens only confirm them. Log: [agent_logs/review-r874-altbound.log](../agent_logs/review-r874-altbound.log).*

## Claim table

| # | Claim | Verdict | Reason |
|---|---|---|---|
| 1 | $\lVert\mathrm{Alt}(A)\rVert\le\sqrt{(m-1)/(3m)}\operatorname{tr}A$ for every psd $A$ on $\Lambda^2\mathbb R^n$, $m=\lfloor n/2\rfloor$, in the record's norm | **CONFIRMED** | every link re-derived independently and the composition closes exactly |
| 2 | The triangle-inequality step, with $\operatorname{tr}A=\sum_\alpha\mu_\alpha$ as the factor | **CONFIRMED** | positivity is load-bearing and supplies exactly $\lvert\mu_\alpha\rvert=\mu_\alpha$, and orthonormality supplies the unit sphere |
| 3 | $\lVert\omega\wedge\omega\rVert^2=24\sum_{i<j}a_i^2a_j^2$ and $\max_{\lVert\omega\rVert=1}\lVert\omega\wedge\omega\rVert=\sqrt{12(m-1)/m}$ | **CONFIRMED** | the $24$ is $\tfrac14\cdot4!\cdot 2^2$ and the simplex maximum is $\tfrac{m-1}{2m}$, uniquely at $a_i^2=1/m$ |
| 4 | $\tfrac16\sqrt{12(m-1)/m}=\sqrt{(m-1)/(3m)}$ | **CONFIRMED** | $12/36=1/3$, exact |
| 5 | The ruling: the $m$-form is at most the $n$-form at every $n\ge2$, equal at even $n$, strictly smaller at odd $n$ | **CONFIRMED** | exact difference is $0$ at even $n$ and $-1/\bigl(k(6k+3)\bigr)$ at $n=2k+1$ |
| 6 | The separation figures at $n=9$: $\tfrac12$ against $\sqrt{7/27}=0.509175$ | **CONFIRMED** | $\sqrt{7/27}=\sqrt{21}/9=0.5091750772\ldots$ |
| 7 | The screened maxima $2.449490,\,2.828427,\,3,\,3$ at $n=4,6,8,9$ | **CONFIRMED** | $\sqrt6,\sqrt8,3,3$, reproduced in exact rationals from the record's own wedge |
| 8 | The $m$-form is *the sharp form* | **CONFIRMED, AND STRENGTHENED** | the constant is attained, by a rank-one projection onto a balanced bivector at every $n\ge4$, so no smaller constant works |
| 9 | The constant is not attained by a Weyl tensor (attack item 6, not in the quoted blocks) | **REFUTED** | a self-dual $W\in\mathcal W_4$ attains it exactly, $\lVert\mathrm{Alt}(W^2)\rVert=\lVert W\rVert^2/\sqrt6$, and the same object attains it in $\mathcal W_5$ |
| 10 | Lean: `altConst_le_altConstN`, `altConst_eq_altConstN_of_even`, `altConst_lt_altConstN_n9` are the prose claims they are named for | **CONFIRMED** | all three type exactly what the prose says, build clean, no `sorry` |
| 11 | Lean: `alt_le_altConst_trace` is the prose bound with the maximisation as its only gap | **REFUTED AS STATED** | as typed the statement is **false**, not merely unproved: nothing constrains $\omega$ to be unit or orthonormal, so scaling $\omega$ breaks it, and the eigenbasis is indexed by `Fin n` where the operator has $\binom n2$ eigenpairs |
| 12 | An upper bound cannot close a vanishing statement in $G_W$, only a lower bound at a failing $W$ would (attack item 9, paraphrased in the brief) | **REFUTED AS STATED** | a norm upper bound is two-sided on the quadratic form, and in this normalisation $\lvert\langle\Theta x,x\rangle\rvert\le\lVert\Theta\rVert\lVert x\rVert^2$ exactly, which is the tool a $\langle G_Wx,x\rangle\le0$ argument needs |
| 13 | The written derivation is complete as written | **REFUTED AS STATED (presentation)** | two steps are used and not stated: the $4!\times2^2\times\tfrac14$ component count behind the $24$, and the $O(n)$-invariance that licenses the reduction to canonical form |

## One line someone can act on

**Fold the bound in as written, with the constant and the ruling both correct and the constant provably optimal. Then repair two things: delete the record's side-claim that no Weyl tensor attains the constant (a self-dual $W\in\mathcal W_4$ does, exactly), and restate `alt_le_altConst_trace` with orthonormality and a $\binom n2$-sized index, because as typed it is a false statement rather than an unproved one.**

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector, the inner product being $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- **The norm on a four-index tensor is the record's: $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$.** This is load-bearing throughout and is the convention the claims below are stated at.
- The wedge of two bivectors is $(\omega\wedge\eta)_{ijkl}=\omega_{ij}\eta_{kl}-\omega_{ik}\eta_{jl}+\omega_{il}\eta_{jk}+\omega_{jk}\eta_{il}-\omega_{jl}\eta_{ik}+\omega_{kl}\eta_{ij}$, so $(\omega\wedge\omega)_{ijkl}=2(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$. **The record's wedge is TWICE the Pfaffian.**
- $\mathcal W_n$ is the space of algebraic Weyl tensors: symmetric operators on $\Lambda^2\mathbb R^n$, first Bianchi, Ricci-flat, trace-free. $\lVert W\rVert^2=\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)$ over the eigenvalues. Criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.

## Hypothesis inventory

| Hypothesis | Where the chain uses it | The object it applies to | Status |
|---|---|---|---|
| $A$ is a symmetric operator on $\Lambda^2\mathbb R^n$ | given 1, to have a spectral decomposition at all | $A=W^2$, a square of a symmetric operator | holds |
| $A\succeq0$, that is $\mu_\alpha\ge0$ for all $\alpha$ | step one, to replace $\sum_\alpha\lvert\mu_\alpha\rvert$ by $\operatorname{tr}A$ | $W^2\succeq0$ for every real symmetric $W$ | holds, and is essential (section 1.3) |
| the eigenbasis is ORTHONORMAL, $\lVert\omega_\alpha\rVert=1$ | step one, to invoke a maximum taken over the unit sphere | spectral theorem on a real inner-product space | holds, and is the hypothesis Lean drops |
| $\operatorname{tr}A$ is the trace on $\Lambda^2\mathbb R^n$, a sum of $\binom n2$ eigenvalues | step one, as the factor | $\operatorname{tr}(W^2)=\lVert W\rVert^2$ by the record's own convention | holds, no norm mismatch (section 1.2) |
| canonical form with $m=\lfloor n/2\rfloor$ blocks, given 3 | step two, to parametrise the maximisation | every bivector | holds |
| $\lVert\cdot\rVert$ is $O(n)$-invariant and $\wedge$ is $O(n)$-equivariant | step two, to reduce the maximisation to canonical form | the record's $\tfrac14\sum R^2$ and the record's wedge | holds, **used without being stated** |
| $\mathrm{Alt}$ carries the constant $\tfrac16$, given 1 | both steps, linearly | the bound's constant scales with it | holds, screened independently (section 1.1) |
| $m\ge1$, that is $n\ge2$ | the constant $(m-1)/(3m)$ to be defined | `altConst_le_altConstN` and `altConst_eq_altConstN_of_even` carry `2 ≤ n`, while `alt_le_altConst_trace` carries no such hypothesis | gap in Lean only (section 5.4) |
| first Bianchi, Ricci-flat, trace-free | **nowhere** | $\mathcal W_n$ | unused, so the bound is a statement about arbitrary psd operators and applies to the square of any curvature operator |

## 1. Attack item 1: the triangle-inequality step

### 1.1 The starting identity, and a screen of its constant

The step begins from given 1, $\mathrm{Alt}(A)=\tfrac16\sum_\alpha\mu_\alpha\,\omega_\alpha\wedge\omega_\alpha$. The whole bound is linear in that $\tfrac16$, and the brief records that the constant was once $\tfrac13$ and was withdrawn, so I screened it rather than taking it on trust. With $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ and $R=\sum_\alpha\mu_\alpha\,\omega_\alpha\otimes\omega_\alpha$ in components, the two sides agree identically at $n=4$ on the operator $2u_1\otimes u_1-u_2\otimes u_2-u_3\otimes u_3$ of section 4, in exact rationals. By hand on the rank-one case: for $u=(\varphi_{12}+\varphi_{34})/\sqrt2$ one has $u_{12}=u_{34}=-1/\sqrt2$, so $R_{1234}=\tfrac12$ while $R_{1342}=R_{1423}=0$, giving $\mathrm{Alt}(R)_{1234}=\tfrac13\cdot\tfrac12=\tfrac16$, while $(u\wedge u)_{1234}=2u_{12}u_{34}=2\cdot\tfrac12=1$ and so $\tfrac16(u\wedge u)_{1234}=\tfrac16$. The $\tfrac16$ stands.

### 1.2 The step itself

$\lVert\cdot\rVert$ with $\lVert R\rVert^2=\tfrac14\sum R_{ijkl}^2$ is a positive scalar multiple of the Euclidean norm on four-index tensors, hence a genuine norm, so the triangle inequality and absolute homogeneity apply:

$$\lVert\mathrm{Alt}(A)\rVert\ \le\ \tfrac16\sum_\alpha\lvert\mu_\alpha\rvert\,\lVert\omega_\alpha\wedge\omega_\alpha\rVert\ \le\ \tfrac16\Bigl(\max_{\lVert\omega\rVert=1}\lVert\omega\wedge\omega\rVert\Bigr)\sum_\alpha\lvert\mu_\alpha\rvert .$$

The second inequality needs $\lVert\omega_\alpha\rVert=1$, which orthonormality of the eigenbasis supplies, and needs the maximum to exist, which continuity on a compact sphere supplies. Positivity then gives $\sum_\alpha\lvert\mu_\alpha\rvert=\sum_\alpha\mu_\alpha=\operatorname{tr}A$. So yes: positivity gives exactly what the step needs and no more, and $\operatorname{tr}A$ is the right factor.

The factor is coherent with the record's application $\lVert\mathrm{Alt}(W^2)\rVert\le C\lVert W\rVert^2$, because $\operatorname{tr}(W^2)=\sum_\alpha\lambda_\alpha^2=\lVert W\rVert^2$ in the record's convention. I checked that the two norms in play do not clash. For $R=\sum_\alpha\mu_\alpha\,\omega_\alpha\otimes\omega_\alpha$ with orthonormal $\omega_\alpha$,

$$\tfrac14\sum_{ijkl}R_{ijkl}^2=\tfrac14\sum_{\alpha\beta}\mu_\alpha\mu_\beta\Bigl(\sum_{ij}(\omega_\alpha)_{ij}(\omega_\beta)_{ij}\Bigr)^2=\tfrac14\sum_{\alpha\beta}\mu_\alpha\mu_\beta(2\delta_{\alpha\beta})^2=\sum_\alpha\mu_\alpha^2 ,$$

so the record's four-index norm of a curvature operator equals the Frobenius norm of the operator. The $\tfrac14$ is exactly the factor that makes the two agree, and it is also the factor that makes $\langle Rx,y\rangle=\tfrac14\sum R_{ijkl}x_{ij}y_{kl}$ reproduce the eigenvalues. This is a positive finding about the convention rather than a defect, and it is what section 7 uses.

### 1.3 What happens without positivity

**The step's conclusion is FALSE without positivity, not merely unproved.** The inequality through $\sum_\alpha\lvert\mu_\alpha\rvert$ survives, so what survives is $\lVert\mathrm{Alt}(A)\rVert\le\sqrt{(m-1)/(3m)}\,\lVert A\rVert_1$ with the nuclear norm in place of the trace. The stated form fails, and it fails by the widest possible margin at a trace-free $A$.

Closed form, at $n=4$. Take $w_1=(\varphi_{12}+\varphi_{34})/\sqrt2$ and $w_2=(\varphi_{12}-\varphi_{34})/\sqrt2$, which are orthonormal, and set $A=w_1\otimes w_1-w_2\otimes w_2$, extended by zero. Then $\operatorname{tr}A=0$ while $(w_1\wedge w_1)_{1234}=2\cdot\tfrac12=1$ and $(w_2\wedge w_2)_{1234}=2\cdot(-\tfrac12)=-1$, so

$$\mathrm{Alt}(A)_{1234}=\tfrac16\bigl(1\cdot1+(-1)(-1)\bigr)=\tfrac13,\qquad \lVert\mathrm{Alt}(A)\rVert^2=\tfrac14\cdot24\cdot\tfrac19=\tfrac23 .$$

So $\lVert\mathrm{Alt}(A)\rVert=\sqrt{2/3}>0=C\operatorname{tr}A$. Screened in exact rationals and it returns $2/3$. Positivity is therefore load-bearing and must stay in every restatement of the bound.

## 2. Attack item 2: the maximisation, which is the crux

### 2.1 Total antisymmetry, which is what makes the count work

$T_{ijkl}:=(\omega\wedge\omega)_{ijkl}=2(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$ is totally antisymmetric. Checking the three adjacent transpositions, which generate $S_4$, and using $\omega^{\mathsf T}=-\omega$:

- $T_{jikl}=2(\omega_{ji}\omega_{kl}-\omega_{jk}\omega_{il}+\omega_{jl}\omega_{ik})=2(-\omega_{ij}\omega_{kl}+\omega_{ik}\omega_{jl}-\omega_{il}\omega_{jk})=-T_{ijkl}$.
- $T_{ikjl}=2(\omega_{ik}\omega_{jl}-\omega_{ij}\omega_{kl}+\omega_{il}\omega_{kj})=-T_{ijkl}$.
- $T_{ijlk}=2(\omega_{ij}\omega_{lk}-\omega_{il}\omega_{jk}+\omega_{ik}\omega_{jl})=-T_{ijkl}$.

Consequently every tuple with a repeated index contributes zero, and all $4!$ orderings of a four-element index set carry the same magnitude.

### 2.2 The $24$, checked against $4!$ and against the $\tfrac14$

Put $\omega=\sum_{i=1}^m a_i\varphi_{2i-1,2i}$, so $\omega_{pq}\ne0$ only for $\{p,q\}$ inside one block, with $\omega_{2i-1,2i}=-a_i$. A nonzero $T_{ijkl}$ needs four distinct indices, and each of the three products pairs them two and two, so the only surviving index sets are $\{2p-1,2p,2q-1,2q\}$ for a pair of blocks $p<q$. On the ordered tuple $(2p-1,2p,2q-1,2q)$,

$$T=2\bigl(\omega_{2p-1,2p}\,\omega_{2q-1,2q}-\omega_{2p-1,2q-1}\,\omega_{2p,2q}+\omega_{2p-1,2q}\,\omega_{2p,2q-1}\bigr)=2\bigl((-a_p)(-a_q)-0+0\bigr)=2a_pa_q .$$

So the record's "value $2a_ia_j$ each" is right. The bookkeeping to the $24$ is then

$$\sum_{ijkl}T_{ijkl}^2=\underbrace{4!}_{\text{orderings per set}}\cdot\sum_{p<q}\underbrace{(2a_pa_q)^2}_{4a_p^2a_q^2}=96\sum_{p<q}a_p^2a_q^2,\qquad \lVert\omega\wedge\omega\rVert^2=\tfrac14\cdot96\sum_{p<q}a_p^2a_q^2=24\sum_{p<q}a_p^2a_q^2 .$$

The $24$ is exactly $\tfrac14\cdot4!\cdot2^2$: the $4!$ signed components of a basis four-form, the squared value $2^2$ from the record's wedge being twice the Pfaffian, and the record's $\tfrac14$. The identity is confirmed. **The written derivation states the per-set value and the answer and omits this count**, so a reader cannot check the $24$ from what is on the page. That is a presentation gap, item 13 of the table, and not a defect in the result.

### 2.3 The reduction to canonical form, which is used and not stated

The maximisation is over all unit bivectors, and the calculation above is carried out in one particular frame. The step is licensed by $O(n)$-equivariance of the wedge together with $O(n)$-invariance of $\tfrac14\sum R^2$, both of which hold because the wedge formula is built from index contractions and the norm is a full contraction. Neither is stated in the written chain. Second half of item 13.

### 2.4 The simplex maximum and its uniqueness

With $t_i=a_i^2\ge0$ and $\sum_i t_i=\lVert\omega\rVert^2=1$,

$$\sum_{i<j}t_it_j=\frac{\bigl(\sum_it_i\bigr)^2-\sum_it_i^2}{2}=\frac{1-\sum_it_i^2}{2},$$

so maximising $\sum_{i<j}t_it_j$ is minimising $\sum_it_i^2$ on the simplex, which by Cauchy–Schwarz is $\ge1/m$ with equality exactly at $t_i=1/m$ for all $i$. Hence

$$\max\sum_{i<j}a_i^2a_j^2=\frac{1-1/m}{2}=\frac{m-1}{2m},\qquad \max_{\lVert\omega\rVert=1}\lVert\omega\wedge\omega\rVert^2=24\cdot\frac{m-1}{2m}=\frac{12(m-1)}{m}. $$

**The maximiser is unique in $t$ and not unique as a bivector.** The vector $(t_1,\dots,t_m)=(1/m,\dots,1/m)$ is the unique critical point of the strictly convex $\sum t_i^2$ on the simplex, so "balanced" is a unique condition on the block moduli. The set of maximising bivectors is the full $O(n)$-orbit of $\tfrac1{\sqrt m}\sum_i\varphi_{2i-1,2i}$ together with all sign patterns $a_i=\pm1/\sqrt m$, so the Lean docstring's "attained at the balanced bivector $\sum\varphi_{2i-1,2i}/\sqrt m$" is correct as naming one attainer and should not be read as uniqueness.

### 2.5 Screen of item 7's figures

At $m=\lfloor n/2\rfloor$ the value $\sqrt{12(m-1)/m}$ is $\sqrt6=2.449489742\ldots$ at $n=4$, $\sqrt8=2.828427124\ldots$ at $n=6$, and exactly $3$ at $n=8$ and at $n=9$. Reproduced from the record's own wedge formula and the record's own norm in exact rationals at $n=4,6,8,9$, giving $6,8,9,9$ for the squares. The record's quoted six-decimal figures are right.

## 3. Attack item 3: the composition

$$\tfrac16\sqrt{\frac{12(m-1)}{m}}=\sqrt{\frac{12(m-1)}{36m}}=\sqrt{\frac{m-1}{3m}} .$$

Exact, since $12/36=1/3$. Confirmed. The constant is increasing in $m$ and bounded: $\sqrt{(m-1)/(3m)}<1/\sqrt3=0.5773502\ldots$ for every $m$, with the value $0$ at $m=1$. So the result is in substance a dimension-free bound $\lVert\mathrm{Alt}(A)\rVert<\tfrac1{\sqrt3}\operatorname{tr}A$, refined by dimension.

Two consistency checks on the endpoints. At $n=2$ and $n=3$ the constant is $0$, which is forced, because $\Lambda^4\mathbb R^3=0$ and $\Lambda^4\mathbb R^2=0$, and the mechanism agrees: $m=1$ means every bivector has a single block and so $\omega\wedge\omega=0$.

## 4. Attack items 4 and 5: the ruling, and whether the ordering ever reverses

Write $m=\lfloor n/2\rfloor$ and compare $f(m)=(m-1)/(3m)$ with $g(n)=(n-2)/(3n)$.

**Even $n=2k$, $k\ge1$.** Then $m=k$ and $g(2k)=(2k-2)/(6k)=(k-1)/(3k)=f(k)$. Equality at every even $n\ge2$.

**Odd $n=2k+1$, $k\ge1$.** Then $m=k$ and

$$f(k)-g(2k+1)=\frac{k-1}{3k}-\frac{2k-1}{6k+3}=\frac{(k-1)(6k+3)-(2k-1)\cdot3k}{3k(6k+3)}=\frac{(6k^2-3k-3)-(6k^2-3k)}{3k(6k+3)}=\frac{-3}{3k(6k+3)}=\frac{-1}{k(6k+3)} .$$

Strictly negative for every $k\ge1$. So the $m$-form is strictly smaller at every odd $n\ge3$, and the numerator being the constant $-3$ independent of $k$ is the whole content of the ruling.

**The ordering never reverses.** The two parity classes above are exhaustive for $n\ge2$, and in each the sign is fixed, so no $n\ge2$ reverses it. There is nothing left to search. Item 5: confirmed, the block's "no" is right.

Exact values, screened:

| $n$ | $m$ | $(m-1)/(3m)$ | $(n-2)/(3n)$ | order |
|---|---|---|---|---|
| 2 | 1 | $0$ | $0$ | equal |
| 3 | 1 | $0$ | $1/9$ | strict |
| 4 | 2 | $1/6$ | $1/6$ | equal |
| 5 | 2 | $1/6$ | $1/5$ | strict |
| 6 | 3 | $2/9$ | $2/9$ | equal |
| 7 | 3 | $2/9$ | $5/21$ | strict |
| 8 | 4 | $1/4$ | $1/4$ | equal |
| 9 | 4 | $1/4$ | $7/27$ | strict |
| 10 | 5 | $4/15$ | $4/15$ | equal |
| 11 | 5 | $4/15$ | $3/11$ | strict |
| 12 | 6 | $5/18$ | $5/18$ | equal |
| 13 | 6 | $5/18$ | $11/39$ | strict |

The odd cases the brief asks for in exact arithmetic: $n=5$ is $1/6$ against $1/5$, $n=7$ is $2/9$ against $5/21$, $n=9$ is $1/4$ against $7/27$. All three strict.

**The $n=9$ strictness figures.** $\sqrt{1/4}=\tfrac12$ and $\sqrt{7/27}=\sqrt{21}/9=4.5825756950\ldots/9=0.5091750772\ldots$, so the recorded $0.509175$ is right to six decimals and the recorded $\tfrac12$ is exact. Item 6 confirmed.

**The mechanism sentence is right.** A canonical form carries $\lfloor n/2\rfloor$ blocks, so $n\mapsto n+1$ across an even-to-odd step adds no block and no room, which an $n$-shaped constant cannot express. Section 6 adds the part the block does not have: the $m$-form is not only smaller at odd $n$, it is attained there, so the $n$-form is provably not the optimal constant at odd $n$.

## 5. Attack item 10 in the Lean layer, and the fidelity question the brief asks

Build, run as the brief gives it: `Build completed successfully (8708 jobs)`, with a single diagnostic, `L204AltBound.lean:95:8: declaration uses 'sorry'`. Line 95 is `alt_le_altConst_trace`. So the file is as advertised in its sorry count. I report this as a screen of the record's own claim about its own file.

### 5.1 `altConst_le_altConstN` IS the prose claim

Typed: `∀ n, 2 ≤ n → altConst (n / 2) ≤ altConstN n`, with `n / 2` natural division, so the argument is literally $\lfloor n/2\rfloor$. That is the ruling of block 2 exactly, no weaker and no wider. The proof splits on parity, which matches the mathematics of section 4, and `Real.sqrt_le_sqrt` needs only the inner inequality, so no nonnegativity side condition is being smuggled. Confirmed.

### 5.2 `altConst_eq_altConstN_of_even` IS the prose claim

Typed: even $n\ge2$ implies equality. That is the block's "the same number at even $n$". Confirmed. The `2 ≤ n` hypothesis is stronger than the mathematics needs (at $n=0$ both sides are $0$ under Lean's $x/0=0$ and $\sqrt{\text{negative}}=0$), which is harmless.

### 5.3 `altConst_lt_altConstN_n9` IS the prose claim, at the one value the prose names

Typed: `altConst 4 < altConstN 9`, and $4=\lfloor9/2\rfloor$, so this is $\sqrt{1/4}<\sqrt{7/27}$. That is precisely "their strict separation at $n=9$", and block 2 does say "at $n=9$", so the prose about the Lean is accurate.

**One overclaim, in the module docstring rather than in the quoted blocks.** [L204AltBound.lean:18](../lean/HamiltonsCubic/Results/L204AltBound.lean#L18) says the $m$-form is at most the $n$-form "with equality exactly when `n` is even". The "exactly" has two halves and only one is typed: even implies equal is `altConst_eq_altConstN_of_even`, while odd implies strict is typed at $n=9$ alone. Section 4 proves the missing half by hand for every odd $n\ge3$, so the statement is true and the docstring is ahead of the file. Also stale: the same docstring calls the ruling `altBound_le_nBound`, an identifier that does not exist in the file. The theorem is `altConst_le_altConstN`.

### 5.4 `alt_le_altConst_trace` is NOT the prose bound, and as typed it is false

This is the material Lean finding. The typed statement is

```
theorem alt_le_altConst_trace {n : ℕ} (μ : Fin n → ℝ) (hμ : ∀ a, 0 ≤ μ a)
    (ω : Fin n → Matrix (Fin n) (Fin n) ℝ) (T : Fin n → Fin n → Fin n → Fin n → ℝ)
    (hT : T = fun i j k l => (1 / 6 : ℝ) *
      ∑ a, μ a * HamiltonsCubic.SelfDualLayer.wedgeSelf (ω a) i j k l) :
    Real.sqrt (tensorNormSq T) ≤ altConst (n / 2) * ∑ a, μ a
```

Three separate defects, in increasing order of seriousness.

**Wider than the prose in its index type, so it cannot be the prose claim.** A symmetric operator on $\Lambda^2\mathbb R^n$ has $\binom n2$ eigenpairs, and the eigenbasis of the prose is indexed by a set of that size. Here `μ` and `ω` are indexed by `Fin n`. At $n=4$ that is four eigenpairs where the operator has six. The statement therefore covers only the sub-family of operators expressible with at most $n$ terms, which is a different statement from the one the record makes, even before the next point.

**No hypothesis makes `ω a` a bivector.** `ω : Fin n → Matrix (Fin n) (Fin n) ℝ` is an arbitrary family of square matrices. There is no skew-symmetry hypothesis, no unit-norm hypothesis, and no orthogonality hypothesis. Section 1.2 shows that the unit-norm hypothesis is exactly what the first step of the proof consumes.

**Consequently the statement is false, which means the `sorry` is unclosable and not merely open.** The docstring at [L204AltBound.lean:92](../lean/HamiltonsCubic/Results/L204AltBound.lean#L92) says "what is owed is the maximisation", which would make this an honest gap. It is worse than that. `wedgeSelf` is homogeneous of degree $2$ in its matrix argument, for any faithful encoding of the record's $(\omega\wedge\omega)_{ijkl}=2(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$, and `tensorNormSq` is homogeneous of degree $2$ in `T`. So take $n=4$, $\mu=(1,0,0,0)$, and $\omega_0=s\,u_1$ with $u_1=(\varphi_{12}+\varphi_{34})/\sqrt2$ and $s>1$. The right-hand side is $\mathrm{altConst}(2)\cdot1=1/\sqrt6$, fixed. The left-hand side is $s^2/\sqrt6$, since at $s=1$ it equals $\tfrac16\sqrt6=1/\sqrt6$ by section 2. Any $s>1$ refutes the statement, and $s$ is unconstrained. **Per the brief I did not open `SelfDual.lean`, so this refutation is stated conditionally on `wedgeSelf` being homogeneous of positive degree in its argument and nonzero at $u_1$**, which any encoding of the brief's wedge formula satisfies.

The repair is mechanical and the mathematics is already done in sections 1 and 2: index by `Fin N` with `N = n.choose 2` or by an abstract `Fintype`, add skew-symmetry and an orthonormality hypothesis on `ω`, and add `2 ≤ n`. The statement then becomes the prose claim and the only genuine gap is the maximisation of section 2.4, which does need the canonical form and is indeed built nowhere in that layer.

## 6. Attack item 6: the equality condition, and the side-claim that no Weyl tensor attains the constant

### 6.1 The equality condition is correct, with two refinements

Equality in the chain of section 1.2 needs equality at both inequalities:

- **(E1)** every $\omega_\alpha$ with $\mu_\alpha>0$ is balanced, that is $a_i^2=1/m$ in its own canonical frame, so that $\lVert\omega_\alpha\wedge\omega_\alpha\rVert$ attains $\sqrt{12(m-1)/m}$. Eigenforms with $\mu_\alpha=0$ are unconstrained.
- **(E2)** the terms $\mu_\alpha\,\omega_\alpha\wedge\omega_\alpha$ with $\mu_\alpha>0$ lie on a single ray of $\Lambda^4$, because equality in the triangle inequality of a strictly convex norm requires nonnegative proportionality. Since (E1) makes them all of the same norm, they must all be **equal** to one four-form $\Omega$.

So the recorded condition, "every eigenform balanced and every $\omega_\alpha\wedge\omega_\alpha$ aligned in $\Lambda^4$", is the right condition. The two refinements are that it binds only the eigenforms with $\mu_\alpha>0$, and that "aligned" must mean the same ray and not merely parallel. An anti-aligned pair is the opposite of equality, and at $A=W^2$ that distinction is what separates the self-dual from the mixed case below.

### 6.2 The side-claim is REFUTED: a self-dual Weyl tensor in $\mathcal W_4$ attains the constant exactly

Take $n=4$, $m=2$, constant $\sqrt{1/6}=1/\sqrt6$. Set

$$v_1=\varphi_{12}+\varphi_{34},\qquad v_2=\varphi_{13}+\varphi_{42},\qquad v_3=\varphi_{14}+\varphi_{23},\qquad u_i=v_i/\sqrt2 .$$

The $\varphi$ are orthonormal and the three $v_i$ use disjoint pairs of them, so $\{u_1,u_2,u_3\}$ is orthonormal. Each is balanced, with $a_1^2=a_2^2=\tfrac12$. And by the component formula their wedge-selves coincide, all three being the four-form $\Omega$ with $\Omega_{1234}=1$:

- $\alpha\varphi_{12}+\beta\varphi_{34}$: $(\omega\wedge\omega)_{1234}=2\omega_{12}\omega_{34}=2\alpha\beta$.
- $\alpha\varphi_{13}+\beta\varphi_{42}$: $(\omega\wedge\omega)_{1234}=-2\omega_{13}\omega_{24}=-2(-\alpha)(\beta)=2\alpha\beta$.
- $\alpha\varphi_{14}+\beta\varphi_{23}$: $(\omega\wedge\omega)_{1234}=2\omega_{14}\omega_{23}=2\alpha\beta$.

At $\alpha=\beta=1/\sqrt2$ each gives $1$. So (E1) and (E2) hold on $V=\mathrm{span}(u_1,u_2,u_3)$ simultaneously, which is the whole point: this is a three-dimensional space of pairwise orthogonal balanced bivectors with one common wedge-self.

Now set $W=2\,u_1\otimes u_1-u_2\otimes u_2-u_3\otimes u_3$, a symmetric operator on $\Lambda^2\mathbb R^4$ with spectrum $(2,-1,-1,0,0,0)$.

- **Trace-free**: $2-1-1=0$.
- **First Bianchi**: $\mathrm{Alt}(W)=\tfrac16\sum_\alpha\lambda_\alpha\,u_\alpha\wedge u_\alpha=\tfrac16\bigl(\sum_\alpha\lambda_\alpha\bigr)\Omega=0$, because the three wedge-selves are the same $\Omega$ and the eigenvalues sum to zero. Screened: $\mathrm{Alt}(W)=0$ identically in exact rationals.
- **Ricci-flat**: $\mathrm{Ric}_{jl}=\sum_iW_{ijil}=0$, screened as the zero $4\times4$ matrix in exact rationals.

So $W\in\mathcal W_4$. Then $W^2=4\,u_1\otimes u_1+u_2\otimes u_2+u_3\otimes u_3$ is positive semidefinite with $\operatorname{tr}(W^2)=6=\lVert W\rVert^2$, and

$$\mathrm{Alt}(W^2)=\tfrac16\bigl(4+1+1\bigr)\Omega=\Omega,\qquad \lVert\mathrm{Alt}(W^2)\rVert^2=\tfrac14\cdot24\cdot1^2=6 ,$$

against the bound's $\bigl(\tfrac16\bigr)\bigl(\operatorname{tr}W^2\bigr)^2=\tfrac{36}{6}=6$. **Equality, exactly.** Screened in exact rationals: both sides $6$.

This refutes the record's side-claim that the constant is not attained by a Weyl tensor. The mechanism is that on a three-dimensional space of balanced bivectors with a common wedge-self, first Bianchi coincides with trace-freeness, so the constraint the record expected to obstruct equality is automatically satisfied rather than obstructive.

The same object attains the bound in $\mathcal W_5$, because $m=\lfloor5/2\rfloor=2$ leaves the constant at $1/\sqrt6$, and the padding of section 7 preserves first Bianchi, trace-freeness and Ricci-flatness while changing neither $\lVert W\rVert$ nor $\mathrm{Alt}(W^2)$.

### 6.3 What would have to hold at $n\ge6$, and where that is blocked

At $n\ge6$ the constant rises above $1/\sqrt6$, so the padded object no longer attains it and equality inside $\mathcal W_n$ would need a genuinely $n$-dimensional configuration. Naming what would have to hold, per the brief:

1. at least two orthogonal eigenforms of $W$ with nonzero eigenvalues, both balanced with $m=\lfloor n/2\rfloor$ blocks, hence both of full rank $2m$,
2. their wedge-selves **equal** to one common four-form $\Omega$ of norm $\sqrt{12(m-1)/m}$, by (E2),
3. eigenvalues summing to zero and Ricci vanishing.

Condition 3 costs nothing extra once 2 holds, by the $n=4$ mechanism: first Bianchi becomes $\tfrac16(\sum\lambda_\alpha)\Omega=0$, which trace-freeness already gives. So the whole question is whether 1 and 2 are jointly realisable at $m\ge3$.

One hand observation narrows it. Within a single fixed block frame, two balanced bivectors have coefficient patterns $a_i=\pm1/\sqrt m$, and their inner product is $\tfrac1m$ times a sum of $m$ terms $\pm1$. For $m$ odd that sum is odd and so never zero, so **at $m$ odd, in particular at $n=6$ and $n=7$, no two balanced bivectors sharing a block frame are orthogonal**, and any equality configuration would need eigenforms in genuinely different frames. Deciding realisability at $m\ge3$ needs either a construction or a nonexistence argument. **This item is computation-gated and I stop here under the analysis-only footing.** What a run would decide: whether the constant is attained inside $\mathcal W_n$ for some $n\ge6$. A positive outcome would make "sharp within $\mathcal W_n$" a theorem at that $n$. A negative outcome would leave the psd sharpness of section 8 as the only sharpness available and would mean the bound is strictly lossy on Weyl tensors above $n=5$, which is itself worth knowing because it would say the bound leaves headroom in the one place the programme uses it.

## 7. Attack item 9: the reach claimed for the route

The brief paraphrases the record as saying that an upper bound cannot close a vanishing statement, and that a lower bound at a failing $W$ is what would. I can judge the paraphrase and not the record's sentence, which I did not read.

**As an absolute the reading is wrong, because a norm upper bound is two-sided on the quadratic form.** Section 1.2 gives the conversion at no cost in this normalisation. $\mathrm{Alt}(W^2)$ is totally antisymmetric, hence pair-symmetric, hence a symmetric operator $\Theta$ on $\Lambda^2\mathbb R^n$, and the record's four-index norm of it equals its Frobenius norm as an operator. So

$$\bigl\lvert\langle\Theta x,x\rangle\bigr\rvert\ \le\ \max_\beta\lvert\nu_\beta\rvert\cdot\lVert x\rVert^2\ \le\ \lVert\Theta\rVert\,\lVert x\rVert^2 ,$$

and the bound feeds straight into $G_W$ as

$$\bigl\lvert12\,\langle\mathrm{Alt}(W^2)x,x\rangle\bigr\rvert\ \le\ 12\sqrt{\frac{m-1}{3m}}\,\lVert W\rVert^2\lVert x\rVert^2\ <\ 4\sqrt3\,\lVert W\rVert^2\lVert x\rVert^2\ =\ 6.9282\ldots\lVert W\rVert^2\lVert x\rVert^2 .$$

Because $+12\,\mathrm{Alt}(W^2)$ enters $G_W=4(\mathrm{Ric}(W^2)\wedge\mathrm{id})+12\,\mathrm{Alt}(W^2)-4W^2-4W^\#$ with a **positive** sign, an upper bound on it is exactly what an argument of the shape "exhibit $x$ with $\langle G_Wx,x\rangle\le0$, conclude $[\mathrm{ad}(x),W]=0$" needs. So an upper bound can close a vanishing statement, given matching estimates on the other three terms at the same $x$.

**What is defensible in the reading, stated positively.** A norm upper bound cannot prove $\mathrm{Alt}(W^2)=0$, since it bounds and does not locate. It also discards the $x$-dependence, so it is usable only where the other three terms of $G_W$ are estimated in norm at the same $x$, and it is the wrong tool where the argument needs the $\mathrm{Alt}$ term to be **large**, for instance to force $\langle G_Wx,x\rangle>0$ and conclude non-degeneracy. That last case is the one a lower bound serves. So the correct statement is that the direction required follows the sign the term carries in the inequality being closed, and for the $\le0$ direction in $G_W$ the upper bound is the right tool. The record's blanket version should be narrowed to the $>0$ case.

## 8. Attack items 7 and 8: the kernel, padding, sharpness, and vacuity

### 8.1 The kernel breaks nothing, and the bound is weaker at a padded object

Zero eigenvalues of $W$ give zero eigenvalues of $W^2$, and those terms vanish from both $\tfrac16\sum\mu_\alpha\,\omega_\alpha\wedge\omega_\alpha$ and from $\sum_\alpha\mu_\alpha$. Nothing in the chain touches them, and (E1) does not constrain them. So $\ker W\ne0$ is harmless here, which makes this one of the few statements in the programme that the recurring obstruction does not reach.

Padding is the interesting direction. Embed $W\in\mathcal W_{n_0}$ into $\mathbb R^n$ with $n>n_0$ by zero. Then $\lVert W\rVert$ and $\mathrm{Alt}(W^2)$ are literally unchanged as tensors, while $m=\lfloor n/2\rfloor$ grows, so the constant $\sqrt{(m-1)/(3m)}$ grows toward $1/\sqrt3$. **The bound is therefore weaker at a padded object**, and consistent, since the larger-$n$ statement must also hold for the padded tensor.

That points at a strengthening the record can have for free. The maximisation in section 2.4 only ever needs the maximum over the eigenforms that actually carry weight, and an $\omega_\alpha$ with $r_\alpha$ nonzero blocks satisfies $\lVert\omega_\alpha\wedge\omega_\alpha\rVert^2\le12(r_\alpha-1)/r_\alpha$ by the same simplex argument. So with $r=\max\{r_\alpha:\mu_\alpha>0\}\le m$,

$$\lVert\mathrm{Alt}(A)\rVert\ \le\ \sqrt{\frac{r-1}{3r}}\,\operatorname{tr}A ,$$

strictly better whenever $r<m$, and reducing to the recorded bound at $r=m$. The recorded statement is the weakest member of this family, which is the honest reading of "sharp": sharp over all psd $A$ at a given $n$, and improvable on any sub-family of bounded eigenform rank.

### 8.2 The constant is attained, at every $n\ge4$

Let $u=\tfrac1{\sqrt m}\sum_{i=1}^m\varphi_{2i-1,2i}$ and $A=u\otimes u$, a rank-one orthogonal projection and so positive semidefinite with $\operatorname{tr}A=1$. Then $\mathrm{Alt}(A)=\tfrac16\,u\wedge u$ and

$$\lVert\mathrm{Alt}(A)\rVert=\tfrac16\sqrt{\frac{12(m-1)}{m}}=\sqrt{\frac{m-1}{3m}}=\sqrt{\frac{m-1}{3m}}\operatorname{tr}A .$$

Equality. Screened in exact rationals at $n=4,5,6,8,9$, returning $1/6,1/6,2/9,1/4,1/4$ for $\lVert\mathrm{Alt}A\rVert^2$ against $(m-1)/(3m)$ in every case. **So no constant smaller than $\sqrt{(m-1)/(3m)}$ makes the statement true at that $n$**, and the record's word "sharp" is earned. This also upgrades the ruling of section 4: at odd $n$ the $m$-form is not merely smaller, it is optimal, so the $n$-form is provably non-optimal there rather than merely larger.

### 8.3 Where the bound is far from tight

Two families, both exact and both with ratio zero.

- $A=\mathrm{id}_{\Lambda^2\mathbb R^n}$: $\mathrm{Alt}(\mathrm{id})=\tfrac16\sum_{a<b}\varphi_{ab}\wedge\varphi_{ab}=0$, since each $\varphi_{ab}$ has a single block, while $\operatorname{tr}A=\binom n2$. The gap factor is unbounded in $n$.
- More generally $A=\sum_{a<b}\mu_{ab}\,\varphi_{ab}\otimes\varphi_{ab}$ with any $\mu_{ab}\ge0$: every eigenform has $r_\alpha=1$, so $\mathrm{Alt}(A)=0$ while $\operatorname{tr}A$ is arbitrary. Consistent with the refinement of section 8.1, which gives constant $0$ at $r=1$.

### 8.4 Vacuity, and what the trivial bound is

The trivial bound available from the norm alone is the one section 1.2 makes visible. $\mathrm{Alt}$ is the orthogonal projection onto the $\Lambda^4$ summand, so $\lVert\mathrm{Alt}(A)\rVert\le\lVert A\rVert=\sqrt{\operatorname{tr}(A^2)}=\sqrt{\sum_\alpha\mu_\alpha^2}\le\sum_\alpha\mu_\alpha=\operatorname{tr}A$ for psd $A$. **The bound would be vacuous if its constant were $\ge1$.** It is not: $\sqrt{(m-1)/(3m)}<1/\sqrt3=0.5774$ at every $n$, so the recorded bound strictly improves the trivial $\operatorname{tr}A$ form by a factor better than $\sqrt3$ at every dimension, and it does not degenerate as $n\to\infty$.

One honest qualification. The recorded bound does not dominate $\sqrt{\operatorname{tr}(A^2)}$ pointwise, because that quantity can be smaller than $\operatorname{tr}A$ by a factor up to $\sqrt{\binom n2}$. At $A=\mathrm{id}$ the recorded bound gives $0.577\binom n2$ against the trivial $\sqrt{\binom n2}$, and the trivial one wins. At the attaining objects of sections 6.2 and 8.2 the recorded bound wins and is exact: at the $n=4$ Weyl tensor it gives $\sqrt6=2.449$ against the trivial $\sqrt{\operatorname{tr}W^4}=\sqrt{18}=4.243$, and the true value is $\sqrt6$. So the precise claim to record is that the bound is the optimal member of the family $C\operatorname{tr}A$, which is exactly what section 8.2 establishes, and that it should be used alongside rather than instead of $\sqrt{\operatorname{tr}(A^2)}$.

## 9. Attack item 10: what would break each claim, and what I did to look

**The bound.** A falsifier is a positive semidefinite $A$ on $\Lambda^2\mathbb R^n$ with $\lVert\mathrm{Alt}(A)\rVert>\sqrt{(m-1)/(3m)}\operatorname{tr}A$. By sections 1 and 2, such an $A$ requires either given 1 to be wrong in its constant, or a unit bivector with $\lVert\omega\wedge\omega\rVert>\sqrt{12(m-1)/m}$. The first I screened independently in section 1.1 and it holds. The second is excluded by an identity and a Cauchy–Schwarz on the simplex, both exact and both covering all unit bivectors after the invariance step of section 2.3, so the falsifier cannot exist. **What I did to look: I re-derived both links from the definitions rather than searching, and the derivation is a proof, so there was nothing to search.** I screened the wedge maximum in exact rationals at $n=4,6,8,9$ and the whole bound at the attaining objects of sections 6.2 and 8.2, where it holds with equality and so is on the edge of falsification and did not cross it.

**The ruling.** A falsifier is an $n\ge2$ with $(m-1)/(3m)>(n-2)/(3n)$. Section 4 computes the difference exactly in both parity classes, obtaining $0$ at even $n$ and $-1/\bigl(k(6k+3)\bigr)$ at $n=2k+1$. The two classes are exhaustive, so there is no $n$ left to try. **What I did to look: exact algebra over both parity classes, which is exhaustive, plus an exact-rational table at $n=2$ through $n=13$ as a screen, with no reversal anywhere.**

**The Lean bound statement.** A falsifier is what section 5.4 exhibits, in closed form, by scaling one matrix argument. That one I did find.

## Verdict

**The mathematics of both quoted blocks is correct, the constant is optimal, and two attached claims are wrong.**

- **The bound is CONFIRMED** and every link of the written chain holds. Positivity and orthonormality are both load-bearing, and the composition is exact.
- **The constant is optimal**, which the record asserts and does not establish. A rank-one projection onto a balanced bivector attains it at every $n\ge4$.
- **The ruling is CONFIRMED**, with the sharper form of it available: at odd $n$ the $m$-form is not only strictly smaller, it is attained, so the $n$-form is provably non-optimal there.
- **Two claims fail.** The side-claim that no Weyl tensor attains the constant is **REFUTED**: a self-dual $W\in\mathcal W_4$, and the same object in $\mathcal W_5$, attain it exactly, and the mechanism is that first Bianchi coincides with trace-freeness on a space of balanced bivectors with a common wedge-self. The reading that an upper bound cannot close a vanishing statement is **REFUTED AS STATED**, because in this normalisation a norm bound converts to a two-sided bound on the quadratic form at no cost, and the $\mathrm{Alt}$ term carries a positive sign in $G_W$.
- **The Lean layer is two-thirds sound.** The three ordering theorems ARE the prose claims, build clean, and carry no gap. `alt_le_altConst_trace` is **REFUTED AS STATED**: it is false as typed rather than unproved, because nothing makes `ω` a family of unit bivectors, and its `Fin n` index cannot carry the $\binom n2$ eigenpairs the prose quantifies over. Its docstring therefore misdescribes its own gap. The module docstring also names a non-existent identifier and claims an "exactly when even" that is typed only in one direction.
- **Two presentation repairs.** The written derivation should state the $\tfrac14\cdot4!\cdot2^2$ count behind the $24$, and should state the $O(n)$-invariance that licenses the reduction to canonical form. Neither is a defect in the result.
- **One item is computation-gated and stops here**: whether the constant is attained inside $\mathcal W_n$ for any $n\ge6$. Section 6.3 names the three conditions and the $m$-odd obstruction to sharing a block frame.

*Screens run, all exact and all reported as screens: the wedge maximum from the record's own wedge and norm at $n=4,6,8,9$; the $\tfrac16$ of given 1 against the $\tfrac13$-cyclic $\mathrm{Alt}$; first Bianchi, Ricci-flatness and the equality at the $n=4$ self-dual Weyl tensor; the failure at a trace-free $A$; the rank-one attainer at $n=4,5,6,8,9$; the constant table at $n=2$ through $13$; and one `lake build` of the named module.*
