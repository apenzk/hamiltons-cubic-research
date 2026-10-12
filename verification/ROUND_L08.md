# ROUND L08, the graded case as a finite check, and a label that differs between files

**Id:** L08. **Source:** [findings/graded-half.md](../findings/graded-half.md):421–, with the canonical form at [results.md](../results.md):367 and the landscape line at :124. **Date:** 2026-09-07. **Verifiers allocated:** v143, v144, v145. **Phase:** 6, closed. **Verdict:** `BROKEN`, repaired, impact `PROPAGATES`.

**Why this id.** Tier 1, cited eight or more times. It is the record's account of the graded half, the side [Lemma L7](../findings/bounds.md)'s dichotomy leaves when its inequality is an equality.

**Phase 0's own finding.** The findings block and the canonical form both head this **Conjecture L8**; [results.md](../results.md):124 heads it **Lemma L8**. Under the record's own labelling rule those are different claims, one proven, one a candidate. **The verifiers are told neither heading.**

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **What is actually established, and what is checked?** **Separate the general reduction from the case-by-case settlement: say precisely which statement is proved for all objects in scope, which is verified family by family, and which families are covered.**
2. **Does the value follow from the pair's dimensions and one Casimir ratio?** **Derive that, say what it needs, and check it at named symmetric pairs, including one where the two sides could differ.**
3. **What does "finite" rest on?** *A finite check presupposes a classification.* **Name the classification used, say whether its source is in [references/](../references/), and say what the check would have to exhaust if it were not available.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source, this record holds no Cartan, Helgason, Berger or Besse entry, which earlier rounds have established.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

**SCOPE REFUTED, the pinning holds for the pair's EQUIVARIANT critical point, not for every graded one.** *Candidate, Gate 2 owed; the counterexample was built and checked here, and the refutation is the highest-variance kind on the record.* A second graded critical point on the **same** symmetric pair $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ carries $\theta=1.088948$ against $S^3\times S^5$'s $1.115547$: same $p=\dim\mathfrak k=13$, same $q=\dim\mathfrak m=15$, trivial kernel, all three bracket inclusions to $10^{-29}$, and **its isotropy algebra has the identical Killing spectrum** $-3.0^{\times10}\oplus-1.0^{\times3}$, difference exactly $0$, so it is the same pair and not a coincidence of dimensions. *The mechanism is this file's companion equivalence*: on a graded point $\Delta=0$ iff $W$ is $\mathrm{ad}(\mathfrak p)$-equivariant ([bounds.md](bounds.md)), and Schur then makes $W$ scalar on each irreducible summand, which is what the formula below encodes. **Drop equivariance and a single pair carries a family**, the witness having $\Delta=1.512231$ and five distinct positive eigenvalues where the equivariant point has two. So what follows settles the **equivariant** graded critical points, and the graded half is settled only over those. The sentence as originally written read: a graded critical point is pinned by its pair's dimensions, $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$ with $p=\dim\mathfrak k$, $q=\dim\mathfrak m$; and a second identity, counting the pair's structure constants two ways, reduces $c_{\mathfrak k}$ to a tabulated Casimir ratio. **So the value follows from three integers and one table lookup, with no curvature operator built at any stage.** It reproduces the Ricci-flat Kähler family and the sphere pairs identically, and predicts values never computed by construction.
Since the compact symmetric pairs are classified, the graded case is then a finite check, **and the check that was run settles the balanced splits only**.
Two safeguards were load-bearing: the criticality relation has to be *tested* against each pair's true Casimirs rather than solved for them, and the isotropy ideals have to be split correctly, the versions that got either wrong produced, respectively, values above the rival maximizer for pairs carrying no critical point, and a false report that no complex Grassmannian carried one.
One subtlety had to be closed. The value depends only on the abstract pair, but the defect depends on how the isotropy algebra sits inside $\mathfrak{so}(n)$: at $n=8$ the sphere product $S^3\times S^5$ and the quaternionic-Kähler operator on $\mathbb{HP}^2$ are isospectral with the identical value $1.115546702$, yet one has zero defect and the other does not. Two non-conjugate embeddings of a single pair require an outer automorphism, which $\mathfrak{so}(N)$ possesses only at $N=8$ (triality) so the phenomenon is confined to one dimension, below the threshold and below the rival's value. Outstanding: the same closure for the $\mathfrak{su}$ and $\mathfrak{sp}$ families, and the exceptional algebras.

## Phase 2, the clustering

**Reports:** [VERIFY_v143](VERIFY_v143.md), [VERIFY_v144](VERIFY_v144.md), [VERIFY_v145](VERIFY_v145.md), **all three `BROKEN`, unanimous.**

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the pinning formula as a universal statement | **false at reducible isotropy**: at $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ the two ideals carry adjoint Casimirs $2$ and $6$, so no single $c_{\mathfrak k}$ exists, the formula gives $1.130862$ against $\sqrt{56/45}$ | v143, v144, v145 |
| **C2** | the denominator | **$2q-p=0$ on an infinite Pell family**: $ab=\binom n2/3$ forces $(n+1)^2-3s^2=1$, so $n\in\{6,25,96,361,\dots\}$, and the family reaches above the rival maximizer, $\theta^2=912/575$ at $(\mathfrak{so}(25),\mathfrak{so}(20)\oplus\mathfrak{so}(5))$, odd $n=25$ with both blocks $\ge5$ | v144 |
| **C3** | the pole at $\mathbb{CP}^2$ | $2q-p=0$ at the point that **attains** $\sqrt{3/2}$, the rival maximizer itself | v143, v144, v145 |
| **C4** | $\mathbb{CP}^3$ | the formula returns $1.229772$, **above $\sqrt{3/2}$**, where the truth is $\sqrt{10}/3$, *a published sentence producing what would read as a counterexample to Conjecture A* | v145 |
| **C5** | missing hypotheses | four of eight are in no citable form: $\mathfrak k$ simple, $2q>p$, $\mathfrak h$ irreducible, and the embedding index, **"one table lookup" is a fourth input short**, $\mathfrak{so}(m)$ carrying $c_{\mathfrak k}=m-2$ in one pair and $2(m-2)$ in another | v143, v144, v145 |
| **C6** | the label | [results.md](../results.md):17 and :124 say **Lemma**, :367 and the findings block say **Conjecture**, and :124 uses "Conjecture L6"/"Lemma L7" two lines away, so the distinction is deliberate there | v143, v144, v145 |
| **C7** | "finite check" | rests on a classification **[references/](../references/) does not hold**, no Cartan, Helgason, Berger or Besse. Cartan's list is finite in *families*, not pairs, against a target over all $n\ge12$; one exceptional row **cannot be evaluated at all**; the sweeps truncate at $N,m\le40$ | v143, v144, v145 |
| **C8** | "settled across the classical families" | one family named as owed and never closed, unbalanced real Grassmannians checked to $N\le40$, non-simple exceptional pairs screened rather than solved | v143 |
| **C9** | the $\mathbb{CP}^m$ refutation's range | the blockquote says "fails for $m\ge4$"; it fails from $m=2$ | v144 |
| **C10** | "settles the balanced splits only" | **understates what is covered**, an ideal-wise sweep reaches 342 unbalanced pairs, and one verifier reproduced $S^5\times S^7$ from it by hand | v143 |
| **C11** | (R1) | **no derivation on file**, introduced as verified at seven catalogue points, and everything above it inherits that | v144 |
| **C12** | the Lean row | blocks this on "the classification of compact symmetric **spaces**", which the findings file's own correction rules out as the wrong object, **and the proved part needs no classification and is formalisable today** | v144 |

**Withdrawn with reasons:** the $p,q\ge5$ threshold reading, and "reproduces the Ricci-flat Kähler family", which holds for the family it names.

## Phase 3, adjudication

**The elimination is exact and everyone confirmed it.** What is false is its universal quantification: the formula is a *two*-eigenvalue ansatz, and it represents the pair's invariant Weyl operator only when the isotropy's simple ideals are interchangeable.

**C2 is new to the record and is the round.** The poles are not an edge case to be excluded by a footnote, **they are an infinite family, and they include both the rival maximizer and points above it.**

**C4 is the most dangerous single line.** A published sentence that returns $1.229772$ at $\mathbb{CP}^3$ produces what a reader would take for a counterexample to the conjecture the programme is proving.

**The round's brief was itself defective, and this is recorded as a finding against the round.** The extraction filter stripped blockquotes to remove provenance, and lines 429–431 were a Gate-2 blockquote **refuting the paragraph the brief reproduced**. The verifiers found the defect anyway, three times over. *The trap, committed by the round rather than found by it.*

**Impact is not `FATAL`.** The reducible case is covered by the ideal-wise system already on the record (one verifier reproduced $S^5\times S^7$ from it by hand) so what falls is the published sentence rather than the route.

**No adjudication split, and no finding required computation.**

## Phase 4, the fix

**Verdict: `BROKEN`. Impact: `PROPAGATES`**, the elimination survives under its true hypotheses; the universal statement, the label and the finiteness claim were `UNSUPPORTED` at every consumer site.

- **The canonical sentence now carries its three hypotheses**, the three counterexamples, the Pell family, and the ideal-wise system as what covers the reducible case.
- **The landscape line is relabelled Conjecture** and says what the formula does and does not pin.
- **Finiteness is stated as owed**, with the absent classification named and the truncation of the sweeps recorded.
- **The blockquote carries the Pell family, the corrected $\mathbb{CP}^m$ range and the embedding index**, and "balanced splits only" is corrected to what the ideal-wise sweep reaches.
- **The Lean row's obstruction is corrected**, the wrong object was named, and the proved part is formalisable now.
