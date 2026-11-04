# Reviewer 317, the three senses of "graded", the labelling claim, and the fence-post ambiguity

*Adversarial Gate 2 audit of the three claims newly recorded in [findings/graded-half.md](../findings/graded-half.md) and [findings/INDEX.md](../findings/INDEX.md). Every number below comes from an implementation written for this audit from the definitions alone, [lib317.py](../scripts/reviewers/r317/lib317.py) and [points317.py](../scripts/reviewers/r317/points317.py), with no repository script imported and no repository prose taken on trust. The one repository artefact used is the stored operator [w_n8_nondiagonal_witness.npy](../scripts/data/w_n8_nondiagonal_witness.npy), consumed as data and re-verified from scratch.*

## Calibration of the independent implementation

Basis $A_{ij}=e_ie_j^\top-e_je_i^\top$ of $\mathfrak{so}(n)\cong\Lambda^2$, orthonormal for $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^\top Y)$; structure constants $c_{abc}=\langle[A_a,A_b],A_c\rangle$; $W^\#_{\alpha\beta}=\tfrac12\sum c_{cd\alpha}c_{ab\beta}W_{ca}W_{db}$; $Q=W^2+W^\#$; $P=\langle W,Q(W)\rangle$. Sign convention fixed by $\mathrm{Id}^\#=(n-2)\,\mathrm{Id}$, verified at $n=4,5,6,8$.

| point | my $\theta$ | record | $\lVert Q(W)-\theta W\rVert$ |
|---|---|---|---|
| $S^3\times S^5$ | $1.115546702$ | $1.115546702$ | $2.5\times10^{-16}$ |
| $S^4\times S^4$ | $1.145643924$ | $1.145643924$ | $3.3\times10^{-16}$ |
| $S^5\times S^7$ | $1.228239158$ | $1.228239158$ | $2.7\times10^{-16}$ |
| $S^6\times S^6$ | $1.236033081$ | $1.236033081$ | $3.9\times10^{-16}$ |
| $\mathbb{CP}^2$ | $1.224744871392$ | $\sqrt{3/2}$ | $2.7\times10^{-16}$ |
| $\mathbb{CP}^3$, $\mathbb{CP}^4$ | $1.054092553$, $0.986013297$ | same | $\le1.5\times10^{-16}$ |

Ricci-flatness, first Bianchi and $\mathop{\mathrm{tr}}W=0$ hold to $\le9\times10^{-16}$ at every one. The machinery agrees with the record everywhere it is checkable, which is what makes the disagreements below meaningful.

---

## O1, the three nested senses, **REFUTED**

The claimed chain $(\mathrm C)\subsetneq(\mathrm A)\subsetneq(\mathrm B)$ fails at **both** links, for two independent reasons.

### (C) $\Rightarrow$ (A) is false, and the witness is the rival maximiser itself

$W_{\mathbb{CP}^2}$ at $n=4$ satisfies the first characterisation of (C) verbatim (including the uniqueness clause) and is not sign-graded.

- $\mathfrak p=\mathfrak u(2)\subset\mathfrak{so}(4)$ is a symmetric subalgebra: $\lVert[\mathfrak p,\mathfrak p]_{\mathfrak m}\rVert=\lVert[\mathfrak p,\mathfrak m]_{\mathfrak p}\rVert=\lVert[\mathfrak m,\mathfrak m]_{\mathfrak m}\rVert=0$ **exactly** ([o1_n4.py](../scripts/reviewers/r317/o1_n4.py)).
- $\dim\{W\in\mathcal W_4:\mathrm{ad}(\mathfrak u(2))\text{-invariant}\}=\mathbf 1$, and its generator is $W_{\mathbb{CP}^2}$: $|\langle W,W_{\mathbb{CP}^2}\rangle|=1.000000000000$.
- Its spectrum is $0.81649658^{\times1}\oplus 0^{\times3}\oplus(-0.40824829)^{\times2}$. So $\ker W$ carries **3 of the 6 dimensions of $\mathfrak{so}(4)$**, and (A) fails.

The record's stated reason (*"the pair's $\mathfrak p$ and $\mathfrak m$ are exactly $E_\pm$ with no kernel"*), is false here in one half: $\mathfrak m=E_-$ exactly (dimension 2), but $\mathfrak p=E_+\oplus\ker W$ ($1+3$). **The two characterisations offered for (C) are therefore inequivalent**, and they diverge precisely on the kernel-carrying invariants. Writing $(\mathrm C_1)$ for "ad$(\mathfrak p)$-invariant Weyl tensor of a symmetric pair" and $(\mathrm C_2)$ for "sign-graded with $\Delta=0$": $(\mathrm C_2)=(\mathrm C_1)\cap(\mathrm A)$, strictly.

*The witness is robust to how "pair" is read.* Whether $(\mathrm C_1)$ means "a $\mathbb Z_2$-grading of $\mathfrak{so}(n)$ with $W$ $\mathrm{ad}(\mathfrak p)$-invariant" or "the isotropy algebra of a compact symmetric space with $W$ its invariant Weyl tensor", $\mathfrak u(2)\subset\mathfrak{so}(4)$ qualifies under both (it is a symmetric subalgebra ($SO(4)/U(2)=S^2$) and it is the isotropy of $\mathbb{CP}^2$) and the kernel is there either way.

**The failure is a single accident, and it is located exactly.** For $\mathbb{CP}^m$ the $\mathfrak{su}(m)$-block eigenvalue of $W=R-\tfrac{\mathrm{Id}}{2(n-1)}$ is $\lambda_2-c=\tfrac{m-2}{2(m+1)(2m-1)}$, which vanishes **iff $m=2$**. Measured: $\mathbb{CP}^3,\mathbb{CP}^4,\mathbb{CP}^5$ have $\dim(E_+,E_-,\ker)=(9,6,0),(16,12,0),(25,20,0)$ with $E_+=\mathfrak u(m)$ and $\Delta<8\times10^{-30}$, all in (A). Only $m=2$ carries a kernel, and $m=2$ is the rival maximiser.

*Secondary, and weaker.* For every symmetric pair the invariant line contains $\pm W$, and the negative representative has $(E_+,E_-)=(\mathfrak m,\mathfrak p)$, which is never a grading. Measured at $\mathfrak{so}(4)\oplus\mathfrak{so}(4)\subset\mathfrak{so}(8)$: the invariant line's returned generator has $\theta=-1.145643924$ with $\dim(E_+,E_-,\ker)=(16,12,0)$. If (C) is taken up to scale this is a second, dimension-free family of (C)-not-(A) points; if the sign is pinned by the actual curvature it disappears. **The $\mathbb{CP}^2$ witness does not depend on this and stands either way.**

### (A) $\Rightarrow$ (B) is false under the reading the C3 route actually uses

The brief's sub-question has a sharp answer: **the two readings of "involution" are not interchangeable, and the record uses the narrow one.**

| reading of $\sigma$ | gradings it reaches | (A) $\Rightarrow$ (B)? |
|---|---|---|
| Lie-algebra involution of $\mathfrak{so}(n)$ | all: $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$, $\mathfrak u(n/2)$, and at $n=8$ the triality images | **true, and vacuous**, the grading's own involution witnesses it |
| orthogonal involution of $\mathbb R^n$ ($\sigma^2=+I$) | only $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$ | **false** |

C3's slice is *"the fixed set of conjugation by $\Lambda^2(\mathrm{diag}(I_p,-I_q))$"*, i.e. the narrow reading. Under it the implication fails, because $\Lambda^2(J)$ for a complex structure $J$ ($J^2=-I$) is an involution *on $\Lambda^2$* without $J$ being one on $\mathbb R^n$, and $\mathfrak u(n/2)$-type gradings arise only that way.

**Witness** ([o1_slice.py](../scripts/reviewers/r317/o1_slice.py), then [o1_AtoB.py](../scripts/reviewers/r317/o1_AtoB.py)). $\dim\{W\in\mathcal W_8:[W,\mathrm{Ad}(J)]=0\}=160$. Take $W=(W_{\mathbb{CP}^4}+0.05\,W_{\text{rand}})/\lVert\cdot\rVert$ from that space:

- sign-graded: $\dim(E_+,E_-,\ker)=(16,12,0)$, $S_{\mathfrak{mmm}}=1.9\times10^{-29}$, $S_{\mathfrak{mpp}}=3.2\times10^{-29}$;
- non-equivariant: $\Delta=0.042$;
- **every** Lie-algebra involution of $\mathfrak{so}(8)$ commuting with it, enumerated exhaustively: the spectrum is simple, so any such involution is $\pm1$-diagonal in the eigenbasis, and the conditions $\varepsilon_a\varepsilon_b\varepsilon_c=1$ over every nonzero structure-constant triple form a $\mathrm{GF}(2)$ linear system. Its solution space has dimension **1**, the identity and the $\mathfrak u(4)$ grading, nothing else (automorphism residual $1.5\times10^{-15}$).
- The fixed algebra of that one involution has $\dim\{S\in\mathrm{Sym}(\mathbb R^8):[S,\mathfrak h]=0\}=1$, against $2$ for every $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$ (checked at $(2,6),(3,5),(4,4)$). So it is **not** $\Lambda^2(\sigma)$ for any orthogonal involution of $\mathbb R^8$.

Same conclusion at $\varepsilon=0.15$.

**Caveat, stated plainly.** This witness is a Weyl operator, not a critical point ($\lVert Q(W)-\theta W\rVert=0.069$). An ascent on the full $160$-dimensional $\mathrm{Ad}(J)$-slice from $60$ random starts ([o1_crit_search.py](../scripts/reviewers/r317/o1_crit_search.py)) returned only two limits, **both equivariant**, padded $W_{\mathbb{CP}^2}$ at $\theta=1.2247449$ and $S^4\times S^4$ at $\theta=1.1456439$, so I did not produce a *critical* (A)-not-(B) point. The implication as the record states it quantifies over Weyl operators, and as stated it is refuted; **restricted to critical points it is UNDECIDED.**

*The failure is confined and I can say where.* The equivariant $\mathfrak u(m)$ points do satisfy (B) narrowly, because $\sigma$ can be taken inside $U(m)$: $\mathbb{CP}^3$ commutes with $\Lambda^2(\mathrm{diag}(I_k,-I_{6-k}))$ for $k\in\{2,4\}$ and $\mathbb{CP}^4$ for $k\in\{2,4,6\}$. Only the *non-equivariant* $\mathfrak u(m)$-sign-graded operators escape.

### Corrected picture

$(\mathrm C_1)$ and $(\mathrm A)$ are **incomparable**, $W_{\mathbb{CP}^2}$ is in the first and not the second, the $n=8$ witness is in the second and not the first (see O3). $(\mathrm C_2)=(\mathrm C_1)\cap(\mathrm A)$. Both imply (B) in the Lie-algebra reading; in the $\mathbb R^n$ reading $(\mathrm C_1)\Rightarrow(\mathrm B)$ survives at every $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$ and $\mathfrak u(m)$ pair, the witnessing $\sigma$ can be taken inside $\mathfrak p$ itself, verified at $\mathbb{CP}^3$ and $\mathbb{CP}^4$; the $n=8$ triality pairs are unchecked, while $(\mathrm A)\Rightarrow(\mathrm B)$ does not.

---

## O2, the labelling claim, **REFUTED**

### 1. The definitions block labels Lemma L8 twice, incompatibly

- the (C) bullet: *"This is what Lemma L8 and Lemma L69 are about"*;
- the (B) bullet, three lines later: *"This is what Lemma L8 and the C3 route use."*

Both cannot be "fixed by its own proof". Reading the proof: Lemma L8's pinning formula is derived from $W=(q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m})/\sqrt{pq(p+q)}$, scalar on $\mathfrak k$ and on $\mathfrak m$ (that is Schur applied to $\mathrm{ad}(\mathfrak p)$-equivariance) and the file's own **SCOPE REFUTED** paragraph restricts the lemma to *"the pair's EQUIVARIANT critical point"*. **Lemma L8 is a (C) statement; the (B) attribution is wrong.**

### 2. Lemma L69's step 1 is correctly labelled, but only under $(\mathrm C_1)$

*"An equivariant graded point is the Weyl operator of a compact symmetric space"* needs a $\mathbb Z_2$-grading $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m$ with $W$ $\mathrm{ad}(\mathfrak p)$-invariant (exactly $(\mathrm C_1)$) and **nothing about the kernel**. $W_{\mathbb{CP}^2}$ at $n=4$ is the proof that kernel-freeness is not needed: it has $\ker W=3$ and it *is* the Weyl operator of a compact symmetric space. Under $(\mathrm C_2)$ the step is still valid but the lemma is under-scoped.

### 3. The step that is wrong is the dichotomy feeding Lemma L69

At [graded-half.md](../findings/graded-half.md): *"on a graded point $\Delta=0$ iff $W$ is $\mathrm{ad}(\mathfrak p)$-equivariant. So every graded critical point is either equivariant, where Lemma L69 applies, or non-equivariant, $\Delta>0$."*

$\Delta=\sum_{\delta\in E_+}\lVert[\mathrm{ad}(v_\delta),W]\rVert^2$ says exactly that $W$ is $\mathrm{ad}(E_+)$-invariant. That is equivalent to *"$\mathrm{ad}(\mathfrak p)$-equivariant for a symmetric pair"* **only when $E_+$ is a grading half**, only on (A). Padded $W_{\mathbb{CP}^2}$ has $\Delta=0$ exactly at $n=4,6,8,10,12$ and is $\mathrm{ad}(\mathfrak p)$-equivariant for **no** symmetric subalgebra of $\mathfrak{so}(n)$ (computation in O3). So the branch *"$\Delta=0\Rightarrow$ Lemma L69 applies"* is **false off the kernel-free locus**. The dichotomy is sound only if "graded" is read as (A), and it must be stated as *kernel-free $\wedge$ bracket relations $\wedge$ $\Delta=0$*. This is a scope error in the assembly, not in Lemma L69.

### 4. The one-dimensional-commutant repair: verified, extended, and its conclusion misstated

I recomputed $\dim\{W\in\mathcal W_n:\mathrm{ad}(\mathfrak p)\text{-invariant}\}$ for **every** symmetric subalgebra of $\mathfrak{so}(n)$ at $n=4,6,8,10$ ([o2_commutant.py](../scripts/reviewers/r317/o2_commutant.py)), including the unitary pairs the record's spot-check omitted. It is $\mathbf 1$ in every case: $\mathfrak{so}(2)\oplus\mathfrak{so}(4)$, $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, $\mathfrak u(3)$; $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$, $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$, $\mathfrak u(4)$; $\mathfrak{so}(2)\oplus\mathfrak{so}(8)$ through $\mathfrak{so}(5)\oplus\mathfrak{so}(5)$, $\mathfrak u(5)$; and $\mathfrak u(2)\subset\mathfrak{so}(4)$. **Agreement, and a strengthening.**

But the sentence drawn from it, *"an equivariant graded critical point on a pair is the sphere product's Weyl tensor, uniquely up to scale, with no appeal to the classification of symmetric spaces"*, is **false as written**. At $\mathfrak p=\mathfrak u(m)$ the unique invariant is $\mathbb{CP}^m$, not a sphere product: $\theta=1.054092553$ at $\mathfrak u(3)$, $0.986013297$ at $\mathfrak u(4)$, $0.948683298$ at $\mathfrak u(5)$. Lemma L69's conclusion survives only because $\mathbb{CP}^m$ falls below $\sqrt{3/2}$ for $m\ge3$, and $\mathbb{CP}^2$ sits at exactly $\sqrt{3/2}$ but has $n=4<12$. **The repair therefore replaces the classification with (commutant $=1$) plus the closed-form values on both families, a smaller appeal, not none.**

### 5. Lemma L69's arithmetic step: CONFIRMED

Built from my own sphere products at $n=12,14,16$: the criterion $\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}\le\tfrac13$ agrees with $\theta\ge\sqrt{3/2}$ in **all 18 cases**, and the survivors are exactly $p,q\ge5$ ($S^4\times S^8$ at $1.201561484$ is the last to fail at $n=12$, $S^5\times S^7$ at $1.228239158$ the first to pass).

### 6. "The defect screen and everything built on $\Delta$ test (A)", right as intent, unenforced in practice

The screen cannot tell it is off (A): it returns $\Delta=0$ and $S=0$ at padded $W_{\mathbb{CP}^2}$ while tracing over $3$ of $66$ dimensions. The record says this ("trust the screen exactly when $\ker W=0$") and then uses $\Delta=0$ as a branch condition without re-imposing it. The two statements need to be joined at the point of use.

---

## O3, the residual ambiguity, premise REFUTED under (A) and under (C), SURVIVES under (B)

### The point, verified from scratch

At $n=4,6,8,10,12$, padded $W_{\mathbb{CP}^2}$ ([o3_padded.py](../scripts/reviewers/r317/o3_padded.py)):

| quantity | value |
|---|---|
| $\theta$ | $1.224744871392$, against $\sqrt{3/2}=1.224744871392$, **12 digits, at every $n$** |
| $\lVert Q(W)-\theta W\rVert$ | $2.7\times10^{-16}$ |
| $S_{\mathfrak{mmm}}$, $S_{\mathfrak{mpp}}$, $\Delta$ | $0$ exactly |
| $\dim(E_+,E_-,\ker)$ | $(1,2,25)$ of $28$ at $n=8$; $(1,2,63)$ of $66$ at $n=12$ |
| $\dim\mathfrak k(W)$ | $4,5,10,19,32$ at $n=4,6,8,10,12$, exactly $\dim(\mathfrak u(2)\oplus\mathfrak{so}(n-4))$ |

**(A): NO**, the kernel carries all but three dimensions, and the zeros are vacuous.

**(B): YES**, in both readings, $W$ commutes with $\Lambda^2(\mathrm{diag}(I_k,-I_{n-k}))$ for $k\in\{2,4,5,6,7\}$ at $n=8$ and $k\in\{2,4,5,\dots,11\}$ at $n=12$.

**(C): NO for $n\ge6$**, by a dimension-and-ideal argument rather than a search. A symmetric subalgebra $\mathfrak p\subseteq\mathfrak k(W)$ is needed. At $n=6,8,10$ the dimension alone settles it: $\dim\mathfrak k(W)=5,10,19$ against smallest symmetric subalgebras of dimension $6$ ($\mathfrak{so}(3)^{\oplus2}$), $12$ ($\mathfrak{so}(4)^{\oplus2}$) and $20$ ($\mathfrak{so}(5)^{\oplus2}$). At $n=12$, $\dim\mathfrak k(W)=32$ and the only symmetric subalgebras below it are $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$ ($30$) and $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ ($31$); both are semisimple, so they would have to sit inside $\mathfrak{su}(2)\oplus\mathfrak{so}(8)$, and each simple factor (being $15$- or $21$-dimensional and simple), must land in $\mathfrak{so}(8)$, giving $30>28$ and $31>28$. Impossible. At $n=4$ alone, $\mathfrak k(W)=\mathfrak u(2)$ **is** symmetric, which is the O1 witness.

### The reading, and what each one costs

The chain's mechanism step is *"if every graded critical point with $\theta\ge t$ is Morse–Bott nondegenerate, each graded orbit is isolated, so the ungraded part of $\{\theta\ge t\}\cap\mathrm{Crit}$ is compact"*, and its supplier is Lemma L69, a (C) statement. The positivity step then needs $S>0$ off the graded class. The two steps pull in opposite directions:

| reading of "graded" | positivity step (3) | mechanism step (2) |
|---|---|---|
| **(A) sign** | **refuted**, padded $W_{\mathbb{CP}^2}$ is ungraded, critical, $S=0$, and sits exactly on the boundary $\theta=\sqrt{3/2}$ | supplied: $\Delta=0\Rightarrow(\mathrm C_1)\Rightarrow$ Lemma L69 |
| **(C) pair** | **refuted** by the same point; and the $n=8$ witness shows $S=0$ non-vacuously outside (C) | supplied directly |
| **(B) slice** | **survives**, the point is slice-graded | **lost**: step 2 would have to hold over every slice-graded critical point (slice dimension $155$ at $(3,5)$, $n=8$; $834$ at $(6,6)$, $n=12$), a class neither classified nor known nondegenerate. Lemma L69 does not reach it, and padded $W_{\mathbb{CP}^2}$ is itself a slice-graded critical point at the threshold that is equivariant for **no** grading |

So **the sense that saves the premise disarms the step above it.** That is the trade the record has not recorded: the ambiguity is not free to resolve either way.

### The $n=8$ witness, re-verified, and what it adds

Read from [w_n8_nondiagonal_witness.npy](../scripts/data/w_n8_nondiagonal_witness.npy) and re-tested with my own machinery: Ricci $5.1\times10^{-16}$, Bianchi $2.6\times10^{-16}$, $\mathop{\mathrm{tr}}W=-4.0\times10^{-16}$, $\theta=1.088948053$, $\lVert Q(W)-\theta W\rVert=2.8\times10^{-15}$, $\dim(E_+,E_-,\ker)=(13,15,0)$, $S_{\mathfrak{mmm}}=1.4\times10^{-28}$, $S_{\mathfrak{mpp}}=1.2\times10^{-28}$, $\Delta=1.512231$. **Every recorded figure reproduced.** It is (A) and not (C), which is the second half of the incomparability in O1. The $\mathrm{GF}(2)$ enumerator also settles the record's *"at least eight slice gradings"*: the witness carries exactly **seven non-identity involutions**, of fixed dimensions $12,13,13,13,16,16,21$, i.e. $\mathfrak{so}(4)^{\oplus2}$, $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ (three of them), $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ (two) and $\mathfrak{so}(7)$, **all of $\mathbb R^n$-involution type** (symmetric-commutant $2$), each commuting with $W$ to $\le2.2\times10^{-16}$. Its own sign splitting is the $13$-dimensional one. So the witness is (B) in the narrow sense as well, with seven witnesses. It also kills *"$S>0$ off (C)"* as a general fact, though at $\theta=1.088948<\sqrt{3/2}$ it is a near-miss for the C2 premise rather than a refutation of it.

### The useful reading, which the brief asked for

There is one, and it is neither (A), (B) nor (C). Take

> **graded $:=\{S=0\}$**, the equality locus of the compression inequality itself.

Then the positivity step is true by construction and empty, and the entire gap moves into a single checkable statement: *every critical point with $S=0$ and $\theta\ge t$ is Morse–Bott nondegenerate.* This keeps the chain's shape, survives padded $W_{\mathbb{CP}^2}$ (which has $S=0$ and is reported nondegenerate), and is honest about where the work is, $S$ is the quantity the compression inequality actually produces, so quantifying over its zero set introduces nothing the chain did not already own. What it costs is that $\{S=0\}$ strictly contains (A): it holds the vacuous-screen points too, so the nondegeneracy claim must be established there rather than inherited from Lemma L69. **That is the recommendation: state the premise over $\{S=0\}$, and treat "is every $S=0$ critical point above threshold nondegenerate?" as the open item, in place of the unnamed "ungraded".**

---

## Found, not asked for

1. **The record's own separating witness is mislabelled by one padding.** The claim *"padded $W_{\mathbb{CP}^2}$ separates (B) from (A)"* is right, but the **unpadded** $W_{\mathbb{CP}^2}$ at $n=4$ separates (A) from $(\mathrm C_1)$, the opposite direction. The same object refutes the nesting in the direction the record used it to establish.
2. **$\Lambda^2$ of a complex structure is an involution though $J$ is not.** $\Lambda^2(J)^2=\Lambda^2(J^2)=\Lambda^2(-I)=\mathrm{Id}$. This is the whole reason (B) has two inequivalent readings, and it is why the $\mathbb{CP}^m$ family (which the record lists among its graded points), is graded by an involution that no $\mathrm{diag}(I_p,-I_q)$ produces.
3. **A cheap exhaustive grading-finder.** For $W$ with simple spectrum, every Lie-algebra involution commuting with $W$ is $\pm1$-diagonal in its eigenbasis, so the automorphism conditions become the $\mathrm{GF}(2)$ system $x_a+x_b+x_c=0$ over the nonzero structure-constant triples. Gaussian elimination over $\mathrm{GF}(2)$ then enumerates *all* gradings a point carries, and $\dim\{S\in\mathrm{Sym}(\mathbb R^n):[S,\mathfrak h]=0\}$ ($2$ for $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$, $1$ for $\mathfrak u(m)$) classifies each. This settles "(B) or not" without searching a continuum of $\sigma$, and it is what makes the O1 refutation a proof rather than a failed search.
4. **The successor statement is refuted at $n=8$ and $n=10$.** I built the constrained Hessian myself ([o3_hessian.py](../scripts/reviewers/r317/o3_hessian.py)), $L(V)=\tfrac12(WV+VW)+W\#V$ projected onto $\mathcal W_n$, $L_e=L/\theta$, local maximum iff $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$, and at padded $W_{\mathbb{CP}^2}$ it gives $\lambda_{\max}=0.500000000000$ with $\mathrm{mult}(\tfrac12)=18=\dim(\text{orbit})$ at $n=8$ and $26=\dim(\text{orbit})$ at $n=10$. **Morse–Bott nondegenerate local maximum, independently of [Reviewer 316](REVIEW_r316.md).** It lies in coordinate slices ($k\in\{2,4,5,6,7\}$ at $n=8$), so it is a local maximum of $P\vert_{S(V)}$ there; and no symmetric subalgebra fits inside its $10$-dimensional stabiliser. So it is a local maximum of $P\vert_{S(V)}$ that is equivariant for **no** grading it carries, which **refutes** *"Every local maximum of $P\vert_{S(V)}$ is equivariant for some grading it carries"*. My ascent on the $160$-dimensional $\mathrm{Ad}(J)$ slice reached it as an attractor at $\theta=1.2247449$, above $S^4\times S^4$'s $1.1456439$ on the same slice. Whether the refutation reaches $n\ge12$ I did not compute; r316 reports the same nondegeneracy there.
5. **Coordinate sphere products lie in every coordinate slice**, verified, $\lVert\Lambda^2(\sigma)W-W\Lambda^2(\sigma)\rVert=0$ for all $n-1$ splits at $S^3\times S^5$ and $S^4\times S^4$. This corroborates the record's uniqueness refutation without needing any ascent.

## Verdicts

| claim | verdict |
|---|---|
| **O1** three nested senses, $(\mathrm C)\subsetneq(\mathrm A)\subsetneq(\mathrm B)$ | **REFUTED**, $(\mathrm C_1)\not\subseteq(\mathrm A)$ ($W_{\mathbb{CP}^2}$, $n=4$); $(\mathrm A)\not\subseteq(\mathrm B)$ under the $\mathbb R^n$-involution reading that C3 uses |
| **O2** each result's sense is fixed by its own proof | **REFUTED**, Lemma L8 is labelled (C) and (B) in consecutive bullets; the $\Delta=0$ dichotomy feeding Lemma L69 is false off $\ker W=0$; the commutant repair's conclusion is false at the unitary pairs. Lemma L69's own steps are sound and its arithmetic step is confirmed |
| **O3** the fence-post chain's ambiguity | **CONFIRMED, and sharpened**, refuted under (A) *and* under (C), survives under (B) at the cost of the mechanism step; the reading that keeps the chain useful is $\{S=0\}$ |
