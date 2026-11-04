# r809: Gate 2 on the L184 pair statement, and on the entailment that the rank-two configuration lands in it

*Cold brief: I was given the two claims and the pointers, and read [findings/diagonal-half.md](../findings/diagonal-half.md) (L178 through L190), [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), [plan.md](../plan.md) and [reviews/INDEX.md](INDEX.md) from scratch. **The programme is on an analysis-only footing and I opened no numerical line of work.** Every derivation below is by hand and every constant is exact. Four machine actions were screens on objects I constructed for the purpose, reported as screens in §8 and never as evidence for a positive claim. Log: [agent_logs/g2-l184pair-r809.log](../agent_logs/g2-l184pair-r809.log).*

| Claim | Verdict |
|---|---|
| **P**: no orthonormal pair of $2$-forms with a common six-dimensional support has both its squares and its self-wedges coincident | **CONFIRMED**, and **understated**: the hypotheses force $\omega_2=\pm\omega_1$ before orthogonality is spent, so the theorem is a rigidity statement and the pair statement is its corollary |
| **P.1**: case 1's $u_ju_k=1$ is forced from a pair and gives $\omega_2=\eta\omega_1$ | **CONFIRMED.** Two of the three equations suffice, and $u_j$ is independent of the sign chosen for each $\varepsilon_j$ |
| **P.2**: case 2 closes for a pair from $\star_V(J\wedge J)=2\epsilon_JJ$ alone, the rank argument inert | **CONFIRMED.** Injectivity of $\star_V$ is genuinely unused, and $\mathop{\mathrm{tr}}(\omega_1\omega_2)=\mp2$ replaces linear independence exactly |
| **P.3**: case 3's three-signs count is false for two, and orthogonality substitutes | **CONFIRMED that the count fails**, with the $\rho_1\rho_2=-1$, $b=2a$ configuration exhibited below in closed form. **The substitution that closes the case is the CROSS TERM, not orthogonality**: the near-miss is orthonormal, has a common six-dimensional support and equal squares, and is excluded by the cross term alone |
| **P.4**: the trichotomy is still exhaustive for a pair | **CONFIRMED.** Every input to the split is read off $A=-\omega_1^2$ from one form, and the count of three values is $\dim V=6$ and nothing else |
| **The `HYPOTHESIS-DEBT` items (i)–(iv)** | **ALL FOUR DISCHARGED CORRECTLY.** (iv)'s three star signs recomputed and all $+$ at the fixed orientation. $\epsilon_J$'s well-definedness is the $U(3)$ fact, $\det_{\mathbb R}A=\lvert\det_{\mathbb C}A\rvert^2=1$ |
| **E**: the rank-two Weyl configuration lands exactly in Claim P's hypothesis at $\dim V=6$ | **CONFIRMED as stated.** $\lambda_2=-\lambda_1$, both coincidences and orthonormality all follow. **The common support is DERIVED and its six-dimensionality is a CASE HYPOTHESIS**, correctly declared |
| **E.1**: what the entailment closes | **CONFIRMED and correctly hedged.** It empties $\dim V=6$ of a branch that is open at every even $\dim V\ge6$. **The rank-two branch does not close**, and no analogue of [L187](../findings/diagonal-half.md)'s congruence bounds it |
| **The box's own claim that case 3 "as written" is three-index** | **OVERSTATED.** The block's corrected case-3 route, $\rho_i$ constant from the cross term, is already pair-valid by its own words *"which retires the three-signs step"*. Only the vestigial final sentence is three-form. The claim holds for case 2 |
| **Dimension-free carry-over** | **NONE FOUND** in the pair argument. Every step that needs six dimensions says so, and the statement is genuinely false one dimension down: an explicit orthonormal pair at $\dim V=4$ with both coincidences is in §7 |

**One line.** *Both claims survive, and Claim P survives in a stronger form than it is stated: at $\dim V=6$ equal squares and equal self-wedges force $\omega_2=\pm\omega_1$ outright, with orthogonality spent only at the last line, so the pair statement is safe to fold and safe to cite for the rank-two branch at $\dim V=6$ alone. The one correction is to the observation box's account of itself: case 3's closing for a pair is the cross term, and the near-miss the three-signs count admits is a real orthonormal configuration that the cross term kills.*

## 0. Conventions, fixed once

- $\langle\omega,\eta\rangle=\sum_{a<b}\omega_{ab}\eta_{ab}$, the convention [L180](../findings/diagonal-half.md) fixes by $\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=2\lVert\omega\rVert^2$ and the one `inner2` carries in [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean). Hence $\mathop{\mathrm{tr}}(\omega\eta)=-2\langle\omega,\eta\rangle$, and **orthogonality of two $2$-forms is exactly $\mathop{\mathrm{tr}}(\omega_1\omega_2)=0$**.
- A $2$-form is read as a skew matrix, and its **support** is $\mathop{\mathrm{im}}\omega$, and $\ker\omega=(\mathop{\mathrm{im}}\omega)^\perp$.
- $A_i=-\omega_i^2=\omega_i\omega_i^{\mathsf T}$, positive semidefinite of trace $2\lVert\omega_i\rVert^2$.
- $\varepsilon_j$ is a unit area form of a plane $P_j$, with $\varepsilon_j\wedge\varepsilon_j=0$ and $\varepsilon_j^2=-\mathrm{Id}_{P_j}$.
- $\star_V$ is the star of the six-dimensional $V$, never $\mathbb R^n$'s, with $\mathrm{vol}_V=e^{123456}$ in a positively oriented frame.

**Two facts used throughout, both one line.** For skew $\omega$, $\ker\omega=\ker\omega^2$, since $\omega^2x=0$ gives $\lVert\omega x\rVert^2=-x^{\mathsf T}\omega^2x=0$. And equal squares therefore give **equal supports**: $\omega_1^2=\omega_2^2$ forces $\ker\omega_1=\ker\omega_2$, hence $\mathop{\mathrm{im}}\omega_1=\mathop{\mathrm{im}}\omega_2$.

## 1. Claim P.4: the trichotomy, for a pair

**Located.** [L184](../findings/diagonal-half.md)'s *Setup*: $A=-\omega_i^2$ common, positive definite of trace $2$ on $V$, spectrum $\{c_1^2,c_1^2,c_2^2,c_2^2,c_3^2,c_3^2\}$, and the three cases set by how many of the $c_j^2$ agree.

**Every input is read off one form.** In $\omega_1$'s canonical frame $\omega_1=\bigoplus_j c_j\varepsilon_j$ on $V$ and zero on $V^\perp$, so $A=\bigoplus_j c_j^2\mathrm{Id}_{P_j}$ with three blocks because $\dim V=6$. Positive definiteness on $V$ is $V=\mathop{\mathrm{im}}A=\mathop{\mathrm{im}}\omega_1$, giving every $c_j\ne0$; the doubling is skewness; $\mathop{\mathrm{tr}}A=2$ is the unit norm. **Nothing in that derivation reads a second form, still less a third.** The second form enters only through $\omega_2^2=\omega_1^2=-A$, which makes $\omega_2$ commute with $A$ and so preserve each of its eigenspaces.

**So the split is a trichotomy on three positive reals and is exhaustive.** The count of three is $\dim V=6$: at $\dim V=8$ there are four values and a pattern such as $(a,a,b,b)$ sits outside all three cases, which the block's entailment box already says.

**One thing the pair setup gains over the triple.** The hypothesis *common support* is half redundant: equal squares already give equal supports by §0. What remains genuinely hypothetical is that the common support has dimension six. This matters for Claim E and is taken up in §6.

## 2. Case 1, pairwise distinct $c_j^2$: CONFIRMED, and two equations suffice

**Located.** The observation box: *"case 1's equal wedges give $s_{1j}s_{1k}=s_{2j}s_{2k}$ at all three pairs, which in the sign variables $u_j=s_{1j}s_{2j}$ reads $u_ju_k=1$"*.

**Exhibited.** The eigenspaces of $A$ are three planes $P_1,P_2,P_3$, each preserved by $\omega_1$ and by $\omega_2$. A skew map on a plane is a multiple of its area form, and $(\omega_i|_{P_j})^2=-c_j^2\mathrm{Id}$, so with a sign chosen once for each $\varepsilon_j$,
$$\omega_i=\textstyle\sum_j s_{ij}c_j\varepsilon_j,\qquad s_{ij}=\pm1,\ c_j>0,\ i\in\{1,2\}.$$
Then $\omega_i\wedge\omega_i=2\sum_{j<k}s_{ij}s_{ik}c_jc_k\,\varepsilon_j\wedge\varepsilon_k$, the diagonal terms vanishing. By debt item (i) the $\varepsilon_j\wedge\varepsilon_k$ are independent, so equal self-wedges give $s_{1j}s_{1k}c_jc_k=s_{2j}s_{2k}c_jc_k$ for each $j<k$, and $c_jc_k>0$ cancels.

**The sign algebra, done exactly.** Multiplying $s_{1j}s_{1k}=s_{2j}s_{2k}$ by $s_{2j}s_{2k}$, whose square is $1$, gives $u_ju_k=1$ with $u_j=s_{1j}s_{2j}$. For signs, $u_ju_k=1$ is $u_j=u_k$, so $u_1u_2=1$ and $u_1u_3=1$ already force $u_1=u_2=u_3=:\eta$, and the third equation is the consequence $u_2=u_3$. Hence $s_{2j}=u_js_{1j}=\eta s_{1j}$ for every $j$ and $\omega_2=\eta\omega_1$ exactly.

**Closing.** $\mathop{\mathrm{tr}}(\omega_1\omega_2)=\eta\mathop{\mathrm{tr}}(\omega_1^2)=-2\eta\ne0$, against orthogonality. **The pair uses no third index anywhere.**

**Two points of hygiene, both clean.** $s_{ij}$ depends on the sign chosen for $\varepsilon_j$ and $u_j=s_{1j}s_{2j}$ does not, so the forced relation is on a choice-free quantity. And the box's remark that *"the count is not two free ratios against three constraints"* is a warning about naive counting rather than a step: the substitution $u_j=s_{1j}s_{2j}$ is what makes the system linear in the sign group.

**Both hypotheses are load-bearing here, which I checked by building the near-miss.** Orthogonality alone is satisfiable in this stratum: with $(c_1^2,c_2^2,c_3^2)=(\tfrac12,\tfrac3{10},\tfrac15)$, which sums to $1$ as $\mathop{\mathrm{tr}}A=2$ requires, the pattern $u=(+,-,-)$ gives $\mathop{\mathrm{tr}}(\omega_1\omega_2)=-2\sum_ju_jc_j^2=-2(\tfrac12-\tfrac3{10}-\tfrac15)=0$. **What kills it is the wedge hypothesis**, which forces all $u_j$ equal and then $\sum_ju_jc_j^2=\pm1\ne0$.

## 3. Case 2, $A=cI_6$: CONFIRMED, and injectivity of $\star_V$ is genuinely unused

**Located.** [L184](../findings/diagonal-half.md)'s case 2 and the box's *"from the identity $\star_V(J\wedge J)=2\epsilon_JJ$ alone"*.

**Exhibited.** $\mathop{\mathrm{tr}}A=2$ over six dimensions gives $c=\tfrac13$, so $J_i=\sqrt3\,\omega_i$ is skew with $J_i^2=-\mathrm{Id}_V$, hence orthogonal, hence a compatible complex structure. Equal self-wedges give $J_1\wedge J_1=J_2\wedge J_2$ in $\Lambda^4V$. **Apply $\star_V$ to both sides**, which is a linear map and needs no injectivity, and use the identity on each side separately:
$$2\epsilon_1J_1=\star_V(J_1\wedge J_1)=\star_V(J_2\wedge J_2)=2\epsilon_2J_2\ \Longrightarrow\ J_2=\epsilon_1\epsilon_2J_1=\pm J_1,$$
so $\omega_2=\pm\omega_1$ and $\mathop{\mathrm{tr}}(\omega_1\omega_2)=\mp2\ne0$.

**The box's reading of the block is right on both counts.** The block cites $\star$ being injective and item (iii) upgrades it to an isomorphism, and **neither is consumed**, because the identity is applied to each side of an equality rather than inverted. And the block's stated closing, *"linear independence rather than orthogonality"*, has nothing to bite on at two forms: $\omega_2=\pm\omega_1$ is a two-element set spanning a line, which two forms are entitled to do until orthogonality forbids it. **The substitution is orthogonality, and it is exactly the clause the block flags as pair-scoped**, so case 2 is the one place the box's warning about the ledger row is fully earned.

## 4. Case 3, spectrum $(a,a,b)$: CONFIRMED, and the closing for a pair is the CROSS TERM

**Located.** [L184](../findings/diagonal-half.md)'s case 3, and the box's *"which is false for two, $\rho_1\rho_2=-1$ admits $b=2a$"*.

**Exhibited.** $A$'s eigenspaces are a $4$-plane $Q$ and a plane $P$, both preserved by both forms, and $\mathop{\mathrm{tr}}A=4a+2b=2$. Since $(\omega_i|_Q)^2=-a\,\mathrm{Id}_Q$ with $\omega_i|_Q$ skew, $\omega_i=\sqrt a\,J_i\oplus\tau_i\sqrt b\,\varepsilon_P$ with $J_i$ a complex structure on $Q$ and $\tau_i=\pm1$. The self-wedge splits into two independent summands of $\Lambda^4V$,
$$\omega_i\wedge\omega_i=\underbrace{a\,J_i\wedge J_i}_{\Lambda^4Q}+\underbrace{2\tau_i\sqrt{ab}\,J_i\wedge\varepsilon_P}_{\Lambda^2Q\wedge\Lambda^2P},$$
the $\varepsilon_P\wedge\varepsilon_P$ term vanishing because $\Lambda^4P=0$.

**The cross term carries the whole conclusion.** Equating it across $i=1,2$ and cancelling $\sqrt{ab}\ne0$ gives $\tau_1J_1=\tau_2J_2$, and item (ii) makes $\alpha\mapsto\alpha\wedge\varepsilon_P$ injective on $\Lambda^2Q$, so $J_2=\tau_1\tau_2J_1$. Then
$$\omega_2=\sqrt a\,\tau_1\tau_2J_1+\tau_2\sqrt b\,\varepsilon_P=\tau_1\tau_2\big(\sqrt a\,J_1+\tau_1\sqrt b\,\varepsilon_P\big)=\tau_1\tau_2\,\omega_1,$$
and $\mathop{\mathrm{tr}}(\omega_1\omega_2)=-2\tau_1\tau_2\ne0$. **The $\Lambda^4Q$ equality is then automatic**, and only in that order, exactly as the block says: read first it asserts $\eta_1=\eta_2$ for the orientation signs of $J_i\wedge J_i=2\eta_i\mathrm{vol}_Q$, which is a real restriction, and it becomes vacuous once $J_2=\pm J_1$ is known, $(-J)\wedge(-J)=J\wedge J$.

**The three-signs count IS false for two, and here is what it admits, in closed form.** With $\rho_i=\sigma_i\tau_i$ and $\mathop{\mathrm{tr}}(\omega_i\omega_j)=-4a\sigma_i\sigma_j-2b\tau_i\tau_j$, orthogonality reads $4a\,\sigma_1\sigma_2=-2b\,\tau_1\tau_2$, that is $2a\rho_1\rho_2=-b$. At $\rho_1\rho_2=-1$ this is $b=2a$, which with $4a+2b=2$ gives $a=\tfrac14$, $b=\tfrac12$. Take $Q=\langle e_1,e_2,e_3,e_4\rangle$, $P=\langle e_5,e_6\rangle$, $J=e^{12}+e^{34}$, $\varepsilon_P=e^{56}$:
$$\omega_1=\tfrac12 J+\tfrac1{\sqrt2}\varepsilon_P,\qquad \omega_2=\tfrac12 J-\tfrac1{\sqrt2}\varepsilon_P.$$
This pair is **orthonormal** ($\lVert\omega_i\rVert^2=2\cdot\tfrac14+\tfrac12=1$ and $\langle\omega_1,\omega_2\rangle=\tfrac12-\tfrac12=0$), has the **common six-dimensional support** $V=\mathbb R^6$, and has **equal squares** ($\omega_i^2=-\tfrac14\mathrm{Id}_Q\oplus-\tfrac12\mathrm{Id}_P$ for both). It meets three of Claim P's four conditions and is a genuine near-miss.

**It fails only on the self-wedges, and only in the cross term.** Both $\Lambda^4Q$ parts are $\tfrac14\cdot2\,e^{1234}=\tfrac12 e^{1234}$, equal. The cross terms are $\pm\tfrac1{\sqrt2}\,J\wedge\varepsilon_P=\pm\tfrac1{\sqrt2}(e^{1256}+e^{3456})$, differing by $\sqrt2$ in each of the two components $e^{1256}$ and $e^{3456}$.

**So the correction to the box is one word.** The box says the three-signs step *"is false for two"* and that both retired steps are *"inert once the conclusion is stated as $\omega_2=\pm\omega_1$ against orthogonality"*. That is right, and the substitution it names is not orthogonality but the cross term: **orthogonality is what the near-miss above satisfies.** The cross term excludes $\rho_1\rho_2=-1$ before orthogonality is consulted, by forcing $\rho_1=\rho_2$, and only then does $2a\rho_1\rho_2=-b$ become $2a=-b$, impossible at $a,b>0$.

## 5. What Claim P actually proves: a rigidity statement, and orthogonality is spent last

**None of the three cases uses orthogonality to reach $\omega_2=\pm\omega_1$.** Case 1 reaches it from equal wedges through the sign algebra, case 2 from the star identity, case 3 from the cross term. Orthogonality enters once, at the end, to contradict $\mathop{\mathrm{tr}}(\omega_1\omega_2)=\mp2$. **So the theorem the three cases prove is:**

> **Let $\omega_1,\omega_2$ be $2$-forms on $\mathbb R^n$ with a common six-dimensional support $V$, with $\omega_1^2=\omega_2^2$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$. Then $\omega_2=\pm\omega_1$.**

Claim P is the corollary at $\lVert\omega_i\rVert=1$ and $\langle\omega_1,\omega_2\rangle=0$. **Equal norms are a consequence rather than a hypothesis** ($\mathop{\mathrm{tr}}A$ is common), and the normalisation to $\mathop{\mathrm{tr}}A=2$ is used nowhere in the rigidity statement, case 3's $4a+2b=2$ entering only the discarded orthogonality route. *I record the stronger form because it is what a fold would want and because it is what makes the pair version robust: the two closings the box calls three-index are replaced by nothing at all, the cases having already delivered $\omega_2=\pm\omega_1$ without them.*

## 6. Claim E: the two readings, the support, and the dimension

**$\lambda_2=-\lambda_1$.** [L180](../findings/diagonal-half.md)(1) is stated for a general nonzero $W$ in spectral form at any rank, and (2) says tracelessness is its trace: $\mathop{\mathrm{tr}}(\omega_i^2)=-2$, so the trace of $\sum_i\lambda_i\omega_i^2=0$ is $-2\sum_i\lambda_i=0$. At rank two this is $\lambda_2=-\lambda_1$. **CONFIRMED, and it follows from Ricci-flatness alone**, tracelessness being the same equation read on its trace rather than an independent input.

**The squares coincide.** $\lambda_1\omega_1^2+\lambda_2\omega_2^2=0$ at $\lambda_2=-\lambda_1\ne0$ is $\omega_1^2=\omega_2^2$. **CONFIRMED**, and it is [L180](../findings/diagonal-half.md)'s own rank-two note, which reads it as $A_1=A_2$.

**The self-wedges coincide.** [L179](../findings/diagonal-half.md)(b) reads first Bianchi as $\sum_{\lambda_\alpha\ne0}\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$, and it is stated over the whole nonzero spectrum at rank $r$, its *"three, at the rank L178 treats"* being an instance rather than the statement. At rank two, $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$. **CONFIRMED, and this is the place a three-form carry would have hidden.** It does not: the Bianchi map $\mathfrak b:S^2\Lambda^2\to\Lambda^4$ is rank-blind.

**Orthonormality.** It is the spectral theorem on the self-adjoint $W$ acting on $\Lambda^2$, so it is a property of the decomposition rather than an assumption. **CONFIRMED.**

**The common support is DERIVED.** $A_1=A_2$ gives $\ker\omega_1=\ker\omega_2$ and hence equal images (§0), and [L179](../findings/diagonal-half.md)(a) defines $V$ as the span of the supports of the eigenforms with nonzero eigenvalue, which is then that one common image. **So both forms are supported exactly on $V$ and lie in $\Lambda^2V$.** Claim E does not have to assume this.

**Six-dimensionality is a CASE HYPOTHESIS, and Claim E declares it.** What the record derives about $\dim V$ at rank two is: it is even, being a $2$-form's support, and it is at least four, because $\Lambda^2V$ is one-dimensional at $\dim V=2$ and cannot hold two orthonormal forms. **So $\dim V\in\{4,6,8,\dots\}$ and nothing narrows it further.** Claim E's *"empties the rank-two configuration at $\dim V=6$"* is therefore exact: it is a statement about one stratum of an open branch, chosen because Claim P applies there. **This is the step the brief asked about, and it is a hypothesis rather than a skipped derivation.** That is legitimate, because the claim is conditional on it.

**What the entailment leaves open, stated so a ledger row cannot inflate it.** [L180](../findings/diagonal-half.md)'s note has the rank-two branch open at every even $\dim V\ge6$. Claim P closes $\dim V=6$. **$\dim V\ge8$ remains open**, and no congruence bounds it: the rank-two spectrum condition is $\sum_j c_j^2=1$ over $m=\tfrac12\dim V$ values, which is satisfiable at every $m$, so there is no analogue of [L187](../findings/diagonal-half.md)'s $\dim V\equiv0\pmod4$ to lean on. **A row reading "rank two closed" would be wrong. The row is "rank two closed at $\dim V=6$".**

## 7. The dimension hypothesis is load-bearing, and the statement is false one dimension down

**At $\dim V=4$ the pair statement fails, by a configuration that is also a rank-two Weyl tensor.** Take the standard self-dual forms on $\mathbb R^4$,
$$\omega_1=\tfrac1{\sqrt2}(e^{12}+e^{34}),\qquad \omega_2=\tfrac1{\sqrt2}(e^{13}+e^{42}).$$
Both are unit and orthogonal, both have $\omega_i^2=-\tfrac12\mathrm{Id}_4$ so the squares coincide and the common support is all of $\mathbb R^4$, and both have $\omega_i\wedge\omega_i=e^{1234}$, since $e^{13}\wedge e^{42}=e^{1342}=e^{1234}$ by an even permutation. **So every hypothesis of Claim P except $\dim V=6$ holds, and the conclusion fails.** Consequently $W=\lambda(\omega_1\otimes\omega_1-\omega_2\otimes\omega_2)$ is Ricci-flat and satisfies first Bianchi, a rank-two Weyl tensor with $\dim V=4$: **the rank-two configuration is inhabited at four**, which is why [L180](../findings/diagonal-half.md)'s note needs a bound there rather than an emptiness, and why the pair statement has to be a six-dimensional theorem.

**Where the proof notices.** At $\dim V=4$ the trichotomy has two values, and in the degenerate one $A=\tfrac12I_4$ the case-2 route asks for $\star(J\wedge J)$, which lands in $\Lambda^0$ rather than $\Lambda^2$. The identity that closes case 2 exists only at $\dim V=6$, as the block states, and this witness is what that restriction is protecting.

## 8. The `HYPOTHESIS-DEBT`, items (i)–(iv)

- **(i) the $\varepsilon_j\wedge\varepsilon_k$ are independent.** In the frame adapted to the eigenplanes, $\varepsilon_j\wedge\varepsilon_k=e^{2j-1,2j,2k-1,2k}$ for $j<k$, three distinct members of the standard basis of $\Lambda^4V$. **CORRECT.**
- **(ii) $\alpha\mapsto\alpha\wedge\varepsilon_P$ is injective on $\Lambda^2Q$.** With $Q\perp P$ and $\varepsilon_P=e^{56}$, a basis $e^{ij}$ of $\Lambda^2Q$ maps to the distinct basis $4$-forms $e^{ij56}$. **CORRECT**, and the natural-isomorphism phrasing in the block is the same statement.
- **(iii) $\star_V:\Lambda^4V\to\Lambda^2V$ is an isomorphism at $\dim V=6$.** The star is an isometry $\Lambda^k\to\Lambda^{\dim V-k}$. **CORRECT**, and unused by the pair argument (§3), so it is a strengthening the proof does not need.
- **(iv) the base constant is $2$, and the sign.** In a $J$-adapted frame $J=\varepsilon_1+\varepsilon_2+\varepsilon_3$ and $J\wedge J=2(e^{1234}+e^{1256}+e^{3456})$. **I recomputed all three stars from $\beta\wedge\star\alpha=\langle\beta,\alpha\rangle\mathrm{vol}$ with $\mathrm{vol}=e^{123456}$:** $e^{1234}\wedge e^{56}=\mathrm{vol}$; $e^{1256}\wedge e^{34}=e^{125634}=\mathrm{vol}$, the block $34$ passing the block $56$ for a sign $(-1)^{2\cdot2}$; $e^{3456}\wedge e^{12}=e^{345612}=\mathrm{vol}$, the block $12$ passing a $4$-block for $(-1)^{2\cdot4}$. **All three signs are $+$**, so $\star_V(J\wedge J)=2J$ at the fixed orientation and $-2J$ at the other. **CORRECT as written.**
- **Well-definedness of $\epsilon_J$.** Two $J$-adapted frames differ by the real form of a matrix in $U(3)$, and $\det_{\mathbb R}=\lvert\det_{\mathbb C}\rvert^2=1>0$, so every $J$-adapted frame has one orientation and $\epsilon_J$ compares it to $V$'s. **CORRECT, and the block is right that connectedness of $SO(6)$ is a different statement**: it says the positively oriented frames form one component, which is silent on whether the $J$-adapted ones all sit there.

**Screens, reported as screens and not as evidence.** Four short constructed checks, seconds of compute, on objects built for the purpose: the star identity on the standard $J$ and on $300$ compatible complex structures $RJ_0R^{\mathsf T}$, returning $2\epsilon J$ with $\epsilon=\mathop{\mathrm{sign}}\det R$ in every instance; the $64$ sign patterns of case 1 at $(c_1^2,c_2^2,c_3^2)=(\tfrac12,\tfrac3{10},\tfrac15)$, of which $16$ are orthogonal and none has equal wedges; the case-3 near-miss of §4, returning orthonormality, equal squares and a cross-term difference of $\sqrt2$ in $e^{1256}$ and $e^{3456}$; and the $\dim V=4$ configuration of §7, returning both coincidences. **Each reproduces a value derived by hand above and none is cited as a reason to believe anything.**

## 9. Carry-over audit: a relation exact at three forms, or a formula with no dimension attached

| Step | Forms it needs | Dimension it needs | Status |
|---|---|---|---|
| $A$ has spectrum $\{c_j^2\}$ doubled, three values | one | $\dim V=6$, stated | clean |
| $\omega_2$ preserves $A$'s eigenspaces | two | none | clean |
| case 1's $\omega_i=\sum_js_{ij}c_j\varepsilon_j$ and $u_ju_k=1$ | two | three planes, so $\dim V=6$ | clean |
| $\mathop{\mathrm{tr}}(\omega_1\omega_2)=-2\eta$ | two | none | clean |
| $\star_V(J\wedge J)=2\epsilon_JJ$ | one | $\dim V=6$, stated twice and scoped to $V$ rather than $\mathbb R^n$ | clean |
| case 2's closing | **three in the block, two here** | none | **substitution required, and it is orthogonality** |
| case 3's cross term and $J_2=\tau_1\tau_2J_1$ | two | $\dim Q=4$, $\dim P=2$ | clean |
| case 3's $4a+2b=2$ and $\mathop{\mathrm{tr}}(J^2)=-4$ | one | $\dim V=6$ | clean, and unused by the pair route of §5 |
| case 3's three-signs closing | **three, and false at two** | none | **retired by the cross term, which the block's own corrected sentence already does** |

**No dimension-free formula was found**, which is the failure mode [L187](../findings/diagonal-half.md) was refuted for and [L190](../findings/diagonal-half.md)'s cross term repeated. **The one relation exact at three forms and used at two is case 2's linear independence**, and the box names it. *The block's case-3 body contains both the pair-valid route and the vestigial three-signs sentence, so the box's blanket statement about "cases 2 and 3 as written" is right for case 2 and overstated for case 3.*

## 10. Falsifiers, and what I did to look for them

**Claim P is falsified by** an orthonormal pair on a six-dimensional $V$ with equal squares and equal self-wedges. **I looked stratum by stratum, in closed form.** In case 1 the constraints reduce to a finite problem in the sign group: equal wedges force all $u_j$ equal, which puts $\mathop{\mathrm{tr}}(\omega_1\omega_2)$ at $\mp2$, and I confirmed that the orthogonal patterns are a nonempty set that the wedge condition misses entirely. In case 2 the constraint set is $\{J_2=\pm J_1\}$ by the star identity, which I recomputed from the definition of $\star$. In case 3 I built the only configuration the retired sign count admits, $b=2a$ at $a=\tfrac14$, verified that it satisfies orthonormality, common support and equal squares, and located its failure in the two cross-term components. **Nothing survives, and the near-miss shows the surviving hypothesis is exactly the one doing the work.**

**Claim E is falsified by** either reading being wrong, or by the rank-two configuration failing one of Claim P's hypotheses. **I checked the two readings against the general-rank statements of [L180](../findings/diagonal-half.md)(1)–(2) and [L179](../findings/diagonal-half.md)(b) rather than against their rank-three prose**, derived the common support instead of accepting it, and confirmed that six-dimensionality is where a derivation stops and a case begins. **The one way Claim E could still mislead is by being read as closing the branch**, which it does not: I looked for a bound on $\dim V$ at rank two and found none, the spectral condition $\sum_jc_j^2=1$ being satisfiable at every $m$.

**What would change these verdicts.** For P, a compatible complex structure on $\mathbb R^6$ with $\star_V(J\wedge J)$ not proportional to $J$, or a $\dim V=6$ pair outside the three strata. For E, a rank-two Weyl tensor at $\dim V=6$, which by P cannot exist, or a proof that $\dim V=4$ is forced at rank two, which would make the whole question moot and which the record does not have.
