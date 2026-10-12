# Reviewer r748, the two pinned moments of $F_u$, $\lVert T\rVert^2$, and the check they run on the tabulated $\mathbb{CP}^2$ spectrum

**Cold review.** Written from [reviews/BRIEF-g2-l168.md](BRIEF-g2-l168.md) alone; the findings block it came from was not opened, and neither was the sibling report on the same brief. No numerical work was done: every value below is exact rational or symbolic arithmetic, done by hand and then screened. Two screens are reported as screens and are labelled where they appear, an exact-rational recomputation of the table's moments, and an exact Weyl-character count of invariants, neither is offered as evidence for a positive claim. Log: [agent_logs/g2-l168-r748.log](../agent_logs/g2-l168-r748.log).

## Claim table

| # | claim | verdict |
|---|---|---|
| C1 | $\langle F_uh,k\rangle=T(u,h,k)$ on the nose, no constant | **PROVEN** |
| C2 | $\langle X\#Y,Z\rangle$ totally symmetric; anticommutator term likewise | **PROVEN**, both, and the second is an identity on all matrices |
| C3 | $\mathcal W_n$ carries $F_u$ as an endomorphism at all (closure under $B$) | **PROVEN**, unstated in the block, and it is a real step |
| C4 | $\operatorname{tr}(F_u)=0$ for every $u\in\mathcal W_n$ | **PROVEN** for $n\ge5$ |
| C5 | $\operatorname{tr}(F_u^2)=\tfrac{(n-1)(2n-1)}4\lVert u\rVert^2$ | **PROVEN** for $n\ge5$, conditional on the inherited Killing constant |
| C6 | $\lVert T\rVert^2=\tfrac{(n-1)(2n-1)}4\dim\mathcal W_n$ | **PROVEN** |
| C7 | the six multiplicity counts sum to $\dim M_\lambda$ | **CONFIRMED**, all six |
| C8 | the four block traces are $4,2,\tfrac16,\tfrac12$ | **CONFIRMED**, all four |
| C9 | the collapse to $\tfrac{(2m+7)(m+3)}6=\tfrac{(2n-1)(n-1)}6$, and $\tfrac{253}4$ at $n=12$ | **CONFIRMED** |
| C10 | the table's blockwise first moments vanish | **CONFIRMED**, all six |
| C11 | "more than the identity demands" | **CONFIRMED**, and made precise: the identity leaves a one-parameter line of trace vectors |
| C12 | "two scalars not pinning 56 eigenvalues" | **CONFIRMED in conclusion, UNDERSTATED as an assessment**, it is six conditions on 56, and it does pin the other five to zero |
| C13 | $\operatorname{tr}(F_u^3)$ is an invariant cubic **hence** a multiple of $P(u)$ | **REFUTED**, the "hence" is a non-sequitur, and the space of invariant cubics is two-dimensional at every $n$ in scope |
| C14 | the table returns $\theta^{*3}\tfrac{2n^2-15n+1}{36}$ | **CONFIRMED** |
| C15 | the tabled decomposition is valid across the stated range | **REFUTED at $n=6$**, $\dim V_{(2,2)}$ returns $-2$ at $m=2$, and $F_u=\bigoplus F_\lambda\otimes\mathrm{Id}$ fails there too; the table's range is $n\ge7$ |

**Overall verdict: PROVEN, hypotheses corrected.** The three displayed identities are true and the proof of them is sound; the table passes both moment checks exactly and for the right reasons. Two of the block's surrounding statements are wrong (the third-moment justification and the table's applicability at $n=6$) and neither is load-bearing for the identities.

**One-line actionable summary.** Keep the theorem and the check, restrict the table to $n\ge7$, state closure of $\mathcal W_n$ under $B$ as the step it is, and replace "invariant cubic hence a multiple of $P(u)$" with the true reason, the invariant cubics on $\mathcal W_n$ form a **two**-dimensional space for $n\ge6$, so $\operatorname{tr}(F_u^3)$ is a combination of $\operatorname{tr}(u^3)$ and $\langle u,u^\#\rangle$ of which only the sum $P(u)$ is on file; §6 below exhibits a rational alternative spectrum passing both moment checks identically in $m$ and failing the third, which shows a third check would have real content if that second scalar were ever recorded.

## 0. Conventions, fixed once

Write $\mathfrak g=\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$, with $\{b_\alpha\}$ an orthonormal basis and structure constants $c_{\alpha\beta\gamma}=\langle[b_\alpha,b_\beta],b_\gamma\rangle$, **totally antisymmetric** in the three indices, that antisymmetry is the only property of $\mathfrak g$ any argument below uses. Operators $X$ on $\Lambda^2\mathbb R^n$ are written in that basis as $X_{\alpha\beta}$, and $\langle X,Y\rangle=\sum_{\alpha\beta}X_{\alpha\beta}Y_{\alpha\beta}$ is the Frobenius pairing, which for symmetric $X,Y$ is $\operatorname{tr}(XY)$.

The sharp product is taken in the form $(X\#Y)_{\alpha\beta}=\tfrac{\kappa}2\sum c_{\alpha\gamma\mu}c_{\beta\delta\nu}(X_{\gamma\delta}Y_{\mu\nu}+Y_{\gamma\delta}X_{\mu\nu})$, the "halved" convention being exactly the choice of $\kappa$ and of the outer $\tfrac12$ that makes $X\#X=X^\#$. The value of $\kappa$ is nowhere used below; the arguments are normalisation-free, and the one place the halving matters is flagged in §1.

Throughout, $B(X,Y)=\tfrac12(XY+YX)+X\#Y$, $F_u=B(u,\cdot)$, $Q(W)=B(W,W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $m=n-4$, and $\theta^*=P(u)=\sqrt{3/2}$ at the padded unit $u=W_{\mathbb{CP}^2}$. Block quantities are written $t_\lambda=\operatorname{tr}(F_\lambda)/\theta^*$, $q_\lambda=\operatorname{tr}(F_\lambda^2)/\theta^{*2}$, $r_\lambda=\operatorname{tr}(F_\lambda^3)/\theta^{*3}$, and $d_\lambda(m)=\dim V_\lambda$.

## Hypothesis inventory

| | hypothesis | where it enters | status on the page |
|---|---|---|---|
| H1 | $\#$ normalised so that $X\#X=X^\#$, i.e. $B(W,W)=Q(W)$ | C1, and only C1 | stated ("halved"), **the single point where a stray factor could enter** |
| H2 | one and the same Frobenius pairing in $P$, in $T$, in $\lVert T\rVert^2$ and in the traces | C1, C6 | implicit |
| H3 | $\mathcal W_n$ closed under $B$, or $F_u$ read as the compression $\pi_{\mathcal W}F_u|_{\mathcal W_n}$ | C4, C5, C6, without it $\operatorname{tr}(F_u)$ has no referent | **unstated**; true, §3 |
| H4 | $n\ge5$, for $SO(n)$-irreducibility and absolute irreducibility of $\mathcal W_n$ | C4, C5 | stated as $n\ge6$, which is safe |
| H5 | the Killing constant $\tfrac{(n-1)(2n-1)}4$ | C5, C6 | inherited from the record; **not re-derived here** |
| H6 | $\lVert u\rVert=1$ and $\theta^*=P(u)=\sqrt{3/2}$ | C9, the collapse consumes $\theta^{*2}=\tfrac32$ exactly | cited; **not verified here**, and the check tests the table and $\theta^*$ jointly |
| H7 | $m$-freeness of the six $F_\lambda$ | everything the check is supposed to license | **undischarged**, and the block says so |
| H8 | $m\ge3$, for the tabled rows to be a decomposition and for $F_u=\bigoplus F_\lambda\otimes\mathrm{Id}$ | C15 | **absent**, and false at $m=2$ |
| H9 | $u$ is $SO(m)$-fixed, so $F_u$ commutes with $SO(m)$ | the block form of $F_u$ | implicit, and correct |

## 1. The pairing identity, and why no constant can enter (attack 1)

The brief is right that this is the first thing to settle, and it settles cleanly and in a normalisation-free way.

**The sharp term.** Put $\Psi(A,B,C)=\sum c_{\alpha\gamma\mu}c_{\beta\delta\nu}A_{\alpha\beta}B_{\gamma\delta}C_{\mu\nu}$. Relabel the dummies $\alpha\leftrightarrow\gamma$, $\beta\leftrightarrow\delta$: each $c$ picks up one transposition, so the product of the two picks up $(-1)^2=+1$, and the expression becomes $\Psi(B,A,C)$. Relabelling $\gamma\leftrightarrow\mu$, $\delta\leftrightarrow\nu$ gives $\Psi(A,C,B)$ the same way. Those two transpositions generate $S_3$, so $\Psi$ is **totally symmetric**. Nothing was assumed about $A,B,C$, not symmetry as matrices, not Bianchi, not Ricci-flatness. Since $\langle X\#Y,Z\rangle=\kappa\,\Psi(Z,X,Y)$ for whatever $\kappa$ the record's normalisation carries, the sharp term's total symmetry is a property of the antisymmetry of $c$ alone and survives any restriction.

**The anticommutator term.** $\langle\tfrac12(XY+YX),Z\rangle=\tfrac12\operatorname{tr}(XYZ)+\tfrac12\operatorname{tr}(YXZ)$. Cyclicity puts the six orderings into two classes, $\{XYZ,YZX,ZXY\}$ and $\{YXZ,XZY,ZYX\}$, one representative from each appearing here; so the expression equals $\tfrac16\sum_{\sigma\in S_3}\operatorname{tr}(\sigma\cdot)$, the full symmetrisation. This is an identity on arbitrary square matrices. The brief's worry (whether the symmetry "survives on $\mathcal W_n$ rather than on all of $S^2(\Lambda^2)$"), has the direction of the risk backwards: the identity holds on the ambient algebra, so restricting to any subspace is free. What does *fail* on restriction is closure: $\tfrac12(XY+YX)$ alone need not satisfy first Bianchi for $X,Y\in\mathcal W_n$, and neither need $X\#Y$ alone. Only the sum does (§3), and only the sum is used.

**No constant.** $T$ is *defined* as the symmetric trilinear form with $T(W,W,W)=P(W)$, and over $\mathbb R$ that form is unique, polarisation recovers it from its restriction to the diagonal. The form $(X,Y,Z)\mapsto\langle B(X,Y),Z\rangle$ is symmetric by the two paragraphs above and restricts on the diagonal to $\langle B(W,W),W\rangle=\langle Q(W),W\rangle=P(W)$, the middle equality being **exactly H1**. So the two forms coincide and $\langle F_uh,k\rangle=T(u,h,k)$ with coefficient $1$. The only way a factor enters is if H1 is false, if the record's $\#$ is the unhalved polarisation, then $B(W,W)=2W^\#+W^2\ne Q(W)$, $T$ acquires a factor and $\lVert T\rVert^2$ acquires its square. That single convention is the whole exposure, and the block names it.

**Verdict C1, C2: PROVEN.**

## 2. The two Schur arguments, and the range each needs (attack 2)

**Equivariance is $O(n)$, not merely $SO(n)$.** For $g\in O(n)$, the action on $\Lambda^2\mathbb R^n$ is $\Lambda^2g$; conjugation by $g$ preserves $\mathfrak{so}(n)$ and its bracket for either sign of $\det g$, so $c$ is $O(n)$-invariant, and $\Lambda^2g$ is orthogonal for the Frobenius metric. Hence $B$ is $O(n)$-equivariant and $F_{gu}=\rho(g)F_u\rho(g)^{-1}$, so every $\operatorname{tr}(F_u^k)$ is $O(n)$-invariant. The block's use of $O(n)$ is therefore legitimate.

**Does the difference matter?** No, at every $n$ in scope, and this is worth saying because it is where the argument would fail if pushed down. $\mathcal W_n$ is the space of Weyl tensors, the $SO(n)$-module of highest weight $(2,2,0,\dots,0)$; since the partition $(2,2)$ has length $2$, it is a single irreducible $\mathfrak{so}(n,\mathbb C)$-module whenever $2<\lfloor n/2\rfloor$ or $n$ is odd, that is, for every $n\ge5$. Its complexification being irreducible is precisely absolute irreducibility, so $\operatorname{End}_{SO(n)}(\mathcal W_n)=\mathbb R$ and the invariant symmetric bilinear forms are one-dimensional. At $n=4$ both statements fail, $SO(4)$ splits $\mathcal W_4=W^+\oplus W^-$ and $O(4)$ makes it irreducible but not absolutely so, the commutant being two-dimensional, which is exactly why the $O(n)$/$SO(n)$ distinction is a live question and exactly why it is inert above $n=4$. **The range each argument needs is $n\ge5$; the stated $n\ge6$ is inside it with room to spare.**

**The linear functional.** $u\mapsto\operatorname{tr}(F_u)$ is linear (from bilinearity of $B$) and invariant, so it lies in $\operatorname{Hom}_{O(n)}(\mathcal W_n,\mathbb R)=0$, $\mathcal W_n$ being irreducible and not the trivial module ($\dim\mathcal W_n\ge84$ at $n\ge6$). Equivalently and more concretely: $\operatorname{tr}(F_u)=\sum_aT(u,u_a,u_a)=\langle u,\sum_aB(u_a,u_a)\rangle$, and $\sum_aB(u_a,u_a)$ is a basis-independent invariant vector of $\mathcal W_n$, hence $0$. **C4: PROVEN.**

**The quadratic form.** $u\mapsto\operatorname{tr}(F_u^2)$ is a quadratic form, invariant by the equivariance above, hence a multiple of $\lVert u\rVert^2$ by absolute irreducibility. The multiple is read off at unit $W$ from the inherited $\operatorname{tr}(L_W^2)=\tfrac{(n-1)(2n-1)}4$. **C5: PROVEN, conditional on H5**, which this brief supplies as already passed and which I did not re-derive. As an independent corroboration of the shape of the argument rather than of the constant, the character screen of §7 returns exactly one invariant quadratic on $\mathcal W_n$ at $n=5,6,7,8,9$.

## 3. Closure, the step the block does not take (attack 1, continued)

$\operatorname{tr}(F_u)$ and $\operatorname{tr}(F_u^2)$ presuppose that $F_u$ is an endomorphism *of $\mathcal W_n$*. The block asserts $F_u(h)=B(u,h)$ with no projection and no remark. The step is true, and it is not free.

First Bianchi is preserved by $Q$, this is the standard fact underlying the Hamilton–Böhm–Wilking ODE, that $Q$ maps algebraic curvature operators to algebraic curvature operators. Ricci-flatness is preserved as well, and for a reason that can be stated in one line: in the reaction ODE $\partial_tR=Q(R)$ the induced motion of the Ricci tensor is $\partial_t\operatorname{Ric}_{ik}=2R_{ipkq}\operatorname{Ric}_{pq}-2\operatorname{Ric}_{ip}\operatorname{Ric}_{pk}$, **every term of which carries a factor of $\operatorname{Ric}$**; so $\operatorname{Ric}(R)=0$ forces $\operatorname{Ric}(Q(R))=0$. Hence $Q(\mathcal W_n)\subseteq\mathcal W_n$, and polarising inside the linear subspace $\mathcal W_n$ gives $B(\mathcal W_n,\mathcal W_n)\subseteq\mathcal W_n$. So $(\mathcal W_n,B,\langle\cdot,\cdot\rangle)$ is a commutative metrised algebra and $F_u$ is a genuine self-adjoint endomorphism of it, self-adjointness being $T$'s symmetry in its last two slots.

**Arguing the opposite**, as the brief requires: had closure failed, nothing above would break, because $\langle B(u,h),k\rangle=T(u,h,k)$ holds for $h,k\in\mathcal W_n$ whatever $B(u,h)$ does, and every trace statement would then be a statement about the compression $\pi_{\mathcal W}F_u|_{\mathcal W_n}$, still self-adjoint, still with the same matrix entries, so §4's summation and the two moments would be untouched. Closure is therefore a presentational debt rather than a risk, but it is a debt: as written, the symbol $\operatorname{tr}(F_u)$ has no referent until it is paid. **C3: PROVEN; recommend one sentence on the page.**

## 4. The summation step (attack 3)

Fix an orthonormal basis $\{u_a\}$ of $\mathcal W_n$. For each $a$, $F_{u_a}$ is self-adjoint, so
$$\operatorname{tr}(F_{u_a}^2)=\sum_b\langle F_{u_a}^2u_b,u_b\rangle=\sum_b\lVert F_{u_a}u_b\rVert^2=\sum_{b,c}\langle F_{u_a}u_b,u_c\rangle^2=\sum_{b,c}T(u_a,u_b,u_c)^2,$$
the third equality being Parseval in the same basis, which is legitimate because $F_{u_a}u_b\in\mathcal W_n$ by §3. Summing over $a$ gives $\sum_a\operatorname{tr}(F_{u_a}^2)=\sum_{a,b,c}T(u_a,u_b,u_c)^2=\lVert T\rVert^2$ by the brief's own definition, while the right-hand side is $\sum_a\tfrac{(n-1)(2n-1)}4\lVert u_a\rVert^2=\tfrac{(n-1)(2n-1)}4\dim\mathcal W_n$ since each $\lVert u_a\rVert=1$. The index bookkeeping is clean: one basis, used for the trace, for the Parseval expansion and for $\lVert T\rVert^2$, and $\lVert T\rVert^2$ is in any case basis-independent, being the Frobenius norm of a tensor under an orthogonal change of frame. **C6: PROVEN.**

## 5. The four block traces and the collapse (attacks 4, 5)

Read as multiplicities as well as values, as the brief asks.

| $\lambda$ | multiplicities sum | $\dim M_\lambda$ | $t_\lambda$ | $q_\lambda$ | $r_\lambda$ |
|---|---|---|---|---|---|
| trivial | $2+6+6+3+2+1=20$ | $20$ ✓ | $-2-1+0+1+1+1=0$ | $2+\tfrac16+\tfrac13+\tfrac12+1=4$ | $-\tfrac23$ |
| vector | $4+12+4=20$ | $20$ ✓ | $-2+0+2=0$ | $1+0+1=2$ | $0$ |
| $\Lambda^2$ | $2+3+1=6$ | $6$ ✓ | $-\tfrac13+0+\tfrac13=0$ | $\tfrac1{18}+\tfrac19=\tfrac16$ | $\tfrac1{36}$ |
| $S^2_0$ | $6+1+3=10$ | $10$ ✓ | $-1+0+1=0$ | $\tfrac16+\tfrac13=\tfrac12$ | $\tfrac1{12}$ |
| $V_{(2,1)}$ | $4$ | $4$ ✓ | $0$ | $0$ | $0$ |
| $V_{(2,2)}$ | $1$ | $1$ ✓ | $0$ | $0$ | $0$ |

All six multiplicity counts are right, all four traces are $4,2,\tfrac16,\tfrac12$ as claimed, and all six blockwise first moments vanish exactly as the block displays them ($-2-1+1+1+1$, $-2+2$, $-\tfrac13+\tfrac13$, $-1+1$). No transcription error is present.

**A dimension check the block does not run, and passes.** $\sum_\lambda\dim M_\lambda\,d_\lambda(m)=20+20m+3m(m-1)+5(m+2)(m-1)+\tfrac43m(m^2-4)+\tfrac1{12}m(m+1)(m+2)(m-3)$ collapses to $\tfrac1{12}(m^4+16m^3+89m^2+194m+120)=\tfrac1{12}(m+1)(m+4)(m+5)(m+6)=\dim\mathcal W_{m+4}$, identically in $m$. This is a much stronger constraint on the table's twelve dimension entries than either moment, and it holds. It is the check I would run first against transcription, and I recommend it be recorded.

**The collapse.** $\operatorname{tr}(F_u^2)/\theta^{*2}=\sum_\lambda d_\lambda q_\lambda=4+2m+\tfrac{m(m-1)}{12}+\tfrac{(m+2)(m-1)}4$. Over $12$: $\tfrac{48+24m+(m^2-m)+3(m^2+m-2)}{12}=\tfrac{4m^2+26m+42}{12}=\tfrac{2m^2+13m+21}6=\tfrac{(2m+7)(m+3)}6$. With $m=n-4$: $2m+7=2n-1$, $m+3=n-1$, giving $\tfrac{(2n-1)(n-1)}6$; times $\theta^{*2}=\tfrac32$ this is $\tfrac{(n-1)(2n-1)}4$. At $n=12$, $m=8$: $4+16+\tfrac{56}{12}+\tfrac{70}4=\tfrac{120+28+105}6=\tfrac{253}6$, and $\tfrac32\cdot\tfrac{253}6=\tfrac{253}4$. **C7, C8, C9, C10: CONFIRMED**, each recomputed by hand and then screened exactly in rational arithmetic.

## 6. What the check licenses, and a rational spectrum that passes it and is not the table (attacks 6, 7)

This is where I part company with the block's assessment, in both directions at once.

**Read identically in $m$, the two identities are ten scalar conditions, not two.** The weights $d_\lambda(m)$ have degrees $0,1,2,2,3,4$; matching coefficients of $m^0,\dots,m^4$ turns each identity into five equations. So the block's "two scalars" is the count at one fixed $n$, and the $m$-identical reading it invokes elsewhere is five times stronger per identity.

**Those ten conditions do pin five of the sixty-one eigenvalues, exactly.** Take the second identity, $\sum_\lambda d_\lambda q_\lambda=\tfrac{2m^2+13m+21}6$. Only $d_{(2,2)}$ carries $m^4$, and it carries no $m^3$; only $d_{(2,1)}$ carries $m^3$. So the top two coefficients read $q_{(2,2)}/12=0$ and $q_{(2,1)}/3=0$, forcing $q_{(2,1)}=q_{(2,2)}=0$. Each $F_\lambda$ is self-adjoint, so a vanishing sum of squares of eigenvalues forces the block itself to vanish: **$F_{(2,1)}=0$ and $F_{(2,2)}=0$ are consequences of the second moment alone**, given only $m$-freeness. That is five of the sixty-one entries determined, not merely constrained, and the block does not claim it.

**On the remaining fifty-six, the two identities collapse to six conditions.** The six weights $d_\lambda$ are six polynomials of degree $\le4$, so they span at most a five-dimensional space; their coefficient matrix has rank exactly $5$ with one-dimensional kernel spanned by
$$(1,-1,-1,1,0,0),\qquad\text{i.e.}\qquad 1-m-\tfrac{m(m-1)}2+\tfrac{(m+2)(m-1)}2=0 .$$
So the first identity forces $t_{(2,1)}=t_{(2,2)}=0$ and confines $(t_{\text{triv}},t_{\text{vec}},t_{\Lambda^2},t_{S^2_0})$ to the **line** $\mathbb R\cdot(1,-1,-1,1)$ (three conditions) and the second confines $(q_{\text{triv}},q_{\text{vec}},q_{\Lambda^2},q_{S^2_0})$ to the affine line $(4,2,\tfrac16,\tfrac12)+t(1,-1,-1,1)$, another three, with $q_\lambda\ge0$ cutting $t$ to $[-\tfrac12,\tfrac16]$. Six conditions on fifty-six unknowns.

**So: "more than the identity demands" is right (C11).** The identity does not force blockwise tracelessness; it permits the whole line $t\cdot(1,-1,-1,1,0,0)$, and the table sits at the origin of it. Nothing in the brief, and nothing I can derive from what is on it, forces each block separately traceless, the isotypic decomposition is defined only at this particular $u$, so the invariance argument of §2 has no purchase blockwise. **This claim has no argument on file, and it does not need one: it is offered as an observation about slack, and as such it is correct.**

**And "two scalars not pinning 56 eigenvalues" reaches the right conclusion from an understated premise (C12).** The correct statement is: *given $m$-freeness, the two identities determine the last two blocks outright and impose six independent scalar conditions on the remaining 56 eigenvalues.* Still nowhere near a determination, so the block's conclusion stands unchanged.

**The concrete test the brief asks for.** Here is an alternative spectrum, rational, exhibited in closed form, with the tabled $\dim M_\lambda$ and the tabled blockwise vanishing of every first moment, satisfying **both** identities identically in $m$:

| $\lambda$ | $\dim M_\lambda$ | alternative $\operatorname{spec}(F_\lambda)/\theta^*$ | $t_\lambda$ | $q_\lambda$ |
|---|---|---|---|---|
| trivial | $20$ | $-\tfrac32,\ \tfrac12,\ 1,\ 0^{\times17}$ | $0$ | $\tfrac72$ |
| vector | $20$ | $-1,\ -\tfrac12,\ \tfrac12,\ 1,\ 0^{\times16}$ | $0$ | $\tfrac52$ |
| $\Lambda^2$ | $6$ | $-\tfrac13^{\times2},\ \tfrac23,\ 0^{\times3}$ | $0$ | $\tfrac23$ |
| $S^2_0$ | $10$ | $0^{\times10}$ | $0$ | $0$ |
| $V_{(2,1)},V_{(2,2)}$ | $4,\,1$ | $0$ throughout | $0$ | $0$ |

Its second moment is $\tfrac72+\tfrac52m+\tfrac{m(m-1)}2\cdot\tfrac23=\tfrac{21+15m+2m^2-2m}6=\tfrac{2m^2+13m+21}6$, identical to the tabled one as a polynomial in $m$; its $q$-vector is the tabled one displaced by $-\tfrac12(1,-1,-1,1)$, the kernel direction, which is why. It is stronger than the $m$-dependent perturbation the brief asked for, being $m$-free itself, so it survives even after H7 is granted. And it keeps the one structural feature the table has beyond the moments, a top eigenvalue $\theta^*$ in the trivial block, which the Rayleigh identity $\langle F_uu,u\rangle=P(u)=\theta^*$ at the unit vector $u$ demands of any admissible spectrum.

Its **third** moment is $-\tfrac94+\tfrac{m(m-1)}9$, against the table's $\tfrac{m^2}{18}+\tfrac m{36}-\tfrac34$, different at every $m$. So the third moment is exactly the invariant that would separate the two, which is the point of §7.

*(Screen: the two spectra's three weighted moments were recomputed in exact rational arithmetic on objects constructed for this section; the hand derivations above are the argument, and the screen agreed with each of them.)*

## 7. The third-moment claim (attack 8)

**The arithmetic is right (C14).** $r_{\text{triv}}=-2-\tfrac1{36}+\tfrac19+\tfrac14+1=-\tfrac23$, $r_{\text{vec}}=0$, $r_{\Lambda^2}=-\tfrac1{108}+\tfrac1{27}=\tfrac1{36}$, $r_{S^2_0}=-\tfrac1{36}+\tfrac19=\tfrac1{12}$. Weighting,
$$\frac{\operatorname{tr}(F_u^3)}{\theta^{*3}}=-\tfrac23+\tfrac{m^2-m}{72}+\tfrac{m^2+m-2}{24}=\frac{4m^2+2m-54}{72}=\frac{2m^2+m-27}{36},$$
and $m=n-4$ gives $2(n-4)^2+(n-4)-27=2n^2-15n+1$. The displayed $\tfrac{2n^2-15n+1}{36}$ is correct.

**The reason attached to it is not (C13).** Two things are wrong with "an invariant cubic, hence a multiple of $P(u)$".

*First, the inference is a non-sequitur independently of the answer.* For the quadratic, absolute irreducibility is a theorem about $\operatorname{End}_G(V)$ and delivers a one-dimensional space of invariant quadratic forms. There is no analogous theorem for cubics: $\dim(S^3V^*)^G$ is unrelated to $\operatorname{End}_G(V)=\mathbb R$, and irreducibility bounds it neither above nor below. So the word "hence" is unsupported whatever the true dimension turns out to be. **On the brief's own rule this claim has no argument on file.**

*Second, the dimension is two, not one, at every $n$ in scope.* Two manifestly $O(n)$-invariant cubics exist on $\mathcal W_n$, $\operatorname{tr}(u^3)$, the operator cube on $\Lambda^2$, and $\Psi(u,u,u)=\langle u,u^\#\rangle$, and $P(u)$ is their sum. **Screen** (exact Weyl-character computation, seconds, on characters I constructed for the purpose; reported as a screen and offered only against the block's positive claim, never for one): the multiplicity of the trivial module in $S^3\mathcal W_n$ is

| $\mathfrak g$ | $n=5$ | $n=6$ | $n=7$ | $n=8$ | $n=9$ |
|---|---|---|---|---|---|
| $\dim\mathcal W_n$ | $35$ | $84$ | $168$ | $300$ | $495$ |
| invariant quadratics | $1$ | $1$ | $1$ | $1$ | $1$ |
| invariant cubics | $1$ | $\mathbf2$ | $\mathbf2$ | $\mathbf2$ | $\mathbf2$ |

The dimensions in the first row reproduce $\tfrac{n(n+1)(n+2)(n-3)}{12}$ at all five values, which is the check on the computation. At $n=7$ and $n=9$ the count is unambiguous for $O(n)$, since for odd $n$ one has $O(n)=SO(n)\times\{\pm I\}$ with $-I$ acting trivially on a degree-four tensor; at even $n$ the tabulated figure is the $SO(n)$ count and bounds the $O(n)$ count above.

The degeneracy at $n=5$ is the likely source of the error, and it is visible by hand one dimension lower. On $\mathcal W_4=W^+\oplus W^-$ write $u=\operatorname{diag}(A,B)$ with $A,B$ traceless symmetric $3\times3$. Then $\operatorname{tr}(u^3)=\operatorname{tr}A^3+\operatorname{tr}B^3$, while $u^\#$ is the adjugate on each $\mathfrak{su}(2)$ factor and $\langle u,u^\#\rangle\propto\det A+\det B$; Cayley–Hamilton gives $\operatorname{tr}A^3=3\det A$ for traceless $A$, so the two invariants are proportional and $P(u)=3\operatorname{tr}(u^3)$. **In low dimension the space really is one-dimensional; from $n=6$ it is not.**

**What survives.** The block's conclusion, that nothing fixes the constant independently, so the value defines it rather than testing the table, is not merely intact but strengthened: with a two-dimensional space of cubics, pinning $\operatorname{tr}(F_u^3)$ requires *two* scalars at the $\mathbb{CP}^2$ point, of which the record carries only their sum $P(u)=\theta^*$. And §6 shows the stake is real: an admissible alternative spectrum agreeing on both moments disagrees on the third at every $m$, so recording $\operatorname{tr}(u^3)$ and $\langle u,u^\#\rangle$ separately at $u=W_{\mathbb{CP}^2}$ would convert the third moment from a definition into a genuine test.

## 8. Edges (attack 9)

**$u=0$.** $F_0=0$; both identities read $0=0$. The Schur arguments are statements about forms, unaffected. No issue.

**Odd $n$.** Nothing in §§1–4 sees the parity of $n$: the antisymmetry of $c$, the cyclicity of the trace, the irreducibility of $(2,2,0,\dots)$ for $n\ge5$ and Parseval are all parity-blind, and the inherited constant is quoted for both parities. The table's variable is $m=n-4$ and runs over both parities equally. No issue.

**$n=6$, i.e. $m=2$, and here the table fails, twice.** Evaluating the tabled $\dim V_\lambda$ at $m=2$ gives $1,\ 2,\ 1,\ 2,\ 0,\ -2$. The last entry is **negative**: $\tfrac{m(m+1)(m+2)(m-3)}{12}$ at $m=2$ is $-2$, so the row is not a multiplicity of anything, and the total $20+40+6+20+0-2=84$ reaches $\dim\mathcal W_6$ only through that cancellation. Separately, $\Lambda^2\mathbb R^2$ is the *trivial* $SO(2)$-module, so that row does not name a distinct isotypic component at all and merges with the first. And thirdly, the two-dimensional $SO(2)$-modules are not absolutely irreducible ($\operatorname{End}_{SO(2)}$ is $\mathbb C$) so the form $F_u=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}$, which is Schur's lemma in disguise, is not available at $m=2$ either. **The table is a decomposition only for $m\ge3$, i.e. $n\ge7$.**

The damage is contained, and it is worth saying why. The rows that misbehave at $m=2$ are exactly the rows whose spectra are identically zero, and traces are additive whether or not rows merge, so the numeric check still comes out right: at $m=2$, $4+4+\tfrac16+1=\tfrac{55}6=\tfrac{(2\cdot6-1)(6-1)}6$. And the theorem at $n=6$ rests on §2, not on the table. So the correct repair is a scope line on the table, not a retraction. **C15: REFUTED as stated, with the fix being "$n\ge7$".**

**$m=3$, i.e. $n=7$.** All entries are non-negative ($1,3,3,5,5,0$), the $V_{(2,2)}$ row vanishing cleanly rather than going negative, and the total $20+60+18+50+20+0=168=\dim\mathcal W_7$. Sound.

**$m=1$ and below** ($n\le5$) are outside the stated range and are degenerate in the same way ($d_{(2,1)}=d_{(2,2)}=-1$); no claim is made there.

## 9. What would break it (attack 10)

1. **The $\#$ normalisation.** If the record's $\#$ is not halved, $B(W,W)=W^2+2W^\#\ne Q(W)$, $T$ picks up a factor and $\lVert T\rVert^2$ its square, and the second-moment check fails by that square. §1 shows this is the *only* channel by which a constant can enter, so it is the one convention to verify against the record's own definition.
2. **The inherited Killing constant** $\tfrac{(n-1)(2n-1)}4$ (H5). It is quoted, not re-derived here; the whole of C5, C6 and the table check ride on it, and the check would fail by the same factor it were wrong by.
3. **$\theta^*\ne\sqrt{3/2}$** (H6). The collapse consumes $\theta^{*2}=\tfrac32$ exactly at the last step, so the check tests the pair (table, $\theta^*$) jointly and cannot separate an error in one from an error in the other.
4. **A transcription error preserving the two moments.** §6 exhibits one explicitly and shows they form a six-codimensional family within a 56-dimensional space of spectra; the check is structurally incapable of detecting such an error, and the dimension identity $\sum\dim M_\lambda\dim V_\lambda=\dim\mathcal W_n$ of §5 is a far sharper transcription guard.
5. **$m$-freeness** (H7). Without it the ten conditions of §6 fall back to two per value of $n$ and even the vanishing of the last two blocks is not forced.
6. **The $n=6$ instance of the table** (§8), which is the one place where a stated claim is literally false rather than merely unargued.
7. **Non-closure of $\mathcal W_n$ under $B$** would leave $\operatorname{tr}(F_u)$ undefined; §3 shows it does not hold as a risk, but the page should say so.

## 10. Answers to every attack item, including where nothing was found

1. **Pairing identity.** Derived from scratch; $\langle X\#Y,Z\rangle$ is totally symmetric from the total antisymmetry of $c$ alone, the anticommutator term from cyclicity, and no constant can enter given the halved convention. **Nothing wrong.** §1.
2. **The Schur arguments.** $\mathcal W_n$ is $SO(n)$-irreducible and absolutely irreducible for every $n\ge5$; $B$ is $O(n)$-equivariant, and the $O(n)$/$SO(n)$ distinction is inert above $n=4$, where it would matter. **Nothing wrong**; the needed range is $n\ge5$, stated as $n\ge6$. §2.
3. **Summation.** Index bookkeeping correct, one basis throughout, $\lVert T\rVert^2$ basis-independent. **Nothing wrong.** §4.
4. **Block traces.** All four values and all six multiplicity counts verified; a dimension identity the block does not run also passes. **No transcription error.** §5.
5. **The collapse.** Verified symbolically and at $n=12$ against $\tfrac{253}4$. **Nothing wrong.** §5.
6. **What the check licenses.** The assessment understates the premise (ten conditions, not two; five eigenvalues pinned outright) and is right in conclusion; a rational $m$-free alternative spectrum passing both checks is exhibited. §6.
7. **Blockwise first moment.** "More than the identity demands" is correct and now made precise, the identity permits a one-parameter line of trace vectors, and nothing on the brief forces the origin. §6.
8. **Third moment.** The value $\tfrac{2n^2-15n+1}{36}$ is confirmed; the justification is **refuted**, both as an inference and on the dimension count. §7.
9. **Hypothesis inventory and edges.** Nine hypotheses tabulated, three of them unstated on the page; $u=0$, odd $n$ and $m=3$ are clean; $m=2$ breaks the table three ways. §8, inventory above.
10. **What would break it.** Seven channels, ranked. §9.
