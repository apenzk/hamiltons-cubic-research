# Review r657, Observation L53, the champion split

**Reviewer A of a two-reviewer pair on identical briefs. Target: [findings/bispectral.md:442](../findings/bispectral.md#L442), the block headed `#### Observation L53, the champion split`, together with the section its provenance note names, [bispectral.md:405](../findings/bispectral.md#L405).**

## Verdict: GAP

**Nothing in the block is shown false, and the numbered block's own sentences stay inside the Observation label, but the table cannot be read as written.** Row 3's landing point at $n=6$ is named by a $\theta$-value that two distinct objects on this record share exactly, and the record has already been bitten by that same collision once. Row 3's $n=10$ entry is missing from a table whose header promises it, and the run that produced it did cover $n=10$. Three of the six directions the ascent swept are unreported. And the canonical restatement at [results.md:722](../results.md#L722) performs the ascent-to-optimum inversion the block itself avoids, in the clause immediately after the one that forbids it.

**Six of the block's numbers, and both entries of the $n=12$ table it depends on, are closed forms.** They are given below, including one the record does not appear to hold: $p_3(\mu)$ at $\mathbb{CP}^m$.

## Standing rule

Analysis only. **No run was made.** Every number below is a closed-form evaluation, and the one arithmetic pass I ran was a screen of decimals I was about to write down, reported as a screen, and load-bearing for nothing. Where an item needs a run I say so and stop.

## 0. The readings I adopt, and what the record does not define

| symbol | reading adopted | authority |
| --- | --- | --- |
| $\mathcal W_n$ | algebraic Weyl operators on $\mathbb R^n$; the ascent runs on its **unit sphere** | [conventions.md](../findings/conventions.md) |
| $\mu$ | $\mathop{\mathrm{spec}}(M)$ on $\Lambda^2$ at $\lVert M\rVert_F=1$, so $\sum\mu=0$, $\sum\mu^2=1$ | [conventions.md](../findings/conventions.md) |
| $\omega$ | $\mathop{\mathrm{spec}}(\mathring W)$ on $S^2_0$, Li's $iklj$ order, $\sum\omega=0$, $\sum\omega^2=3$ | [conventions.md](../findings/conventions.md) |
| $p_3$ | the **power sum** $\sum x_i^3$ | **derived, see below** |
| pairing | half-trace at the $\Lambda^2$ level, $\{\varphi_{ab}\}_{a<b}$ orthonormal | [conventions.md](../findings/conventions.md) |
| $\theta_0(n)$ | the closed form $\sqrt{2(n-1)(n-2)}/n$ alone | [conventions.md](../findings/conventions.md) |

**$\mu$ is the disambiguation the brief warns about, and L53 takes the safe one.** [conventions.md](../findings/conventions.md) records that $\mu$ carries the $\Lambda^2$ spectrum and, thirty lines later in this same file, the scalar $-\min\omega$. Inside $p_3(\mu)$ only the vector reading is grammatical, so L53 is unexposed. $\omega$ I found carrying **one** sense across [bispectral.md](../findings/bispectral.md), I did not reproduce the companion audit's second sense for it, and record the disagreement rather than resolve it.

**$p_3$ has no row in [conventions.md](../findings/conventions.md)**, the file whose stated job is that every definition the record uses lives there. It is recoverable and I recovered it rather than assumed it: [bispectral.md:140](../findings/bispectral.md#L140) proves $\alpha=8\mathop{\mathrm{tr}}(M^3)$ and $\theta=\mathop{\mathrm{tr}}(M^3)+\langle M^\#,M\rangle$, and states $p_3(\omega)=p_3(\mu)-2\langle M^\#,M\rangle$; substituting gives the identity $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ only if $p_3(x)=\sum x_i^3$. The elementary-symmetric reading $e_3$ fails the identity. **Add the row.**

**$\Theta_n$ never appears in the block, so the parity trap does not bite, and it is worth saying why rather than assuming it.** $n=6,8,10,12$ are all even, so $\Theta_n=\theta_0(n)$ there and the balanced product attains the closed form; the block uses $\theta_0(n)$ only as *the value at a named point*, which is what the repaired convention licenses at even $n$. I checked the two closed forms agree at the balanced split: $\theta_{k,l}^2=2\frac{n-1}{n-2}\bigl(1-\frac{n-1}{kl}\bigr)$ at $k=l=n/2$ gives $kl=n^2/4$ and

$$2\frac{n-1}{n-2}\cdot\frac{n^2-4n+4}{n^2}=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2 .$$

## 1. The closed forms, six table entries and both $n=12$ entries are checks, not measurements

### 1a. Already on the record

| printed | closed form | where |
| --- | --- | --- |
| $\theta_0(6)=1.054093$ | $\sqrt{10}/3$ | [conventions.md](../findings/conventions.md) |
| $1.145644$, $1.200000$ | $\sqrt{21}/4$, $6/5$ | same |
| $\theta_0(12)=1.236033$ | $\sqrt{55}/6$ | same |
| $\sqrt{3/2}=1.224745$ | exact as printed | [INDEX-values.md:19](../findings/INDEX-values.md#L19) |
| $0.986013$ | $\sqrt{35}/6$ | $\theta^2(\mathbb{CP}^4)=\frac{(m+1)(2m-1)}{3m(m-1)}=\frac{35}{36}$ |

### 1b. The balanced product's coordinates, derived from [L67](../findings/bispectral.md#L466)

[bispectral.md:417](../findings/bispectral.md#L417) asserts $p_3(\mu)=2\sqrt2/\bigl(n\sqrt{(n-1)(n-2)}\bigr)$ and $p_3(\omega)=3p_3(\mu)-2\theta_0(n)$ at the balanced product. **Both are derivable from [L67](../findings/bispectral.md#L466) plus the bi-spectral identity, and I derived them cold.** With $n=2m$,

$$p_3(\mu)=\frac{2\sqrt2}{2m\sqrt{2(2m-1)(m-1)}}=\frac1{m\sqrt{(m-1)(2m-1)}}=A ,$$

so **the $\Lambda^2$ cubic of the balanced product is exactly [L67](../findings/bispectral.md#L466)'s constant $A$**, the record states the two quantities separately and never says they are the same number. From L67's spectrum $\bigl(mA^{\times(m-1)(m+2)},\,-(m-1)A^{\times m^2},\,-2m(m-1)A\bigr)$,

$$p_3(\omega)=A^3m^2(m-1)\bigl[m(m+2)-(m-1)^2-8m(m-1)^2\bigr]=\frac{-8m^3+16m^2-4m-1}{m(2m-1)^{3/2}(m-1)^{1/2}},$$

while $3A-2\theta_0(2m)=\dfrac{3-2(2m-1)(m-1)}{m\sqrt{(2m-1)(m-1)}}=\dfrac{-4m^2+6m+1}{m\sqrt{(2m-1)(m-1)}}$; multiplying the second by $(2m-1)/(2m-1)$ gives numerator $(-4m^2+6m+1)(2m-1)=-8m^3+16m^2-4m-1$. **Identical in $m$.** As a by-product $\sum\omega^2=3(m-1)(2m-1)/((2m-1)(m-1))=3$ identically, which re-derives L67's normalisation.

**So the $n=12$ table at [bispectral.md:429](../findings/bispectral.md#L429) is a closed form, both columns:**

$$p_3(\mu)=\frac1{6\sqrt{55}}=0.0224733,\qquad p_3(\omega)=\frac{-107}{6\sqrt{55}}=-2.4046459 .$$

Both reproduce the printed six digits. The falsifier test at $n=12$ therefore rests on no measurement at all except the ascent's failure to exceed them.

### 1c. New, $p_3(\mu)$ at $\mathbb{CP}^m$, which the record does not appear to hold

The Fubini–Study curvature operator on $\Lambda^2\mathbb R^{2m}$ (holomorphic sectional curvature $4$) has eigenvalues $2m+2$ on $\mathbb R\omega$, $2$ on $\Lambda^{1,1}_0$ (multiplicity $m^2-1$) and $0$ on the $J$-anti-invariant part (multiplicity $m(m-1)$). *Three checks: the multiplicities sum to $\binom{2m}2$; the trace is $2m(m+1)=\mathrm{scal}/2$; a holomorphic plane returns $4$ and a totally real plane $1$.* $\mathbb{CP}^m$ is Einstein, so $M=\mathcal R-\frac{\mathrm{scal}}{n(n-1)}\mathrm{Id}$ with $\frac{\mathrm{scal}}{n(n-1)}=\frac{2(m+1)}{2m-1}$, giving the unit-norm Weyl $\Lambda^2$ spectrum

$$\mu(\mathbb{CP}^m)=\frac{\bigl(4(m^2-1),\ (2m-4)^{\times(m^2-1)},\ (-2(m+1))^{\times m(m-1)}\bigr)}{\sqrt{12m(m^2-1)(2m-1)}},\qquad\text{and}\qquad \boxed{\,p_3(\mu)\bigl(\mathbb{CP}^m\bigr)=\frac{8m^3-24m+11}{3\sqrt3\,(2m-1)^{3/2}\sqrt{m(m^2-1)}}\,}$$

**Four independent confirmations, none of them circular.**

1. At $m=2$ the spectrum is $(2,-1,-1,0,0,0)/\sqrt6$ and $p_3=1/\sqrt6$, character for character the record's own exact rational build at [INDEX-values.md:19](../findings/INDEX-values.md#L19) ($\Lambda^2$ spectrum $(2,-1,-1,0^7)/\sqrt6$, $\mathop{\mathrm{tr}}(W_0^3)=1/\sqrt6$).
2. Trace-freeness holds identically in $m$.
3. [bispectral.md:33](../findings/bispectral.md#L33) records, from a wholly separate line of work, that $\theta$ is *"$87\%$ $\Lambda^2$ term at $\mathbb{CP}^4$ ... and exactly half-and-half at $\mathbb{CP}^2$"*. My formula gives $\tfrac32p_3(\mu)/\theta=0.87144$ at $m=4$ and $0.50000$ at $m=2$.
4. The same line's *"$97\%$ second-kind term at $S^6\times S^6$"*: $\tfrac32A(6)/\theta_0(12)=0.0273$, so $97.3\%$.

| $m$ | $n$ | $p_3(\mu)(\mathbb{CP}^m)$ | $\theta(\mathbb{CP}^m)$ |
| --- | --- | --- | --- |
| $2$ | $4$ | $1/\sqrt6=0.408248$ | $\sqrt{3/2}=1.224745$ |
| $3$ | $6$ | $0.544614$ | $\sqrt{10}/3=1.054093$ |
| $4$ | $8$ | $0.572827$ | $\sqrt{35}/6=0.986013$ |
| $5$ | $10$ | $0.579751$ | $\sqrt{0.9}=0.948683$ |

## 2. The finding, row 3 does not identify its landing point, and the record has made this exact mistake before

**Row 3 reads *"$\theta_0(6)$ at $n=6$; $\mathbb{CP}^4$'s $0.986013$ at $n=8$"* in a column headed "where the ascent lands". Both entries are $\theta$-values, and at both dimensions the value is shared by two distinct named objects on this record.**

- **At $n=6$: $\theta(\mathbb{CP}^3)=\sqrt{10}/3=\theta_0(6)$ exactly.** $\theta^2(\mathbb{CP}^3)=\frac{4\cdot5}{3\cdot3\cdot2}=\frac{10}9=\theta_0(6)^2$. So "$\theta_0(6)$" names either $S^3\times S^3$ or $\mathbb{CP}^3$.
- **At $n=8$: $\theta(S^2\times S^6)=\sqrt{35}/6=\theta(\mathbb{CP}^4)$ exactly.** $\theta_{2,6}^2=2\cdot\frac76\bigl(1-\frac7{12}\bigr)=\frac{35}{36}$, and [nondegeneracy.md:650](../findings/nondegeneracy.md#L650) independently records $S^2\times S^6$ at $\theta=0.986013$. So "$0.986013$" names either.

**The record already knows this collision and has already been caught by it.** [INDEX-results.md:24](../findings/INDEX-results.md#L24), the Gate 2 verdict on result 9, reads: *"the $\mathbb{CP}^3$ paragraph described $S^3\times S^3$, **the two sharing $\theta=\sqrt{10}/3$ exactly**."* The identical ambiguity is live and unflagged in L53's row 3.

**The mathematics forces the answer at $n=6$, and it is $\mathbb{CP}^3$, or the row is a stall.** The $(1,0)$ direction maximises $p_3(\mu)$. At $n=6$ the two candidates carry

$$p_3(\mu)\bigl(S^3\times S^3\bigr)=A(3)=\tfrac1{3\sqrt{10}}=0.105409,\qquad p_3(\mu)\bigl(\mathbb{CP}^3\bigr)=0.544614,$$

and padded $W_{\mathbb{CP}^2}$, feasible in $\mathcal W_6$, already gives $1/\sqrt6=0.408248$. **An ascent maximising $p_3(\mu)$ that returned the balanced product would have stalled at less than a quarter of a point the record holds in closed form.** So either the landing is $\mathbb{CP}^3$ and the row is informative, or it is $S^3\times S^3$ and the row records a stall, the precise inversion the brief warns of, in its other direction. **The block does not say which, and no reader can tell.**

**One reading is excluded outright.** "$\theta_0(6)$" cannot be a $p_3(\mu)$ value: with $N=\binom62=15$, $\sum\mu=0$ and $\sum\mu^2=1$, Okumura gives $p_3(\mu)\le\frac{N-2}{\sqrt{N(N-1)}}=\frac{13}{\sqrt{210}}=0.897$, below $1.054093$. So the entry is a $\theta$-value reported in a row whose objective is not $\theta$.

**The discriminating number was computed and then dropped.** [run_bispectral_region.py:88](../scripts/runs/run_bispectral_region.py#L88) prints `p3(mu)` and `p3(om)` per direction alongside `3/2x-1/2y`; the table kept only the last. **Naming the point needs no new run, it needs the column the script already printed.** That is the whole fix for the most valuable defect here.

**And the script identifies no landing point anywhere.** Its only reference object is `sphere_product(n//2, n//2, n)`, printed separately; there is no code computing $W_{\mathbb{CP}^2}$, $\mathbb{CP}^4$ or a distance to any of them. **Every identification in the table's third column was made by eye from a $\theta$-value**, at two dimensions where the $\theta$-value is degenerate between two named objects. The row-1 and row-2 identifications are safe on their own arithmetic ($\theta_0(n)$ at row 1 is the balanced product's value at even $n$; $\sqrt{3/2}$ at row 2 is $W_{\mathbb{CP}^2}$'s, and no other catalogued object is recorded at it); row 3 is not.

## 3. Clause by clause

| clause | status |
| --- | --- |
| *"Ascent in a direction $(a,b)$, maximizing $a\,p_3(\mu)+b\,p_3(\omega)$"* | **derivable/definitional**, matches [run_bispectral_region.py:52](../scripts/runs/run_bispectral_region.py#L52) |
| *"over $\Weyl_n$"* | **defective**, the unit-norm constraint is dropped; the objective is homogeneous of degree $3$ and unbounded without it. [results.md:722](../results.md#L722) says "over the unit sphere of $\mathcal W_n$" correctly |
| *"from six starts each"* | **true of the run**, `starts=6` at [:52](../scripts/runs/run_bispectral_region.py#L52) |
| *"where the ascent lands"* (column head) | **exactly right, and the block's best sentence**, it claims a landing, not a maximum |
| row 1, balanced product at $n=6,8,10$ and $n=12$ | **observed, and its $\theta$ and both coordinates are closed forms** (§1b) |
| row 2, $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$ | **observed**; as a statement it is the lower bound $M(n)\ge\sqrt{3/2}$, which [conventions.md](../findings/conventions.md) already holds unconditionally from padding, so the row is a positive control, correctly labelled as one at [:423](../findings/bispectral.md#L423) |
| row 3, $n=6$ and $n=8$ | **not decidable as written** (§2) |
| row 3, $n=10$ | **absent from a table whose header promises it**, and `REGION_NS` defaults to `"6,8,10"` at [:80](../scripts/runs/run_bispectral_region.py#L80), so $n=10$ was run and the entry was dropped in reporting, not left unrun |
| the heading *"the champion split"* | **superlative, unearned by the instrument**, see §4 |

**The numbered block itself commits no ascent-to-optimum inversion.** That is worth stating plainly, because its neighbours do.

## 4. "Champion", what it claims, and where it breaks

**Three sentences slide from "the ascent landed" to "is the maximiser", all of them outside the numbered block.**

- **[bispectral.md:417](../findings/bispectral.md#L417): *"At $n=6,8,10$ the maximiser of the second-kind cubic alone is the balanced sphere product."*** This is the argmax asserted from a landing. Six starts of a backtracking projected gradient with no convergence certificate ([:52](../scripts/runs/run_bispectral_region.py#L52)–[:70](../scripts/runs/run_bispectral_region.py#L70)) support *"ascent reached the balanced product"* and $\max(-p_3(\omega))\ge2.4046$ at $n=12$. **To earn it** one needs an upper bound on $-p_3(\omega)$ over $\mathcal W_n$ meeting the closed form of §1b; the record's own accounting at [bispectral.md:152](../findings/bispectral.md#L152) puts the best marginal cap at $5.094$ against the attained $2.405$, a factor $2.1$ short. The sentence sits **twelve lines below** the heading at [:405](../findings/bispectral.md#L405) that forbids it, *"so these are lower bounds on each direction's maximum, and the identifications are evidence rather than proof"*.

- **[results.md:722](../results.md#L722), the canonical statement: *"These are lower bounds on each direction's maximum, at the dimensions stated, and they say that the balanced product is the champion of one spectrum's cubic and $W_{\mathbb{CP}^2}$ of the combination."*** **The second clause contradicts the first inside one sentence.** Lower bounds cannot say who the champion is. And *"$W_{\mathbb{CP}^2}$ [is champion] of the combination"* at $n=6,8,10$ is exactly $M(n)=\sqrt{3/2}$ there, which [ELIM-secondorder.md:138](ELIM-secondorder.md#L138) has already quarantined from this same instrument (*"Its supremum over $\mathrm{Weyl}_n$ is $\sqrt{3/2}$ at $n=6,8,10$, same instrument"*), and which [conventions.md](../findings/conventions.md) grants only at $n=4$ and $n=6$. **The canon asserts at $n=8,10$ what an elimination review withdrew.** *Fix: end the sentence at "at the dimensions stated", and continue "so the ascent's best point differs between the two extreme directions", which is what the evidence supports and is still the interesting content.*

- **[bispectral.md:421](../findings/bispectral.md#L421): *"$W_{\mathbb{CP}^2}$ wins the $\Lambda^2$ cubic."*** Two readings, and they differ. **Pairwise between the two named competitors it is true**, $1/\sqrt6=0.4082$ against $A(3)=0.1054$ at $n=6$, and the sentence opens *"the two competitors are separated by"*, so that is the intended reading. **Globally it is false**, and the block's own row 3 is the evidence: $p_3(\mu)(\mathbb{CP}^3)=0.5446>1/\sqrt6$ at $n=6$ and $p_3(\mu)(\mathbb{CP}^4)=0.5728>1/\sqrt6$ at $n=8$, so the $(1,0)$ ascent lands on **neither** competitor. The section heading above it (*"The two cubics have different champions"*), invites the global reading. *Fix: "of the two competitors, $W_{\mathbb{CP}^2}$ has the larger $\Lambda^2$ cubic".* **The same sentence is in the report without the qualifier**, at [06b-bispectral.tex:107](../report/sections/06b-bispectral.tex#L107).

**What the ascent can establish, stated positively.** For each sampled ray it gives a lower bound on the support function $h_{\mathcal R_n}(a,b)$ of the realisable region, and therefore can refute the supporting-line claim and never confirm it. [run_bispectral_region.py:3](../scripts/runs/run_bispectral_region.py#L3) says this, and so does [bispectral.md:438](../findings/bispectral.md#L438), **the fence is well built where it is built.**

## 5. The direction sweep

**$(a,b)$ is scale-invariant on the positive ray and the record does not say so.** The objective is linear in $(a,b)$, so the argmax depends only on the ray $\mathbb R_{>0}(a,b)$; the script confirms it operationally, normalising by `nb=np.hypot(a,b)` before ascending ([:91](../scripts/runs/run_bispectral_region.py#L91)). **The sign is not free**, $(0,-1)$ and $(0,1)$ are different problems. The choice of $(\tfrac32,-\tfrac12)$ over the equivalent $(3,-1)$ is deliberate and worth one clause in the block: at that scaling the objective value *is* $\theta$.

**Three of the six directions are unreported.** The script sweeps `DIRS=[(1.5,-0.5),(0,-1),(1,0),(1,-1),(2,-1),(1,-2)]` at [:90](../scripts/runs/run_bispectral_region.py#L90). The table carries the first three. **$(1,-1)$, $(2,-1)$ and $(1,-2)$ appear nowhere in [findings/](../findings/), [results.md](../results.md) or [report/](../report/)**, and $(1,-1)$ and $(2,-1)$ bracket the $\theta$ ray $(3,-1)$, so they are the directions that would say whether the champion changes across it. The prose at [:407](../findings/bispectral.md#L407) says "six directions" and then shows three; a reader cannot tell whether the other three were uninteresting or unfavourable.

**Six rays is not a sweep of the circle, and the block should not be read as one.** Nothing here bounds the support function between sampled rays, so a fourth champion sitting in an unsampled arc is untouched by this evidence. *"Split" is safe language for what was seen; "the champion split" is not.*

**Does a direction land on the conjectured maximiser? Yes, and the record says so.** $(0,-1)$ lands on the balanced sphere product at $n=6,8,10$ and $12$, and at $n=12$ so does $(\tfrac32,-\tfrac12)$ ([:429](../findings/bispectral.md#L429)). This is not a fence post; it is the block's first row and its $n=12$ table.

**What a run would decide, since I may not open one.** The single most informative missing cell is row 3 at $n=10$. If the $(1,0)$ ascent there lands at $\theta=\sqrt{0.9}=0.948683$ with $p_3(\mu)=0.579751$, the row is the $\mathbb{CP}^{n/2}$ family at $m=3,4,5$ and row 3 becomes a closed-form family; if it lands lower, the row is a stall census and rows 1 and 2 inherit the doubt. **The run already exists** (`REGION_NS` defaults to `6,8,10`) so this is a reporting question, not a compute question, unless the output was not retained.

## 6. Provenance

**The boilerplate is false here, and its locator is broken.** The note reads *"the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block."*

| clause | verdict | evidence |
| --- | --- | --- |
| *"numbered in report/"* | **TRUE** | `\begin{Obs}{53}` entered [06b-bispectral.tex:103](../report/sections/06b-bispectral.tex#L103) in `052c33b7` (2026-08-26); the findings block is `86621751` (2026-08-31) |
| *"the mathematics has always been in this file"* | **FALSE** | `git log -S "Numerical, by ascent" --all` returns `1f82f29f` first (2026-08-26 11:51), which wrote the material into **`findings/live-front.md`**, since deleted. It reached `findings/bispectral.md` only at `ea7c61c4` (12:33 the same day), the commit that created the file by splitting live-front in three. The material has been in *this file* since the file existed, and lived elsewhere before that |
| *"it carried no block"* | **TRUE** | `86621751`'s diff adds the block to a file that had none |

**This is one of the fifteen surviving copies of the boilerplate, and it is false in the same way the others are: the phrase asserts the mathematics did not move, and it moved.** *Fix: "the mathematics was written in `findings/live-front.md` on 2026-08-26 and reached this file in the split of the same day".*

**A fourth clause, added later, names a heading that does not exist.** The note ends *"the argument is in this file under **"Numerical, by ascent, so these are lower bounds on each direction's m"**"*. The real heading at [:405](../findings/bispectral.md#L405) ends *"...on each direction's maximum, and the identifications are evidence rather than proof"*. **The locator was truncated mid-word at roughly 60 characters by `93472f0d`, and it is a class defect, not a one-off**, the same commit produced *"...and the failure is systema"*, *"...$\theta$ from $\dim\mathfrak h$ alone, and Conj"* and three more. Grep for a heading by that string and it does not resolve.

**The section reading I use.** I take a `##` section to run to the next `##`, so the `####` blocks under it are inside it. Under that reading L53 sits in the [Post F26](../findings/bispectral.md#L244) section, which is not what the provenance note points at, the note points at a `####` sibling, and that is the pointer that matters. Under the narrow reading (a `##` heading owns only its own prose) nothing about this verdict changes, because the locator is a quoted `####` heading either way.

## 7. Duplication

**The block is a verbatim duplicate of the markdown table thirty-seven lines above it, in a format that renders in neither place.** [bispectral.md:409](../findings/bispectral.md#L409)–[:413](../findings/bispectral.md#L413) is the same table in working markdown; [:447](../findings/bispectral.md#L447)–[:457](../findings/bispectral.md#L457) is the LaTeX copy. **The numbered block is strictly the poorer of the two:**

- its middle column drops the formulas, the markdown row 1 says *"$-p_3(\omega)$, the second-kind cubic alone"*, the LaTeX row says only *"the second-kind cubic alone"*, so the **sign is lost** and a reader sees direction $(0,-1)$ against an unsigned objective;
- it writes `\thstar` where the markdown writes $\sqrt{3/2}$, so the value's identity is lost;
- it drops the norm constraint and the script citation;
- **it drops the report's own hedge.** [06b-bispectral.tex:118](../report/sections/06b-bispectral.tex#L118) carries a *"Label caution"* immediately after the same table, *"Ascent bounds each direction's maximum from below only ... which is why this is an Observation and not a Lemma"*. The findings block imported the table and left the caution behind.

**Answer to the brief's question: the content appears elsewhere unnumbered, not under another number.** No second numbered result restates it. The near neighbours are distinct: [L50](../findings/bispectral.md#L128) is the identity, [L67](../findings/bispectral.md#L466) the balanced spectrum, and the crossover $n=6+2\sqrt7$ is [L2](../results.md), which I checked, $2(n-1)(n-2)/n^2=3/2$ giving $n^2-12n+8=0$ and $n=6+2\sqrt7$.

*Recommendation: delete the LaTeX tabular from the block, replace it with the markdown table already at [:409](../findings/bispectral.md#L409) (with the point named in row 3 and the $n=10$ cell filled) and carry the report's label caution across.*

## 8. Presentation and pointers

- **The raw `tabular` does not render.** `\begin{center}`, `\begin{tabular}`, `\toprule`, `\midrule`, `\bottomrule` are inert in markdown; **[bispectral.md:449](../findings/bispectral.md#L449) is the only `\toprule` anywhere in [findings/](../findings/)**, so this block is the record's sole full LaTeX float in a markdown file.
- **Report-only macros: `\Weyl`, `\CP`, `\thstar`.** None is defined for markdown. They leak into six findings files, [target.md:636](../findings/target.md#L636), [target.md:751](../findings/target.md#L751), [sym3-stability.md:58](../findings/sym3-stability.md#L58), [sym3-blocks.md:198](../findings/sym3-blocks.md#L198), [ungraded-slack.md:261](../findings/ungraded-slack.md#L261), [ungraded-slack.md:296](../findings/ungraded-slack.md#L296), [LEDGER.md:960](../findings/LEDGER.md#L960), but only here inside a float.
- **Markdown bold inside LaTeX.** Row 1 carries `**balanced sphere product**`, which the report renders as literal asterisks; the report's own copy correctly uses `\textbf{}`. So the block is broken in **both** directions at once, it is neither valid markdown nor the valid LaTeX it was copied from.
- **Columns against header: aligned in count, mismatched in content.** Three `p{}` columns, three header cells, three cells per row, the alignment is sound. The mismatch is semantic: the header promises *"$n=6,8,10$"* and row 1 over-delivers (adding $n=12$) while row 3 under-delivers (omitting $n=10$).
- **Pointers.** The block's one link, `[report/](../report/)`, resolves. [run_bispectral_region.py](../scripts/runs/run_bispectral_region.py) exists and is cited from the section, not the block. The provenance locator does not resolve (§6). Downstream, [INDEX-results.md:68](../findings/INDEX-results.md#L68) and [results.md:250](../results.md#L250) both point here and both resolve; [plan-verification.md:97](../plan-verification.md#L97) has L53 unchecked.
- **One report line outside my remit, recorded not acted on.** [06b-bispectral.tex:177](../report/sections/06b-bispectral.tex#L177) says *"**Verified** at $n=6,8,10,12$ by multistart ascent"* with no hedge, where [09-status.tex:77](../report/sections/09-status.tex#L77) says the same and adds *"which bounds each direction from below only"*. The second is right.

## 9. What I would change, in order of value

1. **Name the point in row 3** at $n=6$ and $n=8$, from the `p3(mu)` column the script already prints. $\theta$ alone cannot: $\theta(\mathbb{CP}^3)=\theta_0(6)$ and $\theta(S^2\times S^6)=\theta(\mathbb{CP}^4)$ exactly. Cite [INDEX-results.md:24](../findings/INDEX-results.md#L24), where the record already paid for this collision once.
2. **Cut the champion clause from [results.md:722](../results.md#L722)**, which contradicts its own preceding clause and asserts at $n=8,10$ what [ELIM-secondorder.md:138](ELIM-secondorder.md#L138) withdrew.
3. **Fold the closed forms in.** $p_3(\mu)$ at the balanced product **is** [L67](../findings/bispectral.md#L466)'s $A$; the $n=12$ table is $\bigl(\tfrac1{6\sqrt{55}},\tfrac{-107}{6\sqrt{55}}\bigr)$; $0.986013=\sqrt{35}/6$; and $p_3(\mu)(\mathbb{CP}^m)$ has the closed form of §1c. Every one converts a measurement into a check.
4. **Replace the tabular with the markdown table**, restore the $-p_3(\omega)$ sign, the unit-norm constraint and the report's label caution, and fill or explicitly strike the $n=10$ cell.
5. **Qualify [bispectral.md:421](../findings/bispectral.md#L421)** to the pairwise reading; the global one is false by $\mathbb{CP}^3$ and $\mathbb{CP}^4$.
6. **Repair the provenance note**, both the false "always been in this file" and the truncated locator, the latter a class defect across `93472f0d`'s seven blocks.
7. **Add a $p_3$ row to [conventions.md](../findings/conventions.md).** It is the objective of this entire block and the file that owns definitions does not carry it.
