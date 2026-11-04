# REVIEW r544, Lemma L31, "the bracket cap, characterised"

**Target.** [findings/stratum-two-negative.md:393](../findings/stratum-two-negative.md#L393), `#### Lemma L31 (the bracket cap, characterised), canonical statement and proof`, down to the next heading (line ~415).

**Statement audited.** *For orthonormal $X,Y\in\mathfrak{so}(n)$, $\lVert[X,Y]\rVert^2=2$ if and only if $XY=-YX$, both $X$ and $Y$ have rank $4$ with all singular values $1/\sqrt2$, and $\mathrm{im}\,X=\mathrm{im}\,Y$.*

**Footing.** Analysis-only. Everything below is derived by hand. Four short constructions were **screened** in `numpy` (objects I built for the purpose, seconds of compute) and are labelled *screen* wherever they appear. No search, sweep, census or falsifier hunt was run.

## VERDICT: CONFIRMED

The statement is **true as written**, at every $n$, in the record's half-trace pairing, and the block's proof is sound in **both** directions, including the "only if" that [Lemma L29](../findings/stratum-two-negative.md#L82)'s converse clause now leans on. Six defects are recorded below; **none of them touches the mathematics of the block**. Three are in passages *around* the block that contradict it or point at nothing, and one is the unrepaired provenance line the brief suspected.

## The answers, in brief

| # | question | answer |
| --- | --- | --- |
| 1 | is the cap $\le2$ proved or assumed? | **proved, in the block itself**, from the root system plus Cauchy–Schwarz. No hypothesis is inherited |
| 2 | are the three conditions independent? | **all three independent**, three witnesses below, each satisfying two conditions and failing the bracket value |
| 3 | does the "only if" hold, hardest reading? | **yes**, and the equality chain it runs on is a genuine equality, I checked every constant |
| 4 | $n=4$, $n=5$? | both hold; realisable at both. $n\le3$ is vacuously true. No range is stated and none is needed |
| 5 | pairing? | **the record's half-trace pairing throughout**; every constant in the block is right in it |
| 6 | what the citations use | overwhelmingly the **cap alone**; the equality case is consumed at seven sites, all of them the "only if" image clause; the "if" is consumed twice |

## 1. The cap is proved here, not assumed

The block proves it. Verbatim:

> The roots of $\mathfrak{so}(n)$ give $\mathrm{ad}_X$ the eigenvalues $i(\pm s_i\pm s_j)$ and $i(\pm s_i)$ for the angles $s_i$ of $X$, so $\max_{\|Y\|=1}\|[X,Y]\|^2=(s_1+s_2)^2$ exactly. With $\sum_is_i^2=1$, Cauchy–Schwarz gives $(s_1+s_2)^2\le2$

I re-derived this cold. $\mathrm{ad}_X$ is skew-adjoint for the ad-invariant trace form, hence normal, hence $\lVert\mathrm{ad}_X\rVert_{\mathrm{op}}=\max|\text{eigenvalue}|$. Every eigenvalue modulus is some $|s_i\pm s_j|$ or $s_i$, all $\le s_1+s_2$, and $s_1+s_2$ is attained for $n\ge3$. Then $(s_1+s_2)^2\le2(s_1^2+s_2^2)\le2\sum_is_i^2=2$, with equality iff $s_1=s_2=1/\sqrt2$ and the rest vanish. **So $\lVert[X,Y]\rVert^2\le2$ is a theorem of this block**, and the conditions its consumers inherit are exactly $\lVert X\rVert=\lVert Y\rVert=1$.

Two notes, neither material.

- **The root list is the odd-$n$ ($B_r$) list.** At even $n$ the roots $\pm e_i$ do not exist, so the eigenvalues $i(\pm s_i)$ are absent. The block prints both families without saying which $n$. Harmless: $s_1\le s_1+s_2$, so a spurious eigenvalue never raises the maximum.
- **[conventions.md:74](../findings/conventions.md#L74) records the cap as a bare "standing fact"**, *"$\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ … Both are standing facts, used across several files"*, with no pointer to L31, which is its proof. Two other files ([stratum-two-negative.md:21](../findings/stratum-two-negative.md#L21), [bounds-relaxations.md:269](../findings/bounds-relaxations.md#L269)) say the cap is *"proven through $\lVert\mathrm{ad}_X\rVert_{\mathrm{op}}\le\sqrt2$"*, which is L31's route stated correctly. **No file states the cap in a way that conflicts with the block.**

## 2. The "only if", the direction L29's closure needs, is sound

This is the direction I attacked hardest. The block's chain, verbatim:

> Equality in $\|[X,Y]\|_F\le\|XY\|_F+\|YX\|_F\le2\|X\|_{\rm op}\|Y\|_F$ then forces the columns of $Y$ into $X$'s top singular subspace, which is all of $\mathrm{im}\,X$ since the nonzero singular values coincide, so $\mathrm{im}\,Y\subseteq\mathrm{im}\,X$ and symmetrically; and the triangle step with $\|XY\|_F=\|YX\|_F$ forces $XY=-YX$.

Checked step by step, in the record's pairing ($\lVert A\rVert_F^2=2\lVert A\rVert^2$):

1. **The chain really is an equality.** $\lVert[X,Y]\rVert^2=2\Rightarrow\lVert[X,Y]\rVert_F=2$. From step 1, $\lVert X\rVert_{\mathrm{op}}=s_1=1/\sqrt2$; and $\lVert Y\rVert_F=\sqrt2$. So the right end is $2\cdot\tfrac1{\sqrt2}\cdot\sqrt2=2$, equal to the left end. Both inequalities are therefore equalities. *The block asserts this rather than computing it; the numbers do come out, but a reader has to supply them.*
2. **Image equality.** $\lVert XY\rVert_F^2=\mathop{\mathrm{tr}}(X^{\mathsf T}X\,YY^{\mathsf T})=\mathop{\mathrm{tr}}(AB)$ with $A=X^{\mathsf T}X$ (eigenvalue $\tfrac12$ with multiplicity $4$, else $0$) and $B=YY^{\mathsf T}\succeq0$, $\mathop{\mathrm{tr}}B=2$. Equality $\mathop{\mathrm{tr}}(AB)=\lVert A\rVert_{\mathrm{op}}\mathop{\mathrm{tr}}B$ forces $\mathrm{im}\,B\subseteq$ the top eigenspace of $A$, which is $\mathrm{im}\,X$ because all four nonzero singular values coincide. So $\mathrm{im}\,Y\subseteq\mathrm{im}\,X$, both of dimension $4$, hence equal. **Sound.**
3. **Anticommuting.** $(YX)^{\mathsf T}=X^{\mathsf T}Y^{\mathsf T}=XY$ for skew $X,Y$, so $\lVert XY\rVert_F=\lVert YX\rVert_F$ automatically. Equality in $\lVert XY+(-YX)\rVert_F=\lVert XY\rVert_F+\lVert{-}YX\rVert_F$ with equal nonzero norms gives $-YX=XY$. **Sound.**

**One elision, not a gap.** The block derives rank $4$ and singular values $1/\sqrt2$ **for $X$ only**, then jumps to the statement's "both $X$ and $Y$". $Y$'s rank $4$ follows from $\mathrm{im}\,Y=\mathrm{im}\,X$, but $Y$'s *singular values* need the symmetric re-run of step 1 (legitimate, since $\lVert[Y,X]\rVert^2=2$ and $\lVert X\rVert=1$). The file's **own earlier copy** of this argument supplies exactly the missing sentence, [stratum-two-negative.md:261](../findings/stratum-two-negative.md#L261), *"Symmetric in $X$ and $Y$, so both"*, and the canonical block dropped it in the move. **Defect D5 below.**

**The orthogonality hypothesis is never used in the "only if"**, which only consumes $\lVert X\rVert=\lVert Y\rVert=1$. That is a silent strengthening, and it is harmless for every consumer.

## 3. The "if" is sound too

Verbatim: *"Conversely, $X^2=Y^2=-P_V/2$ and $[X,Y]=2XY$ give $\|[X,Y]\|^2=\mathop{\mathrm{tr}}(Y^{\mathsf T}Y)=2$."*

Rank $4$ with all singular values $1/\sqrt2$ on $V=\mathrm{im}\,X$ gives $X^{\mathsf T}X=\tfrac12P_V$, i.e. $X^2=-\tfrac12P_V$; anticommuting gives $[X,Y]=2XY$; so $\lVert[X,Y]\rVert^2=\tfrac12\mathop{\mathrm{tr}}(4Y^{\mathsf T}X^{\mathsf T}XY)=\mathop{\mathrm{tr}}(Y^{\mathsf T}P_VY)=\mathop{\mathrm{tr}}(Y^{\mathsf T}Y)=2$, the last step because $\ker Y=(\mathrm{im}\,Y)^\perp=V^\perp$ so $P_VY=Y$. **Every constant is in the half-trace pairing and every one is right**: $\mathop{\mathrm{tr}}(Y^{\mathsf T}Y)=\lVert Y\rVert_F^2=2\lVert Y\rVert^2=2$. There is **no half-trace/Frobenius collision in this block.**

*Screen.* $X=I/\sqrt2$, $Y=J/\sqrt2$ on $\mathbb R^4$: $\lVert X\rVert^2=\lVert Y\rVert^2=1$, $\langle X,Y\rangle=0$, $\lVert[X,Y]\rVert^2=2.000000$. Padded to $n=5$: $2.000000$. The parent's contrast also reproduces: $\varphi_{12},\varphi_{13}$ give $\lVert\varphi\rVert^2=1$ and $\lVert[\cdot,\cdot]\rVert^2=1$.

## 4. All three conditions are independent

Each witness below is orthonormal in the half-trace pairing, satisfies **two** of the three conditions, and fails $\lVert[X,Y]\rVert^2=2$. So no condition may be dropped, and the characterisation is exactly as tight as it needs to be. *(Constructed by hand, then screened; the screen agrees to machine precision.)*

| dropped condition | witness | the other two hold | $\lVert[X,Y]\rVert^2$ |
| --- | --- | --- | --- |
| **anticommuting** | $X=I^+/\sqrt2$, $Y=I^-/\sqrt2$ in $\mathfrak{so}(4)$, one self-dual and one anti-self-dual complex structure, they **commute** | rank $4$, singular values $1/\sqrt2$; images both $\mathbb R^4$, so equal | $\mathbf0$ |
| **rank $4$ / singular values $1/\sqrt2$** | $X=I/2$, $Y=J/2$ for anticommuting complex structures on $\mathbb R^8$ | anticommuting; images both $\mathbb R^8$, so equal | $\mathbf1$ |
| **equal images** | $X=I/\sqrt2$ on $\mathrm{span}(e_1..e_4)$, $Y=J/\sqrt2$ on $\mathrm{span}(e_5..e_8)$ in $\mathfrak{so}(8)$ | anticommuting (both products vanish); rank $4$, singular values $1/\sqrt2$ | $\mathbf0$ |

The first witness is the sharpest: it satisfies **rank $4$, equal singular values and equal images** and still brackets to zero. Anticommuting is doing real work and is not a decoration.

## 5. $n=4$ and $n=5$; the unstated range is harmless

- **$n=4$.** Holds, and is realised: $\Lambda^+\cong\mathfrak{su}(2)$, every unit element is $\tfrac1{\sqrt2}\times$ a complex structure ($u=(aI+bJ+cK)/\sqrt2$ with $a^2+b^2+c^2=1$ gives $u^2=-\tfrac12\mathrm{Id}$), and orthogonal imaginary quaternions anticommute. The clause $\mathrm{im}\,X=\mathrm{im}\,Y$ is automatic here, so the characterisation degenerates to "anticommuting, both $\tfrac1{\sqrt2}\times$ a complex structure", still correct, and still with content, by witness 1 above.
- **$n=5$.** Holds; the $n=4$ witness padded gives $\lVert[X,Y]\rVert^2=2.000000$ (*screen*).
- **$n\le3$.** Vacuously true. At $n=3$ the maximum is $s_1^2=1<2$ (*screen*: any orthonormal pair of $\mathfrak{so}(3)$ brackets to $1$), and rank $4$ is impossible; at $n=2$ no orthonormal pair exists. So **the block's silence on the range costs nothing**, and no consumer is exposed.

## 6. The ten citations, classified

| site | what it consumes |
| --- | --- |
| [stratum-two-negative.md:21](../findings/stratum-two-negative.md#L21), [:93](../findings/stratum-two-negative.md#L93) | the **cap** alone |
| [:33](../findings/stratum-two-negative.md#L33), [:108](../findings/stratum-two-negative.md#L108) | the **"if"**, every orthonormal pair in $\Lambda^+$ brackets to $2$, so the cap saturates identically. Correct: verified above |
| [:35](../findings/stratum-two-negative.md#L35) | the **"only if"**, image clause, and the passage is stale, **D1** below |
| [:82](../findings/stratum-two-negative.md#L82) | the **"only if"**, image clause, *the load-bearing citation*, the L29 converse closure |
| [:251](../findings/stratum-two-negative.md#L251) | the **"only if"**, rank clause, *"With the pair cap attained, both ranks are $4$"*; contradicted one line later, **D2** |
| [:265](../findings/stratum-two-negative.md#L265) | the **"only if"**, image clause, "at the bracket cap $W$ is a padded $\mathrm{Weyl}_4$ element" |
| stratum table, $k\ge3,\ \delta=0$ row | all three conditions at once |
| [results.md:148](../results.md#L148), [:424](../results.md#L424) | the statement, restated. **Both restatements are faithful** |
| [INDEX-results.md:44](../findings/INDEX-results.md#L44), [:86](../findings/INDEX-results.md#L86); [LEDGER.md:912](../findings/LEDGER.md#L912) | the closure attribution, i.e. the **"only if"** |
| [conventions.md:74](../findings/conventions.md#L74), [bounds.md:31](../findings/bounds.md#L31), [fence-posts.md:175](../findings/fence-posts.md#L175), [bounds-relaxations.md](../findings/bounds-relaxations.md) ×5 | the **cap** alone |
| [ELIM-stratum.md:95](ELIM-stratum.md#L95) | the **"only if"**, image clause, from saturated marginals |

**Every consumer of the equality case uses the "only if", and it holds.** The L29 closure at [:82](../findings/stratum-two-negative.md#L82), *"equality forces $T_{1,N-1,N}=2$, hence $\lVert[v_2,v_3]\rVert^2=2$, hence $\mathop{\mathrm{im}}v_2=\mathop{\mathrm{im}}v_3$ of dimension $4$"*, is **valid**: $T_{1,N-1,N}\le\sum_\gamma T_{N-1,N,\gamma}=\lVert[v_{N-1},v_N]\rVert^2\le2$ forces the marginal to saturate, the eigenvectors are orthonormal in the $\Lambda^2$ pairing which [conventions.md](../findings/conventions.md) fixes as the half-trace one, so L31 applies verbatim. **L31 carries the weight it was handed an hour ago.**

## The defects

**D1, [stratum-two-negative.md:35](../findings/stratum-two-negative.md#L35) still carries the withdrawn status, and it is self-defeating.** Verbatim:

> **The equality clause, reduced but open.** … The bracket-cap characterisation forces $\mathrm{im}\,v_2=\mathrm{im}\,v_3$ of dimension $4$, hence $r=4$, so the *iff* is **equivalent to**: no full-support rank-$3$ signature-$(1,2)$ element of $\mathrm{Weyl}_r$ exists for even $r\ge6$. Excluded numerically at $r=6,8,10$ … with **$r\ge12$ untested**.

The sentence proves $r=4$ and then declares open the question of whether $r\ge6$ can occur, which $r=4$ has just answered. Forty-seven lines below, [:82](../findings/stratum-two-negative.md#L82) says the clause is *"closed in three lines by [Lemma L31], at every $n$ and with no numerics"*. [LEDGER.md:914](../findings/LEDGER.md#L914) claims *"The same file was carrying three different statuses for one clause … All corrected to [L31]"*, **the correction missed this one**, and "reduced but open" is still the bold lead-in at line 35.

**D2, [stratum-two-negative.md:252](../findings/stratum-two-negative.md#L252) asserts a rank pair that L31 forbids, because the sentence withdrawing it was deleted.** Verbatim:

> At $n=8$ the ranks come out $4$ and $6$, so the descent continues there too.

L31, and [:261](../findings/stratum-two-negative.md#L261) ten lines below it, force **both** ranks to $4$ at the cap. The pre-refactor file carried the retraction, *"A less converged run had reported ranks $4$ and $6$ at $n=8$; that was a rank-tolerance artefact and is withdrawn"*, and it is **absent from the current file**; `git log -S` puts its removal in the `51ab61f8` / `c6e591b1` refactors. A withdrawn number is now standing again, against the very lemma printed on the same screen.

**D3, the provenance line is false, and it is the unrepaired copy of one already repaired next door.** Verbatim at [:395](../findings/stratum-two-negative.md#L395):

> *Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy.*

`git show a9e4b8c0^:findings/stratum-two-negative.md` (the version immediately before the move), already carried the **complete** argument at its lines 124–128: the root-system identity $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$, the Cauchy–Schwarz step to rank $4$, and **both** equality steps (image equality and anticommuting). That text is still in the file today at [:257–:263](../findings/stratum-two-negative.md#L257). **The L29 block twenty lines above carries the corrected wording for the identical claim**, *"The claim once made here, that results.md held the only copy, **is false**: this file already carried the complete argument before the move, which is why it appears twice below"* ([:70](../findings/stratum-two-negative.md#L70)), so the repair reached L29's note and stopped short of L31's. Suggested replacement, matching L29's: *"Moved here from results.md on 2026-08-31. The claim once made here, that results.md held the only copy, is false: this file already carried the complete argument, which is why it appears twice above."*

**D4, both in-file links to L31 point at a dead anchor that belongs to a different lemma.** [:82](../findings/stratum-two-negative.md#L82) and [:502](../findings/stratum-two-negative.md#L502) both write `[Lemma L31](../findings/fence-posts.md#post-f31-the-sharp-target-is-not-freely-described-and-n-cannot-be-smuggled-in-as-a-trace)`. The heading is `Lemma L31 (the bracket cap, characterised), canonical statement and proof`, so the live anchor is `#lemma-l31--the-bracket-cap-characterised--canonical-statement-and-proof`. No heading anywhere in the record ends "and what saturates it" **except [Lemma L70](../findings/bounds.md#L185)**, *"the deficiency identity, and what saturates it"*. Both dead links sit on the load-bearing closure sentences, the exact two places a reader chasing the L29 repair will click.

**D5, the canonical block's proof gives $Y$'s singular values by assertion.** Recorded in §2. The fix is one clause, and the file's own earlier copy already contains it.

**D6, [conventions.md:74](../findings/conventions.md#L74) files the pair cap as a "standing fact" with no pointer to its proof.** L31 is that proof. Every other consumer names a route; conventions.md, which is the file the others quote, names none.

## What I did not do

Nothing here required a computation to settle. The four screens listed above were hand-built $4\times4$ and $8\times8$ matrices, run once, and are reported as screens, they agree with the derivations and are not offered as evidence for any positive claim.

**VERDICT: CONFIRMED**
