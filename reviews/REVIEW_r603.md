# Review r603, Lemma L63, the $n=12$ block table

Reviewer 603. Target: [findings/sym3-stability.md](../findings/sym3-stability.md), line 44, `#### Lemma L63, the $n=12$ block table`. Conventions read first: [findings/conventions.md](../findings/conventions.md). Derived cold from the definitions; the paired reviewer's report was not opened.

**Standing rule observed.** Analysis only. Nothing was decomposed, swept or recomputed. Every number below was reached either by hand or by a closed-form screen, Weyl's dimension formula, a binomial, a power sum, and integer bookkeeping on the reported counts, each of which is seconds of arithmetic on objects built for the check. The census itself was left alone, deliberately; §7 names the one computation that would close what remains.

## Verdict

**GAP, every derivable claim in the block is CONFIRMED, and the census claims are correct-as-far-as-checkable but unproven and carried under the wrong label.** No number is refuted. The block is a `Lemma` whose load-bearing content is a machine decomposition, and its provenance note points at a section that proves a different theorem.

| claim | status |
| --- | --- |
| $\dim\mathcal W_{12}=1638$ | **CONFIRMED**, two independent closed forms |
| highest weight $(2,2,0,0,0,0)$ for $D_6$ | **CONFIRMED**, and it is the weight that yields $1638$ |
| $\sum m_\lambda d_\lambda=\binom{1640}3=733\,813\,080$ | **CONFIRMED** as arithmetic; the summands are not checkable without the run |
| $77$ $SO(12)$ constituents, $191$ multiplicities | **CENSUS**, read from a pickle, asserted by no argument on the record |
| twelve chiral in six pairs at multiplicities $2,1,1,1,1,1$ | **CENSUS**, and *internally consistent to the digit* with $191\to184$ |
| $77-6=71$, $191-7=184$ | **CONFIRMED**, and the bookkeeping is tighter than the block states |
| six invariants separate the $71$ blocks, the sixth $\mathrm{Pf}^2$ | **CONFIRMED**, correction included, re-derived independently |
| the block's label `Lemma` | **DEFECT**, the record's own rule makes this an `Observation` |
| the provenance note, *"the argument is in this file under 'The argument'"* | **FALSE for the census**, true only for a statement the block does not make |

## 1. The pointer, and where the argument actually lives

The note at [sym3-stability.md:46](../findings/sym3-stability.md) reads: *"the mathematics has always been in this file … the argument is in this file under 'The argument'"*. Both halves fail, and `git` shows how.

**The section exists and proves a different theorem.** *"The argument"* ([sym3-stability.md:7–17](../findings/sym3-stability.md)) is four steps: the Newell–Littlewood row bound $\lambda'_1\le6$; the $O(n)$ labelling condition $\lambda'_1+\lambda'_2\le n$; the maximum $12$ attained at $(2,2,2,2,2,2)$; and Koike–Terada carrying stability from labels to multiplicities. Its conclusion is *the table does not move for $n\ge12$, and $12$ is the threshold*. That conclusion is **conditional on a table it does not produce**. It never yields $1638$, never yields $77$ or $191$, never yields the six chiral pairs or their multiplicities, and never yields $733\,813\,080$. Steps 1 and 2 are sound and I confirm them independently: $\ell(\nu)\le\ell(\lambda)+\ell(\mu)$ holds for Newell–Littlewood as it does for Littlewood–Richardson, so three two-row inputs give at most six rows, and $\lambda'_1+\lambda'_2\le12$ follows with nothing read from a run. Step 3's *attainment* is the census speaking: that $(2,2,2,2,2,2)$ actually occurs in $\mathrm{Sym}^3$ (as opposed to $\otimes^3$), is asserted from the table, and it is what makes $12$ the threshold rather than merely an upper bound.

**"Always been in this file" is false.** The file was created by `8e88af4b` on 2026-08-30. I recovered that revision and grepped it: it contains $71/184/477$, $77/191$ and $64/182/493$, and it contains **none** of $1638$, $(2,2,0,0,0,0)$, the word "chiral", the six pairs, the multiplicities $2,1,1,1,1,1$, or $733\,813\,080$. Every one of those arrived on 2026-08-31 **with the block itself**, in `86621751`, carried across from [report/](../report/).

**The note's present wording is a repair of an earlier, admittedly loose one.** `86621751` created the block saying *"the argument is the surrounding material in this file"*; `bbfa159b` then sharpened it to name *"The argument"*, on a commit whose own message says the seventeen sharpened blocks were *"located by searching each lemma's own distinctive content"*. Here that search landed on the section whose title matched, not the section that proves the statement, the failure mode `bbfa159b` was written to fix. This is the same defect [fence-posts.md:231](../findings/fence-posts.md) already documents for the sibling block, in the same two commits.

**Where the census's justification actually lives: only in [report/](../report/).** The one sentence on the record that says how the decomposition was obtained is [report/sections/07-gradedness-split.tex:930](../report/sections/07-gradedness-split.tex), *"Four independent routes agree on $1638$ … and three on the decomposition, the third being Racah's alternating sum over $W(D_6)$, which reproduces all $191$ multiplicities and proves completeness."* That sentence appears **nowhere in [findings/](../findings/)**. [sym3-blocks.md](../findings/sym3-blocks.md), the block's former home, contains no occurrence of $1638$, $191$, "chiral", "Racah" or "Freudenthal". So the findings-side record of L63 carries the numbers with no account of their origin, and the account exists only downstream, in the file the record treats as derivative.

**The script does not close the gap either.** [run_n12_stability.py](../scripts/runs/run_n12_stability.py) loads the table from [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl) and *asserts* `len(MULT) == 77 and sum(MULT.values()) == 191`. It checks steps 1 and 3 **against** that table; it does not produce it. Its own docstring is candid about this, *"This file checks steps 1 and 3 against the constituents the covariant run actually produced"*. The $77$ and the $191$ are inputs to the script, not outputs.

**The L64 pointer resolves.** [sym3-stability.md:50](../findings/sym3-stability.md) sends L64 to post F32 in [fence-posts.md](../findings/fence-posts.md); post F32 exists at line 215 and the `#### Lemma L64` block sits inside it at line 227. Recorded as asked, and not audited, though a reader should know that F32's own text at line 231 declares the *content* of that pointer false, so the section exists while the proof it promises does not. That is another pair's business.

## 2. Derivable, and machine census

### Derivable in closed form, both confirmed

**$\dim\mathcal W_{12}=1638$, two ways that do not share a step.**

- The record's closed form, [conventions.md](../findings/conventions.md): $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$, so $12\cdot9\cdot13\cdot14/12=9\cdot13\cdot14=1638$.
- Weyl's dimension formula for $D_6$ at $\lambda=(2,2,0,0,0,0)$. With $\rho=(5,4,3,2,1,0)$ and $\ell=\lambda+\rho=(7,6,3,2,1,0)$, the positive roots $e_i\pm e_j$ pair up so that $\dim=\prod_{i<j}(\ell_i^2-\ell_j^2)\big/\prod_{i<j}(\rho_i^2-\rho_j^2)$, a ratio of Vandermondes in the squares. Evaluated exactly in the rationals: $1638$.

**They agree.** The brief flagged disagreement as the finding; there is none. The second route also confirms the highest weight independently, $(2,2,0,0,0,0)$ is the $D_6$ weight of the $O(12)$ partition $(2,2)$, and it is the weight that returns $1638$, so the label and the dimension corroborate each other rather than being two transcriptions of one source.

**$\binom{1640}3$.** $\mathrm{Sym}^3$ of a $1638$-dimensional space has dimension $\binom{1638+2}3=\binom{1640}3=1640\cdot1639\cdot1638/6=733\,813\,080$. Exact, and it matches the block's figure to the digit. Note precisely what this does and does not certify: it confirms the *target*, not the decomposition. $\sum m_\lambda d_\lambda$ hitting it is a real check on the table, but the check lives in the run, not in the block, and the block reports the target rather than performing the check.

### Machine census, none of it derivable from anything on the record

$77$, $191$, the identity of the six chiral pairs, the multiplicities $2,1,1,1,1,1$, and therefore $71$ and $184$ as *values* rather than as consequences. Nothing in [findings/](../findings/) derives them; the argument that would (a plethysm of $\mathrm{Sym}^3$ of the $(2,2)$ universal character, or Racah's alternating sum), is named in [report/](../report/) and recorded nowhere as steps.

**So the label is wrong, and the counts are not.** By the record's own rule at [INDEX-results.md:5](../findings/INDEX-results.md), *"Labels are literal. **Lemma** is proven, Gate 1 and Gate 2 passed. **Observation** is verified numerically at the dimensions stated"*, L63 is an `Observation` verified at $n=12$. A census whose arithmetic is exact is still a census. The clean split, if the record wants to keep a `Lemma` here, is to keep $\dim\mathcal W_{12}=1638$ at highest weight $(2,2,0,0,0,0)$ as a `Lemma` (it is proven above, twice) and carry the block table as an `Observation`. [INDEX-results.md:77](../findings/INDEX-results.md) currently lists row 63 as `Lemma` with *"Gate 2: no verdict on the record"*, this review is that verdict on the label.

## 3. Internal consistency, checked by hand, and it is tighter than the block claims

**The fusion identity.** Twelve chiral constituents form six pairs; an orientation-reversing element fuses each pair to one $O(12)$ block, while each of the $77-12=65$ non-chiral constituents stays one block. So $65+6=71$ blocks, and equivalently $77-6=71$. **Confirmed.** The figure *"$65+2\cdot6=77$ against $65+6=71$"* at [sym3-stability.md:63](../findings/sym3-stability.md) is the same identity written from the other end, and it reconciles exactly: $65$ is the non-chiral count, $2\cdot6=12$ the chiral one. The block at line 48 and the section at line 63 are consistent.

**The multiplicity bookkeeping, which the block does not state and which works.** The six pairs carry multiplicities $2,1,1,1,1,1$, summing to $7$. Each pair contributes that multiplicity *twice* on the $SO(12)$ side, once per chirality: $2\cdot7=14$. The non-chiral multiplicity is therefore $191-14=177$. Fusing returns one $O(12)$ block per pair at the pair's own multiplicity, so the $O(12)$ total is $177+7=\mathbf{184}$. **Confirmed exactly.** This is the sharpest check available without the table: it uses all four reported figures ($191$, $184$, the six pairs and the list $2,1,1,1,1,1$) and a transcription error in any one of them would break it. It does not break.

**A resolvable ambiguity, worth fixing.** Line 48 gives the multiplicities as an ordered list $2,1,1,1,1,1$ with no labels attached; line 63 lists the six pairs and appends *"at multiplicity $2$"* to the last of them, $(2,2,1,1,1,\pm1)$. Read positionally, the two disagree about which pair carries the $2$. **The file settles it against the positional reading**: step 3 of *"The argument"* states $(2,2,2,2,2,2)$ occurs *with multiplicity $1$*, and $(2,2,2,2,2,\pm2)$ is the first entry of line 63's list. So the $2$ sits on $(2,2,1,1,1,\pm1)$ and line 48's ordering is not aligned with anything. The multiset is unaffected and so are all four totals; the fix is to attach the multiplicities to their labels at line 48, or to say the list is unordered.

**A fifth check the file supports, on the $n=10$ side.** $71\to64$ is seven blocks lost, and $184\to182$ only two multiplicities. That looks wrong until the two mechanisms are separated, and then it is forced: **associate identification merges** $\lambda$ with its associate, so five merges remove five blocks and **no multiplicities at all** (the two add); the **modification rule kills** $(2,2,2,2,2,2)$ and the $(2,2,2,2,2)$ it cancels against, removing two blocks and their multiplicities. $5+2=7$ blocks and $0+2=2$ multiplicities. **Both figures come out.** This is independent corroboration of the mechanism split at [sym3-stability.md:21](../findings/sym3-stability.md), reached without touching a table.

**One figure I could not reconcile, and it is outside L63.** The "unknowns" ($477$ at $n\ge12$, $493$ at $n=10$), are never defined in the file. Under the reading $\sum_\lambda m_\lambda(m_\lambda+1)/2$ (a Gram-matrix count per block) the numbers are consistent in *direction*, since merging blocks raises the total, and they force $\sum m_\lambda^2=770$ at $n\ge12$ against $804$ at $n=10$, both plausible against $\sum m_\lambda=184$ over $71$ blocks. That is a reconstruction, not a check. **The block does not mention the unknowns**, so this is a note on the file rather than a finding against L63: the file should say what an unknown is.

## 4. The separation claim, re-derived cold, and it holds

I rebuilt this from the definitions without consulting reviewers 177–179's reasoning beyond the statements the file records.

**The two groups.** $O(12)$ block labels correspond to $W(B_6)$-orbits of $\ell=\lambda+\rho$ (all sign changes and permutations); $SO(12)$ labels to $W(D_6)$-orbits (permutations and *even* sign changes). $\mathrm{Pf}=\prod_i\ell_i$ is $W(D_6)$-invariant and flips under an odd sign change, so it is **not** $W(B_6)$-invariant while $\mathrm{Pf}^2$ is. The file's claim on this point is right, and it is exactly why $\mathrm{Pf}$ must be excluded: for a chiral pair $\ell_6=\lambda_6\ne0$, so $\mathrm{Pf}\ne0$ takes opposite signs on the two halves and would split a block that fusion has joined. $\mathrm{Pf}^2$ agrees on both. **Confirmed.**

**Reviewer 178's correction is right, and I reproduce it.** The odd power sums vanish identically, so the even ones are the content: $p_2,p_4,p_6,p_8,p_{10}$ in $\ell$ are precisely $p_1,\dots,p_5$ in the variables $x_i=\ell_i^2$. Newton's identities in characteristic zero convert $p_1,\dots,p_k$ into $e_1,\dots,e_k$ and no further. A multiset of **six** elements is pinned by $e_1,\dots,e_6$; $e_1,\dots,e_5$ leave a one-parameter family. So $p_2,\dots,p_{10}$ genuinely fall one short, and $e_6(x)=\prod_i\ell_i^2=\mathrm{Pf}^2$ is the missing function. **The uncorrected statement was insufficient and the correction repairs it.** Confirmed independently.

**Independence of $\mathrm{Pf}^2$ from the other five.** $e_1,\dots,e_6$ of six variables are algebraically independent, and $\mathbb Q(p_1,\dots,p_5)=\mathbb Q(e_1,\dots,e_5)$ by Newton, so $e_6$ is not algebraic over $\mathbb Q[p_2,\dots,p_{10}]$. **Genuinely independent, not merely of a new degree.** The degree bookkeeping the file offers corroborates: $W(D_6)$ has degrees $2,4,6,8,10$ and $6$ (the Pfaffian), $W(B_6)$ has $2,4,6,8,10,12$, and $\mathrm{Pf}^2$ has degree $12$ in $\ell$, the missing slot exactly. Both statements are correct as written.

**Recovering the label from $\{\ell_i^2\}$, the step that makes separation work, and the file gets it right.** Dominance for $SO(12)$ gives $\lambda_1\ge\dots\ge\lambda_5\ge|\lambda_6|$, and $\rho=(5,4,3,2,1,0)$ has consecutive gaps $1$, so $\ell_i-\ell_{i+1}=\lambda_i-\lambda_{i+1}+1\ge1$ for $i\le4$ and $\ell_5-|\ell_6|=\lambda_5+1-|\lambda_6|\ge1$. Hence $\ell_1>\ell_2>\dots>\ell_5>|\ell_6|\ge0$, **strictly**. So the multiset $\{\ell_i^2\}$ has six distinct values except possibly a zero, sorting recovers $|\ell_i|$ uniquely, and $\rho_6=0$ gives $\ell_6=\lambda_6$ so the $O(12)$ label $\lambda_6\ge0$ comes back. **Confirmed, and this is injectivity, not merely well-definedness**, 177's objection is correctly met.

**The hypothesis the file flags is real and is discharged in the same file.** An $O(12)$ label with seven or more rows is the $\det$-twist of one with at most five and restricts to the same $SO(12)$ module, so no function of $\ell$ could tell them apart. The file says this does not arise because every constituent has at most six rows in the stable range, **which is step 1 of *"The argument"*, the Newell–Littlewood bound $\lambda'_1\le6$, proved $389$-odd lines above.** The block does not make that cross-reference and should. It is the one place where *"The argument"* does carry load for this section.

**"Separate points" or "generate the ring", and which one the argument needs.** The file proves the *stronger* statement: $p_2,\dots,p_{12}$ generate the full $W(B_6)$-invariant ring, by Chevalley on the degrees $2,4,6,8,10,12$. For a finite group acting on a vector space over an infinite field the invariant ring separates orbits, so generation implies the separation of all $71$ blocks. **Both readings are true here and the stronger gives the weaker, so no equivocation is load-bearing.** One honest caveat on the phrasing: *"six invariants separate the $71$ blocks"* invites the reading that six are *needed* for those $71$ points, which is not established and is almost certainly false, $71$ points in a six-dimensional space are generically separated by far fewer. **Six is what generation costs, not what these $71$ points cost.** The sentence should say it separates *every* stable-range label, which is the true and useful statement.

**$p_{12}$ against $\mathrm{Pf}^2$, the file's own resolution is correct, and I verified the witness.** They are different polynomials: Newton's identity $p_6=e_1p_5-e_2p_4+e_3p_3-e_4p_2+e_5p_1-6e_6$ (in the $x_i=\ell_i^2$) shows each determines the other **given** $e_1,\dots,e_5$, so they generate the same extension of $\mathbb Q[p_2,\dots,p_{10}]$ while being distinct elements. The stated witness is exact: at the trivial block $\ell=\rho=(5,4,3,2,1,0)$, $\mathrm{Pf}^2=0$ since $\rho_6=0$, while $p_{12}=5^{12}+4^{12}+3^{12}+2^{12}+1=244\,140\,625+16\,777\,216+531\,441+4096+1=261\,453\,379$. **Matches the recorded figure exactly.** Reviewer 179's correction stands.

## 5. Stability, the Lemma is about $n=12$ alone, and the number carries two statements

**L63 as stated in [findings/](../findings/) and [results.md](../results.md) is purely $n=12$.** Every quantity in it is a $D_6$, $SO(12)$ or $O(12)$ quantity, and nothing in the block quantifies over $n$. The $n\ge12$ stability claim is the *file's* subject, stated at [sym3-stability.md:5](../findings/sym3-stability.md) and proved (modulo the census) by *"The argument"*, it is a **different statement**, and it is what would carry $71/184$ upward, not L63.

**And the record does not agree with itself about which statement L63 names.** [report/sections/diagram.tex:86](../report/sections/diagram.tex) and [report/sections/diagram-closed.tex:98](../report/sections/diagram-closed.tex) both gloss L63 as *"the block table is stable from $n=12$, threshold sharp"*, the stability theorem. [results.md:602](../results.md) and the findings block state the $n=12$ census. **One number, two statements, and they have different proofs and different labels**: the stability statement has an argument (so `Lemma` would be defensible for it, once the census it rests on is granted), the census does not. This is worth fixing however the label question lands, because the diagram's reading is the one that would let a reader think L63 is proven.

**Direction of dependence, which the block leaves implicit.** Stability *consumes* the census: step 3 needs $(2,2,2,2,2,2)$ to actually occur before $12$ is a threshold rather than a bound. So the stability theorem is **no stronger than** the census beneath it, and promoting the census to `Observation` correctly propagates.

## 6. Hedging clauses and pointers

**Hedges.** Four in scope, and the checklist's suspicion is warranted for one of them.

- *"the mathematics **has always been** in this file"* (line 46), **false**, as §1 shows by the file's own first revision.
- *"the argument is the surrounding material"*, the phrasing `bbfa159b` replaced, was the honest version of a false claim; the replacement is more precise and no more true.
- *"under a hypothesis worth stating"* (line 61), **clean**. The hypothesis is stated, it is real, and it is discharged by step 1 of the same file.
- *"makes the statement right rather than weaker"* (line 61), **clean and accurate**; the corrected list is strictly stronger, returning $e_6$ and hence injectivity.

**Pointers, all resolved.**

| pointer | resolves |
| --- | --- |
| *"The argument"*, [sym3-stability.md:7](../findings/sym3-stability.md) | section exists, **proves stability, not the census** |
| [fence-posts.md](../findings/fence-posts.md) post F32 for L64 | exists, line 215, with L64's block at 227 |
| [run_n12_stability.py](../scripts/runs/run_n12_stability.py) | exists, **reads** the table, does not derive it |
| [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl) | exists, 1343 bytes, dated 2026-08-29 |
| [REVIEW_r224.md](REVIEW_r224.md), [REVIEW_r225.md](REVIEW_r225.md) | exist, they audit **the stability theorem**, not L63's counts |
| [sym3-blocks.md](../findings/sym3-blocks.md), the re-file source | exists, and now contains none of L63's numbers |
| [conventions.md](../findings/conventions.md) | exists |

## 7. What is owed, and the one computation that would settle it

**Owed, and reachable without any computation:**

1. **Relabel.** `Observation L63`, verified at $n=12$, or split, keeping $\dim\mathcal W_{12}=1638$ at $(2,2,0,0,0,0)$ as a `Lemma` and the table as an `Observation`. Update [INDEX-results.md:77](../findings/INDEX-results.md), whose row still reads `Lemma` with no verdict.
2. **Correct the provenance note.** It should say the census is a decomposition run, name [run_n12_stability.py](../scripts/runs/run_n12_stability.py) and its pickle as the artifact, and say plainly that *"The argument"* proves **stability** of the table and not its entries. The three-route provenance now sitting only at [07-gradedness-split.tex:930](../report/sections/07-gradedness-split.tex) belongs in [findings/](../findings/).
3. **Attach the multiplicities to their labels** at line 48, or mark the list unordered, §3's ambiguity.
4. **Reconcile the diagram.** [diagram.tex](../report/sections/diagram.tex) and [diagram-closed.tex](../report/sections/diagram-closed.tex) name L63 as the stability theorem; the block names the census.
5. **Add the cross-reference** from the separation section's row hypothesis to step 1 of *"The argument"*, which discharges it.
6. **Restate the separation claim** as separating every stable-range label rather than *"the $71$ blocks"*, which suggests a minimality nobody has shown.

**Owed and needing computation, exactly one run.** Recompute $\mathrm{Sym}^3$ of the $O(n)$ universal character $(2,2)$ in the stable ring, by a route sharing no code with the pickle, and report the constituent count, the multiplicity total, and the sublist with $\lambda_6\ne0$ at $n=12$ with multiplicities.

- **$77$, $191$ and the six pairs at $2,1,1,1,1,1$ come back**: the census is confirmed by a second route, and L63 becomes a well-supported `Observation`. It does **not** become a `Lemma`, two agreeing runs are still runs.
- **Any count differs**: the block, the stability theorem above it, the $477$ unknowns, and the certificate problem's stated size all move together, since the stability argument's step 3 reads the threshold off this table.

**A cheaper intermediate exists and is not a decomposition.** [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl) is on disk. Reading it and listing the entries with $\lambda_6\ne0$ with their multiplicities would settle §3's label ambiguity and confirm the block's transcription against the artifact it came from, in seconds and with no plethysm. **I did not run it**, since the standing rule allows screening objects I construct rather than consulting the record's own numerical artifacts, and consulting it would blur a transcription check into evidence for the census. It is named here as the first thing to do when computation is next approved, before the full re-derivation.

## What this review did not do

No decomposition, no plethysm, no sweep. The screens were: Weyl's dimension formula at $D_6$ for $(2,2,0,0,0,0)$; the record's quartic closed form at $n=12$; $\binom{1640}3$; $p_{12}(\rho)$; and the integer bookkeeping of §3. Each is closed-form arithmetic on an object built for the check, and each is reported as a screen. **No screen is offered as evidence that the census is right**, only that the block's arithmetic is internally sound, which is what a hand check can reach.
