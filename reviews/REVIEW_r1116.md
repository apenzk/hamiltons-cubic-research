# Reviewer r1116: the first Fox trace identity, tr L_x = 0, against its Lean proof

*Gate 2 review, one reviewer, of the block of [second-order.md](../findings/second-order.md) displaying $\mathop{\mathrm{tr}}(L_x)=0$ for every $x\in\mathrm{Weyl}_n$ and the paragraph "The first identity is machine-checked", against `trace_leftMulS_eq_zero'` in [WeylTraceZero.lean](../lean/HamiltonsCubic/Results/WeylTraceZero.lean), its chain ([WeylTraceStrict.lean](../lean/HamiltonsCubic/Results/WeylTraceStrict.lean), [WeylEquivariance.lean](../lean/HamiltonsCubic/Results/WeylEquivariance.lean), [WeylAction.lean](../lean/HamiltonsCubic/Results/WeylAction.lean), [WeylFoxEquivariance.lean](../lean/HamiltonsCubic/Results/WeylFoxEquivariance.lean), [WeylTraceInvariance.lean](../lean/HamiltonsCubic/Results/WeylTraceInvariance.lean), [WeylInvariantZero.lean](../lean/HamiltonsCubic/Results/WeylInvariantZero.lean)), and the I82b row of [lean/INDEX.md](../lean/INDEX.md), at commit b3f61f7f. Source statement: Fox's Theorem 1.3 in [notes.md](../references/fox-2019-nonassociative-curvature-algebra/notes.md) and the text dump beside it. Analysis first. Two Lean checks of seconds on constructed objects, compiled against the built layer, reported below with their code. Log: [r1116-trace-zero.log](../agent_logs/r1116-trace-zero.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | `weylModuleS` is the record's $\mathcal W_n$ | CONFIRMED by hand. Restriction to skew matrices is a linear isomorphism onto the Ricci-flat algebraic curvature tensors on $\Lambda^2$, nothing lost or added. Untyped, as the row says |
| 2 | `foxProd` is the record's $x\circ y$ | CONFIRMED. Definitional on the record's side. The trace-zero conclusion is also insensitive to the normalisation of $\#$ and to Fox's overall scalar |
| 3 | `trace_leftMulS_eq_zero'` states $\mathop{\mathrm{tr}}L_x=0$ on all of $\mathcal W_n$ | CONFIRMED. No excluding hypothesis, and `LinearMap.trace` over `weylModuleS` is the record's trace by conjugation invariance |
| 4 | Non-vacuity of `weylModuleS` | CONFIRMED, now typed in a scratch check: `weylModuleS (Fin 4) ≠ ⊥` on the standard three axioms |
| 5 | Axioms | CONFIRMED: `[propext, Classical.choice, Quot.sound]` |
| 6 | I82b row and the findings paragraph | PLAUSIBLE, corrected. The proof description is accurate, including the finite-group claim. **The one `sorry` both texts name, `trace_leftMulS_comp`, is FALSE as quantified**, typed below. The row also carries a stale "route under way" sentence |

**The Lean proves Fox's first identity on the record's $\mathcal W_n$.** `trace_leftMulS_eq_zero'` compiles on the standard three axioms, quantifies over every member of `weylModuleS` at every finite index type, and `weylModuleS` is the record's space under restriction to $\Lambda^2$. The corrections are to the surrounding text, and the sharp one is the neighbouring `sorry`, whose universally quantified `kappa` makes it a false statement.

## 1. weylModuleS against the record's $\mathcal W_n$

- **Definitions.** `weylModuleS ι` is `weylModule ι ⊓ {R | KillsSym R}` with `KillsSym R := ∀ Z, Zᵀ = Z → R Z = 0`. `weylModule ι` is the linear maps $R$ on all $n\times n$ matrices satisfying `IsWeyl`: $R$ maps skew to skew, $R$ is self-adjoint for `inner2` on skew arguments, `bianchi R i j k l = 0`, and `Ric R a b = 0`.
- **Every clause of `IsWeyl` reads $R$ only on skew arguments.** The first two quantify over skew $X,Y$, and `bianchi` and `Ric` evaluate $R$ only at `phi i j`. This is the radical [WeylRadical.lean](../lean/HamiltonsCubic/Results/WeylRadical.lean) documents: `weylModule` carries every map killing $\Lambda^2$, a whole $\mathrm{Hom}(\mathrm{Sym},M)$.
- **Restriction $\rho:R\mapsto R|_{\Lambda^2}$ is injective on `weylModuleS`.** Every matrix splits as $Z=\tfrac12(Z-Z^{\mathsf T})+\tfrac12(Z+Z^{\mathsf T})$, and `KillsSym` kills the second part, so $R$ is fixed by its restriction. The last step of `invariant_zero` runs exactly this argument.
- **$\rho$ is surjective onto the operators on $\Lambda^2$ satisfying the four clauses.** Given such a $T$, the map $Z\mapsto T(\tfrac12(Z-Z^{\mathsf T}))$ is linear, kills symmetric matrices and restricts to $T$. Since `IsWeyl` reads only skew arguments, it satisfies all four clauses. The scratch lemma `comp_skewProj_mem` in section 4 types this direction for every member of `weylModule`.
- **The four clauses on $\Lambda^2$ are the algebraic Weyl tensors.** Put $R_{ijkl}=$ `inner2 (R (phi i j)) (phi k l)`. Antisymmetry in $ij$ and in $kl$ is `phi_swap`. On $\Lambda^2$, `inner2` is $\tfrac12$Frobenius, positive definite, with $\{\varphi_{ij}\}_{i<j}$ orthonormal, so self-adjointness is pair symmetry $R_{ijkl}=R_{klij}$. `bianchi` is $R_{ijkl}+R_{iklj}+R_{iljk}=0$, which under the two antisymmetries and pair symmetry is the first Bianchi identity. `Ric` is $\sum_cR_{acbc}$, and its vanishing on algebraic curvature tensors cuts out the Weyl tensors exactly (scalar flatness follows).
- **So nothing is lost and nothing is added.** $\rho$ is a linear isomorphism of `weylModuleS` onto $\mathcal W_n$. At $n\le3$ both sides are $0$. The isomorphism is not typed, which the I82b row already records under "Not typed".

## 2. foxProd against the record's Fox product

- **The record**, [conventions.md](../findings/conventions.md): "$X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$", and $Q(W)=W^2+W^\#$ in the same table.
- **The layer**, [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean): `foxProd X Y := fun Z => (1 / 2 : ℝ) • (Qop (X + Y) Z - Qop X Z - Qop Y Z)`, with `Qop R := fun X => compOp R X + sharpOp R X` and `compOp R X := R (R X)` in [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean). So the product is the record's definition verbatim, and `L` in the theorem is $Y\mapsto e\circ Y$, the record's $L_x$.
- **`sharpOp` is the record's $\#$.** `sharpQF R η = -¼ Σ_{i,j} inner2 [η, R[η, R φ_ij]] φ_ij` over ordered pairs is $-\tfrac12\mathop{\mathrm{tr}}_{\Lambda^2}(\mathrm{ad}_\eta R\,\mathrm{ad}_\eta R)$, which is the Böhm–Wilking quadratic form up to one scalar. At $R=\mathrm{id}$ it gives $-\tfrac12\mathop{\mathrm{tr}}\mathrm{ad}_\eta^2=(n-2)\lVert\eta\rVert^2$ (Killing form $(n-2)\mathop{\mathrm{tr}}XY=-2(n-2)\langle X,Y\rangle$), which pins the scalar to the record's anchor $\mathrm{id}^\#=(n-2)\mathrm{id}$, typed as `sharpOp_id` ([r905](REVIEW_r905.md), [r906](REVIEW_r906.md)). `sharpBil` polarises it and `sharpOp` reassembles the vector by `skew_expand`.
- **The restriction commutes with the product.** At skew $Z$, `compOp` evaluates $R$ at the skew $RZ$, and `sharpQF` at skew $\eta$ evaluates $R$ only at $\varphi_{ij}$ and at brackets of skew matrices. So $\rho(e\circ Y)=\rho e\circ\rho Y$, and $\rho$ intertwines the Lean $L$ with the record's $L_{\rho e}$.
- **Fox's side.** Fox defines $X*Y$ by Hamilton's formula (his (5.14)), which the record identifies with $\circ$ up to normalisation ([notes.md](../references/fox-2019-nonassociative-curvature-algebra/notes.md), "Careful with normalisations"). Trace zero is unchanged by a nonzero rescaling of the product, so this identification needs no constant.
- **Robustness, worth recording.** The Lean argument uses only that the product is bilinear and $O(n)$-equivariant (`foxProd_act`). The Jordan half and the $\#$ half are each equivariant, so the conclusion would survive even a wrong constant in front of $\#$. It is about the record's product because of the anchor above, and its truth does not rest on that anchor.

## 3. The statement

`#check` output, verbatim:

```
@trace_leftMulS_eq_zero' : ∀ {ι : Type u_1} [inst : Fintype ι] [inst_1 : DecidableEq ι],
  ∀ e ∈ weylModuleS ι,
    ∀ (L : ↥(weylModuleS ι) →ₗ[ℝ] ↥(weylModuleS ι)),
      (∀ (Y : ↥(weylModuleS ι)) (Z : Matrix ι ι ℝ), ↑(L Y) Z = ((fun A => e A) ∘w fun A => ↑Y A) Z) →
        (LinearMap.trace ℝ ↥(weylModuleS ι)) L = 0
```

- **The hypotheses exclude nothing.** $e$ ranges over all of `weylModuleS ι` at every finite `ι`. `hL` characterises $L$ as $Y\mapsto e\circ Y$, and such an $L$ exists for every $e$ (`leftMulS_exists`, unconditional, closure from the proved `foxClosed`) and is unique (`leftMulS_unique`). So the binder is a definition of $L_e$, never an extra condition. Fox states $\dim V\ge4$, and the Lean covers every $n$, trivially below $4$.
- **The trace is the record's.** `LinearMap.trace` over the finite-dimensional real space `weylModuleS ι` is basis-free. By section 1, $\rho$ is an isomorphism with $\rho L\rho^{-1}=L^{\mathrm{rec}}_{\rho e}$, and trace is conjugation invariant, so it equals $\mathop{\mathrm{tr}}$ of the record's $L_x$ on $\mathcal W_n$. No inner product enters.
- **The proof, checked by hand.** `trE` is additive (`trE_add`, from left additivity of `foxProd`) and invariant under every orthogonal $g$ (`trace_leftMulS_act`, via `actE` as a linear automorphism and `trace_conj'`). The sum of $D_SP_\sigma\cdot e$ over all $2^n\,n!$ signed permutation matrices is fixed by each single flip (reindex $S\mapsto S\triangle\{m\}$) and each permutation (reindex by $\tau$), hence zero by `invariant_zero`. So $0=2^n\,n!\mathop{\mathrm{tr}}L_e$.
- **`invariant_zero`, checked by hand.** A single flip at $m$ multiplies $R_{ijkl}$ by $s_is_js_ks_l$, so a coordinate with an index appearing once dies (`coord_single`). With the antisymmetries, only $R_{abab}$ and $R_{abba}=-R_{abab}$ survive (`coord_reduce`). The transposition $(b\,c)$ fixing $a$ gives $c_{ab}=c_{ac}$, and $\mathrm{Ric}(a,a)=\sum_cc_{ac}=(n-1)c_{ab}=0$ with $n\ge2$ where $a\ne b$ exists. It uses neither Bianchi nor pair symmetry, only the Ricci clause, skewness of values and `KillsSym`.

## 4. Non-vacuity

- **The file does not exhibit a nonzero member**, as the row says. The layer's existing witness, `sphereWeight_diagOpL_ne_zero`, lives in `weylModule` and is not in `weylModuleS`: `diagOp w` is the Hadamard product $X\mapsto w\circ X$, which sends a symmetric $Z$ to the symmetric $w\circ Z$, nonzero in general.
- **Precomposing with the skew projection repairs it.** For any $R\in$ `weylModule`, $R\circ\pi$ with $\pi(Z)=\tfrac12(Z-Z^{\mathsf T})$ lies in `weylModuleS` and agrees with $R$ on $\Lambda^2$. At $S=\{0,1\}\subset$ `Fin 4` the sphere weight has cross entry $-1$, so $R\circ\pi$ moves $\varphi_{02}$ to $-\varphi_{02}$.
- **Typed**, compiled against the built layer, `#print axioms` giving `[propext, Classical.choice, Quot.sound]`:

```lean
noncomputable def skewProj (ι : Type*) [Fintype ι] [DecidableEq ι] : CurvLin ι where
  toFun Z := (1/2 : ℝ) • (Z - Zᵀ)
  map_add' X Y := by
    ext p q; simp [Matrix.add_apply, Matrix.sub_apply, Matrix.transpose_apply]; ring
  map_smul' c X := by
    ext p q; simp [Matrix.smul_apply, Matrix.sub_apply, Matrix.transpose_apply]; ring

theorem skewProj_skew (X : Matrix ι ι ℝ) (hX : IsSkew X) : skewProj ι X = X := by
  show (1/2 : ℝ) • (X - Xᵀ) = X
  unfold IsSkew at hX
  rw [hX]; ext p q; simp; ring

theorem skewProj_sym (Z : Matrix ι ι ℝ) (hZ : Zᵀ = Z) : skewProj ι Z = 0 := by
  show (1/2 : ℝ) • (Z - Zᵀ) = 0
  rw [hZ]; simp

theorem comp_skewProj_mem (R : CurvLin ι) (hR : R ∈ weylModule ι) :
    R ∘ₗ skewProj ι ∈ weylModuleS ι := by
  obtain ⟨h1, h2, h3, h4⟩ := hR
  have hs : ∀ X, IsSkew X → (R ∘ₗ skewProj ι) X = R X := fun X hX => by
    rw [LinearMap.comp_apply, skewProj_skew X hX]
  have hphi : ∀ i j, (R ∘ₗ skewProj ι) (phi i j) = R (phi i j) :=
    fun i j => hs _ (phi_isSkew i j)
  refine ⟨⟨fun X hX => ?_, fun X Y hX hY => ?_, fun i j k l => ?_, fun a b => ?_⟩,
    fun Z hZ => ?_⟩
  · show IsSkew ((R ∘ₗ skewProj ι) X); rw [hs X hX]; exact h1 X hX
  · show inner2 ((R ∘ₗ skewProj ι) X) Y = inner2 X ((R ∘ₗ skewProj ι) Y)
    rw [hs X hX, hs Y hY]; exact h2 X Y hX hY
  · have := h3 i j k l
    simp only [bianchi] at this ⊢
    rw [hphi, hphi, hphi]; exact this
  · have := h4 a b
    simp only [Ric] at this ⊢
    simp only [hphi]; exact this
  · show R (skewProj ι Z) = 0
    rw [skewProj_sym Z hZ, map_zero]

theorem weylModuleS_fin4_ne_bot : weylModuleS (Fin 4) ≠ ⊥ := by
  intro h
  let S : Finset (Fin 4) := {0, 1}
  have hmem := comp_skewProj_mem (diagOpL (sphereWeight S))
    (diagOpL_mem (sphereWeight_isWeight S (by decide) (by decide)))
  rw [h, Submodule.mem_bot] at hmem
  have hne := sphereWeight_diagOpL_ne_zero S (by decide) (by decide) (a := 0) (b := 2)
    (by decide) (by decide)
  apply hne
  have := congrArg (fun R : CurvLin (Fin 4) => R (phi 0 2)) hmem
  simp only [LinearMap.zero_apply] at this
  rw [LinearMap.comp_apply, skewProj_skew _ (phi_isSkew 0 2)] at this
  exact this
```

*The file opens `HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.WeylRadical HamiltonsCubic.FamilyLayer Matrix` and imports WeylTraceZero and WeylRadical. It sits in the session scratchpad, uncommitted. `comp_skewProj_mem` is the typed half of the section 1 isomorphism, and landing it with the witness would retire the row's "Not typed: a nonzero member" clause.*

## 5. Axioms

`#print axioms HamiltonsCubic.Results.trace_leftMulS_eq_zero'` returns `[propext, Classical.choice, Quot.sound]`, run from source against the built layer. No `sorryAx`, so `foxClosed`, `leftMulS_exists` and the whole equivariance chain are proved, and the neighbouring `sorry` in `trace_leftMulS_comp` is not on its path.

## 6. The I82b row and the findings paragraph

**Accurate.**

- The findings paragraph describes the proof correctly: equivariance of the product and the trace under every orthogonal $g$, averaging over the finite signed-permutation group, and the three-step vanishing (flips leave $c_{ab}=R_{abab}$, transpositions make it independent of $b$, Ricci gives $(n-1)c_{ab}=0$).
- **"Only the finite group is used" holds.** `trace_leftMulS_act` is proved for every orthogonal $g$ and applied only at the $2^n\,n!$ matrices `signSet S * permMat σ`. No irreducibility, Haar measure, Lie algebra or continuity enters. The paragraph words this correctly: equivariance is stated for every $g$, and the averaging for the finite group.
- "19/19 clean" matches the 19 theorems in [WeylTraceZero.lean](../lean/HamiltonsCubic/Results/WeylTraceZero.lean). "Not typed: that `weylModuleS` restricts isomorphically onto the record's $\mathcal W_n$" is true and is confirmed by hand in section 1.

**Corrections.**

1. **`trace_leftMulS_comp` is false as stated, and both texts name it as the remaining `sorry`.** Its signature begins `(kappa : ℝ) (e f : CurvLin ι) ...`, so it asserts $\mathop{\mathrm{tr}}(L_eL_f)=\kappa\langle e,f\rangle$ for EVERY $\kappa$. Its docstring means "ONE constant for every pair", which is $\exists\kappa\,\forall e,f$. At any $e=f\ne0$ in `weylModuleS` the right side takes two values at $\kappa=0,1$ while the left takes one. Typed at `Fin 4`, on the standard three axioms, with the witness of section 4 and `inner2`'s definiteness:

   ```lean
   theorem comp_statement_false : ¬ (∀ (kappa : ℝ) (e f : CurvLin (Fin 4)),
       e ∈ weylModuleS (Fin 4) → f ∈ weylModuleS (Fin 4) →
       ∀ (Le Lf : weylModuleS (Fin 4) →ₗ[ℝ] weylModuleS (Fin 4)),
         (∀ (Y : weylModuleS (Fin 4)) (Z : Matrix (Fin 4) (Fin 4) ℝ),
           (Le Y : CurvLin (Fin 4)) Z = foxProd (fun A => e A) (fun A => (Y : CurvLin (Fin 4)) A) Z) →
         (∀ (Y : weylModuleS (Fin 4)) (Z : Matrix (Fin 4) (Fin 4) ℝ),
           (Lf Y : CurvLin (Fin 4)) Z = foxProd (fun A => f A) (fun A => (Y : CurvLin (Fin 4)) A) Z) →
         LinearMap.trace ℝ (weylModuleS (Fin 4)) (Le ∘ₗ Lf)
           = kappa * innerOp (fun A => e A) (fun A => f A))
   ```

   The proof applies the hypothesis at $\kappa=0$ and $\kappa=1$ with $e=f$ the witness, gets `innerOp w w = 0`, and reads off $w\,\varphi_{02}=0$ from a sum of non-negative `inner2` squares, contradicting `sphereWeight_diagOpL_ne_zero`. Nothing in `lean/` consumes `trace_leftMulS_comp` today, so no proved result is contaminated, but a false `sorry` is a proof of `False` waiting for its first caller. **Fix**: state it as `∃ kappa : ℝ, ∀ e f ...`, or with the record's constant $\kappa=\tfrac{(2n-1)(n-1)}4$ at `Fintype.card ι = n` in the layer's `innerOp` normalisation, and name the change in the row and in the findings sentence "stays `sorry` as `trace_leftMulS_comp`". [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean) carries no copy, the statements having been retired from it. [plan-lean.md](../plan-lean.md)'s sorry table quotes the docstring's reading and should follow the fix.
2. **The row's middle sentence is stale.** "**The route to `trace_leftMulS_eq_zero` is under way** ... proved so far" describes the route as incomplete and names the unprimed theorem, which the landing commit retired. It should read that the route is complete and ends in `trace_leftMulS_eq_zero'`.
3. **The non-vacuity clause can be retired** by landing `comp_skewProj_mem` and `weylModuleS_fin4_ne_bot` from section 4, which also types one direction of the isomorphism the row lists as untyped.
