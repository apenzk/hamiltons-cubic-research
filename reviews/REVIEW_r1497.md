# Review r1497: L178 step 1 in Lean, a Weyl operator on Λ²ℝ⁴ of rank at most three is self-dual or anti-self-dual, with r1496's gap repaired

Gate 2 review of commit 71b4ddb7: the new [Results/L178Split.lean](../lean/HamiltonsCubic/Results/L178Split.lean) (`P01` to `P23`, `cphi`, `cphi_swap`, `cphi_self`, the table `c01` to `c33`, `om4p`, `om4m`, `symm_ep`, `mixed_zero`, `trace_blocks`, `eq_zero_of_minors`, `mixed_zero'`, `exists_minor`, `two_by_two`, `L178_split`), the record edits ([lean/INDEX.md](../lean/INDEX.md) lines 70 and 480, [diagonal-half.md](../findings/diagonal-half.md) line 605, the header of [Results/L17WeylIdent.lean](../lean/HamiltonsCubic/Results/L17WeylIdent.lean) lines 19 to 21), and the repair of [r1496](REVIEW_r1496.md)'s gap C-1. One reviewer. Analysis-only rule inherited: the only compute was the module build (8772 jobs, "Build completed successfully") and the axiom audit.

| item | claim | verdict |
| --- | --- | --- |
| A | `om4p`/`om4m` are the layer's self-dual and anti-self-dual bivectors, `L178_split`'s block vanishing is $W^+=0$ or $W^-=0$, the rank hypothesis is the record's, and the $n=4$ restriction is recorded as owed | CONFIRMED |
| B | `mixed_zero` uses only Ricci-flatness and symmetry over a correct coordinate table, `trace_blocks` uses Bianchi at $(0,1,2,3)$, `eq_zero_of_minors` is a sound sum-of-squares argument, and `L178_split`'s four image vectors are independent | CONFIRMED |
| C | no edited sentence overstates, and r1496's C-1 is repaired | CONFIRMED |
| D | all 27 declarations rest on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED |

**Summary: in the bivector model at $n=4$, Ricci-flatness alone kills the mixed block $\langle\omega^+_i,W\omega^-_j\rangle$, Ricci-flatness and the first Bianchi identity at $(0,1,2,3)$ make each diagonal block trace-free, a nonzero symmetric trace-free $3\times3$ block has a nonzero $2\times2$ minor, and two such minors give four independent vectors in the range, so rank at most three forces one block to vanish. This is diagonal-half.md's step 1 with Bianchi consumed exactly where step 4's paragraph says. 27/27 declarations on the standard three axioms. r1496's C-1 repaired. No gap. CONFIRMED.**

## A. Fidelity

- **Orientation and normalisation of `om4p`, `om4m`.** In coordinates, `cphi` sends $\varphi_{ij}$ to $e_{(i,j)}$, so `om4p` (L178Split.lean line 69) is `coords` of [Base/SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean)'s `sdForm` (line 452), $\varphi_{01}+\varphi_{23}$, $\varphi_{02}-\varphi_{13}$, $\varphi_{03}+\varphi_{12}$, the layer's self-dual forms for `star4`. Checked by hand against `star4_apply` with `levi4` of the standard orientation and `phi i j = single j i 1 - single i j 1`: $\star\varphi_{01}=\varphi_{23}$, $\star\varphi_{02}=-\varphi_{13}$, $\star\varphi_{03}=\varphi_{12}$, matching the file header lines 14 to 16. `om4m` is the $-1$ eigenspace. The file does not tie `om4p` to `star4` by a theorem, and `L178_split` needs no such tie since its conclusion is symmetric under exchanging the two families. The six vectors have norm $\sqrt2$, so each block is twice the matrix of $W^\pm$ in an orthonormal basis, which changes nothing about vanishing or rank. Note, not a gap.
- **The conclusion is $W^+=0$ or $W^-=0$.** The docstring (line 143) defines $W^\pm$ as the blocks $(\langle\omega^\pm_i,W\omega^\pm_j\rangle)$, which is the splitting's summand once `mixed_zero` has removed the off-diagonal blocks. Read as operators: if the $+$ block and the mixed block vanish, $W\omega^+_j$ is orthogonal to all six $\omega^\pm$, which span $\Lambda^2\mathbb R^4$, so $W$ kills $\Lambda^+$. That last spanning step is not in the file, and it is the two-line reading of the block statement, not a clause the record asks for. Note, not a gap.
- **The rank hypothesis.** `finrank ℝ (LinearMap.range W) ≤ 3` for `W : Biv 4 →ₗ[ℝ] Biv 4` is $\mathop{\mathrm{rank}}(W:\Lambda^2\to\Lambda^2)\le3$ at $n=4$. **Faithful.**
- **The Weyl class.** Hypotheses `hS` (symmetric), `hA : alt4 (compOf W) = 0` (first Bianchi) and `hR : ric W = 0` are the membership conditions of [L17WeylDim.lean](../lean/HamiltonsCubic/Results/L17WeylDim.lean)'s `weylT` less tangency, which is the bivector model of $\mathcal W_4$. **Faithful.**
- **Bianchi consumed in step 1.** diagonal-half.md's step 4 paragraph says Ricci-flatness gives $\mathop{\mathrm{tr}}W^++\mathop{\mathrm{tr}}W^-=0$ and Bianchi gives $\mathop{\mathrm{tr}}W^+-\mathop{\mathrm{tr}}W^-=0$. `trace_blocks` (line 93) is that: $\mathop{\mathrm{tr}}W^\pm=\sum_pw_{pp}\pm2(w_{01,23}-w_{02,13}+w_{03,12})$, the first term is $\tfrac12\mathop{\mathrm{scal}}=0$ from `r00` to `r33`, and `alt4` at $(0,1,2,3)$ is $\tfrac13(w_{23,01}-w_{13,02}+w_{12,03})$, the second. **Faithful.**
- **$n=4$ and the padding.** The record's statement is for $W$ supported on $\Lambda^2V\subset\Lambda^2\mathbb R^n$. The file works on $\Lambda^2\mathbb R^4$, and lean/INDEX.md line 70 lists "the padding from $\Lambda^2V$ to $\Lambda^2\mathbb R^n$" as owed, with the row state **partial**. diagonal-half.md line 605 says "Kernel-checked at $V=\mathbb R^4$". The owed item is correctly named: a Weyl operator on $\mathbb R^n$ supported on $\Lambda^2V$ has its Ricci contraction over $k\notin V$ vanish, so it restricts to a member of $\mathcal W_4$ with the same rank, which is the missing link. **CONFIRMED.**

## B. Soundness

- **The coordinate table.** `cphi` (line 38) rewrites through `coords_phi_eq_basis`, `cphi_swap` through `phi_swap`, `cphi_self` shows $\varphi_{ii}=0$ from $\varphi_{ii}=-\varphi_{ii}$. So coords$(\varphi_{ij})=e_{(i,j)}$ for $i<j$, $-e_{(j,i)}$ for $i>j$, $0$ for $i=j$, and `c01` to `c33` instantiate exactly that. **Correct.**
- **`mixed_zero` uses only Ricci and symmetry.** Its binders are `hS` and `hR` only, so Bianchi cannot enter. Spot checks by hand with $w_{pq}=\langle e_p,We_q\rangle$: $\langle\omega^+_0,W\omega^-_0\rangle=w_{01,01}-w_{23,23}=\tfrac12(\mathrm{Ric}_{00}+\mathrm{Ric}_{11}-\mathrm{Ric}_{22}-\mathrm{Ric}_{33})$, and $\langle\omega^+_0,W\omega^-_1\rangle=w_{01,02}+w_{01,13}+w_{23,02}+w_{23,13}=\mathrm{Ric}_{12}-\mathrm{Ric}_{03}$ with $\mathrm{Ric}_{12}=w_{02,01}+w_{23,13}$ and $\mathrm{Ric}_{03}=-w_{13,01}-w_{23,02}$. This is the standard fact that the mixed block of a 4-dimensional curvature operator is the traceless Ricci part. **Correct.**
- **`trace_blocks`.** As in A, the Bianchi instance is `congrFun … hA 0 1 2 3`, the only one needed. **Correct.**
- **`eq_zero_of_minors`.** Principal minors give $B_{00}B_{11}=B_{01}^2$, $B_{00}B_{22}=B_{02}^2$, $B_{11}B_{22}=B_{12}^2$, and with $B_{22}=-B_{00}-B_{11}$ their sum is $B_{00}^2+B_{00}B_{11}+B_{11}^2+B_{01}^2+B_{02}^2+B_{12}^2=0$, a positive definite form, so all entries vanish. `hB`, `htr`, `hm` are all used. **Correct.**
- **`L178_split`'s independence.** Pairing $\sum c_t v_t=0$ with $\omega^+_{i_1},\omega^+_{i_2}$ kills the $\omega^-$ terms by `mixed_zero'`, leaving $c_0B_{i_1j_1}+c_1B_{i_1j_2}=0$ and $c_0B_{i_2j_1}+c_1B_{i_2j_2}=0$, and `two_by_two`'s determinant $ad-bc$ with $a=B_{i_1j_1}$, $b=B_{i_1j_2}$, $c=B_{i_2j_1}$, $d=B_{i_2j_2}$ is `exists_minor`'s nonzero minor exactly. The same on the minus side. Four independent vectors in a range of finrank at most three is the contradiction. Every hypothesis (`hS`, `hA`, `hR`, `hrank`) is used, and nothing is missing. **CONFIRMED.**

## C. Record accuracy

- **lean/INDEX.md line 70, the L178 row.** "Step 1 is PROVED at $V=\mathbb R^4$", the three named theorems and their descriptions match the file, and the owed list keeps $\#$ as the adjugate on $\mathfrak{su}(2)$ and adds the padding. The removed owed clause ("that rank $\le3$ forces one of $W^\pm$ to vanish") is the one now proved at $n=4$. The row stays **partial**. No overstatement.
- **diagonal-half.md line 605.** The added sentence scopes the check to $V=\mathbb R^4$ and names the three theorems. No overstatement.
- **r1496 C-1.** lean/INDEX.md line 480 now reads "every clause of the lemma's statement is proved, and so are the size paragraph's dimension bounds and properness", which is r1496's suggested narrowing, and the measure-zero reading stays in the prose list. **Repaired.**
- **r1496's non-gap note.** L17WeylIdent.lean lines 19 to 21 now attribute only $\dim\{F=0\}<1637$ to the new pair and credit the lower bound $1451$ to `L17_dim_12` in L17WeylDim.lean. **Repaired.** **CONFIRMED.**

## D. Axioms

- `python3 scripts/misc/axiom_audit.py --only L178Split`: "auditing 27 declarations across 1 files, 27/27 clean -- resting on the standard three alone".
- The build's only `sorry` warning is L16Statement.lean line 123, a pre-existing file outside this commit. **CONFIRMED.**

## E. Style

- The added lines of the commit carry no em dash (grep count 0) and no backticks inside link text.
- The semicolons in the L178 row separate items of a list whose items carry commas, the permitted use.
- lean/INDEX.md rows and diagonal-half.md line 605 are single lines. The Lean header wraps inside a comment block of a `.lean` file, outside the markdown rule. **CONFIRMED.**

## Overall

**CONFIRMED.** `L178_split` proves diagonal-half.md's Lemma L178 step 1 at $V=\mathbb R^4$ in the layer's bivector model: the mixed block vanishes by Ricci-flatness, each block is trace-free by Ricci-flatness plus one Bianchi instance, and two nonzero trace-free symmetric blocks would give rank at least four. All 27 declarations on the standard three axioms. r1496's C-1 and its header note are repaired. Notes, not gaps: the file states $W^\pm=0$ as block vanishing with non-unit $\omega^\pm$ (equivalent to the operator statement through the spanning of the six $\omega$), and the self-duality of `om4p` is checked here by hand against `star4` rather than by a theorem in the file.
