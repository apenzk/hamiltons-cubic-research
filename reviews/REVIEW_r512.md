# Review r512, Lemma L33

**Target.** [Lemma L33](../findings/stratum-two-negative.md), "one eigenvalue of one sign forces the tensor to vanish", at the `#### Lemma L33` heading (line 118 of [findings/stratum-two-negative.md](../findings/stratum-two-negative.md)) down to the next heading.

**VERDICT: CONFIRMED.** Every step of the proof re-derived cold and holds. The identity is right, including its sign and its constant. The stated exception is both realised and complete, I derived the completeness independently, including the degenerate case that [Lemma L32](../findings/isotropy-cap.md) disposes of in one sentence. The "in particular" follows, and all three of its qualifiers are forced. Four record defects are named below; none touches the mathematics, and one of them is a **false provenance sentence**.

**Analysis-only footing.** No searches, sweeps, censuses or falsifier hunts were run. Nothing below rests on computation: every check is by hand.

---

## 0. Calibration, before deriving anything

Three anchors fixed first, per the brief.

| anchor | check | result |
| --- | --- | --- |
| $\theta_0(6)=\sqrt{10}/3$ | $\theta_0(n)^2=2(n-1)(n-2)/n^2=40/36=10/9$ | ✓ |
| $\operatorname{tr}W^\#=-\lVert W\rVert^2$ | falls out of L33's own identity contracted twice (§3) | ✓ |
| the pair cap saturating on $\Lambda^+$ | $[w_1,w_2]=-\sqrt2\,w_3$, so $\lVert[w_1,w_2]\rVert^2=2$ | ✓ |

The working normalisation is the one [conventions.md](../findings/conventions.md) states for skew matrices, $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, under which $\{\varphi_{ij}\}_{i<j}$ is orthonormal. *Note in passing that [conventions.md](../findings/conventions.md) also carries "$\lVert\varphi_{ab}\rVert^2=2$" three bullets later; the two are inconsistent and only the first reproduces the pair cap.* The constant $2$ in $N_v$ is tied to the first; the argument is insensitive to it (§3).

---

## 1. "Exactly one eigenvalue of one sign", pinned down

**The proof needs a one-dimensional minority eigenspace, not one distinct eigenvalue.** The rescaling step "$N_x=\sum_iN_{y_i}$, $x$ the minority-side eigenvector" puts a **single** term on the left. With a minority eigenvalue of multiplicity $\ge2$ the left side is $N_{x_1}+N_{x_2}$, its kernel is $\mathfrak c_1\cap\mathfrak c_2$, and $\mathfrak z(\mathfrak c_1\cap\mathfrak c_2)$ is far larger than $\mathbb Rx$, the argument does not survive.

**The file's own convention makes the statement correct.** [stratum-two-negative.md](../findings/stratum-two-negative.md) counts eigenvalues *with* multiplicity throughout: [Lemma L29](../findings/stratum-two-negative.md) says "exactly one positive and two negative eigenvalues, $\lambda_1>0>-a\ge-b$", where the $\ge$ admits $a=b$; and [Lemma L34](../findings/stratum-two-negative.md) calls its $m=8$ witness, whose spectrum is $\{-1/\sqrt3\,(\times2),\,1/(2\sqrt3)\,(\times4)\}$, an element with "exactly two negative eigenvalues". So "exactly one" reads as multiplicity one, which is exactly what the proof uses. **The proof uses the reading the statement makes.**

> **DEFECT 1, the phrase is false under its other reading, and the witness is 240 lines below it in its own file.** Take two copies of $W_4(q,q)$ padded onto **orthogonal** $4$-planes of $\mathbb R^8$ and add, [Lemma L34](../findings/stratum-two-negative.md)'s own construction. The negative eigenvalue $-2q$ occurs once per summand, so there is exactly **one distinct** negative eigenvalue; its eigenspace is the $2$-plane spanned by the two summands' self-dual generators $x_1,x_2$, and a generic $\alpha x_1+\beta x_2$ is block-diagonal with two invertible $4$-blocks, hence **nondegenerate on $\mathbb R^8$** and no complex structure on a $4$-dimensional subspace. And $W\ne0$. *This costs nothing inside the file, where the convention is fixed. It costs something outside it*: L33's statement is quoted verbatim in [results.md:152](../results.md) and [results.md:436](../results.md) and reaches [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex), where the file's counting convention does not travel with it. **Repair: "whose eigenspace of one sign is one-dimensional", or "exactly one eigenvalue, counted with multiplicity, of one sign".**

**Sign is not a hypothesis.** Both signs give the same equation after moving the minority term to the left, and the pre-move copy said so explicitly ("Signature $(1,2)$ and signature $(2,1)$ are one statement, not two, since $\mathrm{Weyl}_m$ is a linear space and $W\mapsto-W$ exchanges them"). That sentence did not survive the move; it is worth restoring, since the canonical block leaves "of one sign" unexplained.

---

## 2. The exception, realised, and complete

**Realised.** $W_4(q,r)=-(q+r)w_1\otimes w_1+q\,w_2\otimes w_2+r\,w_3\otimes w_3$ with $\{w_i\}$ orthonormal in $\Lambda^+\mathbb R^4$: the trace on $\Lambda^+$ is $0$, so it lies in $S^2_0(\Lambda^+)\subset\mathrm{Weyl}_4$; signature $(2,1)$; the single negative eigenvector $w_1$ is a unit self-dual form, hence a complex structure; and $W\ne0$. Checked directly. ✓

**Complete, I derived this rather than taking it.** The exception is whatever makes $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\ne\mathbb Rx$ for $\mathfrak c=\mathfrak z(x)\cap x^\perp$. Write $V=\operatorname{supp}x$ of dimension $2k$, $D=\ker x$ of dimension $d$, so $\mathfrak{so}(m)=\mathfrak{so}(V)\oplus\mathfrak{so}(D)\oplus(V\otimes D)$.

- $\operatorname{ad}(x)$ acts on $V\otimes D$ as $x|_V\otimes1$, which is injective, so $\mathfrak z(x)=\mathfrak z_{\mathfrak{so}(V)}(x|_V)\oplus\mathfrak{so}(D)$ and $\mathfrak c=\mathfrak c_V\oplus\mathfrak{so}(D)$ with $\mathfrak c_V=\mathfrak z_{\mathfrak{so}(V)}(x)\cap x^\perp$.
- **$d\ge2$.** $\mathfrak{so}(D)\subseteq\mathfrak c$, and $\mathfrak{so}(d)$ has no invariants in $\mathfrak{so}(D)$'s adjoint (for $d\ge3$) nor in the $\dim V$ copies of its vector representation carried by $V\otimes D$ (for $d\ge2$). For $d=2$ the surviving $\mathbb Rz=\mathfrak{so}(D)$ lies in $\mathfrak c$ and is deleted by $\mathfrak c^\perp$. Either way $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\subseteq\mathfrak{so}(V)$ and the question reduces to the nondegenerate one on $V$.
- **$d=1$.** $\mathfrak{so}(D)=0$, so the $V\otimes D\cong V$ block is live. Its $\mathfrak c$-invariants are the common kernel in $V$ of $\mathfrak t\cap x^\perp$, and a block $i$ survives only if $e_i\perp(a^\perp)$, i.e. $e_i\propto a$, impossible for $k\ge2$ since every $a_j\ne0$. **Empty.** ($k=1,d=1$ is $m=3$, the $\mathfrak{so}(3)$ witness that refuted L32, excluded by $\mathfrak c\ne0$.)
- **Inside $V$.** [Lemma L32](../findings/isotropy-cap.md)'s root argument applies with $p=k$: $\mathfrak z(\mathfrak c_V)\subseteq\mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}$, and a $D_k$ root has $k-2$ zero coordinates while $a$ has none, so the only escape is $k=2$ with $a\propto(1,\pm1)$.

**So the failure locus is exactly $\operatorname{rank}x=4$ with equal singular values, a multiple of a complex structure on a $4$-dimensional subspace, and nothing else.** The stated exception is neither empty nor incomplete. Spot-check at $m=6$, $x$ a complex structure on a $4$-plane $U$: $\mathfrak c=\Lambda^-(U)\oplus\mathfrak{so}(U^\perp)$ and $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\Lambda^+(U)$, dimension $3$. ✓ Matches L32's "$3$-dimensional $\mathfrak{su}(2)$".

---

## 3. The Bianchi step, derived cold

The block's identity is $\sum_\alpha\lambda_\alpha\operatorname{ad}(v_\alpha)^2=2W$. Deriving it:

**Where first Bianchi enters.** For skew $\omega$, the Bianchi identity $R_{ikjl}=R_{ijkl}+R_{iljk}$ contracted against $\omega_{kl}$, with the second term relabelled $k\leftrightarrow l$, gives $2R_{ikjl}\omega_{kl}=R_{ijkl}\omega_{kl}$, i.e.

$$\mathring R\,\omega=W\omega\quad\text{on }\Lambda^2 .$$

*This is the whole of the load-bearing content the block claims for first Bianchi*, and it is exactly the contraction the block names ("the term $\operatorname{tr}(u^2v_\alpha^2)$"): the Ricci terms of $q(R)\omega=\operatorname{Ric}\omega+\omega\operatorname{Ric}-2\mathring R\omega$, paired against $u$, give $\sum_\alpha\lambda_\alpha\operatorname{tr}(u^2v_\alpha^2)$ via $\operatorname{Ric}=-\sum_\alpha\lambda_\alpha v_\alpha^2$ and $\operatorname{tr}(uv^2u)=\operatorname{tr}(u^2v^2)$. Ricci-flatness kills the *weighted sum*, not each term, the block's singular "the term" is compressed but not wrong.

**The Lie-algebra side.** $q(R)\rvert_{\Lambda^2}=-\sum_\alpha\lambda_\alpha\operatorname{ad}(v_\alpha)^2$, since the derivation action of $\Lambda^2$ on $\Lambda^2$ is $\operatorname{ad}$.

**The sign is load-bearing and it checks.** If the identity read $-2W$ then $\langle u,N_vu\rangle=-2\langle v,u\rangle^2+\lVert[v,u]\rVert^2$ would be indefinite and the proof would collapse, so I checked the sign three ways.

1. **Round sphere.** $B(X,Y)=(n-2)\operatorname{tr}(XY)=-2(n-2)\langle X,Y\rangle$, so for a $\langle\cdot,\cdot\rangle$-orthonormal basis $\sum_a\operatorname{ad}(A_a)^2=-2(n-2)\operatorname{Id}$. Against $q(R)=2(n-1)\operatorname{Id}-2\operatorname{Id}=2(n-2)\operatorname{Id}$. **Equal, with the sign the block needs.** ✓
2. **$\Lambda^4$, checking the block's own caveat.** At $n=4$, $\Lambda^4=\mathbb R\star$ with $\star=\Pi_+-\Pi_-$. From $[w_1,w_2]=-\sqrt2w_3$ (computed above) one gets $\sum_{\Lambda^+}\operatorname{ad}(w_a)^2=-4\Pi_+$, likewise on $\Lambda^-$, so $\sum\lambda_\alpha\operatorname{ad}(v_\alpha)^2=-4\Pi_++4\Pi_-=-4\star$. And $\star$ **is** Ricci-flat, since $\sum_aw_aw_a^{\mathsf T}=\tfrac32I$ on each of $\Lambda^\pm$. **So the block's sentence "$\Lambda^4$ is itself Ricci-flat and carries eigenvalue $-4$ rather than $+2$" is exactly right**, and it is the correct demonstration that first Bianchi, and not Ricci-flatness, is what the identity runs on. ✓ *(As a by-product $\sum_{\mathfrak{so}(4)}\operatorname{ad}^2=-4\operatorname{Id}$, agreeing with $-2(n-2)$ at $n=4$.)*
3. **On the exceptional family itself.** For $W_4(q,r)$, $\operatorname{ad}(w_1)^2=-2(\Pi_2+\Pi_3)$ on $\Lambda^+$ and $0$ on $\Lambda^-$, so $\sum\lambda_\alpha\operatorname{ad}(w_\alpha)^2$ has $\Pi_1$-coefficient $-2(q+r)$, $\Pi_2$-coefficient $2q$, $\Pi_3$-coefficient $2r$, and $0$ on $\Lambda^-$. **That is $2W$ coefficient by coefficient.** ✓

**And it reproduces the record's own anchor.** Contracting at $u=v_\beta$ gives $2\lambda_\beta+\sum_\alpha\lambda_\alpha\lVert[v_\alpha,v_\beta]\rVert^2=0$; substituting $\epsilon_{\alpha\beta}=2-\lVert[v_\alpha,v_\beta]\rVert^2$ with $\sum\lambda=0$ gives $\sum_{\alpha\ne\beta}\lambda_\alpha\epsilon_{\alpha\beta}=0$, the per-row balance [Lemma L72](../findings/stratum-two-negative.md) uses; contracting that against $\lambda_\beta$ gives $\operatorname{tr}W^\#=-\lVert W\rVert^2$, the record's $\operatorname{tr}W^\#=-1$. **The constant $2$ and the sign are both pinned by an anchor the record already holds.**

**The pairing is legitimate.** $\operatorname{ad}(v)$ is skew-adjoint for the ad-invariant $\langle\cdot,\cdot\rangle$, so $\langle u,N_vu\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2\ge0$ with null set $v^\perp\cap\mathfrak z(v)$. ✓ The rescaling is legitimate because $N$ is homogeneous of degree $2$ ($N_{cv}=c^2N_v$), and zero eigenvalues drop from both sides. ✓

> **DEFECT 2, the record overstates a debt against L33.** [LEDGER.md:287](../findings/LEDGER.md), [isotropy-cap.md:219](../findings/isotropy-cap.md) and [reviews/INDEX.md](INDEX.md) row 472 all say L33 "uses both inclusions" of $\ker N_v=v^\perp\cap\mathfrak z(v)$, and therefore owes the unstated passage from the quadratic form's null set to the kernel. **It does not.** The proof needs only the easy inclusion $\mathfrak c\subseteq\ker N_x$ (one line, $N_xu=2\langle x,u\rangle x-\operatorname{ad}(x)[x,u]=0$), after which $\langle u,N_xu\rangle=0$ and the **explicit quadratic form** $2\langle y_i,u\rangle^2+\lVert[y_i,u]\rVert^2=0$ delivers $[y_i,u]=0$ and $y_i\perp u$ directly. Neither self-adjointness-plus-semidefiniteness nor $\ker\operatorname{ad}(v)^2=\ker\operatorname{ad}(v)$ is required. *This clears a debt rather than adding one.*

---

## 4. The "in particular"

> *no rank-$3$ $\mathrm{Weyl}_m$ tensor at even $m\ge6$ has a nondegenerate minority-side eigenvector.*

**It follows, and all three qualifiers are forced.**

| ingredient | where it comes from |
| --- | --- |
| **rank $3$** | Ricci-flatness gives $\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=0$; taking the trace with $\lVert v_\alpha\rVert_F^2=2$ gives $\sum\lambda_\alpha=0$. So rank $3$ excludes signatures $(3,0)$ and $(0,3)$, leaving $(1,2)$ or $(2,1)$, **exactly one eigenvalue on the minority side, necessarily simple**. This is the main statement's hypothesis, supplied by rank $3$ plus trace-freeness. |
| **nondegenerate** | $x$ invertible as a skew matrix. A skew matrix on odd-dimensional space always has a kernel, so **nondegeneracy is what forces $m$ even**, it is not an independent hypothesis. At odd $m$ the sentence is vacuously true. |
| **$m\ge6$** | a nondegenerate $x$ on $\mathbb R^m$ has rank $m$; the exception needs rank $4$. At $m=4$ the two coincide and the exception is live ($W_4(q,r)$); at even $m\ge6$, rank $m>4$ excludes it. **$m\ge6$ is exactly the threshold at which the exception dies.** |

Then the main statement gives $W=0$, contradicting rank $3$. ✓ The consumer at [stratum-two-negative.md:374](../findings/stratum-two-negative.md) uses it correctly: with one positive eigenvalue, Ricci-flatness forces $U=\operatorname{im}v_1$, so full support means $v_1$ nondegenerate and the minority side is the positive one.

> **DEFECT 3, "nondegenerate" is never defined where it is used.** The word appears in L33's statement and nowhere else in the block. It is not in [conventions.md](../findings/conventions.md). Its only definition on the record is implicit, inside a *proof header* in a different file: [L32](../findings/isotropy-cap.md)'s "**Proof, for nondegenerate $x$.** Let $\mathfrak t$ be the maximal torus spanned by $x$'s $p=m/2$ coordinate $2$-planes and $a=(a_1,\dots,a_p)$ its singular values, all nonzero." A cold reader can plausibly take "nondegenerate" to mean the *eigenvalue* is simple, or that $W$ is nondegenerate. **Repair: one clause in the statement, "nondegenerate (i.e. invertible as a skew matrix)".**

---

## 5. The [Lemma L32](../findings/isotropy-cap.md) citation

**Within scope, and the discharge is sound.** L32 as recorded reads: for nonzero $x\in\mathfrak{so}(m)$ and $\mathfrak c=\mathfrak z(x)\cap x^\perp$, $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$ except when $x$ is a multiple of a complex structure on a $4$-dimensional subspace. L33 uses precisely that, on precisely that object, and excludes precisely that exception in its own hypothesis. **No strengthening is taken.** In particular L33 does **not** need L32's stronger "iff" form ([Lemma L81](../findings/isotropy-cap.md)), which is where the $\mathfrak{so}(3)$ hole propagated.

**The repaired hypothesis $\mathfrak c\ne0$ is discharged correctly.** I re-derived the block's bound: $\mathfrak z(x)$ contains the $k$-torus of $x$'s $2$-blocks together with $\mathfrak{so}(\ker x)$, so $\dim\mathfrak z(x)\ge k+\binom{m-2k}2$, minimised at $k=\lfloor m/2\rfloor$ where it equals $\lfloor m/2\rfloor$; intersecting the hyperplane $x^\perp$ costs at most $1$, giving $\dim\mathfrak c\ge\lfloor m/2\rfloor-1$. **Positive for every $m\ge4$**, and $\mathrm{Weyl}_m=0$ for $m\le3$ anyway. ✓ The block's "vanishes only at $n\le3$" is a statement about the bound, which is the right thing to say. Concurs with [r462](REVIEW_r462.md) and [r463](REVIEW_r463.md).

---

## 6. The label, and the provenance note

**The label matches.** [findings/INDEX-results.md](../findings/INDEX-results.md) row 33 reads "one eigenvalue of one sign forces the tensor to vanish", in [stratum-two-negative.md](../findings/stratum-two-negative.md), identical to the block's heading, correct file. ✓ *(The row also carries "Gate 2: no verdict on the record" against a `Lemma` label the index defines as "Gate 2 passed", while the block says "Gate 2 passed by both reviewers". The two senses of Gate 2 (the research loop's and this audit's), are being run together, but the pattern is shared with rows 30, 31 and 34, so it is not an L33 defect.)*

> **DEFECT 4, the provenance sentence is FALSE for this block.** It reads *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was **the only copy**."* At `56848c5e`, the commit immediately preceding the move `a9e4b8c0`, **a complete second copy, statement and proof, sat in [findings/isotropy-cap.md](../findings/isotropy-cap.md)** under the heading "Lemma 33 (the answer to B0's recorded question, in the sharp form Reviewer 60 supplies)", lines 158–162. `git grep -ln 'Rescale so the identity reads' 56848c5e` returns **both** `results.md` and `findings/isotropy-cap.md`. The argument in fact originated at `62ccb443` (2026-08-23) in `response.md`, which became `results.md` at `56848c5e`. So results.md was not the only copy, and it was not even the copy the findings tree inherited from.

**And the discarded copy said three things the canonical block does not.** The isotropy-cap.md version's "In particular" ran: "for even $m\ge6$ there is no rank-$3$ $\mathrm{Weyl}_m$ tensor whose minority-side eigenvector is nondegenerate, **at any number of eigenvalues on the other side**; and the padded $\mathrm{Weyl}_4$ family is the **only** thing on the boundary. **This single statement covers odd $m$ and degenerate minority eigenvectors as well.**" All three clauses are true (the first two are immediate from the proof, the third is §2's completeness result) and all three were lost in the move. The last is the substantive loss: it says the *general* statement subsumes the odd-$m$ and degenerate cases that the "in particular" restricts away, which is what stops a reader treating even $m\ge6$ as the lemma's reach.

---

## 7. Cross-checks for contradiction

| checked | result |
| --- | --- |
| every non-review mention of L33 in the tree | no restatement with different hypotheses; [results.md:152](../results.md) and [results.md:436](../results.md) match the block |
| later sections of [stratum-two-negative.md](../findings/stratum-two-negative.md) | **no contradiction.** [L34](../findings/stratum-two-negative.md)'s full-support witnesses have **two** negative eigenvalues, outside L33's hypothesis, and L34 says so ("a statement stronger than Lemma L33 settles"). [L72](../findings/stratum-two-negative.md) closes the rank-$3$ stratum by an independent route that "replac[es] … the $\mathfrak{su}(2)$ input", i.e. it does not depend on L33's conclusion. |
| [isotropy-cap.md:245](../findings/isotropy-cap.md) | correctly demoted to a pointer at the move; the Gate 2 paragraph at line 249 is still duplicated verbatim in both files. Cosmetic. |
| [L72](../findings/stratum-two-negative.md)'s citation at line 501 | **mis-attributed, mildly.** "the per-row Bianchi balance (Lemma L33 evaluated at a single $v_\beta$)" cites L33 for the *classical identity*, which L33's own block explicitly disclaims as "cited, not claimed" (Besse §1.143, Petersen–Wink 1.6). The derivation is right (I reproduced it in §3) but it makes L33's *conclusion* look load-bearing for L72 when only the Weitzenböck identity is. |

---

## Summary

**The lemma is true and the proof is correct.** Four repairs are owed, in descending order:

1. **Correct the provenance sentence**, the argument was not the only copy; a full duplicate sat in [isotropy-cap.md](../findings/isotropy-cap.md).
2. **Disambiguate "exactly one eigenvalue of one sign"** to "one-dimensional eigenspace of one sign". Correct inside its file, false outside it, with [L34](../findings/stratum-two-negative.md)'s $m=8$ witness supplying the counterexample to the wrong reading.
3. **Define "nondegenerate"** in the statement.
4. **Clear the overstated debt** at [LEDGER.md:287](../findings/LEDGER.md) and [isotropy-cap.md:219](../findings/isotropy-cap.md); restore the three dropped clauses and the signature-symmetry sentence.

**VERDICT: CONFIRMED**
