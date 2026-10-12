# REVIEW r877: relation (B) at the padded $W_{\mathbb{CP}^2}$ spectrum, and a closed-form spectrum where the (B)-augmented programme reaches $8/\sqrt6$

*Reviewer r877, 2026-09-12. The brief was **cold**: the only file read was the brief itself, and no findings file, plan, review or attempts notebook was opened. **No numerical work beyond screening was done, and every value in this report is exact**: the derivations below are by hand, and the one machine step is an exact-rational bookkeeping screen of two closed-form points I construct here, reported as a screen and never as evidence for a positive claim. Log: [agent_logs/review-r877-brow.log](../agent_logs/review-r877-brow.log).*

## Claim table

| # | Claim as recorded | Verdict |
|---|---|---|
| C1 | $\theta=6c^3(1+T_{123})$ at the padded $W_{\mathbb{CP}^2}$ spectrum, $n=12$ | **Upheld.** Rederived from given 1, including the factor and the count of six contributing ordered triples. |
| C2 | Hollowness kills $\beta=1$ in (B) at index $1$ | **Upheld.** $T_{11\gamma}=0$, and $\lambda_\beta=0$ for $\beta\ge4$ kills the rest. |
| C3 | (B) at index $1$ reads $\sum_\gamma T_{12\gamma}+\sum_\gamma T_{13\gamma}=4$ | **Upheld**, over ordered pairs, with the marginal's own $T_{123}\le10$ confirming the ordered reading. |
| C4 | $T_{123}\le2$, hence $\theta\le18c^3=\sqrt{3/2}=1.224745$ | **Upheld.** |
| C5 | The bound is **tight**, the object attaining it | **Upheld, and verified independently of given 5.** Direct commutator computation in $\Lambda^+\mathbb R^4$ gives $[\omega_1,\omega_2]=\sqrt2\,\omega_3$, so $c_{123}=\sqrt2$ and $T_{123}=2$ exactly. |
| C6 | $\sqrt{3/2}<\theta_0(12)=1.236033$ | **Upheld.** $\theta_0(12)=\sqrt{55}/6$ and $\sqrt{3/2}=\sqrt6/2$. |
| C7 | "No further constraint can improve this spectrum" | **Upheld**, and it is the correct reading of tightness: it is a statement about that spectrum alone. |
| C8 | Contracting (B) gives $\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta T_{\alpha\beta\gamma}=-2$ | **Upheld.** |
| C9 | The two-parameter dual displayed is valid | **Upheld**, and identified: it is the **uniform-$y$ sub-family** of the dual to [aggregate marginal + contracted (B)]. |
| C10 | Its optimum at that spectrum is $23.48$ | **Corrected.** The exact optimum is $\frac{115\sqrt6}{12}=\frac{115}{2\sqrt6}=23.474277$, attained at $y=\frac{1}{12\sqrt6}$, $z=-\frac{1}{2\sqrt6}$. It rounds to $23.47$. |
| C11 | "The contracted form of (B) is worse than useless", "five times worse than using the marginals alone" | **Refuted as stated.** The comparison silently also drops the $N$ per-index marginal multipliers down to one uniform multiplier. With the per-index marginals **retained**, contracted (B) gives exactly $5/\sqrt6=2.041241$ at that spectrum, a **strict improvement** on the marginals-only $11/\sqrt6=4.490731$. The loss of a factor of five is caused by uniformising the marginals, not by contracting (B). |
| C12 | "A successor puts one multiplier per index, not one per relation" | **Upheld in substance**, and by a wider margin than the record's arithmetic shows: per-index (B) gives $\sqrt{3/2}$ where contracted (B) with per-index marginals gives $5/\sqrt6$. |
| C13 | Balanced product: the augmented programme returns exactly $\theta_0(n)$ there | **Upheld**, conditional on given 3 applying to the balanced product. The floor half needs the balanced product's own $T$ to satisfy (B), which given 3 supplies for every $W\in\mathcal W_n$. I verified the mechanism concretely for the padded $W_{\mathbb{CP}^2}$. |
| C14 | The implied reach of the headline: that the augmented programme now controls the spectrum that was defeating the record | **Refuted, with an exact counterexample.** At $n=12$ and $\lambda=\tfrac{1}{\sqrt6}(1,1,1,-1,-1,-1,0^{60})$ the (B)-augmented per-index programme admits an explicit feasible $T$ with $\theta=48a^3=8/\sqrt6=3.265986>\theta_0(12)=1.236033$. A simpler point at $\lambda=\tfrac12(1,1,-1,-1,0^{62})$ gives $\theta=2$. The family's value is $(n-4)/\sqrt{2p}$, unbounded in $n$. |
| C15 | Vacuity (item 9) | **Not vacuous where it is used, but feasibility is conditional.** Summing the (B) rows against the marginal forces $\sum_k\lambda_k=0$, so the augmented programme is infeasible at every spectrum off the trace-free hyperplane. That is correct content, not a defect, and it means any sweep must be read as restricted to $\{\sum\lambda=0\}$. |

## One-line summary

The three-line argument at the padded $W_{\mathbb{CP}^2}$ spectrum is correct, exact and tight, and I confirmed its tightness independently by computing $T_{123}=2$ from the commutators, but the programme it belongs to does not reach the target: at $\lambda=\tfrac{1}{\sqrt6}(1,1,1,-1,-1,-1,0^{60})$ the same augmented programme admits an exact feasible $T$ with $\theta=8/\sqrt6=3.265986$, two and a half times $\theta_0(12)$, and the recorded verdict on contracted (B) confounds contraction with uniformisation of the marginal multipliers.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector, the inner product being $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- The norm on a four-index tensor is the record's: $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$.
- $(\omega\wedge\omega)_{ijkl}=2(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$, the record's wedge being twice the Pfaffian.
- $\mathcal W_n$ is the space of algebraic Weyl tensors, $\lVert W\rVert^2=\operatorname{tr}(W^2)$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.

## Hypothesis inventory

What the audited chain uses, and where each piece comes from.

| Ingredient | Source | Used where |
|---|---|---|
| $\theta=\sum_\alpha\lambda_\alpha^3+\tfrac12 m_3$, $m_3=\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}$ over ordered triples | Given 1 | §1 objective, §5, §8 |
| $T=c^2$ totally symmetric and hollow, $T\ge0$ | Given 1 | §1, §2, §8 |
| Marginal $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$, ordered pairs | Given 2, Lemma L153 | §1, §7, §8 |
| Relation (B) $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$, no criticality hypothesis, linear in $T$ | Given 3 | §1, §2, §6, §8, §9 |
| Marginals-only optimum $11/\sqrt6$ at $n=12$ with $T_{123}=10$ | Given 4 | §5 comparison |
| The padded spectrum, its unit norm, its true $\theta=\sqrt{3/2}$, criticality and local maximality | Given 5 | §3, §4 |
| Marginals-only returns $\theta_0(n)$ at the balanced product, complementary slackness exact | Given 6 | §6 |
| $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ | Given 7 | §4, §8 |
| $\mathcal W_n$ membership of the balanced product | Implicit in given 6 | §6, and flagged there |

Nothing in §1 to §4 or §8 uses criticality, local maximality or the geometric realisability of a spectrum. §8 in particular uses only the marginal, (B), total symmetry, hollowness and nonnegativity, which given 4 and the brief state to be the programme's entire input about $T$.

## 1. The three-line derivation, rederived

**The objective.** The spectrum is $\lambda_1=2c$, $\lambda_2=\lambda_3=-c$, $\lambda_\alpha=0$ for $4\le\alpha\le66$, and unit norm gives $4c^2+c^2+c^2=6c^2=1$, so $c=1/\sqrt6$. Then $\sum_\alpha\lambda_\alpha^3=8c^3-c^3-c^3=6c^3$.

In $m_3$ a term survives only when all three of $\lambda_\alpha,\lambda_\beta,\lambda_\gamma$ are nonzero, so all three indices lie in $\{1,2,3\}$, and hollowness then forces them to be a permutation of $(1,2,3)$. There are **six** such ordered triples, each carrying $T_{123}$ by total symmetry and each carrying the same product $\lambda_1\lambda_2\lambda_3=2c\cdot(-c)\cdot(-c)=2c^3$. Hence $m_3=12c^3T_{123}$ and

$$\theta=6c^3+\tfrac12\cdot12c^3T_{123}=6c^3(1+T_{123}).$$

The count of six and the factor $\tfrac12$ cancel into the clean $6c^3$, which is why the formula looks as though the factor had been dropped. It has not. **C1 upheld.**

**Hollowness.** $T$ vanishes whenever two indices coincide, because $c_{\alpha\beta\gamma}=\langle[\omega_\alpha,\omega_\beta],\omega_\gamma\rangle$ is totally antisymmetric and $T=c^2$. So in $\sum_{\beta\gamma}\lambda_\beta T_{1\beta\gamma}$ the terms with $\beta=1$ and with $\gamma=1$ are zero. **C2 upheld.**

**The row.** What remains has $\beta\in\{2,\dots,66\}$, and $\lambda_\beta\ne0$ needs $\beta\in\{2,3\}$:

$$-c\sum_\gamma T_{12\gamma}-c\sum_\gamma T_{13\gamma}=-2\lambda_1=-4c\quad\Longrightarrow\quad S_{12}+S_{13}=4,\qquad S_{ab}:=\sum_\gamma T_{ab\gamma}.$$

This is the ordered-pair reading of (B). The reading is pinned independently by the record's own marginals-only number: $2T_{123}\le\sum_{\beta\gamma}T_{1\beta\gamma}=2(n-2)=20$ gives $T_{123}\le10$, which is exactly the $T_{123}=10$ of given 4. **C3 upheld.**

**The bound.** $S_{12}\ge T_{123}$ and $S_{13}\ge T_{132}=T_{123}$, so $2T_{123}\le4$ and $T_{123}\le2$, whence

$$\theta\le6c^3\cdot3=18c^3=\frac{18}{6\sqrt6}=\frac{3}{\sqrt6}=\frac{\sqrt6}{2}=\sqrt{3/2}=1.224745.$$

**C4 upheld.** Against the marginals-only $6c^3(1+10)=66c^3=11/\sqrt6=4.490731$, the single row of (B) cuts the bound by a factor of $11/3$.

## 2. The nonnegativity step, and whether indices 2 and 3 give more

The step is sound: $S_{12}=\sum_\gamma T_{12\gamma}$ is a sum of nonnegative terms one of which is the $\gamma=3$ term $T_{123}$, and $S_{13}\ge T_{132}=T_{123}$ by total symmetry. No other term of either sum is needed, and none is discarded with a sign error.

**Using all three rows pins more than the record claims, but does not improve the bound.** Write the three rows out. At index $2$, hollowness leaves $\beta\in\{1,3\}$ and

$$2c\,S_{12}-c\,S_{23}=-2\lambda_2=2c\quad\Longrightarrow\quad 2S_{12}-S_{23}=2,$$

and at index $3$ symmetrically $2S_{13}-S_{23}=2$. With $S_{12}+S_{13}=4$ from index $1$, the three equations have the unique solution

$$S_{12}=S_{13}=S_{23}=2.$$

So (B) does not merely bound the three pair-sums, it **determines** all three exactly. The binding inequality on the objective is still $T_{123}\le S_{12}=2$, so the bound $\theta\le\sqrt{3/2}$ is unchanged. What the extra rows buy is rigidity: at the optimum $T_{12\gamma}=T_{13\gamma}=T_{23\gamma}=0$ for every $\gamma\ge4$, so the $2$ units of each pair-sum are entirely inside $\{1,2,3\}$. That rigidity is worth recording, because it is what makes §7's feasibility check nontrivial.

## 3. Tightness, verified without given 5

The record asserts tightness by appeal to the object's true $\theta$. I verified it from the commutators instead, so the claim does not rest on given 5.

From $\varphi_{ab}=E_{ba}-E_{ab}$ and $E_{ij}E_{kl}=\delta_{jk}E_{il}$,

$$[\varphi_{ab},\varphi_{cd}]=\delta_{ad}\varphi_{cb}-\delta_{ac}\varphi_{db}-\delta_{bd}\varphi_{ca}+\delta_{bc}\varphi_{da}.$$

Take the self-dual triple in $\Lambda^2\mathbb R^4$, each unit in the brief's inner product:

$$\omega_1=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34}),\qquad \omega_2=\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24}),\qquad \omega_3=\tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23}).$$

The four brackets are $[\varphi_{12},\varphi_{13}]=\varphi_{23}$, $[\varphi_{12},\varphi_{24}]=-\varphi_{14}$, $[\varphi_{34},\varphi_{13}]=\varphi_{14}$ and $[\varphi_{34},\varphi_{24}]=-\varphi_{23}$, so

$$[\omega_1,\omega_2]=\tfrac12\big(\varphi_{23}+\varphi_{14}+\varphi_{14}+\varphi_{23}\big)=\varphi_{14}+\varphi_{23}=\sqrt2\,\omega_3,$$

giving $c_{123}=\sqrt2$ and $T_{123}=c_{123}^2=2$ exactly. Padding to $n=12$ changes nothing, because $[\omega_1,\omega_2]$ lies in $\mathfrak{so}(4)$ and is orthogonal to every basis bivector involving $e_5,\dots,e_{12}$.

Three independent checks fall out of the same computation.

- **The bound is attained**, so $\theta=6c^3(1+2)=18c^3=\sqrt{3/2}$, which is the true value given 5 records. **C5 upheld.**
- **Lemma L153 is confirmed at $n=4$.** The marginal at index $1$ is $\sum_{\beta\gamma}T_{1\beta\gamma}=T_{123}+T_{132}=4=2(n-2)$, with no contribution from $\Lambda^-$ because $[\Lambda^+,\Lambda^-]=0$. The ordered-pair reading of given 2 is therefore right.
- **Relation (B) is confirmed on this object.** $S_{12}=S_{13}=S_{23}=2$, matching §2's forced values exactly, and index $1$ reads $S_{12}+S_{13}=4$. This is an instance-level check of given 3's "no criticality hypothesis" wording that I could make from the brief alone.

The record's "no further constraint can improve this spectrum" is then correct and correctly scoped: it is a statement about this spectrum, and §8 shows it must not be read as a statement about the programme.

## 4. The comparison against $\theta_0(12)$

$\theta_0(12)=\sqrt{2\cdot11\cdot10}/12=\sqrt{220}/12=\sqrt{55}/6=1.236033$ and $\sqrt{3/2}=1.224745$, so $\sqrt{3/2}<\theta_0(12)$ with a margin of $0.011288$. **C6 upheld.**

What it means, stated precisely. At this one spectrum the augmented programme delivers a certificate that no $W\in\mathcal W_{12}$ with this spectrum has $\theta$ above $\theta_0(12)$, and the certificate is exact rather than slack, the object sitting $0.011288$ below the target. It is a spectrum-wise certificate and nothing more. The conjecture needs the same at **every** trace-free unit spectrum, which is the burden §8 discharges negatively.

## 5. Contracted (B): correct contraction, valid dual, wrong headline

**The contraction is right.** Multiply (B) at index $k$ by $\lambda_k$ and sum: $\sum_k\lambda_k\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\sum_k\lambda_k^2=-2$ at unit norm, and the left side is $\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta T_{\alpha\beta\gamma}$ after relabelling. **C8 upheld.**

**The dual is valid, and it is a dual to a weaker primal than the record's wording suggests.** Pass to unordered triples with $t_\Delta=T_{abc}$ for $\Delta=\{a,b,c\}$, and write $\pi_\Delta=\lambda_a\lambda_b\lambda_c$, $p_\Delta=\lambda_a\lambda_b+\lambda_b\lambda_c+\lambda_c\lambda_a$. Then $m_3=6\sum_\Delta\pi_\Delta t_\Delta$, so the objective is $\sum\lambda^3+3\sum_\Delta\pi_\Delta t_\Delta$, the marginal is $\sum_{\Delta\ni k}t_\Delta=n-2$, and the contraction is $2\sum_\Delta p_\Delta t_\Delta=-2$, that is $\sum_\Delta p_\Delta t_\Delta=-1$. The LP dual with one multiplier $y_k$ per marginal and $\zeta$ on the scalar is

$$\min\ (n-2)\sum_k y_k-\zeta\quad\text{s.t.}\quad y_a+y_b+y_c+\zeta p_\Delta\ge3\pi_\Delta\ \ \forall\Delta.$$

Setting all $y_k=y$ and $z=\zeta/3$ reproduces the recorded pair exactly: $\pi_\Delta\le y+z\,p_\Delta$ and $\theta\le\sum\lambda^3+(n-2)Ny-3z$. **C9 upheld**, and the identification settles the brief's question about direction: **the two families are not nested.** The recorded family restricts $N$ free marginal multipliers to a single uniform one, so its primal is [aggregate marginal + contracted (B)], which is a *relaxation* of [per-index marginals], not a tightening. A weaker primal has a larger optimum. No duality paradox survives.

**The recorded number is slightly wrong.** At the padded spectrum, $p_{123}=-2c^2+c^2-2c^2=-3c^2=-\tfrac12$, $p_{\{1,2,\gamma\}}=p_{\{1,3,\gamma\}}=-2c^2=-\tfrac13$, $p_{\{2,3,\gamma\}}=c^2=\tfrac16$ and $p_\Delta=0$ for any triple with at most one index in $\{1,2,3\}$. Only $\Delta=\{1,2,3\}$ has $\pi_\Delta\ne0$, with $\pi_{123}=2c^3$. Solving the two-variable dual: for $z>0$ the binding row is $\{1,2,3\}$ and the objective increases in $z$, so take $z=-w$ with $w>0$, where $y\ge\max\big(w/6,\ \tfrac1{3\sqrt6}-\tfrac w2,\ 0\big)$ and the objective is $660y+3w$. The two active rows cross at $w=\tfrac1{2\sqrt6}$, $y=\tfrac1{12\sqrt6}$, and either branch pushes to that point, giving

$$\theta\le\frac1{\sqrt6}+\frac{113}{2\sqrt6}=\frac{115}{2\sqrt6}=\frac{115\sqrt6}{12}=23.474277.$$

The primal confirms it: with only $\sum_\Delta t_\Delta=N(n-2)/3=220$ and $\sum p_\Delta t_\Delta=-1$, putting no mass on $\{1,2,\gamma\}$ or $\{1,3,\gamma\}$ and mass $C$ on $\{2,3,\gamma\}$ gives $t_{123}=2+\tfrac13C$ with $t_{123}+C\le220$, hence $t_{123}\le56.5$ and $\theta\le6c^3\cdot57.5=\tfrac{115\sqrt6}{12}$. **The record's $23.48$ should be $23.47$. C10 corrected.**

**The headline is refuted.** Keep the per-index marginals and add contracted (B). At the padded spectrum, with $A$, $B$, $C$ the masses on $\{1,2,\gamma\}$, $\{1,3,\gamma\}$, $\{2,3,\gamma\}$ for $\gamma\ge4$ and $u=t_{123}$:

$$-\tfrac12u-\tfrac13(A+B)+\tfrac16C=-1,\qquad u+A+C+D_2=10\ \ (D_2\ge0),$$

so $u=2-\tfrac23(A+B)+\tfrac13C$ and $C\le10-u-A$ combine to $\tfrac43u\le\tfrac{16}3-A-\tfrac23B$, giving $u\le4$ with equality at $A=B=0$, $C=6$. Hence

$$\theta\le6c^3\cdot5=30c^3=\frac{5}{\sqrt6}=2.041241<\frac{11}{\sqrt6}=4.490731.$$

The point $u=4$, $C=6$ is feasible: index $1$ takes its remaining $6$ units on triples $\{1,\beta,\gamma\}$ with $\beta,\gamma\ge4$, indices $2$ and $3$ are exactly filled, and the $63$ zero indices absorb the rest uniformly. Note also that the marginals-only optimum $t_{123}=10$ of given 4 **violates** the contraction, giving $\sum p_\Delta t_\Delta=-5$ rather than $-1$, which is why the contraction has bite.

So contracted (B) is not worse than useless. It improves the marginals-only bound by a factor of $11/5$ at the very spectrum the record uses to dismiss it. What the record measured is the cost of *uniformising the marginal multipliers*, a loss of a factor of $\tfrac{115}{2\sqrt6}\big/\tfrac{11}{\sqrt6}=\tfrac{115}{22}=5.227$, attributed to contraction. **C11 refuted as stated.** The conclusion drawn from it survives on better evidence: per-index (B) gives $\sqrt{3/2}=1.224745$ against contracted (B)'s $5/\sqrt6=2.041241$ with per-index marginals throughout, a clean factor of $\tfrac{5}{\sqrt6}\big/\tfrac{\sqrt6}{2}=\tfrac53$ in favour of one multiplier per index. **C12 upheld in substance, on a corrected comparison.**

## 6. The balanced product

The argument has two halves and both are valid, one of them conditionally.

- **Ceiling.** The augmented feasible set is a subset of the marginals-only feasible set, because (B) is added as an equality and nothing is removed. A maximum over a subset cannot exceed the maximum over the set, so the augmented optimum is at most $\theta_0(n)$ by given 6.
- **Floor.** The balanced product's own $T$ must be feasible for the augmented programme and must attain $\theta_0(n)$. Attainment is given 6, which records the marginals-only optimum as reached *at the balanced product's triangle counts* with complementary slackness exact. Feasibility needs the balanced product's $T$ to satisfy (B).

**It does, given 3.** Given 3 states that (B) is the diagonal of the operator identity $W\#I=-W$ and holds with no criticality hypothesis, so it holds for every $W\in\mathcal W_n$ and in particular for the balanced product, whose membership in $\mathcal W_n$ is implicit in given 6 treating it as an object with a true $\theta$. Together the two halves give equality, and the record's one-line justification is sound. **C13 upheld.**

Two residuals I could not close from a cold brief, both recorded rather than resolved.

- I did not verify the balanced product's $T$ against (B) by direct computation, because that needs the record. I did verify the analogous statement for the padded $W_{\mathbb{CP}^2}$ in §3, where the object's $S_{12}=S_{13}=S_{23}=2$ satisfy every (B) row exactly. If given 3 carried a hidden genericity or simple-spectrum hypothesis that the balanced product fails, the floor half would degrade from equality to "at most", and the balanced-product claim alone would be the casualty. The ceiling half is unaffected.
- (B) refers to $T$ in an orthonormal eigenframe, which is not unique when eigenvalues repeat. This is harmless: (B) is the diagonal of an operator identity, so it holds in every orthonormal eigenframe, and the balanced product's degeneracies cost nothing.

## 7. The kernel

**Nothing in the derivation breaks at $\lambda=0$.** The argument of §1 divides by $c$ once, and $c=1/\sqrt6\ne0$. The zero eigenvalues enter only by killing terms of a sum, which is the direction that is always safe. There is no division by $\lambda_\beta$, no ratio, and no step that needs a $\lambda$ to be invertible.

**The rows at zero indices are constraints, not vacancies.** At $k\ge4$, (B) reads $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=0$, which after hollowness is $2c\,S_{k1}-c\,S_{k2}-c\,S_{k3}=0$, that is $2S_{k1}=S_{k2}+S_{k3}$. Sixty-three real linear conditions, one per kernel index. They are worth noticing because they are the rows that do the damage in §8.

**The marginal remains satisfiable once (B) binds, and the whole system is feasible at the tight point.** Take $t_{123}=2$, which by §2 forces $t_{\{1,2,\gamma\}}=t_{\{1,3,\gamma\}}=t_{\{2,3,\gamma\}}=0$ for all $\gamma\ge4$. Each of indices $1,2,3$ then needs its remaining $8$ units on triples with exactly one special index, so put mass $8$ at each of $1,2,3$ spread uniformly over $\{i,\beta,\gamma\}$ with $\beta,\gamma\ge4$. By that symmetry $S_{k1}=S_{k2}=S_{k3}$ at every $k\ge4$, so $2S_{k1}=S_{k2}+S_{k3}$ holds, and the kernel marginals are topped up to $10$ by triples inside $\{4,\dots,66\}$, which carry $\lambda=0$ on all three indices and disturb nothing. The augmented programme is therefore feasible at this spectrum and attains $\sqrt{3/2}$. **Not vacuous here.**

## 8. What a counterexample looks like, and one exhibited in closed form

This is the item the brief marks as decisive, and the answer is that a counterexample exists, is exact, and is not a boundary artefact.

### 8.1 The reformulation that makes the search possible

For a triple $\Delta=\{k,b,c\}$ the ordered pairs available to (B) at $k$ are $(b,c)$ and $(c,b)$, contributing $\lambda_b+\lambda_c=\sigma_\Delta-\lambda_k$ with $\sigma_\Delta:=\lambda_a+\lambda_b+\lambda_c$. So (B) at $k$ is $\sum_{\Delta\ni k}(\sigma_\Delta-\lambda_k)t_\Delta=-2\lambda_k$, and substituting the marginal $\sum_{\Delta\ni k}t_\Delta=n-2$ turns the whole augmented programme into

$$\max\ \sum_\alpha\lambda_\alpha^3+3\sum_\Delta\pi_\Delta t_\Delta\quad\text{s.t.}\quad t\ge0,\qquad \sum_{\Delta\ni k}t_\Delta=n-2,\qquad \boxed{\sum_{\Delta\ni k}\sigma_\Delta t_\Delta=(n-4)\lambda_k}\ \ \forall k.$$

The boxed row is (B) in its useful form: **a first-moment condition on the triple-sum $\sigma$**. The reformulation reproduces the record's own number, which is how I checked it. At the padded spectrum, index $1$ gives $c(A_{12}+A_{13})+2cE=16c$ against the marginal $u+A_{12}+A_{13}+E=10$, so $E=u+6$ and $A_{12}+A_{13}=4-2u\ge0$, hence $u=T_{123}\le2$. Same bound, same slack structure.

### 8.2 Where the weakness is

The objective sees only triples with three nonzero eigenvalues. The (B) rows see every triple, including those touching the kernel, where $\pi_\Delta=0$ and the constraint can be discharged for free. So the search is for a spectrum whose $\sigma$-budget $(n-4)\lambda_k$ can be paid on **objective-blind** triples, leaving the objective-carrying triples nearly unconstrained. The padded $W_{\mathbb{CP}^2}$ spectrum resists this because its own $\{1,2,3\}$ has $\sigma_{123}=0$, so the budget must be paid on triples that also consume marginal, which is exactly the $E=u+6$ coupling that produces $u\le2$. A spectrum whose objective-carrying triples have **positive** $\sigma$ pays its budget out of the objective itself, and the coupling reverses sign.

### 8.3 The counterexample

Take $n=12$, $N=66$, and

$$\lambda=\tfrac1{\sqrt6}\,(\underbrace{1,1,1}_{P},\underbrace{-1,-1,-1}_{M},\underbrace{0,\dots,0}_{60\ \text{kernel}}),\qquad a:=\tfrac1{\sqrt6}.$$

Unit norm: $6a^2=1$. Trace-free: $\sum\lambda_k=0$, so §9's necessary condition is met. $\sum_\alpha\lambda_\alpha^3=3a^3-3a^3=0$. The four triple types with nonzero $\pi$ are $(+,+,+)$ and $(+,-,-)$ at $\pi=+a^3$, and $(+,+,-)$ and $(-,-,-)$ at $\pi=-a^3$, with $\sigma$ equal to $3a$, $-a$, $a$ and $-3a$ respectively.

The feasible point, exact and explicit:

| triples | count | mass each | total | $\sigma/a$ | $\pi/a^3$ |
|---|---|---|---|---|---|
| $\{1,2,3\}$ | $1$ | $4$ | $4$ | $3$ | $+1$ |
| $\{i,j,k\}$, $i\in P$, $\{j,k\}\subset M$ | $9$ | $4/3$ | $12$ | $-1$ | $+1$ |
| $\{i,j,k\}$, $i\in P$, $j\in M$, $k$ kernel | $540$ | $1/90$ | $6$ | $0$ | $0$ |
| $\{k,l,m\}$ all kernel | $\binom{60}{3}$ | $\tfrac{99}{10}\big/\binom{59}{2}$ | $198$ | $0$ | $0$ |
| everything else, $(+,+,-)$ and $(-,-,-)$ included | rest | $0$ | $0$ | any | any |

All entries are nonnegative, the tensor is symmetric and hollow by construction, and the total mass is $4+12+6+198=220=N(n-2)/3$, as the marginals require.

**Marginal, at each of the three classes of index.**

- $i\in P$: $4+3\cdot\tfrac43+180\cdot\tfrac1{90}=4+4+2=10$.
- $j\in M$: $6\cdot\tfrac43+180\cdot\tfrac1{90}=8+2=10$.
- $k$ kernel: $9\cdot\tfrac1{90}+\binom{59}{2}\cdot\tfrac{99/10}{\binom{59}{2}}=\tfrac1{10}+\tfrac{99}{10}=10$.

**Relation (B), at each of the three classes, target $(n-4)\lambda_k=8\lambda_k$.**

- $i\in P$: $3a\cdot4+(-a)\cdot4+0\cdot2=12a-4a=8a=8\lambda_i$.
- $j\in M$: $(-a)\cdot8+0\cdot2=-8a=8\lambda_j$.
- $k$ kernel: every triple through $k$ that carries mass has $\sigma=0$, so the row is $0=8\cdot0$.

**The objective.**

$$\theta=0+3\big(a^3\cdot4+a^3\cdot12\big)=48a^3=\frac{48}{6\sqrt6}=\frac{8}{\sqrt6}=\frac{4\sqrt6}{3}=3.265986.$$

$$\boxed{\ \theta_{\text{augmented}}\big(\lambda\big)\ \ge\ \frac{8}{\sqrt6}=3.265986\ \gg\ \theta_0(12)=\frac{\sqrt{55}}6=1.236033\ }$$

The programme exceeds its target by a factor of $2.642318$ at this spectrum. **C14 refuted.**

### 8.4 A second, simpler point, and the family

The four-index spectrum $\lambda=\tfrac12(1,1,-1,-1,0^{62})$ at $n=12$ has no $(+,+,+)$ triple and still breaks the target. Put $t_{\{1,3,4\}}=t_{\{2,3,4\}}=\tfrac83$, mass $\tfrac{16}3$ on $\{1,2,\gamma\}$ with $\gamma$ in the kernel, mass $1$ on each of the four families $\{i,j,\gamma\}$ with $i\in\{1,2\}$, $j\in\{3,4\}$, mass $\tfrac83$ on each of the two families $\{j,\beta,\gamma\}$ with $j\in\{3,4\}$ and $\beta,\gamma$ in the kernel, and fill the kernel marginals to $10$ with kernel-only triples. Every marginal is $10$ and every (B) row holds, and with $a=\tfrac12$ the only triples carrying $\pi\ne0$ are $\{1,3,4\}$ and $\{2,3,4\}$ at $\pi=a^3$, so $\theta=3a^3\big(\tfrac83+\tfrac83\big)=16a^3=2$. The kernel rows close by the exact cancellation $2a\cdot\tfrac{16}3-a\cdot2\cdot\big(\tfrac83+\tfrac83\big)=0$, weighting each triple by how many kernel indices it carries, between the $(+,+,0)$ mass at $\sigma=2a$ and the two $(-,0,0)$ families at $\sigma=-a$. That cancellation is what makes this family work.

Solving the reduced LP in closed form for the general two-block spectrum with $p$ entries at $+a$, $p$ at $-a$, $a=1/\sqrt{2p}$, and enough kernel indices, the optimal per-index masses are $x=y=\tfrac{n-4}2$ on $(+,+,+)$ and $(+,-,-)$ and $r=2$ on $(+,-,0)$, with $w=v=0$, giving

$$\theta=2a^3p(n-4)=\frac{n-4}{\sqrt{2p}}\qquad(p\ge3),\qquad\text{and}\qquad\theta=\frac{n-4}{4}\qquad(p=2).$$

So the failure is monotone in $n$ while $\theta_0(n)\to\sqrt2$, and $p=3$ is the worst member. At $n=20$ the $p=3$ point gives $16/\sqrt6=6.532$ against $\theta_0(20)=\sqrt{684}/20=1.307726$. **This is not a boundary artefact and cannot be repaired by enlarging $n$.**

### 8.5 What this does and does not refute

- It **does** refute the augmented programme as a route to Conjecture A. The programme's logic is that every trace-free unit spectrum's LP value is at most $\theta_0(n)$. One spectrum with LP value $8/\sqrt6$ ends that.
- It **does not** refute Conjecture A, and it does not claim that any $W\in\mathcal W_{12}$ has this spectrum. Realisability is not tested here and is very likely to fail. That is precisely the point: the relaxation has no mechanism to exclude an unrealisable spectrum, so a successor must add either a realisability condition on the spectrum or a further condition on $T$ (the off-diagonal part of $W\#I=-W$, a Jacobi-type identity on $c$, or a Gram or rank condition), and the per-index rows of (B) alone are not it.
- It **does not** touch §1 to §4. Those remain exact, tight and correct, and the augmented bound at the padded $W_{\mathbb{CP}^2}$ spectrum stands at $\sqrt{3/2}$.
- It **bounds what (B) bought globally.** The marginals-only worst case is $11/\sqrt6=4.490731$ by given 4, and the augmented worst case is at least $8/\sqrt6=3.265986$, so per-index (B) improves the global bound by at most a factor of $11/8=1.375$. The factor of $11/3$ visible at the padded spectrum is local to that spectrum.

### 8.6 What I did to look for it

By hand, and in this order. First I recast the programme into the boxed $\sigma$-form of §8.1 and checked the recast against the record's own $T_{123}\le2$ and $T_{123}\le10$. Then I read off the structural weakness of §8.2, namely that the $\sigma$-budget is payable on objective-blind triples. Then I solved the reduced LP in closed form for three candidate families: the three-index family $(2,-1,-1)$ (which is the audited spectrum and resists, by $\sigma_{123}=0$), the four-index family $(1,1,-1,-1)$, and the two-block family with $p$ plus and $p$ minus entries. Each reduction is a handful of aggregated variables, solved by elimination as shown. Finally I wrote out the two winners as fully explicit tensors and verified every marginal and every (B) row at all $66$ indices by hand, as tabulated in §8.3.

**Screen.** Because §8.3 and §8.4 are pure bookkeeping over $45\,760$ triples, I guarded them with an exact-rational check over the explicit tensors, in Python [fractions.Fraction](https://docs.python.org/3/library/fractions.html#fractions.Fraction) with no floating point anywhere, reported here as a screen and not as evidence: both points return marginal exactly $10$ at all $66$ indices, (B) row exactly $8\lambda_k$ at all $66$ indices, total mass exactly $220$, and $\theta/a^3$ exactly $48$ and $16$. The evidence for the claim is the hand derivation above, which the screen agrees with in every digit.

## 9. Vacuity, and a structural fact about the augmented programme

**The augmented programme is infeasible at every spectrum with nonzero trace.** Sum the (B) rows over $k$. By total symmetry of $T$,

$$\sum_k\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=\sum_\beta\lambda_\beta\sum_{\alpha\gamma}T_{\beta\alpha\gamma}=2(n-2)\sum_\beta\lambda_\beta,$$

while the right sides sum to $-2\sum_k\lambda_k$. Hence $2(n-1)\sum_k\lambda_k=0$, so $\sum_k\lambda_k=0$ is **forced** by the marginal and (B) together.

This is correct content rather than a defect: $\mathcal W_n$ is trace-free, so nothing admissible is excluded, and the forcing is a small independent confirmation that (B) is the diagonal of $W\#I=-W$. The consequence for how the programme may be used is real, though. Off the hyperplane $\{\sum\lambda=0\}$ the programme is infeasible and its LP value is $-\infty$, which proves everything and means nothing. **Any bound stated "at every spectrum" must read "at every trace-free unit spectrum"**, and any sweep that reports an unboundedly good value at some spectrum has probably found an infeasible one rather than a strong certificate.

On the hyperplane the programme is feasible at every spectrum I examined, and §7 and §8.3 exhibit explicit feasible points at two of them. So the line is not vacuous where it is used, and the audited claim at the padded spectrum is a genuine certificate. **C15 recorded.**

## 10. What would make this round wrong

Four readings the whole report rests on, and what pins each.

- **The marginal is over ordered pairs.** If given 2's $2(n-2)$ were over unordered pairs, every mass in §8 doubles and the bounds move. Pinned twice: the record's own marginals-only optimum needs $2T_{123}\le20$ to give $T_{123}=10$, and my §3 computation of the true object at $n=4$ returns $T_{123}+T_{132}=4=2(n-2)$ exactly.
- **Relation (B) is over ordered pairs.** Pinned by the record's own three-line derivation, whose $\sum_\gamma T_{12\gamma}+\sum_\gamma T_{13\gamma}=4$ is the ordered reading, and by my §8.1 recast reproducing $T_{123}\le2$ from it.
- **The factor $\tfrac12$ on $m_3$, and the count of six ordered triples.** Pinned three ways that agree: given 1 states the factor and calls it unadjustable, my independent $T_{123}=2$ from the commutators feeds $6c^3(1+2)=\sqrt{3/2}$, and given 5 records $\sqrt{3/2}$ as the object's true $\theta$. A wrong factor or count would break that triangle.
- **The programme's input about $T$ is the marginal, (B), total symmetry, hollowness and nonnegativity, and nothing else.** This is what §8 exploits, and it is what given 4 and the brief state. If the record's augmented programme silently carries a further constraint that the brief omits, my counterexample would have to be tested against it and might fail. I flag this as the one place where a cold brief is a real limitation, and I note that the natural extra constraints (the off-diagonal part of $W\#I=-W$, a Jacobi identity on $c$, a Gram condition) are precisely what §8.5 says a successor needs, so the omission would change the address of the finding rather than remove it.

I also checked that my counterexample does not contradict given 4. The marginals-only optimum at $\lambda=\tfrac1{\sqrt6}(1,1,1,-1,-1,-1,0^{60})$ is $10/\sqrt6=4.082483$, below given 4's $11/\sqrt6=4.490731$, and the augmented value $8/\sqrt6$ is below that in turn, as adding a constraint requires. The three numbers are consistent, which is a further check on the reformulation.

## Verdict

**The audited pair splits, and the programme behind them does not reach the target.**

- **Claim 1, relation (B) at the padded $W_{\mathbb{CP}^2}$ spectrum: UPHELD IN FULL, and strengthened.** The three lines are correct, the constants are exact, and the tightness claim is true. I verified $T_{123}=2$ independently of the record by computing $[\omega_1,\omega_2]=\sqrt2\,\omega_3$ in $\Lambda^+\mathbb R^4$, which also confirms Lemma L153 at $n=4$ and relation (B) on that object. §2 adds that (B) at all three indices pins $S_{12}=S_{13}=S_{23}=2$ exactly, rather than merely bounding them.
- **Claim 2, contracted (B): CORRECTED, headline REFUTED.** The contraction and the dual family are right, the recorded optimum should be $\frac{115\sqrt6}{12}=23.474277$ rather than $23.48$, and "worse than useless" is an artefact of also uniformising the $N$ marginal multipliers down to one. With per-index marginals retained, contracted (B) gives exactly $5/\sqrt6=2.041241$ against the marginals-only $11/\sqrt6=4.490731$, a strict improvement by a factor of $11/5$. The conclusion "one multiplier per index, not one per relation" survives on the corrected comparison, at a factor of $5/3$ rather than nineteen.
- **The augmented programme as a route to Conjecture A: REFUTED.** At $n=12$ and $\lambda=\tfrac1{\sqrt6}(1,1,1,-1,-1,-1,0^{60})$ the per-index (B)-augmented programme admits the explicit feasible tensor of §8.3, with $\theta=8/\sqrt6=3.265986$ against $\theta_0(12)=1.236033$. The family value $(n-4)/\sqrt{2p}$ grows without bound in $n$ while $\theta_0(n)\to\sqrt2$, so the failure is structural. Per-index (B) improves the **global** worst case by at most $11/8$, not by the $11/3$ the audited spectrum suggests.
- **What the record should carry forward.** The padded $W_{\mathbb{CP}^2}$ result is a real, tight, spectrum-wise certificate and should be kept as one. The sentence asserting that (B) collapses "the worst spectrum" should be scoped to the marginals-only worst spectrum, with §8's spectrum recorded as the augmented programme's own obstruction. A successor needs an input that the per-index rows of (B) do not supply: either a realisability condition on the spectrum, or a further condition on $T$ beyond symmetry, hollowness, nonnegativity, the marginal and (B).
