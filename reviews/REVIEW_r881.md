# REVIEW r881. I76 at n = 5: the witness is a rotated coordinate pentagon, and the integrality defect measures its basis rather than its operator

Reviewer r881, adversarial audit of the candidate non-coordinate two-eigenvalue element of $\mathcal W_5$ carried in `witness_n5.npy`. Working log: [agent_logs/review-r881-witness.log](../agent_logs/review-r881-witness.log). Scripts used are in the session scratchpad at `/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/` (`r881_rebuild.py`, `r881_polish.py`, `r881_mp.py`, `r881_weyl.py`, `r881_theta_aperp.py`, `r881_exact.py`, `r881_exact2.py`, `r881_span.py`, `r881_frame.py`, `r881_direct.py`, `r881_confirm.py`).

## Claim table

| # | Sub-claim | Verdict |
|---|---|---|
| C1 | the file rebuilds to the reported figures under the stated recipe | **holds** (reshape is row-major, not column-major) |
| C2 | the object is a two-eigenvalue element of $\mathcal W_5$ | **holds**, exactly, and the given derivation of each of the three conditions is valid |
| C3 | the recorded eigenbasis is orthonormal, decomposable and isotropic | **holds**, and an exact solution sits within $10^{-79}$ of the recorded one |
| C4 | the integrality defect $0.4985$ is real, not an artefact of the $10^{-11}$ residual | **holds**, and it survives Newton polish to residual $4.8\times10^{-81}$ at 80 digits |
| C5 | the recorded eigenbasis is not the coordinate basis of any frame | **holds** (and is provable without search: a pairwise plane trace is an $O(5)$ invariant that must be an integer) |
| C6 | $W$ is not coordinate-diagonal in any frame | **REFUTED**. An explicit frame is constructed in which $W$ is diagonal, to $10^{-60}$ at 70 digits, by exact linear algebra with no search |
| C7 | "every two-eigenvalue critical point of the decomposable locus is coordinate-diagonal" is FALSE at $n = 5$ | **not established**, and the witness is consistent with that statement |
| C8 | $A^\perp$ admits an orthonormal decomposable basis | **holds**, exactly: $A^\perp$ is the complementary coordinate pentagram of the very same frame |
| C9 | reported $\theta$ comparison | $\theta(W) = 0$ **exactly**, against $\theta_0(5) = \sqrt{24}/5 \approx 0.9798$ and $\sqrt{3/2} \approx 1.2247$. $W$ is a critical point of $P$ on the unit sphere, with multiplier $0$ |

## Summary

The witness is a genuine two-eigenvalue element of $\mathcal W_5$ whose recorded eigenbasis genuinely has a pairwise plane trace near $\tfrac12$, and it is nevertheless coordinate-diagonal: because the eigenvalue $+\lambda$ has multiplicity five, the eigenbasis is far from unique, and the one recorded in the file is a rotation, inside the degenerate eigenspace, of the coordinate pentagon basis of a frame that I construct explicitly from the witness itself.

## Conventions

Those of the brief, used unchanged. $\Lambda^2\mathbb R^n$ is skew matrices with $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, $\varphi_{ab}=E_{ba}-E_{ab}$, $u\wedge v = vu^{\mathsf T}-uv^{\mathsf T}$, $\Pi_\alpha=\omega_\alpha\omega_\alpha^{\mathsf T}$, $t_{\alpha\beta}=\operatorname{tr}(\Pi_\alpha\Pi_\beta)$, $A=\operatorname{span}\{\omega_1,\dots,\omega_5\}$, $W=\lambda(\Pi_A-\Pi_{A^\perp})=\lambda(2\Pi_A-\mathrm{Id})$ with $\lambda=1/\sqrt{10}$. I verified the two useful identities in these conventions before using them: $\langle u\wedge v,\,x\wedge y\rangle=\det\big([u\,v]^{\mathsf T}[x\,y]\big)$, and $R_{ijkl}=\langle W\varphi_{ij},\varphi_{kl}\rangle$ gives $R_{ijkl}=\omega_{ij}\omega_{kl}$ for $W=\omega\otimes\omega$, so $\mathrm{Ric}=\sum_\alpha\lambda_\alpha\omega_\alpha\omega_\alpha^{\mathsf T}$ and the Bianchi expression is the Pfaffian. Givens 1 and 2 are therefore correct as stated.

## Hypothesis inventory

What I took from the brief without re-deriving: only L201 (given 3), and I use it in the weak direction alone (a non-integer trace makes a *configuration* non-coordinate), which is elementary anyway. Given 4 I re-derived. Everything else below I derived or computed.

What I did **not** assume: that the claim's chosen eigenbasis is the only decomposable orthonormal eigenbasis of $W$. That assumption is where the claim fails, and it is not stated in the brief.

Tooling checked before starting: `python3` 3.9.6, `numpy` 2.0.2, `scipy` 1.13.1, `mpmath` 1.3.0, `sympy` 1.14.0. Nothing was missing.

Footing: analysis-only, with screening permitted. The three search-shaped runs below (items 3 and 4) each served to **exhibit** an object that I then verified by exact or 70-digit linear algebra, which is the direction in which numerics are allowed to settle anything. The decisive frame in section 3 was in the end obtained without any search at all.

---

## 1. Rebuilding the object from the file

The recipe in the brief says "column-major", but the code it gives, `v[10i:10i+10].reshape(5,2)`, is numpy's default row-major. Row-major is the correct reading: it reproduces every reported figure, and Fortran order reproduces none of them (isotropy residual $1.79$, off-diagonal $0.52$). I report the wording as an error and the code as right.

| Figure | Reported | Reproduced |
|---|---|---|
| $\lVert\sum\Pi_\alpha-2\,\mathrm{Id}\rVert$ | $2.5\times10^{-11}$ | $2.4662\times10^{-11}$ |
| $\max_{i\neq j}\lvert\langle\omega_i,\omega_j\rangle\rvert$ | $6.0\times10^{-12}$ | $5.9740\times10^{-12}$ |
| $\lVert\omega_i\rVert^2$ | $1$ | $1$ for all five |
| $\max$ $4\times4$ Pfaffian | $2.8\times10^{-17}$ | $2.7756\times10^{-17}$ |
| integrality defect | $0.498510$ | $0.4985097557$ |

All five reproduce. The remaining reported pair ($4.8\times10^{-24}$ for $A^\perp$ against $4.1\times10^{-25}$ for the pentagon) are an optimiser's residuals whose procedure the brief does not fix, so I cannot reproduce the numbers. Section 4 settles the underlying question exactly instead.

One thing the brief's figures conceal, and which turned out to be the key to the whole object: the trace multiset is irregular, not the half-integral pattern that a defect of $0.4985$ suggests. Sorted, it is
$$\{0.028968,\ 0.029141,\ 0.058109,\ 0.469542,\ 0.472349,\ 0.498510,\ 0.501490,\ 0.941891,\ 1,\ 1\},$$
with total $5$ and every row sum $2$, as $\operatorname{tr}\big((\sum\Pi)^2\big)=20$ and $\sum_\alpha S_\alpha=0$ for $S_\alpha=\Pi_\alpha-\tfrac25\mathrm{Id}$ require. Two of the ten traces are exactly $1$, namely $t_{14}$ and $t_{35}$, which says two pairs of planes meet in a line.

## 2. Is it really in $\mathcal W_5$?

Yes, and the derivational argument the brief offers is valid in all three parts. I built $R_{ijkl}=\langle W\varphi_{ij},\varphi_{kl}\rangle$ from the operator and checked the definitions directly rather than through the givens' shortcuts.

In double precision on the recorded witness: $\operatorname{tr}_{\Lambda^2}W = 5.6\times10^{-17}$, $\sum_{ij}R_{ijij}=1.4\times10^{-16}$, $\lVert\mathrm{Ric}\rVert = 2.6\times10^{-16}$, and $\max_{ijkl}\lvert R_{ijkl}+R_{iklj}+R_{iljk}\rvert = 2.8\times10^{-17}$. Pair symmetry $R_{ijkl}=R_{klij}$ is exact by construction. Independently, projecting $W$ onto the 35-dimensional space $\mathcal W_5$, built as the kernel of the Ricci and Bianchi constraint map on $\mathrm{Sym}(\Lambda^2\mathbb R^5)$ (rank 20 of 55, so $\dim\mathcal W_5 = 35$), leaves $\lVert W-\Pi_{\mathcal W_5}W\rVert = 4.0\times10^{-16}$.

On the exact rational configuration of section 3 the same three checks are exactly zero in `sympy`: scalar curvature $0$, Ricci the zero matrix, and all $625$ Bianchi components $0$. The spectrum is exactly $\pm1$ with multiplicities $5,5$ for $W/\lambda$, since $(W/\lambda)^2=\mathrm{Id}$ and $\operatorname{tr}(W/\lambda)=0$, and $\lVert W\rVert^2 = 10\lambda^2 = 1$, which is what fixes $\lambda=1/\sqrt{10}$.

The derivation is valid for a reason worth recording, because it is also the reason the claim fails: Bianchi holds **term by term** over a decomposable eigenbasis, and Ricci-flatness follows from isotropy of the plane projections, so both conditions are conditions on the *collection of planes*, while $W$ itself depends only on the *subspace* $A$ they span.

## 3. Is it really non-coordinate? No. $W$ is coordinate-diagonal, and I give the frame

This is where the claim breaks, and the break is logical before it is numerical.

**The gap.** $W$ has eigenvalue $+\lambda$ with multiplicity five, so every orthonormal basis of $A$ is an eigenbasis. L201 and the integrality defect concern one such basis. "Coordinate-diagonal in some frame" is a property of $W$, equivalently of the subspace $A$: it holds exactly when $A$ is spanned by five coordinate bivectors $\varphi_{ab}$ of some orthonormal frame. Ricci-flatness makes those five edges a 2-regular graph on five vertices, and the only 2-regular simple graph on five vertices is $C_5$, so the property is precisely "$A$ is the span of the five edge bivectors of a 5-cycle of some frame". Nothing about one non-coordinate basis of $A$ bears on this.

**The gap is not hypothetical.** Take any frame, set $c^2+s^2=1$, and put
$$\omega_1 = e_1\wedge e_2,\quad \omega_2 = e_2\wedge e_4,\quad \omega_4 = e_1\wedge e_3,\quad \omega_3 = (c\,e_3-s\,e_4)\wedge e_5,\quad \omega_5 = (s\,e_3+c\,e_4)\wedge e_5 .$$
With $(c,s)=(3/5,4/5)$ this is rational, and `sympy` verifies in exact arithmetic: $\sum_\alpha\Pi_\alpha = 2\,\mathrm{Id}_5$ exactly, the Gram matrix of the five forms is exactly $\mathrm{Id}_5$, all five $4\times4$ Pfaffians of each $\omega_\alpha$ are exactly $0$, and the pairwise traces are
$$t_{12}=t_{14}=t_{35}=1,\quad t_{13}=t_{15}=t_{24}=0,\quad t_{23}=t_{45}=\tfrac{16}{25},\quad t_{25}=t_{34}=\tfrac9{25},$$
an integrality defect of $9/25$ with four non-integral traces, four commutators $\lVert[\Pi_\alpha,\Pi_\beta]\rVert^2 = 288/625$, and yet $A = \operatorname{span}\{e_1\wedge e_2,\ e_2\wedge e_4,\ e_1\wedge e_3,\ e_3\wedge e_5,\ e_4\wedge e_5\}$, the span of the 5-cycle $1$–$2$–$4$–$5$–$3$–$1$. The parameter $(c,s)$ drops out of $A$ entirely. So here is an orthonormal decomposable configuration with a large integrality defect whose $W$ is coordinate-diagonal in the frame it was written in. The inference "defect $>0$, therefore $W$ is not coordinate-diagonal" is invalid.

**The mechanism, in one sentence.** In a 5-cycle every vertex has degree $2$, and for two edges sharing vertex $a$, $\operatorname{span}\{\varphi_{ab},\varphi_{ac}\} = f_a\wedge\langle f_b,f_c\rangle$ consists entirely of decomposable forms. Rotating within such a pair therefore keeps the basis orthonormal and decomposable, leaves $A$ and $W$ untouched, and moves the pairwise traces off the integers. At $n=5$ this applies to *every* coordinate two-eigenvalue point, so the integrality-defect test can never certify non-coordinacy of $W$ at $n=5$.

**The witness is exactly this.** I did try hard for a frame, by three routes, and all three succeed.

*(a) A classification, which is the route that decides it.* Suppose two of the five planes meet in a line. Normalise $P_1=\langle e_1,e_2\rangle$, $P_4=\langle e_1,e_3\rangle$, which $\Lambda^2$-orthogonality permits, since a shared line forces the complements to be orthogonal. Isotropy at $e_1$ reads $2 = (\sum\Pi)_{11}$ and $\Pi_1+\Pi_4$ already supplies $2$, so $P_2,P_3,P_5\perp e_1$, and their $\Lambda^2$-orthogonality to $\omega_1,\omega_4$ becomes automatic. What is left is three 2-planes in $V=\langle e_2,e_3,e_4,e_5\rangle$, pairwise $\Lambda^2$-orthogonal, with $\sum_k\Pi_k=\operatorname{diag}(1,1,2,2)$. Writing a unit decomposable form in $\mathbb R^4$ as $\omega=\tfrac12(J_a+K_b)$ with $J,K$ left and right quaternion multiplication and $a,b\in S^2$, one has $\Pi=\tfrac12(\mathrm{Id}-J_aK_b)$, $\langle\omega,\omega'\rangle=\tfrac12(a\!\cdot\!a'+b\!\cdot\!b')$ and $t = 1+(a\!\cdot\!a')(b\!\cdot\!b')$. Since $(a,b)\mapsto J_aK_b$ is bilinear and $\{\tfrac12 J_iK_j\}$ is orthonormal in $\mathrm{Sym}_0(\mathbb R^4)$, isotropy becomes the rank-one condition $\sum_k a_kb_k^{\mathsf T}=a_0b_0^{\mathsf T}$ and orthogonality becomes $b_k\!\cdot\!b_l=-(a_k\!\cdot\!a_l)$. Taking Frobenius norms gives $p^2+q^2+r^2=1$ for $p,q,r$ the off-diagonal entries of the $a$-Gram, and rank one forces $\det(\text{Gram})=1-(p^2+q^2+r^2)+2pqr=2pqr=0$. So one of them vanishes, say $r=0$, all three $a_k$ lie in a plane, and the solution is the explicit one above up to the residual gauge. Carrying the residual gauge through, the general member is the explicit configuration with two rotations applied, one mixing $\{\varphi_{12},\varphi_{13}\}$ by an angle $\chi$ and one mixing $\{\varphi_{35},\varphi_{45}\}$ by an angle $\psi$, and $A$ is a coordinate pentagon span for every $(\chi,\psi)$.

That closed form predicts every trace of the file witness from two of them. With $C=\cos^2\chi=t_{12}$, $S=\sin^2\chi=t_{24}$, $c^2=\cos^2\psi=t_{25}$, $s^2=t_{23}$, the prediction is $t_{13}=c^2S$, $t_{15}=s^2S$, $t_{34}=c^2C$, $t_{45}=s^2C$. Against the 80-digit polished solution all four agree to better than $10^{-46}$, and $C+S=1$, $c^2+s^2=1$ to the same accuracy. The witness is the member with $\cos^2\chi = 0.05810875698752544918705\ldots$ and $\cos^2\psi = 0.50149030321124648538973\ldots$

*(b) A search-free construction of the frame.* Read off the frame from the witness by linear algebra alone: $f_1 = P_1\cap P_4$, $U=(P_1+P_4)\ominus f_1$, $V=U^\perp\cap f_1^\perp$, $u=P_2\cap U$, $v_4=P_2\cap V$, $u'$ the unit vector of $U$ orthogonal to $u$, and $f_5=P_3\cap P_5$. At 70 digits every one of those intersections has the predicted dimension, $(f_1,u,u',v_4,f_5)$ is orthonormal to $7.9\times10^{-61}$, and the five coordinate bivectors $\varphi_{12},\varphi_{13},\varphi_{24},\varphi_{35},\varphi_{45}$ of that frame lie in $A$ with $\lVert(\mathrm{Id}-\Pi_A)\varphi\rVert \le 1.07\times10^{-60}$. Five orthonormal vectors inside a 5-dimensional space span it, so $A$ is that pentagon span and $W$ is diagonal there. Their edge set is 2-regular and their pairwise traces are all in $\{0,1\}$, as L201 requires of a coordinate configuration.

*(c) Two independent numerical searches, as cross-checks.* Minimising over $S^4$ the sum of the two smallest eigenvalues of $\Pi_{A^\perp}$ restricted to $x\wedge\mathbb R^5$ returns exactly five directions with a 2-dimensional intersection, and they are mutually orthogonal to $10^{-8}$. Gauss-Newton on the ten parameters of $g\in SO(5)$, requiring $\Pi_{A^\perp}\varphi^g_{ab}=0$ on the resulting five edges, converges to residual $6.8\times10^{-16}$ with $\max\lvert\text{off-diagonal of }W\rvert = 1.6\times10^{-16}$, all ten diagonal entries $\pm1/\sqrt{10}$, and principal cosines between $A$ and the coordinate span equal to $1$ to $10^{-14}$. The frame it finds agrees with (b) up to column order and sign.

The two exact traces $t_{14}=t_{35}=1$ are what makes the classification apply, and they are exact: they stay $1$ to 70 digits through the polish of section 5, and the intersections $P_1\cap P_4$ and $P_3\cap P_5$ come out 1-dimensional.

## 4. Is $A^\perp$ genuinely decomposable?

Yes, exactly, and the residual $4.8\times10^{-24}$ is an artefact of fitting rather than a defect. Once the frame of section 3 is in hand, $A^\perp$ is the span of the five complementary coordinate bivectors $\varphi_{14},\varphi_{15},\varphi_{23},\varphi_{24},\varphi_{35}$ of that same frame, whose edge set is again 2-regular, the complementary 5-cycle. Each is a single wedge $f_a\wedge f_b$, so each is decomposable with all five $4\times4$ Pfaffians identically zero, not merely small. Numerically in double precision from the polished frame: $\lVert\Pi_A\varphi\rVert \le 1.7\times10^{-16}$ for each, every $\lVert\varphi\rVert^2=1$, $\max$ Pfaffian $5.6\times10^{-17}$, Gram deviation from $\mathrm{Id}_5$ equal to $4.3\times10^{-16}$, $\lVert\sum\Pi-2\,\mathrm{Id}\rVert = 1.2\times10^{-15}$, and all ten of its pairwise traces exactly in $\{0,1\}$. So $A^\perp$ is a coordinate pentagram, and the claim's observation that it admits an orthonormal decomposable basis is true for the strongest possible reason.

## 5. Precision: does the defect move?

It does not, and I record this as a confirmation of the claim's numerics even though the conclusion drawn from them does not follow.

Gauss-Newton in double precision on the 40 constraints (15 Gram, 10 wedge-orthogonality, 15 isotropy) in 50 unknowns drives $\lVert r\rVert$ from $2.14\times10^{-11}$ to $2.19\times10^{-15}$ while the traces move only in the eighth digit. Continuing in `mpmath` at 80 digits with a Levenberg-regularised minimum-norm step, the residual falls quadratically, $8.5\times10^{-31}$, then $1.3\times10^{-61}$, then $4.83\times10^{-81}$, and the traces are then stable to 40 digits:
$$t_{12}=0.05810875698752544918705281468894488504978,\qquad t_{23}=0.498509696788753514610269311046806071622 .$$
The defect is $0.4985096968$, a shift of $6\times10^{-8}$ from the value in the file, which is the size of the file's own $10^{-11}$ isotropy error and no more. The nearby exact solution is not the pentagon and is not coordinate *as a configuration*.

How firmly does that establish an exact solution? The Jacobian at the polished point has rank 33 of $40\times50$, with $\sigma_{33}=0.239$, so $\lVert J^{+}\rVert\le4.2$ on the range, the constraints are quadratic so the second derivative is constant and modest, and quadratic Newton convergence to $4.8\times10^{-81}$ then places an exact zero of the 33 independent constraints within about $4\times10^{-80}$ of the computed point, moving the traces by at most $10^{-79}$. The remaining 7 residual components are dependent at the solution and are satisfied to $5\times10^{-81}$. I did not close that last step into a Newton-Kantorovich theorem, because section 3 makes it unnecessary: the exact rational configuration there exhibits the same phenomenon in exact arithmetic.

Nullity 33 also fixes the local geometry: nullspace dimension $17$, gauge dimension $15$ (ten for $O(5)$, one $O(2)$ per block), so two moduli, matching the two angles $(\chi,\psi)$ of the closed form in section 3 and confirming that the classification found the whole component.

## 6. Is it a rotation of the pentagon?

As an operator, yes. As a configuration of five labelled planes, no. Both halves matter, and the claim conflates them.

| Invariant | coordinate pentagon | file witness |
|---|---|---|
| sorted pairwise traces $t_{\alpha\beta}$ | $\{0,0,0,0,0,1,1,1,1,1\}$ | $\{0.0290,0.0291,0.0581,0.4695,0.4723,0.4985,0.5015,0.9419,1,1\}$ |
| spectrum of the trace Gram $(t_{\alpha\beta})$ | $\{0.3820,0.3820,2.6180,2.6180,4\}$ | $\{0.4754,0.9999,1.9387,2.5859,4\}$ |
| $\operatorname{rank}\operatorname{span}\{\Pi_\alpha\}$ | $5$ | $5$ |
| Gram of the $\omega_\alpha$ | $\mathrm{Id}_5$ | $\mathrm{Id}_5$ |
| $\max\lVert[\Pi_\alpha,\Pi_\beta]\rVert$ | $0$ | $0.7071$ |
| the operator $W$ | pentagon point | $O(5)$-conjugate to it |

The first two rows and the fifth separate the configurations, and the fifth gives the cleanest search-free proof that the recorded *basis* is not coordinate: coordinate projections commute, and $\lVert[\Pi_\alpha,\Pi_\beta]\rVert$ is conjugation-invariant, so a value of $0.7071$ excludes every frame at once. Equally, $t_{\alpha\beta}$ is an $O(5)$ invariant which for coordinate planes counts shared axes and so lies in $\{0,1,2\}$, and $0.0581$ does not. The last row is the one that answers the claim: since $A$ is a 5-cycle span in the frame of section 3 and any two 5-cycles on five labelled vertices differ by a permutation, $W$ lies in the $O(5)$ orbit of the coordinate pentagon's $W$.

## 7. What is its $\theta$?

Calibrating the sharp product by $\mathrm{Id}^{\#}=(n-2)\,\mathrm{Id}$, which fixes $M^{\#}_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\epsilon}c_{\beta\delta\zeta}M_{\gamma\delta}M_{\epsilon\zeta}$ with $c_{\alpha\beta\gamma}=\langle[\varphi_\alpha,\varphi_\beta],\varphi_\gamma\rangle$:

- $\operatorname{tr}(W^3)=0$ exactly, forced by the spectrum $\pm\lambda$ with equal multiplicities.
- $\langle W,W^{\#}\rangle=0$ exactly. In an eigenbasis this is $\tfrac{\lambda^3}{2}\sum_{\alpha\beta\gamma}c_{\alpha\beta\gamma}^2\varepsilon_\alpha\varepsilon_\beta\varepsilon_\gamma$, and `sympy` evaluates that sum to exactly $0$ on the rational configuration. The structural reason is that $c_{\alpha\beta\gamma}\ne0$ only on triangles of $K_5$, and of the ten triangles five carry two pentagon edges and one pentagram chord while five carry one edge and two chords, so the sign products cancel five against five.
- Hence $P(W)=0$ and, since $\lVert W\rVert=1$, $\theta(W)=0$ exactly, under every rescaling of the sharp product. This is well below $\theta_0(5)=\sqrt{24}/5\approx0.9798$ and $\sqrt{3/2}\approx1.2247$.

It **is** a critical point of $P$ on the unit sphere of $\mathcal W_5$. Euler's relation gives multiplier $3P(W)=0$, so criticality is $\Pi_{\mathcal W_5}(W^2+W^{\#})=0$, and in fact both terms vanish separately: $\lVert\Pi_{\mathcal W_5}(W^2)\rVert=1.0\times10^{-16}$ (immediate, since $W^2=\tfrac1{10}\mathrm{Id}$ and the identity is the constant-curvature direction, orthogonal to $\mathcal W_5$) and $\lVert\Pi_{\mathcal W_5}(W^{\#})\rVert=1.2\times10^{-16}$, total $1.9\times10^{-16}$. The coordinate pentagon gives $1.9\times10^{-17}$ for the same quantity, as it must, being the same point up to rotation. So this is a degenerate critical point at level zero, which is where the pentagon already sat.

## 8. Does it reach beyond $n = 5$?

There is no operator-level refutation at $n=5$ to propagate, so the question as posed has no content for $n\ge6$ or $n\ge12$. Two positive statements can be made in its place.

The basis-level phenomenon propagates everywhere, and trivially. Whenever $A$ is spanned by coordinate bivectors of some frame and two of those edges share a vertex $a$, the pencil $f_a\wedge\langle f_b,f_c\rangle$ is entirely decomposable, so rotating inside it produces a non-coordinate orthonormal decomposable eigenbasis of the same $A$ with non-integral pairwise traces. Ricci-flatness makes the edge set $\tfrac{2a}{n}$-regular, so as soon as that degree is at least $2$ such a shared vertex exists. The consequence for the programme is the useful one: the integrality-defect test certifies nothing about $W$ at any $n$, not only at $n=5$.

Had the claim stood, its natural reach would have been $n\equiv0\bmod 5$ and a family of block constructions besides. For two eigenvalues with $\lvert A\rvert=a$ the conditions are exactly $\sum_A\Pi=\tfrac{2a}{n}\mathrm{Id}_n$ and $\lambda_-/\lambda_+=-a/(\binom n2-a)$, with no further arithmetic obstruction, and combining an $n=5$ block with a biregular mixed set and a regular coordinate graph on the complement solves them at $n=8$ ($r=3$, $s=5$, $d=0$, $a=20$, $\tfrac{2a}n=5$) and at $n=10$ ($r=s=k$, $d=2$). That machinery is intact and is worth keeping for whatever object eventually needs it.

## 9. The $\kappa = 1$ theorem

No conflict. The witness has $\sum_\alpha\Pi_\alpha = 2\,\mathrm{Id}_5$, so $\kappa=\tfrac{2a}{n}=\tfrac{2\cdot5}{5}=2$, confirmed at $10^{-11}$ in the file and $10^{-81}$ after polish. $\kappa=1$ would require $a=n/2=5/2$, which is not an integer, so $\kappa=1$ indeed never occurs at $n=5$ and the theorem has no purchase here. Consistently, the witness's planes are not mutually orthogonal: four of its traces exceed $0.46$ and two equal $1$, which $\kappa=2$ permits, while the $\kappa=1$ conclusion of mutual orthogonality would demand all ten traces $0$.

## 10. What would make this round wrong

- **The frame could be an artefact of round-off.** Ruled out three ways. The construction in 3(b) is exact linear algebra at 70 digits on a solution whose own residual is $4.8\times10^{-81}$, and it lands at $1.07\times10^{-60}$. An independent 10-parameter Gauss-Newton in double precision lands at $1.6\times10^{-16}$ with principal cosines $1$. And the exact rational configuration of 3 exhibits the same phenomenon in `sympy` with zero arithmetic error.
- **The trace-$1$ pairs could be spurious, collapsing the classification.** Ruled out: $t_{14}$ and $t_{35}$ are $1$ to 70 digits after polish, and the corresponding plane intersections compute as 1-dimensional.
- **The classification could have missed a branch.** It covers configurations in which some pair of planes meets in a line. Within that case the derivation is complete: $p^2+q^2+r^2=1$ and $2pqr=\det(\text{Gram})=0$ leave one free angle, the residual gauge supplies the second, and the resulting two moduli match the Jacobian nullity $17-15=2$ measured at the witness. The witness has two such pairs, so it lies in the branch covered.
- **"Coordinate-diagonal" could have been intended to mean something narrower**, such as "the given eigenbasis is a coordinate basis". Under that reading the claim is true of this object but empty, because a five-fold degenerate eigenvalue leaves the eigenbasis undetermined up to $O(5)$, and section 3 shows the coordinate pentagon itself has non-coordinate decomposable eigenbases. Either way the stated consequence about two-eigenvalue critical points does not follow.
- **The $\theta$ convention could be wrong.** I calibrated it by $\mathrm{Id}^{\#}=(n-2)\mathrm{Id}$ and also reported $\theta$ under four other scalings of the sharp product. It is $0$ under all of them, and $0$ for the coordinate pentagon too, so the comparison with $\theta_0(5)$ does not turn on the convention.

## What survives, and what is open

Intact: the object is in $\mathcal W_5$; the recorded five planes are orthonormal, decomposable and isotropic to $4.8\times10^{-81}$; the integrality defect is real; the recorded configuration is not coordinate; $A^\perp$ has an orthonormal decomposable basis; $\theta=0$ and $W$ is a critical point of $P$ on the unit sphere; and the brief's givens 1, 2 and 4 are correct as stated.

Open, and untouched by this witness: whether an $n=5$ configuration exists in which **no** pair of planes meets in a line, that is with all ten traces strictly below $1$, and whether such a configuration's span would be non-coordinate. The classification in section 3 says nothing about that case. That is the only route by which the statement "every two-eigenvalue critical point of the decomposable locus is coordinate-diagonal" could still fail at $n=5$, and settling it needs a derivation rather than a witness, since the invariant that would decide it is a property of the subspace $A$ and not of any basis of it.

## Verdict

**REFUTED.** The witness is not a counterexample. Its $W$ is coordinate-diagonal in a frame that the witness's own data determines by linear algebra, and it lies in the $O(5)$ orbit of the coordinate pentagon. The claim's argument fails at the step where L201, a statement about a configuration of planes, is applied to a statement about an operator with a five-fold degenerate eigenvalue: the defect measures the basis that was recorded, and every coordinate two-eigenvalue point at $n=5$ has such bases. The statement the claim set out to refute stands unrefuted.
