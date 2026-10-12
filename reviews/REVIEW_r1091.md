# REVIEW r1091

**Cold Gate 2, one of two independent reviewers on an identical brief.** Commits under review: `4fe9ea9f` (the `WCP2` entry-shape measurement), `5366f187` (the r1089 repairs), `5a579518` (sub-step (a), the projected pair quotient). The claim under review is the block **SUB-STEP (a), THE PROJECTED QUOTIENT** inside `#### Lemma L233` in [second-order.md](../findings/second-order.md).

**Footing: analysis-only, and honoured.** Every run below finished in seconds to tens of seconds on objects constructed for the check. No sweep, census or unbounded hunt was opened. The one bounded sampling run is labelled a screen where it is used.

**The rebuild shares nothing with [screen_I73_pair_direction.py](../scripts/misc/screen_I73_pair_direction.py)**, which was not read, imported or run. It was built from [conventions.md](../findings/conventions.md) alone: $\varphi_{ab}=E_{ba}-E_{ab}$ orthonormal under the half-trace pairing, $\#$ the halved Böhm–Wilking product, $X\circ Y=\tfrac12(XY+YX)+\mathrm{sharpBil}(X,Y)$. Its three anchors, each of which the brief's givens fix independently: $\mathrm{id}^\#=(n-2)\,\mathrm{id}$ **exactly** at $n=5,6,7$; $Q(e)=e$ to $5\cdot10^{-17}$ at the sphere product's $e$; and $\dim\mathcal W_n$ read off the rank of the complement, $35,84,168,300$ at $n=5,\dots,8$, against $n(n-3)(n+1)(n+2)/12$.

| # | claim | verdict |
|---|---|---|
| F1 | the **disjoint** case IS L26's $\mu$, so L26 already settles that half | **REFUTED as stated, and replaced by something stronger.** Both halves fail outside one configuration: disjoint planes **both inside the $p$-block** give $0$, not $\mu$, and at a generic coordinate-diagonal $W$ the projected direction is **not** an eigenvector. The true general law is a FOUR-symbol identity, stated below, of which L26's is the cross-block case |
| F2 | the **sharing** case does NOT follow L26's three-symbol shape, missing in BOTH directions | **CONFIRMED on the numbers, REFUTED on the inference.** All four misses reproduced to the digit. But the sharing quotient IS that formula with a correction, and the correction is now exact: the shape is the $n\to\infty$ limit of a law whose every coefficient is displayed below |
| F3 | $1/4$ at $p=3$ independently of $q$ | **CONFIRMED**, and wider than recorded: flat at $n=5,\dots,13$, not $6,\dots,10$ |
| F4 | $(n-4)/(6(n-3))$ at $p=4$, giving $4/27$ at $n=12$ | **CONFIRMED**, and it is no longer a fit. It holds at $n=6,7$ as well, and the whole family is $\dfrac{n-p}{2(p-1)(n-3)}$: the $6$ is $2(p-1)$, and the $p=5$ row the record leaves open is $(n-5)/(8(n-3))$ |
| F5 | $p=3$ is flat because $\{i,j,k\}$ exhausts the block | **CONFIRMED, and now derived.** The numerator counts indices outside the block and the denominator's $(n-3)$ counts indices outside $\{i,j,k\}$, and at $p=3$ those are the same set |
| F6 | every value measured is $\le\tfrac12$, so no violation of L24 has been found | **TRUE AND VACUOUS, and the sentence is unscoped.** No measurement at a $p,q\ge3$ sphere product could have exceeded $\tfrac12$, because [Lemma L27](../findings/nondegeneracy.md)'s spectrum already puts $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ there. At $q=2$ the same projected quotient measures $3/4$, $2/3$, $5/8$ |
| F7 | the `WCP2` entry shape: 6 s, 3.1 GB, so cost is not the obstacle | **NOT RE-RUN, and PLAUSIBLE on its conclusion only.** `lake` is held by another session, so no Lean process was started. The measured file was never committed on any branch, so the numbers are unreproducible, and $3.1$ GB sitting BELOW the $4.25$ GB import baseline says the two were not measured the same way. *The conclusion survives on the goal evidence, which needs neither number* |

## F1. The disjoint case, and the four-symbol law that replaces it

**Disjoint planes both inside one block give $0$, not $\mu$.** At the $(4,4)$ split at $n=8$, for $u=\varphi_{01}$ and $v=\varphi_{23}$, both planes in the $p$-block, $X=\pi_{\mathcal W_n}(u\odot v)$ has $\lVert X\rVert^2=\tfrac13$, so it is not the zero direction, and

$$e\circ X=0\cdot X,\qquad \frac{\langle X,e\circ X\rangle}{\lVert X\rVert^2}=0\ \ne\ \mu=\tfrac13 .$$

*The same at $(4,4)$ inside the $q$-block, and at every split with a block of size $\ge4$ over $n=6,\dots,12$.* **L26's hypothesis is $\pi$ in the $p$-block and $\rho$ in the $q$-block**, and the block's sentence drops it, so "the DISJOINT case is already the record's" covers a case L26 does not reach and gets a different number there.

**The projected direction is an eigenvector only in special position.** At a two-block sphere product with $u=\varphi_{0p}$ and $v=\varphi_{1,p+1}$, both planes straddling, the pair is disjoint and $\lVert e\circ X-\lambda X\rVert/\lVert X\rVert=0.14$ at $(4,4)$. **At a generic coordinate-diagonal Weyl $W$** (random, hollow, zero row sums, verified Weyl to $3\cdot10^{-16}$) the residual reaches $2.19$ over all $210$ disjoint pairs at $n=8$. *So "at a coordinate-diagonal $W$ the projected direction is an eigenvector" is false at a coordinate-diagonal $W$. It is true at the sphere product for the cross-block pair.*

**WHAT IS TRUE IS A FOUR-SYMBOL LAW, AND IT IS EXACT AT EVERY COORDINATE-DIAGONAL WEYL $W$ AND EVERY $n$.** For disjoint $u=\varphi_{ij}$, $v=\varphi_{kl}$,

$$\boxed{\ \frac{\langle X,e\circ X\rangle}{\lVert X\rVert^2}=\tfrac12\big(\varepsilon_{ij}+\varepsilon_{kl}\big)-\tfrac14\big(\varepsilon_{ik}+\varepsilon_{il}+\varepsilon_{jk}+\varepsilon_{jl}\big),\qquad \lVert X\rVert^2=\tfrac13\ }$$

**and every coefficient outside the four core indices is exactly $0$.** *The quotient is LINEAR in $e$, because $X=\pi_{\mathcal W_n}(u\odot v)$ does not depend on $e$ at all, so the coefficients are not fitted: they are read off the gradient.* Read at $n=6,7,8,10,11$ they are $\tfrac12,\tfrac12,-\tfrac14,-\tfrac14,-\tfrac14,-\tfrac14$ and $0$ on every remaining plane, and the law was checked against all $45+105+210$ disjoint pairs at $n=6,7,8$ at a random coordinate-diagonal Weyl $W$, agreeing to $4.4\cdot10^{-16}$.

**The law's four specialisations at the two-block sphere product, each confirmed symbolically in $p$ and $q$:**

| the pair | the law gives | measured |
|---|---|---|
| $\pi\subset P$, $\rho\subset Q$ | $\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}=\mu$ | $\mu$, and here it IS an eigenvector |
| both inside one block | $0$ | $0$ |
| one inside a block, one straddling | $0$ | $0$ |
| both straddling | $-\mu/2$ | $-\mu/2$ |

*So L26's three-symbol identity is the cross-block row of a law that has four rows, and the record's sentence promotes one row to the whole.* **The finding the block wanted is available and is bigger than the one it states.**

## F2. The sharing case, and its correction, which exists

**The four misses are reproduced exactly**, from my own rebuild: in-block sharing at $(6,3)$ and $(8,4)$ gives measured $\tfrac14$ and $\tfrac2{15}$ against a candidate of $0$, so $+0.25$ and $+0.1\overline3$. Cross-block sharing at the same two splits gives $\tfrac16$ and $\tfrac1{10}$ against candidates $\tfrac14$ and $\tfrac16$, so $-0.08\overline3$ and $-0.0\overline6$. *Both directions, and the block's four numbers in its own order.*

**BUT IT IS THAT FORMULA WITH A CORRECTION, AND HERE IS THE CORRECTION.** For $u=\varphi_{ij}$, $v=\varphi_{ik}$ sharing $i$, at every coordinate-diagonal Weyl $W$, writing $m$ for an index outside $\{i,j,k\}$,

$$\frac{\langle X,e\circ X\rangle}{\lVert X\rVert^2}=\frac{n-3}{2(n-2)}\big(\varepsilon_{ij}+\varepsilon_{ik}\big)-\tfrac12\varepsilon_{jk}-\frac{1}{n-2}\sum_m\varepsilon_{im}+\frac{1}{2(n-2)(n-3)}\sum_m\big(\varepsilon_{jm}+\varepsilon_{km}\big)+\frac{1}{(n-2)(n-3)}\sum_{m<m'}\varepsilon_{mm'}$$

with $\lVert X\rVert^2=\dfrac{n-3}{2(n-2)}$. *Read off the gradient at $n=6,7,8,9$ and confirmed at $n=10,11,12$, every coefficient exact as a rational, then checked as an identity against $1755$ sharing pairs over three random coordinate-diagonal Weyl $W$ at each of $n=6,7,8,9$, agreeing to $1.8\cdot10^{-15}$.* **The coefficient vector is one representative**, since the $\varepsilon$ obey $\sum_b\varepsilon_{ab}=0$ and the functional therefore has many, and it is the identity rather than the representative that was checked. **The record's candidate is its $n\to\infty$ limit**: $\frac{n-3}{2(n-2)}\to\tfrac12$ and every other coefficient $\to0$. So "it is not that formula with a correction" is an inference from four numbers that the object does not support. *What is true, and is the useful half of the claim, is that the correction touches EVERY plane of the ambient space, where L26's disjoint law touches only four.*

## F3, F4, F5. The table, reproduced and then closed

**Every recorded number reproduced**, independently: $\tfrac14$ at $p=3$ for $n=5,\dots,12$; $\tfrac2{15},\tfrac5{36},\tfrac17,\tfrac7{48},\tfrac4{27}$ at $p=4$ for $n=8,\dots,12$; $\tfrac5{56}$ at $(10,5)$. *No disagreement anywhere.*

**THE FAMILY IS ONE FORMULA AND THE $p$-DEPENDENCE IS $2(p-1)$.** Substituting the sphere product's $\varepsilon_{PP}=\frac{q}{(p-1)(n-1)}$, $\varepsilon_{QQ}=\frac{p}{(q-1)(n-1)}$, $\varepsilon_{PQ}=\frac{-1}{n-1}$ into the sharing law above, with $i,j,k$ all in the $p$-block, and simplifying in $p$ and $q$ as free symbols:

$$\boxed{\ \frac{\langle X,e\circ X\rangle}{\lVert X\rVert^2}\Big|_{\text{sharing, }i,j,k\subset P}=\frac{n-p}{2(p-1)(n-3)}=\frac{q}{2(p-1)(n-3)}\ }$$

*The difference from the record's $p=4$ row is zero as a rational function, not as a decimal.* It gives $\tfrac14$ at $p=3$, $\frac{n-4}{6(n-3)}$ at $p=4$ and $\frac{n-5}{8(n-3)}$ at $p=5$, so **the $6$ the record cannot place is $2(p-1)$**, and the row it says is missing is available. *Checked out of sample at ten further points nobody in the record has used: $n=13$ at $p=3,4,5,6$, and $(12,6)$, $(12,7)$, $(11,6)$, $(9,6)$, $(10,8)$, $(11,9)$, every one matching exactly.*

**F5's mechanism is right and the formula says why.** The numerator $n-p$ counts the indices outside the block, and the denominator's $n-3$ counts the indices outside $\{i,j,k\}$. They are the same count exactly when $\{i,j,k\}$ **is** the block, which is $p=3$, and there the factor cancels. *So $p=3$ is flat for the reason the block gives, and the degeneracy is visible in the closed form rather than asserted beside it.* **A second sense in which $p=3$ is special**: it is the only $p$ at which the projected sharing direction is an eigenvector (residual $10^{-17}$ against $0.10$ at $p=4$).

## F6. True, already proved, and stated wider than it holds

**No measurement of this kind could have failed at a $p,q\ge3$ sphere product.** [Lemma L27](../findings/nondegeneracy.md) gives the whole spectrum of $L_e$ there: $1$ on $\langle W\rangle$, $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$, $\lambda_m=\frac{m-2}{2(m-1)}<\tfrac12$, and $\pm\mu$ with $\mu\le\tfrac12$ throughout $p,q\ge3$. **Every Rayleigh quotient of $L_e$ on $W^\perp$ is therefore at or below $\tfrac12$ before any direction is chosen**, so "no violation of L24 has been found at a sphere product" reports the absence of something the record already proves absent. *It is a screen that cannot fire, and it is offered in the sentence where a test would be.*

**AND THE UNSCOPED SENTENCE IS FALSE AT $q=2$.** The same projected quotient, same construction, at the cross-block disjoint pair:

| split | projected quotient |
|---|---|
| $(3,2)$, $n=5$ | $3/4$ |
| $(4,2)$, $n=6$ | $2/3$ |
| $(5,2)$, $n=7$ | $5/8$ |

*These are $\mu$ at a block of size $2$, which [Lemma L26](../findings/nondegeneracy.md) already records as exceeding $\tfrac12$ by $\frac1{2(n-3)}$.* **No contradiction with L24 arises**, because L24's hypothesis is a local maximiser and a sphere product with a $2$-block is not one. **But the claim says "at a sphere product" and means "at a sphere product with $p,q\ge3$"**, and a consumer reading it as written would take a bound the record's own L26 contradicts.

**THE MEASURED SET IS NARROWER AGAIN THAN "EVERY VALUE MEASURED" SUGGESTS.** $e$'s eigenspaces at a sphere product are degenerate, so $u$ and $v$ range over an orthonormal pair in a $\binom p2$-dimensional space, not over coordinate planes. Sampling $400$ random orthonormal pairs inside the $PP$ eigenspace at $(4,4)$ reaches $0.291$ against the coordinate value $\tfrac2{15}=0.133$, and at $(3,4)$ inside the $QQ$ eigenspace $0.287$ against $\tfrac18$. *Recorded as a SCREEN.* **So the coordinate-plane table is a slice of the eigenspace, not its extremum**, and the block's quantifier should say which.

## F7. The Lean measurement

**THE RUN WAS NOT MADE: `lake` IS HELD BY ANOTHER SESSION.** `lake build` at PID `69577` with its worker at PID `70024` elaborating [I67Pf6.lean](../lean/HamiltonsCubic/Results/I67Pf6.lean) at 5.58 GB resident. *No Lean process was started and none was killed.* **So the timing and the peak are not reproduced here, and nothing below is a claim about what they would have shown.**

**Verdict: UNVERIFIABLE BY CONSTRUCTION, AND THE TWO NUMBERS DO NOT SIT TOGETHER.**

- **The object was deleted.** The commit says so in its own last bullet, *"the scratch entry file is removed rather than committed"*, and the working tree agrees: `git ls-files --others` over [lean/](../lean/) is empty and `git log --all -S` over [lean/](../lean/) finds the string `sharpBilin WCP2 1 0 0` in this commit's docstring alone, in no file on any branch. **So the measured file exists nowhere**, and a successor who wants the 6 seconds back must first rebuild the thing that produced them. *Leaving nothing untracked in [lean/](../lean/) was right. Recording the numbers with no way to reproduce them is the cost of it, and the block does not say so.*
- **3.1 GB is BELOW the 4.25 GB baseline, and a goal file cannot peak below the cost of its own imports.** The baseline is described as *"a file that merely imports this one"*. A file that imports the same oleans AND elaborates a goal cannot peak lower than one that imports them and stops. **Either the two numbers were taken by different methods or of different processes, or the baseline file imports more than the entry file did.** The record says which in none of its three copies of the figure. *This project has already lost a measurement to exactly that trap, a wrapper process sitting at 1 MB while its worker held 5.5 GB.*
- **The conclusion is safe anyway, by the other half of the evidence.** *"The entry lemmas fire, and what remains is `WCP2 * WCP2` not reducing"* is a statement about the goal, not about the budget, and it carries **cost is not the obstacle** without either number. **That is where the claim should rest**, and the two memory figures should carry the method that produced them or be withdrawn.

## The habit check: was this block's novelty tested against the object?

**Asked by VALUE across [findings/](../findings/), [results.md](../results.md) and [reviews/](../reviews/), not by wording.** $\tfrac2{15}$, $\tfrac5{36}$, $\tfrac4{27}$ and $\tfrac5{56}$ appear nowhere else as this quantity. The hits are [route-a.md](../findings/route-a.md)'s $c_2$ ceiling $\tfrac5{36}$ and [ungraded-slack.md](../findings/ungraded-slack.md)'s Casimir $P$ value $\tfrac2{15}$, neither related. **So the $p\ge4$ rows are new.**

**BUT TWO OF THE BLOCK'S FOUR ANSWERS WERE ALREADY IN THE RECORD, UNDER OTHER NAMES, IN THE VERY LEMMA IT CITES ONE LINE ABOVE.**

- **The $p=3$ row IS $\lambda_m$ at $m=3$.** [Lemma L27](../findings/nondegeneracy.md)'s spectrum carries $\lambda_m=\frac{m-2}{2(m-1)}$ on $S^2_0(\mathbb R^m)$ at $m=p,q$, which at $m=3$ is exactly $\tfrac14$. The projected sharing direction at $p=3$ is an eigenvector (residual $10^{-17}$), and the $\tfrac14$ eigenspace has multiplicity $5=s_3$ at $(9,3)$ and $(7,3)$, and $10=s_3+s_3$ at $(6,3)$, which is $L27$'s $S^2_0(\mathbb R^p)$ summand and no other. ***$\lambda_m$ depends on $m$ alone, so "independent of $q$" is immediate from the record and needs no scan over five values of $n$.***
- **The disjoint-inside-one-block zeros ARE L27's kernel.** [nondegeneracy.md](../findings/nondegeneracy.md) already states *"$\ker L_e$ is exactly the four block-support subspaces $(pp,pp)$, $(qq,qq)$, $(pp,\mathrm{mix})$, $(qq,\mathrm{mix})$"*. Those are precisely the three configurations measured at $0$ above. **So the record held the whole of the disjoint case before this block was written**, in two pieces rather than one, and the block collapses it to the piece L26 owns.

**What the block gets right about its own novelty**: the $p\ge4$ sharing values, the four-symbol disjoint law and the general coordinate-diagonal sharing law are new here. *The absence claim was not tested by the object, and testing it would have found the answer to the question the block leaves open.*

## Summary of corrections owed to the block

1. **Scope the disjoint sentence or replace it.** *"The DISJOINT case is already the record's"* is true of the cross-block pair and false of the other three. **The four-symbol law above replaces it and is stronger**, holding at every coordinate-diagonal Weyl $W$ and every $n$.
2. **Drop "the projected direction is an eigenvector" as a general statement.** It is a statement about the cross-block pair at a sphere product and about $p=3$ sharing, and nothing wider.
3. **Replace the two-row table with the closed form $\dfrac{n-p}{2(p-1)(n-3)}$.** *The $p$-dependence the block says is owed is $2(p-1)$*, it is a derivation rather than a fit, and the $p=5$ row is $(n-5)/(8(n-3))$.
4. **Rewrite F2's inference.** The three-symbol shape IS the sharing law's $n\to\infty$ limit, and the correction exists and is displayed above.
5. **Scope the $\le\tfrac12$ sentence to $p,q\ge3$, and say it is L27's.** As written it is contradicted at $q=2$ by the record's own L26, and where it holds it cannot fail.
6. **Say what the quantifier "every value measured" ranges over**: coordinate-plane pairs, which are a slice of each degenerate eigenspace, not its extremum.
