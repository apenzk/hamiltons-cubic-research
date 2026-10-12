# REVIEW r1770: L120Decomp.lean (c371ef44) and L1_eq (f4cb8f54)

| Claim | Verdict | Reason |
|---|---|---|
| A, L120 decomposition and block-by-block second order (`weylPerp_decomp`, `hess_blocks`) | CONFIRMED WITH OBSERVATIONS | the projector, its character and the covering are correct, and the owed identification of the nonzero blocks is recorded as owed, while the file header reads as if it were done |
| B, L1's equality clause (`L1_eq`) | CONFIRMED WITH OBSERVATIONS | the statement matches the record's "up to $S_n$ alone", positive multiples only, and problem.md still calls the clause untyped |

**Summary.** Both commits prove what they claim on three standard axioms. The observations are one stale record sentence, one overreaching docstring paragraph, and two readings the record uses that the Lean reaches only through already-proved bridges.

Standing rule: analysis only. The one run was `lake env lean` on a four-line `#print axioms` check file kept in the scratchpad.

## 1. Is `proj t` the isotypic projector?

Yes.

- `chi t u = ∏_{i∈t} (if i ∈ u then -1 else 1)`, which is $(-1)^{\lvert t\cap u\rvert}$, the character $\chi_t$ of $\Gamma\cong(\mathbb Z/2)^n$ evaluated at $g_u=$ `diagSet u`. The characters are real and $\pm1$-valued, so the usual conjugate plays no part.
- `proj t B = 2^{-n} Σ_u chi t u • act (diagSet u) B` is the standard formula $\frac1{\lvert\Gamma\rvert}\sum_g\chi(g)\,g\cdot B$.
- `proj_flip`: `act (flip m)` composed with `act (diagSet u)` is `act (diagSet (u ∆ {m}))` (`act_comp`, `flip_diagSet`), and `u ↦ u ∆ {m}` is an involution, hence a permutation of `Finset ι` (`Function.Involutive.toPerm`). Reindexing by it and using `chi_symmDiff` (flipping $m$ in $u$ multiplies $\chi_t(u)$ by $-1$ exactly when $m\in t$) gives the factor `if m ∈ t then -1 else 1` = `∏_{i∈t} sgn i m`. The reindexing is correct.
- `proj_signMat` passes from flips to every sign matrix through `signMat_eq_diag_set` and `act_diag_set`, with character `setChar t ε = ∏_{i∈t} ε_i`. The convention `act g R Z = g R(gᵀZg) gᵀ` matches `HasChar`'s `S * extend R (Sᵀ Z S) * Sᵀ`.
- `sum_chi`: `Finset.prod_one_add` over `univ` with `powerset univ = univ` gives $\sum_t\prod_{i\in t}f(i)=\prod_i(1+f(i))$, which is $2^n$ at $u=\varnothing$ and has a zero factor $1+(-1)$ at any $x\in u$ otherwise. Correct.
- `sum_proj` swaps the sums, keeps only $u=\varnothing$, and `diagSet ∅ = 1`, `act_one` close it. It holds on all of `CurvLin`.

Idempotence and mutual orthogonality of the `proj t` are not proved in this file. Nothing downstream here needs them: `hess_blocks` uses existence of the decomposition, and the cross terms are removed by `char_orth`.

## 2. Does `comp` lose anything through `extendL` and `restrict`? Is `sum_comp` exactly $v=\sum_tV_t$?

Nothing is lost, and `sum_comp` is exactly $\sum_t$ `comp t R h` $=R$ as `CurvOp2`.

- `extendL R` is `extend R` (precomposition with `skewProj`) bundled as a linear map. `extendL_mem` shows it lies in `weylModuleS`: `isWeyl_extend` for the Weyl clauses, and it kills symmetric $Z$ since `skewProj Z = 0`.
- `proj_mem` keeps `proj t (extendL R)` in `weylModuleS` (each `act (diagSet u)` does, `diagSet_orth`), so `.1` supplies the `IsWeyl` that `restrict` needs.
- `sum_comp` is evaluated pointwise at skew $X$: the coercion of the sum is the sum of coercions (`Submodule.coe_sum`), `LinearMap.sum_apply` and `sum_proj` collapse it to `extendL R X`, and `extend_apply` returns $R X$. The identity is checked on every element of $\Lambda^2$, which is the whole domain of `CurvOp2`.
- `comp_char` reads `proj_signMat` at $Z$ and passes it through `hasChar_restrict`, whose hypothesis is on skew $Z$ only, and $S^\top ZS$ is skew there.
- `weylPerp_decomp` then states $\sum_tV_t=v$ in `weylPerpR a` by `Subtype.ext` and `sum_comp (tanV v)`. That is the record's $v=\sum_tV_t$.

## 3. The $t=\varnothing$ component, and where $\Gamma$-fixedness enters

The argument is correct.

- For $t\ne\varnothing$, `setChar_sep` gives $\varepsilon$ with $\chi_\varnothing(\varepsilon)\chi_t(\varepsilon)=-1$, and `char_orth` with `hfix` (character constantly $1$) gives $\langle a,V_t\rangle=0$.
- For $t=\varnothing$, $\langle a,v\rangle=0$ and `innerOp2_sum'` expand $\langle a,\sum_tV_t\rangle$ as $\langle a,V_\varnothing\rangle+\sum_{t\ne\varnothing}\langle a,V_t\rangle=\langle a,V_\varnothing\rangle$, so $\langle a,V_\varnothing\rangle=0$. This is the proof by difference the docstring names.
- In `weylPerp_decomp`, `hfix` is used only in `comp_perp_ne`, that is only through `char_orth`. `sum_comp` and `comp_char` hold for any $a$. In `hess_sum_blocks` and `hess_blocks`, `hfix` enters a second time through `hess_blockwise`, which calls `hessOp_char` (the Hessian preserves each character at a $\Gamma$-fixed $a$). That second use is L120Blocks.lean's (r1769) and is necessary: the block-diagonality of $L_e$ is what $\Gamma$-fixedness buys.

## 4. Is `hess_blocks` the record's "checkable block by block"? What else is missing?

It is the record's sentence at the level of the Hessian form. The record, [second-order.md](../findings/second-order.md) Lemma L120, reads:

> "**and at every diagonal $M$, ... the operator $L_M$ preserves each summand. Hence the Hessian of $P$ on the sphere is block-diagonal in the same way, and Lemma L24's criterion is checkable block by block **once $\mathcal D_n$ is cut by $\langle M\rangle$**"

and

> "**$W^\perp$ cuts $\mathcal D_n$ and nothing else**, since $M$ spans the trivial character and every other summand lies wholly inside $W^\perp$ by isotypic orthogonality."

- `hess_blocks` states: at a $\Gamma$-fixed unit critical Weyl $a$ with $P(a)\ne0$, $\mathrm{hess}\le0$ on $W^\perp$ iff $\mathrm{hess}\le0$ on each set of $v\in W^\perp$ of character $\chi_t$. The forward direction is restriction. The reverse direction is `hess_sum_blocks` plus `Finset.sum_nonpos`. Both are sound.
- The cut is built in: the blocks are subsets of $W^\perp=\mathcal W_n\cap a^\perp$, so the trivial block is (trivial-character part of $\mathcal W_n$) $\cap\,a^\perp$. The second quoted sentence, that only the trivial block is cut, is exactly `comp_perp_ne`.
- `setChar_four` is a one-line evaluation of $\chi_{\{i,j,k,l\}}$ at distinct indices. Correct, and it enters no theorem in the file.

Missing, beyond the recorded owed identification:

- **O2 (docstring overreach).** The module header's last paragraph says which blocks are nonzero, and that $t=\varnothing,\{j,k\},\{i,j,k,l\}$ are $\mathcal D_n\cap a^\perp$, the pair and the four-set summands, "is L120Diag.lean, L120Pair.lean and L120Four.lean's identification on bivectors". Those files prove the identification on `CurvLin` inside `weylModuleS` (`diagSummand_iff`, `pair_isotypic`, `four_isotypic`). None of them carries it to `CurvOp2`, and none proves that the blocks with $\lvert t\rvert$ odd or $\lvert t\rvert\ge6$ vanish on `CurvOp2`. The INDEX row says this correctly ("proved on bivectors ... and not carried across", "Owed"). The header should say "owed" in the same words.
- **O3 (the record's criterion is an eigenvalue bound).** Lemma L24's criterion is $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$. `hess_blocks` is phrased on the form $\mathrm{hess}=\langle v,6\theta(L_e-\tfrac12)v\rangle$ (`hessQ_op`). The two agree when $\theta>0$, the case at a maximiser. With $\theta<0$ the eigenvalue reading flips direction and the form statement remains the correct second-order statement. The block eigenvalue reading ($\lambda_{\max}$ over $W^\perp$ is the maximum of the blocks' $\lambda_{\max}$) is not stated. It follows from the form statement for a self-adjoint operator and is owed only as a restatement.
- **O4 (directness).** The record's "$\mathcal W_n$ decomposes as $\oplus$" is a direct sum. L120Decomp.lean proves covering, and pairwise orthogonality is `char_orth`, so directness follows. It is not stated as a theorem on `CurvOp2` in this file. [L120Direct.lean](../lean/HamiltonsCubic/Results/L120Direct.lean) exists on the `CurvLin` side. `hess_blocks` does not need it.
- The Lean hypothesis is "$\Gamma$-fixed", and the record's is "every diagonal $M$". `signChar_diag` in L120Hess.lean bridges these, as r1693 recorded. Criticality and $P(a)\ne0$ are hypotheses of `hess_blocks` because `hessQ_op` needs them. That is consistent with the record's "criticality is unused", which concerns $L_M$ preserving the summands (`hessOp_char`, L120Block.lean) and does not concern the Hessian form.

## 5. Does `L1_eq` state the record's equality clause? Reconciling "up to sign"

Yes. The positive multiple is correct, and a negative multiple attains $-\theta_0$.

- `L1_eq`, at $n\in\{12,14\}$, for `W` with `IsWeyl`, `IsDiagonalOp`, `normSq W = 1`: `Pcubic W = theta0 n` iff there are `T` and `c` with `2 * T.card = n`, `0 < c` and `W X = diagOp (c • sphereWeight T) X` on every skew `X`.
- The record states the equality case as follows, in [problem.md](../findings/problem.md) under "So the all-$n$ diagonal theorem is COMPLETE": "**Equality is up to $S_n$ alone**: $P$ is an odd cubic, so of the pair $\pm S_*$ exactly one attains an upper bound". The choice of `T` is the $S_n$ freedom. The coordinate sign group fixes every coordinate-diagonal operator, so "up to sign" in the sense of frame signs is vacuous. In the sense $W\mapsto-W$ it is false.
- Screen (by hand): `Pcubic = trCube + sharpPair` ([WeylReal.lean:170](../lean/HamiltonsCubic/Base/WeylReal.lean#L170)) is homogeneous of degree three, so $P(-W)=-P(W)$, and $-W_{\text{sphere}}$ has $P=-\theta_0<\theta_0$. Inside the Lean, a $c<0$ witness would give $P=\theta_0$ by the backward direction, and `L57_equality_even`'s forward direction would then force $c\,\mathrm{sphereWeight}\,T=c'\,\mathrm{sphereWeight}\,T'$ with $c'>0$. So the `0 < c` clause is required, and it is correct.
- "On bivectors" is the right phrasing. `IsWeyl` constrains `W` only on skew inputs, and `pcubic_congr` shows $P$ and the norm read only those. `T` and `Tᶜ` give the same operator at $2\lvert T\rvert=n$, since `sphereWeight` is then complement-symmetric. So the witness is unique up to that swap and $S_n$, and the clause claims no more than that.
- The backward direction derives $2\le\lvert T\rvert$ and $2\le\lvert T^{\mathsf c}\rvert$ from $n\in\{12,14\}$ for `sphereWeight_isWeight`, and the norm transfers through `pcubic_congr`. Sound.
- **O1 (stale record sentence).** [problem.md](../findings/problem.md) line 540 still ends "The equality clause of L1 is untyped". After f4cb8f54 it is typed and proved as `L1_eq`. The INDEX row and the Lean header have been updated, and this sentence should be updated to match.

## 6. `#print axioms`

`lake env lean` on a scratchpad check file, exit 0:

```
'HamiltonsCubic.L120Decomp.hess_blocks' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L120Decomp.weylPerp_decomp' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L120Decomp.sum_comp' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L1Statement.L1_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
```

No `sorryAx` and no `native_decide` (`Lean.ofReduceBool` is absent). Neither file contains `sorry`. The `#check` of `hess_blocks` printed the signature quoted in section 4.

## 7. lean/INDEX.md rows

- **L120**: status **partial**. The L120Decomp.lean passage lists `proj`, `proj_signMat`, `sum_proj`, `weylPerp_decomp`, `hess_blocks`, `hess_sum_blocks`, `setChar_four` and "standard three axioms", each matching the code and section 6. The **Owed** clause names the nonzero-block identification and the $\mathcal D_n\cap M^\perp$ dimension $n(n-3)/2-1$ as not carried to `CurvOp2`, which is accurate. The row is consistent. It is sharper than the module header (O2).
- **L1 (statement)**: status **proved**, "`L1_eq` PROVED ... $c>0$, $2\lvert T\rvert=n$, from `L57_equality_even`", "stated in the coordinate frame". This matches the code. `IsDiagonalOp` is the coordinate class, and the frame passage is prose per r1768 O1.

## 8. Falsifiers and the search for them

- **Claim A, the covering.** Falsifier: a $v\in W^\perp$ at a $\Gamma$-fixed $a$ that is not the sum of its isotypic components, or a component with the wrong character. I searched by reading `proj_flip`'s reindexing, `sum_chi`'s product expansion and `sum_comp`'s coercions line by line. Nothing turned up, and the kernel check excludes it.
- **Claim A, block by block.** Falsifier: a $\Gamma$-fixed unit critical $a$ and $v\in W^\perp$ with $\mathrm{hess}(v)>0$ while every block is nonpositive. Excluded once `hess_sum_blocks` holds, and it rests on `char_orth` plus `hessOp_char` (r1769). For the record's stronger reading, the falsifier would be a nonzero block at $\lvert t\rvert\notin\{0,2,4\}$ on `CurvOp2`, or a trivial block larger than $\mathcal D_n\cap M^\perp$. That identification is owed, and this review did not construct such an object. The `CurvLin` side (`diagSummand_iff`, `pair_isotypic`, `four_isotypic`) exists, and I found no argument that the transfer fails.
- **Claim B.** Falsifier: a unit coordinate-diagonal Weyl $W$ at $n=12$ or $14$ with $P(W)=\theta_0$ that is not a positive multiple of a balanced sphere weight on bivectors, or a negative multiple attaining $\theta_0$. The second is excluded by oddness (the screen in section 5). The first is excluded by `L57_equality_even`. I checked that its hypotheses (`4 ≤ card`, `IsWeight (wOf c)`, unit norm) are all supplied and that `theta_of_unit` identifies `theta` with `Pcubic`.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.**

- O1: [problem.md](../findings/problem.md) line 540, "The equality clause of L1 is untyped", is stale after f4cb8f54.
- O2: the last paragraph of the L120Decomp.lean header attributes the nonzero-block identification to L120Diag, L120Pair and L120Four without saying it is owed on `CurvOp2`. The INDEX row words it correctly.
- O3: `hess_blocks` is the form reading of L24's criterion. The block eigenvalue restatement ($\theta>0$) is unstated.
- O4: directness of the decomposition on `CurvOp2` follows from `char_orth` and is not stated as a theorem in the file. Nothing depends on it.
