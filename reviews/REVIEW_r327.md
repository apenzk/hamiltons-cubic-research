# Reviewer 327, Lemma L71: the saturation structure, the $\mathfrak r=0$ hypothesis, and the mass law

**Cold brief, independent build.** Everything below is computed from $\mathfrak{so}(n)$, its structure constants, $\#$ and $\mathcal W_n$ rebuilt from the definitions in [scripts/reviewers/r327/](../scripts/reviewers/r327/); no script of the record was read or run. Validation of the build: $\dim\mathcal W_n=10,35,84,168,300$ at $n=4,\dots,8$ against $(n+2)(n+1)n(n-3)/12$; $c_{abc}$ totally antisymmetric to $0$ with row mass $\sum_{bc}c_{abc}^2=2(n-2)$ exactly; $Q$ maps $\mathcal W_n$ into $\mathcal W_n$ (relative distance $\le5\times10^{-16}$ at random Weyl tensors) with $\operatorname{tr}(W^\#)=-\operatorname{tr}(W^2)$ to $10^{-16}$; and the balanced sphere products come out as genuine Weyl tensors ($\mathrm{dist}(\mathcal W_n)\le2.5\times10^{-16}$), critical to $\le6.1\times10^{-16}$, at $\theta=\theta_0(n)$ exactly.

| claim | verdict |
| --- | --- |
| **M4** does saturation force $\mathfrak r\subseteq\ker W$ | **CONFIRMED, and superseded by a stronger theorem.** For $n\ge5$ saturation forces $\mathfrak r=0$ **and** $\ker W=0$ outright, the hypothesis of Lemma L71 is not a hypothesis, it is a consequence. $n=4$ is the only dimension where $\mathfrak r\neq0$ is possible, and the reason is that $\mathfrak{so}(4)$ is the one non-simple member of the family. Proof in §1; no counterexample exists to be found, and none was found in the search |
| **M1** the saturation structure | **CONFIRMED**, with one silent hypothesis surfaced (§2.1) and one missing step supplied, $[\mathfrak m,\mathfrak h\ominus[\mathfrak m,\mathfrak m]]=0$, which is what turns the record's $\mathfrak g'$ observation into a proof (§2.3). The Jacobi step is valid as written *only because* $[\mathfrak m,\mathfrak m]$ is by definition the span of brackets |
| **M2** Lemma L71 granting $\mathfrak r=0$ | **CONFIRMED as mathematics, REFUTED AS STATED as a claim.** "$W$ has exactly two eigenvalues, derived not assumed" is vacuous: $\mathfrak r=0$ *is* the two-eigenvalue hypothesis, written in other letters. Both routes to the last step are valid; they are independent in deriving $\dim\mathfrak h$ and **share** the classification step. The symmetric-pair list is complete, and the uniqueness holds at every even $n$, not only $n\le16$ |
| **M3** the mass law | **CONFIRMED as arithmetic**, all five points and the control reproduced to the digit, and the factor $2$ is exactly the $b\leftrightarrow c$ swap. **REFUTED AS STATED** as an "independent confirmation of the saturation ratio": the closed form $\dim\mathfrak h(n-4)$ *assumes* the ratio, and once the unconditional form is written down the check reduces to counting $\dim\mathfrak m$ and $\dim\mathfrak h$, which is done by reading the spectrum |

*The verdicts are against the claims as posed in the cold brief. While this audit ran, the record independently landed the same M4 theorem from [Reviewer 328](REVIEW_r328.md); §5 says what the audit leaves after that commit, and what the two derivations share.*

**Net effect on the record: Lemma L71 becomes unconditional for $n\ge5$, and the conjecture it was hedged with disappears.** The saturating critical points of $\mathcal W_n$, $n\ge5$, are exactly the balanced sphere products $S^{n/2}\times S^{n/2}$ for $n$ even, and there are **none** for $n$ odd. The $W_{\mathbb{CP}^2}$ witness is not a warning about general $n$; it is a fact about $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$.

---

## 1. M4, the one that matters. Verdict: CONFIRMED, and the conjecture is superseded

### 1.1 The theorem

> **Theorem (r327).** Let $n\ge5$ and let $W\neq0$ be a symmetric operator on $\Lambda^2\mathbb R^n=\mathfrak{so}(n)$ with $\operatorname{tr}W=0$, in particular any $W\in\mathcal W_n$. Write $\mathfrak m=E_{\min}(W)$, $\mathfrak h=E_{\max}(W)$, $\mathfrak r$ for the sum of the remaining eigenspaces. If $\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$ for every $v\in\mathfrak m$, i.e. if $W$ saturates [Lemma L70](../findings/bounds.md), then
> $$\mathfrak r=0,\qquad \ker W=0,\qquad [\mathfrak m,\mathfrak m]=\mathfrak h,\qquad \mathfrak{so}(n)=\mathfrak h\oplus\mathfrak m \text{ is a symmetric pair.}$$

Criticality is used nowhere in the proof. It enters only to make "saturation" equivalent to $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$, which is Lemma L70's business, and to feed the conclusion into Lemma L23.

**Proof.**

*(a) $\lambda_{\min}<0<\lambda_{\max}$.* $\operatorname{tr}W=0$ and $W\neq0$ give $\lambda_{\min}<0$ and $\lambda_{\max}>0$.

*(b) The minimum product is attained only on $E_{\min}\times E_{\max}$.* For eigenvalues $\lambda',\lambda''$ of $W$ with $\lambda'\lambda''=\lambda_{\min}\lambda_{\max}<0$, one of them is negative, say $\lambda'<0\le\lambda''$. Then $\lambda_{\min}\le\lambda'$ and $\lambda_{\max}\ge0$ give $\lambda_{\min}\lambda_{\max}\le\lambda'\lambda_{\max}$, and $\lambda''\le\lambda_{\max}$ with $\lambda'<0$ gives $\lambda'\lambda_{\max}\le\lambda'\lambda''$. Equality throughout forces $(\lambda_{\min}-\lambda')\lambda_{\max}=0$ and $\lambda'(\lambda_{\max}-\lambda'')=0$, hence $\lambda'=\lambda_{\min}$ and $\lambda''=\lambda_{\max}$ since $\lambda_{\max}>0$ and $\lambda'<0$. So the terms of $D(v)$ with a nonzero weight are exactly the pairs with one index in $\mathfrak m$ and one in $\mathfrak h$.

*(c) The three bracket relations.* $D(v)=0$ with every summand $\ge0$ kills every $c_{vab}$ whose pair $(a,b)$ is not in $\mathfrak m\times\mathfrak h\cup\mathfrak h\times\mathfrak m$. Reading that off: $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak r]=0$.

*(d) The forgotten piece of $\mathfrak h$.* Put $\mathfrak h_0=[\mathfrak m,\mathfrak m]$ and $\mathfrak h_1=\mathfrak h\ominus\mathfrak h_0$. For $x\in\mathfrak h_1$ and $v,w\in\mathfrak m$, total antisymmetry of $c$ gives $\langle[v,x],w\rangle=-\langle[v,w],x\rangle=0$ because $[v,w]\in\mathfrak h_0\perp x$. But $[v,x]\in[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, so $[v,x]=0$: **$[\mathfrak m,\mathfrak h_1]=0$.**

*(e) The centraliser splits off.* Let $\mathfrak c=\mathfrak z(\mathfrak m)=\{x:[x,\mathfrak m]=0\}$, a subalgebra. If $x=x_{\mathfrak m}+x_{\mathfrak h}+x_{\mathfrak r}\in\mathfrak c$ then for $v\in\mathfrak m$ the three pieces $[x_{\mathfrak m},v]\in\mathfrak h$, $[x_{\mathfrak h},v]\in\mathfrak m$, $[x_{\mathfrak r},v]=0$ lie in mutually orthogonal spaces and so vanish separately; and no $0\neq v\in\mathfrak m$ centralises $\mathfrak m$, since $\mathrm{ad}(v)$ carries mass $2(n-2)\lVert v\rVert^2>0$, all of it on $\mathfrak m\times\mathfrak h$. With (d), $\mathfrak c=\mathfrak h_1\oplus\mathfrak r$ exactly.

*(f) Two ideals.* $\mathfrak g'=\mathfrak m\oplus\mathfrak h_0$ is a subalgebra: $[\mathfrak m,\mathfrak h_0]\subseteq[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, and on the spanning brackets $[[v,w],[x,y]]=[v,[w,[x,y]]]-[w,[v,[x,y]]]\in[\mathfrak m,\mathfrak m]$. Jacobi on spanning brackets also gives $[\mathfrak h_0,\mathfrak c]=0$, so $[\mathfrak g',\mathfrak c]=0$ and $\mathfrak{so}(n)=\mathfrak g'\oplus\mathfrak c$ with both summands ideals.

*(g) Simplicity.* $\mathfrak{so}(n)$ is simple for $n\ge5$. $\mathfrak g'\supseteq\mathfrak m\neq0$, so $\mathfrak c=0$: $\mathfrak r=0$ and $\mathfrak h=\mathfrak h_0=[\mathfrak m,\mathfrak m]$. Finally $0$ is an eigenvalue of $W$ only if it lies in $\mathfrak r$, it is not $\lambda_{\min}<0$, and $\lambda_{\max}=0$ would force $W\preceq0$ with zero trace, i.e. $W=0$, so $\ker W\subseteq\mathfrak r=0$. $\square$

### 1.2 What it does to the record

- **The hypothesis "$\mathfrak r=0$" in Lemma L71 is discharged for every $n\ge5$.** So is the record's preferred replacement "$\ker W=0$". Both are conclusions.
- **The conjectured multiplicity law is true but empty above $n=4$.** $\mathfrak r=0$ makes $\mathfrak r\subseteq\ker W$ trivial and $\operatorname{rk}W=N$, so $\dim\mathfrak m=n^2/4$, $\dim\mathfrak h=n(n-2)/4$, the balanced values. The formula's two "regimes" are one dimension and every other dimension.
- **Odd $n\ge5$ carries no saturating critical point at all.** $\dim\mathfrak m=n^2/4\notin\mathbb Z$ for odd $n$; equivalently Lemma L23's cap $n(n-2)/4$ is not an integer, so no symmetric pair of $\mathfrak{so}(n)$ has the required dimension.
- **An independent derivation of r324's saturation ratio, for $n\ge5$.** The theorem lands $W$ in Lemma L23's family; the equality case there gives $\dim\mathfrak h=n(n-2)/4$, hence $\lambda_{\max}/\lvert\lambda_{\min}\rvert=\dim\mathfrak m/\dim\mathfrak h=n/(n-2)$. This uses neither first Bianchi nor $\mathrm{Ric}=0$ beyond $\operatorname{tr}W=0$, so it is a genuine second route to that ratio, unlike the mass law of M3 (§4.2).
- **Why $n=4$ escapes, exactly.** $\mathfrak{so}(4)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$ is the unique non-simple member, so step (g) fails and $\mathfrak c$ may be a whole factor. At $W_{\mathbb{CP}^2}$ it is: I measure $\dim\mathfrak z(\mathfrak m)=3$, $\dim\mathfrak g'=3$, $\dim[\mathfrak m,\mathfrak m]=1=\dim\mathfrak h$, $\lVert[\mathfrak m,\mathfrak r]\rVert=2.0\times10^{-16}$, with $(\mathfrak g',\mathfrak h_0)=(\mathfrak{su}(2),\mathfrak u(1))$ the symmetric pair and $\mathfrak c=\mathfrak r=\ker W$ the other $\mathfrak{su}(2)$. The witness is the theorem's boundary case, not evidence about general $n$.

### 1.3 $n=4$ settled completely, so the conjecture is a theorem at every $n$

At $n=4$, $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ and every $W\in\mathcal W_4$ is block diagonal with trace-free blocks (measured over $200$ random Weyl tensors: off-block $\le9.0\times10^{-16}$, block traces $\le7.2\times10^{-16}$; $\dim\mathcal W_4=10=5+5$). $[\Lambda^+,\Lambda^-]=0$, so $\#$ acts blockwise, and in an eigenbasis of a block with $c_{abc}=\sqrt2\,\varepsilon_{abc}$ one gets $W^\#=\mathrm{diag}(2\mu_2\mu_3,2\mu_1\mu_3,2\mu_1\mu_2)$. Criticality $\mu_i^2+2\mu_j\mu_k=\theta\mu_i$ differenced pairwise gives $(\mu_i-\mu_j)(3\mu_k+\theta)=0$, so a nonzero block has at most two distinct eigenvalues and, with $\sum\mu_i=0$, spectrum $(s,s,-2s)$ with $\theta=-3s$. Hence for $\theta>0$ the critical set is exactly: one block active ($W_{\mathbb{CP}^2}$, spectrum $(-\tfrac\theta3,-\tfrac\theta3,\tfrac{2\theta}3,0,0,0)$) or both ($S^2\times S^2$). A census of $80$ Newton solves from random seeds returns precisely four orbits, $\pm S^2\times S^2$ at $\theta=\pm0.866025$ and $\pm W_{\mathbb{CP}^2}$ at $\theta=\pm1.224745$, and nothing else. Both $\theta>0$ orbits saturate, and in both $\mathfrak r\subseteq\ker W$. **So "$\mathfrak r\subseteq\ker W$ at saturation" is a theorem at every $n\ge4$**, trivially for $n\ge5$ and by exhaustion at $n=4$.

### 1.4 The search, which found nothing, as it must

Every point below is screened against $\mathcal W_n$, and the saturation defect is $\lambda_{\min}+(n-2)\lambda_{\max}-\theta$.

| population | $n$ | points | criticality residual | $\mathrm{dist}(\mathcal W_n)$ | min saturation defect | with $\mathfrak r\neq0$ |
| --- | --- | --- | --- | --- | --- | --- |
| Newton (LM) from random seeds, criticality only and criticality+saturation | 4 | 80 | $\le6\times10^{-16}$ | $\le4.1\times10^{-16}$ | $0$ (both $\theta>0$ orbits) | $\mathfrak r=\ker W$ |
| same | 5 | 15 | $\le4.5\times10^{-16}$ | $\le5.6\times10^{-16}$ | $0.516398$ | $1.154702$ |
| same | 6 | 30 | $\le3.0\times10^{-16}$ | $\le4.7\times10^{-16}$ | $0.802736$ | $0.802736$ |
| same | 7 | 4 of 24 solves converged | $\le5.0\times10^{-16}$ | $\le5.6\times10^{-16}$ | $1.137840$ | $1.137840$ |
| targeted: seeds at $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, torus, $\mathfrak u(3)$, padded $W_{\mathbb{CP}^2}$, $\varepsilon\in\{0,0.02,0.1,0.3,0.8\}$ | 6 | 4 converged | $\le1.3\times10^{-15}$ | $4.2\times10^{-16}$ | $1.3\times10^{-15}$, all $=S^3\times S^3$ | none saturating |
| gradient ascent to local maxima | 6 | 40 | $\le9.9\times10^{-14}$ | $\le5.2\times10^{-16}$ | $1.632993$ (padded $W_{\mathbb{CP}^2}$) | $1.632993$ |
| gradient ascent to local maxima | 8 | 40 | $\le9.4\times10^{-14}$ | $\le6.9\times10^{-16}$ | $7.8\times10^{-13}$ at $S^4\times S^4$ ($\mathfrak r=0$) | $3.265986$ |
| padded critical points, $\mathcal W_k\hookrightarrow\mathcal W_n$, $k=4,5,6$, $n\le8$ | 5–8 | $73$ | $\le4.7\times10^{-16}$ | $\le5.9\times10^{-16}$ | $0.577350$ | $0.866091$ |

The padded family is the sharpest control available: padding a critical Weyl tensor of $\mathbb R^k$ into $\mathbb R^n$ **stays** critical and **stays** Weyl (I verify $\mathrm{dist}(\mathcal W_n)\le5.9\times10^{-16}$ over $73$ of them), so it manufactures critical points with $\dim\mathfrak r$ up to $26$ and up to $13$ **nonzero** non-extreme eigenvalues, exactly the shape a counterexample would have. None with a nonzero non-extreme eigenvalue comes within $0.866$ of saturation. The mechanism is the one the theorem names: at padded $W_{\mathbb{CP}^2}$ the entire saturation failure is $[\mathfrak m,\mathfrak r]\neq0$, of mass $4,8,16$ at $n=5,6,8$, i.e. $2\dim\mathfrak m\,(n-4)$, zero exactly at $n=4$.

---

## 2. M1, the structure at saturation. Verdict: CONFIRMED, with one hypothesis and one step to add

### 2.1 The three inclusions need $\lambda_{\min}<0<\lambda_{\max}$ stated at the point of use

The record reads the equality case as "$\mathrm{ad}(v)$ supported on $E_{\min}\otimes E_{\max}$", but what $D(v)=0$ literally says is that $\mathrm{ad}(v)$ is supported on $\{(a,b):\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}\}$. That the second set equals the first is step (b) above and it is *false* without $\lambda_{\min}<0<\lambda_{\max}$, the same hypothesis Lemma L70 already needs for $D\ge0$, and the same one [Reviewer 323](REVIEW_r323.md) caught missing there. It costs one line and it should be in the text, because a spectrum with two negative and two positive eigenvalues can in principle equalise two different products.

### 2.2 The Jacobi step, as the brief asks

$[[\mathfrak m,\mathfrak m],[\mathfrak m,\mathfrak m]]\subseteq[\mathfrak m,[\mathfrak m,[\mathfrak m,\mathfrak m]]]$ is **not** a chain of subspace inclusions, an element of $[\mathfrak m,\mathfrak m]$ is a sum of brackets, and there is nothing to expand until it is written as one. It is valid, and valid **precisely because** $[\mathfrak m,\mathfrak m]$ is by definition the span of the brackets $[v,w]$: on those, $[[v,w],Y]=[v,[w,Y]]-[w,[v,Y]]$ with $[w,Y]\in[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, so the value lands in $[\mathfrak m,\mathfrak m]$; bilinearity does the rest. The record's notation invites the reader to check something that is not what is being used. Same remark for $[\mathfrak r,[\mathfrak m,\mathfrak m]]\subseteq[[\mathfrak r,\mathfrak m],\mathfrak m]+[\mathfrak m,[\mathfrak r,\mathfrak m]]=0$, which is correct on spanning brackets.

### 2.3 The step the record is missing, and it is the load-bearing one

The record stops at "$\mathfrak r$ centralises $\mathfrak g'$ entirely" and then hypothesises $\mathfrak r=0$. What it never asks is what the rest of $\mathfrak h$ does. $\mathfrak h_1=\mathfrak h\ominus[\mathfrak m,\mathfrak m]$ also centralises $\mathfrak m$ (§1.1(d)), so the centraliser is $\mathfrak h_1\oplus\mathfrak r$ and the decomposition $\mathfrak{so}(n)=\mathfrak g'\oplus\mathfrak c$ is a decomposition into **ideals**, not merely into a subalgebra and a commuting piece. That is the whole difference between an observation and a proof: with $\mathfrak h_1$ left out, $\mathfrak g'\oplus\mathfrak r$ need not exhaust $\mathfrak{so}(n)$ and simplicity says nothing.

---

## 3. M2, Lemma L71 itself. Verdict: CONFIRMED as mathematics, REFUTED AS STATED as a claim

### 3.1 "Exactly two eigenvalues, derived not assumed" is vacuous

$\mathfrak r$ is by construction the sum of the eigenspaces other than $E_{\min}$ and $E_{\max}$, and $\lambda_{\min}\neq\lambda_{\max}$ always. So **$\mathfrak r=0$ and "$W$ has exactly two eigenvalues" are the same sentence.** Lemma L71 as written assumes the two-eigenvalue property and then reports it as a conclusion, and the closing boast, "the saturating critical points are the balanced sphere products, and that needs no two-eigenvalue hypothesis", is not supported by the lemma above it. §1.1 repairs this: for $n\ge5$ the two-eigenvalue property *is* derived, from saturation alone.

A second, smaller overstatement in the same sentence: "$\mathfrak r=0$, equivalently, that $\mathfrak m=E_{\min}$ generates $\mathfrak{so}(n)$". Under saturation the algebra generated by $\mathfrak m$ is $\mathfrak g'=\mathfrak m\oplus[\mathfrak m,\mathfrak m]$, so "generates" is $\mathfrak r=0$ *and* $\mathfrak h_1=0$, strictly stronger, until one runs the simplicity argument that the record does not run.

One step used implicitly and worth writing: $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ (needed to call $\mathfrak{so}(n)=\mathfrak h\oplus\mathfrak m$ a symmetric pair) follows from $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$ by invariance ($\langle[x,y],v\rangle=-\langle y,[x,v]\rangle=0$ for $x,y\in\mathfrak h$, $v\in\mathfrak m$) and not from any of the three displayed relations directly.

### 3.2 Route (i) is valid, and its input hypothesis is real

Two eigenvalues plus $\operatorname{tr}W=0$ give $W=(\lambda_{\max}-\lambda_{\min})\big(\Pi_{\mathfrak h}-\tfrac rN I\big)$ with $r=\dim\mathfrak h$, so $W$ is in [Lemma L23](../results.md)'s family exactly, and $W$ is critical by assumption, which is Lemma L23's hypothesis $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$. Lemma L23 then gives $r\le n(n-2)/4$ with equality iff the pair is symmetric; saturation supplies the symmetric pair, so equality holds and the balanced split follows. The only thing to flag is that $\operatorname{tr}W=0$ is doing load-bearing work and is inherited from $\mathcal W_n$, not from saturation.

### 3.3 Route (ii) is valid, and the classification claim is stronger than the record checks

$\operatorname{tr}W=0$ with two eigenvalues gives $\dim\mathfrak m/\dim\mathfrak h=\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$, and with $\dim\mathfrak m+\dim\mathfrak h=N$ this forces $\dim\mathfrak m=n^2/4$, $\dim\mathfrak h=n(n-2)/4$, in particular $n$ even. The classification input is the Cartan list of involutions of compact $\mathfrak{so}(n)$: $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=n$ (BDI) and $\mathfrak u(n/2)$ for $n$ even (DIII), together with the triality-twisted copies at $n=8$, whose fixed algebras $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ have the dimensions $21$ and $13$ of $\mathfrak{so}(7)\oplus\mathfrak{so}(1)$ and $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$. **The list is complete as used.** And the uniqueness is not a table to be checked at $n=6,\dots,16$; it is one line at every even $n$:

$$\dim\big(\mathfrak{so}(p)\oplus\mathfrak{so}(q)\big)=\frac{n(n-2)}4+\Big(\frac{p-q}2\Big)^2,\qquad \dim\mathfrak u(n/2)=\frac{n(n-2)}4+\frac n2 ,$$

so the target $n(n-2)/4$ is met only at $p=q$, and $n=8$ adds nothing at $12$. The two defects the record quotes, $(p-q)^2/4$ and $m$, are exactly these two excesses.

### 3.4 Does route (ii) secretly depend on route (i)? Partly, and the shared part is the classification

| | route (i) | route (ii) |
| --- | --- | --- |
| source of $\dim\mathfrak h=n(n-2)/4$ | Lemma L23's sum of squares $S_{\mathfrak{mmm}}\ge0$ | $\operatorname{tr}W=0$ plus r324's ratio $n/(n-2)$ |
| classification of symmetric pairs of that dimension | used, inside Lemma L23's equality case | used, explicitly |
| independent of the audited material? | yes | no, it consumes r324's ratio |

So they are genuinely independent where the record says they are (deriving the dimension) and **not** independent where it matters most (the identification of $\mathfrak h$), since both discharge the last step with the same Cartan list. Route (ii) is therefore a check on r324's ratio *given* Lemma L23's classification work, not a second proof. §1.2 supplies what would make (ii) self-standing: for $n\ge5$ the ratio itself follows from saturation via Lemma L23, so r324's derivation can be dropped from route (ii), at the cost of route (ii) then resting on Lemma L23 as well.

---

## 4. M3, the mass law. Verdict: CONFIRMED as arithmetic, REFUTED AS STATED as confirmation of the ratio

### 4.1 The counting is right, including the factor 2

$T_{abc}=c_{abc}^2$ is totally symmetric with $\sum_{bc}T_{abc}=\lVert\mathrm{ad}\varphi_a\rVert^2=2(n-2)$ for every unit $\varphi_a$, this is $-\kappa(x,x)=2(n-2)\lVert x\rVert^2$ and needs no eigenbasis. At saturation each row $a\in\mathfrak m$ is carried by pairs with one index in $\mathfrak m$ and one in $\mathfrak h$, and the two orders contribute equally by symmetry of $T$, so

$$\dim\mathfrak m\cdot2(n-2)=\sum_{a\in\mathfrak m}\sum_{b,c}T_{abc}=2\!\!\sum_{a,b\in\mathfrak m,\,c\in\mathfrak h}\!\!T_{abc}=2M .$$

**The factor $2$ is the $b\leftrightarrow c$ swap and nothing else**; $M=\dim\mathfrak m\,(n-2)$ follows. Summing rows over $\mathfrak h$ instead and subtracting the $\mathfrak m\times\mathfrak m$ part, which is the same $M$, gives the residue **unconditionally** as $(n-2)(2\dim\mathfrak h-\dim\mathfrak m)$.

Reproduced independently, all five saturating points and the control:

| point | $\dim\mathfrak m/\dim\mathfrak h/\dim\mathfrak r$ | $M$ | $\dim\mathfrak m(n-2)$ | residue | $\dim\mathfrak h(n-4)$ | crit. residual | $\mathrm{dist}(\mathcal W_n)$ |
| --- | --- | --- | --- | --- | --- | --- | --- |
| $W_{\mathbb{CP}^2}$, $n=4$ | $2/1/3$ | $4$ | $4$ | $0$ | $0$ | $3.4\times10^{-16}$ | $1.2\times10^{-16}$ |
| $S^2\times S^2$, $n=4$ | $4/2/0$ | $8$ | $8$ | $0$ | $0$ | $1.9\times10^{-16}$ | $1.5\times10^{-16}$ |
| $S^3\times S^3$, $n=6$ | $9/6/0$ | $36$ | $36$ | $12$ | $12$ | $2.7\times10^{-16}$ | $1.7\times10^{-16}$ |
| $S^4\times S^4$, $n=8$ | $16/12/0$ | $96$ | $96$ | $48$ | $48$ | $3.3\times10^{-16}$ | $2.1\times10^{-16}$ |
| $S^5\times S^5$, $n=10$ | $25/20/0$ | $200$ | $200$ | $120$ | $120$ | $6.1\times10^{-16}$ | $2.5\times10^{-16}$ |
| $S^6\times S^6$, $n=12$ | $36/30/0$ | $360$ | $360$ | $240$ | $240$ | $2.8\times10^{-16}$ | $1.8\times10^{-16}$ |
| control: max torus, $n=6$ | $12/3/0$ | $24$ | $48$ | $0$ | $6$ | $4.8\times10^{-17}$ | $2.2\times10^{-16}$ |
| control: max torus, $n=8$ | $24/4/0$ | $48$ | $144$ | $0$ | $16$ | $1.4\times10^{-16}$ | $2.7\times10^{-16}$ |

Every reported number matches. The record's separate torus statistic is also reproduced: the mass of $\mathfrak m$'s rows off $\mathfrak m\times\mathfrak h$ is $\tfrac{m-2}{m-1}$ of the total, $m=n/2$, $48/96$ at $n=6$ and $192/288$ at $n=8$.

**One sentence in the premise is false, and the table above is what shows it.** "At saturation $T$ is supported on $(\mathfrak m,\mathfrak m,\mathfrak h)$" is not what saturation gives; saturation constrains only the rows **through $\mathfrak m$**. Triples with no $\mathfrak m$ index are untouched, and they are not empty: $\mathfrak h=[\mathfrak m,\mathfrak m]$ is a subalgebra with $[\mathfrak h,\mathfrak h]\ne0$, so the $(\mathfrak h,\mathfrak h,\mathfrak h)$ mass is exactly the residue column, $12,48,120,240$ at the balanced products $n=6,8,10,12$. The mass law survives because the derivation only ever sums rows, but the premise as written contradicts its own conclusion, since a residue of $\dim\mathfrak h(n-4)>0$ *is* off-support mass. At $n=4$ the residue is $0$, which is why the error is invisible at the witness.

### 4.2 Whether it confirms the saturation ratio: it is an assumption of it, dressed as a check

The record's closed form $\dim\mathfrak h(n-4)$ is obtained from the unconditional $(n-2)(2\dim\mathfrak h-\dim\mathfrak m)$ **by substituting $\dim\mathfrak m=n\dim\mathfrak h/(n-2)$**. So the two forms agree at a point iff that point satisfies $\dim\mathfrak m/\dim\mathfrak h=n/(n-2)$, and $\dim\mathfrak m$ and $\dim\mathfrak h$ are eigenvalue multiplicities, read directly off the spectrum in the same computation that produced $T$. The mass law contributes nothing to the verification: the check "residue $=\dim\mathfrak h(n-4)$" is logically the check "$\dim\mathfrak m/\dim\mathfrak h=n/(n-2)$", which is one division. Calling this "a check of that ratio through bracket-mass counting, a route sharing nothing with the reviewer's derivation" **overstates it**, and the sentence "that discharges the validation this record owes on the claim" should come out. What the five points do validate is the *unconditional* identity, which is a real and useful statement about the bracket tensor.

Two further points against the claim's evidential weight, both from the table above: at $n=4$ the residue identity reads $0=0$; and the five points comprise four balanced products, at which the ratio was never in doubt, plus the $n=4$ witness, where it is a single division on the multiplicities $2$ and $1$. **The repair is small**: state $M=\dim\mathfrak m(n-2)$ and residue $=(n-2)(2\dim\mathfrak h-\dim\mathfrak m)$ as the mass law, note that the ratio turns the second into $\dim\mathfrak h(n-4)$, and drop the independence claim. The ratio does have a second derivation, §1.2, and it is not this one.

---

## 5. What I would change in [bounds.md](../findings/bounds.md)

**Written after the fact: while this audit ran, the record landed the same theorem from [Reviewer 328](REVIEW_r328.md) (commit `ab9a8ce`).** That is an independent confirmation and I record it as one, 328 gets $\mathfrak g'$ to be an ideal from $[\mathfrak h,[\mathfrak m,\mathfrak m]]\subseteq[\mathfrak m,\mathfrak m]$, I get it from $[\mathfrak m,\mathfrak h\ominus[\mathfrak m,\mathfrak m]]=0$ and the ideal complement $\mathfrak z(\mathfrak m)$; both then run simplicity, and my §1.1(d) additionally identifies the missing piece as centralising rather than merely normalising. The five items below are what the audit leaves **after** that commit.

1. **The corrections and the claims they correct are both standing in the same section.** Four paragraphs of the pre-r328 text are now false where they sit, and a reader meets them *after* the box that refutes them: "The one hypothesis, named rather than hidden: $\mathfrak r=0$ … any version of this lemma without a hypothesis excluding $\mathfrak r$ is false" (true only at $n=4$); "So the open half of Lemma L71 is precisely: does saturation force $\mathfrak r\subseteq\ker W$?" (answered); the multiplicity formula "checked at exactly one point … a conjecture with a witness, not a verified law" (empty for $n\ge5$); and "*Route (i) uses nothing from the audit; route (ii) is a check on it*", which the same section's defect (iii) withdraws. Delete them rather than leaving them to be reconciled by the reader.
2. **The $n=6,\dots,16$ case list in the two-route paragraph** is superseded by defect (iv)'s one-line identity and should go with it.
3. **Add the minimum-product line** of §1.1(b). Every version of this section reads $D(v)=0$ straight off as "$\mathrm{ad}(v)$ supported on $E_{\min}\otimes E_{\max}$"; that step needs $\lambda_{\min}<0<\lambda_{\max}$ and is the one place the argument touches $\operatorname{tr}W=0$.
4. **Fix the mass law's premise**, per §4.1: saturation constrains the rows through $\mathfrak m$, not $T$ itself, and the residue column is the counterexample to the stronger reading.
5. **Record the second derivation of r324's ratio** that §1.2 supplies, since the record now says explicitly that the validation owed on that ratio is still owed: for $n\ge5$, saturation lands $W$ in Lemma L23's family and its equality case returns $\dim\mathfrak h=n(n-2)/4$, hence $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$, using no Bianchi identity beyond $\operatorname{tr}W=0$.

**Scripts.** [core.py](../scripts/reviewers/r327/core.py) (so(n), $\#$, $\mathcal W_n$, projector), [points.py](../scripts/reviewers/r327/points.py) (subalgebra points), [diag.py](../scripts/reviewers/r327/diag.py) (saturation structure and mass law), [search.py](../scripts/reviewers/r327/search.py), [run_hunt.py](../scripts/reviewers/r327/run_hunt.py), [run_targeted.py](../scripts/reviewers/r327/run_targeted.py), [run_ascent.py](../scripts/reviewers/r327/run_ascent.py). Log: [r327-lemma71.log](../agent_logs/r327-lemma71.log).
