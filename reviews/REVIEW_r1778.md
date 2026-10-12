# REVIEW r1778: L219Prod.lean (ee95af03) and L219Diag.lean's n − 1 clause (cb9b3a68)

| Claim | Verdict | Reason |
|---|---|---|
| `foxProd2` is the record's $x\circ y$ and `Qop2 x` is $x\circ x$ | CONFIRMED | `foxProd2` is the polarisation of $Q$, which is the record's definition by L209, and `foxProd2_self` gives $x\circ x=Q(x)$ |
| `innerOp2_sig_left` | CONFIRMED | one rewrite of `innerOp2_sig` at `sig m S` followed by `sig_sig` |
| `sharp_sig` | CONFIRMED | the duality uses only hypothesis-free lemmas and closes by `eq_of_innerOp2` |
| `Qop2_sig` | CONFIRMED | $\sigma$ distributes over composition (`sig_comp`) and commutes with `#` |
| `Qop2_add`, `Qop2_sub` | CONFIRMED | the first is the definition of `foxProd2` rearranged, the second adds `Qop2_smul` at $-1$ |
| `L219_ops` | CONFIRMED | exactly the record's two operator identities at a coordinate reflection, with no hidden hypothesis, and valid on all of `CurvOp2` |
| `act_neg_one`, `act_diag_set_fix` | CONFIRMED | $(-1)R(Z)(-1)=R(Z)$, and induction over the set with `act_comp` |
| `sig_of_others` | CONFIRMED | $\mathrm{flip}_{k_0}=(-I)\cdot\mathrm{diagSet}(\mathrm{univ}\setminus k_0)$ holds entrywise, and it is the record's "last reflection redundant" |
| `diagonal_iff_even_but_one` | CONFIRMED | reduces to `diagonal_iff_even` by `sig_of_others` |
| lean/INDEX.md "L219 (statement)" row | CONFIRMED WITH OBSERVATIONS | accurate and its Owed list is right, but r1777 O2's double space survives |

**Summary:** both commits prove what they claim, with standard axioms, and `L219_ops` is slightly stronger than the record since it holds off $\mathcal W_n$. Two cosmetic observations remain.

## 1. Is `foxProd2` the record's product, and is `Qop2 x = x∘x`?

- [FirstVariation.lean:57](../lean/HamiltonsCubic/Results/FirstVariation.lean#L57) defines `foxProd2 X Y := (1/2) • (Qop2 (X + Y) - Qop2 X - Qop2 Y)`.
- [Bivectors2.lean:825](../lean/HamiltonsCubic/Base/Bivectors2.lean#L825) defines `Qop2 R := compOp2 R + sharpMapCL R`, which is $R^2+R^\#$.
- The record's product is the polarisation of $Q$. L209 in [curvature-invariants.md](../findings/curvature-invariants.md) states: "$Q(\mathcal W_n)\subseteq\mathcal W_n$ and, by polarisation, $X,Y\in\mathcal W_n\Rightarrow X\circ Y\in\mathcal W_n$". So on $\mathcal W_n$ the record's $x\circ y$ is `foxProd2 x y`, with no projection needed.
- `foxProd2_self` ([L24Eigen.lean:48](../lean/HamiltonsCubic/Results/L24Eigen.lean#L48)) gives `foxProd2 v v = Qop2 v` for every `v`. The record's $b\circ b+c\circ c$ is therefore `Qop2 b + Qop2 c`, as `L219_ops` writes it.
- Answer: yes on both counts.

## 2. Is `sharp_sig`'s duality sound?

- Goal after `eq_of_innerOp2`: for every `S`, `innerOp2 S (sharpMapCL (sig m R)) = innerOp2 S (sig m (sharpMapCL R))`.
- `← innerOp2_sig_left` turns the right side into `innerOp2 (sig m S) (sharpMapCL R)`. `innerOp2_sig_left` itself is `innerOp2_sig` at `(sig m S, X)` plus `sig_sig`, which is sound since `sig m` is an involution ([L219Op.lean:112](../lean/HamiltonsCubic/Results/L219Op.lean#L112)).
- `innerOp2_sharpMap_eq_phiTri` ([PhiTri.lean:317](../lean/HamiltonsCubic/Results/PhiTri.lean#L317)) carries no hypothesis, so both sides become $-\tfrac12\Phi(S;\sigma R,\sigma R)$ and $-\tfrac12\Phi(\sigma S;R,R)$.
- `← phiTri_sig m (sig m S) R R` rewrites the second as $-\tfrac12\Phi(\sigma\sigma S;\sigma R,\sigma R)$, and `sig_sig` closes.
- `phiTri_sig` ([L219Op.lean:139](../lean/HamiltonsCubic/Results/L219Op.lean#L139)) and `innerOp2_sig` ([L219Op.lean:129](../lean/HamiltonsCubic/Results/L219Op.lean#L129)) are unconditional. Neither needs self-adjointness or Bianchi.
- `eq_of_innerOp2` ([L24Eigen.lean:34](../lean/HamiltonsCubic/Results/L24Eigen.lean#L34)) is nondegeneracy through `normSq2_eq_zero`. That is the right tool for identifying two operators.
- Answer: sound.

## 3. Is `L219_ops` the record's pair exactly, with no hidden hypothesis?

- Record, Lemma L219 in [second-order.md](../findings/second-order.md): "*If $W$ is a critical point, $Q(W)=\theta W$, then* $b\circ b+c\circ c=\theta b,\ 2\,b\circ c=\theta c$". Proof step 2: "$Q(W)=b\circ b+c\circ c+2\,b\circ c$, whose even part is $b\circ b+c\circ c$ and odd part $2\,b\circ c$".
- `#check` output: the only hypothesis is `Qop2 W = θ • W`. The conclusions are `Qop2 b + Qop2 c = θ • b` and `2 • foxProd2 b c = θ • c`, with `b`, `c` being `(1/2) • (W ± sig m W)`. With question 1, that is the record's pair verbatim at $u=e_m$.
- The Lean proof takes a different route from the record. It uses $Q(b\pm c)=Q(b)+Q(c)\pm2\,b\circ c$ and $Q(b-c)=Q(\sigma W)=\sigma Q(W)=\theta\sigma W$, then adds and subtracts. The record uses the parity split of $Q(W)$ instead. Both need only that $\sigma$ commutes with $Q$ and is linear, which `Qop2_sig` supplies on all of `CurvOp2`.
- Dropping the Weyl and self-adjoint hypotheses is right. `sig_comp`, `sharp_sig` and `Qop2_sig` hold for every bounded operator on $\Lambda^2$, so the lemma generalises the record's statement rather than weakening it. The record's restriction to $\mathcal W_n$ matters only for reading `foxProd2` as the record's $\circ$ (question 1), and `even_odd_isWeyl2` places $b,c$ in $\mathcal W_n$ when $W$ is Weyl.
- Checked: `Qop2_add` is `unfold foxProd2; module`, true by the definition. `Qop2_sub` writes $x-y=x+(-1)y$ and uses `Qop2_smul` ($(-1)^2=1$) and `foxProd2_smul_right`. Both are hypothesis-free, and the axiom output confirms `Qop2_sub` is clean.
- Scope: coordinate reflection $u=e_m$ only. The general unit $u$ stays on the Owed list.

## 4. Is `sig_of_others` sound, and is it the record's statement?

- `hflip`: $\mathrm{diagSet}(\mathrm{univ})\cdot\mathrm{diagSet}(\mathrm{univ}\setminus\{k_0\})$ is diagonal with entry $(-1)(1)=-1$ at $k_0$ and $(-1)(-1)=1$ elsewhere. `Results.flip k0` has exactly those entries. Proved entrywise by `diagonal_mul_diagonal` and a case split.
- `hU`: $\mathrm{diagSet}(\mathrm{univ})=-I$, entrywise. Correct.
- `act_neg_one`: $(-1)\,R((-1)^{\mathsf T}Z(-1))\,(-1)^{\mathsf T}=R(Z)$. This holds for every linear `R` on matrices, Weyl or not, and so is stronger than "on $\mathcal W_n$".
- `act_diag_set_fix`: induction with $\mathrm{diagSet}(\{a\}\cup s)=\mathrm{flip}_a\cdot\mathrm{diagSet}(s)$ for $a\notin s$, and `act_comp` ($\mathrm{act}\,g\circ\mathrm{act}\,h=\mathrm{act}(gh)$, [WeylTraceZero.lean:21](../lean/HamiltonsCubic/Results/WeylTraceZero.lean#L21)). Sound.
- Main chain: $\mathrm{act}(\mathrm{flip}_{k_0})=\mathrm{act}(-I)\circ\mathrm{act}(\mathrm{diagSet}(\mathrm{univ}\setminus k_0))$ fixes `extendL V`. `hasChar_of_sig`/`sig_of_hasChar` then transfer between `sig` and `act` on the extension. `sig_of_others` needs no Weyl hypothesis, which is correct because $-I$ acts trivially on every operator by conjugation.
- Edge cases: `k0 : Fin n` forces $n\ge1$. At $n=1$ the erased set is empty, `diagSet ∅ = 1` is handled in the base case, and `flip k0 = -I`. Nothing breaks.
- Record: "the last reflection being redundant since $-I$ acts trivially on $\mathcal W_n$", and proof step 3: "$\sigma_{e_1}\cdots\sigma_{e_n}=-I$ acts trivially, so $n-1$ of them suffice". `diagonal_iff_even_but_one` takes an arbitrary omitted index $k_0$, which includes the record's $k_0=n$. It is the record's statement, generalised in which index is dropped.

## 5. Axioms

`lake env lean` on a scratch file importing `HamiltonsCubic.Results.L219Prod`, exit 0 (oleans at 05:28 are newer than both sources, and the working tree matches HEAD for both files):

```
'HamiltonsCubic.L219Prod.L219_ops' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L219Prod.sharp_sig' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L219Prod.Qop2_sig' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L219Prod.Qop2_sub' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L219Diag.diagonal_iff_even_but_one' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L219Diag.sig_of_others' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The output contains no `sorryAx`, `native_decide` or `Lean.ofReduceBool`.

## 6. The lean/INDEX.md "L219 (statement)" row

- The operator-identities clause names `sharp_sig`, `Qop2_sig` and `L219_ops`, the duality via `phiTri_sig`, the expansion $Q(b\pm c)$ and "standard three axioms". It matches the code.
- The $n-1$ clause names `sig_of_others`, `diagonal_iff_even_but_one` and `act_neg_one`, with $\mathrm{flip}_{k_0}=(-I)\prod_{k\ne k_0}\mathrm{flip}_k$. It matches the code. "Gate 2 r1777, O1 discharged" is accurate: r1777 O1 asked for exactly this.
- Owed list: "$\langle b\circ b,c\rangle=0$ exported at $\mathcal W_n$; a general unit $u$ (frame rotation); and $\lVert c_u\rVert^2\le\tfrac34$ beyond its arithmetic". All three are still untyped, and nothing else the record claims is untyped:
  - the split and $P(c)=0$ are `L219_op`;
  - the operator identities are `L219_ops`;
  - the diagonality clause and its $n-1$ form are in L219Diag.lean.
  The "orthonormal frame" of the diagonality clause is covered by "in the coordinate frame" plus the frame-rotation item.
- **O1 (cosmetic).** r1777 O2 had two parts. The four asterisks were repaired. The double space before "**The reflection preserves $\mathcal W_n$, PROVED**" (after "`hmax`.*") is still there.
- **O2 (cosmetic).** The module docstring of [L219Diag.lean](../lean/HamiltonsCubic/Results/L219Diag.lean) still quotes the record as "vanishes for every $k$". The record reads "for $k=1,\dots,n-1$". That was the second half of r1777 O1. The docstring's new `sig_of_others` bullet now states the $n-1$ form, so nothing is misstated about the code, but the quotation of the record remains inexact.

## 7. Falsifiers and the search for them

- **`sharp_sig`/`Qop2_sig`:** a `CurvOp2` $R$ and index $m$ with $(\sigma R)^\#\ne\sigma(R^\#)$. That would need `phiTri_sig` or `innerOp2_sig` to fail. I read both statements and the proof chain in question 2. No numerics were run, because the kernel settles it.
- **`L219_ops`:** a $W$ with $Q(W)=\theta W$ whose parts violate either identity. Its existence would contradict `Qop2_sig` together with the linear algebra of `Qop2_add`/`Qop2_sub`. I checked the `#check` signature for a hidden hypothesis and found none.
- **`sig_of_others`:** an $n$ and $k_0$ where the product $\prod_{k\ne k_0}\mathrm{flip}_k$ is not $-\mathrm{flip}_{k_0}$, or an operator moved by conjugation by $-I$. Neither exists: the first is an entrywise diagonal identity, the second holds because $(-1)^2=1$. I checked the $n=1$ edge case by hand.
- **`diagonal_iff_even_but_one`:** a Weyl $V$ fixed by every flip but $k_0$ yet not diagonal. That would refute `sig_of_others` or `diagonal_iff_even`, the latter confirmed at r1777.
- **Faithfulness:** a record reading of $\circ$ that differs from `foxProd2`, for example a projected product. L209's closure $X\circ Y\in\mathcal W_n$ rules that out.
- No screen was run. None was needed, because every claim is kernel-checked and the question was faithfulness, which is settled by reading.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.**
- The mathematics of both commits is confirmed.
- O1: r1777's double space survives in the INDEX row.
- O2: L219Diag.lean's module docstring still quotes the record's range as "every $k$".
