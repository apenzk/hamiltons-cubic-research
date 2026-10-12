# REVIEW r1717: L71Witness.lean, the balanced sphere product as a witness for L71_saturated

**Verdict: CONFIRMED on the file, REFUTED AS STATED on the row's residue.** [L71Witness.lean](../lean/HamiltonsCubic/Results/L71Witness.lean) exhibits $S^p\times S^p$ at every $p\ge3$ as an operator meeting every hypothesis of [L71Sat.lean](../lean/HamiltonsCubic/Results/L71Sat.lean)'s `L71_saturated`, binder for binder, and discharges [r1692](REVIEW_r1692.md) O3 at every even $n\ge6$. The residue the [L71 row](../lean/INDEX.md) now owes, *"a saturating witness at odd $n\ge5$"*, is an object the record proves cannot exist, and the layer already holds the impossibility one step from two proved theorems.

*Cold brief from the dispatching loop, Gate 2 statement-fidelity review. Analysis only: every check below is by hand from the Lean source and the record, with one hand screen of `weylE_sq` at $p=3$ reported as a screen. No `lake build`, no numerics. Heartbeats in agent_logs/review-r1717.log.*

| # | Claim | Verdict |
|---|---|---|
| 1a | `Wb p` is the Weyl operator of $S^p\times S^p$ at the Einstein normalisation | **CONFIRMED** |
| 1b | The balanced sphere product is what the record names as saturating | **CONFIRMED** |
| 1c | $\theta=1$ is the criticality multiplier, `IsCritical` being $Q(W)\varphi_{ij}=\theta\,W\varphi_{ij}$ | **CONFIRMED** |
| 2 | `weylE_sq` is the equation `DiagCriticalityIsCritical` consumes, and it holds | **CONFIRMED** (screened at $p=3$, proved by hand at every $p\ge2$) |
| 3 | `ev_bounds`, `ev_attains` concern `Mpair_isHermitian … .eigenvalues`, soundly | **CONFIRMED** |
| 4 | $1=-C+(2p-2)(A-C)$, with $A-C$ the top and $-C$ the bottom eigenvalue | **CONFIRMED** (true at $p=2$ as well, excluded only by `hn : 5 ≤ n`) |
| 5 | `L71_nonvacuous`'s existential is exactly `L71_saturated`'s hypotheses | **CONFIRMED** |
| 6 | `L71_witness` is `L71_saturated`'s conclusion at `Wb p`, with real content | **CONFIRMED** (it is a corollary, an instance of the theorem, and certifies no independent computation) |
| 7 | The row's residue "a saturating witness at odd $n\ge5$" | **REFUTED AS STATED**: no such object exists, by the record's L71 and by `L117_no_eq_odd` plus one step |
| 8 | The docstring's inventory (17 declarations, a declaration `saturates`) | **REFUTED AS STATED**, nit: the file has 19 top-level declarations (`hbs` and `hn` besides the 17 listed), and `saturates` names an inline step of `L71_nonvacuous`, with no declaration of that name |

**One line.** The witness is right and faithful at even $n\ge6$. The odd-$n$ item the row keeps owing should become an owed *vacuity* statement, since at odd $n\ge5$ the hypotheses of `L71_saturated` are jointly unsatisfiable.

## Conventions

- `IsCritical R θ` ([WeylReal.lean:194](../lean/HamiltonsCubic/Base/WeylReal.lean#L194)): `∀ i j, Qop R (phi i j) = θ • R (phi i j)`, with `Qop R = compOp R + sharpOp R`, Hamilton's $Q(R)=R^2+R^\#$. No norm constraint.
- `IsWeylOp R` ([FoxProduct.lean:110](../lean/HamiltonsCubic/Base/FoxProduct.lean#L110)) is `IsLinOp R ∧ IsWeyl R`, where `IsWeyl` is skew-preserving, self-adjoint on bivectors, first Bianchi, `Ric = 0`. So `hW.1`, `hW.2.1`, `hW.2.2.1` are linearity, skew preservation and self-adjointness, the three inputs `Mpair_isHermitian` takes.
- `diagOp w X = w ∘ X` entrywise ([Families.lean:147](../lean/HamiltonsCubic/Base/Families.lean#L147)), so `diagOp w (phi i j) = w i j • phi i j` for symmetric `w`.
- `weylE β` ([L56Weyl.lean:51](../lean/HamiltonsCubic/Results/L56Weyl.lean#L51)): off-diagonal entry $1/(b_a-1)-1/(n-1)$ within a factor, $-1/(n-1)$ across, zero diagonal.
- $n=2p$, $A=1/(p-1)$, $C=1/(2p-1)$, as in the file.

## Hypothesis inventory

| Binder of `L71_saturated` | Discharged in `L71_witness` by | Faithful |
|---|---|---|
| `hn : 5 ≤ n` | `by omega` from `hp : 3 ≤ p`, `n = 2 * p` | yes |
| `W`, `hW : IsWeylOp W` | `Wb p`, `Wb_isWeylOp` (from `isLinOp_diagOp`, `diagOp_isWeyl`, `weylE_isWeight`) | yes |
| `θ`, `hc : IsCritical W θ` | `1`, `Wb_critical` | yes |
| `lmin lmax`, `hneg`, `hpos` | $-C<0<A-C$, since $1/(2p-1)<1/(p-1)$ | yes |
| `hlo`, `hhi` | `ev_bounds` | yes |
| `hsat : θ = lmin + ((n:ℝ) - 2) * lmax` | `push_cast; field_simp; ring` | yes, $n$ cast from `2 * p : ℕ` |
| `hex` | `ev_attains` | yes |

`L71_nonvacuous` states the same list as an existential at `Fin (2 * p)`, with `hn` left to the fixed dimension ($5\le2p$ from `hp`). Nothing is weakened: the eigenvalue accessor is the same `Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1`, and its dependence on the proof `hW` is immaterial by proof irrelevance.

## 1. The operator, the record's saturating object, and θ

**Weyl operator.** The product of unit spheres $S^p\times S^p$ has curvature operator $1$ on within-factor $\varphi_{ab}$ and $0$ across, scalar curvature $2p(p-1)$, and is Einstein, so its Weyl operator is $R-\frac{s}{n(n-1)}\mathrm{Id}$, giving within $1-\frac{p-1}{2p-1}=\frac{p}{2p-1}$ and across $-\frac{p-1}{2p-1}$. Scaling by $1/(p-1)$ (sphere radius $\sqrt{p-1}$, so $\mathrm{Ric}=g$) gives within $\frac{p}{(p-1)(2p-1)}=\frac1{p-1}-\frac1{2p-1}=A-C$ and across $-\frac1{2p-1}=-C$. These are `weylE (βb p)`'s entries (`weylE_val`), with `bs_bal` supplying $b_a=p$. **CONFIRMED.** The normalisation only rescales $\theta$ and the spectrum together, and every hypothesis of `L71_saturated` is homogeneous of degree one under $W\mapsto cW$ ($Q(cW)=c\,\theta\,(cW)$ gives $\theta\mapsto c\theta$), so the record's unit-norm reading and the Lean's unnormalised one select the same rays.

**Saturating object.** [Lemma L71](../findings/bounds.md#lemma-l71-saturation-forces-the-balanced-sphere-product-with-no-two-eigenvalue-hypothesis) concludes that a saturating critical point at $n\ge5$ is the Weyl tensor of the balanced sphere product $S^{n/2}\times S^{n/2}$, and its converse blockquote (Reviewer 324) records that the balanced products do saturate. `βb p` splits `Fin (2p)` into $\{0,\dots,p-1\}$ and $\{p,\dots,2p-1\}$, and `bs_bal` proves both have size $p$. **CONFIRMED.**

**θ.** `IsCritical` is $Q(W)=\theta W$ on the $\varphi$ basis with no sign or norm factor, and `DiagCriticalityIsCritical` ([Families.lean:171](../lean/HamiltonsCubic/Base/Families.lean#L171)) reduces it for `diagOp w` to $w_{ab}^2+(w^2)_{ab}=\theta\,w_{ab}$ off the diagonal. At the normalisation above that equation holds with $\theta=1$ (Section 2). The sign convention is checked at the round sphere: $w=J-I$ gives $(w^2)_{ab}=n-2$, so $Q(\mathrm{Id})=(n-1)\mathrm{Id}$, which is Hamilton's value. **CONFIRMED.**

## 2. weylE_sq

The statement is `weylE (βb p) a b ^ 2 + (weylE (βb p) * weylE (βb p)) a b = 1 * weylE (βb p) a b` for `a ≠ b`, which is the premise `∀ a b, a ≠ b → w a b ^ 2 + (w * w) a b = th * w a b` of `DiagCriticalityIsCritical` at `th = 1`, character for character. `Wb_critical` applies the proved theorem `diagCriticalityIsCritical` ([SharpDiag.lean:805](../lean/HamiltonsCubic/Base/SharpDiag.lean#L805)) with `weylE_isWeight`. **CONFIRMED.**

**Screen at $p=3$** ($A-C=3/10$, $-C=-1/5$, $n=6$, hollow so $c\ne a,b$):

- Within ($a,b$ in one factor): $w_{ab}^2=9/100$. The sum over $c$ has one within term $(3/10)^2=9/100$ and three across terms $3\cdot(1/5)^2=12/100$. Total $9/100+21/100=3/10=w_{ab}$.
- Across: $w_{ab}^2=4/100$. Each of the four $c\ne a,b$ contributes $(3/10)(-1/5)=-6/100$, total $-24/100$. Sum $-20/100=-1/5=w_{ab}$.

**By hand at general $p$.** Within: $(p-1)(A-C)^2+pC^2=\frac{p^2+p(p-1)}{(p-1)(2p-1)^2}=\frac{p}{(p-1)(2p-1)}=A-C$. Across: $C^2-2(p-1)(A-C)C=C\big(\frac{1}{2p-1}-\frac{2p}{2p-1}\big)=-C$. Both hold at every $p\ge2$, so `hp : 3 ≤ p` in `weylE_sq` is stronger than the algebra needs, harmlessly. The Lean route (indicator form `weylE_ind`, `sum_s`, `sum_ss`, then `within_id`, `across_id` over atoms $u=p-1$, $v=2u+1$) computes the same two sums.

## 3. ev_bounds and ev_attains

Both are stated about `(Mpair_isHermitian (Wb p) hW.1 hW.2.1 hW.2.2.1).eigenvalues`, the accessor `L71_saturated` names, with the same `hW := Wb_isWeylOp p _`. **CONFIRMED.**

**`ev_bounds`.** `eigenFrame_exists` ([EigenFrameExist.lean:146](../lean/HamiltonsCubic/Results/EigenFrameExist.lean#L146)) is an `EigenFrame` for exactly these eigenvalues, with fields `skew`, `orthonormal`, `eigen : R (v γ) = lam γ • v γ`, `complete`. A frame vector has `inner2 (v j) (v j) = 1`, hence is nonzero. `diagOp_eigen_entry` ([L56Spec.lean:29](../lean/HamiltonsCubic/Results/L56Spec.lean#L29)) then gives an off-diagonal index pair with `ev j = w a b`: a nonzero skew matrix has a nonzero entry, off the diagonal by skewness, and the Hadamard eigen-equation cancels it. Every off-diagonal weight is $A-C$ or $-C$, and $-C<A-C$. Sound.

**`ev_attains`.** $X=\varphi_{0p}$ is a nonzero bivector with $\mathrm{Wb}\,X=-C\,X$ (`diagOp_phi`, $0$ and $p$ in different factors). If no eigenvalue equalled $-C$, self-adjointness gives $(\mathrm{ev}_j+C)\langle X,v_j\rangle=0$, so $X$ is orthogonal to every frame vector, and `complete` forces $X=0$. Sound as typed. The falsifier for either theorem would be a frame eigenvalue outside $\{A-C,-C\}$, or a spectrum missing $-C$, and the entrywise argument rules out both at every frame index.

## 4. The saturation identity and the ends of the spectrum

$(2p-2)(A-C)=2(p-1)\cdot\frac{p}{(p-1)(2p-1)}=\frac{2p}{2p-1}$, and $\frac{2p}{2p-1}-\frac1{2p-1}=1=\theta$. **CONFIRMED.** Top is $A-C>0$ and bottom $-C<0$ because $A>0$, which holds at every $p\ge2$, so the ordering itself needs no $p\ge3$.

**At $p=2$, $n=4$** the weights are $2/3$ on $\varphi_{01},\varphi_{23}$ and $-1/3$ on the four across pairs, trace zero, and $-\frac13+2\cdot\frac23=1$: $S^2\times S^2$ saturates too. It is excluded from the file only because `L71_saturated` takes `hn : 5 ≤ n`, the record's range, where $\mathfrak{so}(n)$ is simple. `hp : 3 ≤ p` is exactly $5\le2p$. The record's $n=4$ exceptional saturator is $W_{\mathbb{CP}^2}$, already checked in [L70b.lean](../lean/HamiltonsCubic/Results/L70b.lean).

## 5. L71_nonvacuous against the binders

Compared binder by binder in the inventory above: `W`, `hW`, `θ`, `lmin`, `lmax`, then `IsCritical W θ`, `lmin < 0`, `0 < lmax`, the two bracketing clauses, `θ = lmin + (((2 * p : ℕ) : ℝ) - 2) * lmax`, and `∃ γ, … = lmin`. These are `L71_saturated`'s `hc`, `hneg`, `hpos`, `hlo`, `hhi`, `hsat`, `hex` in order, with `n := 2 * p`. `hn` is a fact about the fixed dimension and is carried by `hp`. **Nothing weaker, nothing stronger.** The record's unit norm is absent from both the theorem and the witness, consistently, and by the homogeneity of Section 1 that is no gap. **CONFIRMED.**

## 6. L71_witness

The conclusion is produced by `refine L71Sat.L71_saturated (n := 2 * p) …`, so it is `L71_saturated`'s conclusion at `Wb p`, `θ = 1`, with `lmin`, `lmax` unfolded to their values. **CONFIRMED literal.**

**What it says here.** $\mathfrak m=E_{\min}$ is spanned by the $p^2$ across bivectors $\varphi_{ab}$, $a<p\le b$, which is $\mathbb R^p\otimes\mathbb R^p$. $\mathfrak h=E_{\max}$ is spanned by the within bivectors, $\mathfrak{so}(p)\oplus\mathfrak{so}(p)$, dimension $p(p-1)=n(n-2)/4$. The pair $(\mathfrak{so}(2p),\mathfrak{so}(p)\oplus\mathfrak{so}(p))$ is the symmetric pair of the real Grassmannian $SO(2p)/(SO(p)\times SO(p))$.

- `spanOf … (ev k ≠ lmin ∧ ev k ≠ lmax) = ⊥` holds because the index set is empty, `ev_bounds`' entrywise argument putting every eigenvalue in $\{A-C,-C\}$. That is the two-valuedness of a two-weight diagonal operator, a real fact about this operator, although its span statement is the trivial one.
- $E_{\max}=[E_{\min},E_{\min}]$ holds for a real reason: $[\varphi_{ab},\varphi_{a'b'}]$ with $a,a'$ in the first factor and $b,b'$ in the second is $\pm\varphi_{aa'}$ when $b=b'$ and $\pm\varphi_{bb'}$ when $a=a'$, and these span both $\mathfrak{so}(p)$ summands.
- $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ is closure of $\mathfrak{so}(p)\oplus\mathfrak{so}(p)$.

**Observation O1.** The Lean proof of `L71_witness` is an application of `L71_saturated`, so it adds no computation beyond `L71_nonvacuous`. It shows the conclusion is true at a named object and agrees with the direct bracket computation above, which is what a non-vacuity witness owes. The spans are spans of whatever orthonormal eigenframe `eigenFrame_exists` picks. Those equal the eigenspaces by the spectral theorem, the one-step identification r1692 O1 already recorded.

## 7. The residue: a saturating witness at odd n ≥ 5

**REFUTED AS STATED.** The object the row owes does not exist.

- The record: [Lemma L71](../findings/bounds.md#lemma-l71-saturation-forces-the-balanced-sphere-product-with-no-two-eigenvalue-hypothesis) states *"no critical point saturates at odd $n\ge5$, since $\dim\mathfrak m=n^2/4\notin\mathbb Z$"*, and the [L117 row](../lean/INDEX.md) states the equality clause *"has no instance at $5,7,9$"*.
- The layer: `L117_no_eq_odd` ([L117Frame.lean:238](../lean/HamiltonsCubic/Results/L117Frame.lean#L238)) takes `hn : 3 ≤ n`, `¬ Even n`, `hW`, `hc`, `hγ` (which is `hex` with its witness named), `hneg`, `hpos`, `hlo`, `hhi`, `hsat`, the same binders as `L71_saturated`, and concludes that the spectrum is **not** two-valued in $\{\lambda_{\min},\lambda_{\max}\}$.
- `L71_saturated` concludes `spanOf v (ev ≠ lmin ∧ ev ≠ lmax) = ⊥`. A frame vector with a middle label would lie in that span while having norm one, so every label is `lmin` or `lmax`. That is the one-step corollary r1692 O2 already names ("$W$ has exactly two eigenvalues").
- Composing the three: at odd $n\ge5$ the hypotheses of `L71_saturated` are jointly unsatisfiable. A "saturating witness at odd $n\ge5$" would falsify both `L71_saturated` and `L117_no_eq_odd`.

**What I searched for a falsifier.** The record's L71 statement and its converse blockquote, the L117 and L169 rows of [lean/INDEX.md](../lean/INDEX.md), and the grep for "witness at odd" across [lean/INDEX.md](../lean/INDEX.md), [plan-lean.md](../plan-lean.md) and [STATUS.md](../STATUS.md). No saturating object at odd $n$ appears anywhere on the record, and the record's own clause excludes one.

**The right residue** is the vacuity statement: `L71_saturated`'s hypotheses have no instance at odd $n\ge5$, proved by `L71_saturated`, the two-valued corollary, and `L117_no_eq_odd`. That is a bounded Lean step. Owing an odd witness instead leaves the row asking for a counterexample to two proved theorems. The remaining owed items (Cartan's classification, `out`, and the one-step corollaries) are the right residue otherwise, and the two-valued corollary is the one the vacuity statement needs first.

## 8. Docstring inventory

The brief and the row count 17 declarations. The file has 19 top-level declarations: the 17 listed plus `hbs` and `hn`, both used by `Wb_isWeylOp`, `Wb_critical` and `ev_attains`. The module docstring lists `saturates` as a bullet in the same style as named declarations, and no declaration of that name exists (the identity is the third `?_` of `L71_nonvacuous` and of `L71_witness`). Nit, no mathematical consequence.

## Overall verdict

**CONFIRMED** for [L71Witness.lean](../lean/HamiltonsCubic/Results/L71Witness.lean): `Wb p` is the balanced sphere product's Weyl operator, it is critical at $\theta=1$, its $\Lambda^2$ spectrum through `Mpair_isHermitian` is $\{-C,A-C\}$ with both ends attained where needed, it saturates, and `L71_nonvacuous` and `L71_witness` match `L71_saturated` binder for binder at every even $n\ge6$. r1692 O3 is discharged there. **REFUTED AS STATED** for the row's new residue: the odd-$n$ witness is impossible by the record and by `L117_no_eq_odd` composed with `L71_saturated`, and the item should be replaced by that vacuity statement. Two docstring nits (19 declarations, no `saturates`).
