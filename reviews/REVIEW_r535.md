# Review r535, Lemma L127

**Target.** Lemma L127, "the block-level refinement of Lemma L27: which block each $\tfrac12$ comes from", in [findings/second-order.md](../findings/second-order.md), heading at line 732, through line 762.

**Reviewer.** r535, cold, adversarial. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts were run; every number below is derived by hand from the definitions.

**Method.** Conventions fixed from [findings/conventions.md](../findings/conventions.md). I then derived, without reading L127's proof first: the polarised form $L_M X = M\odot X+\tfrac12(MX+XM)$ on sectional matrices; the whole $L_e$-spectrum of $\mathcal D_n$ at $S^p\times S^q$; the full cross-factor and within-factor pair spectra from [Lemma L122](../findings/second-order.md)'s Kirchhoff form; the four-set values from [Lemma L121](../findings/second-order.md)'s $\Sigma$; and a complete multiplicity cross-check against [Lemma L27](../findings/nondegeneracy.md)'s ten summands.

**VERDICT: PLAUSIBLE**, every value in the table is true and I re-derived all four rows independently, and the cross-check against L27 is exact identically in $p,q$. Three defects stand in the text as printed: one cell false at $\min(p,q)=2$, one column whose reading silently changes between rows, and the $\mathcal D_n$ row's only cited source not covering the range the table is stated over. Repairs supplied for all three.

---

## 0. Conventions fixed, and my anchors agree with the record

At $S^p\times S^q$, $n=p+q$, sectional matrix $\alpha$ within $F_1$, $\beta$ within $F_2$, $\gamma$ across. Ricci-flatness is $(p-1)\alpha+q\gamma=0$ and $(q-1)\beta+p\gamma=0$. For a coordinate-diagonal $W$, $Q(W)_{ij}=M_{ij}^2+(M^2)_{ij}$ off the diagonal, so criticality gives

$$\theta=-(n-1)\gamma=(n-1)\lvert\gamma\rvert,\qquad\gamma<0,$$

which is L127's own closing identity, reached here before reading it. Polarising, $L_MX = M\odot X+\tfrac12(MX+XM)$ with the diagonal discarded; $L_MM=Q(M)=\theta M$, so $L_ee=e$ with $e=M/\theta$. All values below are $L_e$ values.

## 1. The four rows, each re-derived

**Four-set.** On a $(2,2)$-split, $A=\alpha+\beta$, $B=C=2\gamma$, so $\Sigma=(A-B)^2$ and $\alpha+\beta-2\gamma=-\gamma\frac{(n-1)(n-2)}{(p-1)(q-1)}$, giving $\tfrac12\sqrt\Sigma/\theta=\frac{n-2}{2(p-1)(q-1)}=\mu_{p,q}$. On a $(3,1)$-split $A=B=C=\alpha+\gamma$ and on $(4,0)$ all are $2\alpha$, so $\Sigma=0$. **Row confirmed.**

**Pair, cross-factor.** With $j\in F_1$, $k\in F_2$ the three eigenvector types of $\Delta^{(jk)}$ on $\mathbf1^\perp$ give $\Delta$-eigenvalues $-\gamma$ (multiplicity $p-2$), $-\gamma$ ($q-2$) and $\gamma(n-2)$ (simple), hence block values $0,0,-\tfrac12(n-1)\gamma=\theta/2$. **Spectrum $\{\tfrac12,0^{n-4}\}$ confirmed**, and L127's displayed intermediates are right: its "$(p-1)\alpha+(q-1)\gamma$" is exactly *row sum minus $M^{(jk)}$-eigenvalue* $=[(p-2)\alpha+(q-1)\gamma]-(-\alpha)$, which is the $\Delta$-eigenvalue, $=-\gamma$ by Ricci-flatness. The orbit vector $x_i=M_{ki}-M_{ji}$ is $(\gamma-\alpha,\beta-\gamma)$, sum-zero by Ricci-flatness, and is the constant-on-parts type. **Confirmed.**

**Pair, within-factor.** For $j,k\in F_1$ the block spectrum is not just a top; in full it is
$$\Big\{\ \lambda_p=\tfrac{p-2}{2(p-1)}\ \text{simple},\qquad (-\mu)^{\,q-1},\qquad 0^{\,p-3}\ \Big\},$$
the three types being constant-on-parts, supported-on-$F_2$-sum-zero, and supported-on-$F_1'$-sum-zero. Multiplicities total $n-3$. **Top confirmed for $p\ge3$**; see §3 for $p=2$.

**$\mathcal D_n$.** Writing $X=\begin{pmatrix}A&C\\C^{\mathsf T}&B\end{pmatrix}$ symmetric, hollow, row sums zero, three families diagonalise it:

| family | dimension | $L_e$ value |
|---|---|---|
| $M$ itself | $1$ | $1$ |
| $A=B=0$, $C\mathbf1_q=0$, $C^{\mathsf T}\mathbf1_p=0$ | $(p-1)(q-1)$ | $\gamma-\tfrac{\alpha+\beta}2$ divided by $\theta$, $=-\mu$ |
| $A_{ij}=u_i+u_j$, $C=-\tfrac{p-2}{q}u\mathbf1_q^{\mathsf T}$, $B=0$, $u\perp\mathbf1_p$ | $p-1$ | $\lambda_p$ |
| the same with $p\leftrightarrow q$ | $q-1$ | $\lambda_q$ |
| $A\in\mathcal D_p$, $B=C=0$ (and $B\in\mathcal D_q$) | $\tfrac{p(p-3)}2+\tfrac{q(q-3)}2$ | $0$ |

The dimensions sum to $pq+\tfrac{p(p-3)}2+\tfrac{q(q-3)}2=\tfrac{n(n-3)}2=\dim\mathcal D_n$ exactly, so the lower bounds are the eigenspaces and the list is complete. **Row confirmed**, and, decisively, **confirmed with no representation theory and with no appeal to L27**, valid at every $p,q\ge2$.

## 2. The multiplicity cross-check against L27, exact, identically in $p,q$

This is the brief's question 2, and it is the strongest thing in this review. Summing each eigenvalue over L120's block families against L27's ten summands:

| value | L127's blocks contribute | L27's summand | dimension |
|---|---|---|---|
| $1$ | $\mathcal D_n$: $1$ | $\langle W\rangle$ | $1$ |
| $\tfrac12$ | cross-factor pairs: $pq\times1$ | $\mathbb R^p\otimes\mathbb R^q$ | $pq$ |
| $+\mu$ | four-set $(2,2)$-splits: $\binom p2\binom q2$ | $\Lambda^2\otimes\Lambda^2$ | $\binom p2\binom q2$ |
| $\lambda_p$ | $\mathcal D_n$: $p-1$; within-$F_1$ pairs: $\binom p2$ | $S^2_0(\mathbb R^p)$ | $\tfrac{(p+2)(p-1)}2$ |
| $-\mu$ | four-set $\binom p2\binom q2$; $\mathcal D_n$ $(p-1)(q-1)$; within-$F_1$ $\binom p2(q-1)$; within-$F_2$ $\binom q2(p-1)$ | $S^2_0\otimes S^2_0$ | $\tfrac{(p+2)(p-1)}2\cdot\tfrac{(q+2)(q-1)}2$ |

The two nontrivial identities check out with no slack:

$$(p-1)+\tbinom p2=\tfrac{(p-1)(p+2)}2=\dim S^2_0(\mathbb R^p),$$
$$\tbinom p2\tbinom q2+(p-1)(q-1)+\tbinom p2(q-1)+\tbinom q2(p-1)=(p-1)(q-1)\tfrac{(p+2)(q+2)}4=\dim\big(S^2_0\otimes S^2_0\big).$$

**The two decompositions agree on the spectrum with multiplicity, identically in $p,q$.** Zeros then match by subtraction. At $(3,3)$ the values $+\mu$ and $\tfrac12$ collide and $\dim E(\tfrac12)=pq+\binom p2\binom q2=9+9=18$, reproducing L27's excluded case and L127's own closing paragraph.

**One observation the check forces.** Running it needs the *full* within-factor pair spectrum $\{\lambda_p,(-\mu)^{q-1},0^{p-3}\}$, which L127's table does not print, it gives only the top. The table alone cannot be audited against L27; I had to derive the missing rows. Adding the two full pair spectra would make the lemma self-checking.

## 3. Defects, quoted

### D1, the "reaches $\tfrac12$?" column is decided by the "top" column in three rows and not in the fourth

Verbatim, the $\mathcal D_n$ row:

> | $\mathcal D_n$ | $1$ | $\sigma(L_e|_{\mathcal D_n})=\{1,\ \lambda_p^{\,p-1},\ \lambda_q^{\,q-1},\ (-\mu)^{(p-1)(q-1)},\ 0^{\text{rest}}\}$, from [Lemma L27](nondegeneracy.md)'s summands | no |

The column is headed **top $L_e$-eigenvalue**. The cell's top is $1$, attained at $e$ itself. The next column says **no**. Rows one to three are answered by comparing their printed top against $\tfrac12$; row four cannot be, and the reader must silently either switch to a strict "$=\tfrac12$" reading or apply [Lemma L120](../findings/second-order.md)'s cut of $\mathcal D_n$ by $\langle M\rangle$. **L127 inherits the clause L120 was found to have omitted and does not handle it**, the word $W^\perp$, or $\langle e\rangle$, appears nowhere in the block.

The answer is correct once the cut is made: after removing $\langle e\rangle$ the top of $\mathcal D_n$ is $\max(\lambda_p,\lambda_q,0)<\tfrac12$.

**That the omission bites is on the record already.** Two consumers read the same row two ways. [r420](REVIEW_r420.md): "L127's $\mathcal D_n$ row supplies the same bound unconditionally". [ATTEMPTS.md:3978](../ATTEMPTS.md): "L127's $\mathcal D_n$ row says only that $\tfrac12$ is *not attained* there". Both readings are licensed by the printed row; only the first is what the row can be made to say, and only with the cut.

**Repair.** Head the third column *top $L_e$-eigenvalue on $W^\perp$*, and write the $\mathcal D_n$ cell as $\sigma(L_e|_{\mathcal D_n\cap W^\perp})=\{\lambda_p^{p-1},\lambda_q^{q-1},(-\mu)^{(p-1)(q-1)},0^{\text{rest}}\}$ with $1$ on $\langle e\rangle$ removed by the cut. Note that L127's own consumer at [second-order.md:900](../findings/second-order.md) already writes the block as "$\mathcal D_n\cap(W^*)^\perp$", the citation states the cut the lemma omits.

### D2, the four-set row's answer is an equality answer, and fails under the $\ge$ reading that Lemma L24 needs

Verbatim:

> | four-set | $\binom n4$ | $\mu_{p,q}=\dfrac{n-2}{2(p-1)(q-1)}$ on the $(2,2)$-splits, $0$ otherwise | only at $(3,3)$ ([Lemma L126](../findings/second-order.md#lemma-l126-the-four-set-tfrac12-threshold-met-in-the-two-factor-family-only-at-s3times-s3)) |

$\mu_{2,q}=\frac q{2(q-1)}>\tfrac12$ for every $q\ge2$. So at $\min(p,q)=2$ the four-set block **exceeds** $\tfrac12$: it does not attain it, and "only at $(3,3)$" is right for "$=\tfrac12$" and wrong for "$\ge\tfrac12$".

This matters because the table's obvious use is [Lemma L24](../findings/second-order.md), whose criterion is $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, a $\ge$ question. A reader checking L24 block by block off this table concludes $S^2\times S^q$ is safe. [Lemma L126](../findings/second-order.md)'s own box says the opposite, in bold: "$\mu_{2,q}=\dfrac q{2(q-1)}>\tfrac12$ at every $q$, so **no $S^2\times S^q$ is a local maximum**, its four-set block breaches [Lemma L24] outright."

**Answer to the brief's question 4:** the column asks $=\tfrac12$, and under that reading every row is answered consistently and correctly. The defect is that the reading is unstated and is not the reading L24 needs. **Repair:** rename the column *attains $\tfrac12$?* and add a fifth column *exceeds $\tfrac12$?*, whose only "yes" is the four-set row at $\min(p,q)=2$.

### D3, the within-factor top is not attained at $p=2$

Verbatim:

> | pair, **within-factor** | $\binom p2$ and $\binom q2$, **two families** | $\dfrac{p-2}{2(p-1)}$ and $\dfrac{q-2}{2(q-1)}$ respectively, both $<\tfrac12$ | no |

At $p=2$ the set $F_1\setminus\{j,k\}$ is empty, so both the constant-on-parts type and the $F_1'$-sum-zero type vanish, and the single within-$F_1$ block is $(-\mu_{2,q})^{q-1}$ entire, with top $-\frac q{2(q-1)}<0$. The printed $\frac{p-2}{2(p-1)}=0$ is then an upper bound that is **not attained**, in a column headed "top $L_e$-eigenvalue".

The conclusion "both $<\tfrac12$" survives, and [r375](REVIEW_r375.md) recorded exactly this, "L127's $(p-2)/(2(p-1))=0$ is then an upper bound that is not attained. **The conclusion survives; the cited formula does not apply**", and **the repair was never folded into the block.**

### D4, the $\mathcal D_n$ row's only cited source does not cover the table's stated range

The row is sourced "from [Lemma L27](nondegeneracy.md)'s summands". L27 is stated for $p,q\ge3$ with $(p,q)\ne(3,3)$; L126's box in the same file records that its decomposition **over-counts at $p=2$**, $86$ against $84$ at $S^2\times S^4$. But L127's table is stated "At $S^p\times S^q$" with no restriction, and its four-set row cites L126, whose content is *precisely* $p=2$ and $(3,3)$, the two cases L27 refuses. **So the table's own four-set row invokes the range in which its $\mathcal D_n$ row has no source.**

The row is nevertheless true there: §1 above derives it from the polarised $L_M$ for every $p,q\ge2$, with no representation theory. At $p=2$ the third family degenerates to $\{0\}$ and $\lambda_2=0$, so the printed multiset $\{1,\lambda_p^{p-1},\dots\}$ still reads correctly, $\lambda_2^1$ merging into the zeros. [r392](REVIEW_r392.md) derived the same thing and recommended precisely this repair, "Add the $\mathcal D_n$ spectrum in the closed form above to L127's row as a second, representation-theory-free proof valid at $p=2$", and **it was never folded.**

### D5, the priority-withdrawal note misstates L27's scope

Verbatim, the block's second line:

> ***The first version claimed to prove sphere-product nondegeneracy for all $p,q$ and all $n$ as new. [Lemma L27](nondegeneracy.md) already does***

L27 does not. Its statement is "Let $p,q\ge3$ with $(p,q)\ne(3,3)$", and by [Lemma L11](../findings/nondegeneracy.md)'s corrected statement the proposition is not merely unproved but **false** outside that range: "The exceptions are two families, not one, $(3,3)$, and every product with $\min(p,q)=2$." So the sentence disclaiming priority overstates the thing it defers to.

**Answer to the brief's question 5:** apart from this, no priority claim survives. The title reads "the block-level refinement of Lemma L27", the closing box says "*Does not*: establish nondegeneracy independently, since the $\mathcal D_n$ row is L27's", and the [LEDGER](../findings/LEDGER.md) row 170 records the withdrawal. The eight citations claim nothing for L127 beyond the block table; none asserts priority. **Clean, but for the scope error in the disclaimer itself.**

### D6, one mis-targeted reference

The block writes `[post F40](INDEX-traps.md)`. Post F40 is at [findings/fence-posts.md:324](../findings/fence-posts.md), under a `## Post F40,` heading; [findings/INDEX-traps.md](../findings/INDEX-traps.md) carries no F40 row. The link lands nowhere.

## 4. The brief's question 3 rests on a false premise, and that is a finding

The brief asks whether the pair row states a fact or a bound, and whether it carries L122's maximiser hypothesis. **It states a fact and needs no maximiser.** L122 separates three hypothesis sets, and L127 uses only the second: the Kirchhoff rewriting, which needs coordinate-diagonality plus Ricci-flatness, both present at $S^p\times S^q$. L122's *inequality* $\lambda_{\min}(\Delta^{(jk)}|_{\mathbf1^\perp})\ge-(\theta+M_{jk})$ is the clause that needs a maximiser, and L127 never invokes it; it computes the block spectrum outright, and I reproduced that computation eigenvector type by eigenvector type in §1. Nothing is owed here.

## 5. The eight citations, and what each takes

| where | what it takes |
|---|---|
| [second-order.md:787](../findings/second-order.md) (L128 novelty accounting) | the *scope* of the table, "L127 has the block table only at sphere products". A limitation statement, correct. |
| [second-order.md:789](../findings/second-order.md) | a **strengthening**: L128(iii) reinstates L127's withdrawn branching clause. Consistent with the block, which prints the withdrawal. |
| [second-order.md:793](../findings/second-order.md) (Corollary L128.1) | the two **pair rows**, correctly attributed. It takes the $\mathcal D_n$ leg from L27 directly, not from L127 (so it routes around D4) and it assumes $p,q\ge3$ explicitly. Clean. |
| [second-order.md:895](../findings/second-order.md) (the $\kappa^{\mathrm{Hess}}$ lemma) | the **whole table** at $S^m\times S^m$. It writes the fourth block as "$\mathcal D_n\cap(W^*)^\perp$" (stating D1's cut) and then defers that block to L27 for strictness. Clean, and it silently repairs D1. |
| [second-order.md:914](../findings/second-order.md) | the **four-set row** at $n=6$, for the $\dim E(\tfrac12)=18$ agreement. Correct. |
| [LEDGER.md:170](../findings/LEDGER.md) | a ledger entry recording the Gate 2 landing and the novelty withdrawal, not a mathematical use. |
| [plan.md:51](../plan.md) | names L127 as a sphere-product fact that item I3 does **not** borrow. Correct, the competitor is not a sphere product. |
| [ATTEMPTS.md:3972](../ATTEMPTS.md), [3978](../ATTEMPTS.md) | "the full block table" as an ingredient; and the reading of the $\mathcal D_n$ row flagged in D1. |

**No citation takes a row in a way the row cannot support**, and no citation overstates it. The one place the table is read differently by two consumers is the $\mathcal D_n$ row, which is D1.

## 6. Cross-file scan

Grepped `findings/` for the block tops $\frac{p-2}{2(p-1)}$, $\{\tfrac12,0^{n-4}\}$ and $\mu_{p,q}$, and read the later sections of [second-order.md](../findings/second-order.md).

- **No contradicting restatement anywhere.** [second-order.md:589](../findings/second-order.md) and [:595](../findings/second-order.md) give $L_e|_{\mathrm{Sym}_0(\mathbb R^p)}=\frac{p-2}{2(p-1)}$; L121 at [:641](../findings/second-order.md) and L122 at [:664](../findings/second-order.md) both attribute it to the within-factor pair block *and* to $\mathcal D_n$. My §2 tally explains why both are right and gives the split: $\binom p2$ copies in pair blocks against $p-1$ in $\mathcal D_n$, totalling $\dim S^2_0(\mathbb R^p)$.
- **[INDEX-results.md:145](../findings/INDEX-results.md)** summarises L127 by the cross-factor row alone; it states nothing false.
- **No later passage in second-order.md corrects L127.** The nearest thing is [:900](../findings/second-order.md) writing "$\mathcal D_n\cap(W^*)^\perp$", which is D1's repair applied without saying that it is one.
- **Two repairs already on the record are unfolded**: [r375](REVIEW_r375.md)'s $p=2$ degeneration (D3) and [r392](REVIEW_r392.md)'s representation-theory-free $\mathcal D_n$ derivation (D4). Both were recommended in reviews and neither reached the block.

## 7. Summary of repairs owed

1. Cut $\langle e\rangle$: head column three *on $W^\perp$* and drop the $1$ from the $\mathcal D_n$ cell. (D1)
2. Split column four into *attains $\tfrac12$?* and *exceeds $\tfrac12$?*; the second is "yes at $\min(p,q)=2$" in the four-set row and "no" elsewhere. (D2)
3. Mark the within-factor top as an upper bound not attained at $p=2$, where the block is $(-\mu)^{q-1}$ entire. (D3)
4. Replace "from L27's summands" with the direct derivation, which holds at every $p,q\ge2$ and removes the range mismatch. (D4)
5. Correct the disclaimer: L27 proves it for $p,q\ge3$, $(p,q)\ne(3,3)$, not "for all $p,q$ and all $n$". (D5)
6. Repoint `[post F40](INDEX-traps.md)` at [fence-posts.md](../findings/fence-posts.md). (D6)
7. Optional but valuable: print the full pair-block spectra, so the L27 cross-check of §2 can be run off the table alone.

## 8. Computation not run

None was needed and none was run. Had the multiplicity cross-check of §2 failed to close symbolically, the run that would have decided it is an exact $L_e$ diagonalisation on an explicit $\mathcal D_n$ basis at two or three $(p,q)$, and I would have stopped and said so rather than running it. It closed by hand, identically in $p,q$, which is the stronger outcome.
