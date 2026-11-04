# REVIEW r1759: L264Cross.lean (L264 (2) with the cross block), against the record

**Verdict: CONFIRMED WITH OBSERVATIONS.** `L264_cross` states L264 (2) on every split $\mathfrak h=\mathfrak h_1\oplus\mathfrak h_2$ into two orthogonal commuting ideals inside $\mathfrak{so}(n)$, for every cross block, and under a weaker hypothesis than the record's (both diagonal blocks nonzero in place of positive definiteness). `sharp_blk` is the record's $C\#D_i=D_i$ in `Ftri`'s normalisation, and the direction $H=\lVert D_2\rVert^2D_1-\lVert D_1\rVert^2D_2$ is the record's "$\mathop{\mathrm{span}}(D_1,D_2)$ meets $C^\perp$". Both theorems carry only the standard three axioms. The hypotheses are jointly satisfiable, with and without a cross block. The observations concern prose steps the header and INDEX row leave unnamed, one stale clause in the INDEX row, and two redundant hypotheses.

Targets: [L264Cross.lean](../lean/HamiltonsCubic/Results/L264Cross.lean) (commit 26f02ba2), the definitions `Ftri`, `IsIdem`, `IsStable`, `Ftri_idem`, `Ftri_symm12`, `Ftri_symm23`, `coordOp`, `starW`, `isIdem_coordOp_iff` in [I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean), and the L264 row of [lean/INDEX.md](../lean/INDEX.md) as edited in 26f02ba2. Source: [findings/second-order.md](../findings/second-order.md), Lemma L264. Footing: analysis only. The one computation was a small check file run with `lake env lean` against the built oleans (`#print axioms` on two theorems and one idempotency check on `Fin 6`), seconds in length, deleted afterwards.

| Claim | Verdict |
| --- | --- |
| Q1(a). "Range closed under bracket" plus $[\mathfrak h_1,\mathfrak h_2]=0$ encodes "$\mathfrak h_1$, $\mathfrak h_2$ ideals of $\mathfrak h=\mathfrak h_1\oplus\mathfrak h_2$" | CONFIRMED |
| Q1(b). "Both blocks nonzero" in place of positive definiteness on $\mathfrak h$ | CONFIRMED (a weakening of the hypothesis, so a stronger theorem) |
| Q1(c). $P_1P_2=0$ (orthogonal ideals) is justified for ideals of a compact semisimple $\mathfrak h$ under the trace form | CONFIRMED |
| Q1(d). Nothing too strong or missing | CONFIRMED WITH OBSERVATIONS (O1, O3) |
| Q2. `sharp_blk` is $C\#D_i=D_i$ | CONFIRMED |
| Q3. The split into two orthogonal commuting ideals is the only remaining step | REFUTED AS STATED (O1) |
| Q4. $H=\lVert D_2\rVert^2D_1-\lVert D_1\rVert^2D_2$ realises "$\mathop{\mathrm{span}}(D_1,D_2)$ meets $C^\perp$" | CONFIRMED |
| Q5. Axioms of `L264_cross` and `sharp_blk` | CONFIRMED, `propext`, `Classical.choice`, `Quot.sound` |
| Q6. The hypotheses are jointly satisfiable | CONFIRMED, $\mathfrak{so}(3)\oplus\mathfrak{so}(3)\subset\mathfrak{so}(6)$ with $C=P_1+P_2$ (kernel-checked idempotent), and $\mathfrak{so}(4)=\Lambda^2_+\oplus\Lambda^2_-$ with $C=\Pi_{\mathfrak{so}(3)}$ for $E\ne0$ |
| Q7. INDEX L264 row as edited | CONFIRMED WITH OBSERVATIONS (O2) |

One line: the theorem says what the record's (2) says and more, and the gaps are two unnamed prose steps and a stale clause in the INDEX row.

## The record

- **L264 Statement (2), verbatim:** *"On a compact semisimple $\mathfrak h$ with two or more simple ideals, no positive-definite idempotent is stable."*
- **L264 Proof (2), verbatim:** *"Write $C=D_1+D_2+E$ over $\mathfrak h=\mathfrak h_1\oplus\mathfrak h_2$ with $E$ the cross block. $\mathrm{ad}$ kills $\mathfrak h_1\wedge\mathfrak h_2$, so $(C\#C)_{\mathfrak h_i\mathfrak h_i}=D_i\#D_i$ and $C\#D_i=D_i$: each $D_i$ is an eigenvector of eigenvalue $1$, and $\mathop{\mathrm{span}}(D_1,D_2)$ meets $C^\perp$."*
- **L264 Statement (1), the stability notion:** *"stable: $\langle C\#H,H\rangle\le\tfrac12\lVert H\rVert^2$ for every $H\perp C$."*

## Q1: the hypotheses

- **Ideals.** With $\mathfrak h=\mathop{\mathrm{range}}(P_1+P_2)$ and $P_1P_2=P_2P_1=0$, `b₁`, `b₂` and `c₁₂` give $[\mathfrak h,\mathfrak h_1]=[\mathfrak h_1,\mathfrak h_1]+[\mathfrak h_2,\mathfrak h_1]\subseteq\mathfrak h_1$, and likewise for $\mathfrak h_2$, so each range is an ideal of $\mathfrak h$ and $\mathfrak h$ is a subalgebra of $\mathfrak{so}(n)$. Conversely two ideals with $\mathfrak h_1\cap\mathfrak h_2=0$ satisfy $[\mathfrak h_1,\mathfrak h_2]\subseteq\mathfrak h_1\cap\mathfrak h_2=0$. So the three bracket hypotheses are exactly "ideals of $\mathfrak h=\mathfrak h_1\oplus\mathfrak h_2$". Ideals of $\mathfrak h$, which is what the record means, and ideals of $\mathfrak{so}(n)$ would be far too strong: the hypotheses correctly ask for the former.
- **Orthogonality.** The trace form of $\mathfrak{so}(n)$ is $\mathrm{ad}$-invariant, so its restriction to $\mathfrak h$ is $\mathfrak h$-invariant. For a semisimple ideal $\mathfrak h_1=[\mathfrak h_1,\mathfrak h_1]$ and $c\in\mathfrak h_2$, $\langle[a,b],c\rangle=\langle a,[b,c]\rangle=0$, so $\mathfrak h_1\perp\mathfrak h_2$. Hence $P_1$, $P_2$ are the orthogonal projections and `s₁`, `s₂`, `o₁₂`, `o₂₁` are consequences of the setting, never an extra assumption.
- **Positive definiteness.** A positive-definite $C$ on $\mathfrak h$ has $D_i=P_iCP_i$ positive definite on $\mathfrak h_i\ne0$, hence nonzero. The Lean hypothesis `h₁`, `h₂` is weaker, so the theorem is stronger than the record's (2). It reaches PSD idempotents with a cross block (Q6), which the record's (2) does not claim. The record's proof uses nothing beyond the blocks being nonzero, so the strengthening is sound and could be written into the record.
- **Support.** `hCQ` and `hQC` say $C=CQ=QC$, $Q=P_1+P_2$, which is "$C\in\mathop{\mathrm{Sym}}^2\mathfrak h$" for self-adjoint $C$.
- **Redundancy (O3).** `o₂₁` follows from `o₁₂` with `s₁`, `s₂` ($\langle P_2P_1X,Y\rangle=\langle X,P_1P_2Y\rangle=0$), and `hQC` follows from `hCQ` with `hC`. Harmless.

## Q2: sharp_blk

`IsIdem C` is `sharpMapCL C = C`, and `Ftri_idem` gives $F(C,C,Y)=\langle Y,C\rangle$, so `Ftri` is the trilinear form whose diagonal in the first two slots is $\langle C\#C,\cdot\rangle$. By polarisation $F(C,D,Y)=\langle C\#D,Y\rangle$ for the symmetric bilinear $\#$ with the same normalisation, and $C\#D$ is self-adjoint, so "$F(C,D_1,Y)=\langle Y,D_1\rangle$ for every self-adjoint $Y$" is $C\#D_1=D_1$. It is also exactly the form `IsStable` uses ($F(C,H,H)$ against $\tfrac12\lVert H\rVert^2$), so "eigenvalue $1$" is read in the operator stability tests. The route (`chainY`, `chainY1`, `inner_move`) differs from the record's blockwise $(C\#C)_{\mathfrak h_i\mathfrak h_i}=D_i\#D_i$ and reaches the same identity.

## Q3: what stays between L264_cross and the record's (2)

The header names one step, the split of a compact semisimple $\mathfrak h$ into two orthogonal commuting ideals. That step is standard (the decomposition into simple ideals, with orthogonality as in Q1). Three further readings are needed and are unnamed or named only in passing:

1. **PD implies both blocks nonzero.** The header states it as a fact. It is one line, but it is prose.
2. **$\mathfrak h$ sits inside $\mathfrak{so}(n)$ with the restricted trace form, and $\#$ is the ambient one.** The record's (2) is on an abstract compact semisimple $\mathfrak h$ with its own $\#$. The Lean reads it on a subalgebra of $\mathfrak{so}(n)$ with $\mathfrak{so}(n)$'s $\#$, which agrees with $\mathfrak h$'s own on $\mathop{\mathrm{Sym}}^2\mathfrak h$ (the record's (1) proof: "$\mathop{\mathrm{Sym}}^2\mathfrak h$ is closed under $\#$"). For the use in (3), where $\mathfrak h\subseteq\mathfrak{so}(n)$, this is the right reading.
3. **Ambient against intrinsic stability.** `IsStable` quantifies $H$ over all self-adjoint operators on $\mathfrak{so}(n)$, so `¬ IsStable C` exhibits an ambient $H$. The record's (2) on $\mathfrak h$ asks for $H\in\mathop{\mathrm{Sym}}^2\mathfrak h$. The proof's $H$ lies in $\mathop{\mathrm{span}}(D_1,D_2)\subset\mathop{\mathrm{Sym}}^2\mathfrak h$, but the statement does not expose it. For (3) the ambient form suffices, since (1) gives ambient stability of the maximiser.

So "the split is the only remaining step" is REFUTED AS STATED: items 1 to 3 also stay with the record, and none of them is in doubt.

## Q4: the destabilising direction

With $a=\lVert D_2\rVert^2$, $b=\lVert D_1\rVert^2$ and `hDC` ($\langle D_i,C\rangle=\lVert D_i\rVert^2$, from $P_i$ idempotent and self-adjoint), $\langle H,C\rangle=ab-ba=0$, so $H\in\mathop{\mathrm{span}}(D_1,D_2)\cap C^\perp$, nonzero since $\langle D_1,D_2\rangle=0$ and $a,b>0$. As $C\#D_i=D_i$, $F(C,H,H)=\lVert H\rVert^2=a^2b+b^2a>\tfrac12\lVert H\rVert^2$. This is the record's sentence made explicit.

## Q5: axioms

`#print axioms` on both `HamiltonsCubic.L264Cross.L264_cross` and `HamiltonsCubic.L264Cross.sharp_blk` returns `[propext, Classical.choice, Quot.sound]`.

## Q6: an object meeting the hypotheses

- **Without cross block, kernel-checked.** $\iota=\mathrm{Fin}\,6$, $\mathfrak h_1=\mathfrak{so}(3)$ on coordinates $\{0,1,2\}$, $\mathfrak h_2=\mathfrak{so}(3)$ on $\{3,4,5\}$, $P_i=$ `coordOp` of the $0/1$ pair indicator of block $i$, $C=P_1+P_2=$ `coordOp w6` with `w6` the block-diagonal $J_3-I$. The check file proved `IsIdem (coordOp w6)` through `isIdem_coordOp_iff` (off the diagonal, $(W^2)_{ik}=1$ inside a block and $0$ across). The blocks are $D_i=P_i\ne0$, disjoint coordinate $\mathfrak{so}(3)$'s commute and are orthogonal. $C$ is positive definite on $\mathfrak h$, so this is the record's (2) at $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, $C=\bigoplus\Pi_i/c_i$ with $c_i=1$.
- **With a cross block, by hand.** $\iota=\mathrm{Fin}\,4$, $P_\pm$ the projections onto $\Lambda^2_\pm$ (two orthogonal commuting ideals $\mathfrak{su}(2)$ of $\mathfrak{so}(4)$), $C=\Pi_{\mathfrak{so}(3)}$ on coordinates $\{0,1,2\}$, idempotent by the same $J_3-I$ computation. With $s_k$, $a_k$ the self-dual and anti-self-dual unit bivectors, $\varphi_{12}=(s_1+a_1)/\sqrt2$ and so on, so $D_\pm=\tfrac12P_\pm\ne0$ and $E=\tfrac12\sum_k(s_ka_k^{\mathsf T}+a_ks_k^{\mathsf T})\ne0$. $C$ is PSD and not positive definite on $\mathfrak{so}(4)$, so this instance lies outside the record's (2) and inside `L264_cross`: the cross-block generality is inhabited.

## Q7: the INDEX row

The added sentence states `L264_cross` accurately (orthogonal projections onto two commuting ideals, self-adjoint idempotent supported on their sum, both blocks nonzero, unstable for every $E$, via `sharp_blk` over `trace_move`), and the status stays **partial**, correctly, since (3) and (1)'s perfect-to-semisimple step remain prose. Two defects (O2):

- The earlier parenthesis on `L264_not_simple_unstable` still reads *"the record's cross block $E$ is untyped"*, which the new sentence in the same row contradicts.
- The closing remainder names only the split, leaving out Q3's items 1 to 3.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.**

1. **O1.** The header's remainder and the INDEX row's untyped remainder should also name the ambient reading of (2): $\mathfrak h\subseteq\mathfrak{so}(n)$ with the restricted form and the ambient $\#$, and instability witnessed by an $H$ that the statement quantifies over all of $\mathop{\mathrm{Sym}}^2\mathfrak{so}(n)$ (the proof's $H$ lies in $\mathop{\mathrm{Sym}}^2\mathfrak h$). PD implying nonzero blocks is a third one-line prose step.
2. **O2.** The L264 row's clause *"the record's cross block $E$ is untyped"* is stale after 26f02ba2 and should be removed or re-dated as earlier.
3. **O3.** `o₂₁` and `hQC` are consequences of the other hypotheses (self-adjointness of $P_1$, $P_2$, $C$). Harmless, and removable.
4. **O4.** `L264_cross` is stronger than the record's (2): it needs only nonzero blocks, so it covers PSD idempotents with a cross block such as $\Pi_{\mathfrak{so}(3)}$ in $\mathfrak{so}(4)$. The record may state this strengthening, its proof already giving it.

**What would falsify each claim.**

- Q1: a pair of ideals of $\mathfrak h$ violating `b₁`, `b₂` or `c₁₂`, or two ideals of a compact semisimple $\mathfrak h\subseteq\mathfrak{so}(n)$ that are not orthogonal under the trace form.
- Q2: a self-adjoint $D$ with $F(C,D,Y)=\langle Y,D\rangle$ for every self-adjoint $Y$ but $C\#D\ne D$ in `sharpMapCL`'s polarisation.
- Q3: a compact semisimple subalgebra of $\mathfrak{so}(n)$ with two simple ideals and a PD idempotent that is stable within $\mathop{\mathrm{Sym}}^2\mathfrak h$ yet destabilised only by ambient directions (impossible here, since the proof's $H$ lies in $\mathop{\mathrm{Sym}}^2\mathfrak h$).
- Q4: $\langle H,C\rangle\ne0$ for $H=\lVert D_2\rVert^2D_1-\lVert D_1\rVert^2D_2$, which `hHC` rules out.
- Q6: `IsIdem (coordOp w6)` failing to elaborate, or $\Pi_{\mathfrak{so}(3)}$ in $\mathfrak{so}(4)$ having $D_\pm=0$.
