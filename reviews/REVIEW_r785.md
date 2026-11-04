# REVIEW r785, the PAIR statement flagged beside L184

*Cold brief, worked from [BRIEF-g2-pair.md](BRIEF-g2-pair.md) and nothing else; [findings/](../findings/) was not opened. **No numerical work was done and every value in this report is exact**, the only compute was a permitted screen of two closed-form identities I record below, carried out in exact integer and rational arithmetic over an explicit basis, reported as a screen and cited nowhere as evidence. Log: [agent_logs/g2-pair-r785.log](../agent_logs/g2-pair-r785.log).*

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 2 | The pair statement itself: no orthonormal pair with common six-dimensional support has equal squares and equal self-wedges | **TRUE** |
|, | The traced argument, taken as a whole, proves the pair statement | **UPHELD** |
| 3 | The case split survives with two forms, spectrum doubled, positive definite, trace 2, no third form used | **CLEAN** |
| 4 | Case 1 for a pair; the three equations against two sign-ratios | **CLEAN, the count is not over-determined, and I show why** |
| 5 | Case 2 for a pair | **CONCLUSION CORRECT, JUSTIFICATION MIS-ATTRIBUTED**, injectivity of the star is not the operative fact and is not used |
| 6 | Case 3 for a pair; the cross term and the 4+2 splitting | **CLEAN** |
| 7 | Unit norm genuinely available in each case | **AVAILABLE, AND STRONGER THAN NEEDED**, only non-vanishing of one form is used |
| 8 | The pair statement implies the triple statement | **YES, WITH NOTHING LOST** |
| 9 | "Common six-dimensional support" for a pair | **SAME HYPOTHESIS, AND PARTLY REDUNDANT** given equal squares |
| 10 | Overreach, steps that genuinely need the third form | **TWO FOUND, BOTH INERT**: case 2's rank contradiction and case 3's three-signs step |
| 1 | Hypothesis inventory | **ONE UNSTATED USE** (the wedge-with-a-volume-form injectivity in case 3) and one **HYPOTHESIS-DEBT** |
|, | The base computation $\star_V(J_0\wedge J_0)=2J_0$ and the two-orbit claim behind $\epsilon_J$ | **HYPOTHESIS-DEBT, no computation on file** |

**Actionable summary in one line.** The pair statement is true and the traced argument establishes it, so the observation may be folded, but the fold must carry two corrections: case 2's reason is the identity $\star_V(J\wedge J)=2\epsilon_JJ$ rather than injectivity of $\star_V$, and the terminal contradictions written in the block for cases 2 and 3 are three-form statements that must be replaced by orthogonality, which the traced version does silently.

## 0. Conventions, fixed once

$\mathbb R^n$ carries its standard inner product. A $2$-form $\omega$ is identified with a real skew matrix; $\langle\alpha,\beta\rangle=-\tfrac12\mathop{\mathrm{tr}}(\alpha\beta)$ and $\lVert\omega\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(\omega^2)$. The **support** of $\omega$ is $\mathop{\mathrm{im}}\omega$. An **orthonormal pair** is $\lVert\omega_1\rVert=\lVert\omega_2\rVert=1$ with $\langle\omega_1,\omega_2\rangle=0$. Products $\omega^2$, $\omega_1\omega_2$ are matrix products; $\wedge$ is the exterior product, so $\omega\wedge\omega\in\Lambda^4$. For an oriented $6$-dimensional subspace $V$, $\star_V:\Lambda^4V\to\Lambda^2V$ is the Hodge star of $V$ with its induced metric and a chosen orientation.

**Neither $\mathcal W_n$ nor any Weyl hypothesis is needed at any point of this review, and none of $n\ge12$, $\sqrt{3/2}$, $6+2\sqrt7$ appears anywhere in the pair statement, in the argument, or in my own derivation.** The only dimensional input is $\dim V=6$; $n$ enters solely as the ambient dimension, and $n\ge6$ is the only constraint on it.

Throughout, $A:=-\omega_1^2$. I write $V$ for the common support.

## 1. Hypothesis inventory

**The pair statement's hypotheses, as stated.**

- **H1** $\omega_1,\omega_2\in\Lambda^2\mathbb R^n$.
- **H2** $\lVert\omega_1\rVert=\lVert\omega_2\rVert=1$.
- **H3** $\langle\omega_1,\omega_2\rangle=0$.
- **H4** $\mathop{\mathrm{im}}\omega_1=\mathop{\mathrm{im}}\omega_2=:V$ with $\dim V=6$.
- **H5** $\omega_1^2=\omega_2^2$.
- **H6** $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$.

**Used.** H1, H3, H5, H6 throughout. From H4, only $\dim\mathop{\mathrm{im}}\omega_1=6$ is an independent assumption (see §9), and that dimension is genuinely load-bearing in cases 2 and 3, case 2 because $\star_V$ carries $\Lambda^4V$ back into $\Lambda^2V$ only at $\dim V=6$, case 3 because the complementary eigenspace $P$ is then a plane and $\varepsilon_P\wedge\varepsilon_P=0$.

**Stated and all but unused.** H2 is used three times and none of the three needs the full strength of a unit norm: (i) $\mathop{\mathrm{tr}}A=2$, which the case split never consults; (ii) $c=\tfrac13$ in case 2, which is decorative; (iii) $\mathop{\mathrm{tr}}(\omega_1^2)=-2$ at the end of case 1, where $\mathop{\mathrm{tr}}(\omega_1^2)\ne0$ would do. Further, $\lVert\omega_2\rVert=1$ follows from $\lVert\omega_1\rVert=1$ and H5, so half of H2 is derivable rather than assumed. See §7.

**Used and unstated.** Case 3 equates the cross terms and concludes $\tau_1J_1=\tau_2J_2$; that step is the injectivity of $\alpha\mapsto\alpha\wedge\varepsilon_P$ on $\Lambda^2Q$, which the block uses and does not state. It is true, and I supply no more than the name of the fact being used. Case 2 also requires an orientation on $V$ before $\star_V$ exists; the block never chooses one. The conclusion is orientation-independent, so this is a presentational omission rather than a defect.

**HYPOTHESIS-DEBT.** The block asserts $\star_V(J\wedge J)=2\epsilon_JJ$ with $\epsilon_J=\pm1$, and grounds the well-definedness of $\epsilon_J$ on $SO(6)$ being connected. **Neither the base computation for a standard $J$ (which fixes both the constant $2$ and the sign) nor the claim that the compatible complex structures on $V$ form exactly two $SO(6)$-orbits is on file anywhere in the material I was given.** Connectedness of $SO(6)$ alone does not produce the identity; it only tells you $\epsilon$ is constant on orbits once you already know $\star_V(J\wedge J)$ is a multiple of $J$. **This claim has no argument on file.** I record the debt and do not discharge it. I did confirm the identity for myself before recording anything that leans on it, and say so as a screen in §5, not as a supplied argument.

## 2. Is the pair statement true? Attacked directly

**I derived the structure of an arbitrary such pair from scratch before reading the traced argument, and it closes. Verdict: TRUE. I produced no counterexample, and the reason no counterexample exists is closed-form and is set out below.**

Let $\omega_1,\omega_2$ satisfy H1, H4, H5, H6, and set $A=-\omega_1^2=-\omega_2^2$.

For a real skew $\omega$, $-\omega^2=\omega^{\mathsf T}\omega$ is positive semidefinite with $\mathop{\mathrm{im}}(-\omega^2)=\mathop{\mathrm{im}}\omega$ and $\ker\omega=(\mathop{\mathrm{im}}\omega)^\perp$. Hence $A$ is symmetric, positive semidefinite, $\mathop{\mathrm{im}}A=V$, positive definite on $V$ and zero on $V^\perp$, and **both** $\omega_i$ vanish on $V^\perp$, so $\omega_1,\omega_2\in\Lambda^2V$.

Each $\omega_i$ commutes with $A$: $\omega_iA=-\omega_i^3=A\omega_i$. So each preserves every eigenspace of $A$.

Restricting to $V$: $\omega_1|_V$ is invertible and skew, so in some orthonormal basis it is $\bigoplus_{j=1}^3c_j\varepsilon$ with $c_j>0$, whence $A|_V$ has eigenvalues $c_1^2,c_1^2,c_2^2,c_2^2,c_3^2,c_3^2$. Three positive reals fall into exactly one of: pairwise distinct, all equal, exactly two equal. The three strata below exhaust the pairs.

**Pairwise distinct.** The eigenspaces of $A|_V$ are three orthogonal planes $P_1,P_2,P_3$, each preserved by both $\omega_i$. A skew endomorphism of a plane is $\lambda\varepsilon_j$ for a chosen area form $\varepsilon_j$, and squaring to $-c_j^2$ forces $\lambda=\pm c_j$. So $\omega_i=\sum_js_{ij}c_j\varepsilon_j$, $s_{ij}=\pm1$. Since $\varepsilon_j\wedge\varepsilon_j=0$,
$$\omega_i\wedge\omega_i=2\sum_{j<k}s_{ij}s_{ik}c_jc_k\,\varepsilon_j\wedge\varepsilon_k,$$
and the three $\varepsilon_j\wedge\varepsilon_k$ are supported on disjoint index quadruples, hence linearly independent. With $c_jc_k>0$, H6 is exactly $s_{1j}s_{1k}=s_{2j}s_{2k}$ for all $j<k$. Put $t_j:=s_{1j}s_{2j}\in\{\pm1\}$; the condition reads $t_jt_k=1$, i.e. $t_j=t_k$. So $t_1=t_2=t_3=:\eta$ and $\omega_2=\eta\omega_1$.

**All equal, $A|_V=cI_V$.** Then $J_i:=\omega_i|_V/\sqrt c$ is skew with $J_i^2=-\mathrm{Id}_V$, hence orthogonal: a metric-compatible complex structure on $V$. Fix an orientation on $V$. Every such $J$ satisfies $\star_V(J\wedge J)=2\epsilon_JJ$ with $\epsilon_J=\pm1$ (this is the identity carrying the debt of §1; see §5). Applying $\star_V$ to H6 gives $2\epsilon_1J_1=2\epsilon_2J_2$, so $J_2=\pm J_1$ and $\omega_2=\pm\omega_1$.

**Exactly two equal, $(a,a,b)$, $a\ne b$.** $A|_V$ has a $4$-dimensional eigenspace $Q$ and a plane $P$, both preserved. So $\omega_i=\sqrt a\,J_i\oplus\tau_i\sqrt b\,\varepsilon_P$ with $J_i$ a complex structure on $Q$ and $\tau_i=\pm1$. Then
$$\omega_i\wedge\omega_i=a\,J_i\wedge J_i\;+\;2\tau_i\sqrt{ab}\,J_i\wedge\varepsilon_P,$$
the $\varepsilon_P\wedge\varepsilon_P$ term vanishing because $\dim P=2$. The two summands lie in the independent subspaces $\Lambda^4Q$ and $\Lambda^2Q\wedge\Lambda^2P$ of $\Lambda^4V$, so H6 splits. The cross terms give $\tau_1J_1\wedge\varepsilon_P=\tau_2J_2\wedge\varepsilon_P$, and $\alpha\mapsto\alpha\wedge\varepsilon_P$ is injective on $\Lambda^2Q$ because $\varepsilon_P$ is a volume form on a complement of $Q$; hence $\tau_1J_1=\tau_2J_2$, i.e. $J_2=\tau_1\tau_2J_1$. Then
$$\tau_1\tau_2\,\omega_1=\sqrt a\,\tau_1\tau_2J_1\oplus\tau_1^2\tau_2\sqrt b\,\varepsilon_P=\sqrt a\,J_2\oplus\tau_2\sqrt b\,\varepsilon_P=\omega_2,$$
so $\omega_2=\pm\omega_1$.

**In all three strata $\omega_2=\pm\omega_1$, and then $\langle\omega_1,\omega_2\rangle=\pm\lVert\omega_1\rVert^2=\pm1\ne0$, against H3. The pair statement is TRUE.**

**What I did to look for a counterexample.** Nothing that the standing rule reserves: no search, sweep, census or falsifier hunt was run. The derivation above is itself the answer to where one could hide, because it leaves no free parameter, H5 fixes the eigenspace decomposition of $V$ common to both forms, and on each stratum the residual freedom of $\omega_2$ given $\omega_1$ is a finite sign set that H6 collapses to $\pm1$. **A counterexample would have to break one of exactly three closed-form facts: the linear independence of $\{\varepsilon_j\wedge\varepsilon_k\}_{j<k}$, the identity $\star_V(J\wedge J)=2\epsilon_JJ$, or the injectivity of $\wedge\varepsilon_P$ on $\Lambda^2Q$.** Each is elementary and none does. See the closing section for the shape of the object that would falsify the statement and why it cannot exist at $\dim V=6$.

## 3. The case split, for a pair

**CLEAN. Every input to the split is a statement about $\omega_1$ alone; no second form is used, let alone a third.**

- **Doubled spectrum**: from $\omega_1|_V$ being invertible and skew. One form.
- **Positive definiteness on $V$**: from $-\omega_1^2=\omega_1^{\mathsf T}\omega_1$ with $\mathop{\mathrm{im}}=V$. One form.
- **Trace $2$**: $\mathop{\mathrm{tr}}A=-\mathop{\mathrm{tr}}(\omega_1^2)=2\lVert\omega_1\rVert^2=2$. One form, and (as flagged in §1), never consulted by the split, which is a trichotomy on how many of $c_1^2,c_2^2,c_3^2$ agree and is insensitive to their scale.
- **Exhaustiveness**: three positive reals admit exactly the three coincidence patterns. Purely arithmetic.

The block's own defence of the split ("every input to that split is Weyl-free") is correct as far as it goes, and the pair reading is strictly weaker again: it needs no property of $\omega_2$ beyond H5 to inherit the same decomposition, since $A$ is common by hypothesis and $\omega_2$ commutes with it.

**One remark the block does not make.** $A$'s multiplicities are even **on $V$** only; off $V$ the zero eigenvalue has multiplicity $n-6$, which need not be even. The block does say this, in case 1, and it is correct there. The point matters for the split as well, and the split's own statement of it ("$A$ has spectrum $\{c_1^2,\dots\}$") is loose in the same way, it is $A|_V$ that has that spectrum.

## 4. Case 1 for a pair, the count

**CLEAN, and the brief's worry does not bite. The system is under-determined, not over-determined, and I set out the count explicitly because the brief asked for it.**

The unknowns are $s_{1j},s_{2j}\in\{\pm1\}$ for $j=1,2,3$. Fixing $\omega_1$ fixes $s_{1j}$, so the free data in $\omega_2$ is three signs. H6 imposes three conditions, one per pair $j<k$.

**Rewrite in the right variables.** Set $t_j:=s_{1j}s_{2j}$. Since every $s$ is a sign, $s_{1j}s_{1k}=s_{2j}s_{2k}$ is equivalent to $(s_{1j}s_{2j})(s_{1k}s_{2k})=1$, that is $t_jt_k=1$, that is $t_j=t_k$. **So the three conditions are $t_1=t_2$, $t_2=t_3$, $t_1=t_3$, of which any two imply the third.** The system has rank $2$ over $\mathbb F_2$, not $3$: exactly two of the three equations are independent. Its solution set is $t_1=t_2=t_3=\eta\in\{\pm1\}$, two solutions, never zero. **The count is therefore three equations, two independent, three unknowns, a two-element solution set.**

Consequences, both of which the brief's framing invites:

- **The argument does not prove too much.** $t\equiv+1$ (that is $\omega_2=\omega_1$) always solves the system, so H6 is consistent and the case-1 conclusion is not the vacuous one that would follow from an inconsistent system.
- **The argument does not prove too little.** $\eta$ is unique across all three planes, so $s_{2j}=\eta s_{1j}$ for every $j$ and $\omega_2=\eta\omega_1$ exactly, with $\eta$ the same sign on all three planes.

**Does the block's own route go through with two indices?** Yes. The block sets $\eta_i=s_{i1}s_{11}$ and claims $s_{ij}=\eta_is_{1j}$ for every $j$. At $i=2$ this reads $s_{2j}s_{1j}=s_{21}s_{11}$, i.e. $t_j=t_1$, which is the equation for the pair of planes $(1,j)$, so only the conditions at $j=2,3$ are consumed, exactly two of the three. **The three indices in the block's $\eta_i$ range over the three forms; the three indices in $s_{ij}s_{ik}$ range over the three planes. Only the second family is needed, and a pair supplies three planes just as a triple does.** The step is form-count-free.

**Screen.** Enumerating all $8\times8$ sign pairs $(s_1,s_2)$ against the three conditions returns exactly $16$ solutions, all with $s_2=\pm s_1$, and none outside that form. Exact integer arithmetic, seconds of compute, on objects I constructed for the purpose. Recorded as a screen of a claim I make by hand above, not as evidence for it.

**Terminal step.** $\mathop{\mathrm{tr}}(\omega_1\omega_2)=\eta\mathop{\mathrm{tr}}(\omega_1^2)=-2\eta$, so $\langle\omega_1,\omega_2\rangle=\eta=\pm1\ne0$. Correct as written in the traced argument.

## 5. Case 2 for a pair

**The conclusion is correct for a pair. The justification the block gives for it is mis-attributed, and I record that as a defect in the reason rather than in the result.**

**What is true.** With $A|_V=cI_V$, both $J_i=\omega_i|_V/\sqrt c$ are metric-compatible complex structures on $V$. Fix an orientation on $V$. Then $\star_V(J\wedge J)=2\epsilon_JJ$, $\epsilon_J=\pm1$ according as $J$'s induced orientation agrees with $V$'s. Applying the linear map $\star_V$ to $J_1\wedge J_1=J_2\wedge J_2$ gives $\epsilon_1J_1=\epsilon_2J_2$, hence $J_2=\pm J_1$ and $\omega_2=\pm\omega_1$. **Two forms suffice; nothing in the step counts forms.**

**The defect.** The block writes: *"nothing weaker survives, since $\star$ is injective, so equal wedges give $\omega_j=\pm\omega_1$ exactly."* **Injectivity of $\star_V$ is not used and cannot be what carries the step.** Applying any linear map to an equality preserves it; the deduction from $J_1\wedge J_1=J_2\wedge J_2$ to $\epsilon_1J_1=\epsilon_2J_2$ needs no injectivity whatsoever. Injectivity of $\star_V$ would be the tool for the *converse* (deducing equality of the wedges from equality of the forms) which is not what is wanted. **The operative fact is that $\star_V$ sends $J\wedge J$ to a multiple of $J$ itself**, and that is a property of the pair $(\star_V,J)$, not of $\star_V$ alone. The stated reason is a true sentence about $\star_V$ doing work it does not do here. The brief's traced rendering inherits the error verbatim: *"$\star_V$ is injective, so equal wedges give $\omega_2=\pm\omega_1$."*

**The debt behind the identity.** As recorded in §1, the identity $\star_V(J\wedge J)=2\epsilon_JJ$ itself has no computation on file, neither the constant $2$, nor the base sign, nor the claim that compatible complex structures form two $SO(6)$-orbits so that $\epsilon$ is well defined. **HYPOTHESIS-DEBT.** I do not supply the missing argument.

**Screen.** Before recording that I believe the identity, I evaluated $\star_V(J\wedge J)$ in exact integer arithmetic for all eight sign-types $J=\pm f_1\wedge f_2\pm f_3\wedge f_4\pm f_5\wedge f_6$ over the orientation $f_1\wedge\cdots\wedge f_6$. Each returned $\star_V(J\wedge J)=2\epsilon J$ with $\epsilon$ the product of the three signs, consistently across every basis component. Seconds of compute, objects constructed for the purpose, reported as a screen and cited as evidence for nothing. It does not discharge the debt: eight diagonal representatives are not the family.

**The block's terminal contradiction does not transfer.** The block closes case 2 with *"the contradiction is then linear independence rather than orthogonality: $J_i=\pm K$ leaves the three forms spanning a line, so the rank cannot be three."* **That sentence is about three forms and is meaningless for two**, two forms spanning a line is no contradiction on its own. For a pair the contradiction must revert to orthogonality: $\omega_2=\pm\omega_1$ gives $\langle\omega_1,\omega_2\rangle=\pm1\ne0$. This substitution is legitimate and the brief's traced version performs it, but performs it silently. See §10.

## 6. Case 3 for a pair

**CLEAN. The cross-term argument survives with two forms, and the $4+2$ splitting is forced by $\omega_1$ alone.**

**The splitting.** "Exactly two of $c_1^2,c_2^2,c_3^2$ agree" means $A|_V$ has eigenvalue $a$ with multiplicity $4$ and $b\ne a$ with multiplicity $2$, both positive. That is a statement about $A=-\omega_1^2$ and the doubling of §3, so it is forced before $\omega_2$ is mentioned. Both eigenspaces $Q$ (dimension $4$) and $P$ (dimension $2$) are preserved by both forms because both commute with $A$.

**The cross term.** As in §2, H6 splits into a $\Lambda^4Q$ part and a $\Lambda^2Q\wedge\Lambda^2P$ part. The cross part gives $\tau_1J_1=\tau_2J_2$ by injectivity of $\wedge\varepsilon_P$, hence $J_2=\tau_1\tau_2J_1$ and $\omega_2=\tau_1\tau_2\omega_1$. **Both index families here run over the two forms only; nothing ranges over a third.**

**The sequencing.** The block insists that the $\Lambda^4Q$ condition is vacuous only *after* the cross term has acted, and it is right, and the point holds unchanged for a pair: read alone, $J_1\wedge J_1=J_2\wedge J_2$ in the one-dimensional $\Lambda^4Q$ says $\eta_1=\eta_2$, a real restriction; once $J_2=\pm J_1$ is known, $(-J)\wedge(-J)=J\wedge J$ makes it automatic. The load-bearing order is preserved.

**Where the block's case 3 does *not* transfer.** Its closing paragraph argues orthogonality as a sign identity: $4a\,\sigma_i\sigma_j=-2b\,\tau_i\tau_j$, then *"the ratio $\sigma_i\sigma_j/(\tau_i\tau_j)=\rho_i\rho_j$ must be one constant, and three signs with all pairwise products equal force that constant to be $+1$"*. **The final clause is genuinely a three-form step and it fails for a pair.** With three signs, $\rho_1\rho_2=\rho_1\rho_3=\rho_2\rho_3=k$ multiplies to $(\rho_1\rho_2\rho_3)^2=k^3$, so $k^3=1$ and $k=+1$. With two signs there is a single product $\rho_1\rho_2$ and no equation forcing it to $+1$; taking $\rho_1\rho_2=-1$ gives $4a=2b$, i.e. $b=2a$, which is perfectly admissible for $a,b>0$. **So the three-signs route to $4a=-2b$ has no two-form analogue.**

This costs the pair statement nothing, because the block itself retires that route: *"$\rho_i=\sigma_i\tau_i$ is constant, which retires the three-signs step and gives $2a=-b$ at once."* Constancy of $\rho$ comes from the cross term, which is a two-form step, and $\rho_1=\rho_2$ gives $\rho_1\rho_2=+1$ directly. Equivalently, and more simply, $\omega_2=\pm\omega_1$ already contradicts H3 with no reference to $a$ and $b$ at all. **The finding is that the block carries a step which the pair reading must be careful to route around, and the traced version does route around it.**

## 7. The orthonormality contradiction, and whether unit norm is assumed

**Available in every case, and stronger than the argument needs.**

$\lVert\omega_1\rVert=1$ is H2, a hypothesis, so it is available by assumption in all three cases and nothing derives it circularly. Checking each terminal step:

| Case | Terminal step as it must read for a pair | What of H2 it consumes |
|---|---|---|
| 1 | $\mathop{\mathrm{tr}}(\omega_1\omega_2)=\eta\mathop{\mathrm{tr}}(\omega_1^2)=-2\eta$, so $\langle\omega_1,\omega_2\rangle=\eta\ne0$ | The value $-2$; only $\mathop{\mathrm{tr}}(\omega_1^2)\ne0$ is needed |
| 2 | $\omega_2=\pm\omega_1$, so $\langle\omega_1,\omega_2\rangle=\pm1\ne0$ | The value $1$; only $\omega_1\ne0$ is needed |
| 3 | $\omega_2=\pm\omega_1$, so $\langle\omega_1,\omega_2\rangle=\pm1\ne0$ | The value $1$; only $\omega_1\ne0$ is needed |

**In every case the contradiction is $\langle\omega_1,\omega_2\rangle=\pm\lVert\omega_1\rVert^2$ against H3, and it needs only $\omega_1\ne0$.** Since $\omega_1$ has six-dimensional image by H4 it is nonzero anyway, so the norm hypothesis is doing no work in the contradiction at all. The two other appearances of H2 ($\mathop{\mathrm{tr}}A=2$ in the setup and $c=\tfrac13$ in case 2), are consumed by statements that no later step uses. **This means the pair statement holds verbatim for any *orthogonal* pair of $2$-forms with common six-dimensional support, normalisation dropped.** I record that as an observation about what the argument establishes and deliberately do not fold it into the statement; that is the author's call and this round was convened over exactly this kind of unadopted strengthening.

Also worth stating: $\lVert\omega_2\rVert=1$ is not an independent hypothesis, since $\lVert\omega_2\rVert^2=\tfrac12\mathop{\mathrm{tr}}(-\omega_2^2)=\tfrac12\mathop{\mathrm{tr}}A=\lVert\omega_1\rVert^2$ by H5.

## 8. Does the pair statement imply the triple statement?

**Yes, immediately, and nothing is lost.**

Suppose $\omega_1,\omega_2,\omega_3$ were an orthonormal triple with common six-dimensional support $V$, coincident squares and coincident self-wedges. Then $\omega_1,\omega_2$ is a pair of $2$-forms with $\lVert\omega_1\rVert=\lVert\omega_2\rVert=1$, $\langle\omega_1,\omega_2\rangle=0$, $\mathop{\mathrm{im}}\omega_1=\mathop{\mathrm{im}}\omega_2=V$ of dimension six, $\omega_1^2=\omega_2^2$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$. Every hypothesis of the pair statement holds for it, so the pair statement forbids it. **The restriction of a triple's hypotheses to two of its members is hypothesis-for-hypothesis exactly the pair hypotheses**, this is the point to check, and it checks: orthonormality restricts, common support restricts, and both coincidence conditions restrict.

**What is lost: nothing.** The triple statement is a corollary with a one-line proof and no residue. The converse fails, so the pair statement is strictly stronger, as the block's observation says. The corollary the programme actually wanted from L184, that there is no rank-three $W\in\mathcal W_n$ with $\dim V=6$ whose three images under $\Phi$ coincide, therefore also follows from the pair statement through the triple statement, with the same bridge (the eigenforms of such a $W$ being an orthonormal triple with coincident $\Phi$-images) and no new step.

**One caution on how the fold should be worded.** L184's headline is currently the triple statement, and the block warns that the pair statement *"must not be cited as though it were"* what the block claims. If the pair statement is adopted, that warning must be removed in the same edit, not left standing beside a strengthened headline; two rounds' worth of readers will otherwise see a statement and a note telling them not to use it.

## 9. The kernel and the support

**Same hypothesis as for a triple, and partly redundant.**

For a triple, "common six-dimensional support" is $\mathop{\mathrm{im}}\omega_1=\mathop{\mathrm{im}}\omega_2=\mathop{\mathrm{im}}\omega_3=V$, $\dim V=6$. For a pair it is the same sentence over two forms. There is no reading under which the pair version is weaker or stronger per form.

**The redundancy.** Given H5, $\mathop{\mathrm{im}}\omega_2=\mathop{\mathrm{im}}(-\omega_2^2)=\mathop{\mathrm{im}}A=\mathop{\mathrm{im}}(-\omega_1^2)=\mathop{\mathrm{im}}\omega_1$, using $\mathop{\mathrm{im}}\omega=\mathop{\mathrm{im}}(\omega^{\mathsf T}\omega)$ for skew $\omega$. **So "common" is a theorem, not a hypothesis, once the squares agree; the only independent content of H4 is $\dim\mathop{\mathrm{im}}\omega_1=6$.** The block observes the same thing for the triple (*"equal squares already force a common support, so no reconciliation step is needed"*) and the observation is exactly as true for two forms.

The kernels follow: $\ker\omega_i=(\mathop{\mathrm{im}}\omega_i)^\perp=V^\perp$, common, of dimension $n-6$, so both forms lie in $\Lambda^2V$ and every computation may be done inside $V$. **Nothing in the argument needs more than this.** Specifically, no step needs $n$, needs $V^\perp$ to have even dimension, or needs $V$ to be spanned in any particular way.

**Where the dimension is genuinely spent.** Case 1 spends only "three planes", which is $\dim V=6$ via the doubling. Case 2 spends $\dim V=6$ essentially, since $\star_V:\Lambda^4V\to\Lambda^2V$ requires $\binom{2m}{4}=\binom{2m}{2}$, true only at $2m=6$. Case 3 spends it as $4+2$, needing $\dim P=2$ for $\varepsilon_P\wedge\varepsilon_P=0$ and for the injectivity of $\wedge\varepsilon_P$. The block's entailment box is right that cases 2 and 3 are strictly six-dimensional, and the pair reading changes none of that.

## 10. Overreach, steps that genuinely need the third form

**Two found. Both are terminal steps, and both are inert because a two-form contradiction is already in hand at the point they are reached.**

- **Case 2's contradiction.** *"The contradiction is then linear independence rather than orthogonality: $J_i=\pm K$ leaves the three forms spanning a line, so the rank cannot be three."* This is a statement about three forms with no two-form content. Replaced by orthogonality for a pair, as in §5.
- **Case 3's three-signs step.** *"Three signs with all pairwise products equal force that constant to be $+1$."* Shown in §6 to fail with two signs, where $\rho_1\rho_2=-1$ is unobstructed by that equation. Superseded by the cross term's constancy of $\rho$, which the block itself flags as retiring it.

**Case 1 contains no such step.** Its three indices are planes, not forms.

**How this should be read.** It is not overreach in the sense of the block claiming more than it proves, the block claims the triple statement and proves it. It is that **two of the block's written closings are triple-specific, so the pair statement is not obtained by simply deleting the index $3$ from the block.** The traced argument in the brief does perform the necessary substitution (*"In each case $\omega_2=\pm\omega_1$, which an orthonormal pair cannot satisfy"*) but does so without noting that this replaces the block's stated case-2 and case-3 contradictions rather than restricting them. **If the observation is folded, the block's case bodies should be edited so their terminal step is $\omega_i=\pm\omega_1$ against orthogonality in all three cases, which is the mechanism the block's own headline box already claims is uniform.**

## What would break it, and what I did to look

**The object.** A pair $\omega_1,\omega_2\in\Lambda^2\mathbb R^n$, both of unit norm, orthogonal to each other, both of image exactly a common $V$ with $\dim V=6$, with $\omega_1^2=\omega_2^2$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$ and $\omega_2\ne\pm\omega_1$. Concretely it would have to be one of:

- **three planes**: signs $s_{1j},s_{2j}$ with $s_{1j}s_{1k}=s_{2j}s_{2k}$ for all $j<k$ but $s_2\ne\pm s_1$;
- **$A|_V$ scalar**: two compatible complex structures $J_1,J_2$ on $\mathbb R^6$ with $J_1\wedge J_1=J_2\wedge J_2$, $J_2\ne\pm J_1$;
- **$4+2$**: complex structures $J_1,J_2$ on $\mathbb R^4$ and signs $\tau_1,\tau_2$ with $\tau_1J_1\wedge\varepsilon_P=\tau_2J_2\wedge\varepsilon_P$ but $\tau_1J_1\ne\tau_2J_2$.

**Why each is empty**, in closed form: the first because the conditions read $t_j=t_k$ in $t_j=s_{1j}s_{2j}$ and force $t$ constant; the second because $\star_V$ carries $J\wedge J$ to $2\epsilon_JJ$, so the wedge determines $J$ up to sign; the third because $\wedge\varepsilon_P$ is injective on $\Lambda^2Q$ when $\varepsilon_P$ is a volume form on a complement.

**What I did to look.** I derived the general form of a pair satisfying H4 and H5 from first principles, which leaves a finite sign set on strata 1 and 3 and a single $O(6)$-orbit datum on stratum 2, and then imposed H6 on each in closed form. **No search, sweep, census, optimisation or falsifier hunt was run**, in keeping with the analysis-only footing. The only compute was the two screens named in §4 and §5, exact and on objects I constructed to check identities I was about to write down. The natural place a counterexample would live is outside the statement: at $\dim V=8$ a spectrum such as $(a,a,b,b)$ falls into none of the three strata, and the block's entailment box already says so. **I found nothing that touches $\dim V=6$.**

## Overall verdict

**UPHELD, the pair statement is true, and the traced argument proves it. Two corrections are owed before it is folded, and one debt is owed by the block whether it is folded or not.**

- **The statement** stands, and the argument for it needs no third form anywhere: the case split is a fact about $\omega_1$, case 1 counts planes rather than forms, case 2 is one application of a linear map, case 3 is one injectivity.
- **Correction 1.** Case 2's *"since $\star$ is injective"* names the wrong fact; injectivity is never used and the step rests on $\star_V(J\wedge J)=2\epsilon_JJ$. This travels into the brief's traced rendering unchanged.
- **Correction 2.** The block's terminal contradictions in cases 2 and 3 are three-form statements (a rank argument and a three-signs product argument) and neither survives to a pair. Both are inert, but a fold must rewrite them to $\omega_i=\pm\omega_1$ against orthogonality rather than delete an index.
- **HYPOTHESIS-DEBT.** $\star_V(J\wedge J)=2\epsilon_JJ$ (the constant, the base sign, and the two-orbit fact behind $\epsilon_J$'s well-definedness), has no argument on file. Connectedness of $SO(6)$ is not that argument. I name the gap and leave it unfilled.
- **Recorded, not folded.** The norm hypothesis is spent only on $\omega_1\ne0$, so the argument establishes the statement for any orthogonal pair; and "common support" is a consequence of equal squares rather than a hypothesis. Both are the author's to adopt or decline.
