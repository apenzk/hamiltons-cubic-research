# REVIEW r1182: L244 rowB_mass against the record

Log: agent_logs/r1182.log. Scope: [L244RowBMass.lean](../lean/HamiltonsCubic/Results/L244RowBMass.lean) against [second-order.md](../findings/second-order.md) Lemma L244 (i), row (B). Analysis-only footing: one seconds-scale screen, reported as a screen.

| Item | Verdict |
|---|---|
| 1 `mixQF_Pc` (any skew family, no orthonormality) | CONFIRMED |
| 2 `rowB_mass` hypotheses and conclusion vs the record | REFUTED (vacuous at every n >= 1) |
| 3 non-vacuity | REFUTED (only n = 0 satisfies the hypotheses) |

## Item 1

- The argument is sound: `Pc a = sum_{gamma in E_a} psi_gamma <psi_gamma, .>` is a sum of rank-one symmetric operators, and the only Parseval step (`parseval_phi`) is applied with `Y = [eta, psi_gamma]`, which is skew. Neither step uses orthonormality.
- Screen (pure Python, n = 5, r = 7 random non-orthonormal skew psi, random 3-class labels, random skew eta): max over (a,b) of |mixQF(Pc a, Pc b) eta - bAB a b eta| = 4.5e-13 against values up to 2.2e3.

## Item 2 (the defect)

- `hId : ∀ X, X = ∑ a, Pc ψ cls a X` quantifies over ALL real n x n matrices, and `hWP : ∀ X, W X = ...` likewise.
- Each `Pc a X` is a linear combination of skew `psi_gamma`, so `∑ a Pc a X` is skew for every X. At X = I (n >= 1): `inner2 psi I = ½ tr(psiᵀ) = 0` for skew psi, so `∑ a Pc a I = 0 ≠ I`. The screen above confirms `∑ a Pc a I = 0` exactly.
- Hence `hId` is false for every psi, cls at every n >= 1, and `rowB_mass` holds vacuously. W's orthonormal eigenbasis of so(n) satisfies `hId` only on skew X (there `∑ a Pc a X` is the skew part of X).
- `rowB_classes` itself is sound: its `P` are arbitrary linear maps on all matrices and can resolve the identity. The defect enters only when `P := Pc`, which cannot.
- The conclusion's shape is right: at unit x in E_c, `-inner2 (W x) x = -lam_c`, the record's row (B). Only the hypotheses are defective.

## Item 3

- n = 0 (trivial matrix space) is the only case where `hId` holds. No W at n >= 1.

## Repair

- Restrict both hypotheses to skew X: `hId : ∀ X, IsSkew X → X = ∑ a, Pc ψ cls a X`, `hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • Pc ψ cls b X`.
- This needs a skew-restricted `rowB_classes`: `mixQF A B eta` evaluates B only at `phi i j` and A only at `[eta, B(phi i j)]` (both skew when B preserves skewness), and `rowB` evaluates W only at skew arguments. So replace the two `funext` rewrites by a congruence lemma (`mixQF`/`mixSym` agree for operators equal on skew matrices, given skew-preservation), then re-derive.
- [lean/INDEX.md](../lean/INDEX.md) line 182's "row (B) in the record's class masses is PROVED" should be withdrawn to "typed, vacuous as stated" until the repair lands.
