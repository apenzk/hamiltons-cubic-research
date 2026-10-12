# Verifier v263, Lemma L63: dim W_12 = 1638 and its highest weight (2,2,0,0,0,0), the Sym^3 census 77/191 with six chiral pairs, the O(12) fusion to 71/184, the total C(1640,3), Passage D as support, and the Lean statement

Cold brief ([BRIEF_L63.md](BRIEF_L63.md)). No numerical work: no scripts written or run, the Lean file was read and not built, every value below is exact and computed by hand. Log: [agent_logs/verify-L63-v263.log](../agent_logs/verify-L63-v263.log).

| # | claim | verdict |
|---|---|---|
| 1 | $\dim\mathcal W_{12}=1638$ | CONFIRMED AS ALGEBRA |
| 2 | $\mathcal W_{12}$ is the $D_6$ irreducible of highest weight $(2,2,0,0,0,0)$ | GAP |
| 3 | census: $77$ $SO(12)$ constituents, $191$ multiplicities, twelve chiral in six pairs at $2,1,1,1,1,1$ | HYPOTHESIS-DEBT |
| 4a | fusion arithmetic $77\to71$, $191\to184$ given the census | CONFIRMED AS ALGEBRA |
| 4b | "So $O(12)$ sees $71$ blocks and $184$ multiplicities" from the fusion alone | GAP (unstated hypothesis) |
| 5a | $\binom{1640}3=733\,813\,080=\dim\mathrm{Sym}^3$ of a $1638$-dimensional space | CONFIRMED |
| 5b | $\sum_\lambda m_\lambda d_\lambda$ over the table equals it, as a check on the table | HYPOTHESIS-DEBT |
| 6 | Passage D's argument as support for Passage A | GAP (proves a different statement) |
| 7 | Passage E, the Lean statement, against the claim | CONFIRMED AS ALGEBRA (docstring overclaims on the label) |
| 8 | canonical label "Lemma L63 (direct)" on the whole statement | REFUTED AS STATED |

Summary: the dimension is exact and the fusion arithmetic is right, but the census, which carries every other figure, rests on runs with no argument on file, and the highest-weight identification is argued only by a dimension match that cannot pin a module.

## 0. Conventions, fixed once

- $\mathcal W_n$: algebraic Weyl tensors on $\mathbb R^n$. $D_6$ weights in orthogonal coordinates $(\lambda_1,\dots,\lambda_6)$, $\rho=(5,4,3,2,1,0)$. Chiral means $\lambda_6\ne0$.
- $O(n)$ labels: partitions $\lambda$ with $\lambda'_1+\lambda'_2\le n$. $[\lambda]$ is the $O(n)$-irreducible, $\varepsilon=\det$, $\lambda^*$ the associate (first column replaced by $n-\lambda'_1$), $[\lambda^*]\cong[\lambda]\otimes\varepsilon$.
- A "block" at $n=12$ is an $O(12)$-isotypic component, as Passage A's fusion sentence fixes it.
- Quotations: Passages A to D were compared against the cited lines only ([sym3-stability.md](../findings/sym3-stability.md) lines 3-36, 44, 58; [results.md](../results.md) lines 222, 757, 759) and match verbatim. Passage E matches [L63Statement.lean](../lean/HamiltonsCubic/Results/L63Statement.lean) verbatim. The brief says 161 lines, the file has 160 newline-terminated lines, and the difference is the brief's blank line before the closing fence.
- Screens (seconds of hand arithmetic on objects built for the purpose) are marked as screens and are never evidence for a positive claim.

## 1. Hypothesis inventory

**Of the statement (Passages A, B, C).**

- $n=12$, the group $SO(12)$ for the census and $O(12)$ for the block table. Stated.
- The field of the decomposition. Unstated. At $n=12$ it is harmless in the reading that $D_6$ irreducibles of $SO(12)$ are self-dual (rank $6$ even) and occur in real tensor powers, so real and complex counts agree. This is an unfiled standard fact. At $n=10$ ($D_5$) chiral pairs are complex conjugate and the real and complex counts differ, which matters only for Passage D's $n=10$ figures.
- That no non-chiral $SO(12)$ constituent $V_\lambda$ of $\mathrm{Sym}^3\mathcal W_{12}$ occurs under both $O(12)$ extensions $[\lambda]$ and $[\lambda]\otimes\varepsilon$. **Used by "So $O(12)$ sees $71$ blocks", unstated in A, B and C.** See 3.4, item 4b.
- That chiral constituents come in pairs $(\dots,\lambda_6)$, $(\dots,-\lambda_6)$ at equal multiplicity. Stated as a count, unargued. It follows from $O(12)$-stability of $\mathrm{Sym}^3\mathcal W_{12}$ by index-2 Clifford theory, unfiled.

**Of the imported theorems.**

| import | where used | filed? |
|---|---|---|
| $\mathcal W_n$ is irreducible, highest weight $(2,2,0,\dots)$ | A, B, C, D step 1 | irreducibility under $SO(n)$ for $n\ne4$ stated without proof at [viaclovsky-865-fall-2007.txt](https://www.math.uci.edu/~jviaclov/courses/865_Fall_2007.pdf) lines 913-914 ("This turns out to be an irreducible decomposition as an SO(n)-module, except in dimension 4"). Highest weight: unfiled |
| $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ | Lean `weylDim` | ingredients filed: $\dim\mathcal C=n^2(n^2-1)/12$ at Viaclovsky (4.25), lines 776-780, and $\mathcal C=\mathcal W\oplus\psi(S^2_0)\oplus\psi(\mathbb Rg)$ at (5.4), lines 909-913. The subtraction itself is not on the record |
| Weyl's dimension formula for $D_n$ | Lean `wdim` | unfiled |
| Newell–Littlewood product rule | D step 1 | unfiled. Cited only in the remarks and bibliography of [htw-math0311159.txt](https://arxiv.org/abs/math/0311159), lines 251, 290, 1689 |
| Weyl's labelling condition $\lambda'_1+\lambda'_2\le n$ | D step 2 | unfiled |
| Littlewood / King / Newell modification rules | D step 2, $n=10$ paragraph | unfiled (HTW line 281 and bibliography line 1656 only) |
| Koike–Terada specialisation, a ring map commuting with $\mathrm{Sym}^3$ | D step 4 | unfiled (HTW bibliography line 1678 only) |
| Clifford theory for $SO(12)\subset O(12)$ | A's fusion | unfiled |
| $\dim\mathrm{Sym}^3 V=\binom{d+2}3$ | A, E | elementary |

**Used but unstated in Passage D.**

- D step 4 needs, besides specialisation, that distinct stable labels specialise to **non-isomorphic** $O(n)$ irreducibles for $n\ge12$, so that no associate coincidence occurs. D names associate identification as a separate mechanism at $n=10$ and then asserts "Neither mechanism operates at $n\ge12$" (line 21) with no argument. It follows from step 1's row bound ($\lambda^*$ has $n-\lambda'_1\ge n-6\ge6$ rows, equal to $6$ only when $n=12$, $\lambda'_1=6$, where $\lambda^*=\lambda$), but that line is not written.
- D step 1 invokes Newell–Littlewood "in the stable range" to bound rows at the $n$ whose stability is being decided. It is non-circular only when read as a statement about labels in the universal character ring, transported by step 4. The written order puts step 1 before its justification.
- D step 3 "which at total weight $12$": constituents have weight $12,10,\dots$, not $12$. The argument needs only weight $\le12$, since six parts $\ge2$ force weight $\ge12$. Withdrawn as a defect in 7.3.
- D step 3 "attained at $(2,2,2,2,2,2)$ ... with multiplicity $1$": the occurrence and the multiplicity are census facts with no argument on file.

## 2. Quantifier order and scope

- **Passages A, B, C:** every figure is at $n=12$ only. No quantifier over $n$.
- **Passage D, "What is claimed":** $\forall n\ge12$, the $O(n)$ table is the same, plus the existential "$n=12$ is exactly where that begins" (the table at $n=11$ differs). The figures $71/184/477$ "at $n\ge12$" and $64/182/493$ at $n=10$ come from the run table (lines 29-32).
- **Passage D's argument** proves, modulo imports, the $\forall n\ge12$ statement about the label set and multiplicities being $n$-independent. It fixes no figure.
- **Passage E:** every theorem is a closed statement about numerals at $n=12$ (and the $n=10$ subtraction). `weylDim` is a function of $n$, but only its value at $12$ is proved. No theorem quantifies over constituents.
- **[Sym3Threshold.lean](../lean/HamiltonsCubic/Results/Sym3Threshold.lean):** `column_sum_bound`, `equality_forces_six` and `others_admissible_earlier` quantify over natural numbers $c_1,c_2,c$, not over constituents of $\mathrm{Sym}^3$. The link "every constituent has $c_1\le6$" is a hypothesis of those theorems, supplied by the unfiled row bound.

## 3. The claims

### 3.1 Claim 1, $\dim\mathcal W_{12}=1638$: CONFIRMED AS ALGEBRA

**First closed form.** $12\cdot13\cdot14\cdot9/12=13\cdot14\cdot9=1638$. In $\mathbb N$, $12\cdot13\cdot14\cdot9=19656=12\cdot1638$, so the truncating division in `weylDim` is exact. The closed form agrees with the filed ingredients: $\frac{n^2(n^2-1)}{12}-\frac{n(n+1)}2=\frac{n(n+1)(n^2-n-6)}{12}=\frac{n(n+1)(n+2)(n-3)}{12}$, using Viaclovsky (4.25) and the decomposition (5.4). At $n=12$: $1716-78=1638$. The subtraction is my check against the source, not an argument on the record.

**Second closed form.** $\ell=\lambda+\rho=(7,6,3,2,1,0)$, squares $(49,36,9,4,1,0)$ against $\rho$ squares $(25,16,9,4,1,0)$. Factors $\ell_i^2-\ell_j^2$ with $i,j\ge2$ coincide with $\rho$'s and are nonzero ($5,8,9,3,4,1$), so they cancel. The remaining ratio:

| pair | $\ell$ | $\rho$ |
|---|---|---|
| (0,1) | $13$ | $9$ |
| (0,2) | $40$ | $16$ |
| (0,3) | $45$ | $21$ |
| (0,4) | $48$ | $24$ |
| (0,5) | $49$ | $25$ |
| (1,2) | $27$ | $7$ |
| (1,3) | $32$ | $12$ |
| (1,4) | $35$ | $15$ |
| (1,5) | $36$ | $16$ |

Numerator $=2^{14}3^{8}5^{3}7^{3}13$, denominator $=2^{13}3^{6}5^{3}7^{2}$, ratio $2\cdot3^2\cdot7\cdot13=1638$. So `wdim_D6_two_two` and `closed_forms_agree` state true equalities.

**Label.** The value is exact by both routes. The first closed form is not derived in any quoted passage, though its ingredients are filed. Weyl's dimension formula is unfiled. So: CONFIRMED AS ALGEBRA.

### 3.2 Claim 2, the highest weight $(2,2,0,0,0,0)$: GAP

**The argument on file.** Passage E lines 90-91: "*The second is what pins the label, which the audit calls the part that was wrong.*" Lines 128-129: "**Second closed form, and the one that pins the label.**" Passage D step 1 asserts "$\mathcal W_n$ is the $O(n)$-irreducible labelled by the partition $(2,2)$" with no argument.

**Candidate G1: a dimension match does not pin a module.**

1. *Locate.* Passage E lines 128-130 and 198-203, where `L63_dimension` equates two numbers and the docstring reads it as "that value is the dimension of the $D_6$ irreducible of highest weight $(2,2,0,0,0,0)$".
2. *Exhibit.* Weyl's formula at $(2,2,0,0,0,0)$ returning $1638$ shows that irreducible has dimension $1638$. It says nothing about $\mathcal W_{12}$. The $SO(12)$-module $\mathbb C^{1638}$ with trivial action also has dimension $1638$ and highest weight $0$. Closer to home, the curvature-tensor space $\mathcal C_{12}$ has $\dim=1716=1638+77+1$ and is reducible, so a dimension count certifies neither irreducibility nor a label.
3. *Charitable reading.* The inference would go through given (i) $\mathcal W_{12}$ is $SO(12)$-irreducible and (ii) $(2,2,0,0,0,0)$ is the only $D_6$ dominant weight of dimension $1638$ among those that can occur in $V^{\otimes4}$. (i) is stated without proof at Viaclovsky line 913. (ii) appears nowhere on the record. Alternatively the classical identification of Weyl tensors with the traceless $(2,2)$ Young-symmetrised tensors would settle it outright, but it is unfiled. The candidate survives.

**What would have to be proved.** That $\mathcal W_{12}\otimes\mathbb C$ is irreducible with highest weight $2\omega_2=(2,2,0,0,0,0)$, e.g. by exhibiting the highest weight vector in $\mathcal W_{12}$ and citing irreducibility at source. The claim is classically true, and the record's argument for it is invalid: GAP.

### 3.3 Claim 3, the census: HYPOTHESIS-DEBT

- **No passage derives it.** Passages A, B, C assert $77$, $191$, the six pairs and $2,1,1,1,1,1$. Passage D's argument (lines 9-17) contains no figure. The figures appear only in the verification table (lines 29-32): "Weyl character formula, block by block | ... $n=12\to77/191$ (SO)", and "Littlewood's inverse restriction formula ... $71/184/477$". Both rows report program runs ([run_n12_stability.py](../scripts/runs/run_n12_stability.py) and two reviews, which were not opened).
- **Passage E agrees.** Its quoted audit note (lines 72-74) calls the census "a decomposition run with no argument on the record, so it is an Observation at $n=12$", and line 78-84 state that it is not typed.
- **What would have to be proved.** The expansion $h_3[o_{(2,2)}]=\sum_\lambda m_\lambda o_\lambda$ in the universal orthogonal character ring, by hand: $71$ labels, $184$ total multiplicity, exactly six labels with six rows, carrying multiplicities $2,1,1,1,1,1$, including $(2^6)$ at multiplicity $1$. Then the restriction to $SO(12)$ gives $77/191$.
- **Screens (not evidence).** The reported figures are mutually consistent under the conventions of section 0. $71+6=77$ and $184+7=191$ match six six-row labels of total multiplicity $7$. $n=13$: $SO(13)$ counts equal $O(13)$ counts because $-I$ acts trivially on $\mathrm{Sym}^3\mathcal W_{13}\subset V^{\otimes12}$ and by opposite signs on $[\lambda]$ and $[\lambda]\otimes\varepsilon$, so at most one of each associate pair occurs. So $71/184$ at $n=13$ is what stability predicts. $n=11$: the same parity argument makes $SO(11)$ and $O(11)$ counts equal, and $70/183=71-1/184-1$ is consistent with the single label $(2^6)$ at multiplicity $1$ dropping out. None of this bears on whether $71/184$ is right.

### 3.4 Claim 4, the fusion

#### 4a. Arithmetic: CONFIRMED AS ALGEBRA

Given twelve chiral constituents in six pairs, each member of pair $i$ at multiplicity $m_i$, with $(m_i)=(2,1,1,1,1,1)$:

- Blocks: each pair becomes one block, $77-6=71$.
- Multiplicities: the chiral mass is $2\sum m_i=14$, the non-chiral mass is $191-14=177$, each fused block carries $m_i$ once, $177+7=184$.

In $\mathbb N$ all subtractions stay non-negative, so `blocks_fused`, `mults_fused` and `fusion_chain` state true equalities. That each fused pair carries $m_i$ (not $2m_i$) is correct: $V_+\oplus V_-$ is the restriction of one $O(12)$-irreducible, so $m$ copies of each give $m$ copies of that irreducible.

#### 4b. From $SO(12)$ counts to $O(12)$ counts: GAP (unstated hypothesis)

**Candidate F1: fusing chiral pairs does not by itself give the $O(12)$ block count.**

1. *Locate.* Passage A: "an orientation-reversing element fuses each pair into one $O(12)$ block. So $O(12)$ sees $\mathbf{71}$ blocks and $\mathbf{184}$ multiplicities". Passage C: the same, "so $O(12)$ sees $71$ blocks with $184$ multiplicities".
2. *Exhibit.* A non-chiral $V_\lambda$ ($\lambda_6=0$) has two non-isomorphic $O(12)$ extensions, $[\lambda]$ and $[\lambda]\otimes\varepsilon=[\lambda^*]$. The $O(12)$-module $\mathbb C^{12}\oplus\Lambda^{11}\mathbb C^{12}$ restricts to $SO(12)$ as $V_{(1,0,0,0,0,0)}$ at multiplicity $2$, one non-chiral constituent with no chiral pairs, yet has two $O(12)$ blocks: a reflection has trace $10$ on $\mathbb C^{12}$ and $-10$ on $\Lambda^{11}\mathbb C^{12}\cong\mathbb C^{12}\otimes\varepsilon$. "Fuse the chiral pairs, the rest carry over" would report one block. So the "So" needs: no non-chiral constituent of $\mathrm{Sym}^3\mathcal W_{12}$ occurs under both extensions.
3. *Charitable reading.* The hypothesis holds for $\mathrm{Sym}^3\mathcal W_{12}$ given Passage D: by step 1 every stable label has at most six rows, by step 4 with no modification at $n=12$ these are the $O(12)$ constituents, and for $\lambda'_1<6$ the associate $\lambda^*$ has $12-\lambda'_1\ge7$ rows, so it never occurs. The claim is therefore true given D's imports. It is not stated in A or C, and the imports it rests on (Newell–Littlewood, Koike–Terada) are unfiled. The candidate survives as an unstated hypothesis, not as a refutation.

Moreover, the brief's own run table reports $71/184$ directly by the Littlewood route, so the $O(12)$ figures, like the $SO(12)$ ones, rest on runs.

### 3.5 Claim 5, $\sum m_\lambda d_\lambda=\binom{1640}3$

#### 5a. CONFIRMED

$\dim\mathrm{Sym}^3V=\binom{d+2}3$ for $\dim V=d$, so with $d=1638$ it is $\binom{1640}3$. By hand: $1640\cdot1639=2\,687\,960$, times $1638$ is $4\,402\,878\,480$, divided by $6$ is $733\,813\,080$. `symCube_dim` states a true equality.

#### 5b. HYPOTHESIS-DEBT

For the true decomposition the identity holds automatically, so as a statement it adds nothing. As a check that the reported table (the $71$ labels with their multiplicities and $O(12)$ dimensions) is correct, it is asserted, not shown: no passage lists the $d_\lambda$ or carries out the sum. The only support is the run row "holds at $n=12,13,14,16,18$" (line 31). The Lean file types only the right-hand side.

### 3.6 Claim 6, Passage D against Passage A: GAP (proves a different statement)

**What D's argument establishes, link by link.**

- **Step 1 (row bound).** In the Newell–Littlewood product $[\mu][\nu]=\sum c^\mu_{\alpha\beta}c^\nu_{\alpha\gamma}c^\lambda_{\beta\gamma}[\lambda]$, $\ell(\lambda)\le\ell(\beta)+\ell(\gamma)\le\ell(\mu)+\ell(\nu)$. So a threefold product of $(2,2)$ has labels with $\le6$ rows, and $\mathrm{Sym}^3$ is a summand. Valid given the import, read in the universal ring (section 1). Import unfiled.
- **Step 2 (labelling condition).** Weyl's classification of $O(n)$-irreducibles. Correct as stated, unfiled.
- **Step 3 (maximum $12$).** $\lambda'_2\le\lambda'_1\le6$ gives $\lambda'_1+\lambda'_2\le12$. Equality forces six parts all $\ge2$, weight $\ge12$, and weight $\le12$ forces all parts $=2$. The bound and uniqueness are CONFIRMED AS ALGEBRA. "Attained ... with multiplicity $1$" is a census fact with no argument (HYPOTHESIS-DEBT). Without attainment the threshold could be $\le11$.
- **Step 4 (Koike–Terada).** If the specialisation is a $\lambda$-ring homomorphism, $h_3[o_{(2,2)}]$ decomposes once in the universal ring and specialises to $\mathrm{Sym}^3\mathcal W_n$. With step 3, no label is modified at $n\ge12$. With the unwritten associate step (section 1), distinct labels stay distinct. Valid given imports, unfiled.

**Conclusion.** D proves, modulo three unfiled imports, one unargued attainment and one unwritten line, that the $O(n)$ table is independent of $n$ for $n\ge12$. It proves none of Passage A's figures: not $1638$, not the label, not $77/191$, not the pairs, not $71/184$. It does supply the hypothesis 4b needs. The pointer from Passage A's block to this section names an argument for a different statement.

### 3.7 Claim 7, Passage E: CONFIRMED AS ALGEBRA (docstring overclaims on the label)

- **What is typed.** `weylDim_twelve`, `wdim_D6_two_two`, `closed_forms_agree`, `symCube_dim`, `chiral_pairs_count`, `chiral_mult_sum`, `chiral_mass`, `blocks_fused`, `mults_fused`, `fusion_chain`, `ten_corroboration`, `L63_dimension`, `L63_fusion`. Each is a closed identity between numerals, and each was checked true by hand (sections 3.1, 3.4, 3.5, and $71-5-2=64$, $184-0-2=182$). The file was not built.
- **What is not the claim.** `L63_dimension` states $\mathrm{weylDim}(12)=1638$ and a ratio identity. It contains no module, so it does not state that $\mathcal W_{12}$ has highest weight $(2,2,0,0,0,0)$. Its docstring (lines 198-200) and lines 90-91, 128-129 read it as pinning the label, which section 3.2 shows it cannot. `L63_fusion` takes $77$, $191$ and the multiset as numerals, so it is the arithmetic of 4a, not 4b and not the census.
- **What the file says cannot be stated.** Lines 76-84: the census, for want of Mathlib machinery for $SO(n)$ irreducibles and plethysm. That is an accurate account of what is typed.
- **Label.** The file follows the grading "Lemma for the dimension, Observation for the census" (lines 70-74). The canon does not (section 3.8).
- **The chiral list position.** Lines 100-103 record that the findings file's heading list and a list below it disagree on where the $2$ sits. That list lies in the prior-verdict lines I may not read, so it was not checked. The multiset is what 4a reads, so 4a is unaffected.

### 3.8 Claim 8, the canonical label: REFUTED AS STATED

**Candidate L1: "Lemma" on a statement whose substance has no argument.**

1. *Locate.* [results.md](../results.md) line 222: "**Lemma L63 (direct). The $n=12$ block table.**", line 757: "##### Lemma L63, the $n=12$ block table", [sym3-stability.md](../findings/sym3-stability.md) line 44: "#### Lemma L63, the $n=12$ block table".
2. *Exhibit.* The census (claim 3) and every figure derived from it (4b, 5b) have no argument in any quoted passage. Their only support is the run table at lines 29-32. Passage E's quoted audit note grades that half an Observation.
3. *Charitable reading.* (i) "direct" might mean "verified directly by computation", which is a description of a run, and a run earns HYPOTHESIS-DEBT under this loop's rules, not Lemma. (ii) Passage D might be the proof. It proves stability, not the figures (3.6). (iii) The whole might count as a Lemma through the dimension half. The dimension half is one clause of four and carries its own GAP on the label. The candidate survives.

**Label each part earns.** $\dim\mathcal W_{12}=1638$: Lemma-grade arithmetic. Highest weight: GAP. The census and the $O(12)$ table: Observation (HYPOTHESIS-DEBT). The fusion arithmetic: Lemma-grade conditional on the census.

## 4. The edge of every range

- **$n=10$.** Outside the statement. D reports $64/182/493$ from a run, $7$ blocks lost ($2$ by modification, $5$ by associate identification). Screen: with King's rule, $h=2\lambda'_1-n=2$ for $(2^6)$ removes a horizontal strip of two columns, so $[2^6]=-\varepsilon[2^5]=-[2^5]$ (self-associate at $n=10$), which cancels one $(2^5)$: $2$ blocks and $2$ multiplicities if both carry multiplicity $1$. That matches. The other five six-row labels with $\lambda'_2\le4$ become $\varepsilon[\mu]$, and "loses $5$ blocks and $0$ multiplicities" is what merging each with $[\mu]$ would give. The wording candidate on that merge is in 7.1. **Falsifier named:** a stable label $(3,2,2,2,2,1)$ (six rows, $\lambda'_2=5$). At $n=10$ its strip of length $2$ from the foot of column 1 is not removable, so it would vanish, adding a loss D does not account for. Whether it occurs is a census fact, so this was not decided.
- **$n=11$.** Only $(2^6)$ is inadmissible (step 3). Its $h=1$ strip leaves a non-diagram, so it vanishes. Consistent with $70/183$ (screen, 3.3).
- **$n=12$.** All labels admissible. Six-row labels have $\lambda'_1=6=n/2$, so $\lambda^*=\lambda$ and each $O(12)$-irreducible splits into a chiral pair under $SO(12)$. Non-six-row labels have associates with $\ge7$ rows, absent. This is the content of D line 34, and it is what 4b needs.
- **$n=13$.** Stable, $SO(13)$ and $O(13)$ counts agree by the $-I$ parity (3.3), so $71/184$ is the predicted value.
- **The Weyl-tensor boundary.** D line 34 "$\dim\mathcal W_3=0$ where $\lambda'_1+\lambda'_2=n+1$": $3\cdot4\cdot5\cdot0/12=0$, correct. "$\dim\mathcal W_4=10=n$": see 7.2.

## 5. What to attack, item by item

1. **$\dim\mathcal W_{12}$ and the highest weight.** The dimension: two closed forms, both exact (3.1), neither derived in a quoted passage, ingredients of the first filed at Viaclovsky (4.25), (5.4). The highest weight: no argument, only the dimension match, which is invalid as a proof (3.2, GAP).
2. **The census.** No passage derives it. It rests on runs. Label: Observation, HYPOTHESIS-DEBT (3.3).
3. **The fusion.** Arithmetic correct (4a). "Each pair fuses to one block" is index-2 Clifford theory, true and unfiled. "So $71$ and $184$" needs the unstated hypothesis that no non-chiral constituent occurs under both $O(12)$ extensions (4b, GAP).
4. **$\sum m_\lambda d_\lambda$.** $\binom{1640}3=\dim\mathrm{Sym}^3\mathcal W_{12}$ is correct (5a). The table's sum is asserted, supported only by a run (5b).
5. **D against A.** D proves stability of the table for $n\ge12$, a different statement. It proves no figure of A (3.6).
6. **D's steps against sources.** Newell–Littlewood: unfiled (cited HTW lines 251, 290, 1689). Labelling condition: unfiled. Koike–Terada: unfiled (HTW line 1678). Modification rules: unfiled (HTW lines 281, 1656). Each step is logically valid given its import. Step 3's attainment is unargued. The associate step for $n\ge12$ is unwritten (section 1).
7. **Passage C's closing sentence.** "The table is the size of the certificate problem at the threshold dimension; it supplies the unknowns and no certificate." No finding on correctness: it is a scope statement, and it truthfully claims no certificate. Two notes. "The certificate problem" is not defined in the brief, so "the size" cannot be checked. "The threshold dimension" imports D's stability claim, whose support is as in 3.6. "Supplies the unknowns" refers to the $477$ that appears only in D's run table, not in C.
8. **Passage E against A and C.** Typed: the dimension arithmetic, the binomial, the fusion arithmetic, the $n=10$ subtraction. Not typed and said to be unstatable: the census, correctly. The label the file follows (census as Observation) does not match the canon's "Lemma L63 (direct)" (3.8). The docstring's "pins the label" overclaims (3.2).
9. **The boundary.** Section 4. $n=11$, $12$, $13$ as D reports them are mutually consistent under the screens. The self-associate labels at $\ell=n/2=6$ are exactly the six-row labels, correctly described at D line 34. $n=10$ carries the wording candidate 7.1 and an undecided falsifier.

## 6. Falsifying objects, and the search for each

| claim | falsifier | what I did |
|---|---|---|
| 1 | a correct dimension count of $\mathcal W_{12}$ other than $1638$ | both closed forms by hand. The first checked against Viaclovsky (4.25), (5.4) |
| 2 | a highest weight vector of $\mathcal W_{12}\otimes\mathbb C$ of weight $\ne(2,2,0,0,0,0)$, or a proper invariant subspace | searched references. Irreducibility stated without proof (Viaclovsky 913), highest weight unfiled. No such vector constructed: that would be building the proof |
| 3 | a label multiset of $h_3[o_{(2,2)}]$ other than the reported one | none derivable without the expansion, which is on no page. Screens at $n=11,13$ only |
| 4b | a non-chiral constituent with both $[\lambda]$ and $[\lambda^*]$ present, i.e. a label with $\ge7$ rows | excluded by the row bound (unfiled import), shown in 4b |
| 5a | $\binom{1640}3\ne733\,813\,080$ | computed by hand |
| 5b | a table whose $\sum m_\lambda d_\lambda$ misses the total | the table's $d_\lambda$ are not on the brief. Not constructible |
| 6 | a stable label with $\lambda'_1+\lambda'_2\ge13$, or an associate coincidence at $n\ge12$ | both excluded by the row bound (3.6, section 1) |
| 7 | a Lean theorem false or not matching its docstring | every identity checked by hand. `L63_dimension` against its docstring gives 3.2 |
| 8 | an argument for the census on file | none in Passages A to D |
| $n=10$ | a stable label $(3,2,2,2,2,1)$ | named in section 4. Its occurrence is census data, undecided |

## 7. Withdrawn candidates and transcription notes

### 7.1 "λ and its associate become the same $O(10)$ irreducible"

1. *Locate.* D line 21: "five from **associate identification**, where $\lambda$ and its associate become the same $O(10)$ irreducible."
2. *Exhibit.* For $\lambda'_1\ne n/2$, $[\lambda]\not\cong[\lambda^*]$ as $O(n)$-modules: at $n=10$, $\lambda=(1)$, $\mathbb C^{10}$ against $\Lambda^9\mathbb C^{10}\cong\mathbb C^{10}\otimes\varepsilon$, reflection traces $8$ and $-8$. For $\lambda'_1=n/2$, $\lambda^*=\lambda$ and nothing merges. So no two distinct labels ever "become the same $O(10)$ irreducible".
3. *Charitable reading.* Blocks counted up to $\otimes\varepsilon$ (equivalently, by $SO(10)$-restriction class without chiral splitting). That convention reproduces "$5$ blocks and $0$ multiplicities". It also gives the same counts as genuine $O(n)$ blocks at $n=11,12,13$, because there the associate of a table label is never in the table. Whether the certificate problem is entitled to merge $\varepsilon$-twists depends on a definition the brief does not carry.

**Withdrawn** as a defect in the counts, since the charitable reading is consistent at every $n$ reported. **Retained as a wording note:** the sentence is false for $O(10)$ literally, and the $64$ is an $O(10)$ block count only under the det-blind convention. It lies outside L63's statement, but the Lean theorem `ten_corroboration` types it.

### 7.2 "$\dim\mathcal W_4=10=n$"

1. *Locate.* D line 34.
2. *Exhibit.* $n=4$, and $10\ne4$.
3. *Charitable reading.* It parallels the preceding clause: $\dim\mathcal W_4=10$ at $\lambda'_1+\lambda'_2=n$, with $\dim\mathcal W_4=4\cdot5\cdot6\cdot1/12=10$ correct.

**Withdrawn** as mathematics. Retained as a transcription note: the displayed equation is false as written.

### 7.3 "at total weight 12"

1. *Locate.* D step 3 (line 13) and [Sym3Threshold.lean](../lean/HamiltonsCubic/Results/Sym3Threshold.lean) lines 18-19, "Among constituents of `Sym³` of a weight-`4` label the total is `12`".
2. *Exhibit.* Newell–Littlewood contractions lower weight by even amounts, so constituents have weight $12,10,8,\dots$. Weight $12$ is not universal.
3. *Charitable reading.* Only weight $\le12$ is needed, and six parts $\ge2$ force weight $\ge12$, so the uniqueness conclusion stands.

**Withdrawn:** the conclusion is unaffected.

## Overall verdict

**HYPOTHESIS-DEBT.** Lemma L63's substance, the census $77/191$ with six chiral pairs at $2,1,1,1,1,1$, and with it $71/184$ and the table sum, rests on runs with no argument on file. Beneath that are:

- a GAP on the highest weight $(2,2,0,0,0,0)$, argued only by a dimension match.
- an unstated hypothesis in the step from $SO(12)$ to $O(12)$ counts.
- a canonical label "Lemma" that the statement does not earn.

The dimension $1638$, the binomial total and the fusion arithmetic are exact and correct. Passage D proves a different statement, stability for $n\ge12$, modulo unfiled imports.
