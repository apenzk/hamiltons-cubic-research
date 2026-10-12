# Reviewer 95, fence posts 1–2f, with 2e2, 2f and the invariant-theory closure as the target

**No numerical checking was used in this report.** Every computation is exact: `sympy` `Rational`/`Integer`/`sqrt` symbolic algebra and integer enumeration, or hand algebra. No floating point, no sampling, no solvers, no optimisation. The one `evalf` call in the working scripts was a sort key over already-exact expressions; every reported comparison is an exact `sign(simplify(...))`.

Worked cold: the sharp map, the adjugate identity, the collapse criterion and the orbit-count arithmetic were derived from definitions before [fence-posts.md](../findings/fence-posts.md) was opened.

---

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1a | The formula $(R^\#)_{ab}=\tfrac12c_{a\gamma\delta}c_{b\varepsilon\zeta}R_{\gamma\varepsilon}R_{\delta\zeta}$ is this project's $\#$ | **CONFIRMED** |
| 1a' | "$\operatorname{adj}(R)_{ij}=\tfrac12\varepsilon_{iab}\varepsilon_{jcd}R_{ac}R_{bd}$, residual exactly $0$" | **REFUTED as stated** (true only for symmetric $R$) |
| 1b | "$\#$ **is** the adjugate $\iff$ $c$ **is** the volume form $\iff\dim\mathfrak g=3$" | **REFUTED as stated**; a corrected version is CONFIRMED |
| 1c | "That is the whole of the $n=4$ phenomenon, at the root"; 2e2 "subsumes 2c and 2f" | **REFUTED** (over-reading; the Weyl trace-free input is missing) |
| 2 | Post F2f collapse criterion, the "exactly when" | **REFUTED in both directions** |
| 2' | $\mathfrak{su}(3)$: $T=f^2$ takes values $\{\tfrac14,\tfrac34,1\}$ | **CONFIRMED** exactly |
| 2'' | "$28$ of its $56$ triples carrying $T=0$" | **REFUTED**, it is $47$ of $56$ |
| 3a | Orbit-finiteness boundary $N\le8$, and the attributions | **CONFIRMED** (necessary half proved here; sufficiency from secondary sources) |
| 3b | "Any argument reaching $\theta$ through a classification of $c$ therefore cannot exist" | **REFUTED, badly overstated** |
| 4 | "Three independent appearances of the $n=4$ boundary" | **REFUTED** |
| 5a | Post F2c display $\langle W^\#,W\rangle=3(\det W^++\det W^-)=\operatorname{tr}((W^+)^3)+\operatorname{tr}((W^-)^3)$ | **REFUTED**, off by a factor $2$; the stated constant $2\operatorname{tr}(W^3)$ is right |
| 5b | The $n=6$ isospectral pair, $P=0$ against $P=24$ | **CONFIRMED and strengthened** ($P\in\{-24,0,24\}$) |
| 5c | $\lvert W\rvert=2\lVert W\rVert$ | **CONFIRMED** |
| 5d | "$\tfrac{\sqrt6}4$ against $\lvert W\rvert^3$ … becomes $\tfrac{\sqrt6}2$" | **UNPROVEN** as written (factor $4$ unaccounted); the target constant is safe by an independent route |
| 5e | $1+\tfrac{\sqrt3}6$ as a "floor" ([plan.md](../plan.md) line 26) | **REFUTED at $n=4,5,6$** |

---

## 1. The sharp map as adjugate (post F2e2)

### 1a. The formula is right for this project's convention, CONFIRMED

Built $\mathfrak{so}(n)$ from scratch in the pair basis $b_{ij}=E_{ij}-E_{ji}$ with the Böhm–Wilking inner product $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(XY)$, which makes that basis orthonormal, and set $c_{abd}=\langle[b_a,b_b],b_d\rangle$. The author's formula then reproduces the project's own gatekeeper $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ **exactly**:

| $n$ | $3$ | $4$ | $5$ | $6$ |
|---|---|---|---|---|
| $\mathrm{Id}^\#/\mathrm{Id}$ | $1$ | $2$ | $3$ | $4$ |

with every off-diagonal entry exactly $0$. It also reproduces the diagonal identity $\langle\mathrm{Id}^\#,\mathrm{Id}\rangle=\binom n2(n-2)$ ($=60$ at $n=6$), and at $n=4$ it gives $\langle Q(W),W\rangle=3\operatorname{tr}(W^3)$ on a *fully general* $\mathrm{Weyl}_4$ (see §5a). So the formula, with the $\tfrac12$, agrees with [rsharp_basis_free.py](../scripts/rsharp_basis_free.py)'s convention and with Böhm–Wilking.

**One normalisation caveat worth recording.** The prefactor $\tfrac12$ is not convention-free. Under $\langle X,Y\rangle=\operatorname{tr}(X^{\mathsf T}Y)$ (orthonormal basis $b_{ij}/\sqrt2$) the same formula gives $\mathrm{Id}^\#=\tfrac{n-2}2\mathrm{Id}$. The post does not name the metric normalisation, and the whole "$\#$ **is** the adjugate" claim turns on exactly this scale, see 1b.

### 1a'. The quoted adjugate identity is false for general $R$, REFUTED as stated

The post writes "the classical identity $\operatorname{adj}(R)_{ij}=\tfrac12\varepsilon_{iab}\varepsilon_{jcd}R_{ac}R_{bd}$, verified here symbolically, residual exactly $0$". For a generic $3\times3$ $R$ the residual is **not** zero. Exactly:

$$\Big[\tfrac12\varepsilon_{iab}\varepsilon_{jcd}R_{ac}R_{bd}-\operatorname{adj}(R)\Big]_{01}=R_{01}R_{22}-R_{02}R_{21}-R_{10}R_{22}+R_{12}R_{20}\ne0,$$

and the residual matrix is antisymmetric, vanishing precisely when $R$ is symmetric. The correct general identity pairs the index slots the other way, $\operatorname{adj}(R)_{ij}=\tfrac12\varepsilon_{iab}\varepsilon_{jcd}R_{ca}R_{db}$. In context $R$ *is* symmetric, so nothing downstream breaks, but "residual exactly $0$" is true only under a hypothesis the post never states, and a reader reproducing the check with a generic matrix will not get $0$.

### 1b. The "iff" chain is false as written; a corrected version holds, REFUTED / repaired

Three separate failures in the displayed chain $\#=\operatorname{adj}\iff c=\varepsilon\iff\dim\mathfrak g=3$.

**(i) $\dim\mathfrak g=3$ does not give $c=\varepsilon$.** Total antisymmetry of $c$ makes it a $3$-form, so on a $3$-dimensional metric Lie algebra $c=\lambda\varepsilon$ for *some* $\lambda\in\mathbb R$, and then $R^\#=\lambda^2\operatorname{adj}(R)$. Taking $\lambda=0$ (abelian $\mathbb R^3$) gives $\#\equiv0$, which is not the adjugate. So the second "$\iff$" needs $\lambda=\pm1$, i.e. a normalisation choice, and is false without it.

**(ii) The post's own headline case violates it.** The chirality subalgebras of $\mathfrak{so}(4)$ are $3$-dimensional, and in the orthonormal self-dual/anti-self-dual frame $\tfrac1{\sqrt2}(b_{01}\pm b_{23})$ etc. I computed the transported structure constants exactly:

$$c_{012}^{\,\mathrm{SD}}=-\sqrt2,\qquad c_{345}^{\,\mathrm{ASD}}=+\sqrt2,\qquad\text{all cross-block }c=0 .$$

Hence on each chirality block $\#=(\sqrt2)^2\operatorname{adj}=\mathbf{2\operatorname{adj}}$, verified on a general symmetric traceless $A$: $\#-2\operatorname{adj}=0$ while $\#-\operatorname{adj}\ne0$. **So at $n=4$ (the case the post exists to explain), "$\#$ is the adjugate" is literally false.** It is twice the adjugate. This is the same factor $2$ that makes post F2c's display wrong (§5a); the two errors have a single root, namely that "$c$ **is** the volume form" is being asserted where only "$c$ is *a multiple of* the volume form" holds.

**(iii) A cleaner and stronger proof of the surviving direction.** The forward implication needs no volume form at all, only a degree count:

> $R\mapsto R^\#$ is homogeneous of degree $2$ in $R$ for every $\mathfrak g$; $R\mapsto\operatorname{adj}(R)$ on $N\times N$ is homogeneous of degree $N-1$ and is not identically zero. Two nonzero homogeneous polynomial maps of unequal degree cannot agree, so $\#\propto\operatorname{adj}$ forces $N-1=2$, i.e. $N=3$.

The structural reason behind the degree count is worth stating because it is the actual mechanism: $R^\#=\mathrm{ad}\circ\Lambda^2R\circ\mathrm{ad}^*$, where $\mathrm{ad}:\Lambda^2\mathfrak g\to\mathfrak g$. The adjugate is the top compound; $\#$ is the *second* compound compressed along the bracket. These coincide exactly when $\Lambda^2\mathfrak g$ and $\mathfrak g$ have the same dimension, $\binom I2=N$, i.e. $N=3$. **The correct statement is therefore**

$$\#=\kappa\operatorname{adj}\text{ for some }\kappa\ne0\iff\dim\Lambda^2\mathfrak g=\dim\mathfrak g\iff\dim\mathfrak g=3,\qquad\kappa=\lambda^2 .$$

That is a genuine result and it is *better* than what the post claims, because it is normalisation-free.

### 1c. Could $\#$ be adjugate-like in higher dimension? Yes, and the post's own example is one

The post reads its "iff" as closing off higher dimensions. It does not. $\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ has $\dim=6$ and $\#$ is *exactly* a pair of scaled adjugates. Iterating, $\mathfrak{so}(3)^{\oplus k}$ has $\dim=3k$ arbitrarily large with $\#$ block-diagonal and equal to $\lambda_i^2\operatorname{adj}$ on each factor. **So "adjugate-like" survives to every dimension.** What fails from $n\ge5$ is not dimension but **simplicity**, $\mathfrak{so}(n)$ admits no decomposition into $3$-dimensional ideals. The post gets to the right place ("$>3$ **and simple** for every $n\ge5$") but files it under a dimension criterion that its own $n=4$ example refutes.

**And the conclusion over-reaches.** "That is the whole of the $n=4$ phenomenon, at the root" and "subsumes 2c and 2f" are both too strong. $\langle\operatorname{adj}A,A\rangle=3\det A$ holds for *every* $A$; $\operatorname{tr}(A^3)=3\det A$ needs $\operatorname{tr}A=0$. The passage from "$\#$ is a scaled adjugate" to "$\theta$ is spectral" therefore consumes a second, independent ingredient: **each chirality of a Weyl tensor is separately trace-free**. That is a curvature-tensor fact (the Ricci-flatness of $\mathrm{Weyl}_4$), not a Lie-algebra fact, and 2e2 contains no trace of it. Post F2f *does* record it as its condition 2. So 2e2 does not subsume 2f; it drops one of its two hypotheses.

---

## 2. The collapse criterion (post F2f)

The post asserts: $\theta$ reduces to a multiple of $\sum\lambda^3$ **exactly when** the frame splits into blocks with (1) $T$ supported inside blocks, (2) $\sum_{\alpha\in B}\lambda_\alpha=0$ per block, (3) $T$ constant over each block's triples.

### 2.0. The statement is not well posed, and the flaw is structural

No quantifier over $\lambda$ is given. Take the identity to be required on all of $\mathbb R^N$ and it forces $T\equiv0$:

> Let $F=\sum_{\alpha<\beta<\gamma}D_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ be squarefree with $F\in(e_1)$, say $F=e_1G$ with $G=\sum g_{\alpha\beta}\lambda_\alpha\lambda_\beta$. The coefficient of $\lambda_\alpha^3$ in $e_1G$ is $g_{\alpha\alpha}$, forcing $g_{\alpha\alpha}=0$; the coefficient of $\lambda_\alpha^2\lambda_\beta$ is then $2g_{\alpha\beta}$, forcing $g_{\alpha\beta}=0$. Hence $G=0$, $F=0$, and $T$ is constant across **all** $\binom I3$ triples.

So the intended domain must be smaller, and condition (2) *is* that domain, being a condition on $\lambda$ rather than on the frame or on $T$. The "exactly when" therefore has its quantifier supplied by its own conclusion: the variety on which the identity is tested is cut out by the block decomposition being asserted. Any such statement can be neither proved nor refuted until the domain is fixed independently. I read it in the only way that makes it non-vacuous, *there exists a block decomposition such that on $\{\sum_{\alpha\in B}\lambda_\alpha=0\ \forall B\}$ one has $\theta=\kappa\sum\lambda^3$*, and it fails in both directions under that reading.

### 2.1. Sufficiency fails, REFUTED

Conditions (1)–(3) give $T=t_B$ on the triples of block $B$, hence, using $p_3(B)=3e_3(B)$ from condition (2),

$$\theta=\sum_B(1+t_B)\,p_3(\lambda_B),$$

which is a multiple of $\sum\lambda^3$ **only if $t_B$ is the same for every block**. Condition (3) says "constant over each block's triples", it permits $t_B$ to vary between blocks. Exact check at $N=6$ with blocks $\{0,1,2\},\{3,4,5\}$: solving $\theta=\kappa\sum\lambda^3$ on $\{s_1=s_2=0\}$ returns the unique solution $\{\kappa=t_2+1,\ t_1=t_2\}$; for $t_1\ne t_2$ the reduced form is

$$-3\big[(t_1{+}1)(\lambda_0^2\lambda_1+\lambda_0\lambda_1^2)+(t_2{+}1)(\lambda_3^2\lambda_4+\lambda_3\lambda_4^2)\big]\ne\kappa\textstyle\sum\lambda^3 .$$

This is realisable, not a paper case. Two witnesses:

- $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ with the ad-invariant metric scaled differently on the two factors: $c_i=\lambda_i\varepsilon$, $t_i=\lambda_i^2$, all three conditions hold, no collapse.
- $\mathfrak{so}(3)\oplus\mathbb R^m$: the abelian block has $t=0$ (constant, so (3) holds vacuously) against $t=2$ on the $\mathfrak{so}(3)$ block. All three conditions hold, no collapse.

The fix is one clause: **(3′) $T$ constant over the triples of every block, with the same constant across blocks.** At $n=4$ that extra clause is automatic ($t=2$ on both chiralities, by the $\pm\sqrt2$ computed in §1b), so the $n=4$ conclusion is unaffected, but the criterion as printed is false.

### 2.2. Necessity of condition 1 fails, REFUTED by explicit construction

Once $k\ge2$ blocks are present, the ideal $(s_1,\dots,s_k)$ contains **nonzero squarefree cubics**, e.g. $s_1\cdot e_2(B_2)$, so cross-block mass can vanish on the variety without being zero. Explicitly, at $N=6$ with $B_1=\{0,1,2\}$, $B_2=\{3,4,5\}$, set

$$T_{\alpha\beta\gamma}=\begin{cases}\tau&\text{all three in one block}\\ 1&\text{exactly one index in }B_1\\ 0&\text{exactly two indices in }B_1\end{cases}$$

$T$ is totally symmetric and nonnegative for $\tau\ge0$, it satisfies everything a genuine $c^2$ satisfies at this level. Verified exactly: substituting $\lambda_2=-\lambda_0-\lambda_1$, $\lambda_5=-\lambda_3-\lambda_4$,

$$\theta-\big[(1+\tau)\textstyle\sum_\alpha\lambda_\alpha^3\big]=0 .$$

**The collapse happens with $T$ carrying cross-block mass**, because the cross part is exactly $3s_1e_2(B_2)$, which the variety kills. Condition 1 is sufficient for the cross terms to drop out; it is not necessary.

### 2.3. What *is* necessary, and what "forces size 3"

Given (1) and the block decomposition, condition (3) *is* necessary: within a single block, an in-block squarefree cubic lying in $(s_B)$ forces $G=0$ by the same coefficient argument as §2.0, so $T$ must be block-constant. That half is correct.

**But "what forces size 3 is condition 3" is wrong.** Condition 3 forces block-*constancy*, not block-*size*. A block of any size on which $T\equiv0$ (every abelian block, every Cartan direction), satisfies it. The genuine content is: *among compact simple metric Lie algebras, only $\mathfrak{su}(2)\cong\mathfrak{so}(3)$ has block-constant $T$*, and even that needs the constant to match across blocks (§2.1), which is why the abelian-block witness breaks the collapse. Size $3$ is a conclusion about $\mathfrak{so}(n)$'s ideals, not a consequence of condition 3.

The Newton self-correction is right, and the correction was the right call. Written formula "$p_3=e_1p_2-e_2e_1+3e_3$" should read $e_2p_1$, harmless since $e_1=p_1$; and $e_1=0\Rightarrow p_3=3e_3$ holds for any block size, as the post now says.

### 2.4. The $\mathfrak{su}(3)$ Gell-Mann computation

Built $f_{abc}=-\tfrac i4\operatorname{tr}([\lambda_a,\lambda_b]\lambda_c)$ exactly from the eight Gell-Mann matrices (only $\mathbb Q$ and $\sqrt3$ appear). Total antisymmetry verified exactly.

- **$T=f^2$ takes the values $\{\tfrac14,\tfrac34,1\}$, CONFIRMED**, with multiplicities $6$, $2$, $1$ respectively (the standard $f_{147}$-family, $f_{458},f_{678}$, and $f_{123}$).
- **"$28$ of its $56$ triples carrying $T=0$", REFUTED.** Of the $\binom83=56$ triples, **$47$ carry $T=0$** and only $9$ are nonzero. The figure $28$ is wrong by $19$. The error runs in the author's favour ($\mathfrak{su}(3)$ is *further* from block-constant than claimed) so the conclusion is not damaged, but the number as printed is not the number.
- One caveat: $\{\tfrac14,\tfrac34,1\}$ is normalisation-dependent (rescaling the invariant metric scales every $f$ by a common factor). The invariant content is the ratio set $1:3:4$ together with "non-constant".

---

## 3. The invariant-theory closure, the impossibility claim

### 3a. The literature fact, CONFIRMED as cited

I proved the **necessary** half from first principles, in exact integer arithmetic. Finitely many $GL(V)$-orbits on $\Lambda^3V^*$ requires $\dim GL(V)\ge\dim\Lambda^3V^*$, i.e. $N^2\ge\binom I3$, i.e. $N^2-9N+2\le0$, i.e. $N\le\tfrac{9+\sqrt{73}}2$:

| $N$ | $6$ | $7$ | $8$ | $9$ | $10$ |
|---|---|---|---|---|---|
| $N^2-\binom I3$ | $+16$ | $+14$ | $+8$ | $-3$ | $-20$ |

So **moduli from $N\ge9$, exactly as claimed**, and the arithmetic $N\le8\iff n(n-1)\le16\iff n\le4$ is correct.

The **sufficient** half (finiteness for $N\le8$) I could not verify from a primary source, there is no trivector-classification paper in [references/](../references/); the two Turán papers the post itself flags as the wrong tool are the only nearby items. An independent literature search reproduces the author's attributions verbatim (Schouten $\le7$ and Gurevich $N=8$ over $\mathbb C$; Gurevich–Revoy–Westwick $\le7$ and Djoković, *Linear and Multilinear Algebra* **13** (1983) 3–39, $N=8$ over $\mathbb R$), and corroborating evidence for the $N=9$ threshold is that Vinberg–Elashvili's 1978 $N=9$ classification is a classification *into parametrised families*. **Status: consistent with the literature, verified only in its necessary half here.** The post should say so rather than assert it flat.

### 3b. "Any argument reaching $\theta$ through a classification of $c$ therefore cannot exist", REFUTED, and this is the worst claim in the three posts

Five independent reasons, any one of which is fatal.

**(i) There is nothing to classify.** $c$ is a *single, explicit, known* alternating $3$-form, the structure form of $\mathfrak{so}(n)$, computable in closed form (I built it above in four lines). A statement that the $GL$-orbit space of $\Lambda^3\mathbb R^N$ is positive-dimensional says nothing whatever about an argument that uses the one point sitting in it. The impossibility claim refutes a proof strategy ("enumerate normal forms of a generic $3$-form") that nobody has proposed and that no one would use when the form is given.

**(ii) The classification the post says "does not exist" *does* exist, for the actual objects.** The forms in play are not generic $3$-forms; they satisfy the **Jacobi identity** and arise from compact metric Lie algebras. Those are classified (Cartan–Killing), in **every** dimension: a finite list of simple factors plus an abelian centre. The Jacobi identity cuts a wildly non-generic subvariety out of $\Lambda^3$, and the generic-orbit moduli count is silent about it. The post's own post F2f uses this classification (it argues from simplicity of $\mathfrak{so}(n)$ for $n\ge5$) one post later. **The two posts contradict each other**: 2f reasons from the structure theory of compact Lie algebras, 2e2 declares that structure theory unavailable.

**(iii) The group is wrong.** $T=c^2$ is read in an *orthonormal* eigenframe. The group acting is $O(N)$, and the symmetry actually relevant is $\mathrm{Aut}(\mathfrak{so}(n))\subset O(N)$, the $O(n)$-action on $\Lambda^2\mathbb R^n$. $GL(N)$-orbit counting is a different action on a different problem. Under $GL(N)$ the structure form is in fact *rigid* in the sense that matters here: its stabiliser contains $\mathrm{Aut}(\mathfrak{so}(n))$, so its orbit has dimension $N^2-\binom n2$, and the "moduli" are populated by forms that are not Lie brackets at all.

**(iv) "Has moduli" $\ne$ "no argument". This is a category error, and the record refutes it in two places.** Moduli spaces support sharp inequalities routinely. The nearest example is the post's own: Okumura's bound $\operatorname{tr}(A^3)\le\tfrac{m-2}{\sqrt{m(m-1)}}\lVert A\rVert^3$ is a sharp inequality on traceless symmetric matrices, a space with $GL$-moduli, and it is precisely the tool post F2c uses to close $n=4$. Closer still: by the project's own arithmetic (verified exactly here) $\dim\mathrm{Weyl}_n-\dim O(n)=\tfrac{n^2(n^2-13)}{12}$, which is $4$ at $n=4$, **so $\mathrm{Weyl}_4$ has moduli, and the sharp bound on it is nonetheless proved**. And [post F2d](../findings/fence-posts.md) (Reviewer 94) already adjudicated exactly this inference: *"a spectral bound cannot suffice is a **non-sequitur**, the fibrewise supremum is itself a spectral function."* Post F2e2 re-commits the refuted inference and then cites the same moduli count as supporting evidence.

**(v) The "boundary" is not being detected by the number $8$.** $\binom n2$ takes the values $3,6,10,15,\dots$, it never lands in $\{7,8,9\}$. **Any** threshold $N^\ast\in\{6,7,8,9\}$ yields the identical conclusion "$n\le4$". So the agreement with $n=4$ is a coincidence of a $4$-wide gap, and the claim would read the same if the true orbit-finiteness boundary were $6$ or $9$. As evidence about $n=4$ this carries almost no information.

**What survives.** One defensible sentence: *a proof by exhaustion over a finite list of $GL$-normal forms for a generic alternating $3$-form is unavailable for $N\ge9$.* That is a remark about one technique, not an impossibility theorem, and it is not a fence post, it is an observation that a route nobody proposed is unattractive. The current wording ("cannot exist", "closes it structurally rather than for want of effort") should come out.

---

## 4. "Three independent appearances of the $n=4$ boundary", REFUTED

They are neither three, nor independent, nor all at $n=4$.

| Appearance | What it actually is | Boundary it gives |
|---|---|---|
| $\#=\operatorname{adj}\iff\dim\mathfrak g=3$ | $\binom n2=3$ | $n=\mathbf3$, not $4$ |
| Orbit finiteness $\iff N\le8$ | $\binom n2\le8$ | $n\le4$ |
| $\tfrac{n^2(n^2-13)}{12}>0$ | $\dim\mathrm{Weyl}_n>\dim O(n)$ | $n\ge4$ |

- **Rows 1 and 3 are two thresholds on one monotone function**, $\dim\mathfrak{so}(n)=\binom n2$, read at $3$ and at $8$. Reading the same dimension count against two different constants is one fact, not two.
- **Row 1 does not even give $n=4$.** It gives $n=3$. Reaching $n=4$ needs the *separate* input $\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, an exceptional isomorphism, which is exactly the thing 2e2 says it is replacing with a root cause.
- **Row 2 is a different polynomial**, I verified $\dim\mathrm{Weyl}_n-\dim O(n)=\tfrac{n^2(n^2-13)}{12}$ exactly, and it is not $\binom I3-N^2=\tfrac{n(n-1)(n^4-2n^3-17n^2+18n+8)}{48}$, so the two counts are genuinely distinct arithmetic. But its "$n=4$ boundary" is nothing but $\mathrm{Weyl}_n=0$ for $n\le3$, i.e. **the domain of the conjecture**. Confirming that the phenomenon starts where the problem starts is circular.
- **And row 2 was already disqualified.** [Post F2d](../findings/fence-posts.md) says the count "stands as arithmetic and **fails as an inference**". Post F2e2 then lists it as one of the three confirmations. A count that has been ruled a non-sequitur cannot be re-enlisted as corroboration two posts later.
- Finally, all three are *necessary conditions* / heuristics. Even three genuinely independent necessary conditions do not compound into evidence for an impossibility.

**Recommended wording:** one appearance, not three, "$\dim\mathfrak{so}(n)$ crosses both the adjugate threshold ($3$) and the orbit-finiteness threshold ($8$) inside the same gap between $n=4$ and $n=5$", stated as an observation rather than as confirmation.

---

## 5. Everything else in posts 1–2f

### 5a. Post F2c's displayed chain is off by a factor 2, REFUTED (display), CONFIRMED (constant)

The post displays

$$\langle W^\#,W\rangle=3(\det W^++\det W^-)=\operatorname{tr}((W^+)^3)+\operatorname{tr}((W^-)^3)\ \propto\ \operatorname{tr}(W^3)$$

and then says "Reviewer 94 fixes the constant at $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$". **The display and the sentence contradict each other**: the displayed chain evaluates to $\operatorname{tr}(W^3)$, not $2\operatorname{tr}(W^3)$.

Reviewer 94 is right and the display is wrong. On a fully general $\mathrm{Weyl}_4$ ($A$, $B$ arbitrary symmetric traceless $3\times3$ on the two chiralities, ten free parameters), I verified exactly:

$$W^\#=\big(2\operatorname{adj}A,\ 2\operatorname{adj}B\big),\qquad\langle W^\#,W\rangle-2\operatorname{tr}(W^3)=0,\qquad\langle Q(W),W\rangle=3\operatorname{tr}(W^3).$$

The missing $2$ is exactly the $c^{\mathrm{SD}}_{012}=-\sqrt2$ of §1b. **The correct display is $\langle W^\#,W\rangle=6(\det W^++\det W^-)=2\big[\operatorname{tr}((W^+)^3)+\operatorname{tr}((W^-)^3)\big]$.** Because 2e2's headline sentence asserts "$\#$ **is** the adjugate", and 2c's display silently uses that unscaled identity, the two posts propagate one and the same error.

### 5b. The $n=6$ isospectral pair, CONFIRMED, and stronger than stated

Derived independently. A coordinate-diagonal $W\in\mathrm{Weyl}_6$ is exactly a symmetric $6\times6$ matrix $K$ with zero diagonal and all row sums zero (Bianchi is automatic, a coordinate-diagonal operator has $R_{ijkl}=0$ unless $\{i,j\}=\{k,l\}$, so every Bianchi triple vanishes termwise; Ricci-flatness is the row-sum condition). Demanding the $\Lambda^2$-spectrum $(1^6,0^3,(-1)^6)$: each vertex needs equally many $+1$ and $-1$ edges, so its nonzero degree is even, so its zero-degree is odd; the zero-degrees sum to $6$ over $6$ vertices, hence **the three zero edges must form a perfect matching**, and the support is $K_6$ minus a matching (the octahedron). Exhaustive exact enumeration over all $15\cdot2^{12}$ labellings, with $P=\operatorname{tr}(W^3)+\tfrac12\sum c_{abc}^2\lambda_a\lambda_b\lambda_c$ anchored against $\langle\mathrm{Id}^\#,\mathrm{Id}\rangle=60$:

| $P$ | $-24$ | $0$ | $+24$ |
|---|---|---|---|
| count | $60$ | $180$ | $60$ |

every one with $\operatorname{tr}(W^3)=0$ and $\lVert W\rVert^2=12$. So the post's "$P=0$ against $P=24$" is right and understates the case: **the spread across one $\Lambda^2$-spectrum is $48$, not $24$**, and there is a third value. The conclusion ($P$ is provably not a function of the spectrum), is CONFIRMED, and the post should quote $\{-24,0,24\}$. ("Both with trivial stabiliser" I did not check; it is not load-bearing, since the three distinct $P$ values settle non-spectrality on their own.)

### 5c–d. The Huisken norm correction

$\lvert W\rvert=2\lVert W\rVert$ is **CONFIRMED**: the $e_i\wedge e_j$ ($i<j$) are orthonormal, so $\lVert W\rVert^2=\sum_{i<j,k<l}W_{ijkl}^2=\tfrac14\sum_{ijkl}W_{ijkl}^2=\tfrac14\lvert W\rvert^2$, matching Xu's $(2.54)$ as the note says.

The **conversion is not**. [notes.md](../references/huisken-1985-ricci-deformation/notes.md) says "the sharp constant is $\tfrac{\sqrt6}4$ against $\lvert W\rvert^3$ … In the project's normalisation it becomes $\tfrac{\sqrt6}2$." Substituting $\lvert W\rvert=2\lVert W\rVert$ into $\tfrac{\sqrt6}4\lvert W\rvert^3$ gives $2\sqrt6\,\lVert W\rVert^3$, a factor $4$ away from $\tfrac{\sqrt6}2\lVert W\rVert^3$. The note converts the right-hand side but never says how the *left*-hand cubic rescales, so the chain as written does not reach its conclusion. **UNPROVEN as stated.**

The target constant itself is safe by an independent exact route, which the note also gives and which I reproduced: $W_{\mathbb{CP}^2}$ has $\Lambda^2$-spectrum $(2,-1,-1,0,0,0)$, so $\lVert W\rVert^2=6$, $\operatorname{tr}(W^3)=6$, and $\theta=3\cdot6/6^{3/2}=\tfrac{\sqrt6}2=\sqrt{3/2}$ exactly. **The fix is to drop the Huisken-constant conversion as the justification and keep the $\mathbb{CP}^2$ computation**, or to state the cubic form's normalisation explicitly.

### 5e. $1+\tfrac{\sqrt3}6$ is a limit, not a floor, REFUTED where it is called a floor

With $f(n)=\tfrac{n(n-3)}{(n-1)(n-2)}+\tfrac{n\sqrt3}{6\sqrt{(n-1)(n-2)}}$, exact evaluation and exact sign comparison against $1+\tfrac{\sqrt3}6$:

| $n$ | $4$ | $5$ | $6$ | $7$ | $11$ |
|---|---|---|---|---|---|
| $f(n)$ | $\tfrac23+\tfrac{\sqrt2}3$ | $\tfrac54$ | $\tfrac{9+\sqrt{15}}{10}$ | $\tfrac{14}{15}+\tfrac{7\sqrt{10}}{60}$ | $\tfrac{44}{45}+\tfrac{11\sqrt{30}}{180}$ |
| $f(n)-(1+\tfrac{\sqrt3}6)$ | $<0$ | $<0$ | $<0$ | $>0$ | $>0$ |

$\lim_{n\to\infty}f=1+\tfrac{\sqrt3}6$ **CONFIRMED**; the maximum over $n\ge6$ is at $n=11$ and $f$ decreases from there, **CONFIRMED**; and $f(323)>\tfrac{129}{100}>f(324)$, **CONFIRMED** exactly (also $f(322)>\tfrac{129}{100}>f(325)$, so the crossing is where the post says).

But $f(n)<1+\tfrac{\sqrt3}6$ for $n=4,5,6$. [fence-posts.md](../findings/fence-posts.md) post F2 is careful (it calls $1+\tfrac{\sqrt3}6$ "the limit") but [plan.md](../plan.md) line 26 writes "a term-by-term split (floor $1+\tfrac{\sqrt3}6$)". **That is false at $n=4,5,6$, and $n=6$ is inside the live range.** At $n=6$ the true term-by-term overshoot is $\tfrac{9+\sqrt{15}}{10}$, strictly below the quoted floor. Small, but it is the kind of number a future attempt will quote.

---

## Summary of what should change

1. **Post F2e2, the headline "iff".** Replace with the normalisation-free statement: $\#=\kappa\operatorname{adj}$ ($\kappa\ne0$) $\iff\dim\Lambda^2\mathfrak g=\dim\mathfrak g\iff\dim\mathfrak g=3$, with $\kappa=\lambda^2$ where $c=\lambda\varepsilon$. Note that at $n=4$, $\kappa=2$, "$\#$ **is** the adjugate" is false in the post's own key case.
2. **Post F2e2, the adjugate identity.** Add "for symmetric $R$"; the residual is nonzero otherwise.
3. **Post F2e2, "subsumes 2c and 2f".** Remove. 2e2 lacks the trace-free ingredient that 2f supplies as condition 2.
4. **Post F2e2, the impossibility claim.** Remove "Any argument reaching $\theta$ through a classification of $c$ therefore cannot exist". The Jacobi identity puts $c$ inside the Cartan–Killing classification, which is finite in every dimension; the relevant group is $\mathrm{Aut}(\mathfrak{so}(n))\subset O(N)$, not $GL(N)$; and the project's own $n=4$ proof is a sharp bound on a space with moduli.
5. **Post F2e2, "third independent appearance".** Remove. Two of the three are thresholds on the same $\binom n2$, one gives $n=3$ rather than $n=4$, and the third was declared a non-sequitur in post F2d.
6. **Post F2f, condition 3.** Strengthen to "with the same constant across blocks", else $\mathfrak{so}(3)\oplus\mathbb R^m$ is a counterexample to sufficiency.
7. **Post F2f, condition 1 and the "exactly when".** Downgrade to "if". A $T$ with cross-block support collapses whenever the cross part lies in $(s_1,\dots,s_k)$, and $s_1e_2(B_2)$ is such a part. Also state the domain explicitly; without it the criterion has no truth value.
8. **Post F2f, "what forces size 3 is condition 3".** Replace: condition 3 forces block-constancy, which every abelian block also satisfies. Size $3$ comes from the ideal structure of $\mathfrak{so}(n)$.
9. **Post F2f, $\mathfrak{su}(3)$.** $47$ of $56$ triples carry $T=0$, not $28$.
10. **Post F2c, the display.** Insert the factor $2$: $\langle W^\#,W\rangle=6(\det W^++\det W^-)$.
11. **Post F1, the $n=6$ pair.** Quote $P\in\{-24,0,+24\}$ over one spectrum, a spread of $48$.
12. **[plan.md](../plan.md) line 26.** "$1+\tfrac{\sqrt3}6$" is the limit, and is not a floor at $n=4,5,6$.
13. **[huisken notes](../references/huisken-1985-ricci-deformation/notes.md).** State the cubic form's rescaling or drop the constant conversion; keep the $\mathbb{CP}^2$ derivation, which is exact and self-contained.
