# REVIEW r507, Lemma L120

**Target:** [Lemma L120](../findings/second-order.md) (*"$L_M$ is block-diagonal over the sign characters at every diagonal critical point"*), in [findings/second-order.md](../findings/second-order.md), the block at `#### Lemma L120` (line 601) down to `#### Lemma L121`.

**Reviewer:** r507, cold and independent. Everything below is derived from the definitions in [findings/conventions.md](../findings/conventions.md) and the $\circ$-product; the record was read afterwards, for collision only.

**Analysis-only footing observed.** No search, sweep, census or falsifier hunt was run, and **no computation of any kind was used**, every check below is symbolic and closes by hand. Nothing in this audit is blocked on a run.

**VERDICT: CONFIRMED**, the decomposition and the block-diagonality are *proved*, not merely plausible: the dimension count closes identically, the three characters are the right ones, the isotypic separation is exact for the full sign group, and $\Gamma$-invariance of a coordinate-diagonal $M$ is immediate. **Two clauses of the printed block are nonetheless defective and are named as D1 and D2 below**, D1 is false at $n=4$; D2 is an omission in the sentence that all 13 citations rest on.

---

## C1, the dimension count closes exactly, at every $n$

$\dim\mathcal W_n$ is **not stated in [conventions.md](../findings/conventions.md)** (see N1). Taking $\mathcal W_n$ as [README.md](../README.md) defines it (algebraic curvature operators, Bianchi and Ricci-flat), the standard count is $\dim\mathcal W_n=\tfrac1{12}n(n+1)(n+2)(n-3)$, equivalently $\tbinom{N+1}2-\tbinom n4-\tbinom{n+1}2$ with $N=\tbinom n2$. Then

$$\frac{n(n-3)}2+2\binom n4+(n-3)\binom n2=\frac{n(n-3)}2\Big[1+\frac{(n-1)(n-2)}6+(n-1)\Big]=\frac{n(n-3)}{12}(n^2+3n+2)=\frac{n(n-3)(n+1)(n+2)}{12}.$$

Identical, at every $n$. Spot values: $10=10$ at $n=4$, $35=35$ at $n=5$, $84=84$ at $n=6$. The block's own factorisation is reproduced character-for-character. **No summand misses.**

The block calls this "transcription insurance and nothing more", which is right as far as it goes, but it undersells it: the count closes *per character* as well as in total (C3), and that is not insurance.

## C2, the three characters are correct, and the isotypic separation is exact

$\Gamma=\{\pm1\}^n$ acts on $\Lambda^2$ by $g\cdot e_{ij}=\varepsilon_i\varepsilon_j e_{ij}$, so on $\mathrm{Sym}^2(\Lambda^2)$ the element $e_{ij}\odot e_{kl}$ carries $\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_l$. Since $\varepsilon^2=1$ this **is** $\chi_S$ with $S=\{i,j\}\,\triangle\,\{k,l\}$, which is [Lemma L123](../findings/second-order.md)'s own observation, and it makes the trichotomy a statement about $\lvert S\rvert$:

| overlap | $S$ | character | how many basis elements share it |
| --- | --- | --- | --- |
| two indices | $\emptyset$ | trivial | $e_{ij}\odot e_{ij}$, so $\tbinom n2$ |
| one index | $\{j,k\}$ | $\varepsilon_j\varepsilon_k$ | $e_{ij}\odot e_{ik}$ over $i\notin\{j,k\}$, so **exactly $n-2$** |
| none | $\{i,j,k,l\}$ | $\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_l$ | the $3$ pairings of the $4$-set |

Each count is *exhaustive*, not merely a lower bound: $\lvert S\rvert=2$ with $S=\{j,k\}$ forces the two $2$-sets to be $\{j,m\},\{k,m\}$ for a common $m\notin\{j,k\}$, $n-2$ choices and no others; $\lvert S\rvert=4$ forces a partition of the $4$-set into two $2$-sets, $3$ of them and no others. So the listed spaces are the *full* character eigenspaces of $\mathrm{Sym}^2(\Lambda^2)$, not subspaces of them.

**Distinctness is exact.** $S\mapsto\chi_S$ is the standard bijection $2^{[n]}\to\widehat{(\mathbb Z/2)^n}$, so distinct $4$-sets, distinct pairs, $4$-sets against pairs, and everything against the trivial character are pairwise distinct characters. $\Gamma$ is abelian with real characters, so isotypic component $=$ character eigenspace, and distinct ones are orthogonal under the $\Gamma$-invariant pairing. **Nothing merges, at any $n$, for the full sign group.** The three block sizes are therefore forced.

## C3, the passage from $\mathrm{Sym}^2(\Lambda^2)$ to $\mathcal W_n$: the stated $2$ and $n-3$ ARE the post-subtraction dimensions

This was the sharpest thing to check and the block gets it right. Both subtracted pieces are $O(n)$-, hence $\Gamma$-, submodules, so each removal lands inside single characters and can be accounted character by character.

- **$\Lambda^4$** has basis $e_i\wedge e_j\wedge e_k\wedge e_l$, one per $4$-set, carrying $\chi_{\{i,j,k,l\}}$. It therefore lies **entirely** in the $4$-set characters, one dimension each, and touches the trivial and pair characters not at all. Since $\mathrm{Alt}$ is the equivariant orthogonal projection onto it ([conventions.md](../findings/conventions.md)), first Bianchi is *vacuous* off the $4$-set characters, exactly the block's "first Bianchi being empty there since it needs four distinct indices". $3-1=2$. ✔
- **$\mathrm{Sym}^2(\mathbb R^n)$** (the Ricci part, injected $O(n)$-equivariantly) splits as $n$ dimensions of trivial character ($e_a\odot e_a$) plus $\tbinom n2$ dimensions carrying $\chi_{\{a,b\}}$, one per pair. So the trivial block loses $n$ and each pair block loses $1$, and the $4$-set blocks lose nothing, "a trace needs a repeated index". $\tbinom n2-n=n(n-3)/2$ ✔ and $(n-2)-1=n-3$ ✔.
- The per-character Ricci tally is $n+\tbinom n2=\tbinom{n+1}2=\dim\mathrm{Sym}^2(\mathbb R^n)$, so nothing is double-counted or dropped.

**Answer to the question the brief poses:** the stated $2$ and $n-3$ are the $\mathcal W_n$ dimensions, already net of both subtractions, they are *not* $\mathrm{Sym}^2(\Lambda^2)$ dimensions carried over. The trivial block's identification with $\mathcal D_n$ is likewise exact: the trivial isotypic is the pair-diagonal operators, Bianchi is automatic on them (every term of $R_{ijkl}+R_{iklj}+R_{iljk}$ vanishes on four distinct indices), and Ricci-flatness is $\sum_bS_{ab}=0$, which is [conventions.md](../findings/conventions.md)'s $\mathcal D_n=\{S\text{ symmetric, hollow},S\mathbf 1=0\}$ verbatim. The $n$ row-sum conditions are independent already at $n=4$ (the four row-sum vectors of $S_{12},S_{13},S_{14},S_{23}$ span $\mathbb R^4$), giving $\dim\mathcal D_4=2$.

## C4, "at every diagonal critical point": what each route actually needs

**Equivariance route, verified, and the $\Gamma$-invariance question has a clean answer.** "Diagonal" here is [conventions.md](../findings/conventions.md)'s sense: *diagonal in the coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame of $\mathbb R^n$*, **not** diagonal as an operator on $\Lambda^2$. For such an $M$, $g\vert_{\Lambda^2}$ is diagonal in the very basis $M$ is diagonal in, so $gMg^{-1}=M$: **a coordinate-diagonal $M$ is exactly a $\Gamma$-invariant element**, and indeed *the trivial-character isotypic is precisely the coordinate-diagonal operators*. Since $Q$ is $O(n)$-equivariant, so is $\circ$, hence $g\cdot(M\circ X)=(gM)\circ(gX)=M\circ(gX)$: $L_M$ is $\Gamma$-equivariant and preserves every character eigenspace. With C2's distinctness this is the whole lemma. The step survives a Weyl projection, that projection being $O(n)$-equivariant too, as [Lemma L123](../findings/second-order.md) already notes.

**Criticality is never used** (D3). Nothing above touches $Q(M)=\theta M$; only $\Gamma$-invariance of $M$ and $L_M(\mathcal W_n)\subseteq\mathcal W_n$ enter, the latter from $Q(\mathcal W_n)\subseteq\mathcal W_n$ by polarisation. This matters, because [Lemma L123](../findings/second-order.md)'s own scope-correction paragraph and [Lemma L122](../findings/second-order.md) both need the diagonality-only version to transport a block to a frame where $W$ is *not* diagonal, and [r351](REVIEW_r351.md) records the support argument as holding "for every diagonal $M$, critical or not, Weyl or not".

**The fusion box is right in substance, incomplete in its $n=4$ list** (D4). On $\Gamma\cap SO(n)$ one has $\chi_{[n]}=1$, so $\chi_S=\chi_{S^{\mathsf c}}$; with $\lvert S\rvert\in\{0,2,4\}$ a fusion needs $\lvert S\rvert+\lvert S^{\mathsf c}\rvert=n\le8$, and the box's $n=4$ (trivial with the $4$-set), $n=6$ (pair with $4$-set), $n=8$ (two complementary $4$-sets) are each correct, as is "nothing fuses at $n\ge9$". **The box omits one case:** at $n=4$, $\lvert S\rvert=\lvert S^{\mathsf c}\rvert=2$, so the complementary *pair* blocks $\{1,2\}/\{3,4\}$, $\{1,3\}/\{2,4\}$, $\{1,4\}/\{2,3\}$ fuse as well, three fusions the box does not list. Harmless to L120, which uses the full group, but the box is a cautionary enumeration and is read as complete.

## C5, the consequence, which is what the 13 citations use

**"$\binom n4$ of them have size $2$", correct**, one $V_{ijkl}$ per $4$-subset, each $2$-dimensional by C3.

### D1, "the largest block a non-diagonal direction occupies has size $n-3$" is FALSE at $n=4$

A non-diagonal direction lies in some $V_{ijkl}$ (size $2$) or some $V_{jk}$ (size $n-3$), so the largest is $\max(2,n-3)$. That is $n-3$ for $n\ge5$, and at $n=4$ it is $\mathbf 2$ against $n-3=1$. **Witness:** at $n=4$ the six pair blocks are one-dimensional while the single $4$-set block $V_{1234}$ is two-dimensional. The clause needs "$\max(2,n-3)$", or the scope "$n\ge5$".

### D2, "L24's criterion is checkable block by block" omits the one block that must be cut, and this is the load-bearing defect

[Lemma L24](../findings/second-order.md)'s criterion is $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$ **on $W^\perp$**, and $W^\perp$ does not meet the blocks evenly:

- $e=M/\theta$ is coordinate-diagonal, hence **lies in $\mathcal D_n$**, the trivial-character block, by C4.
- Distinct isotypics are orthogonal, so **every $V_{ijkl}$ and every $V_{jk}$ lies wholly inside $W^\perp$** and may be checked entire.
- **$\mathcal D_n$ is the one block $W^\perp$ cuts**, to $\mathcal D_n\cap e^\perp$ of dimension $\tfrac{n(n-3)}2-1$.

The cut is not cosmetic. $L_ee=e\circ e=\tfrac12\big(Q(2e)-2Q(e)\big)=Q(e)=Q(W)/\theta^2=e$, so $L_e$ has eigenvalue $1$ on $\mathcal D_n$ **at every diagonal critical point**. Read literally, "the criterion is checkable block by block" therefore reports $\lambda_{\max}(L_e\vert_{\mathcal D_n})\ge1>\tfrac12$ and refutes local maximality of *every* diagonal critical point, the balanced sphere product included. **The sentence as printed needs "block by block, the $\mathcal D_n$ block restricted to $e^\perp$".**

*Corroboration from inside the record.* [Lemma L127](../findings/second-order.md)'s block table prints the $\mathcal D_n$ row as $\sigma(L_e\vert_{\mathcal D_n})=\{1,\lambda_p^{p-1},\lambda_q^{q-1},(-\mu)^{(p-1)(q-1)},0^{\text{rest}}\}$ and answers "reaches $\tfrac12$? **no**", a table containing a $1$ and answering "no" is only consistent under the omitted convention. [plan.md](../plan.md) line 51 states the caveat outright, *"the restriction to $W^\perp$ is not optional, since $L_ee=e$ forces $\lambda_{\max}(L_e)\ge1$"*, and [Lemma L125](../findings/second-order.md) supplies the general off-$W^\perp$ form. **So the record holds the correction everywhere except in the sentence that the 13 citations quote.**

*One scope note attached to D2.* The clean statement "only $\mathcal D_n$ is cut" holds **under L120's own hypothesis** that $M$ is coordinate-diagonal. Where L120's decomposition is used in a frame in which $W$ is *not* diagonal, the [Lemma L123](../findings/second-order.md) transport, and [Lemma L124](../findings/second-order.md)'s half-flat family, where the box records the top eigenvector of $G$ being $W$'s own component "the direction Lemma L24 excludes by $X\perp W$", $W$ has components in the $4$-set blocks too and more than one block is cut. That is consistent with the above and worth keeping visible.

## C6, the label, the anchor, and the index

| check | finding |
| --- | --- |
| `[Lemma L24](#)` in the statement (line 605) | **dead anchor, confirmed.** The live form exists and is used in the same file at line 698: `#lemma-l24--second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement`. The file carries **13** `](#)` links in total, so this is a file-wide transcription defect rather than one link |
| [INDEX-results.md](../findings/INDEX-results.md) row 120 | `| **120** | Lemma | ... | second-order.md |`, a bare `Lemma`, i.e. Gate 1 and Gate 2 claimed. **This is honest**: the section preamble above the heading records *Gate 2, [r345](REVIEW_r345.md) and [r346](REVIEW_r346.md) on identical briefs*, and both review files exist. No Gate-2-owed text sits inside the block. **No defect here**, unlike the three results the brief warns of |

## C7, collisions across the record: none against L120

Everything restating the decomposition agrees with it, and where the record disagrees with itself L120 is the side that wins:

- [Lemma L127](../findings/second-order.md)'s table: $\binom n4$ four-set, pair blocks split $pq$ cross-factor $+\ \binom p2+\binom q2$ within-factor $=\binom n2$ ✔, and both pair spectra have $1+(n-4)$ and $1+(p-3)+(q-1)$ entries $=n-3$ ✔.
- [r351](REVIEW_r351.md) recovers the within-factor pair spectrum at dimension $n-3$ independently, and kills the halved [Lemma L122](../findings/second-order.md) *by* contradiction with L120.
- [plan.md](../plan.md) I14 names the group as $\Gamma\cap SO(n)$; the item **already records this as a scope correction owed to itself**, resolved in L120's favour. [r374](REVIEW_r374.md) line 168 states the same resolution.
- [Lemma L27](../findings/nondegeneracy.md)'s summand decomposition **over-counts at $p=2$**, $86$ against $\dim\mathcal W_6=84$ at $S^2\times S^4$, per [Lemma L126](../findings/second-order.md) and [r369](REVIEW_r369.md). L120's count closes identically at every $n$, so L120 is the correct one and L27's list is the defective one. Flagged for whoever audits L27; it does not touch L120.
- Later sections of [second-order.md](../findings/second-order.md) (the per-frame blindness note at line 789, [trap 44](../findings/INDEX-traps.md)) state *limitations* of the decomposition, not contradictions of it.

---

## Summary of defects

| id | severity | where | what |
| --- | --- | --- | --- |
| **D1** | **false as printed** | statement, line 605 | "largest non-diagonal block has size $n-3$", at $n=4$ it is $2$. Needs $\max(2,n-3)$ or scope $n\ge5$ |
| **D2** | **load-bearing omission** | statement, line 605 | "checkable block by block" without "the $\mathcal D_n$ block restricted to $e^\perp$". $L_ee=e$ and $e\in\mathcal D_n$, so the literal reading refutes every diagonal critical point. Cited 13 times; the correction exists in [plan.md](../plan.md) and [Lemma L125](../findings/second-order.md) but not here |
| **D3** | scope over-statement | heading and statement | "critical" is unused; diagonality alone suffices, and the wider scope is what [Lemma L123](../findings/second-order.md) needs |
| **D4** | incomplete enumeration | the $SO(n)$ fusion box | at $n=4$ the three complementary **pair** fusions are omitted. Substance of the box unaffected |
| **D5** | transcription | line 605 | `[Lemma L24](#)` dead; the live anchor exists in the same file. 13 such links file-wide |
| **N1** | record gap | [conventions.md](../findings/conventions.md) | $\dim\mathcal W_n$ is not stated there, although the brief and the block both need it. Suggest adding $\dim\mathcal W_n=\tfrac1{12}n(n+1)(n+2)(n-3)$ |

**VERDICT: CONFIRMED.** The decomposition and the block-diagonality are proved from the definitions, at every $n$, for the full sign group; D1–D5 are corrections owed to the printed text, D2 being the one a citing argument can trip over.
