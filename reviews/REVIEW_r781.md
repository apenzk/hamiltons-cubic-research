# Review r781, Gate 2 on L184, the coincident case at $\dim V=6$

*Cold brief: I worked from [BRIEF-g2-l184.md](BRIEF-g2-l184.md) and my own derivations, and read no part of [findings/](../findings/) except the single corrected Case 3 paragraph the coordinator asked me to audit mid-task ([diagonal-half.md:725](../findings/diagonal-half.md#L725)). **No numerical work was done; every value below is exact and was obtained by hand.** Log: [agent_logs/g2-l184-r781.log](../agent_logs/g2-l184-r781.log).*

## Claim table

| # | Claim as written | Verdict |
|---|---|---|
| 2a | $\omega_i$ commutes with $\omega_i^2$, hence preserves every eigenspace of $A$ | SOUND |
| 2b | $A$ is positive definite of trace $2$ on $V$, and $\dim V=6$ gives it | SOUND, VIA AN UNSTATED STEP ($V=\operatorname{im}A$) |
| 2c | $A$'s eigenvalues are doubled | SOUND (every multiplicity is even) |
| 3a | A skew map preserving a plane is a multiple of its area form | SOUND |
| 3b | Case 1 makes all three $\omega_i$ block-diagonal for **one** splitting | SOUND |
| 3c | Case 1's appeal to [L181](../findings/diagonal-half.md) closes the case | SOUND FOR EVEN $n$; HYPOTHESIS-DEBT FOR ODD $n$ |
| 4a | $\star(J\wedge J)=2\epsilon_JJ$ on $\mathbb R^6$, $\epsilon_J=\pm1$ by orientation | SOUND, derived independently below |
| 4b | Equal $J_i\wedge J_i$ forces $\epsilon_iJ_i$ all equal | SOUND ($\star$ is an isomorphism) |
| 4c | $\operatorname{tr}(K^2)=-6$, so orthogonality fails | SOUND |
| 4d | The $\star$ of Case 2 is the star of which space? | UNSTATED AND FALSE IF READ ON $\mathbb R^n$, $n>6$ |
| 4e | *Addition:* the contradiction is linear independence, not the trace | SOUND, AND STRICTLY BETTER THAN THE TRACE ROUTE |
| 4f | *Addition:* $\epsilon_J$ is well defined because $U(3)\subset SO(6)$ is connected | SOUND |
| 4g | *Addition:* the closure reaches nothing outside $n=6$ | SOUND IN SUBSTANCE, MISSTATED, it is $\dim V$, not $n$ |
| 4h | *Addition:* the matching triple witnesses that squares and orthonormality obstruct nothing | SOUND, AND IT DOES FAIL EQUAL WEDGES, computed in §12A |
| 5a | $\omega_i=\sqrt a\,J_i\oplus\tau_i\sqrt b\,\varepsilon_P$ is the general form | SOUND |
| 5b | *First draft:* $J\wedge J=2\,\mathrm{vol}_Q$ for **every** complex structure on a $4$-plane | FALSE, closed-form counterexample below |
| 5c | *Corrected:* $J\wedge J=2\eta\,\mathrm{vol}_Q$, $\eta=\pm1$ by orientation match | SOUND, AND THE REPAIR IS RIGHT |
| 6a | The wedge splits into a $\Lambda^4Q$ part and a $\Lambda^2Q\wedge\Lambda^2P$ cross term | SOUND (direct summands) |
| 6b | Equating cross terms forces $\tau_iJ_i$ all equal, hence $J_i=\sigma_iJ$ | SOUND, VIA AN UNSTATED INJECTIVITY |
| 6c | The $\Lambda^4Q$ condition is then automatic | SOUND, BUT ORDER-DEPENDENT, see §6.3 |
| 7a | $\operatorname{tr}(\omega_i\omega_j)=-4a\sigma_i\sigma_j-2b\tau_i\tau_j$, both constants | SOUND |
| 7b | Three signs with all pairwise products equal force the product $+1$ | SOUND |
| 7c | $4a=-2b$, impossible | SOUND, and REDUNDANT, see §7.3 |
| 8 | The three cases are exhaustive | SOUND, derived independently below |
| 9 | No step assumes $\ker W=0$ or $V=\mathbb R^n$ | SOUND, except 4d |
| 10 | Boundary: $\dim V=4$, $\dim V\ge8$, odd $n$, small $n$ | ODD $n$ IS THE ONE LIVE GAP |
| 11 | "What is left of [I38](../plan.md) is the distinct-and-collinear case at $\dim V\ge6$" | OVERREACH, two ways, §11 |
|, | **The Lemma statement itself** | **TRUE, AND PROVED FOR EVEN $n$** |

**Overall: REPAIR-REQUIRED.** The statement holds and all three cases genuinely close; the Case 3 repair is correct; what still has to change before the block is citable is the odd-$n$ appeal to Given C, the unstated ambient space of $\star$ in Case 2, and the concluding box, which claims a residual scope the block does not establish.

## 0. Conventions, fixed once

- $Q\perp P$ are the eigenspaces of $A$; $V=Q\oplus P$, $\dim V=6$. Orientations of $V$, $Q$ and $P$ are chosen once and never varied.
- A skew matrix $\omega$ and its $2$-form are identified throughout; $\varepsilon_j$ denotes the unit area form of an oriented plane, $e^{kl}$ the monomial $e^k\wedge e^l$, and $\lVert\omega\rVert^2=-\tfrac12\operatorname{tr}(\omega^2)$, so orthonormality of the $\omega_i$ reads $\operatorname{tr}(\omega_i\omega_j)=-2\delta_{ij}$.
- A *complex structure on a Euclidean space* means an orthogonal skew $J$ with $J^2=-\mathrm{Id}$; skewness plus $J^2=-\mathrm{Id}$ already gives $J^{\mathsf T}J=-J^2=\mathrm{Id}$, so orthogonality is free and never has to be assumed.
- **None of the programme's constants appears in this block.** No $\sqrt{3/2}$, no $\theta_0(12)=1.236033$, no $6+2\sqrt7$, no restriction to even $n\ge12$. The block is pure linear algebra plus one citation, and that is as it should be.

## 1. Hypothesis inventory

**Used and stated.** Orthonormality of $\omega_1,\omega_2,\omega_3$; the coincidence $\omega_1^2=\omega_2^2=\omega_3^2$; the coincidence $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2=\omega_3\wedge\omega_3$; $\dim V=6$; rank exactly three, i.e. $\lambda_i\ne0$, which is what makes $\{\omega_i\}$ *the* set of eigen-$2$-forms with nonzero eigenvalue that Given C quantifies over.

**Used and unstated.** (i) $V=\operatorname{im}A$, the three supports coincide because $\operatorname{im}\omega_i=\operatorname{im}(\omega_i\omega_i^{\mathsf T})=\operatorname{im}A$ for each $i$, and only this turns "$\dim V=6$" into "$A$ has rank $6$", which the whole spectral analysis rests on. One line, missing. (ii) The injectivity of $\alpha\mapsto\alpha\wedge\varepsilon_P$ in Case 3 (§6.2). (iii) The ambient space of $\star$ in Case 2 (§4.3).

**Stated and unused.** The wedge coincidence is never used in Case 1, the case is closed on $\omega_i^2$ coincidence plus Given C alone. Givens A and B are used only inside Given C; the block invokes no Weyl condition of its own. Consequently **Cases 2 and 3 prove something strictly stronger than stated**: no orthonormal triple in $\Lambda^2\mathbb R^n$ with coincident $\Phi$-images and $\dim V=6$ exists at all, Weyl or not. Given D is stated and correctly unused: nothing here is a $\dim V=4$ finding.

## 2. The setup (brief item 2)

**2.1 Commuting.** $\omega_i$ commutes with $\omega_i^2=-A$ trivially, and any operator commuting with $A$ preserves each eigenspace of $A$. The step is sound, and it is precisely here that the $\omega^2$-coincidence does its work: $A$ is *one* operator, so *all three* $\omega_i$ commute with it and *one* eigenspace decomposition serves all three. That is the hinge of the whole lemma, and the block states it correctly.

**2.2 Positive definiteness.** $A=\omega_i\omega_i^{\mathsf T}$ is positive semidefinite on $\mathbb R^n$ with $\operatorname{tr}A=-\operatorname{tr}(\omega_i^2)=2\lVert\omega_i\rVert^2=2$. Its restriction to its own image is positive definite by construction, and $\operatorname{im}A=V$ by the unstated step above, so $A|_V$ is positive definite of rank $6$ and trace $2$. **Verdict: true, and $\dim V=6$ does give it, but only through $V=\operatorname{im}A$, which the block should write down.**

**2.3 Doubling.** On an eigenspace $E_\mu$ of $A|_V$ with $\mu>0$, $\omega_i|_{E_\mu}$ is skew with square $-\mu\,\mathrm{Id}$, so $\mu^{-1/2}\omega_i|_{E_\mu}$ is a complex structure and $\dim E_\mu$ is even. Hence **every multiplicity of $A|_V$ is even**, which is exactly what licenses writing the spectrum as $\{c_1^2,c_1^2,c_2^2,c_2^2,c_3^2,c_3^2\}$. Sound.

## 3. Case 1 (brief item 3)

**3.1 The plane restriction.** The skew $2\times2$ matrices form a one-dimensional space spanned by the area form, so a skew map preserving a plane restricts there to a multiple of $\varepsilon_j$. With $\omega_i|_{P_j}^2=-c_j^2\mathrm{Id}$ the multiple is exactly $\pm c_j$, and $c_j\ne0$ by positive definiteness. Sound.

**3.2 One splitting for all three.** Yes, and for the reason in §2.1: $P_1,P_2,P_3$ are the eigenplanes of the *common* $A$, and preserving each eigenplane while vanishing on $V^\perp$ makes each $\omega_i$ block-diagonal with no cross terms. So all three lie in $\operatorname{span}_{\mathbb R}\{\varepsilon_1,\varepsilon_2,\varepsilon_3\}$, which is the hypothesis Given C asks for. Sound.

**3.3 The citation.** Given C is stated for an orthogonal decomposition of **$\mathbb R^n$** into planes. For even $n$ one extends $P_1,P_2,P_3$ by any plane decomposition of the $(n-6)$-dimensional $V^\perp$ and the citation is exact. **For odd $n$ no such decomposition of $\mathbb R^n$ exists**, so Given C as stated is unavailable and the block, which quantifies over all $n$, has no argument on file for odd $n$. Verdict `HYPOTHESIS-DEBT`, narrow: it is a citation-scope defect, not a mathematical doubt, and I decline to write the repair.

**3.4 A remark the block may want.** The wedge hypothesis is discarded in Case 1. Kept, it gives $\omega_i\wedge\omega_i=2\sum_{j<k}\varepsilon_{ij}\varepsilon_{ik}c_jc_k\,\varepsilon_j\wedge\varepsilon_k$ where $\omega_i=\sum_j\varepsilon_{ij}c_j\varepsilon_j$; the $\varepsilon_j\wedge\varepsilon_k$ are independent and $c_jc_k\ne0$, so equality across $i$ pins every $\varepsilon_{ij}\varepsilon_{ik}$, and by the same three-signs lemma the block itself uses in Case 3, $\omega_i=\pm\omega_1$. That contradicts orthonormality outright. I record this as an observation, not as a repair I am supplying: it would make Case 1 independent of Given C and would therefore dissolve §3.3's odd-$n$ debt as a side effect, and it would put all three cases on the single mechanism *the hypotheses force the triple to be collinear*.

## 4. Case 2, derived independently (brief item 4)

**4.1 The identity.** Let $J$ be a complex structure on an oriented $6$-space $V$ with $2$-form $\omega_J$. Pick a $J$-adapted orthonormal frame $e_1,\,e_2=Je_1,\,e_3,\,e_4=Je_3,\,e_5,\,e_6=Je_5$, so $\omega_J=e^{12}+e^{34}+e^{56}$. Then
$$\omega_J\wedge\omega_J=2\left(e^{1234}+e^{1256}+e^{3456}\right).$$
Take the orientation with $\mathrm{vol}=e^{123456}$. Each of $e^{1234}\wedge e^{56}$, $e^{1256}\wedge e^{34}$ and $e^{3456}\wedge e^{12}$ equals $e^{123456}$ (the middle one because $(5,6,3,4)\mapsto(3,4,5,6)$ is an even permutation) so $\star e^{1234}=e^{56}$, $\star e^{1256}=e^{34}$, $\star e^{3456}=e^{12}$ and
$$\star(\omega_J\wedge\omega_J)=2\left(e^{56}+e^{34}+e^{12}\right)=2\,\omega_J.$$
Reversing the ambient orientation negates $\star$ and leaves $\omega_J\wedge\omega_J$ alone, so against a fixed orientation of $V$ the identity is $\star(\omega_J\wedge\omega_J)=2\epsilon_J\omega_J$ with $\epsilon_J=+1$ when $J$'s adapted frames are positively oriented and $-1$ when they are not. **The block's identity is correct, and its "$\epsilon_J=\pm1$ by orientation" names the right dichotomy.**

*Bookkeeping check that both signs occur, so the $\epsilon_J$ is not decoration:* an adapted frame for $-J$ is $(e_1,-e_2,e_3,-e_4,e_5,-e_6)$, of orientation $(-1)^3=-1$ times that of $J$'s, so $\epsilon_{-J}=-\epsilon_J$. This is consistent with the identity read on $\omega_{-J}=-\omega_J$: $\star(\omega_{-J}\wedge\omega_{-J})=\star(\omega_J\wedge\omega_J)=2\omega_J=-2\,\omega_{-J}$. Complex dimension $3$ is odd, which is why negation flips the orientation here and (see §5), does not in dimension $4$.

**4.2 The forcing.** $\star:\Lambda^4V\to\Lambda^2V$ is a linear isomorphism, so equality of the $J_i\wedge J_i$ gives equality of the $\epsilon_iJ_i$, exactly and not merely up to something weaker. Setting $K=\epsilon_1J_1$ gives $J_i=\epsilon_iK$, i.e. $J_i=\pm K$. Sound.

**4.3 The contradiction.** $K^2=-\mathrm{Id}_V$ with $\dim V=6$ gives $\operatorname{tr}(K^2)=-6$; the block's value is right. With $A=cI_6$ on $V$ and $\operatorname{tr}A=2$ we get $c=1/3$, and $\operatorname{tr}(\omega_i\omega_j)=c\,\epsilon_i\epsilon_j\operatorname{tr}(K^2)=-2\epsilon_i\epsilon_j=\pm2\ne0$, against $\operatorname{tr}(\omega_i\omega_j)=0$. Sound. The block drops the factor $c$ when it writes "$\operatorname{tr}(J_iJ_j)=\pm6$ against orthogonality"; harmless, since $c>0$ is all that is needed.

**4.4 The one real defect in Case 2.** $\star$ is never said to be the Hodge star **of $V$**. Read on $\mathbb R^n$ with $n>6$ the identity is false on its face, $\star(J\wedge J)$ then lies in $\Lambda^{n-4}$, not $\Lambda^2$. The mathematics is fine because $\omega_i\in\Lambda^2V$ and the whole computation lives in $\Lambda^\bullet V$, but the block must say so, and must also record that an orientation of $V$ is chosen (any one; $\epsilon_J$ flips with it and the conclusion does not).

**4.5 The addition: the contradiction is linear independence, and it is the better one.** Correct, and I would put it ahead of the trace route. $\star$ is an isomorphism, so equal wedges give $\epsilon_iJ_i$ all equal *exactly*, hence $J_i=\pm K$ and $\omega_i=\pm\sqrt c\,K$: the three forms span a line. A rank-three $W$ has three linearly independent eigen-$2$-forms with nonzero eigenvalue, so this alone closes the case, and $\operatorname{tr}(J_iJ_j)=\pm6$ was never needed. Two reasons to prefer it: it consumes only **linear independence**, a strictly weaker hypothesis than orthonormality, so the case closes for any independent triple; and it drops the constants $c=1/3$ and $\operatorname{tr}(K^2)=-6$, which are the only places a numerical slip could hide. §4.3 above stands as a valid but redundant route, and it is the same collinearity that closes Cases 1 and 3 (§3.4, §6.4).

**4.6 The addition: $\epsilon_J$ is well defined.** Correct, and the reason given is the right one. The $J$-adapted orthonormal frames form a torsor under the group of orthogonal maps commuting with $J$, which is $U(3)$; $U(3)$ is connected and lands in $SO(6)$ since a complex-linear map has real determinant $\lvert\det_{\mathbb C}\rvert^2>0$. A connected family of frames cannot change orientation class, so every $J$-adapted frame induces the same orientation of $V$ and $\epsilon_J=\pm1$ depends on $J$ alone, not on the frame used to read it. This is the step my §4.1 left implicit by computing in one chosen frame, and the addition supplies it correctly.

**4.7 The addition: the reach of the closure.** The substance is right and the statement is misworded. What is true: $\star(\omega_J\wedge\omega_J)$ lands in $\Lambda^2$ of a $d$-dimensional space exactly when $d-4=2$, so this mechanism is confined to a **six-dimensional $V$** and gives nothing at $\dim V=8$. What is written ("nothing outside $n=6$"), reads on the ambient dimension, and there Case 2 is *not* confined: the whole computation lives in $\Lambda^\bullet V$, so it holds for every $n\ge6$ with $\dim V=6$. Substitute $\dim V$ for $n$ and the remark is exact. This is the same conflation as 4d and should be fixed in the same pass.

## 5. Case 3, the splitting, and the audit of the repair (brief item 5)

**5.1 The general form is right.** $A|_V$ has eigenspaces $Q$ ($\dim4$, eigenvalue $a$) and $P$ ($\dim2$, eigenvalue $b$), both preserved by every $\omega_i$, which vanishes on $V^\perp$. On $Q$, $(\omega_i|_Q)^2=-a\,\mathrm{Id}$ makes $a^{-1/2}\omega_i|_Q=:J_i$ a complex structure; on $P$, skewness makes $\omega_i|_P$ a multiple of $\varepsilon_P$ and the square condition fixes the multiple to $\tau_i\sqrt b$, $\tau_i=\pm1$. So $\omega_i=\sqrt a\,J_i\oplus\tau_i\sqrt b\,\varepsilon_P$ is fully general. Sound.

**5.2 The flagged claim is false, in closed form.** On $Q$ with $\mathrm{vol}_Q=e^{1234}$, both
$$\omega=e^{12}+e^{34}\qquad\text{and}\qquad\omega'=e^{12}-e^{34}$$
are $2$-forms of complex structures ($\omega'$ belongs to $J'$ with $J'e_1=e_2,\ J'e_3=-e_4$, which is skew with $J'^2=-\mathrm{Id}$) and
$$\omega\wedge\omega=+2\,\mathrm{vol}_Q,\qquad \omega'\wedge\omega'=-2\,\mathrm{vol}_Q.$$
**So $J\wedge J=2\,\mathrm{vol}_Q$ holds only for the self-dual complex structures, and the anti-self-dual ones give $-2\,\mathrm{vol}_Q$.** In complex dimension $2$ negation preserves orientation, $(-1)^2=+1$, so each of the two families is closed under $J\mapsto-J$ and both are non-empty; the dichotomy is real, not an artefact of sign convention. The first draft's clause was false as written.

**5.3 The repair on file is correct.** The corrected paragraph now reads $J\wedge J=2\eta\,\mathrm{vol}_Q$ with $\eta=\pm1$ by orientation match, which is exactly §5.2, and it moves the load onto the cross term. I audited the on-disk text at [diagonal-half.md:725](../findings/diagonal-half.md#L725) and it matches the coordinator's account word for word. **The repair is right, it is minimal, and it costs the conclusion nothing**, my §6 checks each of its three joints.

**5.4 Independence.** I derived §5.2 myself, before the coordinator's message arrived and from the brief's quotation alone; the counterexample $e^{12}-e^{34}$ above is mine and does not appear in the coordinator's account, which argues the point through frame orientation instead. I cannot evidence the timing to you, so take the substance as the claim: the derivation is here in full, it is reproduced from a different angle than the one I was handed, and §6.4 and §7.3 carry two consequences of the repair that the coordinator's account does not draw.

## 6. Case 3, the cross term, the coordinator's three attacks (brief item 6)

**6.1 Does the cross term separate from the $\Lambda^4Q$ part?** Yes, and cleanly. $\Lambda^4V=\bigoplus_{p+q=4}\Lambda^pQ\wedge\Lambda^qP$ is a direct sum, and with $q\le\dim P=2$ only $p+q\in\{(4,0),(3,1),(2,2)\}$ survive. Writing $\omega_i=\alpha_i+\beta_i$ with $\alpha_i=\sqrt a\,J_i\in\Lambda^2Q$ and $\beta_i=\tau_i\sqrt b\,\varepsilon_P\in\Lambda^2P$,
$$\omega_i\wedge\omega_i=\underbrace{a\,J_i\wedge J_i}_{\Lambda^4Q}+\underbrace{2\tau_i\sqrt{ab}\,J_i\wedge\varepsilon_P}_{\Lambda^2Q\wedge\Lambda^2P}+\underbrace{b\,\varepsilon_P\wedge\varepsilon_P}_{=0},$$
the last vanishing because $\Lambda^4P=0$. The $(3,1)$ component is absent for parity, not by assumption. Two terms in two distinct direct summands means the equality $\omega_i\wedge\omega_i=\omega_j\wedge\omega_j$ splits into two independent equalities. **The separation claimed is genuine.**

**6.2 Does equating the cross terms force $\tau_iJ_i$ equal, or something weaker?** Exactly that, nothing weaker. The map $\varphi:\Lambda^2Q\to\Lambda^4V$, $\varphi(\alpha)=\alpha\wedge\varepsilon_P$, is injective: in an orthonormal frame with $\varepsilon_P=f^{12}$, $\varphi$ sends the six basis monomials $e^{kl}$ of $\Lambda^2Q$ to the six distinct basis monomials $e^{kl}\wedge f^{12}$ of $\Lambda^4V$, which are linearly independent. The scalar $2\sqrt{ab}$ is nonzero since $a,b>0$. So $\tau_iJ_i\wedge\varepsilon_P=\tau_jJ_j\wedge\varepsilon_P$ gives $\tau_iJ_i=\tau_jJ_j$ on the nose, hence $J_i=\sigma_iJ$ for a single complex structure $J$ and signs $\sigma_i$. **Sound, but the injectivity is the one link the corrected paragraph still leaves implicit, and it is worth the half-line.**

**6.3 Is the $\eta$ condition genuinely automatic?** Yes, *given the cross-term step, and only in that order*. Once $\tau_iJ_i$ is $i$-independent, $J_i=\sigma_iJ$ with $\sigma_i=\pm1$, so $J_i\wedge J_i=\sigma_i^2\,J\wedge J=J\wedge J$, and the $\Lambda^4Q$ components $a\,J_i\wedge J_i$ agree for free. The coordinator's phrasing ($(-J)\wedge(-J)=J\wedge J$ leaves $\eta$ unchanged), is the same computation and is correct. **The caution I attach:** taken on its own, before the cross-term step, the $\Lambda^4Q$ equality is *not* vacuous, it says $\eta_1=\eta_2=\eta_3$, a real restriction on an arbitrary triple of complex structures on $Q$. It is automatic only as a *consequence* of the conclusion drawn from the other component. So "automatic" is true as the corrected text sequences it, and would be false if the two components were discussed in the other order or in isolation. Nothing has been waved through; the sequencing is just load-bearing and should stay explicit.

**6.4 What the repair additionally buys, which the account does not draw.** The cross term gives $\tau_iJ_i=\tau_1J_1$, so with $J:=J_1$ one gets $\sigma_i=\tau_i\tau_1$ and hence $\rho_i:=\sigma_i\tau_i=\tau_1$ for every $i$, **the $\rho_i$ are equal before orthogonality is ever invoked**. Equivalently
$$\omega_i=\tau_i\left(\tau_1\sqrt a\,J_1+\sqrt b\,\varepsilon_P\right)=\tau_i\tau_1\,\omega_1,$$
so the three forms are collinear, $\omega_i=\pm\omega_1$. This is the same mechanism as Case 2 (§4.2) and as the Case 1 remark (§3.4).

## 7. Case 3, the sign identity (brief item 7)

**7.1 The trace formula and both constants.** $J^2=-\mathrm{Id}_Q$ with $\dim Q=4$ gives $\operatorname{tr}(J^2)=-4$; $\varepsilon_P^2=-\mathrm{Id}_P$ with $\dim P=2$ gives $\operatorname{tr}(\varepsilon_P^2)=-2$. The two blocks are orthogonal, so
$$\operatorname{tr}(\omega_i\omega_j)=a\,\sigma_i\sigma_j\operatorname{tr}(J^2)+b\,\tau_i\tau_j\operatorname{tr}(\varepsilon_P^2)=-4a\,\sigma_i\sigma_j-2b\,\tau_i\tau_j.$$
**Both constants check.**

**7.2 The three-signs step.** Orthogonality at all three pairs gives $\sigma_i\sigma_j/(\tau_i\tau_j)=\rho_i\rho_j=-b/(2a)=:k$, one constant. From $\rho_1\rho_2=\rho_1\rho_3$ follows $\rho_2=\rho_3$, and likewise all three $\rho_i$ agree, so $k=\rho_i^2=+1$. (Equivalently $(\rho_1\rho_2\rho_3)^2=k^3$ gives $k^3=1$ with $k=\pm1$, so $k=+1$.) Then $4a=-2b$ with $a,b>0$ is impossible, doubly so, since $4a+2b=\operatorname{tr}A=2$ would additionally force $0=2$. **Sound.**

**7.3 It is redundant, and the block should say which route it is taking.** By §6.4 the wedge hypothesis alone already fixes $\rho_i=\tau_1$ for all $i$, so the "three signs with all pairwise products equal" lemma is proving something the previous step has handed over. Worse for the reader, presenting $\sigma_i$ and $\tau_i$ as independent signs at this point *discards* information the argument has already earned. It is safe (a contradiction from less information is still a contradiction) but the honest short route is $\omega_i=\pm\omega_1$ against $\operatorname{tr}(\omega_i\omega_j)=0$, which needs neither trace constant. I flag this as presentation, not as error.

## 8. Exhaustiveness (brief item 8), derived independently

By §2.3 every eigenvalue multiplicity of $A|_V$ is even, and they sum to $6$. The partitions of $6$ into even parts are
$$6=2+2+2,\qquad 6=4+2,\qquad 6=6,$$
and these are precisely: three distinct values (Case 1, three eigenplanes), two distinct values (Case 3, a $4$-plane and a plane, with $a$ naming whichever value has multiplicity $4$, so both assignments are covered), one value (Case 2, $A=cI_6$). Read through the block's own parameterisation $\{c_1^2,c_1^2,c_2^2,c_2^2,c_3^2,c_3^2\}$, the possible agreement patterns among $c_1^2,c_2^2,c_3^2$ are: none, exactly two, all three, and "exactly two agree" is a single case up to relabelling. **The three cases are exhaustive and I find no configuration missed.** The one thing that makes it exhaustive is the evenness of the multiplicities, which is a theorem (§2.3) and not an assumption, and which in turn needs $A$ positive definite on $V$, a zero eigenvalue would be free to have odd multiplicity, and is excluded only because $V=\operatorname{im}A$.

## 9. The kernel (brief item 9)

$\ker\omega_i=V^\perp$ is $(n-6)$-dimensional and generally nonzero. No step needs it to vanish: $A$ is handled as an operator on $V$ throughout ("positive definite of trace $2$ on $V$"), the case split is a statement about $A|_V$, and $\omega_i\wedge\omega_i\in\Lambda^4V\subset\Lambda^4\mathbb R^n$ so the wedge equalities may be read inside $\Lambda^4V$ without loss. The single place where the ambient space is silently switched is the $\star$ of Case 2 (§4.4), and that is a notational debt rather than a use of $\ker W=0$. **No step assumes a trivial kernel.**

## 10. The boundary (brief item 10)

- **$\dim V=4$.** Given D closes it off and the block correctly claims nothing there. Note that Case 3's shape has no $\dim V=4$ analogue anyway: $4=2+2$ splits as Case 1 or as $4$, never as $4+2$.
- **$\dim V\ge8$.** The block claims nothing, and is right to. Case 1's argument survives verbatim wherever all the $c_j^2$ are pairwise distinct; the other multiplicity patterns at $\dim V=8$ ($4+2+2$, $4+4$, $6+2$, $8$), are untried, and neither Case 2's $\mathbb R^6$ Hodge identity nor Case 3's $4+2$ decomposition transfers as written. The footnote in the block says this accurately.
- **Odd $n$.** The live gap of §3.3. Nothing else in the block cares about the parity of $n$; Cases 2 and 3 are internal to $V$ and use no decomposition of $\mathbb R^n$.
- **$n$ below the conjecture's range.** The block is stated for all $n$ and uses no threshold, so nothing breaks; $n\ge6$ is needed only for $\dim V=6$ to be possible at all, and that is implicit in the hypothesis. **No forbidden constant appears anywhere in the block**, I checked for all four named in the brief and found none.

## 11. Overreach (brief item 11)

The concluding box says: *what is left of I38 is one case, the images are distinct and collinear, at $\dim V\ge6$.* **That is not entailed, in two separate ways.**

1. **The trichotomy is wrong.** Three collinear points in the image of $\Phi$ are either all equal, all distinct, or *two equal and one different*. L184 closes only the first. The residual is therefore "not all three images equal", which strictly contains the partially-coincident configuration; the box's "distinct" silently drops it. Either the box must say "not all coincident", or a separate argument must reduce the two-equal-one-different configuration to one of the settled cases, and no such argument is in the block.
2. **The dimension range is wrong, by the block's own footnote.** The headline claims the residue at $\dim V\ge6$; the footnote immediately concedes that nothing here reaches $\dim V\ge8$, where Cases 2 and 3 are untried. The coincident case is therefore open at $\dim V\ge8$ and the box contradicts itself within three sentences.

What the block does entail is the narrower and still worthwhile statement: **at $\dim V=6$ the fully coincident configuration is empty.** The headline should be cut to that.

## 12. What would break it, and what I did to look

**The falsifier.** A rank-three $W\in\mathcal W_n$ with $\dim V=6$ and $\Phi(\omega_1)=\Phi(\omega_2)=\Phi(\omega_3)$, concretely, an orthonormal triple in $\Lambda^2\mathbb R^6$ with a common square and a common self-wedge. Weaker but still fatal to a case: for Case 3, a triple $\{\tau_iJ_i\}$ on a $4$-plane not all equal yet with equal cross terms, refuted by the injectivity in §6.2; for Case 2, two distinct complex structures on $\mathbb R^6$ with equal self-wedge, refuted by $\star$ being an isomorphism in §4.2; for Case 1, block-diagonal $\omega_i$ escaping Given C, refuted by §3.2 giving one common splitting.

**What I did to look.** I ran no search, sweep, census or falsifier hunt, in keeping with the analysis-only footing recorded in [analysis-only.md](../.claude/rules/analysis-only.md), and I performed no computation of any kind, every identity above was derived by hand in a fixed frame and every value is exact. The one object I exhibited in closed form, $e^{12}-e^{34}$ on an oriented $4$-plane, refutes a stated justification (§5.2) and not the Lemma. Structurally, all three cases converge on $\omega_i=\pm\omega_1$ (§3.4, §4.2, §6.4), and orthonormality of three forms is incompatible with their collinearity, so I expect no falsifier to exist at $\dim V=6$; I record that as an expectation, not as a result.

## 12A. The witness triple (coordinator's second addition)

**The construction is correct.** Take the three pairwise edge-disjoint perfect matchings of $\{1,\dots,6\}$
$$M_1=\{12,34,56\},\qquad M_2=\{13,25,46\},\qquad M_3=\{14,26,35\},$$
and let $J_k=\sum_{ab\in M_k}e^{ab}$. Each $M_k$ is a perfect matching, so $J_k$ is block-diagonal with three $2\times2$ rotation generators and $J_k^2=-\mathrm{Id}_6$, giving $A_k=\mathrm{Id}$ for all three, the squares coincide. Edge-disjointness makes the matrix supports disjoint, so $\operatorname{tr}(J_kJ_l)=-\sum_{a,b}(J_k)_{ab}(J_l)_{ab}=0$ termwise for $k\ne l$. Each has $\lVert J_k\rVert^2=3$, so $\{J_k/\sqrt3\}$ is orthonormal with common $A=\tfrac13\mathrm{Id}$ of trace $2$, exactly the Case 2 setup. **So neither the equal squares nor orthonormality obstructs anything at $\dim V=6$, and the entire force of Case 2 is the wedge condition.** The witness is right and it is the honest thing to record: it shows the case is not closed by a hypothesis that costs nothing.

**They do fail equal wedges, verified in closed form.** For $\omega=e^{ab}+e^{cd}+e^{ef}$ over a matching, $\omega\wedge\omega=2\left(e^{ab}\!\wedge e^{cd}+e^{ab}\!\wedge e^{ef}+e^{cd}\!\wedge e^{ef}\right)$, each term a single sorted monomial up to sign:
$$J_1\wedge J_1=2\left(e^{1234}+e^{1256}+e^{3456}\right),$$
$$J_2\wedge J_2=2\left(-e^{1235}+e^{1346}-e^{2456}\right),$$
$$J_3\wedge J_3=2\left(-e^{1246}-e^{1345}+e^{2356}\right).$$
The signs come from sorting: $e^{13}\wedge e^{25}=-e^{1235}$ and $e^{25}\wedge e^{46}=-e^{2456}$ each need one transposition, $e^{13}\wedge e^{46}=+e^{1346}$ none; $e^{14}\wedge e^{26}=-e^{1246}$ and $e^{14}\wedge e^{35}=-e^{1345}$ one each, $e^{26}\wedge e^{35}=+e^{2356}$ two. **The three supports $\{1234,1256,3456\}$, $\{1235,1346,2456\}$, $\{1246,1345,2356\}$ are pairwise disjoint and every coefficient is $\pm2$**, so the three wedges are pairwise distinct, indeed pairwise orthogonal in $\Lambda^4\mathbb R^6$, the furthest from equal they could be. No two of them share a wedge, so the witness does not endanger Case 2.

**Independent cross-check against §4.1.** Applying $\star$ with $\mathrm{vol}=e^{123456}$: $\star e^{1235}=-e^{46}$, $\star e^{1346}=+e^{25}$, $\star e^{2456}=-e^{13}$, giving $\star(J_2\wedge J_2)=2(e^{13}+e^{25}+e^{46})=2J_2$; and $\star e^{1246}=-e^{35}$, $\star e^{1345}=-e^{26}$, $\star e^{2356}=+e^{14}$, giving $\star(J_3\wedge J_3)=2J_3$; with $\star(J_1\wedge J_1)=2J_1$ from §4.1. So $\epsilon_1=\epsilon_2=\epsilon_3=+1$, all three are complex structures for the *same* orientation, and the identity of §4.1 then predicts that equal wedges would force $J_1=J_2=J_3$, false, since they are orthogonal. The prediction and the direct computation agree, which is the check worth having: the witness confirms the identity rather than straining it.

*All of the above is exact hand algebra in a fixed basis (sorting signs and inversion counts) and no computation was run.*

## Verdict

**REPAIR-REQUIRED.** The Lemma is **true** and, for even $n$, **proved**: the case division is exhaustive, and each of the three cases closes. The Case 3 repair now on file is **correct**, the cross term does separate, it does force $\tau_iJ_i$ equal rather than something weaker, and the $\eta$ condition is genuinely automatic once the cross term is settled first. Three things must change before the block is citable:

1. **Case 1's odd-$n$ citation.** Given C is stated for a plane decomposition of $\mathbb R^n$, which does not exist for odd $n$; the block quantifies over all $n$. `HYPOTHESIS-DEBT`, and I decline to write the fix.
2. **Case 2's $\star$.** Say it is the Hodge star of the oriented six-space $V$. Read on $\mathbb R^n$ the identity is false for $n>6$.
3. **The concluding box.** Cut it to "at $\dim V=6$ the coincident configuration is empty". As written it drops the two-equal-one-different configuration and contradicts its own footnote on $\dim V\ge8$.

**On the two additions received mid-review:** both are right. The linear-independence route through $\star$ replaces the trace computation and should become Case 2's argument of record, since it consumes only independence of the eigenforms (§4.5); the $U(3)$ connectedness argument correctly supplies the well-definedness of $\epsilon_J$ that my own frame computation left implicit (§4.6); the "nothing outside $n=6$" remark is right about the mechanism but should say $\dim V$, not $n$ (§4.7); and the matching triple is a genuine witness that squares and orthonormality obstruct nothing at $\dim V=6$, I verified in closed form that its three wedges are pairwise orthogonal, so it fails the wedge condition and leaves Case 2 intact (§12A).

Two smaller debts, both one line: $V=\operatorname{im}A$ (§1), and the injectivity of $\alpha\mapsto\alpha\wedge\varepsilon_P$ (§6.2). And one credit the block is not claiming: **Cases 2 and 3 use no Weyl condition at all**, so they close the configuration for any orthonormal triple in $\Lambda^2\mathbb R^n$, not merely for Weyl tensors.
