# Review r998: the bracket-trace bridge, and the Gram reading of Ricci-flatness

Brief: [BRIEF_I74_bridge.md](BRIEF_I74_bridge.md). Reviewer r998, one of two on identical briefs, working independently. Conventions are the brief's: $\omega=a\wedge b$ is the matrix $ba^{\mathsf T}-ab^{\mathsf T}$, the inner product making $\{\varphi_{ab}\}_{a<b}$ orthonormal is $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, and $[\,\cdot,\cdot\,]$ is the matrix commutator.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | the bridge, $\lVert[\omega_\alpha,\omega_\beta]\rVert^2=\operatorname{tr}(\Pi_\alpha\Pi_\beta)$ | **CONFIRMED**, and the two Lean declarations cited type a *different* identity |
| 2 | the bracket is decomposable | **CONFIRMED**, with the inference relabelled |
| 3 | the pair cap sharpens from $2$ to $1$ | **CONFIRMED**, and it sharpens under a weaker hypothesis than stated |
| 4 | row sum $2(n-2)$ | **CONFIRMED**, twice, the second proof needing no decomposability |
| 5 | total sum $n(n-1)(n-2)$ | **CONFIRMED** |
| 6 | Ricci-flatness is exactly $S\lambda=0$ | **CONFIRMED**, non-vacuous at $n\ge4$ and vacuous at $n=3$ |
| 7 | $S\succeq0$, trace $n(n-1)$, rank, all-ones eigenvector | **CONFIRMED**, all four parts |
| 8 | $S=A(J(n,2))+2\,\mathrm{Id}$, spectrum, $\lVert S\rVert_F^2=n^2(n-1)$ | **CONFIRMED** exactly |
| 9 | relation (B) is $(S\lambda)_k=0$ | **CONFIRMED** as algebra, its premise out of my reach |
| 10 | relation (C) summed upgrades Ricci-flatness to a consequence | **CONFIRMED**, consuming $\theta\operatorname{tr}W=0$ and the whole diagonal |
| 11 | only the $W^\#$ off-diagonal family can bite | **PLAUSIBLE**, and its payload is **REFUTED** on one reading, below |

**The one thing to carry out of this review that is not in the table**: there is an exactly verified critical, Ricci-flat, Bianchi-satisfying $W$ on $\Lambda^2\mathbb R^4$ carrying **two** decomposable orthonormal eigenbases, one coordinate and one with $S$ entries $3969/4225$ and $256/4225$. Every criticality relation holds at the non-integral one. So **no family of relations can force integrality at a fixed decomposable eigenbasis**, and any route to Conjecture A through [L201](../lean/HamiltonsCubic/Results/L201Statement.lean) has to quantify existentially over eigenbases. Section [Row 11](#row-11-which-families-can-bite) carries it.

## Row 1, the bridge

**CONFIRMED in general, with an exact normal form rather than a case split.**

*Principal position is available at every pair, with no exception.* Let $G=[\langle a_i,c_j\rangle]$ be the $2\times2$ Gram matrix between an orthonormal basis $(a_1,a_2)$ of $P_\alpha$ and one $(c_1,c_2)$ of $P_\beta$. Take a singular value decomposition $G=U\Sigma V^{\mathsf T}$ and force $U,V\in SO(2)$ by absorbing a sign into $\Sigma$, so $\Sigma=\mathrm{diag}(\sigma_1,\varepsilon\sigma_2)$ with $\varepsilon=\pm1$. Rotating each plane's basis by $U$ and $V$ leaves $a_1\wedge a_2$ and $c_1\wedge c_2$ *exactly* fixed, because an $SO(2)$ change of basis inside a plane preserves its unit bivector. This uses only the existence of a $2\times2$ SVD, so it needs no genericity, no distinctness of the principal angles, and no assumption on how the planes meet.

*$\Lambda^2$-orthogonality really does force $\cos\vartheta_1\cos\vartheta_2=0$.* In the stated inner product $\langle a\wedge b,c\wedge d\rangle=\det G$, which I checked by expanding $\tfrac12\operatorname{tr}\big((ab^{\mathsf T}-ba^{\mathsf T})(dc^{\mathsf T}-cd^{\mathsf T})\big)=\langle a,c\rangle\langle b,d\rangle-\langle a,d\rangle\langle b,c\rangle$. In principal position that determinant is $\pm\cos\vartheta_1\cos\vartheta_2$, so orthogonality says one principal angle is right.

*The normal form, after relabelling so that the right angle is the second.* There are unit vectors with $\omega_\alpha=a\wedge b$, $\omega_\beta=c\wedge d$, $b\perp P_\beta$, $d\perp P_\alpha$, $a\perp b$, $c\perp d$ and $\langle a,c\rangle=t$. Then $\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\lVert G\rVert_F^2=t^2$, and

$$\omega_\alpha\omega_\beta=-t\,bd^{\mathsf T},\qquad \omega_\beta\omega_\alpha=-t\,db^{\mathsf T},\qquad [\omega_\alpha,\omega_\beta]=t\,(b\wedge d).$$

Since $b\perp d$ and both are unit, $b\wedge d$ is a decomposable unit form, so $\lVert[\omega_\alpha,\omega_\beta]\rVert^2=t^2=\operatorname{tr}(\Pi_\alpha\Pi_\beta)$.

*The three named edge cases.* **Equal planes are vacuous**: $\Lambda^2P$ is one-dimensional, so two decomposable unit forms on the same plane are $\pm$ each other and are never $\Lambda^2$-orthogonal. The bridge would fail there ($\operatorname{tr}=2$ against a zero bracket), and orthogonality is exactly what excludes it. **Planes meeting in a line** give $\vartheta_1=0$ automatically, so $t=1$, the bracket is a unit bivector and the trace is $1$. **Orthogonal planes** give $t=0$ and both sides vanish. At $n=3$ the first case is forced: two planes in $\mathbb R^3$ always meet, so every $\Lambda^2$-orthogonal decomposable pair has $\operatorname{tr}(\Pi_\alpha\Pi_\beta)=1$ exactly.

*On the record's "three of the four terms vanish".* Per product this is right: each of $\omega_\alpha\omega_\beta$ and $\omega_\beta\omega_\alpha$ expands into four rank-one terms of which three die. If the sentence is read as being about the bracket, it should say six of eight.

**The correction the brief asked for, and it goes the other way from what the table says.** [trace_instA_instB](../lean/HamiltonsCubic/Results/L201Statement.lean) and [frobSq_commutator_inst](../lean/HamiltonsCubic/Results/L201Statement.lean) do **not** type row 1 at an instance. Their own docstrings say so: they pin $\lVert[\Pi_\alpha,\Pi_\beta]\rVert_F^2=2t(1-t)$, an identity about the commutator of the two **projections**, which is what makes integrality commutativity and feeds [commuting_of_integral](../lean/HamiltonsCubic/Results/L201Statement.lean). At that same instance the two quantities are numerically different: I computed $\lVert[\omega_A,\omega_B]\rVert^2=9/25$ (row 1) against $\lVert[\Pi_A,\Pi_B]\rVert_F^2=288/625$ (the theorem). So **row 1 is typed nowhere in the layer, not even at one instance**, and the brief's table over-credits it. The instance pair is genuinely $\Lambda^2$-orthogonal, so it would serve for row 1 if the statement were written.

## Row 2, the bracket is decomposable

**CONFIRMED**, and it falls out of row 1's normal form for free: the bracket is $t\,(b\wedge d)$, which is zero or a rank-two decomposable form.

*One relabelling.* The sentence "the bracket is decomposable, **so** integrality says every bracket is zero or a unit bivector" splits its work in a way that reads backwards. Decomposability supplies the word *bivector*. What supplies the dichotomy is the cap $t^2\le1$ of row 3 together with integrality of $t^2$: without the cap, an integral value of $2$ would not be excluded, and decomposability alone excludes nothing. Stated cleanly: the bracket is $t\,(b\wedge d)$ with $t^2=\operatorname{tr}(\Pi_\alpha\Pi_\beta)\in[0,1]$, so integrality of the trace makes it zero or a unit decomposable form.

## Row 3, the cap sharpens from 2 to 1

**CONFIRMED**, with the equality case as stated, and the hypothesis is weaker than the row claims.

$\lVert[\omega_\alpha,\omega_\beta]\rVert^2=t^2=\cos^2\vartheta_1\le1$. Equality holds exactly at $\vartheta_1=0$, which is exactly $P_\alpha\cap P_\beta\ne\{0\}$, and the intersection is exactly a line because $\vartheta_2=\pi/2$ rules out equal planes. So equality is exactly "the two planes share a line", as claimed.

*It does not need both arguments decomposable.* Fix $\omega_\alpha=e_1\wedge e_2$. The operator $\mathrm{ad}_{\omega_\alpha}^2$ on $\Lambda^2$ is $0$ on $e_1\wedge e_2$ and on every form supported off $\{1,2\}$, and is $-\mathrm{Id}$ on the $2(n-2)$ mixed directions $e_i\wedge e_1$, $e_i\wedge e_2$. Hence for any unit $X$,

$$\lVert[\omega_\alpha,X]\rVert^2=-\langle\mathrm{ad}_{\omega_\alpha}^2X,X\rangle=\sum_{\text{mixed }c}X_c^2\le\lVert X\rVert^2=1 .$$

So **one decomposable argument already caps the bracket at 1**, with no orthogonality hypothesis at all. The cap $2$ therefore needs **both** arguments to have rank $4$, which is the brief's suspicion and is confirmed: I checked the unit orthonormal self-dual pair $v_1=(e_1\wedge e_2+e_3\wedge e_4)/\sqrt2$, $v_2=(e_1\wedge e_3+e_4\wedge e_2)/\sqrt2$ in $\mathbb R^4$, both of rank $4$, whose bracket has squared norm exactly $2$. A random search over orthonormal pairs in $\mathbb R^4$ climbed to $1.905$ and no higher, which is the screen behind reading $2$ as the true maximum.

## Rows 4 and 5, the row and total sums

**Both CONFIRMED.** Row 4 has two independent proofs and their agreement is a real check on row 1.

*The $\Theta$ route, which uses decomposability of the whole basis.* $\Pi_\beta=\omega_\beta^{\mathsf T}\omega_\beta$, and $X\mapsto X^{\mathsf T}X$ is a quadratic map whose sum over any orthonormal basis is basis-independent, so $\sum_\beta\Pi_\beta=\sum_{a<b}\varphi_{ab}^{\mathsf T}\varphi_{ab}=(n-1)\mathrm{Id}$. Then $\sum_\beta\operatorname{tr}(\Pi_\alpha\Pi_\beta)=2(n-1)$, and removing the diagonal term $\operatorname{tr}(\Pi_\alpha^2)=2$ leaves $2(n-2)$.

*The Killing route, which uses no decomposability.* $\mathrm{ad}$ is skew for an invariant form, so $\sum_\gamma\lVert[\omega_\alpha,\omega_\gamma]\rVert^2=-\operatorname{tr}(\mathrm{ad}_{\omega_\alpha}^2)=-B(\omega_\alpha,\omega_\alpha)$ with $B(X,Y)=(n-2)\operatorname{tr}(XY)$ on $\mathfrak{so}(n)$. A unit $\omega_\alpha$ has $\operatorname{tr}(\omega_\alpha^2)=-2$, giving $2(n-2)$ at **every** orthonormal basis of $\Lambda^2$, decomposable or not.

The two constants agree, which they would not if row 1 carried a spurious factor. Row 5 is then $N\cdot2(n-2)=\tfrac{n(n-1)}2\cdot2(n-2)=n(n-1)(n-2)$.

## Rows 6 and 7, the Gram reading and the positivity

**Both CONFIRMED.**

With $R_{ijkl}=\sum_\alpha\lambda_\alpha(\omega_\alpha)_{ij}(\omega_\alpha)_{kl}$ the Ricci contraction is $\mathrm{Ric}_{ik}=\sum_jR_{ijkj}=\sum_\alpha\lambda_\alpha(\omega_\alpha\omega_\alpha^{\mathsf T})_{ik}=M_{ik}$, so Ricci-flatness is $M=0$. The control is the round $S^3$: $n=3$, $\lambda=(1,1,1)$ gives $M=(n-1)\mathrm{Id}=2\,\mathrm{Id}$, which is the Ricci tensor of the unit round metric.

*The positivity line is sound, and both of its halves hold.* $(S\lambda)_\alpha=\langle\Pi_\alpha,M\rangle$, so $S\lambda=0$ says $M\perp\mathrm{span}\{\Pi_\beta\}$. **$M$ really lies in that span**, by its definition as the $\lambda$-combination of the $\Pi_\beta$, with no step in between. **The pairing is positive definite there**, because $\langle A,B\rangle=\operatorname{tr}(AB)$ is positive definite on all of $\mathrm{Sym}^2\mathbb R^n$, so definiteness on the subspace is inherited rather than assumed. Hence $\langle M,M\rangle=0$ and $M=0$. The converse is immediate, so the equivalence is exact.

Row 7 in four parts. $S$ is the Gram matrix of $\{\Pi_\alpha\}$ in a positive definite form, so $S\succeq0$ and $\operatorname{rank}S=\dim\mathrm{span}\{\Pi_\alpha\}$. Its trace is $\sum_\alpha\operatorname{tr}(\Pi_\alpha^2)=2N=n(n-1)$. Row 4 gives $S\mathbf1=2(n-1)\mathbf1$. All four are stable under the whole decomposable locus, not only at coordinate configurations, which I checked on a non-coordinate decomposable orthonormal basis of $\Lambda^2\mathbb R^4$ built by rotating the two "mixed" pencils through different angles.

*Vacuity, which the brief asked for explicitly.* Row 6 describes an empty set exactly when $\ker S=0$. At $n=3$ that is what happens: $\binom32=3=n$, $S=\mathrm{Id}+J$ is nonsingular, and the only Ricci-flat weighting is $\lambda=0$. This is correct rather than a defect, since Ricci-flat in dimension three means flat. At $n\ge4$ the kernel has dimension $\binom n2-n>0$ at a coordinate configuration, and each kernel vector is a nonzero Ricci-flat $W$. The concrete $n=4$ witness is $\lambda=(1,-1,0,0,-1,1)$ on $(12),(13),(14),(23),(24),(34)$. So row 6 is non-vacuous exactly where it needs to be.

## Row 8, the Johnson graph

**CONFIRMED, exactly, and the arithmetic is right at every step.**

At a coordinate configuration $\Pi_{ij}=E_{ii}+E_{jj}$, so $S_{\{i,j\},\{k,l\}}=\lvert\{i,j\}\cap\{k,l\}\rvert$, which is $2$ on the diagonal, $1$ when the pairs meet in one index, and $0$ when disjoint. The adjacency of $J(n,2)$, the triangular graph, is exactly the "meet in one index" relation, so $S=A(J(n,2))+2\,\mathrm{Id}$ with no slack.

$J(n,k)$ has eigenvalues $(k-i)(n-k-i)-i$ at multiplicity $\binom ni-\binom n{i-1}$. At $k=2$ that is $2(n-2)$, $n-4$ and $-2$ at multiplicities $1$, $n-1$ and $\binom n2-n$. Adding $2$ gives the row's $2n-2$, $n-2$, $0$ at those multiplicities. Two internal checks both close: the trace is $(2n-2)+(n-1)(n-2)=n^2-n=n(n-1)$, matching row 7, and

$$\lVert S\rVert_F^2=(2n-2)^2+(n-1)(n-2)^2=(n-1)\big[4(n-1)+(n-2)^2\big]=(n-1)n^2 .$$

I recomputed the adjacency identification, the full spectrum with multiplicities and the Frobenius norm from scratch for $n=3,\dots,11$ as assertions, all of which hold. Note that the third multiplicity is $0$ at $n=3$, so the row's three-eigenvalue phrasing degenerates there without becoming wrong. The nonzero multiplicities sum to $n$, which agrees with the given fact that rank $S=n$ exactly at coordinate configurations.

## Rows 9 and 10, the upgrade

**Row 9 CONFIRMED as algebra.** Since $S_{\alpha\alpha}=2$ at every index, $\hat S=S-2\,\mathrm{Id}$ **is** the off-diagonal part of $S$, and $\hat S\lambda=-2\lambda$ is $S\lambda-2\lambda=-2\lambda$, that is $S\lambda=0$. The step is unconditional. What I cannot audit from the brief alone is the premise, namely that criticality's relation (B) reads $(\hat S\lambda)_k=-2\lambda_k$, since the brief quotes the reading rather than the relation and forbids the findings file. Read as "given that (B) says this, it is $S\lambda=0$", the row is correct.

**Row 10 CONFIRMED, and the brief's two doubts both resolve in the record's favour, at the price of one hypothesis that should be stated aloud.**

*What "relation (C) summed" actually computes.* With $W$ diagonal in the basis, $W^\#_{\alpha\beta}=\tfrac12\sum_{\gamma\delta}c^{\gamma\delta}_\alpha c^{\gamma\delta}_\beta\lambda_\gamma\lambda_\delta$ where $c^{\gamma\delta}_\alpha=\langle[\omega_\gamma,\omega_\delta],\omega_\alpha\rangle$. Summing the diagonal and using $\sum_\alpha(c^{\gamma\delta}_\alpha)^2=\lVert[\omega_\gamma,\omega_\delta]\rVert^2$, then row 1 and $S_{\gamma\gamma}=2$,

$$\operatorname{tr}W^\#=\tfrac12\sum_{\gamma\ne\delta}\lambda_\gamma\lambda_\delta S_{\gamma\delta}=\tfrac12\lambda^{\mathsf T}S\lambda-\lVert\lambda\rVert^2 .$$

Summing $W^\#=\theta W-W^2$ on the diagonal gives $\operatorname{tr}W^\#=\theta\operatorname{tr}W-\lVert\lambda\rVert^2$. The $\lVert\lambda\rVert^2$ cancels and

$$\boxed{\ \lambda^{\mathsf T}S\lambda=2\,\theta\operatorname{tr}W\ }$$

so $\lambda^{\mathsf T}S\lambda=0$ is **exactly** $\theta\operatorname{tr}W=0$, for which $\operatorname{tr}W=0$ suffices. I verified this identity as an assertion on rotated coordinate bases at $n=3,4,5$ and on the non-coordinate $n=4$ basis, and the round $S^3$ is the closed control: $\lambda=(1,1,1)$, $W^\#=\mathrm{Id}$, $\theta=2$, and $\lambda^{\mathsf T}S\lambda=12=2\cdot2\cdot3$.

*Is $\operatorname{tr}W=0$ enough?* **Yes**, and it is the whole of the extra input. The upgrade is genuine rather than circular: scalar-flatness is one linear condition on $\lambda$ and Ricci-flatness is $\binom{n+1}2$, and the argument delivers the second from the first.

*Does $S\succeq0$ with $\lambda^{\mathsf T}S\lambda=0$ give $S\lambda=0$ for a possibly singular $S$?* **Yes, and singularity is irrelevant to it.** $\lambda^{\mathsf T}S\lambda=\lVert S^{1/2}\lambda\rVert^2$, so vanishing of the form gives $S^{1/2}\lambda=0$ and hence $S\lambda=S^{1/2}(S^{1/2}\lambda)=0$. The kernel of a positive semidefinite quadratic form is the kernel of its matrix, at every rank. The doubt would be well founded only for an indefinite $S$, and row 7 rules that out. The same conclusion is available without the square root: $\lambda^{\mathsf T}S\lambda=\lVert M\rVert^2$ by the row 6 computation, so the quadratic form vanishing is $M=0$ directly.

**Exactly which hypotheses the upgrade consumes**, since the brief asks for this precisely:

1. the whole orthonormal basis of $\Lambda^2$ is decomposable, which is what row 1 needs;
2. $W$ is diagonal in that basis, so that $W^2$ contributes only $\lVert\lambda\rVert^2$ to the trace;
3. the diagonal of criticality at **every** index, since it is summed over all $\alpha$, so a subset of the diagonal relations does not suffice;
4. $\theta\operatorname{tr}W=0$, in practice $\operatorname{tr}W=0$;
5. row 1 **with constant exactly one**.

Point 5 is not pedantry and is the one place row 10 is fragile. If the bridge held as $\lVert[\omega_\gamma,\omega_\delta]\rVert^2=\kappa\,S_{\gamma\delta}$ for some $\kappa\ne1$, the cancellation would leave a residual $(\kappa-1)\lVert\lambda\rVert^2$ and the implication would fail outright. The brief's inner product, the plain matrix commutator and Hamilton's $W^\#$ built from the structure constants of that same orthonormal basis are mutually consistent and give $\kappa=1$, which is what makes the argument work. Any later change of normalisation in one of the three, and only one of the three, breaks row 10 silently.

## Row 11, which families can bite

**PLAUSIBLE on the half I can check, and its payload is REFUTED on the reading that matters.**

*The logical question the brief poses.* "Cannot force integrality" does follow from "is satisfied by a non-integral example", provided the witness satisfies every hypothesis that travels with the family. That is the definition of non-entailment and the method is sound. But the conclusion is weaker than inertness. A family with a non-integral witness can still cut the solution set down, and can still be indispensable jointly with the others. The phrase to avoid is "carries no information", which the witness does not earn.

*One of the two claimed-inert families earns the stronger verdict on its own.* The Killing route in row 4 shows that $\sum_\gamma\lVert[\omega_\alpha,\omega_\gamma]\rVert^2=2(n-2)$ holds at **every** orthonormal basis of $\Lambda^2$, with no hypothesis on the basis and no reference to $\lambda$. A relation that is an identity on the whole ambient space is genuinely inert, and that is a proof rather than a witness. The same standard applies to a family that holds at every Weyl tensor: within the class of Weyl tensors it is an identity, hence inert there, and inert only there.

*The payload fails.* I constructed and verified **in exact rational arithmetic** the following object in $\mathbb R^4$. Let $W$ be diagonal in the coordinate bivector basis with weights $(-2,-2,1,1,1,1)$ on $\big(\varphi_{12},\varphi_{34},\varphi_{13},\varphi_{14},\varphi_{23},\varphi_{24}\big)$. Then, over $\mathbb Q$ and with no floating point anywhere:

- $W^2+W^\#=-3\,W$, so $W$ is critical at $\theta=-3$, checked entry by entry from the $\mathfrak{so}(4)$ structure constants;
- $M=\sum\lambda_\alpha\Pi_\alpha=0$ and $\operatorname{tr}W=0$, so it is Ricci-flat and trace-free;
- the first Bianchi identity holds at all $4^4$ index quadruples, so it is a genuine algebraic curvature operator.

The eigenvalue $+1$ has multiplicity four, so its eigenspace admits many decomposable orthonormal bases. Take $f_3=\tfrac35e_3+\tfrac45e_4$, $f_4=-\tfrac45e_3+\tfrac35e_4$, $g_3=\tfrac5{13}e_3+\tfrac{12}{13}e_4$, $g_4=-\tfrac{12}{13}e_3+\tfrac5{13}e_4$ and the six forms

$$e_1\wedge e_2,\quad e_3\wedge e_4,\quad e_1\wedge f_3,\quad e_1\wedge f_4,\quad e_2\wedge g_3,\quad e_2\wedge g_4 .$$

They are an orthonormal basis of $\Lambda^2\mathbb R^4$ by decomposable unit forms, they satisfy $\sum\Pi_\alpha=3\,\mathrm{Id}$, and they are an eigenbasis of the **same** $W$ with the same weights. Their Gram matrix is

$$S=\begin{pmatrix}2&0&1&1&1&1\\0&2&1&1&1&1\\1&1&2&1&\tfrac{3969}{4225}&\tfrac{256}{4225}\\1&1&1&2&\tfrac{256}{4225}&\tfrac{3969}{4225}\\1&1&\tfrac{3969}{4225}&\tfrac{256}{4225}&2&1\\1&1&\tfrac{256}{4225}&\tfrac{3969}{4225}&1&2\end{pmatrix},$$

with every row summing to $2(n-1)=6$ and off-diagonal total $n(n-1)(n-2)=24$, exactly as rows 4 and 5 require, with $\operatorname{rank}S=5>n=4$, and with $S\lambda=0$ as rows 6, 9 and 10 require. **It is not integral.**

Since criticality is an operator equation, it holds in every orthonormal basis of $\Lambda^2$, so at this configuration the off-diagonal of $W^\#=\theta W-W^2$ is satisfied too, $W$ being diagonal here as well. Hence the third family does not force integrality either, and **no family of criticality relations can**, at a decomposable eigenbasis handed to it. Row 11's "only the third can bite" survives only in the weak reading "only the third carries information the other two do not", which I have not been able to settle.

*What this costs the programme, and what it does not.* It does not touch rows 1 to 10, every one of which is a statement about a configuration and its Gram matrix and holds at this configuration too. It does not touch [L201](../lean/HamiltonsCubic/Results/L201Statement.lean), which assumes integrality rather than deriving it. What it does touch is any argument of the shape "criticality plus a decomposable eigenbasis gives integrality at that basis", which is now false with an exact witness. The route to Conjecture A has to say **there exists** a decomposable eigenbasis at which $S$ is integral, and the freedom that supplies it is exactly the degeneracy of the spectrum: a $W$ with simple $\Lambda^2$ spectrum has its decomposable eigenbasis determined up to signs, and only there is integrality at "the" eigenbasis a well posed constraint.

## Method

Every derivation above is by hand. The numerical work is assertions, never printed expectations, and was used only to screen claims before recording them: the bridge, decomposability and the cap on 1500 random orthogonal decomposable pairs at $n=3,\dots,7$; rows 4, 5 and 7 on rotated coordinate bases at $n=3,\dots,6$ and on a non-coordinate $n=4$ basis; row 8 at $n=3,\dots,11$; the row 10 trace identity on both kinds of basis. The row 11 witness is exact rational arithmetic with no floating point, and it is the only object in this review whose correctness the verdicts depend on.

Two screens returned a value rather than an assertion and are labelled as screens: a random search over orthonormal pairs of general 2-forms in $\mathbb R^4$ reaching $1.905$, which is evidence for and not proof of the cap $2$, and the observation that a non-coordinate decomposable configuration has $\operatorname{rank}S=5$.
