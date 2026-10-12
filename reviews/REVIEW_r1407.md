# REVIEW r1407: L70 at any number of eigenvalue classes in Lean, `L70_identity`, `L70_bound`, `L70_equality`

Log [agent_logs/r1407.log](../agent_logs/r1407.log). One reviewer, statement fidelity only (the kernel has checked the proofs). Analysis-only: one elaboration of a scratch file for `#print axioms` and three short screening lemmas on objects constructed for the purpose, no numerics. Record: [findings/bounds.md](../findings/bounds.md), Lemma L70 ("the deficiency identity, and what saturates it"), with its excluded-index blockquote and dimension theorem. Lean: commit 766b90e9, [L70Weyl.lean](../lean/HamiltonsCubic/Results/L70Weyl.lean), [L244RowA.lean](../lean/HamiltonsCubic/Results/L244RowA.lean) (`bAB`, `rowMass_eq_sum_bAB`), [L244RowBMass.lean](../lean/HamiltonsCubic/Results/L244RowBMass.lean) (`Pc`, `rowC_mass`), [L70Identity.lean](../lean/HamiltonsCubic/Results/L70Identity.lean) (`D`, `deficiency_identity`, `deficiency_nonneg`, `deficiency_zero_iff`), [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) (`inner2`, `br`, `IsCritical`), [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) (`IsWeylOp`), the L70 row of [lean/INDEX.md](../lean/INDEX.md). Prior review: [r1195](REVIEW_r1195.md), which found the three-class limit.

**Standfirst.** The generalisation from `Fin 3` to `Fin K` does what the commit says. With ψ an orthonormal eigenbasis of W on Λ², K = r and `cls = id`, `Pc ψ id b` is the rank-one projection onto ψ_b, `hWP` follows from linearity of W and the eigen-equations, and `bAB ψ id a b x` is $\tfrac12 c_{xab}^2$, so `L70Identity.D` is the record's $D(v)$ term for term. All three were screened as Lean lemmas that elaborate against the committed files. So `L70_identity`, `L70_bound` and `L70_equality` now state Lemma L70 for every spectrum, modulo the existence of the eigenbasis and the unit-norm reading, both of which the INDEX row lists. The range hypotheses match the record's sign condition, with `lmax` read as any nonnegative upper bound, which is weaker as a hypothesis and gives the record's statement at the spectral maximum. The equality case keeps its meaning at single-vector classes. The INDEX row is accurate in content, but its new sentence joins two clauses with a semicolon, it still reads "pending" for this review, and it calls L244RowA generic in K while `hA_of_basis` stays at three classes. The satisfiability claim for `cls = id` is argued in prose and typed nowhere in the repo. The axioms are the standard three.

| Item | Verdict | Reason |
| --- | --- | --- |
| 1a. `Pc` and `bAB` at `cls = id` | CONFIRMED | The filter `{γ | γ = b}` is `{b}`, so `Pc ψ id b X = inner2 (ψ b) X • ψ b` and `bAB ψ id a b x = ½ inner2 (br (ψ a) (ψ b)) x ^ 2`. Both screened by `simp [Finset.filter_eq']`. |
| 1b. `hWP` satisfiable for every spectrum | CONFIRMED | `IsWeylOp` contains `IsLinOp`, so from `hψ` and `W ψ_k = μ_k ψ_k` one gets `W X = ∑ b, μ b • Pc ψ id b X` at every skew X. Screened as a lemma. No constraint on the number of distinct μ remains. |
| 1c. `bAB` is the record's $b_{ab}$, `D` the record's $D(v)$ | CONFIRMED | `inner2` is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ and `br` the commutator, the record's pairing and bracket ([conventions.md](../findings/conventions.md)). `D = ∑(λ_aλ_b − λ_minλ_max) b_ab` with $b_{ab}=\tfrac12c_{vab}^2$ is the record's $\tfrac12\sum(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})c_{vab}^2$. Row (A) reads $\tfrac12\sum c^2=n-2$, the record's mass $2(n-2)$. |
| 1d. The theorems are the record's statement for every spectrum | CONFIRMED | Given 1a to 1c, the three theorems hold at every critical linear Weyl operator admitting an orthonormal eigenbasis, whatever its spectrum. The two remaining distances (eigenbasis existence, $\theta$ as the $Q(W)=\theta W$ multiplier rather than $P/\lVert W\rVert^3$) are listed in the row. |
| 2a. `hneg`, `hmax`, `hlo`, `hhi` against the record | CONFIRMED | `hlo` with the eigenvector `x` pins `lmin` as the spectral minimum. `hhi` and `hmax` make `lmax` any upper bound that is at least 0, which contains the record's $\lambda_{\max}$ with $\lambda_{\min}\le0\le\lambda_{\max}$. Strict `hneg` is what the record's own division by $\lvert\lambda_{\min}\rvert$ needs. |
| 2b. Equality case at single-vector classes | CONFIRMED | At `cls = id` the condition is per basis pair: $c_{xab}\ne0\Rightarrow\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}$, the record's "support" reading. At coarser classes the factor is constant on a class pair and `bAB` is a sum of squares, so the two readings are equivalent. Nothing changes meaning. |
| 3a. INDEX L70 row accurate | CONFIRMED WITH GAP | The content is right. Three defects: a semicolon joins "for every spectrum" to "Gate 2 for the generalisation" (a splice), "pending" needs this verdict, and "L244RowA generic in K" should except `hA_of_basis`, still at `Fin 3`. The `cls = id` claim is argued and typed nowhere. See section 3. |
| 3b. "Not typed" list complete | CONFIRMED | Dropping "spectra with more than three eigenvalues" is correct. The six remaining items cover what the record claims beyond the Lean. The per-$v$ quantifier over $E_{\min}$ is recovered by generalising `x`, and the strict-sign argument is in [L70.lean](../lean/HamiltonsCubic/Results/L70.lean). |
| 4. Axioms | CONFIRMED | `L70_bound`, `L70_identity`, `L70_equality`: `[propext, Classical.choice, Quot.sound]`. |

**One-line summary: CONFIRMED WITH GAP.** The K-generic theorems are Lemma L70 for every spectrum once an orthonormal eigenbasis is supplied, and the gap is editorial: the INDEX row needs its semicolon splice and "pending" fixed, the `hA_of_basis` exception noted, and optionally the ten-line `cls = id` lemma committed so the satisfiability claim is typed.

## 1. The classes at single vectors

`Pc ψ cls a X` in [L244RowBMass.lean](../lean/HamiltonsCubic/Results/L244RowBMass.lean) is $\sum_{\gamma:\,\mathrm{cls}\,\gamma=a}\langle\psi_\gamma,X\rangle\psi_\gamma$, and `bAB ψ cls a b x` in [L244RowA.lean](../lean/HamiltonsCubic/Results/L244RowA.lean) is $\tfrac12\sum_{\gamma\in E_a}\sum_{\delta\in E_b}\langle[\psi_\gamma,\psi_\delta],x\rangle^2$. The commit changes only the codomain of `cls` and the domain of `lam`. No proof step used `Fin 3` beyond its being a `Fintype`, which is why the diff is signatures only.

At `K = r`, `cls = id` both filters are singletons. The scratch file proved, each by one `simp [Finset.filter_eq']` or a short induction:

- `Pc ψ id b X = inner2 (ψ b) X • ψ b`,
- `bAB ψ id a b x = (1/2) * inner2 (br (ψ a) (ψ b)) x ^ 2`,
- from `IsWeylOp W`, `hψ` and `∀ k, W (ψ k) = μ k • ψ k`: `∀ X, IsSkew X → W X = ∑ b, μ b • Pc ψ id b X`.

The third is the satisfiability of `hWP` asked for, and it needs no bound on the number of distinct μ. It is a screen: it shows the hypothesis is met by the intended object, and it is not in the repo. `hψ` asks only that ψ be a Parseval frame for `inner2` on skew matrices, which an orthonormal basis of Λ² is, so the theorems are if anything more general than the record.

With these, `L70Identity.D (fun a b => bAB ψ id a b x) μ lmin lmax` is $\sum_{a,b}(\mu_a\mu_b-\lambda_{\min}\lambda_{\max})\tfrac12 c_{xab}^2$, the record's $D(v)$ at $v=x$, with $c_{vab}=\langle[v_a,v_b],v\rangle$ in the $\tfrac12\operatorname{tr}$ pairing ([conventions.md](../findings/conventions.md)).

## 2. The hypotheses and the equality case

The record needs $\lambda_{\min}\le0\le\lambda_{\max}$ for the sign and divides by $\lvert\lambda_{\min}\rvert$ in the boxed identity. The Lean has `hneg : lmin < 0`, `hmax : 0 ≤ lmax`, and `hlo`, `hhi` placing every class value in $[\lambda_{\min},\lambda_{\max}]$. Since `x` is a unit eigenvector at `lmin`, `lmin` is in the spectrum, and `hlo` makes it the minimum. `lmax` is any upper bound at least 0. Choosing the spectral maximum gives the record's bound exactly, and a larger choice gives a weaker true bound. With K free, a class may be empty, in which case its `lam` value is unconstrained by `hWP` and must merely be chosen inside the range, which is always possible. At `cls = id` no class is empty.

`L70_equality` says $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ iff $(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})\,b_{ab}(x)=0$ for all class pairs. At single-vector classes $b_{ab}=\tfrac12c_{xab}^2$, so this is: every basis pair carrying bracket mass has $\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}$. At eigenspace classes the product is constant on a class pair and $b_{ab}$ is a sum of nonnegative squares, so a class pair vanishes exactly when each of its basis pairs does. The two readings agree, and the record's "every class pair carrying mass" loses nothing at singletons. The further step to support on $E_{\min}\otimes E_{\max}$ needs $\lambda_{\max}>0$ and is in the "Not typed" list, as is the sharp $m_1$ form.

## 3. The INDEX row

The L70 row's content is correct after the change: the theorem names, the rows' provenance, the standard three axioms, and the lifting of r1195's limit. Three editorial defects:

- The new sentence "... meets `hWP` for every spectrum; Gate 2 for the generalisation: [r1407](REVIEW_r1407.md), pending." splices two independent clauses with a semicolon. It should be two sentences.
- "pending" should read this verdict, CONFIRMED WITH GAP.
- "[L244RowA.lean] and [L244RowBMass.lean] being generic in `K`" should except `hA_of_basis` (L244RowA line 172), which keeps `cls : Fin r → Fin 3`. L70Weyl does not use it, so nothing is wrong in the result, only in the description.

The claim "`cls = id` on an orthonormal eigenbasis meets `hWP` for every spectrum" is correct (section 1) but argued rather than typed. Committing the screened lemma to L70Weyl.lean would make the row's sentence a pointer to a theorem.

The "Not typed" list: the removed item was the only one the change discharged. The remaining six are the unit-norm reading, the step to $E_{\min}\otimes E_{\max}$, the sharp $m_1$ form, eigenbasis existence, the dimension theorem, and the Lie-theoretic reading on L23's family. The record's "for every unit $v\in E_{\min}$" is the universal closure over `x`, and its "strict form free on $\mathcal W_n$" is in L70.lean. Nothing else in the lemma sits outside the Lean or the list.

## 4. Axioms

Scratch file importing `HamiltonsCubic.Results.L70Weyl`, elaborated with `lake env lean` from `lean/`:

```
'HamiltonsCubic.L70Weyl.L70_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L70Weyl.L70_identity' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L70Weyl.L70_equality' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The three screening lemmas of section 1 elaborated in the same file with no errors.
