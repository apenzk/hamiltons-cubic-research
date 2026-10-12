# r1831: FourPi.lean, L220 step 2's other two products

*Gate 2 review of [FourPi.lean](../lean/HamiltonsCubic/Results/FourPi.lean) at commit afdc815b and that commit's edit to the [L220] result row of [lean/INDEX.md](../lean/INDEX.md). The file compiles with no errors and no `sorry`, all seven declarations rest on the standard three axioms, `PiQ_mul`'s formula is right at every entry class, and together with `nu_sq` the file covers the record's step 2. Two observations need a repair: `Dnu_char` proves the character but leaves the Weyl half of "∈ V_Q" to an unstated one-line call, and the L220 (statement) row still lists step 2's products as owed, contradicting the result row that defers to it.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `PiQ_mul`: Π_Q(x,y,z)∘Π_Q(x′,y′,z′) = Π_Q(xx′+yz′+zy′, yy′+zx′+xz′, zz′+xy′+yx′) (question b) | CONFIRMED |
| 2 | `PiQ_mul` with `PiQ_weight` is the record's "Π_Q is a subalgebra of D_n" (question a) | CONFIRMED WITH OBSERVATIONS |
| 3 | `sum_Q`, `PiQ_T`, `PiQ_hollow`, `PiQ_off` state what their names and docstrings say | CONFIRMED |
| 4 | `Dnu_char` is the record's "D∘ν ∈ V_Q by L120" (question c) | CONFIRMED WITH OBSERVATIONS |
| 5 | The INDEX result row's "Step 2 is complete on the operators", with step 2 removed from Owed and r1830's flag repaired (question d) | CONFIRMED WITH OBSERVATIONS |
| 6 | Build and axiom audit | CONFIRMED |
| 7 | Hand evaluation at (1,1,−2), (1,−2,1) | CONFIRMED |

**Summary:** the mathematics of step 2 is fully covered, with one Weyl conjunct left implicit in `Dnu_char` and one stale owed list in the L220 (statement) row.

## 1. The record

[findings/second-order.md](../findings/second-order.md), Lemma L220, Setting: "$\Pi_Q\subset\mathcal D_n$ is the plane of sectional matrices supported on $Q$, $K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$ with $x+y+z=0$".

Step 2: "$\Pi_Q$ is a subalgebra of $\mathcal D_n$, since a hollow matrix supported on $Q$ with zero row sums has $S^{\circ2}+S^2$ supported on $Q$ off the diagonal with zero row sums … And $D\circ\nu\in V_Q$ by L120."

Statement: "$V_Q$ the four-set block of character $\chi_Q$", a block of L120's decomposition of $\mathcal W_n$, so V_Q is the Weyl operators of character χ_Q.

`PiQ i j k l x y z` in [FourProd.lean](../lean/HamiltonsCubic/Results/FourProd.lean) is x(E2 i j + E2 k l) + y(E2 i k + E2 j l) + z(E2 i l + E2 j k), with E2 p q the symmetric pair of unit matrices. Its entries are exactly the Setting's K, so Π_Q in the record is {PiQ(x,y,z) : x+y+z = 0}. No surjectivity lemma is needed, since the record defines Π_Q by the pattern.

## 2. `PiQ_mul`'s formula by hand (claim 1)

`foxProd2_coordOp` in [ItemFour.lean](../lean/HamiltonsCubic/Results/ItemFour.lean) gives coordOp a ∘ coordOp b = coordOp(a⊙b + ½(ab+ba)) for symmetric hollow a, b. `coordOp_congr_off` then compares off the diagonal only. Write a = PiQ(x,y,z), b = PiQ(x′,y′,z′).

- **Entry ij.** (a⊙b)_ij = xx′. (ab)_ij = a_ik b_kj + a_il b_lj = yz′ + zy′, the terms r = i, j vanishing by hollowness and r ∉ Q by support. (ba)_ij = y′z + z′y. Half the sum is yz′+zy′. Total xx′+yz′+zy′. Matches.
- **Entry ik.** yy′ + ½((xz′+zx′) + (x′z+z′x)) = yy′+zx′+xz′. Matches.
- **Entry il.** zz′ + ½((xy′+yx′) + (x′y+y′x)) = zz′+xy′+yx′. Matches.
- **Entry kl.** xx′ + ½((a_ki b_il + a_kj b_jl) + (b_ki a_il + b_kj a_jl)) = xx′ + ½((yz′+zy′)+(y′z+z′y)) = xx′+yz′+zy′. Matches the ij value, as the pattern requires. The remaining pairs jk, jl follow by the same Klein-group symmetry of the pattern.
- **Entry ir with r ∉ Q.** a⊙b vanishes there, and (ab)_ir = Σ_s a_is b_sr = 0 since b_sr = 0 for r ∉ Q. Likewise (ba)_ir. Entry 0, matching PiQ_off.
- **Diagonal.** (ab)_ii = xx′+yy′+zz′, generally nonzero. `coordOp_congr_off` discards it, which is the record's "supported on $Q$ off the diagonal".

The three values sum to the nine products x_α x′_β over all pairs, which is (x+y+z)(x′+y′+z′). So two factors in Π_Q give a product in Π_Q. CONFIRMED.

## 3. Subalgebra of D_n (claim 2)

- **Bilinear against square.** The record argues with $S^{\circ2}+S^2$, which is `Qop2_coordOp`'s square. `PiQ_mul` gives the bilinear product. On a linear subspace the two are equivalent by polarisation, and `foxProd2` is defined as the polarisation ½(Q(X+Y) − Q(X) − Q(Y)). At x = x′, `PiQ_mul` gives x² + 2yz, the square's pattern. So `PiQ_mul` is the record's claim, in its bilinear form.
- **Membership in D_n.** `PiQ_weight` gives IsWeight (symmetric, hollow, zero row sums) at x+y+z = 0. Row i's sum is x+y+z by `sum_Q`, and rows off Q vanish. With `coordOp_eq_restrict` this places coordOp(PiQ) in D_n.
- **O1.** "Π_Q is closed under ∘" is assembled in the docstring from `PiQ_mul` plus the arithmetic (x+y+z)(x′+y′+z′) = 0. No theorem states the closure itself, for instance ∀ x y z x′ y′ z′ with both sums zero, ∃ x″ y″ z″ with x″+y″+z″ = 0 and the product equal to coordOp(PiQ x″ y″ z″). The step is one `ring`, and r1830 O1 asked for the same handle on the ν∘ν side. A named Π_Q set with a closure lemma would make "subalgebra" literal.

## 4. Helper lemmas (claim 3)

`sum_Q` reduces a sum vanishing off Q to its four values via `Finset.sum_subset` and the distinctness hypotheses. `PiQ_T` is symmetry, `PiQ_hollow` the zero diagonal, `PiQ_off` vanishing in any column outside Q. Each statement matches its docstring. CONFIRMED.

## 5. `Dnu_char` against "D∘ν ∈ V_Q by L120" (claim 4)

- `Dnu_char` takes SignChar 1 on D and SignChar χ_Q on ν and returns SignChar χ_Q on foxProd2 D ν, through `foxProd2_char2` in [L222Op.lean](../lean/HamiltonsCubic/Results/L222Op.lean) and `signChar_congr` with 1·χ_Q = χ_Q. This is the "by L120" half: characters multiply.
- **Hypothesis on D.** SignChar 1 is weaker than D ∈ D_n. Every element of D_n has it, by `trivial_block_iff` in [L120Ident.lean](../lean/HamiltonsCubic/Results/L120Ident.lean). So the hypothesis is a harmless generalisation.
- **O2.** V_Q membership needs the Weyl property as well as the character. `Dnu_char` does not state it. It follows in one line from `isWeyl2_foxProd2` in [L24Restrict.lean](../lean/HamiltonsCubic/Results/L24Restrict.lean) at Weyl D and ν, and D_n ⊂ W_n. The mathematics is covered by existing theorems, but the INDEX row's "$D\circ\nu$ has character $\chi_Q$" is accurate while the commit title's "D∘ν ∈ V_Q" is a conjunction of two theorems, one of which the file does not cite. A two-conjunct corollary, or a mention of `isWeyl2_foxProd2` in the row, would close it.

## 6. The INDEX row (claim 5)

- **The result row.** It now lists FourPi.lean, describes `PiQ_mul`, `PiQ_weight`, `Dnu_char` accurately, and its Owed list drops "step 2's products, that $\Pi_Q$ is a subalgebra of $\mathcal D_n$, $\nu\circ\nu\in\Pi_Q$ with its pattern, and $D\circ\nu\in V_Q$ as an operator statement". That repairs r1830's flag on the result row. Step 2's three clauses are covered: the subalgebra by `PiQ_mul` and `PiQ_weight`, ν∘ν ∈ Π_Q with its pattern by `nu_sq` (FourProd, on FourSquare and FourIdent, r1830 CONFIRMED), and D∘ν ∈ V_Q by `Dnu_char` with `isWeyl2_foxProd2` (O2). "Step 2 is complete on the operators" is accurate.
- **O3.** The L220 (statement) row, line 151 of [lean/INDEX.md](../lean/INDEX.md) at HEAD, still ends its Owed list with "step 2's products, that $\Pi_Q$ is a subalgebra of $\mathcal D_n$, $\nu\circ\nu\in\Pi_Q$ with its pattern, and $D\circ\nu\in V_Q$ as an operator statement", and carries no account of FourSquare, FourIdent, FourProd or FourPi. The result row says "The full account, with its Gate 2 history, is in the L220 (statement) row above", so the row it defers to contradicts it. The statement row needs the same deletion and the four files' account.
- **O4.** The edit leaves a double space in the result row's Owed list: "(r1792 O6);  $L_r\nu=0$".
- **O5.** r1830 O5's mixed product ν∘ν′ ∈ Π_Q, which step 4 uses, belongs to step 4 in the record, so its absence from step 2 is correct. It is covered in the Owed list only implicitly, under "$L_r\nu=0$". Naming it there would keep it from being lost now that step 2 has left the list.

## 7. Build and audit (claim 6)

- `lake env lean HamiltonsCubic/Results/FourPi.lean`: exit 0, no errors, no `sorry`.
- **O6.** Linter warnings only: unused section variables in `PiQ_T` and `PiQ_off` (they need no distinctness), nine unreachable `<;> ring` tails in `PiQ_mul`'s case tree, and fourteen unnecessary `<;>`. Cosmetic, and `omit … in` on the two lemmas would drop six needless hypotheses from their signatures.
- `python3 scripts/misc/axiom_audit.py --only FourPi.lean`: "7/7 clean -- resting on the standard three alone". CONFIRMED.

## 8. Hand evaluation (claim 7)

*Exact hand evaluation, reported as a screen of the formula, with the kernel proof of `PiQ_mul` carrying the claim.*

(x,y,z) = (1,1,−2), (x′,y′,z′) = (1,−2,1), both summing to 0.

- From `PiQ_mul`: x″ = 1·1 + 1·1 + (−2)(−2) = 6, y″ = 1·(−2) + (−2)·1 + 1·1 = −3, z″ = (−2)·1 + 1·(−2) + 1·1 = −3. Sum 0, as (x+y+z)(x′+y′+z′) = 0 requires.
- Direct at ij: (a⊙b)_ij = 1. (ab)_ij = a_ik b_kj + a_il b_lj = y z′ + z y′ = 1·1 + (−2)(−2) = 5. (ba)_ij = b_ik a_kj + b_il a_lj = y′ z + z′ y = (−2)(−2) + 1·1 = 5. Entry 1 + ½·10 = 6. Agrees.
- Direct at ik, as a second check: (a⊙b)_ik = −2, (ab)_ik = x z′ + z x′ = 1 − 2 = −1, (ba)_ik = x′ z + z′ x = −2 + 1 = −1. Entry −2 − 1 = −3. Agrees.
- Diagonal ii: xx′+yy′+zz′ = 1 − 2 − 2 = −3, discarded by `coordOp_congr_off`.

## 9. What would falsify each headline

- Claims 1 and 7: an off-diagonal entry pair of Q where a⊙b + ½(ab+ba) differs from the stated triple. None exists by §2, and the kernel checks all 16 off-diagonal cases.
- Claim 2: a pair in Π_Q whose product leaves Π_Q, which would need the product's three values to have nonzero sum. Their sum is (x+y+z)(x′+y′+z′).
- Claim 4: V_Q containing a requirement beyond Weyl and character χ_Q. The Statement defines it as L120's block of that character.
- Claim 5: a clause of the record's step 2 with no covering theorem. The three clauses map to `PiQ_mul` with `PiQ_weight`, `nu_sq`, and `Dnu_char` with `isWeyl2_foxProd2`.
- Claim 6: an axiom beyond propext, Classical.choice and Quot.sound in the audit output.
