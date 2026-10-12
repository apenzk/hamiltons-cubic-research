# Gate 2 review r370, Lemmas L126 and L127

Brief: break Y1–Y8, arguing from definitions. Analysis only; the one numerical run below is a **screen** of claims recorded here, on objects built for that purpose, and is never cited as evidence for a positive claim.

**Verdicts.**

| claim | verdict | one line |
|---|---|---|
| Y1, $DF(M)=\theta(2L_e-\mathrm{Id})$, branch only at $\tfrac12$ | **PLAUSIBLE** | algebra re-derived and correct; the claim **as briefed** is vacuous, and "branch" is undefined |
| Y2, four-set blocks orbit-free | **CONFIRMED** | re-derived from $[\rho(\xi),M]$; two wording defects, both fillable |
| Y3, $\mu=(n-2)/(2(p-1)(q-1))$, $=\tfrac12$ iff $(3,3)$ | **CONFIRMED** | re-derived from [L121](../findings/second-order.md); matches $\tfrac23$, $\tfrac35$, and $\mu_{2,2}=1$ |
| Y4, no $S^2\times S^q$ is a local maximum | **CONFIRMED** | and the $X\perp W$ hypothesis of [L24](../findings/second-order.md) is met for free |
| Y5, cross-factor block $=\{\tfrac12,0^{n-4}\}$ | **CONFIRMED** | both Ricci relations verified against the record's own $\alpha,\beta,\gamma$ |
| Y6, third type is the orbit, $\theta=(n-1)\lvert\gamma\rvert$ is the $\Pi$-bound | **PLAUSIBLE** | the eigenvector claim holds; **"the $\Pi$-bound" is a mislabel** and a normalisation hypothesis is unstated |
| Y7, within-factor top $(p-2)/(2(p-1))<\tfrac12$ | **PLAUSIBLE** | value correct, **the table row is wrong**: it omits the second factor's $(q-2)/(2(q-1))$ |
| Y8, $E(\tfrac12)$ is exactly the orbit; nondegenerate local max; no non-diagonal branch | **REFUTED as stated** | three independent defects, of which the $\mathcal D_n$ grant is fatal to the proof |

The conclusion of Y8 is **true**, it is [Lemma L27](../findings/nondegeneracy.md), already proved. What is refuted is L127's proof of it, and L127's account of what it adds.

---

## Conventions taken as of record

From [scripts/lib/adversarial_check1.py](../scripts/lib/adversarial_check1.py), `sphere_product_abc`:

```python
    n = p + q
    a = Fr(1, p - 1) - Fr(1, n - 1)
    b = Fr(1, q - 1) - Fr(1, n - 1)
    cc = -Fr(1, n - 1)
```

so $\alpha=\tfrac1{p-1}-\tfrac1{n-1}$, $\beta=\tfrac1{q-1}-\tfrac1{n-1}$, $\gamma=-\tfrac1{n-1}$. The same file records that this is the **only** scale satisfying $\langle Q(W),W\rangle=\lVert W\rVert^2$, and it is in fact the idempotent scale $Q(e)=e$, this matters for Y6 and Y7 and is developed below.

---

## Y5, CONFIRMED, and the Ricci relations are the ones the brief asked me to doubt

Both hold, verified from $\alpha,\beta,\gamma$ rather than accepted:

$$(p-1)\alpha+q\gamma=\Big(1-\tfrac{p-1}{n-1}\Big)-\tfrac q{n-1}=1-\tfrac{p-1+q}{n-1}=0,\qquad (q-1)\beta+p\gamma=1-\tfrac{q-1+p}{n-1}=0 .$$

So the second factor's relation **is** $(q-1)\beta+p\gamma=0$, exactly as Y5 states.

Re-deriving the block independently of the write-up: for $j\in F_1$, $k\in F_2$, [Lemma L122](../findings/second-order.md)'s bracketed form on the index set $(F_1\setminus j)\cup(F_2\setminus k)$ has $M_{ji}+M_{ki}=\alpha+\gamma$ on the first part and $\gamma+\beta$ on the second, $M_{jk}=\gamma$, and $M^{(jk)}$ hollow with entries $\alpha,\beta,\gamma$.

- Sum-zero within $F_1\setminus j$ (multiplicity $p-2$): $M^{(jk)}$-eigenvalue $-\alpha$, block value $\tfrac12[(\alpha+\gamma)-\gamma-\alpha]=0$.
- Sum-zero within $F_2\setminus k$ (multiplicity $q-2$): block value $\tfrac12[(\gamma+\beta)-\gamma-\beta]=0$.
- Constant on each part, cut by $(p-1)s+(q-1)t=0$: I get $\Delta^{(jk)}$-eigenvalue $\gamma(n-2)$ and block value $-\tfrac12(n-1)\gamma=\tfrac12$.

Multiplicities $(p-2)+(q-2)+1=n-3$ exhaust the block, so the spectrum is **exactly** $\{\tfrac12\ \text{simple},\,0^{\,n-4}\}$. Not vacuous: the $0^{n-4}$ is the informative half, and it is what makes the $\tfrac12$ simple.

One wording note: the write-up's "eigenvalue $(p-1)\alpha+(q-1)\gamma$ … turns into $-\gamma$" is the eigenvalue of $\Delta^{(jk)}$, not of $L_e$. The lemma says so; the brief's paraphrase Y5 does not, and read literally Y5 would be wrong.

## Y3, CONFIRMED

Take $i,j\in F_1$, $k,l\in F_2$. Then $A=M_{ij}+M_{kl}=\alpha+\beta$ and $B=C=2\gamma$, so

$$\Sigma=A^2+B^2+C^2-AB-BC-CA=(A-B)^2,\qquad \pm\tfrac12\sqrt\Sigma=\pm\tfrac12(\alpha+\beta-2\gamma)=\pm\tfrac12\Big(\tfrac1{p-1}+\tfrac1{q-1}\Big)=\pm\tfrac{n-2}{2(p-1)(q-1)} .$$

The other splits vanish for a reason the write-up does not give: at a $(4,0)$-split $A=B=C=2\alpha$, and at a $(3,1)$-split $A=B=C=\alpha+\gamma$, so $\Sigma=0$ in both. That exhausts the splits, so "exactly the $(2,2)$-splits" is right.

Against the record's own values: $\mu_{2,4}=\tfrac12(1+\tfrac13)=\tfrac23$ and $\mu_{2,6}=\tfrac12(1+\tfrac15)=\tfrac35$, both match. A third check the brief did not name: [nondegeneracy.md](../findings/nondegeneracy.md) records the $(2,2)$ spectrum as $(-1)^4,(\tfrac12)^4,1^2$ with $1$ **not simple**; $\mu_{2,2}=1$, and the single $4$-set block at $n=4$ supplying $\pm1$ is exactly why. The Diophantine step is trivial and correct ($u=1$ forces $\tfrac1v=0$; $u,v\ge3$ gives $\le\tfrac23$).

## Y4, CONFIRMED, with the hypothesis check the write-up skips

$\mu_{2,q}=q/(2(q-1))>\tfrac12$ is immediate. Two things the write-up leaves implicit and which do hold:

- [Lemma L24](../findings/second-order.md) is a **local** statement (the constrained Hessian is $\le0$ at a local maximum) so "not a local maximum" is licensed, not only "not a maximiser".
- L24 requires the test direction $X\perp W$, the requirement whose neglect killed the first version of [Lemma L124](../findings/second-order.md). Here it is free: $M$ is diagonal, hence lies wholly in the trivial sign character, while the four-set direction lies in a four-index character. So there is **no projection defect** in Y4, unlike in the L124/DERIVE-mx1 setting. The write-up should say this, because a reader who has just read L124's box will expect a $\rho$ or $c$ correction here.

## Y2, CONFIRMED, two defects in the wording

Independently: let $\xi$ act as $\xi e_j=e_k$, $\xi e_k=-e_j$, $\xi e_i=0$ otherwise. On $\Lambda^2$, $\rho(\xi)e_{ji}=e_{ki}$, $\rho(\xi)e_{ki}=-e_{ji}$ for $i\notin\{j,k\}$, and $\rho(\xi)$ kills $e_{jk}$ and every $e_{ab}$ with $a,b\notin\{j,k\}$. With $M$ diagonal,

$$[\rho(\xi),M]\,e_{ji}=(M_{ji}-M_{ki})e_{ki},\qquad [\rho(\xi),M]\,e_{ki}=(M_{ji}-M_{ki})e_{ji},$$

and zero on everything else, i.e. $\propto\sum_{i\notin\{j,k\}}(M_{ji}-M_{ki})\,e_{ji}\odot e_{ki}$, precisely [L122](../findings/second-order.md)'s pair-block basis. So the four-set blocks are orbit-free.

- **The single-generator argument is not the proof.** L126 exhibits one generator and concludes about the whole orbit. The missing line is that $\{\xi_{jk}\}$ spans $\mathfrak{so}(n)$ and $\xi\mapsto[\rho(\xi),M]$ is linear, true, so the gap is one sentence, but the brief was right that the lemma as written makes it plausible rather than proved.
- **"The orbit lies inside the span of the pair blocks" is false as written.** The orbit contains $M$, which lies in $\mathcal D_n$. Only $T_M(O(n)\cdot M)$ lies in the span of the pair blocks. Harmless in use, since only the tangent enters $\ker DF$.

**The group count is right**, contrary to the brief's suspicion. The stabiliser algebra is exactly $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$: the within-factor generators kill $M$ because $M_{ji}=M_{ki}$ for $j,k$ in one factor, and the $pq$ cross generators have images in $pq$ *distinct* pair blocks, each nonzero ($\gamma-\alpha=-1/(p-1)\ne0$), hence linearly independent. So $\dim\mathcal O=\binom n2-\binom p2-\binom q2=pq$ exactly, not merely at least. L126 asserts this without the independence step.

## Y1, PLAUSIBLE; the algebra is right, the statement as briefed is vacuous

The derivative is correct. $P$ cubic gives $DP(M)Y=3\langle Q(M),Y\rangle=3\theta\langle M,Y\rangle$, so $D(P(W)W)(M)Y=3\theta\langle M,Y\rangle M+\theta Y$, and on $Y\perp M$,

$$DF(M)Y=2M\circ Y-\theta Y=\theta(2L_eY-Y).$$

Three checks it passes: it is a self-map of $M^\perp$, since $\langle DF(M)Y,M\rangle=2\theta\langle Y,M\circ e\rangle=2\theta\langle Y,M\rangle=0$; the radial direction is *not* covered, $DF(M)M=-2\theta M$, so "on the tangent space" is load-bearing and correctly stated; and $F(W)=0$ with $Q(W)\ne0$ forces $\lVert W\rVert=1$, so the zero set really is the unit critical set.

Two defects:

- **Y1 as briefed is vacuous.** "A branch leaves $M$ only where **some** block carries the eigenvalue exactly $\tfrac12$" is satisfied at *every* critical point with a positive-dimensional orbit, because the orbit directions are exact $\tfrac12$-eigenvectors, L122 proves this itself, and [L24](../findings/second-order.md) says so in its own scope note. The lemma's actual wording is per-block ("leaves $M$ **through a four-set block** only where **that block**…") and is not vacuous. The brief's compression drops the only clause carrying content.
- **"Branch" is undefined and the tangent is assumed to exist.** The step is: $W(t)$ critical, $W(0)=M$, differentiate $F(W(t))=0$ to get $W'(0)\in\ker DF(M)$. That needs $W$ differentiable at $0$. It is recoverable, $\mathrm{Crit}(P)$ is real algebraic, so curve selection supplies an analytic arc with a tangent, but nothing in L126 says so.

## Y6, PLAUSIBLE; the eigenvector is right, "the $\Pi$-bound" is a mislabel

The identification is correct. The orbit direction is $\gamma-\alpha$ on $F_1\setminus j$ and $\beta-\gamma$ on $F_2\setminus k$, hence constant on each part; it satisfies the Ricci cut, since $(p-1)(\gamma-\alpha)+(q-1)(\beta-\gamma)=\gamma[(p-1)+q-p-(q-1)]=0$ using both Ricci relations; and it is nonzero. So it is the third type, and the third type is simple, so the identification is forced rather than merely consistent.

That $\theta=(n-1)\lvert\gamma\rvert$ then follows is genuine, and the $\theta/2$ half is independently sound: $Q$ is $O(n)$-equivariant and $Q(M)=\theta M$, so differentiating along the orbit gives $2M\circ\dot M=\theta\dot M$, i.e. $L_M\dot M=\tfrac\theta2\dot M$, using nothing from the block computation.

**But it is not the $\Pi$-bound.** The $\Pi$-bound is [Lemma L107](../findings/bounds.md), $\theta\le(n-1)\lvert\lambda_{\min}\rvert$, an inequality holding at every critical point. What L127 obtains is its **equality case at one family**, and only because $\gamma$ happens to be the unique negative eigenvalue at $S^p\times S^q$ so that $\lambda_{\min}=\gamma$, a step the write-up does not take. Π-saturation at the catalogued symmetric points is already on the record twice, at [post F40](../findings/fence-posts.md) ("$\theta=(n-1)\lvert\lambda_{\min}\rvert$ holds at every padding-free catalogued point") and via [Lemma L117](../findings/bounds.md). So "**the** $\Pi$-bound, recovered here as a by-product rather than assumed" claims a general bound from a single saturating family. This is the same overclaim shape the record polices elsewhere.

**And a normalisation hypothesis is missing.** L127 says "$M$ the sphere product … with sectional matrix $\alpha,\beta,\gamma$" and never fixes the scale, yet its table compares block values against $\tfrac12$. L121 and L122 give eigenvalues of $L_M$, whose orbit value is $\theta/2$; comparing against $\tfrac12$ is legitimate only when $\theta=1$, i.e. only in the idempotent normalisation $Q(M)=M$. The record's convention does supply it (the $\alpha,\beta,\gamma$ above satisfy $Q(e)=e$) but then $\gamma=-1/(n-1)$ is fixed and $\theta=(n-1)\lvert\gamma\rvert$ reads $\theta=1$, so what the box calls "the check on the whole computation" is the check that the Einstein-normalised Weyl tensor is the algebra's idempotent. That is a real fact (the same file's `sphere_product_abc` docstring records it) and a much smaller one than advertised. Under any other scale the table's threshold column is wrong by a factor of $\theta$.

## Y7, PLAUSIBLE; the value is right, the table row is wrong

Re-deriving the within-factor block ($j,k\in F_1$) from L122 gives the full spectrum, not just the top:

$$\Big\{\tfrac{p-2}{2(p-1)}\ \text{simple},\quad 0^{\,p-3},\quad (-\mu)^{\,q-1}\Big\},$$

by the same three eigenvector types, with the constant-on-each-part value $\tfrac12(p-2)(\alpha-\gamma)=\tfrac{p-2}{2(p-1)}$, and its consistency across the two parts is *exactly* the Ricci relation $(p-1)\alpha+q\gamma=0$, which is a fourth independent confirmation of Y5. The top is $<\tfrac12$ at every $p$ since $(p-2)/(p-1)<1$. Orbit-freeness holds because $M_{ji}=M_{ki}$ on both parts.

**The defect:** the table gives a single value $\tfrac{p-2}{2(p-1)}$ for a row of count $\binom p2+\binom q2$ that contains **two** families. The $\binom q2$ blocks inside the second factor top at $\tfrac{q-2}{2(q-1)}$, strictly larger whenever $q>p$. At $(3,4)$ the true within-factor tops are $\tfrac14$ and $\tfrac13$; the table prints only $\tfrac14$. The conclusion survives (both are $<\tfrac12$) but the row as written is false, and it is the row a reader would quote.

## Y8, REFUTED as stated

The conclusion is true. The proof offered for it is not a proof, and the paragraph explaining what it adds is wrong.

### (1) The $\mathcal D_n$ row is a hole, and "granted by [README.md](../README.md)" does not fill it

L127's table has four rows; the fourth reads "$\mathcal D_n$ | $1$ | the diagonal locus | granted by README.md". Both of Y8's conclusions quantify over **all** blocks:

- "the $\tfrac12$-eigenspace of $L_e$ is **exactly** the orbit", needs $\tfrac12\notin\sigma(L_e|_{\mathcal D_n\cap W^\perp})$;
- "**nondegenerate local maximum** modulo its orbit", needs $\sigma(L_e|_{\mathcal D_n\cap W^\perp})<\tfrac12$ strictly.

What README grants is: *"the result holds when $P$ is restricted to curvature operators that are diagonal with respect to a suitable basis"*, a **global maximisation** statement over the diagonal locus. That is a different kind of object from a **local spectral** statement at a named point, and the mismatch bites twice:

- It says nothing at all about the **unbalanced** $S^p\times S^q$, which are not the diagonal maximiser. Y8 is stated for all $p,q\ge3$.
- Even at the balanced product, "local maximum within $\mathcal D_n$" yields $\lambda\le\tfrac12$ on $\mathcal D_n\cap W^\perp$, never $\lambda<\tfrac12$. So the grant cannot deliver "**exactly** the orbit" even where it applies.

This is not a repair-in-passing: it is the row that decides the lemma. **The repair is available and is what L127 should have written.** The diagonal block's $L_e$-spectrum is

$$\sigma\big(L_e|_{\mathcal D_n}\big)=\Big\{1,\ \Big(\tfrac{p-2}{2(p-1)}\Big)^{p-1},\ \Big(\tfrac{q-2}{2(q-1)}\Big)^{q-1},\ (-\mu)^{(p-1)(q-1)},\ 0^{\,\text{rest}}\Big\},$$

so $\lambda_{\max}(L_e|_{\mathcal D_n\cap W^\perp})=\tfrac{\max(p,q)-2}{2\max(p,q)-2}<\tfrac12$ at every $p,q$. Dimensions check: the named eigenvalues account for $1+(p-1)+(q-1)+(p-1)(q-1)=pq$ directions, and the zeros make up the remaining $\tfrac{n(n-3)}2-pq$, which is $0,2,4,5$ at $(3,3),(3,4),(4,4),(3,5)$. The whole list is the diagonal part of [L27](../findings/nondegeneracy.md)'s ten summands, $\langle W\rangle$, the diagonal traceless parts of $S^2_0(\mathbb R^p)$ and $S^2_0(\mathbb R^q)$, of $S^2_0\otimes S^2_0$, and of the four zero summands. **Which is the problem in (2).**

### (2) The novelty claim is false, and the hole in (1) is filled only by the lemma L127 says it supersedes

L127's classification paragraph states that [nondegeneracy.md](../findings/nondegeneracy.md) "records sphere-product nondegeneracy as **measured**, $\dim E(\tfrac12)=\text{orbit}$ at $S^4\times S^4$ padded and at $S^5\times S^7$", and that "what is new is a proof for all $p,q$ and all $n$".

That is not what the record holds. **[Lemma L27](../findings/nondegeneracy.md) is already exactly that proof**, over exactly the same range ($p,q\ge3$, $(p,q)\ne(3,3)$), for all $n$: Nienhaus Proposition 4.6's ten-summand $O(p)\times O(q)$ decomposition, multiplicity-free, so $L_e$ is a scalar on each summand by Schur; the ten scalars listed in closed form; $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0$; both former grants (the $\mathrm{Weyl}_p$ and $X_p\otimes\mathbb R^q$ vanishings, and multiplicity-freeness at $p,q\le4$) discharged; audited by Reviewers 34 and 35. L127 cites the *numerical table above L27* and describes the file as if L27 were not in it.

Worse than a citation slip: the summand list in L27 is **the only thing on the record that closes L127's own $\mathcal D_n$ row**. So L127 is not an independent proof of a previously measured fact; it is a second route whose gap is patched by the first route. It remains valuable, the block attribution is genuinely new, and two independent derivations of the same spectrum is worth having, but the classification paragraph inverts the dependency.

The two accountings do agree, which is the useful content. Summing my block spectra:

| eigenvalue | from blocks | L27 summand |
|---|---|---|
| $1$ | $\mathcal D_n$ | $\langle W\rangle$, $\dim1$ |
| $\tfrac12$ | $pq$ cross-factor pair blocks, one each | $\mathbb R^p\otimes\mathbb R^q$, $\dim pq$ |
| $\tfrac{p-2}{2(p-1)}$ | $\binom p2$ within-factor blocks $+\ (p-1)$ from $\mathcal D_n$ | $S^2_0(\mathbb R^p)$, $\dim\tfrac{(p+2)(p-1)}2$ |
| $+\mu$ | $\binom p2\binom q2$ four-set $(2,2)$-splits | $\Lambda^2(\mathbb R^p)\otimes\Lambda^2(\mathbb R^q)$ |
| $-\mu$ | four-set $+$ within-factor $+\ (p-1)(q-1)$ from $\mathcal D_n$ | $S^2_0\otimes S^2_0$ |
| $0$ | non-$(2,2)$ four-sets, cross-factor tails, within-factor tails, $\mathcal D_n$ rest | $\mathrm{Weyl}_p\oplus\mathrm{Weyl}_q\oplus X_p\otimes\mathbb R^q\oplus X_q\otimes\mathbb R^p$ |

At $(3,3)$ this reproduces the record's $1,\ \tfrac12^{18},\ \tfrac14^{10},\ 0^{30},\ -\tfrac12^{25}$ in every multiplicity, $\tfrac12$: $9$ four-set $+\ 9$ cross-pair; $\tfrac14$: $6$ within-pair $+\ 4$ from $\mathcal D_6$; $-\tfrac12$: $9+12+4$; $0$: $12+18$, with $\mathcal D_6=\{1,\tfrac14^4,-\tfrac12^4\}$ and total trace $0$. So Y8's block accounting **does** reproduce every multiplicity, as the brief asked, but only once the $\mathcal D_n$ row is supplied from outside L127.

### (3) "No non-diagonal critical point branches off it" needs machinery that is nowhere stated

$\ker DF(M)=T_M\mathcal O$ gives only that any analytic arc of critical points through $M$ is **tangent to** the orbit. Concluding that $\mathrm{Crit}(P)$ is locally *equal to* the orbit needs more: an equivariant slice (legitimate, $O(n)$ is compact, $F$ is equivariant, $DF(M)$ is self-adjoint) plus Lyapunov–Schmidt on the slice, or the record's own third-order obstruction $\Psi$. None of it appears.

The record knows this is not free. [nondegeneracy.md](../findings/nondegeneracy.md) warns at the two-block plateau that a vanishing second-order obstruction "is consistent with a genuine critical manifold though it does not establish one, the obstruction proves no branch when it fails, rather than a branch when it vanishes", and elsewhere does the full third-order tangent-cone computation precisely because the kernel exceeded the orbit. L127 asserts the conclusion in one clause.

Two further points on this row:

- The gap is **fillable in three lines** when the kernel is exactly the orbit, so this defect alone would rate PLAUSIBLE. It compounds with (1): the slice argument needs $\ker DF(M)=T_M\mathcal O$, which is what (1) leaves unproved.
- The qualifier "non-diagonal" does **not** immunise the claim against (1). If $\mathcal D_n$ carried a $\tfrac12$-eigenvector $v$ (which L127 does not exclude), a branch could be tangent to $v$ and still leave the diagonal locus at second order, $W(t)=M+tv+t^2z+\dots$ with $z$ non-diagonal. So "no non-diagonal critical point branches off it" depends on the $\mathcal D_n$ row too.

---

## The four error shapes, checked and reported negative where negative

- **Frame-dependence, no error found, one exposure worth a scope line.** $\Sigma_{ijkl}$ is frame-dependent, as [L124](../findings/second-order.md)'s own box establishes, so L126's criterion "$\Sigma_{ijkl}=\theta^2$" is a statement relative to a chosen diagonalising frame. It does not become an invariant claim, because the invariant fact ($\tfrac12\in\sigma(L_e)$) holds at every critical point. The block *attribution* is frame-relative bookkeeping, and everything L126/L127 concludes is stated relative to the named frame, so nothing is smuggled. The one thing I did not verify is that $S^p\times S^q$'s diagonalising frames form a single $O(p)\times O(q)$ orbit up to factor swap; if they did not, the four-set spectrum could differ between diagonalising frames and L126's threshold would need a "for some frame" quantifier. Worth a line in the lemma.
- **Category error, none found.** L126 cites L121 for the four-set block of $L_M$ on $\mathrm{Sym}^2(\Lambda^2)$ and uses it as a block eigenvalue, not as an invariant plane of $W$ on $\Lambda^2$; the trap L124's box records is avoided. L127 cites L122 for the pair block on $\mathrm{Sym}^2(\Lambda^2)$ and its "equitable two-block partition" is a partition of the *pair-block index set* $(F_1\setminus j)\cup(F_2\setminus k)$, on which $\Delta^{(jk)}$ genuinely is a graph Laplacian, not a partition of $\mathbb R^n$. The orbit tangent $[\rho(\xi),M]$ I computed lands in $\mathrm{Sym}^2(\Lambda^2)$, the same space as the blocks. Every citation lands correctly.
- **Miscounting a group, none found, one missing step.** $\dim SO(n)=\binom n2$, stabiliser algebra exactly $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ (proved above by the independence of the $pq$ cross-generator images), orbit $pq$, matching the $pq$ cross-factor blocks and the $9$ at $(3,3)$. L126 asserts the stabiliser rather than proving it, which makes $pq$ a lower bound as written.
- **Vacuity.** Y1 as briefed is vacuous (see above); the lemma's per-block form is not. Y5 is not vacuous, the $0^{n-4}$ is what makes the $\tfrac12$ simple, and simplicity is what makes Y6's identification of the orbit forced.

---

## Screen

Reported as a screen of the claims recorded above, on objects built here for that purpose; it is evidence for nothing positive. Structure constants of $\mathfrak{so}(n)$ on $\Lambda^2$ built from matrix commutators, $Q(W)=W^2+W^\#$, $\mathrm{Weyl}_n$ as the null space of first Bianchi plus Ricci, $L_e$ as a matrix in an orthonormal Weyl basis.

- $\lVert Q(e)-e\rVert_\infty\le1.1\times10^{-16}$ at all four $(p,q)$, confirming the $\alpha,\beta,\gamma$ above are the idempotent scale, which is the normalisation hypothesis Y6 needs and L127 omits.
- Full spectra: $(3,3)$ gives $1,\tfrac12^{18},\tfrac14^{10},0^{30},-\tfrac12^{25}$, reproducing the record's table; $(3,4)$ gives $1,\tfrac12^{12},\tfrac5{12}^{18},\tfrac13^{9},\tfrac14^{5},0^{78},-\tfrac5{12}^{45}$; $(4,4)$ gives $1,\tfrac12^{16},\tfrac13^{54},0^{148},-\tfrac13^{81}$; $(3,5)$ gives $1,\tfrac12^{15},\tfrac38^{44},\tfrac14^{5},0^{165},-\tfrac38^{70}$. Every multiplicity agrees with the hand accounting in (2), and $\dim E(\tfrac12)=pq$ in all four.
- $\sigma(L_e|_{\mathcal D_n})$ agrees with the closed form in (1) at all four, including $\dim\mathcal D_n=n(n-3)/2$ and the multiplicities $p-1$, $q-1$, $(p-1)(q-1)$.
- $(3,4)$ is the case that exhibits Y7's table defect: both $\tfrac14$ and $\tfrac13$ are present.

## What I would ask for before this row moves

1. Replace the $\mathcal D_n$ row's grant with the closed form, or state the lemma conditionally on it. As written the lemma's headline conclusions do not follow from its own table.
2. Rewrite the classification paragraph: L27 already proves the conclusion analytically for the same range; L127 is a second route and a block attribution, and its $\mathcal D_n$ row currently depends on L27.
3. Add the slice/Lyapunov–Schmidt sentence to "no non-diagonal critical point branches off it", or weaken it to "every branch through $M$ is tangent to the orbit".
4. Split the within-factor table row into its two families, or state its top as $\frac{\max(p,q)-2}{2\max(p,q)-2}$.
5. Demote "the $\Pi$-bound, recovered" to "$\Pi$-saturation at $S^p\times S^q$, recovered", and cite [post F40](../findings/fence-posts.md) / [L117](../findings/bounds.md), which already carry it.
6. State the normalisation $Q(M)=M$ that the table's $\tfrac12$ threshold requires, and add the one line for Y2 that $\{\xi_{jk}\}$ spans $\mathfrak{so}(n)$ and that the stabiliser is exactly $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$.
