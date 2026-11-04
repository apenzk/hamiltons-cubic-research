# Review r646, Lemma L38, two families capped, in closed form and strictly decreasing

**Reviewer B, cold brief, analysis only. Review number 646.** Target: [findings/ungraded-slack.md](../findings/ungraded-slack.md) line 244, together with the section its provenance note names, [findings/ungraded-slack.md](../findings/ungraded-slack.md) line 73.

## Verdict: CONFIRMED

Both closed forms are right, both monotonicity claims are right, and the $m=2$ identification is right. I derived each independently and each agrees with a second and third route already on the record. **Four defects, none touching the truth of the display:**

1. **The provenance pointer is false.** The named section is the Casimir subalgebra family, which explicitly lists $\mathbb{CP}^m$ among the objects *outside* it. Neither closed form, and neither derivation, occurs anywhere in [ungraded-slack.md](../findings/ungraded-slack.md) except inside the L38 block itself. The two arguments live in [findings/algebra.md](../findings/algebra.md) and [findings/target.md](../findings/target.md).
2. **No range of $m$ is stated**, and both formulas are undefined at $m=1$. "Strictly decreasing" and "maximum $\tfrac32$" are not well-posed without it. [results.md](../results.md) line 476 carries $m\ge2$ for the first family and nothing for the second.
3. **The $\mathbb{CP}^m$ half is [Lemma L10](../findings/graded-half.md) restated**, same formula, same monotonicity, same $m=2$ remark, two numbers, neither block citing the other.
4. **The block does not render**, and the defect is already on the record and unrepaired.

---

## 0. My reading of the symbols, stated before deriving

[conventions.md](../findings/conventions.md) was read first and treated as unreliable, as instructed. The senses I use:

| symbol | my reading | why |
| --- | --- | --- |
| $\theta$ | $P(W)/\lVert W\rVert^3$ with $P(W)=\langle W,W^2+W^\#\rangle$; equivalently the eigenvalue in $Q(W)=\theta W$ at $\lVert W\rVert=1$ | [conventions.md](../findings/conventions.md), the objects table |
| $\lVert\cdot\rVert$ on $\Lambda^2$ | half-trace, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal and $\lVert\varphi_{ab}\rVert^2=1$ | [conventions.md](../findings/conventions.md), "Norms and pairings"; the other pairing inflates every $\theta$ by $\sqrt2$ |
| $\mathfrak k$, $\mathfrak m$ | the **symmetric-pair** sense: $\mathfrak k$ the isotropy of $(\mathfrak g,\mathfrak k)$, $\mathfrak m=\mathfrak k^\perp$ **inside $\mathfrak g$**, not inside $\mathfrak{so}(n)$ | forced by $p+q=\dim\mathfrak g$ below; this is [target.md](../findings/target.md)'s sense, **not** [conventions.md](../findings/conventions.md)'s $\mathfrak m=E_{\min}$ and **not** [L36](../findings/isotropy-cap.md)'s whole negative eigenspace |
| $p$, $q$ | $\dim\mathfrak k$, $\dim\mathfrak m$ | the block |
| $S_{XYZ}$ | $\sum c_{abc}^2$ over **fully ordered** triples $(a,b,c)\in X\times Y\times Z$ in an orthonormal basis | undefined on the record; pinned by the $1:3$ weight in [L39](../findings/target.md) and independently by the Killing identity $S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp$ |
| $c$ | the Killing constant of the embedding: $\sum_{y\in\mathfrak g}\lVert[x,y]\rVert^2=c\lVert x\rVert^2$ | [conventions.md](../findings/conventions.md), "The Killing constant of a SUBALGEBRA" |
| $\kappa$ | the same quantity for $\mathfrak g=\mathfrak{so}(n)$ itself, $\kappa=2(n-2)$ | [conventions.md](../findings/conventions.md) |

**The letter $\mathfrak m$ is the live hazard here.** Under [conventions.md](../findings/conventions.md)'s reading $\mathfrak m=E_{\min}$ and $q=\dim\mathfrak m$ would be a spectral multiplicity; the block's $q=\binom{m+1}2-1$ is not one, and $p+q=m^2-1=\dim\mathfrak{su}(m)$ settles the symmetric-pair reading. **The block never says which it means.**

$\Pi_X$ is the orthogonal projection onto $X$, sense (i) of [conventions.md](../findings/conventions.md)'s four-way $\Pi$ collision, which is not the sense that table declares "meant below". Read from context.

---

## 1. The $\mathbb{CP}^m$ closed form, CONFIRMED, derived cold from Fubini–Study

I did not use the block's reasoning, criticality, or any recorded value. I built $W_{\mathbb{CP}^m}$ from the Fubini–Study curvature tensor and evaluated $P/\lVert W\rVert^3$ directly.

### 1.1 The curvature operator on $\Lambda^2\mathbb R^{2m}$

Normalise the metric to holomorphic sectional curvature $4$, so $K(X,Y)=1+3\,g(JX,Y)^2$ on orthonormal pairs, and

$$R(X,Y,Z,T)=g(X,Z)g(Y,T)-g(X,T)g(Y,Z)+g(JX,Z)g(JY,T)-g(JX,T)g(JY,Z)+2g(X,JY)g(Z,JT),$$

which returns $R(X,Y,X,Y)=1+3g(JX,Y)^2$ on an orthonormal pair, the one check the ansatz needs.

Under $U(m)$, $\Lambda^2\mathbb R^{2m}$ splits into three isotypic pieces: $\mathbb R\omega$ with $\omega=\sum_a e_a\wedge Je_a$ (dimension $1$), the $\mathfrak{su}(m)$-part of $\Lambda^{1,1}$ (dimension $m^2-1$), and $[\Lambda^{2,0}]_{\mathbb R}$ (dimension $m^2-m$). They sum to $\binom{2m}2=2m^2-m$.

Evaluating $\mathcal R$ on each, with $\langle\mathcal R(X\wedge Y),X\wedge Y\rangle=K(X,Y)$:

- $R(e_a,Je_a,e_b,Je_b)=2\delta_{ab}+2$, so $\langle\mathcal R\omega,\omega\rangle=\sum_{a,b}(2\delta_{ab}+2)=2m+2m^2$ against $\lVert\omega\rVert^2=m$: eigenvalue $\boxed{2(m+1)}$.
- On $\xi=e_1\wedge Je_1-e_2\wedge Je_2$: $\langle\mathcal R\xi,\xi\rangle=4-2\cdot2+4=4$ against $\lVert\xi\rVert^2=2$: eigenvalue $\boxed{2}$.
- On $u=e_1\wedge e_2$, $v=Je_1\wedge Je_2$ with $e_2\perp\{e_1,Je_1\}$: $\langle\mathcal Ru,u\rangle=\langle\mathcal Rv,v\rangle=1$ and $\langle\mathcal Ru,v\rangle=R(e_1,e_2,Je_1,Je_2)=1$. So $u-v$ (the $(2,0)$ type) has eigenvalue $\boxed{0}$ and $u+v$ has eigenvalue $2$, consistent with the previous line.

Trace check: $2(m+1)+2(m^2-1)=2m(m+1)=s/2$ with $s=4m(m+1)$, the scalar curvature of this normalisation. ✓

### 1.2 The Weyl operator

$\mathbb{CP}^m$ is Einstein, so $W=\mathcal R-\frac{s}{n(n-1)}\mathrm{Id}$ on $\Lambda^2$, that is, $\mathcal R$ shifted to trace zero. Writing $D=2m-1$, the mean is $2(m+1)/D$ and

$$\lambda_1=\frac{4(m^2-1)}D\ (\times1),\qquad \lambda_2=\frac{2(m-2)}D\ (\times\,m^2-1),\qquad \lambda_3=-\frac{2(m+1)}D\ (\times\,m^2-m),$$

with $\sum d_i\lambda_i=0$ identically. **At $m=2$ this is $\{4,0,0,0,-2,-2\}$, i.e. $\mathop{\mathrm{diag}}(0,0,0,-1,-1,2)/\sqrt6$ after normalisation**, byte-for-byte the record's $W_{\mathbb{CP}^2}$ at [report/sections/03-setup.tex](../report/sections/03-setup.tex) line 23. First independent anchor.

$$\lVert W\rVert^2=\sum d_i\lambda_i^2=\frac{4}{D^2}\cdot3m(m-1)(m+1)(2m-1)=\frac{12m(m-1)(m+1)}{2m-1}.$$

### 1.3 The bracket masses, from the Killing marginal alone

$\mathfrak z=\mathbb R\omega$ and $\mathfrak s=\mathfrak{su}(m)$-part make up $\mathfrak u(m)$, with $\mathfrak z$ central in it, and $(\mathfrak{so}(2m),\mathfrak u(m))$ is a symmetric pair, so $[\mathfrak n,\mathfrak n]\subseteq\mathfrak u(m)$ where $\mathfrak n=[\Lambda^{2,0}]_{\mathbb R}$. **Every block mass therefore vanishes except $S_{\mathfrak{sss}}$, $S_{\mathfrak{znn}}$ and $S_{\mathfrak{snn}}$.** Applying $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=\kappa=4(m-1)$ on each block in turn:

$$S_{\mathfrak{znn}}=4(m-1),\qquad S_{\mathfrak{znn}}+S_{\mathfrak{snn}}=\tfrac12\kappa(m^2-m)=2m(m-1)^2,\qquad S_{\mathfrak{sss}}+S_{\mathfrak{snn}}=\kappa(m^2-1),$$

hence $S_{\mathfrak{snn}}=2(m-1)(m-2)(m+1)$ and $S_{\mathfrak{sss}}=2m(m^2-1)$.

**Two checks that could not pass by accident.** $S_{\mathfrak{sss}}/\dim\mathfrak s=2m$, which is the Killing constant $2h^\vee(\mathfrak{su}(m))/I_\rho=2m/1$ of the realified standard representation, the same $c=2m$ [target.md](../findings/target.md) line 347 uses for the *second* family. And at $m=2$, $S_{\mathfrak{snn}}=0$, which says $[\mathfrak{su}(2)_+,\mathfrak n]=0$, true, because $\mathfrak n\subset\mathfrak{su}(2)_-$ and the two chiral factors of $\mathfrak{so}(4)$ commute.

### 1.4 The value

$$\theta=\mathop{\mathrm{tr}}(W^3)+\tfrac12\big[\lambda_2^3S_{\mathfrak{sss}}+3\lambda_1\lambda_3^2S_{\mathfrak{znn}}+3\lambda_2\lambda_3^2S_{\mathfrak{snn}}\big].$$

$$\mathop{\mathrm{tr}}(W^3)=\frac{8m(m-1)(m+1)(8m^3-24m+11)}{D^3}=\frac{8m(m-1)(m+1)(4m^2+2m-11)}{D^2},$$

using $8m^3-24m+11=(2m-1)(4m^2+2m-11)$. The bracket term is

$$\tfrac12\Sigma=\frac{8m(m-1)(m+1)}{D^3}\big[m(m-2)^3+12(m-1)(m+1)^2+3(m-2)^2(m+1)^2\big]=\frac{8m(m-1)(m+1)(2m^2+m+8)}{D^2},$$

using $4m^4+15m^2-8m=m(2m-1)(2m^2+m+8)$. The two brackets sum to $6m^2+3m-3=3(2m-1)(m+1)$, so

$$P(W)=\frac{24m(m-1)(m+1)^2}{2m-1},\qquad \theta^2=\frac{P^2}{\lVert W\rVert^6}=\frac{576(m+1)(2m-1)}{1728\,m(m-1)}=\boxed{\frac{(m+1)(2m-1)}{3m(m-1)}}$$

**exactly the displayed form.** Criticality was never used; this is a value computation.

### 1.5 Three further anchors already on the record

- $m=2$ gives $3/2$, and $P/\lVert W\rVert^3=144/24^{3/2}=\sqrt{3/2}$ directly from §1.2. The rival maximiser.
- $m=3$ gives $10/9=\theta_0(6)^2$ **exactly**, [ungraded-slack.md](../findings/ungraded-slack.md) line 101's "$W_{\mathbb{CP}^3}$ ties $\theta_0(6)$ from outside the family".
- [algebra.md](../findings/algebra.md) line 29 gives a fourth, independent of everything above: Fox's idempotent $\mathcal S^r(\alpha)$ has $\lvert\mathcal S^r\rvert^2=6r(r-2)/((r+2)(r-1))$, so $\theta^2=2(r+2)(r-1)/(3r(r-2))$, which at $r=2m$ is $\frac{4(m+1)(2m-1)}{12m(m-1)}$, the same. **That is the block's real proof, and it is in a different file.**

---

## 2. The $(\mathfrak{su}(m),\mathfrak{so}(m))$ closed form, CONFIRMED, by two routes

$p=\binom m2=\frac{m(m-1)}2$, $q=\binom{m+1}2-1=\frac{(m-1)(m+2)}2$, and $p+q=m^2-1=\dim\mathfrak{su}(m)$, the internal check that fixes the symmetric-pair reading of $\mathfrak m$. **Note $p+q<\binom{2m}2$, so $W$ carries a kernel of dimension $m^2-m+1$ on $\Lambda^2\mathbb R^{2m}$ and has three eigenvalues, not two**, which is precisely why this family is *not* a member of the Casimir subalgebra family the provenance note points at (§5).

### 2.1 Via the three-invariant form the brief supplies

With $c=2m$, $3p-q=(m-1)^2$ and $p-q=-(m-1)$:

$$cq(3p-q)-4p(p-q)=m(m+2)(m-1)^3+2m(m-1)^2=m(m-1)^2\big[(m+2)(m-1)+2\big]=m^2(m+1)(m-1)^2,$$
$$16p^3q(p+q)=m^3(m-1)^5(m+2)(m+1),$$
$$\theta^2=\frac{m^4(m+1)^2(m-1)^4}{m^3(m-1)^5(m+2)(m+1)}=\boxed{\frac{m(m+1)}{(m-1)(m+2)}}.$$

### 2.2 Via [L39](../findings/target.md)'s four-invariant form, with the record's own block masses

Independent of the Killing reduction: substitute $S_{\mathfrak{kkk}}=(m-2)p$ and $S_{\mathfrak{kmm}}=mq$ ([target.md](../findings/target.md) line 389) into $\theta^2=\big(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2\big)^2/\big(4p^3q(p+q)^3\big)$. Writing $u=(m-1)/2$, $p=mu$, $q=(m+2)u$, $p+q=2(m+1)u$:

$$\mathcal N=p\big[mq^2+3mpq-2p^2\big]=mu\cdot u^2m\big[(m+2)^2+3m(m+2)-2m\big]=4m^2u^3(m+1)^2,$$
$$4p^3q(p+q)^3=32m^3(m+2)(m+1)^3u^7,\qquad \theta^2=\frac{16m^4u^6(m+1)^4}{32m^3(m+2)(m+1)^3u^7}=\frac{m(m+1)}{2(m+2)u}=\frac{m(m+1)}{(m-1)(m+2)}.$$

**The two routes agree, and they are not the same computation**, §2.1 consumes only $(p,q,c)$, §2.2 only $(p,q,S_{\mathfrak{kkk}},S_{\mathfrak{kmm}})$. They cross-validate the Killing reduction as a by-product: $c(p-\tfrac q2)=2m\cdot\frac{(m-1)(m-2)}4=(m-2)p$ ✓ and $\tfrac12cq=mq$ ✓. **So [r636](REVIEW_r636.md)'s three-invariant sharpening and [target.md](../findings/target.md)'s independently derived block masses agree exactly on this family, which is the check the brief asked for.**

$X=m(m+1)$ gives $X-2=(m-1)(m+2)$, so $\theta^2=X/(X-2)$ identically. A third agreeing route is [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 111, through the pinning law with $C=m$.

---

## 3. "Strictly decreasing", CONFIRMED for both, over $m\ge2$; the range is missing from the block

**Second family, immediate.** $\theta^2=1+\dfrac2{X-2}$, strictly decreasing in $X$ on $X>2$, and $X=m(m+1)$ is strictly increasing for $m\ge1$. Requires $X>2$, i.e. $m\ge2$.

**First family, by derivative.** With $f(m)=\dfrac{2m^2+m-1}{3(m^2-m)}$,

$$\mathop{\mathrm{sign}}f'(m)=\mathop{\mathrm{sign}}\Big[(4m+1)(m^2-m)-(2m^2+m-1)(2m-1)\Big]=\mathop{\mathrm{sign}}\big[-(3m^2-2m+1)\big],$$

and $3m^2-2m+1$ has discriminant $4-12=-8<0$ with positive leading coefficient, so it is positive for every real $m$. **Hence $f'<0$ on all of $(1,\infty)$**, strictly decreasing, and not merely on integers. Limit $2/3$.

### The range is stated nowhere in the block

| $m$ | family 1 | family 2 |
| --- | --- | --- |
| $0$ | $\frac{1\cdot(-1)}{0}$, undefined | $p=0$, $q=-1$, meaningless |
| $1$ | denominator $3m(m-1)=0$ | $X-2=0$; and $p=q=0$, the pair is trivial |
| $2$ | $3/2$ | $3/2$ |

So $m=0$ and $m=1$ are excluded, but **by the formulas being undefined, not by any stated hypothesis**, which is exactly the failure mode the brief flags. Both constructions independently confirm $m\ge2$: Fox's $\mathcal S^r(\alpha)$ needs even $r\ge4$ (at $r=2$, $\lvert\mathcal S^r\rvert^2=0$), and the second family needs $\mathfrak{so}(m)\ne0$. **[results.md](../results.md) line 476 states $m\ge2$ for the first family and says nothing for the second; the [findings/](../findings/) block states neither.** With no range, "strictly decreasing in $m$" and "maximum $\tfrac32$" are not well-posed statements. **This is the one repair the display itself needs.**

### Where the two families meet

Setting the forms equal and cancelling $(m+1)/(m-1)\ne0$: $(2m-1)(m+2)=3m^2$, i.e. $m^2-3m+2=0$, i.e. $m\in\{1,2\}$. **So on $m\ge2$ they agree at $m=2$ and nowhere else**, consistent with the block's claim that the $m=2$ members coincide, and the coincidence is isolated. Off $m=2$ the second family is strictly the larger: $6/5$ against $10/9$ at $m=3$, $10/9$ against $35/36$ at $m=4$.

---

## 4. What the cap is worth

### 4.1 $\Theta_n$ at $n=2m$

$n=2m$ is even for every integer $m$, and [conventions.md](../findings/conventions.md) gives $\Theta_n=\theta_0(n)$ **at even $n$** with $\theta_0(n)^2=2(n-1)(n-2)/n^2$; at odd $n$ it is the smaller $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$. **So $\Theta_{2m}=\theta_0(2m)$ is safe here, and I say so rather than assuming it.** At $n=2m$, $\theta_0(2m)^2=(2m-1)(m-1)/m^2$.

### 4.2 Where each family drops below $\Theta_{2m}$

**First family.** $\dfrac{(m+1)(2m-1)}{3m(m-1)}$ against $\dfrac{(2m-1)(m-1)}{m^2}$: cancel $2m-1>0$ and $m>0$, leaving $m(m+1)$ against $3(m-1)^2$, i.e.

$$\theta(\mathbb{CP}^m)^2-\theta_0(2m)^2\ \propto\ -(2m-1)(m-3).$$

**Above at $m=2$, an exact tie at $m=3$, strictly below for every $m\ge4$.** This reproduces the companion audit's result exactly, by a route that shares nothing with it.

**Second family.** $m^3(m+1)$ against $(2m-1)(m-1)^2(m+2)$, i.e. the sign of $-m^4+2m^3+6m^2-7m+2$: $+12$, $+8$, $-58$, $-258$ at $m=2,3,4,5$. **Above at $m=2$ and $m=3$, strictly below for $m\ge4$, with no tie at any integer.** At $m=3$ it sits at $\sqrt{6/5}=1.0954$ against $\theta_0(6)=1.0541$, the same $\sqrt{6/5}$ the file's own $(\mathfrak{su}(3),\mathfrak{so}(3))$ row carries. No conflict with [L23](../findings/ungraded-slack.md)'s cap $\theta\le\theta_0(n)$, which is a statement about the *Casimir* family, and this point is not in it (§2).

### 4.3 What the caps license at $n\ge12$, and what they do not

Padding preserves $\theta$ ([conventions.md](../findings/conventions.md)), so **every member persists as a critical point at every larger $n$ with its value intact**, and the maximum $\sqrt{3/2}$ at $n=4$ is present at every $n\ge4$.

$$\theta_0(n)^2\ge\tfrac32\iff 4(n-1)(n-2)\ge3n^2\iff n^2-12n+8\ge0\iff n\ge6+2\sqrt7=11.2915\ldots$$

the file's own crossover constant. **Licensed at $n\ge12$:** no member of either family, at any $m\ge2$, padded to any $n\ge12$, reaches $\theta_0(n)$, the strict inequality $\sqrt{3/2}<\theta_0(12)=\sqrt{220}/12$ holds with margin, and grows with $n$. That is a genuine analytic cap over two infinite families, in the headline range, with no numerics.

**Not licensed.** (i) Nothing about points outside the two families, [results.md](../results.md) line 476 says this in the statement itself and the [findings/](../findings/) block does not. (ii) Nothing at $n\le11$: at $n=4$ and $n=6$ both families *exceed* $\theta_0(n)$, so the cap is against $\sqrt{3/2}$, never against $\Theta_n$. (iii) **The cap is attained**, at $\mathbb{CP}^2$, so it can never separate strictly below the rival, [target.md](../findings/target.md) line 405 already records this in the same words. What L38 buys is structural: the rival maximiser is the extreme point of two natural infinite families rather than an isolated accident, and both families run away from it monotonically.

---

## 5. The $m=2$ identification, CONFIRMED, and I derived it rather than checking dimensions

Dimensions first, as the brief asks: $p=\binom22=1$, $q=\binom32-1=2$, $p+q=3=\dim\mathfrak{su}(2)$, inside $\mathfrak{so}(4)$ with $N=6$. **Consistent**, and it forces a kernel of dimension $6-3=3$.

That is weak evidence on its own, so here is the identification. From §1.2 at $m=2$, $W_{\mathbb{CP}^2}$ has spectrum $\{4;\,0,0,0;\,-2,-2\}$ with the $4$ on $\mathbb R\omega$, the $0$ on the $\mathfrak{su}(2)$-part of $\mathfrak u(2)$, and the $-2$ on $\mathfrak n=[\Lambda^{2,0}]_{\mathbb R}$. **In $\mathfrak{so}(4)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$ the $\mathfrak{su}(2)$-part of $\mathfrak u(2)$ is one chiral factor and $\mathbb R\omega\oplus\mathfrak n$ is the other.** So:

- $W_{\mathbb{CP}^2}$ is supported on a single $\mathfrak{su}(2)\subset\mathfrak{so}(4)$ and vanishes on its complement, which is the second family's shape, $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ inside $\mathfrak g$, zero outside;
- $\mathfrak k=\mathbb R\omega=\mathfrak{so}(2)$ is the maximal torus of that $\mathfrak{su}(2)$, dimension $p=1$; $\mathfrak m$ is its orthogonal complement there, dimension $q=2$;
- $a\,p+b\,q=4\cdot1+(-2)\cdot2=0$ ✓, the family's own trace condition;
- $\theta^2=3/2$ from both formulas ✓.

**The identification is therefore proved, not asserted**, and it was already proved on the record, at [target.md](../findings/target.md) line 401, by naming the two spans explicitly and observing that $\mathbb{CP}^m$'s $P_{\mathfrak{su}}$ coefficient $(m-2)/((m+1)(2m-1))$ vanishes **only** at $m=2$. That last clause is what makes the coincidence isolated, and it agrees with my §3 computation that the two formulas meet only at $m=2$. **The [findings/](../findings/) block asserts the identification with no argument and no pointer to the one two files away.**

---

## 6. Provenance, the pointer is FALSE

The note reads: *"the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block. The statement is below; the argument is in this file under 'The subalgebra family: $\theta$ from $\dim\mathfrak h$ alone, and Conj'".*

**Section-containment reading used here, stated because two audits disagreed:** a `####` block belongs to the nearest preceding `##` heading, or to the file's `#` heading if none precedes it. [ungraded-slack.md](../findings/ungraded-slack.md) has exactly one `##`, at line 289, *after* L38 at line 244, so **under either reading L38 sits directly under the file heading**, and the "*Re-filed here 2026-09-02 from [target.md](target.md)*" line at 287 does not govern it. Nothing in this review turns on the choice.

| clause | verdict | evidence |
| --- | --- | --- |
| "numbered in [report/](../report/)" | **TRUE** | `\begin{Lem}{38}` at [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1098, in the subsection "Capping the non-diagonal families analytically" |
| "the mathematics has always been in this file" | **FALSE** | [ungraded-slack.md](../findings/ungraded-slack.md) did not exist before 2026-08-31. The block entered it at `7ad0455d`, the split of [graded-half.md](../findings/graded-half.md); before that it was written into [graded-half.md](../findings/graded-half.md) the same day. `git log -S 'two families capped' -- findings/ungraded-slack.md` returns exactly `7ad0455d` |
| "the argument is in this file under 'The subalgebra family…'" | **FALSE, twice over** | That section ([line 73](../findings/ungraded-slack.md)) is the Casimir family $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with $\theta=\tfrac2n\sqrt{rN/(N-r)}$, a **two**-eigenvalue operator spanning all of $\Lambda^2$. Neither of L38's families is in it: $\mathbb{CP}^m$ has three eigenvalues and the section's own closing paragraph names *"$\mathbb{CP}^m$, $\mathbb{HP}^m$, the complex Grassmannians"* as lying **outside** it, while the second family carries an $(m^2-m+1)$-dimensional kernel. And `grep` over the whole file returns the strings `3m(m-1)` and `(m-1)(m+2)` **only inside the L38 block itself** |

**Where the arguments actually are:** the $\mathbb{CP}^m$ form at [algebra.md](../findings/algebra.md) line 29 (Fox's norm identity, a derivation) and, as a four-row fit plus one held-out check, at [graded-half.md](../findings/graded-half.md) line 442; the second family at [target.md](../findings/target.md) line 389 (a full symbolic derivation) and as a sketch at [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1110.

**Sixteenth-time pattern, inverted.** The brief asks whether the block's own file settles it. Here it does **not**, and that is itself the finding: this is the block whose answer is in *three other files*, and the note sends the reader to the one section of its own file that explicitly disclaims both families.

### Derived or measured?

- **$\mathbb{CP}^m$: measured first, derived later, and the block cites neither.** Its origin is [graded-half.md](../findings/graded-half.md) line 442 (*"The four rows collapse to a closed form valid for all $m$… confirmed independently at $m=8$"*), a fit to four data points with one held-out check. [algebra.md](../findings/algebra.md) line 29 later supplied the proof and says so in as many words: *"it supplies the proof of the closed form that the measurement lacked."* §1 above is a third, independent derivation.
- **Second family: derived.** [target.md](../findings/target.md) line 389 is explicit that it is *"DERIVED, symbolically in $m$, not pattern-matched"*, and §2 confirms it twice.

---

## 7. Pointers, rendering, and duplication

- **The broken LaTeX is real**, at [ungraded-slack.md](../findings/ungraded-slack.md) line 256: `**The $m=2$ member of the second family is $W_{\CP^2**$ itself.}`, the `\textbf{…}` of [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1107 half-converted, leaving the bold markers inside the math and a stray closing brace outside it. **The defect is already on the record and unrepaired**: [reviews/ELIM-canon.md](ELIM-canon.md) line 214 names this exact string.
- **The whole block is raw report LaTeX.** `\CP`, `\su`, `\so`, `\kk`, `\mm` and `\[ … \]` displays, in a markdown file with no macro layer. The neighbouring blocks in the same file write `\mathbb{CP}` and `$$…$$`. Five macro occurrences.
- **Every other pointer resolves.** The `report/` claim, the `target.md` re-file note, and the internal links in the surrounding blocks all check.
- **The $\mathbb{CP}^m$ half duplicates [Lemma L10](../findings/graded-half.md).** L10's canonical block at [graded-half.md](../findings/graded-half.md) line 464 carries the identical formula, the identical monotonicity claim and the identical "$3/2$ at $m=2$" remark; [results.md](../results.md) lines 128 and 354 repeat it under L10's number. **Two numbered results assert one fact, in two files, neither citing the other**, and the copy that sits beside the derivation is L10's, while the copy carrying the false pointer is L38's.
- **A defect in [report/](../report/), reported not repaired** (outside this review's edit scope): the class table at [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 218 gives the $\mathbb{CP}^m$ row as *"decreasing to $1$"*. The limit of $\frac{(m+1)(2m-1)}{3m(m-1)}$ is $\tfrac23$, as [graded-half.md](../findings/graded-half.md) line 446 and [report/sections/90-appendix.tex](../report/sections/90-appendix.tex) line 67 both say. **$1$ is the limit of the *other* family, $X/(X-2)$**, the neighbouring row's number, written onto this one.

---

## 8. Every hedging clause

| clause | verdict |
| --- | --- |
| "strictly decreasing" (first family) | **TRUE**, and strictly, for all real $m>1$: §3 |
| "strictly decreasing" (second family) | **TRUE** for $m\ge2$, immediate from $1+2/(X-2)$ |
| "again" | **TRUE**, the mechanism differs (derivative against a one-line monotone reparametrisation), the conclusion is the same |
| "with maximum $\tfrac32$ at $m=2$", both | **TRUE given $m\ge2$; not well-posed as printed**, the range being absent |
| "itself" | **TRUE and provable**: §5 |
| "the K\"ahler family" | **Unjustified as a name for $m\ge3$.** $SU(m)/SO(m)$ is not a Hermitian symmetric space ($\mathfrak{so}(m)$ has trivial centre for $m\ne2$) so the word is accurate only at the $m=2$ member. Nothing mathematical depends on it; the record uses the name at [target.md](../findings/target.md) line 385 without ever justifying it |
| "capped" (the section title in [report/](../report/)) | **TRUE but the cap is attained**, so it fences and never separates: §4.3 |

---

## 9. Repairs, in order of value

1. **Replace the provenance pointer.** The two arguments are at [algebra.md](../findings/algebra.md) line 29 and [target.md](../findings/target.md) line 389. The named section disclaims both families in its own closing paragraph.
2. **State $m\ge2$**, for both families. [results.md](../results.md) line 476 already has it for the first.
3. **Fix line 256** and convert the block out of raw report LaTeX, a defect [ELIM-canon.md](ELIM-canon.md) recorded and nobody has cleared.
4. **Cross-link L38 and [L10](../findings/graded-half.md)**, or fold the $\mathbb{CP}^m$ half into one of them. Two numbers for one formula is how a correction reaches one copy.
5. **Carry [results.md](../results.md) line 476's scope sentence into the block**, *"a value statement about two families, saying nothing about points outside them"*. Without it the section title "capped" reads as a bound on more than it bounds.
6. **Add what the cap buys**, since the block states the values and not their use: $\theta\le\sqrt{3/2}<\theta_0(n)$ for every $n\ge12$, by $n\ge6+2\sqrt7$, at every padding of every member.
7. **[report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 218**: the $\mathbb{CP}^m$ limit is $\tfrac23$, not $1$.

*Analysis only throughout, per the standing rule. No computation was run, every number above is a hand derivation or an exact rational, and no screen was needed.*
