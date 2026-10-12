# r1813: PairConv.lean and L224Eq.lean's r1812 additions

*Gate 2 on the Lean layer. [PairConv.lean](../lean/HamiltonsCubic/Results/PairConv.lean) (commit f74fbe49) makes L222's $V_{jk}$ a set equality, and [L224Eq.lean](../lean/HamiltonsCubic/Results/L224Eq.lean) (commit 45928f0a) discharges `L224_eq_tight`'s two hypotheses at both parities and adds the $s=0$ branch. Every declaration checked holds as the record reads it. The observations are a docstring typo, an index file list, and two implicit points.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `nuX_weyl`: $\nu_x$ is Weyl at $\sum x=0$, via `rot45_Dminus` | CONFIRMED |
| 2 | `extendL_nuX`: $\nu_x$ extended is `pairMap j k x`, the two skew projections equated | CONFIRMED |
| 3 | `nuX_char`: $\nu_x$ has character $\varepsilon_j\varepsilon_k$, through `pair_block_iff` and `mem_ker_blockSums1` | CONFIRMED |
| 4 | `pair_iff`: the Weyl operators of character $\varepsilon_j\varepsilon_k$ are exactly the $\nu_x$ with $x$ zero at $j,k$ and $\sum x=0$ | CONFIRMED WITH OBSERVATIONS |
| 5 | `theta0_pos`, `L57_even`: the two hypotheses of `L224_eq_tight` at $\theta_0(n)$, $n\ge4$ | CONFIRMED WITH OBSERVATIONS |
| 6 | `thetaOdd_pos`, `L57_odd`: the two hypotheses at the odd $\Theta_n$, odd $n\ge5$ | CONFIRMED |
| 7 | `zero_branch`: the record's "At $s=0$, $W=E$ is diagonal" | CONFIRMED WITH OBSERVATIONS |
| 8 | [lean/INDEX.md](../lean/INDEX.md), the L222 and L224 result rows | CONFIRMED WITH OBSERVATIONS |

**Summary: CONFIRMED WITH OBSERVATIONS, both files compile silently and audit on the standard three, with four observations and no defect.**

## 1. Runs

- `lake env lean HamiltonsCubic/Results/PairConv.lean` from lean/: exit 0, no output.
- `lake env lean HamiltonsCubic/Results/L224Eq.lean` from lean/: exit 0, no output.
- `python3 scripts/misc/axiom_audit.py --only PairConv.lean`: "auditing 4 declarations across 1 files", "4/4 clean -- resting on the standard three alone".
- `python3 scripts/misc/axiom_audit.py --only L224Eq.lean`: "auditing 7 declarations across 1 files", "7/7 clean -- resting on the standard three alone".

## 2. PairConv.lean against L222's preamble

The record, [second-order.md](../findings/second-order.md) line 1591, Lemma L222's Statement: "Write $\nu\in V_{jk}$ as $\nu=\sum_ax_a\,e_{ja}\odot e_{ka}$ ($a\notin\{j,k\}$, $\sum x=0$, $\lVert\nu\rVert^2=2\lVert x\rVert^2$)", with $V_{jk}$ L120's summand of character $\varepsilon_j\varepsilon_k$.

**2.1 `nuX_weyl`.** The hypothesis is `∑ c, vy j k x c = 0`, where [DiagSquare.lean](../lean/HamiltonsCubic/Results/DiagSquare.lean)'s `vy` zeroes $x$ at $j,k$, so it is $\sum_{a\notin\{j,k\}}x_a=0$. The proof rewrites $\nu_x$ as the $45^\circ$ rotation of $D^-_x$ (`rot45_Dminus`) and carries `Dminus_weyl` through `rotR_isWeyl2` with `Rot_orth` at $c^2+c^2=1$. Sound.

**2.2 `extendL_nuX` and the skew projections.** [WeylModuleSNonzero.lean](../lean/HamiltonsCubic/Results/WeylModuleSNonzero.lean) defines `skewProj` with `toFun Z := (1/2 : ℝ) • (Z - Zᵀ)`. [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) defines `skewProj X := (2⁻¹ : ℝ) • (X - Matrix.transpose X)`. The `show` states exactly `(1 / 2 : ℝ) • (X - Xᵀ) = (2⁻¹ : ℝ) • (X - Xᵀ)`, and `norm_num` closes it since $1/2=2^{-1}$ in $\mathbb R$. The `show` elaborated, so both unfold definitionally to those forms. The rest is `pairLin_eq_nuX` on the skew matrix `skewProj X` (`skewProj_mem`). Sound.

**2.3 `nuX_char` and the kernel condition.** [L127Dim.lean](../lean/HamiltonsCubic/Results/L127Dim.lean): `mem_ker_blockSums1 A c : c ∈ ker (blockSums1 A) ↔ (∀ i ∉ A, c i = 0) ∧ ∑ i ∈ A, c i = 0`. With $A=\{i:j\ne i\wedge k\ne i\}$, $i\notin A$ is $i=j\vee i=k$, so the first clause is $c_j=c_k=0$. Given that, $\sum_{i\in A}c_i=\sum_ic_i$, since the omitted terms are $c_j,c_k=0$. The kernel is therefore exactly "x zero at j, k with $\sum x=0$", and the proof's two bullets carry out each half (the second through `Finset.sum_filter` and the vanishing at $j,k$). `pair_block_iff` ([L120Ident.lean](../lean/HamiltonsCubic/Results/L120Ident.lean)) then gives the character from $\mathrm{extendL}\,\nu_x\in\mathrm{pairMap}(\ker)$. Sound.

**2.4 `pair_iff`.** The forward direction is PairIdent's `pair_eq_nuX` verbatim. The converse is `nuX_weyl` with `nuX_char`. The statement is `(IsWeyl2 V ∧ SignChar (setChar {j, k}) V) ↔ ∃ x, x j = 0 ∧ x k = 0 ∧ ∑ i, x i = 0 ∧ V = nuX j k x`. The record's "Write $\nu\in V_{jk}$ as ..." presupposes the forward direction (every $\nu$ has the form), and reading the form as a parametrisation of $V_{jk}$ presupposes the converse. `pair_iff` is both, so it is the set equality the record uses. The norm clause $\lVert\nu\rVert^2=2\lVert x\rVert^2$ lives in PairNorm's `normSq2_nuX`, outside this file, as the L222 row says. See O1 on uniqueness.

## 3. L224Eq.lean's r1812 additions

[conventions.md](../findings/conventions.md) line 18: "$\theta_0(n)$ | **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.**" Line 19: "$\Theta_n$ | the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, **the value is the root, not the radicand**".

`L224_eq_tight` takes `(hΘ : 0 < Θ)` and `(hL57 : ∀ w, IsWeight w → Pcubic (diagOp w) ≤ Θ * RealLayer.norm (diagOp w) ^ 3)`.

**3.1 Even.** `theta0_pos` proves `0 < Real.sqrt (2 * (n - 1) * (n - 2)) / n` at $n\ge4$, and $\sqrt{2(n-1)(n-2)}/n$ is $\theta_0(n)$ (the positive root of line 18's square). `L57_even` is `L57_diagonal` with `Fintype.card_fin` rewritten, in exactly `hL57`'s shape at that $\Theta$. At even $n$ this is the record's $\Theta_n$. See O4 on odd $n$.

**3.2 Odd.** `thetaOddSq` in `HamiltonsCubic.L57Critical` ([L57Odd.lean](../lean/HamiltonsCubic/Results/L57Odd.lean) line 26) is `2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2))`, line 19's radicand verbatim, and the Lean value is its `Real.sqrt`, the root as line 19 insists. Positivity at every odd $n\ge5$ (indeed every real $n\ge5$), factor by factor:

| Factor | At $n\ge5$ | Sign |
|---|---|---|
| $2$ | $2$ | $+$ |
| $n-1$ | $\ge4$ | $+$ |
| $n-3$ | $\ge2$ | $+$ |
| $n+1$ | $\ge6$ | $+$ |
| $n-2$ | $\ge3$ | $+$ |

The quotient is positive, so its root is positive, which is what `div_pos <;> nlinarith` closes. The bound fails at $n=3$ only through $n-3=0$, outside the hypothesis. `L57_odd` is `L57_diagonal_odd` in `hL57`'s shape. CONFIRMED.

**3.3 `zero_branch`.** The record, [second-order.md](../findings/second-order.md) line 1620, L224 step 5: "At $s=0$, $W=E$ is diagonal." The hypotheses `hM : ½(D − σD) = coordOp (Dminus j k 0)` and `hνx : ν = nuX j k 0` are `L224_eq_tight`'s conclusions at its left branch $y=x=0$. The proof reads $D^-_0=0$ and $\nu_0=0$ off `normSq2_eq_zero` (with `vy j k 0 = 0`) and concludes `D + ν = ½ • (D + rotR (swapM j k) D)`, that is $W=E$. The file does not re-prove that $E$ is diagonal. That half holds by construction: $E$ is Weyl of character $1$ (the swap keeps character $1$ by L222Swap's `signChar_rotR_swap`), and `charOne_diag` makes every such operator a `diagOp`. So `zero_branch` is the sentence's equation, and the diagonality is one lemma away (O3).

## 4. lean/INDEX.md

- **L222 row.** PairConv.lean appears in the file list and in a sentence: "`pair_iff`, the Weyl operators of character $\varepsilon_j\varepsilon_k$ are exactly the $\nu_x$ with $x$ zero at $j,k$ and $\sum x=0$, the converse of `pair_eq_nuX` (r1809 O2); standard three axioms." It matches the file. The Owed list is "item 1's rotation invariance; item 5, of which only the scalar step `pair_mass_le` is typed ...; and, for generality only, `normSq2_nuX` without its `hsum` hypothesis (r1804 O2)". The converse is no longer owed, correctly. The sentence carries no Gate 2 citation yet, which this review supplies.
- **L224 row.** The r1812 repairs are in: "`theta0_pos` with `L57_even`, and `thetaOdd_pos` with `L57_odd`, discharge its two hypotheses on $\Theta$ at even and odd $n$ (r1812 O1); `zero_branch`, $y=x=0$ gives $D+\nu=E$ (r1812 O2)". The Owed list names `L57_unit_eq` and `L57_unit_eq_odd` (r1812 O4) and the bridge "through `charOne_diag` and the rescaling to `fro S = 2`" (r1812 O3). All accurate. See O2 on the file list.

## 5. Hand evaluation (exact, by hand, a screen)

$n=4$, $j=0$, $k=1$, $x=(0,0,1,-1)$, so $x_j=x_k=0$ and $\sum x=0$. $\nu_x=\mathrm{sandOp}(S,D_x)$ with $S=E_{01}+E_{10}$, $D_x=\mathrm{diag}(0,0,1,-1)$, acting by $X\mapsto SXD_x+D_xXS$. Take $\varphi_{02}=E_{02}-E_{20}$.

- $S\varphi_{02}=E_{10}E_{02}=E_{12}$, then $E_{12}D_x=x_2E_{12}=E_{12}$.
- $D_x\varphi_{02}=x_0E_{02}-x_2E_{20}=-E_{20}$, then $-E_{20}S=-E_{21}$.
- So $\nu_x\varphi_{02}=E_{12}-E_{21}=\varphi_{12}=x_2\varphi_{12}$, which is `nuX_phi_ja`.

`HasChar c S R` ([L120Hess.lean](../lean/HamiltonsCubic/Results/L120Hess.lean)) is $S\,R(S^{\mathsf T}ZS)\,S^{\mathsf T}=c\,R(Z)$ on skew $Z$. Conjugation by $\mathrm{diag}\,\varepsilon$ scales $\varphi_{ab}$ by $\varepsilon_a\varepsilon_b$.

- $\varepsilon=(-1,1,1,1)$: $S^{\mathsf T}\varphi_{02}S=-\varphi_{02}$, $\nu_x(-\varphi_{02})=-\varphi_{12}$, and conjugating back gives $-\varepsilon_1\varepsilon_2\varphi_{12}=-\varphi_{12}$. So $c=-1=\varepsilon_j\varepsilon_k$.
- $\varepsilon=(-1,-1,1,1)$: the left side is $\varepsilon_0\varepsilon_2\cdot\varepsilon_1\varepsilon_2\,\varphi_{12}=\varphi_{12}$, so $c=1=\varepsilon_j\varepsilon_k$.

Both agree with `nuX_char`. This is one basis vector at one $x$, a screen of the sign conventions and not evidence for the theorem, which the compiled proof carries.

## 6. Observations

- **O1 (pair_iff, uniqueness).** `pair_iff` gives existence of $x$ only. The record's "Write $\nu$ as ..." reads $x$ as $\nu$'s coordinates, which also needs $x\mapsto\nu_x$ injective on $\{x_j=x_k=0\}$. That follows from `normSq2_nuX` ($\lVert\nu_x\rVert^2=2\lVert x\rVert^2$ at $\sum x=0$) and linearity of `nuX` in $x$, so it is one line away and no defect. A `pair_unique` would make the parametrisation a bijection in Lean.
- **O2 (L224 row files).** The L224 row's file list omits PairConv.lean, while commit 45928f0a states that r1812 O5 (ν_x Weyl of character $\varepsilon_j\varepsilon_k$) is answered by PairConv's `pair_iff`. The row should list it or cite it in the step 5 sentence.
- **O3 (zero_branch, diagonality).** `zero_branch` proves $W=E$. The record's "is diagonal" is supplied by $E$'s character $1$ with `charOne_diag`, which no declaration composes here. A two-line corollary would close it on the page.
- **O4 (θ₀ at odd n).** `theta0_pos` and `L57_even` hold at every $n\ge4$, odd included. At odd $n$, $\theta_0(n)>\Theta_n$ (conventions.md line 18's gap $8(n-1)/(n^2(n+1)(n-2))$), so `L224_eq_tight` at $\theta_0$ is valid but its equality hypothesis is unattainable except at $D+\nu=0$. The row's "at even and odd $n$" pairs them correctly. No change needed beyond care in any later citation.
- **O5 (typo).** L224Eq.lean line 17, the module docstring: "attains $P(W')=\Theta\lVert W'\rVert^3$.;" carries a stray ".;".

## 7. What would falsify each headline

- **Claims 1 to 4:** a compile error or a non-standard axiom in PairConv.lean, or a reading of `blockSums1`'s kernel other than §2.3's (for example a filter whose complement is not $\{j,k\}$).
- **Claims 5 and 6:** a mismatch between `L57_even`/`L57_odd`'s right-hand side and `hL57`'s shape, a radicand differing from conventions.md line 19, or a nonpositive factor at some odd $n\ge5$ in §3.2's table.
- **Claim 7:** $\tfrac12(D+\sigma D)$ failing to be character $1$, which would break the "by construction" diagonality.
- **Claim 8:** a declaration named in either row that is absent from the files, or an Owed item already proved.
