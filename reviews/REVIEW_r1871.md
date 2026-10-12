# Review r1871: I121, the Λ² loss, Σ₄ and its failure on Weyl tensors (reader one of two)

Brief: [BRIEF_I121_sigma4.md](BRIEF_I121_sigma4.md). Log: [r1871-i121-sigma4.log](../agent_logs/r1871-i121-sigma4.log). Block under review: [2026-09-28d-I121-smallmass-direct.md](2026-09-28d-I121-smallmass-direct.md), section "The Λ² loss is tr(W²#W²)". Lean: [IndexConcentration.lean](../lean/HamiltonsCubic/Results/IndexConcentration.lean), [AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean).

Footing: analysis first. Computation was limited to checks on objects built here (own Weyl basis from the Bianchi and Ricci constraints, own # from the so(n) structure constants, own N): a descent of Σ₄/tr W⁴ at n = 5 and n = 6 fixed in advance at 8 starts by at most 300 BFGS iterations, and one refinement from the n = 6 witness, a single start of at most 200 iterations. Every number below is a screen.

## Verdicts

| item | claim | verdict |
|---|---|---|
| 1 | sigma4_comp at R = W² is Σ₄ = 2 tr W⁴ − 6‖Alt(W²)‖², the "exactly when" and the L204 sentence | CONFIRMED, one wording note |
| 2 | Σ₄ = 2‖W⁺‖²‖W⁻‖² at n = 4, zero exactly at one-sided W | CONFIRMED |
| 3 | a Weyl tensor with Σ₄ < 0 from n = 5, the n = 6 witness | CONFIRMED in substance, REFUTED on two statements: the ratio's normalisation, and "not a critical point" |
| 4 | the split needs criticality to supply Σ₄ ≥ 0, and nothing on the record does | REFUTED as worded: criticality alone does not supply it, the n = 6 witness being a critical point at θ = 0 with Σ₄ < 0. Correct once scoped to θ > 0 |
| 5 | scope and wording | REFUTED on three points, corrections below |

## Item 1: the Σ₄ reduction (CONFIRMED)

- sigma4_comp states Σ comp R_{ijkl} comp R_{jkli} = 2 fourNormSq (comp R) − 6 altNormSq R for R respecting sign and symmetric on skew matrices. The left side is the undivided ordered sum, which is the block's Σ₄ = Σ_{ijkl}(W²)_{ijkl}(W²)_{jkli}. The global sign of comp against the record's R_{ijkl} cancels in the product.
- comp R i j k l = ⟨R φ_ij, φ_kl⟩ with inner2 = ½ tr(XᵀY), and ⟨φ_ij, φ_ij⟩ = 1, so comp is the matrix of R in the orthonormal pair basis. At R = W∘W this is the operator square (W²)_{ijkl} = Σ_{p<q} W_{ijpq}W_{pqkl}.
- fourNormSq (comp R) = normSq R is normSq_eq_fourNormSq_comp in AltPart.lean, needing only that R maps skew to skew. At R = W² it is the Hilbert–Schmidt norm of W² on Λ², that is tr W⁴. altNormSq R = fourNormSq (alt4 (comp R)) is ‖Alt(W²)‖² with the record's ⅓ and ¼.
- Hypotheses at R = W∘W: hneg holds by linearity. hsym needs inner2 (W(WX)) Y = inner2 (WX) (WY), which uses W's symmetry at the skew argument WX, supplied by the first clause of IsWeyl (W maps skew to skew). Both hold. The instantiation at W² and its reading as tr W⁴ are prose in the docstring, with no declaration of their own. That is acceptable for the block's claim, since the block says "read at the record's operators".
- Hand check of the mechanism: for Bianchi B, T_{jkli} = −T_{iljk} and B_{iljk} = −B_{ijkl} − B_{iklj}, and the cyclic relabelling gives Σ B_{ijkl}B_{iklj} = Σ B_{ijkl}B_{iljk} = X, so X = −ΣB² − X and Σ₄(B) = ½ ΣB² = 2‖B‖². On Λ⁴, Σ₄(A) = −ΣA² = −4‖A‖². Cross terms vanish because the four-cycle and its inverse act by −1 on Λ⁴. Total 2‖T‖² − 6‖A‖². Screened on a random Weyl tensor: the reduction holds to 10⁻¹⁶.
- "exactly when": with the given identity, tr(W²#W²) ≤ ⅛‖N‖²_F iff Σ₄ ≥ 0 iff ‖Alt(W²)‖² ≤ ⅓ tr W⁴. Follows.
- L204 sentence: A = W² is positive semidefinite with tr A = 1, so L204 gives ‖Alt(W²)‖² ≤ (m−1)/(3m), which is at most ⅓ tr W⁴ exactly when tr W⁴ ≥ 1 − 1/m. Right. At n = 4 (m = 2) this asks tr W⁴ ≥ ½, and tr W⁴ = ½(s₊² + s₋²) ≤ ½ with equality only at one-sided W, so L204 delivers the bound at n = 4 only where Σ₄ = 0 anyway.
- Wording note: "the index map acts by ½ on the Bianchi part" is true of its quadratic form (equivalently its symmetric part), and the map itself has no eigenvalue ½ there. Suggest "whose quadratic form is ½ on the Bianchi part and −1 on Λ⁴".

## Item 2: n = 4 (CONFIRMED)

- A Weyl W at n = 4 is block diagonal on Λ⁺ ⊕ Λ⁻ with traceless 3×3 blocks A, B, s₊ = tr A², s₋ = tr B² (screened: off-diagonal block 10⁻¹⁶).
- On a traceless symmetric 3×3 X with eigenvalues a, b, −a−b: Σλ² = 2(a² + ab + b²) and Σλ⁴ = 2(a² + ab + b²)², so tr X⁴ = ½(tr X²)². Hence tr W⁴ = ½(s₊² + s₋²).
- L199's Alt(W²) = ⅙(s₊ − s₋)⋆ agrees with the projection coefficient ⟨W², ⋆⟩/‖⋆‖² = (tr A² − tr B²)/6, and ‖Alt(W²)‖² = 6(s₊ − s₋)²/36 = (s₊ − s₋)²/6.
- Σ₄ = (s₊² + s₋²) − (s₊ − s₋)² = 2s₊s₋ ≥ 0, zero iff s₊ = 0 or s₋ = 0, which is one-sided W. Screened on a random unit Weyl tensor at n = 4: Σ₄ = 0.411771245077 against 2s₊s₋ = 0.411771245077.
- The P₊ example: G = ½(I + ⋆), Ric(G) = (3/2)I, N_G = 3I, ⅛‖N_G‖² = 9/2. Σ₄(G) = 2·3 − 6·(6/4) = −3, so tr(G#G) = 9/2 + 3/2 = 6. Screened with the own #: 6.0 and 4.5.

## Item 3: the failure from n = 5 (the tensor CONFIRMED, two statements REFUTED)

- Own descent, n = 5 (Weyl dimension 35): all 8 starts reach Σ₄/tr W⁴ = −0.182104, with ‖Alt(W²)‖²/tr W⁴ = 0.363684.
- n = 6 (dimension 84): 2 of 8 starts reach Σ₄/tr W⁴ = −2/3 (Λ⁴ fraction 4/9), the other 6 stop at −0.609902. The −2/3 point has spectrum ±0.353553 = ±1/(2√2) on two four-dimensional eigenspaces and a seven-dimensional kernel, N = (2/3)I, tr(G#G) = 0.375 = 3/8 with the own # (the identity also reproduced on a random symmetric G to 10⁻¹³), Bianchi and Ricci residuals 2·10⁻¹⁶ and 2·10⁻¹⁵. The block's spectrum, N and tr(W²#W²) are CONFIRMED.
- **Normalisation, REFUTED as written.** The block's values −0.046, −⅙, −0.286, −0.408 are Σ₄ divided by the undivided sum Σ(W²)²_{ijkl} = 4 tr W⁴, while its Λ⁴ fractions are ‖Alt(W²)‖²/tr W⁴ in the record's norm. In the record's norm, where ‖W²‖² = tr W⁴, the ratios are 2 − 6·(fraction): −0.182, −⅔, −1.144, −1.630. At the witness, tr W⁴ = 8/64 = ⅛, ‖Alt(W²)‖² = 1/18 and Σ₄ = ¼ − ⅓ = −1/12, so Σ₄/‖W²‖² = −⅔. The block announces the record's norm two sentences earlier, so the ratio must be relabelled "Σ₄/Σ(W²)²_{ijkl}" or the values replaced.
- **"It is a Weyl tensor and not a critical point", REFUTED at screen strength.** At the witness θ = P(W) = 5·10⁻¹⁰ (tr W³ = 0 by the symmetric spectrum, and ⟨W#, W⟩ = 0), and the Weyl projections of W² and of W# have norm 0.0527 each and cancel to 3·10⁻⁵. One refinement (single start, BFGS, at most 200 iterations, minimising ‖Π_Weyl(W² + W#) − θW‖²) reaches residual 9.6·10⁻⁸ with θ = −1.5·10⁻¹⁵ and Σ₄/tr W⁴ = −0.6666666666, spectrum unchanged to 10⁻⁶. So the witness is, to screen precision, a critical point of P on the unit Weyl sphere at θ = 0.
- **Closed form, partial.** The witness is J-invariant for a complex structure J on ℝ⁶ (J is the one-dimensional centraliser of its image, J² = −I to 10⁻¹¹, [ad J, W] = 10⁻⁵), its two nonzero eigenspaces together span su(3) ⊂ u(3) ⊂ so(6) (bracket-closure residual 3·10⁻⁵), and the kernel is ℝJ ⊕ [[Λ^{2,0}]]. So W is a Kähler algebraic curvature tensor with zero Ricci, of Calabi–Yau type on ℂ³, W = (1/(2√2))(P_{U₊} − P_{U₋}) with U₊ ⊕ U₋ = su(3), [U₊, U₊] ⊂ U₋, [U₋, U₋] ⊂ U₊, and stabiliser in so(6) equal to ℝJ. An explicit basis for U₊ was not reached.
- Padding: a Weyl tensor padded by zeros stays Weyl, and Σ₄, tr W⁴ and Alt(W²) are unchanged, so the n = 5 tensor gives Σ₄ < 0 at every n ≥ 5. With item 2 this makes n = 5 the exact threshold. The block does not state the padding step, and "from n = 5" rests on it.

## Item 4: the consequence (REFUTED as worded, correct at θ > 0)

- Record search, [findings/](../findings/), [results.md](../results.md) and the reviews, for Σ₄, Q, or ‖Alt(W²)‖ at critical points: the only upper bound on ‖Alt(W²)‖ is L204. The record does give Alt(W²) = 0, hence Σ₄ = 2 tr W⁴ > 0, on two loci for every Weyl tensor with no criticality: coordinate-diagonal W ([bounds.md](../findings/bounds.md), the L199 remark "where the deficit vanishes"), and W with at most two distinct eigenvalues ([diagonal-half.md](../findings/diagonal-half.md), the I75 block, Gate 2 r995 and r996). At three distinct eigenvalues Alt(W²) is one free parameter, and the witness has exactly three (±c, 0). Neither locus reaches a general critical point, so the absence claim stands for general critical points, and the block could cite these two loci beside its list of positive examples.
- Hamilton's identity puts W² + W# in the Bianchi space for every algebraic curvature tensor, so Alt(W²) = −Alt(W#) at every Weyl tensor, critical or not. The critical equation Π_Weyl(W² + W#) = θW changes only the Ricci and scalar parts of W² + W#, whose Alt vanishes on both sides. So the first-order critical equation with Hamilton's identity imposes no condition on Alt(W²). This agrees with the block.
- **The witness sharpens the claim.** Since the n = 6 witness is a critical point with θ = 0 and Σ₄ = −1/12 < 0 (item 3), "at critical points Σ₄ ≥ 0 is open" is false as stated, and "the split needs criticality to supply Σ₄ ≥ 0" names a hypothesis that does not supply it. Any route to Σ₄ ≥ 0 has to use θ > 0 (the regime of the bound) or second-order information at a maximiser. The block's inequality is stated at θ > 0, so the band argument itself is unaffected.

## Item 5: scope and wording (REFUTED on three points)

- The descent ratio's normalisation (item 3): relabel or rescale.
- "It is a Weyl tensor and not a critical point": replace by "a critical point at θ = 0, outside the bound's hypothesis θ > 0" (screen, residual 10⁻⁷).
- "At critical points Σ₄ ≥ 0 is open": scope to θ > 0, and cite the witness as the reason the scope is needed.
- The n = 5, 7, 8 values are written as what descent "reaches", which is the right strength. At n = 6 the value is reached from 2 of 8 starts here, with a second descent endpoint at −0.6099 (record norm), so −⅔ is a descent value rather than a proved minimum, as the block implies.
- "From n = 5" needs the padding sentence of item 3.

## Corrections for the author

1. Relabel the descent ratio: the four values are Σ₄/Σ_{ijkl}(W²)²_{ijkl}, or in the record's norm Σ₄/tr W⁴ = −0.182, −⅔, −1.144, −1.630.
2. Replace "It is a Weyl tensor and not a critical point" with "It is a critical point at θ = 0 (residual 10⁻⁷ after refinement), a Kähler Ricci-flat curvature tensor on ℂ³ whose nonzero eigenspaces span su(3)".
3. Scope "At critical points Σ₄ ≥ 0 is open" and "the split needs criticality to supply Σ₄ ≥ 0" to θ > 0, since the witness is a θ = 0 critical point with Σ₄ < 0.
4. Add the padding step that carries the n = 5 tensor to every n ≥ 5.
5. Optional: "acts by ½" to "has quadratic form ½", and cite the two record loci (coordinate-diagonal, two distinct eigenvalues) where Alt(W²) = 0 and Σ₄ = 2 tr W⁴.
