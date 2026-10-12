# Review r866: the $n=5$ rank count, the two-projection removal, and the pentagon

*Reviewer r866. The brief was cold: I read the cold brief at [scratchpad/brief-r866-r867.md](../../../../../private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/brief-r866-r867.md), absolute path /private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/brief-r866-r867.md, and nothing else of the record, and every derivation below is my own rather than a check of the block's. No numerical work of any kind was done: the programme is on an analysis-only footing, the screening allowance was not needed, and every value in this report is exact and obtained by hand. Log: [agent_logs/review-r866-rankcount.log](../agent_logs/review-r866-rankcount.log).*

## Claim table

| # | Claim under audit | Verdict |
| --- | --- | --- |
| 1 | Eigenvalues of $c\,\mathrm{Id}-\Pi_1$ are $c-1$ twice and $c$ with multiplicity $n-2$ | CONFIRMED |
| 2 | Positive semidefiniteness of $\sum_{\alpha\ne1}\Pi_\alpha$ forces $c\ge1$ | CONFIRMED, DERIVATION REDUNDANT |
| 2b | The parenthetical "which is the rank bound $2a\ge n$ again", citing given 17 | MISLABELLED, INEQUALITY CORRECT |
| 3 | $c>1$ forces $a\ge n/2+1$, and the admissible sizes are $a=n/2$ or $a\ge n/2+1$ | CONFIRMED |
| 4 | The complement obeys the same bound at constant $2(N-a)/n=n-1-c$ | CONFIRMED, ONE UNSTATED HYPOTHESIS |
| 5 | At $n=5$ the enumeration is $a\in\{4,5,6\}$, with $a=3$ and $a=7$ excluded | CONFIRMED |
| 6 | $a\leftrightarrow N-a$ is the same case, by $E\leftrightarrow E^\perp$ and $W\mapsto-W$ | CONFIRMED, AND $\theta\mapsto-\theta$ |
| 7 | The explicit $a=3$ contradiction, and the pairwise trace $1/5$ | CONFIRMED, AND STRONGER THAN CLAIMED |
| 8 | $\Pi_1+\Pi_2$ has eigenvalues $1\pm c,1,1,0$ in $\mathbb R^5$ at one right principal angle | CONFIRMED |
| 9 | The $a=4$ chain: spectrum, trace $4$, $c\le\tfrac35$, forced zero, $c=\tfrac35$, row sum $\tfrac{27}{25}$ against $\tfrac{30}{25}$ | CONFIRMED, PLUS AN INDEPENDENT SECOND CONTRADICTION |
| 10 | Every pair inside $A$ is forced to the same $S_{\alpha\beta}=\tfrac9{25}$ | CONFIRMED, PAIR BY PAIR |
| 11 | $C_5$ is $\mathrm{SRG}(5,2,0,1)$, self-complementary, and $\pm1$ on the two $5$-cycles is a Ricci-flat two-eigenvalue critical point | CONFIRMED, AND ITS $\theta$ IS $0$ EXACTLY, UNSTATED |
| 11b | "strongly regular, SO it is a critical point": the implication as stated | CONFIRMED AS A GENERAL THEOREM, PROOF SUPPLIED |
| 12 | "At $n=5$ the only isotropic decomposable subspaces have $a=5$" as worded | OVERSTATED, HYPOTHESIS ON $E^\perp$ OMITTED |
| 12b | Nothing vacuous, and $a=5$ left open for non-coordinate configurations | CONFIRMED |
| all | Both arguments together empty every falsifier candidate at $n=5$ in the two-eigenvalue decomposable frame | SUSTAINED |
| new | Handover: the same count kills $a=n/2+1$ at every $n\ge4$, so admissible is $a=n/2$ or $a\ge n/2+2$ | NEW, DERIVED HERE |

## Summary in one line

Both arguments are correct and I reproduce each independently, one of them by a second route the block does not use. The defects are three of wording, the omission that the pentagon's $\theta$ is exactly $0$, and a headline that drops the hypothesis on $E^\perp$ under which $a=7$ is excluded.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector. The inner product is $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$. At orthonormal $u,v$ this is a unit bivector and $(u\wedge v)(u\wedge v)^{\mathsf T}=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_P$, the orthogonal projection onto $P=\mathrm{span}\{u,v\}$. **This holds for exactly this normalisation**: the $1/\sqrt2$ convention returns $\tfrac12\Pi_P$.
- $\omega$ is **decomposable** when $\omega=u\wedge v$, equivalently $\omega\wedge\omega=0$. The record's wedge is TWICE the Pfaffian.
- $\mathcal W_n$ is the space of algebraic Weyl tensors: symmetric operators on $\Lambda^2\mathbb R^n$, first Bianchi, Ricci-flat, trace-free. $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.
- $\sqrt{3/2}=1.224745$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.

Two pieces of notation are mine, introduced because the block reuses one letter for two quantities. I write $\kappa=2a/n$ for the isotropy constant and keep $c=\cos\vartheta_1=\sqrt{S_{\alpha\beta}}$ for the cosine of the non-right principal angle. In the block's $a=4$ paragraph the single letter $c$ carries both meanings inside four lines, first as $8/5$ and then as the quantity bounded by $3/5$. Nothing is wrong underneath, and the collision is worth removing before the paragraph is copied into the record.

## Hypothesis inventory

What the two arguments actually consume, in the order they consume it.

1. **$E\subseteq\Lambda^2\mathbb R^n$ has an orthonormal basis $\{\omega_\alpha\}_{\alpha\in A}$ of decomposable forms**, $a=\lvert A\rvert$. Used to write $\omega_\alpha\omega_\alpha^{\mathsf T}=\Pi_\alpha$, a rank-two orthogonal projection.
2. **Isotropy $\Theta(E)=\sum_{\alpha\in A}\Pi_\alpha=\kappa\,\mathrm{Id}$ at $\kappa=2a/n$**, granted as given 14, which is the two-eigenvalue Ricci-flatness on the decomposable locus. Given 14 is stated at eigenvalues $\mu>0>\nu$ with no kernel, and it needs that: with a kernel, given 2 yields only $\mu\Theta(E_+)+\nu\Theta(E_-)=0$, and given 15 then relates $\Theta(E_+)+\Theta(E_-)$ to $(n-1)\mathrm{Id}-\Theta(\ker)$, which is not isotropy of either summand. So both arguments are conditioned on exactly two nonzero eigenvalues.
3. **One principal angle between any two of the planes is right**, from given 15, itself equivalent to $\Lambda^2$-orthogonality of decomposable forms. Used in items 7, 8, 9, 10.
4. **The row sum $\sum_{\beta\in A}S_{\alpha\beta}=4a/n$ with $S_{\alpha\alpha}=2$**, given 14 again, read as the trace of $\Pi_\alpha\Theta(E)$.
5. **$E^\perp$ also carries an orthonormal decomposable basis, and $E^\perp\ne0$.** Consumed silently by the complement half of the argument, and by the $n=5$ upper bound $a\le6$. It is automatic in the falsifier frame, where the whole of $\Lambda^2\mathbb R^n$ has a decomposable orthonormal eigenbasis, and it is not automatic in the bare statement about isotropic subspaces. See section 12.
6. **Divisibility $n\mid2a$ is necessary for coordinate-spannedness**, given 16, used only to say which surviving $a$ could be a known configuration.

## 1. The eigenvalues of $\kappa\,\mathrm{Id}-\Pi_1$

$\Pi_1$ is the orthogonal projection onto a $2$-plane of $\mathbb R^n$, so it is symmetric idempotent of trace $2$ and its spectrum is $1,1,0^{n-2}$. Subtracting from $\kappa\,\mathrm{Id}$ acts on each eigenvalue, giving $\kappa-1$ with multiplicity $2$ and $\kappa$ with multiplicity $n-2$. The block's "$c-1$ twice and $c$ elsewhere" is this, and "elsewhere" is $n-2$ slots. CONFIRMED. The rank-two-ness of $\Pi_1$ is where decomposability enters, and it enters correctly: a unit decomposable $\omega=u\wedge v$ has orthonormal $u,v$ under this normalisation, so its plane is genuinely two-dimensional and never degenerates.

## 2. The positivity step

$\sum_{\alpha\ne1}\Pi_\alpha$ is a sum of positive semidefinite matrices and so is positive semidefinite. Its spectrum is the list of item 1, so $\kappa-1\ge0$, that is $2a\ge n$. CONFIRMED as an inequality.

Two remarks on the derivation rather than the conclusion.

- **The removal is not needed for $c\ge1$.** $\Theta(E)=\kappa\,\mathrm{Id}$ with $\kappa=2a/n>0$ has rank $n$, while a sum of $a$ rank-two matrices has rank at most $2a$, so $n\le2a$ directly. The block's route is sound and longer. That matters only for exposition, and the record should state the one-line version because the removal step's real work is the strict inequality of item 3.
- **The case split is correct.** Since $\kappa\ge1$ is now known, the only alternative to $\kappa>1$ is $\kappa=1$ exactly, that is $a=n/2$ with $n$ even. At $\kappa=1$ the identity reads $\sum_{\alpha\ne1}\Pi_\alpha=\mathrm{Id}-\Pi_1$, whose rank is $n-2$, exactly the ceiling $2(a-1)=n-2$ that item 3 will impose. So $\kappa=1$ is consistent and survives, with the rank inequality tight. No contradiction hides there.

**Item 2b.** The parenthetical "which is the rank bound $2a\ge n$ again" points at given 17, the statement that the Gram matrix has rank at least $n$ at an orthonormal decomposable basis. Given 17 is a statement about a full basis, $a=N$, and its content is $\operatorname{rank}S\ge n$ rather than $2a\ge n$. For a proper subset $A$, $\operatorname{rank}S$ is $\dim\operatorname{span}\{\Pi_\alpha\}_{\alpha\in A}$ and nothing in the givens bounds it below by $n$. The inequality $2a\ge n$ is true and just derived, so the slip is one of attribution. Recommend striking "again" or naming the trace-and-rank argument instead.

## 3. The rank step, and the admissible sizes

$\sum_{\alpha\ne1}\Pi_\alpha$ is a sum of $a-1$ matrices of rank $2$, so its rank is at most $2(a-1)$. If $\kappa>1$ then every eigenvalue in item 1's list is strictly positive, so the same matrix has rank exactly $n$. Hence $n\le2(a-1)$, that is $a\ge n/2+1$. CONFIRMED.

The two-case conclusion is then exactly right, and it is sharper than integrality for odd $n$, which is the point at $n=5$. Since $\kappa\ge1$, either $\kappa=1$, which needs $n$ even and gives $a=n/2$, or $\kappa>1$ and $a\ge n/2+1$. The band $n/2<a<n/2+1$ is empty of integers when $n$ is even and contains exactly $a=(n+1)/2$ when $n$ is odd, and that value is what the argument removes. At $n=5$: $a=3$ is $(n+1)/2$ and is excluded, because $\kappa=6/5>1$ forces $a\ge3.5$.

**One generalisation, and why it earns nothing.** Removing $m$ projections gives $\kappa\,\mathrm{Id}-\sum_{i\le m}\Pi_i$ of rank at most $2(a-m)$, and a sum of $m$ projections has spectral radius at most $m$, so $\kappa>m$ forces $n\le2(a-m)$, that is $a\ge n/2+m$. This is vacuous for every $m\ge2$ once $n\ge4$: the hypothesis $2a/n>m$ already says $a>nm/2$, and $nm/2\ge n/2+m$ whenever $n(m-1)\ge2m$. So the crude count cannot be pushed by removing more projections, and the block's second argument is right to proceed instead by locating the spectrum exactly at fixed $a$. That is a real distinction between the two blocks and it should be said out loud, because a reader who thinks the second block is "the same count with $m=2$" will think it follows from the first.

## 4. The complement

Given 15 supplies $\Theta(E)+\Theta(E^\perp)=(n-1)\mathrm{Id}$, so $\Theta(E^\perp)=(n-1-\kappa)\mathrm{Id}$, and
$$n-1-\frac{2a}n=\frac{n(n-1)-2a}n=\frac{2\binom n2-2a}n=\frac{2(N-a)}n,$$
which is the isotropy constant for a subspace of dimension $N-a$. CONSTANT CORRECT.

The bound transfers on one condition, hypothesis 5 of the inventory: $E^\perp$ must itself carry an orthonormal basis of decomposable forms, since items 1 to 3 use nothing else. In the falsifier frame it does, because the two-eigenvalue tensor's eigenbasis is decomposable and $E^\perp$ is spanned by the part of it outside $A$. It also needs $E^\perp\ne0$, which at $a=N$ fails. That case is separately dead because $\Theta(\Lambda^2\mathbb R^n)=(n-1)\mathrm{Id}$ leaves $W$ a multiple of the identity, which trace-freeness kills. Both conditions hold where the argument is used, and neither is stated. CONFIRMED WITH ONE UNSTATED HYPOTHESIS.

## 5. The $n=5$ enumeration

$N=\binom52=10$. From item 3 with $n$ odd, $a\ge n/2+1=3.5$, so $a\ge4$. From item 4 applied to $E^\perp$, $10-a\ge4$, so $a\le6$. Hence $a\in\{4,5,6\}$. CONFIRMED. $a=3$ is excluded by item 3, and $a=7$ by item 4 because its complement has dimension $3<4$. Both exclusions are as the block says. The constants check: $a=4$ gives $\kappa=8/5$ and complement $12/5$, $a=5$ gives $2$ and $2$, $a=6$ gives $12/5$ and $8/5$, all exceeding $1$ as item 3 requires.

Divisibility: $5\mid2a$ holds among $\{4,5,6\}$ only at $a=5$, so $a=4$ and $a=6$ cannot be coordinate-spanned and would be new objects if they existed. CONFIRMED.

## 6. The swap $a\leftrightarrow N-a$

The pair $(E,E^\perp)$ is one object read twice, so an isotropic decomposable $E$ of dimension $4$ with decomposable complement exists if and only if one of dimension $6$ does. The existence questions at $a=4$ and $a=6$ are therefore literally the same question, and emptiness at one is emptiness at the other. CONFIRMED.

What $W\mapsto-W$ does, checked term by term. Symmetry, first Bianchi and Ricci-flatness are all linear conditions and survive negation, trace-freeness likewise, so $-W\in\mathcal W_n$. The eigenspaces are unchanged as subspaces and the eigenbasis is unchanged as a basis, so the decomposable locus is preserved and the positive eigenspace becomes the old negative one. $W^2$ is unchanged and $W^\#$ is quadratic in $W$, hence also unchanged, so $Q(-W)=Q(W)=\theta W=(-\theta)(-W)$: criticality is preserved with $\theta\mapsto-\theta$. Independently, $P$ is cubic and $\lVert\cdot\rVert$ even, so $\theta=P/\lVert W\rVert^3$ negates. A local maximum maps to a local minimum.

**The caveat the block should carry.** The configuration question is symmetric, the analytic one is not. If a falsifier at $a=4$ had $\theta$ above a positive threshold, its partner at $a=6$ has $\theta$ below the negative of it, so at most one member of the pair is ever a falsifier in the sense of exceeding $\theta_0(n)$ or $\sqrt{3/2}$. Nothing in the argument breaks, because emptiness is what transfers. The sentence "these two are the same case" is true of the geometry and false of $\theta$, and the record will want that distinction the next time the swap is invoked to move a bound rather than an emptiness.

## 7. The explicit $a=3$ contradiction

**The trace $1/5$ is forced, not chosen, and the block undersells its own computation.** At $a=3$ and $n=5$ the row sums are $S_{\alpha\alpha}+\sum_{\beta\ne\alpha}S_{\alpha\beta}=4a/n=12/5$ with $S_{\alpha\alpha}=2$, so the two off-diagonal entries of each row sum to $2/5$. The three equations $S_{12}+S_{13}=S_{12}+S_{23}=S_{13}+S_{23}=2/5$ give $S_{12}=S_{13}=S_{23}=1/5$ uniquely. So $1/5$ is the only possible pairwise trace at $n=5$, $a=3$. ANSWER TO THE ITEM'S QUESTION: YES, AND UNIQUELY.

**The pair is the principal-angle normal form, so the computation is a proof and not an example.** Two $2$-planes in $\mathbb R^5$ are determined up to $O(5)$ by their principal angles. With $\vartheta_2=\pi/2$ forced by $\Lambda^2$-orthogonality and $\cos^2\vartheta_1=1/5$, the normal form is $P_1=\mathrm{span}\{e_1,e_2\}$ and $P_2=\mathrm{span}\{\cos\vartheta_1e_1+\sin\vartheta_1e_3,\ e_4\}$, and $\cos\vartheta_1=1/\sqrt5$, $\sin\vartheta_1=2/\sqrt5$ give exactly $(e_1+2e_3)/\sqrt5$ and $e_4$. So the block's $P_1,P_2$ are the general pair, up to rotation, and the contradiction it reaches is general.

The two stated properties hold. With $\Pi_1=\mathrm{diag}(1,1,0,0,0)$ and $f_1=(e_1+2e_3)/\sqrt5$,
$$\Pi_2=f_1f_1^{\mathsf T}+e_4e_4^{\mathsf T},\qquad (\Pi_2)_{11}=\tfrac15,\ (\Pi_2)_{13}=(\Pi_2)_{31}=\tfrac25,\ (\Pi_2)_{33}=\tfrac45,\ (\Pi_2)_{44}=1,$$
so $\operatorname{tr}(\Pi_1\Pi_2)=(\Pi_2)_{11}+(\Pi_2)_{22}=1/5$. For orthogonality I use the determinant form of the inner product, which under this brief's normalisation is exactly $\langle u\wedge v,x\wedge y\rangle=\langle u,x\rangle\langle v,y\rangle-\langle u,y\rangle\langle v,x\rangle$: writing $X=vu^{\mathsf T}-uv^{\mathsf T}$ and $Y=yx^{\mathsf T}-xy^{\mathsf T}$, the four terms of $\operatorname{tr}(X^{\mathsf T}Y)$ are $2(\langle u,x\rangle\langle v,y\rangle-\langle u,y\rangle\langle v,x\rangle)$ and the factor $\tfrac12$ removes the $2$. Hence $\langle e_1\wedge e_2,f_1\wedge e_4\rangle=\langle e_1,f_1\rangle\langle e_2,e_4\rangle-\langle e_1,e_4\rangle\langle e_2,f_1\rangle=0$. CONFIRMED.

The third matrix is as printed. With $\kappa=6/5$,
$$\Pi_3=\tfrac65\mathrm{Id}-\Pi_1-\Pi_2=\operatorname{diag}\!\left(0,\tfrac15,\tfrac25,\tfrac15,\tfrac65\right)-\tfrac25\left(e_1e_3^{\mathsf T}+e_3e_1^{\mathsf T}\right),$$
because the diagonal of $\Pi_1+\Pi_2$ is $(6/5,1,4/5,1,0)$ and its only off-diagonal entries are $\pm$ the $2/5$ at $(1,3)$ and $(3,1)$. That matches given 14's arithmetic in the block, entry for entry. Its trace is $0+\tfrac15+\tfrac25+\tfrac15+\tfrac65=2$, as a rank-two projection's must be, so the failure is not a trace failure.

The failure is positivity, and it is immediate. A positive semidefinite matrix with $M_{11}=0$ has its whole first row zero, since the $2\times2$ principal minor on $\{1,3\}$ is $\begin{vmatrix}0&M_{13}\\M_{13}&M_{33}\end{vmatrix}=-M_{13}^2$, negative unless $M_{13}=0$. Here $M_{13}=-2/5$. So $\Pi_3$ cannot be a projection, and no third plane exists. CONFIRMED, and the case $a=3$ at $n=5$ is closed twice over, once by this rigid computation and once by item 3.

## 8. The eigenvalues of $\Pi_1+\Pi_2$, the step to be most sceptical about

Take the normal form for two $2$-planes of $\mathbb R^5$ with principal angles $\vartheta_1$ and $\pi/2$: $P_1=\mathrm{span}\{e_1,e_2\}$ and $P_2=\mathrm{span}\{ce_1+se_3,\ e_4\}$ with $c=\cos\vartheta_1$, $s=\sin\vartheta_1$, $c^2+s^2=1$. Then
$$\Pi_1+\Pi_2=\begin{pmatrix}1+c^2&&cs&&\\&1&&&\\ cs&&s^2&&\\&&&1&\\&&&&0\end{pmatrix}$$
in the basis ordered $e_1,e_2,e_3,e_4,e_5$. The matrix is block diagonal with a $2\times2$ block on $\{e_1,e_3\}$ and scalars $1,1,0$ on $e_2,e_4,e_5$. The block has trace $1+c^2+s^2=2$ and determinant $(1+c^2)s^2-c^2s^2=s^2$, so its eigenvalues solve $\lambda^2-2\lambda+s^2=0$, giving $\lambda=1\pm\sqrt{1-s^2}=1\pm\lvert c\rvert$. Hence the spectrum is
$$\{1+c,\ 1-c,\ 1,\ 1,\ 0\},\qquad c=\lvert\cos\vartheta_1\rvert=\sqrt{S_{12}},$$
with trace $4=\operatorname{tr}\Pi_1+\operatorname{tr}\Pi_2$. CONFIRMED, and $c=\sqrt{S_{12}}$ is consistent with given 15 since $S_{12}=\cos^2\vartheta_1+\cos^2\vartheta_2=\cos^2\vartheta_1$.

**The degeneracies, exactly.** The multiset above is correct for every admissible pair, and degeneracy changes only which entries coincide.

- $c=0$, mutually orthogonal planes, $S_{12}=0$: the multiset is $\{1,1,1,1,0\}$ and the eigenvalue $1$ has multiplicity $4$. The formula is unchanged.
- $c=1$, planes sharing a line, $S_{12}=1$, which $\Lambda^2$-orthogonality permits (take $e_1\wedge e_2$ and $e_1\wedge e_3$): the multiset is $\{2,1,1,0,0\}$, the zero acquires multiplicity $2$, and this is visible geometrically since $\dim(P_1+P_2)=3$. The formula is again unchanged.
- Coincident planes, both angles zero, is impossible: it would give $\langle\omega_1,\omega_2\rangle=\pm1$ against orthonormality.
- The single $0$ in the generic case is not an accident of the normal form: $\dim(P_1+P_2)\le4<5$, so $\Pi_1+\Pi_2$ is singular at $n=5$ always. This is the fact the next section's rank step lives on, and at $n\ge6$ the zero has multiplicity $n-4$ instead.

## 9. The $a=4$ contradiction chain

Isotropy at $a=4$, $n=5$ gives $\kappa=8/5$. Subtracting item 8's spectrum from $8/5$:
$$\tfrac85\mathrm{Id}-\Pi_1-\Pi_2\ \text{has eigenvalues}\ \tfrac35-c,\ \tfrac35+c,\ \tfrac35,\ \tfrac35,\ \tfrac85,$$
of trace $\tfrac{3-5c+3+5c+3+3+8}5=\tfrac{20}5=4$, which is $\operatorname{tr}(\Pi_3+\Pi_4)$ as it must be. CONFIRMED.

That matrix equals $\Pi_3+\Pi_4$ by isotropy, hence is positive semidefinite, and the only eigenvalue that can be negative is $\tfrac35-c$, so $c\le\tfrac35$. CONFIRMED. Its rank is at most $2+2=4<5$, so at least one eigenvalue vanishes. Since $\tfrac35+c\ge\tfrac35>0$, $\tfrac35>0$ and $\tfrac85>0$, only $\tfrac35-c$ can vanish, and $c=\tfrac35$, that is $S_{12}=\tfrac9{25}$. CONFIRMED.

The labels were arbitrary, so this holds at every one of the six pairs of $A$ (section 10). The row sum from given 14 is $\sum_{\beta\in A}S_{\alpha\beta}=4a/n=\tfrac{16}5$, and $S_{\alpha\alpha}=2$ leaves $\tfrac{16}5-2=\tfrac65=\tfrac{30}{25}$ for the three off-diagonal entries of each row, which at $\tfrac9{25}$ apiece give $\tfrac{27}{25}$. CONTRADICTION CONFIRMED, and the arithmetic is as printed. The same contradiction in the symmetric form: $\sum_{\alpha<\beta}S_{\alpha\beta}$ must be $\tfrac12(\kappa^2n-2a)=\tfrac12(\tfrac{64}5-8)=\tfrac{12}5=\tfrac{60}{25}$, while six pairs at $\tfrac9{25}$ give $\tfrac{54}{25}$.

**A second contradiction, independent of the row sum.** Once $c=\tfrac35$ is forced, the spectrum of $\tfrac85\mathrm{Id}-\Pi_1-\Pi_2$ is $\{0,\tfrac35,\tfrac35,\tfrac65,\tfrac85\}$. But that matrix is $\Pi_3+\Pi_4$, and section 8 applies to the pair $(P_3,P_4)$ as well, so its spectrum must have the shape $\{1+c',1-c',1,1,0\}$ and in particular must contain the eigenvalue $1$ with multiplicity at least $2$. It contains no eigenvalue $1$ at all. Even without invoking $c=\tfrac35$ first: matching $\{\tfrac35-c,\tfrac35+c,\tfrac35,\tfrac35,\tfrac85\}$ against $\{1+c',1-c',1,1,0\}$ needs $1$ twice on the left, and $\tfrac35\ne1$, $\tfrac85\ne1$, while $\tfrac35-c$ and $\tfrac35+c$ cannot both be $1$. So the case dies on the spectra alone. This costs nothing extra in hypotheses, it uses only section 8 twice, and I record it because it makes the $a=4$ emptiness independent of given 14's row-sum reading.

The degenerate case is handled as the block says: two planes sharing a line have $c=1$, so $\tfrac35-c=-\tfrac25<0$ and positivity excludes it before anything else. Planes spanning fewer than four dimensions is that same case, and there is no other, by section 8's list.

## 10. Does the argument force all pairs to one value

**It forces each pair separately, and every pair to the same number, so yes.** Nothing in section 9 used the identity of the two removed indices: for any $\alpha\ne\beta$ in $A$, $\kappa\,\mathrm{Id}-\Pi_\alpha-\Pi_\beta$ is the sum of the other two projections, hence positive semidefinite of rank at most $4$, hence has a zero eigenvalue, which only $\tfrac35-c_{\alpha\beta}$ can supply. The forced value $\tfrac35=\kappa-1$ depends on $\kappa$ and $n$ alone, not on the pair, so all six coincide at $S_{\alpha\beta}=\tfrac9{25}$ without any regularity being assumed. This is the step where an incautious version of the argument would have assumed equal entries, as the $a=3$ block's phrasing invites. Here equality is a conclusion. CONFIRMED.

A consistency check on the same data: rank $<4$ for $\Pi_3+\Pi_4$ would need two zero eigenvalues, which the list cannot supply, so the forcing also proves that no two of the four planes share a line. That is consistent with $S_{\alpha\beta}=\tfrac9{25}\ne1$ and provides no separate contradiction.

## 11. The pentagon

**$C_5$ is $\mathrm{SRG}(5,2,0,1)$.** It is $2$-regular; adjacent vertices have no common neighbour, since $C_5$ is triangle-free, giving $\lambda=0$; non-adjacent vertices have exactly one, giving $\mu=1$. The identity $k(k-\lambda-1)=(n-k-1)\mu$ reads $2\cdot1=2\cdot1$. CONFIRMED. Its complement on $\{1,\dots,5\}$ is the pentagram with edges $13,35,52,24,41$, which is the cycle $1$-$3$-$5$-$2$-$4$-$1$, so $C_5$ is self-complementary. CONFIRMED.

**The configuration and its isotropy.** For a graph $G$ on the $n$ frame vectors, taking the coordinate planes of its edges gives $\Theta=\sum_{\{i,j\}\in G}(e_ie_i^{\mathsf T}+e_je_j^{\mathsf T})=\sum_i\deg_G(i)\,e_ie_i^{\mathsf T}$, isotropic exactly when $G$ is regular, of constant $\deg=2\lvert E(G)\rvert/n=2a/n$. At $C_5$: $a=5$, $\kappa=2$, complement $\kappa'=2$, and $\kappa+\kappa'=4=n-1$ as given 15 demands. CONFIRMED, and $5\mid2a$ holds, so this is a divisible degree.

**Ricci-flat, trace-free, Bianchi.** With weights $+1$ on the cycle and $-1$ on the pentagram, given 2 gives $1\cdot2\,\mathrm{Id}+(-1)\cdot2\,\mathrm{Id}=0$, so Ricci-flat; $\sum_\alpha\lambda_\alpha=5-5=0$, so trace-free; and given 6 makes first Bianchi automatic, since every $\omega_\alpha$ is decomposable and contributes $\omega_\alpha\wedge\omega_\alpha=0$. So $W\in\mathcal W_5$ with two eigenvalues $\pm1$, each of multiplicity $5$, and $\lVert W\rVert^2=10$. CONFIRMED.

**Criticality, derived rather than granted, and $\theta=0$.** I needed $W^\#$ for a coordinate-diagonal $W$, so I built it from given 12's structure constants. Write $W$ diagonal in the coordinate basis with weight $w_{ij}$ on $e_i\wedge e_j$, and let $M$ be the symmetric $n\times n$ matrix with $M_{ij}=w_{ij}$ off the diagonal and $M_{ii}=0$. The Lie bracket of coordinate bivectors is nonzero only on triangles: $[\varphi_{12},\varphi_{23}]=-\varphi_{13}$ by direct multiplication of $\varphi_{ab}=E_{ba}-E_{ab}$, so $c_{\alpha\beta\gamma}=\pm1$ when $\alpha,\beta,\gamma$ are the three edges of a triangle and $0$ otherwise, and $T=c^2=1$ on triangles, which is given 12's hollow symmetric tensor. Two consequences.

- Off the diagonal, $(W^\#)_{\alpha\beta}=\tfrac12\sum_{\gamma\delta}c_{\alpha\gamma\delta}c_{\beta\gamma\delta}w_\gamma w_\delta$ vanishes for $\alpha\ne\beta$, because a pair $\gamma,\delta$ sharing exactly one vertex closes to a unique third edge, forcing $\alpha=\beta$. So $W^\#$ is coordinate-diagonal whenever $W$ is, and criticality reduces to its diagonal.
- On the diagonal, given 12's relation (C) identifies $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\gamma\delta}T_{\alpha\gamma\delta}w_\gamma w_\delta$, and for $\alpha=\{i,j\}$ the contributing ordered pairs are $(\{i,k\},\{j,k\})$ and its reverse over the $n-2$ third vertices, so $(W^\#)_{\alpha\alpha}=\sum_{k}w_{ik}w_{jk}=(M^2)_{ij}$, the last step because the terms $k=i$ and $k=j$ vanish with $M_{ii}=M_{jj}=0$.

Criticality $W^2+W^\#=\theta W$ is therefore the scalar family $w_{ij}^2+(M^2)_{ij}=\theta\,w_{ij}$ over the edges $\{i,j\}$ of $K_n$. For the pentagon, $M=2A-J+I$ with $A=A(C_5)$, and $A^2=2I+(J-I-A)=I+J-A$ from the parameters, $AJ=JA=2J$, $J^2=5J$, so
$$M^2=4A^2+I+J^2+4A-4AJ-2J=4(I+J-A)+I+5J+4A-8J-2J=5I-J,$$
giving $(M^2)_{ij}=-1$ at every $i\ne j$. Then $w_{ij}^2+(M^2)_{ij}=1-1=0$ at every edge, so $Q(W)=0=\theta W$ with $\theta=0$, and $W$ IS a critical point. Independently, $P(W)=\langle W,W^2+W^\#\rangle=\sum_\alpha w_\alpha(w_\alpha^2+(M^2)_\alpha)=\sum_\alpha(w_\alpha-w_\alpha)=0$, so $\theta=P/\lVert W\rVert^3=0$ as well. CONFIRMED that it is a two-eigenvalue diagonal critical point.

**The omission worth fixing.** Its invariant is $\theta=0$ exactly, against $\theta_0(5)=\sqrt{24}/5$ and $\sqrt{3/2}$. The block calls it "a genuine two-eigenvalue diagonal critical point" and leaves $\theta$ unsaid, which invites a reader to file the pentagon as a competitor at $n=5$. It is a critical point of critical value zero, so it constrains nothing about the maximum, and its own negation is the pentagram-positive labelling with $\theta=0$ again, consistent with section 6. The record should print the value.

**Item 11b, the implication as stated.** "Strongly regular, so it is a critical point" is stated as if strong regularity were the reason, and I checked whether it is. For a $k$-regular $G$ on $n$ vertices the Ricci-flat and trace-free weights are forced up to scale, and both conditions give the same ratio: $\mu_+k+\mu_-(n-1-k)=0$ and $\mu_+a+\mu_-(N-a)=0$ agree because $a=nk/2$ makes $(N-a)/a=(n-1-k)/k$. Take $\mu_+=n-1-k$ and $\mu_-=-k$, so $M=sA-qJ+qI$ with $q=k$ and $s=n-1$. For $G$ strongly regular, $A^2=kI+(\lambda-\mu)A+\mu(J-I)$ and the off-diagonal of $M^2$ is $[s^2(\lambda-\mu)+2sq]A_{ij}+[s^2\mu+q^2n-2sqk-2q^2]$. Imposing $w_{ij}^2+(M^2)_{ij}=\theta w_{ij}$ separately on non-edges and edges gives
$$\theta=\frac{(n-1)\left(k^2-(n-1)\mu\right)}{k}\quad\text{and}\quad\theta=\frac{(n-1)\left((n-1)(1+\lambda)-k^2\right)}{n-1-k},$$
and the two agree exactly when $k^2+k\mu-(n-1)\mu=k+k\lambda$, which is $k(k-\lambda-1)=(n-k-1)\mu$, the standard strongly-regular parameter identity. So the implication is not only true for $C_5$ but a general theorem: EVERY strongly regular graph's coordinate configuration with its Ricci-flat weights is a critical point, and the criticality condition is precisely the SRG identity, with the displayed $\theta$ before unit normalisation. At $C_5$ the first formula gives $4(4-4)/2=0$, matching. The block's inference is sound and, as far as this brief shows, stronger than it knew. One caution for whoever records it: $Q=\theta W$ is not scale-invariant, so the $\theta$ above must be divided by $\lVert W\rVert$ to be the record's $\theta=P/\lVert W\rVert^3$, and my $\pm1$ pentagon happens to be a case where $\mu_+=\mu_-$ because $n=2k+1$.

## 12. Vacuity and scope

Nothing is vacuous. At $a=3$ and at $a=4$ the constraints look satisfiable until the argument is run: at $a=3$ the Gram data is uniquely determined and consistent as a matrix, and the obstruction is that the third projection it demands is not positive semidefinite; at $a=4$ the row sums and the trace are mutually consistent, and the obstruction is spectral. So both emptiness claims carry content.

**One genuine overstatement.** The headline "at $n=5$ the only isotropic decomposable subspaces have $a=5$" omits hypothesis 5. The rank count of items 3 and 4 excludes $a\le3$ outright, but $a\in\{7,8,9\}$ are excluded only through the complement, that is only when $E^\perp$ also carries an orthonormal decomposable basis. Without that, $a=9$ still dies for a different reason, since $\Theta(E^\perp)=\tfrac25\mathrm{Id}$ would need a single $\omega\omega^{\mathsf T}$ of rank $5$ while a skew matrix's square has even rank at most $4$. But $a=7$ does not die, because $\Theta(E^\perp)=\tfrac65\mathrm{Id}$ on a three-dimensional $E^\perp$ has the right trace, $6=2\cdot3$, and three not-necessarily-decomposable unit forms can carry full rank between them. So the statement that is proved is: among $E$ such that $E$ AND $E^\perp$ both have orthonormal decomposable bases, the only isotropic ones at $n=5$ have $a=5$. That is exactly the falsifier frame, so the mathematics stands and only the sentence needs the clause.

**A second scope clause, unstated.** Everything is conditioned on exactly two nonzero eigenvalues, per hypothesis 2. A decomposable-basis Weyl tensor at $n=5$ with a kernel, or with three eigenvalues, is untouched by these blocks, because given 14's isotropy is unavailable there. The closing sentence "the falsifier hunt at $n=5$ is therefore over for the non-divisible degrees" is true inside that frame and should name it, especially since $W_{\mathbb{CP}^2}$ itself, given 5, has a kernel at $n=4$ and would be outside the analogous frame.

**Does the conclusion cover $a=5$?** No, and the block says so: divisibility is necessary and not sufficient, so what survives is the question whether the degree-two configuration at $n=5$ admits a non-coordinate realisation. The pentagon is one coordinate realisation, and by L201 with given 9 any configuration whose pairwise traces are all in $\{0,1\}$ is coordinate. The open case is a five-element configuration with some $S_{\alpha\beta}$ strictly between $0$ and $1$ and row sums $4$. The block's scope statement here is accurate.

## 13. What would break each argument, and what I did to look for it

**Argument one, the single removal.** It breaks if some $\Pi_\alpha$ has rank other than two, if two basis forms share a plane, or if isotropy fails. I checked each: unit decomposability forces orthonormal $u,v$ under this brief's normalisation, so the rank is exactly two; a shared plane forces $\omega_\beta=\pm\omega_\alpha$ against orthonormality; isotropy is given 14 and needs no kernel, which I recorded as hypothesis 2 rather than tested. The object that would refute it is an isotropic decomposable $E$ with $2a<n$, and the trace identity $\operatorname{tr}\Theta(E)=2a=\kappa n$ forbids it before any removal.

**Argument two, the double removal.** It breaks if a pair of orthogonal decomposable forms can have both principal angles away from a right angle, which would change section 8's spectrum. I derived the inner product in determinant form and found $\langle\omega_1,\omega_2\rangle=\cos\vartheta_1\cos\vartheta_2$, so orthogonality is exactly one right angle and the spectrum $\{1\pm c,1,1,0\}$ is unavoidable at $n=5$. It also breaks if $\Pi_3+\Pi_4$ could reach rank five, which two rank-two matrices cannot, or if the row-sum constant were other than $4a/n$. I re-derived that constant as $\operatorname{tr}(\Pi_\alpha\Theta(E))=2\kappa$. The object that would refute it is four pairwise $\Lambda^2$-orthogonal decomposable unit forms in $\Lambda^2\mathbb R^5$ with $\sum\Pi_\alpha=\tfrac85\mathrm{Id}$. I looked for it by forcing its Gram matrix, which is determined to the single value $S_{\alpha\beta}=\tfrac9{25}$, and it then fails two independent tests, the row sum and the spectral shape of $\Pi_3+\Pi_4$. No search or sweep was run and none is needed, the case being closed in closed form.

**The pentagon.** It would break if $W^\#$ had off-diagonal entries in the coordinate basis, which I ruled out from the triangle support of the structure constants, or if $(M^2)_{ij}$ were anything but $-1$, which I computed twice, once through the SRG relation for $A^2$ and once through the general parameter formula. A refuting object would be a $\theta$ for the pentagon different from $0$, and both routes, the criticality equation and $P(W)$ directly, return $0$.

## 14. Handover: the same count one step further, at every $n$

The block's $a=4$ computation is not special to $n=5$, and running it in general strengthens item 3 from $a\ge n/2+1$ to $a\ge n/2+2$. I record the derivation because it is short, exact, and it reproduces the $n=5$ endpoint in one stroke.

Let $E$ have an orthonormal decomposable basis and $\Theta(E)=\kappa\,\mathrm{Id}$, $\kappa=2a/n>1$. For any pair, $\kappa\,\mathrm{Id}-\Pi_\alpha-\Pi_\beta$ has eigenvalues $\kappa-1-c$, $\kappa-1+c$, $\kappa-1$ twice, and $\kappa$ with multiplicity $n-4$, by section 8 read at general $n$. It is a sum of $a-2$ rank-two projections, so if $2(a-2)<n$ it is singular, and with $\kappa>1$ only $\kappa-1-c$ can vanish. Hence every pair has $c_{\alpha\beta}=\kappa-1$ and $S_{\alpha\beta}=(\kappa-1)^2$. Writing $x=\kappa-1>0$, the row sum $\sum_{\beta\ne\alpha}S_{\alpha\beta}=4a/n-2=2x$ gives $(a-1)x^2=2x$, so $x=2/(a-1)$, that is
$$\frac{2a}n-1=\frac2{a-1},\qquad\text{equivalently}\qquad (2a-n)(a-1)=2n.$$
Now the only integers in $[n/2+1,\,n/2+2)$ are $a=n/2+1$ for even $n$ and $a=(n+3)/2$ for odd $n$. At $a=n/2+1$ the equation reads $2\cdot\tfrac n2=n=2n$, false. At $a=(n+3)/2$ it reads $3\cdot\tfrac{n+1}2=2n$, that is $n=3$. So for every $n\ge4$: either $a=n/2$, or $a\ge n/2+2$, and by section 4 the complement obeys it too. The exception $n=3$, $a=3$ is real and realised, all three coordinate planes of $\mathbb R^3$ giving $\Theta=2\,\mathrm{Id}$ with every pair sharing a line and $x=c=1$.

Two checks. At $n=5$ the strengthened bound gives $a\ge4.5$, so $a\ge5$, and the complement gives $10-a\ge5$, so $a=5$ immediately, which is exactly the two blocks' combined conclusion. At $n=4$ it kills $a=3$, and it leaves $a=2=n/2$ and $a=4=n/2+2$, which is what given 4's rotated witness shows, its weights $(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$ having four positive and two negative entries.

## Verdict

**SUSTAINED. Both arguments are correct, and I reproduce each independently, the $a=4$ one by a second route the block does not use.** No step is missing, no case is skipped, and the two emptiness results do close every candidate at $n=5$ inside the two-eigenvalue decomposable frame, leaving only the question the block itself leaves, whether the divisible degree $a=5$ admits a non-coordinate configuration.

Four corrections, none of them touching a conclusion.

1. **The headline needs its hypothesis.** $a\in\{7,8,9\}$ are excluded only when $E^\perp$ also carries an orthonormal decomposable basis, and $a=7$ has no other exclusion in the givens. State the frame.
2. **The pentagon's $\theta$ is exactly $0$**, which the block does not say and a reader will want, since a critical value of zero makes it irrelevant to the maximisation it might otherwise seem to bear on.
3. **The letter $c$ carries two meanings** in the $a=4$ paragraph, the isotropy constant $8/5$ and the principal-angle cosine bounded by $3/5$. Separate them before the paragraph enters the record.
4. **"Which is the rank bound $2a\ge n$ again" mislabels given 17**, whose content is a rank bound on the Gram matrix at a full basis. The inequality is true and follows from trace and rank of $\Theta(E)$ in one line.

Two additions offered for the record, both derived above and both exact.

- **Every strongly regular graph's coordinate configuration is a critical point** with its Ricci-flat weights, the criticality condition reducing identically to $k(k-\lambda-1)=(n-k-1)\mu$, and $\theta=(n-1)(k^2-(n-1)\mu)/k$ before unit normalisation. The block's "strongly regular, so critical" is therefore a theorem and not a coincidence at $C_5$.
- **The admissible sizes are $a=n/2$ or $a\ge n/2+2$ at every $n\ge4$**, with $n=3$ the single realised exception, which subsumes both blocks at $n=5$ into one line and prunes one further dimension at every larger $n$.
