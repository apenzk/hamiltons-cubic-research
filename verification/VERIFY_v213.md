# VERIFY_v213, L37, diagonality is decided by a single kernel

Verifier v213, cold reader on [BRIEF_L37.md](BRIEF_L37.md), sections A–D. **No numerical work of any kind was done**: no script, no Sage, no Python, no numeric evaluation. Every object below is exhibited in closed form and every spectrum is read off by hand. Log: [agent_logs/verify-L37-v213.log](../agent_logs/verify-L37-v213.log).

## Claim table

| # | claim, as written | verdict |
| --- | --- | --- |
| 1 | $\delta_A(X)=AX+XA$ preserves the skew matrices | **CORRECT**, uses $A$ symmetric |
| 2 | $\delta_A$ is the derivation extension $u\wedge v\mapsto Au\wedge v+u\wedge Av$ | **CORRECT**, uses $A$ symmetric, and the record's $\varphi_{ab}=E_{ab}-E_{ba}$ |
| 3 | $\delta_A\varphi_{ij}=(a_i+a_j)\varphi_{ij}$ in $A$'s eigenframe | **CORRECT** |
| 4 | $A=\sum_i2^if_if_i^{\mathsf T}$ has pairwise-distinct sums $2^i+2^j$ | **CORRECT**, the sums are over $i<j$, two set bits, pair recoverable |
| 5 | that $A$ lies in $\ker\Phi_W$ when $W$ is diagonal in $\{f_i\}$ | **CORRECT**, loosely worded ($A$ acts on $\mathbb R^n$, $W$ on $\Lambda^2$; what commutes is $\delta_A$ with $W$) |
| 6 | "the distinctness is achievable at every $n$ and is **never a genericity obstruction**" | **OVERREACHED**, true inside the forward paragraph, false as the standalone slogan it is bolded into, and already cited stripped in [lean/INDEX.md](../lean/INDEX.md) |
| 7 | pairwise-distinct sums force pairwise-distinct $a_i$, for $n\ge3$ | **CORRECT**, and $n\ge3$ is the exact threshold |
| 8 | "…**so** $\delta_A$ has simple spectrum on $\Lambda^2$" | **FALSE AS WRITTEN**, distinct $a_i$ do not give distinct sums; the simple spectrum is the hypothesis itself, not a consequence of the middle term |
| 9 | eigenlines $\mathbb R\varphi_{ij}$, and $[W,\delta_A]=0$ makes $W$ preserve each | **CORRECT** |
| 10 | preserving each line "is diagonality in $A$'s eigenframe" | **CORRECT**, a $1$-dimensional invariant subspace *is* an eigenvector; the frame is orthonormal by the spectral theorem |
| 11 | the range: no statement carries one, the proof carries $n\ge3$ | **DEFECT**, statements A/B/C are correct unrestricted; the *proof* is incomplete at $n\le2$ |
| 12 | a diagonal $W$ has all $n$ diagonal matrices in $\ker\Phi_W$, so $\dim\ker\Phi_W<n$ excludes diagonality | **CORRECT**, and the count $n$ requires the ambient to be $\mathrm{Sym}^2$, not $\mathrm{Sym}_0$ |
| 13 | "It needs neither criticality nor $W\in\mathcal W_n$" | **CORRECT, AND UNDERSTATED**, the whole equivalence needs neither; $W\in\mathcal W_n$ is an unused hypothesis in A and D |
| 14 | non-vacuity: "$\dim\ker\Phi_W=1<4$ at $n=4$" | **NO WITNESS ON FILE**, the block names no $W$; true, and I derive a closed-form witness below |
| 15 | the distinct-sums condition is the non-vanishing of a polynomial in $A$ | **TRUE, UNARGUED**, eigenvalues are not polynomial in $A$; the missing step is the discriminant of $\chi_{\delta_A}$ |
| 16 | vanishes identically on $\ker\Phi_W$ or is non-zero on a dense Zariski-open subset | **CORRECT** |
| 17 | "**decidable** without an $O(n)$ search" | **OVERSTATED**, what is proved is a zero-one dichotomy; no decision procedure is exhibited |
| 18 | $\mathrm{Id}\in\ker\Phi_W$ always, all sums equal, so the quantifier must be "some" | **CORRECT** |
| 19 | $\ker\Phi_{gWg^{-1}}=g(\ker\Phi_W)g^{-1}$ | **CORRECT**, needs $g\in O(n)$, which is unstated, and $g$ denotes two different operators in one identity |
| 20 | "carries no information about $\theta$" ([results.md:511](../results.md)) | **FALSE AGAINST THE RECORD'S OWN $\Theta_n$**, wording only |
| 21 | $\ker W\ne0$ and padded objects | **NO THREAT**, the proof is rank-free; padded $W_{\mathbb{CP}^2}$ tested by hand and the criterion passes |

**Verdict: `PROVEN, hypotheses corrected`.** The equivalence, the corollary, the quantifier remark and the frame-independence identity are all true, and I re-derived each cold. The written proof has one false implication in its converse chain, a range ($n\ge3$) that lives in the proof and in no statement, an unused hypothesis ($W\in\mathcal W_n$), an unstated one ($g\in O(n)$), an unargued polynomiality step, and a non-vacuity claim with no witness. None of these touches the truth of the lemma; all six are repairable in place, and four of the repairs are one line each.

## 0. Conventions, fixed once

Quoted from [findings/conventions.md](../findings/conventions.md), not restated.

> **"Diagonal" means diagonal in coordinate $2$-planes $e_i\wedge e_j$** of an orthonormal frame of $\mathbb R^n$, *not* diagonal as an operator on $\Lambda^2\mathbb R^n$. A generic spectral eigenbasis is essentially never of that form, and conflating the two is what makes the diagonal case look liftable.

Section A's gloss ("every $\varphi_{ij}=e_i\wedge e_j$ an eigenvector") and section D's ("diagonal on the coordinate $2$-planes of the frame") both agree with this. The block is read against the tabled meaning throughout.

> A bivector's norm, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing … which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal; $\lVert\varphi_{ab}\rVert^2=2$ under **plain Frobenius**, $\operatorname{tr}(X^{\mathsf T}X)$, for $\varphi_{ab}=E_{ab}-E_{ba}$.

So the identification of $\Lambda^2$ with skew matrices is $u\wedge v=uv^{\mathsf T}-vu^{\mathsf T}$, under which $e_i\wedge e_j=E_{ij}-E_{ji}=\varphi_{ij}$. This is the identification claim 2 needs and it is the record's.

> $\Phi$, **the letter carries four unrelated objects.** *(i)* $\Phi_W(A)=[W,\delta_A]$ with $\delta_A(X)=AX+XA$, the frame-independent diagonality test of L37, the sense every $\ker\Phi_W$ takes …

L37 is sense (i) throughout. No collision inside the block.

> $D_A$, $H_A$, for $A\in\mathrm{Sym}_0(\mathbb R^n)$, $D_A$ is the induced derivation on $\Lambda^2$ and $H_A=D_AW+WD_A$ the deformation it generates.

**This is the same map as L37's $\delta_A$, under a different letter and with a narrower tabled domain.** See §8.

## Hypothesis inventory

| # | hypothesis | stated where | used where |
| --- | --- | --- | --- |
| H1 | $A$ real symmetric | A, B, D | **three times**: skew-preservation; the derivation identity ($uv^{\mathsf T}A=u(Av)^{\mathsf T}$ needs $A=A^{\mathsf T}$); the orthonormal eigenframe |
| H2 | $A\in\ker\Phi_W$, i.e. $[W,\delta_A]=0$ | A, B, D | converse |
| H3 | the sums $a_i+a_j$ ($i<j$) pairwise distinct | A, B, D | converse, twice |
| H4 | $W$ diagonal in some orthonormal frame | A, B, D | forward |
| H5 | $W\in\mathcal W_n$ | A, D (**B omits it**) | **never** |
| H6 | $W$ symmetric on $\Lambda^2$ | implied by H5 only | **never** |
| H7 | criticality $Q(W)=\theta W$ | nowhere | nowhere, correctly disclaimed |
| H8 | $n\ge3$ | **nowhere** | converse |
| H9 | $g\in O(n)$ | **nowhere** | frame-independence identity |
| H10 | ambient of $\Phi_W$ is $\mathrm{Sym}^2$, not $\mathrm{Sym}_0$ | A ("$A\in\mathrm{Sym}^2(\mathbb R^n)$"), D ("symmetric"); **B omits it** | corollary's count $n$; $\mathrm{Id}\in\ker\Phi_W$ |
| H11 | $\ker W=0$, or any rank/spectral condition on $W$ | nowhere | **nowhere**, this is why padding is harmless |
| H12 | the distinct-sums condition is polynomial in $A$ | asserted in D | the Zariski dichotomy |

H5, H6: stated and never used. H8, H9, H12: used and never stated (H12 asserted without argument). Both failure modes the brief names are present, one instance each way.

## 1. The action, the three claims, derived separately

**(a) $\delta_A$ preserves the skew matrices.** For $X^{\mathsf T}=-X$ and $A^{\mathsf T}=A$,
$$(AX+XA)^{\mathsf T}=X^{\mathsf T}A^{\mathsf T}+A^{\mathsf T}X^{\mathsf T}=-XA-AX=-(AX+XA).$$
Skew. **Symmetry of $A$ is used**; for general $A$ the map does not preserve skewness.

**(b) $\delta_A$ is the derivation extension.** With $u\wedge v=uv^{\mathsf T}-vu^{\mathsf T}$,
$$\delta_A(uv^{\mathsf T}-vu^{\mathsf T})=Auv^{\mathsf T}+uv^{\mathsf T}A-Avu^{\mathsf T}-vu^{\mathsf T}A.$$
Now $v^{\mathsf T}A=(Av)^{\mathsf T}$ (again symmetry of $A$) so this is
$$\big[(Au)v^{\mathsf T}-v(Au)^{\mathsf T}\big]+\big[u(Av)^{\mathsf T}-(Av)u^{\mathsf T}\big]=Au\wedge v+u\wedge Av.$$
Correct.

**(c) The eigenvalue.** Let $\{f_i\}$ be an eigenframe, $Af_i=a_if_i$. By (b), $\delta_A(f_i\wedge f_j)=a_if_i\wedge f_j+a_jf_i\wedge f_j=(a_i+a_j)\varphi_{ij}$. Correct.

Two remarks the block does not make and does not need to: $A\mapsto\delta_A$ is **linear**, so $\ker\Phi_W$ is genuinely a linear subspace (which the decidability paragraph and the corollary both rely on); and $A\mapsto\delta_A$ is **injective** for $n\ge2$, since $\delta_A=0$ forces $a_i+a_j=0$ for all $i<j$, hence $a_i=a_j$ for $n\ge3$ and then $2a_1=0$.

## 2. The forward direction

**Distinctness of the sums, checked as stated.** The claim is about $2^i+2^j$ with $i<j$, sums of **two distinct** powers. Each such number has exactly two set bits, at positions $i$ and $j$, and by uniqueness of binary representation the unordered pair $\{i,j\}$ is recovered from the value. So the map $\{i,j\}\mapsto2^i+2^j$ is injective and the sums are pairwise distinct. **Correct as stated.** The claim would fail if the sums ranged over $i\le j$ ($2^i+2^i=2^{i+1}$, which is one set bit), but $\varphi_{ij}$ requires $i\ne j$, so the block's index range is the right one.

**Membership in $\ker\Phi_W$.** In the frame $\{f_i\}$ where $W$ is diagonal, both $W$ and $\delta_A$ are diagonal in the basis $\{\varphi_{ij}\}_{i<j}$ of $\Lambda^2$, $W$ by hypothesis H4, $\delta_A$ by §1(c). Diagonal operators in a common basis commute, so $[W,\delta_A]=0$. Correct. The block's phrasing, "$A$ commutes with $W$'s diagonal action", is loose: $A$ acts on $\mathbb R^n$ and $W$ on $\Lambda^2$, and what commutes is $\delta_A$ with $W$. Harmless, but it is the kind of elision that makes the $\mathrm{Sym}_0$ collision of §8 easy to walk into.

**"never a genericity obstruction", the conclusion does not survive being lifted out.** Inside the paragraph the claim is: *when $W$ is diagonal*, a distinct-sums witness exists in $\ker\Phi_W$ at every $n$. True, and that is what the construction gives.

Read as the standalone slogan it is bolded into, it says the distinct-sums condition never obstructs. **That is false**, and the falsifier is on this record. §5 derives that $\ker\Phi_{W_{\mathbb{CP}^2}}=\mathbb R\cdot\mathrm{Id}$ exactly, in which **no** $A$ has distinct sums (all sums equal $2$). At $W_{\mathbb{CP}^2}$ the distinctness is not merely an obstruction, it is the whole content of the criterion.

*Discrepancy protocol.* **Locate:** [findings/target.md:640](../findings/target.md), the bolded clause. **Exhibit:** $W_{\mathbb{CP}^2}$, closed form in §5. **Argue the opposite:** the sentence sits inside the paragraph opening "*If $W$ is diagonal in some frame $\{f_i\}$*", so a reader who keeps the scope is not misled. **The candidate survives**, because the stripping has already happened: [lean/INDEX.md:265](../lean/INDEX.md) records "**the distinctness is achievable at every `n`**, the sums `2ⁱ + 2ʲ` over `i < j` are pairwise distinct, so the criterion is never obstructed by genericity", with no diagonality hypothesis anywhere in the row. What is kernel-checked there is the arithmetic fact about $2^i+2^j$; the sentence appended to it is not that fact. **Repair:** scope the clause (*"so a diagonal $W$ always has a witness, at every $n$"*) and amend the Lean row to match.

## 3. The converse

**Distinct sums $\Rightarrow$ distinct $a_i$, and $n\ge3$ is exact.** Suppose $a_i=a_j$ with $i\ne j$ and $n\ge3$. Pick $k\notin\{i,j\}$. Then $\{i,k\}\ne\{j,k\}$ are distinct pairs with $a_i+a_k=a_j+a_k$, contradicting H3. So the $a_i$ are distinct. The step consumes a third index and therefore genuinely needs $n\ge3$; at $n=2$ there is exactly one pair, H3 is vacuous, and $A=\mathrm{Id}$ on $\mathbb R^2$ satisfies it with $a_1=a_2$. **The threshold is right.**

**The chain "distinct $a_i$, so simple spectrum" is a false implication.**

*Discrepancy protocol.* **Locate:** [findings/target.md:642](../findings/target.md), "*For $n\ge3$ that forces the $a_i$ themselves distinct, **so** $\delta_A$ has simple spectrum on $\Lambda^2$*". **Exhibit:** take $n=4$ and $A=\mathrm{diag}(0,1,2,3)$. The $a_i$ are pairwise distinct. The spectrum of $\delta_A$ on $\Lambda^2\mathbb R^4$ is $\{a_i+a_j\}_{i<j}=\{1,2,3,3,4,5\}$, with $a_1+a_4=a_2+a_3=3$. Not simple. So "distinct $a_i$" does not imply "simple spectrum", and the implication as written is false. **Argue the opposite:** the simple spectrum is immediate from the hypothesis rather than from the middle term, H3 *is* the statement that the multiset $\{a_i+a_j\}_{i<j}$, which by §1(c) is exactly $\operatorname{spec}(\delta_A)$ on $\Lambda^2$, has distinct entries. And distinct $a_i$ is not idle: it is what makes "**$A$'s eigenframe**" a well-defined frame (unique up to signs and permutation), so that the final clause names something. **The candidate survives as a defect in the written proof**, not in the lemma: a reader following the chain literally passes through a false step, and the two facts have been fused into one "so" that mis-attributes the reason for each.

**Repair, one sentence.** *"For $n\ge3$ that forces the $a_i$ themselves distinct, so $A$'s eigenframe $\{f_i\}$ is determined up to signs and order; and the hypothesis says precisely that $\operatorname{spec}(\delta_A)=\{a_i+a_j\}_{i<j}$ is simple, with eigenlines $\mathbb R\varphi_{ij}$."*

**Simple spectrum plus $[W,\delta_A]=0$ gives eigenvectors, not merely invariant lines.** The brief flags this step; it holds. If $\delta_Av=\lambda v$ and $W\delta_A=\delta_AW$ then $\delta_A(Wv)=W\delta_Av=\lambda Wv$, so $Wv\in E_\lambda(\delta_A)$. Simplicity gives $E_\lambda=\mathbb R v$, so $Wv=cv$ for some scalar $c$. **A one-dimensional invariant subspace is an eigenline in the strict sense**, "preserves the line" and "the line is spanned by an eigenvector" coincide exactly at dimension one, and the distinction the brief warns about would bite only at multiplicity $\ge2$, which simplicity excludes. Applying this to $v=\varphi_{ij}$ for every $i<j$: every $\varphi_{ij}$ of $A$'s eigenframe is an eigenvector of $W$.

*This candidate is **withdrawn**: located, but no failure can be exhibited, since the two notions are provably identical on a line.*

**Is $A$'s eigenframe orthonormal?** Yes, and this is required, because the tabled definition of "diagonal" quantifies over **orthonormal** frames. $A$ is real symmetric (H1), so the spectral theorem supplies an orthonormal eigenbasis; with the $a_i$ distinct, the eigenspaces are lines and any eigenframe is orthonormal automatically (eigenvectors for distinct eigenvalues of a symmetric matrix are orthogonal). **The step is implicit in the block and valid.** It is the third place H1 is consumed, which is worth noticing: dropping "symmetric" from L37 would break the lemma in three separate ways.

## 4. The range, what happens at $n=2$, and which statement is correct

**$n\ge3$ appears in the proof and in none of A, B, C, D's statement.** That is the pattern the brief names, and it is present.

**At $n=2$ the statement is true, and the proof does not reach it.**

- $\Lambda^2\mathbb R^2$ is one-dimensional, spanned by $\varphi_{12}=f_1\wedge f_2$ for **any** orthonormal frame $\{f_1,f_2\}$. Any linear $W$ maps this line to itself, so $W\varphi_{12}$ is a multiple of $\varphi_{12}$: **every $W$ is diagonal, in every orthonormal frame.** The left side is always true.
- There is exactly one pair $\{1,2\}$, hence one sum, hence "pairwise-distinct sums" is **vacuously satisfied by every $A$**; and $\mathrm{Id}\in\ker\Phi_W$, so a witness always exists. The right side is always true.
- So the equivalence holds at $n=2$, but *not for the reason the proof gives*. The converse's first step fails there, exactly as shown in §3.

**At $n=1$** both sides are vacuous ($\Lambda^2=0$; no pairs) and the equivalence again holds trivially.

**The corollary at $n\le2$ never fires**, consistently: at $n=2$ every operator on the one-dimensional $\Lambda^2$ commutes with everything, so $\ker\Phi_W=\mathrm{Sym}^2(\mathbb R^2)$ has dimension $3\ge2$, and $\dim\ker\Phi_W<n$ is unsatisfiable, which is what it must be, since no $W$ is non-diagonal there.

**Which statement is correct.** The **unrestricted statements A, B and C are correct**; adding "$n\ge3$" to them would be a false economy, since it would fence off two dimensions where the equivalence in fact holds. The **proof** is what carries the range, and it needs one added line: *"At $n\le2$ both sides hold for every $W$, $\Lambda^2\mathbb R^2$ is a line, so every $W$ is diagonal, and with a single pair the distinctness condition is vacuous. Assume $n\ge3$ from here."*

## 5. The corollary, and the non-vacuity witness

**The counting step.** Let $W$ be diagonal in an orthonormal frame $\{f_i\}$. For **any** $A$ diagonal in that same frame, $\delta_A$ is diagonal in $\{\varphi_{ij}\}$ by §1(c), $W$ is diagonal there by hypothesis, so $[W,\delta_A]=0$. The diagonal matrices in a fixed frame form a subspace of $\mathrm{Sym}^2(\mathbb R^n)$ of dimension exactly $n$, and $A\mapsto\delta_A$ being linear, this subspace sits inside $\ker\Phi_W$. Hence $\dim\ker\Phi_W\ge n$, and contrapositively $\dim\ker\Phi_W<n$ excludes diagonality. **Correct.**

**"It needs neither criticality nor $W\in\mathcal W_n$", correct, and understated.** Nothing in the counting step uses criticality, the first Bianchi identity, tracelessness, or even symmetry of $W$ as an operator on $\Lambda^2$; the argument runs for any $W\in\mathrm{End}(\Lambda^2\mathbb R^n)$. **The same is true of the whole equivalence**: §2 and §3 use only that $W$ is linear on $\Lambda^2$. So $W\in\mathcal W_n$ (H5) is an unused hypothesis in A and D, and the corollary's sentence, by disclaiming it only for the corollary, implies the equivalence needs it. Section B, which omits $W\in\mathcal W_n$, is the statement that is right; A and D fence more tightly than their own proof. *This is the brief's "hypothesis stated but never used", and it is also an inconsistency between three statements of one lemma.*

**The witness: the block names no $W$.** "$\dim\ker\Phi_W=1<4$ at $n=4$" is a bare number with no object attached. Following the record: the only support anywhere is post F22's **measured** table at [findings/target.md:478–482](../findings/target.md), which lists $\mathbb{CP}^2,\mathbb{CP}^3,\mathbb{CP}^4,\mathbb{CP}^5$ at $\dim\ker\Phi_W=1,1,1,1$. That table is three sections above the block, is not cited from it, and is numerics. **So the finding stands as: this claim has no argument and no named witness on file.**

**A closed-form witness exists, and I record the derivation as a suggested repair rather than as something the block contains.** All of it is by hand.

1. For **traceless** symmetric $A_0$ on $\mathbb R^4$, $\delta_{A_0}$ **anticommutes** with the Hodge star on $\Lambda^2\mathbb R^4$. Check on a generator: $A_0=\mathrm{diag}(1,-1,0,0)$ gives $\delta_{A_0}$ diagonal in $\{\varphi_{ij}\}$ with entries $\varphi_{12}\mapsto0$, $\varphi_{34}\mapsto0$, $\varphi_{13}\mapsto+1$, $\varphi_{24}\mapsto-1$, $\varphi_{14}\mapsto+1$, $\varphi_{23}\mapsto-1$. Since $\star$ pairs $(12,34)$, $(13,24)$, $(14,23)$, each $\star$-pair carries **opposite** $\delta_{A_0}$-eigenvalues, which is exactly $\star\delta_{A_0}=-\delta_{A_0}\star$. The general case follows by $SO(4)$-equivariance: $A_0\mapsto\delta_{A_0}$ is injective and equivariant, $\mathrm{Sym}_0(\mathbb R^4)$ is the irreducible $(\mathbf3,\mathbf3)$, and inside $\mathrm{Sym}(\Lambda^2)=\mathrm{Sym}^2(\mathbf3,\mathbf1)\oplus\mathrm{Sym}^2(\mathbf1,\mathbf3)\oplus(\mathbf3,\mathbf3)$ the only $(\mathbf3,\mathbf3)$ is the off-diagonal block $\Lambda^+\otimes\Lambda^-$, which is precisely the anticommuting part.
2. So in the splitting $\Lambda^2=\Lambda^+\oplus\Lambda^-$ we may write $\delta_{A_0}=\begin{pmatrix}0&B\\B^{\mathsf T}&0\end{pmatrix}$.
3. Let $W$ be **self-dual**: $W|_{\Lambda^+}=W^+$, $W|_{\Lambda^-}=0$. Then $[W,\delta_{A_0}]=\begin{pmatrix}0&W^+B\\-B^{\mathsf T}W^+&0\end{pmatrix}$, which vanishes iff $W^+B=0$.
4. If $W^+$ is **invertible** this forces $B=0$, i.e. $\delta_{A_0}=0$, i.e. $A_0=0$ by the injectivity in §1.
5. Splitting a general $A=\tfrac{\operatorname{tr}A}4\mathrm{Id}+A_0$ and using $\delta_{\mathrm{Id}}=2\,\mathrm{Id}_{\Lambda^2}$, we get $\ker\Phi_W=\mathbb R\cdot\mathrm{Id}$ exactly, so $\boxed{\dim\ker\Phi_W=1<4}$.

$W_{\mathbb{CP}^2}$ is of this shape, with $W^-=0$ and $W^+$ proportional to $\mathrm{diag}(2,-1,-1)$ (trace-free and invertible) and it lies in $\mathcal W_4$. So the corollary's non-vacuity holds **inside $\mathcal W_4$**, not merely among general operators, and the derivation agrees with the record's measured $1$ by a route that touches no numerics. *Note also what step 5 recovers independently: [findings/target.md:458](../findings/target.md)'s "$\dim\ker\Phi_W=1$ forces $\ker\Phi_W=\mathbb R\cdot\mathrm{Id}$ exactly".*

**A second witness, outside $\mathcal W_4$, worth recording because it separates the two claims.** Take $W=\star$ itself. It commutes with $SO(4)$, so $\ker\Phi_\star$ is an $SO(4)$-submodule of $\mathbb R\,\mathrm{Id}\oplus\mathrm{Sym}_0$; it contains $\mathrm{Id}$; and it excludes $\mathrm{diag}(1,-1,0,0)$ by step 1 above, so by irreducibility of $\mathrm{Sym}_0$ it is exactly $\mathbb R\,\mathrm{Id}$. But $\mathrm{Alt}(\star)=\star\ne0$ ([conventions.md](../findings/conventions.md): "*inside $\Lambda^2\mathbb R^4$, $\Lambda^4$ is one-dimensional and $\mathrm{Alt}$ is the projection onto the Hodge star*"), so $\star$ violates the first Bianchi identity and $\star\notin\mathcal W_4$. **This is the witness for "needs neither criticality nor $W\in\mathcal W_n$"; the $\mathbb{CP}^2$ one is the witness for non-vacuity where the lemma is used.** The block asserts both with one number.

## 6. Decidability

**Is the condition polynomial in $A$?** The brief's objection is right that the eigenvalues $a_i$ are not polynomial functions of $A$'s entries, and the block supplies nothing in their place. The claim is nonetheless **true**, by a step the block omits:

- $\delta_A$ depends **linearly** on $A$, so the coefficients of $\chi_{\delta_A}$, the characteristic polynomial of $\delta_A$ acting on $\Lambda^2$, are polynomials in the entries of $A$.
- $\Delta(A):=\operatorname{disc}\big(\chi_{\delta_A}\big)=\prod_{\alpha<\beta}(\lambda_\alpha-\lambda_\beta)^2$ is a universal polynomial in those coefficients, hence a polynomial in $A$ (of degree $N(N-1)$ with $N=\binom n2$).
- By §1(c), $\operatorname{spec}(\delta_A)=\{a_i+a_j\}_{i<j}$, so $\Delta(A)\ne0$ **iff** the sums are pairwise distinct.

The naive object (the product $\prod(s_{ij}-s_{kl})$ over unordered pairs-of-pairs), is only defined up to sign, since permuting the $a_i$ permutes the factors; taking the square, i.e. the discriminant, is what makes it a symmetric function and hence a polynomial in $A$. **The claim is correct; the argument is missing and is three lines.** Record as a debt, not a break.

**The dichotomy.** $\ker\Phi_W$ is a linear subspace $V\subseteq\mathrm{Sym}^2(\mathbb R^n)$, hence an irreducible affine variety. A polynomial restricted to $V$ either vanishes identically on $V$ or its non-vanishing locus is a non-empty Zariski-open, hence Zariski-dense, subset of $V$; over $\mathbb R$ that locus contains real points, since a non-zero polynomial on $\mathbb R^m$ cannot vanish on all of $\mathbb R^m$. **Correct as stated.** Combined with the equivalence this is a genuine zero-one law: *either no $A\in\ker\Phi_W$ has distinct sums (and $W$ is non-diagonal), or almost every one does (and $W$ is diagonal).* That is a real strengthening over the corollary and it does hold at $\dim\ker\Phi_W=n$, as claimed.

**What decidability actually follows, less than the word suggests.** What is proved is the dichotomy. A *decision procedure* is not exhibited: certifying the "vanishes identically" branch requires symbolically evaluating $\Delta$ on a parametrisation of $V$, or evaluating at enough points to conclude, and the block gives neither. The sentence "**This is what makes the residual statement decidable without an $O(n)$ search**" is true in the sense it plainly means (the search over the orthogonal group is replaced by a condition on one linear subspace) and I read "$O(n)$" here as the group rather than a complexity class. **Recommended wording:** *"…so the criterion is generic-or-never on $\ker\Phi_W$, and no frame search is involved."*

*I note without endorsing it that [findings/bounds.md:171](../findings/bounds.md) already cites this clause as load-bearing ("$\dim\ker\Phi_W=8=n$ leaves Lemma L37's **corollary** silent), **its equivalence is not**, the distinct-sums condition being decidable on $\ker\Phi_W$ at any dimension". The dichotomy supports that citation; the word "decidable" is doing more work there than the block proves.*

## 7. The quantifier and frame-independence

**$\mathrm{Id}\in\ker\Phi_W$ always.** $\delta_{\mathrm{Id}}(X)=X+X=2X$, so $\delta_{\mathrm{Id}}=2\,\mathrm{Id}_{\Lambda^2}$, which commutes with every $W$. Its sums are all $2$, maximally non-distinct. So a criterion reading "**all** $A\in\ker\Phi_W$ have distinct sums" would be unsatisfiable for every $W$, and the "some" is forced. **Correct, and this also pins $\dim\ker\Phi_W\ge1$ always, which is what makes "$=1$" the extreme value in §5.**

**Frame-independence.** The identity is correct, with two things left unsaid.

Derivation. For $g\in O(n)$ and $A$ symmetric, $gAg^{-1}=gAg^{\mathsf T}$ is symmetric, and
$$(\Lambda^2g)\,\delta_A\,(\Lambda^2g)^{-1}(u\wedge v)=(\Lambda^2g)\big(Ag^{-1}u\wedge g^{-1}v+g^{-1}u\wedge Ag^{-1}v\big)=gAg^{-1}u\wedge v+u\wedge gAg^{-1}v,$$
so $\delta_{gAg^{-1}}=(\Lambda^2g)\,\delta_A\,(\Lambda^2g)^{-1}$. Hence
$$\Phi_{(\Lambda^2g)W(\Lambda^2g)^{-1}}(gAg^{-1})=(\Lambda^2g)\,[W,\delta_A]\,(\Lambda^2g)^{-1},$$
which vanishes iff $[W,\delta_A]=0$. So $\ker\Phi_{gWg^{-1}}=g(\ker\Phi_W)g^{-1}$. And $\operatorname{spec}(gAg^{-1})=\operatorname{spec}(A)$, so the distinct-sums clause transports too, as does the dimension since conjugation is a linear isomorphism. **Correct.**

Unsaid, and both worth fixing:

- **$g$ denotes two different operators in one identity.** On the right it is the $n\times n$ matrix acting on $A$; on the left, inside $gWg^{-1}$, it must be $\Lambda^2g$, since $W$ lives on $\Lambda^2$. The identity is only readable if the reader supplies that.
- **$g\in O(n)$ is required and is nowhere stated.** For general $g\in GL_n$, $gAg^{-1}$ need not be symmetric, so $\delta_{gAg^{-1}}$ falls outside the definition, and "orthonormal frame" would not transport either. The right group is exactly the one the frame-independence claim is about, so this is a stated-hypothesis omission rather than an error.

## 8. Symbol collisions, checked against conventions.md

- **$\delta_A$ *is* $D_A$.** [conventions.md:37](../findings/conventions.md) tables "$D_A$ is the induced derivation on $\Lambda^2$" **for $A\in\mathrm{Sym}_0(\mathbb R^n)$**; L37 calls the identical map $\delta_A$ **for $A$ symmetric**. One object, two letters, two different tabled domains. **The domain difference is arithmetically live**: read on $\mathrm{Sym}_0$, the diagonal traceless matrices span $n-1$ dimensions, so the corollary's threshold would be $n-1$ rather than $n$, and the quantifier paragraph's "$\mathrm{Id}\in\ker\Phi_W$ always" would be a statement about a matrix outside the domain. A and D say "symmetric" and not "traceless", so L37 is internally unambiguous, but section B's landscape statement gives neither the ambient space nor the tracefulness, and it is the statement a consumer is most likely to quote. **Recommend tabling $\delta_A$ under its own row, identifying it with $D_A$, and stating the ambient as $\mathrm{Sym}^2$ in section B.**
- **$A$.** [conventions.md:21](../findings/conventions.md) uses $A$ as a variable ranging over $\mathcal W_n$ ("$M(n)=\max\{P(A):\lVert A\rVert=1\}$"), and [conventions.md:39](../findings/conventions.md) tables $A=\lambda_1$ in the two-negative relaxation. L37's $A$ is a symmetric $n\times n$ matrix. Three live senses; L37's is not among the tabled ones. **Recommend adding it.**
- **$\Phi$.** L37 is sense (i) throughout, correctly, and the block never strays. No defect.
- **"diagonal".** Read against the tabled meaning in §0; A, D and the corollary all use it consistently, and none of them slips into "diagonal as an operator on $\Lambda^2$". **No defect**, which is worth saying explicitly, since this is the collision the conventions file warns about most sharply.
- **$\theta$.** §9 below.

## 9. "Carries no information about $\theta$"

Section A alone adds: "*The test is frame-independent, necessary and sufficient, and carries no information about $\theta$*".

*Discrepancy protocol.* **Locate:** [results.md:511](../results.md); the phrase descends from post F22's heading at [findings/target.md:474](../findings/target.md). **Exhibit:** on this record $\Theta_n$ is defined ([conventions.md:19](../findings/conventions.md)) as **the diagonal maximum**. So the output "$W$ is diagonal" yields $\theta(W)\le\Theta_n$, which is information about $\theta$, and it is information the record uses, since Observation L40 excludes $S^5\times S^7$ at $\theta=1.228239$ on exactly this ground. The very next sentence of A, "*It is the criterion by which Observation L40 separates the two sides of the critical set*", is hard to reconcile with a criterion that carries no information about $\theta$. **Argue the opposite:** F22's body says the accurate thing, "$\dim\ker\Phi_W=1$ is the **generic** value … So the invariant separates diagonal from non-diagonal cleanly and separates nothing else", i.e. *the kernel dimension does not track $\theta$*, and *the test does not require knowing $\theta$*. Both are true. **The candidate survives as a wording defect confined to A**, where a heading's compression has been promoted into a canonical statement. **Repair:** "*and involves $\theta$ nowhere*", or "*and its kernel dimension does not track $\theta$*".

## 10. The traps, answered by name

| trap | finding |
| --- | --- |
| $\ker W\ne0$ | **No contact.** The proof nowhere touches $W$'s rank, spectrum, symmetry or invertibility; H11 is unused throughout. A kernel in $W$ cannot reach any step. |
| **padded objects, a padded $W$ constructed** | **Constructed, and the criterion passes.** Take $n=5$ and $W=W_{\mathbb{CP}^2}\oplus0$ on $\Lambda^2\mathbb R^5=\Lambda^2\mathbb R^4\oplus(\mathbb R^4\wedge e_5)$. Then $A=e_5e_5^{\mathsf T}$ lies in $\ker\Phi_W$, $\delta_A$ is $0$ on $\Lambda^2\mathbb R^4$ and $1$ on the $e_5$ block, scalar on each $W$-invariant summand, so it commutes with $W$, and its sums are $a_i+a_j=0$ for $i,j\le4$, **repeated**, so it does not falsely certify diagonality. That is the correct behaviour: padded $W_{\mathbb{CP}^2}$ is genuinely non-diagonal, because the Kähler form is a **simple** eigenvector of rank $4$ while a diagonal $W$'s simple eigenvectors must be the rank-$2$ decomposables $\varphi_{ij}$, the same certificate the record records at [findings/target.md:510](../findings/target.md) and [findings/bounds.md:171](../findings/bounds.md). The equivalence therefore *requires* that no $A$ in that kernel has distinct sums, and the natural candidates do not. **The record's own warning that "implementing only the dimension corollary … wrongly called padded $W_{\mathbb{CP}^2}$ diagonal" is consistent with the lemma**: at padded $\mathbb{CP}^2$, $n=8$, $\dim\ker\Phi_W=11\ge n$, so the corollary is silent and the equivalence, not the corollary, is what decides. |
| $n=2$ | **Defect found.** §4: the statement is true, the proof does not reach it. |
| $n=3$ | **The threshold is exact.** §3: the third index is what the argument consumes. |
| $n=4$ | **Defect found.** §5: the non-vacuity witness is unnamed; a closed-form witness exists and is supplied as a repair, not as a finding of the block. |
| crossover $n=6+2\sqrt7$ | **No contact.** L37 has no numeric threshold, no norm inequality, and no $n$-dependence beyond $n\ge3$. Nothing in the block can meet it. |
| a claim proven on a subfamily, used in general | **Found:** "never a genericity obstruction", §2, proved for diagonal $W$, bolded as a general slogan, and already cited stripped of its hypothesis in [lean/INDEX.md](../lean/INDEX.md). |
| a hypothesis stated but never used | **Found:** $W\in\mathcal W_n$ (H5) and, through it, symmetry of $W$ (H6). §5. |
| a step using a hypothesis never stated | **Found, twice:** $n\ge3$ (H8, §3–4) and $g\in O(n)$ (H9, §7). A third, the orthonormality of $A$'s eigenframe, is implicit but **valid**, since it follows from the stated symmetry of $A$. |
| a universal claim with no witness | **Found:** "$\dim\ker\Phi_W=1<4$ at $n=4$", §5, a non-vacuity claim whose only support anywhere on the record is a measured table in a different section. |
| an imported theorem with unchecked hypotheses | **None.** The imports are the spectral theorem for real symmetric matrices (H1 satisfied), the fact that operators commuting with a simple-spectrum operator preserve its eigenlines (§3, derived in place), uniqueness of binary representation (§2), and the Zariski dichotomy on an irreducible affine variety (§6, whose hypothesis (that $\ker\Phi_W$ is a linear subspace), holds because $A\mapsto\delta_A$ and $\Phi_W$ are linear). **No unital-algebra import**, and nothing requiring $\mathcal W_n$ to carry a product; the route that died on that failure has no analogue here. |
| symbol collisions in conventions.md | **§8.** $\delta_A$ against the tabled $D_A$ is real and its domains differ; $A$ has three live senses and L37's is untabled; $\Phi$ and "diagonal" are used in their tabled senses without slippage. |

## 11. What would falsify the statement, and what I did to look for it

**The object that would break it:** a linear $W$ on $\Lambda^2\mathbb R^n$, non-diagonal in every orthonormal frame, together with a symmetric $A$ such that $[W,\delta_A]=0$ and the sums $a_i+a_j$ ($i<j$) are pairwise distinct. Equivalently (since the sums are $\operatorname{spec}(\delta_A)$), an operator commuting with a **simple-spectrum** derivation $\delta_A$ while failing to be diagonal in $A$'s eigenframe.

**What I did to look for it.** No search, per the standing rule; the hunt was structural.

- I checked the one place it could hide: **multiplicity**. The converse's conclusion is forced the moment $\delta_A$'s spectrum on $\Lambda^2$ is simple, and simplicity is the hypothesis verbatim. A falsifier would need $\delta_A$ to have a repeated eigenvalue, which contradicts the hypothesis, or would need commutation to fail to preserve eigenspaces, which is false for any pair of commuting operators. **There is no room.**
- I checked whether **distinct $a_i$** could be slipped in for distinct sums, since that is the block's own middle term and would leave room: it does, and $A=\mathrm{diag}(0,1,2,3)$ at $n=4$ (§3) is the object that exploits it. It falsifies the written implication, **not** the lemma, since the lemma hypothesises the sums.
- I checked the **boundary**, $n\le2$, where the converse's first step genuinely fails: the statement survives there for an independent reason (§4).
- I checked a **padded** object by hand, $W_{\mathbb{CP}^2}\oplus0$, since padding is where this record's diagonality claims have failed before, and both the natural kernel element and the record's own rank-$4$ certificate line up with the criterion rather than against it (§10).
- I checked a **large-kernel** object, the case the corollary cannot see: at padded $\mathbb{CP}^2$ the kernel has dimension $11>n=8$ and the equivalence still returns non-diagonal, which is the configuration in which a falsifier would be least conspicuous.

**None was found, and the structure of the converse says none exists.** The lemma is true as stated in A, B and C, at every $n\ge1$.

## Verdict

**`PROVEN, hypotheses corrected`.**

The equivalence, the corollary, the quantifier remark and the frame-independence identity are all true; I derived every one of them cold, and the two directions close. Six corrections are owed to the written record, none of them touching the truth of the lemma:

1. **[findings/target.md:642](../findings/target.md)**, the converse's "distinct $a_i$, **so** simple spectrum" is a false implication, refuted by $A=\mathrm{diag}(0,1,2,3)$; the simple spectrum is the hypothesis itself. One-sentence repair in §3.
2. **The range**, add the $n\le2$ line to the proof; leave A, B and C unrestricted, since the equivalence holds there.
3. **[findings/target.md:640](../findings/target.md)**, scope "never a genericity obstruction" to the diagonal case, and amend the [lean/INDEX.md](../lean/INDEX.md) row that already carries it unscoped.
4. **[findings/target.md:644](../findings/target.md)**, name the non-vacuity witness. $W_{\mathbb{CP}^2}$ works, and §5 supplies a three-step closed-form derivation of $\ker\Phi_W=\mathbb R\,\mathrm{Id}$ for any self-dual $W$ with $W^+$ invertible; the Hodge star $\star$ is the separate witness for the "$W\notin\mathcal W_n$" half.
5. **[findings/target.md:646](../findings/target.md)**, supply the polynomiality step ($\operatorname{disc}\chi_{\delta_A}$, $\delta_A$ linear in $A$); soften "decidable" to the zero-one dichotomy that is actually proved.
6. **Hypotheses**, drop the unused $W\in\mathcal W_n$ from A and D (or say it is not needed for either direction); state $g\in O(n)$ in the frame-independence identity; state the ambient $\mathrm{Sym}^2$ in B; and fix "carries no information about $\theta$" in A. Table $\delta_A$ in [conventions.md](../findings/conventions.md), identified with $D_A$ and with its wider domain.
