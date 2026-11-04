# Gate 2, reviewer r176: the Casimir normalisation, the collision table, and the price of the $n\ge12$ projection

Cold adversarial review of [plan.md](../plan.md) item 3c, [REVIEW_r173.md](REVIEW_r173.md), [REVIEW_r174.md](REVIEW_r174.md), and commits `dd467c6`, `8d70505`, `7a66cce`. Deliverable: derivation. The $n\ge12$ plethysm was not run, every $n=12$ figure below comes from the $853$-weight multiset of $\mathrm{Weyl}_{12}$ convolved in plain Python, which never forms a character.

**Written cold against the three named commits.** While this review was being derived, reviewer 175 filed and [plan.md](../plan.md) was amended at `624f846`, which folds in corrections to claims 2, 3 and 4 and withdraws the word *infeasible* from claim 5. **Reviewer 175 and I converged independently on the $16$-is-forced derivation, on the eigenspace dimension being a detector rather than a projector, and on the $n=12$ collision being far worse, three findings each reached twice from cold.** The verdicts below are against the pre-amendment text; §6 says what survives the amendment, and two things do.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | the $\mathfrak{so}(5)$ action on $\mathrm{Weyl}_5$ is a homomorphism to $2.8\times10^{-15}$, skew to $2.2\times10^{-16}$ | **verified, and exactly**, the natural construction is skew to $0.0$ in machine arithmetic, so the tolerance understates what is available |
| 2 | the Casimir is scalar on $\mathrm{Weyl}_5$ at exactly $16$, "with NO convention factor" | **the number is right and reproduces from scratch; the phrase is wrong.** The factor is $1$ *because* a specific normalisation was chosen; under the Killing form the same object reads $8/3$ |
| 3 | the $24$ eigenvalues, $21$ distinct, three collisions | **verified exactly**, by four independent routes; the list is complete and the three collisions are the only ones |
| 4 | "a degree-four Casimir or the eigenspace dimension separates them, both exact over $\mathbb Q$" | **half right, and the wrong half is stated first-class.** The quartic Casimir does separate, proved below, not merely asserted. The eigenspace dimension separates **nothing**: it is a number attached to a subspace, not an operator |
| 5 | the $n\ge12$ projection is **infeasible** in dense form, so `attackable` $\to1$ | **REFUTED as a route-closing statement.** The largest object the projection touches at $n=12$ is $635\,220$ numbers, $5.1$ MB, not $5.9$ GB, and all $71$ blocks together are $15.7$ MB, not $1.1$ TB. The record's own [plan.md:316](../plan.md#L316) already states the correct measure |

**The result this review adds.** The collision hazard of claim 3 is far worse at $n=12$ than the record's $n=5$ table suggests, and the record has not looked. Among the $71$ stable blocks the quadratic Casimir takes only $36$ distinct values, merging $\mathbf{52}$ of the $\mathbf{71}$ blocks into $17$ classes, two of which are **five-fold**. The quartic rescues it ($(c_2,c_4)$ separates all $71$) but that is a contingent fact about this set of labels, not a theorem, since $\mathfrak{so}(12)$ has rank $6$ and its centre needs six generators.

---

## 1. Claim 2, the $16$ is real, and it is a convention check rather than a convention-free coincidence

### 1.1 The derivation the record does not give

The record asserts agreement without saying which bilinear form its Casimir belongs to, and that is exactly where a convention factor would hide. Write $L_{ij}=E_{ij}-E_{ji}$ for the ten generators of $\mathfrak{so}(5)$ in the vector representation. Then

$$\mathop{\mathrm{tr}}(L_{ij}L_{ij})=-2,\qquad\text{so } B(X,Y):=\tfrac12\mathop{\mathrm{tr}}(XY)\ \text{ makes } \{L_{ij}\}\ \text{orthonormal up to sign,}$$

and $C:=-\sum_{i<j}A_{ij}^2$ is the Casimir element for $B$. On the vector representation itself $L_{ij}^2=-(E_{ii}+E_{jj})$, so

$$C\big|_{\mathbb R^5}=\sum_{i<j}(E_{ii}+E_{jj})=(n-1)\,\mathrm{Id}=4\,\mathrm{Id},$$

against $\langle\lambda,\lambda+2\rho\rangle=1\cdot(1+3)+0=4$ for $\lambda=(1,0)$. **That single line is the whole content of "no convention factor"**: it fixes $B=\tfrac12\mathop{\mathrm{tr}}$, and $B$ is precisely the form under which the $e$-coordinates on $\mathfrak h^*$ are orthonormal, which is the form $\langle\lambda,\lambda+2\rho\rangle$ presupposes. The agreement at $\lambda=(2,2)$ is then forced rather than lucky.

### 1.2 There is a convention, and naming the alternative shows it

For $\mathfrak{so}(n)$ the Killing form is $\kappa=(n-2)\mathop{\mathrm{tr}}$, so at $n=5$, $\kappa=6B$. Had the generators been normalised against $\kappa$ (the default in a great deal of the literature), the same operator on $\mathrm{Weyl}_5$ would read $16/6=8/3$. **So "with NO convention factor" is a claim about the chosen normalisation, and it should be recorded as one.** The correct sentence is *"the generators are $B$-orthonormal for $B=\tfrac12\mathop{\mathrm{tr}}$, which is the form the $e$-coordinates are orthonormal for, so the Casimir reads $\langle\lambda,\lambda+2\rho\rangle$ on the nose."* As written, the record invites a later reader to reproduce the computation with $\kappa$-normalised generators and conclude the record is wrong by a factor of six.

### 1.3 Reproduced from scratch, and the accompanying sentence over-claims

[casimir.py](../scripts/reviewers/r176/casimir.py) builds the whole thing from the ten elementary skew matrices, with no reference to the record's code and **no Weyl projector at all**: the $\Lambda^2$ action, then $X.M=[\rho_{\Lambda^2}(X),M]$ on symmetric $10\times10$ matrices, then $C=-\sum A_p^2$ on that $55$-dimensional space. The spectrum is

$$C\big|_{\mathrm{Sym}^2(\Lambda^2\mathbb R^5)}:\quad 0^{\times1},\ 4^{\times5},\ 10^{\times14},\ \boxed{16^{\times35}}$$

exactly the $O(5)$-decomposition $[2,2]\oplus[2]\oplus\Lambda^4\oplus[\,]$ with $\langle\lambda,\lambda+2\rho\rangle=16,10,4,0$. Skewness came out at $0.0$, not $2.2\times10^{-16}$.

**Two consequences for the record's gloss**, *"one number confirming the Weyl projector, the basis orthonormality and the $\Lambda^2$ normalisation together"*:

- **The $16$ does not confirm basis orthonormality.** $C$ is built from the commutator action $X.M=[\rho(X),M]$, which is conjugation and therefore basis-free; its eigenvalues are invariant under *any* change of basis, orthonormal or not. What tests orthonormality is the skewness check, which is a different number in the same package.
- **The $16$ does confirm the Weyl projector**, in the strong sense that the $c=16$ eigenspace of $C$ inside $\mathrm{Sym}^2(\Lambda^2\mathbb R^5)$ *is* $\mathrm{Weyl}_5$, so a projector landing on any other $35$-dimensional subspace would fail scalarity. It also settles the $4\omega_2$-versus-$\omega_1{+}2\omega_2$ ambiguity the item flags: $(2,1)$ has $\langle\lambda,\lambda+2\rho\rangle=12$, and $12$ and $16$ both occur in the block table as distinct blocks of dimension $35$.

**Verdict: the number stands, the derivation is now on the record, and the phrase "with NO convention factor" should be replaced by the normalisation that produces it.**

---

## 2. Claim 3, the eigenvalue list is exactly right, and it is over-determined four ways

I reconstructed the table without using the record's list, then checked the record's list against it.

**Route 1, on paper.** Weyl dimension for $B_2$ with $\ell=\lambda+\rho=(p,q)$ is $\tfrac23pq(p^2-q^2)$, and $c=a(a+3)+b(b+1)$. The thirteen named blocks fix thirteen values; the eleven unnamed ones are forced by solving $a(a+3)+b(b+1)=c$ over $a\ge b\ge0$ for the residual $c\in\{0,4,30,40,42,52,54,60,60,66,96\}$, which has a unique dominant solution in every case: $(5,1)_{260}$, $(5,3)_{455}$, $(6,0)_{140}$, $(6,3)_{770}$, $(6,6)_{455}$ alongside $()_1$, $(1)_5$, $(3,3)_{84}$, $(5,0)_{91}$, $(5,4)_{429}$, $(6,2)_{625}$.

**Route 2, the closure check.** $\sum m_\lambda d_\lambda$ over the reconstructed table is $7770$ **exactly**, $=\binom{37}3=\dim\mathrm{Sym}^3(\mathrm{Weyl}_5)$. A wrong assignment anywhere would miss this.

**Route 3, the orbit check.** Reviewer 174's rule ($\dim V_\lambda^H=1$ iff the second label is even), selects exactly **sixteen** of my reconstructed blocks, and their dimensions sum to **$3570$ on the nose**, the measured orbit span. Applying $m_\lambda\mapsto m_\lambda-1$ on those sixteen gives **$36$** surviving unknowns in **two $3\times3$, five $2\times2$ and nine scalars**, every figure of [plan.md:320](../plan.md#L320)'s box, recovered from a table built independently.

**Route 4, Sage.** [n5b.sage](../scripts/reviewers/r176/n5b.sage) runs `WeylCharacterRing("B2")(0,4).symmetric_power(3)` and returns the identical $24$ rows, $41$ multiplicities, $65$ unknowns, the eigenvalue list character-for-character, $21$ distinct, span $3570$, residual $36$, shapes $\{1:9,\ 2:5,\ 3:2\}$.

**So claim 3 is verified, and no fourth collision was missed.** The three doubles are the only repeats in a list whose completeness is pinned by $\sum m_\lambda d_\lambda=7770$.

---

## 3. Claim 4, the quartic works, the dimension does not, and neither is the cheapest fix

### 3.1 The observation behind the fix is genuinely new and corrects both prior reviews

Worth saying plainly before attacking the remedy. [REVIEW_r173.md](REVIEW_r173.md) §4 and [REVIEW_r174.md](REVIEW_r174.md) §4 both proposed the Lagrange interpolation projector

$$\Pi_\lambda=\prod_{\nu\ne\lambda}\frac{C-c_\nu}{c_\lambda-c_\nu}$$

as the exact-over-$\mathbb Q$ answer to "group averaging introduces approximation", and [plan.md:316](../plan.md#L316) folded that in verbatim. **With $c_\nu$ repeated the formula does not even typecheck** (the product contains $(C-30)/(30-30)$) and the nearest well-formed version projects onto the $c=30$ *eigenspace*, which is $V_{(3,3)}\oplus V_{(4,1)}^{\oplus2}$, dimension $392$. `dd467c6` catches an error that two reviewers and the plan all carried. That is the substance of the commit and it is correct.

### 3.2 The quartic Casimir does separate, here is why, which the record does not say

Harish-Chandra identifies $Z(U(\mathfrak{so}(5)))$ with the $W(B_2)$-invariants in $\mathbb C[\mathfrak h^*]$, evaluated at $\ell=\lambda+\rho$. $W(B_2)$ is the signed permutations of $(p,q)$, so the invariant ring is generated by

$$e_1=p^2+q^2,\qquad e_2=p^2q^2,$$

of degrees $2$ and $4$ in $\ell$. The quadratic Casimir is $e_1-|\rho|^2=e_1-\tfrac52$. Any degree-$4$ **generator** of the centre has Harish-Chandra image involving $e_2$ with nonzero coefficient, for the standard $C_4=\mathop{\mathrm{tr}}(F^4)$ the image is $p^4+q^4+(\text{lower in }e_1)=e_1^2-2e_2+\cdots$. Since $(e_1,e_2)$ determines the multiset $\{p^2,q^2\}$, and $p>q>0$ for dominant $\lambda$, the pair $(c_2,c_4)$ **determines $\lambda$ outright**. So no pair can remain merged, at $n=5$ or anywhere in $B_2$. Explicitly, [quartic.sage](../scripts/reviewers/r176/quartic.sage):

| pair | $p^2+q^2$ (equal) | $p^2q^2$ | $p^4+q^4$ |
|---|---|---|---|
| $(3,3)_{84}$ vs $(4,1)_{154}$ | $65/2$ | $3969/16$ vs $1089/16$ | $4481/8$ vs $7361/8$ |
| $(5,0)_{91}$ vs $(4,3)_{231}$ | $85/2$ | $169/16$ vs $5929/16$ | $14281/8$ vs $8521/8$ |
| $(5,4)_{429}$ vs $(6,2)_{625}$ | $125/2$ | $13689/16$ vs $5625/16$ | $17561/8$ vs $25625/8$ |

All rational, so "exact over $\mathbb Q$" holds. **And the cost is small for the reason the record gives but does not quantify**: $C_4$ is never needed on all of $\mathrm{Sym}^3$, only on the three merged eigenspaces, of dimensions $392$, $553$ and $1054$.

**One correction to the phrasing.** *"A degree-four Casimir"* is false with the indefinite article: $C_2^2$ is a perfectly good degree-four central element and separates nothing. The claim needs *a degree-four **generator** of the centre*, and that distinction is the entire content of why the fix works.

### 3.3 The eigenspace dimension is not a fix

*"Each pair differs in dimension, so … the eigenspace dimension separates them"* is the sentence to strike. Dimension is an invariant of the merged subspace; it is not an operator and does not produce a projector. Knowing $\dim\ker(C-30)=84+2\cdot154=392$ tells you the pair is present (it is a **detector**) and gives no map onto either isotypic piece. The record presents it as an alternative to the quartic, on equal footing, and it is not on any footing. A block decomposition needs $\Pi_{(3,3)}$ and $\Pi_{(4,1)}$ as matrices; a cardinal number supplies neither.

### 3.4 The cheapest fix is free, and the plan already uses it

Neither remedy is needed. For all three pairs, **the highest weight of each is not a weight of the other**, verified in [quartic.sage](../scripts/reviewers/r176/quartic.sage): $(4,1)$ lies outside the convex hull of $W\!\cdot\!(3,3)$ (first coordinate $4>3$), $(3,3)$ lies outside the hull of $W\!\cdot\!(4,1)$ ($x+y=6>5$), and likewise for the other two pairs. So the Cartan grading alone splits every collision, at no cost, and the Cartan grading is exactly what [plan.md:316](../plan.md#L316)'s adopted method, *"highest-weight vectors, in exact arithmetic"*, is built on. **The collision hazard bites only the Casimir-interpolation route, which the item mentions but does not use.** That should be said, because as written the item reads as though the projection now needs a quartic Casimir it does not need.

### 3.5 The finding is much larger at $n\ge12$, and the record has not looked

This is where the collision table earns its keep. Taking the $71$ stable $O(n)$ labels from the record's own [sym3_weyl_blocks.sage](../scripts/runs/sym3_weyl_blocks.sage) and $c=\sum\lambda_i(\lambda_i+2\rho_i)$ with $\rho=(5,4,3,2,1,0)$, [collide12.py](../scripts/reviewers/r176/collide12.py) gives

$$\boxed{\ \textbf{36 distinct Casimir values across 71 blocks; 52 blocks merged into 17 classes}\ }$$

with **two five-fold classes**, $c=104$ merging $[3,3,2,2,1,1]$, $[3,3,3,1]$, $[4,2,2,2]$, $[4,3,1,1,1]$, $[4,4]$ (multiplicities $1,2,3,2,4$), and $c=120$ merging $[3,3,3,3]$, $[4,3,2,2,1]$, $[4,4,1,1,1,1]$, $[4,4,2]$, $[5,3,1,1]$, and three four-fold classes. At $n=5$ the damage is three pairs out of $24$ blocks; at $n=12$ it is $73\%$ of the blocks. **The record states the hazard at the calibration dimension and not at the dimension that closes the conjecture.**

The good news, and it is contingent rather than structural: [tower.py](../scripts/reviewers/r176/tower.py) confirms $(c_2,c_4)$ separates all $71$. **This is luck, not a theorem.** $\mathfrak{so}(12)$ has rank $6$, so $Z(U)$ needs six generators (degrees $2,4,6,8,10$ and the Pfaffian) and two of them are not in general enough; they happen to suffice on these particular $71$ labels. Any later change to the ansatz that alters the label set must re-run the check. Separately, [dims12.py](../scripts/reviewers/r176/dims12.py) confirms no two merged blocks share a dimension at $n=12$ either, so the record's dimension observation survives as a fact while remaining useless as a separator, per §3.3.

---

## 4. Claim 5, "infeasible" is wrong, and it is the expensive kind of wrong

[plan.md:340](../plan.md#L340) prices the projection at $733\,813\,080\times8$ bytes $=5.9$ GB per vector, $\times184$ multiplicities $=1.1$ TB, and [plan.md:81](../plan.md#L81) drops `attackable` to $1$ on that basis. The arithmetic is correct. **The measure is not, and the record says so itself twenty-four lines earlier.**

### 4.1 The record already rejects its own measure

[plan.md:316](../plan.md#L316), folded in from [REVIEW_r174.md](REVIEW_r174.md) §4 barely half an hour before `8d70505`:

> *What actually prices the projection is the largest weight space, $234$, not the largest multiplicity, and not the $7770$ basis vectors either.*

At $n=5$ the item prices the projection by the largest weight space and explicitly disowns the ambient dimension. At $n\ge12$ it prices it by the ambient dimension. **Both cannot be right, and the correct one is the earlier.** A highest-weight vector of weight $\lambda$ is the kernel of the raising operators *inside the $\lambda$-weight space*; the Cartan grading is free, and no algorithm that knows the grading exists stores a vector in the ungraded space.

### 4.2 The correct price at $n=12$

Convolving the $853$-weight multiset of $\mathrm{Weyl}_{12}$ three times with the $\mathrm{Sym}^3$ plethysm correction, [n12w2.sage](../scripts/reviewers/r176/n12w2.sage) plus [sym3w.py](../scripts/reviewers/r176/sym3w.py), a few seconds and no character:

- $\dim\mathrm{Sym}^3(\mathrm{Weyl}_{12})=733\,813\,080$, reproducing the record's figure exactly and confirming its arithmetic;
- the **largest weight space of $\mathrm{Sym}^3(\mathrm{Weyl}_{12})$ is $635\,220$**, at weight $0$, a factor $1155$ below the ambient dimension, i.e. $\mathbf{5.1}$ **MB, not** $\mathbf{5.9}$ **GB**;
- [price.py](../scripts/reviewers/r176/price.py) evaluates the weight space at each of the $71$ block highest weights. **The sum over all $71$ is $1\,959\,767$ coordinates $=15.7$ MB**, against the record's $1.1$ TB, a factor of $\mathbf{7\times10^4}$.

| block $\lambda$ | weight-space dim | note |
|---|---|---|
| $[\,]$ | $635\,220$ | trivial block, mult $2$, **already known four ways**, [ATTEMPTS.md](../ATTEMPTS.md) Result 3 |
| $[2]$ | $266\,000$ | largest block actually requiring work |
| $[2,2]$ | $106\,431$ | $\mathrm{Weyl}_{12}$ itself, mult $8$ |
| median of the $71$ | $810$ | |
| $[6,6]$ | $1$ | |

**Forty of the $71$ blocks have weight spaces under $4\,000$.** The single hard one is the trivial block, and the record already holds its multiplicity.

### 4.3 The naive framing double-counts even on its own terms

The $184$ multiplicity vectors do not occupy $184$ independent ambient vectors: they are distributed over $71$ weight spaces, so even without the grading insight the storage is $71$ weight spaces, not $184\times\dim\mathrm{Sym}^3$. And the projection is a per-block computation, nothing requires all of them resident at once.

### 4.4 What is actually left, stated honestly

The remaining work is a sparse nullspace: for each $\lambda$, the kernel of the six simple raising operators mapping the $\lambda$-weight space into its neighbours. The operators act as derivations on $\mathrm{Sym}^3$ and are sparse (order $3\times O(n)$ nonzeros per column) so the largest system is of order $6\times10^5$ columns with a few $10^7$ nonzeros, and the kernel dimension is the multiplicity, at most $9$. That is a standard sparse solve, and over a small prime with rational reconstruction it is comfortably a laptop computation. **I did not build these operators at $n=12$, so this paragraph is an estimate of the remaining work, not a measurement of it**, but the gap between $15.7$ MB and $1.1$ TB is not an estimate.

### 4.5 And "no sparse or symbolic method is named on the record" is false twice

[plan.md:342](../plan.md#L342) closed the route on the ground that *"a route must be invented (a sparse or purely symbolic projection) and none is named on the record."* **Two are**, and the sentence has since been replaced at `624f846`, though the grade row at [plan.md:81](../plan.md#L81) still carries it (§6.2).

- **The weight-space method is named**, at [plan.md:316](../plan.md#L316), in this same item, for $n=5$. It is $n$-independent in kind: the Cartan grading exists at every $n$.
- **A purely symbolic method is not merely named but committed and running.** [sym3_weyl_blocks.sage](../scripts/runs/sym3_weyl_blocks.sage) handles $\mathrm{Sym}^3(\mathrm{Weyl}_{12})$ in **under a second** (I ran it: $71$ blocks, $184$ multiplicities, $477$ unknowns, $89$ constraints), by taking the plethysm in the orthogonal symmetric-function basis with no character expanded. Its own docstring says so. It delivers the decomposition rather than the covariants, which is a real distinction, but the sentence as written says no such method exists at all.

**Verdict: `attackable` should not have dropped. The $n\ge12$ half is priced at $15.7$ MB of coordinates and one sparse kernel per block; the obstacle is work, not a wall.** Closing a route on a storage figure the item elsewhere rejects is the error the brief was right to be worried about.

---

## 5. The brief's three questions

**(a) One thing asserted as new that the record already holds.** The figure $733\,813\,080$ and its identification as 3c's own unreduced Gram are already at [plan.md:283](../plan.md#L283), several commits earlier. `8d70505` re-derives it and converts it into a route closure; the number is not new, and the conversion is the part that does not survive §4. Everything else in `dd467c6` (the eigenvalue table, the collisions, the $C=16$ normalisation check), is new, and the collision finding corrects a sentence that two prior reviewers and the plan all carried.

**(b) The two grades are not both right.**

| row | recorded | my reading |
|---|---|---|
| 3c($n\ge12$) | $3\times1\times1=3$ | **$3\times2\times1=6$**, `attackable` returns to $2$. The projection is priced at $15.7$ MB across $71$ blocks, the largest single system is $6\times10^5$ columns sparse, and two methods are named on the record. Nothing here warrants $1$ |
| 3c($n=5$) | $1\times3\times1=3$ | **$3$ stands.** `closes` $=1$ is right by the item's own no-lift note; `attackable` $=3$ is right and now over-determined, I reproduced all of $24$ blocks, $7770$, $3570$ and $36$ from an independently built table |

The split itself, from `7a66cce`, is sound and should stay.

**(c) Three things in the $n=5$ pipeline are still unverified.**

- **The projection itself.** Every *number* is verified, I reproduced the block table, the eigenvalue list, the span $3570$, the $36$ unknowns and the shapes $\{3,3,2,2,2,2,2,1^{\times9}\}$, but not one highest-weight vector has been exhibited. The item's own *"the one substantial step remaining"* is accurate and nothing this cycle moved it.
- **The Casimir-interpolation projector must not be used as written**, per §3.1: at $n=5$ it is ill-defined at $c=30,40,60$. The remedy in force should be the Cartan grading (§3.4), not a quartic Casimir.
- **Exactness of the action is claimed at floating-point tolerance.** The homomorphism at $2.8\times10^{-15}$ and skewness at $2.2\times10^{-16}$ are $\mathbb Q$-checkable in seconds, [casimir.py](../scripts/reviewers/r176/casimir.py) gets skewness at $0.0$ from integer generators, and the certificate is meant to be rational end to end. There is no reason for a tolerance to appear anywhere in this pipeline.

---

## 6. What survives the amendment at `624f846`

Three of my findings are now on the record via reviewer 175, and I record the independent second derivation rather than restating them: the trace-form derivation of the $16$ (§1.1), the eigenvalue check being basis-free so the $16$ cannot evidence orthonormality (§1.3), and the eigenspace dimension being a smoke alarm rather than a projector (§3.3). The $n=12$ collision count, $36$ classes, $52$ blocks merged, $(c_2,c_4)$ separating all $71$ as a measurement rather than a theorem, was reached twice from cold and is now at [plan.md:364](../plan.md#L364). **Two things the amendment does not settle.**

### 6.1 The amended Casimir sentence carries a sign it cannot carry

[plan.md:349](../plan.md#L349) now reads: *"under the trace form $B(X,Y)=-\tfrac12\mathop{\mathrm{tr}}(XY)$ … that form makes $\{E_{ij}-E_{ji}\}$ orthonormal and its dual is exactly $\langle e_i,e_j\rangle=\delta_{ij}$."* **Those two clauses need opposite signs, and the sentence asserts both.**

- $B=-\tfrac12\mathop{\mathrm{tr}}$ is positive definite on the compact real form, so it does make $\{L_{ij}\}$ orthonormal, that clause is right.
- Its Casimir is then $\Omega=\sum_p A_p^2$, which on $\mathbb R^5$ equals $-4\,\mathrm{Id}$, so the induced form on $\mathfrak h^*$ is $\langle e_i,e_j\rangle=-\delta_{ij}$, and $\Omega$ reads $-16$ on $\mathrm{Weyl}_5$.

The record's operator is $C=-\sum_p A_p^2=-\Omega$, which is the Casimir for $B'=+\tfrac12\mathop{\mathrm{tr}}$; under $B'$ the $e$-coordinates are orthonormal and $C=+16$. **So the minus sign in front of the sum is not decoration, it is what carries the normalisation from the compact torus to the $e$-basis**, and the amended sentence attributes the flip to the form instead. The corrected statement is §1.1: $C=-\sum A_p^2$ is the Casimir for $B'=\tfrac12\mathop{\mathrm{tr}}$, checked at $C|_{\mathbb R^5}=4=\langle(1,0),(1,0)+2\rho\rangle$. The value $16$ is unaffected because $\langle\lambda,\lambda+2\rho\rangle$ is quadratic, which is exactly why the sign can sit there unnoticed.

### 6.2 The grade row still carries the withdrawn word, and `attackable` should move

[plan.md:342](../plan.md#L342) now says *"`attackable` $=1$ survives as 'no route priced to completion', but the word infeasible does not"*, while the grade table at [plan.md:81](../plan.md#L81) still reads **"the dense projection is infeasible, and no sparse method is named"**. The row was not updated with the paragraph, so the withdrawn claim is still the recorded justification for the grade.

**And on the substance, `attackable` $=2$ is the right value.** §4 prices the projection a second way, independent of reviewer 175's contraction words: [price.py](../scripts/reviewers/r176/price.py) names the *exact linear system for every one of the $71$ blocks*, the $\lambda$-weight space of $\mathrm{Sym}^3(\mathrm{Weyl}_{12})$, whose kernel under the six simple raising operators is that block's multiplicity space. Largest $635\,220$, second $266\,000$, median $810$, total $1\,959\,767$. That is a route priced per block rather than in aggregate, and the two routes agree to within a factor of two on the total ($15.7$ MB against $12$ MB), which is the useful part of having derived them separately.

---

## What I ran, and what I did not

The $n\ge12$ plethysm was not invoked and no $D_6$ symmetric power was formed. `WeylCharacterRing("D6")(2,2,0,0,0,0).weight_multiplicities()` on the $1638$-dimensional module takes $0.5$ s and returns $853$ weights; everything at $n=12$ is a Python convolution of that multiset. Total wall clock across all scripts is under two minutes.

| script | what it settles |
|---|---|
| [casimir.py](../scripts/reviewers/r176/casimir.py) | $C=-\sum A_p^2$ rebuilt from $L_{ij}=E_{ij}-E_{ji}$; spectrum $0,4,10,16$ on $\mathrm{Sym}^2(\Lambda^2\mathbb R^5)$; the $B=\tfrac12\mathop{\mathrm{tr}}$ normalisation |
| [n5b.sage](../scripts/reviewers/r176/n5b.sage) | the $24$ blocks, $7770$, the eigenvalue list, $21$ distinct, span $3570$, $36$ unknowns, shapes $\{1:9,2:5,3:2\}$ |
| [quartic.sage](../scripts/reviewers/r176/quartic.sage) | $p^2q^2$ separates all three colliding pairs; neither highest weight is a weight of the other |
| [labels.sage](../scripts/reviewers/r176/labels.sage) | the $71$ stable block labels with multiplicities |
| [n12w2.sage](../scripts/reviewers/r176/n12w2.sage) | the $853$-weight multiset of $\mathrm{Weyl}_{12}$ |
| [sym3w.py](../scripts/reviewers/r176/sym3w.py) | $\dim\mathrm{Sym}^3(\mathrm{Weyl}_{12})=733\,813\,080$ reproduced; largest weight space $635\,220$ |
| [price.py](../scripts/reviewers/r176/price.py) | the weight space at each of the $71$ block highest weights; total $1\,959\,767$ |
| [collide12.py](../scripts/reviewers/r176/collide12.py) | $36$ distinct Casimir values across $71$ blocks; $52$ merged in $17$ classes |
| [tower.py](../scripts/reviewers/r176/tower.py) | $(c_2,c_4)$ separates all $71$ at $n=12$ |
| [dims12.py](../scripts/reviewers/r176/dims12.py) | no two merged blocks share a dimension at $n=12$ |

**Not verified here:** the sparse raising operators at $n=12$ were not built, so §4.4's estimate of the remaining kernel work is an estimate. The isotropy branching of [REVIEW_r174.md](REVIEW_r174.md) §2 was taken on trust and checked only through the $3570$ agreement, which it passes exactly.
