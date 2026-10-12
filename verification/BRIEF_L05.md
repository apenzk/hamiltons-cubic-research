# Brief for round L05

**Verbatim extracts. Nothing here is paraphrased.**

## A. The canonical statement, from results.md

```markdown
##### Lemma L5, rival critical-point families

Needed to rule out every other critical-point family found so far. Six further families lose to both named competitors: multi-block sphere products (3+ factors), Fox's full 5-dimensional hyper-Kähler subalgebra and its $r\geq8$ extension (both collapse onto orbits of already-named competitors, the latter tied to the quaternionic-Kähler family named next), quaternionic-Kähler operators on $\mathbb{HP}^m$, $m\leq4$, new ground, with no prior link between this problem and QK geometry in the literature, and eliminated on value while remaining a genuine peak in its own right (Lemma L9), strongly-regular-graph-derived solutions ([Deninger–Grundhöfer–Kramer](https://arxiv.org/pdf/2204.02706)), where the non-primitive case collapses exactly onto the sphere product and every primitive case checked (named families plus an exhaustive parameter sweep to $n=200$) falls well short, and the simple-isotropy members of Lemma L4's family, which top out at $P\leq0.837$, that family also contains the balanced sphere products themselves, and Lemma L23 shows they are its maximum. The defect analysis later surfaced one more genuinely new critical point, living on $\mathfrak{so}(5)=\mathfrak{sp}(2)$ in its 8-dimensional spin representation, with a non-symmetric invariant split, which also threatens nothing ($P=0.387$) but shows the landscape still holds surprises. A seventh family surfaced late and is the most structurally telling: a Ricci-flat Kähler family on $\mathbb C^m$ with closed-form value, whose $m=2$ member **is** the $\mathbb{CP}^2$-type competitor itself, and the family peaks there, so the one persistent rival is the extreme point of its own family rather than an isolated accident.

**Proof:** [graded-half.md](findings/graded-half.md)
```

## B. The landscape statement of the same result, from results.md

```markdown
- **Lemma L5 (landscape). Rival critical-point families.** Six families eliminated on value, multi-block sphere products, both of Fox's hyper-Kähler subalgebras, the quaternionic-Kähler operators, the strongly-regular-graph solutions, and the simple-isotropy members of the family found here. **The highest is $\theta(\mathbb{HP}^2)=\sqrt{56/45}\approx1.1155$ against $\sqrt{3/2}\approx1.2247$, and one family attains $\sqrt{3/2}$ exactly.** *The figure $0.837$ that stood here is the ceiling of the isotropy-generated family alone, and \"none is close\" was refuted three times over from inside this very list, by Fox's $r=4$ subalgebra, by $\mathbb{HP}^2$, and by the $\mathbb{CP}^m$ family above $0.837$ at every $2\le m\le30$.* The elimination survives, with a margin of $0.109$ rather than $0.388$.
```

## C. The block in findings/graded-half.md, lines 41-64

```markdown
#### Observation L5, the census of rival critical-point families, at the families examined

> **REFUTED AS A LEMMA AND AS A CENSUS.** *Gate 2, [r581](../reviews/REVIEW_r581.md) and [r582](../reviews/REVIEW_r582.md) on identical briefs.* **The label was never earned**, [INDEX-results.md](INDEX-results.md) records *\"Gate 2: no verdict on the record\"* for it, and a census of families found so far is evidence about a population, not a theorem. **The population is undefined**: *rival*, *family* and *found so far* have no definitions here, and there is no $n$-quantifier though every constituent check is bounded.
>
> **\"The highest tops out at $0.837$ … none is close\" is false three times over, each witness inside the six families that sentence enumerates.** Fox's $r=4$ subalgebra attains **exactly** $\sqrt{3/2}=1.224745$; the quaternionic-Kähler operator on $\mathbb{HP}^2$ gives $\sqrt{56/45}=1.115546702$; and the $\mathbb{CP}^m$ family exceeds $0.837$ for every $2\le m\le30$. *The route $\theta=1/(2\lVert W\rVert)$ reproduces four further record values it was not fitted to, to all printed digits.*
>
> **The six are not six, and they do not all lose.** Items $3$ and $4$ are one family: $\mathbb B_8$ and $\mathbb B_{12}$ give $1.11554670$ and $0.85294386$, identical to $\mathbb{HP}^2$ and $\mathbb{HP}^3$ to nine digits. And item $2$ **ties** rather than loses, *which this block's own parenthesis says, \"collapse onto orbits of already-named competitors\", contradicting the word \"lose\" in the same sentence.*
>
> **AND THE CENSUS OMITS A FAMILY THAT BEATS ONE OF THE TWO COMPETITORS, TABULATED TWENTY LINES ABOVE IT.** $S^5\times S^7$ at $n=12$ has $\theta^2=\tfrac{264}{175}=1.5085714>\tfrac32$, so $\theta=1.2282392>\sqrt{3/2}$ (**it beats padded $W_{\mathbb{CP}^2}$**) and an infinite such family exists whenever $p,q\ge5$. *The census's only sphere-product entry reads \"3+ factors\", so two-factor unbalanced products are absent from it entirely.* Verified by two exact-rational routes sharing nothing with the table's solver, including this file's own partition identity $\tfrac5{32}+\tfrac7{48}-\tfrac3{22}=\tfrac{175}{1056}$.
>
> **The conclusion survives against the balanced product**, which is what Conjecture A is about: $\theta_0(12)=1.2360331$ still exceeds $1.2282392$. **What fails is the census's own claim** that every named family loses to *both* competitors. **What fails is the count, the comparative and the ceiling**, and the ceiling reached the report, where a status table called it *Proven*.

*Copied here from [results.md](../results.md) on 2026-08-31 and **the duplication resolved on 2026-09-06**: that file carried this paragraph byte-identical for six days while its commit message said it was untouched, and now holds the statement alone. **And the correction that stood here, that "results.md held the only copy" is false, is itself false**: at `84cada75^` this file carried no L5 block at all, the material being in [problem.md](problem.md), so results.md did hold the only copy. A provenance note wrong in both clauses, the second while presenting itself as the outcome of a check.*

**Both eliminations are already theorems on the record, and the census cites neither.** *This was written here as a repair and is a rediscovery, corrected on [r581](../reviews/REVIEW_r581.md)'s self-correction.* **[ungraded-slack.md](ungraded-slack.md) closes the multi-block family in form**, and **this file closes the quaternionic one $150$ lines below this block** with

$$\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}=1.115546702<\sqrt{3/2},$$

stated there *\"by proof rather than by the two points tabulated above\"*. **So the exact value refuting this census's ceiling is a proved supremum in its own file**, not a witness, but the very quantity a ceiling claims. *Eleventh time this session that the fact settling a result sat inside its own file, and the most extreme instance of it.* The multi-block bound reads $\lVert W\rVert^2=\tfrac{k-1}8+\tfrac18\big(\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}\big)$, hence

$$\theta\ <\ \sqrt{\tfrac2{k-1}}\qquad\text{for any $k$-block sphere product,}$$

so $\theta<1$ for every $k\ge3$, **uniformly in $n$**, checked exactly against $S^5\times S^7$ at $1.228239$ and $(S^3)^4$ at $0.638285$. *Neither elimination was ever a measurement; the census recorded them as though they were.*

```

## D. How the three files label it

```markdown
47:| [graded-half.md](graded-half.md) | **Canonical Lemma L5**, the census of rival families. The gradedness split, the graded enumeration, the $\mathbb{CP}^m$ family, the subalgebra family, the four failed attacks on the slack gap |
20:| **5** | Observation | **Gate 2: REFUTED as a Lemma and as a census** ([r581](../reviews/REVIEW_r581.md), [r582](../reviews/REVIEW_r582.md), identical briefs, both REFUTED). **Downgraded to `Obser
(results.md heading, line 316):
##### Lemma L5, rival critical-point families
(findings heading, line 41):
#### Observation L5, the census of rival critical-point families, at the families examined
```
