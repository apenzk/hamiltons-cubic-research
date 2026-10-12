# Gate 2 review r208, the apolarity reduction (claims 4, 5, 6)

Reviewer 208. Brief: `brief15.md`. Commits under review: `ec35c0b`, `6237a63`, `2f20131`.
Primary source: [run_n5_necessary.py](../scripts/runs/run_n5_necessary.py), its docstring is the argument.

Assignment: claims **4** and **5** first (reviewer 207 runs 1–3 concurrently), then **6**.

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 4 | The $v^3\in C$ criterion | **UPHELD**, re-derived independently. Restated as $\mathcal A(v^6)\in\mathrm{ANN}\iff v\in V(K)$. |
| 4' | "no witness off the orbit cone" | **UPHELD and strengthened.** $W_0$ is a *smooth* point of $V(K)$, $\dim T=7$, over $\mathbb R$ **and** $\mathbb C$, a local non-existence proof, not a failed search. 160 ascents, real and complex; 0 witnesses. |
| 4'' | the evidence as the file describes it | **UNDERSTATED GAP.** The file's search was 12 real ascents; the criterion's natural search space is $V(K)(\mathbb C)$, since a complex $v$ gives *two* real ANN directions. That search is run here for the first time. |
| 5 | build the 14 invariant sextics | **DONE.** 14 independent complete contractions, over $\mathbb C$, no 15th in 42 more. (The brief's "never constructed" is out of date, [run_n5_sextic_basis.py](../scripts/runs/run_n5_sextic_basis.py) already had one mod $p$.) |
| 5' | decide $\dim\mathrm{ANN}$ | **$\dim\mathrm{ANN}=1$, $\text{rank}=13$**, numerically, gap $\sigma_{13}/\sigma_{14}=425$–$458$ on three independent samples, the kernel is the predicted $\mathcal A(W_0^6)$ direction to $0.02^\circ$, and independent runs share exactly one kernel direction. **$F_5$ lies in the image; the route's necessary condition holds.** |
| 6a | gpadd / gpconj round-trip tests | **REPAIR HOLDS.** 7 of 7 sabotages fire (r204's four plus three new). |
| 6b | step-(b) rank computation | **HOLDS on $W_0$** (35/35 effective corruptions fire) but **BLIND to the $\mathfrak{so}(5)$ action**: negating a generator breaks 9 of 45 Lie relations and passes both asserts. The homomorphism test in [run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py) is a print rather than an assert, and [run_n5_order2.py](../scripts/runs/run_n5_order2.py)'s loader swallows it. |
| 6c | renamed gauge coordinates | **HARMLESS.** Only the counts are used downstream. |
| 6d | "restored" sampled-rank caveat | **REFUTED.** The caveat came back as a print; the *check* did not. [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) computes no rank at all. r194's end-to-end falsification is still missing. |
| 6e | what `ec35c0b` misses | [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) still prints "the family is 36 - rank, so at least 23 dimensions" unconditionally, while the same commit added the consistency caveat to [run_n5_order2.py](../scripts/runs/run_n5_order2.py). |

*(this file was written incrementally, a section at a time, and committed as each claim settled)*

## Claim 4, the $v^3\in C$ criterion

### 4a. Independent derivation

Re-derived from the definitions, in five steps. Write $\mathcal A$ for the Reynolds operator $\mathcal A(F)=\int_{O(5)}h\cdot F\,dh$ and $\langle\cdot,\cdot\rangle$ for the apolar pairing.

1. **Polarisation.** $\mathrm{Cat}_F$ is a *symmetric bilinear* form, so $\mathrm{Cat}_F(K,K)=0$ is equivalent to $\mathrm{Cat}_F(f,f)=0$ for all $f\in K$, characteristic zero, so no loss either way. The file only ever needs the $f=g$ direction, and it is legitimate.
2. **Linearity of Cat in $F$.** $h\cdot(v^6)=(hv)^6$, so $\mathcal A(v^6)=\int(hv)^6dh$ and $\mathrm{Cat}_{\mathcal A(v^6)}=\int\mathrm{Cat}_{(hv)^6}\,dh$, no equivariance of the pairing is needed at this step, only linearity.
3. **The rank-one catalecticant of a sixth power.** $\langle v^6,fg\rangle=(fg)(v)\cdot\kappa$ for a nonzero constant $\kappa$ depending only on the normalisation, so $\mathrm{Cat}_{v^6}(f,g)=\kappa f(v)g(v)$ and $\mathrm{Cat}_{\mathcal A(v^6)}(f,g)=\kappa\int f(hv)g(hv)\,dh$.
4. **The integral is definite.** Over $\mathbb R$, $\mathrm{Cat}_{\mathcal A(v^6)}(f,f)=\kappa\int f(hv)^2dh=0$ forces $f(hv)=0$ for a.e. $h$, hence all $h$ by continuity. **This step is where the real field is used**, and it is used correctly.
5. **Transport through apolarity.** $f(u)=\kappa'\langle f,u^3\rangle$, and $K=C^\perp$ with $C=\mathrm{span}\{(hW_0)^3\}$. So "$f(hv)=0$ for all $f\in K$, all $h$" says $(hv)^3\perp C^\perp$, i.e. $(hv)^3\in (C^\perp)^\perp=C$. Since $C$ is $O(5)$-stable this holds for one $h$ iff for all. **Criterion confirmed: $\mathcal A(v^6)\in\mathrm{ANN}\iff v^3\in C$.**

Also confirmed: $\mathcal A(v^6)\neq0$ for $v\neq0$, since $\langle\mathcal A(v^6),\Phi\rangle\propto\Phi(v)$ for invariant $\Phi$ and $\lVert W\rVert^6$ does not vanish at $v$. So the criterion never produces a vacuous element.

### 4b. A cleaner statement of the same criterion

$v^3\in C \iff \langle f,v^3\rangle=0$ for every $f\in C^\perp=K \iff f(v)=0$ for every $f\in K$. So

$$\boxed{\ \mathcal A(v^6)\in\mathrm{ANN}\iff v\in V(K),\ \text{the common zero locus of the cubics vanishing on the orbit cone.}}$$

This is worth having because it converts the hunt into a **classical question**: *is the cone over $O(5)\cdot W_0$ cut out set-theoretically by cubics?* A witness exists exactly when the cubics through the orbit cone have extra zeros. The file's $\rho(u)=\lVert P_Cu^3\rVert^2/\lVert u^3\rVert^2$ is the numerical proxy for membership in $V(K)$, and $\rho=1$ is exactly $u\in V(K)$.

### 4c. Independent reproduction of the ambient facts

[dimC.py](../scripts/reviewers/r208/dimC.py) rebuilds $C$ from 4200 orbit points using only 35-dimensional inner products, the identity $\langle a^3,b^3\rangle=\langle a,b\rangle^3$ means $\mathrm{Sym}^3$ (7770-dimensional) is never constructed. $\dim C=3570$, the same count at every relative tolerance from $10^{-6}$ to $10^{-12}$, so the gap is clean; $\rho(W_0)=1$ to $4\cdot10^{-15}$.

### 4d. A local theorem the file does not have: $W_0$ is a smooth point of $V(K)$

[tangent.py](../scripts/reviewers/r208/tangent.py). For $f=P_Ku^3$,

$$\nabla f(W_0)=3\langle u,W_0\rangle^2u-3\sum_k c_k(u)\langle u_k,W_0\rangle^2u_k,\qquad c(u)=G^+\big(\langle u,u_k\rangle^3\big)_k,$$

so the Jacobian of the ideal generators at $W_0$ is computable in the same 35-dimensional arithmetic. Over 400 random $u$:

$$\dim\operatorname{span}\{\nabla f(W_0):f\in K\}=28,\qquad \sigma_{28}=3.9\cdot10^{1}\ \to\ \sigma_{29}=8.7\cdot10^{-10},$$

a gap of eleven orders of magnitude. Hence $\dim T_{W_0}V(K)=35-28=7$, which is **exactly** the dimension of the orbit cone ($\dim O(5)-\dim\mathrm{Stab}(W_0)+1=10-4+1=7$). The same holds at a second, independently generated orbit point.

Three consequences, none of them in the record:

- $W_0$ is a **smooth** point of $V(K)$ and the orbit cone is a whole irreducible component through it. No witness lies in any neighbourhood of the orbit, the ascents cannot fail by "just missing" a nearby branch.
- **The statement is field-independent.** Jacobian rank is a rank of a real matrix, so it is the same over $\mathbb C$: the complexified $V(K)$ is also smooth of dimension 7 at $W_0$. A complex witness, too, must live on a component disjoint from the (complexified) orbit cone.
- It upgrades the character of the evidence. The file's "no $v$ found" is a failed search. This is a *local proof of non-existence*, leaving only the question of components elsewhere.

### 4e. The witness hunt, widened in the direction that matters

[hunt.py](../scripts/reviewers/r208/hunt.py), [complex_test.py](../scripts/reviewers/r208/complex_test.py), [witness_test.py](../scripts/reviewers/r208/witness_test.py).

**The real search, at ten times r203's scale.** 120 L-BFGS ascents on $\rho$ from random starts: **all 120** reached $\rho=1$ and **all 120** landed on the orbit cone, matched by the $\Lambda^2$ spectrum to $10^{-4}$. Structured starts (coordinate vectors, $W_0\pm gW_0$, rank-one lifts), add nothing: they reach either $1$ (on the orbit) or the plateaux $0.505$ and $0.800$.

**The complex search, which the record never ran.** For $v\in\mathbb C^{35}$, $\rho_{\mathbb C}(v)=b^*G^+b/\lVert v\rVert^6$ with $b_k=\langle u_k,v\rangle^3$; $\rho_{\mathbb C}=1$ iff $v^3\in C\otimes\mathbb C$. This is the *right* ambient space: if $v^3\in C_{\mathbb C}$ then $\mathrm{Re}\,\mathcal A(v^6)$ and $\mathrm{Im}\,\mathcal A(v^6)$ are **both real** elements of ANN, because $F\mapsto\mathrm{Cat}_F$ is real-linear and $\mathrm{Cat}_F(K,K)=0$ splits into real and imaginary parts. A real variety can have a tiny real locus and a large complex one, so restricting to real $v$ could have missed everything.

**A first, too-weak test, and its correction.** All 120 complex maximisers have $\mathrm{Re}\,v$ and $\mathrm{Im}\,v$ linearly independent, but that proves nothing, because $O(5,\mathbb C)$ already carries a real $W_0$ to such points. The similarity invariant is the right test: for $g\in O(5,\mathbb C)$, $\Lambda^2(g)$ is complex orthogonal, so $M=\mathrm{expand}(v)$ moves by conjugation and the spectrum is the invariant. **Seven of forty maximisers have $\operatorname{rank}M\in\{4,5\}$ while matching every trace ratio of $W_0$** ($t_3^2/t_2^3=1/6$, $t_4/t_2^2=1/2$, $t_6/t_2^3=66/216$, to $10^{-12}$), non-semisimple points with $W_0$'s characteristic polynomial, i.e. boundary points of the cone.

**The decisive test, which subsumes the geometry.** $\mathcal A(v^6)$ is new exactly when it is *not* proportional to $\mathcal A(W_0^6)$, and since $\langle\mathcal A(v^6),\Phi\rangle\propto\Phi(v)$ this reads: **the 14-vector $(\Phi_r(v))_r$ is not proportional to $(\Phi_r(W_0))_r$.** The locus where it *is* proportional is Zariski closed and contains the orbit cone, hence its closure, so boundary points can never separate, and no spectral bookkeeping is needed. Controls: three real orbit points separate by $2\cdot10^{-16}$, three random points by $0.40$–$0.60$. Result:

> **0 of 40 complex maximisers (the rank-4 and rank-5 ones included), give an element of ANN independent of $\mathcal A(W_0^6)$.**

**Verdict on claim 4.** The criterion is correct as stated, and the file's caveat ("a subspace need not be spanned by the sixth powers it contains") is the only gap in the *logic*. The *evidence* was weaker than the file implied (twelve real ascents, no complex search) and is now considerably stronger: 160 ascents over $\mathbb R$ and $\mathbb C$, a proof that $W_0$ is a smooth point of $V(K)$ over both fields, and a separation test with $10^{16}$ of dynamic range. **No witness. No second obstruction of the form $\mathcal A(v^6)$.**

## Claim 5, the open question: the 14 built, and $\dim\mathrm{ANN}$ decided

### 5a. The brief's premise is out of date; the record's own premise is not

The brief calls a basis of the 14 something "this project has counted four ways and never constructed". [run_n5_sextic_basis.py](../scripts/runs/run_n5_sextic_basis.py) already constructs one mod $p$. What the *file under review* says is narrower and correct: what is missing is $\mathrm{Cat}_F$ block by block. Both are now superseded.

### 5b. An independent basis of the 14, over $\mathbb C$

[sextics.py](../scripts/reviewers/r208/sextics.py). By the first fundamental theorem for $O(n)$, every degree-6 invariant is a combination of complete contractions of six copies of $W$, i.e. of perfect matchings of the 24 index slots. Built from the record's rational Weyl module, with the four defining symmetries asserted at the sample points (antisymmetry, pair symmetry, first Bianchi, Ricci trace: residuals $0$, $0$, $1.1\cdot10^{-16}$, $2.2\cdot10^{-16}$):

- **14 independent matchings out of 94 tried**; 42 further matchings produce nothing independent of them.
- The evaluation matrix at 30 generic points has $\sigma_1=3.2$, $\sigma_{14}=1.1\cdot10^{-3}$.
- Built over $\mathbb C$, which is what made the complex witness test of 4e possible.

### 5c. $\dim\mathrm{ANN}=1$, and the route's necessary condition HOLDS

[ann_rank.py](../scripts/reviewers/r208/ann_rank.py), [ann_nullcheck.py](../scripts/reviewers/r208/ann_nullcheck.py). The identity that makes this cheap:

$$\int_{O(5)}x(hv)^2\,dh=\mathcal A(x^2)(v),$$

so sampling the group at $v$ **evaluates** the invariant sextic $\mathcal A(x^2)$ there. The $\mathcal A(x_a^2)$, $x_a\in K$, span the image, so $\text{rank}$ is the rank of their coordinate matrix in any basis of the 14, no block decomposition, no $7770\times7770$ catalecticant. Each $\mathcal A(x_a^2)$ is least-squares fitted to the 14 sextics of 5b at the same points, which enforces the cap $\text{rank}\le14$ exactly and discards the sampling noise orthogonal to the invariant space.

With $x_a=P_Ku_a^3$ ($a=1,\dots,30$, exact: $|x_a|\le3\cdot10^{-13}$ at 40 **fresh** orbit points against $8\cdot10^{-2}$ at random points), 24 generic $v_r$ plus $v_0=W_0$ as a zero control, $10^5$ group samples per column:

| quantity | value |
|---|---|
| zero control, mean $|E[:,0]|$ at $v_0=W_0$ | $8.0\cdot10^{-27}$ against $1.1\cdot10^{-4}$ elsewhere |
| $\sigma_{13}/\sigma_1$ | $1.34\cdot10^{-3}$ |
| $\sigma_{14}/\sigma_1$ | $3.04\cdot10^{-6}$ |
| gap $\sigma_{13}/\sigma_{14}$ | $\mathbf{440}$ |

$$\Rightarrow\quad \text{rank}=13,\qquad \dim\mathrm{ANN}=14-13=1.$$

**The self-check that makes this more than a rank read-off.** A functional $\beta$ kills the image iff it spans the left kernel, and the one functional known to do so is $F\mapsto\langle F,\mathcal A(W_0^6)\rangle$, whose coordinates are $\langle\Phi_r,\mathcal A(W_0^6)\rangle\propto\Phi_r(W_0)$. So the kernel is *predicted* to be the vector $(\Phi_r(W_0))_r$, computed by a wholly separate route. Measured:

- $|\cos|=0.99999994$, **0.0195 degrees**, relative distance $3.4\cdot10^{-4}$;
- the second-smallest singular vector is orthogonal to it, $|\cos|=1.6\cdot10^{-4}$.

**Consequence.** $\mathrm{ANN}=\operatorname{span}\{\mathcal A(W_0^6)\}$, and $F_5\perp\mathcal A(W_0^6)$ because $F_5(W_0)=0$. So

> **$F_5$ lies in the image of the certificate map. The necessary condition the file was written to isolate is satisfied, $\text{rank}=13$, and the $n=5$ route survives to the PSD question.**

**Status of the claim.** This is a Monte Carlo screen, not a proof: the group average is sampled. What raises it well above a plateau reading is that the predicted kernel direction is recovered to $0.02^\circ$, an agreement that a rank artefact has no reason to produce. An exact settlement still wants $\mathrm{Cat}_F$ block by block, or the same computation in exact arithmetic with an exactly invariant cubature on $O(5)$.

## Claim 6, the r203/r204 repairs in `ec35c0b`

[plants.py](../scripts/reviewers/r208/plants.py). Each repair was attacked by sabotage.

### 6a. The gpadd / gpconj round-trip tests, **REPAIR HOLDS**

All four of r204's sabotages fire on the new asserts, including `new-d2` (the one that made $h$ come out exactly $\mathrm{Re}(h)$ and so manufactured the evidence stage 4 reads off). Three further sabotages of my own (`gpconj` negating the real part, `gpadd` swapping re/im, `gpadd` scaling by 2), also fire. **7 of 7 caught; the control passes.**

### 6b. The step-(b) rank computation in `run_n5_order2.py`, **HOLDS ON $W_0$, BLIND TO THE ACTION**

| plant | dim Stab | dim $(\mathcal W_5)^{\mathfrak h}$ | |
|---|---|---|---|
| control, the shipped $W_0$ | 4 | 1 | passes, correctly |
| $W_0$ scaled by 7 | 4 | 1 | passes, correctly, only the direction matters |
| a random symmetric $10\times10$ | 0 | 35 | **fires**, both asserts |
| **all 35 effective one-entry corruptions of $W_0$** | (|), | **35 of 35 fire** |
| generator 3 **negated** | 4 | 1 | **passes** |
| generator 3 scaled by 7 | 4 | 1 | **passes** |
| two generators swapped | 4 | 1 | **passes** |

Two findings.

- **A caveat on the commit message's "perturbing one entry of $W_0$ fires it".** `coords()` reads only the 35 **free** columns of the 55, so **20 of the 55 entries of $W_0$ are invisible to the tested object**, corrupting `S[0][0]` changes nothing at all. Of the 35 that do change the weight-basis vector, all 35 fire. The claim is true where it can be true, and its scope is 35 entries, not 55.
- **The check is blind to a corrupted $\mathfrak{so}(5)$ action, which is what it is built on.** Negating generator 3 **breaks 9 of the 45 Lie relations** and leaves $\dim\mathrm{Stab}=4$ and $\dim(\mathcal W_5)^{\mathfrak h}=1$ *exactly* intact. This is r177's observation reappearing one level up: the stabiliser is a kernel, and a kernel does not change when a generator is rescaled, negated, or reordered. Worse, `run_n5_weyl_module.py`'s homomorphism test is a **`print`, not an `assert`** (its only `assert` is `len(set(FREE)) == 35`), and `run_n5_order2.py`'s `_load` redirects stdout to `devnull`, **so even the diagnostic is swallowed.** The fix is one line: make the homomorphism check an assert in the module.

### 6c. The renamed gauge coordinates, **RENAME IS COSMETIC BUT HARMLESS**

`UNK, GAUGE = COUNT_SYM, COUNT_ANTI` keeps the old names as aliases. Downstream they are used for their **counts** (65 and 24) and the asserts are on lengths, so no computation depends on the refuted labelling. The print now says "the SPLIT is 24-dimensional by theorem, but WHICH 24 is not these coordinates", which is the honest statement.

### 6d. The "restored" sampled-rank caveat, **THE CAVEAT CAME BACK, THE CHECK DID NOT**

The commit message says the sampled-rank check "COMES BACK; the theorem tells us what the answer must be, which makes the check sharper rather than unnecessary." What was added to `run_n5_assemble.py` is a **`print`**:

> `rank(A) for the SAMPLED matrix still needs unisolvent points and is NOT retired`

`run_n5_assemble.py` computes **no rank at all**, no `matrix_rank`, no elimination, no `_rank` helper anywhere in the file. **r194's end-to-end falsification is still absent**; the commit restored a sentence about it. This is the single substantive gap in `ec35c0b`.

### 6e. What else `ec35c0b` misses

`run_n5_assemble.py` still prints, unconditionally:

> `the family is 36 - rank, so at least 23 dimensions.`

The same commit added the caveat to `run_n5_order2.py` ("*the family is 36 - rank only when the system is CONSISTENT*") and did not carry it across. As printed the line is wrong in the inconsistent case, where the family is **empty**, not $\ge23$-dimensional. (My claim-5 measurement says the system *is* consistent, so the number is right, but the file asserts it for a reason it does not have.)

### 5d. $F_5$ in the image, checked directly rather than inferred

[f5_in_image.py](../scripts/reviewers/r208/f5_in_image.py). $\text{rank}=13$ says the image is the *whole* 13-dimensional space of invariant sextics vanishing at $W_0$, so $F_5$ is in it. Rather than infer that, $F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$ is expanded in the 14 explicit sextics (relative residual $3.4\cdot10^{-15}$, itself an independent check that the 14 really are a basis of the invariant sextics, since $F_5$ was built from a formula sharing nothing with them) and projected onto $\operatorname{span}\{\mathcal A(x_a^2)\}$:

| direction | residual after projection onto the 13-dimensional image |
|---|---|
| $F_5$ | $5.3\cdot10^{-4}$ (seed 7777), $5.7\cdot10^{-5}$ (seed 31337) |
| the $\mathcal A(W_0^6)$ direction $(\Phi_r(W_0))_r$ | $0.9997$, essentially wholly outside |
| three random directions in the 14 | $0.31$, $0.35$, $0.50$ |

### 5e. Reproduction across independent samples

Three runs, each with its own $u_a$, its own $v_r$ and its own group samples:

| | $N=10^5$, seed 7777 | $N=2\cdot10^5$, seed 31337 | $N=1.6\cdot10^6$, seed 2086 |
|---|---|---|---|
| fit residual (the noise level) | $9.5\cdot10^{-3}$ | $6.8\cdot10^{-3}$ | $2.2\cdot10^{-3}$ |
| $\sigma_{13}/\sigma_1$ | $1.34\cdot10^{-3}$ | $1.24\cdot10^{-3}$ | $5.6\cdot10^{-4}$ |
| $\sigma_{14}/\sigma_1$ | $3.04\cdot10^{-6}$ | $2.70\cdot10^{-6}$ | $1.31\cdot10^{-6}$ |
| **gap $\sigma_{13}/\sigma_{14}$** | $440$ | $458$ | $425$ |
| null vector vs $(\Phi_r(W_0))_r$ | $0.0195^\circ$ | $0.0196^\circ$ | $0.0286^\circ$ |
| $F_5$ residual | $5.3\cdot10^{-4}$ | $5.7\cdot10^{-5}$ | $2.6\cdot10^{-6}$ |

The **gap** is the stable quantity, $425$ to $458$ across a sixteen-fold change in sample size and three independent draws. The noise level falls as $N^{-1/2}$ (a factor $9.5/2.2=4.3$ against the predicted $4$), $\sigma_{14}$ falls with it, and $\sigma_{13}$ stays several hundred times above it throughout. $\sigma_{13}$ itself varies between runs because it is the smallest *signal* direction and depends on which $x_a$ were drawn, which is exactly the behaviour 5f uses to tell the two apart.

**A remark on the file's own caveat.** It warns that "ANN is a subspace, and a subspace need not be spanned by the sixth powers it happens to contain". Correct in general, and moot here, since $\mathrm{ANN}$ turns out to be one-dimensional and spanned by $\mathcal A(W_0^6)$, which *is* one of the sixth powers it contains. The gap the file identified was real and is now closed from the other side.

### 5f. The test that separates $\dim\mathrm{ANN}=1$ from $\dim\mathrm{ANN}=2$

[kernel_stability.py](../scripts/reviewers/r208/kernel_stability.py). The worry a Monte Carlo rank read-off deserves is the opposite one: that $\sigma_{13}$ is itself noise and the true kernel is 2-dimensional. The kernel is **intrinsic**, it is $\mathrm{ANN}$ in the $\Phi$ basis and does not depend on which $x_a$ or which $v_r$ were drawn, while a signal direction does depend on the sample. So compare the bottom-$k$ right singular subspaces of the two independent runs by principal angles:

| $k$ | principal angles between the two runs' bottom-$k$ subspaces |
|---|---|
| 1 | $0.028^\circ$ |
| 2 | $0.011^\circ$, $\ \mathbf{29.7^\circ}$ |
| 3 | $0.008^\circ$, $7.4^\circ$, $57.8^\circ$ |

Exactly **one** direction is shared. If $\dim\mathrm{ANN}$ were 2, the whole bottom-2 plane would be shared and both angles would be small. **$\dim\mathrm{ANN}=1$.**

### 5g. Cross-validation: the sampled columns really are invariant sextics

[crossval.py](../scripts/reviewers/r208/crossval.py). Fit each $\mathcal A(x_a^2)$ to the 14 using 19 of the 25 points, predict the other 6.

| | held-out mean relative error |
|---|---|
| the sampled $\mathcal A(x_a^2)$ | $2.2\cdot10^{-2}$ (max $1.3\cdot10^{-1}$), against a $0.128$ spread of $E$ about its mean |
| control: the **non**-invariant sextic $v_1^6$, fitted identically | $6.2$ |

Three orders of magnitude of separation, so the objects being fitted do lie in the invariant span and the rank read off them is a rank of the right thing.


## The two answers interlock

Claims 4 and 5 were attacked independently and their answers constrain each other, which is the strongest form of corroboration available here.

- **Claim 5 makes claim 4's target unattainable.** $\dim\mathrm{ANN}=1$ forces $\mathrm{ANN}=\operatorname{span}\{\mathcal A(W_0^6)\}$, so *no* $v$ whatever (on the cone, off it, real or complex), can give an $\mathcal A(v^6)$ independent of $\mathcal A(W_0^6)$. The brief's "that single witness would produce a second obstruction candidate" is, given claim 5's answer, a hunt that could not have succeeded. The 160 ascents finding nothing is exactly what $\dim\mathrm{ANN}=1$ predicts.
- **Claim 4 corroborates claim 5 from the other direction.** The witness hunt is a search over $v$; the rank measurement is a linear-algebra computation over $x\in K$. They share the object $C$ and nothing else (different scripts, different quantities, different failure modes) and they agree.

## What is left open

- The rank measurement is a **Monte Carlo screen**, not a proof. The group average is sampled. What would settle it exactly is $\mathrm{Cat}_F$ block by block for the 14, which is still the computation the file names, but it now has a target to hit, and the target is $\text{rank}=13$ with kernel $(\Phi_r(W_0))_r$.
- $V(K)$ is shown smooth of dimension 7 at $W_0$; **components disjoint from the orbit cone are not excluded** by anything here. Given $\dim\mathrm{ANN}=1$ they would be harmless, but the geometric question is open.
- `run_n5_assemble.py` should actually compute a sampled rank (6d), and `run_n5_weyl_module.py`'s homomorphism test should be an `assert` (6b). Both are one-line fixes.
