# REVIEW r640, Lemma L114

**Target:** Lemma L114, "the block-mass identity $6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)$, and its $\mathfrak h$-row twin", [findings/bounds-relaxations.md:126](../findings/bounds-relaxations.md), the heading, the block under it at lines 128–134, and the twin as actually printed at line 144. Index copy at [findings/INDEX-results.md:132](../findings/INDEX-results.md).

**Reviewer:** r640, cold, adversarial, on the **analysis-only** footing. No search, sweep, census or falsifier hunt was run, and the block's numerics were neither re-run nor extended. Every identity below was derived by hand from the definitions before the block was read for its reasoning, and every number quoted as mine is a hand count, not a measurement.

**VERDICT: CONFIRMED, the identity is a theorem, the coefficients $6/4/2$ are exactly right, and the $\mathfrak h$-row twin is right too.** But the reading they are right in is **nowhere stated**, and it is the *opposite* of the record's own stated default, which is the whole cause of the [L77](../findings/isotropy-cap.md) factor-of-$2$ conflict. Four defects follow, one of them a false self-historical note.

---

## Lead, the convention finding

**L114 counts UNORDERED triples.** Under that reading its $6/4/2$ are correct at every $n$, every $d$, and for **every** subspace $\mathfrak m$, no criticality, no Weyl tensor, no isotropy required.

**Under the record's own stated default it is false.** [conventions.md](../findings/conventions.md) says, in "The normalisations", *"Sums over pairs are over ORDERED pairs unless the line says otherwise"*, and L114's line does not say otherwise. The only written definition of $S_{XYZ}$ anywhere on the record, [ungraded-slack.md:81](../findings/ungraded-slack.md), $S_{\mathfrak{hhh}}=\sum_{a,b,c\in\mathfrak h}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2$, is likewise **ordered**. In that ordered reading the true row identity is $S_{\mathfrak{mmm}}+2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}=2d(n-2)$, and substituting ordered numbers into the printed display gives $144$ against a true $72$ at the $n=6$ balanced product (witness §3 below).

**So the two competing rules are the same identity in two conventions, and each is right in its own.** The conversion is per index pattern, not global:

| pattern | ordered $S^{\mathrm{ord}}$ vs. unordered $S^{\mathrm{unord}}$ | why |
| --- | --- | --- |
| $(\mathfrak{mmm})$, $(\mathfrak{hhh})$ | $S^{\mathrm{ord}}=6\,S^{\mathrm{unord}}$ | the label fixes no slot; all $3!$ orderings are summed |
| $(\mathfrak{mmh})$, $(\mathfrak{mhh})$ | $S^{\mathrm{ord}}=2\,S^{\mathrm{unord}}$ | the odd index is pinned to its slot; only the like pair permutes |

**Recommendation, stated flatly: [conventions.md](../findings/conventions.md) should adopt the ORDERED-SLOT reading**, and [bounds-relaxations.md](../findings/bounds-relaxations.md) and [isotropy-cap.md](../findings/isotropy-cap.md) should be converted to it. The concrete edit list is §5. The reasons, in order of weight:

- **It is already the record's stated rule.** The ordered-pairs sentence in [conventions.md](../findings/conventions.md) extends to triples with nothing added; adopting the other reading means writing an exception into the file whose purpose is to have none.
- **It is the only reading ever written down as a definition** ([ungraded-slack.md:81](../findings/ungraded-slack.md)).
- **It is a projector contraction and so is well posed unconditionally**: $S_{XYZ}=\sum_{abc}T_{abc}\,(\Pi_X)_a(\Pi_Y)_b(\Pi_Z)_c$, manifestly independent of the basis chosen inside each block. The unordered count is a count of *distinct* index triples and is only well posed because $T$ happens to be hollow; it would be ill defined for any tensor with diagonal support.
- **A numbered result with a proof already depends on it.** [Lemma L23](../findings/ungraded-slack.md)'s proof runs on $S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r$ and $2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r)$ with $\kappa=2(n-2)$, which are the ordered row identities and are false unordered.
- **The coefficients become the plain multinomials**: the row identity reads $1/2/1$ and the total reads $1/3/3/1$, so the bookkeeping is $\binom{3}{k}$ and nothing has to be remembered.

The cost is honest and small: the memorable $6/4/2$ goes away, and roughly a dozen printed numerals in two files double or sextuple. The record's largest single body of measured $S$ values, [nondegeneracy.md](../findings/nondegeneracy.md)'s $355$-point sweep and its table, is already ordered and does not move.

---

## 1. The derivation, from the definitions

**Conventions pinned before deriving.** $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal ([conventions.md](../findings/conventions.md), "Norms and pairings"); $c_{abc}=\langle[v_a,v_b],v_c\rangle$ is **totally antisymmetric**, so $T_{abc}=c_{abc}^2$ is **totally symmetric and vanishes whenever two indices coincide** ([conventions.md](../findings/conventions.md), "Structure constants"). I write $M(X,Y,Z):=\sum_{a\in X}\sum_{b\in Y}\sum_{c\in Z}T_{abc}$ for the slotwise contraction, which is the ordered $S_{XYZ}$.

### 1a. The row marginal $2(n-2)$, confirmed, and it has no result number

Stated in [conventions.md](../findings/conventions.md) under "The pair cap and the Killing marginal", as $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$, beside the pair cap. **The pair cap carries a number ([Lemma L31](../findings/stratum-two-negative.md)); the marginal carries none**, I checked [INDEX-results.md](../findings/INDEX-results.md) end to end, and it appears there only as prose inside the [L70](../findings/bounds.md) and [L79](../findings/isotropy-cap.md) rows. The brief's claim is correct, and the fact is load-bearing in at least four numbered results.

It is one line. $\operatorname{ad}(v)$ is skew for an ad-invariant inner product, so for unit $v$

$$\sum_\beta\lVert[v,v_\beta]\rVert^2=\operatorname{tr}\big(\operatorname{ad}(v)^{\mathsf T}\operatorname{ad}(v)\big)=-\operatorname{tr}\operatorname{ad}(v)^2=-B(v,v)=-(n-2)\operatorname{tr}(v^2)=2(n-2),$$

using the Killing form $B(X,Y)=(n-2)\operatorname{tr}(XY)$ and $\operatorname{tr}(v^2)=-2$ at half-trace unit norm, both from [conventions.md](../findings/conventions.md). Equivalently $\sum_{b,c}T_{abc}=2(n-2)$ for every $a$. **Hand check at $n=3$:** the total is $2N(n-2)=2\cdot3\cdot1=6$, and $\mathfrak{so}(3)$ has exactly one unordered triple with $T=1$ (from $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$), so the ordered total is $3!=6$. ✓

### 1b. The identity

Sum the marginal over the $d$ indices of $\mathfrak m$ and split the free slots across the two blocks:

$$2d(n-2)=\sum_{a\in\mathfrak m}\sum_{b,c}T_{abc}=M(\mathfrak{mmm})+M(\mathfrak{mmh})+M(\mathfrak{mhm})+M(\mathfrak{mhh})=S^{\mathrm{ord}}_{\mathfrak{mmm}}+2S^{\mathrm{ord}}_{\mathfrak{mmh}}+S^{\mathrm{ord}}_{\mathfrak{mhh}}.$$

Applying the conversion table gives the printed form:

$$6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)\qquad\text{(unordered)}.$$

**Each coefficient accounted for.** They are *not* multinomial weights times a marginal, which is what the brief anticipated and what the display's shape suggests; they are **slot-occupancy counts**. An unordered triple of distinct indices is counted once for each of its $\mathfrak m$-indices that can sit in the summed row slot, times $2$ for the two orderings of the remaining pair: an all-$\mathfrak m$ triple $3\times2=6$, a two-in-$\mathfrak m$ triple $2\times2=4$, a one-in-$\mathfrak m$ triple $1\times2=2$. The multinomial reading is the *ordered* one, where the row identity is $1/2/1$ and the total is $1/3/3/1$; the $6/4/2$ is the same content with the $6$-fold and $2$-fold orbit sizes folded in. **Both are given, and the display is in the second.**

### 1c. The $\mathfrak h$-row twin, correct as printed

Repeating with $\mathfrak m\leftrightarrow\mathfrak h$ and $\dim\mathfrak h=N-d$ gives $S^{\mathrm{ord}}_{\mathfrak{hhh}}+2S^{\mathrm{ord}}_{\mathfrak{mhh}}+S^{\mathrm{ord}}_{\mathfrak{mmh}}=2(N-d)(n-2)$, i.e. unordered

$$6S_{\mathfrak{hhh}}+4S_{\mathfrak{mhh}}+2S_{\mathfrak{mmh}}=2(N-d)(n-2),$$

which is exactly what [bounds-relaxations.md:144](../findings/bounds-relaxations.md) prints. **Confirmed.** *Structural note:* the L114 **heading** promises the twin, but the block under it (lines 128–134) never states it; the twin appears ten lines lower under a different heading, "On $\{S=0\}$ the block structure is a one-parameter family". The content is on the record and correct; the numbered result and its statement are not in the same place.

Adding the two twins gives $6(S_{\mathfrak{mmm}}+S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}+S_{\mathfrak{hhh}})=2N(n-2)$, the whole-space marginal. The two rows are consistent and together are equivalent to the total.

### 1d. Where total symmetry of $T$ enters, twice, at very different strengths

- **In the display itself, only the transposition of slots $2$ and $3$ is used**, to merge $M(\mathfrak{mmh})+M(\mathfrak{mhm})$ into $2S_{\mathfrak{mmh}}$. That much is free: $c$ is antisymmetric in its last two arguments by the definition of the bracket, so $c^2$ is symmetric there whatever else is true.
- **Total symmetry is what makes the label $S_{\mathfrak{mmh}}$ mean anything at all.** Without it $M(\mathfrak{mmh})$, $M(\mathfrak{mhm})$ and $M(\mathfrak{hmm})$ are three different numbers, the twin identity does not pair with this one, and the unordered count is not defined. It is genuinely load-bearing, and it is not free, it comes from ad-invariance of the inner product, i.e. from $c_{abc}$ being totally antisymmetric.

So the block's citation of total symmetry is **correct and correctly placed**, which is a better outcome than the neighbouring audit's.

### 1e. Two hypotheses the block does not state

- **$\mathfrak h:=\mathfrak m^\perp$, the whole complement.** The splitting of the free slots above needs the index set partitioned into exactly **two** blocks. Under [conventions.md](../findings/conventions.md)'s own table ($\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$, $\mathfrak r$ everything else), there is a third block, and the identity acquires terms $S_{\mathfrak{mmr}},S_{\mathfrak{mhr}},S_{\mathfrak{mrr}}$ and is **false** as printed. The block writes "$\mathfrak m$ the negative eigenspace" and never says what $\mathfrak h$ is. [isotropy-cap.md:128](../findings/isotropy-cap.md) already records the identical omission next door.
- **Nothing about $W$ is needed, and the block understates its own result.** The identity is a statement about an orthogonal splitting $\mathfrak{so}(n)=\mathfrak m\oplus\mathfrak h$ with $\dim\mathfrak m=d$. Criticality, the Weyl symmetries, Bianchi, Ricci-flatness, $S=0$ and even the eigenspace interpretation of $\mathfrak m$ are all inert. [Reviewer 65](REVIEW_r65.md) said so at the time (*"the row-marginal identity, which holds for every subspace, isotropic or not"*) and the block's "with the negative eigenspace $\mathfrak m$ of dimension $d$" reads as a hypothesis where it is only an application.

---

## 2. Reconciling with the $1/3/3/1$ rule

[nondegeneracy.md:317](../findings/nondegeneracy.md) states $S_{\mathfrak{mmm}}+3S_{\mathfrak{mmh}}+3S_{\mathfrak{mhh}}+S_{\mathfrak{hhh}}=2N(n-2)$. Derived cold: sum $\sum_{b,c}T_{abc}=2(n-2)$ over **all** $N$ indices and split all three slots, using total symmetry to merge the three placements of each mixed pattern. That is the ordered form, and it is correct.

**Are they the same identity?** They are the same *fact* (the Killing row marginal), contracted over different row sets, and they are consistent with each other rather than in competition. The precise relation:

- L114 sums the marginal over $\mathfrak m$-rows; the twin sums it over $\mathfrak h$-rows; their sum is the $1/3/3/1$ total. **So $1/3/3/1$ is a strict consequence of L114-plus-twin, and carries strictly less information**, it is one equation where the pair is two.
- Their coefficient patterns differ for **two independent reasons at once**, which is why they look irreconcilable: the row set (a $\mathfrak m$-row sum versus an all-row sum) *and* the convention. Fixing only one of the two does not make them match.

**The calibration in the brief checks and pins the readings.** At $\mathfrak{so}(3)\oplus\mathfrak{so}(3)\subset\mathfrak{so}(6)$ each $\mathfrak{so}(3)$ factor contributes exactly one unordered triple with $T=1$ (from $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$, so $c^2=1$), the two factors commuting. So $S^{\mathrm{unord}}_{\mathfrak{mmm}}=2$ and $S^{\mathrm{ord}}_{\mathfrak{mmm}}=12$. **[nondegeneracy.md:291](../findings/nondegeneracy.md)'s $12$ is ordered**, confirming the factor $6$ on that pattern by hand.

**And the factor $2$ on the mixed patterns is pinned independently by the record's own numbers.** Padded $W_{\mathbb{CP}^2}$ at $n=6$: [bounds-relaxations.md:212](../findings/bounds-relaxations.md) reports $S_{\mathfrak{mhh}}=4$, [nondegeneracy.md:316](../findings/nondegeneracy.md) reports $S_{\mathfrak{hhm}}=8$ for the same object. Neither is wrong; they are one number in two conventions, and $8=2\times4$ is the table's entry.

**Consequence for [L77](../findings/isotropy-cap.md), which is the live conflict.** With $\mu=\sum_{a,b\in\mathfrak m}\lVert[e_a,e_b]\rVert^2=S^{\mathrm{ord}}_{\mathfrak{mmm}}+S^{\mathrm{ord}}_{\mathfrak{mmh}}$ and $X=\sum_{a\in\mathfrak m,b\in\mathfrak h}\lVert[e_a,e_b]\rVert^2=S^{\mathrm{ord}}_{\mathfrak{mmh}}+S^{\mathrm{ord}}_{\mathfrak{mhh}}$, the marginal gives $\mu+X=2d(n-2)$ and

$$\gamma=X-\mu=S^{\mathrm{ord}}_{\mathfrak{mhh}}-S^{\mathrm{ord}}_{\mathfrak{mmm}}=2S^{\mathrm{unord}}_{\mathfrak{mhh}}-6S^{\mathrm{unord}}_{\mathfrak{mmm}}.$$

**[r609](REVIEW_r609.md) and [r610](REVIEW_r610.md) are both right**: $\gamma=S_{\mathfrak{mhh}}$ ordered, $\gamma=2S_{\mathfrak{mhh}}$ unordered, under isotropy. Eliminating $\gamma$ recovers $2\mu+\gamma=2d(n-2)$, which is [Lemma L36](../findings/isotropy-cap.md)'s form, **and expanding that in block masses is L114 itself**. So L36, L77 and L114 are three faces of one equation, and [isotropy-cap.md:118](../findings/isotropy-cap.md)'s note that L36 sits "incompatibly with the factor and correctly" $138$ lines above L77 is the same observation reached from the other side.

**Hand witness for the general $\gamma$ law**, at $n=4$, $\mathfrak m=\mathfrak{so}(3)=\operatorname{span}(\varphi_{12},\varphi_{13},\varphi_{23})$, $\mathfrak h=\operatorname{span}(\varphi_{14},\varphi_{24},\varphi_{34})$: $S^{\mathrm{unord}}_{\mathfrak{mmm}}=1$; the $(\mathfrak{mhh})$ triples are $\{\varphi_{i4},\varphi_{j4},\varphi_{ij}\}$, three of them at $T=1$, so $S^{\mathrm{unord}}_{\mathfrak{mhh}}=3$; hence $\gamma=2\cdot3-6\cdot1=0$, matching [isotropy-cap.md:116](../findings/isotropy-cap.md)'s $\mu=6$, $\gamma=0$, $S_{\mathfrak{mhh}}=3$ exactly. That file is therefore **unordered** too, and $\mu=6=S^{\mathrm{ord}}_{\mathfrak{mmm}}$ confirms the $6$ once more.

---

## 3. The witness that separates the two readings

$n=6$, $\mathfrak h=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, $\mathfrak m=\mathfrak h^\perp=\operatorname{span}\{\varphi_{ai}:a\in\{1,2,3\},i\in\{4,5,6\}\}$, so $d=9$ and $2d(n-2)=72$. This is a symmetric pair, so $S_{\mathfrak{mmm}}=0$ and $S_{\mathfrak{mhh}}=0$.

Counting the $(\mathfrak{mmh})$ triples by hand from $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$: two elements $\varphi_{ai},\varphi_{bj}$ of $\mathfrak m$ bracket nontrivially exactly when they share one index. Shared $i=j$ with $a\ne b$ gives $-\varphi_{ab}$ ($3\times\binom32=9$ triples; shared $a=b$ with $i\ne j$ gives $\varphi_{ij}$), $3\times3=9$ triples. Each has $T=1$, so

$$S^{\mathrm{unord}}_{\mathfrak{mmh}}=18,\qquad S^{\mathrm{ord}}_{\mathfrak{mmh}}=36 .$$

- Printed display, unordered: $6\cdot0+4\cdot18+2\cdot0=72$. ✓
- Printed display, ordered: $6\cdot0+4\cdot36+2\cdot0=144\ne72$. ✗
- Ordered display $1/2/1$: $0+2\cdot36+0=72$. ✓

**Second witness, exercising the $6$.** Same point, $\mathfrak m=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ instead, $d=6$, $2d(n-2)=48$: $S^{\mathrm{unord}}_{\mathfrak{mmm}}=2$, $S^{\mathrm{unord}}_{\mathfrak{mmh}}=0$ (the subalgebra closes), $S^{\mathrm{unord}}_{\mathfrak{mhh}}=18$ (the same $18$ triples, read from the other side). Then $6\cdot2+4\cdot0+2\cdot18=48$. ✓ All three coefficients are now checked by hand at a point where they are separately visible.

---

## 4. The two other halves of the brief

### 4a. The withdrawn inference, the withdrawal is correct

With $S_{\mathfrak{mmm}}=0$ the identity leaves $4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)$, i.e. $2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}=d(n-2)$, which is exactly the "weighted total" the block names, so the block is **internally consistent and internally in the unordered reading**, a third confirmation of the convention. With $\mathfrak m$ the negative eigenspace, $(\mathfrak{mmh})=(--+)$ has $\lambda_\alpha\lambda_\beta\lambda_\gamma>0$ and $(\mathfrak{mhh})=(-++)$ has it $<0$, and $\theta=\sum\lambda^3+3\sum T\lambda\lambda\lambda$ ([post F18](../findings/bounds-relaxations.md)). **One linear equality between two quantities that enter $\theta$ with opposite signs determines neither**, so the freed mass may go to either and $\theta$ may rise, fall, or stay. The withdrawal is right, and for the reason the block gives.

*The hedges check.* "Stands" is fair, the identity is untouched by the withdrawal. "Multiplicities included" is fair; see 4b. "Mechanically" is the right word for what is being denied: the claim was that the identity *forces* the reallocation, and it does not.

### 4b. Provenance, one clean note, one false one

Origin: commit `d1fc8810`, 2026-08-23, *"keep the 6/4/2 identity, withdraw the inference from it"*, restoring the identity that `fe02120`'s fence-post-17 rewrite had removed along with the bad inference. The "both reviewers" are [r65](REVIEW_r65.md) and [r66](REVIEW_r66.md).

- **"Confirmed independently by both reviewers, multiplicities included", TRUE, and unusually clean.** [r65](REVIEW_r65.md) confirms at its lines 13 and 127; [r66](REVIEW_r66.md) at lines 19 and 189–201, with a full derivation matching mine coefficient for coefficient, and a check the note does not claim: replacing $(6,4,2)$ by $(6,4,3)$, $(6,5,2)$, $(5,4,2)$, $(3,2,1)$ returns $64.44$, $63.52$, $54.49$, $28.00$ against a true $56.00$, so **the multiplicities are not fittable**. Both reviewers built their own implementations.
- **"Both reviewers rejected the inference while confirming the identity", FALSE as to r65.** Only [r66](REVIEW_r66.md) rejected it. [r65:127](REVIEW_r65.md) says the rider is *"right for the relaxation; it is a statement about the LP optimum, not about genuine Weyl tensors, and should be phrased that way"* (a rescoping) and [r65:13](REVIEW_r65.md) separately **confirms** C6(a), *"$S=0$ invisible to the LP"*. The sentence converts a $1$–$1$ split with a scoping proposal into unanimity. *(Post F17 immediately above L114 later corrected r65's C6(a) on other grounds, but that does not retroactively make r65 a rejector of this inference.)*
- **The convention was stated by the source and dropped in the fold-in.** [r65:127](REVIEW_r65.md) reads verbatim *"With $S_{mmm},S_{mmh},S_{mhh}$ read as sums over **unordered** triples"*, and [r66](REVIEW_r66.md)'s derivation spells out the $3\times2$, $2\times2$, $1\times2$ occupancy count. Neither qualifier survived into `d1fc8810`'s prose. **That single omission is the entire cause of the [L77](../findings/isotropy-cap.md) $\gamma$ conflict two weeks later**, and it is the most instructive thing in this audit: the record lost a convention it had been handed.

### 4c. The evidence's status, a theorem labelled as a measurement

*"Exact to $10^{-13}$ at $n=5,6,7$"* is a measurement of an algebraic identity that holds at every $n$, every $d$ and every subspace, provable in the four lines of §1b. **The numbers are a check, not the evidence.** The record's labels being literal:

- The heading calls it a **Lemma**, which is right, but no statement-and-proof block exists, and the body presents it as measured. It should carry the derivation and demote $10^{-13}$ to a check, exactly as today's four measured tables became corollaries.
- [INDEX-results.md:132](../findings/INDEX-results.md) reads *"Gate 2: no verdict on the record"*. After this audit and its pair, it has one.
- The measurement is also weaker than it sounds: $n=5,6,7$ tests only three values of a statement with no $n$-dependence beyond the constant $2(n-2)$, and it does not discriminate the two readings unless $S_{\mathfrak{mmm}}$ and $S_{\mathfrak{mhh}}$ are both nonzero at the tested points.

### 4d. Consumers and pointers

- **Nothing on the record cites the withdrawn inference.** Grepped across [findings/](../findings/), [results.md](../results.md), [report/](../report/) and [plan.md](../plan.md): the only occurrence of "frees … mass" is the withdrawal sentence itself.
- **L114 has no downstream consumer either**, it is named at [INDEX-results.md:132](../findings/INDEX-results.md), [INDEX.md:43](../findings/INDEX.md), the $d$-collision row of [conventions.md:32](../findings/conventions.md) and [LEDGER.md:1398](../findings/LEDGER.md), and nowhere is a step taken through it. So a convention change here breaks no argument.
- **Pointers resolve.** The block's single link, to [conventions.md](../findings/conventions.md), lands on a file that does state the row marginal. The file's two empty `(#)` targets are at lines 314 and 408, outside this block.

---

## 5. The concrete edit list, if the ordered reading is adopted

Applying it requires no re-derivation: multiply $S_{\mathfrak{mmm}}$ and $S_{\mathfrak{hhh}}$ by $6$, and $S_{\mathfrak{mmh}}$ and $S_{\mathfrak{mhh}}$ by $2$, wherever a currently-unordered file prints one.

**Add to [conventions.md](../findings/conventions.md)**, three entries, none of which the file has:

1. $S_{XYZ}:=\sum_{a\in X,b\in Y,c\in Z}T_{abc}$, **the slotwise contraction over ordered index triples**, with the note that the label is a multiset and that total symmetry of $T$ makes it slot-order-independent. Table the conversion ($\times6$ on $(\mathfrak{mmm})/(\mathfrak{hhh})$, $\times2$ on the mixed patterns) as the trap, since both readings are printed on the record and both are in published reviews.
2. **In the block-mass context $\mathfrak h:=\mathfrak m^\perp$**, distinct from the $\mathfrak h=E_{\max}$ of the objects table, the two-block partition is a hypothesis, and with a third block L114 and L77 are both false.
3. Give the **row marginal $2(n-2)$ a result number**. It is used in at least L23, L36, L70, L77, L79 and L114 and is currently a numbered-free prose bullet.

**[bounds-relaxations.md](../findings/bounds-relaxations.md)**, line 126 heading and line 132 display become $S_{\mathfrak{mmm}}+2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}=2d(n-2)$; line 144's twin becomes $S_{\mathfrak{hhh}}+2S_{\mathfrak{mhh}}+S_{\mathfrak{mmh}}=2(N-d)(n-2)$; line 134's weighted total becomes $2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}=2d(n-2)$; line 146's solved forms become $S_{\mathfrak{mmh}}=d(n-2)-\tfrac12S_{\mathfrak{mhh}}$ and $S_{\mathfrak{hhh}}=(n-2)(2N-3d)-\tfrac32S_{\mathfrak{mhh}}$; line 150's mass bounds become $4d^2/n-2d\le S_{\mathfrak{mmh}}\le(n-2)d$ and $S_{\mathfrak{hhh}}\le(n-2)(2N-3d)$; line 170's general law becomes $\gamma=S_{\mathfrak{mhh}}-S_{\mathfrak{mmm}}$; line 212's series $S_{\mathfrak{mhh}}=4,8,12,16$ becomes $8,16,24,32$, **which then agrees with [nondegeneracy.md:316](../findings/nondegeneracy.md)'s $8$ at $n=6$ instead of contradicting it**.

**[isotropy-cap.md](../findings/isotropy-cap.md)**, line 132's $\mu=2S_{\mathfrak{mmh}}$ becomes $\mu=S_{\mathfrak{mmm}}+S_{\mathfrak{mmh}}$ (and $=S_{\mathfrak{mmh}}$ under isotropy) and $X=2S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}$ becomes $X=S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}$; the L77 statement and its [INDEX-results.md:92](../findings/INDEX-results.md) row become $\gamma=S_{\mathfrak{mhh}}$, i.e. **[r609](REVIEW_r609.md)'s form, and the r609/r610 disagreement closes with both reviewers correct**; line 116's $n=4$ witness $S_{\mathfrak{mhh}}=3$ becomes $6$; line 128's remark that the $\gamma$-allowance $(n^2-1)/(2n)$ "is attached below to $S_{\mathfrak{mhh}}$, which is half it" becomes obsolete and should be struck, since $\gamma=S_{\mathfrak{mhh}}$ makes the allowance attach directly.

**Unchanged:** [ungraded-slack.md](../findings/ungraded-slack.md) and [nondegeneracy.md](../findings/nondegeneracy.md) in full, both are already ordered, including L23's proof, the $1/3/3/1$ identity and the $355$-point sweep table.

---

## 6. Defects, ranked

| # | defect | severity |
| --- | --- | --- |
| D1 | The unordered reading is **stated nowhere**, and contradicts [conventions.md](../findings/conventions.md)'s own ordered-pairs default. Both source reviewers stated it and the fold-in dropped it. This is the cause of the [L77](../findings/isotropy-cap.md) factor-$2$ conflict. | **high**, cross-file, live, and already cost one refutation |
| D2 | $\mathfrak h:=\mathfrak m^\perp$ is unstated; under [conventions.md](../findings/conventions.md)'s $\mathfrak h=E_{\max}$ a third block exists and the identity is false. | **high** |
| D3 | *"Both reviewers rejected the inference"* is false: [r65](REVIEW_r65.md) rescoped it and confirmed the companion claim. | **medium**, a false self-historical note |
| D4 | A theorem carried as a $10^{-13}$ measurement, with no proof block, and [INDEX-results.md:132](../findings/INDEX-results.md) reading "no verdict on the record". | **medium** |
| D5 | The hypothesis is stated as "the negative eigenspace" where **any** subspace works; the block understates its own generality. | **low** |
| D6 | The heading names the twin; the twin is stated ten lines away under an unrelated heading. | **low** |

**None of these touches the mathematics.** $6/4/2$ is right, the twin is right, the withdrawal is right, and the coefficients are not fittable. What is wrong is that the sentence carrying them does not say which of two conventions it is in, and the record has already paid once for that.

---

## Analysis-only compliance

No computation of any kind was run for this review, no script, no solver, no screen. Every number above ($12$, $2$, $18$, $36$, $72$, $48$, $3$, $6$, $0$, $8$) is a hand count from $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$ and is reproducible with pencil and paper. **Nothing here requires a run to decide.** The one thing a run would add is confirmation that the record's *other* printed $S$ values are each in the reading their file claims, a $10$-second recomputation of, say, [nondegeneracy.md](../findings/nondegeneracy.md)'s sweep columns and [bounds-relaxations.md:212](../findings/bounds-relaxations.md)'s series against both readings. It would decide whether the two files are *internally* consistent in their own convention or whether either mixes; a pass means the §5 edit list is complete as written, a fail means a fuller inventory is needed first. **It is not run here.**
