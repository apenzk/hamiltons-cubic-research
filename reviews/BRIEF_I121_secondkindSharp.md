# Gate 2 brief (one reader): SecondKindSharp.lean, the record's sharp frame constant in the second-kind bound on E

**This round compares a complete Lean proof against its prose claim, so it has one reader.** Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: read, compare and derive; compute only to check a value, the smallest computation that does it (seconds). No sweeps.

## The claim

[bispectral.md](../findings/bispectral.md) carries, frame by frame and Gate 2 passed (r555, r556): at the bottom eigenvector $h$ of $\mathring W$, $\mu=v^{\mathsf T}K^Fv\le\mu_1(K^F)\le\sqrt{t_F(n-2)/(n-1)}$, with $t_F=\lVert K^F\rVert_F^2$, using $K^F\mathbf1=0$. [The working note](2026-09-28d-I121-smallmass-direct.md)'s section "$E$ is the second-kind cubic" now states that this cap, read at $t_F\le2t_{\max}^2$, is typed in `lean/HamiltonsCubic/Results/SecondKindSharp.lean` (commit `66302ece`) as `E_le_tmax_sharp`: $E\le\tfrac32\sqrt{2(n-2)/(n-1)}\,t\,\lVert W\rVert^2$ at a Ricci-flat operator whose frames all have $\sum_{p,q}K_{pq}^2\le2t^2$. The hollow-only version in `SecondKindE.lean` (Gate 2 [r1861](REVIEW_r1861.md)) has $\sqrt{2(n-1)/n}$.

## Items

1. **Statement fidelity.** Is each declaration the claim its docstring names? `vertex_quad_sq_le` (hollow $K$, zero row sums, $\sum e=0$ give $(e^{\mathsf T}Ke)^2\le\lVert K\rVert_F^2\tfrac{n-2}{n-1}(\sum e^2)^2$); `rowsum_secK`; `ringW_sub_smul_one`, `frob_ringW_traceless`, `frob_traceless_le`; `neg_frob_ringW_le_traceless`, `neg_frob_ringW_le_sharp`; `E_le_tmax_sharp`. In particular: is the Ricci-flat hypothesis the record's (`Ric R a b = 0` for all $a,b$), and is $n>1$ the only size hypothesis needed?
2. **The prose follows the Lean.** Does the Cauchy–Schwarz against $ee^{\mathsf T}-c(I-J/n)$ at $c=\sum e^2/(n-1)$ give exactly $\tfrac{n-2}{n-1}$, and is the trace-free reduction (replace $h$ by $h-\tfrac{\operatorname{tr}h}n I$) valid at a Ricci-flat operator?
3. **Agreement with the record's cap.** Is `E_le_tmax_sharp` the record's cap from bispectral.md read at $t_F\le2t_{\max}^2$, and not something weaker or stronger?
4. **Axioms.** The audit script reported "8/8 clean -- resting on the standard three alone" on `SecondKindSharp`. Cite it, or rerun `python3 scripts/misc/axiom_audit.py --only SecondKindSharp` if the toolchain is free (check `pgrep -f '\.elan/toolchains/[^ ]*/bin/(lake (build|env|exe)|lean /)'` first, background it, and do not wait more than ten minutes).

## Lean table

| claim | declaration |
|---|---|
| vertex-space Cauchy–Schwarz | `vertex_quad_sq_le` |
| zero row sums of every frame's sectional matrix | `rowsum_secK` |
| trace-free reduction | `ringW_sub_smul_one`, `frob_ringW_traceless`, `frob_traceless_le` |
| the sharp frame step | `neg_frob_ringW_le_traceless`, `neg_frob_ringW_le_sharp` |
| the bound on $E$ | `E_le_tmax_sharp` |
