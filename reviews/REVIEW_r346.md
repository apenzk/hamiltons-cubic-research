# Review r346, Gate 2 on I14, the sign-flip decomposition of $\mathcal W_n$

**E1, PLAUSIBLE, with a correction that matters.** The three-case list is exhaustive and the counts are right, but the determinant-one condition *does* change the characters, and the note's "$\Gamma\cong(\mathbb Z/2)^{n-1}$" is right about the abstract group and wrong about the group that acts. Two of the listed blocks carry the same character whenever $n\in\{4,6,8\}$.

**E2, CONFIRMED**, all three cuts, both emptiness claims and the Bianchi sign, with a shorter proof of the emptiness than the note gives.

**E3, CONFIRMED as an exact polynomial identity in $n$**, verified by hand and screened. As evidence it is worth much less than the note claims: it tests the three cut *totals* jointly and is completely blind to which relation did each cut, and blind to the character-fusion failure in E1/E4.

**E4, REFUTED AS STATED, and repaired.** The listed summands are *not* the isotypic components at $n=4,6,8$; at $n=8$ two complementary $4$-subsets carry one and the same $\Gamma$-character, so the argument delivers a block of size $4$, not two of size $2$. Everything survives at $n\ge9$, and the repair (replace $\Gamma\subset SO(n)$ by the full sign group $\{\pm1\}^n\subset O(n)$), restores the claim at every $n\ge4$ for free. Block-diagonality rather than block-triangularity is correct.

**E5, CONFIRMED, with one arithmetic correction.** The Hessian formula, the $\Gamma$-stability of $W^\perp$ and the placement of the orbit directions all check out; the orbit directions sit *inside* the pair blocks, exactly one per pair. The trivial block on $W^\perp$ has size $\tfrac{n(n-3)}2-1$, not $\tfrac{n(n-3)}2$, since $M$ itself lies in it.

**BONUS, the $2\times2$ $4$-set block is derived in closed form below, it is traceless, its spectrum is $\pm\tfrac1{2\theta}\sqrt{\tfrac12\sum_{r<s}(p_r-p_s)^2}$ in the three opposite-pair sums, and at $S^p\times S^q$ it equals $\pm\tfrac{n-2}{2(p-1)(q-1)}$.** That value hits exactly $\tfrac12$ at $S^3\times S^3$ and accounts, on the nose, for the nine $\tfrac12$-eigenvectors that [second-order.md](../findings/second-order.md) records as "an eigenvalue coincidence with no group origin".

*Method: analysis only, per the brief. Every formula below was derived by hand; the two screens named as screens are seconds of arithmetic on objects built for the purpose and are cited as insurance on transcription, never as evidence.*

---

## E1, the character types

**What is right.** The overlap of two $2$-subsets is $2$, $1$ or $0$ and nothing else, so the case list is exhaustive by construction. The characters are as stated: equal pairs give $\varepsilon_i^2\varepsilon_j^2=1$; one shared index $a$ gives $\varepsilon_a^2\varepsilon_b\varepsilon_c=\varepsilon_b\varepsilon_c$, which depends only on the unshared pair; disjoint pairs give the four-index product. The multiplicities are right too, for a fixed unshared pair $\{b,c\}$ the shared index ranges over the other $n-2$ indices, and a $4$-subset splits into two unordered pairs in exactly $3$ ways.

**What is wrong, and it is the question the brief asks.** Index the characters of the full sign group $\{\pm1\}^n$ by subsets, $\chi_S(\varepsilon)=\prod_{i\in S}\varepsilon_i$. On $\Gamma=\{\prod\varepsilon_i=1\}$ we have $\chi_S\chi_{S^{\mathsf c}}=\chi_{[n]}\equiv1$, so **$\chi_S$ and $\chi_{S^{\mathsf c}}$ are the same character of $\Gamma$**, and these are the only coincidences, $\widehat\Gamma$ being $\widehat{(\mathbb Z/2)^n}$ modulo $\langle\chi_{[n]}\rangle$. The note's blocks use $|S|\in\{0,2,4\}$, so a coincidence between two *listed* characters needs $|S|+|S^{\mathsf c}|=n$ with both sizes in $\{0,2,4\}$, that is $n\le8$, and since the sum is even, exactly $n\in\{4,6,8\}$:

| $n$ | which listed blocks share a character |
| --- | --- |
| $4$ | the trivial block with the single $4$-set block ($|S|=0$ against $|S|=4$), and pair blocks in complementary pairs ($\{1,2\}$ with $\{3,4\}$) |
| $6$ | every pair block $\{a,b\}$ with the $4$-set block on its complement |
| $8$ | $4$-set blocks in complementary pairs, $\{1,2,3,4\}$ with $\{5,6,7,8\}$ |
| $5,7$ and $n\ge9$ | none: the complements have size $\ge5$ or odd, and no listed character has that |

The same point read the other way: for **$n$ even** (the conjecture's own regime), $-\mathrm{Id}\in\Gamma$ and acts trivially on $\Lambda^2$, so the group actually acting is $\Gamma/\{\pm\mathrm{Id}\}$ of order $2^{n-2}$, not $2^{n-1}$. Writing "$\Gamma\cong(\mathbb Z/2)^{n-1}$ … so every $e_{ij}$ spans a character line" and then treating the characters as freely indexed by $S$ conflates the abstract group with its image, and the missing factor of $2$ is exactly the fusion above.

**The determinant-one condition is not needed and should be dropped.** $\circ$ is $O(n)$-equivariant, and this holds for $\det=-1$ too: the action on $\Lambda^2\cong\mathfrak{so}(n)$ is $\mathrm{Ad}_g$, which is a Lie-algebra automorphism and an isometry of the trace form for every $g\in O(n)$, so it preserves $c_{\alpha\beta\gamma}$ and hence $\#$, while $W\mapsto gWg^{-1}$ obviously preserves $W^2$. So take $\widetilde\Gamma=\{\pm1\}^n\subset O(n)$ instead. Its image in $GL(\Lambda^2)$ is $\widetilde\Gamma/\{\pm\mathrm{Id}\}$ of order $2^{n-1}$, its characters are exactly the $2^{n-1}$ maps $\chi_S$ with $|S|$ even (each trivial on the kernel, hence descending, and all distinct) and there is **no fusion at any $n$**. A diagonal $M$ is $\widetilde\Gamma$-fixed for the same reason it is $\Gamma$-fixed. The repair costs nothing and buys $n=4,6,8$.

**Small $n$, the brief's last sub-question.** No case is ever empty for $n\ge4$: the pair blocks have size $n-2\ge2$ before the cut and $n-3\ge1$ after, and $\binom n4\ge1$. At $n=4$ the pair block has size $1$ and the $4$-set block is the only one. At $n=3$ the $4$-set case is empty and $\mathcal W_3=0$, consistent with $n(n-3)/2=0$.

## E2, the Weyl cuts, block by block

**All three cuts CONFIRMED.** I checked each by direct index computation and then found a uniform argument that proves both emptiness claims at once and is worth putting in the note's place.

**The uniform argument.** First Bianchi is the vanishing of the $O(n)$-equivariant map $b:\mathrm{Sym}^2(\Lambda^2\mathbb R^n)\to\Lambda^4\mathbb R^n$, and Ricci-flatness the vanishing of the $O(n)$-equivariant trace $r:\mathrm{Sym}^2(\Lambda^2\mathbb R^n)\to\mathrm{Sym}^2\mathbb R^n$. Under the sign group, $\Lambda^4$ carries only characters $\chi_S$ with $|S|=4$, and $\mathrm{Sym}^2\mathbb R^n$ only $|S|\in\{0,2\}$. An equivariant map kills every isotypic component absent from its target. Hence **Ricci is identically zero on the $4$-set blocks and Bianchi is identically zero on the pair and diagonal blocks**, both of E2's emptiness claims, in one line. (Stated over $\widetilde\Gamma$ this is unconditional in $n$; over $\Gamma$ it would inherit the $n\ge9$ caveat, which is a further reason to switch groups.)

**Diagonal block.** The trivial-character space is the hollow symmetric arrays $M_{ij}=W_{ijij}$, dimension $\binom n2$. Bianchi is automatic: the only surviving instance has a repeated index, $W_{ijij}+W_{iijl}+W_{ijji}$-type, and cancels against itself. Ricci: $\mathrm{Ric}_{ik}=\sum_jW_{ijkj}$ vanishes for $i\ne k$ by support and gives $\sum_{j\ne i}M_{ij}=0$ for $i=k$, $n$ conditions, independent for $n\ge3$ since the row-sum map on hollow symmetric arrays is onto $\mathbb R^n$. Dimension $\binom n2-n=\tfrac{n(n-3)}2$, agreeing with $\mathcal D_n$ as [conventions.md](../findings/conventions.md) defines it. **CONFIRMED.**

**$4$-set block, and the sign.** With $\alpha=W_{ijkl}$, $\beta=W_{ikjl}$, $\gamma=W_{iljk}$ the coefficients of $e_{ij}\odot e_{kl}$, $e_{ik}\odot e_{jl}$, $e_{il}\odot e_{jk}$, first Bianchi $W_{ijkl}+W_{iklj}+W_{iljk}=0$ has $W_{iklj}=-W_{ikjl}=-\beta$, so it reads $\alpha-\beta+\gamma=0$. **The sign in E2 is correct.** There is exactly one such relation, not four: the Bianchi map lands in $\Lambda^4$, which is one-dimensional on a fixed $4$-set, and I checked directly that basing the identity at $j$ instead of $i$ reproduces the same relation up to sign. Ricci is empty because every component here has four distinct indices while $\mathrm{Ric}_{ab}=\sum_cW_{acbc}$ needs a repeat. Drop $3\to2$. **CONFIRMED.**

**Pair block.** With $x_i=W_{iaib}$ for $i\notin\{a,b\}$: Bianchi with base $(i,a,i,b)$ gives $W_{iaib}+W_{iiba}+W_{ibai}=0$, whose second term vanishes and whose third is $-W_{iaib}$ by one antisymmetry and one pair exchange, so the identity is $0=0$; and the four-distinct-index instances involve only $4$-set coordinates. Ricci: the only component with this character is $\mathrm{Ric}_{ab}=\sum_{i\notin\{a,b\}}W_{aibi}=\sum_ix_i$, one nonzero functional. Drop $n-2\to n-3$. **CONFIRMED.**

## E3, the dimension identity

**It is an exact identity in $n$, not a numerical coincidence.** Factoring,
$$\frac{n(n-3)}2+2\binom n4+(n-3)\binom n2=\frac{n(n-3)}2\Big[1+\frac{(n-1)(n-2)}6+(n-1)\Big]=\frac{n(n-3)}{12}\big(n^2+3n+2\big)=\frac{n(n+1)(n+2)(n-3)}{12},$$
and the right-hand side is $\dim\mathcal W_n$ ($10$ at $n=4$, $35$ at $n=5$, $84$ at $n=6$). Screened as an exact rational identity at $n=4,\dots,15$; the note's screen at $n=4,\dots,12$ is redundant once the factorisation is written down, and writing it down is worth more than the screen.

**How much evidence it is, less than the note claims, and in a specific way.** It is one linear equation in the three unknown block dimensions $(d,f,p)$, weighted $1,\binom n4,\binom n2$, so it does constrain them jointly, and most single-block errors break it: replacing the $4$-set count $2$ by $3$ shifts the total by $\binom n4$, which no integer change in the pair count can absorb for $n\ge5$. But three things it cannot see, and the third is the one that bit:

- **It cannot see which relation did the cutting.** The identity is a statement about $2$ and $n-3$, not about *Bianchi cuts one on the $4$-set and Ricci cuts none*. E2's two emptiness claims (precisely the ones the brief asks to be attacked separately), are invisible to it. Had Bianchi and Ricci each cut one dimension somewhere, in a way that left the totals unchanged, the identity would still close.
- **It cannot see the decomposition at all.** It is a dimension count on a direct-sum decomposition of $\mathcal W_n$; nothing in it says the summands are $L_e$-invariant, or isotypic, or even $\Gamma$-stable.
- **It is blind to the E1/E4 failure.** At $n=4,6,8$ the listed summands fuse into larger isotypic components, and the dimensions still add to $\dim\mathcal W_n$, fusion regroups the summands, it does not change their total. The identity closes at $n=8$ while the note's conclusion there is false.

The note's claim that the two sides are "computed by wholly unrelated routes" is fair; the claim implicit in *"a wrong Bianchi or Ricci count in any one block would break it at every $n$"* is not, because the identity does not distinguish Bianchi from Ricci.

## E4, block-diagonality

**Is $e$ $\Gamma$-fixed at every diagonal critical point? Yes.** Diagonal means, per [conventions.md](../findings/conventions.md), diagonal in the coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame; a sign flip acts diagonally in that basis, so it fixes $M$ entry by entry, and $e=M/\theta$ is fixed whenever $\theta\ne0$. The one thing to say out loud is that $\Gamma$ is the sign group *of the frame that diagonalises $M$*, so the decomposition is frame-dependent, harmless here, since the frame is chosen after the point.

**Does equivariance give diagonality or only triangularity? Diagonality, unconditionally.** The isotypic projector $P_\chi=|G|^{-1}\sum_g\chi(g)^{-1}g$ is a polynomial in the group elements, so it commutes with any equivariant $T$; then $T(V_\chi)=TP_\chi V=P_\chi TV\subseteq V_\chi$. All characters here are real ($\pm1$-valued), so this works over $\mathbb R$ with no complexification. **CONFIRMED.** It also needs $L_e$ to map $\mathcal W_n$ into itself, which holds because $Q$ does.

**Do two blocks ever carry the same character? Yes, and this is where E4 fails.** By E1, at $n=8$ the $4$-subsets $\{1,2,3,4\}$ and $\{5,6,7,8\}$ satisfy $\varepsilon_1\varepsilon_2\varepsilon_3\varepsilon_4=\varepsilon_5\varepsilon_6\varepsilon_7\varepsilon_8$ on $\Gamma$, so their isotypic component is $4$-dimensional and the equivariance argument permits $L_e$ to mix them. At $n=6$ each pair block fuses with a $4$-set block into a component of dimension $n-3+2=5$; at $n=4$ the trivial block fuses with the $4$-set block. **So the sentence "since the components listed are distinct characters" is false at $n\in\{4,6,8\}$, and the block sizes claimed there are wrong.** The conjecture lives at $n\ge12$, where nothing is harmed, but the record pads tensors down from small $n$ and works at $n=5,\dots,8$ throughout, so a domain line is needed and $n\ge9$ is the honest one for the argument as written.

**The repair, and it is better than the domain restriction.** Run the whole argument over $\widetilde\Gamma=\{\pm1\}^n\subset O(n)$, as in E1. The characters $\{\chi_S:|S|\text{ even}\}$ are $2^{n-1}$ in number and pairwise distinct, matching $|\widetilde\Gamma/\{\pm\mathrm{Id}\}|$ exactly, so the listed summands *are* the isotypic components at every $n\ge4$ and the block-size claim holds unrestricted. Nothing else in the note changes.

**Independently, the conclusion is true at $n=8$ anyway, by support rather than by character.** For $M$ diagonal, $\tfrac12(MX+XM)$ preserves the position pattern of $X$ outright, and $(M\# X)_{\alpha\beta}=\tfrac12\sum_\gamma M_\gamma c_{\alpha\gamma\delta}c_{\beta\gamma\zeta}X_{\delta\zeta}$ forces $\gamma$ to triangulate with both $\alpha$ and $\beta$, which confines every index appearing to the union of the index sets of $\alpha,\beta$ and the support of $X$. I checked case by case that no entry of $L_MX$ falls outside the $4$-set for $X\in V_{ijkl}$, and screened it: leakage exactly $0$ at $n=5,6,7$. So $\{1,2,3,4\}$ and $\{5,6,7,8\}$ do not in fact mix, but that is a theorem about $\circ$, not a consequence of the note's argument, and the note does not have it.

## E5, the consequence

**The Hessian formula CONFIRMED**, and its hypotheses are exactly [Lemma L24](../findings/second-order.md)'s. $P(W)=B(W,W,W)$ with $B(X,Y,Z)=\langle X,Y\circ Z\rangle$ symmetric, so $\nabla P=3Q(W)$ and $D^2P=6L_W$; at a critical point on $\{\lVert W\rVert=1\}$ the multiplier is $\lambda=\tfrac32\theta$, and the constrained Hessian on the tangent space is $6L_W-3\theta\,\mathrm{Id}=6\theta(L_e-\tfrac12\mathrm{Id})$. The hypotheses that matter: $W$ critical with $\lVert W\rVert=1$; the tangent space is $W^\perp$ *inside* $\mathcal W_n$; and $\theta>0$, without which dividing by $6\theta$ flips the inequality, the record's $\mathfrak u(2)\subset\mathfrak{so}(4)$ point at $\theta=-0.866$ is the standing witness.

**Is $W^\perp$ $\Gamma$-stable? Yes**, since $W=M$ is $\Gamma$-fixed and $\Gamma$ acts by isometries.

**One arithmetic correction.** $M$ lies in the trivial-character block, so passing to $W^\perp$ removes one dimension *from that block only*. The Hessian's blocks are therefore $\tfrac{n(n-3)}2-1$, then $\binom n4$ of size $2$ and $\binom n2$ of size $n-3$. E5's "block-diagonal the same way" is right in shape and off by one in the first size.

**Where the orbit directions sit, inside the pair blocks, one each.** For $A\in\mathfrak{so}(n)$ the orbit tangent is $Z_A=[\mathrm{ad}_A,M]$ as an operator on $\mathfrak{so}(n)$, and $\mathfrak{so}(n)$ has the basis $\{\varphi_{ab}\}$ with $\mathrm{Ad}_\varepsilon\varphi_{ab}=\varepsilon_a\varepsilon_b\varphi_{ab}$; since $M$ is fixed, $Z_{\varphi_{ab}}$ carries the character $\chi_{\{a,b\}}$ and so lies in the pair block $\{a,b\}$. Computing it, $Z_{\varphi_{ab}}\varphi_{ia}=(M_{ib}-M_{ia})\varphi_{ib}$, i.e. $x_i=M_{ib}-M_{ia}$, the note's own $x_i=\sigma_i(M_{ji}-M_{ki})$. It satisfies the pair block's Ricci relation for free: $\sum_i(M_{ib}-M_{ia})$ is the difference of two row sums, both zero. **So the orbit tangent meets each pair block in exactly one line and never crosses blocks**, the $\binom n2$ lines accounting for the whole of $\mathfrak{so}(n)$, and "off the orbit" removes one dimension from each pair block whose line is nonzero. It is nonzero unless $a$ and $b$ are twins ($M_{ia}=M_{ib}$ for all $i$), which is exactly when $\varphi_{ab}$ lies in the isotropy, at $S^p\times S^q$ that is every pair inside a factor, recovering $\mathfrak k=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$. **CONFIRMED, and sharper than stated.**

**"The largest block a non-diagonal direction can occupy has size $n-3$", CONFIRMED** for $n\ge5$ (and, with the E4 repair, at every $n\ge5$; at $n=4$ the $4$-set block of size $2$ is the largest). The statement should be read as: on the sum of the nontrivial-character components, the blocks have size $n-3$ or $2$.

---

## The $2\times2$ $4$-set block in closed form, the owed next step

**Setup.** $\varphi_{ij}=E_{ij}-E_{ji}$, declared orthonormal, so $[\varphi_{ij},\varphi_{jk}]=\varphi_{ik}$ and $c_{\alpha\beta\gamma}=\langle[\varphi_\alpha,\varphi_\beta],\varphi_\gamma\rangle$ is $\pm1$ on triangles and $0$ otherwise. $L_MX=\tfrac12(MX+XM)+M\#X$ with $(A\#B)_{\alpha\beta}=\tfrac12c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}A_{\gamma\epsilon}B_{\delta\zeta}$, the two polarisation terms coincide, by the simultaneous swap $\gamma\!\leftrightarrow\!\delta$, $\epsilon\!\leftrightarrow\!\zeta$. **The relative normalisation of $\#$ against $\tfrac12(MX+XM)$ is not a convention here, it is forced**: scaling $\#$ by $\mu$ makes $L_M$ preserve the Bianchi line $x_1-x_2+x_3=0$ only at $\mu=1$, as the computation below shows. And $L_e=L_M/\theta$ is invariant under rescaling $Q$, so the block is convention-free.

**The three opposite-pair sums.** On the $4$-set $\{i,j,k,l\}$ put
$$p_1=M_{ij}+M_{kl},\qquad p_2=M_{ik}+M_{jl},\qquad p_3=M_{il}+M_{jk},$$
and coordinates $x_1=X_{(ij),(kl)}$, $x_2=X_{(ik),(jl)}$, $x_3=X_{(il),(jk)}$, so that Bianchi is $x_1-x_2+x_3=0$.

**The computation.** $\tfrac12(MX+XM)$ is diagonal, $x_r\mapsto\tfrac12p_rx_r$. For $\#$, the constraint that $\gamma$ triangulate with both $\alpha$ and $\beta$ leaves four terms per entry, and summing them with the signs of $c$ gives
$$(M\#X)_1=\tfrac12(p_2x_3-p_3x_2),\qquad (M\#X)_2=-\tfrac12(p_3x_1+p_1x_3),\qquad (M\#X)_3=\tfrac12(p_2x_1-p_1x_2).$$
The check that pins the normalisation and the signs together: the full $L_MX$ satisfies
$$(L_MX)_1-(L_MX)_2+(L_MX)_3=\tfrac12(p_1+p_2+p_3)(x_1-x_2+x_3),$$
so $L_M$ maps the Bianchi hyperplane to itself and maps its complement off it, the Weyl space is preserved and nothing else is, which is as strong an internal check as this calculation admits.

**The block.** Eliminating $x_2=x_1+x_3$ and using $(x_1,x_3)$ as coordinates on $V_{ijkl}$,
$$L_M\big|_{V_{ijkl}}=\frac12\begin{pmatrix}p_1-p_3 & p_2-p_3\\[2pt] p_2-p_1 & p_3-p_1\end{pmatrix},$$
which is **traceless**, so the spectrum is $\pm\lambda$ with $\lambda^2=-\det$. Writing $a=p_1-p_2$, $b=p_2-p_3$, the determinant is $-\tfrac14(a^2+ab+b^2)$, hence
$$\mathop{\mathrm{spec}}\Big(L_e\big|_{V_{ijkl}}\Big)=\pm\frac1{2\theta}\sqrt{\tfrac12\big[(p_1-p_2)^2+(p_2-p_3)^2+(p_3-p_1)^2\big]}=\pm\frac1{2\theta}\sqrt{\tfrac32\textstyle\sum_r(p_r-\bar p)^2}.$$
**The block sees only the variance of the three opposite-pair sums**; it is blind to $p_1+p_2+p_3$, i.e. to the total mass of the $4$-set.

**Screen** (seconds, on operators built here for the purpose, reported as transcription insurance and not as evidence): against $\circ$ assembled from the structure constants, at $n=5,6,7$ with random $M\in\mathcal D_n$ and random $X\in V_{1234}$, the closed form reproduces $L_MX$ to $2\times10^{-16}$; the output stays on the Bianchi hyperplane to $4\times10^{-16}$; and leakage out of the $4$-set support is exactly $0$, which is the support half of E4.

**The new necessary condition.** [Lemma L24](../findings/second-order.md) on this block reads, at every diagonal maximiser and every $4$-subset,
$$\sum_{r<s}(p_r-p_s)^2\ \le\ 2\theta^2 .$$
One inequality per $4$-subset, in six entries of $M$ each, entirely local. The record's standing constraints on a diagonal critical point are the row-sum and criticality equations and [Lemma L68](../findings/diagonal-half.md)'s defect bounds; this is a second-order constraint of a different shape, and it is what the $\binom n4$ blocks contribute to $\lambda_{\max}(L_e)\le\tfrac12$.

**At $S^p\times S^q$.** Take the record's own parametrisation: $M_{ij}=a$ inside the first factor, $b$ inside the second, $-s$ across, with $a=qs/(p-1)$, $b=ps/(q-1)$ and $\theta=(n-1)s$. Splitting $4$-subsets by how they meet the factors:

| split | $(p_1,p_2,p_3)$ | block spectrum of $L_e$ |
| --- | --- | --- |
| $(4,0)$ or $(0,4)$ | $(2a,2a,2a)$ or $(2b,2b,2b)$ | $0$ |
| $(3,1)$ or $(1,3)$ | $(a-s,\,a-s,\,a-s)$ | $0$ |
| $(2,2)$ | $(a+b,\,-2s,\,-2s)$ | $\pm\dfrac{a+b+2s}{2\theta}$ |

and since $\dfrac q{p-1}+\dfrac p{q-1}+2=\dfrac{(n-1)(n-2)}{(p-1)(q-1)}$,
$$\lambda_{\max}\Big(L_e\big|_{4\text{-set}}\Big)=\frac{n-2}{2(p-1)(q-1)}\quad\text{on the }(2,2)\text{ subsets, }0\text{ on all others.}$$
Screened exactly at $(p,q)=(3,3),(3,4),(3,5),(4,4)$, with $Q(M)=\theta M$ to machine zero and $\theta=(n-1)s$ confirmed.

**What it gives.** The bound $\lambda_{\max}\le\tfrac12$ holds on the $4$-set blocks **iff $(p-2)(q-2)\ge1$, that is iff $p,q\ge3$, with equality exactly at $p=q=3$.** So:

- $S^2\times S^q$ is killed by a $4$-set block alone, at $\tfrac q{2(q-1)}>\tfrac12$, a second-order refutation that needs no search.
- At the balanced product $S^{k}\times S^{k}$ the value is $\tfrac1{k-1}=\tfrac2{n-2}$, so for $n\ge8$ the conjectured maximiser is **strictly** stable in every $4$-set direction with margin $\tfrac12-\tfrac2{n-2}$, which is $0.3$ at $n=12$ and grows. This complements [second-order.md](../findings/second-order.md)'s margin $\tfrac1{2(k-1)}$ in the $\mathrm{Sym}_0$ directions, which live in the trivial and pair blocks; the two together now cover the whole of $\mathcal W_n$ except the pair blocks' non-orbit part.
- **The $n=6$ saturation explains a recorded anomaly.** At $S^3\times S^3$ the value is exactly $\tfrac12$, and there are $\binom32\binom32=9$ subsets of type $(2,2)$, each contributing one $+\tfrac12$ eigenvector. With the $9$-dimensional orbit ($15-6$) that is $18$. [second-order.md](../findings/second-order.md) records "$\dim E(\tfrac12)=18$ against an orbit of dimension $9$: **nine of the eighteen $\tfrac12$-directions are an eigenvalue coincidence with no group origin**". They are not a coincidence, **they are one $+\tfrac12$ eigenvector from each of the nine $(2,2)$ $4$-set blocks**, and the closed form above says why the value is exactly $\tfrac12$ there and strictly below it at every larger balanced product. Note this sits at $n=6$, one of the fusion cases; the block is still correct because block-diagonality at $n=6$ holds by support, as shown in E4.

**On the note's flagged tension with $\tfrac{p-2}{2(p-1)}$.** The note warns that the record attributes $\tfrac{p-2}{2(p-1)}$ to the diagonal restriction while a screen found it in a non-diagonal pair block. The decomposition resolves this without a run: the deformation $A\mapsto H_A$ is equivariant, $A$ diagonal lands in the trivial block and $A=E_{ab}+E_{ba}$ lands in the pair block $\{a,b\}$, and both sit inside the single $\mathfrak k$-irreducible $\mathrm{Sym}_0(\mathbb R^p)$. If that irreducible occurs in $\mathcal W_n$ with multiplicity one, Schur makes $L_e$ scalar on it and **both attributions are right at once**, the same eigenvalue, reached through two different $\Gamma$-blocks. I record the multiplicity-one step as PLAUSIBLE rather than proved; it is the one thing that would close the flag, and it is a branching question, not a numerical one.

## Summary of corrections owed to the note

- **E1/E4.** Replace $\Gamma\subset SO(n)$ with the full sign group $\{\pm1\}^n\subset O(n)$ throughout, on the strength of $O(n)$-equivariance of $\circ$; then the listed summands are the isotypic components at every $n\ge4$. Failing that, restrict the proposition to $n\ge9$ and state that $\chi_S=\chi_{S^{\mathsf c}}$ on $\Gamma$ fuses blocks at $n=4,6,8$. Drop the parenthetical "$\Gamma\cong(\mathbb Z/2)^{n-1}$, so every $e_{ij}$ spans a character line" as a justification, since for $n$ even the acting group is $\Gamma/\{\pm\mathrm{Id}\}$ of order $2^{n-2}$.
- **E2.** Replace the case-by-case emptiness argument with the target-character argument: Bianchi lands in $\Lambda^4$ ($|S|=4$ only), Ricci in $\mathrm{Sym}^2\mathbb R^n$ ($|S|\in\{0,2\}$ only). Shorter and it proves both at once.
- **E3.** State it as the polynomial factorisation rather than a screen, and replace *"a wrong Bianchi or Ricci count in any one block would break it at every $n$"* with what is true: it tests the three block *totals*, not the attribution of the cuts, and it closes unchanged at $n=8$ where the proposition fails.
- **E5.** The trivial Hessian block on $W^\perp$ has size $\tfrac{n(n-3)}2-1$. Add that the orbit meets each pair block in exactly one line, vanishing exactly on the isotropy's pairs.
