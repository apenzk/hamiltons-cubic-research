# Gate 2 brief: the Ricci correction as a difference of commutator masses (r1159, r1160)

**Two reviewers, independently: the round checks an argument.** Analysis-only: argue from the definitions; seconds of computation on objects you construct only as a screen. Model: opus.

## The claims, verbatim from [the working file](2026-09-25-I73c-per-vector-rows.md) at 4ca4f921

> **Where the Ricci correction can cancel, and where it cannot.** With $e=\tfrac a\theta(P_2-P_0)$ and $Q_c(h)=\sum_{\psi\in E_c}\mathop{\mathrm{tr}}(\psi h\psi h)$, the record's identity $\sum_c\lambda_cQ_c(h)=\mathring W(h,h)$ gives $\langle h,\mathring eh\rangle=\tfrac a\theta\big(Q_2(h)-Q_0(h)\big)$. **Separately each $Q_c$ is not small**: $\lvert Q_c(h)\rvert\le\mathop{\mathrm{tr}}(h^2A_c)$ with $A_c=\sum_{\psi\in E_c}\psi^{\mathsf T}\psi$, and even for isotropic $E_c$ ($A_c=\tfrac{2p}nI$) this is $\tfrac{2p}n\lvert h\rvert^2$, so $\tfrac a\theta\cdot\tfrac{2p}n=O(1)$ in the band. **Their difference cancels in the full trace under symmetry**: if an isometry of $\mathbb R^n$ swaps $E_0$ and $E_2$ by conjugation, it maps $\{h_{uv}\}$ to itself ($h_{uv}=h_{vu}$) and $Q_0$ to $Q_2$, so $\sum_{u,v}\big(Q_2-Q_0\big)(h_{uv})=0$. *The trace reduction restricts to the certificate's positive space $V_+$, which that symmetry does not preserve ($V_+$ lives on $P_0C$, the $E_0$ side), so the cancellation available is in the whole-family trace, the object [F76](../findings/fence-posts.md) closed, and not in $\mathop{\mathrm{tr}}_{V_+}$.* **So the corrections on the band need either a $V_+$-adapted cancellation or a certificate space that is swap-symmetric.** Algebra on the record's identities; no computation.

> **Ricci-flatness turns the Ricci correction into a difference of commutator masses.** For any $\psi$ and $h$, $\mathop{\mathrm{tr}}(\psi h\psi h)=\tfrac12\mathop{\mathrm{tr}}([\psi,h]^2)+\mathop{\mathrm{tr}}(\psi^2h^2)$ (typed: `trace_psi_h` in [ClassTraceTest.lean](../lean/HamiltonsCubic/Results/ClassTraceTest.lean)). For skew $\psi$ and symmetric $h$, $[\psi,h]$ is symmetric, so summing over an eigenspace gives $Q_c(h)=\tfrac12C_c(h)-\mathop{\mathrm{tr}}(A_ch^2)$ with $C_c(h)=\sum_{\psi\in E_c}\lVert[\psi,h]\rVert_F^2$ and $A_c=\sum_{\psi\in E_c}\psi\psi^{\mathsf T}$. **The Weyl tensor is Ricci-flat, and its Ricci contraction is $\sum_\psi\lambda_\psi\psi\psi^{\mathsf T}$, so on the symmetric family $a(A_2-A_0)=0$, i.e. $A_0=A_2$ exactly.** Hence
> $$\langle h,\mathring eh\rangle=\frac a{2\theta}\big(C_2(h)-C_0(h)\big),$$
> **a difference of the commutator masses of $h$ against the two extreme eigenspaces**, with no $\mathop{\mathrm{tr}}(Ah^2)$ term. *Each $C_c(h)$ is at most the full Casimir mass $\sum_{\text{all }\psi}\lVert[\psi,h]\rVert^2$, which is of order $n\lvert h\rvert^2$, so the bound is still $O(n/\kappa)=O(1)$ in the band; what the identity adds is that the correction is antisymmetric under $E_0\leftrightarrow E_2$ pointwise in $h$, and vanishes on any $h$ whose commutator mass splits evenly between the two.* Derivation; the trace identity typed.
> 

## Givens

- $W=\sum_\psi\lambda_\psi\,\psi\otimes\psi$ on $\Lambda^2=\mathfrak{so}(n)$ over an orthonormal eigenbasis ($\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}X^{\mathsf T}Y$), $W$ an algebraic Weyl tensor (Ricci-flat, first Bianchi). Symmetric family: $\lambda=(-a,0,a)$ on $E_0,E_1,E_2$, $e=W/\theta=\tfrac a\theta(P_2-P_0)$.
- The record's identity $\sum_c\lambda_cQ_c(h)=\mathring W(h,h)$ with $Q_c(h)=\sum_{\psi\in E_c}\mathop{\mathrm{tr}}(\psi h\psi h)$ (working file, "Criticality on symmetric directions").

## Lean

| claim | declaration |
|---|---|
| $\mathop{\mathrm{tr}}(\psi h\psi h)=\tfrac12\mathop{\mathrm{tr}}([\psi,h]^2)+\mathop{\mathrm{tr}}(\psi^2h^2)$ | `trace_psi_h` in [ClassTraceTest.lean](../lean/HamiltonsCubic/Results/ClassTraceTest.lean) |
| the Ricci contraction of $W$ is $\sum_\psi\lambda_\psi\psi\psi^{\mathsf T}$ (up to a constant), hence $A_0=A_2$ | none: the layer's Weyl objects are not tied to an eigenbasis expansion |
| the swap cancellation, and $\langle h,\mathring eh\rangle=\tfrac a{2\theta}(C_2-C_0)$ | none, same reason |

## Items

1. Is the Ricci contraction of $W=\sum\lambda_\psi\psi\otimes\psi$ proportional to $\sum_\psi\lambda_\psi\psi\psi^{\mathsf T}$ (check signs and the normalisation), so that Ricci-flatness gives $A_0=A_2$ on the symmetric family?
2. Does $Q_c(h)=\tfrac12C_c(h)-\mathop{\mathrm{tr}}(A_ch^2)$ follow for skew $\psi$, symmetric $h$ (check $[\psi,h]$ symmetric and $\psi^2=-\psi\psi^{\mathsf T}$), and hence $\langle h,\mathring eh\rangle=\tfrac a{2\theta}(C_2-C_0)$ via the record's identity (check which $\mathring W$ convention the identity uses)?
3. The swap paragraph: is the whole-family cancellation right, and is "$V_+$ does not preserve the swap" a correct reading of the certificate?
4. Is any conclusion stated beyond these (the $O(n/\kappa)$ size, "vanishes on any $h$ whose commutator mass splits evenly")?

## Protocol

Reviewer N (1159 or 1160) logs to `agent_logs/rN.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_rN.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md` or any other file; do not read the other reviewer's report or log. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
