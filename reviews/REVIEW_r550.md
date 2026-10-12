# REVIEW r550, Lemma L34

**Target:** Lemma L34, "full support with two negative eigenvalues, at $m=6$ and $m=8$", in [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) at the `#### Lemma L34` heading (line 361) down to the next heading.

**Reviewer:** r550, cold, adversarial, analysis-only footing. Anchors fixed from [findings/conventions.md](../findings/conventions.md): half-trace pairing $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, $\lVert\varphi_{ab}\rVert^2=1$, $\operatorname{tr}W^\#=-1$, $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, $\theta=P(W)/\lVert W\rVert^3$ with $P(W)=\sum_\alpha\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$, $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$. *That cubic formula is not taken on trust: $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ against the Killing marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ fixes $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\beta\gamma}T_{\alpha\beta\gamma}\lambda_\beta\lambda_\gamma$, which is the formula.*

**VERDICT: CONFIRMED**, the statement is true at both dimensions, every recorded number reproduces, and I derived the $m=8$ case entirely by hand. Two steps of the written proof are asserted rather than argued; both are fillable and I supply them below. Five separate defects are recorded, one of which (the label), is a violation of the record's own literal-label convention.

## 1. What the block claims

> **Statement.** For $m=6$ and $m=8$ there is a $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues and $\dim U=m$, where $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$.
>
> **Construction.** Pad two copies of $W_4(q,r)$ onto 4-planes of $\mathbb R^m$ and add. Both defining conditions are linear, so the sum is a $\mathrm{Weyl}_m$ element whatever the planes do; each summand contributes exactly one negative eigenvalue, and the support is the union of the planes. Orthogonal planes at $m=8$ give spectrum $\{-1/\sqrt3\ (\times2),\ 1/(2\sqrt3)\ (\times4)\}$ and $\theta=-\sqrt3/2$; planes meeting in a 2-plane at $m=6$ give $(-3,-1,1,1,1,1)/\sqrt{14}$ and $\theta=-1.030865$. $\square$

## 2. The $m=8$ witness, derived cold

$W_4(q,r)=-(q+r)\,w_1\otimes w_1+q\,w_2\otimes w_2+r\,w_3\otimes w_3$ with $w_i$ the unit self-dual $2$-forms of the $4$-plane, quoted from [Lemma L33](../findings/stratum-two-negative.md)'s block. Its $\Lambda^-$ block is zero, so its $\Lambda^2\mathbb R^4$ spectrum is $\{-(q+r),q,r,0,0,0\}$, **one** negative eigenvalue, which is what the construction needs. Take $q=r$.

- **Padding is genuinely $\mathrm{Weyl}$.** With all four indices in the plane it is the dimension-$4$ Bianchi identity and the dimension-$4$ Ricci trace; with any index outside, every term is zero. So each summand lies in $\mathrm{Weyl}_m$, and $\mathrm{Weyl}_m$ being a linear subspace of $\mathrm{Sym}^2(\Lambda^2)$, so does the sum. The block's "both defining conditions are linear" is right.
- **Spectrum.** Orthogonal planes make $\Lambda^2P_1\perp\Lambda^2P_2$, so the spectra union with multiplicity: $\{-2q\ (\times2),\ q\ (\times4)\}$. Unit norm is $2(4q^2)+4q^2=12q^2=1$, giving $q=1/(2\sqrt3)$ and $-2q=-1/\sqrt3$. **Matches, and trace is $-2/\sqrt3+4/(2\sqrt3)=0$.**
- **$\theta$, by hand.** Orthogonal supports kill every cross bracket, so $P$ is additive. Within one copy the only live triple is $(w_1,w_2,w_3)$: $J_i=\sqrt2\,w_i$ are the quaternionic complex structures, $[J_1,J_2]=2J_3$, so $[w_1,w_2]=\sqrt2\,w_3$ and $T_{123}=2$, the pair cap, attained, consistent with [Lemma L31](../findings/stratum-two-negative.md) since each $w_i$ has rank $4$ and all singular values $1/\sqrt2$. Then $P(\text{one copy})=(-8q^3+2q^3)+3\cdot2\cdot(-2q^3)=-18q^3$, and at $q=1/(2\sqrt3)$ that is $-\sqrt3/4$. Two copies: $\theta=-\sqrt3/2$. **Matches exactly.**
- **Cross-check on the same algebra.** At unit norm a single copy has $q=1/\sqrt6$ and $\theta=-18q^3=-\sqrt{3/2}$, the padded base-case family, which is what [isotropy-cap.md](../findings/isotropy-cap.md) calls "the B0 base-case family at $\theta=+\sqrt{3/2}$". Its $\theta_{\rm sum}=\theta_A/\sqrt2$ rule then also returns $-\sqrt3/2$.
- **$\dim U=8$.** $\operatorname{im}\omega_1=P_1$, $\operatorname{im}\omega_2=P_2$, orthogonal, so $U=\mathbb R^8$ for any basis of the negative eigenplane.

## 3. The four properties L33's repair needs of this witness

L33's repair reads *"[Lemma L34] supplies a second witness at $m=8$"* against the distinct-value reading. Taking the four in turn:

| property | holds? |
|---|---|
| one **distinct** negative eigenvalue | **yes**, both negatives are $-1/\sqrt3$; the eigenvalue has multiplicity $2$ |
| generically nondegenerate | **yes**, $a\omega_1+b\omega_2$ with $ab\ne0$ has rank $8$ |
| no $4$-plane complex structure | **only generically**, see below |
| $W\ne0$ | **yes** |

**The third is the one that is weaker than it reads.** Each $\omega_i$ is a *unit self-dual $2$-form on a $4$-plane*, i.e. rank $4$ with all singular values $1/\sqrt2$, that is, $\omega_i=J_i/\sqrt2$ for a complex structure $J_i$ on $P_i$. So the negative eigenplane contains **exactly two lines, $\mathbb R\omega_1$ and $\mathbb R\omega_2$, each of which *is* precisely L33's stated exception**, and every other line in it has rank $8$ and is not. The witness therefore refutes the distinct-value reading only under the **existential** quantification of L33's "that eigenvector"; under the universal reading it is not a witness at all.

**This does not damage L33's repair**, for two reasons, and both should be on the record:

1. L33's *primary* witness ($W^+=W^-=\operatorname{diag}(2,-1,-1)$ in $\mathrm{Weyl}_4$), has the same feature. Writing $w^\pm$ for the first self-dual and anti-self-dual basis forms, $a\,w^++b\,w^-=\big((a+b)\varphi_{12}+(a-b)\varphi_{34}\big)/\sqrt2$, which is a complex-structure multiple exactly when $ab=0$. So the exceptional lines sit in *that* eigenplane too. The quantifier ambiguity is L33's, not L34's, and it is orthogonal to the multiplicity ambiguity L33's callout does disambiguate.
2. L34 is called *"a second witness"*. L33's repair stands on the $\mathrm{Weyl}_4$ witness; L34 is corroborative. **The weight the brief says L34 now carries is real but not load-bearing.**

**And the witnesses are not instances of L33's exception in disguise.** Each is a *sum of two* exception elements on distinct $4$-planes; the sum has $8$-dimensional (resp. $6$-dimensional) support and two negative eigenvalues counted with multiplicity, so L33's hypothesis (one eigenvalue *with multiplicity* on one side), never applies to it. No circularity, and no collision with the exception's completeness.

## 4. Two steps of the proof are asserted, not argued, both fillable, both filled

**(a) "the support is the union of the planes".** The statement's "support" is $\dim U$ with $U=\operatorname{im}v_{N-1}+\operatorname{im}v_N$, an object built from the **negative** eigenvectors alone. The union of the padding planes is a different object, and nothing in the block connects them. At $m=8$ they happen to coincide visibly; at $m=6$ the summands do not commute, the negative eigenvectors are not the padded $w_1$'s, and their images could a priori be smaller.

*The missing step is Ricci-flatness, and the file already carries it 96 lines above:* $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ makes the positive-side and negative-side positive-semidefinite sums the same matrix, so $U=\operatorname{im}\big(\sum_{\lambda>0}\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha\big)=\sum_\alpha\operatorname{im}v_\alpha=S(W)$, the honest support. *This is exactly the identity the file uses at line 265 under "Consequence, and it is stronger than a descent"; L34 does not reach for it.*

*And then $S(W)=P_1+P_2$ analytically.* For $u\in P_1$ nonzero pick $x\in P_1\cap P_2^\perp$ with $x\perp u$ (available at $m=6$, where $\dim(P_1\cap P_2^\perp)=2$). Then $\xi=u\wedge x\in\Lambda^2P_1$ is orthogonal to $\Lambda^2P_2$, so $B\xi=0$, while $A\xi=W^+\big(\pi^+(u\wedge x)\big)\ne0$ because $W^+$ is invertible on $\Lambda^+$; and $A\xi$ is a nonzero self-dual form on $P_1$, hence nondegenerate there, so $(A\xi)u\ne0$ and $u\notin S(W)^\perp$. Symmetrically for $P_2$. Hence $\dim U=6$.

**(b) "each summand contributes exactly one negative eigenvalue".** With overlapping planes the summands do not commute and eigenvalues do not add. What is true is the subadditivity of the negative index, $n_-(A+B)\le n_-(A)+n_-(B)=2$, via $A+B=(A_++B_+)-(A_-+B_-)$ with $\operatorname{rank}(A_-+B_-)\le2$. **Exactly two** is asserted from a reported spectrum.

*The missing step:* $W\ne0$ and $\operatorname{tr}W=0$ give $n_-\ge1$; $n_-=1$ would put L33 in force, so either $W=0$ or the negative eigenvector is a $4$-plane complex-structure multiple, whose image is a $4$-plane, contradicting $\dim U=6$ from (a). Hence $n_-=2$. *The dependency runs L34 $\to$ L33 and not back, since L33's proof never uses L34.*

**With (a) and (b) in place the statement is proved analytically at both dimensions**, with the $m=8$ case needing neither.

## 5. Screen of the recorded numbers

*Reported as a screen, seconds of compute on objects I constructed for the purpose, never as evidence for a positive claim. The analytic derivations above are what carry the verdict.*

Building $W$ in the orthonormal $\{\varphi_{ab}\}$ basis with $P_1=\langle e_1..e_4\rangle$, $P_2=\langle e_3..e_6\rangle$ (resp. $\langle e_5..e_8\rangle$) and equal self-dual copies:

| $m$ | nonzero spectrum | $n_-$ (mult / distinct) | $\dim U$ | Bianchi | Ricci | $\theta$ | $\lVert[v_{N-1},v_N]\rVert^2$ |
|---|---|---|---|---|---|---|---|
| $6$ | $(-3,-1,1,1,1,1)/\sqrt{14}$ | $2$ / $2$ | $6$ | $0$ | $0$ | $-1.030865$ | $0$ |
| $8$ | $\{-1/\sqrt3^{\times2},\,1/(2\sqrt3)^{\times4}\}$ | $2$ / $1$ | $8$ | $0$ | $0$ | $-0.866025$ | $0$ |

Every recorded figure reproduces to the digits given. Three consequences worth having on the record:

- **The $m=6$ witness has two *distinct* negative eigenvalues**, so it is the $m=8$ one alone that can serve L33's disambiguation, as L33's callout says.
- **At $m=6$ the less-negative eigenvector has rank $4$ with all singular values $1/\sqrt2$**, i.e. it too is a $4$-plane complex-structure multiple; the more-negative one has rank $6$.
- **Both witnesses sit at bracket $0$, deficit $\delta=2$** (the far end from the cap), **with trivial common kernel.** So they are consistent with [Lemma L30](../findings/stratum-two-negative.md), whose hypothesis they fail, and they are nowhere near the assembled table's $\delta=0$ row.

## 6. What it corrects, and whether the overreach survives anywhere

The motivation is right. B0's descent had been recorded as closing once *no* $\mathrm{Weyl}_m$ element with at most two negative eigenvalues has full support; the witnesses have exactly two and full support, so that statement is false at $m=6$ and $m=8$. The block's own account of *why* the recorded equivalence to the rank-3 question fails, at one positive eigenvalue Ricci-flatness pins $U=\operatorname{im}v_1$, at several it reads $\sum_{\lambda>0}\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=b\,yy^{\mathsf T}+c\,zz^{\mathsf T}$ and constrains no rank, **is correct as written**.

**Nothing downstream still leans on the overreaching form.** The one place that looks like it does is the assembled table's row *"$k\ge3$, $\delta=0$ | cap $\Rightarrow XY=-YX$, rank $4$, $\operatorname{im}X=\operatorname{im}Y$ $\Rightarrow \ker X=\ker Y$ of dimension $n-4$ $\Rightarrow$ **padding descent to $n=4$** | **proved**"*. That is a **different, conditional** descent, in force only at bracket saturation, which the witnesses are two full units of deficit away from; and the file at lines 265–271 has already replaced even that with the three-line PSD argument, calling the descent *"the earlier route ... the long way"*. The word "descent" carrying both the refuted unconditional statement and this surviving conditional one **inside one file** is the residual hazard, and it is worth one clause of disambiguation in the table row.

## 7. The label, against the dimensions, the block's most serious defect

[findings/INDEX-results.md](../findings/INDEX-results.md) states the convention in its own words:

> Labels are literal. **Lemma** is proven, Gate 1 and Gate 2 passed. **Observation** is verified numerically at the dimensions stated.

and its row for this result reads:

> | **34** | Lemma | **Gate 2: no verdict on the record.** full support with two negative eigenvalues, at $m=6$ and $m=8$ | [stratum-two-negative.md](stratum-two-negative.md) |

**So the block is labelled `Lemma` while the index that owns the numbering records that Gate 2 has never been run on it.** Neighbouring blocks in the same file carry their Gate 2 line explicitly, L31's *"Gate 2 passed, the repair supplied by the review"*, L33's *"Gate 2, r511 and r512 ... both CONFIRMED"*. L34's block carries none. The label is unearned as the record defines it.

**And as written the block is an Observation, not a Lemma.** Its $\square$ closes a paragraph whose two substantive claims are a reported spectrum and the decimal $\theta=-1.030865$; §4 above names the two steps that are asserted rather than derived. *The remedy is either label, the statement is genuinely provable, so completing it with §4(a) and §4(b) and running Gate 2 is the better one.*

**On the range.** The heading names $m=6$ and $m=8$ and the block claims nothing beyond them, correctly. Its own silence clause (*"two 4-planes span at most eight dimensions, so the construction is silent at $m\ge10$"*), is right, and adding a third orthogonal copy does not evade it, since a third copy adds a third negative eigenvalue. *What the block understates is the low end: two $4$-planes also span $\mathbb R^5$ and $\mathbb R^7$, so the construction plausibly reaches $m=5$ and $m=7$ as well; the block neither claims nor excludes them.*

## 8. The six citations

| # | site | what it takes |
|---|---|---|
| 1 | [stratum-two-negative.md:130](../findings/stratum-two-negative.md), L33's disambiguation callout | **the named $m=8$ witness**, as a "second witness"; anchor link resolves |
| 2 | [stratum-two-negative.md:440](../findings/stratum-two-negative.md) (L35's preamble | **the corrected form of B0's descent**), "the descent that used to reduce the general case to dimension four is refuted by Lemma L34" |
| 3 | [results.md:154](../results.md), landscape entry | **the general claim**, plus a value: "In general position they reach $\theta=+0.485$" |
| 4 | [results.md:448](../results.md) (mirrored block | **the general claim and the whole construction verbatim**), see §9 |
| 5 | [findings/LEDGER.md:600](../findings/LEDGER.md) | **the named $m=8$ witness**, attributed to r512, for L33's multiplicity ambiguity |
| 6 | [plan-verification.md:46](../plan-verification.md) | a bare unchecked row, `- [ ] **L34**`; no content taken |

*Outside the record proper, [reviews/ELIM-stratum.md:182](ELIM-stratum.md) endorses the block, "linearity of both defining conditions is the whole proof and it holds". That is the sentence §4 disputes: linearity gives Weyl membership and nothing else, and neither the support claim nor the exact count follows from it.*

## 9. The provenance line, the first in this file to survive

> *Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

- **First clause: TRUE**, and I checked it against git rather than the record. The block entered [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) at `a9e4b8c0`; at its parent `84cada75`, `git grep -l "Pad two copies of"` returns **`results.md` and nothing else**. This is the first of this file's provenance lines to hold, L33's and L31's both carry corrections saying theirs did not.
- **Second clause: FALSE.** [results.md:448](../results.md) still carries the statement **and the entire Construction paragraph**, byte-identical to the one in findings (512 characters, verified by string containment), followed by *"**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)"*, a pointer to the file it has just duplicated. **The duplicate the move existed to remove is still there**, which is the same defect L33's note records against itself. Either results.md keeps the statement alone, or the sentence must stop claiming it does.

## 10. Two further defects

**(a) A stale status, corrected by a passage 46 lines below it in its own file.** The block ends:

> **The consequence for B0 is that $\sup\theta\le\sqrt{3/2}$ on that stratum is now unproved rather than differently proved**, the descent was its proof.

[Lemma L35](../findings/stratum-two-negative.md), at line 435 of the same file, is *"at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$, unconditionally"*, and its own preamble says it exists because *"the descent having been refuted by the full-support witnesses recorded above"*. **So the stratum bound is proved, and the sentence has been true only between 2026-08-23 and the arrival of L35.** It needs one clause pointing forward.

**(b) A value conflict on the general-position maximum.** The block says $4$-planes in general position *"reach $\theta=+0.485408612$ at $m=6$ and $+0.115574271$ at $m=8$"*, and [results.md:154](../results.md) propagates it as *"In general position they reach $\theta=+0.485$"*. But [isotropy-cap.md:275](../findings/isotropy-cap.md) records, for the same construction, that *"random general-position draws reach $+0.6259$ at $m=6$ and $+0.2650$ at $m=7$"*. **$+0.6259>+0.485408612$**, so the word "reach" in L34 and in results.md reads as a family maximum that the record itself beats by $29\%$. *Nothing depends on the figure (every value is far below $\sqrt{3/2}$) but the landscape entry states the smaller number with no qualifier, and it is the one a reader outside these two files will take.*

## 11. Verdict

**CONFIRMED.** The statement of L34 is true at $m=6$ and $m=8$; the $m=8$ case I derived entirely by hand, including its spectrum, its norm, its trace, its $\theta=-\sqrt3/2$ and its $\dim U=8$; the $m=6$ case is provable by the two steps in §4 and every recorded figure reproduces on screening. The block's correction of B0's overreach is right, and no downstream consumer still leans on the overreaching form.

**What is owed, in priority order.**

1. **The label.** `Lemma` against an index row reading "Gate 2: no verdict on the record" violates the record's own literal-label convention. Complete the proof with §4(a) and §4(b) and run Gate 2, or relabel.
2. **The two asserted steps**, §4(a) and §4(b). The first is the more serious: "support" in the statement means $\dim U$, an object built from the negative eigenvectors, and identifying it with the union of the padding planes needs Ricci-flatness, an identity the same file uses 96 lines above.
3. **The provenance's second clause**, §9: results.md carries the whole construction verbatim, not the statement alone.
4. **The stale "now unproved"**, §10(a), superseded by L35 in the same file.
5. **The "reach $+0.485$" figure**, §10(b), against $+0.6259$ recorded elsewhere for the same family.
6. **One clause on L33's quantifier**, §3: the $m=8$ witness refutes the distinct-value reading only under the existential reading of "that eigenvector", since its eigenplane contains two lines that *are* L33's exception. The same is true of L33's own $\mathrm{Weyl}_4$ witness, so this is a note owed to L33, not a defect of L34.
