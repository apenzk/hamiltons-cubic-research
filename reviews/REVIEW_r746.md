# r746, the competitor's stabiliser $\mathfrak{stab}(u)=\mathfrak u(2)\oplus\mathfrak{so}(m)$, the mixed-block vanishing, and $\dim(SO(n)\cdot u)=4n-14$, Gate 2

*Worked cold from [BRIEF-g2-l167.md](BRIEF-g2-l167.md) alone: no findings file, no sibling report and no prior verdict was read before every claim below had been settled. **No numerical work was performed.** Every value in this report is exact (rational or symbolic) and the single machine call made was a *screen* of a claim I was about to record (section 4), whose evidence is the closed-form derivation printed beside it, not the run. Log: [agent_logs/g2-l167-r746.log](../agent_logs/g2-l167-r746.log).*

| # | claim | verdict |
| --- | --- | --- |
| A | $\rho(A)$ carries $\Lambda^2\mathbb R^4$ into $\mathbb R^4\wedge\mathbb R^m$ for $A$ in the mixed block, and $u$ kills that block, so $[\rho(A),u]\xi=\rho(A)(u\xi)$ there | **CONFIRMED** |
| B | Restricting the stabiliser equation to $\Lambda^2\mathbb R^4$ is a necessary condition only, and that suffices for a *vanishing* conclusion | **CONFIRMED, legitimate** |
| C | $\rho(A)\omega=-\sum_j(\omega v_j)\wedge f_j$, signs included | **CONFIRMED, sign exact in the brief's convention** |
| D | $A=\sum_j v_j\wedge f_j$ with $\{f_j\}$ orthonormal is always available and loses no generality; coincident or vanishing $v_j$ are harmless | **CONFIRMED** |
| E | $\omega^2=-\lVert\omega\rVert^2\mathrm{Id}$ on $\Lambda^\pm$ in the stated normalisation | **REFUTED, off by a factor $2$; the truth is $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$** |
| E' | every nonzero $\omega\in\Lambda^\pm$ is invertible (the use to which E is put) | **CONFIRMED, the slip is invisible to the conclusion** |
| F | $\mathop{\mathrm{im}}u=\Lambda^\pm$, and the argument survives support on both summands | **CONFIRMED** |
| G | $\mathfrak{stab}(u)\cap(\mathbb R^4\otimes\mathbb R^m)=0$ (first display) | **PROVEN** |
| H | $\mathfrak{so}(m)$ stabilises $u$ entirely | **CONFIRMED** |
| I | $\Lambda^\mp$ commutes with $u$, contributing $3$ | **CONFIRMED** |
| J | the $\mathfrak{so}(3)$-stabiliser of $\mathrm{diag}(2,-1,-1)$ is $\mathfrak{so}(2)$, contributing $1$ | **CONFIRMED, dimension $1$ exactly, not larger** |
| K | $\mathfrak{stab}(u)$ is the direct sum of its three block intersections (the step "the dimension follows by addition" | **GAP), not argued on file; true, and repaired in section 7 by a $\mathbb Z/2$-grading argument the text does not contain** |
| L | $\mathfrak{stab}(u)=\mathfrak u(2)\oplus\mathfrak{so}(m)$ as an equality of Lie algebras (second display) | **HYPOTHESIS-DEBT, true, but only its dimension $4+\binom m2$ is computed; the identification of the $\mathfrak{so}(4)$-part with $\mathfrak u(2)$ appears nowhere** |
| M | $\binom n2-\binom{n-4}2-4=4n-14$ | **CONFIRMED, exact** |
| N | $\dim(SO(n)\cdot u)=4n-14$ (third display) | **PROVEN once K is supplied; as written it inherits K's gap** |
| O | edges $m=0$, $m=1$, $n=4$; the range the claim needs | **CONFIRMED at every edge; the unstated hypothesis is $n\ge4$ with $\binom k2=0$ for $k\le1$** |

**Actionable summary.** The mathematics is right end to end and the first display is fully proved, but two steps are missing from the page, the block-decomposition of $\mathfrak{stab}(u)$ (K, two lines, supplied in section 7) and the identification of the $\mathfrak{so}(4)$-part with $\mathfrak u(2)$ (L, one line, supplied in section 8), and one displayed identity, $\omega^2=-\lVert\omega\rVert^2\mathrm{Id}$, is off by a factor $2$ in the brief's own normalisation.

## 0. Conventions, fixed once

Throughout, $n=4+m$, and $\mathbb R^n=\mathbb R^4\oplus\mathbb R^m$ with $e_1,\dots,e_4$ spanning the first summand and $f_1,\dots,f_m$ the standard orthonormal basis of the second.

$\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ on skew matrices, and $x\wedge y$ is the operator $z\mapsto\langle x,z\rangle y-\langle y,z\rangle x$. In matrices, $x\wedge y=yx^{\mathsf T}-xy^{\mathsf T}$. The normalisation checks: $e_1\wedge e_2$ sends $e_1\mapsto e_2$, $e_2\mapsto-e_1$ and kills $e_3,e_4$, so $\mathop{\mathrm{tr}}(X^{\mathsf T}X)=2$ and $\lVert e_1\wedge e_2\rVert=1$, as the brief states.

**$\rho$ is the adjoint action.** For $A\in\mathfrak{so}(n)$ and $\xi=x\wedge y$, the derivation $\rho(A)\xi=Ax\wedge y+x\wedge Ay$ equals the commutator $[A,\xi]$ of skew operators. Applying $A\xi-\xi A$ to $z$ and using $\langle x,Az\rangle=-\langle Ax,z\rangle$:

$$(A\xi-\xi A)z=\langle x,z\rangle Ay-\langle y,z\rangle Ax+\langle Ax,z\rangle y-\langle Ay,z\rangle x=(Ax\wedge y+x\wedge Ay)z .$$

I use $\rho(A)=\mathop{\mathrm{ad}}_A$ freely below; it is the only place the wedge convention enters, and it enters with no sign.

**The three blocks.** $\Lambda^2\mathbb R^n=V_2\oplus V_1\oplus V_0$ with $V_2=\Lambda^2\mathbb R^4$, $V_1=\mathbb R^4\wedge\mathbb R^m$, $V_0=\Lambda^2\mathbb R^m$; the subscript counts $\mathbb R^4$-factors. The same decomposition read on $\mathfrak{so}(n)=\Lambda^2\mathbb R^n$ is the split $\mathfrak{so}(4)\oplus(\mathbb R^4\otimes\mathbb R^m)\oplus\mathfrak{so}(m)$ of the statement; the middle summand is $V_1$, of dimension $4m$. Dimensions add: $6+4m+\binom m2=6+\tfrac{7m+m^2}2=\binom{4+m}2$.

**Self-dual basis.** $I=e_{12}+e_{34}$, $J=e_{13}+e_{42}$, $K=e_{14}+e_{23}$ span $\Lambda^+$, where $e_{ab}:=e_a\wedge e_b$; the sign-flipped triple spans $\Lambda^-$. $\Lambda^\pm$ are the two ideals of $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$, so $[\Lambda^+,\Lambda^-]=0$.

## Hypothesis inventory

**Used, and where.**

1. **$u$ is padded by zero**: $u|_{V_1}=u|_{V_0}=0$ and $u(V_2)\subseteq V_2$. Sections 1 and 7.
2. **$W_{\mathbb{CP}^2}$ is supported on one of $\Lambda^\pm$, with all three eigenvalues there nonzero.** Section 5 (surjectivity onto $\Lambda^\pm$) and section 6 (the $\Lambda^\mp$ contribution).
3. **Elements of $\Lambda^\pm$ square to a negative multiple of the identity.** Section 4. What is used is invertibility; the *scalar* is not used.
4. **The eigenvalue multiplicity pattern on $\Lambda^\pm$ is (simple, double).** Section 6, for the count $\dim\mathfrak{so}(2)=1$.
5. **$\{f_j\}$ linearly independent.** Section 3.
6. **$n\ge4$**, unstated in the display, and needed for $\binom{n-4}2$ to be the dimension of an $\mathfrak{so}(m)$. Section 9.

**Present in the definitions and never used.**

- **First Bianchi and Ricci-flatness of $\mathcal W_N$.** Neither is invoked at any step. They are what places $W_{\mathbb{CP}^2}$ in $\mathcal W_4$ and what forces the trace of $(2,-1,-1)$ to vanish, but the argument reads the eigenvalues off the definition rather than deriving them, so it never touches either hypothesis.
- **Symmetry of $u$.** Unused in sections 1–5. It is used implicitly nowhere: the mixed-block argument needs only $u|_{V_1}=0$ and one invertible element of $\mathop{\mathrm{im}}u$.
- **The ratio $2:-1:-1$ itself.** Every step survives replacing it by any $(a,b,b)$ with $a\ne b$ and $(a,b)\ne(0,0)$, and by any $(a,b,c)$ at all for the first display, which needs only $u|_{\Lambda^\pm}\ne0$. The specific ratio is load-bearing only in that it is *not* $(a,a,a)$, which is what makes the $\Lambda^+$-contribution $1$ rather than $3$.

## 1. The one-term reduction (claims A, B)

**Where $\rho(A)$ sends each block, for $A$ in the mixed block.** Write $A=\sum_jv_j\wedge f_j$, so that $A$ maps $\mathbb R^4\to\mathbb R^m$ and $\mathbb R^m\to\mathbb R^4$ and vanishes nowhere else. Then on decomposables:

- $\xi=x\wedge y\in V_2$: $\rho(A)\xi=Ax\wedge y+x\wedge Ay$ with $Ax,Ay\in\mathbb R^m$ and $x,y\in\mathbb R^4$, so $\rho(A)\xi\in V_1$.
- $\xi=x\wedge f\in V_1$: $Ax\in\mathbb R^m$ gives $Ax\wedge f\in V_0$, and $Af\in\mathbb R^4$ gives $x\wedge Af\in V_2$, so $\rho(A)\xi\in V_2\oplus V_0$.
- $\xi=f\wedge f'\in V_0$: both terms land in $V_1$.

So the first assertion is exactly right on $V_2$, and (a fact the text does not state but section 7 needs), $\rho(A)$ is **odd** for the $\mathbb Z/2$-grading $\deg\xi\bmod2$, shifting $V_2\leftrightarrow V_1\leftrightarrow V_0$ and never preserving a block.

**The padding kills what it must.** $u$ vanishes on $V_1$, so for $\xi\in V_2$, $u\rho(A)\xi=0$ and

$$[\rho(A),u]\xi=\rho(A)u\xi-u\rho(A)\xi=\rho(A)(u\xi).$$

The text says $u$ "annihilates" $\mathbb R^4\wedge\mathbb R^m$; it annihilates strictly more than that ($\Lambda^\mp$ as well), but the claim as made is what is used and it is true.

**Is a necessary condition enough?** Yes, and this is the one place the direction of the implication matters. Membership in $\mathfrak{stab}(u)$ requires $[\rho(A),u]$ to vanish on all of $\Lambda^2\mathbb R^n$; the proof uses only its vanishing on $V_2$. Since

$$\mathfrak{stab}(u)\cap V_1\ \subseteq\ \{A\in V_1:[\rho(A),u]|_{V_2}=0\},$$

showing the larger set is $\{0\}$ shows the smaller one is. A necessary condition can prove a subspace trivial; it could not prove a subspace *equal* to something, which is why claim K (section 7) is a different matter. **No defect.**

## 2. The expansion, with every sign (claim C)

Let $\omega\in\Lambda^2\mathbb R^4$, regarded as a skew operator killing $\mathbb R^m$ with image in $\mathbb R^4$, and $A=\sum_jv_j\wedge f_j$. Compute $[A,\omega]$ on a vector $z\in\mathbb R^n$.

$$A\omega z=\sum_j\big(\langle v_j,\omega z\rangle f_j-\langle f_j,\omega z\rangle v_j\big)=\sum_j\langle v_j,\omega z\rangle f_j=-\sum_j\langle\omega v_j,z\rangle f_j,$$

the middle term dropping because $\omega z\in\mathbb R^4\perp f_j$, and the last step by skewness of $\omega$.

$$\omega Az=\omega\Big(\sum_j\langle v_j,z\rangle f_j-\langle f_j,z\rangle v_j\Big)=-\sum_j\langle f_j,z\rangle\,\omega v_j,$$

since $\omega f_j=0$. Subtracting,

$$[A,\omega]z=-\sum_j\Big(\langle\omega v_j,z\rangle f_j-\langle f_j,z\rangle\,\omega v_j\Big)=-\sum_j\big((\omega v_j)\wedge f_j\big)z .$$

So $\rho(A)\omega=-\sum_j(\omega v_j)\wedge f_j$, **exactly as written, sign included**, in the brief's convention $x\wedge y:z\mapsto\langle x,z\rangle y-\langle y,z\rangle x$. The brief asked me to say so if a sign were wrong, on the ground that it would be invisible to the conclusion, no sign is wrong. (And it would indeed have been invisible: the conclusion is that this expression vanishes only for $\omega v_j=0$, unchanged by an overall sign.)

## 3. The decomposition $A=\sum v_j\wedge f_j$ (claim D)

**Always available.** $V_1=\mathbb R^4\wedge\mathbb R^m$ has $\{e_a\wedge f_k\}_{a\le4,k\le m}$ as a basis, so any $A\in V_1$ is $\sum_{a,k}A_{ak}\,e_a\wedge f_k=\sum_k v_k\wedge f_k$ with $v_k:=\sum_aA_{ak}e_a$, taking $\{f_k\}$ to be the *standard* orthonormal basis of $\mathbb R^m$ and running $k$ over all of $1,\dots,m$. No choice, no genericity, no loss.

**Coincident or vanishing $v_j$ are harmless.** The step that consumes the decomposition is: $\sum_j(\omega v_j)\wedge f_j=0\Rightarrow\omega v_j=0$ for each $j$. Expand $\omega v_j=\sum_ac_{aj}e_a$; then the sum is $\sum_{a,j}c_{aj}\,e_a\wedge f_j$, and $\{e_a\wedge f_j\}$ is linearly independent because $\{f_j\}$ is, so every $c_{aj}=0$. Nothing here asks the $v_j$ to be distinct, nonzero, or independent, the independence used is that of the $\{f_j\}$, which orthonormality supplies. And the conclusion "$v_j=0$ for all $j$ hence $A=0$" is sound with the standard basis in hand, since then $A=\sum_kv_k\wedge f_k=0$.

One remark on the phrasing: the text writes "$\{f_j\}\subset\mathbb R^m$ orthonormal" without saying it is a basis. If a reader took $\{f_j\}$ to be a proper orthonormal subset chosen to make the expression short, the conclusion $A=0$ would still follow, since $A$ is by construction the sum of those terms. Either reading is sound. **No defect.**

## 4. Invertibility on $\Lambda^\pm$ (claims E, E')

**The displayed identity is off by a factor $2$.** Take $\omega=aI+bJ+cK\in\Lambda^+$ with $I,J,K$ as in section 0. These are the quaternionic triple: $I^2=J^2=K^2=-\mathrm{Id}$, and they anticommute, e.g. $IJe_1=Ie_3=e_4=Ke_1$ while $JIe_1=Je_2=-e_4=-Ke_1$. Hence

$$\omega^2=-(a^2+b^2+c^2)\,\mathrm{Id}.$$

But in the brief's normalisation $\lVert e_{ab}\rVert=1$ with $e_{12}\perp e_{34}$, so $\lVert I\rVert^2=\lVert J\rVert^2=\lVert K\rVert^2=2$ and $I,J,K$ are pairwise orthogonal, giving

$$\lVert\omega\rVert^2=2(a^2+b^2+c^2).$$

Therefore the correct statement is

$$\boxed{\ \omega^2=-\tfrac12\lVert\omega\rVert^2\,\mathrm{Id}\ }\qquad\text{for }\omega\in\Lambda^\pm,$$

and the proof's $\omega^2=-\lVert\omega\rVert^2\mathrm{Id}$ is **false by a factor of $2$** in its own stated convention. The cleanest witness is the concrete one the brief asked for: $\omega=e_{12}+e_{34}$ has $\omega^2=-\mathrm{Id}$ and $\lVert\omega\rVert^2=1+1=2$, so $-\lVert\omega\rVert^2\mathrm{Id}=-2\,\mathrm{Id}\ne\omega^2$.

*Screen.* I ran one exact symbolic check, $\omega=aI+bJ+cK$ built from the matrix form $x\wedge y=yx^{\mathsf T}-xy^{\mathsf T}$, with $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, returning $\omega^2+(a^2+b^2+c^2)\mathrm{Id}=0$ and $\lVert\omega\rVert^2=2a^2+2b^2+2c^2$, and confirming $[\Lambda^+,\Lambda^-]=0$ on all nine basis pairs. This is a screen of the claim above, not its evidence; the evidence is the closed-form derivation in this section.

**Arguing the opposite.** The formula would be right under the *other* common normalisation, $\lVert X\rVert^2=\mathop{\mathrm{tr}}(X^{\mathsf T}X)$ with $\lVert e_{ab}\rVert^2=2$, no; that doubles the norm again and makes it worse. It would be right if $\Lambda^\pm$ were normalised so that a unit $\omega$ is a complex structure, i.e. if $\lVert e_{ab}\rVert=1/\sqrt2$. The brief fixes $\lVert e_{ab}\rVert=1$ explicitly, so there is no reading of the stated conventions under which the displayed identity holds. It is a genuine slip.

**Invisible to the conclusion.** What the proof extracts is that a nonzero $\omega\in\Lambda^\pm$ is invertible, and $\omega^2=-c\,\mathrm{Id}$ with $c=a^2+b^2+c^2>0$ gives $\omega^{-1}=-\omega/c$ immediately. The scalar is never used again. So claim E' stands and the mixed-block argument is unaffected; the repair is to write $-\tfrac12\lVert\omega\rVert^2$, or simply to say "$\omega^2$ is a negative multiple of the identity".

Worth recording: the restriction to $\Lambda^\pm$ is essential and the proof is right to make it. A general element of $\Lambda^2\mathbb R^4$ is *not* invertible ($e_1\wedge e_2$ has $\ker=\mathop{\mathrm{span}}(e_3,e_4)$) so the argument genuinely needs $\mathop{\mathrm{im}}u$ to sit inside a self-duality summand.

## 5. $\mathop{\mathrm{im}}u=\Lambda^\pm$ (claim F)

$u|_{\Lambda^\pm}$ has eigenvalues proportional to $(2,-1,-1)$, all three nonzero, so it is an invertible endomorphism of the $3$-space $\Lambda^\pm$ and its image is that whole $3$-space. **Correct.** Note that the argument needs far less: a single nonzero element of $\mathop{\mathrm{im}}u$ lying inside $\Lambda^+$ or inside $\Lambda^-$.

**Is $W_{\mathbb{CP}^2}$ really supported on one summand?** Yes, and it is forced by the definitions the brief gives rather than assumed: the space of algebraic Weyl tensors in dimension $4$ (symmetric, first Bianchi, trace-free), is $S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, and $\mathbb{CP}^2$ with its Fubini–Study metric is self-dual, so one summand vanishes; the surviving block is trace-free, consistent with $(2,-1,-1)$ summing to $0$. The definition in the brief stipulates the one-summand support directly, so nothing turns on this.

**If it were supported on both** (the brief's hypothetical), the argument survives, because every element of $S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ preserves the splitting $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$. Hence $\mathop{\mathrm{im}}u=\mathop{\mathrm{im}}(u|_{\Lambda^+})\oplus\mathop{\mathrm{im}}(u|_{\Lambda^-})$, and if $u\ne0$ at least one of those two contains a nonzero element, which lies in a single self-duality summand and is invertible by section 4. Only the choice of witness changes. (What would *not* survive is a hypothetical $u$ whose image met $\Lambda^\pm$ only in sums $\omega^++\omega^-$; block-diagonality of Weyl tensors in dimension $4$ rules that out.)

## 6. The three contributions (claims H, I, J)

**$\mathfrak{so}(m)$ acts trivially.** For $B\in\mathfrak{so}(m)$ padded into $\mathfrak{so}(n)$, $\rho(B)$ preserves each of $V_2,V_1,V_0$ and vanishes identically on $V_2$ (both terms of $Bx\wedge y+x\wedge By$ die for $x,y\in\mathbb R^4$). On $V_2$: $\rho(B)u\xi=0$ since $u\xi\in V_2$, and $u\rho(B)\xi=u(0)=0$. On $V_1\oplus V_0$: $u$ vanishes there and $\rho(B)$ preserves it, so both terms vanish. Hence $[\rho(B),u]=0$ for every $B$, contributing $\binom m2$. **Confirmed.**

**$\Lambda^\mp$ commutes with $u$.** Say $u$ is supported on $\Lambda^+$. For $A\in\Lambda^-$, $\rho(A)=\mathop{\mathrm{ad}}_A$ annihilates $\Lambda^+$ (commuting ideals; screened on all nine basis pairs in section 4) and preserves $\Lambda^-$, and it preserves $V_1$ and $V_0$. On $\Lambda^+$: $\rho(A)u\xi=0$ because $u\xi\in\Lambda^+$, and $u\rho(A)\xi=u(0)=0$. On $\Lambda^-$: $u\xi=0$ and $\rho(A)\xi\in\Lambda^-$ so $u\rho(A)\xi=0$. On $V_1\oplus V_0$: $u$ vanishes and $\rho(A)$ preserves. Hence all of $\Lambda^-$ stabilises, contributing $3$. **Confirmed.**

**The $\Lambda^+$ contribution is $1$, and no larger.** $\mathop{\mathrm{ad}}:\Lambda^+\to\mathfrak{so}(\Lambda^+)$ is the adjoint representation of $\mathfrak{su}(2)\cong\mathfrak{so}(3)$ on its own $3$-dimensional underlying space, i.e. the vector representation, hence an isomorphism onto $\mathfrak{so}(3)$. So the $\Lambda^+$-part of the stabiliser is $\{X\in\mathfrak{so}(3):[X,S]=0\}$ with $S=\mathrm{diag}(2,-1,-1)$ in an eigenbasis. Splitting $\mathbb R^3=\mathbb R\oplus\mathbb R^2$ by the eigenvalues, the commutant of $S$ in $\mathfrak{gl}(3)$ is $\mathfrak{gl}(1)\oplus\mathfrak{gl}(2)$, and intersecting with $\mathfrak{so}(3)$ gives $\mathfrak{so}(1)\oplus\mathfrak{so}(2)$, of dimension $0+1=1$. **Confirmed, and it is not larger**: it would be all of $\mathfrak{so}(3)$ only for a scalar $S$, and $(2,-1,-1)$ is not scalar, which is exactly the content of the eigenvalue pattern being used. Concretely, the surviving generator is the rotation of the $(-1)$-eigenplane.

**The $\mathfrak{so}(4)$-total is $3+1=4$, and this much is legitimate**, because $[\rho(A^++A^-),u]=[\rho(A^+),u]$ by the previous paragraph, so $A\in\mathfrak{so}(4)$ stabilises iff its $\Lambda^+$-part does; the stabiliser inside $\mathfrak{so}(4)$ is $\Lambda^-\oplus\mathfrak{so}(2)$, a genuine direct sum of dimension $4$.

**The arithmetic (claim M).** With $m=n-4$,

$$\binom n2-\binom{n-4}2=\frac{n(n-1)-(n-4)(n-5)}2=\frac{(n^2-n)-(n^2-9n+20)}2=\frac{8n-20}2=4n-10,$$

so $\binom n2-\binom{n-4}2-4=4n-14$. **Exact.** And the orbit-stabiliser step is the standard one: $SO(n)$ acts on $\mathcal W_n$ by $g\cdot u=\rho(g)u\rho(g)^{-1}$, the derivative of $g\mapsto g\cdot u$ at the identity is $A\mapsto[\rho(A),u]$, so the isotropy subgroup has Lie algebra $\mathfrak{stab}(u)$ and $\dim(SO(n)\cdot u)=\binom n2-\dim\mathfrak{stab}(u)$.

## 7. The gap: "the dimension follows by addition" (claim K)

**Locate it exactly.** The final paragraph adds three numbers ($\binom m2$ from $\mathfrak{so}(m)$, $3$ from $\Lambda^\mp$, $1$ from $\Lambda^\pm$) and concludes $\dim\mathfrak{stab}(u)=4+\binom m2$. What has been computed is $\dim\big(\mathfrak{stab}(u)\cap\mathfrak{so}(4)\big)=4$, $\dim\big(\mathfrak{stab}(u)\cap\mathfrak{so}(m)\big)=\binom m2$, and $\mathfrak{stab}(u)\cap V_1=0$.

**Exhibit the failure.** Those three facts give only

$$\mathfrak{stab}(u)\ \supseteq\ \big(\mathfrak{stab}\cap\mathfrak{so}(4)\big)\oplus\big(\mathfrak{stab}\cap\mathfrak{so}(m)\big),\qquad\text{i.e.}\quad\dim\mathfrak{stab}(u)\ \ge\ 4+\tbinom m2 .$$

They do not give the reverse. A subspace of $\mathfrak{so}(n)$ can meet a direct summand trivially and still contain vectors with a nonzero component in it: the line $\mathbb R\cdot(X+Y)$ with $0\ne X\in\mathfrak{so}(4)$, $0\ne Y\in V_1$ meets $V_1$ in $0$, meets $\mathfrak{so}(4)$ in $0$, and is not contained in the sum of those intersections. Nothing on the page rules out an $A=A_4+A_{\mathrm{mix}}+A_m$ with $A_{\mathrm{mix}}\ne0$ stabilising $u$ while no summand does on its own, and such an $A$ would raise $\dim\mathfrak{stab}$, *lowering* the orbit dimension below $4n-14$. So the second and third displays do not follow from what is written.

**Argue the opposite**, the strongest reading. One might read "the dimension follows by addition" as tacitly invoking a decomposition principle, and indeed the principle holds here. But it holds for a reason that is stated nowhere, is not automatic, and is exactly the kind of step this review exists to demand. The proof also never says that $\mathfrak{stab}(u)$ is a graded or block subalgebra.

**The repair, in two lines.** By section 1, $\rho(A_{\mathrm{mix}})$ is **odd** for the $\mathbb Z/2$-grading of $\Lambda^2\mathbb R^n$ by $\deg\bmod2$ ($V_2,V_0$ even; $V_1$ odd), while $\rho(A_4)$, $\rho(A_m)$ and $u$ are all **even** (each preserves every $V_i$). Hence

$$[\rho(A),u]=\underbrace{[\rho(A_4)+\rho(A_m),u]}_{\text{even}}+\underbrace{[\rho(A_{\mathrm{mix}}),u]}_{\text{odd}},$$

and even and odd endomorphisms of a $\mathbb Z/2$-graded space intersect in $0$, so both parts vanish separately. The odd part gives $A_{\mathrm{mix}}\in\mathfrak{stab}(u)\cap V_1=0$ by the first display. For the even part, $\rho(A_m)$ vanishes on $V_2$ and $u$ vanishes on $V_1\oplus V_0$, so $[\rho(A_m),u]=0$ identically and the even part reduces to $[\rho(A_4),u]$, forcing $A_4\in\mathfrak{stab}(u)\cap\mathfrak{so}(4)$. Therefore

$$\mathfrak{stab}(u)=\big(\mathfrak{stab}(u)\cap\mathfrak{so}(4)\big)\oplus\mathfrak{so}(m)=\big(\Lambda^-\oplus\mathfrak{so}(2)\big)\oplus\mathfrak{so}(m),$$

of dimension $4+\binom m2$, and the addition is then legitimate. **The conclusion is true; the argument for it is absent from the page.**

## 8. $\mathfrak u(2)$ is named but never identified (claim L)

The second display asserts an equality of Lie algebras, $\mathfrak{stab}(u)=\mathfrak u(2)\oplus\mathfrak{so}(m)$. The proof establishes that the $\mathfrak{so}(4)$-part has dimension $3+1=4$ and then remarks "a total of $4=\dim\mathfrak u(2)$", a coincidence of dimensions, and nothing more. **The identification is not argued anywhere.** Per the brief's rule, the finding is: *this clause has no argument on file.*

It is nevertheless true, in one line. Section 6 gives the $\mathfrak{so}(4)$-part as $\Lambda^-\oplus\mathfrak{so}(2)_{\Lambda^+}\cong\mathfrak{su}(2)\oplus\mathfrak u(1)$, and $\mathfrak u(2)=\mathfrak{su}(2)\oplus\mathfrak u(1)$ as a Lie algebra, its centre is the $\mathfrak u(1)$ of scalars and its derived algebra is $\mathfrak{su}(2)$, and the two intersect trivially. So the abstract isomorphism holds. As a *subalgebra of* $\mathfrak{so}(4)$ it is conjugate to the standard $\mathfrak u(2)$ under $\mathbb C^2\cong\mathbb R^4$, which is also what the geometry predicts: the isotropy of $\mathbb{CP}^2=SU(3)/U(2)$ is $U(2)$. Writing either of these sentences discharges the debt.

Two smaller points on the same clause. First, $\mathfrak{stab}(u)=\mathfrak u(2)\oplus\mathfrak{so}(m)$ is a direct sum of *ideals* ($[\mathfrak{so}(4),\mathfrak{so}(m)]=0$ inside $\mathfrak{so}(n)$) so the notation is honest. Second, at the group level the statement would need care that the algebra statement does not: the stabiliser subgroup of $u$ in $SO(4)$ has the $\Lambda^+$-part covering $O(2)\subset SO(3)$ rather than $SO(2)$, so it has extra components. Since the claim is about $\mathfrak{stab}$, the dimension count and the orbit dimension are untouched.

## 9. Edges (claim O)

| $m$ | $n$ | mixed block | $\dim\mathfrak{stab}$ | $\binom n2$ | orbit | $4n-14$ |
| --- | --- | --- | --- | --- | --- | --- |
| $0$ | $4$ | $0$ (empty) | $4+0=4$ | $6$ | $2$ | $2$ |
| $1$ | $5$ | $\mathbb R^4$ | $4+0=4$ | $10$ | $6$ | $6$ |
| $2$ | $6$ | $\mathbb R^8$ | $4+1=5$ | $15$ | $10$ | $10$ |

- **$m=0$, $n=4$.** The mixed block is the zero space and the first display is vacuously true; $\mathfrak{so}(0)=0$, and the grading argument of section 7 degenerates harmlessly ($V_1=V_0=0$). $\dim(SO(4)\cdot u)=6-4=2$, matching $4\cdot4-14=2$, the correct dimension of the $SO(4)$-orbit of a self-dual Weyl tensor with a repeated eigenvalue, namely $SO(3)/SO(2)=S^2$ up to the $\Lambda^-$-factor acting trivially. **Consistent.**
- **$m=1$, $n=5$.** The mixed block is $4$-dimensional and the sum $\sum_jv_j\wedge f_j$ has a single term, $A=v_1\wedge f_1$; the argument reads $\omega v_1=0$ for an invertible $\omega$, so $v_1=0$. $\mathfrak{so}(1)=0$ and $\binom12=0$. $10-4=6=4\cdot5-14$. **Consistent.**
- **Range.** The claim needs $n\ge4$, since it needs an $\mathbb R^4$ to pad from; the display's $\binom{n-4}2$ then requires the convention $\binom02=\binom12=0$, which is standard but unstated. At $n=4,5$ the formula $4n-14$ gives $2,6$, both positive and correct, so there is no lower-range breakdown to flag beyond naming $n\ge4$. The claim needs nothing else: no upper bound, no genericity, no $m\ge2$.

## 10. What would break it, and what I did to look (claim, and the brief's item 10)

**The falsifier.** The first display fails exactly if there exists $A=\sum_jv_j\wedge f_j\ne0$ in the mixed block with $[\rho(A),u]=0$ on all of $\Lambda^2\mathbb R^n$. By sections 1–3 such an $A$ must in particular satisfy $(u\xi)v_j=0$ for every $\xi\in\Lambda^2\mathbb R^4$ and every $j$, that is, every $v_j$ must lie in

$$\bigcap_{\omega\in\mathop{\mathrm{im}}u}\ker\omega .$$

**Why none exists, in closed form.** $\mathop{\mathrm{im}}u=\Lambda^+$ contains the invertible element $I=e_{12}+e_{34}$ (section 4: $I^2=-\mathrm{Id}$), so the intersection above is contained in $\ker I=0$. Hence every $v_j=0$ and $A=0$. There is nowhere for a falsifier to live, and the containment is strict enough that no perturbation of $u$ within its stated class creates one: any nonzero Weyl tensor in dimension $4$ has an invertible element in its image, by section 5.

**What I did to look.** Analysis only, per the standing rule of the brief: I characterised the falsifier as an element of a common kernel and computed that kernel in closed form. **No search, sweep, census or falsifier hunt was run**, and none is needed, the common kernel is $0$ by a one-line argument, so the falsifier set is empty by proof rather than by absence of evidence. The single machine call in this report is the screen recorded in section 4.

## Overall verdict

**GAP.**

- **The first display, $\mathfrak{stab}(u)\cap(\mathbb R^4\otimes\mathbb R^m)=0$, is PROVEN as written**, every step (A–D, E', F, G) survives cold, the expansion's signs are exact, the necessary-condition shortcut is legitimate for a vanishing conclusion, and the falsifier set is empty in closed form.
- **The second and third displays do not follow from what is on the page.** The passage from three block intersections to $\mathfrak{stab}(u)$ itself (claim K) is asserted, not argued, and the assertion is not automatic, it yields only $\dim\mathfrak{stab}(u)\ge4+\binom m2$, hence only $\dim(SO(n)\cdot u)\le4n-14$. Section 7 supplies the missing two lines via the $\mathbb Z/2$-grading; with them the two displays are true and $4n-14$ is exact.
- **One clause carries hypothesis-debt** (claim L): the identification of the $\mathfrak{so}(4)$-part with $\mathfrak u(2)$ is a Lie-algebra statement for which only a dimension is computed. It is true ($\Lambda^-\oplus\mathfrak{so}(2)\cong\mathfrak{su}(2)\oplus\mathfrak u(1)=\mathfrak u(2)$) and one sentence discharges it.
- **One displayed identity is wrong** (claim E): $\omega^2=-\lVert\omega\rVert^2\mathrm{Id}$ should read $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$ in the brief's own normalisation $\lVert e_i\wedge e_j\rVert=1$. It is invisible to the conclusion, which uses only invertibility.

**What to write to close the gap:** the grading paragraph of section 7, the one-line $\mathfrak u(2)$ identification of section 8, the corrected scalar in section 4, and the hypothesis $n\ge4$.
