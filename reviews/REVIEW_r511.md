# REVIEW r511, Lemma L33

**Target.** [Lemma L33](../findings/stratum-two-negative.md) ("one eigenvalue of one sign forces the tensor to vanish"), the block at `#### Lemma L33` in [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), read down to the next heading.

**VERDICT: CONFIRMED.** *The mathematics is right at every step, rebuilt from the definitions without reading the record's argument for the identity first. Three defects are in the statement and the surrounding prose, not in the proof: an ambiguous hypothesis that has a false reading with an explicit witness (D1), a false provenance sentence (D2), and an index row that contradicts the block (D3).*

Worked under the analysis-only footing. The one computation is a screen of objects I built for the purpose, reported as a screen; it is corroboration, never the ground of a positive claim.

---

## Conventions fixed first, against the record's own anchors

Inner product $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ on $\mathfrak{so}(m)\cong\Lambda^2$, the form [conventions.md](../findings/conventions.md) names as "the form the stratum arguments use". Under it $\{\varphi_{ab}\}_{a<b}$ is orthonormal and $\operatorname{tr}(v^2)=-2$ for a unit bivector, both as conventions.md states.

Two anchors computed by hand before anything else, with $\Phi(R):=\sum_\alpha\lambda_\alpha\operatorname{ad}(v_\alpha)^2$:

| anchor | derived | record |
| --- | --- | --- |
| $\sum_{a<b}\operatorname{ad}(\varphi_{ab})^2$ on $\mathfrak{so}(n)$ | $-2(n-2)\,\mathrm{Id}$ | $\kappa=2(n-2)$, [conventions.md](../findings/conventions.md) |
| $\Phi$ on $\Lambda^4\subset S^2(\Lambda^2\mathbb R^4)$, i.e. on $\star=\Pi_{SD}-\Pi_{ASD}$ | $-4\star$ | "$\Lambda^4$ … carries eigenvalue $-4$ rather than $+2$", L33's own block |

The second is the sharper check: $\mathfrak{su}(2)_\pm$ commute, so $\sum_{SD}\operatorname{ad}(v)^2=-4\,\Pi_{SD}$ and likewise for ASD, giving $\Phi(\star)=-4\Pi_{SD}+4\Pi_{ASD}=-4\star$. My normalisation therefore reproduces a number the block asserts and does not use, so a factor-of-two error would have shown up here.

---

## 1. "Exactly one eigenvalue of one sign", the reading, and a witness against the other one

**Which sign: either.** $\mathrm{Weyl}_m$ is a linear space, so $W\mapsto-W$ is an involution of the hypothesis; the proof's word "minority-side" is the right one and nothing turns on the sign. **Zero eigenvalues are of neither sign** and drop out of $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$, so they are harmless.

**Which multiplicity: simple, and only simple.** The proof's first move is *"Rescale so the identity reads $N_x=\sum_iN_{y_i}$, $x$ the minority-side eigenvector."* A **single** $N_x$ on the left is what makes $\ker N_x=\mathfrak z(x)\cap x^\perp=\mathfrak c$ and hands $\mathfrak c$ to [Lemma L32](../findings/isotropy-cap.md). At multiplicity $k\ge2$ the left side is $\sum_{j\le k}N_{x_j}$, whose kernel is $\bigcap_j\mathfrak c_j$, a *smaller* space, and L32 says nothing about $\mathfrak z$ of an intersection of centraliser-slices. So the proof uses the reading "the minority eigenvalue is simple", equivalently "the minority side of the spectrum is one-dimensional".

> ### D1, the statement's phrase has a second reading, and under it the Lemma is FALSE
>
> *"Let $W\in\mathrm{Weyl}_m$ have exactly one eigenvalue of one sign"* also parses as **one distinct eigenvalue value on one side**, at any multiplicity. Witness, in $\mathrm{Weyl}_4$: take $W^+=W^-=\operatorname{diag}(2,-1,-1)$ in the bases $w^\pm_1,w^\pm_2,w^\pm_3$ of $\Lambda^\pm$. Each block is trace-free symmetric on its own $\Lambda^\pm$, so $W\in\mathrm{Weyl}_4$; the spectrum is $(2,2,-1,-1,-1,-1)$, so **one** eigenvalue value $+2$ sits on the positive side. Its eigenspace $\operatorname{span}\{w_1^+,w_1^-\}$ contains $w_1^++w_1^-=\sqrt2\,\varphi_{12}$, of **rank $2$**, not a multiple of a complex structure on a $4$-dimensional subspace. And $W\ne0$.
>
> The singular *"that eigenvector"* in the next sentence does disambiguate (a multiplicity-$k$ eigenvalue has an eigenspace and no distinguished eigenvector) so the statement is defensible as written. It is still one word away from a false theorem, and the record has just been through [Lemma L46](../findings/problem.md) and [Lemma L11](../findings/nondegeneracy.md) for exactly this class of defect.
>
> **Repair, in the statement:** *"…have exactly one eigenvalue of one sign, counted with multiplicity"*, or *"…whose minority-side eigenspace is one-dimensional"*.
>
> **Corroboration that simple is the intended reading:** [isotropy-cap.md](../findings/isotropy-cap.md)'s Gate-2 note records the reviewers' convex certificate as $\exists W\in\mathrm{Weyl}_m$ with $G=W+\hat x\hat x^{\mathsf T}\succeq0$ and $G\hat x=0$. That program says exactly $W\hat x=-\lVert\hat x\rVert^2\hat x$ and $W\succeq0$ on $\hat x^\perp$, one negative eigenvalue, **simple**. So the certificate and the proof agree on the reading and only the prose is loose.

---

## 2. The Bianchi step, derived cold

The block's identity is $\Phi(W)=\sum_\alpha\lambda_\alpha\operatorname{ad}(v_\alpha)^2=2W$, equivalently $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$ with $N_v=2\,v\otimes v-\operatorname{ad}(v)^2$. **It is correct in this record's normalisation.**

- **$\Phi$ is $O(m)$-equivariant and self-adjoint** on $S^2(\Lambda^2)$: $\langle\Phi(R)u,u\rangle=\langle R,\operatorname{ad}(u)^2\rangle$, because $\operatorname{ad}(v)$ is skew-adjoint for the ad-invariant form. So $\Phi$ is a scalar on each of $\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathcal W_m\oplus\Lambda^4$, and the whole claim is one number on $\mathcal W_m$.
- **The Bianchi contraction.** For skew $\omega$ put $A_{ij}=\sum_{k,l}R_{ikjl}\omega_{kl}$. Its symmetric part vanishes identically by the pair symmetry and the skewness of $\omega$; its skew part is $\tfrac12(R_{ikjl}-R_{iljk})\omega_{kl}$, and **first Bianchi rearranges to $R_{ikjl}-R_{iljk}=R_{ijkl}$**, giving $A=\tfrac12R_{ijkl}\omega_{kl}=(R\omega)_{ij}$, the curvature operator itself. This is the load-bearing step and the block names it correctly.
- **The constant.** With $q(R)=-\Phi(R)$ and $q(R)\omega=\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric}-2\mathring R\omega$: Ricci-flatness kills the first two terms, the line above gives $\mathring R|_{\Lambda^2}=R$, hence $q(R)=-2R$ and $\Phi(W)=2W$. **Checked against the sphere**, which is not Ricci-flat and so tests the constants independently: $\mathrm{Ric}=(n-1)g$ and $\mathring R=\mathrm{Id}$ give $q=2(n-1)-2=2(n-2)$, matching the hand computation $\Phi(\mathrm{Id})=-2(n-2)\mathrm{Id}$ above.
- **The pairing is with the right object.** $\langle u,N_vu\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2$, so $N_v\succeq0$ with $\ker N_v=v^\perp\cap\mathfrak z(v)$, the block's line, correct. And $\sum_\alpha\lambda_\alpha N_{v_\alpha}=2W-2W=0$ is then bookkeeping.

*Independent corroboration found afterwards, not used to derive:* [references/petersen-wink-2019-bochner-technique/notes.md](../references/petersen-wink-2019-bochner-technique/notes.md) carries the same rearrangement $R_{ikjl}-R_{iljk}=R_{ijkl}$ and the same conclusion $q(R)=-2R$. The block's attribution, Besse §1.143 for $q(R)$, Petersen–Wink Prop. 1.6 for the eigenbasis rewriting and **not** the evaluation, matches what those notes say.

**One citation slip, downstream.** [stratum-two-negative.md](../findings/stratum-two-negative.md)'s later per-row balance calls $\sum_{\alpha\ne\beta}\lambda_\alpha\epsilon_{\alpha\beta}=0$ *"Lemma L33 evaluated at a single $v_\beta$"*. It is the **identity L33 runs on** evaluated at $v_\beta$, not L33; L33 is the vanishing statement. The mathematics of that consumer is right, $\langle v_\beta,(\sum_\alpha\lambda_\alpha N_{v_\alpha})v_\beta\rangle=0$ gives $2\lambda_\beta+\sum_\alpha\lambda_\alpha\lVert[v_\alpha,v_\beta]\rVert^2=0$, and $\sum_\alpha\lambda_\alpha=0$ with $\epsilon_{\beta\beta}=2$ turns it into exactly that line, so this is a naming fix, not a defect.

---

## 3. The exceptional case is real, and it is complete

**Realised.** $W_4(q,r)=-(q+r)\,w_1\otimes w_1+q\,w_2\otimes w_2+r\,w_3\otimes w_3$ with $q,r>0$ sits in $\mathrm{Sym}^2_0(\Lambda^+)\subset\mathrm{Weyl}_4$, is trace-free hence Bianchi-clean, has no $\Lambda^+\otimes\Lambda^-$ part hence is Ricci-flat, and has exactly one negative eigenvalue $-(q+r)$, **simple**. Its eigenvector $w_1$ is a unit self-dual $2$-form, so $w_1^2=-\tfrac12\mathrm{Id}$ and $\sqrt2\,w_1$ is a complex structure on $\mathbb R^4$. **Hypothesis satisfied, $W\ne0$: the exception is not empty.**

**Complete.** The exception L33 states is L32's, and I re-derived L32's classification rather than reading it off, splitting on $\ker x$:

| $x$ of rank $2p$, kernel $K$ of dim $k$ | $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ | why |
| --- | --- | --- |
| $k=0$, $p\ge3$ | $\mathbb Rx$ | no root of $D_p$ is proportional to a vector with no zero coordinate |
| $k=0$, $p=2$ | $\mathfrak{su}(2)$ **iff** $a\propto(1,1)$ | the only admissible root direction, the complex structure |
| $k\ge3$ | reduces to the support | $\mathfrak z(\mathfrak{so}(K))=\mathfrak{so}(V)$, cross terms killed by invertibility of $x|_V$ |
| $k=2$ | reduces to the support | $\mathfrak z(\varphi_K)=\mathfrak{so}(V)\oplus\mathbb R\varphi_K$, and $\varphi_K\in\mathfrak c$ so it is cut by $\mathfrak c^\perp$ |
| $k=1$, $p\ge2$ | $\mathbb Rx$ | $\mathfrak t\cap x^\perp$ has trivial common kernel, so no $V\to K$ cross term centralises $\mathfrak c$ |
| $k=1$, $p=1$ ($m=3$) | all of $\mathfrak{so}(3)$ | $\mathfrak c=0$, the witness that refuted L32 |

So the exception is exactly *"$x$ a multiple of a complex structure on a $4$-dimensional subspace"*, degenerate cases included, and L33's phrase says **subspace**, not "on $\mathbb R^4$", which is what makes it cover the padded rank-$4$ $J$ at $m=6,8,10$. **No second family.**

---

## 4. The use of Lemma L32 is within scope, and the $\mathfrak c\ne0$ discharge is sound

[L32](../findings/isotropy-cap.md) was refuted as stated on 2026-09-04 and repaired with the hypothesis $\mathfrak c\ne0$. L33's block discharges it inline. **The discharge holds, with one wording repair:**

- The block writes *"$\mathfrak z(x)$ contains the torus spanned by $x$'s own $2$-blocks, so $\dim\mathfrak z(x)\ge\lfloor n/2\rfloor$."* For **degenerate** $x$ that torus has dimension $p=\operatorname{rank}(x)/2<\lfloor n/2\rfloor$, so the sentence does not deliver its own bound. What does: **any maximal torus containing $x$ is abelian, hence inside $\mathfrak z(x)$, and has dimension $\lfloor n/2\rfloor$.** Then $\mathfrak c\supseteq\mathfrak t\cap x^\perp$ gives $\dim\mathfrak c\ge\lfloor n/2\rfloor-1$, vanishing only at $n\le3$, as the block says.
- **And $n\le3$ costs nothing here:** $\dim\mathcal W_m=m(m-3)(m+1)(m+2)/12$ is $0$ for $m\le3$, so $\mathrm{Weyl}_m=0$ and L33's conclusion holds vacuously exactly where the hypothesis could fail. **L33 is unconditional; L32's missing hypothesis never reaches it.** The block's own hedge ("*At $n\ge12$ the bound is at least $5$*"), is weaker than the truth and can be strengthened to "at every $m$ where $\mathrm{Weyl}_m\ne0$".
- L33 uses only the **weak** inclusion $\ker N_x\subseteq\bigcap_i\ker N_{y_i}$ and only L32's conclusion, no strengthening. The step from "the quadratic form vanishes" to "the kernel" is licensed by $N_v$ being self-adjoint and PSD, flagged as unstated in [isotropy-cap.md](../findings/isotropy-cap.md) and still unstated here, but true.

**The rest of the proof checks line by line.** $N_{cv}=c^2N_v$ licenses the rescaling; eigenvectors of a symmetric $W$ are mutually orthogonal so $y_i\perp x$ survives it; $y_i\in\mathbb Rx$ with $y_i\perp x$ gives $y_i=0$; and $W=\pm x\otimes x$ with $\mathrm{Ric}(W)(u,u)=\pm\lVert xu\rVert^2\equiv0$ forces $x=0$.

---

## 5. The "in particular" follows, and understates the Lemma

*"No rank-$3$ $\mathrm{Weyl}_m$ tensor at even $m\ge6$ has a nondegenerate minority-side eigenvector."*

| word | where it comes from | verdict |
| --- | --- | --- |
| **rank $3$** | $\operatorname{tr}W=0$ makes the signature $(2,1)$ or $(1,2)$, so the minority side is a **simple** eigenvalue, exactly the main hypothesis | forced, but see below |
| **nondegenerate** | $\ker x=0$, i.e. $x$ invertible, the sense L32's proof uses ("$p=m/2$ … singular values, all nonzero") | forced |
| **even $m$** | an odd-dimensional skew matrix is always singular, so nondegeneracy is possible only at even $m$ | forced (and odd $m$ is vacuously covered) |
| **$m\ge6$** | a complex structure on a $4$-dimensional subspace has rank $4$; at $m\ge6$ that is degenerate, so nondegeneracy **excludes the exception**. At $m=4$ it does not, $W_4(q,r)$ is the boundary case | forced, and sharp |

No extra input beyond the main statement. **But "rank $3$" is a needless weakening**: the main statement forbids *any* nonzero $W$ at even $m\ge6$ whose minority side is one simple eigenvalue with nondegenerate eigenvector, at any rank. [isotropy-cap.md](../findings/isotropy-cap.md)'s shorter account says exactly that (*"at any number of eigenvalues on the other side"*) so **the file that calls itself non-canonical carries the stronger statement**. The two should be reconciled in the canonical block's favour by adopting the stronger clause.

> ### D-word, "nondegenerate" is defined nowhere and collides with another sense in the record
>
> L33's sense is *full rank as a skew matrix*. [findings/nondegeneracy.md](../findings/nondegeneracy.md) uses "nondegenerate" throughout for **Morse–Bott** nondegeneracy of a critical point, an unrelated notion. Neither sense appears in [conventions.md](../findings/conventions.md), and its "words with more than one meaning" section does not list this pair, though it lists $B$, $M$ and $\mu$. The definition is recoverable only from L32's proof. **It belongs in conventions.md.**

---

## 6. The label and the provenance note

> ### D2, the provenance sentence is FALSE for this block
>
> The block opens: *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy."*
>
> At `a9e4b8c0~1`, the commit immediately before `a9e4b8c0 refactor(results): the proofs move to findings, results.md states and points`, **[findings/isotropy-cap.md](../findings/isotropy-cap.md) already carried a full account of L33**: the identity $\sum_\alpha\lambda_\alpha\operatorname{ad}(v_\alpha)^2=2W$ with the same $N_v$ (line 117), $N_v\succeq0$ and $\ker N_v=v^\perp\cap\mathfrak z(v)$ (lines 136–138), the statement under the heading "Lemma 33 (the answer to B0's recorded question, in the sharp form Reviewer 60 supplies)" (lines 158–160), and the $W_4(q,r)$ exception (line 174). So results.md was **not** the only copy. isotropy-cap.md itself still says so, at its own L33 pointer: *"what stood here was the shorter account."*
>
> **And the second clause is inaccurate too.** *"That file now carries the statement and points here."* [results.md](../results.md) carries the statement **plus two full paragraphs of the argument**, the whole "The identity the proof runs on" block and the whole "This is classical and is cited, not claimed" block, verbatim. That was already true at the move commit and is true today.
>
> This is the sentence the brief flags as standing in 38 blocks across eleven findings files. **For L33 it is false on both clauses.**

> ### D3, the index row contradicts the block it points at
>
> [findings/INDEX-results.md](../findings/INDEX-results.md) row 33 reads **"Gate 2: no verdict on the record."** The block says *"Gate 2 passed by both reviewers through an independent **convex** certificate rather than the centraliser argument"*, and [isotropy-cap.md](../findings/isotropy-cap.md) records that certificate in detail, infeasible at every multiplicity pattern and both signs at $m=6,8,10,12$, margins $-0.013$ to $-0.14$, with a feasible degenerate control. One of the two is wrong; the evidence in the record is on the block's side.
>
> The row's descriptive label ("one eigenvalue of one sign forces the tensor to vanish"), matches the block's heading exactly. **The Gate-2 clause is the whole of the discrepancy.**

---

## 7. Cross-file sweep

- **Nothing in `findings/` restates L33 with different hypotheses in a way that changes its truth.** The one variant, [isotropy-cap.md](../findings/isotropy-cap.md)'s "shorter account", is *stronger* (any rank, any number on the other side) and correct; see §5.
- **The later sections of [stratum-two-negative.md](../findings/stratum-two-negative.md) do not contradict it.** [Lemma L34](../findings/stratum-two-negative.md) exhibits $\mathrm{Weyl}_m$ elements with full support at $m=6,8$ built from **two** padded copies of $W_4(q,r)$, **two** negative eigenvalues, outside L33's hypothesis, and the block says so in as many words ("a statement stronger than Lemma L33 settles"). Its "Why the recorded equivalence fails" paragraph cites L33 correctly, at one positive eigenvalue where Ricci-flatness forces $U=\operatorname{im}v_1$.
- **The per-row balance at line 501 is consistent** and is a further independent check on the identity; see §2.
- **[LEDGER.md](../findings/LEDGER.md) already records** that L33 was "repaired rather than cleared" by the $\mathfrak c\ne0$ discharge. That record is accurate; §4 above finds the discharge sound and, in fact, stronger than stated.

---

## Screen (analysis-only: objects built for this purpose, seconds of compute, corroboration only)

Built $\Lambda^2\mathbb R^4$ in the orthonormal $\varphi_{ab}$ basis and computed $\Phi$ directly from the spectral decomposition. Every number below is a check on a claim derived above by hand, not a source for one.

| checked | result |
| --- | --- |
| $\Phi(\mathrm{Id})+2(n-2)\mathrm{Id}$ | $0$ exactly |
| $\Phi(\star)+4\star$ | $2.2\times10^{-15}$ |
| $W_4(0.7,0.3)$: $\lVert\Phi(W)-2W\rVert$, $\lVert\mathrm{Ric}\rVert$, $\langle W,\star\rangle$ | $7.2\times10^{-16}$, $2.5\times10^{-16}$, $9.3\times10^{-18}$ |
| $W_4(0.7,0.3)$ spectrum | $(-1,0,0,0,0.3,0.7)$, one negative, simple |
| D1's witness $W^+=W^-=\operatorname{diag}(2,-1,-1)$: Weyl conditions | $\lVert\Phi(W)-2W\rVert=0$, $\lVert\mathrm{Ric}\rVert=0$ |
| its spectrum, and the singular values of $\varphi_{12}$ in the $+2$ eigenspace | $(2,2,-1,-1,-1,-1)$; $(1,1,0,0)$, rank $2$, no complex structure |
| $\operatorname{spec}N_{\varphi_{12}}$ on $\Lambda^2\mathbb R^4$ | $(0,1,1,1,1,2)$, $\mathfrak c=\mathbb R\varphi_{34}$, one-dimensional, matching the hand computation |

---

## What to change

1. **D1 (statement).** Add *"counted with multiplicity"* to the hypothesis, or restate as *"whose minority-side eigenspace is one-dimensional"*. A witness for the other reading is in §1.
2. **D2 (provenance).** Delete or correct *"where the argument was the only copy"*, [findings/isotropy-cap.md](../findings/isotropy-cap.md) held a second copy at the move, and correct *"That file now carries the statement and points here"*, since results.md carries two paragraphs of the argument as well.
3. **D3 (index).** Reconcile [findings/INDEX-results.md](../findings/INDEX-results.md) row 33's "Gate 2: no verdict on the record" with the block's recorded Gate-2 pass.
4. **The $\mathfrak c\ne0$ discharge.** Replace "the torus spanned by $x$'s own $2$-blocks" with "any maximal torus containing $x$", the present wording fails for degenerate $x$, which is the case the discharge most needs. Then strengthen "*At $n\ge12$…*" to "*at every $m$ with $\mathrm{Weyl}_m\ne0$*", since $\mathrm{Weyl}_m=0$ for $m\le3$.
5. **"Nondegenerate."** Define it in [conventions.md](../findings/conventions.md) as full rank for a skew matrix, and table the collision with the Morse–Bott sense in [findings/nondegeneracy.md](../findings/nondegeneracy.md).
6. **The "in particular."** Adopt isotropy-cap.md's stronger clause (any rank, any number of eigenvalues on the majority side) so the canonical block is not weaker than the account it supersedes.
