# REVIEW r648, Lemma L78

**Target:** Lemma L78, "the residual floor $\alpha\ge(2d/n)(4d-n^2)$ for the 3-form mass at dimension $d$", [findings/isotropy-cap.md:155](../findings/isotropy-cap.md), the heading, the by-product paragraph at line 159 and the *Evidence* paragraph at line 161. Index row at [findings/INDEX-results.md:93](../findings/INDEX-results.md), which records **"Gate 2: no verdict on the record."**

**Reviewer:** r648, cold, adversarial, **analysis-only footing**. No search, sweep, census, optimisation or falsifier hunt was run, and **the gradient search this block reinterprets was not re-run**. Everything in §2–§4 was derived by hand from the definitions in [conventions.md](../findings/conventions.md) before the block was read for its reasoning. **Two screens** were taken, a few seconds of dense linear algebra on two subalgebras of $\mathfrak{so}(5)$ and one of $\mathfrak{so}(6)$, objects constructed here for the purpose, and each is reported as a screen, agreeing to the last digit with a closed form derived by hand in the same section. Neither screen is the ground of any positive claim.

**VERDICT: GAP.** The floor is a **theorem** and I re-derive it from the definitions in six lines (§2); it needs no hypothesis the record does not already hold, and it survives every attack I made on it. The reinterpretation at $n=5$, $d=7$ is **also true, and true for a better reason than the block gives**, I prove attainment outright (§3): the floor $8.4$ is realised exactly by $\mathfrak m=\mathfrak h^\perp$ where $\mathfrak h$ is the **principal $\mathfrak{su}(2)\subset\mathfrak{so}(5)$**, so the search reached a point that a proven lower bound certifies as optimal, and "it had found the true global minimum" is a theorem rather than a coincidence. **The gap is scope.** The block's *Evidence* paragraph advertises two residuals, $8.4$ **and** $16.6$, as one phenomenon. The second is at $n=6$, $d=10$, where the floor is $40/3=13.\overline{3}$, the search sits **24% above it** and is certified by nothing. The source the block is compressing ([r65](REVIEW_r65.md)) carried a four-row table marking exactly one row **attained** and three loose by $24\%$, $58\%$ and $41\%$; **the retrofit kept the headline and dropped the table**. Four further defects follow: $\alpha$ and "3-form mass" are **undefined anywhere on the record** (§1); the floor's range of content is unstated and it says nothing at or below the cap (§2.3); the $\lfloor n^2/4\rfloor$ sentence is a **one-line corollary presented as four measurements** (§5); and the heading comes from **the same bulk-retrofit commit that [L75](../findings/isotropy-cap.md) and [L76](../findings/isotropy-cap.md) were repaired for** (§7). Nothing consumes L78.

---

## 1, Conventions, pinned before anything was derived

[conventions.md](../findings/conventions.md) was re-read in full first. It defines neither of the block's two principal symbols.

| object | reading adopted here | pinned at | status |
| --- | --- | --- | --- |
| $\langle X,Y\rangle$ | $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ on $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal | [conventions.md](../findings/conventions.md), "Norms and pairings", bullets 1–2 | the record's choice, pinned twice ([r519](REVIEW_r519.md), [r520](REVIEW_r520.md)) |
| $c_{abc}$ | $\langle[v_a,v_b],v_c\rangle$, **totally antisymmetric**; $T_{abc}=c_{abc}^2$ totally symmetric | [conventions.md](../findings/conventions.md), "Structure constants" | load-bearing in §2 and §3 |
| Killing marginal | $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ | [conventions.md](../findings/conventions.md), "The pair cap and the Killing marginal" | the whole of §2's first identity |
| $N$ | $\binom n2$ | [conventions.md](../findings/conventions.md), "The objects" |, |
| $S_{XYZ}$ | the **ordered-slot** reading adopted 2026-09-04 | [conventions.md](../findings/conventions.md), $S_{XYZ}$ row | §1.2 below; the block never uses the symbol, which is why it escapes the collision |
| $\alpha$ | $\alpha(\mathfrak m)=\sum_{a,b,c\in\mathfrak m}c_{abc}^2$ over **ordered** triples from an orthonormal basis of $\mathfrak m$, equivalently $\lVert\omega\rvert_{\mathfrak m}\rVert^2$, the squared norm of the Cartan $3$-form restricted to $\mathfrak m$ | **nowhere in [findings/](../findings/)**; recoverable only from [r65](REVIEW_r65.md) | **D1** |
| "3-form mass at dimension $d$" | the same $\alpha$, minimised over $d$-dimensional subspaces $\mathfrak m\subseteq\mathfrak{so}(n)$ | **nowhere** | **D1** |
| $\mathfrak m$, $\mathfrak h$ | here a **free** $d$-dimensional subspace and its orthogonal complement, *not* $E_{\min}$/$E_{\max}$ | [conventions.md](../findings/conventions.md) tables three other senses for $\mathfrak m$ | **D2** |

### D1, the block's subject has no definition on the record

Neither $\alpha$ nor "3-form mass" appears in [conventions.md](../findings/conventions.md), and neither is defined in [isotropy-cap.md](../findings/isotropy-cap.md). The only written definition anywhere is inside a review, [REVIEW_r65.md:69](REVIEW_r65.md), $\alpha=\sum_{a,b,c\in\mathfrak m}c'^2_{abc}$, itself carrying a stray prime on $c$. **A `Lemma` heading whose subject exists only in a review is not citable**, and this is the fourth symbol in this file to fail that test after $\gamma$, $\mathfrak m$ and $\psi$. The reading above is the only one under which every number in the block comes out; §3 verifies that by reproducing $8.4$ exactly under it.

Two adjacent readings are excluded, and each changes the number:

- **unordered triples.** Then $\alpha$ divides by $6$ and the floor would read $\alpha\ge\tfrac{d}{3n}(4d-n^2)$, giving $1.4$ at $n=5$, $d=7$. The block's $8.4$ forces the ordered reading, which is also [conventions.md](../findings/conventions.md)'s stated default ("Sums over pairs are over ORDERED pairs unless the line says otherwise") and the reading its $S_{XYZ}$ row adopted on 2026-09-04. **So the record's repaired convention is the one L78 silently uses, and the block should quote it.**
- **plain Frobenius on $\Lambda^2$.** Every $c_{abc}$ scales, and $8.4$ does not survive. The block names no pairing.

### D2, $\mathfrak m$ is used in a fourth sense, and it is the sense that matters

The whole point of L78 is that it drops isotropy: $\alpha=0$ *is* isotropy, so the lemma is a statement about **non-isotropic** subspaces, and $\mathfrak m$ is quantified over all $d$-dimensional subspaces of $\mathfrak{so}(n)$ with no Weyl operator in sight. That is none of the three senses [conventions.md](../findings/conventions.md) tables. The block never says so.

### 1.2, a live $\gamma$ collision that L78 sits exactly on top of, and it is the file's own

[isotropy-cap.md](../findings/isotropy-cap.md) uses $\gamma$ in two inequivalent ways, and **they agree only under isotropy, which is precisely the hypothesis L78 discards**:

| symbol | definition | where |
| --- | --- | --- |
| $\gamma_{\text{block}}$ | $\sum_{a\in\mathfrak m}\lVert C_{e_a}\rVert_F^2=\sum_{a\in\mathfrak m,\,b,c\in\mathfrak h}c_{abc}^2$, the $\mathfrak h$-to-$\mathfrak h$ bracket mass seen from $\mathfrak m$ | [isotropy-cap.md:68](../findings/isotropy-cap.md), L36's proof, via $2\mu+\gamma=2(n-2)d$ |
| $\gamma_{\text{file}}$ | $2(n-2)d-2\mu$ | [isotropy-cap.md:132](../findings/isotropy-cap.md), "The odd-$n$ gap, stated sharply" |

From the identities of §2, $\gamma_{\text{file}}=\gamma_{\text{block}}-\alpha$. **The two coincide exactly when $\alpha=0$**, so every result above L78 in this file may use them interchangeably and L78 may not. This also *validates* [conventions.md](../findings/conventions.md)'s newly recorded general law $\gamma=S^{\mathrm{ord}}_{\mathfrak{mhh}}-S^{\mathrm{ord}}_{\mathfrak{mmm}}$: that law is true of $\gamma_{\text{file}}$ and false of $\gamma_{\text{block}}$, and it differs from [L77](../findings/isotropy-cap.md)'s displayed $\gamma=2S_{\mathfrak{mhh}}$ by both a factor and a term. **L78 is the one block in the file where the difference is not zero, and it is the one block that never mentions $\gamma$.**

---

## 2, The floor: CONFIRMED, derived cold

### 2.1 The two identities

Fix $\mathfrak{g}=\mathfrak{so}(n)$, $N=\binom n2$, an orthonormal basis $\{f_i\}$ of $\mathfrak g$, a $d$-dimensional subspace $\mathfrak m$ with orthonormal basis $\{e_a\}$ and $\mathfrak h=\mathfrak m^\perp$. Write

$$\alpha=\!\!\sum_{a,b,c\in\mathfrak m}\!\!c_{abc}^2,\qquad \beta=\!\!\sum_{a,b\in\mathfrak m,\ c\in\mathfrak h}\!\!c_{abc}^2,\qquad \gamma=\!\!\sum_{a\in\mathfrak m,\ b,c\in\mathfrak h}\!\!c_{abc}^2,\qquad \mu=\!\!\sum_{a,b\in\mathfrak m}\!\!\lVert[e_a,e_b]\rVert^2 .$$

Splitting the Killing marginal $\sum_{j,k}c_{ajk}^2=2(n-2)$ over each $a\in\mathfrak m$ by where $j$ and $k$ fall, and summing over $a$:

$$\alpha+2\beta+\gamma=2(n-2)d. \tag{I}$$

Splitting $\lVert[e_a,e_b]\rVert^2=\sum_{c\in\mathfrak g}c_{abc}^2$ the same way gives $\mu=\alpha+\beta$. Eliminating $\beta$:

$$\boxed{\ \alpha=2\mu+\gamma-2(n-2)d\ }\qquad\text{hence}\qquad \alpha\ \ge\ 2\mu-2(n-2)d, \tag{II}$$

since $\gamma\ge0$ as a sum of squares. **No hypothesis has been used.** Note that (I) reduces to the record's $2\mu+\gamma=2(n-2)d$ exactly when $\alpha=0$, which is §1.2's collision in one line.

### 2.2 The eigenvalue input, and the record already owns it

Write $P$ for the orthoprojector onto $\mathfrak m$ and $T(A)=-\sum_k\operatorname{ad}(f_k)\,A\,\operatorname{ad}(f_k)$ on $\operatorname{Sym}(\mathfrak g)$, so that $\mu=\langle T(P),P\rangle$. With $\rho(X)A=[\operatorname{ad}X,A]$ and $\sum_k\operatorname{ad}(f_k)^2=-2(n-2)\mathrm{Id}$,

$$\textstyle\sum_k\rho(f_k)^2A=-4(n-2)A+2T(A)\quad\Longrightarrow\quad T=2(n-2)\mathrm{Id}-\tfrac12\operatorname{Cas}.$$

I recomputed all four Casimir eigenvalues by hand from $\langle\lambda,\lambda+2\rho\rangle$ in the normalisation fixed by $\Lambda^k\mathbb R^n\mapsto k(n-k)$, rather than taking them from the block:

| summand of $\operatorname{Sym}(\Lambda^2\mathbb R^n)$ | highest weight | $\operatorname{Cas}$ | $T$-eigenvalue |
| --- | --- | --- | --- |
| $\mathbb R\cdot\mathrm{Id}$ | $0$ | $0$ | $2n-4$ |
| $\operatorname{Sym}^2_0\mathbb R^n$ | $2\epsilon_1$ | $2n$ | $n-4$ |
| $\mathcal W_n$ | $2\epsilon_1+2\epsilon_2$ | $4n-4$ | $\mathbf{-2}$ |
| $\Lambda^4\mathbb R^n$ | $\epsilon_1+\cdots+\epsilon_4$ | $4n-16$ | $4$ |

These are **exactly $-1$ times** the eigenvalues [Lemma L79](../findings/isotropy-cap.md) states at [isotropy-cap.md:256](../findings/isotropy-cap.md), $+2$, $-(m-4)$, $-2(m-2)$, $-4$ on $\mathrm{Weyl}_m$, $S^2_0$, $\mathbb R\cdot\mathrm{Id}$, $\Lambda^4$, so **$\mathcal A=-T$ and the record already holds L78's second ingredient as a numbered, Gate-2-confirmed result.** L78's chain instead cites "Lemma L2", which is [r65](REVIEW_r65.md)'s internal numbering; the record's numbered [Lemma L2](../findings/problem.md) is the exact dimension threshold, an unrelated result. **The file writes "Lemma L2" three times ([isotropy-cap.md:68](../findings/isotropy-cap.md), [:144](../findings/isotropy-cap.md), [:153](../findings/isotropy-cap.md)) in a file that links "Lemma L36" and "Lemma L79" as record identifiers.** That is a live mis-resolving pointer, and the repair is to cite L79.

With $P=(d/N)\mathrm{Id}+P_0$ and $\lVert P_0\rVert^2=d-d^2/N$, decomposing $P_0=P_s+P_W+P_\lambda$ isotypically:

$$\mu=\frac{4d^2}{n}-2d+(n-2)\lVert P_s\rVert^2+6\lVert P_\lambda\rVert^2\ \ \ge\ \frac{4d^2}{n}-2d, \tag{III}$$

the constant $4d^2/n$ coming out of $(2n-2)d^2/N$ with $N=n(n-1)/2$. Since $n-4\ge-2$ for every $n\ge2$ and $4>-2$, **(III) holds at every $n\ge3$**, including $n=3$ where $\mathcal W_n$ and $\Lambda^4$ are absent and the true minimum is $-1$. So the floor inherits no dimension restriction, although [L36](../findings/isotropy-cap.md)'s $n\ge4$ scope (repaired by [L79](../findings/isotropy-cap.md)) is where it is *sharp*.

### 2.3 The floor, and where it has content

Substituting (III) into (II):

$$\alpha\ \ge\ \frac{8d^2}{n}-4d-2(n-2)d\ =\ \frac{8d^2}{n}-2nd\ =\ \frac{2d}{n}\bigl(4d-n^2\bigr).\qquad\blacksquare$$

**CONFIRMED.** At $n=5$, $d=7$: $\tfrac{14}{5}\cdot3=\tfrac{42}5=8.4$, exactly. Combining (II) and (III) also gives the **exact** slack, which the block never states and which is what §3 and §4 turn on:

$$\alpha\ =\ \frac{2d}{n}\bigl(4d-n^2\bigr)\ +\ 2(n-2)\lVert P_s\rVert^2\ +\ 12\lVert P_\lambda\rVert^2\ +\ \gamma_{\text{block}}. \tag{IV}$$

Setting $\alpha=0$ in (IV) reproduces the file's own displayed slack formula at [isotropy-cap.md:122](../findings/isotropy-cap.md) verbatim, which is an independent check on (I)–(III).

**Sign and range, the brief's question, answered, and the block does not state it.** The floor is negative exactly when $4d<n^2$, so it has content **only strictly above the cap** $\lfloor n^2/4\rfloor$:

| regime | floor | content |
| --- | --- | --- |
| $d<n^2/4$ | negative | **vacuous**, $\alpha\ge0$ is stronger |
| $d=n^2/4$ ($n$ even) | $0$ | tight, and attained: $\alpha=0$ at the balanced symmetric pair |
| $d=(n^2-1)/4$ ($n$ odd) | $-2d/n<0$ | **vacuous**, although $\alpha=0$ is attained |
| $d>n^2/4$ | positive | the only regime with content |

**So the floor re-proves [L36](../findings/isotropy-cap.md) and nothing more below the cap**, $\alpha>0$ forces $d>n^2/4$ to be non-isotropic, which is L36 contrapositively. The block's "The proof yields a residual floor" is therefore right in substance: this is not a new theorem so much as L36's own chain read as a lower bound on $\alpha$ instead of an upper bound on $\gamma_{\text{file}}$. **Saying so would be worth a line**, because it tells a reader that the floor is exactly as strong as L36 and no stronger.

---

## 3, The reinterpretation: the floor **is** attained at $n=5$, $d=7$, and here is the extremiser

This is the load-bearing claim and the brief is right that it converts a negative computational result into a positive mathematical one. **It survives, and the block's own grounds for it are weaker than the truth.**

### 3.1 The logic the block uses, stated properly

A proven lower bound $L$ plus a feasible point of value $L$ is a **certificate of optimality**, standard, and sound. So if the search's $8.400$ is genuine, the $n=5$ reinterpretation follows. The brief's worry ("a floor and a stall agreeing to the digit is also consistent with the floor being wrong in a way that coincidentally matches") is answered by §2: the floor is derived, so it cannot be wrong. What the block *does* leave open is **attainment**, three digits of agreement is evidence that the floor is attained, not proof, and the block infers it.

### 3.2 The attainment is provable, by hand, and the extremiser is nameable

By (IV), the floor is attained iff $\gamma_{\text{block}}=0$, $P_s=0$ and $P_\lambda=0$ simultaneously. Now $\gamma_{\text{block}}=\sum_{b,c\in\mathfrak h}\lVert P_{\mathfrak m}[b,c]\rVert^2=0$ **iff $\mathfrak h$ is a subalgebra**. Suppose it is, write $\delta(\mathfrak h)=\sum_{a,b,c\in\mathfrak h}c_{abc}^2$, and split the total mass $\lVert\omega\rVert^2=\sum_{i,j,k}c_{ijk}^2=2(n-2)N$ by pattern, using total symmetry of $c_{abc}^2$:

$$2(n-2)N=\alpha+3\beta+3\gamma_{\text{block}}+\delta(\mathfrak h)=\alpha+3\beta+\delta(\mathfrak h).$$

Together with (I) at $\gamma_{\text{block}}=0$, eliminating $\beta$ gives a closed form I have not seen on the record:

$$\boxed{\ \alpha(\mathfrak h^\perp)=6(n-2)d+2\delta(\mathfrak h)-4(n-2)N\ }\qquad\text{for every subalgebra }\mathfrak h\text{ with }\dim\mathfrak h=N-d. \tag{V}$$

**Take $n=5$, $d=7$, $N=10$, so $\dim\mathfrak h=3$.** A subalgebra of a compact algebra is of compact type, and $\mathfrak{so}(5)$ has rank $2$, so a $3$-dimensional $\mathfrak h$ is $\cong\mathfrak{su}(2)$. For $\mathfrak h\cong\mathfrak{su}(2)$, $\delta(\mathfrak h)=3c_{\mathfrak h}$ with $c_{\mathfrak h}=2\lambda^2$ from $[h_1,h_2]=\pm\lambda h_3$ on an orthonormal basis. Two embeddings:

| $\mathfrak h\subset\mathfrak{so}(5)$ | $\mathbb R^5$ as an $\mathfrak{su}(2)$-module | $\lambda^2$ | $\delta(\mathfrak h)$ | $\alpha(\mathfrak h^\perp)$ by (V) |
| --- | --- | --- | --- | --- |
| standard $\mathfrak{so}(3)$ on $\{e_1,e_2,e_3\}$ | spin $1\ \oplus$ $2$ trivial | $1$ | $6$ | $126+12-120=\mathbf{18}$ |
| **principal $\mathfrak{su}(2)$** | **spin $2$**, irreducible | $\tfrac15$ | $\tfrac65$ | $126+\tfrac{12}5-120=\mathbf{8.4}$ |
| $\mathfrak{su}(2)_L\subset\mathfrak{so}(4)$ | spin $\tfrac12$ twice $\oplus$ $1$ trivial | $2$ | $12$ | $126+24-120=\mathbf{30}$ |

These are **all** of them: $\mathfrak{su}(2)$-subalgebras of $\mathfrak{so}(5)$ up to conjugacy are the $\mathfrak{sl}_2$-triples, indexed by the partitions of $5$ in which even parts have even multiplicity ($[5]$, $[3,1,1]$, $[2,2,1]$) and $\delta$ depends only on the module structure, so $\alpha\in\{8.4,\,18,\,30\}$ and **the principal embedding is the unique minimiser**. The $\lambda^2=\tfrac15$ is $\operatorname{tr}(J_z^2)=\sum_{m=-2}^{2}m^2=10$ on the spin-$2$ representation, giving $\lVert iJ_z\rVert^2=5$ under the half-trace pairing, so the normalised generators satisfy $[h_1,h_2]=-\tfrac1{\sqrt5}h_3$. The first row is an independent check: $\mathfrak m$ is then the monomial span of all edges of $K_5$ meeting $\{4,5\}$, whose only triangles are $\{i,4,5\}$ for $i=1,2,3$, giving $\alpha=3\times3!=18$ by direct count. $\mathfrak m=\mathfrak h^\perp$ in the second row is the **spin-$3$ summand** of $\Lambda^2(\text{spin }2)=\text{spin }3\oplus\text{spin }1$, of dimension $7$, and it is $\mathfrak{su}(2)$-irreducible.

> **THEREFORE: $\min_{\dim\mathfrak m=7}\alpha=8.4$ AT $n=5$, ATTAINED, AND THE MINIMISER IS THE ORTHOGONAL COMPLEMENT OF THE PRINCIPAL $\mathfrak{su}(2)$ IN $\mathfrak{so}(5)$.** The floor of §2 gives $\ge$; the principal $\mathfrak{su}(2)$ gives $\le$. **The block's reinterpretation is not merely licensed, it is a theorem, and the block does not know it.**

Two free corollaries fall out of (IV) at this point. Since the floor is attained, $\lVert P_s\rVert=\lVert P_\lambda\rVert=0$: **the projector onto the spin-$3$ summand of $\mathfrak{so}(5)$ has its traceless part entirely inside $\mathcal W_5$**, the same "$P_0$ is purely Weyl" condition that [isotropy-cap.md:153](../findings/isotropy-cap.md) shows *fails* at odd $n$ at the cap. And $\mu=\alpha+\beta=8.4+16.8=25.2=4\cdot49/5-14$, matching (III) with zero slack.

*Screen, reported as a screen.* Building both subalgebras in $\mathfrak{so}(5)$ in double precision and contracting $c_{abc}^2$ over the complement returned $\alpha=8.4$ and $\delta=1.2$ for the principal embedding, $\alpha=18$ and $\delta=6$ for the standard one, $\alpha=30$ and $\delta=12$ for $\mathfrak{su}(2)_L$, the hand values to every printed digit. Seconds of compute, on objects constructed here; **the derivation above is the evidence, and this paragraph is not.**

### 3.3 What the positive control actually controls for, and what it does not

The block cites: *"the same optimiser from random starts finds an isotropic subspace at $\lfloor n^2/4\rfloor$ itself, residual $\sim10^{-11}$, so the negative is informative rather than a blind search."*

- **It does control for one thing, and that thing is real**: the optimiser and its parameterisation can locate a global minimum of this objective, so a nonzero residual is not simply a broken run. That is a legitimate and often-omitted control.
- **It does not control for the thing the block needs.** The control instance is *easier along every axis that matters*: its minimum is exactly $0$ rather than strictly positive; its solution set is a whole $SO(n)$-orbit (dimension $9$ at $n=6$) rather than a possibly isolated point; and it is a feasibility problem, where descent on a nonneg­ative objective with a zero terminates on the zero set. Success there is weak evidence about a strictly-positive-minimum instance one dimension up.
- **At $n=5$ the control is now redundant.** §3.2 supplies a certificate that owes nothing to the optimiser. **At $n=6,7,8$ the control is all there is, and it is not enough**, see §4.

So the sentence is defensible but does more work than it can carry, and the correct account is: *the control shows the optimiser is not broken; the floor is what shows the $n=5$ run was optimal.*

---

## 4, The gap: the block's second number is not certified, and the block does not say so

The block's *Evidence* sentence reads: *"Gradient search on the 3-form mass at one dimension higher fails with residual $8.4$ and $16.6$, not marginal."* Both numbers sit under a heading and a preceding paragraph asserting that the search "had found the true global minimum".

The $16.6$ is at $n=6$, $d=10$, established from [REVIEW_r66.md:106](REVIEW_r66.md) ("At $n=6$ … against the reported $16.6$") and [REVIEW_r65.md:80](REVIEW_r65.md) ("the programme's reported $8.4$ and $16.6$ at $n=5,6$"). **[r65](REVIEW_r65.md)'s own table, which the block does not reproduce:**

| $n$ | $d=\lfloor n^2/4\rfloor+1$ | search residual | floor at that $d$ | gap |
| --- | --- | --- | --- | --- |
| $5$ | $7$ | $8.400$ | $8.400$ | **attained** |
| $6$ | $10$ | $16.55$ | $13.\overline{3}$ | $+24\%$ |
| $7$ | $13$ | $17.64$ | $11.14$ | $+58\%$ |
| $8$ | $17$ | $23.94$ | $17.00$ | $+41\%$ |

**Exactly one row of four is certified, and the block advertises two numbers.** Under the record's literal labels this is the difference between a `Lemma` and an `Observation`, and the block does not draw it.

**And at $n=6$ the failure is structural, not a matter of more search effort.** By (V), any $d=10$ subspace attaining the floor must have $\mathfrak h=\mathfrak m^\perp$ a $5$-dimensional subalgebra of $\mathfrak{so}(6)$, and then $\alpha=6\cdot4\cdot10+2\delta-4\cdot4\cdot15=2\delta(\mathfrak h)$, so attaining $13.\overline3$ needs $\delta(\mathfrak h)=\tfrac{20}3$. A $5$-dimensional compact-type algebra is $\mathfrak{su}(2)\oplus\mathbb R^2$ ($\mathbb R^5$ is excluded, $\mathfrak{so}(6)$ having rank $3$; $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ has dimension $6$), so $\mathfrak h$ is an $\mathfrak{su}(2)\subset\mathfrak{so}(6)$ whose centraliser contains a $2$-torus. Of the $\mathfrak{su}(2)$-module structures on $\mathbb R^6$, only $\mathbb R^4\oplus\mathbb R^2$ with $\mathfrak{su}(2)$ acting as $\mathfrak{su}(2)_L\subset\mathfrak{so}(4)$ has a rank-$2$ centraliser ($\mathfrak{su}(2)_R\oplus\mathfrak{so}(2)$); spin $1\oplus$ trivial$^3$ and $\mathbb R^3\otimes\mathbb R^2$ both centralise only a rank-$1$ torus. For $\mathfrak{su}(2)_L$, $\lambda^2=2$ and $\delta=12$, giving $\alpha=24$.

> **SO AT $n=6$, $d=10$ EVERY SUBSPACE WITH $\gamma_{\text{block}}=0$ HAS $\alpha=24$, AND THE FLOOR $13.\overline3$ IS UNATTAINABLE.** The search's $16.55$ therefore has $\gamma_{\text{block}}>0$ strictly, sits strictly between the floor and the best subalgebra complement, and **is certified by nothing at all**. It may be the global minimum; the record has no argument that it is.

*Screen, reported as a screen.* Constructing $\mathfrak h=\mathfrak{su}(2)_L\oplus\mathfrak u(1)_R\oplus\mathfrak{so}(2)_{56}$ in $\mathfrak{so}(6)$ returned $\delta=12.0$ and $\alpha(\mathfrak h^\perp)=24.0$, matching (V) exactly. Seconds of compute; the derivation is the evidence.

**Deciding the $n=6$ row would need computation, and I do not have approval for it.** What a run would decide: whether $\min_{\dim\mathfrak m=10}\alpha$ at $n=6$ is $16.55$ or lower. It cannot *prove* optimality either way, only a construction attaining a value, or a strengthened floor, can. **The analytic route is the one to take**, and (IV) names it: the floor is loose at $n=6$ by exactly $2(n-2)\lVert P_s\rVert^2+12\lVert P_\lambda\rVert^2+\gamma_{\text{block}}$, so sharpening it means bounding $\lVert P_s\rVert$ below at $d>n^2/4$, the **same** extremal question about $P_0$'s isotypic profile that [isotropy-cap.md:124](../findings/isotropy-cap.md) already names as the odd-$n$ debt. **L78 and the odd-$n$ gap are the same obstruction at two dimensions, and neither block says so.**

### 4.1 Hedging clauses, checked one at a time

| clause | verdict |
| --- | --- |
| "gives **exactly** $8.4$" | **true**, $42/5$ on the nose |
| "That search **was not stalling**" | **true at $n=5$, and now provable** (§3.2). Unstated for $n=6,7,8$, where it is unsupported |
| "it had found the **true global minimum**" | **true at $n=5$**, by floor $+$ attainment. **Not established at $n=6$**, where the block's own second number lives |
| "$8.4$ and $16.6$, **not marginal**" | **true** as stated (both are far from $0$), but the sentence's placement makes "not marginal" read as "both are at the floor", which is false of $16.6$ |
| "the negative evidence was **stronger than it was recorded as being**" | **true at $n=5$**; asserted without a dimension qualifier |
| "the positive control **passes**" | **true**; what it establishes is narrower than claimed (§3.3) |
| "**exactly** $\lfloor n^2/4\rfloor$ each" | **true**, and a triviality, see §5 |

---

## 5, The $\lfloor n^2/4\rfloor$ sentence is a one-line corollary printed as four measurements

*"Symmetric-pair subspaces realise $6,9,12,16$ at $n=5,6,7,8$, exactly $\lfloor n^2/4\rfloor$ each."*

The arithmetic checks: $\lfloor25/4\rfloor=6$, $\lfloor36/4\rfloor=9$, $\lfloor49/4\rfloor=12$, $\lfloor64/4\rfloor=16$. But **no measurement was ever needed**, and the derivation is shorter than the table:

1. For the symmetric pair $\mathfrak{so}(n)=\bigl(\mathfrak{so}(p)\oplus\mathfrak{so}(q)\bigr)\oplus\mathfrak p$ with $p+q=n$, the odd part is $\mathfrak p=\mathbb R^p\otimes\mathbb R^q$, so $\dim\mathfrak p=pq$, the symbolic identity $\binom{p+q}2=\binom p2+\binom q2+pq$, which is [L76](../findings/isotropy-cap.md)'s.
2. $\mathfrak p$ is isotropic because $K_{p,q}$ is triangle-free, [L76](../findings/isotropy-cap.md) again.
3. $\max\{pq:p+q=n,\ p,q\ge1\}=\lfloor n^2/4\rfloor$ by AM–GM over the integers, attained at the balanced split.

**Three lines, every $n$, no numerics.** So the sentence is a corollary of [L76](../findings/isotropy-cap.md) plus integer AM–GM, and $6,9,12,16$ is a spot check on a polynomial identity, **the identical pathology [r621](REVIEW_r621.md)/[r622](REVIEW_r622.md) recorded against L76 ("the recorded verification at $n=6,7,8$ was a spot check on a polynomial identity") and [r609](REVIEW_r609.md)/[r610](REVIEW_r610.md) recorded against L77 ("a closed form presented as a measurement"). This file has now done it three times.**

Two further notes on the sentence:

- **The route the brief suggests is the longer one.** "Maximal isotropic dimensions lie in $[n-1,\lfloor n^2/4\rfloor]$" gives the *upper* end only; the content here is **attainment**, which needs $pq$ at the balanced split regardless. So the interval statement does not subsume this; steps 1–3 do.
- **"Symmetric-pair subspaces realise … each" is loose.** Each individual symmetric pair realises $pq$, which is $\lfloor n^2/4\rfloor$ only for the balanced one; the sentence means the **maximum** over pairs. As written it reads as a claim about all of them, and it is false of, say, $\mathfrak{so}(2)\oplus\mathfrak{so}(4)\subset\mathfrak{so}(6)$, which realises $8$.

**The catalogue check is sound.** $\dim\mathfrak m=9,20,6,12$ at $S^3\times S^3$ ($n=6$), the $C_5$ blow-up ($n=10$), $\mathbb{CP}^3$ ($n=6$) and $\mathbb{CP}^4$ ($n=8$) against caps $9,25,9,16$: all four hold, and the two $\mathbb{CP}$ entries are $\dim\mathfrak{so}(2k)-\dim\mathfrak u(k)=k(k-1)$, giving $6$ and $12$ in closed form, a fifth measurement that is a formula.

---

## 6, The literature paragraph: right field, one misquotation, one unnamed field change

- **[Qiao](https://arxiv.org/abs/2007.12820) and [Chen et al.](https://arxiv.org/abs/2603.00715) both resolve** and both are on the record, [references/qiao-2020-turan-alternating-multilinear/](../references/qiao-2020-turan-alternating-multilinear/) and [references/turan-multilinear-2026/](../references/turan-multilinear-2026/), but the block cites **bare arXiv URLs** where the rest of the record cites the reference folder's notes. Minor, and a structure-check item.
- **The direction of the comparison is right.** $\alpha_\Lambda(F,n,d,m)$ is the *minimum over forms* of the largest isotropic subspace, and [L36](../findings/isotropy-cap.md) is the value for one distinguished form, so their theorems bound L36's quantity from below. The block states this correctly.
- **Theorem 1.2(b) is misquoted by one branch.** [references/turan-multilinear-2026/notes.md:33](../references/turan-multilinear-2026/notes.md) transcribes **four** cases: $\lceil n/2\rceil$ if $d=2$; $4$ at $(d,n)=(3,7)$; $n-2$ if $d=n-2$ is even; and $\max\{s:s(n-s)\ge\binom sd\}$ otherwise. The block names two exceptions and **drops the $d=2$ branch**, presenting the max-formula as holding "at every order" with two exceptions. It is three.
- **The field is not named.** Theorem 1.2 is stated over an **algebraically closed** $\mathbb F$; the record works over $\mathbb R$. A real isotropic subspace complexifies, so the inequality still runs in the claimed direction, but the step is unwritten. The reference's own notes flag the neighbouring hypothesis, *"the **generic**-element hypothesis in Tevelev is the second reason this cannot settle Lemma 36"*, and the block reproduces neither caveat.

---

## 7, Label, provenance and pointers

### 7.1 Provenance: L78 shares the failure mode exactly

`git log -S` on the heading returns **`5b258c14`, "docs(isotropy-cap): place headings for Lemmas 75-82"**, whose body reads *"eight results that previously sat under narrative headings only are now greppable by number"* and *"headings only: no statement, proof or table text is altered"*. **That is the same commit [L75](../findings/isotropy-cap.md) and [L76](../findings/isotropy-cap.md) were repaired for**, and the file says so twice, *"the heading was a bulk retrofit … the same commit that mislabelled L76"* and *"the heading itself is a bulk retrofit ten days after the block, so it inherited the mislabel"*. **L78 is the third result in that commit to be audited and the third to be found carrying an unstated hypothesis or definition**: here the definition of $\alpha$, the ordered-slot reading, the $d>n^2/4$ range, and [r65](REVIEW_r65.md)'s four-row table. The failure mode is not "one bad heading" but "a `Lemma` heading placed over narrative prose that never had a statement to carry the hypotheses". **The remaining five headings from `5b258c14` should be assumed to share it until audited.**

The prose itself is older, entering at `51ab61f8` (the findings split) from [REVIEW_r65.md:155](REVIEW_r65.md), where it appears nearly verbatim. **The compression happened at import, not at the retrofit**: r65 wrote the paragraph directly beneath its own table, so a reader saw the three loose rows; the record kept the paragraph and left the table behind.

### 7.2 A dangling antecedent

The block opens *"The proof yields a residual floor…"*. After the retrofit, the nearest preceding text is the parity-split discussion, and the proof it means, [L36](../findings/isotropy-cap.md)'s, at [isotropy-cap.md:68](../findings/isotropy-cap.md), is **91 lines above**, with [L77](../findings/isotropy-cap.md), the odd-$n$ gap and the rigidity chain in between. **"The proof" resolves to nothing local.** Repair: *"the proof of [L36](../findings/isotropy-cap.md), with $\alpha=0$ dropped, yields…"*.

Also, the retrofit left **two consecutive `####` headings** at [isotropy-cap.md:155](../findings/isotropy-cap.md) and [:157](../findings/isotropy-cap.md), the second being the original narrative one. The `(#)` empty anchor the brief warns about is present in this file at [isotropy-cap.md:382](../findings/isotropy-cap.md) but is **outside** the L78 block; every link inside the block resolves.

### 7.3 Label, clause by clause

| clause | correct label |
| --- | --- |
| the floor $\alpha\ge\frac{2d}n(4d-n^2)$ | **`Lemma`**, proved in §2, every $n\ge3$, no hypothesis beyond the record's normalisations. **The heading's label is right.** |
| attainment at $n=5$, $d=7$, hence "that search found the true global minimum" | **`Lemma`**, on the strength of §3.2, *currently written as an inference from a numerical coincidence, and it can be promoted* |
| "the residual $8.4$ **and** $16.6$" as jointly certified | **not a result at all.** The $n=6$ number is $24\%$ above its floor; at most an `Observation` that the search stalls there |
| "symmetric pairs realise $6,9,12,16$, exactly $\lfloor n^2/4\rfloor$" | **`Lemma`**, as a corollary of [L76](../findings/isotropy-cap.md) $+$ integer AM–GM (§5), *written as four measurements* |
| the literature paragraph | prose; correct in direction, misquoted in one branch, unnamed field change (§6) |

### 7.4 Consumers

**Nothing consumes L78.** Grepping the record for `L78` returns only [findings/INDEX-results.md:93](../findings/INDEX-results.md), a reference-folder heading that means something else, and line anchors `#L78` in unrelated files. So **no repair here damages anything**, and the reverse: the promotion in §3.2 is free to make.

---

## 8, What I attacked and failed to break

- **The floor.** Attempted to break (III) by looking for a subspace whose $P_0$ has a large $\Lambda^4$ component at negative $T$-eigenvalue, impossible, the eigenvalue is $+4$. Attempted $n=3$, where $\mathcal W_n$ is absent: the bound survives, weakly.
- **Attainment at $n=5$.** Attempted to make (V) undercut the floor by taking $\delta(\mathfrak h)=0$, i.e. $\mathfrak h$ abelian: that gives $\alpha=2(n-2)(3d-2N)=6<8.4$ at $n=5$, $d=7$, **a would-be violation**, and it is blocked because $\mathfrak{so}(5)$ has rank $2$ and admits no $3$-dimensional abelian subalgebra. At the largest $d$ where an abelian $\mathfrak h$ exists, $d=8$, (V) gives $\alpha=24$ against a floor of $22.4$: consistent, and tight to $7\%$. **The floor and the rank of $\mathfrak{so}(n)$ agree in a way they had no obligation to, which is the strongest single check I have on §2.**
- **The $8.4$ coincidence.** Attempted to make some *other* $\mathfrak{su}(2)\subset\mathfrak{so}(5)$ hit $8.4$, which would have made the agreement accidental: all three conjugacy classes were enumerated (§3.2) and they give $8.4$, $18$ and $30$. The principal embedding is the unique minimiser, so the coincidence is a rigid fact about one subalgebra rather than a numerical near-miss.

## 9, Repairs, in the order they should be made

1. **Define $\alpha$ in [conventions.md](../findings/conventions.md)** as $\lVert\omega\rvert_{\mathfrak m}\rVert^2=\sum_{a,b,c\in\mathfrak m}c_{abc}^2$ over ordered triples, equivalently $S^{\mathrm{ord}}_{\mathfrak{mmm}}$, which ties it to the row repaired on 2026-09-04, and note that $\alpha=0$ *is* isotropy. **Nothing else in §9 is citable until this is done.**
2. **State the range in the heading**: the floor has content only for $d>n^2/4$, and below the cap it is L36 restated.
3. **Split the block into two claims.** The floor is a `Lemma` (§2). The $n=5$ reinterpretation is a `Lemma` too, on §3.2's certificate, *"the floor is attained at $n=5$, $d=7$ by the orthogonal complement of the principal $\mathfrak{su}(2)\subset\mathfrak{so}(5)$, whose $\mathfrak m$ is the spin-$3$ summand"*, with (V) recorded as the general closed form for subalgebra complements.
4. **Restore [r65](REVIEW_r65.md)'s four-row table**, or at minimum say that the floor is attained at one of the four dimensions tried and loose by $24$–$58\%$ at the other three. **The $16.6$ must stop travelling next to the $8.4$ as if both were certified.**
5. **Record §4's structural fact** at $n=6$: the floor is unattainable at $d=10$ because every $5$-dimensional subalgebra of $\mathfrak{so}(6)$ gives $\alpha=24$.
6. **Cite [L79](../findings/isotropy-cap.md), not "Lemma L2"**, at [isotropy-cap.md:68](../findings/isotropy-cap.md), [:144](../findings/isotropy-cap.md) and [:153](../findings/isotropy-cap.md), and fix the dangling "The proof".
7. **Demote the $6,9,12,16$ sentence to the corollary it is** (§5), and correct "each" to the maximum over pairs.
8. **Repair the Chen quotation** (the $d=2$ branch) and name the algebraically-closed hypothesis.
9. **Record that L78's slack and the odd-$n$ debt are the same obstruction** (§4), since both reduce to bounding $\lVert P_s\rVert$.
