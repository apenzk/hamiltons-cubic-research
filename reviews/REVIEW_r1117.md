# Reviewer r1117: L105 typed, Isserlis and Ky Fan stated, and the r1116 fold, against their sources

*Gate 2 review, one reviewer, of four Lean commits against the statements they claim: 45bfd5ab ([L105Closing.lean](../lean/HamiltonsCubic/Results/L105Closing.lean) against Lemma L105 in [bounds-relaxations.md](../findings/bounds-relaxations.md)), 4fb54f22 ([GaussianMoment.lean](../lean/HamiltonsCubic/Results/GaussianMoment.lean) against Lemma L238 in [second-order.md](../findings/second-order.md)), 6a21c9ae ([KyFanPrinciple.lean](../lean/HamiltonsCubic/Results/KyFanPrinciple.lean) against Lemma L237 there), and 42bbe565 (the fold of [r1116](REVIEW_r1116.md): [WeylModuleSNonzero.lean](../lean/HamiltonsCubic/Results/WeylModuleSNonzero.lean) and the restated `trace_leftMulS_comp` in [WeylTraceStrict.lean](../lean/HamiltonsCubic/Results/WeylTraceStrict.lean)). Analysis first. One Lean scratch check of seconds against the built layer (the four modules replayed clean, so the oleans match HEAD), and one numeric screen of seconds on constructed matrices, both reported with what they can and cannot show. Log: [r1117-four-commits.log](../agent_logs/r1117-four-commits.log).*

| # | Commit | Claim | Verdict |
|---|---|---|---|
| 1 | 45bfd5ab | L105's two branches and closing inequality, typed | **CONFIRMED**, with one INDEX correction: the L105 row's first-column link points at [route-a.md](../findings/route-a.md), which holds no L105. The lemma is in [bounds-relaxations.md](../findings/bounds-relaxations.md) |
| 2 | 4fb54f22 | `integral_quadForm_mul_quadForm` is Isserlis' fourth moment as L238 uses it | **CONFIRMED** |
| 3 | 6a21c9ae | `kyFan_sum_le` is a true dual form of Ky Fan and suffices for L237 | **CONFIRMED** |
| 4 | 42bbe565 | the restated `trace_leftMulS_comp` is Fox's second identity, and `weylModuleS_fin4_nonzero` says what its name says | **CONFIRMED** |
| 5 | all | axioms | **CONFIRMED**: proved declarations on `[propext, Classical.choice, Quot.sound]`, stated ones add `sorryAx` and nothing else |

**All four commits state what their sources say.** The one correction is a pre-existing link in the L105 row of [lean/INDEX.md](../lean/INDEX.md) that the commit edited around and left standing.

## 1. 45bfd5ab, L105 typed

**The row hypotheses match the record's two displayed identities term for term.**

- **Class-1 row.** The record: $-(r-1)(N-r)(u+w)^2t_{112}=2u\theta-2(n-1)uw$. `L105_pi_bound`'s `hrow`: `-(r - 1) * (N - r) * (u + w) ^ 2 * t112 = 2 * u * θ - 2 * (n - 1) * u * w`. Lean parses the left side as $(-(r-1))\cdot(N-r)\cdots$, which is the same number. Signs and coefficients agree.
- **Class-2 row.** The record: $(N-r-1)(N-r-2)(u+w)^2t_{222}=2(n-2)u^2-4uw-2w^2-2w\theta$. `L105_tangent_bound`'s `hrow` is the same expression, term for term.
- **The branch conclusions follow by hand.** With $t_{112}\ge0$ and $1\le r\le N$ the left side of row 1 is $\le0$, so $u(\theta-(n-1)w)\le0$ and $u>0$ gives $\theta\le(n-1)w$. With $t_{222}\ge0$ and the coefficient nonnegative, row 2 gives $2w\theta\le2Q$, $Q=(n-2)u^2-2uw-w^2$, which is the record's $\theta\le Q/w$ multiplied through by $w>0$.
- **The side hypotheses are automatic for the lemma's objects.** `hcoef`, $(N-r-1)(N-r-2)\ge0$, is a product of two consecutive integers when $N-r$ is a positive integer, and vanishes at $N-r\in\{1,2\}$, the degenerate multiplicities the record says force equality in one branch. `hr`, `hNr` are $1\le r\le N$.

**$uwN=1$ is a correct consequence of tracelessness and unit norm, and $N$ is the record's.**

- $ru^2+(N-r)w^2=(ru)u+((N-r)w)w=(N-r)wu+ruw=Nuw$, using $ru=(N-r)w$ once in each term. So unit norm reads $Nuw=1$.
- `huw` writes $N=n(n-1)/2=\binom n2$, the record's $N$ (fixed in L104's statement). Cross-check at the crossing point: $r=n(n-2)/4$ and $N-r=n^2/4$ sum to $n(n-1)/2$.

**`L105_closing` states $\theta\le\theta_0(n)$ with the record's constant**, `Real.sqrt (2 * (n - 1) * (n - 2)) / n` $=\sqrt{2(n-1)(n-2)}/n$. Checked by hand:

- Target in squared form: $\theta^2n^2\le2(n-1)(n-2)=(n-1)^2(n-2)\,n\,uw$ by $uw\,n(n-1)=2$, so it suffices that $\theta^2n\le(n-1)^2(n-2)uw$ when $\theta>0$ (the case $\theta\le0$ is immediate).
- **Branch $nw\le(n-2)u$.** $\theta^2\le(n-1)^2w^2$ and $nw^2\le(n-2)uw$.
- **Branch $nw>(n-2)u$.** $0<\theta w\le Q$, and `L105_identity` (by `ring`) writes $(n-1)^2(n-2)uw^3-nQ^2$ as $(n-1)w^2\cdot[-((n-2)u-nw)(nu+w)]+nQ\,((n-1)w^2-Q)$. The first bracket is $\ge0$ on this branch. The second needs $0\le Q\le(n-1)w^2$, and $(n-1)w^2-Q=(nw-(n-2)u)(u+w)>0$ here. So $nQ^2\le(n-1)^2(n-2)uw^3$ and $\theta^2w^2n\le nQ^2$ closes it.
- **It covers the record's middle inequality, not only $\theta\le\theta_0$.** Put $\theta:=\min\{(n-1)w,Q/w\}$: both `h1` and `h2` hold, so $\min\{\cdots\}\le\theta_0(n)$ follows. The Lean uses only $uwN=1$, not the record's parametrisation of $u,w$ by $r$, so it replaces the monotonicity-in-$r$ argument by a statement over a larger set, as the commit says.
- **Non-vacuous and sharp.** At $n=4$, $r=2$, $N=6$, $u=2w$, $w=1/\sqrt{12}$ (the balanced point) every hypothesis holds with $\theta=(n-1)w=\sqrt3/2=\theta_0(4)$ and $\theta w=Q=3w^2$, so both branch hypotheses and the conclusion are equalities. The $uwN=1$ clause at this point compiled as a scratch `example` in the layer.

**Nothing is assumed that the lemma lacks.** $n\ge3$ real is weaker than the lemma's integer dimension (the content starts at $n=4$), $u,w>0$ are the lemma's, and the proof uses $n\ge3$ only through $n>0$ and $n-1\ge0$. The row identities and $uwN=1$ enter as hypotheses, which the file and the row both say.

**The INDEX row is accurate in what it adds, with one stale link it kept.**

- The added text (the three names, the identity, "every real $n\ge3$", standard three axioms, and the owed list: the row identities from L104, $uwN=1$, $T_{abc}=c_{abc}^2$, the equality case, $r\le8$) matches the file and the axioms below.
- **Correction.** The row's first column reads `[L105](../findings/route-a.md)`, and [route-a.md](../findings/route-a.md) carries L100 to L103 and no L105. The lemma is `#### Lemma L105` at line 378 of [bounds-relaxations.md](../findings/bounds-relaxations.md), which the row's own owed list cites correctly for L104. The L104 row above it has the same stale link, and [L105.lean](../lean/HamiltonsCubic/Results/L105.lean)'s docstring says "route-a.md's Lemma L105". Pre-existing, and a one-token fix in each place.

## 2. 4fb54f22, Isserlis' fourth moment

**`integral_quadForm_mul_quadForm` is true as stated, with the right normalisation.**

- Under `Measure.pi fun _ => gaussianReal 0 1` the coordinates are independent with mean $0$ and variance $1$ (Mathlib's second argument is the variance), so $\mathbb E[v_iv_jv_kv_l]=\delta_{ij}\delta_{kl}+\delta_{ik}\delta_{jl}+\delta_{il}\delta_{jk}$. Contracting against $A_{ij}B_{kl}$ gives $\mathop{\mathrm{tr}}A\mathop{\mathrm{tr}}B+\mathop{\mathrm{tr}}(AB^{\mathsf T})+\mathop{\mathrm{tr}}(AB)$, which is $\mathop{\mathrm{tr}}A\mathop{\mathrm{tr}}B+2\mathop{\mathrm{tr}}(AB)$ for symmetric $B$.
- The integrand is a polynomial, integrable under the Gaussian product, so Lean's integral is the true expectation and not the junk value $0$. At $d=0$ both sides are $0$.
- **The symmetry hypotheses are load-bearing**, so the statement is not a weaker true form: at skew $A=B\ne0$ the left side is $0$ and the right side is $2\mathop{\mathrm{tr}}A^2<0$.
- Screen, seconds, constructed matrices: the Wick contraction against the formula at 200 random symmetric pairs, $d\le5$, agrees to $3\times10^{-14}$, and one Monte Carlo instance ($2\times10^6$ draws) gives $9.033$ against $9$. This confirms the arithmetic of the normalisation only.

**It is what L238 uses.** L238's proof applies it three times, and each matches the typed form: $\mathbb E[G_{ii}G_{jj}]=4+2\mathop{\mathrm{tr}}Q_iQ_j$ ($A=Q_i$, $B=Q_j$, $\mathop{\mathrm{tr}}Q_i=2$), $\mathbb E G_{ij}^2=\tfrac12\lVert S_{ij}\rVert_F^2$ ($A=B=-\tfrac12S_{ij}$, $\mathop{\mathrm{tr}}S_{ij}=0$), and $\mathbb E(v^{\mathsf T}Pv)^2=196+2\mathop{\mathrm{tr}}P^2$. The Gaussian on $\mathop{\mathrm{ran}}P\cong\mathbb R^d$ is the typed one after an orthonormal change of basis, which the file leaves untyped and the L238 row names.

## 3. 6a21c9ae, Ky Fan in dual form

**`kyFan_sum_le` is true as stated, for every real $c$.**

- Proof checked by hand, the docstring's route: with $u_k$ an orthonormal eigenbasis, $\sum_j\langle x_j,Mx_j\rangle=\sum_k\lambda_kw_k$, $w_k=\sum_j\langle u_k,x_j\rangle^2\in[0,1]$ by Bessel for the orthonormal $x_j$, $\sum_kw_k=r$ by Parseval in $\mathbb R^d$. Then $\lambda_kw_k=cw_k+(\lambda_k-c)w_k\le cw_k+\max(\lambda_k-c,0)$ because $0\le w_k\le1$, and summing gives the right side. No sign condition on $c$ enters.
- Orthonormality in the `dotProduct` sense is the real Euclidean one. `hM.eigenvalues : Fin d → ℝ` is Mathlib's eigenvalue list with multiplicity in no guaranteed order, and the right side is a symmetric function of it, which is why the dual form is the right one to state. At $r>d$ the hypothesis is unsatisfiable and the statement holds vacuously, matching the principle's range.
- **The dual form is exact, not lossy.** At $c=\lambda_{(r)}$, the $r$-th largest, $rc+\sum_k(\lambda_k-c)^+$ is the sum of the $r$ largest eigenvalues, so the infimum over $c$ is Ky Fan's bound itself.

**A false variant would be caught.** At $M=I_d$, $r=d$ the statement is an equality for every $c\le1$, so dropping the $rc$ term, flipping the sign inside the max, or summing $\max(c-\lambda_k,0)$ each fail there (for instance $d\le0$ at $c=0$ for the flipped sign). Screen, seconds: 2000 random symmetric $M$, $d\le7$, random orthonormal $x$, $c$ at random and at every eigenvalue: $\max(\text{lhs}-\text{rhs})=1.7\times10^{-14}$, and the $c=\lambda_{(r)}$ reduction to the top-$r$ sum agrees to $1.2\times10^{-14}$. A screen of the stated form, never a proof of it.

**It implies what L237 uses.** L237 needs $\sum_j\lVert[X_0,X_j]\rVert^2\le$ the sum of the $r$ largest eigenvalues of $-\mathrm{ad}_{X_0}^2$ for orthonormal $X_j$. In an orthonormal basis of $\mathfrak{so}(n)$ under $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}XY$, $\mathrm{ad}_{X_0}$ is skew, so $M=-\mathrm{ad}_{X_0}^2$ is a symmetric matrix, $\lVert[X_0,X_j]\rVert^2=\langle X_j,MX_j\rangle$, and the $X_j$ become `dotProduct`-orthonormal coordinate vectors. The coordinate transfer is untyped, as the L237 row's "What the files leave out" says.

## 4. 42bbe565, the r1116 fold

**The restated `trace_leftMulS_comp` is Fox's second identity, true, and neither vacuous nor trivially true.** `#check` output:

```
@trace_leftMulS_comp : ∀ {ι : Type u_1} [inst : Fintype ι] [inst_1 : DecidableEq ι],
  ∃ kappa,
    ∀ (e f : CurvLin ι), e ∈ weylModuleS ι → f ∈ weylModuleS ι →
      ∀ (Le Lf : ↥(weylModuleS ι) →ₗ[ℝ] ↥(weylModuleS ι)),
        (∀ Y Z, ↑(Le Y) Z = foxProd (fun A => e A) (fun A => ↑Y A) Z) →
        (∀ Y Z, ↑(Lf Y) Z = foxProd (fun A => f A) (fun A => ↑Y A) Z) →
          (LinearMap.trace ℝ ↥(weylModuleS ι)) (Le ∘ₗ Lf) = kappa * innerOp (fun A => e A) fun A => f A
```

(namespaces shortened, the binders on `Y`, `Z` as in the file.)

- **Quantifier order is right.** `ι` is bound outside, then one $\kappa$, then every pair. So $\kappa$ may depend on $n$ and on nothing else, which is Fox's "$\mathop{\mathrm{tr}}(L_xL_y)=\kappa\langle x,y\rangle$" with the constant left open (his Remark 1.4). The retired form, $\kappa$ a parameter, is refuted in the layer as `old_comp_statement_false`, whose negated body is the old signature specialised at `Fin 4`, binder for binder.
- **`innerOp` is an $O(n)$-invariant inner product on `weylModuleS`.** It is $\tfrac12\sum_{i,j}$`inner2`$(e\varphi_{ij},f\varphi_{ij})$, the Hilbert–Schmidt pairing of the restrictions to $\Lambda^2$, and a member of `weylModuleS` is fixed by its restriction ([r1116](REVIEW_r1116.md) section 1), so it is positive definite there.
- **True, by Schur, checked by hand.** $(e,f)\mapsto\mathop{\mathrm{tr}}(L_eL_f)$ is symmetric ($\mathop{\mathrm{tr}}(AB)=\mathop{\mathrm{tr}}(BA)$) and $O(n)$-invariant (`foxProd_act` gives $L_{g\cdot e}=gL_eg^{-1}$, and trace is conjugation invariant). Against the invariant inner product it defines a self-adjoint intertwiner, whose real eigenspaces are $O(n)$-submodules. $\mathcal W_n$ is $O(n)$-irreducible at $n\ge4$ (at $n=4$ the two $SO(4)$ halves are exchanged by a reflection), so the intertwiner is a scalar. At $n\le3$, $\mathcal W_n=0$ and any $\kappa$ serves. The irreducibility is the untyped input, which is why the `sorry` stands.
- **Not vacuous.** `leftMulS_exists` supplies $L_e$ for every member, and `weylModuleS_fin4_nonzero` supplies a nonzero member at $n=4$.
- **Not trivially true.** $\kappa=0$ fails: the product is metrised ($\langle x\circ y,z\rangle$ is the polarised cubic $\langle Q(W),W\rangle$, totally symmetric), so $L_e$ is self-adjoint and $\mathop{\mathrm{tr}}L_e^2=\lVert L_e\rVert_{HS}^2>0$ whenever $L_e\ne0$, for instance at any $e$ with $\theta(e)=\langle e\circ e,e\rangle\ne0$. With $\kappa\ne0$ forced by one pair, the content is that one constant serves every pair.

**`weylModuleS_fin4_nonzero` says what its name says**: `∃ w ∈ weylModuleS (Fin 4), w ≠ 0`. The witness is the sphere-weight operator at $S=\{0,1\}$ precomposed with the skew projection, a member by `comp_skewProj_mem`, and nonzero because it agrees with the layer's operator at $\varphi_{02}$, where `sphereWeight_diagOpL_ne_zero` applies. This is the construction [r1116](REVIEW_r1116.md) section 4 typed as a scratch lemma, now in the layer.

**`comp_skewProj_mem` is the stated direction of the identification**: $R\in$ `weylModule` gives $R\circ\pi\in$ `weylModuleS`, each `IsWeyl` clause read only at skew arguments where $R\circ\pi=R$, and `KillsSym` from $\pi(Z)=0$ at symmetric $Z$. The findings paragraph and the I82b row now describe the restated form ($\exists\kappa\,\forall x,y$) and cite the non-vacuity file, both accurate.

## 5. Axioms

`#print axioms`, compiled against the built layer in a scratch file outside the repository:

| declaration | axioms |
|---|---|
| `L105_pi_bound`, `L105_tangent_bound`, `L105_identity`, `L105_closing` | `[propext, Classical.choice, Quot.sound]` |
| `comp_skewProj_mem`, `weylModuleS_fin4_nonzero`, `old_comp_statement_false` | `[propext, Classical.choice, Quot.sound]` |
| `integral_quadForm_mul_quadForm`, `kyFan_sum_le`, `trace_leftMulS_comp` | `[propext, sorryAx, Classical.choice, Quot.sound]` |

**Each commit's own claim about its axioms holds**: 4/4 clean for L105, the fold's three new proofs clean, and exactly the three named `sorry`s carrying `sorryAx`.
