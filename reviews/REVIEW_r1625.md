# REVIEW r1625: commits 0c0bb911 and 9b97c139, L120's pair summand dimension and its full-sign-group characterisation

**Verdict: CONFIRMED.** The pair summand's dimension $n-3$ and its two-sided characterisation at the full sign group $\Gamma$ are proved as stated, on the standard three axioms, and r1624's three gaps are closed. Two cosmetic notes below carry no mathematical content.

Reviewer: cold adversarial Gate 2, analysis-only footing. Runs made, both screens on objects in hand: `lake build HamiltonsCubic.Results.L120PairSign` (which builds L120PairDim, exit 0) and `scripts/misc/axiom_audit.py --only` on each file.

## Claim table

| Claim | Where | Verdict |
|---|---|---|
| `pairLin_apply`, the unfolding of `pairLin` as $\sum_{i\notin\{j,k\}}c_i\,\mathrm{rk2}(\varphi_{ji},\varphi_{ki})$ | [L120PairDim.lean:24](../lean/HamiltonsCubic/Results/L120PairDim.lean#L24) | CONFIRMED |
| `pairMap`, $c\mapsto$ `pairLin j k c ∘ₗ skewProj`, linear in $c$ | [L120PairDim.lean:28](../lean/HamiltonsCubic/Results/L120PairDim.lean#L28) | CONFIRMED |
| `pairSummand_mem`: the image of `ker (blockSums1 s)` is exactly the flip-isotypic members of `weylModuleS` | [L120PairDim.lean:41](../lean/HamiltonsCubic/Results/L120PairDim.lean#L41) | CONFIRMED |
| `pairSummand_finrank`: that image has finrank $n-3$ at $n\ge3$ | [L120PairDim.lean:62](../lean/HamiltonsCubic/Results/L120PairDim.lean#L62) | CONFIRMED (note 1) |
| `rot_sign`, `coord_sign`: $\operatorname{diag}(\varepsilon)$ rescales $R_{abcd}$ by $\varepsilon_a\varepsilon_b\varepsilon_c\varepsilon_d$ | [L120PairSign.lean:27](../lean/HamiltonsCubic/Results/L120PairSign.lean#L27), [L120PairSign.lean:40](../lean/HamiltonsCubic/Results/L120PairSign.lean#L40) | CONFIRMED |
| `pairForm_parity_sign`: a `PairForm` position carries $\varepsilon_j\varepsilon_k$ at $\varepsilon_y^2=1$ | [L120PairSign.lean:48](../lean/HamiltonsCubic/Results/L120PairSign.lean#L48) | CONFIRMED |
| `pairS_iso_signMat`: the pair-span operator on the cut is $\Gamma$-isotypic with character $\varepsilon_j\varepsilon_k$ | [L120PairSign.lean:59](../lean/HamiltonsCubic/Results/L120PairSign.lean#L59) | CONFIRMED |
| `pairSummand_mem_signMat`: image of the cut = $\Gamma$-isotypic members of `weylModuleS`, both directions | [L120PairSign.lean:74](../lean/HamiltonsCubic/Results/L120PairSign.lean#L74) | CONFIRMED |
| INDEX L120 row, file column and wording | [INDEX.md:475](../lean/INDEX.md#L475) | CONFIRMED |
| L127WTop.lean header, r1624 gap 3 | [L127WTop.lean:20](../lean/HamiltonsCubic/Results/L127WTop.lean#L20) | CONFIRMED |
| Axiom audit, L120PairDim.lean | 3/3 on the standard three | CONFIRMED |
| Axiom audit, L120PairSign.lean | 5/5 on the standard three | CONFIRMED |

## Checks, and the object that would break each claim

- **The coefficient space is the Ricci cut.** The breaking object is a `blockSums1` whose kernel is something other than "vanishing off $s$, zero sum on $s$". [mem_ker_blockSums1](../lean/HamiltonsCubic/Results/L127Dim.lean#L46) states exactly $(\forall i\notin A,\ c_i=0)\wedge\sum_{i\in A}c_i=0$, and `blockSums1 A` is $c\mapsto(c|_{A^c},\sum_A c)$ ([L127Dim.lean:39](../lean/HamiltonsCubic/Results/L127Dim.lean#L39)). With $s=\{i: j\ne i,\ k\ne i\}$ this is the record's Ricci cut on $n-2$ coordinates.
- **The off-$s$ vanishing is only for injectivity.** `pairLin` sums over $s$ alone, so the image depends only on $c|_s$ and the forward direction of `pairSummand_mem` uses only the zero-sum half (`hc.2`). The converse builds $c_y=R_{jyky}$ and discharges $c_j=0$ by `cd_self12` ($R_{jjkj}=0$) and $c_k=0$ by `cd_self34` ($R_{jkkk}=0$), both antisymmetry. So the image is the pair span of the cut, with no extra freedom from $c_j,c_k$.
- **Injectivity.** The breaking object is a nonzero cut vector $c$ with `pairMap j k c = 0`. For $y\in s$ the coordinate $(j,y,k,y)$ of `pairMap j k c` is $c_y$ by `coord_pairS_diag` (confirmed in r1624), and off $s$ both vectors vanish by the kernel condition, so equal images force equal vectors. The proof passes through `coord` of the composite with `skewProj`, the same form `coord_pairS_diag` is stated for, and the kernel accepts the `change`.
- **The count and the hypothesis $n\ge3$.** `pairIdx_card` gives $|s|+2=n$, `finrank_ker_blockSums1` gives $|s|-1$ at $s$ nonempty, and `finrank_range_of_inj` transports it, so $n-3$. $n\ge3$ is exactly what makes $s$ nonempty. At $n=3$ the statement gives $0$, correct since $|s|=1$ and the cut is $\{0\}$ (and $\mathcal W_3=0$). At $n=2$, the only other case admitting $j\ne k$, $s=\varnothing$, the kernel is $\{0\}$ and $n-3=0$ in `ℕ`, so the conclusion is still true there (note 1).
- **The sign-matrix law.** The breaking object is a convention in `act` under which $\operatorname{diag}(\varepsilon)$ scales $R_{abcd}$ by something other than $\varepsilon_a\varepsilon_b\varepsilon_c\varepsilon_d$. `rot_sign` computes $\operatorname{diag}(\varepsilon)^T\varphi_{ij}\operatorname{diag}(\varepsilon)=\varepsilon_i\varepsilon_j\varphi_{ij}$ entrywise through `rot_phi`, the same route as `rot_flip` ([WeylInvariantZero.lean:64](../lean/HamiltonsCubic/Results/WeylInvariantZero.lean#L64)), and `coord_sign` pulls the two scalars out of `inner2` on each side. No hypothesis on $\varepsilon$ is needed there, correctly, since it is a pure rescaling identity.
- **The parity on a `PairForm` position.** A `PairForm` position has $\{a,b\}=\{j,y\}$ and $\{c,d\}=\{k,y\}$ (or swapped), so the product is $\varepsilon_j\varepsilon_k\varepsilon_y^2$. The eight orderings are closed by `linear_combination (ε j * ε k) * hy`, which is that identity.
- **`pairS_iso_signMat` is the full-group converse.** It compares coordinates through `eq_of_coord`, which needs both sides in `weylModuleS`: the left by `act_mem` with `signMat_orth`, the right by `smul_mem`. At a zero coordinate both sides vanish, and at a nonzero one `iso_coord_form` (from flip isotypy, `pairS_iso`) places it at a `PairForm` position, where the factor is $\varepsilon_j\varepsilon_k$. This argues through coordinates rather than through "flips generate $\Gamma$", and it is complete.
- **`pairSummand_mem_signMat` is two-sided at $\Gamma$.** Forward is `pairS_mem` plus `pairS_iso_signMat`. Backward specialises $\varepsilon=$ `sgn m`, using `sgn_mul_self`, and relies on `flip m` and `signMat (sgn m)` being definitionally the same diagonal matrix, which the kernel accepted. The hypothesis $\forall i,\ \varepsilon_i\varepsilon_i=1$ over real $\varepsilon$ is exactly $\varepsilon_i=\pm1$, so the quantifier ranges over $\Gamma$ and nothing larger. This is the bundled `iff` r1624 gap 1 asked for.
- **The INDEX row.** The file column now lists L120, L120Dim, L120Block, L120Pair, L120PairDim and L120PairSign, closing r1624 gap 2. The text says the flip-level converse is `pairS_mem` and `pairS_iso` and the $\Gamma$-level one is L120PairSign's, which matches the files, and it keeps the four-set summand and $\mathcal D_n$ as owed. The dimension sentence names `pairSummand_mem` as the flip form and `pairSummand_finrank` with $n\ge3$, as stated.
- **L127WTop.lean header.** The splice at line 20 is now two sentences, closing r1624 gap 3. The change is comment-only.

## Notes, not gaps

1. **The hypothesis $n\ge3$ in `pairSummand_finrank` ([L120PairDim.lean:62](../lean/HamiltonsCubic/Results/L120PairDim.lean#L62)) is sufficient and harmless, and the conclusion also holds at $n=2$ by truncated subtraction.** It is used only to make $s$ nonempty for `finrank_ker_blockSums1`. Nothing depends on dropping it, and $n\ge3$ is the range where the record's count means anything.
2. **Two unused simp arguments** at [L120PairSign.lean:31](../lean/HamiltonsCubic/Results/L120PairSign.lean#L31) and [L120PairSign.lean:32](../lean/HamiltonsCubic/Results/L120PairSign.lean#L32) (linter warnings in the build). The unused-variable warnings in L120Pair.lean noted in r1624 remain.

## Summary

L120's pair summand is the Ricci-cut pair span, of dimension $n-3$ at $n\ge3$, and is characterised by $\Gamma$-isotypy with character $\varepsilon_j\varepsilon_k$ in both directions, 3/3 and 5/5 on the standard three. r1624's three gaps are closed.
