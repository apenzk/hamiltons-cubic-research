# REVIEW r546, Lemma L58

**Target.** Lemma L58, "the graded set is strictly wider than the subalgebra family", in [findings/ungraded-slack.md](../findings/ungraded-slack.md) at the `#### Lemma L58` heading (line 256), down to the next heading of any level.

**Reviewer.** r546, independent adversarial audit, cold. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts; screening only, and reported as screening.

**Phase plan.**

1. Read the target block verbatim; fix conventions against the record's anchors.
2. Resolve the truncated pointer, does the named section exist and does it hold the argument?
3. Audit each witness in the table: graded, critical, and three or more distinct eigenvalues.
4. Determine which sense of "graded" is in play and whether it matches the file's usage.
5. Check consistency with Conjecture L8 and whether either subsumes the other.
6. Grep the six citations and classify what each takes.
7. Grep `findings/` for restatements and for later passages contradicting the block.
8. Check the provenance / numbering note against git.
9. Verdict.

VERDICT: PLAUSIBLE, the statement is true and independently confirmed on two of its three witnesses; the block as printed omits the gradedness leg entirely, one witness fails it, and the third row's stated reason is defective.

## Findings

### F0, Conventions fixed against the record's anchors

Checked before deriving anything. $\theta_0(6)=\sqrt{2\cdot5\cdot4}/6=\sqrt{40}/6=\sqrt{10}/3=1.054092553$, the brief's anchor and the block's own figure are the same number. $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing, per [conventions.md:38](../findings/conventions.md#L38), which is what makes $\{\varphi_{ab}\}_{a<b}$ orthonormal and $N=\binom n2$ the right normalisation for $\Pi_{\mathfrak h}$. Unit norm is $\mathop{\mathrm{tr}}(W^2)=1$ on $\Lambda^2$, per [conventions.md:99](../findings/conventions.md#L99). No convention mismatch reaches this block: the eigenvalue-count mechanism is scale-free and pairing-free, as the source section itself says, *"an argument using no $\theta$, no slack and no convention"*.

### F1, The pointer resolves; the title is merely truncated, and the section does hold the argument

The block reads: *"the argument is in this file under \"The graded critical set is strictly wider than the subalgebra family, \""*. That is the **truncation** case, not the missing-proof case. The section is [ungraded-slack.md:142](../findings/ungraded-slack.md#L142), full heading **"The graded critical set is strictly wider than the subalgebra family, at every threshold"**, the pointer stops after the comma. It holds the argument: the two-eigenvalue statement, the three-witness table with a `graded` column the numbered block drops, the Jensen identification, the $\mathbb{CP}^2$ remark, and a Gate 1 paragraph.

**But the truncation is not harmless here.** The five dropped words are *"at every threshold"*, which is exactly the scope claim two citations lean on (F7). A reader following the pointer gets a section whose heading claims more than the block does.

### F2, The mechanism is correct, re-derived cold

$W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ is an affine function of a projector, so its spectrum is the affine image of $\{1,0\}$: $c(1-\tfrac rN)$ on $\mathfrak h$ with multiplicity $r$, $-c\tfrac rN$ on $\mathfrak h^\perp$ with multiplicity $N-r$. Both multiplicities are nonzero exactly when $0<r<N$, and the two values are distinct since $c\ne0$. So the operator has exactly two eigenvalues, and $\mathfrak h$ is recoverable from $W_{\mathfrak h}$ as the eigenspace of the positive one. Contrapositive: **three or more distinct eigenvalues $\Rightarrow$ not of this form, for any $\mathfrak h$ whatever**, which is stronger than what the block's third row actually uses (F5). Confirmed.

### F3, Witness $S^5\times S^7$: all three legs hold, and it carries the lemma alone

| leg | verdict | evidence |
|---|---|---|
| graded | **yes**, sense (C) pair-graded | $(\mathfrak{so}(12),\mathfrak{so}(5)\oplus\mathfrak{so}(7))$ is a compact symmetric pair; $\Delta=0$ at $10^{-31}$ ([ATTEMPTS.md:2148](../ATTEMPTS.md#L2148)); $\ker W=0$, so the (A) screen is non-vacuous here too |
| critical | **yes** | closed form $\theta_{k,l}=\sqrt2\sqrt{\tfrac{k-1}k\tfrac{l-1}l\tfrac{n-1}{n-2}}$, reproduced at $1.228239$ by an independent solver as a positive control ([ATTEMPTS.md:1344](../ATTEMPTS.md#L1344)) |
| $\ge3$ eigenvalues | **yes** | $\Lambda^2\mathbb R^{12}=\Lambda^2\mathbb R^5\oplus\Lambda^2\mathbb R^7\oplus(\mathbb R^5\otimes\mathbb R^7)$, dimensions $10+21+35=66$; spectrum $(42,20,-24)$ found independently by three verifiers at [verification/ROUND_L04.md:37](../verification/ROUND_L04.md#L37) |

**Its $\theta$ and its position above $\theta^*$ check out exactly over $\mathbb Q$.** $\theta^2=2\cdot\tfrac45\cdot\tfrac67\cdot\tfrac{11}{10}=\tfrac{264}{175}=1.5085714$, so $\theta=1.22823916$, against $\theta^*=\sqrt{3/2}=1.22474487$. It sits above by $0.0035$, so the block's closing sentence, *"Since $S^5\times S^7$ sits above $\thstar$, restricting the family by a value threshold does not recover it"*, is true.

**This witness alone proves the lemma.** Graded, critical, three eigenvalues, hence not a Casimir by F2.

### F4, Witness $\mathbb{CP}^3$: all three legs hold

Graded in **all three** senses, [graded-half.md:270](../findings/graded-half.md#L270)'s own table gives $\mathbb{CP}^3$ ($n=6$) as (C) yes / (A) yes / (B) yes, with $\ker W=0$ so the screen is trustworthy there. Critical at residual $5.1\times10^{-16}$ with $\theta=\theta_0(6)$ exactly, recorded at [ungraded-slack.md:103](../findings/ungraded-slack.md#L103). Three eigenvalues: under $\mathfrak u(3)$, $\Lambda^2\mathbb R^6$ splits as $\mathbb R\omega\oplus\mathfrak{su}(3)$-part$\oplus(\Lambda^{2,0}+\Lambda^{0,2})_{\mathbb R}$, dimensions $1+8+6=15$, and the operator is constant on each. Off the family independently: $\mathfrak u(m)\subset\mathfrak{so}(2m)$ has $r=m^2=9$ against the cap $n(n-2)/4=6$, and [Lemma L23](../findings/ungraded-slack.md#L114) names $\mathfrak u(m)$ as never entering the family.

**$\mathbb{CP}^3$ is the sharper witness of the two for the *threshold-free* half**, because it ties $\theta_0(6)$ exactly, no value argument can separate it from the family's own maximiser, so only the eigenvalue count does. The block does not say this.

### F5, DEFECT. Witness $(\mathfrak{su}(3),\mathfrak{so}(3))$ fails the gradedness leg, by the record's own vacuity rule

**Quoting the source section verbatim:** *"**Jensen's entry carries $S=0$ and nothing stronger.** The compression slack vanishing certifies a $\mathbb Z_2$-grading **only inside the subalgebra family**, where the two remaining conditions come free, so calling that point graded outright overstates what was measured."*

It is worse than "overstates". The same section records the point's Weyl spectrum as *"three eigenvalues $\tfrac5{24},0,-\tfrac18$ at multiplicities $3,7,5$; equivalently a $7$-dimensional kernel"*. And [graded-half.md:366](../findings/graded-half.md#L366) rules on precisely that situation:

> the defect screen, $\Delta$, $S_{\mathfrak{mmm}}$, $S_{\mathfrak{mpp}}$ | **(A)** sign-graded | it traces over $E_\pm$ by construction. **Vacuous wherever $\ker W\ne0$**

with the companion instruction *"Trust the screen exactly when $\ker W=0$."* Jensen's Weyl kernel is $7$ of $15$. **So the only evidence offered for its gradedness is a screen the record declares vacuous at exactly this point.** The point is not shown ungraded, it is undetermined, and by the brief's rule an undetermined leg is a failed witness.

*Self-consistency check on the spectra, which holds:* the curvature-operator spectrum recorded at [ungraded-slack.md:186](../findings/ungraded-slack.md#L186) is $\tfrac7{24}(3),\tfrac1{12}(7),-\tfrac1{24}(5)$; subtracting $\tfrac1{12}$ throughout gives $\tfrac5{24},0,-\tfrac18$ at the same multiplicities. The $7$-fold eigenvalue lands exactly on zero, so the kernel is real and not an artefact.

**Impact: none on the headline.** Jensen is one of three witnesses and the other two are sound. It should be withdrawn from the witness list or re-labelled as an illustration.

### F6, DEFECT. The block never asserts that any witness is graded, so as printed it does not prove its own headline

The block's table is:

> Witness & $n$ & $\theta$ & Why it is not a Casimir

Three columns of the source section's four. **The `graded` column was dropped in the paste.** The lead sentence is *"Hence no graded critical point with three or more distinct eigenvalues lies in the family, and the following do not:"*, where "do not" resolves to "do not lie in the family", a claim about three points that says nothing about gradedness. The headline needs *graded* $\wedge$ *critical* $\wedge$ *off the family*, and the block supplies the second and third only.

A reader who does not follow the truncated pointer cannot verify the lemma from the numbered block. The gradedness is on the record, it just is not here.

### F7, DEFECT in two citations. "At every threshold" is not supported by the witnesses

The block itself claims only the $\theta^*$ threshold, correctly. Two citations upgrade it:

- [report/sections/06-shape.tex:40](../report/sections/06-shape.tex#L40): *"the graded set is strictly wider than the family **above every threshold** (Lemma~58)"*
- [report/sections/09-status.tex:21](../report/sections/09-status.tex#L21): *"Closes (H) by classification **at any threshold**"*

The three witnesses sit at $1.054093$, $1.095445$ and $1.228239$. Above $t=1.228239$ they give nothing, and at $n=12$ the family's own ceiling is $\theta_0(12)=1.236033$, so the interval where the claim would be most useful is exactly where no witness lives. The supported statement is *"no threshold at or below $\sqrt{3/2}$ recovers it"*, which is what (H) needs and what the block says. The pointer section's heading carries the same overreach.

### F8, DEFECT. The $S^5\times S^7$ row's stated reason is not the independent second route Gate 1 claims

The row's justification is *"its isotropy $\mathfrak{so}(5)+\mathfrak{so}(7)$ has $r=31$, and the family's $\theta$ at $r=31$ is $1.2742878$"*. Two problems.

**(a) It evaluates the family's closed form outside the family's own proven domain.** At $n=12$ the family's cap is $r\le n(n-2)/4=30$, and [Lemma L23](../findings/ungraded-slack.md#L114) says so explicitly of this very subalgebra: *"So the cap is not a bound on symmetric pairs: $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ is one, at $r=31$ against $30$."* There is no family member at $r=31$; the quoted $1.2742878$ is a formula value at a point the record proves cannot occur.

**(b) It is not independent of the eigenvalue count.** The row silently assumes the only candidate $\mathfrak h$ is the isotropy, which is justified only because $W_{\mathfrak h}$'s $\mathfrak h$ is an eigenspace, i.e. by the two-eigenvalue structure. So Gate 1's *"(b) the eigenvalue-count argument shares no step with the $\theta$-value one"* does not hold for the argument as printed.

**The genuinely independent route exists and is one line, and is not on the record.** If $W_{S^5\times S^7}=W_{\mathfrak h}$ for any family member, then $\theta^2=\tfrac4{n^2}\tfrac{rN}{N-r}=\tfrac{11r}{6(66-r)}$. Setting this to $\tfrac{264}{175}$ gives $1925r=1584(66-r)$, so $r=\tfrac{104544}{3509}=29.7932\ldots\notin\mathbb Z$. **Suggested repair:** replace the $r=31$ clause with the non-integrality of $r$, which is exact over $\mathbb Q$, needs no candidate $\mathfrak h$, and is genuinely disjoint from the eigenvalue count.

### F9, The six citations, classified

| citation | what it takes | sound? |
|---|---|---|
| [results.md:18](../results.md#L18) | headline only | yes |
| [results.md:178](../results.md#L178) | full mechanism + all three named witnesses | **no**, asserts *"$\mathbb{CP}^3$ ..., $(\mathfrak{su}(3),\mathfrak{so}(3))$ ... and $S^5\times S^7$ ... **are graded** and outside it"*, flat, for the point the source hedges (F5) |
| [results.md:342](../results.md#L342) | *"non-equivariant graded points are outside it (Lemma L58)"* | **no**, see below |
| [results.md:518](../results.md#L518) | headline, as "the graded set is wider than the families ... its floor is a different number" | yes |
| [results.md:524](../results.md#L524) | canonical statement, full mechanism + witnesses | **no**, same flat "are graded" as :178 |
| [report/sections/09-status.tex:21](../report/sections/09-status.tex#L21) | headline + "at any threshold" | **no**, F7 |
| [report/sections/06-shape.tex:40](../report/sections/06-shape.tex#L40) | headline + "above every threshold" | **no**, F7 |

(Seven, not six; [plan-verification.md:78](../plan-verification.md#L78) is a checklist row, not a citation.)

**[results.md:342](../results.md#L342) is a misuse worth naming.** It sits in the L8 block and reads *"The lemma is stated in the pair-graded sense and pins the pair's equivariant point only; non-equivariant graded points are outside it (Lemma L58)"*. L58 exhibits graded points outside the **subalgebra Casimir family**, a different exclusion. Its strongest witness, $S^5\times S^7$, is a compact symmetric pair, i.e. exactly the equivariant pair-graded object L8 pins. The only witness that could carry "non-equivariant" is Jensen, whose gradedness is the one that fails (F5). **So this citation rests entirely on the withdrawn witness.**

### F10, Relation to Conjecture L8: consistent, neither subsumes the other

[INDEX-results.md:23](../findings/INDEX-results.md#L23) records L8 as **REFUTED at Gate 2 and downgraded from Lemma**, its pinning resting on *"a two-eigenvalue ansatz valid only where the isotropy's simple ideals are interchangeable, and $S^3\times S^5$ has three"*, with the census behind *"settled across the classical families"* rejecting every unbalanced split before evaluating it.

**They are consistent, and more than consistent, they fail on the same object.** L8's ansatz breaks at unbalanced splits with three isotropy values; L58's load-bearing witness is the unbalanced $S^5\times S^7$ with three distinct eigenvalues. The point that refutes L8's scope is the point that proves L58.

**Neither subsumes the other.** L8 is a pinning formula for $\theta$ from the pair's dimensions (sense (C)); L58 is a set-inclusion statement about the Casimir family. L58 survives L8's downgrade untouched, it cites no numbered result and its mechanism is a spectral count. **What does need repair is the direction of use at [results.md:342](../results.md#L342)**, where L58 is made to cover L8's retreat and cannot (F9).

### F11, The sense of "graded", and a gap in the labelling pass

[graded-half.md:254](../findings/graded-half.md#L254) names three senses (**(C) pair-graded**, **(A) sign-graded**, **(B) slice-graded**) and records that **(C) and (A) are incomparable**, both strictly inside (B). Its labelling table at [graded-half.md:363](../findings/graded-half.md#L363) claims *"Every result that says 'graded' is tagged here with the sense its own proof uses."*

**L58 has no row in that table.** It is a numbered result with "graded" in its title, and the pass that was supposed to be exhaustive omits it.

**What the correct label would be:** L58 is stated across two senses at once, which is why it slipped the pass. $S^5\times S^7$ enters as **(C)**; $\mathbb{CP}^3$ satisfies (C), (A) and (B); Jensen enters only through the **(A)** screen, where it is vacuous. This is benign for the conclusion (the mechanism is a spectral count that is indifferent to which sense supplies gradedness) but the record's own rule is that *"any future argument that moves between a $\Delta$-based screen and a pair-based lemma owes a justification at the crossing"*, and L58's witness list makes that crossing without one.

### F12, DEFECT. The file contradicts the block thirty lines below it

[ungraded-slack.md:186](../findings/ungraded-slack.md#L186), in the Jensen table:

> | slack $S$ | $0$, **graded** |

followed by *"**So a non-symmetric homogeneous Einstein metric can have a graded Weyl operator.**"* This is the flat assertion that the L58 pointer section, **thirty lines above it in the same file**, exists to retract. Two passages of one file disagree about one point, and the *later* one is the wrong one, the reverse of the usual pattern, so a reader who reads down is left with the retracted claim.

*Everything else below the block was checked.* [Lemma L38](../findings/ungraded-slack.md#L234) (two families capped) and [Observation L56](../findings/ungraded-slack.md#L249) (the families' floor) are about the named families, and L56's closing line at [results.md:518](../results.md#L518) explicitly defers to L58 for the set being wider, agreement, not contradiction. The slack-gap and local-separation sections concern $S$ on the ungraded side and do not touch the Casimir count.

### F13, Provenance, checked against git

*"Numbered here on 2026-08-31: the result was numbered in [report/] and the mathematics has always been in this file, but it carried no block."*

| clause | verdict |
|---|---|
| "numbered in `report/`" first | **true**, `6a98336d`, 2026-08-28, *"docs(report): (H) cannot be closed by classifying the isotropy, at any threshold"*, the first commit carrying `Lemma~58` under `report/` |
| "numbered here on 2026-08-31" | **true**, the `Lemma 58` block is present at `7ad0455d` (2026-08-31), and the id prefix `L58` arrived later at `fe85b5bd` |
| "the mathematics has always been in this file" | **misleading**, the argument section was created 2026-08-27 at `9f85f84a`, *"fix(graded-half): the graded critical set is strictly wider than the subalgebra family"*, in [graded-half.md](../findings/graded-half.md). [ungraded-slack.md](../findings/ungraded-slack.md) did not exist until `7ad0455d`, 2026-08-31, *"refactor(findings): split graded-half into the graded and ungraded halves"*. True only within the file's four-day life |

**And the block's own span contradicts it.** The block runs to the next heading, so it swallows the separator and the line at [ungraded-slack.md:276](../findings/ungraded-slack.md#L276): *"Re-filed here 2026-09-02 from [target.md](target.md) by the parallel sort of [findings/](.)"* (`56601517`, 2026-09-02). That line belongs to the [Observation L12](../findings/ungraded-slack.md#L281) material appended after it, but as placed it reads as L58's provenance and says the opposite of the block's own note.

### F14, The block is unrenderable markdown (already on the record)

The block is raw LaTeX pasted from `report/`: `\begin{center}`, `\begin{tabular}`, `\toprule`, and the macros `\hh`, `\Id`, `\CP`, `\thstar`, none of which exist outside [report/report.tex](../report/report.tex). [ELIM-canon.md:214](ELIM-canon.md#L214) already logs this for the L38 and L58 blocks, including the malformed `$W_{\CP^2**$ itself.}` in the neighbouring L38 block. Recorded here as confirmed, not as new.

---

## Verdict

**VERDICT: PLAUSIBLE**

**The statement is true and I confirm it independently.** The mechanism is correct, an affine function of a projector has exactly two eigenvalues when $0<r<N$, and $\mathfrak h$ is recoverable as an eigenspace, so three distinct eigenvalues excludes membership for *every* $\mathfrak h$, not merely the candidate one. Two of the three witnesses carry all three legs: $S^5\times S^7$ (pair-graded symmetric pair, critical, spectrum $(42,20,-24)$ at multiplicities $10/21/35$, $\theta^2=264/175$ exactly, above $\theta^*$) and $\mathbb{CP}^3$ (graded in all three senses per the record's own table, critical at $5\times10^{-16}$, three eigenvalues, and off the family at $r=9$ against the cap $6$). Either alone proves the lemma.

**It is PLAUSIBLE rather than CONFIRMED because the block as printed does not establish its own headline, and one third of its evidence is withdrawn:**

1. **F6, the `graded` column was dropped in the paste**, so the numbered block asserts gradedness of nothing and proves only "three points outside the family". The headline needs a leg the block does not contain.
2. **F5, the $(\mathfrak{su}(3),\mathfrak{so}(3))$ witness fails.** Its gradedness rests on $S=0$ alone, at a point with a $7$-dimensional Weyl kernel, where [graded-half.md:366](../findings/graded-half.md#L366) declares that screen **vacuous**.
3. **F8, the $S^5\times S^7$ row's stated reason is defective**: it evaluates the family's closed form at $r=31$, above the cap $r\le30$ the record proves for $n=12$, and it is not the independent second route Gate 1 claims.

**Repairs, in priority order.**

- Restore the `graded` column, with $S^5\times S^7$ marked (C) pair-graded and $\mathbb{CP}^3$ marked graded in all three senses.
- Withdraw $(\mathfrak{su}(3),\mathfrak{so}(3))$ from the witness list, or keep it flagged as undetermined; fix the flat *"are graded"* at [results.md:178](../results.md#L178) and [results.md:524](../results.md#L524), and the flat *"$0$, **graded**"* at [ungraded-slack.md:186](../findings/ungraded-slack.md#L186).
- Replace the $r=31$ clause with the exact non-integrality: $\theta^2=264/175$ forces $r=104544/3509\notin\mathbb Z$.
- Scope the two report citations to *"no threshold at or below $\sqrt{3/2}$"* (F7), and cut the L58 citation at [results.md:342](../results.md#L342), which rests on the withdrawn witness (F9).
- Add an L58 row to the labelling table at [graded-half.md:363](../findings/graded-half.md#L363) (F11).
- Fix the pointer's truncation and the misplaced re-filing line at [ungraded-slack.md:276](../findings/ungraded-slack.md#L276) (F1, F13).

**Analysis-only compliance.** No searches, sweeps, censuses or falsifier hunts were run. All arithmetic here is exact by hand over $\mathbb Q$, $\theta^2=264/175$, $r=104544/3509$, $\theta_0(6)=\sqrt{10}/3$, the multiplicity counts $10+21+35=66$ and $1+8+6=15$, and the $\tfrac1{12}$ shift between Jensen's curvature and Weyl spectra. No computation was needed and none was performed.
