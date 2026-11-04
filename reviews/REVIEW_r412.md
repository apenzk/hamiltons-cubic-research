# Reviewer r412, Gate 2 on "The correction Route 1 owed, in closed form: $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$"

*Target: [ATTEMPTS.md](../ATTEMPTS.md) §"The correction Route 1 owed, in closed form" (lines 3887–3905). Route 1 of the 2026-09-03 step 8 sweep, [L16](../plan.md)(a). **Analysis only**, no run was made; every constant below is derived by hand and cross-checked against the record's own definitions read as text.*

## Verdict in one line

**The boxed identity is TRUE and I confirm it by an independent component derivation, but the section's argument for it is a non-sequitur, and the result is not new: three files on the record already carry it in the $\mathcal A$ normalisation.**

| # | Claim | Verdict |
| --- | --- | --- |
| C1 | $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$ for every symmetric $R$ | **CONFIRMED**, independently derived below |
| C2 | $T=2(\#I)$, hence $c_4=2$ | **CONCLUSION CONFIRMED, ARGUMENT REFUTED**, the scalar is read off the one summand where the identification was never checked. Repair supplied |
| C3 | $\Lambda^4$ is irreducible, so $\#I$ acts by one scalar | **CORRECTED**, true under $O(n)$, **false under $SO(8)$**; the cited [Lemma L79](../findings/isotropy-cap.md) claims only $SO(m)$-equivariance, so the chain has a hole at $n=8$ |
| C4 | Polarisation $(A+B)^\#=A^\#+2A\#B+B^\#$; no normalisation factor breaks it | **CONFIRMED**, and it is Böhm–Wilking's own proof line, not a new step |
| C5 | $\mathrm{Ric}$ annihilates $\Lambda^4$, so $\mathrm{Ric}(R_B)=\mathrm{Ric}(R)$ | **CONFIRMED** |
| C6 | $H=2\big(\lvert W\rvert+\lvert W\rvert\#I-3\,\mathrm{Alt}(\lvert W\rvert)\big)$ | **CONFIRMED**, the factor $2$ is the $\mathrm{Ric}^*$ convention, verified by computing the adjoint |
| C7 | "$\mathrm{Alt}$" beside $\mathop{\mathrm{tr}}D=6\lVert\mathrm{Alt}\rVert^2$ | **TRAP**, $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$, so $\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=4\delta^2$, not $\delta^2$ |
| C8 | "nothing in [findings/](../findings/) carries $\mathrm{Ric}(R)\wedge\mathrm{id}-(R+R\#I)$" | **REFUTED**, [isotropy-cap.md](../findings/isotropy-cap.md) L79, [stratum-two-negative.md](../findings/stratum-two-negative.md), [results.md](../results.md) |
| C9 | "the grant is a $\#$-calculus statement plus one term **linear in the defect**" | **OVERSTATED**, the term is $\langle X_{\mathrm{inv}},\mathrm{Alt}(\lvert W\rvert)\rangle$, bilinear, with $X_{\mathrm{inv}}$ uncontrolled by $\delta$ |

## C1, the identity, derived cold and independently

I fixed the convention **before** reading the section, from the record's own code rather than its prose: [sharp4](../scripts/lib/review_r10_defectmax_independent.py) implements $(R^\#)_{ijkl}=\sum_{pq}R_{ipkq}R_{jplq}-R_{iplq}R_{jpkq}$, "calibrated so $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ exactly", and [alt_mop](../scripts/lib/review_r10_defectmax_independent.py) is the cyclic **average** over the last three slots. Polarising the first gives $(R\#S)_{ijkl}=\tfrac12\sum_{pq}\big[R_{ipkq}S_{jplq}-R_{iplq}S_{jpkq}+R_{jplq}S_{ipkq}-R_{jpkq}S_{iplq}\big]$.

Setting $S=I$ with $I_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ and $\mathrm{Ric}_{ik}=\sum_pR_{ipkp}$:

$$(R\#I)_{ijkl}=\tfrac12\big[\mathrm{Ric}_{ik}\delta_{jl}+\mathrm{Ric}_{jl}\delta_{ik}-\mathrm{Ric}_{il}\delta_{jk}-\mathrm{Ric}_{jk}\delta_{il}\big]+\tfrac12\big[X+\sigma X\big],\qquad X=R_{iljk}+R_{iklj},$$

$\sigma$ the involution $(i\leftrightarrow j,\ k\leftrightarrow l)$, which preserves the symmetry class. **This is the only place first Bianchi enters**: $R_{ijkl}+R_{iklj}+R_{iljk}=0$ collapses $X=-R_{ijkl}$. For general $R$, with $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ (the record's normalisation, and $\mathrm{Alt}$ is the orthogonal projection onto $\Lambda^4$), one gets $X=3\,\mathrm{Alt}(R)-R$ and $\sigma X=X$, hence

$$\boxed{\ R+R\#I=\mathrm{Ric}(R)\wedge\mathrm{id}+3\,\mathrm{Alt}(R)\ }$$

which is the section's identity. **Two calibration checks on my own component formula, both passed exactly:** $I\#I=(n-2)I$ by direct expansion, and $W\#I=-W$ since $\mathrm{Ric}(W)=\mathrm{Alt}(W)=0$. The wedge convention is thereby pinned to the halved one, $(A\wedge\mathrm{id})_{ijkl}=\tfrac12(A_{ik}\delta_{jl}+A_{jl}\delta_{ik}-A_{il}\delta_{jk}-A_{jk}\delta_{il})$, which is the convention Böhm–Wilking's Lemma 2.1 needs to return $(n-1)I$ at $R=I$.

**Restricting to $\Lambda^4$ gives $\#I=+2$ there**, since $\mathrm{Ric}$ vanishes on $\Lambda^4$ and $\mathrm{Alt}$ is the identity: $R+R\#I=3R$.

## C2, the identification $T=2(\#I)$: right answer, broken argument

The section's chain is: $T$'s eigenvalues match $2(\#I)$ on $\langle I\rangle$, $\langle\mathrm{Ric}_0\rangle$ and $\langle W\rangle$, "checked on all three components Lemma 2.1 supplies", therefore $T=2(\#I)$, therefore $c_4=2$ from $T$'s fourth eigenvalue.

**That is a non-sequitur.** $T$ and $2(\#I)$ are two equivariant self-adjoint operators on a multiplicity-free space; each acts by a scalar on each of the four summands, and agreement on three summands places **no** constraint on the fourth. The section reads the unknown scalar off an operator identity that was verified only on the complement of the summand where the unknown lives. Since $\Lambda^4\cap S^2_B=0$, Lemma 2.1 can never supply that datum, which is exactly why the correction was owed in the first place.

**The repair, three lines, and it needs no eigenvalue table.** From the invariant form the [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) already transcribe, $R\#S=\mathrm{ad}\circ(R\wedge S)\circ\mathrm{ad}^*$ with $\mathrm{ad}^*(h)=\tfrac12\sum_{\alpha\beta}\langle h,[b_\alpha,b_\beta]\rangle\,b_\alpha\wedge b_\beta$. Ad-invariance gives $\sum_\beta\langle h,[b_\alpha,b_\beta]\rangle b_\beta=-[b_\alpha,h]$, and the two terms of $(R\wedge I)(u\wedge v)=\tfrac12(Ru\wedge v+u\wedge Rv)$ coincide after relabelling, so

$$(R\#I)(h)=-\tfrac12\sum_\alpha\mathrm{ad}(Rb_\alpha)\,\mathrm{ad}(b_\alpha)h,\qquad\text{i.e.}\qquad 2(R\#I)=-\sum_{g,h}R_{gh}\,\mathrm{ad}(\varphi_g)\mathrm{ad}(\varphi_h)=-\mathcal A(R),$$

$\mathcal A$ being **precisely** the operator of [Lemma L79](../findings/isotropy-cap.md). Its table gives $\mathcal A=-4$ on $\Lambda^4$, hence $\#I=+2$, hence $c_4=2$, with no appeal to $T$ at all. The identity also self-checks against L79's other three rows: $\mathcal A=-2(m-2)$ on $\mathbb R\cdot\mathrm{Id}$ reproduces $I\#I=(n-2)I$, $\mathcal A=+2$ on $\mathrm{Weyl}$ reproduces $W\#I=-W$, and $\mathcal A=-(m-4)$ reproduces $\tfrac{n-4}2$ on $\mathrm{Ric}_0$.

**So $T=2(\#I)$ is confirmed as a conclusion**, by the independent route of C1 and by $\mathcal A=-2(\#I)$ together with the record's own $\mathcal A=-T$ reading. What the section may not do is derive $c_4$ from it.

**One remark that removes any residual doubt about the constant $3$.** Apply $\mathrm{Alt}$ to both sides of the boxed identity. The left side lies in $S^2_B$, so $\mathrm{Alt}=0$; the right gives $\mathrm{Alt}(R\#I)-(c-1)\mathrm{Alt}(R)$, and $\#I$ preserves $\Lambda^4$ by equivariance. Hence $c-1=c_4$ identically: **the constant $3$ carries no information beyond $c_4=2$**, and a successor cannot check it independently of the scalar.

## C3, $\Lambda^4$ irreducible: true under $O(n)$, false under $SO(8)$

$\Lambda^4\mathbb R^n$ is $O(n)$-irreducible for every $n\ge4$ (at $n=4$ it is the one-dimensional determinant representation, distinct from the trivial one). Under $SO(n)$ it is irreducible **except at $n=8$**, where the Hodge star splits it as $\Lambda^4_+\oplus\Lambda^4_-$, two inequivalent $35$-dimensional $SO(8)$-representations. The same failure hits $\mathrm{Weyl}_4=\mathcal W_+\oplus\mathcal W_-$ under $SO(4)$.

This matters because [Lemma L79](../findings/isotropy-cap.md) states its Schur step as "$\mathcal A$ is linear and **$SO(m)$-equivariant**, so Schur makes it a scalar on each summand". At $m=8$ that hypothesis licenses two independent scalars on $\Lambda^4$, and at $m=4$ two on $\mathrm{Weyl}$. **The lemma's own justification is therefore incomplete at exactly two dimensions**, one of which ($n=8$) the programme uses as a test dimension.

The repair is immediate and costs nothing: $\mathcal A$, $\#$ and $I$ are all defined without reference to an orientation, so $\mathcal A$ is $O(m)$-equivariant, the four summands are $O(m)$-irreducible and pairwise inequivalent, and Schur delivers four scalars. Equivalently, conjugation by an orientation-reversing element swaps $\Lambda^4_\pm$ and forces equal scalars. The transcribed [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) get this right (they say $O(n)$-equivariant throughout) so the defect is the record's, not the source's. **And the C1 derivation moots the question entirely**: it computes the scalar on $\Lambda^4$ without invoking Schur.

## C4, polarisation survives, and it is not the section's own step

The $\tfrac12$ in the notes' display sits **inside** the definition of the bilinear map $\#$, and Böhm–Wilking set $R^\#:=R\#R$ with $\#$ symmetric and bilinear on all of $S^2(\mathfrak{so}(n))$. So $(A\pm B)^\#=A^\#\pm2A\#B+B^\#$ holds with no correction, and (separately important), $\#$ is defined on the **full** space, so applying it to $R\pm I\notin S^2_B$ is legitimate. Both are silently used hypotheses worth naming, since Lemma 2.1 itself is stated only on $S^2_B$.

The section presents "Bianchi enters only in identifying the result" as its own finding. **It is Böhm–Wilking's own proof, transcribed verbatim in the record**: the notes quote "One can write $R+R\#I=\tfrac14[(R+I)^2+(R+I)^\#-(R-I)^2-(R-I)^\#]$" as the first line of the published proof. The observation that this line is Bianchi-free is a correct reading of a text already on file, not a derivation.

## C5, C6, the two normalisations, checked

$\mathrm{Ric}$ annihilates $\Lambda^4$ because every contraction of a totally antisymmetric tensor on two of its slots vanishes. **CONFIRMED.**

$H=\mathrm{Ric}^*(\mathrm{Ric}(\lvert W\rvert))$. I verified by hand that [ric_star](../scripts/lib/review_r13_independent.py), $h\mapsto h_{ik}\delta_{jl}+h_{jl}\delta_{ik}-h_{il}\delta_{jk}-h_{jk}\delta_{il}$, is the adjoint of $\mathrm{Ric}$ for $\langle A,B\rangle_{\mathrm{op}}=\tfrac14\sum A_{ijkl}B_{ijkl}$, all four terms contribute $\tfrac14\langle\mathrm{Ric}(M),h\rangle$. Hence $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$ in the halved wedge convention, and the leading $2$ in the section's $H$ formula is forced by that convention rather than chosen. **CONFIRMED.** As a by-product, $\mathrm{Ric}^*(h)$ acts on a $2$-form as $\omega\mapsto h\omega+\omega h$, so $H$ is literally L79's $\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric}$, which is what makes C8 below unavoidable.

## C7, $\mathrm{Alt}(\lvert W\rvert)$ is not the record's $\delta$-object

With $W=W_+-W_-$, both $\succeq0$, and $\lvert W\rvert=W+2W_-$: $\mathrm{Alt}(W)=0$ forces $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, the record verifies this at [review_r10_defectmax_independent.py](../scripts/lib/review_r10_defectmax_independent.py), so

$$\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-),\qquad \lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=4\delta^2,\qquad \delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2 .$$

The record's own [review_r13_independent.py](../scripts/lib/review_r13_independent.py) header states it in this form: "$\delta^2=\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2_{\mathrm{op}}/4$".

The section's $H$ formula is **correct**, it is an identity in $R$ applied at $R=\lvert W\rvert$, and $\delta$ never appears in it. The trap is its closing sentence, which sets the constant $3$ "beside $\mathop{\mathrm{tr}}D=6\lVert\mathrm{Alt}\rVert^2$". That pairing is coherent only if $\lVert\mathrm{Alt}\rVert$ there means $\lVert\mathrm{Alt}(\lvert W\rvert)\rVert_{\mathrm{op}}=2\delta$, giving $\mathop{\mathrm{tr}}D=24\delta^2$. **A successor who reads it as $\delta$ is off by a factor of $4$** in precisely the cancellation the sentence directs them to look for. The section should say which $\mathrm{Alt}$ it means.

## C8, the novelty claim is refuted

The section screens itself and concludes "nothing in [findings/](../findings/) carries $\mathrm{Ric}(R)\wedge\mathrm{id}-(R+R\#I)$". That is true of the **expression** and false of the **content**. Three files carry the same sentence:

> "First Bianchi is the load-bearing hypothesis (it alone gives $\mathcal A(R)=2R-(\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric})$) while Ricci-flatness only deletes the correction, and fails on its own because $\Lambda^4$ is itself Ricci-flat and carries eigenvalue $-4$ rather than $+2$."

[findings/isotropy-cap.md](../findings/isotropy-cap.md), [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), [results.md](../results.md).

Substituting $\mathcal A=-2(\#I)$ and $\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric}=\mathrm{Ric}^*(\mathrm{Ric})=2(\mathrm{Ric}\wedge\mathrm{id})$, that sentence together with L79's table is the general statement

$$\mathcal A(R)=2R-\big(\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric}\big)-6\,\mathrm{Alt}(R),$$

which on $\Lambda^4$ returns $2R-0-6R=-4R$, reproducing the table row. **That is the boxed identity, doubled and sign-flipped.** So the mechanism, the failure mode, the affected summand and the numerical size of the failure were all already on the record, in the same file the section cites for its scalar.

This is the failure mode [findings/INDEX.md](../findings/INDEX.md) itself warns about at instruction 3, "Three refutations on record came from points already in the file, all missed because the search used the vocabulary of the construction rather than the value." The section searched for its own expression and for $\#I$, and did not search for the operator whose eigenvalue table it was quoting.

**What is genuinely new is narrower, and should be recorded as such**: the closed form in the $\#$ normalisation, the pinning of the constant to $3$ in the record's $\mathrm{Alt}$ convention, and the observation that $\mathcal A$ and $T$ are the same operator up to sign, which the record holds in one file, in two places, without noticing.

## C9, the payoff sentence is overstated

"$\langle X_{\mathrm{inv}},H\rangle\ge0$ is a $\#$-calculus statement plus one term linear in the defect." The term is $-6\langle X_{\mathrm{inv}},\mathrm{Alt}(\lvert W\rvert)\rangle$, which is **bilinear** in the pair, and nothing on the record bounds $\lVert X_{\mathrm{inv}}\rVert$ in terms of $\delta$ or of anything that vanishes with it. Calling it "linear in the defect" invites a successor to treat it as $O(\delta)$, which is unsupported. The section is otherwise honest that it "rewrites $H$ exactly, bounding nothing".

## Silently used hypotheses, named

1. $\#$ is bilinear and symmetric on the **whole** of $S^2(\mathfrak{so}(n))$, with $R^\#=R\#R$, needed because $R\pm I\notin S^2_B$ as soon as $\mathrm{Alt}(R)\neq0$. True in Böhm–Wilking; not stated in the section.
2. Equivariance under the **full** $O(n)$, not $SO(n)$, without it the $\Lambda^4$ scalar is not single at $n=8$. See C3.
3. $\Lambda^4$ sits in $\mathrm{Sym}^2(\Lambda^2)$ with multiplicity one, so $\mathrm{Alt}$ is *the* orthogonal projection and $R=R_B+\mathrm{Alt}(R)$ is orthogonal.
4. $\mathrm{Alt}$ is the cyclic **average** ($\div3$), as [alt_mop](../scripts/lib/review_r10_defectmax_independent.py) has it. With the unaveraged cyclic sum the constant is $1$, not $3$.
5. The halved wedge, $(A\wedge\mathrm{id})=\tfrac12(A_{ik}\delta_{jl}+\cdots)$, pinned by $\mathrm{Ric}(I)\wedge\mathrm{id}=(n-1)I$; and $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$, which is where $H$'s factor $2$ comes from.
6. $n\ge4$. Below that $\Lambda^4=0$ and the correction is empty.

## What the section should become

Keep the boxed identity, it is right. Replace its justification with the C1 component derivation or the C2 three-line $\mathcal A=-2(\#I)$ argument, either of which proves $c_4=2$ where the current argument assumes it. Add the $\mathrm{Alt}$-of-both-sides remark so a reader knows $3$ and $c_4=2$ are one fact. Restate the novelty as "the closed form and the coefficient, joining [Lemma L79](../findings/isotropy-cap.md) to Böhm–Wilking's Lemma 2.1, the two being the same operator in two normalisations", and add to [Lemma L79](../findings/isotropy-cap.md) the general-$R$ form $\mathcal A(R)=2R-\mathrm{Ric}^*(\mathrm{Ric}\,R)-6\,\mathrm{Alt}(R)$ together with the $SO(m)\to O(m)$ repair of its Schur step. Say which $\mathrm{Alt}$ the closing sentence means.
