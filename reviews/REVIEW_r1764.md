# REVIEW r1764: L260Sub.lean and gopC_range, L260 (4) at a proper h and (2)'s semisimple clause

**Standfirst.** Cold Gate 2 reading of [L260Sub.lean](../lean/HamiltonsCubic/Results/L260Sub.lean) and the `gopC_range` addition to [CompactSemisimple.lean](../lean/HamiltonsCubic/Results/CompactSemisimple.lean) at commit 464df289, with the [lean/INDEX.md](../lean/INDEX.md) rows L260 and L263 as edited in e3f5a08b, against [findings/second-order.md](../findings/second-order.md) Lemma L260. Statement fidelity only, the kernel having checked the proofs. Analysis-only footing: every identification below is derived by hand from the definitions. One small check file ran (`#print axioms` on four theorems and one `#check`), reported as a kernel check.

**Summary.** Every statement says what the record needs: `Kh` is exactly the diagonal of the record's $K$ in $C$'s eigenbasis, in the record's normalisation ($K=n-2=c$ on $\mathfrak{so}(n)$), the conclusion is $\operatorname{tr}(CK)\le d$, the hypotheses are equivalent to "self-adjoint positive-semidefinite idempotent", and all four theorems rest on the standard three axioms. The observations concern prose left between the typed objects and the record's operators, and one stale phrase in the INDEX row.

## Claim table

| Claim | Verdict |
|---|---|
| `pairing_gen`: cyclic $c\ge0$ supported on positive triples gives $\sum_k\lambda_k\cdot\tfrac12\sum_{i,j}c_{ijk}\le\tfrac12\sum c_{ijk}\lambda_i\lambda_j/\lambda_k$ (Q3) | CONFIRMED |
| `pairing_gen` reduces to `trace_le_of_pairing` at constant rows and all $\lambda>0$ (Q3) | CONFIRMED |
| `wB`, `Kh`: $K_k=\tfrac12\sum_{i,j\in S}\langle b_i,[b_k,b_j]\rangle^2$ is $\langle Kb_k,b_k\rangle$ for the record's $K=\bigoplus_ic_i\Pi_i$ of $\mathfrak h=\operatorname{range}C$ (Q1) | CONFIRMED (O1) |
| `L260_four_sub`: $\sum_k\lambda_kK_k\le\#\{\lambda_k>0\}$ is L260 (4)'s inequality $\operatorname{tr}(CK)\le d$ at every positive-definite idempotent on a subalgebra of $\mathfrak{so}(n)$ (Q2) | CONFIRMED (O1, O2) |
| `L260_two_semisimple`: the range of a self-adjoint PSD idempotent is semisimple, L260 (2)'s semisimple clause (Q4) | CONFIRMED |
| `gopC_range`: range (gop lamC) = span gv, the join r1763 O2 asked for (Q4) | CONFIRMED (O3) |
| `#print axioms` on `pairing_gen`, `L260_four_sub`, `L260_two_semisimple`, `gopC_range` (Q5) | CONFIRMED: propext, Classical.choice, Quot.sound |
| Objects meeting `L260_four_sub`'s hypotheses (Q6) | CONFIRMED: $C=0$, $C=I/(n-2)$, the L263 witness |
| INDEX rows L260 and L263 as edited in e3f5a08b (Q7) | CONFIRMED WITH OBSERVATIONS (O4) |

## The record

L260 (2), quoted: *"(2) The range of a PSD idempotent is a semisimple subalgebra $\mathfrak h$, on which it is a positive-definite idempotent of $\mathfrak h$'s own $\#$."*

L260 (4), quoted: *"(4) Every positive-definite idempotent satisfies $\operatorname{tr}(CK)\le d$, $K=\bigoplus_ic_i\Pi_i$, with equality exactly at $\bigoplus_i\Pi_i/c_i$."* Here $\Pi_i\#\Pi_i=c_i\Pi_i$ (from (3)).

Proof of (4), quoted: *"(4) Pair $C\#C=C$ with $C^{-1}$ in $C$'s eigenframe, symmetrise each triple, use $\frac{xy}z+\frac{yz}x+\frac{zx}y\ge x+y+z$ and the row sums $\sum_{i,j}\langle[u_i,u_j],u_k\rangle^2=2\langle Ku_k,u_k\rangle$. Equality forces the eigenvalues constant on bracket-connected triples, which on each simple ideal connect everything."*

## Q1: Kh is the record's Casimir diagonal

- Orientation. `wB b i j k` $=\langle b_i,[b_k,b_j]\rangle^2$. By invariance of the trace form (`ad_skewAdjoint`, used in the proof as `hcyc0`) this equals $\langle[b_i,b_j],b_k\rangle^2$, the summand of the record's row sum.
- Normalisation. The record fixes $K$ by $\sum_{i,j}\langle[u_i,u_j],u_k\rangle^2=2\langle Ku_k,u_k\rangle$, which is `Kh`'s factor $\tfrac12$. At $\mathfrak h=\mathfrak{so}(n)$, `casimir_row` gives $\sum_{\beta,\gamma}\langle b_\beta,[b_\delta,b_\gamma]\rangle^2=2(n-2)$, the same index pattern as `wB` at $k=\delta$, so $K_k=n-2$. `sharpMapCL_id` gives $I\#I=(n-2)I$, so $c=n-2$ and $K=cI$, the record's $K$ on a simple $\mathfrak h$.
- The record's $K$ in general. By `sharp_rk1_sum`, $P_{\mathfrak h}\#P_{\mathfrak h}=\tfrac12\sum_{i,j\in S}|[b_i,b_j]\rangle\langle[b_i,b_j]|$ for any orthonormal basis $\{b_i\}_{i\in S}$ of $\mathfrak h$, so its diagonal entry at $b_k$ is exactly $\tfrac12\sum_{i,j\in S}\langle b_i,[b_k,b_j]\rangle^2=K_k$, with no closure hypothesis. In an ideal-adapted orthonormal basis of a compact semisimple $\mathfrak h$ (ideals orthogonal under the invariant form) the cross brackets vanish and $P_{\mathfrak h}\#P_{\mathfrak h}=\sum_i\Pi_i\#\Pi_i=\bigoplus_ic_i\Pi_i$. Both sides are basis-free, so $K=P_{\mathfrak h}\#P_{\mathfrak h}$ and $K_k=\langle Kb_k,b_k\rangle$ in every basis.
- With closure. When $\mathfrak h$ is closed under the bracket (L260 (2), `L260_range_subalgebra`), $[b_k,b_j]\in\mathfrak h$ for $j\in S$, so $\sum_{i\in S}\langle b_i,[b_k,b_j]\rangle^2=\lVert[b_k,b_j]\rVert^2$ and $K_k=\tfrac12\sum_{j\in S}\lVert[b_k,b_j]\rVert^2$. That is half of $\langle-\sum_j\mathrm{ad}_{b_j}^2b_k,b_k\rangle$, the Casimir of $\mathfrak h$ for the trace form, so the record's $K$ is half the textbook Casimir, consistent with $2(n-2)$ versus $n-2$ at $\mathfrak{so}(n)$.
- The mask on $k$ in `Kh` sets $K_k=0$ at $\lambda_k=0$, where $K_k$ is multiplied by zero, so it is harmless.

## Q2: the sum is tr(CK) and the hypotheses are general enough

- $C$ is diagonal in the orthonormal basis $b$, so $\operatorname{tr}(CK)=\sum_k\langle KCb_k,b_k\rangle=\sum_k\lambda_k\langle Kb_k,b_k\rangle=\sum_k\lambda_kK_k$.
- $b$ is an orthonormal eigenbasis, so $\operatorname{range}C=\operatorname{span}\{b_k:\lambda_k\ne0\}$ and, with $\lambda\ge0$, $d=\dim\operatorname{range}C=\#\{\lambda_k>0\}$.
- An orthonormal eigenbasis with real eigenvalues makes $C$ self-adjoint, and $\lambda\ge0$ makes it PSD, so the theorem needs no separate `hC`. Conversely every self-adjoint PSD idempotent has such a basis by the spectral theorem. The hypothesis set is therefore exactly "self-adjoint PSD `#`-idempotent of $\mathfrak{so}(n)$, with a chosen eigenbasis" (O2 on the choice).
- Against the record's "positive-definite idempotent on $\mathfrak h$": by L260 (2) every PSD idempotent is one on its range, and a positive-definite idempotent of $\mathfrak h$'s own `#`, extended by zero, is a PSD idempotent of $\mathfrak{so}(n)$ because $\mathfrak h$'s `#` is $\mathfrak{so}(n)$'s restricted (`sharp_rk1_sum`, the reading L263's row already leaves to the record). So the theorem covers the record's inequality on every compact semisimple subalgebra of $\mathfrak{so}(n)$, which is the scope (3) sets.
- The proof's `hdiag` is `sharpBil2_eigen` read on the diagonal, $\lambda_k=\tfrac12\sum_{i,j}\lambda_i\lambda_jw_{ijk}$, and `hmask` drops the kernel terms because they carry a factor $\lambda_i\lambda_j=0$. Nothing in the statement depends on positivity off the range.

## Q3: pairing_gen

- The statement is the record's pairing: after cyclic symmetrisation, each positive triple gives $\lambda_i+\lambda_j+\lambda_k\le\frac{\lambda_i\lambda_j}{\lambda_k}+\frac{\lambda_j\lambda_k}{\lambda_i}+\frac{\lambda_k\lambda_i}{\lambda_j}$ (`three_ratio`), and by cyclicity each of the three sums $\sum c_{ijk}\lambda_i$, $\sum c_{ijk}\lambda_j$, $\sum c_{ijk}\lambda_k$ equals $\sum_k\lambda_k\sum_{i,j}c_{ijk}$, as do the three ratio sums. The support hypothesis `hlam` is exactly what makes the ratios meaningful, and the conclusion is the ungraded form with row sums varying in $k$.
- Reduction. With `hrow : ∀ k, ∑ i, ∑ j, c i j k = 2 * γ` and `∀ k, 0 < lam k`, `pairing_gen`'s support hypothesis holds trivially and its left side is $\sum_k\lambda_k\gamma=\gamma\sum_k\lambda_k$, which is `trace_le_of_pairing`'s left side. The remaining hypotheses (`hc`, `hcyc`, `hpair`) are identical. So `trace_le_of_pairing` is the constant-row, full-support instance.

## Q4: L260_two_semisimple and gopC_range

- `L260_two_semisimple` takes self-adjoint, PSD and idempotent $C$ and returns the bracket closure of $\operatorname{range}C$ together with Mathlib's `LieAlgebra.IsSemisimple ℝ (lieOf _ hbr)`, through `L260_range_subalgebra`'s span equality and `isSemisimple_perfect` (confirmed in r1763). That is (2)'s semisimple clause at every PSD idempotent. The clause "on which it is a positive-definite idempotent of $\mathfrak h$'s own `#`" is `L260_range_subalgebra`'s third conjunct, dropped here by `-`, and stays typed there. At $C=0$ the range is zero, and the zero Lie algebra is semisimple in Mathlib's sense, which matches the record's convention.
- `gopC_range`: the inclusion $\subseteq$ is `gop_expand` (every image is a combination of the $g_k$), and $\supseteq$ is `C_gv` with the nonzero eigenvalues $\tfrac9{28}$, $\tfrac3{28}$. `L263_witness` states its idempotent as `gop lamC` and `L263_semisimple` is over `span ℝ (Set.range gv)`, so the theorem joins the two statements in one equation: the witness's range is the semisimple $\mathfrak h$. That closes r1763 O2 in substance (O3 on form).

## Q5: axioms

`#print axioms` on `HamiltonsCubic.L260Sub.pairing_gen`, `HamiltonsCubic.L260Sub.L260_four_sub`, `HamiltonsCubic.L260Sub.L260_two_semisimple` and `HamiltonsCubic.CompactSemisimple.gopC_range`, each: `[propext, Classical.choice, Quot.sound]`. `#check` confirmed the signature quoted in Q2 (no `IsSelfAdjoint2` hypothesis, eigenbasis and `0 ≤ lam β` as data). Kernel check, exit 0.

## Q6: objects meeting L260_four_sub's hypotheses

- $C=0$ with any orthonormal basis: `IsIdem 0` since $0\#0=0$, $\lambda\equiv0$. It gives $0\le0$.
- $C=I/(n-2)$, $n\ge3$, with any orthonormal basis of $\mathfrak{so}(n)$: idempotent by `idem_Ic`, $\lambda\equiv1/(n-2)>0$, `Kh` $=\tfrac12\cdot2(n-2)=n-2$ by `casimir_row`. It gives $\sum_k1=N\le N$, the equality case, matching `L260_trace_bound` and `L260_trace_eq_iff`.
- L263's witness $C=\tfrac9{28}P_{\mathfrak{su}(3)}+\tfrac3{28}P_{\mathfrak p}$ on $\mathfrak h=\mathfrak g_2\subset\mathfrak{so}(7)$, with the normalised $g_k$ completed by an orthonormal basis of $\mathfrak h^\perp$ (eigenvalue 0): $K=P_{\mathfrak h}\#P_{\mathfrak h}=4P_{\mathfrak h}$ by `L263_witness`, so $K_k=4$ on $\mathfrak h$. It gives $4\operatorname{tr}C=4(8\cdot\tfrac9{28}+6\cdot\tfrac3{28})=\tfrac{90}7<14=d$, strict, consistent with (4)'s equality holding only at $P_{\mathfrak h}/4$. This is the first instance the theorem covers that `L260_trace_bound` could not, since the rows are masked to a proper $\mathfrak h$.

## Q7: the INDEX rows

- L260: the new sentence "(4) at a proper $\mathfrak h$ is PROVED for the inequality ... the equality case at a proper $\mathfrak h$ is prose, and at $\mathfrak{so}(n)$ both halves are typed" is accurate, and the file list adds L260Sub.lean. The earlier sentence "(4) is typed at $\mathfrak{so}(n)$ and prose at a proper semisimple $\mathfrak h$" is correctly removed. The row's italic opening still reads "every typed clause proved, (1) at every $X$ and (4) at $\mathfrak h=\mathfrak{so}(n)$", which now understates (4) (O4). **partial** remains the right status, the equality case at a proper $\mathfrak h$ being prose.
- L263: "it is the witness's range (`gopC_range`)" and the r1763 citation are accurate.
- The record's L260 provenance (ec886f2c) names `L260_two_semisimple`, `L260_four_sub` and `pairing_gen` in terms that match the theorems.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.**

1. **O1, $K$ is typed as a diagonal, the operator identification is prose.** `Kh` is the diagonal of $P_{\mathfrak h}\#P_{\mathfrak h}$ in $C$'s eigenbasis, and that operator is the record's $\bigoplus_ic_i\Pi_i$ (Q1). Neither link is a Lean statement, so "which is $\operatorname{tr}(CK)\le d$" in the docstring and the INDEX row is a correct reading carried in prose. A one-line corollary `Kh b lam k = sharpBil2 P P (ofSk (b k)) (ofSk (b k))` for $P$ the projection with eigenvalues $\mathbf 1[\lambda>0]$ would follow from `sharpBil2_eigen` and make the Casimir identification a statement.
2. **O2, the eigenbasis is a hypothesis.** `L260_four_sub` takes $b$ and $\lambda$ as data. The form "every self-adjoint PSD idempotent satisfies $\operatorname{tr}(CK)\le\operatorname{rank}C$" needs the spectral theorem step (the `opSk` route that `L260_psd_cone` already uses) composed in front. Harmless for fidelity, since such a basis always exists.
3. **O3, the L263 join goes through the witness.** r1763 O2 suggested restating `L263_g2` with $\mathfrak h:=\operatorname{span}(gv)$. `gopC_range` instead identifies the range of `L263_witness`'s explicit idempotent with `L263_semisimple`'s subalgebra, which settles the same question, and `L263_g2`'s existential form stays unjoined.
4. **O4, the L260 row's opening is stale.** "(1) at every $X$ and (4) at $\mathfrak h=\mathfrak{so}(n)$" should read "(4)'s inequality at every PSD idempotent, its equality case at $\mathfrak{so}(n)$".

## Falsifiers

| Statement | The object that would falsify it |
|---|---|
| `pairing_gen` | a cyclic $c\ge0$, supported on triples of positive $\lambda$'s, with $\sum_k\lambda_k\cdot\tfrac12\sum_{i,j}c_{ijk}>\tfrac12\sum c_{ijk}\lambda_i\lambda_j/\lambda_k$ |
| `L260_four_sub` | a `#`-idempotent of $\mathfrak{so}(n)$ with an orthonormal eigenbasis, $\lambda\ge0$, and $\operatorname{tr}(C\,P_{\mathfrak h}\#P_{\mathfrak h})>\operatorname{rank}C$ |
| `L260_two_semisimple` | a self-adjoint PSD idempotent whose range carries a nonzero abelian ideal |
| `gopC_range` | an $X$ with `gop lamC X` outside $\operatorname{span}(gv)$, or some $g_k$ with eigenvalue 0 under `gop lamC` |
| Q1's identification | a compact semisimple $\mathfrak h\subset\mathfrak{so}(n)$ and $b_k\in\mathfrak h$ with $\tfrac12\sum_{i,j\in S}\langle b_i,[b_k,b_j]\rangle^2\ne\langle(\bigoplus_ic_i\Pi_i)b_k,b_k\rangle$ |
