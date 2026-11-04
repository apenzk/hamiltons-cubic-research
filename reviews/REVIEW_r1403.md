# REVIEW r1403: the cubic trace identity `trS2_ringW_cube` against Dai–Fu's Lemma 3.3 and L50

Log [agent_logs/r1403.log](../agent_logs/r1403.log). One reviewer, statement fidelity only (the kernel has checked the proofs). Analysis-only: one elaboration of a scratch file for `#print axioms`, and one hand computation at $R=\mathrm{Id}$ reported as a screen. Record: [findings/bispectral.md](../findings/bispectral.md) (L50, its derivation and its "transfer" paragraph), [results.md](../results.md) (L50), [references/dai-fu-2023-einstein-second-kind/notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md) (Lemma 3.3). Lean: [SecondKind.lean](../lean/HamiltonsCubic/Results/SecondKind.lean) section `trace`, [L209FoxClosure.lean](../lean/HamiltonsCubic/Results/L209FoxClosure.lean) (`R4`, `R4_pair`, `R4_anti2`), [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) (`phi`, `inner2`, `bianchi`, `IsWeyl`).

**Standfirst.** `trS2_ringW_cube` states $\mathop{\mathrm{tr}}_{S^2}\mathring W^3=\alpha/8-\beta$ with `alphaW` and `betaW` equal to Dai–Fu's $\alpha$ and $\beta$ letter for letter after a relabelling, and `trS2` is the genuine trace of the restriction to $S^2$. It is exactly Dai–Fu's intermediate identity $\mathop{\mathrm{tr}}(\tilde R^3)=-\beta+\tfrac18\alpha$ on the full $S^2(V)$, which holds for every algebraic curvature tensor, so trace-freeness is correctly absent. The passage from $S^2$ to $S^2_0$, where L50's $\omega$ lives, is a one-line consequence of `ringW_one` and `trace_ringW` at a Weyl operator and is not typed.

| Item | Verdict | Reason |
| --- | --- | --- |
| 1a. `alphaW` is the record's $\alpha$ | CONFIRMED | Record and Dai–Fu: $\alpha=W_{tpsq}W_{tpkl}W_{sqkl}$. Relabel $(t,p,s,q,k,l)\to(i,j,k,l,m,n)$: $W_{ijkl}W_{ijmn}W_{klmn}$, which is `alphaW` term for term. |
| 1b. `betaW` is the record's $\beta$ | CONFIRMED | Record and Dai–Fu: $\beta=W_{tspq}W_{tjpl}W_{sjql}$. Relabel $t\to i$, $s\to j$, $p\to k$, $q\to l$, $j\to m$, $l\to n$: $W_{ijkl}W_{imkn}W_{jmln}$, which is `betaW` term for term. The docstring's claim holds. |
| 1c. Normalisation and index order | CONFIRMED | `R4 R i j k l = inner2 (R φ_ij) φ_kl` with $\langle\varphi_{ij},\varphi_{kl}\rangle=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ (r1401), so `R4 Id` is the round-sphere tensor with $\mathrm{Ric}_{ik}=R_{ijkj}=(n-1)\delta_{ik}$, Dai–Fu's convention. `ringW` is $R_{iklj}h_{kl}$, Dai–Fu's and Li's order. The identity is homogeneous of degree three on both sides, so a global rescaling of `R4` cannot break it, and the only convention that can is the index order ($ikjl$ negates $\mathring W$ and leaves $\alpha/8-\beta$ fixed), which `ringW_id_S20` pins in the kernel. The record's $\lVert W\rVert^2=\tfrac14\sum W_{ijkl}^2$ enters only the companion `trS2_ringW_sq`, where $\lvert W\rvert^2=\sum W_{ijkl}^2$ is Dai–Fu's $\lvert R\rvert^2$. |
| 2. `trS2` is the trace of $A\vert_{S^2}$ | CONFIRMED | For linear $A$ preserving $S^2$: $\sum_{a,b}(A\,\mathrm{symB}_{ab})_{ab}=\mathop{\mathrm{tr}}(A\circ P)$ on all matrices, $P$ the symmetriser, and $A\circ P$ is $A$ on $S^2$ and $0$ on $\Lambda^2$, so the sum is $\mathop{\mathrm{tr}}(A\vert_{S^2})$. The docstring's basis argument is the same count: $a=b$ gives $(AE_{aa})_{aa}$, and each $a<b$ pair gives $\tfrac12((As)_{ab}+(As)_{ba})=(As)_{ab}$ with $s=E_{ab}+E_{ba}$, using linearity to pull out the $\tfrac12$ and symmetry of $As$. Both hold for $\mathring W^3$ (`ringW` is a finite sum, `ringW_symm`). |
| 3a. Hypotheses needed | CONFIRMED | The identity reads only the numbers `R4 R i j k l`. It needs pair symmetry (`hsym` through `R4_pair`), both antisymmetries (the second automatic, the first from pair symmetry), and first Bianchi (`hB`, used in `cross_half`, `two_E_eq`, `betaW'_eq`). `hR` and `hskew` look superfluous on inspection, as r1401 found for the structural facts, and are harmless: they make the theorem's hypotheses stronger than needed, never different from the record's. |
| 3b. Satisfied by the record's Weyl operators | CONFIRMED | `IsWeylOp = IsLinOp ∧ IsWeyl`, and `IsWeyl` is skew-preserving, self-adjoint on bivectors, first Bianchi and Ricci-flat. The four hypotheses are the first four clauses. |
| 3c. Trace-freeness absent | CONFIRMED | Dai–Fu's proof of Lemma 3.3 computes $\mathop{\mathrm{tr}}(\tilde R^3)=-R_{isjt}R_{kslt}R_{ikjl}+\tfrac18R_{ijkl}R_{ijst}R_{klst}$ on all of $S^2(V)$ for any algebraic curvature tensor and uses the Einstein hypothesis only to subtract the $g/\sqrt n$ direction. The Lean statement is that intermediate identity, so it genuinely holds without Ricci-flatness. The screen of item 4 is at a non-Ricci-flat object and agrees. |
| 4. Screen at $R=\mathrm{Id}$ (round sphere) | CONFIRMED (screen) | By hand: $\mathring W h=h^{\mathsf T}-(\mathop{\mathrm{tr}}h)g$, so $\mathring W=+1$ on $S^2_0$ (dimension $N-1$, $N=n(n+1)/2$) and $\mathring Wg=(1-n)g$. LHS $=N-1+(1-n)^3$. $\alpha=\mathop{\mathrm{tr}}(2P)^3=8\binom n2=4n(n-1)$. $\beta$ by expanding the eight $\delta$-products: $n^3-3n^2+2n=n(n-1)(n-2)$. RHS $=\tfrac12n(n-1)-n(n-1)(n-2)$, and RHS $-$ LHS $=(n-1)\,[\,1-(n-1)^2+n(n-2)\,]=0$. At $n=4$ both sides are $-18$. The quadratic companion agrees too: $N-1+(1-n)^2=\tfrac34\cdot2n(n-1)$ at $n=4$ ($18=18$). A screen, not evidence. |
| 5. Axioms | CONFIRMED | `#print axioms` on `trS2_ringW_cube` and `trS2_ringW_sq`: `[propext, Classical.choice, Quot.sound]`. |
| 6. Fit to L50's use ($\omega$ on $S^2_0$) | CONFIRMED WITH GAP | L50 reads $p_3(\omega)$ over $S^2_0$. At a Weyl operator $\mathring Wg=0$ (`ringW_one`) and $\mathop{\mathrm{tr}}\mathring Wh=0$ (`trace_ringW`), so $S^2=S^2_0\oplus\mathbb Rg$ is a $\mathring W$-invariant splitting with $\mathring W^3=0$ on $\mathbb Rg$, and $\mathop{\mathrm{tr}}_{S^2}=\mathop{\mathrm{tr}}_{S^2_0}$. That step is not typed. It is short and owes nothing to the record, so it is a gap in the Lean chain to L50 and not in this theorem. |
| 7. Module docstring | STALE | [SecondKind.lean:25](../lean/HamiltonsCubic/Results/SecondKind.lean#L25) still says the two trace identities are "Not typed here", which both `trS2_ringW_sq` and `trS2_ringW_cube` now contradict. Not repaired here, since this review commits only its own two files. |

**One-line summary: CONFIRMED.** `trS2_ringW_cube` is Dai–Fu's $\mathop{\mathrm{tr}}_{S^2}\tilde R^3=\alpha/8-\beta$ with the record's $\alpha$ and $\beta$ index for index, `trS2` is the true $S^2$ trace, the hypotheses are the record's minus Ricci-flatness (correctly), and the $S^2\to S^2_0$ transfer plus a stale module docstring are the two things left.

## 1. What the record means

[bispectral.md](../findings/bispectral.md)'s derivation of L50 quotes Dai–Fu's Lemma 3.3 at $s=0$, $\mathop{\mathrm{tr}}(\mathring W^3)=\tfrac18\alpha-\beta$, with $\alpha=W_{tpsq}W_{tpkl}W_{sqkl}$ and $\beta=W_{tspq}W_{tjpl}W_{sjql}$. Its "transfer" paragraph proves the algebraic version through the pair operator $B_{(ij),(kl)}=W_{iklj}$, which restricts to $\mathring W$ on $S^2$ and to $-M$ on $\Lambda^2$. The [notes](../references/dai-fu-2023-einstein-second-kind/notes.md) transcribe the source proof: the trace is first taken on $S^2(V)$ as $\mathop{\mathrm{tr}}(\tilde R^3)=-\beta+\tfrac18\alpha$, and the $s^3/n^3$ term comes from removing the $g$ direction. The Lean theorem is that first step.

## 2. The contractions

Both relabellings are in the table. For `betaW` the last factor $W_{jmln}$ against the alternative $W_{jnlm}$ (`betaW'`) is the only place an index slip could hide, and `betaW'_eq` shows the two differ by $\alpha/4$, which Dai–Fu record as $R_{pstq}R_{tjpl}R_{sjql}=-\tfrac14\alpha+\beta$. So the file distinguishes the two orderings correctly and names the record's one $\beta$.

## 3. The trace

`trS2` is defined on every map but is only meaningful for linear maps preserving $S^2$, which the docstring states. The only consumers are `ringW` compositions, which qualify. Writing it as $\mathop{\mathrm{tr}}(A\circ P)$ makes the basis-independence plain, and it avoids the trap r1401 flagged: a trace over all matrices would add $\mathop{\mathrm{tr}}(-M)^3$ from the $\Lambda^2$ block.

## 4. Hypotheses

The four section variables are the first four clauses of `IsWeylOp`. Ricci-flatness is the fifth and is correctly omitted, because the identity is the pre-Einstein one. `hR` and `hskew` are carried but not needed mathematically, the same observation r1401 made, and they cost the consumers nothing since `IsWeylOp` supplies them.

## 5. Screen

Item 4's computation is independent of the file's proof route: $\beta$ was expanded as eight $\delta$-products directly, not through the pair operator $B$. It tests the identity at a non-Ricci-flat object at every $n$, which is the regime where a hidden trace-free assumption would show.

## 6. Owed

- The $S^2\to S^2_0$ transfer at a Weyl operator, from `ringW_one`, `trace_ringW` and `ringW_selfAdjoint`, before L50's $p_3(\omega)$ can be read off.
- The module docstring's "Not typed here" sentence, to be replaced by the two proved identities.
- The dictionary $\alpha=8\mathop{\mathrm{tr}}M^3$, $\beta=2\langle M^\#,M\rangle$, already listed as owed in [lean/INDEX.md](../lean/INDEX.md).
