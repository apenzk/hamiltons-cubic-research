# Review r486, Lemma L21 ($\alpha \le 1/3$ in every dimension)

**Status: PLAUSIBLE**, exhaustion CONFIRMED and now proved (F1, F2); the $n$-independence of the four $F_\lambda$ matrices remains the one unproved, load-bearing input, and it reduces to the trivial $20\times20$ block.

Reviewer r486, independent audit. Target: [Lemma L21](../findings/route-a.md), the sole unproved input to [Lemma L20](../findings/route-a.md).

## Attack plan

1. Read [conventions.md](../findings/conventions.md) critically.
2. Read the L21 block and L20 in full.
3. The exhaustion table: identify the two unnamed "higher types", compute their dimensions, check the sum against $\dim\mathrm{Weyl}_{12} = 1638$.
4. The four $F_\lambda$ spectra: decide the $n$-stability question.
5. Sharpness of $1/3$.
6. Does the block contain its proof?
7. Citation audit.

## Findings

_(appended as reached)_

---

### F1, The two unnamed types are $[2,1]$ and $[2,2]$, and the $940$ is exactly theirs. **Exhaustion CONFIRMED, and now proved rather than asserted.**

Derived by branching, by hand, then screened arithmetically. Write $m=n-4$, $G=SO(m)$, and split $\Lambda^2\mathbb R^n=A\oplus B\oplus C$ with

$$A=\Lambda^2\mathbb R^4\ (6\cdot\text{triv}),\qquad B=\mathbb R^4\otimes\mathbb R^m\ (4\cdot\text{vec}),\qquad C=\Lambda^2\mathbb R^m\ (1\cdot[1,1]).$$

$\mathrm{Weyl}_n=V^{O(n)}_{[2,2]}$, and $S^2(\Lambda^2\mathbb R^n)=V_{[2,2]}\oplus V_{[2]}\oplus V_{[0]}\oplus V_{[1^4]}$, i.e. $\mathrm{Weyl}_n=S^2(\Lambda^2\mathbb R^n)\ominus S^2\mathbb R^n\ominus\Lambda^4\mathbb R^n$. *(Dimension check at $n=12$: $1638+77+1+495=2211=\binom{66}{2}+66$.)* Counting $G$-multiplicities blockwise:

| $G$-type | $S^2(\Lambda^2\mathbb R^n)$ | $-\,S^2\mathbb R^n$ | $-\,\Lambda^4\mathbb R^n$ | $=\dim M_\lambda$ |
| --- | --- | --- | --- | --- |
| trivial | $21_{S^2A}+10_{S^2B}+1_{S^2C}=32$ | $11$ | $1$ | $\mathbf{20}$ |
| vector | $24_{A\otimes B}+4_{B\otimes C}=28$ | $4$ | $4$ | $\mathbf{20}$ |
| $[1,1]$ | $6_{A\otimes C}+6_{S^2B}=12$ | $0$ | $6$ | $\mathbf{6}$ |
| $[2]_0$ | $10_{S^2B}+1_{S^2C}=11$ | $1$ | $0$ | $\mathbf{10}$ |
| $[1,1,1]$ | $4_{B\otimes C}$ | $0$ | $4$ | $\mathbf{0}$ |
| $[1^4]$ | $1_{S^2C}$ | $0$ | $1$ | $\mathbf{0}$ |
| $\mathbf{[2,1]}$ | $4_{B\otimes C}$ | $0$ | $0$ | $\mathbf{4}$ |
| $\mathbf{[2,2]}$ | $1_{S^2C}$ | $0$ | $0$ | $\mathbf{1}$ |

The first four rows reproduce the block's own $\dim M_\lambda=20,20,6,10$ **independently of it**. The two survivors are $[2,1]$ (the hook, multiplicity $4$) and $[2,2]$ (multiplicity $1$), **exactly two higher types**, as the row says. Their dimensions are $\dim V_{[2,1]}=m\binom m2-\binom m3-m$ and $\dim V_{[2,2]}=\tfrac{m(m+1)(m+2)(m-3)}{12}$.

At $n=12$, $m=8$: $\dim V_{[2,1]}=160$, $\dim V_{[2,2]}=300$, so the two carry $4\cdot160+1\cdot300=\mathbf{940}$, **exactly the missing $940$**, and $698+940=1638$. The sum closes at every dimension checked ($n=10,12,14,16,20$).

**Verdict on the first target: the table does exhaust, the row is right, and the record can now say why.** Two remarks a repair should carry:

- $\Lambda^3\mathbb R^m$ and $\Lambda^4\mathbb R^m$ each occur in $S^2(\Lambda^2\mathbb R^n)$ and are **cancelled exactly** by $\Lambda^4\mathbb R^n$. That cancellation is why the count is *two* and not *four*, and it is the only non-obvious step.
- The named four also come out right, so the "$698$" is not an accident of a wrong $\dim M$.

### F2, "$0$ throughout" on those $940$ dimensions is **provable, in three lines**, and the record merely asserts it.

$F_u(h)=\tfrac12(uh+hu)+u\#h$ with $u=W_{\mathbb{CP}^2}$ supported in $A$.

- **Anticommutator.** $\tfrac12(uh+hu)$ has $(X,Y)$-block $\tfrac12(u_A h_{AY}\delta_{XA}+h_{XA}u_A\delta_{YA})$, so it *reads* only $h_{AA},h_{AB},h_{AC}$ and *writes* only into $AA,AB,AC$.
- **Sharp product.** $(u\#h)_{ab}\sim\sum c_{ace}c_{bdf}(u_{cd}h_{ef}+h_{cd}u_{ef})$ forces $c,d\in A$. In $\mathfrak{so}(n)=A\oplus B\oplus C$ the brackets grade as $[A,A]\subset A$, $[A,B]\subset B$, $[A,C]=0$, the last because $\mathfrak{so}(4)$ and $\mathfrak{so}(m)$ commute. So $c_{ace}\neq0$ with $c\in A$ forces $a,e$ **both** in $A$ or **both** in $B$, and likewise $b,f$. Hence $u\#h$ reads only $h_{AA},h_{AB},h_{BB}$ and writes only into $AA,AB,BB$.
- **Where the two types live.** By F1's table, $[2,1]$ occurs in $S^2(\Lambda^2\mathbb R^n)$ **only** in $B\otimes C$ and $[2,2]$ **only** in $S^2C$. Neither block is read, and neither type occurs in any block written ($AA,AB,AC$ carry trivial, vector, $[1,1]$; $BB$ carries trivial, $[2]_0$, $[1,1]$).

Therefore $F_u$ annihilates the $[2,1]$ and $[2,2]$ isotypic components outright: $F_{[2,1]}=F_{[2,2]}=0$, **in every dimension, with no stable-range hypothesis and no computation.** The bound $\alpha\le\tfrac13$ never has to look at $940$ of the $1638$.

*This is the strongest thing in the audit: it converts the block's weakest row into its most robust one, and it does not go through the exact-diagonalisation obligation at all.*

### F3, The internal consistency of the whole table, which passes **and only closes because of F2**

Assembling the four tabulated spectra with $\dim V_\lambda$ at $n=12$ and putting the $940$ at $0$:

| $\lambda(F_u)/\theta^*$ | $1$ | $\tfrac12$ | $\tfrac13$ | $0$ | $-\tfrac16$ | $-\tfrac12$ | $-1$ |
| --- | --- | --- | --- | --- | --- | --- | --- |
| multiplicity at $n=12$ | $1$ | $34$ | $136$ | $1161$ | $272$ | $32$ | $2$ |

Three checks, all passing:

- **Total $=1638=\dim\mathrm{Weyl}_{12}$.** This is the block's own closing claim ("multiplicities summing to $\dim\mathrm{Weyl}_n$ exactly"). *It closes only if the $940$ sit at eigenvalue $0$*, F2 is what makes the claim true rather than lucky.
- **$\tfrac12$ has multiplicity $2+4m=34=4n-14=\dim\mathcal O$ exactly**, so "the $\tfrac12$-eigenspace *is* the orbit tangent space" is at least dimensionally forced. This is the step [Lemma L134](../findings/route-a.md)'s scope note says carries the weight.
- **$\operatorname{tr}F_u=0$** in these units, an independent identity the table was not fitted to.

Also: each block's tabulated multiplicities sum to its own $\dim M_\lambda$ ($20,20,6,10$). No arithmetic defect anywhere in the four named rows.

### F4, The $n$-stability split: **r484 is right about which obligation is live; r485 proves a true theorem about the wrong object.** REFUTED as an argument, in r485's direction.

**What is classical.** Littlewood's restriction rule $GL_m\downarrow O(m)$ holds without modification when $\ell(\lambda)\le m/2$; with $\ell\le4$ that is $m\ge8$, i.e. $n\ge12$, exactly r485's $m\ge2k$. What it delivers is the **stability of the type set and of $\dim M_\lambda$**. That is precisely what F1 computes, and F1 shows it in fact holds for every $m\ge4$ ($n\ge8$), the $\dim M_\lambda$ count being a polynomial identity in $m$. **So r485's half is true and is now proved outright, one range wider than claimed.**

**What it does not deliver.** $F_\lambda$ is an operator *on* $M_\lambda$, a $20\times20$, $20\times20$, $6\times6$, $10\times10$ matrix of numbers. Nothing in the branching rule constrains its entries. **r484's phrasing is the correct one: the obligation is the $n$-independence of the four matrices, not the location of the stable range.**

**Where r484 overstates.** It reads the exact points at $n=6,8,10$ as wasted for being below $n=12$. They are not. Zero-padding $\mathrm{Weyl}_n\hookrightarrow\mathrm{Weyl}_{n+1}$ is isometric and commutes with $Q$ ([conventions.md](../findings/conventions.md): *"Padding commutes with $Q$"*), hence with $F_u=u\circ(\cdot)$; $F_u$ is self-adjoint, so the image and its complement are both invariant and

$$\operatorname{spec}\big(F_u^{(n)}\big)\ \subseteq\ \operatorname{spec}\big(F_u^{(n+1)}\big)\quad\text{for every }n.$$

So the exact $n=6,8,10$ diagonalisations **permanently certify that $\tfrac13$, $\tfrac12$ and $1$ occur at every larger $n$**, they prove *sharpness*, forever. **But spectral nesting runs upward, and $\alpha\le\tfrac13$ is an upper bound: padding is exactly the wrong direction for it.** The bound at $n\ge12$ therefore rests on the two floating-point points, as r484 says.

**Where the $m$-dependence can actually enter, and hence what an exact argument needs.** By F2's support lemma $F_u$ reads only $h_{AA},h_{AB},h_{AC},h_{BB}$ and writes only into $AA,AB,AC,BB$. In the vector, $[1,1]$ and $[2]_0$ blocks the $V_\lambda$-factor is carried by an *orthonormal-indexed* copy of $\mathbb R^m$ ($e_i$; $e_i\wedge e_j$; $e_ie_j$ trace-free), no $g_m$ contraction, so no $m$-dependent normalisation. **The trivial block is the exception, and it is the one that matters.** Its $20$ dimensions come from $S^2A$ ($21$, $m$-free) together with $S^2\mathbb R^4\otimes\mathbb R g_m$ ($10$) and one $\mathrm{id}_{\Lambda^2\mathbb R^m}$-type direction, the last two normalised by $g_m/\sqrt m$; and the $11+1$ trace conditions cutting $\mathrm{Weyl}_n$ out of $S^2(\Lambda^2\mathbb R^n)$ mix all three with coefficients carrying $m$. **The trivial block is also where the $1$, both $\tfrac12$'s and three of the $\tfrac13$'s live.**

So, plainly, an exact argument needs one of:

1. **Interpolation with a degree bound.** In any algebraically chosen basis the entries of $F_\lambda(m)$ are rational in $m$ up to a diagonal normalisation, so $\chi_\lambda(x;m)=\det(x-F_\lambda(m))$ has coefficients that are rational functions of $m$. Bound their numerator/denominator degree by $D$; then $D+1$ **exact** evaluations pin $\chi_\lambda$ and agreement forces constancy. *This is the honest form of r485's "one exact diagonalisation retires it", it is $D+1$ diagonalisations, and the record has never bounded $D$.* Two points, exact or not, prove nothing.
2. **A structural $m$-freeness proof for the trivial $20\times20$ block alone**, the other three being reachable by the support lemma. This is the smaller target and is where I would put the effort.

*Neither route is a numerical run in the sense the standing rule restricts: (1) is a finite exact linear-algebra certificate, (2) is a derivation.*

### F5, Sharpness: $\tfrac13$ is attained, in a $136$-dimensional eigenspace, so the constant cannot be improved

At $n=12$ the $\tfrac13$-eigenspace has dimension $3\cdot1+1\cdot28+3\cdot35=136$, all of it transverse to $\mathbb Ru$ and to $T_u\mathcal O$ (distinct eigenvalues of a symmetric operator). **So $\alpha=\tfrac13$ is attained on a large flat, not at a corner**, no sharpening of L20's $0.5748$ is available from this input, and any repair must come from elsewhere.

The margin, screened: with $\alpha\le a$ the bootstrap gives $m\le\psi_a(\varphi)=\dfrac{\cos^3\varphi+3a\cos\varphi\sin^2\varphi}{1-\sin^3\varphi}$, and $\varphi_c(a)=\sup\{\varphi:\psi_a\le1\}$:

| $a$ | $\tfrac13$ | $0.34$ | $0.36$ | $0.40$ | $0.45$ | $0.49$ | $\tfrac12$ |
| --- | --- | --- | --- | --- | --- | --- | --- |
| $\varphi_c(a)$ | $0.574826$ | $0.5501$ | $0.4761$ | $0.3308$ | $0.1582$ | $0.0303$ | $0$ |

This reproduces the block's hedge figures ($0.476$, $0.158$, zero at $\tfrac12$). Two notes:

- **The block's formula $\varphi_c\approx\tfrac32-3a$ is a linearisation at $a=\tfrac12$**, accurate near there and $14\%$ low at $a=\tfrac13$ ($0.500$ against $0.5748$). It errs conservatively, so it is harmless, but it should not be read as a formula.
- **The qualitative hedge "$a<\tfrac12$ suffices" rescues [Lemma L20](../findings/route-a.md) and NOT [Lemma L134](../findings/route-a.md)(a).** L134(a) converts $\alpha\le\tfrac13$ into the *numerical* margin $3\theta^*(a-\tfrac12)=-\theta^*/2=-0.6124$, which degrades linearly in $a$ and vanishes at $\tfrac12$. Any weakening of $\tfrac13$ propagates into L134(b)'s threshold and into [Lemma L135](../findings/route-a.md)'s $\Delta_2\le\tfrac14$ target.

Minor: *"$\psi$ falls to $0.9787$ near $\varphi=0.3927$"*, the minimum is $\psi=0.9785932$ at $\varphi=0.374734$; $0.9787$ is $\psi(\pi/8)$, the value at the stated point. A consistent evaluation, but not the minimum "falls to" promises. It changes nothing.

### F6, The block does not contain the exhaustion at all, and its heading outruns its own section

- **The canonical L21 block's table has FOUR rows and no remainder row.** The *"two higher types … $0$ throughout"* line exists only in the prose section above it; inside the block headed *"canonical statement and proof"* the entire exhaustion claim is the six words **"Only four types carry a nonzero eigenvalue"**, and a reader summing the table's rows reaches $698$ of $1638$ with nothing acknowledging a remainder. *The claim the bound rests on is carried by an unelaborated clause in the canonical block, and by an em-dash row with two blank cells in the section that supports it.*
- **Heading against section.** The block is headed *"holds in every dimension"* and closes *"valid in every dimension rather than checked at particular ones"*. The section immediately above it closes *"The remaining formal obligation is a proof that the stable range begins at $n-4\ge8$ rather than a check at two dimensions"*. **These are not the same claim, and the stronger one is the one in the title.** F1 and F2 close part of the gap (exhaustion, and $F=0$ on $940$, for every $n\ge8$); the four spectra do not.
- **No statement environment.** As with L20, the block gives a motivation paragraph, a table and an argument; the sentence a citer should quote is in the heading.

### F7, Citation audit: one use outside the hypotheses, and the canon entry states the problem instead of the result

| site | use | inside hypotheses? |
| --- | --- | --- |
| [results.md:660](../results.md), L20 statement | *"the eigenvalue bound $\alpha\le\tfrac13$ of Lemma L21"* | **Yes.** |
| [results.md:662](../results.md), L20 caveat box | *"rests on four $F_\lambda$ spectra tabulated at $n=10,12,14$ and asserted stable beyond"* | **Yes**, this is the record's most accurate sentence about L21. |
| [results.md:234](../results.md), glance entry | *"Four spaces … carry every nonzero eigenvalue and do not vary with $n$"* | **Half.** The exhaustion clause is now proved (F1/F2); *"do not vary with $n$"* is stated flatly as fact and is the unproved half. Add the caveat that line 662 carries. |
| [results.md:668](../results.md), the canon's L21 detail entry | Carries the motivation only: Nienhaus needs multiplicity-freeness, *"That hypothesis is avoidable."* | **Defective in a new way.** It has **no statement of the lemma, no table, no bound**. The canon entry for L21 tells the reader what the *problem* was and never what was *proved*. Compare its neighbours L20 and L22, both of which state their conclusion. |
| [route-a.md](../findings/route-a.md), [Lemma L134](../findings/route-a.md)(a) proof | *"reaches it with no multiplicity-free hypothesis **and identically in $n$**"* | **No.** "Identically in $n$" is the unproved half asserted as established. L134's own *Scope of (a)* paragraph retracts to *"tabulated at $n=10,12,14$ and asserted stable beyond"*, so the lemma contradicts itself two paragraphs apart. [r421](REVIEW_r421.md) flagged exactly this and it is still live. And per F5 the hedge does not rescue it: (a) consumes the numerical $\tfrac13$. |
| [LEDGER.md:353](../findings/LEDGER.md) | records the exhaustion gap and the exact-diagonalisation debt as owed | **Yes**, and the exhaustion half is discharged by F1/F2. |

**Vacuity.** Not vacuous. The bound is over a space of dimension $1638-1-34=1603$ at $n=12$, it is attained on a $136$-dimensional subspace, and its consumer L20 returns a tube of positive radius containing the $\mathbb{CP}^2$ orbit.

---

## Verdict: **PLAUSIBLE**

The claim is very likely true and every check I could close came out in its favour, but it is not proved, and the unproved part is load-bearing.

**What I closed, and the record can adopt:**

- The exhaustion is **CONFIRMED and now provable**. The two unnamed types are $[2,1]$ (multiplicity $4$) and $[2,2]$ (multiplicity $1$); at $n=12$ they carry $4\cdot160+300=940$, and $698+940=1638$. The count is a polynomial identity in $m=n-4$, valid as a decomposition for every $m\ge4$.
- *"$0$ throughout"* on those $940$ dimensions is **CONFIRMED and now proved**, in three lines, from the bracket grading $[\mathfrak{so}(4),\mathfrak{so}(m)]=0$: $\operatorname{im}F_u\subseteq AA\oplus AB\oplus AC\oplus BB$, none of which carries $[2,1]$ or $[2,2]$, so by equivariance and self-adjointness both isotypics lie in $\ker F_u$. **No stable-range hypothesis, no computation, every $n\ge8$.**
- The whole table is internally consistent (total $1638$, $\tfrac12$-multiplicity $=4n-14$, trace zero), **and closes only with the $940$ at zero.**

**What remains unproved, stated as the hypotheses L21 actually needs:**

1. $n\ge8$ (so $m\ge4$), for the branching in F1 and the vanishing in F2.
2. **The four $F_\lambda$ matrices, of sizes $20,20,6,10$, have the tabulated rational spectra independently of $m$.** This is the live obligation, it is r484's formulation and not r485's, and it is not retired by any stable-range theorem. Floating point at $n=12,14$; exact at $n=6,8,10$, which by spectral nesting proves sharpness at every $n$ but cannot supply an upper bound.
3. By F4, the $m$-dependence can only enter through the $g_m$-normalisations and the trace-free projection, which reach **only the trivial block**. *The whole remaining obligation is one $20\times20$ matrix*, and it is the block carrying the $1$, both $\tfrac12$'s and three $\tfrac13$'s.

**Recommended repairs, in order.** (i) Put F1's branching table and F2's three-line vanishing argument into the block, replacing the em-dash row and the six-word exhaustion clause. (ii) Give [results.md:668](../results.md) a statement. (iii) Strike *"and identically in $n$"* from [Lemma L134](../findings/route-a.md)(a)'s proof, or qualify it as (a)'s own scope note already does. (iv) Retitle the block to the range its section supports, or state F1/F2 as the part that is unconditional.
