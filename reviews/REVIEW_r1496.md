# Review r1496: dim spin(7) = 21 and {F=0} a proper subspace in Lean, with r1495's gap repaired

Gate 2 review of commit 3d7d88ff: the new [Results/L159Spin7Dim.lean](../lean/HamiltonsCubic/Results/L159Spin7Dim.lean) (`Lz_gram`, `Pr`, `card_Pr`, `G`, `gram`, `G_linearIndependent`, `L_anticomm`, `spin7_eq_span`, `finrank_spin7`), the additions `F_zero_proper` and `L17_proper_12` to [Results/L17WeylIdent.lean](../lean/HamiltonsCubic/Results/L17WeylIdent.lean), the record edits ([lean/INDEX.md](../lean/INDEX.md) lines 480 and 518, [route-a.md](../findings/route-a.md) line 93, [graded-half.md](../findings/graded-half.md) line 551), and the repair of [r1495](REVIEW_r1495.md)'s gap C-1 and its style note E. One reviewer. Analysis-only rule inherited: the only compute was the module build (8775 jobs, "Build completed successfully") and the two axiom audits.

| item | claim | verdict |
| --- | --- | --- |
| A | `finrank_spin7` is the record's $\dim\mathfrak{spin}(7)=21$ for graded-half.md's object, `F_zero_proper` states $\{F=0\}$ proper in $\mathcal W_n\cap T_uS$, `L17_proper_12`'s strict bound is correct | CONFIRMED |
| B | the `decide` Gram certificate, the ℤ→ℝ transfer, independence from orthogonality, `spin7_eq_span` both ways, `finrank_span_eq_card`, and `F_zero_proper`'s use of `Wb_F_pos` are sound | CONFIRMED |
| C | no edited sentence overstates, and r1495's C-1 is repaired | CONFIRMED WITH GAP |
| D | all declarations of both files rest on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose, and r1495's style note on graded-half.md line 551 repaired | CONFIRMED |

**Summary: the 21 products $L_iL_j$, $i<j$, are Frobenius-orthogonal of square norm $8$ by kernel `decide`, hence independent, and they span `spin7` because $[L_i,L_j]=2L_iL_j$ for $i\ne j$, so `finrank_spin7` is the $21$ graded-half.md uses. `F_zero_proper` is exactly "the kernel of `condMap` on `weylT n` is not all of `weylT n`", witnessed by L17Converse's $\overline{\mathbb{CP}^2}$ operator with $F>0$. 7/7 and 10/10 declarations on the standard three axioms. r1495's C-1 part 2 and style note are repaired and part 1 half-repaired. One gap, C-1: lean/INDEX.md line 480 still says every clause of the size paragraph is proved, and the next sentence but one lists the size paragraph's measure-zero clause as prose, so the row contradicts itself. CONFIRMED WITH GAP.**

## A. Fidelity

- **`finrank_spin7` is the record's count.** graded-half.md line 551 takes "$\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ from the octonionic Clifford module, $\dim=21$". `spin7` (L159Spin7.lean line 57) is the real span of the commutators $[L_i,L_j]$ of the octonionic Clifford module, reviewed as that object in r1495 item A. `finrank_spin7 : finrank ℝ spin7 = 21` (L159Spin7Dim.lean line 81) is the dimension of that same submodule of $8\times8$ real matrices. **Faithful.**
- **`F_zero_proper` states properness.** Its conclusion is `LinearMap.ker (condMap hn ∘ₗ (weylT n).subtype) ≠ ⊤`, a submodule of `weylT n`. `L17_codim`'s first conjunct (L17Codim.lean line 184) identifies membership of that kernel with $F(H)=0$ for every $H$ in `weylT n`, and `mem_weylT2` (r1494) identifies `weylT n` with the layer's $\mathcal W_n\cap T_uS$ through `opBEquiv`. So "$\{F=0\}$ is a proper subspace of $\mathcal W_n\cap T_uS$", in the bivector model and through the equivalence in the layer's own, at every $n\ge4$. The hypothesis `hN : finrank ℝ (Biv n) = N` names $N$ and is always satisfiable (take $N$ = the finrank), so the statement is non-vacuous.
- **`L17_proper_12`'s bound.** It rewrites $1637$ as `finrank ℝ (weylT 12)` by `finrank_weylT_12_eq` and applies `Submodule.finrank_lt` to the proper kernel, giving $\dim\{F=0\}<1637$ strictly. **Correct.** It states only the upper bound. The lower bound $1451$ is `L17_dim_12` (L17WeylDim.lean line 307), already on the record. **CONFIRMED.**

## B. Soundness

- **`Lz_gram` (line 25).** A kernel `decide` over all $7^4$ index quadruples of an implication $i<j\to k<l\to$ an integer trace identity, on `Matrix (Fin 8) (Fin 8) ℤ`. No `native_decide` in the file. Hand check of the diagonal: $L^{\mathsf T}=-L$ gives $(L_iL_j)(L_iL_j)^{\mathsf T}=L_iL_jL_jL_i=L_i(-1)L_i=1$, trace $8$, matching. `trace (A * Bᵀ)` is the Frobenius inner product. **Sound.**
- **The transfer, `gram` (line 34).** `e` rewrites $G_pG_q^{\mathsf T}$ as the entrywise cast of the integer product through `Matrix.map_mul` and `Matrix.transpose_map`, and `← AddMonoidHom.map_trace` moves the cast outside the trace, which is additivity of the cast. `hpq` turns $p=q$ into equality of both coordinates, matching `Lz_gram`'s condition $i=k\wedge j=l$. Both branches cast $8$ or $0$. **Sound.**
- **Independence (line 44).** `Fintype.linearIndependent_iff` reduces to $\sum_pc_pG_p=0\Rightarrow c_q=0$. Pairing with $G_q^{\mathsf T}$ under the trace and `gram` collapses the sum to $8c_q=0$ (`Finset.sum_ite_eq'`), and `linarith` gives $c_q=0$. **Sound.**
- **`L_anticomm` (line 53).** The Clifford relation mapped to ℝ with the `if_neg` branch gives $L_iL_j+L_jL_i=0$, and `eq_neg_of_add_eq_zero_right` yields $L_jL_i=-(L_iL_j)$. **Sound.**
- **`spin7_eq_span` (line 59), both directions.** `spin7` is spanned by the commutators over all of `Fin 7 × Fin 7`. For $a<b$: $L_aL_b-L_bL_a=L_aL_b+L_aL_b=2G_{(a,b)}$. For $a=b$: the commutator is $0$, closed by `simp`. For $a>b$: `L_anticomm` with $b\ne a$ gives $L_aL_b=-L_bL_a$, so the commutator is $-2G_{(b,a)}$, closed by `abel`. Conversely $G_p=\tfrac12[L_i,L_j]$ lies in `spin7`. All three cases of `lt_trichotomy` are covered. **Sound.**
- **`finrank_spin7`.** `finrank_span_eq_card G_linearIndependent` gives $\dim\mathop{\mathrm{span}}(\mathop{\mathrm{range}}G)=|\mathrm{Pr}|$, and `card_Pr` is $21=\binom72$ by `decide`. **Sound.**
- **`F_zero_proper` (L17WeylIdent.lean line 106).** Assuming the kernel is `⊤`, the witness $H=$ `opB (restrict (Wb_weyl hn))` lies in `weylT n` by `opB_mem_weylT` with `Wb_tangent`, hence in the kernel, hence $F(H)=0$ by `L17_codim`'s iff. `Wb_F_pos` gives $F(H)>0$ at the symmetry proof `opB_isSymmetric (...)`, while `L17_codim` produces `Fval` at `(admissible_of_weylT H.2).symm`. The two are proofs of the same proposition `IsSymmetric`, equal by definitional proof irrelevance, so `(Wb_F_pos hn hN).ne' h0` typechecks on the same real number, and the build confirms it. **Sound.** **CONFIRMED.**

## C. Record accuracy

- **graded-half.md line 551.** The added parenthetical cites `finrank_spin7` for "$\dim=21$" and nothing more. **Accurate.**
- **lean/INDEX.md line 518, the L159 row.** Names `Lz_gram`, `spin7_eq_span`, `finrank_spin7` correctly, adds the file to the column, keeps the state **partial** and the Owed list unchanged. **Accurate.**
- **route-a.md line 93.** The added parenthetical attaches `F_zero_proper` to "a proper subspace" and leaves "therefore measure zero" uncited. **Accurate.**
- **lean/INDEX.md line 480, the L17 row, against route-a.md lines 70 to 100.** r1495's C-1 part 2 is repaired: the prose list now reads "two-sided differentiability exactly on the cone", matching route-a.md line 91. The properness claim now has a theorem and is cited. The measure-zero reading is added to the prose list. The new sentence "so $1451\le\dim\{F=0\}<1637$ at $n=12$" takes the lower bound from `L17_dim_12`, which the row names earlier, so as a statement about what is proved it holds. The commit body's "`L17_proper_12`: 1451 <= dim {F=0} < 1637" and L17WeylIdent.lean's header line 20 attribute both bounds to the new pair in the same loose way, outside the record.

**Gap C-1 (residual of r1495's C-1 part 1).** lean/INDEX.md line 480 keeps the sentence "With the [L17 (statement)] row every clause of the lemma's statement and of its size paragraph is proved." The size paragraph is route-a.md line 93, and its clause "and therefore **measure zero** among directions", with the closing "the readings ... are both false" that rests on it, has no theorem. The same row, two sentences later, lists "the measure-zero reading of properness" as staying prose. The row therefore asserts and denies the same clause. Repair: narrow the sentence to "every clause of the lemma's statement and the size paragraph's dimension bounds and properness are proved", or drop "and of its size paragraph". The **proved** state is unaffected. **CONFIRMED WITH GAP.**

## D. Axioms

- `python3 scripts/misc/axiom_audit.py --only L159Spin7Dim`: "auditing 7 declarations across 1 files, 7/7 clean -- resting on the standard three alone".
- `python3 scripts/misc/axiom_audit.py --only L17WeylIdent`: "auditing 10 declarations across 1 files, 10/10 clean -- resting on the standard three alone".
- The build's only `sorry` warning is L16Statement.lean line 123, a pre-existing file outside this commit. **CONFIRMED.**

## E. Style

- No em dash in any added line of the commit (grep count $0$), and no backticks inside markdown link text (grep count $0$).
- graded-half.md line 551: r1495's style note is repaired. "with $\mathfrak m\cong\mathbb R^7$; since" is now two sentences, and "survives at $n=8$; the $O(8)$ form does not" now reads "survives at $n=8$, and the $O(8)$ form does not".
- Semicolons in the added record text are the row convention of a clause and its axiom fragment ("; standard three axioms"), accepted by r1491 to r1495. The semicolons ending the bullets of L159Spin7Dim.lean's module docstring are list separators in the layer's docstring convention.
- The edited markdown lines (lean/INDEX.md 480 and 518, route-a.md 93, graded-half.md 551) are each one unwrapped line. **CONFIRMED.**

## Verdict

**CONFIRMED WITH GAP.** `finrank_spin7` proves the $\dim\mathfrak{spin}(7)=21$ that graded-half.md line 551 uses, through an orthogonal basis certified in the kernel and a two-way span identity covering $i<j$, $i=j$ and $i>j$. `F_zero_proper` proves $\{F=0\}$ proper in $\mathcal W_n\cap T_uS$ at every $n\ge4$ and `L17_proper_12` gives the strict bound $<1637$ at $n=12$. All 17 declarations on the standard three axioms. r1495's C-1 part 2 and style note E are repaired. Open: C-1, lean/INDEX.md line 480 still says every clause of L17's size paragraph is proved while listing that paragraph's measure-zero clause (route-a.md line 93) as prose.
