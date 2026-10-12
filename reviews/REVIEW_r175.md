# Gate 2, reviewer r175: the Casimir normalisation is real, and the collision it exposes is far larger at $n\ge12$ than at $n=5$

Cold adversarial review of [plan.md](../plan.md) item 3c, [REVIEW_r173.md](REVIEW_r173.md), [REVIEW_r174.md](REVIEW_r174.md), and commits `dd467c6`, `8d70505`, `7a66cce`. Deliverable: derivation. The $n\ge12$ plethysm was not run; the stable route in [sym3_weyl_blocks.sage](../scripts/runs/sym3_weyl_blocks.sage) expands no character and returns in under a second. Every number below is exact integer or rational arithmetic.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 2 | the Casimir is scalar on $\mathrm{Weyl}_5$ at exactly $16$, matching $\langle\lambda,\lambda+2\rho\rangle$ **with no convention factor** | **the number is right and it is a theorem, not a cancellation**, but "no convention factor" is true of a generator choice the record never states and false of four neighbouring ones, and **one of the three things the record says the number confirms, it cannot confirm** |
| 3 | $24$ eigenvalues, $21$ distinct, three collisions | **verified exactly**, from the closed form $c(a,b)=a^2+3a+b^2+b$; the three collisions are all of them |
| 4 | "a degree-four Casimir **or** the eigenspace dimension" separates the colliding pairs | **first half proved, second half refuted** (the dimension *detects* the fusion and produces no projector) and **the record measures the hazard at the wrong $n$: at $n=12$ the Casimir fuses $52$ of $71$ blocks into $17$ classes, one of them five blocks wide** |
| 5 | the $n\ge12$ projection is **infeasible** in dense form | **arithmetic exact, conclusion overreaches**, it prices one algorithm, and the item's own $n$-independence claim says that algorithm's coordinates are the wrong object; a symbolic route is named below at $\le140\,152$ contraction words |
| 1 | the $\mathfrak{so}(5)$ action is a homomorphism to $2.8\times10^{-15}$, skew to $2.2\times10^{-16}$ | **the mathematics is confirmed exactly and the measurement is unreproducible**, `dd467c6` touches [plan.md](../plan.md) and nothing else, so no script in the repository produces any of its four numbers |

**The result this review adds.** The eigenvalue $16$ is forced, and the reason is a clean identity worth having on the record: for $\mathfrak{so}(N)$ the bilinear form $B(X,Y)=-\tfrac12\operatorname{tr}(XY)$ makes $\{M_{ij}=E_{ij}-E_{ji}\}_{i<j}$ an **orthonormal** basis, and its dual form on $\mathfrak h^*$ is exactly the one in which $\{e_i\}$ is orthonormal. So $-\sum_{i<j}\rho(M_{ij})^2=\langle\lambda,\lambda+2\rho\rangle$ holds identically, at every $N$ and every $\lambda$, with the $e$-coordinates read literally. The agreement is structural. **What is not structural is the record's inference from it**, and what is genuinely alarming is §3.3 below.

---

## 1. Claim 2, the primary attack: the identity, and the four factors it is contingent on

### 1.1 The eigenvalue is forced, and nothing cancels

Let $\mathfrak g=\mathfrak{so}(N)$ over $\mathbb R$, $M_{ij}=E_{ij}-E_{ji}$ for $i<j$, and $B(X,Y)=-\tfrac12\operatorname{tr}(XY)$. Then

$$B(M_{ij},M_{ij})=-\tfrac12\operatorname{tr}\big(-E_{ii}-E_{jj}\big)=1,\qquad B(M_{ij},M_{kl})=0\ \ \text{for }(ij)\ne(kl),$$

so $\{M_{ij}\}_{i<j}$ is $B$-orthonormal and the Casimir element of $B$ is $\Omega_B=\sum_{i<j}M_{ij}^2$. Hence the record's operator is $C=-\sum_{i<j}\rho(M_{ij})^2=-\rho(\Omega_B)$, positive on the compact form, and its eigenvalue on $V_\lambda$ is $\langle\lambda,\lambda+2\rho\rangle$ in the form on $\mathfrak h^*$ dual to $B$.

**Which form that is, is settled by one evaluation.** On the vector representation $\rho=\mathrm{id}$ and

$$\sum_{i<j}M_{ij}^2=\sum_{i<j}\big(-E_{ii}-E_{jj}\big)=-(N-1)\,\mathrm{Id},\qquad\text{so}\qquad C=(N-1)\,\mathrm{Id}.$$

Against the Weyl formula with $\{e_i\}$ **orthonormal**: at $N=5$, $\lambda=e_1$, $\rho=(\tfrac32,\tfrac12)$, $\langle(1,0),(4,1)\rangle=4=N-1$; at $N=4$, $\rho=(1,0)$, $\langle(1,0),(3,0)\rangle=3$; at $N=6$, $\rho=(2,1,0)$, $\langle(1,0,0),(5,2,0)\rangle=5$. The dual form is $\langle e_i,e_j\rangle=\delta_{ij}$, in which the long roots $e_i\pm e_j$ have norm$^2$ $2$, the standard normalisation, corroborated by the adjoint of $B_2$: $\langle(1,1),(4,2)\rangle=6=2h^\vee$ with $h^\vee(B_2)=3$.

**So at $\lambda=(2,2)$, $\langle\lambda,\lambda+2\rho\rangle=\langle(2,2),(5,3)\rangle=10+6=16$, and $-\sum_{i<j}\rho(M_{ij})^2$ is $16$ because it must be.** There is no coincidence and there are no two conventions cancelling.

### 1.2 But "with NO convention factor" names no convention, and four nearby choices break it

The identity is contingent on the generator set being $\{M_{ij}\}_{i<j}$, unnormalised, summed **once per unordered pair**. Each of the following is a defensible reading of "the $\Lambda^2$ action built from the elementary matrices", and each moves the number:

| choice | $C$ on $\mathrm{Weyl}_5$ |
|---|---|
| $\{E_{ij}-E_{ji}\}_{i<j}$, once per pair, **the record's, implicitly** | $16$ |
| summed over all ordered $i\ne j$ | $32$ |
| generators $(E_{ij}-E_{ji})/\sqrt2$ | $8$ |
| the Killing form $\kappa(X,Y)=(N-2)\operatorname{tr}(XY)$ | $16/6=8/3$ |
| $\Lambda^2$ action taken as $\tfrac12[X,\cdot\,]$ | $4$ |

**"No convention factor" is therefore a claim about a convention the record does not state.** The sentence that carries the weight is *"generators $M_{ij}=E_{ij}-E_{ji}$, $i<j$, each summed once; equivalently the form $-\tfrac12\operatorname{tr}$, for which $\{e_i\}$ is orthonormal"*, five words that make the claim checkable, where the current line makes it an assertion about an unnamed setup.

### 1.3 Independent verification, exactly, with no SVD and no floating point

[r175_casimir_normalisation.py](../scripts/reviewers/r175/r175_casimir_normalisation.py) builds $\mathrm{Sym}^2(\Lambda^2\mathbb R^5)$, dimension $55$, in the raw basis $\omega_{ij}=e_i\wedge e_j$, takes the $\Lambda^2$ action to be $\mathrm{ad}$, which it is: if $A=uv^{\!\top}-vu^{\!\top}$ represents $u\wedge v$ then $Xu\wedge v+u\wedge Xv=XA+AX^{\!\top}=[X,A]$ for $X$ antisymmetric, and forms $C=-\sum_{i<j}A_{ij}^2$ in integer arithmetic. Results:

$$\operatorname{spec}(C)=\{\,0^{\times1},\ 4^{\times5},\ 10^{\times14},\ 16^{\times35}\,\},\qquad \text{$[X_p,X_q]$ exact on all $100$ pairs.}$$

$\mathrm{Sym}^2(\Lambda^2\mathbb R^5)=\mathrm{Weyl}_5(35)\oplus\mathrm{Sym}^2_0(14)\oplus\Lambda^4(5)\oplus\mathbb R(1)$, and the four eigenvalues are $c(2,2)=16$, $c(2,0)=10$, $c(1,0)=4$, $c(0,0)=0$ for $c(a,b)=a^2+3a+b^2+b$. **So claim 2 reproduces, and three further labels come free as a control on the construction.**

### 1.4 "One number confirming the Weyl projector, the basis orthonormality and the $\Lambda^2$ normalisation together", the middle third is false

**An eigenvalue is a similarity invariant.** $C$ is conjugated, not changed, by any change of basis of the module, so $16$ is exactly as compatible with a non-orthonormal basis as with an orthonormal one. §1.3 is the demonstration: $\{\omega_{ij}\}$ has $\operatorname{tr}(\omega^{\!\top}\omega)=2$ and the induced basis of $\mathrm{Sym}^2$ is not orthonormal either, and the spectrum is $16$ regardless.

**The check that does test orthonormality is the other one.** $\rho(X)$ is *skew* in a given basis precisely when that basis is orthonormal for the invariant inner product, so the $2.2\times10^{-16}$ skewness measurement is where the orthonormality evidence lives. The record has attached it to the wrong number.

**What $C=16$ does establish, and the record undersells the best of it.** Three things: that the projected subspace is a submodule at all, $C$ scalar is a strong test of the Weyl projector, since a wrong projector generically returns a non-submodule; that the $\Lambda^2$ action carries the right normalisation, per the table in §1.2; and, **the one worth naming**, that the block is $(2,2)$ and not $(2,1)$. Those two are both $35$-dimensional, the ambiguity [plan.md](../plan.md) flags for $4\omega_2$ against $\omega_1+2\omega_2$ and that [REVIEW_r173.md](REVIEW_r173.md) §3 and [REVIEW_r174.md](REVIEW_r174.md) §3 both flag again inside the block table. $c(2,1)=12\ne16$. **The Casimir is the cheapest discrimination the record has for a hazard it has now recorded three times, and `dd467c6` does not say so.**

---

## 2. Claim 3, verified exactly, and the collisions have a closed form

$c(a,b)=\langle(a,b),(a+3,b+1)\rangle=a^2+3a+b^2+b$. Applied to the $24$ blocks of [REVIEW_r173.md](REVIEW_r173.md) §3, [r175_block_separation.sage](../scripts/reviewers/r175/r175_block_separation.sage) returns

$$0,4,10,12,16,18,20,24,28,30,30,34,40,40,42,46,48,52,54,60,60,66,74,96$$

the record's list, entry for entry, $21$ distinct, and the three collisions are

| $c$ | blocks | fused eigenspace $\sum m_\lambda d_\lambda$ |
|---|---|---|
| $30$ | $(3,3)_{84}$ mult $1$ · $(4,1)_{154}$ mult $2$ | $392$ |
| $40$ | $(5,0)_{91}$ mult $1$ · $(4,3)_{231}$ mult $2$ | $553$ |
| $60$ | $(5,4)_{429}$ mult $1$ · $(6,2)_{625}$ mult $1$ | $1054$ |

**and there are no others.** The structure is visible in doubled coordinates: with $x=2a+3$, $y=2b+1$ one has $x^2+y^2=4c+10$, so a collision is a repeated representation of an integer as a sum of two odd squares with $x>y$, $130=9^2+7^2=11^2+3^2$, $170=13^2+1^2=11^2+7^2$, $250=13^2+9^2=15^2+5^2$. These are Gaussian-integer factorisation coincidences, they are **dense**, and their frequency grows with the weight range. That is the reason §3.3 comes out the way it does.

---

## 3. Claim 4: the degree-four fix is half a fix, and the record measures it at the wrong $n$

### 3.1 "A degree-four Casimir separates them" is true, and provable in three lines

By Harish-Chandra, $Z(U(\mathfrak g))\cong\mathbb C[\mathfrak h^*]^W$ with $V_\lambda$ sent to evaluation at $\lambda+\rho$. For $B_2$, $W$ is the signed permutations of two letters and $\mathbb C[\mathfrak h^*]^W=\mathbb C[p_2,p_4]$, $p_k=x_1^k+x_2^k$. So the central character of a block is the pair $\big(p_2(\lambda+\rho),p_4(\lambda+\rho)\big)$ and it is a **complete** invariant of $\lambda$.

Let $z$ be any degree-four central element, image $\alpha p_4+\beta p_2^2+(\text{lower})$ with $\alpha\ne0$, the fourth Gel'fand invariant $\sum_{ijkl}A_{ij}A_{jk}A_{kl}A_{li}$ is one, with integer coefficients, hence exact over $\mathbb Q$ as the record says. On a colliding pair $c_2$ agrees, so $p_2$ agrees, so the $p_2^2$ and lower parts agree, and the eigenvalues of $z$ differ by $\alpha\,\Delta p_4\ne0$. **Separation is guaranteed for exactly the pairs $c_2$ fails on**, which is a stronger statement than the record makes. In doubled coordinates $p_4=(2a+3)^4+(2b+1)^4$:

| $c$ | $p_4$ | $p_4$ |
|---|---|---|
| $30$ | $(3,3)\mapsto8962$ | $(4,1)\mapsto14722$ |
| $40$ | $(5,0)\mapsto28562$ | $(4,3)\mapsto17042$ |
| $60$ | $(5,4)\mapsto35122$ | $(6,2)\mapsto51250$ |

and $(c_2,p_4)$ is injective on all $24$ blocks.

### 3.2 "Or the eigenspace dimension" is not a separation, it is a smoke alarm

The two are offered as alternatives. They are not the same kind of object. The $c=30$ eigenspace of $C$ inside $\mathrm{Sym}^3(\mathrm{Weyl}_5)$ is $84\cdot1+154\cdot2=392$-dimensional; **its dimension is a number and yields no projector onto the $(3,3)$ and $(4,1)$ summands.** The certificate needs the summands, because the whole reduction from a $7770\times7770$ Gram to $65$ unknowns is the isotypic splitting.

What the dimension does is **detect**: $392$, $553$ and $1054$ are not $m_\lambda d_\lambda$ for any single entry of the table, so a mismatch fires. That is worth having and worth recording, as a consistency check on a projection, not as one of two ways to build one. **As written, half of the sentence licenses a method that does not exist.**

### 3.3 The hazard is measured at $n=5$ and the item is aimed at $n\ge12$, where it is nine times worse

This is the finding that changes the item. Running the same test on the stable table, [r175_stable_casimir_collisions.sage](../scripts/reviewers/r175/r175_stable_casimir_collisions.sage), the plethysm-free route, no character expanded, at $n=12$:

$$\boxed{\ c_2\ \text{separates}\ \mathbf{36}\ \text{of the}\ \mathbf{71}\ \text{blocks: }\mathbf{52}\ \text{blocks fuse into }\mathbf{17}\ \text{classes, the largest }\mathbf{5}\ \text{blocks wide}\ }$$

Sample classes: $c=104$ merges $[3,3,2,2,1,1]$, $[3,3,3,1]$, $[4,2,2,2]$, $[4,3,1,1,1]$ and $[4,4]$; $c=120$ merges five more; $c=96$ merges $[3,3,2,1,1]$, $[4,3,1]$, $[5,1,1,1]$ and $[6]$. **Against three collisions among $24$ at $n=5$, this is $73\%$ of the table fused rather than $12\%$**, and the run also reproduces $\sum m_\lambda\dim V_\lambda=733\,813\,080=\binom{1640}3$ exactly, which independently re-verifies the $71$-block table and the plan's $\mathrm{Sym}^3$ dimension.

**Three consequences.**

- **The record's "the fix is cheap: each pair differs in dimension" is reasoning from an $n=5$ accident.** It happens to survive (I checked, and no two blocks inside any of the $17$ classes at $n=12$ share a dimension) but nothing in the record derives that, and at $n=12$ it would be a check over $17$ classes rather than three pairs.
- **The degree-four fix does survive, and that is worth stating rather than assuming.** $(c_2,c_4)$ separates all $71$ at $n=12$. It is not automatic: $\mathfrak{so}(12)$ has rank $6$, so $\mathbb C[\mathfrak h^*]^{W(D_6)}=\mathbb C[p_2,p_4,p_6,p_8,p_{10},e_6]$ and a complete central character needs six invariants; only the measurement above shows that two suffice on *this* set of $71$ weights. **And $e_6$, the Pfaffian, must be excluded**: it is odd under the sign flip that exchanges the two chiral halves of a six-row label, so using it would split $O(12)$-blocks that the certificate must keep together, the same $SO$-versus-$O$ error the item already carries, re-entering through the separator.
- **The collision is an artifact of the chosen method.** [REVIEW_r173.md](REVIEW_r173.md) §4 and [REVIEW_r174.md](REVIEW_r174.md) §4 each put the Casimir interpolation projector $\prod_{\nu\ne\lambda}(C-c_\nu)/(c_\lambda-c_\nu)$ on the record as *the* exact rational implementation of isotypic projection. **That formula is what `dd467c6` refutes**, with $21$ distinct nodes it interpolates over $21$ values and returns the projector onto the fused sum, and at the colliding $\lambda$ it is not even well defined. Both of those reviews also preferred highest-weight vectors on cost grounds, and **the highest-weight route never meets a collision**, because the weight is read off directly inside a weight space of dimension $\le234$. So the item's "the fix is cheap" answers a difficulty created by taking the more expensive road. The record should say which of the two methods it is committing to; if it is highest-weight vectors, §3 of this review is moot and the Casimir table is a cross-check rather than machinery.

Finally, on "cheap": forming $C$ on $\mathrm{Sym}^3(\mathrm{Weyl}_5)$ is a $7770\times7770$ operator and a degree-four Casimir is four of its factors. That is affordable, and it is three orders of magnitude above the $234$ that [REVIEW_r174.md](REVIEW_r174.md) established as the true cost of the alternative.

---

## 4. Claim 5: the arithmetic is exact and it prices one algorithm

**Every figure checks.** $\dim\mathrm{Weyl}_{12}=\tfrac1{12}\cdot12\cdot13\cdot14\cdot9=1638$; $\dim\mathrm{Sym}^3=\binom{1640}3=733\,813\,080$; at eight bytes, $5.87$ GB per dense vector and $184$ of them is $1.080$ TB.

**And the item's own next-door claim says those coordinates are the wrong object.** [plan.md](../plan.md) records that *"the $71$ blocks carry $n$-independent labels and multiplicities for every $n\ge12$"*. If the decomposition is $n$-independent, the SDP is $n$-independent, and $733\,813\,080$ is precisely the $n$-dependence the stability claim says is absent. A price quoted in coordinates of a space whose dimension does not appear in the answer is a price for an implementation, not for the step.

**A symbolic route, named and priced.** A cubic covariant $\mathrm{Weyl}_n\to V_\lambda$ is a linear combination of contraction words on $W\otimes W\otimes W$, which carries $12$ indices. The words are the partial matchings of $12$ letters, so there are at most $I(12)=140\,152$ of them, and they are $n$-independent symbols, $n$ enters only through $\delta^a{}_a$ in a closed trace, hence polynomially. The $184$ covariants are $184$ rational vectors in that $140\,152$-dimensional span. The degree-six invariants then come free as the $\binom{185}2=17\,020$ pairings $\langle B^p_\lambda(W),B^q_\lambda(W)\rangle$, expressed in the $89$-dimensional invariant space: $17\,020\times89\approx1.5$ million rationals, about $12$ MB, **and it returns every $n\ge12$ at once.** Seven orders of magnitude under $1.1$ TB.

*The same correction retires a second figure the record leans on.* [ATTEMPTS.md](../ATTEMPTS.md) Result 3 closes the degree-six invariant count as unaffordable at $23!!=3.16\times10^{10}$ contractions. One never enumerates degree-six contractions: the degree-six invariants are pairings of degree-three covariants, and degree three is $I(12)=140\,152$. The $89$ is in hand from character theory besides.

**What follows for the grade line.** I have named a route and sketched its size; I have not built it, so `attackable` $=1$ remains defensible **as "no route is priced to completion"**. What is not defensible is the wording at [plan.md:81](../plan.md#L81) (*"the dense projection is **infeasible**, and no sparse method is named"*), on two counts: $1.1$ TB shows one algorithm is closed rather than the step, and a symbolic method is now named. The route-closing language should come out; the number should stay.

---

## 5. Answers to the three questions

### (a) Asserted as new, already on the record, two

- **The Casimir interpolation projector.** `dd467c6` treats "a single polynomial in $C$" as a generic hazard. It is the specific formula that [REVIEW_r173.md](REVIEW_r173.md) §4 and [REVIEW_r174.md](REVIEW_r174.md) §4 each supplied, in each case as the answer to "group averaging would introduce approximation". The commit is a refutation of two named reviews and reads as an unattributed observation.
- **The $(2,2)$ against $(2,1)$ ambiguity at dimension $35$.** On the record three times, [plan.md](../plan.md)'s $4\omega_2$ note, [REVIEW_r173.md](REVIEW_r173.md) §3, [REVIEW_r174.md](REVIEW_r174.md) §3. $c=16$ against $c=12$ resolves it, and that is the strongest thing `dd467c6` proves; the commit does not connect them.

### (b) Are 3c's two grades right, $(n\ge12)$ at $3$, $(n=5)$ at $3$?

**$3$c$(n=5)$ at $1\times3\times1=3$: agree, unchanged.** Nothing here touches it; the reduced problem is $36$ unknowns against $14$ constraints and only the projection is owed.

**$3$c$(n\ge12)$ at $3\times1\times1=3$: the number stands, the justification does not.** `closes` $=3$ is untouched. `attackable` $=1$ survives on "no route priced to completion", not on infeasibility, §4. And §3.3 supplies an independent reason not to raise it: the machinery the $n=5$ half is building transfers to $n\ge12$ in a materially worse regime, $52$ of $71$ blocks fused rather than $3$ of $24$, so the calibration is easier than the target in a way the record has not registered.

### (c) Is anything in the $n=5$ pipeline still unverified before the projection is built on it?, four things

1. **`dd467c6` has no script.** `git show --stat dd467c6` is [plan.md](../plan.md) alone, the working tree is clean, and no file in [scripts/](../scripts/) produces the $\mathfrak{so}(5)$ action, the $2.8\times10^{-15}$, the $2.2\times10^{-16}$, the $16$, or the $24$-entry table. Two of the four I have now rebuilt from scratch and committed; the two floating-point residuals remain unreproducible from the repository. **An item whose next step is a projection should not rest its verification layer on numbers no one can re-run.**
2. **Floating point where exact is free.** The record's pipeline goes through an SVD of projected elementary matrices. §1.3 gets the same module and the same Casimir in integer arithmetic in fifty lines, and the same is available on $\mathrm{Sym}^3$ over $\mathbb Q$. The certificate must be rational at the end; starting rational costs nothing.
3. **No covariant exists.** The gap between the block table and the SDP is the $41$ highest-weight vectors, and not one has been constructed. This is what [REVIEW_r173.md](REVIEW_r173.md) called "the one substantial step remaining" and it is still entirely owed.
4. **The $14$ constraints have never been written down.** Their *count* is reproduced three ways; no explicit basis of $(\mathrm{Sym}^6\mathrm{Weyl}_5)^{O(5)}$ is on the record, and the SDP cannot be assembled without one.

---

## Scripts

Under [scripts/reviewers/r175/](../scripts/reviewers/r175/), each runnable alone, total wall clock under thirty seconds.

| script | what it settles |
|---|---|
| [r175_casimir_normalisation.py](../scripts/reviewers/r175/r175_casimir_normalisation.py) | $C=-\sum_{i<j}A_{ij}^2$ on $\mathrm{Sym}^2(\Lambda^2\mathbb R^5)$ has spectrum $\{0^1,4^5,10^{14},16^{35}\}$ in integer arithmetic; the bracket relations are exact on all $100$ pairs; no SVD, non-orthonormal basis |
| [r175_block_separation.sage](../scripts/reviewers/r175/r175_block_separation.sage) | the $24$ eigenvalues, $21$ distinct, the three collisions and no others; $p_4$ separates each pair; $(c_2,p_4)$ injective on all $24$ |
| [r175_stable_casimir_collisions.sage](../scripts/reviewers/r175/r175_stable_casimir_collisions.sage) | at $n=12$, $c_2$ separates $36$ of $71$; $(c_2,c_4)$ separates $71$; no fused class contains equal dimensions; $\sum m_\lambda d_\lambda=\binom{1640}3$ |

## What I ran, and what I did not

The $n\ge12$ plethysm was not invoked; §3.3 and §4 use [sym3_weyl_blocks.sage](../scripts/runs/sym3_weyl_blocks.sage)'s stable symmetric-function route, which expands no character. Everything else is $B_2$ character theory, one $55\times55$ integer eigenvalue problem, and closed-form arithmetic. The derivations in §1.1, §3.1 and §4 are on paper and were checked against the runs above.
