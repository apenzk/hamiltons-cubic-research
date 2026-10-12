# Verifier v158, Observation L5, the rewritten census of rival critical-point families

I read [BRIEF_L05.md](BRIEF_L05.md) cold and worked from [conventions.md](../findings/conventions.md) and the blocks themselves; I did not read the two Gate 2 reviews that produced the rewrite, and I did not re-run the census. **No numerical work was done. Every value in this report is an exact rational or an exact radical, obtained by hand from the record's own closed forms**; the two decimal expansions I quote ($1.2360331$, $1.2282392$) are the record's own and every comparison I make between them is carried out on the rationals $\tfrac{55}{36}$ and $\tfrac{264}{175}$ instead. Log: [agent_logs/verify-L05-v158.log](../agent_logs/verify-L05-v158.log).

## Claim table

| # | claim attacked | verdict | reason |
| --- | --- | --- | --- |
| 1 | $\theta<\sqrt{2/(k-1)}$ for any $k$-block sphere product, uniformly in $n$ | **CONFIRMED AS ALGEBRA** | follows from [L23](../findings/ungraded-slack.md)'s file's own closed form for every $k\ge2$, every $n_a\ge2$; the quoted $\lVert W\rVert^2$ identity is equivalent to it |
| 2 | the "hence" joining that identity to the bound | **GAP** | it needs $\theta=1/(2\lVert W\rVert)$, which is [L46](../findings/problem.md) with three hypotheses, cited nowhere at that step |
| 3 | $\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}$, "by proof rather than by the two points tabulated" | **CONFIRMED AS ALGEBRA** | derivative, its factorisation and the positivity argument all re-derived exactly; assembly of the block masses into $\theta^2$ is a script, not text |
| 4 | the Petersen–Stanfield input to that closed form | **CONFIRMED, gloss overstated** | §3.5 quoted verbatim and specialises to $\mathbb{HP}^m$ correctly; "every Wolf space of dimension $4n$" is wider than PS's own text, which names four exceptions |
| 5 | $S^5\times S^7$ at $\theta^2=264/175$ beats padded $W_{\mathbb{CP}^2}$ | **CONFIRMED** | $264\cdot2=528>525=3\cdot175$, and $\tfrac{175}{1056}$ reproduced from the multi-block identity |
| 6 | "an infinite such family exists whenever $p,q\ge5$" | **REFUTED AS STATED** | $S^5\times S^5$ has $p,q\ge5$ and $\theta=6/5<\sqrt{3/2}$; so does $S^5\times S^6$. The exceptions are exactly three pairs |
| 7 | the surviving conclusion at $n=12$: $\theta_0(12)>\theta(S^5\times S^7)$ | **CONFIRMED** | $55\cdot175=9625>9504=264\cdot36$ |
| 8 | that conclusion at every $n$, both parities | **CONFIRMED AS ALGEBRA, no argument on file** | convexity of $1/(x-1)$ gives it, and the two-block maximum is $\Theta_n$ at both parities; the block checks one point |
| 9 | "four lose to both named competitors and one ties" | **REFUTED AS STATED** | no $n$-quantifier; at $n=8$ item 2 attains $\sqrt{3/2}=1.224745>\theta_0(8)=\sqrt{21}/4=1.145644$, so it beats a named competitor rather than tying |
| 10 | the two admitted-open classes | **REFUTED AS STATED (scoping)** | the strongly-regular half is closed at every $n$ by [L144](../findings/diagonal-half.md); the census cites its own $n\le200$ sweep and neither [L74](../findings/diagonal-half.md) nor L144 |
| 11 | the repair reaching the consumer | **REFUTED** | [results.md:316](../results.md) still heads the block **Lemma L5** and still reads "**Six** further families **lose to both** named competitors" |
| 12 | $\ker W\ne0$ / padded objects | **GAP** | the $\lVert W\rVert^2$ identity is false at a padded copy read at the ambient dimension; the bound survives, the identity does not |

## One-line summary

The mathematics that survives is correct and is stronger than the block claims, but the rewrite reached [graded-half.md](../findings/graded-half.md) only, so [results.md](../results.md) still carries the refuted sentence and the withdrawn `Lemma` label, and two clauses of the rewritten text ("whenever $p,q\ge5$", "the open two") are false as written.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $\theta$: "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- $\theta_0(n)$: "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$, the gap being $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))$*".
- $\Theta_n$: "the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$".
- $M(n)$: "**the global maximum** of $P$ on the unit sphere of $\mathcal W_n$ … $M(n)>0$ at every $n\ge4$, padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$ … Distinct from $\Theta_n$ … strictly at $n=4$ and $n=6$, where $M=\sqrt{3/2}$ against $\Theta_4=0.866$ and $\Theta_6=1.0541$".
- $t$, $K$: "$K$ is the symmetric hollow $n\times n$ **sectional matrix**, $K_{ab}=W_{abab}$ for all $a\ne b$, and $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$, the sum over **ordered** pairs. Then $t\le2$ with **$t=2$ iff $W$ is coordinate-diagonal in some frame**".
- padding: "**Padding commutes with $Q$**, and preserves both the norm and $\theta$."
- $S(W)$: "the gradedness slack. **Read [W4](../findings/INDEX-traps.md) before using it**: the screen is vacuous when $\ker W\ne0$".

**Symbol collision, live in the statement under review.** The statement writes "*top out at $P\leq0.837$*" and "*threatens nothing ($P=0.387$)*", but the quantities compared everywhere else in the same paragraph are $\theta$'s. Under the table's own definitions $P$ and $\theta$ agree only at $\lVert W\rVert=1$, and the record's own value for the $\mathfrak{su}(3)$ point is $\theta=\sqrt{7/10}=0.836660$ ([ungraded-slack.md](../findings/ungraded-slack.md)). The two numbers are $\theta$'s wearing the letter $P$.

## Hypothesis inventory

### What the statement quantifies over

| term | status |
| --- | --- |
| *rival* | undefined. The Gate 2 pair said so; the rewrite did not define it. |
| *family* | undefined, and the rewrite's own count depends on it, items 3 and 4 merged into one family precisely because "family" is not fixed. |
| *found so far* | undefined, and **time-indexed**: the block's closing sentence ("*the record of what has been checked and found short*") makes this explicit and is the only honest reading available. |
| $n$ | **no quantifier at all.** Every constituent check is bounded: $m\le4$ in the statement, $n\le200$ for the graphs, $n=12$ for the surviving comparison. |
| the "two named competitors" | never named in the block. Reconstructed from [conventions.md](../findings/conventions.md) as the balanced sphere product ($\Theta_n$) and padded $W_{\mathbb{CP}^2}$ ($\sqrt{3/2}$). |

### Hypotheses of every imported result, and whether the written text uses them

| import | its hypotheses | used by the written text? |
| --- | --- | --- |
| the multi-block closed form, [ungraded-slack.md](../findings/ungraded-slack.md) | $S^{n_1}\times\dots\times S^{n_k}$; **$n_a\ge2$ for every block**, needed for $1/(n_a-1)$ to exist; $n=\sum n_a$ | **used, and $n_a\ge2$ is stated nowhere.** The bound is quoted from it, in a different but equivalent algebraic form |
| [L46](../findings/problem.md), $\theta=1/(2\lVert W\rVert)$ | $R$ locally symmetric, **Einstein**, $\mathrm{Ric}=\lambda g$ with $\lambda\ne0$; and $\lambda=\tfrac12$ needs Petersen–Stanfield's normalisation | **used silently** at the "hence" of the multi-block step, and cited nowhere in the block. Its hypotheses fail on two of the census's own items (see §2) |
| [L23](../findings/ungraded-slack.md) | $\mathfrak h\subseteq\mathfrak{so}(n)$ a subalgebra, $0<r<N$, $W_{\mathfrak h}$ a unit multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$, $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$, and $\mathfrak h\not\cong\mathfrak m$ for the producing criterion | **cited, for the family's internal maximum only.** Its conclusion is $\theta\le\theta_0(n)$, see §8 for what that does *not* give at odd $n$ |
| [L9](../findings/graded-half.md) | $\mathbb{HP}^2$ at $n=8$; the block's own boxed correction records that the "$n=8$ **and** $n=12$" reading "**stands on neither reading**" | cited for "*a genuine peak in its own right*", at $n=8$, which is inside L9's surviving scope |
| $\sup_m\theta(\mathbb{HP}^m)$ | the closed form, whose $S_{\mathfrak{mmm}}$ input carries $(m-2)(m-1)(m+1)$ and so **needs $m\ge2$**; $m=1$ is the pole $\mathbb{HP}^1=S^4$, $W=0$ | **used**, and the $m\ge2$ range is stated in the source block though not at the point of use |
| [Deninger–Grundhöfer–Kramer](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/) | strongly regular $(v,k,\lambda,\mu)$; the record's [L74](../findings/diagonal-half.md) re-derives the correspondence in its own normalisation and records the unstated $0<k<v-1$ | **cited as a source of solutions, not as a theorem.** The elimination is carried by a sweep, and the record's own uniform bound ([L144](../findings/diagonal-half.md)) is not cited |
| Petersen–Stanfield §3.5 | Wolf spaces of dimension $4n$; **PS's own text names four spaces where the naive reading of the eigenvalue fails** | used, specialised to $\mathbb{HP}^m$ only, where the exceptions do not bite |

**A hypothesis stated but never used.** The statement's "*quaternionic-Kähler operators on $\mathbb{HP}^m$, $m\leq4$*" restricts a family the same file proves closed **for every $m$**. The restriction is inert: nothing downstream needs it, and it makes the statement weaker than its own proof.

## 1. The multi-block bound, CONFIRMED AS ALGEBRA

The block prints

$$\lVert W\rVert^2=\tfrac{k-1}8+\tfrac18\Big(\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}\Big),\qquad\text{hence}\qquad\theta<\sqrt{\tfrac2{k-1}} .$$

[ungraded-slack.md](../findings/ungraded-slack.md) carries the family's closed form instead:

$$\theta^2=\frac{2(n-1)^2}{(k-1)n^2+\sum_a\frac{(n-n_a)^2}{n_a-1}} .$$

**The two are the same statement.** Writing $\theta^2=2/D$ with $D=(k-1)+\sum_a\frac1{n_a-1}-\frac1{n-1}$ (which is what $\theta=1/(2\lVert W\rVert)$ makes of the printed identity), the equality of the two denominators reduces to

$$\sum_a\frac{(n-1)^2-(n-n_a)^2}{n_a-1}=\sum_a(2n-1-n_a)=k(2n-1)-n=(k-1)(2n-1)+(n-1),$$

using $(n-1)^2-(n-n_a)^2=(n_a-1)(2n-1-n_a)$ and $\sum_an_a=n$. Exact, for every $k$ and every partition.

**The bound follows in one line and is uniform in $n$.** Each $n_a<n$ gives $\frac1{n_a-1}>\frac1{n-1}$, and there are $k\ge2$ such terms, so the bracket is strictly positive; hence $D>k-1$ and $\theta^2<\frac2{k-1}$. Equivalently from the second form, $\sum_a\frac{(n-n_a)^2}{n_a-1}>0$ and $(n-1)^2<n^2$, two strict inequalities. **CONFIRMED for every $k\ge2$, every $n$, every admissible partition.**

**The edge of the range, $k=3$.** The bound reads $\theta<\sqrt{2/2}=1$, strictly, so the boundary case is exactly where "$\theta<1$ for every $k\ge3$" is tightest and it still clears. At the *smallest admissible dimension* for $k=3$ (which is $n=6$, at $(S^2)^3$, since $n_a\ge2$), the identity gives $\lVert W\rVert^2=\tfrac14+\tfrac18(3-\tfrac15)=\tfrac35$ and $\theta^2=\tfrac5{12}$, against $\Theta_6^2=\tfrac{10}9$. Cleared with room.

**And the elimination is uniform against the competitor, which the block does not say.** $\theta_0(n)\ge1\iff n^2-6n+4\ge0\iff n\ge3+\sqrt5$, so $\theta_0(n)>1$ for every even $n\ge6$; at odd $n$, $\Theta_7^2=\tfrac{48}{40}>1$ and $\Theta_n$ increases. Since $k\ge3$ with $n_a\ge2$ forces $n\ge6$, **item 1 loses to both competitors at every admissible $n$, both parities.** That is a stronger statement than the block's, obtained from the block's own bound.

**Anchors reproduced exactly.** $(S^3)^4$: $\lVert W\rVert^2=\tfrac38+\tfrac18(2-\tfrac1{11})=\tfrac{27}{44}$, $\theta^2=\tfrac{11}{27}$, $\theta=0.638285$, the block's figure. $S^5\times S^7$: $\lVert W\rVert^2=\tfrac18+\tfrac18(\tfrac14+\tfrac16-\tfrac1{11})=\tfrac{175}{1056}$, matching this file's own partition identity $\tfrac5{32}+\tfrac7{48}-\tfrac3{22}=\tfrac{175}{1056}$ and giving $\theta^2=\tfrac{264}{175}$.

> **The second anchor is vacuous as a check.** $S^5\times S^7$ has $k=2$, where the bound reads $\theta<\sqrt2$, it cannot discriminate. The block offers it as one of two exact checks on a bound that is about $k\ge3$.

## 2. The "hence", GAP

**Locate it.** "*The multi-block bound reads $\lVert W\rVert^2=\dots$, hence $\theta<\sqrt{2/(k-1)}$*". A statement about $\lVert W\rVert$ implies a statement about $\theta$ only through a relation between them. The relation is $\theta=1/(2\lVert W\rVert)$, and it appears in this same file 130 lines below as a **consequence of [L46](../findings/problem.md)**: "*Let $R$ be the curvature operator of a locally symmetric **Einstein** space, $\mathrm{Ric}=\lambda g$ **with $\lambda\ne0$** … Then $Q(W)=\lambda W$*", plus "*$\lambda=\tfrac12$ for every compact irreducible symmetric space in Petersen–Stanfield's normalisation*". At the point of use it is cited nowhere, and its three hypotheses are checked against nothing.

**Exhibit the failure.** The hypotheses are not idle. This same file records, of the $(\mathfrak{su}(m),\mathfrak{so}(m))$ points, "*Those points are Ricci-flat Kähler **algebraic** curvature operators, not Weyl parts of symmetric metrics*", so $\theta=1/(2\lVert W\rVert)$ is unavailable there, and the census's strongly-regular-graph items are algebraic curvature operators built from a graph, not curvature operators of locally symmetric Einstein manifolds either. The block's parenthesis "*the route $\theta=1/(2\lVert W\rVert)$ reproduces four further record values it was not fitted to*" names no member of the four, so a consumer cannot tell which objects the route is licensed on.

**Argue the opposite.** The step is repairable without L46 at all: the same file's [ungraded-slack.md](../findings/ungraded-slack.md) solves the vertex system for every partition, $w_{ab}=-\theta/(n-1)$ off-block and $w_{aa}=\theta(n-n_a)/((n-1)(n_a-1))$ in-block, and the normalisation $t=2$ of [conventions.md](../findings/conventions.md) then fixes $\theta$ directly:
$$t=\frac{\theta^2}{(n-1)^2}\Big[\sum_an_a\frac{(n-n_a)^2}{n_a-1}+n^2-\sum_an_a^2\Big]=2,$$
and $\sum_a(n-n_a)^2+n^2-\sum_an_a^2=(k-1)n^2$ turns this into the printed closed form with no Einstein hypothesis anywhere. **So the conclusion is safe and the written step is not.** Recorded as a GAP in the text, not in the mathematics.

## 3. $\sup_m\theta(\mathbb{HP}^m)$, CONFIRMED AS ALGEBRA

The closed form is $\theta^2(\mathbb{HP}^m)=\frac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}$. Writing $N=4m^3+15m^2+12m-4$ and $D=9(2m^3-m^2-m)$, I differentiated by hand:

$$N'D-ND'=9\big[-34m^4-56m^3+21m^2-8m-4\big],\qquad D^2=81m^2(m-1)^2(2m+1)^2,$$

so $\frac{d}{dm}\theta^2=\frac{-34m^4-56m^3+21m^2-8m-4}{9m^2(m-1)^2(2m+1)^2}$, and $-(m+2)(34m^3-12m^2+3m+2)$ expands to exactly that numerator. **The record's displayed derivative is correct.**

The positivity argument is correct as written: for $m\ge\tfrac12$, $34m-12\ge5$ so $m^2(34m-12)+3m+2>0$; for $0<m<\tfrac12$, $2+3m-12m^2>0$ since the positive root of $12m^2-3m-2$ is $\frac{3+\sqrt{105}}{24}>\tfrac12$. So $\theta^2$ is strictly decreasing on $m>1$, and over integers $m\ge2$ the supremum is the maximum at $m=2$:

$$\theta^2(\mathbb{HP}^2)=\frac{16\cdot7}{9\cdot2\cdot1\cdot5}=\frac{112}{90}=\frac{56}{45},\qquad \theta^2(\mathbb{HP}^3)=\frac{275}{378},\qquad \theta^2(\mathbb{HP}^4)=\frac59,\qquad \theta^2\to\frac29 .$$

All four match the record. **The claim "by proof rather than by the two points tabulated" is earned for the monotonicity and the supremum.**

**The $m\ge2$ edge is handled.** $m=1$ is a pole, and the record identifies it correctly as $\mathbb{HP}^1=S^4$ with $W=0$, where $\theta$ is undefined rather than infinite. The auxiliary $S_{\mathfrak{mmm}}=\frac{12(m-2)(m-1)(m+1)(2m+1)}{m}$ reproduces $0,224,810,\tfrac{9504}5$ at $m=2,3,4,5$ exactly, and its derivation is sound: for $a\in\mathfrak m$ the only surviving block patterns are $(3,3,3)$, $(3,1,3)$, $(3,3,1)$, $(3,2,3)$, $(3,3,2)$, since $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h\perp\mathfrak m$ kills $S_{113}$ and $S_{223}$, and $[\mathfrak{sp}(1),\mathfrak{sp}(m)]=0$ kills $S_{123}$, so the marginal gives $\rho d_3=S_{\mathfrak{mmm}}+2(S_{133}+S_{233})$, which is the record's line.

**What is not in text.** The step from the five block masses to $\theta^2$ is a script ([b_hp_closed_form.py](../scripts/route-b/b_hp_closed_form.py)), reported as "*closed form and block rebuild agreeing exactly at $m=2,\dots,8$*". Agreement at seven points is not the derivation. **CONFIRMED AS ALGEBRA**: every ingredient I could check by hand is exact, and the one assembly step is on file as code rather than as an argument.

**The census's own range is the weaker claim.** The statement restricts to $m\le4$; the file proves the supremum over all $m$. The elimination against the *second* competitor also holds uniformly and is not stated: $\theta(\mathbb{HP}^m)\le\sqrt{56/45}=1.115547<\sqrt{21}/4=\theta_0(8)\le\theta_0(4m)$ for every $m\ge2$, $\theta_0$ being increasing in $n$.

## 4. The Petersen–Stanfield input, CONFIRMED, gloss overstated

I read §3.5 at source ([petersen-stanfield-2508.11236.txt:1019](https://arxiv.org/abs/2508.11236)). It reads, verbatim: "*For those Wolf spaces of dimension $4n$ we have $\lambda_{sp(1)}=\tfrac12\cdot\tfrac n{n+2}$, $\lambda_{h_2}=\tfrac12\cdot\tfrac n{n+2}\cdot\tfrac{2n+1}{\dim h_2}$*". The record's transcription is exact, and the specialisation is right: at $\mathbb{HP}^m$, $\dim\mathfrak{sp}(m)=m(2m+1)$, so $\lambda_{\mathfrak h_2}=\tfrac12\cdot\tfrac m{m+2}\cdot\tfrac{2m+1}{m(2m+1)}=\tfrac1{2(m+2)}$, the record's figure.

**The gloss overstates.** The record writes that §3.5 "*gives the curvature operator eigenvalues of **every** Wolf space of dimension $4n$*". PS's next paragraph says the obvious reading "*fails in several ways*" and names $SO(6)/(SO(4)\times SO(2))$, $U(2+n)/(U(2)\times U(n))$, $SO(8)/(SO(4)\times SO(4))$ (one eigenvalue only) and $G_2/SO(4)$ (a second eigenvalue $5/12$). **No consequence here** (only $\mathbb{HP}^m$ is used, and it is none of the four) but a consumer who takes the gloss at face value and applies it to another Wolf space inherits a false premise.

## 5. $S^5\times S^7$ against padded $W_{\mathbb{CP}^2}$, CONFIRMED

$\theta^2=\tfrac{264}{175}$ from §1, and $264\cdot2=528>525=3\cdot175$, so $\theta^2>\tfrac32$ exactly. Padding preserves $\theta$ ([conventions.md](../findings/conventions.md)), so padded $W_{\mathbb{CP}^2}$ sits at $\sqrt{3/2}$ at $n=12$ and is beaten. **CONFIRMED, in exact rationals.** The observation that the census's only sphere-product entry says "3+ factors" and so excludes two-factor unbalanced products entirely is correct: the statement's first item is written "multi-block sphere products (3+ factors)".

## 6. "an infinite such family exists whenever $p,q\ge5$", REFUTED AS STATED

**Locate it.** The sentence is "*$S^5\times S^7$ … beats padded $W_{\mathbb{CP}^2}$, and an infinite such family exists whenever $p,q\ge5$*".

**Exhibit the failure.** From §1, $\theta^2(S^p\times S^q)=\dfrac2{1+E}$ with $E=\dfrac1{p-1}+\dfrac1{q-1}-\dfrac1{p+q-1}$, so $\theta^2>\tfrac32\iff E<\tfrac13$. At $p=q=5$:
$$E=\tfrac14+\tfrac14-\tfrac19=\tfrac{7}{18}>\tfrac13,\qquad \theta^2=\frac{2}{\tfrac{25}{18}}=\frac{36}{25},\qquad \theta=\tfrac65=1.2<\sqrt{3/2} .$$
$S^5\times S^5$ satisfies $p,q\ge5$ and **does not** beat padded $W_{\mathbb{CP}^2}$. So does $S^5\times S^6$: $E=\tfrac14+\tfrac15-\tfrac1{10}=\tfrac7{20}>\tfrac13$.

**The exact condition.** With $a=p-1$, $b=q-1$ the criterion $\tfrac1a+\tfrac1b-\tfrac1{a+b+1}<\tfrac13$ resolves to $b(b+5)>60$ at $a=4$ (so $q\ge7$ when $p=5$), $b(b+6)>45$ at $a=5$ (so $q\ge6$ when $p=6$), and $b(b+7)>42$ at $a=6$ (so $q\ge5$ when $p=7$). **The exceptions with $p,q\ge5$ are exactly $(5,5)$, $(5,6)$ and $(6,5)$**; every other such pair exceeds $\sqrt{3/2}$.

**Argue the opposite.** Read existentially ("*there is an infinite family of such pairs, and it lives in the region $p,q\ge5$*"), the sentence is true, and the region is right in the sense that $p=4$ never qualifies ($\tfrac1{q-1}>\tfrac1{q+3}$ makes $E>\tfrac13$ identically). **That reading survives; the universal one does not**, and the sentence as written invites the universal one. Reported as a precision defect a consumer will trip on, not as a mathematical error.

## 7. The surviving conclusion at $n=12$, CONFIRMED

$\theta_0(12)^2=\tfrac{2\cdot11\cdot10}{144}=\tfrac{55}{36}$ against $\theta(S^5\times S^7)^2=\tfrac{264}{175}$. Cross-multiplying, $55\cdot175=9625>9504=264\cdot36$. **Exact, and the decimals the block prints are consistent with it.** The clause "*which is what Conjecture A is about*" is right: [conventions.md](../findings/conventions.md) makes $\Theta_n$ the target of Problem P, and $\Theta_{12}=\theta_0(12)$.

## 8. The conclusion at every $n$, both parities, CONFIRMED AS ALGEBRA, no argument on file

**The claim is true and general.** At fixed $n$, maximising $\theta^2=2/(1+E)$ over two-block splits means minimising $\frac1{p-1}+\frac1{q-1}$ at fixed $(p-1)+(q-1)=n-2$, and $x\mapsto1/x$ is strictly convex, so the minimum is at the balanced split for even $n$ and at $|p-q|=1$ for odd $n$. Evaluating there reproduces $\Theta_n$ exactly in both parities:

- even $n$, $p=q=n/2$: $(n-2)(n-1)+4(n-1)-(n-2)=n^2$, so $\theta^2=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$;
- odd $n$, $p=\tfrac{n-1}2$, $q=\tfrac{n+1}2$: $(n-3)(n-1)+2(n-1)+(n-3)=n^2-n-2=(n-2)(n+1)$, so $\theta^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$, which is [conventions.md](../findings/conventions.md)'s odd-$n$ $\Theta_n$.

**So no sphere product, of any block count, at any $n$, exceeds $\Theta_n$**, the two-block maximum *is* $\Theta_n$, and $k\ge3$ is below $1$. **This is exactly what the record's [L57](../results.md) already says**, sphere products being coordinate-diagonal.

**What the written text licenses.** One tabulated comparison at $n=12$. The block writes "*$\theta_0(12)=1.2360331$ still exceeds $1.2282392$*" and stops. It does not quantify over $n$, it does not name the odd-$n$ competitor, and it does not cite L57, which would have given the whole thing at every $n$ with the equality case. **Per the brief's rule I supply nothing: the general statement has no argument in this block.** The derivation above is my test of the claim, not a repair of the record.

**The odd-$n$ trap bites elsewhere in the same statement.** The statement leans on [L23](../findings/ungraded-slack.md) ("*Lemma L23 shows they are its maximum*") and L23 concludes $\theta\le\theta_0(n)$. At odd $n$, $\theta_0(n)>\Theta_n$ by exactly $\theta_0^2-\Theta_n^2=\frac{8(n-1)}{n^2(n+1)(n-2)}$, so **L23 as stated does not establish that the subalgebra family loses to the actual competitor at odd $n$.** It happens to be true, L23's own integrality gives $r\le\frac{(n-3)(n+1)}4$ at odd $n$, whence $\theta^2\le\frac{2(n-1)(n-3)(n+1)}{n(n^2+3)}$, and $(n+1)^2(n-2)-n(n^2+3)=-6n-2<0$ puts this strictly below $\Theta_n^2$, but that is two lines nobody has written, and the census cites the weaker cap.

## 9. "four lose to both named competitors and one ties", REFUTED AS STATED

**Locate it.** [graded-half.md:69](../findings/graded-half.md): "***Five further families, of which four lose to both named competitors and one ties.***" The one that ties is item 2, Fox's hyper-Kähler subalgebra $\mathbb B$, whose idempotents [problem.md](../findings/problem.md) records as "*a hyper-Kähler-rotated copy of $\mathcal S^4(\alpha)$ itself, all sharing the same $P/\lVert W\rVert^3=\sqrt{3/2}$ value, forming a single orbit*", and [second-order.md](../findings/second-order.md) identifies $\mathcal S^4(\alpha)$ as padded $W_{\mathbb{CP}^2}$.

**Exhibit the failure.** Take $n=8$. Item 2 sits at $\theta=\sqrt{3/2}=1.224745$. The balanced competitor there is $S^4\times S^4$ at $\theta_0(8)^2=\frac{2\cdot7\cdot6}{64}=\frac{21}{16}$, i.e. $\theta_0(8)=\frac{\sqrt{21}}4=1.145644$. Since $\tfrac32>\tfrac{21}{16}$, **item 2 strictly beats one of the two named competitors**, it does not tie both, and it does not lose. The same holds at every $n$ below the crossover $6+2\sqrt7=11.2915$ at even $n$ and $\frac{13+\sqrt{97}}2=11.4244$ at odd $n$, both of which are [results.md](../results.md)'s own figures; [conventions.md](../findings/conventions.md) records the same fact as $M(n)=\sqrt{3/2}>\Theta_n$ at $n=4$ and $n=6$.

**Argue the opposite.** The charitable reading is that the census is implicitly at $n\ge12$, where Conjecture A lives and where $\Theta_n>\sqrt{3/2}$; under it "ties" is correct, since item 2's value equals the padded competitor's and loses to the balanced one. **That reading is available and true, but it is exactly the missing $n$-quantifier that Gate 2 refuted the block for, and the rewrite did not add it.** The rewrite corrected the count and the comparative and left the quantifier defect untouched.

## 10. The two admitted-open classes, REFUTED AS STATED (scoping)

The block writes: "*Four of six are discharged; the open two are the strongly-regular-graph solutions, swept only to $n=200$, and the non-Lie-group simple-isotropy members, whose $(n,r)$ list is nowhere on the record.*"

**The strongly-regular half is not open.** [diagonal-half.md](../findings/diagonal-half.md), Observation L144, carries a Gate 2 correction reading "***THE PRIMITIVE HALF IS NOW PROVED, SO THIS IS A LEMMA*** … **So $\theta<\tfrac12$ for every primitive strongly regular graph, at every $n$, with no census**, … $\tfrac14$ the **sharp, never-attained** supremum, which is what the screened $0.4758$ was approaching", and separately "***THE IMPRIMITIVE HALF, PROVED.*** *Imprimitive strongly regular graphs give $\theta=\sqrt{2(n-1)(g-1)/(n(n-g))}$, maximised uniquely at $g=n/2$, which is the balanced product*". [INDEX-results.md:163](../findings/INDEX-results.md) records the same. Both halves are below $\Theta_n$ at every $n$, uniformly, with no sweep.

**And the census cites neither of the record's own theorems for it.** [L74](../findings/diagonal-half.md) gives $\theta$ *in closed form for every strongly regular graph*, $\theta(\Gamma)=\lvert1+\lambda-\mu\rvert\sqrt{\frac{2(n-1)}{nk(n-1-k)}}$; L144 gives the uniform bound. The statement cites an "*exhaustive parameter sweep to $n=200$*" instead. **This is a third instance of the very fault the block congratulates itself for finding twice** ("*Both eliminations are already theorems on the record, and the census cites neither*") and the block missed it while writing that sentence.

**Argue the opposite.** L144's INDEX row still carries type `Observation` and verdict `GAP`, and [diagonal-half.md](../findings/diagonal-half.md) still holds the superseded "*THE PRIMITIVE HALF, SCREENED AND NOT PROVED*" paragraph directly below the correction that supersedes it. A conservative reader could hold that the promotion has not landed. **On that reading L5's scoping is defensible but its citation is not**: even a screened L144 is a better authority than an uncited sweep, and L74 is unambiguous.

**The simple-isotropy half is scoped correctly**, and the block is right that the $(n,r)$ list is absent. I note only that $0.837$ is the rounding of $\theta=\sqrt{7/10}=0.836660$ at the $\mathfrak{su}(3)$ point, that it is written as a $P$, and that it is a ceiling over an unenumerated population, **HYPOTHESIS-DEBT**, correctly admitted.

## 11. The repair did not reach the consumer, REFUTED

**Locate it.** [results.md:316](../results.md) heads the block "*##### **Lemma** L5, rival critical-point families*" and its first sentence is "*Needed to rule out every other critical-point family found so far. **Six** further families **lose to both named competitors**: …*". [results.md:118](../results.md) repeats "*Lemma L5 (landscape)*".

**Exhibit the failure.** Three separate contradictions, all live:

1. **Label.** [INDEX-results.md:20](../findings/INDEX-results.md) reads "*Gate 2: REFUTED as a Lemma and as a census … **Downgraded to `Observation`***", and [graded-half.md:41](../findings/graded-half.md) heads the block "*Observation L5*". results.md calls it a Lemma twice.
2. **Count and comparative.** graded-half.md's rewritten statement reads "*Five further families, of which four lose to both named competitors and one ties*"; results.md's reads "*Six further families lose to both named competitors*". Two files, one result, contradictory statements.
3. **The provenance note is false for a third time.** The block's own note says the duplication was "*resolved on 2026-09-06 … and now holds the statement alone*". Both files hold a statement, and they disagree. The note has now been wrong in its first clause, wrong in its correction of that clause, and wrong in its claim to have been resolved.

**Argue the opposite.** Nothing in the record designates graded-half.md's line 69 paragraph as the canonical statement, it carries no "canonical statement and proof" heading, unlike [L23](../findings/ungraded-slack.md) and [L9](../findings/graded-half.md) in the same files, so one could argue results.md is still the canonical site and graded-half.md's paragraph is the stray copy. **That makes it worse, not better**: on that reading the canonical statement is the refuted one and the repair is the copy.

**The landscape statement is separately self-contradictory.** [results.md:118](../results.md) reads "*The highest is $\theta(\mathbb{HP}^2)=\sqrt{56/45}\approx1.1155$ … **and one family attains $\sqrt{3/2}$ exactly***". $\sqrt{3/2}=1.2247>1.1155$, so the second clause refutes the first inside one sentence.

## 12. $\ker W\ne0$ and padded objects, GAP

**What the statement says at a padded object.** Nothing, and it cannot: "*found so far*" is undefined, and padding sends every member of every named family to a member at every larger ambient dimension with $\ker W\ne0$ and the same $\theta$ ([conventions.md](../findings/conventions.md): "*Padding commutes with $Q$, and preserves both the norm and $\theta$*"). So the census's population is either finite and silent about padded copies, or closed under padding and infinite at every $n$, and the block never says which. **One of the two "named competitors" is itself a padded object**, so the population and the competitor set meet at a $\ker W\ne0$ point.

**Exhibit the concrete failure.** The printed identity is false at a padded copy read at the ambient dimension. Take $(S^2)^3$ at $n=6$, $\lVert W\rVert^2=\tfrac35$, and pad it into $\mathcal W_8$. The norm is unchanged, but the identity evaluated with $n=8$ returns $\tfrac28+\tfrac18(3-\tfrac17)=\tfrac14+\tfrac5{14}=\tfrac{17}{28}\ne\tfrac35$. **The identity carries an unstated hypothesis that $n=\sum_an_a$ is the support dimension, not the ambient one.**

**Argue the opposite.** The *bound* is immune: at ambient $N>n$ the bracket $\sum_a\frac1{n_a-1}-\frac1{N-1}$ is larger still, so $\theta<\sqrt{2/(k-1)}$ survives either reading. **The conclusion is safe; the identity a consumer would lift out of the block is not.** Recorded as a GAP in the stated hypotheses.

### Withdrawn candidates

- **"The route $\theta=1/(2\lVert W\rVert)$ is unproved."** *Withdrawn.* It is [L46](../findings/problem.md), with a four-line proof in the same file and a recorded factor-of-two correction with a blast-radius note. The defect is that it is uncited at the point of use, which is §2, not that it is absent.
- **"$\mathrm{Alt}$/normalisation mismatch between the two multi-block forms."** *Withdrawn.* The two forms are algebraically identical (§1), so no normalisation is in dispute.
- **"The $\mathbb{HP}^m$ supremum is over $m\le4$ only."** *Withdrawn.* The source block proves it for all $m$; the $m\le4$ restriction lives in the statement and is inert, which is a stale hypothesis rather than a gap.
- **"An imported theorem with a unital-algebra hypothesis."** *Withdrawn.* I looked for one (the brief flags that route) and the only algebra imported here is Fox's, whose use ("*critical points of $P$ are exactly the idempotents*") needs no unit. [algebra.md](../findings/algebra.md) records that the acting group is $O(n)$ rather than $SO(n)$, which is the hypothesis that was actually at risk, and it is checked there.

## What would falsify the surviving statement, and what I did to look for it

**The object.** A critical point in one of the five named families whose $\theta$ exceeds $\Theta_n$ at its own $n$, that is the surviving content, since the block's conclusion is "*these families lose to the balanced product, which is what Conjecture A is about*".

**It exists, and it is on the record.** Item 2, Fox's $\mathbb B$, at $n=8$: $\theta=\sqrt{3/2}=1.224745$ against $\Theta_8=\theta_0(8)=\sqrt{21}/4=1.145644$. It falsifies the statement as written and not under the $n\ge12$ reading, which is §9.

**Where I looked, and what I found instead.** I took one object from each structured family the statement names and tested it in closed form against $\Theta_n$ at its own $n$: the multi-block products at the boundary $k=3$ and the smallest admissible $n=6$ ($\theta^2=\tfrac5{12}$ against $\Theta_6^2=\tfrac{10}9$); the two-block products at every $n$ and both parities, where the maximum *is* $\Theta_n$ (§8), so the family touches the bound and never crosses it; $\mathbb{HP}^m$ at $m=2$, its own maximum, $\sqrt{56/45}=1.115547$ against $\theta_0(8)=1.145644$; the subalgebra family at the odd-$n$ integrality cap $r=\frac{(n-3)(n+1)}4$, strictly below $\Theta_n$ by $(n+1)^2(n-2)-n(n^2+3)=-6n-2$; and the strongly-regular family through [L144](../findings/diagonal-half.md)'s $\theta<\tfrac12$ and the imprimitive closed form. **Every family clears at every $n\ge12$.** The one crossing is item 2 below the crossover, which is the known failure of Conjecture A's bound at small $n$ rather than a new object.

**Where a genuine falsifier would live.** In the one class the block admits and I could not test: the non-Lie-group simple-isotropy members, whose $(n,r)$ list is on no file in [findings/](../findings/). I checked [ungraded-slack.md](../findings/ungraded-slack.md), [graded-half.md](../findings/graded-half.md) and [INDEX-values.md](../findings/INDEX-values.md) for such a list and found none. Constructing one is computation and is reserved.

## Verdict

**GAP.**

The mathematics that survives the earlier refutation is correct, and in three places stronger than the block claims: the multi-block bound holds for every $k$ and every $n$ from the file's own closed form, the quaternionic supremum is proved for all $m$ rather than the $m\le4$ the statement asks for, and the strongly-regular family is closed at every $n$ by a theorem the block calls open. What stands between that and a citable result:

1. **[results.md](../results.md) still carries the refuted statement and the withdrawn `Lemma` label** (§11), the single item a consumer actually reads.
2. **No $n$-quantifier**, and the corrected comparative is false below the crossover (§9).
3. **"whenever $p,q\ge5$" is false** at $(5,5)$, $(5,6)$, $(6,5)$ (§6).
4. **"the open two" is stale** for the strongly-regular half (§10).
5. **Two steps rest on hypotheses stated nowhere at the point of use**: $\theta=1/(2\lVert W\rVert)$ (§2) and $n=\sum_an_a$ in the printed identity (§12).

**What a consumer may cite today**, from the surviving text: $\theta<\sqrt{2/(k-1)}$ for $k$-block sphere products with every $n_a\ge2$, uniformly in $n$; $\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}$; $\theta^2(S^5\times S^7)=\tfrac{264}{175}>\tfrac32$; and the single comparison $\theta_0(12)>\theta(S^5\times S^7)$. **What it may not cite**: any statement of the form "every rival family loses", at any $n$, in any form, the population is still undefined, the quantifier is still absent, and the record's own $n=8$ witness contradicts it.
