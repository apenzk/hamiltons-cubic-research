# REVIEW r1829: FourIdent.lean, L220's four-set block as the span of two sandwiches

*Gate 2 review of [FourIdent.lean](../lean/HamiltonsCubic/Results/FourIdent.lean) at commit 4c51c3e0, with that commit's [FourSquare.lean](../lean/HamiltonsCubic/Results/FourSquare.lean) docstring edit and its [lean/INDEX.md](../lean/INDEX.md) L220 row. The file compiles with zero errors and no `sorry`, the audit reports 11/11 declarations on the standard three axioms, every basis image of both sandwiches checks by hand against `spanVec`, and the record's signed coordinates are `spanVec`'s, forced by the constraint $a+b+c=0$. Analysis only: the one run beyond the compile is the per-file axiom audit.*

| # | Claim | Verdict |
|---|---|---|
| 1 | Helpers `Smat_mul_apply`, `mul_Smat_apply`, `inner2_phiY`, `skewProj_eq` | CONFIRMED |
| 2 | `sigA_mat`: $S_{ik}YS_{jl}+S_{jl}YS_{ik}=\mathrm{spanVec}(1,0,-1)Y$ on skew $Y$ | CONFIRMED |
| 3 | `sigB_mat`: $S_{ij}YS_{kl}+S_{kl}YS_{ij}=\mathrm{spanVec}(0,-1,1)Y$ on skew $Y$ | CONFIRMED |
| 4 | `extendL_sigA`, `extendL_sigB`, `sigA_char`, `sigB_char` | CONFIRMED |
| 5 | `four_eq_sig`: every Weyl $V$ of character $\chi_Q$ is $x\sigma_A+y\sigma_B$ | CONFIRMED |
| (a) | `spanVec`'s $(x,y,z)$ are the record's signed $(a,b,c)$ | CONFIRMED |
| (b) | Hand checks on the seven basis vectors, both sandwiches | CONFIRMED |
| (c) | $V_Q$ is exactly the span of $\sigma_A,\sigma_B$ | CONFIRMED WITH OBSERVATIONS (O1, O2) |
| (d) | $x\sigma_A+y\sigma_B=\mathrm{spanVec}(x,-y,y-x)$ | CONFIRMED |
| (e) | The generated 25-case proof closes every case genuinely | CONFIRMED WITH OBSERVATIONS (O3) |
| 6 | FourSquare docstring edit | CONFIRMED |
| 7 | INDEX L220 row: FourIdent sentence, r1826 sentence, owed list | CONFIRMED WITH OBSERVATIONS (O4) |

**Summary.** FourIdent is sound and faithful: $V_Q=\mathrm{span}(\sigma_A,\sigma_B)$ holds in the record's signed coordinates, and the polarisation step it prepares uses $(a,b,c)=(x,-y,y-x)$ correctly.

## 1. Runs

- `lake env lean HamiltonsCubic/Results/FourIdent.lean` from [lean/](../lean/): exit 0. The output contains no `error` and no `sorry` (grep count 0). Every warning is a linter warning: unused simp arguments, "this tactic is never executed" and "Unused tactic linter" on the generated case lines 63 to 170, and one unused-section-variables warning on `skewProj_eq` at line 172.
- `python3 scripts/misc/axiom_audit.py --only FourIdent.lean`: "auditing 11 declarations across 1 files", "11/11 clean -- resting on the standard three alone".

## 2. Definitions read

- `spanVec i j k l x y z Y = x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y + z • rk2 (phi i l) (phi j k) Y` ([L126GenBridge.lean](../lean/HamiltonsCubic/Results/L126GenBridge.lean)).
- `rk2 U V X = inner2 V X • U + inner2 U X • V` ([L121Block.lean](../lean/HamiltonsCubic/Results/L121Block.lean)).
- `inner2 X Y = ½ tr(XᵀY)`. The compiled `inner2_phiY`, $\langle\varphi_{ab},Y\rangle=Y_{ba}$ on skew $Y$, pins $\varphi_{ab}=E_{ba}-E_{ab}$ with $\langle\varphi_{ab},\varphi_{cd}\rangle=\pm1$ on equal or swapped pairs and $0$ otherwise.
- `Smat a b` $=E_{ab}+E_{ba}$ and `sandOp A B X = AXB + BXA` ([PairSquare.lean](../lean/HamiltonsCubic/Results/PairSquare.lean)), with `sig4 i k j l = sandOp (Smat i k) (Smat j l)` ([FourSquare.lean](../lean/HamiltonsCubic/Results/FourSquare.lean)).
- `fourMap v = fourS i j k l v.1 v.2 (-v.1 - v.2)` and `fourS_mem` with hypothesis $x+y+z=0$ ([L120Four.lean](../lean/HamiltonsCubic/Results/L120Four.lean)).
- `four_block_iff`: for Weyl $V$, `SignChar (setChar {i, j, k, l}) V ↔ extendL V ∈ LinearMap.range (fourMap i j k l)` ([L120Ident.lean](../lean/HamiltonsCubic/Results/L120Ident.lean)).

## 3. (a) Coordinates

The record, [second-order.md](../findings/second-order.md) L220 Setting, verbatim: "in the pairing basis of $V_Q$ with signed coordinates $\nu=a\,e_{ij}\odot e_{kl}+b\,e_{ik}\odot e_{jl}+c\,e_{il}\odot e_{jk}$, $a+b+c=0$".

- Read with the unsigned basis $e_{ik}$, the first Bianchi identity $R_{ijkl}+R_{jkil}+R_{kijl}=0$ picks up the $ik|jl$ coefficient through $e_{ki}=-e_{ik}$, giving $a-b+c=0$.
- The record states $a+b+c=0$. That constraint is the Bianchi condition exactly when the middle term is carried by $e_{ki}\odot e_{jl}$, which is `spanVec`'s second term `rk2 (phi k i) (phi j l)`. The word "signed" and the constraint together therefore fix the record's $(a,b,c)$ as `spanVec`'s $(x,y,z)$.
- `fourS_mem` requires $x+y+z=0$, and `fourMap` parametrises $z=-x-y$. The record's constraint and the Lean's agree.
- Cross-check through the square: at $(a,b,c)=(1,0,-1)$ the record's step 2 pattern "$x=2a^2-b^2-c^2$ and cyclically" gives $K_{ij}=1$, $K_{ik}=2b^2-c^2-a^2=-2$, $K_{il}=2c^2-a^2-b^2=1$. This is `Q_sig`'s "weight $1$ on $ij,il,kj,kl$ and $-2$ on $ik,jl$".

## 4. (b) Hand checks

**Structure (hand derivation).** $S_{ik}E_{uv}S_{jl}$ is $E_{\bar u\bar v}$ when $u\in\{i,k\}$ and $v\in\{j,l\}$ and $0$ otherwise, with bar the swap $i\leftrightarrow k$, $j\leftrightarrow l$. Adding the mirror term, $\sigma_A\varphi_{pq}=\varphi_{\pi p,\pi q}$ for $\pi=(ik)(jl)$ when $\{p,q\}$ crosses between $\{i,k\}$ and $\{j,l\}$, and $0$ otherwise. Likewise $\sigma_B\varphi_{pq}=\varphi_{\rho p,\rho q}$ for $\rho=(ij)(kl)$ on pairs crossing $\{i,j\}$ and $\{k,l\}$.

**Right sides.** $\mathrm{spanVec}(1,0,-1)Y=\langle\varphi_{kl},Y\rangle\varphi_{ij}+\langle\varphi_{ij},Y\rangle\varphi_{kl}-\langle\varphi_{jk},Y\rangle\varphi_{il}-\langle\varphi_{il},Y\rangle\varphi_{jk}$. Using $\varphi_{ki}=-\varphi_{ik}$ twice, $\mathrm{spanVec}(0,-1,1)Y=\langle\varphi_{jl},Y\rangle\varphi_{ik}+\langle\varphi_{ik},Y\rangle\varphi_{jl}+\langle\varphi_{jk},Y\rangle\varphi_{il}+\langle\varphi_{il},Y\rangle\varphi_{jk}$.

| $Y$ | $\sigma_AY$ | $\mathrm{spanVec}(1,0,-1)Y$ | $\sigma_BY$ | $\mathrm{spanVec}(0,-1,1)Y$ |
|---|---|---|---|---|
| $\varphi_{ij}$ | $\varphi_{kl}$ | $\varphi_{kl}$ | $0$ | $0$ |
| $\varphi_{ik}$ | $0$ | $0$ | $\varphi_{jl}$ | $\varphi_{jl}$ |
| $\varphi_{il}$ | $\varphi_{kj}=-\varphi_{jk}$ | $-\varphi_{jk}$ | $\varphi_{jk}$ | $\varphi_{jk}$ |
| $\varphi_{jk}$ | $\varphi_{li}=-\varphi_{il}$ | $-\varphi_{il}$ | $\varphi_{il}$ | $\varphi_{il}$ |
| $\varphi_{jl}$ | $0$ | $0$ | $\varphi_{ik}$ | $\varphi_{ik}$ |
| $\varphi_{kl}$ | $\varphi_{ij}$ | $\varphi_{ij}$ | $0$ | $0$ |
| $\varphi_{pq}$, $p\notin Q$ | $0$ | $0$ | $0$ | $0$ |

All fourteen comparisons agree. The last row holds for either $q$: a pair with an index outside $Q$ never crosses, and every pairing against it vanishes.

**Exact hand evaluation (labelled as such).** $n=5$, $(i,j,k,l)=(0,1,2,3)$, $Y=\varphi_{03}+2\varphi_{14}$, so $Y_{30}=1$, $Y_{03}=-1$, $Y_{41}=2$, $Y_{14}=-2$, all other entries $0$.

- $S_{02}Y$: row $0$ takes $Y$'s row $2$, which is zero, and row $2$ takes $Y$'s row $0$, which is $-e_3^{\mathsf T}$. So $S_{02}Y=-E_{23}$, and $-E_{23}S_{13}=-E_{21}$.
- $S_{13}Y$: row $1$ takes $Y$'s row $3$, giving $E_{10}$, and row $3$ takes $Y$'s row $1$, giving $-2E_{34}$. Then $E_{10}S_{02}=E_{12}$, and $E_{34}S_{02}=0$ because column $4$ lies outside $\{0,2\}$.
- $\sigma_AY=E_{12}-E_{21}=-\varphi_{12}$.
- $\mathrm{spanVec}(1,0,-1)Y$: $\langle\varphi_{23},Y\rangle=Y_{32}=0$, $\langle\varphi_{01},Y\rangle=Y_{10}=0$, $\langle\varphi_{12},Y\rangle=Y_{21}=0$, $\langle\varphi_{03},Y\rangle=Y_{30}=1$. The value is $-1\cdot\varphi_{12}$.
- The two agree. The $2\varphi_{14}$ component survives the first multiplication in $S_{13}Y$ and is killed by $S_{02}$, which is the mechanism behind the table's last row.

## 5. (c) Spanning

- **$V_Q\subseteq\mathrm{span}$.** `four_eq_sig` takes `IsWeyl2 V` and `SignChar (setChar {i, j, k, l}) V` and returns $x,y$ with $V=x\sigma_A+y\sigma_B$. The proof takes $v$ from `four_block_iff`, sets $(x,y)=(v_1,-v_2)$, and checks $\mathrm{spanVec}(v_1,v_2,-v_1-v_2)=v_1\,\mathrm{spanVec}(1,0,-1)-v_2\,\mathrm{spanVec}(0,-1,1)$ on skew $X$ through `sigA_mat`, `sigB_mat` and `module`. The componentwise sum $v_1(1,0,-1)-v_2(0,-1,1)=(v_1,v_2,-v_1-v_2)$ confirms the choice.
- **$\mathrm{span}\subseteq V_Q$.** `sig_weyl` gives both generators Weyl (with its hypotheses permuted correctly for $\sigma_B$), and `sigA_char`, `sigB_char` give both character $\chi_Q$ through `four_block_iff` with witnesses $(1,0)$ and $(0,-1)$. Closure under $x\cdot+y\cdot$ is left to the reader (O1).
- Together these are "V_Q is exactly the span of $\sigma_A,\sigma_B$", with the combination step for the second inclusion an unstated one-liner.

## 6. (d) Polarisation coordinates

By linearity of `spanVec` in $(x,y,z)$: $x\,\mathrm{spanVec}(1,0,-1)+y\,\mathrm{spanVec}(0,-1,1)=\mathrm{spanVec}(x,-y,y-x)$, and $x+(-y)+(y-x)=0$. By section 3 these are the record's $(a,b,c)$. The commit message's $K_{ij}$ check also holds: $2a^2-b^2-c^2=2x^2-y^2-(y-x)^2=x^2-2y^2+2xy$.

## 7. (e) The generated case proof

- Compile exit 0, no error, no `sorry`, audit clean on all 11 declarations. The kernel accepted every branch of `sigA_mat` and `sigB_mat`, so every case closed genuinely.
- The case tree carries dead weight (O3).

## 8. FourSquare docstring and INDEX row

- The FourSquare edit replaces `W4_fix` with `W4_fix1`, `W4_fix2`, the names declared at lines 119 and 133. No stale `W4_fix` reference remains in FourSquare.lean or lean/INDEX.md.
- The INDEX FourIdent sentence names `sigA_mat`, `sigB_mat` with the right coordinates, the four character lemmas and `four_eq_sig` with its route through `four_block_iff`. It matches the file.
- The r1826 sentence, verbatim: "the record's signed coordinates $(a,b,c)$ with $a+b+c=0$ are `spanVec`'s, whose second term is written with $\varphi_{ki}=-\varphi_{ik}$, so $\sigma_A=(1,0,-1)$ and $\sigma_B=(0,-1,1)$ there (O1)". Correct by sections 3 and 4.
- The owed list still carries "step 2's products, that $\Pi_Q$ is a subalgebra of $\mathcal D_n$, $\nu\circ\nu\in\Pi_Q$ with its pattern". That remains owed and is correctly listed (O4).

## 9. Observations

- **O1.** The inclusion $\mathrm{span}(\sigma_A,\sigma_B)\subseteq V_Q$ is proved at the generators only. `SignChar` is `∀ ε, … → HasChar (c ε) (signMat ε) R`, linear in $R$, and `IsWeyl2` is a linear condition, so the combination step is immediate. A two-line `sig_comb_char` would make the "exactly" of the INDEX sentence a single theorem.
- **O2.** Linear independence of $\sigma_A,\sigma_B$ is not stated. The spanning claim does not need it, but the polarisation step reads $(x,y)$ as coordinates. Uniqueness follows from `spanVec`'s coordinates ([L120Four.lean](../lean/HamiltonsCubic/Results/L120Four.lean) `coord_fourS`), and $\mathrm{spanVec}(x,-y,y-x)=0$ forces $x=y=0$.
- **O3.** The generated case tree draws roughly 1,000 "simp argument is unused" warnings and about 40 "tactic is never executed" warnings, and `skewProj_eq` includes the six distinctness hypotheses it does not use. These affect maintenance only: an `omit … in` on `skewProj_eq` and a trimmed simp set per case would silence them.
- **O4.** The owed list names step 2's $\nu\circ\nu$ pattern as a whole. After `Q_sig` and `four_eq_sig`, the concrete residue is $\sigma_B\circ\sigma_B$ (by the symmetry of `Q_sig`) and the cross term $\sigma_A\circ\sigma_B$. Naming these in the owed clause would record how far FourIdent advanced it.

## 10. What would falsify each headline

- **`sigA_mat`, `sigB_mat`:** a basis vector whose image differs between the sides of section 4's table. The kernel check and all fourteen hand comparisons exclude this.
- **Coordinates (a):** a reading of the record's basis under which $a+b+c=0$ is the Bianchi condition while the middle term is unsigned. Section 3 shows the unsigned reading gives $a-b+c=0$ instead.
- **`four_eq_sig` and spanning (c):** a Weyl operator of character $\chi_Q$ outside `range fourMap`. That would contradict L120's `four_block_iff`, which is kernel-checked.
- **Polarisation (d):** a failure of linearity of `spanVec` in its coefficients, which holds by definition.
- **(e):** a `sorry`, an error, or a non-standard axiom in the compile or audit. None appeared.
