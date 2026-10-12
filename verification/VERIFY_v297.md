# Verifier v297, Lemma L86: the reduction to $\sigma_\lambda(W_0)=0$, the stabiliser, the branching, the parity rule, the redundancy of $\varepsilon$, the counts, the rank-one step and the canonical statement

The brief ([BRIEF_L86.md](BRIEF_L86.md)) was read cold. No numerical work was done: every value below is exact, obtained by hand from the labels and the table the brief quotes, and no script was written or run. Log: [agent_logs/verify-L86-v297.log](../agent_logs/verify-L86-v297.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Reduction: covariants vanish on the orbit, equivalently $\sigma_\lambda(W_0)=0$, with $\sigma_\lambda(W_0)\in V_\lambda^H$ | CONFIRMED AS ALGEBRA |
| 2 | $\mathrm{Stab}_{O(5)}(W_0)$: identity component $U(2)\subset SO(4)$, two components, times $\varepsilon$ | HYPOTHESIS-DEBT |
| 3 | Branching: exactly one $\mathfrak{so}(4)$ constituent with $j_L=0$, $(\mu_1,\mu_2)=(\lambda_2,-\lambda_2)$, $j_R=\lambda_2$ | CONFIRMED |
| 4 | Parity rule $\dim V_\lambda^H=1\iff\lambda_2$ even, and the four hand-checks | CONFIRMED AS ALGEBRA |
| 5 | $\varepsilon=\mathrm{diag}(1,1,1,1,-1)$ is redundant on $\mathrm{Sym}^3(\mathcal W_5)$ | CONFIRMED |
| 6 | Counts: $16$ blocks, $3570$, $25$ multiplicities, $36$ unknowns, the shape, the eight deaths | CONFIRMED AS ALGEBRA |
| 7 | Rank-one step: "each block loses one multiplicity", $36$ exact | HYPOTHESIS-DEBT |
| 8a | Passage C: "$\dim V_\lambda^H=1$ exactly when $\lambda_2$ is even" for the $O(5)$-module of highest weight $\lambda$ | REFUTED AS STATED |
| 8b | Passage C: "the lemma proves only $\ge36$ unknowns", matching Passage A | CONFIRMED |

Summary: the parity rule and the lower bound $\ge36$ follow correctly from a stabiliser that the record asserts without argument and from multiplicities that rest on a script, the exact $36$ rests on a measurement, and the canonical statement omits the hypothesis that $-\mathrm{Id}$ acts trivially, without which it is false.

## 0. Conventions, fixed once

- $\lambda=(\lambda_1,\lambda_2)$, $\lambda_1\ge\lambda_2\ge0$ integers, highest weight $\lambda_1e_1+\lambda_2e_2$ of $\mathfrak{so}(5)=B_2$. With $\rho=(\tfrac32,\tfrac12)$ and $\ell=\lambda+\rho$, the Weyl dimension formula reads $d_\lambda=\tfrac23\,\ell_1\ell_2(\ell_1+\ell_2)(\ell_1-\ell_2)$.
- $SO(4)\subset SO(5)$ is the subgroup fixing $e_5$, the padding axis. An $\mathfrak{so}(4)$ highest weight $(\mu_1,\mu_2)$ with $\mu_1\ge|\mu_2|$ is labelled $(j_L,j_R)=\big(\tfrac{\mu_1+\mu_2}2,\tfrac{\mu_1-\mu_2}2\big)$. Passage A does not state this map. Section 3 shows that the conclusion is the same under the swapped map.
- The classical branching rule for $SO(5)\downarrow SO(4)$ (unfiled, per the brief) is multiplicity free with constituents exactly those $(\mu_1,\mu_2)$ satisfying $\lambda_1\ge\mu_1\ge\lambda_2\ge|\mu_2|$.
- The "unknowns" column of Passage B is $m(m+1)/2$ per block (a symmetric $m\times m$ Gram block): $4\mapsto10$, $3\mapsto6$, $2\mapsto3$, $1\mapsto1$, which reproduces $20,6,27,12$ and the total $65$.
- A "certificate" is read as an $O(5)$-invariant sum of squares of cubics, $F_5=\sum_\lambda\operatorname{tr}(Q_\lambda G_\lambda(W))$ with $Q_\lambda\succeq0$ of size $m_\lambda$ and $G_\lambda^{ab}(W)=\langle\sigma_\lambda^a(W),\sigma_\lambda^b(W)\rangle$. The brief does not define the word. This is the only reading under which the unknowns column and "loses one multiplicity" make sense, and it is recorded as an unstated hypothesis below.
- $M_\lambda$ is the multiplicity space of cubic covariants into $V_\lambda$ and $\mathrm{ev}_\lambda:M_\lambda\to V_\lambda$, $\phi\mapsto\phi(W_0)$.
- Quotations were checked against [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 23-36, 70 and 84-99, and [results.md](../results.md) lines 290 and 962, displaying only those lines. All match the brief verbatim.

## Hypothesis inventory

| Hypothesis | Where it enters | Stated? | Argued on file (within the brief)? |
|---|---|---|---|
| H1. $F_5$ vanishes at $W_0$, hence on its $O(5)$-orbit | Passage A line 86 | Yes | No, stated as a premise |
| H2. The certificate is an $O(5)$-invariant SOS with PSD Gram blocks $Q_\lambda$ of size $m_\lambda$ | "every covariant entering a certificate vanishes", the unknowns column | No | No |
| H3. $H=\mathrm{Stab}_{O(5)}(W_0)=(U(2)\rtimes\langle\sigma\rangle)\times\langle\varepsilon\rangle$, with $U(2)=(SU(2)_L\times U(1)_R)/\pm1$ and $\sigma$ normalising $U(1)_R$ in $SU(2)_R$ | Passage A lines 86, 88 | Yes | No, attributed to a reviewer |
| H4. $SO(5)\downarrow SO(4)$ branching | Line 88 | Conclusion only | Classical, unfiled |
| H5. The Weyl element of $SU(2)$ acts on the $m=0$ vector of spin $j$ by $(-1)^j$ | Line 88 | Yes | Classical, unfiled |
| H6. $-\mathrm{Id}$ acts trivially on every $O(5)$-constituent considered | Line 90 | In the proof only, absent from the heading (line 70) and from Passage C | Yes for $\mathrm{Sym}^3(\mathcal W_5)$: $\mathcal W_5$ is a space of $4$-tensors |
| H7. Passage B's block list and multiplicities | Line 92 counts | Yes | No: "come from the character computation", a script. Only $\sum m_\lambda d_\lambda=7770$ is an external check |
| H8. $\mathrm{rank}\,\mathrm{ev}_\lambda=1$ for all sixteen blocks | Line 92 "each loses one multiplicity" | Yes, then withdrawn to a dependency at lines 94-96 | No: rests on a measured $3570$ and on L87, which the passage itself calls owed |

Used but unstated: H2 throughout, and H6 in the statement (see 8a). Every other hypothesis is stated. H1, H3, H7 and H8 carry no argument within the brief.

## 1. The reduction to one condition (attack item 1)

Chain as written: $F_5$ vanishes on the orbit, "so every covariant entering a certificate vanishes there, and by equivariance that is the single condition $\sigma_\lambda(W_0)=0$".

- Under H2, $0=F_5(W_0)=\sum_\lambda\operatorname{tr}(Q_\lambda G_\lambda(W_0))$ is a sum of traces of products of two PSD matrices, each $\ge0$, so each vanishes, so $Q_\lambda G_\lambda(W_0)=0$. The combinations $\sum_a c_a\sigma^a_\lambda$ with $c$ in the range of $Q_\lambda$ therefore vanish at $W_0$. This is the precise content of "every covariant entering a certificate vanishes there". The step needs PSD Gram blocks, which the passage does not state (H2).
- Equivariance: $\sigma_\lambda(gW_0)=g\,\sigma_\lambda(W_0)$, so vanishing on the orbit is equivalent to vanishing at $W_0$. Correct.
- Membership in $V_\lambda^H$: for $h\in H$, $h\,\sigma_\lambda(W_0)=\sigma_\lambda(hW_0)=\sigma_\lambda(W_0)$. Passage A does not write this line, but it invokes "equivariance" and names the map $M_\lambda\to V_\lambda^H$ at line 94, so the membership is the stated principle applied once.

Verdict: CONFIRMED AS ALGEBRA, with H1 (unargued premise) and H2 (unstated model) recorded.

Falsifier: a certificate in which some Gram block is indefinite, or a $W_0$ with $F_5(W_0)\ne0$. The first is excluded by the definition of an SOS certificate, once stated. For the second I looked for an argument for H1 in the brief and found none.

## 2. The stabiliser (attack item 2)

Passage A line 86: "$\mathrm{Stab}_{O(5)}(W_0)$ has identity component $U(2)\subset SO(4)$, two components, times the reflection on the padding axis". The text that follows is "and the rule has a mechanism rather than a bracket. *Reviewer 178, deriving it independently of 174.*" No derivation is on file in the brief, and reviews are not the record.

The argument splits into two directions, and they carry different weight:

- Containment, $U(2)\rtimes\langle\sigma\rangle\times\langle\varepsilon\rangle\subseteq H$, gives $\dim V_\lambda^H\le[\lambda_2\text{ even}]$. This is all that the lower bound $\ge36$ uses (Section 7).
- Equality, meaning nothing else fixes $W_0$, is needed for $\dim V_\lambda^H=1$ when $\lambda_2$ is even. It is therefore needed for the "iff", and for $36$ being attainable at all.

Neither direction is argued. What would have to be proved:

1. $W_{\mathbb{CP}^2}$ is fixed by the $U(2)\subset SO(4)$ commuting with the complex structure, and by an element $\sigma$ that normalises its centre and acts on the $j_L=0$ constituents as the Weyl element of $SU(2)_R$.
2. The only elements of $O(5)$ fixing the padded tensor are these, times $\varepsilon$. This includes showing that every stabilising element preserves the padding axis $\mathbb Re_5$ (the kernel of $W_0$) and that no orientation-reversing element of $O(4)$ fixes $W_{\mathbb{CP}^2}$.

Verdict: HYPOTHESIS-DEBT.

Falsifier: an element of $O(5)$ fixing $W_0$ outside the stated group, which would lower $\dim V_\lambda^H$ at some even $\lambda_2$. The candidates are an orientation-reversing element of $O(4)$ and an element moving $e_5$. Alternatively, a failure of $\sigma$ or of $U(2)$ to fix $W_0$ would raise it. I found no closed-form such element in the brief, and per the brief I did not construct the missing argument.

## 3. The branching (attack item 3)

Claim: "exactly one constituent with $j_L=0$, namely $(\mu_1,\mu_2)=(\lambda_2,-\lambda_2)$, so $j_R=\lambda_2$".

- With the interlacing rule of Section 0 and $j_L=\tfrac{\mu_1+\mu_2}2$: $j_L=0$ forces $\mu_2=-\mu_1$. Then $\mu_1\ge\lambda_2\ge|\mu_2|=\mu_1$ forces $\mu_1=\lambda_2$. The constituent $(\lambda_2,-\lambda_2)$ occurs exactly once, with $j_R=\tfrac{\mu_1-\mu_2}2=\lambda_2$. Correct.
- Swapped map, $j_L=\tfrac{\mu_1-\mu_2}2$: the unique constituent is $(\lambda_2,\lambda_2)$, again with $j_R=\lambda_2$. The label map is unstated, but the result is independent of it. What does matter is that "$L$" names the $SU(2)$ factor lying wholly inside $U(2)$, which is part of H3.
- The hypotheses of the imported rule match the object: the embedding is $SO(4)$ fixing $e_5$, which is the padding, and all weights are integral because $\mathcal W_5=V_{(2,2)}$.
- Check at $\lambda=(2,2)$: the constituents are $(2,\pm2),(2,\pm1),(2,0)$, of dimensions $5+5+8+8+9=35=d_{(2,2)}$, with the single $j_L=0$ constituent $(2,-2)$ and $j_R=2$.

Verdict: CONFIRMED (import unfiled, label map unstated and immaterial).

Falsifier: a $\lambda$ with two constituents satisfying $\mu_1=-\mu_2$, or none. Interlacing pins $\mu_1=\lambda_2$, so neither exists.

## 4. The parity rule and the hand-checks (attack item 4)

- Under H3, $U(2)$-invariants of $(j_L,j_R)$ are $SU(2)_L$-invariants, which force $j_L=0$, tensored with $U(1)_R$-invariants, which are the $m=0$ line and exist exactly for integer $j_R$. By Section 3 there is exactly one such constituent, with $j_R=\lambda_2\in\mathbb Z$, so $\dim V_\lambda^{U(2)}=1$. Correct.
- The component group acts on this line by a character, so any representative of $\sigma$ gives the same sign. On $j_L=0$ only the $SU(2)_R$ part acts, and the Weyl element gives $(-1)^{j}$ on $|j,0\rangle$ (H5, classical: $d^j_{00}(\pi)=P_j(-1)=(-1)^j$). A sign ambiguity $\pm w$ is invisible at integer $j$. The rule follows: $\dim V_\lambda^{U(2)\rtimes\langle\sigma\rangle}=1$ for even $\lambda_2$ and $0$ for odd $\lambda_2$. Adding $\varepsilon$ changes nothing on the modules of Section 5.
- Hand-checks, read against the branching:
  - $(1,0)$: constituents $(1,0),(0,0)$, so $j_L=0$ at $(0,0)$ with $j_R=0$, giving $1$. It is realised by $e_5$ *on the module where $-\mathrm{Id}$ is trivial*, where $\varepsilon$ acts as $\mathrm{diag}(-1,-1,-1,-1,1)$ and fixes $e_5$.
  - $(1,1)$: constituents $(1,1),(1,0),(1,-1)$, so $j_R=1$, giving $0$. The $U(2)$-fixed line is the Kähler form, and $\sigma$ reverses it. Consistent.
  - $(2,0)$: $j_L=0$ at $(0,0)$, giving $1$, realised by $\mathrm{diag}(1,1,1,1,-4)$.
  - $(2,2)$: $j_R=2$, giving $1$, realised by $W_0$ itself.

Verdict: CONFIRMED AS ALGEBRA, conditional on H3 (Section 2) and on H6 (Section 8a).

Falsifier: an even-$\lambda_2$ module with no $H$-fixed vector, or an odd one with one. See 8a for the first, which exists exactly when $-\mathrm{Id}$ acts by $-1$.

## 5. The redundancy of $\varepsilon$ (attack item 5)

- $-\mathrm{Id}\in O(5)$ acts on a $4$-tensor by $(-1)^4=1$, so trivially on $\mathcal W_5$ and on $\mathrm{Sym}^3(\mathcal W_5)$, hence on every constituent.
- On such modules $\varepsilon$ acts as $(-\mathrm{Id})\varepsilon=\mathrm{diag}(-1,-1,-1,-1,1)$. This is $-1_{\mathbb C^2}\oplus1$, the central $-1\in U(2)\subset SO(4)$, so it already lies in the identity component.

Verdict: CONFIRMED. The claim holds on $\mathrm{Sym}^3(\mathcal W_5)$, which is the scope that line 90 states.

Falsifier: a constituent on which $-\mathrm{Id}$ acts by $-1$. None exists in an even tensor power.

## 6. The counts (attack items 6, 8)

All arithmetic below was done by hand on Passage B.

- Weyl dimensions: all $24$ tabulated $d_\lambda$ were recomputed from $d_\lambda=\tfrac23\ell_1\ell_2(\ell_1+\ell_2)(\ell_1-\ell_2)$ and all match. For example $(6,2)$: $\ell=(\tfrac{15}2,\tfrac52)$, $\tfrac{75}4\cdot10\cdot5=937.5$, and $\tfrac23\cdot937.5=625$.
- Table totals: $4(255)+3(105)+2(1155)+4125=1020+315+2310+4125=7770=\binom{37}{3}$. The multiplicities sum to $8+3+18+12=41$ and the unknowns to $20+6+27+12=65$. The multiplicity-$1$ dimensions sum to $4125$. All agree with line 38.
- Even $\lambda_2$ blocks:
  - multiplicity 4: $(4,2),(2,2)$
  - multiplicity 3: $(3,2)$
  - multiplicity 2: $(5,2),(4,4),(4,0),(3,0),(2,0)$
  - multiplicity 1: $(6,6),(6,4),(6,2),(6,0),(5,4),(5,0),(1,0),(0,0)$

  That is $2+1+5+8=16$ blocks. Their dimensions sum to $255+105+(390+165+55+30+14)+(455+810+625+140+429+91+5+1)=255+105+654+2556=3570$.
- With rank one on these sixteen blocks, the surviving multiplicities are $41-16=25$. The unknowns are:
  - reduced blocks: $2\cdot6+3+5\cdot1+8\cdot0=20$
  - untouched odd blocks $(4,3),(4,1),(3,1),(2,1)$ at $3$ each and $(6,3),(5,3),(5,1),(3,3)$ at $1$ each: $12+4=16$
  - total $36$
- Shape: two $3\times3$ blocks (the multiplicity-4 blocks). Five $2\times2$ blocks: $(3,2)$ plus the four odd multiplicity-2 blocks. Nine scalars: the five reduced multiplicity-2 blocks plus the four odd multiplicity-1 blocks. The eight deaths are exactly the eight even multiplicity-1 blocks listed. All correct.
- $65-36=29=2\cdot4+3+5\cdot2+8\cdot1$. Consistent.

Scope (item 8):

- The parity rule is independent of Passage B.
- $16$ and $3570$ depend on the block *list*.
- $25$, $36$, the shape and the deaths depend on the *multiplicities* too. Both come from the character computation, a script, and $7770$ constrains only $\sum m_\lambda d_\lambda$. One linear relation does not determine twenty-four multiplicities. The counts are therefore HYPOTHESIS-DEBT on H7.
- Independently of H7, "$36$", "shape" and "die outright" at line 92 are stated unconditionally but require H8 (Section 7).

Verdict: CONFIRMED AS ALGEBRA.

Falsifier: a misread parity, a wrong dimension, or a wrong sum in the table. All $24$ entries and all totals were checked, and none was found.

## 7. The rank-one step (attack item 7)

- Line 92: "Each loses one multiplicity". The only bound on file is $\mathrm{rank}\,\mathrm{ev}_\lambda\le\dim V_\lambda^H\le1$ (Section 1 and Section 4). Line 94 says so itself: "it does not force rank $1$ rather than rank $0$". The unknowns are $\sum_\lambda(m_\lambda-r_\lambda)(m_\lambda-r_\lambda+1)/2$, which is non-increasing in each $r_\lambda$. Taking $r_\lambda\le[\lambda_2\text{ even}]$ gives $\ge36$. This lower bound needs only the containment direction of H3, plus H2 and H7.
- Line 96, the algebra: a cubic in the $\lambda$-isotypic part vanishes on the orbit exactly on $(\ker\mathrm{ev}_\lambda)$ tensored with $V_\lambda^*$, because $V_\lambda$ is irreducible and so the orbit of a nonzero $v_0\in V_\lambda^H$ spans it. The codimension of the cubics vanishing on the orbit is therefore $\sum_\lambda r_\lambda d_\lambda$, which is the dimension of the span of $\{(gW_0)^3\}$. Given $r_\lambda\le[\lambda_2\text{ even}]$ and $d_\lambda>0$, the value $3570$ forces every $r_\lambda=1$ on the sixteen blocks. The implication is correct.
- The premise $\dim\langle O(5)\cdot W_0^3\rangle=3570$ is "measured" (r170) and "recomputed exactly over $\mathbb F_{46337}$" (r178). This loop treats a measurement as HYPOTHESIS-DEBT. Line 96 adds that "the two ends are ranks of different objects, and what joins them is owed, see L87". The passage therefore records its own unclosed link.
- What would have to be proved: $\mathrm{ev}_\lambda\ne0$ for each of the sixteen even-$\lambda_2$ blocks, meaning some covariant into each block is nonzero at $W_0$. Equivalently, the span of the cubes on the orbit has dimension $3570$. For $(0,0)$ this is a nonvanishing cubic invariant at $W_0$, and Passage B line 40 already lists the identification of that invariant with $\operatorname{tr}(W^3)$ as owed.
- Heading and statements: line 70 says "the $\ge36$ unknowns it leaves", line 290 says "bounds ... from below by thirty-six", and line 962 says "proves only $\ge36$". All three match what is proven.

Verdict: HYPOTHESIS-DEBT for exactness. The inequality $\ge36$ is CONFIRMED AS ALGEBRA under H2, H3 (containment) and H7.

Falsifier: an even-$\lambda_2$ block all of whose covariants vanish at $W_0$. That would make the block survive with its full multiplicity and push the orbit span below $3570$. None can be exhibited or excluded without the measurement or a proof.

## 8. Passage C against Passage A (standing item 4)

### 8a. The parity statement omits H6

1. Location. [results.md](../results.md) line 962 reads "$\dim V_\lambda^H=1$ exactly when $\lambda_2$ is even", and line 290 reads "The $H$-invariant dimension is one exactly when the second highest-weight coordinate is even". The brief defines $V_\lambda$ as "the $O(5)$-module with highest weight $\lambda$". The heading at line 70 carries the same statement.
2. Failure. Take $\lambda=(0,0)$ and the one-dimensional $O(5)$-module $\det$. As an $SO(5)$-module it has highest weight $(0,0)$, and $-\mathrm{Id}$ acts by $\det(-\mathrm{Id})=-1$. Now $\varepsilon\in H$ has $\det\varepsilon=-1$, so $V^H=0$ although $\lambda_2=0$ is even. Likewise for the standard $\mathbb R^5$ at $\lambda=(1,0)$: $\varepsilon$ fixes only $\mathbb R^4$, and $U(2)$ fixes no nonzero vector of $\mathbb R^4=\mathbb C^2$, so $V^H=0$. In general, on any extension where $-\mathrm{Id}$ acts by $-1$, $\varepsilon$ acts on the fixed line by $-1$ and the rule reverses at even $\lambda_2$.
3. Charitable reading. "The $O(5)$-module with highest weight $\lambda$" means the extension occurring in $\mathrm{Sym}^3(\mathcal W_5)$, where $-\mathrm{Id}$ is trivial. Line 90 supplies exactly this, and the hand-check "$(1,0)\mapsto1$, realised by $e_5$" is correct only on that extension. Under this reading the lemma is correct and no count changes. The reading rescues the intent but not the text: the definite article presupposes a unique $O(5)$-module per $\lambda$, and there are two.

Verdict: REFUTED AS STATED. The correction is to add "on which $-\mathrm{Id}$ acts trivially (as on every constituent of $\mathrm{Sym}^3(\mathcal W_5)$)" to the heading at line 70 and to results.md lines 290 and 962. Downstream impact: none.

### 8b. The bound

Passage C claims "$\ge36$", with the rank-one step placed in a separate measurement. That matches Section 7 exactly. Passage A line 92 states "$36$", the shape and the deaths unconditionally, and lines 94-96 then condition them. The canonical statement takes the conditioned version.

Verdict: CONFIRMED.

### 8c. Withdrawn candidates

- **"the heading claiming $65$".**
  1. Location: line 962, "the heading claiming $65$ claims a number the section itself disclaims".
  2. Failure: the L86 heading quoted at line 70 reads "the $\ge36$ unknowns it leaves" and contains no $65$.
  3. Charitable reading: the sentence may refer to another heading of the section, outside the lines the brief quotes, which I was not permitted to display.

  Step 3 cannot be excluded. Withdrawn: the referent is unresolvable from the brief.
- **"$65=36+29$ is a tautology rather than a count".**
  1. Location: line 962.
  2. Failure: $65$ is a genuine count of Gram entries given Passage B, so calling it a tautology looked false.
  3. Charitable reading: the sentence says that $65$, as a claim about the certificate's unknowns after the orbit constraint, carries no information beyond $36$ plus the $29$ removed entries. $29$ is defined as the difference, so that identity is indeed tautological.

  Withdrawn: the charitable reading is coherent.
- **"Frobenius reciprocity bounds the evaluation map".**
  1. Location: line 94.
  2. Failure: the bound $\mathrm{rank}\le\dim V_\lambda^H$ is plain equivariance, so the citation looked misplaced.
  3. Charitable reading: restriction to the orbit $O(5)/H$ lands in functions on $O(5)/H$, whose $\lambda$-multiplicity is $\dim V_\lambda^H$ by Frobenius reciprocity. That is a valid route to the same bound.

  Withdrawn.

## 9. The edges (standing item 3, attack item 9)

- **$\lambda_2=0$:** the constituents are $(\mu_1,0)$, $0\le\mu_1\le\lambda_1$, with $j_L=j_R=\mu_1/2$. The unique $j_L=0$ constituent is $\mu_1=0$, with $j_R=0$. Both label conventions coincide here. Rule: $1$, correct under H6.
- **Trivial block $(0,0)$:** $V^H=1$ on the trivial module and $0$ on $\det$ (8a). Its "death" requires rank one, meaning the cubic invariant is nonzero at $W_0$. That is conditional (Section 7), and its identification with $\operatorname{tr}(W^3)$ is owed per Passage B line 40.
- **Multiplicity-$1$ blocks:** rank one forces $Q_\lambda=0$ ("die outright"). With rank $0$ the block keeps its single scalar. The eight deaths are therefore exactly as conditional as H8.
- **Kernel of $W_0$ (padding):** $\mathbb Re_5$. It enters twice. It is the source of the $\varepsilon$ factor in $H$, redundant by Section 5 on $\mathrm{Sym}^3(\mathcal W_5)$ and not on other extensions. It also enters the unargued requirement that stabilising elements preserve $\mathbb Re_5$ (Section 2). The hand-check at $(1,0)$ is realised by $e_5$, which is correct only under H6.

## 10. Quantifier order and scope (standing item 2)

- Group: $O(5)$ acting on $\mathcal W_5$, with $H\subset O(5)$. The branching is for $\mathfrak{so}(5)\supset\mathfrak{so}(4)$ at the Lie algebra level, and the components of $H$ are handled separately ($\sigma$, $\varepsilon$). The quantifiers are in the right order: for each $\lambda$ in the table, $\dim V_\lambda^H$ is computed, and then the ranks are bounded.
- Labelling: $\lambda$ in the $e$-basis, which is consistent with Passage B's dimensions (Section 6). $(j_L,j_R)$ is unstated and immaterial (Section 3).
- Blocks: the $24$ of Passage B, under H7.

## 11. Falsifiers and the search (standing item 6)

| Claim | Falsifying object | What I did |
|---|---|---|
| 1 | Indefinite Gram block, or $F_5(W_0)\ne0$ | Read the chain. The first is excluded once H2 is stated. H1 has no argument in the brief |
| 2 | Element of $O(5)$ fixing $W_0$ outside the stated group, or $U(2)$ or $\sigma$ not fixing it | Named the candidates (orientation-reversing elements of $O(4)$, elements moving $e_5$). No argument on file to exclude them |
| 3 | $\lambda$ with $\ne1$ constituent of $j_L=0$ | Interlacing pins $\mu_1=\lambda_2$, both label maps checked, and a dimension check at $(2,2)$ |
| 4 | Even-$\lambda_2$ module without a fixed line | Found one on the $-\mathrm{Id}=-1$ extensions (8a), and none on $\mathrm{Sym}^3(\mathcal W_5)$ constituents |
| 5 | Constituent with $-\mathrm{Id}$ acting by $-1$ | Impossible in an even tensor power |
| 6 | Arithmetic error in the table or the counts | All $24$ dimensions and every total recomputed by hand, and none found |
| 7 | Even-$\lambda_2$ block with $\mathrm{ev}_\lambda=0$ | Not constructible without computation. The claim rests on a measurement |
| 8 | Mismatch between Passage C and Passage A | 8a found. 8b consistent. Three candidates withdrawn |

## Overall verdict

**HYPOTHESIS-DEBT.**

- The algebra is correct throughout: the reduction, the branching, the parity mechanism, the redundancy of $\varepsilon$, every count against Passage B, and the implication from $3570$ to rank one.
- The debts are:
  - the stabiliser of $W_0$ (no argument on file)
  - the multiplicities of Passage B (a script)
  - the exact value $36$ with its shape and eight deaths (a measurement, plus the link that L87 owes)
- The canonical statement also needs the hypothesis correction of 8a: $-\mathrm{Id}$ acting trivially.
- The lower bound $\ge36$ that Passage C claims needs only containment in the stabiliser, the certificate model and the table.
