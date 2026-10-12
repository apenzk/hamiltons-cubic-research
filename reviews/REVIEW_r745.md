# r745, Gate 2 on L167: the competitor's stabiliser, $\mathfrak{stab}(u)=\mathfrak u(2)\oplus\mathfrak{so}(m)$, and $\dim(SO(n)\cdot u)=4n-14$

**Cold review.** I worked from [BRIEF-g2-l167.md](BRIEF-g2-l167.md) alone and read no findings file, no sibling report and no prior review before forming a verdict on every claim. **No numerical work was done**: every value below is exact rational or symbolic arithmetic derived by hand, and the three places where I ran code are **screens of claims I was about to record**, done in exact `Fraction` arithmetic on objects I built for that purpose, they corroborate hand derivations and are never the warrant for a positive claim. Log: [agent_logs/g2-l167-r745.log](../agent_logs/g2-l167-r745.log).

| Claim | Verdict |
| --- | --- |
| Display 1, $\mathfrak{stab}(u)\cap(\mathbb R^4\otimes\mathbb R^m)=0$ | **PROVEN** |
| Display 2 ($\mathfrak{stab}(u)=\mathfrak u(2)\oplus\mathfrak{so}(m)$ | **GAP), two holes, both closed in §3 and §8; the equality itself is true** |
| Display 3, $\dim(SO(n)\cdot u)=4n-14$ | **PROVEN, on the §3 repair; the arithmetic is exact and holds at every $n\ge4$** |
| Step "on $\Lambda^2\mathbb R^4$ the commutator has one term" | **CONFIRMED** |
| The written proof covers all of $\mathfrak{stab}(u)$, not just its mixed part | **REFUTED, the proof quantifies over $A$ in the mixed block only** |
| Expansion $\rho(A)\omega=-\sum_j(\omega v_j)\wedge f_j$, sign included | **CONFIRMED, the sign as written is right** |
| $A=\sum_jv_j\wedge f_j$ with $\{f_j\}$ orthonormal, always available, no generality lost | **CONFIRMED** |
| $\omega^2=-\lVert\omega\rVert^2\mathrm{Id}$ on $\Lambda^\pm$ | **REFUTED in the stated normalisation, it is $-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$, off by a factor of $2$; inert** |
| Invertibility of every nonzero $\omega\in\Lambda^\pm$ | **CONFIRMED** |
| $\operatorname{im}u=\Lambda^\pm$ from the pattern $(2,-1,-1)$ | **CONFIRMED, and the argument survives support on both summands** |
| $\mathfrak{so}(m)$ stabilises $u$ entirely | **CONFIRMED** |
| $\Lambda^\mp$ commutes with $u$, contributing $3$ | **CONFIRMED** |
| Stabiliser of $\mathrm{diag}(2,-1,-1)$ in $\mathfrak{so}(3)$ is $\mathfrak{so}(2)$, contributing $1$ | **CONFIRMED, exactly $1$, and larger is impossible under tracelessness** |
| The identification of the $4$-dimensional answer with $\mathfrak u(2)$ | **HYPOTHESIS-DEBT, only the dimension is argued; the isomorphism is true and proved in §8** |
| $\binom n2-\binom{n-4}2-4=4n-14$ | **CONFIRMED** |
| Edges $m=0$, $m=1$, $n=4$ | **CONFIRMED, no lower bound beyond $n\ge4$ is needed** |
| First Bianchi and Ricci-flatness | **UNUSED, the whole argument reads only the shape of $u$** |

**Actionable summary.** The mathematics is right and all three displays are true, but the written proof proves only the first of them: it quantifies over $A$ *in the mixed block*, so it never rules out a stabiliser element with a nonzero mixed part sitting diagonally across the splitting, insert the two-line block-projection of §3, after which displays 2 and 3 follow; and replace $\omega^2=-\lVert\omega\rVert^2\mathrm{Id}$ by $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$, or say the norm is the operator norm.

## 0. Conventions, fixed once

$\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ on skew matrices; $x\wedge y$ is $z\mapsto\langle x,z\rangle y-\langle y,z\rangle x$, equivalently the matrix $yx^{\mathsf T}-xy^{\mathsf T}$. Then $e_1\wedge e_2$ sends $e_1\mapsto e_2$ and $e_2\mapsto-e_1$, has four nonzero entries of modulus $1$, and $\lVert e_1\wedge e_2\rVert^2=\tfrac12\cdot2=1$, so $\{e_i\wedge e_j\}_{i<j}$ is orthonormal, as the brief asserts. I use this in §5 and it is the whole content of the factor-of-$2$ finding.

$\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ by that matrix formula, and under it **$\rho(A)=\operatorname{ad}_A$**. Proof: with $A^{\mathsf T}=-A$ one has $x^{\mathsf T}A=-(Ax)^{\mathsf T}$, so
$$[A,\,yx^{\mathsf T}-xy^{\mathsf T}]=\big(Ay\,x^{\mathsf T}-x(Ay)^{\mathsf T}\big)+\big(y(Ax)^{\mathsf T}-Ax\,y^{\mathsf T}\big)=x\wedge Ay+Ax\wedge y,$$
which is the defining derivation property. Every commutator below is read through this identity. It is the one convention the written proof leaves implicit, and it is harmless: the alternative $\rho=-\operatorname{ad}$ would flip a sign in §4 and change nothing, since only vanishing is ever read.

Blocks: $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^4\oplus(\mathbb R^4\wedge\mathbb R^m)\oplus\Lambda^2\mathbb R^m$, matching $\mathfrak{so}(n)=\mathfrak{so}(4)\oplus(\mathbb R^4\otimes\mathbb R^m)\oplus\mathfrak{so}(m)$ under the same isomorphism. I write $A=A_4+A_{\mathrm{mix}}+A_m$ for the corresponding decomposition of $A\in\mathfrak{so}(n)$, and $u=\mathrm{pad}(W_{\mathbb{CP}^2})$, so $u$ is $W_{\mathbb{CP}^2}$ on $\Lambda^2\mathbb R^4$ and zero on the other two blocks.

On $\Lambda^2\mathbb R^4$ I use the orthogonal basis $\alpha_1=e_{12}+e_{34}$, $\alpha_2=e_{13}+e_{42}$, $\alpha_3=e_{14}+e_{23}$ of $\Lambda^+$ (writing $e_{ij}=e_i\wedge e_j$), each of squared norm $2$.

## Hypothesis inventory

**H1** $u$ is padded by zero: $u$ vanishes on $\mathbb R^4\wedge\mathbb R^m$ and on $\Lambda^2\mathbb R^m$, and preserves $\Lambda^2\mathbb R^4$. *Used* in §2 (the one-term reduction), §3 (the repair) and §7 ($\mathfrak{so}(m)$ acting trivially).

**H2** $W_{\mathbb{CP}^2}$ is supported on one of $\Lambda^\pm$ and zero on the other. *Used twice*: for $\operatorname{im}u\subseteq\Lambda^\pm$ in §6, and for the $\Lambda^\mp$ contribution of $3$ in §7. Only the second use is load-bearing, see §6.

**H3** its eigenvalues there are proportional to $(2,-1,-1)$. *Two separate consequences are used*: all three nonzero, so $u|_{\Lambda^\pm}$ is invertible (§6); and the multiplicities split $1+2$, so the $\mathfrak{so}(3)$-stabiliser is $1$-dimensional (§7). **The proportionality constant is never read.**

**H4** $\{f_j\}$ orthonormal, hence independent. *Used* in §4 to pass from a vanishing sum to termwise vanishing. Orthonormality is more than is needed; independence suffices.

**H5** $\Lambda^+$ and $\Lambda^-$ are commuting ideals of $\mathfrak{so}(4)$, and $\operatorname{ad}:\Lambda^+\to\mathfrak{so}(\Lambda^+)$ is an isomorphism onto $\mathfrak{so}(3)$. *Used* in §7, twice, and never stated in the proof.

**H6** $\dim(G\cdot u)=\dim\mathfrak g-\dim\mathfrak{stab}(u)$ for the $SO(n)$-action $g\cdot u=\rho_{\Lambda^2}(g)\,u\,\rho_{\Lambda^2}(g)^{-1}$, whose differential at the identity is $A\mapsto[\rho(A),u]$. *Used* in §9 and unstated. It is the standard orbit–stabiliser statement for a smooth linear action; I flag it only because the third display is a statement about a group orbit while everything proved is about a Lie algebra.

**Unused.** Membership of $\mathcal W_n$, **first Bianchi and Ricci-flatness are never touched**. So is tracelessness $2-1-1=0$ as such (§7 uses only that the three eigenvalues are not all equal, which tracelessness then upgrades to *cannot* be all equal unless $u=0$). So is the normalisation $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, which is precisely why the factor-of-$2$ slip of §5 costs nothing. The argument as given proves the first display for **any** $u$ supported on $\Lambda^2\mathbb R^4$ whose image there contains one invertible $2$-form, and §7 for any $u$ supported on $\Lambda^\pm$ with a $1{+}2$ eigenvalue split; the geometry of $\mathbb{CP}^2$ enters only through those two facts.

## 1. Attack 1, the one-term reduction, and whether a necessary condition suffices

**The block claim is right.** For $A=A_{\mathrm{mix}}=\sum_jv_j\wedge f_j$ and $\xi\in\Lambda^2\mathbb R^4$, §4 computes $\rho(A)\xi=-\sum_j(\xi v_j)\wedge f_j$, and each summand has one leg $\xi v_j\in\mathbb R^4$ and one leg $f_j\in\mathbb R^m$. So $\rho(A_{\mathrm{mix}})\big(\Lambda^2\mathbb R^4\big)\subseteq\mathbb R^4\wedge\mathbb R^m$, and by **H1** $u$ kills exactly that block. Hence $[\rho(A),u]\xi=\rho(A)(u\xi)-u(\rho(A)\xi)=\rho(A)(u\xi)$. The written sentence is exact.

**What $\rho(A_{\mathrm{mix}})$ does to the other two blocks**, for completeness, since the brief asks. On $\mathbb R^4\wedge\mathbb R^m$: $\rho(A_{\mathrm{mix}})(x\wedge f)=(A_{\mathrm{mix}}x)\wedge f+x\wedge(A_{\mathrm{mix}}f)$ with $A_{\mathrm{mix}}x\in\mathbb R^m$ and $A_{\mathrm{mix}}f\in\mathbb R^4$, so the image lands in $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^4$. On $\Lambda^2\mathbb R^m$ it lands in $\mathbb R^4\wedge\mathbb R^m$. So $\rho(A_{\mathrm{mix}})$ is *odd* for the $\mathbb Z/2$ grading that gives $\Lambda^2\mathbb R^4$ and $\Lambda^2\mathbb R^m$ degree $0$ and the mixed block degree $1$, which is why the reduction is clean.

**Is a necessary condition enough?** For the first display, **yes, and there is no gap**. The proof takes $A$ in the stabiliser, derives a consequence of $[\rho(A),u]=0$ on one block only, and concludes $A=0$. The conclusion is a *containment* $\mathfrak{stab}\cap(\mathbb R^4\otimes\mathbb R^m)\subseteq\{0\}$, and the reverse containment is trivial. Discarding information can only shrink the solution set from below, never certify membership, and membership is never certified here.

**For the second and third displays, no, and this is the review's main finding; see §3.**

## 2. Attack 2, the expansion, sign by sign

Take $\omega\in\Lambda^2\mathbb R^4$, extended by zero to $\mathbb R^n$, so $\omega f=0$ for every $f\in\mathbb R^m$. Using $\rho=\operatorname{ad}$ from §0 and antisymmetry of the bracket,
$$\rho(A)\omega=[A,\omega]=-[\omega,A]=-\sum_j\rho(\omega)\big(v_j\wedge f_j\big)=-\sum_j\Big((\omega v_j)\wedge f_j+v_j\wedge(\omega f_j)\Big)=-\sum_j(\omega v_j)\wedge f_j,$$
the last step by $\omega f_j=0$. **The sign as written is correct**, and it survives the one convention the proof leaves implicit. I record, as the brief asks, that a sign error here would have been invisible to the conclusion, the argument reads only "$=0$", and $-\sum_j(\omega v_j)\wedge f_j$ and $+\sum_j(\omega v_j)\wedge f_j$ vanish together, but there is none to report.

**Screen** (exact `Fraction` arithmetic, $n=6$, $m=2$, $f_1=e_5$, $f_2=e_6$, $v_1=(3,-1,0,2)$, $v_2=(1,1,-4,0)$, tested at $\omega\in\{e_{12},\ \alpha_1,\ 2\alpha_1+e_{13}\}$): $\operatorname{ad}_A$ agreed with the derivation $Ax\wedge y+x\wedge Ay$; $\rho(A)\omega$ equalled $-\sum_j(\omega v_j)\wedge f_j$ and differed from $+\sum_j(\omega v_j)\wedge f_j$; and $\rho(A)\omega$ had zero component in both $\Lambda^2\mathbb R^4$ and $\Lambda^2\mathbb R^m$. This corroborates §1 and §2; the warrant is the derivation above.

## 3. The one real hole, the proof establishes only the first display

**Locate it.** The proof opens *"Write $A=\sum_jv_j\wedge f_j$ with $v_j\in\mathbb R^4$ and $\{f_j\}\subset\mathbb R^m$ orthonormal"*, which restricts the quantifier to $A\in\mathbb R^4\otimes\mathbb R^m$, and closes at $\square$ having shown such an $A$ is zero. That is the first display and nothing more. The next paragraph then computes $\dim\mathfrak{stab}(u)$ as $3+1+\binom m2$, which presumes
$$\mathfrak{stab}(u)=\big(\mathfrak{stab}(u)\cap\mathfrak{so}(4)\big)\oplus\big(\mathfrak{stab}(u)\cap\mathfrak{so}(m)\big).$$
**Nothing on file supplies that.**

**Exhibit the failure concretely.** The inference "$S\cap V_2=0$, therefore $S\subseteq V_1\oplus V_3$" is false for subspaces in general, and one line of it is all that separates the displays. In $\mathbb R^3=V_1\oplus V_2\oplus V_3$ (coordinate lines), $S=\mathbb R(1,1,0)$ meets $V_2$ in $0$ and is not contained in $V_1\oplus V_3$. So an element $A=A_4+A_{\mathrm{mix}}$ with $A_{\mathrm{mix}}\ne0$, killed by $[\rho(\cdot),u]$ only in combination, is not excluded by anything the proof writes down; it would leave the first display intact and make the second false. **Silence on this is the gap**, not an error.

**Argue the opposite.** The strongest reading is that the opening "Write $A=\dots$" is meant of a general $A\in\mathfrak{so}(n)$ that *happens* to have been shown to lie in the mixed block, or that the reader is to run the same computation with $A_4$ and $A_m$ carried along. That reading is available but is not what the words say, and it is not free: it needs the observation below, which the proof does not make.

**The repair, two lines, and it works.** Compose $\Phi(A)=[\rho(A),u]$ with restriction to $\Lambda^2\mathbb R^4$ and projection onto $\mathbb R^4\wedge\mathbb R^m$.

- $A_4$ contributes nothing there: $A_4$ preserves $\mathbb R^4$, so $\rho(A_4)$ preserves $\Lambda^2\mathbb R^4$; $u$ preserves it too by **H1**; so $[\rho(A_4),u]$ maps $\Lambda^2\mathbb R^4$ into $\Lambda^2\mathbb R^4$.
- $A_m$ contributes nothing there either: $A_m$ kills $\mathbb R^4$, so $\rho(A_m)$ kills $\Lambda^2\mathbb R^4$; and $u\xi\in\Lambda^2\mathbb R^4$, so $\rho(A_m)u\xi=0$ as well. Hence $[\rho(A_m),u]\big|_{\Lambda^2\mathbb R^4}=0$ identically.
- $A_{\mathrm{mix}}$ contributes $\rho(A_{\mathrm{mix}})\circ u|_{\Lambda^2\mathbb R^4}$, by §1.

So $\Pi_{\mathbb R^4\wedge\mathbb R^m}\circ\Phi(A)\big|_{\Lambda^2\mathbb R^4}=\rho(A_{\mathrm{mix}})\circ u|_{\Lambda^2\mathbb R^4}$ **depends on $A_{\mathrm{mix}}$ alone**. Now $\Phi(A)=0$ forces $\rho(A_{\mathrm{mix}})(u\xi)=0$ for every $\xi$, and §4–§6 give $A_{\mathrm{mix}}=0$. Hence $\mathfrak{stab}(u)\subseteq\mathfrak{so}(4)\oplus\mathfrak{so}(m)$, which is what the addition needs.

**And the splitting then completes.** For $A=A_4+A_m$, the operator $A$ preserves both $\mathbb R^4$ and $\mathbb R^m$, so $\rho(A)$ preserves each of the three blocks. On $\mathbb R^4\wedge\mathbb R^m$ and on $\Lambda^2\mathbb R^m$, $u$ vanishes and $\rho(A)$ stays inside, so both terms of $[\rho(A),u]$ vanish there identically. On $\Lambda^2\mathbb R^4$, the $A_m$ term vanishes by the bullet above. So $[\rho(A),u]=0$ **iff** $[\rho(A_4),u]\big|_{\Lambda^2\mathbb R^4}=0$, with $A_m$ free, that is, $\mathfrak{stab}(u)=\big(\mathfrak{stab}(u)\cap\mathfrak{so}(4)\big)\oplus\mathfrak{so}(m)$ exactly, and the addition is licensed.

**Verdict on the display.** True; the proof of it is incomplete as written, and the missing step is the one displayed above.

## 4. Attack 3, the decomposition $A=\sum_jv_j\wedge f_j$

**Always available, and nothing is lost.** The mixed block is $\mathbb R^4\otimes\mathbb R^m$ under $x\otimes f\mapsto x\wedge f$; fix once and for all the standard orthonormal basis $f_1,\dots,f_m$ of $\mathbb R^m$ and write $A=\sum_{a,j}c_{aj}\,e_a\wedge f_j=\sum_{j=1}^m v_j\wedge f_j$ with $v_j=\sum_ac_{aj}e_a$. This is a canonical decomposition, not a choice, and it exists for every $A$ in the block. (A singular-value decomposition gives the sharper form with $\{v_j\}$ orthogonal too and at most $\min(4,m)$ terms; the argument does not need it.)

**Coincident or vanishing $v_j$ are harmless.** Only **H4** is used, and it constrains the $f_j$, never the $v_j$. If $v_1=v_2$ the two terms remain independent because $e_a\wedge f_1$ and $e_a\wedge f_2$ are; if $v_j=0$ the $j$-th term is absent and the conclusion $v_j=0$ is already true of it. The final step "$v_j=0$ for every $j$, hence $A=0$" is exactly right in this normalisation, since $\{e_a\wedge f_j\}$ is a basis of the block.

**Where it would break.** Had the proof instead demanded $\{v_j\}$ orthonormal with $f_j$ arbitrary, the same sentence would be wrong: $\sum_j(\omega v_j)\wedge f_j=0$ would no longer separate, since the $\omega v_j$ need not be independent even when the $v_j$ are. The proof picks the correct side of the tensor product to normalise.

## 5. Attack 4, the normalisation of $\omega^2$, which is off by a factor of two

**Locate it.** *"every nonzero $\omega\in\Lambda^\pm$ satisfies $\omega^2=-\lVert\omega\rVert^2\mathrm{Id}$"*.

**Exhibit the failure in closed form.** Take $\omega=\alpha_1=e_{12}+e_{34}$. As an operator, $e_1\mapsto e_2\mapsto-e_1$ and $e_3\mapsto e_4\mapsto-e_3$, so $\omega^2=-\mathrm{Id}$ exactly. But by §0 the four nonzero matrix entries have modulus $1$, so $\lVert\omega\rVert^2=\tfrac12\cdot4=2$. Hence $-\lVert\omega\rVert^2\mathrm{Id}=-2\,\mathrm{Id}\ne\omega^2$. **The stated identity is false by a factor of exactly $2$**, in the normalisation the brief fixes.

**The general statement.** $\alpha_1,\alpha_2,\alpha_3$ are orthogonal with $\lVert\alpha_i\rVert^2=2$, satisfy $\alpha_i^2=-\mathrm{Id}$, and anticommute, e.g. $\alpha_1\alpha_2e_1=\alpha_1e_3=e_4$ against $\alpha_2\alpha_1e_1=\alpha_2e_2=-e_4$, and likewise on $e_2$; indeed $\alpha_1\alpha_2=-\alpha_3$, so $\Lambda^+$ is the imaginary quaternions. For $\omega=\sum_ic_i\alpha_i$ the cross terms cancel and
$$\omega^2=-\Big(\sum_ic_i^2\Big)\mathrm{Id},\qquad \lVert\omega\rVert^2=2\sum_ic_i^2,\qquad\text{so}\qquad \boxed{\ \omega^2=-\tfrac12\lVert\omega\rVert^2\,\mathrm{Id}\ }$$
for every $\omega\in\Lambda^+$, and the same on $\Lambda^-$ by the mirror basis.

**Screen** (exact, corroborating the display above): at $(c_1,c_2,c_3)=(1,2,3)$, $\lVert\omega\rVert^2=28$ and $\omega^2=-14\,\mathrm{Id}$; at $(\tfrac13,-\tfrac57,2)$, $\lVert\omega\rVert^2=\tfrac{4076}{441}$ and $\omega^2=-\tfrac{2038}{441}\mathrm{Id}$. Ratio $-\tfrac12$ both times.

**Argue the opposite.** There is a reading that makes the sentence literally true: every nonzero $\omega\in\Lambda^\pm$ is conformal (all four singular values equal $\big(\sum c_i^2\big)^{1/2}$) so the *operator* norm satisfies $\lVert\omega\rVert_{\mathrm{op}}^2=\sum_ic_i^2$ and $\omega^2=-\lVert\omega\rVert_{\mathrm{op}}^2\mathrm{Id}$ exactly. This is the strongest reading the words support, and it is a real identity. But the brief fixes $\lVert\cdot\rVert$ by $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ and pins it with $\lVert e_i\wedge e_j\rVert=1$; under that declared convention the sentence is wrong. **Repair: write $-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$, or say the norm meant is the operator norm.**

**The error is inert.** Everything the argument extracts is "$\omega^2$ is a nonzero multiple of the identity, so $\omega$ is invertible", and $-\tfrac12\lVert\omega\rVert^2\ne0$ for $\omega\ne0$ just as $-\lVert\omega\rVert^2$ does. Nothing downstream reads the constant. **Invertibility of every nonzero element of $\Lambda^\pm$: CONFIRMED.**

## 6. Attack 5, the image of $u$, and what happens if the support is not on one summand

**The image is full, and the reason is exactly the one given.** $u|_{\Lambda^\pm}$ is symmetric with eigenvalues proportional to $(2,-1,-1)$; **none is zero**, so $u|_{\Lambda^\pm}$ is an isomorphism of that $3$-space and $\operatorname{im}(u|_{\Lambda^2\mathbb R^4})=\Lambda^\pm$. The eigenvalue pattern is doing precisely one job here, being nowhere zero. (Note that trace $2-1-1=0$, so the pattern is consistent with $u$ being a Weyl operator; that fact is used nowhere.)

**One element suffices, and this is where the invertibility lands.** The condition extracted in §1 is $\rho(A)(u\xi)=0$ for *every* $\xi\in\Lambda^2\mathbb R^4$, i.e. $\omega v_j=0$ for every $j$ and every $\omega\in\operatorname{im}u$. It is therefore enough to name a single invertible $\omega$ in that image, and §5 supplies one, every nonzero element of $\Lambda^\pm$ will do. The sentence *"One element of the image finishes it"* is exact.

**Is $W_{\mathbb{CP}^2}$ really on one summand?** In the brief this is a **stipulation**, not a claim to verify: the definition says "supported on one of $\Lambda^\pm$ ... and zero on the other summand". It is also the truth about Fubini–Study $\mathbb{CP}^2$, which is self-dual Einstein with $W^-=0$ and $W^+$ of type $(2,-1,-1)$. So there is nothing to break here.

**What if it were supported on both?** The first display **survives**, provided at least one of $W^\pm$ is nonzero: the image then contains $W^+(\Lambda^+)\subseteq\Lambda^+$ (or the $\Lambda^-$ analogue), and any nonzero element of $\Lambda^\pm$ is invertible by §5, so the same single-element argument runs. What does **not** survive is §7's contribution of $3$ from $\Lambda^\mp$, if both $W^\pm$ are nonzero the commuting-ideal argument dies on both sides and the stabiliser inside $\mathfrak{so}(4)$ drops to at most $1+1=2$, changing the dimension. **So H2 is load-bearing for the dimension and idle for the first display.** Worth noting because it identifies exactly which hypothesis each display consumes.

A genuine degeneration would be an image consisting only of *degenerate* $2$-forms (say $\operatorname{im}u=\mathbb R\,e_{12}$, whose kernel is $\operatorname{span}(e_3,e_4)$) and then $A=e_3\wedge f_1$ would be a nonzero mixed stabiliser element. The pattern $(2,-1,-1)$ on a single $\Lambda^\pm$ is exactly what excludes this: see §10.

## 7. Attack 6, the three contributions

**(a) $\mathfrak{so}(m)$ stabilises $u$ entirely. CONFIRMED.** For $A_m\in\mathfrak{so}(m)$, $\rho(A_m)$ annihilates $\Lambda^2\mathbb R^4$ (both legs are killed), preserves $\mathbb R^4\wedge\mathbb R^m$ and preserves $\Lambda^2\mathbb R^m$. On $\Lambda^2\mathbb R^4$: $u\xi\in\Lambda^2\mathbb R^4$ so $\rho(A_m)u\xi=0$, and $\rho(A_m)\xi=0$, so the commutator vanishes. On the other two blocks $u$ vanishes and $\rho(A_m)$ stays inside them, so both terms vanish. Contribution $\binom m2$.

**(b) $\Lambda^\mp$ commutes with $u$. CONFIRMED.** Say $u$ is supported on $\Lambda^+$ and take $A\in\Lambda^-\subset\mathfrak{so}(4)$. By **H5**, $\rho(A)=\operatorname{ad}_A$ kills $\Lambda^+$ and preserves $\Lambda^-$. On $\Lambda^+$: $u\xi\in\Lambda^+$, so $\rho(A)u\xi=0$, and $\rho(A)\xi=0$, commutator zero. On $\Lambda^-$: $u\eta=0$, and $\rho(A)\eta\in\Lambda^-$ so $u\rho(A)\eta=0$, commutator zero. (On the blocks outside $\Lambda^2\mathbb R^4$, part (a)'s argument applies verbatim with $A_4$ in place of $A_m$.) Contribution $3$. **The step needs $\Lambda^\pm$ to be commuting ideals**, which the proof uses without naming; that is a citation gap only, the fact being standard $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$.

**(c) The $\mathfrak{so}(3)$ stabiliser of $\mathrm{diag}(2,-1,-1)$ is one-dimensional. CONFIRMED, and it cannot be larger.** By **H5**, $\operatorname{ad}:\Lambda^+\to\mathfrak{so}(\Lambda^+)\cong\mathfrak{so}(3)$ is an isomorphism, so the question is the commutant of $D=\mathrm{diag}(2,-1,-1)$ inside $\mathfrak{so}(3)$. $D$ has eigenvalue $2$ with multiplicity $1$ and $-1$ with multiplicity $2$; the commutant of $D$ in $\mathfrak{gl}(3)$ is $\mathfrak{gl}(1)\oplus\mathfrak{gl}(2)$ blockwise, and intersecting with skew-symmetry gives $\mathfrak{so}(1)\oplus\mathfrak{so}(2)=0\oplus\mathfrak{so}(2)$, of dimension $1$. **Larger is impossible**: the commutant would exceed $\mathfrak{so}(2)$ only if $D$ had a repeated eigenvalue of multiplicity $3$, i.e. $D$ scalar, and a scalar with trace $0$ is $D=0$, contradicting the pattern. So the answer is exactly $1$, and the generator is a rotation about the eigenvalue-$2$ axis. **The brief's suspicion that the pattern might have a larger stabiliser is unfounded**, and the reason is the $1{+}2$ multiplicity split, which is the second and last thing **H3** is used for.

**(d) The arithmetic.** $\dim\mathfrak{stab}(u)=3+1+\binom m2=4+\binom{n-4}2$, and
$$\binom n2-\binom{n-4}2-4=\frac{n^2-n-(n^2-9n+20)}2-4=\frac{8n-20}2-4=4n-10-4=4n-14.$$
**CONFIRMED**, exactly.

## 8. Attack 7, the identification with $\mathfrak u(2)$ is stated, not argued

**Locate it.** The proof writes *"a total of $4=\dim\mathfrak u(2)$"*. That is a numerical coincidence between two integers. The second display asserts an equality of **Lie algebras**, $\mathfrak{stab}(u)=\mathfrak u(2)\oplus\mathfrak{so}(m)$, and **no isomorphism is exhibited anywhere on file**. Per the brief's rule, the finding is: *this half of the claim has no argument on file*, and I record it as **HYPOTHESIS-DEBT** rather than as an error, because it is true and cheap.

**The fill.** From §7, $\mathfrak{stab}(u)\cap\mathfrak{so}(4)=\Lambda^-\oplus\mathbb R J$, where $J\in\Lambda^+$ is the eigenvector of $u|_{\Lambda^+}$ with eigenvalue $2$, the $\mathfrak{so}(2)$ of §7(c) is generated by the rotation about the eigenvalue-$2$ axis, so its generator is $J$ itself. Now $\Lambda^-\cong\mathfrak{su}(2)$ as a Lie algebra (**H5**), $\mathbb R J$ is central in the sum because $[\Lambda^-,\Lambda^+]=0$, and
$$\Lambda^-\oplus\mathbb R J\;\cong\;\mathfrak{su}(2)\oplus\mathbb R\;=\;\mathfrak u(2),$$
the last being the standard splitting $\mathfrak u(2)=\mathfrak{su}(2)\oplus\mathbb R\,i\,\mathrm{Id}$ into trace-free part and centre. Geometrically this is the right answer: normalising so that $J^2=-\mathrm{Id}$ (possible by §5), $J$ is a complex structure on $\mathbb R^4$ and $\Lambda^-\oplus\mathbb R J$ is exactly $\mathfrak u(2)=\{A\in\mathfrak{so}(4):[A,J]=0\}$, the isotropy of $\mathbb{CP}^2$, with $J$ its Kähler form. So the display is true, and the argument for it is the paragraph just written, not the one on file.

**Argue the opposite.** One could read *"$4=\dim\mathfrak u(2)$"* as shorthand, the identification being folklore for $\mathbb{CP}^2$. That is the strongest reading, and it is why I call this debt rather than a break. It remains true that the record states an isomorphism and proves a cardinality.

## 9. Attack 9, the edges

Write $m=n-4\ge0$ throughout; the whole setup requires $n\ge4$ for $u$ to exist, and **nothing in the argument needs more**.

- **$m=0$, $n=4$.** The mixed block is $\{0\}$ and the index set $\{f_j\}$ is empty, so the first display is vacuously true, the proof's own sum is empty and $A=0$ trivially. $\mathfrak{so}(0)=0$, $\mathfrak{stab}(u)=\mathfrak u(2)$ of dimension $4$, orbit dimension $6-4=2$, and $4\cdot4-14=2$. **Holds.** Note $\binom{n-4}2=\binom02=0$, consistent.
- **$m=1$, $n=5$.** The mixed block is $\mathbb R^4\otimes\mathbb R$, dimension $4$; the decomposition of §4 has a single term with $f_1$ a unit vector, and orthonormality is the trivial condition $\lVert f_1\rVert=1$. The argument runs unchanged. $\mathfrak{so}(1)=0$, $\dim\mathfrak{stab}=4$, orbit $10-4=6=4\cdot5-14$. **Holds.**
- **$m=2$, $n=6$.** $\binom22=1$, $\dim\mathfrak{stab}=5$, orbit $15-5=10=4\cdot6-14$. **Holds.**
- **$n<4$** is outside the definition of $u$; the formula $4n-14$ would return $-2$ at $n=3$, so the statement should carry $n\ge4$ explicitly. The convention $\binom k2=0$ for $k\in\{0,1\}$ is needed for the displayed identity at $n=4,5$ and is standard.

**Screen** (exact, corroborating §3, §7 and §9). I assembled $u$ as the rational operator $\xi\mapsto\sum_i\lambda_i\frac{\langle\xi,\alpha_i\rangle}{\langle\alpha_i,\alpha_i\rangle}\alpha_i$ with $\lambda=(2,-1,-1)$, zero on $\Lambda^-$ and on the two padded blocks, built the linear map $A\mapsto[\rho(A),u]$ on all of $\mathfrak{so}(n)$, and took its exact rank by Gaussian elimination over $\mathbb Q$:

| $n$ | $\dim\mathfrak{so}(n)$ | rank $=\dim$ orbit | nullity $=\dim\mathfrak{stab}$ | $4n-14$ | $4+\binom{n-4}2$ |
| --- | --- | --- | --- | --- | --- |
| $4$ | $6$ | $2$ | $4$ | $2$ | $4$ |
| $5$ | $10$ | $6$ | $4$ | $6$ | $4$ |
| $6$ | $15$ | $10$ | $5$ | $10$ | $5$ |
| $7$ | $21$ | $14$ | $7$ | $14$ | $7$ |

Every row matches. This is corroboration of claims derived above, not their warrant; the derivations are §3, §7 and §9.

## 10. Attack 10, what would break it, and what I did

**The falsifier.** A nonzero $A=\sum_jv_j\wedge f_j$ in the mixed block with $\omega v_j=0$ for every $j$ and every $\omega\in\operatorname{im}\big(u|_{\Lambda^2\mathbb R^4}\big)$. Equivalently, a nonzero vector in
$$\bigcap_{\omega\in\operatorname{im}u}\ker\omega\subseteq\mathbb R^4 ,$$
since $A\ne0$ means some $v_j\ne0$, and each $v_j$ must lie in that intersection.

**Why none exists, without searching.** The intersection is contained in $\ker\omega_0$ for any single $\omega_0\in\operatorname{im}u$, and §5–§6 produce an invertible $\omega_0$, so the intersection is $\{0\}$. The falsifier is **provably absent**, so no search is called for and none was run, consistent with the analysis-only footing of this brief.

**What the falsifier would look like if a hypothesis were dropped.** Weaken **H3** to allow a zero eigenvalue, say $u|_{\Lambda^+}$ of type $(1,-1,0)$ with kernel direction $\alpha_3$: the image is $\operatorname{span}(\alpha_1,\alpha_2)$, still all invertible, so this particular weakening does not break it, every nonzero element of $\Lambda^\pm$ is invertible whatever the eigenvalues. **The real fragility is H2's placement, not H3's values.** Drop the requirement that the support sit inside a single $\Lambda^\pm$ and let $\operatorname{im}u=\mathbb R\,e_{12}=\mathbb R\cdot\tfrac12(\alpha_1+\beta_1)$ with $\beta_1=e_{12}-e_{34}\in\Lambda^-$: then $e_{12}$ has rank $2$ with kernel $\operatorname{span}(e_3,e_4)$, and $A=e_3\wedge f_1$ is a nonzero mixed-block stabiliser element, falsifying the first display. **So what the argument truly consumes is that the image contains one nondegenerate $2$-form**, which "supported on one $\Lambda^\pm$" delivers for free and general support does not.

**The second falsifier, the one the written proof does not exclude.** Per §3, an $A=A_4+A_{\mathrm{mix}}$ with $A_{\mathrm{mix}}\ne0$ and $[\rho(A),u]=0$ would leave display 1 standing and refute display 2. The proof as written says nothing against it; the block-projection of §3 does, and I verified there that the projection isolates $A_{\mathrm{mix}}$.

## Overall verdict

**GAP, the mathematics is sound, all three displays are true, and both holes are closed inside this report.**

- **What is proved on file:** the first display, completely and correctly, with the sign of the expansion right and the one-term reduction exact.
- **What is not:** the passage from "the stabiliser meets the mixed block only in $0$" to "the stabiliser is contained in $\mathfrak{so}(4)\oplus\mathfrak{so}(m)$", which the second and third displays both need, repaired in §3 by projecting $[\rho(A),u]|_{\Lambda^2\mathbb R^4}$ onto $\mathbb R^4\wedge\mathbb R^m$, which depends on $A_{\mathrm{mix}}$ alone; and the identification of the $4$-dimensional answer with $\mathfrak u(2)$, which is argued only by dimension, repaired in §8 as $\Lambda^-\oplus\mathbb R J\cong\mathfrak{su}(2)\oplus\mathbb R=\mathfrak u(2)$, with $J$ the eigenvalue-$2$ eigenvector, i.e. the Kähler form.
- **One false sentence, inert:** $\omega^2=-\lVert\omega\rVert^2\mathrm{Id}$ is $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$ in the declared normalisation, witnessed at $\omega=e_{12}+e_{34}$ where $\omega^2=-\mathrm{Id}$ and $\lVert\omega\rVert^2=2$. It becomes true verbatim under the operator norm.
- **Two hypotheses idle:** first Bianchi and Ricci-flatness are never used; membership of $\mathcal W_n$ is decoration here.
