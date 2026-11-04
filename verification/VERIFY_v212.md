# VERIFY_v212, Lemma L37, diagonality is decided by a single kernel

*Cold read of [BRIEF_L37.md](BRIEF_L37.md), sections A–D, against [conventions.md](../findings/conventions.md). **No numerical work of any kind was done**, no script, no Sage, no Python, no floating-point evaluation. Every object below is exhibited in closed form and every arithmetic step is exact and by hand. Log: [agent_logs/verify-L37-v212.log](../agent_logs/verify-L37-v212.log).*

## Claim table

| # | claim, as written | verdict |
| --- | --- | --- |
| 1 | $\delta_A(X)=AX+XA$ preserves the skew matrices | **CONFIRMED** |
| 2 | $\delta_A$ is the derivation extension $u\wedge v\mapsto Au\wedge v+u\wedge Av$ | **CONFIRMED** |
| 3 | $\delta_A\varphi_{ij}=(a_i+a_j)\varphi_{ij}$ in $A$'s eigenframe, and that frame is orthonormal | **CONFIRMED** |
| 4 | Forward: $W$ diagonal in $\{f_i\}$ $\Rightarrow$ $A=\sum_i2^if_if_i^{\mathsf T}\in\ker\Phi_W$ | **CONFIRMED** |
| 5 | The sums $2^i+2^j$ are pairwise distinct by uniqueness of binary representations | **CONFIRMED** |
| 6 | "so the distinctness is achievable at every $n$ and is never a genericity obstruction" | **CONFIRMED IN SCOPE, OVERSTATED OUT OF IT**, true only under the diagonality hypothesis it sits inside, and [LEDGER.md](../findings/LEDGER.md) line 701 restates it detached |
| 7 | Converse: pairwise-distinct sums force the $a_i$ distinct | **CONFIRMED FOR $n\ge3$, FALSE AT $n=2$** |
| 8 | Converse: simple spectrum of $\delta_A$ on $\Lambda^2$, eigenlines $\mathbb R\varphi_{ij}$ | **CONFIRMED** |
| 9 | Converse: $[W,\delta_A]=0$ makes $W$ preserve each eigenline, which is diagonality in $A$'s eigenframe | **CONFIRMED** |
| 10 | The range: A, B, C and D state the equivalence with no range; the proof's converse needs $n\ge3$ | **RANGE IN THE PROOF AND IN NO STATEMENT**, the equivalence is nonetheless true at $n\le2$, by an argument that is not on file |
| 11 | Corollary: a diagonal $W$ puts an $n$-dimensional space in $\ker\Phi_W$, so $\dim\ker\Phi_W<n$ excludes diagonality | **CONFIRMED** (D's wording *"all $n$ diagonal matrices"* is wrong; A's *"an $n$-dimensional subspace"* is right) |
| 12 | The corollary needs neither criticality nor $W\in\mathcal W_n$ | **CONFIRMED, AND UNDERSTATED**, the whole equivalence needs neither |
| 13 | Non-vacuity: $\dim\ker\Phi_W=1<4$ at $n=4$ | **TRUE BUT WITNESSLESS IN THE BLOCK**, no $W$ is named; the record's only backing is a floating-point table |
| 14 | "only the corollary is one-directional" | **CONFIRMED, with a closed-form witness supplied below** |
| 15 | The distinct-sums condition is the non-vanishing of a polynomial on $\ker\Phi_W$ | **TRUE, ARGUMENT MISSING**, eigenvalues are not polynomial in $A$ and the block never bridges that |
| 16 | Zariski dichotomy: identically zero, or non-zero on a dense open subset | **CONFIRMED** |
| 17 | "decided outright ... without an $O(n)$ search" | **CONFIRMED as a reduction**, "outright" being a shade strong |
| 18 | $\mathrm{Id}\in\ker\Phi_W$ always and has all sums equal, so the quantifier must be *some* | **CONFIRMED for $n\ge3$**; at $n=2$ the second half fails harmlessly |
| 19 | Frame-independence $\ker\Phi_{gWg^{-1}}=g(\ker\Phi_W)g^{-1}$ | **CONFIRMED**, with a notation abuse: $g$ acts on $\mathbb R^n$ and on $\Lambda^2$ under one symbol, and $g\in O(n)$ is never stated in the display |
| 20 | A only: "carries no information about $\theta$" | **NOT PROVEN BY THIS BLOCK**, an unargued numerical claim inside a canonical statement graded **Proven** |
| 21 | A only: "the criterion by which Observation L40 separates the two sides" | **CONFIRMED as provenance, with a scope caveat** on what L40 may cite |

**Summary.** The equivalence, the corollary, the decidability dichotomy, the quantifier and the frame-independence are all correct, and the record's numerical kernel dimensions at $\mathbb{CP}^m$ and its paddings reproduce exactly from a closed form I derive below; the defects are a range that lives in the proof and in no statement, a missing bridge from eigenvalues to a polynomial, a universal claim with no named witness, and one clause of the canonical statement that the proof does not touch.

## 0. Conventions, fixed once

Quoted, not restated, from [conventions.md](../findings/conventions.md):

> - **"Diagonal" means diagonal in coordinate $2$-planes $e_i\wedge e_j$** of an orthonormal frame of $\mathbb R^n$, *not* diagonal as an operator on $\Lambda^2\mathbb R^n$. A generic spectral eigenbasis is essentially never of that form, and conflating the two is what makes the diagonal case look liftable.

> | $\Phi$ | **the letter carries four unrelated objects.** *(i)* $\Phi_W(A)=[W,\delta_A]$ with $\delta_A(X)=AX+XA$, the frame-independent diagonality test of [L37](../results.md), the sense every $\ker\Phi_W$ takes; …

> | $D_A$, $H_A$ | for $A\in\mathrm{Sym}_0(\mathbb R^n)$, $D_A$ is the induced derivation on $\Lambda^2$ and $H_A=D_AW+WD_A$ the deformation it generates. **Neither had a definition on the record** …

> | $\dim\mathcal W_n$ | $\frac{n(n-3)(n+1)(n+2)}{12}$, $10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$ |

Sense (i) is the one L37 takes throughout, and it is the only sense in this report. Two consequences of the third quotation are used in §7: the induced derivation is already tabled under the letter $D_A$, and it is tabled on $\mathrm{Sym}_0$, whereas L37 needs it on all of $\mathrm{Sym}^2$.

Two further points of reading. **The sums $a_i+a_j$ are over $i\ne j$.** The statements never say so; the converse's step *"For $n\ge3$ that forces the $a_i$ themselves distinct"* is what fixes it, since under an $i\le j$ reading the step would hold at every $n\ge2$ and the threshold would be pointless. The $i\ne j$ reading is also the one that matches $\mathop{\mathrm{spec}}(\delta_A|_{\Lambda^2})$, which is what the converse consumes. **And the block restates the tabled meaning of "diagonal"** (*"Diagonal here means diagonal on the coordinate $2$-planes of the frame"*) where [conventions.md](../findings/conventions.md)'s own rule is that a convention is quoted; the two agree, so this is a process point and not a defect.

## Hypothesis inventory

| # | hypothesis | stated where | used where | status |
| --- | --- | --- | --- | --- |
| H1 | $W$ a linear operator on $\Lambda^2\mathbb R^n$ | implicit in $[W,\delta_A]$ | everywhere | fine; symmetry of $W$ is never needed |
| H2 | $W\in\mathcal W_n$ | A, B, D all open with it | **nowhere** | **stated and never used.** The block half-admits it (*"it needs neither criticality nor $W\in\mathcal W_n$"*) but scopes the admission to the corollary, when it covers the equivalence too |
| H3 | $A$ symmetric, on **all** of $\mathrm{Sym}^2(\mathbb R^n)$ | A says $\mathrm{Sym}^2(\mathbb R^n)$; B and D say only "symmetric" | the threshold $n$ in the corollary, and $\mathrm{Id}\in\ker\Phi_W$ | **load-bearing and half-stated.** On $\mathrm{Sym}_0$, the domain [conventions.md](../findings/conventions.md) tables for the same operator under the letter $D_A$, the diagonal matrices span $n-1$ dimensions and the corollary's threshold is $n-1$, not $n$; and $\mathrm{Id}\notin\mathrm{Sym}_0$, which would empty the quantifier paragraph |
| H4 | $n\ge3$ | **no statement**; only the proof's converse | the converse, essentially | **the headline finding.** §4 |
| H5 | $A$'s eigenframe orthonormal | never stated | the converse's conclusion, which is about an *orthonormal* frame | fine, the spectral theorem supplies it, and no hypothesis is owed |
| H6 | criticality, $S=0$, $\theta$ | disclaimed | nowhere | correctly disclaimed |
| H7 | $\ker\Phi_W$ is a linear subspace | asserted in the decidability paragraph | the Zariski dichotomy | fine, $A\mapsto\delta_A$ is linear and $[W,\cdot]$ is linear, so $\Phi_W$ is linear; the block never says it |
| H8 | $g\in O(n)$ in the frame-independence display | said only in the words after it | the display | fine in substance, sloppy in the display (§9) |

## 1. The action, the three claims, derived separately

**(a) $\delta_A$ preserves the skew matrices.** For $X^{\mathsf T}=-X$ and $A^{\mathsf T}=A$,
$$(AX+XA)^{\mathsf T}=X^{\mathsf T}A^{\mathsf T}+A^{\mathsf T}X^{\mathsf T}=-XA-AX=-(AX+XA).$$
Symmetry of $A$ is used twice and is available. **CONFIRMED.**

**(b) $\delta_A$ is the derivation extension.** Identify $u\wedge v$ with $uv^{\mathsf T}-vu^{\mathsf T}$. Using $A^{\mathsf T}=A$ to write $(uv^{\mathsf T})A=u(Av)^{\mathsf T}$,
$$A(uv^{\mathsf T}-vu^{\mathsf T})+(uv^{\mathsf T}-vu^{\mathsf T})A=\big[(Au)v^{\mathsf T}-v(Au)^{\mathsf T}\big]+\big[u(Av)^{\mathsf T}-(Av)u^{\mathsf T}\big]=Au\wedge v+u\wedge Av.$$
Both sides are linear in the identification, so any normalising factor on $u\wedge v$ cancels, this is one place where the record's live $\tfrac12$ ambiguity on $\Lambda^2$ does no damage. **CONFIRMED.**

**(c) $\delta_A\varphi_{ij}=(a_i+a_j)\varphi_{ij}$, and the frame is orthonormal.** $A$ is real symmetric, so the spectral theorem gives an **orthonormal** eigenframe $\{f_i\}$ with $Af_i=a_if_i$, repeated eigenvalues included. Then $\delta_A(f_i\wedge f_j)=a_if_i\wedge f_j+f_i\wedge a_jf_j=(a_i+a_j)f_i\wedge f_j$ by (b). **CONFIRMED**, and the orthonormality the brief asks about is exactly the spectral theorem's, which is why the converse lands in an orthonormal frame and meets [conventions.md](../findings/conventions.md)'s definition of "diagonal" rather than a weaker one.

## 2. The forward direction

$W$ diagonal in the orthonormal frame $\{f_i\}$ means every $f_i\wedge f_j$ is an eigenvector of $W$; since the $\binom n2$ of them are a basis of $\Lambda^2$, $W$ is diagonal in that basis. Put $A=\sum_i2^if_if_i^{\mathsf T}$. Then $A$ is symmetric with eigenframe $\{f_i\}$ and eigenvalues $a_i=2^i$, so by §1(c) $\delta_A$ is diagonal in the same basis $\{f_i\wedge f_j\}$. Two operators diagonal in one basis commute, so $[W,\delta_A]=0$ and $A\in\ker\Phi_W$. **CONFIRMED.** The block's phrase *"$A$ commutes with $W$'s diagonal action"* is loose, the commutation is between $W$ and $\delta_A$, both on $\Lambda^2$, while $A$ itself lives on $\mathbb R^n$, but the content is right.

**The distinctness, checked as stated.** The claim is about sums of two **distinct** powers: if $2^i+2^j=2^k+2^l$ with $i<j$ and $k<l$, then the two sides are the same non-negative integer, whose binary expansion has exactly two $1$-bits, in positions $\{i,j\}$ on the left and $\{k,l\}$ on the right; uniqueness of binary representation gives $\{i,j\}=\{k,l\}$. **CONFIRMED**, and the hypothesis $i\ne j$ is doing real work: $2^i+2^i=2^{i+1}$ has one bit, so the argument as phrased is exactly the $i\ne j$ one. (Under an $i\le j$ reading the conclusion survives too, since $2^{i+1}$ has one bit and $2^k+2^l$ with $k<l$ has two, but that is a different argument from the one written.)

**"never a genericity obstruction".** The sentence sits inside the italic scope *"If $W$ is diagonal in some frame $\{f_i\}$"*, and in that scope it is correct and worth saying: within $\ker\Phi_W$ for a diagonal $W$ one need not argue that a *generic* $A$ has distinct sums, because an explicit one does. Read outside that scope it is false, and the converse is precisely the statement that it is false: for a non-diagonal $W$ **no** $A\in\ker\Phi_W$ has distinct sums. The bolding invites the wider reading, and [LEDGER.md](../findings/LEDGER.md) line 701 has already taken it (*"The distinctness the criterion needs is never an obstruction"*) as a free-standing sentence whose only tether to diagonality is the $f_i$ inside the displayed $A$. **CONFIRMED IN SCOPE, OVERSTATED OUT OF IT.**

## 3. The converse

Let $A\in\ker\Phi_W$ have pairwise-distinct sums, $n\ge3$.

**Step 1, distinct sums force distinct $a_i$.** Suppose $a_i=a_j$ with $i\ne j$. Since $n\ge3$ pick $k\notin\{i,j\}$. Then $\{i,k\}$ and $\{j,k\}$ are distinct pairs with $a_i+a_k=a_j+a_k$, contradicting distinctness. **CONFIRMED, and $n\ge3$ is exactly what the step consumes**, the third index is the whole of it.

**Step 2, simple spectrum with eigenlines $\mathbb R\varphi_{ij}$.** By §1(c), $\mathop{\mathrm{spec}}(\delta_A|_{\Lambda^2})=\{a_i+a_j\}_{i<j}$ with $\varphi_{ij}=f_i\wedge f_j$ an eigenvector for $a_i+a_j$. These are $\binom n2$ pairwise-distinct values on a $\binom n2$-dimensional space, so each eigenspace is exactly the line $\mathbb R\varphi_{ij}$. **CONFIRMED.** Step 1 is not needed for this (distinct sums alone give it) which is worth noting, because it means the $n\ge3$ threshold is consumed by Step 1 alone and by nothing else in the proof.

**Step 3, $[W,\delta_A]=0$ makes each $\varphi_{ij}$ an eigenvector of $W$.** From $\delta_A\varphi_{ij}=\mu\varphi_{ij}$ with $\mu=a_i+a_j$, $\delta_A(W\varphi_{ij})=W\delta_A\varphi_{ij}=\mu\,W\varphi_{ij}$, so $W\varphi_{ij}$ lies in the $\mu$-eigenspace of $\delta_A$, which by Step 2 is $\mathbb R\varphi_{ij}$. Hence $W\varphi_{ij}=\lambda_{ij}\varphi_{ij}$. **The brief's worry does not bite**: a $W$-invariant subspace of dimension **one** is by definition an eigenline of $W$, so "preserves the line" and "the line is spanned by an eigenvector" coincide here. The worry would be real if the eigenspaces of $\delta_A$ had dimension $\ge2$, which is exactly what distinct sums rules out, so the simple-spectrum step is not decoration.

**Step 4, this is diagonality in the tabled sense.** $\{f_i\}$ is orthonormal by §1(c), and every $f_i\wedge f_j$ is an eigenvector of $W$ by Step 3, which is [conventions.md](../findings/conventions.md)'s *"diagonal in coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame"* verbatim. **CONFIRMED.** Had $A$ been merely diagonalisable rather than symmetric the frame could have failed to be orthonormal and this step would have produced a weaker conclusion than the statement claims; symmetry of $A$ is where that is bought.

**No symmetry of $W$ is used anywhere in §2 or §3.** The equivalence holds for every linear operator on $\Lambda^2\mathbb R^n$, $n\ge3$.

## 4. The range, $n=2$, $n=3$, and which statement is correct

**Located.** [target.md](../findings/target.md) line 642 carries *"For $n\ge3$"*. [results.md](../results.md) lines 16, 160 and 511, and [target.md](../findings/target.md) line 636, carry no range at all. So a range lives in a proof and in no statement, the failure mode the brief names.

**Exhibited concretely, at $n=2$.** $\Lambda^2\mathbb R^2=\mathbb R\varphi_{12}$ is one-dimensional, so there is exactly **one** pair $\{1,2\}$ and exactly one sum $a_1+a_2$. "Pairwise-distinct sums" over a one-element set holds vacuously for **every** symmetric $A$. Take $A=\mathrm{Id}$: it lies in $\ker\Phi_W$ for every $W$ (§8), it has pairwise-distinct sums in this vacuous sense, and $a_1=a_2$. **So the converse's Step 1 is false at $n=2$**, and with it the written route to the conclusion.

**Argued the opposite.** The *conclusion* survives. At $n=2$ every linear $W$ on the one-dimensional $\Lambda^2\mathbb R^2$ is a scalar, and $e_1\wedge e_2$ spans that space, so $e_1\wedge e_2$ is an eigenvector for any orthonormal frame $\{e_1,e_2\}$ and every $W$ is diagonal. Both sides of the equivalence are identically true at $n=2$, and the equivalence holds, by a different argument, which is not on file. The same holds vacuously at $n\le1$, where $\Lambda^2=0$.

**Verdict on the range.** The unrestricted statements are **true**; the proof establishes them only for $n\ge3$; the missing case is one line and nobody has written it. This is a `GAP` in the proof, not a `BROKEN` in the statement, the discrepancy protocol's third leg (argue the opposite) succeeds, so the finding is recorded as a proof-coverage defect rather than a refutation.

**$n=3$ is the correct threshold for the written argument**, and it is sharp for Step 1: at $n=2$ Step 1 fails, at $n=3$ the third index exists. **Two ways to close the gap**, neither of which I supply as an argument, both of which the block could state: add "$n\ge3$" to the statements and note the $n\le2$ case separately; or read the sums over $i\le j$, under which "distinct sums" directly gives $2a_i\ne2a_j$ and Step 1 needs no third index. The second changes the criterion, $a=(0,1,2)$ has $\{a_i+a_j\}_{i<j}=\{1,2,3\}$ distinct while $2a_2=2=a_1+a_3$, so the two readings are genuinely different conditions, and it is not the reading the block uses.

**$n\le3$ inside $\mathcal W_n$ is empty**, by [conventions.md](../findings/conventions.md)'s $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$, which is $0$ at $n=3$ and not defined as a dimension at $n=2$. So a reader who keeps hypothesis H2 never meets the gap. But the block's own *"it needs neither criticality nor $W\in\mathcal W_n$"* discards H2, and the record uses $\ker\Phi_W$ on operators that are not Weyl tensors, so the gap is reachable in the record's own reading.

## 5. The corollary

**The count.** Let $W$ be diagonal in the orthonormal frame $\{f_i\}$. For any $a\in\mathbb R^n$, $A=\sum_ia_if_if_i^{\mathsf T}$ has eigenframe $\{f_i\}$, so $\delta_A$ is diagonal in $\{f_i\wedge f_j\}$ by §1(c), where $W$ is diagonal too, so $[W,\delta_A]=0$. The $f_if_i^{\mathsf T}$ are orthogonal rank-one idempotents, hence linearly independent in $\mathrm{Sym}^2(\mathbb R^n)$, so they span an $n$-dimensional subspace of $\ker\Phi_W$ and $\dim\ker\Phi_W\ge n$. Contrapositive: $\dim\ker\Phi_W<n\Rightarrow W$ diagonal in no orthonormal frame. **CONFIRMED.**

**A wording defect in D.** *"A diagonal $W$ has all $n$ diagonal matrices in $\ker\Phi_W$"*, there are not $n$ diagonal matrices; there is an $n$-dimensional space of them. [results.md](../results.md) line 511 has it right: *"the diagonal matrices in any frame supply an $n$-dimensional subspace"*. The canonical entry is correct and the proof block is not, which is the wrong way round.

**The threshold depends on H3.** The subspace is $n$-dimensional because $\mathrm{Sym}^2$ is the domain. On $\mathrm{Sym}_0(\mathbb R^n)$, the domain [conventions.md](../findings/conventions.md) tables for the same operator under the letter $D_A$, the diagonal trace-free matrices span $n-1$ dimensions and the certificate would read $\dim\ker\Phi_W<n-1$. Every consumed number on the record is computed on $\mathrm{Sym}^2$ (§6 confirms this exactly), so nothing is broken; but only [results.md](../results.md) line 511 says which domain, and the proof block does not.

**"needs neither criticality nor $W\in\mathcal W_n$", CONFIRMED and understated.** Nothing in §1, §2, §3 or §5 uses criticality, $S=0$, $\theta$, the Bianchi identity, tracelessness or even symmetry of $W$. The disclaimer is scoped to the corollary; it covers the equivalence as well.

**"only the corollary is one-directional", CONFIRMED, with a witness the block does not give.** A closed-form object at $n=4$ settles it. Let $\omega=\varphi_{12}+\varphi_{34}\in\Lambda^2\mathbb R^4$ and let $W=P_\omega$ be the orthogonal projection onto $\mathbb R\omega$, a symmetric operator on $\Lambda^2\mathbb R^4$.

*$P_\omega$ is diagonal in no orthonormal frame.* Its eigenvalue $1$ is simple with eigenline $\mathbb R\omega$, and $\omega\wedge\omega=2\,e_1\wedge e_2\wedge e_3\wedge e_4\ne0$, so $\omega$ is not decomposable and $\mathbb R\omega\ne\mathbb R f_i\wedge f_j$ for any frame. In a diagonalising frame a simple eigenvalue's eigenline would have to be one of the $\mathbb R f_i\wedge f_j$.

*Yet $\dim\ker\Phi_{P_\omega}=7\ge4=n$.* Since $\delta_A$ is self-adjoint, $[P_\omega,\delta_A]=0$ iff $\delta_A\omega\in\mathbb R\omega$. Writing $A=(a_{k\ell})$ symmetric and expanding $\delta_A\omega=Ae_1\wedge e_2+e_1\wedge Ae_2+Ae_3\wedge e_4+e_3\wedge Ae_4$ in the basis $\{\varphi_{k\ell}\}_{k<\ell}$ gives coefficients
$$\varphi_{12}:a_{11}+a_{22},\quad\varphi_{34}:a_{33}+a_{44},\quad\varphi_{13}:a_{23}-a_{14},\quad\varphi_{14}:a_{13}+a_{24},\quad\varphi_{23}:-(a_{13}+a_{24}),\quad\varphi_{24}:a_{23}-a_{14}.$$
So $\delta_A\omega\in\mathbb R\omega$ iff $a_{14}=a_{23}$, $a_{13}=-a_{24}$ and $a_{11}+a_{22}=a_{33}+a_{44}$: three independent linear conditions on the $10$-dimensional $\mathrm{Sym}^2(\mathbb R^4)$, leaving $\dim\ker\Phi_{P_\omega}=7$.

So $\dim\ker\Phi_W\ge n$ carries no implication, the corollary is genuinely one-directional, and the decidability paragraph's *"including at $\dim\ker\Phi_W=n$ where the corollary says nothing"* is about a non-empty situation.

*And the equivalence classifies this $W$ correctly, on the whole $7$-dimensional kernel, in closed form.* Every $A\in\ker\Phi_{P_\omega}$ has $\delta_A\omega=\lambda\omega$ with $\lambda=a_{11}+a_{22}$. If $A$ had pairwise-distinct sums then by §3 Step 2 the eigenspaces of $\delta_A$ would all be lines $\mathbb R f_i\wedge f_j$, each spanned by a **decomposable** bivector; but $\omega$ is an eigenvector and is not decomposable. So no $A\in\ker\Phi_{P_\omega}$ has pairwise-distinct sums, and the criterion returns "not diagonal", which is right. **This is the sharpest independent test of the converse I can run without computation, and L37 passes it at a kernel dimension where the corollary is silent.**

## 6. The non-vacuity witness, and the padded objects

**The block names no $W$.** *"it is not vacuous, $\dim\ker\Phi_W=1<4$ at $n=4$"* is an existence claim with no object attached, which is the "universal claim with no witness" trap in the brief. **Finding: the block does not name it.**

**What the record has.** [target.md](../findings/target.md)'s post-F22 table gives $\dim\ker\Phi_W=1$ at $\mathbb{CP}^2,\mathbb{CP}^3,\mathbb{CP}^4,\mathbb{CP}^5$, and $\mathbb{CP}^2$ is the $n=4$ row, so the intended witness is $W_{\mathbb{CP}^2}$. [REVIEW_r80.md](../reviews/REVIEW_r80.md) line 64 classifies that table's kernel dimensions as **"floating point only"**. So the record's sole backing for a claim inside a `Proven` block is numerical.

**It is derivable in closed form, and the derivation is short.** On $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ write $W=W^+\oplus W^-$. Split $A=\tfrac{\mathop{\mathrm{tr}}A}4\mathrm{Id}+A_0$ with $A_0$ trace-free; $\delta_{\mathrm{Id}}=2\,\mathrm{Id}_{\Lambda^2}$ is central, so $A\in\ker\Phi_W$ iff $A_0\in\ker\Phi_W$. For trace-free symmetric $A_0$ the operator $\delta_{A_0}$ **exchanges** $\Lambda^+$ and $\Lambda^-$, checked on $A_0=\mathrm{diag}(1,1,-1,-1)$, where $\delta_{A_0}(\varphi_{12}+\varphi_{34})=2(\varphi_{12}-\varphi_{34})$, so $\delta_{A_0}=\left(\begin{smallmatrix}0&\beta^{*}\\\beta&0\end{smallmatrix}\right)$ and
$$[W,\delta_{A_0}]=\begin{pmatrix}0&W^+\beta^{*}-\beta^{*}W^-\\ \beta W^+-W^-\beta&0\end{pmatrix}.$$
By Sylvester's theorem this vanishes only for $\beta=0$ whenever $\mathop{\mathrm{spec}}(W^+)\cap\mathop{\mathrm{spec}}(W^-)=\varnothing$. At $W_{\mathbb{CP}^2}$, $W^-=0$ and $W^+$ is invertible, so the spectra are disjoint and $\beta=0$; and $A_0\mapsto\delta_{A_0}$ is injective for $n\ge3$ (if all $a_i+a_j=0$ for $i<j$ then $A_0=0$). Hence $\ker\Phi_{W_{\mathbb{CP}^2}}=\mathbb R\,\mathrm{Id}$ and $\dim=1<4$. **The claim is TRUE; the defect is that the block asserts it with no object and the record supports it with a float.**

**The padded objects, constructed as the brief demands.** Let $W_0$ act on $\Lambda^2\mathbb R^m$ and let $W=W_0\oplus0$ be its zero-padding to $\Lambda^2\mathbb R^n$, $n>m$. Split $\mathbb R^n=\mathbb R^m\oplus V$, $\dim V=n-m$, so $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^m\oplus(\mathbb R^m\otimes V)\oplus\Lambda^2V$ with $W$ equal to $W_0$ on the first summand and $0$ on the other two. For $A=a\,\mathrm{Id}_m\oplus B$ with $B$ symmetric on $V$, $A$ preserves the splitting, hence so does $\delta_A$; on $\Lambda^2\mathbb R^m$ it is the scalar $2a$, which commutes with $W_0$, and on the other two summands $W$ vanishes. So every such $A$ lies in $\ker\Phi_W$ and
$$\dim\ker\Phi_{W_0\oplus0}\ \ge\ 1+\binom{n-m+1}2 .$$
**This closed form reproduces the record's measured table exactly.** Padded $\mathbb{CP}^2$ at $n=8$ ($m=4$): $1+\binom52=11$, against the table's $11$. Padded $\mathbb{CP}^3$ at $n=8$ ($m=6$): $1+\binom32=4$, against the table's $4$. Unpadded $\mathbb{CP}^m$ ($n=m$): $1+\binom12=1$, against the table's $1,1,1,1$. Three independent rows, no float. It also explains the record's own note at [target.md](../findings/target.md) line 510 that implementing only the dimension corollary *"wrongly called padded $W_{\mathbb{CP}^2}$ diagonal"*: at $n=8$ the kernel is $11\ge8$, so the corollary is silent there by construction, and the distinct-sums clause is what decides it. **The padded trap is real, the record has met it, and L37 as stated survives it, because the corollary is the only one-directional part and the block says so.**

## 7. Decidability, is the condition really polynomial in $A$?

The block says: *"On the linear subspace $\ker\Phi_W$ the distinct-sums condition is the non-vanishing of a polynomial, which therefore either vanishes identically on it or is non-zero on a dense Zariski-open subset."*

**The brief's objection is correct as stated: eigenvalues are not polynomial functions of a matrix.** $a_1,\dots,a_n$ are the roots of $\chi_A$; on $\mathrm{Sym}^2(\mathbb R^n)$ they can be chosen continuously but not polynomially, and individually they are not even single-valued. The block asserts polynomiality of a condition it has written entirely in terms of them, and supplies no bridge. **Finding: the load-bearing step of the decidability paragraph is asserted, not argued.**

**The claim is nonetheless true, by a bridge the block does not name.** $\delta_A$ depends **linearly** on $A$, so the coefficients of $\chi_{\delta_A}(t)=\det(t\,\mathrm{Id}_{\Lambda^2}-\delta_A)$ are polynomials in the entries of $A$; the discriminant of a monic polynomial is a polynomial in its coefficients; hence
$$D(A):=\mathop{\mathrm{disc}}\big(\chi_{\delta_A}\big)$$
is a polynomial in the entries of $A$. Since $A$ is symmetric, $\delta_A$ is diagonalisable with $\mathop{\mathrm{spec}}(\delta_A|_{\Lambda^2})=\{a_i+a_j\}_{i<j}$ by §1(c), so $D(A)\ne0$ iff those $\binom n2$ values are pairwise distinct, **exactly** the distinct-sums condition, symmetric in the $a_i$ and therefore expressible without choosing an ordering of them, which is what the eigenvalue objection is really about. Note the route runs through the **discriminant of $\delta_A$ on $\Lambda^2$**, not of $A$ on $\mathbb R^n$: $\mathop{\mathrm{disc}}(\chi_A)\ne0$ says the $a_i$ are distinct, which is strictly weaker than distinct sums at every $n\ge3$ ($a=(0,1,2)$ again).

**The dichotomy, CONFIRMED.** $\Phi_W$ is linear in $A$ (composition of the linear $A\mapsto\delta_A$ with the linear $[W,\cdot]$), so $V:=\ker\Phi_W$ is a linear subspace, say of dimension $m$. Restricting $D$ along a linear parametrisation $\mathbb R^m\to V$ gives a polynomial in $m$ variables. Over the infinite field $\mathbb R$ a polynomial that is not the zero polynomial does not vanish identically, and its zero set is a proper algebraic subset (Zariski-closed with empty Euclidean interior) so its complement is Zariski-open and dense in both topologies. Hence exactly one of: no $A\in V$ has distinct sums; or a dense open subset of $V$ does. **CONFIRMED.**

**What decidability actually follows.** Combining with §2 and §3, for $n\ge3$:
$$W\ \text{is diagonal in some orthonormal frame}\iff D|_{\ker\Phi_W}\not\equiv0 .$$
That is a genuine reduction, and it is the content the block is reaching for: **the $O(n)$ frame search is replaced by one linear-algebra kernel computation plus one identical-vanishing test of an explicit polynomial on a linear subspace**, which is decidable by elimination over any field the data live in. Two qualifications the block does not make. First, *"decided outright"* overstates it: the dichotomy converts an existential over a continuum into a genericity test, and a test still has to be run, the block's own $\square$ falls before this paragraph, so this is commentary and not part of the proved lemma. Second, the reduction is **exact-arithmetic**; deciding $D|_V\equiv0$ in floating point requires tolerances on both $\dim\ker\Phi_W$ and the sum gaps, and both are ill-conditioned near a degeneracy. That bears on §10's consumer, not on L37.

## 8. The quantifier

**$\mathrm{Id}\in\ker\Phi_W$ always, CONFIRMED.** $\delta_{\mathrm{Id}}(X)=X+X=2X$, so $\delta_{\mathrm{Id}}=2\,\mathrm{Id}_{\Lambda^2}$, which commutes with every operator on $\Lambda^2$; hence $[W,\delta_{\mathrm{Id}}]=0$ for every $W$ whatsoever. This is also why $\ker\Phi_W\ne0$ always, so the corollary's certificate has $\dim\ker\Phi_W\in\{1,\dots,n-1\}$ as its whole range of usable values.

**"and has all sums equal", CONFIRMED, with an $n=2$ footnote.** For $A=\mathrm{Id}$ every $a_i+a_j=2$, so the distinct-sums condition fails as soon as there are two distinct pairs, that is at $n\ge3$. At $n=2$ there is one pair and the condition holds vacuously, consistent with §4, where every $W$ is diagonal at $n=2$ anyway. So the quantifier paragraph, like the converse, is an $n\ge3$ statement, and the same unstated range runs through it.

**The conclusion, CONFIRMED.** A criterion reading "**all** $A\in\ker\Phi_W$ have distinct sums" would be false at every $W$ and every $n\ge3$, since $\mathrm{Id}$ is always a counterexample; the existential quantifier is forced. **This paragraph is the block's own trap-note and it is correct.**

## 9. Frame-independence

**The identity, CONFIRMED.** For invertible $g$ on $\mathbb R^n$, on decomposables,
$$(\Lambda^2g)\,\delta_A\,(\Lambda^2g)^{-1}(u\wedge v)=(\Lambda^2g)\big(Ag^{-1}u\wedge g^{-1}v+g^{-1}u\wedge Ag^{-1}v\big)=gAg^{-1}u\wedge v+u\wedge gAg^{-1}v=\delta_{gAg^{-1}}(u\wedge v),$$
so $\delta_{gAg^{-1}}=(\Lambda^2g)\delta_A(\Lambda^2g)^{-1}$. Conjugating the bracket,
$$\big[(\Lambda^2g)W(\Lambda^2g)^{-1},\ \delta_{gAg^{-1}}\big]=(\Lambda^2g)\,[W,\delta_A]\,(\Lambda^2g)^{-1},$$
so $A\in\ker\Phi_W\iff gAg^{-1}\in\ker\Phi_{gWg^{-1}}$, giving the stated equality of kernels and equality of dimensions. And $gAg^{-1}$ has the same eigenvalues as $A$, so the distinct-sums clause transfers too. **Both halves CONFIRMED.**

**Two notational points.** The display writes $gWg^{-1}$ where $W$ acts on $\Lambda^2$ and $g$ on $\mathbb R^n$; the two conjugations are by $\Lambda^2g$ and by $g$ respectively, under one symbol. And $g\in O(n)$ appears only in the prose after the display, it is needed, because $gAg^{-1}$ must be symmetric for it to lie in the domain of $\Phi$, and because the conclusion is about *orthonormal* frames. Neither is an error; both are the kind of elision that a reader reconstructing the argument has to repair.

## 10. The consumers, and the clause the proof does not touch

**"carries no information about $\theta$" ([results.md](../results.md) line 511), NOT PROVEN BY THIS BLOCK.** Nothing in section D argues it. The record's support is [target.md](../findings/target.md)'s post-F22 table, which is measured, plus the observation at [target.md](../findings/target.md) line 458 that $\dim\ker\Phi_W=1$ forces $\ker\Phi_W=\mathbb R\,\mathrm{Id}$ *exactly*, so $\mathbb{CP}^3$ and $\mathbb{CP}^5$ have literally the same kernel at different $\theta$. That last step is analytic and correct **given** the two kernel dimensions, and §6 above shows those dimensions are derivable in closed form at $\mathbb{CP}^m$, so the clause is defensible, but its derivation is in another block and the record's own [REVIEW_r80.md](../reviews/REVIEW_r80.md) line 38 grades the stronger form **OVERSTATED**. **Finding: a clause whose warrant is elsewhere and partly numerical sits inside a canonical statement carried at `Proven` in [results.md](../results.md) line 16.** It should be attributed to post F22, not to L37's proof.

**"the criterion by which Observation L40 separates the two sides", CONFIRMED as provenance, with a scope caveat.** [results.md](../results.md) line 166 has L40 deciding diagonality over catalogued critical points by L37. Two things L40 may **not** cite. It may not cite the *corollary* alone: [bounds.md](../findings/bounds.md) line 171 records $\dim\ker\Phi_W=8=n$ at the $n=8$ witness, where the corollary is silent, and [target.md](../findings/target.md) line 510 records the corollary alone misclassifying padded $W_{\mathbb{CP}^2}$, both of which §6 explains exactly. And it may not cite the equivalence as an *exact* decision when the distinct-sums clause was run in floating point (§7). **Frame-independence is enough for L40's use**: catalogued points come in $O(n)$-orbits, and §9 shows the kernel dimension and the distinct-sums clause are both $O(n)$-invariant, so a verdict computed in one representative holds on the orbit. That is the whole of what frame-independence buys, and it is what L40 needs.

## 11. The traps, each answered by name

- **$\ker W\ne0$ and padded objects.** Constructed in §6. Zero-padding gives $\dim\ker\Phi_{W_0\oplus0}\ge1+\binom{n-m+1}2$, which pushes the kernel **above** the threshold $n$ and silences the corollary, and the closed form reproduces the record's $11$, $4$ and $1$ exactly. The equivalence survives; only the corollary is defeated, and the block says the corollary is one-directional. A large $\ker W$ on its own does nothing here: $P_\omega$ in §5 has $\dim\ker W=5$ and is correctly classified.
- **Boundaries of the stated ranges.** $n=2$: the converse's Step 1 is **false** there and the statement is nonetheless true, §4, the headline finding. $n=3$: the correct and sharp threshold for the written argument, and the first $n$ at which $\mathcal W_n$ could be non-trivial ($\dim\mathcal W_3=0$, so in fact the first is $n=4$). $n=4$: the corollary's non-vacuity claim lives here and names no object, §6.
- **The crossover $n=6+2\sqrt7$.** No contact. It is the root of $n^2-12n+8=0$ comparing $P$-values of two competing critical points ([ATTEMPTS.md](../ATTEMPTS.md) lines 228, 297, 336); L37 has no $n$-dependence beyond the $n\ge3$ threshold and no dependence on $\theta$ or $P$ at all. **Checked, nothing found.**
- **A claim proven on a subfamily and used in general.** The forward direction's $A=\sum_i2^if_if_i^{\mathsf T}$ is built from the diagonalising frame and is used only under that hypothesis; the corollary's non-vacuity is claimed at $n=4$ only; the dichotomy is general and proved generally. The one instance is item 6 in the claim table, *"never a genericity obstruction"*, correct in its italic scope and restated unscoped in [LEDGER.md](../findings/LEDGER.md) line 701.
- **A hypothesis stated but never used.** $W\in\mathcal W_n$ (H2), stated in A, B and D, used nowhere. The block admits it for the corollary only; it holds for the whole lemma.
- **A step using a hypothesis never stated.** $n\ge3$ (H4). And, more quietly, $A\in\mathrm{Sym}^2$ rather than $\mathrm{Sym}_0$ (H3), which is stated only in [results.md](../results.md) line 511 and is what makes the corollary's threshold $n$ rather than $n-1$.
- **A universal claim with no witness.** *"it is not vacuous, $\dim\ker\Phi_W=1<4$ at $n=4$"*. §6.
- **An imported theorem whose hypotheses were never checked.** Five imports: the spectral theorem (needs $A$ real symmetric, held, and it is what makes the frame orthonormal); uniqueness of binary representation (needs $i\ne j$, held); the commuting-operators fact (needs only linearity, held); the discriminant/symmetric-function fact (**not imported at all**, which is the §7 finding); and the Zariski dichotomy (needs an infinite field and a linear, hence irreducible, parameter space, both held). **None of them is an algebra theorem and none needs a unit**, so the failure mode the brief recalls (a cited theorem assuming a unital algebra where $\mathcal W_n$ has none), does not recur here. Nothing in L37 is an algebra statement about $\mathcal W_n$; the only products in sight are compositions of operators on $\Lambda^2$, where the identity is present and is in fact used (§8).
- **Symbol collisions in [conventions.md](../findings/conventions.md).** $\Phi$: four objects, and L37 takes sense (i), which the table records, **clean**. $A$: L37's general symmetric $A$ is not the $A=\lambda_1$ of the two-negative relaxation (row 39) nor the $A\in\mathrm{Sym}_0$ of row 37; **not tabled in L37's sense**. $\delta$: has no row of its own; it is defined only inside the $\Phi$ row, and the **same operator is tabled under the letter $D_A$ in row 37, on the smaller domain $\mathrm{Sym}_0$**, one object, two letters, two domains, and the domain is what fixes the corollary's threshold. $W$: uniform. **"Diagonal"**: row 66's binary sense is L37's and the block restates rather than quotes it; row 135's *"diagonality is MEASURED as off-diagonal Frobenius mass minimised over $O(n)$"* is a different, quantitative statistic, and §10 shows the record has used both instruments on the same objects, L37 is the binary one and cannot be read as the measurement.

## 12. What would falsify it, and what I did to look

**The object.** For $n\ge3$: a linear operator $W$ on $\Lambda^2\mathbb R^n$ that is diagonal in **no** orthonormal frame, together with an $A\in\ker\Phi_W$ whose sums $a_i+a_j$, $i<j$, are pairwise distinct. Its two weaker siblings would be a $W$ diagonal in some orthonormal frame with **every** $A\in\ker\Phi_W$ carrying a repeated sum (falsifying the forward direction), and a $W$ diagonal in some orthonormal frame with $\dim\ker\Phi_W<n$ (falsifying the corollary).

**What I did to look, all in closed form and with no computation.** I built the two objects most likely to break a diagonality criterion and pushed the criterion through both. $P_\omega$ at $n=4$ (§5): non-diagonal, $\dim\ker\Phi_W=7>n$ (so the corollary is silent and the equivalence is on its own) and I showed that **every** $A$ in that $7$-dimensional kernel has a repeated sum, because $\omega$ is a $\delta_A$-eigenvector and is not decomposable while a simple $\delta_A$-spectrum would force every eigenline to be decomposable. Zero-padded $W$ at general $(m,n)$ (§6): the kernel is pushed above the threshold, and the closed form matches three measured rows. $W_{\mathbb{CP}^2}$ at $n=4$ (§6): kernel exactly $\mathbb R\,\mathrm{Id}$, by Sylvester on the $\Lambda^\pm$ blocks. And I checked the two-parameter families inside $\ker\Phi_{P_\omega}$ by hand, the constraint $a_{11}+a_{22}=a_{33}+a_{44}$ forces the collision directly for diagonal members, and forces $r_1=r_2$ for the $a_{14}=a_{23}$ members, so the collision is structural in every case I could close.

**No falsifier exists, and the reason is stronger than the search.** §3's converse is a complete argument at $n\ge3$: distinct sums give a simple $\delta_A$-spectrum, a simple spectrum makes every eigenspace a line, and a commuting $W$ has each of those lines as an eigenline. There is no room for a counterexample above $n=3$, and §4 settles $n\le2$ separately.

## Verdict

**PROVEN, hypotheses corrected.**

The equivalence, the corollary, the decidability dichotomy, the quantifier and the frame-independence are all correct as mathematics, and three of the record's numerical kernel dimensions reproduce exactly from closed forms derived here. Four repairs are owed, none of which touches the truth of the statement:

1. **The range.** Add $n\ge3$ to the statements at [results.md](../results.md) lines 16, 160 and 511 and at [target.md](../findings/target.md) line 636, or add the one-line $n\le2$ case to the proof. As it stands a range lives in the proof and in no statement, and at $n=2$ the converse's first step is false while its conclusion is true.
2. **The polynomial.** Name the bridge, $D(A)=\mathop{\mathrm{disc}}(\chi_{\delta_A})$ is polynomial in $A$ because $\delta_A$ is linear in $A$ and the discriminant is polynomial in the coefficients, since the condition as written is in terms of eigenvalues, which are not polynomial in $A$.
3. **The witness.** Name the $W$ behind *"$\dim\ker\Phi_W=1<4$ at $n=4$"*. The record means $W_{\mathbb{CP}^2}$ and supports it with a float; §6 gives the closed form.
4. **The hypotheses.** Say $A\in\mathrm{Sym}^2$ in the proof block, not only in [results.md](../results.md); fix D's *"all $n$ diagonal matrices"* to A's *"an $n$-dimensional subspace"*; and extend *"needs neither criticality nor $W\in\mathcal W_n$"* from the corollary to the whole lemma, since $W\in\mathcal W_n$ is used nowhere.

And one item that is not L37's to repair: **the clause "carries no information about $\theta$" in [results.md](../results.md) line 511 is not proved by this block** and should be attributed to post F22, whose own record grades the stronger form OVERSTATED.
