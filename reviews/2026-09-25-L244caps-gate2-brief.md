# Gate 2 brief: L244's cap in eigenspace form, in Lean (r1158)

**One reviewer: the round compares Lean declarations against a statement already fixed** (L244's cap hypotheses in [L244SymmetricPerVector.lean](../lean/HamiltonsCubic/Results/L244SymmetricPerVector.lean) and the cap as stated in [the working note](2026-09-25-I73c-per-vector-rows.md)'s opening section: $\sum_bb_{ab}(x)\le\tfrac12\kappa_{m_a}(x)$ with $b_{ab}(x)=\langle B_{ab}x,x\rangle$, $B_{ab}=\tfrac12\sum_{\gamma\in E_a,\delta\in E_b}[\psi_\gamma,\psi_\delta]\otimes[\psi_\gamma,\psi_\delta]$). Analysis-only; builds in the background from `lean/`, waiting if another is running. Model: opus.

## What to compare, in [L244Caps.lean](../lean/HamiltonsCubic/Results/L244Caps.lean)

| claim | declaration |
|---|---|
| `R_a(x) = ½ ∑_{γ,δ} ⟨[ψ_γ, φ_δ], x⟩²` over an orthonormal `ψ` (basis of `E_a`) and a complete `φ` | `rowMass` |
| Parseval: `R_a(x) = ½ ∑_γ ‖[ψ_γ, x]‖²` when `φ` expands every skew matrix as `∑ ⟨φ_k, Y⟩ φ_k` | `rowMass_eq` |
| `R_a(x) ≤ ½ (r + 2) ⟨x, x⟩` from `κ_r ≤ r + 2` | `rowMass_le` |

## Items

1. Is `rowMass` the sum over `b` of `b_ab(x)` when `φ` is the union of orthonormal bases of the eigenspaces (check the factor `½` and the pairing `⟨[ψ_γ, φ_δ], x⟩²` against `⟨B_{ab}x, x⟩`)? Is `rowMass_eq`'s completeness hypothesis the right one (it drops orthonormality of `φ`: is that sound)?
2. Is `rowMass_le` stated at every skew `x` with no hidden restriction, and does the INDEX row for L244 claim only this?
3. Build `HamiltonsCubic.Results.L244Caps` in the background and run `python3 scripts/misc/axiom_audit.py --only L244Caps`.

## Protocol

Log to `agent_logs/r1158.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_r1158.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md`, any Lean file or any script. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
