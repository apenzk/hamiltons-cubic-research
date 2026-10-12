# Review r504, Lemma L8

**Target:** Lemma L8, [findings/graded-half.md](../findings/graded-half.md) at `#### Lemma L8` (line 383), through to the next heading (line 396).
**Reviewer:** r504, cold, adversarial. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts. Two screens were run, both on objects built here for the purpose, and both are labelled as screens below.
**Parallel reviewer:** r503 on the same brief (its log and report deliberately unread).

**VERDICT: REFUTED.**

**The claim judged.** Not the sentence the block itself already retracts, but the one it says survives: *an equivariant graded critical point (the ad(𝔨)-invariant Weyl operator of a symmetric pair (so(n),𝔨)), has θ = (c_𝔨q² + 2q² + p²)/[(2q−p)√(pq(p+q))] with p = dim 𝔨, q = dim 𝔪 and c_𝔨 a tabulated Casimir ratio, so the value follows from three integers and one table lookup.* **That formula is false at every pair whose isotropy ideals are not interchangeable** (including its own worked example, S³×S⁵) and is true only on the balanced sphere splits so(k)⊕so(k). The witness and the mechanism are below.

---

## Phase plan

- P0 setup, done
- P1 read the target block verbatim, done
- P2 [conventions.md](../findings/conventions.md), [INDEX-results.md](../findings/INDEX-results.md), [INDEX.md](../findings/INDEX.md), done
- P3 state precisely what survives the block's own `SCOPE REFUTED` line, done, §1
- P4 sweep the citations, classify each, done, §2
- P5 the label the row is entitled to, done, §3
- P6 audit the surviving mathematics, done, §§4–8
- P7 cross-check against the rest of [findings/](../findings/), done, §9
- P8 verdict, §10

---

## 1. What survives the refutation, in one sentence

**Surviving claim (as I read the block, and as [results.md](../results.md) line 340 already states it):** *for a symmetric pair (so(n), 𝔨) with p = dim 𝔨 and q = dim 𝔪 = dim 𝔨^⊥, the pair's unique ad(𝔨)-invariant (equivariant) Weyl critical point has θ = (c_𝔨q² + 2q² + p²)/[(2q−p)√(pq(p+q))] with c_𝔨 a Casimir ratio read from a table; the compact pairs being classified, the equivariant graded case is a finite check, which the block claims to have run over the classical families.*

**What was refuted, and it is a real refutation.** The original sentence quantified over *every* graded critical point. It fails because "graded" in senses (A) and (B) of [conventions.md](../findings/conventions.md) is far wider than "equivariant": the pair's *slice* V = fix(Λ²σ) has dimension 155 at n=8 on (3,5) and carries many critical points, while the pair's ad(𝔨)-**commutant** in 𝒲_n is one-dimensional and carries exactly one. The block's counterexample lives in the first set and not the second.

**Three corollaries of that, which the block does not draw.**

- In sense **(C)**, [graded-half.md](../findings/graded-half.md) line 248, "W is the ad(𝔭)-invariant Weyl tensor of a symmetric pair", *equivariant and pair-graded are the same condition by definition*. So under the label the labelling table at line 354 assigns L8, "the pinning holds for the equivariant point, not for every graded one" is not a scope refutation at all; it is the observation that (C) ⊊ (A) ∪ (B), which the file already carries. The refutation bites only against a reading of L8 in sense (A) or (B), and line 252 does assign L8 to (B). **The block's `SCOPE REFUTED` banner and the labelling table at line 354 cannot both be right, and the file asserts both.**
- The block's phrase *"a single pair carries a family"* is true in senses (A)/(B) and false in sense (C). The record's own one-dimensional-commutant count ([graded-half.md](../findings/graded-half.md) line 331: three K-invariant symmetric endomorphisms of Λ², Alt and Ric removing 0 and 2, leaving a line) makes the pair-graded point **unique**. The file's own table at line 262 marks the n=8 witness **(C) no, (A) yes**, which is exactly this.
- So the surviving claim is a statement about *one operator per pair*, and it is checkable pair by pair. §4 does that.

---

## 2. The citation sweep, which sites use the surviving claim and which use the refuted one

Grep: `grep -rn --include='*.md' "L8"`, filtered for L80–L89 and for [agent_logs/](../agent_logs/). Sites in the record proper (reviews and my own file excluded except where they are the record's memory of a repair):

| site | what it asserts | status |
| --- | --- | --- |
| [results.md](../results.md) line 124 | "An **equivariant** graded point's value follows from its pair's dimensions and one Casimir ratio" | scope-**safe**; formula broken (§4) |
| [results.md](../results.md) line 340 | canonical statement, explicitly "**equivariant** graded critical point"; carries "pins the pair's equivariant point only" | scope-**safe**; formula broken (§4) |
| [results.md](../results.md) line 366 (L12) | "Lemma L8 settles the equality side **over the equivariant graded points**" | scope-**safe** |
| **[results.md](../results.md) line 530 (L69)** | "the Weyl operator of a compact symmetric space, **the correspondence being Lemma L8**" | **BROKEN, circular and stale.** L8 *assumes* the correspondence; [graded-half.md](../findings/graded-half.md) line 333 says so and line 331 replaced it with an invariant count. results.md was not updated |
| [findings/graded-half.md](../findings/graded-half.md) line 222 | "Lemma L8 does not extend off it" | scope-**safe**, correct |
| [findings/graded-half.md](../findings/graded-half.md) line 248 | (C) bullet, "this is what L8 and L69 are about" | **safe** |
| **[findings/graded-half.md](../findings/graded-half.md) line 252** | (B) bullet, "this is what **Lemma L8** and the C3 route use" | **BROKEN, uncorrected.** Line 354 records this as "the labelling table's own inconsistency … corrected here", but line 252 still reads (B). Two incompatible labels, 100 lines apart, both live |
| [findings/graded-half.md](../findings/graded-half.md) line 333 | "the first version credited this sentence to Lemma L8, **which assumes it**" | **safe**, and correct |
| [findings/graded-half.md](../findings/graded-half.md) line 354 | labelling table, L8 = (C), "its scope is separately refuted" | **safe** |
| **[findings/graded-half.md](../findings/graded-half.md) line 379** | "the correspondence equivariant graded critical point ↔ compact symmetric space; **Lemma L8 supplies it**" | **BROKEN.** L8 assumes it. This sentence sits 46 lines *below* line 333, which says the opposite about the same sentence. The file contradicts itself within one section |
| **[findings/ungraded-slack.md](../findings/ungraded-slack.md) line 285** | "Lemma L8 settles the equality side **across the classical families**" | **BROKEN, unscoped.** This is the same sentence as [results.md](../results.md) line 366, where it reads "over the equivariant graded points". The ungraded-slack.md copy was not updated |
| [findings/INDEX.md](../findings/INDEX.md) line 20 | "Settled only over the EQUIVARIANT graded points … *Candidate, Gate 2 owed*" | **safe**, and the most accurate line in the record |
| **[findings/INDEX-results.md](../findings/INDEX-results.md), row 8** | bare `Lemma`, no Gate-2 annotation | **BROKEN, mislabelled.** §3 |
| [findings/LEDGER.md](../findings/LEDGER.md) lines 266, 485, 489 | bookkeeping; 485/489 flag the circularity | **safe** |
| [reviews/ELIM-canon.md](ELIM-canon.md) line 176 | flags the canon/index conflict | **safe** |

**Five sites broken, and none of them is a use of the pinning formula off the equivariant locus.** That is the important negative result of this sweep: *the scope refutation has already been propagated correctly everywhere it matters.* The live breakage is a different failure, **stale credit for a correspondence L8 assumes** ([results.md](../results.md) line 530, [graded-half.md](../findings/graded-half.md) line 379), **an unscoped copy of a scoped sentence** ([ungraded-slack.md](../findings/ungraded-slack.md) line 285), **a contradictory sense label** ([graded-half.md](../findings/graded-half.md) line 252), and **the index row**.

**And the sweep understates the exposure, because the real defect is in the surviving claim.** Every site above that says "the value follows from its pair's dimensions and one Casimir ratio", [results.md](../results.md) lines 124 and 340, and the block itself, is asserting the formula of §4, which is false at all but one family.

---

## 3. What label the row is entitled to

[INDEX-results.md](../findings/INDEX-results.md) states its convention twice, literally: **"Lemma is proven, Gate 1 and Gate 2 passed."** The L8 block says *"Candidate, Gate 2 owed"*. [INDEX.md](../findings/INDEX.md) line 20 says *"Candidate, Gate 2 owed"*. The row says `Lemma`, bare, with no Gate-2 annotation, the only row among its audited neighbours (5, 7, 9, 10, 11, 12) without one.

**The row should read `Conjecture`, not `Lemma`**, the convention's own third label, "a candidate, with what would settle it", is precisely what the block calls itself. Failing that, `Lemma` with an explicit `Gate 2: SCOPE REFUTED, and the pinning formula is false off the balanced splits (r504)`. On the finding of §4 the honest row is: **the pinning formula is a Lemma on so(k)⊕so(k) and false elsewhere; the finite-check reduction is a valid observation that L8 assumes rather than proves.**

---

## 4. The pinning formula is false at every unbalanced pair, the refutation

This is the load-bearing section.

**Two facts the record supplies.** (i) [Reviewer 317](REVIEW_r317.md) line 79 records the derivation: L8's formula comes from the **two-eigenvalue ansatz** W = (q·Π_𝔨 − p·Π_𝔪)/√(pq(p+q)), scalar on 𝔨 and scalar on 𝔪. That operator is traceless and unit-norm for any (p,q), so the ansatz is self-consistent as an ansatz. (ii) The record now holds the closed form, added at audit,

$$\theta(S^a\times S^b)^2=\frac{2(n-1)(a-1)(b-1)}{(n-2)ab},\qquad n=a+b .$$

**The closed form is sound.** It returns θ₀(n)² = 2(n−1)(n−2)/n² at a = b ([conventions.md](../findings/conventions.md)), and it reproduces every recorded value exactly: 1.115546702 at (3,5), 1.145643924 at (4,4), 1.236033081 at (6,6), 1.228239158 at (5,7), 1.141798451 at (3,9), and the four n=12 rationals 176/135, 231/160, 264/175, 55/36 verbatim. It also independently confirms [Lemma L69](../findings/graded-half.md)'s threshold arithmetic: no split with a factor ≤ 4 ever reaches 3/2, and p = 5 first clears it at n = 12.

**The argument.** Fix a pair. The formula asserts θ = N/D with

- N = (c_𝔨 + 2)q² + p², **rational**, since c_𝔨 is a tabulated Casimir ratio, and Casimir ratios in the record's normalisation ([conventions.md](../findings/conventions.md): Σ_b‖[a,b]‖² = c‖a‖², giving c = 2(k−2) for so(k)) are rational;
- D = (2q − p)·√(pq(p+q)), with p, q, p+q integers.

So **the formula can hold only if θ·√(pq(p+q)) is rational.** Evaluate at the block's own headline pair, (so(8), so(3)⊕so(5)), where p = 13, q = 15, p+q = 28:

θ = √(56/45) = 2√70/15, D = 17√5460 = 34√1365, so N = θD = (68/15)√95550 = **(476/3)·√78 ≈ 1401.36**, which is irrational.

**No rational c_𝔨 exists. The formula fails at S³×S⁵.**

**Screen** (seconds, on rationals I constructed for the purpose; reported as a screen, not as evidence for a positive claim). Testing whether N² is a perfect rational square for each pair:

| pair | dim 𝔨, dim 𝔪 | θ² | N rational? | required c_𝔨 |
| --- | --- | --- | --- | --- |
| S³×S³ | 6, 9 |, | **yes** | **2.000000** = 2(3−2) |
| S⁴×S⁴ | 12, 16 | 21/16 | **yes** | **4.000000** = 2(4−2) |
| S⁵×S⁵ | 20, 25 | 36/25 | **yes** | **6.000000** = 2(5−2) |
| S⁶×S⁶ | 30, 36 | 55/36 | **yes** | **8.000000** = 2(6−2) |
| S⁷×S⁷ | 42, 49 | 78/49 | **yes** | **10.000000** = 2(7−2) |
| S³×S⁵ | 13, 15 | 56/45 | **no** | 3.476916 |
| S³×S⁷ | 24, 21 | 9/7 | **no** | 3.663796 |
| S⁴×S⁶ | 21, 24 | 45/32 | **no** | 5.605698 |
| S³×S⁹ | 39, 27 | 176/135 | **no** | 2.107126 |
| S⁴×S⁸ | 34, 32 | 231/160 | **no** | 6.304178 |
| S⁵×S⁷ | 31, 35 | 264/175 | **no** | 7.679524 |
| S²×S⁶ | 16, 12 | 35/36 | **no** | 0.238649 |
| ℂP³ | 9, 6 | 10/9 | yes | **−1.750000**, negative, impossible for a Casimir |
| ℂP⁴ | 16, 12 | 35/36 | **no** | 0.238649 |
| ℂP⁵ | 25, 20 | 9/10 | **no** | 1.773844 |
| ℂP⁶ | 36, 30 | 77/90 | **no** | 3.145317 |

**The formula is exact on the balanced sphere splits and nowhere else in the classification.** On those it is exact with c_𝔨 = 2(k−2), the ambient Killing constant of [conventions.md](../findings/conventions.md), which is what makes it look like a theorem.

**Root cause, and it is structural rather than a slip.** The ansatz asks W to be scalar on all of 𝔨. For 𝔨 = so(a) ⊕ so(b) with a ≠ b, the ad(𝔨)-commutant on Λ² is **three**-dimensional (a scalar on each of so(a), so(b), 𝔪 = ℝ^a⊗ℝ^b), and the two Ricci conditions cut it to a line, the record's own count at [graded-half.md](../findings/graded-half.md) line 331, but that line has **different** scalars on the two ideals. Only when a = b does the swap symmetry of the pair force them equal, collapsing three eigenvalues to two. Same for 𝔨 = u(m) = u(1) ⊕ su(m): two ideals, three eigenvalues, ansatz false, which is what the ℂP^m rows show.

**Screen, confirming it directly.** Building the Weyl operators of the round product metrics from the Kulkarni–Nomizu decomposition and reading their Λ² spectra (all traces of W vanish to 3×10⁻¹⁶):

| point | Λ² spectrum, unit norm | ‖A‖² on E₊ |
| --- | --- | --- |
| **S³×S⁵** | **0.398410** (×3, so(3)), **0.119523** (×10, so(5)), −0.159364 (×15, 𝔪), **three values** | 0.619048 = 13/21 |
| **S⁴×S⁴** | 0.218218 (×12), −0.163663 (×16), **two values**, and exactly (q,−p)/√(pq(p+q)) = (1/√21, −3/(4√21)) | 0.571429 = 12/21 |
| **S⁵×S⁷** | 0.195402 (×10), 0.093048 (×21), −0.111658 (×35), **three values** | 0.563636 = 31/55 |

The ‖A‖² column reproduces the record's own dim𝔨/C(n−1,2) at all three, so the construction is the record's object. The ansatz's ‖A‖² would be dim𝔪/C(n,2), 15/28 at (3,5) against the true 13/21, and 35/66 at (5,7) against 31/55; the two agree exactly when a = b and disagree otherwise.

**The block's own sentence is the casualty.** *"It reproduces the Ricci-flat Kähler family and the sphere pairs identically"* is false on both counts: it reproduces the ℂP^m family at no m ≥ 3, and it reproduces only the balanced sphere pairs. *"So the value follows from three integers and one table lookup"* is false wherever the isotropy has two inequivalent ideals, which is every pair in the classification except so(k)⊕so(k).

*Robustness of the reading.* I checked the alternative reading in which p, q are the sphere dimensions rather than dim 𝔨, dim 𝔪: it fails rationality even at S⁴×S⁴ (D = 32√2, θD = 8√42), so the dim𝔨/dim𝔪 reading, which [results.md](../results.md) line 340 and the block both state explicitly, is the only one under which anything works, and it is the one refuted.

*One thing I did not manage.* I tried to recompute θ from the constructed operators via Q(W) = W² + W^# as a fourth independent check on the closed form; my W^# normalisation is wrong (the ratios to the closed form are not constant across pairs), so **that computation is discarded and is not used anywhere above**. The closed form rests on its six exact matches against recorded values and on θ₀(n)² at balance.

---

## 5. "Since the compact symmetric pairs are classified, the graded case is then a finite check", L8 ASSUMES the reduction

**The reduction is not this result's own claim.** [results.md](../results.md) line 340 states the lemma as *"An equivariant graded critical point (**the Weyl operator of a compact symmetric pair** (so(n),𝔨) …), is pinned by …"*. The correspondence is a **hypothesis in the statement**, not a conclusion. The block derives a value *given* a pair; it never shows that being a graded critical point produces one.

**Stated explicitly, since [Lemma L69](../findings/graded-half.md) was relying on L8 for it: L8 assumes "equivariant graded point ⇒ Weyl operator of a compact symmetric pair" and proves nothing about it.** I reach this independently and it agrees with [r501](REVIEW_r501.md), [r502](REVIEW_r502.md), [r313](REVIEW_r313.md) and [r314](REVIEW_r314.md).

**L69's dependency is repaired; two citations of it are not.** [graded-half.md](../findings/graded-half.md) line 331 replaces the appeal with an invariant count that needs no classification, at every ℤ₂-grading of so(n) the K-invariant symmetric endomorphisms of Λ² form a 3-space, Alt and Ric remove 0 and 2, leaving one line; the count runs 4−1−2 at p = 4 and 3−1−1 at u(m). That is a real proof and it is better than what it replaced. But [results.md](../results.md) line 530 and [graded-half.md](../findings/graded-half.md) line 379 still credit L8 (§2).

**Separately, the reduction is finite for a reason L8 does not state.** The finite list that matters is the ℤ₂-**gradings of so(n)** (so(p)⊕so(q), u(n/2), plus spin(7) and sp(1)⊕sp(2) at n = 8) which the same file tabulates at lines 364–373. L8's own family list (Ricci-flat Kähler, SO(2m)/U(m), the complex Grassmannians, sp and su families, Wolf spaces) is a list of symmetric **spaces**. **Correction 5, 25 lines below the block, says that is the wrong enumeration**: *"Graded critical points here are indexed by symmetric pairs (𝔥,𝔨) with 𝔥 ⊆ so(n); Petersen–Stanfield classify symmetric spaces … so their tables do not enumerate what needs enumerating."* So the block runs its finite check over a list its own Gate 2 declares unfit for the purpose.

---

## 6. "running it over the classical families settles it there", what *there* covers

| family | in the block | status |
| --- | --- | --- |
| so(p)⊕so(q), sphere products | claimed to exceed the rival maximizer and be defect-free | value claim **false** (§7); defect claim **correct** (§7) |
| u(m) / ℂP^m | named as "SO(2m)/U(m)" and "the Ricci-flat Kähler family" | **misnamed.** Correction 2, 28 lines below in the same file: *"the Hermitian family is ℂP^m, not SO(2m)/U(m), and it is prior art."* The block was not updated. Values are correct, via [Lemma L10](../findings/graded-half.md)'s closed form |
| complex Grassmannians | "genuinely defective but below the rival maximizer" | plausible; and Correction 3 finds Gr_ℂ(2,2) and Gr_ℂ(2,3) **ungraded** (S = 0.5714, 0.9631), so they are not in the graded enumeration at all |
| (sp(2j), sp(j)⊕sp(j)), (su(2k), sp(k)) | "carry **no** graded critical point at all" | these are not subalgebras of so(n); they are pairs of other algebras. Under the ℤ₂-grading enumeration the question does not arise, so the claim is either vacuous or about the wrong list |
| **spin(7) ⊂ so(8)** | **absent** | added to the enumeration at line 372 of the same file; line 450 gives it a **zero**-dimensional invariant Weyl space, so it contributes nothing. Handled, but not by L8 |
| **sp(1)⊕sp(2) ⊂ so(8)**, i.e. ℍP² = τ(S³×S⁵) | **absent** | line 373; θ = 1.115547 with **nonzero** defect δ² = 0.031746, graded per Correction 3. It is a graded critical point in a classical dimension that the block's own "settled across the classical families" does not reach |
| exceptional algebras | *"Outstanding"*, the block's last sentence | **the title says "settled", the last sentence says outstanding.** Under the correct so(n)-grading enumeration there is nothing exceptional beyond n = 8; under the symmetric-space framing the block actually uses, the gap is real |

**So *there* means: the balanced sphere splits, where the formula holds, plus values imported from [Lemma L10](../findings/graded-half.md) and elsewhere.** A finite check whose own closing sentence lists outstanding cases is not a finite check, and the heading "settled across the classical families" overstates the block by the width of that list.

---

## 7. The two sphere-product claims

**Claim A, "Sphere products, balanced and unbalanced alike, exceed the rival maximizer's value." FALSE, and the closed form settles it outright.**

The rival maximizer is the ℂP²-type competitor at θ = √(3/2), θ² = 3/2 ([Lemma L10](../findings/graded-half.md): the ℂP^m closed form is exactly 3/2 at m = 2). Substituting into θ(S^a×S^b)² = 2(n−1)(a−1)(b−1)/((n−2)ab):

| n | splits, θ², and whether > 3/2 |
| --- | --- |
| 8 | (2,6) 0.9722 ✗ · (3,5) 1.2444 ✗ · (4,4) 1.3125 ✗, **none** |
| 10 | (2,8) 0.9844 ✗ · (3,7) 1.2857 ✗ · (4,6) 1.4062 ✗ · (5,5) 1.4400 ✗, **none** |
| 12 | (3,9) 1.3037 ✗ · (4,8) 1.4438 ✗ · **(5,7) 1.5086 ✓ · (6,6) 1.5278 ✓** |
| 14 | (3,11) 1.3131 ✗ · (4,10) 1.4625 ✗ · (5,9) ✓ · (6,8) ✓ · (7,7) ✓ |

Balanced sphere products exceed √(3/2) iff n² − 12n + 8 > 0, i.e. **n ≥ 12**; and a factor of 4 never suffices at any n, since 2(n−1)(3)(q−1)/((n−2)·4q) → 3/2 strictly from below. **So the claim is false at every n ≤ 10 and false for two of the four splits at n = 12**, by the record's own values (1.115547, 1.141798, 176/135, 231/160), all of which sit below the rival maximizer.

*This is not a nitpick*: the block's next sentence is *"Everything else either falls below or does not exist"*, so the two sentences together assert a clean separation at √(3/2) with sphere products above it. There is no such separation. What is true is the block's **final** sentence (*"every graded critical point above the rival maximizer is a sphere product"*) which is the containment in the other direction and is what [Lemma L69](../findings/graded-half.md) actually proves. The record's canon at [results.md](../results.md) line 124 already states only the true direction; the block does not.

**Claim B, "provably defect-free for every dimension and every split." CORRECT, and the block's one-line reason is repairable to a proof.**

At a sphere product, E₊ = 𝔨 = so(a) ⊕ so(b) and W|_{E₊} = λ₁Π₁ + λ₂Π₂ with Π_i the projection onto Λ²ℝ^{a}, Λ²ℝ^{b}. Each Π_i, read as a 4-tensor, is (δ_{ik}δ_{jl} − δ_{il}δ_{jk}) on its block and zero elsewhere (the constant-curvature tensor of the subspace, extended by zero) and it satisfies the first Bianchi identity (all-in-block indices give the constant-curvature identity; any mixed index kills all three terms). By [conventions.md](../findings/conventions.md), *"Alt(H) = 0 for every H satisfying the first Bianchi identity"*, so Alt(Π_i) = 0 and hence Alt(W|_{E₊}) = 0 **for every a, b, every n, by linearity, with no computation**. The block's phrasing (*"the projection onto 𝔪 is a sum over decomposable bivectors whose 4-form parts vanish"*), is loose (the object is the projection onto 𝔨, not 𝔪, and "sum over decomposable bivectors" is not the reason) but the conclusion is right.

**And it is sharp in the right place**: ℍP² = τ(S³×S⁵) has 𝔨 = sp(1)⊕sp(2) acting irreducibly, which is not a Λ²V, so Alt(Π_𝔨) ≠ 0, matching the recorded δ² = 0.031746 and the file's note that *"Alt is not triality-invariant"*. The two facts corroborate each other exactly.

---

## 8. The counterexample

**What is genuinely established.** The witness is real and heavily corroborated elsewhere in the record: [r307](REVIEW_r307.md)'s census of 18 graded critical points at n = 8, [r313](REVIEW_r313.md), [r314](REVIEW_r314.md), and the criticality residual 2.9×10⁻¹⁵ recorded at [graded-half.md](../findings/graded-half.md) line ~215. Its bracket inclusions to 10⁻²⁹, trivial kernel and Δ = 1.512231 make it sign-graded (sense (A)) and not equivariant. **That is all the refutation needs, and it holds.**

**What is asserted rather than shown, and it matters.** *"Its isotropy algebra has the identical Killing spectrum −3.0^{×10} ⊕ −1.0^{×3}, difference exactly 0, **so it is the same pair** and not a coincidence of dimensions."* The spectrum is consistent with so(3)⊕so(5) (ratio 3:1 = c(so(5)):c(so(3)) = 6:2), so it fixes the **isomorphism class**. It does not fix the **conjugacy class of the embedding in so(8)**, and the block itself argues, two paragraphs later, that at exactly n = 8 those come apart:

> *"Two non-conjugate embeddings of a single pair require an outer automorphism, which so(N) possesses only at N = 8, triality."*

S³×S⁵ and ℍP² are the block's own example of two isospectral, equal-θ objects on one abstract pair with different defects. **So the inference "identical Killing spectrum ⇒ the same pair" is invalid at the one dimension where it is applied**, by the block's own argument thirty lines below it.

**The refutation survives the objection.** Even if the embedding is non-conjugate, the Killing spectrum is unchanged, so p, q and c_𝔨 are unchanged, so the pinning formula predicts the same value for both, and the witness sits at 1.088948 against 1.115547. The counterexample stands; only its stated justification is unsound. Two things in it remain asserted and unverifiable from the record's notes: the value 1.088948, and the claim of five distinct positive eigenvalues.

**One thing the counterexample is not.** It is not a *second pair-graded* point. Sense (C) admits exactly one per pair, by the one-dimensional commutant. The block's *"drop equivariance and a single pair carries a family"* is a statement about the pair's **slice**, dimension 155 at n = 8 on (3,5), and should say so.

---

## 9. What the record already knows, and one contradiction it does not

**Already reconciled:** [INDEX.md](../findings/INDEX.md) line 20 carries the scope correctly; [graded-half.md](../findings/graded-half.md) line 222 records "L8 does not extend off it"; lines 331–333 repair L69's dependency; line 354 fixes the sense label; [ELIM-canon.md](ELIM-canon.md) line 176 flags the canon/index conflict; [ELIM-halves.md](ELIM-halves.md) line 174 already flags the p,q overload (§ below).

**Not reconciled, and this is a live contradiction inside one file.** [graded-half.md](../findings/graded-half.md) line 450, sixty-seven lines below the block:

> *"So a graded critical point is not merely associated with a symmetric pair; **it is the unique invariant operator of that pair, with no room for a second point to hide.**"*

That sentence asserts *graded ⇒ invariant*, which is precisely what the L8 block's counterexample refutes. Read in sense (C) it is a tautology; read in sense (A) or (B) (which is how "graded critical point" is used everywhere else in that section), it is **false, by the witness in the block above it**. It needs the scope word "equivariant", or "of the subalgebra family", inserted.

**Symbol collision, live in the block.** p and q mean dim 𝔨 and dim 𝔪 in L8's formula and the sphere dimensions in the closed form θ(S^p×S^q)², at (3,5) they read 13, 15 and 3, 5 in adjacent paragraphs of the same file. [ELIM-halves.md](ELIM-halves.md) E5 already flagged this; it is still there, and [conventions.md](../findings/conventions.md) shows this class of collision (B, M, μ) has cost this programme cycles.

---

## 10. Verdict

**REFUTED.**

**Judged: the surviving claim**, the pinning of an *equivariant* graded critical point's θ by (dim 𝔨, dim 𝔪) and one tabulated Casimir ratio, and the finite check said to follow.

**Broken step:** the two-eigenvalue ansatz W = (qΠ_𝔨 − pΠ_𝔪)/√(pq(p+q)) from which the formula is derived. It is the pair's invariant Weyl operator only when the isotropy's simple ideals are interchanged by a symmetry of the pair.

**Witness:** (so(8), so(3)⊕so(5)), the block's own headline pair. Its equivariant point S³×S⁵ has **three** Λ² eigenvalues 0.398410 / 0.119523 / −0.159364, not two; θ·√(pq(p+q)) = (476/3)√78 is irrational, so no rational Casimir ratio satisfies the formula; and ‖A‖² = 13/21 against the ansatz's 15/28. Same failure at S³×S⁷, S⁴×S⁶, S⁵×S⁷, S³×S⁹, S⁴×S⁸, S²×S⁶ and at ℂP^m for every m ≥ 4, with ℂP³ requiring c_𝔨 = −7/4 < 0.

**Second, independent refutation, in the same block:** *"Sphere products, balanced and unbalanced alike, exceed the rival maximizer's value"* is false at every n ≤ 10 and at the (3,9) and (4,8) splits of n = 12, by the record's own recorded values.

**What survives and should be kept.**

1. The formula, exactly, on the **balanced** splits (so(k), so(k)⊕so(k)) with c_𝔨 = 2(k−2), verified at k = 3…7.
2. **Defect-freeness of every sphere product at every n and every split** (§7B), now with a proof rather than a measurement.
3. The block's **final** sentence, *"every graded critical point above the rival maximizer is a sphere product"*, which is [Lemma L69](../findings/graded-half.md)'s content and is proved there, independently of L8.
4. The finite-check **reduction** as an assumed hypothesis, correctly credited: the proof of it is at [graded-half.md](../findings/graded-half.md) line 331, not here.

**Six repairs the record owes.**

1. [INDEX-results.md](../findings/INDEX-results.md) row 8: `Lemma` → `Conjecture`, or `Lemma` with the Gate-2 verdict attached (§3).
2. [results.md](../results.md) line 530 and [graded-half.md](../findings/graded-half.md) line 379: drop the credit to L8 for the correspondence; point at [graded-half.md](../findings/graded-half.md) line 331 (§2, §5).
3. [ungraded-slack.md](../findings/ungraded-slack.md) line 285: "across the classical families" → "over the equivariant graded points", matching [results.md](../results.md) line 366 (§2).
4. [graded-half.md](../findings/graded-half.md) line 252: remove L8 from the (B) bullet; line 354 already says (C) (§2).
5. [graded-half.md](../findings/graded-half.md) line 450: scope "a graded critical point … is the unique invariant operator of that pair" to equivariant points (§9).
6. The block itself: restrict the pinning formula to balanced splits, delete *"reproduces … the sphere pairs identically"*, delete *"balanced and unbalanced alike, exceed the rival maximizer's value"*, replace "SO(2m)/U(m)" per Correction 2, and rename "the same pair carries a family" to "the pair's slice carries a family" (§§4, 6, 7, 8).

**Screens declared.** Two, both on objects built here for the purpose, both seconds of compute, neither used as evidence for a positive claim: (i) exact-rational testing of whether θ·√(pq(p+q)) is rational across sixteen pairs, and (ii) Kulkarni–Nomizu construction of the sphere-product Weyl operators to read their Λ² spectra. A third computation (recomputing θ via Q(W) = W² + W^#), was attempted, came out wrong on the W^# normalisation, and is discarded and unused.
