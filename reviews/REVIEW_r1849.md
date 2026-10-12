# REVIEW r1849: I121 small-mass reduction, above sqrt(3/2) the value lives in the visible and diagonal parts

Brief: [BRIEF_I121_Ereduction.md](BRIEF_I121_Ereduction.md). Source: [2026-09-28d-I121-smallmass-direct.md](2026-09-28d-I121-smallmass-direct.md), last section. Log: [agent_logs/r1849-i121-ered.log](../agent_logs/r1849-i121-ered.log). Value check: [review_r1849_dm.py](../scripts/reviewers/review_r1849_dm.py). Analysis-only footing: every verdict below is argued from the definitions, and the two computations are value checks of identities already derived by hand.

**Verdict: the algebra holds throughout. Two claims need their hypotheses written in, and the account of what remains open is narrower than the node it is written for.**

| claim | verdict |
|---|---|
| Claim 1 (frame-free bound, threshold, values) | CONFIRMED with a correction: the proof needs $\theta>0$, which the prose omits and the Lean carries |
| Claim 2 ($E$ in a frame at pair-free $W$, every $J$ cancels) | CONFIRMED |
| Three sources: diagonal term and coupling estimate | CONFIRMED, at even $n$, with the sum over $(e,f)$ read as ordered in $\sum X^2=\tfrac34\lVert B_f\rVert^2$ |
| Three sources: visible cubic per matching as $P(D_M)$ | CONFIRMED, derived by hand and value-checked independently at $n=8$ |
| Scope: "what is open is the visible cubic" | PLAUSIBLE with corrections: it holds at pair-free $W$ and asymptotically in $n$, and omits the pair part and the finite-$n$ size of the coupling |
| The screen | PLAUSIBLE as a screen: it claims nothing positive, but "near minima" is unsupported and no script is cited |

## Claim 1

- **Invariance.** $P(W)=\operatorname{tr}W^3+\langle W^\#,W\rangle$, so $E=\langle W^\#,W\rangle-\tfrac12\operatorname{tr}W^3$. Both terms are $O(n)$-invariant because $\#$ is equivariant and the trace is conjugation-invariant.
- **The power-sum step.** $\lambda^3\le\lambda_{\max}\lambda^2$ is $\lambda^2(\lambda_{\max}-\lambda)\ge0$, true for every $\lambda\le\lambda_{\max}$ whatever the sign of $\lambda_{\max}$. The appeal to $\operatorname{tr}W=0$ is correct ($\sum_{i<j}W_{ij,ij}$ is half the scalar trace of the Ricci, which vanishes) and idle.
- **The gap.** From $T:=\operatorname{tr}W^3\le\lambda_{\max}$ and $\theta\lambda_{\max}\le1$ the proof concludes $\tfrac32T\le\tfrac3{2\theta}$. That multiplies by $\theta$ and needs $\theta>0$. The claim is stated "at every unit critical point", and critical points with $\theta<0$ exist ($-W$ is critical with value $-\theta$). [crit_E_bound](../lean/HamiltonsCubic/Results/SmallMassE.lean) carries `hθ : 0 < θ`, so the Lean is right and the prose is wider than its proof.
- **Correction, which also covers every sign.** L198's first clause gives $\theta\lambda_k-\lambda_k^2\le1-\lambda_k^2$, so $\theta\lambda_k\le1$ at every $k$. Then $\theta\lambda_k^3=(\theta\lambda_k)\lambda_k^2\le\lambda_k^2$ termwise, and summing gives $\theta T\le1$ with no sign condition. Hence $\theta^2=\tfrac32\theta T+\theta E\le\tfrac32+\theta E$ at every unit critical point. Equivalently, $\theta E$ and $\theta^2$ are both unchanged under $W\mapsto-W$. Either repair is two lines, and the consequences are unaffected since they assume $\theta>\sqrt{3/2}>0$.
- **The consequences.** At $\theta>\sqrt{3/2}$, $\theta E\ge\theta^2-\tfrac32>0$ gives $E>0$. At $\theta\ge\theta_0>0$, $E\ge\theta-\tfrac3{2\theta}\ge\theta_0-\tfrac3{2\theta_0}$, as $\theta-\tfrac3{2\theta}$ is increasing on $\theta>0$.
- **Values.** With the record's $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$: $\theta_0(12)=\sqrt{220}/12=1.236033$, $\tfrac3{2\theta_0}=1.213560$, $\varepsilon_{12}=0.022473$. The limit is $\sqrt2-\tfrac3{2\sqrt2}=\tfrac1{2\sqrt2}=0.353553$. Both as stated.
- **A scope note to add.** $\varepsilon_n\ge0$ exactly when $\theta_0(n)^2\ge\tfrac32$, that is $n^2-12n+8\ge0$, that is $n\ge12$ among even $n$. Below $12$ the threshold is negative and the second implication is vacuous. This matches the conjecture's live range, and the note should say so.

## Claim 2

- $\operatorname{tr}(A+B_f)^3=\operatorname{tr}A^3+3\operatorname{tr}(A^2B_f)+3\operatorname{tr}(AB_f^2)+\operatorname{tr}B_f^3$ by cyclicity.
- $\operatorname{tr}(A^2B_f)=\sum_ea_e^2(B_f)_{ee}=0$: every diagonal entry $W_{e,e}$ belongs to $A$.
- $(B_f)_{e,g}$ is nonzero only for disjoint $e,g$, where it is $J_{eg}$ up to an orientation sign, so $\operatorname{tr}(AB_f^2)=\sum_ea_e\sum_{g\cap e=\emptyset}J_{eg}^2=\sum_{\{e,g\}}(a_e+a_g)J_{eg}^2$.
- Subtracting $\tfrac32\operatorname{tr}W^3$ from the whole-$P$ formula: the $J^2$ coefficient is $3\cdot\tfrac32-\tfrac32\cdot3=0$, the $X^2$ coefficient is $3\cdot(-2)=-6$, and the rectangle $JJJ$ coefficient is $9-\tfrac32\cdot6=0$ by $\operatorname{tr}B_f^3=6\sum_RJJJ$. The formula follows, with $P(A)-\tfrac32\operatorname{tr}A^3=E(A)$.
- The record's check script reproduces $E(W)=-26.1123208173$ both ways at $n=6$.

## The three sources

**Diagonal term.** $\lvert E(A)\rvert\le\lvert P(A)\rvert+\tfrac32\lvert\operatorname{tr}A^3\rvert\le(\Theta_n+\tfrac32)t^3$, by L57 applied to $\pm A$ and $\lvert\sum a_e^3\rvert\le t^3$. "Of size $O(t^3)$" holds with this constant.

**Coupling.** Write $S_e=\sum_{f\cap e=\emptyset}X_{ef}^2$, so the coupling is $-6\sum_ea_eS_e$.
- *Per-edge bound.* Fix $e$ (n even). Each perfect matching $M\ni e$ gives $4\sum_{f\in M\setminus e}X_{ef}^2\le E(M)\le t^2-\sum_{g\in M}a_g^2\le t^2$ by the matching inequality. Summing over the $(n-3)!!$ such matchings, each edge $f$ disjoint from $e$ lies in $(n-5)!!$ of them, so $4(n-5)!!\,S_e\le(n-3)!!\,t^2$, giving $S_e\le\tfrac{n-3}4t^2$. Correct.
- *Total.* Per block $\sum_\pi X_\pi^2=\tfrac38\lVert\nu_Q\rVert^2$, so the sum over ordered pairs is $\sum_eS_e=\tfrac34\lVert B_f\rVert^2$. The brief's $\sum_{e,f}X_{ef}^2=\tfrac34\lVert B_f\rVert^2$ is right only as an ordered sum, and the note should say "ordered".
- *Cauchy–Schwarz.* $\lvert\sum a_eS_e\rvert\le t\sqrt{\sum S_e^2}\le t\sqrt{\max S_e\cdot\sum S_e}\le t\cdot\tfrac{\sqrt{3(n-3)}}4\,t\,\lVert B_f\rVert$. Times $6$ with $\lVert B_f\rVert\le1$ this gives $\tfrac32\sqrt{3(n-3)}\,t^2$. CONFIRMED.
- *Parity.* The step uses perfect matchings, so it holds at even $n$. The note states the matching form needs $n$ even two sections earlier, but the estimate is written without it.

**Visible cubic as $P(D_M)$.** Rotate by $\tfrac\pi4$ in each plane $e_a=\{i,j\}$ of $M$, $u_a=(x_i+x_j)/\sqrt2$, $v_a=(x_i-x_j)/\sqrt2$.
- The rotated $B_f$ has diagonal entry $W(u_a,u_b,u_a,u_b)=\tfrac14\cdot2(b+c)=X_{ab}$. In the expansion of $W$ itself, the cross-diagonal entries would be $A$'s and the one-shared-index entries $B_p$'s (zero here), both absent from $B_f$, and the $i\ne i'$, $k\ne k'$ terms are the four crossing entries summing to $2(b+c)=4X_{ab}$, so the $\tfrac14$ leaves $X_{ab}$. By the same count the entries are $+X_{ab}$ on $\{u_a,u_b\}$ and $\{v_a,v_b\}$, and $-X_{ab}$ on $\{u_a,v_b\}$ and $\{v_a,u_b\}$, with $0$ on $\{u_a,v_a\}$.
- $D_M$ is an algebraic curvature operator because a diagonal operator has zero Bianchi image, and it is Weyl because each row sum is $\sum_b(X_{ab}-X_{ab})=0$.
- $P(D)=\sum K^3+3\sum_{\text{triangles}}KKK$ on diagonals. The cubes cancel in fours per block. A triangle through $u_a$ and $v_a$ meets the zero in-block entry, so triangles take one vertex from each of three blocks. The three sign factors multiply to $1$ for each of the $8$ letter choices, giving $3\cdot8=24$ per rectangle $R\subset M$. $\lVert D_M\rVert^2=\sum_{a<b}4X_{ab}^2=E(M)$.
- $\lvert P(D_M)\rvert\le\Theta_nE(M)^{3/2}$ follows from L57 applied to $\pm D_M$, since L57 is one-sided.
- *Independent value check* ([review_r1849_dm.py](../scripts/reviewers/review_r1849_dm.py), a different random tensor at $n=8$, the rotation applied to $W$ as an operator on $\Lambda^2$): the rotated diagonal matches the $\pm X$ pattern to $3\times10^{-16}$, the row sums vanish, $P(D_M)=2.2881341813=24\sum_{R\subset M}XXX$, and $\lVert D_M\rVert^2=8.6980651470=E(M)$.
- *The summed bound.* $\sum_ME(M)=\tfrac32(n-5)!!\lVert B_f\rVert^2$ and each rectangle lies in $(n-7)!!$ matchings, so the visible cubic is at most $\tfrac32(n-5)\Theta_n\,t\,\lVert B_f\rVert^2$. That is order $nt$, as stated.

## Scope: what the section claims against what it shows

1. **The pair part is dropped, and it enters at the same order as the open term.** Claim 2 and the three-source split are at pair-free $W$. At the node, the record gives $\lVert B_p\rVert^2\le(n-1)t^2$ from single-plane maximality, and the screens two sections up locate the product's off-diagonal mass mostly in $B_p$ in matching-feasible frames. $E$'s terms linear in $B_p$ (for example $3E(B_p,B_f,B_f)$) are then of order $\sqrt n\,t$, the same scale as the visible-cubic bound. The plan line "at pair-free small mass is diagonal plus visible: **open, the visible cubic**" is accurate for pair-free $W$. For the node it should read: open, the visible cubic and every term of $E$ carrying $B_p$.
2. **At $n=12$ the coupling and diagonal bounds do not close on their own.** The coupling bound alone is below $\varepsilon_{12}=0.02247$ only when $\tfrac32\sqrt{27}\,t^2<0.02247$, that is $t^2<0.0029$. Adding the diagonal bound with $\Theta_{12}=\theta_0(12)$ gives about $t^2<0.0028$. The obstructed $\mathbb{CP}^m$ sit at $t^2=\tfrac3{n+2}=0.21$ at $n=12$, and the pair identity is quoted in [plan.md](../plan.md) as giving $t\gtrsim n^{-1/2}$. So "what is open is the visible cubic" is right asymptotically, where the coupling bound decays like $n^{-1/2}$ at $t^2\sim1/n$ while $\varepsilon_n\to0.354$. At the dimension the conjecture starts at, all three sources are open unless $\tau_{12}$ is below about $0.003$. The note should state this threshold.
3. **"The invisible part of $B_f$ is spent entirely by L198."** Correct in substance, since $E$ carries no $J$. It is loose in one respect: L198 bounds all of $\operatorname{tr}W^3$, including $\operatorname{tr}A^3$ and the $A$-$J$ cross terms, and the bound $\operatorname{tr}W^3\le\lambda_{\max}\le1/\theta$ is tight only at a spectrum concentrated on its top eigenvalue. That slack is where any improvement of $\sqrt{3/2}$ would have to come from, and the sentence reads as if nothing were left there.
4. **The final sentence** ("a proof has to show that a critical point cannot spread product-like visible patterns over a $\tfrac1{cn}$ fraction of all matchings") is a heuristic reading of the order-$nt$ loss, not a derived necessity. It is presented as what "a proof has to show", which is stronger than the section establishes, since a proof could also bound the visible cubic by a route that is not matching by matching.

## The screen

- It is labelled a screen and draws no positive conclusion. That meets the record's standard.
- "The near-critical frames sit near minima of $t^2$" is not supported by what is reported: $\lvert\nabla t^2\rvert\le0.044$ locates frames near critical points of $t^2$, and minimality needs second-order information the paragraph does not give.
- No script is cited, and a grep of [scripts/misc/](../scripts/misc/) for the first-order condition of $t^2$ finds none that matches. The numbers cannot be reproduced from the record as it stands. The note should link the script or mark the figures as unreproduced.

## Corrections to fold

- Claim 1: add $\theta>0$ to the proof, or replace it with the termwise route $\theta\lambda_k^3\le\lambda_k^2$, which covers every sign. Drop "with $\lambda_{\max}\ge0$ from $\operatorname{tr}W=0$" as idle. Add that $\varepsilon_n\ge0$ exactly at even $n\ge12$.
- Coupling: say "ordered pairs" in $\sum_{e,f}X_{ef}^2=\tfrac34\lVert B_f\rVert^2$, and "even $n$".
- Scope: name the pair-part terms of $E$ as open alongside the visible cubic, and record that at $n=12$ the coupling bound needs $t^2<0.0029$.
- Screen: replace "near minima" with "near critical points", and cite the script.
