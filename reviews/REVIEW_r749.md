# Reviewer r749, L169: the grading and tracelessness determine the saturating operator

**Cold review.** I worked from [BRIEF-g2-l169.md](BRIEF-g2-l169.md) alone and from mathematics I re-derived, and I did not open the findings file the block came from until every verdict below was fixed. **No numerical work was done.** Two exact symbolic screens are reported as screens, each of a claim I had already derived by hand, each seconds of compute on objects I built for the purpose; every value in this report is rational or a closed-form surd. Log: [agent_logs/g2-l169-r749.log](../agent_logs/g2-l169-r749.log).

| # | claim | verdict |
| --- | --- | --- |
| C1 | Ricci-flatness makes $W$ traceless on $\Lambda^2$ | **CONFIRMED**, implication only, and the argument closes on the implication |
| C2 | $r=\tfrac{n(n-2)}4$, $N-r=\tfrac{n^2}4$, $\tfrac r{N-r}=\tfrac{n-2}n$ | **CONFIRMED** |
| C3 | exactly two eigenvalues gives $E_{\min}=E_{\max}^\perp$ and no kernel | **CONFIRMED** |
| C4 | $W\in\mathbb R(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$, scale and sign fixed | **CONFIRMED**, the sign is fixed by $\lambda_{\max}>0$ *and* $E_{\max}=\mathfrak h$ jointly |
| C5 | the balanced Casimir member is $W_{S^{n/2}\times S^{n/2}}$, with $E_{\max}=\mathfrak h$ | **CONFIRMED**, derived cold from the product curvature |
| C6 | $\theta=\tfrac2n\sqrt{rN/(N-r)}=\theta_0(n)$ at this member | **CONFIRMED**, derived cold from the $\mathfrak{so}(n)$ brackets |
| C7 | criticality is not used | **CONFIRMED**, the closed form imports none |
| C8 | saturation is not used | **CONFIRMED** |
| C9 | the ratio hypothesis is tracelessness read backwards | **CONFIRMED**, given $E_{\max}=\mathfrak h$ and the two-eigenvalue form |
| C10 | conjugating in and back out preserves everything claimed | **CONFIRMED** |
| C11 | at odd $n$ the hypothesis is unsatisfiable | **CONFIRMED**, the stated reason is true but downstream of the direct one |
| C12 | "at $n=4$ the conclusion would be false" | **REFUTED AS STATED**, the lemma's own conclusion holds at $n=4$; the escape clause about $W_{\mathbb{CP}^2}$ is **CONFIRMED** |
| C13 | $n=6$ carries the statement without degeneration | **CONFIRMED** |
| C14 | first Bianchi is consumed somewhere in the proof | **REFUTED**, it is never used; the block proves a strictly larger statement |
| C15 | $\lambda_{\max}>0>\lambda_{\min}$ is an independent hypothesis | **REFUTED**, it is forced by tracelessness, $\lVert W\rVert=1$ and two eigenvalues |

**Overall verdict: PROVEN, hypotheses corrected.** The mathematics closes at every step and the sharpest question in the brief comes out in the block's favour: I evaluated $\theta$ at the balanced member from the structure constants of $\mathfrak{so}(n)$ and got $\theta_0(n)$ with no critical-point equation anywhere in the derivation. Three hypotheses are dead weight, first Bianchi, the sign conditions on the two eigenvalues, and all of Ricci-flatness beyond its trace, and one edge remark is wrong as written.

**One-line summary.** The lemma is proved and can be restated on strictly weaker hypotheses: *a scalar-flat symmetric $W$ on $\Lambda^2\mathbb R^n$ of unit norm with exactly two eigenvalues and $E_{\max}$ conjugate to $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ is the sphere product's Weyl tensor and has $\theta=\theta_0(n)$*, but the $n=4$ remark must be rewritten to say that what fails at $n=4$ is the *extremality* of the sphere product, not this lemma's conclusion.

## 0. Conventions, fixed once

Everything below is in one normalisation, and the brief's flagged factor-of-two hazard is settled by §6, which reproduces $\theta_0(n)$ on the nose.

- $\Lambda^2\mathbb R^n$ carries the inner product making $\{e_i\wedge e_j\}_{i<j}$ orthonormal. $N=\binom n2=\dim\Lambda^2$.
- $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ by $e_i\wedge e_j\mapsto b_{ij}:=E_{ij}-E_{ji}$, and $\langle A,B\rangle=\tfrac12\mathop{\mathrm{tr}}(A^{\mathsf T}B)$, so $\{b_{ij}\}_{i<j}$ is orthonormal too.
- An algebraic curvature tensor is read as the symmetric operator $W$ with $\langle W(e_i\wedge e_j),e_k\wedge e_l\rangle=W_{ijkl}$; $\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)=\sum_{i<j,\,k<l}W_{ijkl}^2$.
- $\mathrm{Ric}_{ik}=\sum_jW_{ijkj}$, $\mathrm{scal}=\sum_i\mathrm{Ric}_{ii}$.
- Structure constants $c_{\alpha\beta\gamma}=\langle[b_\alpha,b_\beta],b_\gamma\rangle$, totally antisymmetric. The sharp operator is $(W^\#)_{\gamma\delta}=\tfrac12\sum_{\alpha\beta\mu\nu}c_{\alpha\beta\gamma}c_{\mu\nu\delta}W_{\alpha\mu}W_{\beta\nu}$, normalised by $\mathrm{Id}^\#=(n-2)\mathrm{Id}$.
- $P(W)=\langle W,W^2+W^\#\rangle=\mathop{\mathrm{tr}}(W^3)+\langle W,W^\#\rangle$, $\theta(W)=P(W)/\lVert W\rVert^3$, $\theta_0(n)=\tfrac1n\sqrt{2(n-1)(n-2)}$.
- $n=2p$ throughout, $\mathbb R^n=A\oplus B$ with $\dim A=\dim B=p$, and $\mathfrak h=\mathfrak{so}(A)\oplus\mathfrak{so}(B)$, spanned by exactly those $b_{ij}$ whose two indices lie in the same block. $\mathfrak m=\mathfrak h^\perp$ is spanned by the mixed $b_{ij}$.

## 1. Hypothesis inventory

| hypothesis | where the proof uses it | verdict |
| --- | --- | --- |
| $n$ even | for $\mathfrak{so}(n/2)$ to exist at all | **used, and load-bearing** |
| $W$ symmetric on $\Lambda^2$ | the spectral decomposition in step 1 | **used** |
| first Bianchi (part of $W\in\mathcal W_n$) | nowhere | **unused** |
| Ricci-flat (part of $W\in\mathcal W_n$) | only through $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$ | **used at the strength of scalar-flatness only** |
| $\lVert W\rVert=1$ | fixes the scale; also gives $W\ne0$ | **used** |
| exactly two eigenvalues | the two-projector form and the absence of a kernel | **used, and load-bearing** |
| $\lambda_{\max}>0>\lambda_{\min}$ | quoted when the sign is fixed | **implied by the three above; redundant** |
| $E_{\max}$ conjugate to $\mathfrak h$ | the conjugation, and the sign | **used, and load-bearing** |
| criticality | nowhere | **unused, correctly claimed** |
| saturation $\theta=\theta_0$ | nowhere; it is a conclusion | **unused, correctly claimed** |
| the ratio $(n-2)\lambda_{\max}=n\lvert\lambda_{\min}\rvert$ | nowhere as an input | **derived, not assumed** |

Two imported facts stand behind the last two sentences of the block, and I checked both at source rather than taking them: that the balanced Casimir member is the sphere product's Weyl tensor (§5), and that its $\theta$ is $\tfrac2n\sqrt{rN/(N-r)}$ (§6). The third import, that the sphere product's isotropy is $\mathfrak h$ at that dimension, is decoration: the isotropy algebra of $S^p\times S^p$ at a point is $\mathfrak{so}(p)\oplus\mathfrak{so}(p)$, of dimension $p(p-1)=r$, which is right, but no step consumes it. The operator's actual stabiliser in $SO(n)$ is the *normaliser* of $\mathfrak h$, strictly larger than the isotropy group, and nothing in the proof is sensitive to which of the two is meant.

## 2. Attack 1, Ricci-flatness and the trace on $\Lambda^2$

**Derivation.** With $\{e_i\wedge e_j\}_{i<j}$ orthonormal,
$$\mathop{\mathrm{tr}}_{\Lambda^2}W=\sum_{i<j}\langle W(e_i\wedge e_j),e_i\wedge e_j\rangle=\sum_{i<j}W_{ijij}=\tfrac12\sum_{i,j}W_{ijij}=\tfrac12\sum_i\mathrm{Ric}_{ii}=\tfrac12\,\mathrm{scal}.$$
So $\mathrm{Ric}=0\Rightarrow\mathrm{scal}=0\Rightarrow\mathop{\mathrm{tr}}_{\Lambda^2}W=0$.

**Which normalisation, and does the flagged hazard bite.** It does not bite here. Reading $\Lambda^2\subset\otimes^2$ with the tensor norm replaces the orthonormal basis by one of squared length $2$ and multiplies the trace by a constant; the *vanishing* of the trace is unaffected. The hazard bites only on the numerical value of $\theta$, where a rescaling $\lVert\cdot\rVert\mapsto c\lVert\cdot\rVert$ sends $\theta\mapsto c^{-3}\theta$. That is settled independently in §6, where the conventions of §0 return $\theta_0(n)$ exactly at $n=4,6,8$.

**Implication or equivalence.** Implication only, and strictly so. $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$ says $\mathrm{scal}=0$, which is one linear condition; $\mathrm{Ric}=0$ is $\binom{n+1}2$ of them. Any scalar-flat, non-Ricci-flat algebraic curvature tensor witnesses the gap, and they exist for every $n\ge3$: take $\mathrm{Ric}_0\ne0$ trace-free and form $\tfrac1{n-2}\mathrm{Ric}_0\owedge g$.

**Does the argument still close.** Yes, and this is a strengthening rather than a defect. Every later step consumes the trace and nothing else from $\mathcal W_n$, so the conclusion holds for scalar-flat symmetric operators. The conclusion is not thereby weakened: the operator the argument lands on is a genuine Weyl tensor, so it *is* Ricci-flat and *does* satisfy first Bianchi, those two hypotheses are recovered as output rather than spent as input.

## 3. Attack 2, the dimension count

$\dim\mathfrak{so}(p)=\binom p2$, so with $p=n/2$,
$$r=2\binom{n/2}2=2\cdot\frac{\tfrac n2(\tfrac n2-1)}2=\frac n2\Bigl(\frac n2-1\Bigr)=\frac{n(n-2)}4.$$
$$N-r=\frac{n(n-1)}2-\frac{n(n-2)}4=\frac{2n(n-1)-n(n-2)}4=\frac{n\bigl(2n-2-n+2\bigr)}4=\frac{n^2}4.$$
Cross-check without subtraction: $\mathfrak m\cong A\otimes B$ has dimension $p^2=n^2/4$. Both agree.
$$\frac r{N-r}=\frac{n(n-2)/4}{n^2/4}=\frac{n-2}n,\qquad \frac rN=\frac{n(n-2)/4}{n(n-1)/2}=\frac{n-2}{2(n-1)}.$$
All three checks pass. Note $r>0$ requires $n\ge4$; at $n=2$ the algebra $\mathfrak h$ is zero and the hypothesis is empty.

## 4. Attacks 3 and 7, the spectrum, the kernel, and the conjugation

**No kernel.** "Exactly two eigenvalues" means the spectrum is a two-element set, and the statement names its elements $\lambda_{\max}>0>\lambda_{\min}$; neither is $0$, so $\ker W=0$. $W$ is symmetric, so $\Lambda^2=E_{\max}\oplus E_{\min}$ orthogonally and $E_{\min}=E_{\max}^\perp$, giving $W=\lambda_{\max}\Pi_{\mathfrak h}+\lambda_{\min}(\mathrm{Id}-\Pi_{\mathfrak h})$ after the conjugation. The brief asks what happens if a zero eigenvalue is not excluded: it *is* excluded, twice over. If one dropped the sign clause and allowed a two-element spectrum containing $0$, tracelessness would force the other eigenvalue to be $0$ as well, contradicting $\lVert W\rVert=1$, so a kernel is impossible on the two-eigenvalue stratum regardless. This is the ground for **C15**: given $\mathop{\mathrm{tr}}W=0$, $\lVert W\rVert=1$ and a two-element spectrum, $\lambda_{\max}>0>\lambda_{\min}$ is a theorem, not a hypothesis.

**The conjugation.** $SO(n)$ acts on $\Lambda^2$ through $\rho(g)=\Lambda^2g$, which is $\mathrm{Ad}$ under the identification of §0. If $\rho(g)E_{\max}(W)=\mathfrak h$, set $\widetilde W=\rho(g)W\rho(g)^{-1}$. Then $\widetilde W$ is symmetric with the same spectrum and multiplicities, $E_{\max}(\widetilde W)=\rho(g)E_{\max}(W)=\mathfrak h$, $\lVert\widetilde W\rVert=\lVert W\rVert$, and $\widetilde W\in\mathcal W_n$ because both first Bianchi and the Ricci contraction are $O(n)$-equivariant. Conjugating back: the conclusion for $\widetilde W$ is that $\widetilde W$ is $SO(n)$-conjugate to $W_{S^p\times S^p}$, and $SO(n)$-conjugacy is an equivalence relation on symmetric operators, so the same holds for $W=\rho(g)^{-1}\widetilde W\rho(g)$. The $\theta$ claim transports because $\mathop{\mathrm{tr}}$, $\#$ and $\lVert\cdot\rVert$ are all $O(n)$-equivariant, hence $\theta(\widetilde W)=\theta(W)$. Nothing is lost in either direction.

One point worth naming since the brief asks whether $SO(n)$-conjugacy of the *eigenspace* suffices: it does, because the eigenspace is all the proof ever uses, the eigenvalues are then pinned by tracelessness and the norm, not carried through the conjugation as extra data. The two possible block-swap normalisations of $\mathfrak h$ (whether the exchange of $A$ and $B$ lies in $SO(n)$ depends on the parity of $p$) are irrelevant, since both stabilise $\mathfrak h$ setwise.

## 5. Attacks 4 and 9, the line, the sign, and that the member is the sphere product

**The line.** From the two-projector form and $\mathop{\mathrm{tr}}W=r\lambda_{\max}+(N-r)\lambda_{\min}=0$ we get $\lambda_{\min}=-\lambda_{\max}\tfrac r{N-r}$ and
$$W=\lambda_{\max}\Bigl[\Pi_{\mathfrak h}-\tfrac r{N-r}(\mathrm{Id}-\Pi_{\mathfrak h})\Bigr]=\lambda_{\max}\tfrac N{N-r}\Bigl(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}\Bigr).$$
So $W=t\,(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with $t=\lambda_{\max}N/(N-r)$.

**The sign, the one place I tried hardest to break the block.** Read in isolation, "$\lVert W\rVert=1$ fixes the scale up to sign and $\lambda_{\max}>0$ the sign" is not a valid inference: *both* unit multiples $\pm(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})/\lVert\cdot\rVert$ have $\lambda_{\max}>0$, since each is traceless and nonzero. The $t<0$ operator has eigenvalues $-t\tfrac rN>0$ on $\mathfrak h^\perp$ and $t(1-\tfrac rN)<0$ on $\mathfrak h$; its largest eigenvalue is positive.

**Argued the opposite, and the block survives.** The sentence is not in isolation. By the time it is written, $E_{\max}=\mathfrak h$ has already been used to put $\lambda_{\max}$ on the $\Pi_{\mathfrak h}$ slot, so $t=\lambda_{\max}N/(N-r)$ and $\lambda_{\max}>0$ does give $t>0$. The inference is sound as sequenced. **I therefore report this `withdrawn`** as a defect and record only that the sentence understates its own premise: what fixes the sign is $E_{\max}=\mathfrak h$ together with $\lambda_{\max}>0$, and the second is redundant given §4.

**The member is the sphere product's Weyl tensor, derived cold.** Give each factor of $S^p\times S^p$ the unit round metric. The curvature operator of a Riemannian product is the direct sum of the factors' with zero on the mixed part, and the round $S^p(1)$ has curvature operator $\mathrm{Id}_{\Lambda^2}$, so
$$R_{S^p\times S^p}=\Pi_{\Lambda^2A\oplus\Lambda^2B}=\Pi_{\mathfrak h}.$$
Each factor has $\mathrm{Ric}=(p-1)g$, so the product is **Einstein** with $\mathrm{Ric}=(p-1)g$ and $\mathrm{scal}=n(p-1)$. For an Einstein metric the trace-free Ricci term of the curvature decomposition vanishes and the scalar term is $\tfrac{\mathrm{scal}}{n(n-1)}\mathrm{Id}$ on $\Lambda^2$, so
$$W_{S^p\times S^p}=\Pi_{\mathfrak h}-\frac{p-1}{n-1}\mathrm{Id}=\Pi_{\mathfrak h}-\frac rN\mathrm{Id},$$
the last equality because $\tfrac rN=\tfrac{n-2}{2(n-1)}=\tfrac{p-1}{n-1}$. This is the same operator, with the same $r$, obtained without reference to the Casimir family. Its trace is $r-\tfrac rN\cdot N=0$, as it must be, and its eigenvalues are $1-\tfrac rN>0$ on $\mathfrak h$ and $-\tfrac rN<0$ on $\mathfrak m$, so $E_{\max}=\mathfrak h$ for the positive multiple. The block's sign check is right.

**The norm and the spectrum at unit scale.** $\lVert\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}\rVert^2=r(1-\tfrac rN)^2+(N-r)(\tfrac rN)^2=\tfrac{r(N-r)}N$, so at unit norm
$$\alpha:=\lambda_{\max}=\sqrt{\tfrac{N-r}{rN}}=\frac1{\sqrt{(p-1)(2p-1)}},\qquad \beta:=\lambda_{\min}=-\sqrt{\tfrac r{N(N-r)}}=-\frac{p-1}{p\sqrt{(p-1)(2p-1)}},$$
using $N=p(2p-1)$, $r=p(p-1)$, $N-r=p^2$. Check: $r\alpha+(N-r)\beta=\tfrac{p(p-1)-p(p-1)}{\sqrt{\cdot}}=0$ and $r\alpha^2+(N-r)\beta^2=\tfrac{p(p-1)+(p-1)^2}{(p-1)(2p-1)}=1$.

**Two unit positive multiples of one operator coincide.** Trivially true, and it is what the block needs: both $W$ and $W_{S^p\times S^p}$ have been shown to be positive multiples of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ of norm one.

## 6. Attack 5, the $\theta$ evaluation, and whether criticality enters through it

This is the brief's sharpest question, so I did not quote the closed form; I derived $\theta$ at the balanced member from scratch.

**The structure constants.** For $b_{ij}=E_{ij}-E_{ji}$ one computes $[b_{ij},b_{ik}]=-b_{jk}$ and $[b_{ij},b_{kl}]=0$ whenever $\{i,j\}\cap\{k,l\}=\emptyset$ or $\{i,j\}=\{k,l\}$. Hence $c_{\alpha\beta\gamma}\ne0$ exactly when the three index-pairs $\alpha,\beta,\gamma$ are the three edges of a triangle $\{i,j,k\}$, and then $c_{\alpha\beta\gamma}=\pm1$. Convention anchor: $(\mathrm{Id}^\#)_{\gamma\gamma}=\tfrac12\sum_{\alpha\beta}c_{\alpha\beta\gamma}^2=\tfrac12\cdot2(n-2)=n-2$, since a fixed edge $\gamma=(jk)$ sits in exactly $n-2$ triangles and each contributes two ordered pairs. So $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, the standard normalisation.

**The cubic invariant on a block-diagonal spectrum.** $W=\alpha\Pi_{\mathfrak h}+\beta\Pi_{\mathfrak m}$ is diagonal in $\{b_{ij}\}$ with $\lambda_{ij}=\alpha$ when $i,j$ share a block and $\beta$ otherwise. Then
$$\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\beta\gamma}c_{\alpha\beta\gamma}^2\lambda_\alpha\lambda_\beta\lambda_\gamma=\tfrac12\sum_{\{i,j,k\}}6\,\lambda_{ij}\lambda_{ik}\lambda_{jk}=3\sum_{i<j<k}\lambda_{ij}\lambda_{ik}\lambda_{jk}.$$
Triangles split into two types: all three vertices in one block, contributing $\alpha^3$, of which there are $2\binom p3$; and two vertices in one block with one in the other, contributing $\alpha\beta^2$, of which there are $2p\binom p2$. Hence
$$\langle W,W^\#\rangle=6\binom p3\alpha^3+6p\binom p2\alpha\beta^2=p(p-1)(p-2)\alpha^3+3p^2(p-1)\alpha\beta^2.$$
Sanity check at $\alpha=\beta=1$: this is $p(p-1)(4p-2)=(n-2)N$, matching $\langle\mathrm{Id},\mathrm{Id}^\#\rangle$.

**Assembling $P$.** With $\mathop{\mathrm{tr}}(W^3)=p(p-1)\alpha^3+p^2\beta^3$,
$$P(W)=p(p-1)^2\alpha^3+p^2\beta^2\bigl[\beta+3(p-1)\alpha\bigr].$$
Substituting the unit-norm traceless values of §5 and writing $s=\sqrt{(p-1)(2p-1)}$, so $\alpha=1/s$ and $\beta=-(p-1)/(ps)$:
$$P(W)=\frac{(p-1)^2}{ps^3}\bigl[p^2+(p-1)(3p-1)\bigr]=\frac{(p-1)^2(2p-1)^2}{p\,s^3}=\frac{\sqrt{(p-1)(2p-1)}}p,$$
the bracket collapsing because $p^2+3p^2-4p+1=(2p-1)^2$. In terms of $n=2p$,
$$\theta(W)=P(W)=\frac2n\sqrt{\tfrac{n-2}2\,(n-1)}=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$

**Screen.** I rebuilt $\mathfrak{so}(n)$, the full tensor $c_{\alpha\beta\gamma}$ and the sharp operator symbolically at $n=4,6,8$ and evaluated $P$ on the unit-norm balanced operator: $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ in all three, and $P=\tfrac{\sqrt3}2,\ \tfrac{\sqrt{10}}3,\ \tfrac{\sqrt{21}}4$, equal to $\theta_0(4),\theta_0(6),\theta_0(8)$ exactly. This is reported as a screen of a hand derivation, not as evidence for it.

**Does the closed form import criticality, the verdict.** **It does not, and it cannot.** Two separate reasons, and the second is the decisive one.

1. *Structurally.* $\theta$ is a function on $\Lambda^2$-operators. The proof pins $W$ to a single point by linear algebra; evaluating a function at a determined point cannot consume a hypothesis about that point. A criticality proviso attached to the closed form on the record can only be a restriction on *where the record chose to state it*, never a premise of the evaluation.
2. *Concretely.* The derivation above never writes a critical-point equation. It uses the spectrum, the block decomposition of $\mathfrak{so}(n)$ under $\mathfrak h$, and the triangle census (nothing else) and it lands on the record's $\tfrac2n\sqrt{rN/(N-r)}$: at $r=p(p-1)$, $N=p(2p-1)$, $N-r=p^2$ one has $\tfrac{rN}{N-r}=(p-1)(2p-1)$, so $\tfrac2n\sqrt{rN/(N-r)}=\tfrac1p\sqrt{(p-1)(2p-1)}$, exactly the $P(W)$ above.

So the block's claim stands, and it stands on more than the syllogism: the number it quotes is independently correct at the member it quotes it for. The residual arithmetic in the block is also right, $\tfrac{rN}{N-r}=\tfrac{(n-1)(n-2)}2$ and $\tfrac2n\sqrt{(n-1)(n-2)/2}=\theta_0(n)$.

## 7. Attack 6, the redundancy claims

**Criticality: not consumed.** Confirmed in §6.

**Saturation: not consumed.** Confirmed. $\theta=\theta_0(n)$ appears only as the last line of the conclusion, derived from the operator; no step conditions on it. This matters, because the block's function on the record is presumably to run the implication in the direction *grading $\Rightarrow$ saturation*, and a saturation hypothesis would make it circular. It has none.

**The ratio and tracelessness are one equation.** Confirmed, with the premises named. Given $W=\lambda_{\max}\Pi_{\mathfrak h}+\lambda_{\min}\Pi_{\mathfrak h^\perp}$ with $\dim\mathfrak h=r$ and $\lambda_{\min}<0<\lambda_{\max}$,
$$\mathop{\mathrm{tr}}W=0\iff r\lambda_{\max}+(N-r)\lambda_{\min}=0\iff\frac{\lvert\lambda_{\min}\rvert}{\lambda_{\max}}=\frac r{N-r}=\frac{n-2}n\iff(n-2)\lambda_{\max}=n\lvert\lambda_{\min}\rvert,$$
every arrow reversible because $\lambda_{\max}\ne0$ and $\lambda_{\min}<0$. The equivalence is genuine, but it is *not* unconditional: it holds only on the two-eigenvalue stratum with $E_{\max}$ of dimension exactly $r$. Stated without those, tracelessness is one equation in $N$ unknowns and the ratio is a different one. The block's "the same equation read in two directions" is right in its context and would be wrong if lifted out of it, worth a clause in the record.

**Two redundancies the block does not claim, and should.** First Bianchi is never used (§2), and the sign conditions $\lambda_{\max}>0>\lambda_{\min}$ are derived rather than assumed (§4).

## 8. Attack 9, the edges

**Odd $n$.** The hypothesis is unsatisfiable, confirmed. The block's reason, $\tfrac{n^2}4\notin\mathbb Z$, is *true* ($n$ odd makes $n^2$ odd) but it is a consequence rather than the obstruction. The direct statement is that $\mathfrak{so}(n/2)$ is undefined for $n/2\notin\mathbb Z$, so no subalgebra of the named type exists and no $E_{\max}$ can be conjugate to one. Both routes reach the same place; the block's is roundabout, and I record it as a presentational point rather than an error.

**$n=6$, does anything degenerate.** Nothing does. $p=3$, $\mathfrak h=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ is a genuine $6$-dimensional subalgebra of the $15$-dimensional $\mathfrak{so}(6)$, and $r=\tfrac{6\cdot4}4=6$ matches, $N-r=9=\tfrac{36}4$. The unit spectrum is $\alpha=\tfrac1{\sqrt{10}}$ with multiplicity $6$ and $\beta=-\tfrac2{3\sqrt{10}}$ with multiplicity $9$; trace $\tfrac6{\sqrt{10}}-\tfrac{18}{3\sqrt{10}}=0$. And $\theta=\tfrac{\sqrt{10}}3=\theta_0(6)$, as §6 computes and the screen confirms. Every quantity in the proof is a ratio of positive integers at $n=6$ and none of them is a $0/0$.

**A correction to the brief's own framing of $n=6$.** The brief calls $n=6$ "the smallest even case where $\mathcal W_n\ne0$ and $\tfrac{n^2}4$ is an integer." Both halves fail to isolate $n=6$: $\tfrac{n^2}4$ is an integer for *every* even $n$, and $\mathcal W_4\ne0$, it is the $10$-dimensional space $\mathcal S^2_0(\Lambda^+)\oplus\mathcal S^2_0(\Lambda^-)$, containing $W_{\mathbb{CP}^2}$, which the brief itself cites two lines earlier. The smallest even case carrying the hypothesis non-vacuously is $n=4$. This does not touch the lemma.

**$n=4$, the kernel claim is right and the sentence around it is wrong.** The escape clause is correct: $\mathbb{CP}^2$ with the Fubini–Study metric is self-dual, so $W^-=0$ and $\Lambda^-\subseteq\ker W$, while $W^+$ has eigenvalues in ratio $(2,-1,-1)$; at unit norm the spectrum is $\{\tfrac{\sqrt6}3,\,0\ (\text{mult }3),\,-\tfrac{\sqrt6}6\ (\text{mult }2)\}$. **Three** eigenvalues, kernel of dimension **three**, so $W_{\mathbb{CP}^2}$ fails the two-eigenvalue hypothesis and is outside the lemma, exactly as claimed. Screened symbolically.

**But "at $n=4$ the conclusion would be false" is REFUTED AS STATED.** The lemma's conclusion at $n=4$ is: *any unit $W\in\mathcal W_4$ with exactly two eigenvalues and $E_{\max}$ conjugate to $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$ is $W_{S^2\times S^2}$ and has $\theta=\theta_0(4)$.* Every step of §§2–6 runs unchanged at $p=2$: $r=2$, $N=6$, $N-r=4$, spectrum $\tfrac2{\sqrt6}$ with multiplicity $2$ and $-\tfrac1{\sqrt6}$ with multiplicity $4$, and $P(W)=\tfrac{\sqrt{1\cdot3}}2=\tfrac{\sqrt3}2=\theta_0(4)$. **The conclusion is true at $n=4$.**

What *is* false at $n=4$ is a different statement, that the sphere product is the $\theta$-maximiser. I computed $\theta(W_{\mathbb{CP}^2})=\tfrac{\sqrt6}2=\sqrt{3/2}\approx1.2247$ from the same structure constants (in dimension four the mixed brackets vanish and $\langle W,W^\#\rangle=6(w_1w_2w_3+u_1u_2u_3)$ over the two self-dual triples, giving $12c^3$ against $\mathop{\mathrm{tr}}W^3=6c^3$ at $c=1/\sqrt6$, so $P=18c^3=\tfrac{\sqrt6}2$), against $\theta_0(4)=\tfrac{\sqrt3}2\approx0.8660$. So at $n=4$ a member of $\mathcal W_4$ beats $\theta_0(4)$ by a factor of $\sqrt2$. **Repair:** the sentence should read *at $n=4$ the sphere product is no longer the maximiser ($W_{\mathbb{CP}^2}$ has $\theta=\sqrt{3/2}>\theta_0(4)$) but the lemma is untouched, since $W_{\mathbb{CP}^2}$ has a three-dimensional kernel and so three eigenvalues.* As written, the block says the lemma fails at $n=4$, which would be a false restriction on its own scope.

**Non-vacuity, at every even $n\ge4$.** The hypotheses are satisfiable: $W_{S^p\times S^p}$ at unit norm satisfies all of them, and it lies in $\mathcal W_n$ because a Weyl tensor is totally trace-free and satisfies first Bianchi. So the lemma is not vacuously true at any admissible $n$.

## 9. Attack 10, what would break it, and what I did to look

**The breaker.** A unit $W\in\mathcal W_n$ with exactly two eigenvalues and $E_{\max}$ $SO(n)$-conjugate to $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ that is *not* conjugate to $W_{S^{n/2}\times S^{n/2}}$. **There is none, and the proof shows why in three lines:** the hypotheses cut out a single point. After conjugation, the two-eigenvalue structure confines $W$ to the plane $\mathop{\mathrm{span}}(\Pi_{\mathfrak h},\mathrm{Id})$, tracelessness cuts that plane to a line, the norm cuts the line to two points, and $E_{\max}=\mathfrak h$ selects one of them. No room is left for a witness.

**What I did to look, given the analysis-only rule.** I ran no search, sweep, census or falsifier hunt. Instead I looked for the *hypothesis that could be weakened until a witness appears*, which is the analytic version of the same question, and found exactly one candidate.

**The candidate: replacing conjugacy by dimension.** If "$E_{\max}$ conjugate to $\mathfrak h$" were weakened to "$\dim E_{\max}=\tfrac{n(n-2)}4$", the argument as written would collapse, $\Pi_{\mathfrak h}$ would become $\Pi_U$ for an arbitrary $r$-dimensional $U\subset\Lambda^2$, and every step through §5 would still go through, giving a whole Grassmannian of traceless two-eigenvalue operators. **The only thing that could rule those out is first Bianchi**, which the block never uses. So the unused hypothesis of §2 is precisely the one that would have to be switched on to weaken the conjugacy clause, and the block's redundancy claim about it is a statement about *this* proof rather than about the lemma's boundary. I checked the weakened form at $n=4$ by hand and it happens to survive there: $\mathcal W_4=\mathcal S^2_0(\Lambda^+)\oplus\mathcal S^2_0(\Lambda^-)$ forces $W$ block-diagonal with each block trace-free, a two-element spectrum with $\lambda_{\max}$ of multiplicity $2$ forces both blocks into the shape $(a,b,b)$ with $a=-2b$, and $\mathop{\mathrm{span}}(\omega^+,\omega^-)$ for unit $\omega^\pm\in\Lambda^\pm$ is always some $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$. Whether that persists at $n\ge6$ is open and would need a genuine argument; I record it as a question, not a finding.

**Second candidate, discharged.** Dropping "exactly two eigenvalues" to "$E_{\max}\cong\mathfrak h$" alone admits $W_{\mathbb{CP}^2}$-like witnesses with a kernel and breaks the conclusion immediately, which is the content of the $n=4$ remark, and why the two-eigenvalue clause is load-bearing rather than cosmetic.

## 10. What the record should change

1. **Rewrite the $n=4$ remark** (§8). As written it says the lemma's conclusion fails at $n=4$; the conclusion holds there. What fails is the extremality of the sphere product, and the number is $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}>\sqrt3/2=\theta_0(4)$.
2. **Record that first Bianchi is unused** (§2, §9), and that this is the hypothesis a dimension-only version of the grading clause would have to consume.
3. **Record that Ricci-flatness is used only at the strength of scalar-flatness** (§2), and that the conclusion returns full Ricci-flatness and Bianchi as output.
4. **Drop $\lambda_{\max}>0>\lambda_{\min}$ from the hypotheses** (§4); it follows from tracelessness, $\lVert W\rVert=1$ and the two-element spectrum.
5. **Attach the premises to the ratio-equals-tracelessness claim** (§7): the equivalence holds on the two-eigenvalue stratum with $\dim E_{\max}=r$, and is false without them.
6. **Say that the sign is fixed by $E_{\max}=\mathfrak h$**, not by $\lambda_{\max}>0$ alone (§5), both unit multiples have a positive top eigenvalue.
7. **Change the odd-$n$ reason** from $\tfrac{n^2}4\notin\mathbb Z$ to the direct $n/2\notin\mathbb Z$ (§8).
