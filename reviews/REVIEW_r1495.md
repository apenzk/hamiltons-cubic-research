# Review r1495: spin(7) fixes no nonzero vector of ℝ⁸ in Lean, L159's n = 8 step, and r1494's gap repaired

Gate 2 review of commit 05305713: the new [Results/L159Spin7.lean](../lean/HamiltonsCubic/Results/L159Spin7.lean) (`Lz1` to `Lz7`, `Lz`, `Lz_clifford`, `Lz_skew`, `Lz_unit`, `Xz_sq`, `L`, `spin7`, `L_transpose`, `spin7_skew`, `spin7_no_fixed`), the record edits for it ([lean/INDEX.md](../lean/INDEX.md) line 518, the L159 row, and [graded-half.md](../findings/graded-half.md) line 551, the $n=8$ paragraph), and the repair of [r1494](REVIEW_r1494.md)'s gap E-1 in lean/INDEX.md line 480, the L17 row. One reviewer. Analysis-only rule inherited: the only compute was the module build (8706 jobs, "Build completed successfully"), `scripts/misc/axiom_audit.py --only L159Spin7`, and a screen of the seven matrices against the Fano-plane table, reported as a screen.

| item | claim | verdict |
| --- | --- | --- |
| A | `spin7` is the record's $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ from the octonionic Clifford module, and `spin7_no_fixed` states that it fixes no nonzero vector | CONFIRMED |
| B | `Lz_clifford`, `Lz_skew`, `Lz_unit`, `Xz_sq` (kernel `decide`), `L_transpose`, `spin7_skew` and `spin7_no_fixed` are sound | CONFIRMED |
| C | no edited sentence overstates, and r1494's E-1 is repaired | CONFIRMED WITH GAP |
| D | every declaration of L159Spin7.lean rests on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED |

**Summary: the seven integer matrices are the octonionic left multiplications for the cyclic triples $(i,i+1,i+3)$ mod $7$, they satisfy the $\mathrm{Cl}_{0,7}$ relations in the kernel, their commutator span lies in $\mathfrak{so}(8)$, and $[L_1,L_2]^2=-4$ gives `spin7_no_fixed`, which is exactly the clause graded-half.md needs at $k\in\{1,7\}$. All 7 declarations on the standard three axioms. One gap, C-1: the repaired L17 row says every clause of the size paragraph is proved, while that paragraph's properness claim (route-a.md line 93, r1494's E-1 item 4) has no theorem and is missing from the row's list of prose items, and "two-sided differentiability off the cone" misdescribes the claim, which is two-sided differentiability exactly on the cone. CONFIRMED WITH GAP.**

## A. Fidelity

- **The matrices are octonionic left multiplications.** `Lz_unit` (line 44) gives $L_ie_0=e_i$, so column $b$ of `Lz a` is $e_ae_b$. Screen: every column of all seven matrices matches the table generated from $e_ae_b=e_c$ on the triples $(1,2,4),(2,3,5),(3,4,6),(4,5,7),(5,6,1),(6,7,2),(7,1,3)$ with cyclic rotation, antisymmetry for $a\ne b$ and $e_a^2=-1$ (56 columns, $0$ mismatches). This is Baez's convention in *The Octonions* (§2.1, $e_ie_{i+1}=e_{i+3}$), whose seven lines are the Fano plane. Hand check of `Lz1`: columns $2,4,3,7,5,6$ give $e_1e_2=e_4$, $e_1e_4=-e_2$, $e_1e_3=e_7$, $e_1e_7=-e_3$, $e_1e_5=e_6$, $e_1e_6=-e_5$, each matching the table. The same screen found the algebra alternative and the norm multiplicative on 200 random integer pairs, a screen only. **What the argument needs is less than this and is kernel-checked**: `Lz_clifford` (line 36), $L_iL_j+L_jL_i=-2\delta_{ij}$, makes $\mathbb R^8$ a $\mathrm{Cl}_{0,7}$-module, and `Lz_skew` (line 40) makes it orthogonal.
- **`spin7` is the record's object.** `spin7` (line 57) is $\operatorname{span}_{\mathbb R}\{[L_i,L_j]\}$. Given the Clifford relations, $[L_i,L_j]=2L_iL_j$ for $i\ne j$, and these span the image of $\mathfrak{spin}(7)=\operatorname{span}\{e_ie_j\}\subset\mathrm{Cl}_{0,7}$ in $\mathfrak{so}(8)$, which is the record's "$\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ from the octonionic Clifford module". The file proves neither $\dim=21$ nor closure under the bracket, and says so by omission rather than claim.
- **Does the record's use need what the file omits?** No. graded-half.md line 551 takes $\dim\mathfrak h=21$ and $\mathfrak h=\mathfrak{spin}(7)$ from the preceding prose and the count from `spin7_not_standard` in L159.lean, and uses the Lean only at $k\in\{1,7\}$. There an invariant line or $7$-plane, with $\mathfrak h$ skew (`spin7_skew`), gives an invariant line whose vector $\mathfrak h$ kills, since $\mathfrak{so}(1)=0$, and `spin7_no_fixed` excludes it. The inference from an invariant $7$-plane to a killed line through the orthogonal complement is prose, one line, and uses only skewness, which the file supplies. The adjacent phrase "transitive on $S^7$" is not claimed as kernel-checked: the citation attaches to "fixes no nonzero vector".
- **The reading of `spin7_no_fixed`.** `(hv : ∀ X ∈ spin7, X.mulVec v = 0) : v = 0` (line 77). For a Lie algebra of matrices, "fixes $v$" means $Xv=0$ for every $X$, the infinitesimal form of $\exp(tX)v=v$. **The right reading.** It is also stronger than the record needs, since one element, $[L_1,L_2]$, already kills no nonzero vector. **CONFIRMED.**

## B. Soundness

- **The certificates.** `Lz_clifford`, `Lz_skew`, `Lz_unit` close by `fin_cases` then `decide`, and `Xz_sq` by `decide`, all on `Matrix (Fin 8) (Fin 8) ℤ`, where matrix equality is decidable entrywise over `Fin 8`. No `native_decide` in the file (grep). The build succeeds, so the kernel evaluated them.
- **The transfer to ℝ.** `L i` is `(Int.castRingHom ℝ).mapMatrix (Lz i)`, a ring hom on square matrices. `L_transpose` (line 60) rewrites through `Matrix.transpose_map`, `Lz_skew` and `Matrix.map_neg`, the leftover goal `(-x).cast = -(x.cast)` closed by `simp`. In `spin7_no_fixed` the congruence of `Xz_sq` under `mapMatrix` is rewritten by `map_mul`, `map_sub`, `map_zsmul`, `map_one` into the real identity $[L_0,L_1]^2=-4\cdot1$, which is the ring hom applied to both sides and so faithful. **Sound.**
- **`spin7_skew`.** `Submodule.span_induction` over the four cases: a generator $L_aL_b-L_bL_a$ transposes to $L_b^{\mathsf T}L_a^{\mathsf T}-L_a^{\mathsf T}L_b^{\mathsf T}=L_bL_a-L_aL_b$ by `L_transpose` and `neg_mul_neg`, which `abel` matches with $-(L_aL_b-L_bL_a)$. Zero, sums and scalars are closed by linearity of transpose. **Sound.**
- **`spin7_no_fixed`.** $X=[L_0,L_1]\in$ `spin7` by `subset_span`. Applying $X$ to $Xv=0$ gives $X^2v=0$, so $-4v=0$ as a `ℤ`-smul, cast to $(4:\mathbb R)\cdot v=0$, and $4\ne0$ gives $v=0$. The index shift is harmless: `Lz 0`, `Lz 1` are $L_1,L_2$ and the record's $[L_1,L_2]^2=-4$ is exactly `Xz_sq`. **Sound.** **CONFIRMED.**

## C. Record accuracy

- **lean/INDEX.md line 518, the L159 row.** The new sentence names `Lz_clifford`, `spin7_skew`, `Xz_sq`'s identity and `spin7_no_fixed` correctly. "$\mathfrak{spin}(7)=\operatorname{span}[L_i,L_j]$" is the file's definition. The "Owed" clause drops the fixed-vector item and keeps $\mathrm{Aut}(\mathfrak{so}(n))=\mathrm{Ad}(O(n))$ and the classification, and the state stays **partial**. **Accurate.**
- **graded-half.md line 551.** The added parenthetical cites `spin7_no_fixed` for "fixes no nonzero vector" and nothing else. **Accurate.**
- **The commit body** says the file closes "the fixed-vector clause of graded-half.md's n = 8 irreducibility argument at k = 1, 7". Per A, that is the whole of what those two cases need beyond skewness. **Accurate.**
- **r1494's E-1, lean/INDEX.md line 480.** The row now ends "every clause of the lemma's statement and of its size paragraph is proved. The block's worked examples ($H=u$, $H=-\star$, two-sided differentiability off the cone, the kink profile along $u+tH_0$) stay prose." That follows r1494's suggested wording and removes "every clause of the block". Two defects remain, recorded as C-1.

**Gap C-1.** lean/INDEX.md line 480, last two sentences.

1. **The size paragraph is not fully proved.** route-a.md line 93 is the "Its size, stated correctly" paragraph, and it asserts "$\{F=0\}$ is a proper subspace and therefore **measure zero** among directions". r1494's E-1 item 4 lists exactly this as having no theorem (it follows in one line from `Wb_weyl`, `Wb_tangent`, `Wb_F_pos`, but nothing states it), and a grep of the L17 files finds only docstring mentions (L17.lean line 15, L17Statement.lean line 206). So "every clause ... of its size paragraph is proved" overstates by that clause. r1494's item C made the same slip, and the commit inherited it through r1494's suggested repair. The prose list names four of r1494's five items and omits this one.
2. **"two-sided differentiability off the cone" inverts the claim.** route-a.md line 91 says $\{F=0\}$, the cone, *is exactly the set of directions in which $\delta^2$ is two-sided differentiable*. "Off the cone" reads as locating differentiability outside it.

The row's **proved** state is unaffected, since it rests on the lemma's statement. Repair: either state properness at $n=12$ as a theorem (one line from the `Wb_*` lemmas) or add it to the prose list and narrow the claim to "the size paragraph's dimension bounds", and replace "off the cone" with "exactly on the cone".

**CONFIRMED WITH GAP.**

## D. Axioms

`python3 scripts/misc/axiom_audit.py --only L159Spin7`: "auditing 7 declarations across 1 files, 7/7 clean -- resting on the standard three alone". The build emits no `sorry` warning for this module. **CONFIRMED.**

## E. Style

- No em dash in any added line of the commit (grep count $0$). The Lean docstring's `−` is the minus sign U+2212.
- No backticks inside markdown link text in any added line (grep count $0$).
- The new semicolon in lean/INDEX.md line 518, "gives `spin7_no_fixed`; standard three axioms", follows the row convention of a clause and its axiom fragment, used throughout the file and accepted by r1491 to r1494. Line 480's new sentences carry no semicolon. Pre-existing, outside this commit's added text: graded-half.md line 551's "survives at $n=8$; the $O(8)$ form does not" splices two clauses.
- The edited markdown lines (lean/INDEX.md 480 and 518, graded-half.md 551) are each one unwrapped line. **CONFIRMED.**

## Verdict

**CONFIRMED WITH GAP.** The seven matrices are the octonionic left multiplications of the Fano-plane table, the Clifford relations and skewness are kernel-checked by `decide`, `spin7` is the record's $\mathfrak{spin}(7)$ as a span in $\mathfrak{so}(8)$, and `spin7_no_fixed` is exactly the "fixes no nonzero vector" clause graded-half.md uses at $k\in\{1,7\}$, needing nothing the file omits (the $\dim=21$ and subalgebra facts enter only through prose and L159.lean). All 7 declarations on the standard three axioms. r1494's E-1 is repaired in its main point. Open: C-1, lean/INDEX.md line 480 still claims every clause of the size paragraph is proved while route-a.md line 93's properness claim has no theorem and is missing from the prose list, and "two-sided differentiability off the cone" inverts route-a.md line 91.
