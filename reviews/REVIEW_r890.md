# REVIEW_r890: the simplex bound as this record's per-index relation, its equality case, and what it caps

The brief was cold: I worked from the definitions and givens handed to me, from [Casazza and Fickus, arXiv:1708.08879](https://arxiv.org/abs/1708.08879) Theorem 5.1 read at first hand in [casazza-fickus-1708.08879.txt:370](https://arxiv.org/abs/1708.08879), and from nothing else in this repository. Every value below is exact: the specialisation $\frac{c(Mc-d)}{d(M-1)}\big|_{c=2,d=n}=\frac{2(2M-n)}{n(M-1)}$, the mean $\frac{2(\kappa-1)}{M-1}$ with $\kappa=2M/n$, the evaluation $\frac{4}{n+1}$ at $M=\binom n2$, the icosahedral $\sigma^2=\frac{Mc-d}{d(M-1)}=\frac15$ at $M=6,c=2,d=6$, and the common overlap $S_{\alpha\beta}=\frac45$ of the six-plane equality family in $\mathbb R^4$ constructed in section 6. Compute was used twice, both times as a screen of a claim I had already argued in closed form and each time finishing in seconds: the $\mathbb R^4$ equality family, and the corrected commutator identity of section 0a. Log: [review-r890-simplex.log](../agent_logs/review-r890-simplex.log).

## Claim table

| # | Claim under audit | Verdict | Reason |
|---|---|---|---|
| C1 | At $c=2$, $d=n$ the simplex bound reads $\max_{\alpha\ne\beta}S_{\alpha\beta}\ge\frac{2(2M-n)}{n(M-1)}$, and the per-index mean from (G1) with (G2) is the same expression, symbolic difference zero | **CONFIRMED** | Both sides equal $\frac{2(2M-n)}{n(M-1)}$ as rational functions of $M$ and $n$, an identity and not a coincidence at particular values |
| C2 | "The simplex bound of the fusion-frame literature **is** this record's per-index relation, read as max at least mean" | **REFUTED AS STATED** | Neither statement contains the other: (G3) needs no tightness while (G1) does, and (G1) is an equality per index, giving $M$ localised bounds plus $\min_{\beta\ne\alpha}S_{\alpha\beta}\le$ mean, which the single global inequality does not |
| C3 | "Equality in the simplex bound is **exactly** isotropy" | **REFUTED AS STATED** | Equality implies tightness and additionally equi-chordality. The coordinate basis at $n=4$ is tight with $\max S=1>\frac45$, so isotropy alone is not equality |
| C4 | The literature's optimal-packing criterion and this record's Ricci-flatness condition on a decomposable eigenbasis "are the same equation" | **REFUTED AS STATED** | Same defect as C3, and worse at the case the record cares about: at $M=\binom n2$ a $\Lambda^2$-orthonormal decomposable basis is tight **automatically** (section 5), so isotropy is vacuous there and all the content of equality sits in the equi-chordal half |
| C5 | The bound is a lower bound on the largest overlap, so it caps no multiplicity, and $S_{\alpha\beta}\le1$ is "too weak to bite at any $n>4$" | **CONFIRMED**, strengthened | $\frac{2(2M-n)}{n(M-1)}$ increases in $M$ to the limit $\frac4n$, so it never reaches $1$ for any $n\ge4$ and any finite $M$. Pairing it with $S\le1$ gives $M(4-n)\le n$, empty for every $n\ge4$ and at $n=3$ only the dimension count $M\le3$ |
| C6 | At $M=\binom n2$ the bound gives only $\max S\ge\frac4{n+1}$, "far below $1$" | **CONFIRMED AS ALGEBRA**, gloss **REFUTED** | $\frac4{n+1}$ is exact. The gloss reads the gap as slack in the bound, but at $n=4$ the bound is **attained** by a $\Lambda^2$-orthonormal decomposable basis of $\Lambda^2\mathbb R^4$ with every $S_{\alpha\beta}=\frac45$ (section 6), so $\frac45$ is the true value of $\max S$ there and the coordinate basis is simply not optimal |
| C7 | Six lines in $\mathbb C^3=\mathbb R^6$ from the icosahedron are equi-isoclinic tight with $\sum\Pi_\alpha=2\,\mathrm{Id}_6$ and $\cos^2=\frac15$, failing $\Lambda^2$-orthonormality | **CONFIRMED** | $\frac{Mc-d}{d(M-1)}=\frac{12-6}{6\cdot5}=\frac15$ and $\frac{Mc}d=2$, and the same values come out of the complex reading $M=6,c=1,d=3$. The failure of $\Lambda^2$-orthonormality is **forced**: $\Lambda^2$-orthonormality makes $\cos\theta_1\cos\theta_2=0$ for every pair, so an equi-isoclinic $\Lambda^2$-orthonormal family has $\sigma^2=0$ |
| C8 | (Implicit in the record's use, tested as item 5) $M=\binom n2$ with $\Lambda^2$-orthonormality forces $\kappa=n-1$ | **CONFIRMED** | $\sum_\alpha A_\alpha^2$ is the same operator for every orthonormal basis of $\mathfrak{so}(n)$, so it equals its coordinate-basis value $-(n-1)\mathrm{Id}_n$, giving $\sum_\alpha\Pi_\alpha=(n-1)\mathrm{Id}_n$ with no extra hypothesis. Consistent with (G2) |
| C9 | (Given, audited incidentally) $S_{\alpha\beta}=\lVert[\omega_\alpha,\omega_\beta]\rVert^2$ and $S_{\alpha\beta}\in[0,1]$ for distinct planes, and $S_{\alpha\beta}=1$ exactly at a shared line | **HYPOTHESIS-DEBT** | All three hold under $\Lambda^2$-orthonormality and fail without it. Two planes in $\mathbb R^4$ sharing $e_1$ with $S=\frac32$ break the range and the biconditional, and the correct identity is $\lVert[\omega_\alpha,\omega_\beta]\rVert^2=S_{\alpha\beta}-2\langle\omega_\alpha,\omega_\beta\rangle^2$ |

**One line the cycle can act on**: the specialisation is an exact identity and the $\sigma^2=\frac15$ identification is right, but "one statement" and "equality is exactly isotropy" both overreach, and the record's reading of $\frac4{n+1}$ as slack is wrong because that bound is attained at $n=4$ by a $\Lambda^2$-orthonormal decomposable basis whose $\max S$ is therefore $\frac45$ and not near $1$.

## 0. Conventions, fixed once

Quoted from the brief.

- $\mathbb R^n$ with its standard inner product, and $\Lambda^2\mathbb R^n$ with $\langle\cdot,\cdot\rangle$ normalised so that the $\varphi_{ij}=e_i\wedge e_j$ for $i<j$ are orthonormal. $N:=\binom n2=\dim\Lambda^2\mathbb R^n$.
- A **decomposable** $2$-form is $\omega=u\wedge v$. A unit decomposable $\omega$ determines a $2$-plane $P_\omega=\mathrm{span}(u,v)\subset\mathbb R^n$ and $\Pi_\omega$ is the orthogonal projection of $\mathbb R^n$ onto it.
- For two unit decomposable forms write $S_{\alpha\beta}:=\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)$. **Given:** $S_{\alpha\beta}=\lVert[\omega_\alpha,\omega_\beta]\rVert^2$ under the identification $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $S_{\alpha\beta}\in[0,1]$ for distinct planes, $S_{\alpha\beta}=1$ exactly when the two planes share a line, and $S_{\alpha\beta}=0$ exactly when they are orthogonal.
- A family $\{\omega_\alpha\}_{\alpha=1}^M$ of unit decomposable forms is **$\Lambda^2$-orthonormal** when $\langle\omega_\alpha,\omega_\beta\rangle=\delta_{\alpha\beta}$.

### 0a. A correction to the third bullet, needed before anything else is stated precisely

The $\mathfrak{so}(n)$ identification I use throughout sends $\omega=\sum_{i<j}c_{ij}e_i\wedge e_j$ to the antisymmetric $A(\omega)$ with $A_{ij}=c_{ij}$, under which $\langle\omega,\omega'\rangle=-\tfrac12\mathop{\mathrm{tr}}(A A')$ and, for a unit decomposable $\omega$ with $u,v$ orthonormal, $A=uv^{\!\top}-vu^{\!\top}$ and $\Pi_\omega=-A^2$. Both normalisations check on $\omega=e_1\wedge e_2$: $-\tfrac12\mathop{\mathrm{tr}}(A^2)=1$ and $-A^2=e_1e_1^{\!\top}+e_2e_2^{\!\top}$.

Writing $\theta_1,\theta_2$ for the principal angles between $P_\alpha$ and $P_\beta$, two standard facts fix everything: $S_{\alpha\beta}=\cos^2\theta_1+\cos^2\theta_2$, and $\langle\omega_\alpha,\omega_\beta\rangle=\pm\cos\theta_1\cos\theta_2$ (the latter because $\langle u_1\wedge u_2,v_1\wedge v_2\rangle=\det(\langle u_i,v_j\rangle)$, evaluated in principal-vector bases).

Three consequences, the third of which corrects the brief.

1. **$S_{\alpha\beta}\in[0,2]$ in general, and $[0,1]$ exactly under $\Lambda^2$-orthonormality.** Orthonormality forces $\cos\theta_1\cos\theta_2=0$, so one principal angle is right and $S_{\alpha\beta}=\cos^2\theta_1\in[0,1]$, with $S_{\alpha\beta}=1$ if and only if $\theta_1=0$, which is a shared line. Without orthonormality the range is $[0,2]$: take $P_1=\mathrm{span}(e_1,e_2)$ and $P_2=\mathrm{span}(e_1,\tfrac{e_2+e_3}{\sqrt2})$ in $\mathbb R^4$, which share $e_1$ and give $S=1+\tfrac12=\tfrac32$.
2. **"$S=1$ exactly at a shared line" also fails without orthonormality.** $P_1=\mathrm{span}(e_1,e_2)$ and $P_2=\mathrm{span}(\tfrac{e_1+e_3}{\sqrt2},\tfrac{e_2+e_4}{\sqrt2})$ have both principal angles at $\tfrac\pi4$, so $S=\tfrac12+\tfrac12=1$, while $P_1\cap P_2=0$.
3. **The commutator identity is $\lVert[\omega_\alpha,\omega_\beta]\rVert^2=S_{\alpha\beta}-2\langle\omega_\alpha,\omega_\beta\rangle^2$.** Expanding, $\lVert[A,B]\rVert^2=-\tfrac12\mathop{\mathrm{tr}}([A,B]^2)=\mathop{\mathrm{tr}}(A^2B^2)-\mathop{\mathrm{tr}}((AB)^2)=S_{\alpha\beta}-\mathop{\mathrm{tr}}((AB)^2)$, and $\mathop{\mathrm{tr}}((AB)^2)=\tfrac12\mathop{\mathrm{tr}}(AB)^2=2\langle\omega_\alpha,\omega_\beta\rangle^2$ for rank-two $A,B$. The two examples above confirm the correction numerically ($S=\tfrac32$ against $\lVert[\cdot,\cdot]\rVert^2=\tfrac12$ with $\langle\cdot,\cdot\rangle^2=\tfrac12$, and $S=1$ against $\tfrac12$ with $\langle\cdot,\cdot\rangle^2=\tfrac14$), and a screen over 1200 random plane pairs at $n=4,5,6,7$ agreed to $6\cdot10^{-16}$.

This is bookkeeping rather than a defect in the record's own use, because the record works inside $\Lambda^2$-orthonormality throughout, where the brief's three statements are all true. It matters for one thing only, and section 4 says where: the inequality $S\le1$ that the record pairs with the simplex bound is a consequence of $\Lambda^2$-orthonormality and not a general property of $2$-planes, for which the true bound is $S\le c=2$.

## Hypothesis inventory

| Hypothesis | Carried by | Holds for the object the record applies it to | Used by the argument |
|---|---|---|---|
| $\{U_j\}$ are $c$-dimensional subspaces of $\mathbb F^d$, $M\ge2$ | (G3) | Yes at $c=2$, $d=n$, $\mathbb F=\mathbb R$: the $P_\alpha$ are $2$-planes in $\mathbb R^n$ | Yes, and $M\ge2$ is needed for $M-1\ne0$ |
| Tightness $\sum_jP_j=\alpha I$ | **not** a hypothesis of (G3), see [casazza-fickus-1708.08879.txt:370](https://arxiv.org/abs/1708.08879) | Irrelevant to whether the bound holds | No, and this is the asymmetry that sinks C2 |
| Tightness $\sum_\alpha\Pi_\alpha=\kappa\,\mathrm{Id}_n$ | (G1), (G2) | Automatic at $M=\binom n2$ under $\Lambda^2$-orthonormality (section 5), and a genuine restriction for $M<\binom n2$ | Yes, essentially: (G1) has no content without it |
| $\Lambda^2$-orthonormality $\langle\omega_\alpha,\omega_\beta\rangle=\delta_{\alpha\beta}$ | (G1) as stated | Yes by construction in the record | **No** in (G1)'s own derivation, which needs only $\sum\Pi_\beta=\kappa\mathrm{Id}$ and $\mathop{\mathrm{tr}}(\Pi_\alpha^2)=\mathop{\mathrm{tr}}(\Pi_\alpha)=2$. It **is** needed for $S\le1$ (section 0a), for $\kappa=n-1$ at $M=N$ (section 5), and for $M\le\binom n2$ |
| Decomposability of each $\omega_\alpha$ | throughout | Yes | Yes: it is what makes $\Pi_\alpha$ a rank-two projection, so $\mathop{\mathrm{tr}}\Pi_\alpha^2=2$ |
| Equi-chordality, all $\mathop{\mathrm{tr}}(P_jP_{j'})$ equal | (G3)'s equality case | **Fails** for the coordinate basis at every $n\ge4$ | Yes, and its omission is the defect in C3 and C4 |
| Equi-isoclinicity $P_{j'}P_jP_{j'}=\sigma^2P_{j'}$ | the refinement quoted in (G3) | **Fails** for every $\Lambda^2$-orthonormal family with $\sigma^2>0$ (section 7) | Only in section 7, to check the icosahedral value |
| $\mathop{\mathrm{tr}}(P_jP_{j'})=\lVert\Phi_j^*\Phi_{j'}\rVert_{\mathrm{Fro}}^2$ | (G4) | Yes, basis-independent | Yes: it is the bridge from the literature's quantity to $S_{\alpha\beta}$ |
| $S_{\alpha\beta}\le1$ | the record's multiplicity argument | Yes **given $\Lambda^2$-orthonormality**, false in general | Yes in section 4, where the hypothesis it needs is one the record carries |

## 1. The specialisation, derived independently

Put $c=2$ and $d=n$ in (G3). The right-hand side is
$$\frac{c(Mc-d)}{d(M-1)}=\frac{2(2M-n)}{n(M-1)},$$
and by (G4) with $P_\alpha=\Pi_\alpha$ the left-hand side is $\max_{\alpha\ne\beta}\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=\max_{\alpha\ne\beta}S_{\alpha\beta}$. So the specialised bound is $\max_{\alpha\ne\beta}S_{\alpha\beta}\ge\frac{2(2M-n)}{n(M-1)}$, exactly as the record states it.

Now (G1) with (G2). For each fixed $\alpha$, $\sum_{\beta\ne\alpha}S_{\alpha\beta}=2(\kappa-1)$ and $\kappa=\frac{2M}n$, so
$$\sum_{\beta\ne\alpha}S_{\alpha\beta}=2\left(\frac{2M}n-1\right)=\frac{2(2M-n)}n,$$
and the mean over the $M-1$ partners of $\alpha$ is
$$\frac1{M-1}\cdot\frac{2(2M-n)}n=\frac{2(2M-n)}{n(M-1)}.$$

**The two expressions are equal, and the equality is an identity in $M$ and $n$**, not a coincidence at particular values: both are the same rational function, and the difference is identically zero on the whole domain $M\ge2$, $n\ge2$. C1 is **CONFIRMED**. Since a maximum over a finite set is at least the mean of that set, the specialised simplex bound follows from (G1) and (G2) alone, with no appeal to Theorem 5.1.

I note in passing that (G1)'s own derivation, as the brief gives it, uses the completeness relation and $\mathop{\mathrm{tr}}(\Pi_\alpha^2)=\mathop{\mathrm{tr}}(\Pi_\alpha)=2$ and nothing else. $\Lambda^2$-orthonormality appears in (G1)'s statement and does no work in its proof. That is inert rather than wrong, but a reader who assumes the hypothesis is load-bearing will draw the wrong conclusion about where the record's structure comes from.

## 2. Quantifiers: what each side controls, and what the record's reading discards

Write $m_\alpha:=\frac1{M-1}\sum_{\beta\ne\alpha}S_{\alpha\beta}$ for the per-index mean.

**(G3) controls one quantity**: a single inequality $\max_{\alpha\ne\beta}S_{\alpha\beta}\ge R$, where $R=\frac{2(2M-n)}{n(M-1)}$, with the max over all $\binom M2$ unordered pairs, and it holds for **every** family of $M$ two-planes in $\mathbb R^n$.

**(G1) controls $M$ quantities exactly**: for every $\alpha$, $\sum_{\beta\ne\alpha}S_{\alpha\beta}=2(\kappa-1)$, hence $m_\alpha=R$ for every $\alpha$, and it holds only for tight families.

Three things follow, and they pull in opposite directions.

- **(G1) is strictly stronger where it applies.** It gives, for every $\alpha$ separately, $\max_{\beta\ne\alpha}S_{\alpha\beta}\ge R$. That is $M$ localised bounds, and the global bound is their disjunction weakened to a single statement: $\max_{\alpha\ne\beta}S_{\alpha\beta}=\max_\alpha\max_{\beta\ne\alpha}S_{\alpha\beta}\ge R$. Knowing that **every** index has a partner at overlap $\ge R$ is more than knowing that **some** index does.
- **(G1) gives the reverse half too, which "max at least mean" throws away.** From $m_\alpha=R$ exactly, one also gets $\min_{\beta\ne\alpha}S_{\alpha\beta}\le R$ for every $\alpha$, and beyond that the exact value of the sum, which is a linear constraint on the whole overlap vector rather than an inequality. The simplex bound supplies none of this. Reading the identity as "max at least mean" is a strict loss of information.
- **(G3) is strictly more general in hypothesis.** Theorem 5.1 as printed at [casazza-fickus-1708.08879.txt:370](https://arxiv.org/abs/1708.08879) assumes only that the $U_j$ are $c$-dimensional subspaces. Tightness enters as a condition characterising equality, never as a hypothesis. On a non-tight family (G1) has no content at all, while (G3) still constrains. Closed-form witness: in $\mathbb R^4$ take $P_1=\mathrm{span}(e_1,e_2)$, $P_2=\mathrm{span}(e_1,e_3)$, $P_3=\mathrm{span}(e_1,e_4)$. Then $\sum_\alpha\Pi_\alpha=3e_1e_1^{\!\top}+e_2e_2^{\!\top}+e_3e_3^{\!\top}+e_4e_4^{\!\top}$, which is not a multiple of $\mathrm{Id}_4$, so no $\kappa$ exists and (G1) is undefined, while (G3) reads $\max S\ge\frac{2(6-4)}{4\cdot2}=\frac12$ and is satisfied with $\max S=1$.

So neither statement contains the other. (G1) plus "max at least mean" implies the specialisation of (G3) **restricted to tight families**, and that is the whole of the implication. **C2 is REFUTED AS STATED**: the honest formulation is that at a tight frame the specialised simplex bound is the weakest consequence of this record's per-index identity, which is a reason to prefer the identity and not evidence that the two are one statement.

Two further notes on the hypothesis side. Tightness is not free: $\sum_\alpha\Pi_\alpha=\kappa\mathrm{Id}_n$ with $\kappa>0$ has rank $n$ while the left side has rank at most $2M$, so tightness by itself forces $2M\ge n$ and therefore $\kappa\ge1$. And (G3) covers complex subspaces, which (G1) as stated does not reach at all.

## 3. The equality cases are different conditions

(G3)'s equality is characterised by **both** of (i) tightness $\sum_jP_j=\alpha I$ and (ii) equi-chordality, all $\mathop{\mathrm{tr}}(P_jP_{j'})$ equal for $j\ne j'$, with the forced values $\alpha=\frac{Mc}d$ and $\beta=\frac{c(Mc-d)}{d(M-1)}$. (G1) requires only (i).

So one direction of the record's claim is sound: **equality in the simplex bound does imply isotropy**, because (i) is part of the characterisation. The converse fails, and it fails on the most natural object in the record's own setting.

**Witness, exact.** Take $n=4$ and the coordinate family $\{e_i\wedge e_j\}_{i<j}$, so $M=6=\binom42$. Each $e_i$ lies in exactly $3$ of the six coordinate planes, so $\sum_\alpha\Pi_\alpha=3\,\mathrm{Id}_4$ and the family is tight with $\kappa=3=\frac{2\cdot6}4$, consistent with (G2). The overlaps are $S_{\alpha\beta}=1$ when the index pairs meet and $0$ when they are disjoint. Fixing $\alpha=\{1,2\}$: the partners $\{1,3\},\{1,4\},\{2,3\},\{2,4\}$ give $1$ and $\{3,4\}$ gives $0$, so $\sum_{\beta\ne\alpha}S_{\alpha\beta}=4=2(\kappa-1)$, confirming (G1). But $\max S=1$ while $R=\frac{2(12-4)}{4\cdot5}=\frac45$, so the bound is strict, and the reason is precisely that (ii) fails: the overlaps take two values, $1$ and $0$, not one.

**C3 is REFUTED AS STATED.** Equality is isotropy **plus** equi-chordality, and isotropy alone is compatible with strict inequality. The same defect refutes **C4**: the literature's optimal-packing criterion at $c=2$, $d=n$ is the conjunction, so it is strictly stronger than isotropy and the two are not the same equation.

C4 has a second, sharper problem, which section 5 establishes and I state here because it changes what the claim is worth. At $M=\binom n2$ with $\Lambda^2$-orthonormality, isotropy is **automatic**. A condition that holds for every object in the class carries no information about that class, so at the case the record cares about, identifying the packing criterion with isotropy identifies a real constraint with an empty one. Either the record's "Ricci-flatness condition" is something strictly more than $\sum\Pi_\alpha=\kappa\mathrm{Id}$, in which case the identification needs restating in those terms, or it is that condition and the route should know it is free.

## 4. The multiplicity claim, and every way I tried to break it

**The reasoning as stated is correct.** $\max_{\alpha\ne\beta}S_{\alpha\beta}\ge R$ is satisfied more easily as the overlaps grow, so it excludes families whose overlaps are all small and admits every family with one large overlap. A cap on $M$ needs an upper bound on overlaps, and a lower bound on a maximum can only produce one in combination with such an upper bound.

**Attempt 1, pair it with $S_{\alpha\beta}\le1$.** This gives $\frac{2(2M-n)}{n(M-1)}\le1$, that is $4M-2n\le nM-n$, that is $M(4-n)\le n$. At $n\ge5$ the left side is negative or zero and the inequality is automatic. At $n=4$ it reads $0\le4$, also automatic. At $n=3$ it reads $M\le3=\binom32$, which is the dimension count already implied by $\Lambda^2$-orthonormality. So the pairing yields nothing anywhere. The record says "too weak to bite at any $n>4$", which is true and one step short of maximal: it does not bite at $n=4$ either, and at $n=3$ it only reproduces what orthonormality already gives.

**Why no upper bound on overlaps can ever rescue this.** Treat $R$ as a function of $M$: $\frac{d}{dM}\frac{2M-n}{M-1}=\frac{n-2}{(M-1)^2}>0$ for $n>2$, so $R$ increases in $M$ with $\lim_{M\to\infty}R=\frac4n$. Hence $R<\frac4n$ for every finite $M$. For $n\ge4$ this gives $R<1$ unconditionally, so the constraint $R\le\max S\le1$ is empty for every $M$ whatsoever. This is stronger than the record's statement and settles the question rather than checking one case: **no pairing of the specialised simplex bound with the true upper bound $S\le1$ can ever cap $M$ at any $n\ge4$**, because the bound's supremum over all $M$ already lies below the cap.

**Attempt 2, sum (G1) over $\alpha$ instead of maximising.** $\sum_{\alpha\ne\beta}S_{\alpha\beta}=2M(\kappa-1)$ over the $M(M-1)$ ordered pairs, and $S\le1$ gives $2M(\kappa-1)\le M(M-1)$, that is $\frac{4M}n-2\le M-1$, that is $M(4-n)\le n$ again. The same inequality, so averaging buys nothing over maximising.

**Attempt 3, does $\Lambda^2$-orthonormality supply the missing upper bound?** It supplies two things, and neither caps $M$ below the dimension count.

- The dimension count itself, $M\le N=\binom n2$, which is immediate and independent of the simplex bound.
- The overlap bound $S_{\alpha\beta}\le1$, which section 0a shows is exactly what orthonormality buys (the general bound being $S\le c=2$). So the record's use of $S\le1$ is legitimate, and by the paragraph above it is still useless for capping $M$.

Orthonormality does **not** force overlaps away from $1$: $\omega_1=e_1\wedge e_2$ and $\omega_2=e_1\wedge e_3$ are $\Lambda^2$-orthonormal with $S_{12}=1$, so there is no gap to exploit.

**Attempt 4, where a cap does come from.** If one adds the hypothesis that the planes pairwise commute, $S_{\alpha\beta}=0$ for all $\alpha\ne\beta$, then (G1) gives $0=2(\kappa-1)$, so $\kappa=1$ and (G2) gives $M=\frac n2$ exactly. That is a sharp multiplicity determination, and it comes from the identity plus a vanishing hypothesis, never from the simplex bound. If the route wants a cap, this is the shape it will have: an extra hypothesis forcing overlaps down, with (G1) converting it into a statement about $M$.

**C5 is CONFIRMED** and strengthened as above.

## 5. The evaluation at $M=\binom n2$, and why $\kappa=n-1$ is forced

**The value.** With $M=\frac{n(n-1)}2$: $2M-n=n^2-2n=n(n-2)$ and $M-1=\frac{n^2-n-2}2=\frac{(n-2)(n+1)}2$, so
$$R=\frac{2\,n(n-2)}{n\cdot\frac{(n-2)(n+1)}2}=\frac{4n(n-2)}{n(n-2)(n+1)}=\frac4{n+1}.$$
Confirmed, valid for $n\ge3$ where $n-2\ne0$ cancels legitimately.

**$\kappa=n-1$, and it is forced rather than assumed.** (G2) gives $\kappa=\frac{2M}n=\frac{n(n-1)}n=n-1$ the moment tightness is granted. Tightness is granted for free at $M=N$, by the following argument, which is linear algebra and needs no representation theory.

Under the identification of section 0a, $\langle\omega,\omega'\rangle=-\tfrac12\mathop{\mathrm{tr}}(AA')$, so a $\Lambda^2$-orthonormal basis of $\Lambda^2\mathbb R^n$ is an orthonormal basis of $\mathfrak{so}(n)$ for the form $B(A,A')=-\tfrac12\mathop{\mathrm{tr}}(AA')$. For two such bases related by $A'_\alpha=\sum_\beta O_{\alpha\beta}A_\beta$ with $O$ orthogonal,
$$\sum_\alpha (A'_\alpha)^2=\sum_{\beta,\gamma}\Big(\sum_\alpha O_{\alpha\beta}O_{\alpha\gamma}\Big)A_\beta A_\gamma=\sum_\beta A_\beta^2,$$
so the operator $\sum_\alpha A_\alpha^2$ on $\mathbb R^n$ is the **same** for every $\Lambda^2$-orthonormal basis. Evaluating it on the coordinate basis, where $A_{ij}^2=-(e_ie_i^{\!\top}+e_je_j^{\!\top})$ and each index appears in $n-1$ pairs, gives $\sum_\alpha A_\alpha^2=-(n-1)\mathrm{Id}_n$. For decomposable $\omega_\alpha$ we have $\Pi_\alpha=-A_\alpha^2$, hence

$$\sum_{\alpha=1}^{\binom n2}\Pi_\alpha=(n-1)\,\mathrm{Id}_n\qquad\text{for every }\Lambda^2\text{-orthonormal decomposable basis of }\Lambda^2\mathbb R^n.$$

**C8 is CONFIRMED**, consistently with (G2), and the screen in section 6 exhibits a non-coordinate basis where it holds with $\sum\Pi_\alpha=3\,\mathrm{Id}_4$.

Two riders. First, this is genuinely a statement about $M=N$: for $M<N$ orthonormality does not give tightness, as $\omega_1=e_1\wedge e_2$, $\omega_2=e_1\wedge e_3$ in $\mathbb R^4$ shows with $\sum\Pi=2e_1e_1^{\!\top}+e_2e_2^{\!\top}+e_3e_3^{\!\top}$. Second, this is the argument behind the sharper half of C4's refutation in section 3: isotropy is not a condition one imposes at $M=N$, it is a theorem.

## 6. Does the bound bind, and can a $\Lambda^2$-orthonormal decomposable family attain it

**The coordinate family.** $\{e_i\wedge e_j\}_{i<j}$ is $\Lambda^2$-orthonormal with $M=\binom n2$, tight with $\kappa=n-1$, and has $S_{\alpha\beta}\in\{0,1\}$ according to whether the index pairs meet. So $\max S=1$ for $n\ge3$ against $R=\frac4{n+1}$, with slack $1-\frac4{n+1}=\frac{n-3}{n+1}$. At $n=3$ the slack is zero: $M=3$, all three coordinate planes pairwise share a line, every $S_{\alpha\beta}=1$, and $R=\frac44=1$. That is an equality case, equi-chordal and tight as Theorem 5.1 requires. At $n=4$ the slack is $\frac15$, and at large $n$ it tends to $1$.

**Can a $\Lambda^2$-orthonormal decomposable family come close to equality?** Yes, and at $n=4$ it attains it exactly. The brief's premise that $S_{\alpha\beta}\in\{0,1\}$ is a property of the coordinate family alone, not of the class: by section 0a, any $\Lambda^2$-orthonormal pair has $\cos\theta_1\cos\theta_2=0$ and hence $S_{\alpha\beta}=\cos^2\theta_1$, which ranges over all of $[0,1]$.

**The construction, in closed form.** Work in $\Lambda^2\mathbb R^4=\Lambda^2_+\oplus\Lambda^2_-$, with $a:\mathbb R^3\to\Lambda^2_+$ and $b:\mathbb R^3\to\Lambda^2_-$ the isometries onto the self-dual and anti-self-dual parts, normalised by $a_1=\frac{\varphi_{12}+\varphi_{34}}{\sqrt2}$, $a_2=\frac{\varphi_{13}-\varphi_{24}}{\sqrt2}$, $a_3=\frac{\varphi_{14}+\varphi_{23}}{\sqrt2}$ and $b_i$ the same with the signs of the second terms reversed. For unit $u,v\in\mathbb R^3$ set $\omega(u,v):=\frac{a(u)+b(v)}{\sqrt2}$. Then $\lVert\omega\rVert=1$, and $\omega\wedge\omega=(\lVert a(u)/\sqrt2\rVert^2-\lVert b(v)/\sqrt2\rVert^2)\cdot2\,\mathrm{vol}=0$, so $\omega$ is decomposable. Writing $p=\langle u_\alpha,u_\beta\rangle$ and $q=\langle v_\alpha,v_\beta\rangle$,
$$\langle\omega_\alpha,\omega_\beta\rangle=\tfrac12(p+q),\qquad S_{\alpha\beta}=1+pq,$$
the second from $S=\cos^2\theta_1+\cos^2\theta_2=1+(\cos\theta_1\cos\theta_2)^2-(\sin\theta_1\sin\theta_2)^2$ together with $\cos\theta_1\cos\theta_2=\frac{p+q}2$ and $\sin\theta_1\sin\theta_2=\frac{p-q}2$ in $\mathbb R^4$. Both formulas check on the coordinate basis, for instance $\omega_{12}=\omega(e_1,e_1)$ and $\omega_{34}=\omega(e_1,-e_1)$ give $\langle\cdot,\cdot\rangle=0$ and $S=1-1=0$.

Now let $S_{\mathrm{Sei}}$ be the Seidel matrix of the six icosahedral equiangular lines in $\mathbb R^3$, which arise from the six vectors $(0,\pm1,\pm\varphi)$, $(\pm1,\pm\varphi,0)$, $(\pm\varphi,0,\pm1)$ chosen one per antipodal pair with $\varphi=\frac{1+\sqrt5}2$. Each has squared norm $2+\varphi$ and every pairwise inner product has magnitude $\varphi$, so the common squared cosine is $\frac{\varphi^2}{(2+\varphi)^2}=\frac{(3+\sqrt5)/2}{(15+5\sqrt5)/2}=\frac{3+\sqrt5}{5(3+\sqrt5)}=\frac15$. Their unit Gram matrix is $G_+=I+\frac1{\sqrt5}S_{\mathrm{Sei}}$, and because the six lines form an orbit of the icosahedral group acting irreducibly on $\mathbb R^3$ they are a tight frame, $\sum_\alpha u_\alpha u_\alpha^{\!\top}=2I_3$, so $G_+$ has eigenvalues $2,2,2,0,0,0$. Hence $\frac1{\sqrt5}S_{\mathrm{Sei}}$ has eigenvalues $1,1,1,-1,-1,-1$, so $S_{\mathrm{Sei}}^2=5I$ and
$$G_-:=2I-G_+=I-\tfrac1{\sqrt5}S_{\mathrm{Sei}}$$
has eigenvalues $0,0,0,2,2,2$, positive semidefinite of rank $3$ with unit diagonal. So $G_-$ is the Gram matrix of six unit vectors $v_1,\dots,v_6\in\mathbb R^3$.

Set $\omega_\alpha:=\omega(u_\alpha,v_\alpha)$ for $\alpha=1,\dots,6$. Then for $\alpha\ne\beta$, $p+q=(G_+)_{\alpha\beta}+(G_-)_{\alpha\beta}=0$, so the family is $\Lambda^2$-orthonormal, and $pq=-p^2=-\frac15$, so
$$S_{\alpha\beta}=1-\tfrac15=\tfrac45=\frac4{n+1}\Big|_{n=4}\qquad\text{for every }\alpha\ne\beta.$$
Tightness is automatic by section 5, giving $\sum\Pi_\alpha=3\,\mathrm{Id}_4$, and equi-chordality is the display above. So this is an **equi-chordal tight fusion frame of six $2$-planes in $\mathbb R^4$ attaining the simplex bound, consisting of a $\Lambda^2$-orthonormal basis of decomposable forms**.

A screen of the construction, seconds of arithmetic on the object just built, returned the $\Lambda^2$ Gram matrix equal to $I_6$, $\Pi_\alpha^2=\Pi_\alpha$ with $\mathop{\mathrm{tr}}\Pi_\alpha=2$ for each $\alpha$ so every form is decomposable, $\sum_\alpha\Pi_\alpha=3\,\mathrm{Id}_4$, and all thirty off-diagonal $S_{\alpha\beta}=0.8$.

**Consequences for C6.** The algebra $\frac4{n+1}$ is right, so C6 is **CONFIRMED AS ALGEBRA**. The gloss "which is far below $1$" is **REFUTED** as a reading: at $n=4$ the bound is attained, so $\frac45$ is the exact optimum of $\max_{\alpha\ne\beta}S_{\alpha\beta}$ over $\Lambda^2$-orthonormal decomposable bases of $\Lambda^2\mathbb R^4$, and the distance from $1$ measures how far the coordinate basis is from optimal rather than how weak the bound is. Whether $\frac4{n+1}$ is attained for $n\ge5$ I did not settle, and settling it is a census of equi-chordal decomposable bases, which the analysis-only rule puts out of reach here. What the $n=4$ case already establishes is that the record cannot argue from the size of $\frac4{n+1}$ to the weakness of the bound.

## 7. The equi-isoclinic refinement and the icosahedral configuration

**The value.** With $M=6$, $c=2$, $d=6$, the quoted formula gives
$$\sigma^2=\frac{Mc-d}{d(M-1)}=\frac{12-6}{6\cdot5}=\frac6{30}=\frac15,$$
and $\alpha=\frac{Mc}d=\frac{12}6=2$. Both match the record: $\cos^2=\frac15$ and $\sum\Pi_\alpha=2\,\mathrm{Id}_6$. The complex reading of the same configuration, six equiangular lines in $\mathbb C^3$ with $M=6$, $c=1$, $d=3$, gives $\frac{6-3}{3\cdot5}=\frac15$ and $\alpha=2$ as well, which is no accident: $\frac{Mc-d}{d(M-1)}$ is invariant under $(c,d)\mapsto(2c,2d)$, the substitution that realifies. A $6$-vector equiangular tight frame in $\mathbb C^3$ with $|\langle\cdot,\cdot\rangle|^2=\frac{M-d}{d(M-1)}=\frac15$ does exist, so the configuration is real and the identification is right. **C7 is CONFIRMED.**

**The failure of $\Lambda^2$-orthonormality is forced, not incidental.** Equi-isoclinicity means both principal angles of every pair are equal, $\cos^2\theta_1=\cos^2\theta_2=\sigma^2$. By section 0a, $\Lambda^2$-orthonormality means $\cos\theta_1\cos\theta_2=0$ for every pair. Together they force $\sigma^2=0$, that is pairwise orthogonal planes, whereupon (G1) gives $\kappa=1$ and (G2) gives $M=\frac n2$. So:

> No $\Lambda^2$-orthonormal family of decomposable forms is equi-isoclinic with $\sigma^2>0$.

This is worth recording because it closes a whole class of literature optima to the route: every equi-isoclinic tight fusion frame of $2$-planes, which is the sharper optimum Theorem 5.1's refinement characterises, is unusable under $\Lambda^2$-orthonormality. The reachable optima are exactly the equi-chordal ones that are not equi-isoclinic, and section 6's $\mathbb R^4$ family is one: its pairs have $\cos^2\theta_1=\frac45$ and $\cos^2\theta_2=0$, which the screen confirmed as the spectrum of $\Pi_\beta\Pi_\alpha\Pi_\beta$.

## 8. Boundary and degenerate cases

- **$M=1$.** $R$ has $M-1=0$ in the denominator and the max ranges over the empty set. The bound is ill-posed rather than false, and (G1) reads $0=2(\kappa-1)$ with (G2) giving $\kappa=\frac2n$, consistent only at $n=2$. Nothing in the record's use goes here.
- **$Mc\le d$, that is $2M\le n$.** $R\le0$ and the bound is vacuous, since $S\ge0$ always. Under tightness this range is almost empty anyway: section 2 showed tightness forces $2M\ge n$, and at $2M=n$ exactly, (G1) gives $\sum_{\beta\ne\alpha}S_{\alpha\beta}=0$, so all overlaps vanish and the planes are mutually orthogonal, which needs $n$ even. So at odd $n$ the case $R=0$ is unreachable for a tight family.
- **$n=4$.** Not vacuous: $R=\frac45$ at $M=6$, and section 6 shows it is attained. The record's use of $n>4$ as the threshold for "$S\le1$ does not bite" understates by one, as section 4 records.
- **Odd $n$.** $\kappa=\frac{2M}n$ need not be an integer, and nothing in (G1) or (G2) requires it to be. At $M=\binom n2$ it is $n-1$ regardless of parity, and $n=3$ is a genuine equality case. The only parity effect is the one noted above at $\kappa=1$.
- **$n=2$.** $N=1$, so $M=1$ and the setting collapses to the $M=1$ case.
- **Where the record strays.** Nowhere into these ranges, as far as the two quoted passages go. The quoted passages use $M\ge2$ and $n\ge4$ throughout, where the bound is well posed.

## 9. What would break the identification, and what I did to look for it

**The algebraic fact that does break "one statement"** is the absence of tightness from Theorem 5.1's hypotheses. Any family of $M$ two-planes in $\mathbb R^n$ that is not tight is an object on which (G3) speaks and (G1) is undefined, so the two cannot be one statement. I looked for one and exhibited it in closed form in section 2: three coordinate planes through $e_1$ in $\mathbb R^4$.

**The object that does break "equality is exactly isotropy"** is a tight family whose overlaps are not all equal. I looked for one and exhibited it in closed form in section 3: the coordinate basis of $\Lambda^2\mathbb R^4$, tight with $\kappa=3$ and $\max S=1>\frac45$.

**The object that would break the record's reading of $\frac4{n+1}$ as slack** is a $\Lambda^2$-orthonormal decomposable basis attaining the bound. I looked for one and constructed it in closed form in section 6 at $n=4$, from the icosahedral Seidel matrix via $G_\pm=I\pm\frac1{\sqrt5}S_{\mathrm{Sei}}$, and screened it.

**What would break the direction that survives**, namely that (G1) plus "max at least mean" implies the specialised bound at a tight frame, would be a tight family with $\max_{\alpha\ne\beta}S_{\alpha\beta}<\frac{2(2M-n)}{n(M-1)}$. No such object exists, because a maximum of finitely many reals is at least their mean and section 1's identity makes that mean the bound's right-hand side. I record this as settled rather than searched.

**Where I stopped.** Whether $\frac4{n+1}$ is attained by a $\Lambda^2$-orthonormal decomposable basis for some or all $n\ge5$ is a census of a family and needs approval under the analysis-only rule, so I did not open it. The structural constraint that section 7 derives, namely $\cos\theta_1\cos\theta_2=0$ for every pair and hence $S_{\alpha\beta}=\cos^2\theta_1$, is the right starting point for that question whenever it is taken up: an attaining family at general $n$ is a decomposable orthonormal basis of $\Lambda^2\mathbb R^n$ whose pairs all have a common perpendicular direction and a single common non-right principal angle with $\cos^2=\frac4{n+1}$.

## Verdict for the whole

**The arithmetic is right and two of the conclusions drawn from it are not.**

- **CONFIRMED**: the $c=2$, $d=n$ specialisation coincides identically with the per-index mean (C1), the bound caps no multiplicity and $S\le1$ cannot make it do so (C5, strengthened to every $n\ge4$ and every $M$ by $R<\frac4n$), the value $\frac4{n+1}$ at $M=\binom n2$ (C6 as algebra), the icosahedral $\sigma^2=\frac15$ and $\alpha=2$ (C7), and $\kappa=n-1$ at a full decomposable orthonormal basis (C8, forced rather than assumed).
- **REFUTED AS STATED**: that the simplex bound **is** the per-index relation (C2, since neither statement contains the other and the record's reading discards the identity's reverse half and its per-index localisation), and that equality in the bound **is** isotropy (C3 and C4, since equality is isotropy plus equi-chordality, and at $M=\binom n2$ isotropy is automatic and therefore empty).
- **REFUTED as a reading**: that $\frac4{n+1}$ being far below $1$ shows the bound weak (C6's gloss). The bound is attained at $n=4$ by a $\Lambda^2$-orthonormal decomposable basis with every $S_{\alpha\beta}=\frac45$, so it is exactly sharp there.
- **HYPOTHESIS-DEBT**: the given range $S_{\alpha\beta}\in[0,1]$, the shared-line biconditional, and the commutator identity $S_{\alpha\beta}=\lVert[\omega_\alpha,\omega_\beta]\rVert^2$ all need the $\Lambda^2$-orthonormality hypothesis, which the record carries and its statement of the givens does not attach (C9). The general identity is $\lVert[\omega_\alpha,\omega_\beta]\rVert^2=S_{\alpha\beta}-2\langle\omega_\alpha,\omega_\beta\rangle^2$ and the general range is $[0,2]$.
- **Two positive results for the record to keep**: a full $\Lambda^2$-orthonormal decomposable basis of $\Lambda^2\mathbb R^n$ is tight with $\kappa=n-1$ automatically, by basis-independence of $\sum_\alpha A_\alpha^2$ (section 5), and no $\Lambda^2$-orthonormal decomposable family is equi-isoclinic with $\sigma^2>0$, so the equi-isoclinic optima of the fusion-frame literature are unreachable for this route while the equi-chordal ones are not (section 7).
