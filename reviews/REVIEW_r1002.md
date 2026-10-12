# Reviewer 1002: does `I36Budget` discharge what L174 carries?

*Cold brief: [BRIEF-g2-i36-budget.md](BRIEF-g2-i36-budget.md), no prior report read, no author's conclusion supplied. **No numerical work was done.** Every value below is exact and rational, derived by hand. The machine steps are `lake build`, `#check`, `#print axioms`, and the elaboration of one witness file of 100 lines that I wrote for this round: each reports what the kernel holds rather than computing a value, and the witness cost under a minute. Log: [agent_logs/r1002.log](../agent_logs/r1002.log).*

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | `WeylT n` is inhabited, and by something with content | **CONFIRMED**, with a kernel-checked nonzero witness at every $n\ge4$ and a scope note at $n\le3$ |
| 2 | `IsUnitC` and `IsWeyl` are jointly satisfiable, at the record's normalisation | **CONFIRMED** on both halves, the same witness, and the two normalisations agree where both are defined |
| 3 | `IsCoordDiagonalC` is the record's "coordinate-diagonal in some frame" | **CONFIRMED**, it is [L94](../findings/bispectral.md)'s own right-hand side verbatim |
| 4 | `kappaSqC` is the record's $\kappa^2$, with the supremum attained | **CONFIRMED**, attainment proved in the file and load-bearing |
| 5 | `l94_concrete` has the type L174's `shape_iff_budget` takes, no implicit different | **CONFIRMED**, checked in the kernel rather than read off the source |
| 6 | `shape_iff_budget_concrete` carries I36 content beyond `l94_concrete` | **REFUTED**, its whole content is `l94_concrete`, and the threshold `t` is consumed nowhere |
| 7 | this discharges [plan-lean.md](../plan-lean.md)'s `L94` row | **CONFIRMED for one of the two `Prop`s**, and the row still collapses them into one |

**Actionable summary.** Two index repairs, no mathematical defect: [plan-lean.md](../plan-lean.md)'s `L94` row names one definition site where the tree has two distinct `Prop`s of that name ([L174.lean:44](../lean/HamiltonsCubic/Results/L174.lean#L44) and [L174Statement.lean:60](../lean/HamiltonsCubic/Results/L174Statement.lean#L60)), which is the error its own preamble says an audit corrected, and its *concluded by* column should now read [I36Budget.lean](../lean/HamiltonsCubic/Results/I36Budget.lean) for the first of them; and [lean/INDEX.md:133](../lean/INDEX.md#L133)'s row says *a unit Weyl $W$ **above the threshold*** where the theorem holds at every unit Weyl $W$ and reads the threshold nowhere.

## 0. Conventions, fixed once

- $n$ is the ambient dimension, indices run over `Fin n`, and all index tuples below are $0$-based, matching Lean.
- $M$ is the curvature **operator on $\Lambda^2$**, $M_{(ab),(cd)}=W_{abcd}$ in the basis $\{\varphi_{ab}\}_{a<b}$, which [conventions.md:88](../findings/conventions.md) makes orthonormal under the half-trace pairing. So $\lVert M\rVert_F^2=\sum_{a<b}\sum_{c<d}W_{abcd}^2$, which is [normM2](../lean/HamiltonsCubic/Results/L94Statement.lean#L89) verbatim, and $\operatorname{tr}(M^2)=\lVert M\rVert_F^2$ because pair symmetry makes $M$ symmetric.
- $K=K(F)$ is the $n\times n$ **sectional** matrix, $K_{ab}=W_{abab}(F)$, symmetric and hollow. $t_F=\lVert K(F)\rVert_F^2=\sum_{a\ne b}K_{ab}^2$, the ordered sum, which is [frobK](../lean/HamiltonsCubic/Results/L94Statement.lean#L84) verbatim, its $a=b$ terms vanishing by antisymmetry.
- $\kappa^2=\max_F t_F$ over orthonormal frames, which is [kappaSq](../lean/HamiltonsCubic/Results/L94Statement.lean#L98) written as an `sSup`.
- $\delta$ is the Kronecker delta. $\lambda$ is a symmetric hollow $n\times n$ real matrix.
- $\mathcal W_n$ is the space of Weyl tensors on $\mathbb R^n$, of dimension $n(n+1)(n+2)(n-3)/12$.

## Hypothesis inventory, as the declarations bind it

| declaration | binders | conclusion |
| --- | --- | --- |
| [kappaSq_eq_two_iff](../lean/HamiltonsCubic/Results/L94Statement.lean#L535) | `IsWeyl W`, `normM2 W = 1` | $\kappa^2(W)=2\iff\exists R$ frame with `rotate R W` coordinate-diagonal |
| [L94](../lean/HamiltonsCubic/Results/L174.lean#L44) | `IsCoordDiagonal`, `kappaSq`, `IsUnit` over implicit `Weyl`, `Frame` | $\forall W$ unit, $\kappa^2(W)=2\iff\exists F$, `IsCoordDiagonal W F` |
| [shape_iff_budget](../lean/HamiltonsCubic/Results/L174.lean#L58) | the five predicates, `t : ℝ`, and `h94 : L94 …` | `I36_shape ↔ I36_budget` |
| [l94_concrete](../lean/HamiltonsCubic/Results/I36Budget.lean#L46) | `{n : ℕ}` alone | `L94 IsCoordDiagonalC kappaSqC IsUnitC` |
| [shape_iff_budget_concrete](../lean/HamiltonsCubic/Results/I36Budget.lean#L60) | `theta`, `IsLocalMax`, `t`, all free | `I36_shape … ↔ I36_budget …` |

**Kernel status, read rather than assumed.** `lake build HamiltonsCubic.Results.I36Budget` completes over 8708 jobs. `#print axioms` returns `[propext, Classical.choice, Quot.sound]` on `l94_concrete` and on `shape_iff_budget_concrete`, and on `kappa_sq_le_and_equality`, `kappaSq_eq_iff` and `kappaSq_eq_two_iff` beneath them. No `sorry` and no `native_decide` on this chain, so the round is about the objects and not the manipulations, as the brief directs.

## 1. Is `WeylT n` inhabited, and by anything with content?

**Verdict: CONFIRMED**, with one scope note that costs the file nothing.

[WeylT n](../lean/HamiltonsCubic/Results/I36Budget.lean#L28) is `{W : Tensor4 n // IsWeyl W}`. The zero tensor inhabits it at every $n$, which [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean) already types as an `example`. That answers inhabitation and answers nothing else, because item 2's `IsUnitC` excludes it.

**A nonzero member at every $n\ge4$, exhibited in closed form.** For $\lambda$ symmetric, hollow and with every row sum zero, set

$$W_{abcd}\ =\ \lambda_{ab}\,(\delta_{ac}\delta_{bd}-\delta_{ad}\delta_{bc}).$$

This is a Weyl tensor at every $n$ and every such $\lambda$, by four one-line checks.

- **Antisymmetry in each pair** is the antisymmetry of the bracket, with $\lambda_{ba}=\lambda_{ab}$ for the first slot.
- **Pair symmetry.** When $\delta_{ac}\delta_{bd}\ne0$ we have $a=c$ and $b=d$, so $\lambda_{cd}=\lambda_{ab}$; when $\delta_{ad}\delta_{bc}\ne0$ we have $a=d$ and $b=c$, so $\lambda_{cd}=\lambda_{ba}=\lambda_{ab}$; and when both vanish both sides are $0$.
- **The first Bianchi identity** holds term by term, in three cancelling pairs. Expanding $W_{abcd}+W_{acdb}+W_{adbc}$ and grouping by delta product: the $\delta_{ac}\delta_{bd}$ terms are $+\lambda_{ab}-\lambda_{ad}$, zero because $b=d$ there; the $\delta_{ad}\delta_{bc}$ terms are $-\lambda_{ab}+\lambda_{ac}$, zero because $b=c$ there; the $\delta_{ab}\delta_{cd}$ terms are $-\lambda_{ac}+\lambda_{ad}$, zero because $c=d$ there.
- **Tracelessness.** $W_{abad}=\lambda_{ab}(\delta_{bd}-\delta_{ad}\delta_{ab})$, and the second term survives only at $a=b=d$ where $\lambda_{aa}=0$, so $\sum_aW_{abad}=\delta_{bd}\sum_a\lambda_{ab}=0$ by the row sums.

**At $n=4$ this is a two-parameter family and it is not empty.** Hollow symmetric $\lambda$ on four indices has six entries, the row-sum map to $\mathbb R^4$ is the unsigned incidence matrix of $K_4$, of rank $4$ because $K_4$ has an odd cycle, so the solution space is $2$-dimensional: $\lambda_{01}=\lambda_{23}=s$, $\lambda_{02}=\lambda_{13}=r$, $\lambda_{03}=\lambda_{12}=u$ with $s+r+u=0$. **The member I take is $(s,r,u)=(\tfrac12,-\tfrac12,0)$**, and $W_{0101}=\tfrac12\ne0$. Padding $\lambda$ with zero rows carries it to every $n\ge4$, the row sums being unchanged.

**Kernel-checked, not asserted.** I wrote the construction and this member into a scratch file against the repository's own definitions and elaborated it under `lake env lean`. `Wd_isWeyl` proves `IsWeyl (Wd lam)` from the three conditions on $\lambda$ at every $n$, `W4_isWeyl` instantiates it, `W4_nonzero` gives $W_{0101}=\tfrac12$, and the chain reports the three standard axioms.

```lean
def Wd (lam : Fin n → Fin n → ℝ) : Tensor4 n :=
  fun a b c d => lam a b * (dl a c * dl b d - dl a d * dl b c)

theorem Wd_isWeyl (lam : Fin n → Fin n → ℝ)
    (hsym : ∀ a b, lam a b = lam b a) (hhol : ∀ a, lam a a = 0)
    (hrow : ∀ b, ∑ a, lam a b = 0) : IsWeyl (Wd lam)

noncomputable def lam4 : Fin 4 → Fin 4 → ℝ :=
  ![![0, 1/2, -1/2, 0], ![1/2, 0, 0, -1/2], ![-1/2, 0, 0, 1/2], ![0, -1/2, 1/2, 0]]
```

**The scope note, and it is a property of the mathematics rather than of the file.** At $n\le3$ the only Weyl tensor is zero, so `WeylT n` is inhabited there by $0$ alone and item 2's class is empty. At $n=2$ this is immediate from the definitions in the file: tracelessness at $b=d=1$ reads $W_{0101}=0$, and $\Lambda^2$ is one-dimensional. At $n=3$ the Hodge star carries $M$ to a symmetric $3\times3$ matrix $S$ with $\mathrm{Ric}=(\operatorname{tr}S)\,\mathrm{Id}-S$, so $\mathrm{Ric}=0$ gives $3\operatorname{tr}S=\operatorname{tr}S$, then $\operatorname{tr}S=0$ and $S=0$. **So `l94_concrete` is vacuous at $n\le3$ and has content at every $n\ge4$**, which is the range [plan.md](../plan.md) quantifies I36 over, and [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s own threshold remark already works at $4\le n\le11$ and $n\ge12$.

**And the class is interesting in the sharper sense the brief means: both sides of the biconditional are realised on it.** The member above is coordinate-diagonal in the identity frame, so `kappaSqC` $=2$ there, proved in the same scratch file *through* `l94_concrete` itself. Off the diagonal locus the record holds the other case: [Lemma L95](../findings/bispectral.md) gives $\kappa^2(\mathbb{CP}^m)=3/(m+1)$, so $\kappa^2(W_{\mathbb{CP}^2})=1\ne2$ at unit norm and that tensor is coordinate-diagonal in no frame. **I also have an independent count that does not lean on L95's numeric confirmation**: the coordinate-diagonal locus of $\mathcal W_4$ is exactly $\{W(\lambda)\}$, of dimension $2$, so the tensors coordinate-diagonal in *some* frame form the image of a smooth map from $O(4)\times\mathbb R^2$, of source dimension $6+2=8$, into $\mathcal W_4$ of dimension $4\cdot5\cdot6\cdot1/12=10$. **An $8$-dimensional source cannot cover a $10$-dimensional target**, so a generic unit Weyl tensor at $n=4$ falsifies both sides at once.

## 2. Is `IsUnitC` satisfiable together with `IsWeyl`, and is it the record's normalisation?

**Verdict: CONFIRMED on both halves.**

**Satisfiability.** [IsUnitC](../lean/HamiltonsCubic/Results/I36Budget.lean#L41) is `normM2 W.1 = 1`. At the member of section 1, the only nonvanishing components with $a<b$ and $c<d$ are the four diagonal ones $W_{abab}=\lambda_{ab}$, so

$$\lVert M\rVert_F^2=\sum_{a<b}\lambda_{ab}^2=\tfrac14+\tfrac14+0+0+\tfrac14+\tfrac14=1 .$$

This is `W4_unit : normM2 W4 = 1`, kernel-checked, and with `W4_isWeyl` it gives `WT4 : WeylT 4` satisfying `IsUnitC`. **The conjunction is not empty.** The same scratch file then closes `WT4_kappa : kappaSqC WT4 = 2` by feeding the identity frame through `l94_concrete`, and `#print axioms` on it returns `[propext, Classical.choice, Quot.sound]`, so the instantiated `L94` is applied to a real object and returns a real value.

**The normalisation, which is the half the brief flags.** [conventions.md:157](../findings/conventions.md) states outright that **the letter $M$ carries two objects**: the $\Lambda^2$ operator, and the $n\times n$ sectional or vertex matrix that [diagonal-half.md](../findings/diagonal-half.md) writes $\operatorname{tr}M^2=2$ over. The two squared norms differ by a factor $2$ on the diagonal locus and by less off it, since $t_F=2\lVert\operatorname{diag}W\rVert^2\le2\lVert M\rVert_F^2$ with equality exactly at coordinate-diagonal. **So `normM2 W = 1` and $\operatorname{tr}M^2=2$ are the same normalisation read at the two objects, and they agree exactly on the locus where the record uses the second.** My section-1 member checks this in closed form: $\lVert M\rVert_F^2=1$ for the operator and $\lVert K\rVert_F^2=\sum_{a\ne b}\lambda_{ab}^2=2$ for the sectional matrix, at one and the same tensor. [r1001](REVIEW_r1001.md) reached the same identification from the other side, `diagOp_normSq` giving *the record's normalisation $\operatorname{tr}M^2=2$ is exactly $\lVert W\rVert^2=1$*.

**And `kappaSq_eq_two_iff` is stated at the normalisation its $\kappa^2=2$ needs.** [second-order.md:2025](../findings/second-order.md) states the failure mode explicitly: under the sectional sense $\lVert M\rVert_F^2=2$ at a unit Weyl tensor, L94 would read $\kappa^2\le4$ and *at unit norm that reads $\kappa^2=2$* would be false, and it names the working sense as the $\Lambda^2$ operator matrix. [normM2](../lean/HamiltonsCubic/Results/L94Statement.lean#L89) sums over $a<b$ and $c<d$, which is the $\Lambda^2$ operator matrix and not the sectional one, and [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean)'s own header says so as *the record's norm-choice warning built into the definition instead of stated beside it*. **The invisible risk [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) names first is therefore discharged and not carried**, and `IsUnitC` is the binder that discharges it.

## 3. Is `IsCoordDiagonalC` the record's "diagonal in some frame"?

**Verdict: CONFIRMED.**

[IsCoordDiagonalC W F](../lean/HamiltonsCubic/Results/I36Budget.lean#L34) unfolds to `CoordinateDiagonal (rotate F.1 W.1)`, and [FrameT n](../lean/HamiltonsCubic/Results/I36Budget.lean#L31) is `{R // IsFrame R}` with [IsFrame](../lean/HamiltonsCubic/Results/L94Statement.lean#L75) reading $RR^{\mathsf T}=\mathrm{Id}$. So `∃ F : FrameT n, IsCoordDiagonalC W F` is, term for term, the right-hand side of [kappaSq_eq_two_iff](../lean/HamiltonsCubic/Results/L94Statement.lean#L535): $\exists R$, `IsFrame R ∧ CoordinateDiagonal (rotate R W)`. There is no re-wording between the two, which is what the `exact ⟨⟨R, hR⟩, hcd⟩` and `h.mpr ⟨F.1, F.2, hF⟩` steps of the proof do and all they do.

Three checks against the record.

- **The predicate.** [CoordinateDiagonal](../lean/HamiltonsCubic/Results/L94Statement.lean#L94) says $W_{abcd}=0$ unless the index pairs coincide as sets, which is *every off-diagonal entry of $M$ in the pair basis of $F$ vanishes* at [bispectral.md:499](../findings/bispectral.md). The clauses match in both directions and neither adds a condition.
- **The group.** `IsFrame` is $O(n)$ and not $SO(n)$, which is the group the record's $\kappa$ is invariant under, stated at the head of [the L94 block](../findings/bispectral.md). A restriction to $SO(n)$ would have been a real narrowing, and the file does not make it.
- **The quantifier.** [plan.md:142](../plan.md) asks whether every local maximiser above $\sqrt{3/2}$ is *coordinate-diagonal in some frame*, an existential over frames outside the tensor, and `I36_shape` binds `W` first and `F` inside, matching. This is the one place [r1001](REVIEW_r1001.md) recorded a quantifier gap in the other diagonal-locus file, where `diagOp` is the coordinate locus in a fixed frame, and **the gap does not recur here**: `IsCoordDiagonalC` carries the frame as an argument, so the existential is present rather than implied.

## 4. Is `kappaSqC` the record's $\kappa^2$, and is the supremum attained?

**Verdict: CONFIRMED**, and attainment is proved rather than assumed.

[kappaSqC](../lean/HamiltonsCubic/Results/I36Budget.lean#L38) is `kappaSq W.1`, an `sSup` over $\{\lVert K(R)\rVert_F^2 : R$ a frame$\}$. Three things make it the record's object.

- **The per-frame quantity matches.** [frobK](../lean/HamiltonsCubic/Results/L94Statement.lean#L84) is $\sum_a\sum_b(\text{rotate }R\,W)_{abab}^2$, the **ordered** sum, whose $a=b$ terms vanish by antisymmetry, so it equals $\sum_{a\ne b}K_{ab}^2$. That is [the L94 block](../findings/bispectral.md)'s $t_F=\lVert K(F)\rVert_F^2=\sum_{a\ne b}W_{abab}(F)^2$ exactly. The ordered reading is the one [L174Statement.lean](../lean/HamiltonsCubic/Results/L174Statement.lean)'s `ordered_is_double` isolates as the hazard, *read as an unordered sum, $t_F\le1$ and $\kappa^2=2$ holds nowhere*, and the file is on the safe side of it.
- **The supremum is attained, and the file proves it.** [kappaSq_attained](../lean/HamiltonsCubic/Results/L94Statement.lean#L488) gives $\exists R$ frame with `frobK R W = kappaSq W`, from [frames_compact](../lean/HamiltonsCubic/Results/L94Statement.lean#L480) (closed and bounded in finite dimension) and continuity of `frobK`. Nonemptiness comes from [isFrame_id](../lean/HamiltonsCubic/Results/L94Statement.lean#L104) and boundedness above from the frame-wise bound, both supplied at the `csSup` and `le_csSup` calls.
- **Attainment is load-bearing, so its proof is not decoration.** In [kappaSq_eq_iff](../lean/HamiltonsCubic/Results/L94Statement.lean#L502) the forward direction reads `obtain ⟨R, hR, hRk⟩ := kappaSq_attained W` and then `hRk.trans h`. Without it, $\kappa^2=2\lVert M\rVert_F^2$ would say only that $2\lVert M\rVert_F^2$ is a least upper bound, and the frame-wise equality clause [equality_iff](../lean/HamiltonsCubic/Results/L94Statement.lean#L381) would have nothing to consume, so no diagonalising frame would be produced. **An unattained supremum would break exactly the direction I36 uses**, budget to shape, and it is the direction `shape_iff_budget`'s `mp` branch runs. The record names the same point, *carrying attainment of $\max_F$*, at [L174Statement.lean](../lean/HamiltonsCubic/Results/L174Statement.lean)'s quotation of the block.

**One scope note that widens rather than narrows.** [kappa_sq_le_and_equality](../lean/HamiltonsCubic/Results/L94Statement.lean#L443) uses only the two antisymmetries, as the record's L94 does, while `kappaSq_eq_two_iff` binds the full `IsWeyl`. So the Lean bridge is stated at a **narrower** hypothesis class than the record's lemma. It costs nothing here, because `WeylT n` is the type I36 quantifies over, and it is the right choice for this file.

## 5. Does `l94_concrete` have the type `L94` at those instantiations?

**Verdict: CONFIRMED**, checked in the kernel rather than argued from the source.

Elaborating `#check @HamiltonsCubic.I36Budget.l94_concrete` against the built library returns

```
∀ {n : ℕ}, VertexBudget.L94 I36Budget.IsCoordDiagonalC I36Budget.kappaSqC I36Budget.IsUnitC
```

and `#check @HamiltonsCubic.VertexBudget.shape_iff_budget` returns a hypothesis of the shape `VertexBudget.L94 IsCoordDiagonal kappaSq IsUnit`. **The three explicit arguments agree in order and in type**, and `Weyl` and `Frame` are the only implicits, fixed to `WeylT n` and `FrameT n` by unification against the predicates. `theta` and `IsLocalMax` are declared as `variable`s in [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) and neither appears in `L94`'s body, so Lean's variable inclusion leaves them out of the `def` altogether, and there is no silent fifth argument.

`#print HamiltonsCubic.I36Budget.l94_concrete` shows the proof term reaching `L94Statement.kappaSq_eq_two_iff ↑W W.property hW` with no coercion step and no bridging lemma, `W.property` supplying `IsWeyl` and `hW` supplying `normM2 W.1 = 1` definitionally from `IsUnitC`. **`shape_iff_budget_concrete` then passes the same three predicates into `I36_shape` and `I36_budget`**, which the elaborated signature confirms, so the `IsUnitC` under the biconditional is the one `l94_concrete` discharges and not a second predicate of the same shape.

## 6. What does `shape_iff_budget_concrete` leave open?

**Verdict: REFUTED**, as a claim that it carries I36 content beyond `l94_concrete`. This agrees with the file's own docstring and with [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s, so it is a confirmation of their honesty rather than a finding against them.

**What it gives.** At the concrete tensors, and with no hypothesis left standing, the shape reading and the budget reading of I36 are interchangeable. Anyone proving either one gets the other for free, which is a genuine transfer and the thing the item was reformulated for.

**What it does not give.** Neither side. `I36_shape` is not proved, `I36_budget` is not proved, and the theorem is consistent with both being false, which is exactly what the section-1 dimension count shows happens at a generic unit Weyl tensor at $n=4$ under any `theta` and `IsLocalMax` making that tensor a maximiser.

**`theta` and `IsLocalMax` universally quantified.** As a Lean statement this is **stronger**, since every instance follows. As a statement about I36 it is **weaker in exactly the way that matters**: the equivalence is proved for *every* real-valued function and *every* predicate on `WeylT n`, so nothing in it depends on those being the record's $\theta$ and the record's local-maximality. Neither is defined anywhere in the Lean layer at these types, so **the link to I36 is by naming and not by typing**. The theorem is reusable the day someone defines them, which is the honest reading, and it is not a statement about $\theta$ today.

**The threshold `t` plays no role in the proof, and it is not that it plays a small one.** [shape_iff_budget](../lean/HamiltonsCubic/Results/L174.lean#L58)'s two branches read `(h94 W hu).mpr (h W hu hm ht)` and `(h94 W hu).mp (h W hu hm ht)`: `ht : t < theta W` is passed straight through to `h` and `h94` never sees it, nor does `hm : IsLocalMax W`. **`h94 W hu` is the whole proof**, so the statement holds at $t=0$, at $t=-100$, and at `IsLocalMax := fun _ => True`. [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) says this itself, *the maximiser hypotheses are idle*, and [L174Statement.lean](../lean/HamiltonsCubic/Results/L174Statement.lean) types the general form where the class is arbitrary, including empty.

**So the precise content of `shape_iff_budget_concrete` is: `l94_concrete`, re-expressed under two quantifiers.** [lean/INDEX.md:133](../lean/INDEX.md#L133) describes it as *a unit Weyl $W$ **above the threshold** is coordinate-diagonal in some frame exactly when $\kappa^2(W)=2$*, and the qualification is a weakening of what is proved as well as a misplacement of where the threshold enters, which is nowhere. `l94_concrete` holds at every unit Weyl $W$.

**What I36 still needs, stated positively.** A proof that a unit local maximiser with $\theta>\sqrt{3/2}$ attains $\kappa^2=2$, or that it is coordinate-diagonal in some frame. This file supplies the licence to choose whichever of the two is easier and says nothing about either.

## 7. Does this discharge [plan-lean.md](../plan-lean.md)'s `L94` row?

**Verdict: CONFIRMED for one of the two `Prop`s**, and the row needs a repair its own preamble already prescribes.

**The row names one definition site and the tree has two.** [plan-lean.md:66](../plan-lean.md#L66) reads `L94` | defined [L174.lean:44](../lean/HamiltonsCubic/Results/L174.lean#L44) | taken as a hypothesis by [L174.lean](../lean/HamiltonsCubic/Results/L174.lean), [L174Statement.lean](../lean/HamiltonsCubic/Results/L174Statement.lean) | concluded by nothing. A grep of the tree gives `def L94` at [L174.lean:44](../lean/HamiltonsCubic/Results/L174.lean#L44) and again at [L174Statement.lean:60](../lean/HamiltonsCubic/Results/L174Statement.lean#L60), in different namespaces. The second file's three binders (`class_transfer`, `I36_shape_iff_budget`, `empty_class`) take **its own** `Prop`, not [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s, which it cannot, since it does not import that file. **So the row is an instance of the failure its own preamble reports an audit having fixed**, *two different `Prop`s of the same name collapsed into one row*, and the `DiagCriticalityIsCritical` row two lines above shows the format for the repair, `DEFINED 2 TIMES` with both sites.

**Which one this reaches.** [I36Budget.lean](../lean/HamiltonsCubic/Results/I36Budget.lean) imports [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) and not [L174Statement.lean](../lean/HamiltonsCubic/Results/L174Statement.lean), and `l94_concrete` concludes `VertexBudget.L94`. So it reaches the first, and the *concluded by* column for that `Prop` becomes [I36Budget.lean](../lean/HamiltonsCubic/Results/I36Budget.lean). **The producer is unconditional**, taking only `{n : ℕ}`, so the table's *a conditional producer moves the debt rather than closing it* rule does not apply and the debt is closed at that instantiation.

**Whether the other is reachable: yes, and at zero cost.** The two `Prop`s are definitionally one, differing only in binder names and in `W` and `F` being implicit in the second. I confirmed this in the kernel rather than by reading: in a scratch file importing both,

```lean
theorem l94_stmt_concrete {n : ℕ} :
    L174Statement.L94 (W := WeylT n) (F := FrameT n) IsCoordDiagonalC kappaSqC IsUnitC :=
  l94_concrete
```

elaborates, with `#print axioms` returning the three standard ones. **There is no bridging term**, `l94_concrete` is accepted at the other type on the nose. So the second row is one `import` and one line away, and until someone writes them it stands at *concluded by nothing* in the tree.

**What is not discharged, and this is not a defect.** The binder in [shape_iff_budget](../lean/HamiltonsCubic/Results/L174.lean#L58) cannot be removed, because the abstract `L94` is **false** at some instantiations and so is not a theorem: take `Weyl = Frame = Unit`, `IsCoordDiagonal = fun _ _ => True`, `kappaSq = fun _ => 0`, `IsUnit = fun _ => True`, and the biconditional reads $0=2\iff\text{True}$. **That is the plan-lean trap cleared in the direction the table asks for**, a binder that excludes something, exhibited. What [I36Budget.lean](../lean/HamiltonsCubic/Results/I36Budget.lean) removes is the binder from the statement I36 needs, which is the whole of what was owed.

## Overall verdict

**PROVEN.** The instantiation discharges something real, on all three of the hazards the brief names. `WeylT n` is inhabited by objects with content at every $n\ge4$, and I exhibit one, kernel-checked, satisfying `IsUnitC` and `IsWeyl` together. `IsUnitC` is the record's working normalisation and is the one `kappaSq_eq_two_iff`'s numeral $2$ requires, the competing $\operatorname{tr}M^2=2$ being the same normalisation read at the sectional matrix. `IsCoordDiagonalC` and `kappaSqC` are the record's objects term for term, with the attainment the equality clause needs proved rather than assumed. The binders match in the kernel.

**The one thing to keep straight is what it buys.** `shape_iff_budget_concrete` is `l94_concrete` under two vacuous quantifiers and a threshold it never reads. I36's two readings are now interchangeable at the record's own tensors, with no hypothesis, and **neither reading is any closer to being true**.
