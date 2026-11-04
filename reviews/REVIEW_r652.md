# Review r652, Lemma L59, "the certificate's necessary condition is one dimension count"

**Reviewer B of a two-reviewer pair on identical briefs. Target: [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 157 and the section its provenance note names, "The constraint count". First Gate 2 audit of this result, [INDEX-results.md](../findings/INDEX-results.md) row 59 reads "no verdict on the record".**

## Verdict: GAP

**Both consequences are true and I rederive both below; the block's own $65=36+29$ count I reproduce exactly and independently. What is missing is a pairing, a distinction between two maps written with one letter, one unstated non-formal step, and the pointer.**

| item | verdict |
| --- | --- |
| the adjunction $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$ | **true, and definitional**, but exact only under one pairing choice, which the block does not name; the natural alternative inserts a global factor $2$ |
| $\mathrm{rank}=14-\dim\mathrm{ANN}$ | **true**, and it is rank–nullity for the **adjoint** $\mu_K^{*}$, not for $\mu_K$, one step of the proof is unstated |
| $F_5\in\mathrm{image}\iff F_5\perp\mathrm{ANN}$ | **true**, and both of the brief's worries are free in finite dimension |
| the $29$, and $65=36+29$ | **derived in the block and verified here exactly**, block by block, against [L83](../findings/sym3-blocks.md)'s table |
| the $14$ | **imported, uncited**, it is [L85](../findings/sym3-blocks.md)'s |
| the pointer to "The constraint count" | **FALSE**, and the same commit that made [L61](../findings/sym3-blocks.md)'s and [L62](../findings/sym3-blocks.md)'s pointers false made this one |
| may [L62](../findings/sym3-blocks.md) rest on L59 as it does? | **yes**, the dependency is real, correct and acyclic |

## 0. The readings I adopt, and what [conventions.md](../findings/conventions.md) does not carry

I read the objects as follows, because these are the only readings under which the block's own numbers close.

- **$K$**, the $O(5)$-submodule of $\mathrm{Sym}^3\mathcal W_5^{*}$ of cubics vanishing on the orbit of $W_0$; by [line 130](../findings/sym3-blocks.md) vanishing at $W_0$ alone already puts a cubic there, so "the span cut out by the orbit constraint" and "the span cut out by $\sigma_\lambda(W_0)=0$" are the same space.
- **$\mu$**, multiplication $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^{*})\to\mathrm{Sym}^6\mathcal W_5^{*}$, restricted to $O(5)$-invariants, i.e. [L89](../findings/sym3-blocks.md)'s Gram-to-sextic map. **Two restrictions of it are in play and the block writes both as $\mu$**, see §2.
- **$\mathrm{Cat}_F$**, for $F$ in the dual sextics, the middle catalecticant $\mathrm{Cat}_F(p,q)=\langle F,pq\rangle_6$; equivalently $\mathrm{Cat}=\mu^{*}$.
- **$\mathrm{ANN}$**, $\{F\in(\mathrm{Sym}^6\mathcal W_5)^{O(5)}:\mathrm{Cat}_F|_{K\times K}=0\}$, living in the **dual** of the $14$.
- **"the 14"**, $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, [L85](../findings/sym3-blocks.md).

**Five symbols this block uses are absent from or in collision with [conventions.md](../findings/conventions.md), which the brief asked me to flag.**

- **$K$ collides.** [conventions.md](../findings/conventions.md)'s "The vertex matrix" section fixes $K$ as the symmetric hollow $n\times n$ sectional matrix $K_{ab}=W_{abab}$, and the $d,d_\varphi,d_\psi$ row uses it that way. L59's $K$ is a space of cubics. **The collision is not tabled**, and it is exactly the class the file tables for $B$, $M$, $\mu$, $d$ and $\mathfrak m$.
- **$\mu$ is a fourth sense.** The file already warns that $\mu$ is the $\Lambda^2$ spectrum in [bispectral.md](../findings/bispectral.md), the scalar $-\min\omega$ thirty lines later, and a third thing in [target.md](../findings/target.md). The multiplication map is a fourth, unlisted.
- **$B$ is a further sense.** [conventions.md](../findings/conventions.md) carries the Killing form, the operator $\tfrac\theta2\mathrm{Id}-L_W$, and warns "THE LETTER $B$ MEANS TWO THINGS, live". L59's $B$ is a Gram element of $\mathrm{Sym}^2(\mathrm{Sym}^3)$.
- **$\mathrm{Cat}$, $\mathrm{ANN}$, $\mathcal A$ and $W_0$ appear nowhere in [conventions.md](../findings/conventions.md)**, and $\mathrm{ANN}$ is spelled two ways inside one file, $\mathrm{ANN}$ at lines 123, 141, 165 and 204, $\mathrm{ann}$ in [L62](../findings/sym3-blocks.md)'s heading.
- **No pairing is named anywhere in the block**, which is the substance of §1.

## 1. The adjunction

**It is true, and it is a definition rather than a theorem: $\mathrm{Cat}_F$ *is* $\mu^{*}F$.** The content is entirely in whether the two brackets are the same pairing, and the block names neither.

Write $\langle\cdot,\cdot\rangle_d$ for the apolarity pairing $\mathrm{Sym}^dV\times\mathrm{Sym}^dV^{*}\to\mathbb R$, $\langle\Phi,p\rangle=\Phi(\partial)p$, and define $\mathrm{Cat}_F(p,q)=\langle F,pq\rangle_6$ for $p,q$ cubic. Fix a basis $\{p_i\}$ of cubics and write $B=\sum_{i\le j}b_{ij}\,p_ip_j\in\mathrm{Sym}^2(\mathrm{Sym}^3V^{*})$, so that $\mu(B)=\sum_{i\le j}b_{ij}p_ip_j$ as a sextic. Then

$$\langle F,\mu(B)\rangle_6=\sum_{i\le j}b_{ij}\,\mathrm{Cat}_F(p_i,p_j)=\mathop{\mathrm{tr}}\!\big(\mathrm{Cat}_F\cdot B_{\mathrm{mat}}\big),$$

$B_{\mathrm{mat}}$ being the Gram matrix with $b_{ii}$ on the diagonal and $b_{ij}/2$ off it. **So the identity is exact when the right-hand bracket is the trace (Gram) pairing of matrices.**

**It is off by a uniform factor $2$ when the right-hand bracket is apolarity in degree two.** For $U$ any space, $\langle\Phi,b\rangle_{\mathrm{apol}}=\Phi(\partial)b$ on $\mathrm{Sym}^2U\times\mathrm{Sym}^2U^{*}$ satisfies $\partial_1^2(x_1^2)=2$ against $\mathop{\mathrm{tr}}=1$, and $\partial_1\partial_2(x_1x_2)=1$ against $\mathop{\mathrm{tr}}=1/2$: **the ratio is $2$ on the diagonal and $2$ off it alike**, so degree-two apolarity is exactly $2\times$ the trace pairing.

**Verdict: the two pairings are *not* the same pairing, and the block asserts an identity that holds under one reading and fails by $2$ under the other.** Unlike today's other convention collisions this one is **inert**: the factor is global, and both consequences L59 draws (a rank, an orthogonality), are invariant under rescaling either bracket. *The scale of $\langle\cdot,\cdot\rangle_6$ is free for the same reason: it appears on the left and again inside the definition of $\mathrm{Cat}$.* **I record it as a naming defect, not a numerical one, and I checked specifically that no number downstream moves.**

One asymmetry the block hides: $\mathrm{ANN}$ lives in $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$ and $F_5$ in $(\mathrm{Sym}^6\mathcal W_5^{*})^{O(5)}$, and the block calls both "the invariant sextics". They are identified through the invariant inner product on $\mathcal W_5$, which exists and is unique up to scale because $\mathcal W_5$ is irreducible, so the identification is legitimate, and "$F_5\perp\mathrm{ANN}$" is well posed as the plain dual pairing. [Line 125](../findings/sym3-blocks.md) hedges this correctly for the one instance it needs ("exact over $\mathbb Z$ **in both normalisations**"); L59's block hedges nothing.

## 2. $\mathrm{rank}=14-\dim\mathrm{ANN}$, whose kernel, and the step that is missing

**CONFIRMED, and the brief's characterisation is right.** Let $\mu_K:\mathrm{Sym}^2(K)^{O(5)}\to(\mathrm{Sym}^6\mathcal W_5^{*})^{O(5)}$ be the restriction, $36\to14$. Its adjoint is $\mu_K^{*}:F\mapsto\mathrm{Cat}_F|_K$, from the $14$ to the $36$. Rank–nullity for the adjoint reads

$$14=\mathop{\mathrm{rank}}(\mu_K^{*})+\dim\ker\mu_K^{*}=\mathop{\mathrm{rank}}(\mu_K)+\dim\mathrm{ANN}.$$

**So $\mathrm{ANN}$ is the kernel of the adjoint, equivalently the annihilator of $\mathop{\mathrm{image}}(\mu_K)$ inside the $14$-dimensional target. It is not the kernel of $\mu_K$, which has dimension $36-13=23$**, the number [line 125](../findings/sym3-blocks.md) already prints as "the affine family is $36-13=23$ dimensional". **[L62](../findings/sym3-blocks.md)'s audit is confirmed on both halves.** *For completeness the other kernel on the record is $\ker(\mu|_{\mathrm{inv}})=65-14=51$, [L89](../findings/sym3-blocks.md)'s; the brief's $23$ is the restricted one.*

**Does the block's phrasing distinguish them? No, and worse, it writes one letter for two different maps in four lines.** The formula $\mathrm{rank}=14-\dim\mathrm{ANN}$ is about $\mu_K$ (whose rank is $13$). The very next sentence, "$\mu$ is surjective, so its adjoint is injective", is about the **unrestricted** $\mu|_{\mathrm{inv}}$ (whose rank is $14$), the restricted map is precisely the one that need not be onto, as [line 133](../findings/sym3-blocks.md) says in as many words. **A reader who carries one reading of $\mu$ through the paragraph gets $\dim\mathrm{ANN}=0$ from the second sentence and contradicts the first.** The word "kernel" never appears, so nothing is stated falsely; nothing is stated clearly either.

**One step of the proof is genuinely absent, and it is the only non-formal step in the lemma.** The annihilator of the image is $\{F:\mathrm{Cat}_F\perp B\ \text{for every }B\in\mathrm{Sym}^2(K)^{O(5)}\}$, orthogonality against the **invariant** forms only. $\mathrm{ANN}$ as defined demands $\mathrm{Cat}_F|_{K\times K}=0$ outright, against **all** of $\mathrm{Sym}^2(K)$. One inclusion is trivial; the other needs an argument, and here it is: $\mu$ is equivariant, so $\mathrm{Cat}_F=\mu^{*}F$ is an invariant form whenever $F$ is invariant, whence $\mathrm{Cat}_F|_K$ lies in the trivial isotypic of $\mathrm{Sym}^2(K^{*})$; the perfect pairing $\mathrm{Sym}^2(K^{*})\times\mathrm{Sym}^2(K)$ annihilates distinct isotypics, so it restricts to a perfect pairing of the two trivial isotypics, and an invariant form orthogonal to every invariant form is zero. **Two lines, and the block has neither.** *Complete reducibility is what carries it, so the step is safe, but it is the same appeal to reductivity that [L89](../findings/sym3-blocks.md) spends a paragraph making explicit for its own use, so its silence here is inconsistent within one file.*

## 3. $F_5\in\mathop{\mathrm{image}}\iff F_5\perp\mathrm{ANN}$

**CONFIRMED. Both of the brief's worries are free in finite dimension, and I say so rather than manufacture depth.**

- **Closedness of the image.** $\mathop{\mathrm{image}}(\mu_K)$ is a linear subspace of a $14$-dimensional real vector space, hence closed. No topology enters; the concern is real only for infinite-dimensional or semialgebraic images, and this is neither.
- **Non-degeneracy of the pairing.** The pairing of $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$ with $(\mathrm{Sym}^6\mathcal W_5^{*})^{O(5)}$ is the restriction of a perfect pairing to matched trivial isotypics, hence perfect; so $W^{\perp\perp}=W$ for every subspace $W$ of the $14$, and in particular for the image.

**What the equivalence is worth is another matter.** Applying it needs $\mathrm{ANN}$ known, and the only unconditional member is $\mathcal A(W_0^{6})$. That member is clean and I verify it independently: $\langle\mathcal A(W_0^{6}),G\rangle_6\propto\int_{O(5)}G(gW_0)\,dg=G(W_0)$ for invariant $G$, so $\mathrm{Cat}_{\mathcal A(W_0^6)}(p,q)\propto p(W_0)q(W_0)=0$ on $K\times K$; and it is nonzero, since pairing it against $\lVert W\rVert^6$ returns $\lVert W_0\rVert^6\ne0$. **So $\dim\mathrm{ANN}\ge1$ unconditionally, and hence $\mathrm{rank}\le13$, L59's adjunction reproves [L62](../findings/sym3-blocks.md)'s cap from the dual side, which the record does not observe.** *That $\mathcal A(W_0^6)$ kills $K\times K$ uses vanishing on the whole orbit, not merely at $W_0$; [line 130](../findings/sym3-blocks.md) supplies that and [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) states it, while L59's block does not.*

**And the converse then does real work:** $\mathcal A(W_0^6)\ne0$ in $\mathrm{ANN}$ means $\dim\mathrm{ANN}=1\Rightarrow\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^{6})\Rightarrow\big(F_5\perp\mathrm{ANN}\iff F_5(W_0)=0\big)$, which holds. So the *dimension alone* does decide the necessary condition, given the standing member, a point the heading gestures at and the block never makes.

## 4. The $14$, the $29$, and what is derived against what is imported

| number | status in L59 |
| --- | --- |
| $14$ | **imported, uncited.** It is [L85](../findings/sym3-blocks.md)'s Weyl-integration count $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$. L59 derives nothing about it and names no source. |
| $65$ | **imported, uncited**, [L88](../findings/sym3-blocks.md)'s. |
| $36$ | **imported, uncited**, [L86](../findings/sym3-blocks.md)/[L87](../findings/sym3-blocks.md)'s. |
| $29$ | **derived, block by block, in L59 itself.** The one number the lemma earns. |
| $13$ | **absent from L59**, it is [L62](../findings/sym3-blocks.md)'s, and correctly so: L59 states a formula, not a value. |

**I verified the $29$ independently and it is exactly right.** From [L83](../findings/sym3-blocks.md)'s table, $16$ of the $24$ blocks have $\lambda_2$ even, and $K$ has multiplicity $m_\lambda-1$ there and $m_\lambda$ at odd $\lambda_2$. Symmetric forms on an $m$-dimensional space vanishing on a codimension-$1$ subspace form a space of dimension $m(m+1)/2-m(m-1)/2=m$, which is the block's "$u\otimes v+v\otimes u$" with $u$ the annihilating functional and $v$ free. So the forms killing $K\times K$ number $\sum_{\lambda_2\ \mathrm{even}}m_\lambda$, and the even blocks are the two $m=4$, the one $m=3$, five of the nine $m=2$, and eight of the twelve $m=1$:

$$8+3+10+8=29,\qquad \sum_\lambda\tfrac{m(m+1)}2=20+6+27+12=65,\qquad \sum_\lambda\tfrac{m'(m'+1)}2=12+3+5+12+4=36.$$

*Screened, seconds, on a table I typed from [L83](../findings/sym3-blocks.md), reported as a screen: it reproduces $41$ multiplicities, $16$ even blocks, $65$, $25$ surviving multiplicities, $36$, $29$, the shape "two $3\times3$, five $2\times2$ and nine scalars", and the eight dying blocks $(0,0),(1,0),(5,0),(5,4),(6,0),(6,2),(6,4),(6,6)$, every one of them matching [line 66](../findings/sym3-blocks.md) exactly.* **This is the strongest part of the block and it is internally consistent to the last entry.**

Two phrasing notes on the same paragraph. $65=36+29$ is not a splitting of the $65$ into two given subspaces but the rank–nullity of the surjective restriction $\mathrm{Sym}^2(\mathrm{Sym}^3)^{O(5)}\to\mathrm{Sym}^2(K)^{O(5)}$; the $36$ is naturally a **quotient**, and "those supported on $K$" needs an invariant complement to be a subspace of the $65$ at all. And the paragraph's real purpose is never stated: it sets up $\mathrm{Cat}(\text{the }14)\cap(\text{the }29)$ inside the $65$, which is the intersection whose generic dimension $14+29-65=-22$ is quoted at [line 141](../findings/sym3-blocks.md) and in [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex). **Without that sentence the second paragraph reads as an unused count.**

## 5. "One dimension count", is the reduction exact?

**The reduction is exact for the condition it names, and the condition it names is one of four the certificate owes.**

**The certificate's necessary condition, in full**, is that there exist $B\in\mathrm{Sym}^2(K)^{O(5)}$ with $B\succeq0$ and $\mu(B)=F_5$. L59 reduces the **linear** half ($F_5\in\mathop{\mathrm{image}}(\mu_K)$) and **drops the positive-semidefiniteness entirely**. Solvability puts a $23$-dimensional affine family on the table and says nothing about whether it meets the PSD cone.

**Does the block slide from necessary to sufficient? No.** L59 states an equivalence and a rank formula, claims neither existence nor sufficiency, and [line 140](../findings/sym3-blocks.md) labels consistency "exactly the open necessary condition" correctly. **I checked for the slide specifically and there is none.** The heading is accurate, with one softening: "$F_5\perp\mathrm{ANN}$" is an orthogonality, not a count, and it becomes a count only through the argument of §3 that the block does not give.

**What the certificate still owes after L59 is granted**, all of it visible elsewhere in the same file:

- **A PSD point in the $23$-dimensional family.** Supplied at [line 106](../findings/sym3-blocks.md) by an explicit rational Gram, by machine, and [L61](../findings/sym3-blocks.md)'s audit records that "rational entries at denominator $10^5$" is false, thirteen coordinates reaching $5\times10^{16}$.
- **Injectivity of evaluation on the image**, or $40$ equations give agreement at $40$ places rather than an identity, [L90](../findings/sym3-blocks.md), itself resting on a measured rank.
- **The equivariant identification of copies**, guarded by the multi-probe Schur test, [line 129](../findings/sym3-blocks.md), which also records a wrong build sampling *above* the cap.
- **$\dim\mathrm{ANN}=1$ itself**, which is [L62](../findings/sym3-blocks.md)'s **measured** half. L59 converts the necessary condition into that number; it does not produce it.
- **Equality on the orbit**, which [L61](../findings/sym3-blocks.md)'s audit shows this route cannot reach at all, $F_5$ being even.

## 6. The pointer, FALSE

*The reading I use, stated as the brief requires: I take a `##` section to run from its own heading to the next heading of any level, so "The constraint count" is [lines 44–49](../findings/sym3-blocks.md), ending where "## The 41 highest-weight vectors" begins.* **Here the choice is moot and I say so plainly: that span contains no `####` block at all, so the containment question the two L62 audits split on cannot arise, and the verdict is the same under either reading.**

**The named section is [L85](../findings/sym3-blocks.md)'s: Weyl integration in exact Laurent polynomials, the answer $14$, the degree sequence $1,1,4,5,14$, and the Lovelock cross-check.** It contains no apolarity, no catalecticant, no $K$, no $\mathrm{ANN}$, no $\mu$, no rank formula, no $29$ and no $65=36+29$. **It supplies exactly one of L59's five ingredients (the constant $14$) and none of its argument.**

Where L59's argument actually is: **the $29$-count and the $\mathrm{Cat}$-injectivity are inside L59's own block**, and the parts the block omits sit in [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex), the orbit-average description of $\mathrm{Cat}_{\mathcal A(W_0^6)}$, the genericity count $14+29-65=-22$, and the catalecticant-free criterion $\mathcal A(v^6)\in\mathrm{ANN}\iff v^3\in C$. **So, as with [L61](../findings/sym3-blocks.md), the only place the argument is composed is the LaTeX rather than the block the record designates canonical.**

**Provenance, and it is the pattern the brief predicted.** `git log -S` on the note's distinctive phrase returns a single commit, `bbfa159b`, *"docs(findings): the 24 numbered-from-the-report blocks name where their proof is"*, of 2026-08-31. Its diff to this file changes three notes at once (**L59, L61 and L62**), each from *"the argument is the surrounding material in this file"*, which was vague and true, to a named section. **The commit body claims the sections were "located by searching each lemma's own distinctive content rather than by title similarity, which had matched five different lemmas to one heading". For L59 the opposite happened**: L59's heading ends "is one dimension **count**" and the section chosen is "The constraint **count**", a title match, to a section holding none of the distinctive content. *The commit names the failure mode it then commits.* **Three of three pointers narrowed by that commit in this file are now audited, and three of three are false or contested.**

**One contrary reading is on the record and I disagree with it.** [r633](REVIEW_r633.md), auditing [L62](../findings/sym3-blocks.md), remarks in passing that L59's pointer *"resolves correctly, [L85](../findings/sym3-blocks.md)'s section being where the $14$ and the counts live"*. **I reached the opposite verdict before reading that line and hold it**: the note claims the section holds *the argument*, and "The constraint count" holds one imported constant and no step of the derivation, the adjunction, the rank identity, the equivalence and the $29$ are all absent from it, and r633's own sentence concedes that the $65=36+29$ split is argued elsewhere. *That remark was incidental to r633's target and carries none of the weight this audit does.*

*Fifteen copies of the boilerplate survive across [findings/](../findings/); eight name a section, and three of the eight carry a heading truncated mid-word, "closed modulo three nam", "whose separation role ", "is strictly wider than the subalgebra family, ", which is machine narrowing on its face and is worth a sweep beyond this audit's scope.*

## 7. Does the block's own file settle it, above or below?

**Partly, and in three places the block does not cite.** [Line 141](../findings/sym3-blocks.md) already states L59's rank formula, *"Tightness is open, reduced to one question: $\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$"*, sixteen lines **above** the block, together with the genericity count the block's second paragraph exists to set up. [Line 130](../findings/sym3-blocks.md) supplies the orbit-vanishing step that L59's only unconditional $\mathrm{ANN}$ member needs. [Line 133](../findings/sym3-blocks.md) supplies the distinction between the restricted and unrestricted $\mu$ that §2 finds collapsed. **Every gap I record is closed somewhere in the same file, and the block cites none of them.**

**Unreconciled strata, inherited rather than new.** Line 141 calls the rank *"open in $[1,13]$"*, line 121 calls it $13$ and a theorem, and L62 states $13$; [L62](../findings/sym3-blocks.md)'s audit already logged the contradiction. L59 sits between the two strata and commits to neither, which is the one respect in which its reticence helps.

## 8. May [L62](../findings/sym3-blocks.md) rest on L59 as it does?

**Yes. The dependency is mathematically real, correct, and acyclic, and it should be cited.**

L62 has two halves. **The cap $\mathrm{rank}\le13$ is proved directly**, evaluation at $W_0$ is a nonzero functional on the $14$ and every product of two cubics of $K$ vanishes there, and needs no apolarity, only [L85](../findings/sym3-blocks.md)'s $14$. **The word doing the L59 work is L62's "Hence"**: passing from $\mathrm{rank}=13$ to $\dim\mathrm{ANN}=1$ is precisely $14=\mathrm{rank}+\dim\mathrm{ANN}$, which is L59's formula and nothing else. **So L62's trailing note is right that "$\dim\mathrm{ann}=1$ and $\mathrm{rank}=13$ are one claim, by L59's apolarity adjunction, ANN is the adjoint's kernel, not the map's", and I confirm every clause of it independently.**

**L59 depends on [L83](../findings/sym3-blocks.md), [L85](../findings/sym3-blocks.md), [L86](../findings/sym3-blocks.md)/[L87](../findings/sym3-blocks.md), [L88](../findings/sym3-blocks.md) and [L89](../findings/sym3-blocks.md), and on none of [L62](../findings/sym3-blocks.md), [L90](../findings/sym3-blocks.md) or [L91](../findings/sym3-blocks.md). There is no cycle.** What is defective is the citation, not the logic: **L59 consumes five results and names none of them**, which is the same defect L62's audit found in L62, so the pair of blocks has it symmetrically, and repairing only L62 would leave half of it standing.

## 9. What I would change

- **Name the two pairings.** One clause, "$\langle\cdot,\cdot\rangle_6$ apolarity, $\langle\cdot,\cdot\rangle$ the trace pairing on Gram matrices", makes the adjunction exact instead of exact-up-to-$2$.
- **Split the two maps.** Write $\mu_K$ for the restriction and $\mu$ for the whole, and say that $\mathrm{ANN}=\ker\mu_K^{*}$, the annihilator of the image inside the $14$; add that $\ker\mu_K$ is the $23$-dimensional affine family, so the two are never read as one.
- **Add the two-line invariance step** taking $\mathrm{Cat}_F\perp\mathrm{Sym}^2(K)^{O(5)}$ to $\mathrm{Cat}_F|_{K\times K}=0$.
- **Cite [L85](../findings/sym3-blocks.md) for the $14$, [L88](../findings/sym3-blocks.md) for the $65$, [L86](../findings/sym3-blocks.md)/[L87](../findings/sym3-blocks.md) for the $36$, [L83](../findings/sym3-blocks.md) for the multiplicity table.**
- **Repair the pointer.** The honest note is that the statement and the $29$-count are in the block, the $14$ is [L85](../findings/sym3-blocks.md)'s under "The constraint count", and the fuller argument is in [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex). *Reverting `bbfa159b`'s narrowing for this note would restore something vague and true.*
- **Table $K$, $\mathrm{Cat}$, $\mathrm{ANN}$, $\mathcal A$, $W_0$ and the fourth $\mu$ in [conventions.md](../findings/conventions.md)**, and settle $\mathrm{ANN}$ against $\mathrm{ann}$.
- **[report/sections/09-status.tex](../report/sections/09-status.tex) line 14 tables L59 as "Proven".** Under this audit the formula is proven and the block is not a proof of it; the status is defensible for the mathematics and overstated for the block, and it inherits [L62](../findings/sym3-blocks.md)'s open question of whether a measured value may be tabled the same way as a theorem.

## Standing rule

**Analysis only.** Nothing here required computation. The one machine touch was a seconds-long screen of arithmetic I had already done by hand, the multiplicity table's $41$, $16$, $65$, $25$, $36$, $29$, the block shape and the eight deaths, on a table I typed for that purpose, reported as a screen and cited as evidence for nothing positive. **No rank was computed, nothing was sampled, and the whole derivation above is hand-checkable.**
