# Verifier v264, L63: dim W_12 = 1638 at highest weight (2,2,0,0,0,0), the Sym^3 census 77/191 with six chiral pairs, the fusion to 71/184, and the sum identity C(1640,3)

The brief was cold. No numerical work was done: every value below is exact and evaluated by hand, and no script was written or run. Log: [agent_logs/verify-L63-v264.log](../agent_logs/verify-L63-v264.log).

| # | claim | verdict |
|---|---|---|
| 1 | $\dim\mathcal W_{12}=1638$ | CONFIRMED AS ALGEBRA |
| 2 | $\mathcal W_{12}\otimes\mathbb C$ is the $D_6$ irreducible of highest weight $(2,2,0,0,0,0)$ | HYPOTHESIS-DEBT |
| 3 | census: $77$ $SO(12)$ constituents, $191$ multiplicities, twelve chiral in six pairs at $2,1,1,1,1,1$ | HYPOTHESIS-DEBT |
| 4 | fusion: a reflection fuses each chiral pair, $77\to71$, $191\to184$, given the census | CONFIRMED AS ALGEBRA |
| 5a | $\binom{1640}3=733\,813\,080=\dim\mathrm{Sym}^3\mathcal W_{12}$ | CONFIRMED |
| 5b | $\sum_\lambda m_\lambda d_\lambda$ over the table equals $\binom{1640}3$ | HYPOTHESIS-DEBT |
| 6 | Passage D's argument proves Passage A | GAP |
| 7 | Passage D: "$n=12$ is exactly where that begins" (the lower edge) | HYPOTHESIS-DEBT |
| 8 | Passage D, $n=10$: "$\lambda$ and its associate become the same $O(10)$ irreducible" | REFUTED AS STATED |
| 9 | Passage D: "$\dim\mathcal W_4=10=n$" | REFUTED AS STATED |
| 10 | Passage E is the claim, under the canon's label | GAP |

**Summary: the dimension and every piece of arithmetic check exactly, but the census that is L63's substance rests on program runs with no argument on file. The canon labels the whole of it "Lemma L63 (direct)" (Passages A, B, C), so the lemma is HYPOTHESIS-DEBT.**

## 0. Conventions, fixed once

- $V=\mathbb R^n$, $\mathcal W_n\subset V^{\otimes4}$ is the space of algebraic Weyl tensors. $\lambda'$ is the conjugate partition, so $\lambda'_1=\ell(\lambda)$ is the row count and $\lambda'_2$ counts parts $\ge2$.
- $D_6$ weights in orthogonal coordinates $(\lambda_1,\dots,\lambda_6)$, $\rho=(5,4,3,2,1,0)$. A constituent is chiral when $\lambda_6\ne0$.
- $[\lambda]_n$ is the $O(n)$ irreducible $E^\lambda_{(n)}$ of [Howe-Tan-Willenbring §1](https://arxiv.org/abs/math/0311159), defined for $\lambda'_1+\lambda'_2\le n$. $\lambda^*$ is the associate label, $\lambda$ with its first column replaced by $n-\lambda'_1$.
- "Block" is read as in Passage A: an $O(12)$ isotypic type in $\mathrm{Sym}^3\mathcal W_{12}$. "Multiplicity" is the multiplicity of that type.
- Brief line numbers refer to [BRIEF_L63.md](BRIEF_L63.md). Every quotation in Passages A to D was displayed at its cited source lines and matches verbatim. Passage E matches [L63Statement.lean](../lean/HamiltonsCubic/Results/L63Statement.lean) character for character (the file has 160 newline-terminated lines, the brief says 161, which is cosmetic).

## 1. Hypothesis inventory

**Of the statement (Passage A).**

| hypothesis | stated? | used by |
|---|---|---|
| $n=12$ | yes | all figures |
| the field: constituents counted over $\mathbb C$ by $D_6$ highest weights | no | the census. Counting over $\mathbb R$ agrees only when every constituent is of real type, which is unstated |
| $\mathcal W_{12}$ is $SO(12)$-irreducible | no | "the irreducible of highest weight" |
| each chiral pair has equal multiplicities on its two members | implicit ("pairs ... at multiplicities") | the fusion arithmetic |
| no non-chiral $SO(12)$ type is carried by both $[\lambda]_{12}$ and $[\lambda]_{12}\otimes\det=[\lambda^*]_{12}$ | **no** | $77\to71$ (see §4) |
| $d_\lambda$ is the dimension of the block (the $O(12)$ dimension for a fused pair) | no | $\sum m_\lambda d_\lambda$, which is the same number under either reading |

**Of the imported theorems.**

| import | filed? | hypotheses at source | used how |
|---|---|---|---|
| Labelling of $O(n)$ irreducibles by $\lambda'_1+\lambda'_2\le n$ | **yes**, [HTW §1](https://arxiv.org/abs/math/0311159) lines 79-86 (citing Goodman-Wallach Ch. 10, unfiled) | "each irreducible rational representation is indexed **uniquely**" by such $\nu$ | Passage D step 2 |
| Newell-Littlewood product | **partly**: HTW §2.1.2 (lines 206-211), attributed to Newell and Littlewood in HTW §2.5(a) | $\ell(\lambda)\le\lfloor n/2\rfloor$ **and** $\ell(\mu)+\ell(\nu)\le\lfloor n/2\rfloor$. The formula gives the multiplicity of targets $[\lambda]$ with $\ell(\lambda)\le\lfloor n/2\rfloor$ only | step 1, "in the stable range" (range unstated in D) |
| Koike-Terada specialisation $\pi_n$ from the universal character ring | **unfiled** (appears only as HTW bibliography entry [KT]) | not readable | step 4, and silently in step 1 (see §6) |
| $\pi_n$ commutes with $\mathrm{Sym}^3$ | **unfiled** | a $\lambda$-ring property, stronger than "ring homomorphism" | step 4 |
| Littlewood's (Newell's, King's) modification rules | **unfiled** (HTW cites [Ne], [Ki2]) | not readable | step 2, $n=10,11$ narrative |
| Weyl's dimension formula for $D_6$ | **unfiled** | standard | Lean `wdim_D6_two_two` |
| closed form $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ | **no derivation on file** in any quoted passage | valid for $n\ge3$ | Lean `weylDim_twelve` |

**Used but unstated:** the weight bound $|\lambda|\le12$ (Passage D step 3, "at total weight 12"), the stable range of step 1, the equal-multiplicity and no-det-twist hypotheses of the fusion, and the real type of the constituents.

## 2. Quantifier order and scope

- **At $n=12$ only:** everything in Passages A, B, C. The $SO(12)$ figures $77/191$ and the six chiral pairs are specific to $n=12$: at $n=13$ there is no chirality, and at $n=14$ a six-row label has $\ell=6<7=n/2$ and does not split. $\dim\mathcal W_{12}$, $\binom{1640}3$, the fusion.
- **For all $n\ge12$:** Passage D's "What is claimed", that the $O(n)$ table is $71/184/477$ for every $n\ge12$. Steps 1, 2, 4 are uniform in $n$. Step 3 is a statement about the universal label set, independent of $n$.
- **At $n=10$:** $64/182/493$ and the seven-block account.
- Passage A's $71/184$ is an instance of Passage D's universal claim only once the universal table is known, and the universal table itself is not derived (§3).

## 3. Claim 1, $\dim\mathcal W_{12}=1638$

**On file:** the closed form $n(n+1)(n+2)(n-3)/12$ (Lean `weylDim`, stated without derivation) and Weyl's dimension formula at $(2,2,0,0,0,0)$ (Lean `wdim_D6_two_two`). Neither passage derives the closed form or the identification of $\mathcal W_{12}$ with the highest weight.

**First closed form, exact:** $12\cdot13\cdot14\cdot9/12=13\cdot14\cdot9=1638$.

**Second closed form, exact.** For $D_6$ the positive roots are $e_i\pm e_j$, so $\dim=\prod_{i<j}(\ell_i^2-\ell_j^2)/(\rho_i^2-\rho_j^2)$ with $\ell=\lambda+\rho=(7,6,3,2,1,0)$. Squares: $\ell^2=(49,36,9,4,1,0)$, $\rho^2=(25,16,9,4,1,0)$. The factors with $i\ge2$ coincide in numerator and denominator ($5,8,9,3,4,1$) and cancel. What remains:

- numerator: $13\cdot40\cdot45\cdot48\cdot49$ (row $i=0$) and $27\cdot32\cdot35\cdot36$ (row $i=1$)
- denominator: $9\cdot16\cdot21\cdot24\cdot25$ and $7\cdot12\cdot15\cdot16$
- pairing: $\tfrac{40}{16}\cdot\tfrac{45}9\cdot\tfrac{48}{24}\cdot\tfrac{49}{21}\cdot\tfrac{32}{16}\cdot\tfrac{36}{12}\cdot\tfrac{35}7\cdot\tfrac{27}{15}=\tfrac52\cdot5\cdot2\cdot\tfrac73\cdot2\cdot3\cdot5\cdot\tfrac95$, times $13/25$
- $=13\cdot\tfrac{5\cdot5\cdot7\cdot2\cdot9}{25}=13\cdot7\cdot18=1638$.

The Lean definition `wdim` is exactly this product, and the two closed forms agree. **Verdict: CONFIRMED AS ALGEBRA.** Both evaluations are exact and correct. That the first closed form is $\dim\mathcal W_n$, and that the second applies to $\mathcal W_{12}$, rest on unfiled standard facts (the curvature-tensor dimension count, and claim 2).

## 4. Claim 2, the highest weight $(2,2,0,0,0,0)$

**On file:** Passage D step 1 asserts "$\mathcal W_n$ is the $O(n)$-irreducible labelled by the partition $(2,2)$" with no argument. The Lean header (brief lines 89-91) says the Weyl-formula value "is what pins the label".

**Candidate (a): "the second is what pins the label".**
1. *Location:* brief line 90-91, "Weyl's dimension formula for `D₆` at `(2,2,0,0,0,0)`. *The second is what pins the label*".
2. *Failure:* equal dimension does not determine the highest weight of a $D_6$ irreducible. $(1,1,1,1,1,1)$ and $(1,1,1,1,1,-1)$ are distinct highest weights, both of dimension $462$, since $\Lambda^6\mathbb C^{12}$ has dimension $\binom{12}6=924$ and splits into these two. A dimension match is a consistency check on the label, never an identification.
3. *Charitable reading:* the label comes from the construction (Young symmetry $(2,2)$ plus tracelessness), and the dimension match rules out off-by-one shapes. Read so, the phrase is an overstatement in a docstring, and the identification still has no argument on file.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: that $\mathcal W_{12}\otimes\mathbb C$ is $SO(12)$-irreducible and is the traceless $(2,2)$-symmetrised subspace of $V^{\otimes4}$, whose highest weight is $(2,2,0,0,0,0)$ (Weyl's construction, Goodman-Wallach Ch. 10, unfiled). The fact is textbook, and the record carries no argument or filed source for it.

## 5. Claim 3, the census

**On file:** nothing derives $77$, $191$, the twelve chiral constituents or the multiplicity list. Passage D's argument (steps 1-4) produces no count. Its "Verification" table (brief lines 43-48) reports four program routes and cites [run_n12_stability.py](../scripts/runs/run_n12_stability.py) plus two review files. The Lean file says so explicitly: "rests on a decomposition run with no argument on the record" (brief line 73-74), and "The census figures themselves are not derived here and cannot be stated here" (line 209).

**Screens the census survives, none of which is evidence for it:**
- Chiral constituents must come in pairs with equal multiplicity. $\mathrm{Sym}^3\mathcal W_{12}$ is an $O(12)$-module, and conjugation by a reflection sends $\lambda_6\mapsto-\lambda_6$ and carries one isotypic component onto the other. So "twelve, in six pairs" is forced to be even and paired, and says nothing about the value.
- The figures are internally consistent with the six-row labels of the universal table being exactly the chiral ones (§6): $71+6=77$, $184+7=191$.

**Falsifying object:** a decomposition of $\mathrm{Sym}^3\mathcal W_{12}$ with a different count. None can be exhibited in closed form without the decomposition, which this loop does not compute. **Verdict: HYPOTHESIS-DEBT.** What would have to be proved: the plethysm $h_3[o_{(2,2)}]=\sum_\lambda m_\lambda o_\lambda$ in the universal ring, or the $D_6$ decomposition, by an argument on file.

## 6. Claims 4, 5a, 5b: the fusion and the sum

**Claim 4, the arithmetic.** Six pairs at $2,1,1,1,1,1$ sum to $7$, and the chiral mass is $2\cdot7=14$. Non-chiral: $77-12=65$ types carrying $191-14=177$. Each fused pair is one $O(12)$ block of multiplicity equal to that of either member, so blocks are $65+6=71$ and multiplicities $177+7=184$. Exact, and identical to Lean `blocks_fused`, `mults_fused`, `fusion_chain`.

**Claim 4, the fusion.** A reflection $g\in O(12)\setminus SO(12)$ acts on $D_6$ weights by $\lambda_6\mapsto-\lambda_6$. So it swaps the two isotypic components of a chiral pair, and their sum is one $O(12)$ isotypic type (Clifford theory for the index-2 subgroup, standard, unfiled).

**The unstated hypothesis.** $77\to71$ also needs every non-chiral $SO(12)$ type to carry a single $O(12)$ type. A non-chiral $SO(12)$ irreducible is the restriction of both $[\lambda]_{12}$ and $[\lambda^*]_{12}=[\lambda]_{12}\otimes\det$, and if both occurred the $O(12)$ count would exceed $71$. For $\ell(\lambda)\le5$, $\lambda^*$ has $12-\ell(\lambda)\ge7$ rows. The hypothesis is therefore exactly Passage D step 1's row bound $\lambda'_1\le6$, applied to **all** $O(12)$ constituents. As §1 records, the filed Newell-Littlewood statement (HTW §2.1.2) gives multiplicities only for targets with $\ell(\lambda)\le\lfloor12/2\rfloor=6$ and is silent on the $\ge7$-row labels. The exclusion needs the unfiled Koike-Terada specialisation. **Verdict: CONFIRMED AS ALGEBRA**, given the census and that hypothesis.

**Claim 5a.** $\dim\mathrm{Sym}^3$ of a $d$-dimensional space is $\binom{d+2}3$, so $\binom{1640}3$ at $d=1638$. Exact: $1640\cdot1639=2\,687\,960$. Then $2\,687\,960\cdot1638=4\,300\,736\,000+102\,142\,480=4\,402\,878\,480$, and $/6$ gives $733\,813\,080$. **CONFIRMED** (given claim 1).

**Claim 5b.** $\sum m_\lambda d_\lambda=\dim\mathrm{Sym}^3\mathcal W_{12}$ holds for any correct decomposition. It is a check on the table only when the table is summed. No passage exhibits the table or the sum, the brief's line 47 reports it as a run ("holds at $n=12,13,14,16,18$"), and the Lean file types only the right-hand side (`symCube_dim`). **Verdict: HYPOTHESIS-DEBT.** The sum over the table is asserted.

## 7. Claim 6, Passage D against Passage A

Passage D proves, at best, a different statement: **the $O(n)$ table is independent of $n$ for $n\ge12$.** The chain, link by link:

- **Step 1, the row bound.** Correct as an arithmetic consequence of the Newell-Littlewood form ($c^\lambda_{\alpha\beta}\ne0$ forces $\ell(\lambda)\le\ell(\alpha)+\ell(\beta)\le\ell(\mu)+\ell(\nu)$, and $|\lambda|\le|\mu|+|\nu|$). The stable range is unstated in D. At source it is $\ell(\mu)+\ell(\nu)\le\lfloor n/2\rfloor$, which for the second product $4+2\le\lfloor n/2\rfloor$ holds exactly when $n\ge12$. The filed formula does not cover targets with more than $\lfloor n/2\rfloor$ rows (candidate (e), §11). Transfer from $\mathcal W^{\otimes3}$ to its summand $\mathrm{Sym}^3$ is immediate.
- **Step 2, the labelling condition.** Filed and read at source (HTW §1, lines 79-86), including "boundary inclusive" ($\le n$). CONFIRMED at source.
- **Step 3, the maximum.** The bound $\lambda'_2\le\lambda'_1\le6$ gives $\le12$. Equality forces six parts $\ge2$, and with $|\lambda|\le12$ every part is $2$. Correct given step 1 and the unstated weight bound. The conclusion "every other constituent is already admissible at $11$" follows. The Lean file [Sym3Threshold.lean](../lean/HamiltonsCubic/Results/Sym3Threshold.lean) carries only this integer arithmetic under hypotheses ($c_1\le6$, $c_2\le c_1$). **"Attained at $(2,2,2,2,2,2)$ ... with multiplicity 1" has no argument**: its Lean counterpart `attaining_label` proves $6+6=12\wedge6\cdot2=12$, which is not occurrence.
- **Step 4, Koike-Terada.** Unfiled. The sentence needs two properties, ring homomorphism and commuting with $\mathrm{Sym}^3$, and the second is the operative one.
- **Conclusion "for $n\ge12$ ... the table cannot move".** Follows from steps 1, 2, 4 given the unfiled imports.

None of $77$, $191$, $71$, $184$, $477$, the chiral pairs or their multiplicities is produced by steps 1-4. Every figure in D ("71 blocks, 184 multiplicities, 477 unknowns", "64, 182, 493") comes from the Verification table of runs. **Verdict: GAP.** The pointer names an argument for stability, conditional on unfiled Koike-Terada, and no argument for the table L63 states.

## 8. Claim 7, the lower edge "$n=12$ is exactly where that begins"

The upper half (nothing moves for $n\ge12$) is §7's conditional stability. The lower half needs the table at $n=11$ to differ, which needs $(2^6)$ to **occur** in the universal decomposition (and its specialisation at $n=11$ to change the counts). Occurrence and "multiplicity 1" rest on the run (brief line 46, "$n=11\to70/183$"). The $n=11$ mechanism is not stated in any passage, and the modification rules are unfiled. **Falsifying object:** a proof that $m_{(2^6)}=0$. **Verdict: HYPOTHESIS-DEBT.** What would have to be proved: $m_{(2^6)}\ne0$ in $h_3[o_{(2,2)}]$, and that its $O(11)$ modification changes the block table.

## 9. Claim 8, associate identification at $n=10$

**Candidate (b).**
1. *Location:* brief line 37, "five from **associate identification**, where $\lambda$ and its associate become the same $O(10)$ irreducible."
2. *Failure:* the filed source indexes $O(n)$ irreducibles **uniquely** by admissible labels (HTW §1, line 81-82). $\lambda$ and $\lambda^*$ are both admissible ($\lambda^{*\prime}_1+\lambda^{*\prime}_2=n-\lambda'_1+\lambda'_2\le n$), so they are distinct $O(10)$ irreducibles whenever $\lambda\ne\lambda^*$. Closed-form instance: $(1^4)^*=(1^6)$ at $n=10$, i.e. $\Lambda^4V$ and $\Lambda^6V$. Take the reflection $r=\mathrm{diag}(-1,1,\dots,1)$. Its trace on $\Lambda^4V$ is $\binom94-\binom93=126-84=42$, and on $\Lambda^6V$ it is $\binom96-\binom95=84-126=-42$. The characters differ, so these are distinct $O(10)$ irreducibles. They have the same $SO(10)$ restriction (Hodge star).
3. *Charitable reading:* "the same $O(10)$ irreducible" means the same $SO(10)$ irreducible, and "block" at $n=10$ means an $SO(10)$ type taken up to the outer automorphism. Under that reading the bookkeeping "lose 5 blocks and 0 multiplicities" is consistent, since a merged block carries $a+b$. But then the $n=10$ count uses a different notion of block from the one Passage A uses at $n=12$ ($O(12)$ isotypic types). On HTW's $O(10)$ indexing, and on the record's own account of the five merges, the $O(10)$ count would be $71-2=69$ blocks, with $182$ multiplicities.

The reading survives only by changing the group in the sentence. **Verdict: REFUTED AS STATED.** The convention for "block" is unstated and differs between $n=10$ and $n=12$. This touches Passage D's comparison "at $n=10$ it is $64$", and it leaves Passage A's figures untouched.

## 10. Claim 9, "$\dim\mathcal W_4=10=n$"

**Candidate (c).**
1. *Location:* brief line 50, "$\dim\mathcal W_3=0$ where $\lambda'_1+\lambda'_2=n+1$, and $\dim\mathcal W_4=10=n$".
2. *Failure:* at $n=4$, $4\cdot5\cdot6\cdot1/12=10\ne4=n$. For completeness, $\dim\mathcal W_3=3\cdot4\cdot5\cdot0/12=0$ is correct.
3. *Charitable reading:* the parallel clause intends "where $\lambda'_1+\lambda'_2=n$" (the column sum of $(2,2)$ is $4=n$). This makes the sentence correct and consistent with the inclusive boundary of HTW §1.

**Verdict: REFUTED AS STATED**, a transcription slip with no consequence for any figure.

## 11. Claim 10, Passage E against Passages A and C

- **Typed and correct:** `weylDim_twelve`, `wdim_D6_two_two`, `closed_forms_agree` (checked by hand in §3), `symCube_dim` (§6), `chiral_*`, `blocks_fused`, `mults_fused`, `fusion_chain` (§6), `ten_corroboration` ($71-5-2=64$, $184-0-2=182$). All are closed numeral arithmetic, true independently of any representation theory.
- **Stated by the file as untypable:** the census, and with it everything that makes $77,191,2,1,1,1,1,1$ facts about $\mathrm{Sym}^3\mathcal W_{12}$. The file's reason (no Mathlib theory of $SO(n)$ highest weights or plethysm) is accurate as a description of what it does.
- **Not typed and not flagged as such:** that $\mathcal W_{12}$ has highest weight $(2,2,0,0,0,0)$. `L63_dimension`'s docstring calls the value "the dimension of the $D_6$ irreducible of highest weight $(2,2,0,0,0,0)$", which the theorem supports only through the reading of `wdim` as Weyl's formula, and the header's "pins the label" overstates (candidate (a)).
- **Label.** The file follows a grading, quoted from an audit note, in which the census "is an `Observation` at `n = 12`" (brief lines 73-74). The canon carries no such split: Passage A is headed "Lemma L63", Passage B reads "**Lemma L63 (direct)**", Passage C is headed "Lemma L63". The census half of the canon's lemma earns HYPOTHESIS-DEBT.
- **Not checked:** the Lean header's report that "the record's heading list and the list below it disagree on where the `2` sits" (brief line 100) refers to text outside the passages quoted to me. Passages A and C both give $2,1,1,1,1,1$, and the fusion arithmetic reads only the multiset.

**Verdict: GAP.** Passage E is a faithful typing of the arithmetic and says so, and it is not the claim.

## 12. Passage C's sentence

"The table is the size of the certificate problem at the threshold dimension; it supplies the unknowns and no certificate." It is a description, with two dependencies:
- "the threshold dimension" inherits claim 7's HYPOTHESIS-DEBT on the lower edge.
- "the size of the certificate problem" presupposes a symmetry group that no quoted passage defines. The size is $71/184$ for $O(12)$-invariant certificates and $77/191$ if the certificate problem is $SO(12)$-invariant, since the chiral members are distinct $SO(12)$ types. "The unknowns" ($477$ in Passage D) are not given in Passage C and are not derived anywhere.

No finding beyond those dependencies: the sentence claims no certificate.

## 13. The edge of every range

| $n$ | record says | source of the figure | check |
|---|---|---|---|
| $10$ | $64/182/493$, seven blocks lost: $2$ by modification, $5$ by associate identification | runs | $71-7=64$, $184-2=182$ exact. The associate mechanism is refuted as stated (§9). The modification pair is consistent with the unfiled King rule (strip of length $2\cdot6-10=2$ from $(2^6)$ leaves the self-associate $(2^5)$), which this report does not rely on |
| $11$ | $70/183$ | run | loses one block and one multiplicity, consistent with $(2^6)$ vanishing at $O(11)$. No mechanism on file (§8) |
| $12$ | $77/191$ ($SO$), $71/184$ ($O$) | runs | six-row labels have $\lambda^*=\lambda$ at $\ell=n/2=6$ and split under $SO(12)$. The rows are consistent (§6) |
| $13$ | $71/184$ | run | odd $n$: no chiral splitting, and $\lambda^*$ has $\ge7$ rows, so $SO=O$ counts agree, consistent |
| self-associate labels | "present as full $O(12)$ irreducibles" | text | consistent with HTW's unique indexing: $(2^6)$ and every six-row label with $\lambda'_2\le6$ is admissible at $12$ |

**Wording, candidate (d)**, heading "by three mechanisms" (brief line 35) against two mechanisms named and "Neither mechanism" (line 37). Reported in §14.

## 14. Withdrawn candidates

- **(d) "three mechanisms".** Location: brief line 35. Failure: the paragraph names two mechanisms and closes with "Neither mechanism". Charitable reading: inadmissibility of $(2^6)$, its cancellation, and associate identification are counted as three, and the counts $2+5=7$ are unaffected. *Withdrawn at step 2: no figure fails.*
- **(e) Step 1's row bound is not delivered by the filed Newell-Littlewood statement.** Location: brief line 25, "it cannot raise the row count above the sum of its inputs'". Failure sought: an $O(n)$ product in the stable range with a constituent of more than $\ell(\mu)+\ell(\nu)$ rows. None exists, because the stable-range product specialises from the universal ring without modification. *Withdrawn at step 2: no concrete failure.* Retained as a sourcing gap in §1 and §6: the $\ge7$-row exclusion needs unfiled Koike-Terada.
- **(f) "a ring homomorphism commuting with $\mathrm{Sym}^3$".** Location: brief line 31. A ring homomorphism need not commute with $\lambda$-operations. But $\pi_n$, being evaluation on the eigenvalue alphabet, does commute. *Withdrawn at step 3: the charitable reading is correct.* Retained as unfiled in §1.

## 15. Falsifying objects and the search

| claim | falsifying object | what was done |
|---|---|---|
| 1 | an exact evaluation of either closed form $\ne1638$ | both evaluated by hand (§3) |
| 2 | a $D_6$ highest weight other than $(2,2,0^4)$ for $\mathcal W_{12}\otimes\mathbb C$, or its reducibility | none sought computationally. Showed that dimension cannot decide it ($462=462$) |
| 3 | the decomposition with any different count | not searchable without computation. No closed-form argument on file to attack |
| 4 | a non-chiral type carried by both $[\lambda]_{12}$ and $[\lambda^*]_{12}$, or a chiral pair with unequal multiplicities | the second is impossible (§5). The first is equivalent to a $\ge7$-row constituent, excluded by step 1 via unfiled Koike-Terada |
| 5a | $\binom{1640}3\ne733\,813\,080$ | evaluated by hand |
| 5b | the table's sum $\ne\binom{1640}3$ | table absent from the passages |
| 6 | a figure of Passage A derived in Passage D | read steps 1-4. None is |
| 7 | $m_{(2^6)}=0$ | no argument on file either way |
| 8 | two associate labels giving the same $O(10)$ irreducible | exhibited the opposite: $\Lambda^4V\not\cong\Lambda^6V$ under $O(10)$ |
| 9 | $\dim\mathcal W_4\ne4$ | $10$ |
| 10 | a typed proposition equivalent to the census | the file has none, by its own account |

## Overall verdict

**HYPOTHESIS-DEBT.** $\dim\mathcal W_{12}=1638$, $\binom{1640}3=733\,813\,080$ and the fusion arithmetic are exact and correct. The census ($77$, $191$, the six chiral pairs at $2,1,1,1,1,1$), the sum over the table, the highest-weight identification and the lower edge of the threshold have no argument on file and rest on runs or unfiled sources. The canon labels all of it Lemma L63. The argument section the block points to proves a different statement, stability for $n\ge12$ conditional on unfiled Koike-Terada. Its $n=10$ account misstates associate identification as an $O(10)$ identification.
