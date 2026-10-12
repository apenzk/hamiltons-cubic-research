# Review r330, is Lemma L71 non-vacuous, and does it do anything?

**Reviewer 330, adversarial, cold brief.** Every number below comes from an implementation written from the definitions alone, [scripts/reviewers/r330/](../scripts/reviewers/r330/). It is validated before use by three checks that fix its conventions: $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ at $n=4,5,6$; $I^{\#}=(n-2)I$ to $1.8\times10^{-15}$; and $Q(\mathcal W_n)\subseteq\mathcal W_n$ to $5\times10^{-16}$ on random Weyl tensors, which pins the $\#$ normalisation and the Bianchi/Ricci projector against each other. No script of this record was read. Distance from $\mathcal W_n$ is reported for every point and never exceeds $4\times10^{-15}$.

## Verdicts

| claim | verdict |
| --- | --- |
| **P4(b)**, does Lemma L71 constrain any non-saturating critical point? | **NO. It is a rigidity statement with no route to the conjecture**, but it is not a third "definition restated": it closes the one stratum where [r324](REVIEW_r324.md) forces $\theta\ge\theta_0(n)$, i.e. the only stratum on which a counterexample was *guaranteed* if one existed there |
| **P4(a)**, substantive, or one line from the record? | **Substantive, and narrow.** Its entire increment over the record is the three-line ideal argument; the saturation hypothesis already writes down two thirds of a symmetric decomposition |
| **P4(c)**, a saturating critical point at $n\ge5$ other than a balanced product | **None.** $192$ generic Newton-solved critical points at $n=5,6,7$, minimum defect $0.395$; joint criticality-plus-saturation solve converges nowhere |
| **P1**, the ideal argument | **CONFIRMED**, every link. Two notes: $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ needs no ideal argument at all, and the span/set distinction is harmless |
| **P2**, the consequences | **CONFIRMED**, with one step supplied at $n=8$: Aut-invariance of $\dim\mathfrak g^\theta$ rules out a new *dimension*, not a new *conjugacy class* |
| **P3**, the withdrawals | **Correct, and now complete** for the four deleted paragraphs. **Three surviving claims are false**: the $n=4$ "$\pm$" classification, "saturation forces $\ker W=0$ outright, which is stronger", and the mass law's mixed conventions |

---

## P4, the one that matters

### (b) Lemma L71 constrains no non-saturating critical point. None. Say it plainly

**The hypothesis is an equality, and by the record's own R14 tautology it is an equality on the spectrum.** At a critical point $D(v)=\lvert\lambda_{\min}\rvert\big(\lambda_{\min}+(n-2)\lambda_{\max}-\theta\big)$ identically, reproduced here to $\le8\times10^{-15}$ at every critical point tested, and failing by $0.16$–$0.46$ at non-critical diagonal Weyl tensors, as it must. So "saturating" is $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$, and Lemma L71 governs exactly the locus where that holds with equality. Off it the lemma has no content, and there is no mechanism in it that degrades gracefully: it has no quantitative form, and the quantitative form one would want ($D$ small $\Rightarrow$ $\theta$ near $\theta_0$), is precisely the statement [Reviewer 323](REVIEW_r323.md) showed to be Conjecture A with the same terms subtracted from both sides.

**And the locus is a single orbit.** By Lemma L71 itself the saturating critical set is one $O(n)$-orbit at even $n\ge6$ and empty at odd $n\ge5$. A theorem whose hypothesis cuts the critical set down to one orbit cannot bound anything on the rest of it.

**The deficiency does not even order $\theta$, which is the sharpest way to see there is no route.** At $n=12$, $S^3\times S^9$ and the maximal torus $\mathfrak{so}(2)^6$ are both genuine critical points ($\lVert Q(W)-\theta W\rVert\le4.3\times10^{-15}$, distance from $\mathcal W_{12}\le3.1\times10^{-15}$) carrying the **identical** defect $3.425395354$, at $\theta=1.141798$ and $\theta=0.428174$, a factor $2.67$ apart. And the defect is not monotone in $\theta$ across the family at all:

| $n=12$ critical point | defect $\lambda_{\min}+(n-2)\lambda_{\max}-\theta$ | $\theta$ |
| --- | --- | --- |
| $S^6\times S^6$ | $0.000000000$ | $1.236033$ |
| $S^5\times S^7$ | $0.614119579$ | $1.228239$ |
| $S^4\times S^8$ | $1.602081979$ | $1.201562$ |
| $S^3\times S^9$ | $3.425395354$ | $1.141798$ |
| maximal torus | $3.425395354$ | $0.428174$ |
| padded $W_{\mathbb{CP}^2}$ | $6.531972647$ | $1.224745$ |

The competitor that actually matters at $n=12$ (padded $W_{\mathbb{CP}^2}$ at $\theta=\sqrt{3/2}$), sits at the **largest** defect in the table. Whatever the deficiency measures, proximity to the extremiser is not it.

**What Lemma L71 does buy, and it is worth stating positively.** [r324](REVIEW_r324.md) proves $D=0\Rightarrow\theta\ge\theta_0(n)$. That inequality points the wrong way for the conjecture: any saturating critical point with three or more eigenvalues would have $\theta>\theta_0(n)$ and would *be* a counterexample. Lemma L71 proves the stratum is empty of such points at every $n\ge5$. So it eliminates a class of would-be counterexamples rather than restating a definition, which is more than [route R14](../findings/bounds.md) or the LP sharpness table did, and is the honest reason to keep it. It is a rigidity theorem that closes a stratum, and it is not a step toward the conjecture.

### (a) Substantive, and narrow, the increment is three lines

**The saturation hypothesis already carries most of the conclusion.** $D(v)=0$ for all $v\in\mathfrak m$ says $c_{vab}=0$ unless $\{\lambda_a,\lambda_b\}=\{\lambda_{\min},\lambda_{\max}\}$, i.e. $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak r]=0$. That is two thirds of a $\mathbb Z_2$-grading written down as a hypothesis. Everything the record needs after it (Lemma L23's admissibility cap, the two-eigenvalue formula, Cartan's classification), was already on file, and [Lemma L69](../findings/graded-half.md) had the conclusion under a two-eigenvalue hypothesis.

**So the whole increment is the ideal argument**, which removes that hypothesis. It is genuinely new, it consumes an input the record had not used at this point (simplicity of $\mathfrak{so}(n)$), and its conclusion is not equivalent to its hypothesis. It is therefore **not** a third instance of the R14 pattern. But it is three lines, and the record should describe it as three lines rather than as a proof whose length is the concatenation of everything it cites.

### (c) No saturating point outside the family. Reported as supporting evidence, not as the deliverable

Per the coordinator's instruction the search was bounded once the theorem was proved twice. What it covered:

| where | points | criticality residual | distance from $\mathcal W_n$ | minimum defect found |
| --- | --- | --- | --- | --- |
| $n=5$, random multistart | $120$ genuine critical points | $\le3\times10^{-14}$ | $\le5\times10^{-16}$ | $0.394806$ |
| $n=6$, random multistart | $60$ | $\le2.5\times10^{-14}$ | $\le1.1\times10^{-15}$ | $0.857444$ |
| $n=7$, random multistart | $12$ | $\le2.5\times10^{-14}$ | $\le1.3\times10^{-15}$ | $1.101291$ |
| structured families, $n=5,6,8,10,12$ | balanced and unbalanced $S^p\times S^q$, $\mathfrak u(n/2)$ ($\mathbb{CP}^m$), maximal tori, $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$, padded $W_{\mathbb{CP}^2}$, diagonal | $\le5.2\times10^{-15}$ at the critical ones | $\le4\times10^{-15}$ | $0$ at the balanced products only |

A joint least-squares solve on $\big(\text{criticality},\ \text{defect}\big)$ converged to nothing at $n=5,6,7$, which is the expected behaviour at odd $n$ and at $n=6$ away from $S^3\times S^3$. The structured families reproduce the record's own numbers independently: tori defects $1.290994,\,2.160247,\,2.846050,\,3.425395$ at $n=6,8,10,12$; $\mathrm{ad}(\mathfrak{su}(3))$ at $0.836660$; $\theta$ at $\mathbb{CP}^3,\mathbb{CP}^4,\mathbb{CP}^5$ of $1.054093,\,0.986013,\,0.948683$; padded $W_{\mathbb{CP}^2}$ carrying $D=(n-4)/3$ **exactly** at $n=5,6,8,10,12$.

---

## P1, the ideal argument is airtight

**Every link checked, and each holds.**

- **The support statement.** $\operatorname{tr}W=0$ and $W\ne0$ give $\lambda_{\min}<0<\lambda_{\max}$ ($\lambda_{\max}=0$ would force $W\preceq0$ with zero trace). Then $\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}$ forces $\{\lambda_a,\lambda_b\}=\{\lambda_{\min},\lambda_{\max}\}$: same signs give $\lambda_a\lambda_b\ge0>\lambda_{\min}\lambda_{\max}$, and for $\lambda_a<0\le\lambda_b$ one has $\lvert\lambda_a\lambda_b\rvert\le\lvert\lambda_{\min}\rvert\lambda_{\max}$ with equality only at both ends. So the three displayed inclusions are exact, not merely sufficient.
- **Span or set?** $[\mathfrak m,\mathfrak m]$ must be read as the **span**, and the Jacobi step survives it. $[x,[a,b]]=[[x,a],b]+[a,[x,b]]$ lands in the span for each generator $[a,b]$, and $\mathrm{ad}(x)$ is linear, so it lands in the span on all of it. The same for $[\mathfrak m,[\mathfrak m,\mathfrak m]]\subseteq\mathfrak m$ and $[\mathfrak r,[\mathfrak m,\mathfrak m]]=0$. Nothing in the chain needs the set of brackets.
- **Is "every summand maps $\mathfrak g'$ into $\mathfrak g'$" enough?** Yes, and the fact that $\mathfrak g'$ is built from two of the three summands is irrelevant. An ideal is $[\mathfrak{so}(n),\mathfrak g']\subseteq\mathfrak g'$; $\mathfrak m+\mathfrak h+\mathfrak r$ spans $\mathfrak{so}(n)$ and the bracket is bilinear. The six checks needed are $[\mathfrak m,\mathfrak m]$, $[\mathfrak m,[\mathfrak m,\mathfrak m]]$, $[\mathfrak h,\mathfrak m]$, $[\mathfrak h,[\mathfrak m,\mathfrak m]]$, $[\mathfrak r,\mathfrak m]$, $[\mathfrak r,[\mathfrak m,\mathfrak m]]$, and all six are on the page.
- **The closing step.** $\mathfrak g'=\mathfrak m\oplus[\mathfrak m,\mathfrak m]$ is orthogonal because $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\perp\mathfrak m$; $\mathfrak g'=\mathfrak{so}(n)$ then gives $\dim[\mathfrak m,\mathfrak m]=\dim\mathfrak h+\dim\mathfrak r$ against $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, forcing $\mathfrak r=0$ and $[\mathfrak m,\mathfrak m]=\mathfrak h$.
- **Simplicity.** $\mathfrak{so}(n)$ is simple for every $n\ge5$, $n=6$ included, $\mathfrak{so}(6)\cong\mathfrak{su}(4)$ is simple, and $\mathfrak{so}(8)$ is simple, triality being an outer automorphism. The record's "$\mathfrak{so}(n)$ is simple for $n\ge5$" is true; "for **exactly** $n\ge5$" would not be, since $\mathfrak{so}(3)\cong\mathfrak{su}(2)$ is simple too. The record does not write "exactly", so nothing turns on it.
- **Is $\mathfrak m\ne0$ guaranteed?** Yes, and without reference to the sign of $\theta$. $\lVert W\rVert=1$ and $\operatorname{tr}W=0$ give $\lambda_{\min}<0$, so $E_{\min}\ne0$.

**One simplification the record misses.** Defect (ii) ($[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$), does not need $\mathfrak h=[\mathfrak m,\mathfrak m]$ or the ideal argument. It is one line from $\mathrm{ad}$-invariance: for $x,y\in\mathfrak h$ and $a\in\mathfrak m$, $\langle[x,y],a\rangle=-\langle y,[x,a]\rangle=0$ because $[x,a]\in[\mathfrak h,\mathfrak m]\subseteq\mathfrak m\perp y$. The same one line gives $[\mathfrak h,\mathfrak r]\perp\mathfrak m$ and $[\mathfrak r,\mathfrak r]\perp\mathfrak m$, so $\mathfrak h\oplus\mathfrak r$ is a subalgebra and $\mathfrak{so}(n)=(\mathfrak h\oplus\mathfrak r)\oplus\mathfrak m$ is a symmetric pair **before** any simplicity is used. Recording the repair as downstream of the ideal argument makes the write-up look more entangled than it is.

**Verified numerically at the saturating points**, from my own structure constants in the eigenbasis: $\lVert[\mathfrak m,\mathfrak m]\text{ off }\mathfrak h\rVert^2\le1.1\times10^{-27}$ and $\lVert[\mathfrak m,\mathfrak h]\text{ off }\mathfrak m\rVert^2\le9.7\times10^{-28}$ at the balanced products $n=6,8,10,12$ and at both $n=4$ saturating points; $\dim\mathfrak m/\dim\mathfrak h=9/6,\,16/12,\,25/20,\,36/30$ and $\dim\mathfrak r=0$. The control behaves as it must: the $n=6$ maximal torus puts $48$ of $96$ units of $\mathfrak m$-row mass off $\mathfrak m\times\mathfrak h$.

---

## P2, the consequences hold, with one step supplied at $n=8$

**The arithmetic is right.** $\operatorname{tr}W=0$ with two eigenvalues gives $\dim\mathfrak m\lvert\lambda_{\min}\rvert=\dim\mathfrak h\lambda_{\max}$; with $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$ and $\dim\mathfrak m+\dim\mathfrak h=n(n-1)/2$ this gives $\dim\mathfrak m=n^2/4$ and $\dim\mathfrak h=n(n-2)/4$. The $t$-identity checks: $\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))=\tfrac12(p^2+q^2-n)=\tfrac{n^2}4+t^2-\tfrac n2$, and the target $\tfrac{n^2}4-\tfrac n2$ forces $t=0$ at every even $n$ at once. $\mathfrak u(n/2)$ has dimension $n^2/4$, off by $n/2$. Odd $n$: $n^2/4\notin\mathbb Z$, so no critical point saturates, confirmed by the $n=5$ and $n=7$ searches finding nothing.

**Is the list of symmetric pairs complete?** For $n\ne8$, yes and for the stated reason: $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$, so every involution is $\mathrm{Ad}(g)$ with $g^2=\pm1$; $g^2=1$ gives $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $g^2=-1$ gives $\mathfrak u(n/2)$. Nothing else.

**At $n=8$ the record's justification proves less than the step needs.** "$\dim\mathfrak g^\theta$ is an $\mathrm{Aut}$-invariant, so triality can never produce a new dimension" is true and gives what it says: the fixed dimensions available at $n=8$ are $21,16,13,12$, so the target $12$ still picks out one dimension. But the lemma identifies $\mathfrak h$ as *the subalgebra* $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$, not merely as *a subalgebra of dimension $12$*, and a triality image of $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ would have dimension $12$ while possibly not being $O(8)$-conjugate to it. **The missing step, and it holds:** $\mathfrak{so}(4)\oplus\mathfrak{so}(4)\cong\mathfrak{su}(2)^{\oplus4}$ acts on each of the three $8$-dimensional representations of $\mathrm{Spin}(8)$ as $(2,2,1,1)\oplus(1,1,2,2)$ (vector, and both half-spin) so its triality images act on $\mathbb R^8$ as $\mathbb R^4\oplus\mathbb R^4$ again and are $O(8)$-conjugate to it. The class is triality-stable, and the identification is safe. Supply that sentence; the current one does not reach the conclusion.

**And $\mathfrak h$ determines $W$.** Two eigenvalues, $\operatorname{tr}W=0$ and $\lVert W\rVert=1$ leave $W=c\big(\Pi_{\mathfrak h}-\tfrac{\dim\mathfrak h}{N}I\big)$ with $c>0$ fixed, which is exactly what my $\mathcal W_n$-projection of $\Pi_{\mathfrak{so}(m)\oplus\mathfrak{so}(m)}$ returns: $\theta=1.054092553,\,1.145643924,\,1.200000000,\,1.236033081=\theta_0(n)$ at $n=6,8,10,12$, defect $0.000000000$. So "$\theta=\theta_0(n)$ exactly" and "r324's inequality is never strict at $n\ge5$" are confirmed.

---

## P3, the withdrawals are correct; three surviving claims are not

### The four withdrawals

All four are correct, and the deletion of the four stale paragraphs closes the leftovers. **(i)** With $\mathfrak r=0$ hypothesised, "exactly two eigenvalues" is that hypothesis restated, circular, correctly withdrawn. **(ii)** $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ was indeed used and never derived; the repair is valid, and simpler than stated (above). **(iii)** Both uniqueness routes terminate in Cartan's classification of the involutions of $\mathfrak{so}(n)$; they are not independent. **(iv)** Mass counting alone gives only the residue $\ge0$, i.e. $\dim\mathfrak m\le2\dim\mathfrak h$, confirmed, and it is exactly $n\ge4$ that this expresses.

### REFUTED, the $n=4$ classification, "$\pm S^2\times S^2$ and $\pm W_{\mathbb{CP}^2}$"

**Saturation is not sign-invariant, and both sign-flips are strictly slack.** If $Q(W)=\theta W$ then $Q(-W)=W^2+W^{\#}=(-\theta)(-W)$, so $-W$ is a genuine critical point; but $\lambda_{\min}(-W)=-\lambda_{\max}(W)$, so the defect is $-\lambda_{\max}+(n-2)\lvert\lambda_{\min}\rvert+\theta$, a different number.

| $n=4$ critical point | criticality residual | $\theta$ | defect |
| --- | --- | --- | --- |
| $W_{\mathbb{CP}^2}$ | $2.2\times10^{-16}$ | $+1.224744871$ | $+0.000000000$ |
| $S^2\times S^2$ | $3.1\times10^{-15}$ | $+0.866025404$ | $-6.7\times10^{-16}$ |
| $-W_{\mathbb{CP}^2}$ | $2.2\times10^{-16}$ | $-1.224744871$ | $+1.224744871$ |
| $-(S^2\times S^2)$ | $3.1\times10^{-15}$ | $-0.866025404$ | $+0.866025404$ |

**Repair:** *the saturating critical points at $n=4$ are exactly $W_{\mathbb{CP}^2}$ and $S^2\times S^2$ (the $\theta>0$ representatives) and nothing else.* If the record's convention normalises to $\theta>0$ then the "$\pm$" is redundant; if it does not, the "$\pm$" is false. Either way it should go.

**The $n=4$ classification is complete, and I can give it in closed form rather than by search.** $\mathcal W_4=\mathrm{Sym}^2_0(\Lambda^2_+)\oplus\mathrm{Sym}^2_0(\Lambda^2_-)$; the two $\mathfrak{so}(3)$ factors commute, so $\#$ acts blockwise, and on each block the structure constants are $c=\kappa\varepsilon$ with $\kappa^2=2$ **exactly** (measured $\kappa=\mp1.414213562$, deviation from $\kappa\varepsilon$ of $0.0$), making $A^{\#}=2\,\mathrm{cof}(A)$. Criticality is $a_i^2+2a_ja_k=\theta a_i$, whose difference of two equations is $(a_i-a_j)(3a_k+\theta)=0$; all three distinct is impossible, so each block is $0$ or $\tfrac\theta3\mathrm{diag}(-1,-1,2)$. Unit norm then leaves exactly two orbits up to sign: one block nonzero at $\theta^2=3/2$ ($W_{\mathbb{CP}^2}$), both nonzero at $\theta^2=3/4$ ($S^2\times S^2$). Four critical points up to $O(4)$; two saturate. A $4000$-start solve over the full $10$-dimensional $\mathcal W_4$ converges $4000/4000$ times and returns exactly these four spectra, no fifth.

### REFUTED AS STATED, "saturation forces $\ker W=0$ outright, which is stronger than either"

$\ker W\subseteq\mathfrak r$, because $0$ is neither $\lambda_{\min}<0$ nor $\lambda_{\max}>0$. So "$\ker W=0$" is an immediate **corollary** of the lemma's own conclusion $\mathfrak r=0$, and is strictly **weaker** than it, $\mathfrak r=0$ implies $\ker W=0$ and not conversely. And it is **false at $n=4$**: $W_{\mathbb{CP}^2}$ saturates with $\dim\ker W=3$, spectrum $(2,-1,-1,0,0,0)/\sqrt6$, which is the record's own witness. **Repair:** *for $n\ge5$, $\mathfrak r=0$ and hence $\ker W=0$; at $n=4$ the saturating $W_{\mathbb{CP}^2}$ has $\ker W=\mathfrak r$ of dimension $3$.*

### REFUTED AS STATED, the mass law mixes two conventions in one display

The stated premise is right: at saturation **the rows through $\mathfrak m$** are supported on $(\mathfrak m,\mathfrak m,\mathfrak h)$, and $T$ itself is not, confirmed, off-support mass $12,48,120,240$ at the balanced products. But the two displayed quantities are computed in **different** conventions, and only one can be right at a time.

| quantity | ordered convention (the one the display states, row mass $2(n-2)$) | halved convention (row mass $n-2$) | what the record prints |
| --- | --- | --- | --- |
| $M$, $\mathfrak m$-row mass, $n=6,8,10,12$ | $72,192,400,720=2\dim\mathfrak m(n-2)$ | $36,96,200,360=\dim\mathfrak m(n-2)$ | $36,96,200,360$ |
| residue, $\mathfrak h$-rows off $\mathfrak m\times\mathfrak m$ | $12,48,120,240=(n-2)(2\dim\mathfrak h-\dim\mathfrak m)$ | $6,24,60,120$ | $12,48,120,240$ |

**Repair:** state the row mass once and keep it. With the ordered convention the display reads $M=2\dim\mathfrak m\,(n-2)$ and residue $=(n-2)(2\dim\mathfrak h-\dim\mathfrak m)=\dim\mathfrak h(n-4)$; with the halved convention, $M=\dim\mathfrak m(n-2)$ and residue $=\dim\mathfrak h(n-4)/2$. The derivation itself is sound in the ordered convention and reproduces exactly: $\mathfrak h$-row mass on $\mathfrak m\times\mathfrak m$ measures $36,96,200,360=(n-2)\dim\mathfrak m$ against $\mathfrak h$-row totals $48,144,320,600$.

**And one parenthetical in the same paragraph is false.** "*the off-support mass is $12,48,120,240$ at the balanced products and $12$ at $W_{\mathbb{CP}^2}$, which is exactly the residue below*", at $W_{\mathbb{CP}^2}$ the off-$(\mathfrak m,\mathfrak m,\mathfrak h)$ mass is $12.0$ while the residue is $0.0$, as the record's own next sentence says. They coincide only when $\mathfrak r=0$; at $W_{\mathbb{CP}^2}$ the $12$ is carried entirely by $\mathfrak r$'s own rows, $\mathfrak r$ being the second $\mathfrak{so}(3)$ factor. **Repair:** off-support mass $=$ residue $+$ $\mathfrak r$'s row mass, equal to the residue exactly when $\mathfrak r=0$.

### The ratio debt, a second derivation, and what it costs

I derived $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$ independently of [r324](REVIEW_r324.md), from the mass split plus criticality on the $\mathfrak h$ rows. Write $k=n-2$, $t=\lambda_{\max}/\lvert\lambda_{\min}\rvert$. Criticality gives $\langle u,W^{\#}u\rangle=\lambda_{\max}(\theta-\lambda_{\max})$ for unit $u\in\mathfrak h$, and $\langle u,W^{\#}u\rangle=\tfrac12\sum\lambda_a\lambda_bc_{uab}^2$. With $\mathfrak r=0$ the $\mathfrak h$ rows split into an $\mathfrak m\times\mathfrak m$ part of total mass $k\dim\mathfrak m$ and the rest, so summing over $\mathfrak h$ and using $\dim\mathfrak m\lvert\lambda_{\min}\rvert=\dim\mathfrak h\lambda_{\max}$ gives $\tfrac12k(1+2t-t^2)=kt-t-1$, i.e. $k(1-t)=-2$ and $t=n/(n-2)$.

**This does discharge the debt, and it is not independent of the ideal argument**, it uses $\mathfrak r=0$, which is Lemma L71's own conclusion. There is no circularity (ideal argument $\to\mathfrak r=0\to$ ratio $\to$ dimensions), but the record should not present it as a check *on* the ideal argument. The record's withdrawal is correctly scoped: mass counting **alone** yields only $\dim\mathfrak m\le2\dim\mathfrak h$; mass counting **plus criticality on the $\mathfrak h$ rows** yields the ratio.

---

## What I would change in the record

- **Delete the "$\pm$" from the $n=4$ classification** and say $W_{\mathbb{CP}^2}$ and $S^2\times S^2$. Add that the closed-form solve of $a_i^2+2a_ja_k=\theta a_i$ classifies $\mathcal W_4$ outright, so "complete" is a theorem there rather than a search result.
- **Scope "$\ker W=0$" to $n\ge5$** and record it as a corollary of $\mathfrak r=0$, not as something stronger.
- **Pick one mass-law convention.** As printed, $M$ and the residue differ by a factor $2$ in what they count.
- **Fix the $W_{\mathbb{CP}^2}$ parenthetical**: off-support mass equals the residue only when $\mathfrak r=0$.
- **Supply the triality-stability sentence at $n=8$**; Aut-invariance of $\dim\mathfrak g^\theta$ does not by itself pin the conjugacy class.
- **Say in Lemma L71's own entry that it constrains no non-saturating critical point**, and that its value is the elimination of the stratum on which [r324](REVIEW_r324.md) forces $\theta\ge\theta_0(n)$. Without that sentence a reader will take a rigidity theorem for progress on the conjecture, which is the failure mode this record has hit twice this week.
