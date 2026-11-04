# Review r954, post F68 (Gate 2)

Brief: [BRIEF_F68.md](BRIEF_F68.md). Log: [agent_logs/review-r954.log](../agent_logs/review-r954.log). Single reader. Computation was limited to the fixed witness, its diagonal supremum, and three screens of claims recorded below, each seconds long and reported as a screen.

**Verdict.** The refutation of the fixed-norms lemma stands and the numbers are right. Three passages claim more than the witness gives or carry an inherited formula error: the claim refuted is stronger than $G(2)$ as batch 6 defines it, batch 5's field $A$ (quoted in the post) omits a term $-\tfrac23\beta_{ab}R$, and the successor clause states a dichotomy the witness does not force.

| Item | Verdict | Reason |
|---|---|---|
| 1. The refuted claim | REFUTED with corrections | Coefficients $\tfrac{15}4$, $\tfrac94$ and the norm $\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2$ are right, but the post's claim fixes $\lvert U\rvert$ and $\lvert V\rvert$ separately, while batch 6's $G(k)$ fixes the total norm. The witness does not refute the latter (a diagonal pair at the same total norm reaches $10.351$). |
| 2. The witness | CONFIRMED | Rounded matrices are symmetric, traceless to $10^{-6}$, of unit norm to $6\cdot10^{-7}$, commutator entry $0.52$, and $\Phi=7.5030796752$, a critical point to $4\cdot10^{-6}$. |
| 3. The diagonal supremum | CONFIRMED | Independent bound $\sup\le7.385789$ from a $3000^2$ periodic grid and an analytic second-derivative bound $1.8\cdot10^{-5}$. The gap is at least $0.11729$. The script's Lipschitz constant is valid. |
| 4. Why it happens | PLAUSIBLE with corrections | The Fan and von Neumann account matches batch 7 and the witness's spectrum, and $e_2$ is described correctly. The symbol $\beta$ is undefined in the post and collides with $\beta_{ac}$ two sentences later. |
| 5. What it does not touch | REFUTED with corrections | The formula for $A$ matches batch 5 verbatim, but both omit $-\tfrac23\beta_{ab}R$ (screen exact to $10^{-10}$). The claims that the node and L228 are untouched are CONFIRMED. |
| 6. What a successor must clear | REFUTED with corrections | The witness refutes a fixed-norms two-block lemma. It leaves $G(2)$ at fixed total norm undecided and says nothing about steps that free three or more blocks in diagonal fields, so "must ... or free all blocks at once" overstates it. |

## Item 1, the refuted claim

**Batch 5 rederived by hand.** From L228 item 1 with $X=U+R$, $X_a=\tfrac12(U+V)$, $X_b=\tfrac12(U-V)$:

- $\mathop{\mathrm{tr}}U^3$ collects $2+\tfrac32+\tfrac14=\tfrac{15}4$, $\mathop{\mathrm{tr}}(U^2R)$ collects $6+\tfrac32=\tfrac{15}2$, $\mathop{\mathrm{tr}}(UV^2)$ collects $\tfrac32+\tfrac34=\tfrac94$, and $\mathop{\mathrm{tr}}(V^2R)$ collects $\tfrac32$. The shift cancellations and the coefficient $1$ on $\mathop{\mathrm{tr}}(\hat UR^2)$ check.
- The norm: $\lvert\hat U+\tfrac13R\rvert^2+\tfrac12\lvert\hat U-\tfrac23R\rvert^2$ has cross coefficient $\tfrac23-\tfrac23=0$, so $\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2+\text{const}$ holds.
- The post's $\Phi(U,V)$ is batch 5's $\Phi(\hat U,V)$ with the hat dropped. That is harmless for an abstract lemma, but the post never says that its $U$ is the shifted sum.

**The gap between the post's claim and batch 6's $G(2)$.** Batch 6 defines $G(k)$ as "the maximum of $P$ at fixed norm over the free blocks is attained with the free blocks diagonal in $F$". The fixed norm is $\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2$, so the split between $\lvert\hat U\rvert$ and $\lvert V\rvert$ is free. The post fixes $\lvert U\rvert$ and $\lvert V\rvert$ separately.

- The fixed-norms claim implies batch 6's $G(2)$. The converse does not hold, so a counterexample to the fixed-norms claim is no counterexample to batch 6's $G(2)$ unless the witness also beats every diagonal pair on the whole ellipse.
- **Screen** (seconds, scratchpad, reported as a screen). At the witness fields with $\beta_{ab}=0$, $P$ at fixed total norm equals $\Phi$ plus a constant. The total norm at the witness is $\tfrac32+\tfrac12=2$. The diagonal pair with $\lvert\hat U\rvert=0.3204$, $\lvert V\rvert=1.9215$ (a grid point on $720^2$ angles and $801$ splits) has $\Phi=10.351$. A grid value is attained, so no error term is needed. It exceeds the witness's $7.503$, so **the witness is no counterexample to batch 6's $G(2)$**. Whether $G(2)$ at fixed total norm fails needs a general maximisation over the ellipse. That search lies outside this brief and was not run.
- "Its one-block case is L228's item 3" is right: with one free block the norm fixes $\lvert Y_a\rvert$, and item 3's proof is exactly the diagonal rearrangement.

## Item 2, the witness

Checked in exact rationals and in floating point, independently of the filed script:

- **Symmetry and trace.** Both printed matrices are symmetric. $\mathop{\mathrm{tr}}U=0$ exactly and $\mathop{\mathrm{tr}}V=10^{-6}$ at six digits.
- **Norms.** $\lvert U\rvert^2-1=5.5\cdot10^{-7}$ and $\lvert V\rvert^2-1=-3.9\cdot10^{-7}$.
- **Non-commuting.** $\max\lvert[U,V]_{ij}\rvert=0.5216$ and $\lVert[U,V]\rVert=0.738$.
- **Value.** With $A=\mathop{\mathrm{diag}}(\sqrt2,-\sqrt2,0)$ and $C=\tfrac5{\sqrt2}\mathop{\mathrm{diag}}(0,1,-1)$, $\Phi=7.5030796752$ at the rounded matrices and $7.5030796762$ after projecting them back to traceless unit norm. Rounding moves $\Phi$ by about $10^{-9}$, against a gap of $0.117$, so **it does not change the conclusion**.
- **Criticality.** The tangential gradients on the two spheres have norms $3.6\cdot10^{-6}$ and $3.8\cdot10^{-6}$, and $\lvert[U,\tfrac94V^2+A]\rvert_{\max}=1.4\cdot10^{-6}$, as batch 7 predicts for the optimal $U$ at fixed $V$.
- **Script.** The filed script reproduces $\Phi=7.5030796761576966$, grid maximum $7.385776004$, refined $7.385776767$, bound $L h=0.0393$ and gap $0.11730$. The run took 7 seconds.
- **Fields.** Batch 8's $a=2(1,-1,0)/\sqrt2$ equals the post's $A$.

## Item 3, the diagonal supremum

**Method, independent of the script.** Diagonal traceless unit matrices are $u(\theta)=\sqrt{2/3}\,(\cos\theta,\cos(\theta-\tfrac{2\pi}3),\cos(\theta+\tfrac{2\pi}3))$, and the same holds for $v(\varphi)$. Then $f(\theta,\varphi)=\tfrac{15}4\sum u_i^3+\tfrac94\sum u_iv_i^2+a\cdot u+c\cdot v$ is a periodic trigonometric polynomial.

- **Interpolation bound.** Bilinear interpolation on a periodic grid of step $h$ gives $\sup f\le\max_{\text{grid}}f+\tfrac{h^2}8(M_{\theta\theta}+M_{\varphi\varphi})$, since the interpolant is at most its largest corner.
- **Curvature bounds.** $u''=-u$ and $\sum u_i^3=\tfrac1{\sqrt6}\cos3\theta$. With $\lvert v^2\rvert\le1$ and $\lvert u\cdot v'^2\rvert\le1$ this gives $M_{\theta\theta}\le\tfrac{15}4\cdot\tfrac9{\sqrt6}+\tfrac94+\lvert a\rvert=18.03$ and $M_{\varphi\varphi}\le\tfrac94\cdot4+\lvert c\rvert=14$. Finite differences on the grid observe $16.43$ and $8.67$.
- **Result.** At $N=3000$ the error term is $1.76\cdot10^{-5}$ and the grid maximum is $7.3857716$, so **$\sup\le7.385789$**. The maximiser sits near $u=(0.814,-0.465,-0.349)$, $v=(0.089,0.659,-0.747)$.
- **Gap.** $7.5030797-7.385789\ge0.11729$, which exceeds every error in play: rounding ($10^{-9}$), the interpolation bound ($1.8\cdot10^{-5}$) and the script's Lipschitz bound ($0.039$).
- **The script's Lipschitz bound is valid and conservative.** Its $L=25$ dominates the gradient norm, which is at most $\sqrt{(11.25+2+2.25)^2+(5+4.5)^2}\approx18.2$. It prints $Lh$ where its comment derives $Lh/\sqrt2$. The Nelder–Mead refinement is no bound, and the post only says it agrees.

## Item 4, why it happens

- **Checks against batch 7.** The chain holds as batch 7 states it: $\psi$ is convex and $O(3)$-invariant, hence Schur-convex in the spectrum. Fan gives $\lambda(\beta V^2+A)\prec\lambda^\downarrow(\beta V^2)+\lambda^\downarrow(A)$, and von Neumann orders $\mathop{\mathrm{tr}}(VC)$. Batch 7's two one-field cases were reread and hold at fixed $\lvert\hat U\rvert,\lvert V\rvert$.
- **The witness matches the account.** $V$ has spectrum $(0.633,0.130,-0.763)$. Against $C$ (order $e_2>e_1>e_3$), von Neumann puts $0.633$ on $e_2$, $0.130$ on $e_1$ and $-0.763$ on $e_3$. Against $A$ (order $e_1>e_3>e_2$), Fan puts the largest square, from $-0.763$, on $e_1$. In the witness $0.633$ sits on $e_2$, and the eigenvector of $-0.763$ is $(0.243,0,0.970)$, about $14^\circ$ from $e_3$ towards $e_1$. So the rotation in the $(e_1,e_3)$-plane moves between von Neumann's and Fan's placement of that eigenvalue.
- **$e_2$.** The zero pattern gives $Ue_2=-0.459487\,e_2$ and $Ve_2=0.633156\,e_2$, so the italic sentence is exact.
- **Defects.**
  - $\beta$ is undefined in the post. It is batch 7's $\tfrac94$ and collides with $\beta_{ac}$ in the next section.
  - "A diagonal $V$ realises one arrangement" leaves out the qualifier "when the two differ". When they agree, a diagonal $V$ realises both.
  - The account explains the witness. It proves nothing, and the post presents it as an account, which is appropriate.

## Item 5, what it does not touch

**The field $A$ in batch 5, and so in the post, omits $-\tfrac23\beta_{ab}R$.**

- **Derivation.** The Gram term $\tfrac12\beta_{ab}\lvert U\rvert^2$ is frame-free in $U$ but not in $\hat U$. It equals $\tfrac12\beta_{ab}\big(\lvert\hat U\rvert^2-\tfrac43\mathop{\mathrm{tr}}(\hat UR)+\tfrac49\lvert R\rvert^2\big)$, and at fixed $\lvert\hat U\rvert$ it contributes $\mathop{\mathrm{tr}}\big(\hat U\cdot(-\tfrac23\beta_{ab}R)\big)$.
- **Screen.** At $m=4$, with random symmetric $\beta$ ($\beta_{ab}=-1.584$), two random diagonal external blocks and random $\hat U,V$ rotated independently at fixed norms, the change in $P$ from L228 item 1 equalled the change in $\Phi$ with the corrected $A$ to ten digits in four trials ($+20.7809972131$ against $+20.7809972131$, for example). With the printed $A$ the changes were off by several units ($+13.7768842006$ for that trial). $C$ as printed is right, and the norm stayed unchanged to $2\cdot10^{-14}$.
- **Effect.** The omitted term is diagonal in $F$, so the refutation for arbitrary diagonal fields is unaffected. Only the displayed formula is wrong.

**Node and L228: CONFIRMED.**

- The witness refutes a strengthening of the node ($G$ with arbitrary fields and fixed norms), so it bears on neither the node nor its value.
- L228's items 3 and 4 need all blocks but one, or the rest and $X_a+X_b$, diagonal in $F$. In the witness $\hat U$ is not diagonal, so neither stratum contains it.
- The cited ascents exist ([first derivation](2026-09-15-I106-derivation.md), screens: 60 starts, $\Theta_5,\Theta_6,\Theta_7$ reached at blocks commuting to $10^{-8}$). That source itself records that they refute nothing and prove nothing. At $n=5$ ($m=2$) there are no external blocks, and L227 proves that case, so only $n=6,7$ bear on $m\ge3$.

**Observation (by hand).** At $m=3$, which is $n=6$, the witness's fields cannot be realised.

- With one external block $X_c$, $C$ is a multiple of $X_c$, so $X_c=x\mathop{\mathrm{diag}}(0,1,-1)$.
- The traceless part of $A=4X_c^2+\kappa X_c$ is $\tfrac43x^2\mathop{\mathrm{diag}}(-2,1,1)+\kappa x\mathop{\mathrm{diag}}(0,1,-1)$.
- The witness's $A=\mathop{\mathrm{diag}}(\sqrt2,-\sqrt2,0)$ needs the coefficient $-\tfrac1{\sqrt2}<0$ on $\mathop{\mathrm{diag}}(-2,1,1)$, which is impossible.
- This supports the post's point that the built fields are special. Realisability at $m\ge4$ was not checked.

## Item 6, what a successor must clear

The witness supports this much: a lemma asserting diagonal attainment for two free blocks in arbitrary diagonal fields at fixed $\lvert\hat U\rvert$ and $\lvert V\rvert$ is false, so an induction whose two-block step is that lemma fails. Three things it does not support:

- **$G(2)$ at fixed total norm, which is batch 6's own definition.** By item 1's screen the witness is no counterexample there, and that form is undecided.
- **Steps that free three or more blocks together in diagonal fields.** These are not implied by $G(2)$ and not refuted by it, so "or free all blocks at once" is too narrow a disjunction.
- **The title's "one at a time".** $G(2)$ frees two blocks jointly. What fails is the two-block step of the family.

The same overreach appears in batch 8's "What follows" ("no induction through blocks in arbitrary diagonal fields can prove the node") and in the R27 row of [routes.md](../routes.md) ("an induction freeing blocks one at a time in arbitrary diagonal fields fails at two blocks"). Both are outside this brief's scope for edits.

## Corrections

**C1 (item 1), post F68, "The claim refuted".**

- Replace "$G(2)$ of the [I106 derivation](../reviews/2026-09-15-I106-m3-derivation.md), batch 6: *for two free traceless symmetric $3\times3$ blocks in diagonal external fields $A,C$," with "The fixed-norms form of $G(2)$ of the [I106 derivation](../reviews/2026-09-15-I106-m3-derivation.md), batch 6, which implies $G(2)$ as batch 6 defines it at fixed total norm $\tfrac32\lvert U\rvert^2+\tfrac12\lvert V\rvert^2$: *for two free traceless symmetric $3\times3$ blocks in diagonal external fields $A,C$,".
- After the italic claim insert "Here $U$ is batch 5's shifted sum $\hat U=X_a+X_b+\tfrac23R$ and $V=X_a-X_b$."

**C2 (item 4), post F68, "Why it happens".**

- Replace "a convex, invariant, hence Schur-convex function of $\beta V^2+A$" with "a convex, invariant, hence Schur-convex function of $\tfrac94V^2+A$".
- Replace "A diagonal $V$ realises one arrangement, and a rotated $V$ trades the two." with "When the two arrangements differ a diagonal $V$ realises only one of them, and a rotated $V$ trades between them: the witness's $V$ has spectrum $(0.633,0.130,-0.763)$ with $0.633$ on $e_2$ as von Neumann places it, and the eigenvector of $-0.763$ lies about $14^\circ$ from $e_3$, von Neumann's place, towards $e_1$, Fan's."

**C3 (item 5), post F68, "What it does not touch", and batch 5's display in [the derivation](2026-09-15-I106-m3-derivation.md).**

- Replace "$A=R^2+3T_R+\sum_c(\beta_{ac}+\beta_{bc})X_c$" with "$A=R^2+3T_R+\sum_c(\beta_{ac}+\beta_{bc})X_c-\tfrac23\beta_{ab}R$" in both places.
- In batch 5's Gram bullet, replace "$2\beta_{ab}\mathop{\mathrm{tr}}(X_aX_b)=\tfrac12\beta_{ab}(\lvert U\rvert^2-\lvert V\rvert^2)$ is frame-free," with "$2\beta_{ab}\mathop{\mathrm{tr}}(X_aX_b)=\tfrac12\beta_{ab}(\lvert U\rvert^2-\lvert V\rvert^2)$, where $\tfrac12\beta_{ab}\lvert U\rvert^2=\tfrac12\beta_{ab}\lvert\hat U\rvert^2-\tfrac23\beta_{ab}\mathop{\mathrm{tr}}(\hat UR)+\text{const}$ puts $-\tfrac23\beta_{ab}R$ into $A$,".

**C4 (item 5, optional), post F68, "What it does not touch".**

- After "built from the blocks held fixed and the scalars, and the maximisation runs over those too." insert "At $m=3$ the witness's fields are not realisable: $C$ is a multiple of the one external block $X_c=x\mathop{\mathrm{diag}}(0,1,-1)$, and the traceless part of $A$ carries $\tfrac43x^2\ge0$ on $\mathop{\mathrm{diag}}(-2,1,1)$ where the witness needs $-\tfrac1{\sqrt2}$."
- Replace "at $n=5,6,7$ found commuting maximisers" with "at $n=5,6,7$ found commuting maximisers, of which $n=6,7$ have external blocks".

**C5 (item 1 and item 6), post F68, "What it does not touch".** Append "It leaves $G(2)$ at fixed total norm undecided: at the witness fields with $\beta_{ab}=0$ a diagonal pair at the same total norm $2$ reaches $\Phi=10.351$, above the witness's $7.503$."

**C6 (item 6), post F68, "What a successor must clear".**

- Replace "*An induction through the block step must use how the fields are built from the blocks it holds fixed, or free all blocks at once.* A lemma about arbitrary diagonal fields is false at two blocks." with "*An induction through the block step whose two-block step holds $\lvert\hat U\rvert$ and $\lvert V\rvert$ fixed must use how the fields are built from the blocks it holds fixed.* A lemma about arbitrary diagonal fields at fixed norms of the two free variables is false at two blocks. $G(2)$ at fixed total norm, and steps freeing three or more blocks in diagonal fields, are not decided by this witness."
- Retitle the post "Post F68, freeing two outer blocks at fixed norms in arbitrary diagonal fields fails". Make the matching change to batch 8's "What follows", the batch 6 bullet on $G(2)$, and the R27 row of [routes.md](../routes.md).

## Screens run (scratchpad, not filed)

- Witness recheck at the rounded matrices (item 2).
- Diagonal supremum by periodic grid and second-derivative bound (item 3).
- Batch 5 field check against L228 item 1 at $m=4$ (item 5).
- Diagonal value over the norm split at the witness fields (items 1 and 6).
