# REVIEW r264, Gate 2, the seed lemma

Reviewer 264. Commits under review: `e0b9cb0` (primary), `90ad8d9`, `f99e050`.
Primary file: [run_seed_is_a_diagram.py](../scripts/runs/run_seed_is_a_diagram.py), and the final section of [findings/brauer-pairing.md](../findings/brauer-pairing.md). Constraining prior reviews: [r259](REVIEW_r259.md), [r260](REVIEW_r260.md), [r261](REVIEW_r261.md), [r262](REVIEW_r262.md).
Scripts: [scripts/reviewers/r264/](../scripts/reviewers/r264/). Reviewer 263 runs the identical brief concurrently and independently.

**The tree moved while this review was being written.** Everything below is a verdict on the three commits named above, as they stand at `e0b9cb0`. Between my sweep and this filing, an uncommitted working-tree edit applying [r263](REVIEW_r263.md) landed on [findings/brauer-pairing.md](../findings/brauer-pairing.md), [findings/INDEX.md](../findings/INDEX.md) and both scripts; where it has already applied a finding I reached independently, the row says so. **Claims 1, 2 and 4 converge with r263 on four points reached from different evidence**, the missing admissibility hypothesis, the $16$ blocks with no padding, obligation (ii) not being closed, and `padded_seed`'s inferred exponent. Claim 5, Claim 6 and the $19\to16$ count are this review's own; the last of those is now applied too, with the $O$/$SO$ split named.

Every number below comes from a route that shares no code with the reviewed script. The seed is built from a genuine Young symmetriser applied to an all-distinct-index tensor (traceless by construction, so it lies in $V_\lambda$ and not merely in the $GL$ Weyl module) and the diagram action is applied through `einsum` on the $(n,\dots,n)$ tensor rather than through dense $n^f\times n^f$ matrices. $\dim\operatorname{End}_{O(n)}(V^{\otimes f})$ is computed from three random elements of $O(n)$ and nothing else: no diagram, no tableau.

| # | Claim | Verdict |
|---|---|---|
| 1 | The seed lemma itself | **CORRECT IN SUBSTANCE, FALSE AS QUANTIFIED, and the "does it suffice in $M_\lambda$" worry is empty.** Equivariance holds. Nonvanishing holds *given $O(n)$-admissibility of $\lambda$*, which the lemma never states: at $\lambda=(2,2)$, $n=3$ and at $\lambda=(2)$, $n=1$ the space $V_\lambda$ is zero, so $\iota_\lambda=0$ and $c_0=0$, **"nonzero for every positive $n$" is refuted**, harmlessly, since every block of the $n\ge12$ table is admissible at every $n\ge12$. Nonvanishing *in* $V^{\otimes12}$ and nonvanishing *in the multiplicity space* are the **same statement**: $M_\lambda$ **is** $\operatorname{Hom}_{O(n)}(V_\lambda,V^{\otimes12})$. The cup/cap computation is sound and **redundant**, $c_0\ne0$ already because a tensor product of nonzero vectors is nonzero |
| 2 | The parity and range conditions | **ALL $71$ BLOCKS, ENUMERATED, and the framing is empty on $16$ of them.** The record's own table reproduces exactly: $71$ blocks / $184$ multiplicities after merging the SO chiral pairs, every $\lvert\lambda\rvert$ even and $\le12$, $\max(\lambda'_1+\lambda'_2)=12\le n$. So the hypotheses are automatic and no block is missed. But the $k$ census is $16/22/16/10/5/1/1$ for $k=0\ldots6$: **$16$ of the $71$ blocks have $k=0$ and carry no padding at all**, $c_0=\iota_\lambda$, which is the object [r258](REVIEW_r258.md) priced at $33{,}177{,}600$ terms. Separately, *"the $19$ blocks with $\lvert\lambda\rvert=12$"* in [findings/brauer-pairing.md](../findings/brauer-pairing.md) and [findings/INDEX.md](../findings/INDEX.md) is the **SO(12)** $77$-entry count; in the $71$-block $O$ table it is **$16$** |
| 3 | The verification | **THE GAP IS REAL AND THE LEMMA SURVIVES IT; the $e_0$ objection does not bite.** Eight cells over the two smallest labels is not a test of a lemma quantified over $\lvert\lambda\rvert\le12$. Extended here to $\lambda=(2),(1,1),(2,2),(3,1),(2,1,1),(1^4),(4)$ at $k=0,1,2$: **$35$ cells, zero mismatches** against $m_\lambda(n)$, twelve of them sub-threshold, including the admissibility boundary $\lambda'_1+\lambda'_2=n$ at $(1,1)/n=2$ and $(1^4)/n=4$. The weight-vector shortcut is **legitimate**, with a proof and a check: $\operatorname{im}c_0\subseteq V_\lambda\otimes M_\lambda$ and the diagrams act on the $M_\lambda$ factor alone, so $e_0$, a random vector of $V_\lambda$, and the full map give **the same rank** at $9$ cells. `padded_seed`'s float-log inference and its floor-divided $k$ are real fragilities but unreachable in the eight cells run; part (1) of the script is arithmetic ($\mathrm{cup}\cdot\mathrm{cup}=\sum_{a,b}\delta_{ab}$), not evidence |
| 4 | What the record claims is closed | **THE SCRIPT OVERREACHES; [findings/](../findings/), [plan.md](../plan.md) and [findings/INDEX.md](../findings/INDEX.md) DO NOT, and one of them under-claims.** *"obligation (ii) closes structurally"* and *"the covariants are now explicit combinations of diagrams"* appear **only** in the docstring of [run_seed_is_a_diagram.py](../scripts/runs/run_seed_is_a_diagram.py). Both are false: the lemma gives a seed, the theorem gives a **spanning set**, and obligation (ii)'s deliverable is the expansion of the $184$ **constructed** covariants, objects never identified with any $e\,\nu(D)c_0$. [r242](REVIEW_r242.md) names that expansion as a Gram solve whose $\det\mathrm{Gram}_S$ is open obligation (iii), so the residue is on the record already. In the other direction: **[findings/INDEX.md](../findings/INDEX.md)'s index row does not mention the seed lemma at all**, and [plan.md](../plan.md) still says the theorem *"reduces this to $71$ seeds"*, written before the seeds were free |
| 5 | The corrections in `f99e050` and `90ad8d9` | **(a) and (c) CONFIRMED; (b) IS NOT CIRCULAR, and it is now the only certificate.** (a) Weyl's FFT for $O(n)$ **is** unconditional: $\dim\operatorname{End}_{O(n)}(V^{\otimes f})=\dim\nu(B_f(n))$ at all $16$ cells tested, **$8$ of them with $n<f$**, by a route using only random elements of $O(n)$. (b) $\dim\nu=\sum_\lambda m_\lambda(n)^2$ is **independently established**, the same group-only route returns it at the same $16$ cells, so the script is not certifying itself. (c) The r244 hedge is faithful, r244 contains **zero** occurrences of $\mathrm{Gram}_S$ and prices $\xi(n)$ at $r\sim89$, degree $\le6$, and $24$ and $32$ are both right: the script's grid is $f\in\{2,3,4,5\}\times n\in[1,6]$, r259's is $\times\,n\in[1,8]$. Two blemishes the same commit introduced: an assert that says *"the six primes"* over a **two**-prime tuple, and a docstring sentence that restates itself |
| 6 | Prior findings still unapplied | **FOUR AT `e0b9cb0`, TWO STILL LIVE.** (1) *The conditional theorem box still stands above the unconditional paragraph in **both** files*, [run_diagram_realisation.py:21](../scripts/runs/run_diagram_realisation.py#L21) and [findings/brauer-pairing.md](../findings/brauer-pairing.md) still open the theorem with *"$B_{12}(12)$ is semisimple over $\mathbb Q$"*, which the section below each declares decoration ([r261](REVIEW_r261.md) claim 1, named explicitly, not applied by any of the three commits). (2) *The Gram identity's reason is still absent*, both [r261](REVIEW_r261.md) and [r262](REVIEW_r262.md) traced $n^{\mathrm{loops}}$ to the **Frobenius** pairing of $\nu(D),\nu(E)$ and its positive-definiteness; neither word occurs in either file. (3) [plan.md:55](../plan.md) still reads *"A3 cannot start without it"*, the conflation [r262](REVIEW_r262.md) claim 3 named, now merely ambiguous rather than wrong, since obligation (ii) is restored beneath it. (4) The *"$19$ blocks"* count above, not previously raised |

## Claim 1, the seed lemma

**Equivariance is right and needs no defence.** $\mathrm{cup}=\sum_a e_a\otimes e_a$ is the invariant metric element, $\iota_\lambda$ is $O(n)$-equivariant by construction, and $v\mapsto\iota_\lambda(v)\otimes\mathrm{cup}^{\otimes k}$ is the tensor product of an equivariant map with an invariant vector. It lands in $V^{\otimes\lvert\lambda\rvert}\otimes V^{\otimes 2k}=V^{\otimes12}$ exactly as claimed.

**The brief's central worry is empty, and the reason is a definition.** The record's $M_\lambda$ *is* $\operatorname{Hom}_{O(n)}(V_\lambda,V^{\otimes12})$, [brauer-pairing.md](../findings/brauer-pairing.md) states it in the theorem box and again in *"$e\,M_\lambda=\operatorname{Hom}_{O(n)}(V_\lambda,\mathrm{Sym}^3\mathrm{Weyl}_n)$"*. So "nonzero as a map into $V^{\otimes12}$" and "nonzero in the multiplicity space" are one statement, not two. What is genuinely a *different* statement ($e\,c_0\ne0$, the seed lying in the covariant space), is **not needed**, and the record says so, correctly, on [r259](REVIEW_r259.md)/[r261](REVIEW_r261.md)/[r262](REVIEW_r262.md)'s authority.

**The nonvanishing argument is sound and redundant.** Contracting the last $2k$ legs of $c_0$ with $k$ caps returns $n^k\iota_\lambda$; over $\mathbb Q$ with $n\ge1$ that is nonzero *provided $\iota_\lambda\ne0$*. But $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a tensor product of nonzero vectors, so it is nonzero under exactly the same proviso, with no computation. The cup/cap step buys nothing the elementary observation does not, and it buys nothing over a field where $n$ could vanish either, since $\mathrm{cup}\ne0$ regardless.

**And the proviso is the whole content, so stating the lemma without it makes it false.** $V_\lambda$ exists for $O(n)$ exactly when $\lambda'_1+\lambda'_2\le n$; outside that range $\iota_\lambda=0$ and $c_0=0$. Two witnesses fell out of the sweep in Claim 3 without being looked for: at $\lambda=(2,2)$ the label is inadmissible at $n=2,3$, and at $\lambda=(2)$, $n=1$ the traceless part of $\mathrm{Sym}^2(\mathbb R^1)$ is zero. So *"IT IS NONZERO FOR EVERY POSITIVE $n$"* (the script's capitals) and *"nonzero for every positive $n$"* in the findings file are both refuted as written. **The damage is zero at the route's own $n$** (Claim 2), which is why this is a wording defect and not a route defect; the honest statement is *"nonzero whenever the block exists"*.

## Claim 2, parity, range, and the $71$ blocks

[c2_block_census.py](../scripts/reviewers/r264/c2_block_census.py) reads [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl), merges the SO chiral pairs, and reproduces the record's shape exactly.

| quantity | computed here | record |
|---|---|---|
| $O(n\ge12)$ blocks / multiplicities | $71$ / $184$ | $71$ / $184$ |
| SO(12) entries / multiplicities | $77$ / $191$ | $77$ / $191$ |
| $\max\lvert\lambda\rvert$, all even | $12$, yes | $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ |
| $\max(\lambda'_1+\lambda'_2)$ | $12$ | $12$, at $(2,2,2,2,2,2)$ |

**So the construction covers all $71$, and there is nothing to enumerate as missing.** Every constituent of $\mathrm{Sym}^3(\mathcal W_n)\subset V^{\otimes12}$ automatically has $\lvert\lambda\rvert\le12$ and $\lvert\lambda\rvert\equiv12\bmod2$, and $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert\le12\le n$ at every $n\ge12$. The lemma's two hypotheses are consequences of the block being a block. **The admissibility hypothesis Claim 1 says is missing is therefore free here**, but it is free by an argument the record does not make, and it stops being free the moment the lemma is quoted at small $n$, which the verification script does at $n=2$ and $n=3$.

**$16$ of the $71$ blocks get no padding.** The census of $k=(12-\lvert\lambda\rvert)/2$:

| $k$ | 0 | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|---|
| blocks | **16** | 22 | 16 | 10 | 5 | 1 | 1 |

At $k=0$ the lemma reads $c_0=\iota_\lambda$ and its proof reads $n^0\iota_\lambda=\iota_\lambda$. **For those $16$ blocks the section's title, *"The seed is itself a diagram"*, is false**, there is no diagram, only the inclusion, and $\iota_\lambda$ is exactly [r258](REVIEW_r258.md)'s Young-symmetriser object $c_\lambda e_I$ at $33{,}177{,}600$ terms. For the other $55$ it is half true: $c_0$ is a padding diagram **composed with** $\iota_\lambda$, and the script's own body concedes this, *"$c_0$ is a diagram acting on iota_lambda"*. The defensible claim, and it is worth having, is that **a seed exists in closed form and needs no search**; that is weaker than the title and it is what the argument proves.

**A count in the record is off by three.** [findings/brauer-pairing.md](../findings/brauer-pairing.md) and [findings/INDEX.md](../findings/INDEX.md) both say the $n^6$ ceiling is *"attained only in the $19$ blocks with $\lvert\lambda\rvert=12$"*. The $71$-block table has **$16$**; the SO(12) $77$-entry table has $19$, the difference being the three six-row labels of size $12$ that split chirally. This is the same $O$-versus-$SO$ conflation [r261](REVIEW_r261.md) and [r262](REVIEW_r262.md) found in the citation, appearing here as an arithmetic figure. It predates the three commits under review.

## Claim 3, the verification, at labels that are not the two smallest

**The brief's complaint is fair.** All eight cells use $\lambda=\varnothing$ or $\lambda=(1)$, whose $m_\lambda(n)$ values run $1,3,3,3,3$ and $3,10,15$. Nothing in that grid distinguishes a lemma about $\iota_\lambda$ from a lemma about the invariant vector and the vector representation.

**The extension.** [c3_nontrivial_lambda.py](../scripts/reviewers/r264/c3_nontrivial_lambda.py) builds the seed properly: $v=c_\lambda(e_0\otimes e_1\otimes\dots\otimes e_{m-1})$, the Young symmetriser on an all-distinct-index tensor. Distinct indices make every contraction $\delta_{i_ai_b}$ vanish, and permutations preserve that, so $v$ is traceless, hence in the $O(n)$ irreducible $V_\lambda$, not merely in the $GL$ Weyl module. Tracelessness is asserted in code at every cell. Then $c_0(v)=v\otimes\mathrm{cup}^{\otimes k}$, and the rank of $\{\nu(D)c_0(v)\}$ is compared against $m_\lambda(n)$ from the restricted up–down recursion.

**$35$ cells, zero mismatches** ([out_c3.txt](../scripts/reviewers/r264/out_c3.txt)). Selected rows:

| $\lambda$ | $f$ | $n$ | $k$ | sub-threshold | rank | $m_\lambda(n)$ |
|---|---|---|---|---|---|---|
| $(2)$ | 6 | 3 | 2 | yes | 40 | 40 |
| $(1,1)$ | 6 | 3 | 2 | yes | 36 | 36 |
| $(1,1)$ | 4 | 2 | 1 | yes | 3 | 3 |
| $(2,2)$ | 6 | 4 | 1 | yes | 25 | 25 |
| $(3,1)$ | 6 | 4 | 1 | yes | 45 | 45 |
| $(2,1,1)$ | 6 | 4 | 1 | yes | 36 | 36 |
| $(1,1,1,1)$ | 6 | 4 | 1 | yes | 10 | 10 |
| $(4)$ | 6 | 4 | 1 | yes | 15 | 15 |
| $(2,2)$ | 4 | 4 | 0 |, | 2 | 2 |

Twelve of the $35$ are sub-threshold ($n<f-1$), where the abstract algebra is not semisimple. Two sit on the admissibility boundary $\lambda'_1+\lambda'_2=n$: $(1,1)$ at $n=2$ and $(1^4)$ at $n=4$, the latter self-associate for $O(4)$, **an independent reconfirmation of [r262](REVIEW_r262.md)'s "no doubling is owed"**, since a doubled multiplicity space would put the rank at $2m_\lambda$.

**The $e_0$ objection does not bite, and here is why.** $c_0$ is an element of $M_\lambda$, so $\operatorname{im}c_0$ lies in the $\lambda$-isotypic component $V_\lambda\otimes M_\lambda$, and under that splitting $c_0(v)=v\otimes m_0$ for a fixed $m_0\in M_\lambda$. The diagram algebra acts as $1\otimes(\cdot)$, so
$$\operatorname{span}\{\nu(D)c_0(v)\}=v\otimes\big(\nu(B)\,m_0\big),$$
whose dimension is $\dim\nu(B)c_0$ for **every** nonzero $v$. Evaluating at one weight vector loses nothing. [c3_evalpoint.py](../scripts/reviewers/r264/c3_evalpoint.py) confirms it: $e_0$, a random vector of $V_\lambda$, and the stacked full map give the identical rank at all $9$ cells ([out_c3b.txt](../scripts/reviewers/r264/out_c3b.txt)). **So the thing the script tests IS the lemma's $c_0$**, with the caveat that for $f$ odd it tests it at $\lambda=(1)$ only, which is the complaint this section answers.

**Two fragilities in `padded_seed`, neither reachable in the run.** The exponent is inferred as `int(round(np.log(len(base)) / np.log(n)))`, which is a float route to an integer that is already known to the caller, and which divides by zero at $n=1$. And `k = (f - m) // 2` **floor-divides away the lemma's own parity hypothesis**: a caller violating $\lvert\lambda\rvert\equiv f\bmod2$ silently gets a vector of the wrong length rather than an error. Neither fires in the eight cells, because the only bases used are the scalar and $e_0$. A one-line postcondition, `assert len(out) == n ** f`, would close both.

**One check is arithmetic rather than evidence.** Part (1) verifies $\mathrm{cup}^{\otimes k}\cdot\mathrm{cup}^{\otimes k}=n^k$ at four values of $n$. That identity is $\sum_{a,b}\delta_{ab}=n$ raised to the $k$; it involves no $\iota_\lambda$ and cannot distinguish a true lemma from a false one. It is the $\lambda=\varnothing$ shadow of the nonvanishing claim, not the claim.

## Claim 4, what the record now claims is closed

**The overreach is confined to one file, and it is the primary file.** Grepping the whole tree, *"closes structurally"* and *"WHY THIS CLOSES (ii)"* occur only in the docstring of [run_seed_is_a_diagram.py](../scripts/runs/run_seed_is_a_diagram.py). [findings/brauer-pairing.md](../findings/brauer-pairing.md)'s new section says only that the gap *"kept obligation (ii) open"* and that the seed *"need not be searched for"*, and closes with an honest **What stays open**. [plan.md](../plan.md) and [findings/INDEX.md](../findings/INDEX.md) were not touched by `e0b9cb0` at all.

**The docstring's claim is false, in one specific step.** It reasons: *"The covariants are now explicit combinations of diagrams: $c_0$ is a diagram acting on $\iota_\lambda$, and the theorem's $e\,\nu(D)c_0$ are diagrams acting on the same thing."* What that establishes is that the **spanning set** consists of diagrams. Obligation (ii)'s deliverable, restored by `90ad8d9` two minutes earlier, is *"each of the $184$ **constructed** covariants is exhibited as an explicit combination of Brauer diagrams"*. Three things separate them:

- **The constructed covariants are never identified with the $e\,\nu(D)c_0$.** They come out of the weight-space route; nothing in the record maps one family onto the other.
- **A spanning set is not an expansion.** Writing a given element over $\{e\,\nu(D)c_0\}$ is a linear solve with $23!!=316{,}234{,}143{,}225$ columns and no coefficient bound, the gap [r260](REVIEW_r260.md) named and the record still records two paragraphs above.
- **The record already prices that solve as an open obligation.** [r242](REVIEW_r242.md) says in terms that item 1 *"expresses each covariant in the diagram spanning set by solving against the diagram Gram"* and that every returned coordinate carries $\det\mathrm{Gram}_S(n)$ in its denominator, which is obligation **(iii)**, still open. So the residue of (ii) is (iii), and the seed lemma touches neither.

**Nor does "needs no search" survive to the deliverable.** It is true of the seed. Choosing $184$ independent members of a $3.16\times10^{11}$-element spanning set is a search, and it is the one obligation (ii) actually faces.

**And there is an under-claim, of the shape `ae44228` produced.** [findings/INDEX.md](../findings/INDEX.md)'s [brauer-pairing.md](../findings/brauer-pairing.md) row carries the pairing theorem and the realisation theorem and **says nothing about the seed lemma**, the cycle's own new result is absent from the index it is indexed by. [plan.md](../plan.md) item 1(ii) still reads *"The realisation theorem reduces this to $71$ seeds, one per block"*, a sentence written when the seeds were the difficulty. Both are stale in the *conservative* direction, so nothing false is asserted; but a reader of the index cannot find the result.

## Claim 5, the corrections in `f99e050` and `90ad8d9`

### (a) The FFT, and whether Weyl's version is unconditional

**Confirmed, by a route with no diagram in it.** [c5_fft_commutant.py](../scripts/reviewers/r264/c5_fft_commutant.py) computes $\dim\operatorname{End}_{O(n)}(V^{\otimes f})$ as the nullity of the commutator system for three random elements of $O(n)$ (two in $SO(n)$, one with $\det=-1$, so both components are hit) and compares it against $\dim\nu(B_f(n))$ and $\sum_\lambda m_\lambda(n)^2$.

| $f$ | $n$ | $n<f$ | $(2f-1)!!$ | $\dim\operatorname{End}_{O(n)}$ | $\dim\nu(B_f(n))$ | $\sum m_\lambda(n)^2$ |
|---|---|---|---|---|---|---|
| 3 | 2 | yes | 15 | 10 | 10 | 10 |
| 4 | 2 | yes | 105 | 35 | 35 | 35 |
| 4 | 3 | yes | 105 | 91 | 91 | 91 |
| 5 | 2 | yes | 945 | 126 | 126 | 126 |
| 6 | 2 | yes | 10395 | 462 | 462 | 462 |
| 2 | 1 | yes | 3 | 1 | 1 | 1 |

**All $16$ cells agree, $8$ of them with $n<f$** where $\nu$ is far from injective, at $(6,2)$ the algebra has $10{,}395$ dimensions and the image $462$. So the surjection is unconditional in $n$, and attributing it to Weyl's FFT for $O(n)$ rather than to ASWT 3.17(b) is correct. ([r260](REVIEW_r260.md) asked for Brauer 1937 and the commit names Weyl; both are standard names for the two halves of one classical fact, the invariant-theoretic statement is Weyl's, its translation into $\nu$ being onto is Brauer's. Neither attribution is wrong.)

### (b) The modular rank, and whether the certificate is circular

**Not circular.** The chain is: the modular rank is a **lower** bound; $\dim\nu=\sum_\lambda m_\lambda(n)^2$ supplies the **upper** bound; they meet, so the value is exact. The upper bound is a theorem (the double centraliser plus the FFT) and it is **not** the statement the table tests, which is $\dim\nu=\sum_\lambda(\dim\Delta_\lambda)^2$, the cell-module form. The two part company at exactly the sub-threshold cells, which is where the table's content lives.

**And the upper bound is independently established, not asserted.** The same group-only route above returns $\sum_\lambda m_\lambda(n)^2$ at all $16$ cells without touching a Gram, a prime or a tableau, the identity is confirmed from the group side, so nothing in the script is certifying itself. *In the semisimple range the test does degenerate*: there the two forms coincide, and "modular rank meets the upper bound" makes the assertion automatic. The informative rows are the sub-threshold ones, and the file now says so.

**Two blemishes the same commit introduced.** [run_diagram_realisation.py:232](../scripts/runs/run_diagram_realisation.py#L232) asserts over a **two**-element `primes` tuple with the message *"the six primes disagree on rank"*; and the docstring above it now reads *"Rank is taken modulo TWO 31-bit primes: the rank is taken modulo two 31-bit primes, and cross-checked exactly"*. Both are cosmetic; the second is an edit that left its own predecessor in place.

### (c) The r244 hedge and the pair counts

| item | checked | verdict |
|---|---|---|
| r244 mentions $\det\mathrm{Gram}_S$ | `grep -c` over [REVIEW_r244.md](REVIEW_r244.md) | **zero occurrences**, the hedge is needed and is now present |
| r244's $\sim89$, degree $\le6$ | [REVIEW_r244.md](REVIEW_r244.md) line 33 | *"a determinant of an $r\times r$ matrix with $r$ of order $89$ and entries of degree $\le6$"*, said of $\xi(n)$, matches [plan.md](../plan.md)'s corrected wording verbatim |
| r242's own witness is a $3\times3$ Gram | [REVIEW_r242.md](REVIEW_r242.md) line 29 | $\det\mathrm{Gram}_S(n)=343n(n-1)(869n-2767)/24$, consistent |
| the script's $24$ | grid at [run_diagram_realisation.py:319](../scripts/runs/run_diagram_realisation.py#L319) | $f\in\{2,3,4,5\}\times n\in[1,6]=\mathbf{24}$ |
| r259's $32$ | *"every $(f,n)$ with $2\le f\le5$, $1\le n\le8$"* | $4\times8=\mathbf{32}$ |

**All five confirmed.** The *"all $40$ pairs"* figure [r262](REVIEW_r262.md) refuted is gone, replaced by *"$24$ in the script, and independently $32$ in r259's sweep"*, and both numbers are the right ones.

## Claim 6, prior findings still unapplied

I walked all $24$ verdict rows of [r259](REVIEW_r259.md), [r260](REVIEW_r260.md), [r261](REVIEW_r261.md), [r262](REVIEW_r262.md) against the working tree. Applied: the audit script's deletion and the restoration of its one sound conclusion; the deliverable restored to [plan.md](../plan.md) item 1(ii); the three refuted sentences in [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py); the ASWT miscitation; the r244 misattribution; the *"$40$ pairs"* figure; the *"exactly one sub-threshold failure"* artefact; the non sequitur about agreeing primes; the *"tighter than Rui's"* self-contradiction in [rui-brauer-semisimplicity/notes.md](../references/rui-brauer-semisimplicity/notes.md). Four are not.

**1. The conditional theorem box is still printed above the unconditional paragraph, in both files.** [r261](REVIEW_r261.md) claim 1 named this in those words. [run_diagram_realisation.py:21](../scripts/runs/run_diagram_realisation.py#L21) still opens the theorem with *"(i) $B_{12}(12)$ is SEMISIMPLE over $\mathbb Q$"*, and [findings/brauer-pairing.md](../findings/brauer-pairing.md)'s box still reads *"At $n=12$: 1. $B_{12}(12)$ is semisimple over $\mathbb Q$"*, both immediately above a section headed *"The theorem is unconditional in $n$, no threshold enters"*. A reader taking the box as the statement takes a threshold the file then says is decoration. `f99e050` rewrote the paragraphs around the box and left the box.

**2. The Gram identity's reason is still missing.** [r261](REVIEW_r261.md) claim 4 and [r262](REVIEW_r262.md) claim 4 both derived it: $n^{c(D\cup D')}$ is the **Frobenius** inner product $\langle\nu(D),\nu(E)\rangle$, which is positive definite, which is why the Gram rank equals $\dim\operatorname{span}\{\nu(D)\}$ and why the $n$-independent-size shortcut is legitimate at all. Neither *"Frobenius"* nor *"positive definite"* occurs anywhere in [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) or [findings/brauer-pairing.md](../findings/brauer-pairing.md). **This one is load-bearing**: the whole $f=5$ half of the table rests on the Gram shortcut, and the file states the identity as a fact with no argument.

**3. [plan.md:55](../plan.md) still reads *"A3 cannot start without it"*.** [r262](REVIEW_r262.md) claim 3 called this the conflation its conclusion (c) named. `90ad8d9`'s own message quotes the sentence and says both halves are restored, the deliverable was, this sentence was not. It is now **ambiguous rather than wrong**, because item 1(ii) beneath it says *"A3 consumes the objects, not the theorem"*, so *"it"* reads as the object. Naming the object would settle it.

**4. The *"$19$ blocks with $\lvert\lambda\rvert=12$"* count**, in both [findings/brauer-pairing.md](../findings/brauer-pairing.md) and [findings/INDEX.md](../findings/INDEX.md), $16$ in the $71$-block table, per Claim 2. Not previously raised.

### State at filing

The in-flight r263 edit has since closed (1) (the theorem box now reads *"At **every** $n$"* with the semisimplicity clause gone) and (4), which now carries the $O$/$SO$ split explicitly: *"the $16$ $O(12)$ blocks with $\lvert\lambda\rvert=12$ ($19$ is the $SO(12)$ count)"*. **Two remain, and a third has appeared.**

- **The Frobenius reason is still missing.** Zero occurrences of *"Frobenius"* or *"positive definite"* in either [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) or [findings/brauer-pairing.md](../findings/brauer-pairing.md), across three cycles of corrections. This is the one unapplied finding that carries weight.
- **[plan.md:55](../plan.md) still reads *"A3 cannot start without it"*.**
- **New, and introduced by the in-flight edit: [run_seed_is_a_diagram.py:1](../scripts/runs/run_seed_is_a_diagram.py#L1) still says *"obligation (ii) closes structurally"* while line 38 of the same docstring says *"It does NOT close obligation (ii)"* and adds *"the header of this file first claimed otherwise"*.** The header it names is the line above it, unedited. A file whose first line asserts what its body refutes is the `ae44228` failure mode in miniature, the correction applied to the paragraph, not to the claim wherever it appears.
- The *"the six primes disagree"* message over a two-prime tuple ([run_diagram_realisation.py:244](../scripts/runs/run_diagram_realisation.py#L244)) also survives the edit.

## Verdict

**The lemma is true, its stated quantifier is not, and its title is not.** $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is equivariant and nonzero **whenever the block exists**, which at the route's own $n\ge12$ is every one of the $71$ blocks, so the substance survives intact and the construction misses nothing. *"Nonzero for every positive $n$"* is refuted by any inadmissible $\lambda$, and *"the seed is itself a diagram"* is refuted by the $16$ blocks with $\lvert\lambda\rvert=12$, where there is no diagram and $c_0$ is the Young-symmetriser inclusion the item already had.

**The verification's coverage gap was real and the lemma survives it**: $35$ cells at seven non-trivial labels, twelve sub-threshold, zero mismatches, and the weight-vector shortcut the brief suspects is provably lossless, confirmed at $9$ cells by three routes.

**The corrections land.** Weyl's FFT is unconditional in $n$, checked at $8$ cells below injectivity with no diagram in the computation, and the identity now supplying the modular rank's upper bound is a theorem confirmed from the group side, so the certificate is not circular.

**What is claimed is right in [findings/](../findings/) and wrong in the script, and the in-flight r263 edit has since said so in the body while leaving it standing in the first line.** The deliverable of obligation (ii) is the expansion of $184$ constructed covariants; the lemma supplies a seed and the theorem a spanning set, and [r242](REVIEW_r242.md) already records the expansion's $\det\mathrm{Gram}_S$ as open obligation (iii). *"Obligation (ii) closes structurally"* should come out of the docstring. In the other direction the index has not caught up: [findings/INDEX.md](../findings/INDEX.md) does not carry the seed lemma at all.
