# r808: Gate 2 on L184's pair statement, and on the rank-two entailment that would use it

*Cold brief: I was given the two claims and the pointers, and read [findings/diagonal-half.md](../findings/diagonal-half.md) (L179, L180, L183, L184, L185, L186, L190), [L184Statement.lean](../lean/HamiltonsCubic/Results/L184Statement.lean), [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) and [plan.md](../plan.md) from scratch. **The programme is on an analysis-only footing and I opened no numerical line of work.** Every derivation below is by hand and every constant is exact. Two machine actions were screens, reported as screens and never as evidence for a positive claim, in section 8. Log: [agent_logs/g2-l184pair-r808.log](../agent_logs/g2-l184pair-r808.log).*

| Claim | Verdict |
|---|---|
| **P**: no orthonormal **pair** of $2$-forms with a common six-dimensional support has both its squares and its self-wedges coincident | **CONFIRMED**, all three cases, on the substitutions the observation box names and by no other route |
| **P.1**: the case split survives the drop from three forms to two | **CONFIRMED.** Every input is a one-form fact plus the common square, and the planes are $A$'s eigenspaces rather than either form's normal-form planes, which is what makes the fold legal |
| **P.2**: case 1's $u_ju_k=1$ at all three pairs forces $\omega_2=\eta\omega_1$ | **CONFIRMED**, and two of the three equations already suffice |
| **P.3**: case 2 closes on $\star_V(J\wedge J)=2\epsilon_JJ$ alone, the rank argument inert | **CONFIRMED.** Only linearity of $\star_V$ is used, never injectivity, and the closing is orthogonality. Machine-screened |
| **P.4**: case 3 closes on the cross term, the three-signs count being false for two | **CONFIRMED in both halves.** $\rho_1\rho_2=-1$ with $b=2a$ is a genuine configuration and is excluded by the cross term, not by the sign count. Exhibited in closed form in section 5 |
| **P.5**: the `HYPOTHESIS-DEBT` item (iv) | **CONFIRMED**: three $\star$ signs recomputed $+$, base constant $2$, $\epsilon_J$ well defined by $\det_{\mathbb R}U=\lvert\det_{\mathbb C}U\rvert^2=1$ on $U(3)$. **One step is left implicit**: that every compatible $J$ admits an adapted orthonormal frame at all |
| **P.6 (new)**: the six-dimensional support hypothesis | **LOAD-BEARING IN ALL THREE CASES, AND SHARP.** The same statement at $\dim V=4$ is **FALSE**, refuted by a two-parameter family: any orthonormal pair in $\Lambda^+\mathbb R^4$. Section 7 |
| **E**: the rank-two configuration at $\dim V=6$ lands in Claim P's hypothesis | **CONFIRMED.** Both readings are right, $\lambda_2=-\lambda_1$ follows, orthonormality and the common support are supplied, and the two eigenvalues are simple so the pair is canonical |
| **E.1**: the common support is $V$ and is six-dimensional | **The identity of the support is DERIVED. Its dimension is the BRANCH HYPOTHESIS**, correctly so, and the brief says as much. $\dim V\in\{4,6,8,\dots\}$ is all the record forces, and $\dim V=4$ is inhabited |
| **[plan.md](../plan.md)'s one-line rendering of L184's cases** | **STALE IN BOTH THE CASES A FOLD WOULD TOUCH.** It still routes case 1 through [L181](../findings/diagonal-half.md), which the L184 block retired and which cannot reach a bare pair, and it renders case 3 as the three-signs count, which is exactly the step false for two |

**One line.** *The pair statement holds, by the three substitutions its own observation box names and by no shortcut: case 1 needs nothing rewritten, case 2 replaces a rank argument with orthogonality and case 3 replaces a sign count with the cross term, and I could break none of them. Claim E's two readings are correct and its entailment is exact, with the one caveat that six-dimensionality is the branch it is asked about rather than something it derives: at $\dim V=4$ the same pair statement is false, by an orthonormal pair in $\Lambda^+\mathbb R^4$, so the entailment is sharp and the branch it closes is exactly one dimension wide.*

## 0. Conventions, fixed once

- $\langle\omega,\eta\rangle=\sum_{a<b}\omega_{ab}\eta_{ab}$, the convention [L180](../findings/diagonal-half.md) fixes by $\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=2\lVert\omega\rVert^2$ and the one `inner2` carries in [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean). In it, $\langle\omega_1,\omega_2\rangle=-\tfrac12\mathop{\mathrm{tr}}(\omega_1\omega_2)$, so **orthogonality is exactly $\mathop{\mathrm{tr}}(\omega_1\omega_2)=0$** and L184's contradictions $\mathop{\mathrm{tr}}(\omega_1\omega_2)=\mp2$ are stated in it correctly.
- $A=-\omega_1^2=-\omega_2^2=\omega_i\omega_i^{\mathsf T}$, positive semidefinite of trace $2$ on $\mathbb R^n$ and positive definite on $V$.
- $\varepsilon_j$ is the unit area form of a plane $P_j$, fixed up to sign. $J$ names both a complex structure and its $2$-form $\omega_J(x,y)=\langle Jx,y\rangle$.
- $\mathop{\mathrm{supp}}\omega=\mathop{\mathrm{im}}\omega$. For skew $\omega$, $\ker\omega=(\mathop{\mathrm{im}}\omega)^\perp$ and $\ker A=\ker\omega$, so $\mathop{\mathrm{supp}}\omega=\mathop{\mathrm{range}}A$.

## 1. The setup for a pair, and why the fold is legal at all

**Located.** The hypotheses are $\omega_1,\omega_2\in\Lambda^2\mathbb R^n$ skew, $\langle\omega_i,\omega_j\rangle=\delta_{ij}$, $\mathop{\mathrm{supp}}\omega_1=\mathop{\mathrm{supp}}\omega_2=V$ with $\dim V=6$, $\omega_1^2=\omega_2^2$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$.

Three one-form facts carry the setup, and none of them wants a third index.

1. $\mathop{\mathrm{supp}}\omega_i=V$ gives $\ker\omega_i=V^\perp$, so **both forms lie in $\Lambda^2V$** and both self-wedges lie in $\Lambda^4V$. Equality of the self-wedges in $\Lambda^4\mathbb R^n$ and in $\Lambda^4V$ is the same statement.
2. $\omega_1$ is skew and invertible on $V$, so its eigenvalues on $V\otimes\mathbb C$ are $\pm\mathrm ic_1,\pm\mathrm ic_2,\pm\mathrm ic_3$ with every $c_j>0$, and **$A|_V$ has spectrum $\{c_1^2,c_1^2,c_2^2,c_2^2,c_3^2,c_3^2\}$**. Off $V$ the eigenvalue is $0$ with multiplicity $n-6$, which is the caveat the case-1 body already carries. $\mathop{\mathrm{tr}}A=2$ gives $c_1^2+c_2^2+c_3^2=1$.
3. **Each $\omega_i$ commutes with $\omega_i^2=-A$, hence preserves every eigenspace of $A$.** Since the two squares are equal, *both* forms preserve *the same* eigenspaces.

**Point 3 is the whole of why the fold works, and it is where a careless fold would break.** The planes and the $4$-plane below are eigenspaces of $A$, which is a canonical object attached to the pair, and not the normal-form planes of $\omega_1$, which the second form would have no reason to respect. The L184 block defines them from $A$, and so the second form respects them for a reason and not by inheritance. **This is the [L187](../findings/diagonal-half.md) failure mode checked for and not found.**

**The trichotomy is on how many of the three positive reals $c_1^2,c_2^2,c_3^2$ agree, which is exhaustive for any three positive reals**, and the multiplicity patterns it names are $(2,2,2)$, $(6)$ and $(4,2)$. Nothing in the derivation mentions a third form. **P.1 CONFIRMED.**

## 2. Case 1, the $c_j^2$ pairwise distinct

$A|_V$ has three mutually orthogonal eigenplanes $P_1,P_2,P_3$, each preserved by both forms, and a skew endomorphism of a plane is a multiple of its area form, so $\omega_i|_{P_j}=t_{ij}\varepsilon_j$ with $t_{ij}^2=c_j^2$, hence

$$\omega_i=\textstyle\sum_j s_{ij}c_j\varepsilon_j,\qquad s_{ij}=\pm1 .$$

$\varepsilon_j\wedge\varepsilon_j=0$, so $\omega_i\wedge\omega_i=2\sum_{j<k}s_{ij}s_{ik}c_jc_k\,\varepsilon_j\wedge\varepsilon_k$, and the $\varepsilon_j\wedge\varepsilon_k$ are the distinct basis $4$-forms $e_{2j-1,2j,2k-1,2k}$, independent by debt item (i). Equal self-wedges give $s_{1j}s_{1k}c_jc_k=s_{2j}s_{2k}c_jc_k$ at each of the three pairs, and **$c_jc_k>0$ cancels because $A$ is positive definite on $V$**, which is the six-dimensional support hypothesis and not a decoration.

Multiplying $s_{1j}s_{1k}=s_{2j}s_{2k}$ through by $s_{1j}s_{1k}$ and setting $u_j=s_{1j}s_{2j}$ gives $u_ju_k=1$ at all three pairs. On signs $u_ju_k=1$ is $u_j=u_k$, so all three $u_j$ equal one $\eta=\pm1$, whence $s_{2j}=\eta s_{1j}$ for every $j$ and $\omega_2=\eta\omega_1$ exactly. Then $\mathop{\mathrm{tr}}(\omega_1\omega_2)=\eta\mathop{\mathrm{tr}}(\omega_1^2)=-2\eta\ne0$, against orthogonality.

**CONFIRMED, and the box's arithmetic remark is right.** Read as ratios it looks like two free ratios against three constraints. In the $u_j$ variables it is three equations in three signs with only the all-equal solutions, and in fact **two of the three equations already force it**, so case 1 has slack rather than being tight. $u_j$ is canonical where $s_{ij}$ is not, since flipping $\varepsilon_j$ flips $s_{1j}$ and $s_{2j}$ together.

**The argument uses no dimension.** At $\dim V=2m$ with the $c_j^2$ pairwise distinct it runs verbatim on $m\ge2$ planes. Section 9 records what that gives.

## 3. Case 2, $A|_V=cI_6$

$\omega_i/\sqrt c$ is skew with square $-\mathrm{Id}$, hence orthogonal: a compatible complex structure $J_i$ on $V$. Unit norm gives $6c=\mathop{\mathrm{tr}}A=2$, so $c=\tfrac13$, though the pair contradiction never needs the value.

Equal self-wedges give $J_1\wedge J_1=J_2\wedge J_2$ in $\Lambda^4V$. **Apply $\star_V$ to both sides and evaluate each side by the identity:** $2\epsilon_1J_1=2\epsilon_2J_2$, so $J_2=(\epsilon_1\epsilon_2)J_1=\pm J_1$ and $\omega_2=\pm\omega_1$, whence $\mathop{\mathrm{tr}}(\omega_1\omega_2)=\mp2\ne0$ against orthogonality.

**The box is right on both readings.** Only that $\star_V$ is a well-defined linear map is used, so debt item (iii)'s "isomorphism" is true and stronger than needed, and the block's "injective" was the wrong reason rather than a wrong fact. And the triple version's closing, linear independence against three forms spanning a line, has nothing to bite on for a pair, so **the rank argument is genuinely inert and orthogonality genuinely replaces it**. That substitution is the one the observation box says lives only there, and it is valid.

**Orientation-independence of the conclusion.** $\star_V$ needs a chosen orientation on $V$. Reversing it flips $\star_V$ and both $\epsilon_i$ at once, so $J_2=\pm J_1$ is unaffected. Nothing in case 2 depends on which orientation $V$ is given.

### The `HYPOTHESIS-DEBT`, item (iv), recomputed

In a $J$-adapted orthonormal frame $Je_{2j-1}=e_{2j}$, write $\varepsilon_j=e^{2j-1}\wedge e^{2j}$, so $J=\varepsilon_1+\varepsilon_2+\varepsilon_3$ and $J\wedge J=2(\varepsilon_1\varepsilon_2+\varepsilon_1\varepsilon_3+\varepsilon_2\varepsilon_3)$, the diagonal terms vanishing. With $\mathrm{vol}=e_{123456}$:

| $\alpha$ | reordering to $e_{123456}$ | $\star\alpha$ |
|---|---|---|
| $e_{1234}=\varepsilon_1\varepsilon_2$ | $e_{1234}\wedge e_{56}$, already ordered | $+e_{56}=\varepsilon_3$ |
| $e_{1256}=\varepsilon_1\varepsilon_3$ | $e_{1256}\wedge e_{34}$, $e_3$ and $e_4$ each cross two slots | $+e_{34}=\varepsilon_2$ |
| $e_{3456}=\varepsilon_2\varepsilon_3$ | $e_{3456}\wedge e_{12}$, $e_1$ and $e_2$ each cross four slots | $+e_{12}=\varepsilon_1$ |

All three signs are $+$, so $\star_V(J\wedge J)=2(\varepsilon_3+\varepsilon_2+\varepsilon_1)=2J$, and $-2J$ when the adapted frame carries the opposite orientation. **The constant is $2$ and the sign is that comparison and nothing else, as (iv) says.** I checked the sign convention against a second $J$: for $J'=\varepsilon_1+\varepsilon_2-\varepsilon_3$, which is compatible, $\star_V(J'\wedge J')=2(\varepsilon_3-\varepsilon_2-\varepsilon_1)=-2J'$, and the frame $(e_1,\dots,e_4,e_6,e_5)$ that adapts it is indeed negatively oriented.

**Well-definedness of $\epsilon_J$.** Two $J$-adapted orthonormal frames differ by a real orthogonal map commuting with $J$, that is by an element of $U(3)$, and $\det_{\mathbb R}U=\lvert\det_{\mathbb C}U\rvert^2=1$, so the induced orientation is frame-independent. **The record's correction stands**: connectedness of $SO(6)$ is a statement about all oriented frames and says nothing about which frames are $J$-adapted, so it does not supply this. Connectedness of $U(3)$ would be a second valid route.

**One step (iv) leaves implicit, and it should be written down.** That a compatible $J$ admits an adapted orthonormal frame at all is used and not stated. It is two lines: take unit $e_1$, set $e_2=Je_1$, which is a unit vector orthogonal to $e_1$ by skewness and orthogonality of $J$; then $\{e_1,e_2\}^\perp$ is $J$-invariant, since $\langle Jx,e_1\rangle=-\langle x,e_2\rangle$ and $\langle Jx,e_2\rangle=\langle Jx,Je_1\rangle=\langle x,e_1\rangle$; induct. **Recorded as the one gap in an otherwise complete discharge.**

## 4. Case 3, spectrum $(a,a,b)$ with $a\ne b$

$A|_V$ has a $4$-plane $Q$ (eigenvalue $a$) and a plane $P$ (eigenvalue $b$), both preserved by both forms, with $a,b>0$ by positive definiteness on $V$. So $\omega_i=\sqrt a\,J_i\oplus\tau_i\sqrt b\,\varepsilon_P$ with $J_i$ a complex structure on $Q$ and $\tau_i=\pm1$, and

$$\omega_i\wedge\omega_i=\underbrace{a\,J_i\wedge J_i}_{\Lambda^4Q}+\underbrace{2\tau_i\sqrt{ab}\;J_i\wedge\varepsilon_P}_{\Lambda^2Q\wedge\Lambda^2P},$$

the $\varepsilon_P\wedge\varepsilon_P$ term vanishing. The two summands lie in complementary subspaces of $\Lambda^4V$, so equal self-wedges split into two equations. **The cross term is the one that carries the pair conclusion**: $\sqrt{ab}\ne0$, and $\alpha\mapsto\alpha\wedge\varepsilon_P$ is injective on $\Lambda^2Q$ by debt item (ii), so $\tau_1J_1=\tau_2J_2$, hence $J_2=\tau_1\tau_2J_1$ and

$$\omega_2=\tau_1\tau_2\sqrt a\,J_1+\tau_2\sqrt b\,\varepsilon_P=\tau_1\tau_2\Big(\sqrt a\,J_1+\tau_1\sqrt b\,\varepsilon_P\Big)=\tau_1\tau_2\,\omega_1 ,$$

so $\mathop{\mathrm{tr}}(\omega_1\omega_2)=\mp2\ne0$ against orthogonality. **CONFIRMED, and this is the box's $\omega_2=\tau_2\tau_1\omega_1$ exactly.**

**The three-signs count really is false for two, and the record is right to say so.** With $J_i=\sigma_iJ$ for a fixed $J$ and $\rho_i=\sigma_i\tau_i$, orthogonality reads $4a\,\sigma_1\sigma_2=-2b\,\tau_1\tau_2$, that is $\rho_1\rho_2\cdot 4a=-2b$. At three forms the pairwise products $\rho_i\rho_j$ are all equal, which on signs forces $+1$ and gives the impossible $4a=-2b$. **At two forms there is one product and no such forcing**, and $\rho_1\rho_2=-1$ gives $b=2a$, which is satisfiable. So the triple version's closing step must be rewritten and not folded.

**And the configuration it admits is excluded by the cross term, not by any sign count.** The cross term gives $\tau_iJ_i=\rho_iJ$ independent of $i$, hence $\rho_1=\rho_2$ and $\rho_1\rho_2=+1$, which returns the impossible $4a=-2b$. **The order matters**: the cross term must be used before orthogonality, which is the same sequencing point the block already makes about the $\Lambda^4Q$ part. Read alone, the $\Lambda^4Q$ equality says only $\eta_1=\eta_2$ where $J\wedge J=2\eta\,\mathrm{vol}_Q$, and it becomes vacuous only once the cross term has already given $J_2=\pm J_1$, since $(-J)\wedge(-J)=J\wedge J$.

## 5. The $\rho_1\rho_2=-1$ configuration, exhibited in closed form

**Constructed for this audit to test the claim I am about to record, and it is a near-miss and not a counterexample.** Take $V=Q\oplus P=\mathbb R^4\oplus\mathbb R^2$, $J=\varepsilon_1+\varepsilon_2$ on $Q$, $a=\tfrac14$, $b=\tfrac12$, so $b=2a$ and $\mathop{\mathrm{tr}}A=4a+2b=2$:

$$\omega_1=\tfrac12J+\tfrac1{\sqrt2}\varepsilon_P,\qquad \omega_2=-\tfrac12J+\tfrac1{\sqrt2}\varepsilon_P .$$

| Hypothesis | Value | Met |
|---|---|---|
| $\lVert\omega_i\rVert^2$ | $a\lVert J\rVert^2+b=2a+b=\tfrac12+\tfrac12$ | $=1$, yes |
| $\langle\omega_1,\omega_2\rangle$ | $-2a+b=-\tfrac12+\tfrac12$ | $=0$, yes |
| $\omega_i^2$ | $-a\,\mathrm{Id}_Q\oplus-b\,\mathrm{Id}_P$, independent of $i$ | equal, yes |
| common support | all of $V$, $a,b\ne0$ | six-dimensional, yes |
| $\Lambda^4Q$ part of the self-wedge | $a\,J\wedge J$ both times, $(-J)\wedge(-J)=J\wedge J$ | equal, yes |
| **cross term** | $\pm2\sqrt{ab}\,J\wedge\varepsilon_P$, opposite signs | **unequal, no** |

**So this pair satisfies every hypothesis of Claim P except the cross-term half of the wedge condition, and it is $\rho_1\rho_2=-1$ with $b=2a$ exactly.** It is the concrete demonstration that a fold of case 3 that kept the sign count and the $\Lambda^4Q$ equality and dropped the cross term would have been **wrong**, and that the record's warning names a real object rather than a hypothetical one. Its Weyl form $W=\lambda(\omega_1\otimes\omega_1-\omega_2\otimes\omega_2)$ is Ricci-flat and traceless at $\dim V=6$ and fails first Bianchi, by $2\lambda\cdot 2\sqrt{ab}\,J\wedge\varepsilon_P\ne0$.

**A second near-miss, in case 1's stratum.** $c_1^2=\tfrac16$, $c_2^2=\tfrac13$, $c_3^2=\tfrac12$, pairwise distinct and summing to $1$. Then $\omega_1=c_1\varepsilon_1+c_2\varepsilon_2+c_3\varepsilon_3$ and $\omega_2=c_1\varepsilon_1+c_2\varepsilon_2-c_3\varepsilon_3$. Unit, orthogonal by $\tfrac16+\tfrac13-\tfrac12=0$, equal squares, common six-dimensional support, and the self-wedges differ in the $\varepsilon_1\varepsilon_3$ and $\varepsilon_2\varepsilon_3$ components. **Together the two show that Claim P's content is entirely first Bianchi**: Ricci-flatness plus orthonormality plus six-dimensional support is a rich set at rank two, and the wedge condition is what empties it.

## 6. Claim E

**Both readings are correct.**

- $W=\lambda_1\omega_1\otimes\omega_1+\lambda_2\omega_2\otimes\omega_2$ nonzero in spectral form with the $\omega_i$ orthonormal and both $\lambda_i\ne0$. **$\lambda_2=-\lambda_1$ follows**, by [L180](../findings/diagonal-half.md)(2): tracelessness is the trace of Ricci-flatness, $\mathop{\mathrm{tr}}(\omega_i^2)=-2\lVert\omega_i\rVert^2=-2$, so the trace of $\sum\lambda_i\omega_i^2=0$ is $-2(\lambda_1+\lambda_2)$. Unit norm is consumed here, and orthonormality supplies it.
- **Ricci.** [L180](../findings/diagonal-half.md)(1) is $\sum\lambda_i\omega_i^2=0$, which at $\lambda_2=-\lambda_1\ne0$ is $\omega_1^2=\omega_2^2$. **This half is already in the record**, in L180's own rank-two note as $A_1=A_2$.
- **Bianchi.** [L179](../findings/diagonal-half.md)(b) is $\sum\lambda_i\,\omega_i\wedge\omega_i=0$ over the nonzero spectrum, which at $\lambda_2=-\lambda_1\ne0$ is $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$. **This half is new here**, and it is correct. L180's note stops at Ricci and never draws it.
- **Orthonormality** is the spectral hypothesis. It is not a choice at rank two: the eigenvalues are $\pm\lambda_1$, distinct and each simple, so the eigenforms are canonical up to sign. **The degenerate-eigenspace worry [L180](../findings/diagonal-half.md)(3) raises for rank three does not arise here.**
- **The common support is derived, and it is $V$.** $A_1=A_2$ gives equal ranges, and $\mathop{\mathrm{range}}A_i=\mathop{\mathrm{supp}}\omega_i$ by $A_i$'s self-adjointness together with $\ker A=\ker\omega$. By [L179](../findings/diagonal-half.md)(a), $V$ is the span of the supports of the nonzero eigenforms, which is that one space.

**So the rank-two configuration meets orthonormality and a common support, and it meets Claim P's remaining two hypotheses exactly. Claim E is CONFIRMED.**

## 7. The support, and why the entailment is exactly one dimension wide

**The dimension is not derived, and it should not be.** What the record forces at rank two is that $V$ is a $2$-form's support, hence of even dimension, and that $\dim V=2$ is impossible because $\Lambda^2V$ would be a line holding two orthonormal vectors. That leaves $\dim V\in\{4,6,8,\dots\}$. **Claim E asks about $\dim V=6$ and says so**, which is the honest form: it is the branch, not a step.

**And it must be, because at $\dim V=4$ the pair statement is FALSE.** Take any two orthonormal $\omega_1,\omega_2\in\Lambda^+\mathbb R^4$. By the record's own [L183](../findings/diagonal-half.md) box, every unit self-dual form on $\mathbb R^4$ has $\omega^2=-\tfrac12\mathrm{Id}_4$ and $\omega\wedge\omega=\lVert\omega\rVert^2f_{1234}$. So:

| Claim P hypothesis, read at $\dim V=4$ | at an orthonormal pair in $\Lambda^+\mathbb R^4$ |
|---|---|
| orthonormal | yes, by choice |
| common support, of the full dimension | $\omega_i^2=-\tfrac12\mathrm{Id}_4$, so both supports are $\mathbb R^4$ |
| squares coincide | both $-\tfrac12\mathrm{Id}_4$ |
| self-wedges coincide | both $f_{1234}$ |

**A two-parameter family of counterexamples**, and each is an honest rank-two Weyl tensor: $W=\lambda(\omega_1\otimes\omega_1-\omega_2\otimes\omega_2)$ is Ricci-flat by $-\tfrac12\lambda\mathrm{Id}+\tfrac12\lambda\mathrm{Id}=0$, satisfies first Bianchi by $\lambda f_{1234}-\lambda f_{1234}=0$, and is traceless. So **the rank-two branch is inhabited at $\dim V=4$**, which is consistent with [L180](../findings/diagonal-half.md)'s note: what happens there is that [L178](../findings/diagonal-half.md)'s step 1 returns $\theta=0$, not that the branch is empty.

**Three consequences, and they should be on the record.**

1. **Claim P's six-dimensionality is sharp**, not incidental. The proof does not transfer downward for a visible reason: at $\dim V=4$ the scalar case has $\star:\Lambda^4\to\Lambda^0$ and the identity $\star_V(J\wedge J)=2\epsilon_JJ$ has no analogue, the dimension count $\binom{2m}4=\binom{2m}2$ holding at $2m=6$ and nowhere else.
2. **Claim E's dimension hypothesis is load-bearing**, since the same entailment read at $\dim V=4$ would conclude something false.
3. **The six-dimensional support is used in every case of Claim P**, not just in the setup: positive definiteness of $A$ on $V$ is what makes $c_jc_k>0$ cancel in case 1 and $\sqrt{ab}\ne0$ in case 3, and what makes case 2's $c$ nonzero.

## 8. Screens

Two, both reported as screens and neither offered as evidence for a positive claim.

- **The pair form of case 2 compiles.** I wrote the analogue of [L184Statement.lean](../lean/HamiltonsCubic/Results/L184Statement.lean)'s `scalar_case_empty` at `Fin 2` in a scratch file outside the repo, closing on `inner2 (om 1) (om 0) = 0` in place of `LinearIndependent`, and it elaborated clean under `lake env lean`. It consumes `pm_of_eq_wedgeSelf`, which [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) already states **for a pair of complex structures** and proves from `StarWedgeIdentity` alone. *So the pair version of case 2 is already the shape the Lean carries, and what my file adds is the two-line orthogonality closing.* It remains conditional on the owed identity, which is a `Prop` there that is never proved and never assumed.
- **The owed identity itself did not screen.** I attempted `star6 (wedgeSelf stdJ6) = 2 • stdJ6` directly in the file's own normalisation. It exhausted `simp` steps and then four million heartbeats after five minutes of elaboration, which is **over the screening budget the standing rule allows**, so I stopped and did not retry. **No machine result on the star identity, in either direction.** The hand computation in section 3 stands on its own, and it agrees with the independent recomputations [r802](REVIEW_r802.md) and [r806](REVIEW_r806.md) recorded for the same three star signs.

## 9. What the argument reaches beyond the coincident case at six

**Case 1's argument is dimension-free and gives a strictly larger emptiness at rank two.** At $\dim V=2m$ with the $c_j^2$ pairwise distinct, the same computation gives $u_ju_k=1$ over all $\binom m2$ pairs, which for $m\ge2$ forces $\omega_2=\eta\omega_1$ against orthogonality. So:

> *At rank two, the stratum where $-\omega_1^2$ has $m$ distinct eigenvalues each of multiplicity two is empty at every $\dim V=2m\ge4$.*

**Recorded as derived here and unaudited**, and it does not rescue $\dim V=4$, where the counterexamples of section 7 have $A$ scalar and so sit outside this stratum. **What Claim P leaves open in the rank-two branch is $\dim V\ge8$ with a repeated eigenvalue.** Cases 2 and 3 are strictly six-dimensional: case 2 because $\star_V$ carries $\Lambda^4\to\Lambda^2$ only there, case 3 because its splitting is $4+2$. At $\dim V=8$ the trichotomy does not apply at all, there being four values, and a pattern such as $(a,a,b,b)$ falls outside every case, which is the same limit the L184 entailment box already states for the triple.

## 10. What [plan.md](../plan.md) says, and why it matters here

[plan.md](../plan.md) line 141 renders L184's three cases in one sentence: *"Pairwise distinct: each $\omega_i$ preserves $A$'s eigenplanes, so all three are block-diagonal for one splitting and [L181](../findings/diagonal-half.md) applies. All equal: complex structures, and $\star(J\wedge J)=2\epsilon_JJ$ collapses them to $\pm K$. Exactly two equal: orthogonality reduces to $4a=-2b$."*

**Both of the cases a pair fold has to rewrite are rendered there in the form that does not fold.**

- **Case 1 is routed through [L181](../findings/diagonal-half.md).** The L184 block retired that appeal explicitly, on the ground that L181's conclusion is about a $W\in\mathcal W_n$ and cannot reach a bare triple. It reaches a bare **pair** even less: the pair statement has no tensor in it at all. The live argument is the sign count of section 2, which needs nothing but orthogonality.
- **Case 3 is rendered as the three-signs count.** That is precisely the step the observation box says is **false for two**, and the near-miss of section 5 is the configuration it admits.

**A reader who folds the pair statement from [plan.md](../plan.md)'s summary rather than from L184's own block gets a wrong proof in two of three cases**, and both wrongnesses are of the kind this line has already been refuted for twice. I make no edit outside my report, and record the two as defects to be fixed by the author.

## 11. Argue the opposite, and what would falsify each claim

**I tried to build a counterexample to Claim P and could not, and I can say where every attempt died.**

| Attack on Claim P | Outcome |
|---|---|
| Make the second form not respect $A$'s eigenspaces | Impossible: $\omega_2$ commutes with $\omega_2^2=-A$, and the squares are equal by hypothesis |
| Give $A|_V$ an eigenvalue of odd multiplicity, escaping the trichotomy | Impossible: $\omega_1$ is skew and invertible on $V$, so its eigenvalues pair up |
| Break case 1 by choosing signs freely | Ricci alone permits it, section 5's second family. Bianchi kills it, and only two of the three sign equations are needed |
| Break case 2 with two distinct complex structures sharing a self-wedge | Impossible given the identity: applying $\star_V$ gives $\epsilon_1J_1=\epsilon_2J_2$ outright |
| Break case 3 at $\rho_1\rho_2=-1$, $b=2a$ | Genuinely admitted by orthogonality alone, exhibited in section 5, and killed by the cross term |
| Kill a cross term or a cancellation by degeneracy | Needs $c_j=0$ or $ab=0$, which is a support of dimension below six |
| Drop to $\dim V=4$ | **Succeeds**: the pair statement is false there, section 7. This is the sharpness, not a defect |

**What would falsify Claim P**, and where I looked: an orthonormal pair on a six-dimensional $V$ with equal squares and equal self-wedges. Because every case forces $\omega_2=\pm\omega_1$, any such pair must break the case analysis rather than the closings, so I attacked the setup first, at the two places it could fail for a pair and not for a triple, namely the eigenspace preservation and the identification of the planes as $A$'s eigenspaces rather than $\omega_1$'s. Both hold. I then attacked each closing on its own hypotheses, and the two that had to be rewritten are the two the box names, with the substitutions it names and no others.

**What would falsify Claim E**, and where I looked: a rank-two Ricci-flat first-Bianchi $W$ with $\dim V=6$, or an error in either reading. I checked $\lambda_2=-\lambda_1$ against its source rather than against the brief, checked that both readings survive the division by $\lambda_1$, checked that orthonormality is not a basis choice at rank two, and checked that the common support is derived rather than assumed. The one thing Claim E does not derive is the dimension, and section 7 shows the entailment would be false without it, so I put that on the record as scope rather than as a defect.

**What would falsify the two entailments I add**: for section 9's stratum result, a rank-two configuration at some $\dim V=2m\ge8$ whose $A$ has $m$ distinct eigenvalues, which the sign count forbids; for section 7's counterexample family, a failure of $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$ or of $\omega\wedge\omega=\lVert\omega\rVert^2f_{1234}$ on $\Lambda^+\mathbb R^4$, both of which are in the record and were independently recomputed by [r806](REVIEW_r806.md) and [r807](REVIEW_r807.md).

## 12. Verdicts

- **Claim P: CONFIRMED.** All three cases close for a pair, on the substitutions the observation box names. The record's account of the fold is accurate in every particular I checked, including the two places it says a fold would be wrong.
- **Claim E: CONFIRMED.** Both readings hold, $\lambda_2=-\lambda_1$ follows from the record's own L180(2), and the rank-two configuration meets Claim P's orthonormality and common-support hypotheses. **Six-dimensionality is the branch and not a derivation**, correctly, and it is load-bearing: the same entailment at $\dim V=4$ would conclude something false.
- **Together they close the rank-two configuration at $\dim V=6$ and no further.** The branch survives at $\dim V\ge8$ with a repeated eigenvalue of $A$, and is inhabited at $\dim V=4$.
