# REVIEW r545, Lemma L58

**Target:** Lemma L58, "the graded set is strictly wider than the subalgebra family", `findings/ungraded-slack.md` at `#### Lemma L58` (line 256) down to the next heading of any level.

**Reviewer:** r545, independent adversarial audit, cold. Analysis-only footing inherited: no searches, sweeps, censuses or falsifier hunts. Screening of a claim about to be recorded is permitted and is labelled as a screen wherever used.

**Phase plan**

1. Read the target block verbatim.
2. Fix conventions against the record's anchors ($\operatorname{tr}W^\#=-1$, $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, $\theta_0(6)=\sqrt{10}/3$, $\lVert\varphi_{ab}\rVert^2=1$).
3. Attack point 1: the truncated pointer, does the named section exist and hold the argument?
4. Attack point 2: the witnesses, graded, critical, three-or-more eigenvalues, each checked.
5. Attack point 3: which sense of "graded", against `findings/graded-half.md`.
6. Attack point 4: relation to Conjecture L8 (downgraded); consistency and subsumption.
7. Attack point 5: the six citations, eigenvalue argument, witness, or headline.
8. Cross-file grep of `findings/` for restatements; check later sections of the target's own file for contradiction.
9. Provenance / numbering note checked against git.
10. Verdict.

**VERDICT: CONFIRMED**, statement proved on two of its three witnesses; the third is refuted as graded, one row's stated reason is invalid, and the block does not render. Details below.

## Findings

### Conventions fixed, by independent reconstruction (screen)

I rebuilt $\Lambda^2\mathbb R^6$ in the basis $\varphi_{ab}=E_{ab}-E_{ba}$ under the half-trace pairing $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ and computed $\#$ from structure constants as $(W^\#)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\epsilon}c_{\beta\delta\zeta}W_{\gamma\delta}W_{\epsilon\zeta}$. All four of the brief's anchors reproduce, to machine zero:

| anchor | reproduced |
| --- | --- |
| $\lVert\varphi_{ab}\rVert^2=1$ | Gram matrix $=\mathrm{Id}_{15}$, deviation $0.0$ |
| $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ | deviation $0.0$ at $n=6$ |
| $\operatorname{tr}W^\#=-1$ | $-1.0$ at the unit-norm $W_{\mathbb{CP}^3}$ |
| $\theta_0(6)=\sqrt{10}/3$ | $1.0540925533894598$, matching the block's $1.054092553$ |

*This is a screen on objects I constructed for the purpose, run in seconds, and is reported as a screen. It is not offered as evidence for a positive claim; each positive claim below has an argument.*

### F1, the pointer resolves, and its title is merely truncated

The block's note reads *"the argument is in this file under \"The graded critical set is strictly wider than the subalgebra family, \""*. That section exists, at [ungraded-slack.md:142](../findings/ungraded-slack.md#L142), titled **"The graded critical set is strictly wider than the subalgebra family, at every threshold"**, the pointer was cut at the comma, dropping *"at every threshold"*.

**It holds the argument.** The section states the two-eigenvalue mechanism verbatim, tables the same three witnesses, and adds a $\theta$-threshold conclusion the lemma block also carries. **This is the truncated-title case, not the empty-pointer case.**

### F2, one of the three witnesses is not graded, and the source section says so in a paragraph the lemma block drops

The lemma block writes: *"Hence no graded critical point with three or more distinct eigenvalues lies in the family, **and the following do not**"*, then tables $\mathbb{CP}^3$, $(\mathfrak{su}(3),\mathfrak{so}(3))$ and $S^5\times S^7$ with no qualification on any row.

**The source section qualifies the second row and the lemma block deletes the qualification.** Its own table cell for that row reads *"$S=0$ **only**, see below"*, and below it:

> **Jensen's entry carries $S=0$ and nothing stronger.** The compression slack vanishing certifies a $\mathbb Z_2$-grading **only inside the subalgebra family** ..., so calling that point graded outright overstates what was measured. *It is listed because its eigenvalue count settles it either way, and because the conclusion rests on $S^5\times S^7$, which is a symmetric pair and graded with nothing owed.*

**The point is worse than "unmeasured", it is refuted in both senses the record's siblings use.** The source's own table gives its spectrum as *"three eigenvalues $\tfrac5{24},0,-\tfrac18$ at multiplicities $3,7,5$; equivalently a $7$-dimensional kernel"* (arithmetically consistent: $3\cdot\tfrac5{24}+5\cdot(-\tfrac18)=0$, $3+7+5=15=\binom62$). Then:

- **(A) sign-graded fails by definition.** [graded-half.md:260](../findings/graded-half.md#L260) requires *"$\mathfrak p=E_+(W)$ and $\mathfrak m=E_-(W)$, these span $\mathfrak{so}(n)$, equivalently $\ker W=0$"*. The kernel is $7$-dimensional, so (A) is refuted outright, and by [trap W3](../findings/INDEX-traps.md) the $S=0$ screen is vacuous there.
- **(C) pair-graded fails by the record's own enumeration.** The adjacent section [ungraded-slack.md:158](../findings/ungraded-slack.md#L158) argues *"the dimension-$6$ compact symmetric spaces are $S^6$, $\mathbb{CP}^3$ and $Q_3$, at $\theta=0$, $1.0540926$ and $0.7595545$. The point sits at $1.0954451$ and matches none"*, that is exactly a proof that it is no symmetric pair's invariant Weyl tensor.

**So the row fails the "is it graded" leg, which the brief requires alongside criticality and the eigenvalue count.** Its criticality and its three eigenvalues are fine; being graded is what it lacks, and being graded is the whole of what the lemma quantifies over.

### F3, the third row's stated reason applies the family's closed form where the family is empty

Row 3's reason column reads: *"isotropy $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ has $r=31$, and the family's value there is $1.2742878$"*.

- The arithmetic is right: $\tfrac2{12}\sqrt{31\cdot66/35}=1.2742878$.
- **But there is no family member at $r=31$, $n=12$.** [Lemma L23](../findings/ungraded-slack.md#L114) proves $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]$ is a sum of squares, hence $r\le n(n-2)/4=30$. At $r=31$ it evaluates to $35\cdot(20-\tfrac{1364}{66})=-23.\overline3<0$, so the hypothesis $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ is unsatisfiable and the closed form derived from it names nothing. **The record states this itself**, in L23: *"So the cap is not a bound on symmetric pairs: $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ is one, at $r=31$ against $30$."*
- **The comparison is therefore a discriminant against a value the family never takes.** The conclusion survives (trivially, since the family is empty at $r=31$) but the step as written is invalid, and it is also *not the lemma's own mechanism*: the preamble says "Hence ... the following do not", yet this row is discharged by a $\theta$-value argument rather than by the eigenvalue count.

**The repair is one line and it is already elsewhere on the record.** $W_{S^5\times S^7}$ is coordinate-diagonal, so by [conventions.md](../findings/conventions.md) its $\Lambda^2$ spectrum *is* the multiset of vertex entries, which [Observation L56](../findings/ungraded-slack.md#L249) gives as $-q/(p-1)$, $-p/(q-1)$, $1$. At $(p,q)=(5,7)$ that is $-\tfrac74$ at multiplicity $\binom52=10$, $-\tfrac56$ at $\binom72=21$, $1$ at $5\cdot7=35$, trace $10(-\tfrac74)+21(-\tfrac56)+35=0$ **exactly**, three distinct eigenvalues, so the stated mechanism covers it directly. [graded-half.md:35](../findings/graded-half.md#L35) already gives this reason: *"only the balanced split is a two-eigenvalue operator. Every unbalanced sphere product is a genuine three-eigenvalue graded critical point"*. The same check at $(6,6)$ gives $-\tfrac65$ at $30$ and $1$ at $36$, trace $0$, **two** eigenvalues, confirming that the balanced split, and only it, is the Casimir.

### F4, the two surviving witnesses are sound, and they carry the headline alone

- **$S^5\times S^7$, $n=12$.** Graded in sense (C) as the symmetric pair $(\mathfrak{so}(12),\mathfrak{so}(5)\oplus\mathfrak{so}(7))$, with nothing owed; critical; three distinct eigenvalues by the exact hand computation in F3. Its $\theta=1.228239$ is corroborated independently at [graded-half.md:35](../findings/graded-half.md#L35) and [:299](../findings/graded-half.md#L299) (`1.228239158`).
- **$\mathbb{CP}^3$, $n=6$.** Graded in sense (C) as $SO(6)/U(3)$, and in sense (A) as well since $\ker W=0$ ([graded-half.md:276](../findings/graded-half.md#L276)). *Screen:* I built the Fubini–Study curvature on $\mathbb R^6$ from $R_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}+J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl}$, took the traceless part on $\Lambda^2$ and normalised; the spectrum is $-0.2108185107$ at multiplicity $6$, $0.0527046277$ at $8$, $0.8432740427$ at $1$ (**three distinct, no kernel**), with criticality residual $\lVert Q(W)-\theta W\rVert_F=7.2\times10^{-17}$ and $\theta=1.0540925533894598=\theta_0(6)$.

**Neither can be a Casimir**, since $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ has exactly two eigenvalues for $0<r<N$, and the eigenvalue count is precisely the invariant that closes the *"isospectral $\ne$ same orbit"* gap [Reviewer 111](REVIEW_r111.md) warns of: differing spectra rule out $O(n)$-conjugacy outright, where matching $\theta$ would not.

**So the headline is true, on two witnesses, with no numerics needed for either.**

### F5, the file contradicts itself on the Jensen witness, seventy lines above the lemma

[ungraded-slack.md:184–191](../findings/ungraded-slack.md#L184) carries a standalone Jensen block whose summary table reads:

> | slack $S$ | $0$, **graded** |

and draws the headline **"So a non-symmetric homogeneous Einstein metric can have a graded Weyl operator."**

**That is the exact inference [ungraded-slack.md:168](../findings/ungraded-slack.md#L168) says is invalid** (*"calling that point graded outright overstates what was measured"*) and [trap W4](../findings/INDEX-traps.md) states the general rule: *"the gradedness screen is vacuous when $\ker W\ne0$ ... a point whose kernel carries most of $\mathfrak{so}(n)$ reports $S=0$ while admitting no grading"*. Jensen's kernel is $7$ of $15$.

**The eigenvalue data is right, and I checked it cold.** The block gives the *curvature* spectrum as $\tfrac7{24}$ at $3$, $\tfrac1{12}$ at $7$, $-\tfrac1{24}$ at $5$; the space is Einstein, so the Weyl part subtracts the mean $\tfrac1{15}(3\cdot\tfrac7{24}+7\cdot\tfrac1{12}-5\cdot\tfrac1{24})=\tfrac1{12}$, giving $\tfrac5{24},0,-\tfrac18$ at $3,7,5$, **exactly** the L58 table's entry. So the row's spectrum, its criticality and its three eigenvalues are all sound. **Only its gradedness fails, and it fails in both senses.**

**The correction reached one table cell and stopped.** It is in the source section's cell and its follow-up paragraph; it is absent from the standalone block at line 189, from [Lemma L58](../findings/ungraded-slack.md#L256) itself, and from both `results.md` restatements.

### F6, a fourth witness, stronger than the one that fails, was dropped in the move to the lemma

The source section closes with *"and $W_{\mathbb{CP}^2}$ sits exactly **at** the threshold, graded, critical, and likewise not a Casimir"* ([ungraded-slack.md:154](../findings/ungraded-slack.md#L154)). $W_{\mathbb{CP}^2}$ is pair-graded by [graded-half.md:258](../findings/graded-half.md#L258), *"the unique $\mathrm{ad}(\mathfrak u(2))$-invariant tensor of $(\mathfrak{so}(4),\mathfrak u(2))$, commutant exactly one-dimensional"*, and it is the point that makes the *threshold* sentence tight, since it sits at $\sqrt{3/2}$ exactly. **The lemma keeps the threshold sentence and drops the witness that anchors it**, retaining instead the one witness that is not graded.

### F7, L58 and Conjecture L8 are consistent; in fact L58's mechanism is *why* L8 was downgraded, and neither block says so

[Conjecture L8](../findings/graded-half.md#L393)'s refutation box reads: *"The formula comes from a **two**-eigenvalue ansatz $W=(q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m})/\sqrt{pq(p+q)}$"*, failing at *"$S^3\times S^5$, $S^3\times S^7$, $S^4\times S^6$, $S^5\times S^7$, $S^3\times S^9$, $S^4\times S^8$, $S^2\times S^6$, and $\mathbb{CP}^m$ for $m\ge4$"*.

**That ansatz is the subalgebra family, algebraically identical.** With $p=\dim\mathfrak k=r$ and $p+q=N$,
$$q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m}=q\Pi_{\mathfrak k}-p(\mathrm{Id}-\Pi_{\mathfrak k})=(p+q)\Pi_{\mathfrak k}-p\,\mathrm{Id}=N\Big(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}\Big).$$

So **L8's pinning fails exactly where L58 says the family fails, for exactly L58's reason**, and one of L58's own witnesses ($S^5\times S^7$), sits in L8's failure list. The two are consistent, neither subsumes the other (L58 is the general landscape statement; L8's refutation is one instance of it), and **the cross-link is missing in both directions**: L8's box does not cite L58, and L58 does not cite L8.

### F8, the citation inside L8 draws from L58 something L58 does not supply

[results.md:342](../results.md#L342), inside Conjecture L8, reads: *"non-equivariant graded points are outside it (Lemma L58)"*.

**L58 supplies no established non-equivariant graded point.** Both of its sound witnesses are *equivariant*, $\mathbb{CP}^3=SO(6)/U(3)$ and $S^5\times S^7=(\mathfrak{so}(12),\mathfrak{so}(5)\oplus\mathfrak{so}(7))$ are symmetric pairs, so they lie **inside** L8's scope, not outside it. Only the Jensen row is non-equivariant, and its gradedness is what F2 and F5 refute.

**The record holds the right witness elsewhere.** [results.md:18](../results.md#L18) and L8's own scope box name it: *"A second graded critical point on the **same** symmetric pair $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ carries $\theta=1.088948$ ... trivial kernel, all three bracket inclusions to $10^{-29}$"*, trivial kernel, so the (A) screen is *not* vacuous there. **That is L8's own counterexample, and the sentence should cite it rather than L58.**

### F9, the six citations, classified

| site | what it takes | sound? |
| --- | --- | --- |
| [results.md:18](../results.md#L18) | headline only | yes |
| [results.md:178](../results.md#L178) | mechanism **and all three witnesses**, *"are graded and outside it"* | propagates F2 |
| [results.md:342](../results.md#L342) | headline, for non-equivariance | **no, F8** |
| [results.md:518](../results.md#L518) | headline only, *"its floor is a different number"* | yes |
| [results.md:522](../results.md#L522) | the mirror statement: mechanism **and all three witnesses** | propagates F2 and F3 |
| [plan-verification.md:78](../plan-verification.md#L78) | a bare unchecked checklist row | n/a |

**No consumer takes L58 as an input to a proof.** Every citation is a landscape or scope remark, so the blast radius of F2 is confined to the three places that restate the witness list. [INDEX-results.md:73](../findings/INDEX-results.md#L73) carries *"**Gate 2: no verdict on the record.**"*, which is accurate before this review.

### F10, the provenance note is TRUE, checked against git

The note reads: *"Numbered here on 2026-08-31: the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block."*

| claim | git |
| --- | --- |
| mathematics predates the numbering | argument section entered `graded-half.md` on **2026-08-27**, `c6554873` |
| numbered in `report/` | **2026-08-28**, `6a98336d`, at [07-gradedness-split.tex:396](../report/sections/07-gradedness-split.tex#L396), `\begin{Lem}{58}` |
| block added here 2026-08-31 | **2026-08-31**, `86621751`, then split into this file the same day by `7ad0455d` |

The only slack is verbal: *"always been in this file"* means its parent `graded-half.md`, this file being four days old. The substance (mathematics first, number second, block third), is exact. **No defect.**

### F11, the block does not render, and the whole of its evidence is the part that does not

The block is a verbatim paste of the report's `\begin{Lem}{58}` environment into a markdown file: `\CP`, `\su`, `\so`, `\hh`, `\Id`, `\thstar`, and a `\begin{center}\begin{tabular}...\toprule...\end{tabular}\end{center}`. **The witness table is the entire evidential content of the lemma, and it is the part that renders as literal LaTeX source.** [ELIM-canon.md:214](ELIM-canon.md#L214) flagged this, *"raw LaTeX pasted from report/ ... which will not render and cannot be corrected in place as markdown"*, and it is **still present**. Only `\emph{}` was converted; the macros and the table were not.

### F12, collateral: `conventions.md` has the two graded traps swapped, both ways

[conventions.md:22](../findings/conventions.md#L22) sends the reader to **W3** for *"the screen is vacuous when $\ker W\ne0$"*, and [conventions.md:95](../findings/conventions.md#L95) sends them to **W4** for the three senses. [INDEX-traps.md](../findings/INDEX-traps.md) has them the other way: **W3** is the three senses, **W4** is the vacuous screen. *This bears directly on L58: a reader checking whether Jensen's $S=0$ is trustworthy follows the pointer and lands on the wrong trap.* Outside my target, reported for repair.

## Verdict

**VERDICT: CONFIRMED**, the statement, with two of its three witnesses and with three repairs owed to the block.

**What is proved.** A Casimir $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with $0<r<N$ has exactly two eigenvalues; $W_{\mathbb{CP}^3}$ and $W_{S^5\times S^7}$ are each graded in the pair sense (C), each critical, and each has three distinct eigenvalues. **So the graded critical set is strictly wider than the subalgebra family, and $S^5\times S^7$ at $1.228239>\sqrt{3/2}$ makes it wider above the threshold too.** Neither witness needs a computation: $S^5\times S^7$'s spectrum is $-\tfrac74,-\tfrac56,1$ at multiplicities $10,21,35$ with trace $0$ exactly, and $\mathbb{CP}^3$'s $U(3)$-decomposition of $\Lambda^2\mathbb R^6$ has three inequivalent summands of dimensions $6,8,1$. Differing spectra rule out $O(n)$-conjugacy, so the eigenvalue count closes the *"isospectral $\ne$ same orbit"* gap that a $\theta$-comparison would leave open.

**Three repairs the block owes.**

1. **Withdraw or caveat the $(\mathfrak{su}(3),\mathfrak{so}(3))$ row.** It is refuted as graded in sense (A) by its $7$-dimensional kernel and in sense (C) by the record's own dimension-$6$ enumeration. The block states it flat, having dropped the source's caveat. Carry the caveat, or replace the row with $W_{\mathbb{CP}^2}$ (F6). *This also needs fixing at [results.md:178](../results.md#L178) and [results.md:522](../results.md#L522), and the contradicting block at [ungraded-slack.md:189](../findings/ungraded-slack.md#L189) needs the same correction.*
2. **Replace row 3's reason with the eigenvalue count.** *"the family's value there is $1.2742878$"* evaluates the closed form at $r=31$, above the cap $r\le30$ that the same theorem proves, where no family member exists; the record says so itself in L23. The eigenvalue count discharges the row directly and is the lemma's own stated mechanism.
3. **Convert the block to markdown.** The witness table is raw LaTeX and does not render (F11).

**One citation to re-point.** [results.md:342](../results.md#L342) should cite L8's own $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ counterexample for non-equivariant graded points, not L58 (F8).

**A cross-link worth adding.** L8's refuted two-eigenvalue ansatz *is* the Casimir shape, so L58 is the general form of L8's own downgrade (F7). Neither block says so.
