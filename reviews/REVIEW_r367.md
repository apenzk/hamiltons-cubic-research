# Review r367, Lemma L125 and Post F46

*Gate 2, reviewer r367, cold brief, analysis only. Every expansion below was redone by hand from the definitions before the write-ups' arguments were read; the only file consulted for conventions is [adversarial_check1.py](../scripts/lib/adversarial_check1.py), and the only source consulted is the paper text in [kt-1801.00617.txt](https://arxiv.org/abs/1801.00617). No computation was run.*

## Verdicts

| Claim | Verdict |
| --- | --- |
| W1, the unrestricted bound | **CONFIRMED** as a true statement, **deflated** as a lemma: it is one line from [Lemma L24](../findings/second-order.md), and its equality case is an identity |
| W2, the second-order expansion | **CONFIRMED**, every coefficient reproduced independently |
| W3 (agreement with Krasnov–Tkachev | **PLAUSIBLE**), the constants are right, the stated equivalence is against a form the source misprints |
| W4, application to L121's four-set block | **CONFIRMED**, and $c$ is [DERIVE-mx1](DERIVE-mx1.md)'s $\rho$, with no repeat of the L124-$\rho$ conflation |
| W5, the route closure | **REFUTED** on both halves of its reasoning and on its stated conclusion |
| W6, $c=1$ at padded $\mathbb{CP}^2$ | **REFUTED**; $c=1/\sqrt2$ and the slack factor is $9/4$, which is the record's own $2.25$ |

## Conventions taken as of record

From [adversarial_check1.py](../scripts/lib/adversarial_check1.py): the inner product is the Frobenius pairing of $\Lambda^2$-matrices,

```
def T_full(A, B, Cm, c):
    """Trilinear form T(A,B,C) = <A, B(B,C)>, inner product <X,Y>=tr(XY)."""
    return float(np.trace(A @ B_full(B, Cm, c)))

def P_value(W, c):
    return float(np.trace(W @ Q_full(W, c)))
```

so $\lVert W\rVert^2=\operatorname{tr}(W^2)$ counts each off-diagonal entry of $W$ on $\Lambda^2$ **twice**, and $P(X)=\langle X,Q(X)\rangle$ with $Q$ the diagonal of the polarisation $B$. That convention is load-bearing for the $c$ computation in W6 and is the one used throughout below.

## W2, the expansion, redone

Write $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, symmetric because it is the full polarisation of the cubic $P$ (the permutation symmetry of $T$ is item 4 of the script's own docstring). With $Q(W)=\theta W$, $\lVert W\rVert=1$, $a=\langle W,Y\rangle$, $b=\lVert Y\rVert^2$:

$$P(W+tY)=\theta+3t\,T(W,W,Y)+3t^2T(W,Y,Y)+t^3P(Y)=\theta+3t\theta a+3t^2\langle Y,W\circ Y\rangle+t^3P(Y).$$

$\lVert W+tY\rVert^2=1+2ta+t^2b$, so with $s=2ta+t^2b$ and $(1+s)^{-3/2}=1-\tfrac32s+\tfrac{15}8s^2+O(s^3)$, and $s^2=4t^2a^2+O(t^3)$:

$$\lVert W+tY\rVert^{-3}=1-3ta-\tfrac32t^2b+\tfrac{15}2t^2a^2+O(t^3).$$

Both factors match the write-up verbatim. The product's $t^1$ coefficient is $3\theta a-3\theta a=0$, the gradient of $f$ vanishes in **every** direction, as it must for a degree-zero function at a sphere-critical point. The $t^2$ coefficient is

$$3\langle Y,W\circ Y\rangle+(3\theta a)(-3a)+\theta\big(-\tfrac32b+\tfrac{15}2a^2\big)=3\langle Y,W\circ Y\rangle-\tfrac32\theta b+\big(-9+\tfrac{15}2\big)\theta a^2=3\langle Y,W\circ Y\rangle-\tfrac32\theta\lVert Y\rVert^2-\tfrac32\theta\langle W,Y\rangle^2.$$

Identical to the claim, sign and factor of $3$ included. $Q(W)=\theta W$ is used only in the $t^1$ term of $P$ and in $P(W)=\theta$, both legitimate at a critical point of unit norm. $D^2f(W)\le0$ on all of $\mathcal W_n$ is correct: $f(X)=P(X/\lVert X\rVert)$ is smooth away from $0$ and globally maximised at $W$, so the second-order necessary condition holds on the whole space with no tangency restriction. Dividing by $3\theta>0$ gives W1. **W2 is confirmed.**

## W1, true, and equivalent to L24 by two lines

$L_e$ is self-adjoint ($\langle L_eX,Y\rangle=\theta^{-1}T(W,X,Y)$, symmetric in $X,Y$) and $L_eW=Q(W)/\theta=W$. Hence $W^\perp$ is $L_e$-invariant. Write $Y=\alpha W+Z$ with $Z\perp W$:

$$\langle Y,L_eY\rangle=\alpha^2\underbrace{\langle W,L_eW\rangle}_{=1}+2\alpha\underbrace{\langle Z,L_eW\rangle}_{=\langle Z,W\rangle=0}+\langle Z,L_eZ\rangle=\alpha^2+\langle Z,L_eZ\rangle,$$
$$\tfrac12\lVert Y\rVert^2+\tfrac12\langle W,Y\rangle^2=\tfrac12(\alpha^2+\lVert Z\rVert^2)+\tfrac12\alpha^2=\alpha^2+\tfrac12\lVert Z\rVert^2 .$$

So **W1 is, term by term, the statement $\langle Z,L_eZ\rangle\le\tfrac12\lVert Z\rVert^2$ for $Z\perp W$**, [Lemma L24](../findings/second-order.md) and nothing else. The two are equivalent, in both directions, with no hypothesis beyond $L_eW=W$ and self-adjointness.

Two consequences for how L125 is framed:

- The box "**THIS IS THE GENERAL FORM THE RECORD CARRIED ONLY AS A QUOTATION**" overstates. The record carried the restriction and used the restriction; the general form is recoverable from it by the display above. The lemma is a correct repackaging, not new information, and the write-up should say so, a reader who takes the box at face value will look for content in the $\tfrac12\langle W,Y\rangle^2$ term that is not there.
- "**At $Y=W$ both sides are $1$**" is an **identity of degree-zero homogeneity**, not a sharpness statement. $f(W+tW)=f((1+t)W)=f(W)$ for all $t$, so the whole radial Taylor series vanishes; substituting $Y=W$ into the $t^2$ coefficient gives $3\theta-\tfrac32\theta-\tfrac32\theta=0$ for **any** critical point, maximiser or not, and for any sign of $\theta$. Equality along $W$ therefore certifies nothing about maximality and is not evidence that the bound is attained. The genuine attainment statement is the orbit directions at exact $\tfrac12$ in $W^\perp$, which L24 already carries.

**Verdict: W1 is true. It is not vacuous (off the radial line it is L24, which has real content) but it is vacuous exactly where L125 advertises it as sharp.**

## W3, the constants are right; the quoted Krasnov–Tkachev form is not

The paper's own second-derivative formula, equation (56) as it stands in [kt-1801.00617.txt](https://arxiv.org/abs/1801.00617) line 1071, is

```
   1 2         2|x|4 Lx − hx2 ; xi|x|2 − 3|x|2 (x ⊗ x2 + x2 ⊗ x) + 5hx2 ; xix ⊗ x
   3 D f (x) =                                                                         . (56)
                                                |x|5
```

Evaluate at $x=c$ with $c^2=c$, so $\langle c^2;c\rangle=|c|^2$ and $c\otimes c^2+c^2\otimes c=2\,c\otimes c$:

$$\tfrac13D^2f(c)=\frac{2|c|^4L_c-|c|^4\mathrm{Id}-6|c|^2c\otimes c+5|c|^2c\otimes c}{|c|^5}=\frac{1}{|c|}\Big(2L_c-\mathrm{Id}-\frac{c\otimes c}{|c|^2}\Big).$$

So the inequality $D^2f(c)\le0$ delivers is

$$2L_c-1\ \le\ \frac{c\otimes c}{|c|^2},$$

and the paper's next printed line, $2L_c-1\le c\otimes c$, **drops a factor $|c|^{-2}$**. The source's own conclusion is unaffected (both right-hand sides vanish on $c^\perp$) but the intermediate line is false whenever $|c|<1$, and it is false **in this project's setting**: test it at $y=c$, where it reads $|c|^2\le|c|^4$, i.e. $|c|\ge1$. Here $c=e=W/\theta$ has $|c|=1/\theta$ and a maximiser has $\theta=\max P\ge\sqrt{3/2}>1$, so $|c|<1$ and the printed form fails at $y=c$.

Two corrections follow.

- [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) transcribes the misprint into the record ("$D^2f(c)\le0$ reads $2L_c-1\le c\otimes c$"). It should carry $c\otimes c/|c|^2$, with a note that the source drops the normalisation. The notes file already records that KT's $c$ has $\lVert c\rVert=1/\theta$, so the file contains both halves of its own contradiction.
- [Lemma L24](../findings/second-order.md)'s prior-art paragraph repeats the same misprint, and L125's box quotes it as if it were the general truth L125 specialises.

**The substance of W3 stands**: with $c=e$ and $\lVert W\rVert=1$, $c\otimes c/|c|^2=\hat c\otimes\hat c=W\otimes W$, which is exactly W1's right-hand side. So L125's constants agree with the *corrected* Krasnov–Tkachev inequality. The claim as briefed (equivalence to the printed $c\otimes c$), is what fails. **PLAUSIBLE: right conclusion, wrong statement of what it agrees with.**

## W4, the application, and the $\rho$ question

The arithmetic is right. On a single sign-character direction $X$, [Lemma L123](../findings/second-order.md) gives $\langle X,L_RX\rangle=0$, so $\langle\hat X,L_e\hat X\rangle=\theta^{-1}\langle\hat X,L_{\mathrm{diag}(M)}\hat X\rangle=\tfrac1{2\theta}\sqrt\Sigma$ for the top eigenvector of [Lemma L121](../findings/second-order.md)'s block; W1 then gives $\tfrac1{2\theta}\sqrt\Sigma\le\tfrac12(1+c^2)$, hence $\sqrt\Sigma\le\theta(1+c^2)$ and $\Sigma\le\theta^2(1+c^2)^2$.

On the conflation r365 found: **there is no repeat of it here.** [DERIVE-mx1.md](DERIVE-mx1.md) defines its $\rho$ as the four-set mass, "since every $X_S$ has zero diagonal so $\rho=\langle X,R\rangle$", that is $\langle\hat X,W\rangle$ for the same unit block vector, so I12's $\rho$ and L125's $c$ **are the same quantity**. The quantity that differs is [Lemma L124](../findings/second-order.md)'s $\rho^2:=\lVert W|_{\Lambda^2\langle S\rangle}\rVert^2$, which is the mass of $W$ on the whole four-set, not on the four-set *character block*. L125 does not touch it. **CONFIRMED.**

One wording defect, without consequence: L125 calls $\tfrac1{2\theta}\sqrt\Sigma$ "the $L_e$-spectrum" of the block. Off the eigenframe $L_e=L_{\mathrm{diag}(M)}/\theta+L_R/\theta$ is not block-diagonal ([Post F44](../findings/second-order.md): $L_R$ is exactly the off-block part), so $\hat X$ is not an $L_e$-eigenvector and this is a Rayleigh quotient. W1 needs only the quotient, so nothing breaks; the sentence should say so.

## W6, $c=1/\sqrt2$ at padded $\mathbb{CP}^2$, not $1$. REFUTED.

Take $W$ half-flat at $S=\{i,j,k,l\}$, supported on $S$, with $V_+=\operatorname{diag}(A,B,C)$ in the basis $\omega_1=(e_{ij}+e_{kl})/\sqrt2$, $\omega_2=(e_{ik}-e_{jl})/\sqrt2$, $\omega_3=(e_{il}+e_{jk})/\sqrt2$ of [Lemma L124](../findings/second-order.md)(ii). As an operator on $\Lambda^2\langle S\rangle$,

$$W=A\,\omega_1\omega_1^{\!\top}+B\,\omega_2\omega_2^{\!\top}+C\,\omega_3\omega_3^{\!\top},$$

whose entries in the coordinate-plane basis are $W_{(ij),(ij)}=W_{(kl),(kl)}=W_{(ij),(kl)}=A/2$, and likewise $B/2$ (with the sign of the off-diagonal entry reversed) and $C/2$. So in the trace pairing:

- diagonal part (trivial character, [Lemma L123](../findings/second-order.md): "the trivial character space is precisely the diagonal entries"): six entries of size $A/2,A/2,B/2,B/2,C/2,C/2$, giving $\lVert\operatorname{diag}(M)\rVert^2=\tfrac12(A^2+B^2+C^2)$;
- four-set block (three complementary-pair entries, each counted twice by $\operatorname{tr}(XY)$): $\lVert W|_{V_S}\rVert^2=\tfrac12(A^2+B^2+C^2)$.

With $\lVert W\rVert^2=A^2+B^2+C^2=1$ the mass splits **exactly in half**. Two independent checks that this is the project's own arithmetic: it gives $t_F=2\lVert\operatorname{diag}(M)\rVert^2=1$, which is precisely the $t_F=1$ [DERIVE-mx1.md](DERIVE-mx1.md) records at padded $\mathbb{CP}^2$; and it gives $\lVert R\rVert^2=1-t_F/2=1/2$, which is that file's "$\rho\le\lVert R\rVert$ is exactly tight" there.

Hence, even when $\hat X\propto W|_{V_S}$, which is what "the top eigenvector is $(A,B,C)$ itself" means, and it is correct at $\mathbb{CP}^2$ since $G(A,B,C)^{\!\top}=(A^2+2BC,\,B^2+2AC,\,C^2+2AB)=\tfrac{\sqrt6}2(A,B,C)^{\!\top}$ at $(A,B,C)=(2,-1,-1)/\sqrt6$,

$$c=\langle W,\hat X\rangle=\lVert W|_{V_S}\rVert=\tfrac1{\sqrt2},\qquad c^2=\tfrac12,\qquad (1+c^2)^2=\tfrac94=2.25 .$$

$c=1$ would require $W$ to lie **entirely** inside the four-set character block. It cannot: half of a half-flat tensor's mass is its own sectional curvatures $M_{ab}$, which are trivial-character and orthogonal to the block. The two sentences of W6 ("$W$'s own component in that block" and "$c=1$ exactly"), are not the same statement, and the second does not follow from the first.

The correcting number is already twice on the record. [Lemma L124](../findings/second-order.md)'s own withdrawn-reading (c) says "at padded $\mathbb{CP}^2$ the step $\rho\le\lVert R\rVert$ is exactly tight and all of the $2.25$ is the projection correction", and [DERIVE-mx1.md](DERIVE-mx1.md) says "at padded $\mathbb{CP}^2$ ($t_F=1$, weaker bound) it is slack by $2.25$". **F46's "slack by exactly the factor $4$" contradicts the two paragraphs it cites.**

## W5, the route closure. REFUTED.

### The bound on $c$ in force is $1/2$, not $1$

$c\le1$ by Cauchy–Schwarz is true ($\lVert W\rVert=\lVert\hat X\rVert=1$) and is the weakest available statement. The applicable bound is Bessel over the four-set blocks, which the record already holds: distinct four-set blocks carry distinct sign characters and share no basis monomial ([DERIVE-mx1.md](DERIVE-mx1.md)'s Gate 2 paragraph), so $\sum_S c_S^2\le\lVert R\rVert^2=1-t_F/2$. On the half-flat single-four-set family that is $c^2\le1/2$, computed above. The chain therefore reads

$$\theta^2\ \le\ \Sigma\ \le\ \tfrac94\theta^2,$$

not $\theta^2\le\Sigma\le4\theta^2$.

### "Consistent for every member, so no member is excluded" is false

On the family the middle term is a **constant**. Half-flat with $V_+$ diagonal in the $\omega$-basis gives $\Sigma=\tfrac32\lVert\operatorname{diag}V_+\rVert^2=\tfrac32\rho^2=\tfrac32$ for every member, which is L124's own withdrawn-reading (a): "$\Sigma\equiv\tfrac32$ across the family while $\theta^2$ sweeps $[0,\tfrac32]$". So the right-hand inequality $\sqrt\Sigma\le\theta(1+c^2)$ is not a constraint on $\Sigma$ at all, it is a **lower bound on $\theta$**:

$$\sqrt{\tfrac32}\ \le\ \theta\,(1+c^2)\ \le\ \tfrac32\,\theta\qquad\Longrightarrow\qquad \theta\ \ge\ \tfrac23\sqrt{\tfrac32}=\sqrt{\tfrac23}\approx0.8165 .$$

Since $\theta=9\det V_+=9ABC$ sweeps $[-\sqrt{3/2},\sqrt{3/2}]$ over the family, **every member with $|\theta|<\sqrt{2/3}$, i.e. below two thirds of the family's maximum, violates the second-order condition and is excluded.** That is a positive exclusion, and F46's sentence asserting there is none is wrong. It is wrong precisely because $c$ was taken at $1$: at $c=1$ the threshold falls to $\tfrac12\sqrt{3/2}$, still nonzero, so even F46's own numbers do not support "consistent for every member" without checking the low-$\theta$ end, which it did not do.

### The route was never open, for a reason that has nothing to do with W1

The exclusion above is strictly weaker than a one-line comparison the record already states. A maximiser has $\theta=\max P\ge\sqrt{3/2}$, "since padded $\mathbb{CP}^2$ competes at every $n\ge4$" ([Lemma L124](../findings/second-order.md), withdrawn-reading (b)). Every member of the half-flat single-four-set family other than $\pm W_{\mathbb{CP}^2}$ has $\theta=9\det V_+<\sqrt{3/2}$ by the sharp determinant bound, and is therefore **not a maximiser by direct comparison of $P$-values**. There is nothing left for a second-order criterion to exclude.

So F46 closes a route that L124(iii) had already closed on its own: the "rigidity" $\theta^2\le\Sigma$ *is*, on this family, the determinant bound $\theta^2\le\tfrac32$ with $\Sigma$ a constant standing in for $\tfrac32$, and that bound with equality only at $\mathbb{CP}^2$ is the whole story. Writing it as a two-sided sandwich in $\Sigma$ makes it look like a composition of two independent facts; it is one fact and a constant.

### The stated open problem is already solved on the record

"**What a successor must clear:** a bound on $c$ itself at a maximiser", [DERIVE-mx1.md](DERIVE-mx1.md) carries it: $\sum_S\rho_S^2\le\lVert R\rVert^2=1-t_F/2$, its Corollary 2 ("at most $\lfloor1/t\rfloor$ of the $\binom n4$ subsets can have $\rho^2>t$", mean $\rho^2\le1/\binom n4$), and the screen reporting $\max\rho^2$ of $0.03$–$0.12$ at rotated $S^3\times S^3$. Since $c=\rho$ (see W4), F46 poses as the open obstacle the exact quantity its own sibling section bounds, and the file L125 cites for agreement one paragraph earlier is that sibling section.

## Corrections required

1. **[Post F46](../findings/second-order.md)**: replace $c\le1$ by $c^2\le\lVert R\rVert^2=1-t_F/2$, hence $c^2=1/2$ on this family; replace $4\theta^2$ by $\tfrac94\theta^2$ and "slack by exactly the factor $4$" by $2.25$, matching the two paragraphs it cites. Withdraw "consistent for every member, so no member is excluded": the chain excludes $|\theta|<\sqrt{2/3}$. Restate the closure as it actually is, every non-$\mathbb{CP}^2$ member is already a non-maximiser by $P$-value, so no second-order criterion has work to do here. Withdraw "what a successor must clear", or restate it as the sharper question ($c$ at an actual maximiser, beyond the Bessel budget), since the Bessel bound exists.
2. **[Lemma L125](../findings/second-order.md)**: record that the unrestricted form is equivalent to L24 by the $Y=\alpha W+Z$ split, and that equality at $Y=W$ is forced by degree-zero homogeneity at every critical point. Drop or rewrite the "GENERAL FORM ... CARRIED ONLY AS A QUOTATION" box accordingly. Change "$L_e$-spectrum" to "Rayleigh quotient" in the agreement paragraph.
3. **[notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) and [Lemma L24](../findings/second-order.md)'s prior-art paragraph**: the inequality is $2L_c-1\le c\otimes c/|c|^2$; the source's printed $c\otimes c$ drops the normalisation and is false at $y=c$ whenever $|c|<1$, which is the case here. Note it as a source misprint, since the paper's own equation (56) gives the corrected form.

## What survives

W2's computation, W1 as a true statement, W4's identification of $c$ with I12's $\rho$, and F46's headline that L124(iii) and the unrestricted bound do not compose into an exclusion. Everything supporting that headline, the constant $4$, the value $c=1$, the claim that nothing is excluded, and the open problem it hands forward, is wrong.
