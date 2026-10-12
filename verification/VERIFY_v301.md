# Verifier v301, Lemma L88: the invariant counts 65, 24, 89 on Sym^3(W_5), the real type of the 24 blocks, the gauge claim, and the Q(i) coordinate claims

The brief ([BRIEF_L88.md](BRIEF_L88.md)) was cold. No numerical work was done, every value below is exact, and no script was written or run. The only arithmetic is hand evaluation of closed formulas at the values given in the brief. Log: [agent_logs/verify-L88-v301.log](../agent_logs/verify-L88-v301.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $\dim\mathrm{Sym}^2(U)^{O(5)}=65$, $\dim\Lambda^2(U)^{O(5)}=24$ | HYPOTHESIS-DEBT |
| 2 | $\sum\binom{m+1}2$, $\sum\binom m2$, $\sum m^2$ over Passage B give $65$, $24$, $89$, and under real type these are the invariant dimensions | CONFIRMED AS ALGEBRA |
| 3 | "$65+24=89$" as a check | CONFIRMED AS ALGEBRA (an identity, it detects no multiplicity error) |
| 4 | Every one of the 24 blocks is of real type | CONFIRMED (classical, unfiled) |
| 5 | The 24 antisymmetric directions are genuine invariants and are gauge for the Gram-to-sextic map | CONFIRMED |
| 6 | "The identification holds only in a basis real for $\sigma$, and such a basis forces $h$ real symmetric" | HYPOTHESIS-DEBT |
| 7 | "On a multiplicity-2 block the kernel direction is the imaginary coordinate iff $\operatorname{Im}h=0$" | REFUTED AS STATED |
| 8 | "Over 4000 bases ... the relative distance never fell below 0.541" | HYPOTHESIS-DEBT |
| 9 | The converse example $Q=\mathrm{diag}(1,i)$ gives $h=I$ with a real symmetric kernel direction | CONFIRMED |
| 10 | Rephasing one copy by $i$ passes the Hermitian assert and $\det h\ne0$ | CONFIRMED AS ALGEBRA (the multi-probe test is undefined in the brief) |
| 11 | A measured $h$ with nonzero imaginary off-diagonal shows the basis is not real | CONFIRMED AS ALGEBRA (the value of $h$ is a measurement) |
| 12 | Passage B's multiplicities | HYPOTHESIS-DEBT (a given, no derivation on file) |

**Summary:** the counts follow from Passage B by Schur and the classical real type of integral $B_2$ weights, and the gauge claim is sound for the sextic, but the multiplicities and hence $65$ and $24$ rest only on scripts, and the reviewer paragraph's "iff" is contradicted by its own converse example.

## 0. Conventions, fixed once

- $G=O(5)$, $\mathcal W_5$ the algebraic Weyl tensors on $\mathbb R^5$ ($\dim\mathcal W_5=5\cdot6\cdot7\cdot2/12=35$), $U=\mathrm{Sym}^3(\mathcal W_5)$ real, $\dim U=\binom{37}3=7770$.
- $O(5)=SO(5)\times\{\pm I\}$ since $5$ is odd. $-I$ acts on a 4-index tensor by $(-1)^4=1$, so trivially on $\mathcal W_5$ and on $U$. Hence $O(5)$-invariants equal $SO(5)$-invariants on every tensor construction from $U$, and each $O(5)$-constituent of $U$ restricts to an irreducible $SO(5)$-module with the same commutant.
- Highest weights $\lambda=(\lambda_1,\lambda_2)$, $\lambda_1\ge\lambda_2\ge0$, are in orthogonal ($\varepsilon$) coordinates. With $\rho=(3/2,1/2)$ and positive roots $\varepsilon_1\pm\varepsilon_2,\varepsilon_1,\varepsilon_2$, the Weyl dimension is $d_\lambda=(\lambda_1-\lambda_2+1)(\lambda_1+\lambda_2+2)(2\lambda_1+3)(2\lambda_2+1)/6$ and $c_2=\langle\lambda,\lambda+2\rho\rangle=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$, matching Passage B's stated Casimir.
- $U\otimes\mathbb C\cong\bigoplus_\lambda V_\lambda\otimes M_\lambda$, $m_\lambda=\dim M_\lambda$.
- Basis change on a multiplicity space: $f$ a $\sigma$-real orthonormal basis of $M_\lambda$ for the invariant inner product, $e=fQ$ the basis in hand, $Q\in GL_m(\mathbb C)$. A Hermitian form with matrix $X_f$ in $f$ has matrix $X_e=Q^*X_fQ$ in $e$. Then $h=Q^*Q$. This convention is the one under which the passage's own example "$Q=\mathrm{diag}(1,i)$ gives $h=I$" holds.
- For $m=2$, $J=\begin{psmallmatrix}0&1\\-1&0\end{psmallmatrix}$. In $f$ the $\Lambda^2$ ("kernel") direction of Hermitian forms is $iJ$, and in $e$ it is $iQ^*JQ$. "The imaginary coordinate" in $e$ is $\mathbb R\,iJ$.

## Hypothesis inventory (standing item 1)

| Hypothesis | Where | Used by | Stated? |
|---|---|---|---|
| Sextic is $O(5)$-invariant and the Gram is replaced by its group average (PSD preserved under averaging over a compact group) | "An SOS Gram is an invariant quadratic form" | Restriction of unknowns to invariants | Unstated, standard |
| Complete reducibility of $U$ | Decomposition $\bigoplus V_\lambda\otimes M_\lambda$ | Every count | Implicit (compact group) |
| Multiplicities $m_\lambda$ of Passage B | "the measured multiplicities" | Claims 1, 2 | Stated as measured, no derivation |
| Every $V_\lambda$ of real type | Real-type paragraph | Formula $\sum\binom{m+1}2$ | Stated, imported |
| All $B_2$ irreps self-dual (no complex type), since $-1\in W(B_2)$ | Needed for "hence of real type" | Claim 4 | Unstated: the sentence only excludes quaternionic type |
| Schur: $\mathrm{Hom}_G(V_\lambda,V_\mu)=0$ for $\lambda\ne\mu$, $\mathrm{End}_G(V_\lambda)=\mathbb R$ for real type, unique invariant form $\beta_\lambda$ on each $V_\lambda$, symmetric | Reduction of invariant bilinear forms to $\bigoplus\beta_\lambda\otimes h_\lambda$ | Claim 2 | Unstated, classical, unfiled |
| $-I$ acts trivially on $U$ | Passing between $O(5)$ and $B_2$ weights, "Weyl integration" on the disconnected $O(5)$ | Claims 1, 4 | Unstated in the quoted passages, true (Section 0) |
| Weyl integration output of the cited script | [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py) | Claim 1 | Script only, unread by rule |
| Measured $h$ on $(2,0)$, "4000 bases", "multi-probe test" | Reviewer paragraph | Claims 6, 8, 10, 11 | Measurements |

## 1. The two dimensions (claim 1, attack item 1)

- **Argument on file.** Two sources only: "Weyl integration settles it in run_n5_unknown_count.py", and agreement with the sums over "the measured multiplicities". Neither is an argument a reader can check. The first is a script, the second rests on multiplicities from [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py) (Passage B line 25).
- **What would have to be proved.** The decomposition of $\mathrm{Sym}^3(V_{(2,2)})$ under $SO(5)$ with the multiplicities of Passage B, for example by a character computation written out on file, or at minimum the two moments $\sum_\lambda m_\lambda=41$ and $\sum_\lambda m_\lambda^2=89$ (Section 3 shows these determine $65$ and $24$ under real type).
- **Verdict:** HYPOTHESIS-DEBT.

## 2. The sums over Passage B (claim 2)

Hand reading of Passage B's table:

| $m$ | blocks | $\binom{m+1}2$ each, total | $\binom m2$ each, total | $m^2$ each, total | $m\,d$ total |
|---|---|---|---|---|---|
| 4 | 2 | 10, 20 | 6, 12 | 16, 32 | $4(220+35)=1020$ |
| 3 | 1 | 6, 6 | 3, 3 | 9, 9 | $3\cdot105=315$ |
| 2 | 9 | 3, 27 | 1, 9 | 4, 36 | $2\cdot1155=2310$ |
| 1 | 12 | 1, 12 | 0, 0 | 1, 12 | $4125$ |
| sum | 24 | 65 | 24 | 89 | 7770 |

- Multiplicities sum to $8+3+18+12=41$. The m=2 dimensions sum to $1155$ and the m=1 dimensions to $4125$ (as Passage B states). $\sum m_\lambda d_\lambda=7770=37\cdot36\cdot35/6$.
- All 24 dimensions reproduce exactly from the Weyl formula of Section 0, for instance $(4,2)$: $3\cdot8\cdot11\cdot5/6=220$, $(2,1)$: $2\cdot5\cdot7\cdot3/6=35$, $(6,4)$: $3\cdot12\cdot15\cdot9/6=810$, $(1,0)$: $2\cdot3\cdot5\cdot1/6=5$. The Dynkin-label reading is excluded: there $[2,1]$ would have dimension $3\cdot2\cdot5\cdot8/6=40\ne35$.
- **The reduction.** For real $U=\bigoplus_\lambda V^{\mathbb R}_\lambda\otimes M^{\mathbb R}_\lambda$ with every $V_\lambda$ of real type and pairwise non-isomorphic, Schur gives every invariant bilinear form as $\bigoplus_\lambda\beta_\lambda\otimes h_\lambda$ with $\beta_\lambda$ the unique invariant form (symmetric) and $h_\lambda$ an arbitrary real $m_\lambda\times m_\lambda$ matrix. The form is symmetric iff every $h_\lambda$ is. Hence $\dim(U\otimes U)^G=\sum m^2$, $\dim\mathrm{Sym}^2(U)^G=\sum\binom{m+1}2$, $\dim\Lambda^2(U)^G=\sum\binom m2$. The passage does not write this reduction. It is the classical content of "each multiplicity space carries a real structure and the invariant form is real symmetric in a real basis".
- **Verdict:** CONFIRMED AS ALGEBRA, conditional on Passage B and real type.

## 3. "65+24=89" as a check (claim 3, attack item 2)

- $U\otimes U=\mathrm{Sym}^2U\oplus\Lambda^2U$ as $G$-modules, and taking invariants commutes with direct sums, so $\dim\mathrm{Sym}^2(U)^G+\dim\Lambda^2(U)^G=\dim(U\otimes U)^G$ for every $U$. On the side of the sums, $\binom{m+1}2+\binom m2=m^2$ for every $m$. The equation holds identically in both readings and detects only an addition slip.
- The informative combination is the difference. $\dim\mathrm{Sym}^2(U)^G-\dim\Lambda^2(U)^G=\sum_\lambda\varepsilon_\lambda m_\lambda$ with $\varepsilon_\lambda$ the Frobenius-Schur indicator. Here $65-24=41=\sum m_\lambda$, which would test real type of every block, but only if the $65$ and $24$ were obtained independently of Passage B, and both are script output.
- The triple $(65,24,89)$ carries exactly the two moments $(\sum m,\sum m^2)=(41,89)$. Any reassignment of the multiplicities with the same two moments (for example swapping the multiplicities of two blocks of equal dimension, $(2,2)_{35}$ with $m=4$ and $(2,1)_{35}$ with $m=2$, which also preserves $\sum m d=7770$) passes every check in the passage.
- **Verdict:** CONFIRMED AS ALGEBRA.

## 4. Real type (claim 4, attack item 3)

- **The written chain.** "Every one of the 24 weights is integral for $B_2$, hence of real type, the quaternionic representations of $\mathfrak{so}(5)\cong\mathfrak{sp}(4)$ are the half-integral spin ones, and none occur."
- **Integrality.** Every weight in Passage B is a pair of integers with $\lambda_1\ge\lambda_2\ge0$ in $\varepsilon$-coordinates (Section 2 fixes the coordinates). Correct.
- **The import.** For $\mathrm{Spin}(5)\cong Sp(2)$ every irrep is self-dual, since $-1$ lies in the Weyl group, and the Frobenius-Schur indicator of $V_\lambda$ is the scalar by which the central element $\exp(2\pi i\rho^\vee)$, the nontrivial element of $\ker(\mathrm{Spin}(5)\to SO(5))$, acts. It is $+1$ exactly for integral $\lambda$. This is classical and unfiled. Its hypotheses (compact connected group, irreducible $V_\lambda$) hold, and $O(5)$ adds nothing because $-I$ is trivial on $U$.
- **Lacuna in the wording.** The sentence rules out quaternionic type and says nothing about complex type. The charitable reading takes self-duality as part of the classical fact cited, and under it the step is sound.
- **Consequence.** In a $\sigma$-real basis of $M_\lambda$ the invariant inner product of $U$ restricts to $\beta_\lambda\otimes h_\lambda$ with $h_\lambda$ real symmetric positive definite. Correct given real type.
- **Edges.** Multiplicity-1 blocks also need real type: a complex-type or quaternionic real irreducible with $m=1$ carries $1$ or $3$ invariant antisymmetric forms, so $\sum\binom m2$ would not vanish on them. The blocks of equal dimension, $(2,2)_{35}$ with $(2,1)_{35}$ and $(6,6)_{455}$ with $(5,3)_{455}$, are non-isomorphic (distinct highest weights, and $c_2=16,12$ and $96,52$), so Schur kills the cross terms and equal dimension plays no role.
- **Verdict:** CONFIRMED (import classical and unfiled).

## 5. The 24 are invariants of $\Lambda^2$ and are gauge (claim 5, attack item 4)

- **Invariants.** A $G$-invariant Hermitian form $H$ on $U\otimes\mathbb C$, restricted to real vectors, is $S+iA$ with $S$ real symmetric and $A$ real antisymmetric, both $G$-invariant, and conversely every such pair extends uniquely sesquilinearly. This split uses only the real structure of $U\otimes\mathbb C$, no basis of $M_\lambda$. So the Hermitian invariant forms have real dimension $65+24$ and the extra $24$ are $\Lambda^2(U)^G$. Correct.
- **Gram to sextic.** The sextic of a form $B$ is $p_B(W)=B(v,v)$ with $v=v(W)\in U$ real. For antisymmetric $A$, $A(v,v)=-A(v,v)$, so $A(v,v)=0$, and in the Hermitian ansatz $v^{\mathsf T}(S+iA)v=v^{\mathsf T}Sv$. The $\Lambda^2$ directions lie in the kernel of the map. Correct.
- **PSD cone.** In a real bilinear Gram, positivity is a property of the symmetric part, so $\Lambda^2$ is fully gauge. In the Hermitian ansatz the $\Lambda^2$ directions do move membership in the PSD cone. Take $m=2$ in a real orthonormal basis, $H_t=I+t\,iJ$. The matrix $iJ$ has eigenvalues $\pm1$, so $H_t$ has eigenvalues $1\pm t$. $H_0=I\succeq0$ and $H_2$ has eigenvalue $-1$, with the same sextic. The passage makes no PSD claim, and "gauge" is defined in the passage by the sextic. Candidate 5a in Section 9 records this.
- **Verdict:** CONFIRMED for the sextic map. The reduction of a Hermitian PSD certificate to a real one ($H\succeq0\Rightarrow S\succeq0$ on real vectors) is not written on file, and nothing in L88 as stated requires it.

## 6. "The identification holds only in a basis real for $\sigma$, and such a basis forces $h$ real symmetric" (claim 6, attack item 5)

- **Second half.** In a $\sigma$-real orthonormal basis $f$, $h=I$. In any basis $f R$ with $R$ real, $h=R^{\mathsf T}R$ real symmetric. Correct and immediate.
- **First half.** "The identification holds only in a basis real for $\sigma$" carries no argument in the passage. What would have to be proved: for $m\ge2$, $Q^*AQ$ is real for every real antisymmetric $A$ iff $Q$ is a complex scalar multiple of a real matrix. The literal statement also needs "up to a common phase" (candidate 6a, withdrawn) and "on blocks with $m\ge2$" (candidate 6b, withdrawn).
- **Application to $(2,0)$.** The conclusion "false" at $\lambda=(2,0)$ rests on the unargued first half and on the measured $h$. The $h$ quoted in the passage is Hermitian ($\overline{55i/37}=-55i/37$), with $\det h=5075/1628-3025/1369=(187775-133100)/60236=54675/60236>0$, positive definite and non-real. That is reading, and its source is a measurement.
- **Verdict:** HYPOTHESIS-DEBT.

## 7. "On a multiplicity-2 block the kernel direction is the imaginary coordinate iff $\operatorname{Im}h=0$" (claim 7, attack item 5)

**Discrepancy record.**

1. **Locate.** Source line 128 (brief line 17): "On a multiplicity-$2$ block the kernel direction is the imaginary coordinate iff $\operatorname{Im}h=0$".
2. **Exhibit.** The passage's own next sentence: "$Q=\mathrm{diag}(1,i)$ gives $h=I$ with a real symmetric kernel direction". Checked in Section 0's convention: $h=\mathrm{diag}(1,-i)\,\mathrm{diag}(1,i)=I$, so $\operatorname{Im}h=0$. $J\,\mathrm{diag}(1,i)=\begin{psmallmatrix}0&i\\-1&0\end{psmallmatrix}$, $Q^*JQ=\begin{psmallmatrix}0&i\\i&0\end{psmallmatrix}$, $iQ^*JQ=\begin{psmallmatrix}0&-1\\-1&0\end{psmallmatrix}$, real symmetric and outside $\mathbb R\,iJ$. The right side of the "iff" holds and the left fails. A second instance with no diagonal structure: $Q=\tfrac1{\sqrt2}\begin{psmallmatrix}1&i\\i&1\end{psmallmatrix}$ is unitary, so $h=I$, and $Q^*JQ=\mathrm{diag}(i,-i)$, $iQ^*JQ=\mathrm{diag}(-1,1)$, again real symmetric. The textual contradiction between "iff" and "the converse fails too" is independent of the convention.
3. **Opposite reading.** The most charitable reading is "only if": if the kernel direction is the imaginary coordinate then $\operatorname{Im}h=0$, with "the converse fails too" retracting the other direction. That reading is consistent with the example, and is the direction used against the $(2,0)$ basis. It is not what the sentence says, and the "only if" direction carries no argument on file (it is the $m=2$ case of the debt in Section 6).

- **Verdict:** REFUTED AS STATED. The surviving "only if" direction is HYPOTHESIS-DEBT.

## 8. "Over 4000 bases consistent with the measured $h$ the relative distance never fell below 0.541" (claim 8)

- A finite sample of bases, with a floating-point distance, is a measurement. It cannot establish a statement over all bases consistent with $h$. The brief classes it as HYPOTHESIS-DEBT.
- "Relative distance" is undefined in the brief.
- If the "only if" direction of Section 7 were proved, this figure would be redundant for the claim it supports.
- **Verdict:** HYPOTHESIS-DEBT.

## 9. The converse example and rephasing (claims 9, 10, 11)

- **Claim 9.** Verified in closed form in Section 7, step 2. CONFIRMED.
- **Claim 10.** With $D=\mathrm{diag}(1,i)$, rephasing sends $h\mapsto D^*hD$, which is Hermitian when $h$ is, and $\det(D^*hD)=|\det D|^2\det h=\det h$. So the Hermitian assert and $\det h\ne0$ are both blind to the rephasing, while Section 7 shows the "imaginary coordinate" split moves. The "multi-probe test" is not defined in the brief and is not assessed. CONFIRMED AS ALGEBRA.
- **Claim 11.** A basis $e=fQ$ with $Q=cR$, $c\in\mathbb C^\times$, $R$ real, has $h=|c|^2R^{\mathsf T}R$ real. So nonzero $\operatorname{Im}h$ implies $e$ is not real, even up to a common phase. Correct as an implication. The value of $h$ is a measurement ("reproduced exactly by reviewers 201 and 202" is agreement between runs, not a derivation). CONFIRMED AS ALGEBRA.
- **"They appear because the 41 highest-weight vectors were built over $\mathbb Q(i)$."** Read literally, the $24$ appear in any Hermitian ansatz, in any basis (Section 5). Candidate 9a records the charitable reading under which the sentence stands.

## 10. Scope: Passage B's multiplicities (claim 12, attack item 6)

- Passage B's multiplicities come "from the character computation" in a script. By the brief's rule, a statement supported only by a script is HYPOTHESIS-DEBT.
- Everything numeric in L88 ($65$, $24$, $89$, the $m=2$ block $(2,0)$ as the site of the non-real $h$) depends on them.
- What is checkable by reading holds: all 24 dimensions, $\sum m d=7770=\dim U$, the multiplicity and unknown totals $41$ and $65$. These constrain the multiplicities but do not determine them (Section 3).
- Passage B itself marks the trivial multiplicity $1$ as resting on an owed spanning statement and on $\operatorname{tr}(W^3)\not\equiv0$ on $\mathcal W_5$. That owed item feeds the $m=1$ count.
- **Verdict:** HYPOTHESIS-DEBT.

## 11. Passage C (attack item 7)

Both Lean files are withheld by the brief and were not opened. No finding.

## 12. Standing items 2 to 4 and 6

- **Quantifier order and scope (item 2).** Group: $O(5)$ throughout, legitimately interchangeable with $SO(5)$ because $-I$ acts trivially (Section 0). Field: the counts are over $\mathbb R$, the Hermitian ansatz over $\mathbb C$ (with the basis over $\mathbb Q(i)$), and Section 5's split is basis-free. Basis: the $\Lambda^2$ subspace is intrinsic, while its coordinates depend on the basis of $M_\lambda$, which is exactly the passage's point. Gram-to-sextic against the PSD cone: see Section 5. No finding beyond Sections 5 and 7.
- **Edges (item 3).** Multiplicity-1 blocks, equal-dimension pairs and real type are covered in Section 4 and candidate 6b. No finding.
- **Proven against stated (item 4).**
  - Stated: $\dim\mathrm{Sym}^2=65$, $\dim\Lambda^2=24$, and the $24$ are gauge.
  - Proven on file, modulo classical imports: $\dim\mathrm{Sym}^2(U)^G=\sum\binom{m+1}2$ and $\dim\Lambda^2(U)^G=\sum\binom m2$ for the multiplicities of $U$, and the gauge property of $\Lambda^2$ for the sextic.
  - The gap: the multiplicities, so the numerals $65$ and $24$.
- **Falsifiers (item 6).**

| Claim | Falsifying object | What was done |
|---|---|---|
| 1, 12 | A constituent of $\mathrm{Sym}^3(V_{(2,2)})$ with multiplicity other than Passage B's | Not searchable without a character computation, which is excluded. Every reading-level constraint checked (24 dimensions, $7770$, $41$, $65$) and found consistent |
| 2, 3 | An arithmetic slip in the sums | Summed by hand, no slip |
| 4 | A weight in $U$ that is half-integral, or an irrep of complex type | All 24 weights integral in the confirmed coordinates, and complex type is impossible for $B_2$ |
| 5 | A nonzero antisymmetric form with $A(v,v)\ne0$ | Impossible by $A(v,v)=-A(v,v)$. For the PSD cone, $H_2=I+2iJ$ exhibited |
| 6, 7 | A basis with $\operatorname{Im}h=0$ whose kernel direction is not the imaginary coordinate | Found: $Q=\mathrm{diag}(1,i)$ (the passage's own) and $Q=\tfrac1{\sqrt2}\begin{psmallmatrix}1&i\\i&1\end{psmallmatrix}$ |
| 8 | A basis consistent with the measured $h$ at relative distance below $0.541$ | Not searchable without numerics. The claim is a sample |
| 9, 10 | A failure of the closed-form example or of $\det$-invariance | Checked, none |

## 13. Withdrawn candidates

- **5a. "They are gauge" fails against the PSD cone.**
  1. Locate: "An antisymmetric form contributes nothing to a quadratic, hence nothing to the sextic, and they are gauge."
  2. Exhibit: $H_t=I+t\,iJ$ on an $m=2$ block has eigenvalues $1\pm t$ and the same sextic for all $t$.
  3. Opposite: "gauge" is defined in the sentence as contributing nothing to the sextic, which holds. For certificate existence, a PSD Hermitian $H$ restricts on real vectors to $S$ with $v^{\mathsf T}Sv=v^*Hv\ge0$, so zeroing $A$ loses nothing.
  - Withdrawn. The statement makes no PSD claim.
- **6a. "Only in a basis real for $\sigma$" fails for a phase-rotated real basis.**
  1. Locate: "the identification holds only in a basis real for $\sigma$".
  2. Exhibit: $e=e^{i\pi/4}f$ gives $X_e=X_f$, so the identification holds, while $\sigma(e_j)=-ie_j\ne e_j$.
  3. Opposite: a common phase acts trivially on forms, "real" means real up to a common phase, and the implication used (identification implies $h$ real) survives.
  - Withdrawn.
- **6b. The same sentence on multiplicity-1 blocks.**
  1. Locate: as 6a.
  2. Exhibit: for $m=1$ there is no $\Lambda^2$ direction and no imaginary coordinate of a $1\times1$ Hermitian matrix, so the identification holds vacuously in every basis, real or not.
  3. Opposite: the sentence concerns blocks carrying $\Lambda^2$ directions, $m\ge2$.
  - Withdrawn.
- **9a. "They appear because the 41 highest-weight vectors were built over $\mathbb Q(i)$" misattributes the 24.**
  1. Locate: source line 130, brief line 19.
  2. Exhibit: a Hermitian ansatz in a $\sigma$-real basis also has $89$ real parameters, the $24$ as $i$ times real antisymmetric matrices (Section 5).
  3. Opposite: in a non-real basis the $65$-dimensional $\mathrm{Sym}^2$ subspace is not the set of real symmetric coordinate matrices, so without $\sigma$ one cannot restrict to it and a Hermitian ($89$) ansatz is forced. Under that reading the $\mathbb Q(i)$ basis is why the ansatz was Hermitian.
  - Withdrawn.

## Overall verdict

**HYPOTHESIS-DEBT.**

- The structural content of L88 is sound modulo classical, unfiled imports (Schur, the real type of integral $B_2$ weights): the counts are $\sum\binom{m+1}2$ and $\sum\binom m2$, and $\Lambda^2$ is gauge for the sextic.
- The numerals $65$ and $24$ rest only on script-measured multiplicities.
- In the reviewer paragraph, the "iff" on multiplicity-2 blocks is REFUTED AS STATED by the paragraph's own converse example. The "only if" direction it needs, the "only in a real basis" claim, and the 4000-basis figure are HYPOTHESIS-DEBT.
- None of the reviewer-paragraph defects touches the lemma's headline statement.
