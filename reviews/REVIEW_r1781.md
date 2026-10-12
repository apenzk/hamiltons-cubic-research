# Review r1781: L245Op.lean (15fdf176)

| Claim | Verdict | Reason |
|---|---|---|
| `xk` is $x\wedge e_k$ | CONFIRMED | $\sum_a x_a\varphi_{ak}=e_kx^{\mathsf T}-xe_k^{\mathsf T}$, the record's $x\wedge e_k$ up to a sign that every use squares or pairs twice |
| `isoW P x` is $\langle A_cx,x\rangle$ at $P=\sum_{\psi\in E_c}\psi\psi^{\mathsf T}$ | CONFIRMED | $\langle\psi,x\wedge e_k\rangle=\pm(\psi x)_k$ under inner2 $=\tfrac12\operatorname{tr}$, so $\sum_k\langle\psi,x\wedge e_k\rangle^2=\lvert\psi x\rvert^2=\langle\psi\psi^{\mathsf T}x,x\rangle$ (hand derivation, plus a screen) |
| `isoW_expand` | CONFIRMED | bilinear expansion over the $\varphi$ basis, checked at source |
| `isoW_add`, `isoW_smul`, `isoW_sum` | CONFIRMED | linearity of the pairing in its first slot, induction for the sum |
| `isoW_nonneg` | CONFIRMED | each summand is `IsPSD2` evaluated at `xk x k` |
| `isoW_weyl` | CONFIRMED | after expansion the inner sum is `hW.ric a b`, which is the record's $\operatorname{Ric}_{ab}=\sum_c\langle W\varphi_{ac},\varphi_{bc}\rangle=0$ |
| `isoW_id` | CONFIRMED | Gram matrix $\langle\varphi_{ak},\varphi_{bk}\rangle=\delta_{ab}-\delta_{ak}\delta_{bk}$ gives $n\lvert x\rvert^2-\lvert x\rvert^2$, the record's $(n-1)$ |
| `L245_op` | CONFIRMED | the record's three facts, under hypotheses satisfied by the spectral projectors and strictly weaker than them |
| `L245_ceilings` | CONFIRMED | the record's $h_0$ and $h_2$ multiplied out, with the right order hypothesis fed to each scalar lemma |
| Axioms | CONFIRMED | `propext`, `Classical.choice`, `Quot.sound` for `L245_op`, `L245_ceilings`, `isoW_id`, `isoW_weyl` |
| lean/INDEX.md L245 row | CONFIRMED WITH OBSERVATIONS | accurate, with $h_1$ at the operator level left unmentioned among the untyped items |

**Summary:** the file proves L245's two identities and nonnegativity at the operator level from definitions that match the record's normalisation, and derives $h_0$ and $h_2$. Two observations concern wording only.

## 1. Is `isoW P x` the record's $\langle A_cx,x\rangle$?

- Definitions at source: `phi i j = single j i 1 - single i j 1` and `inner2 X Y = ½ tr(XᵀY)` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)), so $\lVert\varphi_{ij}\rVert=1$ at $i\ne j$ (`inner2_self_phi`, [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)).
- `xk x k` $=\sum_a x_a\varphi_{ak}$. With $\varphi_{ak}=e_ke_a^{\mathsf T}-e_ae_k^{\mathsf T}$ this is $e_kx^{\mathsf T}-xe_k^{\mathsf T}$, a unit-normalised $x\wedge e_k$ at unit $x\perp e_k$ and the negative of the other sign convention. The sign is immaterial because `isoW` is quadratic in `xk`.
- For skew $\psi$: $\langle\psi,e_kx^{\mathsf T}-xe_k^{\mathsf T}\rangle=\tfrac12\bigl(\sum_a\psi_{ka}x_a-\sum_a\psi_{ak}x_a\bigr)=(\psi x)_k$. Summing squares over $k$ gives $\lvert\psi x\rvert^2=\langle\psi\psi^{\mathsf T}x,x\rangle$ exactly, with no factor of 2.
- At $P=\sum_{\psi\in E}\psi\langle\psi,\cdot\rangle$ with $E$ inner2-orthonormal, $\langle P(x\wedge e_k),x\wedge e_k\rangle=\sum_\psi\langle\psi,x\wedge e_k\rangle^2$, so `isoW P x` $=\sum_{\psi\in E}\lvert\psi x\rvert^2=\langle A x,x\rangle$. This matches the record.
- The $(n-1)$ is the record's. The record's own $\sum_cA_c=(n-1)I$ fixes inner2-orthonormality: $\sum_{a<b}\varphi_{ab}\varphi_{ab}^{\mathsf T}=\sum_{a<b}(e_ae_a^{\mathsf T}+e_be_b^{\mathsf T})=(n-1)I$. Under Frobenius normalisation it would read $\tfrac{n-1}2I$. `isoW_id` gives $(n-1)\lvert x\rvert^2$, so both sides use the same convention.
- Screen: for 20 random inner2-unit skew $\psi$ and random $x$ at $n=6$, $\max\lvert\,\lvert\psi x\rvert^2-\sum_k\langle\psi,\sum_ax_a\varphi_{ak}\rangle^2\rvert=4.4\times10^{-16}$. This is a screen of the hand identity and serves as no further evidence.
- Observation O1: the identification of `isoW` with $\langle A_cx,x\rangle$ at a rank-one sum lives in the docstring and the INDEX row and is not typed. It is a two-line computation (above) and the operator-level statement remains meaningful without it, because the record itself writes $\sum_cA_c=\operatorname{Ric}(\mathrm{Id})$, which is `isoW` read as a Ricci contraction.

## 2. Is `isoW_weyl` sound from IsWeyl2's `ric` field?

- `IsWeyl2.ric` ([Bivectors2.lean:352](../lean/HamiltonsCubic/Base/Bivectors2.lean)) reads `∀ a b, ∑ c, inner2 (applyPhi R a c) (phi b c) = 0`, with `applyPhi R a c = R φ_ac` coerced. This is the record's $\operatorname{Ric}_{ab}=\sum_c\langle W\varphi_{ac},\varphi_{bc}\rangle=0$. The $c=a$ and $c=b$ terms vanish because $\varphi_{aa}=0$.
- The proof expands `isoW W x` to $\sum_k\sum_a\sum_bx_ax_b\langle W\varphi_{ak},\varphi_{bk}\rangle$, commutes $k$ inward past both $a$ and $b$, and applies `hW.ric a b`. Sound. It uses only `ric`, as the record says only $\operatorname{Ric}(W)=0$ is used.

## 3. The hypotheses on $P_c$

- Satisfiable: at $W=0$ (Weyl by `isWeyl2_zero`), $P=(\mathrm{id},0,0)$ and any $\lambda$, all three hypotheses hold, since `inner2 X X` $=\tfrac12\sum X_{ij}^2\ge0$. Nondegenerate instances come from any self-adjoint Weyl $W$ with three eigenvalues: its orthogonal spectral projectors are PSD, resolve the identity and satisfy $\sum\lambda_cP_c=W$. So the record's case lies inside the hypotheses.
- At the spectral projector $P_c=\sum_{\psi\in E_c}\psi\langle\psi,\cdot\rangle$, `isoW (P c) x` is the record's $a_c$ by section 1.
- Nothing is lost. The Lean statement assumes less than the record (no idempotence, no self-adjointness, no mutual orthogonality, no distinct or ordered $\lambda$ in `L245_op`, no criticality) and concludes the same three facts. This is the generalisation the record's own remark predicts ("holds at every three-valued Weyl tensor, critical or not"). `isoW` reads only the quadratic form of $P$, so self-adjointness is not needed.

## 4. Does `L245_ceilings` state $h_0$ and $h_2$?

- Stated: $(\lambda_2-\lambda_0)a_0\le(n-1)\lambda_2$ and $(\lambda_2-\lambda_0)a_2\le(n-1)(-\lambda_0)$. At $\lambda_0<\lambda_2$ these are $a_0\le h_0$ and $a_2\le h_2$ with $h_2$'s $\lvert\lambda_0\rvert=-\lambda_0$ (the record's $\lambda_0<0$ follows from the Ricci identity at $\lambda_0<\lambda_2$, and the multiplied form needs no sign).
- Plumbing: `ceiling_h0` takes $a_1\ge0$ and $\lambda_1\le\lambda_2$ (`hn 1`, `hl12`), `ceiling_h2` takes $a_1\ge0$ and $\lambda_0\le\lambda_1$ (`hn 1`, `hl01`). Both match their scalar statements in [L245SymmetricIsotropy.lean](../lean/HamiltonsCubic/Results/L245SymmetricIsotropy.lean).
- $h_1$ and the star clause are not stated at the operator level. $h_1$ is one application of the existing `ceiling_h1` to `hn 0`, `hn 2`, and its two-inequality form is at least as strong as the record's sign-split $h_1$.
- Observation O2: the module docstring says "`ceiling_h0`, `ceiling_h1`, `ceiling_h2` apply (`L245_ceilings`)", while `L245_ceilings` delivers $h_0$ and $h_2$ only. The INDEX row says "`L245_ceilings`, $h_0$ and $h_2$ from them" and lists under **Not typed** the spectral theorem and the star clause, without naming $h_1$ at the operator level. Suggested repair: add the `ceiling_h1` conjunct to `L245_ceilings` (one term), or name $h_1$ in the docstring and row as scalar-only.

## 5. Axioms

`#print axioms` on a check file importing `HamiltonsCubic.Results.L245Op`: `L245_op`, `L245_ceilings`, `isoW_id` and `isoW_weyl` each depend on `[propext, Classical.choice, Quot.sound]`. No `sorryAx`, no `Lean.ofReduceBool`.

## 6. The INDEX row

- File list, `partial` status and every named declaration match the code.
- "the record's $\langle A_cx,x\rangle$ at an eigenprojector" is correct (section 1) and is prose, not typed (O1).
- "standard three axioms" matches section 5.
- The untyped list omits $h_1$ at the operator level (O2).

## 7. Falsifiers

| Statement | Falsifying object | What was done |
|---|---|---|
| `isoW` $=\langle A_cx,x\rangle$ | a normalisation mismatch, e.g. $\varphi$ of Frobenius norm 1, giving a factor 2 | derived by hand from `phi`, `inner2` at source, then screened at $n=6$ |
| `isoW_id` | $\varphi$ Gram matrix other than $\delta_{ik}\delta_{jl}-\delta_{jk}\delta_{il}$ | read `inner2_phi_phi` at source and recomputed $\sum_{a<b}\varphi\varphi^{\mathsf T}=(n-1)I$ |
| `isoW_weyl` | an `IsWeyl2` field weaker than $\operatorname{Ric}=0$ | read the `ric` field, which is the full Ricci contraction for every $a,b$ |
| `L245_op` | vacuous hypotheses, or hypotheses the spectral projectors fail | exhibited $W=0$, $P=(\mathrm{id},0,0)$ and argued the spectral projectors satisfy all three |
| `L245_ceilings` | a swapped order hypothesis or index | matched `hn 1`, `hl12`, `hl01` against the scalar lemmas |

The Lean statements are kernel-checked, so a falsifier could only be interpretive. None was found.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** O1: the identification of `isoW` with $\langle A_cx,x\rangle$ is by hand. O2: the docstring overstates `L245_ceilings` as covering $h_1$, and the INDEX row does not name $h_1$ at the operator level as untyped.
