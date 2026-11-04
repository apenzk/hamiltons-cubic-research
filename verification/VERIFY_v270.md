# Verifier v270, Lemma L65: the seed $\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a well-defined, $O(n)$-equivariant, nonzero element of $M_\lambda$, its admissibility clause, its "diagram" heading, its pointer, and the Lean files

**Standfirst.** The brief ([BRIEF_L65.md](BRIEF_L65.md)) was read cold. No numerical work was done, no scripts were written or run, and every value below is exact and derived by hand. Quotations were checked against their sources by displaying only the cited lines (brauer-pairing.md lines 1-13, 40-50, 86-98, 112-116, results.md lines 226 and 771). Log: [agent_logs/verify-L65-v270.log](../agent_logs/verify-L65-v270.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | Passage B's Lemma: for admissible $\lambda$, $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a well-defined $O(n)$-equivariant map $V_\lambda\to V^{\otimes12}$ | CONFIRMED, with two unstated hypotheses supplied: $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ and $n\ge1$ |
| C2 | Passage A's pointer: "the argument is in this file under 'The diagram-realisation theorem, one seed per block'" | REFUTED AS STATED |
| C3 | Equivariance for the full $O(n)$, reflections included | CONFIRMED |
| C4 | Nonvanishing, reason 1: a tensor product of nonzero vectors is nonzero | CONFIRMED (for $n\ge1$) |
| C5 | Nonvanishing, reason 2: the cap computation returns $n^k\iota_\lambda$ | CONFIRMED AS ALGEBRA (for $n\ge1$) |
| C6 | "Nonzero in $M_\lambda$ and nonzero as a map are the same statement", and $c_0\in M_\lambda$ | CONFIRMED |
| C7 | "Without admissibility $V_\lambda=0$ and $\iota_\lambda$ does not exist, so the hypothesis is load-bearing" | CONFIRMED AS ALGEBRA for the partition-indexed statement, and the hypothesis is automatic for every block |
| C8 | The witnesses $(2,2)$ at $n=2,3$, $(2,1,1)$ at $n=3$, and tightness at $(2^6)$, $n=12$ | CONFIRMED AS ALGEBRA, with membership of $(2^6)$ among the blocks HYPOTHESIS-DEBT (unused) |
| C9 | "At $n=12$ it holds for all $71$ blocks" | CONFIRMED for every $\lambda$ with $\lvert\lambda\rvert\le12$, with the count $71$ HYPOTHESIS-DEBT (unused) |
| C10 | "The seed is a diagram" (Passage A heading, Passage E) | REFUTED AS STATED at the blocks with $\lvert\lambda\rvert=12$ |
| C11 | The counts $16$ blocks and $17$ of $184$ multiplicities with $\lvert\lambda\rvert=12$ | HYPOTHESIS-DEBT (unused by the lemma) |
| C12 | Passage E's last sentence and the canon's scope | CONFIRMED (the lemma is dimension-free) |
| C13 | The Lean files state or prove L65 | REFUTED AS STATED if read as a formalisation of L65: they type abstract ingredients only, and L65Statement.lean's "verbatim" quote has drifted from source |
| C14 | Boundary: $\lambda=\varnothing$, $\lvert\lambda\rvert=12$, small $n$, $n<\lvert\lambda\rvert$ | CONFIRMED for $n\ge1$ |

**Summary.** The mathematics of L65 is correct and complete at the level of Passage B's Lemma, once $\lvert\lambda\rvert$ even and at most $12$ and $n\ge1$ are written in. The defects are in the wrapping: the pointer names the wrong section, the heading "is a diagram" fails at $k=0$, and the block counts carry no argument (none is used).

**Overall verdict: PROVEN (hypotheses corrected).**

## 0. Conventions, fixed once

- $V=\mathbb R^n$ with the standard inner product and basis $e_1,\dots,e_n$, and $O(n)=\{g: gg^{T}=I\}$ acting by $g\cdot v=gv$ and diagonally on $V^{\otimes f}$.
- $\lambda$ a partition, $\lambda'$ its conjugate, so $\lambda'_1$ is the number of nonzero parts and $\lambda'_2$ the number of parts of size at least $2$. Admissible for $O(n)$ means $\lambda'_1+\lambda'_2\le n$.
- $V_\lambda$ is the $O(n)$-irreducible labelled by admissible $\lambda$, realised by Weyl's construction inside $V^{\otimes\lvert\lambda\rvert}$ (traceless tensors of Young symmetry $\lambda$). $\iota_\lambda$ is a chosen $O(n)$-equivariant injection $V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$. The choice is non-canonical (the multiplicity is the number of standard tableaux) and any choice serves.
- $\mathrm{cup}=\sum_a e_a\otimes e_a\in V\otimes V$, also read as the linear map $\mathbb R\to V\otimes V$, $1\mapsto\mathrm{cup}$. $\mathrm{cap}\colon V\otimes V\to\mathbb R$, $u\otimes w\mapsto\langle u,w\rangle$.
- $k=(12-\lvert\lambda\rvert)/2$ and $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}\colon V_\lambda\cong V_\lambda\otimes\mathbb R\to V^{\otimes\lvert\lambda\rvert}\otimes V^{\otimes2k}=V^{\otimes12}$, so $c_0(v)=\iota_\lambda(v)\otimes\mathrm{cup}^{\otimes k}$.
- $M_\lambda=\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$, a real vector subspace of $\mathop{\mathrm{Hom}}_{\mathbb R}(V_\lambda,V^{\otimes12})$.
- "Block" means a label $\lambda$ of the decomposition the record certifies (Passage D: $\lvert\lambda\rvert\in\{0,2,\dots,12\}$).

## Hypothesis inventory

| Hypothesis | Source | Used where | Stated? | Satisfiable? |
|---|---|---|---|---|
| $\lambda$ admissible for $O(n)$ | Passage B Lemma, A, E | existence of a nonzero $V_\lambda$ and of $\iota_\lambda$ | yes | yes, e.g. $\lambda=\varnothing$ at every $n$ |
| $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ | implicit in "block" (Passage D, Passage E's "a block $\lambda$") | $k$ a nonnegative integer, $c_0$ lands in $V^{\otimes12}$ | in E ("For a block $\lambda$") and D, absent from A and B's Lemma | yes |
| $n\ge1$ | nowhere | $\mathrm{cup}\ne0$ in reason 1, $n^k\ne0$ in reason 2 | no | yes, and the programme's $n\ge4$ (Weyl tensors) implies it |
| Weyl's construction: for admissible $\lambda$, $V_\lambda\ne0$ is irreducible and embeds equivariantly in $V^{\otimes\lvert\lambda\rvert}$ | classical, unfiled (Weyl, *The Classical Groups*, Ch. V, and Goodman-Wallach, Thm 10.2.9) | existence of $\iota_\lambda$, nonvanishing | named as "the inclusion", not cited | holds for $V=\mathbb R^n$ with a positive-definite form, every $n\ge1$ |
| Classification of $O(n)$-irreducibles by admissible partitions | classical, unfiled | "without admissibility $V_\lambda=0$" | invoked, not cited | yes |
| $\mathrm{cup}$ is $O(n)$-invariant | Passage B ("the invariant metric element") | equivariance | asserted in the definition, no argument written | yes, one line, see section 3 |
| Tensor product of equivariant maps is equivariant | Passage B | equivariance | yes | elementary |
| A tensor product of nonzero vectors over a field is nonzero | Passage B | reason 1 | yes | elementary |
| First Fundamental Theorem for $O(n)$ | Passage C, filed as Lehrer-Zhang Cor. 3.8 ($K$ of characteristic zero, $V=K^n$ with nondegenerate symmetric form) | Passage C only, and L65's last sentence "the realisation theorem applies" | yes | yes, and L65's own proof does not use it |

No hypothesis is used but unsatisfiable. Two are used and unstated in the numbered block ($\lvert\lambda\rvert$ even and at most $12$, and $n\ge1$).

## 1. C1, what $c_0$ is, and its well-definedness (brief item 2)

**Derivation.** Passage B line 92: *"the map $c_0:=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is $O(n)$-equivariant $V_\lambda\to V^{\otimes12}$"*. Reading $\mathrm{cup}^{\otimes k}$ as the map $\mathbb R\to V^{\otimes2k}$, the tensor product of linear maps $\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ has domain $V_\lambda\otimes\mathbb R\cong V_\lambda$ and codomain $V^{\otimes(\lvert\lambda\rvert+2k)}$. That codomain is $V^{\otimes12}$ exactly when $\lvert\lambda\rvert+2k=12$, which with $k\in\mathbb Z_{\ge0}$ means $\lvert\lambda\rvert\in\{0,2,4,\dots,12\}$.

**Composite against tensor.** Passage A (line 116) and E (lines 226, 771) say "the composite $\iota_\lambda$ with $k$ cups". In the monoidal sense that composite is $(\mathrm{id}_{V^{\otimes\lvert\lambda\rvert}}\otimes\mathrm{cup}^{\otimes k})\circ\iota_\lambda$, using $V^{\otimes\lvert\lambda\rvert}\cong V^{\otimes\lvert\lambda\rvert}\otimes\mathbb R$. By bifunctoriality of $\otimes$ this equals $\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$. The two descriptions name the same map. The positions of the cup legs among the $12$ are unspecified in A and E and fixed as "last" in B. Any other placement differs by a permutation of tensor factors, which is $O(n)$-equivariant and injective, so equivariance and nonvanishing are placement-independent.

**The unstated range.** For $\lvert\lambda\rvert$ odd or $\lvert\lambda\rvert>12$, $k$ is a half-integer or negative and $c_0$ is undefined. A and B's Lemma state only admissibility. At those $\lambda$ the Hom space is zero anyway: $-I\in O(n)$ acts on $V^{\otimes12}$ by $(-1)^{12}=1$ and on $V_\lambda\subset V^{\otimes\lvert\lambda\rvert}$ by $(-1)^{\lvert\lambda\rvert}$, so an equivariant map kills everything when $\lvert\lambda\rvert$ is odd (consistent with Lehrer-Zhang Theorem 3.1, "$(V^{\otimes t})^{*O(V)}$ is zero if $t$ is odd", read at source). So the correction costs nothing and is supplied by the word "block" in Passage E.

**Verdict.** CONFIRMED with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ written in. Brief item 2 answered: $c_0$ is well defined, the two descriptions agree, and $k\in\mathbb Z_{\ge0}$ exactly for $\lvert\lambda\rvert$ even and at most $12$.

## 2. C2, the pointer in Passage A (brief item 1)

**Candidate.**

1. *Location.* brauer-pairing.md line 114: *"the argument is in this file under "The diagram-realisation theorem, one seed per block""*.
2. *Failure.* The section so named is lines 40-50 (Passage C), headed `## The diagram-realisation theorem, one seed per block`. Its content is the Theorem (parts 1 and 2) and a paragraph on $e\in\nu(B_{12}(n))$ via the FFT. It contains no $\iota_\lambda$, no $\mathrm{cup}$, no $k$, no admissibility, no equivariance or nonvanishing argument for a seed. The argument for L65 (equivariance, both nonvanishing reasons, the admissibility discussion) is at lines 86-98 (Passage B), under its own heading `## The seed is itself a diagram`. Both headings are level-2 (`##`), so Passage B is a sibling section, and the pointer names the wrong one.
3. *Charitable reading.* Passage C is the section that introduces "one nonzero seed per block", and Passage B opens by referring back to it, so the pointer might mean "the context the lemma serves". That reading does not rescue the sentence, which says *the argument* is in the named section, and the argument is elsewhere. The heading levels were read at source, so B cannot be a subsection of C.

**Verdict.** REFUTED AS STATED. The fix is to point to "The seed is itself a diagram". The defect is a citation error with no mathematical consequence.

## 3. C3, equivariance for the full $O(n)$ (brief item 3)

**Derivation, cup invariance.** For $g\in O(n)$,
$$g\cdot\mathrm{cup}=\sum_a ge_a\otimes ge_a=\sum_{a,b,c}g_{ba}g_{ca}\,e_b\otimes e_c=\sum_{b,c}(gg^{T})_{bc}\,e_b\otimes e_c=\sum_b e_b\otimes e_b=\mathrm{cup}.$$
Only $gg^{T}=I$ is used, so every $g\in O(n)$ is covered, $\det g=-1$ included. Hence the map $\mathbb R\to V\otimes V$, $1\mapsto\mathrm{cup}$, is equivariant from the trivial representation, and so is $\mathrm{cup}^{\otimes k}\colon\mathbb R\to V^{\otimes2k}$.

**Derivation, closure.** If $f\colon A\to A'$ and $h\colon B\to B'$ are $G$-equivariant, then on pure tensors $(f\otimes h)(ga\otimes gb)=f(ga)\otimes h(gb)=gf(a)\otimes gh(b)=g\,(f\otimes h)(a\otimes b)$, and pure tensors span. $\iota_\lambda$ is $O(n)$-equivariant by choice. Therefore $c_0$ is $O(n)$-equivariant, for the whole of $O(n)$.

**Remark on the written argument.** Passage B line 96 gives only "closure of the tensor product under equivariant maps". The group-specific input, that $\mathrm{cup}$ is invariant under $O(n)$ (it fails for $GL(n)$), is carried by the phrase "the invariant metric element" at line 90 with no computation. The computation is the one line above, so this is recorded as a thin spot, not as debt.

**Verdict.** CONFIRMED.

## 4. C4 and C5, nonvanishing, both reasons (brief item 4)

**Reason 1.** Take $n\ge1$ and admissible $\lambda$, so $V_\lambda\ne0$ (Weyl's construction) and there is $v\ne0$ in $V_\lambda$. Then $\iota_\lambda(v)\ne0$ by injectivity. $\mathrm{cup}\ne0$ since its $e_1\otimes e_1$ coefficient is $1$, so $\mathrm{cup}^{\otimes k}\ne0$. In a tensor product of vector spaces over a field, $x\otimes y\ne0$ whenever $x\ne0$ and $y\ne0$ (extend each to a basis, and $x\otimes y$ has a nonzero coordinate on a basis tensor). So $c_0(v)\ne0$ and $c_0\ne0$. CONFIRMED for $n\ge1$.

**Reason 2.** Let $\Gamma=\mathrm{id}_{V^{\otimes\lvert\lambda\rvert}}\otimes\mathrm{cap}^{\otimes k}\colon V^{\otimes12}\to V^{\otimes\lvert\lambda\rvert}$, each cap contracting the two legs of one cup. $\mathrm{cap}(\mathrm{cup})=\sum_a\langle e_a,e_a\rangle=n$, so $\Gamma(c_0(v))=\iota_\lambda(v)\cdot n^k$ and $\Gamma\circ c_0=n^k\iota_\lambda$. For $n\ge1$, $n^k\ne0$ and $\iota_\lambda\ne0$, so $\Gamma\circ c_0\ne0$, forcing $c_0\ne0$. The phrase "proves *the map* nonzero rather than merely some contraction" is right: a nonzero composite forces a nonzero factor. The record states the cap identity without writing its one-line computation. CONFIRMED AS ALGEBRA for $n\ge1$.

**At which $n$.** Both reasons need $n\ge1$. At $n=0$ both inputs vanish ($V=0$, $\mathrm{cup}=0$, $n^k=0$ for $k\ge1$), see withdrawn candidate W1.

## 5. C6, "nonzero in $M_\lambda$ and nonzero as a map are the same statement" (brief item 5)

**Derivation.** $M_\lambda$ is defined (Passage B line 96, Passage C line 45) as $\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$, a linear subspace of $\mathop{\mathrm{Hom}}_{\mathbb R}(V_\lambda,V^{\otimes12})$ whose zero is the zero map. So "$c_0\ne0$ in $M_\lambda$" and "$c_0$ is a nonzero map" are literally the same assertion. Membership $c_0\in M_\lambda$ is C1 (codomain $V^{\otimes12}$) plus C3 (equivariance). Passage C part 2 asks for "one nonzero seed $c_0$ per block", and part 1's "generated by any nonzero vector" asks for a nonzero vector of $M_\lambda$. $c_0$ meets that hypothesis. Whether Passage C's theorem is itself correct (irreducibility over $\nu(B_{12}(n))$, which also needs $\mathop{\mathrm{End}}_{O(n)}(V_\lambda)=\mathbb R$) lies outside L65 and outside this round.

**Verdict.** CONFIRMED.

## 6. C7, C8, C9, admissibility (brief item 6)

**C7, coherence of "without admissibility $V_\lambda=0$ and $\iota_\lambda$ does not exist".** Two conventions are available. Under the brief's convention, $V_\lambda$ is defined only for admissible $\lambda$, and "$V_\lambda=0$" is shorthand for "no irreducible carries the label". Under Weyl's convention, $V_\lambda$ is the space of traceless tensors of symmetry $\lambda$, which is zero exactly when $\lambda'_1+\lambda'_2>n$, and then $\iota_\lambda$ is the zero inclusion $0\hookrightarrow V^{\otimes\lvert\lambda\rvert}$, which exists. The sentence mixes the two conventions (candidate W2). Its content, that no nonzero seed arises from this construction for inadmissible $\lambda$, is correct under both: every linear map out of $0$ is zero.

**"Load-bearing", and whether admissibility can fail where the lemma is applied.** Read as a statement over all partitions $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ and all $n\ge1$, the hypothesis cannot be dropped: at $\lambda=(2,2)$, $n=3$ there is no nonzero seed. Read as a statement over blocks, it is automatic. A block carries a nonzero $V_\lambda$, and every $O(n)$-irreducible has an admissible label, so a block label is admissible by definition. At $n=12$ it is also automatic by size: each part $p\ge1$ contributes $1$ to $\lambda'_1$ and $[p\ge2]$ to $\lambda'_2$, at most $p$ in total, so $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert\le12=n$. So admissibility fails for no $\lambda$ the lemma is applied to. CONFIRMED AS ALGEBRA, with "load-bearing" true for the partition-indexed statement only.

**C8, witnesses and tightness.**

- $\lambda=(2,2)$: $\lambda'=(2,2)$, $\lambda'_1+\lambda'_2=4>3>2$. Inadmissible at $n=2$ and $n=3$.
- $\lambda=(2,1,1)$: $\lambda'=(3,1)$, $\lambda'_1+\lambda'_2=4>3$. Inadmissible at $n=3$.
- $\lambda=(2^6)$: $\lambda'=(6,6)$, $\lambda'_1+\lambda'_2=12=n$ at $n=12$. Admissible with zero slack.

All exact and CONFIRMED AS ALGEBRA. Two remarks. The witnesses sit at $n=2,3$, where $\mathrm{Weyl}_n=0$ and there are no blocks at all, so they illustrate the partition-indexed statement only. The equality case $\lambda'_1+\lambda'_2=\lvert\lambda\rvert$ holds exactly when every part is $1$ or $2$ (from the charge count above), so $(2^6)$ is one of several tight partitions of $12$, for example $(1^{12})$ and $(2,1^{10})$. "It is tight" as a statement about the block set needs $(2^6)$, or another part-$\le2$ partition of $12$, to be a block. No argument for that is on file in the passages. HYPOTHESIS-DEBT, and unused: the lemma never invokes tightness.

**C9, "At $n=12$ it holds for all $71$ blocks".** The inequality $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$ proves admissibility at $n=12$ for every $\lambda$ with $\lvert\lambda\rvert\le12$, so it holds for whatever set of blocks there is. The claim is CONFIRMED in that stronger form. The number $71$ comes from a decomposition of the degree-3 covariants at $O(12)$ with no derivation in the passages. It is HYPOTHESIS-DEBT, and the lemma does not use it. What would discharge it: the decomposition of $\mathrm{Sym}^3(\mathrm{Weyl}_{12})$ into $O(12)$-irreducibles, with the distinct labels counted.

## 7. C10 and C11, "the seed is a diagram", and the counts $16$, $17$, $184$ (brief item 7)

**Candidate on the heading.**

1. *Location.* brauer-pairing.md line 112: `#### Lemma L65, the seed is a diagram, under admissibility`. results.md line 226: *"The seed is a diagram, under admissibility"*, and line 771: *"(one seed per block, given by a diagram)"*.
2. *Failure.* At any block with $\lvert\lambda\rvert=12$, $k=0$ and $c_0=\iota_\lambda$. $\iota_\lambda\colon V_\lambda\to V^{\otimes12}$ has domain $V_\lambda$, which is a proper subspace of a tensor power (for $\lambda=(12)$ at $n=12$, $V_\lambda$ is the traceless symmetric tensors), so it is no Brauer diagram and contains no cup. Passage B line 98 says so itself: *"It is a **padding** diagram only where $k>0$, at the $16$ blocks with $\lvert\lambda\rvert=12$ ... $k=0$, there is no cup at all, and the content there is that an inclusion is nonzero."* Brauer diagrams are the file's meaning of "diagram" (Passage C line 46, "$D$ a Brauer diagram").
3. *Charitable reading.* "Diagram" could mean a string diagram in a monoidal category enlarged by a box for $\iota_\lambda$, under which a lone box at $k=0$ is a diagram. The record's own closing remark rules that reading out, since it calls the seed a diagram only where $k>0$. Even at $k>0$ only the padding is a diagram: $\iota_\lambda$ remains a non-diagram factor. The substantive claim that survives is "every block has an explicit seed", which C1 to C6 establish (explicit relative to Weyl's construction of $\iota_\lambda$, classical and unfiled).

**Verdict.** REFUTED AS STATED at the blocks with $\lvert\lambda\rvert=12$ (and at $k>0$ only in the padding sense). The fix is a heading such as "the seed is explicit, $\iota_\lambda$ padded by $k$ cups".

**C11, the counts.** "$16$ blocks with $\lvert\lambda\rvert=12$" and "$17$ of the $184$ multiplicities" (line 98, and $16$ again in Passage D line 13) have no derivation in the passages. They are internally consistent with Passage D's "$19$ is the $SO(12)$ count; three chiral pairs are the difference": an $O(12)$-label with $\lambda'_1=6$ splits into two $SO(12)$-irreducibles, and $16+3=19$. They are also consistent with each other ($17-16=1$ block of multiplicity $2$, unnamed). Neither enters the proof of L65. HYPOTHESIS-DEBT, discharged by the same decomposition named in C9, restricted to $\lvert\lambda\rvert=12$.

## 8. C12, Passage E's last sentence and scope (brief item 8)

*"The lemma removes a search from the certificate pipeline and adds no certificate."* The mathematical content is that a nonzero element of $M_\lambda$ is written down rather than found, which C1 to C6 confirm, relative to a concrete $\iota_\lambda$. Constructing $\iota_\lambda$ is Weyl's construction in $V^{\otimes\lvert\lambda\rvert}$ (Young symmetriser on traceless tensors), classical and unfiled, so the search is replaced by that construction. "Adds no certificate" is correct: $c_0\ne0$ is a statement about a single vector and certifies nothing about the Gram data. Scope: nothing in C1 to C6 depends on $n=12$. The $12$ is the leg count ($3\times4$), and the argument holds at every $n\ge1$ for every admissible $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$. Only the decorative sentences (C8 tightness, C9, C11) are $n=12$ statements. The detail line's "a block $\lambda$ of the sextic invariants" names the blocks of the cubic covariants whose pairings are sextic, a loose but unambiguous phrase. CONFIRMED, dimension-free.

## 9. C13, the Lean files (brief items 5 and 9)

Both files were read in full from disk. They were not built (no runs in this loop), so nothing below asserts that they compile.

**L65Statement.lean types:** `legs` ($2\lfloor(12-f)/2\rfloor+f=12$ for even $f\le12$), `no_cup_iff`, `tprod_map_equivariant` (tensor product of equivariant maps is equivariant, arbitrary group, abstract modules), `seed_ne_zero` (from `cap ∘ₗ c0 = nk • iota`, `nk ≠ 0`, `iota ≠ 0`, conclude `c0 ≠ 0`), `no_seed_of_trivial` (maps out of a subsingleton module are zero), `Admissible` with `rows`/`rows2`, the three witnesses and `admissibility_tight` by `decide`, and two non-vacuity examples.

**L65.lean types:** `conj_le_size` ($\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$ for any `List ℕ`), `admissible_of_size_le`, `admissible_in_range`, `tight_conj`, `tight_size`, the three failures, `witnesses_exceed`, `leg_count`, `cups_wellposed`, and `diagram_failure_share` ($16\cdot4<71<16\cdot5$, bare arithmetic on the record's numbers).

**Neither file states L65.** No $O(n)$, $V=\mathbb R^n$, $V_\lambda$, $\iota_\lambda$, $\mathrm{cup}$, $c_0$ or $M_\lambda$ appears. L65Statement.lean says so in its "What is NOT typed here" section, and lists the cap identity as the undischarged hypothesis `hcap`. The typed pieces are each correct as algebra on their face and match the hand derivations in sections 3, 4 and 6. `conj_le_size` is the clean proof of C9.

**Candidate on the "verbatim" quote.**

1. *Location.* L65Statement.lean docstring, section "The record's statement, verbatim", quoting the surrounding section with a LaTeX em dash (three hyphens) where source line 96 has ", and it is equivariance for the **full** $O(n)$", ending that sentence at "reflection included.", and with the same three-hyphen mark after "only where $k>0$" where source line 98 has a comma.
2. *Failure.* Source line 96 reads *"Equivariance is closure of the tensor product under equivariant maps, and it is equivariance for the **full** $O(n)$, reflection included, which is exactly what the $SO$-versus-$O$ gap turns on."* and line 98 reads *"only where $k>0$, at the $16$ blocks"*. The punctuation differs and a clause is missing without an ellipsis at that point.
3. *Charitable reading.* The drift is punctuation plus one clause with no mathematical content for the Lean file, so the quotation is faithful in substance. That rescues the content but leaves the word "verbatim" false.

**Verdict.** The Lean files do not state or prove L65, and they do not claim to. The quote drift is cosmetic. Recorded as REFUTED AS STATED only against a reading of the files as a formalisation of L65, and against the word "verbatim".

## 10. C14, the boundary (brief item 10 and standing item 3)

- **$\lambda=\varnothing$.** Admissible at every $n$. $V_\varnothing=\mathbb R$ trivial, $V^{\otimes0}=\mathbb R$, $\iota_\varnothing=\mathrm{id}$, $k=6$, $c_0(1)=\mathrm{cup}^{\otimes6}\ne0$ for $n\ge1$. Equivariant by C3. Holds.
- **$\lvert\lambda\rvert=12$.** $k=0$, $c_0=\iota_\lambda$, nonzero because $V_\lambda\ne0$ and $\iota_\lambda$ is injective. Both nonvanishing reasons degenerate to "an inclusion is nonzero" ($n^0=1$). Holds, and this is where the heading fails (C10).
- **Small $n$.** $n=1$: admissible labels are $\varnothing$ and $(1)$, only $\varnothing$ has even size, $c_0=e_1^{\otimes12}\ne0$. $n=2$: $(m)$ and $(1,1)$ are admissible, e.g. $\lambda=(12)$, $V_{(12)}$ two-dimensional, $c_0=\iota_{(12)}$. Holds. For $n\le3$, $\mathrm{Weyl}_n=0$ and the lemma has no blocks to apply to, while the partition statement still holds.
- **$n<\lvert\lambda\rvert$.** Example $n=3$, $\lambda=(4)$: $\lambda'_1+\lambda'_2=2\le3$, admissible, $V_{(4)}$ the harmonic quartics (dimension $9$) inside $\mathrm{Sym}^4V\subset V^{\otimes4}$, $k=4$, $c_0=\iota_{(4)}\otimes\mathrm{cup}^{\otimes4}\ne0$. Holds. The lemma needs admissibility, never $\lvert\lambda\rvert\le n$.
- **Non-admissible $\lambda$.** Covered by C7: no nonzero seed, and no block.
- **$\lvert\lambda\rvert$ odd or above $12$.** Covered by C1: $k$ undefined, and $M_\lambda=0$.

CONFIRMED for $n\ge1$.

## 11. Quantifier order and scope (standing item 2)

The proven statement is: for every $n\ge1$ and every $O(n)$-admissible $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, and every choice of equivariant injection $\iota_\lambda$, the map $c_0$ is a nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$. The group is $O(n)$ throughout. $V_\lambda$ is an $O(n)$-irreducible and the equivariance is for $O(n)$ including reflections. For $SO(n)$ blocks the lemma gives seeds for the $O(n)$-labels only. When $\lambda'_1=n/2$ the $O(n)$-module $V_\lambda$ splits under $SO(n)$ and the restriction of $c_0$ to each summand is nonzero, but $SO(n)$-covariants twisted by $\det$ lie outside $\mathop{\mathrm{Hom}}_{O(n)}$ and receive no seed from this construction. That is consistent with Passage D's choice of the $O(12)$ labels and is no defect of L65. No finding on quantifier order.

## 12. The gap between proven and stated or used (standing item 4)

- Stated in A and E: "the seed is the composite of $\iota_\lambda$ with $k$ cups ... provided $\lambda$ is admissible". Proven: that, with $\lvert\lambda\rvert$ even and at most $12$ and $n\ge1$ added. Gap closed by the hypothesis correction.
- Stated in the headings: "the seed is a diagram". Proven: the seed is explicit, a padding of $\iota_\lambda$ by $k$ cups. Gap: C10.
- Used downstream (Passage B line 98): "$c_0$ is a nonzero element of $M_\lambda$ ... the realisation theorem applies to it". Proven: $c_0\in M_\lambda\setminus\{0\}$, which is the realisation theorem's hypothesis. The theorem's own correctness is outside this round.
- Decorative and unproven here: the counts $71$, $16$, $17$, $184$, and $(2^6)$ being a block. None is used by L65.

## 13. Falsifiers named and searched (standing item 7)

| Claim | Falsifying object | What was done |
|---|---|---|
| C1 | an admissible block $\lambda$ with $k\notin\mathbb Z_{\ge0}$ | $-I$ parity argument and Lehrer-Zhang Thm 3.1 at source show blocks have $\lvert\lambda\rvert$ even, Passage D bounds it by $12$ |
| C3 | $g\in O(n)$ with $g\cdot\mathrm{cup}\ne\mathrm{cup}$ | the identity $gg^{T}=I$ gives invariance for every $g$, reflections included |
| C4, C5 | admissible $\lambda$ and $n$ with $c_0=0$ | only $n=0$ (W1), and for $n\ge1$ both proofs go through |
| C6 | a nonzero map that is zero in $M_\lambda$ | $M_\lambda$ is a subspace of Hom, so none can exist |
| C7 | a block $\lambda$ that is inadmissible | the size bound $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$ and the classification exclude it |
| C8 | a witness with $\lambda'_1+\lambda'_2\le n$ | each conjugate computed exactly |
| C9 | a $\lambda$ with $\lvert\lambda\rvert\le12$ inadmissible at $n=12$ | excluded by the size bound, machine-checked as `conj_le_size` |
| C10 | a block with $k=0$ | the record's own line 98 names $16$ of them, and every $\lambda\vdash12$ is admissible at $n=12$ |
| C11 | the decomposition of $\mathrm{Sym}^3(\mathrm{Weyl}_{12})$ | not computed (no numerical work), recorded as debt |
| C2 | the argument located in Passage C | Passage C read at source, no seed argument present |

## 14. Withdrawn candidates

**W1, $n=0$ breaks the lemma.**

1. *Location.* Passage B line 92, *"Provided $\lambda$ is $O(n)$-admissible ... **nonzero**"*, with no lower bound on $n$.
2. *Failure.* At $n=0$, $\lambda=\varnothing$ is admissible ($0\le0$), $k=6$, and $V^{\otimes12}=0$, so $c_0=0$.
3. *Charitable reading.* $n$ is the dimension of the space carrying Weyl tensors, and the record's blocks exist only for $n\ge4$. Brauer's loop parameter $n$ and $O(n)$ as a group of isometries of $\mathbb R^n$ are read with $n\ge1$ throughout. Under that reading $n=0$ is outside the statement.

Withdrawn at step 3. The bound $n\ge1$ is still written into the corrected hypotheses, because both nonvanishing reasons use it.

**W2, "without admissibility $V_\lambda=0$ and $\iota_\lambda$ does not exist" is self-contradictory.**

1. *Location.* brauer-pairing.md line 116 and line 94, results.md lines 226 and 771.
2. *Failure.* If $V_\lambda=0$, the inclusion $0\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ exists.
3. *Charitable reading.* "$\iota_\lambda$ does not exist" means no inclusion of a nonzero irreducible exists, and the conclusion drawn (no nonzero seed) is true under either convention for $V_\lambda$.

Withdrawn at step 3, recorded as imprecise wording in C7.

**W3, the Lean `seed_ne_zero` has the wrong type for the record's cap identity.**

1. *Location.* L65Statement.lean, `(cap : T →ₗ[ℝ] Vlam) (iota : Vlam →ₗ[ℝ] Vlam)`.
2. *Failure.* The record's identity is $\Gamma\circ c_0=n^k\iota_\lambda$ with $\iota_\lambda\colon V_\lambda\to V^{\otimes\lvert\lambda\rvert}$, whose codomain differs from $V_\lambda$ unless $\lambda=\varnothing$.
3. *Charitable reading.* Post-composing with an equivariant left inverse $r\colon V^{\otimes\lvert\lambda\rvert}\to V_\lambda$ ($r=\iota_\lambda^{-1}$ on the image composed with orthogonal projection onto it, so $r\circ\iota_\lambda=\mathrm{id}$) turns the record's identity into an instance with `cap := r ∘ Γ` and `iota := id`. The theorem's content is unchanged, and the file states that it types abstract maps.

Withdrawn at step 3.

**W4, L65Statement.lean's claim that tensor closure is "the whole of the lemma's equivariance clause".**

1. *Location.* Docstring of `tprod_map_equivariant`.
2. *Failure.* The group-specific input, $O(n)$-invariance of $\mathrm{cup}$, sits in the undischarged hypothesis `hg`.
3. *Charitable reading.* The file's "What is NOT typed here" lists $\mathrm{cup}$ as the invariant metric element among the untyped objects, so the docstring describes the clause's form and defers its instance.

Withdrawn at step 3.

## Overall verdict

**PROVEN (hypotheses corrected).** Corrected statement: for $n\ge1$ and $O(n)$-admissible $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$. Separate from the verdict, three record defects: the pointer in Passage A names the wrong section (C2), the heading "the seed is a diagram" is false at the $\lvert\lambda\rvert=12$ blocks (C10), and the counts $71$, $16$, $17$, $184$ and the block membership of $(2^6)$ carry no argument, though none is used (C8, C9, C11).
