# REVIEW r284, Gate 2, route D's diagonality instruments and the direction retraction

Reviewer 284. Commits under review: `5b50431` (primary), `d4813d1`, `37cac5b`.
Primary file: [findings/diagonality.md](../findings/diagonality.md). Supporting: [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), [findings/second-order.md](../findings/second-order.md), [findings/fence-posts.md](../findings/fence-posts.md), [findings/target.md](../findings/target.md) (post F22), [plan.md](../plan.md) route D, [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex).
Scripts: [scripts/reviewers/r284/](../scripts/reviewers/r284/). Reviewer 283 runs the identical brief concurrently and independently.

Everything numeric below is built from [review_r30_core.py](../scripts/review_r30_core.py)'s $Q$ and Weyl basis plus my own Hessian, Plücker and isotropy code; no reviewed script is called except the two constructors and the mass function whose values are being checked.

| # | Claim | Verdict |
|---|---|---|
| 1 | D2's lever points the wrong way | **THE RETRACTION IS RIGHT, AND UNDERSTATED, and its proposed replacement is REFUTED BY A WITNESS.** Padded $W_{\mathbb{CP}^2}$ is a Plücker-obstructed critical point whose constrained Hessian is negative semidefinite with null space exactly the orbit, at $n=8$ and $n=12$: a **local maximum**. So no second-order argument at a maximiser can exclude an obstructed eigenspace |
| 2 | The three instruments and their domains | **(a) YES and certified, on better grounds than stated. (b) YES as a statement, but the quoted values are frame-minimal only at padded $W_{\mathbb{CP}^2}$. (c) REFUTED, the isotropy of padded $W_{\mathbb{CP}^2}$ IS unitary, exactly $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$, and so is $W_{\mathbb{CP}^m}$'s at odd $m$. (d) all six numbers reproduce** |
| 3 | Is route D fenced? | **POST F22 SPLITS, it certifies D1 and fences D2, so the plan's reading is inverted. And route D's crux does bound $\theta$**: any proof of D2 must show $\sup\{\theta:\text{non-diagonalisable critical}\}<\theta_0(n)$, since a local-max witness sits in the class. Route D is the record's **lifting lemma** at the maximiser, three closed attacks in [ATTEMPTS.md](../ATTEMPTS.md), named open in [problem.md](../findings/problem.md) item 11 |
| 4 | Lemma L66 as it stands | **THE PROOF IS CORRECT and matches the findings file, but the commit orphaned Lemma L41's certificate.** `37cac5b` inserted Lemma L66 between Lemma L41 and the certificate + discussion that belong to Lemma L41, which now read as certifying Lemma L66 |
| 5 | What route D would buy | **CONFIRMED, Conjecture A at every even $n\ge12$, odd $n$ untouched.** Every hypothesis of Jäger's Theorem A is met once diagonality is granted. *And it is **equivalent** to Conjecture A there, not a reduction of it* |
| 6 | Sweep r259–r282, index | **THE INDEX GAP IS REAL and one of the five is a genuine loss**: r269–r272 are salvaged partials, **r273 is a full report** whose Claim 3 is the source of the report's own new status item. Substance applied; rows missing |

---

## Claim 1, the direction argument

### The implication is in the direction the retraction says

[stratum-two-negative.md:59](../findings/stratum-two-negative.md) reads, verbatim: *"The chain's dominant term $(+--)\le6\lambda_1ab$ is tight only when $\|[v_{N-1},v_N]\|^2=2$ … So equality pins the two negative eigenvectors to a $2$-plane of rank-$4$ bivectors, which by the Plücker criterion already on record is precisely a plane containing no decomposable element."* That is

$$\text{tight}\Longrightarrow\text{rank-4 2-plane}\Longrightarrow\text{obstructed}\Longrightarrow\text{non-diagonalisable},$$

with no converse anywhere in the file. **`5b50431` reads its own source correctly**, and the composition it rejects is genuinely vacuous: *maximiser $\Rightarrow$ estimate not tight* constrains nothing, because the estimate is a step in a proof, not a property of $P$.

### And the retraction understates the problem, on the record's own scoping

The tightness statement lives on the stratum *one positive, two negative eigenvalues*. [stratum-two-negative.md:11](../findings/stratum-two-negative.md) closes that stratum at $\theta\le\sqrt{3/2}<\theta_0(n)$ for $n\ge12$. So at every $n$ route D targets, **no maximiser is in the stratum where the lever is defined**, the lever is not merely pointed the wrong way, it is evaluated off its own domain. The file's "what is owed" bullet *"whether a maximiser must make that chain tight"* is therefore already answered in the negative by the record: at $n\ge12$ a maximiser is not a point the chain is applied to at all.

### The proposed replacement is refuted, and this is the cycle's real finding

[diagonality.md](../findings/diagonality.md) closes with *"what would serve is an implication running from maximality to the absence of an obstructed eigenspace, a second-order argument at the maximiser."* **No such argument can exist**, and the counterexample is the record's own sharp point.

At a critical point $Q(W)=\theta W$ the constrained Hessian is $6\theta(L_e-\tfrac12\mathrm{Id})$, $e=W/\theta$ ([second-order.md:11](../findings/second-order.md)). Measured on the full Weyl space at padded $W_{\mathbb{CP}^2}$ ([c1_local_max_witness.py](../scripts/reviewers/r284/c1_local_max_witness.py)):

| $n$ | $\dim\mathcal W_n$ | $\theta$ | criticality residual | $\max\mathop{\mathrm{spec}}(L_e\mid W^\perp)$ | eigenvalues $>\tfrac12$ | eigenvalues $=\tfrac12$ | $\dim$ orbit |
|---|---|---|---|---|---|---|---|
| $8$ | $300$ | $1.224744871392$ | $2.1\times10^{-15}$ | $0.500000000000$ | $\mathbf0$ | $18$ | $18$ |
| $12$ | $1638$ | $1.224744871392$ | $1.7\times10^{-15}$ | $0.500000000000$ | $\mathbf0$ | $34$ | $34$ |

**The Hessian is negative semidefinite and its kernel is exactly the orbit directions**, along which $P$ is constant, so padded $W_{\mathbb{CP}^2}$ is a strict local maximum transverse to its orbit, at both dimensions, $n=12$ included. The orbit dimensions are independent: $\binom n2-\dim\mathfrak k(W)$ with $\mathfrak k(W)=\mathfrak u(2)\oplus\mathfrak{so}(n-4)$ gives $28-10=18$ and $66-32=34$, matching the Hessian nullities exactly ([c2c_isotropy.py](../scripts/reviewers/r284/c2c_isotropy.py)).

And the same point is Plücker-obstructed: its $(-0.408248)$-eigenspace, of dimension $2$, has $\min\|\omega\wedge\omega\|=0.500000$ over its unit sphere.

> **So there is a point of $\mathrm{Weyl}_{12}$ that is critical, is a local maximum, and carries a Plücker-obstructed eigenspace.** Any second-order criterion at a maximiser is evaluated on data this point also has. D2 as respecified is not merely unattempted, **it is unreachable by the class of argument the file nominates**, and the file should record that rather than leave the door open.

*What survives.* Excluding a local maximum needs the **value**, $\theta=\sqrt{3/2}<\theta_0(n)$, a global comparison. That is the only mechanism the record has ever used against this point, and it is a bound on $\theta$.

## Claim 2, the three instruments

### (a) Plücker is sufficient, and the certification is stronger than the file claims

The argument, from the definitions: if $W$ is diagonal in the basis $\{e_i\wedge e_j\}$ of some orthonormal frame, then every eigenspace of $W$ is spanned by a subset of those basis vectors, each of which is decomposable. So an eigenspace containing **no** decomposable bivector forbids every frame. Decomposability of a $2$-vector is exactly $\omega\wedge\omega=0$ in any dimension, so $\min\|\omega\wedge\omega\|>0$ over the eigenspace's unit sphere is the certificate. **Sufficient, never necessary** (all eigenspaces may contain decomposables without a *common frame* existing), the file's "sufficient" column is right, and its "no criticality, no unit norm" domain is right too, since nothing above uses either.

"Certified rather than numerical" is defensible, and for a reason the file does not give. Recomputed ([c2_numbers.py](../scripts/reviewers/r284/c2_numbers.py)), the quoted minima are attained on **one-dimensional** eigenspaces at $\mathbb{CP}^4$ and $\mathbb{CP}^5$ (where "minimise over the unit sphere" is the evaluation of a single vector, not a search) and at padded $W_{\mathbb{CP}^2}$ the obstructed eigenspace is $\Lambda^2_+V$, where [ATTEMPTS.md](../ATTEMPTS.md)'s Hodge argument gives $\omega\wedge\omega=|\omega|^2\mathrm{vol}_V$ in closed form. **No load-bearing minimisation is involved in any of the three.**

### (b) Frame-minimal mass is exact, but only one of the three values is certified minimal

$\min_{O(n)}\|W_{\rm off}\|_F=0$ iff diagonalisable is immediate, $O(n)$ is compact so the minimum is attained, and it vanishes iff some frame diagonalises. **Exact, as claimed.** The caveat the file states (computing it is a global search) is the operative one, and it bites the numbers: [b_diagonality_split.py](../scripts/b_diagonality_split.py)'s own header says its descent *"must NOT be read as certifying frame-minimality"*, its positive control reaching only $1.3\times10^{-2}$. My rerun reaches $1.0\times10^{-4}$ on a rotated $S^3\times S^3$ and does not improve any of the three constructor-frame values. So $0.707107$ is **proved** minimal (ATTEMPTS' $1/\sqrt2$ floor, two independent proofs), while $0.836660$ and $0.866025$ are **numerically stalled**, not certified. Calling all three "frame-minimal" without that split overstates two of them.

### (c) REFUTED, the domain claim, and the witness offered for it

[diagonality.md](../findings/diagonality.md) says: *"padded $W_{\mathbb{CP}^2}$ is non-diagonalisable while its isotropy is **not** unitary, the $U(m)$ argument applying only in native dimension $4$; $\mathbb{CP}^m$ at odd $m$ fails likewise."* Both halves are false.

Computing $\mathfrak k(W)=\{X\in\mathfrak{so}(n):[\mathrm{ad}X,W]=0\}$ directly ([c2c_isotropy.py](../scripts/reviewers/r284/c2c_isotropy.py)):

| point | $\dim\mathfrak k(W)$ | expected | block structure | $\max\|[X_V,J_V]\|$ |
|---|---|---|---|---|
| padded $W_{\mathbb{CP}^2}$, $n=8$ | $10$ | $\mathfrak u(2)\oplus\mathfrak{so}(4)=10$ | block-diagonal, mixed entries $\le2.7\times10^{-15}$ | $1.8\times10^{-15}$ |
| padded $W_{\mathbb{CP}^2}$, $n=12$ | $32$ | $\mathfrak u(2)\oplus\mathfrak{so}(8)=32$ | block-diagonal, mixed entries $\le7.8\times10^{-16}$ | $1.6\times10^{-15}$ |
| $W_{\mathbb{CP}^3}$, $n=6$ | $9$ | $\mathfrak u(3)=9$ |, | $2.0\times10^{-14}$ |
| $W_{\mathbb{CP}^5}$, $n=10$ | $25$ | $\mathfrak u(5)=25$ |, | $1.8\times10^{-14}$ |

$J$ here is the top eigenvector of $W$ read as a skew matrix, and it squares to $-\mathrm{Id}_V$ to $10^{-15}$. **The isotropy algebra's $V$-part commutes with $J$ (it is exactly $\mathfrak u(2)$, genuinely unitary**) so padded $W_{\mathbb{CP}^2}$ is the *first application* of the $U(m)$ proposition, which is how [ATTEMPTS.md](../ATTEMPTS.md) states it (*"Fox's $\mathcal S^4(\alpha)$, isotropy $U(2)\times O(n-4)$, $m=2$"*), not a case where it fails. Odd $m$ is the same story: $\mathbb{CP}^3$ and $\mathbb{CP}^5$ have isotropy exactly $\mathfrak u(m)$.

And the domain is **wider**, not narrower, than "native dimension $4$": ATTEMPTS states the proposition for $\dim V=2m\ge2$ and applies it to the $r\ge8$ hyperkähler family and to $\mathbb{HP}^m$ ($\mathrm{Sp}(m)\mathrm{Sp}(1)\subset U(2m)$) in the same breath. **The whole row is a misreading of the source.** The instrument's true limitation is different and worth stating in its place: the proposition needs the *full* stabiliser's $V$-part inside $U(m)$, and the identity component is all that the dimension count above certifies.

### (d) The numbers

All six reproduce ([c2_numbers.py](../scripts/reviewers/r284/c2_numbers.py)):

| point | $n$ | $\theta$ | off-diagonal mass | Plücker $\min\|\omega\wedge\omega\|$ | quoted |
|---|---|---|---|---|---|
| $\mathbb{CP}^4$ | $8$ | $0.986013$ | $0.836660$ | $0.612372$ (on the $1$-dim eigenspace $+0.845154$) | $0.837$ / $0.61$ |
| $\mathbb{CP}^5$ | $10$ | $0.948683$ | $0.866025$ | $0.632456$ (on the $1$-dim eigenspace $+0.843274$) | $0.866$ / $0.63$ |
| padded $W_{\mathbb{CP}^2}$ | $8$ | $1.224745$ | $0.707107$ | $0.500000$ (on the $2$-dim eigenspace $-0.408248$) | $0.707$ / $0.50$ |

Criticality residuals $\le3.7\times10^{-16}$ at all three. The rounding is honest and the ordering claim holds: max-entry gives $0.197/0.158/0.408$, reversing $\mathbb{CP}^4$ against $\mathbb{CP}^5$ relative to the mass.

## Claim 3, is route D fenced?

### Post F22 splits: it is D1's specification and it is D2's fence

[Post F22](../findings/target.md) says $\ker\Phi_W$ *"decides diagonality but carries no information about $\theta$"*, and closes with the instruction **"Use it to define the target set, not to bound $\theta$ on it."** [plan.md](../plan.md) reads this as route D's specification. Half of that is right:

- **D1 is exactly the permitted use.** Naming a frame-independent diagonality test and its domain is defining the set. Post F22 supports D1 outright.
- **D2 is exactly the forbidden use.** D2 must show a specific point (the maximiser), is *outside* that set. Nothing in $\ker\Phi_W$, or in the Plücker minimum, or in the frame-minimal mass, changes when $\theta$ changes; post F22's table is the measurement that says so ($\dim\ker\Phi_W=1$ at every $\mathbb{CP}^m$ *and* at random Weyl tensors whose $\theta$ differs by an order of magnitude). So the instruments cannot supply the maximality half of D2's implication, by the post's own content.

**Post F22 therefore does not "become the specification", it certifies D1 and fences D2**, and the plan's inversion of it is the routing error, not a reframe.

### And Claim 1's witness shows what D2 must be, which is a bound on $\theta$

Padded $W_{\mathbb{CP}^2}$ is critical, Plücker-obstructed and a local maximum at $n=12$. So the only thing separating it from the sphere product is its **value**, $\sqrt{3/2}<\theta_0(12)$. Any proof of D2 must therefore establish

$$\sup\{\theta(W):W\ \text{critical},\ \text{non-diagonalisable}\}<\theta_0(n),$$

because a non-diagonalisable local maximum with $\theta\ge\theta_0(n)$ would be a counterexample to D2 and no structural test distinguishes it from padded $W_{\mathbb{CP}^2}$. That statement **is a bound on $\theta$**, over a subclass. So route D's justification, *"it proves a structural statement and never estimates $\theta$ at all"*, the sentence on which its grade of $18$ rests, is false at its own crux. The posts that fence $\theta$-bounds (1, 2, 2b, 6, 10, 33, 34, 35) reach D2 to exactly the extent that they reach the non-diagonal half in general, and route D imports no new method that would clear them.

Two further posts bear directly:

| post | bearing on route D |
|---|---|
| **3**, universal lifting is false, three ways | Does **not** kill D, which quantifies over maximisers only. But it removes the entire class of frame/rank arguments as a proof method: any argument not using $\theta$ proves the universal statement, which is false |
| **9**, enumeration cannot close it | D cannot be discharged by a census: the critical set is *"exponentially large and mostly symmetry-free"*, $17$ distinct critical values from $20$ restarts at $n=6$, all with trivial stabiliser |

Post F3 is the sharp one. **Together with Claim 1's witness it gives a clean dichotomy**: an argument for D2 that uses only structure at the point proves too much (post F3 refutes it), and an argument that uses maximality must use the value (the fenced territory). *That is the honest statement of route D's position, and it is stronger than "no mechanism is in hand".*

### It has been attempted, under another name

Route D is the record's **lifting lemma**, restricted to the global maximiser. [ATTEMPTS.md](../ATTEMPTS.md) carries three sections titled *"Lifting lemma"*, the critical-point algebraic obstruction, the small-$n$ numerical exploration, and the polar-representation dimension count, and [problem.md](../findings/problem.md) item 11 states the residue verbatim:

> *"What remains open is narrower than before: not whether the lifting lemma holds universally (it doesn't), but whether it holds specifically for the actual global maximizer once $n\ge12$."*

**That is route D's theorem, already on file as an open question, with three closed attacks behind it.** Neither [plan.md](../plan.md) nor [diagonality.md](../findings/diagonality.md) uses the word "lifting" or cites those sections. The route is not new; what `d4813d1` adds is the domain table, and what `5b50431` adds is the retraction. *The grade's `attackable = 3` is not supported by a record in which the same question has three closed attempts and, by the file's own last line, no mechanism.*

## Claim 4, Lemma L66 as it now stands

### The proof is correct, and it matches the findings file

[07-gradedness-split.tex:974](../report/sections/07-gradedness-split.tex) states the definition of $\circ$-decomposable and the theorem verbatim as [support-dichotomy.md](../findings/support-dichotomy.md), and the chain checks step by step:

- $a_i^3P(A_i)\le\lvert a_i\rvert^3\lvert P(A_i)\rvert\le M(n)\lvert a_i\rvert^3$, the $\lvert\cdot\rvert$ repair is present in the report, and it is what makes this step hold at negative $a_i$;
- $\sum_i\lvert a_i\rvert^3\le\max_i\lvert a_i\rvert\sum_ia_i^2=\max_i\lvert a_i\rvert$;
- $\max_i\lvert a_i\rvert<1$ from $k\ge2$, all $a_i\ne0$, $\sum a_i^2=1$.

Two small things the write-up leaves implicit, neither of which breaks it. **(i)** The last inequality is strict only because $M(n)>0$, which holds since $M(n)\ge\theta_0(n)$. **(ii)** Additivity needs the trilinear form $\langle X,Y\circ Z\rangle$ to be totally symmetric: $\langle A_i,Q(A_j)\rangle=\langle A_i,A_j\circ A_j\rangle=\langle A_j,A_i\circ A_j\rangle=0$ is what kills the cross terms, and the report says only *"$A_i\circ A_j=0$ makes $P$ additive"*. Both are one clause each.

### But `37cac5b` inserted it between Lemma L41 and Lemma L41's certificate

This is a real defect in the report as it now reads. The commit adds the Lemma L66 block at line 970, immediately after `\end{Lem}` of **Lemma L41** (*"A $\lambda$-weighted identity, and the bound it gives"*) and immediately **before** the `certificate` environment and the *"What blocks it"* paragraph that belong to Lemma L41. As typeset, the reader now sees:

> Lemma L41 → Lemma L66 → proof of 66 → the $\lvert a_i\rvert^3$ remark → **certificate** → *"What blocks it, and what has been ruled out as a source"*

and the certificate reads *"The identity holds to $12$ digits … the bound is never violated … Equality holds at all nine symmetric-space points … Slack appears only where $\Delta>0$"*, while the paragraph after it discusses $\lvert\lambda_{\min}\rvert$ and $\Delta$. **Lemma L66 has no identity, no bound, no $\Delta$ and no $\lambda_{\min}$**, every word of both belongs to Lemma L41. Lemma L66 also lands inside `\subsection{The λ-weighted bound, and the one ingredient it lacks}`, whose subject it is not, and between Lemmas 39 and 41 by number. **The fix is to move the Lemma L66 block after the "What blocks it" paragraph, or into the section the decomposable stratum belongs to.** The [09-status.tex:150](../report/sections/09-status.tex) item is correctly placed and correctly worded.

## Claim 5, what route D would actually buy

**It would close Conjecture A at every even $n\ge12$, and buy nothing at odd $n$.** The assembly is sound, and each hypothesis is met:

| step | supplied by | check |
|---|---|---|
| a maximiser exists | $P$ continuous, unit sphere of $\mathrm{Weyl}_n$ compact | ✓ |
| it is critical, $W^2+W^\#=\theta W$ with $\theta=P(W)$ | Lagrange on the sphere, $\nabla P=3Q(W)$ | ✓ |
| $\theta\ge\theta_0(n)$ | $S^{n/2}\times S^{n/2}$ is a competitor at exactly $\theta_0(n)$ | ✓ |
| $W\in\langle W\rangle_d$ in some frame | **route D's theorem**, and $P$ is $O(n)$-invariant so the frame change is free | the open step |
| $\theta=\theta_0(n)$ and $W$ is the sphere product | [Jäger Theorem A](../references/jaeger-2016-diagonal-case/notes.md), even $n\ge16$ | ✓ |
| $n=12,14$ | [response.md](../response.md) Lemma L1, Jäger's threshold is rounding slack, closed by exact root isolation plus validated interval arithmetic | ✓, and on the record's audited list |

**What would remain: odd $n$, entirely.** Jäger is even-$n$ only; Lemma L1 *"does not change that, its computation covers the bulk of Jäger's argument for odd $n$, but his endgame genuinely needs evenness"*; and the odd statement is a different theorem, about $S^m\times S^{m+1}$. [diagonality.md](../findings/diagonality.md)'s $n$-range bullet states this correctly.

**One thing the file should add, because it prices the route.** Given the diagonal grant, route D's theorem is not merely *sufficient* for Conjecture A at even $n\ge12$, it is **equivalent** to it: if Conjecture A holds the maximiser is the sphere product, which is diagonal. So D buys the conjecture and nothing more, and costs the conjecture and nothing less. That is what [target.md](../findings/target.md) classifies as *"Conjecture A rewritten, neither easier nor harder"*, the classification the record applies to every other equivalent restatement, and route D has not been measured against it.

## Claim 6, the sweep, and the index

### The index

Confirmed: [reviews/INDEX.md](INDEX.md)'s index runs $\dots$ **282, 281, 280, 279, 278, 277, 276, 275, 274, 268** $\dots$, **rows 269–273 are absent**, while `reviews/REVIEW_r269.md` through `REVIEW_r273.md` all exist on disk. The five are not alike:

| reviewer | file | status |
|---|---|---|
| 269, 270, 271, 272 | salvaged log fragments | **partials, no verdict**, each says so in its own header. A row saying "partial, killed mid-flight, nothing citable" is what is missing |
| **273** | a genuine report, claims 1 and 3 delivered | **a real gap**, its Claim 3 is the source of the report's own *"false at the balanced sphere product at every even $n\ge4$"*, and its Claim 1 upgraded the half-percent table to closed form in $m=n/2$ |

### What is applied, and what is not

The substance of r271 and r273 **is** in the record even though their rows are not: r271's $\langle\Lambda^4(M^\#),M\rangle=0$ is a validation-ledger row in [plan.md](../plan.md), and r273's $(\star)$ refutation is [09-status.tex](../report/sections/09-status.tex)'s first new item from `37cac5b`. r282's residual correction ($s\ge12$, padded $S^6\times S^6$ at $n=14$) is the third new item. r279/r280/r281's verdicts are folded into [support-dichotomy.md](../findings/support-dichotomy.md) explicitly, by name.

**The one thing in r259–r282 that route D needed and did not get** is not a verdict but a measurement the record already had the machinery for: [nondegeneracy.md](../findings/nondegeneracy.md) records padded $W_{\mathbb{CP}^2}$ as Morse–Bott nondegenerate with $\ker\mathrm{Hess}$ exactly the orbit at $n=6,8,10$, and separately records $\lambda_{\max}(L_e\rvert_{W^\perp})=1.206011$ at the $C_5$ blow-up, but **never reads $\lambda_{\max}(L_e\rvert_{W^\perp})$ at padded $W_{\mathbb{CP}^2}$**, which is $\tfrac12$ exactly and is the number that decides D2's proposed mechanism. Claim 1 supplies it at $n=8$ and $n=12$.
