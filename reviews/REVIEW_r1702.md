# REVIEW r1702: L143's headline typed modulo the second-order bound, the CurvOp2 to EigenFrame bridge (341920d2)

**Verdict: CONFIRMED, with one stale-prose finding and two observations.** `L143_headline` in [L143Attain.lean](../lean/HamiltonsCubic/Results/L143Attain.lean#L73) states that if every critical point of the unit Weyl sphere satisfies $P(R)\le\lambda_{\max}p+B_5$ in its spectral frame, then $\lvert P\rvert\le1+\sqrt{n-2}$ on the whole sphere at every $n\ge4$. Its hypothesis is the record's second-order bound restricted to critical points, with $p$ and $B_5$ exactly as [L143Assembly.lean](../lean/HamiltonsCubic/Results/L143Assembly.lean) defines them and the existential `amax` equivalent to the record's $\lambda_{\max}$. The bridge `evOf`/`vOf` is the spectrum and an orthonormal eigenframe of $R$ on $\Lambda^2$, and the unit spectrum follows from two proved identities. The module builds and rests on the standard three axioms. The finding is that [bounds.md:33](../findings/bounds.md#L33) still lists the bridge as unchecked (G1).

| # | Claim | Verdict |
|---|---|---|
| 1a | `hso` states the record's $\theta\le\lambda_{\max}p+B_5$ at each critical point, $\lambda$ the spectrum of $W$ on $\Lambda^2$ | **CONFIRMED** |
| 1b | `∃ amax` is the record's $\lambda_{\max}$ | **CONFIRMED**, equivalent, neither weaker nor stronger |
| 1c | `hso` fixes one frame where the record's bound holds in every eigenframe | **CONFIRMED**, the hypothesis is weaker than the record's claim, so the theorem is at least as strong as needed (O1) |
| 2a | `evOf`, `vOf` are the spectrum and an orthonormal eigenframe of $R$ on $\Lambda^2$ | **CONFIRMED** |
| 2b | `normSq_frame` with `normSq_extend` derives $\sum_a\lambda_a^2=1$ soundly | **CONFIRMED** |
| 3 | The conclusion is the record's $\sup\lvert P\rvert\le1+\sqrt{n-2}$ at $n\ge4$ | **CONFIRMED** |
| 4 | Axioms: standard three only | **CONFIRMED** (screen by the repo's audit script, 4/4) |
| 5 | The record's prose is current | **STALE** at bounds.md:33 (G1) |

One line: the headline $\sup\lvert P\rvert\le1+\sqrt{n-2}$ is now a kernel-checked implication on the record's own sphere from the record's own second-order bound, and that bound appears to be provable from identities the layer already holds (O2).

## Attack line 1: the hypothesis `hso`

- **What it reads.** For every `R ∈ weylSphereSet (Fin n)` with `Qop2 R = Pcubic2 R • R`, there is `amax : Pairs n` with `Pcubic2 R ≤ evOf R amax * posMass (evOf R) + (1/2) * √(∑_a (∑_b ∑_c cst (vOf R) a b c ^ 2 * |evOf R b| * |evOf R c|)^2)`. Per [r1701](REVIEW_r1701.md), the premise is the record's critical point at unit norm, where $P=\theta$.
- **$p$ and $B_5$.** `posMass lam = ∑_a (if 0 < lam a then lam a ^ 2 else 0)` is $p=\sum_{\lambda>0}\lambda^2$. The square-root term is character for character the binder of `L143_of_second_order`, and with $T_{abc}=c_{abc}^2$ and $\mu=\lvert\lambda\rvert$ it is $\tfrac12(\sum_\alpha\langle T_\alpha\mu,\mu\rangle^2)^{1/2}$, the record's $B_5$ ([bounds.md:25](../findings/bounds.md#L25), [second-order.md](../findings/second-order.md), the display defining $B_5$ under "A bound that survives both regimes").
- **The normalisation of `cst`.** `cst v a b c = inner2 [v_a, v_b] v_c` with `inner2 X Y = ½ tr(XᵀY)`. The layer proves `sharpPair_T` ([L41Statement.lean:823](../lean/HamiltonsCubic/Results/L41Statement.lean#L823)), $\langle W,W^\#\rangle=\tfrac12\sum\lambda_\gamma\lambda_\alpha\lambda_\beta c_{\gamma\alpha\beta}^2$ in this very normalisation, which is the first link of second-order.md's chain $\langle W,W^\#\rangle\le\tfrac12\sum_\alpha\mu_\alpha\langle T_\alpha\mu,\mu\rangle\le B_5$. The two marginals the record uses (pair cap 2, Killing row mass $2(n-2)$) are proved in this normalisation in L143.lean. So `hso` is the record's inequality and not a rescaled one.
- **`∃ amax` against $\lambda_{\max}$.** Equivalent. If $\theta\le\lambda_ap+B_5$ for some $a$, then $\theta\le\lambda_{\max}p+B_5$ since $p\ge0$ and $\lambda_a\le\lambda_{\max}$. Conversely the maximum over the finite `Pairs n` is attained at some index, which serves as `amax`. The record's $\lambda_{\max}$ is a specific eigenvalue, and the existential ranges over exactly the eigenvalues, so nothing is lost or gained.
- **Critical points only.** The record's bound holds pointwise at every unit Weyl tensor (bounds.md:33). Asking it only at critical points is a weaker hypothesis, which is what `sup_abs_le_of_critical` consumes. Faithful.

## Attack line 2: the bridge

- **`evOf R h`** ([L143Attain.lean:61](../lean/HamiltonsCubic/Results/L143Attain.lean#L61)) is `(Mpair_isHermitian (extend R) …).eigenvalues`, Mathlib's eigenvalues of the symmetric matrix $M_{(ab),(cd)}=W_{abcd}$ over `Pairs n` ($a<b$), which is $W$ on $\Lambda^2$ in the orthonormal basis $\{\varphi_{ab}\}_{a<b}$ (`inner2_phi_pairs`). So `evOf` is the spectrum of $W$ on $\Lambda^2$ with multiplicity, $\binom n2$ values.
- **`vOf R h`** ([L143Attain.lean:66](../lean/HamiltonsCubic/Results/L143Attain.lean#L66)) is `frameVec`, $v_k=\sum_{a<b}U_k(a,b)\varphi_{ab}$ with $U$ Mathlib's orthonormal eigenbasis. `eigenFrame_exists` ([EigenFrameExist.lean:146](../lean/HamiltonsCubic/Results/EigenFrameExist.lean#L146)) proves `EigenFrame (extend R) (frameVec …) (… .eigenvalues)`: skew, orthonormal under `inner2`, `extend R v_k = λ_k v_k`, and complete on skew matrices. Those are the four properties of the record's "eigenbasis $\{v_\gamma\}$ orthonormal".
- **The extension.** `extend R X = R(skewProj X)` agrees with `R` on $\Lambda^2$ (`extend_apply`), and `isWeyl_extend` proves the matrix layer's `IsWeyl` from `IsWeyl2`. The Hermitian proof term inside `evOf` and the one inside `eigenFrame_exists` are built from the same `isLinOp_extend R`, `(isWeyl_extend h).1` and `.2.1`, so the eigenvalues named by `evOf` are the ones the frame carries. Proof irrelevance makes this definitional in any case.
- **The unit spectrum.** `normSq_frame hW hf : normSq (extend R) = ∑ λ_γ²` ([L41Statement.lean:804](../lean/HamiltonsCubic/Results/L41Statement.lean#L804)), `normSq_extend : normSq (extend R) = normSq2 R` ([TensorBridge.lean:258](../lean/HamiltonsCubic/Results/TensorBridge.lean#L258)) and `hR.1 : normSq2 R = 1` give $\sum\lambda^2=1$ in three rewrites ([L143Attain.lean:84](../lean/HamiltonsCubic/Results/L143Attain.lean#L84)). Both identities are proved lemmas, and the sum on both sides runs over `Pairs n`, so there is no double count between the $\varphi_{ij}$ over all ordered pairs and the frame over $a<b$.

## Attack line 3: the conclusion

- `∀ R ∈ weylSphereSet (Fin n), |Pcubic2 R| ≤ 1 + √((n:ℝ) − 2)` is the record's $\sup_{\lVert W\rVert=1}\lvert P(W)\rvert\le1+\sqrt{n-2}$ over $W_n$, with the sphere and $P$ as r1701 confirmed. `L143_of_second_order` returns `√(Fintype.card (Fin n) − 2)`, and `simpa [Fintype.card_fin]` turns it into $n$. The subtraction is real, so no truncation arises, and $n\ge4$ is the range where the sphere is nonempty and `sup_abs_attained` holds.

## Attack line 4: axioms and build

- **Screen**: `lake build HamiltonsCubic.Results.L143Attain` completed (8799 jobs), with only long-line linter warnings (line 69 exceeds 100 characters, and the file does not carry the `longLine` option that L143Assembly.lean sets).
- **Screen**: `python3 scripts/misc/axiom_audit.py --only L143Attain.lean` reports 4/4 declarations clean on `propext`, `Classical.choice` and `Quot.sound`. The two new `def`s are covered by the headline's audit, since it unfolds them.

## The object that would break the claims

- **A unit Weyl critical point whose frame spectrum is not unit**, for example a factor of 2 between `normSq2` and $\sum\lambda^2$ from the $\varphi_{ij}$ over ordered pairs against the frame over $a<b$. I looked for it by reading `normSq_extend`, `normSq_frame` and `inner2_phi_pairs`: the ½ in `innerOp2` and the ½ in `inner2` are the ones `normSq_frame` already absorbs, and the kernel checks the rewrite chain. It cannot exist.
- **An `hso` in a rescaled `cst`**, which would make the hypothesis a different, possibly false, inequality and the headline vacuous in practice. I looked for it by matching `cst` against `sharpPair_T` and against the marginals L143.lean proves, all in one normalisation. None found.
- **An `amax` quantifier that weakens the bound**. The equivalence argument above rules it out.

## Findings

- **G1 (stale prose).** [bounds.md:33](../findings/bounds.md#L33) ends *"which leaves the second-order bound $\theta\le\lambda_{\max}p+B_5$ and a bridge from `CurvOp2` to the matrix layer's `EigenFrame` as the unchecked steps."* The bridge is now `L143_headline`, so the second-order bound is the only unchecked step. The INDEX row is already current.

## Observations

- **O1.** The record's bound holds in every orthonormal eigenframe, and $B_5$ can depend on the choice of frame inside a repeated eigenspace. `hso` asks for it in Mathlib's chosen frame only, which the record's statement implies. Nothing further is owed here.
- **O2 (a route for `hso`, unbuilt).** The layer appears to hold every ingredient of second-order.md's derivation: `Pcubic_extend` ([CubicBridge.lean:97](../lean/HamiltonsCubic/Results/CubicBridge.lean#L97)) carries $P$ to the matrix layer, `trCube_frame` ([L41Statement.lean:810](../lean/HamiltonsCubic/Results/L41Statement.lean#L810)) gives $\operatorname{tr}W^3=\sum\lambda^3\le\lambda_{\max}p$ by dropping negative terms, and `sharpPair_T` with $\lvert\lambda_\gamma\lambda_\alpha\lambda_\beta\rvert=\mu_\gamma\mu_\alpha\mu_\beta$ and Cauchy–Schwarz at $\sum\mu^2=1$ gives $\langle W,W^\#\rangle\le B_5$. That would discharge `hso` pointwise and make the headline unconditional. This is a reading of the lemma statements, not a build.
