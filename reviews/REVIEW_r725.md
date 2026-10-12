# Reviewer r725, the $\tfrac29$ identification: the join is on file, and the derivation compares a subspace of $S^2(\Lambda^2)$ with a subspace of $\mathcal W_n$

*Gate 2 on a derivation held off the record, attacking the `HYPOTHESIS-DEBT` at [second-order.md](../findings/second-order.md):1241. Cold brief; every count below was redone from the definitions before the derivation's own count was read, and the record was searched by mechanism afterwards. **Analysis only**: no search, sweep or falsifier hunt was run. Two screens were taken, each of a numeral this report records, the $\rho^{\mathrm{eff}}_n$ values under both candidate coefficients, and the identification of the debt box's own numerals, reported as screens and never as evidence for a positive claim. Log at [agent_logs/r725.log](../agent_logs/r725.log).*

| # | claim under review | verdict |
| --- | --- | --- |
| 1 | The $(2,2)$-split four-set block is $2$-dimensional per four-set, three pairings, one Bianchi relation | **CONFIRMED, AND NOT NEW.** It is [L120](../findings/second-order.md)'s own display and the second sentence of its proof, and [L121](../findings/second-order.md)'s signed coordinates |
| 2 | The Weyl trace conditions might cut the block further | **REFUTED.** A Ricci contraction needs a repeated index; on four distinct indices it is empty, as L120 states |
| 3 | The pair symmetry $R_{abcd}=R_{cdab}$ is a further relation | **REFUTED.** It is consumed before the count starts: the ambient space is $S^2(\Lambda^2)$, and the three pairings are three basis vectors of it |
| 4 | $R_{ijkl}$ ($i,j\in V_1$, $k,l\in V_2$) is *the* $\Lambda^2V_1\otimes\Lambda^2V_2$ component | **HALF-CONFIRMED.** True of the *coordinate*; false of the *subspace*, $(\Lambda^2V_1\odot\Lambda^2V_2)\cap\mathcal W_n=\{0\}$ |
| 5 | $R_{ikjl}$, $R_{iljk}$ lie in $S^2(V_1\otimes V_2)$, "and Bianchi leaves one dimension of them" | **CONFIRMED THEN REFUTED.** The two coordinates are $S^2(V_1\otimes V_2)$ coordinates; Bianchi leaves *two* of them, the block projecting onto the whole $(y,z)$ plane. What is $1$-dimensional is $\text{block}\cap\{x=0\}$ |
| 6 | HEADLINE, "the $(2,2)$ four-set block strictly contains the $\Lambda^2\otimes\Lambda^2$ summand, $2$ against $1$" | **REFUTED.** Read literally the containment runs empty, not strict; read as the summand's image in $\mathcal W_n$ it is a containment the derivation's own conclusion denies |
| 7 | "The decompositions provably do not coincide, and nothing joins them" | **REFUTED.** $\Lambda^2\otimes\Lambda^2=\bigoplus_{(2,2)}(\text{the }+\mu\text{ line of that block})$, proved in §3 from L26, L27 and L121 alone |
| 8 | Consequence 1, "$\sigma\le\tfrac29$ bounds the whole block, so the record's use is safe but loose" | **WITHDRAWN.** Safe and **sharp**: $\sigma\le\tfrac29$ holds on all of $\mathcal W_n$ with equality exactly on $\Lambda^2\otimes\Lambda^2$ |
| 9 | Consequence 2, "margin and penalty on different spaces, so L149's convex-combination form fails" | **REFUTED TWICE.** They are on the same summand; and a min-margin/max-penalty combination is a valid lower bound even when they are not |
| 10 | "Which of the two holds is not decidable from the passages read here" | **REFUTED.** It is decided by [L133](../findings/second-order.md) step 3, which the derivation cites for the count and does not read for the eigenvector |
| 11 | A third reading exists | **CONFIRMED, AND IT IS THE ANSWER.** The debt is dischargeable in closed form; $\tfrac29$ stands, and with it L149's monotonicity |
| 12 | *New, against the record*: the debt box's floor numeral $0.582938$ | **DEFECT.** It evaluates $a$ at $n=12$ inside an $n\to\infty$ limit; the floor is $0.589804$. The direction of the claim is unaffected |
| 13 | *New, against the record*: ":1241's phrase "identifies **that block** with $\Lambda^2\otimes\Lambda^2$"" | **DEFECT OF WORDING.** What is identified is the block's $+\mu$ **line**. Read as written it over-counts the summand by a factor $2$, which is the trap the derivation fell into |

**One line.** The count is right and is the record's own; the headline is a category error, $\Lambda^2\otimes\Lambda^2$ is compared as a subspace of $S^2(\Lambda^2)$, where it meets $\mathcal W_n$ only at zero, against a block that lives inside $\mathcal W_n$, and the join the derivation declares absent is three lines of the record it cites, so the debt is discharged here rather than deepened.

## 0. Conventions, fixed once

All from [conventions.md](../findings/conventions.md), quoted and not restated.

- $\mathcal W_n\subset S^2(\Lambda^2\mathbb R^n)$ is the algebraic Weyl space: pair symmetry is built into the ambient $S^2(\Lambda^2)$, and $\mathcal W_n$ is cut out of it by the first Bianchi identity and by Ricci-flatness.
- $\mathrm{Alt}$ is the **orthogonal projection** of $S^2(\Lambda^2)$ onto $\Lambda^4$, carrying its $\tfrac13$: $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$, self-adjoint and idempotent, and $\mathrm{Alt}(H)=0$ for every $H$ satisfying first Bianchi.
- $\{\varphi_{ab}\}_{a<b}$ is orthonormal under the record's half-trace pairing.
- Setting throughout: $W^*=S^m\times S^m$, $n=2m$, $\mathbb R^n=V_1\oplus V_2$, the frame the product frame, $e=W^*/\theta_0$, $L_e=e\circ(\cdot)$, $\mu=\mu_{m,m}=\tfrac2{n-2}=\tfrac1{m-1}$, $\lambda_m=\tfrac{m-2}{2(m-1)}$.
- Signed coordinates on a four-set block are [L121](../findings/second-order.md)'s: $(x,y,z)=(H_{ij,kl},H_{ik,jl},H_{il,jk})$ **with the middle pairing negated**, in which first Bianchi reads $x+y+z=0$ and $\mathrm{Alt}$ is the orthogonal projection onto $\mathbf 1$. The Frobenius norm is $\lVert H\rVert^2=\gamma(x^2+y^2+z^2)$ with $\gamma=2$; $\gamma$ cancels from everything below.
- $\sigma(H):=\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\rVert^2/\lVert H\rVert^2$, the quantity [L141](../findings/second-order.md)(a) bounds by $\tfrac14$ and [L133](../findings/second-order.md) step 2 bounds by $\tfrac29$.

## 1. The count, redone from scratch

Fix distinct $i,j,k,l$. In $S^2(\Lambda^2)$ the vectors carrying the sign character $\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_l$ are the three pairings $\varphi_{ij}\odot\varphi_{kl}$, $\varphi_{ik}\odot\varphi_{jl}$, $\varphi_{il}\odot\varphi_{jk}$. They are independent (distinct unordered pairs of distinct basis bivectors) so the pre-Bianchi count is **three**, and the pair symmetry has already been spent in writing $\odot$ rather than $\otimes$. It is not a further relation, and a count that imposed it a second time would return $3$ again by accident rather than by argument.

Two cuts are available.

- **First Bianchi.** $\mathrm{Alt}$ maps the character space to the one-dimensional $\Lambda^4$-line $e_i\wedge e_j\wedge e_k\wedge e_l$, surjectively. So Bianchi is exactly one relation and the cut is $3\to2$.
- **Ricci.** A Ricci contraction $\sum_a R_{iaja}$ needs a repeated index. Every component in this character space carries four **distinct** indices, so no Ricci condition touches it: the cut is empty.

**Two dimensions per four-set.** This is [L120](../findings/second-order.md)'s $\underbrace{V_{ijkl}}_{2}$, with the same two reasons in the same order, and it is the plane $\mathbf 1^\perp$ of [L121](../findings/second-order.md). *The derivation's count is correct and is not a finding; the passage it attacks proves it four hundred lines above.*

**And the "(2,2)-split" qualifier is licensed.** L120's blocks are indexed by four-subsets of $[n]$ and are defined by a sign character, with no reference to $V_1\oplus V_2$; L120's own scope note says criticality is unused and $\Gamma$-equivariance needs only that $M$ is $\Gamma$-fixed, which $W^*$ is in the product frame. The split type $(4,0)/(3,1)/(2,2)$ is a partition of the index set of blocks, not a second decomposition of the space, so the two are compatible by construction. **The derivation's weakest-looking link is in fact sound**, and the brief's suspicion that L120's sign characters name a different partition is not borne out.

## 2. Where the two dimensions live, and the category error

The derivation's assignment is right about coordinates and wrong about spaces, and the whole headline turns on the difference.

**Right.** $\varphi_{ij}\odot\varphi_{kl}$ with $\{i,j\}\subset V_1$, $\{k,l\}\subset V_2$ lies in the summand $\Lambda^2V_1\odot\Lambda^2V_2\cong\Lambda^2V_1\otimes\Lambda^2V_2$ of $S^2(\Lambda^2)$; $\varphi_{ik}\odot\varphi_{jl}$ and $\varphi_{il}\odot\varphi_{jk}$ have one index in each factor in every slot and lie in $S^2(V_1\otimes V_2)$. The decomposition $\Lambda^2\mathbb R^n=\Lambda^2V_1\oplus\Lambda^2V_2\oplus(V_1\otimes V_2)$ is as the derivation states.

**Wrong, and exhibited in closed form.** $\Lambda^2V_1\odot\Lambda^2V_2$ contains no nonzero Weyl tensor at all:

$$Z=\sum_{\pi\subset V_1,\ \rho\subset V_2}c_{\pi\rho}\,\varphi_\pi\odot\varphi_\rho\ \Longrightarrow\ \mathrm{Alt}(Z)=\tfrac13\sum_{\pi\rho}c_{\pi\rho}\,e_\pi\wedge e_\rho,$$

and the $\binom m2^2$ four-forms $e_\pi\wedge e_\rho$ are distinct basis vectors of $\Lambda^4$, hence independent. So $\mathrm{Alt}(Z)=0$ forces every $c_{\pi\rho}=0$. Since $\mathcal W_n\subseteq\ker\mathrm{Alt}$,

$$\boxed{\ (\Lambda^2V_1\odot\Lambda^2V_2)\cap\mathcal W_n=\{0\}.\ }$$

**Therefore "the block strictly contains the $\Lambda^2\otimes\Lambda^2$ summand" is false in the literal reading, and false in the direction the derivation did not consider**: the containment is not strict, it is empty. A $2$-dimensional subspace of $\mathcal W_n$ cannot contain a line that meets $\mathcal W_n$ at the origin.

**And the derivation's own second bullet is wrong on its own terms.** "Bianchi leaves one dimension of them" is not what Bianchi does. On the block, $x=-(y+z)$, so the projection of the block to the $(y,z)$-plane (the $S^2(V_1\otimes V_2)$ coordinates), is an **isomorphism**, not a $2\to1$ cut. What is one-dimensional is $\text{block}\cap\{x=0\}=\mathrm{span}(0,1,-1)$, which is a different object and requires the orthogonal splitting the derivation elsewhere denies exists.

**The category error, named.** The derivation compares $\dim(\Lambda^2V_1\odot\Lambda^2V_2\text{ per four-set})=1$, computed in $S^2(\Lambda^2)$, against $\dim V_{ijkl}=2$, computed in $\mathcal W_n$. Those two numbers are counted in different spaces, and the only reading under which "$1$" names a subspace of $\mathcal W_n$ is the image of the summand under the orthogonal projection $\mathcal W_n\leftarrow S^2(\Lambda^2)$, which is §3, and which is a join.

## 3. The join, in closed form

**Claim.** For $m\ge5$, $\ \Lambda^2\otimes\Lambda^2=\bigoplus_{\{i,j\}\subset V_1,\{k,l\}\subset V_2}\mathbb R\,X_{ijkl}$, where $X_{ijkl}$ is the $+\mu$ eigenvector of $L_e$ in [L120](../findings/second-order.md)'s block $V_{ijkl}$, and $X_{ijkl}$ is the orthogonal projection of $\varphi_{ij}\odot\varphi_{kl}$ into $\mathcal W_n$.

**Step 1, the projection is the $+\mu$ line.** On the four-set character space the Weyl condition is $\mathbf 1^\perp$ and $\mathrm{Alt}$ is the projection onto $\mathbf 1$, so the orthogonal projection of $\varphi_{ij}\odot\varphi_{kl}=(1,0,0)$ into $\mathcal W_n$ is

$$(1,0,0)-\tfrac13(1,1,1)=\tfrac13(2,-1,-1).$$

That is [L26](../findings/nondegeneracy.md)'s $X=\varphi_\pi\odot\varphi_\rho$ "with its $\Lambda^4$ component removed", whose recorded coefficients $\tfrac23,\tfrac13,-\tfrac13$ become the signed triple $(\tfrac23,-\tfrac13,-\tfrac13)$ and whose norm $\lVert X\rVert^2=\gamma\cdot\tfrac69=\tfrac43$ at $\gamma=2$, both numbers on the record, in [L26](../findings/nondegeneracy.md) and in [L133](../findings/second-order.md) step 3. And L133 step 3 states in one clause that this is the $+\mu$ eigenvector, with $(0,1,-1)$ at $-\mu$.

**Step 2, the span is the whole summand, and this needs no source.** $L_eX_{ijkl}=\mu X_{ijkl}$ by [L26](../findings/nondegeneracy.md). Distinct four-sets carry distinct sign characters, so the $\binom m2^2$ vectors $X_{ijkl}$ are independent. By [L27](../findings/nondegeneracy.md), $L_e$ is a scalar on each of the ten multiplicity-free summands, with values $1$, $\tfrac12$, $\lambda_m$ (twice), $+\mu$ on $\Lambda^2\otimes\Lambda^2$, $-\mu$ on $S^2_0\otimes S^2_0$ and $0$ on the remaining four. At $m\ge5$ the value $\mu=\tfrac1{m-1}$ is distinct from every other value on that list, $\mu>0$ separates it from $0$ and $-\mu$; $\mu<\tfrac12$ from $\tfrac12$ and $1$; and $\lambda_m-\mu=\tfrac{m-4}{2(m-1)}>0$ from $\lambda_m$. Hence $E_{L_e}(\mu)=\Lambda^2\otimes\Lambda^2$ exactly, of dimension $\binom m2^2$. A space of dimension $\binom m2^2$ containing $\binom m2^2$ independent vectors equals their span. $\square$

*So the identification does not rest on the citation. L26's source line, "Nienhaus Proposition 4.6 supplies the $SO(p)\times SO(q)$ decomposition in which this family **is** the $\Lambda^2(\mathbb R^p)\otimes\Lambda^2(\mathbb R^q)$ summand, for $p,q\ge5$", says the same thing, and L149 runs at $m\ge6$, inside that range.*

**Step 3, the block splits, orthogonally, across the two decompositions.** Each $(2,2)$ block is

$$V_{ijkl}=\underbrace{\mathbb R(2,-1,-1)}_{\text{the }\Lambda^2\otimes\Lambda^2\text{ line, }L_e=+\mu}\ \perp\ \underbrace{\mathbb R(0,1,-1)}_{\subset S^2(V_1\otimes V_2),\ L_e=-\mu},$$

the two being orthogonal ($2\cdot0-1\cdot1-1\cdot(-1)=0$) and the second lying literally inside $S^2(V_1\otimes V_2)$, being the $x=0$ line. **This is the derivation's own final sentence ("the other dimension sits in $S^2(V_1\otimes V_2)$") and it is true only because the join exists.** The derivation uses the join to state its conclusion and then concludes that no join exists.

*One asymmetry worth stating, because it is the reason the $+\mu$ line is the canonical one: the $-\mu$ line sits literally inside $S^2(V_1\otimes V_2)$, while the $+\mu$ line sits inside $\Lambda^2V_1\odot\Lambda^2V_2$ only after projection. The sum of the $-\mu$ lines is $\binom m2^2$-dimensional and is **not** the $S^2_0\otimes S^2_0$ summand, which has dimension $\big(\tfrac{(m+2)(m-1)}2\big)^2$, it is only that summand's four-set-supported part, and it is not $O(m)\times O(m)$-invariant. The $+\mu$ side is the one where the four-set lines assemble into a whole summand.*

## 4. $\sigma\le\tfrac29$ is a global bound, and it is attained exactly on $\Lambda^2\otimes\Lambda^2$

From [L133](../findings/second-order.md) step 2, $\mathrm{Alt}\,DW_-[H]=-\tfrac x3\mathbf 1$ on a $(2,2)$ block and $0$ on every other block of the decomposition, the $(4,0)$ and $(3,1)$ four-sets, the pair blocks and $\mathcal D_n$. Distinct blocks carry distinct characters, so the images are orthogonal and

$$\sigma(H)=\frac{\sum_{b\,(2,2)}\tfrac\gamma3x_b^2}{\sum_b\gamma(x_b^2+y_b^2+z_b^2)+\lVert H_{\text{other}}\rVert^2}\ \le\ \max_{x+y+z=0}\frac{x^2}{3(x^2+y^2+z^2)}.$$

Given $x$, the constraint $y+z=-x$ minimises $y^2+z^2$ at $y=z=-\tfrac x2$ with value $\tfrac{x^2}2$, so the ratio is at most $\tfrac{x^2}{3\cdot\tfrac32x^2}=\tfrac29$, with equality **iff** $H\propto(2,-1,-1)$ in every block it occupies, that is, iff $H\in\Lambda^2\otimes\Lambda^2$ by §3.

$$\boxed{\ \sigma(H)\le\tfrac29\ \text{on all of }\mathcal W_n,\ \text{with equality exactly on }\Lambda^2\otimes\Lambda^2;\ \sigma\equiv0\ \text{on its orthogonal complement inside the }(2,2)\ \text{blocks}.\ }$$

**This also confirms [L141](../findings/second-order.md)(b) internally.** Its $s$ is "the fraction of a direction's weight carried by the defect-active part of the block", so $\sigma=\tfrac29s$ and the Hessian term is $3\theta_0(\mu s-\mu(1-s)-\tfrac12)=3\theta_0(2\mu s-\mu-\tfrac12)$, reproducing the display

$$\frac{Q}{\lVert H\rVert^2}=3\theta_0\big(2\mu s-\mu-\tfrac12\big)+\tfrac29\lvert\kappa_n\rvert s$$

verbatim, increasing in $s$, with $s=1$ **being** the $\Lambda^2\otimes\Lambda^2$ line. *L141(b)'s "defect-active part of the block" and L149's "$\Lambda^2\otimes\Lambda^2$ summand" are the same object, and L141(b) already carries the join in the arithmetic of its own display.*

## 5. The two consequences, and the third reading

**Consequence 1 ("safe but loose"), WITHDRAWN.** $\sigma\le\tfrac29$ does bound the whole block, so the use is safe. It is not loose: $\tfrac29$ is attained, and attained precisely on the summand the penalty is charged to. The coefficient cannot be improved.

**Consequence 2 ("different spaces, so the convex combination fails"), REFUTED, and it would not have followed even if the premise held.** [L149](../findings/second-order.md)'s margin coefficient is the *smallest surviving* summand margin. The surviving summands are the ten minus $\langle W\rangle$, minus the orbit, minus the two $S^2_0$ copies that make up $\Sigma$; their $L_e$ values are $+\mu$, $-\mu$ and $0$, so the largest is $\mu$ and the smallest margin is $3\theta_0(\tfrac12-\mu)$, on $\Lambda^2\otimes\Lambda^2$. The penalty is $\lvert\kappa_n\rvert\sigma$, which by §4 is largest (and nonzero only), on the same summand. **Same summand, both attained, and jointly attained on a single direction**: putting weight $w$ on $\Lambda^2\otimes\Lambda^2$ and $\sqrt{1-w^2}$ on $\Sigma$ gives

$$c(H)-\lvert\kappa_n\rvert\sigma(H)=c_p+3\theta_0(\lambda_m-\mu)w^2-\tfrac29\lvert\kappa_n\rvert w^2=c_p+\rho^{\mathrm{eff}}_nw^2$$

with equality, which is exactly L149's numerator. *And had the two extrema sat on different summands, the combination would still have been a valid **lower** bound, a minimum of margins minus a maximum of penalties always is; it would have been loose, not broken. The derivation's consequence 2 mistakes a possible looseness for a failure of form.*

**The third reading, which is the answer.** The debt is dischargeable, and §3–§4 discharge it: what was owed is not "the block equals $\Lambda^2\otimes\Lambda^2$" (which is false) but "**the $+\mu$ line of each $(2,2)$ block is $\Lambda^2\otimes\Lambda^2$'s share of that block, and $\sigma=\tfrac29$ exactly there**", which is true, proved above from L26, L27 and L121, and already half-written in L133 step 3. So $\tfrac29$ stands as the sharp coefficient, and with it L149's monotonicity and positivity of $\rho^{\mathrm{eff}}_n$.

**A screen, reported as a screen.** Under the coefficient $\tfrac29$ the record's $\rho^{\mathrm{eff}}_n$ reads $0.719043,\ 0.872390,\ 0.985640,\ 1.072737$ at $n=12,14,16,18$ (the record's own four numerals) and the closed form $\sqrt6-\theta_0(n)\tfrac{n+16}{2(n-2)}$ agrees to six digits. Under coefficient $1$ it reads $0.640026$ at $n=12$, falling to $0.416105$, which is the record's $0.6400\to0.4161$. *This distinguishes the two readings and settles nothing on its own; §3–§4 are what settle it.*

## 6. What the record already had, searched by mechanism

Searched for the mechanism, "the projection of a $\Lambda^2\odot\Lambda^2$ vector into the Bianchi plane", "which eigenvector of the four-set block", "which summand carries the smallest margin", rather than for the symbols the derivation uses. No other reviewer's report was opened.

| where | what it already says |
| --- | --- |
| [L26](../findings/nondegeneracy.md), statement | $X=\varphi_\pi\odot\varphi_\rho$ **with its $\Lambda^4$ component removed** is in $\mathrm{Weyl}_n$ with $e\circ X=\mu X$, the projection, the eigenvalue, and the coefficients $\tfrac23,\tfrac13,-\tfrac13$ |
| [L26](../findings/nondegeneracy.md), Sources | "the $SO(p)\times SO(q)$ decomposition in which **this family is the $\Lambda^2(\mathbb R^p)\otimes\Lambda^2(\mathbb R^q)$ summand**, for $p,q\ge5$", the join, stated outright |
| [L27](../findings/nondegeneracy.md) | the ten-summand list, multiplicity-free, $+\mu$ on $\Lambda^2\otimes\Lambda^2$ and $-\mu$ on $S^2_0\otimes S^2_0$ |
| [L133](../findings/second-order.md) step 3 | the $+\mu$ eigenvector of the $(2,2)$ block **is** L26's $X$, signed triple $(\tfrac23,-\tfrac13,-\tfrac13)$, with $(0,1,-1)$ at $-\mu$ |
| [L148](../findings/second-order.md), scope box | "at $m=4$ the eigenspace strictly contains it, **picking up $\Lambda^2\otimes\Lambda^2$**", and at $m=3$ "the margin sits on $\Lambda^2\otimes\Lambda^2$ instead", the record already treats the name as the $+\mu$ eigenspace |

**So the debt line's "nothing on file joins the two decompositions" was true only of an explicit sentence, never of the content.** The chain L26 $\to$ L133 step 3 $\to$ L27 was on file, in two of the three lemmas the debt line itself cites. *This is the failure the brief warned of, and the derivation commits it: it cites L133 for the support table and does not read L133's next step, where the eigenvector it needs is written down.*

## 7. One defect found on the way, against the record rather than the derivation

The debt box at [second-order.md](../findings/second-order.md):1241 reads: *"At coefficient $1$ the constant reads $0.689771$ and decreases to a floor of $0.582938$."*

The constant is not $\rho^{\mathrm{eff}}$, it is L149's $n$-free coefficient $\big(\tfrac{\sqrt2n}{3\sqrt{(n-1)(n-2)}}+\tfrac1\rho\big)^{-1/2}$, whose $\tfrac29$-value is the recorded $0.7197978$. At coefficient $1$ and $n=12$ it is $0.689771$, reproduced exactly, so the head numeral is right and correctly labelled. **The floor is not.** Both factors move with $n$: the first term falls from $0.539368$ at $n=12$ to $\tfrac{\sqrt2}3=0.471405$, while $\rho$ falls from $0.640026$ to $0.416105$, giving a limit of

$$\big(0.471405+1/0.416105\big)^{-1/2}=0.589804 .$$

The recorded $0.582938$ is what comes out of holding the **first** term at its $n=12$ value $0.539368$ while sending $\rho$ to its limit: $(0.539368+2.403252)^{-1/2}=0.582924$. *A finite-$n$ constant inside an asymptotic limit, the class of error [second-order.md](../findings/second-order.md):1322 names in the entry twelve lines below.* The claim the box draws from it, that the constant **decreases** under coefficient $1$, reversing the monotonicity, survives untouched, $0.689771>0.589804$. Only the numeral is wrong, by $1.18\%$.

*Screened, not swept: the two evaluations above are of a numeral this report records, and are reported as a screen.*

## 8. The strongest defence of the derivation, and where it fails

**The defence.** *"The record's own sentence is 'reading it here identifies **that block** with $\Lambda^2\otimes\Lambda^2$'. The block is $2$-dimensional and the summand's share of it is $1$-dimensional. Those are different, the record says 'that block', and pointing at the discrepancy is exactly what a Gate 2 is for. Everything after that is a matter of wording."*

**Why it fails, in three steps.**

1. **The discrepancy it names is in the record's paraphrase, not in the record's mathematics.** L141(b) charges the penalty at $s=1$, and $s$ is the weight on the defect-active part, one dimension, not two. L149 charges the margin at the smallest surviving summand, one summand, not a block. Neither lemma ever uses a $2$-dimensional object where a $1$-dimensional one belongs. The over-count exists only in the debt box's own gloss, which is why §7's second defect is booked as wording.
2. **The derivation does not stop at the wording.** It concludes "the decompositions **provably do not coincide**" and "what is owed is which space each of $\sigma$ and the margin actually lives on", a positive claim that the join is unavailable. That claim is false, and its falsity is one line of L133 away.
3. **Its own dimension statement is unsound.** "Strictly contains, $2$ against $1$" requires the summand to be a subspace of the block. §2 shows the summand meets $\mathcal W_n$ at $\{0\}$, so under the reading that makes the sentence's words true, the sentence's content is false; and under the reading that makes the content true, the containment is the join being denied.

*What survives from the derivation:* the observation that the record's phrase over-counts, and the correct count of $2$, both of which the record already held, and neither of which supports the conclusion drawn.

## 9. Verdict

**The derivation is `withdrawn`.** Its count is correct and duplicated; its headline is a category error exhibited in closed form at §2; its "nothing joins the two decompositions" is refuted at §3 by three passages of the record it cites; and both of the consequences it offers are refuted at §5.

**What replaces it, and is offered to the record as the discharge of the debt at [second-order.md](../findings/second-order.md):1241**, *unaudited, and stated as this reviewer's derivation rather than as a finding*:

> $\Lambda^2\otimes\Lambda^2$ is the sum, over the $\binom m2^2$ $(2,2)$-split four-sets, of the $+\mu$ line $\mathbb R(2,-1,-1)$ of [L120](../findings/second-order.md)'s block, that line being the orthogonal projection of $\varphi_\pi\odot\varphi_\rho$ into $\mathcal W_n$, which is [L26](../findings/nondegeneracy.md)'s $X$. On it $\sigma=\tfrac29$ exactly; on its orthogonal complement inside the blocks $\sigma=0$; and $\sigma\le\tfrac29$ on all of $\mathcal W_n$ with equality there alone. The margin's smallest surviving summand is the same one, so [L149](../findings/second-order.md)'s $\rho^{\mathrm{eff}}_n=3\theta_0\tfrac{n-8}{2(n-2)}-\tfrac29\lvert\kappa_n\rvert$ is attained, and its monotonicity and positivity stand.

**And two defects against the record**, both small and both booked in the table above: the floor numeral $0.582938$ at §7, and the phrase "identifies that block with $\Lambda^2\otimes\Lambda^2$", which should read "identifies that block's $+\mu$ line with $\Lambda^2\otimes\Lambda^2$".
