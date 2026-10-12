# REVIEW r516, Lemma L7 (bound at every critical point; symmetric-pair equality class)

**Target:** `findings/bounds.md`, `#### Lemma L7` (line 43) through the next heading.
**Reviewer:** r516, cold, adversarial, analysis-only.
**Statement under audit:** at every critical point, $\theta\,\mathrm{tr}(W_-)+\mathrm{tr}(W_-^2)\le\|\mathrm{Ric}(W_-)\|^2+6\delta^2$, with equality iff the eigenspace ranges are bracket-graded (claimed = symmetric pair).

## Phase plan

0. Setup (log + this file).
1. Fix conventions against known anchors: $Q_{ab}=M_{ab}^2+(M^2)_{ab}$ on the diagonal locus; $\mathrm{tr}\,W^\#=-1$; $\theta_0(6)=\sqrt{10}/3$; $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$.
2. Read L7 verbatim.
3. Read L15 verbatim (refuted as stated; identity survives).
4. Derive the inequality cold; audit the four claimed ingredients, the constant 6, and the meaning of $W_-$.
5. Audit the equality case and the "precisely"/symmetric-pair identification (cf. L23 cap $r=n(n-2)/4$).
6. Audit the 11 citations.
7. Cross-check `findings/` for restatements with other constants and for later passages in `bounds.md` contradicting the block.
8. Verdict.

VERDICT: REFUTED, as stated. The inequality is true and I give a complete proof (F1); the equality-case clause, which the block calls its whole value, is false with a witness (F5).

## Findings

### F1, The inequality is TRUE, and I reconstructed the proof from cold. The four named ingredients are exactly right.

Fixing conventions from [conventions.md](../findings/conventions.md) and the anchors: $\operatorname{scal}(X)=2\operatorname{tr}_{\Lambda^2}(X)$; $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ (equivalently $Q(\mathrm{Id})=(n-1)\mathrm{Id}$); $(uu^{\mathsf T})\#(ww^{\mathsf T})=\tfrac12[u,w][u,w]^{\mathsf T}$ in the record's bivector normalisation. $W_-:=\tfrac12(|W|-W)\succeq0$, $\Pi_-$ the projection onto the strictly negative eigenspace $E_-$, $\mathfrak p:=E_+$, $\mathfrak m:=E_-$.

**Step 1 (partial trace + criticality), an exact identity, not an inequality.** $W^2=W_+^2+W_-^2$ with orthogonal supports, so $\operatorname{tr}(\Pi_-W^2)=\operatorname{tr}(W_-^2)$ and $\operatorname{tr}(\Pi_-W)=-\operatorname{tr}(W_-)$. Tracing $Q(W)=\theta W$ against $\Pi_-$ gives
$$\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)\;=\;-\operatorname{tr}(\Pi_-W^\#).$$

**Step 2 (bilinearity + rank-one positivity).** $W^\#=W_+^\#-2\,W_+\#W_-+W_-^\#$, and $A,B\succeq0\Rightarrow A\#B\succeq0$. Dropping the two nonnegative terms $\operatorname{tr}(\Pi_-W_+^\#),\operatorname{tr}(\Pi_-W_-^\#)$ and then $\Pi_-\preceq I$ against $W_+\#W_-\succeq0$:
$$-\operatorname{tr}(\Pi_-W^\#)\;\le\;2\operatorname{tr}\bigl(\Pi_-(W_+\#W_-)\bigr)\;\le\;2\operatorname{tr}(W_+\#W_-).$$

**Step 3 (L15's identity, three times).** $2\operatorname{tr}(W_+\#W_-)=\operatorname{tr}(W_+^\#)+\operatorname{tr}(W_-^\#)-\operatorname{tr}(W^\#)$. Since $W$ is Weyl, L15 at $R=W$ gives $\operatorname{tr}(W^\#)=-\operatorname{tr}(W^2)$ (this is the record's anchor $\operatorname{tr}W^\#=-1$ at unit norm, and it needs no criticality). Since $\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$, $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$ and $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, so L15 at $W_+$ and at $W_-$ gives $\operatorname{tr}Q(W_+)=\operatorname{tr}Q(W_-)$ **exactly**. Substituting,
$$2\operatorname{tr}(W_+\#W_-)=2\operatorname{tr}(W_-^2)+2\operatorname{tr}(W_-^\#)=\operatorname{scal}\bigl(Q(W_-)\bigr)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2 .$$

Chaining gives L7. **The four stated ingredients are each used and jointly sufficient; nothing else enters.** In particular the constant $6$ is L15's own dimension-free constant, entering only in the last equality, and it is not fitted.

**"Rank-one positivity of $\#$" is a theorem here, not an assumption.** From the structure-constant definition, $(uu^{\mathsf T})\#(ww^{\mathsf T})=\tfrac12[u,w][u,w]^{\mathsf T}\succeq0$; bilinearity plus the spectral decomposition of $A,B\succeq0$ gives $A\#B\succeq0$. I calibrated the constant independently two ways, against the record's Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$, and against $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, and they agree.

**Screen** (seconds, on objects built for the purpose; reported as a screen). With $\#$ calibrated by $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, the anchors come back: $\operatorname{tr}(\star^\#)=12$ and $\lVert\star\rVert^2=6$ at $n=4$; $\theta(\mathbb{CP}^2)=1.224745=\sqrt{3/2}$ with $\delta^2=0.111111=1/9$; $\theta(S^3\times S^3)=1.054093=\theta_0(6)=\sqrt{10}/3$. Criticality residual $\le4\times10^{-16}$ at each. Both sides of L7: $\mathbb{CP}^2$ $4/3=4/3$; $S^3\times S^3$ $2.4=2.4$; $S^2\times S^4$ $1.8=1.8$; $S^4\times S^4$ $24/7=24/7$; and **strict** at $(S^2)^3$, $1.2$ against $1.6$. Both equality cases I also did by hand.

### F2, What $W_-$ is, and the block never says. The reading is load-bearing and only one of the two makes the block's own claim true.

$W_-$ must be read as [conventions.md](../findings/conventions.md)'s **positive-semidefinite magnitude of the negative part**, $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$, so that $\operatorname{tr}(W_-)=\sum_{\lambda<0}\lvert\lambda\rvert>0$. Under the other reading ($W$ restricted to $E_-$, with negative eigenvalues), the right-hand side is unchanged (both its terms are quadratic in $W_-$ and blind to the sign) while the left-hand side drops by $2\theta\operatorname{tr}(W_-)$: at $\mathbb{CP}^2$ it becomes $-2/3$ against $4/3$. **The inequality is then still true and its equality class is empty**, which destroys the block's stated value without producing a visible error.

- The block is *formally* within [bounds.md](../findings/bounds.md)'s stated policy of quoting conventions rather than restating them, and conventions.md pins the sign globally.
- But conventions.md also records that a collision between the two signs *"refuted four lemmas in one day, because it is invisible at first order and bites only where a one-sided inequality is applied."* **L7 is precisely a one-sided inequality**, and the sign is the entire content of its left-hand side. **The block should name the sign.**
- $\mathrm{Ric}(W_-)$ is likewise the Ricci contraction of that psd operator read as an algebraic curvature tensor; $W_-$ satisfies neither Ricci-flatness nor the first Bianchi identity, which is exactly why $\lVert\mathrm{Ric}(W_-)\rVert^2$ and $\delta^2$ are nonzero. Correct as used.

### F3, "At every critical point" is not all it needs. Weyl-ness is used twice and is unstated.

Criticality $Q(W)=\theta W$ is used once (Step 1). But Step 3 uses **both** $\mathrm{Ric}(W)=0$ **and** the first Bianchi identity $\mathrm{Alt}(W)=0$, once for $\operatorname{tr}(W^\#)=-\operatorname{tr}(W^2)$, and again for $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$, $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$. The honest general statement, for **any** algebraic curvature operator $R$ with $Q(R)=\theta R$, is
$$\theta\operatorname{tr}(R_-)+\operatorname{tr}(R_-^2)\;\le\;\tfrac12\Bigl[\lVert\mathrm{Ric}R_+\rVert^2+\lVert\mathrm{Ric}R_-\rVert^2-\lVert\mathrm{Ric}R\rVert^2\Bigr]+3\Bigl[\lVert\mathrm{Alt}R_+\rVert^2+\lVert\mathrm{Alt}R_-\rVert^2-\lVert\mathrm{Alt}R\rVert^2\Bigr],$$
which collapses to L7's right-hand side exactly when $\mathrm{Ric}R=0$ and $\mathrm{Alt}R=0$. So the answer to *"criticality, or Ricci-flatness, or a sign condition on the spectrum"* is: **criticality plus Ricci-flatness plus first Bianchi; no sign condition on the spectrum, no unit-norm hypothesis** (the statement is homogeneous once $\theta$ is read as the multiplier in $Q(W)=\theta W$). Weyl-ness is the ambient assumption of $\mathcal W_n$, so this is a stated-hypothesis gap rather than an error.

### F4, The dependence on Observation L15 is clean: L7 takes only the surviving identity.

[Observation L15](../findings/problem.md) was refuted for claiming the Bianchi defect is the *only* obstruction to lifting Jäger's argument; the second obstruction is $X_{\mathrm{inv}}\succeq0$. **L7 uses none of that.** It uses only the displayed identity $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$, which is confirmed, and the definition $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$, matching [LEDGER.md](../findings/LEDGER.md)'s own account (*"L7 and L18 take the identity and the definition of $\delta^2$"*). I re-verified the identity independently at $R=\mathrm{Id}$ ($n(n-1)^2$ both sides) and at $R=\star$, $n=4$ ($\operatorname{scal}(\star^2+\star^\#)=12+24=36=6\lVert\star\rVert^2$), and the constant $6$ is dimension-free in both.

$\delta^2$ means the same thing in L7 as in L15's consumer, and it is the right spectral half: since $\mathrm{Alt}(W)=0$, $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, so naming the negative part costs nothing here.

**A pleasing consistency check the record already holds.** [ATTEMPTS.md](../ATTEMPTS.md) line 3962 records $S=\tfrac12\operatorname{tr}(X_{\mathrm{inv}})$ and $\operatorname{scal}(X_{\mathrm{inv}})=4S$, i.e. **L7 is exactly the trace of the very matrix inequality $X_{\mathrm{inv}}\succeq0$ that L15's audit refuted off the diagonal locus.** The trace survives where the matrix statement does not, and L7 proves the trace outright. That is the sharpest possible statement of "L7 takes only what survives".

### F5, The equality case: the bracket-grading half is right, the symmetric-pair half is FALSE, with a witness the block itself names

All three inequality steps are traces of psd operators against $\Pi_-$ or $I-\Pi_-$, so $\operatorname{tr}(\Pi_-X)=0$ with $X\succeq0$ iff $\operatorname{range}(X)\perp E_-$. Writing $\mathfrak p=E_+$, $\mathfrak m=E_-$, $\mathfrak z=\ker W$, and using $\operatorname{range}(A\#B)=\operatorname{span}\{[u,w]:u\in\operatorname{range}A,\;w\in\operatorname{range}B\}$, equality in L7 holds **exactly** when all three of
$$\textbf{(E1) } [\mathfrak p,\mathfrak p]\perp\mathfrak m,\qquad \textbf{(E2) } [\mathfrak m,\mathfrak m]\perp\mathfrak m,\qquad \textbf{(E3) } [\mathfrak p,\mathfrak m]\subseteq\mathfrak m .$$
This is a genuine derivation of the block's *"the eigenspace ranges are graded by the Lie bracket"*, and it reproduces the record's own conditional slack formula: dropping (E1) and (E3) leaves $S=\operatorname{tr}(P_{E_-}W_-^\#P_{E_-})$ under exactly the two bracket conditions [ungraded-slack.md](../findings/ungraded-slack.md) names, and my three terms are [ATTEMPTS.md](../ATTEMPTS.md)'s $T_1+2T_2+T_3$. **Independent agreement on the decomposition.**

**But (E1) and (E2) are conditions modulo the kernel, and the block drops the kernel.** They read $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p\oplus\mathfrak z$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p\oplus\mathfrak z$. Only when $\mathfrak z=0$ does $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m$ become a $\mathbb Z_2$-grading, i.e. $(\mathfrak{so}(n),\mathfrak p)$ a symmetric pair with $\mathfrak p$ the isotropy algebra. **The block states no trivial-kernel hypothesis, and its own named example violates it.**

**Witness, $W_{\mathbb{CP}^2}$ at $n=4$, unpadded, the block's own "$\mathbb{CP}^2$-type competitor".** Screened: critical to $3.4\times10^{-16}$, $\theta=\sqrt{3/2}$, $\delta^2=1/9$, L7 equality exact ($4/3=4/3$). Its spectrum is $(0.816497;\,-0.408248,-0.408248;\,0,0,0)$, so $\dim\mathfrak p=1$, $\dim\mathfrak m=2$, $\dim\mathfrak z=3$. Then $\mathfrak p\oplus\mathfrak m=\mathfrak{su}(2)_+$ is $3$-dimensional inside the $6$-dimensional $\mathfrak{so}(4)$, **not a $\mathbb Z_2$-grading of $\mathfrak{so}(4)$**, and $\mathfrak p$ is $1$-dimensional where $\mathbb{CP}^2$'s isotropy algebra $\mathfrak u(2)$ is $4$-dimensional. Padded to $n=6$ the same point is still critical ($5.6\times10^{-16}$) with the same equality and $\dim\mathfrak z=12$ inside a $15$-dimensional $\mathfrak{so}(6)$.

**[bounds.md](../findings/bounds.md) says this itself, 79 lines below the block**, in *"A correction to the record's reading of $W_{\mathbb{CP}^2}$"*: *"$\mathfrak p\oplus\mathfrak m\cong\mathfrak{su}(2)$ is a graded 3-dimensional subalgebra while $\mathfrak{so}(8)$ is 28-dimensional and the 25-dimensional kernel is unassigned … $S_{\mathfrak{mpp}}=0$ certifies a grading of the span of the nonzero eigenvectors, not of $\mathfrak{so}(n)$."* Its [Lemma L106](../findings/bounds.md) carries the missing hypothesis explicitly (*"with trivial kernel"*) and its measured table records *"$\mathbb{CP}^2$ is the self-dual exception, with a 3-dimensional kernel and $\mathfrak p\subsetneq\mathfrak k(W)$."* **This is the fifth-plus instance of the session's pattern: a block refuted by a passage below it in its own file.**

**The converse half of the "precisely" also fails, in the other direction.** A compact symmetric pair $(\mathfrak{so}(n),\mathfrak k)$ does not give equality: one additionally needs $W$'s spectral splitting to *coincide* with the pair, $E_+=\mathfrak k$ and $E_-=\mathfrak m$. [Lemma L23](../findings/ungraded-slack.md) makes the gap concrete, within the subalgebra family a symmetric pair is critical only *at* the cap $r=n(n-2)/4$, and $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ is a symmetric pair at $r=31$ against $30$. So "symmetric pair" is strictly the wider class, in both directions.

**What survives, stated positively.** Equality in L7 holds exactly when (E1)–(E3) hold; when $\ker W=0$ that is exactly the statement that $\mathfrak{so}(n)=E_+\oplus E_-$ is a $\mathbb Z_2$-grading, i.e. $(\mathfrak{so}(n),E_+)$ is a compact symmetric pair with $E_+$ its isotropy algebra. **The repair is one clause: add $\ker W=0$, and say the pair is the one carried by $W$'s own spectral splitting.**

### F6, "It fails strictly at the low-value ones" is false, with a witness

Screened at $n=6$: $S^2\times S^4$ is critical to $3.2\times10^{-16}$ at $\theta=0.968246$ (**below $1$**), with $\delta^2=0$ and **exact equality**, $1.8=1.8$. Its $E_+=\Lambda^2V_1\oplus\Lambda^2V_2=\mathfrak{so}(2)\oplus\mathfrak{so}(4)$ has $r=7$ against the cap $n(n-2)/4=6$, so it is also a live instance of the L23 point that L7-equality reaches symmetric pairs strictly over the cap. The sentence *"Every known critical point with value above $1$ satisfies it … and it fails strictly at the low-value ones"* is safe in its first half and **refuted in its second**. What is true (and is what the block needs), is the *graded/ungraded* split: $(S^2)^3$ at $\theta=0.645497$ is critical, zero-defect, and strictly inside ($1.2$ against $1.6$), matching [Observation L12](../findings/ungraded-slack.md)'s $(S^m)^3$ witness.

### F7, The block advertises a proof it does not contain, and two of the eleven citations overreach

**No proof is present.** The heading reads *"canonical statement and proof"*, and the block is a single paragraph whose entire proof content is the sentence *"the proof needs only bilinearity of $\#$, its rank-one positivity, a partial trace, and the polarized identity of Observation L15."* That is an ingredient list, not an argument: it does not say which trace, in which order, or where the constant $6$ comes from. The ingredient list is **accurate** (I reconstructed a complete proof from it and nothing else) but the record's own standard, applied to [Lemma L1](../findings/problem.md) this session (*"the first version claimed this block held a proof … the block carried three sentences and no argument"*), condemns it. The three-line chain of F1 should be transcribed into the block.

**The eleven citations.** By what each takes:

| citation | takes | verdict |
| --- | --- | --- |
| [findings/bounds.md:43](../findings/bounds.md) | the block itself |, |
| [findings/INDEX.md:42](../findings/INDEX.md) | listing only | fine |
| [results.md:330](../results.md) | verbatim mirror of the block | inherits F5 and F6 |
| [results.md:122](../results.md) | *"with equality exactly on the compact symmetric pairs"* | **overreaches**, same false clause, and stated without even the bracket-grading hedge |
| [results.md:366](../results.md) = [ungraded-slack.md:285](../findings/ungraded-slack.md) (Observation L12) | the inequality only, as $S\ge0$ | fine; *"Lemma L7's inequality $S\ge0$ is untouched"* is right |
| [ungraded-slack.md:290](../findings/ungraded-slack.md) | the inequality only | fine |
| [ATTEMPTS.md:3962](../ATTEMPTS.md) | the inequality, as $\operatorname{scal}(X_{\mathrm{inv}})\ge0$ | fine, and confirms the $\operatorname{scal}=2\operatorname{tr}$ normalisation independently |
| [LEDGER.md:266](../findings/LEDGER.md) | that L7 takes L15's identity and $\delta^2$ | correct; but its link **[L7](target.md) points at the wrong file**, the block is in bounds.md, as the same file's line 624 says |
| [LEDGER.md:624](../findings/LEDGER.md) | provenance only | fine |
| [graded-half.md:201](../findings/graded-half.md) | *"matching Lemma L7's closed form, which puts it at the family's peak"* | **misattribution, L7 has no closed form.** The closed form pinning a graded point by its pair's dimensions is [Lemma L8](../results.md); L7 is an inequality with an equality case. |
| [nondegeneracy.md:407](../findings/nondegeneracy.md) | the slack expression, numerically | fine, and independently reports slack $=0$ at $\mathbb{CP}^{3,4,5}$, consistent |

**No citation rests on the refuted half of L15.** Two rest on claims L7 does not support: results.md:122 (the symmetric-pair equality class, in its strongest form) and graded-half.md:201 (a "closed form").

### F8, Cross-checks

- **Constant.** Every restatement in the record carries $6$: [ungraded-slack.md:178, 286](../findings/ungraded-slack.md), [results.md:366](../results.md), [nondegeneracy.md:407](../findings/nondegeneracy.md). **No competing constant anywhere.** I re-derived $6$ from L15 at two anchors and it is dimension-free. The $24\lVert\mathrm{Alt}(W_-)\rVert^2$ in L15's own block is Jäger's master inequality at a different normalisation ($4\times$), not a competing value for L7's term.
- **[Lemma L132](../findings/ungraded-slack.md), withdrawn**, states $S=2\operatorname{tr}(W_-^\#)+\operatorname{tr}(W_-^2)-\theta\operatorname{tr}(W_-)$. That is **exactly my Step 3 rearranged and it is true**, it was withdrawn for being dominated, not for being wrong, and its agreement with an independently rebuilt derivation is a check on both.
- **Later sections of [bounds.md](../findings/bounds.md).** No later section restates the bound. Two bear on the equality clause and both cut against it: L106's *"with trivial kernel"* and the withdrawn-correction block's *"a grading of the span of the nonzero eigenvectors, not of $\mathfrak{so}(n)$"*. See F5.


---

## VERDICT: REFUTED

**Refuted as stated, and the refuted part is the part the block calls its value.** The sentence *"equality holds precisely when the eigenspace ranges are graded by the Lie bracket, which is exactly the condition defining a compact symmetric pair with $E_+$ the isotropy algebra"* is false in both directions, and the witness against it is the block's own named example.

**The witness.** $W_{\mathbb{CP}^2}$ at $n=4$: critical to $3.4\times10^{-16}$, $\theta=\sqrt{3/2}$, $\delta^2=1/9$, **L7 equality exact** ($4/3=4/3$), and $\dim E_+=1$, $\dim E_-=2$, $\dim\ker W=3$, so $E_+\oplus E_-$ is $3$-dimensional inside the $6$-dimensional $\mathfrak{so}(4)$. There is no $\mathbb Z_2$-grading of $\mathfrak{so}(4)$ here, and $E_+$ is $1$-dimensional where $\mathbb{CP}^2$'s isotropy algebra is $4$-dimensional. [bounds.md](../findings/bounds.md) states this itself 79 lines below the block, and its [Lemma L106](../findings/bounds.md) carries the missing *"with trivial kernel"* hypothesis.

**The broken step.** Equality forces (E1) $[\mathfrak p,\mathfrak p]\perp\mathfrak m$, (E2) $[\mathfrak m,\mathfrak m]\perp\mathfrak m$, (E3) $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$, conditions **modulo $\ker W$**. The block reads them as conditions in $\mathfrak p\oplus\mathfrak m=\mathfrak{so}(n)$, dropping the kernel. In the other direction, a symmetric pair does not give equality without $W$'s spectral splitting coinciding with it; [Lemma L23](../findings/ungraded-slack.md)'s cap makes that gap concrete.

**A second false sentence, separately witnessed.** *"It fails strictly at the low-value ones"*, $S^2\times S^4$ at $n=6$ is critical to $3.2\times10^{-16}$ with $\theta=0.968246<1$ and **exact equality** (F6).

### What survives, and it is most of the block

- **The inequality is TRUE at every critical point of $\mathcal W_n$**, and F1 gives a complete four-line proof from cold. The four ingredients the block names are each used and are jointly sufficient; "rank-one positivity of $\#$" is a theorem, not an assumption; and the constant $6$ is L15's, dimension-free, entering only at the final equality. Verified as equality at $\mathbb{CP}^2$, $S^3\times S^3$, $S^2\times S^4$, $S^4\times S^4$ and strictly at $(S^2)^3$.
- **The bracket-grading half of the equality case is TRUE**, in the exact form (E1)–(E3), and it reproduces the record's own conditional slack formula and ATTEMPTS.md's $T_1+2T_2+T_3$ decomposition independently.
- **L7 takes only what survives of L15**, the identity and the definition of $\delta^2$. Nothing rests on L15's refuted consequence. Indeed L7 is exactly the *trace* of the refuted matrix inequality $X_{\mathrm{inv}}\succeq0$, and the trace holds outright.

### The repair, as a positive statement

Replace the equality sentence with:

> Equality holds exactly when $[E_+,E_+]\perp E_-$, $[E_-,E_-]\perp E_-$ and $[E_+,E_-]\subseteq E_-$, the eigenspace ranges graded by the Lie bracket modulo $\ker W$. **When $\ker W=0$** this says exactly that $\mathfrak{so}(n)=E_+\oplus E_-$ is a $\mathbb Z_2$-grading, i.e. that $(\mathfrak{so}(n),E_+)$ is a compact symmetric pair with $E_+$ its isotropy algebra; with $\ker W\ne0$ it grades only the span of the nonzero eigenvectors, and $E_+$ need not be the isotropy algebra, $W_{\mathbb{CP}^2}$ being the standing example.

and further:

1. State the hypotheses in full: $Q(W)=\theta W$ **and** $W\in\mathcal W_n$ (Ricci-flat, first Bianchi). Both Weyl conditions are used, twice (F3).
2. Name the sign of $W_-$ in the block. The right-hand side is blind to it; the left-hand side is the whole statement (F2).
3. Transcribe the actual proof, the heading promises one and the block has an ingredient list (F7).
4. Replace *"it fails strictly at the low-value ones"* with the graded/ungraded split it actually establishes (F6).
5. Fix [results.md:122](../results.md) (*"equality exactly on the compact symmetric pairs"*), [graded-half.md:201](../findings/graded-half.md) (*"Lemma L7's closed form"*, L7 has none; that is L8), and [LEDGER.md:266](../findings/LEDGER.md)'s `[L7](target.md)` link (F7).

**Suggested relabelling, on this session's own precedent.** L15 was refuted as stated, relabelled `Observation`, and its identity kept. L7's inequality is stronger than that (it is a proved theorem with a proved equality criterion) so the number should stay a **Lemma**, with the statement narrowed to what is proved and the symmetric-pair reading demoted to the corollary it is, under $\ker W=0$.
