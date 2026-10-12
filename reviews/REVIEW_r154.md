# Review r154, Gate 2: the three-label discrepancy, the perp-sum closure, the subalgebra route

Cold adversarial reading of [plan.md](../plan.md) §2 B1, [findings/graded-half.md](../findings/graded-half.md), [findings/target.md](../findings/target.md) and [references/petersen-stanfield-2025-poincare-polynomials/](../references/petersen-stanfield-2025-poincare-polynomials/). Output is derivation and reading; the two numbers below are exact rationals obtained by hand from formulas already on the record.

## Verdict in one line

**The discrepancy is not a discrepancy.** One of the three labels was already struck from the record before the item was written, and the surviving two are compatible descriptions of one operator, which I identify here by proof rather than by matching digits. **B1's owed object is on file**, and has been since the Jensen entry was written. Claim 3 is CONFIRMED and I supply an unconditional proof covering every unbalanced sphere product. Claim 2's conclusion holds but for a reason different from the one recorded, its numeric sequence has no artefact and its last entry does not reproduce, and the phrase "reducibility is itself a strong symmetry" is backwards as stated.

---

## CLAIM 1, SETTLED. Two live labels, one point, and B1 is answered

### Label (i), $Q_3=\widetilde G_2(\mathbb R^5)$, is not a live label at all

[target.md](../findings/target.md) line 375 is inside the table headed *"Reviewer 78's $Q_3$, $Q_5$, $Q_6$ were MISLABELLED"*, whose columns are **"as recorded"** and **"exact truth"**. The $\sqrt{6/5}$ entry sits in the *as recorded* column; the *exact truth* column gives $\theta^2=15/26$, $\theta=0.759554525$, $S_{\mathfrak{mmm}}=30$. Line 434 of the same file states the attribution is refuted and line 438 withdraws the consequence. **Citing line 375 as a current identification quotes a value the file explicitly marks as wrong.** So $\widetilde G_2(\mathbb R^5)$ and the measured point do **not** coincide: they differ in the fourth significant figure of $\theta$ and in $S$ by $30$.

### Label (ii)'s stated defect does not exist, the "$\dim 5$ vs $6$" reading misreads the column

The $(\mathfrak{su}(m),\mathfrak{so}(m))$ rows are **not** quotients $SU(m)/SO(m)$. [target.md](../findings/target.md)'s own derivation fixes $p=\dim\mathfrak{so}(m)=\binom m2$, $q=\dim\mathfrak m=\binom{m+1}2-1$, and $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ acts on $\Lambda^2\mathbb R^n$ with $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$ through $\mathbb R^{2m}=\mathbb C^m$. Hence **$n=2m$**, and the tabulated column is the ambient dimension, not $\dim G/K$:

| $m$ | $p$ | $q$ | $p+q$ | $n=2m$ | tabulated at |
|---|---|---|---|---|---|
| $2$ | $1$ | $2$ | $3=\dim\mathfrak{su}(2)$ | $4$ | $W_{\mathbb{CP}^2}$, $n=4$ |
| $3$ | $3$ | $5$ | $8=\dim\mathfrak{su}(3)$ | $6$ | $n=6$ ✓ |
| $5$ | $10$ | $14$ | $24=\dim\mathfrak{su}(5)$ | $10$ | $n=10$ ✓ |
| $6$ | $15$ | $20$ | $35=\dim\mathfrak{su}(6)$ | $12$ | $n=12$ ✓ |

All four rows are internally consistent. **The row is not mislabelled; the discrepancy note's third column is.** The Wu manifold $SU(3)/SO(3)$, $\dim 5$, was never claimed.

Consequently the "symmetric? **yes**" cell on that row is also wrong: $(\mathfrak{su}(3),\mathfrak{so}(3))$ is a symmetric **pair of Lie algebras** used to grade an operator inside $\mathfrak{so}(6)$. It is not an assertion that any symmetric **space** carries this Weyl operator, and it could not be, since the only symmetric space named by that pair has the wrong dimension. **The discrepancy table's "symmetric?" column conflates a symmetric pair with a symmetric space, and that conflation is the entire content of the alleged contradiction.**

### Labels (ii) and (iii) name the same operator, proved, not matched

The record ([graded-half.md](../findings/graded-half.md) line 346) says the values "coincide". They do more than coincide.

Petersen–Stanfield §2.4 (source text, [petersen-stanfield-2508.11236.txt](https://arxiv.org/abs/2508.11236) lines 384–406) write $S^3\times S^3=SU(2)^3/\Delta SU(2)$ with $\mathfrak p=\mathfrak p_1\oplus\mathfrak p_2$, $\mathfrak p_i\cong\mathfrak{su}(2)$, and
$$\textstyle\Lambda^2\mathfrak p=\underbrace{\mathfrak{su}(2)}_{\Lambda^2\mathfrak p_1}\oplus\underbrace{\mathfrak{su}(2)}_{\Lambda^2\mathfrak p_2}\oplus\underbrace{\mathfrak{su}(2)\oplus\mathrm{Sym}^2_0(\mathfrak{su}(2))\oplus\mathbb R}_{\mathfrak p_1\wedge\mathfrak p_2},$$
with $R=\frac1{48}\mathrm{diag}\big(\begin{smallmatrix}9&5\\5&9\end{smallmatrix}\big),4,-2,4\big)$ in that splitting.

Four steps, each from the definitions:

1. **The Weyl part.** $\operatorname{tr}R=3\cdot\frac7{24}+7\cdot\frac1{12}+5\cdot(-\frac1{24})=\frac54$, and $\dim\Lambda^2\mathbb R^6=15$, so the trace part is $\frac1{12}\mathrm{Id}$. The metric is Einstein, so the traceless-Ricci term vanishes and $W=R-\frac1{12}\mathrm{Id}$, with eigenvalues $\tfrac5{24}$ (mult $3$), $0$ (mult $7$), $-\tfrac18$ (mult $5$), exactly what [graded-half.md](../findings/graded-half.md) line 313 records.
2. **The top eigenspace is a subalgebra, and which one.** The $\tfrac7{24}$ eigenvector of $\big(\begin{smallmatrix}9&5\\5&9\end{smallmatrix}\big)$ is $(1,1)$, so $E_{5/24}$ is the **diagonal** of $\Lambda^2\mathfrak p_1\oplus\Lambda^2\mathfrak p_2$. The isotropy $\Delta SU(2)$ acts on $\mathfrak p_1$ and $\mathfrak p_2$ each by the adjoint, so its image in $\mathfrak{so}(\mathfrak p)=\mathfrak{so}(6)$ *is* that diagonal. Hence $E_{5/24}=\mathfrak h\cong\mathfrak{so}(3)$, and as an $\mathfrak{so}(3)$-module $\mathbb R^6=\mathfrak p_1\oplus\mathfrak p_2=2\cdot V_3$.
3. **The same $\mathfrak{so}(3)$ appears in label (ii).** For $(\mathfrak{su}(3),\mathfrak{so}(3))$ the ambient is $\mathbb R^6=\mathbb C^3=\mathbb R^3\otimes_{\mathbb R}\mathbb C$, on which $\mathfrak{so}(3)$ acts as $2\cdot V_3$ as well. An $\mathfrak{so}(3)\subset\mathfrak{so}(6)$ with $\mathbb R^6\cong 2\cdot V_3$ is unique up to $O(6)$-conjugacy, so the two top eigenspaces may be identified.
4. **The rest is then forced.** As an $\mathfrak{so}(3)$-module, $\mathfrak{so}(6)=3\cdot V_3\oplus V_1\oplus V_5$, the $5$-dimensional irreducible occurs with **multiplicity one**. Both operators are scalar on an $\mathfrak{so}(3)$-submodule of dimension $5$, so both have the *same* $5$-dimensional eigenspace, hence the same $7$-dimensional kernel. Their nonzero eigenvalue ratio is fixed by tracelessness alone: $3a+5b=0\Rightarrow a/b=-5/3$, and $(\tfrac5{24})/(-\tfrac18)=-5/3$. ✓

**Therefore the Jensen point and the $(\mathfrak{su}(m),\mathfrak{so}(m))$ point at $m=3$ are $O(6)$-conjugate.** One operator, two correct descriptions. (Corollary, free: $\mathfrak{so}(3)\oplus V_5\cong\mathfrak{su}(3)$ inside $\mathfrak{so}(6)$, since it is so for label (ii).) The record's numeric agreement is upgraded to an identity, and $\theta^2=m(m+1)/((m-1)(m+2))=12/10=6/5$ at $m=3$ ✓.

### So: does the record hold an irreducible critical point that is not a symmetric space? **YES**

Take $W$ = the point above.

- **Not a symmetric space.** It is the Weyl operator of the homogeneous nearly-Kähler metric on $S^3\times S^3$, which Petersen–Stanfield certify non-symmetric by their own Theorem A ($R$ has eigenvalue $-\tfrac1{24}<0$, while symmetric spaces have $\mathrm{spec}\,R\subset[0,\tfrac12]$). This is a citation, not a computation.
- **De Rham irreducible**, one line: a Riemannian product has $R$ vanishing on $V_1\wedge V_2$, a subspace of dimension $\ge5$; here $\mathrm{spec}\,R=\{\tfrac7{24},\tfrac1{12},-\tfrac1{24}\}$ contains no zero, so $R$ is invertible and the metric is not a product.
- **Block-indecomposable as an operator**, which is B1's own sense of irreducible ("absence of a distinguished decomposition"). A $\perp$-sum on $\mathbb R^6=\mathbb R^{n_1}\oplus\mathbb R^{n_2}$ forces $\ker W\supseteq\mathbb R^{n_1}\wedge\mathbb R^{n_2}$ of dimension $n_1n_2\in\{5,8,9\}$; $\dim\ker W=7$, so only $(1,5)$ survives arithmetically, i.e. $W$ would be a padding and $\mathbb R^6$ would carry a $\mathrm{Stab}(W)$-invariant line. $\mathrm{Stab}(W)^\circ\supseteq SO(3)$ acting as $2\cdot V_3$, which has no invariant vector. So $W$ is unpadded and indecomposable.

**B1's letter is met, and was met before the item was written.** [bounds.md](../findings/bounds.md) line 129 already records *"Graded does not imply symmetric, gradedness is strictly broader, Jensen's metric on $S^3\times S^3$ being the record's own witness"*, and [graded-half.md](../findings/graded-half.md) line 346 already records the coincidence with the $\mathfrak{su}(3)$ point. `git log -S` confirms **both sentences predate commit 0da462f**, the commit that raised the discrepancy.

### The caveat B1 should carry instead

B1's *spirit* is not met. The paragraph's complaint is that "symmetry fixes every equivariant quantity before criticality is consulted", and this point is homogeneous with $\mathrm{Stab}(W)^\circ\supseteq SO(3)\cdot U(1)$ (the $U(1)$ being the centre of $U(3)$, which centralises $\mathfrak{su}(3)$ and so fixes both eigenspaces), $\dim\ge4$ out of $15$. $W$ is determined by its isotropy representation up to two scalars, which trace and norm then fix. **So B1 should be restated:** what is owed is not "irreducible and non-symmetric" (that is on file) but a critical point whose stabiliser does not already determine it, i.e. one with $\dim\mathrm{Weyl}_n^{\mathrm{Stab}(W)}$ large. As written, B1 asks for something the record holds and will be satisfiable without supplying what it exists to supply.

### One smaller label defect, uncovered by the above

[target.md](../findings/target.md) calls this "the $(\mathfrak{su}(m),\mathfrak{so}(m))$ **Kähler** family". At $m=2$ that is right ($W_{\mathbb{CP}^2}$). At $m=3$ the member is *nearly* Kähler and not Kähler. The family label is correct only at its first member.

---

## CLAIM 2, conclusion survives, mechanism and numbers do not

### The isotropy-product step is right, and needs no numbers

Let $W=\sum_i c_iW_i$ on $\mathbb R^N=\bigoplus_i V_i$, $c_i\ne0$, each $W_i\ne0$. Any $g\in\mathrm{Stab}(W)$ permutes the eigenspaces of $W$; each nonzero eigenspace lies in some $\Lambda^2V_i$ and spans $V_i$, so $g$ permutes the $V_i$ and fixes each when the blocks are pairwise distinct. Hence $\mathrm{Stab}(W)^\circ=\prod_i\mathrm{Stab}_{SO(n_i)}(W_i)^\circ$ and $\dim\mathrm{Stab}=\sum_is_i$. **Confirmed.**

The decay then needs no sequence at all:
$$\frac{\dim\mathrm{Stab}}{\dim\mathfrak{so}(N)}=\frac{\sum_i s_i}{\binom I2}\le\frac{\sum_i n_i(n_i-1)}{N(N-1)}\le\frac{\max_i n_i-1}{N-1}\xrightarrow[k\to\infty]{}0 .$$
One line, unconditional, and it makes the tabulated sequence decorative.

### The sequence itself has no artefact, and its last entry does not reproduce

Commit `0380f5e` touched **plan.md only**, no findings file, no script. The natural reading (balanced sphere products at $n=6,8,10,12,14$, stabilisers $\mathfrak{so}(k)^{\oplus2}$ of dimensions $6,12,20,30,42$, cumulative $N=6,14,24,36,50$) gives

$$\tfrac6{15}=0.400,\quad\tfrac{18}{91}=0.198,\quad\tfrac{38}{276}=0.138,\quad\tfrac{68}{630}=0.108,\quad\tfrac{110}{1225}=\mathbf{0.0898},$$

against the recorded $0.40,\ 0.20,\ 0.14,\ 0.11,\ \mathbf{0.097}$. The first four agree; the fifth is off by $8\%$. *A number is used here only to test whether the recorded sequence reproduces, and it cannot be settled by argument because the block list was never written down.* **Flag it as unsourced rather than wrong**, but the record's own standing rule ("a number its own script cannot reproduce is not a number", [plan.md](../plan.md) §10) applies, and the derivation above means the sequence can simply be deleted.

### The scale-invariance citation is over-extended

Reviewer 127 ([REVIEW_r127.md](REVIEW_r127.md) line 70) established one thing: $c_i=\lambda/\lambda_i$ makes $\mu/\lambda=\mu_i/\lambda_i$, so **verdicts that are functions of the normalised spectrum** are inherited blockwise. That covers "is $\lambda_{\max}$ the Einstein constant", which is what r127 was testing. It does **not** cover "is the point a symmetric space", "is it irreducible", or "is it graded", gradedness is inherited, but by a different argument ($S$ is cubic, so $S(\sum c_iW_i)=\sum c_i^3S(W_i)$ with $c_i>0$). The plan promotes a spectral-ratio statement into a claim about all verdicts and attributes the promotion to r127.

The conclusion nonetheless holds, and for a reason that needs no citation at all: **a $\perp$-sum is reducible by construction, and B1 as sharpened demands irreducibility.** The route is closed by definition-chasing, one line, and the r127 machinery is not load-bearing.

### "Reducibility is itself a strong symmetry", **DISAGREE, as stated it is backwards**

The same paragraph argues (a) the isotropy fraction $\to0$, "so the orbit approaches all of $O(n)$" (*little* symmetry) and (b) "reducibility is itself a strong symmetry", *too much* symmetry. Both cannot be read the same way, and the paragraph does not distinguish them.

The brief asks for a quantity a $\perp$-sum does **not** fix but an irreducible symmetric point does. **There is one, and it is central:** the relative block scales. At unpadded $\mathbb{CP}^m$, $\dim\mathrm{Weyl}_n^{\mathfrak k(W)}=1$ ([target.md](../findings/target.md) line 456), so symmetry determines the point outright and criticality is never consulted. At a $\perp$-sum of $k$ distinct blocks, $\mathrm{Weyl}_N^{\mathrm{Stab}}$ contains a $k$-parameter family of scalings, and **the harmonic-square law $1/\theta^2=\sum_i1/\theta_i^2$ is precisely criticality doing non-trivial work that symmetry did not already do.** So a $\perp$-sum is *less* symmetry-determined than an irreducible symmetric point, not more.

The defensible statement is narrower and should replace the current one: *a $\perp$-sum carries a distinguished orthogonal decomposition that block-diagonalises every equivariant tensor, so every spectral-ratio verdict is inherited from the blocks unchanged.* That is true, it is what r127 proved, and it does not contradict the isotropy fraction going to zero.

---

## CLAIM 3, CONFIRMED, and the Casimir step generalises to a clean theorem

### The two-eigenvalue step is exact

$W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ has eigenvalues $c(1-\tfrac rN)$ on $\mathfrak h$ and $-c\tfrac rN$ on $\mathfrak m$. For $0<r<N$ and $c\ne0$ both eigenspaces are nonempty and the values differ. **Exactly two, and (worth stating, because it shortens two of the three witnesses), neither is zero.** So *any* graded critical point with a kernel is instantly not a Casimir, without counting.

### The three witnesses

| witness | $n$ | why not a Casimir | needed? |
|---|---|---|---|
| $\mathbb{CP}^3$ | $6$ | three eigenvalues (Petersen–Stanfield Prop. 2.2: $R$'s eigenspaces are $\mathfrak h_0\oplus\mathfrak h_1=\mathfrak u(1)\oplus\mathfrak{su}(3)$, plus the complement) | redundant, sits at $\theta_0(6)<\sqrt{3/2}$ |
| $\sqrt{6/5}$ point | $6$ | $\dim\ker W=7>0$, so not a Casimir by the kernel alone | redundant, and the **weakest**: [graded-half.md](../findings/graded-half.md) line 328 concedes it carries "$S=0$ **only**", i.e. gradedness is uncertified; line 330 notes the cap $r\le n(n-2)/4$ reaches it at $n=6$ anyway |
| $S^5\times S^7$ | $12$ | three eigenvalues, **proved below**; graded as a product of symmetric spaces, with $(\mathfrak{so}(12),\mathfrak{so}(5){+}\mathfrak{so}(7))$ a symmetric pair | **suffices alone** |

**Yes, witness 2 is the same point as Claim 1's.** So the item rests on two independent points, not three.

### An unconditional replacement for the $S^5\times S^7$ argument

The plan's stated ground for this witness is a $\theta$-value mismatch ($\theta=1.2282390$ against the family's $1.2742878$ at $r=31$), which only excludes the Casimir of *that* subalgebra. The eigenvalue count does better, and holds for the whole family. For $M=S^p(k_1)\times S^q(k_2)$, $n=p+q$, $a_1=(p-1)k_1$, $a_2=(q-1)k_2$, $s=\mathrm{scal}/((n-1)(n-2))$, the Weyl operator is scalar on three blocks:
$$A=k_1-\tfrac{2a_1}{n-2}+s\ \ (\Lambda^2\mathbb R^p),\qquad B=k_2-\tfrac{2a_2}{n-2}+s\ \ (\Lambda^2\mathbb R^q),\qquad C=-\tfrac{a_1+a_2}{n-2}+s\ \ (\text{mixed}).$$
Then $A=C\iff k_1(q-1)=-k_2(q-1)\iff k_1=-k_2$, impossible for round spheres; symmetrically $B\ne C$; and $A=B\iff(q-p)(k_1+k_2)=0\iff p=q$.

**Theorem (free): the Weyl operator of $S^p\times S^q$ has exactly three distinct eigenvalues whenever $p\ne q$, and exactly two when $p=q$**, for every pair of positive curvatures, no criticality needed. This proves the whole "every unbalanced sphere product is graded and off the family" claim ([plan.md](../plan.md) line 95) in three lines, and explains why the *balanced* product is the one Casimir.

### The threshold, exactly

Using the record's own product law $\lVert W\rVert^2=\sum_af(n_a)-\frac n{8(n-1)}$ with $f(m)=\frac m{8(m-1)}$ and $\theta=1/(2\lVert W\rVert)$ at sphere products ([response.md](../response.md) Lemma L48):
$$\lVert W\rVert^2=\tfrac5{32}+\tfrac7{48}-\tfrac3{22}=\tfrac{175}{1056},\qquad \theta^2=\frac{1056}{700}=\boxed{\tfrac{264}{175}}=1.5085714,\quad\theta=1.2282392 .$$
This reproduces the recorded $1.2282390$ and gives the margin as an exact rational: $\tfrac{264}{175}-\tfrac32=\tfrac3{350}>0$. **The witness is above $\sqrt{3/2}$ by an exact amount, so the threshold-restricted form of item 1 is genuinely dead.** Sanity cross-check of the same formula at the balanced split: $2f(6)-\tfrac3{22}=\tfrac9{55}$, giving $\theta_0(12)^2=\tfrac{55}{36}$ ✓.

**Claim 3 CONFIRMED. $S^5\times S^7$ alone carries it; the other two witnesses are redundant and one of them is the record's weakest entry.**

---

## Question (a), three things asserted as new that the record already held

1. **The B1 discrepancy itself.** [bounds.md](../findings/bounds.md) line 129 and [graded-half.md](../findings/graded-half.md) line 346 both predate commit `0da462f` and both state the resolution. Worse, **the discrepancy is self-refuting inside one file**: [graded-half.md](../findings/graded-half.md) raises it at line ~322 and answers it at line 352 ("The value $\sqrt{6/5}$ coincides with the $\mathfrak{su}(3)$ Kähler point already in the enumeration"), 30 lines apart, in text that was already there.
2. **The $Q_3$ label.** Struck by Reviewer 80 and recorded three times in [target.md](../findings/target.md) (lines 369, 434, 436). Reading line 375 as live re-opens a closed question.
3. **The subalgebra conclusion, a third time.** `9f85f84` ("the graded critical set is strictly wider than the subalgebra family") and `c655487` ("the subalgebra route to (H) is closed at every threshold") are the same result; `f358f5f` then walked back one of its three witnesses. The brief anticipated "twice"; the commit log shows three passes.

## Question (b), the reading is literally right, but two zeros are artefacts and one row is unscored

- **Item 5 (degree-six SOS) has no grade**, only "handed off" with `closes = 3` and both other factors dashed. So "**every** section 1 item now scores $0$" is false for one of five rows. It matters, because [plan.md](../plan.md) line 36 names this exact route as *"the one route that structurally cannot"* fall into the record's diagnosed failure mode. It is off the board for being numerics-first (a stated preference) rather than for any defect. **That is an item removed too eagerly.**
- **Numbering collision:** line 36 calls the degree-six SOS "item 3"; the table calls it item 5, and item 3 is "the target $\sup\theta\le\sqrt{3/2}$". Two different items are called item 3 within thirty lines.
- **Items 2, 3, 4 score $0$ on `margin` because equality is attained.** Conjecture A *is* sharp, at $W_{\mathbb{CP}^2}$ and at $S^{n/2}\times S^{n/2}$. A multiplicative rubric with a `margin` factor therefore zeroes the conjecture itself and everything implying it, permanently and by construction. Item 3 **is** the goal. "Every item scores $0$, so work section 2" is a fact about the rubric, not about the items.
- **Item 1's zero is sound**, it is a closed *route*, and Claim 3 above confirms the closure. Note that (H) itself is untouched: $S^5\times S^7$ **is** a sphere product, so it refutes the Casimir classification while being fully consistent with (H).

## What I would change

1. **Delete the discrepancy box** in [graded-half.md](../findings/graded-half.md) and the "FIRST, resolve a discrepancy" paragraph in [plan.md](../plan.md) §2. Replace with: *the $\sqrt{6/5}$ point is one operator; $(\mathfrak{su}(3),\mathfrak{so}(3))$ names its graded structure inside $\mathfrak{so}(6)$ at $n=2m=6$, and Jensen's nearly-Kähler $S^3\times S^3$ names a non-symmetric Einstein manifold realising it. $\widetilde G_2(\mathbb R^5)$ was struck by Reviewer 80.*
2. **Record B1 as answered in its letter and restate it.** The owed object (irreducible, not a symmetric space), is on file. What is actually owed is a critical point not determined by its own stabiliser.
3. **Replace the isotropy sequence** with the one-line bound $\dim\mathrm{Stab}/\dim\mathfrak{so}(N)\le(\max_in_i-1)/(N-1)$; the sequence has no artefact and its fifth entry does not reproduce.
4. **Restate "reducibility is a strong symmetry"** as the narrower true claim about a distinguished block decomposition and inherited spectral ratios, and drop the over-extended r127 citation.
5. **Drop witnesses 1 and 2 from item 1**, keep $S^5\times S^7$, and replace its $\theta$-mismatch ground with the three-eigenvalue theorem for $p\ne q$ proved above.
6. **Fix the "every item scores 0" line and the item-3/item-5 numbering**, and note that `margin` is structurally zero on a sharp conjecture.

## Debts I did not discharge

The $0.097$ entry cannot be checked against an artefact because none exists. I did not verify $\mathbb{CP}^3$'s three eigenvalues independently of Petersen–Stanfield Proposition 2.2; the citation is sufficient for the use made of it, and the witness is redundant anyway.
