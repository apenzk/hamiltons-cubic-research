# Review r325, the diagonal-criticality LP, the bracket-coordinate rewriting, and the deficiency marginals

Reviewer 325, adversarial, cold brief. Everything below was recomputed from the definitions in a fresh library, [lib325.py](../scripts/reviewers/r325/lib325.py) and [lp325.py](../scripts/reviewers/r325/lp325.py); no repository script is imported and no repository number was taken on trust. [Lemma L70](../findings/bounds.md) is taken as given, per the brief, and what was built on it is what is audited.

**Calibration.** The normalisation was fixed independently, by requiring $\sum_{a,b}c_{vab}^2=2(n-2)$ for unit $v$, which forces $\Lambda^2\mathbb R^n=\mathfrak{so}(n)$ with $\varphi_{ij}=E_{ij}-E_{ji}$, $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(XY)$ and the matrix commutator, and it then reproduces $\theta_0(n)$ at the balanced sphere products to $10^{-16}$ with no further tuning. Every catalogued point was rebuilt: $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$, the maximal torus, $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$, padded $W_{\mathbb{CP}^2}$, $\mathbb{CP}^m$ from the Kähler curvature tensor, and the Einstein products $S^p\times S^q$. All pass the $\mathrm{Weyl}_n$ screen (Bianchi and Ricci residuals $\le9\times10^{-16}$) and all reproduce the record's $\theta$: $0.645497/0.540062/0.474342/0.428174$ at the tori, $0.836660$ at $\mathrm{ad}(\mathfrak{su}(3))$, $1.115547$ at $S^3\times S^5$, $1.228239$ at $S^5\times S^7$, $1.224745$ at padded $W_{\mathbb{CP}^2}$.

| claim | verdict |
| --- | --- |
| **I4, the sharpness is informative** | **REFUTED.** The table shows a known critical point satisfying its own constraints. At the balanced spectrum every new constraint is inert: [Lemma L70](../findings/bounds.md)'s single $\lambda_{\min}$ row already returns $\theta_0(n)$ exactly |
| I3, the sharpness table | **CONFIRMED to the digit, and the maximum is EXACTLY $\theta_0$, proved.** The reading placed on it is the I4 refutation. Two additions: a closed form for the two-value case, and the "not merely pinned" evidence points the other way |
| I2, criticality in bracket coordinates | **REFUTED AS STATED.** The matrix identity is criticality verbatim, but the record's "i.e." rendering is strictly weaker and holds exactly at nine non-critical points, one of them at $\theta=1.238486>\theta_0(12)$ |
| I1, the marginals are inert | **CONFIRMED**, every number and every constraint. The dichotomy is an artefact, and the exact criterion is $2\min(\dim E_{\max},\dim E_{\min})\ge n-2$ |

---

## I4, is the sharpness informative? **REFUTED**

The record's reading is that the diagonal criticality relations are "sharp on the equality family", that this is "the property [post F34](../findings/fence-posts.md) closes routes for lacking", and that this is "the first relaxation on this record that is NOT lossy at the extremum". Three independent findings say the reading is not justified.

### (i) At the balanced spectrum the new relaxation is entirely inert, Lemma L70 alone returns $\theta_0$

At the balanced product's spectrum, $\lambda_{\max}=1/\sqrt{(m-1)(2m-1)}$ and $\lambda_{\min}=-\sqrt{m-1}/(m\sqrt{2m-1})$ with $n=2m$, so

$$\lambda_{\min}+(n-2)\lambda_{\max}=\frac{m(2m-2)-(m-1)}{m\sqrt{(m-1)(2m-1)}}=\frac{(m-1)(2m-1)}{m\sqrt{(m-1)(2m-1)}}=\frac{\sqrt{(m-1)(2m-1)}}{m}=\theta_0(n).$$

**[Lemma L70](../findings/bounds.md)'s own one-line bound is already exactly $\theta_0(n)$ at that spectrum**, at every $n$, which the record states itself, as "slack $0.000000000$" in the salvage-equality table. Confirmed numerically at $n=6,8,10,12$: $1.054092553$, $1.145643924$, $1.200000000$, $1.236033081$.

So the headline number of the $455$-, $3276$-, $14190$- and $45760$-variable LP is a quantity the record already had, from one row and one inequality.

### (ii) The constraint-drop study: nothing in the new machinery is load-bearing at that point, and everything is load-bearing elsewhere

LP maximum at $n=6$ under successive weakenings ([the drop study](../scripts/reviewers/r325/lib325.py) drives the same LP with rows removed and with $T$ no longer required totally symmetric):

| point | $\theta$ | Lemma L70 | full LP | $T$ not symmetric | $E_{\min}$ rows only | $E_{\max}$ rows only |
| --- | --- | --- | --- | --- | --- | --- |
| $S^3\times S^3$ | $1.054093$ | $1.054093$ | $1.054093$ | $1.054093$ | $1.054093$ | $1.581139$ |
| maximal torus | $0.645497$ | $1.936492$ | **$0.645497$** | $1.936492$ | $1.936492$ | $2.581989$ |
| $\mathbb{CP}^3$ | $1.054093$ | $3.162278$ | **$1.054093$** | $1.054093$ | $3.162278$ | $1.054093$ |
| padded $W_{\mathbb{CP}^2}$ | $1.224745$ | $2.857738$ | **$1.224745$** | $1.632993$ | $2.857738$ | $1.632993$ |

Read the first row: with $T$ stripped of total symmetry and every row but $E_{\min}$'s discarded (which is Lemma L70 and nothing else), the LP still returns $\theta_0(6)$. Read the others: the row coupling, the total symmetry of $T$, or both, are what carry the bound down from $1.94$/$3.16$/$2.86$ to the true $\theta$.

**The new machinery is load-bearing at every catalogued point except the one the headline table uses.** That is the exact inversion of the selection the record made.

*A corollary the record states backwards.* "Every previous relaxation overshoots here" is false for Lemma L70, which is the record's own most recent relaxation and equals $\theta_0$ at that spectrum exactly.

### (iii) The relaxation is exact on the whole catalogue and lossy off it, so "sharp at the extremum" separates nothing

The LP maximum equals the true $\theta$ at **every** catalogued critical point tested, seventeen of them, criticality residual $\le3\times10^{-16}$ throughout:

| $n$ | point | $\theta$ | LP max | LP min | $\theta-\theta_0(n)$ |
| --- | --- | --- | --- | --- | --- |
| $6$ | $\mathbb{CP}^3$ | $1.054092553$ | $1.054092553$ | $1.054092553$ | $0$ |
| $6$ | $S^2\times S^4$ | $0.968245837$ | $0.968245837$ | $0.968245837$ | $-0.085847$ |
| $6$ | $S^3\times S^3$ | $1.054092553$ | $1.054092553$ | $0.175682092$ | $0$ |
| $6$ | maximal torus | $0.645497224$ | $0.645497224$ | $0.645497224$ | $-0.408595$ |
| $6$ | padded $W_{\mathbb{CP}^2}$ | $1.224744871$ | $1.224744871$ | $1.224744871$ | $+0.170652$ |
| $8$ | $\mathbb{CP}^4$ | $0.986013297$ | $0.986013297$ | $0.986013297$ | $-0.159631$ |
| $8$ | $S^3\times S^5$ | $1.115546702$ | $1.115546702$ | $-0.055777335$ | $-0.030097$ |
| $8$ | $S^4\times S^4$ | $1.145643924$ | $1.145643924$ | $-0.190940654$ | $0$ |
| $8$ | maximal torus | $0.540061725$ | $0.540061725$ | $0.540061725$ | $-0.605582$ |
| $8$ | $\mathrm{ad}(\mathfrak{su}(3))$ | $0.836660027$ | $0.836660027$ | $0.250998008$ | $-0.308984$ |
| $8$ | padded $W_{\mathbb{CP}^2}$ | $1.224744871$ | $1.224744871$ | $1.224744871$ | $+0.079101$ |
| $10$ | $\mathbb{CP}^5$ | $0.948683298$ | $0.948683298$ | $0.948683298$ | $-0.251317$ |
| $10$ | $S^4\times S^6$ | $1.185854123$ | $1.185854123$ | $-0.355756237$ | $-0.014146$ |
| $10$ | maximal torus | $0.474341649$ | $0.474341649$ | $0.474341649$ | $-0.725658$ |
| $12$ | $\mathbb{CP}^6$ | $0.924962462$ | $0.924962462$ | $0.924962462$ | $-0.311071$ |
| $12$ | $S^5\times S^7$ | $1.228239158$ | $1.228239158$ | $-0.541010105$ | $-0.007794$ |
| $12$ | $S^6\times S^6$ | $1.236033081$ | $1.236033081$ | $-0.576815438$ | $0$ |

Losslessness runs from $\theta=0.428174$, $0.81$ *below* $\theta_0(12)$, to $\theta=1.224745$, which is *above* $\theta_0(n)$ at $n=6,8,10$. A relaxation that is exact at a point exceeding $\theta_0$ cannot be used to prove $\theta\le\theta_0$, and a relaxation that is equally exact $0.8$ below the extremum is not detecting the extremum.

And off the catalogue it is not sharp at all. Twenty-five Newton-solved **genuine** critical points of $\mathrm{Weyl}_6$ (criticality residual $\le4\times10^{-13}$, $\ker W=0$, all distinct spectra):

| statistic | value |
| --- | --- |
| LP max $-\ \theta$, range | $+0.497$ to $+1.008$ |
| worst case | $\theta=0.013820478$, LP max $=1.021622161$ (a factor of $74$) |
| typical | $\theta\approx0.10$, LP max $\approx0.85$ |

So the answer to the brief's (c) is the plain one. **The table shows that a known critical point satisfies its own constraints, and that at that particular spectrum the constraints leave no room above it.** "Sharp on the equality family" is a catalogue property, it holds at the tori, at $\mathrm{ad}(\mathfrak{su}(3))$, at every $\mathbb{CP}^m$, at every unbalanced Einstein product and at padded $W_{\mathbb{CP}^2}$, and fails by up to $+1.0$ at generic critical points. It is the same trap [post F40](../findings/fence-posts.md)'s own correction names: *"the separator separates the symmetric catalogue from generic points, which is what the catalogue already is."*

### (a) Where it overshoots $\theta_0(n)$, and by how much

| family | result |
| --- | --- |
| catalogued critical points | overshoot only at padded $W_{\mathbb{CP}^2}$: $+0.170652$, $+0.079101$, $+0.024745$ at $n=6,8,10$; $-0.011288$ at $n=12$ |
| unbalanced Einstein products $S^p\times S^q$ | no overshoot; the LP returns $\theta$ exactly at each, all below $\theta_0$ |
| two-value spectra (below) | no overshoot; the maximum over the family is exactly $\theta_0(n)$ |
| random trace-$0$ unit spectra, $n=6$ | $16\%$ exceed $\theta_0$, worst $+0.192461$; $20\%$ are LP-infeasible |
| random trace-$0$ unit spectra, $n=8$ | $51\%$ exceed, worst $+0.235228$ |
| random trace-$0$ unit spectra, $n=12$ | $93\%$ exceed, worst $+0.208708$ |
| kernel-heavy random spectra, $n=8$ | $50\%$ exceed, worst $+0.965148$ |

Realisability is untested for the random rows and they are screening only. The catalogued rows are not: padded $W_{\mathbb{CP}^2}$ is a genuine critical point in $\mathrm{Weyl}_n$ and the LP is exact there, above $\theta_0(n)$ at three of four dimensions.

### (b) Is the tightness forced by the multiplicity structure alone? Partly, and the part that is not is the symmetric-pair structure, not criticality

**A theorem, and it settles the sub-question.** At a two-value spectrum ($p$ with multiplicity $r$, $-q$ with multiplicity $s$, $r+s=N$) the full $\binom I3$-variable LP has exactly the same value as a **four-variable** LP in the aggregate triple-type masses $X_{+++},X_{++-},X_{+--},X_{---}$. The reason is symmetry: $S_r\times S_s$ acts on the constraint set and fixes the objective, so averaging a feasible $T$ over the group gives a feasible $T$ constant on the four orbits with the same $\theta$. Solving that LP in closed form, with $t=rp=sq$,

$$X_{++-}=\frac{t\big((n-1)q-\theta\big)}{(p+q)^2},\qquad X_{+--}=\frac{t\big(\theta+(n-1)p\big)}{(p+q)^2},$$

so $X_{++-}\ge0$ gives $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ and $X_{---}\ge0$ gives $\theta\le s(n-2)(p+q)^2/t-(2p+q)(n-1)$. Agreement with the full LP is exact at all $27$ two-value spectra at $n=8$ and all $14$ at $n=6$, to nine digits.

At the **balanced** multiplicities $r=n(n-2)/4$, $s=n^2/4$, **both** bounds evaluate to $\sqrt{(m-1)(2m-1)}/m=\theta_0(n)$, verified symbolically for every $m$. And the true $T$ of the balanced product has $X_{++-}=X_{---}=0$ exactly (measured: $12/0/36/0$ at $n=6$, $48/0/96/0$ at $n=8$), because $\mathfrak h$ is a subalgebra and $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair. **The two LP constraints that produce the bound are precisely the two Lie-theoretic vanishings, and they are active at the true $T$.** That is what "sharp" means here: the true $T$ is an optimal vertex of its own LP.

Two consequences.

- Over the whole two-value family the LP maximum is $\min$ of an increasing and a decreasing branch, crossing exactly at the balanced multiplicities, so the maximum over the family is $\theta_0(n)$ attained only there. Confirmed at $n=6$ ($r=3\ldots12$) and $n=8$ ($r=4\ldots24$). This is more than the record claims, and it is a statement about multiplicities.
- Holding the balanced product's two **values** fixed and moving the multiplicities, the LP maximum is $0.922331$, $1.054093$, $0.737865$ at $r=5,6,7$ and infeasible elsewhere ($n=6$). So the tightness needs both the values and the multiplicities, but it needs nothing about criticality beyond the two row identities, which are Lemma L70's row identity applied $N$ times.

### (c) Verdict

**REFUTED.** "Sharp at the equality family" is not a property of the relaxation that distinguishes the equality family. Say plainly what the table shows: at the balanced spectrum the balanced product's own $T$ is feasible and attains $\theta_0$, and the constraints, of which only [Lemma L70](../findings/bounds.md)'s $\lambda_{\min}$ row is doing any work at that point, leave no room above it.

**What should be recorded instead, because it is real.** The LP *is* a genuine advance on Lemma L70, just not where the record looked. It carries $1.936\to0.645$ at the maximal torus, $3.162\to1.054$ at $\mathbb{CP}^3$, $2.858\to1.225$ at padded $W_{\mathbb{CP}^2}$, and it is exact at all seventeen catalogued points where Lemma L70 is slack by up to $7.4$. The mechanism is the row coupling plus the total symmetry of $T$, and the drop table above isolates which of the two does the work at which point. That is a result about the relaxation. The $\theta_0$ column is not.

---

## I3, the sharpness table: **CONFIRMED numerically**

### Reproduced, independently, to every digit

| $n$ | variables | my LP max | $\theta_0(n)$ | my LP min | record's LP min |
| --- | --- | --- | --- | --- | --- |
| $6$ | $455$ | $1.054092553$ | $1.054092553$ | $0.175682092$ | $0.175682092$ |
| $8$ | $3276$ | $1.145643924$ | $1.145643924$ | $-0.190940654$ | $-0.190940654$ |
| $10$ | $14190$ | $1.200000000$ | $1.200000000$ | $-0.420000000$ | $-0.420000000$ |
| $12$ | $45760$ | $1.236033081$ | $1.236033081$ | $-0.576815438$ | $-0.576815438$ |

Variable counts match, and $\binom I3$ is the right count because $T_{k\alpha\beta}=c_{k\alpha\beta}^2$ is totally symmetric and hollow, $c$ being totally antisymmetric for the ad-invariant $-\tfrac12\operatorname{tr}(XY)$.

### Is the maximum exactly $\theta_0$, or merely close? **Exactly**, and here is the proof

Upper: by the two-value symmetrisation above, the LP value equals the four-variable aggregate value, whose $X_{++-}\ge0$ branch is $\theta\le(n-1)\lvert\lambda_{\min}\rvert=\sqrt{(m-1)(2m-1)}/m=\theta_0(n)$ identically. Lower: the balanced product's own $T$ is feasible at $\theta=\theta_0$. Both are exact identities in $m$, so the LP maximum is $\theta_0(n)$ with no numerical content.

### Is the feasible set nonempty for the right reason? **Yes**

The true $T$ of the balanced product satisfies both constraint families exactly: row masses $\sum_{\alpha<\beta}T_{k\alpha\beta}=n-2$ for every $k$ (measured: a single distinct value $4.000000000$ at $n=6$, $6.000000000$ at $n=8$), and the $\lambda$-weighted rows at $\lambda_k(\theta_0-\lambda_k)$.

### Is the LP bounded and correctly posed with $\theta$ free? **Yes**

For any $k$ with $\lambda_k\ne0$ the second family reads $\theta=\lambda_k+\lambda_k^{-1}\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta T_{k\alpha\beta}$, and the first family forces $0\le T_{k\alpha\beta}\le n-2$, so $\lvert\theta\rvert\le\lvert\lambda_k\rvert+(n-2)\max_{\alpha\ne\beta}\lvert\lambda_\alpha\lambda_\beta\rvert/\lvert\lambda_k\rvert$. Some $\lambda_k\ne0$ always, since $\lVert W\rVert=1$. Bounded above and below, feasible, so well posed. No defect analogous to the greedy fill: an LP over a superset of the true $T$ cannot return a value below the true $\theta$, and it never did in any run here.

### Which single constraint is doing the work?

At the balanced spectrum, the $\lambda_{\min}$ row alone, see the drop table in I4(ii). Elsewhere it is the coupling: the torus needs all $N$ rows *and* the total symmetry of $T$ (dropping either returns Lemma L70's $1.936$), padded $W_{\mathbb{CP}^2}$ needs the symmetry of $T$ (dropping it costs $1.225\to1.633$), and $\mathbb{CP}^3$ needs only the $E_{\max}$ rows.

### The "genuine range rather than a pinned value" evidence points the other way

The record offers the LP minima as evidence that the maximum is not a trivial pinning. But the same LP **is** pinned (minimum equal to maximum equal to the true $\theta$), at the maximal torus at $n=6,8,10,12$, at padded $W_{\mathbb{CP}^2}$ at every $n$, at $\mathbb{CP}^3$, $\mathbb{CP}^4$, $\mathbb{CP}^5$, $\mathbb{CP}^6$, $S^2\times S^4$, $S^2\times S^6$ and $S^2\times S^8$. Pinning is the *common* case on the catalogue, and the balanced product is one of the few points where it does not happen. So the non-pinning at the balanced spectrum is not evidence of strength; if anything it says the constraint set is *looser* there than at points far below the extremum.

---

## I2, criticality in bracket coordinates: **REFUTED AS STATED**, with the repair

### The matrix identity is criticality verbatim, and the record's own self-assessment is right

Polarising $\langle v,W^\#v\rangle=-\tfrac12\operatorname{tr}(\mathrm{ad}(v)W\,\mathrm{ad}(v)W)$ gives $M_{kl}=-2W^\#_{kl}$ as an identity on all symmetric operators, checked at the balanced product ($1.9\times10^{-16}$) and at a **random** symmetric operator with no Weyl or criticality structure ($4.6\times10^{-14}$). Hence in an eigenbasis of $W$,

$$M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}\iff W^\#_{kl}=(\theta\lambda_k-\lambda_k^2)\delta_{kl}\iff W^\#=\theta W-W^2\iff Q(W)=\theta W.$$

Exactly criticality, neither weaker nor stronger. **The record's "change of language, not new information" is correct, and the record does not understate it.**

### But the record's "i.e." rendering is strictly weaker, and it is what the numerics tested

The displayed equivalent, *"$\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ whenever $\lambda_k\ne\lambda_l$"*, drops two things: the diagonal values, and the off-diagonal entries inside a degenerate eigenspace. What is left is $[W^\#,W]=0$ and nothing more. That is not criticality.

**Nine counterexamples, all in the record already**, the unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ points, which [bounds.md](../findings/bounds.md) itself records as non-critical with residuals $5\times10^{-2}$ to $5\times10^{-1}$:

| point | $n$ | $\theta$ | criticality residual | $\lVert[W^\#,W]\rVert$ | $\max\lvert M_{kl}\rvert$, $k\ne l$, isotypic eigenbasis | spread of $\theta_k:=\lambda_k-M_{kk}/2\lambda_k$ |
| --- | --- | --- | --- | --- | --- | --- |
| $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ | $8$ | $1.050174$ | $3.4\times10^{-1}$ | $0$ | $0$ | $1.146$ |
| $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ | $8$ | $1.151371$ | $1.1\times10^{-1}$ | $0$ | $0$ | $0.227$ |
| $\mathfrak{so}(2)\oplus\mathfrak{so}(8)$ | $10$ | $0.994398$ | $4.5\times10^{-1}$ | $0$ | $0$ |, |
| $\mathfrak{so}(3)\oplus\mathfrak{so}(7)$ | $10$ | $1.165348$ | $2.3\times10^{-1}$ | $0$ | $0$ |, |
| $\mathfrak{so}(4)\oplus\mathfrak{so}(6)$ | $10$ | $1.203766$ | $6.9\times10^{-2}$ | $0$ | $0$ |, |
| $\mathfrak{so}(2)\oplus\mathfrak{so}(10)$ | $12$ | $0.935505$ | $5.2\times10^{-1}$ | $0$ | $0$ |, |
| $\mathfrak{so}(3)\oplus\mathfrak{so}(9)$ | $12$ | $1.136230$ | $3.3\times10^{-1}$ | $0$ | $0$ |, |
| $\mathfrak{so}(4)\oplus\mathfrak{so}(8)$ | $12$ | $1.221822$ | $1.6\times10^{-1}$ | $0$ | $0$ | $0.369$ |
| $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ | $12$ | **$1.238486$** | $4.8\times10^{-2}$ | $0$ | $0$ | $0.106$ |

The zeros are exact, to the last bit, and the reason is structural rather than numerical: $\Lambda^2\mathbb R^p$, $\Lambda^2\mathbb R^q$ and $\mathbb R^p\otimes\mathbb R^q$ are pairwise inequivalent $SO(p)\times SO(q)$-modules, so Schur forces $W^\#$ to be scalar on each, hence $[W^\#,W]=0$ and $M$ diagonal in the isotypic eigenbasis. **Every off-diagonal relation the record displays holds exactly at all nine, none of which is critical, and the last of them sits at $\theta=1.238486>\theta_0(12)=1.236033$.** A route that reads the off-diagonal family as "criticality in bracket coordinates" admits a point above $\theta_0$ at the conjecture's own threshold dimension.

### The record's own negative control was too weak to see this

"$1.1\times10^{-1}$ at random non-critical $W$" is the weakest available control: a random $W$ fails $[W^\#,W]=0$ for reasons unrelated to criticality. The screen never separated the off-diagonal half from criticality because it was never asked to.

### What happens when $\lambda_k=\lambda_l$, the record asserting nothing there is wrong

Under criticality $W^\#$ acts on $E_a$ by the *scalar* $\theta\lambda_a-\lambda_a^2$, so $M$ restricted to $E_a$ is scalar and $M_{kl}=0$ for $\lambda_k=\lambda_l$, $k\ne l$, **in every eigenbasis**. The qualifier is unnecessary in the forward direction and fatal in the reverse. It is also inconsistent with the record's own count: $\tfrac12N(N-1)$ counts *all* off-diagonal pairs, whereas the qualifier admits only $r\cdot s$ of them, $54$ of $105$ at the balanced $n=6$ point.

### The repair

State the relation as the full matrix identity, and say where the content sits.

> Criticality is equivalent to $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ **as a matrix identity in any eigenbasis of $W$**, the diagonal pinned at $2\lambda_k(\lambda_k-\theta)$ with one common $\theta$, and *every* off-diagonal entry zero, inside a degenerate eigenspace included. Dropping the diagonal half leaves $[W^\#,W]=0$, which holds at every unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ point, none of them critical, and at $\theta=1.238486>\theta_0(12)$ on $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$. **All the discriminating content is in the diagonal half**, which is the half [the LP](../findings/bounds.md) uses, and the reason it works.

The last sentence is not a demotion of the rewriting: the diagonal half's $N$ pinned rows are exactly what carries the torus from $1.936$ to $0.645$.

---

## I1, the marginals are inert: **CONFIRMED**

### Reproduced, every row

| point | $n$ | $\theta$ | criticality residual | Lemma L70 bound | my marginal LP | improvement |
| --- | --- | --- | --- | --- | --- | --- |
| $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ | $6,8,10,12$ | saturated | $\le3\times10^{-16}$ | $=\theta_0(n)$ | $=\theta_0(n)$ | $0$ |
| maximal torus | $6$ | $0.645497$ | $7\times10^{-17}$ | $1.936491673$ | $1.936491673$ | $0$ |
| maximal torus | $8$ | $0.540062$ | $7\times10^{-17}$ | $2.700308624$ | $2.700308624$ | $0$ |
| maximal torus | $10$ | $0.474342$ | $8\times10^{-17}$ | $3.320391543$ | $3.320391543$ | $0$ |
| maximal torus | $12$ | $0.428174$ | $9\times10^{-17}$ | $3.853569774$ | $3.853569774$ | $0$ |
| $\mathrm{ad}(\mathfrak{su}(3))$ | $8$ | $0.836660$ | $3\times10^{-16}$ | $1.673320053$ | $1.673320053$ | $0$ |
| padded $W_{\mathbb{CP}^2}$ | $6$ | $1.224745$ | $1\times10^{-16}$ | $2.857738033$ | $1.224744871$ | $1.632993162$ |
| padded $W_{\mathbb{CP}^2}$ | $8$ | $1.224745$ | $3\times10^{-16}$ | $4.490731195$ | $1.224744871$ | $3.265986324$ |
| padded $W_{\mathbb{CP}^2}$ | $10$ | $1.224745$ | $3\times10^{-16}$ | $6.123724357$ | $1.224744871$ | $4.898979486$ |
| padded $W_{\mathbb{CP}^2}$ | $12$ | $1.224745$ | $3\times10^{-16}$ | $7.756717519$ | $1.224744871$ | $6.531972647$ |

### Is it a valid relaxation? Yes, every constraint is proved, and the row cap is correct and sharp

- **Total $\sum_{a,b}C_{ab}=2(n-2)$.** With $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(XY)$ and $\operatorname{tr}(\mathrm{ad}\,x\,\mathrm{ad}\,y)=(n-2)\operatorname{tr}(xy)$, $\lVert\mathrm{ad}(v)\rVert_{HS}^2=2(n-2)$. Measured exactly at every point.
- **Zero diagonal.** $c_{vaa}=0$.
- **Row cap $m_a\le2$.** For unit $v$, $\lVert v\rVert_F^2=2$, so its matrix eigenvalues $\pm ia_j$ satisfy $\sum a_j^2=1$; $\mathrm{ad}(v)$ has eigenvalues $i(\pm a_j\pm a_k)$ and $\pm ia_j$, and $\max_{j\ne k}(a_j+a_k)\le\sqrt{2(a_j^2+a_k^2)}\le\sqrt2$. So $\lVert\mathrm{ad}(v)\rVert_{op}\le\sqrt2$ and $m_a\le2$, sharp at $v=(\varphi_{12}+\varphi_{34})/\sqrt2$. **Proved and correctly applied.** The cap is attained *in situ*: the measured row maximum is exactly $2.000000$ at padded $W_{\mathbb{CP}^2}$ and $1.000000$ at the balanced products and tori, $0.920395$ at $\mathrm{ad}(\mathfrak{su}(3))$.
- **The true $C$ is feasible at every point**, checked directly against the true bracket data, and $D(v)\ge D_{\min}\ge0$ everywhere, with $D(v)$ constant over $E_{\min}$ to $\le3\times10^{-16}$. So there is no analogue of the greedy defect: the LP value is an upper bound on $\theta$ at every row, by construction and in measurement.
- **One valid constraint is omitted**, harmlessly: taking $\varphi_1=v\in E_{\min}$ forces row $1$ of $C$ to vanish. Adding it changes nothing at any point here, because the binding cap is always on $E_{\max}$'s rows.

### Is the dichotomy real, or an artefact of $\dim E_{\max}=1$? **An artefact, and the exact criterion is available**

Saturating Lemma L70 needs all $2(n-2)$ of the bracket mass on $E_{\min}\times E_{\max}$, of which half sits in $E_{\min}$'s rows and half in $E_{\max}$'s. The caps supply $2\dim E_{\max}$ and $2\dim E_{\min}$. Hence

$$\text{improvement}=0\iff 2\min(\dim E_{\max},\dim E_{\min})\ge n-2 .$$

Tested on $30$ synthetic three-value spectra at $n=10,12$ with $\dim E_{\max}$ and $\dim E_{\min}$ swept over $\{1,\dots,6,20\}$: **zero disagreements**, improvement exactly $0$ on one side of the threshold and strictly positive on the other. The catalogue sits where it does for that reason alone, $\dim E_{\max}=n(n-2)/4$ at the balanced products, $n/2$ at the tori, $8$ at $\mathrm{ad}(\mathfrak{su}(3))$, all far above $(n-2)/2$; and $\dim E_{\max}=1$ at padded $W_{\mathbb{CP}^2}$.

The padded $W_{\mathbb{CP}^2}$ row is exactly computable, which also explains its $n$-independence. With $\lambda=(2,-1,-1,0,\dots,0)/\sqrt6$ the only negative product is $\lambda_{\max}\lambda_{\min}=-\tfrac13$, the unique $E_{\max}$ row caps that mass at $2$, and the surplus goes on zero-product pairs at no cost, so $\tfrac12\sum\lambda_a\lambda_bC_{ab}=-\tfrac23$, $D_{\min}=(n-4)/3$ and

$$\lambda_{\min}+(n-2)\lambda_{\max}-\frac{D_{\min}}{\lvert\lambda_{\min}\rvert}=\frac{2n-5}{\sqrt6}-\frac{2(n-4)}{\sqrt6}=\frac3{\sqrt6}=\sqrt{3/2}=1.224744871,$$

for **every** $n$. Measured $D_{\min}=2/3$, $4/3$, $2$ at $n=6,8,10$, matching $(n-4)/3$.

**So the dichotomy carries no information about criticality.** The marginals close the gap at padded $W_{\mathbb{CP}^2}$ because its extreme eigenspaces are small and its kernel is large, and they buy zero at the tori because theirs are large. The record's inference, *"a lower bound on $D$ written in the marginals cannot separate a maximal torus from a balanced sphere product"*, is correct, and the fence post stands; what should be added is that the separation the marginals *do* achieve is a statement about $\dim E_{\max}$, so a successor must not read the padded $W_{\mathbb{CP}^2}$ row as evidence that the marginals see anything Lie-theoretic.

---

## Reproducibility

| file | what it does |
| --- | --- |
| [lib325.py](../scripts/reviewers/r325/lib325.py) | $\mathfrak{so}(n)$ structure constants, $W^\#$, $Q$, $P$, the $\mathrm{Weyl}_n$ screen and orthonormal basis, and every point construction |
| [lp325.py](../scripts/reviewers/r325/lp325.py) | the diagonal-criticality LP and the marginal deficiency LP |
| [flow325.py](../scripts/reviewers/r325/flow325.py) | projected flow and Newton solve for genuine critical points in $\mathrm{Weyl}_n$ |
| [r325-lp-sharpness.log](../agent_logs/r325-lp-sharpness.log) | the run log, with each falsification timestamped at discovery |

Every $\theta$ reported here is accompanied by its criticality residual. Non-critical points appear only where they are the point (the nine $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ counterexamples in I2) and their residuals are given. Memory stayed under $300$ MB; the $n=12$ LP with $45760$ variables solves in $0.5$–$26$ s.
