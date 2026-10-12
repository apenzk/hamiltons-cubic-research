# REVIEW r621, Lemma L76, "every symmetric pair $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ is a maximal isotropic subspace"

Reviewer r621, independent adversarial audit, cold from the definitions in [conventions.md](../findings/conventions.md). Target: [Lemma L76](../findings/isotropy-cap.md#L200) at [isotropy-cap.md:200](../findings/isotropy-cap.md#L200), whose content is the block that follows it, [*"REFUTED: there is no gap at 8, and every symmetric pair is maximal"*](../findings/isotropy-cap.md#L202) at lines 202–208, together with the criterion it consumes, [Lemma L75](../findings/isotropy-cap.md#L183) at lines 183–198.

**Analysis only.** Every claim below was derived by hand from the structure constants of $\mathfrak{so}(n)$ in the $\varphi_{ij}$ basis. **No computation of any kind was run**, no rank, no singular value, no screen. The block's own numerics were not re-run; where I confirm one of its numbers I do so by producing the closed form it is a sample of. Everything here is checkable on paper.

## Verdict

**REFUTED as stated, the heading names the wrong half of the symmetric pair, and the object it names is a maximal isotropic subspace at no $(p,q)$ whatever.** The witness is $(p,q)=(3,1)$ at $n=4$, and the refutation is total rather than range-limited: for $\max(p,q)\ge3$ the named subspace fails *isotropy*, and for $p,q\le2$ it is isotropic but *extends*. **The block's mathematics is nonetheless entirely correct**, its own numbers ($\dim\mathfrak m=pq$, $\operatorname{rank}=N-pq$, the pair $(2,4)$ at dimension $8$) are computed on the *odd* part $\mathfrak p=\mathbb R^p\otimes\mathbb R^q$, which is the object the source reviewer named and the heading dropped. **On that object the Lemma is true at every $(p,q)$ with $p,q\ge1$, and I prove it in closed form below**, which promotes it from a check at $n=6,7,8$ to a genuine Lemma. **This is the same error [L36](../findings/isotropy-cap.md#L17)'s warning box was written to correct**, 169 lines above, in the same file, in the same words.

| # | finding | verdict |
| --- | --- | --- |
| 1 | L75's first equivalence, $\mathfrak m$ maximal $\iff[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ | **CONFIRMED**, and the equality is *better* than the inclusion, for a reason the block does not give |
| 2 | L75's second equivalence, $\operatorname{rank}[\mathfrak m,\mathfrak m]=N-\dim\mathfrak m$ | **CONFIRMED**; $N=\binom n2$, and "rank" and "dimension of the span" coincide by bilinearity |
| 3 | L76's heading, on $\mathfrak k=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ | **REFUTED at every $(p,q)$ with $n\ge3$**; witness $(3,1)$ at $n=4$ |
| 4 | L76's content, on $\mathfrak p=\mathbb R^p\otimes\mathbb R^q$ | **CONFIRMED and PROVED** for all $p,q\ge1$, at every $n$, no dimension restriction |
| 5 | The degenerate range | $q=0$ **fails** (the zero subspace is not maximal); $q=1$ and $q=2$ are **fine and non-vacuous** |
| 6 | The four table rows at $d=4,5,6,9$ | $d=4,5,9$ **now closed-form**; $d=6$ **measurement only**, and it is the only row carrying new information |
| 7 | The six singular values of $\sqrt6$ at the cap | **CONFIRMED analytically**: the spectrum is $\sqrt{2p}$ with multiplicity $\binom q2$ and $\sqrt{2q}$ with multiplicity $\binom p2$ |
| 8 | The rank-$15$ tell | **CONFIRMED**, and it is the easy half of L75 used as an error detector, the strongest thing on the page, as the brief says |
| 9 | The Witt-index comparison | **APT but under-qualified**, and the varying-dimension claim is now provable in general, not merely at four rows |
| 10 | Provenance | **CLEAN**, [r66](REVIEW_r66.md) said it, and said it correctly; the transcription into the record is what broke |
| 11 | Pointers | One empty `(#)` target at [isotropy-cap.md:350](../findings/isotropy-cap.md#L350), and one stale anchor at line 257 |

## Conventions I fixed before starting, as the brief requires

- **$\mathfrak m$.** [conventions.md](../findings/conventions.md) records three senses. **I use none of them as a definition.** In [L75](../findings/isotropy-cap.md#L183) and [L76](../findings/isotropy-cap.md#L200) the letter is a free variable ranging over subspaces of $\mathfrak{so}(n)$, constrained only by the isotropy hypothesis $\langle[u,v],w\rangle=0$ for $u,v,w\in\mathfrak m$. Where L76's arithmetic forces a specific subspace I name it $\mathfrak p$ or $\mathfrak k$ explicitly and never write $\mathfrak m$ for it. This matters: the reading "$\mathfrak m=$ the symmetric-pair odd part", which conventions.md attributes to [target.md](../findings/target.md), is exactly the reading under which L76 is *true*, and the heading is written under a fourth reading that is in none of the three.
- **$S_{XYZ}$.** The ordered/unordered collision flagged in [L77](../findings/isotropy-cap.md#L112) **does not reach this audit**, and that is worth saying rather than assuming. Isotropy enters here only as the *vanishing* of $\omega$ on triples from $\mathfrak m$, and a quantity that vanishes vanishes under either count. No mass, no factor, no normalisation.
- **$\theta_0(n)$.** Not used.
- **The pairing.** I work in the half-trace pairing of [conventions.md](../findings/conventions.md), under which $\{\varphi_{ij}\}_{i<j}$ with $\varphi_{ij}=E_{ij}-E_{ji}$ is orthonormal. **Findings 1–6 are pairing-independent**: an orthogonal complement and a rank are unchanged by rescaling the inner product, so the $\sqrt2$ trap that has cost this record cycles is inert on the criterion. **Finding 7 is not**, the value $\sqrt6$ is half-trace with ordered pair columns, and I say so where I derive it.
- **$N=\binom n2$**, tabled in [conventions.md](../findings/conventions.md). Confirmed as the right constant: the perp in L75 is taken inside $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$.
- **Structure constants.** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ totally antisymmetric, from ad-invariance, per [conventions.md](../findings/conventions.md). Load-bearing in §1. The one bracket I use throughout: $[\varphi_{ij},\varphi_{jk}]=\varphi_{ik}$ for distinct $i,j,k$, and $[\varphi_{ij},\varphi_{kl}]=0$ when $\{i,j\}\cap\{k,l\}=\emptyset$.

## 1. The criterion, CONFIRMED, and the equality is not the overclaim the brief suspects

Let $\mathfrak m\subseteq\mathfrak{so}(n)$ be isotropic for $\omega(x,y,z)=\langle[x,y],z\rangle$.

**The inclusion $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$ is not merely automatic, it *is* isotropy, verbatim.** Unwinding: $w\in[\mathfrak m,\mathfrak m]^\perp$ says $\langle[u,v],w\rangle=0$ for all $u,v\in\mathfrak m$; requiring this of every $w\in\mathfrak m$ is precisely $\omega|_{\mathfrak m}=0$. So the two conditions are the same sentence read twice.

**The other inclusion is maximality.** Suppose $w\in[\mathfrak m,\mathfrak m]^\perp\setminus\mathfrak m$ and set $\mathfrak m'=\mathfrak m\oplus\mathbb Rw$. By trilinearity, $\omega|_{\mathfrak m'}=0$ needs only three families of triples: those inside $\mathfrak m$ (zero by isotropy); those of the form $(u,v,w)$ with $u,v\in\mathfrak m$ (zero because $w\perp[\mathfrak m,\mathfrak m]$); and those repeating $w$ (zero by **total antisymmetry**, which is where the ad-invariance of the pairing is spent). So $\mathfrak m'$ is a strictly larger isotropic subspace and $\mathfrak m$ was not maximal. Conversely, if $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ and $\mathfrak m''\supsetneq\mathfrak m$ is isotropic, any $w\in\mathfrak m''\setminus\mathfrak m$ satisfies $\langle[u,v],w\rangle=0$ for $u,v\in\mathfrak m\subseteq\mathfrak m''$, hence lies in $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$, contradiction. Note that checking one-dimensional extensions suffices, and the second half is where that is earned.

**So the block's equality is correct, and it is strictly stronger than the inclusion form for a reason the block never states.** The condition $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ **entails isotropy on its own**, since it contains $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$. The heading of L75 therefore reads correctly as a characterisation over *all* subspaces, with no hypothesis carried in from outside. Had the block written $[\mathfrak m,\mathfrak m]^\perp\subseteq\mathfrak m$ (the naive reading of "no $w$ can be added") that form would **not** be self-certifying, and would be satisfied by non-isotropic subspaces with large bracket span. *The block chose the better of the two and does not say why; a reader checking it against the naive derivation will suspect an overclaim and find none.*

**The second equivalence.** $\dim[\mathfrak m,\mathfrak m]^\perp=N-\dim[\mathfrak m,\mathfrak m]$, and given the inclusion just proved, equality of subspaces is equality of dimensions. Hence $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m\iff\dim[\mathfrak m,\mathfrak m]=N-\dim\mathfrak m$. Two points the brief asks about:

- **$N=\binom n2$.** Confirmed against [conventions.md](../findings/conventions.md).
- **"Rank" versus "dimension of the subspace".** These coincide and no hypothesis is needed. Fixing a basis $e_1,\dots,e_d$ of $\mathfrak m$, bilinearity makes $[\mathfrak m,\mathfrak m]$ the span of the $\binom d2$ brackets $[e_a,e_b]$, so it is the *column space* of the $N\times\binom d2$ matrix of brackets and its rank is that dimension. **The word is safe.** *One consequence the record does not draw, and should*: the criterion is only satisfiable when $\binom d2\ge N-d$, which is a free necessary condition on the dimension of any maximal isotropic. It is used silently in §3 below.

## 2. The Lemma, REFUTED as stated, at every $(p,q)$, and the correct statement proved in general

### 2.1 The object the heading names is not isotropic

Write $\{1,\dots,n\}=A\sqcup B$ with $|A|=p$, $|B|=q$, and let

$$\mathfrak k=\mathfrak{so}(p)\oplus\mathfrak{so}(q)=\operatorname{span}\{\varphi_{ab}:a<b\in A\}\oplus\operatorname{span}\{\varphi_{ij}:i<j\in B\},\qquad \dim\mathfrak k=\tbinom p2+\tbinom q2 .$$

$\mathfrak k$ is a subalgebra, so $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$; isotropy would then force $\langle\mathfrak k,\mathfrak k\rangle\supseteq\langle[\mathfrak k,\mathfrak k],\mathfrak k\rangle=0$ on the image, i.e. $[\mathfrak k,\mathfrak k]=0$. **An isotropic subalgebra is abelian**, and $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ is abelian exactly when $p,q\le2$.

**Witness, smallest available.** $(p,q)=(3,1)$ at $n=4$. Then $\mathfrak k=\mathfrak{so}(3)$ on $\{1,2,3\}$, and $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=\langle\varphi_{13},\varphi_{13}\rangle=1\ne0$. The triple lies inside $\mathfrak k$, so $\mathfrak k$ is not isotropic and *a fortiori* not maximal isotropic. **A single $(p,q)$ suffices to kill the "every", and this is it.** The same triangle refutes $(3,3)$ at $n=6$, $(4,4)$ at $n=8$, and every $(p,q)$ with $\max(p,q)\ge3$.

### 2.2 And where it *is* isotropic it is never maximal, so no range saves the heading

The surviving cases are $p,q\le2$, hence $n\le4$. There $\mathfrak k$ is abelian, so $[\mathfrak k,\mathfrak k]=0$ and $[\mathfrak k,\mathfrak k]^\perp=\mathfrak{so}(n)$, which equals $\mathfrak k$ only if $\mathfrak k$ is the whole algebra and the whole algebra is abelian, $n\le2$, outside the programme's range and outside any honest reading of "symmetric pair". Concretely at $n=4$, $(p,q)=(2,2)$: $\mathfrak k=\operatorname{span}\{\varphi_{12},\varphi_{34}\}$ of dimension $2$, and $\operatorname{span}\{\varphi_{12},\varphi_{34},\varphi_{13}\}$ is isotropic, the three triples evaluate to $\langle[\varphi_{12},\varphi_{34}],\varphi_{13}\rangle=0$, $\langle[\varphi_{12},\varphi_{13}],\varphi_{34}\rangle=\langle-\varphi_{23},\varphi_{34}\rangle=0$, $\langle[\varphi_{34},\varphi_{13}],\varphi_{12}\rangle=\langle-\varphi_{14},\varphi_{12}\rangle=0$, and strictly larger. **So the heading's claim is false at every $(p,q)$ at every $n\ge3$: either by failure of isotropy or by extendability. The heading's "every" cannot be repaired by attaching a range; the object has to change.**

### 2.3 The object the block actually computes, and the general proof

Every number in the block is $pq$-flavoured: *"$\operatorname{rank}[\mathfrak m,\mathfrak m]=N-pq$ at every $(p,q)$"*, and *"the pair $(2,4)$ has $\dim\mathfrak m=8$"*, where $\binom22+\binom42=7\ne8$ but $2\cdot4=8$. **The object is the odd part**

$$\mathfrak p=\mathbb R^p\otimes\mathbb R^q=\operatorname{span}\{\varphi_{ai}:a\in A,\ i\in B\},\qquad\dim\mathfrak p=pq,\qquad\mathfrak p=\mathfrak k^\perp .$$

**Theorem (the repaired L76).** *For every $n$ and every split $p+q=n$ with $p,q\ge1$, $\mathfrak p$ is a maximal isotropic subspace of $\mathfrak{so}(n)$ for the Cartan $3$-form.*

**Proof, in three lines and closed form.**

1. **Isotropic.** $\mathfrak p$ is a coordinate subspace whose graph is the complete bipartite $K_{p,q}$, and $\omega$ in the $\varphi$ basis is supported exactly on triangles of $K_n$ ([isotropy-cap.md](../findings/isotropy-cap.md) states this and it is immediate from $[\varphi_{ij},\varphi_{jk}]=\varphi_{ik}$). A bipartite graph has no odd cycle, hence no triangle, so $\omega|_{\mathfrak p}=0$ identically. *Residual exactly $0$, as the block reports, and now as a theorem rather than a measurement.*
2. **The bracket span.** For $a,b\in A$ and $i,j\in B$: $[\varphi_{ai},\varphi_{aj}]=-\varphi_{ij}$ when $i\ne j$; $[\varphi_{ai},\varphi_{bi}]=-\varphi_{ab}$ when $a\ne b$; and $[\varphi_{ai},\varphi_{bj}]=0$ when $a\ne b$ and $i\ne j$, the index sets being disjoint. So $[\mathfrak p,\mathfrak p]$ is spanned by all $\varphi_{ij}$ with $i,j\in B$ (available whenever $p\ge1$) and all $\varphi_{ab}$ with $a,b\in A$ (whenever $q\ge1$), giving $[\mathfrak p,\mathfrak p]=\mathfrak k$ **exactly**, with no containment slack.
3. **Maximal.** $\mathfrak k^\perp=\mathfrak p$, because the orthonormal basis $\{\varphi_{ij}\}$ splits into within-$A$, within-$B$ and crossing families, and $\mathfrak k$ is spanned by the first two. Hence $[\mathfrak p,\mathfrak p]^\perp=\mathfrak k^\perp=\mathfrak p$, which is L75's criterion. $\square$

**And the rank identity falls out symbolically, which is what the brief asks for in place of sample dimensions.** $\binom{p+q}2=\binom p2+\binom q2+pq$ identically, so

$$\operatorname{rank}[\mathfrak p,\mathfrak p]=\dim\mathfrak k=\tbinom p2+\tbinom q2=N-pq=N-\dim\mathfrak p$$

at every $(p,q)$, with no arithmetic left to check at $n=6,7,8$ or anywhere else. **The record's "verified independently here at $n=6,7,8$" is a spot check on a polynomial identity.**

### 2.4 The degenerate cases the brief asks about

| $q$ | status of $\mathfrak p$ |
| --- | --- |
| $0$ | $\mathfrak p=0$, isotropic but **not maximal** for $n\ge2$: $[\,0,0\,]^\perp=\mathfrak{so}(n)\ne0$. **The "every" must exclude it.** |
| $1$ | $\mathfrak p=\operatorname{span}\{\varphi_{an}:a\in A\}$, $\dim=n-1$, $[\mathfrak p,\mathfrak p]=\mathfrak{so}(n-1)$ of dimension $\binom{n-1}2=N-(n-1)$. **Maximal, and non-vacuous**, it supplies the $d=5$ row at $n=6$. |
| $2$ | $\dim\mathfrak p=2(n-2)$, $[\mathfrak p,\mathfrak p]=\mathfrak{so}(2)\oplus\mathfrak{so}(n-2)$. **Maximal.** It supplies the $d=8$ row at $n=6$, the whole point of the block. |

**So the heading's "every" should carry the range $p,q\ge1$ and nothing more.** No parity condition, no lower bound on $n$, no genericity. *The block carries no range at all, and the one case that genuinely fails ($q=0$), is the one a careless reader would grant.*

### 2.5 A closed form for the singular values, which retires the strongest-looking numeric in the table

Build the bracket matrix with **ordered** pair columns, per [conventions.md](../findings/conventions.md)'s standing rule. Each ordered pair $(\varphi_{ai},\varphi_{bj})$ maps to a *single* basis vector of $\mathfrak k$ with coefficient $\pm1$, and distinct targets receive disjoint sets of columns, so the rows of the matrix are mutually orthogonal and the singular values are the row norms. Counting sources: $\varphi_{ij}$ with $i,j\in B$ receives $2p$ ordered pairs (one per $a\in A$, twice), and $\varphi_{ab}$ with $a,b\in A$ receives $2q$. Hence

$$\operatorname{sing}\big([\mathfrak p,\mathfrak p]\big)=\big\{\sqrt{2p}\ \text{with multiplicity}\ \tbinom q2,\quad \sqrt{2q}\ \text{with multiplicity}\ \tbinom p2\big\}.$$

At $n=6$: $(3,3)$ gives $\sqrt6$ with multiplicity $3+3=6$, **exactly the block's "six values of exactly $\sqrt6$ then nothing"**, the word "exactly" now earned. $(2,4)$ gives $2$ six times and $\sqrt8$ once, rank $7$. $(1,5)$ gives $\sqrt2$ ten times, rank $10$. **Three of the block's measured numbers reproduced from a two-line count.** *This is the check that convinces me the block's numerics are of $\mathfrak p$ and not of $\mathfrak k$, a mislabelled object would not reproduce $\sqrt6$ with multiplicity six.*

## 3. The table, and what it can support

At $n=6$, $N=15$. The symmetric-pair dimensions are $pq\in\{5,8,9\}$ for $p=1,2,3$, so exactly two of the four rows sit on a symmetric pair.

| row | what the closed form says | label the record should carry |
| --- | --- | --- |
| $d=4$, rank $6$, **extends** | **Confirmed, and forced.** $\binom42=6<11=N-d$, so *no* $4$-dimensional subspace can meet the criterion, isotropic or not. The measured rank $6$ is the maximum a $4$-plane can produce. | **Lemma**, provable for all $4$-planes at $n=6$, not merely the sampled one |
| $d=5$, rank $10$, maximal | **Existence confirmed** by $(1,5)$, whose bracket span is $\mathfrak{so}(5)$ of dimension $10$. Note $\binom52=10=N-d$ **exactly**, so a maximal isotropic $5$-plane needs all ten brackets independent, the row sits on the counting bound with zero slack. | **Lemma** for existence; **Observation** that the *sampled generic* $5$-plane is maximal |
| $d=6$, rank $9$, maximal | **Not confirmed.** $pq=6$ has no solution with $p+q=6$, and [r66](REVIEW_r66.md) reports that no *coordinate* maximal isotropic has dimension $6$ at $n=6$ either. So this row is the only one carrying information not derivable, and it asserts a **non-coordinate, non-symmetric-pair** maximal isotropic. | **Observation**, at $n=6$ only |
| $d=9$, rank $6$, maximal | **Confirmed** by $(3,3)$, and upgraded by the cap rigidity recorded above in the same file, every isotropic at the cap is $SO(6)$-conjugate to it. | **Lemma** |

**On the labels.** The record labels L76 a `Lemma` on the strength of a check at $n=6,7,8$, Observation-grade evidence under a Lemma heading. **That defect is now moot rather than repaired**: the corrected statement is a Lemma, proved above at every $(p,q)$. But it was a defect at the time of writing, and [INDEX-results.md](../findings/INDEX-results.md) row 76 carries the same label with the same wrong object and "Gate 2: no verdict on the record".

**The rank-$15$ tell, and the brief is right that it is the strongest thing on the page.** The argument is the easy half of L75, used contrapositively: isotropy gives $[\mathfrak m,\mathfrak m]\subseteq\mathfrak m^\perp$, hence $\operatorname{rank}[\mathfrak m,\mathfrak m]\le N-\dim\mathfrak m$ **for every isotropic $\mathfrak m$, with no maximality involved**. At $n=6$, $d=6$ the ceiling is $9$; a measured $15$ says $[\mathfrak m,\mathfrak m]=\mathfrak{so}(6)$, so $[\mathfrak m,\mathfrak m]^\perp=0$, which cannot contain a nonzero $\mathfrak m$. **The candidate was therefore not isotropic to the working tolerance, and the rank measurement diagnosed it.** *This is a numerical failure caught by an inequality that costs one line, and the record should state it as a standing self-check on every isotropy computation rather than as an anecdote about one polish.*

**The structural claim and the Witt index.** The comparison is **apt but under-qualified, and the claim it decorates is now provable in general.**

- *Apt*: for a **nondegenerate** quadratic form over a field, Witt's theorem does make every maximal totally isotropic subspace share a dimension. So "dimension is an invariant of maximality in degree $2$ and is not in degree $3$" is a true and useful contrast, and the word "nondegenerate" is owed.
- *Under-qualified in a second way*: the sentence sits close enough to $\lfloor n^2/4\rfloor$ to invite reading the cap as a Witt index. It is not, it is the **maximum** over a spectrum of dimensions, not a common value, and the whole force of L76 is that the spectrum is wide.
- *And the claim of varying dimension needs no rows at all.* §2.3 gives maximal isotropics of dimension $p(n-p)$ for every $1\le p\le n/2$, and $p\mapsto p(n-p)$ is strictly increasing there. **So at every $n\ge4$ the Cartan $3$-form has maximal isotropic subspaces of at least $\lfloor n/2\rfloor$ distinct dimensions, proved.** At $n=6$ that is $\{5,8,9\}$ before a single measurement. **L75's own sentence, *"maximal isotropic subspaces occur at dimensions $5$, $6$ and $9$"*, is therefore both weaker than what is provable and stale against the block $17$ lines below it, which says the set includes $8$.**

## 4. What L76 feeds, and the chain does not need it

**What it contributes:** it kills a false census (the reported gap at $d=8$), and it supplies proved maximal isotropics at $\lfloor n/2\rfloor$ distinct dimensions. Its consumer is the single sentence closing [L75](../findings/isotropy-cap.md#L183), *"the middle band is not proper subspaces of a symmetric pair and cannot inherit the cap rigidity; it needs an argument of its own"*, for which dimension-variation alone is enough, and which §3 now establishes without numerics.

**What it does not contribute:** nothing to the rigidity chain. That chain runs *at the cap*, $d=\lfloor n^2/4\rfloor$, where isotropy kills $S_{\mathfrak{mmm}}$ and $\gamma=0$ kills $S_{\mathfrak{mhh}}$, yielding a $\mathbb Z_2$-grading, a symmetric pair, Cartan's list and the balanced split. **It needs only the balanced pair, and it needs it as a conclusion rather than as a hypothesis**, the pair is what the grading *produces*, and maximality of the resulting $\mathfrak p$ is never invoked. So a reader may drop L76 entirely and the chain is unchanged.

*And note the chain's own $\mathfrak m$ is the odd part*: $\gamma=0$ makes $\mathfrak m^\perp$ the subalgebra $\mathfrak k$, so $\mathfrak m=\mathfrak p$. **Every other block in the file is consistent with §2.3's reading. L76's heading is the sole outlier in the file.**

## 5. Checklist

**Provenance, CLEAN, and this is one of the two the brief says came back clean.** The block credits "(Reviewer 66, verified independently here)", and [REVIEW_r66.md](REVIEW_r66.md) does contain it, correctly: *"For m = **the off-diagonal block** of so(p)+so(q), [m,m] = so(p) ⊕ so(q) = m^⊥ exactly (including p = 1, where [φ_{0j},φ_{0k}] = −φ_{jk} spans so(q)). Hence [m,m]^⊥ = m and m cannot be enlarged, at any n and any split."* **That is my §2.3, including the $p=1$ case and the "at any n and any split".** The quoted census caveat is also genuine: `git show 66457b5d` shows the text it replaced reading *"These rows describe the generic subspace at each dimension and are not a classification"*, so the block quotes the record accurately against its own history. **The defect is transcription, not attribution: the record dropped "the off-diagonal block of" and the sentence inverted.** The same commit wrote the same error into [plan.md](../plan.md), where it survives as *"every symmetric pair is maximal ($pq=5,8,9$)"*, the parenthesis giving the correct dimensions under the incorrect name.

**Hedging clauses.**

- *"every symmetric pair"*, **the failure**, per §2.
- *"at every $(p,q)$ for $n=6,7,8$"*, a polynomial identity presented as a three-dimension sweep. Harmless in truth value, misleading in strength.
- *"isotropy residual exactly $0$"*, true of $\mathfrak p$ and **false of the named $\mathfrak k$**, where the residual is bounded below by the triangle $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=1$.
- *"clean singular-value gaps throughout"* (L75), three of the four rows are symmetric pairs or forced, where the gap is infinite by §2.5 and the phrase is vacuous; the one row where "gap" carries content is $d=6$, at $3.5\times10^{-9}$ against $0.436$. **The word "throughout" spreads one real gap across four rows.**
- *"Maximal dimensions now known at $n=6$ include $5,6,7,8,9$"*, the "include" is honest, and $\{5,8,9\}$ of those are now proved while $\{6,7\}$ remain measured. The record does not distinguish them.
- *"the observation that generic isotropic subspaces at $d=5,6,7$ are maximal"*, "generic" here means "sampled and polished", not "outside a proper closed subvariety". No genericity statement is proved.

**Does the file settle it above or below? Yes, 169 lines above, and in the same words.** [L36](../findings/isotropy-cap.md#L17)'s warning box at line 31 reads: *"THE FIRST VERSION NAMED $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ AS THE MAXIMISER, AND THAT IS FALSE TWICE OVER. It is $\mathfrak m^\perp$ rather than $\mathfrak m$; … it is not admissible at all, since an isotropic subalgebra is abelian, and at $n=6$ already $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=1\ne0$ inside the first $\mathfrak{so}(3)$."* **That box refutes L76's heading exactly, with my witness, and closes by pointing *"This file states the correct object 190 lines below"*, a pointer that passes *through* L76 on its way to line 214.** So the file contains its own refutation, the refutation names the same triangle, and the two blocks were audited independently without either being read against the other.

**Pointers.**

- **[isotropy-cap.md:350](../findings/isotropy-cap.md#L350) carries an empty target**: `[Lemma L36](#)`. The brief predicted at least one; this is it, and it resolves to nothing.
- **[isotropy-cap.md:257](../findings/isotropy-cap.md#L257) carries a stale anchor**: it links `#lemma-l81--the-sharp-centraliser-criterion-wider-than-lemma-l32--requires-pge2`, while the heading at line 271 now reads *"Lemma L81 (the sharp centraliser criterion), REQUIRES $m\ne3$"*. The heading was rewritten and the link was not.
- **The L76 block itself contains no links at all**, no pointer to [L75](../findings/isotropy-cap.md#L183) whose criterion it consumes, none to [L36](../findings/isotropy-cap.md#L17) whose warning box refutes it, none to [r66](REVIEW_r66.md) which it credits by name.

## 6. What is owed, and it is all reachable

1. **Rename the object in the heading of [L76](../findings/isotropy-cap.md#L200), in [INDEX-results.md](../findings/INDEX-results.md) row 76, and in [plan.md](../plan.md).** *"every symmetric pair's odd part $\mathbb R^p\otimes\mathbb R^q$, $p,q\ge1$, is a maximal isotropic subspace"*, or equivalently *"the complete bipartite subspace $K_{p,q}$"*. **One phrase, three files.**
2. **Replace the $n=6,7,8$ verification with §2.3's proof.** Three lines, valid at every $n$, and it is what makes the `Lemma` label honest.
3. **Record §2.5's singular-value formula.** It closes the cap row's $\sqrt6$ and the $(2,4)$ rank in closed form, and it turns "clean gaps throughout" into a statement with a proof for three of four rows.
4. **State the rank ceiling $\operatorname{rank}[\mathfrak m,\mathfrak m]\le N-\dim\mathfrak m$ as a standing isotropy self-check**, which is what caught the rank-$15$ run; and record the free necessary condition $\binom d2\ge N-d$, which forces the $d=4$ row.
5. **Update L75's stale sentence** from *"dimensions $5$, $6$ and $9$"* to the general statement: at least $\lfloor n/2\rfloor$ distinct dimensions at every $n\ge4$, namely $p(n-p)$ for $1\le p\le n/2$. Qualify the quadratic form as **nondegenerate**, and say the cap is a maximum rather than a Witt index.
6. **Cross-link [L36](../findings/isotropy-cap.md#L17)'s warning box to [L76](../findings/isotropy-cap.md#L200)**, since the box is the refutation and the block is the offence, and fix the two broken pointers in §5.

*Nothing above needs a computation. Items 1–6 are edits and short proofs.*
