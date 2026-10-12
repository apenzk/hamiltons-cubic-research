# Review r651, Lemma L59, the certificate's necessary condition as a dimension count

**Reviewer A of a pair on identical briefs. Review number 651.** Target: [findings/sym3-blocks.md:157](../findings/sym3-blocks.md#L157) (heading) with its body at lines 159–166, and the section its provenance note names, [The constraint count](../findings/sym3-blocks.md#L44).

**Analysis only. No computation was run.** Every number below is derived by hand from the block table at [findings/sym3-blocks.md:22](../findings/sym3-blocks.md#L22) or checked against a number already on the record.

## Verdict

**GAP.** Every mathematical claim in the block is **true**, and I re-derived each of them cold: the adjunction, both consequences, the injectivity of $\mathrm{Cat}$, and the count $65=36+29$, which I confirmed block by block by hand, arriving at $29$ and $36$ independently of the file. **Nothing here is refuted.**

The gap is that the block **cannot be checked as written**. Three things stand between a reader and the proof, and each is a defect of the record rather than of the mathematics:

| # | defect | severity |
| --- | --- | --- |
| 1 | **The pointer is false**, and false under *both* readings of `##` containment | the reader is sent to a section holding one of the block's five inputs and none of its argument |
| 2 | $\mathrm{Cat}_F$ **is defined nowhere in [findings/](../findings/)**, [conventions.md](../findings/conventions.md) included | the central identity is unreadable until the reader supplies the definition, and the identity is *true for any definition consistent on both sides*, so supplying the wrong one is invisible |
| 3 | $\mathrm{rank}$ and $\mu$ each carry **two different maps, four lines apart, inside this one block** | $\mathrm{rank}$ means the *restricted* map; $\mu$ in "$\mu$ is surjective" means the *unrestricted* one. Under the other reading of either, one of the two sentences is false |

**L62 may rest on L59 as it does.** The identification *"$\dim\mathrm{ann}=1$ and $\mathrm{rank}=13$ are one claim"* is exactly the adjunction plus rank–nullity for the adjoint, and it is sound, see [§2.1](#21-rank-14-dimmathrmann) and [§5](#5-may-l62-rest-on-l59). L59 carries no circular dependency on L62 and no dependency on any measurement. **The dependency is legitimate; what is missing is the citation.**

## 0. The reading I adopt, symbol by symbol

The brief asks for this explicitly. **[conventions.md](../findings/conventions.md) carries none of L59's five symbols**, and two of them collide with entries it does carry.

| symbol | reading I adopt | in [conventions.md](../findings/conventions.md)? |
| --- | --- | --- |
| $K$ | the cubics vanishing on the orbit: $K=\{f\in\mathrm{Sym}^3\mathcal W_5^*:\ f(gW_0)=0\ \forall g\in O(5)\}$. Blockwise $K=\bigoplus_\lambda K_\lambda\otimes V_\lambda$ with $K_\lambda\subseteq M_\lambda$ | **no, and it COLLIDES.** [conventions.md](../findings/conventions.md) fixes $K$ as *the symmetric hollow $n\times n$ sectional matrix*, $K_{ab}=W_{abab}$. Two unrelated objects under one letter |
| $\mathrm{ANN}$ | $\{F\in(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}:\mathrm{Cat}_F(K,K)=0\}$, $F$ ranging over the **invariant** sextics only, as the block says | no |
| $\mathrm{Cat}_F$ | the middle catalecticant $\mathrm{Cat}_F(f,g)=\langle F,fg\rangle=f(\partial)g(\partial)F$ for $f,g\in\mathrm{Sym}^3$ | **no, nowhere in [findings/](../findings/) at all.** The only prose definition on the record is inside a review, [r633](REVIEW_r633.md), which reads it *off L59's own apolarity line* |
| $\mu$ | multiplication $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$, a Gram to its sextic, as in [L89](../findings/sym3-blocks.md#L92) | **no, and it COLLIDES three ways.** [conventions.md](../findings/conventions.md)'s $\mu$ is the $\Lambda^2$ spectrum, or the scalar $-\min\omega$, or [target.md](../findings/target.md)'s third sense |
| "the 14" | $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$, [L85](../findings/sym3-blocks.md#L42) | no (it is L85's, not a convention) |
| $\langle\cdot,\cdot\rangle$ | the apolar (Bombieri) pairing on forms, $\langle F,G\rangle=F(\partial)G$ up to the degree factorial | **no.** [conventions.md](../findings/conventions.md)'s "Norms and pairings" section fixes only the $\Lambda^2$ and Frobenius normalisations on $\mathcal W_n$; the pairing on $\mathrm{Sym}^d\mathcal W_5^*$ is unfixed anywhere on the record |

**The two properties of the apolar pairing that L59 actually consumes, neither stated in the block:** it is $O(5)$-invariant (because $O(5)$ acts on $\mathcal W_5$ through $\Lambda^2$, orthogonally for the Frobenius product), and it is **positive definite on real forms** ($\langle x^\alpha,x^\beta\rangle=\delta_{\alpha\beta}\alpha!/d!$). The second is what makes the second consequence an *equivalence* and not one implication.

## 1. The adjunction

$$\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$$

**CONFIRMED, and it is normalisation-free.** Fix a basis $q_1,\dots,q_N$ of $\mathrm{Sym}^3\mathcal W_5^*$ and write $B$ as a symmetric matrix in it, so that $\mu(B)=\sum_{a,b}B_{ab}q_aq_b$. Then

$$\langle F,\mu(B)\rangle=\sum_{a,b}B_{ab}\,\langle F,q_aq_b\rangle=\sum_{a,b}B_{ab}\,\mathrm{Cat}_F(q_a,q_b)=\operatorname{tr}\!\big(\mathrm{Cat}_F\,B\big)=\langle\mathrm{Cat}_F,B\rangle .$$

That is one line, and it is **the definition of the adjoint $\mu^{*}=\mathrm{Cat}$**, not a theorem about apolarity. The word *"gives"* in "apolarity gives" is doing no work: the identity holds for **any** bilinear form on $\mathrm{Sym}^6$, provided the same form is what defines $\mathrm{Cat}_F$.

### The brief's question: are the two sides the same pairing?

**No, and they must not be.** They are two pairings on two different spaces:

| side | pairing | on |
| --- | --- | --- |
| $\langle F,\mu(B)\rangle$ | the apolar/Bombieri inner product | $\mathrm{Sym}^6\mathcal W_5^*$ |
| $\langle\mathrm{Cat}_F,B\rangle$ | the trace/duality pairing of a bilinear form against a symmetric tensor | $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)$ and its dual |

An adjunction between a map and its adjoint is *always* an identity between the pairing on the source and the pairing on the target. Asking them to be "the same pairing" would be a category error. **So the factor the brief warns about cannot hide here**, but it can hide in two adjacent places, and I checked both:

- **The symmetrisation.** If $p\odot q:=p\otimes q+q\otimes p$ (which is [conventions.md](../findings/conventions.md)'s own $\odot$, from the Li quotation), then $\mu(p\odot q)=2pq$ and $\langle\mathrm{Cat}_F,p\odot q\rangle=2\mathrm{Cat}_F(p,q)$. **The $2$ appears on both sides and cancels.** If instead $\odot$ carries the $\tfrac12$, it cancels again. The identity is stable under this convention **as long as one convention is used at both places**, mixing them is where a factor $2$ would enter, and the block does not name either.
- **The two forms of the catalecticant.** $\mathrm{Cat}_F(f,g)=\langle F,fg\rangle$ and $\mathrm{Cat}_F(f,g)=f(\partial)g(\partial)F$ (the form [r203](REVIEW_r203.md) uses) **agree exactly**, because the apolar pairing is symmetric: $\langle F,fg\rangle=\langle fg,F\rangle=(fg)(\partial)F=f(\partial)g(\partial)F$. No factor.

**Where the normalisation *is* load-bearing, the block attaches no warning:** positive definiteness (needed in §2.2), and $\langle v^6,h\rangle=h(v)$ exactly, which is what the *neighbouring* block at [line 124](../findings/sym3-blocks.md#L124) uses to turn $F_5\perp\mathcal A(W_0^6)$ into $F_5(W_0)=0$. **L59's one hedge about normalisation-sensitivity ("apolarity gives"), sits on the step that does not need it.**

## 2. The two consequences

### 2.1 rank $=14-\dim\mathrm{ANN}$

**CONFIRMED, with one hypothesis the block imports silently.**

Write $U=\mathrm{Sym}^2(K)^{O(5)}$ for the unknowns ($\dim U=36$, [L86](../findings/sym3-blocks.md#L56)/[L87](../findings/sym3-blocks.md#L74)) and $T=(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$ for the target ($\dim T=14$, [L85](../findings/sym3-blocks.md#L42)). The claim is about $\mu|_U:U\to T$.

$$F\perp\operatorname{im}(\mu|_U)\iff\langle F,\mu(B)\rangle=0\ \forall B\in U\iff\langle\mathrm{Cat}_F,B\rangle=0\ \forall B\in U .$$

The last condition is *a priori* weaker than $\mathrm{Cat}_F(K,K)=0$, because $U$ holds only the **invariant** forms on $K$. **They are equal, and the reason is a hypothesis the block never states:** $K$ is an $O(5)$-submodule. Given that, $\mathrm{Cat}_F|_{K\times K}$ is an *invariant* symmetric form on $K$; transport it to $C\in\mathrm{Sym}^2(K)^{O(5)}=U$ by the invariant inner product on $K$; the hypothesis then allows $B=C$, giving $\lVert C\rVert^2=0$, hence $C=0$. So

$$\mathrm{ANN}=\operatorname{im}(\mu|_U)^{\perp}\ \text{inside}\ T,\qquad \operatorname{rank}(\mu|_U)=14-\dim\mathrm{ANN}. \qquad\checkmark$$

**The submodule hypothesis is on the record and is not cited here.** It is at [findings/sym3-blocks.md:130](../findings/sym3-blocks.md#L130), *"Vanishing at $W_0$ suffices for vanishing on the orbit, because the restriction cuts the copy index and leaves $V_\lambda$ whole"*, credited to reviewer 210, twenty-nine lines above L59's block. **This is the same defect [r634](REVIEW_r634.md) flagged against L62 for the dual form of the same argument.**

#### Whose kernel is ANN, the brief's question

**Confirmed: ANN is the annihilator of the image inside the 14-dimensional target, equivalently the kernel of the *adjoint* $F\mapsto\mathrm{Cat}_F|_{K\times K}$. It is not the kernel of $\mu$ under either reading of $\mu$.** Three distinct spaces are in play and their dimensions are all different:

| space | dimension | source |
| --- | --- | --- |
| $\mathrm{ANN}=\operatorname{im}(\mu|_U)^{\perp}\subseteq T$ | $1$ | [L62](../findings/sym3-blocks.md#L187), measured |
| $\ker(\mu|_U)$, the affine family's direction space | $36-13=23$ | [findings/sym3-blocks.md:125](../findings/sym3-blocks.md#L125) |
| $\ker(\mu|_{\mathrm{inv}})$ on the full $65$ | $65-14=51$ | [L89](../findings/sym3-blocks.md#L92) |

**Does the block's phrasing distinguish them? No.** It writes a bare $\mathrm{rank}$ with no map named. This is not a pedantic complaint: [L89](../findings/sym3-blocks.md#L92), sixty-five lines above in the same file, is *titled* $\mathrm{rank}(\mu|_{\mathrm{inv}})=14$, and [L90](../findings/sym3-blocks.md#L115) uses "rank" for a **sampled** matrix. Under L89's reading L59's formula degenerates to the vacuous $14=14-0$; under L90's it is **false**, since a sampled rank is only a lower bound. The formula is true for exactly one of the three, and the block does not say which. [results.md:586](../results.md#L586) does better, *"gives $\mathrm{rank}=14-\dim\mathrm{ANN}$ on the $14$-dimensional space of invariant sextics"*, and [results.md:206](../results.md#L206) better still, *"the restricted catalecticant rank"*. **The canonical block is the least precise copy of its own statement.**

**The block also uses $\mu$ for two maps four lines apart.** In the rank formula $\mu$ is restricted to $U$; in *"$\mathrm{Cat}$ is injective on the invariant sextics, $\mu$ is surjective, so its adjoint is injective"* it is the unrestricted $\mu|_{\mathrm{inv}}$ on the $65$, since $\mu|_U$ has rank $13$ and is **not** surjective. Read the sentence with the restricted $\mu$ and it is false. This is a second, independent instance of the same ambiguity, inside one paragraph.

The injectivity claim itself is **correct**: $\mu|_{\mathrm{inv}}:\mathbb R^{65}\twoheadrightarrow\mathbb R^{14}$ ([L89](../findings/sym3-blocks.md#L92)) gives $\mu^{*}$ injective, and $\mu^{*}=\mathrm{Cat}$ by §1, so $\mathrm{Cat}$ embeds the $14$ in the $65$. $\checkmark$

### 2.2 $F_5\in\operatorname{image}\iff F_5\perp\mathrm{ANN}$

**CONFIRMED. Both halves check, and the brief's two worries resolve cleanly, one is automatic, the other rests on a property of the pairing the block does not name.**

- **$\Rightarrow$** is immediate: $F_5=\mu(B)$ with $B\in U$ and $F\in\mathrm{ANN}$ give $\langle F,F_5\rangle=\langle\mathrm{Cat}_F,B\rangle=0$.
- **Closedness of the image**: **automatic and requires no argument.** $U$ and $T$ are finite-dimensional ($36$ and $14$), so every linear image is a closed subspace. The brief flags this because it matters for infinite-dimensional analogues; here it is free.
- **Non-degeneracy**: this is the real hypothesis. $(\operatorname{im})^{\perp\perp}=\operatorname{im}$ needs the form on $T$ to be non-degenerate **on $T$**, not merely on $\mathrm{Sym}^6$. The apolar pairing is **positive definite** on real forms, and the restriction of a positive definite form to any subspace is positive definite, so it is non-degenerate on $T$. $\checkmark$ **The block never says this.** Its nearest gesture is *"$\mathrm{Cat}$ is injective"*, which is a weaker statement proved a different way (from surjectivity of $\mu$) and does **not** deliver $\perp\perp$.
- **An unstated hypothesis that is needed and is true:** the equivalence requires $F_5\in T$, i.e. that $F_5$ is an $O(5)$-invariant sextic. It is, both $\lVert W\rVert^6$ and $\operatorname{tr}(W^3)^2$ are invariants. Without it, $F_5\perp\mathrm{ANN}$ is a much weaker condition and the converse fails. **The block states $\mathrm{ANN}$'s ambient space but never $F_5$'s.**

### 2.3 The $29$, checked block by block from scratch

The block asserts $29$ and $65=36+29$. **I derived both from the table at [findings/sym3-blocks.md:22](../findings/sym3-blocks.md#L22) without using the file's numbers, and both are right.**

Partition the $24$ blocks by the parity of $\lambda_2$, per [L86](../findings/sym3-blocks.md#L56):

| | blocks | multiplicities $\sum m_\lambda$ |
| --- | --- | --- |
| $\lambda_2$ **even** | $16$, $(4,2),(2,2),(3,2),(5,2),(4,4),(4,0),(3,0),(2,0)$ and the eight $m=1$ blocks $(6,6),(6,4),(6,2),(6,0),(5,4),(5,0),(1,0),(0,0)$ | $4{+}4{+}3{+}2{\cdot}5{+}1{\cdot}8=\mathbf{29}$ |
| $\lambda_2$ **odd** | $8$, $(4,3),(4,1),(3,1),(2,1)$ at $m=2$; $(6,3),(5,3),(5,1),(3,3)$ at $m=1$ | $8+4=\mathbf{12}$ |

$29+12=41$ $\checkmark$ ([L83](../findings/sym3-blocks.md#L15)'s multiplicity total) and $16+8=24$ $\checkmark$.

- The invariant symmetric forms are $\bigoplus_\lambda\mathrm{Sym}^2(M_\lambda)$, of dimension $\sum\binom{m_\lambda+1}2=\mathbf{65}$ $\checkmark$ ([L88](../findings/sym3-blocks.md#L78)).
- **Odd block:** $K_\lambda=M_\lambda$, so a form vanishing on $K_\lambda\times K_\lambda$ vanishes outright, contributes $0$.
- **Even block:** $K_\lambda$ has codimension $1$, so the forms vanishing on it are $\binom{m_\lambda+1}2-\binom{m_\lambda}2=m_\lambda$.
- **Total: $\sum_{\lambda_2\text{ even}}m_\lambda=\mathbf{29}$.** $\checkmark$
- **And the complementary count:** $\sum_\lambda\binom{\dim K_\lambda+1}2$ over even blocks $(k=3,3,2,1,1,1,1,1$ and eight $0)$ gives $6{+}6{+}3{+}5=20$, over odd blocks $(k=2,2,2,2,1,1,1,1)$ gives $12{+}4=16$, **total $\mathbf{36}$** $\checkmark$, [L86](../findings/sym3-blocks.md#L56)'s unknown count, recovered independently.

$65=36+29$ is the exact sequence $0\to\{\Phi:\Phi|_{K\times K}=0\}\to\mathrm{Sym}^2(\mathrm{Sym}^3)^{*,O(5)}\to\mathrm{Sym}^2(K)^{*,O(5)}\to0$, restriction being surjective block by block. **Exact.** $\checkmark$

**Two prose defects sitting on top of a correct count:**

1. **"an even one keeps $u\otimes v+v\otimes u$" has no quantifier and reads as one dimension per block.** One dimension per even block is $16$, contradicting the $29$ four words later in the same sentence. The intended reading is *$u$ the fixed line annihilating $K_\lambda$, $v$ ranging over all of $M_\lambda$*, which gives $m_\lambda$ per block and sums to $29$. **The stated total is right; the stated mechanism, read literally, gives a different number.** This is the one place in the block where a careful reader is led to a wrong integer.
2. **"splits the invariant forms into those supported on $K$"** is loose. The $36$ is a *quotient* (restriction), not canonically a subspace; the direct sum exists only after choosing the invariant orthogonal complement. That choice is canonical and available, so the claim survives, but the word "splits" is doing work the block does not pay for. [r207](REVIEW_r207.md) reached the same conclusion about the same sentence independently.

### 2.4 Where the $14$ comes from

**Imported, uncited.** L59 neither derives the $14$ nor names its source. It is [L85](../findings/sym3-blocks.md#L42)'s Weyl-integration dimension $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$. Taking the brief's checklist item in full:

| number | status in L59 | true source |
| --- | --- | --- |
| $14$ | **imported**, uncited | [L85](../findings/sym3-blocks.md#L42), derived by Weyl integration in exact Laurent polynomials |
| $65$ | **imported**, uncited | [L88](../findings/sym3-blocks.md#L78), derived by Weyl integration |
| $36$ | **imported**, uncited | [L86](../findings/sym3-blocks.md#L56) + [L87](../findings/sym3-blocks.md#L74); L87's half is a **mod-$p$ Gram rank meeting its cap** |
| $29$ | **derived here**, correctly, from the block table | this block |
| codimension $1$ per even block | **imported**, uncited | [L87](../findings/sym3-blocks.md#L74), and this is the one imported ingredient that is **not** a pure theorem |
| $K$ is an $O(5)$-submodule | **imported**, uncited, and not even mentioned | [findings/sym3-blocks.md:130](../findings/sym3-blocks.md#L130) |

**L59 consumes four numbered results and cites none of them.** It is the same citation failure the record has just recorded against L62, and L62's own note ([findings/sym3-blocks.md:203](../findings/sym3-blocks.md#L203)) names L59 as one of *its* uncited dependencies. **The pattern is a chain, not an incident.**

*One consequence worth stating: because the codimension-$1$ step is [L87](../findings/sym3-blocks.md#L74)'s, the $29$ and the $36$ are **conditional on a mod-$p$ measurement**, even though L59 presents both as arithmetic. L87 argues that the measurement meets a proved cap and so forces the value, sound as far as it goes, but [findings/sym3-blocks.md:131](../findings/sym3-blocks.md#L131)'s own warning applies: "a defect landing the rank exactly *on* the cap is invisible."*

## 3. "One dimension count"

### Is the reduction exact, or does it drop a condition?

**The reduction is exact for what it addresses, and what it addresses is a strict subset of what the certificate needs.**

The certificate's condition in full is: **there exists $B\in\mathrm{Sym}^2(K)^{O(5)}$ with $B\succeq0$ and $\mu(B)=F_5$.** That is two conditions, and L59 handles only the first:

| | condition | L59's reach |
| --- | --- | --- |
| linear | $F_5\in\operatorname{im}(\mu|_U)$ | **exactly this**, reduced to $F_5\perp\mathrm{ANN}$ |
| conic | some $B$ in the resulting $23$-dimensional affine family is positive semidefinite | **untouched** |

So the heading's *"the certificate's necessary condition"* is accurate as a description of scope (the linear condition genuinely is necessary) but it names *a* necessary condition as *the* necessary condition. **The definite article is the only thing wrong with the heading.**

### Is the reduction actually a reduction?

**It is a dualisation, not a simplification, and the heading's "is one dimension count" oversells it.** The input is $\dim\operatorname{im}(\mu|_U)$; the output is $\dim\mathrm{ANN}$; the two are related by rank–nullity for the adjoint, so **neither is easier than the other**. What makes the route usable is that $\dim\mathrm{ANN}$ turns out to be small and one element of $\mathrm{ANN}$ is guessable ($\mathcal A(W_0^6)$), and that is [L62](../findings/sym3-blocks.md#L187)'s content, not L59's. **After L59 is granted, the necessary condition is exactly as open as before.**

### Does the block slide from necessary to sufficient?

**The block itself does not.** Its four sentences state the equivalence, the injectivity and the count, and claim nothing about sufficiency. **The file around it is where the slide lives:**

- [line 123](../findings/sym3-blocks.md#L123) boxes $\boxed{F_5\ \text{lies in the image}}$ as settled, while
- [line 133](../findings/sym3-blocks.md#L133) says the restricted rank is *"open in $[1,13]$"* and
- [line 141](../findings/sym3-blocks.md#L141) says *"tightness is open"*.

Three unreconciled strata, already on the record from [L62](../findings/sym3-blocks.md#L187)'s audit. **L59 sits inside that contradiction without inheriting it**, its statement is compatible with all three.

### What the certificate still owes after L59 is granted

1. **$\dim\mathrm{ANN}=1$**, [L62](../findings/sym3-blocks.md#L187), whose lower half is a sampled mod-$p$ rank, not a proof. The proved half alone gives $F_5\perp\mathcal A(W_0^6)$, which is $F_5(W_0)=0$ and is content-free.
2. **PSD feasibility** in the $23$-dimensional affine family, the entire conic half, which no dimension count reaches.
3. **The equality clause**, [L61](../findings/sym3-blocks.md#L168)'s audit established the SOS route cannot supply it, $F_5$ being even.
4. *A structural remark:* the file already claims an **exhibited** rational PSD Gram at [line 104](../findings/sym3-blocks.md#L104). If that certificate stands, items 1 and 2 are settled constructively and L59's necessary-condition apparatus is decoration. [L61](../findings/sym3-blocks.md#L168)'s audit refuted the *"denominator $10^5$"* description of that certificate but not its existence. **L59 is therefore either superfluous or load-bearing depending on the status of a result three blocks above it, and neither block says which.**

## 4. The pointer

**FALSE, and, unusually, false under both readings of `##` containment.**

The note reads: *"The statement is below; **the argument is in this file under 'The constraint count'**."*

### Which reading I use, and why it does not matter here

I use the **narrow** reading ([r633](REVIEW_r633.md)'s): a `##` section runs from its heading to the next heading of the same or higher level, and its subordinate `####` blocks are its contents. **But the verdict is the same under [r634](REVIEW_r634.md)'s wide reading**, and here is why: in this file the pattern is `#### Lemma LNN` *followed by* `## Section`, so the section carrying L85's argument is the one named. From [findings/sym3-blocks.md:44](../findings/sym3-blocks.md#L44) to the next `##` at [line 50](../findings/sym3-blocks.md#L50) there is **no `####` heading at all**. Both readings therefore return the identical extent, lines 44–49.

**This is worth stating plainly: L59's pointer verdict is immune to the ambiguity that split [r633](REVIEW_r633.md) and [r634](REVIEW_r634.md) on L62.**

### What is actually in the named section

Lines 44–49 contain exactly: the observation that an SOS certificate faces one equation per basis invariant sextic; the Weyl-integration method; **the answer $14$**; the degree sequence $1,1,4,5,14$ against the stable-range $1,2,7,19,89$; and the Lovelock-collapse remark.

**They contain no $K$, no $\mathrm{ANN}$, no $\mathrm{Cat}$, no apolarity, no adjunction, no $29$, no $36$, no $65$, and no rank formula.** The section supplies **one of L59's five inputs** (the integer $14$) and none of its argument.

### And the argument is in the block itself

The note's own structure gives it away. *"The statement is below"*, and what is below is **the statement together with its complete argument**: the adjunction, the injectivity step, the block-by-block count, the split. **The note directs a reader away from a proof that sits under its own heading.** The one thing that is genuinely elsewhere is the $14$, and the note calls that "the argument".

### Provenance, `git log -S` confirms the manufacture

`git log -S` on the phrase returns a single commit, `bbfa159b` *"docs(findings): the 24 numbered-from-the-report blocks name where their proof is"* (2026-08-31). Its diff shows the note in its first form:

> *…the argument is **the surrounding material in this file**.*

which was **vague and true**, narrowed to

> *…the argument is in this file under **"The constraint count"**.*

which is precise and false. **The same commit narrowed L59, [L61](../findings/sym3-blocks.md#L168) and [L62](../findings/sym3-blocks.md#L187) in one hunk**, giving L61 and L62 the $\Theta_5$ certificate section and L59 the constraint count. The commit body claims the seventeen retargeted notes were *"located by searching each lemma's own distinctive content rather than by title similarity"*. **For L59 that is demonstrably not what happened**: no distinctive content of L59 (not $K$, not $\mathrm{ANN}$, not $\mathrm{Cat}$, not $29$), appears in the named section. The match is by title similarity between "the certificate's necessary **condition** is one **dimension count**" and "The **constraint count**".

**Boilerplate census, as the checklist asks.** Fifteen copies of the note survive in [findings/](../findings/), distributed as [bispectral.md](../findings/bispectral.md) 3, [problem.md](../findings/problem.md) 3, [target.md](../findings/target.md) 3, [ungraded-slack.md](../findings/ungraded-slack.md) 2, and one each in [brauer-pairing.md](../findings/brauer-pairing.md), [stratum-two-negative.md](../findings/stratum-two-negative.md), [support-dichotomy.md](../findings/support-dichotomy.md) and [sym3-blocks.md](../findings/sym3-blocks.md). **The single remaining copy in this file is L59's**, L61's and L62's were replaced by their Gate 2 verdicts. **Three of this file's three narrowed pointers are now audited and all three are false.**

### Do the other pointers resolve?

The block carries no other pointer. Its four uncited dependencies ([L85](../findings/sym3-blocks.md#L42), [L86](../findings/sym3-blocks.md#L56), [L87](../findings/sym3-blocks.md#L74), [L88](../findings/sym3-blocks.md#L78)) are all in this same file and all resolve once a reader knows to look for them.

### Does the file already settle it elsewhere?

**Yes, sixteen lines above the block.** [findings/sym3-blocks.md:141](../findings/sym3-blocks.md#L141) reads *"Tightness is open, reduced to one question: $\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$… with a dimension count putting every other intersection at $14+29-65<0$."* **That is L59's first consequence and L59's $29$, stated in the file before L59's block, without citing L59.** The seventeenth instance of the record's recurring pattern.

## 5. May L62 rest on L59?

**Yes. Unreservedly on the mathematics; the citation is what is owed.**

[L62](../findings/sym3-blocks.md#L187)'s trailing note says *"$\dim\mathrm{ann}=1$ and $\operatorname{rank}=13$ are one claim, by L59's apolarity adjunction, ANN is the adjoint's kernel, not the map's"*. **Every clause of that is correct**, and §1–§2.1 above establish it independently of L62's block: the adjunction is an identity, $\mathrm{ANN}=\operatorname{im}(\mu|_U)^\perp$ inside a $14$-dimensional target, and $\operatorname{rank}=14-\dim\mathrm{ANN}$ is rank–nullity for the adjoint. So L62's *"so the rank is $13$"* and its *"$\dim\mathrm{ANN}=1$"* are the same assertion, exactly as the note says.

**Three points on the shape of the dependency:**

- **L59 carries no circularity.** Its inputs are [L85](../findings/sym3-blocks.md#L42), [L86](../findings/sym3-blocks.md#L56), [L87](../findings/sym3-blocks.md#L74), [L88](../findings/sym3-blocks.md#L78) and the submodule fact at [line 130](../findings/sym3-blocks.md#L130). **None of them consumes L62.**
- **L59 imports no measurement of its own**, but it inherits one, [L87](../findings/sym3-blocks.md#L74)'s mod-$p$ Gram rank, through the $36$ and the codimension-$1$ step (§2.4). That does not make L62's use of L59 unsound; it means the chain L87 → L59 → L62 has **two** measured links, not one, and neither block says so.
- **L62 needs only the *direction* of L59 it cites**, namely the adjunction plus non-degeneracy on the $14$. It does **not** need L59's injectivity of $\mathrm{Cat}$ or the $65=36+29$ split, which serve the separate purpose of bounding $\dim\mathrm{ANN}$ by a genericity count. **A reader who takes L62's citation of L59 as a citation of the whole block will import more than L62 uses.**

**What L62 should say and does not:** *"by L59's adjunction, together with L85's $14$ and the non-degeneracy of the apolar pairing on it."*

## 6. Summary of what is owed

| # | owed | kind |
| --- | --- | --- |
| 1 | **Repair the pointer.** The argument is the block's own body; the named section supplies only the $14$. The honest note is *"the statement and its argument are below; the $14$ is [L85](../findings/sym3-blocks.md#L42)'s"* | false statement on the record |
| 2 | **Qualify $\mathrm{rank}$** as the rank of $\mu$ restricted to the $36$ invariant Grams supported on $K$. [results.md:586](../results.md#L586) already carries better wording than the canonical block | ambiguity that makes the claim false under two of three readings |
| 3 | **Qualify $\mu$** in *"$\mu$ is surjective"* as the unrestricted map on the $65$, false for the restricted one, which is the $\mu$ of the preceding sentence | ambiguity, same paragraph |
| 4 | **Define $\mathrm{Cat}_F$** in [conventions.md](../findings/conventions.md), and fix the apolar pairing there, noting it is $O(5)$-invariant and positive definite | symbol with no definition anywhere in [findings/](../findings/) |
| 5 | **Flag the $K$ and $\mu$ collisions** with [conventions.md](../findings/conventions.md)'s existing entries, as that file does for $B$, $M$, $d$ and $\Pi$ | live cross-file symbol collision |
| 6 | **Cite [L85](../findings/sym3-blocks.md#L42), [L86](../findings/sym3-blocks.md#L56), [L87](../findings/sym3-blocks.md#L74), [L88](../findings/sym3-blocks.md#L78) and [line 130](../findings/sym3-blocks.md#L130)** | four numbered results and one hypothesis consumed uncited |
| 7 | **Quantify the $u\otimes v+v\otimes u$ clause**, $v$ ranges over $M_\lambda$, giving $m_\lambda$ per even block, not $1$ | prose that contradicts the block's own $29$ |
| 8 | **State that $F_5$ is an invariant sextic**, the unstated hypothesis of the equivalence's converse | missing hypothesis, true |
| 9 | **Say that non-degeneracy is what gives the converse**, and that it comes from positive definiteness rather than from *"$\mathrm{Cat}$ is injective"* | the block's only nod at the pairing sits on the step that does not need it |
| 10 | **Say the heading names *a* necessary condition, not *the* one**, and that the conic half is untouched | the definite article |

**No repair on this list changes a number.** $14$, $65$, $36$, $29$ and the two displayed formulas all stand exactly as written.

---

*Reviewer A, r651. Derived cold from [conventions.md](../findings/conventions.md) and the block table; no computation run, per the standing analysis-only rule. Log: [agent_logs/audit-L59-a.log](../agent_logs/audit-L59-a.log).*
