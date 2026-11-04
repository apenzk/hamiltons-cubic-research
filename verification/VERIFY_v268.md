# Verifier v268, Lemma L65: the seed $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a nonzero $O(n)$-equivariant map $V_\lambda\to V^{\otimes12}$ under admissibility, its pointer, heading, counts, scope and Lean files

The brief ([BRIEF_L65.md](BRIEF_L65.md)) was read cold. No numerical work was done: every value below is exact, no script was written and nothing was run, the Lean files included (read, not built). Log: [agent_logs/verify-L65-v268.log](../agent_logs/verify-L65-v268.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Passage A's pointer: the argument is under "The diagram-realisation theorem, one seed per block" | REFUTED AS STATED |
| 2 | $c_0$ is a well-defined linear map $V_\lambda\to V^{\otimes12}$, and "composite with $k$ cups" equals $\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ | CONFIRMED, with the unstated hypothesis $\lvert\lambda\rvert$ even, $\lvert\lambda\rvert\le12$ |
| 3 | $c_0$ is equivariant for the full $O(n)$ | CONFIRMED |
| 4a | Nonvanishing: a tensor product of nonzero vectors is nonzero | CONFIRMED, at every $n\ge1$ |
| 4b | Nonvanishing: the cap computation returns $n^k\iota_\lambda$ | HYPOTHESIS-DEBT (non-load-bearing, 4a suffices) |
| 5 | $c_0\in M_\lambda$, and "nonzero in $M_\lambda$" equals "nonzero as a map" | CONFIRMED |
| 6a | "Without admissibility $V_\lambda=0$ and $\iota_\lambda$ does not exist" | CONFIRMED AS ALGEBRA (wording self-contradictory, content correct) |
| 6b | The three witnesses $(2,2)$ at $n=2,3$ and $(2,1,1)$ at $n=3$ | CONFIRMED |
| 6c | "At $n=12$ it holds for all $71$ blocks", tightness at $(2^6)$ | CONFIRMED (for every $\lvert\lambda\rvert\le12$, the value $71$ unused) |
| 7 | "The seed is a diagram" (A heading, E line 771 "given by a diagram") | REFUTED AS STATED |
| 7c | The counts $16$ blocks, $17$ of $184$ multiplicities, $71$ blocks, $19$ $SO(12)$ labels | HYPOTHESIS-DEBT (census values, unused by the lemma) |
| 8 | "Removes a search ... adds no certificate", scope dimension-free | CONFIRMED |
| 9 | The Lean files state or prove the lemma | REFUTED AS STATED (they type ingredients and arithmetic, $c_0$ is never constructed) |
| 10 | Boundary: $\lambda=\varnothing$, $\lvert\lambda\rvert=12$, small $n$, $n<\lvert\lambda\rvert$ | CONFIRMED (with $n\ge1$ stated) |

**Summary.** The lemma's mathematics is correct and its first nonvanishing argument is complete given Weyl's construction (classical, unfiled), once $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ and $n\ge1$ are written into the statement. The defects are editorial: a wrong pointer, a heading that calls the seed a diagram, and an asserted cap identity.

**Overall verdict: PROVEN (hypotheses corrected).**

## 0. Conventions, fixed once

- $V=\mathbb R^n$ with the standard inner product $\langle e_a,e_b\rangle=\delta_{ab}$, $n\ge1$ unless stated. $O(n)=\{g: gg^T=I\}$ acts on $V^{\otimes m}$ by $g^{\otimes m}$, and $V^{\otimes0}=\mathbb R$ with trivial action.
- $\lambda$ a partition, $\lambda'$ its conjugate, so $\lambda'_1$ is the number of nonzero parts and $\lambda'_2$ the number of parts $\ge2$. Admissible means $\lambda'_1+\lambda'_2\le n$.
- $V_\lambda$: for admissible $\lambda$, the $O(n)$-irreducible labelled by $\lambda$, realised (Weyl) as the traceless tensors in $V^{\otimes\lvert\lambda\rvert}$ lying in the image of a Young symmetriser of shape $\lambda$. For non-admissible $\lambda$ the same construction gives $0$. This is the "Weyl convention" below. Under the brief's own definition $V_\lambda$ is defined only for admissible $\lambda$.
- $\iota_\lambda\colon V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ any fixed equivariant embedding (the multiplicity of $V_\lambda$ in $V^{\otimes\lvert\lambda\rvert}$ can exceed one, and nothing below depends on the choice).
- $\mathrm{cup}=\sum_a e_a\otimes e_a\in V^{\otimes2}$. $k=(12-\lvert\lambda\rvert)/2$. $M_\lambda=\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$.
- $\mathrm{cap}_{i,i+1}\colon V^{\otimes m}\to V^{\otimes(m-2)}$ applies $\langle\cdot,\cdot\rangle$ to factors $i,i+1$.
- Quotations of [brauer-pairing.md](../findings/brauer-pairing.md) lines 1-13, 40-50, 86-98, 112-116 and [results.md](../results.md) lines 226 and 771 were checked at source and match the brief verbatim. Only those lines were displayed.

## Hypothesis inventory

| Hypothesis | Where | Used by | Stated? | Satisfiable? |
|---|---|---|---|---|
| H1. $\lambda$ is $O(n)$-admissible | A, B display, E | existence and nonvanishing of $V_\lambda$ | yes | yes, e.g. $\lambda=\varnothing$ at any $n\ge0$ |
| H2. $\lvert\lambda\rvert$ even and $\lvert\lambda\rvert\le12$ | implicit, from "per block" (B line 88), "block of the sextic invariants" (E line 771), D line 11 | $k\in\mathbb Z_{\ge0}$, target $V^{\otimes12}$ | in E by context only, absent from the B display and A | yes |
| H3. $n\ge1$ | implicit | $\mathrm{cup}\ne0$ (4a), $n^k\ne0$ (4b) | no | yes |
| H4. $V=\mathbb R^n$ with the standard form, group $O(n)$ | B line 90 "invariant metric element" | invariance of cup | yes | yes |
| I1. Weyl's construction: for admissible $\lambda$, $V_\lambda\ne0$, irreducible, and embeds equivariantly in $V^{\otimes\lvert\lambda\rvert}$ | imported, unfiled, classical | $\iota_\lambda$ exists and is injective with nonzero domain | named only as "the inclusion" | yes |
| I2. For non-admissible $\lambda$ the Weyl module is $0$ | imported, unfiled | 6a, 6b only | asserted | yes |
| I3. Classification of $O(n)$-irreducibles by admissible partitions | imported, unfiled | the labelling of blocks | named in the brief | yes |
| I4. Passage C (realisation theorem, FFT for $O(n)$) | downstream | the sentence "the realisation theorem applies to it", never the lemma itself | yes | outside this round |
| I5. $\mathrm{cap}$ identity $\mathrm{cap}^k\circ c_0=n^k\iota_\lambda$ | B line 96 | 4b only | asserted without derivation | yes |

Exact form of I1 the argument needs: for admissible $\lambda$ there is a nonzero $O(n)$-submodule of $V^{\otimes\lvert\lambda\rvert}$ isomorphic to the irreducible labelled $\lambda$ (Weyl, *The Classical Groups*, Ch. V, and Fulton and Harris, *Representation Theory*, Theorem 19.19, both unfiled). Irreducibility is never used by L65. The filed references ([andersen-stroppel-tubbenhauer-brauer-semisimplicity](../references/andersen-stroppel-tubbenhauer-brauer-semisimplicity/), [lehrer-zhang-sft-orthogonal](../references/lehrer-zhang-sft-orthogonal/)) carry no step L65 uses, so they were not opened beyond their note headings.

## 1. The pointer in Passage A

**Candidate 1.** (1) Location: [brauer-pairing.md:114](../findings/brauer-pairing.md#L114), "**the argument is in this file under "The diagram-realisation theorem, one seed per block"**". (2) Failure: that heading is [line 40](../findings/brauer-pairing.md#L40) (Passage C). Lines 40-50 state a theorem that takes "one nonzero seed $c_0$ per block" as input and contain no mention of $\iota_\lambda$, cup, $k$ or admissibility. The lemma's statement and argument (equivariance, both nonvanishing reasons, admissibility witnesses) are at lines 86-98, under the separate `##` heading "The seed is itself a diagram" ([line 86](../findings/brauer-pairing.md#L86)), a peer section to line 40, never a subsection of it. (3) Charitable reading: "under" might mean "downstream of" or "in the part of the file after". Lines 51-84 also lie in C's section and were outside what this verifier may read, so a seed argument there cannot be excluded by inspection. The brief however identifies Passage B as "the section the lemma's argument is written in", and B's own text begins "The realisation theorem says ... nothing about where a seed comes from", which places the seed argument outside C by the record's own account. The charitable reading fails.

**Verdict: REFUTED AS STATED.** The pointer should name "The seed is itself a diagram". Editorial, no mathematical consequence.

## 2. What $c_0$ is

**Derivation.** Let $u_k\colon\mathbb R\to V^{\otimes2k}$, $1\mapsto\mathrm{cup}^{\otimes k}$. Then $\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ means $(\iota_\lambda\otimes u_k)\circ(V_\lambda\cong V_\lambda\otimes\mathbb R)$, i.e. $c_0(v)=\iota_\lambda(v)\otimes\mathrm{cup}^{\otimes k}\in V^{\otimes\lvert\lambda\rvert}\otimes V^{\otimes2k}=V^{\otimes(\lvert\lambda\rvert+2k)}$. This is $V^{\otimes12}$ exactly when $2k=12-\lvert\lambda\rvert$ with $k\in\mathbb Z_{\ge0}$, i.e. when $\lvert\lambda\rvert$ is even and $\lvert\lambda\rvert\le12$.

**Composite against tensor product.** Read "cup" as the Brauer diagram $\mathrm{id}^{\otimes m}\otimes\mathrm{cup}\colon V^{\otimes m}\to V^{\otimes(m+2)}$. Then the composite of $\iota_\lambda$ with $k$ such maps is $x\mapsto\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}$, which is B's $c_0$. Passages A and E leave the cup positions free. Any other placement (interleaved or nested) differs from $c_0$ by post-composition with a permutation of tensor factors, which is $O(n)$-equivariant and invertible, so equivariance and nonvanishing are unaffected.

**Candidate 2 (withdrawn, recorded as a hypothesis correction).** (1) Location: the B display [line 92](../findings/brauer-pairing.md#L92), "*Provided $\lambda$ is $O(n)$-admissible* ... the map $c_0:=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is $O(n)$-equivariant $V_\lambda\to V^{\otimes12}$", and A [line 116](../findings/brauer-pairing.md#L116), whose only proviso is admissibility. (2) Failure: $\lambda=(1)$ at $n=2$ is admissible ($1+0\le2$) with $k=11/2$, and $\lambda=(14)$ at $n=2$ is admissible ($1+1\le2$) with $k=-1$. In both cases $c_0$ is undefined. (3) Charitable reading: B line 88 frames the construction "once per block", E line 771 opens "For a block $\lambda$ of the sextic invariants", and D line 11 gives $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ "for this certificate". Under that reading both counterexamples are outside scope. The reading rescues the content, so the candidate is withdrawn as a defect. The hypothesis still belongs in the statement, since A presents admissibility as the lemma's only hypothesis.

**Debt behind the correction.** "Every block has an explicit seed" (B [line 98](../findings/brauer-pairing.md#L98)) needs every block label to satisfy H2. In the passages on file this is asserted (D line 11) without argument. What would have to be proved: every $O(n)$-constituent $V_\lambda$ of $V^{\otimes12}$ has $\lvert\lambda\rvert\le12$ and $\lvert\lambda\rvert\equiv0\pmod2$. This is classical and unfiled. It is recorded here, and it does not bear on the lemma once H2 is a hypothesis.

**Verdict: CONFIRMED** for $\lvert\lambda\rvert$ even, $\lvert\lambda\rvert\le12$.

## 3. Equivariance for the full $O(n)$

**Derivation, read against the written chain.** The record's chain is "closure of the tensor product under equivariant maps" plus cup being "the invariant metric element".
- $\iota_\lambda$ is equivariant as the inclusion of a subrepresentation (I1).
- $\mathrm{cup}$ is invariant for every $g\in O(n)$: $(g\otimes g)\mathrm{cup}=\sum_a\sum_{b,c}g_{ba}g_{ca}\,e_b\otimes e_c=\sum_{b,c}(gg^T)_{bc}\,e_b\otimes e_c=\mathrm{cup}$, using only $gg^T=I$, so $\det g=-1$ is included. The record asserts this by name, and the check is the defining relation of $O(n)$.
- Hence $u_k$ is equivariant from the trivial module, and $g^{\otimes12}c_0(v)=g^{\otimes\lvert\lambda\rvert}\iota_\lambda(v)\otimes(g^{\otimes2})^{\otimes k}\mathrm{cup}^{\otimes k}=\iota_\lambda(gv)\otimes\mathrm{cup}^{\otimes k}=c_0(gv)$.

The clause "which is exactly what the $SO$-versus-$O$ gap turns on" is commentary with no role in the lemma. For $SO(n)$ one has $M_\lambda\subseteq\mathop{\mathrm{Hom}}_{SO(n)}(V_\lambda,V^{\otimes12})$, and the lemma claims nothing about the chiral $SO(n)$ constituents. No finding.

**Verdict: CONFIRMED.**

## 4. Nonvanishing

### 4a. "A tensor product of nonzero vectors is nonzero"

By I1, $V_\lambda\ne0$. Take $v\ne0$. Then $\iota_\lambda(v)\ne0$ by injectivity. For $n\ge1$, $\mathrm{cup}\ne0$ (its $e_1\otimes e_1$ coefficient is $1$), so $\mathrm{cup}^{\otimes k}\ne0$. A pure tensor of nonzero vectors over a field is nonzero, so $c_0(v)\ne0$. The argument in fact gives $c_0$ injective. It holds at every $n\ge1$ and uses no threshold.

**Candidate 4 (withdrawn).** (1) Location: C [line 45](../findings/brauer-pairing.md#L45) "At **every** $n$", with B's "nonzero". (2) Failure: $n=0$, $V=\mathbb R^0=0$, $\lambda=\varnothing$ is admissible ($0\le0$), $V_\varnothing=\mathbb R\ne0$, $k=6$, $\mathrm{cup}$ is the empty sum $0$, so $c_0=0$ (indeed $V^{\otimes12}=0$). (3) Charitable reading: $n$ is the dimension of the space carrying Weyl tensors and $O(n)$ acts on $\mathbb R^n$, and nothing in the programme reads $n=0$. Withdrawn. H3 ($n\ge1$) is recorded in the inventory.

**Verdict: CONFIRMED** at every $n\ge1$.

### 4b. "The cap computation returning $n^k\iota_\lambda$"

The claimed identity, with caps on the pairs of the $k$ cups, is $\mathrm{cap}_{\lvert\lambda\rvert+1,\lvert\lambda\rvert+2}\circ\dots\circ\mathrm{cap}_{11,12}\circ c_0=n^k\iota_\lambda$. The record writes the result and no derivation. The only support the files name is [L65Statement.lean](../lean/HamiltonsCubic/Results/L65Statement.lean)'s remark that "the record verifies it at $n = 3,4,5,6$ for $k = 1,2,3$", which is a run, and the Lean theorem takes it as the hypothesis `hcap`. What would have to be proved: $\mathrm{cap}_{1,2}(\mathrm{cup})=\sum_a\langle e_a,e_a\rangle=n$, and the $k$ caps act on the $k$ disjoint cups factorwise, so $x\otimes\mathrm{cup}^{\otimes k}\mapsto n^k x$. Given the identity, nonvanishing follows at every $n\ge1$ (over $\mathbb R$, $n^k\ne0$), with $\iota_\lambda\ne0$.

The record's contrast, that this reason "proves *the map* nonzero rather than merely some contraction", is spurious: 4a already exhibits $c_0(v)\ne0$, which is the map being nonzero.

**Verdict: HYPOTHESIS-DEBT**, non-load-bearing, since 4a is a complete argument on its own.

## 5. $c_0\in M_\lambda$, and the two senses of nonzero

$c_0$ is linear (tensor product of linear maps), has domain $V_\lambda$ and target $V^{\otimes12}$ (Section 2), and is equivariant (Section 3), so $c_0\in\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})=M_\lambda$. The zero element of $M_\lambda$ is the zero map, so "nonzero in $M_\lambda$" and "nonzero as a map" are one statement, as written. $\nu(B_{12}(n))$ acts on $M_\lambda$ by post-composition, so $c_0$ is a vector of the module in C's part 1. Whether C's theorem is true is outside this round.

**Verdict: CONFIRMED.** No finding.

## 6. Admissibility

### 6a. "Without admissibility $V_\lambda=0$ and $\iota_\lambda$ does not exist"

**Candidate 6a (withdrawn as a mathematical defect, recorded as wording).** (1) Location: A [line 116](../findings/brauer-pairing.md#L116) "Without admissibility $V_\lambda=0$ and $\iota_\lambda$ does not exist", repeated at B [line 94](../findings/brauer-pairing.md#L94) and E lines 226, 771. (2) Failure: the two clauses exclude each other. Under the Weyl convention $V_\lambda=0$, and then $\iota_\lambda\colon0\to V^{\otimes\lvert\lambda\rvert}$ exists (the zero map, the inclusion of the zero subspace) and $c_0=0$. Under the brief's convention $V_\lambda$ is undefined for non-admissible $\lambda$, and then "$V_\lambda=0$" is not a statement. (3) Charitable reading: "no nonzero inclusion exists, so no nonzero seed of this form exists". Under the Weyl convention this is exactly true: $c_0$ is a map out of the zero module, hence zero, and the lemma's conclusion "nonzero" fails. That is the sense in which the hypothesis is load-bearing, and it is what [L65Statement.lean](../lean/HamiltonsCubic/Results/L65Statement.lean)'s `no_seed_of_trivial` types. The content survives.

**Verdict: CONFIRMED AS ALGEBRA.** Suggested wording: "without admissibility the Weyl module $V_\lambda$ is $0$, so $c_0=0$."

**Is it load-bearing where the lemma is applied?** A block at a given $n$ is labelled by an $O(n)$-irreducible, and by I3 its label is admissible. So admissibility cannot fail on a block at the $n$ where the block is defined. It is load-bearing when a fixed list of labels (the $71$ $O(12)$ labels) is carried to a smaller $n$: at $n=3$, $(2,2)$ has $\lvert\lambda\rvert=4\le12$, even, and $\lambda'_1+\lambda'_2=4>3$.

### 6b. The witnesses

- $\lambda=(2,2)$: $\lambda'=(2,2)$, $\lambda'_1+\lambda'_2=4$, and $4>2$, $4>3$.
- $\lambda=(2,1,1)$: $\lambda'=(3,1)$, $\lambda'_1+\lambda'_2=4>3$.

That these $V_\lambda$ vanish is I2 (unfiled). **Verdict: CONFIRMED.**

### 6c. All blocks at $n=12$, and tightness

For every partition, a part $p\ge1$ contributes $1$ to $\lambda'_1$ and $[p\ge2]$ to $\lambda'_2$, at most $p$ in total, so $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$. Hence $\lvert\lambda\rvert\le12=n$ implies admissible. This argument is absent from B, which states the conclusion as a fact about "all $71$ blocks". It is on file as `conj_le_size` and `admissible_in_range` in [L65.lean](../lean/HamiltonsCubic/Results/L65.lean), whose induction I read and found correct (not built). The claim therefore holds for every $\lambda$ with $\lvert\lambda\rvert\le12$, and the value $71$ is used nowhere in it.

Tightness: $(2^6)$ has $\lambda'=(6,6)$, sum $12=n$. Equality $\lambda'_1+\lambda'_2=\lvert\lambda\rvert=12$ holds exactly for the seven partitions $(2^a,1^{12-2a})$, $a=0,\dots,6$, so $(2^6)$ is one tight point among seven. The record claims no uniqueness. Whether $(2^6)$ is among the $71$ blocks is a census fact not checkable here (see 7c).

**Verdict: CONFIRMED.**

## 7. "The seed is a diagram"

**Candidate 7.** (1) Location: A heading [line 112](../findings/brauer-pairing.md#L112) "Lemma L65, the seed is a diagram, under admissibility", E line 226 "The seed is a diagram", E line 771 "(one seed per block, given by a diagram)", B heading [line 86](../findings/brauer-pairing.md#L86) "The seed is itself a diagram". (2) Failure: a Brauer diagram $D$ acts $V^{\otimes a}\to V^{\otimes b}$, while $c_0$ has domain $V_\lambda$, which for even $\lvert\lambda\rvert\ge2$ and $n\ge1$ is a proper subspace of $V^{\otimes\lvert\lambda\rvert}$ (an irreducible of $V^{\otimes2}=\mathrm{Sym}^2_0V\oplus\Lambda^2V\oplus\mathbb R$ for $n\ge2$, and at $n=1$ no $\lambda$ with $\lvert\lambda\rvert\ge2$ is admissible). So $c_0=\nu(D_{\mathrm{pad}})\circ\iota_\lambda$ with $D_{\mathrm{pad}}=\mathrm{id}^{\otimes\lvert\lambda\rvert}\otimes\mathrm{cup}^{\otimes k}$, a diagram composed with an inclusion. At $\lvert\lambda\rvert=12$, $D_{\mathrm{pad}}=\mathrm{id}$ and $c_0=\iota_\lambda$, as B line 98 itself says ("there is no cup at all, and the content there is that an inclusion is nonzero"). The only $\lambda$ at which $c_0$ is a diagram is $\lambda=\varnothing$, where $c_0(1)=\mathrm{cup}^{\otimes6}$, the six-cup matching. (3) Charitable reading: "is a diagram" abbreviates "is $\iota_\lambda$ followed by a padding diagram", which the body of A and E states. That reading makes the body correct and leaves the headings and E's parenthetical overclaiming for every $\lambda\ne\varnothing$, a wider set than the $16$ blocks that B's closing remark and [L65.lean](../lean/HamiltonsCubic/Results/L65.lean)'s `diagram_failure_share` concede. The heading's claim fails as stated.

**Verdict: REFUTED AS STATED.** The mathematics is unaffected. A correct name: "the seed is the inclusion followed by a padding diagram".

### 7c. The counts

$16$ blocks with $\lvert\lambda\rvert=12$, $17$ of $184$ multiplicities, $71$ blocks, and $19$ $SO(12)$ labels with three chiral pairs (D line 11): each is the output of a multiplicity census of the sextic covariants, and no derivation is in the passages on file. None enters the lemma's truth. The partition count of the candidate range, $p(0)+p(2)+\dots+p(12)=1+2+5+11+22+42+77=160$, only bounds them. What would have to be proved: the decomposition of $\mathrm{Sym}^3(\mathrm{Weyl}_{12})$ into $O(12)$-isotypic parts with those label and multiplicity counts. `diagram_failure_share` checks $16\cdot4<71<16\cdot5$, arithmetic on the census inputs.

**Verdict: HYPOTHESIS-DEBT**, unused by L65.

## 8. "Removes a search ... adds no certificate", and scope

- Scope: the argument (Sections 2-5) holds at every $n\ge1$ for every admissible $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$. The $12$ is the leg count $3\cdot4$. The lemma is dimension-free, with admissibility the only $n$-dependent hypothesis, and at $n\ge12$ that hypothesis is automatic (6c).
- "Removes a search": L65 supplies a nonzero element of $M_\lambda$ in closed form, which is the seed C's part 2 requires. The removal of the search from the pipeline is conditional on C, which this round does not check.
- "Adds no certificate": L65 certifies no Gram entry, rank or covariant, so the sentence is accurate.

**Verdict: CONFIRMED.**

## 9. The Lean files

[L65Statement.lean](../lean/HamiltonsCubic/Results/L65Statement.lean) types:
- `legs`, `no_cup_iff`: $2\lfloor(12-f)/2\rfloor+f=12$ and $k=0\iff f=12$, for even $f\le12$.
- `tprod_map_equivariant`: the tensor product of two equivariant maps is equivariant, for an arbitrary group $G$.
- `seed_ne_zero`: $\mathrm{cap}\circ c_0=nk\cdot\iota$, $nk\ne0$, $\iota\ne0$ imply $c_0\ne0$, with `hcap` a hypothesis.
- `no_seed_of_trivial`: a linear map out of a subsingleton module is zero.
- `admissibility_witnesses`, `admissibility_tight`, and two non-vacuity examples.

Its docstring states that $V_\lambda$, $\iota_\lambda$, cup, $c_0$ and $M_\lambda$ are not constructed, nor the cap identity, nor I1.

[L65.lean](../lean/HamiltonsCubic/Results/L65.lean) types the partition arithmetic: `conj_le_size`, `admissible_of_size_le`, `admissible_in_range`, `tight_conj`, `tight_size`, the three failure witnesses, `leg_count`, `cups_wellposed`, `diagram_failure_share`.

Neither file states the lemma ($c_0\in M_\lambda$, $c_0\ne0$). Neither was built in this round.

**Verdict: REFUTED AS STATED** for "state or prove the lemma". Each typed ingredient reads as correct.

### 9, withdrawn candidates

- **Shape of `seed_ne_zero` (withdrawn).** (1) `(cap : T →ₗ[ℝ] Vlam) (iota : Vlam →ₗ[ℝ] Vlam)`, with the docstring "Reading `c₀` for the seed, `cap` for the contraction with `k` cups and `ι` for the inclusion". (2) The record's cap lands in $V^{\otimes\lvert\lambda\rvert}$ and $\iota_\lambda\colon V_\lambda\to V^{\otimes\lvert\lambda\rvert}$, which for $\lvert\lambda\rvert\ge2$ is not an endomorphism of $V_\lambda$, so the literal instantiation does not typecheck. (3) Charitable reading: instantiate with $\mathrm{cap}':=\pi_\lambda\circ\mathrm{cap}$, $\pi_\lambda$ the orthogonal projection onto $\iota_\lambda(V_\lambda)$, and `iota` $:=\mathrm{id}_{V_\lambda}$. Then $\mathrm{cap}'\circ c_0=n^k\,\mathrm{id}$ and the theorem applies. Withdrawn, the docstring's reading is loose.
- **"Verbatim" quotation (withdrawn as mathematics, noted as editorial).** The docstring's quote of B ends "reflection included." and uses dashes at two places where the source has commas and continues "which is exactly what the $SO$-versus-$O$ gap turns on" ([line 96](../findings/brauer-pairing.md#L96), [line 98](../findings/brauer-pairing.md#L98)). The difference changes no mathematical content.
- **"Cannot fail in the programme's range" (L65.lean docstring, withdrawn).** It holds at $n=12$ (and $n\ge12$). At $n<12$ it fails for labels with $\lvert\lambda\rvert\le12$, e.g. $(2,2)$ at $n=3$. The docstring pins the range to "$\lvert\lambda\rvert\le12=n$", so it is correct as scoped.

## 10. The boundary

- $\lambda=\varnothing$: admissible at every $n$. $V_\varnothing=\mathbb R$, $\iota_\varnothing=\mathrm{id}_{\mathbb R}$, $k=6$, $c_0(1)=\mathrm{cup}^{\otimes6}\ne0$ for $n\ge1$. This is the one case where the seed is a diagram (Section 7).
- $\lvert\lambda\rvert=12$: $k=0$, $\mathrm{cup}^{\otimes0}=1\in V^{\otimes0}$, $c_0=\iota_\lambda$. It is nonzero by I1, and 4b degenerates to $n^0\iota_\lambda=\iota_\lambda$.
- Small $n$. At $n=1$ the admissible labels are $\varnothing$ and $(1)$, so the only even one is $\varnothing$, with $c_0(1)=e_1^{\otimes12}\ne0$. At $n=2$ the admissible labels are $\varnothing$, $(m)$ for $m\ge1$, and $(1,1)$ [$(2,1)$ gives $2+1=3>2$], and the lemma applies to each with even size $\le12$. At $n=0$ see withdrawn candidate 4.
- $n<\lvert\lambda\rvert$ with $\lambda$ admissible, e.g. $\lambda=(12)$ at $n=2$ ($1+1\le2$). $V_{(12)}$ is the traceless symmetric $12$-tensors on $\mathbb R^2$, nonzero, and $c_0=\iota_{(12)}\ne0$. The size of $n$ against $\lvert\lambda\rvert$ enters only through admissibility.
- Non-admissible $\lambda$: Section 6a.

**Verdict: CONFIRMED** with H3.

## 11. Falsifiers sought

| Claim | Falsifying object | Search |
|---|---|---|
| $c_0$ well defined | admissible $\lambda$ with $\lvert\lambda\rvert$ odd or $>12$ | found $(1)$, $(14)$ at $n=2$, withdrawn by block scope (Section 2) |
| Equivariance | $g\in O(n)\setminus SO(n)$ moving cup | none exists: $(g\otimes g)\mathrm{cup}=\mathrm{cup}$ from $gg^T=I$ |
| Nonvanishing | $(n,\lambda)$ admissible with $c_0=0$ | only $n=0$, $\lambda=\varnothing$, withdrawn. At $n\ge1$ none exists by 4a |
| Load-bearing | non-admissible $\lambda$ with $c_0\ne0$ | none exists under the Weyl convention, since $V_\lambda=0$ |
| All blocks admissible at $n=12$ | $\lvert\lambda\rvert\le12$ with $\lambda'_1+\lambda'_2>12$ | none exists by $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$ |
| "The seed is a diagram" | any block with $\lambda\ne\varnothing$ | every such $\lambda$ falsifies the literal reading (Section 7) |
| Pointer | the named section lacking the argument | lines 40-50 lack it, and B holds it (Section 1) |
| Lean states the lemma | a theorem with conclusion $c_0\in M_\lambda$, $c_0\ne0$ | both files read in full, and none is present |
