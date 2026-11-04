# Review r917, L204: the sharp $\Lambda^4$ bound and the ruling between two rival constants

This round read a written derivation link by link. I read the L204 block at [findings/bounds.md](../findings/bounds.md), the wedge normalisation at [wedgeSelf_apply](../lean/HamiltonsCubic/Base/SelfDual.lean), the Alt normalisation at [altCoeff_eq_third_bianchi](../lean/HamiltonsCubic/Base/AltPart.lean), the four statements of [L204AltBound.lean](../lean/HamiltonsCubic/Results/L204AltBound.lean), the $\Lambda^4$ norm convention at [conventions.md](../findings/conventions.md), and [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean). Every step below is derived by hand from the component definitions. The computation was a few seconds of exact rational arithmetic on objects built for the purpose, reported as a screen: it fixes conventions and reproduces the block's own numbers, and it establishes nothing. Log: [agent_logs/gate2-l204-r917.log](../agent_logs/gate2-l204-r917.log).

## Claim table

| # | Item | Verdict | Reason |
|---|---|---|---|
| 1 | The eigen-expansion and the $\tfrac16$ | CONFIRMED | $\tfrac16=\tfrac13\cdot\tfrac12$, the record's Alt against the record's wedge, and an independent projection computation at $n=4$ returns $\tfrac16$ on the nose |
| 2 | Where positivity is spent | CONFIRMED | spent at exactly one step, $\sum\lvert\mu_\alpha\rvert=\mathop{\mathrm{tr}}A$, and the witness is exact at $\sqrt{2/3}$ against a zero trace |
| 3 | The polynomial identity | CONFIRMED | derived from components in the record's wedge convention, skewness alone suffices, and it is the record's own $\Phi$-sphere identity rescaled by the factor $6$ between the two $\Lambda^4$ norms |
| 4 | The rank step and Cauchy--Schwarz | CONFIRMED | $\omega^2=-\omega^{\mathsf T}\omega$, rank even and at most $2m$ at odd $n$ too, and the factor $2$ and the $m$ land where the block puts them by two independent countings |
| 5 | The combination | CONFIRMED | a maximum rather than a bound, attained at the balanced bivector, and $\tfrac16\sqrt{12(m-1)/m}=\sqrt{(m-1)/(3m)}$ identically |
| 6 | The canonical-form route | CONFIRMED | the $24$ and its $\tfrac14\cdot4!\cdot2^2$ reading are right, the maximisation is the flat-simplex one, $O(n)$-equivariance of the wedge licenses the reduction, and the routes agree exactly |
| 7 | The ruling and sharpness | CONFIRMED | $2m\le n$ with equality exactly at even $n$ is the whole content, and the $m$-form is attained at every $n$, odd $n$ included, so it is sharp rather than merely smaller |
| 8 | The $W_{\mathbb{CP}^2}$ attainment | CONFIRMED | trace-free in $S^2\Lambda^2_+$, so Bianchi and Ricci-flat follow at $n=4$, and $\lVert\mathrm{Alt}(W^2)\rVert^2=6$ against $\mathop{\mathrm{tr}}(W^2)=6$ is equality on the nose |
| 9 | The rival bound and the crossover | GAP | the bound and the threshold are right, and the quantifier is wrong: $r>3m/(m-1)$ is the flat-spectrum crossover, false as a claim about every rank-$r$ operator |
| 10 | Hypothesis inventory and reach | CONFIRMED | nothing used that is not stated, nothing stated and unused, and the application at $A=W^2$ is licensed by the norm agreement the $\tfrac14$ buys |
| 11 | The Lean statement | GAP | the type is faithful and non-vacuous, and two claims around it overreach: the doc-comment's "exactly when $n$ is even" is proved only at $n=9$, and the reach claim omits the odd-$n$ rank-evenness obligation |
| 12 | What would break it | CONFIRMED | the four-index norm's $\tfrac14$ and the rank bound $2\lfloor n/2\rfloor$ are the two load-bearing objects, and the wedge normalisation is not one because its factor cancels against the $\tfrac16$ |

**Summary.** The bound, its constant, its attainment and the ruling for the $m$-form are all correct and all follow from what is written, and the two GAPs are a wrong quantifier on the rival bound's crossover and two overclaims about what the Lean file and the second derivation deliver.

## 1. The eigen-expansion and the $\tfrac16$

**No finding on the identity, and the $\tfrac16$ is confirmed three ways.**

The record's Alt is $\tfrac13\mathfrak b$ by definition, not by theorem: [altCoeff_eq_third_bianchi](../lean/HamiltonsCubic/Base/AltPart.lean) is `rfl`. The record's wedge is $(\omega\wedge\omega)_{ijkl}=2(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$ at [wedgeSelf_apply](../lean/HamiltonsCubic/Base/SelfDual.lean), which by skewness is $2(\omega_{ij}\omega_{kl}+\omega_{ik}\omega_{lj}+\omega_{il}\omega_{jk})$, so it is twice the Bianchi sum of $\omega\otimes\omega$. For a rank-one $A=\omega\otimes\omega$ the four-index form is $A_{ijkl}=\omega_{ij}\omega_{kl}$, so $\mathfrak b(A)=\tfrac12\,\omega\wedge\omega$ and $\mathrm{Alt}(A)=\tfrac13\cdot\tfrac12\,\omega\wedge\omega=\tfrac16\,\omega\wedge\omega$. Linearity over the spectral decomposition $A=\sum_\alpha\mu_\alpha\,\omega_\alpha\otimes\omega_\alpha$ gives the block's line, and $\mathop{\mathrm{tr}}A=\sum_\alpha\mu_\alpha$ because the $\omega_\alpha$ are orthonormal.

**A notational discrepancy between the brief and the record, and the record is right.** The brief's definition line gives $(\omega\wedge\omega)_{ijkl}=\omega_{ij}\omega_{kl}+\omega_{ik}\omega_{lj}+\omega_{il}\omega_{jk}$ with no factor $2$, which is half the record's. Read literally it makes the block's identity and its $24$ both false by a factor of $4$ in the squared norm: my screen returns $3/2$ at the balanced unit bivector under the brief's formula against the block's $6$. The L204 block itself names the missing factor, calling the $24$ "$\tfrac14\cdot4!\cdot2^2$, the four-index norm's $\tfrac14$ against a basis four-form's $24$ signed components **and the wedge's own $2$**", so the block is self-consistent and the brief's line is the outlier. Everything below uses the record's convention.

**$\mathrm{Alt}=\tfrac13\mathfrak b$ is the orthogonal projection onto $\Lambda^4$, on the curvature-symmetric space and not on all four-index tensors.** Write $\mathfrak b=\mathrm{id}+\sigma+\sigma^2$ with $\sigma$ the cyclic permutation of the last three slots. As an index permutation $\sigma$ is orthogonal with $\sigma^*=\sigma^2$, so $\mathfrak b^*=\mathfrak b$ and $\tfrac13\mathfrak b$ is self-adjoint in the four-index inner product, the $\tfrac14$ being a positive scale that changes nothing here. On a totally antisymmetric $T$ the cyclic images are even permutations, so $\mathfrak b(T)=3T$ and $\tfrac13\mathfrak b$ is the identity on $\Lambda^4$. And $\mathfrak b$ of a curvature-symmetric tensor is totally antisymmetric, which I checked on $\omega\otimes\omega$ directly: swapping $i$ and $j$ flips all three terms of $\omega_{ij}\omega_{kl}+\omega_{ik}\omega_{lj}+\omega_{il}\omega_{jk}$. A self-adjoint idempotent with range $\Lambda^4$ is the orthogonal projection. **The qualification matters**: the pair symmetry $T_{ijkl}=T_{klij}$ is what makes the range land in $\Lambda^4$, and the block states the projection claim without it. A symmetric $A$ supplies it, so nothing in L204 is affected.

**The $\tfrac16+\tfrac56=1$ split, and it is a genuine third route.** Let $u$ be the balanced unit self-dual form at $n=4$ and $E$ the Levi-Civita four-form, which spans the one-dimensional $\Lambda^4\mathbb R^4$ and has $\lVert E\rVert^2=\tfrac14\cdot24=6$. Computing the projection of $u\otimes u$ onto that line without touching the wedge at all, $\langle u\otimes u,E\rangle=1$ exactly and $\lVert u\otimes u\rVert^2=1$, so the projection has squared norm $1/6$ and the complement $5/6$. Since $\lVert u\wedge u\rVert^2=6$, matching $\tfrac16\cdot\lVert u\wedge u\rVert$ against $\sqrt{1/6}$ forces the coefficient to be $\tfrac16$ and refutes the withdrawn $\tfrac13$, which would have delivered $2/3$. This also confirms that $\tfrac13\mathfrak b$ agrees with total antisymmetrisation here, since total antisymmetrisation is exactly that averaging projection. **And it confirms the $\tfrac14$**: $\lVert u\otimes u\rVert^2=1$ equals the operator Frobenius norm of a unit rank-one projection, which is the agreement the brief calls load-bearing. In general, for $A=\sum\mu_\alpha\omega_\alpha\otimes\omega_\alpha$ the four-index norm is $\tfrac14\sum_{\alpha\beta}\mu_\alpha\mu_\beta(2\delta_{\alpha\beta})^2=\sum_\alpha\mu_\alpha^2=\mathop{\mathrm{tr}}A^2$, exactly.

## 2. Where positivity is spent

**No finding, and the witness is exact.**

Positivity enters at one step and one step only. The triangle inequality gives $\lVert\mathrm{Alt}(A)\rVert\le\tfrac16\sum_\alpha\lvert\mu_\alpha\rvert\,\lVert\omega_\alpha\wedge\omega_\alpha\rVert\le\tfrac16 M\sum_\alpha\lvert\mu_\alpha\rvert$ with $M=\max_{\lVert\omega\rVert=1}\lVert\omega\wedge\omega\rVert$, and $\mu_\alpha\ge0$ is what turns $\sum\lvert\mu_\alpha\rvert$ into $\mathop{\mathrm{tr}}A$. Without it the true statement is the same bound with the nuclear norm $\sum\lvert\mu_\alpha\rvert$ in place of the trace, and the maximisation step is untouched, being a statement about bivectors alone.

**The witness checks.** At $n=4$ take $s_1$ a unit self-dual form and $a_1$ a unit anti-self-dual form, and $A=s_1\otimes s_1-a_1\otimes a_1$. Then $\mathop{\mathrm{tr}}A=0$, and since $\omega\wedge\omega=\langle\omega,\star\omega\rangle E$ we get $s_1\wedge s_1=E$ and $a_1\wedge a_1=-E$, my screen returning those two coefficients as exactly $+1$ and $-1$. So $\mathrm{Alt}(A)=\tfrac16(E+E)=\tfrac13E$ and $\lVert\mathrm{Alt}(A)\rVert^2=\tfrac19\cdot6=\tfrac23$, which the screen returns as the exact rational $2/3$. The bound would read $\sqrt{2/3}=0.816497\le0$. **Refuted without positivity, as the block says.**

**Positive semidefiniteness is used nowhere else.** Symmetry of $A$ is used twice more, for the spectral theorem and for the pair symmetry that item 1 needs, and those are consequences of symmetry rather than of positivity.

## 3. The polynomial identity

**No finding on the identity. It is true, skewness alone suffices, and it is not new.**

Write $a=\omega_{ij}\omega_{kl}$, $b=\omega_{ik}\omega_{lj}$, $c=\omega_{il}\omega_{jk}$, so $(\omega\wedge\omega)_{ijkl}=2(a+b+c)$ and $\lVert\omega\wedge\omega\rVert^2=\tfrac14\cdot4\sum_{ijkl}(a+b+c)^2=\sum_{ijkl}(a+b+c)^2$.

The squares. $\sum_{ijkl}a^2=\big(\sum_{ij}\omega_{ij}^2\big)^2=(2\lVert\omega\rVert^2)^2=4\lVert\omega\rVert^4$, and relabelling gives the same for $b$ and $c$, so the squares contribute $12\lVert\omega\rVert^4$. This uses only the norm convention.

The cross terms, each of which needs skewness three times. For $ab$, the index pattern $\omega_{ij}\omega_{kl}\omega_{ik}\omega_{lj}$ is the closed chain $i\to j\to l\to k\to i$ after the substitutions $\omega_{kl}=-\omega_{lk}$, $\omega_{ik}=-\omega_{ki}$, $\omega_{lj}=-\omega_{jl}$, so the product equals $-\omega_{ij}\omega_{jl}\omega_{lk}\omega_{ki}$ and $\sum_{ijkl}ab=-\mathop{\mathrm{tr}}(\omega^4)$. For $ac$ the chain $i\to j\to k\to l\to i$ needs only $\omega_{il}=-\omega_{li}$ and gives $-\mathop{\mathrm{tr}}(\omega^4)$. For $bc$ the chain $i\to k\to j\to l\to i$ needs three flips and gives $-\mathop{\mathrm{tr}}(\omega^4)$. Hence $2\sum(ab+ac+bc)=-6\mathop{\mathrm{tr}}(\omega^4)$ and

$$\lVert\omega\wedge\omega\rVert^2=12\lVert\omega\rVert^4-6\mathop{\mathrm{tr}}(\omega^4).$$

**Skewness alone suffices and is needed.** Only $\omega_{ba}=-\omega_{ab}$ was used, at no point $n$, no positivity, no normal form. Without it the three cross sums are traces of words in $\omega$ and $\omega^{\mathsf T}$ rather than of $\omega^4$.

**Both ends check.** $\varphi_{12}$ has $\lVert\varphi_{12}\rVert^2=1$ and $\varphi_{12}^2=-I_2$ on its block, so $\mathop{\mathrm{tr}}(\varphi_{12}^4)=2$ and the right side is $12-12=0$, which is right because a decomposable bivector wedges to zero. The balanced $(\varphi_{12}+\varphi_{34})/\sqrt2$ has $\omega^2=-\tfrac12I_4$, so $\mathop{\mathrm{tr}}(\omega^4)=1$ and the right side is $12-6=6$. My screen returns the left side as the exact rationals $0$ and $6$ from the record's wedge in components, and reproduces the identity exactly on random rational skew matrices at $n=3,4,5,6,7$.

**The finding that matters here is provenance, not correctness.** This identity is already in the record. [conventions.md](../findings/conventions.md) carries L183's $\Phi$ identity $\mathop{\mathrm{tr}}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2=2\langle\omega,\omega\rangle^2$ at every skew $\omega$ and every $n$, in the multi-index norm $\lVert\cdot\rVert_\perp^2=\sum_{i<j<k<l}$, together with the note that this norm is six times smaller than the $\tfrac14\sum_{ijkl}$ rule on the same array. Substituting $\lVert\omega\wedge\omega\rVert^2=6\lVert\omega\wedge\omega\rVert_\perp^2$ turns it into $12\lVert\omega\rVert^4-6\mathop{\mathrm{tr}}(\omega^4)$, character for character L204's identity. It is proved gap-free in the Lean layer at two dimensions already, [trace_pow_four_add_pf_sq](../lean/HamiltonsCubic/Results/PhiSphere.lean) at $n=4$ and [phi_sphere6](../lean/HamiltonsCubic/Results/PhiSphere.lean) at $n=6$, both closed by `ring` after the skew substitutions, and that file's own doc-comment names the general-$n$ form as the shape the statement takes. **The L204 block presents the identity as new and links neither place**, which understates its support and duplicates an obligation conventions.md already logs as owed.

## 4. The rank step and the Cauchy--Schwarz

**No finding. The factor $2$ and the $m$ are where the block puts them, and I checked it by two independent countings.**

$\omega^2=\omega\omega=-\omega^{\mathsf T}\omega$ for skew $\omega$, so it is symmetric with $\langle\omega^2x,x\rangle=-\lVert\omega x\rVert^2\le0$: negative semidefinite, confirmed. Its kernel is $\ker\omega$, so $\mathop{\mathrm{rank}}\omega^2=\mathop{\mathrm{rank}}\omega$, which is even for a real skew matrix and at most $n$, hence at most $2\lfloor n/2\rfloor=2m$. **At odd $n$ this is the sharper statement** $\mathop{\mathrm{rank}}\le n-1=2m$, and evenness is exactly what supplies it.

Let $\nu_1,\dots,\nu_r$ be the nonzero eigenvalues of $\omega^2$, $r\le2m$. Then $\sum_p\nu_p=\mathop{\mathrm{tr}}(\omega^2)=-\mathop{\mathrm{tr}}(\omega^{\mathsf T}\omega)=-2\lVert\omega\rVert^2$ and $\sum_p\nu_p^2=\mathop{\mathrm{tr}}(\omega^4)$, so Cauchy--Schwarz gives

$$\mathop{\mathrm{tr}}(\omega^4)\ \ge\ \frac{\big(\sum_p\nu_p\big)^2}{r}\ =\ \frac{4\lVert\omega\rVert^4}{r}\ \ge\ \frac{4\lVert\omega\rVert^4}{2m}\ =\ \frac{2\lVert\omega\rVert^4}{m}.$$

The $4$ comes from squaring $2\lVert\omega\rVert^2$ and is halved by the $2m$, which is where the block's factor $2$ and its $m$ rather than $2m$ come from. **Crossing it against the pairing catches any off-by-two.** The eigenvalues of $\omega^2$ come in equal pairs, $-\lambda_i^2$ twice per block, so $\mathop{\mathrm{tr}}(\omega^4)=2\sum_{i\le m}\lambda_i^4$ and $\lVert\omega\rVert^2=\sum_i\lambda_i^2$, and Cauchy--Schwarz over $m$ blocks gives $\sum_i\lambda_i^4\ge\lVert\omega\rVert^4/m$, hence the same $\mathop{\mathrm{tr}}(\omega^4)\ge2\lVert\omega\rVert^4/m$. The two countings agree, so there is no off-by-two.

## 5. The combination

**No finding, and it is a maximum rather than an upper bound.**

Items 3 and 4 give $\lVert\omega\wedge\omega\rVert^2\le12\lVert\omega\rVert^4-12\lVert\omega\rVert^4/m=12\lVert\omega\rVert^4(m-1)/m$, so at $\lVert\omega\rVert=1$ the value is at most $12(m-1)/m$.

**Attained.** At the balanced $\omega=m^{-1/2}\sum_{i\le m}\varphi_{2i-1,2i}$, $\omega^2=-m^{-1}I_{2m}$ on its support, so $\mathop{\mathrm{tr}}(\omega^4)=2m\cdot m^{-2}=2/m$ and the identity returns $12-12/m$ exactly. My screen returns $12(m-1)/m$ as the exact rationals $6,6,8,9,9$ at $n=4,5,6,8,9$, and the repeat of $6$ at $n=5$ and of $9$ at $n=9$ is the $m$-dependence showing: an odd dimension adds no room.

The arithmetic is exact: $\tfrac16\sqrt{12(m-1)/m}=\tfrac13\sqrt{3(m-1)/m}=\sqrt{3(m-1)/(9m)}=\sqrt{(m-1)/(3m)}$.

## 6. The canonical-form route, read independently

**No finding. The $24$, its decomposition and the maximisation are all right, and both routes agree.**

**The reduction is legitimate.** Under $\omega\mapsto Q\omega Q^{\mathsf T}$ with $Q\in O(n)$, the wedge is equivariant as a $(0,4)$ tensor, since each of its terms is a product of two entries contracted the same way, and the four-index Frobenius norm and $\lVert\omega\rVert^2=\tfrac12\mathop{\mathrm{tr}}(\omega^{\mathsf T}\omega)$ are both $O(n)$-invariant. So both sides are invariant and the real normal form of a skew matrix puts $\omega$ in the block shape. The block says this step "was not written and is owed" and cites it in one clause, which is a fair self-assessment: the step is true, and the second derivation makes it unnecessary.

**The count.** With $\omega=\sum_{i\le m}a_i\varphi_{2i-1,2i}$ and the $\varphi$ orthonormal, $\sum_ia_i^2=\lVert\omega\rVert^2=1$. An entry $\omega_{ab}$ is nonzero only on a block, so a term $\omega_{ij}\omega_{kl}$ survives only when $\{i,j\}$ and $\{k,l\}$ are two distinct blocks, giving the $\binom m2$ index sets the block names. On blocks $\{1,2\}$ and $\{3,4\}$ the component at $(1,2,3,4)$ is $2(\omega_{12}\omega_{34}+0+0)=2(-a_p)(-a_q)=2a_pa_q$, **so the stated value $2a_ia_j$ is right in the record's convention**, and all $4!=24$ orderings of the four-element set carry $\pm2a_pa_q$ while every quadruple with a repeated index vanishes. Hence $\sum_{ijkl}T^2=24\cdot4\sum_{p<q}a_p^2a_q^2$ and $\lVert T\rVert^2=\tfrac14\cdot4!\cdot2^2\sum_{p<q}a_p^2a_q^2=24\sum_{p<q}a_p^2a_q^2$. **The $24$ and its reading as $\tfrac14\cdot4!\cdot2^2$ are both confirmed.**

**The maximisation.** With $t_p=a_p^2\ge0$ and $\sum t_p=1$, $\sum_{p<q}t_pt_q=\tfrac12\big(1-\sum_pt_p^2\big)$, maximised where $\sum t_p^2$ is least, at $t_p=1/m$, giving $(m-1)/(2m)$. So $\lVert\omega\wedge\omega\rVert^2=24\cdot(m-1)/(2m)=12(m-1)/m$, **identical to item 5's value**, and the balanced maximiser is the same bivector. The two routes agree exactly.

## 7. The ruling, and whether the $m$-form is sharp

**No finding on the ruling. It is correct, and the $m$-form is sharp rather than merely smaller. One recorded number is mislabelled.**

**The ordering.** $\sqrt{(m-1)/(3m)}\le\sqrt{(n-2)/(3n)}$ is equivalent to $(m-1)/m\le(n-2)/n$, that is $1-1/m\le1-2/n$, that is $2/n\le1/m$, that is $2m\le n$. **True at every $n\ge2$, with equality precisely when $2m=n$, which is precisely when $n$ is even.** That is the whole content of the ruling, and it is one line.

**The two instances.** At $n=9$, $m=4$ and the $m$-form is $\sqrt{3/12}=1/2$ while the $n$-form is $\sqrt{7/27}=0.5091751$, strictly larger. At $n=3$, $m=1$ and the $m$-form is $0$, which is the truth, because $\Lambda^4\mathbb R^3=0$ makes $\omega\wedge\omega$ vanish for every bivector and $\mathrm{Alt}(A)=0$ for every symmetric $A$. **One imprecision to record.** The block writes that "the $n$-form misses at $1/9$", but $(n-2)/(3n)=1/9$ is the radicand and the $n$-form's constant at $n=3$ is $\sqrt{1/9}=1/3$. The conclusion is untouched and the figure is mislabelled.

**Sharpness, which is the harder half.** At $A=u\otimes u$ with $u=m^{-1/2}\sum_{i\le m}\varphi_{2i-1,2i}$ we have $\mathop{\mathrm{tr}}A=\lVert u\rVert^2=1$ and $\mathrm{Alt}(A)=\tfrac16\,u\wedge u$, so by item 5 $\lVert\mathrm{Alt}(A)\rVert=\tfrac16\sqrt{12(m-1)/m}=\sqrt{(m-1)/(3m)}=\sqrt{(m-1)/(3m)}\mathop{\mathrm{tr}}A$. **Equality, exactly, at every $n\ge4$**, and trivially at $n=2,3$ where both sides vanish. So the constant cannot be lowered.

**Attainment holds at odd $n$ too**, because $u$ occupies only the first $2m=n-1$ coordinates and nothing in its construction needs an even dimension. That is what upgrades the ruling from "smaller" to "non-optimal": at odd $n$ the supremum of $\lVert\mathrm{Alt}(A)\rVert/\mathop{\mathrm{tr}}A$ over positive semidefinite $A$ equals $\sqrt{(m-1)/(3m)}$ and is achieved, so no constant below it is valid and $\sqrt{(n-2)/(3n)}$ is strictly above the sharp value. **The $n$-form is provably non-optimal at every odd $n\ge3$.**

**An independent confirmation of the block's diagnosis, which I offer as my own derivation.** The block says one bound is the other's shadow and argues it from the even-$n$ coincidence. The mechanism is stronger than that. Run item 4's Cauchy--Schwarz with the crude rank bound $\mathop{\mathrm{rank}}\omega^2\le n$ instead of $2m$: it gives $\mathop{\mathrm{tr}}(\omega^4)\ge4\lVert\omega\rVert^4/n$, hence $\lVert\omega\wedge\omega\rVert^2\le12\lVert\omega\rVert^4(n-2)/n$, hence the constant $\tfrac16\sqrt{12(n-2)/n}=\sqrt{(n-2)/(3n)}$. **The two rival constants are one Cauchy--Schwarz read at two rank bounds**, the $n$-form at $\mathop{\mathrm{rank}}\le n$ and the $m$-form at the true $\mathop{\mathrm{rank}}\le2\lfloor n/2\rfloor$. The ruling for the $m$-form is therefore not a preference between two arguments but the observation that one of them threw away the evenness of the rank of a skew matrix.

## 8. The $W_{\mathbb{CP}^2}$ attainment

**No finding. Every claim in the sentence checks, and the geometry behind it checks too.**

At $n=4$ let $s_1,s_2,s_3$ be an orthonormal basis of $\Lambda^2_+$ and $W=2s_1\otimes s_1-s_2\otimes s_2-s_3\otimes s_3$.

- **Trace-free.** $\mathop{\mathrm{tr}}W=2-1-1=0$.
- **Bianchi.** Each $s_a$ is a unit self-dual form, so $s_a\wedge s_a=\langle s_a,\star s_a\rangle E=E$, the same four-form for all three, which my screen confirms with all three coefficients exactly $+1$. Hence $\mathrm{Alt}(W)=\tfrac16(2E-E-E)=0$. **On $S^2\Lambda^2_+$ at $n=4$, Bianchi and trace-freeness are the same condition**, since $\mathrm{Alt}(s\otimes s')\propto\langle\star s,s'\rangle=\langle s,s'\rangle$ there. That is exactly the block's closing remark about the denial having read Bianchi as opposing balance, and it is correct.
- **Ricci-flat.** Under $S^2\Lambda^2=S^2\Lambda^2_+\oplus S^2\Lambda^2_-\oplus(\Lambda^2_+\otimes\Lambda^2_-)$ at $n=4$, the traceless Ricci part lives in the mixed summand and the scalar curvature in the traces, so a trace-free element of $S^2\Lambda^2_+$ is a pure $W^+$ with zero Ricci and zero scalar curvature. $W$ is such an element.
- **Genuinely $\mathbb{CP}^2$.** The Fubini--Study metric is self-dual Einstein with $W^-=0$ and $W^+$ eigenvalues proportional to $(2,-1,-1)$, which is this operator up to scale, and the equality below is scale-invariant because both sides are degree two in $W$.
- **The number.** $W^2=4\,s_1\otimes s_1+s_2\otimes s_2+s_3\otimes s_3$ is positive semidefinite with $\mathop{\mathrm{tr}}(W^2)=6$, and $\mathrm{Alt}(W^2)=\tfrac16(4+1+1)E=E$, so $\lVert\mathrm{Alt}(W^2)\rVert=\lVert E\rVert=\sqrt6$. My screen returns $\lVert\mathrm{Alt}(W^2)\rVert^2=6$ as an exact rational. Against the bound, $\sqrt{1/6}\cdot\mathop{\mathrm{tr}}(W^2)=6/\sqrt6=\sqrt6$. **Equality on the nose.**

So the bound is attained by an honest Weyl tensor and not only by an abstract positive operator, which is the fact the route depends on: a $\Lambda^4$-vanishing theorem has to defeat $\mathbb{CP}^2$, and the bound alone leaves it standing.

## 9. The rival bound and the crossover

**GAP, and the defect is a quantifier rather than a number.**

**The bound is right.** $\mathrm{Alt}$ is an orthogonal projection in the record's norm by item 1, so $\lVert\mathrm{Alt}(A)\rVert\le\lVert A\rVert$, and item 1 also establishes $\lVert A\rVert^2=\mathop{\mathrm{tr}}A^2$ exactly for a symmetric $A$. Hence $\lVert\mathrm{Alt}(A)\rVert\le\sqrt{\mathop{\mathrm{tr}}A^2}$, with no positivity needed.

**The threshold is right for the flat spectrum.** For a positive semidefinite $A$ of rank $r$ with all nonzero eigenvalues equal, $\mathop{\mathrm{tr}}A^2=(\mathop{\mathrm{tr}}A)^2/r$, so the rival gives $\mathop{\mathrm{tr}}A/\sqrt r$ and beats $\sqrt{(m-1)/(3m)}\mathop{\mathrm{tr}}A$ exactly when $1/r<(m-1)/(3m)$, that is when $r>3m/(m-1)$. Solved rather than accepted.

**The quantifier is wrong.** Rank $r$ alone only gives $\sqrt{\mathop{\mathrm{tr}}A^2}\in\big[\mathop{\mathrm{tr}}A/\sqrt r,\ \mathop{\mathrm{tr}}A\big]$, so at any $r$ a spiked spectrum makes the rival arbitrarily close to $\mathop{\mathrm{tr}}A$ and therefore worse. "Beats this one whenever the rank exceeds $3m/(m-1)$" reads as a claim about every rank-$r$ operator and is false in that reading. The correct universal statement runs the other way: **when $r\le3m/(m-1)$ the recorded bound is never worse**, since $\mathop{\mathrm{tr}}A^2\ge(\mathop{\mathrm{tr}}A)^2/r\ge(\mathop{\mathrm{tr}}A)^2(m-1)/(3m)$, and above the threshold each is better on some operators.

**One consequence the block would have liked.** At $n=4$, $3m/(m-1)=6=\dim\Lambda^2\mathbb R^4$, so no operator has rank exceeding the threshold and **the rival never beats the recorded bound at $n=4$**, which is the dimension where the $\mathbb{CP}^2$ attainment lives. The threshold falls to $4$ at $m=4$ and tends to $3$ as $m$ grows, so the rival matters only at larger $n$ and flat spectra.

## 10. Hypothesis inventory and reach

**No finding. Nothing unstated is used, nothing stated is idle, and the object is the right one.**

| Hypothesis | Where it is used |
|---|---|
| $A$ symmetric on $\Lambda^2\mathbb R^n$ | the spectral theorem supplying the orthonormal eigenbasis, and the pair symmetry $A_{ijkl}=A_{klij}$ that item 1 needs for $\tfrac13\mathfrak b$ to project onto $\Lambda^4$ |
| $A$ positive semidefinite | once, at $\sum_\alpha\lvert\mu_\alpha\rvert=\mathop{\mathrm{tr}}A$ in the triangle inequality, per item 2 |
| $\omega$ skew | the three cross-term sign flips in item 3, and $\omega^2\preceq0$ with even rank in item 4 |
| the four-index norm's $\tfrac14$ | the value of the constant, and the agreement $\lVert A\rVert^2=\mathop{\mathrm{tr}}A^2$ that item 9 and the $G_W$ remark consume |
| the record's wedge factor $2$ | the $\tfrac16$ and the $24$, which move together, per item 12 |
| $n\ge2$, equivalently $m\ge1$ | well-definedness of $(m-1)/(3m)$, since $m=0$ leaves it undefined. The Lean file carries this as `hn : 2 ≤ n` |

**Reach.** The statement quantifies over positive semidefinite operators on $\Lambda^2$, and the application at $A=W^2$ is legitimate: the square of a symmetric operator is positive semidefinite, and $\mathop{\mathrm{tr}}(W^2)=\lVert W\rVert^2$ is the norm agreement above, so the applied form $\lVert\mathrm{Alt}(W^2)\rVert\le\sqrt{(m-1)/(3m)}\lVert W\rVert^2$ is the stated form with no extra step. Throughout the block $W^2$ means the operator square, matching L199, not the componentwise tensor square. Bianchi and Ricci-flatness of $W$ appear only in the attainment example and are not hypotheses of the bound, which is right, because the bound holds for every positive semidefinite operator whether or not it is a curvature square.

## 11. The Lean statement

**GAP. The type is faithful and non-vacuous, and two surrounding claims overreach.**

**[alt_le_altConst_trace](../lean/HamiltonsCubic/Results/L204AltBound.lean) says the lemma, conditional on the eigen-expansion.** Its hypotheses are the right ones: `hskew` is skewness, `hunit` is $\tfrac12\mathop{\mathrm{tr}}(\omega_a^{\mathsf T}\omega_a)=1$ which is the record's unit norm, `horth` is the record's inner product vanishing off the diagonal, `hμ` is the positivity item 2 showed to be indispensable, and `hT` defines $T$ as $\tfrac16\sum_a\mu_a\,\mathrm{wedgeSelf}(\omega_a)$, which is item 1's expansion of $\mathrm{Alt}(A)$. The conclusion $\sqrt{\mathrm{tensorNormSq}\,T}\le\mathrm{altConst}(n/2)\sum_a\mu_a$ is the bound in the record's norm, `tensorNormSq` carrying the real $1/4$ and Lean's `n / 2` being $\lfloor n/2\rfloor$ on the nose.

- **Not wider than true.** The indexing by `Fin (n * (n - 1) / 2)`, exact at $n\ge2$ because $n(n-1)$ is even, forces $\{\omega_a\}$ to be a full orthonormal basis of $\Lambda^2\mathbb R^n$ rather than merely an orthonormal family, which is what the earlier `Fin n` version got wrong. The file's own doc-comment states that repair accurately.
- **Not vacuous.** The $\varphi_{ij}$ basis with any nonnegative $\mu$ satisfies every hypothesis, so the statement has instances, and I have proved it above.
- **What it leaves out.** The step $\mathrm{Alt}(A)=\tfrac16\sum\mu_\alpha\omega_\alpha\wedge\omega_\alpha$ is not in the file, being cited to the base layer, so the file never mentions $A$, $\mathrm{Alt}$ or $\mathop{\mathrm{tr}}A$. Also absent: the projection property of $\mathrm{Alt}$, the attainment and hence the sharpness, the $\mathbb{CP}^2$ witness, and the rival bound. Nothing in the file records that the constant cannot be lowered, which is the half of the ruling that makes it a ruling.
- **The three gap-free theorems are non-vacuous**, their hypotheses being satisfiable and their conclusions concrete: `altConst_le_altConstN` at $n\ge2$, `altConst_eq_altConstN_of_even`, and `altConst_lt_altConstN_n9` whose `altConst 4 < altConstN 9` is the right instance since `9 / 2 = 4`, resting on $1/4<7/27$.

**First overreach, in the Lean doc-comment.** Lines 19 to 21 and line 41 say the two constants "agree exactly when `n` is even". The file proves agreement at even $n$ and separation at $n=9$ only, so the converse half is established at a single odd dimension rather than at all of them. The general statement is easy, $2m<n$ strictly at every odd $n$ giving strictly ordered radicands, and it is simply absent. [findings/bounds.md](../findings/bounds.md) describes the file accurately, so the overclaim is confined to the Lean prose.

**Second overreach, on the reach of the second derivation.** The file says the new route is "reachable in this layer where the real normal form is not". That is right for the identity and incomplete for the rank step.

- The identity half is in better shape than the note claims: it is already proved gap-free at $n=4$ and $n=6$ in the layer, at [trace_pow_four_add_pf_sq](../lean/HamiltonsCubic/Results/PhiSphere.lean) and [phi_sphere6](../lean/HamiltonsCubic/Results/PhiSphere.lean), each closed by `ring` after the skew substitutions, and it is `ring`-closable at any fixed $n$ at rising cost.
- The Cauchy--Schwarz half needs $\mathop{\mathrm{rank}}(\omega^2)\le2\lfloor n/2\rfloor$. **At even $n$ that is free**, being $\mathop{\mathrm{rank}}\le n$. **At odd $n$ it requires that the rank of a real skew matrix is even**, and that is the one ingredient the note does not name. Searching the vendored Mathlib at [lean/.lake/packages/mathlib](../lean/.lake/packages/mathlib) for rank-evenness of an alternating form or a symplectic normal form returned nothing, so this looks like a genuine new obligation. It is weaker than the full real normal form, a vanishing Pfaffian or an odd-order skew determinant argument would do, and it is not nothing. The honest statement is that the second derivation discharges the even-$n$ case inside the layer and leaves one named lemma at odd $n$, which is exactly the half where the ruling bites.

## 12. What would break it

**The two load-bearing objects, and what I did to look for a failure.**

1. **The rank bound $\mathop{\mathrm{rank}}(\omega^2)\le2\lfloor n/2\rfloor$.** This is the single point where $m$ rather than $n$ enters the argument. Item 7 shows that replacing it by $\mathop{\mathrm{rank}}\le n$ reproduces $\sqrt{(n-2)/(3n)}$ exactly, so if the rank of a real skew matrix could be odd the ruling would invert at odd $n$ and r844's constant would be the sharp one. **This is the identity to attack.** I attacked it by the two independent countings of item 4, the direct pairing of the eigenvalues of $\omega^2$ and the blind Cauchy--Schwarz over $r\le2m$ terms, which agree, and by the exact screen at $n=5$ and $n=9$ where the balanced value repeats its even-dimensional neighbour's, which is the rank bound showing on the nose.
2. **The four-index norm's $\tfrac14$.** Dropping it multiplies every squared norm by $4$ and the constant by $2$. It is pinned twice over: it is what makes $\lVert A\rVert^2=\mathop{\mathrm{tr}}A^2$ for a symmetric operator, which item 1 verified exactly, and item 9 consumes that agreement.

**The wedge normalisation is NOT load-bearing, which is worth recording.** Had the record's wedge been the undoubled three-term sum, the identity would read $3\lVert\omega\rVert^4-\tfrac32\mathop{\mathrm{tr}}(\omega^4)$ and the maximum $\sqrt{3(m-1)/m}$, but $\mathrm{Alt}=\tfrac13\mathfrak b$ would then contribute $\tfrac13$ rather than $\tfrac16$ and the constant would come out $\tfrac13\sqrt{3(m-1)/m}=\sqrt{(m-1)/(3m)}$, unchanged. **The wedge's $2$ and the $\tfrac16$ cancel**, so the brief's dropped factor of $2$ would have broken the two intermediate figures, the identity's $12$ and $6$ and the canonical route's $24$, and left the lemma's constant standing. This is why my initial factor-of-four discrepancy against the block was a convention mismatch rather than a defect.

**What else I looked for.** An independent computation of the projection coefficient at $n=4$ from the Hodge star, bypassing the wedge entirely, which returned $\tfrac16$; the positivity witness, which is exact; the $\mathbb{CP}^2$ equality, which is exact; the identity on random rational skew matrices at $n=3$ to $7$, exact at every one; and a search for a cheaper crossover in item 9, which turned up the quantifier defect rather than a numerical one.

## Verdict

**L204: CONFIRMED.** The bound $\lVert\mathrm{Alt}(A)\rVert\le\sqrt{(m-1)/(3m)}\mathop{\mathrm{tr}}A$ at $m=\lfloor n/2\rfloor$ is true for every positive semidefinite $A$ on $\Lambda^2\mathbb R^n$ in the record's norm, every step of both derivations follows from the one above it and from the stated hypotheses, the constant is optimal because it is attained at the balanced rank-one operator at every $n\ge4$, and the $\mathbb{CP}^2$ attainment is exact. Two GAPs sit on the surrounding claims rather than on the lemma: the rival bound's crossover is stated with the wrong quantifier (item 9), and the Lean file's doc-comment plus the reach claim for the second derivation both overreach (item 11). Two figures are mislabelled without affecting a conclusion, the $n=3$ value $1/9$ which is a radicand rather than a constant (item 7), and the brief's own wedge formula which is half the record's (item 1). One provenance point is owed: the polynomial identity is the record's existing $\Phi$-sphere identity rescaled, already machine-checked at $n=4$ and $n=6$ (item 3).

**The ruling between the two constants: CORRECT.** $\sqrt{(m-1)/(3m)}\le\sqrt{(n-2)/(3n)}$ at every $n\ge2$ with equality exactly at even $n$, because the inequality is $2\lfloor n/2\rfloor\le n$ and nothing else. The $m$-form is sharp rather than merely smaller, being attained at odd $n$ as well as even, so the $n$-form is provably non-optimal at every odd $n\ge3$ rather than just larger. The mechanism is stronger than the block records: **both constants are one Cauchy--Schwarz read at two rank bounds**, r844's at $\mathop{\mathrm{rank}}(\omega^2)\le n$ and r845's at the true $\mathop{\mathrm{rank}}(\omega^2)\le2\lfloor n/2\rfloor$, so the ruling is not a choice between arguments but the observation that one of them discarded the evenness of the rank of a skew matrix. Ruling for r845, upheld.
