# Gate 2 brief, post F68 (freeing outer blocks one at a time in arbitrary diagonal fields fails at two blocks)

**Cold brief, one reader, r954.** The post refutes a claim by an explicit witness, so the round compares the witness against the claim it refutes and against what the post says the witness does and does not touch. Verdicts: CONFIRMED, PLAUSIBLE or REFUTED with corrections, per item. Every passage is quoted verbatim, each sliced from its own heading to the next heading of the same level.

**Analysis only, with screens.** Checking the witness is a computation on a fixed object and is permitted: evaluate $\Phi$ at the printed matrices, and bound the diagonal supremum (two circles of diagonal configurations, a 2-dimensional compact set) by any method whose error you can state. Run [witness_I106_G2.py](../scripts/misc/witness_I106_G2.py) and also check independently of it. No open-ended search beyond the witness and the diagonal supremum.

## The post under review ([findings/fence-posts.md](../findings/fence-posts.md))

## Post F68, freeing outer blocks one at a time in arbitrary diagonal fields fails at two blocks

**Established 2026-09-15 by an explicit witness, [witness_I106_G2.py](../scripts/misc/witness_I106_G2.py). Gate 2 owed.**

**The claim refuted.** $G(2)$ of the [I106 derivation](../reviews/2026-09-15-I106-m3-derivation.md), batch 6: *for two free traceless symmetric $3\times3$ blocks in diagonal external fields $A,C$, the maximum of $\Phi(U,V)=\tfrac{15}4\operatorname{tr}U^3+\tfrac94\operatorname{tr}(UV^2)+\operatorname{tr}(UA)+\operatorname{tr}(VC)$ at fixed $\lvert U\rvert,\lvert V\rvert$ is attained at $U,V$ diagonal in the fields' frame.* It is what the $\lvert J\rvert=3$ block step of [R27](../routes.md) becomes when all outer blocks but two share a frame (the derivation's batch 5), and its one-block case is [L228](second-order.md)'s item 3.

**The witness.** At $A=\operatorname{diag}(\sqrt2,-\sqrt2,0)$, $C=\tfrac5{\sqrt2}\operatorname{diag}(0,1,-1)$ and $\lvert U\rvert=\lvert V\rvert=1$,
$$U\approx\begin{pmatrix}0.485853&0&0.525416\\0&-0.459487&0\\0.525416&0&-0.026366\end{pmatrix},\qquad V\approx\begin{pmatrix}0.077333&0&-0.210166\\0&0.633156&0\\-0.210166&0&-0.710488\end{pmatrix},$$
traceless, of unit norm and not commuting, with $\Phi=7.50308$, while every diagonal pair gives at most $7.38578$: a $4001\times4001$ grid on the two circles of diagonal configurations and a continuous refinement agree, and the grid's Lipschitz error bound is $0.039$, below the gap of $0.117$.

**Why it happens.** For fixed $V$ the best $U$ gives a convex, invariant, hence Schur-convex function of $\beta V^2+A$, which Fan's majorisation makes largest when $V$'s squares are ordered like $A$'s diagonal. Von Neumann makes $\operatorname{tr}(VC)$ largest when $V$'s entries are ordered like $C$'s. A diagonal $V$ realises one arrangement, and a rotated $V$ trades the two. *The witness keeps $e_2$ as a common eigenvector and rotates in the $(e_1,e_3)$-plane.* With either field zero the claim holds (the derivation's batch 7), so both fields are needed.

**What it does not touch.** The $\lvert J\rvert=3$ node itself: in the block problem the fields are $A=R^2+3T_R+\sum_c(\beta_{ac}+\beta_{bc})X_c$ and $C=\sum_c(\beta_{ac}-\beta_{bc})X_c$, built from the blocks held fixed and the scalars, and the maximisation runs over those too. Bounded ascents on the whole of $\mathcal S_J\cap\mathcal W_n$ at $n=5,6,7$ found commuting maximisers. [L228](second-order.md) is untouched.

**What a successor must clear.** *An induction through the block step must use how the fields are built from the blocks it holds fixed, or free all blocks at once.* A lemma about arbitrary diagonal fields is false at two blocks.

## Givens, quoted from [the I106 derivation](2026-09-15-I106-m3-derivation.md)

## Batch 5, two free blocks against a common frame reduce to L227 in two diagonal fields

Let every block but $X_a,X_b$ be diagonal in $F$, with $R=\sum_{c\ne a,b}X_c$ and $T_R=\sum_{c\ne a,b}X_c^2$. Put $U=X_a+X_b$, $V=X_a-X_b$ and shift $\hat U=U+\tfrac23R$.

- **The norm.** $\lvert X\rvert^2+\lvert X_a\rvert^2+\lvert X_b\rvert^2=\lvert U+R\rvert^2+\tfrac12\lvert U\rvert^2+\tfrac12\lvert V\rvert^2=\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2+\text{const}$.
- **The cubic part in $U,V$.** From item 1 of L228, $2\operatorname{tr}(U+R)^3+\tfrac32\operatorname{tr}\big((U+R)(U^2+V^2)\big)+3\operatorname{tr}\big((U+R)T_R\big)+\tfrac14\operatorname{tr}U^3+\tfrac34\operatorname{tr}(UV^2)+\text{const}$, so $\tfrac{15}4\operatorname{tr}U^3+\tfrac{15}2\operatorname{tr}(U^2R)+\tfrac94\operatorname{tr}(UV^2)+\tfrac32\operatorname{tr}(V^2R)+\operatorname{tr}\big(U(6R^2+3T_R)\big)+\text{const}$.
- **The shift.** Substituting $U=\hat U-\tfrac23R$: the $\operatorname{tr}(\hat U^2R)$ coefficient is $\tfrac{15}4\cdot3\cdot(-\tfrac23)+\tfrac{15}2=0$, and the $\operatorname{tr}(V^2R)$ coefficient is $\tfrac94\cdot(-\tfrac23)+\tfrac32=0$. **Both quadratic couplings to the frame cancel.** The linear coefficient of $\operatorname{tr}(\hat UR^2)$ is $\tfrac{15}4\cdot3\cdot\tfrac49-\tfrac{15}2\cdot\tfrac43+6=1$.
- **The Gram part.** $2\beta_{ab}\operatorname{tr}(X_aX_b)=\tfrac12\beta_{ab}(\lvert U\rvert^2-\lvert V\rvert^2)$ is frame-free, and the cross terms with $c\ne a,b$ are $\sum_c\big((\beta_{ac}+\beta_{bc})\operatorname{tr}(UX_c)+(\beta_{ac}-\beta_{bc})\operatorname{tr}(VX_c)\big)$.

So, up to terms fixed by the frame data and the norms, $$\Phi(\hat U,V)=\tfrac{15}4\operatorname{tr}\hat U^3+\tfrac94\operatorname{tr}(\hat UV^2)+\operatorname{tr}(\hat UA)+\operatorname{tr}(VC),\qquad A=R^2+3T_R+\sum_c(\beta_{ac}+\beta_{bc})X_c,\quad C=\sum_c(\beta_{ac}-\beta_{bc})X_c,$$ with $A$ and $C$ diagonal in $F$ and the norm $\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2$. **The internal part is exactly [L227](../findings/second-order.md)'s value at two outer indices, with $U$ shifted, and the rest of the blocks acts as two diagonal external fields.**

**Where the alignments agree and where they may not.** For strong fields each of $\hat U$, $V$ aligns with its own field, both diagonal in $F$. For weak fields the internal part is maximised at commuting $\hat U,V$ (L227), and one common rotation, Birkhoff-linear in a single doubly stochastic matrix because $\hat U$ and $V$ share a frame, aligns the pair with both fields. In between, three orderings are involved, $\hat U$ against $A$, $V$ against $C$ and $\hat U$ against $V^2$, and they can disagree.

**Screen** ([screen_I106_pair_field.py](../scripts/misc/screen_I106_pair_field.py)): over 60 random diagonal fields and norm ratios, the general maximum of $\Phi$ was attained at diagonal $\hat U,V$ every time (off-diagonal entries at most $2\cdot10^{-5}$, commutator at most $5\cdot10^{-6}$), and it matched an exhaustive grid over diagonal configurations to within the grid's resolution. *Random fields rarely conflict: batch 8's fields with conflicting orderings refute the claim.*

## Batch 7, $G(2)$ with one field vanishing is proved, and the general case is two majorisations that disagree

Keep batch 5's $\Phi(\hat U,V)=\alpha\operatorname{tr}\hat U^3+\beta\operatorname{tr}(\hat UV^2)+\operatorname{tr}(\hat UA)+\operatorname{tr}(VC)$ at $\lvert\hat U\rvert=p$, $\lvert V\rvert=q$, with $\alpha,\beta\ge0$ and $A,C$ diagonal in $F$. For a symmetric $M$ put $\psi(M)=\sup\{\alpha\operatorname{tr}U^3+\operatorname{tr}(UM):U\text{ traceless symmetric},\lvert U\rvert=p\}$. It is a supremum of affine functions of $M$, hence convex, and $O(3)$-invariant, hence $\psi(M)=g(\lambda(M))$ with $g$ symmetric and convex on $\mathbb R^3$, hence Schur-convex. For fixed $V$, $\sup_{\hat U}\Phi=\psi(\beta V^2+A)+\operatorname{tr}(VC)$, and the supremum is attained at $\hat U$ commuting with $\beta V^2+A$, diagonal in any eigenframe of it.

**$C=0$.** By Fan's theorem ([Chayes, Theorem 2.4](../references/matrix-rearrangement-2020-arxiv/notes.md)), $\lambda(\beta V^2+A)\prec\lambda^\downarrow(\beta V^2)+\lambda^\downarrow(A)$, with equal sums. So $\psi(\beta V^2+A)\le g\big(\lambda^\downarrow(\beta V^2)+\lambda^\downarrow(A)\big)$. The right side is $\psi(\beta V'^2+A)$ for $V'=F\operatorname{diag}(\nu')F^{\mathsf T}$, where $\nu'$ is $V$'s spectrum arranged so that $\nu'^2$ is ordered like the diagonal of $A$: $V'$ is traceless with $\lvert V'\rvert=\lvert V\rvert$ and $\beta V'^2+A$ is diagonal with that sorted spectrum. Then the optimal $\hat U'$ is diagonal in $F$. **So $G(2)$ holds when $C=0$**, which at the block level is $\sum_{c\ne a,b}(\beta_{ac}-\beta_{bc})X_c=0$, for instance a pair with $K_{ac}-t_a=K_{bc}-t_b$ at every external $c$.

**$A=0$.** $\psi(\beta V^2)$ depends on $V$'s spectrum alone, so at fixed spectrum only $\operatorname{tr}(VC)$ depends on $V$'s frame, it is maximised at $V$ diagonal in $F$ in von Neumann's order, and $\hat U$ then aligns with the diagonal $\beta V^2$. **So $G(2)$ holds when $A=0$.**

**Both fields.** Fan bounds the $\hat U$-side value by the arrangement of $V$'s squares ordered like $A$, von Neumann bounds $\operatorname{tr}(VC)$ by the arrangement of $V$'s entries ordered like $C$, and a single diagonal $V'$ realises one arrangement. *An argument through the pinching $\Delta_F$ runs the wrong way*: for convex invariant $\psi$, $\psi(\beta V^2+A)\ge\psi\big(\Delta_F(\beta V^2)+A\big)$, a lower bound where an upper bound is needed. **The general $G(2)$ is therefore the question whether, at an optimum, the square-ordering Fan prefers and the entry-ordering von Neumann prefers can be taken equal**, and batch 8 answers it in the negative for arbitrary fields.

## Items

1. **The refuted claim.** Is $G(2)$ as the post states it the claim batch 5 reduces the block step to, and are the coefficients $\tfrac{15}4$, $\tfrac94$ and the norms consistent with batch 5?
2. **The witness.** Are $U$ and $V$ traceless, symmetric, of unit norm and non-commuting to the printed precision? Recompute $\Phi$ at them with the stated $A$ and $C$. Does rounding to six digits change the conclusion?
3. **The diagonal supremum.** Bound $\sup\Phi$ over diagonal traceless $U,V$ of unit norm by an argument with a stated error, independently of the script's grid. Is the gap real and larger than every error in play?
4. **"Why it happens."** Is the account through Fan's majorisation and von Neumann's inequality right, and is the common eigenvector $e_2$ correctly described?
5. **"What it does not touch."** Do the displayed formulas for $A$ and $C$ match batch 5, and is it right that the witness refutes neither the $\lvert J\rvert=3$ node nor [L228](../findings/second-order.md)?
6. **"What a successor must clear."** Does the refutation support exactly this, no more?

## Logging and report

- Log to `agent_logs/review-r954.log`: first line with PID and phase plan, a line per phase, a heartbeat with live state at least every ~3 minutes, and a closing line that OPENS with `DONE <summary>` or `FAILED <reason>` (at most a timestamp before the word), written last.
- **Phase 0**: write `reviews/REVIEW_r954.md` as a skeleton (title, item table with every verdict `NOT REACHED`, log path), then `git add reviews/REVIEW_r954.md` in one call and **`git commit -m "review(F68): r954 skeleton" -- reviews/REVIEW_r954.md`** in a separate call. **Always commit by that pathspec.**
- Do not edit [reviews/INDEX.md](INDEX.md), the findings, the plan, any script or any Lean file. Never `git -C`, never amend, never stage another file. No em dashes, no semicolons joining clauses. Use aaa@aaa.com if a tool asks for an email.
