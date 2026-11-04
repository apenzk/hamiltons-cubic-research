# v69, Lemma L59's apolarity sentence: $\mathrm{rank}=14-\dim\mathrm{ANN}$ and $F_5\in\mathrm{image}\iff F_5\perp\mathrm{ANN}$

*Adjudication of finding **D2** of [Round L62](ROUND_L62.md), on the bolded sentence of [Lemma L59](../results.md), [results.md:619](../results.md), with its second original at [findings/sym3-blocks.md:303–307](../findings/sym3-blocks.md) and a third at [report/sections/07-gradedness-split.tex:897–901](../report/sections/07-gradedness-split.tex).*

**The brief was cold: the step was put neutrally, with no verdict and no prior report in hand. I ran nothing, no script, no Sage, no numerics, and I wrote none; every value below is exact and every step is by hand.** Log: [agent_logs/verify-L62-v69.log](../agent_logs/verify-L62-v69.log).

## Verdict

**`VALID AS WRITTEN`.** Both assertions are true, and both are true of the objects the record names, under the one reading that makes the sentence's two halves refer to the same map. Each is a short piece of linear algebra over an invariant nondegenerate pairing; neither imports a measurement, and neither is affected by the global normalisation constant the two L59 reviewers disagreed about.

- The **rank identity** is rank–nullity applied to the adjoint, plus one step identifying $\mathrm{ANN}$ with that adjoint's kernel.
- The **equivalence** is the double-annihilator theorem in a finite-dimensional space carrying a nondegenerate form.
- The single step both need beyond the definitions, passing from *"$\mathrm{Cat}_F$ annihilates the invariant forms supported on $K$"* to *"$\mathrm{Cat}_F(K,K)=0$"*, is two lines from the Reynolds operator, and the **same** two lines also supply the nondegeneracy of the pairing on the $14$. D2 named both as missing; they are missing from the prose and they are true, and one lemma discharges them together.

The sentence is false under exactly one reading, and it is a reading the record's own downstream use excludes: **crossing the two halves**, taking $\mathrm{rank}$ to be the unrestricted $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$ of [Lemma L89](../findings/sym3-blocks.md) while keeping $\mathrm{ANN}$ defined by $K$, gives $14=14-1$. That is the ambiguity booked as D8 and settled at [findings/conventions.md:45](../findings/conventions.md); it is a legibility defect in the sentence, not a defect in the mathematics it states.

## Which space each object lives in, and which pairing

Write $V=\mathcal W_5$, $\dim V=35$, with its $O(5)$-invariant positive definite inner product, the $\Lambda^2$-level half-trace pairing of [findings/conventions.md](../findings/conventions.md), whose normalisation plays no role below beyond being invariant and definite. Write $S^d=\mathrm{Sym}^dV^*$ for the degree-$d$ forms on $V$.

| object | lives in | dimension | source |
|---|---|---|---|
| $K$ | an $O(5)$-submodule of $S^3$, the cubic forms vanishing on $O(5)\cdot W_0$ | $4200$ | [L86](../findings/sym3-blocks.md), [L87](../findings/sym3-blocks.md); submodule property at [sym3-blocks.md:234](../findings/sym3-blocks.md), dimension at [sym3-blocks.md:253](../findings/sym3-blocks.md) |
| $U=\mathrm{Sym}^2(S^3)^{O(5)}$ | invariant symmetric forms on $\mathrm{Sym}^3$ | $65$ | [L88](../findings/sym3-blocks.md) |
| $U_K=(\mathrm{Sym}^2K)^{O(5)}$ | the invariants supported on $K$, the certificate's unknowns | $36$ | [L86](../findings/sym3-blocks.md)/[L87](../findings/sym3-blocks.md) |
| $S=(S^6)^{O(5)}$ | the invariant sextics | $14$ | [L85](../findings/sym3-blocks.md) |
| $\mu_K\colon U_K\to S$ | multiplication, restricted |, | [L89](../findings/sym3-blocks.md), [L91](../findings/sym3-blocks.md) |
| $\mathrm{ANN}$ | a subspace of $S$ | $1$, by [L62](../results.md) | the step under adjudication |

**The pairing, which the record never names, this is the reading I adopt.** On $S^6$ take the apolar (Bombieri) inner product induced by the inner product on $V$: the unique invariant symmetric form for which the sixth power $v^6$ reproduces evaluation,
$$\langle F,\,v^6\rangle=F(v)\qquad\text{for every }F\in S^6,\ v\in V,$$
equivalently $\langle u^6,v^6\rangle=\langle u,v\rangle^6$. It is positive definite (its Gram on sixth powers is the sixth Hadamard power of a positive definite matrix, and sixth powers span $S^6$), and it is $O(5)$-invariant because the inner product on $V$ is. The same construction gives the invariant definite pairing on $\mathrm{Sym}^2(S^3)$ used on the right-hand side.

**This is the record's own reading**, pinned by two of its sentences rather than by my choice: [report/sections/07-gradedness-split.tex:912](../report/sections/07-gradedness-split.tex) says *"apolarity makes $\mathrm{Cat}_{v^6}$ the rank-one form $(f,g)\mapsto f(v)g(v)$"*, which is exactly $\langle v^6,fg\rangle=(fg)(v)$; and [sym3-blocks.md:253](../findings/sym3-blocks.md) calls the apolar pairing *"reproducing"*. Under it the catalecticant of a sextic is
$$\mathrm{Cat}_F(f,g)=\langle F,\,fg\rangle,\qquad f,g\in S^3,$$
a symmetric bilinear form on the space of cubic **forms**, which is the space $K$ sits in, so $\mathrm{Cat}_F(K,K)=0$ parses without any further transport. Taking this as the definition of $\mathrm{Cat}$ makes the displayed adjunction $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$ an identity with no constant at all on decomposables $B=f\odot g$, and hence on all of $\mathrm{Sym}^2(S^3)$ by bilinearity, up to whatever factor the symbol $\odot$ carries. Under the classical differential definition of the catalecticant the two sides differ by a factor depending only on the degrees $(3,3,6)$, hence **one global constant**, which is the reviewers' disputed $2$. Both consequences below are invariant under rescaling $\mathrm{Cat}$ by a nonzero scalar, so the dispute is inert, as the [L59](../findings/sym3-blocks.md) Gate 2 note says.

**Where the second reading admissible from the words leads.** One may instead read $\mathrm{Cat}_F$ classically, as a form on $\mathrm{Sym}^3V$ rather than on $\mathrm{Sym}^3V^*$, with $K$ transported across by the invariant identification $V\cong V^*$. Everything below goes through verbatim, with $\mathrm{Sym}^3V$ and $\mathrm{Sym}^3V^*$ exchanged throughout; the two readings differ by an isomorphism that is invariant, so no dimension and no kernel moves.

## The one lemma both halves need

> **Lemma (Reynolds transfer).** Let the compact group $G$ act on finite-dimensional real spaces $M$ and $N$ with an invariant nondegenerate pairing $\langle\cdot,\cdot\rangle\colon M\times N\to\mathbb R$, and let $R$ be the Reynolds operator (Haar average). Then
> 1. for $x\in M^G$ and any submodule $P\subseteq N$: $\ \langle x,P\rangle=0\iff\langle x,P^G\rangle=0$;
> 2. the restriction of the pairing to $M^G\times N^G$ is nondegenerate.

*Proof.* (1) The forward direction is trivial. Conversely, let $p\in P$. Invariance of the pairing and of $x$ give $\langle x,p\rangle=\langle g\cdot x,g\cdot p\rangle=\langle x,g\cdot p\rangle$ for every $g\in G$; averaging over Haar measure, $\langle x,p\rangle=\langle x,Rp\rangle$, and $Rp\in P^G$ because $P$ is a submodule. So $\langle x,P^G\rangle=0$ forces $\langle x,p\rangle=0$. (2) Apply (1) with $P=N$: if $x\in M^G$ pairs to zero with $N^G$ then it pairs to zero with all of $N$, hence $x=0$ by nondegeneracy; symmetrically in the other argument. $\square$

Both parts are elementary and neither needs positivity, only invariance, nondegeneracy, and compactness of $O(5)$. Part (2) can also be read as: an invariant nondegenerate pairing makes distinct isotypic components mutually orthogonal, so it restricts nondegenerately to the trivial one.

## Half one, the rank identity

Let $\mu_K\colon U_K\to S$ be multiplication restricted to the invariants supported on $K$. Its codomain is $S$ and not merely $S^6$, because $\mu$ is $O(5)$-equivariant (multiplicativity of the action) and $U_K$ consists of invariants. Write $\mathrm{rank}:=\dim\mathop{\mathrm{im}}\mu_K$.

**Step 1, the adjoint.** Part (2) of the lemma makes the apolar pairing nondegenerate on $S$, so it identifies $S^*\cong S$; likewise on $U$ and hence on $U_K$. Under those identifications the adjoint of $\mu_K$ is
$$\mu_K^*\colon S\to U_K,\qquad \mu_K^*(F)=\Pi_{U_K}\mathrm{Cat}_F,$$
$\Pi_{U_K}$ the orthogonal projection, and the defining property of the adjoint is precisely the displayed adjunction $\langle F,\mu_K(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$ for $B\in U_K$. **The adjunction is therefore the definition of the adjoint rather than an imported theorem**, exactly as the Gate 2 note on [L59](../findings/sym3-blocks.md) says; what the record owes is naming the pairing, not proving the identity.

**Step 2, the kernel of the adjoint is $\mathrm{ANN}$.** For $F\in S$,
$$F\in\ker\mu_K^*\iff\langle\mathrm{Cat}_F,B\rangle=0\ \ \forall B\in U_K=(\mathrm{Sym}^2K)^{O(5)}.$$
Now $\mathrm{Cat}_F$ is $O(5)$-invariant, being the image of an invariant $F$ under the equivariant map $\mathrm{Cat}=\mu^*$; and $\mathrm{Sym}^2K$ is a submodule of $\mathrm{Sym}^2(S^3)$, because $K$ is a submodule. Part (1) of the lemma, with $x=\mathrm{Cat}_F$ and $P=\mathrm{Sym}^2K$, upgrades the display to $\langle\mathrm{Cat}_F,\mathrm{Sym}^2K\rangle=0$, which by polarisation in characteristic zero is $\mathrm{Cat}_F(f,g)=0$ for all $f,g\in K$, that is, $\mathrm{Cat}_F(K,K)=0$. Hence
$$\ker\mu_K^*=\{F\in S:\mathrm{Cat}_F(K,K)=0\}=\mathrm{ANN}.$$

**Step 3, rank–nullity.** $\mathrm{rank}(\mu_K)=\mathrm{rank}(\mu_K^*)=\dim S-\dim\ker\mu_K^*=14-\dim\mathrm{ANN}$. $\blacksquare$

Two remarks on what this does and does not use.

- The number $14$ enters once, as $\dim S$, and it is [L85](../findings/sym3-blocks.md)'s machine count. The identity itself is dimension-agnostic: it reads $\mathrm{rank}=\dim S-\dim\mathrm{ANN}$ at any $n$.
- The clause the sentence attaches (*"$\mathrm{Cat}$ is injective on the invariant sextics because $\mu$ is surjective"*), is **not needed** for the rank identity; it serves the $65=36+29$ picture that follows. It is nonetheless true, and more cheaply than stated: $\mathrm{Cat}_F=0$ gives $\langle F,\mu(B)\rangle=0$ for every $B$, so $F\perp\mathop{\mathrm{im}}\mu=S^6$ and $F=0$. Surjectivity of $\mu$ on the full space suffices; invariance is not consumed. This matches [Round L62](ROUND_L62.md)'s D10, which recorded the clause as an unused import, it is unused *here*, and it is correct.

## Half two, the membership equivalence

$F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2$ is a sextic and is $O(5)$-invariant, both summands being invariants; so $F_5\in S$, which is what lets the question be asked inside the $14$ at all.

$\mathop{\mathrm{im}}\mu_K\subseteq S$ is a subspace of a finite-dimensional space carrying a nondegenerate form (Lemma, part 2). Step 2 above says $\mathrm{ANN}=\ker\mu_K^*=(\mathop{\mathrm{im}}\mu_K)^{\perp}$, the orthogonal complement taken **inside $S$**. The double-annihilator theorem for a nondegenerate form on a finite-dimensional space gives $(\mathop{\mathrm{im}}\mu_K)^{\perp\perp}=\mathop{\mathrm{im}}\mu_K$, whence
$$F_5\perp\mathrm{ANN}\iff F_5\in\mathrm{ANN}^\perp=(\mathop{\mathrm{im}}\mu_K)^{\perp\perp}=\mathop{\mathrm{im}}\mu_K.\qquad\blacksquare$$

The forward direction is free; the content is the reverse one, and it is exactly where nondegeneracy on $S$ is load-bearing. With the apolar inner product the form on $S$ is positive definite, so there are no isotropic subspaces and the theorem applies with room to spare; part (2) of the lemma shows it would apply for **any** invariant nondegenerate pairing, definite or not, which is why the record's silence about the pairing does not endanger this half.

**Two scope statements the sentence carries implicitly and correctly.**

- *"image"* is the image of the **linear** map $\mu_K$, not of the PSD cone inside $U_K$. So the equivalence certifies solvability of the linear system and not the existence of a sum-of-squares certificate; the record is consistent about this, calling the count *"the necessary condition"* here and reserving the PSD point for [L90](../findings/sym3-blocks.md)/[L91](../findings/sym3-blocks.md).
- $\mathrm{rank}$ is the rank of the **abstract** map, not of any sampled coefficient matrix. [L89](../findings/sym3-blocks.md)'s correction (the sampled matrix has rank $\le$ the true one), bites on [L62](../results.md)'s value, not on L59's identity, which asserts nothing about samples.

## Cross-check: the identity is consistent with the record's own value of $\mathrm{ANN}$

Not a proof of anything above, but a check that my reading of $\mathrm{Cat}$ is the record's. Under it,
$$\mathrm{Cat}_{\mathcal A(W_0^6)}(f,g)=\Big\langle \int_{O(5)}(gW_0)^6\,dg,\ fg\Big\rangle=\int_{O(5)}f(gW_0)\,g(gW_0)\,dg,$$
which vanishes for $f,g\in K$ because every element of $K$ vanishes on the **whole orbit**, not merely at $W_0$, so $\mathcal A(W_0^6)\in\mathrm{ANN}$, as [results.md:631](../results.md) and [report/sections/07-gradedness-split.tex:910](../report/sections/07-gradedness-split.tex) assert. And $\langle F,\mathcal A(W_0^6)\rangle=\int F(gW_0)\,dg=F(W_0)$ for invariant $F$, so $F_5\perp\mathcal A(W_0^6)$ is exactly $F_5(W_0)=0$. Both of the record's downstream sentences fall out of the reading, which is the strongest evidence available that the reading is the intended one.

## Every hypothesis the sentence needs, and where the record states it

| # | hypothesis | needed by | stated on the record? |
|---|---|---|---|
| H1 | a nondegenerate $O(5)$-invariant pairing on $S^6$, and one on $\mathrm{Sym}^2(S^3)$, with respect to which $\mathrm{Cat}=\mu^*$ | both halves | **no.** The pairing is named nowhere; [findings/conventions.md:45](../findings/conventions.md) states the adjunction without saying in which pairing. Reconstructible from [07-gradedness-split.tex:912](../report/sections/07-gradedness-split.tex)'s $\mathrm{Cat}_{v^6}=(f,g)\mapsto f(v)g(v)$ |
| H2 | that pairing restricts nondegenerately to the $14$ | rank identity (to write $\mathrm{ANN}$ as a space of sextics) and, critically, the $\Leftarrow$ of the equivalence | **no.** Named as missing by D2; two lines from the Reynolds lemma above |
| H3 | $K$ is an $O(5)$-submodule of $S^3$ | the transfer from invariant forms to all of $K\times K$ | **yes**, [sym3-blocks.md:234](../findings/sym3-blocks.md): *"the restricted cubics form an $O(5)$-submodule"* |
| H4 | Reynolds averaging over the compact $O(5)$, characteristic zero | the same transfer; also polarisation | **partly.** [L89](../findings/sym3-blocks.md) invokes the Reynolds operator on compact $O(5)$ for exactness of invariants; the transfer step itself is stated nowhere, and the [L59](../findings/sym3-blocks.md) Gate 2 note books it as *"one step genuinely absent"* |
| H5 | $\mathrm{ANN}$ ranges over the **invariant** sextics, i.e. sits inside the $14$ | both halves | **yes at this site**, [results.md:619](../results.md) says *"the $O(5)$-invariant sextics $F$"*; booked as omitted at [L91](../findings/sym3-blocks.md)'s third bullet and at [findings/conventions.md:45](../findings/conventions.md) |
| H6 | $\mu$ is $O(5)$-equivariant, so $\mathop{\mathrm{im}}\mu_K\subseteq S$ and $\mathrm{Cat}_F$ is invariant for invariant $F$ | both halves | **yes**, [sym3-blocks.md:188](../findings/sym3-blocks.md) |
| H7 | $F_5$ is an invariant sextic | the equivalence | **yes**, throughout [L61](../results.md) |
| H8 | $\mathrm{rank}$ and $\mathrm{image}$ refer to the **same restricted** map $\mu_K$ whose $K$ defines $\mathrm{ANN}$ | both halves | **no at this site.** The sentence writes $\mu$ for the restricted map and, one sentence later, for the unrestricted one; settled at [findings/conventions.md:45](../findings/conventions.md) and consumed correctly by [L62](../results.md) and [L90](../findings/sym3-blocks.md) |
| H9 | $\dim S=14$ | the numeral only | **yes**, [L85](../findings/sym3-blocks.md), a single unreplicated machine count, and the identity's only imported number |

So of the nine, four are unstated at this site (H1, H2, H4, H8) and none is false. H8 is the only one whose violation would make the sentence say something false, and it is a naming failure with a settled convention behind it.

## The strongest defence of the step, and it succeeds

The defence is that the sentence is not making a claim about the certificate at all, it is transcribing a single, standard fact of equivariant linear algebra into the record's notation, and the fact holds for **any** compact group, any invariant nondegenerate pairing, any submodule $K$, and any degree split. Stripped of the $n=5$ furniture it reads:

> Let $G$ be compact, $\mu\colon U\to S$ a $G$-map between finite-dimensional real modules, $\langle\cdot,\cdot\rangle$ invariant and nondegenerate on each side, $K$ a submodule, and $\mu_K$ the restriction of $\mu$ to $(\mathrm{Sym}^2K)^G$. Then $\mathrm{rank}(\mu_K)=\dim S^G-\dim\ker(\mu_K^*)$, and a vector of $S^G$ lies in $\mathop{\mathrm{im}}\mu_K$ if and only if it is orthogonal to that kernel.

Every step is forced: the adjoint exists because the pairings are nondegenerate, its kernel is the annihilator of the image because that is what an adjoint's kernel is, the annihilator computed against invariants equals the annihilator computed against everything because the Reynolds operator maps a submodule onto its invariants, and the annihilator of the annihilator returns the image because the space is finite-dimensional. **Nothing in the chain can be weakened by a normalisation, a basis choice, a real-versus-Hermitian question, or a measurement.** That is why the two [L59](../findings/sym3-blocks.md) reviewers who disagreed about the factor $2$ nonetheless agreed no downstream number moves: a global scalar on $\mathrm{Cat}$ changes neither $\ker\mu_K^*$ nor the relation $\perp$.

The defence's one exposed joint is H8, and it is exposed by the prose rather than by the mathematics: the sentence uses one symbol for two maps whose ranks differ by exactly the quantity under discussion. A reader who crosses them gets $14=13$. **The repair is one word in each half** (*restricted*) and it changes no number, which is what the [L59](../findings/sym3-blocks.md) Gate 2 note also concluded about every repair owed on that block.

## What this verdict does and does not license

- It licenses the **identity**. It licenses nothing about $\dim\mathrm{ANN}=1$, which is [L62](../results.md)'s measured half and is not in scope here; if that value is wrong, both sides of the identity move together and the identity stays true.
- It leaves D2's factual core standing as a **statement defect**: H1, H2 and H4 are genuinely absent from the canon. They are cheap and true, so the correct disposition is a repair (name the pairing, and add the Reynolds line) rather than a downgrade of L59.
- The clause *"$\mathrm{Cat}$ is injective on the invariant sextics"* and the $65=36+29$ split are inert with respect to the bolded sentence, confirming [Round L62](ROUND_L62.md)'s D10 from the other direction: they are unused imports, and both are correct.
