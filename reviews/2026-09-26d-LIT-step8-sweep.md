# Step 9 literature sweep, 2026-09-26d: after I114

Works from [the position file](2026-09-26d-step8-position.md). One section per batch.

## Batch 1: norms of idempotents, cubic Weyl invariants

- *Norm bounds for idempotents of a metrised commutative algebra*: [Tkachev's 2024 slides](../references/tkachev-2024-metrized-slides/notes.md), already on the shelf since 2026-08-31 (a duplicate folder filed this batch was removed). Minimal idempotents have Peirce spectrum $\le\tfrac12$ off $c$ and obey a Jordan-type fusion law; a norm bound exists only with a unit. **Both conditions hold on H's whole equality family, so neither closes H's window.** Hsiang algebras (all idempotents of one length) exclude ours.
- *Sharp inequalities between the cubic Weyl invariants, maxima at products of spheres*: searched, nothing found.
- *Spinor-trace representations of the cubic Weyl invariants*: searched, nothing found.

## Batch 2: H's equality family projects onto P's conjectured maximisers (derivation, with a screen)

**The Weyl part of $\sigma_k=\mathrm{Ad}(\mathrm{diag}(-1_k,1_{n-k}))$ is the $S^k\times S^{n-k}$ Weyl tensor**, since $\tfrac12(I+\sigma_k)$ is that product's curvature operator. At $n=12$ its normalisation satisfies $Q(W)=P(W)W$ to $10^{-15}$ and gives $P=0.9950,1.1418,1.2016,1.2282,1.2360$ at $k=2,\dots,6$, the last being $\theta_0(12)$.

**H therefore bounds the $\#$ half of P sharply.** *For unit Weyl $W$ and real $a$, $\langle I\#W,W\rangle=-1$ and $\operatorname{tr}W=0$ give $F(W+aI)=F(W)-3a+a^3(n-2)N$, so H on the span of $W$ and $I$ reads*
$$F(W)\le\varphi(n)=\min_a\Big[\tfrac{n-2}{\sqrt N}(1+a^2N)^{3/2}+3a-a^3(n-2)N\Big],$$
*and $\varphi(12)=1.21356$ equals $F(W_{S^6\times S^6})=1.2136$, attained where $W_{\mathrm{ps}}+aI$ is proportional to $\sigma_6$* ($\varphi(16)=1.26867$, $\varphi(20)=1.30002$). **So H implies that $\langle W\#W,W\rangle$ on the unit Weyl sphere is maximised at the balanced product of spheres, for even $n$.** *P's other half, $\operatorname{tr}W^3$, is not controlled by H: at the balanced product it is $0.0225$ and on the recorded asymmetric survivors up to $0.326$.*

## Phase 3: candidates

| route | closes | attackable | margin | analytic | value | reach toward P |
|---|---|---|---|---|---|---|
| **R42: prove H through the invariant trilinear forms on $\operatorname{Sym}^2\Lambda^2=V_0\oplus V_{\mathrm{Ric}}\oplus V_{\mathrm{W}}\oplus V_{\Lambda^4}$** | 2 | 2 | 1 | 1 | **4** | I114 (I73's symmetric family) at every $n\ge12$, the sharp $\#$ half of P at even $n$, L257's quartic bound; P itself still needs the trade against $\operatorname{tr}W^3$ |
| I73's asymmetric spectra by a trade between $F$ and $\operatorname{tr}W^3$ | 3 | 1 | 1 | 1 | 3 | the goal, but this trade is P's own difficulty |
| R17, R27/R28, R25 (register) | 2 | 1 | 1 | 1 | 2 | P, no method |

**Pick: R42.** *It has a concrete first step: batch 30's window needs $F$ evaluated on the components, and the equivariant trilinear forms among four irreducibles are a finite list, each fixed up to a constant. The first step is to write that list and its constants, then pair $C\#C=C$ with each component's own projection, which is the pairing batch 30 lacked.*

## Phase 3, corrected: R42 contains a sharp half of P, and the reach gate fires

**Batch 2 cuts both ways.** *H implies $\max_{\text{unit Weyl}}\langle W\#W,W\rangle=F(W_{S^{n/2}\times S^{n/2}})$ at even $n$, so any proof of H proves that sharp statement, which is the $\#$ half of Problem P with P's own conjectured extremal.* **R42's `attackable` is therefore $1$, not $2$**: its component route must bound $F$ on $V_{\mathrm W}^{\otimes3}$ exactly at the balanced product, which is a P-type problem, and its value falls to $2$. *The same observation says the component pairings of $C\#C=C$ carry the Weyl–Weyl–Weyl form as an unknown, so they cannot close the window without it.*

**The reach gate fires.** *Every candidate either reaches only I114 and the $\#$ half of P (R42), or reaches P with no method (the $F$-against-$\operatorname{tr}W^3$ trade, R17, R27/R28, R25).* **Decision recorded as [D12](../DECISIONS-TO-MAKE.md).**

## Teeth test for D12's recommendation (a screen)

*At the balanced product $W_{S^6\times S^6}$, $n=12$: $\iota(W)$ has spectrum $1.3484$ once, $\pm0.13484$ ($30$ against $40$), $\pm0.11237$ ($36$ each), $0$ once; its top eigenvalue sits at $0.9959$ of batch 30's $\Gamma$-cap, and $\tfrac12\operatorname{tr}\iota(W)^3+\operatorname{tr}W^3=1.21356+0.02247=1.23603=\theta_0(12)$.* **The shape is L258's: one dominant eigenvalue and near-pairs.** *The cap alone is $0.4\%$ from tight there, so a proof along this line needs the pairs' imbalance ($40$ against $30$) as a second input, not only the cap.*

## D12's pick is the recorded bi-spectral route (classification against the record)

**Agreement, not discovery.** *For Weyl $W$, $\iota(W)$ is $W$ on $\Lambda^2\mathbb R^n$ plus minus the second-kind operator $\mathring W$ (Li's order) on $S^2_0$, with $0$ on the trace line, so $P=\operatorname{tr}W^3+\tfrac12\operatorname{tr}\iota(W)^3=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$: the bi-spectral identity of [bispectral.md](../findings/bispectral.md) (Gate 2, Reviewers 97 and 98). The $\Gamma$-cap, read on the $S^2_0$ block with $\sum s_k^4\ge1/n$, is $\lvert\omega\rvert\le\sqrt{2(n-1)/n}$ at unit $W$, the curvature-operator maximum recorded at [fence post F14](../findings/second-order.md).* **So the block-operator line is the bi-spectral route, and [post F26](../findings/fence-posts.md) is its recorded wall**: $\tfrac32\max p_3(\mu)$ alone exceeds $\theta_0$, and both-sided Schur–Horn and the vertex-matrix budget are the same wall. *The sweep's phase 3 screened R42 against the record and not this candidate; the screen of the block operator by its defining identity, not its name, is what would have caught it.* I116 is closed as a duplicate.
