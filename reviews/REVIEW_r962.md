# Review r962, Gate 2 on batches 32 and 33 of the I106 derivation, and post F69

Reviewer **r962**, adversarial Gate 2 auditor, cold brief [BRIEF_I106_batches32_33.md](BRIEF_I106_batches32_33.md).
Log: [agent_logs/r962-batches32-33.log](../agent_logs/r962-batches32-33.log).

Worked from the brief's definitions and this reviewer's own derivations. No script under review was read or run. Every symbolic identity below was checked on GENERIC traceless symmetric $\hat U$, $V$ and generic skew $\Omega$ with the Lagrange forms carrying their own multiples of $I$ as free symbols, and the criticality system was rederived from scratch as $[A,C]=0$ rather than taken from the record.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $[\hat U,V^2]=\{V,K\}$, and $[\hat U,A]=-\beta\{V,K\}$ for the $A$ Lagrange form | **CONFIRMED** |
| 2 | $[\hat U,\beta V^2+A]=0$ at every critical point, so batch 7's condition is an identity | **CONFIRMED**, with a scope narrowing |
| 3 | Post F69's test is correct as stated, and its scope is not overreach | **PLAUSIBLE**, the test is right and two sentences around it overreach |
| 4 | The orbit preserves both norms and the internal part, so the curve lies in the constraint set | **CONFIRMED**, and stronger than the block states |
| 5 | $X=[\Omega,\hat U]$, $Y=[\Omega,V]$ is traceless symmetric and satisfies the tangency form identically | **CONFIRMED** |
| 6 | First order along the orbit is $[\hat U,A]+[V,C]=0$, an identity under the Lagrange forms | **CONFIRMED** |
| 7 | $Q(\Omega)$ has the displayed form, is not identically zero, and the multiples of $I$ drop out | **CONFIRMED** |
| 8 | $Q(\Omega)\ge0$ equals batch 21's inequality at the orbit direction, exactly | **CONFIRMED** |
| 9 | $Q\ge0$ is equivalent to a lower bound on $\mu$, a generalised eigenvalue | **CONFIRMED**, with one word to fix |
| 10 | The table's four rows, and the conclusion that the orbit bound excludes nothing new | **REFUTED in part**, every NUMBER reproduces, one VERDICT and the summary clause built on it are wrong |

## The refutation, row two of batch 33's table

**Row two records "orbit CLEARS it, and is weaker than both" at $\mu=-24.43870$ against an orbit threshold of $-12.529$. The point fails that threshold.** The orbit condition is $\mu\ge\lambda_{\max}$, and $-24.43870<-12.52940$, so the orbit bound EXCLUDES this point exactly as batches 18 and 21 do.

Verified three ways rather than by reading the inequality off the table. The generalised eigenproblem at that point returns $\lambda_{\max}=-12.52940$, reproducing the recorded figure. The top eigenvector, normalised so that $3\lvert[\Omega,\hat U]\rvert^2+\lvert[\Omega,V]\rvert^2=1$, gives $Q(\Omega)=\mu-\lambda_{\max}=-11.90930$, strictly negative, so the second-order condition is violated at an explicit direction. And $Q$ evaluated from the Lagrange forms as $\operatorname{tr}([\Omega,\hat U][\Omega,A])+\operatorname{tr}([\Omega,V][\Omega,C])$ agrees with $\mu N-R$ at that direction.

**A number could not replace an argument here**: the sign of $\mu-\lambda_{\max}$ at one recorded point is the whole question, and it costs one $3\times3$ generalised eigenproblem.

**What this changes, and what it does not.** All four points now behave identically under all three bounds: three excluded by each, one cleared by each. The block's headline conclusion, that the orbit bound excludes nothing the record did not already exclude, survives intact and is in fact cleaner than the block claims, since the exception it reports does not exist. What must go is the row-two verdict and the clause *"and at one point it is strictly weaker"* insofar as it asserts a failure to exclude. The threshold $-12.529$ IS numerically lower than $9.3675$ and $15$, so a rewrite can keep that observation if it says only that, and must not attach a clearance to it.

## What the block gets right, checked independently

**Claims 1, 2, 5, 6, 7 and 8 all reduce to zero symbolically on generic matrices.** $[\hat U,V^2]-\{V,K\}=0$, $[\hat U,A]+\beta\{V,K\}=0$, $[V,C]-\beta\{V,K\}=0$, $[\hat U,A]+[V,C]=0$, $X$ and $Y$ symmetric and traceless, $3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)=0$, and $Q$ equal to the block's displayed decomposition and to $\mu N-R$ alike. Differentiating $Q$ in each of the two free $I$-coefficients gives zero, so the block's "the multiples of $I$ drop out" is checked rather than assumed. $Q$ at a rational sample point is $122\mu+126$, so it is not identically zero.

**Claim 8 is exact, and the step that makes it work is worth recording.** Expanding $[\Omega,V^2]=\{Y,V\}$ and $[\Omega,\{\hat U,V\}]=\{X,V\}+\{\hat U,Y\}$ leaves $2\operatorname{tr}(XYV)+2\operatorname{tr}(XVY)+2\operatorname{tr}(\hat UY^2)$, which becomes batch 21's $4\beta\operatorname{tr}(XVY)+2\beta\operatorname{tr}(\hat UY^2)$ only because reversal symmetry gives $\operatorname{tr}(XYV)=\operatorname{tr}(XVY)$ for three symmetric matrices. **So batch 33 is a specialisation of batch 21 and not new mathematics, as the block itself says.**

**Claim 4 holds exactly, and the block understates it.** Over $t\in[-1,1]$ with the exact matrix exponential, $T$, the internal part, $\lvert\hat U\rvert$ and $\lvert V\rvert$ all drift at $10^{-16}$ to $10^{-15}$. The brief's worry about an acceleration contribution does not arise: writing $\hat U(t)=e^{t\Omega}\hat Ue^{-t\Omega}$ gives $\ddot{\hat U}(0)=[\Omega,[\Omega,\hat U]]$, and $\operatorname{ad}_\Omega$ is anti-self-adjoint for the trace form, so $\operatorname{tr}(\ddot{\hat U}A)=-\operatorname{tr}([\Omega,\hat U][\Omega,A])$ and $\ddot\Phi(0)=-Q(\Omega)$ **with the acceleration term retained, not dropped**. Confirmed numerically to $4\times10^{-7}$ by central difference. **Batch 21's justification for discarding the acceleration, which does assume a critical point, is therefore not needed for the orbit at all**, and the orbit's second-order inequality holds at any local maximum whether or not criticality is invoked. This is a strengthening the record should take.

**Claim 6's contrast is real.** With generic symmetric fields the first-order pairing $\operatorname{tr}(\Omega([\hat U,A_g]+[V,C_g]))$ evaluates to $-2.70$ at a random sample, so the collapse is caused by the substitution.

**Claim 9 needs one word.** $Q\ge0$ for all $\Omega$ is equivalent to $\mu\ge\lambda_{\max}(R,N)$ only where $N\succ0$. $N(\Omega)=0$ exactly when $\Omega$ generates a common infinitesimal symmetry of $\hat U$ and $V$, and there $X=Y=0$ forces $R(\Omega)=0$ too, so the degenerate directions are harmless and the pencil is read on the quotient. The block's "the $\mu$ term is a positive multiple of $\mu$" should read **nonnegative**, strictly positive off that kernel. At all four table points $N$ is positive definite, its smallest eigenvalue running from $27.6$ to $4.1\times10^5$.

## Which numbers reproduced, one by one

The round's warning was that two figures had been recorded at twice their size. **Every number in the audited table reproduced at its recorded value**, from an independently derived criticality system.

| quantity | recorded | reproduced | route |
|---|---|---|---|
| batch 28's $(1,2)$ equation | $a_1D_2=a_2D_1$ | yes, $E_{01}=-\tfrac{81w^2}{16}(a_1D_2-a_2D_1)$ | own $[A,C]=0$ |
| batch 29's quadratic $c_2,c_1,c_0$ | as quoted | yes, up to the factor $9(u_1-u_2)$ | elimination of $a_1,a_2$ |
| $\mu$ roots at $(3,1,-4)$ | $-6.06130$, $-24.43870$ | yes | own quadratic |
| $\mu$ roots at $(19,-20,1)$ | $5.61547$, $762.38453$ | yes | own quadratic |
| $(a_1,a_2)$ at the four roots | $\pm(1.58669,2.22137)$, $\pm(11.77482,16.48475)$, $\pm(46.9168,40.2144)$ | yes, including the sign pair | back-substitution |
| $\lVert K\rVert$ at $(19,-20,1)$ | $39.1152$ | yes, $\sqrt{2(18^2+21^2)}=\sqrt{1530}$ | by hand |
| batch 18 column | $9.3675$, $50.7124$ | yes, $\tfrac92\lvert\hat U\rvert/\sqrt6$ at $\lvert\hat U\rvert^2=26,762$ | by hand |
| batch 21 column | $15$, $75$ | yes, $\alpha\lvert u_{\min}\rvert$ | by hand |
| orbit column | $11.274$, $-12.529$, $97.950$, $105.693$ | yes, $11.27393$, $-12.52940$, $97.95009$, $105.69267$ | own pencil |

**The withdrawn figures are consistent with the record's account of its own slip.** Doubling this reviewer's $\lambda_{\max}$ at $(3,1,-4)$ gives $22.54785$ and $-25.05880$, which are the $22.548$ and $-25.059$ the record says were first filed. **One note on how that slip could recur**: the ratio $R(\Omega)/N(\Omega)$ is insensitive to a factor applied to BOTH forms, so a halving error is only visible when the two forms are built by different routes, which is exactly what the record reports happened.

**Two things the criticality system settled that the brief did not ask for.** The system $[A,C]=0$, rederived here without reference to the record, reproduces batches 28 and 29 exactly, which is independent support for both. And the two $a$-branches are related by $V\mapsto-gVg^{\mathsf T}$ with $g=\operatorname{diag}(1,1,-1)$, which fixes $\hat U$, so they give the same $R$, $N$ and $\lambda_{\max}$ and the sign pair costs nothing.

## Batch 32 and post F69, where the reach is too long

**The identity is right and the framing around it is too strong.** Substituting batch 10's form gives $\beta V^2+A=3\mu\hat U-3\alpha\hat U^2+cI$, **a polynomial in $\hat U$**, so the commuting condition is not merely an identity, it could not have been anything else. Batch 32's derivation is correct.

**But batch 7's maximiser statement carries more than its commuting corollary, and what it carries is batch 21's bound.** A maximiser of $\psi$'s inner problem is defined up to conjugation by a permutation matrix, which preserves $\lvert U\rvert$, $\operatorname{tr}U^3$ and $M$ while repairing the pairing of the two spectra. So a maximiser must pair them to maximise $\sum_iu_im_i$, and the rearrangement inequality forces $u$ and $m$ to be similarly ordered. With $m_i=3\mu u_i-3\alpha u_i^2$ this reads
$$(u_i-u_j)(m_i-m_j)=3(u_i-u_j)^2\big(\mu-\alpha(u_i+u_j)\big)\ \ge\ 0,$$
so $\mu\ge-\alpha u_k$ at every pair with $u_i\ne u_j$, **which is batch 21's bound recovered from batch 7 by a route that never touches the second variation**. Screened on 300 random $(p,M)$ pairs with no ordering violation, and at the record's own four points the condition fails at three and holds at $(19,-20,1)$, $\mu=762.38453$, matching batch 21's column.

**So the honest statement is narrower than the record's.** *Batch 7's COMMUTING corollary is criticality restated.* Batch 7's maximiser statement is not vacuous, it is redundant, which is a different verdict: it reproduces a bound the record already has rather than carrying nothing. And [post F69](../findings/fence-posts.md)'s opening line, which names the refuted claim as *"that batch 7 supplies a maximality input"*, should name the commuting corollary instead, since batch 7 also supplies the value formula $\sup_{\hat U}\Phi=\psi(\beta V^2+A)+\operatorname{tr}(VC)$, which F69's own closing sentence expressly admits as a genuine input.

**On F69's reach, the brief's fifth line of attack.** A condition on $A$ and $C$ that is emphatically not criticality restated is already load-bearing in this derivation: **$[A,C]=0$, the standing hypothesis that the two fields are diagonal in one frame**. Substituting both Lagrange forms leaves the three equations batches 28 and 29 solve, not an identity. So F69 would be false if read as "a condition on the fields is vacuous" and is correct as written, which is "a condition on the fields is TESTED by substituting the field's own form". The wording in the fence post is already the safe one. The sentence in batch 32's block is the safe one too. Only F69's headline needs narrowing.

**Batch 7's "diagonal in any eigenframe of it" is loose and should be softened to "in a common eigenframe".** Where $\mu=-\alpha u_k$ with $u_i\ne u_j$, the matrix $3\mu\hat U-3\alpha\hat U^2$ has a repeated eigenvalue while $\hat U$ is non-scalar on that eigenspace, so an arbitrary eigenframe of it fails to diagonalise $\hat U$. This is a phrasing defect in batch 7, and it costs batch 32 nothing, since the commuting reading is the one batch 32 tests and is the true content.

## Whether the negative conclusion overreaches, the brief's sixth line

**Split it in two, because one half is a theorem and the other is four points.**

- **Against batch 21's FULL second-order condition the conclusion is proved, not sampled.** Claim 8 says the orbit direction is one admissible $(X,Y)$ in batch 21's quantifier, so the orbit condition is implied by batch 21's condition at every configuration whatever. It can never exclude a point batch 21 does not. **This deserves to be stated as the reason, in place of the table.**
- **Against batch 21's RECORDED corollary $\mu\ge\alpha\lvert u_{\min}\rvert$ and batch 18's bound, the comparison is empirical**, four points at two spectra on the single sub-stratum $w_3=0$, $w_1=w_2=1$, and should say so. It is a screen, and the block is entitled to it as one.

**The block also undersells its own bound.** At $(19,-20,1)$ the orbit threshold is $97.950$ and $105.693$ against $75$ and $50.7124$, so at two of the four points it is **the strongest of the three**, and it still fails to exclude the surviving point. That is the informative reading, and it is more damaging to the lever than the "strictly weaker" sentence the block leads with.

## The Lean declarations

**Checked as statements against the block's words, without treating a build as evidence.**

- [orbit_first_order_vacuous](../lean/HamiltonsCubic/Results/I106Criticality.lean) types $[\hat U,A]+[V,C]=0$ under `Afield` and `Cfield`. It carries claim 6's identity correctly.
- [orbit_second_order_form](../lean/HamiltonsCubic/Results/I106Criticality.lean) types a MATRIX identity for an arbitrary `W`, which is strictly stronger than the trace identity the block displays and implies it. Its docstring already says it asserts no nonnegativity, which is accurate.
- **One gap.** `Afield` and `Cfield` carry no multiple of $I$, so neither declaration types the block's sentence "the multiples of $I$ drop out". Adding a `c • 1` to each definition, or a corollary stating invariance under the two shifts, would close it, and the sympy check above already establishes it.

**Claims 2, 4, 5, 8, 9 and 10 are typed nowhere, and four of the six could be.**

| claim | could Lean carry it |
|---|---|
| 2 | **Yes, easily.** `U * (β • V*V + Afield ...) - (β • V*V + Afield ...) * U = 0` is one `module` call, the same shape as `orbit_first_order_vacuous`. |
| 4 | **Partly.** Invariance of $\operatorname{tr}\hat U^3$, $\operatorname{tr}(\hat UV^2)$ and both norms under $X\mapsto gXg^{\mathsf T}$ for `g` orthogonal is statable and provable. The statement that the curve lies in the constraint set needs the constraint set, which the file does not define. |
| 5 | **Yes.** Symmetry, tracelessness and $3\operatorname{tr}(\hat U[\Omega,\hat U])+\operatorname{tr}(V[\Omega,V])=0$ are three short identities and the tangency one holds for arbitrary `W`. |
| 8 | **Yes, and it is the one most worth typing.** It is a polynomial identity: the block's cubic terms equal $6\alpha\operatorname{tr}(\hat UX^2)+4\beta\operatorname{tr}(XVY)+2\beta\operatorname{tr}(\hat UY^2)$ at $X=[\Omega,\hat U]$, $Y=[\Omega,V]$. It needs symmetry of $\hat U$, $V$ and $\Omega$-skewness only through the reversal step $\operatorname{tr}(XYV)=\operatorname{tr}(XVY)$, so the hypotheses are the interesting part. |
| 9 | **No, not usefully.** It is a statement about a generalised eigenvalue of a pencil with a degenerate kernel, and typing it would mean carrying the whole spectral apparatus for a restatement. |
| 10 | **No.** Four numerical points at irrational $\mu$. A Lean statement would be a certified interval arithmetic exercise, out of proportion to what it settles. |

## What to change in the record

1. **Fix batch 33's table, row two.** Change the verdict from "orbit CLEARS it, and is weaker than both" to excluded by all three, and record that the threshold is nonetheless the lowest of the three. Fix the summary sentence so that "strictly weaker" no longer carries a clearance. Note in the same place that all four points now agree under all three bounds. **This is a refutation of a verdict, not of a number**, and the block's conclusion is unharmed.
2. **Replace the table's role in the argument with claim 8.** State that the orbit condition is implied by batch 21's full condition at every configuration, so the failure to exclude anything is a theorem. Keep the table as a screen against the two RECORDED bounds and say it is four points on one sub-stratum.
3. **Add that at two of the four points the orbit bound is the strongest of the three and still clears the survivor.** It makes the lever's closure more convincing than the "weaker" reading does.
4. **Narrow batch 32's "it carries no information" and post F69's headline** to the commuting corollary. Record that batch 7's maximiser statement, read through the rearrangement inequality, recovers $\mu\ge-\alpha u_k$, so it is redundant with batch 21 rather than vacuous. This is a small positive addition, an independent second route to batch 21's bound.
5. **Record that the orbit's second-order inequality needs no criticality**, since the acceleration term is retained rather than dropped. It makes batch 33's condition valid at every local maximum on its own terms.
6. **Soften batch 7's "diagonal in any eigenframe"** to a common eigenframe, and fix "positive multiple of $\mu$" to nonnegative in batch 33.
7. **Give `Afield` and `Cfield` their multiples of $I$**, or add the shift-invariance corollary, so that the Lean file types the sentence the block asserts.
