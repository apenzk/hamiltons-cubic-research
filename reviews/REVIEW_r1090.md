# Review r1090, COLD Gate 2 on sub-step (a) of Lemma L233

*Reviewer r1090, 2026-09-23. Commits under review: `4fe9ea9f`, `5366f187`, `5a579518`. Claim block: the section headed **SUB-STEP (a), THE PROJECTED QUOTIENT** inside `#### Lemma L233` of [second-order.md](../findings/second-order.md).*

**Footing.** Analysis-only. Every run below is seconds on objects built for the run, reported as a screen. The one structural statement offered as a derivation is proved from the record's own conventions and marked as such.

**Independence.** The whole pipeline was rebuilt from [conventions.md](../findings/conventions.md) alone: $\varphi_{ab}=E_{ba}-E_{ab}$, half-trace pairing, $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$, and $\pi_{\mathcal W_n}$ as the orthogonal projection killing first Bianchi and Ricci. [screen_I73_pair_direction.py](../scripts/misc/screen_I73_pair_direction.py) was never read or run. Controls that passed before any claim was evaluated: $\dim\mathcal W_n$ ($84$ at $n=6$, $1638$ at $n=12$) recovered as the constraint nullspace; the structure constants agreeing with [conventions.md](../findings/conventions.md)'s display to $0$; $\mathrm{id}^\#=(n-2)\,\mathrm{id}$ to $0$; $\theta^2=2(n-1)(p-1)(q-1)/((n-2)pq)$ to $4\cdot10^{-16}$; criticality residual $\le10^{-16}$ at every split.

## Verdicts

| # | claim | verdict |
|---|---|---|
| F1 | the disjoint case IS [L26](../findings/nondegeneracy.md)'s $\mu$ | **REFUTED as written** |
| F2 | the sharing case does not follow L26's three-symbol shape | **REFUTED** |
| F3 | $\tfrac14$ at $p=3$, independent of $q$ | **CONFIRMED**, and the value is L27's $\lambda_3$ |
| F4 | $(n-4)/(6(n-3))$ at $p=4$, $\tfrac4{27}$ at $n=12$ | **CONFIRMED and superseded** by a closed form in $p$ and $q$ |
| F5 | $p=3$ is flat because it is degenerate | **CONFIRMED**, mechanism sharpened |
| F6 | every value measured is $\le\tfrac12$ | **CONFIRMED and VACUOUS**: L27 forbids the alternative |
| F7 | the `WCP2` entry-shape cost | **conclusion CONFIRMED, both figures REFUTED** |

## The closed form the block says is owed

**Every number in the table is one formula.** For $u=\varphi_{ij}$, $v=\varphi_{ik}$ with $i,j,k$ inside the $p$-block of $S^p\times S^q$,

$$\sigma(p,q)\;=\;\frac{\langle X,e\circ X\rangle}{\lVert X\rVert^2}\;=\;\frac{n-p}{2(p-1)(n-3)},\qquad X=\pi_{\mathcal W_n}Y_0,\qquad \lVert X\rVert^2=\frac{n-3}{2(n-2)} .$$

At $p=3$ it is $\tfrac14$ at every $q$, and at $p=4$ it is $(n-4)/(6(n-3))$, so it subsumes both rows. It reproduces the block's own unexplained $p=5$ datum $\tfrac5{56}$ at $(10,5)$ and it holds **out of sample at twelve points nobody has used**, including $n=13$ at $p=3,4,5,7,10$, $n=14$ at $p=4$, and the unbalanced $(n,p)=(12,8)$, $(11,7)$, $(9,5)$, $(11,6)$, $(11,3)$, $(12,3)$, exact in rational arithmetic at every one.

**And it is not a two-block fact.** At the three-factor product with equal blocks, which is critical to $5.6\cdot10^{-17}$, the same quotient appears: $\tfrac14$ at $(3,3,3)$, $n=9$, and $\tfrac4{27}$ at $(4,4,4)$, $n=12$, each equal to the two-block value at the same $n$ and the same block size. *The table's scope line, "at a two-block sphere product", is narrower than the object.*

**The mechanism, and it is a derivation.** $X$ is invariant under the $O(q)$ factor of the isotropy, so it lies in the sum of the $O(q)$-invariant summands of [Lemma L27](../findings/nondegeneracy.md)'s ten, which are $\langle W\rangle$, $\mathrm{Weyl}_p$ and $S^2_0(\mathbb R^p)$. It is orthogonal to $W$, so the quotient is $\lambda_p$ weighted by the $S^2_0(\mathbb R^p)$ share of $\lVert X\rVert^2$:

$$\sigma=\lambda_p\cdot w,\qquad \lambda_p=\frac{p-2}{2(p-1)},\qquad w=\frac{q}{(p-2)(n-3)} .$$

*Screened exactly*: $L_e(L_eX)=\lambda_pL_eX$ to $2\cdot10^{-17}$ at six splits, so $X$ meets exactly the eigenvalues $0$ and $\lambda_p$; $w$ matches the formula in rational arithmetic at all six; and the $0$-component of $X$ has **zero mass outside the $p$-block** ($7\cdot10^{-17}$), which identifies it as the $\mathrm{Weyl}_p$ summand.

## F1, the disjoint case, REFUTED as written

**The block's sentence drops L26's hypothesis.** [Lemma L26](../findings/nondegeneracy.md) is stated for $\pi$ inside the $p$-block and $\rho$ inside the $q$-block. The block says instead that *at a coordinate-diagonal $W$ the projected direction is an eigenvector and the quotient is L26's $\mu$*, with no mention of where the two planes sit.

**For two disjoint planes BOTH inside one block the quotient is $0$, not $\mu$.** Measured at $(8,4)$, $(9,4)$, $(10,4)$, $(12,4)$, $(9,5)$, $(10,5)$ and $(12,6)$: the quotient is $0$ to $10^{-17}$ at every one, with $\lVert X\rVert^2=\tfrac13\ne0$ and an eigenvector residual of $10^{-17}$, against $\mu$ running over $\tfrac13,\tfrac7{24},\tfrac4{15},\tfrac5{21},\tfrac7{24},\tfrac14,\tfrac15$. **The eigenvector half of the sentence survives and the value half does not.** *The repair is one clause: the disjoint case is L26's $\mu$ exactly when the two planes lie in different factors.*

## F2, the three-symbol shape, REFUTED

**The four miss numbers are real and reproduce exactly**, and the two families they come from are different configurations: $+0.25$ and $+0.1333$ at the in-block sharing pair at $(6,3)$ and $(8,4)$, where the transplanted shape returns $0$; $-0.0833$ and $-0.0667$ at the pair sharing an index with one leg in each factor at the same two splits, where it returns $\tfrac14$ and $\tfrac16$. *The block's arithmetic is right.*

**The inference from them is wrong.** The sharing quotient IS L26's three-symbol combination, times a scalar:

$$\frac{\langle X,e\circ X\rangle}{\lVert X\rVert^2}\;=\;\frac{\binom q2}{\binom{n-2}2}\Big[\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}\Big],$$

exact in rational arithmetic at all **eighteen** splits from $(6,3)$ to $(13,10)$. *So it is precisely that formula with a correction, and the correction is a combinatorial factor rather than a new object.*

**AND THE SHAPE IS FORCED, FOR EVERY DIRECTION AT ONCE, BY TWO FACTS THE RECORD ALREADY HAS.** Write the quotient as a linear functional of $e$, which is legitimate because $X=\pi_{\mathcal W_n}Y_0$ does not depend on $e$ at all. By the full symmetry of $T$ ([conventions.md](../findings/conventions.md), $T$ third sense), $\langle X,D\circ X\rangle=\langle Q(X),D\rangle$, and $Q$ maps $\mathcal W_n$ to itself, so the functional sees only the Weyl part of $D$. The three-block diagonal operators are three-dimensional and carry a two-dimensional Ricci-and-scalar part, spanned by $S\wedge g$ at $S=\mathrm{diag}(1_P,0)$ and $\mathrm{diag}(0,1_Q)$, which in the three symbols are $(2,0,1)$ and $(0,2,1)$. The annihilator of both is the line $(1,1,-2)$, **which is $\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$.** *Screened: the coefficient triple is $(a,a,-2a)$ at every one of sixteen configurations tested, in-block and cross alike, and $\langle X,D\circ X\rangle=\langle Q(X),\pi_{\mathcal W_n}D\rangle$ to $2\cdot10^{-16}$ at arbitrary symmetric $D$.*

**So no direction whatever can escape L26's shape at a two-block diagonal $e$, and only the prefactor varies.** *That also explains why L26's own proof found the shape holding for any three-block diagonal operator: it is an identity about $\mathcal W_n$, not a fact about that eigenvector.*

## F3, F4, F5

**F3 CONFIRMED**, $\tfrac14$ reproduced at $n=6,7,8,9,10$ and additionally at $n=11,12,13$. **The value is [Lemma L27](../findings/nondegeneracy.md)'s $\lambda_m=(m-2)/(2(m-1))$ at $m=3$**, a value on the record since 2026-08, which the block reaches without citing it.

**F4 CONFIRMED**, $\tfrac2{15},\tfrac5{36},\tfrac17,\tfrac7{48},\tfrac4{27}$ at $n=8\ldots12$, each exact. **Superseded** by $\sigma=(n-p)/(2(p-1)(n-3))$ above, which the brief's own out-of-sample points confirm.

**F5 CONFIRMED, and the sharp statement is $\dim\mathrm{Weyl}_3=0$.** The block's reason, that $\{i,j,k\}$ exhausts the block, is the combinatorial face of it. What makes the quotient flat is that the only other $O(q)$-invariant summand available to $X$ is $\mathrm{Weyl}_p$, which is the zero space at $p=3$, so $X$ is a pure $S^2_0(\mathbb R^3)$ eigenvector at $\lambda_3$ and $q$ cannot enter. *Measured: $\lVert X_0\rVert^2=0$ at $p=3$ against $\tfrac14$ at $p=4$ and $\tfrac13$ at $p=5$.*

## F6 is true, and it could not have been false

**Exhaustive, not sampled.** Over **every** pair of distinct coordinate planes at $(6,3)$, $(7,3)$, $(8,3)$, $(10,3)$, $(8,4)$, $(9,4)$, $(10,4)$ and $(10,5)$, the maximum projected quotient is exactly $\mu$, attained at the cross-block disjoint pair, equal to $\tfrac12$ at $(3,3)$ and strictly below it everywhere else.

**But the screen was incapable of firing.** [Lemma L27](../findings/nondegeneracy.md) and [Lemma L207](../findings/nondegeneracy.md) give $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at every two-block sphere product with $p,q\ge3$, as a theorem. *Every* direction there obeys $\le\tfrac12$, so no pair direction at any such point could ever have exceeded it, and "no violation of L24 has been found at a sphere product" reports a theorem as a measurement. **The sentence is true and carries no evidential weight**, and the block should say that the bound is L27's rather than the screen's.

**Where the quotient DOES exceed $\tfrac12$, the record already holds it.** At $p=2$ the exhaustive maximum is $\mu=(n-2)/(2(n-3))>\tfrac12$: $\tfrac23,\tfrac58,\tfrac35,\tfrac7{12},\tfrac47$ at $n=6\ldots10$, attained at a cross-block disjoint pair and an exact eigenvector. That is L26's $\mu$, and [Lemma L207](../findings/nondegeneracy.md) already records $S^2\times S^{n-2}$ as a saddle for exactly this reason. *No new falsifier exists here, and the in-block sharing family cannot supply one: $\sigma\le\lambda_p<\tfrac12$ at every $p$, with the maximum $\tfrac14$ at $p=3$.*

## F7, the entry-shape measurement

**The conclusion is confirmed and both figures are refuted.** Re-measured here with the toolchain free and the tree clean, peak resident size polled on the `lean` child itself.

| run | wall | peak RSS |
|---|---|---|
| a file that merely imports `WCP2Sharp1` | $4.3$ s, $6.2$ s on a cold repeat | $5.29$ GB, $5.30$ GB |
| the entry statement `sharpBilin WCP2 1 0 0 = (-WCP2) 0 0`, elaborated | $4.3$ s | $5.30$ GB |

**So the entry shape costs $0.01$ GB and no measurable time beyond loading the oleans**, which is the block's conclusion, reached independently. **The quoted numbers are not.** The baseline here is $5.30$ GB against the recorded $4.25$ GB, and the entry figure is $5.30$ GB against the recorded $3.1$ GB.

**And the two recorded figures contradict each other.** $3.1$ GB is quoted for a file that imports `WCP2Sharp1` and $4.25$ GB for a file that merely imports it. **A file that does strictly more cannot peak $1.15$ GB lower**, so at least one of the two runs missed its peak, and the peak arrives early, while the oleans load. *The recorded $5.3$ GB for the whole-matrix goal matches my floor exactly, which is consistent with that run alone having caught it.*

**The measured object was deleted in the same commit** that recorded its cost, as the message states. *So the figure is unreproducible by construction, and the reconstruction above is a reconstruction rather than a repeat.*

## The absence and novelty claims, tested by the object

**Grepped by value, not by words.** $\tfrac2{15}$, $\tfrac5{36}$, $\tfrac4{27}$ and $\tfrac14$ as this quantity appear nowhere else in [findings/](../findings/), [results.md](../results.md) or [plan.md](../plan.md). The hits on $\tfrac5{36}$ and $\tfrac2{15}$ are [L134](../findings/route-a.md)'s defect ceiling and a Casimir value, unrelated.

**What the record does already hold is the frame, and the block cites none of it.** [Lemma L27](../findings/nondegeneracy.md) gives all ten $L_e$ eigenvalues at a two-block sphere product in closed form, $1$, $\tfrac12$, $\lambda_p$, $\lambda_q$, $\pm\mu$ and four zeros. Every number in sub-step (a) is a Rayleigh quotient against that list: $\tfrac14$ at $p=3$ **is** $\lambda_3$, the disjoint cross value **is** $\mu$, the disjoint in-block value **is** the $\mathrm{Weyl}_p$ zero, and the $p\ge4$ sharing values are two-term mixtures of $\lambda_p$ and $0$. *The block reads as a new family measured for the first time; it is the known spectrum seen through a particular set of directions.*

## What to change in the block

- **Restore L26's hypothesis** to the disjoint sentence, and record that two disjoint planes inside one factor give $0$.
- **Withdraw "does NOT follow L26's three-symbol shape"** and replace it with the identity above, including the reason no direction can escape that shape.
- **Replace the two-row table** with $\sigma=(n-p)/(2(p-1)(n-3))$, note that it holds at a three-factor product too, and drop "what replaces the $6$ at $p=5$" as answered.
- **Attribute the $\le\tfrac12$ bound to [L27](../findings/nondegeneracy.md)** rather than to the screen, and say that the screen could not have refuted it.
- **Restate F7 without the two figures**, or re-measure them with a poller that catches the olean-load peak.
