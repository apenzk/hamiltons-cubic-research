# Gate 2 brief: the Casimir identity in Lean (r1166)

**One reviewer: the round compares Lean declarations against a statement already fixed** ([r1160](REVIEW_r1160.md) item 4: the Casimir mass $\sum_{\psi}\lVert[\psi,h]\rVert_F^2=2n\lvert h\rvert^2$ over an orthonormal basis of $\mathfrak{so}(n)$, for traceless symmetric $h$). Analysis-only; builds in the background from `lean/`, waiting if another is running. Model: opus.

## What to compare, in [Casimir.lean](../lean/HamiltonsCubic/Results/Casimir.lean)

| claim | declaration |
|---|---|
| `φ_ij = E_ji − E_ij`; `∑_{i,j} φ_ab φ_cd = 2(δ_ac δ_bd − δ_ad δ_bc)` over ordered pairs | `phi`, `completeness` |
| `∑_{i,j} φ_ij M φ_ij = 2(Mᵀ − (tr M) I)` | `sum_phi_M_phi` |
| `φ_ij` is skew | `phi_transpose` |
| For symmetric `h`, `∑_{i,j} tr([φ_ij,h]ᵀ[φ_ij,h]) = 4n tr(h²) − 4 (tr h)²` | `casimir` |

## Items

1. Does each declaration state its claim with no weakening or vacuity? Does `casimir`, restricted to `i < j` (half the ordered sum) and to traceless `h`, give r1160's `2n|h|²` in the record's normalisation (`φ_ij` with `i < j` orthonormal for `⟨X,Y⟩ = ½ tr XᵀY`)?
2. Is `phi` the same object as the layer's `phi` in [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) (`single j i 1 − single i j 1`), or does it only coincide entrywise? Say whether a bridging lemma is needed for use elsewhere.
3. Build `HamiltonsCubic.Results.Casimir` in the background and run `python3 scripts/misc/axiom_audit.py --only Casimir`.

## Protocol

Log to `agent_logs/r1166.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_r1166.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md`, any Lean file or any script. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
