# REVIEW_r618, Lemma L106 (independent adversarial audit)

**Reviewer** r618. **Target**: [Lemma L106, the zero-defect set is exactly where every positive eigenvector is an infinitesimal symmetry](../findings/bounds.md), heading at [bounds.md:106](../findings/bounds.md), statement at [bounds.md:108](../findings/bounds.md), evidence section [bounds.md:110–126](../findings/bounds.md).

**Footing.** Analysis only. Every derivation below is by hand on objects I constructed for the purpose. I ran no script, no sweep, no search and no census, in particular I did not re-run [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py), whose table the block prints; I read its source to determine what its columns *are*, which is a reading and not a run. I did not read the co-reviewer's report or log.

**Overall verdict: CONFIRMED, and the biconditional is a restatement, not a theorem.** Both directions are immediate from the definition, both bracket relations follow, and every one of the ten numeric rows passes the dimension identity. Four defects sit around the true core, one of them load-bearing for a downstream file:

| # | where | severity |
| --- | --- | --- |
| **D1** | the third bracket relation is asserted one clause before its hypothesis arrives, [bounds.md:108](../findings/bounds.md) | wording; the block's own next clause repairs it |
| **D2** | "so there $\mathfrak p$ **is** $\mathfrak k(W)$" does not follow from the table, the `isotropy` column is a hard-coded constant, not a measured $\dim\mathfrak k(W)$ | GAP; the claim is true, by an argument nobody has written down |
| **D3** | [ATTEMPTS.md:2154](../ATTEMPTS.md) states the reduction **without** $\ker W=0$, the repair applied in [bounds.md](../findings/bounds.md) never propagated | real, and the script's docstring says this exact omission already cost a Gate 2 |
| **D4** | "step **H**" has no definition anywhere on the record | unresolved pointer; the Lemma's stated payoff is uncheckable |

---

## 0. Fixing the senses before deriving

[conventions.md](../findings/conventions.md) warns that $\mathfrak m$ carries three incompatible senses. Which one is in force here is settled by the table, not by the block:

| symbol | sense in force at L106 | how it is pinned |
| --- | --- | --- |
| $g_\delta$ | $\lVert[\mathrm{ad}(v_\delta),W]\rVert^2$, the [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7 density | [diagonal-half.md:88](../findings/diagonal-half.md), quoted correctly |
| $\Delta$ | the trace of $g$ over the **strictly** positive eigenspace | [conventions.md](../findings/conventions.md) ("traced over $\{\lambda>0\}$ only") |
| $\mathfrak p$ | $\operatorname{span}\{v_a:\lambda_a>0\}$, the positive eigenspace **of $W$ itself** | never stated in the block; forced by $\dim\mathfrak m+\dim\ker+\dim\mathfrak p=\binom n2$ in every row |
| $\mathfrak m$ | the **whole** negative eigenspace, [L36](../findings/isotropy-cap.md)'s sense, **not** [conventions.md](../findings/conventions.md)'s $\mathfrak m=E_{\min}$ | same row arithmetic; under $E_{\min}$ the columns would not close |
| $\mathfrak k(W)$ | $\{x\in\mathfrak{so}(n):[\mathrm{ad}(x),W]=0\}$, the isotropy algebra | [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py) header; no findings file defines it |
| $S$ | $S_{\mathfrak{mmm}}=\sum_{a,b,c\in\mathfrak m}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2$ | defined in-block, matching [ungraded-slack.md:81](../findings/ungraded-slack.md) |

*Two of these are pinned only by the table's arithmetic.* A reader who takes $\mathfrak m=E_{\min}$ from [conventions.md](../findings/conventions.md) gets a **false** corollary as soon as $W$ has two distinct negative eigenvalues, since $\mathfrak p\oplus E_{\min}$ is then not all of $\mathfrak{so}(n)$ even at trivial kernel. The block should say "the whole negative eigenspace" once.

*One collision worth naming*: $S$ here is a structure-constant sum, while [conventions.md](../findings/conventions.md)'s tabled $S(W)$ is [ungraded-slack.md](../findings/ungraded-slack.md)'s **compression** slack $S=T_1+2T_2+T_3$, a different object. The block defines its $S$ in place, so it is self-contained; the phrase "on $\{S=0\}$" is not, and it recurs in [bounds-relaxations.md:38](../findings/bounds-relaxations.md) and [ATTEMPTS.md:2154](../ATTEMPTS.md) with no local definition.

---

## 1. The biconditional, CONFIRMED, and it is a restatement

**Derivation, cold.** $x\mapsto\mathrm{ad}(x)$ is linear and $A\mapsto[A,W]$ is linear, so
$$G(x):=\lVert[\mathrm{ad}(x),W]\rVert^2$$
is the squared norm of a linear map of $x$: a **positive semi-definite quadratic form on $\mathfrak{so}(n)$**. Its trace over a subspace is therefore basis-independent, and
$$\Delta(W)=\operatorname{tr}\big(G\vert_{\mathfrak p}\big)=\sum_{\delta}g_\delta$$
over any orthonormal basis of $\mathfrak p$, the eigenbasis included. For a psd form, $\operatorname{tr}(G\vert_{\mathfrak p})=0\iff G\vert_{\mathfrak p}\equiv0$: ($\Leftarrow$) trivial; ($\Rightarrow$) a sum of non-negative terms vanishes iff each vanishes, and vanishing on a basis extends to the span because $x\mapsto[\mathrm{ad}(x),W]$ is linear, not merely because $G$ is. Hence
$$\Delta(W)=0\iff[\mathrm{ad}(x),W]=0\ \forall x\in\mathfrak p\iff\mathfrak p\subseteq\mathfrak k(W).\qquad\blacksquare$$

**The index sets do agree, which was the brief's leading suspicion.** $\Delta$ sums $g_\delta$ over $\delta$ in an orthonormal basis of $\mathfrak p$, the script's `g[p].sum()` with `p = lam > tol`, and the statement quantifies over $x\in\mathfrak p$. Same set. **No defect here.**

**The prose gloss matches the formula.** "Every positive eigenvector of $W$ is an infinitesimal symmetry of $W$" is the vanishing of $G$ on a spanning set of eigenvectors; linearity makes that equivalent to vanishing on $\mathfrak p$. And "$\mathfrak p$" is the positive eigenspace of $W$ itself, not a positive part of some other operator, so the gloss is faithful. *One subtlety it glosses over and gets right anyway*: under $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, the derivation induced on $\Lambda^2$ by $x\in\mathfrak{so}(n)$ **is** $\mathrm{ad}(x)$, so the two possible readings of $\mathrm{ad}$ coincide and no ambiguity is live.

**What the Lemma adds beyond "a sum of squares vanishes iff each term does": nothing, and that is worth stating plainly.** The only content past the sum-of-squares observation is *basis-independence*, that $\Delta$ is the trace of a quadratic form, so its vanishing controls all of $\mathfrak p$ and not just the eigenbasis. That step is one line. **The Lemma is a definitional identification of the set $\{\Delta=0\}$, not a theorem about it.** It should be cited for what $\Delta=0$ *means*, never as evidence that the set is small, rare, or free of rivals, and the same file already refutes the rarity reading directly ([bounds.md:92](../findings/bounds.md): "a $\Delta=0$ point in the band is not rare, it is catalogued").

*Screen of the underlying expansion* (hand algebra, recorded as a screen): with $\mathrm{ad}(v_\delta)v_a=\sum_bc_{\delta ab}v_b$,
$$[\mathrm{ad}(v_\delta),W]v_a=\sum_b c_{\delta ab}(\lambda_a-\lambda_b)v_b\ \Longrightarrow\ g_\delta=\sum_{a,b}(\lambda_a-\lambda_b)^2T_{\delta ab},$$
which reproduces the script's displayed identity character for character. So $\Delta=0$ says $T_{\delta ab}=0$ whenever $\lambda_a\ne\lambda_b$ and $\delta\in\mathfrak p$, the eigenspace-preservation statement, read off the tensor.

---

## 2. The consequence: two of the three grading relations, and where the third comes from

**Arrow 1, commuting implies preserving eigenspaces. CONFIRMED.** If $[\mathrm{ad}(x),W]=0$ and $Wv=\lambda v$, then $W(\mathrm{ad}(x)v)=\mathrm{ad}(x)Wv=\lambda\,\mathrm{ad}(x)v$, so $\mathrm{ad}(x)E_\lambda\subseteq E_\lambda$. One line, and it needs nothing about $W$ beyond that it is an operator.

**Arrow 2, the bracket containments. CONFIRMED, and the block understates them.** $\mathfrak p$, $\mathfrak m$ and $\ker W$ are each sums of eigenspaces, so for $x\in\mathfrak p$:
$$[\mathfrak p,\mathfrak p]\subseteq\mathfrak p,\qquad[\mathfrak p,\mathfrak m]\subseteq\mathfrak m,\qquad[\mathfrak p,\ker W]\subseteq\ker W.$$
The third of these is free and the block does not state it, though it is exactly what governs the padded points it goes on to discuss. Also free: $\mathfrak k(W)$ is a subalgebra, so $\mathfrak p\subseteq\mathfrak k(W)$ gives $[\mathfrak p,\mathfrak p]\subseteq\mathfrak k(W)$ as well, the brief's alternative reading. Both hold; $\subseteq\mathfrak p$ is the stronger and is what is written, so **what is written is what follows.**

**The count the brief asks for: the Lemma delivers TWO of the three grading relations.** With $\mathfrak h:=\mathfrak p$ and the odd part $\mathfrak m$, it gives $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ and $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$. It gives **nothing whatever** about $[\mathfrak m,\mathfrak m]$, every relation it produces has an $x\in\mathfrak p$ in it, so the pure-$\mathfrak m$ relation is out of its reach by construction. That third relation is imported from $S_{\mathfrak{mmm}}=0$, which is a hypothesis and not a consequence.

**D1, the third relation is asserted one clause before its hypothesis.** [bounds.md:108](../findings/bounds.md) reads

> Since $S:=S_{\mathfrak{mmm}}=0$ says exactly $[\mathfrak m,\mathfrak m]\perp\mathfrak m$, the third relation $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$ **follows**.

As written this is **false**. $S=0$ gives $[\mathfrak m,\mathfrak m]\subseteq\mathfrak m^\perp=\mathfrak p\oplus\ker W$, and the passage to $\mathfrak p$ needs $\ker W=0$. The block supplies that hypothesis in the *next* sentence ("So on $\{S=0\}$ with trivial kernel…"), where a reader may reasonably attach it to "$\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m$" alone. **The script's own docstring gets the attachment right** ("gives the third relation `[m, m] contained in p` **PROVIDED** `ker W = 0`") and records that the omission has already cost a Gate 2 ("`ker W = 0` IS LOAD-BEARING AND WAS OMITTED HERE. Gate 2, both reviewers"). *So the record is weaker than its own script at the one point the script says was already paid for.* Repair: move "provided $\ker W=0$" into the sentence that asserts the third relation. Not a refutation of the Lemma, the corollary as finally stated carries both hypotheses.

**The corollary, stated correctly, is CONFIRMED.** Let $\Delta(W)=0$, $S_{\mathfrak{mmm}}=0$ and $\ker W=0$. Then $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m$ orthogonally (eigenspaces of a symmetric operator, kernel empty), $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$, $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak m^\perp=\mathfrak p$. Three relations, so a $\mathbb Z_2$-grading. $\blacksquare$

**And the hypothesis excludes the point that sets the threshold.** $W_{\mathbb{CP}^2}$ at $n=4$ has $\dim\ker=3$, so the grading corollary says nothing there, while $\mathbb{CP}^2$ is the point carrying $\theta=\sqrt{3/2}$, the very threshold in "does $\theta>\sqrt{3/2}$ force $\Delta=0$?". The script's docstring shouts this ("**AND THE CONSEQUENCE EXCLUDES CP² ITSELF**"); **the findings block never says it.** The block's CP² sentence discusses only $\mathfrak p\subsetneq\mathfrak k(W)$ and concludes "the containment, which is all the lemma uses, still holds", true of the *Lemma*, silent about the *corollary*, which is the part with consumers.

---

## 3. The label, and the table

**Proven, not measured, and the `Lemma` label is right.** Section 1 is a complete proof requiring no hypothesis at all, and section 2 is a complete proof under two stated hypotheses. Nothing in either rests on a number. **The table is a consistency check, and the block should say so**, because the heading at [bounds.md:110](../findings/bounds.md), `Measured ([b_symmetry_defect.py]), Gate 1`, sits at the *same* `####` level as the Lemma heading and immediately beneath it, so on the record's literal reading a proven statement appears to be resting on a Gate 1 table.

*This is a loss introduced by a rename, and the provenance checks out.* The [LEDGER](../findings/LEDGER.md) records that the block "declared its own debt in its heading, *proved, two lines; Gate 2 owed*". **Verified against history**, not assumed: `git log -S'proved, two lines'` reaches `4c300e3c` (*docs(bounds): place headings for fence posts 15-21 and 28*, 2026-09-02), whose diff is exactly

```
-#### Lemma (proved, two lines; Gate 2 owed)
+#### Lemma 106, the zero-defect set is exactly where every positive eigenvector is an infinitesimal symmetry
```

and `085d2c53` carries the same account in its commit body. **The ledger's note is accurate, one of the clean ones.** But the numbering dropped the words "proved, two lines", and **nothing in the present block says the biconditional is proved rather than measured.** Restoring three words fixes it.

**The dimension identity: all ten numeric rows PASS.** $\dim\mathfrak m+\dim\ker+\dim\mathfrak p$ against $\binom n2$:

| row | $n$ | sum | $\binom n2$ | |
| --- | --- | --- | --- | --- |
| $S^6\times S^6$ | 12 | $36+0+30$ | 66 | ok, and $36=6\cdot6$, $30=\dim(\mathfrak{so}(6)^{\oplus2})$ |
| $S^5\times S^7$ | 12 | $35+0+31$ | 66 | ok, $35=5\cdot7$, $31=10+21$ |
| $S^4\times S^8$ | 12 | $32+0+34$ | 66 | ok, $32=4\cdot8$, $34=6+28$ |
| $S^3\times S^3$ | 6 | $9+0+6$ | 15 | ok, $9=3\cdot3$, $6=3+3$ |
| $\mathbb{CP}^2$ | 4 | $2+3+1$ | 6 | ok |
| $\mathbb{CP}^3$ | 6 | $6+0+9$ | 15 | ok, $9=\dim\mathfrak u(3)$ |
| $\mathbb{CP}^4$ | 8 | $12+0+16$ | 28 | ok, $16=\dim\mathfrak u(4)$ |
| $\mathbb{CP}^2$ padded | 8 | $2+25+1$ | 28 | ok |
| $S^3\times S^3$ padded | 8 | $9+13+6$ | 28 | ok |
| $C_5$ blow-up | 10 | $20+0+25$ | 45 | ok |

The `random Weyl` row carries dashes and is not checkable; it is labelled as a range, so that is honest.

**The $\mathbb{CP}^2$ row: the isotropy column *may* exceed $\dim\mathfrak p$, and here it must.** Derived by hand, using nothing from the block. $W_{\mathbb{CP}^2}$ is self-dual: $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$, $W=W^+\oplus0$ with $W^+$ of spectrum proportional to $(2,-1,-1)$. Hence $\dim\mathfrak p=1$, $\dim\mathfrak m=2$, $\dim\ker=3$, the row. For $x=x^++x^-\in\mathfrak{so}(4)=\mathfrak{su}(2)^+\oplus\mathfrak{su}(2)^-$: $\mathrm{ad}(x)$ preserves the $\Lambda^\pm$ split, $\mathrm{ad}(x^-)$ kills $\Lambda^+$, and $W$ kills $\Lambda^-$; so $[\mathrm{ad}(x),W]=0$ reduces to $[\mathrm{ad}(x^+)\vert_{\Lambda^+},W^+]=0$, whose solutions are the $\mathfrak{so}(2)$ fixing the $+2$ eigenvector. Therefore
$$\mathfrak k(W_{\mathbb{CP}^2})=\mathfrak{so}(2)\oplus\mathfrak{su}(2)^-,\qquad\dim=1+3=4\cong\mathfrak u(2).$$
So $4$ is right, $\mathfrak p\subsetneq\mathfrak k(W)$ is right, and **the column can exceed $\dim\mathfrak p$ whenever $W$ has a kernel or a repeated eigenvalue**, $\mathfrak k(W)$ is the full stabiliser and sees $\ker W$ and $\mathfrak m$ too, while $\mathfrak p$ is one eigen-block.

**D2, but the column is not measuring $\mathfrak k(W)$, and the block's inference needs it to.** [bounds.md:126](../findings/bounds.md) argues: $\dim\mathfrak p$ equals the isotropy dimension at six rows, "so there $\mathfrak p$ **is** $\mathfrak k(W)$." That inference is valid only if the column *is* $\dim\mathfrak k(W)$. Reading [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py)'s `main()`, the value is **hard-coded per row** (`sum(b*(b-1)//2 for b in blocks)` for the sphere products, `m*m` for $\mathbb{CP}^m$), a quoted $\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))$ and $\dim\mathfrak u(m)$, passed in as the literal `iso` and printed unchanged. **No $\dim\mathfrak k(W)$ is computed anywhere in the script.** What the table therefore supports is $\dim\mathfrak p=\dim(\text{quoted isometry algebra})$, which with $\mathfrak p\subseteq\mathfrak k(W)$ yields only $\dim\mathfrak p\le\dim\mathfrak k(W)$, the containment, not the equality.

*The conclusion is nonetheless true, by an argument the record does not carry.* $\mathfrak k(W)$ consists of the $x$ whose $\mathrm{ad}(x)$ preserves every eigenspace; since $\mathfrak p$ and $\mathfrak m$ are unions of eigenspaces, $\mathfrak k(W)\subseteq\mathfrak n_{\mathfrak{so}(n)}(\mathfrak p)$. For $\mathfrak p=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and for $\mathfrak p=\mathfrak u(m)$ the normaliser is the subalgebra itself, so $\mathfrak k(W)\subseteq\mathfrak p$; the reverse containment is $\Delta=0$. Hence $\mathfrak p=\mathfrak k(W)$ at those six rows. **One sentence, and it replaces a table column that cannot carry the claim.** *The script's docstring makes the same slip in the other direction*, writing of $\mathbb{CP}^2$ that "`dim k(W) = dim u(2) = 4`, the printed table shows it", when the printed $4$ is the constant its author typed. No number is wrong; the warrant is.

**The $\Delta$ column's zeros are entailed, not independently measured.** At the six symmetric rows, $W$ is invariant under the isometry group, so its isotropy algebra is contained in $\mathfrak k(W)$; combined with the spectral sign pattern that makes $\mathfrak p$ that same algebra, $\Delta=0$ **follows** and is not evidence. At the two padded rows, $\Delta=0$ is forced by the $\{\lambda>0\}$ convention, as the block itself argues at [bounds.md:104](../findings/bounds.md). **The only genuinely measured entries in the $\Delta$ column are $\mathbf{12}$ at the $C_5$ blow-up and the random-Weyl row**, which is precisely the block's point at [bounds.md:128](../findings/bounds.md), that criticality does not force $\Delta=0$.

**The $S_{\mathfrak{mpp}}$ column is entailed by the $\Delta$ column and carries no independent information.** $\Delta=0\Rightarrow[\mathfrak p,\mathfrak p]\subseteq\mathfrak p\Rightarrow\langle[\mathfrak p,\mathfrak p],\mathfrak m\rangle=0\Rightarrow S_{\mathfrak{mpp}}=0$, by the Lemma being audited. So every $0$ in the last column is a corollary of the $0$ beside it; the column checks the script against the Lemma, not the Lemma against the world. Only the $C_5$ row is informative, and there it runs the safe way: $S_{\mathfrak{mpp}}=80\ne0$ forces $\Delta>0$, observed $12$. **This is exactly what "the table is a consistency check" means here, and it is the strongest reading available.**

**A column the table needs and does not have.** The grading corollary's hypothesis is $S_{\mathfrak{mmm}}=0$. The script computes it and prints it; **the findings table drops it** in favour of $S_{\mathfrak{mpp}}$. So no row of the printed table lets a reader check the corollary's hypothesis anywhere, it has to be fetched from prose elsewhere in the file. Restoring the $S_{\mathfrak{mmm}}$ column would cost one column and close the gap.

---

## 4. Scope, and what consumes it

**Scope of the biconditional: every $n$, every $W$, no hypotheses.** It needs only that $W$ be a symmetric operator on $\Lambda^2\mathbb R^n$; criticality, the Weyl symmetries, the Bianchi identity and the splitting are all unused. It is not restricted to where "the splitting is defined", the splitting $\mathfrak{so}(n)=\mathfrak p\oplus\ker W\oplus\mathfrak m$ is the spectral decomposition and always exists. *What is discontinuous is $\Delta$ itself*, at eigenvalue zero-crossings ([conventions.md](../findings/conventions.md)), so the *set* $\{\Delta=0\}$ is not closed; the equivalence holds pointwise regardless.

**Scope of the corollary: two extra hypotheses, and they bite.** $S_{\mathfrak{mmm}}=0$ and $\ker W=0$. Of the eleven rows, three fail the kernel condition outright ($\mathbb{CP}^2$ and both padded points), and the padded $\mathbb{CP}^2$ is the recorded witness that without it only "$\mathfrak p\oplus\mathfrak m$ is a graded **subalgebra**" survives, at $n=8$ all three relations hold on a $3$-dimensional $\mathfrak{su}(2)$ inside a $28$-dimensional $\mathfrak{so}(8)$, with $25$ kernel directions unassigned and $[\mathfrak z,\mathfrak z]\to\mathfrak m=16$.

**What consumes it, and whether it supports what it is asked for:**

| consumer | uses | verdict |
| --- | --- | --- |
| the dimension screen, [bounds.md:88](../findings/bounds.md) | $\Delta=0\Rightarrow\mathfrak p\subseteq\mathfrak k(W)$, giving $\dim\mathcal O\le\dim\mathfrak m+\dim\ker W$ | **sound.** $\dim\mathcal O=\binom n2-\dim\mathfrak k(W)\le\binom n2-\dim\mathfrak p$, which is the right-hand side. Uses only the containment |
| the reduction to step **H**, [bounds.md:108](../findings/bounds.md) | the full corollary | sound as stated there, both hypotheses present |
| [ATTEMPTS.md:2154](../ATTEMPTS.md) | the same reduction | **D3, defective**, see below |
| [target.md:530](../findings/target.md) | "$\mathbb{CP}^m$ for $m\ge3$ has $\Delta=0$, $G_0=0$, $\ker W=0$ and $S=0$, hence is graded by this record's own lemma" | **sound**, it names $\ker W=0$ explicitly, which is what [ATTEMPTS.md](../ATTEMPTS.md) omits |
| the open question "does $\theta>\sqrt{3/2}$ force $\Delta(W)=0$?" | the *meaning* of $\Delta=0$ | fine as a question; the Lemma contributes no bound to it |

**D3, the repair did not propagate.** [ATTEMPTS.md:2154](../ATTEMPTS.md) reads:

> $\Delta=0$ makes $\mathrm{ad}(x)$ preserve every eigenspace of $W$ for $x\in\mathfrak p$, hence $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$ and $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$; with $S=0$ supplying $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$, $W$ is graded.

**$\ker W=0$ appears nowhere in it**, and it is headed "The reduction, **proved**". Padded $W_{\mathbb{CP}^2}$ at $n=8$ satisfies every hypothesis this sentence lists ($\Delta=0$, $S_{\mathfrak{mmm}}=0$) and $\mathfrak{so}(8)$ is not $\mathbb Z_2$-graded by $\mathfrak p\oplus\mathfrak m$, which is only $3$-dimensional. **That is a witness against the sentence as written, and it is already on the record**, in the same script's docstring, flagged as a Gate 2 finding. [bounds.md](../findings/bounds.md) was repaired; [ATTEMPTS.md](../ATTEMPTS.md) was not.

*Second-order note on the same sentence*: "the band splits into a half step H already handles and a half, $\Delta>0$, that is **the whole remaining problem**". Since the $n=8$ witness is **graded with $\Delta=1.512$** ([bounds.md:140](../findings/bounds.md)), the $\Delta>0$ set strictly contains the ungraded set. The sentence therefore over-states the remainder rather than under-stating it, safe as an upper bound on what is left, wrong as a description of it, and it is the same invalid-converse reading that [target.md:530](../findings/target.md) has already withdrawn once.

**D4, "step **H**" resolves to nothing.** It is invoked at [bounds.md:108](../findings/bounds.md), [bounds-relaxations.md:38](../findings/bounds-relaxations.md), [bounds-relaxations.md:312](../findings/bounds-relaxations.md), [target.md:530](../findings/target.md) and [ATTEMPTS.md:2154](../ATTEMPTS.md), and **no file on the record defines it.** [routes.md](../routes.md) numbers its routes R12, R17, …; [plan.md](../plan.md) numbers items I2, I8, I33, …; neither carries a lettered step scheme, and [bounds-relaxations.md:38](../findings/bounds-relaxations.md) additionally names a "step (G)" that is equally undefined. So the Lemma's entire stated payoff (*the $\Delta=0$ half is already handled*), points at machinery a reader cannot locate, and cannot confirm handles anything.

**Naming a set is not bounding it, and the block is on the right side of that line.** L106 identifies $\{\Delta=0\}$ with $\{\mathfrak p\subseteq\mathfrak k(W)\}$ and, under two further hypotheses, routes it to the graded case. It says **nothing** about the size of the set, and the same file records the set as populous in the band. Any downstream claim that $\Delta=0$ makes a region small or rival-free is unsupported by this Lemma.

---

## 5. Hedging clauses, checked one by one

| clause | verdict |
| --- | --- |
| "**exactly** where every positive eigenvector is an infinitesimal symmetry" (title) | **true**, and the strongest word in the block is the one that is earned, it is an iff, both directions one line |
| "**i.e.** $\mathfrak p\subseteq\mathfrak k(W)$" | true; the restatement is faithful |
| "Then $\mathrm{ad}(x)$ preserves each eigenspace, **hence** $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$ and $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$" | true, and incomplete: $[\mathfrak p,\ker W]\subseteq\ker W$ comes free and is omitted |
| "the third relation $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$ **follows**" | **D1, false as written**, needs $\ker W=0$, supplied one sentence later |
| "**So** on $\{S=0\}$ with trivial kernel … $W$ is graded" | true; both hypotheses present |
| "**so there** $\mathfrak p$ **is** $\mathfrak k(W)$" | **D2, true, but not by the cited table** |
| "the containment, **which is all the lemma uses**, still holds" (at $\mathbb{CP}^2$) | true of the Lemma; misleading by omission, since the corollary (the part with consumers), excludes $\mathbb{CP}^2$ |
| "step **H** already handles graded critical points" | **D4, unresolvable pointer** |

*Pointers that do resolve*: [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py), [b_defect_catalogue.py](../scripts/route-b/b_defect_catalogue.py) and the [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) note all exist at the paths given.

---

## 6. What I am recommending

1. **Say the Lemma is proved.** Restore "proved, two lines" (or equivalent) into the block, so the `Measured, Gate 1` sibling heading cannot be read as the Lemma's status. State that the table is a consistency check.
2. **Move the kernel hypothesis into the sentence that needs it** (D1): "the third relation $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$ follows *provided $\ker W=0$*".
3. **Replace the "so there $\mathfrak p$ is $\mathfrak k(W)$" inference with the normaliser argument** (D2), one sentence, and stop resting it on a hard-coded column. Say what the `isotropy` column is.
4. **Propagate the kernel hypothesis to [ATTEMPTS.md:2154](../ATTEMPTS.md)** (D3), and fix the "$\Delta>0$ is the whole remaining problem" reading there, which the record has already withdrawn elsewhere.
5. **Define "step H"** somewhere, or drop the claim (D4).
6. **Restore the $S_{\mathfrak{mmm}}$ column** to the table, and say once that $\mathfrak m$ here is the *whole* negative eigenspace.
7. **Add one sentence recording what the Lemma may be cited for**: it names the set $\{\Delta=0\}$; it bounds nothing about it.

**Nothing computational is owed.** Every claim above is settled by hand. The one thing a run could add is a computed $\dim\mathfrak k(W)$ column, which would turn D2's normaliser argument into a cross-check, *not needed*, since the argument is complete without it, and I did not run it.
