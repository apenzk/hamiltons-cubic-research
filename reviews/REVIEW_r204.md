# Review r204, the three dimensions are right and the 65/24 *coordinates* are not, and rank 14 is a theorem about a map the code no longer evaluates

Audited at HEAD `4ba31e2`. Reviewer 204, Gate 2, brief `brief14.md`. Scripts: [scripts/reviewers/r204/](../scripts/reviewers/r204/). Log: [agent_logs/gate2_204.log](../agent_logs/gate2_204.log).

The brief made claims 3 and 4 the priority. Both are answered with derivations, and each splits cleanly into a part that survives and a part that does not. Claims 5 and 6 follow; claims 1 and 2 get a short confirming pass, since r203 has them.

## Verdict table

| claim | verdict | the one line |
|---|---|---|
| 3a. dim = 65, 24, 89, 14 | **UPHELD, three independent routes** | Sage's [WeylCharacterRing](https://doc.sagemath.org/html/en/reference/combinat/sage/combinat/root_system/weyl_characters.html) decomposition reproduces the 24-block table, `Sym^2` = 65 and `Lambda^2` = 24 by **direct plethysm** on a 30,190,335-dimensional module, and `(Sym^6)^{SO(5)}` = 14, none of it by constant-term Weyl integration |
| 3b. the real-type argument | **UPHELD, and verified block by block** | every one of the 24 constituents has trivial multiplicity 1 in `Sym^2 V` and 0 in `Lambda^2 V`, computed independently; "integral for B_2 ⟹ real type" is the correct reading of `so(5) ≅ sp(4)` |
| 3c. **the licence to discard the 24 named coordinates** | **REFUTED, with a proof and a measured witness** | on a multiplicity-2 block the kernel direction is the code's `GAUGE` coordinate **iff h is real there**, and h is measured *non-real* on `(2,0)`. The split `UNK`/`GAUGE` is also moved by rephasing a copy, which every check in the file passes |
| 4a. `mu` surjective, invariants exact | **UPHELD** | `Sym^6` is spanned by products of two cubic monomials; `O(5)` is linearly reductive in characteristic zero, so `V ↦ V^G` is exact and carries the surjection to a surjection. `rank(mu|_inv) = 14` |
| 4b. "no sample points are needed", sampling task retired | **REFUTED** | the theorem gives the rank of the **abstract map**; the file's `A` is the **sampled** coefficient matrix, whose rank is `≤ 14` with equality only if the samples are unisolvent for the 14. Retiring the check removes the pipeline's only end-to-end falsification (r194's diagnostic) |
| 4c. the stage-4 code | **DEAD** | `sample_weyl` and `solve_weight` are defined at lines 486 and 500 and **called nowhere**; `B_ij` is never formed. The module docstring still lists the rank and consistency checks as "checks that can fail, run before the solve" |
| 5a. the three gp/gpmul unit tests | **UPHELD for what they cover, three new escapees** | they catch r201's `i^2 = +1` and the re/im swap. `gpadd` is untested, and three `gpadd` sabotages pass all three tests *and* the Hermitian assert with a wrong h |
| 5b. `det h != 0` | **UPHELD, and 12 of the 24 are vacuous** | fires on coincident copies at `m = 3`; the `m == 1` branch hardcodes `[[(1,0)]]`, so the printed "det h nonzero on all 24" is a check on 12 |
| 5c. the q00 guard | **UPHELD** | fires; unguarded, `pow(0, p-2, p) = 0` makes every h entry `(0,0)`, which is Hermitian |
| 5d. the post-orbit shape assert | **UPHELD, self-referential** | fires on every multiplicity perturbation, but the `lam[1] % 2 == 0` rule it tests against is hardcoded in the same file |
| 6. 16 / 25 / 36, two 3×3, five 2×2, nine scalars | **UPHELD, recomputed from scratch** | reproduced from the Sage block table with no repo input, including the eight dead blocks |
| 1, 2. order-2 vanishing, rank ≤ 13 | **no defect found** | the `lambda_2`-even rule is derived generically and applies to `(2,2)`; the full stabiliser and its identity component give the same 1-dimensional answer, so step (b) is robust either way |

---

## Claim 3a, the three dimensions, by routes that share no step with Weyl integration

[run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py) gets 65, 24 and 14 from the constant-term formula `dim V^G = (1/|W|) CT[chi * prod(1 - t^alpha)]`, with `Sym^k` characters built from power sums by Newton. [sage_blocks.sage](../scripts/reviewers/r204/sage_blocks.sage) and [sage_plethysm.sage](../scripts/reviewers/r204/sage_plethysm.sage) use Sage's Weyl character ring instead: characters are carried as formal sums of irreducibles and products are decomposed by Brauer–Klimyk, so the final step is reading a multiplicity of the trivial representation rather than extracting a constant term.

`Weyl_5` is entered as `B2(0,4)` in coroot coordinates, `4*omega_2`, which is the `[2,2]` the record identifies, and the ring returns dimension 35.

**The 24-block table is reproduced entry for entry**, multiplicities included: `(4,2)` and `(2,2)` at 4, `(3,2)` at 3, nine blocks at 2, twelve at 1, `sum m = 41`, `sum m_lambda d_lambda = 7770`. So the table in [findings/sym3-blocks.md](../findings/sym3-blocks.md) is now confirmed by a second decomposition algorithm.

**65 and 24 are confirmed by direct plethysm, not by the `sum m(m+1)/2` identity.** `S3.symmetric_power(2)` is a module of dimension 30,190,335 and `S3.exterior_power(2)` of dimension 30,182,565; the trivial multiplicities come out 65 and 24, and the tensor square gives 89. That closes the one thing the record's own check could not close on its own, it asserted `(ds, dl, ds+dl) == (sym, anti, herm)`, which tests the constant-term code against the multiplicity table, both of which come from the same character machinery.

**14 is confirmed, and so is the whole low-degree sequence**: degrees 1 through 6 give 0, 1, 1, 4, 5, 14, matching [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py).

## Claim 3b, real type is right, and it is now checked rather than argued

The record's argument is that every constituent is an integral weight of `B_2`, hence a representation of `SO(5)` rather than of `Spin(5) = Sp(2)` alone, and the quaternionic representations of `so(5) ≅ sp(4)` are the half-integral spin ones. That is the correct classical statement.

It is also checkable directly, and the check is the definition rather than the classification: a self-dual irreducible is of real type exactly when the trivial representation appears once in `Sym^2 V` and not at all in `Lambda^2 V`. Over all 24 constituents, `sage_blocks.sage` returns `(1, 0)` every time, `blocks NOT of real type: []`.

**What real type buys, stated precisely.** `U = Sym^3(Weyl_5)` is a real `O(5)`-module. For an invariant Hermitian form `H` on `U_C`, write the restriction to real vectors as `H|_{U x U} = S + iA` with `S` real symmetric and `A` real antisymmetric, both invariant. Because `W^3` is a real vector,

    q(W) = H(W^3, W^3) = S(W^3, W^3),

so the kernel of `H ↦ q` is exactly `{H : S = 0} = i·(Lambda^2 U*)^{O(5)}`, of real dimension 24, and the quotient is `(Sym^2 U*)^{O(5)}`, of dimension 65. **89 = 65 + 24 is a theorem and the 24 really are gauge.** The Hermitian ansatz is also complete and loses nothing: the sesquilinear extension of a PSD invariant `S` is a PSD invariant `H` restricting to it, so the two feasible sets correspond.

## Claim 3c, but the 24 the code names are not those 24, and h being non-real is the proof

This is the tension the brief asks to resolve, and it does not resolve the way the record says.

Stage 4 of [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) builds three lists: `HERM`, all `m^2` real Hermitian coordinates per block; `UNK`, the `re` coordinates, 65 of them; `GAUGE`, the `im` off-diagonal coordinates, 24 of them. The surrounding comment calls `GAUGE` "the Lambda^2 part", says the directions "lie in the kernel", and says they "must be quotiented out".

**Which coordinates the kernel occupies depends on the basis of the multiplicity space `M_lambda`, and the code's basis is demonstrably the wrong one.** Let `xi_a` be a basis of `M_lambda` real for the real structure `sigma` that real type provides. In that basis, and only in bases related to it by `GL(m, R)`, the kernel is `{i · real antisymmetric}`, the `im` coordinates. In that basis the multiplicity Gram is also forced real:

    h_ij = <v_i, v_j> = b(xi_i, xi_j) · ||w||^2,     b real symmetric, ||w||^2 > 0.

So a `sigma`-real basis gives a **real symmetric h**. The measured h on `lambda = (2,0)` is `[[1, 55i/37], [-55i/37, 5075/1628]]` (r192, reproduced by r201 and r202). The basis in hand is therefore not `sigma`-real, which the record says, and then it uses the labelling that requires `sigma`-reality anyway.

**The failure is provable, not merely possible** ([gauge_split.py](../scripts/reviewers/r204/gauge_split.py)). Write the change of basis as `Q = A + iB` with `A, B` real, absorbing the Cholesky factor of `h_R` into `Q` (`X^T J X = det(X) J` in two dimensions, so `J` is only rescaled). Then

    kernel direction   K = i(det A + det B) J − S,   S = A^T J B + (A^T J B)^T,
    multiplicity Gram  h = (A^T A + B^T B) + i(A^T B − B^T A).

`K` is a real multiple of the code's `GAUGE` direction `iJ` exactly when `S = 0`; `S = 0` rewrites as `J X = X^T J` for `X = A^{-1} B`, whose only solutions are `X = a·I`, i.e. `B = aA`; and `B = aA` forces `Im h = 0`. Contrapositive, verified symbolically in the script:

> **`Im h != 0` on a multiplicity-2 block ⟹ the kernel direction is not the code's `GAUGE` coordinate there.**

Sampling 4000 bases `Q` with `Q^† Q` equal to the measured h (`Q ↦ UQ` for unitary `U` is the entire remaining freedom), the relative distance from the kernel direction to `iJ` never drops below **0.541**.

**The implication is one-way, so "make h real" is not the repair either.** With `Q = diag(1, i)` the Gram is `h = I`, perfectly real, and the kernel direction comes out `[[0,-1],[-1,0]]`, real symmetric, sitting *inside* the 65 that the code keeps. In that basis dropping the `im` coordinates retains a direction that maps to zero and the surviving 65 parametrise only 64 distinct quadratic forms.

**And the split is not gauge-invariant, which settles it on its own.** Nothing in the pipeline pins the phase of a highest-weight vector. Replace `v_2` by `i·v_2` on block `(2,0)`: h becomes `[[1, -55/37], [-55/37, 5075/1628]]`, still Hermitian, same determinant, and consistent across every probe because the rescaling is uniform. The Hermitian assert passes, `det h != 0` passes, the multi-probe `dis == 0` passes, and `UNK`/`GAUGE` now name a *different* 65-dimensional subspace of the 89. A labelling that a free phase choice moves cannot be "the `Lambda^2` part".

**What is actually true, and what has to replace the labelling.** The dimensions 65, 24 and 89 stand. The 51-dimensional unrestricted family and the 36 post-orbit unknowns stand as *dimensions*. What does not stand is any implementation that drops the `im` coordinates and solves over the remaining 65 (or 36). The kernel has to be computed, not named, and the direct way to compute it is to evaluate `Im B_ij(W)` at sample points, because

    q(W) = sum_ij Re(G)_ij Re(B_ij)(W) + sum_ij Im(G)_ij Im(B_ij)(W),

so the `im` coordinates of `G` drop out exactly when `Im B_ij` vanishes identically. Which brings the sampling back, from a second direction.

## Claim 4, the mathematics is right and the conclusion drawn from it is too strong

**`mu` is surjective.** `Sym^6 W*` is spanned by degree-6 monomials in a basis of `W*`, and every such monomial is a product of two degree-3 monomials, so `Sym^3 W* ⊗ Sym^3 W* -> Sym^6 W*` is onto; it is symmetric, so it factors through `Sym^2(Sym^3 W*)`. `O(5)` acts by algebra automorphisms of the polynomial ring, so `mu` is equivariant. Correct.

**Exactness is being applied correctly.** `O(5)` is linearly reductive in characteristic zero, every rational representation is semisimple, and `V ↦ V^G` is the projection onto the isotypic component of the trivial representation, an exact functor. An exact functor carries a surjection to a surjection, so `mu` restricted to invariants is onto `(Sym^6 W*)^{O(5)}`, which has dimension 14. Correct. The identification of the Gram space with `Sym^2(Sym^3 W*)` is also legitimate: an invariant inner product on `Sym^3 W*` identifies it equivariantly with its dual, and pulling back along the Veronese `W ↦ W^3` is exactly `mu`.

**The overreach is in the word `A`.** `rank(mu|_inv) = 14` is a statement about a map between two abstract spaces. The `A` in the file's own docstring, "the coefficient matrix must have rank EXACTLY 14", "the test with real content is CONSISTENCY, `rank(A) = rank[A | F_5]`", is the matrix of `B_ij` **evaluated at sample points**. Its rank is at most 14 and equals 14 only if evaluation at those points is injective on the 14-dimensional space of invariant sextics. The theorem says nothing about that, and r194's "the check is vacuous below 15 sample points" is untouched by it.

**Worse, the check was doing work the theorem cannot do.** r194 catalogued what `rank > 14` diagnoses: copies that are not genuine isotypic components, a `Q` that is not an invariant form, an adapted basis not held fixed across samples, arithmetic error. Every one of those is a claim about the *code*, and each is refuted by a measured rank exceeding a bound the *mathematics* guarantees. Replacing the measurement by the theorem removes the only place in the pipeline where the mathematics and the code are made to meet. Consistency likewise: `rank(A) = rank[A | F_5]` follows from `rank(A) = 14` **at the sample points**, so it too reduces to a measurement, not to a theorem.

**And the code that would do it is dead.** `sample_weyl` (line 486) and `solve_weight` (line 500) are defined and called nowhere in the file; `B_ij` is never formed. Meanwhile the module docstring still opens with "Checks that can fail, run before the solve" and lists four, of which the rank and consistency checks now run nowhere and the other two run. This is the same defect class the record has caught three times, `det_p` dead at `c6da435`, the docstring describing checks that did not run at r193/r194, and `run_n5_evaluate.py` at r191.

**So the retired sampling task must come back**, with a narrower job than it had: not "read off the rank" but "confirm the sample points are unisolvent for the 14, and that the pipeline realises the bound the theorem proves". Fifteen points is the floor; the theorem tells you what the answer must be, which makes it a sharper test than before, not a redundant one.

## Claim 5, the four repairs, planted

[plants.py](../scripts/reviewers/r204/plants.py) transcribes `PRIME`, `gp`, `gpmul`, `gpadd`, `gpconj`, the three unit tests and `_det_g` verbatim from the file under review, then sabotages them.

**The three unit tests.** They fire on r201's two escapees, as claimed: `i^2 = +1` trips both the `i^2` test and the ring-map test, and the re/im swap trips the slot test and the ring-map test. A new sabotage, `gpmul` computing `im = u0v1 − u1v0`, is caught by the ring-map test alone.

**Three new escapees, all in `gpadd`.** The tests touch `gpmul` and `gp` only. `gpadd` is the accumulator inside `ip3_g`, where every entry of h is formed, and it is tested by nothing:

| sabotage | unit tests | Hermitian assert | h correct |
|---|---|---|---|
| `gpadd` subtracts the second imaginary part | none fire | passes | **no** |
| `gpadd` drops the second imaginary part | none fire | passes | **no** |
| `gpadd` doubles the second imaginary part | none fire | passes | **no** |

The middle one is the one to fix first. If `gpadd` ignores `v[1]`, the accumulator never carries an imaginary part at all, so **h comes out exactly `Re(h)`, real symmetric.** That is precisely the observation the record reads as evidence about whether the basis is `sigma`-real. The corruption does not merely escape the checks; it manufactures the evidence for the conclusion stage 4 draws from h. A one-line `gpadd` round-trip against exact `Fraction` arithmetic closes all three, at the same `O(1)` cost as the tests already there. `gpconj` is likewise untested, though the Hermitian assert does catch replacing it by the identity.

**`det h != 0`.** `_det_g` reproduces the exact Gaussian determinant on 300 random matrices of sizes 2 to 4. It fires on the all-ones matrix that coincident copies produce, for every `m > 1`, as the commit claims.

Two limits. First, **12 of the 24 blocks are vacuous**: the `m == 1` branch sets `HMAT[lam] = [[(1,0)]]` as a literal before any inner product is taken, so `_det_g` returns `(1,0)` unconditionally there. The line printing "det h nonzero on all 24" is a check on 12.

Second, and this is the intended limit rather than a defect, `det h != 0` tests exactly one property, that the copy list has full rank. Every element of `GL(m, C)` acting on the copies passes it, passes the Hermitian assert, and passes the multi-probe test, because a linear change of copies is uniform across probes and leaves the Schur ratios consistent. Verified on the measured `(2,0)` block for `v_2 ↦ i v_2`, `v_2 ↦ v_1 + v_2` and the transposition. Those genuinely are gauge for the mathematics, and they are exactly the freedom under which stage 4's `UNK`/`GAUGE` labelling moves, which is claim 3c.

**The q00 guard** fires on a killed normaliser. Unguarded, `den = 0` and `pow(0, p-2, p) = 0`, so every h entry is `(0,0)` and the Hermitian assert passes on an identically-zero h, as the comment says.

**The post-orbit shape assert** fires under every perturbation of the multiplicities tried, `m[(3,2)] += 1`, `m[(2,0)] += 1`, `m[(4,3)] += 1` all break `two 3×3, five 2×2, nine scalars`. It is self-referential in one respect worth stating: `SURV` is built from `lam[1] % 2 == 0` hardcoded five lines above, so the assert tests the multiplicity table against the `lambda_2`-even rule and tests the rule against nothing.

**What all four still miss, together.** The pair form `gp`/`gpmul`/`gpadd`/`gpconj` was adopted because folding `i` into a single residue makes re and im unrecoverable (r200). It reaches `ip3_g`, and `ip3_g` is used only to measure h and run the multi-probe check. `Q` is built by `ip3` and the coordinates by `solve_weight`, and both call `to_p`, which is the collapsing map `a + b·IMOD mod p`. So every quantity stage 4 needs (`Q`, the coefficients `c^{lambda,i}`, hence `B_ij`), is computed in exactly the representation the pair form exists to avoid, and `Im B_ij(W)` is not recoverable from the shipped arithmetic. That is the same measurement claim 3c needs.

## Claim 6, the post-orbit counts, recomputed from scratch

Recomputed in [plants.py](../scripts/reviewers/r204/plants.py) section C from the Sage block table, with no input from `ADAPTED` or from the record.

Sixteen blocks have `lambda_2` even. Eight of them have multiplicity 1 and die outright, `(0,0)`, `(1,0)`, `(5,0)`, `(5,4)`, `(6,0)`, `(6,2)`, `(6,4)`, `(6,6)`, matching the record's list. The eight even survivors carry `4→3`, `4→3`, `3→2`, `2→1`, `2→1`, `2→1`, `2→1`, `2→1`; the eight odd blocks are untouched at `2, 2, 2, 2, 1, 1, 1, 1`. That is **16 blocks, 25 multiplicities, shaped two 3×3, five 2×2 and nine scalars**, giving `sum m(m+1)/2 = 36` and `sum m^2 = 47`. Confirmed.

One structural point the record states loosely and which is worth pinning, because it is what makes "one condition per block" right. The certificate cubics must vanish on the whole `O(5)`-orbit of `W_0`, not at `W_0` alone; a single point would be codimension 1 in the 7770. The orbit condition is `p ⊥ span{(g W_0)^3}`, and that span is the 3570-dimensional submodule, one copy in each `lambda_2`-even block. So `K` has dimension 4200 and each even block loses exactly one multiplicity. The 3570 is the number r178 proved by a mod-`p` Gram rank meeting the `sum d_lambda` cap.

## Claims 1 and 2, a confirming pass

r203 has these. Nothing found against them, and two of the brief's specific questions have short answers.

**Is the `lambda_2`-even rule legitimately applied to `Weyl_5` itself?** Yes. Its derivation in [findings/sym3-blocks.md](../findings/sym3-blocks.md) is generic, branch `so(5) -> su(2)_L ⊕ su(2)_R`, note the unique constituent with `j_L = 0` is `(lambda_2, -lambda_2)`, so `U(2)`-invariants are always one-dimensional, and the extra component acts on the `m = 0` vector of spin `j` by `(-1)^j`. Nothing in it is special to constituents of `Sym^3`, and `(2,2)` is one of the file's own hand-checks.

**Full stabiliser or identity component?** Both give the same answer here. For the identity component `U(2)`, the branching argument gives `dim V^{H_0} = 1` for every `lambda`; the extra component can only cut that to 0, and does so exactly when `lambda_2` is odd. `Weyl_5 = V_{(2,2)}` has `lambda_2 = 2`, so `(Weyl_5)^{H_0}` and `(Weyl_5)^H` are both one-dimensional and both are `span(W_0)`. Step (b) is robust to the ambiguity.

**Steps (a) and (c).** Equivariance of the gradient needs one fixed invariant metric, and Euler's identity `sum_i W_i ∂_i p = 6p` is the pairing of `grad_g p` with `W` for that same `g`; the normalisation `|W_0|^2 = 1` is in the same metric. Consistent as written. The conclusion is that order-2 vanishing adds nothing to order-1 vanishing, so the cap on the restricted rank is 13 and it comes from order 1 alone, which is how the commit states it.

**Claim 2's containment and the 13.** Evaluation at `W_0` is nonzero on the 14 because `||W||^6` takes the value 1 there, so the invariant sextics vanishing at `W_0` form a 13-dimensional subspace; a product of two orbit-constrained cubics vanishes at `W_0`; the containment follows. Correct.

**Tightness, reformulated.** Because invariants is exact, the image of `Sym^2(K)^{O(5)}` is `(K·K)^{O(5)}`, where `K·K` is the span of products of two orbit-vanishing cubics inside `Sym^6 W*`. The invariant sextics vanishing on the orbit are the 13. So

> the restricted rank is 13 exactly when every invariant sextic vanishing at `W_0` is a sum of products of two orbit-vanishing cubics, i.e. when the degree-6 part of the ideal of the orbit cone is generated by its degree-3 part, on invariants.

The 65 splits as `36 + 13 + 16` over `Sym^2(K)`, `K ⊗ N` and `Sym^2(N)`, and the first two both land inside the 13, so the whole of the missing fourteenth direction comes from `Sym^2(N)`. A lower bound is available without assuming `F_5` is in the image: the 25 diagonal covariant norms `<sigma_lambda(W), sigma_lambda(W)>` over the surviving multiplicities are invariant sextics vanishing at `W_0` and lie in the image by construction, so the rank is at least the dimension of their span, which is a rank of a 25-column matrix at sample points, and needs `B_ij`, which is the same dead code as claim 4c.

---

## What to change

1. **Stop labelling the 24.** Delete the `UNK`/`GAUGE` split, or keep the 89-parameter Hermitian ansatz (it is complete and loses nothing) and record 65 as the effective dimension rather than as a coordinate subset. Any solve over "the 65 `re` coordinates" is over an unjustified subspace.
2. **Bring the sampler back**, with the job stated as unisolvence: `rank(A) = 14` at `>= 15` sample points, which the theorem now makes a sharp two-sided test of the pipeline rather than an estimate of an unknown number. Delete `sample_weyl` and `solve_weight` or call them; do not leave them defined.
3. **Test `gpadd` and `gpconj`** with the same `O(1)` round-trip already used for `gpmul`. Three `gpadd` sabotages currently pass every check in the file, and one of them makes h come out real.
4. **Fix the "det h nonzero on all 24" line** to say 12, or compute h on the `m == 1` blocks instead of hardcoding it.
5. **Carry the pair form into `ip3` and `solve_weight`**, since `Im B_ij` is the measurement both claim 3c and the tightness question in claim 2 need, and `to_p` destroys it.
