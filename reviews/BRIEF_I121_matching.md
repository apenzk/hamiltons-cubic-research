# Gate 2 brief, the matching inequality and the visibility route for the small-mass node of (MG), for I121

**Cold brief. The claims are quoted verbatim from [reviews/2026-09-28b-LIT-step8-sweep.md](2026-09-28b-LIT-step8-sweep.md) as it stands at dispatch. You are asked to break them.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: argue from the definitions, reading the written chain link by link; compute only to refute or to check a value, the smallest computation that does it (numpy under `sage -python`). A run of a few minutes on objects you construct is allowed; no sweeps or open-ended searches. **Screens quoted in the claims are screens, not evidence for a positive claim.**

## Definitions

- $\mathcal W_n$: algebraic Weyl tensors as symmetric operators on $\Lambda^2\mathbb R^n$, Hilbert–Schmidt norm, $Q$, $P$ as in the record. In an orthonormal frame: $a_{ij}=W(e_i\wedge e_j,e_i\wedge e_j)$, $t^2=\sum_{i<j}a_{ij}^2$ at unit $W$, the pair part (entries $W(e_a\wedge e_c,e_b\wedge e_c)$), the four-set part $B_f$ (four distinct indices). A **globally maximal frame** maximises $t$ over $O(n)$.
- For a pair $e=\{i,j\}$: $x^e_k=W(e_i\wedge e_k,e_j\wedge e_k)$ and $\delta^e_k=\tfrac12(a_{ik}-a_{jk})$, $k\notin e$.

## Givens

- **The double-rotation block exchange** (Gate 2, [r1797](REVIEW_r1797.md), [r1798](REVIEW_r1798.md); typed as `block_exchange` in [DoubleRotation.lean](../lean/HamiltonsCubic/Results/DoubleRotation.lean)): rotating by $\tfrac\pi4$ in the planes $(i,j)$ and $(k,l)$ changes the diagonal mass of the block on $\{e_{ik},e_{il},e_{jk},e_{jl}\}$ by $(W_{ik,jl}+W_{il,jk})^2-\tfrac14\square^2+(x^{kl}_i+x^{kl}_j)^2-(\delta^{kl}_i+\delta^{kl}_j)^2+(x^{ij}_k+x^{ij}_l)^2-(\delta^{ij}_k+\delta^{ij}_l)^2$, $\square=a_{ik}-a_{il}-a_{jk}+a_{jl}$.
- **The matching rotation** (the first sweep's attempt 1, screened to $9\times10^{-14}$): rotating by $\tfrac\pi4$ in every plane of a perfect matching $M$ changes the diagonal mass by the sum of the block exchanges over pairs of edges of $M$. In a globally maximal frame this change is $\le0$.
- Row sums: $\sum_ka_{ik}=0$ for a Weyl operator.

## The claims

## Post F81's successor, formulated: visibility to a matching rotation (derived here, unreviewed)

- **The fourth-order expansion.** For $\xi\in\mathfrak{so}(n)$ put $D_k=\pi_{\mathcal D}(\xi^k\cdot W)$, so $f(\varphi)=\lVert\pi_{\mathcal D}(e^{\varphi\xi}W)\rVert^2=t^2+c_2\varphi^2+c_3\varphi^3+c_4\varphi^4+\dots$ with $c_2=\lVert D_1\rVert^2+\langle D_0,D_2\rangle$, $c_3=\tfrac13\langle D_0,D_3\rangle+\langle D_1,D_2\rangle$ and $c_4=\tfrac1{12}\langle D_0,D_4\rangle+\tfrac13\langle D_1,D_3\rangle+\tfrac14\lVert D_2\rVert^2$. **At a pair-free $W$, $D_1=0$**, since a one-plane generator moves the diagonal only through that plane's pair profile, **so $c_2=\langle A,D_2\rangle$ is $O(t)$ while $c_4$ carries $\tfrac14\lVert D_2\rVert^2$, whose four-set share is $O(1)$.** At small $t$ a multi-plane rotation that sees the four-set part therefore raises the diagonal mass at a small angle, and the witness is the extreme case, where $c_2=c_3=0$.
- **In finite form this is attempt 1's exact identity, unaveraged** ([first sweep](2026-09-28-LIT-step8-sweep.md)). In a maximal frame every perfect matching $M$ satisfies $\sum_{e<f\in M}\Delta_{ef}\le0$, so its **visible four-set energy** $E(M)=\sum_{e<f\in M}(\text{the pairing's combination})^2$ is at most the $A$-side, $\sum\tfrac14\square_{ef}^2$ plus the $\delta$ terms, which is $O(t^2)$ on average over $M$ by the forced sums. *Averaged over $M$ the visible energy is only $\tfrac32\lVert B_f\rVert^2/((n-1)(n-3))$, which is why attempt 1 washed out.*
- **The statement the node now needs, "visibility"**: a unit $W$ with $P(W)$ above $\sqrt{3/2}$ (or near $\theta_0$) has a perfect matching, or a multi-plane rotation, seeing a fixed fraction of its four-set part, $\max_ME(M)\ge c\lVert B_f\rVert^2$. With the $A$-side $O(t^2)$ that forces $t\gtrsim\sqrt c$. *Random four-set tensors hide from every matching, at $E(M)\sim\lVert B_f\rVert^2/n^2$, but they have low $P$. The witness is fully visible to its own matching. So visibility is exactly the claim that high value forces structure a rotation can see, the conjecture's core in a combinatorial form.* **Next, a bounded screen of the visible fraction $\max_ME(M)/\lVert B_f\rVert^2$** at the high-value pair-free tensors the $n=12$ ascent found, against random ones.

## The matching inequality with an absolute constant, and the visibility screen

- **Lemma candidate, derived here, unreviewed.** *In a globally maximal frame at even $n$, every perfect matching $M$ satisfies*
$$E(M)+\sum_{e\ne f\in M}(x^e_k+x^e_l)^2\ \le\ 3t^2,\qquad E(M)=\sum_{e<f\in M}\big(W_{ik,jl}+W_{il,jk}\big)^2,$$
*with no factor of $n$.* **Proof.** The $\tfrac\pi4$ rotation along $M$ changes the diagonal mass by $\sum_{e<f}\Delta_{ef}\le0$ (the first sweep's exact identity, `block_exchange` per edge pair). Its negative side is bounded by $t^2$ and $2t^2$: each $\square_{ef}=a_{ik}-a_{il}-a_{jk}+a_{jl}$ has $\tfrac14\square_{ef}^2\le a_{ik}^2+a_{il}^2+a_{jk}^2+a_{jl}^2$, and the cross entries of distinct edge pairs are distinct, so $\sum\tfrac14\square^2\le t^2$. And $(\delta^e_k+\delta^e_l)^2\le2(\delta^{e\,2}_k+\delta^{e\,2}_l)$, $\lVert\delta^e\rVert^2\le\tfrac12(r_i+r_j)$ with $r_i=\sum_ka_{ik}^2$, and the rows of one matching's edges sum to $\sum_ir_i=2t^2$, so the $\delta$ side is at most $2\sum_{e\in M}\lVert\delta^e\rVert^2\le2t^2$. $\square$
- **The screen** ([screen_I121_visibility.py](../scripts/misc/screen_I121_visibility.py), all $10395$ perfect matchings at $n=12$, a screen): the largest share of the four-set mass one matching sees is **$1.0000$ at the witness** ($P=\theta_0$), **$0.540$ at a four-set-sector ascent** ($P=0.950$), and **$0.040$ to $0.049$ at random pair-free tensors** ($P\approx0$). *High value goes with high visibility.*
- **So the route is: visibility plus the matching inequality.** If a unit $W$ with $P(W)$ above $\sqrt{3/2}$ has, in its maximal frame, a matching seeing a share $c$ of its four-set mass, then $c\lVert B_f\rVert^2\le3t^2$, and with the pair mass either small or at most $(n-1)t^2$, $t$ is bounded below. **Visibility is where the value enters, and it is the conjecture's core in combinatorial form**, now with a screened constant ($c\approx0.5$ at $P\approx0.95$) and an $n$-free inequality to feed.

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| the fourth-order expansion and $D_1=0$ at pair-free $W$ | none: a Taylor expansion and a character argument; check it | |
| the matching inequality $E(M)+\dots\le3t^2$ | none: sums over one perfect matching, which the layer does not index; its single-block core is `block_exchange`; check each bound | |
| the visibility screen and the route's conclusion | none: a screen and an implication; check that the text claims no more than the screen shows | |

## What to attack

1. The fourth-order coefficients $c_2,c_3,c_4$, and $D_1=0$ at a pair-free $W$: does a rotation generator move the diagonal only through pair profiles?
2. The matching inequality: $\sum\tfrac14\square_{ef}^2\le t^2$ (distinct cross entries), the $\delta$ side at most $2t^2$ (the row-sum argument), and the resulting $E(M)+\sum(x^e_k+x^e_l)^2\le3t^2$. Is the constant right, and is anything used beyond the givens?
3. The visibility route: does "a matching seeing a share $c$ of the four-set mass" plus the inequality really give $t$ bounded below, and how does the pair mass enter? Is "visibility is the conjecture's core" an overstatement?
4. The screen: is the visible share computed with the combination the identity uses, and are the three quoted numbers used only as screens?
