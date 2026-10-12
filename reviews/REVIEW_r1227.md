# REVIEW r1227: batch 37, Lemma E (symmetric pairs with simple k)

Log: agent_logs/r1227.log. Block audited: reviews/2026-09-26-I73-class-ceiling.md, section "Batch 37". Screen script (scratchpad, seconds): r1227.py, recorded below.

| claim | verdict |
|---|---|
| C1 | CONFIRMED, with two findings: Schur is superfluous, and the hypotheses are stronger than the proof needs |
| C2 | CONFIRMED |
| C3 | CONFIRMED, with a minor gap: the step b = ±1/c divides by β without stating β > 0 |
| C4 | CONFIRMED for the parenthetical. The bold closing sentence overreaches if "these families" includes batches 33 and 36 |

## C1. The Schur step

- Block supports, from the bracket relations alone. With an orthonormal basis adapted to k + p, the polarised formula gives the following.
- P_k#P_p has form (h,h') -> (1/2) Σ over k-basis α, p-basis β of <[k_α,p_β],h><[k_α,p_β],h'>. Since [k,p] ⊆ p it vanishes whenever h or h' lies in k, so P_k#P_p is supported on p x p.
- P_p#P_p has form (1/2) Σ over p x p of <[p_α,p_β],h><[p_α,p_β],h'>. Since [p,p] ⊆ k it is supported on k x k.
- P_k#P_k is supported on k x k since [k,k] ⊆ k.
- Expanding I#I = (P_k+P_p)#(P_k+P_p) = P_k#P_k + 2 P_k#P_p + P_p#P_p and reading I#I = cI block by block gives P_k#P_p = (c/2) P_p on p, and P_p#P_p = c P_k − P_k#P_k on k. This holds with no Schur and no irreducibility.
- Finding 1 (a gap in economy, conclusion true): the cited Schur step is valid but unnecessary. The Schur step as written also skips a real-Schur detail. When p is irreducible over R, its commutant is R, C or H. It is the symmetry of P_k#P_p that forces a scalar, because the non-real units of C and H are skew. The identity reading above removes the need for that argument.
- Finding 2 (answering the brief's question): "k simple" is not needed. The only hypothesis used is P_k#P_k = c_k P_k, that is, a single induced Casimir value on k with no centre. "p irreducible under k" is used nowhere, and for compact simple g it is automatic anyway (the isotropy representation of an irreducible symmetric space is irreducible).
- Screen (so(n), record normalisation), all True: so(6)/so(5), so(6)/(so(3)+so(3)) and so(7)/(so(3)+so(4)) each give I#I = (n−2)I, P_k#P_p = ((n−2)/2)P_p and P_p#P_p = (n−2)P_k − P_k#P_k. For so(7)/(so(3)+so(4)), P_k#P_k has two values on k (1 on so(3), 2 on so(4)), so P_p#P_p is then not a multiple of P_k. For so(6)/(so(3)+so(3)), with two ideals and equal Casimir 1, it is 3 P_k. The weakened hypothesis admits that case, and Lemma E's two-parameter conclusion holds there.
- A conventions point: "k simple" must mean non-abelian. For k = so(2) (the pair SO(3)/SO(2)) c_k = 0 and P_k/c_k is undefined.

## C2. The constants

- CONFIRMED. By bilinearity and symmetry of #, I#I on p is 2α = c, since P_k#P_k and P_p#P_p vanish on p. On k it is c_k + β = c, since P_k#P_p vanishes on k. This is exactly the block reading above. It matches batch 33's P_k#P_mix = ((k−1)/2) P_mix, taken at the analogous block.

## C3. The idempotent equations and solutions

- C#C = a² c_k P_k + 2ab α P_p + b² β P_k = (a² c_k + b² β) P_k + abc P_p. So C#C = C is equivalent to a² c_k + b² β = a together with abc = b. CONFIRMED.
- Case b = 0 gives a ∈ {0, 1/c_k}, with c_k > 0 for non-abelian k. Case b ≠ 0 gives a = 1/c and then b² β = (1/c)(1 − c_k/c) = β/c².
- Minor gap: concluding b = ±1/c needs β ≠ 0, and the prose does not state it. It holds because β = (1/2) Σ <[p_α,p_β],h>² / |h|² ≥ 0. Moreover [p,p] + p is an ideal of the simple g, so for p ≠ 0 we get [p,p] = k and β > 0. The Lean declaration carries β > 0 as a hypothesis, which is correct.
- Positive definiteness requires a > 0 and b > 0. Of the four solutions only I/c qualifies, and P_k/c_k is PSD but singular. CONFIRMED.
- σ/c checked independently. σ is an orthogonal automorphism, so ad∘(σ∧σ) = σ∘ad. Also (σ∧σ)∘ad^T = ad^T∘σ, because <x, [σ⁻¹u, σ⁻¹v]> = <σx, [u,v]>. Hence σ#σ = ad(σ∧σ)ad^T = ad ad^T σ = (I#I)σ = cσ, and (σ/c)#(σ/c) = σ/c. The screen confirms σ#σ = cσ in all three cases. The general principle holds for every orthogonal automorphism φ: φ#φ = cφ.
- Lean: HamiltonsCubic.I117PsdReduction.sympair_idem (lean/HamiltonsCubic/Results/I117PsdReduction.lean:125) states the b ≠ 0 branch with hypotheses c > 0, β > 0, c_k + β = c and the two equations. It concludes a = 1/c and b² = 1/c², which matches the prose. The file compiles clean with `lake env lean`, and it contains no sorry and no native_decide. The b = 0 branch and the operator steps (C1, C2) are prose, as the Lean section says.

## C4. Scope parenthetical

- Two-block family: k = so(k) + so(n−k) has two ideals, so it is not simple, as stated. Batch 33's family is three-parameter (a, b, c on the two ideals and on the mix), which puts it outside Lemma E's two-parameter family whatever the hypothesis. CONFIRMED.
- U(m): k = u(m) = su(m) + RJ has a centre. P_k#P_k is 0 on RJ (since [k,k] = su(m) is orthogonal to the centre) and c_su on su(m), so it is not scalar. The family is three-parameter. CONFIRMED.
- Remark: under Finding 2's weakened hypothesis, the balanced two-block case n = 2k with a = b (equal Casimirs k−2) falls inside the lemma's conclusion. It is the diagonal slice of batch 33's family.
- Overreach: the bold sentence "So every idempotent of these families is subalgebra-supported, the identity's multiple, or an automorphism twist of it" is proved only for Lemma E's own two-parameter families. For batch 33 and batch 36 it rests on the screens at particular n, which the record calls screens. The sentence should be scoped to Lemma E's families, or should carry "(screened)" for the other two.

## Suggested rewording

- Replace the hypotheses "k simple ... p irreducible" with "P_k#P_k = c_k P_k with c_k > 0 (for instance k simple)". Replace the Schur parenthetical with "block supports from the bracket relations, then I#I = cI read on p and on k". Add "β > 0 since [p,p] = k" before b = ±1/c.
