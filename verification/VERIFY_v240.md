# Verifier v240, Lemma L46: $Q(W)=\lambda W$ at a locally symmetric Einstein space, $\theta=\lambda/\lVert W\rVert$, the Petersen-Stanfield display, Passage D's reformulation, and the Lean statement

The brief ([BRIEF_L46.md](BRIEF_L46.md)) was read cold. No numerical work was done: every value below is exact and computed by hand in closed form, and no scripts were written or run (the Lean file was read, and was not compiled). Log: [agent_logs/verify-L46-v240.log](../agent_logs/verify-L46-v240.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | Step (A) as worded: Richard-Seshadri Lemma 4.1 "gives it directly for a locally symmetric Einstein space, with no completeness hypothesis", at either sign of $\lambda$ | REFUTED AS STATED |
| C2 | Step (A) on the Ricci-flow reading written in the same paragraph: $Q(R)=\lambda R$ at every locally symmetric Einstein metric | CONFIRMED |
| C3 | Steps (B), (B$'$), (C): $Q(W)=\lambda W$ | CONFIRMED |
| C4 | $\theta(W/\lVert W\rVert)=\lambda/\lVert W\rVert$, and "$W/\lVert W\rVert$ is critical", under the hypothesis $\lambda\ne0$ (Passages A, B, C, D, E) | REFUTED AS STATED |
| C5 | The $\lambda=0$ exclusion: a locally symmetric Ricci-flat space is flat (Passage B, first paragraph) | HYPOTHESIS-DEBT |
| C6 | $\lVert W\rVert^2=\lVert R\rVert^2-(\operatorname{tr}R)^2/N$ and $\theta^2=1/(4(\lVert R\rVert^2-(\operatorname{tr}R)^2/N))$ at $\lambda=\tfrac12$ (Passages A, C, E) | CONFIRMED |
| C7 | The same $\theta^2$ display in Passage D, printed before any normalisation of $\lambda$ | REFUTED AS STATED |
| C8 | Compactness is not used by the proof (Passages A, B, C), against Passage D's "compact" | CONFIRMED |
| C9 | Passage D's reformulation: $\operatorname{tr}R=n/4$, $c=\frac1{2(n-1)}$, $\theta\le\theta_0(n)\iff\lVert W\rVert^2\ge\frac1{4\theta_0(n)^2}$, $\tfrac9{55}$ at $S^6\times S^6$, $n^2-12n+8$, $6+2\sqrt7$ | CONFIRMED AS ALGEBRA |
| C10 | Petersen-Stanfield: $\lambda=\tfrac12$ for every compact irreducible symmetric space in their normalisation | CONFIRMED |
| C11 | Lean (Passage F): the three theorems type what their docstrings say they type | CONFIRMED AS ALGEBRA |
| C12 | Lean (Passage F) prose: the "verbatim" record quotation, the non-vacuity claim, and "no operator $Q$ with $P(R)=\langle Q(R),R\rangle$" | REFUTED AS STATED |
| C13 | Record text (attack item 11): problem.md's closing annotation sentence, its pointer sentence, and Passage C's statement sentence | REFUTED AS STATED |

**What the round should do:** replace $\lambda\ne0$ by $W\ne0$ in the $\theta$ clause, rest step (A) on the Ricci-flow reading (or restrict the Richard-Seshadri citation to its stated range), add $\lambda=\tfrac12$ to Passage D's display and drop its "compact", and repair the broken sentences and the Lean file's stale prose.

## 0. Conventions, fixed once

- $\Lambda^2\mathbb R^n$ carries $\langle R,S\rangle=\operatorname{tr}(RS)$ with $e_i\wedge e_j$ ($i<j$) orthonormal, $N=\binom n2=\lVert I\rVert^2$. The round sphere of radius one has $R=I$ (Böhm-Wilking p. 2, "the curvature operator of the round sphere of radius one is the identity").
- Ricci: $\langle\rho(R)x,y\rangle=\sum_i\langle R(x\wedge e_i),y\wedge e_i\rangle$, and scalar curvature is $2\operatorname{tr}R$ (Richard-Seshadri, txt L182-L187). Petersen-Stanfield's Proposition 2.2 uses the same relation, $\mathrm{scal}=2\operatorname{tr}R$ (txt L346-L350).
- $Q(R)=R^2+R^\#$ with $\#$ as in Böhm-Wilking (4). This is Richard-Seshadri's $Q$ (txt L266-L268) and the brief's.
- $X\circ Y=\tfrac12(XY+YX)+X\#Y$, the symmetric polarisation, so $Q(X+Y)=Q(X)+2\,X\circ Y+Q(Y)$ and $X\circ X=Q(X)$. $P(W)=\langle W,Q(W)\rangle$, $\theta(W)=P(W)/\lVert W\rVert^3$.
- Einstein, $\mathrm{Ric}=\lambda g$: $R=cI+W$, $c=\lambda/(n-1)$, $W$ Weyl. This is Böhm-Wilking (3), $R_I=\frac{\bar\lambda}{n-1}\,\mathrm{id}\wedge\mathrm{id}$ with $\bar\lambda=\lambda$ and $R_{\mathrm{Ric}_0}=0$, together with $\mathrm{id}\wedge\mathrm{id}=I$ (Böhm-Wilking Lemma 2.1 at $R=I$ gives $I+I\#I=(n-1)R_I$ and $=\mathrm{Ric}\wedge\mathrm{id}=(n-1)\,\mathrm{id}\wedge\mathrm{id}$, with $R_I=I$).
- Closed-form objects used below, basis $e_{12},e_{13},e_{14},e_{23},e_{24},e_{34}$ at $n=4$:
  - $\mathbb S^n$ of radius one: $R=I$, $\lambda=n-1$, $c=1$, $W=0$.
  - $S^2\times S^2$ with unit factors: $R=\operatorname{diag}(1,0,0,0,0,1)$, $\lambda=1$. Since only $e_{12}$ and $e_{34}$ carry curvature and $[e_{12},e_{34}]=0$, every bracket in (4) vanishes and $R^\#=0$. So $Q(R)=R^2=R=\lambda R$.
  - $H^2\times H^2$ with factors of curvature $-1$: $R=-\operatorname{diag}(1,0,0,0,0,1)$, $\lambda=-1$, $R^\#=0$ by the same bracket, $Q(R)=R^2=-R=\lambda R$. Its sectional curvature on $e_{12}$ is $-1$.

## 1. Hypothesis inventory

| Hypothesis | Where stated | Checked against the object | Used by the proof |
|---|---|---|---|
| Locally symmetric, $\nabla R=0$ | A, B, C, D, E | the object | yes, $\Delta R=0$ in (A) |
| Einstein, $\mathrm{Ric}=\lambda g$ | A, B, C, D, E | the object | yes, (A), and $W$ Weyl in (C) |
| $\lambda\ne0$ | A, B, C, E; D's heading only | does not imply $W\ne0$ (C4) | no: $Q(W)=\lambda W$ holds at every $\lambda$, and the $\theta$ clause needs $W\ne0$ |
| compact | D only | unused (C8) | no |
| $n\ge2$ | implicit, division by $n-1$ | the object | yes, in $c$ |
| $W\ne0$ | **not stated** in A-E (Lean has it as `hpos`) | needed for $W/\lVert W\rVert$ | **used but unstated** |
| $\lambda=\tfrac12$ | A, C, E for the $\theta^2$ display, absent from D's display | C6, C7 | used by the display, unstated in D |
| $\theta_0(n)$, its definition | **not in the brief** | C9 | used by D's reformulation |
| Richard-Seshadri Lemma 4.1: "non negatively curved" | source L510 | fails at $H^2\times H^2$, and at every space of noncompact type | the record applies it outside this range (C1) |
| Richard-Seshadri Lemma 4.1: "Einstein symmetric space" | source L510 | the record applies it to *locally* symmetric spaces | (C1) |
| Richard-Seshadri Lemma 4.1: "$\lambda>0$" | source L512 | the record allows either sign | (C1) |
| Its proof: Brendle [Bre10a] Proposition 3 | source L526 | **not filed**, so its hypotheses cannot be read | imported by the cited route only |
| Hamilton's evolution $\partial_tR=\Delta R+2Q(R)$ | Richard-Seshadri txt L258-L262, "If $(M,g(t))$ is a Ricci flow", no compactness | the explicit homothetic family (C2) | yes, flow reading |
| Böhm-Wilking Lemma 2.1: $R\in S^2_B(\mathfrak{so}(n))$, no other hypothesis | source L216-L218 | $W$ Weyl, and $I$ | yes: $W\#I=-W$, $I^\#=(n-2)I$ |
| Böhm-Wilking (5): $\operatorname{tr}((R_1\#R_2)R_3)$ totally symmetric | source L186-L191 | any operators | yes, criticality and the $\operatorname{tr}W^\#$ consistency line |
| Petersen-Stanfield: compact **simply connected** $G/H$, $G$ compact semisimple, metric from $-B_{\mathfrak g}$ | source L36-L42 | record says "every compact irreducible" (C10) | yes, the value $\tfrac12$ |

## 2. C1, step (A) as worded against Richard-Seshadri Lemma 4.1

**Source, read at [richard-seshadri-1308.1190.txt](https://arxiv.org/abs/1308.1190) L510-L532 and the PDF p. 10-11.** "Lemma 4.1. Let $(M^n,g_0)$ be a non negatively curved Einstein symmetric space, then its curvature operator R satisfies: $Q(R)=\lambda R$ (3) where $\lambda>0$ is such that $\mathrm{Ric}_{g_0}=\lambda g_0$." Proof: "Since $(M^n,g_0)$ is Einstein, we can use Proposition 3 of [Bre10a] to get that (note that our definition of Q differs from the one used by Brendle by a factor of 2): $\Delta_{g_0}R_{g_0}+2Q(R_{g_0})=\lambda R$. Then, since $g_0$ is symmetric, $R_{g_0}$ is parallel and $\Delta_{g_0}R_{g_0}=0$. This proves that $Q(R_{g_0})=\lambda R_{g_0}$."

**Candidate 1a, the stated hypotheses do not reach the stated object.**
1. *Location.* Passage B (A): "[Richard–Seshadri] Lemma 4.1 gives it directly for a locally symmetric Einstein space, with no completeness hypothesis." The statement (Passages A, C, E) covers $\lambda$ of either sign, and the record's own annotation (problem.md line 624) says "$\lambda<0$ is harmless".
2. *Closed form.* $H^2\times H^2$ with curvature $-1$ factors is a symmetric Einstein space with $\lambda=-1\ne0$, inside Passages A, B, C, E. It is outside Lemma 4.1 on two counts: the sectional curvature on $e_{12}$ is $-1<0$, and $\lambda<0$ contradicts "$\lambda>0$".
3. *Charitable reading.* The printed proof visibly uses only "Einstein" and "$\nabla R=0$", and Remark 4.2 makes the identity pointwise, so the argument may reach every locally symmetric Einstein metric. That reading needs Brendle's Proposition 3 to hold for every Einstein metric, of any sign and without completeness. [Bre10a] is not filed, so this cannot be read at source. The filed [notes.md](../references/richard-seshadri-2013-noncoercive-cones/notes.md) line 17 asserts "the identity itself holds for every Einstein locally symmetric metric" with no argument. **The charitable reading rests on an unfiled source, and the finding stands.**

**Candidate 1b, the proof as printed does not reach its own conclusion.**
1. *Location.* The displayed line $\Delta_{g_0}R_{g_0}+2Q(R_{g_0})=\lambda R$, followed by $\Delta R=0$ and "This proves that $Q(R_{g_0})=\lambda R_{g_0}$". Read literally, the two lines give $Q(R)=\tfrac12\lambda R$.
2. *Closed form, in Richard-Seshadri's own conventions (§0).* Unit $\mathbb S^n$, $n\ge3$: $R=I$, $\Delta R=0$, $\lambda=n-1$, $Q(I)=I+I^\#=(n-1)I$. The displayed identity reads $2(n-1)I=(n-1)I$, which is false. The lemma's conclusion $Q(I)=(n-1)I=\lambda I$ is true. The defect is in the printed intermediate identity, whose right side must be $2\lambda R$ for the conclusion to follow.
3. *Charitable reading.* A typo in the transcription of Brendle's identity, with the conclusion correct, as the sphere shows. That rescues the lemma's statement. It does not rescue the proof as a checkable chain, because the corrected factor sits in the unfiled [Bre10a]. **The finding stands as a defect of the cited route, and the lemma's statement survives.**

**Consequence.** On the cited route alone, step (A) carries HYPOTHESIS-DEBT for $\lambda<0$, for spaces that are not nonnegatively curved, and for spaces that are locally rather than globally symmetric. What is owed is Brendle's Proposition 3 at source, with its hypotheses and its factor. The record's citation, as worded, is REFUTED AS STATED. C2 shows that the step's conclusion is reached by the other route written in the same paragraph.

## 3. C2, step (A) on the Ricci-flow reading

**Written chain (Passage B (A), italic):** "$\nabla R=0$ gives $\Delta R=0$, so $\partial_tR=2Q(R)$, and the homothety $\partial_tg=-2\lambda g$ pins $\partial_tR\vert_0=2\lambda R_0$". Passage E writes the same route.

Link by link:
1. **Hamilton's evolution equation.** Richard-Seshadri txt L258-L262: "If $(M,g(t))$ is a Ricci flow, Hamilton has proved in [Ham86] that the curvature operator $R_{g(t)}$ of $(M,g(t))$ satisfies $\partial_tR_{g(t)}=\Delta_{g(t)}R_{g(t)}+2Q(R_{g(t)})$", with the record's $Q$. The filed statement carries no compactness hypothesis. Böhm-Wilking p. 1-2 state the same equation "for a curve $g_t$ of Riemannian metrics on a compact manifold". The Richard-Seshadri form is the one that covers the object.
2. **The homothety is a Ricci flow at every sign.** $g(t)=(1-2\lambda t)g_0$ for $1-2\lambda t>0$. The Ricci tensor is invariant under constant rescaling, so $\mathrm{Ric}(g(t))=\lambda g_0$, and $\partial_tg=-2\lambda g_0=-2\,\mathrm{Ric}(g(t))$. The record's "$\partial_tg=-2\lambda g$" is this at $t=0$, which is where it is used. No existence theorem enters, because the family is written down.
3. **$\Delta R=0$.** Each $g(t)$ is locally symmetric.
4. **$\partial_tR\vert_0=2\lambda R_0$.** The $(0,4)$ curvature tensor scales by $(1-2\lambda t)$ and a $g(t)$-orthonormal frame by $(1-2\lambda t)^{-1/2}$, so the operator on orthonormal bivectors is $R(t)=R_0/(1-2\lambda t)$, with derivative $2\lambda R_0$ at $0$. The frame $e(t)=(1-2\lambda t)^{-1/2}e_0$ satisfies $\partial_te=\frac{\lambda}{1-2\lambda t}e=\mathrm{Ric}_{g(t)}(e)$, the Uhlenbeck frame in which the evolution equation is written.
5. Hence $2Q(R_0)=2\lambda R_0$, that is $Q(R)=\lambda R$, at every locally symmetric Einstein metric, any $\lambda$, no completeness.

*Screens, closed form:* $S^2\times S^2$ gives $Q(R)=R$ at $\lambda=1$, and $H^2\times H^2$ gives $Q(R)=-R$ at $\lambda=-1$ (§0). Both agree with the conclusion.

**Candidate 2a, the record's appraisal of this route.**
1. *Location.* Passage B (A): the route "reaches the same identity and needs short-time existence, so it is the weaker route". The annotation at problem.md line 624 repeats it: "Its Ricci-flow phrasing would have required short-time existence, hence the compactness this block waives".
2. *Closed form.* Link 2: the solution is $g(t)=(1-2\lambda t)g_0$, explicit, and link 1's filed statement has no compactness. No existence theorem is invoked.
3. *Charitable reading.* Short-time existence would be needed to run the flow from a general initial metric. The sentence, however, is about the homothety, whose solution is explicit. **The appraisal is wrong. The route it calls weaker is the only route on file whose imports are filed and whose range covers the stated object.** This does not touch the truth of $Q(R)=\lambda R$.

A wording slip in Passage E, "the metric shrinks homothetically", is true only for $\lambda>0$ (the family expands when $\lambda<0$). The derivative computation is unaffected.

**Verdict: CONFIRMED.**

## 4. C3, steps (B), (B$'$), (C)

- **(B).** By bilinearity and symmetry of $\circ$ (Böhm-Wilking: $R\#S=S\#R$), $Q(W+cI)=Q(W)+2c\,W\circ I+c^2Q(I)$. $Q(I)=I^2+I^\#=I+(n-2)I=(n-1)I$, since Böhm-Wilking Lemma 2.1 at $R=I$ gives $I+I\#I=(n-1)I$. With $Q(R)=\lambda R$ and $R=W+cI$: $Q(W)=\lambda W+(\lambda c-c^2(n-1))I-2c\,W\circ I$, exactly the record's line. $\lambda c-c^2(n-1)=c(\lambda-c(n-1))=0$ at $c=\lambda/(n-1)$. ✓
- **(B$'$).** $X\circ I=\tfrac12(XI+IX)+X\#I=X+X\#I$, so $W\circ I$ and $W\#I$ differ by $+W$. ✓
- **(C).** Böhm-Wilking Lemma 2.1 (txt L216-L218): $R+R\#I=(n-1)R_I+\frac{n-2}2R_{\mathrm{Ric}_0}=\mathrm{Ric}\wedge\mathrm{id}$ for every $R\in S^2_B(\mathfrak{so}(n))$. For $W$ Weyl, $R_I=R_{\mathrm{Ric}_0}=0$, so $W\#I=-W$. The source's proof checks $n=4$ directly and reaches $n\ge5$ by embedding. At $n=3$, $\mathcal W_3=0$. ✓ Hence $W\circ I=0$ and $Q(W)=\lambda W$. ✓
- The Casimir expansion in (C), "$W\#I=-\tfrac12\sum_\alpha\mathrm{ad}(v_\alpha)W\,\mathrm{ad}(v_\alpha)$", and its "$-2$ eigenvalue" are not derived in the brief. The step does not depend on them, since Böhm-Wilking gives $W\#I=-W$ at source.
- *Consistency line.* $\operatorname{tr}(W^\#)=\langle W\#W,I\rangle=\langle W\#I,W\rangle$ by Böhm-Wilking (5), and this equals $-\lVert W\rVert^2$. ✓
- *Passage E's route.* $R\#I=\lambda I-R$ follows from Lemma 2.1 with $\mathrm{Ric}\wedge\mathrm{id}=\lambda\,\mathrm{id}\wedge\mathrm{id}=\lambda I$, so $R\circ I=\lambda I$. With $Q(R)=\lambda R$ and $Q(I)=(n-1)I$: $Q(W)=Q(R)-2c\,R\circ I+c^2Q(I)=\lambda R-2c\lambda I+c\lambda I=\lambda W$. ✓
- *Criticality.* By the total symmetry of Böhm-Wilking (5) and of $\operatorname{tr}(XYZ+YXZ)$, the gradient of $P$ is $3Q(W)$. $Q(W)=\lambda W$ therefore makes $W/\lVert W\rVert$ critical on the unit sphere of $\mathcal W_n$ and of $S^2_B$ alike, whenever $W\ne0$.

**Verdict: CONFIRMED.**

## 5. C4, the $\theta$ clause under $\lambda\ne0$

1. *Location.*
   - Passage A: "$\theta(\tfrac W{\|W\|})=\frac\lambda{\|W\|}$ $(\lambda\ne0)$".
   - Passage B: "the hypothesis $\lambda\ne0$ IS PART OF THE STATEMENT, at $\lambda=0$ … $W=0$ and $\theta$ is undefined".
   - Passage C: "Locally symmetric Einstein spaces with $\lambda\ne0$ are critical".
   - Passage D: "$W/\lVert W\rVert$ is a critical point of $P$ on the unit sphere", with no hypothesis on $W$.
   - Passage E: "with $\lambda\ne0$ … $\theta(W/\lVert W\rVert)=\lambda/\lVert W\rVert$".
2. *Closed form.*
   - Unit $\mathbb S^n$, $n\ge3$: locally symmetric, Einstein, $\lambda=n-1\ne0$, $c=1$, $W=R-cI=0$. $W/\lVert W\rVert$ is $0/0$, $\theta$ is undefined, and there is no point on the unit sphere to be critical.
   - The same holds for $\mathbb{RP}^n$ and for $H^n$ ($R=-I$, $\lambda=-(n-1)$).
   - It holds at every instance with $n=3$.
   - At Petersen-Stanfield's normalisation, $S^n$ is a compact irreducible symmetric space with $\lambda=\tfrac12$ and $\lVert R\rVert^2=(\operatorname{tr}R)^2/N$. Passage A's second display then reads $\theta^2=1/0$.
3. *Charitable reading.* The expression $\theta(W/\lVert W\rVert)$ presupposes $W\ne0$, so the lemma might be read as silently restricted. Two things block this. Passage B names $\lambda\ne0$ as the hypothesis that makes $\theta$ defined. Passage C quantifies over spaces ("spaces with $\lambda\ne0$ are critical"), which includes $S^n$. The record's own annotation at problem.md line 624 concedes "the conclusion needs $W\ne0$ and neither the block nor the canon says so", and the statement at lines 628-635 was not changed. The Lean file takes `hpos : 0 < norm R`, which is $W\ne0$. **The finding stands.**

**Correction owed:** the $\theta$ and criticality clauses need $W\ne0$, that is, the space is not of constant curvature (never satisfied at $n=3$). The proof of the $\theta$ clause uses $W\ne0$ and nothing about $\lambda$. $Q(W)=\lambda W$ itself holds at $W=0$ trivially.

**Verdict: REFUTED AS STATED.**

## 6. C5, the argument at $\lambda=0$

1. *Location.* Passage B, first paragraph: "at $\lambda=0$ a locally symmetric Ricci-flat space is flat, so $W=0$ … The work is done by the decomposition of [L210] with the definiteness of $\beta$ on an irreducible factor, which leaves only the Euclidean summand at $\lambda=0$."
2. The inference "flat $\Rightarrow R=0\Rightarrow W=0$" is immediate. The step "locally symmetric and Ricci-flat $\Rightarrow$ flat" has no argument in the brief: it is delegated to L210, which the brief does not quote. What is owed is L210's decomposition of a locally symmetric curvature operator into a Euclidean summand and irreducible summands, together with a Ricci form of definite sign on each irreducible summand, so that $\mathrm{Ric}=0$ forces the irreducible part to vanish. No closed-form Ricci-flat, locally symmetric, non-flat object was exhibited, and none is claimed.
3. *Attribution.* Line 614 says the instrument is not Cartan-Ambrose-Hicks. The annotation at line 624 still says "flat by Cartan", and the Lean docstring says "by Cartan–Ambrose–Hicks with de Rham" (C12).
4. *Weight.* The step is not load-bearing. With C4's correction, $W\ne0$ is the hypothesis, and what happens at $\lambda=0$ decides only whether $\lambda\ne0$ is redundant.

**Verdict: HYPOTHESIS-DEBT (non-load-bearing).**

## 7. C6 and C7, the $\theta^2$ display

**C6.**
- $\lVert W\rVert^2=\lVert R-cI\rVert^2=\lVert R\rVert^2-2c\operatorname{tr}R+c^2N$.
- $W$ Weyl is orthogonal to $I$, so $\operatorname{tr}R=cN$, and $\lVert W\rVert^2=\lVert R\rVert^2-c^2N=\lVert R\rVert^2-(\operatorname{tr}R)^2/N$. ✓
- With $W\ne0$, $\theta^2=\lambda^2/(\lVert R\rVert^2-(\operatorname{tr}R)^2/N)$, which is the display exactly when $\lambda^2=\tfrac14$.
- Where each passage places it: Passage A at "Petersen–Stanfield's normalisation … $\lambda=\tfrac12$" ✓. Passage C "under the Einstein normalisation", value unnamed there and $\tfrac12$ by D ✓. Passage E "since $\lambda=\tfrac12$ … $\theta=\frac1{2\lVert W\rVert}$" ✓.
- *Screen.* $S^2\times S^2$ at $\lambda=\tfrac12$ (factor curvature $\tfrac12$): $\lVert R\rVert^2=\tfrac12$, $\operatorname{tr}R=1=n/4$, $\lVert W\rVert^2=\tfrac12-\tfrac16=\tfrac13$, display $\tfrac34=\lambda^2/\lVert W\rVert^2$. ✓

**Verdict: CONFIRMED** (at $\lambda=\pm\tfrac12$, $W\ne0$).

**C7.**
1. *Location.* Passage D: "Then $Q(W)=W^2+W^\#=\lambda W$ for a scalar $\lambda$, … and its value is $\theta=\lambda/\lVert W\rVert$ with $\theta^2=\frac1{4(\lVert R\rVert^2-(\operatorname{tr}R)^2/N)}$." The normalisation arrives only in the next sentence.
2. *Closed form.* $S^2\times S^2$ with unit factors: $\lambda=1$, $\lVert R\rVert^2=2$, $\operatorname{tr}R=2$, $N=6$, $\lVert W\rVert^2=2-\tfrac46=\tfrac43$. Then $\theta^2=\lambda^2/\lVert W\rVert^2=\tfrac34$, while D's display gives $\frac1{4\cdot4/3}=\tfrac3{16}$, and $\tfrac34\ne\tfrac3{16}$. More generally $\theta$ is scale-invariant and the display scales like $\lVert W\rVert^{-2}$.
3. *Charitable reading.* D may intend the normalisation of its following sentence throughout. That sentence is introduced as a further step ("Normalising to Einstein constant $\tfrac12$ makes …"), and "for a scalar $\lambda$" leaves $\lambda$ free, so this reading does not hold. **The finding stands. Correction: "at $\lambda=\tfrac12$".**

**Verdict: REFUTED AS STATED.**

## 8. C8, compactness

- The chain C2 + C3 uses local symmetry, the Einstein condition, the filed evolution equation for an explicit local Ricci flow, and algebra at a point. Nothing global enters.
- The Richard-Seshadri route (C1) uses "symmetric space", a global hypothesis, but not compactness as such.
- Passage D's "compact" is therefore an extra hypothesis. D stays true, but is weaker than A and C.
- The canon's two forms disagree: Passage C says "compactness is not needed, this entry required it", and Passage D still requires it.

**Verdict: CONFIRMED** (compactness unused). Passage D should drop it.

## 9. C9, Passage D's reformulation

1. At $\lambda=\tfrac12$: $\operatorname{tr}R=cN=\frac{\lambda}{n-1}\cdot\frac{n(n-1)}2=\frac{\lambda n}2=\frac n4$ ✓, and $c=\frac1{2(n-1)}$ ✓. Petersen-Stanfield Prop. 2.2 agrees: $\tfrac12\dim M=\mathrm{scal}=2\operatorname{tr}R$.
2. For $W\ne0$ and $\theta_0(n)>0$: $\theta=\frac1{2\lVert W\rVert}>0$, so $\theta\le\theta_0\iff\frac1{4\lVert W\rVert^2}\le\theta_0^2\iff\lVert W\rVert^2\ge\frac1{4\theta_0^2}$ ✓. The equivalence needs C4's $W\ne0$.
3. $S^6\times S^6$ at $\lambda=\tfrac12$:
   - factor curvature $\kappa$ with $5\kappa=\tfrac12$, so $\kappa=\tfrac1{10}$
   - $30$ curved planes, $N=66$
   - $\lVert R\rVert^2=\tfrac3{10}$, $\operatorname{tr}R=3=\tfrac{12}4$ ✓
   - $\lVert W\rVert^2=\tfrac3{10}-\tfrac9{66}=\tfrac{33-15}{110}=\tfrac9{55}$ ✓, and $\tfrac9{55}<\tfrac16\iff54<55$ ✓
4. $\theta_0(n)$ is not defined in the brief. D's last sentence identifies the floor $\frac1{4\theta_0(n)^2}$ with $\frac{n^2}{8(n-1)(n-2)}$, that is, $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$.
   - At $n=12$ the floor is $\frac{144}{880}=\frac9{55}$, the $S^6\times S^6$ value, consistent with "attaining $\theta_0(12)$ exactly".
   - For balanced $S^m\times S^m$, $n=2m$, $\lambda=\tfrac12$: $\kappa=\frac1{2(m-1)}$, $m(m-1)$ planes, $\lVert R\rVert^2=\frac m{4(m-1)}$, $\operatorname{tr}R=\frac m2$, $N=m(2m-1)$. This gives $\lVert W\rVert^2=\frac m{4(m-1)}-\frac m{4(2m-1)}=\frac{m^2}{4(m-1)(2m-1)}=\frac{n^2}{8(n-1)(n-2)}$ ✓.
5. For $n\ge3$: $\tfrac16\ge\frac{n^2}{8(n-1)(n-2)}\iff8(n-1)(n-2)\ge6n^2\iff2n^2-24n+16\ge0\iff n^2-12n+8\ge0$ ✓.
   - The roots are $6\pm2\sqrt7$. $28$ is not a square, so both are irrational, and $6-2\sqrt7\in(0,1)$ because $25<28<36$.
   - The inequality holds for integers $n\ge12$ ($12^2-144+8=8$) and fails for $3\le n\le11$ ($11^2-132+8=-3$). ✓
6. L47's and L48's thresholds, and "the two halves meet", lie outside L46 and were not checked.

**Verdict: CONFIRMED AS ALGEBRA**, conditional on the identification of $\theta_0(n)$ above and on $W\ne0$.

## 10. C10, Petersen-Stanfield's normalisation at source

- **Source** ([petersen-stanfield-2508.11236.txt](https://arxiv.org/abs/2508.11236) L36-L42): "We consider compact simply-connected symmetric spaces: $M=G/H$, where $G$ is a compact semi-simple Lie group … we equip $G/H$ with the $G$-invariant submersion metric induced by $-B_{\mathfrak g}$. With this metric, $M$ is Einstein with Einstein constant $\tfrac12$." Prop. 2.2 (L346-L350) repeats "the Einstein constant $\tfrac12$".
- The value $\tfrac12$ is a choice of scale. The record says so ("in Petersen–Stanfield's normalisation").
- **Candidate 10a.**
  1. *Location.* Passage A: "every compact irreducible symmetric space". Petersen-Stanfield's stated scope is simply connected.
  2. *Closed form.* $\mathbb{RP}^n$ is compact, irreducible and not simply connected.
  3. *Charitable reading.* The display is pointwise, and $\mathbb{RP}^n$ is locally isometric to $S^n$, which lies in the stated scope. Petersen-Stanfield's scope also includes reducible products, so the $S^6\times S^6$ use in D is covered. **Withdrawn.**

**Verdict: CONFIRMED.**

## 11. C11 and C12, the Lean statement (Passage F)

The file matches the brief line for line (`wc -l` gives 151, and the brief's "152" counts a trailing newline). The file was read, and was not compiled.

**C11, the theorems.**

- **`shift_kills_remainder`.**
  - *Binders.* $E$ is any $\mathbb R$-module. `Qb` is bilinear, and `hsymm` makes it symmetric. `hn : (n:ℝ)-1 ≠ 0`, `hQI : Qb I I = (n-1)•I`, `hWI : Qb W I = 0`, `hc : c = lam/(n-1)`, `hcrit : Qb (W+c•I) (W+c•I) = lam•(W+c•I)`. Conclusion `Qb W W = lam•W`.
  - *Directions.* `hcrit` is $Q(R)=\lambda R$ at $R=W+cI$ ✓. `hc` puts $c$ on the left ✓.
  - *Proof, read line by line.* The cross terms vanish by `hWI` and its symmetric image. $Qb(cI)(cI)=c^2(n-1)I$. `hcoef` gives $c\cdot c\cdot(n-1)=\lambda c$ from $c=\lambda/(n-1)$ and `hn` ✓. `add_right_cancel` then closes $Qb\,W\,W+(\lambda c)I=\lambda W+(\lambda c)I$ ✓.
  - *What the hypotheses exclude.* `hn` excludes $n=1$ only, and admits $n=0$, which is harmless algebra. `hQI` and `hWI` hold for curvature operators by Böhm-Wilking Lemma 2.1 (C3). `hcrit` is step (A). Nothing geometric is excluded.
- **`theta_of_eigenvalue`.**
  - *Binders.* `R` is an arbitrary map on matrices, needing neither linearity nor the Weyl property.
  - `hnn : 0 ≤ normSq R` excludes nothing. `normSq R = innerOp R R` $=\tfrac12\sum_{i,j}$ `inner2 (R φ) (R φ)`, and `inner2 X X` $=\tfrac12\operatorname{tr}(X^{\mathsf T}X)\ge0$ (WeylReal.lean L39, L135-L136, L173).
  - `hpos : 0 < norm R` is $W\ne0$. That is the correct hypothesis, and it is not the record's $\lambda\ne0$ (C4). The docstring's "the record's $\lambda\ne0$ clause in the form it is actually needed" names two different conditions as one.
  - *Proof.* $\theta=P/\lVert R\rVert^3$ (L180), $\lVert R\rVert^2=$ `normSq` by `Real.sq_sqrt`, so $\theta=\lambda\lVert R\rVert^2/\lVert R\rVert^3=\lambda/\lVert R\rVert$ ✓.
- **`petersen_stanfield`.** Pure real algebra. `hw` ($\lVert W\rVert^2=\lVert R\rVert^2-(\operatorname{tr}R)^2/N$) and `hth` ($\theta=\tfrac12/w$) are hypotheses, and the conclusion follows ✓. `hwpos` excludes $W=0$, consistent with C4. `hNN` is used only for $N\ne0$.
- *Gap to the lemma.* The three theorems are not chained, and the file's docstring declares this. `hcrit`, `hQI` and `hWI` are hypotheses. `theta_of_eigenvalue`'s `hP` is not derived from `shift_kills_remainder`'s conclusion. $\theta$ is read at $W$ rather than at $W/\lVert W\rVert$. `hw` is assumed rather than derived. The file types the algebra of step (B), the division in the first display, and the arithmetic of the second.

**Verdict: CONFIRMED AS ALGEBRA.**

**C12, the prose around them.**

- **Candidate 12a, the "verbatim" quotation.**
  1. *Location.* L46Statement.lean lines 38-40 (brief lines 94-96): "at $\lambda=0$ a locally symmetric Ricci-flat space is flat by Cartan–Ambrose–Hicks with de Rham, so $W=0$".
  2. *Failure.* problem.md line 614 now reads "at $\lambda=0$ a locally symmetric Ricci-flat space is flat, so $W=0$ and $\theta$ is undefined. THE INSTRUMENT IS NOT CARTAN--AMBROSE--HICKS", displayed at source.
  3. *Charitable reading.* The quotation was verbatim when it was written. The file still presents it as the record's current text, and it carries the attribution the record has since withdrawn. **Stands.**
- **Candidate 12b, non-vacuity.**
  1. *Location.* The docstring above `example`: "A witness for `shift_kills_remainder`'s hypotheses, so the theorem is not vacuous".
  2. *Failure.* The example proves only `Qb I I = (n-1)•I` and `Qb 0 I = 0` for $E=\mathbb R$ and `Qb = mul`. It does not exhibit `hn` (which fails at $n=1$, a value the example admits), `hc`, `hcrit`, or `hsymm`.
  3. *Charitable reading.* The missing hypotheses are satisfiable, but showing it takes steps the example does not contain. **Stands**, with no effect on any theorem's truth.
- **Candidate 12c, "no operator $Q$".**
  1. *Location.* "the real Weyl layer carries `Pcubic` and `normSq` but no operator `Q` with `P(R) = ⟨Q(R), R⟩`".
  2. *Failure.* The imported [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) defines `Qop` (L189) and proves `theorem Pcubic_eq_inner_Qop (R) : Pcubic R = innerOp R (Qop R)` (L249-L250).
  3. *Charitable reading.* The file predates those lines. The stated reason for leaving the bridge untyped is false against the file it imports. **Stands.**

**Verdict: REFUTED AS STATED** (prose only).

## 12. C13, the record's sentences (attack item 11)

- **Closing annotation sentence**, problem.md line 626: "*The statement is below; the section it used to point at is". The clause "the section it used to point at is" has no complement, and the opening asterisk has no closing one. It does not read as a sentence.
- **Pointer sentence heading the block**, line 612: "*The argument is not elsewhere in this file: [graded-half.md] carries a four-line proof labelled as this lemma's, and **the result is published**, Richard–Seshadri Lemma 4.1, in [references/].*"
  - It reads as a sentence.
  - "The argument is not elsewhere in this file" sits directly above the three-step proof in the same block. Read charitably, it means "not in another section".
  - "the result is published, Richard–Seshadri Lemma 4.1" overstates. Lemma 4.1 publishes $Q(R)=\lambda R$ only for nonnegatively curved Einstein symmetric spaces with $\lambda>0$, and the Weyl-part identity appears inside the proof of their Proposition 4.3 (PDF p. 11) in the same range (C1).
- **Passage C**, results.md line 106: "… gives the identity flow-free.*act locally symmetric Einstein space, $Q(W)=\lambda W$, so …". The statement sentence has lost its opening, and what remains starts mid-word at "act". The canonical landscape statement has no grammatical head. No charitable reading restores it.

**Verdict: REFUTED AS STATED** (text).

## 13. Withdrawn candidates

- **W1, "$c=\lambda/(n-1)$ is the choice that kills the remainder" (Passage B (B)).**
  1. *Location.* The quoted clause.
  2. *Failure.* $c=0$ also kills $\lambda c-c^2(n-1)$, and (B) alone leaves $-2c\,W\circ I$.
  3. *Charitable reading.* $c$ is fixed by the Einstein decomposition, not chosen, and the $W\circ I$ term is removed by (B$'$) and (C), which belong to the same proof. **Withdrawn.**
- **W2, "$\theta$ quadratic in $\lVert W\rVert$" (headings of Passages C and D).**
  1. *Location.* Both headings.
  2. *Failure.* $\theta=\lambda\lVert W\rVert^{-1}$ has degree $-1$ in $\lVert W\rVert$.
  3. *Charitable reading.* $\theta^{-2}=4\lVert W\rVert^2$ at $\lambda=\tfrac12$ is quadratic in $\lVert W\rVert$ and a quadratic form in $R$. That is what Passage C's "a quadratic condition on $\lVert W\rVert$" and Passage E's "QUADRATIC functional of published tables" say. **Withdrawn.** The wording would read better as "$\theta^{-2}$ quadratic".
- **W3, "the homothety $\partial_tg=-2\lambda g$".** The family $g(t)=(1-2\lambda t)g_0$ has $\partial_tg=-2\lambda g_0$, which equals $-2\lambda g(t)$ only at $t=0$, and $t=0$ is the only time used. **Withdrawn.**
- **W4, Petersen-Stanfield's scope** (C10, candidate 10a). **Withdrawn.**

## 14. The standing list

1. **Hypothesis inventory.** §1. Used but unstated: $W\ne0$ (the $\theta$ and criticality clauses), $\lambda=\tfrac12$ in Passage D's display, and the definition of $\theta_0(n)$. Stated but unused: compactness (D) and $\lambda\ne0$. Imported outside its stated range: Richard-Seshadri Lemma 4.1 (C1).
2. **Quantifier order and scope.**
   - The identity is: for every locally symmetric Einstein $(M,g)$ with $\mathrm{Ric}=\lambda g$ and every point, $Q(W)=\lambda W$. It needs no guard.
   - The guard "$(\lambda\ne0)$" is scoped differently across passages: after the $\theta$ display in A, over the whole statement in B, and over the subject "spaces with $\lambda\ne0$" in C. In every passage it is meant to make $\theta$ defined, and it does not (C4).
   - Passage D's "for a scalar $\lambda$" reads existentially where $\lambda$ is the Einstein constant. This is harmless until D's display (C7).
   - "Critical point of $P$ on the unit sphere" leaves the ambient space unnamed. That is immaterial, because $Q(W)=\lambda W$ holds exactly.
3. **Edges.**
   - $\lambda<0$: the identity holds (C2, screen $H^2\times H^2$, $\theta=-\sqrt3/2$). The cited lemma does not reach it (C1). Passage E's "shrinks" is wrong in sign.
   - $\lambda=0$: C5.
   - $W=0$: $S^n$, $\mathbb{RP}^n$, $H^n$ break the $\theta$ clause (C4).
   - $n=3$: $\mathcal W_3=0$, so the $\theta$ clause never applies and the identity is trivial.
   - $n=4$: Böhm-Wilking checks $W\#I=-W$ directly, and the screens $S^2\times S^2$ and $H^2\times H^2$ agree.
   - Reducible spaces: the proof uses no irreducibility, and $S^2\times S^2$ and $S^6\times S^6$ agree (C6, C9).
   - $\ker W\ne0$: nothing in the proof inverts $W$. No finding.
4. **Proven against stated or used.**
   - Proven: $Q(W)=\lambda W$ at every locally symmetric Einstein metric, any $\lambda$, with no compactness and no irreducibility; $\theta(W/\lVert W\rVert)=\lambda/\lVert W\rVert$ when $W\ne0$; the $\theta^2$ display when additionally $\lambda=\pm\tfrac12$.
   - Stated beyond that: the $\theta$ clause under $\lambda\ne0$ (C4), D's display at general $\lambda$ (C7), and Richard-Seshadri's range (C1).
   - Used: D's equivalence $\theta\le\theta_0\iff\lVert W\rVert^2\ge\frac1{4\theta_0^2}$ holds only for $W\ne0$. At $S^n$, $\lambda=\tfrac12$, the left side is undefined while the right side is false.
5. **Lean statements.** C11 and C12.
6. **"What to attack" items.**
   1. Step (A) against its source: C1 and C2.
   2. (B), (B$'$), (C) and the chain: C3 and W1.
   3. $\lambda\ne0$ against $W\ne0$: C4.
   4. $\lambda=0$: C5.
   5. The display and $\lVert W\rVert^2$: C6 and C7.
   6. Compactness: C8.
   7. D's reformulation: C9.
   8. Petersen-Stanfield at source: C10.
   9. Lean: C11 and C12.
   10. Boundary: item 3 of this list.
   11. The sentences: C13.
7. **Falsifying objects, and the search for them.**
   - For the $\theta$ clause: unit $S^n$ (found, C4).
   - For D's display: unit $S^2\times S^2$ (found, C7).
   - For the citation's range: $H^2\times H^2$ (found, C1).
   - For $Q(W)=\lambda W$ itself: a locally symmetric Einstein metric with $Q(W)\ne\lambda W$. The chain C2 + C3 was checked link by link against filed sources, and $S^2\times S^2$ and $H^2\times H^2$ were screened in closed form. None was found, and C2 + C3 exclude one.

## 15. Overall verdict

**PROVEN (hypotheses corrected).**
- $Q(W)=\lambda W$ is proven at every locally symmetric Einstein space, of either sign and without compactness. The proof runs on the Ricci-flow reading written in step (A), whose one import (Hamilton's evolution equation, as Richard-Seshadri state it) is filed and covers the object, together with steps (B), (B$'$), (C) and Böhm-Wilking Lemma 2.1.
- The corrections owed:
  - the $\theta$ and criticality clauses take $W\ne0$ in place of $\lambda\ne0$ (C4)
  - Passage D's $\theta^2$ display takes $\lambda=\tfrac12$ (C7), and D drops "compact" (C8)
  - the Richard-Seshadri citation is restricted to its stated range, nonnegatively curved Einstein symmetric spaces with $\lambda>0$, or step (A) rests on the flow reading, whose "weaker route" appraisal is wrong (C1, C2)
- Textual repairs: problem.md's broken sentence, Passage C's truncated statement, and the Lean file's stale quotation and stale reason (C12, C13).
- If the round keeps Richard-Seshadri Lemma 4.1 as the sole route for step (A), that step is HYPOTHESIS-DEBT for $\lambda<0$ and for spaces that are not nonnegatively curved. What is owed is Brendle's [Bre10a] Proposition 3 at source, with its hypotheses and its factor.
