# REVIEW r1683: L237's attainment at r = 1, 2, 4, 6 (93e0f562), and the docstring and row edits beside it

**Verdict: CONFIRMED WITH GAPS.** `Attains r κ` is a faithful, non-vacuous lower bound on the record's $\kappa_r$, the four witnesses are the record's own (the $1$-star, the $2$-star with centre weight $2$, the triangle), their $n$ ranges match the record's Statement at HEAD, the caps at $r=1,2,4,6$ are suprema exactly as the row says, `ray_value_above` is correct and modestly documented, and all twenty declarations rest on the standard three. Two gaps remain. The record's own attainment sentence says "below $n=r+2$ the maximum is smaller", which `attains_six` refutes at $r=6$, $n=6,7$, while the row carries that clause as owed. And the docstrings and row call $2+\sqrt2$ "the record's value", which the current record never states.

| # | Claim | Verdict |
|---|---|---|
| 1 | `Attains r κ` expresses $\kappa_r\ge\kappa$ in the record's normalisation, non-vacuously | **CONFIRMED** |
| 2 | $n$ ranges: $n\ge4$ at $r=1,2$, $n\ge6$ at $r=4,6$ | **CONFIRMED** |
| 3 | Witnesses are the record's $k$-star (centre weight $k$) and triangle, with the stated eigenvalues | **CONFIRMED** (hand-checked) |
| 4 | "with `kappa_cap_norm` and `L31_cap_unit` the caps at these $r$ are the suprema" | **CONFIRMED** |
| 5 | `ray_value_above` and its docstring | **CONFIRMED** |
| 6 | KyFanBracketCap docstrings (`slot3_pm_edge`, `slot3_path_loop`) | **CONFIRMED WITH GAPS** (G2) |
| 7 | L52 `diagonal_locus_proper` docstring and L52 row | **CONFIRMED** |
| 8 | L237 row: every clause of the attainment sentence proved or owed | **CONFIRMED WITH GAPS** (G1) |
| 9 | Axioms: standard three only | **CONFIRMED** (20/20 clean, import present) |

One line: the Lean is right and the row is faithful to it, but the record's "below $n=r+2$ the maximum is smaller" is false at $r=6$ by this very commit's `attains_six`, and the owed list carries it forward instead of routing it.

## Attack line 1: statement fidelity

- **Record.** [second-order.md:232](../findings/second-order.md#L232) at HEAD (after c2e4e824): "$\kappa_r$, the largest sum of $r$ top eigenvalues of $-\mathrm{ad}_X^2$ over unit $X$, and $\kappa_1,\kappa_2=2,4$ for $n\ge4$ ($1,2$ at $n=3$), with $\kappa_4,\kappa_6=6,8$ for $n\ge6$ ($\kappa_4=4$ at $n=4$ and $3+\sqrt5$ at $n=5$)", with $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}XY$.
- **Pairing.** `inner2 X Y = (1/2) tr(Xᵀ Y)` and `br X Y = X Y - Y X` ([WeylReal.lean:39](../lean/HamiltonsCubic/Base/WeylReal.lean#L39), :42), equal to the record's pairing on skew matrices.
- **Direction.** [L237Attain.lean:41](../lean/HamiltonsCubic/Results/L237Attain.lean#L41) asks for skew $X$ with `0 < inner2 X X` and skew $y_j$ with `inner2 (y i) (y j) = if i = j then 1 else 0`, and $\sum_j\lVert[X,y_j]\rVert^2=\kappa\langle X,X\rangle$. For orthonormal $y_j$, $\sum_j\langle y_j,-\mathrm{ad}_X^2y_j\rangle$ is at most the top-$r$ eigenvalue sum (Ky Fan), so `Attains r κ` gives $\kappa_r\ge\kappa$ after scaling $X$ to unit. That is the right direction for a lower bound.
- **Non-vacuity.** $\langle X,X\rangle>0$ is a conjunct and is discharged ($2$, $6$, $3$). Orthonormality is the full Gram identity, discharged entry by entry with `e.injective` supplying the index distinctions, so no degenerate coincidence of indices is possible.
- **$n$.** `Fintype.card ι ≥ 4` for `attains_one`, `attains_two`, `≥ 6` for `attains_four`, `attains_six`, via `emb_of_le`. These match the record's Statement exactly. The $n=3$ exception ($\kappa_1=1$) is consistent: $\mathfrak{so}(3)$ has no room for $\varphi_{01}+\varphi_{23}$.

## Attack line 2: witnesses and a hand check

- **Record's witness.** [second-order.md:236](../findings/second-order.md#L236): "the doubled $k$-star (centre weight $k$, $k$ leaves of weight $1$, all one sign)" and "at $r=6$ the doubled triangle". Lean: $k=1$ is $\varphi_{01}+\varphi_{23}$, $k=2$ is $2\varphi_{01}+\varphi_{23}+\varphi_{45}$ with the four plus slots on the two centre-leaf pairs, the triangle is $\varphi_{01}+\varphi_{23}+\varphi_{45}$ with the six plus slots on its three pairs. Each matches. The load: $2k$ slots of $(k+1)^2$ against $k^2+k$, ratio $2k+2$.
- **Hand check, 1-star.** Using $[\varphi_{ij},\varphi_{kl}]=\delta_{jk}\varphi_{il}+\delta_{il}\varphi_{jk}-\delta_{ik}\varphi_{jl}-\delta_{jl}\varphi_{ik}$ (for $\varphi_{ij}=E_{ij}-E_{ji}$, while the repo's `phi i j` is the negative, a global sign that leaves every bracket norm unchanged): $[\varphi_{01},\varphi_{02}]=-\varphi_{12}$, $[\varphi_{01},\varphi_{13}]=\varphi_{03}$, $[\varphi_{23},\varphi_{02}]=-\varphi_{03}$, $[\varphi_{23},\varphi_{13}]=\varphi_{12}$. So $[X,\varphi_{02}-\varphi_{13}]=-2(\varphi_{03}+\varphi_{12})$, norm squared $8$ against $\langle Z,Z\rangle=2$: eigenvalue $4=(1+1)^2$, ratio $2$ against $\langle X,X\rangle=2$. This is `attains_one`'s value and half of `attains_two`'s.
- **Hand check, 2-star.** $[2\varphi_{01}+\varphi_{23},\varphi_{02}-\varphi_{13}]=-3(\varphi_{03}+\varphi_{12})$ and $[2\varphi_{01}+\varphi_{45},\varphi_{04}-\varphi_{15}]=-3(\varphi_{05}+\varphi_{14})$, so eigenvalue $9$ per unit slot, four slots give $36=6\cdot6$. Matches the docstring.
- **Orthonormality by inspection.** The six triangle slots have pairwise disjoint $\varphi$ supports, each of norm squared $2$ before the $1/\sqrt2$ scaling, so the Gram is $2\delta$ as `attains_of_scaled` requires.

## Attack line 3: are the caps the suprema?

- $r=2,4,6$: `kappa_cap_norm` ([L237SlotCounts.lean:212](../lean/HamiltonsCubic/Results/L237SlotCounts.lean#L212)) gives $\le(r+2)\langle X,X\rangle$ for every skew $X$ and orthonormal skew $y_j$, and `Attains` reaches $r+2$. Supremum attained.
- $r=1$: `kappa_cap_norm` gives only $3$. [L31Statement.lean:444](../lean/HamiltonsCubic/Results/L31Statement.lean#L444) `L31_cap` is $\lVert[X,Y]\rVert^2\le2\langle X,X\rangle\langle Y,Y\rangle$, in `HamiltonsCubic.RealLayer`'s `inner2` (opened at :440, the same definition L237Attain uses), and `L31_cap_unit` (:452) is its unit case. With `attains_one`, $\kappa_1=2$ at $n\ge4$. The row names `L31_cap_unit`, which needs the one-line rescaling of $X$, and `L31_cap` would give it with no rescaling. Not a defect.
- The row's own owed item "$\kappa_r$ as a supremum" remains accurate in the sense that no `sSup` is packaged. The two-theorem reading is what "the caps at these $r$ are the suprema" asserts, and it holds.

## Attack line 4: ray_value_above

- $83^2\cdot21=144669$, $294^2=86436$, $144669/86436\approx1.6737>1.5$, so $83\sqrt{21}/294\approx1.2937>\sqrt{3/2}\approx1.2247$. The proof squares through `Real.sqrt_lt'` with positivity of the right side, which is sound.
- The docstring says it is "the arithmetic the comparison rests on" and that the ray's exact value is owed. It claims no more than it proves.

## Attack line 5: docstrings and rows

- **KyFanBracketCap.** `slot3_pm_edge` proves $(a+b)^2+(a-b)^2+(a+c)^2\le4(a^2+b^2+c^2)$ and `slot3_path_loop` proves $(a+b)^2+(a+c)^2+a^2\le4(\cdot)$, which is what the new docstrings say ("at most $4\Sigma s^2$"). The exact maxima are correct by hand: the forms are $3a^2+2b^2+c^2+2ac$ (block $\begin{pmatrix}3&1\\1&1\end{pmatrix}$, top $2+\sqrt2$) and $3a^2+b^2+c^2+2ab+2ac$ (on $b=c$, block $\begin{pmatrix}3&\sqrt2\\\sqrt2&1\end{pmatrix}$, top $2+\sqrt3$). See G2 for "the record's value".
- **L52.** `diagonal_locus_proper` is `12 n(n-2) < n(n+1)(n+2)(n-3)` over ℚ for $n\ge5$ (at $n=5$: $180<420$). The docstring now states this and owes the subvariety and interior reading, and the L52 row says the same with [r1682](REVIEW_r1682.md) cited. This closes r1682's G2.
- **L237 row, new sentence.** Every declaration it names exists with the stated content and $n$. The witnesses named ($1$-star, $2$-star, triangle) match the file.
- **L237 row, owed list against the record's attainment sentence.** "Equality at every even $r=2k$ once $n\ge2k+2$ by the doubled $k$-star": owed ("attainment at every $k$ ... by the doubled $k$-star"), with $k=1,2$ proved. "At $r=6$ the doubled triangle also attains it": proved. "Below $n=r+2$ the maximum is smaller ($3+\sqrt5$ at $n=5$, $r=4$)": owed as "the values below $n=r+2$", see G1. "At odd $r$ the bound is strict": owed, and at $r=1$ it now follows from `L31_cap` ($2<3$), which the owed item could say.

## G1: the record's "below n = r + 2 the maximum is smaller" is false at r = 6

- **The object.** The triangle $X=\varphi_{01}+\varphi_{23}+\varphi_{45}$ in $\mathfrak{so}(6)$ with its six plus slots: $\sum_j\lVert[X,y_j]\rVert^2=8\langle X,X\rangle$ at $n=6<r+2=8$ (`attains_six`, which needs only `6 ≤ Fintype.card ι`). With `kappa_cap_norm`, $\kappa_6=8=r+2$ at $n=6$ and $n=7$.
- **Where it contradicts.** [second-order.md:236](../findings/second-order.md#L236): "below $n=r+2$ the maximum is smaller". The same record's Statement ([:232](../findings/second-order.md#L232)) already says $\kappa_6=8$ for $n\ge6$, so the block contradicts its own Statement. The clause is true at $r=2$ ($n=3$) and $r=4$ ($n=4,5$), the only cases it exemplifies.
- **What the row does.** It owes "the values below $n=r+2$" without saying the general clause fails at $r=6$. A future formaliser would be sent after a false statement.
- **Repair.** Record side: restrict the clause to the $k$-star, or state it as "below $n=r+2$ the $k$-star is unavailable, and the maximum is smaller at $r=2,4$ ($3+\sqrt5$ at $n=5$, $r=4$) while the triangle keeps $\kappa_6=8$ from $n=6$". Row side: owe the corrected clause and name $r=6$, $n=6,7$ as refuted by `attains_six`. The research loop owns the record fix.

## G2: 2 + √2 is not "the record's value"

- The new docstrings in [KyFanBracketCap.lean](../lean/HamiltonsCubic/Results/KyFanBracketCap.lean) and the row say the exact maxima are "the record's value" and "the two three-slot configurations the record names".
- The current record names $2+\sqrt3$ ([second-order.md:269](../findings/second-order.md#L269), in L239/L240's block, "the path with a kernel slot"), not in L237's block. It names $2+\sqrt2$ nowhere in findings/. The value appears in [REVIEW_r1122.md:68](REVIEW_r1122.md) as a screen and in text removed by 74453a4a.
- The values themselves are correct (hand check above). The repair is attribution: cite r1122 and :269, or drop "the record's".

## What would break the row, and what I did to look

- **The object that would break it**: an $n$ range too small for a witness (an index coincidence making a slot fail orthonormality), or an `inner2` for `L31_cap` in a different normalisation. I checked the embedding hypotheses against each witness's index count, verified the Gram structure by disjoint supports, and confirmed `L31_cap` uses the `RealLayer` `inner2` with constant $2$, attained by `attains_one`.
- **The object that breaks the record**: the triangle at $n=6$ (G1).
- **Screen** (reported as a screen, not as evidence): `python3 scripts/misc/axiom_audit.py --only L237Attain.lean`, "20/20 clean -- resting on the standard three alone". `import HamiltonsCubic.Results.L237Attain` is at [HamiltonsCubic.lean:743](../lean/HamiltonsCubic.lean#L743).
