# Gate 2 review, reviewer r801, does one non-decomposable image form put $\dim V$ at four?

**Cold brief.** I worked from the coordinator's brief and read [L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean) line by line, then [Lemma L186](../findings/diagonal-half.md#L662) and its four givens, [Lemma L178](../findings/diagonal-half.md#L614), [Lemma L179](../findings/diagonal-half.md#L636), [Lemma L180](../findings/diagonal-half.md#L682) and [Lemma L185](../findings/diagonal-half.md#L648), in full, together with [Lemma L181](../findings/diagonal-half.md#L702), [Lemma L183](../findings/diagonal-half.md#L728) and the pairings in [conventions.md](../findings/conventions.md#L85) and [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39). **The programme is on an analysis-only footing and I opened no search, sweep, census, optimisation or falsifier hunt.** Two screens were run, each on an object I constructed for the purpose and each reported as a screen in §6 and §8; no positive claim here rests on either. Log: [agent_logs/g2-l186-r801.log](../agent_logs/g2-l186-r801.log).

## The claim table

| # | Claim attacked | Verdict |
| --- | --- | --- |
| 1 | Step 1, Ricci-flatness is $\lambda_1\omega_1\omega_1^{\mathsf T}+\lambda_2\Pi_2+\lambda_3\Pi_3=0$, with coefficient $1$ on each $\Pi_i$ | **CONFIRMED EXACTLY in the record's own pairing**, the $\tfrac12$ of [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39) is what makes a unit decomposable form's $\omega\omega^{\mathsf T}$ the bare projection, and the identity is convention-robust anyway |
| 2 | Step 2 (the sign hypothesis needs its own argument | **REFUTED), IT IS DERIVABLE, BY TWO INDEPENDENT ROUTES**, so Claim A is unconditional and the lemma, the Lean file and the standing-debt note all understate it |
| 3 | Step 3, non-decomposable gives $\mathop{\mathrm{rank}}\ge4$, and $\dim(P_2+P_3)\le4$ when the planes meet | **CONFIRMED**, a real skew form has even rank and rank $\le2$ is exactly decomposability; meeting planes lower the span rather than raise it |
| 4 | Step 4, $\mathop{\mathrm{range}}(A+B)=\mathop{\mathrm{range}}A+\mathop{\mathrm{range}}B$ for positive-semidefinite $A,B$, and $\mathop{\mathrm{supp}}\omega_1$ is that range | **CONFIRMED and already sourced** at [L180](../findings/diagonal-half.md#L682)(3) |
| 5 | Step 5 ($V$ is the span of the three supports, in the record's own definition | **CONFIRMED**), [L179](../findings/diagonal-half.md#L636)(a) defines $V$ exactly that way |
| 6 | **Vacuity of Claim A** | **THE BRANCH IS EMPTY FOR EVERY RANK-THREE WEYL TENSOR**, by [L179](../findings/diagonal-half.md#L636)(b) in one line, and inhabited over Ricci-flat spectral sums, where I exhibit a member in closed form |
| 7 | Claim B's rank count, $\mathop{\mathrm{rank}}(aA+bB)\ge\max(\mathop{\mathrm{rank}}A,\mathop{\mathrm{rank}}B)$ | **CONFIRMED, and elementary**, $\ker(A+B)=\ker A\cap\ker B$ at positive-semidefinite $A,B$; it fails exactly where positive semidefiniteness or a positive coefficient fails |
| 8 | Claim B's scope and novelty | **CONFIRMED AS TRUE, REFUTED AS NEW**, it is [L180](../findings/diagonal-half.md#L682)(3) read at this branch, and it needs the third form decomposable, which the phrasing supplies and does not say |
| 9 | The closing note's "*That is now the whole of [I38](../plan.md)*" | **REFUTED, twice over**, the two-non-decomposable case is not the whole of it, the all-three case being open and unmentioned; and the branch the lemma treats is not part of it at all |
| 10 | The Lean file's account of what it proves | **REFUTED**, `hsign` is unused in [psd_form_of_ricci](../lean/HamiltonsCubic/Results/L186Statement.lean#L54), the word `PosSemidef` occurs nowhere in the file, and three further binders are inert |

## One-line summary

**Every step of Claim A is sound, its sign hypothesis is redundant, and the class it bounds is empty: a rank-three Weyl tensor cannot have exactly one non-decomposable image form, because first Bianchi then reads $\lambda_1\,\omega_1\wedge\omega_1=0$, so L186 is the second consecutive lemma of this line that is correct and vacuous, and its true statement is the emptiness.**

## 0. Conventions, fixed once

- The $\Lambda^2$ pairing is [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39), $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$; [conventions.md](../findings/conventions.md#L85) says the $\tfrac12$ lives at the $\Lambda^2$ level.
- A $2$-form is a skew matrix, $\mathop{\mathrm{supp}}\omega=\mathop{\mathrm{im}}\omega$, and $A_i=\omega_i\omega_i^{\mathsf T}=-\omega_i^2$.
- $\Pi_P$ is the orthogonal projection onto $P$, and $\Pi_2,\Pi_3$ the projections onto the two decomposable forms' planes.
- **A screen** is seconds of compute on an object I construct for the purpose, reported as a screen and never as evidence for a positive claim. Running Lean is one.

## 1. Step 1 is exact, and the $\tfrac12$ is what makes it exact

The brief asks whether the $\tfrac12$ survives into the displayed identity. **It does, and the identity is right because of it rather than in spite of it.**

[L180](../findings/diagonal-half.md#L682)(1) gives Ricci-flatness as $\sum_i\lambda_i\omega_i\omega_i^{\mathsf T}=0$ with $\mathop{\mathrm{tr}}A_i=\sum_{a,b}(\omega_i)_{ab}^2=2\lVert\omega_i\rVert^2=2$, so this record's unit norm is $\lVert\omega\rVert^2=\tfrac12\sum_{a,b}\omega_{ab}^2$. Take $\omega=e_1\wedge e_2$ as the skew matrix with entries $\pm1$ at $(1,2)$ and $(2,1)$: then $\lVert\omega\rVert^2=\tfrac12\cdot2=1$ and $\omega\omega^{\mathsf T}=\Pi_{\langle e_1,e_2\rangle}$ **with no constant in front**, and $\mathop{\mathrm{tr}}=2$ matches L180. *Under plain Frobenius the same form would have norm $\sqrt2$ and the unit form would give $\tfrac12\Pi$.* So the displayed equation is the record's own, and [r799](REVIEW_r799.md) pinned the same constant against the machine-checked [areaForm_sq_of_orthonormal](../lean/HamiltonsCubic/Base/SelfDual.lean#L292).

**The step is also convention-robust**, which is worth saying because a reader who imports a different normalisation should not conclude the lemma breaks: any other choice gives $\omega_i\omega_i^{\mathsf T}=c\,\Pi_i$ with one $c>0$ shared by both decomposable forms, and every rank statement downstream is untouched.

## 2. The sign hypothesis is derivable, so Claim A is unconditional

**The brief's second question is the one the lemma's own standing-debt note gets wrong.** The note at [diagonal-half.md](../findings/diagonal-half.md#L678) says mixed signs with $P_2\ne P_3$ "need their own argument", and the Lean file repeats it under *What is NOT typed here*. **Both routes below are two lines, and each uses only material already on the record.**

*Route one, the record's own [L180](../findings/diagonal-half.md#L682)(3).* At rank three the weights are nonzero and sum to zero, so one sign is a minority of one, and L180(3) proves $V$ **is** that single form's support. Suppose the minority form were $\omega_3$, decomposable. Then $V=P_3$ is a plane, all three $\omega_i$ lie in $\Lambda^2V$ (one-dimensional) and three orthonormal forms do not fit in a line. **So the minority form is non-decomposable, and with exactly one such form it is $\omega_1$: the two decomposable weights share the sign opposite $\lambda_1$, which is the hypothesis.**

*Route two, the rank count the lemma already runs, Claim B's own count, at this branch.* If $\lambda_1$ shared its sign with, say, $\lambda_2$, then $\lambda_3$ is alone and Ricci-flatness reads $\lvert\lambda_1\rvert A_1+\lvert\lambda_2\rvert\Pi_2=\lvert\lambda_3\rvert\Pi_3$. The left side has range $\mathop{\mathrm{supp}}\omega_1+P_2\supseteq\mathop{\mathrm{supp}}\omega_1$, of dimension at least four; the right has rank two. **So Claim B's argument, applied to the branch Claim A treats, discharges Claim A's hypothesis**, the two halves of the same block prove each other's assumption, and neither says so.

**Consequence for the record.** The sign clause belongs in the proof and not in the statement; the definition [OppositeSigns](../lean/HamiltonsCubic/Results/L186Statement.lean#L43) names a case that is forced rather than chosen; and the *what is still open* note should lose its first sentence.

## 3. Steps 3 and 4 hold, including at intersecting planes

**$\mathop{\mathrm{rank}}\omega\ge4$ for a non-decomposable $\omega$.** By the real skew normal form $\omega=\sum_{j=1}^k c_j\,e_{2j-1}\wedge e_{2j}$ with every $c_j\ne0$ and rank $2k$; then $\omega\wedge\omega=2\sum_{j<l}c_jc_l\,e_{2j-1,2j,2l-1,2l}$ on a basis of $\Lambda^4$, which vanishes exactly at $k\le1$. **So $\omega\wedge\omega=0$, decomposability, and rank $\le2$ are one condition**, and a non-decomposable form has $k\ge2$, hence rank at least four. *This is the fact [L179](../findings/diagonal-half.md#L636) quotes and [nondecomposable_needs_four](../lean/HamiltonsCubic/Results/L179.lean#L50) records arithmetically.*

**$\dim(P_2+P_3)\le4$ when the planes meet.** The brief asks whether meeting breaks the bound; it strengthens it, $\dim(P_2+P_3)=4-\dim(P_2\cap P_3)$. So the upper end of the pin survives, four is forced from both ends, and $P_2\cap P_3=0$ follows rather than being assumed. **And $P_2=P_3$ never needed the separate exclusion the block gives it**, the rank pin rules out every nonzero intersection at once.

**Step 4.** $\mathop{\mathrm{range}}(A+B)=\mathop{\mathrm{range}}A+\mathop{\mathrm{range}}B$ for positive-semidefinite $A,B$ is [L180](../findings/diagonal-half.md#L682)(3)'s imported fact, sourced there to [Fillmore–Williams](../references/fillmore-williams-1971-operator-ranges/) and [Yang](../references/yang-2024-semidefinite-optimization/); the passage $\mathop{\mathrm{range}}A_1=\mathop{\mathrm{supp}}\omega_1$ is L180's own $\ker A=\ker\omega$ observation. Both are used correctly.

## 4. Step 5 matches the record's definition of $V$

[L179](../findings/diagonal-half.md#L636)(a) defines $V$ as the span of the supports of the eigenforms with nonzero eigenvalue, which at rank three is $\mathop{\mathrm{supp}}\omega_1+P_2+P_3$, exactly what the proof writes. **With $\mathop{\mathrm{supp}}\omega_1=P_2+P_3$ the sum collapses and $\dim V=4$.** *The definition also carries the adapted-frame convention L179(a) records, and nothing here reads an index outside $V$, so that convention is not consumed.*

## 5. Claim B's rank count is right, and elementary

**$\mathop{\mathrm{rank}}(aA+bB)\ge\max(\mathop{\mathrm{rank}}A,\mathop{\mathrm{rank}}B)$ holds for positive-semidefinite $A,B$ and $a,b>0$, and needs no operator-range theorem.** For positive-semidefinite $M$, $x^{\mathsf T}Mx=0$ forces $Mx=0$; so $x^{\mathsf T}(aA+bB)x=0$ makes both terms vanish and $\ker(aA+bB)=\ker A\cap\ker B$. Then $\mathop{\mathrm{rank}}(aA+bB)=n-\dim(\ker A\cap\ker B)\ge n-\dim\ker A=\mathop{\mathrm{rank}}A$.

**Where it fails, precisely.** At a negative coefficient, $A-A$ has rank zero; and without positive semidefiniteness the kernel identity goes, $A=\mathop{\mathrm{diag}}(1,0)$ against $B=\mathop{\mathrm{diag}}(-1,0)$. **Neither escape is available here**: $A_i=\omega_i\omega_i^{\mathsf T}$ is a Gram matrix, and the coefficients are $\lvert\lambda_i\rvert$.

**Two things the count's presentation gets wrong.** It is not new, it is [L180](../findings/diagonal-half.md#L682)(3) at this branch, since same-signed $\lambda_1,\lambda_2$ make the decomposable $\omega_3$ the minority form, whose support L180(3) proves is $V$, against that lemma's own $\dim V\ge4$. And it needs $\omega_3$ decomposable, so it reaches *exactly two* non-decomposable forms and not *at least two*; with all three non-decomposable the right side has rank at least four too and the count says nothing.

## 6. Vacuity, the branch is empty for Weyl tensors, and inhabited only when Bianchi is dropped

**This is the finding.** [L179](../findings/diagonal-half.md#L636)(b) reads the first Bianchi identity on the spectrum as $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$ in $\Lambda^4$, and §3 above says $\omega\wedge\omega=0$ **is** decomposability. Under Claim A's hypothesis $\omega_2$ and $\omega_3$ are decomposable, so their self-wedges vanish and the identity reads

$$\lambda_1\,\omega_1\wedge\omega_1=0.$$

**With $\lambda_1\ne0$ this makes $\omega_1$ decomposable, against the hypothesis. So:**

> **No rank-three Weyl tensor has exactly one non-decomposable image form.** Ricci-flatness, orthonormality and the support are all unused; the whole of it is $\lambda_1\ne0$ and L179(b).

**The block is one paragraph away from this and does not take the step.** Its own next note, at [diagonal-half.md](../findings/diagonal-half.md#L676), applies L179(b) to the two-non-decomposable case and writes there that "*the decomposable form contributes nothing, $\omega\wedge\omega=0$ IS decomposability*". Applied one branch earlier, that sentence empties the lemma's own hypothesis.

**Read literally, the statement is about Ricci-flat spectral sums and is inhabited there.** The statement at [diagonal-half.md](../findings/diagonal-half.md#L666) says "Ricci-flat" and not "Weyl", so it is fair to ask whether the wider class is empty too. It is not, and here is a member in closed form on $\mathbb R^4$, with $s=1/\sqrt2$:

$$\omega_1=s\,(e_1\wedge e_3+e_4\wedge e_2),\qquad \omega_2=e_1\wedge e_2,\qquad \omega_3=e_3\wedge e_4,\qquad (\lambda_1,\lambda_2,\lambda_3)=(2,-1,-1).$$

$\omega_1$ is a unit anti-self-dual form, so $\omega_1\omega_1^{\mathsf T}=\tfrac12\mathrm{Id}_4$ and $2\omega_1\omega_1^{\mathsf T}=\Pi_2+\Pi_3=\mathrm{Id}_4$; the triple is orthonormal because $\omega_1$ has no $e_1\wedge e_2$ or $e_3\wedge e_4$ component; $\omega_1$ has rank four and the other two rank two; and $\dim V=4$ as the lemma says. **Its Bianchi sum is $2\,e_{1234}\ne0$**, which is the general obstruction above made concrete. *Screened, as an elaboration of an object built for this report: the Gram matrix returned $\mathrm{Id}_3$, the Ricci sum returned the zero matrix to $10^{-12}$, the Pfaffians returned $(\tfrac12,0,0)$ and the Bianchi sum returned $2$.*

**So the verdict splits by class, and both halves matter.** Over Ricci-flat spectral sums the hypotheses are met and the conclusion is true. Over $\mathcal W_n$, which is where [I38](../plan.md), [L178](../findings/diagonal-half.md#L614) and the Lean file's own framing put it, there is nothing to conclude about. **[L185](../findings/diagonal-half.md#L648) was CONFIRMED and vacuous; L186 is the same shape, one branch along, and the two are emptied by opposite halves of the pair of conditions**, the all-decomposable branch by Ricci-flatness alone, with Bianchi automatic there, and the one-non-decomposable branch by Bianchi alone, with Ricci-flatness unused.

## 7. The branch census the closing note gives is wrong in both directions

The note at [diagonal-half.md](../findings/diagonal-half.md#L678) ends "*And the TWO-non-decomposable case, where $\mathop{\mathrm{supp}}\omega_1=\mathop{\mathrm{supp}}\omega_2+P_3$ can have dimension six and nothing here rules it out. That is now the whole of [I38](../plan.md).*" **The correct census of a rank-three Weyl tensor by its number of non-decomposable image forms is:**

| non-decomposable forms | status | closed by |
| --- | --- | --- |
| $0$ | **empty** | [L185](../findings/diagonal-half.md#L648), Ricci-flatness alone |
| $1$ | **empty** | §6 above, first Bianchi alone |
| $2$ | **open**, with the weights forced opposite | Claim B narrows it; $\dim V\le6$ stands |
| $3$ | **open, and unmentioned** | nothing on the record reaches it |

**So the sentence overstates by one branch and understates by another.** The all-three case is not covered: [L184](../findings/diagonal-half.md#L750) closes only the coincident configuration at $\dim V=6$, [L183](../findings/diagonal-half.md#L728)'s distinct-collinear branch is open, and neither Claim B's rank count nor L180(3) bites when every $A_i$ has rank at least four. *[plan.md](../plan.md)'s own I38 row says "leaving only the non-decomposable one", which is right; it is the lemma's closing note that narrows it too far.*

## 8. The Lean file proves less than it says it proves

**Screen: [L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean) builds clean under the repository toolchain, `8708` jobs, no `sorry`.** The build's own warnings are the finding.

- **`hsign` is not referenced in [psd_form_of_ricci](../lean/HamiltonsCubic/Results/L186Statement.lean#L54)**, and the elaborator says so. What is proved there is the rearrangement $l_1\bullet A+l_2\bullet P_2+l_3\bullet P_3=0\Rightarrow l_1\bullet A=(-l_2)\bullet P_2+(-l_3)\bullet P_3$, which holds for arbitrary reals over any module. **The file's closing docstring says "*What this file PROVES is `psd_form_of_ricci`: that the sign split turns Ricci-flatness into an identity between positive-semidefinite matrices*"**, the sign split is inert in it, and `Matrix.PosSemidef` occurs nowhere in the file, so neither half of that sentence is typed.
- **[rank_ge_of_psd_sum](../lean/HamiltonsCubic/Results/L186Statement.lean#L101) never mentions `rB`**, so the statement carrying the file's name for the positive-semidefinite range fact is $4\le r_A\to r_A\le r_{\text{sum}}\to4\le r_{\text{sum}}$ with the second summand absent.
- **[nondecomposable_weights_opposite](../lean/HamiltonsCubic/Results/L186Statement.lean#L113) uses neither `hsum` nor `h₃`**, so the theorem named for $\sum\lambda_i=0$ is sign trichotomy on two reals.

*The file is candid that [dim_V_eq_four](../lean/HamiltonsCubic/Results/L186Statement.lean#L79) is arithmetic over binders, and that candour is right.* **What it is not candid about is the one theorem it nominates as its content**, and that nomination is what a reader of [lean/INDEX.md](../lean/INDEX.md) will carry away.

## 9. Arguing the opposite

**Against §6, the strongest defence is scope.** One could hold that L186 is a statement about Ricci-flat spectral sums, that §6's witness inhabits it, and that vacuity therefore fails. *That defence costs the lemma its purpose.* The conclusion it advertises is "*this branch lands inside [L178](../findings/diagonal-half.md#L614)'s hypothesis*", and L178 is a $\theta$ bound on $\mathcal W_n$; a $\dim V=4$ for an object that is not a Weyl tensor lands inside nothing. **The honest form is to keep the Ricci-only statement, say that it is Ricci-only, and record the emptiness as the lemma that closes the branch.**

**Against §6 on the mathematics, the only opening is L179(b) itself.** If the Bianchi obstruction carried cross terms $\omega_i\wedge\omega_j$ the argument would not close. It does not: $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$ is diagonal in the eigenbasis, so $\mathfrak b(W)=\sum_i\lambda_i\,\omega_i\wedge\omega_i$ with no off-diagonal terms, the same reading [L181](../findings/diagonal-half.md#L702) and [L183](../findings/diagonal-half.md#L728) both run on, and [L183](../findings/diagonal-half.md#L728) independently confirms it by reaching the same $\Phi=(\omega^2,\omega\wedge\omega)$ criterion. **Under L183 the branch dies again and by a second reading**: the three $\Phi_i$ must coincide or be distinct and collinear, and $\Phi_2,\Phi_3$ having zero second component while $\Phi_1$ does not puts $\Phi_1$ off the line through the other two unless $\lambda_1=0$.

**Against §2, the defence would be that L180(3) is itself the disputed range fact.** Route two answers it: that route uses only $\mathop{\mathrm{range}}(A+B)\supseteq\mathop{\mathrm{range}}A$, which §5 proves from $\ker(A+B)=\ker A\cap\ker B$ and no citation.

**Against §5's demotion of Claim B, the defence is that the rank count is self-contained where L180(3) imports Fillmore–Williams.** That is fair and is why the verdict is *confirmed as true, refuted as new* rather than a withdrawal: the count is a cheaper proof of a recorded fact.

## 10. The falsifiers, named, and what I did to look for them

**Claim A's falsifier** is a triple $\omega_1,\omega_2,\omega_3$ of $2$-forms on $\mathbb R^n$, orthonormal in the half-trace pairing, with $\lambda_i\ne0$, $\sum_i\lambda_i\omega_i\omega_i^{\mathsf T}=0$, exactly one $\omega_i$ non-decomposable, the two decomposable weights sharing the sign opposite the third, and $\dim V\ne4$. **I looked for it by re-deriving each of the five steps from the record's own conventions rather than from the block's prose**, the pairing against [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39) and [conventions.md](../findings/conventions.md#L85), the rank floor from the skew normal form, the span bound at intersecting planes, and the range identity against its sources, and each closes, so no such object exists. **I then attacked the hypothesis set instead**, which is where the lemma gives: I built the closed-form triple of §6 to show the hypotheses are inhabited over Ricci-flat spectral sums, screened it, and found its Bianchi sum nonzero, which led to the general one-line proof that the sign of that failure is forced, and hence that the branch is empty over $\mathcal W_n$.

**Claim B's falsifier** is such a triple with $\omega_1,\omega_2$ non-decomposable, $\omega_3$ decomposable and $\lambda_1\lambda_2>0$. **I looked for it by asking where the rank inequality can fail**, it fails only at a non-positive-semidefinite summand or a non-positive coefficient, and neither is reachable from $A_i=\omega_i\omega_i^{\mathsf T}$ and $\lvert\lambda_i\rvert$, and then by checking whether first Bianchi permits the configuration the count excludes, which it does: $\lambda_1\,\omega_1\wedge\omega_1+\lambda_2\,\omega_2\wedge\omega_2=0$ with same-signed weights is satisfiable in $\Lambda^4$ whenever the two self-wedges point oppositely. **So the count eliminates something Bianchi does not, and no falsifier exists.** *I opened no search for one; the elimination is a two-line kernel argument and a search would have added nothing to it.*

## Verdicts

- **Claim A, CONFIRMED as stated, with the hypothesis redundant and the class empty.** The five steps are sound and $\dim V=4$ follows. The sign hypothesis is derivable two ways (§2), so the lemma is stated weaker than it is proved. And **the branch is empty for every rank-three Weyl tensor** (§6), which is the statement the record should carry in its place, the second consecutive lemma of this line to be correct and vacuous.
- **Claim B, CONFIRMED.** The rank count is valid and elementary (§5). It is [L180](../findings/diagonal-half.md#L682)(3) at this branch rather than a new exclusion, and it reaches exactly-two-non-decomposable rather than at-least-two.

## What the record should change

1. **Replace L186's headline with the emptiness**: *no rank-three Weyl tensor has exactly one non-decomposable image form*, proved from [L179](../findings/diagonal-half.md#L636)(b) alone. Keep the $\dim V=4$ argument beneath it, labelled as the Ricci-only statement it is, with §6's witness as its inhabitant.
2. **Drop the sign hypothesis from the statement** and put §2's two routes in the proof; retire the first sentence of the *what is still open* note and the matching bullet in the Lean file.
3. **Correct the census** of §7: I38's remaining ground is the two- and three-non-decomposable cases, and the three-case has nothing on it.
4. **Fix the Lean file's self-description**: `hsign` is inert in [psd_form_of_ricci](../lean/HamiltonsCubic/Results/L186Statement.lean#L54) and no positive semidefiniteness is typed anywhere in the file.
