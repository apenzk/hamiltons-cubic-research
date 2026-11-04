# REVIEW r697, the five claims of [DERIVE-j5](DERIVE-j5.md)'s Batch 1

*Cold brief, arguing from the definitions in [conventions.md](../findings/conventions.md) and [Lemma L131](../findings/isotropy-cap.md); no code from the run that produced the claims was read. [analysis-only](../.claude/rules/analysis-only.md) in force, **every computation below is by hand and no numerical run was made**, screening allowance unused.*

## Verdicts

| claim | verdict | the correction |
| --- | --- | --- |
| **C1**, the record's sign is the right one, and the variant is a different operator, separated at $S^p\times S^q$ | **CONFIRMED**, and upgraded from screen to proof | none. Both halves are now proven by hand at every $S^p\times S^q$, and the variant is identified: it is $4W_+\#W_-$ at every critical point |
| **C2**, $H=\mathrm{Ric}^*(h)$ is diagonal in $\{e_i\wedge e_j\}$ with eigenvalues $2(\eta_i+\eta_j)$ | **REFUTED on the constant, CONFIRMED on the structure** | the eigenvalues are $\eta_i+\eta_j$. The factor $2$ is a double count of the two live $\wedge$ conventions |
| **C3**, $J_5$ reads off the $h$-frame diagonal, so $H_{\mathrm{cross}}$ belongs to the splitting | **REFUTED as stated** | it carries C2's spurious $2$ and so asserts $J_5=2J_5$; "no off-diagonal information in any frame" is false read literally and vacuous read charitably; the "hence" is a non-sequitur |
| **C4**, the positivity ladder | **CONFIRMED as mathematics, REFUTED as a contribution** | the identity and all four implications are correct; the ladder is already on the record verbatim at [ATTEMPTS.md](../ATTEMPTS.md), its top rung is refuted there, and its claimed independent validation of $H\succeq0$ is the record's own proof transposed |
| **C5**, the identity, valid at every symmetric $W$ and every $\theta$ | **CONFIRMED as an identity; its consequence paragraph REFUTED** | at a critical point $Q(W)-\theta W=0$ **as an operator**, so the reserved computation is unnecessary and [post F55](../findings/second-order.md)'s boxed form is not missing a term. And the object C5 says is "the wrong name" is also zero |

## C2, the factor $2$, and where it comes from

**The record carries two $\wedge$ products and the batch used one inside the other.**

- **Böhm–Wilking's operator wedge**, which is what [Lemma L131](../findings/isotropy-cap.md) and [ATTEMPTS.md](../ATTEMPTS.md) Result 6(a) are written in: $(A\wedge B)(x\wedge y)=\tfrac12(Ax\wedge By+Bx\wedge Ay)$.
- **The Kulkarni–Nomizu product** of two symmetric $2$-tensors: $(h\owedge\delta)_{ijkl}=h_{ik}\delta_{jl}+h_{jl}\delta_{ik}-h_{il}\delta_{jk}-h_{jk}\delta_{il}$.

The batch's display expands $(h\wedge\mathrm{id})$ by the **Kulkarni–Nomizu** rule, obtaining $(\eta_i+\eta_j)\delta_{ik}\delta_{jl}$, and then multiplies by the $2$ of $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$, which is stated in the **Böhm–Wilking** rule. The two differ by exactly a factor $2$ ($2(h\wedge_{\mathrm{BW}}\mathrm{id})=h\owedge\delta$) so the $2$ is counted twice.

**Which product [Lemma L131](../findings/isotropy-cap.md) is in, settled from the lemma's own content.** Evaluate $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$ at $R=\mathrm{Id}_{\Lambda^2}$. Then $\mathrm{Ric}(\mathrm{Id})=(n-1)\mathrm{id}$, $\mathrm{Alt}(\mathrm{Id})=0$ and $I\#I=(n-2)I$, so the right side is $(n-1)\mathrm{Id}$ and the identity forces $\mathrm{id}\wedge\mathrm{id}=\mathrm{Id}_{\Lambda^2}$. That is Böhm–Wilking's normalisation; Kulkarni–Nomizu gives $\delta\owedge\delta=2\,\mathrm{Id}$ and would break the lemma.

**So the correct eigenvalue is $\eta_i+\eta_j$**, and $H(e_i\wedge e_j)=(\eta_i+\eta_j)\,e_i\wedge e_j$. Three further independent confirmations, each using a different anchor:

1. **Adjointness, computed directly.** With the record's pairings, $\{e_i\wedge e_j\}_{i<j}$ orthonormal in $\Lambda^2$ and plain Frobenius on the pair matrix, per [conventions.md](../findings/conventions.md), $\tfrac14\sum_{ijkl}A_{ijkl}(h\owedge\delta)_{ijkl}=\sum_{i,j,k}A_{ijkj}h_{ik}=\langle\mathrm{Ric}(A),h\rangle$, the four Kulkarni–Nomizu terms contributing equally by the pair symmetries. So the adjoint is $h\owedge\delta$ with coefficient $1$, whose $(i,j)$ eigenvalue is $\eta_i+\eta_j$.
2. **The scalar-curvature test.** At $h=\mathrm{id}$ and $A=\mathrm{Id}_{\Lambda^2}$: $\langle \mathrm{Id},\mathrm{Ric}^*(\mathrm{id})\rangle=\mathop{\mathrm{tr}}\mathrm{Ric}(\mathrm{Id})=n(n-1)$, while $\langle\mathrm{Id},c\,\mathrm{Id}\rangle=c\binom n2$. Hence $c=2=\eta_i+\eta_j$, against C2's $4$.
3. **The record's own proof of $H\succeq0$**, [ATTEMPTS.md](../ATTEMPTS.md) Result 5(b): $\langle\varphi,H\varphi\rangle=\mathop{\mathrm{tr}}(h\Phi\Phi^{\top})$. At $\varphi=e_1\wedge e_2$, $\Phi\Phi^{\top}=E_{11}+E_{22}$ and the value is $\eta_1+\eta_2$, with $\lVert\varphi\rVert=1$.

**The structural half survives every press.** Diagonality needs neither criticality, isotropy, Bianchi nor a sign condition on $\eta$: the off-diagonal Kulkarni–Nomizu term $\delta_{il}\delta_{jk}$ is unreachable for $i<j$ and $k<l$, whatever the signs. Degeneracy of $h$ is not a defect either, $H$ is diagonal in **every** orthonormal frame diagonalising $h$, and the eigenvalue attached to $e_i\wedge e_j$ is the same in all of them.

**Where the factor is live.** It is inert for the sign of $J_5$, which is the grant. It is **not** inert in the master inequality: [post F55](../findings/second-order.md) already books an identical factor-$2$ trap in $H$ and records that it is "live in the master identity and $p=(J_4-J_5)/r^2$". A second instance of the same trap, in the same object, one file over.

## C3, the claim contradicts itself, and its conclusion does not follow

**It asserts $J_5=2J_5$.** By definition $J_5=\langle\mathrm{Ric}(X_{\mathrm{inv}}),h\rangle=\sum_i\eta_i\,\mathrm{Ric}(X_{\mathrm{inv}})_{ii}$ in an $h$-eigenframe. C3's own chain ends at $2\sum_i\eta_i\langle\mathrm{Ric}(X_{\mathrm{inv}})e_i,e_i\rangle$, which is $2J_5$. So the display is self-refuting unless $J_5=0$, which is exactly the case the record's sharp points sit in, which is why a screen at sphere products would not have caught it. **The correct statement is**
$$J_5=\sum_{i<j}(\eta_i+\eta_j)\big\langle X_{\mathrm{inv}}(e_i\wedge e_j),e_i\wedge e_j\big\rangle=\sum_i\eta_i\big\langle\mathrm{Ric}(X_{\mathrm{inv}})e_i,e_i\big\rangle,$$
with no constant anywhere, the two sides being one rearrangement of $\mathrm{Ric}(X)_{ii}=\sum_j X_{ijij}$.

**"No off-diagonal information about $X_{\mathrm{inv}}$ enters in any frame" is false read literally.** The quantities that enter are the $h$-frame pair-diagonal entries $X_{ijij}$. In any other frame these are linear combinations of that frame's diagonal **and off-diagonal** entries, and the $h$-frame is fixed by $W$ rather than chosen. The clause is true only in the reading "only the $h$-frame diagonal enters", and in that reading it is a restatement that $\mathrm{Ric}$ is a contraction, it holds for **every** symmetric operator in place of $X_{\mathrm{inv}}$, so it says nothing about $X_{\mathrm{inv}}$.

**The "hence" is a non-sequitur.** $H$ having no cross blocks in its own frame does not make the record's $H_{\mathrm{cross}}$ an artefact. The record's block split exists because the only structural knowledge of $X_{\mathrm{inv}}$, the $\#$-positivity of $P_bX_{\mathrm{inv}}P_b$, [ATTEMPTS.md](../ATTEMPTS.md) Result 5(a), lives in the $W$-frame, and $P_bX_{\mathrm{inv}}P_b\succeq0$ for each $b$ gives **no** sign for $\langle X_{\mathrm{inv}}(e_i\wedge e_j),e_i\wedge e_j\rangle$ at an $h$-frame plane. Moving to the $h$-frame diagonalises $H$ and destroys the one thing known about $X_{\mathrm{inv}}$. Result 5(c) already names the invariant content: the cross term vanishes exactly when $[H,W]=0$, i.e. when the two frames coincide. **The cross term is a property of the misalignment of the pair $(W,h)$, not of either splitting**, and there is no frame diagonalising both unless they commute.

**One case where the claim does buy something, and the record already has it.** When $h$ is scalar, $J_5=\lambda\cdot\mathop{\mathrm{scal}}(X_{\mathrm{inv}})$, and $\mathop{\mathrm{scal}}(X_{\mathrm{inv}})\ge0$ is **proven** at [ATTEMPTS.md](../ATTEMPTS.md) Result 5(a). So the grant is already proven on the locus [post F54](../findings/second-order.md) names as the blind spot of every trace bound. That is worth a line in the record; it is not what C3 claims.

## C1, CONFIRMED, and here is the proof the record has only screened

Write $X_{\mathrm{inv}}=\lvert W\rvert^\#+(W-\theta)\lvert W\rvert$ ([ATTEMPTS.md](../ATTEMPTS.md) Result 5(a)). At a critical point $W^\#=\theta W-W^2$, so
$$-P_+W^\#P_++P_-W^\#P_-=-(\theta W_+-W_+^2)+(-\theta W_--W_-^2)=-\theta\lvert W\rvert+W\lvert W\rvert,$$
which is exactly the record's form. The variant differs by $-2P_-W^\#P_-$, i.e.
$$\text{variant}-X_{\mathrm{inv}}=2W_-^2+2\theta W_-=2W_-(W_-+\theta),$$
nonzero on $\mathop{\mathrm{ran}}W_-$ whenever $\theta>0$. **And the variant is identifiable:** substituting $W^\#=\theta W-W^2$ throughout gives $\text{variant}=\lvert W\rvert^\#-\theta W+W^2=4\,W_+\#W_-$ at every critical point.

**That sharpens why the sign error mattered.** $W_+\#W_-\succeq0$ by the $\#$-positivity calculus and $H\succeq0$, so a hunt started from the variant would have produced $\langle\text{variant},H\rangle\ge0$ in one line, a one-line "proof" of the grant, of a different operator. The correction in Batch 1 was not a typo fix; it removed a false proof.

**At $S^p\times S^q$, by hand.** Under $SO(p)\times SO(q)$ the space $\Lambda^2$ splits into the inequivalent irreducibles $\mathfrak{so}(p)$, $\mathfrak{so}(q)$ and $M=\mathbb R^p\otimes\mathbb R^q$, so every equivariant symmetric operator is block-scalar; let $W=(a,b,c)$ on the three blocks. With $\mathrm{tri}(A,B,C)=\tfrac12\sum_{\alpha\beta\gamma}a_\alpha b_\beta c_\gamma T_{\alpha\beta\gamma}$ in a common eigenbasis and $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$ totally symmetric:

- $\mathrm{Ric}(W)=0$ gives $a(p-1)=-cq$ and $b(q-1)=-cp$, hence $a(p-1)+b(q-1)=-cn$. *The same relation falls out of $W\#I=-W$ on $M$, which is an independent check of the normalisation.*
- $(W^\#)_M=ac(p-1)+bc(q-1)=-c^2n$, so criticality on $M$ reads $c^2-c^2n=\theta c$, i.e. $\boxed{\theta=\lvert c\rvert(n-1)}$.
- $[\mathfrak{so}(p)\oplus\mathfrak{so}(q),M]\subseteq M$, so $W_+\#W_-$ is supported on $M$ alone, with $(W_+\#W_-)_M=\tfrac12\lvert c\rvert\,[a(p-1)+b(q-1)]=\tfrac12c^2n$.

Therefore $X_{\mathrm{inv}}=4W_+\#W_--2\theta W_--2W_-^2$ is supported on $M$ with value
$$4\cdot\tfrac12c^2n-2\lvert c\rvert(n-1)\lvert c\rvert-2c^2=2c^2n-2c^2(n-1)-2c^2=0 .$$
**$X_{\mathrm{inv}}\equiv0$ at every $S^p\times S^q$**, while the variant is $4W_+\#W_-=2c^2n\ne0$ on $M$. C1 confirmed in both halves.

**The computation validates itself against the record's own constants.** Normalising $\lVert W\rVert=1$ gives $\theta^2=(n-1)^2/\big(pq[\tfrac q{2(p-1)}+\tfrac p{2(q-1)}+1]\big)$, which at $p=q=m$, $n=2m$ is $(2m-1)(m-1)/m^2=2(n-1)(n-2)/n^2=\theta_0(n)^2$, and at $(p,q)=(2,3)$ is $8/9=\Theta_5^2$, both matching [conventions.md](../findings/conventions.md) exactly. No numerical run was needed or made.

## C4, true, inert, and already on the record

**The identity is correct** with coefficient $1$: $\langle\mathrm{Ric}(A)x,x\rangle=\sum_j A_{1j1j}=\sum_j\langle A(x\wedge e_j),x\wedge e_j\rangle$ in a frame with $e_1=x$. All four implications hold, and the last uses $h=\mathrm{Ric}(\lvert W\rvert)=2\mathrm{Ric}(W_-)\succeq0$, itself the first rung at $A=W_-\succeq0$. **Nothing in the ladder is wrong.**

**Three things are wrong with it as a contribution.**

- **The ladder is already the record's, verbatim.** [ATTEMPTS.md](../ATTEMPTS.md) states "the natural matrix strengthening $\mathrm{Ric}(X_{\mathrm{inv}})\succeq0$, weaker than the already-refuted $X_{\mathrm{inv}}\succeq0$, and which would give $J_5\ge0$ outright since $h\succeq0$, is **false**", and [2026-09-03b-step8-position.md](2026-09-03b-step8-position.md) closes with "the whole ladder between the scalar target and operator positivity is closed". C4 re-derives that sentence.
- **Its entry point is refuted, so it transmits nothing to the grant.** $X_{\mathrm{inv}}\succeq0$ is refuted, and the third rung $\mathrm{Ric}(X_{\mathrm{inv}})\succeq0$ is refuted independently at an $n=5$ critical point, $\lambda_{\min}=-0.0273$. **On the soundness of that refutation:** the point is numerical, residual $2\times10^{-8}$, single-run and unreviewed, and $W\mapsto W_-$ is only Lipschitz, so the honest condition is that the spectral gap of $W$ at that point exceed the residual by the margin needed for $\lVert\Delta P\rVert\lesssim\text{residual}/\text{gap}\ll0.027$. That is six orders of room if the gap is $O(1)$ and none if the point is near an eigenvalue crossing; **the gap is not recorded, and recording it would discharge the validation debt without a new search.**
- **The claimed independent validation of $H\succeq0$ does not typecheck, and its repair is the record's own proof.** "Read at $A=h$" cannot be done: $h$ is an $n\times n$ form and the identity's $A$ is an operator on $\Lambda^2$. The repair is $A=\varphi\otimes\varphi\succeq0$, giving $\langle H\varphi,\varphi\rangle=\langle h,\mathrm{Ric}(\varphi\otimes\varphi)\rangle\ge0$, but $\mathrm{Ric}(\varphi\otimes\varphi)_{ik}=\sum_j\Phi_{ij}\Phi_{kj}=(\Phi\Phi^{\top})_{ik}$, so this **is** Result 5(b)'s $\mathop{\mathrm{tr}}(h\Phi\Phi^{\top})$, letter for letter. It is the same argument read in the other direction, not a route "sharing nothing with the record's". *The $g\succeq0$ reading at $A=W_-$ is sound and is genuinely the shorter proof.*

## C5, the identity holds; the paragraph drawn from it does not

**The algebra is complete and needs no hypothesis on $P_0$.** From $\lvert W\rvert^\#=W^\#+4W_+\#W_-$, $W_+W_-=0$, $W\lvert W\rvert=W_+^2-W_-^2$ and $W^2=W_+^2+W_-^2$,
$$\lvert W\rvert^\#+(W-\theta)\lvert W\rvert-\big(W^\#+W^2-\theta W\big)=4W_+\#W_--2W_-^2-2\theta W_- ,$$
which is C5. Not one step mentions $P_0$: the kernel is carried inside $W_\pm$ as zero and the identity is unconditional in $W$ and $\theta$. **CONFIRMED**, with the standing caveat the batch itself states, off the critical set the block expression and the closed form are different operators, so "$X_{\mathrm{inv}}$" off criticality names nothing until one of them is elected.

**The consequence paragraph is refuted by the record's own definitions.** It says the leftover "at a critical point of the constrained problem lies in $\mathcal W_n^\perp$ (Ricci part, $\Lambda^4$ part and scalar part) and is **not** an operator zero", and reserves a search for a critical point with $Q(W)-\theta W\ne0$. But:

- $Q$ **maps $\mathcal W_n$ to itself**, [conventions.md](../findings/conventions.md) tables it, and it follows from [Result 2](../results.md) ($\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$ give $\mathrm{Ric}(Q(W))=0$) with Böhm–Wilking's Bianchi preservation. So $Q(W)-\theta W\in\mathcal W_n$, and an element of $\mathcal W_n\cap\mathcal W_n^\perp$ is zero.
- "Critical point" **is** $Q(W)=\theta W$, [conventions.md](../findings/conventions.md), stated as a definition. A critical point with $Q(W)-\theta W\ne0$ is a contradiction in terms.

**Consequences.** $\langle Q(W)-\theta W,H\rangle=0$ at every critical point; [post F55](../findings/second-order.md)'s $J_5=4\langle C,H\rangle-2\langle\theta W_-+W_-^2,H\rangle$ is **not** missing a term; and the run the batch reserved under [analysis-only](../.claude/rules/analysis-only.md) should be **struck rather than left blocked**, it was proposed to decide something the definitions already decide.

**And the object C5 says is the wrong name is also zero.** At a critical point $W^\#=\theta W-W^2$ commutes with $W$, so for $a\ne b$ in $\{+,-,0\}$, $P_aW^\#P_b=\theta P_aWP_b-P_aW^2P_b=0$, and $P_0W^\#P_0=0$. Hence:

- $P_\pm W^\#P_0+P_0W^\#P_\pm$ is **the zero operator**, so [ATTEMPTS.md](../ATTEMPTS.md) Result 4's display is true as written and C5's "names the leftover by the wrong object" is wrong, **both names denote zero**, and the true correction is that Result 4's gloss, "block-off-diagonal terms, the concrete shape a proof of $J_5\ge0$ has to handle", describes nothing to handle.
- **[DERIVE-j5](DERIVE-j5.md)'s route (2) for a new idea, "a route through the block-off-diagonal terms $P_\pm W^\#P_0+P_0W^\#P_\pm$, which the PSD calculus does not reach", points at the zero operator and should be struck from the list of three surviving directions.**
- The record's "established compressions ($P_+W^\#P_-=P_0W^\#P_0=0$), verified to $10^{-15}$" are a one-line consequence of criticality, and the stronger true statement is $[W^\#,W]=0$.
- **A repair that is worth having.** Since $W^\#$ contributes no cross blocks, $X_{\mathrm{cross}}=4\,(W_+\#W_-)_{\mathrm{cross}}$ exactly, so Result 5's reduced open statement becomes $4\lvert\langle C_{\mathrm{cross}},H_{\mathrm{cross}}\rangle\rvert\le J_5^{\mathrm{diag}}$ with $C=W_+\#W_-\succeq0$: **the whole cross question is the off-diagonal blocks of one PSD operator**, against the off-diagonal blocks of another.

## What this review recommends changing

1. **Correct $H$'s spectrum to $\eta_i+\eta_j$** in [DERIVE-j5](DERIVE-j5.md) Batch 1(2), and drop the factor $2$ from the $J_5$ display there, which currently reads $J_5=2J_5$.
2. **Withdraw the inference** that $H_{\mathrm{cross}}$ is an artefact of the splitting; replace it with the misalignment reading, which Result 5(c) already supports.
3. **Close Batch 1(4)'s blocked item** with the definitional argument above instead of a run, and strike route (2) from [DERIVE-j5](DERIVE-j5.md)'s "where a new idea would have to come from".
4. **Record the two free facts**: $[W^\#,W]=0$ at every critical point, and $X_{\mathrm{cross}}=4C_{\mathrm{cross}}$.
5. **Record the $h$-scalar case**: $J_5=\lambda\mathop{\mathrm{scal}}(X_{\mathrm{inv}})\ge0$ is already proven there, which is [post F54](../findings/second-order.md)'s blind spot.
6. **Log the spectral gap** at the $n=5$ point that refutes $\mathrm{Ric}(X_{\mathrm{inv}})\succeq0$; that discharges the standing validation debt without a new search.
