# r831: Gate 2 on the shifted census at the two-negative stratum's failing configuration

*Cold brief. I was handed the block verbatim and then read it on disk at [findings/stratum-two-negative.md](../findings/stratum-two-negative.md#L65), together with [findings/conventions.md](../findings/conventions.md), [findings/diagonality.md](../findings/diagonality.md), [Lemma L31](../findings/stratum-two-negative.md#L473), [Lemma L180](../findings/diagonal-half.md#L887), [Lemma L183](../findings/diagonal-half.md#L933), [ShiftedCensus.lean](../lean/HamiltonsCubic/Results/ShiftedCensus.lean), [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) and the three wedge-norm implementations in [scripts/](../scripts/). **The programme is on an analysis-only footing and I inherited the rule.** **No screen and no numerical run of any kind was performed.** Every derivation below is by hand and every arithmetic figure is a closed-form evaluation I did on paper. Log: [agent_logs/g2-census-r831.log](../agent_logs/g2-census-r831.log).*

| Claim | Verdict |
|---|---|
| **1a**: $\sigma_2^2/p_2\le k_2$ with ceiling $N-3$, and attaining it forces the non-top positives EQUAL | **CONFIRMED.** Both halves. $k_2\le N-3$ is forced by one top and two negatives, so $\sigma_2^2/p_2=N-3$ forces $k_2=N-3$ **and** Cauchy–Schwarz equality |
| **1b**: the block reads the chain's SUPREMUM as a point and attacks that point | **REFUTED as a strategy.** The extremiser is not isolated in the relaxed feasible set, so deleting it leaves the supremum at $1.226297$. Nothing short of an exclusion of a NEIGHBOURHOOD lowers the bound, and the block never says so |
| **2**: $\Pi_{\mathcal W}(\mathrm{Id}_{\Lambda^2})=0$, and $\mathrm{Id}$ satisfies first Bianchi | **CONFIRMED.** $\mathrm{Id}_{\Lambda^2}$ is $R^0_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ exactly, its Bianchi sum cancels in pairs, and its Weyl part is zero. $\mathrm{Ric}(\mathrm{Id})=(n-1)\mathrm{Id}_{\mathbb R^n}\ne0$, which is where the affine target comes from |
| **3**: $\sum_\alpha v_\alpha v_\alpha^{\mathsf T}=(n-1)\mathrm{Id}_{\mathbb R^n}$ over an ARBITRARY orthonormal basis | **CONFIRMED as a statement, REFUTED as justified.** The justification *"by $O(n)$-invariance"* names the wrong group: an arbitrary orthonormal basis of $\Lambda^2$ is not $O(n)$-related to the coordinate one. The right one-line argument is $O(N)$-invariance of a $W$-valued quadratic trace, given in §3, and the derivation does need the general form |
| **4**: $\sum_Fc_\alpha=-N\mu$, and $(n-1)/N=2/n$ so $B=(-\tfrac2n\mathrm{Id},0)$ | **CONFIRMED.** Arithmetic exact. $\mu\ne0$ and $n\notin\{0,1\}$ are carried as hypotheses in [ShiftedCensus.lean](../lean/HamiltonsCubic/Results/ShiftedCensus.lean) and are absent from the prose, which is the only exposure |
| **5**: $\mathop{\mathrm{tr}}(\omega^2)=-2$ at unit $\omega$ and $\mathop{\mathrm{tr}}(-\tfrac2n\mathrm{Id})=-2$ | **CONFIRMED**, and the block's conclusion that the trace is uninformative follows. It is also the reason r824's constraint count is $35$ and not $36$ |
| **6**: $B\notin\Phi(\Lambda^2\mathbb R^n)$ at every $n>2$ | **CONFIRMED**, both implications and the boundary. At $n=2$, $B=\Phi(\varphi_{12})$, and $\Lambda^4\mathbb R^2=0$ is what lets it happen |
| **7**: $c_\alpha>0$ at the top, $<0$ at the rest, and dividing by $-N\mu<0$ flips all four | **CONFIRMED as sign algebra.** $\mu>0$ holds by definition, not by luck. The COUNT is wrong downstream of §11: after the correction there are two positive weights and one negative, not three and one |
| **8**: the isotropy display, and the no-common-kernel corollary | **CONFIRMED.** The pairing step, the constant $2/n$ and the corollary are all correct. The gloss *"the spherical average ... being $\mathop{\mathrm{tr}}(vv^{\mathsf T})/n$"* is the average over $x$ at fixed $v$ and the statement is the average over $v$ at fixed $x$. Both are $2/n$, so the constant is right and the reason given is a different one |
| **9a**: $\mathop{\mathrm{tr}}(\omega^4)+\lVert\omega\wedge\omega\rVert^2=2\langle\omega,\omega\rangle^2$ at every skew $\omega$, every $n$ | **CONFIRMED, AND THE "OWED" IS DISCHARGED.** Four lines from the skew normal form, §9. The block understates its own Lean file, which proves $\dim 4$ and $\dim 6$ |
| **9b**: which inner product on $\Lambda^4$ makes the constant right, and whether the record's numerics use it | **REFUTED, AND THE OWED QUESTION IS ANSWERED NO.** The identity needs $\lVert\sum_{i<j<k<l}c_Ie_I\rVert^2=\sum c_I^2$. [conventions.md](../findings/conventions.md#L124) tables a $\Lambda^4$ norm SIX times larger, under which the block's headline *"$\Phi$ sends the unit sphere into a sphere"* is FALSE and $\lVert\Phi\rVert^2$ ranges over $[2,10\tfrac13]$ at $n=12$. And all three of the record's wedge routines compute HALF the identity's norm |
| **10**: $\min\lVert\omega\wedge\omega\rVert^2=2-\max\mathop{\mathrm{tr}}(\omega^4)$, and $\lVert\omega\wedge\omega\rVert=0$ iff decomposable | **CONFIRMED in the identity's norm, and MISAPPLIED in [diagonality.md](../findings/diagonality.md).** That file's *"$0.5$ at padded $W_{\mathbb{CP}^2}$ needs $\sum\sigma_i^4=0.875$"* is wrong by the factor: the recorded $0.5$ is half a norm, so $\sum\sigma_i^4=0.5$. The range check that file offers as reassurance passes under both readings and therefore discriminates nothing |
| **11**: the fourth exceptional eigenvector is a zero, so the census is on four points | **REFUTED, AND THE ZERO IS EXCLUDED BY THE VERY CEILING THE BLOCK INVOKES.** $\sigma_2^2/p_2=63$ at $n=12$ forces $63$ equal positives, and $1+63+2=66=N$ leaves no room for a zero. The block's own spectrum returns $\sigma_2^2/p_2=62$. **The census is on THREE points, $F$ has no kernel vector, and $\mu=\sigma_2/63$** |
| **12**: closing this needs a rank-four census, harder than the rank-three one | **REFUTED, three ways.** The point count is three, not four, so no new apparatus is asked for. The shift STRENGTHENS the $S^2$ half rather than weakening it, turning [L180](../findings/diagonal-half.md#L887)'s support COLLAPSE into a support EXPANSION. And one of the four points is a fixed known point, which is a specialisation of a four-point census and not an instance of one |
| **13**: r824's count applies once the branch is the principal stratum | **PLAUSIBLE, WITH A NAMED MISSING HYPOTHESIS.** The arithmetic checks ($40-15=25$ against $20+15=35$). What is needed and unstated is TRANSVERSALITY of the descended section to the zero section, and *"the branch IS the principal stratum"* should read *"the branch meets only the free locus"* |
| **14**: what would falsify the block | **A FALSIFIER WAS FOUND AND IT FIRES**, at the block's own line *"the inequalities all pass"*. See the added finding |
| **ADDED**: **the failing configuration cannot make the chain tight, by two lemmas already on record** | **NEW.** [L31](../findings/stratum-two-negative.md#L473) plus [L180](../findings/diagonal-half.md#L887) force every eigenvector of a pair-cap-tight $W$ into $\Lambda^2V_0$ for a single $4$-plane $V_0$, so such a $W$ has at most SIX nonzero eigenvalues and at most FOUR positive ones. The failing configuration needs $64$. **So the recorded supremum $1.226297$ is attained by no Weyl tensor**, and the block's feasibility claim is false |

**One line.** *Nine of the block's fourteen technical steps are correct and two of them are better than the block says, but the spectrum at its head is internally inconsistent with the ceiling it derives from, the correction turns the four-point census into a three-point one and the "programme, not a step" cost claim with it, and the block's closing feasibility claim is refuted outright by two lemmas the record already holds, which show the configuration cannot make the chain tight at all.*

## 0. Conventions, all quoted rather than restated

**The inner product on $\Lambda^2$** is $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ on skew matrices, the $\tfrac12$ sitting at the $\Lambda^2$ level ([conventions.md](../findings/conventions.md#L85)). So a unit bivector has $\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=2$ and $\lVert Z\rVert_F^2=2\lVert Z\rVert^2$.

**$N=\dim\Lambda^2\mathbb R^n=n(n-1)/2$**, so $N=66$ at $n=12$.

**$\Phi(\omega)=(\omega^2,\ \omega\wedge\omega)$** is [L183](../findings/diagonal-half.md#L933)'s map. *This is a FIFTH object under the letter $\Phi$ and [conventions.md](../findings/conventions.md#L51) tables four, warning in bold that the letter is overloaded and to say which is meant.* The block does not, and the omission is recorded in §9.

**The $S^2$ factor carries plain Frobenius**, which is what makes $\lVert B\rVert^2=n\cdot(2/n)^2=4/n$ and $\lVert\omega^2\rVert^2=\mathop{\mathrm{tr}}(\omega^4)$.

**The $\Lambda^4$ factor carries the ORTHONORMAL-BASIS norm** $\lVert\sum_{i<j<k<l}c_{ijkl}\,e_i\wedge e_j\wedge e_k\wedge e_l\rVert^2=\sum_{i<j<k<l}c_{ijkl}^2$. **This is the block's convention by necessity and it is stated nowhere**, in the block, in [conventions.md](../findings/conventions.md) or in [diagonality.md](../findings/diagonality.md). §9 is where that bill comes due.

**Ricci-flatness, first Bianchi, trace-freeness** are as the brief gives them and as [L180](../findings/diagonal-half.md#L887) states them: $\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=0$, $\sum_\alpha\lambda_\alpha\,v_\alpha\wedge v_\alpha=0$, $\sum_\alpha\lambda_\alpha=0$, with $v^2=-vv^{\mathsf T}$ at skew $v$.

**$\sigma_2=\sum_{\alpha\ne1,\lambda_\alpha>0}\lambda_\alpha$ and $p_2=\sum_{\alpha\ne1,\lambda_\alpha>0}\lambda_\alpha^2$**, both over the STRICTLY POSITIVE non-top eigenvalues. A zero eigenvalue contributes to neither. That is the whole of §11.

## 0.1 Hypothesis inventory

What the block's argument consumes, in the order it consumes it.

1. **$W$ lies in the two-negative stratum with $k\ge3$ positive eigenvalues.** Used to have a $\sigma_2$ at all.
2. **The chain of estimates attains its supremum at the recorded spectrum.** Used to say *"the configuration"* rather than *"a configuration"*. Attainment in the RELAXED variables is what the block has, and attainment by a Weyl tensor is what it needs. §1b and the added finding.
3. **$\sigma_2^2/p_2=N-3$ exactly.** Used for Cauchy–Schwarz equality. §1a.
4. **A zero eigenvalue is present.** Used for $\lvert F\rvert=4$. **Unsupported, and refuted by hypothesis 3.** §11.
5. **$\mu\ne0$.** Used to divide by the weight sum. Present in the Lean file, absent from the prose. §4.
6. **$\mu>0$.** Used for the sign flip. Holds by definition once $k_2\ge1$. §7.
7. **The orthonormal-basis norm on $\Lambda^4$.** Used for the sphere radius. Undeclared, and in conflict with [conventions.md](../findings/conventions.md#L124). §9.
8. **NOT used anywhere, and this is the block's largest omission: the chain's own equality conditions.** The chain reaches $1.226297$ only with $\lVert[v_{N-1},v_N]\rVert^2=2$, which the file states two paragraphs above the block at [line 61](../findings/stratum-two-negative.md#L61). The census discards it and then asks a strictly weaker question. §15.

## 1. The equality step, and the point that is not a point

### 1a. Both halves of the Cauchy–Schwarz reading are correct

Let $\lambda_1$ be the top eigenvalue, let $-a,-b$ be the two negatives and let $k_2$ count the strictly positive eigenvalues other than $\lambda_1$. Cauchy–Schwarz against the all-ones vector on those $k_2$ entries gives $\sigma_2^2\le k_2\,p_2$, with equality exactly when all $k_2$ of them are equal. Separately, the $N$ eigenvalues consist of $\lambda_1$, the two negatives, and $N-3$ others, so $k_2\le N-3$ always. Hence

$$\frac{\sigma_2^2}{p_2}\ \le\ k_2\ \le\ N-3 ,$$

and $N-3$ is the right ceiling. Attaining it forces **both** $k_2=N-3$ and Cauchy–Schwarz equality, because the first inequality's right-hand side is itself capped: there is no reading under which $k_2\ge N-3$ suffices, since $k_2>N-3$ is impossible. **The block is right on this and the brief's suspicion that it might only give $k_2\ge N-3$ is unfounded.** So the non-top positives are all equal to one value $\mu$, and

$$W=\mu\,\mathrm{Id}_{\Lambda^2}+\sum_{\alpha\in F}(\lambda_\alpha-\mu)\,v_\alpha\otimes v_\alpha$$

is a correct rewriting, with $F$ the eigenvectors whose eigenvalue is not $\mu$. **What $F$ contains is §11 and it is not what the block says.**

### 1b. Deleting one point of a relaxed feasible set does not lower its supremum

The chain's $1.226297$ is a supremum over a set described by SUMMARY STATISTICS, namely $(\lambda_1,\sigma_2,p_2,a,b)$ subject to trace-freeness $\lambda_1+\sigma_2=a+b$, unit norm $\lambda_1^2+p_2+a^2+b^2=1$ and $\sigma_2^2\le(N-3)p_2$. I reconstructed the extremiser from the brief's own two figures and it closes: *"$\lambda_1=0.744939$ against a cap of $0.745356$"* is $\lambda_1$ against $\sqrt p$ with $p=\lambda_1^2+p_2$, and $\sqrt{5/9}=0.7453560$, so $p=5/9$ exactly. Then $p_2=5/9-0.744939^2=6.19\times10^{-4}$, $\sigma_2=\sqrt{63p_2}=0.19749$, and $a=b=(\lambda_1+\sigma_2)/2=0.471215$ with $2a^2=0.44409$ against $1-p=0.44444$. *That is the recorded configuration to every digit the record prints, and it confirms $a\approx b\approx0.4712$ rather than the $0.46$ the brief and the block both carry.*

Now the point. **The extremiser is not isolated in the feasible set.** Fix $\lambda_1$ and $p_2$ and make the $63$ positives unequal while holding $p_2$: $\sigma_2$ strictly decreases, so $a+b=\lambda_1+\sigma_2$ decreases while $a^2+b^2=1-p$ is unchanged, which is satisfiable by moving $a$ and $b$ apart from their common value. Every point of that one-parameter family is feasible, none of them has equal positives, and the chain's value is continuous in the summary statistics. Since the value at the extremiser exceeds $\sqrt{3/2}$ by $0.13\%$, **an entire relative neighbourhood of the extremiser also exceeds $\sqrt{3/2}$, and no point of it except the extremiser has the block's structure.**

**So the census, even if it returned a clean "no such Weyl tensor exists", would leave the recorded bound exactly where it is.** The block's *"THAT IS WHAT MAKES IT ATTACKABLE"* is a claim about a point, and the quantity under attack is a supremum. To move the bound the census would have to be run in a form robust to perturbation, for instance *"every Weyl tensor of the stratum has $\sigma_2^2/p_2\le N-3-\delta$"* for an explicit $\delta$. **Nothing in the block is of that shape, and nothing in the block says it needs to be.** *The most charitable reading, which I do adopt, is that the block intends the equality case as a place to look for a mechanism rather than as a sufficient target, and it is fair to say that a mechanism found at the extremiser might well perturb. But the block does not say that, and its stated conclusion is that a rank-four census would CLOSE it.*

*Determining $\delta$, or the rate at which the chain's value falls away from the extremiser, is a computation. Under the standing rule I name it and stop.*

## 2. $\mathrm{Id}_{\Lambda^2}$ is the constant-curvature tensor and its Weyl part vanishes

**Which normalisation.** Take $R^0_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$, the curvature tensor of the unit round sphere. As an operator on $\Lambda^2$ it sends $e_i\wedge e_j\mapsto\sum_{k<l}R^0_{ijkl}\,e_k\wedge e_l=e_i\wedge e_j$, so **$R^0=\mathrm{Id}_{\Lambda^2}$ on the nose**, with no factor to argue about. The identification is normalisation-free in the sense that matters here: it is an identity of operators, so the $\tfrac12$ at the $\Lambda^2$ level cancels on both sides.

**First Bianchi.** $R^0_{ijkl}+R^0_{iklj}+R^0_{iljk}=(\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk})+(\delta_{il}\delta_{kj}-\delta_{ij}\delta_{kl})+(\delta_{ij}\delta_{lk}-\delta_{ik}\delta_{lj})=0$, the six terms cancelling in three pairs. **CONFIRMED.**

*A second and basis-free route, which is the same computation as §3 and worth having because it is the one the block's Bianchi sentence actually needs.* Over any orthonormal basis $(v_\alpha)$ of $\Lambda^2$, $\mathrm{Id}_{\Lambda^2}=\sum_\alpha v_\alpha\otimes v_\alpha$, so its Bianchi expression is $\sum_\alpha v_\alpha\wedge v_\alpha$. That sum is independent of the orthonormal basis by §3's argument, and at the coordinate basis every term $\varphi_{ij}\wedge\varphi_{ij}=(e_i\wedge e_j)\wedge(e_i\wedge e_j)$ vanishes. **So $\mathrm{Id}$ satisfies first Bianchi, at every $n$.**

**The Weyl part.** The $O(n)$-decomposition of curvature tensors is $\mathbb R\,R^0\oplus(\mathrm{Ric}_0\text{ part})\oplus\mathcal W_n$, and $R^0$ spans the first summand, so $\Pi_{\mathcal W}(R^0)=0$. **CONFIRMED.**

**And $\mathrm{Ric}(\mathrm{Id})\ne0$, which is the whole reason the census target is affine.** By §3, $\sum_\alpha v_\alpha v_\alpha^{\mathsf T}=(n-1)\mathrm{Id}_{\mathbb R^n}$, so the Ricci contraction of $\mu\,\mathrm{Id}_{\Lambda^2}$ is $\mu(n-1)\mathrm{Id}_{\mathbb R^n}$. **No sign or factor error is present**, and the target moves off zero in $S^2$ while staying at zero in $\Lambda^4$ exactly as the block says.

## 3. The basis sum, true at every orthonormal basis, for a reason the block misnames

**Statement.** For any orthonormal basis $(v_\alpha)_{\alpha=1}^N$ of $\Lambda^2\mathbb R^n$ under $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$,

$$\sum_{\alpha=1}^{N}v_\alpha v_\alpha^{\mathsf T}=(n-1)\,\mathrm{Id}_{\mathbb R^n}.$$

**Proof.** Let $B(X,Y)=\tfrac12(XY^{\mathsf T}+YX^{\mathsf T})$, a symmetric bilinear map $\Lambda^2\times\Lambda^2\to S^2(\mathbb R^n)$ with $B(v,v)=vv^{\mathsf T}$. If $v'_\beta=\sum_\alpha O_{\beta\alpha}v_\alpha$ with $O$ orthogonal, then

$$\sum_\beta v'_\beta v'^{\mathsf T}_\beta=\sum_\beta\sum_{\alpha,\gamma}O_{\beta\alpha}O_{\beta\gamma}\,B(v_\alpha,v_\gamma)=\sum_{\alpha,\gamma}\delta_{\alpha\gamma}B(v_\alpha,v_\gamma)=\sum_\alpha v_\alpha v_\alpha^{\mathsf T},$$

so the sum is the same at every orthonormal basis. Evaluate it at $\varphi_{ij}=E_{ij}-E_{ji}$ for $i<j$, which is orthonormal since $\tfrac12\mathop{\mathrm{tr}}(\varphi_{ij}^{\mathsf T}\varphi_{ij})=1$. Then $\varphi_{ij}\varphi_{ij}^{\mathsf T}=E_{ii}+E_{jj}$, and each index $i$ occurs in exactly $n-1$ pairs, so the sum is $(n-1)\mathrm{Id}$. $\square$

**Trace check.** $\mathop{\mathrm{tr}}\sum_\alpha v_\alpha v_\alpha^{\mathsf T}=\sum_\alpha 2\langle v_\alpha,v_\alpha\rangle=2N=n(n-1)$, and $\mathop{\mathrm{tr}}\big((n-1)\mathrm{Id}_{\mathbb R^n}\big)=n(n-1)$. **The constant is $n-1$, CONFIRMED, and I derived it independently of the record.**

**The justification in the block is the wrong group.** The block writes *"by $O(n)$-invariance and the trace count"*. $O(n)$ acts on $\Lambda^2$ through $\Lambda^2\rho$, and its orbit on orthonormal bases of $\Lambda^2$ is a tiny subset of all of them: a generic orthonormal basis of $\Lambda^2\mathbb R^{12}$ is not $\Lambda^2$ of anything. What is true is that $\Lambda^2\rho(O(n))\subseteq O(N)$, and the invariance actually used is under **all** of $O(N)$, which is the display above. *A reader who takes the block's reason at face value gets the coordinate basis and no more, which is exactly what [BalanceAll.lean](../lean/HamiltonsCubic/Results/BalanceAll.lean) and its neighbours prove.* **The derivation does need the general form**: $W$'s eigenbasis is an arbitrary orthonormal basis of $\Lambda^2$ and is essentially never of the form $\varphi_{ij}$, which is the trap [conventions.md](../findings/conventions.md#L69) records under "diagonal". **REFUTED as justified, CONFIRMED as stated, and the repair is one display.**

## 4. The weight sum and the barycentre

**The weight sum.** Take the trace on $\Lambda^2$ of $W=\mu\,\mathrm{Id}_{\Lambda^2}+\sum_{\alpha\in F}c_\alpha\,v_\alpha\otimes v_\alpha$ with $c_\alpha=\lambda_\alpha-\mu$. The left side is $\sum_\alpha\lambda_\alpha=0$ and the right side is $N\mu+\sum_Fc_\alpha$, so $\sum_Fc_\alpha=-N\mu$. **CONFIRMED**, and it holds for any $\lvert F\rvert$, which is why §11's correction does not disturb it.

**The two conditions.** Ricci-flatness is $\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=0$. Writing $\lambda_\alpha=\mu+c_\alpha$ with $c_\alpha=0$ off $F$ and using §3, this is $\mu(n-1)\mathrm{Id}+\sum_Fc_\alpha v_\alpha v_\alpha^{\mathsf T}=0$, that is $\sum_F(\mu-\lambda_\alpha)v_\alpha v_\alpha^{\mathsf T}=\mu(n-1)\mathrm{Id}$, which is the block's display. In $\Phi$'s first slot, $\Phi_1(v)=v^2=-vv^{\mathsf T}$, so the same equation reads $\sum_Fc_\alpha\Phi_1(v_\alpha)=+\mu(n-1)\mathrm{Id}$. First Bianchi is $\sum_\alpha\lambda_\alpha v_\alpha\wedge v_\alpha=0$, and the $\mu\,\mathrm{Id}$ part of it vanishes by §2, leaving $\sum_Fc_\alpha\,v_\alpha\wedge v_\alpha=0$. **So $\sum_Fc_\alpha\Phi(v_\alpha)=(\mu(n-1)\mathrm{Id},0)$ exactly as written, signs included.**

**The barycentre.** Dividing by $\sum_Fc_\alpha=-N\mu$,

$$\frac{\mu(n-1)}{-N\mu}=-\frac{n-1}{N}=-\frac{n-1}{n(n-1)/2}=-\frac2n ,$$

so $B=(-\tfrac2n\mathrm{Id},0)$ with the weights summing to $1$. **The cancellation is exact, $\mu$ goes because it appears once in each of numerator and denominator, and the multiplicity goes because it never entered: $N$ is the dimension of $\Lambda^2$ and not the multiplicity of $\mu$.** **CONFIRMED.**

**The exclusions.** The step needs $\mu\ne0$ and $n-1\ne0$ and $n\ne0$. [ShiftedCensus.lean](../lean/HamiltonsCubic/Results/ShiftedCensus.lean) carries all three as hypotheses (`hn`, `hn1`, `hmu`) and its `field_simp` step consumes them. **The prose carries none of them.** At $\mu=0$ the weight sum vanishes and there is no affine normalisation at all, the condition collapsing to [L183](../findings/diagonal-half.md#L933)'s homogeneous form, which is a genuinely different statement and not a limiting case of this one. *At the configuration $\mu>0$ strictly, so nothing is lost, but a block that says "both $\mu$ and the multiplicity cancel out of it" should say which values of $\mu$ it is entitled to cancel.* **CONFIRMED with a missing hypothesis in the prose only.**

## 5. The trace is uninformative, and it is uninformative twice over

At a unit bivector, $\mathop{\mathrm{tr}}(\omega^2)=-\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=-2\langle\omega,\omega\rangle=-2$. And $\mathop{\mathrm{tr}}(-\tfrac2n\mathrm{Id}_{\mathbb R^n})=-2$. Every affine combination of trace-$(-2)$ matrices has trace $-2$, so the first component's trace is an identity in the derivation and carries no information about the configuration. **CONFIRMED**, and the block's reading of it as a check on the normalisation is right.

**Two remarks the block could have drawn and does not.** First, this is the same fact as [L180](../findings/diagonal-half.md#L887)(2), *"tracelessness is its trace"*, so the block's observation is a lemma on record rather than a new one. Second, it is the reason r824's constraint count in §13 is $35$: the $S^2$ target is $S^2_0(\mathbb R^6)$ of dimension $20$ and not $S^2(\mathbb R^6)$ of dimension $21$, because the trace equation is automatic. *That connection is worth recording because the two blocks make the same observation in two files and neither cites the other.*

## 6. $B$ is not a point of the surface

**Both implications.** Suppose $\Phi(\omega)=B$ for a skew $\omega$.

*From the first component.* $\omega^2=-\tfrac2n\mathrm{Id}$ means $\omega\omega^{\mathsf T}=\tfrac2n\mathrm{Id}$, so $J:=\sqrt{n/2}\,\omega$ satisfies $JJ^{\mathsf T}=\mathrm{Id}$ and $J^{\mathsf T}=-J$, hence $J^2=-\mathrm{Id}$: **$\omega$ is $\sqrt{2/n}$ times an orthogonal complex structure, and $\mathop{\mathrm{rank}}\omega=n$.** *This also forces $n$ even, since a real skew matrix has even rank, so at odd $n$ the first component alone already excludes $B$.*

*From the second component.* $\omega\wedge\omega=0$ is the Plücker condition, equivalent to $\omega$ being decomposable, $\omega=u\wedge v$, hence $\mathop{\mathrm{rank}}\omega=2$ (or $0$).

*Together.* $n=\mathop{\mathrm{rank}}\omega=2$. **So $B\in\Phi(\Lambda^2\mathbb R^n)$ only at $n=2$**, where it does hold: $\varphi_{12}$ is a unit bivector with $\varphi_{12}^2=-\mathrm{Id}_{\mathbb R^2}=-\tfrac22\mathrm{Id}$, and $\Lambda^4\mathbb R^2=0$ makes the wedge condition vacuous rather than satisfied. **CONFIRMED at both the general claim and the boundary.**

**And the consequence the block draws is right.** If all points of $F$ coincided at some $\Phi(v)$, then the affine combination would equal $\Phi(v)$, so $B$ would be on the surface. **So the coincident branch, which [L183](../findings/diagonal-half.md#L933) has to carry separately and which took [L184](../findings/diagonal-half.md) to close at $\dim V=6$, is free here.** *That is the block's cleanest genuine gain over the homogeneous census, and it survives §11's correction untouched, since the argument does not depend on how many points there are.*

## 7. The sign pattern

At the configuration, $\mu>0$ is not an assumption and not luck: $\mu$ is the common value of the strictly positive non-top eigenvalues, so $\mu>0$ whenever $k_2\ge1$, which $k\ge3$ supplies. Hence $-N\mu<0$.

The signs of $c_\alpha=\lambda_\alpha-\mu$ over $F$: at the top eigenvector $c_1=\lambda_1-\mu>0$ since $\lambda_1$ is the largest; at each negative $c=-a-\mu<0$; at a zero, were one present, $c=-\mu<0$. Dividing by $-N\mu<0$ flips every sign, so $w_1<0$ and the rest are positive. **CONFIRMED as sign algebra.**

**The geometric reading is also right.** With $\sum_\alpha w_\alpha=1$ and $w_1<0$, the point $B$ lies strictly on the far side of the face opposite $\Phi(v_1)$ from $\Phi(v_1)$ itself, which is what *"beyond the face opposite $\Phi(v_1)$"* means. **The count is what §11 corrects**: with $\lvert F\rvert=3$ the simplex is a triangle, and $B$ lies beyond the EDGE opposite $\Phi(v_1)$, with two positive weights and one negative. *The block's "three positive weights and one negative" is a statement about a tetrahedron it does not have.*

## 8. The isotropy condition

**The pairing step.** At skew $v$, $x^{\mathsf T}v^2x=-x^{\mathsf T}v^{\mathsf T}vx=-\lvert vx\rvert^2$. Pairing $\sum_Fw_\alpha v_\alpha^2=-\tfrac2n\mathrm{Id}$ against $x$ on both sides gives $-\sum_Fw_\alpha\lvert v_\alpha x\rvert^2=-\tfrac2n\lvert x\rvert^2$, that is

$$\sum_{\alpha\in F}w_\alpha\lvert v_\alpha x\rvert^2=\tfrac2n\lvert x\rvert^2\qquad\text{for every }x .$$

**CONFIRMED**, and [census_isotropy](../lean/HamiltonsCubic/Results/ShiftedCensus.lean) types the same step over an arbitrary index set, so it is not restricted to four points either.

**The constant $2/n$, twice.** Average $\lvert vx\rvert^2$ over the unit sphere of $\Lambda^2$ at fixed $x$: the average of a quadratic form is $1/N$ times its trace against the metric, which is $\tfrac1N\sum_\alpha\lvert v_\alpha x\rvert^2=\tfrac1N\,x^{\mathsf T}\big(\sum_\alpha v_\alpha v_\alpha^{\mathsf T}\big)x=\tfrac{n-1}{N}\lvert x\rvert^2=\tfrac2n\lvert x\rvert^2$ by §3. **So the block's claim is exactly right**, and the display says that the weighted combination of the four (three) forms equals the spherical average of the family, uniformly in $x$.

*The gloss is a different average.* The block justifies $2/n$ as *"$\mathop{\mathrm{tr}}(vv^{\mathsf T})/n$"*, which is the average of $\lvert vx\rvert^2$ over unit $x$ at FIXED unit $v$. That is also $2/n$, and the coincidence is real rather than accidental, both being $\tfrac1{nN}\sum_\alpha\mathop{\mathrm{tr}}(v_\alpha v_\alpha^{\mathsf T})$ read along the two factors. **But the average the statement is about is the one over $v$**, and the gloss names the other. *The constant is right and the reason given is a different reason, which is a repair and not a refutation.*

**The corollary.** Suppose $x$ lies in the kernel of every positive-weight form. The display collapses to $w_1\lvert v_1x\rvert^2=\tfrac2n\lvert x\rvert^2$ with $w_1<0$, so the left side is at most zero and the right side is nonnegative and vanishes only at $x=0$. **CONFIRMED**, and the block's sign bookkeeping matches. **The negative weight is indeed what makes it run**, and in the homogeneous [L183](../findings/diagonal-half.md#L933) form the same argument gives nothing, since a zero target is compatible with a common kernel.

**And the corollary is strictly weaker than what [L180](../findings/diagonal-half.md#L887) already gives**, which §15 uses.

## 9. The identity, its inner product, and the normalisation that does not match

### 9a. The identity holds at every $n$, and the proof is four lines

**Claim.** For every skew $\omega\in\mathfrak{so}(n)$, with $\langle\omega,\omega\rangle=\tfrac12\mathop{\mathrm{tr}}(\omega^{\mathsf T}\omega)$ and the orthonormal-basis norm on $\Lambda^4$,

$$\mathop{\mathrm{tr}}(\omega^4)+\lVert\omega\wedge\omega\rVert^2=2\,\langle\omega,\omega\rangle^2 .$$

**Proof.** Both sides are $O(n)$-invariant polynomials of degree four (the left side's second term because the induced action of $O(n)$ on $\Lambda^4$ is orthogonal for the orthonormal-basis norm), so it suffices to check the normal form. Choose $O$ with $O\omega O^{\mathsf T}=\bigoplus_{k=1}^{m}a_kJ$, $J=\begin{psmallmatrix}0&1\\-1&0\end{psmallmatrix}$ and $m=\lfloor n/2\rfloor$, padding with a zero row and column at odd $n$. Then:

* $\langle\omega,\omega\rangle=\tfrac12\sum_k2a_k^2=\sum_ka_k^2$,
* $\omega^2=\bigoplus_k(-a_k^2)I_2$, so $\mathop{\mathrm{tr}}(\omega^4)=\sum_k2a_k^4$,
* $\omega=\sum_ka_k\,e_{2k-1}\wedge e_{2k}$, so $\omega\wedge\omega=2\sum_{k<l}a_ka_l\,e_{2k-1}\wedge e_{2k}\wedge e_{2l-1}\wedge e_{2l}$, a sum over DISTINCT basis $4$-vectors, giving $\lVert\omega\wedge\omega\rVert^2=4\sum_{k<l}a_k^2a_l^2$.

And $4\sum_{k<l}a_k^2a_l^2=2\big(\sum_ka_k^2\big)^2-2\sum_ka_k^4$, so the two terms sum to $2(\sum_ka_k^2)^2=2\langle\omega,\omega\rangle^2$. $\square$

**So the "general-dimension form is owed" note in the block and in [diagonality.md](../findings/diagonality.md) is discharged**, and the block also understates its own file: [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) proves it at $\dim 4$ AND at $\dim 6$ (theorem `phi_sphere6`, over all fifteen index sets), while the block's parenthetical says $\dim=4$ only. *The record's convention that the singular values $\sigma_i$ satisfy $\sum\sigma_i^2=1$ at a unit bivector identifies them with my $a_k$, each of which is a singular value of multiplicity two, and the identification is consistent throughout.*

**And the sphere follows.** At $\langle\omega,\omega\rangle=1$, $\lVert\Phi(\omega)\rVert^2=\lVert\omega^2\rVert_F^2+\lVert\omega\wedge\omega\rVert^2=\mathop{\mathrm{tr}}(\omega^4)+\lVert\omega\wedge\omega\rVert^2=2$, using that $\omega^2$ is symmetric so its Frobenius norm squared is $\mathop{\mathrm{tr}}(\omega^4)$. **The radius $\sqrt2$ is CONFIRMED**, as is $\lVert B\rVert^2=4/n<2$ at every $n>2$.

### 9b. Which inner product, and the answer the record does not like

**The identity holds for exactly one scaling of the $\Lambda^4$ factor**, the one under which $\{e_i\wedge e_j\wedge e_k\wedge e_l\}_{i<j<k<l}$ is orthonormal, equivalently $\lVert\eta\rVert^2=\tfrac1{4!}\sum_{ijkl}\eta_{ijkl}^2$. Rescaling $\Lambda^4$ by $t$ turns the identity into $\mathop{\mathrm{tr}}(\omega^4)+t^{-2}\lVert\omega\wedge\omega\rVert^2_t=2\langle\omega,\omega\rangle^2$, and only $t=1$ makes the constant $1$.

**Three scalings of that factor are live in this record and the block declares none.**

1. **The identity's**, above. Never tabled.
2. **[conventions.md](../findings/conventions.md#L124)'s**, $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$, pinned there by $\lVert\star\rVert^2=6$ and by $\delta^2(W_{\mathbb{CP}^2})=\tfrac19$. For a $4$-form this is $\tfrac14\cdot24\sum_{i<j<k<l}=\mathbf6$ times the identity's squared norm. *That norm is introduced for $\Lambda^4$ sitting inside $S^2(\Lambda^2)$ through $\mathrm{Alt}$ rather than for $\omega\wedge\omega$ as a $4$-vector, so the two are not strictly in competition. But it is the only $\Lambda^4$ norm the record tables, and it is the one a reader will reach for.*
3. **The numerics'.** All three implementations of the wedge on disk compute $\sum_{i<j<k<l}\big(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk}\big)^2$: [plucker_min](../scripts/lib/review_r56_core.py#L230), [wedge_norm](../scripts/reviewers/r284/c1_local_max_witness.py#L45) and [wedge_coeffs](../scripts/reviewers/r296/e2_plucker.py#L24) with `half=True`. The genuine coefficient of $e_a\wedge e_b\wedge e_c\wedge e_d$ in $\omega\wedge\omega$ is TWICE that bracket, as [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean)'s `w4` records in its docstring and as the six-term expansion confirms. **So the record's printed $\lVert\omega\wedge\omega\rVert$ is HALF the identity's norm**, which [e2_plucker.py](../scripts/reviewers/r296/e2_plucker.py#L4) says in its own header: *"The repo's plucker_min / wedge_norm use HALF of that, so they report half the standard norm."*

**The exhibited failure.** Read the block's headline in [conventions.md](../findings/conventions.md#L124)'s norm. Then $\lVert\Phi(\omega)\rVert^2=\mathop{\mathrm{tr}}(\omega^4)+6\big(2-\mathop{\mathrm{tr}}(\omega^4)\big)=12-5\mathop{\mathrm{tr}}(\omega^4)$, and $\mathop{\mathrm{tr}}(\omega^4)=2\sum_ka_k^4$ ranges over $[2/m,2]$ at unit norm, so at $n=12$ the quantity ranges over $[2,10\tfrac13]$. **$\Phi$ does not map the unit sphere to a sphere in that norm, and the census's target radius is not $\sqrt2$.** The whole paragraph *"WHICH PLACES THE CENSUS ON A SPHERE WITH ITS TARGET STRICTLY INSIDE"* is false under the record's own tabled convention and true under an untabled one.

**Verdict.** The identity and the sphere are CONFIRMED under the norm the block silently uses. The block is **REFUTED on the convention discipline**, and the repair is two lines: table $\Phi$ as the fifth object under that letter in [conventions.md](../findings/conventions.md#L51), and table the orthonormal-basis $\Lambda^4$ norm beside the $\tfrac14$ one with a sentence saying which of the two each consumer takes. **And the [diagonality.md](../findings/diagonality.md) OWED item is answered NO**: the record's numerical $\lVert\omega\wedge\omega\rVert$ does NOT use the inner product this identity assumes.

## 10. The Plücker consequence, correct as a statement and misapplied as arithmetic

**$\min\lVert\omega\wedge\omega\rVert^2=2-\max\mathop{\mathrm{tr}}(\omega^4)$ over an eigenspace's unit sphere** is immediate from §9a at $\langle\omega,\omega\rangle=1$, the minimum over a set of one quantity being $2$ minus the maximum of the other over the same set. **CONFIRMED.**

**$\lVert\omega\wedge\omega\rVert=0$ iff $\omega$ decomposable** is the Plücker relation, and §9a recovers it: $\lVert\omega\wedge\omega\rVert^2=2(1-\sum_ka_k^4)$ vanishes at $\sum a_k^2=1$ exactly when one $a_k$ carries all the mass, which is $\mathop{\mathrm{rank}}\omega=2$, which is decomposability. **CONFIRMED**, and [diagonality.md](../findings/diagonality.md)'s reading of it as "a maximisation of the fourth moment" is right.

**The arithmetic in [diagonality.md](../findings/diagonality.md) is wrong by the factor of §9b.** That file writes *"the recorded values are consistent with it, $0.5$ at padded $W_{\mathbb{CP}^2}$ needs $\sum\sigma_i^4=0.875$, inside $[\tfrac13,1]$"*. The recorded $0.5$ is a half-norm, so the identity's $\lVert\omega\wedge\omega\rVert$ is $1$, giving $\mathop{\mathrm{tr}}(\omega^4)=1$ and $\sum_k a_k^4=\mathbf{0.5}$, not $0.875$. **The correction does not break anything**, since $0.5$ is also admissible, and that is precisely the problem the file half-noticed: *"a range check is not the constant."* Both readings pass the range check, so the check discriminates nothing and should not be cited as evidence either way. **The five recorded certificates $0.61$, $0.63$, $0.50$, $0.44$, $0.5$ are all still strictly positive under either scaling, so every Plücker NON-diagonalisability verdict on record stands.** *What does not stand is any quantitative use of those numbers against a threshold derived from the identity.*

## 11. Three points, not four, and the zero is excluded by the block's own ceiling

**Locate it.** The block, first paragraph: *"So at $n=12$ the spectrum is $\lambda_1$, a value $\mu$ of multiplicity $62$, two negatives and one zero"*, and then *"writing $F$ for the four exceptional eigenvectors"*. The premise, from [line 63](../findings/stratum-two-negative.md#L63) and from the brief's given, is *"with $\sigma_2^2/p_2$ pushed to its ceiling $N-3=63$"*.

**Exhibit the failure in closed form.** Take the block's own spectrum at $n=12$: one $\lambda_1$, sixty-two copies of $\mu$, one zero, and $-a,-b$. That is $1+62+1+2=66=N$, so the count of eigenvalues is right. But $\sigma_2$ and $p_2$ sum over the STRICTLY POSITIVE non-top eigenvalues, and a zero contributes to neither, so

$$\frac{\sigma_2^2}{p_2}=\frac{(62\mu)^2}{62\mu^2}=\mathbf{62}\ \ne\ 63 .$$

**The block's spectrum misses the ceiling it was derived from, by exactly one.** Conversely, attaining $\sigma_2^2/p_2=63$ forces $k_2=63$ strictly positive non-top eigenvalues, all equal, and then $1+63+2=66=N$ **leaves no eigenvalue over for a zero**. So

$$\text{spectrum}=\big(\lambda_1,\ \underbrace{\mu,\dots,\mu}_{63},\ -a,\ -b\big),\qquad 63\mu=a+b-\lambda_1,\qquad F=\{v_1,v_{N-1},v_N\},\quad\lvert F\rvert=\mathbf3 .$$

**With the record's own figures**, $\mu=\sigma_2/63=0.19749/63=3.1348\times10^{-3}$ and $p_2=63\mu^2=6.19\times10^{-4}$, which is the $p_2$ §1b reconstructed from $p=5/9$. *The two routes agree, which is the check that the corrected spectrum and not the block's is the one the chain's supremum sits at.*

**Argue the opposite, as the protocol requires.** Three charitable readings, and none survives.

* *"$N-3$ is only an a priori ceiling and the true optimum sits at $62$."* Then the ratio at the optimum is $62$, Cauchy–Schwarz equality still forces the $62$ equal, and the block's structure survives with multiplicity $62$. **But then the given premise, quoted in [line 63](../findings/stratum-two-negative.md#L63) and in the brief, is false as stated, and the reconstruction of §1b returns $p_2$ from $\sigma_2^2/63$ and matches $p=5/9$ to five digits, which $\sigma_2^2/62$ does not.** *The record's own numbers pick the ratio $63$.*
* *"The zero is an independent structural fact from elsewhere."* The block gives no source and I found none. The two-negative stratum is defined by the sign pattern and imposes nothing on the kernel, and the file's own [line 63](../findings/stratum-two-negative.md#L63) hedges with *"about $63$ positive eigenvalues"* and *"$63$ positive, $2$ negative and $1$ zero"* in the same sentence, which is $66$ only if the ratio is $62$. **The two halves of that sentence contradict each other, and the block inherits the contradiction rather than resolving it.**
* *"The block covers both cases in the three-or-four paragraph."* It does raise them, and correctly: *"THE CENSUS IS ON THREE POINTS WHEN $W$ HAS NO KERNEL ON $\Lambda^2$, AND FOUR WHEN IT DOES."* **But that paragraph treats which case holds as an open question with "a standing answer elsewhere", and the ceiling settles it in the block's first paragraph.** *The four-point case is not merely unfavoured, it is inconsistent with the hypothesis the block opens with.*

**Verdict: REFUTED.** The zero's presence is an assumption, it is excluded by the ceiling, and the census is a THREE-point census. **Everything the block builds on $\lvert F\rvert=4$ inherits the correction**: the "rank-four correction", the "span of FOUR projected squares", the tetrahedron, the "three positive weights and one negative", the "three same-sign forms", and the cost claim of §12. *The numbers $62\mu\approx0.175$ and $\mu\approx0.0028$ and $11\mu\approx0.031$ in the closing paragraph all move, to $63\mu=0.19749$, $\mu=0.0031348$ and $11\mu=0.0345$. None of those changes a conclusion by itself.*

**One thing that is NOT a defect, recorded so the next reviewer does not spend on it.** The closing paragraph's *"$\mathrm{Id}$'s floor $11\mu\approx0.031$ sits well under the left side's trace $2(3\mu+a+b)\approx1.86$"* looks at first like it contradicts the block's own exact trace identity, under which the two sides of the Ricci display have EQUAL trace $2N\mu\approx0.41$. It does not. The *"left side"* there is the three same-sign terms after the top term has been moved across, of trace $2\big(\mu+(\mu+a)+(\mu+b)\big)=2(3\mu+a+b)=1.86$, and the *"right side"* is $\mu(n-1)\mathrm{Id}+(\lambda_1-\mu)v_1v_1^{\mathsf T}$, of trace $2N\mu+2(\lambda_1-\mu)=1.855$. **The two agree to the digits printed and the arithmetic is sound.** *The referent of "the right side" changes between that sentence and the display it refers back to, which is what makes it read wrong. **WITHDRAWN as a discrepancy**, recorded as prose to disambiguate.*

## 12. The cost claim, argued the other way

The block: *"At four points the conditions are WEAKER (an affine target rather than the origin, and one more free form) so it is harder rather than easier"*, and an item asking for it *"is asking for that whole apparatus one rank up"*.

**First, the point count.** By §11 there are three points, not four. **So "one more free form" is not there**, and the census is on the same number of points as [L183](../findings/diagonal-half.md#L933) through [L191](../findings/diagonal-half.md). The apparatus is not asked for one rank up. *Even were the zero present, the fourth point is the eigenvector of a ZERO eigenvalue, which contributes nothing to $\mathop{\mathrm{tr}}W^3$, to $\langle W,W^\#\rangle$ or to the spectrum's summary statistics, and is the most constrained of the four rather than a free one.*

**Second, the affine target is a constraint and not a freedom, and in the $S^2$ half it is a large one.** In [L183](../findings/diagonal-half.md#L933)'s homogeneous form the $S^2$ condition is $\sum_i\lambda_i\omega_i^2=0$, and [L180](../findings/diagonal-half.md#L887)(3) reads it by moving the minority-sign term across, leaving a PSD sum equal to a PSD matrix and concluding by range additivity that **the supports COLLAPSE into the minority form's**. Now do the same to the shifted census. Writing $A_\alpha=v_\alpha v_\alpha^{\mathsf T}\succeq0$, the target $B$'s first component is $\sum_Fw_\alpha v_\alpha^2=-\tfrac2n\mathrm{Id}$, that is $\sum_Fw_\alpha A_\alpha=\tfrac2n\mathrm{Id}$, and moving the single negative weight across gives

$$w_{N-1}A_{N-1}+w_NA_N\ =\ \tfrac2n\,\mathrm{Id}_{\mathbb R^n}+\lvert w_1\rvert A_1 .$$

**The right side is positive DEFINITE.** Range additivity, which [L180](../findings/diagonal-half.md#L887) already sources to [Fillmore–Williams](../references/fillmore-williams-1971-operator-ranges/), then gives $\mathop{\mathrm{supp}}v_{N-1}+\mathop{\mathrm{supp}}v_N=\mathbb R^n$: **the supports EXPAND to everything instead of collapsing into one.** That is a rigid conclusion the homogeneous version cannot reach, because a zero right-hand side is compatible with any common support. **So the shift makes the $S^2$ half strictly stronger, and the block has the direction of the inequality backwards.**

**Third, there is a reduction, and it runs the direction the block says is unavailable.** The shifted condition is *three surface points and ONE FIXED KNOWN POINT are affinely dependent with a prescribed sign pattern*. A four-point surface census ranges over four unknowns of the surface. This one ranges over three, with the fourth pinned at a point whose structure is completely explicit, a multiple of the identity in $S^2$ and zero in $\Lambda^4$, and which §6 shows is off the surface. **A problem with one of its four points fixed is a specialisation of the four-point problem, not an instance of it**, and every branch analysis [L183](../findings/diagonal-half.md#L933) runs on the free points is available here with one fewer branch, the coincident case being excluded outright by §6.

**Fourth, and the sharpest.** The corrected three-point form is where the census does real work, and §15 shows it closes the configuration using nothing new. **REFUTED.** *The honest residue of the block's paragraph is that a census at general rank is expensive, which is true and is not what the paragraph says.*

## 13. The $\dim V=6$ count

**The claim.** *"Every solution at $\dim V=6$ now has trivial stabiliser, so the branch IS the principal stratum, which is exactly where [r827](REVIEW_r827.md)'s counterexample found the count exact rather than false. So [r824](REVIEW_r824.md)'s repair applies to it: $\dim(M/G)=25$ against $35$ constraints expects a deficit of ten and predicts emptiness."*

**The arithmetic checks, and I redid it cold.** $M$ is the orthonormal triples in $\Lambda^2\mathbb R^6\cong\mathfrak{so}(6)$ times the unit traceless weight circle, of dimension $\big(3\cdot15-\binom42\big)+1=39+1=40$. $G=SO(6)$ has dimension $15$. At trivial stabiliser $\dim(M/G)=40-15=25$. The constraint map is $F=\big(\sum_i\lambda_i\omega_i^2,\ \sum_i\lambda_i\,\omega_i\wedge\omega_i\big)$ into $S^2_0(\mathbb R^6)\oplus\Lambda^4\mathbb R^6$, of dimension $20+15=35$, **the trace being dropped for exactly §5's reason**. So $25-35=-10$. **CONFIRMED as arithmetic.**

**What identifying the branch with the principal stratum actually needs.** Two things, and the block supplies one.

* *Freeness.* If every solution has trivial stabiliser then every solution lies in the free locus, on which $G$ acts freely and properly ($G$ compact), so the quotient is a smooth $25$-manifold. **This the block has**, granted the closures it cites, and it is what the stabiliser work of [r824](REVIEW_r824.md), [r826](REVIEW_r826.md) and [r827](REVIEW_r827.md) bought.
* *Transversality.* $F$ is $G$-equivariant into a $G$-representation, so it does not descend to a map into a fixed $\mathbb R^{35}$. It descends to a SECTION $s$ of the associated bundle $M_{\rm free}\times_G\mathbb R^{35}$ over $M_{\rm free}/G$, and the zero locus of a section has the expected dimension $25-35<0$, hence is empty, **only if $s$ is transverse to the zero section along its zeros**. **This the block does not have, and it is a genuine hypothesis rather than a formality**: the zero section itself is a section of that bundle whose zero locus is all $25$ dimensions.

**So name it.** *For the count to be EXACT at the branch, the linearisation $d_pF$ must be surjective onto the $35$-dimensional target modulo the tangent to the orbit, at every solution $p$.* Equivalently, the solution set's expected codimension is realised. **That is a statement about the constraint map and not about stabilisers**, and no amount of stabiliser classification supplies it. *r827's counterexample $F(v,x)=(v,x\lVert v\rVert^2,\lVert v\rVert^4)$ found the count exact on the principal stratum of THAT example, where $F$ restricted there is transverse. One example establishes that stratification repairs the objection, which is what r827 claimed. It does not establish transversality here, and the block's "which is exactly where r827's counterexample found the count exact" reads it as if it did.*

**One loose phrase, charitably repaired.** *"The branch IS the principal stratum"* is a category error as written: the branch is a solution set, hence a closed subvariety, and the principal stratum is an open dense subset of $M$. The reading the words support and that the argument needs is **"the branch meets only the free locus"**, which is what the stabiliser closures give. *Recorded as a repair, not a defect.*

**Verdict: PLAUSIBLE, with a named missing hypothesis, and the block's own hedge is the right one.** *"A count that survives its own objection is still a count, it predicts and does not prove"* is exactly correct and I would leave it standing. **What should be added is the one sentence saying what would make it a proof**, because without it the next block up the file will be tempted to promote it.

## 14. What would falsify the block, and what I did

**Six falsifiers, in the order I tried them.**

1. **A spectrum meeting the recorded ceiling that is NOT of the form $\mu\mathrm{Id}+$ low rank.** Attempted by re-deriving the Cauchy–Schwarz equality case. **It does not exist**, §1a, so the structural rewriting is safe. *This is the block's strongest step.*
2. **An internal inconsistency between the ceiling and the spectrum.** Found, §11. *This is a falsifier of the block's stated configuration and it fires.*
3. **A wrong constant in the barycentre.** Attempted by re-deriving $\sum_\alpha v_\alpha v_\alpha^{\mathsf T}$, the trace of $\omega^2$, and $(n-1)/N$ from scratch, §§3–5. **All three are right.**
4. **A normalisation mismatch that breaks the sphere.** Found, §9b. Located by deriving the identity at general $n$ myself, reading which $\Lambda^4$ scaling makes the constant $1$, then reading all three wedge implementations on disk and [conventions.md](../findings/conventions.md#L124)'s tabled norm. *It fires against the block's convention discipline and against [diagonality.md](../findings/diagonality.md)'s arithmetic, and not against the mathematics.*
5. **A point of $\Phi$'s surface at $B$, which would restore the coincident branch.** Attempted at both components and at the boundary. **None exists above $n=2$**, §6.
6. **A configuration that the block calls feasible and that a lemma on record forbids.** **FOUND**, §15. *This is the falsifier that matters, it fires on the block's own closing paragraph, and it uses no new mathematics.*

**What I did to look.** I re-derived every display in the block from the definitions before reading the record's version of it, reconstructed the recorded extremiser from the two printed figures until it closed to five digits, read [L29](../findings/stratum-two-negative.md#L113), [L31](../findings/stratum-two-negative.md#L473), [L180](../findings/diagonal-half.md#L887) and [L183](../findings/diagonal-half.md#L933) in full, read both Lean files line by line against the prose they claim to type, and read the three wedge implementations rather than trusting the header of one. **No numerical run of any kind was performed and none was needed**, every figure above being a closed-form evaluation.

## 15. What the review adds: the failing configuration cannot make the chain tight

**This is the finding, and it refutes the block's closing feasibility claim outright.** It uses two canonical lemmas of this record and introduces nothing.

**Premise, from the file itself.** [Line 61](../findings/stratum-two-negative.md#L61): *"The chain's dominant term $(+--)\le6\lambda_1ab$ is tight only when $\lVert[v_{N-1},v_N]\rVert^2=2$."* A Weyl tensor attaining the chain's value $1.226297$ must make every step of the chain an equality, and the $(+--)$ step is the dominant one. *At the reconstructed extremiser, $6\lambda_1ab=0.9933$ against a total of about $1.23$, so it carries four fifths of the bound and there is no reading under which its slack is affordable.*

**Step 1.** $T_{1,N-1,N}\le\sum_\gamma T_{N-1,N,\gamma}=\lVert[v_{N-1},v_N]\rVert^2$, every $T$ being a square and $T$ totally symmetric. So the $(+--)$ step is tight only at $\lVert[v_{N-1},v_N]\rVert^2=2$.

**Step 2, [Lemma L31](../findings/stratum-two-negative.md#L473).** For unit $X,Y\in\mathfrak{so}(n)$, $\lVert[X,Y]\rVert^2=2$ **if and only if** $XY=-YX$, both have rank $4$ with all nonzero singular values $1/\sqrt2$, and $\mathop{\mathrm{im}}X=\mathop{\mathrm{im}}Y$. So the two negative eigenvectors share a single $4$-dimensional support $V_0$.

**Step 3, [Lemma L180](../findings/diagonal-half.md#L887).** *"The general content is $\sum_{\lambda_i>0}\mathop{\mathrm{supp}}\omega_i=\sum_{\lambda_i<0}\mathop{\mathrm{supp}}\omega_i=V$, at any rank."* The negative side is $\mathop{\mathrm{supp}}v_{N-1}+\mathop{\mathrm{supp}}v_N=V_0$, of dimension $4$. **So the positive side is $V_0$ too**, and every eigenvector with $\lambda_\alpha>0$ has $\mathop{\mathrm{supp}}v_\alpha\subseteq V_0$, hence $v_\alpha\in\Lambda^2V_0$.

**Step 4, a count.** $\dim\Lambda^2V_0=\binom42=6$, and the eigenvectors are orthonormal. **So $W$ has at most SIX eigenvectors with nonzero eigenvalue, of which two are the negatives, leaving at most FOUR positive ones.** Every remaining eigenvalue is zero, so $\mu=0$ and there is no $\sigma_2$ at all.

**Conclusion.**

> **No Weyl tensor with two negative eigenvalues and more than four positive ones makes the chain's dominant step tight. The failing configuration needs $63$ or $64$ positive eigenvalues. So the recorded supremum $1.226297$ is attained by NO Weyl tensor at any $n$, and the configuration the whole block is about is infeasible for the chain that produced it.**

**Against the block's own words.** *"AND THE INEQUALITIES ALL PASS, WHICH IS THE POINT ... the three same-sign forms need total rank at least $n$, which three bivectors supply at $n=12$ without effort. So the configuration is feasible for every bound of this kind."* **The rank check is the one that fails, and the block ran it in the weakest available form.** In the shifted census the positive-weight forms are $v_{N-1}$, $v_N$ and, on the block's mistaken count, the kernel vector, so the rank requirement is spread over three forms and is easy. **[L180](../findings/diagonal-half.md#L887) puts the requirement on the two negatives ALONE**, where at $n=12$ it reads $\mathop{\mathrm{rank}}v_{N-1}+\mathop{\mathrm{rank}}v_N\ge12$ against L31's $4+4$ with equal images, which is $4$. *The spurious fourth point is exactly what made the check look easy, which is why §11's miscount is load-bearing and not cosmetic.*

**And the block's own isotropy display reaches the same place**, which is worth recording because it needs no lemma outside the block. At L31 equality, $\ker v_{N-1}=\ker v_N$ is $8$-dimensional at $n=12$. On the corrected THREE-point census the display at such an $x$ reads $w_1\lvert v_1x\rvert^2=\tfrac2n\lvert x\rvert^2$ with $w_1<0$, forcing $x=0$ against an $8$-dimensional kernel. **On the block's four-point version the kernel vector absorbs it**, needing only $\mathop{\mathrm{rank}}v_0\ge8$, which is available at $n=12$. *So the block's own instrument refutes the configuration as soon as the point count is right, and fails to as long as it is wrong.*

**What this does NOT do, stated with the same care §1b demands.** It excludes the extremiser and it gives no quantitative gap. The chain's supremum over REALISABLE Weyl tensors is now known to be strictly below $1.226297$, and *strictly below* is not *below $\sqrt{3/2}$*. **The stratum stays open and the recorded bound stays where it is.** *A quantitative version would need the stability of L31, that is a lower bound on $2-\lVert[X,Y]\rVert^2$ in terms of the singular-value mass outside the top two blocks, together with the support requirement of step 3. Both ends of that are closed form and the middle is not, and pursuing it numerically is a computation I am not authorised to open.*

## Verdict

**The block is CORRECT in its algebra and WRONG in its configuration, its point count, its cost estimate and its conclusion.**

* **Confirmed and needing no change:** the Cauchy–Schwarz equality reading (§1a), the Weyl part of the identity (§2), the basis sum's value (§3), the barycentre and its cancellation (§4), the trace (§5), $B$ off the surface (§6), the sign algebra (§7), the isotropy display and its corollary (§8), the identity itself, now proved at every $n$ (§9a), and the Plücker consequence as a statement (§10).
* **Repairs owed, each one or two lines:** the justification of the basis sum names the wrong group (§3); $\mu\ne0$ and $n\ne1$ belong in the prose and not only in [ShiftedCensus.lean](../lean/HamiltonsCubic/Results/ShiftedCensus.lean) (§4); the spherical average is glossed by the other average (§8); $\Phi$ and the orthonormal-basis $\Lambda^4$ norm belong in [conventions.md](../findings/conventions.md) (§9b); [diagonality.md](../findings/diagonality.md)'s $\sum\sigma_i^4=0.875$ is $0.5$ and its OWED item is answered NO (§10); *"the branch IS the principal stratum"* should read *"meets only the free locus"*, and transversality should be named (§13).
* **Refuted:** the spectrum at the head of the block, which misses by one the ceiling it is derived from, so the census is on THREE points and $F$ carries no kernel vector (§11); the cost claim, which has the direction of the affine target's effect backwards and asks for an apparatus the corrected count does not need (§12); and the closing feasibility claim, which a lemma pair on record contradicts (§15).
* **Refuted as a strategy:** attacking the extremiser as a point, when the quantity is a supremum over a set in which the extremiser is not isolated (§1b).

**The block's final sentence, *"It closes nothing"*, is true, and none of its stated reasons is the reason.** *It closes nothing because a point-wise exclusion cannot lower a supremum, and because the point it would exclude is already excluded by [L31](../findings/stratum-two-negative.md#L473) and [L180](../findings/diagonal-half.md#L887) for a reason the block does not mention.* **What should replace the "rank-four census is a programme" paragraph is the three-point census with the chain's equality conditions carried into it**, which is cheaper than the block prices it and which, run at the extremiser, already returns an answer.
