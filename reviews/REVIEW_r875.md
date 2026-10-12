# Review r875 on the sharp bound $\lVert\mathrm{Alt}(A)\rVert\le\sqrt{(m-1)/(3m)}\operatorname{tr}A$, the ruling between the $m$-form and the $n$-form, and [L204AltBound.lean](../lean/HamiltonsCubic/Results/L204AltBound.lean)

The brief was cold: this reviewer read the brief and [L204AltBound.lean](../lean/HamiltonsCubic/Results/L204AltBound.lean) and nothing else of the record. No numerical work was done beyond screening claims about to be recorded, in exact rational arithmetic on objects constructed for that purpose, and every value below is exact. Log: [agent_logs/review-r875-altbound.log](../agent_logs/review-r875-altbound.log).

## Claim table

| # | Claim as recorded | Verdict | Reason |
|---|---|---|---|
| 1 | $\lVert\mathrm{Alt}(A)\rVert\le\sqrt{(m-1)/(3m)}\operatorname{tr}A$ for PSD $A$, record's norm, $m=\lfloor n/2\rfloor$ | **CONFIRMED** | both steps re-derived, and the constant is attained, so it is sharp over PSD operators |
| 2 | Step one, the triangle inequality with $\operatorname{tr}A=\sum\mu_\alpha$ | **CONFIRMED** | positivity is exactly what converts $\sum_\alpha\lvert\mu_\alpha\rvert$ into $\operatorname{tr}A$ |
| 3 | The same step without positivity | **REFUTED AS STATED** | false, not merely unproved: a trace-free $A$ on $\Lambda^2\mathbb R^4$ has $\lVert\mathrm{Alt}(A)\rVert=\sqrt{2/3}>0$ |
| 4 | $\lVert\omega\wedge\omega\rVert^2=24\sum_{i<j}a_i^2a_j^2$ and $\max=\sqrt{12(m-1)/m}$ | **CONFIRMED** | $4!$ orderings per block pair, each of modulus $2a_ia_j$, times $\tfrac14$, gives $24$ |
| 5 | The maximiser is the balanced bivector $a_i^2=1/m$ | **CONFIRMED**, with a precision | unique in the $a_i^2$, a positive-dimensional family as bivectors (all signs, all frames) |
| 6 | $\tfrac16\sqrt{12(m-1)/m}=\sqrt{(m-1)/(3m)}$ | **CONFIRMED** | $12/36=1/3$, exact |
| 7 | The $m$-form is at most the $n$-form at every $n\ge2$, equality exactly at even $n$ | **CONFIRMED** | the inequality is $2\lfloor n/2\rfloor\le n$, an identity of the floor |
| 8 | At $n=9$ the values are $\tfrac12$ against $\sqrt{7/27}=0.509175$ | **CONFIRMED** | $1/4<7/27$ since $27<28$, and $n=5,7$ part likewise |
| 9 | The ordering never reverses, so the $n$-form is never sharper | **CONFIRMED** | no $n$ has $2\lfloor n/2\rfloor>n$, so no falsifier exists |
| 10 | Equality needs every eigenform balanced and every $\omega_\alpha\wedge\omega_\alpha$ aligned | **CONFIRMED AS ALGEBRA** | correct once restricted to $\mu_\alpha>0$: the null eigenforms are unconstrained |
| 11 | The constant is not attained by a Weyl tensor | **REFUTED** | the self-dual Weyl tensor of $\mathbb R^4$ attains it exactly, exhibited in closed form below |
| 12 | Lean: the three ordering theorems are the prose ruling, gap-free | **CONFIRMED** | each depends on `propext`, `Classical.choice`, `Quot.sound` only |
| 13 | Lean: `alt_le_altConst_trace` is the bound with the maximisation as its one gap | **REFUTED AS STATED** | the eigenbasis is indexed by `Fin n` rather than `Fin (n(n-1)/2)` and no hypothesis makes the `ω a` unit, so the typed statement is false and the `sorry` is unfillable |
| 14 | An upper bound cannot close a vanishing statement, a lower bound would | **REFUTED AS STATED** | $\mathrm{Alt}(W^2)$ enters $G_W\succeq0$ with a positive coefficient, so the upper bound is the usable direction and a norm lower bound is the useless one |

## One line to act on

The bound and the ruling stand as written and the bound is sharp, so fold both in. Withdraw the claim that no Weyl tensor attains the constant, because the self-dual Weyl tensor of $\mathbb R^4$ does, and re-state the Lean bound with the eigenbasis indexed by $\Lambda^2$ and with the eigenforms hypothesised orthonormal before anyone attempts the `sorry`.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector, the inner product being $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- The norm on a four-index tensor is the record's: $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$.
- The wedge is $(\omega\wedge\eta)_{ijkl}=\omega_{ij}\eta_{kl}-\omega_{ik}\eta_{jl}+\omega_{il}\eta_{jk}+\omega_{jk}\eta_{il}-\omega_{jl}\eta_{ik}+\omega_{kl}\eta_{ij}$, so $(\omega\wedge\omega)_{ijkl}=2(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$, twice the Pfaffian.
- $\mathcal W_n$ is the space of algebraic Weyl tensors: symmetric operators on $\Lambda^2\mathbb R^n$, first Bianchi, Ricci-flat, trace-free, with $\lVert W\rVert^2=\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)$.

## Hypothesis inventory

| Hypothesis | Where it is used | Does it hold at the object |
|---|---|---|
| $A$ symmetric on $\Lambda^2\mathbb R^n$ | supplies the orthonormal eigenbasis that given 1 is stated over | yes at $A=W^2$, since $W$ is symmetric |
| $A$ positive semidefinite | converts $\sum_\alpha\lvert\mu_\alpha\rvert$ into $\operatorname{tr}A$, and nowhere else | yes at $A=W^2$, whose eigenvalues are $\lambda_\alpha^2\ge0$ |
| $\lVert\omega_\alpha\rVert=1$ | lets $\lVert\omega_\alpha\wedge\omega_\alpha\rVert$ be compared with the maximum over the UNIT sphere | yes, the eigenbasis is orthonormal |
| Canonical form with $m=\lfloor n/2\rfloor$ blocks (given 3) | reduces the maximisation to the simplex | yes, per eigenform, each in its own frame |
| $O(n)$-invariance of the record's four-index norm | lets the per-eigenform frames differ, which the written argument does not mention | yes, the wedge is equivariant and the norm is a frame-independent sum of squares |
| $n\ge2$ | at $m=1$ the constant is $0$ | consistent: $\Lambda^4\mathbb R^2=\Lambda^4\mathbb R^3=0$, so $\mathrm{Alt}\equiv0$ there and the $m$-form is exact while the $n$-form gives $1/9>0$ at $n=3$ |
| First Bianchi $\mathrm{Alt}(W)=0$ | never used | the bound is a statement about PSD operators and sees no Weyl structure, which is section 6's point |
| Ricci-flat, trace-free | never used in the bound | idem |

## 1. The triangle-inequality step, and what positivity is doing

Given 1 reads $\mathrm{Alt}(A)=\tfrac16\sum_\alpha\mu_\alpha\,\omega_\alpha\wedge\omega_\alpha$ over an orthonormal eigenbasis. The triangle inequality in the record's norm gives

$$\lVert\mathrm{Alt}(A)\rVert\ \le\ \tfrac16\sum_\alpha\lvert\mu_\alpha\rvert\,\lVert\omega_\alpha\wedge\omega_\alpha\rVert\ \le\ \tfrac16\Big(\max_{\lVert\omega\rVert=1}\lVert\omega\wedge\omega\rVert\Big)\sum_\alpha\lvert\mu_\alpha\rvert .$$

Each $\omega_\alpha$ is a unit bivector, so the second inequality is exactly the maximisation over the unit sphere and needs nothing further. Positivity of $A$ enters at one place only, in the last factor: $\sum_\alpha\lvert\mu_\alpha\rvert=\sum_\alpha\mu_\alpha=\operatorname{tr}A$. So $\operatorname{tr}A$ is the right factor, and the general statement the argument proves is the trace-norm statement $\lVert\mathrm{Alt}(A)\rVert\le\sqrt{(m-1)/(3m)}\sum_\alpha\lvert\mu_\alpha\rvert$ for every symmetric $A$, of which the recorded bound is the positive case.

**Without positivity the recorded step is false, not merely unproved.** Work in $\mathbb R^4$ and put $\omega_1=(\varphi_{12}+\varphi_{34})/\sqrt2$ and $\omega_2=(\varphi_{12}-\varphi_{34})/\sqrt2$, an orthonormal pair. Both are balanced, and their wedges are opposite: with $(\omega\wedge\omega)_{1234}=2\omega_{12}\omega_{34}$ and $(\varphi_{ab})_{ab}=-1$, the first gives $+1$ and the second $-1$. Take

$$A=\omega_1\otimes\omega_1-\omega_2\otimes\omega_2,\qquad \operatorname{tr}A=0,$$

a symmetric operator on $\Lambda^2\mathbb R^4$. Then $\mathrm{Alt}(A)=\tfrac16(\omega_1\wedge\omega_1-\omega_2\wedge\omega_2)=\tfrac13\,\omega_1\wedge\omega_1$, whose norm is $\tfrac13\sqrt6=\sqrt{2/3}=0.816497$, against a right-hand side of $0$. Screened exact: the Bianchi antisymmetriser of this $A$ returns $\tfrac13\,\omega_1\wedge\omega_1$ and $\lVert\mathrm{Alt}(A)\rVert^2=2/3$ as rationals. So positivity is load-bearing and cannot be relaxed to trace-free, which matters because $W$ itself is trace-free while $W^2$ is the object the bound is applied to.

## 2. The maximisation, which is the crux

Write $\omega=\sum_{i\le m}a_i\varphi_{p_iq_i}$ in the canonical form of given 3, with $(p_i,q_i)=(2i-1,2i)$ and $\sum_ia_i^2=\lVert\omega\rVert^2=1$. Put $T=\omega\wedge\omega$, so $T_{ijkl}=2(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$. The three terms are the three pairings of $\{i,j,k,l\}$, with coefficients $+1,-1,+1$, all of modulus one.

A factor $\omega_{ij}$ is nonzero only when $\{i,j\}$ is one of the $m$ blocks, so a term survives only when its pairing splits the four indices into two blocks. Case by case:

- **Four indices from two distinct blocks $r\ne s$.** Exactly one of the three pairings is $\{\text{block }r,\text{block }s\}$, the other two pair an index of $r$ with an index of $s$ and vanish. The surviving term has modulus $2\lvert a_ra_s\rvert$. There are $4!=24$ orderings of the four distinct indices, each giving one such component.
- **Four indices inside one block**, necessarily with repeats, for instance $T_{pqpq}=2(\omega_{pq}\omega_{pq}-\omega_{pp}\omega_{qq}+\omega_{pq}\omega_{qp})=2(\omega_{pq}^2-0-\omega_{pq}^2)=0$.
- **Indices drawn from three or more blocks, or repeating across blocks.** No pairing is a pair of blocks, so all three terms vanish.

Hence

$$\sum_{ijkl}T_{ijkl}^2=\sum_{r<s}4!\,(2a_ra_s)^2=96\sum_{r<s}a_r^2a_s^2,\qquad \lVert T\rVert^2=\tfrac14\cdot96\sum_{r<s}a_r^2a_s^2=24\sum_{r<s}a_r^2a_s^2,$$

which is the recorded identity, and the factor $24=4!\cdot2^2/4$ is exactly the $4!$ signed orderings against the $\tfrac14$ of the norm. The recorded prose states the $\binom m2$ pairs and the value $2a_ia_j$ and then the $24$ without the $4!\cdot4/4$ arithmetic, so the step is right and its stated reason is one line short.

On the simplex $x_i=a_i^2\ge0$, $\sum x_i=1$, one has $\sum_{i<j}x_ix_j=\tfrac12(1-\sum_ix_i^2)$, maximal exactly when $\sum x_i^2$ is minimal, which by strict convexity happens only at $x_i=1/m$, value $\tfrac12(1-1/m)=(m-1)/(2m)$. Therefore

$$\max_{\lVert\omega\rVert=1}\lVert\omega\wedge\omega\rVert^2=24\cdot\frac{m-1}{2m}=\frac{12(m-1)}{m},$$

confirming $\sqrt{12(m-1)/m}$ and the recorded screen $\sqrt6=2.449490$, $\sqrt8=2.828427$, $3$, $3$ at $n=4,6,8,9$.

**On uniqueness**, the recorded wording overstates slightly. The maximiser is unique in the squares $a_i^2=1/m$, so it is unique as a point of the simplex, but as a bivector the maximisers form a positive-dimensional family: all sign choices $a_i=\pm1/\sqrt m$ and all frames. At $n=4$ they are precisely the unit self-dual and unit anti-self-dual bivectors, a pair of $2$-spheres, and that abundance is what section 6 turns on. The maximisation is also carried out in one fixed frame, which is legitimate because both $\lVert\omega\rVert$ and $\lVert\omega\wedge\omega\rVert$ are $O(n)$-invariant. The written argument uses that invariance without saying so.

## 3. The composition

$$\tfrac16\sqrt{\frac{12(m-1)}{m}}=\sqrt{\frac{12(m-1)}{36m}}=\sqrt{\frac{m-1}{3m}}.$$

Exact, since $12/36=1/3$. Confirmed.

## 4. The ruling, in exact arithmetic

With $m=\lfloor n/2\rfloor$ and $n\ge2$,

$$\frac{m-1}{3m}\le\frac{n-2}{3n}\iff 1-\frac1m\le1-\frac2n\iff\frac2n\le\frac1m\iff 2m\le n,$$

and $2\lfloor n/2\rfloor\le n$ holds for every $n$, with equality exactly when $n$ is even. So the ordering and the equality case are both right, and the recorded mechanism, that an odd dimension supplies no extra block, is the correct reason. The odd cases, exact:

| $n$ | $m$ | $m$-form squared | $m$-form | $n$-form squared | $n$-form |
|---|---|---|---|---|---|
| 3 | 1 | $0$ | $0$ | $1/9$ | $0.333333$ |
| 5 | 2 | $1/6$ | $0.408248$ | $1/5$ | $0.447214$ |
| 7 | 3 | $2/9$ | $0.471405$ | $5/21$ | $0.487950$ |
| 9 | 4 | $1/4$ | $0.5$ | $7/27$ | $0.509175$ |

At $n=9$ the claim $\tfrac12$ against $\sqrt{7/27}=0.509175$ is right, the separation being $1/4<7/27$ because $27<28$. The $n=3$ row is worth keeping: every bivector of $\mathbb R^3$ is simple and $\Lambda^4\mathbb R^3=0$, so the sharp constant there is $0$, which the $m$-form gives and the $n$-form does not. That is independent evidence for the ruling beyond the even-$n$ agreement.

## 5. Can the $n$-form ever be sharper

No, and the reason is not an inequality that might fail at large $n$ but the definition of the floor. A reversal needs $2\lfloor n/2\rfloor>n$, which no integer admits. There is therefore no falsifier to look for, and none was looked for. What remains true is a weaker reading worth stating positively: the $n$-form is a valid upper bound at every $n$, since it is never smaller than the $m$-form, and it is exact only at even $n$.

## 6. Equality, and the constant IS attained by a Weyl tensor

**The equality condition.** Tracing the two inequalities of section 1, equality holds if and only if

1. for every $\alpha$ with $\mu_\alpha>0$, the eigenform $\omega_\alpha$ is balanced, meaning all $m$ block coefficients of its canonical form have modulus $1/\sqrt m$, and
2. the tensors $\{\omega_\alpha\wedge\omega_\alpha:\mu_\alpha>0\}$ are all positive multiples of one common $\Omega\in\Lambda^4$, so that the triangle inequality is tight.

The recorded phrasing says "every eigenform", which is one word too strong: eigenforms with $\mu_\alpha=0$ contribute to neither side and are unconstrained. With that correction the condition is right.

**It is reachable inside $\mathcal W_4$.** Take the orthonormal self-dual triple in $\Lambda^2\mathbb R^4$,

$$s_1=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34}),\quad s_2=\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24}),\quad s_3=\tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23}),$$

for which $(s_a\wedge s_a)_{1234}=1$ for all three, so $s_1\wedge s_1=s_2\wedge s_2=s_3\wedge s_3=\Omega$ with $\lVert\Omega\rVert=\sqrt6$: each $s_a$ is balanced and the three wedges are not merely parallel but equal. The anti-self-dual triple gives $-\Omega$ three times, so $\sum_\alpha\omega_\alpha\wedge\omega_\alpha=0$ over the full basis, which is the consistency check that $\mathrm{Alt}(\mathrm{id})=0$, as first Bianchi for constant curvature requires. Now set

$$W=2\,s_1\otimes s_1-s_2\otimes s_2-s_3\otimes s_3,$$

zero on $\Lambda^-$. Every condition of $\mathcal W_4$ holds, screened in exact rational arithmetic through $R_{ijkl}=\langle W\varphi_{ij},\varphi_{kl}\rangle$:

- pair symmetry $R_{ijkl}=R_{klij}$, defect $0$;
- first Bianchi, $\max_{ijkl}\lvert R_{ijkl}+R_{iklj}+R_{iljk}\rvert=0$, equivalently $\mathrm{Alt}(W)=\tfrac16(2-1-1)\Omega=0$ because $W$ is trace-free on $\Lambda^+$;
- Ricci-flat, $\max_{ik}\lvert\sum_jR_{ijkj}\rvert=0$;
- trace-free, $\operatorname{tr}W=2-1-1=0$;
- $\lVert W\rVert^2=\operatorname{tr}(W^2)=6$ both as $\sum_\alpha\lambda_\alpha^2$ and as $\tfrac14\sum R_{ijkl}^2$, which also checks that the operator-to-tensor identification respects the record's norm.

Then $W^2=4\,s_1\otimes s_1+s_2\otimes s_2+s_3\otimes s_3$ is PSD with $\operatorname{tr}W^2=6$ and all three nonzero eigenforms balanced and wedge-aligned, so

$$\mathrm{Alt}(W^2)=\tfrac16(4+1+1)\,\Omega=\Omega,\qquad \lVert\mathrm{Alt}(W^2)\rVert=\sqrt6,$$

against the bound $\sqrt{(m-1)/(3m)}\operatorname{tr}W^2=\tfrac1{\sqrt6}\cdot6=\sqrt6$ at $m=2$. **Equality, exactly.** Screened as rationals: $\lVert\mathrm{Alt}(W^2)\rVert^2=6=\tfrac16(\operatorname{tr}W^2)^2$.

So the claim that no Weyl tensor attains the constant is refuted at the first dimension where $\Lambda^4\ne0$, and any scalar multiple of $W$, and every self-dual or anti-self-dual algebraic Weyl tensor of $\mathbb R^4$ whose $\Lambda^\mp$ block vanishes, does the same. The structural reason the obstruction fails: none of first Bianchi, Ricci-flatness or trace-freeness enters the derivation, and the one condition that could have fought the equality, $\mathrm{Alt}(W)=\tfrac16\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$, becomes $\big(\sum_{\lambda_\alpha\ne0}\lambda_\alpha\big)\Omega=0$ once all the wedges coincide, and that is implied by trace-freeness rather than opposed to it. Bianchi and balance point the same way here, not against each other.

**What would have to hold for $n\ge6$.** An orthonormal family in $\Lambda^2\mathbb R^n$ of balanced bivectors with a common wedge direction $\Omega$, large enough to carry a trace-free Ricci-flat Bianchi operator. At $n=4$ such a family exists in abundance because the balanced aligned unit bivectors are a whole $2$-sphere. Whether one exists at $n=6$ or beyond is not settled here: deciding it is a search, and this reviewer is on the analysis-only footing without approval for one. The $n=4$ case is enough to withdraw the claim as stated.

## 7. The kernel

Nothing above breaks at $\ker W\ne0$. The derivation needs $\mu_\alpha\ge0$ and no more, and an eigenvalue $\lambda_\alpha=0$ of $W$ gives $\mu_\alpha=0$ in $W^2$, contributing to neither $\mathrm{Alt}(W^2)$ nor $\operatorname{tr}W^2$. The section 6 witness makes the point sharply: it has a three-dimensional kernel on $\Lambda^2\mathbb R^4$, namely all of $\Lambda^-$, and attains equality. The recurring kernel obstruction does not bite on this bound.

**At a padded object the bound is strictly weaker.** If $W$ lives on $\mathbb R^{n'}\subset\mathbb R^n$ and vanishes elsewhere, both $\lVert\mathrm{Alt}(W^2)\rVert$ and $\operatorname{tr}W^2$ are unchanged while $m=\lfloor n/2\rfloor$ grows, so the constant rises and the slack opens. The section 6 witness padded into $\mathbb R^8$ has $\lVert\mathrm{Alt}(W^2)\rVert=\sqrt6=2.449490$ against a bound of $\sqrt{3/12}\cdot6=3$. So the constant is attained only by objects whose nonzero eigenforms occupy all $\lfloor n/2\rfloor$ blocks, which is the correct statement of what the $m$-dependence measures.

## 8. Vacuity, triviality, and where the bound is beaten

**Attained.** Two witnesses. The rank-one PSD operator $A=\omega\otimes\omega$ at a balanced $\omega$ has $\operatorname{tr}A=1$ and $\lVert\mathrm{Alt}(A)\rVert=\tfrac16\sqrt{12(m-1)/m}=\sqrt{(m-1)/(3m)}$, so the constant is exactly the supremum of $\lVert\mathrm{Alt}(A)\rVert/\operatorname{tr}A$ over PSD $A$ at every $n\ge2$, and the bound is sharp as an inequality about PSD operators. Inside $\mathcal W_n$ it is attained at $n=4$ by section 6.

**Far from tight.** The identity $A=\mathrm{id}$ on $\Lambda^2\mathbb R^n$ is PSD with $\operatorname{tr}A=n(n-1)/2$, and $\mathrm{Alt}(\mathrm{id})=0$ because constant curvature satisfies first Bianchi, checked above in two different orthonormal bases. So the bound gives $\sqrt{(m-1)/(3m)}\,n(n-1)/2$ against a true value of $0$: the slack is the whole bound. A rank-one $A=\omega\otimes\omega$ at a simple $\omega$ is a second such case, $\mathrm{Alt}(A)=0$ against a positive bound.

**The trivial bound available from the norm alone.** $\mathrm{Alt}$ is the orthogonal projection onto $\Lambda^4$ in the record's norm, so $\lVert\mathrm{Alt}(A)\rVert\le\lVert A\rVert=\sqrt{\operatorname{tr}(A^2)}$ with constant one. Screened exact at $A=s_1\otimes s_1$: writing $b(A)_{ijkl}=A_{ijkl}+A_{iklj}+A_{iljk}$, one gets $\mathrm{Alt}(A)=\tfrac13b(A)$, $\tfrac13b$ is idempotent, $b(A-\mathrm{Alt}(A))=0$, and $\lVert\mathrm{Alt}(A)\rVert^2+\lVert A-\mathrm{Alt}(A)\rVert^2=\tfrac16+\tfrac56=1=\lVert A\rVert^2$. Two things follow. First, this is an independent screen of given 1's constant: $\tfrac16$ is exactly the normalisation under which $\mathrm{Alt}$ is the projection, and the withdrawn $\tfrac13$ would make it non-idempotent, so the withdrawal was right and the whole bound, which scales linearly with that constant, rests on the confirmed value. Second, the comparison is genuine, not vacuous either way:

- for PSD $A$ of rank $r$ with flat spectrum, the recorded bound reads $c\,r\mu$ and the projection bound $\sqrt r\,\mu$ at $c=\sqrt{(m-1)/(3m)}$, so the projection bound is the stronger one exactly when $r>1/c^2=3m/(m-1)$;
- at $m=2$ that threshold is $6=\dim\Lambda^2\mathbb R^4$, so at $n=4$ the recorded bound is never worse, tying only at the identity where both are slack;
- at $n=6$, $m=3$, the threshold is $4.5$, and at $A=\mathrm{id}$ the recorded bound gives $\sqrt{2/9}\cdot15=7.071068$ against the projection bound's $\sqrt{15}=3.872983$.

So $\sqrt{(m-1)/(3m)}$ is the sharp constant in the family "$\text{const}\times\operatorname{tr}A$", which is the family the application wants, and it is superseded by $\sqrt{\operatorname{tr}(A^2)}$ whenever the spectrum is spread. Both should be on the record, not one.

## 9. The reach claimed for the route

The recorded reading is the wrong way round. In $G_W=4(\mathrm{Ric}(W^2)\wedge\mathrm{id})+12\,\mathrm{Alt}(W^2)-4W^2-4W^\#$ the term $\mathrm{Alt}(W^2)$ carries a POSITIVE coefficient, and $G_W\succeq0$ is already established as a sum of squares, $\langle G_Wx,x\rangle=\lVert[\mathrm{ad}(x),W]\rVert^2$. Nothing is gained by making $G_W$ more positive, so a lower bound on the $\Lambda^4$ term is the estimate with no consumer. An upper bound is the one that pays: for every $x$,

$$0\le\langle G_Wx,x\rangle\le4\langle(\mathrm{Ric}(W^2)\wedge\mathrm{id})x,x\rangle+12\kappa\lVert\mathrm{Alt}(W^2)\rVert\lVert x\rVert^2-4\langle(W^2+W^\#)x,x\rangle,$$

which at a critical point, where $W^2+W^\#=\theta W$, becomes a usable constraint $4\langle(\mathrm{Ric}(W^2)\wedge\mathrm{id})x,x\rangle-4\theta\langle Wx,x\rangle\ge-12\kappa\lVert\mathrm{Alt}(W^2)\rVert\lVert x\rVert^2$. The upper bound is exactly what forces the remaining terms to be large, and that is how positivity is made to say something. The deeper reason a lower bound cannot do the same work: a norm bound controls only $\lvert\langle\mathrm{Alt}(W^2)x,x\rangle\rvert$, so it can cap a contribution and can never supply a sign, in either direction.

**One constant is owed.** The $\kappa$ above is a conversion from the record's four-index norm $\tfrac14\sum T^2$ on $\Lambda^4$ to the quadratic form of the corresponding operator on $\Lambda^2$, and neither quoted block supplies it. Until $\kappa$ is written down, the bound is an estimate on a tensor and not yet an estimate on the term of $G_W$. That is a gap in the route rather than in the bound.

## 10. What would break each claim, and what was done to look for it

| Claim | The falsifier | What was done |
|---|---|---|
| The bound | a PSD $A$ with $\lVert\mathrm{Alt}(A)\rVert>\sqrt{(m-1)/(3m)}\operatorname{tr}A$ | none can exist: the two steps were re-derived from given 1 and the maximisation is exact on the simplex. The only remaining dependence is given 1's constant $\tfrac16$, which section 8 screened independently through the idempotence of $\tfrac13b$ |
| The maximisation | a unit $\omega$ with $\lVert\omega\wedge\omega\rVert^2>12(m-1)/m$ | none can exist: the component count is exhaustive over the three index cases and the simplex maximum is strict |
| The ruling | an $n$ with $2\lfloor n/2\rfloor>n$ | none exists by definition of the floor, so no search was run |
| "Not attained in $\mathcal W_n$" | a Weyl tensor attaining equality | found, in closed form, at $n=4$, with every condition of $\mathcal W_4$ verified in exact rational arithmetic |
| The Lean bound | a family $(\mu,\omega)$ satisfying the typed hypotheses and violating the typed conclusion | found by scaling: see section 11 |

## 11. The Lean file, statement by statement

Build: `lake build HamiltonsCubic.Results.L204AltBound` completes, with one advertised warning, `declaration uses 'sorry'` at line 95. Axioms, read off with `#print axioms`:

| Declaration | Axioms | Is it the prose claim |
|---|---|---|
| `altConst_le_altConstN` | `propext`, `Classical.choice`, `Quot.sound` | YES. At every `n ≥ 2`, `altConst (n / 2) ≤ altConstN n` with `n / 2` the natural-number division, which is $\lfloor n/2\rfloor$ |
| `altConst_eq_altConstN_of_even` | the same three | YES, equality at even $n\ge2$ |
| `altConst_lt_altConstN_n9` | the same three | Essentially yes, stated as `altConst 4 < altConstN 9`. It is the $n=9$ instance only because $9/2=4$ in $\mathbb N$, which the reader supplies, and `altConst (9 / 2) < altConstN 9` would say it without that step |
| `alt_le_altConst_trace` | the same three plus `sorryAx` | NO. See below |

`tensorNormSq` is $\tfrac14\sum_{ijkl}T_{ijkl}^2$, the record's norm, and `altConst`, `altConstN` are the two constants. So the ruling is machine-checked as an ordering, gap-free, exactly as claimed.

**`alt_le_altConst_trace` is a different statement, and it is false.** Its signature is

```
∀ {n : ℕ} (μ : Fin n → ℝ), (∀ a, 0 ≤ μ a) →
  ∀ (ω : Fin n → Matrix (Fin n) (Fin n) ℝ) (T : ...),
    (T = fun i j k l => 1 / 6 * ∑ a, μ a * wedgeSelf (ω a) i j k l) →
      √(tensorNormSq T) ≤ altConst (n / 2) * ∑ a, μ a
```

Two defects, the first of them independent of anything outside the file:

1. **The eigenbasis is indexed by `Fin n`.** A symmetric operator on $\Lambda^2\mathbb R^n$ has an eigenbasis of $n(n-1)/2$ members, so `∑ a : Fin n, μ a` is not $\operatorname{tr}A$ and the sum over `a` is not the sum of given 1. At $n=4$ the statement sees four of the six eigenforms. The typed object is therefore neither the prose claim nor a special case of it.
2. **Nothing constrains `ω`.** There is no hypothesis that `ω a` is skew, that it is a unit bivector, or that the family is orthonormal. Since `wedgeSelf` is quadratic in its argument, replacing `ω 0` by `c • ω 0` multiplies the left-hand side by $c^2$ and leaves the right-hand side fixed, so the statement asserts a bound uniform over all matrices and fails for large $c$. Concretely, with $n=4$, $\mu=(1,0,0,0)$ and $\omega_0=c\,s_1$, the left-hand side is $c^2\sqrt6/6$ and the right-hand side is $\sqrt{1/6}$, so it breaks at any $c>1$. This reading assumes `wedgeSelf M` is the record's $M\wedge M$, which is what the file's own docstring asserts. The argument is unchanged for any nonzero quadratic wedge, and the alternative, that `wedgeSelf` normalises its argument, would contradict the identity the docstring states.

So the `sorry` at line 95 is not a gap that the maximisation would close. The maximisation is genuinely what the true statement needs, and it is what this review derived in section 2, but the statement must first be re-typed with the eigenbasis indexed by a basis of $\Lambda^2\mathbb R^n$ and with the `ω a` hypothesised orthonormal unit bivectors. Two smaller notes: the module docstring calls the ruling `altBound_le_nBound`, a name that does not occur in the file, and the file's prose "attained at the balanced bivector" inherits the uniqueness overstatement of section 2.

## Verdict

The mathematics of the recorded block holds. The bound $\lVert\mathrm{Alt}(A)\rVert\le\sqrt{(m-1)/(3m)}\operatorname{tr}A$ is correct for positive semidefinite $A$ in the record's norm, both of its steps survive being re-derived, and it is sharp: the supremum of $\lVert\mathrm{Alt}(A)\rVert/\operatorname{tr}A$ over PSD $A$ equals that constant at every $n\ge2$. The ruling holds for the stated reason, the inequality being $2\lfloor n/2\rfloor\le n$ with equality exactly at even $n$, and it cannot reverse. Positivity is the one hypothesis that cannot be weakened, since the same statement with $\operatorname{tr}A$ is false at trace-free $A$.

Three things must change. The claim that no Weyl tensor attains the constant is refuted by the self-dual Weyl tensor of $\mathbb R^4$, which attains it exactly, so the constant is sharp inside $\mathcal W_4$ and no improvement of it can come from the Weyl conditions at $n=4$. The claim that only a lower bound could serve the $G_W$ route is backwards: the upper bound is the direction positivity can consume, and what is actually owed is the constant converting the four-index norm into a quadratic form on $\Lambda^2$. And `alt_le_altConst_trace` states something other than the bound, with an eigenbasis of the wrong size and no hypothesis on its bivectors, so its `sorry` is unfillable as typed.
