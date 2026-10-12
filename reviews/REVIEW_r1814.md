# r1814: L57Bridge.lean, L57's equality case on character-1 Weyl operators

*Gate 2 on the Lean layer. [L57Bridge.lean](../lean/HamiltonsCubic/Results/L57Bridge.lean) (commit e5af1d12) carries [L57Equality.lean](../lean/HamiltonsCubic/Results/L57Equality.lean)'s `L57_unit_eq` and [L57OddEq.lean](../lean/HamiltonsCubic/Results/L57OddEq.lean)'s `L57_unit_eq_odd` from the unit normalisation `fro S = 2` to any nonzero Weyl operator of character 1 attaining the bound homogeneously. Every declaration holds as the record reads it, the transport is lossless, and the hand evaluation at $n=4$ lands on $\theta_0(4)=\sqrt3/2$. The observations concern the direction carried, the index row's wording of the odd form, and a nonzero hypothesis the owed application must supply.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `norm_diagOp`: $\lVert\mathrm{diagOp}\,w\rVert=\sqrt{\mathrm{fro}\,w/2}$ | CONFIRMED |
| 2 | `unit_rescale`: $c=\sqrt{2/F}$ gives `fro (c • w) = 2` and `diagP (c • w) = Θ` | CONFIRMED |
| 3 | `charOne_weight`: a character-1 Weyl operator is `restrict (diagOp w)` with its $P$ and norm | CONFIRMED |
| 4 | `charOne_eq_even`: L57's even equality clause in homogeneous form | CONFIRMED WITH OBSERVATIONS |
| 5 | `charOne_eq_odd`: L57's odd equality clause in homogeneous form | CONFIRMED |
| 6 | `Zp` is the record's $Z(v)$, so $w=t\,Z'(v)$ is the record's block-constant $B'$ | CONFIRMED WITH OBSERVATIONS |
| 7 | [lean/INDEX.md](../lean/INDEX.md), the [L224] result row | CONFIRMED WITH OBSERVATIONS |

**Summary: CONFIRMED WITH OBSERVATIONS, the file compiles silently and audits 5/5 on the standard three, with five observations and no defect.**

## 1. Runs

- `lake env lean HamiltonsCubic/Results/L57Bridge.lean` from lean/: exit 0, no output (no warnings, no sorry).
- `python3 scripts/misc/axiom_audit.py --only L57Bridge.lean`: "auditing 5 declarations across 1 files", "5/5 clean -- resting on the standard three alone".

## 2. The record

L57's equality clause, [problem.md](../findings/problem.md) under *Lemma L57, the diagonal theorem, all $n$, both parities* (the row is **57** in [INDEX-results.md](../findings/INDEX-results.md), which points to problem.md), verbatim:

> with equality exactly at $S^{n/2}\times S^{n/2}$ for even $n$ and at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ for odd $n$, at the *geometric* Weyl tensor of that product, which is $-V/\lVert V\rVert$ under the record's $V$ convention. At even $n$, $\Theta_n=\theta_0(n)$.

The same section's step 2 fixes the projection, verbatim: "$Z(v)_{ij}=v_iv_j+\frac{v_i^2+v_j^2}{n-2}-\frac1{(n-1)(n-2)}$ the projection of $(v_iv_j)$ onto $\mathcal D_n$", and (c) says "$S\parallel Z(v)$ *is* the balanced product, a positive multiple of it, the sign being fixed by attainment since a negative multiple flips $P$."

L224 step 5, [second-order.md](../findings/second-order.md) line 1620, verbatim: "$W'$ is an L57 maximiser $B'$ with swap-even part $E$ and nonzero odd part, so $j$ and $k$ lie in different blocks $A\ni j$, $B\ni k$ of $B'$, which is block-constant with values $\alpha_A,\alpha_B$ inside the blocks and $\gamma$ across."

## 3. The declarations

**3.1 `norm_diagOp`.** `RealLayer.norm` is $\sqrt{\mathrm{normSq}}$ ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)), and [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)'s `diagOp_normSq` gives $\mathrm{normSq}(\mathrm{diagOp}\,w)=\tfrac12\sum_{i,j}w_{ij}^2=\mathrm{fro}\,w/2$ with [L57Diagonal.lean](../lean/HamiltonsCubic/Results/L57Diagonal.lean)'s `fro` the ordered-pair sum. Sound.

**3.2 `unit_rescale`.** With $F=\mathrm{fro}\,w>0$ and $c=\sqrt{2/F}>0$:

- $c^2=2/F$, so `fro_smul` gives $\mathrm{fro}(c\,w)=c^2F=2$.
- $c\sqrt{F/2}=\sqrt{(2/F)(F/2)}=\sqrt1=1$ (`Real.sqrt_mul` needs only $2/F\ge0$).
- `diagP_smul` gives $\mathrm{diagP}(c\,w)=c^3\,\mathrm{diagP}\,w$. `diagCubicFormula` rewrites $\mathrm{diagP}\,w$ as $P(\mathrm{diagOp}\,w)$, the hypothesis makes it $\Theta\lVert\mathrm{diagOp}\,w\rVert^3=\Theta(F/2)^{3/2}$, and $c^3\Theta(\sqrt{F/2})^3=\Theta(c\sqrt{F/2})^3=\Theta$.
- `IsWeight.smul` keeps symmetry, hollowness and zero row sums.

The algebra is exactly as the brief states it. Sound for any real $\Theta$, sign included.

**3.3 `charOne_weight`.** [L120Ident.lean](../lean/HamiltonsCubic/Results/L120Ident.lean)'s `trivial_block_iff` produces $w$ with $W=\mathrm{restrict}(\mathrm{diagOp}\,w)$, and [L0Witness.lean](../lean/HamiltonsCubic/Results/L0Witness.lean)'s `Pcubic2_restrict` and `normSq2_restrict` transfer $P$ and the squared norm. Sound.

**3.4 `charOne_eq_even`.** The hypothesis $P(W)=\sqrt{2(n-1)(n-2)}/n\cdot\sqrt{\mathrm{normSq2}\,W}^3$ is converted to `heq'` on $\mathrm{diagOp}\,w$, `unit_rescale` supplies $c$, and `L57_unit_eq` applies to $S=c\,w$ with `Fintype.card_fin` turning `Fintype.card (Fin n)` into $n$ in `hn` and in the $\theta_0$ expression. It returns $S=t\,Z'(v)$ with $t>0$, $v_a^2=1/n$, $\sum v=0$ and $n$ even. Then $c\,w_{ab}=t\,Z'_{ab}$ gives $w_{ab}=(t/c)Z'_{ab}$ with $t/c>0$. The conclusion's $v$, $\sum v=0$, $v_a^2=1/n$ and `Even n` are `L57_unit_eq`'s own after the card rewrite. Sound.

**3.5 `charOne_eq_odd`.** The same route with `L57_unit_eq_odd`, whose hypotheses `5 ≤ card`, `¬ Even card`, `fro S = 2` and `diagP S = √(thetaOddSq card)` are met after the card rewrite. `thetaOddSq` resolves to `L57Critical.thetaOddSq` $=2(n-1)(n-3)/((n+1)(n-2))$ (the opened namespace, the same constant `L57_unit_eq_odd` uses, and the record's odd $\Theta_n^2$). A name clash with `L20Statement.thetaOddSq` is excluded since that namespace is not opened, and the file compiles. Sound.

## 4. Fidelity questions

**Q1, homogeneous form versus L57's clause.** $W=\mathrm{diagOp}\,w$ and $c\,w$ are positive multiples of each other, and both are positive multiples of $Z'(v)$ ($t$ and $t/c$ positive). Positive scaling preserves $P/\lVert\cdot\rVert^3$, so the homogeneous hypothesis is exactly L57's unit equality hypothesis, and nothing is lost in the direction carried. The record's "a positive multiple of it, the sign being fixed by attainment" matches `0 < t`. The file carries the "only at" half of "equality exactly at" (O1).

**Q2, the imported hypotheses.** `Fintype.card_fin` supplies card $=n$. `hn : 4 ≤ n` (even form) and `hn : 5 ≤ n`, `hodd : ¬ Even n` (odd form) are passed through after the rewrite, and the $\Theta$ expressions agree syntactically with the imported ones after it. At odd $n$ the even form's hypothesis is unsatisfiable, since its conclusion includes `Even n`, which agrees with r1813 O4 (the $\theta_0$ equality case is empty at odd $n$).

**Q3, "nonzero".** Needed. At $W=0$ the equation $P(W)=\Theta\lVert W\rVert^3$ holds as $0=0$, while the conclusion asks $w=t\,Z'(v)$ with $t>0$ and $Z'(v)\ne0$ at a balanced $v$ (at $n=4$, $Z'_{01}=1/3$). The proof uses `hne` exactly once, to get $\mathrm{fro}\,w>0$ from $\mathrm{normSq2}\,W=\mathrm{fro}\,w/2$, which `unit_rescale` needs (at $F=0$, Lean's $2/0=0$ gives $c=0$). Correct use. The even proof also introduces `normSq2_nonneg` into a hypothesis it never reads (O2).

**Q4, the odd conclusion against `L57_unit_eq_odd`.** Clause by clause identical: $0<t$, $\sum v=0$, $\sum v^2=1$, $x\ne y$, $v$ two-valued in $\{x,y\}$, $(\lvert\{v=x\}\rvert-\lvert\{v=y\}\rvert)^2=1$ over $\mathbb Z$, and the entrywise form, with only $S\mapsto w$, $t\mapsto t/c$ and card $\mapsto n$ changed. The size condition is carried in full. Since the two sets partition the $n$ indices, it pins their sizes to $\lfloor n/2\rfloor,\lceil n/2\rceil$, the record's $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$.

**Q5, `Zp` against the record.** [L57Equality.lean](../lean/HamiltonsCubic/Results/L57Equality.lean) line 30: `if a = b then 0 else v a * v b + (v a ^ 2 + v b ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))`, which is the record's $Z(v)_{ij}$ off the diagonal and $0$ on it (hollow, as $\mathcal D_n$ requires), evaluated at $n=\mathrm{card}$. Off the diagonal $Z'_{ab}$ depends on $(v_a,v_b)$ alone, so at a two-valued $v$ with classes $A$, $B$ it takes three values: $x^2(1+\tfrac2{n-2})-\kappa$ inside $A$, $y^2(1+\tfrac2{n-2})-\kappa$ inside $B$, and $xy+\tfrac{x^2+y^2}{n-2}-\kappa$ across, $\kappa=\tfrac1{(n-1)(n-2)}$. That is the record's "block-constant with values $\alpha_A,\alpha_B$ inside the blocks and $\gamma$ across", with the blocks being the value classes of $v$. The block-constant reading is a one-line consequence rather than a stated theorem (O3).

## 5. Hand evaluation, exact, $n=4$ (a screen)

*Hand evaluation, labelled as such, on one constructed weight. It checks the constants of `unit_rescale` and is not evidence for the theorems.*

Weight: blocks $\{0,1\}$, $\{2,3\}$, $w_{01}=w_{23}=2$, every cross entry $-1$, zero diagonal. Row sums $2-1-1=0$, so $w\in\mathcal D_4$.

- **fro.** Ordered pairs: $2\cdot(2\cdot4+4\cdot1)=24$.
- **Spectrum.** $\mathbf1\mapsto0$, $(1,1,-1,-1)\mapsto4$, $(1,-1,0,0)$ and $(0,0,1,-1)\mapsto-2$. Check: $\mathrm{tr}\,w^2=16+4+4=24=\mathrm{fro}$.
- **diagP.** $\sum_{a,b}w_{ab}^3=2(2\cdot8+4\cdot(-1))=24$, $\mathrm{tr}\,w^3=64-8-8=48$, so $\mathrm{diagP}\,w=\tfrac12(24+48)=36$.
- **Rescaling.** $c=\sqrt{2/24}=1/(2\sqrt3)$, $c\sqrt{F/2}=\sqrt{12}/(2\sqrt3)=1$, $\mathrm{fro}(c\,w)=24/12=2$.
- **diagP(c w).** $c^3\cdot36=36/(24\sqrt3)=\sqrt3/2$.
- **Target.** $\theta_0(4)=\sqrt{2\cdot3\cdot2}/4=\sqrt{12}/4=\sqrt3/2$. Equal.
- **Homogeneous form.** $\theta_0(4)\lVert\mathrm{diagOp}\,w\rVert^3=\tfrac{\sqrt3}2\cdot12^{3/2}=36=\mathrm{diagP}\,w$, so the weight satisfies `charOne_eq_even`'s hypothesis on the diagonal side.
- **The conclusion's form.** At $v=(\tfrac12,\tfrac12,-\tfrac12,-\tfrac12)$ ($v_a^2=1/4$, $\sum v=0$): $Z'$ inside $=\tfrac14+\tfrac14-\tfrac16=\tfrac13$, across $=-\tfrac14+\tfrac14-\tfrac16=-\tfrac16$. So $w=6\,Z'(v)$ with $t=6>0$, and $c\,w=\sqrt3\,Z'(v)$. The within/cross ratio $-2$ is the record's $-\frac{n/2}{n/2-1}$ at $n=4$.

## 6. [lean/INDEX.md](../lean/INDEX.md), the [L224] row

- **Files.** L57Bridge.lean and PairConv.lean are listed (r1813 O2 repaired).
- **r1813 O4.** "`L224_eq_tight` at $\theta_0(n)$ is valid at odd $n$ too, where its equality case is empty since $\theta_0(n)>\Theta_n$ (O4)" is present and accurate.
- **The L57Bridge sentence.** `unit_rescale`, `charOne_weight` and `charOne_eq_even` are described accurately. For `charOne_eq_odd` it says "the same with $v$ two-valued on sets whose sizes differ by one", and "the same" reads as keeping $v_a^2=1/n$ and "$n$ even", neither of which the odd form carries (it carries $\sum v^2=1$) (O4). The same phrase is in the file's docstring.
- **Owed list.** It names "the application of `charOne_eq_even`/`charOne_eq_odd` to `L224_eq_tight`'s $W'$ (r1812 O3, O4)", "$q_E=q_{B'}$ of rank one with the line of $\bar u$ as the whole top eigenspace" and "the rotation $e^{\varphi\xi}$ carrying $W'$ to $W$ (L222 item 5)". All three required items are present. The last owed item, "L57's equality clause in block-constant form", is still owed as a stated theorem, and L57Bridge's `Zp` form reduces it to the reading in Q5 (O3).
- **Status.** **partial**, correct while step 5's second half is owed.

## Observations

- **O1, one direction.** The file proves that equality forces the $Z'(v)$ form, the "only at" half of the record's "equality exactly at". Attainment at the product is not in this file. L224 step 5 uses only this half ("$W'$ is an L57 maximiser $B'$"), so nothing downstream is short, but any sentence calling it "L57's equality clause" in full should say "the forcing half".
- **O2, a dead hypothesis.** In `charOne_eq_even`, `have := normSq2_nonneg …` is rewritten and never read (the odd proof omits it). Cosmetic.
- **O3, block-constancy is implicit.** The record's "$B'$ … block-constant with values $\alpha_A,\alpha_B$ … and $\gamma$ across" follows from `w a b = t * Zp v n a b` at two-valued $v$ in one line (Q5) but is stated nowhere, and the step-5 application will need it with $j\in A$, $k\in B$. That can be the owed item "L57's equality clause in block-constant form", now reducible to a short lemma on `Zp`.
- **O4, "the same" in the odd description.** The INDEX row and the file docstring say the odd form is "the same with $v$ two-valued", and the odd conclusion replaces $v_a^2=1/n$ with $\sum v^2=1$ and drops `Even n`. Suggested wording: "with $\sum v=0$, $\sum v^2=1$, $v$ two-valued on sets whose sizes differ by one, $t>0$".
- **O5, nonzero at the application.** `L224_eq_tight`'s second branch does not itself exclude $W'=0$, so the owed application must supply `normSq2 W' ≠ 0`. It follows from $\lVert W'\rVert=\lVert D+\nu\rVert$ (`L224_step4`) and the Statement's unit $W$ ("If $P(W)=\Theta_n$"). The owed list could name it.

## What would falsify each headline

- **Claims 1 to 5.** A compile error or a non-standard axiom in L57Bridge.lean. Neither occurs (§1). Semantically, a weight with $F>0$ attaining $\Theta$ whose $c\,w$ misses `fro = 2` or `diagP = Θ`, which the algebra in 3.2 excludes.
- **Claim 6.** A `Zp` that differs from the record's $Z(v)$ at some $n$ or on the diagonal, or a two-valued $v$ at which `Zp` is not constant on blocks. Q5 excludes both.
- **Claim 7.** A missing owed item, or a row sentence the file contradicts. Only O4's wording is loose.
