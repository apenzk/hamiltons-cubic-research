# REVIEW r846: I36, the $\Lambda^4$ family of coordinate-diagonality conditions

*Cold Gate 2 review of the working-notes block at [diagonal-half.md:1082-1099](../findings/diagonal-half.md#L1082), briefed with the block verbatim and with the givens reproduced below. I derived every claim from those definitions before opening any file beyond the block itself, then opened the record only for items 12 and 13. I read no sibling reviewer's log or report and I have not touched [reviews/INDEX.md](INDEX.md). Analysis-only footing observed: every number below is in closed form, and no search, sweep, census or falsifier hunt was run. Log: [agent_logs/g2-i36-r846.log](../agent_logs/g2-i36-r846.log).*

## Claim table

| # | claim | verdict |
|---|---|---|
| C1 | (i) A coordinate-diagonal $W$ has $W_{abcd}=0$ at every four-distinct entry | **CONFIRMED**, since $W_{ijkl}\ne0$ needs $\{i,j\}=\{k,l\}$ |
| C2 | (i) Every power $W^k$ is again coordinate-diagonal | **CONFIRMED**, the coordinate $2$-forms are a common eigenbasis, so $W^k$ carries eigenvalues $\lambda_{ab}^k$ on it |
| C3 | (i) A $\Lambda^4$ element with no four-distinct entry is zero | **CONFIRMED**, and stronger than the block needs: the cyclic sum of any element of $S^2\Lambda^2$ is totally antisymmetric, so $\mathrm{Alt}(R)_{ijij}=0$ identically for every $R$, diagonal or not |
| C4 | (i) $\mathrm{Alt}(W^k)=0$ for every $k\ge1$ at every coordinate-diagonal $W$, with no Weyl hypothesis and no criticality | **CONFIRMED** |
| C5 | (ii) $\mathrm{Alt}(A)=\tfrac16\sum_\alpha\mu_\alpha\,\omega_\alpha\wedge\omega_\alpha$, so $\mathrm{Alt}(W^k)=\tfrac16\sum_\mu\mu^k\mathfrak b(P_\mu)$ | **CONFIRMED**, the $\tfrac16$ checked against [wedgeSelf](../lean/HamiltonsCubic/Base/SelfDual.lean#L106) and [bianchi_rankSumOp](../lean/HamiltonsCubic/Results/L179Statement.lean#L138), never against a display |
| C6 | (ii) The Vandermonde matrix on distinct nonzero $\mu$ is invertible, giving the stated iff | **CONFIRMED**. Invertibility needs distinctness AND nonvanishing, and the block's index set supplies both. $m$ powers suffice where $m$ is the count of distinct nonzero eigenvalues, so $m\le\binom n2$ and "every $k\ge1$" is more than the argument consumes |
| C7 | (ii) $\mathfrak b(P_\mu)$ is independent of the orthonormal basis chosen inside a degenerate eigenspace | **CONFIRMED**, and the block gives no argument, so **GAP** on the proof. Orthonormality is load-bearing and the one-line proof is $O^{\mathsf T}O=I$ against the commutativity of $\wedge$ on $2$-forms |
| C8 | (ii) $\mathfrak b(\mathrm{Id})=0$, and $\mathfrak b(P_0)$ is then forced | **CONFIRMED** both halves, with the reading that "forced" means forced to vanish |
| C9 | (iii) The six listed forms are an orthonormal basis of $\Lambda^2\mathbb R^4$ | **CONFIRMED** in closed form, through $e_2\wedge e_3=g_2\wedge g_3$ and an $SO(2)$ rotation of the pair $\{g_2\wedge e_4,g_3\wedge e_4\}$ |
| C10 | (iii) Each of the six is decomposable, hence $\mathfrak b(P_\mu)=0$ at every $\mu$ and $\mathrm{Alt}(W^k)=0$ for every $k$ | **CONFIRMED**, each is a literal wedge of two vectors and each eigenvalue is simple |
| C11 | (iii) $W$ is not coordinate-diagonal, by "the three forms sharing a line force $f_1=\pm e_1$" | **CONFIRMED AS ALGEBRA**, and the forcing step is **GAP**: two lines lie in three supports each, $\mathbb Re_1$ and $\mathbb Re_4$, so the quoted phrase singles out nothing. The complete kill is shorter than the block's and is given in §7 |
| C12 | (iii) First Bianchi is free on the all-decomposable set, whatever the eigenvalues | **CONFIRMED**, and the converse the block declines to claim is genuinely false, by $W_{\mathbb{CP}^2}$ |
| C13 | (iii) Any proof that the test characterises the locus inside $\mathcal W_n$ must consume Ricci-flatness, and a route through $\mathfrak b$ alone cannot work | **CONFIRMED AS ALGEBRA at $n=4$**. The brief's suggested weakening does not apply: the witness makes the target statement FALSE on symmetric-plus-Bianchi, which is what licenses "must use". **GAP on the quantifier**: the witness is exhibited at $n=4$ while the claim reads $\mathcal W_n$, and the padding repair is in §9 |
| C14 | (iii) $\lvert\mathrm{Ric}(W)\rvert=10$ at the screened point, so Ricci-flatness is what the witness violates | **GAP**. The conclusion holds and is much stronger than the evidence offered: [L180](../findings/diagonal-half.md#L656)(1), machine-checked as [Ric_rankSumOp](../lean/HamiltonsCubic/Results/L179Statement.lean#L120), gives $\mathrm{Ric}_{23}=\tfrac12\sin2t\,(\mu_1-\mu_2)\ne0$ identically on the family. The screened $10$ is also unreproducible, the eigenvalues being unnamed |
| C15 | (iii) A Weyl tensor at $n=4$ commutes with $\star$ | **CONFIRMED as a theorem**, and already on the record as $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ at [stratum-two-negative.md:31](../findings/stratum-two-negative.md#L31), so **GAP** |
| C16 | (iii) $\omega\wedge\omega\ne0$ for every nonzero $\omega\in\Lambda^\pm\mathbb R^4$, so a simple nonzero eigenvalue is impossible and every nonzero eigenvalue is degenerate | **CONFIRMED**, and **GAP**: [conventions.md:123](../findings/conventions.md#L123) already makes $\mathrm{Alt}$ the $\star$-projection at $n=4$, which gives the strictly stronger signature form in §10 |
| C17 | (iii) The four-cycle has spectrum $\{1,1,-1,-1,0,0\}$ with $\mu=1$ eigenspace $\mathrm{span}\{\varphi_{12},\varphi_{34}\}$, and is a consistent Weyl example | **CONFIRMED**, Ricci-flat because the alternating weight makes every weighted vertex degree zero, and Bianchi by C4 |
| C18 | (iv) $\omega_1\pm\omega_2$ are decomposable with mutually orthogonal planes, so $E$ is coordinate | **CONFIRMED**, all four inner products vanish and the frame is verified orthonormal in §11 |
| C19 | (iv) $\mathrm{Pf}(\omega_1)+\mathrm{Pf}(\omega_2)=\tfrac12-\tfrac12=0$ with $\omega_2$ anti-self-dual | **CONFIRMED** against $\star e_{13}=-e_{24}$ |
| C20 | The route clears [F37](../findings/fence-posts.md#L299), [F6](../findings/fence-posts.md#L164) and [F44](../findings/second-order.md#L845) | **REFUTED AS STATED** on F44 and confirmed on F37 and F6. F44's body lives in [second-order.md:845](../findings/second-order.md#L845) rather than in the file the block links, and "which is exactly what (iii) is" mis-assigns the clearance to the refutation instead of to the test. The paragraph also argues the route is worth the cycle after (iii) has retired it |
| C21 | Is any of this already on the record | **GAP at four sites**: [L180](../findings/diagonal-half.md#L656)(1) and its Lean bridge for the Ricci closed form, [conventions.md:123](../findings/conventions.md#L123) for the $\star$-projection, [diagonal-half.md:646](../findings/diagonal-half.md#L646) for "mutually orthogonal planes make an adapted frame", and [diagonality.md:3](../findings/diagonality.md#L3) for a blanket fence clearance on diagonality routes |

**Actionable summary.** The mathematics of the block is sound throughout and nothing in it is refuted, so keep every claim and make four repairs: replace the screened $\lvert\mathrm{Ric}\rvert=10$ with the closed form $\mathrm{Ric}_{23}=\tfrac12\sin2t\,(\mu_1-\mu_2)$ from the record's own [L180](../findings/diagonal-half.md#L656)(1), replace the unargued forcing step in (iii) with the line count of §7, replace the $\mathcal W_4$ degeneracy corollary with the strictly stronger $\Lambda^\pm$ signature form that [conventions.md:123](../findings/conventions.md#L123) already supports, and cut the fence paragraph's F44 sentence.

## Conventions, quoted from the brief

- **$\mathrm{Alt}$** is the projection onto the $\Lambda^4$ summand of $S^2\Lambda^2$, in components $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$, and the base layer proves $\mathrm{Alt}=\tfrac13\,\mathrm{bianchi}$ where the second name is the undivided cyclic sum.
- **$\mathfrak b:S^2\Lambda^2\to\Lambda^4$** is the Bianchi obstruction map, $\omega\odot\eta\mapsto\omega\wedge\eta$, from **[L179](../findings/diagonal-half.md#L1082)(b)**: "first Bianchi $\iff\sum_{\lambda_\alpha\ne0}\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0\in\Lambda^4$. The zero eigenvalues drop out."
- **$\mathrm{Alt}(A)=\tfrac16\,\mathfrak b(A)$**, established this session and machine-checked. **The record's wedge is TWICE the Pfaffian**, fixed at [wedgeSelf](../lean/HamiltonsCubic/Base/SelfDual.lean#L106): `wedgeSelf X a b c d = 2*(X a b * X c d - X a c * X b d + X a d * X b c)`. A claim of $\tfrac13$ here was refuted at Gate 2 earlier today, so every constant below is checked against that definition and not against a display.
- **"Diagonal" means diagonal in the coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame of $\mathbb R^n$**, and not diagonal as an operator on $\Lambda^2$. From [conventions.md](../findings/conventions.md#L69), which adds: "A generic spectral eigenbasis is essentially never of that form, and conflating the two is what makes the diagonal case look liftable."
- The inner product on $\Lambda^2$ is $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, making $\{\varphi_{ab}\}_{a<b}$ orthonormal; $\varphi_{ab}=E_{ba}-E_{ab}$; sums over pairs are over ordered pairs unless stated.
- A $2$-form satisfies $\omega\wedge\omega=0$ **exactly when it is decomposable**, $\omega=u\wedge v$, and its support is then the plane $\langle u,v\rangle$.
- **[L176](../findings/diagonal-half.md#L568)**: the coordinate-diagonal locus inside $\mathcal W_n$ has $\Lambda^2$-rank at least four. **[L177](../findings/diagonal-half.md#L592)**: a coordinate-diagonal Weyl tensor's support graph has every edge-carrying component of at least four edges, the minimum being the four-cycle $C_4$, whose weight is $(1,-1,1,-1)$.
- **The item [I36](../plan.md#L142)** reads: if $W$ is a local maximiser of $P$ on the unit sphere with $\theta>\sqrt{3/2}$ then $W$ is diagonal in some coordinate frame.

## Hypothesis inventory, checked against the objects

| hypothesis | where the block uses it | is it met by the object |
|---|---|---|
| $W$ symmetric as an operator on $\Lambda^2$ | throughout, for the real spectral theorem and for $W^k\in S^2\Lambda^2$ | met by construction in (iii) and (iv): an orthonormal basis with real eigenvalues |
| the eigenbasis is ORTHONORMAL | (ii)'s basis-independence and the identity $P_\mu=\sum_i\omega_i\odot\omega_i$ | met, and verified in §5 for the six forms of (iii), where it is the step a reader would skip |
| the six eigenvalues are DISTINCT | (iii), to make every $P_\mu$ rank one so that $\mathfrak b(P_\mu)=\omega_\mu\wedge\omega_\mu$ | met by hypothesis, and load-bearing twice more: at $\mu_5\ne\mu_6$ in the final step and at $\mu_1\ne\mu_2$ in the Ricci obstruction of §9 |
| the eigenvalues are NONZERO | (ii)'s Vandermonde determinant $\prod_j\mu_j\prod_{j<j'}(\mu_{j'}-\mu_j)$ | met in (iii), where all six are nonzero, so no $P_0$ exists there at all |
| $\sin2t\ne0$ | (iii), for non-diagonality and for the Ricci violation | met by hypothesis, and both conclusions fail at $\sin2t=0$, where $W$ becomes coordinate-diagonal outright |
| $\star$-invariance of every eigenspace | (iii)'s $\mathcal W_4$ corollary | met on $\mathcal W_4$ and NOT met by the witness, which is the corollary's whole point: it applies to Weyl tensors and the witness is not one |
| first Bianchi | (iii)'s "free here" | met by the witness, which is why the witness is informative |
| Ricci-flatness | nowhere in (i), (ii) or (iii)'s construction | NOT met by the witness, and §9 shows it is violated at every admissible parameter rather than at one screened point |
| criticality or $\theta>\sqrt{3/2}$ | nowhere | not met and not needed, which the block states correctly |

## 1. Item (i), both steps, and the repeated-index worry

The two steps are correct and the second is stronger than the block claims.

A coordinate-diagonal $W$ is $W=\sum_{a<b}\lambda_{ab}\,\varphi_{ab}\odot\varphi_{ab}$, whose components are $W_{ijkl}=\sum_{a<b}\lambda_{ab}(\varphi_{ab})_{ij}(\varphi_{ab})_{kl}$. A nonzero term needs $\{i,j\}=\{a,b\}=\{k,l\}$, so four distinct indices give zero. That is C1.

Powers: the coordinate $2$-forms $\varphi_{ab}$ are a common eigenbasis, so $W^k=\sum_{a<b}\lambda_{ab}^k\,\varphi_{ab}\odot\varphi_{ab}$ is coordinate-diagonal for every $k\ge1$, with the same support graph or a subgraph of it. The block's "so every power $W^k$ has too" is right, and the argument it omits is that one line. Note also that $W^k$ is a symmetric operator on $\Lambda^2$ and therefore an element of $S^2\Lambda^2$, which is what makes $\mathrm{Alt}(W^k)$ defined at all.

The brief's worry about repeated-index components does not bite, and the reason strengthens the block. Let $b(R)_{ijkl}=R_{ijkl}+R_{iklj}+R_{iljk}$ for $R\in S^2\Lambda^2$, so $R_{ijkl}=-R_{jikl}=-R_{ijlk}=R_{klij}$. Then

$$b(R)_{jikl}=R_{jikl}+R_{jkli}+R_{jlik}=-R_{ijkl}-R_{iljk}-R_{iklj}=-b(R)_{ijkl},$$

using $R_{jkli}=R_{lijk}=-R_{iljk}$ and $R_{jlik}=R_{ikjl}=-R_{iklj}$. Likewise $b(R)_{ijlk}=-b(R)_{ijkl}$ directly, and

$$b(R)_{ikjl}=R_{ikjl}+R_{ijlk}+R_{ilkj}=-R_{iklj}-R_{ijkl}-R_{iljk}=-b(R)_{ijkl}.$$

Those three transpositions generate $S_4$, so $b(R)$ is totally antisymmetric and $\mathrm{Alt}(R)=\tfrac13b(R)$ lies in $\Lambda^4$ for every $R\in S^2\Lambda^2$.

**The brief's requested figure.** For a coordinate-diagonal $R$ and $i\ne j$,

$$\mathrm{Alt}(R)_{ijij}=\tfrac13\big(R_{ijij}+R_{iijj}+R_{ijji}\big)=\tfrac13\big(\lambda_{ij}+0-\lambda_{ij}\big)=0,$$

so it vanishes, and by the antisymmetry above it vanishes for every $R\in S^2\Lambda^2$ whatever its diagonality. So "$\mathrm{Alt}(W^k)=0$" means what it says: the $\Lambda^4$ component of $W^k$ is the zero element of $\Lambda^4$, with no repeated-index residue hidden behind the four-distinct entries. What it does NOT mean is that $W^k$ vanishes, or that $W^k$ is a Weyl tensor, since the trace parts survive.

**One scope note the block should carry.** "$W_{abcd}=0$ at every four-distinct entry" is strictly weaker than coordinate-diagonality: $W_{1213}\ne0$ has only three distinct indices and destroys diagonality. The block uses the implication in the safe direction only.

## 2. Item (ii)'s Vandermonde step, written out

Let the distinct nonzero eigenvalues be $\mu_1,\dots,\mu_m$ and $P_j$ their eigenprojectors, so for $k\ge1$

$$W^k=\sum_{j=1}^m\mu_j^kP_j+0^k\,P_0=\sum_{j=1}^m\mu_j^kP_j,\qquad \mathrm{Alt}(W^k)=\tfrac16\sum_{j=1}^m\mu_j^k\,\mathfrak b(P_j).$$

Read $k=1,\dots,m$ as a linear system in the $\Lambda^4$-valued unknowns $\mathfrak b(P_j)$. Its matrix is $M_{kj}=\mu_j^k=V_{kj}\mu_j$ with $V_{kj}=\mu_j^{k-1}$ Vandermonde, so

$$\det M=\Big(\prod_{j=1}^m\mu_j\Big)\prod_{j<j'}(\mu_{j'}-\mu_j).$$

**Invertibility needs BOTH conditions**, distinctness for the second factor and nonvanishing for the first, and the block's index set delivers both: distinctness by grouping the spectrum by value, nonvanishing by excluding $\mu=0$. So the block's phrase "distinct nonzero $\mu$" names exactly the right hypothesis and no hypothesis is missing.

**How many powers.** Exactly $m$, and $m\le\binom n2$ always, so $k=1,\dots,\binom n2$ suffices at every $n$ and $k=1,\dots,6$ suffices at $n=4$. "For every $k\ge1$" is therefore more than the argument consumes. That is a non-minimality rather than a defect: the infinite family and the finite one are equivalent, since the forward direction restricts to $k\le m$ and the backward direction gives every $k$ at once.

**The iff is two-directional.** Backwards is immediate from the display, each term carrying a factor $\mathfrak b(P_j)=0$. Forwards is the Vandermonde inversion. Both use only that $W$ is a symmetric operator.

## 3. Item (ii)'s basis-independence, which the block asserts and does not prove

**CONFIRMED, with the proof the block owes.** The abstract reason is that $P_\mu$ is the orthogonal projector onto the eigenspace $E_\mu$, an object of $W$ alone, and $\mathfrak b$ is linear on $S^2\Lambda^2$, so $\mathfrak b(P_\mu)$ cannot see a basis. The concrete reason is worth writing because it identifies the load-bearing hypothesis. For an orthonormal basis $\{\omega_1,\dots,\omega_d\}$ of $E_\mu$ we have $P_\mu=\sum_i\omega_i\odot\omega_i$ and $\mathfrak b(P_\mu)=\sum_i\omega_i\wedge\omega_i$. Change basis by $\tilde\omega_i=\sum_jO_{ij}\omega_j$ with $O\in O(d)$:

$$\sum_i\tilde\omega_i\wedge\tilde\omega_i=\sum_{j,l}\Big(\sum_iO_{ij}O_{il}\Big)\,\omega_j\wedge\omega_l=\sum_{j,l}\delta_{jl}\,\omega_j\wedge\omega_l=\sum_j\omega_j\wedge\omega_j,$$

where the middle step needs $O^{\mathsf T}O=I$ and the symmetry $\omega_j\wedge\omega_l=\omega_l\wedge\omega_j$ of the wedge on $2$-forms. **Orthonormality is essential**: a merely linearly independent basis of $E_\mu$ changes the sum, so the well-definedness of the test is a statement about orthonormal bases and not about bases.

The block's contrast with "the per-eigenform reading" is exactly right, and its own (iv) is the witness for it: inside $E=\mathrm{span}\{\omega_1,\omega_2\}$ the basis $\{\omega_1,\omega_2\}$ has both self-wedges nonzero while $\{(\omega_1+\omega_2)/\sqrt2,(\omega_1-\omega_2)/\sqrt2\}$ has both zero, and the SUM is $0$ either way.

## 4. Item (ii)'s zero-eigenvalue clause, both halves

**$\mathfrak b(\mathrm{Id})=0$: CONFIRMED.** With the ordered-pair convention $\mathrm{Id}_{\Lambda^2}=\tfrac12\sum_{a\ne b}\varphi_{ab}\odot\varphi_{ab}=\sum_{a<b}\varphi_{ab}\odot\varphi_{ab}$, and each $\varphi_{ab}$ is the unit area form of the coordinate plane $\langle e_a,e_b\rangle$, hence decomposable, hence $\varphi_{ab}\wedge\varphi_{ab}=0$. So $\mathfrak b(\mathrm{Id})=0$ under either convention. A second route, at $n=4$: $\langle\mathrm{Id},\star\rangle=\mathop{\mathrm{tr}}(\Pi_+-\Pi_-)=3-3=0$.

**"$\mathfrak b(P_0)$ is then forced": CONFIRMED, with the reading spelled out.** From $\sum_{\text{all }\mu}P_\mu=\mathrm{Id}$ and linearity, $\mathfrak b(P_0)=-\sum_{\mu\ne0}\mathfrak b(P_\mu)$, which is $0$ once the others vanish. So $\mathfrak b(P_0)=0$ is a consequence and never an extra condition, which is the useful half: the test has $m$ conditions and not $m+1$. When $0$ is not an eigenvalue the same identity reads $\sum_{\mu\ne0}\mathfrak b(P_\mu)=0$, satisfied trivially by the vanishing of each term, so no hidden constraint appears.

## 5. Item (iii): the six forms are an orthonormal basis

**CONFIRMED in closed form.** Write $c=\cos t$, $s=\sin t$, $g_2=ce_2+se_3$, $g_3=-se_2+ce_3$, so $\{e_1,g_2,g_3,e_4\}$ is an orthonormal frame of $\mathbb R^4$, being $\{e_1,e_2,e_3,e_4\}$ rotated inside the $23$-plane. Two identifications do the work.

First, $g_2\wedge g_3=(ce_2+se_3)\wedge(-se_2+ce_3)=(c^2+s^2)\,e_2\wedge e_3=e_2\wedge e_3$, so the fourth listed form is the frame form $f_2\wedge f_3$.

So four of the six are $f_1\wedge f_2$, $f_1\wedge f_3$, $f_1\wedge f_4$, $f_2\wedge f_3$ for that frame, and they are orthonormal. Second, inverting the rotation, $e_2=cg_2-sg_3$ and $e_3=sg_2+cg_3$, hence

$$e_2\wedge e_4=c\,(g_2\wedge e_4)-s\,(g_3\wedge e_4),\qquad e_3\wedge e_4=s\,(g_2\wedge e_4)+c\,(g_3\wedge e_4),$$

an $SO(2)$ change of basis of $\mathrm{span}\{f_2\wedge f_4,f_3\wedge f_4\}$. So the last two are orthonormal, they span the same $2$-plane as the two frame forms they replace, and that plane is orthogonal to the span of the first four. The six are therefore an orthonormal basis of the six-dimensional $\Lambda^2\mathbb R^4$, and $W$ is a well-defined symmetric operator. Normalisation checks out under the brief's inner product, since $\lVert u\wedge v\rVert^2=\tfrac12\mathop{\mathrm{tr}}\big((uv^{\mathsf T}-vu^{\mathsf T})^{\mathsf T}(uv^{\mathsf T}-vu^{\mathsf T})\big)=1$ at orthonormal $u,v$.

## 6. Item (iii): each of the six is decomposable

**CONFIRMED.** Every one of the six is written as a wedge of two vectors, $g_2$ and $g_3$ being unit vectors of $\mathbb R^4$ exactly as much as $e_1$ and $e_4$ are, and $\omega=u\wedge v$ gives $\omega\wedge\omega=u\wedge v\wedge u\wedge v=0$. Concretely for the one the brief singles out, $e_1\wedge g_2=c\,(e_1\wedge e_2)+s\,(e_1\wedge e_3)$ has Pfaffian $\omega_{12}\omega_{34}-\omega_{13}\omega_{24}+\omega_{14}\omega_{23}=0$ term by term, since only $\omega_{12}$ and $\omega_{13}$ are nonzero and neither is paired with a nonzero partner.

Because the six eigenvalues are distinct, each $P_\mu$ is the rank-one $\omega_\mu\odot\omega_\mu$, so $\mathfrak b(P_\mu)=\omega_\mu\wedge\omega_\mu=0$ at every $\mu$, and by §2, $\mathrm{Alt}(W^k)=0$ for every $k\ge1$. The witness passes the whole family of conditions.

## 7. Item (iii): the non-diagonality argument, and the shorter complete one

**The conclusion is CONFIRMED. The block's forcing step is a GAP, and the repair is shorter than what it replaces.**

The six eigenvalues being distinct and nonzero, the eigenlines of $W$ are exactly the six lines $\mathbb R\omega_i$, so $W$ is coordinate-diagonal precisely when some orthonormal frame $\{f_1,\dots,f_4\}$ has $\{\mathbb Rf_a\wedge f_b\}_{a<b}$ equal, as a set of six lines, to $\{\mathbb R\omega_i\}$. Since a decomposable form determines its support plane, that happens precisely when the six SUPPORT PLANES of the $\omega_i$ are the six coordinate $2$-planes of one frame. The supports are

$$\Pi_1=\langle e_1,g_2\rangle,\quad \Pi_2=\langle e_1,g_3\rangle,\quad \Pi_3=\langle e_1,e_4\rangle,\quad \Pi_4=\langle e_2,e_3\rangle,\quad \Pi_5=\langle e_2,e_4\rangle,\quad \Pi_6=\langle e_3,e_4\rangle.$$

In a frame configuration each of the four frame lines lies in exactly three of the six planes, so a frame supplies four lines each contained in three of the $\Pi_i$. A line in $m$ of the planes appears in $\binom m2$ pairwise intersections, so every such line is visible in the fifteen pairwise intersections. Computing them, with $cs\ne0$ throughout:

$$\Pi_1\cap\Pi_2=\Pi_1\cap\Pi_3=\Pi_2\cap\Pi_3=\mathbb Re_1,\qquad \Pi_3\cap\Pi_5=\Pi_3\cap\Pi_6=\Pi_5\cap\Pi_6=\mathbb Re_4,$$
$$\Pi_1\cap\Pi_4=\mathbb Rg_2,\quad \Pi_2\cap\Pi_4=\mathbb Rg_3,\quad \Pi_4\cap\Pi_5=\mathbb Re_2,\quad \Pi_4\cap\Pi_6=\mathbb Re_3,$$
$$\Pi_1\cap\Pi_5=\Pi_1\cap\Pi_6=\Pi_2\cap\Pi_5=\Pi_2\cap\Pi_6=\Pi_3\cap\Pi_4=0.$$

The four vanishing intersections with $\Pi_1$ or $\Pi_2$ are where $\sin2t\ne0$ enters: a vector $\alpha e_1+\beta g_2$ lies in $\langle e_2,e_4\rangle$ only if $\alpha=0$ and $\beta s=0$, and in $\langle e_3,e_4\rangle$ only if $\alpha=0$ and $\beta c=0$. And $\Pi_3\cap\Pi_4=0$ because those two planes are orthogonal complements.

So $\mathbb Re_1$ appears three times and lies in three planes, $\mathbb Re_4$ likewise, and each of $\mathbb Rg_2$, $\mathbb Rg_3$, $\mathbb Re_2$, $\mathbb Re_3$ appears once and so lies in exactly two. **Exactly two lines lie in three of the six supports, and a frame needs four. So no frame exists and $W$ is coordinate-diagonal in none.** The argument consumes $\sin2t\ne0$ and nothing else, so it covers every case the brief asks about, including any frame outside $\{\pm e_1\}\cup\{\pm g_2,\pm g_3,\pm e_4\}$.

**What the block's version is missing.** "The three forms sharing a line force $f_1=\pm e_1$" names no unique object, because $\Pi_3,\Pi_5,\Pi_6$ share $\mathbb Re_4$ just as $\Pi_1,\Pi_2,\Pi_3$ share $\mathbb Re_1$, and it asserts the forcing rather than deriving it. Its continuation is nonetheless valid as a conditional: if $f_1=\pm e_1$, the three planes through $f_1$ are $\Pi_1,\Pi_2,\Pi_3$ and the remaining frame vectors are the unit vectors of $\Pi_i\cap e_1^\perp$, namely $\pm g_2,\pm g_3,\pm e_4$. Then $g_2\wedge e_4=c\,(e_2\wedge e_4)+s\,(e_3\wedge e_4)$ would have to be an eigenform, and it is a combination of two eigenforms with distinct eigenvalues $\mu_5\ne\mu_6$ at $cs\ne0$, so it is not. That step is correct and $\mu_5\ne\mu_6$ is load-bearing in it, which the block leaves implicit.

**On the screen.** "$g_2\wedge e_4$ overlapping the eigenbasis at $0.765$" is exactly $\cos0.7=0.76484$, the larger of $\lvert c\rvert$ and $\lvert s\rvert$. The numeral therefore reports the coefficient already displayed in the same sentence and adds nothing to it. That is harmless and worth saying, since a reader could take it for independent confirmation.

## 8. Item (iii)'s headline: is first Bianchi free on the all-decomposable set

**CONFIRMED.** If $W=\sum_\alpha\mu_\alpha\,\omega_\alpha\odot\omega_\alpha$ for an orthonormal eigenbasis of decomposables, then $\mathrm{Alt}(W)=\tfrac16\sum_\alpha\mu_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$ term by term, whatever the $\mu_\alpha$. No relation among the eigenvalues is used, not even tracelessness, so first Bianchi holds identically on that set. The same computation gives $\mathrm{Alt}(W^k)=0$ for every $k$, which is why the all-decomposable set is the natural home of a witness.

**The converse the block declines to claim is FALSE, and the record's own object refutes it.** Take $W_{\mathbb{CP}^2}$ at $n=4$: it is a Weyl tensor, so $\mathrm{Alt}(W)=0$, and its $\Lambda^2$ spectrum is proportional to $(2,-1,-1)$ on $\Lambda^+$ with $W^-=0$. Every eigenform of the nonzero part lies in $\Lambda^+$, where $\omega\wedge\omega=2\mathrm{Pf}(\omega)\,e_{1234}=\lVert\omega\rVert^2e_{1234}\ne0$, and the $\mu=-1$ eigenspace is a $2$-plane inside $\Lambda^+$ every element of which is self-dual and so non-decomposable. So $W_{\mathbb{CP}^2}$ satisfies first Bianchi and admits NO all-decomposable orthonormal eigenbasis. The all-decomposable set is a proper subset of the first-Bianchi locus.

**Does the block overreach.** No. Its sentence quantifies over the all-decomposable set in the true direction only, and the record's [L185](../findings/diagonal-half.md#L656) contains the same asymmetry in print, its final note reading "padded $W_{\mathbb{CP}^2}$'s eigenforms are self-dual, hence non-decomposable", which it files as corroboration rather than counterexample.

## 9. Item (iii)'s conclusion: what the witness licenses, in exact terms

This is the item the brief flags, and **the block's inference is valid as scoped**, contrary to the weakening the brief proposes. The precise position is worth stating because the two readings differ.

Write $\mathcal S$ for the symmetric operators on $\Lambda^2\mathbb R^n$ satisfying first Bianchi, so that $\mathcal W_n=\mathcal S\cap\{\mathop{\mathrm{Ric}}=0\}$, with $T(W)$ the statement "$\mathrm{Alt}(W^k)=0$ for every $k\ge1$" and $D(W)$ the statement "$W$ is coordinate-diagonal in some orthonormal frame". Item (i) gives $D\Rightarrow T$ everywhere. The characterisation the route needs is the converse on $\mathcal W_n$.

The witness sits in $\mathcal S$, satisfies $T$ by §6, and fails $D$ by §7. So **$T\Rightarrow D$ is FALSE on $\mathcal S$**, which is strictly more than "Ricci-flatness is not implied by the rest": a proof of $T\Rightarrow D$ that never used $\mathop{\mathrm{Ric}}=0$ would be a proof of a false statement. Since $\mathop{\mathrm{Ric}}=0$ is the only condition separating $\mathcal W_n$ from $\mathcal S$, any correct proof of the characterisation on $\mathcal W_n$ must consume it. That is the ordinary sense of "must use a hypothesis" and it is the strongest such statement a single witness can carry. **The block claims exactly this and no more**, and "a route through $\mathfrak b$ alone cannot work" is the same fact restated.

**Two precisions the block owes.**

*The name.* "Ricci-flatness" here is tracelessness of an algebraic curvature tensor, which is the Weyl condition, and not the geometric Einstein condition. The record uses the word this way at [conventions.md:54](../findings/conventions.md#L54), so the usage is house style, and a reader coming from geometry needs the gloss.

*The quantifier, which is a GAP.* The witness is exhibited at $n=4$ while the conclusion reads "inside $\mathcal W_n$". The padding repair is three lines and should be in the block. Extend $W$ to $\Lambda^2\mathbb R^n$ for $n\ge5$ by $0$ on $\mathrm{span}\{e_i\wedge e_j:j\ge5\}$. That complement is spanned by coordinate $2$-forms, all decomposable, so $\mathfrak b(P_0)=0$ and $T$ still holds. For $D$: if a frame $\{f_a\}_{a\le n}$ diagonalised the extension, each of the six nonzero eigenlines would be some $\mathbb Rf_a\wedge f_b$, so every frame vector appearing lies inside $\mathbb R^4=\mathrm{span}(e_1,\dots,e_4)$. The six supports span $\Lambda^2\mathbb R^4$ and hence $\mathbb R^4$, so at least four such vectors occur, and orthonormality caps them at four. The six supports are then all six coordinate planes of an orthonormal frame of $\mathbb R^4$ and §7 applies verbatim. So the witness reaches every $n\ge4$.

**The Ricci violation, in closed form, replacing the screen.** The record's own [L180](../findings/diagonal-half.md#L656)(1) gives $\mathop{\mathrm{Ric}}\big(\sum_m\mu_m\,\omega_m\odot\omega_m\big)=\sum_m\mu_m\,\omega_m\omega_m^{\mathsf T}$, machine-checked as [Ric_rankSumOp](../lean/HamiltonsCubic/Results/L179Statement.lean#L120), and a unit decomposable has $\omega\omega^{\mathsf T}=\Pi$, the orthogonal projector onto its plane, since $(uv^{\mathsf T}-vu^{\mathsf T})(vu^{\mathsf T}-uv^{\mathsf T})=uu^{\mathsf T}+vv^{\mathsf T}$ at orthonormal $u,v$. So

$$\mathop{\mathrm{Ric}}(W)=\sum_{m=1}^6\mu_m\Pi_m=(\mu_1+\mu_2+\mu_3)\,e_1e_1^{\mathsf T}+(\mu_1+\mu_4)\,g_2g_2^{\mathsf T}+(\mu_2+\mu_4)\,g_3g_3^{\mathsf T}+\mu_5\,e_2e_2^{\mathsf T}+\mu_6\,e_3e_3^{\mathsf T}+(\mu_3+\mu_5+\mu_6)\,e_4e_4^{\mathsf T},$$

which is block-diagonal for the splitting $\langle e_1\rangle\oplus\langle e_2,e_3\rangle\oplus\langle e_4\rangle$. In the $23$-block, $g_2g_2^{\mathsf T}$ has rows $(c^2,\,cs)$ and $(cs,\,s^2)$ while $g_3g_3^{\mathsf T}$ has rows $(s^2,\,-cs)$ and $(-cs,\,c^2)$, so

$$\mathop{\mathrm{Ric}}(W)_{23}=cs\big[(\mu_1+\mu_4)-(\mu_2+\mu_4)\big]=\tfrac12\sin2t\,(\mu_1-\mu_2)\ne0$$

at every admissible parameter, since $\sin2t\ne0$ and $\mu_1\ne\mu_2$ are the witness's own hypotheses. **So the witness violates Ricci-flatness identically on the family and not merely at one screened point**, and no choice of the six eigenvalues repairs it. That is the statement the headline needs, it is available from the record's own numbered lemma, and the block reports a screen instead. The screened $\lvert\mathop{\mathrm{Ric}}(W)\rvert=10$ is additionally unreproducible from the block, which names no eigenvalues.

**And the family's Ricci-flat boundary is instructive, which is the strongest support the block does not claim.** Imposing $\mathop{\mathrm{Ric}}=0$ on the family forces $\mu_1=\mu_2=:\mu$ from the off-diagonal entry, whereupon $t$ leaves $\mathop{\mathrm{Ric}}$ entirely and the diagonal equations read $2\mu+\mu_3=0$, $\mu+\mu_4+\mu_5=0$, $\mu+\mu_4+\mu_6=0$, $\mu_3+\mu_5+\mu_6=0$, whose unique solution is $\mu_3=\mu_4=-2\mu$ and $\mu_5=\mu_6=\mu$. At those values $\mu_5=\mu_6$ collapses the $t$-dependence: the $\mu$-eigenspace becomes $\mathrm{span}\{e_1\wedge e_2,e_1\wedge e_3,e_2\wedge e_4,e_3\wedge e_4\}$ and the $-2\mu$-eigenspace $\mathrm{span}\{e_1\wedge e_4,e_2\wedge e_3\}$, so the Ricci-flat member is **coordinate-diagonal in the standard frame**, with weights $\lambda_{12}=\lambda_{13}=\lambda_{24}=\lambda_{34}=\mu$ and $\lambda_{14}=\lambda_{23}=-2\mu$ and every weighted vertex degree zero. So the one-parameter attack "tune the eigenvalues until the witness becomes a Weyl tensor" fails, and it fails by producing a diagonal point. That is derived rather than screened, and it is evidence for the block's own open question in the direction the block hopes.

## 10. Item (iii)'s $\mathcal W_4$ corollary, and the sharper form the record already supports

**$\star$-commutation is a theorem, not an assumption, and it is on the record.** Under $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ we have $S^2\Lambda^2=S^2\Lambda^+\oplus S^2\Lambda^-\oplus(\Lambda^+\otimes\Lambda^-)$ of dimensions $6+6+9=21=\dim S^2(\mathbb R^6)$, where the $9$ is the trace-free Ricci part and the two trace directions in $S^2\Lambda^\pm$ are scalar curvature and the $\Lambda^4$ direction. Tracelessness kills the mixed block, so $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ and every element is block-diagonal for $\Lambda^\pm$, which is $\star$-commutation. The record carries that identification at [stratum-two-negative.md:31](../findings/stratum-two-negative.md#L31) and at [INDEX-results.md:185](../findings/INDEX-results.md#L185), so the block re-derives a recorded fact. Given it, $\star$ restricts to an involution on each eigenspace, hence $E=(E\cap\Lambda^+)\oplus(E\cap\Lambda^-)$ as the block says.

**$\omega\wedge\omega\ne0$ on $\Lambda^\pm$: CONFIRMED.** With $\star e_{12}=e_{34}$, $\star e_{13}=-e_{24}$, $\star e_{14}=e_{23}$, a self-dual $\omega$ has $\omega_{34}=\omega_{12}$, $\omega_{24}=-\omega_{13}$, $\omega_{23}=\omega_{14}$, so $\mathrm{Pf}(\omega)=\omega_{12}^2+\omega_{13}^2+\omega_{14}^2=\tfrac12\lVert\omega\rVert^2$ and $\omega\wedge\omega=2\mathrm{Pf}(\omega)\,e_{1234}=\lVert\omega\rVert^2e_{1234}$ in the record's doubled convention. Anti-self-dual gives $-\lVert\omega\rVert^2e_{1234}$. Both are nonzero away from $\omega=0$, so a simple nonzero eigenvalue of a $W\in\mathcal W_4$ has $\mathfrak b(P_\mu)=\omega_\mu\wedge\omega_\mu\ne0$ and cannot pass the test. Every nonzero eigenvalue of a passing $W\in\mathcal W_4$ is therefore degenerate, as the block says.

**The record already carries the tool for a strictly stronger statement, which is a GAP.** [conventions.md:123](../findings/conventions.md#L123) states that inside $\Lambda^2\mathbb R^4$ the target $\Lambda^4$ is one-dimensional and $\mathrm{Alt}$ is the projection onto $\star=\Pi_{SD}-\Pi_{ASD}$ with $\lVert\star\rVert^2=6$. So $\mathrm{Alt}(A)=\tfrac16\langle A,\star\rangle\,\star$, and for a $\star$-invariant eigenspace

$$\langle P_\mu,\star\rangle=\mathop{\mathrm{tr}}\big(P_\mu(\Pi_+-\Pi_-)\big)=\dim(E_\mu\cap\Lambda^+)-\dim(E_\mu\cap\Lambda^-).$$

**Hence on $\mathcal W_4$ the test reads: every nonzero eigenspace is BALANCED between $\Lambda^+$ and $\Lambda^-$.** That implies the block's degeneracy conclusion, since balance makes $\dim E_\mu$ even and at least two, and it is strictly stronger: it also excludes a two-dimensional nonzero eigenspace lying inside $\Lambda^+$, which the block's version permits. Equivalently, writing $W=W^+\oplus W^-$ with each factor traceless on a three-space, **the test holds on $\mathcal W_4$ exactly when the nonzero spectra of $W^+$ and $W^-$ agree with multiplicity.** Two checks. At the four-cycle, $W^+=W^-=\mathop{\mathrm{diag}}(1,0,-1)$ in the bases $\{(\varphi_{12}\pm\varphi_{34})/\sqrt2,(\varphi_{13}\mp\varphi_{24})/\sqrt2,(\varphi_{14}\pm\varphi_{23})/\sqrt2\}$, so the nonzero spectra are both $\{1,-1\}$ and the test passes. At padded $W_{\mathbb{CP}^2}$, $W^+\propto(2,-1,-1)$ against $W^-=0$, so the test fails, which is what the block's own screen in (i) reports as "$1$ at padded $W_{\mathbb{CP}^2}$". The closed form therefore explains the screen and should replace it.

**The four-cycle check, in full, since it is the block's own consistency test.** The $C_4$ on $1234$ with edges $12,23,34,41$ and weights $(1,-1,1,-1)$ is the coordinate-diagonal operator with $\lambda_{12}=\lambda_{34}=1$, $\lambda_{23}=\lambda_{14}=-1$, $\lambda_{13}=\lambda_{24}=0$. Its $\Lambda^2$ spectrum is the weight multiset, $\{1,1,-1,-1,0,0\}$, as claimed, and its $\mu=1$ eigenspace is $\mathrm{span}\{\varphi_{12},\varphi_{34}\}$, as claimed. First Bianchi holds by §1. Ricci-flatness: for a coordinate-diagonal tensor $\mathop{\mathrm{Ric}}$ is diagonal with $\mathop{\mathrm{Ric}}_{ii}=\sum_{j\ne i}\lambda_{ij}$, the weighted vertex degree, and the alternating weight gives $1-1=0$ at all four vertices, so the tensor is Ricci-flat and traceless. It is a genuine element of $\mathcal W_4$ with $W^\pm$ both traceless. And its $\mu=1$ eigenspace does carry one self-dual and one anti-self-dual direction, $(\varphi_{12}\pm\varphi_{34})/\sqrt2$, whose self-wedges are $+\varphi_{12}\wedge\varphi_{34}$ and $-\varphi_{12}\wedge\varphi_{34}$, cancelling. That is simultaneously the block's cancellation, an instance of §3's basis-independence, and the balance of the signature form.

## 11. Item (iv)'s orthogonality claim, all four inner products

**CONFIRMED throughout.** With $\omega_1=(e_{12}+e_{34})/\sqrt2$ and $\omega_2=(e_{13}+e_{24})/\sqrt2$, the duality table $\star e_{12}=e_{34}$, $\star e_{13}=-e_{24}$, $\star e_{14}=e_{23}$ makes $\omega_1$ self-dual and $\omega_2$ anti-self-dual, so $\omega_2$ is genuinely anti-self-dual as the block states. Pfaffians: $\mathrm{Pf}(\omega_1)=\tfrac12\cdot\tfrac12\cdot2=\tfrac12$ from $\omega_{12}\omega_{34}=\tfrac12$, and $\mathrm{Pf}(\omega_2)=-\omega_{13}\omega_{24}=-\tfrac12$. So $\mathrm{Pf}(\omega_1)+\mathrm{Pf}(\omega_2)=0$ and $\mathfrak b(P_E)=\omega_1\wedge\omega_1+\omega_2\wedge\omega_2=2\big(\mathrm{Pf}(\omega_1)+\mathrm{Pf}(\omega_2)\big)e_{1234}=0$, exactly as the block computes.

Decomposability of the diagonal directions:

$$(e_2+e_3)\wedge(e_4-e_1)=e_{24}+e_{12}+e_{34}+e_{13}=\sqrt2\,(\omega_1+\omega_2),$$
$$-(e_2-e_3)\wedge(e_1+e_4)=e_{12}-e_{24}-e_{13}+e_{34}=\sqrt2\,(\omega_1-\omega_2),$$

so both are decomposable with supports $\Pi_+=\langle e_2+e_3,\,e_4-e_1\rangle$ and $\Pi_-=\langle e_2-e_3,\,e_1+e_4\rangle$. The four inner products across the two planes:

$$\langle e_2+e_3,\,e_2-e_3\rangle=1-1=0,\quad \langle e_2+e_3,\,e_1+e_4\rangle=0,\quad \langle e_4-e_1,\,e_2-e_3\rangle=0,\quad \langle e_4-e_1,\,e_1+e_4\rangle=-1+1=0.$$

All four vanish, so the planes are mutually orthogonal, and $f_1=\tfrac1{\sqrt2}(e_2+e_3)$, $f_2=\tfrac1{\sqrt2}(e_4-e_1)$, $f_3=\tfrac1{\sqrt2}(e_2-e_3)$, $f_4=\tfrac1{\sqrt2}(e_1+e_4)$ is an orthonormal frame with $f_1\wedge f_2=\tfrac1{\sqrt2}(\omega_1+\omega_2)$ and $f_3\wedge f_4=-\tfrac1{\sqrt2}(\omega_1-\omega_2)$, both unit. Hence $E=\mathrm{span}\{f_1\wedge f_2,f_3\wedge f_4\}$, the other four frame forms lie in $E^\perp$ because the six are orthonormal, and $W=\nu\,\mathrm{Id}+(\mu-\nu)P_E$ has every $f_a\wedge f_b$ as an eigenform. **(iv) collapses exactly as the block says, and the diagnosis it draws is correct**: the obstruction to diagonality is a joint condition on the eigenspaces, that their decomposable elements span them AND that the resulting planes are simultaneously the coordinate planes of one frame, which §7 is precisely the failure of.

The brief's phrasing drops the leading minus sign on the second form. That sign changes neither decomposability nor the plane, so nothing turns on it.

## 12. The fence claim, read at source

| fence | source | does the route clear it |
|---|---|---|
| [F37](../findings/fence-posts.md#L299) | "the third/fourth-variation calculus is vacuous on the orbit tangent, at every critical point ... it must consume directions of $A(\tfrac12)$ transverse to the orbit tangent" | **YES**, and for the block's stated reason. F37 constrains routes through the third and fourth variations of $P$, and (i), (ii) and (iii) differentiate nothing and never mention a critical point. The block's "this uses none" is accurate |
| [F6](../findings/fence-posts.md#L164) | "Spectral moments of $L_W$ are the wrong invariants", the Track A route having closed with a quantified negative, $58.9\times$ short at $n=12$ | **YES**, and the resemblance is close enough to deserve the one sentence the block gives it. F6 is about scalar moments of the multiplication operator $L_W$ on $\mathcal W_n$, used to bound $\theta$. The block's object is a power of $W$ as an operator on $\Lambda^2$, and what it extracts is a $\Lambda^4$-valued tensor used to detect diagonality rather than a trace used to bound a value. Different operator, different output, different consumer |
| [F44](../findings/second-order.md#L845) | "the second-order criterion on single-character directions is blind to the off-diagonal part ... a successor must mix characters or leave Rayleigh quotients ... omits a third option: vary the frame" | **CLEARED, and the block's reason is wrong.** The $\mathfrak b$ test is frame-covariant and reads across the whole of $\Lambda^2$, so it is not a single-character Rayleigh quotient and F44's blindness does not reach it. What the block writes is "F44 asks for a frame variation or a character mix, which is exactly what (iii) is", and (iii) is the REFUTATION of the test rather than a criterion. F44 constrains what a successor criterion may be, so the clearance belongs to (i) and (ii) and not to (iii) |

**Two further defects in that paragraph.** The block links F44 to [fence-posts.md](../findings/fence-posts.md) while its body is in [second-order.md:845](../findings/second-order.md#L845), so the reference does not resolve. And [plan.md:142](../plan.md#L142) makes the same mis-siting, so this is a record-level habit rather than the block's invention and is worth fixing in both places. And the paragraph's tense claims the route is "worth the cycle" and speculates on what it proves "if it closes", after (iii) three paragraphs above has concluded that "a route through $\mathfrak b$ alone cannot work". The salvageable reading is that the $\mathfrak b$ test WITH Ricci-flatness consumed clears the three fences, which is true and is what the paragraph should say.

**One nearby overstatement.** "If it closes it proves more than [I36](../plan.md#L142) asks and the $\theta>\sqrt{3/2}$ clause is spent elsewhere" is loose. A characterisation of the coordinate-diagonal locus by the test proves nothing about maximisers on its own: the route still needs "a maximiser passes the test", which is where the value hypothesis would be spent. The sentence is coherent under that reading and reads as stronger than it is.

## 13. Is any of this already on the record

Searched by the object rather than the vocabulary, over [findings/](../findings/) and the Lean layer. **Four sites, one of them load-bearing.**

1. **The Ricci closed form, which is the important one.** [L180](../findings/diagonal-half.md#L656)(1) states that Ricci-flatness of $\sum\lambda_i\,\omega_i\odot\omega_i$ is $\sum_i\lambda_i\omega_i\omega_i^{\mathsf T}=0$, machine-checked as [Ric_rankSumOp](../lean/HamiltonsCubic/Results/L179Statement.lean#L120), and [L185](../findings/diagonal-half.md#L656) uses precisely the specialisation to unit decomposables, $\omega_i\omega_i^{\mathsf T}=\Pi_i$, that §9 needs. So the block's headline rests on a screen where the record has a machine-checked closed form two hundred lines above it in the same file. **GAP.**
2. **$\star$-invariance at $n=4$**, on the record as $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ at [stratum-two-negative.md:31](../findings/stratum-two-negative.md#L31) and [INDEX-results.md:185](../findings/INDEX-results.md#L185). **GAP**, mild, since the block asserts the fact rather than proving it and the record's identification is the proof.
3. **$\mathrm{Alt}$ as the $\star$-projection at $n=4$**, at [conventions.md:123](../findings/conventions.md#L123), which yields the strictly stronger balance form of §10. **GAP**, and this is the one that would improve the block's own corollary.
4. **"Mutually orthogonal planes make an adapted frame"**, at [diagonal-half.md:646](../findings/diagonal-half.md#L646): "an adapted frame would make such a $W$ coordinate-diagonal". That is exactly (iv)'s punchline, in print, in the same file. **GAP**, partial: (iv)'s explicit $\omega_1\pm\omega_2$ exhibit and the verification of the four inner products are new, and the framing lesson is not.

**Two things I looked for and did NOT find, so they are new.** The failure of the CONVERSE of the record's Plücker instrument. [diagonality.md](../findings/diagonality.md#L19) records "$W$ is non-diagonalisable when some eigenspace contains no decomposable bivector" and its own table labels the instrument "sufficient, certified". The block's (iii) is a closed-form proof that it is STRICTLY sufficient: every eigenspace of the witness is one-dimensional and spanned by a decomposable, so the Plücker obstruction is absent, and the witness is still coordinate-diagonal in no frame. That corollary is worth adding to the instrument table, since a reader could otherwise take "certified" for "characterising". And the four-cycle's $\Lambda^2$ spectrum appears nowhere, though it is immediate from [L177](../findings/diagonal-half.md#L592) plus the observation that a coordinate-diagonal operator's spectrum is its weight multiset padded with zeros.

**A blanket clearance the fence paragraph does not cite.** [diagonality.md:3](../findings/diagonality.md#L3) says of the whole diagonality route that "it never estimates $\theta$", and so "the fence posts, all of which fence bounds on $\theta$, do not reach it". That is broader than the block's per-fence check and would have shortened it, though the record's "all of which" is itself loose, F37 and F44 being about a calculus and a criterion rather than about a bound.

## 14. Arguing the opposite of every defect I propose

- *Against the forcing GAP in §7.* One could say a reader supplies the line count themselves and the block is merely terse. I hold the finding, because the count is the entire content of the disputed step, two lines rather than one satisfy the quoted description, and the count delivers a shorter kill that never needs the $g_2\wedge e_4$ step. Terseness that hides the argument is the defect.
- *Against the screened-Ricci GAP in §9 and C14.* One could say the block flags the number as a screen, which is honest, and that the conclusion is true anyway. I hold it, because the CLAIM is universal over a two-parameter family while the evidence is one point, and the closed form is on the record and machine-checked. The screen is also unreproducible, the eigenvalues being unnamed. This is the block's headline finding and it should not rest on a decimal.
- *Against the $\mathcal W_4$ sharpening in §10.* One could say degeneracy is all the block needs, since its purpose is to fix the shape of the next attempt at "eigenspaces of dimension at least two". Partly fair, so I record this as a GAP against the record rather than a defect in the claim. The sharpening still earns its place: balance fixes the shape more tightly, and the resulting spectral criterion reproduces the block's own screens at the four-cycle and at padded $W_{\mathbb{CP}^2}$.
- *Against the F44 finding.* One could read "which is exactly what (iii) is" as loose shorthand for "the line of work (iii) belongs to". Even so the sentence attributes the clearance to the object that refutes the route, and the citation points at the wrong file. I hold it as REFUTED AS STATED with the clearance itself confirmed.
- *Against the $\mathcal W_n$ quantifier GAP.* One could say padding is obvious. It is three lines and one of them (that all frame vectors are forced into $\mathbb R^4$) needs the spanning argument, so I hold it as a GAP and supply the repair rather than asking for work.
- **Withdrawn.** I proposed and then abandoned two candidates. First, that $\mathrm{Alt}(W^k)$ might carry repeated-index content the block ignores: refuted by §1's total antisymmetry, which holds for every element of $S^2\Lambda^2$. Second, that the "must consume Ricci-flatness" inference is the weaker non-implication the brief describes: refuted in §9, because the witness makes the conclusion FALSE without the hypothesis rather than merely unforced, and Ricci-flatness is the only condition separating $\mathcal W_n$ from the set the witness inhabits.

## 15. What would break it, and what I did to look

- **A Ricci-flat member of the witness family**, which would kill the $\mathcal W_4$ corollary outright and put a genuine Weyl counterexample on the record. Looked for it by solving $\mathop{\mathrm{Ric}}(W)=0$ in closed form over the family in §9. The solution set is nonempty and forces $\mu_1=\mu_2$, $\mu_5=\mu_6$, $\mu_3=\mu_4=-2\mu$, at which point the operator is coordinate-diagonal in the standard frame. **The family yields no counterexample, and the way it fails supports the block.**
- **A frame outside $\{\pm e_1\}\cup\{\pm g_2,\pm g_3,\pm e_4\}$ diagonalising the witness**, which is what the block's forcing step leaves open. Looked for it by computing all fifteen pairwise intersections of the six support planes in §7. Exactly two lines lie in three supports and a frame needs four, so none exists at any $t$ with $\sin2t\ne0$.
- **A constant error in the $\tfrac16$**, the failure mode the brief names as having cost a Gate 2 earlier today. Checked against [wedgeSelf](../lean/HamiltonsCubic/Base/SelfDual.lean#L106) and against [bianchi_rankSumOp](../lean/HamiltonsCubic/Results/L179Statement.lean#L138), which gives $\mathrm{bianchi}=\tfrac12\sum_i\lambda_i\,\mathrm{wedgeSelf}(\omega_i)$, and with $\mathrm{Alt}=\tfrac13\,\mathrm{bianchi}$ the composite is $\tfrac16$. The block's constant is right.
- **A hidden non-orthonormality in the six forms**, which would make them no eigenbasis and collapse the witness. Checked in §5 through $e_2\wedge e_3=g_2\wedge g_3$ and the $SO(2)$ change of basis on the remaining pair.
- **An eigenvalue-independence failure in item (ii)'s Vandermonde**, if the block had grouped by eigenform rather than by value or had kept $\mu=0$ in the system. Checked the determinant, which needs distinctness and nonvanishing, and both are supplied by the block's own index set.
- **A degenerate reading of the balance form of §10 that would contradict the block's screens.** Checked it against the four-cycle, which passes, and against padded $W_{\mathbb{CP}^2}$, which fails, matching the block's reported "exactly $0$ at coordinate-diagonal" and "$1$ at padded $W_{\mathbb{CP}^2}$".

No computation was run: every figure above is closed form, and the two screened numerals I checked ($0.765=\cos0.7$ and the sign of $\lvert\mathop{\mathrm{Ric}}\rvert$) were reduced to expressions by hand.

## Overall verdict

**CONFIRMED, with four GAPs and one sub-claim REFUTED AS STATED. Nothing in the block's mathematics is refuted.**

Items (i), (ii) and (iv) are correct in every part, and (ii)'s two unargued steps, basis-independence and the forcing of $\mathfrak b(P_0)$, are both true with one-line proofs supplied above. The witness of (iii) is real: the six forms are an orthonormal basis, each is decomposable, the test is passed at every $k$, and the operator is coordinate-diagonal in no frame at any $n\ge4$. The headline inference is valid as scoped, and the brief's suspicion about it does not apply, because the witness falsifies the target statement on symmetric-plus-Bianchi rather than merely leaving Ricci-flatness unforced.

The repairs, in order of value: replace the screened $\lvert\mathop{\mathrm{Ric}}\rvert=10$ with $\mathop{\mathrm{Ric}}_{23}=\tfrac12\sin2t\,(\mu_1-\mu_2)$ from the record's own [L180](../findings/diagonal-half.md#L656)(1), which upgrades the headline from one point to the whole family; replace the forcing step with the support-plane line count; replace the $\mathcal W_4$ degeneracy corollary with the $\Lambda^\pm$ balance form that [conventions.md:123](../findings/conventions.md#L123) already supports, which also explains the block's own two screens; state the padding that carries the witness from $n=4$ to every $n\ge4$; and cut the fence paragraph's F44 sentence while fixing its link. Two additions the block has earned and does not draw: the Ricci-flat specialisation of its own family is coordinate-diagonal, which is evidence for its open question, and the witness proves the record's Plücker instrument strictly sufficient rather than characterising, which belongs in [diagonality.md](../findings/diagonality.md#L19)'s instrument table.
