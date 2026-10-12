# Reviewer r1118: Ky Fan proved, Ky Fan against an eigenbasis, and the root slots

*Gate 2 review, one reviewer, of three Lean commits against the statements they claim: 6b07c398 (`kyFan_sum_le` proved, [KyFanPrinciple.lean](../lean/HamiltonsCubic/Results/KyFanPrinciple.lean)), aa32980e (`bessel_bilin`, `kyFan_eigen`, same file) and 7b18849a (`slot_plus`, `slot_plus2`, `slot_minus`, `slot_minus2` in [RootSlots.lean](../lean/HamiltonsCubic/Results/RootSlots.lean)), each read against Lemma L237 in [second-order.md](../findings/second-order.md). Analysis first, then one Lean check of seconds: `lake build` of the two modules (clean, linter warnings only) and a scratch file printing the axioms of all eight declarations. Log: [r1118-kyfan-slots.log](../agent_logs/r1118-kyfan-slots.log).*

| # | Commit | Claim | Verdict |
|---|---|---|---|
| 1 | 6b07c398 | `kyFan_sum_le` proved, statement unchanged from r1117's | **CONFIRMED** |
| 2 | aa32980e | `bessel_bilin`, `kyFan_eigen` are Ky Fan against an eigenbasis in the form L237 needs | **CONFIRMED**, with two owed items the L237 row should name (below) |
| 3a | 7b18849a | the four slots carry $(s+t)^2$ and $(s-t)^2$ under the layer's $\varphi$ | **CONFIRMED** |
| 3b | 7b18849a | the lean/INDEX.md L237 row describes them and what remains owed | **PLAUSIBLE**: accurate on what is proved, its owed list is shorter than the file's own |
| 4 | all | axioms | **CONFIRMED**: all eight on `[propext, Classical.choice, Quot.sound]` |

**All three commits prove what they claim.** The corrections are to the owed list in the L237 row and one stale sentence in L237's own Lean paragraph.

## 1. 6b07c398, `kyFan_sum_le` proved

- **The statement is byte-identical to the one [r1117](REVIEW_r1117.md) confirmed** at 6a21c9ae: diffing the theorem header between 6a21c9ae and HEAD shows only `sorry` replaced by the proof. `#check` at HEAD prints the same type.
- **The proof is the textbook one.** $M=V\,\mathrm{diag}(\lambda)\,V^{\mathsf T}$ from Mathlib's `spectral_theorem` with $V$ the eigenvector unitary, $y_j=V^{\mathsf T}x_j$ orthonormal because $VV^{\mathsf T}=1$, $\langle x_j,Mx_j\rangle=\sum_k\lambda_ky_{jk}^2$, weights $w_k=\sum_jy_{jk}^2\in[0,1]$ (Bessel at $z=e_k$) with $\sum_kw_k=r$, and $\lambda_kw_k\le cw_k+\max(\lambda_k-c,0)$, which holds on both signs of $\lambda_k-c$ given $0\le w_k\le1$.
- **`bessel`** is $\lVert z-\sum_j\langle z,y_j\rangle y_j\rVert^2=\lVert z\rVert^2-\sum_j\langle z,y_j\rangle^2\ge0$, correct for any orthonormal family.
- `#print axioms` on `bessel` and `kyFan_sum_le`: standard three.

## 2. aa32980e, `bessel_bilin` and `kyFan_eigen`

**The statement is true and its hypotheses are the right ones.**

- **Hypotheses.** $B$ symmetric and positive semidefinite, $b_k$ a finite $B$-orthonormal family with $Mb_k=\mu_kb_k$, $y_j$ $B$-orthonormal, and `hspan`: $y_j=\sum_kB(b_k,y_j)\,b_k$.
- **Why `hspan` is the right hypothesis.** It puts each $y_j$ in the span of the eigenbasis, which gives $B(y_j,My_j)=\sum_k\mu_kB(b_k,y_j)^2$ by orthonormality of the $b_k$, and $\sum_kB(b_k,y_j)^2=1$ (Parseval inside the span). Without it a component of $y_j$ outside the span would contribute an uncontrolled term. It is also the economical choice: the basis need not span $E$, so $E$ may be all $n\times n$ matrices while the slot basis spans only $\mathfrak{so}(n)$, and `hspan` then holds for skew $y_j$ once the slot basis is complete there.
- **Nothing else is needed.** $M$ is not assumed $B$-self-adjoint, and it need not be, since only $M$ on the $b_k$ enters after `hspan`. Positivity is used only in `bessel_bilin`, which gives $w_k\le1$. The closing chain is the one of item 1.
- **It is the form L237 uses.** L237's pairing is $\langle X,Y\rangle=-\tfrac12\operatorname{tr}XY$, which on skew matrices equals the layer's `inner2` $=\tfrac12\operatorname{tr}X^{\mathsf T}Y$ ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)), positive semidefinite and symmetric on all matrices. With $M=-\mathrm{ad}_{X_0}^2$, $y_j=X_j$ and the slot basis as $b$, `kyFan_eigen` at $c$ equal to the $r$-th largest $\mu$ gives $\sum_j\langle X_j,-\mathrm{ad}_{X_0}^2X_j\rangle\le$ the top-$r$ sum, which is L237's first step.

**Owed before it applies, and absent from the L237 row**:

- `inner2` packaged as a `LinearMap.BilinForm ℝ (Matrix ι ι ℝ)` and $-\mathrm{ad}_{X_0}^2$ as a linear map. The layer has neither (no `BilinForm` occurs outside KyFanPrinciple.lean).
- the identity $\langle X_j,-\mathrm{ad}_{X_0}^2X_j\rangle=\lVert[X_0,X_j]\rVert^2$, from $\mathrm{ad}_{X_0}$ being `inner2`-skew-adjoint on skew matrices. L237's left side is the bracket sum, so this step is what connects it to `kyFan_eigen`'s left side.

## 3. 7b18849a, the root slots

**3a. The eigenvalues are correct under the layer's convention**, $\varphi_{ij}=E_{ji}-E_{ij}$ with `br_phi_phi` giving $[\varphi_{ab},\varphi_{cd}]=\delta_{ac}\varphi_{bd}+\delta_{bd}\varphi_{ac}-\delta_{ad}\varphi_{bc}-\delta_{bc}\varphi_{ad}$. By hand, with $p,q,u,v$ distinct and $X=s\varphi_{pq}+t\varphi_{uv}$:

- $[\varphi_{pq},\varphi_{pu}]=\varphi_{qu}$, $[\varphi_{pq},\varphi_{qv}]=-\varphi_{pv}$, $[\varphi_{uv},\varphi_{pu}]=\varphi_{pv}$, $[\varphi_{uv},\varphi_{qv}]=-\varphi_{qu}$.
- $\mathrm{ad}_X(\varphi_{pu}-\varphi_{qv})=(s+t)(\varphi_{pv}+\varphi_{qu})$ and $\mathrm{ad}_X(\varphi_{pv}+\varphi_{qu})=-(s+t)(\varphi_{pu}-\varphi_{qv})$, so both are $-\mathrm{ad}_X^2$-eigenvectors at $(s+t)^2$.
- $\mathrm{ad}_X(\varphi_{pu}+\varphi_{qv})=(s-t)(\varphi_{qu}-\varphi_{pv})$ and $\mathrm{ad}_X(\varphi_{pv}-\varphi_{qu})=(s-t)(\varphi_{pu}+\varphi_{qv})$, so both are at $(s-t)^2$.
- The six distinctness hypotheses are exactly what the computation needs. Multiplicity two per slot matches L237's "each slot of multiplicity 2" from L31.
- **Normalisation agrees with L237's constants.** $\lVert\varphi_{ij}\rVert=1$ under `inner2`, so a unit $X=(\varphi_{pq}+\varphi_{uv})/\sqrt2$ has top eigenvalue $(s+t)^2=2=\kappa_1$.

**3b. The L237 row is accurate on what is proved and short on what is owed.** Its "what the files leave out" names the kernel slots, the passage to a general normal form and completeness of the slot basis. RootSlots.lean's own docstring owes more, and the row should match it:

- the null directions (the $\varphi_{wz}$ with $w,z$ outside every block, eigenvalue $0$) alongside the kernel slots $\varphi_{pw}$ at $s^2$;
- **orthonormality** of the slot basis: the four slot vectors have `inner2` norm $\sqrt2$ and enter `kyFan_eigen` divided by $\sqrt2$;
- `kyFan_eigen` applied to the slot basis, and the two items of section 2 (the `BilinForm` packaging and the bracket-norm identity).

The phrase "the form the Weyl layer's `inner2` needs" in the row reads as if `inner2` already fits. It fits once packaged, which is owed. "10/10 clean" counts the six bilinearity helpers with the four slots, which is correct.

**Stale in the record (for the owning loop, this reviewer does not edit findings/):** L237's **Lean.** paragraph in [second-order.md](../findings/second-order.md) still ends "Ky Fan's principle and the root-slot spectrum are not typed". After these commits Ky Fan is proved in both forms and the block-pair slots are proved, while the kernel and null slots, completeness and the assembly remain untyped.

## 4. Axioms

`#print axioms` on `bessel`, `kyFan_sum_le`, `bessel_bilin`, `kyFan_eigen`, `slot_plus`, `slot_plus2`, `slot_minus`, `slot_minus2`: each `[propext, Classical.choice, Quot.sound]`. The build of both modules succeeded, with unused-tactic linter warnings from the `first | …` fallbacks in the slot proofs, which are cosmetic.
