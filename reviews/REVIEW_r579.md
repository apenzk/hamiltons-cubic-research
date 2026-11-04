# REVIEW r579, Lemma L81, the sharp centraliser criterion

Reviewer r579, independent adversarial audit of one result: **[Lemma L81](../findings/isotropy-cap.md) (the sharp centraliser criterion, wider than Lemma L32), REQUIRES $p\ge2$**, canonical block at [isotropy-cap.md:255](../findings/isotropy-cap.md#L255). Its companion [Lemma L32](../findings/isotropy-cap.md#L74) was refuted as stated at Gate 2 ([r462](REVIEW_r462.md), [r463](REVIEW_r463.md)); L81's correction block names only [r463](REVIEW_r463.md) and so has had no Gate 2.

**Analysis only, no computation was run.** Two hand screens are reported below as screens: a partition count, and the commutant computations, both done on paper on objects constructed for the purpose.

**Overall verdict: REPAIRED.** The criterion is **true** under either reading of its hypothesis, and I derive it in full below by a route sharing nothing with the block's. But six defects stand, three of them load-bearing: the symbol the hypothesis is stated in is undefined and carries two readings that are different hypotheses; the hypothesis actually recorded is **not** the one its own cited source gives, and is not sharp; the recorded proof does not reach the conclusion at odd $m$; the heading's comparative is unsupported and backwards; and three copies of the refuted statement are still live on the record.

---

## 0. The block's true boundaries, and what it leans on that is undefined

The block runs from the heading at [isotropy-cap.md:255](../findings/isotropy-cap.md#L255) through the correction blockquote at :257 and the section **"The sharp mechanism, and it is wider than nondegeneracy"** at :259–:261, ending where the L33 pointer begins at :263. **The heading announces the lemma; the lemma's statement is under a different heading.** Nothing under L81's own heading states a criterion, the heading is followed immediately by the correction blockquote.

Above the heading, the two lines that bear on it are [isotropy-cap.md:241](../findings/isotropy-cap.md#L241), which asserts that L32 and L81 carry the same $\mathfrak c\ne0$ gap, and [:253](../findings/isotropy-cap.md#L253), the superseded L32 stub. Both matter: :241 says the gap on L81 **is** $\mathfrak c\ne0$, while the heading says it is $p\ge2$. Those are different conditions (§3).

**Undefined in the block, and load-bearing:**

| symbol | where it is defined | why it matters |
| --- | --- | --- |
| $p$ | nowhere in the block; introduced only in [L32](../findings/isotropy-cap.md#L74)'s proof, $180$ lines above, with **no link from L81** | the whole hypothesis is stated in it, and it has two readings (§1) |
| $\mathfrak c$, $\mathfrak z$, $\mathfrak t$, $a$ | [L32](../findings/isotropy-cap.md#L74)'s statement and proof, unlinked | the criterion is a statement about $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ |
| $D_p$ | nowhere on the record | §4 shows the choice of root system is where the proof breaks |
| "multiplicity partition" | nowhere | the census is counted in it, and the two blocks give different counts (§6) |
| $n$ against $m$ | the block runs in $m$ throughout and its closing hedge switches to $n$ | the hedge is the one sentence a consumer would act on (§3) |

[conventions.md](../findings/conventions.md) has no row for any of $\mathfrak c$, $\mathfrak z$, $p$, $D_p$ or $N_v$. Of the collisions that file does table, none reaches this block: $\mathfrak m$ in its three senses, $\Pi$ in its four, and "Theorem A" in its four are all absent here, and the $\mathcal A$/$T$ sign that damaged [L131](../findings/isotropy-cap.md#L310)(ii) is not consumed by L81 either. **The block's convention exposure is entirely in symbols [conventions.md](../findings/conventions.md) does not carry.**

---

## 1. DEFECT 1 (load-bearing), $p$ has two readings and they are two different hypotheses

The block's hypothesis is "$p\ge2$". $p$ is introduced once on the record, in [L32](../findings/isotropy-cap.md#L74)'s proof: *"let $\mathfrak t$ be the maximal torus spanned by $x$'s $p=m/2$ coordinate $2$-planes and $a=(a_1,\dots,a_p)$ its singular values, **all nonzero**"*, then, for degenerate $x$, *"the same argument runs inside the support"*, which resets $p$ to $\tfrac12\mathop{\mathrm{rank}}x$.

So $p$ can be read as:

- **(T) the torus rank**, $p=\lfloor m/2\rfloor$, with $a$ allowed zero entries. Then $p\ge2\iff m\ge4$.
- **(R) the support rank**, $p=\tfrac12\mathop{\mathrm{rank}}x$, with $a$ having no zero entries. Then $p\ge2\iff\mathop{\mathrm{rank}}x\ge4$.

**These are not the same hypothesis.** (R) excludes every rank-$2$ bivector in every dimension; (T) excludes only $m\le3$. Two sentences of the block force opposite readings:

- *"at $p\ge3$ it forces a zero singular value"* is **only meaningful under (T)**, under (R) the entries of $a$ are nonzero by construction, so the sentence asserts a contradiction rather than a case.
- *"At $n\ge12$ the hypothesis is free"* is **true only under (T)** and false under (R): a rank-$2$ bivector exists in $\mathfrak{so}(n)$ at every $n$, so $\mathop{\mathrm{rank}}x\ge4$ is never free.
- The correction's diagnosis *"the proof splits on $p\ge3$ and $p=2$ and never treats $p=1$"* points at the witness $x=e_{12}\in\mathfrak{so}(3)$, which has torus rank $1$ **and** support rank $1$, the one configuration where the two readings agree, which is why the ambiguity survived the correction.

**Verdict: REPAIRED, the block must say which $p$ it means.** Under (T) the hypothesis is right up to §3; under (R) it is sound but badly over-strong.

---

## 2. The criterion, rebuilt from the definitions

Fix $x\in\mathfrak{so}(m)$, $x\ne0$, write $\mathfrak c=\mathfrak z(x)\cap x^\perp$ and $Z=\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$. Let $V=(\ker x)^\perp$ be the support, $\dim V=2r$, and $U=\ker x$, $\dim U=q=m-2r$. The pairing is the ad-invariant one of [conventions.md](../findings/conventions.md); the criterion is a statement about dimensions, so the $\tfrac12$ that file fixes at the $\Lambda^2$ level scales nothing here, **the norm convention is inert for this lemma**, which is the one convention question the block could have got wrong and did not.

**Step A, $\mathfrak z(x)$ splits.** $\Lambda^2\mathbb R^m=\Lambda^2V\oplus(V\otimes U)\oplus\Lambda^2U$. On $V\otimes U$, $\mathop{\mathrm{ad}}(x)$ acts as $x\otimes1$, invertible because $x$ is invertible on $V$. Hence $\mathfrak z(x)=\mathfrak z_{\mathfrak{so}(V)}(x)\oplus\mathfrak{so}(U)$, with no mixed part. Since $\mathfrak{so}(U)\perp x$ and $x\in\mathfrak{so}(V)$,
$$\mathfrak c=\big(\mathfrak z_{\mathfrak{so}(V)}(x)\cap x^\perp\big)\ \oplus\ \mathfrak{so}(U).$$

**Step B, when $\mathfrak c$ vanishes.** $\mathfrak z_{\mathfrak{so}(V)}(x)\supseteq\mathfrak t_V$, the torus of $x$'s own $2$-blocks, of dimension $r$; intersecting with $x^\perp$ leaves at least $r-1$ dimensions. So $\dim\mathfrak c\ge(r-1)+\binom q2$, and this is zero exactly when $r=1$ and $q\le1$, that is, exactly at $m=2$ and $m=3$. **$\mathfrak c\ne0\iff m\ge4$**, for every nonzero $x$. This is a fact about the ambient dimension alone.

**Step C, $r\ge2$, the root argument.** Inside $\mathfrak{so}(V)$ ($\cong\mathfrak{so}(2r)$, root system $D_r$, all singular values nonzero) put $\mathfrak a=\mathfrak t_V\cap x^\perp\subseteq\mathfrak c$. Then $\mathfrak z(\mathfrak c)\subseteq\mathfrak z(\mathfrak a)$, and $\mathfrak z(\mathfrak a)=\mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}$ inside $\mathfrak{so}(V)$. A $D_r$ root $\pm e_i\pm e_j$ has $r-2$ zero coordinates while $a$ has none, so $\beta\propto a$ forces $r=2$ and $a\propto(1,1)$: a rank-$4$ complex structure. Otherwise $\mathfrak z(\mathfrak c)\cap\mathfrak{so}(V)\subseteq\mathfrak t_V$ and $Z\subseteq\mathfrak t_V\cap\mathfrak a^\perp=\mathbb Rx$. The $U$-side is closed by Step D.

**Step D, the kernel side, which the block compresses into one clause.** Three cases, and only one is trivial.
- $q\ge3$: $\mathfrak{so}(U)$ acts on $V\otimes U$ through the standard representation of $U$, which has no invariants, and on $\Lambda^2U$ as the adjoint, which has none either. So $\mathfrak z(\mathfrak{so}(U))=\mathfrak{so}(V)$ and $\mathfrak z(\mathfrak c)\subseteq\mathfrak{so}(V)$, where Step C finishes.
- $q=2$: $\mathfrak z(\mathfrak{so}(U))=\mathfrak{so}(V)\oplus\mathfrak{so}(U)$, and the extra line $\mathfrak{so}(U)$ lies in $\mathfrak c$, so it is deleted by $\mathfrak c^\perp$.
- $q\le1$: $\mathfrak{so}(U)=0$ and the $U$-side gives nothing. This is the only case where $Z$ is not forced into $\mathfrak{so}(V)$, and it is where $m=3$ sits.

**Step E, $r=1$, which the block's proof never reaches.** Here $\mathfrak t_V\cap x^\perp=0$, so $\mathfrak c=\mathfrak{so}(U)$ exactly.
- $q\ge3$ ($m\ge5$): by Step D, $\mathfrak z(\mathfrak c)=\mathfrak z(\mathfrak{so}(U))\cap\mathfrak z(\mathfrak{so}(U))=\mathfrak{so}(V)=\mathfrak{so}(2)=\mathbb Rx$. So $\dim Z=1$ and the criterion **holds**.
- $q=2$ ($m=4$): $\mathfrak c=\mathbb Re_U$, $\mathfrak z(\mathfrak c)=\mathfrak t=\mathbb Rx\oplus\mathbb Re_U$, and $\mathfrak c^\perp$ deletes $e_U$: $Z=\mathbb Rx$, $\dim Z=1$. **Holds.**
- $q=1$ ($m=3$): $\mathfrak c=0$, $\mathfrak z(0)=\mathfrak{so}(3)$, $\mathfrak c^\perp=\mathfrak{so}(3)$, $Z=\mathfrak{so}(3)$, $\dim Z=3$. **Fails**, and $x=e_{12}$ is no rank-$4$ complex structure, $\mathfrak{so}(3)$ carrying no $4$-plane. This reproduces the recorded witness independently.
- $q=0$ ($m=2$): $Z=\mathfrak{so}(2)=\mathbb Rx$. Holds vacuously.

**Step F, the converse.** At a rank-$4$ complex structure $x=a(e_{12}+e_{34})$ padded into $\mathbb R^m$: $x$ lies in one $\mathfrak{su}(2)$ factor of $\mathfrak{so}(V)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$, so $\mathfrak c=\mathfrak{su}(2)_-\oplus\mathfrak{so}(U)$; $V$ is $\mathfrak{su}(2)_-$-irreducible, so $V\otimes U$ contributes no invariants, and $\mathfrak z(\mathfrak c)=\mathfrak{su}(2)_+\oplus(\Lambda^2U)^{\mathfrak{so}(U)}$, whose second summand lies in $\mathfrak c$ and is deleted. $Z=\mathfrak{su}(2)_+$, $\dim Z=3$, at **every** $m\ge4$. This confirms the block's *"a rank-4 $J$ padded into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$ returns $3$ every time"*, and extends it to all $m$.

> **CONCLUSION OF THE REBUILD.** For every nonzero $x\in\mathfrak{so}(m)$, $\dim Z>1$ **iff** $x$ is a multiple of a rank-$4$ complex structure, **except at $m=3$, where it fails and is the only failure.** $\dim Z\in\{1,3\}$ always.

*The commutant computations above are hand screens on objects I constructed for the purpose, the isotypic decompositions of $\Lambda^2(V\oplus U)$ under $\mathfrak{so}(U)$ and under $\mathfrak{su}(2)_-$, reported as screens supporting a derivation, not as evidence in their own right.*

---

## 3. DEFECT 2 (load-bearing), the hypothesis recorded is not the hypothesis its source gives, and it is not sharp

§2 Step B and Step E together give the sharp statement: **the criterion holds for every nonzero $x$ in every $\mathfrak{so}(m)$ with $m\ne3$.** Compare the three conditions in play:

| condition | what it excludes | sharp? |
| --- | --- | --- |
| $m\ne3$ | exactly the failure | **yes** |
| $\mathfrak c\ne0$, [L32](../findings/isotropy-cap.md#L74)'s repair, and what [isotropy-cap.md:241](../findings/isotropy-cap.md#L241) says L81's gap is | $m\in\{2,3\}$ | sharp up to the trivial $m=2$ |
| $p\ge2$ under **(R)**, L81's heading | every rank-$2$ $x$, at every $m$ | **no**: §2 Step E proves the criterion at rank $2$ for all $m\ge4$ |
| $p\ge2$ under **(T)** | $m\le3$ | equals $\mathfrak c\ne0$ |

**[r463](REVIEW_r463.md), the block's own and only cited source, states the sharp form and the block dropped half of it.** [REVIEW_r463.md:114](REVIEW_r463.md#L114) reads: *"The hypothesis it actually needs is $m\ge4$ (equivalently: $\mathfrak c\ne\{0\}$, equivalently $x$ has effective rank $p\ge2$ **or $\dim\ker x\ge2$**)."* The heading kept the first disjunct and deleted "or $\dim\ker x\ge2$", and that deleted disjunct is exactly Step E's $q\ge2$ case, which is the whole of the rank-$2$ range at $m\ge4$. **The correction block is a misquotation of the single review it cites.**

**Consequence for the closing hedge.** *"At $n\ge12$ the hypothesis is free"* is:
- under **(T)**, true but stated at the wrong threshold, it is free at $n\ge4$, and "$12$" is unexplained;
- under **(R)**, **false**, a rank-$2$ eigenvector exists in $\mathfrak{so}(n)$ at every $n$, and rank-$2$ eigenvectors are not exotic in this programme: [Lemma L82](../findings/isotropy-cap.md#L300) is about how far the most negative eigenvector's mass sits from rank $4$, so $s_2\to0$ is a live configuration.

**Verdict: REPAIRED.** The recorded hypothesis is sound (it is sufficient under both readings) but is not what the source says and is not sharp. **Recommended repair: replace "REQUIRES $p\ge2$" with "REQUIRES $m\ge4$", which is $\mathfrak c\ne0$ and matches [L32](../findings/isotropy-cap.md#L74) and [isotropy-cap.md:241](../findings/isotropy-cap.md#L241) word for word**, and delete the $n\ge12$ sentence, which carries no content once the hypothesis is $m\ge4$.

---

## 4. DEFECT 3 (load-bearing), the proof does not reach its conclusion at odd $m$, whichever root system is meant

Under reading **(T)**, $\mathfrak t$ is a maximal torus of $\mathfrak{so}(m)$ and L32's displayed step is
$$\mathfrak z(\mathfrak a)\ =\ \mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}.$$
At **odd** $m=2p+1$ the root system is $B_p$, whose roots are $\pm e_i\pm e_j$ **and the short roots $\pm e_i$**. The block writes $D_p$ throughout while claiming coverage at $m=4,\dots,12$, which includes $m=5,7,9,11$. Both ways of reading "$D_p$" break something:

- **Roots ranging over $D_p$ only.** The displayed equation is then **false at odd $m$**. Take $m=5$, $x=e_{12}$, $\mathfrak t=\langle e_{12},e_{34}\rangle$, $a=(1,0)$, $\mathfrak a=\mathbb Re_{34}$. Then $\mathfrak z(\mathfrak a)=\mathfrak{so}(2)_{34}\oplus\mathfrak{so}(3)_{125}$ has dimension $4$, containing $e_{15}$ and $e_{25}$, while $\mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a,\ \beta\in D_2\}=\mathfrak t$ has dimension $2$. The step under-counts by the short root space $\mathfrak g_{\pm e_1}$.
- **Roots ranging over $B_p$.** The equation is then correct, but the criterion stated in the same sentence (*"$\dim Z>1$ iff the singular-value vector is proportional to a root"*), becomes **false at odd $m\ge5$**: the same $x=e_{12}\in\mathfrak{so}(5)$ has $a=(1,0)\propto e_1$, a $B_2$ root, yet §2 Step E gives $\dim Z=1$.

**Where the argument leaks.** The proof uses only the inclusion $\mathfrak a\subseteq\mathfrak c$ and then bounds $\mathfrak z(\mathfrak c)$ by $\mathfrak z(\mathfrak a)$. In the degenerate case that inclusion is very far from an equality (at $m=5$, $x=e_{12}$, $\dim\mathfrak a=1$ against $\dim\mathfrak c=3$) and it is precisely the discarded part, $\mathfrak{so}(\ker x)$, that closes the case. **The block compresses that part into the single clause "with $\mathfrak z(\mathfrak c)$ additionally centralising $\mathfrak{so}(\ker x)$", which names the object and never uses it.** §2 Steps D and E supply the missing argument; the conclusion at odd $m\ge5$ is true, but by a route the record does not contain.

**Verdict: REPAIRED.** The conclusion survives; the recorded derivation does not establish it at odd $m$. **Recommended repair: state the root system as $B_p$ at odd $m$ and $D_p$ at even $m$, and replace the one-clause degenerate remark with §2 Steps D–E**, which is four lines and makes the $q\ge3$ / $q=2$ / $q\le1$ trichotomy (and hence the isolation of $m=3$), visible.

---

## 5. DEFECT 4, "wider than Lemma L32" is unsupported, and the ordering runs the other way

The brief asks what each gives that the other does not. Taking both statements as written:

| | [L32](../findings/isotropy-cap.md#L74) | L81 |
| --- | --- | --- |
| conclusion off the exception | $Z=\mathbb Rx$ **exactly** | only $\dim Z\le1$, inferred from "$>1$ iff" |
| conclusion at the exception | a $3$-dimensional $\mathfrak{su}(2)$, **named** | only $\dim Z>1$ |
| degenerate $x$ | **covered by the statement**, "let $x$ be nonzero", with a proof clause for it | covered, "degenerate $x$ included" |
| the root criterion | **stated**, in L32's own "Scope, stated" paragraph: *"the criterion is the singular-value vector being proportional to a root of $D_p$"* | stated |
| direction of the biconditional | "except when", which is already a biconditional | "iff" |

**L32 states everything L81 states and two things more**, the exact subspace $\mathbb Rx$, and the exact $\mathfrak{su}(2)$. I find nothing L81 gives that L32 does not. The word "wider" is defensible only against L32's *proof heading*, "**Proof, for nondegenerate $x$**", and that is what L81's own body compares against: its section is titled *"The sharp mechanism, and it is **wider than nondegeneracy**"*. **The heading's comparative and the body's comparative name different things, and only the body's is true.**

The record elsewhere treats them as one result, not two: [ATTEMPTS.md:2100](../ATTEMPTS.md#L2100) records the sharp mechanism as *"the collapse proof was replaced by a three-line root-system argument … which also yields the sharp mechanism"*, a strengthened proof of L32, not a wider lemma. [REVIEW_r512.md:98](REVIEW_r512.md#L98) reads L81 as *"L32's stronger 'iff' form"*, which is the same reading.

**Verdict: REFUTED, as a comparative.** L81 is not wider than L32; L32 is strictly wider. **Recommended repair: retitle to "the sharp mechanism behind [Lemma L32](../findings/isotropy-cap.md), the criterion is a root proportionality, so nondegeneracy is sufficient and not necessary".** *This is the third comparative claim to fail this session, after [L105](../findings/bounds-relaxations.md)'s and [L66](../findings/support-dichotomy.md)'s.*

---

## 6. DEFECT 5, the two repairs, and the two censuses, disagree inside one file

**The repairs.** [isotropy-cap.md:241](../findings/isotropy-cap.md#L241), inside [L80](../findings/isotropy-cap.md#L233)'s block, forty lines above L81, asserts *"the $\mathfrak c\ne0$ gap that corrected L32 **and L81**"*. [findings/LEDGER.md:252](../findings/LEDGER.md#L252) says of L81 *"$p\ge2$ added"*, and [LEDGER.md:285](../findings/LEDGER.md#L285) again attributes the $\mathfrak c\ne0$ condition to both. [REVIEW_r471.md:45](REVIEW_r471.md#L45) and [REVIEW_r472.md:5](REVIEW_r472.md#L5) both write it as "the $\mathfrak c\ne0$ / $p\ge2$ gap", as though the two were one condition. **They are one condition only under reading (T)**; under (R) they differ by the whole rank-$2$ range. The record has three places saying $\mathfrak c\ne0$ and two saying $p\ge2$, the second being [findings/INDEX-results.md:96](../findings/INDEX-results.md#L96), row $81$, with no line reconciling them. *That row is also malformed: its verdict text runs "…Otherwise unaudited. the sharp centraliser criterion, wider than Lemma L32", the result's own name having been appended after the sentence that ends the verdict.*

**The censuses.** L32's block certifies *"at all $29$ multiplicity partitions to $m=12$ and at $m=14,16$"*; L81's block certifies *"at all 26 multiplicity partitions for $m=4,\dots,12$"*. Same object, same upper range, two counts, six lines apart in one file, and neither block defines what a multiplicity partition is. *Screen, by hand:* under the natural reading (partitions of the torus rank $\lfloor m/2\rfloor$), the even $m$ from $2$ to $12$ give $1+2+3+5+7+11=29$, matching L32's figure exactly, while $m=4$ to $12$ even gives $28$ and all $m$ from $4$ to $12$ gives $45$. **No reading I can construct returns $26$.** Reported as a screen: it locates the discrepancy, it does not settle which number is right.

**Verdict: REPAIRED.** Both are recording defects with no effect on the mathematics of §2. The repairs must be stated as one condition; the two counts must be reconciled or both dropped.

---

## 7. DEFECT 6, three live copies of the refuted statement, found by grepping the statement

The record says the radius is closed: [LEDGER.md:252](../findings/LEDGER.md#L252) reads *"Nothing cites L81, so its radius closes there."* **Grepping the identifier confirms that and is the wrong instrument.** Of the $31$ occurrences of the string `L81` outside this report and its twin, $14$ are line anchors of the form `plan.md#L81` or `INDEX-results.md#L81`, and one is [Hashimoto](../references/hashimoto-2023-hilbert-mumford-nilsolitons/notes.md)'s own theorem numbering "L76–L81". **The "cited 33 times" figure in my brief is an artefact of that collision; sixteen mentions are genuine, of which two sit in [findings/](../findings/) prose and the rest in review reports and [reviews/INDEX.md](INDEX.md).**

Grepping the *statement* instead finds three copies that the correction never reached:

| location | text | status |
| --- | --- | --- |
| [results.md:432](../results.md#L432) | *"Let $x\in\mathfrak{so}(m)$ be nonzero and $\mathfrak c=\mathfrak z(x)\cap x^\perp$. Then $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$, except when…"* | **the refuted statement verbatim, no hypothesis.** [r463](REVIEW_r463.md#L114) named this line explicitly, *"the repair is one clause in the statement, in isotropy-cap.md, results.md lines 150 and 430, and Lemma L81"*. Line $150$ was repaired; **line $430$ was not** |
| [report/sections/07-gradedness-split.tex:1021](../report/sections/07-gradedness-split.tex#L1021) | *"For skew $x$ with $\mathfrak c=\mathfrak z(x)\cap x^\perp$, one has $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\R x$ --- unless…"* | **the refuted statement, in the deliverable** |
| [ATTEMPTS.md:2100](../ATTEMPTS.md#L2100) | *"the collapse fails **iff the singular-value vector is proportional to a root of $D_p$, i.e. iff $x$ is a multiple of a rank-4 complex structure**, degenerate $x$ included"* | **L81's own statement, uncorrected**, and false at $m=3$ by the recorded witness |

The one place the criterion is actually *used* is safe: [stratum-two-negative.md:158](../findings/stratum-two-negative.md#L158) cites **L32**, not L81, and discharges the hypothesis in the same sentence, *"whose hypothesis $\mathfrak c\ne0$ holds here"*. [REVIEW_r512.md:98](REVIEW_r512.md#L98) confirms independently that [L33](../findings/stratum-two-negative.md) takes only L32's weaker form and *"does not need L32's stronger 'iff' form"*. **So no downstream mathematics is wrong; three statements of it are.**

**Verdict: REPAIRED**, on the record's own instructions from [r463](REVIEW_r463.md), which were applied to one of the two lines it named.

---

## 8. What the block gets right

Recorded because an audit that lists only defects misprices the block.

- **The criterion itself is true**, as stated with its hypothesis, under either reading of $p$, §2 derives it from the definitions by a route sharing nothing with the block's, using isotypic decomposition on the kernel side where the block uses roots.
- **The witness is correct and correctly diagnosed.** $x=e_{12}\in\mathfrak{so}(3)$ gives $\dim Z=3$, and $\mathfrak{so}(3)$ carries no $4$-plane, so the stated exception genuinely fails to cover it (§2 Step E).
- **"Nondegeneracy is sufficient and not necessary" is right**, and so is the threshold: at even $m\ge6$ a nondegenerate $x$ has $r=m/2\ge3$, and §2 Step C excludes a root proportionality outright.
- **"A rank-4 $J$ padded into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$ returns $3$ every time"** is right, and §2 Step F extends it to every $m\ge4$.
- **The $\dim Z\in\{1,3\}$ dichotomy** (the value $2$ never occurs), is true and is not claimed anywhere; it is free from §2 and would strengthen the block.
- **The block's norm exposure is nil.** The criterion is dimensional, so the $\Lambda^2$ half-trace against plain Frobenius question that [conventions.md](../findings/conventions.md) flags as live cannot touch it.

---

## 9. Verdicts

| # | defect | verdict |
| --- | --- | --- |
| 1 | $p$ undefined in the block, two readings, two different hypotheses | **REPAIRED**, name the reading |
| 2 | "REQUIRES $p\ge2$" is not sharp and misquotes [r463](REVIEW_r463.md), dropping "or $\dim\ker x\ge2$"; the $n\ge12$ hedge is false under (R) and empty under (T) | **REPAIRED**, the hypothesis is $m\ge4$ |
| 3 | the proof's root step is stated over $D_p$ where odd $m$ gives $B_p$; the degenerate clause names $\mathfrak{so}(\ker x)$ and never uses it, so the conclusion is unreached at odd $m$ | **REPAIRED**, §2 Steps D–E supply it |
| 4 | "wider than Lemma L32" | **REFUTED**, L32 states strictly more; the true comparative is "wider than nondegeneracy", which is the body's own |
| 5 | $\mathfrak c\ne0$ against $p\ge2$ across four locations; $26$ against $29$ multiplicity partitions six lines apart | **REPAIRED**, recording defects, no mathematical effect |
| 6 | the refuted statement live at [results.md:432](../results.md#L432), [07-gradedness-split.tex:1021](../report/sections/07-gradedness-split.tex#L1021) and [ATTEMPTS.md:2100](../ATTEMPTS.md#L2100); "nothing cites L81" rests on an identifier grep that collides with line anchors | **REPAIRED**, no consumer is outside its hypotheses, but three statements are wrong |

**Overall: REPAIRED.** The lemma is true and I have derived it; the block that carries it needs the six repairs above, of which §3 (the hypothesis) and §4 (the odd-$m$ root system) change what a reader can check.

**The sharp form the record should carry:**

> Let $x\in\mathfrak{so}(m)$ be nonzero, $m\ge4$, and $\mathfrak c=\mathfrak z(x)\cap x^\perp$. Then $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ is $\mathbb Rx$ unless $x$ is a multiple of a complex structure on a $4$-dimensional subspace, where it is a $3$-dimensional $\mathfrak{su}(2)$; no other value occurs. Equivalently, the collapse fails iff the singular-value vector of $x$ on its own support is proportional to a root of $D_r$, $2r=\mathop{\mathrm{rank}}x$. The hypothesis $m\ge4$ is exactly $\mathfrak c\ne0$ and is sharp: at $m=3$ the collapse fails at every nonzero $x$.
