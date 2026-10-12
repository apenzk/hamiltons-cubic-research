# Review r617, Lemma L106, the zero-defect set as infinitesimal symmetries

**Verdict: CONFIRMED, the biconditional is true, both bracket consequences are true, and the grading conclusion is true under the two hypotheses the block states. But the biconditional is a RESTATEMENT, not a theorem**: it is "a sum of squares vanishes iff every term does" plus the linearity of $x\mapsto\mathrm{ad}(x)$, and everything it can be cited for lives in the *consequences*, not in the equivalence. Four defects around it, none touching the mathematics: the closing pointer **step H** resolves to nothing on the record and, read as written, overstates what the record proves; the table drops the $S_{\mathfrak{mmm}}$ column that the grading conclusion's own hypothesis needs; the block carries no `Proof.` and puts a `Gate 1` table directly under a `Lemma` heading; and $\mathfrak p$ and $\mathfrak k(W)$ have no entry in [conventions.md](../findings/conventions.md).

Reviewer A of an independent pair. **Analysis only: nothing below was computed.** Every number is derived in closed form or read off a file; the one arithmetic sweep (the table's dimension identity) is ten additions done by hand.

The block under audit: [findings/bounds.md](../findings/bounds.md) (heading line 106, body line 108, evidence heading line 110, table lines 112–124).

---

## 0. The conventions, fixed before deriving

The brief is right that $\mathfrak m$ is the trap, and the block disambiguates itself. Reading, with sources:

| symbol | sense in force at L106 | where fixed |
|---|---|---|
| $\mathfrak p$ | $\operatorname{span}\{v_\alpha:\lambda_\alpha>0\}$, the strictly positive eigenspace of $W$ inside $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ | [bounds.md](../findings/bounds.md) line 68 ($\Delta=\sum_{\gamma\in\mathfrak p}$), [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py) line 8 verbatim. **No entry in [conventions.md](../findings/conventions.md)** |
| $\mathfrak m$ | the **whole** negative eigenspace, [L36](../findings/isotropy-cap.md)'s sense, **not** [conventions.md](../findings/conventions.md)'s tabled $E_{\min}$ | forced by the block's own $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m$ under trivial kernel; the two senses coincide at every two-eigenvalue row of the table, so the table cannot separate them |
| $\mathfrak k(W)$ | $\{x\in\mathfrak{so}(n):[\mathrm{ad}(x),W]=0\}$, the isotropy algebra of $W$ under $SO(n)$ | [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py) line 22. **No entry in [conventions.md](../findings/conventions.md)** |
| $g_\delta$ | $\lVert[\mathrm{ad}(v_\delta),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\delta\alpha\beta}$, ordered pairs, the [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7 density | [Lemma L68](../findings/diagonal-half.md) |
| $\Delta$ | $\sum_{\delta}g_\delta$ traced over $\{\lambda>0\}$ **strictly** | [conventions.md](../findings/conventions.md), and the same file 12 lines above L106 |
| $S$ | **local to the block**: $S:=S_{\mathfrak{mmm}}=\sum_{a,b,c\in\mathfrak m}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2$ | [ungraded-slack.md](../findings/ungraded-slack.md) line 132 |

**Two collisions the block survives on its own colon-equals.** [conventions.md](../findings/conventions.md) tables $S(W)$ as *the gradedness slack*, [Lemma L7](../findings/bounds.md)'s $\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\operatorname{tr}(W_-)-\operatorname{tr}(W_-^2)$, whose vanishing is **three** bracket conditions, strictly stronger than $S_{\mathfrak{mmm}}=0$. The block writes $S:=S_{\mathfrak{mmm}}$ explicitly and so takes the *weaker* hypothesis, which makes its conclusion stronger, not weaker. Separately, [conventions.md](../findings/conventions.md) tables $\mathfrak h=E_{\max}$ while [ungraded-slack.md](../findings/ungraded-slack.md) uses $\mathfrak h$ for the whole positive part, the letter L106 renames $\mathfrak p$. Neither collision damages L106; both are why the audit had to start here.

---

## 1. The biconditional, CONFIRMED, and it is a restatement

**Both directions, from the definitions.** Let $L:\mathfrak{so}(n)\to\operatorname{End}(\Lambda^2\mathbb R^n)$, $L(x)=[\mathrm{ad}(x),W]$. $L$ is **linear** in $x$, because $x\mapsto\mathrm{ad}(x)$ is. Put $\Phi(x)=\lVert L(x)\rVert^2$, a positive semidefinite quadratic form. With $\{v_\delta\}$ any orthonormal basis of $\mathfrak p$,

$$\Delta(W)=\sum_\delta g_\delta=\sum_\delta\Phi(v_\delta)=\operatorname{tr}\big(\Phi\vert_{\mathfrak p}\big).$$

- ($\Leftarrow$) If $\mathfrak p\subseteq\mathfrak k(W)$ then $L(v_\delta)=0$ for every $\delta$, so every $g_\delta=0$ and $\Delta=0$.
- ($\Rightarrow$) $\Delta$ is a sum of non-negative terms, so $\Delta=0$ forces $g_\delta=0$, i.e. $L(v_\delta)=0$, for **each** $\delta$. By linearity of $L$, $L\equiv0$ on $\operatorname{span}\{v_\delta\}=\mathfrak p$. Hence $[\mathrm{ad}(x),W]=0$ for every $x\in\mathfrak p$, i.e. $\mathfrak p\subseteq\mathfrak k(W)$. $\square$

**The index sets agree, so the direction the brief flagged as most likely to fail does not fail.** $\Delta$ sums over an orthonormal basis of the strictly positive eigenspace and the statement quantifies over $x$ in that same subspace, checked three ways: [bounds.md](../findings/bounds.md) line 68 writes $\Delta(W)=\sum_{\gamma\in\mathfrak p}\lVert v_\gamma\!\cdot\!W\rVert^2$; [Lemma L68](../findings/diagonal-half.md) says "trace over the strictly positive eigenspace"; and the script header names $\mathfrak p:=\operatorname{span}\{v_a:\lambda_a>0\}$ and states the equivalence in the same two lines. **No subset/superset mismatch exists.** Two incidental soundness points: $\Delta$ is basis-independent because it is the trace of a form over a subspace, so eigenvalue degeneracy inside $\mathfrak p$ is harmless; and the degenerate case $\mathfrak p=0$ makes both sides vacuously true.

**What the Lemma adds beyond "a sum of squares vanishes iff each term does".** Exactly one thing, and it is one line: the upgrade of the quantifier from *a basis of $\mathfrak p$* to *every $x\in\mathfrak p$*, which is linearity of $L$, and the naming of the resulting subspace condition as containment in the **isotropy algebra** $\mathfrak k(W)$, an object that is a Lie subalgebra and carries a dimension. That naming is what the consequences in §2 and the dimension screen in §4 consume. **The equivalence itself proves nothing that the definition of $\Delta$ does not already say**, and the record should cite it for the containment, never as evidence that the containment is hard.

**The prose gloss is accurate.** "Every positive eigenvector of $W$ is an infinitesimal symmetry of $W$" reads correctly: eigenvector *of $W$* with positive eigenvalue, viewed as an element of $\mathfrak{so}(n)$ under $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, and "infinitesimal symmetry" = generator of a one-parameter subgroup of $SO(n)$ fixing $W$ = membership in $\mathfrak k(W)$. There is no second operator whose positive-eigenvalue subspace is meant. The gloss is *weaker* than the formula only in that eigenvectors span $\mathfrak p$ rather than exhaust it, which is the linearity step above.

---

## 2. The consequence, CONFIRMED, and the block is NOT cut short

The copy in the brief is truncated; the file's sentence is complete and has been unchanged since commit `51ab61f8` (2026-08-24). Each arrow:

**(a) $\mathrm{ad}(x)$ commuting with $W$ preserves every eigenspace.** If $A$ commutes with $W$ and $Wv=\lambda v$, then $W(Av)=A(Wv)=\lambda Av$, so $Av\in E_\lambda$. No symmetry of $A$ is needed; $W$ symmetric is used only to know the eigenspaces span and are mutually orthogonal.

**(b) Hence $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$ and $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$.** $\mathfrak p$ is the sum of the eigenspaces with $\lambda>0$ and $\mathfrak m$ the sum of those with $\lambda<0$; $\mathrm{ad}(x)$ for $x\in\mathfrak p$ preserves each summand, hence each sum. Since $\mathrm{ad}(x)y=[x,y]$, $[\mathfrak p,\mathfrak p]=\mathrm{ad}(\mathfrak p)\mathfrak p\subseteq\mathfrak p$ and $[\mathfrak p,\mathfrak m]=\mathrm{ad}(\mathfrak p)\mathfrak m\subseteq\mathfrak m$. **Both hold with no kernel hypothesis and no criticality.**

**(c) The bracket containment, stated in full.** The block delivers $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$, *not* merely $\subseteq\mathfrak k(W)$, which is what the subalgebra property of $\mathfrak k(W)$ alone would give and which is strictly weaker. What is written is what follows.

**(d) How many of the three grading relations.** **Two of three, unconditionally.** With $\mathfrak h=\mathfrak p$, $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ and $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ come from $\Delta=0$ alone. The third, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, is **bought, not derived**: $S_{\mathfrak{mmm}}=0$ gives $[\mathfrak m,\mathfrak m]\perp\mathfrak m$, and $W$ symmetric makes $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m\oplus\ker W$ orthogonal, so $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p\oplus\ker W$, which is $\mathfrak p$ **only under trivial kernel**. The block hedges both hypotheses correctly in the sentence that draws the conclusion. Three relations with $\sigma=+1$ on $\mathfrak p$, $-1$ on $\mathfrak m$ make $\sigma$ an involutive automorphism, which is the $\mathbb Z_2$-grading. Sound.

**The trivial-kernel hypothesis is load-bearing and the record knows where it bites.** Padded $W_{\mathbb{CP}^2}$ has $\Delta=0$ with a $25$-dimensional kernel at $n=8$ and is graded as a $3$-dimensional **subalgebra** rather than as $\mathfrak{so}(8)$, recorded in the block's own withdrawn-correction section, in [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py) lines 47–51, and again at [graded-half.md](../findings/graded-half.md) line 391 as "UNSOUND off $\ker W=0$". The hypothesis is stated; nothing is owed here.

---

## 3. The label and the table

**The biconditional is PROVEN, not measured, and the table is a consistency check.** Saying so explicitly, as the brief asks: §1 and §2 are complete from the definitions, use no numerics, and hold at every $n\ge4$ and every $W$. **The `Lemma` label is right on the mathematics.** Two presentational defects follow from that, both real because this record's labels are literal:

- **The block carries no `Proof.`** Its two lines *are* the proof, but a reader meeting `#### Lemma L106` followed immediately by `#### Measured (...), Gate 1` will read the table as the evidence. Every other audited Lemma in this file carries an explicit proof paragraph. **Owed: mark the two lines as the proof and relabel the table a consistency check.**
- **[INDEX-results.md](../findings/INDEX-results.md) line 123 records "Gate 2: no verdict on the record"**, while the same file's preamble defines `Lemma` as "proven, Gate 1 and Gate 2 passed". The label therefore outruns the row by the index's own definition. This review is one half of the missing Gate 2.

**The dimension identity $\dim\mathfrak m+\dim\ker+\dim\mathfrak p=\binom n2$ holds at every row.** All ten:

| row | $n$ | $\dim\mathfrak m+\dim\ker+\dim\mathfrak p$ | $\binom n2$ |
|---|---|---|---|
| $S^6\times S^6$ | 12 | $36+0+30=66$ | 66 |
| $S^5\times S^7$ | 12 | $35+0+31=66$ | 66 |
| $S^4\times S^8$ | 12 | $32+0+34=66$ | 66 |
| $S^3\times S^3$ | 6 | $9+0+6=15$ | 15 |
| $\mathbb{CP}^2$ | 4 | $2+3+1=6$ | 6 |
| $\mathbb{CP}^3$ | 6 | $6+0+9=15$ | 15 |
| $\mathbb{CP}^4$ | 8 | $12+0+16=28$ | 28 |
| $\mathbb{CP}^2$ padded | 8 | $2+25+1=28$ | 28 |
| $S^3\times S^3$ padded | 8 | $9+13+6=28$ | 28 |
| $C_5$ blow-up | 10 | $20+0+25=45$ | 45 |

**No row fails.** Three further internal checks pass. *(i)* The padding arithmetic is exact: padding $\mathbb{CP}^2$ from $n=4$ adds $28-6=22$ kernel directions to the existing $3$, giving $25$; padding $S^3\times S^3$ from $n=6$ adds $28-15=13$, giving $13$. *(ii)* Every $\dim\mathfrak p$ is the dimension of the named isotropy algebra, $\dim(\mathfrak{so}(6)\oplus\mathfrak{so}(6))=30$, $\dim(\mathfrak{so}(5)\oplus\mathfrak{so}(7))=31$, $\dim(\mathfrak{so}(4)\oplus\mathfrak{so}(8))=34$, $\dim(\mathfrak{so}(3)\oplus\mathfrak{so}(3))=6$, $\dim\mathfrak u(3)=9$, $\dim\mathfrak u(4)=16$, and every $\dim\mathfrak m$ is $pq$ or $\dim\mathfrak{so}(n)-\dim\mathfrak u(m)$. *(iii)* Every $\Delta=0$ row has $S_{\mathfrak{mpp}}=0$ and the one $\Delta>0$ row has $S_{\mathfrak{mpp}}=80$, which is the sign of the implication of §2(b), the table is testing $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$, and passes.

**The $C_5$ row's "$\Delta=12$ of $36$" is re-derived here, closed form.** The total $\sum_\gamma g_\gamma$ over *all* of $\Lambda^2$ is
$$\sum_{\gamma\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}=2\sum_\alpha\lambda_\alpha^2\!\!\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2-2\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\lVert[v_\alpha,v_\beta]\rVert^2=4(n-2)\lVert W\rVert^2-4\operatorname{tr}(W^\#),$$
using the Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ of [conventions.md](../findings/conventions.md) and the walk identity $\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{\gamma\alpha\beta}^2=\langle v_\gamma,W^\#v_\gamma\rangle$ of [bounds.md](../findings/bounds.md). With $\lVert W\rVert=1$ and $\operatorname{tr}(W^\#)=-1$ this is **$4(n-1)$ exactly**, $=36$ at $n=10$. So the block's normaliser is a theorem, the $12$ is a measurement, and the two are consistent. *This also confirms the recorded decomposition $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$ with $Q_\gamma=2(W^\#)_{\gamma\gamma}$, the one step [Lemma L68](../findings/diagonal-half.md) flags as Gate 2 owed.*

**The $\mathbb{CP}^2$ row's isotropy $4$ against $\dim\mathfrak p=1$ is CORRECT and is not a defect.** The isotropy column is $\dim\mathfrak k(W)$, and L106 asserts a **containment** $\mathfrak p\subseteq\mathfrak k(W)$, so the column may exceed $\dim\mathfrak p$ at any row without contradicting anything; it can never fall below it at a $\Delta=0$ row, and it does not. At unpadded $W_{\mathbb{CP}^2}$, $\mathfrak k(W)=\mathfrak u(2)=\mathfrak{su}(2)_-\oplus\mathbb R\omega$ of dimension $4$ inside $\mathfrak{so}(4)$, with $\mathfrak p=\mathbb R\omega$ the Kähler line, independently recorded at [fence-posts.md](../findings/fence-posts.md) line 355. The gap of $3$ is exactly $\mathfrak{su}(2)_-$, which acts trivially on the self-dual part where $W$ lives. The block's own follow-up sentence draws the right conclusion: $\dim\mathfrak p=\dim\mathfrak k(W)$ **plus** containment gives equality, which is why $\mathfrak p$ **is** $\mathfrak k(W)$ at the four sphere products and at $\mathbb{CP}^{3,4}$ and only $\subsetneq$ at $\mathbb{CP}^2$. Valid.

**One column is missing and it is the load-bearing one.** The table prints $\Delta$ and $S_{\mathfrak{mpp}}$ but **not $S_{\mathfrak{mmm}}$**, which is the hypothesis the block's grading conclusion runs on. [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py) line 163 prints an `S_mmm` column and a `graded?` column; both were dropped in transcription. As printed, the table cannot be read to check that $S=0$ at any row, so it does not evidence the sentence it sits under. **Owed: restore the $S_{\mathfrak{mmm}}$ column.** *(Minor, same paragraph: the isotropy entry for padded $\mathbb{CP}^2$ at $n=8$ is "—", while [fence-posts.md](../findings/fence-posts.md) line 355 carries the number ($\mathfrak u(2)\oplus\mathfrak{so}(4)$, dimension $10$) so the dash records the script's sentinel rather than an unknown.)*

---

## 4. Scope, and what consumes it

**Scope.** The biconditional needs nothing: no criticality, no unit norm, no trivial kernel, every $n\ge4$, every $W$ with a spectrum. The two bracket relations of §2(b) inherit that. **Only the grading conclusion is scoped**, and to exactly the two hypotheses it names, $S_{\mathfrak{mmm}}=0$ and $\ker W=0$.

**What it does for the record, and what it does not.** Three consumers, and the honest reading of each:

- **The dimension screen** at [bounds.md](../findings/bounds.md) line 88, $\dim\mathcal O\le\dim\mathfrak m+\dim\ker W$. **Valid, and it is L106's one quantitative output**: $\dim\mathcal O=\binom n2-\dim\mathfrak k(W)$ and $\mathfrak p\subseteq\mathfrak k(W)$ give $\dim\mathfrak k\ge\dim\mathfrak p$, hence the bound. It is an inequality on the orbit, not on the zero-defect set.
- **The band reduction**, on $\{S=0\}$ with trivial kernel, $\{\Delta=0\}$ goes to the graded half and $\{\Delta>0\}$ is what remains ([ATTEMPTS.md](../ATTEMPTS.md) line 2154, [target.md](../findings/target.md) line 530, [graded-half.md](../findings/graded-half.md) line 337). **Valid as an implication**; its converse is false and the record already says so, a graded critical point with $\Delta=1.512$ being catalogued at $n=8$ fourteen lines below the block.
- **Any claim that the zero-defect set is small, or hides no rival.** **L106 supports none of it.** It names the set and gives it a structure; it bounds nothing that lives in it. The same file has already refuted both smallness readings, padded $\mathbb{CP}^2$ at $n=8$ with $\dim\mathcal O=18>\dim\mathfrak m=2$ and $\Delta=0$, padded $S^3\times S^3$ at $n=10$ with $33>9$, and $S^2\times S^{10}$ at $n=12$ inside the band with trivial kernel and $\Delta=0$, and replaced them with a rigidity reading. **Nothing in this Lemma may be cited for scarcity of $\{\Delta=0\}$.**

**The one clause that overstates: "step **H** already handles graded critical points".** Two separate problems.

1. **The pointer does not resolve.** The letter-step scheme is defined nowhere on the record. It survives only in prose, this block, [bounds-relaxations.md](../findings/bounds-relaxations.md) line 38 ("step (G), the crux"), [ATTEMPTS.md](../ATTEMPTS.md) line 2154, and several reviews, and no list of steps A…H exists in [plan.md](../plan.md), [results.md](../results.md), [routes.md](../routes.md) or [ATTEMPTS.md](../ATTEMPTS.md). **The one place the record states what H says is [r111](REVIEW_r111.md), quoting a version of [plan.md](../plan.md) that no longer carries it.** Owed: name the numbered result instead of the letter.
2. **Read as written it is false, though what L106 actually delivers is safe.** The graded half is *not* handled entire: [graded-half.md](../findings/graded-half.md) line 337 splits it into equivariant points, which [Lemma L69](../findings/graded-half.md) handles, and non-equivariant ones ($\Delta>0$), which are open, and [Lemma L69](../findings/graded-half.md) is itself scoped to $n\ge12$, $\theta\ge\sqrt{3/2}$ and the equivariant case ([INDEX-results.md](../findings/INDEX-results.md) line 83, Gate 2 PLAUSIBLE/CONFIRMED). **The rescue is that L106 hands over only $\Delta=0$ points, and on a graded point $\Delta=0$ iff $W$ is $\mathrm{ad}(\mathfrak p)$-equivariant** (the equivalence recorded thirty lines below the block) so the points delivered are exactly [Lemma L69](../findings/graded-half.md)'s territory. The clause is therefore true of *its own output* and false of its stated subject. **Owed: replace with "and [Lemma L69](../findings/graded-half.md) handles the equivariant graded points, which is what $\Delta=0$ delivers".**

---

## 5. The checklist

| item | outcome |
|---|---|
| **Provenance** | **CHECKED AND CLEAN.** [LEDGER.md](../findings/LEDGER.md) line 157 says the block "declared its own debt in its heading (*proved, two lines; Gate 2 owed*) while carrying no number". True: at commit `51ab61f8` the heading in `findings/live-front.md` line 296 read exactly `**Lemma (proved, two lines; Gate 2 owed).**`, and the body sentence is character-for-character what stands today. Introduced at `6d3c62db`. **The block itself carries no history note**, so there is nothing else here to falsify. |
| **Hedging clauses** | "exactly" in the heading is **earned**, the biconditional is an iff. "i.e." before $\mathfrak p\subseteq\mathfrak k(W)$ is **a genuine restatement**, since $\mathfrak k(W)$ is defined by that vanishing. "hence" before the bracket relations is **valid** (§2). "exactly" in "$S=0$ says exactly $[\mathfrak m,\mathfrak m]\perp\mathfrak m$" is **the definition of $S_{\mathfrak{mmm}}$** and correct. **The one clause that conceals something is "already handles"**, §4 above. |
| **Numbers as identities** | $\Delta=0$ at nine rows is a **measurement**. The normaliser $4(n-1)$ is an **identity**, re-derived in §3. $S_{\mathfrak{mpp}}=0$ at the $\Delta=0$ rows is a measurement *and* a consequence of §2(b), so those nine entries are the consistency check. |
| **Does the file already settle it** | **Yes, four times.** The strictly-positive convention is defended twelve lines above; the padded-kernel trap is the block's own withdrawn-correction section below; the graded-and-$\Delta=0$ equivalence, which repairs the "step H" clause, is thirty lines below; and the refutation of every smallness reading is eighteen lines above. |
| **Pointers** | [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py) **resolves** and its header states the same equivalence. [b_defect_catalogue.py](../scripts/route-b/b_defect_catalogue.py) **resolves**. [INDEX-results.md](../findings/INDEX-results.md) line 123 **carries row 106**. **"step H" does not resolve** (§4). *Adjacent, outside this block: [graded-half.md](../findings/graded-half.md) lines 337 and 391 link [Lemma L69](../findings/graded-half.md) with an empty anchor `(#)`.* |

---

## 6. What is owed

Nothing on the mathematics. Four repairs, all editorial, in descending order:

1. **Replace "step **H**"** with the numbered result, and scope it to the equivariant graded points ([Lemma L69](../findings/graded-half.md)), the only clause in the block that says more than the record proves.
2. **Restore the $S_{\mathfrak{mmm}}$ column** to the table, which cannot otherwise evidence the hypothesis of its own conclusion.
3. **Mark the two lines as `**Proof.**`** and relabel the `Measured, Gate 1` heading a consistency check, so a `Lemma` is not seen resting on a Gate 1 table.
4. **Add $\mathfrak p$ and $\mathfrak k(W)$ to [conventions.md](../findings/conventions.md)**, which tables $\mathfrak m$, $\mathfrak h$ and $\Delta$ but neither of the two symbols this Lemma is stated in.

**And one instruction for citation, which is the useful half of this review**: L106 is a restatement of the definition of $\Delta$, so cite it for the *containment* $\mathfrak p\subseteq\mathfrak k(W)$, for the two bracket relations, and for the dimension screen. **Never cite it as evidence that $\{\Delta=0\}$ is small, structured beyond those relations, or free of a rival maximiser.**
