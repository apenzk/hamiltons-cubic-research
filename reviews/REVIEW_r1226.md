# REVIEW r1226: batch 37, Lemma E (symmetric-pair idempotents)

Log: [agent_logs/r1226.log](../agent_logs/r1226.log). Block audited: [2026-09-26-I73-class-ceiling.md](2026-09-26-I73-class-ceiling.md), section "Batch 37". Lean: [I117PsdReduction.lean](../lean/HamiltonsCubic/Results/I117PsdReduction.lean), `sympair_idem`.

| claim | verdict | reason in one line |
|---|---|---|
| C1 Schur step | CONFIRMED, with a redundancy note | the block forms follow from the bracket relations alone; Schur is used for alpha where it is unneeded, and for beta the real content is `P_k#P_k = c_k P_k` |
| C2 constants | CONFIRMED | `I#I = P_k#P_k + 2 P_k#P_p + P_p#P_p`, read on p and on k |
| C3 idempotent solutions | CONFIRMED, with a stated-hypothesis gap | `beta > 0` and `c_k > 0` are used (division) but never stated in the prose; both hold; sigma/c checked independently |
| C4 scope parenthetical | CONFIRMED, with two scope notes | both families have non-simple k; the k = 1 member of the two-block family is inside Lemma E, and k = n/2 meets the weakened hypothesis |

## Method

- Read the chain link by link, then re-derived each step from the definitions.
- One screen (seconds, numpy, so(6), script in the session scratchpad): the block forms of `P_k#P_p`, `P_p#P_p`, `P_k#P_k` and the idempotency of `sigma/c` for k = so(5), so(3)+so(3), so(2)+so(4). Reported as a screen only.

## C1: the block forms

- Write `A#B = ad (A∧B) ad^T`. For `h` in k, `ad^T h` lies in `Λ²k ⊕ Λ²p`; for `h` in p it lies in `k∧p` (bracket relations). `P_k∧P_p` kills `Λ²k` and `Λ²p` and acts as `1/2` on `k∧p`; `P_p∧P_p` is the projector on `Λ²p`; `P_k∧P_k` the projector on `Λ²k`.
- Hence `P_k#P_p = (1/2) ad Π_{k∧p} ad^T` has image in p and vanishes on k and on the k-p cross block; `P_p#P_p` and `P_k#P_k` are supported on the k-block. No P_k component in `P_k#P_p`, no P_p component in `P_p#P_p`: correct.
- **Schur is unnecessary for alpha.** On p, `I#I = 2 P_k#P_p` exactly (the other two terms vanish there), so `P_k#P_p = (c/2) P_p` follows from `I#I = cI` alone, without irreducibility of p. The screen confirms `alpha = 2 = c/2` in all three cases, including k = so(2)+so(4).
- **For beta, the content is the Casimir hypothesis, not Schur.** On k, `P_p#P_p = cP_k - P_k#P_k`. So `P_p#P_p` is a multiple of `P_k` if and only if `P_k#P_k = c_k P_k` with a single value `c_k`. "A single induced Casimir value on k" suffices, and "k simple" is one sufficient condition for it. Screen witness of the failure when the values differ: k = so(2)+so(4) in so(6) gives `P_k#P_k = diag(0, 2)` on the two ideals and `P_p#P_p = diag(4, 2)`; k = so(3)+so(3) (equal values 1) gives scalar `beta = 3`.
- **As written, the Schur citation is incomplete** even though its conclusion is true: it needs the Aut(g)-equivariance of `#` (so that `A#B` commutes with `Ad(K)` when `A`, `B` do) and, for p of complex type (for example so(2m)/u(m)), the remark that the symmetric elements of a commutant `R`, `C` or `H` are real scalars. Neither is stated. Since the argument above makes Schur unnecessary, the cleaner repair is to replace the parenthesis "(Schur, p irreducible and k simple)" with "(the bracket relations, and `I#I = cI` on p; on k, `P_p#P_p = cP_k - P_k#P_k`)".
- Also redundant: for compact simple g the isotropy representation of a symmetric pair is irreducible, so "p irreducible" is automatic.

## C2: the constants

- `I#I = P_k#P_k + 2 P_k#P_p + P_p#P_p` by bilinearity and symmetry. On p: `c = 2 alpha`. On k: `c = c_k + beta`. Correct. Sanity check so(n) ⊃ so(n-1): `c_k = n-3`, `beta = 1`, `alpha = (n-2)/2`, matching the screen at n = 6.

## C3: the idempotent equations and solutions

- `C#C = a² P_k#P_k + 2ab P_k#P_p + b² P_p#P_p = (a²c_k + b²beta) P_k + abc P_p`. Equations `a²c_k + b²beta = a`, `abc = b`: correct.
- `b = 0`: `a ∈ {0, 1/c_k}`, **which divides by `c_k`**. `a = 1/c`: `b²beta = beta/c²`, **which divides by `beta` to get `b = ±1/c`**. Neither `c_k > 0` nor `beta > 0` is stated in the prose. Both hold: `c_k > 0` for non-abelian k, and `beta = (1/2) Σ <[p_α,p_β],h>²` for unit `h` in k is positive because `[p,p] + p` is an ideal of the simple g, so `[p,p] = k`. Also `1/c ≠ 1/c_k` because `beta > 0`, so the branches do not overlap. Repair: state "`beta > 0` since `[p,p] = k`" in the proof.
- Positive definite requires `a > 0` and `b > 0`: only `I/c`. `P_k/c_k` is PSD and singular, `sigma/c` indefinite. Correct.
- **sigma/c, independently.** `sigma` is an orthogonal involutive automorphism, so `ad ∘ Λ²sigma = sigma ∘ ad`, and `sigma#sigma = ad (Λ²sigma) ad^T = sigma (ad ad^T) = sigma (I#I) = c sigma`. Hence `(sigma/c)#(sigma/c) = sigma/c`. Screen: error 0.0 in all three so(6) cases.
- **Lean.** `sympair_idem (hc : 0 < c) (hβ : 0 < β) (hsum : ck + β = c) (h1) (h2) (hb : b ≠ 0) : a = 1/c ∧ b^2 = 1/c^2` matches the `b ≠ 0` branch of the prose, with `beta > 0` as a hypothesis (the prose's missing statement enters here explicitly). The `b = 0` branch and the step from `b² = 1/c²` to `b = ±1/c` are prose only, both elementary.

## C4: the scope parenthetical

- so(k)+so(n-k) in so(n) has two ideals for 3 ≤ k ≤ n-3 (and a centre at k = 2), and u(m) = su(m) + RJ has a centre. Both are outside "k simple". Correct as stated, and "three parameters" matches batch 33 (`a, b, c`) and batch 36 (`a, b, c`).
- **Scope note 1.** At k = 1 the two-block family is so(n-1) ⊂ so(n), which satisfies Lemma E (k = so(n-1) simple for n-1 ≥ 5). "The two-block family ... is the case with two ideals" holds for the interior range of k only.
- **Scope note 2.** At k = n/2 both ideals have the same induced Casimir value (k-2), so by C1's weakening the argument covers the diagonal two-parameter subfamily `a(P_1 + P_2) + b P_p` there. The full three-parameter family stays outside, as the block says.
- **The closing sentence** "every idempotent of these families is subalgebra-supported, the identity's multiple, or an automorphism twist" is proved for the ansatz `aP_k + bP_p`. That the ansatz is the whole K-invariant symmetric family (no `Hom_K(k,p)` cross block) is not argued in the block. It is the family the lemma names, so this is a remark, and no counterexample was sought.

## Findings summary

- No claim refuted.
- Gap (C3): `beta > 0` (and `c_k > 0`) used without statement. Repair: one clause, `[p,p] = k` for simple g.
- Gap (C1): the Schur citation omits the equivariance of `#` and the real-type caveat. Better repair: drop Schur, since `I#I = cI` on p gives alpha and the Casimir hypothesis gives beta. Hypothesis can be weakened from "k simple, p irreducible" to "`P_k#P_k = c_k P_k` with `c_k > 0`".
