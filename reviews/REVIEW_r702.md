# REVIEW r702, the corollary to Lemma L154: $X_{\mathrm{inv}}=0$ iff $\mathfrak p\oplus\mathfrak m$ is a $\mathbb Z_2$-graded subalgebra

**Target:** the block *COROLLARY, GATE 2 OWED* under [Lemma L154](../findings/bounds.md), and its source [DERIVE-j5](DERIVE-j5.md) batch 3.

**Standing rule honoured:** analysis only. Every check below is by hand from the definitions; the sole numbers are the $n=4$ spectrum $(2\varepsilon,-\varepsilon,-\varepsilon;0,0,0)$ and the normalisation $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, both taken from the definitions and worked through on paper.

**Plan followed.** (1) Read L7, L154, the corollary, batch 3, Result 5(a), Theorem A, r515/r516 F5, r699, traps W1–W4. (2) Attack the Gram-vanishing step and the equivalence of the four orthogonalities with the grading. (3) Decide $W_{\mathbb{CP}^2}$ at $n=4$ by hand. (4) $SU(3)$ by representation theory; search the record for prior statements. (5) Report.

## VERDICT: CONFIRMED, the corollary is true as stated, and it sharpens three sentences already on the record

The iff holds at every critical point $W\ne0$. Its proof needs exactly three inputs, all on the record: Result 5(a)'s three diagonal blocks (hypothesis-free algebra, re-derived below), the bracket-Gram form of $\#$, and L154(i). The corrections are to the prose around it, L7's "conditions modulo $\ker W$", L7's "no $\mathbb Z_2$-grading at all", r516's "equality does not force $E_+\oplus E_-$ closed", r699's "graded (mod $\ker W$)", each of which is now weaker than the truth at a critical point, and one sentence of the batch-3 screen that contradicts the hand analysis and must name its object.

## F1, The Gram-vanishing step is sound; degeneracy and zero weights cannot bite

Write $\omega(x,y,z)=\langle[x,y],z\rangle$ on $\mathfrak{so}(n)$. For $A=\sum a_\alpha\varphi_\alpha\varphi_\alpha^{\mathsf T}$, $B=\sum b_\beta\psi_\beta\psi_\beta^{\mathsf T}$ the record's rank-one identity and bilinearity give $\langle(A\#B)\xi,\xi\rangle=c\sum_{\alpha\beta}a_\alpha b_\beta\,\omega(\varphi_\alpha,\psi_\beta,\xi)^2$.

- **Zero weights.** The sum for $C=W_+\#W_-$ runs over an eigenbasis of $W_+$ and one of $W_-$; the terms with $a_\alpha=0$ or $b_\beta=0$ contribute nothing, and what remains is a sum over an orthonormal basis $\{\varphi_\alpha\}$ of $\mathfrak p=\mathop{\mathrm{ran}}W_+$ and one $\{\psi_\beta\}$ of $\mathfrak m=\mathop{\mathrm{ran}}W_-$ with **every weight strictly positive**. So $\langle C\xi,\xi\rangle=0$ forces $\omega(\varphi_\alpha,\psi_\beta,\xi)=0$ for every basis pair.
- **Degenerate eigenvalues.** A repeated eigenvalue leaves the eigenbasis free inside the eigenspace, but the conclusion $\omega(\varphi_\alpha,\psi_\beta,\xi)=0$ on one orthonormal basis of $\mathfrak p$ and one of $\mathfrak m$ extends by bilinearity of the bracket to $\omega(u,v,\xi)=0$ for all $u\in\mathfrak p$, $v\in\mathfrak m$. The basis choice is immaterial, and the left side is a well-defined operator in any case.
- **Same argument for the other two blocks.** $W_+^\#$ on $\xi$ vanishes iff $\omega|_{\mathfrak p\mathfrak p\xi}=0$; $W_-^\#$ iff $\omega|_{\mathfrak m\mathfrak m\xi}=0$; $\lvert W\rvert^\#$ iff $\omega|_{(\mathfrak p\oplus\mathfrak m)(\mathfrak p\oplus\mathfrak m)\xi}=0$, for $\lvert W\rvert$ an eigenbasis may mix $\mathfrak p$ and $\mathfrak m$ when $a_\alpha=b_\beta$, and again it does not matter, since any orthonormal basis of $\mathfrak p\oplus\mathfrak m$ with positive weights gives the same span condition.
- **From a quadratic form to a block.** Each block is PSD, so $P_bXP_b=0$ iff $\langle X\xi,\xi\rangle=0$ for all $\xi$ in that eigenspace; the "only a weighted combination" worry does not arise because a PSD form vanishes on a subspace iff every term of its positive-weight Gram expansion does.

So the brief's first pressure point does not open: **"vanishes iff $[\cdot,\cdot]\perp\cdot$" is correct**, with the perp taken against the span of the brackets.

## F2, The four orthogonalities are exactly the grading, and two of them are one condition

The block conditions, in terms of $\omega$ (totally antisymmetric, since $\langle\cdot,\cdot\rangle$ on $\Lambda^2$ is $O(n)$-invariant, hence $\mathrm{ad}$-invariant):

| block | vanishes iff | $\omega$-patterns killed |
| --- | --- | --- |
| $4P_+CP_+$ | $[\mathfrak p,\mathfrak m]\perp\mathfrak p$ | $\mathfrak p\mathfrak m\mathfrak p$ |
| $2P_-W_+^\#P_-$ | $[\mathfrak p,\mathfrak p]\perp\mathfrak m$ | $\mathfrak p\mathfrak p\mathfrak m$ |
| $2P_-W_-^\#P_-$ | $[\mathfrak m,\mathfrak m]\perp\mathfrak m$ | $\mathfrak m\mathfrak m\mathfrak m$ |
| $P_0\lvert W\rvert^\#P_0$ | $[\mathfrak p\oplus\mathfrak m,\mathfrak p\oplus\mathfrak m]\perp\mathfrak k$ | $\mathfrak p\mathfrak p\mathfrak k$, $\mathfrak p\mathfrak m\mathfrak k$, $\mathfrak m\mathfrak m\mathfrak k$ |

The three inclusions, in the same terms: $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$ iff $\mathfrak p\mathfrak p\mathfrak m=\mathfrak p\mathfrak p\mathfrak k=0$; $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$ iff $\mathfrak p\mathfrak m\mathfrak p=\mathfrak p\mathfrak m\mathfrak k=0$; $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$ iff $\mathfrak m\mathfrak m\mathfrak m=\mathfrak m\mathfrak m\mathfrak k=0$. **The two lists are the same five patterns**, so "all diagonal blocks vanish" is exactly "$\mathfrak p\oplus\mathfrak m$ is closed and $\mathbb Z_2$-graded with even part $\mathfrak p$". The brief's question (what do $[\mathfrak p,\mathfrak p]\perp\mathfrak m$ and $\perp\mathfrak k$ give together), has the answer $[\mathfrak p,\mathfrak p]\subseteq(\mathfrak m\oplus\mathfrak k)^\perp=\mathfrak p$, and likewise for the other two.

**One redundancy the block does not notice.** By antisymmetry of $\omega$, $\mathfrak p\mathfrak m\mathfrak p$ and $\mathfrak p\mathfrak p\mathfrak m$ are the same pattern: $[\mathfrak p,\mathfrak m]\perp\mathfrak p\iff[\mathfrak p,\mathfrak p]\perp\mathfrak m$. So the $P_+$ block vanishes iff the $W_+^\#$ half of the $P_-$ block does. Harmless for the corollary; worth a clause, because it says the $++$ block carries no information the $--$ block lacks.

**The whole chain.** Graded $\Rightarrow$ every diagonal block zero (F1, F2, hypothesis-free) $\Rightarrow\mathop{\mathrm{tr}}X_{\mathrm{inv}}=0\Rightarrow X_{\mathrm{inv}}=0$ by L154(i), which is where criticality enters. Conversely $X_{\mathrm{inv}}=0\Rightarrow$ blocks zero $\Rightarrow$ graded, hypothesis-free. I re-derived Result 5(a)'s blocks from $\lvert W\rvert^\#=W_+^\#+2C+W_-^\#$ and $W^\#=W_+^\#-2C+W_-^\#$ (they are the one-line differences and sums the record says they are) and Theorem A's $X_{\mathrm{inv}}=4C-2\theta W_--2W_-^2$ from $W^\#=\theta W-W^2$ being block-diagonal with $P_0W^\#P_0=0$; L154(i)'s PSD-row argument then goes through as written.

## F3, $W_{\mathbb{CP}^2}$ at $n=4$ is a confirmation, decided by hand, and L7's caveat overstates

Take $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ with $\mathfrak{so}(4)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$, an orthonormal basis $\omega_1,\omega_2,\omega_3$ of $\Lambda^+$ with $[\omega_i,\omega_j]=\mu\,\epsilon_{ijk}\omega_k$, and $W=\mathop{\mathrm{diag}}(2\varepsilon,-\varepsilon,-\varepsilon)$ on $\Lambda^+$, $0$ on $\Lambda^-$. Then $\mathfrak p=\mathbb R\omega_1$, $\mathfrak m=\mathop{\mathrm{span}}(\omega_2,\omega_3)$, $\mathfrak k=\Lambda^-$.

- **Normalisation.** For diagonal $W$ on $\Lambda^+$ the Gram formula gives $W^\#=\gamma\mathop{\mathrm{diag}}(w_2w_3,w_1w_3,w_1w_2)$ with $\gamma=2c\mu^2$ (the factor $2$ from ordered pairs), and $[\Lambda^+,\Lambda^-]=0$ makes $\mathrm{Id}^\#$ block-diagonal, so $\mathrm{Id}^\#=(n-2)\mathrm{Id}=2\,\mathrm{Id}$ pins $\gamma=2$.
- **Criticality.** $Q(W)=\theta W$ reads $4\varepsilon^2+\gamma\varepsilon^2=2\theta\varepsilon$ on $\omega_1$ and $\varepsilon^2-2\gamma\varepsilon^2=-\theta\varepsilon$ on $\omega_{2,3}$. The second gives $\theta=(2\gamma-1)\varepsilon=3\varepsilon$; the first then needs $4+\gamma=2(2\gamma-1)$, i.e. $\gamma=2$, consistent, so the point is critical with $\theta=3\varepsilon=\sqrt{3/2}$ at $\lVert W\rVert=1$ ($6\varepsilon^2=1$). This also settles, from the definitions, that the self-dual $(2,-1,-1;0,0,0)$ operator **is** a critical point; the docstring in [b_cp2_nondegenerate.py](../scripts/lib/b_cp2_nondegenerate.py) that says a hand-rolled self-dual operator "is not a critical point at all" describes a mis-normalised construction, and the record should not inherit it.
- **The blocks.** $\langle C\omega_2,\omega_2\rangle=c\,(2\varepsilon)(\varepsilon)\,\omega(\omega_1,\omega_3,\omega_2)^2=2c\mu^2\varepsilon^2=\gamma\varepsilon^2=2\varepsilon^2$, and $C$'s range is $[\mathfrak p,\mathfrak m]=\mathfrak m$, so $C=2\varepsilon^2P_-$. Then $X_{\mathrm{inv}}=4C-2\theta W_--2W_-^2=(8-6-2)\varepsilon^2P_-=0$. **$X_{\mathrm{inv}}=0$ exactly, at operator level.**
- **The grading.** $[\mathfrak p,\mathfrak p]=0\subseteq\mathfrak p$; $[\mathfrak p,\mathfrak m]=\mathfrak m$; $[\mathfrak m,\mathfrak m]=\mathbb R\omega_1=\mathfrak p$; $[\Lambda^+,\Lambda^-]=0$ gives closure. So $\mathfrak p\oplus\mathfrak m=\mathfrak{su}(2)_+$ is a subalgebra graded as the symmetric pair $(\mathfrak{su}(2),\mathfrak u(1))$ of $S^2$. **Both sides of the corollary hold; the point confirms it.** Padding to any $n$ leaves $\mathfrak p$, $\mathfrak m$, $C$, $W_-$ and $\theta$ unchanged (the Gram sums live in $[\mathfrak{su}(2)_+,\mathfrak{su}(2)_+]=\mathfrak{su}(2)_+$) so $X_{\mathrm{inv}}=0$ at every padding, as the batch-3 screen reports at $n=4,5$.
- **L7's boxed caveat "there is no $\mathbb Z_2$-grading at all" is false as worded.** $\mathfrak{so}(4)=(\mathbb R\omega_1\oplus\mathfrak{su}(2)_-)\oplus\mathfrak m$ **is** a $\mathbb Z_2$-grading: even part $\mathfrak u(2)$, the fixed algebra of $\mathrm{Ad}(J)$ for the complex structure $J=\exp(\tfrac\pi2\omega_1)$, odd part $\mathfrak m=\Lambda^{2,0}\oplus\Lambda^{0,2}$, the symmetric pair of $SO(4)/U(2)=S^2$. What is true, and what L7 meant, is that $\mathfrak p$ alone is the even part of no grading of $\mathfrak{so}(4)$, since $\mathfrak p\oplus\mathfrak m\ne\mathfrak{so}(4)$. The corollary is stated on the subalgebra $\mathfrak p\oplus\mathfrak m$, where the ambiguity disappears, and that is the right place to state it.

## F4, The corollary sharpens three prior statements: criticality closes the kernel

r516 F5 derived L7's equality from the three inequality steps of L7's proof as (E1) $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p\oplus\mathfrak k$, (E2) $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p\oplus\mathfrak k$, (E3) $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$, and concluded that "equality does not force $E_+\oplus E_-$ closed"; L7's block records the same as "conditions modulo $\ker W$", and r699's boxed statement carries "graded (mod $\ker W$)". **At a critical point all three are weaker than the truth**, by one identity none of them uses:

$$P_0\bigl(W_+^\#+W_-^\#\bigr)P_0=P_0\bigl(W^\#+2C\bigr)P_0=2P_0CP_0,$$

since $W^\#=\theta W-W^2$ kills $\ker W$. (E3) gives $(I-P_-)C(I-P_-)=0$, hence $P_0CP_0=0$, hence $P_0W_+^\#P_0=P_0W_-^\#P_0=0$ (both PSD), i.e. $[\mathfrak p,\mathfrak p]\perp\mathfrak k$ and $[\mathfrak m,\mathfrak m]\perp\mathfrak k$. With (E1), (E2) this is $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$: the full grading, and closure with it. This is an independent second route to the corollary's "only if" that bypasses the PSD-row argument, and it confirms by hand that L7's slack equals $\tfrac12\mathop{\mathrm{tr}}X_{\mathrm{inv}}$ at a critical point, the two differ by $\tfrac12\mathop{\mathrm{tr}}P_0(W_+^\#+W_-^\#)-2\mathop{\mathrm{tr}}(P_0C)$, which the identity makes zero.

**Repairs owed to the record**, each a positive statement: L7's "and those are conditions modulo $\ker W$" becomes "and at a critical point they close: $\mathfrak p\oplus\mathfrak m$ is a $\mathbb Z_2$-graded subalgebra"; r516 F5 §7a and r699's "(mod $\ker W$)" are superseded by the corollary; L7's "no $\mathbb Z_2$-grading at all" becomes "$\mathfrak p$ is the even part of no grading of $\mathfrak{so}(4)$, while $\mathfrak p\oplus\mathfrak m=\mathfrak{su}(2)_+$ is graded".

## F5, "$J_5=0$ regardless of $h$" is exactly right, and needs nothing weaker

$J_5=\langle X_{\mathrm{inv}},H\rangle$ (Result 5(b)), so $X_{\mathrm{inv}}=0$ gives $J_5=0$ for every $H$. A weaker sufficient condition exists ($X_{\mathrm{inv}}\perp H$) but the corollary claims the class where the strong one holds, and on the graded class the strong one is what holds. The open converse, "is $J_5=0$ only at graded points", is correctly left open by batch 3; a counterexample must have non-scalar $h$ (L154(ii)) and an ungraded $\mathop{\mathrm{ran}}W$ (this corollary), with $\langle X_{\mathrm{inv}},H\rangle=0$ despite $\mathop{\mathrm{tr}}X_{\mathrm{inv}}>0$ and $H\succeq0$.

## F6, $SU(3)$ fails exactly the third inclusion, by classification

At the $\mathfrak{su}(3)$ adjoint point $W=\Pi_{\mathfrak h}-\tfrac{8}{28}I$ (L23's family), $\mathfrak p=\mathfrak{su}(3)$, $\mathfrak m=\mathfrak{su}(3)^\perp$ of dimension $20$, $\mathfrak k=0$, and $\mathfrak m\otimes\mathbb C=\mathbf{10}\oplus\overline{\mathbf{10}}$ from $\Lambda^2\mathbf 8=\mathbf 8\oplus\mathbf{10}\oplus\overline{\mathbf{10}}$.

- $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$: a subalgebra. $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$: for any subalgebra and its orthogonal complement, $\langle[\mathfrak p,\mathfrak m],\mathfrak p\rangle=\langle\mathfrak m,[\mathfrak p,\mathfrak p]\rangle=0$. Both automatic.
- $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$ would make $\mathfrak{so}(8)=\mathfrak p\oplus\mathfrak m$ a $\mathbb Z_2$-grading, i.e. $\mathfrak{su}(3)$ the fixed algebra of an involution of $\mathfrak{so}(8)$. The fixed algebras of involutions of $\mathfrak{so}(8)$ are $\mathfrak{so}(p)\oplus\mathfrak{so}(8-p)$ (dimensions $21,13,13,12$), $\mathfrak u(4)$ ($16$), and the triality images $\mathfrak{spin}(7)$ ($21$) and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ ($13$), trap W2's list. **None has dimension $8$**, so the third inclusion fails, and only the third. The screen's "fails only $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$" is a theorem.

## F7, The record search: the corollary is new in one clause, and one screen sentence contradicts the hand analysis

- **On the record before batch 3:** L7's three bracket conditions "modulo $\ker W$" (r516 F5), r699's "$X_{\mathrm{inv}}=0\iff$ graded (mod $\ker W$)". **New in the corollary:** the closure clause, i.e. that the kernel does not need to be excused at a critical point. F4 shows it is right. So the corollary is not a restatement; it is the first place the record says $\mathfrak p\oplus\mathfrak m$ is a subalgebra at every equality point.
- **The batch-3 screen sentence "padded $\mathbb{CP}^2$ at $n=6$ fails $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$" contradicts F3** if the object is $W_{\mathbb{CP}^2}$: padding changes neither $\mathfrak p$, $\mathfrak m$ nor $[\mathfrak m,\mathfrak m]=\mathfrak p$, and $X_{\mathrm{inv}}=0$ at every padding. If the object is the $\mathbb{CP}^m$ family's $n=6$ member, that is $\mathbb{CP}^3$ with $\mathfrak p=\mathfrak u(3)$ and $\mathfrak m$ the odd part of the symmetric pair $(\mathfrak{so}(6),\mathfrak u(3))$, graded, with $X_{\mathrm{inv}}=0$ by the corollary. The batch-3 screen script is not in [scripts/](../scripts/), so I cannot name what was screened; **the sentence must either name a different critical point or be withdrawn.** It does not touch the corollary, whose evidence is the argument.
- **Wording.** "Graded as a symmetric pair" means "$\mathbb Z_2$-graded with even part $\mathfrak p$", the grading being the $\pm1$ eigen-decomposition of the involution that the three inclusions make an automorphism. The pair is $(\mathfrak p\oplus\mathfrak m,\mathfrak p)$, a proper subalgebra of $\mathfrak{so}(n)$ whenever $\ker W\ne0$; saying so in the block would keep the $n=4$ reading from recurring. $\mathfrak p$ and $\mathfrak m$ are each nonzero at every critical $W\ne0$ since $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$.

## Summary for the record

| item | status |
| --- | --- |
| $X_{\mathrm{inv}}=0\iff\mathfrak p\oplus\mathfrak m$ closed and graded, at every critical $W\ne0$ | **CONFIRMED**, two routes (PSD-row via L154(i); criticality identity $P_0(W_+^\#+W_-^\#)P_0=2P_0CP_0$) |
| $J_5=0$ on the class for every $h$ | CONFIRMED, from $J_5=\langle X_{\mathrm{inv}},H\rangle$ |
| L7's equality class is exactly this class | CONFIRMED; L7's slack is $\tfrac12\mathop{\mathrm{tr}}X_{\mathrm{inv}}$ at a critical point |
| $W_{\mathbb{CP}^2}$, $n=4$ | confirmation: $X_{\mathrm{inv}}=0$ by hand, $\mathfrak p\oplus\mathfrak m=\mathfrak{su}(2)_+$ graded as $(\mathfrak{su}(2),\mathfrak u(1))$ |
| $SU(3)$ fails only the third inclusion | CONFIRMED by the involution classification of $\mathfrak{so}(8)$ |
| L7 "modulo $\ker W$", r516 F5 §7a, r699 "(mod $\ker W$)" | superseded at critical points, closure is forced |
| L7 "no $\mathbb Z_2$-grading at all" at $n=4$ | overstated: $\mathfrak{so}(4)=\mathfrak u(2)\oplus\mathfrak m$ is one; $\mathfrak p$ alone is the even part of none |
| $[\mathfrak p,\mathfrak m]\perp\mathfrak p$ and $[\mathfrak p,\mathfrak p]\perp\mathfrak m$ | one condition by $\mathrm{ad}$-invariance; the $++$ block adds nothing to the $--$ block |
| screen sentence on "padded $\mathbb{CP}^2$ at $n=6$" | inconsistent with the hand analysis for either reading of the name; name the object or withdraw it |
| docstring "a hand-rolled self-dual operator is not a critical point" | wrong from the definitions; the $(2,-1,-1;0,0,0)$ operator is critical at $\theta=\sqrt{3/2}$ |
