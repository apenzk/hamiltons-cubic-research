# Review r641, Lemma L111, criticality in bracket coordinates

**Reviewer A of a two-reviewer pair on identical cold briefs. Analysis only: no run of any kind was made for this report; every number below is closed-form arithmetic done by hand.**

## Verdict

**GAP.** The matrix form is **CONFIRMED**, factor $2$ included, and it is an identity rather than a discovery. The strictness claim is **CONFIRMED**, with a witness rebuilt here by hand rather than repeated from the cited reviewer. The block's own correction is right and **incomplete in four places**: it drops the count that measures the strictness, leaves standing a sentence its own cited reviewer refuted, restates the withdrawn motivation as a live exclusivity claim, and introduces a third untabled sense of the letter $M$.

## Symbols, read before deriving

Per the brief, [conventions.md](../findings/conventions.md) is treated as unreliable and every reading below is pinned against a second occurrence in the record.

| symbol | reading used here | pinned by |
| --- | --- | --- |
| $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ | inner product $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal | [conventions.md](../findings/conventions.md) "Norms and pairings", settled by [r519](REVIEW_r519.md)/[r520](REVIEW_r520.md) |
| $c_{k\alpha\beta}$ | $\langle[\varphi_k,\varphi_\alpha],\varphi_\beta\rangle$, **totally antisymmetric** | [conventions.md](../findings/conventions.md) "Structure constants" |
| $N$ | $\binom n2$ | [conventions.md](../findings/conventions.md) |
| $\lambda_k$ | the $\Lambda^2$ spectrum of $W$, $\sum\lambda_k^2=\operatorname{tr}(W^2)=1$, **not** the spectrum of the sectional matrix | [conventions.md](../findings/conventions.md), "the letter $M$ carries two objects" |
| $W^\#$ | **half-convention**: $(W^\#)_{kl}=\tfrac12\sum_{\alpha,\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$ in an eigenbasis, the sum over all ordered $(\alpha,\beta)$ | [bounds.md:159](../findings/bounds.md), [fence-posts.md:340](../findings/fence-posts.md), and [problem.md:118](../findings/problem.md)'s diagonal formula, three independent occurrences |
| criticality | $Q(W)=W^2+W^\#=\theta W$ at $\lVert W\rVert=1$, $\theta=P(W)$, no projection onto $\mathcal W_n$ needed | [conventions.md](../findings/conventions.md); legitimacy of the un-projected form proved at [problem.md:53](../findings/problem.md) via [BW08](../references/boehm-wilking-2008-space-forms/) eq. (6), and cited as load-bearing at [bounds.md:181](../findings/bounds.md) |
| $M_{kl}$ | $\operatorname{tr}(\mathrm{ad}(\varphi_k)W\,\mathrm{ad}(\varphi_l)W)$, **a third object under the letter $M$**, see the finding below | this block only |
| $D(v)$ | $\tfrac12\sum_{a,b}(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})c_{vab}^2$ | [Lemma L70](../findings/bounds.md) |

**The factor $2$ in the lemma statement is convention-dependent and the record's convention is the one that makes it right.** Under the full-sum reading $(W^\#)_{kl}=\sum_{\alpha\beta}(\cdots)$ the same derivation gives $M_{kl}=\lambda_k(\lambda_k-\theta)\delta_{kl}$ with no $2$. Three record occurrences fix the half-convention, so the block's constant stands, but it stands on a normalisation that [conventions.md](../findings/conventions.md) never tables, which is the same class of exposure the $\varphi_{ab}$-norm dispute already cost a cycle for.

## 1. The matrix form, CONFIRMED, and it is an identity

**Step 1: $M=-2W^\#$, on every symmetric operator on $\Lambda^2$.** With $(\mathrm{ad}\,\varphi_k)_{\beta\alpha}=c_{k\alpha\beta}$ and $W\varphi_\alpha=\lambda_\alpha\varphi_\alpha$,

$$(\mathrm{ad}(\varphi_k)W)_{\beta\alpha}=c_{k\alpha\beta}\lambda_\alpha,\qquad M_{kl}=\sum_{\alpha\beta}c_{k\beta\alpha}\lambda_\beta\,c_{l\alpha\beta}\lambda_\alpha=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,c_{k\alpha\beta}c_{l\alpha\beta}=-2(W^\#)_{kl},$$

the middle sign being total antisymmetry of $c$ and nothing else. Setting $k=l$ recovers the block's own opening line $\langle v,W^\#v\rangle=-\tfrac12\operatorname{tr}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$, so the polarisation step is sound; $\operatorname{tr}(AWBW)$ is already symmetric in $(A,B)$ by cyclicity, so polarising is a formality.

**Step 2: substitute criticality.** $Q(W)=\theta W$ gives $W^\#=\theta W-W^2$, which in an orthonormal eigenbasis is $(W^\#)_{kl}=\lambda_k(\theta-\lambda_k)\delta_{kl}$, hence

$$\boxed{\;M_{kl}=2\lambda_k(\lambda_k-\theta)\,\delta_{kl}\;}$$

**Step 3: the converse, which the block does not spell out and which is needed for "is criticality".** If $M_{kl}=2\lambda_k(\lambda_k-c)\delta_{kl}$ for some constant $c$, then $W^\#=cW-W^2$, so $Q(W)=cW$; contracting with $W$ at $\lVert W\rVert=1$ gives $c=\langle W,Q(W)\rangle=P(W)=\theta$. So no separate hypothesis pins the constant.

**Hypotheses that enter:** the definition of $W^\#$ through structure constants; total antisymmetry of $c$ (i.e. ad-invariance of the pairing); an *orthonormal eigenbasis* of $W$; $\lVert W\rVert=1$ for step 3; criticality. **Hypotheses that do not enter:** the first Bianchi identity, trace-freeness, $n\ge5$, $\theta>0$. The identity of step 1 holds for any symmetric operator on $\Lambda^2$, Weyl or not, which is exactly why the block's self-assessment "a change of language, not new information" is right.

**Is the $\delta_{kl}$ a conclusion or a hypothesis? A conclusion, and by count it is most of the content.** Nothing in the construction of $M$ makes it diagonal: $M=-2W^\#$, and $W^\#$ is generically not diagonal in $W$'s eigenbasis, it is not even a Weyl tensor ([bispectral.md:148](../findings/bispectral.md): about $60\%$ of its norm lies outside $\mathrm{Weyl}_n$). In a fixed eigenbasis the boxed line is $\binom N2$ off-diagonal vanishings plus $N$ diagonal pinnings, $\binom{N+1}2$ scalar equations of which exactly one is dependent (the $W$-component, by step 3). **But by information the split is the other way round**: the $N$ diagonal entries are the only ones that mention $\theta$, and they are what makes the statement basis-free, pinning the diagonal *values* forces $W^\#|_{E_i}$ to be the scalar $\theta\nu_i-\nu_i^2$, which no longer refers to the basis.

**The block's own file settles this 186 lines above.** [bounds.md:227](../findings/bounds.md) already states "$Q(W)=\theta W$ means $W^\#=\theta W-W^2$: $W^\#$ is a polynomial in $W$ … $W$ and $W^\#$ share eigenspaces, $W^\#$ acts on $E_a$ by the scalar $\theta\lambda_a-\lambda_a^2$." That is the matrix form verbatim, in operator language. [bounds.md:335](../findings/bounds.md) states its diagonal as relation (C). L111 adds the change of variable and nothing else, and says so.

## 2. The bracket form and the strictness, CONFIRMED, with the count the record lacks

### 2a. Forward direction, routine, and it uses only diagonality

$[W,W^2]=0$, so $[W,Q(W)]=[W,W^\#]$, whose $(k,l)$ entry is $(\lambda_k-\lambda_l)(W^\#)_{kl}$. Criticality makes $W^\#$ diagonal in the eigenbasis, so every entry vanishes. **The displayed bracket relations are exactly $[W,Q(W)]=0$**, confirming the block's identification: "$\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ whenever $\lambda_k\ne\lambda_l$" is precisely the statement that $W^\#$ has no matrix element between distinct eigenspaces. It uses the diagonality of $W^\#$ and no diagonal value, which is why $\theta$ disappears from it.

### 2b. The converse fails, witness rebuilt here, not repeated

The block's witness family is the diagonal locus. I rebuilt it from the definitions rather than checking the cited reviewer's numbers.

**Every coordinate-diagonal Weyl tensor satisfies the bracket form, structurally.** For $W$ diagonal in the pair basis $\{\varphi_{ab}\}$, $c_{k\alpha\beta}c_{l\alpha\beta}\ne0$ requires $\{k,\alpha,\beta\}$ and $\{l,\alpha,\beta\}$ both to be triangles. Two edges $\alpha,\beta$ sharing a vertex lie in exactly one triangle, so $l=k$: **$W^\#$ is exactly diagonal, hence $Q(W)$ is, hence $[W,Q(W)]=0$**, with no numerics. This is [problem.md:118](../findings/problem.md)'s "$Q$ preserves diagonality" read at the off-diagonal entries.

**A non-critical member, checkable by hand.** Take $n=4$ and the vertex matrix $K_{12}=K_{34}=1$, $K_{13}=K_{24}=0$, $K_{14}=K_{23}=-1$. It is symmetric, hollow, and every row sums to $0$, so it lies in $\mathcal D_4$ and is a genuine Weyl tensor ([problem.md:546](../findings/problem.md) proves the correspondence both ways). Its $\Lambda^2$ spectrum is the entry multiset, and [problem.md:118](../findings/problem.md)'s formula $(Q(W))_{ij,ij}=\lambda_{ij}^2+\sum_{k\ne i,j}\lambda_{ik}\lambda_{jk}$ gives

| $(ij)$ | $12$ | $13$ | $14$ | $23$ | $24$ | $34$ |
| --- | --- | --- | --- | --- | --- | --- |
| $\lambda_{ij}$ | $1$ | $0$ | $-1$ | $-1$ | $0$ | $1$ |
| $Q(W)_{ij,ij}$ | $1$ | $-2$ | $1$ | $1$ | $-2$ | $1$ |

$Q(W)$ is diagonal in the same basis as $W$, so $[W,Q(W)]=0$; and $Q(W)_{13,13}=-2\ne\theta\cdot 0$ for any $\theta$, so $Q(W)\not\parallel W$ and the point is **not critical**. Padding to any $n\ge4$ leaves both facts intact (the formula's extra terms all carry a zero factor) so the failure is not a small-$n$ artefact. **The strictness is settled.**

**The family's dimension, $n(n-3)/2$, is right.** $\dim\mathcal D_n=\binom n2-n$ because the row-sum map is onto: $S_{ab}=x_a+x_b$ has row sums $(n-2)x+(\mathbf1^{\mathsf T}x)\mathbf1$, invertible in $x$ for $n\ge3$. That gives $n(n-3)/2$, matching the block and matching $9$ of $84$ at $n=6$, $20$ of $300$ at $n=8$.

**One wording correction.** "Every diagonal Weyl tensor satisfies it **while being nowhere near critical**" is false of the family as a whole: $\mathcal D_n$ contains the conjectured maximiser $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ and every $\mathbb{CP}^m$, all critical. It is the generic member that is far from critical, and the statement should say so.

### 2c. How much weaker, the number the record does not state

Let the $\Lambda^2$ spectrum have distinct values with multiplicities $m_1,\dots,m_d$, $\sum m_i=N=\binom n2$.

| condition | independent scalar equations |
| --- | --- |
| criticality (matrix form) | $\binom{N+1}2-1$ |
| bracket form, as displayed | $\binom N2-\sum_i\binom{m_i}2=\tfrac12\big(N^2-\sum_i m_i^2\big)$ |
| **dropped** | $\displaystyle \tfrac12\Big(N+\sum_i m_i^2\Big)-1$ |

The identity behind the middle row: $[W,X]=0$ confines the symmetric $X$ to the commutant, of dimension $\sum_i\binom{m_i+1}2=\tfrac12(N+\sum_i m_i^2)$, while criticality pins $X=Q(W)$ to a single point of it. **The bracket form says $Q(W)$ commutes with $W$; criticality says $Q(W)$ is proportional to $W$. That is the whole of the gap, in one line.**

Worked values:

- **Simple spectrum** ($m_i\equiv1$): $N-1$ conditions lost, precisely the diagonal pinnings, the only ones carrying $\theta$. Even in the least degenerate case the bracket form cannot determine $\theta$.
- **Balanced $S^3\times S^3$, $n=6$** ($N=15$, $m=(9,6)$ by [Lemma L71](../findings/bounds.md)): $65$ of $119$ lost, $55\%$.
- **Balanced $S^6\times S^6$, $n=12$** ($N=66$, $m=(36,30)$): $1130$ of $2210$ lost, $51\%$.

So at the extremal family (where the conjecture is decided), **the bracket form retains under half of criticality**, and it retains none of the half that fixes $\theta$. This quantifies the block's "strictly weaker" and is not on the record in any form; the pre-correction text's count $\tfrac12N(N-1)$ was deleted at the repair and replaced with no count at all.

### 2d. The three nested conditions, one of which the block conflates

The correction note says "criticality forces vanishing for **all** $k\ne l$, basis-independently". Correct, but there are three conditions here and the block names two:

1. $[W,W^\#]=0$, $W^\#$ block-diagonal. Basis-free. **This is the displayed bracket form.**
2. $(W^\#)_{kl}=0$ for all $k\ne l$ in one fixed eigenbasis, $W^\#$ fully diagonal there. Strictly stronger than (1) at a degenerate spectrum, and **basis-dependent** as stated.
3. $(W^\#)_{kl}=\lambda_k(\theta-\lambda_k)\delta_{kl}$, $W^\#|_{E_i}$ scalar. **Criticality.**

(3) $\Rightarrow$ (2) in every eigenbasis $\Rightarrow$ (1), all strict. The block's phrase "basis-independently" is doing the work of moving from (2) to (3), and what actually delivers basis-independence is the *pinned diagonal value*, not the off-diagonal vanishing. That is a fourth reason the diagonal half cannot be dropped, and the block does not give it.

## 3. The withdrawn motivation, the withdrawal is right, and the block still leans on it twice

**The withdrawal is correct.** [r326](REVIEW_r326.md) I1 exhibits the omitted marginal $\sum_a\lambda_a m_a=-2\langle v,Wv\rangle$ and shows that restoring it returns the exact $\theta$ at every point [post F41](../findings/fence-posts.md) cited as inert, with gains $1.290994$, $2.160247$, $2.846050$, $3.425395$, $0.836660$ that match the post's own tabulated slacks digit for digit. The mechanism ("only Jacobi can supply the deficiency"), is dead; the closure survives for a different reason. [fence-posts.md](../findings/fence-posts.md) carries the refutation in place.

**But two sentences of L111 are the withdrawn mechanism restated.**

- [bounds.md:421](../findings/bounds.md): "the off-diagonal entries are the **only place the Jacobi identity can enter** a bound on $D$."
- [bounds.md:438](../findings/bounds.md): "The off-diagonal relations remain the untouched reserve, and they are now the **only thing that could separate this from post F10**."

Both are exclusivity claims with no argument, and both are the F41 mechanism in the form r326 refuted: at the maximal tori the marginals separate exactly, without Jacobi. The first also sits against [post F42](../findings/fence-posts.md), whose demand is a disjunction, a closing inequality must consume a $\{2,2,0\}$ moment **or** the $c$-tensor's Jacobi/Bianchi structure, and against [Lemma L112](../findings/bounds.md), where first Bianchi enters a spectral bound through relation (B) without touching an off-diagonal $W^\#$ entry. **Owed: either an argument for the exclusivity, or the word "only" struck from both.**

**What the result is for now.** Its diagonal half is relation (C), already stated independently at [bounds.md:335](../findings/bounds.md) and consumed there and by [Lemma L104](../findings/bounds-relaxations.md), [Lemma L112](../findings/bounds.md) and T9. Its off-diagonal half is consumed by nothing, the block itself calls it "the untouched reserve". So L111's *net current content* is a set of relations nobody uses, and its motivation is withdrawn. **The blast radius of any error here is therefore the block itself**; [INDEX-results.md:129](../findings/INDEX-results.md) carries it with "Gate 2: no verdict on the record", and no downstream result cites it. That is worth stating in the block, because a reader currently has no way to tell that the reformulation is unconsumed.

## 4. The screen that was blind

**What the screen would have had to test, and it is stronger than "sample the diagonal locus".** The pre-correction screen ([bounds.md at 0d14e8dd^](../findings/bounds.md)) read: off-diagonal residual $\le1.3\times10^{-16}$ at the balanced products, the maximal tori, $\mathrm{ad}(\mathfrak{su}(3))$ and padded $W_{\mathbb{CP}^2}$, and $1.1\times10^{-1}$ at random non-critical $W$, "so the relations are consequences of criticality and of nothing weaker".

Both populations lie in cells that cannot decide the question. The catalogue points are critical, so **both** conditions hold there; random Weyl tensors are neither critical nor diagonal, so **both** fail there. **A screen for an equivalence $A\Leftrightarrow B$ that samples only the "both true" and "both false" cells confirms nothing about either implication.** The claim under test was $B\Rightarrow A$, and the only population that can test it is $B\setminus A$, points satisfying the bracket relations. The screen never contained one, and no amount of sampling would have supplied one, because $B\setminus A$ is a measure-zero set. **The design could not fail.** The cheaper tell was free and needed no run at all: $B$ does not contain the symbol $\theta$, while $A$ determines it.

**Is that stated?** Partly. [LEDGER.md:122](../findings/LEDGER.md) carries the weaker, sampling-shaped lesson, a control drawn from a distribution avoiding the counterexample family cannot see it, and every screen must name the record's structured families, and that is a good rule. **The logical form of the lesson is not recorded anywhere**, and it is the more transferable half: it says *which* set to sample without knowing the counterexample family in advance, and it applies to every "equivalently" and "i.e." on the record, not only to those with a measure-zero witness. This is the finding I would carry out of this audit.

**Do other claims in the block rest on the same screen?** No. Everything else in the block is either derived ([bounds.md:421](../findings/bounds.md)'s diagonal pinning, confirmed above), or produced by the separate LP scripts, which [r326](REVIEW_r326.md) I3 reproduced independently to nine digits with its own triple-indexed formulation. The blind screen's blast radius is the "i.e." alone.

**A small drift, flagged rather than glossed.** The correction note says the record's screen "give[s] off-diagonal $1.5\times10^{-1}$". The record's screen reported $1.1\times10^{-1}$, and [r326](REVIEW_r326.md) quotes it as such while measuring $7.6\times10^{-2}$ and $3.4\times10^{-2}$ itself. The two figures entered and left in the same commit, `0d14e8dd`, with no note that the number changed. Nothing analytic turns on it (the contrast is "exactly zero" against "not zero") but the block now attributes to its own past screen a number that screen did not report.

## Provenance and pointers

| check | result |
| --- | --- |
| "Reviewer 326" attribution on the "equivalently" | **Clean.** [REVIEW_r326.md](REVIEW_r326.md) I2 says exactly this, including the diagonal-locus family, the $n(n-3)/2$ count and the wrong $\lambda_k\ne\lambda_l$ restriction. |
| "Reviewer 326" attribution on the withdrawn motivation | **Clean.** r326 I1, with the omitted marginal named. |
| "Reviewer 326" attribution on the sharpness table's withdrawal | **Clean.** r326 I4, ablation and the $4.05\times$ figure both present. |
| commit `0d14e8dd` message against the diff | **Clean**, it states the refutation against its own prior claim, names the screen's defect, and does not overstate. |
| `[post F41](fence-posts.md)` | Resolves; the post exists. **Unanchored**, a bare file link where the record's convention elsewhere in this block is an anchored one. |
| [run_diag_criticality_lp.py](../scripts/runs/run_diag_criticality_lp.py), [run_bilinear_spectrum_max.py](../scripts/runs/run_bilinear_spectrum_max.py), [run_pinned_lp_spectra.py](../scripts/runs/run_pinned_lp_spectra.py) | all present |
| [REVIEW_r326.md](REVIEW_r326.md), [REVIEW_r323.md](REVIEW_r323.md) | present |

## What the block still owes

The correction is right. Five things remain, in descending order of consequence.

1. **The displayed equation is still the false one.** [bounds.md:415–419](../findings/bounds.md) still reads "criticality is equivalent to $M_{kl}=\dots$, **i.e.** $\sum\dots=0$ whenever $\lambda_k\ne\lambda_l$", with the refutation in a blockquote below it. A reader quoting the display quotes the false claim. r326 supplied the repair text; adopt it, criticality $\Leftrightarrow(W^\#)_{kl}=(\theta\lambda_k-\lambda_k^2)\delta_{kl}$ in an orthonormal eigenbasis, splitting as $N$ diagonal relations **and** $\binom N2$ off-diagonal ones, neither half alone being criticality.
2. **r326's fourth I2 correction was never folded in.** The sentence "criticality and $D$ are now expressed in the same variables $c_{k\alpha\beta}$" at [bounds.md:421](../findings/bounds.md) is **byte-identical to its pre-correction form** (`git show 0d14e8dd^`). r326 refutes it: $D=\tfrac12\sum(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})c_{vab}^2$ and the diagonal relations are functions of $T=c^2$, while the off-diagonal relations involve the *signed* products $c_{k\alpha\beta}c_{l\alpha\beta}$, which are not functions of $T$. **The reserve lives in different variables from the quantity it is meant to bound**, which is the whole of what the reformulation was supposed to buy. Three of r326's four I2 findings were folded in and this one was not; that is exactly the half-repaired block the brief warns about.
3. **The two "only" claims of §3 above**, both restatements of the withdrawn F41 mechanism.
4. **The strictness is unquantified.** §2c supplies $\tfrac12(N+\sum_i m_i^2)-1$, with the two-eigenvalue extremal cases worked. One line in the block.
5. **$M_{kl}$ is a third, untabled sense of the letter $M$.** [conventions.md](../findings/conventions.md) tables $M(n)$ the global maximum and $M$ the $n\times n$ sectional matrix, and warns that the two collide. $M_{kl}$ here is a bilinear form on $\Lambda^2$ indexed by *pairs*, and the collision is live rather than theoretical: [r326](REVIEW_r326.md)'s own I2 section writes "for $W=\mathrm{diag}(M_{ab})$" for the sectional matrix three paragraphs from its $M_{kl}$. Either table it or drop the symbol, the result is cleaner stated basis-free as $M=-2W^\#$, so that criticality reads $M=2(W^2-\theta W)$ and the $\delta_{kl}$ never has to be written.

## Computation not performed, and what it would have decided

Nothing in this report required a run, and none was made. Two figures in the block are not analytically checkable and I have not attempted them: the "$0.527$ to $0.741$" criticality residuals of the six measured diagonal elements, and the $1.5\times10^{-1}$ screen residual. A run would decide only whether those two numbers are the ones the record's own measurement produced; **no verdict above depends on either**, because the diagonal locus's off-diagonal residual is exactly zero for the structural reason given in §2b and the $n=4$ witness's non-criticality is exact arithmetic.
