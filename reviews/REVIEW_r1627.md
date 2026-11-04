# REVIEW r1627: commit 479c4759, L120's trivial summand (L120Diag.lean, L120DiagDim.lean)

**Verdict: CONFIRMED.** The trivial summand is identified with the record's $\mathcal D_n$ (conventions.md: symmetric, hollow, $S\mathbf 1=0$) through `IsWeight`, which is exactly those three conditions, and the identification is two-sided at the full sign group $\Gamma$. The dimension $\binom n2-n$ at $n\ge3$ is correct, and the row-sum preimage checks by hand. Two cosmetic notes carry no mathematical content.

Reviewer: cold adversarial Gate 2, analysis-only footing. One run, a screen on objects in hand: `scripts/misc/axiom_audit.py --only L120Diag`, which matched both files, 16/16 declarations on the standard three axioms. Neither file contains `sorry` or `native_decide`.

## Claim table

| Claim | Where | Verdict |
|---|---|---|
| `diagS`, `diagS_mem`: $\mathop{\mathrm{diagOp}}w\circ\mathrm{skew}$ lies in `weylModuleS` at every weight | [L120Diag.lean:30](../lean/HamiltonsCubic/Results/L120Diag.lean#L30), [L120Diag.lean:33](../lean/HamiltonsCubic/Results/L120Diag.lean#L33) | CONFIRMED |
| `diagS_phi`, `coord_diagS`: $\varphi_{ij}\mapsto w_{ij}\varphi_{ij}$ at symmetric $w$ | [L120Diag.lean:37](../lean/HamiltonsCubic/Results/L120Diag.lean#L37), [L120Diag.lean:47](../lean/HamiltonsCubic/Results/L120Diag.lean#L47) | CONFIRMED |
| `diagWeight_isWeight`: $w_{ij}=R_{ijij}$ is symmetric, hollow, zero row sums | [L120Diag.lean:56](../lean/HamiltonsCubic/Results/L120Diag.lean#L56) | CONFIRMED |
| `diag_isotypic`: flip-fixed Weyl $R$ equals `diagS (diagWeight R)` | [L120Diag.lean:65](../lean/HamiltonsCubic/Results/L120Diag.lean#L65) | CONFIRMED |
| `diagS_signMat`, `diagS_flip` | [L120Diag.lean:84](../lean/HamiltonsCubic/Results/L120Diag.lean#L84), [L120Diag.lean:97](../lean/HamiltonsCubic/Results/L120Diag.lean#L97) | CONFIRMED |
| `diagSummand_iff`: $\Gamma$-fixed in `weylModuleS` iff diagonal operator of a weight | [L120Diag.lean:102](../lean/HamiltonsCubic/Results/L120Diag.lean#L102) | CONFIRMED |
| `symHollow`, `toOff`, `toOff_bij`, `finrank_symHollow` $=\binom n2$ | [L120DiagDim.lean:29](../lean/HamiltonsCubic/Results/L120DiagDim.lean#L29), [L120DiagDim.lean:47](../lean/HamiltonsCubic/Results/L120DiagDim.lean#L47), [L120DiagDim.lean:73](../lean/HamiltonsCubic/Results/L120DiagDim.lean#L73) | CONFIRMED |
| `rowSumL`, `rowSumL_surj` at $n\ge3$ | [L120DiagDim.lean:78](../lean/HamiltonsCubic/Results/L120DiagDim.lean#L78), [L120DiagDim.lean:84](../lean/HamiltonsCubic/Results/L120DiagDim.lean#L84) | CONFIRMED |
| `finrank_weights` $=\binom n2-n$, `isWeight_of_ker` | [L120DiagDim.lean:115](../lean/HamiltonsCubic/Results/L120DiagDim.lean#L115), [L120DiagDim.lean:123](../lean/HamiltonsCubic/Results/L120DiagDim.lean#L123) | CONFIRMED |
| `weightOp`, `diagSummand_mem`: range = $\Gamma$-fixed members of `weylModuleS` | [L120DiagDim.lean:129](../lean/HamiltonsCubic/Results/L120DiagDim.lean#L129), [L120DiagDim.lean:142](../lean/HamiltonsCubic/Results/L120DiagDim.lean#L142) | CONFIRMED |
| `diagSummand_finrank` (injectivity), `two_mul_choose_two_sub` | [L120DiagDim.lean:154](../lean/HamiltonsCubic/Results/L120DiagDim.lean#L154), [L120DiagDim.lean:172](../lean/HamiltonsCubic/Results/L120DiagDim.lean#L172) | CONFIRMED (note 2) |
| INDEX L120 row, new text and stated debt | [INDEX.md:475](../lean/INDEX.md#L475) | CONFIRMED |
| Axiom audit, both files | 16/16 on the standard three | CONFIRMED |

## Checks, and the object that would break each claim

- **Faithfulness of $\mathcal D_n$.** The breaking object is a record definition of $\mathcal D_n$ with a condition `IsWeight` lacks or adds. [conventions.md](../findings/conventions.md) defines $\mathcal D_n=\{S$ symmetric, hollow, $S\mathbf 1=0\}$, and `IsWeight` in [Families.lean:153](../lean/HamiltonsCubic/Base/Families.lean#L153) is `symm`, `hollow`, `rowSum`, the same three. `diagOp` is the Hadamard product, which acts on $\varphi_{ab}$ as $w_{ab}\varphi_{ab}$ at symmetric $w$ (checked by hand: $(\varphi_{ab})_{pq}$ is supported at $(a,b)$ and $(b,a)$, where $w$ takes the one value $w_{ab}$). The record's "trivial character" is the $\Gamma$-fixed subspace of $\mathcal W_n$, and `weylModuleS` is the record's $\mathcal W_n$. So `diagSummand_mem` is the claim as printed.
- **`diag_isotypic`.** The breaking object is a flip-fixed Weyl coordinate outside the positions $(a,b,a,b)$, $(a,b,b,a)$. `coord_reduce_flip` kills every other coordinate by an odd-index flip. At $(a,b,b,a)$ with $a\ne b$ the target is $-w_{ab}$ and `cd_sw34` gives $R_{abba}=-R_{abab}$. At $a=b$ both sides vanish by `cd_self12`. The case split is exhaustive.
- **Converse at the whole group.** The breaking object is a sign vector $\varepsilon$ that moves $\mathop{\mathrm{diagOp}}w$. The only nonzero coordinates carry $\varepsilon_a\varepsilon_b\varepsilon_a\varepsilon_b$ or $\varepsilon_a\varepsilon_b\varepsilon_b\varepsilon_a$, both $1$ under $\varepsilon_i^2=1$. The hypothesis `∀ i, ε i * ε i = 1` over $\mathbb R$ is exactly $\varepsilon_i=\pm1$.
- **`rowSumL_surj`, by hand.** With $N=n$, $w_{ab}=(v_a+v_b)/(N-2)-S/((N-1)(N-2))$ off the diagonal, row $a$ sums over the $N-1$ indices $c\ne a$ to $\big((N-1)v_a+S-v_a\big)/(N-2)-(N-1)S/((N-1)(N-2))=v_a+S/(N-2)-S/(N-2)=v_a$. Correct.
- **Is $n\ge3$ needed and sufficient?** The breaking objects are $n=3$ and $n=2$. At $n=3$ the map $(w_{12},w_{13},w_{23})\mapsto$ row sums has matrix $\begin{pmatrix}1&1&0\\1&0&1\\0&1&1\end{pmatrix}$ with determinant $-2$, so it is onto, and the formula has $N-2=1$, $N-1=2$, both nonzero. The weight space is then $0$, matching $3\cdot0/2$. At $n=2$ the one entry $w_{12}$ gives equal row sums, so $(1,0)$ has no preimage and the hypothesis cannot be lowered. Sufficient and necessary for surjectivity in the range that matters.
- **`toOff_bij`.** The breaking object is a symmetric hollow matrix not determined by its off-diagonal unordered-pair values, or a function on pairs with no hollow symmetric lift. Injectivity uses hollowness on the diagonal and `s(a,b)` off it; surjectivity lifts with `Sym2.eq_swap` for symmetry. `Sym2.card_subtype_not_diag` gives $\binom n2$.
- **Injectivity of `weightOp`.** The breaking object is two distinct weights with the same operator. Reading `coord _ a b a b` returns $w_{ab}$ at $a\ne b$, and hollowness fixes the diagonal.
- **`two_mul_choose_two_sub`.** Checked at $n=3,4,5$: $2(3-3)=0$, $2(6-4)=4=4\cdot1$, $2(10-5)=10=5\cdot2$. Natural subtraction is safe since $\binom n2\ge n$ at $n\ge3$.
- **INDEX row.** The breaking object is a sentence asserting the decomposition of $\mathcal W_n$. The row states the three summands are identified with their dimensions and keeps "the three summands together are all of $\mathcal W_n$" as **Owed**, with `L120_dim_sum` described as arithmetic only. No overclaim found.

## Notes (cosmetic)

1. [L120Diag.lean:20](../lean/HamiltonsCubic/Results/L120Diag.lean#L20) still lists the dimension $n(n-3)/2$ as *Owed*. The same commit discharges it in L120DiagDim.lean, so the docstring line is stale and should point to `diagSummand_finrank`.
2. The printed $n(n-3)/2$ is reached as two lemmas, `diagSummand_finrank` giving $\binom n2-n$ and `two_mul_choose_two_sub` giving twice that as $n(n-3)$. No single theorem states `finrank = n * (n - 3) / 2`. The composition is one line and the INDEX row describes it accurately, so this is presentation only.

## Screen disclosure

The axiom audit ran while another session's `lake env lean` on a scratch file was live. The audit reported 16/16 declarations across 2 files, which is every theorem in the two files (8 each), so the result is complete.
