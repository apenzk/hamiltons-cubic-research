# Review r1487: one-sided second-order expansions in Lean, and the repair of r1486's gaps

Gate 2 review of commit d4052186, which adds [Base/Exp2.lean](../lean/HamiltonsCubic/Base/Exp2.lean) (`Exp2`, its closure lemmas, `exp2_rot`, `exp2_rot_sq`, `M2`, `exp2_conj`) and marks milestone 3 of the [second-order plan](2026-09-26-lean-second-order-plan.md), and of commit 1baa4348, which repairs [r1486](REVIEW_r1486.md)'s gaps C-1 and C-2. One reviewer. Analysis-only rule inherited: the only compute was the module build (8713 jobs, no error) and `#print axioms` on a scratch file under `/private/tmp`, since deleted.

| item | claim | verdict |
| --- | --- | --- |
| A | `Exp2 f a b c` is $f(t)=a+tb+t^2c+o(t^2)$ as $t\to0^+$, `Exp2.mul`'s coefficients are right in a noncommutative algebra, `exp2_rot` and `exp2_rot_sq` are right | CONFIRMED |
| B | the $t$ and $t^2$ coefficients of $e^{-t^2K_2}e^{-tK}(u+tH+t^2G)e^{tK}e^{t^2K_2}$ are $H-[K,u]$ and $M_2-[K_2,u]$ | CONFIRMED |
| C | every exact "codim $=186$" and "89% of directions" claim is gone or reads $\le186$, and the corrected mathematics is right | CONFIRMED WITH GAP |
| D | every declaration of Exp2.lean rests on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | plan milestone 3, the L134 row's pointer, the docstrings, punctuation | CONFIRMED WITH GAP |

**Summary: the Lean is correct and kernel-checked, and $M_2$ is right by hand, but the sweep missed two places that still read the dimension ratio as a share of directions (L17.lean lines 18 to 20 and 42 to 43, findings/LEDGER.md line 446), and one unused simp argument survives in Exp2.lean line 151. CONFIRMED WITH GAP.**

## A. The expansion calculus

- **The definition** (Exp2.lean line 21) is `(fun t => f t - (a + t • b + t ^ 2 • c)) =o[𝓝[Set.Ici 0] 0] fun t => t ^ 2`, which is $f(t)=a+tb+t^2c+o(t^2)$ along $t\to0$, $t\ge0$. **Correct.** *A precision remark, not a gap*: the filter $𝓝[\mathrm{Ici}\,0]\,0$ contains the point $0$, so the little-o forces $f(0)=a$ exactly. Every use in the build has $f(0)=a$ ($W(0)=u$, $\exp(0)=1$), so nothing is lost, and $0$ is a limit point of $[0,\infty)$, so the coefficients are determined by $f$.
- **`Exp2.mul`** (line 55). $(a+tb+t^2c)(a'+tb'+t^2c')=aa'+t(ab'+ba')+t^2(ac'+bb'+ca')+t^3(bc'+cb')+t^4cc'$, with every product kept in its order, so the coefficients $aa'$, $ab'+ba'$, $ac'+bb'+ca'$ hold in any associative algebra. The proof splits $fg-P$ as $(f-p)g+p(g-q)+(pq-P)$, the first two $o(t^2)$ by `IsLittleO.mul_isBigO` against `Exp2.isBigO_one` and `poly_isBigO_one`, and $pq-P=t^3(bc'+cb'+t\,cc')$, which is the `hv`/`h3` term. The closing `module` checks the identity exactly. **Correct.**
- **`exp2_rot`** (line 98): `rot K t` is `NormedSpace.exp (t • K)` ([BlockRotation.lean](../lean/HamiltonsCubic/Base/BlockRotation.lean) line 26), and composing `exp_sub_quadratic_isBigO` with $t\mapsto tK$ gives a remainder $O(\lVert tK\rVert^3)=O(t^3)=o(t^2)$ (`cube_norm_isLittleO`). The quadratic term $\tfrac12(tK)(tK)=t^2\cdot\tfrac12K^2$. **Correct.**
- **`exp2_rot_sq`** (line 109): at $y=t^2K$ the quadratic term $\tfrac12t^4K^2$ is $o(t^2)$ (`hq`) and the remainder $O(t^6)$ is too (`hc`), leaving $1+t^2K$, so the coefficients $(1,0,K)$ are right. **Correct.**
- `Exp2.add`, `Exp2.sub`, `Exp2.smul`, `Exp2.const`, `Exp2.congr` state the expected closure facts. **Correct.**

## B. The rotated path, by hand

Write $e^{\pm tK}=1\pm tK+\tfrac{t^2}2K^2+o(t^2)$ and $W=u+tH+t^2G+o(t^2)$.

- **Inner conjugation** $e^{-tK}We^{tK}$. Order $t$: $H-Ku+uK=H-[K,u]$. Order $t^2$: $G$ from $W$ alone, $-KH+HK$ from one $t$ factor on each of two sides, $\tfrac12K^2u$ and $\tfrac12uK^2$ from the quadratic terms, and $(-K)u(K)=-KuK$ from the two linear terms of the outer factors. Total $G-(KH-HK)+\tfrac12K^2u+\tfrac12uK^2-KuK$, which is `M2 K u H G` (line 135) term for term.
- **Outer conjugation** by $e^{\mp t^2K_2}=1\mp t^2K_2+o(t^2)$ adds $-K_2u+uK_2=-[K_2,u]$ at order $t^2$. Cross terms between $K_2$ and $K$ or $H$ are $O(t^3)$. So the $t^2$ coefficient is $M_2-[K_2,u]$, and the $t$ coefficient stays $H-[K,u]$.
- **The Lean statement** (line 140) is exactly this, with the left factor `rot (-K₂) (t ^ 2) * rot (-K) t` $=e^{-t^2K_2}e^{-tK}$ and the right `rot K t * rot K₂ (t ^ 2)` $=e^{tK}e^{t^2K_2}$, and the proof composes `Exp2.mul` three times and closes the coefficient identity by `module`. **CONFIRMED.**
- *A precision remark, not a gap*: the docstring calls the left factor $R(t)^*$. It is $R(t)^{-1}$, which equals $R(t)^*$ when $K$ and $K_2$ are skew-adjoint, as the generators of milestone 3 will be. The theorem needs no skewness and states the inverse, which is the conjugation the build uses.

## C. The r1486 sweep

- **The mathematics is right.** $u$ is nonzero only on the three self-dual bivectors of the $\mathbb{CP}^2$ factor, so at $n=12$ $\dim\ker u=66-3=63$ with the anti-self-dual span ($\dim3$) inside it. The conditions $\Pi_{ASD}H\Pi_{\ker u}=0$ on symmetric $H$ are $3\cdot60+6=186$ linear functionals, the $3\times3$ corner counting $6$. The common kernel of $186$ functionals has codimension at most $186$ in any subspace, $\mathcal W_{12}\cap T_uS$ included, with equality only if they are independent there, which is not shown. $\dim\mathcal W_{12}=12\cdot13\cdot14\cdot9/12=1638$, so $\dim T_uS=1637$ and $\dim\{F=0\}\ge1451$. Properness holds by `Wb_F_pos`, so $\{F=0\}$ is measure zero among directions.
- **The named files now read correctly.**
  - [route-a.md](../findings/route-a.md) line 73: heading "AND THE CONE IS A LARGE PROPER SUBSPACE", with $\le186$ and "at least $1451$". It agrees with line 93. **C-1 repaired.**
  - [results.md](../results.md) line 1085: "of codimension at most $186$ at $n=12$ (the count of those conditions)", and the "dimension ratio $1451/1637$" clause is removed. Correct.
  - [L17Statement.lean](../lean/HamiltonsCubic/Results/L17Statement.lean) lines 204 to 210: both docstrings say $\le186$ and $\dim\ge1451$. `equality_set_dimensions` is unchanged and true.
  - [L17.lean](../lean/HamiltonsCubic/Results/L17.lean) line 15: "a linear subspace of codimension at most `186` at `n = 12`, a proper subspace and so measure zero among directions". Correct.
  - [lean/INDEX.md](../lean/INDEX.md) line 479: "$\dim\{F=0\}\ge1451$ of $1637$", and "That share is not the subspace's". Correct.
  - [INDEX-results.md](../findings/INDEX-results.md) line 32: "of codimension at most $186$". Correct.
- **Gap C-a, L17.lean still reads the ratio as a share of directions, two lines below the correction.**
  - Lines 18 to 20: "**`8/9` is `88.9%`**, so the reported figure and the natural fraction agree to the digit given which is what makes the gap between "three families" and the subspace quantitative rather than rhetorical." This presents the $\sim89\%$ as a meaningful size of the subspace, which line 16 of the same header now calls measure zero.
  - Lines 42 to 43, `complement`'s docstring: "so the subspace misses about `11%` of directions, a majority statement, which three families could not supply." This is the refuted "89% of directions" reading restated as its complement. The theorems (`eight_ninths_bracket`, `complement`, `complement_share`) are arithmetic and true. The docstrings need to say that $8/9$ matches the record's printed figure only, and that the subspace is measure zero among directions, as the L17 row of lean/INDEX.md already does.
- **Gap C-b, findings/LEDGER.md line 446 was not swept.** The L17 entry of the open-gaps ledger reads "holding at least $1451$ of $T_uS$'s $1637$ dimensions at $n=12$, **about $89\%$ of directions carry equality rather than strict inequality**". The file is outside the list this review was asked to check, but it is a live record and the commit title says the correction was "swept to every record that stated it". ATTEMPTS.md line 5105 and the verification/ files mention the reading only to reject it or as historical round text, and are fine.

## D. Axioms

`#print axioms` on all fifteen declarations of Exp2.lean (`Exp2`, `cube_isLittleO`, `poly_isBigO_one`, `Exp2.isBigO_one`, `Exp2.add`, `Exp2.sub`, `Exp2.smul`, `Exp2.mul`, `Exp2.const`, `Exp2.congr`, `cube_norm_isLittleO`, `exp2_rot`, `exp2_rot_sq`, `M2`, `exp2_conj`): every one reports `[propext, Classical.choice, Quot.sound]`. No `sorryAx`, no `Lean.ofReduceBool`. The scratch file is deleted. **CONFIRMED.**

## E. Record accuracy

- **Plan milestone 3** ([second-order plan](2026-09-26-lean-second-order-plan.md) line 11) marks as proved the calculus, `exp2_rot`, `exp2_rot_sq` and `exp2_conj`, with the choice of block-diagonalising generators from [Schur.lean](../lean/HamiltonsCubic/Base/Schur.lean) listed as owed. That is exactly what Exp2.lean holds. Accurate.
- **Plan milestone 1** now names $C=2\lVert B\rVert_{HS}^2+2\lVert B_2\rVert_{HS}^2$ and the cap $t_0\le1$, matching `specFn_blk_family` as r1486 read it. Accurate.
- **The L134 row** of [lean/INDEX.md](../lean/INDEX.md) now says item (b)'s Rellich route is replaced by the plan, "with its milestone 1 and the rotated path's expansion proved in" SecondOrder.lean and Exp2.lean. Both links resolve from lean/, and the claim matches milestones 1 and 3. Accurate.
- **SecondOrder.lean's docstring** now states `hsSq_add_le` as $\mathrm{hsSq}(X+Y)\le2\,\mathrm{hsSq}\,X+2\,\mathrm{hsSq}\,Y$ and `hsSq_smul` as $\mathrm{hsSq}(cX)=c^2\,\mathrm{hsSq}\,X$. Accurate.
- **Exp2.lean's module docstring** (lines 9 to 11) names `Exp2.add`, `Exp2.smul`, `Exp2.mul` and `exp2_rot` only. It omits `exp2_rot_sq`, `M2` and `exp2_conj`, the file's main result. Minor, noted as a remark.
- **Gap E-a, one lint warning survives.** The commit says "two Exp2.lean lint warnings are cleared", and the `omit` and the removal of `mul_sub` did clear two, but the build still reports `This simp argument is unused: sub_mul` at Exp2.lean line 151 column 53, in `exp2_conj`'s `simp only`. Dropping `sub_mul` from that list clears it.
- **Punctuation.** No em dash in any added line of either commit. No backtick inside link text. The semicolons in SecondOrder.lean's docstring bullet and in the L134 row separate list items that carry commas, the use the rule keeps. results.md line 1085's "at every $n\ge4$; hence" is a clause splice, pre-existing and untouched by this commit, noted only. Both commits' `Searched:` trailers join clauses with an ASCII `--`, which cannot be amended and is noted only.

## Repairs owed

1. L17.lean lines 18 to 20: say $8/9$ matches the record's printed $\sim89\%$ as a figure only, with the subspace measure zero among directions.
2. L17.lean lines 42 to 43: replace "misses about `11%` of directions, a majority statement" with the arithmetic fact alone.
3. findings/LEDGER.md line 446: drop "about $89\%$ of directions carry equality", keeping "at least $1451$ of $1637$ dimensions", a proper subspace and so measure zero among directions.
4. Exp2.lean line 151: remove the unused `sub_mul`.
