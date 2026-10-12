# Verifier v247, Lemma L54: the phi- and psi-diagonals of the second-kind operator, the diagonal of M, the two sums, Schur, the per-frame use of Lemma L94, rigidity at t_F = 2, the vector equality, the landscape form, and the Lean statement

The brief ([BRIEF_L54.md](BRIEF_L54.md)) was read cold. No numerical work was done, every value is exact, and no scripts were written. Log: [agent_logs/verify-L54-v247.log](../agent_logs/verify-L54-v247.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | In the stated basis the $\varphi$-diagonal of $\mathring W$ is $K$ | CONFIRMED |
| 2 | The $\psi$-block of $\mathring W$ is $-K$ on $\mathbf 1^\perp$ | HYPOTHESIS-DEBT |
| 3 | The diagonal of $M$ in the pair basis of $\Lambda^2$ is $K$ | CONFIRMED |
| 4 | $\sum d_\varphi^2=t/2$ and $\sum d^2=\tfrac32 t$ | CONFIRMED AS ALGEBRA |
| 5 | Schur gives $\mu\succ d_\varphi$ and $\omega\succ d$ | CONFIRMED |
| 6 | Lemma L94 gives, per frame, $t_F\le2$ with equality exactly when $W$ is coordinate-diagonal in that frame | GAP |
| 7 | At $t_F=2$: $\mu^\downarrow=d_\varphi^\downarrow$ and $\omega^\downarrow=d^\downarrow$ | HYPOTHESIS-DEBT |
| 8 | At $t_F=2$: $\mu=d_\varphi$ and $\omega=d$ as vectors, by a Cauchy–Schwarz equality | HYPOTHESIS-DEBT |
| 9 | Passage B, the landscape form ("In the Nienhaus–Petersen–Wink basis", "at $t=2$ (coordinate-diagonal in some frame)") | REFUTED AS STATED |
| 10 | Passage G, the Lean statement, types what it says | CONFIRMED AS ALGEBRA |

**What the round should do:** replace the citation of L94 by a per-frame statement with its proof on file, write the $\psi$-block identification, the identity $\sum\omega^2=3\lVert M\rVert_F^2$ and the vector-equality route out, cite a filed source for the rigidity step, name $W$ Weyl and $n\ge4$ in the statement, correct Passage B's basis and frame scope, and correct two docstrings in the Lean file.

## 0. Conventions, fixed once

- $W$ is a Weyl tensor on $\mathbb R^n$: $W_{abcd}=-W_{bacd}=-W_{abdc}=W_{cdab}$, $W_{abcd}+W_{acdb}+W_{adbc}=0$, $\sum_aW_{abad}=0$ (the conventions typed in [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean#L63-L73)). Components are taken in the frame $F=(e_1,\dots,e_n)$. The sign is the one in which the round sphere has $R_{ijij}=1$ ([NPW](../references/nienhaus-petersen-wink-2022-betti-second-kind/README.md) Example 1.1), and $K_{ab}=W_{abab}$.
- $M$ is Li's (2.1), $\hat W(e_i\wedge e_j)=\tfrac12\sum_{k,l}W_{ijkl}\,e_k\wedge e_l$, written in the orthonormal pair basis $\{e_a\wedge e_b\}_{a<b}$, so $M_{(ab),(cd)}=W_{abcd}$ and $\lVert M\rVert_F^2=\sum_{a<b,\,c<d}W_{abcd}^2=\tfrac14\lvert W\rvert^2$, where $\lvert W\rvert^2=\sum_{abcd}W_{abcd}^2$. This agrees with normM2 in [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean#L90-L91). $\mu$ has length $N_1=n(n-1)/2$.
- $S^2$ carries the Frobenius inner product. $A:S^2\to S^2$ is $(Ah)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$ (Passage F). Li's (2.2), $\mathring R(e_i\odot e_j)=\sum_{k,l}R_{iklj}\,e_k\odot e_l$, read at source ([li-2112.08465.txt](https://arxiv.org/abs/2112.08465)), is the same map: its matrix entry $(kl),(ij)$ is $R_{iklj}$, and the two antisymmetries give $R_{iklj}=R_{kijl}$, which is Passage F's formula relabelled. NPW's operator $h\mapsto\sum R_{\cdot kl\cdot}h_{kl}$ (section 1) is the same map again. $\mathring W$ is the compression of $A$ to $S^2_0$ (Li, Remark 2.1), with spectrum $\omega$ of length $N=(n-1)(n+2)/2$.
- $\varphi_{ab}=(e_a\otimes e_b+e_b\otimes e_a)/\sqrt2$ for $a<b$, and $D_v=\operatorname{diag}(v)$ for a unit $v\perp\mathbf 1$. For any orthonormal basis $\{v_k\}$ of $\mathbf 1^\perp$, the set $\{\varphi_{ab}\}\cup\{D_{v_k}\}$ is an orthonormal basis of $S^2_0$: off-diagonal and diagonal supports are disjoint, and $N_1+(n-1)=N$.
- $t_F=\sum_{a\ne b}K_{ab}^2$ and $\kappa^2=\max_Ft_F$. Majorization and $x^\downarrow$ are as in the brief.
- Two consequences of tracelessness, used below. **(W1)** $(K\mathbf 1)_b=\sum_aW_{abab}=0$. **(W2)** $\sum_kW_{ikkj}=-\sum_kW_{ikjk}=0$, so $A$ annihilates the identity $g$.
- The quotations in Passages A, C, D, E and F match their cited lines, apart from link targets rewritten relative to verification/. Passage G is identical to [L54Statement.lean](../lean/HamiltonsCubic/Results/L54Statement.lean). Lean line numbers below are the file's own.

## Hypothesis inventory

| Source | Hypothesis | Holds for the object | Used by the proof | Stated |
|---|---|---|---|---|
| L54 | $W$ is Weyl | By programme convention | Yes: (W1) for $\sum d_\psi^2=t$ and for "restricted to $\mathbf 1^\perp$", (W1) and (W2) for $\sum\omega^2=3$ | Absent from Passages A to C. Typed as IsWeyl in [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean#L71-L73) |
| L54 | $\lVert M\rVert_F=1$ | Normalisation | Yes, in the rigidity | Passage F, bispectral.md line 15 |
| L54 | Fixed orthonormal frame $F$ | Yes | Yes, throughout | Passages A and C, absent from B |
| L54 | $\psi_k$ an eigenbasis of $K$ on $\mathbf 1^\perp$ | A choice | Only for $d_\psi=-\operatorname{spec}(K\vert_{\mathbf 1^\perp})$, hence $\sum d_\psi^2=t$ and the equality at $t_F=2$. Schur holds in every orthonormal basis | Passages A and C, absent from B |
| L54 | Range of $n$ | At $n\le3$, (W1) forces $K=0$, so $t_F=2$ is unreachable | The $t_F=2$ clauses are inhabited only for $n\ge4$ (section 7) | Unstated |
| L54 | $t_F=2$ | Hypothesis of the rigidity | Yes | Yes |
| Schur (half of Schur–Horn) | A real symmetric matrix in an orthonormal basis | $M$ is symmetric by pair symmetry. $\mathring W$ is a symmetric bilinear form on $S^2_0$ (Li, Remark 2.1) | Yes, both majorizations. Horn's converse half is unused | Named, source not filed under references/ |
| Lemma L94 | $W$ Weyl, the operator norm $\lVert M\rVert_F$ | Yes | Used in a per-frame form that its statement does not carry (section 6) | Heading only (Passage E). No proof quoted. [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean#L138-L142) carries a sorry over all frames |
| NPW Proposition 3.10 | Algebraic curvature tensor, orthonormal basis | Yes | The $\varphi_{ij}$ and $g(R\varphi_{ij},\varphi_{ij})=R_{ijij}$ | Read at source, [npw-2206.14218.pdf](https://arxiv.org/abs/2206.14218) page 19. The proof there is "a straightforward computation" |
| NPW staircase $\psi_k$ | As printed, $\psi_k=\bigl(-k\,e^k\otimes e^k+\sum_{l>k}e^l\otimes e^l\bigr)/\sqrt{(n-k+1)(n-k)}$ | The printed tensor has trace $n-2k$ and squared norm $(k^2+n-k)/((n-k+1)(n-k))$, so the coefficient intended is $-(n-k)$ | Replaced by the eigenbasis in L54, so the misprint does not reach the lemma | Source observation only |
| Li's convention | (2.2) at source | Matches Passage F (section 0) | Fixes the sign of both diagonals | Yes |

**Used but unstated:** $W$ Weyl through (W1) and (W2); $n\ge4$ for the $t_F=2$ clauses to be inhabited; the identity $\sum\omega^2=3\lVert M\rVert_F^2$ (section 7); the equality case of the strict Schur-convexity of $x\mapsto\sum x_i^2$ (section 7); the per-frame form of L94 (section 6).

The candidate "Weyl is used but unstated" was put through the protocol. (1) Passage A, bispectral.md line 480, "the $\psi$-block of $\mathring W$ is exactly $-K$ restricted to $\mathbf 1^\perp$". (2) For an algebraic curvature tensor with nonzero Ricci tensor, $(K\mathbf 1)_a=\mathrm{Ric}_{aa}$, so $K$ need not preserve $\mathbf 1^\perp$ and "restricted" has no meaning. (3) Charitably, the letter $W$ denotes a Weyl tensor throughout the programme, as [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean#L71-L73) types it. **Withdrawn as a defect of the lemma**, kept as an inventory item: the statement should name it.

## 1. The $\varphi$-diagonal of $\mathring W$ is $K$. CONFIRMED

Since $\varphi_{ab}\in S^2_0$, $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle=\langle A\varphi_{ab},\varphi_{ab}\rangle$. The components are $(A\varphi_{ab})_{pq}=(W_{pabq}+W_{pbaq})/\sqrt2$. Pairing with $\varphi_{ab}$ picks $(p,q)=(a,b)$ and $(b,a)$:

$$\langle A\varphi_{ab},\varphi_{ab}\rangle=\tfrac12\bigl[(W_{aabb}+W_{abab})+(W_{baba}+W_{bbaa})\bigr]=\tfrac12(K_{ab}+K_{ab})=K_{ab},$$

using $W_{aabb}=0$ and $W_{baba}=W_{abab}$. This holds for every algebraic curvature tensor and is independent of the choice of $\psi_k$. It is NPW Proposition 3.10 at source, in the same index convention. Passage F (line 75) states it without an argument in the brief, and the imported proposition carries it.

Falsifier sought: an algebraic curvature tensor with $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle\ne W_{abab}$. The contraction above is an identity, so none exists.

## 2. The $\psi$-block of $\mathring W$ is $-K$ on $\mathbf 1^\perp$. HYPOTHESIS-DEBT

**Located.** Passage A (line 480) and Passage C (line 1082) assert it. Passage D (line 259) is the argument Passage A points at, and it gives "checked at random Weyl tensors, $n=5,6,7$, to $2\times10^{-16}$". That is a floating-point check. Passages A to F carry no derivation, and NPW Proposition 3.10's $\psi$ formula concerns partial sums of Rayleigh quotients of the staircase, which is a different statement.

**What would have to be proved.** For all $u,v\perp\mathbf 1$, $\langle\mathring WD_u,D_v\rangle=-v^\top Ku$, together with $K\mathbf 1=0$ so that the compression $-PKP$ to $\mathbf 1^\perp$ is the restriction $-K\vert_{\mathbf 1^\perp}$.

**Screen (a classification of the candidate, recorded as a screen).** $(AD_u)_{ii}=\sum_kW_{ikki}u_k=-\sum_kK_{ik}u_k$, so $\langle AD_u,D_v\rangle=-v^\top Ku$ identically. No falsifier exists, and the debt is the missing written derivation.

**"Block" means the whole compression.** Passage D's $\Pi_{\mathrm{diag}}\mathring W\Pi_{\mathrm{diag}}=-K\vert_{\mathbf 1^\perp}$ is the operator statement, and it holds in every orthonormal basis of the diagonal subspace. In an eigenbasis it is diagonal with entries $-\lambda_k$. The lemma asserts nothing about the cross block $\langle A\varphi_{ab},D_v\rangle=-\sqrt2\sum_iW_{iaib}v_i$.

**Why an eigenbasis.** Schur's $\omega\succ d$ holds with any orthonormal $\{v_k\}$. The eigenbasis is what makes $d_\psi=-\operatorname{spec}(K\vert_{\mathbf 1^\perp})$, hence $\sum d_\psi^2=t$ and the norm equality at $t_F=2$. In another basis $\sum(v_k^\top Kv_k)^2\le t$, strictly when $K\vert_{\mathbf 1^\perp}$ is not diagonal there. Section 9 exhibits the strict case for the staircase at $n=4$. The remark "a hollow nonzero $K$ is never diagonal in it" carries no argument on file. The lemma's conclusions do not depend on it.

## 3. The diagonal of $M$ is $K$. CONFIRMED

$\langle M(e_a\wedge e_b),e_a\wedge e_b\rangle=W_{abab}=K_{ab}$ is the definition of $M$ in Li's (2.1) convention, whose sign is fixed at source by "if the eigenvalues of $\hat R$ are all greater than or equal to $\kappa$ then all the sectional curvatures are bounded below by $\kappa$". The record's "$\varphi$-basis of $\Lambda^2$" is a label for the pair basis $\{e_a\wedge e_b\}$ indexed like the $\varphi_{ab}$. The $\varphi_{ab}$ themselves live in $S^2$.

Falsifier sought: a convention in which $M=-W$ on $\Lambda^2$ would give $-K$ and reverse the majorization's content. The record's "$W$ acting on $\Lambda^2$" and normM2 fix the positive convention, so the candidate is withdrawn.

## 4. The sums. CONFIRMED AS ALGEBRA

- $\sum d_\varphi^2=\sum_{a<b}K_{ab}^2=\tfrac12\sum_{a\ne b}K_{ab}^2=t/2$, by symmetry and hollowness only.
- $\sum d_\psi^2=\sum\lambda_k^2$ over $\operatorname{spec}(K\vert_{\mathbf 1^\perp})$. By (W1) the spectrum of $K$ is $\{0\}\cup\operatorname{spec}(K\vert_{\mathbf 1^\perp})$, so $\sum d_\psi^2=\operatorname{tr}K^2=t$, and $\sum d^2=\tfrac32t$.
- **$K\mathbf 1=0$ is used, and it comes from the tracelessness of $W$.** Passages A to D never state it. "Restricted to $\mathbf 1^\perp$" presupposes it, and Passage D's "pure algebra" is correct given it.
- The algebra rests on claims 1 and 2 for the identification of $d$.

## 5. Schur. CONFIRMED

- $\mu\succ d_\varphi$: $M$ is a real symmetric $N_1\times N_1$ matrix, $d_\varphi$ is its diagonal in the orthonormal basis $\{e_a\wedge e_b\}$, and both vectors have length $N_1$.
- $\omega\succ d$: the Gram matrix of $\mathring W$ in the orthonormal basis $\{\varphi_{ab}\}\cup\{D_{v_k}\}$ is real symmetric $N\times N$, and $d$ has length $N_1+(n-1)=N$.
- Only Schur's half is used. Equal sums are automatic (trace): $\sum\mu=\sum_{a<b}K_{ab}=\tfrac12\mathbf 1^\top K\mathbf 1=0$, and $\sum d=0-\operatorname{tr}(K\vert_{\mathbf 1^\perp})=0$.
- Passage D's description "Cauchy interlacing on one compression, a single Rayleigh quotient" is a loose label for Schur's theorem. The conclusion drawn is Schur's, so no finding.
- **Schur (1923) has no source filed under references/.**

## 6. L94 per frame. GAP

**Located.** Passage A, bispectral.md line 480: "Lemma L94 gives $t_F\le2$, with equality exactly when $W$ is coordinate-diagonal in that frame". Passage C, results.md line 1082, repeats it. The given is Passage E, line 217: "$\kappa^2\le2\lVert M\rVert_F^2$, with equality exactly when $W$ is coordinate-diagonal in some frame".

**What Passage E supplies.**
- The bound, per frame: $t_F\le\max_{F'}t_{F'}=\kappa^2\le2$. Delivered.
- $t_F=2\Rightarrow$ coordinate-diagonal in $F$: E gives $\kappa^2=2$, hence coordinate-diagonal in some $F'$. The identification $F'=F$ is not delivered.
- Coordinate-diagonal in $F\Rightarrow t_F=2$: E gives $\kappa^2=2$, attained at some frame. Attainment at $F$ is not delivered.

**The two predicates differ, in closed form.** Take $n=4$ and the coordinate-diagonal Weyl tensor $W_{abcd}=K_{ab}(\delta_{ac}\delta_{bd}-\delta_{ad}\delta_{bc})$ with $K_{12}=K_{34}=\tfrac12$, $K_{13}=K_{24}=-\tfrac12$, $K_{14}=K_{23}=0$. It is an algebraic curvature tensor for every symmetric hollow $K$, and $\sum_aW_{abad}=\delta_{bd}(K\mathbf 1)_b=0$ here. $\lVert M\rVert_F^2=\sum_{a<b}K_{ab}^2=1$ and $t_F=2$. In the frame $F'$ with $f_1=(e_1+e_2)/\sqrt2$, $f_2=(e_1-e_2)/\sqrt2$, $f_3=e_3$, $f_4=e_4$:
$$M'_{(13),(23)}=W(f_1,f_3,f_2,f_3)=\tfrac12\bigl(K_{13}-K_{23}\bigr)=-\tfrac14.$$
So $M'$ has the off-diagonal entries $M'_{(13),(23)}=M'_{(23),(13)}=-\tfrac14$, and $t_{F'}=2\sum_{a<b}M'^2_{(ab),(ab)}\le2(1-\tfrac18)=\tfrac74<2$. At $(W,F')$ E's clause "coordinate-diagonal in some frame" is true while $t_{F'}<2$. E's equality clause therefore cannot be read per frame.

**Charitable reading.** The per-frame statement is true for every Weyl tensor (screen: $t_F=2\sum_{a<b}M_{(ab),(ab)}^2\le2\lVert M\rVert_F^2$, with equality exactly when $M$ is diagonal in $F$'s pair basis, which is coordinate-diagonality in $F$). L94's unquoted proof, reported "in one line" ([L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean#L10-L14)), may well be this. The brief quotes no proof. [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean#L138-L142) leaves the whole lemma as sorry and types the equality clause over all frames. [L94.lean](../lean/HamiltonsCubic/Results/L94.lean) proves arithmetic on $\kappa^2(\mathbb{CP}^m)$ only. **The candidate survives.** The step as written cites a statement that does not deliver it. Passage G's "proved there" is borne out neither in Lean nor in any quoted proof.

**What closes it.** A per-frame statement, $t_F\le2\lVert M\rVert_F^2$ with equality exactly when $W$ is coordinate-diagonal in $F$, with its proof on file, cited in place of E.

## 7. Rigidity at $t_F=2$. HYPOTHESIS-DEBT

**The chain.** At $t_F=2$: $\sum d_\varphi^2=1=\lVert M\rVert_F^2=\sum\mu^2$, and $\sum d^2=3$. Equal sums come from section 5. Then majorization with equal sums and equal $2$-norms gives equal sorted vectors. Each link was checked.

**Debt (a): $\sum\omega^2=3$ carries no argument in Passages A to F.** It appears as a normalisation in [L54Statement.lean](../lean/HamiltonsCubic/Results/L54Statement.lean#L70-L73). What must be proved: $\lVert\mathring W\rVert_F^2=3\lVert M\rVert_F^2$ for Weyl $W$. Screen:
- $A$ commutes with transposition, since $(Ah^\top)_{ij}=\sum W_{ilkj}h_{kl}$ and $W_{jkli}=W_{ilkj}$. So $A=A\vert_{S^2}\oplus A\vert_{\Lambda^2}$, and $\lVert A\rVert^2=\sum W_{iklj}^2=\lvert W\rvert^2$ on $T^2$.
- On $\Lambda^2$, Bianchi $W_{iklj}+W_{iljk}+W_{ijkl}=0$ gives $(Ah)_{ij}=-\tfrac12\sum W_{ijkl}h_{kl}$, so $\lVert A\vert_{\Lambda^2}\rVert^2=\tfrac14\lvert W\rvert^2$.
- Hence $\lVert A\vert_{S^2}\rVert^2=\tfrac34\lvert W\rvert^2$. By (W2), $Ag=0$ and $A$ is symmetric, so $\lVert\mathring W\rVert^2=\tfrac34\lvert W\rvert^2=3\lVert M\rVert_F^2$.
- No Weyl tensor falsifies it. The example of section 6 gives $\omega=(\tfrac12,-\tfrac12,0,0,-\tfrac12,\tfrac12,-1,1,0)$ and $\sum\omega^2=3$.

**Debt (b): the rigidity inference is a classical theorem invoked without citation.** It is the equality case of strict Schur-convexity of $x\mapsto\sum x_i^2$. No source is filed. [L54Statement.lean](../lean/HamiltonsCubic/Results/L54Statement.lean#L102-L105) leaves it as sorry. Mathlib has no majorization theory: [Birkhoff.lean](../lean/.lake/packages/mathlib/Mathlib/Analysis/Convex/Birkhoff.lean#L29) lists it under TODO, and [Spectrum.lean](../lean/.lake/packages/mathlib/Mathlib/Analysis/InnerProductSpace/Spectrum.lean#L47) mentions Schur–Horn in a remark. The theorem is true, so the debt is the citation.

Falsifier sought: vectors $x\succ y$ with $\sum x_i^2=\sum y_i^2$ and $x^\downarrow\ne y^\downarrow$. The classical equality case excludes them.

## 8. The vector equality at $t_F=2$. HYPOTHESIS-DEBT

**Located.** Passage A, line 480: "at $t_F=2$ the Cauchy–Schwarz equality already makes $M$ diagonal in the $\varphi$-basis and $\mathring W$ block-diagonal, whence $\mu=d_\varphi$ and $\omega=d$ as vectors." Passage C, line 1082, gives only "the Cauchy–Schwarz equality that makes $M$ diagonal".

**Which Cauchy–Schwarz.** None is named or written in Passages A to F. The inequality whose equality makes $M$ diagonal is $\sum_{a<b}M_{(ab),(ab)}^2\le\lVert M\rVert_F^2$. That is the per-frame L94 of section 6, and it is also absent.

**What would have to be proved.**
- $M$ diagonal in $F$'s pair basis at $t_F=2$ (section 6).
- For coordinate-diagonal $W$, $\mathring W$ block-diagonal with $\varphi_{ab}$ as eigenvectors and the $\psi$-block $-K\vert_{\mathbf 1^\perp}$. Screen: $(Ah)_{pq}=K_{pq}h_{qp}-\delta_{pq}\sum_kK_{pk}h_{kk}$, so $A\varphi_{ab}=K_{ab}\varphi_{ab}$ and $AD_v=-D_{Kv}$. The claim holds.
- Passage C's stated reason, $M$ diagonal, reaches only $\mu=d_\varphi$. For $\omega=d$ it is incomplete on its face.
- "As vectors" means that the basis diagonalises the operator, with $\omega$ labelled by it.

## 9. Passage B, the landscape form. REFUTED AS STATED

**Located.** results.md line 330: "In the Nienhaus–Petersen–Wink basis of $S^2_0$ … at $t=2$ (coordinate-diagonal in some frame), both majorizations are equalities."

**Failure (i), the literal basis.** Take the section 6 example in $F$ itself, with the NPW staircase $v_1=(-3,1,1,1)/\sqrt{12}$, $v_2=(0,-2,1,1)/\sqrt6$, $v_3=(0,0,-1,1)/\sqrt2$. This uses the coefficient $-(n-k)$, since the printed $-k$ gives tensors outside $S^2_0$. With $a=K_{12}$, $b=K_{13}$, $c=K_{14}$ and $a+b+c=0$:
- $v_1^\top Kv_1=\tfrac{2}{12}\bigl[-3(a+b+c)+(a+b+c)\bigr]=0$
- $v_2^\top Kv_2=\tfrac26(a-2b-2c)=a$
- $v_3^\top Kv_3=-a$

At $a=\tfrac12$ the staircase diagonal is $d_\psi^{\mathrm{st}}=(0,-\tfrac12,\tfrac12)$, so $\sum d^2=1+\tfrac12=\tfrac32<3=\sum\omega^2$ and $\omega^\downarrow\ne d^\downarrow$. The eigenbasis $(1,1,-1,-1)/2$, $(1,-1,1,-1)/2$, $(1,-1,-1,1)/2$, with eigenvalues $2a=1$, $2b=-1$, $2c=0$, gives $\sum d_\psi^2=2$ and equality.

**Failure (ii), the frame scope.** Take the same $W$, coordinate-diagonal in $F$, read in $F'$ of section 6. There $\sum d_\varphi(F')^2=t_{F'}/2\le\tfrac78<1=\sum\mu^2$, so $\mu^\downarrow\ne d_\varphi(F')^\downarrow$.

**Charitable reading.** Passage B abbreviates Passage C: "the NPW basis" means C's eigenbasis-modified basis, taken in the frame where $W$ is coordinate-diagonal, and $t$ means $t_F$. Passage A itself says NPW's staircase "will not serve", and B fixes no frame. **The candidate survives as a defect of the canonical wording.** Passages A and C are correct on these two points.

Passage C's closing sentence on "the vertex-matrix budget" and "the shared-frame coupling of Lemma L52" rests on material the brief does not quote. It was not checked, and no verdict is given on it.

## 10. The Lean statement. CONFIRMED AS ALGEBRA

**No finding:**
- Majorizes ([line 85](../lean/HamiltonsCubic/Results/L54Statement.lean#L85-L87)) is the brief's majorization: the maximum over $k$-subsets is the sum of the $k$ largest entries. A shared index type forces equal lengths.
- SameSorted is permutation equality.
- The one sorry ([lines 102–105](../lean/HamiltonsCubic/Results/L54Statement.lean#L102-L105)) is exactly the rigidity it names, and the statement is true.
- sum_offDiag_sq states $\sum_{a<b}K_{ab}^2=\tfrac12\sum K_{ab}^2$ from symmetry and hollowness, which is correct. I did not build it.
- sum_full_diag_sq and norms_match_at_two are arithmetic on hypotheses, and they disclose that the $\psi$ value is hypothesised.
- The binders of rigidity_at_t_two are jointly satisfiable ($\mu=d_\varphi$ with $\sum\mu^2=1$, $\omega=d$ with $\sum\omega^2=3$) and exclude nothing the lemma needs.
- Mathlib has no majorization, as the docstring says (section 7).

**Finding 10a, a docstring names a hypothesis that is absent.**
- (1) [Lines 44–46](../lean/HamiltonsCubic/Results/L54Statement.lean#L44-L46) say "t_F ≤ 2 is Lemma L94 … it is a named hypothesis with that provenance". The binders at [lines 187–194](../lean/HamiltonsCubic/Results/L54Statement.lean#L187-L194) are hschur_phi, hschur_full, ht : t = 2, hmu, hom, hdphi and hd.
- (2) No binder has the form $t\le2$. The theorem is the rigidity lemma applied twice with $t$ substituted, and L94 plays no role.
- (3) Charitably, the comment at [lines 188–189](../lean/HamiltonsCubic/Results/L54Statement.lean#L188-L189) reads ht as "L94 read at the equality case". Assuming $t=2$ is an assumption of the equality case, and L94's content does not enter it.
- Survives as a documentation defect. Relatedly, [line 40](../lean/HamiltonsCubic/Results/L54Statement.lean#L40) calls Schur "the one thing the brief allows into a binder", while hd and hom also carry the record's own unproved identities in binders. hd is disclosed at lines 47–49, and hom is presented as a normalisation.

**Finding 10b, the non-vacuity gloss.**
- (1) [Lines 213–219](../lean/HamiltonsCubic/Results/L54Statement.lean#L213-L219) say $K=\begin{pmatrix}0&1\\1&0\end{pmatrix}$ at $n=2$ "is exactly the equality case of L94".
- (2) At $n=2$ tracelessness gives $W_{1212}=\sum_aW_{a2a2}=0$, so every Weyl tensor vanishes, and this $K$ has row sums $1\ne0$. It is $K(F)$ of no Weyl tensor.
- (3) Charitably, the example witnesses only that a bare hollow symmetric matrix reaches $\sum K^2=2$, which is true.
- Survives as a gloss defect. The example proves a true statement.

## Standing items

**Item 2, quantifier order and scope.** Passages A and C are per-frame throughout and separate $t_F$ from $\kappa^2$. Passage E is over all frames. The per-frame use of an over-all-frames statement is section 6. Passage B loses the frame (section 9).

**Item 3, the boundary.**
- $n=4$: the section 6 example satisfies every claim exactly. $d_\varphi=\mu=(\tfrac12,-\tfrac12,0,0,-\tfrac12,\tfrac12)$, $d_\psi=(-1,1,0)$, $\sum d^2=3$, and $\omega=d$.
- Odd $n$: nothing in the argument depends on parity. At $n=5$ the same $K$ padded by a zero row and column is hollow, symmetric and null on $\mathbf 1$, and gives a coordinate-diagonal Weyl tensor with $t_F=2$. At $n=3$, (W1) forces $K=0$ ($K_{12}+K_{13}=K_{12}+K_{23}=K_{13}+K_{23}=0$), so the $t_F=2$ clauses are vacuous.
- $t_F=0$: $d=0$ and $\mu\succ0$ since $\sum\mu=0$. The eigenbasis is arbitrary and the rigidity is not invoked. No finding.
- $\ker W\ne0$: the $n=4$ example has zero entries in $\mu$ and a zero eigenvalue of $K$ on $\mathbf 1^\perp$. No step uses invertibility. No finding.

**Item 4, proven against stated.** Proven on file: claims 1 (by import), 3, 4 (given 1 and 2) and 5. Stated without an argument on file: the $\psi$-block identification, $\sum\omega^2=3\lVert M\rVert_F^2$, the rigidity citation, and the vector-equality route. Stated by a citation that does not deliver it: the per-frame equality of L94. The Lean file types the abstract rigidity with every geometric input in binders, which is what its "What is NOT typed" section says.

**Item 7, falsifiers.**

| Claim | Object that would falsify it | What was done |
|---|---|---|
| 1 | Algebraic curvature tensor with $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle\ne W_{abab}$ | Contraction by hand, and NPW 3.10 read at source. Excluded |
| 2 | Weyl $W$, $u,v\perp\mathbf 1$, with $\langle\mathring WD_u,D_v\rangle\ne-v^\top Ku$ | Contraction by hand. Excluded |
| 3 | A convention with $M=-W$ | Li (2.1) sign read at source. Excluded |
| 4 | Weyl $W$ with $K\mathbf 1\ne0$ | (W1). Excluded |
| 5 | Diagonal of a symmetric matrix outside the permutohedron of its spectrum | Schur's theorem, source not filed |
| 6 | Weyl $W$ and frame $F$ with $t_F=2$ but not coordinate-diagonal in $F$, or the converse | Excluded for the claim. The citation fails, as the $n=4$ pair $(F,F')$ shows |
| 7 | $x\succ y$, equal $2$-norms, $x^\downarrow\ne y^\downarrow$, or a Weyl $W$ with $\sum\omega^2\ne3$ | Classical equality case, and the norm identity screened. Excluded |
| 8 | Coordinate-diagonal Weyl $W$ with $\mathring W$ not block-diagonal | Closed form $Ah=K\circ h-\operatorname{diag}(K\operatorname{diag}h)$. Excluded |
| 9 | Staircase basis at $t_F=2$, or frame $F'$ | Exhibited at $n=4$. Found |
| 10 | A binder that excludes a needed case, or a sorry that differs from its name | Binders read. None found. Two docstring defects found |

[L54.lean](../lean/HamiltonsCubic/Results/L54.lean) was also opened. It carries rational arithmetic on $t/2+t$, and no verdict rests on it.

## Overall verdict: GAP

The statement of Passages A and C is not refuted: no Weyl tensor falsifies any of its claims, and the $n=4$ closed form satisfies each one. The proof on file has one link that does not follow from its citation, the per-frame equality of L94. It also has four debts: the $\psi$-block identification, $\sum\omega^2=3\lVert M\rVert_F^2$, a source for the rigidity step, and the vector-equality route. Passage B is refuted as stated, and the Lean file carries two docstring defects.
