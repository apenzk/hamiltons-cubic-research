# Reviewer r418, Gate 2 on post F56 and the withdrawal of Lemma L132

*Targets: [findings/second-order.md](../findings/second-order.md) §"Post F56" (end of file), [findings/ungraded-slack.md](../findings/ungraded-slack.md) §"Lemma L132, WITHDRAWN" (end of file), and the corresponding blocks in [ATTEMPTS.md](../ATTEMPTS.md). Commits `d0587fb`, `a4804e5`, `bf9465c`.*

***Analysis only.** Every positive claim below is proved by hand. One screen was run (seconds, at $n=5$, on random symmetric matrices built for the purpose), solely to check that the $\#$ normalisation I derived in is the record's. It is reported as a screen and is never evidence for a positive claim.*

*The section (a)–(d) below was derived and logged to [agent_logs/gate2-F56-B.log](../agent_logs/gate2-F56-B.log) **before** either target section was opened.*

## Verdict in one line

**F56's arithmetic is right, its conclusion is right, and its demonstration proves nothing, the substitution it performs returns $d=d$ for every identity in mathematics, so it carries no information about this one.** The conclusion survives for a reason F56 does not give, and that reason is a strictly stronger fence than the post states. The withdrawal of L132 is correct on every count.

| # | Item | Verdict |
| --- | --- | --- |
| 1a | F56's evaluation: $\mathop{\mathrm{tr}}(X_{\mathrm{inv}}\#W_-)=\tfrac14J_5+3\langle\mathrm{Alt}X_{\mathrm{inv}},\mathrm{Alt}W_-\rangle-\mathop{\mathrm{tr}}(X_{\mathrm{inv}}W_-)$, and $J_5=J_5$ on back-substitution | **CONFIRMED**, my (b), derived cold, is the same line |
| 1b | The *reason*: "the two are one relation read at two arguments" | **CORRECTED**, they are one relation at **one** argument pair; the $\lvert W\rvert$ and $W_-$ readings are the *same* instance, since $\Phi(\cdot,W)\equiv0$. The true fence is a one-parameter family, below |
| 1c | Is the circularity an artefact of the substitution? | **CONFIRMED as structural, and F56 under-diagnoses it**, the displayed computation is a content-free schema; the real obstruction is that $\mathrm{Ric}$ has rank-one image on $\mathop{\mathrm{span}}\{W_+,W_-\}$ |
| 1d | "the grant asks whether the bracket weight avoids $X_{\mathrm{inv}}$'s negative directions" | **CORRECTED**, the bracket sum is one of **three** unsigned terms. This is the slide [ATTEMPTS.md](../ATTEMPTS.md) already ruled false one section earlier |
| 2a | L132 is the trace of $S=T_1+2T_2+T_3$ | **CONFIRMED**, verified by hand in both directions; and L132 is *also* exactly $\tfrac12\mathop{\mathrm{tr}}(X_{\mathrm{inv}})$, so it is doubly on the record |
| 2b | The withdrawal removes a true result | **CONFIRMED that it does, and the withdrawal is still correct**, L132's formula is true and unconditional-given-criticality; it is withdrawn for weakness, the strictly stronger statement stays on the record, and the number is retired rather than reused |
| 2c | "the two forms agree exactly when the compression is lossless" is false | **CONFIRMED**, the graded points are genuine witnesses. One wording nitpick in 4 below |
| 3 | F56 is new content | **REFUTED**, it is [ATTEMPTS.md](../ATTEMPTS.md)'s own "recombining by the identity that produced it" paragraph, and its "what remains" line is [r414](REVIEW_r414.md)'s C7 with one substitution |
| 4 | Hypotheses used silently | one found, in the *withdrawal*, not in F56: $[E_-,E_-]\ne0$. F56 additionally fails to state that it uses **no** criticality, a missed strengthening |
| 5 | Worth a fence-post number | **REFUTED**, it is [post F55](../findings/INDEX-traps.md)'s last bullet instantiated at the one candidate scalar. Demote to a two-line addendum on F55, carrying the strengthened fence |

---

## The cold derivation, (a)–(d)

Derived from [conventions.md](../findings/conventions.md), [problem.md](../findings/problem.md) and the definitions $X_{\mathrm{inv}}=\lvert W\rvert^\#-\big(P_+W^\#P_++P_-W^\#P_-\big)$, $J_5=\langle\mathrm{Ric}(X_{\mathrm{inv}}),\mathrm{Ric}(\lvert W\rvert)\rangle$ of [ATTEMPTS.md](../ATTEMPTS.md) Result 4.

### (a) The polarised scalar-curvature identity, and where its proof is

**Statement.** For **any** two symmetric operators $A,B$ on $\Lambda^2\mathbb R^n$,

$$\Phi(A,B)\;:=\;\langle A,B\rangle+\mathop{\mathrm{tr}}(A\#B)-3\big\langle\mathrm{Alt}(A),\mathrm{Alt}(B)\big\rangle\;=\;\tfrac12\big\langle\mathrm{Ric}(A),\mathrm{Ric}(B)\big\rangle .$$

**Hypotheses, in full: $A$ and $B$ symmetric. That is the whole list.** No first Bianchi identity, no criticality, no positivity, no relation between $A$ and $B$, no restriction on $n$.

**Proof, from the record's own pieces.** [Lemma L131](../findings/isotropy-cap.md) gives $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$ for every symmetric $R$, off the Bianchi locus. Pair it with $A$ and use three facts: $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$, so $\langle A,\mathrm{Ric}(B)\wedge\mathrm{id}\rangle=\tfrac12\langle\mathrm{Ric}A,\mathrm{Ric}B\rangle$; full symmetry of Huisken's $\mathrm{tri}(A,B,C)=\langle A\#B,C\rangle$ together with $\mathop{\mathrm{tr}}(MI)=\mathop{\mathrm{tr}}M$, so $\langle A,B\#I\rangle=\mathrm{tri}(A,B,I)=\langle A\#B,I\rangle=\mathop{\mathrm{tr}}(A\#B)$; and $\mathrm{Alt}$ an orthogonal projection, so $\langle A,\mathrm{Alt}B\rangle=\langle\mathrm{Alt}A,\mathrm{Alt}B\rangle$. $\square$

**Two properties of $\Phi$ that matter and that neither target section uses.** $\Phi$ is **symmetric** (every one of its three terms is) and it is **positive semi-definite**, being a Gram form in $\mathrm{Ric}$. So $\Phi$ can never sign anything by itself: Cauchy–Schwarz on it gives $\Phi(A,B)^2\le\Phi(A,A)\Phi(B,B)$, an *upper* bound on $\lvert\Phi(A,B)\rvert$.

**Its diagonal is [Lemma L15](../findings/problem.md).** With the record's $\mathop{\mathrm{scal}}(M)=2\mathop{\mathrm{tr}}(M)$, L15's $\mathop{\mathrm{scal}}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$ is exactly $\Phi(R,R)$. So $\Phi$ is L15 polarised, is L131 paired, and is [isotropy-cap.md](../findings/isotropy-cap.md)'s $\mathcal A(R)=2R-\mathrm{Ric}^*(\mathrm{Ric}\,R)-6\,\mathrm{Alt}(R)$, **one statement wearing three names, and [isotropy-cap.md](../findings/isotropy-cap.md) already says so.**

### (b) At $A=X_{\mathrm{inv}}$, $B=W_-$

$W$ is Weyl, so $\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$; hence $\mathrm{Ric}(\lvert W\rvert)=\mathrm{Ric}(W+2W_-)=2\mathrm{Ric}(W_-)=2g$, and

$$\Phi(X_{\mathrm{inv}},W_-)\;=\;\tfrac12\langle\mathrm{Ric}(X_{\mathrm{inv}}),g\rangle\;=\;\tfrac14\langle\mathrm{Ric}(X_{\mathrm{inv}}),\mathrm{Ric}(\lvert W\rvert)\rangle\;=\;\tfrac14 J_5 .$$

Written out, that reads $\langle X_{\mathrm{inv}},W_-\rangle+\mathop{\mathrm{tr}}(X_{\mathrm{inv}}\#W_-)-3\langle X_{\mathrm{inv}},\mathrm{Alt}(W_-)\rangle=\tfrac14J_5$, which **is the boxed form of [post F55](../findings/second-order.md), divided by four**. Substituting it into $J_5=4[\,\cdots]$ therefore returns $J_5=J_5$.

**It is not informative, and here is the sharp reason.** $\mathrm{Ric}$ restricted to $\mathop{\mathrm{span}}\{W_+,W_-\}$ has **rank one**: $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)=g$ and $\mathrm{Ric}(W)=0$. Hence for **every** $B=\alpha W_++\beta W_-$ in that plane,

$$\Phi(X_{\mathrm{inv}},B)\;=\;\tfrac{\alpha+\beta}{4}\,J_5 ,$$

vanishing identically on the line $\mathbb R W$ and returning a multiple of $J_5$ everywhere else. So the identity does not merely return $J_5$ at the one pair F56 tries: **it returns a multiple of $J_5$ at every second argument built from $W$'s spectral parts, and nothing else is reachable.** That is the fence, and it is a one-parameter family, not "two arguments".

A corollary of the same computation, worth having and absent from both sections: $\Phi(A,W)=0$ for every symmetric $A$ is *precisely* $W\#I=-W$, [target.md](../findings/target.md)'s identity, since $\mathrm{Alt}(W)=0$ kills the third term.

### (c) $\mathop{\mathrm{tr}}(A\#B)$ in bracket data

Write $A=\sum_ix_iu_iu_i^{\mathsf T}$, $B=\sum_j\mu_jv_jv_j^{\mathsf T}$ in their own orthonormal eigenbases of $\Lambda^2\cong\mathfrak{so}(n)$. With $(A\#B)_{ab}=\tfrac12\sum c_{ace}c_{bdf}A_{cd}B_{ef}$ and $c_{abc}=\langle[v_a,v_b],v_c\rangle$ totally antisymmetric,

$$\mathop{\mathrm{tr}}(A\#B)\;=\;\tfrac12\sum_{i,j}x_i\mu_j\Big(\sum_a\big\langle[u_i,v_j],v_a\big\rangle^2\Big)\;=\;\boxed{\ \tfrac12\sum_{i,j}x_i\mu_j\big\lVert[u_i,v_j]\big\rVert^2\ }$$

the inner sum collapsing because $\sum_{c,e}c_{ace}(u_i)_c(v_j)_e=\langle[u_i,v_j],v_a\rangle$.

**It extends to an indefinite $A$ verbatim, and this is the point.** The derivation used no positivity and **no commuting hypothesis**, $A$ and $B$ are each in their *own* eigenbasis, and the two bases are unrelated. It is a bilinear algebraic identity, valid for every pair of symmetric operators. What does **not** extend is the *sign*: with $x_i\ge0$ and $\mu_j\ge0$ every summand is nonnegative (Hamilton's $\#$-positivity, since $\lVert[u_i,v_j]\rVert^2\ge0$), whereas signed $x_i$ turns the sum into a signed combination of nonnegative bracket weights, and the $\#$-calculus has nothing to say about it. $X_{\mathrm{inv}}$ is exactly that case: the record refutes $X_{\mathrm{inv}}\succeq0$ at an $n=5$ critical point.

**Normalisation.** Two anchors fix the $\tfrac12$ inside the record's conventions: $A=B=I$ gives $\mathop{\mathrm{tr}}(I^\#)=\tfrac12N\cdot2(n-2)=N(n-2)=\mathop{\mathrm{tr}}\big((n-2)I\big)$, matching $I\#I=(n-2)I$; and $\mathrm{tri}$-symmetry with $W\#I=-W$ gives $\mathop{\mathrm{tr}}(W^\#)=\langle W\#I,W\rangle=-\lVert W\rVert^2=-1$, matching [conventions.md](../findings/conventions.md). *Screen (seconds, $n=5$, random symmetric (hence indefinite and non-commuting), $A$, $B$, against [r313_lib.py](../scripts/reviewers/r313/r313_lib.py)'s $\#$): the boxed formula reproduces the trace to $1.2\times10^{-14}$ and $I^\#=(n-2)I$ holds exactly. Reported as a screen only; the proof above is the evidence.*

### (d) What would still have to be proved

Collapsing (a)–(c), the grant is

$$J_5\ge0\iff\big\langle\mathrm{Ric}(X_{\mathrm{inv}}),g\big\rangle\ge0,\qquad g\succeq0,\ \ \mathrm{Ric}(X_{\mathrm{inv}})\ \text{indefinite},$$

and equivalently, in bracket data, $\sum_ix_i\big(\sum_j\mu_j\lVert[u_i,v_j]\rVert^2\big)\ge\text{(the other two terms)}$ with $x_i$ signed. **Every operator-level route above this is closed on the record**: $X_{\mathrm{inv}}\succeq0$ refuted, $\mathrm{Ric}(X_{\mathrm{inv}})\succeq0$ refuted at $\theta=0.882135$, $n=5$, and both congruence intermediates refuted there too.

So what is owed is an input that **couples $X_{\mathrm{inv}}$'s negative eigendirections to $W_-$'s bracket weight**, a statement of the form "the bracket mass $\sum_j\mu_j\lVert[u_i,v_j]\rVert^2$ is small on $\{x_i<0\}$". Neither L131, nor L15, nor the $\#$-positivity calculus can supply it: all three are blind to the sign pattern of an indefinite argument. The only such input the record holds is the block/cross split, whose surviving open statement is $\lvert\langle X_{\mathrm{cross}},H_{\mathrm{cross}}\rangle\rvert\le J_5^{\mathrm{diag}}$.

---

## 1. Post F56, CONFIRMED in outcome, CORRECTED in reason

### 1a. The arithmetic, CONFIRMED

F56's display is my (b) rearranged, sign for sign, and the back-substitution cancels as it says: the two $\langle X_{\mathrm{inv}},W_-\rangle$ terms cancel, and the two $\mathrm{Alt}$ terms cancel because $\langle X_{\mathrm{inv}},\mathrm{Alt}(W_-)\rangle=\langle\mathrm{Alt}(X_{\mathrm{inv}}),\mathrm{Alt}(W_-)\rangle$. $J_5=J_5$. No dispute.

### 1b. "One relation read at two arguments", CORRECTED

It is one relation read at **one** argument pair. The boxed form *is* $4\,\Phi(X_{\mathrm{inv}},W_-)$; F56 solves $\Phi(X_{\mathrm{inv}},W_-)$ for its middle term and puts it back into $\Phi(X_{\mathrm{inv}},W_-)$.

The historical reading, the box was derived at $B=\lvert W\rvert$ ([ATTEMPTS.md](../ATTEMPTS.md), the "grant's three terms" section) and F56 evaluates at $B=W_-$, does not rescue "two arguments" either, because by (b) those are the **same instance**: $\Phi(X_{\mathrm{inv}},\lvert W\rvert)=2\,\Phi(X_{\mathrm{inv}},W_-)$ exactly, the factor $2$ coming from $\Phi(\cdot,W)\equiv0$. There is no second reading anywhere in the picture.

**The correct statement of the fence is the one-parameter version in (b)**: $\Phi(X_{\mathrm{inv}},\alpha W_++\beta W_-)=\tfrac{\alpha+\beta}4J_5$ for all $\alpha,\beta$. That closes the whole plane at once, including the two instances already on the record and every combination a successor might try, and it says *why*: $\mathrm{Ric}$ has rank-one image there.

### 1c. Is the circularity an artefact of the substitution?, the circularity is structural, but F56's demonstration of it is vacuous

Structural, yes: $\Phi$ is symmetric, so re-entering through the other slot changes nothing, and (b) shows the whole $\{W_+,W_-\}$-plane collapses onto $J_5$.

**But the computation F56 displays does not show this, and cannot show anything.** Strip the symbols: from any true identity $a+b+c=d$, solving $b=d-a-c$ and substituting back into $a+b+c=d$ yields $d=d$. That holds for **every** identity, informative or not, and involves neither $\#$, nor $\mathrm{Ric}$, nor $\mathrm{Alt}$, nor $X_{\mathrm{inv}}$. So "$J_5=J_5$ identically" is a property of the *operation performed*, not a property of the polarised scal identity, and it is not evidence that the identity has no other use. Two things the same identity does yield, neither ruled out by F56's argument:

- $\Phi(X_{\mathrm{inv}},X_{\mathrm{inv}})\ge0$, i.e. $\mathop{\mathrm{tr}}(X_{\mathrm{inv}}^\#)\ge3\lVert\mathrm{Alt}(X_{\mathrm{inv}})\rVert^2-\lVert X_{\mathrm{inv}}\rVert^2$, a genuine lower bound on a $\#$-trace of an *indefinite* operator, which the $\#$-calculus alone does not give;
- Cauchy–Schwarz on the PSD form $\Phi$, giving $J_5^2\le4\,\Phi(X_{\mathrm{inv}},X_{\mathrm{inv}})\cdot\Phi(W_-,W_-)$.

Neither signs $J_5$ (which is why the post's *conclusion* stands) but the post's stated argument does not reach them, so the conclusion is asserted more broadly than it is earned. **The repair is one sentence: replace the back-substitution with (b)'s rank-one observation, which proves the conclusion rather than illustrating it.**

### 1d. "So the grant asks whether the bracket weight avoids $X_{\mathrm{inv}}$'s negative directions", CORRECTED

The grant is $J_5\ge0$, i.e. $\langle X_{\mathrm{inv}},W_-\rangle+\mathop{\mathrm{tr}}(X_{\mathrm{inv}}\#W_-)-3\langle X_{\mathrm{inv}},\mathrm{Alt}(W_-)\rangle\ge0$, **three** terms, all three unsigned once $X_{\mathrm{inv}}\succeq0$ is refuted ($\mathrm{Alt}(W_-)$ is traceless and indefinite, so the third is unsigned too). Signing the bracket sum alone neither implies nor is implied by $J_5\ge0$.

This is the same slide that [ATTEMPTS.md](../ATTEMPTS.md) rejected one section earlier, against a neighbouring proposal: *"'the sign of the middle term is the comparison the grant was always about' is false: there are three terms, the other two unsigned since $X_{\mathrm{inv}}\not\succeq0$."* F56 reintroduces it in its closing sentence. The honest version: *the bracket form makes visible that the middle term is a signed sum of nonnegative bracket weights; the other two remain unsigned, so this is a reformulation of one of three terms, not of the grant.*

---

## 2. The withdrawal of Lemma L132, CONFIRMED

I checked this in the direction the brief asks: **is a true result being deleted?** It is a true result, and the withdrawal is still right, because the record keeps a strictly stronger statement of the same fact and retires the number rather than reusing it.

### 2a. L132 is true, and it is the decomposition's trace, CONFIRMED, both directions

L132 read $S=2\mathop{\mathrm{tr}}(W_-^\#)+\mathop{\mathrm{tr}}(W_-^2)-\theta\mathop{\mathrm{tr}}(W_-)$.

**It is true.** From the definition $S=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)$ with $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$, apply my (a) at $A=B=W_-$: $\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2=2\mathop{\mathrm{tr}}(W_-^2)+2\mathop{\mathrm{tr}}(W_-^\#)$. Substituting gives L132 exactly. No hypothesis beyond the definition of $S$.

**It is the decomposition's trace.** Summing [ATTEMPTS.md](../ATTEMPTS.md)'s three terms and using $\mathop{\mathrm{tr}}\big((1-P_-)M(1-P_-)\big)=\mathop{\mathrm{tr}}M-\mathop{\mathrm{tr}}(P_-MP_-)$,

$$T_1+2T_2+T_3=\mathop{\mathrm{tr}}\Big(P_-\big[W_+^\#-2W_+\#W_-+W_-^\#\big]P_-\Big)+2\mathop{\mathrm{tr}}(W_+\#W_-)=\mathop{\mathrm{tr}}(P_-W^\#P_-)+2\mathop{\mathrm{tr}}(W_-^2)+2\mathop{\mathrm{tr}}(W_-^\#),$$

the last step by (A)+(B). In the other direction, the trace of criticality compressed on $E_-$ ($P_-(W^2+W^\#)P_-=\theta P_-WP_-$ with $W\vert_{E_-}=-W_-$), gives $\mathop{\mathrm{tr}}(W_-^2)+\mathop{\mathrm{tr}}(P_-W^\#P_-)=-\theta\mathop{\mathrm{tr}}(W_-)$. Substituting that into the line above turns it into L132 exactly. **So the two are the same number, and the withdrawal's phrase "that theorem's trace, the three terms summed and their separate signs discarded" is precise.**

**And it is on the record a second time.** Expanding $\mathop{\mathrm{tr}}(X_{\mathrm{inv}})$ from $X_{\mathrm{inv}}=4W_+\#W_--2\theta W_--2W_-^2$ with (A)+(B) gives $\mathop{\mathrm{tr}}(X_{\mathrm{inv}})=2\big[\mathop{\mathrm{tr}}(W_-^2)+2\mathop{\mathrm{tr}}(W_-^\#)-\theta\mathop{\mathrm{tr}}(W_-)\big]$, that is, **L132 is exactly $\tfrac12\mathop{\mathrm{tr}}(X_{\mathrm{inv}})$**, which is [Lemma L7](../results.md)'s $\mathop{\mathrm{scal}}(X_{\mathrm{inv}})\ge0$ read as an equality. The withdrawal's fifth bullet asserts this; I confirm it by the computation above, and note it makes L132 the *same statement* as L7's scalar, not merely a consequence of it.

### 2b. Strictly weaker, CONFIRMED

L132's right-hand side carries the unsigned $-\theta\mathop{\mathrm{tr}}(W_-)$, so it yields none of the decomposition's three products: no $S\ge0$, no $S\ge\tfrac12G_1$, and no equality characterisation. The decomposition yields L132 in one line (above); L132 yields none of the decomposition. Strictly weaker, as claimed.

### 2c. The sentence flagged as false really does fail at graded points, CONFIRMED

The two forms are (i) the conditional $S=\mathop{\mathrm{tr}}(P_{E_-}W_-^\#P_{E_-})=T_3$ and (ii) L132. "Lossless compression" means $\mathop{\mathrm{tr}}(P_{E_-}W_-^\#P_{E_-})=\mathop{\mathrm{tr}}(W_-^\#)$.

At a graded point all three grading conditions hold, so $T_1=T_2=T_3=0$ and $S=0$: **both forms return $0$, so they agree.** Meanwhile L132 at $S=0$ gives $2\mathop{\mathrm{tr}}(W_-^\#)=\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)=\sum_i\mu_i(\theta-\mu_i)$, and independently $\mathop{\mathrm{tr}}(W_-^\#)=\tfrac12\sum_{i,j}\mu_i\mu_j\lVert[v_i,v_j]\rVert^2$ by my (c). So whenever $[E_-,E_-]\ne0$ the uncompressed trace is strictly positive while the compressed one is zero, **total loss, with the two forms agreeing anyway.** The "exactly when" is refuted. $\square$

*Note the pleasing structure of this: the withdrawal note's own refutation of the false sentence is carried out **using L132**, which is independent evidence that L132 is a true and usable identity, and that its withdrawal is a judgement about strength, not correctness. The note would read better if it said so.*

---

## 3. Already on the record, REFUTED as new content

Screened by mechanism ("a symmetric bilinear identity re-entered through its own argument returns itself") across [findings/](../findings/), [reviews/](.), [references/](../references/) and [ATTEMPTS.md](../ATTEMPTS.md). Four hits, three of them from the same day.

| where | what it already says |
| --- | --- |
| [ATTEMPTS.md](../ATTEMPTS.md), §"The grant's three terms" | *"$\langle X,\lvert W\rvert\rangle+\mathop{\mathrm{tr}}(X\#\lvert W\rvert)-3\langle X,\mathrm{Alt}(\lvert W\rvert)\rangle=\cdots=\tfrac12J_5$, **recombining by the identity that produced it** … applying L131 to $X_{\mathrm{inv}}$ instead walks straight back."* This **is** F56, at $B=\lvert W\rvert$, and by my (b) that is the *same instance*, not an analogue |
| [Post F55](../findings/second-order.md) | *"The three recombine to $\tfrac12J_5$ by the identity that produced them"*, and the fence-post bullet *"$\mathop{\mathrm{tr}}(X_{\mathrm{inv}}\#W_-)$ is the one pairing that carries content, and the one place the calculus has no scalar to offer"* |
| [r414](REVIEW_r414.md) C7 | $\mathop{\mathrm{tr}}(A\#B)=\tfrac12\sum_{ij}a_ib_j\lVert[u_i,v_j]\rVert^2$, *proved cold*, F56's "what the pairing does leave" is this with $A=X_{\mathrm{inv}}$ substituted, from a review F56 cites three lines earlier |
| [ungraded-slack.md](../findings/ungraded-slack.md) / [isotropy-cap.md](../findings/isotropy-cap.md) | *"pairing L131 with its own argument depolarises it and returns the identity it came from"*; *"[L131] is [L15] polarised"* |

So the commit message's *"screened against ATTEMPTS.md by mechanism as well as findings/"* did not catch the closest match, which sits in [ATTEMPTS.md](../ATTEMPTS.md) in the very section that produced the box F56 substitutes into. **This is the tenth consecutive already-on-record proposal, and the failure mode is new: the screen ran, and the duplicate was in the paragraph immediately upstream of the object under study.** The screening lesson recorded against L132, query [ATTEMPTS.md](../ATTEMPTS.md) by mechanism, was applied and was still not enough, because the relevant mechanism was not stated as a mechanism in the upstream paragraph; it was stated as a passing remark inside a derivation.

**What is genuinely new in F56, and it is small:** naming the polarised identity as the specific tool that fails, and the observation that the residual question is a weighted-mass one. Both are corollaries of rows 2 and 3 above.

---

## 4. Hypotheses used silently

| hypothesis | where it is needed | stated? |
| --- | --- | --- |
| $\mathrm{Alt}(W)=0$ (first Bianchi for $W$) | $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$; the cancellation of the $\langle X,W\rangle$ terms | **stated**, [post F55](../findings/second-order.md) says it explicitly, F56 inherits it |
| $\mathrm{Ric}(W)=0$ | $\mathrm{Ric}(\lvert W\rvert)=2g$, hence $\tfrac14J_5$ in F56's own display | **stated** in F55's box; F56 imports it via "using $J_5=2\langle\mathrm{Ric}(X_{\mathrm{inv}}),g\rangle$" |
| $W_-\succeq0$, hence $\mu_j\ge0$ and $g=\mathrm{Ric}(W_-)\succeq0$ | the bracket-mass reading | **stated** ($\mu_j\ge0$ in F56; $g\succeq0$ in F55's box). $g\succeq0$ is definitional, from $\mathrm{Ric}(R)(v,v)=\sum_kR(v\wedge e_k,v\wedge e_k)$ |
| $\mathrm{Alt}$ self-adjoint idempotent | the two $\mathrm{Alt}$ terms cancelling | **stated** ("$\mathrm{Alt}$ being an orthogonal projection") |
| $\theta\ge0$ | **not used anywhere in F56.** It is used in F55's $\theta W_-+W_-^2\succeq0$ | **stated, and correctly flagged**, F55 records that the true condition is $\theta\ge-\lambda^+_{\min}(W_-)$ and that [bounds-relaxations.md](../findings/bounds-relaxations.md) catalogues $\theta\le0$ critical points |
| criticality | **not used anywhere in F56**, the identity, the box and the tautology are all unconditional | **not stated, and this is a missed strengthening**: F56 sits inside a critical-point discussion and never says its content is criticality-free |
| $[E_-,E_-]\ne0$ | the L132 **withdrawal**'s "$\mathop{\mathrm{tr}}(W_-^\#)>0$ at every graded point" | **SILENT.** See below |

**The one genuinely silent hypothesis.** The withdrawal writes *"fails at every graded point: there $S=0=T_3$ while $\mathop{\mathrm{tr}}(W_-^\#)=\tfrac12\sum_i\mu_i(\theta-\mu_i)>0$."* By (c), $\mathop{\mathrm{tr}}(W_-^\#)=\tfrac12\sum_{i,j}\mu_i\mu_j\lVert[v_i,v_j]\rVert^2$, which is $\ge0$ always but $>0$ only when $E_-$ carries nonzero bracket among its own positive-$\mu$ directions. At a hypothetical graded point with abelian $E_-$ the compression would be *lossless* (both sides zero) and the sentence would hold there. **The verdict is unaffected**, refuting an "exactly when" needs one witness, and every named graded point (the sphere products, $\mathbb{HP}^2$, $\mathbb{CP}^3$, $SU(3)$) has $[E_-,E_-]\ne0$. The wording should read *"fails at every graded point with $[E_-,E_-]\ne0$, which is every named one"*.

---

## 5. Is F56 worth a fence-post number?, REFUTED; demote

**No, as it stands.** [Post F55](../findings/INDEX-traps.md) already fences the general fact, *"a symmetric pairing rewritten through one argument returns through the other"*, from [r413](REVIEW_r413.md)/[r414](REVIEW_r414.md), and already states the specific consequence, that $\mathop{\mathrm{tr}}(X_{\mathrm{inv}}\#W_-)$ is *"the one place the calculus has no scalar to offer"*. F56 takes the one scalar candidate F55 had already declared empty and confirms it is empty, by an operation that returns $d=d$ on any identity. That is F55's last bullet instantiated, and instantiating a fence post is not a new fence post.

**What should survive, and it is worth keeping.** Not the tautology, but the strengthened statement from my (b), which F56 does not have:

> $\mathrm{Ric}$ has rank-one image on $\mathop{\mathrm{span}}\{W_+,W_-\}$, so the polarised scal identity returns $\Phi(X_{\mathrm{inv}},\alpha W_++\beta W_-)=\tfrac{\alpha+\beta}4J_5$ at **every** second argument built from $W$'s spectral parts, zero on $\mathbb RW$, a multiple of $J_5$ elsewhere. No choice of argument in that plane escapes, and the $\lvert W\rvert$ and $W_-$ readings already on the record are one instance, not two.

**Recommendation.** Fold F56 into [post F55](../findings/second-order.md) as a two-line addendum carrying that display, and rewrite the [INDEX-traps.md](../findings/INDEX-traps.md) row 56 to state the rank-one reason instead of the $J_5=J_5$ computation. Retiring the number is not necessary (unlike L132 the entry has independent (if small) navigational value) but the row as written invites a successor to believe the *computation* is the fence, which it is not.

---

## What I did not check

The numerical claims quoted from earlier sections, the twelve-point verification of the $J_5$ identity, the $n=5$ refutation of $\mathrm{Ric}(X_{\mathrm{inv}})\succeq0$, the point counts behind $S=T_1+2T_2+T_3$, are taken as recorded. Nothing in this review depends on any of them: every verdict above is an algebraic identity or its failure, proved by hand from [Lemma L15](../findings/problem.md), [Lemma L131](../findings/isotropy-cap.md) and the definition of $S$.
