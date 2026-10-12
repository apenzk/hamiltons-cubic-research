# REVIEW r541, Lemma L72

**Target.** Lemma L72, "the rank-3 stratum is overdetermined, and its converse clause closes in three lines", in [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) at the `#### Lemma L72` heading (line 492), down to the next heading of any level.

**Reviewer.** r541, cold brief, adversarial. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts were run. Everything below is derived by hand.

**VERDICT: CONFIRMED**, the numbered statement is true, correctly proved, and realised. **Three claims in the same block are false and are listed as defects; two of them are material.**

## 1. The rows are right, and the normalisation is pinned by the record's own anchor

Criticality $Q(W)=\theta W$ with $Q=W^2+W^\#$ gives, in an eigenbasis, $(W^\#)_{\beta\beta}=\lambda_\beta(\theta-\lambda_\beta)$, and $(W^\#)_{\beta\beta}=\tfrac12\sum_{\gamma\delta}T_{\beta\gamma\delta}\lambda_\gamma\lambda_\delta$ with $T_{\beta\gamma\delta}=c_{\beta\gamma\delta}^2$. The factor is fixed by [conventions.md](../findings/conventions.md): $\tfrac12\sum_\gamma\lVert[v_\beta,v_\gamma]\rVert^2=\tfrac12\cdot2(n-2)=n-2$, reproducing $\mathrm{Id}^\#=(n-2)\mathrm{Id}$.

With spectrum $(\lambda_1,-a,-b,0,\dots)$ and $T$ vanishing on repeated indices, the three non-kernel rows are

- $\beta=1$: $\gamma,\delta\in\{N-1,N\}$, giving $Tab=\lambda_1(\theta-\lambda_1)$;
- $\beta=N-1$: $-T\lambda_1b=-a(\theta+a)$, i.e. (ii);
- $\beta=N$: (iii).

**All three reproduce exactly as printed.** The three non-kernel rows are the right three.

## 2. The block's route to $a=b$ is NOT the parent's, and the block's is the stronger of the two

The brief's derivation subtracts (iii) from (ii):
$$(a-b)\bigl(T\lambda_1+\theta+a+b\bigr)=0,$$
which is correct, but its second factor is killed only by a sign hypothesis on $\theta$. **The block does not do this.** Its preceding sentence "Three expressions for one number" multiplies (i) by $\lambda_1$, (ii) by $a$ and (iii) by $b$, so that all three read as $T\lambda_1ab$:
$$\lambda_1^2(\theta-\lambda_1)=a^2(\theta+a)=b^2(\theta+b).$$
The last equality factors as $(a-b)\bigl[\theta(a+b)+a^2+ab+b^2\bigr]=0$, which **is** the block's printed branch $\theta=-(a^2+ab+b^2)/(a+b)$. Its disposal checks: $\theta+a=-b^2/(a+b)$, so (ii) gives $T\lambda_1=-ab/(a+b)$ and, with $\lambda_1=a+b$, $T=-ab/\lambda_1^2<0$ against $T=c^2\ge0$. **Only $a,b>0$, $\lambda_1>0$ and tracelessness are used, no sign hypothesis on $\theta$ anywhere.**

Then $a=b$, $\lambda_1=2a$; (i) gives $Ta=2\theta-4a$ and (ii) gives $2Ta=\theta+a$, so $\theta=3a$ and $T=2$; $6a^2=1$ gives the spectrum $(2,-1,-1)/\sqrt6$ and $\theta=3/\sqrt6=\sqrt{3/2}$. **Confirmed, every step.**

**Answer to question 3: the block does not need $\theta>0$, and $\theta=3a>0$ is an output rather than a hypothesis.** The invariance worry does not arise: $Q(-W)=W^2-W^\#$, so $W\mapsto-W$ does not preserve criticality, and no $\theta<0$ critical point of this stratum survives the rows. **The brief's own derivation, by contrast, does need $\theta>0$, so the elision named in Defect C below costs a hypothesis to any reader who follows it literally.**

## 3. $T\ge0$ is a theorem here, not an assumption

$T=T_{1,N-1,N}=c_{1,N-1,N}^2$ with $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ real, the eigenbasis of a symmetric operator being real orthonormal. It is a square. The block names the reason (*"impossible for $T=c^2$"*), tersely but correctly, and [conventions.md](../findings/conventions.md) carries $T_{abc}=c_{abc}^2$ as a standing definition. **Available, and the block says so.**

## 4. The conclusion is realised, an independent anchor check that also recovers $\operatorname{tr}W^\#=-1$

At the solution, on the self-dual triple in $\mathfrak{so}(4)$: $T=2$ gives $W^\#=\bigl(2\lambda_2\lambda_3,\,2\lambda_1\lambda_3,\,2\lambda_1\lambda_2\bigr)=(1/3,-2/3,-2/3)$, so $\operatorname{tr}W^\#=-1$ **exactly**, the record's anchor, and
$$Q(W)=W^2+W^\#=(2/3+1/3,\;1/6-2/3,\;1/6-2/3)=(1,-\tfrac12,-\tfrac12)=\sqrt{3/2}\cdot(2,-1,-1)/\sqrt6 .$$
So $W_+(\mathbb{CP}^2)$, padded, is a genuine critical point attaining the lemma's conclusion. **The stratum is nonempty and the lemma is not vacuously true.** The cap $T=2$ is also attained: for the normalised quaternionic triple $[v_1,v_2]=\sqrt2\,v_3$, $\lVert[v_1,v_2]\rVert^2=2$, saturating the pair cap with all mass on $v_3$.

## 5. The kernel rows, a fourth family of equations is dropped, safely

**Question 5, answered.** For every kernel index $\beta$ the same diagonal identity gives a further equation, and it is not vacuous in general:
$$-\lambda_1\bigl(a\,T_{\beta,1,N-1}+b\,T_{\beta,1,N}\bigr)+ab\,T_{\beta,N-1,N}=0 .$$
There are also $\binom N2$ off-diagonal equations $(W^\#)_{\alpha\beta}=0$, likewise dropped. **Dropping them is sound**: L72 is a necessary-condition argument, so a subset of the criticality equations suffices, and extra equations could only shrink the solution set. At the solution they are all satisfied, because $T=2$ forces $[v_1,v_{N-1}]\parallel v_N$ and hence $T_{\beta,\cdot,\cdot}=0$ for kernel $\beta$.

**Defect A (imprecision).** The block writes *"the only bracket entry the rows see is $T:=T_{1,N-1,N}$"*, then narrows to *"the three non-kernel rows"*. Read over all $N$ diagonal rows the first clause is false. The intended reading is defensible; the sentence should say "the three non-kernel rows" in both halves.

## 6. "Overdetermined", the word is earned, in the framing the block states

**Question 4, answered.** The naive count is square, not overdetermined: unknowns $(a,b,T,\theta)$ with $\lambda_1=a+b$, against three rows plus the unit-norm normalisation, four and four, and the solution set is duly a point.

The block's own count is the right one and it says which quantity it is counting: *"the rows give $r$ equations against $\binom r3$ live entries, so $T$ is overdetermined at rank $3$"*. With the spectrum and $\theta$ held, $T$ satisfies $r$ linear equations in $\binom r3$ unknowns:

| $r$ | equations | live $T$-entries | consequence |
| --- | --- | --- | --- |
| 3 | 3 | 1 | 2 compatibility conditions on $(\lambda,\theta)$, exactly the 2 freedoms left after trace and norm, so the spectrum is pinned |
| 4 | 4 | 4 | square in $T$, no compatibility condition, spectrum not pinned |
| $\ge5$ | $r$ | $\binom r3$ | the diagonal rows alone pin nothing |

**The crossing is where the block puts it, and the word is earned.**

**Defect B (overclaim, minor).** *"free from rank $5$ on"* is a statement about the diagonal rows only. The off-diagonal criticality equations and the kernel rows of §5 still bind at every rank, so no freedom follows. The sentence should read "the diagonal rows alone pin nothing from rank 5 on".

## 7. Defect C (material): the closure claim reads the inclusion backwards

Verbatim, from the blockquote:

> The converse clause Lemma L29 left "reduced but not closed", hedged on solves at $r=6,8,10$ with $r\ge12$ untested, is closed by it, and the closure is stronger than the clause: the spectrum is forced at *every* critical point of the stratum, not merely at equality.

Three things are wrong with this, in increasing order of seriousness.

**(a) The strength comparison is inverted.** L72 itself concludes that every critical point of the stratum has $\theta=\sqrt{3/2}$. So $\{\text{critical points of the stratum}\}\subseteq\{\text{equality points}\}$, and a statement quantified over the critical points is quantified over a **subset** of what the clause quantifies over. Forcing the spectrum at every critical point is therefore **weaker** than forcing it at every equality point, not stronger. The phrase "not merely at equality" asserts the opposite inclusion, which is exactly false.

**(b) The hypotheses do not match, and the missing implication is not proved anywhere in the block.** L72 assumes $Q(W)=\theta W$; the clause assumes only $\theta(W)=\sqrt{3/2}$. The stratum is not open in the unit sphere (a kernel of multiplicity $N-3$ is a closed condition, and a generic perturbation splits it) so a maximiser over the stratum is not automatically a critical point of $\theta$ on the sphere. The implication does in fact hold here (equality forces $T_{1,N-1,N}=2$, hence $[v_1,v_{N-1}]\parallel v_N$, hence the kernel and off-diagonal rows vanish), but that is an argument the block does not make, and it is not the argument the block claims.

**(c) The clause named was not the clause that was open.** The development form of the same file, at line 15, states plainly: *"The argument gives equality $\Rightarrow$ spectrum $(2,-1,-1)/\sqrt6$; the converse needs that no other configuration attains $\sqrt{3/2}$."* Equality $\Rightarrow$ spectrum follows from [Lemma L29](../findings/stratum-two-negative.md)'s own $f(t)$, whose unique stationary point is $t=1$, I re-derived $f$ from scratch and it is right, numerator $9t(t+1)$ and scale $(2(t^2+t+1))^{-3/2}$. What was open is the **support** question, *"no full-support rank-$3$ signature-$(1,2)$ element of $\mathrm{Weyl}_r$ for even $r\ge6$"*, and **the three criticality rows say nothing about support.** So the sentence in [Lemma L29](../findings/stratum-two-negative.md)'s Statement (line 82) and the matching rows in [results.md](../results.md) and [INDEX-results.md](../findings/INDEX-results.md) attribute the closure to the wrong result.

**What actually closes it is in the block, one paragraph below, and is sound.** The per-row balance forces $\epsilon_{1,N-1}=\epsilon_{1,N}=\epsilon_{N-1,N}=0$; [Lemma L31](../findings/stratum-two-negative.md) then gives $\mathrm{im}\,v_1=\mathrm{im}\,v_{N-1}=\mathrm{im}\,v_N$ of dimension $4$, so the support is four-dimensional at every $n$ and no full-support element exists at $r\ge6$. **This needs no criticality, no numerics and no case analysis**, so the record's headline claim is true, but it is delivered by the bridge paragraph plus L31, not by the numbered lemma. **L31 is uncited at that point.**

## 8. Defect D (material): the identity is not the $\epsilon_{\min}$ bridge

Verbatim:

> rows $N-1$, $N$ added give $\sum_{p>0}\lambda_p(\epsilon_{p,N-1}+\epsilon_{p,N})=\sigma\delta$ **exactly**, which is the conjectured $\epsilon_{\min}$ bridge as an identity.

**The identity itself is correct**, I re-derived it; adding the two balance rows leaves $(a+b)\epsilon_{N-1,N}$ on the right. **The claim about what it is, is not.**

- $\epsilon_{\min}$ is defined exactly once in the record, at line 190 of the same file: $\epsilon_{\min}=\min_{\lVert u\rVert=1}\bigl(\lVert v_{N-1}u\rVert^2+\lVert v_Nu\rVert^2\bigr)$, the smallest eigenvalue of an $n\times n$ positive semidefinite matrix, a measure of how nearly the two negative eigenvectors share a kernel.
- The identity is a linear relation among the **bracket deficits** $\epsilon_{\alpha\beta}=2-\lVert[v_\alpha,v_\beta]\rVert^2$ of [conventions.md](../findings/conventions.md).

These are different objects, and $\epsilon_{\min}$ is not $\min_{\alpha\beta}\epsilon_{\alpha\beta}$. The owed item is $\epsilon_{\min}\le\tfrac2n\bigl(2-\lVert[X,Y]\rVert^2\bigr)$, item 2 of the three owed at line 428, **and this identity does not discharge it.** This is the same class of symbol collision that [conventions.md](../findings/conventions.md) already tables for $\mu$, $B$ and $M$.

**And the window is at the wrong $k$.** The heading claims *"The bridge across $0<\delta<0.005$ is an identity, not a conjecture"*, but the assembled table at line 420 places that window under $k\ge3$, while the forcing step ($\epsilon_{1,N-1}=\epsilon_{1,N}=0$ from same-signed coefficients) needs **exactly one** positive eigenvalue. The block's own closing sentence concedes it (*"at a positive $\beta$ the balance forces nothing"*) so the heading contradicts the paragraph it heads. At $k=1$ the paragraph proves the stronger $\delta=0$, which is worth saying; it is not a bridge across the window.

## 9. Defect E (minor): a false sub-claim, and it is superfluous

Verbatim: *"and $T=0$ fails (ii) outright"*. It does not: $T=0$ in (ii) gives $a(\theta+a)=0$, hence $\theta=-a$, which is consistent on its own and needs (i) as well to contradict. The clause is also unnecessary, nothing in the proof divides by $T$, and the branch-2 disposal already excludes $T=0$ by deriving a strictly negative value for $T$.

## 10. Defect F (minor, inherited): the elision "(ii)$=$(iii)"

Taken literally, the printed rows (ii) $T\lambda_1b=a(\theta+a)$ and (iii) $T\lambda_1a=b(\theta+b)$ are not equal, and setting the printed left sides equal would presuppose $a=b$. The intended step is the multiplication of §2, licensed by the preceding sentence but never written. A reader who instead subtracts gets $(a-b)(T\lambda_1+\theta+a+b)=0$ and then needs $\theta>0$, which the block never states, **the elision silently costs a hypothesis.** One inserted line ("multiply (i) by $\lambda_1$, (ii) by $a$, (iii) by $b$") removes the whole risk.

## 11. Cross-checks

| check | result |
| --- | --- |
| any other statement of the three rows in [findings/](../findings/) or [results.md](../results.md) | **none.** The rows appear only at lines 494–496 of the target file; the only neighbouring $T_{1,N-1,N}$ uses are L29's $(+--)$ block and the joint cap at $k=2$, neither in conflict |
| later sections of the same file | **no contradiction.** The one-parameter family $\mathrm{diag}(q+r,-q,-r)$ has $\theta$ varying, and the rows force $q=r$, so only its symmetric member is critical, consistent with L72 and with the family being a curve of non-critical stratum members |
| the $n=12$ table at line 607 | $\max\theta=1.224745$ on $\dim\mathfrak m\le2$ at $n=6,8,10,12$, i.e. $\sqrt{3/2}$, consistent |
| [trap 53](../findings/INDEX-traps.md) | independently prints $\langle v,W^\#v\rangle=\lambda(\theta-\lambda)$, the row form L72 uses, and $\operatorname{tr}Q(W)=1+(-1)=0$, the same anchor recovered in §4 |
| [Lemma L33](../findings/stratum-two-negative.md), as widened this audit | applies to the whole stratum, the positive side being one-dimensional whatever $a$ and $b$ do; it is an independent route to the four-dimensional support, and L72 does not depend on it |

## 12. One inherited dependency, named rather than charged

The rows are the diagonal of $Q(W)=\theta W$ **unprojected**. If $Q$ did not preserve $\mathcal W_n$, the Euler–Lagrange condition would carry a projection whose diagonal need not vanish and rows (i)–(iii) would change. [conventions.md](../findings/conventions.md) fixes $Q:\mathcal W_n\to\mathcal W_n$ and the trace half of it is confirmed by $\operatorname{tr}W^\#=-1$, verified exactly in §4. **L72 inherits this and is entitled to; it is recorded here so the dependency is visible.**

## 13. What is owed

1. Delete the strength comparison in the blockquote, or replace it with the correct inclusion: the critical points of the stratum are a subset of the equality points.
2. Move the closure attribution to the bridge paragraph and **cite [Lemma L31](../findings/stratum-two-negative.md) there**, and correct the matching sentences at line 82, in [results.md](../results.md) and in [INDEX-results.md](../findings/INDEX-results.md).
3. Strike *"which is the conjectured $\epsilon_{\min}$ bridge as an identity"*; owed item 2 stands.
4. Repair the heading of the bridge paragraph to say $k=1$, matching its own closing sentence.
5. Insert the multiplication step, and strike the $T=0$ clause.

**None of the five touches the mathematics of the numbered statement, which stands as proved.**
