### Reviewer 326: the deficiency LPs, post F41's marginal relaxation and the "diagonal criticality" sharpness table

**Brief.** Audit four claims built on [Lemma L70](../findings/bounds.md) (itself out of scope, taken as given): I1 [post F41](../findings/fence-posts.md)'s marginal LP; I2 criticality in bracket coordinates; I3 the sharpness table; I4 whether that sharpness is informative. Lead with I4.

**Method.** Everything below is built from the definitions in a fresh module under [scripts/reviewers/r326/](../scripts/reviewers/r326/), [core.py](../scripts/reviewers/r326/core.py) (so(n) structure constants, `#`, `Q`, the 4-tensor, Bianchi/Ricci screens), [weyl.py](../scripts/reviewers/r326/weyl.py) (an explicit orthonormal basis of Weyl_n by nullspace), [points.py](../scripts/reviewers/r326/points.py) (the catalogue), [diaglp.py](../scripts/reviewers/r326/diaglp.py), [marglp.py](../scripts/reviewers/r326/marglp.py), [ablate.py](../scripts/reviewers/r326/ablate.py). No record script was read or run. Validation before any claim: dim Weyl_n = 84, 300, 1638 at n = 6, 8, 12 against n(n+1)(n+2)(n−3)/12; sup‖[v,φ]‖² = 2.000000000 at n = 4, 6, 8, 10; Σ_ab c²_vab = 2(n−2) for random unit v; tr(W#) = −tr(W²) to 6·10⁻¹⁶; Q maps Weyl_n into Weyl_n (Bianchi and Ricci residuals ≤ 5·10⁻¹⁶). The convention that reproduces the record is so(n) ≅ Λ²ℝⁿ with e_i∧e_j orthonormal, i.e. ⟨A,B⟩ = tr(AᵀB)/2; in it c² = 1 on triangles. Independently reconstructed θ at every catalogued point, matching the record: balanced products θ₀(n) at n = 6, 8, 10, 12; tori 0.645497, 0.540062, 0.474342, 0.428174; ad(su(3)) 0.836660; padded W_CP² 1.224744871; S³×S⁵ 1.115547; S⁵×S⁷ 1.228239; CP² 1.224745, CP³ 1.054093, CP⁴ 0.986013, CP⁵ 0.948683; C₅ blow-up 0.670820393. Criticality residuals ≤ 5.3·10⁻¹⁶ at all of them (9.1·10⁻¹⁰ at the C₅ blow-up, which was found by optimisation). Log: [agent_logs/r326-lp-sharpness.log](../agent_logs/r326-lp-sharpness.log).

---

## I4, is the sharpness informative? **REFUTED.** The reading is not justified.

**Verdict in one line: the table shows that a known critical point satisfies its own constraints, and the one bound doing the work is Lemma L70's, already recorded as saturated at exactly those points.** The record's own diagnosis is the correct one, and it has been made twice this week.

**(1) The LP maximum at the balanced spectrum is Lemma L70's bound, in closed form.** Drop the total symmetry of T and keep the rows independent. Row k then reads: T_{k··} ≥ 0 with mass n−2 and Σ λ_αλ_β T_{kαβ} = λ_k(θ−λ_k), so θ ranges over an interval with endpoints λ_k + (n−2)·(extreme product)/λ_k. For the λ_min row the extreme product is λ_min λ_max, and the upper endpoint is

  λ_min + (n−2)·λ_min λ_max / λ_min = **λ_min + (n−2) λ_max**,

which is the [Lemma L70](../findings/bounds.md) bound verbatim. Numerically the decoupled cap equals the full LP maximum at every balanced spectrum: 1.054092553, 1.145643924, 1.200000000, 1.236033081 at n = 6, 8, 10, 12, and λ_min + (n−2)λ_max returns the same nine digits. The record already carries this as "exact equality at every balanced sphere product, slack 0.000000000 at n=6,8,10,12". **The table re-measures a slack the record measured as zero.**

**(2) Ablation: two of the 2N constraints do all the work.** Keeping only the λ_min row's pair (mass n−2 and the pinned value), reproduces the full LP maximum exactly:

| n | full LP max | λ_min row alone | λ_max row alone | θ₀(n) |
|---|---|---|---|---|
| 6 | 1.054092553 | **1.054092553** | 1.581138830 | 1.054092553 |
| 8 | 1.145643924 | **1.145643924** | 1.527525232 | 1.145643924 |
| 10 | 1.200000000 | **1.200000000** | 1.500000000 | 1.200000000 |

So the record's "N constraints where the record used one" contribute nothing at the point where the table is computed. That single surviving pair *is* the ingredient list of Lemma L70, one v ∈ E_min, its bracket mass, and (W#)_{vv} = θλ_min − λ_min².

**(3) The maximum is exactly θ₀, and the proof is two lines, not nine digits.** For a two-eigenvalue traceless unit spectrum, tracelessness forces the values from the multiplicities: λ_max = √((N−r)/(rN)) with multiplicity r, λ_min = −√(r/(N(N−r))). At the balanced split r = n(n−2)/4, N−r = n²/4, m = n/2, this gives λ_min + (n−2)λ_max = √((m−1)(2m−1))/m = θ₀(n) identically. Together with the fact that the point's own T is feasible (verified: (A) to 2.7·10⁻¹⁵, (B) to 1.1·10⁻¹⁶, total symmetry to machine zero, vanishing on repeats), LP max = θ₀ exactly. **Both halves are prior record content, the cap is Lemma L70's saturation, the attainment is criticality at a known critical point.**

**(4) The relaxation is lossy at genuine critical points at n = 12, "not lossy at the extremum" does not survive one step past the extremum.** Every row below is a bona fide element of Weyl₁₂ (Bianchi and Ricci residual 0) and a bona fide critical point:

| point (n = 12) | criticality residual | true θ | diagonal LP | LP / θ | LP / θ₀(12) |
|---|---|---|---|---|---|
| balanced S⁶×S⁶ | 2.3·10⁻¹⁶ | 1.236033 | 1.236033 | 1.00 | 1.000 |
| padded W_CP² | 5.2·10⁻¹⁶ | 1.224745 | 1.224745 | 1.00 | 0.991 |
| **padded S³×S³ ⊂ Weyl₁₂** | 2.2·10⁻¹⁶ | **1.054093** | **2.393410** | **2.27** | **1.936** |
| **W_CP² ⊕ W_CP² ⊕ W_CP²** | 1.4·10⁻¹⁶ | **0.707107** | **2.862099** | **4.05** | **2.316** |
| C₅ blow-up (n = 10) | 9.1·10⁻¹⁰ | 0.670820 | 1.192570 | 1.78 | 0.994 |

The padding construction is legitimate: a Weyl tensor supported on Λ²ℝᵏ ⊂ Λ²ℝⁿ stays Ricci-flat and Bianchi, and [so(k),so(k)] ⊆ so(k) keeps W# in the same block, so criticality and θ transfer unchanged. **The relaxation overshoots a genuine critical point's θ by a factor of 4.05.**

**(5) The remaining maximisation over spectra ceilings far above θ₀(12), including over admissible spectra.** At spectra of twelve genuine random Weyl₁₂ tensors the LP returns 1.338–1.360, i.e. **1.08–1.10 × θ₀(12)**. Over the three-value family (a with multiplicity r, 0 with multiplicity z, b with multiplicity s; traceless, unit) it reaches **3.674235 = 2.97 × θ₀(12)** at r = s = 3, with 3.643, 3.292, 3.182 nearby. For reference, [post F10](../findings/fence-posts.md)'s marginal LP ceilings at 1.6059 against θ₀(6) = 1.0541, a ratio of 1.52. **The new relaxation's ratio is worse, not better.**

**(6) (b) of the brief, the tightness is a fact about the multiplicities, and "the same two values at different multiplicities" cannot be tested because it cannot exist.** Tracelessness plus unit norm makes a two-value spectrum a function of the multiplicity split alone, so the test as posed is empty. The available form of it is the sweep over r at n = 12 (N = 66):

| r = mult(λ_max) | 3 | 6 (torus) | 10 | 15 | 20 | 24 | **30 (balanced)** | 40 | 50 | 60 |
|---|---|---|---|---|---|---|---|---|---|---|
| LP max | infeasible | 0.428174 | 0.572172 | 0.734313 | 0.892805 | 1.023533 | **1.236033** | 0.293902 | −0.134040 | −0.428174 |

The peak sits exactly at r = 30 = n(n−2)/4 with value exactly θ₀(12). That is a real property of the two-value family and it is worth one sentence, but the LP sees only the spectrum, so it is a statement about multiplicities and carries no criticality content beyond the pinned values, and it collapses the moment three values are allowed (item 5).

**(7) So the record's reading fails on its own stated test.** The record writes that the table shows the diagonal relations "sharp on the equality family, which is exactly the property post F34 closes routes for lacking". Post F34's actual demand is "a bound … that is *not* a rearrangement of θ, that is sharp to O(n⁻²) uniformly, and whose worst case is the extremal family rather than the interior". This relaxation fails the third clause outright, its worst case is 4.05× at a padded critical point and 2.97 × θ₀ over spectra, i.e. the loss is entirely in the interior. And [bounds.md](../findings/bounds.md) already carries the rule that settles it: *"evaluate a proposed bound at the conjectured extremiser before adopting it, and if it is tight there it is the original problem."* **What the table records is that the balanced product's own T is feasible and attains θ₀, with the cap supplied by a bound the record has already recorded as saturated there. It is a definition restated, and it is the third such this week.**

---

## I3, the sharpness table. **CONFIRMED as arithmetic; the framing is I4's problem.**

Reproduced independently, with my own triple-indexed LP (variables = C(N,3), which is what 455/3276/14190/45760 are):

| n | variables | LP max | record | LP min | record | θ₀(n) |
|---|---|---|---|---|---|---|
| 6 | 455 | 1.054092553 | 1.054092553 | 0.175682092 | 0.175682092 | 1.054092553 |
| 8 | 3276 | 1.145643924 | 1.145643924 | −0.190940654 | −0.190940654 | 1.145643924 |
| 10 | 14190 | 1.200000000 | 1.200000000 | −0.420000000 | −0.420000000 | 1.200000000 |
| 12 | 45760 | 1.236033081 | 1.236033081 | −0.576815438 | −0.576815438 | 1.236033081 |

Answers to the brief's sub-questions:

- **Exactly θ₀, not close.** Proved in I4(3); the nine digits are an algebraic identity.
- **Feasibility is for the right reason.** The true T of the balanced product satisfies (A) to 2.7·10⁻¹⁵ and (B) to 1.1·10⁻¹⁶, is totally symmetric to machine zero and vanishes on repeated indices.
- **Correctly posed and bounded.** θ enters linearly, so this is an LP. It is bounded because T ≥ 0 with row mass n−2 bounds every Σ λ_αλ_β T_{kαβ}, and any row with λ_k ≠ 0 then confines θ to a compact interval. Dropping the pinned values (B) makes it unbounded (scipy/HiGHS returns status 3) which is the expected behaviour and confirms the bound comes from (B).
- **Which constraint does the work:** the λ_min row's pair, alone. See the ablation table.

---

## I2, criticality in bracket coordinates. **REFUTED AS STATED**, with the repair below.

The record states: "criticality is equivalent to M_kl = 2λ_k(λ_k−θ)δ_kl, i.e. Σ_αβ λ_α λ_β c_{kαβ} c_{lαβ} = 0 whenever λ_k ≠ λ_l". The first form is right; the "i.e." is false; the restriction is wrong; and the supporting numerics screened a population that structurally excludes the counterexamples.

**The matrix form is exactly criticality, confirmed.** M_kl = tr(ad(φ_k) W ad(φ_l) W) = −Σ_αβ λ_αλ_β c_{kαβ}c_{lαβ} = −2(W#)_{kl}, an identity on all of Weyl_n. So M_kl = 2λ_k(λ_k−θ)δ_kl ⟺ W# = θW − W² ⟺ Q(W) = θW. Nothing is lost and nothing is gained; the record's self-assessment ("a change of language, not new information") is correct for this form.

**The bracket form is strictly weaker, refuted by an explicit family.** Σ_αβ λ_αλ_β c_{kαβ}c_{lαβ} = 0 for k ≠ l says only that W# has no matrix element between distinct eigenspaces of W: it is [W, W#] = 0, equivalently [W, Q(W)] = 0. The counterexample family is the record's own diagonal locus. For W = diag(M_ab) the bracket data is supported on triangles, and the triangle {a,b,x} forces the third index back to (ab), so W# is **exactly** diagonal, off-diagonal 0.000·10⁰, structurally, not numerically. Measured at random diagonal Weyl tensors:

| n | Bianchi | Ricci | min eigenvalue gap | max ‖W# off-diagonal‖ | criticality residual |
|---|---|---|---|---|---|
| 6 | 0 | 2·10⁻¹⁶ | 1.0·10⁻³ | **0.000·10⁰** | **0.562** |
| 6 | 0 | 1·10⁻¹⁶ | 2.5·10⁻⁴ | **0.000·10⁰** | **0.469** |
| 8 | 0 | 2·10⁻¹⁶ | 4.8·10⁻⁴ | **0.000·10⁰** | **0.505** |
| 8 | 0 | 1·10⁻¹⁶ | 2.7·10⁻⁴ | **0.000·10⁰** | **0.530** |

The spectra are non-degenerate, so the eigenbasis is unique up to signs and the relations hold in the record's stated form with nothing vacuous. These are genuine Weyl tensors: an n(n−3)/2-dimensional family (9 of 84 at n = 6, 20 of 300 at n = 8), satisfying every relation the record calls equivalent to criticality, while missing criticality by 0.39 to 0.59. **The record's sentence "the relations are consequences of criticality and of nothing weaker" is false.**

**Why the record's screen missed it.** The verification population was random Weyl tensors, where the off-diagonal residual is 3·10⁻² to 1·10⁻¹ (I measure 7.6·10⁻² at n = 6 and 3.4·10⁻² at n = 8, consistent with the reported 1.1·10⁻¹). Random Weyl tensors are never diagonal, so the screen could not meet the counterexample. The diagonal locus is [the record's own principal study object](../findings/diagonal-half.md).

**The "λ_k ≠ λ_l" restriction is wrong, and the record's own count says so.** Criticality gives W#|_{E_λ} = (θλ − λ²)·I, so the off-diagonal entries vanish for **all** k ≠ l, degenerate pairs included, and basis-independently (the brief's question "the record asserts nothing there), is that right?" answers no. The record simultaneously calls the family "N(N−1)/2 scalar relations", which is the count of all k < l, not of the pairs with λ_k ≠ λ_l. The two statements in the same sentence do not agree.

**One further correction to what the form "buys".** The record says the gain is that "criticality and D are now expressed in the same variables c_{kαβ}". They are not. D and the diagonal relations are functions of T = c², whereas the off-diagonal relations involve the *signed* products c_{kαβ}c_{lαβ}, which are not functions of T. That matters directly, because the record designates the off-diagonal half as "the untouched reserve" and "the only place the Jacobi identity can enter a bound on D", the reserve lives in different variables from the quantity it is meant to bound.

**Repair.** State it as: criticality ⟺ (W#)_{kl} = (θλ_k − λ_k²)δ_kl in any orthonormal eigenbasis, which splits as N diagonal relations Σ_{α<β} λ_αλ_β T_{kαβ} = λ_k(θ − λ_k) **and** N(N−1)/2 off-diagonal relations Σ_{αβ} λ_αλ_β c_{kαβ}c_{lαβ} = 0 for all k ≠ l. Neither half alone is criticality: the off-diagonal half alone is [W, Q(W)] = 0 and is satisfied on the whole diagonal locus.

---

## I1, post F41's marginal LP. **REFUTED AS STATED.** The repair is one omitted constraint, and it closes every gap the post reports.

**Reproduction, without the repair, exact.** My independent LP (minimise Σ_{a<b} λ_aλ_b C_ab over C ≥ 0 symmetric hollow, Σ_{a<b} C_ab = n−2, row sums ≤ 2; then θ ≤ λ_min + value/λ_min) returns the post's table to the digit: gain **0.000000** at all four maximal tori and at ad(su(3)), and the whole gap at padded W_CP², returning 1.224745 against Lemma L70 bounds of 2.857738, 4.490731, 6.123724 at n = 6, 8, 10. Every LP value is ≥ the point's true θ, so the LP version has **no** analogue of the greedy defect (the greedy 0.408248 below a true 1.224745), confirmed at all sixteen points.

**Every constraint the LP imposes is proved.** Total mass 2(n−2) follows from −tr(ad(v)²) = (n−2)‖v‖²_tr on so(n); zero diagonal is c_{vaa} = 0; the row cap is confirmed, sup‖[v,φ]‖² = 2.000000000 by alternating maximisation at n = 4, 6, 8, 10, independent of n and attained already in so(4).

**But one proved marginal constraint is missing.** On Weyl_n, for **every** unit v,

  **Σ_a λ_a m_a = −2⟨v, W v⟩**,

verified to 10⁻¹⁶ at random Weyl tensors and random unit v for n = 5, 6, 8, and **failing** on non-Weyl symmetric operators (−0.317 against −0.131 at n = 5, +0.530 against +0.061 at n = 6), so it genuinely uses Ricci-flatness. For unit v ∈ E_min the right-hand side is −2λ_min. This is a constraint on the marginals of ad(v) (it is Σ_{a<b}(λ_a+λ_b)C_ab) so it belongs inside post F41's LP, and post F41's list of "the only constraints the record holds on that law" omits it. The record is aware of the identity: [bounds.md](../findings/bounds.md) records it as "Σ_α u_{γα} = −2λ_γ … the per-row identity re-summed" and dismisses it as not new. Not new is not the same as not binding.

**Adding it collapses the LP to the exact θ at every point post F41 calls inert.**

| point | true θ | Lemma L70 bound | post F41 marginal LP | **+ first moment** | gain from the repair |
|---|---|---|---|---|---|
| maximal torus, n = 6 | 0.645497 | 1.936492 | 1.936492 | **0.645497** | 1.290994 |
| maximal torus, n = 8 | 0.540062 | 2.700309 | 2.700309 | **0.540062** | 2.160247 |
| maximal torus, n = 10 | 0.474342 | 3.320392 | 3.320392 | **0.474342** | 2.846050 |
| maximal torus, n = 12 | 0.428174 | 3.853570 | 3.853570 | **0.428174** | 3.425395 |
| ad(su(3)) ⊂ so(8) | 0.836660 | 1.673320 | 1.673320 | **0.836660** | 0.836660 |
| CP³ | 1.054093 | 3.162278 | 1.581139 | **1.054093** | 2.108185 |
| CP⁴ | 0.986013 | 4.930066 | 1.774824 | **0.986013** | 3.944053 |
| S³×S⁵ | 1.115547 | 2.231093 | 2.231093 | **1.115547** | 1.115547 |
| S⁵×S⁷ | 1.228239 | 1.842359 | 1.842359 | **1.228239** | 0.614120 |
| balanced products, n = 6…12 | θ₀(n) | saturated | saturated | **saturated** | 0 |
| padded W_CP², n = 6, 8, 10 | 1.224745 | 2.857738 / 4.490731 / 6.123724 | 1.224745 | **1.224745** | 0 |

The gains 1.290994, 2.160247, 2.846050, 3.425395 and 0.836660 are, digit for digit, the slacks post F41 tabulates as the evidence that the marginals cannot separate a torus from a balanced product. **One marginal constraint removes all of them.** So the post's headline, "the deficiency D is invisible to the marginals of ad(v), and the maximal tori are where that bites", is false, and the "what a successor must clear" box built on it should be withdrawn: at the maximal tori the marginals do separate, exactly, without the Jacobi identity.

**The reported dichotomy is real for the LP as posted, and its mechanism is as the brief suspects, but it dissolves under the repair.** At padded W_CP² the maximum eigenvalue has multiplicity 1, so the row cap of 2 admits at most 2 of the 2(n−2) units of mass onto the minimal product λ_min λ_max, and the remainder is forced onto products ≥ 0 (mostly λ_min·0); at the tori λ_max has multiplicity n/2 ≥ 3 and the cap never binds. So the dichotomy is an artefact of the interaction of the cap with dim E_max = 1 **combined with the omitted first moment**, with the first moment restored, both sides of the dichotomy return the exact θ.

**What survives of the post's conclusion.** The repaired marginal bound is still not a route to Conjecture A: it is lossy at padded S³×S³ in Weyl₁₂ (2.319004 against a true θ of 1.054093), at W_CP²⊕W_CP²⊕W_CP² (2.592725 against 0.707107) and at the C₅ blow-up (1.341641 against 0.670820, and above θ₀(10) = 1.2), and over three-value spectra at n = 12 it reaches 3.027650 = 2.45 × θ₀(12). **The route is still shut; the reason recorded for shutting it is wrong, and the fence post names the wrong witness family.**

---

## Verdicts

| claim | verdict |
|---|---|
| **I4** the sharpness is informative / "first relaxation not lossy at the extremum" | **REFUTED.** The cap is Lemma L70's already-recorded saturation, the attainment is the point's own T, one row of 2N does all the work, and the relaxation is lossy by 4.05× at a genuine critical Weyl₁₂ tensor and by 2.97 × θ₀(12) over spectra. |
| **I3** the table (values, boundedness, feasibility) | **CONFIRMED** as arithmetic (all eight numbers reproduced to nine digits, LP correctly posed and bounded, true T feasible), with the maximum proved to be exactly θ₀(n) rather than numerically close. |
| **I2** criticality in bracket coordinates | **REFUTED AS STATED.** The matrix form is exactly criticality; the stated bracket form is [W,Q(W)] = 0 and holds on the whole diagonal locus at criticality residual ≈ 0.5; the "λ_k ≠ λ_l" restriction contradicts both criticality and the record's own count. Repair in the I2 section. |
| **I2** the self-assessment "change of language, no new information" | **CONFIRMED, and generous**, the stated form carries strictly *less* than criticality, and its diagonal and off-diagonal halves are not in the same variables. |
| **I1** post F41's marginal LP and its inertness conclusion | **REFUTED AS STATED.** The LP is a valid relaxation and every constraint it imposes is proved, but it omits the proved Weyl identity Σ_a λ_a m_a = −2⟨v,Wv⟩; restoring it returns the exact θ at all four tori, at ad(su(3)), at both CP^m and at both unbalanced products. |
| **I1** the greedy defect has no LP analogue | **CONFIRMED**, every LP value is ≥ the true θ at all sixteen points, both with and without the repair. |

**Not reproduced, and flagged rather than glossed.** The n = 8 witness at θ = 1.088948 was not recovered: plain projected ascent on Weyl₈ converges only to the two local maxima (1.224745 and 1.145644), and the witness sits below them on the graded block-diagonal space over so(3)⊕so(5). Its LP row is therefore missing from the I4(a) table. It is not load-bearing for any verdict above, padded S³×S³, the triple CP² sum and the C₅ blow-up already carry the refutation, at n = 12 where the conjecture lives.
