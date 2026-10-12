# Verifier v288, Lemma L83: the dimension column, the weight list and multiplicity column, the "arithmetic on the highest weights" and "four independent ways" sentences, the label identification, the O(5) reading, the trivial multiplicity, Passage C and the Lean file

The brief was cold. No numerical work was done, every value below is exact and was obtained by hand at a stated weight, and no script was written or run. The Lean file was read and not built. Log: [agent_logs/verify-L83-v288.log](../agent_logs/verify-L83-v288.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Dimension column: all 24 subscripts from Weyl's $B_2$ formula | CONFIRMED |
| 2 | Weight list and multiplicity column of $\mathrm{Sym}^3(\mathcal W_5)$ (the content of L83) | HYPOTHESIS-DEBT |
| 3 | "The table is arithmetic on the highest weights ... No linear algebra on the $7770$ is involved" | REFUTED AS STATED |
| 4 | "The reconstruction closes four independent ways" | REFUTED AS STATED |
| 4a | The four sums themselves ($24$, $7770$, $41$, $65$) and the multiplicity-1 total $4125$ | CONFIRMED |
| 5 | $[2,2]=2e_1+2e_2=4\omega_2$, $\omega_1+2\omega_2=[2,1]$, both of dimension $35$, Casimir $16$ against $12$ | CONFIRMED AS ALGEBRA |
| 6 | $SO(5)$ labels serve as the $O(5)$ block table, and the unknowns column $m(m+1)/2$ | HYPOTHESIS-DEBT |
| 7 | Trivial multiplicity $1$ at $n=5$ and $2$ from $n\ge6$, by the Lovelock collapse | HYPOTHESIS-DEBT |
| 8 | Passage C: "Every number re-derives by hand", "The table is right" | HYPOTHESIS-DEBT |
| 8a | Passage C: "one block is closed by an external count of $7770$" | GAP |
| 9 | Lean file [L83.lean](../lean/HamiltonsCubic/Results/L83.lean) | CONFIRMED AS ALGEBRA (does not state L83) |

**Summary.** Every number that can be read off a stated weight is right. The lemma's actual content, which weights occur in $\mathrm{Sym}^3(\mathcal W_5)$ and with what multiplicities, has no argument on file beyond a script link, and three of the "four independent" closures are one column read three ways.

## 0. Conventions, fixed once

- Label basis: $(a,b)$ means $\lambda=ae_1+be_2$ in the orthonormal $e$-basis of the $B_2$ weight lattice, with $a\ge b\ge0$ integers (dominant integral for $SO(5)$). This basis is not stated at the table (lines 29-42). It is fixed by two things on file: line 9 writes $[2,2]=2e_1+2e_2$ and $[2,1]=2e_1+e_2$, and line 31's $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$ is $\langle\lambda,\lambda+2\rho\rangle$ with $\rho=(\tfrac32,\tfrac12)$ in that basis. The $\omega$-basis reading is excluded by the table itself: $(2,2)$ in the $\omega$-basis is $3e_1+e_2$, of dimension $81$, and the table gives $(2,2)_{35}$. The Lean file states the $e$-basis in its docstring (line 28).
- Fundamental weights: $\omega_1=e_1$, $\omega_2=\tfrac12(e_1+e_2)$.
- Positive roots of $B_2$: $e_1$, $e_2$ (short), $e_1-e_2$, $e_1+e_2$ (long). Weyl's formula at $\lambda+\rho=(a+\tfrac32,b+\tfrac12)$ gives factors $\tfrac{2a+3}{3}$, $2b+1$, $a-b+1$, $\tfrac{a+b+2}{2}$, so $d(a,b)=\tfrac16(2a+3)(2b+1)(a-b+1)(a+b+2)$. This is the "product of four linear factors" of line 31, and the Lean `dim` at line 32. The formula is classical and unfiled.
- Casimir: $c_2(a,b)=a(a+3)+b(b+1)$, with the inner product in which $e_1,e_2$ are orthonormal. Line 13's $B(X,Y)=-\tfrac12\operatorname{tr}(XY)$ induces exactly this (the rotation generator $E_{12}-E_{21}$ has $B$-norm $1$ and $e_1$ is dual to it). Only the ratio $16:12$ is used by the lemma.
- Sources read: [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 3, 7, 9, 13, 15, 29-42 only, [results.md](../results.md) lines 284 and 942 only, and for the imported Lovelock relation [findings/bispectral.md](../findings/bispectral.md) lines 117-152. Every quotation in the brief matches its source verbatim.

## Hypothesis inventory

| Hypothesis | Where stated | Used by | Status |
|---|---|---|---|
| $\mathcal W_5$ is an irreducible $O(5)$-module with Young label $[2,2]$ | line 9, asserted | the whole table (the input weight $(2,2)$) | classical, unfiled. Line 11's $16\cdot\mathrm{Id}$ is script-only |
| $\dim\mathcal W_5=35$ | line 9 | $\dim\mathrm{Sym}^3=\binom{37}{3}=7770$ | correct by hand: $\tfrac{n(n+1)(n+2)(n-3)}{12}$ at $n=5$ is $\tfrac{5\cdot6\cdot7\cdot2}{12}=35$ (classical, unfiled) |
| Weyl's dimension formula for $B_2$ | line 31, described not written | dimension column | classical, unfiled. Exact form given in §0 |
| $c_2=\langle\lambda,\lambda+2\rho\rangle$ at $B_2$'s $\rho$ | line 31 | label separation (line 9) | classical, unfiled |
| $O(5)$- and $SO(5)$-isotypic decompositions of $\mathrm{Sym}^3(\mathcal W_5)$ coincide | used, unstated (brief says "as the passages argue", and the cited lines give no argument) | reading $B_2$ labels as the $O(5)$ Gram blocks | **used, unstated**. See §6 |
| Every block is of real type (absolutely irreducible over $\mathbb R$) | used, unstated | unknowns column $m(m+1)/2$ | **used, unstated**. See §6 |
| $F_5$ is $O(5)$-invariant, so a Gram matrix may be averaged to an invariant one | line 3, "Because $O(5)$ acts" | block-diagonality (setting, outside the lemma) | implicit |
| The weight list and multiplicities | lines 33-38 | everything downstream | **no argument on file**, script link only |
| Lovelock syzygy $\beta-\tfrac\alpha2=-\tfrac1{64}\delta^{(6)}WWW$ | imported, filed at bispectral.md 121-125, 143-147 | trivial multiplicity | constant verified by script at $n=6,7,8$ only. The source file itself records the proportionality as underived |
| Cubic invariants on $\mathcal W_n$ are spanned by $\alpha,\beta$ | used, unstated | "the cubic invariant space is one-dimensional" | **used, unstated** |
| $\operatorname{tr}(W^3)\not\equiv0$ on $\mathcal W_5$ | used, unstated | trivial multiplicity $\ge1$ | **used, unstated** |

## 1. The dimension column

Every subscript, by hand from $d(a,b)=\tfrac16(2a+3)(2b+1)(a-b+1)(a+b+2)$:

| $(a,b)$ | product | $d$ | table | $(a,b)$ | product | $d$ | table |
|---|---|---|---|---|---|---|---|
| $(4,2)$ | $11\cdot5\cdot3\cdot8=1320$ | $220$ | $220$ | $(6,6)$ | $15\cdot13\cdot1\cdot14=2730$ | $455$ | $455$ |
| $(2,2)$ | $7\cdot5\cdot1\cdot6=210$ | $35$ | $35$ | $(6,4)$ | $15\cdot9\cdot3\cdot12=4860$ | $810$ | $810$ |
| $(3,2)$ | $9\cdot5\cdot2\cdot7=630$ | $105$ | $105$ | $(6,3)$ | $15\cdot7\cdot4\cdot11=4620$ | $770$ | $770$ |
| $(5,2)$ | $13\cdot5\cdot4\cdot9=2340$ | $390$ | $390$ | $(6,2)$ | $15\cdot5\cdot5\cdot10=3750$ | $625$ | $625$ |
| $(4,3)$ | $11\cdot7\cdot2\cdot9=1386$ | $231$ | $231$ | $(6,0)$ | $15\cdot1\cdot7\cdot8=840$ | $140$ | $140$ |
| $(4,4)$ | $11\cdot9\cdot1\cdot10=990$ | $165$ | $165$ | $(5,4)$ | $13\cdot9\cdot2\cdot11=2574$ | $429$ | $429$ |
| $(4,1)$ | $11\cdot3\cdot4\cdot7=924$ | $154$ | $154$ | $(5,3)$ | $13\cdot7\cdot3\cdot10=2730$ | $455$ | $455$ |
| $(3,1)$ | $9\cdot3\cdot3\cdot6=486$ | $81$ | $81$ | $(5,1)$ | $13\cdot3\cdot5\cdot8=1560$ | $260$ | $260$ |
| $(4,0)$ | $11\cdot1\cdot5\cdot6=330$ | $55$ | $55$ | $(5,0)$ | $13\cdot1\cdot6\cdot7=546$ | $91$ | $91$ |
| $(2,1)$ | $7\cdot3\cdot2\cdot5=210$ | $35$ | $35$ | $(3,3)$ | $9\cdot7\cdot1\cdot8=504$ | $84$ | $84$ |
| $(3,0)$ | $9\cdot1\cdot4\cdot5=180$ | $30$ | $30$ | $(1,0)$ | $5\cdot1\cdot2\cdot3=30$ | $5$ | $5$ |
| $(2,0)$ | $7\cdot1\cdot3\cdot4=84$ | $14$ | $14$ | $(0,0)$ | $3\cdot1\cdot1\cdot2=6$ | $1$ | $1$ |

All 24 agree, and every product is exactly divisible by $6$, so the Lean file's truncating `/ 6` on $\mathbb N$ loses nothing at these entries. All 24 labels satisfy $a\ge b$, so its natural-number subtraction `a - b` is exact too. **CONFIRMED.** The basis is not stated at the table but is forced by lines 9 and 31 (§0).

## 2. The weight list and the multiplicity column

**What would prove it.** A character identity $\operatorname{ch}\mathrm{Sym}^3V_{(2,2)}=\sum_\lambda m_\lambda\operatorname{ch}V_\lambda$ over $B_2$. It needs the weight multiplicities of $V_{(2,2)}$ and the symmetric-cube plethysm $\tfrac16(\chi(g)^3+3\chi(g^2)\chi(g)+2\chi(g^3))$ reduced to dominant characters. An explicit highest-weight-vector count would also do, as would a branching argument.

**What is on file.** In the cited passages, only the link to [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py) at line 31, and line 31's description, which covers the dimension and Casimir functions of a weight already given. Passage C concedes that "arithmetic on the highest weights is false of the multiplicities" and gives no replacement argument. Under the loop's rule, a statement supported only by a script is HYPOTHESIS-DEBT.

**What a reader can confirm without building the decomposition.** Only necessary conditions: $\sum m_\lambda d_\lambda=7770$ (§4a) and the presence of $(6,6)=3\cdot(2,2)$ with multiplicity $1$ (the Cartan component of a symmetric power, classical). Neither fixes the other 23 rows.

**Verdict: HYPOTHESIS-DEBT.** What must be proved: the multiplicity of every dominant $B_2$ weight in $\mathrm{Sym}^3V_{(2,2)}$. That covers the absence of every weight not listed as well as the 24 values.

**The object that would falsify it.** Any dominant weight whose multiplicity differs from the table. Section 4 shows that the closures on file would not detect some such errors. I looked for a hand-checkable contradiction among the necessary conditions above and found none.

## 3. "The table is arithmetic on the highest weights ... No linear algebra on the $7770$ is involved"

**Candidate: the sentence describes only the $d$ and $c_2$ columns, and says nothing about how the weights and multiplicities were obtained.**

1. *Location.* Line 31: "The table is arithmetic on the highest weights: the Weyl dimension formula for $B_2$ is a product of four linear factors, and $c_2(\lambda)=\ldots$. **No linear algebra on the $7770$ is involved.**"
2. *Failure exhibited.* Both named maps take $\lambda$ as input and return $d_\lambda$ or $c_2(\lambda)$. Neither produces $\lambda$ from $\mathrm{Sym}^3(\mathcal W_5)$ or produces $m_\lambda$. Concretely, the table with $m_{(2,2)}=2$ and $m_{(2,1)}=4$ (§4) has the same highest weights, and every value of the described arithmetic is identical. So "arithmetic on the highest weights" cannot have produced the column that separates the two tables. The table carries three columns (mult, blocks, unknowns), and the multiplicity column is the one the sentence leaves out.
3. *Charitable reading.* "The table" means the dimension subscripts. Under that reading the sentence is true (§1). It is still false as a description of "the table" as printed, because the table's row structure is the multiplicity column. Passage C line 942 draws the same conclusion ("false of the multiplicities").

**Second clause.** "No linear algebra on the $7770$" is unverifiable for the multiplicities, since their method is not on file. It carries no weight for the dimension column, where it is trivially true. The script's name ("casimir separation") sits badly with the table, because three pairs of blocks share a Casimir eigenvalue, by hand from $c_2(a,b)=a(a+3)+b(b+1)$:
- $c_2(4,1)=28+2=30=18+12=c_2(3,3)$
- $c_2(4,3)=28+12=40=40+0=c_2(5,0)$
- $c_2(6,2)=54+6=60=40+20=c_2(5,4)$

Any Casimir-eigenspace derivation of the multiplicities would have to resolve these three pairs by a further argument. None is on file. I report this as an edge an eventual proof must address, not as a finding against a method I have not read.

**Verdict: REFUTED AS STATED** (true of the dimension column only).

## 4. "The reconstruction closes four independent ways"

**Candidate: the four closures are one external check plus three functions of the multiplicity column, and a different table passes all four.**

1. *Location.* Line 40: "The reconstruction closes four independent ways: $24$ blocks, $\sum m_\lambda d_\lambda=7770$ exactly, multiplicities summing to $41$, unknowns to $65$."
2. *Failure exhibited.*
   - *Dependence.* Given a table, the numbers $24=\sum_\lambda m_\lambda^0$, $41=\sum m_\lambda$ and $65=\sum\tfrac12m_\lambda(m_\lambda+1)$ are functions of the multiset of multiplicities alone, and $65$ is determined by $41$ and $\sum m_\lambda^2=89$. None refers to $\mathrm{Sym}^3(\mathcal W_5)$. So they check only that the summary line agrees with the rows (a transcription check). They have no outside value to be compared with: nothing on file predicts $24$, $41$ or $65$ independently of the table. Only $\sum m_\lambda d_\lambda=\binom{37}{3}$ compares the table with an outside number.
   - *A different table passing all four.* Exchange the multiplicities of the two dimension-$35$ blocks: $m_{(2,2)}=2$, $m_{(2,1)}=4$, every other row unchanged. Block count $24$: unchanged. The multiset of multiplicities is unchanged, so $\sum m=41$ and $\sum m(m+1)/2=65$ hold. $\sum m d$ changes by $(2-4)\cdot35+(4-2)\cdot35=0$, so $7770$ holds. This table differs from the printed one, and all four closures accept it.
   - *What $7770$ can detect.* Any error in a single multiplicity (it shifts the sum by a nonzero multiple of $d_\lambda$). Any error in a single subscript. It cannot detect errors that compensate, such as the swap above, a relabelling between the equal-dimension weights $(6,6)_{455}$ and $(5,3)_{455}$ or between $(2,2)_{35}$ and $(2,1)_{35}$, or trades such as $5\cdot d_{(2,0)}=70=2\cdot d_{(2,1)}$.
3. *Charitable reading.* "Independent" means "separately recomputed". Under that reading the claim is true but says nothing about the table's correctness, and the sentence is offered as a closure of "the reconstruction". As a claim of four independent checks it fails.

**Verdict: REFUTED AS STATED.**

### 4a. The sums themselves

- Multiplicity $4$: $(220+35)\cdot4=1020$.
- Multiplicity $3$: $105\cdot3=315$.
- Multiplicity $2$: $390+231+165+154+81+55+35+30+14=1155$, times $2$ is $2310$.
- Multiplicity $1$: $455+810+770+625+140+429+455+260+91+84+5+1=4125$.
- Total: $1020+315+2310+4125=7770=\tfrac{37\cdot36\cdot35}{6}=\binom{37}{3}$.
- Blocks $2+1+9+12=24$. Multiplicities $8+3+18+12=41$. Unknowns $2\cdot10+6+9\cdot3+12\cdot1=20+6+27+12=65$, matching the column entries $20,6,27,12$.

**CONFIRMED.**

## 5. The label identification

- $2e_1+2e_2=4\cdot\tfrac12(e_1+e_2)=4\omega_2$. Correct.
- $2\omega_2=e_1+e_2=[1,1]$, of dimension $\tfrac16\cdot5\cdot3\cdot1\cdot4=10=\dim\Lambda^2\mathbb R^5$. So "rather than $2\omega_2$" is the right contrast.
- $\omega_1+2\omega_2=e_1+(e_1+e_2)=2e_1+e_2=[2,1]$. Correct.
- $d(2,2)=d(2,1)=35$ (§1), so dimension does not separate them.
- $c_2(2,2)=10+6=16$ and $c_2(2,1)=10+2=12$. Correct, and distinct under any normalisation because only the ratio matters.
- Line 13's normalisation: for $X=E_{12}-E_{21}$, $X^2=-(E_{11}+E_{22})$ and $\operatorname{tr}X^2=-2$, so $B(X,X)=1$. The Killing form of $\mathfrak{so}(N)$ is $(N-2)\operatorname{tr}$, which is $3\operatorname{tr}=-6B$ at $N=5$. The Casimir built from a basis orthonormal for $6B$ is $\tfrac16$ of the one built for $B$: $16/6=8/3$. Correct. The other "neighbouring" values $32,8,4$ are not tied to stated conventions and carry no weight in L83.

What the arithmetic does not establish: that $\mathcal W_5$ *is* $V_{(2,2)}$. The record asserts it (line 9), and it is the classical statement that algebraic Weyl tensors form the traceless $[2,2]$ module, irreducible for $n\ge5$, which is unfiled. Line 11's "$16\cdot\mathrm{Id}$" confirmation is script-only. Under the classical identification it is not needed.

**Verdict: CONFIRMED AS ALGEBRA.** The identification with $(2,2)$ is a classical unfiled import.

## 6. $SO(5)$ labels as the $O(5)$ block table, and the unknowns column

**What would have to be proved (not on file in the cited lines).**
- (a) $O(5)=SO(5)\times\{\pm I\}$, and $-I$ acts trivially on $\mathcal W_5$, a four-index tensor, hence on $\mathrm{Sym}^3(\mathcal W_5)$. So each $SO(5)$-isotypic component is $O(5)$-stable and carries a single $O(5)$ extension, and the two isotypic decompositions coincide.
- (b) Every $V_\lambda$ in the table is of real type, so that Schur reduces an invariant symmetric Gram block of multiplicity $m$ to an $m\times m$ real symmetric matrix, giving $m(m+1)/2$ unknowns.

Both are classical. Passage A states only "Because $O(5)$ acts" (line 3), and the brief's "as the passages argue" has no counterpart in the quoted lines.

**Verdict: HYPOTHESIS-DEBT** (minor). The two facts above are to be stated and cited.

### 6, withdrawn candidate: "$(1,0)$ is not an $O(5)$ constituent"

1. *Location.* Line 38, the block $(1,0)_5$.
2. *Apparent failure.* $-I$ acts on the vector representation $\mathbb R^5$ by $-1$ and on $\mathrm{Sym}^3(\mathcal W_5)$ by $+1$, so $\mathbb R^5$ cannot be an $O(5)$-constituent. The same holds for every Young-diagram module $[a,b]$ with $a+b$ odd, on which $-I$ acts by $(-1)^{a+b}$. The table has ten such labels: $(3,2)$, $(5,2)$, $(4,3)$, $(4,1)$, $(2,1)$, $(3,0)$, $(6,3)$, $(5,4)$, $(5,0)$, $(1,0)$.
3. *Charitable reading, which succeeds.* The table labels are $B_2$ highest weights $(a,b)$, not $O(5)$ Young labels $[a,b]$. As $O(5)$-modules these ten blocks are $[a,b]\otimes\det$, on which $-I$ acts by $+1$. The block structure, multiplicities and dimensions are unchanged. **Withdrawn**: nothing in L83 misreads the labels. A downstream use that reads $(a,b)$ as the untwisted $O(5)$ module $[a,b]$ for $a+b$ odd would be wrong. Line 9's use of $[\cdot]$ for $\mathcal W_5$ itself is harmless because $2+2$ is even.

## 7. The trivial multiplicity

**Claim** (line 42): "The trivial multiplicity is $1$ here and $2$ from $n\ge6$, which is the parity-sensitive Lovelock collapse: at $n\le5$, $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$, so the cubic invariant space is one-dimensional."

**The chain as written, link by link.**
1. *At $n\le5$, $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$.* Imported. Read at source ([bispectral.md](../findings/bispectral.md) lines 121-125, 143-147). It rests on the display $\beta-\tfrac\alpha2=-\tfrac1{64}\delta^{a_1\cdots a_6}_{b_1\cdots b_6}WWW$ together with the vanishing of the six-index generalised delta for $n\le5$. The vanishing is correct: antisymmetrising over six indices that take at most five values gives $0$. The display itself is supported by a script at $n=6,7,8$ (line 125), and the source file records at line 137 that its proportionality has "an unread source, and the whole $n\le5$ collapse rests on it". So link 1 is HYPOTHESIS-DEBT at source.
2. *Hence the cubic invariant space is one-dimensional.* Two unstated steps are needed. (i) Every $O(5)$-invariant cubic on $\mathcal W_5$ is a combination of $\alpha$ and $\beta$ (a first-fundamental-theorem reduction of complete contractions of three Weyl tensors). This gives $\le1$ once link 1 holds. (ii) $\operatorname{tr}(W^3)\not\equiv0$ on $\mathcal W_5$, which gives $\ge1$. Neither is on file in the cited lines.
3. *"$2$ from $n\ge6$".* This needs the independence of $\alpha$ and $\beta$ for every $n\ge6$ plus (i). Line 137 of the source records that "only there" has no argument at all. It is outside the $n=5$ table, but it is offered as the reason.

**Wording.** "Parity-sensitive" names the wrong invariant. The threshold $n\le5$ against $n\ge6$ is dimensional ($2k=6$ for the cubic Lovelock term): $n=4$ (even) and $n=5$ (odd) both collapse, and $n=6$ (even) and $n=7$ (odd) would both not. Charitable reading: a slip for "dimension-sensitive". No mathematical consequence.

**Consistency at the edge.** The table's $(0,0)_1$ with multiplicity $1$ agrees with the claimed value. It is a cross-check between two unproven statements, not a proof of either.

**Verdict: HYPOTHESIS-DEBT.** To be proved: (1) the display at source, (2) the spanning of cubic invariants by $\alpha,\beta$, (3) $\operatorname{tr}(W^3)\not\equiv0$ on $\mathcal W_5$, and for the $n\ge6$ half (4) independence for every $n\ge6$.

## 8. Passage C

**"Every number re-derives by hand, all $24$ subscripts from Weyl's formula and the Casimir at $B_2$'s own $\rho$."**
- True of the 24 subscripts (§1), the four sums and $4125$ (§4a), and the label arithmetic (§5).
- The Casimir produces no subscript. The table carries no Casimir column, and $c_2$ separates labels but gives dimensions to nothing. Wording only.
- For the 24 multiplicities and the weight list, no hand derivation is on file, and the same paragraph says arithmetic on the weights does not give them. "Every number" is therefore unsupported for the numbers that constitute the lemma.
- **"The table is right"** is asserted without argument.
- **Verdict: HYPOTHESIS-DEBT** (the same debt as §2).

### 8a. "one block is closed by an external count of $7770$"

1. *Location.* Line 942, with line 284 ("with one block closed by an external count") and the heading at sym3-blocks.md line 15 ("with one external closure ($7770$)").
2. *Failure exhibited.* No block is named. A single linear count $\sum m_\lambda d_\lambda=7770$ can fix one unknown multiplicity only if the weight carrying it is already known and every other row is already established. It cannot say which weight the residue belongs to: for example, a residue of $35$ fits $(2,2)$ and $(2,1)$ equally. Under this reading the count is consumed in building the table, and §4's only external check is no longer a check.
3. *Charitable reading.* "Closed" means "checked", and "one block" is a slip for "the table". Then the sentence says what §4a confirms, and no block's multiplicity is inferred from the count. The text does not decide between the readings, and they carry opposite consequences for whether $7770$ checks anything.

**Verdict: GAP.** The record must say whether any multiplicity was solved from $7770$, and if so which one and on what prior knowledge of the other 23 rows.

## 9. The Lean file

[L83.lean](../lean/HamiltonsCubic/Results/L83.lean) types:
- a `structure Block` of three naturals $(a,b,\mathit{mult})$
- `dim a b`, Weyl's $B_2$ formula in the $e$-basis with truncating division
- `table`, a list of 24 triples matching lines 33-38 entry for entry (checked by eye against §1's list)

It proves by `decide`/`norm_num`:
- `card_table` (length $24$)
- `dims_match` (the formula reproduces the printed subscripts)
- `sum_mult_dim` ($7770$) and `seven_seven_seven_zero` ($\tfrac{37\cdot36\cdot35}{6}=7770$)
- `sum_mult` ($41$), `sum_unknowns` ($65$), `sum_mult_one` ($4125$)
- statements for other results (L86, L87, L88) outside this round

It contains no representation, no $\mathcal W_5$, no $\mathrm{Sym}^3$, no group, and no statement that `table` is the decomposition of anything. Its docstring (lines 7-10) calls the weights and multiplicities "the imported content". I did not build it, so the kernel checks are reported as written, not as run.

**Verdict: CONFIRMED AS ALGEBRA.** It certifies §1 and §4a and **does not state or prove L83**.

## Standing list

1. **Hypothesis inventory.** See the table above. Used but unstated: the $O(5)=SO(5)$ isotypic coincidence, real type of every block, spanning of cubic invariants by $\alpha,\beta$, and $\operatorname{tr}(W^3)\not\equiv0$. The multiplicities themselves are held by a script only.
2. **Quantifier order and scope.**
   - $n$: only $n=5$ is in the table. The single claim at $n\ge6$ (trivial multiplicity $2$) has no argument (§7).
   - Group: $B_2$ labels are used for an $O(5)$ statement, which is correct by §6(a) but not argued on file.
   - Label basis: the $e$-basis, forced but unstated at the table (§0).
3. **Edges of every range.**
   - Equal dimensions: $(2,2)_{35}$ against $(2,1)_{35}$ and $(6,6)_{455}$ against $(5,3)_{455}$ are invisible to every closure (§4). The first pair gives an explicit alternative table.
   - Equal Casimirs: $(4,1)/(3,3)$ at $30$, $(4,3)/(5,0)$ at $40$ and $(6,2)/(5,4)$ at $60$ (§3).
   - Trivial block: consistent with, but not proved by, §7.
   - $n=5$ against $n\ge6$: §7.
   - $(6,6)$ at multiplicity $1$: consistent with the Cartan component.
4. **Proven against stated or used.**
   - *Proven:* dimensions, sums and label arithmetic.
   - *Stated:* the full decomposition.
   - *Used:* the Gram block sizes and the $65$ unknowns. These need the multiplicities (debt), the isotypic coincidence (debt) and real type (debt).
   - *Across B and C:* Passage B claims arithmetic suffices. C concedes it does not, yet keeps "every number re-derives by hand" and "the table is right" with no replacement argument.
5. **Lean.** It states and proves the arithmetic only (§9).
6. **Brief items 1-9.**
   - 1: §2, HYPOTHESIS-DEBT. No argument produces the weight list or the multiplicity column, and only the dimension and Casimir functions are argued.
   - 2: §3, REFUTED AS STATED.
   - 3: §4, REFUTED AS STATED, with the swap table exhibited.
   - 4: §1, CONFIRMED. The basis is forced but unstated.
   - 5: §5, CONFIRMED AS ALGEBRA, and §6, HYPOTHESIS-DEBT for the $O(5)$ reading.
   - 6: §7, HYPOTHESIS-DEBT, plus the "parity" wording.
   - 7: §8, HYPOTHESIS-DEBT, and §8a, GAP.
   - 8: §9, CONFIRMED AS ALGEBRA without stating L83.
   - 9: §4 and §3 edges, and the $4125$ total CONFIRMED (§4a).
7. **Falsifying objects and the search.**
   - *Dimension column:* a weight whose Weyl value differs from its subscript. All 24 were computed, none found.
   - *Sums:* a miscount. All were recomputed, none found.
   - *Multiplicities:* a dominant weight with the wrong multiplicity in $\mathrm{Sym}^3V_{(2,2)}$. Finding one requires the decomposition, which is out of scope. The necessary conditions a reader can check hold.
   - *"Four independent ways":* a second table passing all four. Exhibited.
   - *Label identification:* a second $35$-dimensional label with $c_2=16$. None exists, since $c_2(a,b)=16$ has the single dominant solution $(2,2)$ ($a=2$ forces $b(b+1)=6$, so $b=2$, while $a\ge3$ gives $a(a+3)\ge18>16$ and $a\le1$ gives $a(a+3)+b(b+1)\le4+2$).
   - *Trivial multiplicity:* a second independent cubic invariant on $\mathcal W_5$, or the vanishing of $\operatorname{tr}(W^3)$. Neither can be exhibited from the record, and the chain's links are unproven at source.

## Overall verdict

**HYPOTHESIS-DEBT.** Everything L83 prints that is a function of a stated weight is correct, and the Lean file certifies that arithmetic. The lemma's content (which 24 weights occur in $\mathrm{Sym}^3(\mathcal W_5)$, with multiplicities $4,4,3,2^{\times9},1^{\times12}$ and no others) has no argument on file beyond a script link. The sentences offered in its support are refuted as stated (§3, §4) or ambiguous in a way that matters (§8a). The $O(5)$ reading and the unknowns column rest on two unstated classical facts (§6). The trivial-block cross-check rests on a syzygy that its own source records as underived (§7).
