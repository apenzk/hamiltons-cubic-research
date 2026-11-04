# Verifier v64, the cap $\mathrm{rank}\le13$, the sampled-rank squeeze, $\dim\mathrm{ANN}=1$, $\mathrm{ANN}=\mathbb R\,A(W_0^6)$, $F_5\perp\mathrm{ANN}$, and "at four primes"

This was a cold brief. I worked from the two written forms of Lemma L62, [results.md:629](../results.md) and [findings/sym3-blocks.md:346](../findings/sym3-blocks.md), and from the definitions at source, reading [Lemma L59](../results.md), [Lemma L85](../findings/sym3-blocks.md), [Lemma L86](../findings/sym3-blocks.md), [Lemma L87](../findings/sym3-blocks.md), [Lemma L88](../findings/sym3-blocks.md), [Lemma L90](../findings/sym3-blocks.md) and [Lemma L91](../findings/sym3-blocks.md) in full, plus the pipeline that produced the measured number, [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) and [run_n5_lift.py](../scripts/runs/run_n5_lift.py), and the audits [REVIEW_r214](../reviews/REVIEW_r214.md), [REVIEW_r633](../reviews/REVIEW_r633.md) and [REVIEW_r634](../reviews/REVIEW_r634.md). **I ran no script, no Sage and no numerics.** Every value below is exact and hand-derived; the arithmetic is $\lVert W_0\rVert^2=(4+1+1)/6=1$ and $\mathop{\mathrm{tr}}(W_0^3)=(8-1-1)/6^{3/2}=1/\sqrt6$, from the record's own spectrum. The one machine action I took was printing the array shapes of the four stored JSON row dumps (file metadata, no arithmetic on their contents) and I flag it here rather than leaving it implicit. Log: [agent_logs/verify-L62-v64.log](../agent_logs/verify-L62-v64.log).

## Claim table

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | $\mathop{\mathrm{rank}}(\mu_K)\le13$ from order-1 vanishing plus a nonzero evaluation functional | **CONFIRMED** | image lies in $\ker\mathrm{ev}_{W_0}$, a hyperplane of the $14$; the witness $\lVert W\rVert^6$ makes $\mathrm{ev}$ nonzero |
| 2 | The cap is about $W_0$ | **CONFIRMED AS ALGEBRA, AND WEAKER THAN ADVERTISED** | the six lines use only $W_0\ne0$ and $K\subseteq\{q:q(W_0)=0\}$; nothing about $\mathbb{CP}^2$, padding or the stabiliser enters |
| 3 | Sampling direction, "a sampled rank is bounded above by the true one" / "bounds the true rank from below" | **CONFIRMED** | same statement in two voices; and both available readings of *what is sampled* give a lower bound, so the misnaming in Form A does not bite |
| 4 | Mod-$p$ direction, "reduction modulo a prime can only lower it" | **CONFIRMED AS ALGEBRA + HYPOTHESIS-DEBT** | true for the reduction of a $p$-integral rational matrix; that the sampled matrix *is* such a reduction is asserted nowhere in either form, and the neighbouring measurement at [L87](../findings/sym3-blocks.md) fails exactly this |
| 5 | The measured $13$ and the concluded $13$ are the same rank | **HYPOTHESIS-DEBT** | the measurement runs on the $47$ Hermitian unknowns, the conclusion on the $36$ real symmetric ones; $\mathop{\mathrm{rank}}_{36}\le\mathop{\mathrm{rank}}_{47}$ runs the wrong way, and the bridge is [L88](../findings/sym3-blocks.md)'s gauge claim, cited in neither form |
| 6 | $\mathop{\mathrm{rank}}=14-\dim\mathrm{ANN}$ ([L59](../results.md)'s adjunction) | **HYPOTHESIS-DEBT** | needs nondegeneracy of the pairing on the $14$ and the isotypic step from "kills every invariant form on $K$" to $\mathrm{Cat}_F(K,K)=0$; neither is on file |
| 7 | $A(W_0^6)\in\mathrm{ANN}$ | **CONFIRMED AS ALGEBRA** | true of the invariant projection of $W_0^6$; as typed, $A(W_0^6)$ is not an element of the $14$ at all |
| 8 | $\dim\mathrm{ANN}=1$ | **HYPOTHESIS-DEBT** | it is the measurement, entire; the equivariant-copy identification it needs appears in neither form, and the record itself exhibits a build exceeding the cap |
| 9 | $F_5\perp\mathrm{ANN}$ | **CONFIRMED, AND CONTENT-FREE WITHOUT 8** | $F_5(W_0)=\tfrac32-\tfrac96=0$ exactly; with only the cap this restates $F_5(W_0)=0$ |
| 10 | "It attains it, at four primes" | **CONFIRMED, SOURCE RELOCATED** | four $40\times47$ restricted row dumps near $2^{40}$ exist and [r214](../reviews/REVIEW_r214.md) reports rank $13$ at each; none of the five citing sites names them, and the plural adds no strength |
| 11 | The `Lemma` label and [results.md:23](../results.md)'s "proofs rather than measurements" | **REFUTED AS STATED for L87, DEFENSIBLE for L62** | the logic is right (a lower bound meeting an exact cap is a proof) but the same sentence sweeps in [L87](../findings/sym3-blocks.md), whose own block records that its sample is not the reduction of anything |

## Summary

**The cap is a theorem and I confirm it; the value $13$ is one measurement whose two load-bearing hypotheses, that the sampled matrix is a $p$-integral reduction, and that the $47$ Hermitian columns compute the same rank as the $36$ real unknowns, appear in neither written form, and the second is a change of space in mid-argument that the inequality alone cannot cross.** The much-disputed "four primes" is, against the standing finding, supportable from the record, by a source none of the five citing sites names.

## 0. Conventions, fixed once

Quoted from the brief and from [results.md:619](../results.md), not restated:

- $\mathcal W_5$ is the space of algebraic Weyl curvature operators at $n=5$, the $O(5)$-irreducible $[2,2]$ of dimension $35$.
- $F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2$.
- $W_0$ is the zero-padding into $\mathcal W_5$ of the $\mathbb{CP}^2$ Weyl operator; its spectrum on $\Lambda^2\mathbb R^5$ is $(2,-1,-1,0^7)/\sqrt6$ ([sym3-blocks.md:281](../findings/sym3-blocks.md)).
- $K$ is "the span of cubics cut out by the orbit constraint", the $O(5)$-submodule of cubics vanishing on $O(5)\cdot W_0$, equivalently (by [r210](../findings/sym3-blocks.md), line 234) the submodule of cubics vanishing at the single point $W_0$.
- $\mathrm{ANN}$ is "the $O(5)$-invariant sextics $F$ whose catalecticant satisfies $\mathrm{Cat}_F(K,K)=0$".
- $A(\cdot)$ is "the apolarity/dual pairing's image of a power".
- "the $14$" is $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$, [L85](../findings/sym3-blocks.md).

**Readings I had to choose, where the record admits two.**

- **$\mu$.** [L59](../results.md) uses one symbol for two maps in consecutive sentences: $\mu(B)$ with $B$ supported on $K$ (the restricted map $\mu_K\colon\mathrm{Sym}^2(K)^{O(5)}\to$ the $14$), and "$\mu$ is surjective" (the unrestricted $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$, whose restricted version is *not* surjective, its rank being $13<14$). **I read "the restricted rank" of L62 as $\mathop{\mathrm{rank}}(\mu_K)$ throughout**, which is the only reading under which $\mathrm{ANN}$ is not zero.
- **$A(W_0^6)$.** I read it as the element of the $14$ representing the functional $\mathrm{ev}_{W_0}$ (the invariant projection $\pi(W_0^6)$) for the reason in §7.
- **The unknown space.** The written unknowns are the $36$ real symmetric invariant forms on $K$; the pipeline's are $47$ Hermitian. §5 is about the distance between them.

## 1. Hypothesis inventory

**Carried by L62 itself.**

| Hypothesis | Where stated | Checked against the object | Used? |
|---|---|---|---|
| $W_0\in\mathcal W_5$, nonzero | brief, [L61](../findings/sym3-blocks.md) | holds; padding a $4$-dimensional Weyl operator keeps the $5$-dimensional Ricci contraction zero, since the contraction only sees the padded block | **used**, and only through $\lVert W_0\rVert\ne0$ |
| $\lVert W_0\rVert=1$ | implicit in $\lVert W_0\rVert^6=1$ at [sym3-blocks.md:333](../findings/sym3-blocks.md) | holds: $(4+1+1)/6=1$ | used cosmetically; the cap needs only $\ne0$ |
| every $q\in K$ vanishes at $W_0$ | definition of $K$ | holds by definition | **used** |
| the $14$ | [L85](../findings/sym3-blocks.md) | one unreplicated machine count; L62 inherits its standing | **used** |
| $\mathrm{ev}_{W_0}\ne0$ on the $14$ | Form A and Form B | holds, witness $\lVert W\rVert^6$ | **used** |
| the sample is built equivariantly | **nowhere in either form**, only at [sym3-blocks.md:233](../findings/sym3-blocks.md) and in the script | the record exhibits a wrong build **exceeding** the cap, and [r209](../reviews/REVIEW_r633.md)'s $S_3$ witness on $\mathbb R^3$ | **used**, silently, §8 |
| the sampled matrix is a $p$-integral reduction | **nowhere** | the script asserts denominators prime to $p$; the paper argument does not exist | **used**, silently, §4 |
| $\mathop{\mathrm{rank}}$ on the $47$ equals $\mathop{\mathrm{rank}}$ on the $36$ | **nowhere in L62**; [L88](../findings/sym3-blocks.md) supplies it | L88's gauge half is called "half-derived" by its own Gate 2 | **used**, silently, §5 |

**Imported with "in the setting of Lemma L59".**

| L59 hypothesis | Status | Does L62 use it? |
|---|---|---|
| apolarity $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$ | the definition of the adjoint, per [r651/r652](../findings/sym3-blocks.md); the pairing is never named | **used** |
| the pairing on the $14$ is nondegenerate | **never stated** | **used**, without it $\dim\mathrm{ANN}=14-\mathop{\mathrm{rank}}$ fails |
| $\{F:\mathrm{Cat}_F\text{ kills the invariant forms on }K\}=\{F:\mathrm{Cat}_F(K,K)=0\}$ | "ONE STEP IS GENUINELY ABSENT", [r651/r652](../findings/sym3-blocks.md) | **used** |
| $\mu$ surjective, hence $\mathrm{Cat}$ injective on the $14$ | stated | **not used**, it serves the $65$-side count only |
| $65=36+29$, the block-by-block count | stated | **not used by the inequality**; it fixes the *number* of columns, not their correctness |
| $\dim V_\lambda^H=1\iff\lambda_2$ even ([L86](../findings/sym3-blocks.md)), the rank-one step ([L87](../findings/sym3-blocks.md)) | both stated, L87 itself a mod-$p$ measurement | **not used by the inequality**, see §3.3, which is a *positive* finding for L62 |

**Two entries of that table are findings in their own right.** L62 imports L59's surjectivity/injectivity clause and its $29$ and uses neither; and it uses three hypotheses (equivariance, $p$-integrality, the $47/36$ identification) that neither form states.

## 2. The cap, and what map it caps

**The argument, checked line by line.** Let $\mu_K\colon\mathrm{Sym}^2(K)^{O(5)}\to(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$ be multiplication. Every element of the image is a finite sum $\sum q_iq_i'$ with $q_i,q_i'\in K$; each $q_i(W_0)=0$, so every image element vanishes at $W_0$. Hence $\mathop{\mathrm{im}}\mu_K\subseteq\ker(\mathrm{ev}_{W_0}|_{14})$. The functional $\mathrm{ev}_{W_0}$ is nonzero on the $14$ because $\lVert W\rVert^6$ is an invariant sextic with value $1$ there. A nonzero functional on a $14$-dimensional space has a $13$-dimensional kernel. So $\mathop{\mathrm{rank}}(\mu_K)\le13$. **This closes, and I confirm it.**

**Rank of what map, into what target, and are the three names one number?**

- **L62's "restricted rank"** is $\mathop{\mathrm{rank}}(\mu_K)$, from the $36$ (or the $47$; §5) into the $14$.
- **L59's bare "$\mathrm{rank}$"** in $\mathop{\mathrm{rank}}=14-\dim\mathrm{ANN}$ is the same number under the restricted reading, and is *not* [L89](../findings/sym3-blocks.md)'s $\mathop{\mathrm{rank}}(\mu|_{\mathrm{inv}})=14$, which is the unrestricted map. The canon carries both under one symbol in one paragraph ([results.md:619](../results.md)); this is the [r651/r652](../findings/sym3-blocks.md) slide, and it is in the canonical text as well as the findings text.
- **[results.md:206](../results.md)'s "restricted catalecticant rank"** is a third name. See §12.1, I withdrew it as a defect, because the reading that makes it true delivers the same $13$.

**The kernel is $13$-dimensional in the space the rank is measured in**, since both the image and the kernel are taken inside the $14$. No mismatch there.

## 3. The direction of every inequality, and what the sample is a sample of

### 3.1 Sampling

Form A: "a rank computed from a sample of $K$ bounds the true rank from below". Form B: "a sampled rank is bounded above by the true one". These are one statement in two voices, and both are the direction the conclusion needs: measured $\le$ true, so measured $=$ cap forces true $=$ cap.

**What the sample is of.** It is a sample of **evaluation points**, $40$ random Weyl tensors with integer coordinates in $[-4,4]$, [run_n5_assemble.py:894](../scripts/runs/run_n5_assemble.py), not of $K$ and not of $\mathrm{Sym}^2K$. The matrix is $40\times47$: rows are points, columns are the restricted unknowns. So the measured quantity is $\mathop{\mathrm{rank}}(\mathrm{ev}_{40}\circ\mu_K)\le\mathop{\mathrm{rank}}(\mu_K)$.

**Form A's phrase "a sample of $K$" is therefore a misnaming of the sample.** It does not bite: under the counterfactual reading (sampling a subspace $K'\subseteq K$), one gets $\mathop{\mathrm{rank}}(\mu_{K'})\le\mathop{\mathrm{rank}}(\mu_K)$, the same direction. Both readings are lower bounds, so the conclusion consumes it the right way round either way. Recorded as a legibility defect, not a mathematical one.

### 3.2 Reduction modulo $p$

$\mathop{\mathrm{rank}}_{\mathbb F_p}(\bar M)\le\mathop{\mathrm{rank}}_{\mathbb Q}(M)$ holds **for $\bar M$ the reduction of a $p$-integral $M$**, a nonvanishing $r\times r$ minor mod $p$ lifts to a nonvanishing minor over $\mathbb Q$. See §4 for the hypothesis this smuggles.

### 3.3 The direction that is *not* needed, and why it matters

The squeeze needs the restriction to be **inside** $K$, not equal to it. If the pipeline's restricted column space were a proper subspace of the true one, the measured $13$ would still be a valid lower bound for $\mathop{\mathrm{rank}}(\mu_K)$ and the squeeze would still close. The chain is therefore **robust to [L86](../findings/sym3-blocks.md)/[L87](../findings/sym3-blocks.md) being wrong in the "too small" direction and vulnerable only in the "too large" direction**, which is exactly the failure the record's three wrong restrictions produced, and which the cap itself detects. This is a genuine strengthening of L62's standing that neither form claims: the two-measured-links worry recorded at [L59](../findings/sym3-blocks.md) ("the chain L87 → L59 → L62 has *two* measured links") applies to the *count* $36$, and not to the inequality that produces $13$.

## 4. HYPOTHESIS-DEBT, the mod-$p$ matrix must be a reduction

1. **Located.** Form A: "reduction modulo a prime can only lower it further"; Form B: "reducing modulo $p$ can only lower it further". The sentence names no matrix over $\mathbb Q$.
2. **The failure, concretely.** The statement is false for a matrix *constructed* over $\mathbb F_p$ rather than reduced into it. The record's own neighbouring measurement is that case: [L87](../findings/sym3-blocks.md)'s Gate 2 records that each orbit point there "is a Cayley transform of a random skew matrix **over $\mathrm{GF}(46337)$**, hence an element of $O(5,\mathbb F_p)$ and not the reduction of anything", with the repairing integral lift "nowhere on the record". So the hypothesis is not idle in this file.
3. **Argued the opposite, and this one survives it.** L62's own points are characteristic-zero: [run_n5_assemble.py:894](../scripts/runs/run_n5_assemble.py) builds each sample as a rational Weyl tensor with `Fraction` entries, and the entries are reduced through `gp*` arithmetic with an explicit `assert a.denominator % PRIME` guard at [line 233](../scripts/runs/run_n5_assemble.py). So the sampled matrix **is** the reduction of a rational matrix, at the primes used. **L62 is materially cleaner than L87 on this axis, and neither block says so.**

**The debt, stated precisely.** What would have to be written: *the entries of the sampled restricted matrix are $p$-integral rationals and the mod-$p$ matrix is their reduction, the restriction $T$ included*. The last clause is the delicate half, $T$ being built from inverses of the $W_0$-expansion vector mod $p$; the pivot chosen mod $p$ can differ from the rational pivot without changing the hyperplane, but that is an argument, and it is not on file.

## 5. HYPOTHESIS-DEBT, the measured rank and the concluded rank live on different spaces

This is the finding I regard as new.

1. **Located.** The conclusion's unknowns are the $36$: [L59](../results.md), "$65=36+29$ splits the invariant forms into the unknowns supported on $K$ and those killing $K\times K$", and [L88](../findings/sym3-blocks.md), "real symmetric is $\sum\binom{m+1}2$ … orbit-restricted it is $36$". The measurement's unknowns are the $47$: `herm_row` at [run_n5_assemble.py:869](../scripts/runs/run_n5_assemble.py) emits one real diagonal entry and two entries per off-diagonal pair, i.e. $m^2$ per block ($2\cdot9+5\cdot4+9\cdot1=47$ on the shape *two $3\times3$, five $2\times2$, nine scalars*) and the four stored row dumps [n5_rows_1099511627873.json](../scripts/runs/n5_rows_1099511627873.json) and its three siblings are each $40\times47$.
2. **The failure, concretely.** The squeeze delivers $\mathop{\mathrm{rank}}_{47}=13$: the cap applies verbatim to the Hermitian unknowns, every $\sum h_{ab}q_a\bar q_b$ with $q_a\in K$ vanishing at $W_0$. But $\mathrm{ANN}=\{F:\mathrm{Cat}_F(K,K)=0\}$ is the annihilator of $\mu(\mathrm{Sym}^2K)$, whose invariant part is $\mathop{\mathrm{im}}(\mu_K)$ on the **$36$**. The only inequality available between the two is $\mathop{\mathrm{rank}}_{36}\le\mathop{\mathrm{rank}}_{47}$, which runs the wrong way: a world with $\mathop{\mathrm{rank}}_{36}=12$ and $\mathop{\mathrm{rank}}_{47}=13$ is consistent with every number L62 writes down, and in it $\dim\mathrm{ANN}=2$ and "$F_5\perp\mathrm{ANN}$" no longer follows from $F_5(W_0)=0$.
3. **Argued the opposite.** [L88](../findings/sym3-blocks.md) closes it: "the $24$ are gauge", and its Gate 2 records that this is "**True for the Gram-to-sextic map**, which the block gives", the $11$ restricted antisymmetric directions map to zero, so $\mathop{\mathrm{im}}_{47}=\mathop{\mathrm{im}}_{36}$ and the ranks agree. **So the mathematics is available and I do not report a refutation.** What I report is that L62 changes space mid-argument and names no bridge: neither Form A nor Form B mentions $47$, Hermitian unknowns, or L88, and the file's own note on L62 lists its consumed-uncited results as L59, L85 and L86, L88 is not even on that list.

**The debt, stated precisely.** What would have to be proved or cited at L62: *the Gram-to-sextic map annihilates the $11$ restricted antisymmetric invariant forms, so the rank measured on the $47$ Hermitian columns is the rank of $\mu_K$ on the $36$ real symmetric unknowns.* That is [L88](../findings/sym3-blocks.md), and its gauge half is called "half-derived" by its own audit, the derived part being exactly the part L62 needs.

## 6. HYPOTHESIS-DEBT, $\mathop{\mathrm{rank}}=14-\dim\mathrm{ANN}$

1. **Located.** [results.md:619](../results.md): "Apolarity … gives $\mathrm{rank}=14-\dim\mathrm{ANN}$ on the $14$-dimensional space of invariant sextics."
2. **What is missing.** Two things. First, $\dim(\mathop{\mathrm{im}}^{\perp})=14-\mathop{\mathrm{rank}}$ inside the $14$ requires the pairing to be **nondegenerate on the $14$**, which is stated nowhere and is not automatic from the adjunction, the adjunction is an identity between two pairings on two different spaces, as L59's own Gate 2 says. Second, the passage from "$\mathrm{Cat}_F$ kills every *invariant* form on $K$" to "$\mathrm{Cat}_F(K,K)=0$" needs equivariance and isotypic pairing; [r651/r652](../findings/sym3-blocks.md) call this step "GENUINELY ABSENT, two lines, and the block has neither".
3. **Argued the opposite.** Both are true and standard: the apolar pairing is positive definite in the real normalisation and a compact group's invariant subspace is an orthogonal summand; and averaging over $O(5)$ carries $\mathrm{Cat}_F(q,q')=0$ on invariant combinations to all pairs when $K$ is a submodule and $F$ is invariant. **I do not supply either argument here**, that is the parent's call, not a verifier's. The debt is that L62 rests on both and neither is written.

## 7. $\mathrm{ANN}$ spanned by $A(W_0^6)$, two claims, one of them a type slip

**Membership.** For invariant $F$, $\langle F,A(W_0^6)\rangle=F(W_0)$, so $A(W_0^6)$ *is* the evaluation functional. §2 shows $\mathop{\mathrm{im}}\mu_K\subseteq\ker\mathrm{ev}_{W_0}$, so $A(W_0^6)\in\mathrm{ANN}$, and it is nonzero because $\mathrm{ev}_{W_0}(\lVert W\rVert^6)=1$. **This half follows from the cubics of $K$ vanishing at $W_0$ and nothing else, confirmed.**

**The type slip.** $\mathrm{ANN}$ is a subspace of the *invariant* sextics, and $W_0^6$ is not invariant: its stabiliser is $H=\mathrm{Stab}_{O(5)}(W_0)$, of positive codimension in $O(5)$ ([sym3-blocks.md:110](../findings/sym3-blocks.md) gives $H$ with identity component $U(2)$), so the $O(5)$-average of $W_0^6$ differs from $W_0^6$. Read literally, "$\mathrm{ANN}$ spanned by $A(W_0^6)$" places a non-invariant element in a space of invariants. **The charitable reading repairs it completely**: invariant sextics are constant on orbits, so $\mathrm{ev}_{W_0}=\mathrm{ev}_{gW_0}$ on the $14$ and the intended object is the invariant projection $\pi(W_0^6)$, which represents that functional. Every consequence is unchanged. Reported as a legibility defect; the reading I adopt is the projection one.

**Dimension one.** Not argued anywhere except through the measurement, §8.

## 8. $\dim\mathrm{ANN}=1$, the measurement, and the hypothesis nobody stated

The cap gives $\mathrm{ANN}\supseteq\mathbb R\,\pi(W_0^6)$, i.e. $\dim\ge1$ and $\mathop{\mathrm{rank}}\le13$. Equality is the measured direction, entire. **The hypothesis it needs and neither form states** is the equivariant identification of the copies: the sampled row is $\mu_K^*(\mathrm{ev}_W)$ only if the copies are identified equivariantly, and the record itself exhibits the failure, [sym3-blocks.md:233](../findings/sym3-blocks.md) records [r209](../reviews/REVIEW_r633.md)'s $S_3$ witness on $\mathbb R^3$ giving sampled rank $10$ against a cap of $7$, and the file records **three** wrong restrictions of its own, each caught by coming out *above* the cap at rank $14$. That the guard is a machine Schur test rather than an argument is itself the point: L62 as written reads as though the squeeze needs no hypothesis about how the matrix was built, and it needs two (this one and §5's).

**And the file's own warning applies here and nowhere more sharply:** "a defect landing the rank exactly *on* the cap is invisible" ([sym3-blocks.md:235](../findings/sym3-blocks.md)). The three wrong builds were caught by exceeding the cap; a build that under-restricts lands at or below it silently.

## 9. $F_5\perp\mathrm{ANN}$, confirmed in closed form

$\langle F_5,\pi(W_0^6)\rangle=F_5(W_0)$, and with the record's spectrum $(2,-1,-1,0^7)/\sqrt6$:

$$\lVert W_0\rVert^2=\frac{4+1+1}6=1,\qquad \mathop{\mathrm{tr}}(W_0^3)=\frac{8-1-1}{6\sqrt6}=\frac1{\sqrt6},\qquad F_5(W_0)=\frac32\cdot1-9\cdot\frac16=0 .$$

Exact, and it doubles as a check of the normalisation and of $\theta(W_0)=3\mathop{\mathrm{tr}}(W_0^3)=\sqrt{3/2}$. **The thing L62 needs about $F_5$ at $W_0$ is on the record**, [sym3-blocks.md:229](../findings/sym3-blocks.md), "$F_5\perp\mathcal A(W_0^6)$ because $F_5(W_0)=0$, exact over $\mathbb Z$", and [L61](../findings/sym3-blocks.md) has $F_5$ vanishing on the whole orbit. What is *not* content-free is the step from $F_5\perp\pi(W_0^6)$ to $F_5\perp\mathrm{ANN}$, which is $\dim\mathrm{ANN}=1$, which is §8.

## 10. "At four primes", the record supports it, from a source no citing site names

This is the standing finding I most expected to confirm, and I do not confirm it as stated.

**What the record holds.**

| Prime | Object | Where |
|---|---|---|
| $1000033$ | restricted sampled rank $13$ at the $40$ points | [sym3-blocks.md:225](../findings/sym3-blocks.md), [run_n5_assemble.py:97](../scripts/runs/run_n5_assemble.py) |
| $1000003$ | same, reviewer 209's own code, own points, $T$ rebuilt from three positions | [sym3-blocks.md:225](../findings/sym3-blocks.md), [ranks.py](../scripts/reviewers/r209/ranks.py) |
| $1099511627873$, $1099511627917$, $1099511627933$, $1099511627953$ | four stored $40\times47$ **restricted** row dumps, one per prime, written by the same pipeline at `N5_PRIME` | [n5_rows_1099511627873.json](../scripts/runs/n5_rows_1099511627873.json) and siblings, dumped at [run_n5_assemble.py:1248](../scripts/runs/run_n5_assemble.py) |
| the same four | $\mathop{\mathrm{rank}}(A)=13$ and $\mathop{\mathrm{rank}}([A\mid F_5])=13$ at each, by an independent Gaussian elimination self-tested on planted ranks | [REVIEW_r214:21–22](../reviews/REVIEW_r214.md), [rank_modp.py](../scripts/reviewers/r214/rank_modp.py) |

**So "four primes" is true of the restricted rank**, and the total on the record is six. The standing verdict, [r633](../reviews/REVIEW_r633.md), "the record names two; the four near $2^{40}$ belong to the certificate's row lift, a different computation at a different scale", is half right and half wrong: the four *are* the row-lift primes, and the rows they lift are precisely the $40\times47$ restricted rows whose rank is the quantity in question, and r214 computed that rank at each. [r687](../reviews/REVIEW_r687.md) already noticed this ("r211 does report the sampled rank matching mod three of them") and called the phrase "defensible only by a reading the block never gives", which is the accurate verdict.

**Two things I would still charge to the sentence.**

- **Not one of the five citing sites names a prime**, so a reader cannot get from the claim to its support without reading a reviewer file. That is the real defect, and it is a citation defect rather than an arithmetic one.
- **The plural carries no mathematical weight.** The squeeze is one-sided: a single prime attaining the cap closes it, and the other three add nothing, because $\mathop{\mathrm{rank}}_{\mathbb F_p}\le\mathop{\mathrm{rank}}_{\mathbb Q}\le13$ at every $p$. Four primes insure against an unlucky prime, and against nothing else, in particular not against the two unstated hypotheses of §4, §5 and §8, which are common to all six runs, all sharing the sample, the code and $T$. **Presenting the count as corroboration overstates what repetition buys here**, and [r634](../reviews/REVIEW_r634.md) reached the same conclusion from the other side ("the run cannot promote L62 to a `Lemma`").

Stronger than any of it, and unused by both forms: [run_n5_lift.py:194](../scripts/runs/run_n5_lift.py) asserts the **exact rank over $\mathbb Q$** of the lifted rows is $13$. If that lift is sound, [r211](../reviews/REVIEW_r214.md) is cited for uniqueness with margin $2.26\times10^{-14}$, the mod-$p$ apparatus is not needed at all, and [r687](../reviews/REVIEW_r687.md) says so: "the exact result is the stronger one and the block is currently quoting the weaker".

## 11. Quantifier order, scope, and citation strength

- **Quantifiers.** "Every product of two cubics of $K$ vanishes there" and "evaluation there is a nonzero functional on the $14$" are correctly ordered; the conclusion quantifies over the image, which is spanned by such products. No finding.
- **Scope.** L62 is an $n=5$ statement used only at $n=5$. It is not cited at $n\ge6$, and the neighbouring transfer warnings ([L61](../findings/sym3-blocks.md)'s "it does not lift", the Lovelock syzygy) are respected. **No finding.**
- **Cited stronger than proved, one site.** [results.md:23](../results.md): "*A sampled mod-$p$ rank is a rigorous lower bound, and under an exact cap a lower bound is all that is needed, so [L87]'s rank and [L62]'s value are proofs rather than measurements.*" For L62 the logic is right, subject to §4, §5 and §8. **For L87 it is not**: L87's Gate 2 records that its sample is constructed over $\mathrm{GF}(46337)$ and is "not the reduction of anything", with the repairing lift absent. So one canonical sentence promotes two results on one argument that holds for only one of them.
- **The label.** [results.md:629](../results.md) still carries L62 as a `Lemma` with the value half inside it, while [report/sections/09-status.tex:13](../report/sections/09-status.tex) has already adopted the split ("Cap proven; equality an Observation") and [INDEX-results.md:76](../findings/INDEX-results.md) records the GAP. **The canon is the last carrier of the un-split form**, the same inversion of the canon-over-derivative hierarchy that [r687](../reviews/REVIEW_r687.md) charges at L90.

## 12. Withdrawn candidates

### 12.1 "Restricted catalecticant rank" names the wrong object, WITHDRAWN

1. **Located.** [results.md:206](../results.md): "Order-one vanishing at $W_0$ caps the restricted catalecticant rank at $13$."
2. **The apparent failure.** For a fixed sextic $F$, the catalecticant $\mathrm{Cat}_F$ is a form on $\mathrm{Sym}^3\mathcal W_5$, of dimension $7770$; its rank is a per-$F$ number with no reason to be $\le14$. The object capped at $13$ is the rank of a multiplication map from the $36$ into the $14$.
3. **Why it is withdrawn.** A reading makes it exactly right: the *adjoint* map $F\mapsto\mathrm{Cat}_F|_{K\times K}$, from the $14$ to the dual of the restricted unknowns, has kernel $\mathrm{ANN}$ and rank $14-\dim\mathrm{ANN}$, the same $13$, by the very adjunction L59 states. **"Restricted catalecticant rank" is arguably the better name of the two**, being the side on which $\mathrm{ANN}$ is literally a kernel. No defect.

### 12.2 The two forms state the sampling inequality in opposite directions, WITHDRAWN

Form A's "bounds the true rank from below" and Form B's "is bounded above by the true one" are the same relation with the subject swapped. Both consume it correctly. The only residue is Form A's "a sample of $K$", handled in §3.1 and reported there as legibility rather than as a direction error.

### 12.3 The padded kernel breaks a step, WITHDRAWN

$W_0$ has a $7$-dimensional kernel on $\Lambda^2\mathbb R^5$, spectrum $(2,-1,-1,0^7)/\sqrt6$, so the trap is live in principle. I checked each step against it: the cap uses only $\lVert W_0\rVert\ne0$; $\mathrm{ev}_{W_0}\ne0$ uses only $\lVert W\rVert^6$; $F_5(W_0)=0$ is computed *from* that spectrum, zeros included; and [L86](../findings/sym3-blocks.md)'s stabiliser $H\supseteq U(2)$ and the redundant reflection $\varepsilon=\mathrm{diag}(1,1,1,1,-1)$ **use** the padding rather than assuming it away. **No imported step assumes a trivial kernel.** Nothing to report.

### 12.4 The cap is $\mathbb{CP}^2$-specific, WITHDRAWN, but note what it means

The six-line cap uses no property of $W_{\mathbb{CP}^2}$: substituting any nonzero $P\in\mathcal W_5$ and $K_P=\{q:q(P)=0\}$ gives $\mathop{\mathrm{rank}}(\mu_{K_P})\le13$ verbatim. That is not a defect, it is the correct observation that **all of the certificate's $\mathbb{CP}^2$-specific content sits in the measurement and in $F_5(W_0)=0$**, and none of it in the proved half. It sharpens the standing "the proved half alone is content-free" rather than contradicting it.

## 13. The falsifier

**What would refute L62.** A second, independent element of $\mathrm{ANN}$: a nonzero invariant sextic $F$, not a multiple of $\pi(W_0^6)$, with $\mathrm{Cat}_F(K,K)=0$. Equivalently, and in the form that is easiest to hunt: **a point $W_1\in\mathcal W_5$ at which every cubic of $K$ vanishes and whose evaluation functional on the $14$ is not proportional to $\mathrm{ev}_{W_0}$.** Any such $W_1$ puts $\mathrm{ev}_{W_1}$ into $\mathrm{ANN}$ (all products of pairs from $K$ vanish there) so $\dim\mathrm{ANN}\ge2$, $\mathop{\mathrm{rank}}\le12$, and the measured $13$ would be wrong. In closed form the locus to search is $Z(K)=\{W:W^3\in C\}$, with $C=K^{\perp}$ the $O(5)$-submodule generated by $W_0^3$, which is [L87](../findings/sym3-blocks.md)'s $3570$-dimensional module: a falsifier is a $W_1$ with $W_1^3\in C$ lying outside $\pm O(5)\cdot W_0$ and carrying a different invariant-sextic profile.

**What I did to look for one.**

- **The one structured family that closes by hand, and it closes.** The obvious candidate is $-W_0$: cubics are odd, so every $q\in K$ vanishes at $-W_0$ too, and $-W_0$ is a *different* $O(5)$-orbit, the second zero-orbit [L61](../findings/sym3-blocks.md)'s audit raises. It supplies **no** new annihilator, because $(-W_0)^6=W_0^6$: sextics are even, so $\mathrm{ev}_{-W_0}=\mathrm{ev}_{W_0}$ on the $14$. The whole cone $\mathbb R\cdot O(5)\cdot W_0$ likewise contributes one line, evaluation scaling by the sixth power of the radius. **So the one family the record itself flags as a hidden second orbit cannot produce the second coincidence [L91](../findings/sym3-blocks.md) worries about.**
- **The other families named in the brief** (diagonal points, padded $S^2\times S^2$, the padded maximal torus, subalgebra-Casimir points), cannot be tested by hand: deciding $W_1^3\in C$ means projecting a cube onto a $3570$-dimensional submodule, or evaluating $41$ covariants. That is computation, this task carries no approval for it, and I did not run it. **Recorded as the run that would decide the falsifier question**, with the outcomes: a padded structured point with $W_1^3\in C$ and a distinct invariant profile refutes L62 outright; none found leaves the value exactly where it is, on one measurement.
- **A cheap negative check that does pass.** $K$ contains no invariant cubic: the trivial block $(0,0)$ has multiplicity $1$ and $\lambda_2=0$ even, so the orbit condition kills it entirely, it is first on [L86](../findings/sym3-blocks.md)'s list of eight dying blocks, consistent with $\mathop{\mathrm{tr}}(W_0^3)=1/\sqrt6\ne0$. Had $\mathop{\mathrm{tr}}(W_0^3)$ vanished, $\mathop{\mathrm{tr}}(W^3)^2$ would sit in the image and the whole shape of the count would differ. The record's numbers are internally consistent here.

## Verdict

**L62 splits, as its own Gate 2 said, and the split is sharper than the record's version of it.**

- **The cap $\mathop{\mathrm{rank}}\le13$ is a theorem**, confirmed independently here, and it uses strictly less than the record claims, only $W_0\ne0$ and $K$'s vanishing.
- **The value $\mathop{\mathrm{rank}}=13$, $\dim\mathrm{ANN}=1$ and the useful half of $F_5\perp\mathrm{ANN}$ are one measurement**, whose stated inequalities all point the right way and whose three enabling hypotheses, the equivariant copy identification, the $p$-integrality of the reduced matrix, and the identification of the $47$ Hermitian columns with the $36$ real unknowns, appear in **neither** written form. The third is the one I would fix first: it is a change of space in mid-argument, and the inequality between the two spaces runs the wrong way to cross it unaided.
- **"At four primes" is supportable**, four $40\times47$ restricted row dumps plus [r214](../reviews/REVIEW_r214.md)'s ranks, and two small primes besides, but no citing site names a prime, and the plural buys nothing the first prime did not, since all six runs share the sample, the code and the restriction.
- **Nothing here refutes L62.** The correct label is a `Lemma` for the cap and an `Observation` for the value, which [report/sections/09-status.tex](../report/sections/09-status.tex) already carries and [results.md](../results.md) does not.
