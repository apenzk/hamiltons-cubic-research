# Round L71, saturation forces the balanced sphere product

**Id:** L71 · **Date:** 2026-09-07 · **Verifiers:** v215, v216, v217 · **Brief:** [BRIEF_L71.md](BRIEF_L71.md)

## Sources, verbatim

| passage | source |
|---|---|
| the canonical entry | [results.md](../results.md) lines 617-623 |
| the landscape statement | [results.md](../results.md) line 196 |
| the block | [findings/bounds.md](../findings/bounds.md) lines 605-638 |

## The findings from phase 0

**The statement sits inside a blockquote, in a block whose other blockquotes are corrections.** *So the record's own formatting no longer distinguishes what the lemma says from what was found wrong with it*, and a reader scanning the file meets the theorem in the shape the file uses for defects.

**One blockquote lists four defects "in the write-up above" and the write-up above still stands.** *That is the partial-repair shape [ROUND_L30](ROUND_L30.md) met*, and it is worse here because one of the four is a **circularity**: *"$W$ has exactly two eigenvalues, derived, not assumed"* is said to have been the hypothesis restated, rescued only by the ideal argument. **Whether the rescue works is the round's central question.**

**A phrase is recorded as having outlived what it described.** *"The 'two routes' this paragraph named were deleted from the block and the phrase outlived them"*, so the uniqueness step is a single route ending in Cartan's classification, and **the record elsewhere holds that Cartan answers a different question**, classifying involutions up to $\mathrm{Aut}(\mathfrak g)$ where the lemma consumes $SO(n)$-conjugacy.

**A residual is recorded and then disowned in the same sentence**, $7\times10^{-16}$, *"measured at the theorem's own output points, where $\mathfrak h=[\mathfrak m,\mathfrak m]$ already holds, so it is the noise of a tautology rather than corroboration."* **The round is asked whether any numerical claim in the block carries weight, or whether all of them are of this kind.**

## What the verifiers are asked beyond the standing list

Whether saturation really gives the three bracket relations; whether $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]$ is a subalgebra and then an **ideal**, and whether the Jacobi step shown is enough; whether $\mathfrak r=0$ follows and where simplicity of $\mathfrak{so}(n)$ enters; **whether the two-eigenvalue conclusion is derived or is the hypothesis restated**; whether $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ follows from $\mathfrak h=[\mathfrak m,\mathfrak m]$ as claimed; whether $\dim\mathfrak h=\tfrac{n(n-2)}4$ is derived and whether it forces $t=0$ at every even $n$; and **whether the uniqueness step's use of Cartan is sound given that Cartan classifies up to $\mathrm{Aut}(\mathfrak g)$.**

**And the exception**: whether $n=4$ is the sole one and whether the reason given ($\mathfrak{so}(4)$ being the only non-simple $\mathfrak{so}(n)$), is the whole of it. *The statement says $n\ge5$; ask what happens at $n=3$.*

## Adjudication

**Verdicts: [v215](VERIFY_v215.md) and [v216](VERIFY_v216.md) `PROVEN, hypotheses corrected`, [v217](VERIFY_v217.md) `GAP`. Round verdict: `PROVEN, hypotheses corrected`, repaired, impact `NARROWS`.**

### The central question, answered in the block's favour by all three

**The two-eigenvalue conclusion is derived, not assumed, and the ideal argument is what makes it one.** Each verifier traced every input to $\mathfrak r=0$ backwards and none consumes it: the three bracket relations come from $D(v)=0$ with a *strict* corner minimum needing only $\lambda_{\min}<0<\lambda_{\max}$; the subalgebra, centralisation and normalisation consume those relations and Jacobi alone. **$\mathfrak r$ appears only as a set on which brackets with $\mathfrak m$ vanish, a conclusion throughout.** *And $\mathfrak h$-normalisation does not use $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, which is what keeps the symmetric-pair repair non-circular.* So the recorded defect (i) was diagnosed correctly **and** repaired correctly.

| id | step attacked | mechanism | support | outcome |
|---|---|---|---|---|
| **C1** | the whole chain to $\mathfrak r=0$ | independent re-derivation | 3/3 | `CONFIRMED`, no circularity |
| **C2** | the $n=8$ determinant route | innerness does not give $O(8)$-conjugacy | 3/3 | **`REFUTED`**, deleted |
| **C3** | *"by two independent routes"* | only the weight route closes the step | 3/3 | `CONFIRMED`, corrected to one |
| **C4** | $\mathrm{Aut}(\mathfrak{so}(n))=\mathrm{Ad}(O(n))$ at $n\ne8$ | load-bearing at every even $n$, cited nowhere | 2/3 | `CONFIRMED`, stated, with its source |
| **C5** | the final identification of $W$ | asserted; the record points back here for it | 1/3 | **`HYPOTHESIS-DEBT`**, filed |
| **C6** | $\lVert W\rVert=1$, $\lambda_{\min}<0<\lambda_{\max}$ | load-bearing, in neither statement | 2/3 | `CONFIRMED`, both now stated |
| **C7** | *"$T$'s mass splitting evenly"* | unused **and** unproved | 1/3 | `CONFIRMED`, deleted |
| **C8** | the *"Verified structure"* paragraph | every figure measured where the conclusion holds | 3/3 | `CONFIRMED`, rewritten |
| **C9** | *"defect"* against *"deficiency"* | differ by $\lvert\lambda_{\min}\rvert$ inside one block | 1/3 | `CONFIRMED`, tabled |

### C2, and the block printed its own counterexample two clauses later

The route read: *$\mathrm{Ad}(\mathrm{diag}(-1_4,1_4))$ has $\det=+1$ and is **inner**, so Cartan's classification up to $\mathrm{Aut}$ already delivers $SO(8)$-conjugacy.* **Innerness does not give $O(8)$-conjugacy.** $\mathrm{diag}(-1_2,1_6)$ and an orthogonal complex structure $J$ are both inner with $\det=+1$, are $\mathrm{Aut}$-conjugate, and are **not** $O(8)$-conjugate, $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ preserves a $2$-plane while $\mathfrak u(4)$ acts irreducibly. *Three verifiers produced that pair independently, and it is the pair the same paragraph calls "moving", one sentence earlier.*

**The conclusion survives on the weight route, which all three verified from the $D_4$ weights**: $\mathrm{diag}(I_4,-I_4)$ has pattern $(1^4,(-1)^4)$ on $V$, $S^+$ and $S^-$ alike. *That route carries $n=8$ alone, so "two independent routes" was the overstatement the block's own defect (iii) describes, the same species, one paragraph later.* **The $O(8)\to SO(8)$ collapse the weight route does not itself supply is now recorded as owed.**

### C4, an import consumed everywhere and named nowhere

**Cartan classifies involutions up to $\mathrm{Aut}(\mathfrak g)$ while the lemma consumes $SO(n)$-conjugacy**, and what closes that at every even $n\ne8$ is $\mathrm{Aut}(\mathfrak{so}(n))=\mathrm{Ad}(O(n))$. *Read at source*: [Ziller](../references/ziller-2010-lie-groups-symmetric-spaces/notes.md) Example 4.45 gives it from the diagram symmetries, vacuously at odd $n$, where $B_m$ has none, and with one outer class at even $n\ne8$ represented by an $O(n)$ element of determinant $-1$; at $n=8$, $\mathrm{Sym}(D_4)=S_3$ exceeds the $\mathbb Z_2$ that $O(8)$-conjugation realises, **which is exactly why that dimension needs its own argument.** The block named Cartan and cited nothing.

### C5, the clause the GAP verdict rests on

**One verifier found the lemma's last clause argued nowhere**, and checking it against the index confirms the record points back at L71 for the identification. *What is established is that $\mathfrak h$ is $SO(n)$-conjugate to $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ and that $W$ has two eigenvalues in the ratio $(n-2)\lambda_{\max}=n\lvert\lambda_{\min}\rvert$ at unit norm, which determines $W$ as an operator once the grading is fixed.* **The matching object's isotropy is on the record**, [graded-half.md](../findings/graded-half.md) gives the balanced sphere product's as $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ at dimension $\tfrac{n(n-2)}4$, **and the sentence joining the two is what is missing.** *The round records the debt and names where its data sits rather than writing the join*, which is the research loop's.

### C8, and the block's own honesty did not go far enough

The block disowned its $7\times10^{-16}$ residual as *"the noise of a tautology"*. **Every other figure in the same paragraph is of that kind**, $\dim\mathfrak r=0$, $[\mathfrak m,\mathfrak m]=\mathfrak h$, and $\dim\mathfrak m+\dim[\mathfrak m,\mathfrak m]=N$, the last an outright identity in $n$, all measured at the theorem's own output points. *The load-bearing numbers here are the closed forms ($(n-4)/3$, $\sqrt{3/2}$, $\sqrt3/2$) and three verifiers reproduced each by hand.* The paragraph now says which are which.

### What is not repaired here

**C5 is filed in [plan.md](../plan.md)**, with the data it needs named. One item belongs to another row and is recorded for its round: [results.md](../results.md) still labels L117 *"the converse"* after L117's own block records that as inverting the dependency.

