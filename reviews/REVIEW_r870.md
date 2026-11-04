# REVIEW r870: the moment reduction of $\theta$, and the class-variable system at three eigenvalues

*Reviewer r870, independent and adversarial. The brief was cold: I read the brief and nothing else of the record, no findings file, no plan, no other review, no attempts notebook. No numerical work was done beyond screening claims I was about to record, in exact rational or symbolic arithmetic, on objects I constructed for the screen. Every value in this report is exact and every combinatorial factor below was derived from the definition of the contraction before any screen was run. Log: [agent_logs/review-r870-moments.log](../agent_logs/review-r870-moments.log).*

## Claim table

| # | Claim under audit | Verdict |
|---|---|---|
| 1 | $\theta=\sum_ia_i\mu_i^3+\tfrac12m_3$, and the $\tfrac12$ | **CONFIRMED** |
| 2 | $\sum_{jk}t_{ijk}=2(n-2)a_i$, hence $m_0=2(n-2)N$ and $m_1=0$ | **CONFIRMED** |
| 3 | $\sum_{jk}\mu_jt_{ijk}=-2a_i\mu_i$, hence $m_2=-2$ at unit norm | **CONFIRMED** |
| 4 | Class factors $\tfrac13$ for $m_1$, $\tfrac13$ for $m_2$, $1$ for $m_3$ | **CONFIRMED** at all three class types |
| 5a | Marginal in class form, $\tfrac13\sum_Sm_i(S)v_S=2(n-2)a_i$ | **CONFIRMED** |
| 5b | Relation (B) in class form, the factor $\tfrac16$ | **CONFIRMED** |
| 5c | "its inner factor being the average of the remaining two values" | **DEFECT.** It is the SUM. The equation is right, the gloss is wrong by a factor of two |
| 6 | Caps $\sum_kt_{ijk}\le a_ia_j$ off the diagonal, $a_i(a_i-1)$ on it | **REFUTED as stated.** These are the decomposable-locus caps. The general caps are $2a_ia_j$ and $2a_i(a_i-1)$, and $W_{\mathbb{CP}^2}$ violates the stated ones at three of six pairs, each by exactly two |
| 7a | Exactly four classes carry $\sigma_3>0$ at $p>0>-q\ge-r$, namely $111,122,123,133$ | **CONFIRMED** |
| 7b | "no negative class is free of it except the three all-negative ones" | **DEFECT.** There are FOUR all-negative classes: $222,223,233,333$ |
| 8 | The programme is bounded through $m_0$ and the $i=1$ marginal, without the caps | **CONFIRMED**, and stronger: the $i=1$ marginal alone suffices, $m_0$ being its own consequence |
| 9 | Summing (C) against $\mu_i$ returns $m_3=2\theta-2\sum_ia_i\mu_i^3$, so (C) is circular | **CONFIRMED** for that one combination. The blanket ban on (C) is **OVER-BROAD**: the other $L-1$ components are genuine constraints |
| 10 | The class system at two values reproduces given 16 | **CONFIRMED**, including $(n-1)\sqrt{s/(N(N-s))}$ with $s=a_1$, and both endpoints $\tfrac n2$ and $\tfrac{n(n-2)}4$ |
| 11a | "the feasible polytope is four-dimensional before the caps" | **DEFECT.** The six equalities have rank five, not six, so the affine set is FIVE-dimensional |
| 11b | Degeneracies: $a_i=0$, equal $\mu$'s, a zero eigenvalue, the mirror case | **PARTIAL.** $a_i=0$ self-reduces correctly. The sign pattern $(+,-,0)$ is uncovered and it is $W_{\mathbb{CP}^2}$'s own pattern. The mirror case does NOT run the same way: it has six positive classes |
| 12 | $t_{ijk}$ is never defined in the block | **DEFECT (gap).** Only the block-sum reading makes every stated factor true, and $t$ is not hollow |
| 13 | The reduction itself: bounding $\theta$ is bounding a third moment under pinned lower moments | **CONFIRMED**, and on $W_{\mathbb{CP}^2}$'s spectrum the relaxation with the CORRECT caps is exactly tight at $\sqrt{3/2}$ |

**One line.** The reduction stands and every combinatorial factor in it is right, including the two that could most easily have been halved, but the caps as written are the decomposable-locus caps used on a general problem and the record's own $W_{\mathbb{CP}^2}$ breaks them by exactly a factor of two, so any bound derived from them would be false.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector. The inner product is $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$.
- $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$, and at orthonormal $u,v$ this is a unit bivector with $(u\wedge v)(u\wedge v)^{\mathsf T}=\Pi_P$.
- $\mathcal W_n$ is the space of algebraic Weyl tensors: symmetric operators on $\Lambda^2\mathbb R^n$, first Bianchi, Ricci-flat, trace-free. $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$, criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.
- $\sqrt{3/2}=1.224745$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. $N=\binom n2$.
- $c_{\alpha\beta\gamma}=\langle[\omega_\alpha,\omega_\beta],\omega_\gamma\rangle$ and $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$, totally symmetric and hollow.

## Hypothesis inventory

What each piece of the block actually needs, separated so that a later reader can see which claims survive dropping which hypothesis.

| Ingredient | Needs |
|---|---|
| $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ (the marginal, [Lemma L153](../findings/bounds.md)) | Orthonormality of the basis alone. It is the diagonal of $\mathrm{Id}\#\mathrm{Id}=(n-2)\mathrm{Id}$, true of every orthonormal basis of $\Lambda^2\mathbb R^n$ and of no property of $W$ |
| Relation (B), $\sum_{\beta\gamma}\lambda_\beta T_{\alpha\beta\gamma}=-2\lambda_\alpha$ | An orthonormal eigenbasis, plus $W\#\mathrm{Id}=-W$, which is first Bianchi together with Ricci-flatness |
| $m_1=0$ | The marginal, plus $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$, which is itself the trace of given 2 |
| $m_2=-2$ | Relation (B) plus unit norm. Nothing else |
| The objective $\theta=\sum_ia_i\mu_i^3+\tfrac12m_3$ | Given 14, that is the definition of $\#$ as the Lie-algebra square in the brief's normalisation, plus unit norm. Criticality is NOT needed |
| The class factors $\tfrac13,\tfrac13,1,\tfrac13,\tfrac16$ | Total symmetry of $T$ and nothing else. They are counting identities |
| The caps | The pair cap $\sum_\gamma T_{\alpha\beta\gamma}\le2$ in general, $\le1$ on the decomposable locus, plus hollowness of $T$ on the diagonal block |
| Relation (C) | Criticality. Unlike the above it is not available off the critical set |
| Level sets $a_i>0$, values $\mu_i$ distinct | Assumed throughout by the class construction, and the rank-five count in §11 needs the $\mu_i$ pairwise distinct |

## 1. The objective, and what the $\tfrac12$ rests on

Write $I_i$ for the $i$-th level set of the spectrum, $a_i=\lvert I_i\rvert$, and define
$$t_{ijk}=\sum_{\alpha\in I_i}\sum_{\beta\in I_j}\sum_{\gamma\in I_k}T_{\alpha\beta\gamma},$$
the block sum of $T$ over level sets. This is the only reading of $t_{ijk}$ under which the block's own marginal $\sum_{jk}t_{ijk}=2(n-2)a_i$ is true, so it is the definition I audit against, and §12 records that the block never states it. Then $m_3=\sum_{ijk}\mu_i\mu_j\mu_kt_{ijk}=\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}$ term by term, since every $\alpha\in I_i$ carries $\lambda_\alpha=\mu_i$, and $\sum_\alpha\lambda_\alpha^3=\sum_ia_i\mu_i^3$. Given 14 then gives the objective exactly as stated.

The $\tfrac12$ is the constant in the definition of $\#$, not a symmetry factor for double counting, and this is the place where a factor of two is most easily lost. With $R$ diagonal in the eigenbasis, the Lie-algebra square $(R^\#)_{kk}=\tfrac12\sum_{c,d,e,f}c_{kce}c_{kdf}R_{cd}R_{ef}$ collapses to $\tfrac12\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}$, the double sum running over ALL ordered pairs with hollowness killing $\beta=\gamma$. Equivalently $(W^\#)_{kk}=\sum_{\beta<\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}$: a reader who restricts to unordered pairs must drop the $\tfrac12$, and a reader who keeps ordered pairs must keep it. I checked the same normalisation reproduces the two other diagonals the record uses. Polarising, $(W\#\mathrm{Id})_{kk}=\tfrac12\cdot\tfrac12\sum_{cd}T_{kcd}(\lambda_c+\lambda_d)=\tfrac12\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}$, so $W\#\mathrm{Id}=-W$ is exactly relation (B) with its $-2$, and $(\mathrm{Id}\#\mathrm{Id})_{kk}=\tfrac12\cdot2(n-2)=n-2$ is exactly $\mathrm{Id}\#\mathrm{Id}=(n-2)\mathrm{Id}$. All three constants are the same constant, so the $\tfrac12$ cannot be adjusted in one place alone.

Independent confirmation on the record's own extremal object, computed from matrices rather than from the record's numbers. With $\varphi_{ab}=E_{ba}-E_{ab}$ and $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, the self-dual basis $u_1=(\varphi_{12}+\varphi_{34})/\sqrt2$, $u_2=(\varphi_{13}+\varphi_{42})/\sqrt2$, $u_3=(\varphi_{14}+\varphi_{23})/\sqrt2$ is orthonormal, and by direct expansion of the commutator, using $[\varphi_{ab},\varphi_{ac}]=\varphi_{bc}$ in this convention,
$$[u_1,u_2]=\tfrac12(\varphi_{23}+\varphi_{14}+\varphi_{14}+\varphi_{23})=\varphi_{23}+\varphi_{14}=\sqrt2\,u_3,$$
so $T_{u_1u_2u_3}=2$, and the same on $\Lambda^-$, with all cross-chirality structure constants zero. For $W_{\mathbb{CP}^2}$, spectrum $(2c,-c,-c,0,0,0)$ with $c=1/\sqrt6$ from unit norm, this gives $m_3=24c^3$ and $\theta=6c^3+12c^3=18c^3=3/\sqrt6=\sqrt{3/2}$, matching given 5 exactly. With the $\tfrac12$ removed one would get $30c^3=2.041$, and with it doubled $12c^3=0.8165$. The objective's constant is therefore pinned by an established value of the record and is right.

**Verdict: CONFIRMED.** The $\tfrac12$ rests on the ordered double sum in the Lie-algebra square, is shared with relation (B)'s $-2$ and with $\mathrm{Id}\#\mathrm{Id}=(n-2)\mathrm{Id}$, and reproduces $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$.

## 2. $m_0$ and $m_1$

I re-derived the marginal from the structure constants rather than citing it. In the basis $\{\varphi_{ab}\}_{a<b}$ the commutator $[\varphi_{ab},\varphi_{ac}]=\varphi_{bc}$ and $[\varphi_{ab},\varphi_{cd}]=0$ for $\{a,b\}\cap\{c,d\}=\emptyset$, so $T_{\alpha\beta\gamma}=1$ exactly when the three planes are the three coordinate $2$-planes inside a common $3$-set of indices, and $0$ otherwise. Fixing $\alpha=\{a,b\}$, the ordered pairs $(\beta,\gamma)$ with $T\ne0$ are $(\{a,c\},\{b,c\})$ and $(\{b,c\},\{a,c\})$ for each of the $n-2$ choices of $c$, giving $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$. Since this is the diagonal of the basis-free identity $\mathrm{Id}\#\mathrm{Id}=(n-2)\mathrm{Id}$, it holds at every index of every orthonormal basis, which is what the level-set form needs.

Summing over the level set, $\sum_{jk}t_{ijk}=\sum_{\alpha\in I_i}\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)a_i$, as claimed. Hence $m_0=\sum_i2(n-2)a_i=2(n-2)N$ and
$$m_1=\sum_i\mu_i\sum_{jk}t_{ijk}=2(n-2)\sum_ia_i\mu_i=0.$$
The only extra input is $\sum_ia_i\mu_i=0$, which is $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$. That needs nothing beyond Ricci-flatness: taking the trace of given 2 gives $\sum_\mu\lambda_\mu\cdot2\dim E_\mu=2\mathop{\mathrm{tr}}W=0$. So $m_1=0$ needs the marginal and Ricci-flatness, and in particular no decomposability, no criticality and no unit norm. **CONFIRMED.**

## 3. $m_2=-2$

At the level-set granularity relation (B) reads $\sum_{jk}\mu_jt_{ijk}=\sum_{\alpha\in I_i}\sum_{\beta\gamma}\lambda_\beta T_{\alpha\beta\gamma}=\sum_{\alpha\in I_i}(-2\lambda_\alpha)=-2a_i\mu_i$, as claimed, the step being valid because (B) holds at EVERY index and not only on average. Then
$$m_2=\sum_i\mu_i\left(\sum_{jk}\mu_jt_{ijk}\right)=-2\sum_ia_i\mu_i^2=-2\lVert W\rVert^2=-2.$$
Unit norm is indeed the only extra input beyond (B). I screened this at $n=6$ on a circulant Ricci-flat coordinate spectrum with three distinct values, $\lambda$ equal to $1,2,-6$ by cyclic distance and multiplicities $(6,6,3)$: there $\lVert W\rVert^2=138$ and $m_2=-276=-2\cdot138$ exactly, and (B) held at all fifteen indices. **CONFIRMED.**

I record one consequence the block does not draw. Because (B) and the marginal hold off the critical set, the moment problem they define bounds $\theta$ over ALL Ricci-flat unit-norm $W$ with the given spectrum, not merely the critical ones. That is a strengthening, since the supremum of $\theta$ is what the programme wants.

## 4. The class factors, derived from the ordered-triple counts

Let $S$ run over the ten multisets of size three from $\{1,2,3\}$, let $m_i(S)$ be the multiplicity of $i$ in $S$, let $n_S$ be the number of ORDERED triples of class $S$, and let $t_S$ be the common value of $t_{ijk}$ on that class, common because $t$ inherits total symmetry from $T$. Then $v_S=n_St_S$, with
$$n_S=1\ \text{(three equal)},\qquad n_S=3\ \text{(two equal)},\qquad n_S=6\ \text{(all distinct)}.$$

The general mechanism is one symmetrisation. Since $t$ is totally symmetric,
$$m_1=\sum_{ijk}\mu_it_{ijk}=\tfrac13\sum_{ijk}(\mu_i+\mu_j+\mu_k)t_{ijk}=\tfrac13\sum_S\sigma_1(S)v_S,$$
$$m_2=\sum_{ijk}\mu_i\mu_jt_{ijk}=\tfrac13\sum_{ijk}(\mu_i\mu_j+\mu_i\mu_k+\mu_j\mu_k)t_{ijk}=\tfrac13\sum_S\sigma_2(S)v_S,$$
and $m_3=\sum_S\sigma_3(S)v_S$ with no factor, because the product is already class-invariant. Here $\sigma_r(S)$ is the $r$-th elementary symmetric function of the three values WITH multiplicity, so $\sigma_1(112)=2\mu_1+\mu_2$, $\sigma_2(112)=\mu_1^2+2\mu_1\mu_2$ and $\sigma_3(112)=\mu_1^2\mu_2$. The claimed $\tfrac13,\tfrac13,1$ are right. The brief asks for the three class types separately, and the symmetrisation hides where a miscount would live, so here they are unsymmetrised.

**Three equal, $S=111$.** One ordered triple, $v_{111}=t_{111}$. Direct: contribution $\mu_1t_{111}$ to $m_1$ and $\mu_1^2t_{111}$ to $m_2$. Class form: $\tfrac13\sigma_1v=\tfrac13(3\mu_1)t_{111}=\mu_1t_{111}$, and $\tfrac13\sigma_2v=\tfrac13(3\mu_1^2)t_{111}=\mu_1^2t_{111}$. Agree.

**Two equal, $S=112$.** Three ordered triples $(1,1,2),(1,2,1),(2,1,1)$, so $v_{112}=3t_{112}$. Direct into $m_1$, whose weight is on the first index: $\mu_1+\mu_1+\mu_2$, giving $(2\mu_1+\mu_2)t_{112}$. Class form: $\tfrac13(2\mu_1+\mu_2)\cdot3t_{112}$. Agree. Direct into $m_2$, weight on the first two indices: $\mu_1^2+\mu_1\mu_2+\mu_2\mu_1=(\mu_1^2+2\mu_1\mu_2)t_{112}$. Class form: $\tfrac13(\mu_1^2+2\mu_1\mu_2)\cdot3t_{112}$. Agree. Note that the direct count is NOT $3\mu_1$ or $3\mu_1^2$: the $\tfrac13$ is exactly what converts the per-position count into the class-invariant symmetric function, and it is not a double-counting correction.

**All distinct, $S=123$.** Six ordered triples, $v_{123}=6t_{123}$. Each index occupies the first slot in exactly two of them, so $m_1$ receives $2(\mu_1+\mu_2+\mu_3)t_{123}=\tfrac13\sigma_1\cdot6t_{123}$. Each ordered pair of distinct indices occupies the first two slots exactly once, so $m_2$ receives $2(\mu_1\mu_2+\mu_1\mu_3+\mu_2\mu_3)t_{123}=\tfrac13\sigma_2\cdot6t_{123}$. Agree. For $m_3$ all six orderings give $\mu_1\mu_2\mu_3$, so the contribution is $\sigma_3\cdot6t_{123}=\sigma_3v_{123}$, factor $1$.

**Verdict: CONFIRMED**, all three factors, at all three class types. Screened at $n=6$ on the circulant example above: the class forms of $m_0,m_1,m_2,m_3$ agreed with the direct sums over $T$ exactly.

## 5. The six equalities in class form, and the $\tfrac16$

The count that both equalities rest on: the number of ordered triples of class $S$ whose FIRST entry is $i$ is $n_Sm_i(S)/3$, because among the $n_S$ arrangements each of the three positions is occupied by $i$ in the same proportion $m_i(S)/3$. Checks: $S=111,i=1$ gives $1\cdot3/3=1$, and indeed only $(1,1,1)$; $S=112,i=1$ gives $3\cdot2/3=2$, and indeed $(1,1,2),(1,2,1)$; $S=123,i=1$ gives $6\cdot1/3=2$, and indeed $(1,2,3),(1,3,2)$.

**The marginal.** $\sum_{jk}t_{ijk}=\sum_S\frac{n_Sm_i(S)}{3}t_S=\tfrac13\sum_Sm_i(S)v_S$, so the equality $\tfrac13\sum_Sm_i(S)v_S=2(n-2)a_i$ is right. Consistency: summing over $i$ gives $\tfrac13\sum_S3v_S=m_0$ against $2(n-2)\sum_ia_i=2(n-2)N$, which matches §2.

**Relation (B).** Using symmetry of $t$ in its last two slots, and writing the remaining multiset after removing one copy of $i$,
$$\sum_{jk}\mu_jt_{ijk}=\tfrac12\sum_{jk}(\mu_j+\mu_k)t_{ijk}=\tfrac12\sum_S\frac{n_Sm_i(S)}{3}\big(\sigma_1(S)-\mu_i\big)t_S=\tfrac16\sum_Sm_i(S)\big(\sigma_1(S)-\mu_i\big)v_S.$$
So the $\tfrac16$ IS right, and it is $\tfrac13\cdot\tfrac12$: one third from the first-slot count, one half from symmetrising the remaining two slots.

**5c, the gloss.** The inner factor $\sigma_1(S)-\mu_i=\mu_j+\mu_k$ is the SUM of the remaining two values, not their average. The brief says "its inner factor being the average of the remaining two values", and that is wrong by a factor of two. The equation as printed is correct, so nothing downstream of it is affected, but the prose and the formula cannot both be implemented: with the average as inner factor the prefactor must be $\tfrac13$. A reader who trusts the words over the symbols gets exactly half the right value. I verified the size of the discrepancy on the $n=6$ example: at $i=1$ the correct class form returns $-24$, matching $-2a_1\mu_1=-2\cdot6\cdot2$, whereas the average reading returns $-12$ and the $\tfrac13$ reading returns $-48$. The fix is one word, or writing the equality as $\tfrac13\sum_Sm_i(S)\frac{\sigma_1(S)-\mu_i}{2}v_S=-2a_i\mu_i$.

Hand checks of the second equality at each class type, since this is the factor most at risk. $S=111,i=1$: direct $\mu_1t_{111}$, class form $\tfrac16\cdot3\cdot2\mu_1\cdot t_{111}=\mu_1t_{111}$. $S=112,i=1$: direct $(\mu_1+\mu_2)t_{112}$ from $(1,1,2)$ and $(1,2,1)$, class form $\tfrac16\cdot2\cdot(\mu_1+\mu_2)\cdot3t_{112}$. $S=112,i=2$: direct $\mu_1t_{112}$ from $(2,1,1)$ alone, class form $\tfrac16\cdot1\cdot2\mu_1\cdot3t_{112}=\mu_1t_{112}$. $S=123,i=1$: direct $(\mu_2+\mu_3)t_{123}$, class form $\tfrac16\cdot1\cdot(\mu_2+\mu_3)\cdot6t_{123}$. All agree.

**Verdict: 5a CONFIRMED, 5b CONFIRMED, 5c DEFECT (prose only, factor of two).**

## 6. The caps, and where hollowness enters

The pair marginal is $\sum_kt_{ijk}=\sum_{\alpha\in I_i}\sum_{\beta\in I_j}\big(\sum_\gamma T_{\alpha\beta\gamma}\big)$. Given 15 supplies $\sum_\gamma T_{\alpha\beta\gamma}\le2$ in general and $\le1$ on the decomposable locus. Counting the ordered pairs $(\alpha,\beta)$:

- $i\ne j$: there are $a_ia_j$ of them, all with $\alpha\ne\beta$ automatically, so $\sum_kt_{ijk}\le2a_ia_j$ in general and $\le a_ia_j$ on the decomposable locus.
- $i=j$: there are $a_i^2$ ordered pairs, of which the $a_i$ diagonal ones contribute nothing because $T_{\alpha\alpha\gamma}=0$. **This is the only place hollowness enters**, and it enters correctly: $a_i(a_i-1)$ pairs survive, so $\sum_kt_{iik}\le2a_i(a_i-1)$ in general and $\le a_i(a_i-1)$ on the decomposable locus.

So the diagonal STRUCTURE of the claim is right and hollowness is used in the right place, but the stated caps are the decomposable-locus caps, a factor of two below the general ones, and the block applies them to a problem that assumes no decomposability anywhere else: given 12, given 14 and given 15's marginal and (B) all hold without it. This is not a hypothetical exposure. $W_{\mathbb{CP}^2}$ refutes the stated caps in closed form. Its eigenbasis is $u_1,u_2,u_3$ on $\Lambda^+$ and any orthonormal $w_1,w_2,w_3$ on $\Lambda^-$, none of them decomposable, with $T_{u_1u_2u_3}=T_{w_1w_2w_3}=2$ as computed in §1 and all other entries zero. Level sets $I_1=\{u_1\}$, $I_2=\{u_2,u_3\}$, $I_3=\Lambda^-$, so $(a_1,a_2,a_3)=(1,2,3)$ and $(\mu_1,\mu_2,\mu_3)=(2c,-c,0)$. Then

| pair | $\sum_kt_{ijk}$ | stated cap | general cap |
|---|---|---|---|
| $(1,2)$ | $4$ | $a_1a_2=2$ | $2a_1a_2=4$ |
| $(2,2)$ | $4$ | $a_2(a_2-1)=2$ | $2a_2(a_2-1)=4$ |
| $(3,3)$ | $12$ | $a_3(a_3-1)=6$ | $2a_3(a_3-1)=12$ |

Three violations, each by exactly two, and the general caps hold with equality at all three. The class-variable form makes the same point: $\sum_kt_{ijk}=\tfrac16\sum_Sm_i(S)\big(m_j(S)-\delta_{ij}\big)v_S$, which for $(i,j)=(1,2)$ is $\tfrac13v_{122}+\tfrac16v_{123}$, and $W_{\mathbb{CP}^2}$ has $v_{122}=12$ against the stated cap's $v_{122}\le6$.

The consequence is quantitative and severe. On $W_{\mathbb{CP}^2}$'s spectrum the only class with $\sigma_3>0$ that survives the diagonal constraint at $i=1$ is $122$, with $\sigma_3=\mu_1\mu_2^2=2c^3$, and the stated cap would give $m_3\le12c^3$ hence $\theta\le12c^3=0.8165$, a bound the record's own local maximum at $\sqrt{3/2}=1.2247$ violates. The general cap gives $v_{122}\le12$, hence $m_3\le24c^3$ and $\theta\le18c^3=\sqrt{3/2}$, attained.

**Verdict: REFUTED as stated.** The caps must read $2a_ia_j$ and $2a_i(a_i-1)$ unless the block also declares the decomposable hypothesis, in which case it must say so and forfeit $W_{\mathbb{CP}^2}$.

I note the by-product, because it is the best news in this block: with the corrected caps, the moment relaxation on $W_{\mathbb{CP}^2}$'s spectrum is EXACTLY TIGHT at $\sqrt{3/2}$. The upper bound comes from the two constraints just used and the attainment from $W_{\mathbb{CP}^2}$ itself. At the singleton level set $a_1=1$ the diagonal cap is not an inequality at all but the equality $v_{111}+\tfrac13(v_{112}+v_{113})=0$ forced by hollowness, which is what kills the largest positive coefficient $\sigma_3(111)=8c^3$.

## 7. The signs

At $\mu_1=p>0>\mu_2=-q\ge\mu_3=-r$, so $0<q\le r$, the ten products are

| $S$ | $\sigma_3(S)$ | sign |
|---|---|---|
| $111$ | $p^3$ | $+$ |
| $112$ | $-p^2q$ | $-$ |
| $113$ | $-p^2r$ | $-$ |
| $122$ | $pq^2$ | $+$ |
| $123$ | $pqr$ | $+$ |
| $133$ | $pr^2$ | $+$ |
| $222$ | $-q^3$ | $-$ |
| $223$ | $-q^2r$ | $-$ |
| $233$ | $-qr^2$ | $-$ |
| $333$ | $-r^3$ | $-$ |

Exactly four positive, namely $111,122,123,133$, precisely as the block states, and every one of them contains the index $1$ of the positive eigenvalue. **7a CONFIRMED.**

**7b is a miscount.** The block says "no negative class is free of it except the three all-negative ones". The classes free of index $1$ are the multisets of size three from $\{2,3\}$, and there are $\binom{3+2-1}{3}=4$ of them: $222,223,233,333$. The block's own negative list names all four. It should read four. The structural claim it supports survives unharmed.

## 8. Boundedness without the caps

**The claim is true, and the block understates its own result: the $i=1$ marginal alone suffices, and $m_0$ is redundant.** Every class with $\sigma_3>0$ has $m_1(S)\ge1$, by §7. With $v_S\ge0$ and the $i=1$ marginal $\tfrac13\sum_Sm_1(S)v_S=2(n-2)a_1$,
$$\sum_{S:\,m_1(S)\ge1}v_S\ \le\ \sum_Sm_1(S)v_S\ =\ 6(n-2)a_1,$$
so $m_3\le6(n-2)a_1\max\{p^3,pq^2,pqr,pr^2\}=6(n-2)a_1\max\{p^3,pr^2\}$, and $\theta=\sum_ia_i\mu_i^3+\tfrac12m_3$ is bounded above with no cap used. $m_0$ is not an independent input: it is the sum of the three marginals.

What the caps buy is TIGHTNESS, and on the record's own example the gap is large. For $W_{\mathbb{CP}^2}$'s spectrum, $\max\{p^3,pr^2\}=p^3=8c^3$ and $6(n-2)a_1=12$, so the marginal alone gives only $m_3\le32c^3$, hence $\theta\le22c^3=1.4966$, against the true value $\sqrt{3/2}=1.2247$. The corrected caps close that gap exactly, as §6 records. The caps are therefore not decoration and not merely a boundedness device: they are the constraints that carry the numerical content, which is precisely why getting their constant right matters.

**Verdict: CONFIRMED**, with the correction that the $i=1$ marginal alone does it, and with the warning that in the mirror case of §11 no SINGLE marginal suffices and one needs the marginals at both positive level sets.

## 9. The circularity warning

At the level-set granularity relation (C) reads $\sum_{jk}\mu_j\mu_kt_{ijk}=\sum_{\alpha\in I_i}2\lambda_\alpha(\theta-\lambda_\alpha)=2a_i\mu_i(\theta-\mu_i)$. Weighting by $\mu_i$ and summing,
$$m_3=\sum_i\mu_i\sum_{jk}\mu_j\mu_kt_{ijk}=2\theta\sum_ia_i\mu_i^2-2\sum_ia_i\mu_i^3=2\theta-2\sum_ia_i\mu_i^3$$
at unit norm, which is the objective identity of §1 rearranged. So that combination of (C) carries no information about $v$ that the objective does not already carry, and imposing it while maximising $m_3$ would fix the objective by fiat. **CONFIRMED.**

**The ban is over-broad, however.** (C) is $L$ separate equalities, and only the one combination $\sum_i\mu_i(\cdot)$ is the tautology. The remaining $L-1$ independent components are genuine linear constraints on $v$, at the price that they involve $\theta$, so the correct use is a parametric feasibility problem: fix a trial $\theta$, ask whether the polytope with (C) imposed is nonempty, and bisect. At a critical point that strictly strengthens the bound. I also record the same relation's other role, which is a consistency check rather than a constraint: $\sum_i\mu_i$ against the (B) equalities returns $m_2=-2$, and $\sum_i1$ against them returns $m_1=0$, so both of the pinned lower moments are dependent consequences of the six equalities and not extra information either.

## 10. The two-value consistency check

Two level sets, $\mu_1=\mu>0$ with $a_1=a$ and $\mu_2=\nu<0$ with $a_2=A=N-a$. Trace-freeness gives $a\mu+A\nu=0$, so $\mu:\nu=A:(-a)$, matching given 16's $(N-a):(-a)$, and writing $\mu=As$, $\nu=-as$, unit norm $a\mu^2+A\nu^2=aAN s^2=1$ gives $s=(aAN)^{-1/2}$.

Four classes. Writing the equalities of §5 out, and cancelling $s$ from the (B) rows,
$$3v_{111}+2v_{112}+v_{122}=6(n-2)a,\qquad v_{112}+2v_{122}+3v_{222}=6(n-2)A,$$
$$3Av_{111}+(A-a)v_{112}-av_{122}=-6aA,\qquad Av_{112}+(A-a)v_{122}-3av_{222}=6aA.$$
These four have rank three: $\mu_1\cdot(\text{marginal}_1)+\mu_2\cdot(\text{marginal}_2)=(\mathrm B_1)+(\mathrm B_2)$ identically, in both the coefficients and the constants. That is exactly the block's "the six per-level-set equalities collapse to three", and with four unknowns it leaves the segment the block describes. Solving the first three for $v_{111},v_{112},v_{222}$ in terms of $v_{122}$,
$$v_{112}=\frac{6aA(n-1)}{N}-v_{122},\qquad v_{111}=2(n-2)a-\frac{4aA(n-1)}{N}+\frac{v_{122}}{3},\qquad v_{222}=2(n-2)A-\frac{2aA(n-1)}{N}-\frac{v_{122}}{3}.$$
Substituting into $m_3=\mu^3v_{111}+\mu^2\nu v_{112}+\mu\nu^2v_{122}+\nu^3v_{222}$, the coefficient of $v_{122}$ inside the bracket is $\tfrac13(A^3+a^3)+aA(A+a)=\tfrac N3(A+a)^2=\tfrac{N^3}{3}$ and the constant is $2aAN(a-nA)$, so
$$\theta=aAN(A-a)s^3+aAN(a-nA)s^3+\frac{N^3}{6}s^3v_{122}=s^3\left[\frac{N^3}{6}v_{122}-(n-1)aA^2N\right].$$
$\theta$ is strictly increasing in $v_{122}$, so the optimum is at the largest feasible $v_{122}$.

All three caps are CONSTANT along the segment, which is worth recording as a structural fact of the two-value case: $v_{111}+\tfrac13v_{112}=2(n-2)a-\tfrac{4aA}{n}$, $\tfrac13(v_{112}+v_{122})=\tfrac{2aA(n-1)}{N}$ and $\tfrac13v_{122}+v_{222}=2(n-2)A-\tfrac{4aA}{n}$ all have zero derivative in $v_{122}$. At two values the caps therefore constrain only which $(n,a)$ are admissible, never the objective, and the binding constraint is $v_{112}\ge0$. At $v_{112}=0$, that is $v_{122}=6aA(n-1)/N$,
$$\frac{N^3}{6}v_{122}=\frac{N^3}{6}\cdot\frac{6aA(n-1)}{N}=(n-1)aAN^2,\qquad \theta=s^3(n-1)aAN(N-A)=(n-1)a^2AN\,(aAN)^{-3/2}=(n-1)\sqrt{\frac{a}{N(N-a)}},$$
which is given 16's bound with $s=a$ identified as the multiplicity of the POSITIVE eigenvalue. Both endpoints of given 16's range fall out of nonnegativity at that vertex:
$$v_{111}=a\left(\frac{4a}{n}-2\right)\ge0\iff a\ge\frac n2,\qquad v_{222}=A\left(2(n-2)-\frac{8a}{n}\right)\ge0\iff a\le\frac{n(n-2)}{4}.$$
At the upper endpoint $N-a=n^2/4$ and $(n-1)\sqrt{a/(N(N-a))}=\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$ exactly, as given 16 says.

Two independent confirmations at $n=4$, $a=2$, where the formula gives $3\sqrt{2/24}=\sqrt3/2=\theta_0(4)$. First, the vertex data: $v_{122}=24$ and $v_{111}=v_{112}=v_{222}=0$, with spectrum $\mu=1/\sqrt3$ twice and $\nu=-1/(2\sqrt3)$ four times. Second, the coordinate configuration computed from scratch: for $\lambda_{12}=\lambda_{34}=x$, $\lambda_{13}=\lambda_{24}=y$, $\lambda_{14}=\lambda_{23}=z$ with $x+y+z=0$, Ricci-flatness holds, the four nonzero triples of $T$ all lie in one class, $v=24$, and $\theta=2(x^3+y^3+z^3)+12xyz=18xyz$, maximised at $x=y=-1/\sqrt{12}$, $z=1/\sqrt3$ with value $18/(12\sqrt3)=\sqrt3/2$. The two routes agree in the value, the multiplicities and the class total. **CONFIRMED**, constants included. I screened the general-$n$ algebra symbolically and it returned $v_{122}^\star=6aA(n-1)/N$, $\theta^\star=(n-1)\sqrt a/\sqrt{A(A+a)}$ and the two endpoint conditions above, in agreement with the hand derivation.

This is the strongest single check in the report. Had the objective's $\tfrac12$, the $\tfrac16$ in (B)'s class form, or either $\tfrac13$ been wrong by a factor of two, $\theta^\star$ would not have reproduced an independently established closed form together with both endpoints of its range.

## 11. Dimension count and degeneracies

**11a, the dimension.** The block says "at three values there are ten types and six equalities, so the feasible polytope is four-dimensional before the caps". The ten types are right, and the six equalities are right, but they are NOT independent. The same dependency found at two values in §10 holds at every $L$:
$$\sum_i\mu_i\cdot\left[\tfrac13\sum_Sm_i(S)v_S\right]=\tfrac13\sum_S\sigma_1(S)v_S=\tfrac16\sum_S\big(3\sigma_1(S)-\sigma_1(S)\big)v_S=\sum_i\left[\tfrac16\sum_Sm_i(S)(\sigma_1(S)-\mu_i)v_S\right],$$
using $\sum_im_i(S)\mu_i=\sigma_1(S)$ and $\sum_im_i(S)=3$, and the constants agree too, since $\sum_i\mu_i\cdot2(n-2)a_i=0=\sum_i(-2a_i\mu_i)$. So the $\mu$-weighted sum of the marginals equals the sum of the (B) rows, and the rank is at most five. It is exactly five for pairwise distinct $\mu_i$: testing a general combination $\sum_ic_iM_i+d_1B_1+d_2B_2=0$ on the columns $111,222,333,113,112$ in turn forces $c_3=0$, then $c_1=-d_1\mu_1$ with $d_1(\mu_3-\mu_1)=0$ hence $d_1=c_1=0$, then $d_2(\mu_1-\mu_2)=0$ hence $d_2=c_2=0$. **The affine solution set is five-dimensional, not four**, and the vertex enumeration the block owes is over a five-dimensional polytope. The block's own two-value sentence, which correctly says three rather than four, shows the dependency was noticed there and dropped here.

**Two equal $\mu$'s.** Then there are two level sets, not three. Keeping three labels is harmless for the moments but the parametrisation becomes redundant and the rank drops from five to three, since the rank argument above needs the $\mu_i$ distinct. The framing survives, and the maximum agrees with the two-value answer, but any statement about the polytope's dimension is a genericity statement and should say so.

**A zero eigenvalue.** This is not an edge case to be waved through: it is $W_{\mathbb{CP}^2}$'s own spectrum $(2c,-c,0)$ with $(a_1,a_2,a_3)=(1,2,3)$. The block's sign analysis is stated at $\mu_1=p>0>\mu_2=-q\ge\mu_3=-r$ with $r>0$, which excludes it, and the mirror sentence covers $(+,+,-)$, so the pattern $(+,-,0)$ is covered by neither. It behaves differently: four of the ten classes lose their sign because $\sigma_3(S)=0$ whenever $3\in S$, leaving $111$ and $122$ positive and $112,222$ negative. Trace-freeness with three distinct values and every $a_i>0$ permits exactly the three patterns $(+,-,-)$, $(+,+,-)$ and $(+,0,-)$, so the case analysis is one third incomplete, and the missing third contains the object the programme most wants to certify.

**$a_i=0$.** Here the framing degrades gracefully, which is worth recording as a positive. If a level set is empty then the marginal at that index reads $\tfrac13\sum_Sm_3(S)v_S=0$, and with $v\ge0$ every class containing that index is forced to vanish, so the system reduces to the two-value system of §10 by itself, with no case distinction needed.

**The mirror case.** The block says two positive values against one negative "runs the same way with the roles of the signs exchanged". It does not. At $\mu_1=p\ge\mu_2=q>0>\mu_3=-r$ the products are $p^3,p^2q,pq^2,q^3,pr^2,qr^2$ positive and $-p^2r,-pqr,-q^2r,-r^3$ negative: SIX positive classes, not four. The structural statement that carries the block's argument, "every positive class contains the index of the positive eigenvalue", fails, because $111,112,122,222$ contain no negative index at all. Boundedness survives, since every positive class meets $\{1,2\}$, so the marginals at $i=1$ and $i=2$ together bound the mass, but it needs two marginals rather than one, and the enumeration is a genuinely different polytope rather than a relabelling. **11b PARTIAL.**

## 12. What would break it, and what I did to look

The reduction is a sequence of counting identities plus a relaxation. Here is what I treated as the falsifiers, and what I did about each.

1. **A wrong $\tfrac12$ in the objective**, that is a mismatch between the ordered and the unordered double sum in $W^\#$. Looked for it by deriving $(W^\#)_{kk}$, $(W\#\mathrm{Id})_{kk}$ and $(\mathrm{Id}\#\mathrm{Id})_{kk}$ from the same definition and checking that the same constant produces relation (B)'s $-2$, the marginal's $2(n-2)$ and $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$. Not found.
2. **A miscount in $n_S$ or in the first-slot count $n_Sm_i(S)/3$.** Derived both, then checked every class type by hand unsymmetrised, then screened the whole class system on two independent configurations. Not found.
3. **The undefined $t_{ijk}$.** The block never says what $t_{ijk}$ is. Only the block sum over level sets makes $\sum_{jk}t_{ijk}=2(n-2)a_i$ true; a per-index or averaged reading changes every factor in the system by powers of $a_i$. **This is a real gap and should be closed by one sentence of definition.** A related trap: $T$ is hollow and $t$ is NOT, since $t_{iii}$ counts triples inside one level set. Closed-form witnesses: $t_{333}=12$ for $W_{\mathbb{CP}^2}$, and $t_{111}=12$ on the $n=6$ circulant spectrum of §3.
4. **The caps.** Found, and refuted in closed form by $W_{\mathbb{CP}^2}$, three pairs, factor two each. §6.
5. **The dimension and the class census.** Found, rank five not six. §11a. Ten classes and six equalities are both right.
6. **The sign census.** Checked all ten products by hand. The four positives are right, the "three all-negative" is four, and the mirror case has six positives rather than four.
7. **Reading the relaxation's optimum as the supremum.** The moment programme is a RELAXATION: a vertex of the polytope need not be the $v$ of any Weyl tensor, so its value is an upper bound on $\theta$ and nothing more. The block's phrase "the feasible set is a segment whose endpoints are computable" invites the stronger reading. Two facts bound the risk: at two values the optimum coincides with an independently established bound and is attained by the coordinate configuration, and on $W_{\mathbb{CP}^2}$'s spectrum the corrected programme is exactly tight. Neither is a general guarantee, and the block should state the direction of the inequality once.
8. **Omitted valid constraints** would weaken the bound without invalidating it. The programme as posed uses the marginal, (B) and the pair caps, and leaves given 10's $\Xi\le n^2(n-1)$, the Gram structure of given 11 and any Schur-type positivity of $T$ on the table.

What I did NOT do, on the analysis-only footing: no search, no sweep, no enumeration of the five-dimensional polytope, no falsifier hunt. Every computation reported here is either a hand derivation or a screen of a claim I was about to record, run in exact arithmetic on an object I constructed for the screen, and the two objects used are the record's own coordinate configuration and $W_{\mathbb{CP}^2}$.

## Verdict

**The reduction is CONFIRMED and the combinatorics is sound. The caps are REFUTED as stated and must be doubled. Three further defects are recorded, one substantive and two clerical.**

The reduction of $\theta$ to a third moment under three pinned lower moments is correct, and so is every combinatorial factor in the class-variable system: the $\tfrac12$ in the objective, the $\tfrac13$ for $m_1$ and $m_2$, the $1$ for $m_3$, the $\tfrac13$ in the marginal and the $\tfrac16$ in relation (B). I derived each from the ordered-triple counts before checking anything, and the two-value specialisation then reproduced an independently established closed form together with both endpoints of its range, which no single factor could survive being halved. The block deserves credit for a further point it does not claim: because the marginal and (B) hold off the critical set, the programme bounds $\theta$ over all Ricci-flat unit-norm tensors of a given spectrum, and with the corrected caps it is exactly tight on $W_{\mathbb{CP}^2}$.

Required before this leaves working notes:

1. **Double the caps** to $2a_ia_j$ and $2a_i(a_i-1)$, or declare the decomposable hypothesis and note that $W_{\mathbb{CP}^2}$ then falls outside. As written they yield $\theta\le0.8165$ on a spectrum whose true value is $1.2247$.
2. **Define $t_{ijk}$** as the block sum of $T$ over level sets, and state that $t$ is not hollow.
3. **Five-dimensional**, not four: the six equalities have rank five, the dependency being $\sum_i\mu_i(\text{marginal}_i)=\sum_i(\mathrm B_i)$, and the count needs the $\mu_i$ distinct.
4. **Four all-negative classes**, not three.
5. **Replace "average" by "sum"** in the gloss on relation (B)'s inner factor, or move the $\tfrac12$ back inside.
6. **Add the third sign pattern** $(+,0,-)$, and correct "runs the same way" for the mirror case, which has six positive classes and needs two marginals for boundedness.
7. **State the direction of the inequality**: the programme's optimum bounds $\theta$ from above and is not by itself a value of $\theta$.
