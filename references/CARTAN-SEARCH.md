# The search for a source for Cartan's classification

**Date**: 2026-09-07. **Standing**: [findings/conventions.md](../findings/conventions.md) records the appeal to Cartan's classification as made bare in four results, [L23](../findings/ungraded-slack.md), [L27](../findings/nondegeneracy.md), [L08](../findings/graded-half.md) and [L69](../findings/graded-half.md), and cited to nothing; [findings/LEDGER.md](../findings/LEDGER.md) item 7 records acquiring a source as blocked. This file is the record of the search that lifted the block, and of the one fact it failed to lift.

The four facts the record consumes, as posed:

1. **The involutions of the compact $\mathfrak{so}(n)$ up to conjugacy**, $\mathfrak k=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=n$, and $\mathfrak k=\mathfrak u(n/2)$ at even $n$. Consumed to enumerate the $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$ at $n\ge12$.
2. **The $\mathrm{Aut}$-versus-$SO(n)$-conjugacy distinction**, and that the two differ at $n=8$.
3. **The classification of compact irreducible symmetric spaces**, used to argue a check is finite.
4. **Casimir eigenvalue data for the exceptional pairs** $\mathfrak g_2$, $\mathfrak f_4$, $\mathfrak e_{6,7,8}$.

## Candidates

Every row was fetched in full and read; nothing below rests on a search-engine summary. Copyrighted books (Helgason, Besse, Berger) were not sought, by instruction.

| candidate | how found | fetched | 1. $\mathfrak{so}(n)$ involutions | 2. $\mathrm{Aut}$ vs $SO(n)$ | 3. the finite classification | 4. exceptional Casimirs | verdict |
| --- | --- | --- | --- | --- | --- | --- | --- |
| [Holland–Ion, *Notes on symmetric spaces*, arXiv:1211.4159](https://arxiv.org/abs/1211.4159) | search: involutions / compact Lie algebra / symmetric pairs / lecture notes | PDF + text, 109 pp. | **yes**, compact form, all four cases, pp. 96–103 | no, relation never named, $n=8$ never separated | **yes**, classical families and all twelve exceptional pairs, Ch. 8 | no, no dimensions, no eigenvalues | **ACQUIRED** → [holland-ion-2012-symmetric-spaces](holland-ion-2012-symmetric-spaces/) |
| [Etingof, MIT 18.755 Lecture 15](https://ocw.mit.edu/courses/18-755-lie-groups-and-lie-algebras-ii-spring-2024/mit18_755_s24_lec15.pdf) | search: classification of real forms / Vogan diagrams | PDF + text, 8 pp. | **yes**, by explicit $O(n)$ matrices with the determinant in each case, pp. 223–224 | **half**, Theorem 41.5 names $\mathrm{Aut}$-conjugacy as the relation; $D_4$ is not separated | classical only, exceptional absent | no | **ACQUIRED (partial scope)** → [etingof-2024-real-forms-involutions](etingof-2024-real-forms-involutions/) |
| [Ziller, *Lie Groups. Representation Theory and Symmetric Spaces*](https://www2.math.upenn.edu/~wziller/math650/LieGroupsReps.pdf) | search: automorphism group of $\mathfrak{so}(n)$ / outer / triality | PDF + text, 178 pp. | no, Ch. 6 stops before any list | **yes**, Prop. 4.43 and Ex. 4.45: $\mathrm{Out}\cong\mathrm{Sym}(D)$, $B_n$ trivial, $D_{n}$ realised in $O(2n)$, $D_4=S_3$ | no | no | **ACQUIRED for fact 2's mechanism** → [ziller-2010-lie-groups-symmetric-spaces](ziller-2010-lie-groups-symmetric-spaces/) |
| [Yokota, *Exceptional Lie groups*, arXiv:0902.0431](https://arxiv.org/abs/0902.0431) | search: exceptional symmetric spaces / involutive automorphisms; independently the source [Petersen–Stanfield](petersen-stanfield-2025-poincare-polynomials/) call "the best guide" | PDF + text, 209 pp. | no | **yes for the construction**, Thms 1.3.5, 1.3.6, 1.14.2 build triality and prove the subgroup is $S_3$ | exceptional half, as twelve involutions with their global isotropy groups | no, the book carries no numerical invariants at all | **ACQUIRED for triality and the exceptional pairs** → [yokota-2009-exceptional-lie-groups](yokota-2009-exceptional-lie-groups/) |
| [Caselle–Magnea, *Random matrix theory and symmetric spaces*, cond-mat/0304363](https://arxiv.org/abs/cond-mat/0304363) | search: Cartan classification / table | PDF + text, 162 pp. | group-level restatement only ($SO(p+q)/SO(p)\!\times\!SO(q)$, $SO(4N)/SU(2N)\!\times\!U(1)$, Table 1 p. 51) | no | **classical only**, Table 1 lists the classical families and the group-type spaces; no exceptional space appears anywhere in the paper | no | **PARTIAL, not filed**, everything it states for facts 1 and 3 is stated better and more completely by Holland–Ion, and it adds the restricted-root multiplicities the record has no use for |
| [van Ritbergen–Schellekens–Vermaseren, *Group theory factors for Feynman diagrams*, hep-ph/9802376](https://arxiv.org/abs/hep-ph/9802376) | search: Casimir eigenvalues / exceptional groups / tables | PDF + text, 48 pp. | no | no | no | Tables 5–13 give indices and $C_A$ for $G_2,F_4,E_6,E_7,E_8$ (for the **algebras**, never for the symmetric pairs | **NO, deliberately not filed**), see the warning below |
| [Eschenburg, *Lecture Notes on Symmetric Spaces*](https://myweb.rz.uni-augsburg.de/~eschenbu/symspace.pdf) | search: symmetric spaces / lecture notes | PDF + text, 24 pp. | no | no | no (the word "classification" appears twice, both times pointing elsewhere | no | **NO**), a theory primer that defers every list to Helgason |
| [Yokota via Petersen–Stanfield](petersen-stanfield-2025-poincare-polynomials/) | already on the record | already held | no | no | referenced, not restated | no | already indexed; its role here was to corroborate the choice of Yokota |

## What the record can now cite

- **Fact 1, sourced twice, by routes that share nothing.** [Holland–Ion](holland-ion-2012-symmetric-spaces/) states it for the compact form directly, with the even-$p,q$ and odd-$p,q$ splits arriving from separate halves of its Chapter 8 (pp. 98 and 103), a reader who stops at the first half sees an incomplete list. [Etingof](etingof-2024-real-forms-involutions/) states it for the complex form and realises each involution as conjugation by a named element of $O(n)$, recording the determinant, which is the datum the record's $SO(n)$-conjugacy arguments actually consume.
- **Fact 2, the mechanism is sourced; the record's use of it is one step past the sources.** [Ziller](ziller-2010-lie-groups-symmetric-spaces/) Prop. 4.43 gives $\mathrm{Aut}/\mathrm{Int}\cong\mathrm{Sym}(D(\mathfrak g))$ and Ex. 4.45 reads it off as: inner-only at type $B$, one outer class realised inside $O(2n)$ at type $D_{n\ne4}$, and $S_3$ at $D_4$. [Etingof](etingof-2024-real-forms-involutions/) Thm. 41.5 says the classification's conjugating group is $\mathrm{Aut}$. [Yokota](yokota-2009-exceptional-lie-groups/) Thm. 1.3.5 constructs the $S_3$ from octonion multiplication. **No source located states the consequence the record draws**, that two involutions of $\mathfrak{so}(8)$ can be $\mathrm{Aut}$-conjugate without being $O(8)$-conjugate, witnessed by $S^3\times S^5$ against $\mathbb{HP}^2$ at isotropy dimension $13$. That step stays the record's own, and the citation to use is "triality exists and $\mathrm{Out}(D_4)=S_3$", never "triality separates these two".
- **Fact 3, sourced.** [Holland–Ion](holland-ion-2012-symmetric-spaces/) Ch. 8 lists every classical family and all twelve exceptional pairs, with a caveat printed in its own text: completeness of the Vogan-diagram list is stated and not proved there.
- **Fact 4, unsourced.** See below.

## What remains unsourced

**Casimir eigenvalue data for the exceptional pairs.** Nothing located gives it. The three sources filed supply the *structural* half, [Holland–Ion](holland-ion-2012-symmetric-spaces/) names $(\mathfrak g,\mathfrak k)$ for all twelve, and [Yokota](yokota-2009-exceptional-lie-groups/) determines the global isotropy group including its central quotient, and none of them prints a dimension, a Casimir eigenvalue, or an isotropy-representation branching.

**A warning attached to the nearest miss.** [van Ritbergen–Schellekens–Vermaseren](https://arxiv.org/abs/hep-ph/9802376) Table 13 (p. 44) is the closest thing found to an exceptional Casimir table, and it should not be cited without checking. It prints, with $\eta$ a normalisation the reader fixes,

| group | $G_2$ | $F_4$ | $E_6$ | $E_7$ | $E_8$ |
| --- | --- | --- | --- | --- | --- |
| $N_A$ | 14 | 52 | 78 | 133 | 248 |
| $C_A$ | $4\eta$ | $9\eta$ | $24\eta$ | $18\eta$ | $30\eta$ |

Four of the five $C_A$ coefficients are the dual Coxeter numbers of their algebras; the $E_6$ entry is twice its. The row was re-extracted from the PDF page directly to rule out a transcription artefact, and the printed value is $24\eta$. **This record has been bitten by an inexact source recorded as exact, so the table is named here and filed nowhere.**

**What a source for fact 4 would have to contain**, precisely: for each of the twelve compact exceptional pairs, either $(\dim\mathfrak g,\dim\mathfrak k)$, which is what the Dimension Lemma of [graded-half.md](../findings/graded-half.md) consumes, via $n=\dim\mathfrak g-\dim\mathfrak k$ and $\dim\mathfrak h=\dim\mathfrak k$, or the isotropy-block decomposition of $\mathfrak m$ with the Casimir eigenvalue on each block, which is what [Petersen–Stanfield](petersen-stanfield-2025-poincare-polynomials/) Prop. 2.2 turns into curvature-operator eigenvalues.

**Where it is likely to be found.** Three lines were opened and not run down:

- **Homogeneous-Einstein and isotropy-irreducible papers on arXiv**, which routinely tabulate $\dim G/K$ and the Casimir constants of the isotropy summands for the exceptional pairs. Two are already on this record, [bettiol-friedman-2025-counting-homogeneous-einstein](bettiol-friedman-2025-counting-homogeneous-einstein/) and [lauret-rossibertone-tolcachier-2025-sii-laplace](lauret-rossibertone-tolcachier-2025-sii-laplace/), and neither was re-read against this question during this search.
- **[Schwahn, arXiv:2012.10524](schwahn-2020-symmetric-space-stability/)**, on the record, computes Casimir eigenvalues on isotypes for $E_6/F_4$ specifically, by exactly the Freudenthal arithmetic fact 4 needs. It covers one of the twelve.
- **Physics-side group-theory tables** beyond van Ritbergen, Slansky's *Group theory for unified model building* is the standard one and is behind a publisher; open substitutes exist and were not enumerated.

## Note on method

Nine distinct query phrasings were run across arXiv, open-access journals, author pages, university course pages and MIT OpenCourseWare. Seven candidate texts were downloaded and converted with `pdftotext -layout`; every page number quoted in the four filed folders was verified by re-extracting that page from the PDF, because the printed pagination and the PDF pagination differ in three of the four. Two full texts were read in the sections that matter and skimmed elsewhere; two were read in full.
