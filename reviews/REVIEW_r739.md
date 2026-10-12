# r739, L164, Gate 2: padding preserves $\lVert W\rVert$, $P$ and $\theta$, and the four steps that carry it

Written from [BRIEF-g2-l164.md](BRIEF-g2-l164.md) cold: the definitions, the statement and the proof as written were the only inputs, and no findings file was opened before every claim below had a verdict. No numerical work was done in the sense the standing rule forbids, no search, sweep, census or falsifier hunt. Two screens were run, each on an object constructed for the purpose and each in exact rational arithmetic, and both are reported as screens, not as evidence: §7 and §9. Every value in this report is exact. Log: [agent_logs/g2-l164-r739.log](../agent_logs/g2-l164-r739.log).

## Claim table

| # | Claim | Verdict | Reason |
| --- | --- | --- | --- |
| C1 | (i) the splitting $\Lambda^2\mathbb R^n=\Lambda^2U\oplus(U\wedge U^\perp)\oplus\Lambda^2U^\perp$, and the hypothesis kills the last two | **CONFIRMED** | the span of $\{u\wedge u^\perp: u\perp U\}$ is exactly the last two summands, and the splitting is orthogonal |
| C2 | (i) "so $W$ maps $\Lambda^2U$ into itself" | **CONFIRMED, hypothesis unstated** | the inference is false for a general operator and needs self-adjointness, which $\mathcal W_n$ supplies and the step never names; witness in §5 |
| C3 | (ii) $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ is an isometry for the half-trace pairing | **CONFIRMED** | $\varphi_{ij}$ has half-trace square norm $1$ in both spaces; the block inclusion preserves $\operatorname{tr}(X^{\mathsf T}Y)$ |
| C4 | (ii) hence $\lVert W'\rVert=\lVert W\rVert$ for the operator norm | **CONFIRMED, one clause elided** | the bivector isometry alone does not give it; the missing link is $\operatorname{tr}(W^{\mathsf T}W)=\operatorname{tr}(W'^{\mathsf T}W')$ by cyclicity, one line, supplied in §3 |
| C5 | (iii) $W^\#$ is supported on $\Lambda^2U$ | **CONFIRMED** | bracket table computed; $[\varphi_{ij},\varphi_{kl}]$ produces only indices drawn from $\{i,j,k,l\}$ |
| C6 | (iii) its entries there are $\mathfrak{so}(U)$'s own structure constants | **CONFIRMED** | the bracket and the pairing both restrict, so $c_{acd}$ is the same number computed in $\mathfrak{so}(m)$ or in $\mathfrak{so}(n)$ |
| C7 | the index-set step from $[\Lambda^2U,\Lambda^2U]\subseteq\Lambda^2U$ to "$c_{acd}=0$ for $a$ outside" | **CONFIRMED, basis choice unstated** | needs the $\varphi$-basis adapted to the splitting; "$a$ outside" is not even defined otherwise, and the proof never chooses the basis |
| C8 | (iv) first Bianchi is inherited | **CONFIRMED** | Bianchi is an unsummed identity in four free indices whose three terms permute $i,j,k$ only, so restricting the range is a genuine sub-family |
| C9 | (iv) pair symmetry "likewise" | **CONFIRMED, "likewise" is adequate** | same unsummed reason, and independently: a compression of a self-adjoint operator is self-adjoint |
| C10 | (iv) Ricci-flatness of the restriction | **CONFIRMED, the only step in (iv) with content** | $\operatorname{Ric}$ contracts over the *ambient* range; the extra terms are mixed-block entries of $W$ and vanish |
| C11 | $P(W')=\langle W',Q(W')\rangle=\langle W,Q(W)\rangle$ | **CONFIRMED** | compression preserves the trace pairing exactly when both arguments are supported on the subspace, which (i)–(iii) establish for $W$ and $Q(W)$ |
| C12 | $\theta(W')=\theta(W)$ | **HYPOTHESIS-DEBT** | stated with no $W\neq0$; and at $\dim U\le3$ the hypothesis *forces* $W=0$, so $\theta$ is $0/0$ on a whole admissible branch of the quantification, not at an isolated point |
| C13 | the disclaimer, the entry "does not claim" $Q(\mathrm{pad}\,W')=\mathrm{pad}\,Q(W')$ | **REFUTED as scoped** | steps (i)–(iii) prove exactly that operator identity, and prove it for *every* symmetric operator supported on $\Lambda^2U$, Weyl or not; the scalar route is not lighter, it is the same computation read once |
| C14 | the brief's two definitions of $\#$ agree | **REFUTED** | $\sum c_{acd}c_{bef}W_{ce}W_{df}=2\cdot(vv^{\mathsf T}\#ww^{\mathsf T}$-extension$)$; the operator definition is the standard one ($\mathrm{id}^\#=(n-2)\mathrm{id}$), the index formula is missing a $\tfrac12$ |
| C15 | hypothesis economy: are all stated hypotheses used? | **NO, two are idle for the equalities** | first Bianchi and Ricci-flatness are used only for the membership clause; the three displayed equalities hold for any symmetric operator supported on $\Lambda^2U$ |
| C16 | the reading of "vanishes on $u\wedge u^\perp$" | **the gloss pins the right one** | under the quadratic-form reading the statement is **false**, witness in closed form in §9 ($\lVert W\rVert^2=12$, $W'=0$); the clause "so that $W$ is supported on $\Lambda^2U$" rules that reading out |

**One line to act on.** The mathematics is right and every step survives; add $W\neq0$ to the $\theta$ clause, name the self-adjointness in (i) and the adapted basis in (iii), and correct two pieces of bookkeeping around the result, the "does not claim" disclaimer disowns the operator identity the proof actually delivers, and the index formula for $\#$ carries twice the halved Böhm–Wilking product it is supposed to expand.

## 0. Conventions, fixed once

$\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ by $e_i\wedge e_j\mapsto\varphi_{ij}=E_{ij}-E_{ji}$, with $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$. Then $\varphi_{ij}^{\mathsf T}\varphi_{ij}=E_{jj}+E_{ii}$ has trace $2$, so $\lVert\varphi_{ij}\rVert^2=1$ and $\{\varphi_{ij}\}_{i<j}$ is orthonormal. On $\operatorname{End}(\Lambda^2)$ the pairing is plain Frobenius, $\langle A,B\rangle=\operatorname{tr}(A^{\mathsf T}B)$, which in any orthonormal bivector basis is $\sum_{A,B}A_{AB}B_{AB}$.

Everything is $O(n)$-equivariant, so take $U=\operatorname{span}(e_1,\dots,e_m)$ without loss. Write $I=\{(i,j):i<j,\ i,j\in U\}$ for the basis indices of $\Lambda^2U$ and $J$ for the rest. Write $\iota:\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$, so $\iota^*\iota=\mathrm{id}$, $\iota\iota^*=\Pi$ the orthogonal projection. "**Supported on $\Lambda^2U$**" means $W=\Pi W\Pi$, equivalently $W=\iota W'\iota^*$ with $W'=\iota^*W\iota$.

The bracket table, computed once and used throughout, from $\varphi_{ij}\varphi_{kl}=\delta_{jk}E_{il}-\delta_{jl}E_{ik}-\delta_{ik}E_{jl}+\delta_{il}E_{jk}$:

$$[\varphi_{ij},\varphi_{kl}]=\delta_{jk}\varphi_{il}-\delta_{jl}\varphi_{ik}-\delta_{ik}\varphi_{jl}+\delta_{il}\varphi_{jk}.$$

The half-trace form is $\mathrm{ad}$-invariant, so $c_{abc}=\langle[v_a,v_b],v_c\rangle$ is totally antisymmetric; the proof's reindexing $c_{acd}=\langle[v_c,v_d],v_a\rangle$ is a cyclic permutation and is legitimate.

## 1. Hypothesis inventory

**Hypotheses of the statement.**

- H1. $W$ is a symmetric operator on $\Lambda^2\mathbb R^n$.
- H2. $W$ satisfies the first Bianchi identity.
- H3. $W$ is Ricci-flat.
- H4. $U\subseteq\mathbb R^n$ is a linear subspace.
- H5. $W(u\wedge x)=0$ for every $u\perp U$ and every $x$.

**Imported facts and their hypotheses.**

- F1. $\Lambda^2$ of an orthogonal splitting: $\Lambda^2(U\oplus U^\perp)=\Lambda^2U\oplus(U\wedge U^\perp)\oplus\Lambda^2U^\perp$, orthogonally. Needs only that the splitting is orthogonal. Applied to $U\oplus U^\perp$, holds.
- F2. $\Lambda^2U=\mathfrak{so}(U)$ is a Lie subalgebra of $\mathfrak{so}(n)$. Needs $U$ a subspace. Verified from the bracket table in §4, holds.
- F3. The block inclusion $\mathfrak{so}(m)\hookrightarrow\mathfrak{so}(n)$ preserves $\operatorname{tr}(X^{\mathsf T}Y)$. Holds for any $m\le n$.
- F4. Trace cyclicity, used for the compression identity in §3 and §6.
- F5. $\mathcal W_m=0$ for $m\le3$, used only by me, in §8, to read the edge.

**Which stated hypotheses the written proof uses.**

| Hypothesis | Used where | Used for what |
| --- | --- | --- |
| H1 symmetry | (i), silently; (ii) and (iv) via it | to pass from "annihilates the complement" to "preserves $\Lambda^2U$" |
| H2 Bianchi | (iv) only | membership $W'\in\mathcal W_{\dim U}$ |
| H3 Ricci-flat | (iv) only | membership |
| H4 subspace | (i), (iii) | the orthogonal splitting; that $\Lambda^2U$ is a subalgebra |
| H5 support | (i), (ii), (iii), (iv) | everywhere |

**Two findings drop out of this table.** H2 and H3 are idle for the three displayed equalities: $\lVert W'\rVert=\lVert W\rVert$, $P(W')=P(W)$ and $\theta(W')=\theta(W)$ hold for *any* symmetric operator supported on $\Lambda^2U$, and the Weyl hypotheses buy only the membership clause. And H1 is used without being named, which §5 treats. A third finding is the converse shape: the statement quantifies over every $U$ meeting H5, and §8 shows the $\theta$ clause has no meaning on the branch $\dim U\le3$ of that quantification.

## 2. Step (i), the support

The span of $\{u\wedge x:u\in U^\perp,\ x\perp u\}$ is $(U^\perp\wedge U)\oplus\Lambda^2U^\perp$: taking $x\in U$ gives the first summand, taking $x\in U^\perp\cap u^\perp$ gives the second, and $u\wedge u=0$ means the restriction $x\perp u$ costs nothing. So H5 says precisely that $W$ annihilates the last two summands of F1. **C1 confirmed.**

The next words ("so $W$ maps $\Lambda^2U$ into itself and annihilates its complement"), are the second half of C1 and the whole of C2, and they are two different statements. "Annihilates its complement" *is* H5 restated. "Maps $\Lambda^2U$ into itself" is not, and §5 shows why.

Granting it, $W=\Pi W\Pi$ and $W=\iota W'\iota^*$ with $W'=\iota^*W\iota$, and in the adapted basis the matrix of $W$ is $\operatorname{diag}(W',0)$, entries $W_{ce}$ vanishing unless $c,e\in I$.

## 3. Step (ii), the norm, and whether it conflates two norms

**C3 first.** $\varphi_{ij}$ with $i,j\in U$ is the same matrix whether read in $\mathfrak{so}(m)$ (as the whole matrix) or in $\mathfrak{so}(n)$ (as the top-left block padded by zeros), and $\operatorname{tr}(X^{\mathsf T}Y)$ does not see the padding. So $\iota$ is an isometry for the half-trace pairing, and $\{\varphi_{ij}\}_{(i,j)\in I}$ is simultaneously an orthonormal basis of $\Lambda^2U$ and an orthonormal subset of $\Lambda^2\mathbb R^n$. Confirmed.

**C4, the brief's question.** The operator norm is a Frobenius norm on $\operatorname{End}(\Lambda^2)$ and the isometry just established is a statement about $\Lambda^2$, so the written "so … is an isometry and $\lVert W'\rVert=\lVert W\rVert$ by (i)" does jump between two different objects. **The jump is one clause wide and the clause is true:**

$$\lVert W\rVert^2=\operatorname{tr}(W^{\mathsf T}W)=\operatorname{tr}(\iota W'^{\mathsf T}\iota^*\iota W'\iota^*)=\operatorname{tr}(\iota W'^{\mathsf T}W'\iota^*)=\operatorname{tr}(W'^{\mathsf T}W'\,\iota^*\iota)=\lVert W'\rVert^2,$$

using $\iota^*\iota=\mathrm{id}_{\Lambda^2U}$ twice and cyclicity once. Equivalently and more plainly: the matrix of $W$ in the adapted orthonormal basis is $\operatorname{diag}(W',0)$, and a Frobenius norm in an orthonormal basis is the sum of the squares of the entries. So the step is **correct as a claim and elided as an argument**; what the proof cites (the bivector isometry, plus (i)) is exactly the pair of ingredients needed, and only the sentence joining them is missing.

**Does the pairing on $\operatorname{End}$ inherit the $\tfrac12$?** No, the conventions put plain Frobenius there. **And the answer does not matter for this statement.** Rescale the $\operatorname{End}$ pairing by any $\lambda>0$: then $P\mapsto\lambda P$ and $\lVert W\rVert^3\mapsto\lambda^{3/2}\lVert W\rVert^3$, so $\theta\mapsto\lambda^{-1/2}\theta$, in *both* dimensions alike, so all three equalities survive verbatim. The same immunity covers the other live convention trap: writing $\lVert W\rVert^2=\sum_{ijkl}W_{ijkl}^2$ over all four index ranges gives $4\sum_{A,B}W_{AB}^2$, a uniform factor, and the components $W_{ijkl}$ vanish unless all four indices lie in $U$, so the component sums agree too. **The statement is convention-robust; the numerical value of $\theta$ is not**, which is why C14 in §7 matters downstream even though it is harmless here.

## 4. Step (iii), the sharp, both claims, with the bracket computation

**That $\Lambda^2U$ is a subalgebra.** From the bracket table, $[\varphi_{ij},\varphi_{kl}]$ is a combination of $\varphi_{il},\varphi_{ik},\varphi_{jl},\varphi_{jk}$, every index appearing is drawn from $\{i,j,k,l\}$. If $i,j,k,l\in U$ then every term lies in $\Lambda^2U$. This is the assertion the proof makes, and it is a computation, not a slogan.

**Claim one: $W^\#$ is supported on $\Lambda^2U$.** The sum $(W^\#)_{ab}=\sum_{c,d,e,f}c_{acd}c_{bef}W_{ce}W_{df}$ runs over all of $\Lambda^2\mathbb R^n$. A term survives only if $W_{ce}\neq0$ and $W_{df}\neq0$; by §2 the first forces $c,e\in I$ and the second forces $d,f\in I$. So all four of $c,d,e,f$ lie in $I$, this is the proof's phrase "force $c,d,e,f\in\Lambda^2U$", loose language for "in $I$", and correct. **Note this half already consumes C2**: $W_{ce}=0$ for $c\in I$, $e\in J$ is the statement that $W$ does not map $\Lambda^2U$ out, not merely that it kills $J$.

Now take $a\in J$. For every surviving term, $c,d\in I$, so $[v_c,v_d]\in\Lambda^2U$ by the table, while $v_a\perp\Lambda^2U$ because the basis is adapted to an *orthogonal* splitting. Hence $c_{acd}=\langle[v_c,v_d],v_a\rangle=0$ and every surviving term dies. The same argument on $c_{bef}$ handles $b\in J$. So $(W^\#)_{ab}=0$ unless $a,b\in I$. **Confirmed, and the bracket computation is the one the brief asked for**: with $c=(i,j)$ and $d=(k,l)$, $i,j,k,l\in U$, the bracket is $\delta_{jk}\varphi_{il}-\delta_{jl}\varphi_{ik}-\delta_{ik}\varphi_{jl}+\delta_{il}\varphi_{jk}$, a combination of $\varphi$'s with both indices in $U$, whose pairing against any $\varphi_{ab}$ with an index outside $U$ is zero term by term.

**Claim two: the entries are $\mathfrak{so}(U)$'s own structure constants.** For $a,c,d\in I$ the number $c_{acd}$ is built from the bracket, which restricts (F2), and the half-trace pairing, which restricts (F3). So it is literally the same rational number computed in $\mathfrak{so}(m)$ or in $\mathfrak{so}(n)$. Therefore for $a,b\in I$,

$$(W^\#)_{ab}=\sum_{c,d,e,f\in I}c_{acd}c_{bef}W_{ce}W_{df}=\sum_{c,d,e,f\in I}c^{(m)}_{acd}c^{(m)}_{bef}W'_{ce}W'_{df}=\big((W')^\#\big)_{ab}.$$

**Confirmed.** With $W^2=\iota (W')^2\iota^*$ (immediate from $W=\iota W'\iota^*$ and $\iota^*\iota=\mathrm{id}$), $Q(W)=\iota\,Q(W')\,\iota^*$.

**Screened.** I computed the padded identity as a check of the mechanism at a nontrivial value: for $\Pi$ the projection onto $\Lambda^2U$ regarded as an operator on $\Lambda^2\mathbb R^n$, the recipe gives $(\Pi^\#)_{aa}=\tfrac12\sum_{c,d\in I}c_{acd}^2$, and for $a=(1,2)$ the surviving pairs are $(1k),(2k)$ with $k\in U\smallsetminus\{1,2\}$ in both orders, so $\tfrac12\cdot2(m-2)=m-2$, matching $\mathrm{id}_{\Lambda^2U}^\#=(m-2)\,\mathrm{id}$ computed inside $\mathfrak{so}(m)$, and giving $0$ on $J$. The ambient dimension $n$ has vanished, which is the whole content of step (iii).

## 5. C2 and C7, the two hypotheses the proof uses without naming

**C2, self-adjointness in (i).** The inference "the hypothesis kills $W$ on the last two summands, so $W$ maps $\Lambda^2U$ into itself" is not valid for a general operator.

- *Located.* Step (i), the word "so".
- *Concretely.* Take $n=5$, $U=\operatorname{span}(e_1,\dots,e_4)$, and $A=\varphi_{15}\varphi_{12}^{\mathsf T}$, i.e. $A\xi=\varphi_{15}\langle\varphi_{12},\xi\rangle$. Then $A$ annihilates $(U\wedge U^\perp)\oplus\Lambda^2U^\perp$ (it annihilates everything orthogonal to $\varphi_{12}$) so it satisfies H5 verbatim, yet $A\varphi_{12}=\varphi_{15}\notin\Lambda^2U$. Its compression $A'$ to $\Lambda^2U$ is $0$ while $\lVert A\rVert=1$, so the norm clause would fail.
- *Argued the opposite.* The most charitable reading is the right one: $W\in\mathcal W_n$ is by definition a *symmetric* operator, and for symmetric $W$, $\ker W\supseteq(\Lambda^2U)^\perp$ gives $\operatorname{im}W=(\ker W)^\perp\subseteq\Lambda^2U$ at once. So the statement is true and the repair is one clause, "$W$ is self-adjoint, so annihilating the complement is the same as preserving $\Lambda^2U$".

**Verdict: confirmed, with the hypothesis unstated.** It is worth naming rather than waving because H1 is the *only* place the three equalities touch the definition of $\mathcal W_n$ at all (§1), and a reader tracking which hypotheses the equalities need will otherwise conclude they need none.

**C7, the adapted basis in (iii).** The brief asks whether "the bracket lies in the subalgebra" gives "the coefficient against $v_a$ vanishes for $a$ outside", and whether the basis must be adapted. It must, twice over:

1. The phrase "$a$ outside $\Lambda^2U$" has no meaning for a general orthonormal basis $\{v_a\}$ of $\Lambda^2\mathbb R^n$, a basis vector need be neither in $\Lambda^2U$ nor orthogonal to it. The index sets $I$ and $J$ exist only for an adapted basis.
2. Even given a partition, the conclusion $c_{acd}=\langle[v_c,v_d],v_a\rangle=0$ needs $v_a\perp\Lambda^2U$, i.e. it needs the splitting to be orthogonal *and* the basis aligned with it. Both hold for $\{\varphi_{ij}\}$ once $U$ is a coordinate subspace.

The proof never makes the choice. Step (ii) does speak of "the coordinate bivectors $\varphi_{ij}$ with $i<j$ in $U$", which presupposes it, and the reduction to a coordinate $U$ is free by $O(n)$-equivariance of $\lVert\cdot\rVert$, $\#$, $Q$ and $P$. So this is an elision of the same size as C4: **confirmed, with the basis choice unstated**, repairable by one sentence at the head of the proof.

## 6. Step (iv) and the final chain

**C8, first Bianchi.** In the index form the record uses, $W_{ijkl}+W_{jkil}+W_{kijl}=0$ for all $i,j,k,l$. Two features decide the question. It carries **no summation**, so it is a family of identities indexed by four free indices rather than a single contracted statement; and its three terms cycle $i,j,k$ while fixing $l$, so **every index occurring in the identity at $(i,j,k,l)$ already occurs in $(i,j,k,l)$**. Restricting the four free indices to $U$ therefore selects a sub-family, and each member of the sub-family involves only components $W_{\bullet}$ with all indices in $U$, which are exactly the components $W'$ retains. The identity on $U$ involves nothing the restriction threw away. **Confirmed; the brief's worry does not bite, and the reason it does not is the absence of a contraction.**

**C9, pair symmetry.** Same reason, one line shorter: $W'_{ijkl}=W_{ijkl}=W_{klij}=W'_{klij}$ for indices in $U$. Independently, $W'=\iota^*W\iota$ and $(\iota^*W\iota)^{\mathsf T}=\iota^*W^{\mathsf T}\iota=\iota^*W\iota$, a compression of a self-adjoint operator is self-adjoint, with no index work at all. **"Likewise" is adequate here**, and this is the one place in the proof where a one-word justification is the right length.

**C10, Ricci-flatness, the only step in (iv) that is not free.** $\operatorname{Ric}$ is the adjoint of $h\mapsto h\wedge\mathrm{id}$, so in components $\operatorname{Ric}(W)_{ik}\propto\sum_j W_{ijkj}$ with a universal constant, **and the sum runs over the ambient range**. This is the one contraction in (iv), so it is the one place where the restriction could have lost information. For $i,k\in U$,

$$\operatorname{Ric}_n(W)_{ik}\ \propto\ \sum_{j\in U}W_{ijkj}+\sum_{j\notin U}W_{ijkj},$$

and each term of the second sum has $e_i\wedge e_j\in U\wedge U^\perp$, hence vanishes by H5. So $\operatorname{Ric}_m(W')_{ik}=\operatorname{Ric}_n(W)_{ik}=0$. The proof's "the terms of $\operatorname{Ric}$ involving directions outside $U$ vanish with $W$" is exactly this and is correct.

One subtlety the proof passes over without harm: for $h$ supported on $U$, $h\wedge\mathrm{id}_n$ is *not* supported on $\Lambda^2U$, its components $h_{ik}\delta_{jl}$ with $j=l\notin U$ are nonzero. The adjoint computation survives because only $W$'s support is consulted: $\langle h,\operatorname{Ric}_n(W)\rangle=\langle h\wedge\mathrm{id}_n,W\rangle=\langle h\wedge\mathrm{id}_m,W'\rangle=\langle h,\operatorname{Ric}_m(W')\rangle$ for every $h$ on $U$, the middle equality holding because $W$ kills every component where the two differ. **Confirmed.**

**C11, the final chain, on the nose.** The middle equality is where the brief points, and the general fact is genuinely conditional: for the compression map $A\mapsto\iota^*A\iota$, $\langle\iota^*A\iota,\iota^*B\iota\rangle=\operatorname{tr}(\Pi A^{\mathsf T}\Pi B\Pi)$, which equals $\operatorname{tr}(A^{\mathsf T}B)$ only when $\Pi A\Pi=A$ and $\Pi B\Pi=B$. **Both hold here** (for $W$ by §2, for $Q(W)$ by §4) so

$$\langle W,Q(W)\rangle=\operatorname{tr}\!\big(\iota W'\iota^*\cdot\iota\,Q(W')\,\iota^*\big)=\operatorname{tr}\!\big(W'\,Q(W')\big)=\langle W',Q(W')\rangle=P(W'),$$

by cyclicity and $\iota^*\iota=\mathrm{id}$. **Confirmed.** Annihilating the complement is exactly the hypothesis that makes the compression pairing-preserving, so the brief's question has the sharpest possible answer: the condition it asks about is the condition the statement assumes.

## 7. C14, the two definitions of $\#$ in the conventions differ by a factor of two

- *Located.* The definitions block: "$vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$; in the basis above, $(W^\#)_{ab}=\sum c_{acd}c_{bef}W_{ce}W_{df}$."
- *Derived.* Take $W=vv^{\mathsf T}+ww^{\mathsf T}$. By the operator definition and bilinearity, $W^\#=W\#W=0+2(vv^{\mathsf T}\#ww^{\mathsf T})+0=[v,w][v,w]^{\mathsf T}$. By the index formula, the cross terms give $\sum c_{acd}c_{bef}(v_cv_ew_dw_f+w_cw_ev_dv_f)=L_aL_b+(-L_a)(-L_b)=2L_aL_b$ where $L_a=\sum_{c,d}c_{acd}v_cw_d=\langle[v,w],v_a\rangle$; the pure terms vanish by antisymmetry. So the index formula returns $2[v,w][v,w]^{\mathsf T}$.
- *Which is right.* At $W=\mathrm{id}$ the operator definition gives $(\mathrm{id}^\#)_{ab}=\tfrac12\sum_{c,d}c_{acd}c_{bcd}=(n-2)\delta_{ab}$, since $\sum_{c,d}c_{acd}^2=2(n-2)$, the surviving pairs at $a=(1,2)$ being $(1k),(2k)$ for $k\ge3$ in both orders, so $Q(\mathrm{id})=(n-1)\,\mathrm{id}$, the standard normalisation at the round sphere. The index formula gives $2(n-2)\,\mathrm{id}$ and $Q(\mathrm{id})=(2n-3)\,\mathrm{id}$, which is not it. **The operator definition is correct and the index formula is missing a $\tfrac12$.**
- *Screened.* Both computations were reproduced in exact integer arithmetic on $\mathfrak{so}(4)$ from the bracket table: index formula $/$ operator definition $=2/1$ on $W=\varphi_{12}\varphi_{12}^{\mathsf T}+\varphi_{13}\varphi_{13}^{\mathsf T}$, and $\mathrm{id}$ returns $4=2(n-2)$ against $2=n-2$. Reported as a screen of a claim I am recording, not as evidence.
- *Argued the opposite.* "Halved Böhm–Wilking" might be meant as *the index formula is the halved object*, i.e. the unhalved product carries a further $2$. That reading collides with $\mathrm{id}^\#=(n-2)\mathrm{id}$, which is the fixed point of the whole subject, so I do not think it survives.
- *Impact here: none.* Any fixed positive multiple of $\#$ restricts identically, so C5, C6, C11 and the statement are untouched. **Impact downstream: real.** Unlike the pairing rescaling of §3, this factor multiplies only the $\#$ half of $Q=W^2+W^\#$, so it changes $\theta$'s value non-uniformly and cannot be absorbed. Any recorded numerical $\theta$ depends on which of the two the computing code used.

## 8. C12 and the edges

| Edge | Reading |
| --- | --- |
| $\dim U=n$ | $U^\perp=0$, H5 is vacuous, $\iota=\mathrm{id}$, $W'=W$. All three equalities are identities and the conclusion reads correctly. |
| $\dim U\le3$ | $\mathcal W_m=0$ for $m\le3$, so step (iv) gives $W'\in\mathcal W_{\dim U}=0$, whence $W'=0$ and therefore $W=\iota W'\iota^*=0$. **The hypothesis forces $W=0$ on this whole branch.** The norm and $P$ clauses read $0=0$; the $\theta$ clause reads $0/0=0/0$. |
| $\dim U=4$ | Nothing in (i)–(iv) sees the $\Lambda^\pm$ splitting; the argument is indifferent to it and the statement holds. It is worth noting that the splitting exists in $\Lambda^2U$ and in $\Lambda^2\mathbb R^4$ for different reasons, and the statement never has to compare them. |
| odd $\dim U$ | No step has a parity in it, the bracket table, the contraction and the compression identities are dimension-blind. Holds. |
| $W=0$ | $\theta=P/\lVert W\rVert^3$ is $0/0$ on both sides. |

**C12, the brief's question, is the $\theta$ equality stated without a nonvanishing hypothesis?** Yes. The statement quantifies over $W\in\mathcal W_n$ with no exclusion of $0$ and displays $\theta(W')=\theta(W)$ unconditionally, and $\theta$ is undefined at $W=0$ under its own definition. Two things stop this from being pedantry:

1. $W=0$ satisfies H1–H5 for **every** subspace $U$, so it is not an object one has to go looking for; it is in the domain of quantification at every $U$ simultaneously.
2. The branch $\dim U\le3$ is not an isolated point of the domain but an entire admissible range of $U$, and on all of it the hypothesis *forces* $W=0$, so the $\theta$ clause is undefined on the whole branch, and the reader who checks the small cases first meets nothing else.

**Repair:** add "$W\neq0$" to the $\theta$ clause, or state $\theta$'s equality as "and $\theta(W')=\theta(W)$ whenever either side is defined". This is the one item that keeps the overall verdict off `PROVEN`.

## 9. C16, the reading of "vanishes on $u\wedge u^\perp$", and a closed-form witness that it matters

"$W$ vanishes on a subspace $V$" admits two readings for a symmetric operator: **annihilation**, $W|_V=0$, and **quadratic-form vanishing**, $\langle W\xi,\eta\rangle=0$ for $\xi,\eta\in V$, i.e. $\Pi_VW\Pi_V=0$. For a symmetric operator these are genuinely different, the second permits $W$ to map $V$ isomorphically onto $V^\perp$.

**Under the second reading the statement is false.** Take $n=4$, $U=\operatorname{span}(e_1,e_2,e_3)$, $U^\perp=\mathbb Re_4$, and

$$W=2\big(\varphi_{12}\varphi_{34}^{\mathsf T}+\varphi_{34}\varphi_{12}^{\mathsf T}\big)-\big(\varphi_{13}\varphi_{42}^{\mathsf T}+\varphi_{42}\varphi_{13}^{\mathsf T}\big)-\big(\varphi_{14}\varphi_{23}^{\mathsf T}+\varphi_{23}\varphi_{14}^{\mathsf T}\big).$$

Equivalently, in the Singer–Thorpe description $W=W^+\oplus W^-$ with $W^+=\operatorname{diag}(2,-1,-1)$ on $\Lambda^+$ and $W^-=-W^+$ on $\Lambda^-$, in the basis $\omega_t^\pm=\tfrac1{\sqrt2}(\varphi_{12}\pm\varphi_{34}),\ \tfrac1{\sqrt2}(\varphi_{13}\pm\varphi_{42}),\ \tfrac1{\sqrt2}(\varphi_{14}\pm\varphi_{23})$; the displayed form follows from $\omega^+(\omega^+)^{\mathsf T}-\omega^-(\omega^-)^{\mathsf T}=xy^{\mathsf T}+yx^{\mathsf T}$ for $\omega^\pm=\tfrac1{\sqrt2}(x\pm y)$.

- $W\in\mathcal W_4$: symmetric by construction; first Bianchi is $\operatorname{tr}W^+=\operatorname{tr}W^-$, here $0=0$; Ricci-flat because the $\Lambda^+\!\to\!\Lambda^-$ block is zero and the scalar part is $\operatorname{tr}W^++\operatorname{tr}W^-=0$.
- $\lVert W\rVert^2=\operatorname{tr}(W^+)^2+\operatorname{tr}(W^-)^2=6+6=12$.
- The compression to $U\wedge U^\perp=\operatorname{span}(\varphi_{14},\varphi_{24},\varphi_{34})$ is $\tfrac12(W^++W^-)=0$ in the matched basis, so $W$ "vanishes on $u\wedge u^\perp$" for $u=e_4$ in the quadratic-form sense, and $\Lambda^2U^\perp=0$.
- The compression to $\Lambda^2U$ is also $\tfrac12(W^++W^-)=0$, so $W'=0$ and $\lVert W'\rVert=0\neq\sqrt{12}=\lVert W\rVert$.

**Screened** in exact rational arithmetic on an object constructed for this purpose: symmetry, first Bianchi over all $4^4$ index quadruples, $\operatorname{Ric}=0$, $\lVert W\rVert^2=12$, and both compressions identically zero. Reported as a screen.

- *Argued the opposite, and it wins.* The statement's own gloss ("so that $W$ is supported on $\Lambda^2U$"), pins the annihilation reading, and under that reading this $W$ fails the hypothesis outright: $W\varphi_{14}=-\varphi_{23}\neq0$. **So this is not a defect of the statement.** It is a demonstration that the gloss is load-bearing rather than decorative, and that the sentence would be false if the gloss were dropped as a restatement of the vanishing clause. As written the clause presents support as a *consequence* ("so that") of the vanishing, which it is only under the annihilation reading and only with H1 (§5). **Verdict: the wording is correct as it stands and should not be compressed.**

## 10. C13, the disclaimer

The entry records that it does *not* claim the operator identity $Q(\mathrm{pad}\,W')=\mathrm{pad}\,Q(W')$ for arbitrary tensors, and the brief asks whether the weaker scalar statement is all the displayed equalities need.

**Two answers, and they cut against the disclaimer.**

1. **The proof does not take the lighter route, because there is no lighter route on offer.** Step (iii) proves $W^2=\iota(W')^2\iota^*$ and $W^\#=\iota(W')^\#\iota^*$ (that *is* $Q(\mathrm{pad}\,W')=\mathrm{pad}\,Q(W')$, entry by entry) and then §6 reads a scalar off it. The scalar equality is a corollary of the operator identity here, not an independently cheaper fact.
2. **What (i)–(iii) prove is already the general statement.** Those three steps use H4 and H5 and (silently) H1; they never touch first Bianchi or Ricci-flatness. So the operator identity holds for **every symmetric operator supported on $\Lambda^2U$**, Weyl or not, and, inspecting §4, the only property of $\Lambda^2U$ it uses is that $\Lambda^2U$ is a Lie subalgebra of $\mathfrak{so}(n)$ with the induced pairing.

The disclaimer is defensible only on the narrowest reading of "arbitrary tensors": the identity does fail for operators *not* supported on $\Lambda^2U$, where $Q(\iota^*W\iota)\neq\iota^*Q(W)\iota$ already at the $W^2$ term. But nobody would read $Q(\mathrm{pad}\,W')=\mathrm{pad}\,Q(W')$ as a statement about unpadded tensors, the notation $\mathrm{pad}$ is right there. **Verdict: refuted as scoped.** The entry disowns a result its own proof establishes, and the cost is concrete: a later consumer needing the operator identity will believe it has to be proved afresh.

## 11. C15 and item 8, the statement against the named families

- **Sphere products $W_{p,q}$**, $p+q=m$, padded into $\mathbb R^n$: H5 holds with $U=\mathbb R^m$, the conclusion applies, and its content is precisely the record's habit of quoting one $\theta$ for the family independently of the ambient $n$. No obstruction.
- **$W_{\mathbb{CP}^k}$**, $m=2k$, padded: identical; nothing in (i)–(iv) is sensitive to the Kähler structure, and $\dim U$ even is not used.
- **Paddings of paddings.** For $U''\subseteq U'\subseteq\mathbb R^n$, H5 for $U''$ in $\mathbb R^n$ implies H5 for $U''$ in $U'$ and H5 for $U'$ in $\mathbb R^n$, and applying the statement twice or once gives the same three values, because each equals the ambient value. **The statement composes**, so no route-dependence enters when the record pads a padded tensor.
- **Subalgebra-Casimir tensors.** These are supported on a subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$, and $\mathfrak h=\Lambda^2U$ only when $\mathfrak h=\mathfrak{so}(U)$. **The instructive case is $\mathfrak h=\Lambda^+\cong\mathfrak{su}(2)\subset\mathfrak{so}(4)$**: a subalgebra, and not $\Lambda^2U$ for any $U\subseteq\mathbb R^4$, since $\Lambda^2U$ at $\dim U=3$ is $\operatorname{span}(\varphi_{12},\varphi_{13},\varphi_{23})$, which is not self-dual. So H5 fails and the statement is silent, correctly. This marks the boundary sharply: **the hypothesis is geometric support, strictly stronger than algebraic support on a subalgebra**, and §4 shows steps (i)–(iii) would still run on the weaker one while (ii)'s target space and (iv) would have nothing to land in.
- **Tori.** Flat, so $W=0$; the statement applies at every $U$, the norm and $P$ clauses read $0=0$, and the $\theta$ clause is undefined, the family is a standing instance of the C12 hole rather than a test of anything else.

## 12. Item 7, a large kernel, and whether $U$ is determined

**Every instance of this statement sits on the degenerate stratum.** If $\dim U=m<n$ then $\ker W\supseteq(\Lambda^2U)^\perp$, so $\dim\ker W\ge\binom n2-\binom m2>0$. The statement therefore never applies to an operator of full rank except in the vacuous case $U=\mathbb R^n$, the record's recurring obstruction is not incidental here, it is the hypothesis.

**$U$ is not determined by $W$.** If $U$ satisfies H5 then so does every $U_1\supseteq U$, since $U_1^\perp\subseteq U^\perp$ makes H5 a weaker demand. So the admissible subspaces form an up-closed family. A minimal one exists: if $W$ is supported on $\Lambda^2U_1$ and on $\Lambda^2U_2$ then $\operatorname{im}W\subseteq\Lambda^2U_1\cap\Lambda^2U_2=\Lambda^2(U_1\cap U_2)$, and by self-adjointness $\ker W=(\operatorname{im}W)^\perp\supseteq(\Lambda^2(U_1\cap U_2))^\perp$, so $W$ is supported on $\Lambda^2(U_1\cap U_2)$ and $U_1\cap U_2$ is admissible.

**This non-uniqueness is harmless, and the statement is what makes it harmless.** All three quantities computed at any admissible $U$ equal the ambient values, hence each other. Read the other way round, that is the content of the result: $\theta$ is an invariant of $W$ that does not know which $\mathbb R^n$ it was written in, subject to $W\neq0$, which is C12 again.

## 13. Item 9, what would falsify it, and what I did to look

**The falsifier.** A $W\in\mathcal W_n$, supported on $\Lambda^2U$ in the annihilation sense, with $\theta(W')\neq\theta(W)$. Since $\lVert W'\rVert=\lVert W\rVert$ is forced by the block form (§3), such an object needs $P(W')\neq P(W)$, hence ($W^2$ restricting unconditionally), it needs $(W^\#)|_{\Lambda^2U}\neq(W')^\#$. By §4 that requires one of exactly two things:

1. a bracket $[v_c,v_d]$ with $c,d\in I$ having a nonzero component outside $\Lambda^2U$, i.e. $\Lambda^2U$ failing to be a subalgebra, or the splitting failing to be orthogonal; or
2. a term in $\sum c_{acd}c_{bef}W_{ce}W_{df}$ with some index outside $I$ surviving, i.e. $W$ having a nonzero entry in the mixed or outer block.

**Both routes are closed in closed form**, the first by the bracket table, the second by H5 together with self-adjointness. So no falsifier of the statement as glossed exists, and the search space is empty rather than merely unexplored.

**What I did to look.** Computed the bracket table exactly and read off which $\varphi$'s can appear; checked all three summands of the orthogonal splitting against H5; checked that $\operatorname{Ric}$ is the one contraction running over the ambient range and that its extra terms are mixed-block entries; and, having established that the only remaining freedom was in the *reading* of H5, attacked that instead, where a falsifier does exist, exhibited in closed form in §9 with $\lVert W\rVert^2=12$ and $W'=0$. That is the object a reader should have in mind: **the statement is false for the quadratic-form reading of its hypothesis and true for the annihilation reading, and the gloss is the only thing separating them.**

## Verdict

**PROVEN, hypotheses corrected.**

The norm and $P$ equalities and the membership clause are proven outright by the proof as written, modulo two elisions that are one clause each. The $\theta$ equality is proven once $W\neq0$ is added, and is undefined without it on a whole branch of its own quantification. The four items to fold back:

1. **Add $W\neq0$ to the $\theta$ clause** (C12), the only item affecting what the statement asserts.
2. **Name self-adjointness in step (i)** (C2) and **the adapted basis in step (iii)** (C7); both are one sentence, and both hypotheses are silently in use.
3. **Withdraw or re-scope the disclaimer** (C13): steps (i)–(iii) prove $Q(\mathrm{pad}\,W')=\mathrm{pad}\,Q(W')$ for every symmetric operator supported on $\Lambda^2U$.
4. **Fix the index formula for $\#$ in the conventions** (C14): it carries twice the halved Böhm–Wilking product, against $\mathrm{id}^\#=(n-2)\,\mathrm{id}$. Harmless to this statement, and not harmless to any recorded value of $\theta$.
