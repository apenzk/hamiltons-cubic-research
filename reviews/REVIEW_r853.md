# REVIEW r853: I36a, does [DecomposablePlane.lean](../lean/HamiltonsCubic/Results/DecomposablePlane.lean) state what its index row claims?

*This round was a single comparison of one Lean file against the claim made for it in [lean/INDEX.md](../lean/INDEX.md) line 96, and against the prose it types at [findings/diagonal-half.md](../findings/diagonal-half.md) lines 1132 and 1134. It was not an argument check: the three proofs were built and their axiom dependencies read, and no proof step was re-derived by hand. Every arithmetic statement below is a screen, run by building a scratch Lean file that has since been removed.*

## CLAIM TABLE

| # | What the row claims | Verdict | Reason |
|---|---|---|---|
| 1 | "the build carrying no gap", "no compiler-trusting tactic" | **CONFIRMED** | all three declarations depend on `propext`, `Classical.choice`, `Quot.sound` and nothing else, with one style warning |
| 2 | `wedgeSelf_smul_add` is the polarisation $a^2\,\mathrm{wedgeSelf}X+2ab\,\mathrm{wedge2}\,XY+b^2\,\mathrm{wedgeSelf}Y$ | **CONFIRMED** | term for term identical, and the constant $2$ is forced by [wedgeSelf X = wedge2 X X](../lean/HamiltonsCubic/Base/SelfDual.lean#L106) |
| 3 | `plane_decomposable_iff_wedge2_zero` is that equivalence | **CONFIRMED** | the iff is faithful and holds more widely than for planes, the quantifier over all `a b` being equivalent to the quantifier over nonzero elements |
| 4 | the theorem is about decomposable 2-forms although skewness is never written | **CONFIRMED** | `wedgeSelf M = 0` forces `Mᵀ = -M`, proved as a screen, so the hypotheses carry skewness silently |
| 5 | `wedge2_phi_ne_zero` is "the witness separating the two conditions" | **GAP** | `wedgeSelf (phi 0 1) = 0` and `wedgeSelf (phi 2 3) = 0` are true and the file states neither, so the file exhibits no decomposable basis |
| 6 | "at every dimension" | **CONFIRMED** | `ι` is an arbitrary `Fintype` with `DecidableEq`, both instances unused, and the row itself scopes the third theorem to $n=4$ |
| 7 | the hypotheses are inhabited | **CONFIRMED** | `phi 0 1` and `phi 0 2` satisfy both, are independent, and the theorem applied to them yields the whole pencil |
| 8 | the "what the file does NOT state" clause | **REFUTED AS STATED** | it omits the Plücker dictionary, the witness's decomposability and the witness pair's independence, and its parenthetical dichotomy is false for a plane |
| 9 | the criterion is "the $\ell=2$ core" of the Structure Theorem | **REFUTED AS STATED** | the $\ell=2$ theorem classifies subspaces of every dimension, the file's criterion covers dimension two, where the theorem's second type collapses into the first |
| 10 | the criterion reaches the geometric content | **GAP** | `wedge2 X Y = 0` is equivalent to the four support vectors being dependent for nonzero decomposables, and the file builds no support vector and requires no nonzero |

**One-line summary.** The three theorems are proved outright with no gap and the first two match the row exactly. Replace the row's witness sentence, its "$\ell=2$ core" phrase and its "does NOT state" clause with the text in the final section.

## 1. The build and the axioms

`lake env lean HamiltonsCubic/Results/DecomposablePlane.lean` exits `0`. One warning, at line 31:

```
warning: automatically included section variable(s) unused in theorem
  `HamiltonsCubic.Results.wedgeSelf_smul_add`: [Fintype ι] [DecidableEq ι]
```

`#print axioms` on each of the three, run from a scratch file importing the module:

```
'HamiltonsCubic.Results.wedgeSelf_smul_add' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.Results.plane_decomposable_iff_wedge2_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.Results.wedge2_phi_ne_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
```

None of the three depends on `sorryAx`, so the row's "no gap" holds for all three. None depends on `Lean.ofReduceBool` either, which is the axiom `native_decide` introduces, so "no compiler-trusting tactic" also holds. The tactics in use are `show`, `simp only`, `ring`, `funext`, `congrFun`, `linarith`, `norm_num` and `intro`, every one of which elaborates to a kernel-checked term.

## 2. The polarisation

The row's formula and [line 33](../lean/HamiltonsCubic/Results/DecomposablePlane.lean#L33) agree term for term. The Lean right side is `a ^ 2 * wedgeSelf X i j k l + 2 * (a * b) * wedge2 X Y i j k l + b ^ 2 * wedgeSelf Y i j k l`, which is the row's $a^2\,\mathrm{wedgeSelf}X+2ab\,\mathrm{wedge2}\,XY+b^2\,\mathrm{wedgeSelf}Y$ with the three coefficients in the same places.

The bracketing of the middle coefficient is syntax only. In Lean `2 * a * b` elaborates as `(2 * a) * b`, and multiplication in `ℝ` is associative, so `2 * (a * b)` and `2 * a * b` are equal terms of the same type and `ring` closes either. Nothing turns on the choice.

The constant $2$ is forced by the definitions, which is worth stating because it is the one number a polarisation can get wrong. [halfw](../lean/HamiltonsCubic/Base/SelfDual.lean#L99) is `fun a b c d => X a b * Y c d - X a c * Y b d + X a d * Y b c`, [wedge2](../lean/HamiltonsCubic/Base/SelfDual.lean#L103) is `halfw X Y + halfw Y X`, and [wedgeSelf](../lean/HamiltonsCubic/Base/SelfDual.lean#L106) is `wedge2 X X`, so `wedgeSelf X = wedge2 X X` holds by definition rather than by lemma. `wedge2` is symmetric ([wedge2_comm](../lean/HamiltonsCubic/Base/SelfDual.lean#L116)) and bilinear ([wedge2_add_left](../lean/HamiltonsCubic/Base/SelfDual.lean#L119), [wedge2_smul_left](../lean/HamiltonsCubic/Base/SelfDual.lean#L123)), so `wedgeSelf` is its quadratic form and the cross term of the expansion carries $2ab$ exactly. The row is right to call this the polarisation.

One difference in shape rather than content: the Lean statement is an equation between real numbers at four fixed indices `i j k l`, while the row writes an equation between $\Lambda^4$ components as a whole. The two differ by one `funext`, which [line 50](../lean/HamiltonsCubic/Results/DecomposablePlane.lean#L50) supplies where it is needed.

## 3. The equivalence, and what its left side says

The statement is

```
theorem plane_decomposable_iff_wedge2_zero (X Y : Matrix ι ι ℝ)
    (hX : wedgeSelf X = 0) (hY : wedgeSelf Y = 0) :
    (∀ a b : ℝ, wedgeSelf (a • X + b • Y) = 0) ↔ wedge2 X Y = 0
```

**The quantifier over all `a b` rather than over nonzero elements costs nothing.** The pair `(0, 0)` contributes `wedgeSelf 0 = 0`, which is [wedgeSelf_zero](../lean/HamiltonsCubic/Base/SelfDual.lean#L128) and holds unconditionally. So the universally quantified statement is equivalent to the same statement restricted to `(a, b) ≠ (0, 0)`, which is "every nonzero element of the span has vanishing self-wedge". On this axis the left side is faithful to "lies inside the locus".

**Independence is absent, and the theorem is true without it.** Nothing in the statement makes `X` and `Y` independent, nonzero, or skew. The theorem remains true for a dependent pair: with `Y = c • X` the left side reads `wedgeSelf ((a + b * c) • X) = (a + b * c) ^ 2 • wedgeSelf X = 0` by [wedgeSelf_smul](../lean/HamiltonsCubic/Base/SelfDual.lean#L133) and `hX`, while the right side reads `wedge2 X (c • X) = c • wedgeSelf X = 0` by [wedge2_smul_left](../lean/HamiltonsCubic/Base/SelfDual.lean#L123), so both sides are true and the iff holds. With `Y = 0` both sides are true likewise. So the omission widens the theorem to all pairs and the wider statement is sound: what the row calls a plane, the Lean calls a pair, and the pair version implies the plane version. The word "plane" in the row therefore describes a geometric object the file does not type, which is a naming imprecision rather than an error of content.

**What the left side does NOT say, read literally, is "decomposable".** It says a quartic vanishes on the span. The bridge from that to decomposability is the Plücker equivalence, that for a skew `ω` the condition `ω ∧ ω = 0` holds exactly when `ω` has rank at most two, and the file states it nowhere. Section 4 shows that the bridge is available, and section 8 records its absence as the row's largest undisclosed omission.

## 4. Skewness is implied, so its omission is not load-bearing

This is the item where the file comes out better than the brief's suspicion. `wedgeSelf` is defined on arbitrary matrices, and the hypothesis `wedgeSelf M = 0` by itself forces `M` skew. Screened in Lean, in the general `ι`:

```
theorem isSkew_of_wedgeSelf_eq_zero {ι : Type*} [Fintype ι] [DecidableEq ι]
    (M : Matrix ι ι ℝ) (h : wedgeSelf M = 0) : IsSkew M
```

built clean. The argument is two instances of [wedgeSelf_apply](../lean/HamiltonsCubic/Base/SelfDual.lean#L112). At `(a,a,a,a)` it gives $M_{aa}^2 = 0$, so the diagonal vanishes. At `(a,b,a,b)` and at `(b,a,b,a)`, with the diagonal gone, it gives $M_{ab}(M_{ab}+M_{ba}) = 0$ and $M_{ba}(M_{ab}+M_{ba}) = 0$, whose sum is $(M_{ab}+M_{ba})^2 = 0$, so $M_{ba} = -M_{ab}$ over `ℝ`.

**So the theorem is about 2-forms.** Precisely, `plane_decomposable_iff_wedge2_zero` is a statement about pairs of skew matrices of rank at most two over `ℝ` on a finite index type, which is to say pairs of decomposable elements of $\Lambda^2\mathbb{R}^n$ with the zero form admitted, and about the span of such a pair. The set `{M : wedgeSelf M = 0}` is exactly the cone of decomposable 2-forms together with zero, so the hypotheses are the record's "carries a decomposable basis" and the left side is the record's "is a decomposable subspace". The row's reading is the correct one. What the file omits is the sentence saying so, and a reader who does not reconstruct the above has no way to see that `wedgeSelf` being defined on all matrices does not widen the theorem past 2-forms.

## 5. The witness is half-stated

[wedge2_phi_ne_zero](../lean/HamiltonsCubic/Results/DecomposablePlane.lean#L72) asserts `wedge2 (phi 0 1) (phi 2 3) ≠ 0` at `Fin 4`, and that is all it asserts. A separation needs both halves: the pair satisfies the hypotheses, and the cross term fails. Screened, the missing half is true and one rewrite deep:

```
theorem wedgeSelf_phi01 : wedgeSelf (phi (0 : Fin 4) 1) = 0 := by
  rw [← areaForm_single]; exact wedgeSelf_areaForm _ _
```

and the same for `phi 2 3`, both built clean from [areaForm_single](../lean/HamiltonsCubic/Base/SelfDual.lean#L224) and [wedgeSelf_areaForm](../lean/HamiltonsCubic/Base/SelfDual.lean#L317), which the file already imports. A grep over `lean/HamiltonsCubic/` finds no `wedgeSelf_phi` and no occurrence of `wedgeSelf (phi i j)` as a standalone claim: the only `wedgeSelf (phi ...)` sites are [L183Statement.lean](../lean/HamiltonsCubic/Results/L183Statement.lean#L404) and [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean#L543), both about the sums `phi 0 1 + phi 2 3` and their fellows rather than about a single basis bivector.

So as it stands the third theorem exhibits a nonzero cross term for two matrices whose decomposability the file never records, and the row's description of it as "the witness separating the two conditions" credits it with more than it says. Two lines of Lean would close this, and this reviewer is reporting rather than repairing.

The same paragraph is missing the independence of `phi 0 1` and `phi 2 3`, without which no plane is exhibited even informally. That one is also cheap: their `(1,0)` entries are `-1` and `0`.

## 6. Quantification

`ι` is introduced at [line 27](../lean/HamiltonsCubic/Results/DecomposablePlane.lean#L27) as `{ι : Type*} [Fintype ι] [DecidableEq ι]`, so the first two theorems hold for every finite index type with decidable equality, which is the record's "at every dimension". The row is right, and the third theorem is at `Fin 4`, which the row states.

Two observations on the instances. The build warns that both are unused in `wedgeSelf_smul_add`, and `#check` confirms that [halfw](../lean/HamiltonsCubic/Base/SelfDual.lean#L99), [wedge2](../lean/HamiltonsCubic/Base/SelfDual.lean#L103) and [wedgeSelf](../lean/HamiltonsCubic/Base/SelfDual.lean#L106) carry no instance arguments at all:

```
@wedgeSelf : {ι : Type u_1} → Matrix ι ι ℝ → ι → ι → ι → ι → ℝ
```

The second theorem escapes the same warning only because its proof rewrites with the first, whose signature demands the instances. So both theorems are true verbatim for an arbitrary `ι : Type*`, and the file states them under a hypothesis they do not need. That is a restriction relative to what is provable and no threat to "at every dimension", since every dimension of the record is a `Fin n`.

## 7. Vacuity

The hypotheses admit an independent, nonzero, non-collinear pair, and the theorem applies to it. Screened at `Fin 4` with `X = phi 0 1` and `Y = phi 0 2`:

- `wedgeSelf (phi 0 1) = 0` and `wedgeSelf (phi 0 2) = 0`, by the rewrite of section 5.
- `wedge2 (phi 0 1) (phi 0 2) = 0`, by `fin_cases` on all four indices.
- `phi 0 1 ≠ c • phi 0 2` for every `c : ℝ`, from the `(1,0)` entry.
- Therefore `plane_decomposable_iff_wedge2_zero _ _ _ _ |>.mpr` yields `∀ a b, wedgeSelf (a • phi 0 1 + b • phi 0 2) = 0`, built clean.

That pair is the pencil $e_0\wedge\mathrm{span}\{e_1,e_2\}$, an honest two-dimensional decomposable subspace. Together with the file's own `phi 0 1` and `phi 2 3`, which satisfy the hypotheses and fail the right side, both branches of the iff are inhabited by non-degenerate pairs. The theorem is not vacuous in either direction.

## 8. The "what the file does NOT state" clause

The clause names one absence, the Structure Theorem, and gives a reason for it, the missing support subspaces $V_E$ and $V^E$. The reason is correct: the file builds no support subspace of any kind. Two problems remain.

**The parenthetical is false for a plane.** The clause says the Structure Theorem asserts "that such a plane is a pencil or $\Lambda^2$ of a three-space". At subspace dimension two those are the same thing. Let $W\subset\Lambda^2U$ with $\dim U = 3$ and $\dim W = 2$. Every nonzero $\omega\in\Lambda^2U$ is decomposable with a well-defined support plane, and $\omega\mapsto$ the annihilator of that plane is a linear isomorphism $\Lambda^2U\to U^*$. A two-dimensional $W$ maps to a two-dimensional $N\subset U^*$, whose common kernel is a line $\langle f\rangle$, so every element of $W$ has support plane containing $f$, giving $W\subseteq f\wedge U$, and $f\wedge U$ is itself two-dimensional, so $W = f\wedge U$. Conversely a pencil $f\wedge\mathrm{span}\{a,b\}$ lies in $\Lambda^2\mathrm{span}\{f,a,b\}$. The second type is therefore a genuine alternative only from dimension three upward, where $\Lambda^2U$ appears whole. For a plane the theorem says pencil, and the clause presents a dichotomy where there is one alternative.

**The clause omits three absences a reader would assume.** In order of weight:

- **The Plücker dictionary.** The word "decomposable" appears throughout the row and the docstrings and nowhere in the mathematics. What the file states is the vanishing of `wedgeSelf`, and the equivalence "for skew $\omega$, $\omega\wedge\omega=0$ exactly when $\omega$ has rank at most two" is stated in no theorem of the file or of [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), which has [wedgeSelf_areaForm](../lean/HamiltonsCubic/Base/SelfDual.lean#L317) for the easy direction only. Every geometric reading of the file passes through that unstated equivalence.
- **The witness's decomposability**, section 5, and the independence of the witness pair.
- **The support geometry of the criterion**, section 10: that `wedge2 X Y = 0` says the two support planes meet.

## 9. Is the criterion "the $\ell=2$ core"?

The row's phrase overstates in one specific way, and its own disclosure clause partly covers the same ground, which makes the pair of sentences inconsistent rather than dishonest.

The $\ell=2$ case of [Ghorpade–Patil–Pillai](../references/decomposable-subspaces-grassmann-codes/notes.md) Theorem 6, as [findings/diagonal-half.md](../findings/diagonal-half.md) line 1132 records it, classifies subspaces of $\Lambda^2V$ of **every** dimension: pencil $f\wedge U$ of any dimension, or $\Lambda^2U$ at $\dim U = 3$. The file's theorem is the decidability of one dimension of that, dimension two, and in the form of a test rather than a structure. So the criterion is the **dimension-two case's criterion of the $\ell=2$ theorem**, which is the classical pencil condition, and calling it the core of the $\ell=2$ theorem invites the reader to think the classification is present in algebraic form.

Two things soften this. First, the criterion is genuinely equivalent to the dimension-two case of the classification, granted the Plücker dictionary and the support argument of section 10, so it is not a different statement in the sense of being about other objects. Second, the row does disclose that the pencil description is absent. What is left is the phrase, which should say which case and which half.

**And the record's own scope note is the one the row should have echoed.** Line 1134 of [findings/diagonal-half.md](../findings/diagonal-half.md) says the outstanding classification is of the subspaces carrying a decomposable **basis**, and that Theorem 6's two types plus the mixed kind are the known members. The file's contribution to that is precise and worth stating plainly: it types the mixed kind's defining inequality, so a later argument may quantify over it. The row's "which is what the item needed and all it needed" asserts sufficiency for I36b, which is a claim about the record's plan rather than about the file, and this reviewer read the file rather than the plan.

## 10. Does `wedge2 X Y = 0` mean the four support vectors are dependent?

**Yes, for nonzero decomposables, and the file does not reach it.**

Let $X$ and $Y$ be nonzero with `wedgeSelf X = 0` and `wedgeSelf Y = 0`. By section 4 both are skew, and by the Plücker equivalence each has rank exactly two, so $X = \pm\,u\wedge v$ and $Y = \pm\,p\wedge q$ with $\{u,v\}$ and $\{p,q\}$ independent, in the componentwise realisation `areaForm` of [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean#L205). On skew arguments `wedge2` is alternating in its four indices, which the file's own [wedgeSelf_swap01](../lean/HamiltonsCubic/Base/SelfDual.lean#L147), [wedgeSelf_swap12](../lean/HamiltonsCubic/Base/SelfDual.lean#L154) and [wedgeSelf_swap23](../lean/HamiltonsCubic/Base/SelfDual.lean#L161) record for the diagonal case, and the six-term expression `halfw X Y + halfw Y X` is the standard component formula for $X\wedge Y$ as an element of $\Lambda^4$. So

$$(X\wedge Y)_{abcd} = \pm\,(u\wedge v\wedge p\wedge q)_{abcd} = \pm\det\begin{pmatrix}u_a&v_a&p_a&q_a\\ u_b&v_b&p_b&q_b\\ u_c&v_c&p_c&q_c\\ u_d&v_d&p_d&q_d\end{pmatrix},$$

and `wedge2 X Y = 0` says every $4\times4$ minor of the $n\times4$ matrix $[u\ v\ p\ q]$ vanishes, which says $\mathrm{rank}[u\ v\ p\ q]\le 3$, which is exactly the dependence of the four support vectors. Equivalently $\mathrm{span}\{u,v\}\cap\mathrm{span}\{p,q\}\ne 0$, the two support planes meeting in at least a line, which is the pencil condition and closes the loop with section 9.

Screened at `Fin 4` on both sides of the equivalence: `wedge2 (phi 0 1) (phi 0 2) = 0` with the supports meeting in $\langle e_0\rangle$, and the file's own `wedge2 (phi 0 1) (phi 2 3) ≠ 0` with the four supports independent.

**Where the file falls short of this.** Two places. It has no nonzero hypothesis, so the criterion is satisfied vacuously by `X = 0`, where there are no support vectors to be dependent. And it constructs no support plane, no rank, and no basis of a support, so the equivalence above is available to a reader of the record and unavailable to a reader of the Lean. The row is correct that $V_E$ and $V^E$ are the missing machinery, and the missing machinery costs more than the Structure Theorem: it costs the geometric meaning of the criterion the file does prove.

## VERDICT

**The file is sound and the row over-describes it in three places.** All three theorems are proved outright, at every dimension for the first two and at $n=4$ for the third, with no `sorryAx` and no compiler-trusting tactic. The polarisation matches the row exactly. The equivalence is faithful and in fact wider than the row claims, and its apparent omission of skewness is closed by the hypotheses themselves. What is wrong is the witness sentence, which credits a one-sided inequality with being a separation, the phrase "$\ell=2$ core", which credits a dimension-two criterion with being the $\ell=2$ theorem's algebraic heart, and the "does NOT state" clause, which names the smallest of the four absences and misstates the dichotomy it names.

**Replacement text for [lean/INDEX.md](../lean/INDEX.md) line 96, the I36a row's third column:**

> *statement: typed.* **PROVED OUTRIGHT AT EVERY DIMENSION, THE BUILD CARRYING NO GAP.** *`wedgeSelf_smul_add` is the polarisation, $\mathrm{wedgeSelf}(aX+bY)=a^2\mathrm{wedgeSelf}X+2ab\,\mathrm{wedge2}\,XY+b^2\mathrm{wedgeSelf}Y$, its constant fixed by $\mathrm{wedgeSelf}X=\mathrm{wedge2}\,XX$; `plane_decomposable_iff_wedge2_zero` is the dimension-two criterion of [Ghorpade–Patil–Pillai](../references/decomposable-subspaces-grassmann-codes/notes.md)'s Structure Theorem at $\ell=2$, that the span of two forms of vanishing self-wedge has vanishing self-wedge throughout exactly when the cross term vanishes, stated for every pair and so also where the two are dependent; `wedge2_phi_ne_zero` is the cross term at $n=4$ that [I36b](../plan.md) needs nonzero.* **Skewness is a hypothesis rather than an omission**: $\mathrm{wedgeSelf}\,M=0$ forces $M^{\mathsf T}=-M$, so the theorem is about pairs of 2-forms of rank at most two ([r853](../reviews/REVIEW_r853.md)). **What the file does NOT state**, four things: the Plücker dictionary $\omega\wedge\omega=0\Leftrightarrow\mathrm{rank}\,\omega\le2$, through which every reading of it as being about DECOMPOSABILITY passes; $\mathrm{wedgeSelf}(\varphi_{ij})=0$, so the witness gives the failing half of the separation and not the holding half; the independence of $\varphi_{01}$ and $\varphi_{23}$, so no plane is typed; and the support geometry, that $\mathrm{wedge2}\,XY=0$ says the two support planes meet, which needs the $V_E$ and $V^E$ the layer does not build. *At dimension two the Structure Theorem's two types coincide, a plane inside $\Lambda^2U$ at $\dim U=3$ being a pencil, so for a plane the theorem gives the single alternative PENCIL and that description is what is missing.* Kernel-checked, no compiler-trusting tactic.
