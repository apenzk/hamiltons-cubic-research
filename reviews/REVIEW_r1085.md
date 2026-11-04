# Review r1085, the L233 fold and three Lean splits

*COLD Gate 2 review, sole reviewer, of `ef326919`, `390c266f`, `f3dfe29f` and the WCP2 phase-1 passage carried inside `ef326919`. Every identity below was rebuilt here from [conventions.md](../findings/conventions.md)'s index formula in a scratch build importing nothing from [screen_I73_pair_direction.py](../scripts/misc/screen_I73_pair_direction.py), and every absence claim was settled by grep over the whole Lean tree rather than by reading a docstring. Numbers are screens. Log: [r1085-fold.log](../agent_logs/r1085-fold.log).*

| # | claim | verdict |
|---|---|---|
| A1 | the fold applied r1083's and r1084's verdicts faithfully and at every site | **REFUTED at "every site"**, one surviving copy of the refuted clause in the block itself |
| A2 | the corrected box is right as written, factors and signs included | **CONFIRMED**, and one more hypothesis is inert than the block claims |
| A3 | the relabel to $S^4\times S^4$ is correct and complete | **CONFIRMED as correct, REFUTED as complete**, one site left in the same block |
| A4 | the `Lean: void` on `Weyl_n` is justified | **CONFIRMED**, the `Id` half is a strengthening rather than a gap |
| A5 | the `pf_sq_eq_det` split is sound and its six named absences are real | **CONFIRMED**, with one prose correction |
| A6 | the `WCP2_sharp_one` split is sound | **CONFIRMED as algebra, PLAUSIBLE as a saving**, the file's own measure points the other way |
| A7 | the new `Lean: blocked` trailer on `ef326919` is honest | **REFUTED**, both of its clauses are false and the objects are on file |

## A1, the one copy the fold did not reach

**Four of the five sites were repaired correctly.** [INDEX-results.md](../findings/INDEX-results.md)'s row 233, [plan.md](../plan.md)'s I73 item, the block's own headline at [second-order.md](../findings/second-order.md) line 150 and the Lean docstring all carry the commuting hypothesis, and the row and the item both carry the counterexample.

**The fifth is four lines below the repair and carries the refuted sentence in the reviewers' own words.** [second-order.md](../findings/second-order.md) line 152, *"What this settles for R33"*, reads:

> *Settled*: the unprojected formula, at every $W$ and every eigenpair, and the fact that the projection rather than the bracket carries the $\#$ term.

**That is the clause `ef326919`'s first bullet quotes as REFUTED AS STATED, unrestricted and with no hypothesis anywhere in the sentence.** *It is worse placed than the headline was, because it sits under a heading a reader consults for what may be used downstream.* The repair is one word: **on a commuting pair**, the projection rather than the bracket carries the $\#$ term.

**The reach was checked before this was reported.** Grepping `findings/`, [plan.md](../plan.md), [results.md](../results.md), [routes.md](../routes.md), [STATUS.md](../STATUS.md) and the Lean tree for the clause returns exactly three hits: line 150 (scoped, correct), line 152 (unscoped, above) and [I73PairDirection.lean](../lean/HamiltonsCubic/Results/I73PairDirection.lean) line 27, where the antecedent *"Two disjoint coordinate planes commute"* is present and the sentence is sound. **So it is one site and not a layer.**

## A2, the box: CONFIRMED, and symmetry of $e$ is inert too

**Derived here from the definitions rather than checked against the author's.** With $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ on $\Lambda^2$, $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$ totally antisymmetric, and the record's $\tfrac12$-carrying $(X^{\#})_{ab}=\tfrac12\sum c_{acd}c_{bef}X_{ce}X_{df}$:

- **Anticommutator half.** $Y_0^2=\tfrac14(uu^{\mathsf T}+vv^{\mathsf T})$ at orthonormal $u,v$, so $\langle Y_0,\tfrac12(eY_0+Y_0e)\rangle=\mathop{\mathrm{tr}}(eY_0^2)=\tfrac14(\langle u,eu\rangle+\langle v,ev\rangle)$ by cyclicity alone.
- **`#` half.** The per-basis trace $\mathop{\mathrm{tr}}((AY_0)^2)=\tfrac12(u\!\cdot\!Av)^2$ at antisymmetric $A$, times $-\tfrac12\varepsilon_\gamma$ summed, gives $-\tfrac14\sum_\gamma\varepsilon_\gamma\langle\psi_\gamma,[u,v]\rangle^2=-\tfrac14\langle[u,v],e[u,v]\rangle$, since $u\!\cdot\!\mathrm{ad}_{\psi_\gamma}v=-\langle\psi_\gamma,[u,v]\rangle$ by total antisymmetry.
- **Dividing by $\lVert Y_0\rVert^2=\tfrac12$ returns the box exactly**, both factors and both signs, and the quotient is independent of how the operator pairing is normalised because the same pairing appears above and below.

**Screen, on objects built here.** The mandated anchor $\mathrm{id}^{\#}=(n-2)\mathrm{id}$ is exact to machine zero at $n=4,5,6$, so the $\tfrac12$ is the record's. The box then holds at $n=4,5,6$ to $6\cdot10^{-16}$ at a random symmetric $E$ and a random orthonormal pair that is **not** a pair of eigenvectors, and the eigen-form agrees with the basis-free form to machine zero at a genuine eigenpair. A sign-flipped variant is separated by $0.12$ to $0.45$, so the check can fail.

**One hypothesis more is inert than the block says, and it is worth stating because the block makes inertness its point.** The block reads *"at every symmetric $e$ on $\Lambda^2$"*. **Symmetry is not needed either.** Contracting $Y_0$ against $\mathrm{sharpBil}(E,Y_0)$ and relabelling $(c,d,e,f)\mapsto(e,f,c,d)$ together with $a\leftrightarrow b$ returns the same expression at $E^{\mathsf T}$, so the `#` half is blind to $E$'s antisymmetric part, and the anticommutator half was derived from cyclicity with no symmetry used. Screened at a random non-symmetric $E$ at $n=4,5,6$: the box holds to $6\cdot10^{-16}$. *So the true range is every linear operator on $\Lambda^2$ and every orthonormal pair.* **This is a refinement and not a defect**: the block's statement is true as written.

## A3, the worked point: the identification is right, the relabel stops one line short

**The identification is confirmed four independent ways**, none of them a reading of the commit message.

- $\mu=\tfrac{n-2}{2(p-1)(q-1)}=\tfrac13$ with $p+q=n$ forces $(p-1)(q-1)=\tfrac32(n-2)$, satisfied at $(4,4)$ in $n=8$ and failing at $(3,3)$ in $n=6$, where the same formula gives $\tfrac12$.
- **The eigenvalues cohere with the Weyl weight derived here.** Row-vanishing on the block-diagonal pair matrix gives $(p-1)\alpha=q$, $(q-1)\beta=p$ at cross weight $-1$, which is [L232](../findings/INDEX-results.md)'s own row-sum pair. At $p=q=4$ the ratio of a within-block to a cross eigenvalue is $-\tfrac43$, and $\tfrac{4/21}{-1/7}=-\tfrac43$ exactly.
- **$\theta$ falls out of the same weight as $\sqrt{21}/4=1.145644$**, which [second-order.md](../findings/second-order.md) lines 411 and 772 both record as $S^4\times S^4$'s value.
- **The record's naming convention is $S^p\times S^q$ with $p+q=n$**, fixed by line 220's list of excess-zero points *"at $n=8,10,12$"* and by line 51's $(3,3)$ at $n=6$.

**The internal arithmetic is self-checking and it checks.** $[\varphi_{01},\varphi_{04}]=\pm\varphi_{14}$, a cross-block direction at $\varepsilon=-\tfrac17$ and $\lVert[u,v]\rVert^2=1$, so the `#` term $-\tfrac12\langle[u,v],e[u,v]\rangle$ is $+\tfrac1{14}$, the average is $\tfrac1{42}$ and the unprojected quotient is $\tfrac2{21}$, exactly r1083's figures. The projection's $\tfrac17$ splits as $\tfrac{16}{63}-\tfrac7{63}$ against $\tfrac{12}{63}\to\tfrac{21}{63}$, and $\tfrac{21}{63}=\tfrac13$ is $\mu$.

**The two untouched sites were right to leave.** Line 51 fixes $S^3\times S^3$ as $n=6$ explicitly, line 198's Peirce table says $n=6$, $\dim84$ in the same clause, and line 27's $\dim E(\tfrac12)=18$ against an orbit of $9$ is the $n=6$ datum line 51 and line 714 both carry.

**A THIRD SITE IN THE SAME BLOCK WAS MISSED, AND IT CONTRADICTS ITSELF IN ONE SENTENCE.** [second-order.md](../findings/second-order.md) line 154 closes the non-vacuity paragraph with:

> At $S^3\times S^3$ in $n=8$ the overlap is $3.7\cdot10^{-16}$ against a $16$-dimensional tangent, which is $\dim\mathfrak{so}(8)-\dim(\mathfrak{so}(4)\oplus\mathfrak{so}(4))$.

*The same sentence names the $(4,4)$ isotropy and the $(3,3)$ label.* **It is the sentence the commit's second bullet says was fixed**, and it is the one an $n=8$ reader reaches last. The print string in [screen_I73_pair_direction.py](../scripts/misc/screen_I73_pair_direction.py) was repaired and the prose beside it was not, so the record and the screen now disagree. **Repair: $S^4\times S^4$ in $n=8$.**

## A4, the `Weyl_n` void: CONFIRMED, and the `Id` half does not reopen it

**The trailer's two clauses, read from `fb92cdca` itself**: that the statement quantifies over $S$ in a subspace of $\mathcal W_n$ cut out by orthogonality to $\mathop{\mathrm{span}}\{W,\mathrm{Id}\}$, and that *"no declaration in the layer builds that subspace... the quantified statement has nothing to bind $S$ over"*.

**The second clause is the debt and it is void.** [span_condition_iff](../lean/HamiltonsCubic/Results/I73SpanCondition.lean) binds `S : ι → V` at an arbitrary index type with orthogonality as a hypothesis, so there is something to bind $S$ over and it needed no construction.

**The `Id` half is absent from the hypothesis and that makes the theorem STRONGER, not partial.** The typed statement assumes only $\langle S_i,W\rangle=0$, so it holds for every family orthogonal to $W$, of which the families orthogonal to $\mathop{\mathrm{span}}\{W,\mathrm{Id}\}$ are a sub-collection. Instantiating $\iota$ at the subtype $\{x\mid x\perp W\wedge x\perp\mathrm{Id}\}$ recovers R-A's own formulation. *Nothing is owed on that account.*

**What genuinely remains untyped is a different step, and the row does not name it.** Going from *"$W^{\#}$ pairs to zero against every $S\perp\mathop{\mathrm{span}}\{W,\mathrm{Id}\}$"* to *"$W^{\#}\in\mathop{\mathrm{span}}\{W,\mathrm{Id}\}$"* is the double orthogonal complement, which needs the subspace as an object and finite dimensionality. [lean/INDEX.md](../lean/INDEX.md)'s row files everything past the equivalence under *"equivalent to a two-value spectrum, which needs the spectral theorem"*, and this step needs dimension rather than the spectral theorem. **A one-clause addition, not a debt.**

**And the correction was already on the row before `390c266f` wrote it again.** The row's existing sentence, *"A `Lean: blocked` trailer on the commit that preceded this file is FALSE... the statement needs no subspace construction, $S$ being a variable with orthogonality as a hypothesis"*, is about `fb92cdca`, the file having been added by `a13da80a` whose own summary line reads *"R-A's false blocker is typed away"*. **The row now says it twice, at length the second time.** *The commit was still owed, the debt gate reading commit trailers rather than the index, but the row should carry one paragraph.*

## A5, the `pf_sq_eq_det` split: CONFIRMED

- **The six names are absent as declarations and as strings**: `pf6_conj`, `pf6_equivariant`, `pf6_orthogonal`, `pf6_blockDiag`, `complexStructure_normalForm` and `isComplexStructure_conj` each return zero hits over the whole of `lean/HamiltonsCubic/`, so not even a docstring mentions them.
- **`IsComplexStructure.orthogonal` is in [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) at line 648 and says $J\,J^{\mathsf T}=1$**, which is the orthogonality the route consumes, derived from the skewness clause and $J^2=-1$.
- **The standard $J_0$ is on file too**, as `stdJ6` $=\varphi_{01}+\varphi_{23}+\varphi_{45}$ with `stdJ6_isComplexStructure` beside it, so the route's target is an existing object rather than a seventh absence.
- **The mathematics is sound.** $\mathrm{Pf}(BXB^{\mathsf T})=\det B\cdot\mathrm{Pf}(X)$ at every $B$, and an orthogonal complex structure admits an adapted orthonormal basis built by taking $e_2=Je_1$ and descending to the $J$-invariant orthogonal complement, which is an $O(6)$-conjugacy to $J_0$. With $\det Q=\pm1$ this gives $\mathrm{pf6}(J)=\pm\,\mathrm{pf6}(J_0)$, which is the disjunction the chain consumes. *The transfer to this record's `pf6` rests on `pf6` being $+\mathrm{Pf}$, which [r993](REVIEW_r993.md) pinned.*
- **The split's own claim is the honest one**: the consumer needs $\mathrm{pf6}(J)=\pm1$ and not $\mathrm{Pf}(X)^2=\det X$, and the file and the row now say which.

**One prose correction, and it is load-bearing for the route.** The file writes *"every complex structure on $\mathbb R^6$ is orthogonally conjugate to the standard block-diagonal $J_0$"*. **Read literally that is false**: $SJ_0S^{-1}$ at invertible non-orthogonal $S$ satisfies $J^2=-1$ and is not orthogonally conjugate to $J_0$. What is true is the statement at the record's own predicate, where skewness is a clause and gives orthogonality through `IsComplexStructure.orthogonal`. *The route is fine and its statement should carry the hypothesis it uses, which is the fault this file's other repairs are about.*

## A6, the `WCP2_sharp_one` split: the algebra is exact, the saving is not yet shown

**Every structural claim checks.**

- `Qop R = R * R + sharpMat R` by definition, [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) line 95, and `sharpBilin X Y = ½ • (sharpMat (X+Y) - sharpMat X - sharpMat Y)`, [RelationB.lean](../lean/HamiltonsCubic/Base/RelationB.lean) line 28.
- `WCP2_critical'` is at [CP2Sharp.lean](../lean/HamiltonsCubic/Base/CP2Sharp.lean) line 451 and is kernel-proved: `simp only`, `norm_num`, `rfl`/`omega`/`decide`, with no `native_decide` and no `sorry`. **So `sharpMat WCP2 = 3 • WCP2 - WCP2 * WCP2` is exact.**
- **Substituting it gives the stated goal and nothing else.** $\tfrac12(M_{W+1}-M_W-M_1)=-W$ with $M_W=3W-W^2$ rearranges to $M_{W+1}-M_1+W^2=W$, character for character the passage's display.
- **The seventy-two are what the passage says they are.** [RelationBSharp.lean](../lean/HamiltonsCubic/Base/RelationBSharp.lean) carries exactly thirty-six `sharpMat_I_ab` and thirty-six `sharpMat_WI_ab` theorems and no `sharpMat_W_ab`, so `sharpMat WCP2` is genuinely not among them.
- **The file imports `CP2Sharp` at line 1 and cites `WCP2_critical'` nowhere in a proof**, the only occurrences being the new prose.

**What is NOT shown is that the remaining goal is cheaper, and the file's own measurements point the other way on the factor it identifies as dominant.** The passage above it records that closing each `sharpMat` matrix in its own declaration *"still matched fifty-one value lemmas across thirty-six branches, which reached 6 GB in seventy seconds"*, and that *"one entry against three values elaborates in seconds with flat memory"*. **The new goal in one declaration matches SEVENTY-TWO value lemmas across the same thirty-six branches**, which is more on that axis, not less. *What the route removes is the `sharpQF` unfolding of the third matrix, which is real. What it does not remove is the product of simp-set size and branch count that the file names as the wall.*

**Recommendation, and it follows from the file's own finding rather than from a new idea: phase 2 should be thirty-six entry-level declarations of the assembled identity, each citing `sharpMat_WI_ab`, `sharpMat_I_ab` and one entry of `WCP2 * WCP2`, with `WCP2_sharp_one` assembled from them by `ext`.** That is the shape already measured as seconds at flat memory. **Running the one-declaration form first and capping it is a measurement, not a route**, which the passage concedes, and it should say which of the two it expects to fail.

## A7, the `Lean: blocked` trailer: REFUTED, and the objects it calls absent are in the base layer

**The trailer reads**: *"the assembly needs the full symmetry of the trilinear form, which conventions.md asserts and no declaration holds, and no declaration named `sharpBil_symm`, `sharp_trilinear_symm` or `inner_sharp_symm` exists in the tree. The operator-slot polarisation `sharpOpBil` is also absent and IS buildable, so it is the next round rather than part of this debt."*

**The four names are indeed absent, and that settles nothing.** All four return zero hits. **The objects exist under other names, in the base layer, at general $\iota$ over $\mathbb R$.**

- **The operator-slot polarisation of `#` is `sharpCross`**, [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) line 264: `fun Z => ½ • (sharpOp (X + Y) Z - sharpOp X Z - sharpOp Y Z)`, over bare `CurvOp ι`. *That is the $\mathbb R$ mirror of `sharpBilin` the trailer says is absent and buildable.* Beside it `foxProd` is the same polarisation of `Qop`, with `foxProd_split` proving it splits into the Jordan half and `sharpCross`.
- **The trilinear form is `foxTri`**, line 293 of the same file, whose docstring reads *"`T(X,Y,Z) = ⟨X ∘ Y, Z⟩`, the record's fully symmetric trilinear form"*.
- **Its full symmetry is held, in three places.** `foxTri_comm` swaps the first two slots at **arbitrary** operators. `foxTri2_symm_right` in [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) line 113 swaps the last two on `CurvOp2` needing only `IsSelfAdjoint2` on the second and third arguments. `foxTri_symm_right` in [FoxBridge.lean](../lean/HamiltonsCubic/Results/FoxBridge.lean) line 223 carries that to bare record-Weyl operators, its docstring opening *"SO THE FULL SYMMETRY OF `T` HOLDS AT RECORD-WEYL BARE OPERATORS"*. Underneath them [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean) proves `phiTri_swap_outer` unconditionally and `phiTri_rotate` at a self-adjoint slot, which are the `#` half's own symmetries.
- **And the consumer is already built on it**: `lidem_isSelfAdjoint` proves $\langle L_eX,Y\rangle=\langle X,L_eY\rangle$, which is what the symmetry is for.

**The hypothesis class fits L233.** $Y_0=\tfrac12(uv^{\mathsf T}+vu^{\mathsf T})$ is not a Weyl operator, so `foxTri_symm_right` is the wrong door, but `foxTri2_symm_right` asks only that the second and third arguments be self-adjoint, and $Y_0$ is self-adjoint on $\Lambda^2$ by construction. *So the route the assembly needs is open at the weaker theorem, with the remaining work being to present $Y_0$ as a `CurvOp2`.*

**So `Lean: blocked` is not honest, and the failure is the one this session had already diagnosed once.** `390c266f`'s own body says a trailer *"named a concept rather than a declaration a grep decides, which is the failure mode the trailer's own rule names"*. **This trailer inverts it**: it invented three names for a concept, grepped them, found nothing, and reported the concept absent. `foxTri_comm`'s docstring even records the same correction happening before, *"A first version of this line said the third slot was owed, which it was when written and had stopped being."*

**The same false claim is in [lean/INDEX.md](../lean/INDEX.md)'s L233 row**, which reads *"What is actually missing is the operator-slot polarisation, the $\mathbb R$ mirror of `sharpBilin`... and the full symmetry of $\langle X\#Y,Z\rangle$, which conventions.md asserts and no declaration holds; that second one is a round of its own."* **Both halves are false and the row is where the next round reads its debt.** *The rest of that row's rewrite, which refutes the earlier "`sharpBilin` is fixed at `Fin 6` over $\mathbb Q$ so there is nothing to write the sum in", is correct: [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) carries `sharpQF`, `sharpBil`, `sharpOp` and `sharpPair` at every $\iota$ over $\mathbb R$.*

## A8, the Lean docstring against the elaborated types

**Faithful.** `trace_sq_pair_direction` carries `hA : Aᵀ = -A` and nothing else, so the docstring's *"neither `u` nor `v` need be a unit vector, and they need not be orthogonal"* is exactly its signature. `pairDir_sq`, `trace_mul_pairDir_sq` and `trace_pairDir_sq` each carry `u ⬝ᵥ u = 1`, `v ⬝ᵥ v = 1` and `u ⬝ᵥ v = 0`, so the docstring's *"the application's orthonormality is consumed elsewhere, in the `W²`-half and in the norm"* names the right three.

**One wording hazard the repair introduced.** The new opening sentence ends *"What the identity consumes is orthonormality and nothing else"*, and the next paragraph says the file's identity consumes strictly less than that. **Two different identities are called "the identity" three lines apart.** *Scope the first to L233's identity and the file reads without contradiction.*

## What is owed, in order

1. **Scope [second-order.md](../findings/second-order.md) line 152's "Settled" clause to commuting pairs.** It is the refuted sentence, unmodified, under a heading written for downstream use.
2. **Relabel [second-order.md](../findings/second-order.md) line 154 to $S^4\times S^4$**, where it already names $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ in the same sentence.
3. **Withdraw the `Lean: blocked` reason and rewrite [lean/INDEX.md](../lean/INDEX.md)'s L233 debt around `sharpCross`, `foxTri` and `foxTri2_symm_right`.** *Both loops are armed in this session, so this is a repair and not a handoff.*
4. **Say in the WCP2 passage which of the two phase-2 shapes is expected to survive**, and prefer the per-entry one the file has already measured.
5. **Give [I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean)'s normal-form sentence its skewness hypothesis**, and fold A4's double paragraph in [lean/INDEX.md](../lean/INDEX.md)'s I73 row into one.
