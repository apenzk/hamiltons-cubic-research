# Review r737, Lemma L163, [L37](../findings/target.md)'s two witnesses in closed form (Gate 2)

*Adversarial Gate 2 review, cold from the definitions, on the brief `gate2-L163.md`. Analysis only: every claim below is proved by hand, and the exact-arithmetic runs reported are screens on objects built for the purpose, five rational $A$ on $\mathbb R^4$, the two Fubini–Study Weyl operators, and their zero-paddings at $n\le9$. No sweep, no census, no floating point.*

## Verdict

**GAP.** The mathematics of both parts is correct, and part (a) is CONFIRMED as an equality. Part (b) is true but is the wrong statement for its consumer: **it is a lower bound, and the two things L37 buys from it (the reproduction of the measured rows, and the non-diagonality of padded $W_{\mathbb{CP}^2}$), both need the kernel exactly.** The block asserts non-diagonality and does not prove it. A three-line strengthening supplies everything owed, and it is written out below.

| item | verdict |
| --- | --- |
| (a) $\ker\Phi_{W_{\mathbb{CP}^2}}=\mathbb R\,\mathrm{Id}$, both inclusions | **CONFIRMED** |
| the exchange claim, $\delta_{A_0}:\Lambda^\pm\to\Lambda^\mp$ for trace-free symmetric $A_0$ | **CONFIRMED**, and trace-freeness is exactly the hypothesis |
| the Sylvester step at $W_{\mathbb{CP}^2}$ | **CONFIRMED**, and it is not needed, one line replaces it |
| the displayed block matrix | **REFUTED as printed**: it is symmetric, and $[W,\delta_{A_0}]$ is skew |
| (b) $\dim\ker\Phi_{W_0\oplus0}\ge1+\binom{n-m+1}2$ | **CONFIRMED**, and **strict in general**, witness below |
| *"reproduces three measured rows"* | **REFUTED as stated**: two of the three are not derived, and one is content-free |
| padded $W_{\mathbb{CP}^2}$ at $n=8$ is non-diagonal | **true, and NOT established by this lemma**, the gap |
| the prediction $37$ at $n=12$ | **CONFIRMED**, and it is an equality once the repair is in |

## (a) The exchange claim, from the definition

$\delta_A$ is the derivation extension $u\wedge v\mapsto Au\wedge v+u\wedge Av$ ([L37](../findings/target.md)), so in an eigenframe of $A$ it is diagonal with $\delta_A\varphi_{ij}=(a_i+a_j)\varphi_{ij}$. Fix the self-dual basis $\omega_1^\pm=\varphi_{12}\pm\varphi_{34}$, $\omega_2^\pm=\varphi_{13}\mp\varphi_{24}$, $\omega_3^\pm=\varphi_{14}\pm\varphi_{23}$.

**Diagonal $A_0$.** $\delta_{A_0}\omega_1^+=(a_1+a_2)\varphi_{12}+(a_3+a_4)\varphi_{34}$, and trace-freeness is exactly $a_3+a_4=-(a_1+a_2)$, so this is $(a_1+a_2)\,\omega_1^-$. The other two pairs are identical, and the same computation sends $\omega_k^-$ to a multiple of $\omega_k^+$. **The hypothesis is used at the one step where it can be**: without it the image is $\tfrac{a_i+a_j+a_k+a_l}2\omega^++\ldots$, which has a $\Lambda^+$ component.

**General $A_0$.** Every symmetric $A_0$ is $gDg^{\mathsf T}$ with $g\in SO(4)$ (an eigenvector may be sign-flipped to fix the determinant) and $\delta_{gDg^{\mathsf T}}=\Lambda^2(g)\,\delta_D\,\Lambda^2(g)^{-1}$ with $\Lambda^2(g)$ preserving $\Lambda^\pm$ for $g\in SO(4)$. So the exchange transports. **The claim is true for every trace-free symmetric $A_0$, and the answer to *"what if it only maps into the sum"* is that this never happens.**

*Screened exactly on five rational $A$ on $\mathbb R^4$, diagonal, off-diagonal, and a generic trace-free one with denominators, plus $\mathrm{Id}$ and a trace-$4$ perturbation. Both diagonal blocks vanish for the three trace-free ones and for neither of the other two.*

## (a) The rest of the chain

**The Sylvester step is right and is more machinery than the case needs.** With $W^-=0$ the two off-diagonal blocks read $\beta W^+=0$ and $W^+\beta^{*}=0$, so invertibility of $W^+$ gives $\beta=0$ in one line; Sylvester's criterion is the general statement and specialises correctly, $\operatorname{spec}(W^-)=\{0\}$ making disjointness of the spectra the same condition as invertibility of $W^+$. **And $W^+$ is invertible in the record's normalisation**: [findings/INDEX-values.md](../findings/INDEX-values.md) fixes the $\Lambda^2$ spectrum at $(2,-1,-1,0,0,0)/\sqrt6$, and I rebuilt the operator independently from the complex-space-form curvature tensor at holomorphic sectional curvature $4$, $\mathcal R$ has eigenvalues $2(m+1)$ on $\mathbb R\omega$, $2$ on $\Lambda^{1,1}_0$, $0$ on $[\![\Lambda^{2,0}]\!]$, and $W=\mathcal R-\tfrac{\operatorname{scal}}{n(n-1)}\mathrm{Id}$ returns $(4,-2,-2,0,0,0)$ at $m=2$, which is the record's spectrum doubled. $\Lambda^+=\mathbb R\omega\oplus[\![\Lambda^{2,0}]\!]$ carries $4,-2,-2$ and $\Lambda^-=\Lambda^{1,1}_0$ carries $0,0,0$.

**Both inclusions of the equality hold.** $\supseteq$ is $\delta_{\mathrm{Id}}=2\,\mathrm{Id}_{\Lambda^2}$. For $\subseteq$: $\Phi_W$ is linear and kills $\mathrm{Id}$, so $A\in\ker$ iff $A_0\in\ker$; $\beta=0$ together with the exchange gives $\delta_{A_0}=0$ outright, since the exchange says $\delta_{A_0}$ *has* no diagonal blocks; and $\delta_{A_0}=0$ forces $a_i+a_j=0$ for all $i<j$, hence $A_0=0$ at $n\ge3$. **The step $\beta=0\Rightarrow\delta_{A_0}=0$ spends the exchange a second time and the proof does not say so.**

**The displayed matrix is wrong by a sign.** As printed its lower-left block is $\beta W^+-W^-\beta$ and its upper-right is $W^+\beta^{*}-\beta^{*}W^-$, which is the transpose of the first, so the display is a *symmetric* matrix. But $W$ and $\delta_{A_0}$ are both symmetric operators on $\Lambda^2$, so $[W,\delta_{A_0}]^{\mathsf T}=-[W,\delta_{A_0}]$ and the true matrix is skew: one of the two blocks carries a minus sign. *Screened: $C+C^{\mathsf T}=0$ exactly, $C-C^{\mathsf T}\ne0$.* **The conclusion is untouched** (both blocks vanish together either way) so this is bookkeeping, not a defect in the argument.

**One hypothesis is used and unstated.** *"On $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ write $W=W^+\oplus W^-$"* presupposes that $W$ commutes with the Hodge star, which holds for an algebraic Weyl tensor by the first Bianchi identity and fails for a general linear operator on $\Lambda^2$. **L37's own scope is *every* linear operator on $\Lambda^2\mathbb R^n$**, so a reader carrying (a)'s method across at that scope gets a false step. It is benign here, $W_{\mathbb{CP}^2}$ being a Weyl tensor.

## (b) The bound is true, weak, and strict

**The proof of (b) is correct.** $A=a\,\mathrm{Id}_m\oplus B$ makes $\delta_A$ preserve all three summands ($2a$ on $\Lambda^2\mathbb R^m$, $a+B$ on $\mathbb R^m\otimes V$, $\delta_B$ on $\Lambda^2V$) so it commutes with $W_0\oplus0\oplus0$, and the family has dimension $1+\binom{n-m+1}2$.

**It is the special case $P\in\mathbb R\,\mathrm{Id}_m$ of a bound that is free.** Write $A=\begin{pmatrix}P&C\\C^{\mathsf T}&B\end{pmatrix}$. The diagonal-block part $\delta_{P\oplus B}$ preserves the three summands and $\delta_C$ moves $U_1\to U_2$, $U_2\to U_1\oplus U_3$, $U_3\to U_2$. Since $W$ vanishes on $U_2\oplus U_3$, every commutator block with $U_2$ or $U_3$ on both sides is zero automatically, and $[W,\delta_A]=0$ reduces to exactly three conditions:

- **$U_1\to U_1$:** $[W_0,\delta_P]=0$, i.e. $P\in\ker\Phi_{W_0}$;
- **$U_1\to U_2$:** $\delta_C$ vanishes on $\operatorname{im}W_0$;
- **$U_2\to U_1$:** $(\delta_CY)_{U_1}\in\ker W_0$ for every $Y\in U_2$.

$B$ appears in none of them. So

$$\ker\Phi_{W_0\oplus0}\;\supseteq\;\ker\Phi_{W_0}\oplus\operatorname{Sym}^2(V),\qquad \dim\ker\Phi_{W_0\oplus0}\;\ge\;\dim\ker\Phi_{W_0}+\binom{n-m+1}2 ,$$

which contains the block's bound because $\mathbb R\,\mathrm{Id}_m\subseteq\ker\Phi_{W_0}$ always.

**The inequality as stated is strict, and badly so.** Take $W_0$ diagonal in the $\varphi_{ij}$ basis of $\Lambda^2\mathbb R^4$, $W_0=\operatorname{diag}(1,\dots,6)$ serves. Every diagonal $A$ is then in the kernel, so unpadded the truth is $4$ against the block's bound $1$; padded to $n=6$ the truth is $7$ against the block's $4$, and $7=4+\binom32$ is the sharper bound on the nose. *Screened exactly.* **So the answer to *"find a $W_0$ where the inequality is strict"* is that it is strict at every diagonal $W_0$, which is the whole family L37's corollary exists to separate off.**

## When the bound is an equality, and the gap this closes

**The two $C$-conditions force $C=0$ as soon as $\operatorname{im}W_0$ contains a nondegenerate $2$-form.** Writing $\gamma=C^{\mathsf T}:\mathbb R^m\to V$ with matrix $G$, the first condition unwinds to $\delta_CX=\sum_{i,\alpha}(xG^{\mathsf T})_{i\alpha}\,e_i\wedge f_\alpha$, so it says $Gx=0$ for every skew $x\in\operatorname{im}W_0$. If one such $x$ is invertible, $G=0$. Hence

> **Proposition (r737).** If $\operatorname{im}W_0\subseteq\Lambda^2\mathbb R^m$ contains an invertible skew matrix, then $\ker\Phi_{W_0\oplus0}=\ker\Phi_{W_0}\oplus\operatorname{Sym}^2(V)$ **exactly**, and $W_0\oplus0$ is diagonal in some frame of $\mathbb R^n$ if and only if $W_0$ is diagonal in some frame of $\mathbb R^m$.

The second clause follows from the first through L37: an $A=P\oplus B$ with pairwise-distinct sums needs $P$'s own sums distinct, and $P\in\ker\Phi_{W_0}$, which is diagonality of $W_0$; the converse direction extends $W_0$'s frame and puts the new planes in $\ker W$.

**The hypothesis holds at every $\mathbb{CP}^m$**, the Kähler form being an eigenvector of $W_{\mathbb{CP}^m}$ with nonzero eigenvalue and nondegenerate as a $2$-form.

**And the unpadded kernel is $\mathbb R\,\mathrm{Id}$ at every $m\ge2$, not only at $m=2$.** $W_{\mathbb{CP}^m}$ has three eigenvalues, $2(m+1)-\lambda_0$ on $\mathbb R\omega$, $2-\lambda_0$ on $\Lambda^{1,1}_0$ and $-\lambda_0$ on $[\![\Lambda^{2,0}]\!]$ with $\lambda_0=\tfrac{2(m+1)}{2m-1}$, pairwise distinct for every $m\ge2$. Split $A=A^++A^-$ into the parts commuting and anticommuting with $J$. Then $\delta_A\omega=2JA^+$, and preserving the line $\mathbb R\omega$ forces $A^+\in\mathbb R\,\mathrm{Id}$. And $\delta_{A^-}$ *exchanges* $\Lambda^{1,1}$ with $[\![\Lambda^{2,0}]\!]$ (for $XJ=JX$ one gets $J\delta_{A^-}X=-\delta_{A^-}XJ$) so preserving eigenspaces that are type-pure forces $\delta_{A^-}=0$, hence $A^-=0$. **This is (a)'s own mechanism at general $m$, with the type decomposition in place of $\Lambda^\pm$**, and it needs no Sylvester at all. *Screened: $\dim\ker\Phi=1$ exactly at $\mathbb{CP}^2$ and $\mathbb{CP}^3$.*

Together these give the four rows **as equalities**: $\dim\ker\Phi_{W_{\mathbb{CP}^m}}=1$ for every $m$, and $\dim\ker\Phi_{W_{\mathbb{CP}^m}\oplus0}=1+\binom{n-2m+1}2$ for every padding. *Screened exactly at padded $\mathbb{CP}^2$ for $n=5,6,7,8,9$ ($2,4,7,11,16$, matching the formula at every value) and at padded $\mathbb{CP}^3$ at $n=8$, which returns $4$.*

## What L37 actually consumes, and where the block falls short

L37's block leans on two witnesses. **(a) discharges the first exactly.** The second is *"the corollary runs one way only"*, and that needs a **non-diagonal** $W$ with $\dim\ker\Phi_W\ge n$.

> **(b) SUPPLIES ONE HALF OF THAT WITNESS AND ASSERTS THE OTHER.** The bound gives $\dim\ker\Phi_W\ge11>8$, which is the easy half. **Non-diagonality is stated in the same breath and proved nowhere**, and it cannot be proved from (b), because a lower bound on a kernel is consistent with the kernel containing an $A$ with pairwise-distinct sums, which by L37 is diagonality. *The corollary itself says nothing here, $11>8$ being on its silent side, so there is no fallback.*

The repair is the Proposition: the kernel is *exactly* $\mathbb R\,\mathrm{Id}_4\oplus\operatorname{Sym}^2(V)$, every member has the eigenvalue $a$ with multiplicity $4$, so the sum $2a$ is repeated $\binom42=6$ times and no member has pairwise-distinct sums, **non-diagonal, by L37's equivalence**. Independently, $W_{\mathbb{CP}^2}$ itself is non-diagonal in one line: $\varphi_{12}=\tfrac12(\omega_1^++\omega_1^-)$ can be an eigenvector only if the $\Lambda^-$ component matches, forcing the eigenvalue to $0$ and then $W^+\omega_1^+=0$ against invertibility.

**This is the failure mode the brief named.** The surviving statement is the most general of the three derivations and is a strict lower bound; its consumer needs an equality. *The general form is worth keeping (it costs nothing and covers every padding) but it must be stated in the sharper form above, or the witness it exists to supply does not follow.*

> **AND THE "THREE MEASURED ROWS" CALLOUT IS REFUTED AS WRITTEN.** A lower bound that agrees with a measurement is a consistency check, not a derivation of it. Of the three: **padded $\mathbb{CP}^2$ at $n=8$** gives $\ge11$, agreeing with $11$; **padded $\mathbb{CP}^3$ at $n=8$** gives $\ge4$ and depends on $\ker\Phi_{W_{\mathbb{CP}^3}}=\mathbb R\,\mathrm{Id}$, which (a) does not reach; and **unpadded $\mathbb{CP}^m$** degenerates to $1+\binom12=1$, which is the statement $\mathrm{Id}\in\ker\Phi_W$ and is true of *every* operator whatsoever, so it carries no information about $\mathbb{CP}^m$ at all. **One row is derived (the $n=4$ one, by (a)) and the callout claims three.** *With the Proposition and the general-$m$ kernel above, all four become theorems, on grounds the block does not contain.*

**The prediction is right.** $m=4$, $n=12$, $1+\binom92=37$. Under the Proposition it is an equality rather than a bound, and the same holds at every $n$.

## What would falsify each

| claim | falsifier |
| --- | --- |
| the exchange | one trace-free symmetric $A_0$ on $\mathbb R^4$ with a nonzero $\Lambda^+\to\Lambda^+$ block |
| (a)'s equality | a symmetric $A\notin\mathbb R\,\mathrm{Id}$ with $[W_{\mathbb{CP}^2},\delta_A]=0$ |
| $W^-=0$, $W^+$ invertible | a $\Lambda^2$ spectrum for $W_{\mathbb{CP}^2}$ other than $(2,-1,-1,0,0,0)/\sqrt6$ in this record's normalisation |
| the Proposition's equality | a $C\ne0$ solving both $C$-conditions when $\operatorname{im}W_0$ holds an invertible skew form |
| padded $W_{\mathbb{CP}^2}$ non-diagonal at $n=8$ | an orthonormal frame of $\mathbb R^8$ in which every coordinate $2$-plane is an eigenvector, equivalently, an $A$ in the $11$-dimensional kernel with pairwise-distinct sums |
| $\ker\Phi_{W_{\mathbb{CP}^m}}=\mathbb R\,\mathrm{Id}$ at all $m$ | a coincidence among $2(m+1)-\lambda_0$, $2-\lambda_0$, $-\lambda_0$, or a symmetric $A$ whose $J$-anticommuting part preserves the type decomposition |

## Owed

- **State (b) in the sharper form** $\dim\ker\Phi_{W_0\oplus0}\ge\dim\ker\Phi_{W_0}+\binom{n-m+1}2$, with the equality clause under the nondegenerate-image hypothesis. It is three lines and it is what L37 consumes.
- **Prove the non-diagonality** of padded $W_{\mathbb{CP}^2}$, or drop the word from the statement, as written the one-directionality witness is incomplete.
- **Restate the callout**: one row is derived by (a), the others follow only with the general-$m$ kernel computation above.
- **Fix the sign** in the displayed block matrix, and record that $W$ commutes with the Hodge star.
