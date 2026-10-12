# REVIEW r1180: post F79, Bianchi traced is rows (B) and (C)

Log: agent_logs/r1180.log

| Item | Verdict | Lean |
|---|---|---|
| 1 `wedge_gram` | CONFIRMED | `wedge_gram` (U12 to U33, sq_trace, trace4) |
| 2 conversion to the Gram of the Omega_c | CONFIRMED | none (prose) |
| 3 `bianchi_traced` against `Rows` | CONFIRMED, with one remark | `bianchi_traced` |
| 4 "traced Bianchi adds nothing" | PLAUSIBLE as scoped to pairings with Omega_0, Omega_1, Omega_2; the successor clause overreaches | none |

## Item 1
The statement is `sum_{abcd} wedgeSelf X * wedgeSelf Y = 12 tr(XY)^2 - 24 tr(XYXY)` for `IsSkew X`, `IsSkew Y`, in the `wedgeSelf` convention (factor 2). The factor 24 between the full-index sum and the i<j<k<l sum is prose, and correct: for skew X the form `wedgeSelf X` is totally antisymmetric, so it vanishes on repeated indices and each increasing quadruple appears 4! = 24 times with the same squared sign. `U11` is a trivial reflexivity lemma and is unused.

## Item 2
Record units give `<X^X, Y^Y> = tr(XY)^2/2 - tr(XYXY)`. For orthonormal skew psi, phi: tr(psi phi) = -2<psi,phi>, so the first term sums to 2 delta_ab m_a. For skew psi, phi, `||[psi,phi]||_F^2 = 2 tr(psi^2 phi^2) - 2 tr(psi phi psi phi)`, so `-tr(psi phi psi phi) = ||[psi,phi]||^2/2 - tr(psi^2 phi^2)`. Summing, `sum tr(psi^2 phi^2) = tr(A_a A_b) = G_ab` (the two signs of A cancel) and the bracket mass gives `2 sum_c t_cab`. Screen (seconds, n = 6, random orthonormal sets of sizes 4, 5, 4 in so(6)): all nine pairings agree with the formula to 1e-9, and `wedge_gram` agrees numerically. Reported as a screen.

## Item 3
Hypotheses `G00 = G02 = G22`, `G01 = G21` are what A_0 = A_2 gives. The diagonal term uses `p` for both m_0 and m_2, matching `Rows`, where (A0) and (A2) both carry `(n-2) p`. The three iff right-hand sides are verbatim rows 4, 5, 6 of `Rows` (B0, B1, B2). The norm conjunct equals twice the sum of the (C) residuals `(t000 - 2 t002 + t022 + (kappa+1) p) + (t001 - 2 t012 + t122) + (t002 - 2 t022 + t222 - (kappa-1) p)`, matching rows 7 to 9.

Remark: the (C) sum is redundant given (B). Since `||Omega_0 - Omega_2||^2 = <Omega_0 - Omega_2, Omega_0> - <Omega_0 - Omega_2, Omega_2>`, the (C) sum is (B0) - (B2) up to sign: the LHS of (B0) - (B2) is minus the LHS of (C0)+(C1)+(C2), and 2p = -(-2p). So traced Bianchi yields exactly the span of (B0), (B1), (B2), and the prose "and ||Omega_0 - Omega_2||^2 = 0 is (C0)+(C1)+(C2)" adds no fourth condition. Worth one clause in the note.

## Item 4
Within degree four in the eigenvectors, with class four-forms linear in the eigenspace projectors, the claim holds: the O(n)-invariant choices are the Omega_c, so the three pairings exhaust it. Traced consequences of Omega_0 = Omega_2 beyond these exist:
- **n = 8**: the Hodge star maps Lambda^4 to itself, so `<Omega_0 - Omega_2, *Omega_c> = 0` is a degree-four traced consequence (Pfaffian-type invariants) outside the nine rows.
- **Twisted class forms**: `psi A_b + A_b psi` is skew for skew psi, so `sum_{psi in E_a} (psi A_b + A_b psi) ^ psi` is a class four-form. Pairing gives sextic trace invariants such as tr(psi phi psi A_b phi).
- **Bracket forms**: `sum_{psi in E_a, phi in E_b} [psi,phi] ^ [psi,phi]` is a class four-form. Its pairing with Omega_0 - Omega_2 is a degree-six identity.
- **Compressions of the operator**: reading Omega_0 - Omega_2 as a symmetric operator on Lambda^2, `sum_{w in E_c} ||(Omega_0 - Omega_2) w||^2 = 0` is degree eight.

All of these bring unknowns absent from the nine rows, so they add equations in new variables rather than contradicting "adds nothing to the nine rows". They are class-level pairings, though, so the successor clause "never through class-level pairings" overreaches: `bianchi_traced` covers only pairings with the Omega_c. Suggested wording: "never through pairings with the Omega_c alone".
