# Verifier v65, Lemma L62: the cap $\operatorname{rank}\le13$, the sampled equality, $\dim\mathrm{ANN}=1$, $\mathrm{ANN}=\mathbb R\,A(W_0^6)$, and $F_5\perp\mathrm{ANN}$

The brief was cold: I worked from the two statements as quoted, from [Lemma L59](../results.md) as the setting it imports, and from the definitions at source in [conventions.md](../findings/conventions.md), [sym3-blocks.md](../findings/sym3-blocks.md) and [results.md](../results.md). **I did no numerical work of any kind, no script was run, no Sage session opened, nothing was sampled or estimated.** Every value below is exact and every value attributed to a machine run is quoted from a file already on the record, read as a source rather than executed. Where a claim has no argument on file I have said so and stopped rather than supplying one. Log: [agent_logs/verify-L62-v65.log](../agent_logs/verify-L62-v65.log).

## Claim table

| # | Claim attacked | Verdict | Reason, in a clause |
|---|---|---|---|
| 1 | Evaluation at $W_0$ is a nonzero functional on the $14$ | **CONFIRMED** | $\lVert W\rVert^6$ lies in the $14$ and is nonzero at $W_0$ for any nonzero $W_0$ |
| 2 | $\operatorname{image}(\mu_K)\subseteq\ker(\mathrm{ev}_{W_0})$, so the restricted rank is $\le13$ | **CONFIRMED AS ALGEBRA** | every element of $K$ vanishes at $W_0$ by $K$'s own definition, and a codimension-one kernel in a $14$-dimensional space is $13$-dimensional |
| 3 | "A rank computed from a sample of $K$ bounds the true rank from below" | **CONFIRMED, WRONG OBJECT NAMED** | the direction is right under either reading, but the sample is of forty *evaluation points*, not of $K$ |
| 4 | Reduction modulo $p$ can only lower the rank | **CONFIRMED** | the forty points carry integer coordinates and the entries are $p$-integral by an assert, so the $\mathbb F_p$ matrix genuinely is a reduction, unlike [L87](../findings/sym3-blocks.md)'s |
| 5 | The sampled rank equals $13$ | **HYPOTHESIS-DEBT** | one machine rank of a machine-built matrix; the equivariant identification it rides on is nowhere in L62, and a defect landing exactly on the cap is undetectable |
| 6 | $\dim\mathrm{ANN}=1$ follows from $\operatorname{rank}=13$ | **CONFIRMED AS ALGEBRA** | only the trivial inclusion $\mathrm{ANN}\subseteq\operatorname{image}^{\perp}$ is consumed, but nondegeneracy of the pairing on the $14$ is never stated |
| 7 | $\mathrm{ANN}$ is spanned by $A(W_0^6)$ | **HYPOTHESIS-DEBT** | $A$ is undefined in [results.md](../results.md), and the reproducing identity $\langle F,A(W_0^6)\rangle=F(W_0)$ that carries both halves is written down nowhere |
| 8 | $F_5\perp\mathrm{ANN}$ | **CONFIRMED AS ALGEBRA** | it is $F_5(W_0)=0$ through the same unstated identity, and $F_5(W_0)=0$ appears in no statement of L62 |
| 9 | "It equals $13$ at four primes" | **CONFIRMED** | four row dumps near $2^{40}$ exist, each written only after `assert rk_A == 13` passed at that prime, and the record's standing objection that "four primes" is unsupported is itself refuted |
| 10 | "rank", "restricted rank", "restricted catalecticant rank" name one number | **CONFIRMED AS ALGEBRA, UNSTATED** | the three do coincide, by adjointness, but [results.md](../results.md) defines none of them and never says the L59 "rank" is the restricted one |
| 11 | L62 is cited no more strongly than it proves | **REFUTED AS STATED** | [results.md:23](../results.md) calls L62's value "proofs rather than measurements", against [09-status.tex:13](../report/sections/09-status.tex) and [INDEX-results.md:76](../findings/INDEX-results.md), which call it an Observation |

## One-line summary

**The cap is a theorem and I confirm it; the equality, and with it everything L62 is used for, is one machine rank carrying three unstated hypotheses, but the record's standing objection that "at four primes" is unsupported is wrong, the four primes near $2^{40}$ each carrying their own `assert rk_A == 13`.**

## 0. Conventions, fixed once

Quoted from the brief and from the record rather than restated in my own words.

- $\mathcal W_5$ is the space of algebraic Weyl curvature operators at $n=5$, the $O(5)$-irreducible $[2,2]$ of dimension $35$ ([sym3-blocks.md:7](../findings/sym3-blocks.md)).
- $F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$.
- $W_0$ is "the zero-padding into $\mathcal W_5$ of the $\mathbb{CP}^2$ Weyl operator", and $H=\mathrm{Stab}_{O(5)}(W_0)$. [conventions.md:44](../findings/conventions.md) carries both as "the $n=5$ base point of the $\mathrm{Sym}^3$ machinery and its stabiliser", with no normalisation attached.
- $K$ is "the span of cubics cut out by the orbit constraint" ([results.md:619](../results.md)); the orbit constraint is $\sigma_\lambda(W_0)=0$ ([sym3-blocks.md:237](../findings/sym3-blocks.md)).
- $\mu$ is multiplication $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$; I write $\mu_K$ for its restriction to $\mathrm{Sym}^2(K)^{O(5)}$, the object [L91](../findings/sym3-blocks.md)'s audit names as $\operatorname{rank}(\mu\vert_{\mathrm{Sym}^2(K)^{O(5)}})$, from the $36$ to the $14$.
- $\mathrm{Cat}_F$ is "the catalecticant of a sextic $F$, adjoint to the multiplication $\mu$ under apolarity: $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$" ([conventions.md:45](../findings/conventions.md)).
- $A(\cdot)$, written $\mathcal A(\cdot)$ in [sym3-blocks.md:227](../findings/sym3-blocks.md), is "the apolarity/dual pairing's image of a power" (the brief). It has no entry in [conventions.md](../findings/conventions.md) and no definition in [results.md](../results.md).

**Two readings of $\mathrm{ANN}$, and I say which I adopt.** The record carries the name twice with different content:

- **R1**, at [results.md:619](../results.md) and [sym3-blocks.md:257](../findings/sym3-blocks.md): $\mathrm{ANN}=\{F\ \text{invariant sextic}:\mathrm{Cat}_F(K,K)=0\}$.
- **R2**, at [conventions.md:45](../findings/conventions.md): "ANN is the annihilator of the IMAGE inside [L85](../findings/sym3-blocks.md)'s $14$-dimensional target, it is the adjoint's kernel, not $\ker\mu$".

$\mathrm{R1}\subseteq\mathrm{R2}$ always, and the reverse inclusion is the step [L59](../findings/sym3-blocks.md)'s audit records as "genuinely absent". **I adopt R1**, because it is the reading in the canon file and the one L62's own sentence inherits, and I check throughout whether the reverse inclusion is ever consumed. It is not (see §4) and §4 also records that under R1 the two readings are *forced* to coincide once the rank is granted, which is a positive I owe the block.

**A second convention ambiguity, which does not bite.** $W_0$'s normalisation is not fixed anywhere: [L61](../results.md) speaks of unit $W$, while [REVIEW_r178.md:103](../reviews/REVIEW_r178.md) builds $W_0=2w_1w_1^{\mathsf T}-w_2w_2^{\mathsf T}-w_3w_3^{\mathsf T}$ with eigenvalues $(4,-2,-2)$ on the self-dual forms. Nothing in L62 depends on the choice: the cap needs $W_0\ne0$ only, $F_5$ and every cubic of $K$ are homogeneous so their vanishing at $W_0$ is scale-free, and $A((tW_0)^6)=t^6A(W_0^6)$ spans the same line. Recorded here so that the next reader does not spend an adjudication on it.

## Hypothesis inventory

Every hypothesis L62 carries or imports, checked against the object it is applied to, and marked by whether the written proof uses it.

| # | Hypothesis | Source | Applied to | Used by the written proof? |
|---|---|---|---|---|
| H1 | $W_0\ne0$ (in the form $\lVert W_0\rVert^6=1$) | nowhere in L62; supplied in the audit note at [sym3-blocks.md:333](../findings/sym3-blocks.md) | $W_0$, padded, so nonzero, **holds** | **Used**, and not stated in either form of the statement |
| H2 | $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ | [L85](../findings/sym3-blocks.md), one machine count | the invariant sextics at $n=5$ | **Used**; L62 cites L85 nowhere |
| H3 | Every cubic of $K$ vanishes at $W_0$ | definitional, $K$ being cut out by $\sigma_\lambda(W_0)=0$ | $K$, **holds by construction** | **Used** |
| H4 | $\lVert W\rVert^6$ is an $O(5)$-invariant sextic | unstated | trivially true | **Used** silently, inside H1 |
| H5 | $\operatorname{rank}=14-\dim\mathrm{ANN}$ | [L59](../results.md) | $\mu_K$, from the $36$ to the $14$ | **Used**, and its "rank" is ambiguous between $\mu$ and $\mu_K$, see §2 |
| H6 | The apolar pairing is nondegenerate on the $14$ | **nowhere on the record** | the $14$ | **Used**, silently: without it "$14-\dim\mathrm{ANN}$" and the adjoint-rank identity have no content |
| H7 | $\langle F,A(W_0^6)\rangle=F(W_0)$ for invariant $F$ (the reproducing property) | **nowhere on the record** as a statement; used in passing at [sym3-blocks.md:229](../findings/sym3-blocks.md) and alluded to at [sym3-blocks.md:253](../findings/sym3-blocks.md) | $A(W_0^6)$ | **Used twice**, for $A(W_0^6)\in\mathrm{ANN}$ and for $F_5\perp\mathrm{ANN}$ |
| H8 | $A(W_0^6)\ne0$ | **nowhere** | $A(W_0^6)$ | **Used**: without it "spanned by" fails |
| H9 | $F_5(W_0)=0$ | [L61](../results.md) (equality on the orbit) and the assert at [run_n5_assemble.py:1218](../scripts/runs/run_n5_assemble.py) | $F_5$ at $W_0$ | **Used**, and absent from both forms of L62 |
| H10 | The sampled matrix is built with the copies identified **equivariantly** | [sym3-blocks.md:233](../findings/sym3-blocks.md), guarded by the multi-probe Schur test | the $47$-column matrix $A$ | **Used** by the measurement; nowhere in L62 |
| H11 | The sampled entries are $p$-integral | asserted in code at [run_n5_assemble.py:1193](../scripts/runs/run_n5_assemble.py) | the reduction step | **Used**; nowhere in L62 |
| H12 | The parity rule $\dim V_\lambda^H=1\iff\lambda_2$ even | [L86](../findings/sym3-blocks.md) | the $16$ even blocks | **Not used by the cap.** Used only in *constructing* the $47$-column parametrisation, hence by the measurement |
| H13 | Every even block's evaluation map has rank exactly $1$, giving $36$ unknowns | [L87](../findings/sym3-blocks.md), whose own lower bound is a rank over $\mathbb F_{46337}$ at points built inside $\mathbb F_{46337}$ | the sixteen blocks | **Not used** by any claim of L62, see §5 for why the rank claim survives even if L87 fails |
| H14 | $\mathrm{Cat}$ is injective on the invariant sextics; the split $65=36+29$ | [L59](../results.md), carried into L62 by "in the setting of Lemma L59" | the $65$ invariant symmetric forms | **NOT USED ANYWHERE IN L62** |

**Two inventory findings, in the shape the brief names.**

- **A hypothesis nobody uses.** H14. L62 opens "In the setting of Lemma L59", which imports the injectivity of $\mathrm{Cat}$, the embedding of the $14$ in the $65$, and the block-by-block count $65=36+29$. L62 consumes exactly one sentence of L59 (the adjunction $\operatorname{rank}=14-\dim\mathrm{ANN}$) and nothing else. The $29$, the $36$ and the injectivity are inert here.
- **Steps using hypotheses nobody stated.** H1, H6, H7, H8, H9, H10, H11. Of these, H6 and H7 are load-bearing and appear on the record in no form at all: **H7 is the single identity on which both "$\mathrm{ANN}$ is spanned by $A(W_0^6)$" and "$F_5\perp\mathrm{ANN}$" rest, and the record never states it.**

## 1. Evaluation at $W_0$ is a nonzero functional on the $14$, CONFIRMED

$\lVert W\rVert^6$ is a sextic and $O(5)$-invariant, so it lies in the $14$ of H2. Its value at $W_0$ is $\lVert W_0\rVert^6$, which is nonzero for any nonzero $W_0$ and equal to $1$ under the unit normalisation. So $\mathrm{ev}_{W_0}$ does not annihilate the $14$, and $\ker(\mathrm{ev}_{W_0})\cap(\text{the }14)$ has dimension exactly $13$.

**The padded-kernel trap does not bite here.** $W_0$ is a zero-padding and therefore has a large kernel as an operator on $\Lambda^2\mathbb R^5$, [REVIEW_r178.md:103](../reviews/REVIEW_r178.md) records its spectrum as $(4,-2,-2)$ on the self-dual forms and "zero elsewhere". Every step of this section reads $W_0$ only as a *point* of the vector space $\mathcal W_5$ at which polynomials are evaluated; none of them inverts $W_0$, diagonalises it, or requires its rank. No imported result used by the cap assumes a trivial kernel. **No finding.**

## 2. The cap, CONFIRMED AS ALGEBRA, with the rank's name unfixed

**The derivation, checked step by step.** An element of $\mathrm{Sym}^2(K)$ is a sum $\sum_i q_i\odot q_i'$ with $q_i,q_i'\in K$, so $\mu$ of it is $\sum_i q_iq_i'$. By H3 each $q_i(W_0)=0$, so every element of $\operatorname{image}(\mu_K)$ vanishes at $W_0$. By §1 the invariant sextics vanishing at $W_0$ form a $13$-dimensional subspace of the $14$. Hence $\operatorname{rank}(\mu_K)\le13$. **This closes, in the six lines the record claims for it, and I confirm it independently.**

**Rank of what map, into what target.** The map is $\mu_K:\mathrm{Sym}^2(K)^{O(5)}\to(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, from the $36$ to the $14$; the rank is the dimension of the image inside the $14$; the kernel of $\mathrm{ev}_{W_0}$ is $13$-dimensional *in that same $14$*, which is the space the rank is measured in. The three requirements the brief asks after all line up.

**Are "restricted rank", L59's "rank" and "restricted catalecticant rank" one number?** Yes, but the record never says so, and it uses three names across two adjacent paragraphs of the canon:

| site | phrase | object under the charitable reading |
|---|---|---|
| [results.md:619](../results.md) | "$\mathrm{rank}=14-\dim\mathrm{ANN}$" | ambiguous between $\mu$ and $\mu_K$ |
| [results.md:631](../results.md) | "the restricted rank" | $\operatorname{rank}(\mu_K)$ |
| [results.md:206](../results.md) | "the restricted catalecticant rank" | $\operatorname{rank}$ of $F\mapsto\mathrm{Cat}_F\vert_{K\times K}$, from the $14$ to the $36$ |

The first and third agree with the second because a map and its adjoint have equal rank, but *that* needs H6 on both sides, and H6 is unstated. **The ambiguity in the first row is not idle: under the unrestricted reading [L89](../findings/sym3-blocks.md) proves $\operatorname{rank}(\mu\vert_{\mathrm{inv}})=14$ exactly, which through L59's formula gives $\dim\mathrm{ANN}=0$ and contradicts L62 outright.** What resolves it is that $\mathrm{ANN}$'s own definition mentions $K$, so the formula can only be about $\mu_K$; a reader has to notice that to avoid deriving a contradiction from two canon lemmas. This is the L59 defect already on file, and it reaches L62 unmitigated: **[results.md](../results.md) nowhere defines "restricted".**

## 3. The direction of every inequality, and what the sample is a sample of

**Sampled versus true.** Let $T$ be the $40\times47$ matrix whose $(j,k)$ entry is $\mu(B_k)(W_j)$ for the $47$ Hermitian coordinates $B_k$ and $40$ points $W_j$. Then $T$'s column space is $\mathrm{ev}_{40}(\operatorname{image}\mu_K)$, so $\operatorname{rank}T\le\operatorname{rank}\mu_K$: **sampling loses rank**, and an attained value is a lower bound for the truth. Form B's "a sampled rank is bounded above by the true one" and Form A's "bounds the true rank from below" are the same statement, and it is the right way round for the squeeze.

**Modulo $p$ versus characteristic zero.** For a $p$-integral matrix, $\operatorname{rank}_{\mathbb F_p}(\bar T)\le\operatorname{rank}_{\mathbb Q}(T)$: **reduction loses rank**, again the safe direction. The conclusion consumes both correctly, $13\le\operatorname{rank}_{\mathbb F_p}\bar T\le\operatorname{rank}_{\mathbb Q}T\le\operatorname{rank}\mu_K\le13$.

**What the sample is a sample OF, and here Form A names the wrong object.** [results.md:631](../results.md) says "a rank computed from **a sample of $K$**". The computation samples neither $K$ nor the domain $\mathrm{Sym}^2K$: it samples **evaluation points**. [run_n5_assemble.py:896](../scripts/runs/run_n5_assemble.py) draws each point as `v = [Fr(randint(-4, 4)) for _ in range(35)]` pushed through the Weyl basis (forty random integer-coefficient real Weyl tensors) and the matrix has one row per point and one column per unknown. Under the literal reading ("a sample of $K$" = a subset of the domain directions) the inequality would still point the same way, which is why I do not call this a mathematical error; but the sentence describes a computation the record did not do.

**Why the reduction step is legitimate here, unlike at L87.** [L87](../findings/sym3-blocks.md) carries an unrepaired defect, its orbit points are Cayley transforms of skew matrices drawn *inside* $\mathbb F_{46337}$, so "a mod-$p$ rank is a lower bound for the characteristic-zero rank" names a rational matrix that was never formed. **That defect does not transfer to L62.** L62's points carry integer coordinates in $\mathbb Q$, and [run_n5_assemble.py:1193](../scripts/runs/run_n5_assemble.py) reduces exact `Fraction` entries with an assert that no denominator is divisible by the prime. So the $\mathbb F_p$ matrix genuinely is the reduction of a matrix over $\mathbb Z_{(p)}$, and the inequality applies on its face. This is a point in L62's favour that the record does not make, and it matters because [results.md:23](../results.md) treats L87's rank and L62's as the same kind of object.

## 4. $\dim\mathrm{ANN}=1$ from rank $=13$, CONFIRMED AS ALGEBRA in the direction used

**What is actually consumed.** If $\mathrm{Cat}_F(K,K)=0$ then for every $B\in\mathrm{Sym}^2(K)^{O(5)}$, $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle=0$, so $F\perp\operatorname{image}(\mu_K)$. That is $\mathrm{R1}\subseteq\mathrm{R2}$, the trivial inclusion, and it is the *only* direction L62's conclusion needs: with $\operatorname{rank}\mu_K=13$ and H6, $\mathrm{R2}$ has dimension $14-13=1$, so $\dim\mathrm{R1}\le1$; with $A(W_0^6)\in\mathrm{R1}$ and H8, $\dim\mathrm{R1}\ge1$. **So the "genuinely absent" step booked against L59 (the reverse inclusion), is never used by L62, and I record that as a positive: the L59 defect does not propagate into this conclusion.** Better: the squeeze forces $\mathrm{R1}=\mathrm{R2}$, so the two readings of $\mathrm{ANN}$ coincide *as a consequence* of the measured rank rather than by the missing lemma.

**Are the adjunction's hypotheses proved or asserted?** Asserted.

- Surjectivity of $\mu$ on the full space is proved, and elementarily, [L89](../findings/sym3-blocks.md)'s audit records "every degree-6 monomial splits into two of degree 3". It is not needed by L62.
- Injectivity of $\mathrm{Cat}$ on the invariant sextics follows from that surjectivity by adjointness. It is not needed by L62 (H14).
- **Nondegeneracy of the pairing on the $14$ (H6) is needed and is nowhere on the record.** Without it, "the annihilator of a $13$-dimensional subspace of the $14$ is $1$-dimensional" does not follow, and neither does the equality of the ranks of $\mu_K$ and its adjoint. `HYPOTHESIS-DEBT: that the apolar pairing restricts to a nondegenerate form on $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$.` I do not supply the argument.

## 5. $\operatorname{rank}=13$, the measured half, HYPOTHESIS-DEBT

The cap is a theorem; equality is not derived anywhere on the record. `HYPOTHESIS-DEBT: that $\operatorname{rank}(\mu_K)\ge13$, i.e. that the annihilator of the image inside the $14$ is at most one-dimensional.` The record's only support is the machine rank, and it rides on three hypotheses L62 does not carry:

- **H10, equivariance of the copy identification.** [sym3-blocks.md:233](../findings/sym3-blocks.md) records that a non-equivariant build gives a sampled rank *above* the cap, and names the multi-probe Schur test as what guards it.
- **H11, $p$-integrality**, guarded in code, absent from the statement.
- **Attainment is not self-validating.** [sym3-blocks.md:235](../findings/sym3-blocks.md): "A defect landing the rank exactly *on* the cap is invisible." The three wrong restrictions on record were caught only by exceeding the cap. This configuration is exactly the invisible one.

**One thing I can say in the block's favour, from the record's own materials.** [ROUND_L61.md:97](ROUND_L61.md) records the *unrestricted* sampled rank at the same forty points as $14$ (the full dimension of the invariant sextics), at $1000033$, $1099511627873$ and $1099511627933$. If that holds, evaluation at those forty points is injective on the whole $14$, so $\operatorname{rank}T=\operatorname{rank}\mu_K$ with no sampling loss at all, and the inequality of §3 becomes an equality. That strengthens the measured half; it does not derive it, since it is itself measured.

**A dependency the record over-states, in L62's favour.** [L87](../findings/sym3-blocks.md)'s rank-one step (H13) is *not* consumed by the rank claim. $K$ is defined by the conditions $\sigma_\lambda(W_0)=0$ whatever the evaluation maps' ranks turn out to be, so H3 and hence the cap are untouched by L87, and the columns of $T$ lie in $\operatorname{image}(\mu_{K'})$ for whatever subspace $K'\subseteq K$ the build parametrises, so the lower bound survives too. What L87 does carry is the *dimension* $36$, hence the "$36-13=23$ dimensional affine family" at [sym3-blocks.md:229](../findings/sym3-blocks.md). So L87's unrepaired lift gap reaches the family's dimension and not L62's rank.

## 6. $\mathrm{ANN}$ spanned by $A(W_0^6)$, HYPOTHESIS-DEBT on the membership

Two claims, and they separate cleanly.

- **$\dim\mathrm{ANN}=1$**, §4, granted the measurement.
- **$A(W_0^6)\in\mathrm{ANN}$**, this needs, and only needs, H7: $\langle F,A(W_0^6)\rangle=F(W_0)$ for invariant $F$. Given H7, $\mathrm{Cat}_{A(W_0^6)}(q,q')=\langle A(W_0^6),qq'\rangle=(qq')(W_0)=q(W_0)q'(W_0)=0$ for $q,q'\in K$ by H3. So **yes, it does follow from the cubics of $K$ vanishing at $W_0$**, through an identity the record never states. `HYPOTHESIS-DEBT: that $A(W_0^6)$ is the representative of the functional $F\mapsto F(W_0)$ on the invariant sextics under the apolar pairing.` The nearest thing on file is the parenthetical "the apolar pairing is reproducing" at [sym3-blocks.md:253](../findings/sym3-blocks.md), which is an aside inside a note about a different quantity, and does not define $A$.
- **$A(W_0^6)\ne0$** (H8) is required for "spanned by" and is stated nowhere.

Neither form of L62 argues either point; both assert the span.

## 7. $F_5\perp\mathrm{ANN}$, CONFIRMED AS ALGEBRA, unstated input

Given §6, $\mathrm{ANN}=\mathbb R\,A(W_0^6)$, so $F_5\perp\mathrm{ANN}$ reduces to $\langle F_5,A(W_0^6)\rangle=F_5(W_0)$, which is $0$ by H9. It follows. **What it needs about $F_5$ at $W_0$ is $F_5(W_0)=0$, and neither [results.md:631](../results.md) nor [sym3-blocks.md:346](../findings/sym3-blocks.md) states it**, it appears only at [sym3-blocks.md:229](../findings/sym3-blocks.md) ("because $F_5(W_0)=0$") and as an assert in the pipeline. In the canon, "Hence $\dim\mathrm{ANN}=1$, spanned by $A(W_0^6)$, and $F_5\perp\mathrm{ANN}$" reads as three consequences of the rank, and the third is a consequence of a fact about $F_5$ that the sentence does not mention.

**And the conclusion is empty without the measured half.** The proved part yields only $F_5\perp A(W_0^6)$, which by H7 *is* $F_5(W_0)=0$, true of any sextic vanishing at $W_0$, and already known from [L61](../results.md). The content of "$F_5\perp\mathrm{ANN}$" is entirely in $\mathrm{ANN}$ being no larger than that line. I confirm the record's own reading of this.

## 8. "At four primes", CONFIRMED, and the standing objection against it is REFUTED

The brief asks what the record supports. It supports four, and the four are locatable.

| prime | where | what was ranked |
|---|---|---|
| $1099511627873$ | [n5_rows_1099511627873.json](../scripts/runs/n5_rows_1099511627873.json) | the $40\times47$ restricted matrix $A$ |
| $1099511627917$ | [n5_rows_1099511627917.json](../scripts/runs/n5_rows_1099511627917.json) | same |
| $1099511627933$ | [n5_rows_1099511627933.json](../scripts/runs/n5_rows_1099511627933.json) | same |
| $1099511627953$ | [n5_rows_1099511627953.json](../scripts/runs/n5_rows_1099511627953.json) | same |
| $1000033$ | the default `PRIME` at [run_n5_assemble.py:97](../scripts/runs/run_n5_assemble.py), quoted at [sym3-blocks.md:225](../findings/sym3-blocks.md) | same |
| $1000003$ | reviewer 209, quoted at [sym3-blocks.md:225](../findings/sym3-blocks.md), independent code and points | same |

**Why the four dumps are themselves the evidence.** In [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) the sequence is `assert rk_A == 13` at line 1235 and the dump to `n5_rows_{PRIME}.json` at line 1245, in that order in the same block. **A row dump exists at a prime only if the rank-13 assert passed at that prime.** Four dumps exist. Independently, [REVIEW_r214.md:21](../reviews/REVIEW_r214.md) tabulates "`rank(A)` mod each of the four primes … 13, 13, 13, 13" by a reviewer's own Gaussian elimination, self-tested on planted ranks.

**So the standing objection is wrong.** [sym3-blocks.md:339](../findings/sym3-blocks.md) records, and [INDEX-results.md:76](../findings/INDEX-results.md) repeats, that "'FOUR PRIMES' IS UNSUPPORTED, AT FIVE SITES, the record names two … the four near $2^{40}$ belong to the certificate's row lift, a different computation at a different scale." The four near $2^{40}$ are a different *purpose*, the CRT lift consumes them, but they are the same rows of the same $40\times47$ restricted matrix at the same forty points, and each carries its own rank-13 assert. **I file this as a correction to the record: "at four primes" is supported, and the record understates its own evidence, which reaches six primes across three independent code paths.**

**Two caveats that keep the correction honest.**

- The referent is still unstated at all five sites, which is why the objection was raised; the repair is to name the primes, not to delete the four.
- **Logically the four add nothing.** The same fixed seed regenerates the same forty rational points at every prime ([run_n5_assemble.py:1245](../scripts/runs/run_n5_assemble.py): "The sample points are regenerated identically from the fixed seed at every prime"), so the four are four reductions of one rational matrix, and $\operatorname{rank}_{\mathbb F_p}=13$ at a *single* prime already forces $\operatorname{rank}_{\mathbb Q}\ge13$. The repetition buys confidence against a coding error, not a stronger theorem. **"At four primes" is rhetorically weighty and logically inert.**

## 9. Quantifier order, scope, and citation strength, one REFUTED AS STATED

**Scope.** Every claim is at $n=5$ and nowhere else; L62 says so by inheriting "the setting of Lemma L59", and $n=5$ is the smallest dimension the certificate route treats. The odd-$n$ steps the chain rests on, $O(5)=SO(5)\times\{\pm I\}$ with $-I$ acting as $+1$ on a $4$-tensor, used to read an $SO(5)$ block table as an $O(5)$ one, are recorded at [L83](../findings/sym3-blocks.md) and [L85](../findings/sym3-blocks.md), and both audits note that the same step fails at even $n$. **No finding: L62 makes no claim at any other $n$, and nothing in it is a subfamily result cited in general.**

**Quantifier order.** The only nested quantifier is "every product of two cubics of $K$ vanishes there", which is $\forall q,q'\in K$ at the single point $W_0$, no order to get wrong, and the extension to the whole orbit is not needed by the cap (though it is available, by the submodule argument at [sym3-blocks.md:234](../findings/sym3-blocks.md)).

**Cited more strongly than proved, one site.**

- [report/sections/09-status.tex:13](../report/sections/09-status.tex) is honest: "Cap proven; equality an Observation … at four primes".
- [INDEX-results.md:76](../findings/INDEX-results.md) is honest: "the value rests on a single sampled mod-$p$ rank".
- **[results.md:23](../results.md) is not**: "*A sampled mod-$p$ rank is a rigorous lower bound, and under an exact cap a lower bound is all that is needed, so [L87]'s rank and [L62]'s value are proofs rather than measurements.*" For L62 the sentence is defensible as logic and still elides that the lower bound is a machine rank of a machine-built matrix under H10 and H11. **For L87 it is false**: L87's points are constructed inside $\mathbb F_{46337}$, so there is no characteristic-zero matrix for the reduction inequality to bound, and the repairing lift is nowhere on the record. Sweeping the two into one sentence launders L87's defect through L62's soundness. `REFUTED AS STATED at [results.md:23](../results.md).`
- Also at that line, the clause "and [L90]'s stated proof was withdrawn as circular, its repair sitting twelve lines below it" appears **twice, verbatim, in the same cell**. Cosmetic, and a sign the cell was patched rather than rewritten.
- The canon still labels the whole of L62 a `Lemma` at [results.md:629](../results.md) while its own index row calls the honest form "a `Lemma` for the cap and an `Observation` for the value". That gap is on file and I confirm it stands.

## 10. Withdrawn candidates, with reasons

Each of these looked like a defect and does not survive all three of locate / exhibit / argue-the-opposite. They are recorded so the next reader does not spend an adjudication on them.

- **"A sampled rank bounds the true rank from below" is reversed.** *Withdrawn.* Both forms state it correctly and in opposite words that mean the same thing; the squeeze consumes it the right way round. Located, but no failure exhibited.
- **The mod-$p$ points are characteristic-$p$ natives, as at L87.** *Withdrawn.* [run_n5_assemble.py:896](../scripts/runs/run_n5_assemble.py) draws integer coefficients through `Fraction`, so the points are rational and the matrix is a genuine reduction. The charitable reading is the true one.
- **$W_0$'s normalisation is inconsistent across the record, so $\lVert W_0\rVert^6=1$ may fail.** *Withdrawn.* The record does carry two normalisations, but every step of L62 is invariant under rescaling $W_0$, and the cap needs only $W_0\ne0$.
- **$W_0$ has a kernel, so a step may divide by it.** *Withdrawn.* No step of L62 treats $W_0$ as anything but a point of evaluation. Located a real property of $W_0$; could exhibit no step that breaks on it.
- **$\mathrm{ANN}$'s two readings make $\dim\mathrm{ANN}=1$ ambiguous.** *Withdrawn as a defect of L62, kept as a defect of L59.* The two readings are forced to coincide by the rank, so L62's number is the same under both, see §4. The ambiguity does bite a reader who takes L59's "rank" unrestricted, which is §2's finding.
- **"Four primes" is unsupported.** *Withdrawn, and more than withdrawn: refuted*, see §8. This is the record's own standing objection and I believe it to be wrong.

## Verdict for the result as a whole

**HYPOTHESIS-DEBT, splitting exactly where the record's own index says it splits, with one correction in the block's favour.**

- **$\operatorname{rank}(\mu_K)\le13$ is a theorem** and I confirm it cold, from H1, H2 and H3 alone. The brief's named traps do not touch it.
- **$\operatorname{rank}(\mu_K)=13$, and therefore $\dim\mathrm{ANN}=1$, $\mathrm{ANN}=\mathbb R\,A(W_0^6)$ and the content of $F_5\perp\mathrm{ANN}$, have no argument on file.** They rest on a machine rank whose three hypotheses (H10, H11, and the invisibility of a defect landing on the cap) appear nowhere in either statement of L62.
- **Two identities the conclusion cannot be checked without are absent from the whole record**: the nondegeneracy of the apolar pairing on the $14$ (H6) and the reproducing property of $A(W_0^6)$ (H7).
- **The record understates its own evidence on "four primes"**, and [results.md:23](../results.md) overstates it on "proofs rather than measurements", in opposite directions, in the same file.

## What a counterexample would look like, and what I did to look for one

**The falsifier.** L62's cap cannot be falsified, it follows from the definition of $K$. What can be falsified is the value. **The object that would refute it is an $O(5)$-invariant sextic $G$, not proportional to $A(W_0^6)$, with $\mathrm{Cat}_G(K,K)=0$**, a second annihilator. Its existence makes $\dim\mathrm{ANN}\ge2$, hence $\operatorname{rank}(\mu_K)\le12$, and it kills "$F_5\perp\mathrm{ANN}$" as a *sufficient* condition, since $F_5$ would then have to be orthogonal to a plane rather than a line.

**The structured place to find one.** The natural family of candidates is $G=A(W_1^6)$ for a point $W_1$ at which every cubic of $K$ vanishes: by the argument of §6 such a $G$ lies in $\mathrm{ANN}$ automatically. So the falsifier reduces to **a point of $\mathcal W_5$ outside the cone over $O(5)\cdot(\pm W_0)$ on which the whole of $K$ vanishes**, an unexpected component of the common zero locus of $K$.

**What I did.** I checked the sign orbit first, since it is the one extra component the record itself names: $-W_0$ is a genuinely different $O(5)$-orbit ([L61](../findings/sym3-blocks.md)'s audit), every cubic of $K$ vanishes there because cubics are odd, and it yields **nothing new**, $A((-W_0)^6)=A(W_0^6)$, the sixth power being even. That closes the one closed-form candidate the record hands over. I then looked for what the record knows about the rest of the zero locus and found only [sym3-blocks.md:259](../findings/sym3-blocks.md): $\Delta=\sum_aq_a^2$ over an apolar-orthonormal basis of $K$ "appears to vanish exactly on the orbit cone", supported by "$\Delta/\lVert W\rVert^6\approx0.5$ at random points", a numerical impression, not a determination, and random points cannot see a measure-zero component in any case. The other argument on file, [L91](../findings/sym3-blocks.md)'s "a dimension count putting every other intersection at $14+29-65<0$", is a transversality heuristic and says explicitly that "$13$ holds unless a second coincidence occurs".

**I exhibited no such $G$ and I claim none exists only to the extent the measurement says so.** Constructing or excluding one is exactly the computation this brief forbids and the analysis-only rule reserves: the deciding run would be the common zero locus of $K$, or equivalently the restricted rank recomputed at a fresh, independently built point set, $13$ would leave the value where it stands, $12$ or below would refute it. I name it and stop.
