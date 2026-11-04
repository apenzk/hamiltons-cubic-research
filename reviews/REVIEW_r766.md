# Review r766, whether the ordered-pair convention closes the hazard, and on what grounds

*Cold read of the brief and of the files it names; **no numerical work** beyond two screens of exact rational and symbolic arithmetic on objects I built for the purpose, reported as screens and never as evidence for a positive claim; every value below is exact. Log: [agent_logs/g2-ordered-r766.log](../agent_logs/g2-ordered-r766.log).*

| # | claim | verdict |
| --- | --- | --- |
| **1** | [conventions.md](../findings/conventions.md) tables the ordered reading, $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$, and carries the quoted sentence | **CONFIRMED, verbatim** |
| **2** | the quoted sentence's *"inconsistent"* argument refutes the unordered reading | **REFUTED AS WRITTEN**, it is circular; the conclusion survives on four other grounds the record supplies |
| **3** | [L94](../findings/bispectral.md)'s $t$ and [conventions.md](../findings/conventions.md)'s $t$ are the same object, so the citation transfers | **CONFIRMED**, and L94's constant $2$ *is* the ordered/unordered doubling |
| **4** | under the ordered reading $t=2$ exactly at coordinate-diagonal | **CONFIRMED**, exact at the balanced sphere product, $n=4,6,8,10,12$; the unordered reading gives $1$ |
| **5** | nothing on the record consumes $t$ under the unordered reading | **CONFIRMED**, four consumers checked, all four ordered, three of them by a derived identity |
| **6** | the hazard is *closed*, not open | **CONFIRMED**, closed for [L174](../findings/second-order.md) and for every consumer checked |
| **7** | *"what L174 owed was the citation rather than the argument"* | **CONFIRMED**, and it is faithful to [r762](REVIEW_r762.md), which itself wrote that conventions.md *"fences this explicitly"* |

**Actionable, one line.** L174 and the brief both cite the weakest clause conventions.md offers; swap the citation for the two sentences beside it, the definition $t=\lVert K\rVert_F^2$ and the operator form $t=2\lVert\mathop{\mathrm{diag}}W\rVert^2$, and name the three derived identities ([L94](../findings/bispectral.md)'s constant $2$, [L54](../findings/bispectral.md)'s $\sum d_\varphi^2=t/2$, [target.md](../findings/target.md)'s $\sum R=1-t/2$) that pin the reading against rescaling.

**Overall verdict: PROVEN, hypotheses corrected.** The hazard is closed and the claim's conclusion is right. One hypothesis is corrected: what closes it is the definition of $t$ as a matrix Frobenius norm together with three identities that fix the numeral, rather than the quoted sentence, which cannot do the work it is cited for.

## 0. Conventions, fixed once

Quoted, never restated, from [conventions.md](../findings/conventions.md).

- **The vertex matrix.** $K$ is the symmetric hollow $n\times n$ sectional matrix, $K_{ab}=W_{abab}$ for all $a\ne b$; $t=t_F=\lVert K(F)\rVert_F^2$ **per frame**; $\kappa^2=\max_Ft_F$.
- **The operator.** $M$ is $W$ acting on $\Lambda^2\mathbb R^n$ in the pair basis $\{\varphi_{ab}\}_{a<b}$, and *unit* means $\lVert M\rVert_F=1$, i.e. $\mathop{\mathrm{tr}}(M^2)=\sum_\alpha\mu_\alpha^2=1$. On the diagonal locus the $\Lambda^2$ spectrum is the multiset of **entries** of $K$ indexed by $a<b$.
- **The pairing.** $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal and $\langle M\varphi_{ab},\varphi_{ab}\rangle=W_{abab}=K_{ab}$.
- **Ordered by default.** *"this file's own default that sums run over ordered tuples unless a line says otherwise."*

Two readings are in play throughout, and I write them apart: $t^{\mathrm{ord}}:=\sum_{a\ne b}K_{ab}^2$ and $t^{\mathrm{unord}}:=\sum_{a<b}K_{ab}^2=\tfrac12t^{\mathrm{ord}}$.

## Hypothesis inventory

| id | hypothesis | where it enters | status |
| --- | --- | --- | --- |
| H1 | $t$ denotes $t^{\mathrm{ord}}$ | everywhere $t$, $t_F$, $\kappa^2$ appear | **discharged**, §§1, 3, 4, 5 |
| H2 | the record holds the numeral $2$ in $t\le2$ fixed independently of the naming choice | the quoted argument's premise | **discharged, but not by the quoted sentence**, §2 |
| H3 | $\lVert M\rVert_F=1$ is the sense of *unit* under which $2\lVert M\rVert_F^2=2$ | L94 → L174 | **discharged**, tabled, and cited by L174's own fold |
| H4 | the balanced sphere product is coordinate-diagonal and unit-norm | §4's equality check | **discharged**, [diagonal-half.md](../findings/diagonal-half.md)'s diagonal locus, row sums $0$ exactly (§4) |
| H5 | no consumer reads $t$ as $t^{\mathrm{unord}}$ | §5 | **discharged over the four consumers checked**; §5 names what was searched |

## 1. What conventions.md actually says

It tables the ordered reading, in those words, under a heading of its own, *"The vertex matrix"*, [conventions.md](../findings/conventions.md) line 136:

> **$K$ is the symmetric hollow $n\times n$ **sectional matrix**, $K_{ab}=W_{abab}$ for all $a\ne b$, and $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$, the sum over **ordered** pairs. Then $t\le2$ with **$t=2$ iff $W$ is coordinate-diagonal in some frame**, and $t$ is the coordinate the bi-spectral relaxation is swept in.

The quoted sentence is the next line, 138, and it is quoted **verbatim** by the claim and by [L174](../findings/second-order.md) line 1600, modulo sentence-initial capitalisation and emphasis markup:

> **THE ORDERED SUM IS THE WHOLE OF THE NORMALISATION AND WAS AMBIGUOUS HERE.** Writing $K$ as $(W_{abab})_{a<b}$ reads as an index set over *unordered* pairs, whose square sum is $\tfrac t2\le1$, so the bound $t\le2$ and that reading are inconsistent. *Checked: at a unit-norm coordinate-diagonal $W$ the unordered sum is $1$ and the ordered sum is $2$, and the record's $t=2$ is the ordered one.* In operator terms $t=2\lVert\mathop{\mathrm{diag}}W\rVert^2$ with the diagonal taken in the pair basis, so $t\le2$ is Cauchy–Schwarz against $\lVert W\rVert=1$, with equality exactly when $W$ is diagonal.

A second row tables the same object at line 23 ($t=t_F=\lVert K(F)\rVert_F^2$ per frame, $\kappa^2=\max_Ft_F$, with L94's bound attached) so the reading is tabled twice, once in the table and once in the section. **Claim 1 is confirmed with nothing subtracted.**

## 2. The quoted argument is circular, and the conclusion holds on four other grounds

**Located.** [conventions.md](../findings/conventions.md) line 138, the clause *"so the bound $t\le2$ and that reading are inconsistent"*, and its two citations, [L174](../findings/second-order.md) line 1600 and the claim under review.

**Exhibited.** The clause has the form: *the record writes $t\le2$; the unordered reading makes the same quantity $\le1$; therefore the unordered reading is inconsistent.* The numeral $2$ in *"$t\le2$"* is not an independent fact, it is what the ordered reading of $t$ **produces**. The block's own next-but-one sentence says so: $t\le2$ is Cauchy–Schwarz against $\lVert W\rVert=1$ *given* $t=2\lVert\mathop{\mathrm{diag}}W\rVert^2$, and the leading $2$ there is the ordered doubling. So the argument holds the conclusion fixed as its premise. Adopt $t:=t^{\mathrm{unord}}$ throughout and the record reads $t\le1$, $t=1$ at coordinate-diagonal, $\sum d_\varphi^2=t$, $\kappa^2\le\lVert M\rVert_F^2$, every statement rescaled, none of them false. **That is a change of units, not a contradiction**, which is exactly the test the brief sets: a convention cannot be refuted by being different.

**Argued the opposite, the strongest reading the words support.** Read as a warning against *mixing*, take one file's $t^{\mathrm{ord}}\le2$ into another file's $t^{\mathrm{unord}}$ and you get a statement false by a factor of two, the sentence is correct and useful, and its capitalised headline (*"THE ORDERED SUM IS THE WHOLE OF THE NORMALISATION AND WAS AMBIGUOUS HERE"*) is a mixing warning. So the defect is confined to the word *"inconsistent"* doing duty as a refutation on a line that is quoted in isolation. **The finding is that the clause proves the mixing hazard, not the convention.**

**What does settle it**, and none of it needs the quoted clause:

1. **The definition itself.** $t:=\lVert K\rVert_F^2$ with $K$ an $n\times n$ matrix. The Frobenius norm of a matrix is $\sum_{i,j}K_{ij}^2$; $K$ is hollow, so this is $\sum_{a\ne b}K_{ab}^2$ and nothing else. $t^{\mathrm{unord}}$ is not the Frobenius norm of any matrix on the record. The unordered reading contradicts a **definition**, which is the fixed thing the brief asks for.
2. **[L94](../findings/bispectral.md)'s constant $2$ is the doubling, and it comes with an equality case.** In the pair basis, $M_{(ab),(ab)}=K_{ab}$, so
   $$\lVert K\rVert_F^2=2\sum_{a<b}M_{\alpha\alpha}^2\le2\sum_{\alpha,\beta}M_{\alpha\beta}^2=2\lVert M\rVert_F^2,$$
   frame by frame and hence at $\max_F$, with equality iff $M$ is diagonal in that basis, i.e. $W$ coordinate-diagonal. **The leading $2$ is the ordered/unordered factor.** Under $t:=t^{\mathrm{unord}}$ the lemma would read $\kappa^2\le\lVert M\rVert_F^2$, so the record's stated constant is not a naming choice, it is a derived number carrying a proved equality case, and restating it is restating L94.
3. **[L54](../findings/bispectral.md)'s identity $\sum d_\varphi^2=t/2$** ([bispectral.md](../findings/bispectral.md) lines 308, 480; tabled at [conventions.md](../findings/conventions.md) line 22). $d_\varphi$ is the vector of entries $K_{ab}$ over $a<b$, so $\sum d_\varphi^2=t^{\mathrm{unord}}$ **by construction**. The recorded identity says that equals $t/2$; therefore $t=t^{\mathrm{ord}}$. Under the unordered reading the identity would have to read $\sum d_\varphi^2=t$, and the block's consequence *"at $t=2$, $\sum d_\varphi^2=1=\sum\mu^2$"* (the majorization tightness that Lemma L54's rigidity turns on), would fail.
4. **[target.md](../findings/target.md) line 17's identity $\sum R=1-t/2$**, recorded *exact at any critical point*, residual $\le1.1\times10^{-16}$ at six points, with $R=0$ at a diagonal point. That forces $t=2$ at a diagonal point. Under the unordered reading $t=1$ there and the identity returns $\tfrac12\ne0$.

**Verdict on claim 2: REFUTED AS WRITTEN, conclusion CONFIRMED.** The convention is right; the sentence cited for it cannot carry the weight, and three of the four grounds above are derived identities rather than conventions, so they are not rescalable away.

## 3. L94's $t$ is conventions.md's $t$

[bispectral.md](../findings/bispectral.md) line 219 defines the object directly:

> $\kappa(W):=\max_F\lVert K(F)\rVert_F$ over orthonormal frames is $O(n)$-invariant, satisfies $\kappa^2\le2\lVert M\rVert_F^2$, *the norm must be $\lVert M\rVert_F$, not the $4$-tensor norm, or the bound is slack by a factor $4$*, with equality **iff $W$ is coordinate-diagonal in some frame**

L94 never writes $\sum_{a<b}$ or $\sum_{a\ne b}$ at all: it writes $\lVert K(F)\rVert_F$, the Frobenius norm of the sectional matrix, which is the ordered sum by the definition of the norm. **The two files name the same object by the same notation, so the citation transfers.** Two further confirmations internal to L94:

- The constant $2$ is the doubling, §2 item 2, if L94 had been derived under the unordered reading the lemma would state $\kappa^2\le\lVert M\rVert_F^2$.
- [L95](../findings/bispectral.md) gives $\kappa^2(\mathbb{CP}^m)=3/(m+1)$, which is $1$ at $m=2$; [L174](../findings/second-order.md) and [r102](REVIEW_r102.md) record $\kappa^2=1$ at padded $W_{\mathbb{CP}^2}$, and [diagonal-half.md](../findings/diagonal-half.md) line 288 records $t=1$ there. All three agree, under one reading.

**Claim 3 confirmed.**

## 4. The equality case at a concrete coordinate-diagonal unit $W$

The record's balanced sphere product, on [diagonal-half.md](../findings/diagonal-half.md)'s diagonal locus. Take $n=2m$ and $K_{ab}=\alpha$ within a factor, $\beta$ across. Ricci-flatness is zero row sums, $(m-1)\alpha+m\beta=0$, so $\beta=-\tfrac{m-1}{m}\alpha$, matching the recorded weights $1/(p(p-1))$ within and $-1/(pq)$ across, whose ratio is the same $m/(m-1)$. Unit norm is the file's own constraint $\sum_{a<b}w_{ab}^2=1$:

$$m(m-1)\alpha^2+(m-1)^2\alpha^2=(m-1)(2m-1)\alpha^2=1,\qquad \alpha=\frac1{\sqrt{(m-1)(2m-1)}} .$$

Then, identically in $m$,

$$t^{\mathrm{ord}}=\sum_{a\ne b}K_{ab}^2=2,\qquad t^{\mathrm{unord}}=\sum_{a<b}K_{ab}^2=1 .$$

**Screen** (exact symbolic, on the matrix I built above; reported as a screen). At $n=4,6,8,10,12$: row sums $0$ exactly; $t^{\mathrm{ord}}=2$ and $t^{\mathrm{unord}}=1$ exactly at every one; and the record's diagonal-locus cubic $\theta=\sum_{a<b}w_{ab}^3+3\sum_{a<b<c}w_{ab}w_{bc}w_{ca}$ returns $\tfrac{\sqrt3}2,\ \tfrac{\sqrt{10}}3,\ \tfrac{\sqrt{21}}4,\ \tfrac65,\ \tfrac{\sqrt{55}}6$, equal to $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ with zero symbolic residual at each, which is what identifies the object as the record's balanced sphere product rather than some other diagonal weight.

**So the ordered reading gives $t=2$ at coordinate-diagonal, and the unordered reading gives $1$**, exactly as conventions.md's *"Checked:"* sentence asserts. The general statement is one line: at a diagonal $W$ the $\Lambda^2$ spectrum is the entries $\{K_{ab}\}_{a<b}$, so $\lVert M\rVert_F^2=t^{\mathrm{unord}}$, and unit norm is $t^{\mathrm{unord}}=1$, i.e. $t^{\mathrm{ord}}=2$. **Claim 4 confirmed.**

## 5. What else consumes $t$, and under which reading

Searched: every occurrence of $t\le2$, $t=2$, $t_F$, $\lVert K\rVert_F^2$, $\mathop{\mathrm{tr}}M^2$, $\kappa^2$, $t/2$ and $t\le1$ across [findings/](../findings/), [results.md](../results.md), [README.md](../README.md) and [lean/](../lean/). **Every consumer found reads $t$ as the ordered sum. No site reads it as the unordered one.** The four that pin it rather than merely being compatible with it:

| consumer | what it says | why it pins the ordered reading |
| --- | --- | --- |
| [L94](../findings/bispectral.md) l. 219 | $\kappa^2\le2\lVert M\rVert_F^2$, equality at coordinate-diagonal | the constant $2$ is the doubling; the unordered lemma would have constant $1$ |
| [L54](../findings/bispectral.md) ll. 308, 480 | $\sum d_\varphi^2=t/2$, $\sum d^2=\tfrac32t$; at $t=2$, $\sum d_\varphi^2=1=\sum\mu^2$ | $\sum d_\varphi^2$ **is** $t^{\mathrm{unord}}$ by construction, so $t=2\sum d_\varphi^2$ |
| [target.md](../findings/target.md) l. 17 | $\sum R=1-t/2$, exact at any critical point, $R=0$ at a diagonal point | forces $t=2$ at coordinate-diagonal |
| [diagonal-half.md](../findings/diagonal-half.md) ll. 15–27 | unit norm is $\sum_{a<b}w_{ab}^2=1$ **and** $\mathop{\mathrm{tr}}M^2=2$, four lines apart | the file displays both normalisations side by side and uses each in its own role |

Two more that are consistent without pinning: [L55](../results.md)'s min-entry bound $\lvert\min_{a\ne b}K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$, and the relaxation display $\theta\le(t_F/2)^{3/2}\Theta_n+\tfrac92C(1-t_F/2)$ at [bispectral.md](../findings/bispectral.md) line 90, whose argument $t_F/2$ ranges over $[0,1]$ only under the ordered reading.

**Screen on L55, since its constant is the sharpest test available.** Its recorded extremiser is a perfect matching, $K_{ab}=(n-2)c$ on the matching and $-c$ off it. Row sums vanish: $(n-2)c-(n-2)c=0$. Exact symbolic evaluation at $n=4,6,8,10,12$ gives $t^{\mathrm{ord}}=n(n-1)(n-2)c^2$ ($24c^2,120c^2,336c^2,720c^2,1320c^2$) so $\sqrt{t^{\mathrm{ord}}/(n(n-1)(n-2))}=c=\lvert\min_{a\ne b}K_{ab}\rvert$, matching the recorded formula with zero residual at all five. **Under the unordered reading the recorded constant would be wrong by $\sqrt2$.** So L55 is a fifth pin, and it lives in [results.md](../results.md) rather than in a file that cites the convention.

**The Lean layer is opaque to the question and neither confirms nor threatens it.** [L94.lean](../lean/HamiltonsCubic/Results/L94.lean) and [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) carry the numeral $2$ inside a hypothesis (`L94 : ∀ W, IsUnit W → (kappaSq W = 2 ↔ ∃ F, IsCoordDiagonal W F)`) with `kappaSq` an opaque `Weyl → ℝ`, so no kernel content depends on the reading, as [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s own docstring states. **I built it rather than reading it**: `lake build` completes successfully, $8995$ jobs, exit $0$, warnings only (style lints on unrelated files L42, L73, L73b).

**One adjacent slip, on a different axis, recorded because it is in the same sentence as a $t$ value.** [diagonal-half.md](../findings/diagonal-half.md) line 288 writes *"$t(\mathbb{CP}^m)=3/(m+1)$"*, which is [L95](../findings/bispectral.md)'s $\kappa^2$ (the **extremal** value), under a letter [conventions.md](../findings/conventions.md) reserves for the per-frame $t_F$. It is the per-frame/extremal hazard tabled at [conventions.md](../findings/conventions.md) line 140, not the ordered/unordered one, and it is harmless where it stands: the passage refutes a condition by showing $t<\lambda^2$, and using $\max_Ft_F$ makes that refutation stronger rather than weaker. **Flagged, not charged against this claim.**

## 6. Whether "closed" is the right status

**Yes, and for L174 doubly so.** Three things have to hold for *closed* rather than *open*:

- **The reading is written down.** It is, twice, in the file whose stated purpose is to hold it, §1.
- **The importer names it.** [L174](../findings/second-order.md)'s fold now does, in a block of its own, and cites [conventions.md](../findings/conventions.md). This is precisely what [r762](REVIEW_r762.md) asked for: its §9 entry reads *"[conventions.md] fences this explicitly and L174 does not restate it. **This is the single most dangerous inherited hypothesis and it is unstated in L174.**"*, so what r762 ranked first was an **unstated hypothesis in L174**, never a doubt about the record's reading. The claim's *"what L174 owed was the citation, not the argument"* is a faithful reading of r762, and claim 7 is confirmed with it.
- **No consumer reads it the other way.** None found, §5.

**The one qualification.** *Closed* is earned by §2's four grounds, not by the sentence the claim quotes. A reader who is handed only that sentence is handed a circular argument, and if they see through it they will conclude the hazard is open when it is not. **So the status is right and the warrant offered for it is the weakest one available**, which matters here, because the sentence is the whole of what L174 and the claim transmit.

## 7. What would reopen it

In descending order of how cheaply it could happen.

1. **A new consumer that writes $\sum_{a<b}K_{ab}^2$ and calls it $t$.** The record's five pins are all identities that would then be off by a factor of $2$, and, being identities rather than bounds, a mixed reading makes them **false** rather than slack, which is the loud failure mode. Nothing structural prevents this; §5's sweep is a snapshot.
2. **Restating L94's constant.** Any rewrite of $\kappa^2\le2\lVert M\rVert_F^2$ that absorbs the $2$ (into the norm, into $\kappa$, or into a redefinition of $K$), removes the strongest non-conventional pin, since §2 item 2 is what makes the numeral derived rather than chosen.
3. **A change to the $\Lambda^2$ pairing.** [conventions.md](../findings/conventions.md) line 88 records that $\lVert\varphi_{ab}\rVert^2$ is $1$ here and $2$ under plain Frobenius. Switching moves $\lVert M\rVert_F^2$ by a factor $2$ and with it every $t$ value in §5, so the ordered/unordered question would have to be re-asked against the new unit.
4. **A frame set larger than $O(n)$.** $\kappa^2=\max_Ft_F$ needs attainment; §4's equality case is stated at a frame, so a relaxation that loses compactness detaches $\kappa^2=2$ from *"diagonal in some frame"* and the ordered value stops meaning what it means.
5. **The registry.** There is **no `W`-row for this in [INDEX-traps.md](../findings/INDEX-traps.md)**, so a reader who never opens [conventions.md](../findings/conventions.md) meets nothing. That is a gap in signposting rather than in mathematics, and it is how the hazard came to be re-raised as new by [r762](REVIEW_r762.md) after conventions.md had already fenced it.

## Overall verdict

**PROVEN, hypotheses corrected.**

The hazard is real, named and closed, the citation transfers, the equality case checks exactly, and no consumer reads $t$ the other way. The correction is to the warrant: what closes it is the definition $t=\lVert K\rVert_F^2$ and four derived facts that fix the numeral, [L94](../findings/bispectral.md)'s constant, [L54](../findings/bispectral.md)'s $\sum d_\varphi^2=t/2$, [target.md](../findings/target.md)'s $\sum R=1-t/2$ and [L55](../results.md)'s sharp constant, rather than the quoted clause, which holds its own conclusion as its premise and would leave a careful reader thinking the question is open.
