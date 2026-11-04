# Reviewer 93, the moduli count, Huisken's Lemma 3.5, fence post F2, and the four closures

**No numerical checking was used.** Every computation below is exact: `fractions.Fraction` and `sympy` `Rational`/symbolic arithmetic, exact matrix ranks over $\mathbb Q$, and one Gröbner elimination over $\mathbb Q$. No floating point, no sampling, no solvers. All comparisons of algebraic numbers were made by exact `sympy` sign tests.

Worked cold: the moduli algebra, the $n=4$ normal form, the sphere-product and $\mathbb{CP}^m$ values and the global $n=4$ maximisation were derived from [huisken-jdg-1985.txt](https://projecteuclid.org/journals/journal-of-differential-geometry/volume-21/issue-1/Ricci-deformation-of-the-metric-on-a-Riemannian-manifold/10.4310/jdg/1214439463.pdf) and [xu-2412.13633.txt](https://arxiv.org/abs/2412.13633) before [fence-posts.md](../findings/fence-posts.md), [notes.md](../references/huisken-1985-ricci-deformation/notes.md) or [ATTEMPTS.md](../ATTEMPTS.md) were opened.

---

## Verdicts at a glance

| # | Claim | Verdict |
|---|---|---|
| 1a | $\dim\mathrm{Weyl}_n=n(n-3)(n+1)(n+2)/12$ | **CONFIRMED** |
| 1b | Generic $O(n)$-moduli $=\dim\mathrm{Weyl}_n-\dim O(n)=n^2(n^2-13)/12$; $4,25,69,272,1572$ | **CONFIRMED** (generic stabiliser is $0$-dimensional, proved, not assumed) |
| 1c | The generic count misleads at the maximisers because their orbits are small | **REFUTED**, the orbits *are* small (exact dimensions below), but the invariant count near them is unchanged; the slice grows, not shrinks |
| 1d | "Alignment IS these moduli, so a spectral bound cannot suffice" | **REFUTED as stated.** At $n=4$, $P=3\mathop{\mathrm{tr}}(W^3)$ *identically*, so $P$ is a spectral function there and the spectral bound is an identity. For $n\ge5$ the right proof is an isospectral pair, exhibited below |
| 2 | Huisken's mechanism is the $n=4$ normal form + Lagrange enumeration, with the displayed $8P$ | **CONFIRMED**, and the sharp constant re-proved independently. But [notes.md](../references/huisken-1985-ricci-deformation/notes.md) misquotes both $P$ and the constant |
| 2b | "...and *not* because $\mathfrak{so}(4)$ is the unique semisimple non-simple case" | **REFUTED as a dichotomy**, the normal form exists *because* of that exceptional splitting |
| 3 | $B_\#/\theta_0=\frac{n(n-3)}{(n-1)(n-2)}$ and $\mathop{\mathrm{tr}}(W^3)/P=\frac2{(n-1)(n-2)}$ at $S^{n/2}\times S^{n/2}$ | **CONFIRMED** exactly at $n=4,6,8,10,12,14$ |
| 3b | "any term-by-term route overshoots by $\ge1.29\times$ **unconditionally**" | **REFUTED.** The exact floor on $n\ge12$ is $1+\frac{\sqrt3}6=1.2886\ldots$, decreasing to it from $f(12)=\frac{54}{55}+\frac{\sqrt{330}}{55}$; the ratio drops below $\frac{129}{100}$ at $n=324$ |
| 4 | The whole-$\langle Q(W),W\rangle$ route owes $\Theta(n)$, exactly $\sqrt{n(n+1)/2}$ | **CONFIRMED** |
| 5 | The four route closures | Two sound, one overstated, one closed on a reason the record itself has retracted |

---

## 1. The moduli count, the arithmetic is right, the inference is not

### 1a, 1b: the counts, and the stabiliser assumption discharged

$\dim\mathrm{Weyl}_n=\frac{n^2(n^2-1)}{12}-\frac{n(n+1)}2=\frac{n(n+1)\left(n^2-n-6\right)}{12}=\frac{n(n+1)(n+2)(n-3)}{12}$, and

$$\frac{n(n+1)(n+2)(n-3)}{12}-\frac{n(n-1)}2=\frac{n\left(n^3-7n-6-6n+6\right)}{12}=\frac{n^2(n^2-13)}{12},$$

giving $4,25,69,272,1572$ at $n=4,5,6,8,12$. **CONFIRMED.**

The step the post asserts silently is that the generic orbit is full-dimensional. It is, and it can be *proved* rather than assumed: $\dim\mathrm{Stab}$ is upper semicontinuous, so one explicit witness with $0$-dimensional stabiliser forces the generic value to be $0$. I built the hollow-row-sum-zero "diagonal" Weyl tensor with fixed rational weights and computed the rank of $X\mapsto X\cdot W$ on $\mathfrak{so}(n)$ exactly over $\mathbb Q$:

| $n$ | $\dim\mathfrak{so}(n)$ | rank (orbit) | $\dim\mathrm{Stab}$ | $\dim\mathrm{Weyl}_n$ | slice | $n^2(n^2-13)/12$ |
|---|---|---|---|---|---|---|
| 4 | 6 | 6 | 0 | 10 | 4 | 4 |
| 5 | 10 | 10 | 0 | 35 | 25 | 25 |
| 6 | 15 | 15 | 0 | 84 | 69 | 69 |

(One pedantic correction: the stabiliser is never *trivial* ($-\mathrm{Id}\in O(n)$ acts trivially on a degree-four tensor) but it is finite, which is all the count needs.)

### 1c: what happens at the maximisers, the brief's hypothesis is refuted

Exact stabiliser and orbit dimensions, computed the same way:

| point | $n$ | $\dim\mathrm{Stab}$ | orbit | $\dim\mathrm{Weyl}_n$ | slice $=\dim\mathrm{Weyl}-\text{orbit}$ |
|---|---|---|---|---|---|
| $S^2\times S^2$ | 4 | 2 | 4 | 10 | 6 |
| $S^3\times S^3$ | 6 | 6 | 9 | 84 | 75 |
| $S^4\times S^4$ | 8 | 12 | 16 | 300 | 284 |
| $S^5\times S^5$ | 10 | 20 | 25 | 770 | 745 |
| padded $W_{\mathbb{CP}^2}$ | 4 | 4 | 2 | 10 | 8 |
| padded $W_{\mathbb{CP}^2}$ | 6 | 5 | 10 | 84 | 74 |
| padded $W_{\mathbb{CP}^2}$ | 8 | 10 | 18 | 300 | 282 |

matching $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ of dimension $m(m-1)=\frac{n(n-2)}4$ at the balanced product (orbit $n^2/4$), and $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$ of dimension $4+\frac{(n-4)(n-5)}2$ at padded $W_{\mathbb{CP}^2}$.

**So the orbit is indeed far smaller at the maximisers, and the conclusion the brief proposed does not follow.** Smaller orbit means a *larger* slice, not fewer local moduli. The residual stabiliser $H$ acts on the slice, and the number of independent $O(n)$-invariants near the special orbit is $\dim(\text{slice})-\dim(\text{generic }H\text{-orbit in the slice})$, which returns to $\dim\mathrm{Weyl}_n-\dim O(n)$: the balanced product gives $\dim\mathrm{Weyl}_n-\frac{n^2}4-\frac{n(n-2)}4=\dim\mathrm{Weyl}_n-\frac{n(n-1)}2$ exactly. $\mathrm{Weyl}_n$ is irreducible, so every neighbourhood of the symmetric point contains generic points and the quotient has the generic dimension there too. **There is no local moduli collapse at the maximisers, and no good news hiding in one.** The author's count is not misleading in this respect.

### 1d: the inference from the count is the real error

Three separate problems.

**(i) The count-versus-eigenvalues comparison inverts at $n=4$, which is the case being explained.** Post F2c reads "$1572$ parameters against $66$ eigenvalues" at $n=12$. The same comparison at $n=4$ is *four parameters against six eigenvalues*, the spectrum over-determines the orbit. $n^2(n^2-13)/12>n(n-1)/2$ fails only at $n=4$ and holds from $n=5$ on. The sharp statement is that the crossing is at $n=5$; the post instead presents the count as though $n=4$ were small and $n\ge5$ large by degree, which is the same fact stated less precisely.

**(ii) At $n=4$ the alignment term is exactly spectral, proved.** With Huisken's normal form and $\sum\lambda_i=\sum\mu_i=0$, symbolic expansion of the full contractions gives, identically on $\mathrm{Weyl}_4$,

$$\mathop{\mathrm{tr}}(W^3)=\langle W^2,W\rangle,\qquad \boxed{\ \langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3),\qquad \langle Q(W),W\rangle=3\mathop{\mathrm{tr}}(W^3)\ }$$

(residual exactly $0$ in the four free parameters). Both named points obey it: $S^2\times S^2$ has $(\mathop{\mathrm{tr}} W^3,\langle W^\#,W\rangle)=(\tfrac49,\tfrac89)$ and $\mathbb{CP}^2$ has $(48,96)$. So at $n=4$ the $\mathfrak{so}(n)$-structure-constant term is a function of the spectrum, $P$ is a spectral invariant, and a bound "seeing only the $\binom n2$ eigenvalues" does not merely suffice, it is an identity. That is *why* Huisken's enumeration closes, and it is a sharper statement than the moduli count. Note the consistency with post F1: $\mathop{\mathrm{tr}}(W^3)/P=\frac13$ at $n=4$, which is exactly $\frac2{(n-1)(n-2)}$.

**(iii) For $n\ge5$ the claim is true but the moduli count does not prove it; an isospectral pair does.** For a coordinate-diagonal $W$ with vertex matrix $\Lambda$ (hollow, symmetric, zero row sums), the $\Lambda^2$-spectrum is the multiset $\{\Lambda_{ij}\}$, $\mathop{\mathrm{tr}}(W^3)=\sum\Lambda_{ij}^3$, and $\langle W^\#,W\rangle=\tfrac12\mathop{\mathrm{tr}}(\Lambda^3)$, the first two are multiset functions and the third is not. Taking $\pm1$ weights on $K_{2,2,2}\subset K_6$ with two $+$ and two $-$ at every vertex gives, exactly,

| | $\Lambda$ | spectrum of $W$ on $\Lambda^2$ | $\lVert W\rVert^2$ | $\mathop{\mathrm{tr}}(W^3)$ | $\langle W^\#,W\rangle$ | $P$ | $\dim\mathrm{Stab}$ |
|---|---|---|---|---|---|---|---|
| $W_0$ | rows $(0,0,1,1,-1,-1),(0,0,-1,-1,1,1),(1,-1,0,0,1,-1),(1,-1,0,0,-1,1),(-1,1,1,-1,0,0),(-1,1,-1,1,0,0)$ | $1^6,0^3,(-1)^6$ | 12 | 0 | 0 | 0 | 0 |
| $W_+$ | rows $(0,0,1,-1,1,-1),(0,0,-1,1,-1,1),(1,-1,0,0,1,-1),(-1,1,0,0,-1,1),(1,-1,1,-1,0,0),(-1,1,-1,1,0,0)$ | $1^6,0^3,(-1)^6$ | 12 | 0 | 24 | 24 | 0 |

Both are genuine Weyl tensors (first Bianchi and $\mathrm{Ric}=0$ verified exactly), both have $0$-dimensional stabiliser, they are isospectral as operators on $\Lambda^2\mathbb R^6$, and $P$ differs. **That is the fact fence post F1 needs, and it costs one exact computation rather than a dimension count.**

**(iv) The logical form of "cannot suffice" is wrong.** A dimension count says the spectrum does not *determine* the orbit; an inequality is not a determination. The function $B(\text{spec})=\max\{P(W'):\mathop{\mathrm{spec}}(W')=\mathop{\mathrm{spec}}\}$ *is* a spectral bound, it is sharp, and the conjecture is precisely $B\le\theta_0$. What is true is the narrower statement post F1 already makes: no *tractable* spectral functional in play ($\mathop{\mathrm{tr}}(W^3)$, Hölder/Tachibana), reaches the $\#$ term. The sentence "a spectral bound sees only the $N$ eigenvalues; the moduli are what is left over" should not be carried as if it closed a class of proofs.

---

## 2. Huisken's Lemma 3.5, mechanism CONFIRMED, and the notes misquote it twice

The primary text (pp. 57–59) says exactly what post F2c says it does: the normal-form theorem is invoked ("there exists a local orthonormal basis $e_1,\dots,e_4$ such that ... $W$ takes the form $[E_{ij}]$" built from $A=\mathop{\mathrm{diag}}(\lambda_i)$, $B=\mathop{\mathrm{diag}}(\mu_i)$), $\sum\mu_i=0$ "in view of the Bianchi identity" and $\sum\lambda_i=0$ "since the trace of $W$ vanishes", the cubic becomes $8P(\lambda,\mu)$, and (3.10)–(3.12) enumerate stationary points by Lagrange multipliers. **CONFIRMED.**

I rebuilt the normal form as an actual $4$-tensor and checked every structural claim symbolically: first Bianchi holds $\iff\sum\mu_i=0$; $\mathrm{Ric}=(\sum\lambda_i)g$; $|W|^2=8\sum(\lambda_i^2+\mu_i^2)$, which is Huisken's own normalisation line. The contraction identity is

$$2W_{ijkl}W_{imkn}W_{jmln}+\tfrac12W_{ijkl}W_{klmn}W_{ijmn}=4\langle Q(W),W\rangle=8P,$$

$$P=6\{\lambda_1\lambda_2\lambda_3+\lambda_1\mu_2\mu_3+\lambda_2\mu_1\mu_3+\lambda_3\mu_1\mu_2\}+\{\lambda_1^3+\lambda_2^3+\lambda_3^3\}+3\{\lambda_1\mu_1^2+\lambda_2\mu_2^2+\lambda_3\mu_3^2\},$$

with residual exactly $0$, **and unconditionally, before the trace constraints are imposed**.

**Error 1, in [notes.md](../references/huisken-1985-ricci-deformation/notes.md): the quoted $P$ has $\{\mu_1^3+\mu_2^3+\mu_3^3\}$ where it must be $\{\lambda_1^3+\lambda_2^3+\lambda_3^3\}$.** Independent of my computation, the transcription is impossible: $(\lambda,\mu)\mapsto(\lambda,-\mu)$ is orientation reversal, an element of $O(4)\setminus SO(4)$, so $P$ must be even in $\mu$, and every other displayed term is. At $\mu=0$ the misquoted $P$ gives $48\lambda_1\lambda_2\lambda_3$ against the true $72\lambda_1\lambda_2\lambda_3$, so anyone re-deriving the stationary values from the notes gets the wrong ones.

**Error 2, same file: the constant.** The notes quote (3.8) as $\le\frac{\sqrt6}2|W|^3$ and then read $\frac{\sqrt6}2=\sqrt{3/2}$ as "the $\mathbb{CP}^2$ value". Those are two different conventions. Huisken's $|W|^2=W_{ijkl}W_{ijkl}=4\lVert W\rVert^2$, and the sharp constant in his convention is $\frac{\sqrt6}4$; it is $\frac{\sqrt6}2$ only after passing to $\lVert W\rVert$, which is Xu's (2.49). As quoted, the notes' inequality is true but **not sharp**, contradicting the file's own next sentence.

**The sharp constant, re-proved independently and globally.** Maximising $8P$ over $\sum\lambda_i=\sum\mu_i=0$, $\sum(\lambda_i^2+\mu_i^2)=1$ by Lagrange multipliers, I eliminated all four variables by a lex Gröbner basis over $\mathbb Q$. The elimination ideal in the multiplier $t$ is generated by

$$(t^2-432)(t^2-216),\qquad 8P=\tfrac23t\ \text{(Euler)},$$

so the only critical values of $8P$ are $\pm8\sqrt3$ and $\pm4\sqrt6$. Hence $\max|8P|=8\sqrt3$ at $|W|^2=8$, i.e. $|8P|\le\frac{\sqrt6}4|W|^3=\frac{\sqrt6}2\lVert W\rVert^3\cdot4$, which is Xu (2.49) exactly. Both branches are named points: $t^2=432$ is $\lambda=\mu$ with spectrum $\propto(2,-1,-1)$, i.e. (anti-)self-dual $W_{\mathbb{CP}^2}$ at $\theta=\sqrt{3/2}$; $t^2=216$ is $\mu=0$, $\lambda\propto(1,1,-2)$, i.e. $S^2\times S^2$ at $\theta=\frac{\sqrt3}2$, the two differing by exactly $\sqrt2$. This also validates Huisken's own case analysis: his two branch values, $8P=-3\lambda_1$ with $\lambda_1^2=\frac1{48}$ and $8P=-6\lambda_1$ with $\lambda_1^2=\frac1{96}$ under $|W|=1$, are $\mp\frac{\sqrt3}4$ and $\mp\frac{\sqrt6}4$, my two critical values, rescaled.

### 2b: the dichotomy against "$\mathfrak{so}(4)$ semisimple non-simple" is false

Post F2c and [notes.md](../references/huisken-1985-ricci-deformation/notes.md) both assert the splitting reason is "true but not operative". **This is a distinction without a difference.** The $n=4$ normal form exists precisely because $\Lambda^2=\Lambda^2_+\oplus\Lambda^2_-$ and $SO(4)\to SO(3)\times SO(3)$ is onto, which is what lets $W_\pm$ be diagonalised *simultaneously* by a single frame. Equivalently: at $n=4$ the image of $\mathfrak{so}(n)\to\mathfrak{so}(\Lambda^2)$ is $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, the *full* rotation algebra of each summand, whereas for $n\ge5$ it has dimension $\frac{n(n-1)}2$ inside $\frac{N(N-1)}2$. The moduli count is that same fact in dimensional form, not a competing explanation. Nothing is gained by retracting the first reason, and the retraction cost something: **[ATTEMPTS.md](../ATTEMPTS.md)'s crux table still closes the Huisken route on the retracted reason** ("$n=4$ is the unique dimension where $\mathfrak{so}(n)$ is semisimple but not simple"), so the two live documents now give incompatible accounts of the same closure.

---

## 3. Fence post F2, identities CONFIRMED, the $1.29$ figure REFUTED

I built $W_{S^m\times S^m}$ from the product curvature by exact Weyl projection and computed the three cubics exactly:

| $n$ | $\lVert W\rVert^2$ | $\mathop{\mathrm{tr}}(W^3)$ | $\langle W^\#,W\rangle$ | $P$ | $\mathop{\mathrm{tr}}(W^3)/P$ | $\langle W^\#,W\rangle/P$ | $\theta^2$ |
|---|---|---|---|---|---|---|---|
| 4 | $4/3$ | $4/9$ | $8/9$ | $4/3$ | $1/3$ | $2/3$ | $3/4$ |
| 6 | $18/5$ | $18/25$ | $162/25$ | $36/5$ | $1/10$ | $9/10$ | $10/9$ |
| 8 | $48/7$ | $48/49$ | $960/49$ | $144/7$ | $1/21$ | $20/21$ | $21/16$ |
| 10 | $100/9$ | $100/81$ | $3500/81$ | $400/9$ | $1/36$ | $35/36$ | $36/25$ |
| 12 | $180/11$ | $180/121$ | $9720/121$ | $900/11$ | $1/55$ | $54/55$ | $55/36$ |
| 14 | $294/13$ | $294/169$ | $22638/169$ | $1764/13$ | $1/78$ | $77/78$ | $78/49$ |

Every row matches $\frac{2}{(n-1)(n-2)}$, $\frac{n(n-3)}{(n-1)(n-2)}$ and $\theta_0^2=\frac{2(n-1)(n-2)}{n^2}$. **CONFIRMED**, and the two shares sum to $1$ trivially since they are the two halves of $P$. The identification $B_\#/\theta_0=\frac{n(n-3)}{(n-1)(n-2)}$ is consistent with the recorded $B_\#=\frac{\sqrt2\,(n-3)}{\sqrt{(n-1)(n-2)}}$, exactly.

**Three problems with how the post uses this.**

**(a) "The vertex bound is exactly saturated" presupposes a theorem the record does not have.** [ATTEMPTS.md](../ATTEMPTS.md) states plainly that $\langle W^\#,W\rangle=\tfrac12\mathop{\mathrm{tr}}(\Lambda^3)$ is "a fact about the coordinate-diagonal frame specifically, not a basis-free tensorial identity", and rates the off-diagonal validity of $B_\#$ "Low-to-moderate ... not yet a proof". Saturation of an unproved bound is not a fact about $\mathrm{Weyl}_n$; the fact is that the balanced product *attains* the value the conjectured bound would give.

**(b) The conclusion survives (a), and should be restated so that it visibly does.** Any term-by-term route bounds each summand by a constant times $\lVert W\rVert^3$, and any *valid* such bound is at least the largest attained value of that summand. So the floor is $\frac{\langle W^\#,W\rangle_{S\times S}+\max\mathop{\mathrm{tr}}(W^3)}{\theta_0}$ with no reference to $B_\#$ at all. This is the honest form of the argument and it needs nothing unproven.

**(c) "$\ge1.29\times$ unconditionally" is false.** With the largest known attained $\mathop{\mathrm{tr}}(W^3)/\lVert W\rVert^3=\frac{\sqrt6}6$ (padded $W_{\mathbb{CP}^2}$: $\mathop{\mathrm{tr}}(W^3)=48$, $\lVert W\rVert^2=24$), the floor is

$$f(n)=\frac{n(n-3)}{(n-1)(n-2)}+\frac{n\sqrt3}{6\sqrt{(n-1)(n-2)}},\qquad f(12)=\frac{54}{55}+\frac{\sqrt{330}}{55},\qquad \lim_{n\to\infty}f(n)=1+\frac{\sqrt3}6 .$$

$f$ increases up to $n=11$ and is strictly decreasing from there on (checked by exact comparison $f(n)>f(n+1)$ for every $n$ from $11$ to $60$ and at $100,200,323,324,400,1000,5000$), so on the conjecture's range $n\ge12$ it is **above** its limit $1+\frac{\sqrt3}6=1.2886\ldots$ and takes its maximum at $n=12$, and it falls **below** $\frac{129}{100}$ for all large $n$. Exact comparison: $f(323)>\frac{129}{100}>f(324)$. Reviewer 92's own line says "decreasing to $1+\frac{\sqrt3}6\approx1.2887$" and hedges with "at least ~$1.29$"; fence post F2 and the [ATTEMPTS.md](../ATTEMPTS.md) crux table dropped the tilde and added "unconditionally", which is exactly the word that makes it wrong. **Fix: state the floor as $1+\frac{\sqrt3}6$, which is unconditional on $n\ge12$, and $\frac{54}{55}+\frac{\sqrt{330}}{55}$ at $n=12$, which is the largest value it takes there.** (Below $n=12$ the ratio is the wrong measurement anyway: $\theta_0(n)$ is not the sharp constant there, $\sqrt{3/2}$ is, and $f(4)=\frac23+\frac{\sqrt2}3$ sits under the limit.)

Two smaller notes. The "$17\times$ at $n=8$ and $43\times$ at $n=12$" figures check out ($\frac{N-2}{\sqrt{N(N-1)}}$ against $\theta_0\cdot\frac2{(n-1)(n-2)}$ with $N=\binom n2$) but they compare the trace-free bound to the value *at the sphere product*, not to $\max_{\mathrm{Weyl}}\mathop{\mathrm{tr}}(W^3)$; the wording "overshoots on Weyl tensors by $17\times$" invites the second reading. And "any term-by-term route" should be scoped to routes bounding each summand by a constant multiple of $\lVert W\rVert^3$: a split with an $n$- or spectrum-coupled trade-off between the two terms is not covered by this floor.

---

## 4. The $\Theta(n)$ claim, CONFIRMED, with one scope caveat

Read from the primary text: (2.53) and (2.54) are derived by direct contraction plus first Bianchi, with no estimate anywhere; the single inequality in the chain is (2.55), applying Lemma 2.10's $\lambda_i^2\le\frac{N-1}N\lVert T\rVert^2$ to each $\xi^{pqrs}$ separately. **The localisation of all loss to (2.55) is correct.**

The Gram reformulation is right: with $M=\sum\xi\otimes\xi\succeq0$, $\mathop{\mathrm{tr}}M=16(n-1)\lVert W\rVert^2$ and $\mathop{\mathrm{tr}}(WM)=-16\langle Q(W),W\rangle$, so $\lvert\mathop{\mathrm{tr}}(W\widehat M)\rvert=\frac{\lvert\langle Q(W),W\rangle\rvert}{(n-1)\lVert W\rVert^2}$ and the target is $\lvert\mathop{\mathrm{tr}}(W\widehat M)\rvert\le\frac{\theta_0\lVert W\rVert}{n-1}\sim\frac{\sqrt2}n\lVert W\rVert$ against $\approx\lVert W\rVert$ from (2.55). **CONFIRMED.**

The overshoot factor is exactly as claimed, and it closes in a clean form:

$$\frac{\sqrt{(n^2-1)(n-2)/n}}{\theta_0(n)}=\frac{n\sqrt{(n^2-1)(n-2)/n}}{\sqrt{2(n-1)(n-2)}}=\sqrt{\frac{n(n+1)}2},$$

giving $\sqrt{10},\sqrt{21},\sqrt{78},\sqrt{210}$ at $n=4,6,12,20$ and growth $n/\sqrt2$. **CONFIRMED exactly.**

*Caveat worth adding to post F2b.* It writes "the conjecture is exactly $\lvert\mathop{\mathrm{tr}}(W\widehat M)\rvert\le\frac{\theta_0(n)\lVert W\rVert}{n-1}$" with no dimension range. That statement is **false for $4\le n\le11$**, padded $W_{\mathbb{CP}^2}$ gives $\theta=\sqrt{3/2}>\theta_0(n)$ there, and at $n=4$ my Gröbner computation proves $\sqrt{3/2}$ is the global maximum, so the inequality fails at the very dimension the same post uses as its headline ($\sqrt{10}$ at $n=4$). The post's own $n=4$ entry in the overshoot list is therefore an overshoot against a quantity that is not the sharp constant at $n=4$. Add "for $n\ge12$".

---

## 5. The four closures

| Route | Assessment |
|---|---|
| Tachibana/Hölder term-by-term | **Sound in structure, overstated in number.** The attained-value floor is valid and needs no unproved vertex bound, but the floor is $1+\frac{\sqrt3}6$, not $\ge1.29$ unconditionally, and "any term-by-term route" needs the scoping in §3 |
| Petersen–Wink Prop 1.3 | **Sound.** Verified: $\Lambda_{\alpha\beta\gamma}+6\lambda_\alpha\lambda_\beta\lambda_\gamma=\sum_{i\ne j}\lambda_i\lambda_j^2$ by expansion, and the collapse is then pure linear algebra given the $-4\theta$ identity, which I checked exactly at $S^3\times S^3$ (structure constants of $\mathfrak{so}(6)$ over $\mathbb Q$): every row marginal is $2(n-2)=8$, $\langle W^\#,W\rangle=3\sum_I T\lambda\lambda\lambda=810$, $\sum\lambda^3=\mathop{\mathrm{tr}}(W^3)=90$, $P=900$, and $\sum_\gamma\lambda_\gamma\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2=-3600=-4P$ exactly. No bad argument found |
| Huisken $n=4$ | **Closed on a retracted reason.** The route is genuinely closed, but the [ATTEMPTS.md](../ATTEMPTS.md) table gives the $\mathfrak{so}(4)$-splitting reason that post F2c retracts, and §2b above says the retraction was itself wrong. Two files, two incompatible reasons, and the correct account is that they are the same fact |
| $\xi$-Gram reformulation | **Honest, but a judgement rather than a proof.** "A restatement, neither easier nor harder" is a classification, not a closure; what is established is the measurement ($\Theta(n)$, §4), which the post says plainly. Given post F2b's own admission that this route was once abandoned on fence posts that did not cover it, the file should keep the distinction between *measured* and *closed* visible here |

---

## 6. Other things worth correcting

- **[fence-posts.md](../findings/fence-posts.md) has two items numbered 3** (the $1.7$–$1.8\times$ overshoot, and universal lifting), so the list runs $1,2,2b,2c,3,3,4,\dots$ and every cross-reference to "post F3" is ambiguous.
- **A datum the record may not have.** $\mathbb{CP}^3$ and $S^3\times S^3$ have *the same* $\theta$ at $n=6$: exactly $\theta^2=\frac{10}9$ for both. Exact values I computed for the Fubini–Study family: $\theta^2(\mathbb{CP}^2)=\frac32$, $\theta^2(\mathbb{CP}^3)=\frac{10}9$, $\theta^2(\mathbb{CP}^4)=\frac{35}{36}$, so $\mathbb{CP}^m$ loses to the balanced product from $n=8$ on, while *padded* $W_{\mathbb{CP}^2}$ keeps $\frac32$ and wins up to $n=11$. The coincidence at $n=6$ means the conjectured maximiser there is not unique among named families, which is a fact any rigidity statement at $n=6$ has to respect.
- **$\theta$ is monotone in $n$ for a structural reason worth stating once.** Zero-padding preserves $\langle Q(W),W\rangle$ and $\lVert W\rVert$ exactly, so $\sup_{\mathrm{Weyl}_n}\theta$ is non-decreasing in $n$ and is $\ge\sqrt{3/2}$ for every $n\ge4$. That, plus the $n=4$ Gröbner result $\sup_{\mathrm{Weyl}_4}\theta=\sqrt{3/2}$, gives the $n\le11$ non-invariance with no competitor hunt at all.

---

## What I would change in the files

1. [notes.md](../references/huisken-1985-ricci-deformation/notes.md): $\mu_i^3\to\lambda_i^3$ in $P$, and $\frac{\sqrt6}2|W|^3\to\frac{\sqrt6}4|W|^3$ (or restate in $\lVert W\rVert$).
2. [fence-posts.md](../findings/fence-posts.md) post F2: replace "$\ge1.29\times$ unconditionally" with "$>1+\frac{\sqrt3}6$ at every $n\ge12$, decreasing to that limit; $\frac{54}{55}+\frac{\sqrt{330}}{55}$ at $n=12$"; restate saturation as attainment; scope "any term-by-term route".
3. [fence-posts.md](../findings/fence-posts.md) post F2b: add "$n\ge12$" to the $\lvert\mathop{\mathrm{tr}}(W\widehat M)\rvert$ statement.
4. [fence-posts.md](../findings/fence-posts.md) post F2c: keep the moduli count as an arithmetic fact, drop the false dichotomy against the $\mathfrak{so}(4)$ splitting, and replace "alignment IS these moduli / a spectral bound cannot suffice" with the two provable statements, $P=3\mathop{\mathrm{tr}}(W^3)$ on $\mathrm{Weyl}_4$, and the $n=6$ isospectral pair with $P=0$ against $P=24$.
5. [ATTEMPTS.md](../ATTEMPTS.md) crux table: reconcile the Huisken row with post F2c, and carry the corrected floor.
