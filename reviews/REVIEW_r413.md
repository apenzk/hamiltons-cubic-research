# Reviewer r413, Gate 2 on "The grant's three terms, after moving $\#I$ off one argument"

*Cold audit of the last section of [ATTEMPTS.md](../ATTEMPTS.md), 2026-09-03. Every step re-derived from the definitions in [boehm-wilking-2008-space-forms/notes.md](../references/boehm-wilking-2008-space-forms/notes.md) and [isotropy-cap.md](../findings/isotropy-cap.md) before the section was read as an argument. **Analysis only**; one screen was run on objects built for the purpose and is labelled as a screen.*

## Verdict in one line

**The identity is CORRECT and the factor $2$ is dropped, but the rewrite is the definition of $J_5$ with the $\mathrm{Ric}$ moved to the other argument, and step 3 is inert.** Two of the three flagged failure modes come out clean; the third (step 3) is a non-argument, and the "$\mathrm{Ric}$ and $\mathrm{Ric}^*$ gone" claim is presentation rather than content. **What survives is one thing the section did not write down: $\lvert W\rvert$ can be replaced by $W_-$ throughout, and $W$ cancels identically.**

| Step | Verdict |
| --- | --- |
| **1**, full symmetry moves $\#I$ off $\lvert W\rvert$ | **CORRECT**, and the $\#$-part *is* symmetric on its own. But the move is **not novel**: it is the record's own $\langle A\#B,C\rangle=\tfrac12\sum T_{abc}A_aB_bC_c$, and relations (A) and (B) are read off it |
| **2**, the three-term grant | **IDENTITY CONFIRMED, factor $2$ DROPPED.** The display equals $J_5/2$. As an inequality it is equivalent; as a value it is half |
| **3**, the split into two $\#$-traces | **INERT.** "$a-b$ with $a,b\ge0$" constrains nothing, the same split applies to the *first* term, and the record already holds strictly stronger operator-level statements. Missing hypothesis $\theta\ge0$ |
| **Decisive**, is it Result 5 / Theorem A? | **Neither, but it is the definition of $J_5$ restated.** $J_5=\langle\mathrm{Ric}(X_{\mathrm{inv}}),\mathrm{Ric}(\lvert W\rvert)\rangle$ is symmetric in its two arguments, and the three-term form is [Lemma L131](../findings/isotropy-cap.md) applied to $X_{\mathrm{inv}}$ instead of to $\lvert W\rvert$. One line puts $\mathrm{Ric}$ back |

## Step 1, the $\#$-part of $\mathrm{tri}$ is symmetric on its own, and both normalisation traps come out clean

**Re-derived, not read.** Write $c_{\alpha\beta\gamma}=\langle[b_\alpha,b_\beta],b_\gamma\rangle$, totally antisymmetric because the inner product on $\mathfrak{so}(n)$ is $\mathrm{ad}$-invariant. Then the displayed sum of [eq. 5](../references/boehm-wilking-2008-space-forms/notes.md) is

$$f(R_1,R_2,R_3)=\mathop{\mathrm{tr}}\big(2(R_1\#R_2)R_3\big)=\sum c_{\alpha'\beta'\gamma'}c_{\alpha\beta\gamma}(R_1)_{\alpha'\alpha}(R_2)_{\beta'\beta}(R_3)_{\gamma'\gamma}.$$

Transposing two arguments and renaming the corresponding index pairs flips **both** copies of $c$, so the two signs cancel and $f$ is fully symmetric **on its own**, independently of the $R_1R_2+R_2R_1$ part. The notes' word "manifestly" is earned. **So $\langle X,\lvert W\rvert\#I\rangle=\mathop{\mathrm{tr}}\big((X\#\lvert W\rvert)I\big)$ is valid.**

**The two normalisation traps the brief flagged do not bite.**

- **The pairing is $\mathop{\mathrm{tr}}(AB)$, not $\tfrac12\mathop{\mathrm{tr}}(AB)$.** The $\tfrac12$ lives on $\Lambda^2=\mathfrak{so}(n)$, $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}(AB)$, exactly the normalisation making $e_i\wedge e_j$ orthonormal ([ATTEMPTS.md](../ATTEMPTS.md) line 266), and it is spent making the operator trace over the $N=\binom n2$-dimensional pair basis the right one. On *operators* the record pairs by [frob](../scripts/lib/weyl_decomposition.py), `np.sum(A*B)` over the $i<j$ pair basis, i.e. $\mathop{\mathrm{tr}}(AB)$. **No factor is owed here.** (Check: $A=E_{ij}-E_{ji}$ gives $-\tfrac12\mathop{\mathrm{tr}}(A^2)=1$.)
- **$I$ is the identity operator and the identity curvature operator at once**, in this normalisation and only in it, Böhm–Wilking fix it by "the round sphere of radius one has curvature operator the identity", and the record's $I\#I=(n-2)I$ was checked against `np.eye(N)` at $n=6$ to $0$ exactly ([LIT-invariants.md](LIT-invariants.md)). So $\mathop{\mathrm{tr}}\big((X\#\lvert W\rvert)I\big)=\mathop{\mathrm{tr}}(X\#\lvert W\rvert)$ is the identity map inside the trace, and the trap the brief called "the likeliest error" is not present.

**But the use is not new.** [LIT-invariants.md](LIT-invariants.md) states the record's own convention as

$$\langle A\,\#\,B,\,C\rangle=\tfrac12\sum_{abc}T_{abc}A_aB_bC_c,$$

which is **visibly symmetric in $A,B,C$ because $T_{abc}$ is**, and it is *that* symmetry from which relations (A) ($I\#I=(n-2)I$) and (B) ($W\#I=-W$) are read off. The same file records the whole monomial family as $2\langle W^p\#W^q,W^r\rangle$ with a classification theorem stated in those symbols, and [bounds.md](../findings/bounds.md) uses $S_{22}=2\mathop{\mathrm{tr}}(W^2\#W^2)$. **Moving $\#I$ across the pairing is what the record has been doing since relations (A) and (B) were derived.** The section's own screen looked at [problem.md](../findings/problem.md) only, where the symmetry is used for isotypic expansion of $\langle Q(R),R\rangle$; the hit it needed is in [LIT-invariants.md](LIT-invariants.md), in exactly this shape.

## Step 2, the identity holds, the factor $2$ is dropped, and the record says so three lines from where the section got $H$

$J_5=\langle X_{\mathrm{inv}},H\rangle$ with $H=2\big(\lvert W\rvert+\lvert W\rvert\#I-3\,\mathrm{Alt}(\lvert W\rvert)\big)$ gives

$$J_5=2\Big[\langle X_{\mathrm{inv}},\lvert W\rvert\rangle+\mathop{\mathrm{tr}}\big(X_{\mathrm{inv}}\#\lvert W\rvert\big)-3\langle X_{\mathrm{inv}},\mathrm{Alt}(\lvert W\rvert)\rangle\Big],$$

so **the section's display is $J_5/2$, not $J_5$.** As an inequality the two are equivalent and the section's conclusion is unharmed; as a *quantity* the display is half, and any successor who substitutes it into the lifted §3.3 master identity of [Result 1](../ATTEMPTS.md) (where $J_5$ appears additively against $J_4$ and $\theta r^2$), will be out by a factor $2$ in a place that does not announce itself. [Lemma L131](../findings/isotropy-cap.md) carries the factor explicitly ("with the factor forced"), in the same paragraph the section drew $H$ from, so this is a transcription loss rather than a derivation error.

**Confirmed independently, by a route that never touches $H$.** Apply [L131](../findings/isotropy-cap.md) to $X_{\mathrm{inv}}$ rather than to $\lvert W\rvert$: $\mathrm{Ric}^*(\mathrm{Ric}(X))=2\big(X+X\#I-3\,\mathrm{Alt}(X)\big)$. Pair with $\lvert W\rvert$, use adjointness on the left, step 1's symmetry on the middle ($\langle X\#I,\lvert W\rvert\rangle=\mathop{\mathrm{tr}}(X\#\lvert W\rvert)$), and $\mathrm{Alt}$ being an orthogonal projection on the right ($\langle\mathrm{Alt}(X),\lvert W\rvert\rangle=\langle X,\mathrm{Alt}(\lvert W\rvert)\rangle$). The same three terms come out, times $2$, equal to $\langle\mathrm{Ric}(X),\mathrm{Ric}(\lvert W\rvert)\rangle=J_5$. **Two derivations, one from each argument, agreeing.**

## Step 3, the split is inert, and it is weaker than what the record already proves

**The PSD facts check out.** $W_-\succeq0$ by construction, so $W_-^2\succeq0$, and $\theta W_-\succeq0$ **provided $\theta\ge0$**, an unstated hypothesis. The record catalogues critical points at $\theta=0$ and at $\theta$ down to $0.055$ ([graded compression Result 2](../ATTEMPTS.md), [Result 5](../ATTEMPTS.md)), so "PSD for the same reason" is false as written and true on the band $\theta\ge\sqrt{3/2}$. And $A,B\succeq0\Rightarrow A\#B\succeq0\Rightarrow\mathop{\mathrm{tr}}(A\#B)\ge0$ **is** true and **is** on record: the rank-one identity $(uu^{\mathsf T})\#(vv^{\mathsf T})=\tfrac12[u,v][u,v]^{\mathsf T}$ appears in [Result 5(a)](../ATTEMPTS.md), in the graded-compression proof, and at [ATTEMPTS.md](../ATTEMPTS.md) lines 1194 and 1228.

**But the conclusion drawn from it is empty, on three counts.**

1. **Every real number is a difference of two nonnegative numbers.** Writing $X_{\mathrm{inv}}=4C-2(\theta W_-+W_-^2)$ as PSD minus PSD and tracing each against $\lvert W\rvert$ produces $a-b$ with $a,b\ge0$ and no relation between them. That is not "one comparison between two sharp-traces"; it is the absence of a comparison.
2. **The same split applies verbatim to the first term.** $\langle X_{\mathrm{inv}},\lvert W\rvert\rangle=4\mathop{\mathrm{tr}}(C\lvert W\rvert)-2\mathop{\mathrm{tr}}\big((\theta W_-+W_-^2)\lvert W\rvert\big)$, both parts $\ge0$ since $\mathop{\mathrm{tr}}(AB)=\mathop{\mathrm{tr}}(A^{1/2}BA^{1/2})\ge0$ for $A,B\succeq0$. So the property the section calls out as making the middle term "the useful one" is shared by the first term and distinguishes nothing.
3. **The record holds strictly more, at operator level.** [Result 5(a)](../ATTEMPTS.md) proves $P_+X_{\mathrm{inv}}P_+=4P_+(W_+\#W_-)P_+\succeq0$, $P_-X_{\mathrm{inv}}P_-=2P_-(W_+^\#+W_-^\#)P_-\succeq0$, $P_0X_{\mathrm{inv}}P_0\succeq0$, three *operator* inequalities, by the same $\#$-positivity calculus, which the graded-compression [Result 3](../ATTEMPTS.md) reproves in one line "via $X_{\mathrm{inv}}=4W_+\#W_--2\theta W_--2W_-^2$", i.e. from the identical splitting. Step 3 applies the same tool to the same decomposition and lands one level lower.

**And "the sign of the middle term is exactly the comparison the grant was always about" is false.** The grant is the sign of the *sum* of three terms. Making the middle term decisive requires the other two to be controlled, and neither is: the third has no sign at all, $\mathrm{Alt}(\lvert W\rvert)$ is traceless ($\Lambda^4\perp\langle I\rangle$) and indefinite, so no PSD split exists for it. **This repeats, in new dress, the overstatement Gate 2 corrected one round earlier**: [r411](REVIEW_r411.md)/[r412](REVIEW_r412.md) item (5), "one term linear in the defect is overstated, $\langle X_{\mathrm{inv}},\mathrm{Alt}(\lvert W\rvert)\rangle$ is bilinear, and nothing bounds $X_{\mathrm{inv}}$ by $\delta$."

## The decisive question, not Result 5, not Theorem A, but the definition of $J_5$ read from the other side

- **It is not [Theorem A](../ATTEMPTS.md)**, which is the structural closed form $X_{\mathrm{inv}}=4C-2\theta W_--2W_-^2=2G-2(\theta W_+-W_+^2)$ and $X_{\mathrm{cross}}=4C_{\mathrm{cross}}$.
- **It is not [Result 5](../ATTEMPTS.md)** either: Result 5's decomposition is the block/cross split of $J_5$, which the three-term form does not perform.
- **But it is $J_5$'s own definition.** $J_5=\langle\mathrm{Ric}(X_{\mathrm{inv}}),\mathrm{Ric}(\lvert W\rvert)\rangle$ is a **symmetric** bilinear form in $(X_{\mathrm{inv}},\lvert W\rvert)$, and each of the three terms is separately symmetric in those two arguments. The section reached the form by applying [L131](../findings/isotropy-cap.md) to $\lvert W\rvert$ and then moving $\#I$; §Step 2 above walks the same road backwards by applying L131 to $X_{\mathrm{inv}}$. **So the three-term expression is L131 stated at whichever argument you please, and $\mathrm{Ric}$ is one line away in both directions.** The claim that "$\mathrm{Ric}$ and $\mathrm{Ric}^*$ are gone from the statement entirely" is true of the symbols and false of the content.

That is the **seventh** instance of the session's pattern, in its softest form: not a duplicate of a numbered result, but a restatement of the object being studied.

## The one thing that is new, and it is the section's own step carried one move further

**$\lvert W\rvert$ can be replaced by $W_-$, and $W$ cancels identically.** Use $\lvert W\rvert=W+2W_-$ with the record's two published facts, relation (B), $W\#I=-W$ ([Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md)), and $\mathrm{Alt}(W)=0$ since $W\in S^2_B$:

$$\langle X,\lvert W\rvert\rangle=\langle X,W\rangle+2\langle X,W_-\rangle,\qquad \langle X,\lvert W\rvert\#I\rangle=-\langle X,W\rangle+2\langle X,W_-\#I\rangle,\qquad \mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-).$$

The $\langle X,W\rangle$ terms cancel, leaving

$$\boxed{\ J_5\;=\;4\Big[\big\langle X_{\mathrm{inv}},W_-\big\rangle+\mathop{\mathrm{tr}}\big(X_{\mathrm{inv}}\#W_-\big)-3\big\langle X_{\mathrm{inv}},\mathrm{Alt}(W_-)\big\rangle\Big]\ }$$

**Why this is the better form, and not merely a shorter one.**

- **It states the defect at its native argument.** $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$, so the third term is $-12\langle X_{\mathrm{inv}},\mathrm{Alt}(W_-)\rangle$ with $\delta$'s own object in it. The $\lvert W\rvert$-form invites exactly the comparison [r411](REVIEW_r411.md)/[r412](REVIEW_r412.md) trap (4) fenced (*"a constant stated at $\lvert W\rvert$ is not comparable with one stated at $W_-$"*) and the section duly ends by inviting it ("the constant $3$ sits beside $\mathop{\mathrm{tr}}D=6\lVert\mathrm{Alt}\rVert^2$"). In the $W_-$-form the two constants are at the same argument.
- **$W_-$ is the low-rank object the record has already studied.** Its rank is the number of negative eigenvalues of $W$, the subject of [stratum-two-negative.md](../findings/stratum-two-negative.md) and the $\dim\mathfrak m\le2$ work, whereas $\lvert W\rvert$ has full support. Every $\#$-trace against $W_-$ is a sum over that small rank by the rank-one formula.
- **It localises the whole difficulty in one pairing.** By step 1's symmetry, $\mathop{\mathrm{tr}}(X\#W_-)=\langle X,W_-\#I\rangle$, and $\#I$ acts by a **known scalar** on each summand of $S^2_B$ ($n-2$, $\tfrac{n-4}2$, $-1$) and by $2$ on $\Lambda^4$. **$W_-$ is the only argument in the grant that leaves the Bianchi subspace**, so $\langle X_{\mathrm{inv}},W_-\#I\rangle$ is precisely where Lemma 2.1 stops evaluating, the grant's difficulty is that one pairing, and nothing else. The section's own observation that "$\mathop{\mathrm{tr}}(A\#B)$ is a single scalar invariant of a pair, and the record already computes objects of exactly that shape" is therefore **backwards as encouragement**: whenever an argument is $W$ or $I$ the $\#$-trace *collapses* by relation (A)/(B) and carries no new information; it survives only on $W_-$, which is the defect.

**Screened.** Against [INDEX-traps.md](../findings/INDEX-traps.md) by mechanism first, [post F54](../findings/INDEX-traps.md) fences re-bounding $H$ by trace data, and this bounds nothing, it substitutes an exact decomposition. Then by expression: `grep` over [findings/](../findings/) finds no occurrence of $W_-\#I$ or of the $W_-$-form of the grant; [isotropy-cap.md](../findings/isotropy-cap.md) carries $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$ and [notes.md](../references/boehm-wilking-2008-space-forms/notes.md) carries $W\#I=-W$, in files that do not cite each other for this purpose.

**Screen (labelled as a screen, not as evidence).** Both identities were checked on objects built for the purpose at $n=5,6$, a random unit Weyl operator from the Bianchi-nullspace construction, against a random symmetric $X$ and against the $X_{\mathrm{inv}}$-shaped $4(W_+\#W_-)-2\theta W_--2W_-^2$. The section's three-term expression times $2$ matched $\langle\mathrm{Ric}(X),\mathrm{Ric}(\lvert W\rvert)\rangle$ to $\le1.2\times10^{-14}$, the boxed $W_-$-form to $\le2.0\times10^{-14}$, and the section's display as written differed from $J_5$ by exactly a factor $2$ in all four cases. Criticality was never used, consistent with both identities being unconditional in $X$. *A screen of an identity that is proved above line by line; it decides nothing on its own.*

## What a successor should and should not take from the section

- **Take**: the boxed $W_-$-form, and the reading that the grant's whole difficulty is the single pairing $\langle X_{\mathrm{inv}},W_-\#I\rangle$, the one place Lemma 2.1's scalars run out.
- **Do not take**: "the sign of the middle term is exactly the comparison the grant was always about" (false, three terms, and the third has no sign), the PSD-minus-PSD split (inert, and weaker than [Result 5(a)](../ATTEMPTS.md)), or the displayed expression as a value of $J_5$ (it is $J_5/2$).
- **Fix in place**: restore the factor $2$; add $\theta\ge0$ to step 3; and cite [LIT-invariants.md](LIT-invariants.md) for the symmetry, since the section's novelty screen looked only at [problem.md](../findings/problem.md) and the hit is elsewhere.
