# REVIEW r1784: L219GenOps.lean (45089985) and L1Frame.lean (03760551)

Gate 2 reader for the Lean layer, statement fidelity. Analysis only: the compute was `lake build` of the two modules, `python3 scripts/misc/axiom_audit.py --only` on each, and one scratch check file under the session scratchpad (`#print axioms`, two witnesses and one corollary, listed in section 3). No numerics.

| Claim | Verdict | Reason |
|---|---|---|
| `rotR_comp`, `rotR_one`, `rotR_inv`, `isOrth_transpose` | CONFIRMED | the action composes, the identity acts trivially, and `rotR U ∘ rotR Uᵀ = id` at orthogonal $U$ |
| `Qop2_rotR`: $Q(UVU^{\mathsf T})=U\,Q(V)\,U^{\mathsf T}$ at Weyl $V$, orthogonal $U$ | CONFIRMED WITH OBSERVATIONS | true and axiom-clean, its Weyl hypothesis narrower than the fact but matching the record's scope (O1) |
| `L219_ops_gen` against L219's operator identities at every unit $u$ | CONFIRMED | hypotheses and conclusion are the record's, `foxProd2` is the record's $\circ$ with the record's factor, `Qop2` is the record's $Q$ |
| lean/INDEX.md L219 (statement) row, the L219GenOps clause | CONFIRMED WITH OBSERVATIONS | describes what is proved and nothing more, while the findings block it points to still calls the identities owed (O2) |
| `restrict_conj_eq`, `conj_diag_invariants` | CONFIRMED | frame change of a linear Weyl operator is `rotR` of its restriction, and $P$, $\lVert\cdot\rVert^2$ are frame-invariant at a coordinate-diagonal Weyl $W$ |
| `L1_frame` against L1 "in every orthonormal frame" | CONFIRMED WITH OBSERVATIONS | covers exactly the Weyl operators diagonal in an orthonormal frame, shown by an intrinsic-form corollary compiled here (O5) |
| lean/INDEX.md L1 (statement) row, the L1Frame clause | CONFIRMED | describes what is proved and nothing more |

**Summary**: both files are sound, axiom-clean, non-vacuous and say what the INDEX rows say. Five observations, all bookkeeping or scope remarks, and none refutes a statement.

## 1. L219GenOps.lean

**Source, verbatim.** [findings/second-order.md:1505](../findings/second-order.md) and [:1508](../findings/second-order.md):

> *Let $u\in\mathbb R^n$ be a unit vector, $\sigma_u\in O(n)$ the reflection in $u^\perp$, and split $W\in\mathcal W_n$ as $W=b+c$ with $\sigma_ub=b$ and $\sigma_uc=-c$.* [...] *If $W$ is a critical point, $Q(W)=\theta W$, then* $$b\circ b+c\circ c=\theta b,\qquad 2\,b\circ c=\theta c,\ \dots$$

Conventions: [findings/conventions.md:15](../findings/conventions.md) "$Q(W)$ | Hamilton's quadratic map $W^2+W^\#$", [:17](../findings/conventions.md) "at a critical point, $Q(W)=\theta W$", [:136](../findings/conventions.md) "$X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$".

**Lean, [L219GenOps.lean:88-93](../lean/HamiltonsCubic/Results/L219GenOps.lean).** `L219_ops_gen (u) (hu : ∑ a, u a ^ 2 = 1) (W) (hW : IsWeyl2 W) (hQ : Qop2 W = θ • W)`, conclusion `Qop2 b + Qop2 c = θ • b ∧ 2 • foxProd2 b c = θ • c` with `b, c = ½(W ± rotR (Su u) W)`.

Hypothesis by hypothesis:

- **Unit vector.** `hu` is $\lVert u\rVert^2=1$ in the standard frame. Matches.
- **Reflection.** `Su u = 1 - 2 • vecMulVec u u` ([L219Gen.lean:31](../lean/HamiltonsCubic/Results/L219Gen.lean)), the reflection in $u^\perp$ at unit $u$. `rotR U V X = U · V(Uᵀ X U) · Uᵀ` ([FrameOp2.lean:45](../lean/HamiltonsCubic/Results/FrameOp2.lean), `rotR_coe`), the $O(n)$ action on curvature operators. Matches, and r1783 confirmed both.
- **Split.** $b,c=\tfrac12(W\pm\sigma_uW)$ are the unique even and odd parts, since $\sigma_u^2=1$ (`rotR_Su_Su`). The record's "split $W=b+c$ with $\sigma b=b$, $\sigma c=-c$" names the same pair.
- **Weyl.** `IsWeyl2 W` is $W\in\mathcal W_n$. Matches.
- **Eigen-equation.** `hQ` is $Q(W)=\theta W$ with no norm constraint. The record's normalisation ([conventions.md:17](../findings/conventions.md)) reads $\theta=P(W)$ at unit norm. Both identities are homogeneous of degree two in $W$ with $\theta$ scaling by degree one, so the Lean's unnormalised form contains the record's unit-norm case and nothing false beyond it.
- **$Q$.** `Qop2 R = compOp2 R + sharpMapCL R` ([Bivectors2.lean:825](../lean/HamiltonsCubic/Base/Bivectors2.lean)), $R^2+R^\#$ on `CurvOp2`. Matches [conventions.md:15](../findings/conventions.md).
- **$\circ$ and its factor.** `foxProd2 X Y = ½(Q(X+Y) − Q(X) − Q(Y))` ([FirstVariation.lean:57](../lean/HamiltonsCubic/Results/FirstVariation.lean)), the record's definition verbatim. So $x\circ x=\tfrac12(Q(2x)-2Q(x))=Q(x)$, and the Lean's `Qop2 b + Qop2 c` is the record's $b\circ b+c\circ c$. The second conjunct `2 • foxProd2 b c` is the record's $2\,b\circ c$, factor included.

The proof is the record's step 2 exactly: $Q(b\pm c)=Q(b)+Q(c)\pm2\,b\circ c$ (`Qop2_add`, `Qop2_sub`, both unconditional), with $Q(\sigma W)=\sigma Q(W)=\theta\sigma W$ from `Qop2_rotR`, then half-sum and half-difference.

**`Qop2_rotR`, [L219GenOps.lean:53-85](../lean/HamiltonsCubic/Results/L219GenOps.lean).** The duality argument checks: for Weyl $Z$, $\langle Z,Q(UVU^{\mathsf T})\rangle=T(UVU^{\mathsf T},UVU^{\mathsf T},Z)=T(V,V,U^{\mathsf T}ZU)=\langle U^{\mathsf T}ZU,Q(V)\rangle=\langle Z,U\,Q(V)\,U^{\mathsf T}\rangle$, and the difference is Weyl (`isWeyl2_Qop2`, `rotR_isWeyl2`), so pairing it with itself and `normSq2_eq_zero` (definiteness on `CurvOp2`) gives equality. Each step uses a hypothesis the statement carries.

**The four helpers.** `rotR_comp`: $U(U'V(U'^{\mathsf T}(U^{\mathsf T}XU)U')U'^{\mathsf T})U^{\mathsf T}=(UU')V((UU')^{\mathsf T}X(UU'))(UU')^{\mathsf T}$, unconditional and correct. `rotR_one` trivial. `rotR_inv` uses `hU.2 : U Uᵀ = 1`. `isOrth_transpose` swaps the two clauses of [Frames.lean:27](../lean/HamiltonsCubic/Base/Frames.lean)'s `IsOrth`.

**INDEX row, [lean/INDEX.md:148](../lean/INDEX.md), verbatim clause:** "*The operator identities at every unit $u$, PROVED in L219GenOps.lean: `Qop2_rotR`, $Q$ commutes with every frame change on Weyl operators, by duality (...), with `rotR_comp`, `rotR_inv`; `L219_ops_gen`, $Q(b)+Q(c)=\theta b$ and $2\,b\circ c=\theta c$; standard three axioms.*" The row's hypotheses for $u$ and $W$ are stated once for the preceding `L219_gen` clause ("with $\sigma_u$ = `rotR (Su u)` [...] at a Weyl $W$ with $Q(W)=\theta W$") and carry over. It claims nothing the file does not prove, and it keeps the general-frame diagonality clause as owed, which is correct.

## 2. L1Frame.lean

**Source, verbatim.** The problem statement, [README.md:18](../README.md): "*the result holds when $P$ is restricted to curvature operators that are diagonal with respect to a suitable basis of $\mathbb{R}^n$*". L1's heading, [findings/problem.md:506](../findings/problem.md): "*Lemma L1: the diagonal case at $n=12$ and $n=14$*". Its Lean paragraph, [findings/problem.md:540](../findings/problem.md): "*every orthonormal frame is `L1_frame` in L1Frame.lean, through the frame-change invariance of $P$ and the norm, which discharges r1768's observation O1 (Gate 2 pending)*". The inequality, from [L1Statement.lean](../lean/HamiltonsCubic/Results/L1Statement.lean)'s docstring: "$\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$, with $\Theta_n=\theta_0(n)$ at these two even dimensions".

**Lean, [L1Frame.lean:61-63](../lean/HamiltonsCubic/Results/L1Frame.lean).** `L1_frame (hn : n = 12 ∨ n = 14) (hU : IsOrth U) (W) (hW : IsWeyl W) (hdiag : IsDiagonalOp W) : Pcubic (conjOp U W) ≤ theta0 n * norm (conjOp U W) ^ 3`.

- **Dimension.** `n = 12 ∨ n = 14` on `Fin n`. Matches.
- **Diagonal in an orthonormal frame.** `IsDiagonalOp W` is $W\varphi_{ij}=c_{ij}\varphi_{ij}$ for every coordinate pair ([L1Statement.lean:76](../lean/HamiltonsCubic/Results/L1Statement.lean)), and `conjOp U W X = U · W(Uᵀ X U) · Uᵀ` ([Frames.lean:34](../lean/HamiltonsCubic/Base/Frames.lean)). With $f_i$ the columns of $U$, $U\varphi_{ij}U^{\mathsf T}=f_i\wedge f_j$ and `conjOp U W` sends it to $c_{ij}f_i\wedge f_j$. So the conclusion is about an operator diagonal in the orthonormal frame $(f_i)$.
- **Every such operator is reached.** The parametrised form could in principle miss operators. It does not: I compiled `L1_any_frame` (section 3), which takes any `IsWeyl V` with $V(U\varphi_{ij}U^{\mathsf T})=c_{ij}\,U\varphi_{ij}U^{\mathsf T}$ at an orthogonal $U$ and derives the bound for $V$ itself from `L1_frame` at $W=$ `conjOp Uᵀ V` (Weyl by `isWeyl_conj`, coordinate-diagonal by $U^{\mathsf T}U=1$, and `conjOp U (conjOp Uᵀ V) = V` pointwise on all matrices by $UU^{\mathsf T}=1$). So `L1_frame` is equivalent to the intrinsic statement.
- **Conclusion.** `Pcubic = trCube + sharpPair` is $\langle W^2,W\rangle+\langle W^\#,W\rangle=\langle Q(W),W\rangle$ ([WeylReal.lean:170](../lean/HamiltonsCubic/Base/WeylReal.lean)), `norm` is $\sqrt{\langle W,W\rangle}$, and `theta0 n` $=\sqrt{2(n-1)(n-2)}/n$, which is $\Theta_n$ at even $n$ by [conventions.md:18-19](../findings/conventions.md). Matches.
- **Strength of hypotheses.** `IsWeyl` carries no linearity clause, so the hypotheses are weaker than "linear Weyl operator", never stronger. `IsWeyl` includes the bivector-valued clause whose absence once made `ProblemP` false ([WeylReal.lean:112-120](../lean/HamiltonsCubic/Base/WeylReal.lean)), so the class is not inflated.

**`conj_diag_invariants`, [L1Frame.lean:34-58](../lean/HamiltonsCubic/Results/L1Frame.lean).** It replaces $W$ by its linear diagonal model `diagOp (wOf c)` on bivectors (`pcubic_congr`, before and after the frame change), transports to `CurvOp2` (`restrict_conj_eq`), and applies r1783's confirmed `Pcubic2_rotR`, `normSq2_rotR`. Sound. `restrict_conj_eq` is `rfl` after unfolding, which is right since both sides are $U\,D(U^{\mathsf T}XU)\,U^{\mathsf T}$.

**INDEX row, [lean/INDEX.md:560](../lean/INDEX.md), verbatim clause:** "*In every orthonormal frame, PROVED in L1Frame.lean (r1768 O1): `conj_diag_invariants`, at a coordinate-diagonal Weyl $W$ and orthogonal $U$, $P$ and $\lVert\cdot\rVert^2$ of `conjOp U W` equal $W$'s, through the diagonal model and FrameOp2.lean's `Pcubic2_rotR`; `L1_frame`, $P\le\theta_0(n)\lVert W\rVert^3$ at $n=12,14$ for every Weyl operator diagonal in an orthonormal frame; standard three axioms.*" Accurate, and "every" is earned by the corollary above.

## 3. Axioms, witnesses and the build

`lake build HamiltonsCubic.Results.L219GenOps HamiltonsCubic.Results.L1Frame`: success (one `show` style lint at [L1Frame.lean:50](../lean/HamiltonsCubic/Results/L1Frame.lean)). `axiom_audit.py --only`: 6/6 and 3/3 clean.

`#print axioms`, each `[propext, Classical.choice, Quot.sound]`: `rotR_comp`, `rotR_one`, `rotR_inv`, `isOrth_transpose`, `Qop2_rotR`, `L219_ops_gen`, `restrict_conj_eq`, `conj_diag_invariants`, `L1_frame`.

Scratch checks, all compiled with the standard three and no `sorry`:

- **`w219`** (non-vacuity of `L219_ops_gen`): at $n=4$, `exists_weyl_maximiser` supplies a unit Weyl $a$ with $P(a)\ge\sqrt{3/2}$, `Qop2_eq_smul_weyl` gives $Q(a)=P(a)\,a$, and `L219_ops_gen` instantiates at $u=e_0$ with $\theta=P(a)>0$. The hypotheses are therefore met by a nonzero critical point with positive $\theta$, the record's case, and $W=0$ is the trivial witness beside it.
- **`w1`** (non-vacuity of `L1_frame`): at $n=12$, $W=$ `diagOp (sphereWeight T)` with $T=\{0,\dots,5\}$, the balanced $S^6\times S^6$ Weyl weight the record names as the equality case, rotated by $U=S_{e_0}$. Weyl by `diagOp_isWeyl` and `sphereWeight_isWeight`, diagonal by `diagOp_phi`. `L1_frame` applies.
- **`L1_any_frame`**: the intrinsic reading of section 2, proved from `L1_frame` in eighteen lines.

## 4. Observations

- **O1. `Qop2_rotR` is stated on Weyl $V$ only** ([L219GenOps.lean:53](../lean/HamiltonsCubic/Results/L219GenOps.lean)). $Q$ commutes with $\Lambda^2U$ for every $U\in O(n)$ on all of `CurvOp2`, since $\operatorname{Ad}_U$ is a Lie algebra automorphism of $\mathfrak{so}(n)$ and $\#$ is built from the bracket. The Weyl restriction is a proof artefact of the duality route (`Tsym_rotR` is typed on Weyl triples). It matches the record's scope, "$O(n)$ acts on $\mathcal W_n$", and no consumer needs more.
- **O2. The findings block still calls the operator identities owed.** [findings/second-order.md:1503](../findings/second-order.md): "*The Lean owes, at a general $u$, the operator identities, which need $Q\circ\sigma_u=\sigma_u\circ Q$ on `CurvOp2`, and the diagonality clause in a general frame.*" `Qop2_rotR` and `L219_ops_gen` now discharge the first half. The sentence should name them and keep only the diagonality clause as owed, as lean/INDEX.md:148 already does.
- **O3. `Qop2_rotR` discharges r1783 O2 in substance.** r1783 recorded that $\sigma(x\circ y)=\sigma x\circ\sigma y$ is untyped. Since `foxProd2` is the polarisation of `Qop2`, `Qop2_rotR` at $x$, $y$, $x+y$ gives it at every Weyl pair in one line. No theorem states it, so the record's step-0 sentence "$O(n)$ acts on $\mathcal W_n$ by isometric algebra automorphisms" is typed only through this corollary.
- **O4. Name collision.** [L219GenOps.lean:49](../lean/HamiltonsCubic/Results/L219GenOps.lean)'s `isOrth_transpose` duplicates `HamiltonsCubic.FrameLayer.isOrth_transpose` ([FrameInv.lean:32](../lean/HamiltonsCubic/Results/FrameInv.lean)), the latter at any `Fintype ι`. A file opening both namespaces gets an "Ambiguous term" error, which the scratch file hit. The local copy can be deleted in favour of FrameInv's.
- **O5. L1 has no "Statement." line in the record.** [findings/problem.md:526](../findings/problem.md) is headed "canonical statement and proof" but carries the argument only. The inequality $\langle Q(W),W\rangle\le\theta_0(n)\lVert W\rVert^3$ is stated in L1Statement.lean's docstring and implied by the heading plus [README.md:18](../README.md). A one-sentence statement in the block would give `L1`, `L1_eq` and `L1_frame` a source to be read against. Relatedly, README's "a suitable basis of $\mathbb R^n$" does not say orthonormal. The orthonormal reading is the standard one (Jäger) and the one `L1_frame` takes, and [problem.md:540](../findings/problem.md)'s "(Gate 2 pending)" can now cite this review.

## 5. Falsifiers

| Statement | The object that would falsify it |
|---|---|
| `Qop2_rotR` | an orthogonal $U$ and a Weyl $V$ with $Q(UVU^{\mathsf T})\ne U\,Q(V)\,U^{\mathsf T}$ on some bivector |
| `L219_ops_gen` | a Weyl $W$ with $Q(W)=\theta W$ and a unit $u$ whose even and odd parts give $Q(b)+Q(c)\ne\theta b$ or $2\,b\circ c\ne\theta c$ |
| `conj_diag_invariants` | a coordinate-diagonal Weyl $W$ and orthogonal $U$ with $P$ or $\lVert\cdot\rVert^2$ of `conjOp U W` differing from $W$'s |
| `L1_frame` | at $n=12$ or $14$, a Weyl operator diagonal in some orthonormal frame with $P(W)>\theta_0(n)\lVert W\rVert^3$, that is $\theta(W)>\sqrt{55}/6$ at $n=12$ or $\theta(W)>\sqrt{78}/7$ at $n=14$ |
