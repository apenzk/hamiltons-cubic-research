# Reviewer r414, Gate 2 on "The grant's three terms, after moving $\#I$ off one argument"

*Target: [ATTEMPTS.md](../ATTEMPTS.md) §"The grant's three terms, after moving $\#I$ off one argument" (final section, lines 3923–3936). [L16](../plan.md)(a). **Analysis only**, the derivations below are by hand; one screen was run (seconds, on objects built for the purpose, at $n=5$) and is reported as a screen, never as evidence for a positive claim.*

## Verdict in one line

**Every algebraic step is correct, and the destination is Result 4's own definition of $J_5$, halved.** The three terms recombine (by the very identity that produced them), to $\langle X_{\mathrm{inv}},\mathrm{Ric}(\lvert W\rvert)\wedge\mathrm{id}\rangle=\tfrac12\langle\mathrm{Ric}(X_{\mathrm{inv}}),\mathrm{Ric}(\lvert W\rvert)\rangle$. So the answer to the section's own closing question is neither Result 5 nor Theorem A: it is **Result 4**, the definition the grant was stated in.

| # | Claim | Verdict |
| --- | --- | --- |
| C1 | The $\#$-part of $\mathrm{tri}$ is symmetric on its own | **CONFIRMED**, derived cold from the structure-constant sum, before reading the section |
| C2 | $\langle X,\lvert W\rvert\#I\rangle=\mathop{\mathrm{tr}}\big((X\#\lvert W\rvert)I\big)=\mathop{\mathrm{tr}}(X\#\lvert W\rvert)$ | **CONFIRMED**, $I$ is the identity endomorphism of $\Lambda^2$, so $\mathop{\mathrm{tr}}(MI)=\mathop{\mathrm{tr}}M$; no constant enters |
| C3 | "the grant is three terms and nothing else", displayed as $\ge0$ | **CORRECTED**, the display is $J_5/2$, not $J_5$. Inert for the sign, live downstream |
| C4 | The three terms are new content | **REFUTED**, they sum back to $\langle\mathrm{Ric}(X_{\mathrm{inv}}),\mathrm{Ric}(\lvert W\rvert)\rangle/2$ in one line. Witness below |
| C5 | "$\mathrm{Ric}$ and $\mathrm{Ric}^*$ gone from the statement entirely" | **REFUTED**, cosmetic; recombining restores both, and $\mathrm{Ric}(W)=0$ makes the collapse a single step |
| C6 | The third term is "a defect pairing" | **CORRECTED**, it is the $\Lambda^4$-projection of the first two, subtracted. The three-term form has **zero** $\Lambda^4$ content, so the term carries no defect information |
| C7 | $A,B\succeq0\Rightarrow A\#B\succeq0\Rightarrow\mathop{\mathrm{tr}}(A\#B)\ge0$ | **CONFIRMED**, proved cold, with the sharp formula $\mathop{\mathrm{tr}}(A\#B)=\tfrac12\sum_{ij}a_ib_j\lVert[u_i,v_j]\rVert^2$; and already on record inside [Result 5](../ATTEMPTS.md)(a) |
| C8 | "the sign of the middle term is exactly the comparison the grant was always about" | **REFUTED**, the middle term is one of three, and the other two are unsigned |
| C9 | "both parts are nonnegative and they subtract" is a gain over the block form | **REFUTED**, strictly weaker than [Theorem A](../ATTEMPTS.md)+[Theorem B](../ATTEMPTS.md), and available for the whole of $J_5$ with no $\#$-calculus at all |
| C10 | Novelty of moving $\#I$ off an argument | **REFUTED**, it is self-adjointness of $R\mapsto R\#I$, which is [Lemma L131](../findings/isotropy-cap.md); and the move **discards** that operator's known spectrum |
| H1 | Silently used: $\theta\ge0$ | **HYPOTHESIS**, $\theta W_-+W_-^2\succeq0$ needs it, and the record catalogues critical points with $\theta\le0$ |

## Cold derivations, made before the section was opened

Logged in [gate2-tri-B.log](../agent_logs/gate2-tri-B.log) at phase 1, timestamped ahead of phase 2.

### C1, the $\#$-part is separately symmetric, and so is the anticommutator part

Write $(R_i)_{\alpha\mu}=\langle R_i(b_\alpha),b_\mu\rangle$ and $c_{\alpha\beta\gamma}=\langle[b_\alpha,b_\beta],b_\gamma\rangle$, totally antisymmetric. Expanding [Böhm–Wilking eq. 5](../references/boehm-wilking-2008-space-forms/notes.md),

$$\mathop{\mathrm{tr}}\big(2(R_1\#R_2)R_3\big)=\sum_{\alpha\beta\gamma}\sum_{\mu\nu\rho}c_{\alpha\beta\gamma}\,c_{\mu\nu\rho}\,(R_1)_{\alpha\mu}(R_2)_{\beta\nu}(R_3)_{\gamma\rho}.$$

Transposing two argument slots and relabelling the corresponding index pairs flips **both** copies of $c$, so the sign is $+1$: the $\#$-part is invariant under every transposition, hence fully symmetric. It needs only that the $R_i$ are self-adjoint, no Bianchi, no criticality. Separately, $\mathop{\mathrm{tr}}\big((R_1R_2+R_2R_1)R_3\big)$ picks one term from each of the two cyclic classes of $\mathop{\mathrm{tr}}(R_{\sigma1}R_{\sigma2}R_{\sigma3})$, and self-adjointness identifies the classes pairwise, so it too is symmetric alone.

**Consequence the section should carry:** $\mathrm{tri}$'s symmetry is the sum of two independent symmetries. Nothing in the move uses $\mathrm{tri}$; it uses only the $\#$-part, and citing Huisken's theorem for it overstates the input.

### C2, the identity, and what $I$ is

Setting $R_3=I$ in the symmetric $\#$-form,

$$\langle X,\,Y\#I\rangle=\mathop{\mathrm{tr}}\big(X\,(Y\#I)\big)=\mathop{\mathrm{tr}}\big((X\#Y)\,I\big)=\mathop{\mathrm{tr}}(X\#Y).$$

$I$ is **the identity endomorphism of $\Lambda^2$**, which in [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md)'s normalisation is the same object as the round unit sphere's curvature operator, the paper fixes exactly that ("the round sphere of radius one has curvature operator the identity"), and $I\#I=(n-2)I$ is the check. So $\mathop{\mathrm{tr}}(MI)=\mathop{\mathrm{tr}}M$ holds with no constant, and the $\tfrac12$ that normalises $\#$ never enters, because it sits inside $\#$ on both sides. **C2 CONFIRMED.**

Two free sanity checks. $\langle W,W\#I\rangle=-\lVert W\rVert^2$ from $W\#I=-W$, so $\mathop{\mathrm{tr}}W^\#=-\lVert W\rVert^2$, which is the record's own $\mathop{\mathrm{tr}}W^\#=-1$ at unit norm, cited three lines below the move. **The identity's content is therefore already used on the record, at $X=Y=W$.**

### C7, $\#$-positivity, with the sharp formula

$$\mathop{\mathrm{tr}}(A\#B)=\tfrac12\sum_{\alpha\beta}\big\langle[A b_\alpha,\,Bb_\beta],\,[b_\alpha,b_\beta]\big\rangle .$$

At $A=uu^\top$, $B=vv^\top$ this is $\tfrac12\lVert[u,v]\rVert^2$; indeed $\langle(A\#B)h,h\rangle=\tfrac12\langle[u,v],h\rangle^2$, so $A\#B\succeq0$ already at rank one. By bilinearity, for $A=\sum_ia_iu_iu_i^\top$ and $B=\sum_jb_jv_jv_j^\top$ PSD,

$$A\#B\succeq0,\qquad \mathop{\mathrm{tr}}(A\#B)=\tfrac12\sum_{i,j}a_ib_j\big\lVert[u_i,v_j]\big\rVert^2\ \ge\ 0,$$

with equality exactly when $\mathop{\mathrm{ran}}A$ and $\mathop{\mathrm{ran}}B$ commute in $\mathfrak{so}(n)$. **C7 CONFIRMED**, and it is not new, [Result 5](../ATTEMPTS.md)(a) already invokes "the $\#$-positivity calculus" for the three diagonal blocks.

## C4, the witness: the three terms recombine to the definition

This is the review's main finding, and it is one line.

$$\langle X,\lvert W\rvert\rangle+\mathop{\mathrm{tr}}(X\#\lvert W\rvert)-3\langle X,\mathrm{Alt}(\lvert W\rvert)\rangle=\big\langle X,\ \lvert W\rvert+\lvert W\rvert\#I-3\,\mathrm{Alt}(\lvert W\rvert)\big\rangle=\big\langle X,\ \mathrm{Ric}(\lvert W\rvert)\wedge\mathrm{id}\big\rangle,$$

the last step being [Lemma L131](../findings/isotropy-cap.md)'s identity, **the same identity that generated the three terms**. Since $\mathrm{Ric}^*=2(\cdot\wedge\mathrm{id})$,

$$\boxed{\ \langle X,\lvert W\rvert\rangle+\mathop{\mathrm{tr}}(X\#\lvert W\rvert)-3\langle X,\mathrm{Alt}(\lvert W\rvert)\rangle=\tfrac12\big\langle X,\mathrm{Ric}^*(\mathrm{Ric}\lvert W\rvert)\big\rangle=\tfrac12\big\langle\mathrm{Ric}(X),\mathrm{Ric}(\lvert W\rvert)\big\rangle=\tfrac12 J_5\ }$$

which is [Result 4](../ATTEMPTS.md)'s definition of $J_5$ verbatim. The section expands an identity, then displays the expansion; recombining is one substitution back.

**And the collapse is shorter still, because $W$ is Ricci-flat.** $\mathrm{Ric}(W)=0$ gives $\mathrm{Ric}(\lvert W\rvert)=2\,\mathrm{Ric}(W_-)=2g$ with $g=\mathrm{Ric}(W_-)=\mathrm{Ric}(W_+)\succeq0$, exactly [Result 11](../ATTEMPTS.md)'s $h=2g$, so

$$J_5=4\big\langle X_{\mathrm{inv}},\,g\wedge\mathrm{id}\big\rangle=2\big\langle\mathrm{Ric}(X_{\mathrm{inv}}),\,g\big\rangle .$$

**Verdict C4: REFUTED as new content.** The three-term form is $J_5/2$ rewritten through an identity and back.

### C5, "$\mathrm{Ric}$ and $\mathrm{Ric}^*$ gone from the statement entirely"

Syntactically true of the display, and false of its content: the display *equals* $\tfrac12\langle\mathrm{Ric}X,\mathrm{Ric}\lvert W\rvert\rangle$. A change of variables that is undone by collecting three terms has not removed an operator from the problem. **REFUTED.**

### C6, the third term is not a defect pairing

$\#I$ acts on $\Lambda^4$ by $c_4=2$ ([Lemma L131](../findings/isotropy-cap.md)(i)), so

$$\mathrm{Alt}\big(\lvert W\rvert+\lvert W\rvert\#I\big)=(1+c_4)\,\mathrm{Alt}(\lvert W\rvert)=3\,\mathrm{Alt}(\lvert W\rvert).$$

The third term is therefore **precisely the $\Lambda^4$-content of the first two, subtracted off**: the three-term expression has zero $\Lambda^4$ component, which is only $\mathrm{Ric}$ annihilating $\Lambda^4$ restated. The preceding section's suggestion that the constant $3$ "sits beside Result 2's $\tfrac32$-Gram and $\mathop{\mathrm{tr}}D=6\lVert\mathrm{Alt}\rVert^2$, which is where a successor should look for the cancellation" points at a cancellation that is total, structural and already understood. There is nothing there. **CORRECTED**: call it the $\Lambda^4$ counter-term, not a defect pairing, and do not send a successor to it.

## C3, the factor of two, and where it bites

$H=2\big(\lvert W\rvert+\lvert W\rvert\#I-3\mathrm{Alt}(\lvert W\rvert)\big)$ is stated correctly in the *preceding* section, and the section under review then displays the bracket alone and calls it "the grant". As a **sign** statement the two are equivalent, so nothing here is wrong.

It matters anyway, because $J_5$ is used **quantitatively** twice on the record:

- [Result 1](../ATTEMPTS.md)'s master identity, $\theta r^2=\sqrt2\,r^2\sqrt{1-\mathop{\mathrm{tr}}S^4}\sqrt{1-e^2}-2\langle\mathrm{Ric}(W_-^2),\mathrm{Ric}\rangle+J_4-J_5$;
- [Result 10](../ATTEMPTS.md)'s penalty $p=(J_4-J_5)/r^2$, the number that makes the lifted 3.3.6 ceiling vacuous at Fox.

A successor who reads the display as $J_5$ and substitutes it into either is wrong by a factor of two in the term that carries the whole open grant. **CORRECTED: label the display $\tfrac12 J_5$.**

## C8 and C9, the "two nonnegative traces that subtract" reading

Three separate objections, in increasing order of force.

**(i) The claim about the middle term is an overclaim.** "The sign of the middle term is exactly the comparison the grant was always about", the middle term is one of three, and $X_{\mathrm{inv}}$ is not PSD (the record refutes it), so terms one and three are unsigned too. The grant's sign is not the middle term's sign. **REFUTED as stated**; the true statement is that the middle term splits as $4\mathop{\mathrm{tr}}(C\#\lvert W\rvert)-2\mathop{\mathrm{tr}}\big((\theta W_-+W_-^2)\#\lvert W\rvert\big)$, which is correct and which says nothing about the other two.

**(ii) The split needs no $\#$-calculus, and it applies to the whole grant.** $H\succeq0$ is proven ([Result 5](../ATTEMPTS.md)(b)), $C\succeq0$, and $\theta W_-+W_-^2\succeq0$, so directly

$$J_5=4\langle C,H\rangle-2\big\langle\theta W_-+W_-^2,\ H\big\rangle,$$

both terms nonnegative because the Frobenius pairing of two PSD operators is nonnegative. The identical split of the identical shape is available for term one ($\langle X,\lvert W\rvert\rangle$, $\lvert W\rvert\succeq0$) and for $J_5$ itself, with none of $\mathrm{tri}$, $\#I$, or [Lemma L131](../findings/isotropy-cap.md). **The reformulation buys nothing even for the nonnegativity of the pieces.**

**(iii) It is strictly weaker than the block form it replaces.** Compare what the two readings deliver:

| Reading | What is proven | What is open | Does the open part ever vanish |
| --- | --- | --- | --- |
| [Theorem A](../ATTEMPTS.md)+[Theorem B](../ATTEMPTS.md) block form | $J_5^{\mathrm{diag}}\ge0$, a **signed lower bound** on part of $J_5$; $X_{\mathrm{cross}}=4C_{\mathrm{cross}}$ | $\lvert\mathrm{cross}\rvert\le J_5^{\mathrm{diag}}$, one term | **Yes**, zero on the commuting class, i.e. at every named critical point |
| The section's difference of $\#$-traces | each of two terms $\ge0$ | which of the two is larger | **No**, neither term vanishes anywhere catalogued |

A difference of two nonnegative numbers is an arbitrary real, so the new reading supplies **no** lower bound on $J_5$, where the block form supplies $J_5\ge J_5^{\mathrm{diag}}-\lvert\mathrm{cross}\rvert$ with the first summand proven nonnegative and the second proven zero on the class containing Fox, the sphere products, SU(3), the $\mathfrak{su}(m)$ family, QK $\mathbb{HP}^m$ and the plateau. **C9 REFUTED**: the reformulation replaces a decomposition with a proven-nonnegative part and a vanishing remainder by an unsigned difference with neither. The section's own phrase, "now stated as one inequality between two $\#$-traces rather than as a block sum", names a trade in the wrong direction.

## C10, the novelty of moving $\#I$ off an argument, and what the move throws away

The move is exactly the statement that $R\mapsto R\#I$ is **self-adjoint for the Frobenius product**. That is on the record twice over: [Lemma L131](../findings/isotropy-cap.md) identifies it with $-\tfrac12\mathcal A$, and $\mathcal A$ is a symmetric operator whose full eigen-decomposition is [Lemma L79](../findings/isotropy-cap.md), $\#I$ acts by $n-2$, $\tfrac{n-4}2$, $-1$, $2$ on $\langle I\rangle$, $\langle\mathrm{Ric}_0\rangle$, $\mathrm{Weyl}_n$, $\Lambda^4$.

**And the move discards precisely that.** Keeping $\#I$ where it stands gives, with $\lvert W\rvert=W+2W_-$ and $W\#I=-W$ exact,

$$\lvert W\rvert\#I=-W+2\,(W_-\#I),\qquad\text{so}\qquad \langle X,\lvert W\rvert\rangle+\langle X,\lvert W\rvert\#I\rangle=2\big\langle X,\ W_-+W_-\#I\big\rangle,$$

an expression in $W_-$ alone, on an operator with a four-line spectral table. The section instead sends $\#I$ into an opaque pair-invariant $\mathop{\mathrm{tr}}(X\#\lvert W\rvert)$ about which the record knows only a sign. **REFUTED as a gain**; the record's own instrument is sharper than the one the move produces. *(Completing the display above with the $\Lambda^4$ counter-term reproduces the C4 collapse: $2\langle X,W_-+W_-\#I-3\mathrm{Alt}(W_-)\rangle=2\langle X,g\wedge\mathrm{id}\rangle$.)*

## H1, the hypothesis used without saying so

"$2\mathop{\mathrm{tr}}\big((\theta W_-+W_-^2)\#\lvert W\rvert\big)$, which is also $\ge0$ for the same reason" requires $\theta W_-+W_-^2\succeq0$. With $W_-\succeq0$ that holds iff $\theta+\lambda\ge0$ for every nonzero eigenvalue $\lambda$ of $W_-$, i.e.

$$\theta\ \ge\ -\lambda^+_{\min}(W_-),$$

which is automatic **only for $\theta\ge0$**. The record's convention is $\theta>0$ ([diagonal-half.md](../findings/diagonal-half.md), on the two branches of padded $W_{\mathbb{CP}^2}$), but it also catalogues critical points with $\theta\le0$, [bounds-relaxations.md](../findings/bounds-relaxations.md) records six of nine, and twelve of twenty-two, on the band. So the clause is a hypothesis, not a free step. It costs nothing to state; it costs a reader a wrong branch to omit.

Two further hypotheses used correctly but worth naming, since the neighbouring section advertises "no Bianchi hypothesis": the [Lemma L131](../findings/isotropy-cap.md) rewrite of $H$ is indeed unconditional, but the closed form $X_{\mathrm{inv}}=4C-2\theta W_--2W_-^2$ is **criticality-dependent** ($W^\#=\theta W-W^2$, [Theorem A](../ATTEMPTS.md)), and the $\#$-part's symmetry needs the arguments self-adjoint. The framing "the grant is a $\#$-calculus statement plus one term linear in the defect" inherits the criticality hypothesis silently.

## Screen

Reported as a screen only. At $n=5$, on an $\mathfrak{so}(5)$ basis built for this check with [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md)'s $-\tfrac12\mathop{\mathrm{tr}}(AB)$ product and $\#$ from eq. 4: the basis is orthonormal to $0$; $\lVert I\#I-(n-2)I\rVert_\infty=0$; $\langle X,Y\#I\rangle-\mathop{\mathrm{tr}}(X\#Y)=7\times10^{-15}$ at random symmetric $X,Y$; the spread of $\mathop{\mathrm{tr}}\big((R_{\sigma1}\#R_{\sigma2})R_{\sigma3}\big)$ over all six permutations is $3.6\times10^{-14}$; and $\mathop{\mathrm{tr}}(A\#B)=\tfrac12\lVert[u,v]\rVert^2$ agrees to $4\times10^{-15}$ at rank one. Nothing here is evidence for a positive claim, the claims above are proved by hand, and this only confirms the conventions match.

## What the section should become

Two lines are worth keeping, and both are corrections rather than additions.

1. **$J_5=2\langle\mathrm{Ric}(X_{\mathrm{inv}}),g\rangle$ with $g=\mathrm{Ric}(W_-)=\mathrm{Ric}(W_+)\succeq0$.** Same statement as [Result 4](../ATTEMPTS.md), in the variable [Result 11](../ATTEMPTS.md) already proved facts about, with $\mathrm{Ric}(\lvert W\rvert)$ eliminated by $\mathrm{Ric}(W)=0$.
2. **The three-term form has no $\Lambda^4$ content**, the third term being the $\Lambda^4$ counter-term forced by $c_4=2$. That closes the "look for the cancellation beside $\mathop{\mathrm{tr}}D=6\lVert\mathrm{Alt}\rVert^2$" suggestion in the preceding section: the cancellation is complete and carries no defect information.

Neither is a route. The section's own closing sentence (that Gate 2 should ask whether this is the record's Result 5 in other symbols), has the right instinct and the wrong target: **it is Result 4 in other symbols**, and Result 4 is the grant itself.
