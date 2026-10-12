# r830: Gate 2 on the shifted census of the two-negative stratum, and on the $\dim V=6$ count

*Cold brief. I was given the census block verbatim and read it on disk at [findings/stratum-two-negative.md](../findings/stratum-two-negative.md#L65) through [line 107](../findings/stratum-two-negative.md#L107), and the second claim at [findings/diagonal-half.md](../findings/diagonal-half.md#L798). **The programme is on an analysis-only footing.** Every derivation below is by hand and every positive claim is proved by hand. I ran three SCREENS in the sense the standing rule allows, on objects I built for the purpose, each labelled where it appears, and none is cited as evidence for a positive claim. Log: [agent_logs/g2-census-r830.log](../agent_logs/g2-census-r830.log).*

| Item | Claim | Verdict |
|---|---|---|
| **1** | the Cauchy–Schwarz ceiling is $N-3$, and attaining it forces the non-top positives equal | **CONFIRMED, and sharper than the block says.** $N-3$ is right, attainment forces $k_2=N-3$ **and** equality, and the constraint is ACTIVE at the argmax, so the supremum is attained in the chain's scalar programme and the equality analysis is legitimate |
| **2** | $\Pi_{\mathcal W}(\mathrm{Id}_{\Lambda^2})=0$ | **CONFIRMED.** $\mathrm{Id}_{\Lambda^2}$ is induced by $R^0_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ under the record's $\tfrac12$ pairing, it satisfies first Bianchi, and $\langle\mathrm{Id},W\rangle=\operatorname{tr}W=0$ at every Weyl tensor |
| **3** | $\sum_\alpha v_\alpha v_\alpha^{\mathsf T}=(n-1)\mathrm{Id}$ over an ARBITRARY orthonormal basis | **CONFIRMED**, and the block needs the general form. Proof in two lines: the sum is basis-independent, then evaluate at $\varphi_{ij}$. The companion fact $\sum_\alpha v_\alpha\wedge v_\alpha=0$ is used and unstated |
| **4** | $\sum_Fc_\alpha=-N\mu$, and $B=(-\tfrac2n\mathrm{Id},0)$ with $\mu$ and the multiplicity cancelling | **CONFIRMED.** $(n-1)/N=2/n$ exactly, and $\sum_Fc_\alpha=-N\mu$ holds at EVERY $\lvert F\rvert$, which is why the multiplicity cancels. $n\ne1$ and $\mu\ne0$ are hypotheses of [ShiftedCensus.lean](../lean/HamiltonsCubic/Results/ShiftedCensus.lean) and appear nowhere in the prose |
| **5** | $\operatorname{tr}(\omega^2)=-2$ and $\operatorname{tr}(-\tfrac2n\mathrm{Id})=-2$, so the trace is uninformative | **CONFIRMED**, both exactly, and the trace identity is equivalent to trace-freeness |
| **6** | $B$ is not a point of the surface at $n>2$, so no coincident branch | **CONFIRMED, with the reason wrong at odd $n$.** At even $n$ the rank clash is the argument. At odd $n$ and at $n=3$ there is no complex structure at all, so the first component alone is unsolvable. $n=2$ is genuinely the boundary and $B$ IS on the surface there |
| **7** | $\mu>0$, so $B$ has three positive barycentric weights and one negative | **CONFIRMED as to signs, REFUTED as to the count.** $\mu>0$ holds and $w_1<0$ with the rest positive, but there are THREE weights, so it is two positive and one negative, and the "tetrahedron" is a triangle |
| **8** | the isotropy form, its spherical average, and the no-common-kernel corollary | **CONFIRMED, all three.** The pairing, the average $\operatorname{tr}(vv^{\mathsf T})/n=2/n$ and the corollary are each exact. **The corollary is the strongest line in the block and the block does not spend it** |
| **9** | $\operatorname{tr}(\omega^4)+\lVert\omega\wedge\omega\rVert^2=2\langle\omega,\omega\rangle^2$ at every skew $\omega$, every $n$ | **CONFIRMED at general $n$, derived below.** The $\Lambda^4$ inner product is the one making $\{e_{ijkl}\}_{i<j<k<l}$ orthonormal, which is SIX TIMES SMALLER than [conventions.md](../findings/conventions.md)'s $\tfrac14\sum_{ijkl}$ rule on the same array. The record's numerals $0.61,0.63,0.50$ use exactly this inner product, on the FROBENIUS unit sphere rather than the record's own |
| **9b** | [diagonality.md](../findings/diagonality.md)'s own consistency check on those numerals | **REFUTED.** "$0.5$ at padded $W_{\mathbb{CP}^2}$ needs $\sum\sigma_i^4=0.875$" is a false positive: the eigenvector is self-dual on an $\mathbb R^4$, so $\sum\sigma_i^4=\tfrac12$ and the record-unit value is $1$, not $0.5$. The OWED normalisation is settled below and the numerals survive at half scale |
| **10** | $\min\lVert\omega\wedge\omega\rVert^2=2-\max\operatorname{tr}(\omega^4)$, and $\lVert\omega\wedge\omega\rVert=0$ iff decomposable | **CONFIRMED**, both, and both immediate from item 9 |
| **11** | the fourth exceptional eigenvector is a zero, so four points, three at trivial kernel | **REFUTED, and this is the block's principal defect.** Attaining the ceiling $63$ at $N=66$ leaves $1+63+2=66$, so a zero eigenvalue is EXCLUDED, not assumed. The census is on THREE points at the configuration, unconditionally, and the kernel is not an open question here |
| **12** | closing it needs a rank-four census, harder than the rank-three one | **REFUTED.** The point count is three, the shift is bookkeeping rather than new data, the affine target is strictly MORE rigid than the origin, and the configuration dies in two lines against [Lemma L31](../findings/stratum-two-negative.md#L473), which sits 400 lines below the block in the same file |
| **13** | the $\dim V=6$ count is back in scope because the branch is the principal stratum | **PARTIALLY CONFIRMED, OVERSTATED TWICE.** Containment in the free stratum is what the count needs and is what the premise gives, so "IS the principal stratum" is loose but harmless. The premise is [r827](REVIEW_r827.md)'s own unaudited derivation, and no count is EXACT at a solution: transversality of the descended section is equivalent to emptiness, so the count predicts and cannot check itself |
| **14** | the block as a whole | **REFUTED IN ITS CONCLUSION.** "the configuration is feasible for every bound of this kind ... confirms rather than repairs it" is false in its strong reading: the configuration is NOT realisable by any Weyl tensor at any $n>4$, by the block's own census plus L31 |
| **14b** | the block's own numerical checks | **REFUTED, three of them.** $62\mu$ should be $63\mu$, the left side's trace is $2(\lvert F\rvert\mu+\sigma_2)=n(n-1)\mu\approx0.41$ and not $2(3\mu+a+b)\approx1.86$, and the ambient dimension is $\binom{n+1}2+\binom n4$ and not $\binom n2+\binom n4$ |

**One line.** *The census is right, the arithmetic around it is not, and the census closes the configuration the block says it cannot: the equality case has no zero eigenvalue, hence THREE exceptional eigenvectors and trivial kernel on $\Lambda^2$, hence no common kernel vector for the two negative eigenvectors, while the same configuration needs the pair cap tight, which by [Lemma L31](../findings/stratum-two-negative.md#L473) gives the two negative eigenvectors EQUAL four-dimensional images and a common kernel of dimension $n-4$.* **The block should end "the chain's argmax is unrealisable at every $n>4$", not "the inequalities all pass".**

---

## 0. Conventions, fixed before anything is checked

Everything below runs on the brief's givens and on [findings/conventions.md](../findings/conventions.md). Where the two could differ I say which I use.

- **On $\Lambda^2$**: $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so a unit bivector has $\operatorname{tr}(\omega\omega^{\mathsf T})=2$, $\operatorname{tr}(\omega^2)=-2$, and singular values in pairs $\sigma_1,\sigma_1,\sigma_2,\sigma_2,\dots$ with $\sum_i\sigma_i^2=1$. The coordinate bivectors $\varphi_{ij}=e_ie_j^{\mathsf T}-e_je_i^{\mathsf T}$ are already unit. This is [conventions.md](../findings/conventions.md)'s line 29 and line 87.
- **On $S^2(\mathbb R^n)$**, where $\Phi$'s first component lives: PLAIN Frobenius, $\lVert A\rVert^2=\operatorname{tr}(A^{\mathsf T}A)$, so $\lVert\omega^2\rVert^2=\operatorname{tr}(\omega^4)$. The block's $\lVert\Phi(v_\alpha)\rVert^2=2$ commits to this and nothing else works, as §9 shows.
- **On $\Lambda^4$**: the inner product making $\{e_i\wedge e_j\wedge e_k\wedge e_l\}_{i<j<k<l}$ orthonormal, with the wedge normalised so that $e_{12}\wedge e_{34}=e_{1234}$, equivalently $(\omega\wedge\omega)_{ijkl}=2\big(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk}\big)$ and $\lVert\omega\wedge\omega\rVert^2=\sum_{i<j<k<l}(\omega\wedge\omega)_{ijkl}^2$. **This is NOT [conventions.md](../findings/conventions.md)'s line 124 rule $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$ applied to the same array**, which is six times larger. §9 settles which the record's own numbers use and why both are right in their own places.
- **Sign of $\Phi$'s first component**: $v^2=-vv^{\mathsf T}$ at skew $v$, and Ricci-flatness is $\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=0$, which is the brief's given and is the standard contraction $\mathrm{Ric}_{jl}=\sum_iR_{ijil}$ at $R_{ijkl}=v_{ij}v_{kl}$.
- **The configuration**, in closed form. §1 derives it: $a=b=1/\sqrt{4.5}=\sqrt2/3$, $m=a^2+b^2=4/9$, $p=5/9$, the cap $\sqrt p=\sqrt5/3=0.7453560$ exactly, $\lambda_1=0.744939$, $\sigma_2=2a-\lambda_1=0.1978700$, $p_2=p-\lambda_1^2=6.2153\times10^{-4}$, $\sigma_2^2/p_2=63$, $\mu=\sigma_2/63=0.00314079$, $N=66$, $n=12$.

## Hypothesis inventory

What the block's chain of statements actually consumes, in the order it consumes it.

| # | hypothesis | where it enters | status |
|---|---|---|---|
| H1 | $W\in\mathcal W_n$, $\lVert W\rVert=1$, exactly two negative eigenvalues | throughout | the stratum's own definition |
| H2 | the chain's Cauchy–Schwarz constraint is ATTAINED, $\sigma_2^2=(N-3)p_2$ | the equality step at [line 65](../findings/stratum-two-negative.md#L65) | **conditional**, and the block states it as fact. It holds at the chain's argmax and only there |
| H3 | $\mu\ne0$ | the division by $-N\mu$ at [line 77](../findings/stratum-two-negative.md#L77) | **forced** by H2 and $\sigma_2>0$, and unstated in prose. Present in Lean |
| H4 | $n\ne1$, $n\ne0$ | $(n-1)/N=2/n$ | vacuous here, present in Lean |
| H5 | $\sum_\alpha v_\alpha v_\alpha^{\mathsf T}=(n-1)\mathrm{Id}$ at an ARBITRARY orthonormal basis | the Ricci display at [line 73](../findings/stratum-two-negative.md#L73) | **true**, §3, and proved in Lean only at $\varphi_{ij}$ |
| H6 | $\sum_\alpha v_\alpha\wedge v_\alpha=0$ at an arbitrary orthonormal basis | the Bianchi display at [line 73](../findings/stratum-two-negative.md#L73) | **true**, §3, and used silently under the words "which $\mathrm{Id}_{\Lambda^2}$ satisfies on its own" |
| H7 | a zero eigenvalue is present, so $\lvert F\rvert=4$ | [line 65](../findings/stratum-two-negative.md#L65), and [ShiftedCensus.lean](../lean/HamiltonsCubic/Results/ShiftedCensus.lean)'s `Fin 4` and its "multiplicity `N - 4`" | **FALSE under H2**, §11 |
| H8 | the four points are affinely independent | "beyond the face opposite $\Phi(v_1)$" at [line 99](../findings/stratum-two-negative.md#L99) | unstated, and needed for the word "face" to name anything |
| H9 | the chain's $(+--)$ term is tight at the argmax | never stated in the block, and it is what kills the configuration | **forced** at any realiser of the chain's supremum, §12 |

## 1. The equality step, and whether the supremum is attained

**The ceiling is right.** $\sigma_2=\sum_{\alpha\ne1,\lambda_\alpha>0}\lambda_\alpha$ and $p_2$ the corresponding sum of squares, both over $k_2$ terms where $k_2$ counts the strictly positive non-top eigenvalues. Cauchy–Schwarz gives $\sigma_2^2\le k_2p_2$. With exactly two negative eigenvalues among $N$, the count of nonnegative ones is $N-2$, one of which is the top, so $k_2\le N-3$, which is $63$ at $n=12$. That is the file's own $k\le N-2$ at [line 45](../findings/stratum-two-negative.md#L45) read one index down. **CONFIRMED.**

**Attainment forces both halves, and the block is right to say so.** $\sigma_2^2/p_2=N-3$ forces $k_2\ge N-3$, hence $k_2=N-3$, hence equality in Cauchy–Schwarz over those $N-3$ terms, hence all of them equal to a common $\mu$. Zeros cannot hide among them: a zero contributes to neither $\sigma_2$ nor $p_2$, so the ratio is bounded by the count of STRICTLY positive non-top eigenvalues, and if one of the equal values were zero all would be, giving $\sigma_2=0$. **CONFIRMED, and this is exactly what §11 turns against the block.**

**Approached or attained: attained, in the scalar programme.** The brief asks what happens if the supremum is approached. It is not. The chain's feasible set in $(\lambda_1,a,b)$ is compact, and the constraint $\sigma_2^2\le63\,p_2$ is ACTIVE at the argmax. *Screen, on objects built for it: maximising $\lambda_1p-(a^3+b^3)+6\lambda_1ab+\lambda_1(\sigma_2^2-p_2)$ on the symmetric slice under $\sigma_2^2\le63p_2$ returns $1.226297$ at $\lambda_1=0.744939$, reproducing the file's two recorded figures to all printed digits, with the constraint active.* The screen is reported as a screen. The closed-form reading it confirms is proved by hand: $\sqrt p=0.7453560=\sqrt5/3$ forces $p=5/9$, hence $m=4/9$, hence $a=b=\sqrt2/3$ on the symmetric slice, and then $\sigma_2^2/p_2=63$ at the recorded $\lambda_1$.

**So the equality analysis is legitimate, with one modality correction.** What is true is: IF a Weyl tensor attains the chain's supremum THEN its spectrum is $\lambda_1$, a value $\mu$ of multiplicity $N-3$, and two negatives. The block asserts the spectrum flatly, of an object it calls "the failing configuration", which is a point of the chain's feasible set and not a tensor. *Charitable reading, which the words support: the block is describing the argmax of the scalar programme, and every consumer of the block reads it that way.* The correction is one word and I do not record it as a defect on its own.

**A secondary arithmetic reconciliation, recorded because a successor will hit it.** The file at [line 39](../findings/stratum-two-negative.md#L39) writes the $(+++)$ bound as $2\lambda_1(\sigma_2^2-p_2)$. The recorded supremum $1.226297$ is reproduced by the coefficient $1$, and the coefficient $2$ gives $1.255001$. The charitable reading is the ordered against unordered pair convention, $\sum_{\beta<\gamma}\lambda_\beta\lambda_\gamma=\tfrac12(\sigma_2^2-p_2)$, which is the same factor of two that [line 541](../findings/stratum-two-negative.md#L541) records against L153. **I do not record this as a defect**, both readings being defensible from the words, and I flag it because the two readings differ by $0.0287$ in a quantity whose whole interest is a $0.0016$ overshoot.

## 2. $\Pi_{\mathcal W}(\mathrm{Id}_{\Lambda^2})=0$

**Which $R^0$ is $\mathrm{Id}$.** Take $R^0_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$. Under the record's pairing the induced operator is $(R^0\omega)_{ij}=\tfrac12\sum_{kl}R^0_{ijkl}\omega_{kl}=\tfrac12(\omega_{ij}-\omega_{ji})=\omega_{ij}$, so $R^0=\mathrm{Id}_{\Lambda^2}$ on the nose, with no factor to lose. **This is the constant-curvature tensor of the unit round sphere.**

**It satisfies first Bianchi.** The cyclic sum is $(\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk})+(\delta_{il}\delta_{kj}-\delta_{ij}\delta_{kl})+(\delta_{ij}\delta_{lk}-\delta_{ik}\delta_{lj})=0$ term by term. Equivalently, in the spectral form, $\sum_\alpha\varphi_{ij}\wedge\varphi_{ij}=0$ because each $\varphi_{ij}$ is decomposable. **CONFIRMED.**

**Its Weyl part is zero.** $S^2(\Lambda^2)=\mathcal W_n\oplus S^2_0(\mathbb R^n)\oplus\mathbb R\oplus\Lambda^4$ is the classical decomposition, and $\mathrm{Id}$ lies in the $\mathbb R$ summand, being $O(n)$-invariant and Bianchi. The one-line check that needs no representation theory: $\Pi_{\mathcal W}$ is the orthogonal projection, so $\langle\Pi_{\mathcal W}(\mathrm{Id}),W\rangle=\langle\mathrm{Id},\Pi_{\mathcal W}(W)\rangle=\langle\mathrm{Id},W\rangle=\operatorname{tr}W=0$ at every $W\in\mathcal W_n$, and $\Pi_{\mathcal W}(\mathrm{Id})\in\mathcal W_n$, so it is orthogonal to itself. **CONFIRMED, with no sign or factor available to go wrong.**

**One caveat on the use rather than the fact.** $\mathrm{Id}$ is not Ricci-flat, its Ricci being $(n-1)\mathrm{Id}_{\mathbb R^n}$, which is §3's constant. The block's display at [line 69](../findings/stratum-two-negative.md#L69) is safe because $W$ is in $\mathcal W_n$ by hypothesis, so applying $\Pi_{\mathcal W}$ to $W=\mu\mathrm{Id}+\sum_Fc_\alpha v_\alpha\otimes v_\alpha$ returns $W$ on the left. **The step is $W=\sum_Fc_\alpha\Pi_{\mathcal W}(v_\alpha\otimes v_\alpha)$ and it is correct.**

## 3. $\sum_\alpha v_\alpha v_\alpha^{\mathsf T}=(n-1)\mathrm{Id}$ at an arbitrary orthonormal basis

**The general statement is true, and I derive the constant.** Let $T:S^2(\Lambda^2)\to S^2(\mathbb R^n)$ be the linear map with $T(v\odot w)=\tfrac12(vw^{\mathsf T}+wv^{\mathsf T})$. Then $\sum_\alpha v_\alpha v_\alpha^{\mathsf T}=T\big(\sum_\alpha v_\alpha\odot v_\alpha\big)=T(\mathrm{Id}_{\Lambda^2})$, and $\sum_\alpha v_\alpha\odot v_\alpha$ is the identity element of $S^2(\Lambda^2)$, which does not depend on the orthonormal basis. **So the sum is basis-independent and may be evaluated at $\varphi_{ij}$.** There $\varphi_{ij}^2=-e_ie_i^{\mathsf T}-e_je_j^{\mathsf T}$, so $\varphi_{ij}\varphi_{ij}^{\mathsf T}=e_ie_i^{\mathsf T}+e_je_j^{\mathsf T}$, and each index $k$ appears in exactly $n-1$ pairs, giving $(n-1)\mathrm{Id}$. **The trace check is $\sum_\alpha\operatorname{tr}(v_\alpha v_\alpha^{\mathsf T})=2N=n(n-1)=\operatorname{tr}\big((n-1)\mathrm{Id}\big)$.** CONFIRMED.

**The block's stated reason also works, and is the same reason.** For $g\in O(n)$ the rotated frame $(gv_\alpha g^{\mathsf T})$ is again orthonormal, so $gMg^{\mathsf T}=M$ for $M$ the sum, so $M$ is a multiple of the identity by Schur, and the trace fixes the multiple. **Both routes need basis-independence, which is the content.**

**The block needs the general form and the Lean layer does not carry it.** The $v_\alpha$ are $W$'s eigenvectors, which are essentially never coordinate bivectors, and [conventions.md](../findings/conventions.md) line 69 is explicit that conflating the two is a standing trap of this record. The Lean file proves the $\varphi$ case. **The gap is a real debt and it is one line of mathematics**, which is the best kind to owe.

**And a second general-basis fact is used silently.** The Bianchi half of the display needs $\sum_\alpha v_\alpha\wedge v_\alpha=0$ at an arbitrary orthonormal basis, which the block covers with "which $\mathrm{Id}_{\Lambda^2}$ satisfies on its own". Same proof: the sum is $6\,\mathrm{Alt}$ of the identity element, basis-independent, and at $\varphi_{ij}$ every term vanishes for decomposability. **True, and it should be written down beside H5.**

## 4. The weight sum and the barycentre

**$\sum_Fc_\alpha=-N\mu$, at every $\lvert F\rvert$.** Trace-freeness is $\operatorname{tr}W=0$, and $\operatorname{tr}(v\otimes v)=\langle v,v\rangle=1$ at a unit $v$, so $0=\operatorname{tr}\big(\mu\mathrm{Id}+\sum_Fc_\alpha v_\alpha\otimes v_\alpha\big)=N\mu+\sum_Fc_\alpha$. **CONFIRMED**, and the derivation shows why the multiplicity cancels: it never enters. The same computation at $\lvert F\rvert=3$ gives $-N\mu$ unchanged, which is the one place the block's off-by-one does no damage.

**The arithmetic $(n-1)/N=2/n$.** $N=n(n-1)/2$, so $(n-1)/N=2(n-1)/\big(n(n-1)\big)=2/n$, exactly, for $n\ge2$. Dividing the Ricci display $\sum_Fc_\alpha v_\alpha^2=\mu(n-1)\mathrm{Id}$ by the weight sum $-N\mu$ gives $\sum_Fw_\alpha v_\alpha^2=-\tfrac{(n-1)}N\mathrm{Id}=-\tfrac2n\mathrm{Id}$ with $w_\alpha=c_\alpha/(-N\mu)$ and $\sum_Fw_\alpha=1$. **CONFIRMED**, and the Bianchi half divides through to $0$ unchanged. So $B=(-\tfrac2n\mathrm{Id},0)$ and neither $\mu$ nor the multiplicity survives.

**$n=1$ and $\mu=0$.** Both must be excluded and neither is excluded in the prose. $n=1$ gives $N=0$ and the whole display is empty. $\mu=0$ is the division. **[ShiftedCensus.lean](../lean/HamiltonsCubic/Results/ShiftedCensus.lean) carries both as hypotheses, `hn1 : n ≠ 1` and `hμ : μ ≠ 0`, and `field_simp` consumes them**, so the Lean statement is the honest one and the prose is the loose one. At the configuration $\mu>0$ by §7, so nothing downstream is at risk. *Recorded as a hypothesis debt, not as a defect.*

## 5. The trace check

$\operatorname{tr}(\omega^2)=-\operatorname{tr}(\omega\omega^{\mathsf T})=-2\langle\omega,\omega\rangle=-2$ at a unit $\omega$. $\operatorname{tr}(-\tfrac2n\mathrm{Id}_{\mathbb R^n})=-2$. An affine combination of matrices of trace $-2$ has trace $-2$ because the weights sum to $1$. **All three CONFIRMED, exactly.**

**And the block's reading of what that means is right.** Taking the trace of the Ricci display gives $-2\sum_Fc_\alpha=\mu(n-1)n=2N\mu$, which is $\sum_Fc_\alpha=-N\mu$, which is trace-freeness. **So the trace of the census returns the hypothesis it was built from and constrains nothing.** The block says exactly this at [line 83](../findings/stratum-two-negative.md#L83) and again at [line 107](../findings/stratum-two-negative.md#L107). CONFIRMED both times.

## 6. $B$ is not on the surface

**First implication.** $\omega^2=-\tfrac2n\mathrm{Id}$ gives $\omega\omega^{\mathsf T}=\tfrac2n\mathrm{Id}$, so $J:=\omega/\sqrt{2/n}$ satisfies $JJ^{\mathsf T}=\mathrm{Id}$ and $J^{\mathsf T}=-J$, hence $J^2=-\mathrm{Id}$: a complex structure, and $\omega$ has rank $n$. **CONFIRMED.**

**Second implication.** $\omega\wedge\omega=0$ iff $\omega$ is decomposable is the Plücker criterion, and it falls out of the normal form: $\omega\wedge\omega=2\sum_{i<j}\sigma_i\sigma_j\,e_{2i-1}\wedge e_{2i}\wedge e_{2j-1}\wedge e_{2j}$ vanishes iff at most one $\sigma_i$ is nonzero. Here $\omega\ne0$, so the rank is exactly $2$. **CONFIRMED.**

**The clash, and where the block's reason is wrong.** At even $n\ge4$ the two give $n=2$, a contradiction, which is the block's argument. **At odd $n$ the block's argument does not run**, there being no rank-$n$ skew matrix at all, so the first component alone is already unsolvable and the second is never reached. Same at $n=3$. *Charitable reading: "full rank" against "rank two" covers odd $n$ too if one reads "full rank" as "rank $n$", which is impossible at odd $n$ for the trivial reason. The words support it and the mechanism is different.* **I record this as a gloss and not a defect.**

**The boundary is exactly $n=2$, and there $B$ IS a point of the surface.** $N=1$, $\omega=e_1\wedge e_2$ is the unit bivector, $\omega^2=-\mathrm{Id}_2=-\tfrac22\mathrm{Id}$, and $\Lambda^4\mathbb R^2=0$ so $\omega\wedge\omega=0$. **So the block's "$n>2$" is sharp.** CONFIRMED.

**And the consequence the block draws is right.** If all points of the census coincided at one $v$, then $B=\Phi(v)$ by $\sum w_\alpha=1$, so $B$ would be on the surface. **The coincident branch, which [L183](../findings/diagonal-half.md) has to carry separately, is excluded here outright.** This is a genuine gain and §12 spends it.

## 7. The sign pattern

**$\mu>0$ at the configuration.** $\mu$ is a positive eigenvalue by construction, and quantitatively $\mu=\sigma_2/(N-3)$ with $\sigma_2=a+b-\lambda_1$ by trace-freeness. $\sigma_2>0$ because $\sigma_2=0$ means $k=1$, which is [Lemma L29](../findings/stratum-two-negative.md#L113)'s one-positive case and is already capped at $\sqrt{3/2}$. At the recorded numbers $\sigma_2=0.19787$ and $\mu=0.0031408$. **CONFIRMED.**

**The signs flip as claimed.** $c_1=\lambda_1-\mu>0$, $c_\alpha=-a-\mu<0$ and $-b-\mu<0$ at the negatives, and $-\mu<0$ at a zero were one present. Dividing by $-N\mu<0$ gives $w_1<0$ and the rest positive. **CONFIRMED as to signs.**

**REFUTED as to the count.** There are three weights, not four, by §11. The check that settles it is the weight sum, which works out exactly and differently in the two readings: at three points $\sum w=\big(\lambda_1-a-b-3\mu\big)/(-N\mu)=(63\mu+3\mu)/(66\mu)=1$, the $63+3=66=N$ being the whole of why it closes. **So $B$ is an affine combination with TWO positive weights and one negative, lying beyond the EDGE opposite $\Phi(v_1)$, and the tetrahedron in the block's heading is a triangle.**

**And the geometric wording needs H8.** "Beyond the face opposite $\Phi(v_1)$" names a face only when the points are affinely independent. Nothing in the block supplies that, and the sign statement survives without it. *Recorded as an unstated hypothesis, not as an error.*

## 8. The isotropy form, its average, and the corollary

**The pairing.** At skew $v$, $x^{\mathsf T}v^2x=-x^{\mathsf T}v^{\mathsf T}vx=-\lvert vx\rvert^2$. Pairing $\sum_Fw_\alpha v_\alpha^2=-\tfrac2n\mathrm{Id}$ against $x$ on both sides gives $-\sum_Fw_\alpha\lvert v_\alpha x\rvert^2=-\tfrac2n\lvert x\rvert^2$, which is the display. **CONFIRMED**, and [ShiftedCensus.lean](../lean/HamiltonsCubic/Results/ShiftedCensus.lean)'s `census_isotropy` is this step typed, at a general $r$ rather than at $-2/n$.

**The average.** Let $v$ be uniform on the unit sphere of $\Lambda^2$, whose measure is $O(n)$-invariant. Then $\mathbb E[v^{\mathsf T}v]$ commutes with the $O(n)$ action on $\mathbb R^n$, hence is a multiple of the identity, and its trace is $\mathbb E[\operatorname{tr}(v^{\mathsf T}v)]=2$. So $\mathbb E[v^{\mathsf T}v]=\tfrac2n\mathrm{Id}$ and $\mathbb E\lvert vx\rvert^2=\tfrac2n\lvert x\rvert^2$. **CONFIRMED**, and the block's gloss "being $\operatorname{tr}(vv^{\mathsf T})/n$" is exactly this computation. So the weighted combination of the four forms equals the average of a single form, at every $x$ rather than on average, which is the block's point and is correct.

**The corollary.** Suppose $x$ lies in the kernel of every positive-weight form. The display then reads $w_1\lvert v_1x\rvert^2=\tfrac2n\lvert x\rvert^2$ with $w_1<0$, so the left side is $\le0$ and the right side is $>0$ unless $x=0$. **CONFIRMED**, and the block's sign bookkeeping, $\lvert w_1\rvert\lvert v_1x\rvert^2=-\tfrac2n\lvert x\rvert^2$, is the same statement.

**This corollary is the strongest line in the block, and §12 shows the block does not spend it.** In its unweighted form it needs neither the flat spectrum nor the barycentre:

> **PROPOSITION (r830).** *Let $W\in\mathcal W_n$ be Ricci-flat with exactly two negative eigenvalues $-a,-b$, eigenvectors $v_{N-1},v_N$, and TRIVIAL KERNEL on $\Lambda^2$. Then $\ker v_{N-1}\cap\ker v_N=0$, hence $\operatorname{rank}v_{N-1}+\operatorname{rank}v_N\ge n$.*

*Proof.* Let $x\in\ker v_{N-1}\cap\ker v_N$. Pairing Ricci-flatness $\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=0$ against $x$ leaves $\sum_{\lambda_\alpha>0}\lambda_\alpha\lvert v_\alpha^{\mathsf T}x\rvert^2=0$, a sum of nonnegative terms with positive coefficients, so $v_\alpha x=0$ for every positive $\alpha$. With the two negatives that is every $\alpha$ of an orthonormal basis of $\Lambda^2$, there being no zero eigenvalue, so $\omega x=0$ at every bivector $\omega$. Take $\omega=xy^{\mathsf T}-yx^{\mathsf T}$ at any $y\perp x$: then $\omega x=-\lvert x\rvert^2y$, so $x=0$. $\square$

**The trivial-kernel hypothesis is not an extra assumption at the configuration**, it is forced by §11. *This is the record's [Lemma L30](../findings/stratum-two-negative.md#L258) read at trivial kernel, and its rank-sum form is exactly the one [line 237](../findings/stratum-two-negative.md#L237) says "misses padded $W_{\mathbb{CP}^2}$ below $n=9$", which is why L30 states its hypothesis invariantly. Here the kernel is trivial, so the two forms agree and the rank sum is available.*

## 9. The identity, at general $n$, and which $\Lambda^4$ inner product it needs

**Derivation.** Put $v$ skew in normal form, $v=\sum_{i=1}^m\sigma_i\,e_{2i-1}\wedge e_{2i}$ with $m=\lfloor n/2\rfloor$ and $\sigma_i\ge0$. Three computations.

1. $\langle v,v\rangle=\tfrac12\operatorname{tr}(v^{\mathsf T}v)=\sum_i\sigma_i^2$, each block contributing $2\sigma_i^2$ to the full trace.
2. On the $i$-th block $v$ acts as $\sigma_iJ$, so $v^4$ acts as $\sigma_i^4\mathrm{Id}_2$ and $\operatorname{tr}(v^4)=2\sum_i\sigma_i^4$.
3. $v\wedge v=2\sum_{i<j}\sigma_i\sigma_j\,e_{2i-1}\wedge e_{2i}\wedge e_{2j-1}\wedge e_{2j}$, a sum over DISTINCT basis elements of $\Lambda^4$, so $\lVert v\wedge v\rVert^2=4\sum_{i<j}\sigma_i^2\sigma_j^2$ in the inner product making those elements orthonormal.

Then $4\sum_{i<j}\sigma_i^2\sigma_j^2=2\big[(\sum_i\sigma_i^2)^2-\sum_i\sigma_i^4\big]$, so

$$\operatorname{tr}(v^4)+\lVert v\wedge v\rVert^2=2\sum_i\sigma_i^4+2\Big(\sum_i\sigma_i^2\Big)^2-2\sum_i\sigma_i^4=2\,\langle v,v\rangle^2 .$$

**True at every skew $v$, in every dimension, odd and even alike**, the odd case differing only in carrying an unpaired zero direction that enters nothing. **CONFIRMED.** *Screen, on objects built for it: the residual is at machine zero at $n=4,5,6,7,8,9$ on random skew matrices, and the screen is reported as a screen. The derivation above is independent of it.*

**Exactly which inner product on $\Lambda^4$.** The one for which $\{e_i\wedge e_j\wedge e_k\wedge e_l\}_{i<j<k<l}$ is orthonormal, with the wedge normalised so that $e_{12}\wedge e_{34}=e_{1234}$. In components that is

$$(\omega\wedge\omega)_{ijkl}=2\big(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk}\big),\qquad \lVert\omega\wedge\omega\rVert^2=\sum_{i<j<k<l}(\omega\wedge\omega)_{ijkl}^2=\tfrac1{24}\sum_{ijkl}(\omega\wedge\omega)_{ijkl}^2 .$$

**[PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) commits to exactly this and its two theorems pin it independently**: at $\dim4$ it is $4\,\mathrm{Pf}(\omega)^2$, and at $\dim6$ it is $4\sum_{i<j<k<l}\texttt{w4}^2$ over all fifteen index sets with `w4` the principal $4\times4$ Pfaffian, which is $(\omega\wedge\omega)_{ijkl}/2$. So the file's `4` is the same `4` twice and the constant is checked by the kernel at two dimensions.

**And it is NOT [conventions.md](../findings/conventions.md) line 124's rule.** That rule is $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$, pinned by $\lVert\star\rVert^2=6$ at $\star_{ijkl}=\epsilon_{ijkl}$ and by $\delta^2(W_{\mathbb{CP}^2})=\tfrac19$. Applied to the same component array it is **six times larger**:

$$\lVert\omega\wedge\omega\rVert^2_{\text{identity}}=6\,\big\lVert\mathrm{Alt}(\omega\otimes\omega)\big\rVert^2_{\text{line 124}},\qquad \omega\wedge\omega=6\,\mathrm{Alt}(\omega\otimes\omega)\ \text{as arrays}.$$

*Both are right in their own places: line 124 measures $\mathrm{Alt}(R)$ INSIDE $S^2(\Lambda^2)$, where $\star$ has norm$^2$ six, and the identity measures $\omega\wedge\omega$ as an element of $\Lambda^4$ with the multi-index basis orthonormal.* **The record holds two $\Lambda^4$ norms differing by $\sqrt6$ and does not say so anywhere**, and [diagonality.md](../findings/diagonality.md) is right to have flagged the question as OWED. **It is settled here in favour of the multi-index norm for everything $\Phi$ touches.**

**Whether the record's numerals use it: YES, and on the FROBENIUS unit sphere.** The recorded Plücker certificates are $0.61$, $0.63$, $0.50$ at $\mathbb{CP}^4$, $\mathbb{CP}^5$ and padded $W_{\mathbb{CP}^2}$. At a Kähler line the minimiser is $\omega\propto J$ on $\mathbb R^{2m}$, and the identity gives, in closed form,

$$\lVert\omega\wedge\omega\rVert^2=2-\tfrac2m\ \text{at record-unit }\omega,\qquad \lVert\omega\wedge\omega\rVert^2=\tfrac12-\tfrac1{2m}\ \text{at Frobenius-unit }\omega,$$

since $\lVert\omega\rVert_F^2=2\lVert\omega\rVert^2$ and the wedge is quadratic. The second column reads $0.5$ at $m=2$, $0.6124$ at $m=4$ and $0.6325$ at $m=5$. **Three matches to the printed precision, against a first column of $1.0000$, $1.2247$ and $1.2649$ which matches none.** So the numerals use the identity's $\Lambda^4$ inner product and the Frobenius normalisation of $\omega$. *This is a match rather than a recomputation of the record's eigenvectors, which I did not do, and three coincidences at three different $m$ is not a coincidence.*

**Which makes [diagonality.md](../findings/diagonality.md)'s own consistency check a false positive, and I record that as a defect.**

- **Located.** [findings/diagonality.md](../findings/diagonality.md), the second box: *"The recorded values are consistent with it, $0.5$ at padded $W_{\mathbb{CP}^2}$ needs $\sum\sigma_i^4=0.875$, inside $[\tfrac13,1]$, but a range check is not the constant."*
- **The failure, in closed form.** The eigenvector concerned lies in the $2$-dimensional $-1/\sqrt6$ eigenspace of padded $W_{\mathbb{CP}^2}$, which is a $2$-plane inside $\Lambda^+\mathbb R^4$. Every element of $\Lambda^+\mathbb R^4$ has $\sigma_1=\sigma_2$, so at record-unit norm $\sigma_1=\sigma_2=1/\sqrt2$ and $\sum\sigma_i^4=\tfrac12$, giving $\operatorname{tr}(\omega^4)=1$ and $\lVert\omega\wedge\omega\rVert=1$. **The value $\sum\sigma_i^4=0.875$ is not attained by any element of that eigenspace**, so the check that "$0.875$ lies inside the range" passed on a number the configuration cannot produce. The interval is also wrong at $n=12$, where it is $[\tfrac16,1]$ and not $[\tfrac13,1]$.
- **Argued the opposite.** The most charitable reading is that the box is checking only that SOME unit bivector could produce $0.5$, which is true and is what "a range check is not the constant" concedes. **Under that reading the box is honest and uninformative, and it still asserts "the recorded values are consistent with it" on the strength of it.** The consistency is real, for a different reason: the numerals are on the Frobenius sphere. *The correction is to the reason, and it converts an OWED into a settled fact, so it is worth making.*

**And the block's sphere radius is untouched.** $\lVert\Phi(v_\alpha)\rVert^2=\operatorname{tr}(v_\alpha^4)+\lVert v_\alpha\wedge v_\alpha\rVert^2=2\langle v_\alpha,v_\alpha\rangle^2=2$ at record-unit eigenvectors, which is the normalisation $W$'s spectral decomposition is written in. $\lVert B\rVert^2=n\cdot(2/n)^2=4/n<2$ at $n>2$. **CONFIRMED, both, and the $n=2$ boundary agrees with §6.**

## 10. The Plücker consequence

**$\min\lVert\omega\wedge\omega\rVert^2=2-\max\operatorname{tr}(\omega^4)$ over a unit sphere.** Immediate from the identity at $\langle\omega,\omega\rangle=1$: the two quantities sum to the constant $2$ pointwise, so minimising one is maximising the other, on any subset of the sphere whatever. **CONFIRMED.**

**$\lVert\omega\wedge\omega\rVert=0$ iff $\omega$ is decomposable.** From the normal form, $\lVert\omega\wedge\omega\rVert^2=4\sum_{i<j}\sigma_i^2\sigma_j^2$ vanishes iff at most one $\sigma_i$ is nonzero, which is rank $\le2$, which is decomposability. **CONFIRMED**, and [diagonality.md](../findings/diagonality.md)'s claim that this "falls out of the identity rather than being imposed alongside it" is right: $\operatorname{tr}(\omega^4)=2\sum\sigma_i^4$ is maximal on the unit sphere exactly when one $\sigma$ carries all the mass.

## 11. Three points or four: the block's principal defect

**Located.** [findings/stratum-two-negative.md line 65](../findings/stratum-two-negative.md#L65): *"So at $n=12$ the spectrum is $\lambda_1$, a value $\mu$ of multiplicity $62$, two negatives and one zero"*, and the same sentence's *"writing $F$ for the four exceptional eigenvectors"*. The same count is in [ShiftedCensus.lean](../lean/HamiltonsCubic/Results/ShiftedCensus.lean), whose docstring says *"one value `μ` of multiplicity `N - 4` together with four others"* and whose theorem is indexed by `Fin 4`.

**The failure, in closed form.** The block's own preceding sentence puts $\sigma_2^2/p_2$ at the ceiling $N-3=63$. By §1 that forces exactly $63$ strictly positive non-top eigenvalues, all equal. With the two negatives that is $1+63+2=66=N$ eigenvalues accounted for. **There is no room for a zero.** So $\lvert F\rvert=3$, the multiplicity is $N-3=63$ and not $N-4=62$, and $W$ has TRIVIAL KERNEL on $\Lambda^2$.

**The numbers confirm the count and separate the two readings.** At the argmax, $\sigma_2=0.1978700$ and $p_2=6.2153\times10^{-4}$. A flat block of $63$ equal values gives $\sigma_2^2/p_2=63$ and $p_2=63\mu^2=6.2147\times10^{-4}$ at $\mu=\sigma_2/63$. A flat block of $62$ gives $\sigma_2^2/p_2=62$ and $p_2=62\mu^2=6.3149\times10^{-4}$, wrong by $1.6\%$ and, more to the point, **incapable of reaching the ceiling the configuration is defined by**. *Screen on the two readings, and the closed-form argument above is what carries it.*

**Argued the opposite, three ways, and all three fail.**

1. *Perhaps the ceiling counts nonnegative rather than positive eigenvalues, so a zero may sit among the $63$.* Then Cauchy–Schwarz over those $63$ terms is still $\sigma_2^2\le63p_2$, and equality still forces all $63$ EQUAL, so a zero among them makes all of them zero and $\sigma_2=0$. **Fails.**
2. *Perhaps the ceiling is approached and not attained, leaving $62$ positives and one zero with ratio just under $62$.* The recorded ratio is $63$, and $62<63$. **Fails.**
3. *Perhaps the block means $F$ to include a zero eigenvector chosen arbitrarily from a degenerate eigenspace.* There is no kernel to choose from. **Fails.**

**What the correction does to the rest of the block.** The barycentre, the trace check, $B$, the isotropy form and the sphere are all unaffected, $\sum_Fc_\alpha=-N\mu$ holding at every $\lvert F\rvert$ by §4. What changes is the geometry: a triangle rather than a tetrahedron, an edge rather than a face, two positive weights rather than three, and, decisively, **the paragraph at [line 101](../findings/stratum-two-negative.md#L101) is exactly inverted.** It reads *"THE CENSUS IS ON THREE POINTS WHEN $W$ HAS NO KERNEL ON $\Lambda^2$, AND FOUR WHEN IT DOES ... which case holds is a question with a standing answer elsewhere rather than a new one."* **The case is settled by the configuration's own defining equality, on the spot, and it is the three-point one.** The block presents four as the main case and three as a conditional aside.

**The Lean layer inherits it.** `barycentre_of_shifted_census` is TRUE as stated, being a module-theoretic identity over `Fin 4` whose hypotheses are handed to it, and the identical proof runs over `Fin 3`. **What is wrong is the docstring's description of the configuration and the index type it chose**, and the theorem's hypotheses are never shown to be inhabited by anything.

## 12. The cost claim, argued the opposite

**Located.** [line 105](../findings/stratum-two-negative.md#L105): *"At four points the conditions are WEAKER, an affine target rather than the origin, and one more free form, so it is harder rather than easier"*.

**REFUTED, on four counts.**

**(a) There is no extra free form.** By §11 the census is on three points, which is [L183](../findings/diagonal-half.md)'s own count. The clause "one more free form" has no referent.

**(b) The shift is bookkeeping, not new data.** $\sum_\alpha v_\alpha^2=-(n-1)\mathrm{Id}$ over any orthonormal basis, by §3, so the affine target is $\mu(n-1)\mathrm{Id}=-\mu\sum_\alpha v_\alpha^2$ and the shifted equation is the unshifted $\sum_\alpha\lambda_\alpha\Phi(v_\alpha)=0$ with the flat part collected. **Nothing is lost or gained in the move**, and in particular the shifted census is not a weakening of a homogeneous problem, it is the same problem written at three points instead of $N$.

**(c) The affine target is strictly more rigid than the origin.** L183's condition is homogeneous in the weights, so its solutions come in rays and the weights are determined only up to scale, which is why L183 states its conclusion as collinearity. **The shifted condition names a point**, so the weights are absolutely determined by the three images whenever those are affinely independent, and with them the whole spectrum. It also excludes the coincident branch outright by §6, which is a case L183 has to carry separately. **Fewer branches and more rigidity is easier, not harder.**

**(d) And the configuration is dead already, in two lines, against a lemma in the same file.** This is the substantive point and the block misses it.

> **COROLLARY (r830).** *No Weyl tensor attains the chain's supremum at any $n>4$.*

*Proof.* Let $W$ attain it. By §1 and §11 its spectrum is $\lambda_1$, $\mu$ of multiplicity $N-3$, and $-a,-b$, with no kernel on $\Lambda^2$. By §8's Proposition, $\ker v_{N-1}\cap\ker v_N=0$. Attaining the chain's value also requires its dominant $(+--)$ term to be tight, and that term is bounded through $\sum_\gamma T_{N-1,N,\gamma}=\lVert[v_{N-1},v_N]\rVert^2\le2$, so tightness forces $\lVert[v_{N-1},v_N]\rVert^2=2$. **[Lemma L31](../findings/stratum-two-negative.md#L473) then gives $\operatorname{im}v_{N-1}=\operatorname{im}v_N$ of dimension four**, so $\ker v_{N-1}=\ker v_N$ of dimension $n-4>0$. Contradiction. $\square$

*I re-derived L31's forward half rather than taking it: the eigenvalues of $\mathrm{ad}_X$ on $\mathfrak{so}(n)$ at $X=\sum_jc_j\varepsilon_j$ are $\pm i(c_j\pm c_k)$ and $\pm ic_j$, so $\lVert\mathrm{ad}_X\rVert_{\rm op}=c_1+c_2$ at the top two, and $c_1+c_2\le\sqrt{2(c_1^2+c_2^2)}\le\sqrt2$ at $\sum_jc_j^2=1$ with equality iff $c_1=c_2=1/\sqrt2$ and the rest vanish, which is rank four. That is L31's rank clause and it also re-proves the cap the whole chain rests on.*

**This is not new to the record and the block does not cite it.** [Line 237](../findings/stratum-two-negative.md#L237), dated 2026-08-24, already says: *"the chain reaches that overshoot only when its dominant term $(+--)$ is near-tight, which needs $\lVert[v_{N-1},v_N]\rVert^2$ near its cap $2$, which is attained exactly at rank $4$ for both eigenvectors, giving rank sum $8<12$"*, and calls the result **"This refutes the configuration that was blocking B0"**. The block is dated 2026-09-10 and sits 170 lines above it in the same file. **What the census adds is that at the equality case the argument needs no "near" and no quantitative version**: the trivial kernel is forced, so the common kernel is exactly empty against L31's exactly $n-4$, and the two statements collide at every $n>4$ rather than at $n\ge9$.

**What that does NOT do, stated so nobody over-reads it.** It kills the argmax, not the stratum. [Line 256](../findings/stratum-two-negative.md#L256), same date, already records why: with the count ceiling cut from $N-3$ to $N-n-2$ the chain still returns $1.226264$, and **"the chain still overshoots at $52$"**. So the overshoot is not caused by the count and removing the argmax leaves the bound where it was. *The block's own closing sentence, that this "confirms rather than repairs", is right about the STRATUM and wrong about the CONFIGURATION.*

## 13. The $\dim V=6$ claim

**What the count is.** $M$ is orthonormal triples in $\Lambda^2\mathbb R^6\cong\mathfrak{so}(6)$ times the unit traceless weight circle, of dimension $39+1=40$. $G=O(6)$, of dimension $15$. $F=\big(\sum_i\lambda_i\omega_i^2,\sum_i\lambda_i\omega_i\wedge\omega_i\big)$ lands in $S^2_0(\mathbb R^6)\oplus\Lambda^4\mathbb R^6$ of dimension $20+15=35$. At a trivial stabiliser the orbit is $15$ and $\dim(M/G)=25$, against $35$, for an expected deficit of ten. **The arithmetic is right.**

**"The branch IS the principal stratum" is loose and harmless.** Every solution having trivial stabiliser gives CONTAINMENT of the branch in the free stratum, not equality with it, and containment is all the count needs. *The free stratum is open in $M$ and of dimension $40$, so its quotient is $25$-dimensional, and a finite non-trivial stabiliser would make the quotient an orbifold without changing the dimension.* **Recorded as wording.**

**The premise is unaudited, which the file says two boxes earlier and the quoted block does not repeat.** [findings/diagonal-half.md](../findings/diagonal-half.md#L810) says of the closure that supplies "every solution at $\dim V=6$ now has trivial stabiliser": *"THAT CLOSURE IS A REVIEWER'S OWN DERIVATION AND IS UNAUDITED ... it is cited as r827's and not as the record's."* **The quoted block turns that into "now has", with no hedge**, and it is the sole load-bearing input. *Charitable reading: the block says "A count that survives its own objection is still a count", so it is hedging the conclusion. It does not hedge the premise, and the premise is the part on someone else's footing.*

**What would have to be true of the constraint map for the count to be exact there.** This is the brief's question and it has a sharp answer.

- A dimension count predicts emptiness when the descended section $s$ of the rank-$35$ bundle $E=M_{\rm free}\times_G\mathbb R^{35}$ over the $25$-manifold $M_{\rm free}/G$ is TRANSVERSE to the zero section. **For that to hold one needs $\operatorname{rank}ds_q=35$ at every zero $q$, which is impossible on a $25$-dimensional base.** So transversality at a solution cannot hold, and transversality on the whole base is EQUIVALENT to there being no solutions.
- **The count is therefore not a statement that can be checked at a solution and then applied.** What it says is that a GENERIC equivariant section of that bundle has empty zero set. Exactness would need this particular algebraic section to be generic in that sense, which is a statement about the ideal generated by the $35$ polynomials on the $25$-dimensional quotient, and that is precisely the emptiness being predicted.
- **So the honest form of the conclusion is: the count is a prediction whose hypothesis is its conclusion.** [r827](REVIEW_r827.md)'s counterexample shows the count CAN be exact on a principal stratum, which refutes the principle that a failure on one stratum kills it elsewhere. It does not show that it MUST be, and the quoted block reads "exactly where r827's counterexample found the count exact" as if one example settled the general case.

**Verdict: PARTIALLY CONFIRMED, OVERSTATED TWICE.** The scope claim is right, the arithmetic is right, the premise is on r827's footing rather than the record's, and "found the count exact" is one example rather than a criterion. **The block's own final clause is the right one and should be the whole of it**: it predicts and does not prove, and it now points the same way as the census. *The census is what carries this, and [diagonal-half.md line 800](../findings/diagonal-half.md#L800) already says so in as many words.*

## 14. What would falsify the block, and what I did to look for it

Six falsifiers, each with what I did.

1. **A Weyl tensor at $n=12$ with two negative eigenvalues, $63$ equal positives and $\theta>\sqrt{3/2}$.** This would make the configuration realisable and the census vacuous. *I did not search for one, the standing rule forbidding it, and §12 shows one cannot exist: the equality case is contradictory at every $n>4$.*
2. **The equality step failing, so that the structure statement is empty.** *Checked by hand in §1, and the constraint is active at the argmax, so the equality case is exactly the argmax. The step survives.*
3. **$B$ lying on the surface at some $n>2$, restoring the coincident branch.** *Checked in §6 by the rank clash at even $n$ and by the non-existence of odd-dimensional complex structures at odd $n$. Only $n=2$.*
4. **The identity failing at odd $n$ or above the two dimensions Lean checks.** *Derived at general $n$ in §9 from the singular-value normal form, and screened at $n=4,5,6,7,8,9$ with the residual at machine zero.*
5. **A $\Lambda^4$ normalisation mismatch making $\lVert\Phi\rVert^2\ne2$ and the sphere wrong.** *Two candidate norms found in the record, differing by $\sqrt6$. §9 settles which the identity needs, shows [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) commits to it at two dimensions, and matches the record's own three numerals against it exactly. The sphere radius survives. [diagonality.md](../findings/diagonality.md)'s consistency check does not.*
6. **The census having a solution, exhibited.** *This is what would make the block's "the inequalities all pass" the last word. I looked for it by hand at the three-point form: the Ricci display $(a+\mu)v_2v_2^{\mathsf T}+(b+\mu)v_3v_3^{\mathsf T}=\mu(n-1)\mathrm{Id}+(\lambda_1-\mu)v_1v_1^{\mathsf T}$ has a positive-definite right side and a rank-$\le\operatorname{rank}v_2+\operatorname{rank}v_3$ left side, which is where §8's Proposition comes from, and I found no closed-form solution and no second obstruction beyond it. The trace, the norm and the top-eigenvalue pairing all pass, which is the block's own observation and is correct.*

**And the block's own three numerical checks are wrong**, which I record as one defect with three heads, all at [line 107](../findings/stratum-two-negative.md#L107).

- *"$62\mu=a+b-\lambda_1\approx0.175$ gives $\mu\approx0.0028$"*. The multiplicity is $63$ and $a+b-\lambda_1=0.19787$ at the argmax's own $a=b=\sqrt2/3$, so $\mu=0.0031408$. The $0.175$ comes from the rounded $a=b=0.46$, which does not satisfy the norm constraint at $p=5/9$.
- *"the left side's trace $2(3\mu+a+b)\approx1.86$"*. **The left side of the Ricci display is $\sum_F(\mu-\lambda_\alpha)v_\alpha v_\alpha^{\mathsf T}$, whose trace is $2\sum_F(\mu-\lambda_\alpha)=2\big(\lvert F\rvert\mu+\sigma_2\big)$**, the $-\lambda_1$ being omitted in the block's expression. At $\lvert F\rvert=3$ that is $2(3\mu+\sigma_2)=0.41458$, which equals $n(n-1)\mu=132\mu$ exactly, as it must, the two traces being the same number. **The block's $1.86$ is over four times the true value.** The comparison it is used in, a smallest eigenvalue against a trace, tests nothing in either case.
- *"$B$ is one point of a space of dimension $\binom n2+\binom n4$"*, at [line 81](../findings/stratum-two-negative.md#L81). The ambient space is $S^2(\mathbb R^n)\oplus\Lambda^4\mathbb R^n$, of dimension $\binom{n+1}2+\binom n4$, which is $78+495=573$ at $n=12$ against the block's $66+495=561$. **$\binom n2$ is $\dim\Lambda^2$, not $\dim S^2$.**

*Argued the opposite on all three. The first is a rounding chain rather than an error of derivation and changes no conclusion. The second cannot be read as anything but the trace of the display it names. The third could be a restriction to trace-free symmetric matrices, which is $\binom{n+1}2-1=77$ and still not $66$.* **The second and third stand as defects, the first as a consequence of §11's count.**

## Verdict

**CONFIRMED, in the mathematics that carries the census.** Items 2, 3, 4, 5, 8, 9 and 10 are correct as stated, and item 9 is the strongest of them: the identity is true at every skew $\omega$ in every dimension, the $\Lambda^4$ inner product it needs is now named, and the record's own Plücker numerals are shown to use it. Item 1 is correct and sharper than the block claims, the ceiling being active at the argmax.

**REFUTED, in the structure and the conclusion.** The equality case has no zero eigenvalue, so the census is on THREE points with trivial kernel on $\Lambda^2$, not four with a kernel, and [ShiftedCensus.lean](../lean/HamiltonsCubic/Results/ShiftedCensus.lean) carries the same off-by-one in its docstring and its index type. The cost claim is refuted on four counts. **And the block's closing verdict is refuted on the configuration**: the census it builds, together with [Lemma L31](../findings/stratum-two-negative.md#L473) from the same file, shows that no Weyl tensor attains the chain's supremum at any $n>4$, which the record had already reached by another route on 2026-08-24 and which the block neither cites nor supersedes.

**What to do with it.** Rewrite the block at three points, delete the zero eigenvalue and the tetrahedron, replace "the inequalities all pass" with the corollary of §12, cite [line 237](../findings/stratum-two-negative.md#L237) and [line 256](../findings/stratum-two-negative.md#L256) so the reader learns that killing the argmax leaves the overshoot untouched, and retype the Lean file over `Fin 3`. **The one thing in the block worth promoting to a numbered result is §9's identity with its inner product named**, which settles a standing OWED in [diagonality.md](../findings/diagonality.md) and costs nothing.

**On the $\dim V=6$ claim: PARTIALLY CONFIRMED.** The count's scope claim survives, its premise is unaudited, and no count is exact at a solution. It predicts, and the census is what carries the conclusion.
