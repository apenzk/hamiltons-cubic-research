# REVIEW r266, Gate 2, restitution and the 10,393 kernel

Reviewer 266. Commits under review: `d46cda0` (primary), `26833c0`, `ef6ed9e`.
Primary files: [run_restitution_kernel.py](../scripts/runs/run_restitution_kernel.py), [references/weyl-polarization-primer/notes.md](../references/weyl-polarization-primer/notes.md) and the stored [paper.pdf](https://arxiv.org/abs/2606.24023), [plan.md](../plan.md) section 2 item 1, [.claude/hooks/cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py).
Scripts: [scripts/reviewers/r266/](../scripts/reviewers/r266/). Reviewer 265 runs the identical brief concurrently and independently.

Every number below comes from a route that shares nothing with the reviewed script. The restitution table is reproduced with **no floating point and no sample points at all**, from the incidence matrix "index tuple $\mapsto$ its multiset". The kernel split is measured by evaluating all $10{,}395$ Brauer contractions on **three independent Weyl tensors** as well as on the diagonal, batched over $200$ samples per cell. The symmetrised count is an **exact orbit count**, done twice (by canonicalisation and by Burnside), with no tensor arithmetic in it.

| # | Claim | Verdict |
|---|---|---|
| 1 | Does polarization say what the record now claims? | **THE CITATIONS ARE VERBATIM AND THE INFERENCE IS REFUTED, with the witness.** Theorem I.2.1, Remark I.2.2 and Remark I.2.4 read in the stored PDF exactly as [notes.md](../references/weyl-polarization-primer/notes.md) states them, and the abstract consequence ($\ker\mathcal R_d$ is the non-symmetric complement, $\mathcal R_d$ injective on $\mathrm{Sym}$), is correct for **any** finite-dimensional representation, Weyl tensors included. **But that is not the map r260 measured.** r260's operation is the composite *restrict the domain from $V^{\otimes12}$ to $\mathrm{Weyl}_n^{\otimes3}$*, then restitute; Remark I.2.2 governs only the second factor. Measured at the record's own cells: the invariant multilinear forms on **three independent** Weyl slots already have dimension $\mathbf 2$ at $n=6$ and $n=7$ (the same $2$ as on the diagonal) so **the non-symmetric complement is ZERO-dimensional and all $10{,}393$ is subspace loss**. Remark I.2.2 accounts for $0$ of $10{,}393$, $0.000\%$. The same collapse at the warm-up cell: symmetric traceless, $14=14+0$ at $n=3,4,5,6,12$ |
| 2 | The numerical identification | **THE $2$ IS THE SAME $2$; THE REASON GIVEN FOR IT IS BACKWARDS.** $\dim(\mathrm{Sym}^3\mathrm{Weyl}_n)^{O(n)}=2$ at $n=6,7$ and stably, and r260's rank **is** that dimension, by Remark I.2.4 plus the FFT, not by coincidence. *But "r250's $I_1,I_2$ with $I_2=I_1/2$" names the regime where the count is **ONE**.* Reproduced independently: $\mathrm{rank}(I_1,I_2)=1$ with the ratio pinned at exactly $+0.500000000$ over $30$ samples at $n=4,5$, and $=2$ with the ratio ranging over $[-8.98,+24.23]$ at $n=6,7,8,12$. **The relation is what has to FAIL for the number to be $2$**, and it fails exactly where r260 measured. The sentence appears four times, commit message, [notes.md](../references/weyl-polarization-primer/notes.md), [plan.md](../plan.md), and the script header |
| 3 | The verification script | **THE TABLE IS EXACT, ASSERT 2 IS ASSERT 1 RESTATED, AND THE ASSERT IS NOT THE STATEMENT IN PLAY.** All nine cells reproduce over $\mathbb Z$ with no sampling: $\mathrm{rank}\,\mathcal R_d$ is the number of distinct monomials reached, $\binom{V+d-1}{d}$ by inspection. `assert total - r == total - sd` is `assert r == sd` with the same integer subtracted from both sides and **cannot fire independently**. The point count only ever *lower*-bounds a rank, and the bare `tol=1e-8` is an **absolute** tolerance: rescaling the identical mathematics by $10^{-3}$ makes $(3,3)$ read $7$ instead of $10$ and $(4,4)$ read $\mathbf 0$ instead of $35$. **Applied to the object the record cares about the assert fails by five orders of magnitude** ($\dim\mathrm{Sym}^3(\mathrm{Weyl}_6^*)=102{,}340$ against a measured rank of $2$) because the record has only the $10{,}395$ **invariant** functionals. The equivariant form, $\mathrm{rank}=\dim(\mathrm{Sym}^dV^*)^{O(n)}$, is the true one and the script never tests it |
| 4 | What the record now claims is open | **THE BRIEF'S PREMISE IS WRONG (OBLIGATION (i) WAS NEVER EDITED) AND ITEM 1 NOW CARRIES THE CLAIM AND ITS NEGATION THREE TIMES.** `d46cda0` is $+5/-1$ on [plan.md](../plan.md); obligation (i) still reads *"reopened, and no literature closes it. The restriction kernel is the whole difficulty"*, and the retained third paragraph still reads *"A basis on twelve free legs says nothing once the three slots are filled with the same $W$"*. **Nothing true was dropped (no `ae44228` repeat**) but nothing false was withdrawn either. The one new formulation, *"on the symmetrised functionals restriction loses nothing"*, is **refuted exactly**: the symmetrised $\gamma_D$ span $\mathbf{1779}$ dimensions (orbit count, two ways) and restrict to rank $2$, so it loses $\mathbf{1777}$ |
| 5 | The skill and hook change | **THE GATE MISSES THE RECORD'S OWN REOPENINGS AND THE TRAILER IT DEMANDS IS SATISFIED BY A FULL STOP.** `_opens_an_item` matches four literal words while its docstring promises *"its subject says an item opened"*, `475c32e`, a `fix(` staging [plan.md](../plan.md) whose subject says *"is open"* and whose diff flips an item to **OPEN**, does not fire; nor does `62ccb44`, nor *"re-opened"*, nor *"REFUTES the closure"*. **The primary commit `d46cda0` does not fire either.** `_searched` is a bare `re.search` over the whole Bash command: `Searched: yes`, `Searched: .`, and *"I Searched: nothing, and I am not defending it"* all pass, as does an `echo` that never reaches the message. Three circumventions need no dishonest trailer at all, the cheapest being a `docs(` subject, which exits before the gate is reached |
| 6 | Anything from r259–r264 still unapplied | **TWO LIVE, AND ONE OF THEM IS IN ITS FIFTH CYCLE.** The Gram identity's **Frobenius / positive-definiteness** reason (asked for by r261, r262, r263 and r264), occurs **zero** times in [findings/brauer-pairing.md](../findings/brauer-pairing.md), [findings/INDEX.md](../findings/INDEX.md) or [scripts/runs/](../scripts/runs/). [plan.md:55](../plan.md) still reads *"A3 cannot start without it"*. Everything else applied: the theorem box is gone from both files, *"Independence is settled (Lehrer–Zhang 3.4)"* is gone, *"all 40 pairs"* is gone, the r244 pricing is corrected in place, the $19/16$ collision is fixed. **A new one:** `d46cda0` touched only [plan.md](../plan.md), so [findings/INDEX.md](../findings/INDEX.md) and [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) still say the restriction kernel is the open difficulty, which this review finds is **correct**, leaving the record right in the two files the cycle did not touch |

---

## Claim 1, the source is quoted exactly, and the inference does not survive the slots being Weyl tensors

Evidence: [c1_split_the_kernel.py](../scripts/reviewers/r266/c1_split_the_kernel.py), [out_c1_split_the_kernel.txt](../scripts/reviewers/r266/out_c1_split_the_kernel.txt).

### What the PDF says, read from the PDF

The stored paper is real and the three citations are verbatim. Theorem I.2.1 gives the unique symmetric $\mathcal P_d(f)\in\mathrm{Sym}^d(V^*)$ with $f(\boldsymbol v)=\mathcal P_d(f)(\boldsymbol v,\dots,\boldsymbol v)$. Remark I.2.2 reads *"It agrees with $F$ if and only if $F$ is already symmetric. Hence the linear map $(\mathcal P_d\circ\mathcal R_d)$ is a projection on the subspace of symmetric multilinear forms."* Remark I.2.4 reads *"the polarization process $\mathcal P_d$, the restitution process $\mathcal R_d$, and the projector $(\mathcal P_d\circ\mathcal R_d)$ all commute with the action of $G$."* Theorem I.2.7 and Remark I.2.9 extend both to several representations, and Theorem A states the identification of multi-homogeneous invariant forms with multi-symmetric invariant multilinear maps.

**The abstract consequence the record draws is correct, and it is correct for Weyl tensors.** $\mathcal P_d$ is injective by the uniqueness half of I.2.1, so $\mathcal P_d\mathcal R_dF=0\Rightarrow\mathcal R_dF=0$; combined with I.2.2, $\ker\mathcal R_d=\ker(\mathcal P_d\mathcal R_d)$, which is the complement of the symmetric forms, and $\mathcal R_d$ is injective on $\mathrm{Sym}^d(V^*)$. **The brief's worry that $V$ must be a standard representation is empty**, nothing in Part I asks $V$ to be anything but a finite-dimensional representation of $G$, and $\mathrm{Weyl}_n$ is one. Taking $V:=\mathrm{Weyl}_n$, $d:=3$ is legitimate.

### The step that is missing, and it is the whole distance

r260 did not apply $\mathcal R_3$ to the multilinear forms on $\mathrm{Weyl}_n^3$. Its $\gamma_D$ are functionals on $V^{\otimes12}$, and the measured operation is the **composite**

$$(V^{\otimes12})^*\ \xrightarrow{\ \rho\ }\ (\mathrm{Weyl}_n^{\otimes3})^*\ \xrightarrow{\ \mathcal R_3\ }\ \mathbb R[\mathrm{Weyl}_n]_3,$$

where $\rho$ is **restriction of the domain to a subspace**: $\mathrm{Weyl}_n^{\otimes3}$ sits inside $V^{\otimes12}$ with codimension $n^{12}-(\dim\mathrm{Weyl}_n)^3$, and a functional can die on it without being non-symmetric in any sense. Remark I.2.2 governs $\mathcal R_3$ and says nothing whatever about $\rho$. So the honest decomposition of the measured kernel is

$$10{,}393\ =\ \underbrace{(10{,}395-c)}_{\text{killed by }\rho}\ +\ \underbrace{(c-2)}_{\text{the non-symmetric complement}},\qquad c=\dim\big((\mathrm{Weyl}_n^{\otimes3})^*\big)^{O(n)}.$$

### The measurement, at the record's own cells

$c$ is the rank of the same $10{,}395$ contractions evaluated on **three independent** Weyl tensors rather than one repeated. The Weyl sampler is r260's own construction, and its output is checked for the Riemann symmetries, the first Bianchi identity and tracelessness. Rank is taken on a $10{,}395\times200$ matrix, so $c$ is not capped by the sample count.

| cell | diagrams | $c$ (three independent slots) | rank on the diagonal | killed by $\rho$ | non-symmetric complement |
|---|---|---|---|---|---|
| $\mathrm{Weyl}$, $n=6$ | $10{,}395$ | $\mathbf 2$ | $2$ | $\mathbf{10{,}393}$ | $\mathbf 0$ |
| $\mathrm{Weyl}$, $n=7$ | $10{,}395$ | $\mathbf 2$ | $2$ | $\mathbf{10{,}393}$ | $\mathbf 0$ |
| sym traceless, $n=3,4,5,6,12$ | $15$ | $1$ | $1$ | $14$ | $\mathbf 0$ |

**Remark I.2.2 accounts for $0$ of the $10{,}393$, at both cells the record cites, and for $0$ of the $14$ at the warm-up cell.** The invariant multilinear forms on three independent Weyl slots are *already* symmetric ($c=2$ leaves nothing for a complement to be) so restitution on that space is injective, its kernel is genuinely zero, and the record's conclusion *"nothing a symmetric functional could have seen is lost"* is **true and completely vacuous**. Every dimension of the loss happens one step earlier, at $\rho$, and $\rho$ is not restitution.

**So `d46cda0`'s central sentence, *"THEREFORE $\ker(\mathcal R_d)$ IS EXACTLY THE NON-SYMMETRIC COMPLEMENT"*, applied to the $10{,}393$, is refuted with a witness.** The $10{,}393$ is exactly the non-symmetric complement's *complement*: it is the space of $O(n)$-invariant functionals on twelve free legs that vanish identically on $\mathrm{Weyl}\otimes\mathrm{Weyl}\otimes\mathrm{Weyl}$.

**What the item loses, and what it keeps.** The claim *"the $10{,}393$ was never the difficulty"* does not follow from the literature. What *does* follow, and is worth keeping, is that the surviving rank is not an artefact, Remark I.2.4 plus the FFT identify it as $\dim(\mathrm{Sym}^3\mathrm{Weyl}_n)^{O(n)}$ exactly, which is Claim 2 and is confirmed. The difficulty r260 named survives untouched: Lehrer–Zhang 3.4 makes the $\gamma_D$ a basis upstairs, and $10{,}393$ of them are zero as functions of one Weyl tensor.

## Claim 2, the same $2$, attributed to the relation that would make it $1$

Evidence: [c2_the_number_two.py](../scripts/reviewers/r266/c2_the_number_two.py), [out_c2_the_number_two.txt](../scripts/reviewers/r266/out_c2_the_number_two.txt).

**The identification is sound.** By Remark I.2.4 the whole picture is equivariant, so restitution carries the invariant multilinear forms onto the invariant degree-$3$ polynomials, and by the FFT for $O(n)$ the restricted $\gamma_D$ span all of $((\mathrm{Weyl}_n^{\otimes3})^*)^{O(n)}$. Hence r260's rank **is** $\dim(\mathrm{Sym}^3\mathrm{Weyl}_n)^{O(n)}$, and $2$ is the record's own stable-sequence entry: $0,1,2,7,19,89$ for degrees $1\dots6$, confirmed at [REVIEW_r239.md](REVIEW_r239.md) claim 1 by a third route, at [REVIEW_r177.md](REVIEW_r177.md) by universal characters, and printed at [REVIEW_r237.md](REVIEW_r237.md). **Not a coincidence of two different quantities.**

**The attribution around it is inverted.** [REVIEW_r250.md](REVIEW_r250.md)'s own table reads *"$I_1=\mathrm{tr}\,M^3$ and $I_2=\mathrm{tr}\,B^3$ … independent at $n=6,7$; at $n=4,5$ $\mathbf{I_2=I_1/2}$ identically"*, and its output file prints `n=4: sample rank of (I1, I2) = 1`. Reproduced here from r250's definitions ($M$ the pair matrix $W_{ab,cd}$, $B$ the crossed one $W_{ac,bd}$), $30$ samples per cell:

| $n$ | $\dim\mathrm{Weyl}_n$ | $\mathrm{rank}(I_1,I_2)$ | $I_2/I_1$ over $30$ samples |
|---|---|---|---|
| $4$ | $10$ | $\mathbf 1$ | $+0.500000000$ to $+0.500000000$ |
| $5$ | $35$ | $\mathbf 1$ | $+0.500000000$ to $+0.500000000$ |
| $6$ | $84$ | $\mathbf 2$ | $-3.99$ to $+1.74$ |
| $7$ | $168$ | $\mathbf 2$ | $-1.36$ to $+24.23$ |
| $8$ | $300$ | $\mathbf 2$ | $-8.98$ to $+11.17$ |
| $12$ | $1638$ | $\mathbf 2$ | $-3.49$ to $+2.86$ |

$I_2=I_1/2$ is the $n\le5$ regime, where the invariant dimension is $\mathbf 1$, the record's own Lovelock collapse, $1,1,4,5,14$ at $n=5$ ([sym3-blocks.md](../findings/sym3-blocks.md) line 48). **r260 measured $n=6$ and $n=7$, where the count is $2$ precisely because the relation has failed.** Writing *"$2$ … is r250's $I_1,I_2$ with $I_2=I_1/2$"* names as the reason for the number the identity that destroys it. The correct citation is r250's *other* half: the two are **independent** at $n\ge6$. The error is reproduced four times, the commit body, [notes.md](../references/weyl-polarization-primer/notes.md), [plan.md](../plan.md) item 1, and the header of [run_restitution_kernel.py](../scripts/runs/run_restitution_kernel.py), and the $n=12$ row above supplies the missing check that it is still $2$ at the route's own dimension.

## Claim 3, the table is exact, the second assert is the first restated, and the assert is about the wrong space

Evidence: [c3_restitution_exact.py](../scripts/reviewers/r266/c3_restitution_exact.py), [out_c3_restitution_exact.txt](../scripts/reviewers/r266/out_c3_restitution_exact.txt).

**Reproduced exactly, with no floats and no evaluation points.** $\mathcal R_d$ sends the basis functional indexed by $(i_1,\dots,i_d)$ to the monomial $x_{i_1}\cdots x_{i_d}$, so in the monomial basis its matrix has exactly one $1$ per row. Its rank is the number of distinct multisets, $\binom{V+d-1}{d}$, and its kernel is spanned by differences of tuples with equal multiset. All nine published cells agree over $\mathbb Z$: $(2,2)\to3$, $(2,3)\to4$, $(2,4)\to5$, $(3,2)\to6$, $(3,3)\to10$, $(3,4)\to15$, $(4,2)\to10$, $(4,3)\to20$, $(4,4)\to35$.

**Assert 2 is assert 1.** For integers, $a=b\iff t-a=t-b$. `assert total - r == total - sd` sits one line below `assert r == sd` with the same `total`, so it cannot fire unless the line above already has. It is a restatement, and the commit message's claim that *"the three numbers add up rather than merely being consistent"* is what the restatement is doing: adding up is the same fact written twice.

**The point count lower-bounds; it does not certify.** $\mathrm{rank}(\text{sampled})\le\mathrm{rank}(\text{true})$ always. $4\binom{V+d-1}{d}+20$ points guarantee only that full rank is *achievable*; the script never derives an independent upper bound to close the sandwich. The exact certificate is that degree-$d$ monomials in $V$ variables are linearly independent, which needs no points at all.

**The bare `tol=1e-8` is an absolute tolerance, so the verdict moves with the sampler's scale.** Rescaling the standard normals by $c$ multiplies every singular value by $c^d$:

| $(\dim V,d)$ | $c=1$ | $c=10^{-2}$ | $c=10^{-3}$ | needed |
|---|---|---|---|---|
| $(3,3)$ | $10$ | $10$ | $\mathbf 7$ | $10$ |
| $(4,4)$ | $35$ | $35$ | $\mathbf 0$ | $35$ |

The mathematics is scale-invariant and the test is not. r260's own script scales its tolerance (`tol=1e-8 * max(1.0, abs(M).max())`); this one does not. With standard normals the margin is comfortable and the published table is right, so this is calibration rather than a wrong number.

**The case the record actually cares about, which the script does not test.** With $V=\mathrm{Weyl}_n$ and $d=3$ the script's assert demands $\mathrm{rank}=\dim\mathrm{Sym}^3(V^*)$:

| $n$ | $\dim V$ | $\dim(V^*)^{\otimes3}$ | $\dim\mathrm{Sym}^3(V^*)$ | measured rank |
|---|---|---|---|---|
| $6$ | $84$ | $592{,}704$ | $102{,}340$ | $\mathbf 2$ |
| $7$ | $168$ | $4{,}741{,}632$ | $804{,}440$ | $\mathbf 2$ |
| $12$ | $1638$ | $4{,}394{,}826{,}072$ | $733{,}813{,}080$ | $\mathbf 2$ (stable sequence) |

**The assert fails by five orders of magnitude on the object the record invokes it for**, because the record possesses only the $10{,}395$ *invariant* functionals, not all $\dim(V^*)^{\otimes3}$ of them. The statement that does hold is the equivariant one Remark I.2.4 licenses ($\mathrm{rank}\big(\mathcal R_d|_{\text{invariant forms}}\big)=\dim(\mathrm{Sym}^dV^*)^{O(n)}$) and c1 confirms it directly: $2=2$ for Weyl at $n=6,7$, and $1=1$ for symmetric traceless at $n=3,4,5,6,12$, that $1$ being $\mathrm{tr}\,S^3$. **So the answer to the brief's last question is yes (rank does still equal the invariant dimension on tensors with symmetries) but that is the check the script omits, and running the check it does perform on the same space would fire the assert.**

## Claim 4, obligation (i) was never edited, and item 1 now states both readings

Evidence: `git show --numstat d46cda0 -- plan.md` ($+5/-1$), [c4_symmetrised_loses_plenty.py](../scripts/reviewers/r266/c4_symmetrised_loses_plenty.py), [out_c4_symmetrised.txt](../scripts/reviewers/r266/out_c4_symmetrised.txt).

**The brief's premise does not hold.** Obligation (i) at [plan.md:70](../plan.md) is unchanged and still reads *"(i) Independence as functions on the diagonal, reopened, and no literature closes it. **The restriction kernel is the whole difficulty.**"* The commit added three paragraphs above it and deleted one line. So the item now carries, in this order:

1. *"$\ker\mathcal R_d$ is exactly the non-symmetric complement"* (new);
2. *"the $10{,}393$ is not the difficulty … on the symmetrised functionals restriction loses nothing"* (new);
3. *"A basis on twelve free legs says nothing once the three slots are filled with the same $W$"* (retained, and the third paragraph is the old first one with **STILL** inserted);
4. obligation (i): *"the restriction kernel is the whole difficulty"* (retained).

**Nothing true was dropped (there is no `ae44228` repeat here**) but nothing the new paragraphs contradict was withdrawn, so the item asserts a claim and its negation twice over. Given Claim 1, the retained halves are the correct ones.

**Is the new question well posed? It is decidable, it is not vague, and its answer is no.** *"Independence must be asked of the symmetrised functionals, and on those restriction loses nothing"* has an exact reading and an exact answer. Lehrer–Zhang 3.4 makes $\{\gamma_D\}$ a basis of $\mathrm{Inv}\big((V^{\otimes12})^*\big)$ at $n\ge6$, and a leg permutation sends $\gamma_D$ to $\gamma_{\sigma\cdot D}$ (a **permutation of that basis, with no signs**) so the $S_3$-invariant subspace has dimension equal to the number of $S_3$-orbits on the $10{,}395$ matchings. That count is exact and needs no arithmetic on tensors:

- fixed matchings per element of $S_3$: $10{,}395,\ 75,\ 75,\ 27,\ 27,\ 75$;
- Burnside: $\tfrac16(10{,}395+75+75+27+27+75)=\mathbf{1779}$;
- canonicalisation over all $10{,}395$ matchings: $\mathbf{1779}$. The two agree.

Evaluation at $W\otimes W\otimes W$ is already $S_3$-symmetric, so symmetrising the functionals changes **no value on the diagonal**: the rank there is still $2$. **So the symmetrised functionals number $1779$ and restrict to rank $2$, the loss is $\mathbf{1777}$, and *"restriction loses nothing"* is false by $1777$ dimensions.** Symmetrisation removes $10{,}395-1779=8616$ of the kernel and leaves $1777$; c1 shows independently that the surviving loss is entirely $\rho$, the restriction to the subspace, which symmetrisation cannot reach.

**What would settle obligation (i), stated so it can be computed.** The question is whether the $184$ covariants, *as functions of one Weyl tensor at $n=12$*, are linearly independent. That is one rank: build the $184$ objects, evaluate them at $\ge184$ generic $\mathrm{Weyl}_{12}$ tensors, and take the rank of the resulting $184\times N$ matrix, or equivalently check $\det\mathrm{Gram}_S(12)\ne0$, which is obligation (iii)'s object. It is decidable today up to the one thing the record does not have, which is the covariants themselves, obligation (ii). **So (i) is not blocked on a literature search or on a reformulation; it is blocked on (ii),** and the swap from "the $\gamma_D$" to "the symmetrised $\gamma_D$" moves neither, because the $\gamma_D$ were never the covariants.

## Claim 5, the gate misses the record's own reopenings, and its trailer is satisfied by a full stop

Evidence: [c5_hook_gate.py](../scripts/reviewers/r266/c5_hook_gate.py), [out_c5_hook_gate.txt](../scripts/reviewers/r266/out_c5_hook_gate.txt). The hook module is imported and `git diff --cached` stubbed; nothing under `.claude/` is modified.

### `_opens_an_item` does not do what its docstring says

The docstring promises *"True when this commit changes plan.md AND its subject says an item opened."* The regex is `\b(reopen|reopens|reopened|reopening)\b`, four literal words, none of which is `open`, `opens` or `opened`.

| subject, with plan.md staged | fires | |
|---|---|---|
| `fix(plan): independence is REOPENED …` (`ae44228`) | **yes** | the commit the gate was written for |
| `fix(plan): the n=12 sextic count is open, …` (**`475c32e`**) | **no** | **in the record**: a `fix(` staging plan.md whose diff flips an item to **OPEN** |
| `feat(conjecture-a): B0's rank-3 question answered, its reduction refuted` (**`62ccb44`**) | **no** | **in the record**: its plan.md diff reopens B0 with *"the general case reopens the $(+++)$ and $(++-)$ sign-blocks"* |
| `fix(plan): item 1 is re-opened by the witness` | no | a hyphen defeats the alternation |
| `fix(plan): item 1 is OPENED again` | no | `opened` alone is absent |
| `fix(plan): r260 REFUTES the closure of item 1` | no | the record's own idiom for reopening |
| `feat(restitution): the 10,393 kernel …` (**`d46cda0`**) | **no** | **the primary commit under review**, which rewrites the reopened item |

`475c32e` is the witness the brief asks for. Two further blind spots: `subject` is *line 1 of the Bash command*, so the standard `-m "$(cat <<'EOF'` heredoc form never fires however the real subject reads, and `-F` puts the message outside the command entirely, where neither this gate nor the `Deliverable:` gate can see it. And `"plan.md" in out.stdout` is a substring test over `--name-only`, so `outside material (unpublished, held in the private record)`, `report/plan.md.bak` and `notes/myplan.mdx` all trigger it.

### The trailer it demands is unvalidated

`_searched` is `re.search(r"Searched:[ \t]*(\S.*)", text)` over the whole command, with no anchor, no case-folding and no check against either documented form:

| text | passes |
|---|---|
| `Searched: none -- the literature is silent` | yes, documented |
| `Searched: Weyl polarization -> references/weyl/` | yes, documented |
| `Searched: yes` | **yes**, no slug, no reason |
| `Searched: .` | **yes**, one character |
| `I Searched: nothing, and I am not defending it` | **yes**, an admission of no search |
| *"nothing was Searched: the item was reopened blind"* | **yes**, prose in the body |
| `searched: lowercase` | no, case-sensitive |

The commit message says *"The trailer parser accepts both a reference path and a none-with-reason"*; it accepts any non-space character, so the *"defends it"* half of the subject line is unenforced.

### Three circumventions, none of which needs a false trailer

1. **Use a `docs(` subject.** `main()` returns at `if not any(s.startswith(GATED) …)` before `_opens_an_item` is ever called, so `docs(plan): item 1 is reopened on r260` passes untouched, and `docs(plan):` is a live subject shape in this record (`fcaf711`, `728012c`, `6bbcc62`).
2. **Split the commit.** Stage plan.md separately; with plan.md out of the index, `_opens_an_item` returns `False` on a subject that says `reopens`.
3. **Put the trailer outside the message.** `echo 'Searched: none' ; git commit -m 'fix(plan): item 1 reopens'` passes, and the trailer never reaches the commit.

**Is it theatre?** Not entirely, it fires on `ae44228`, which is the shape it was written for, and the skill text it accompanies is a real rule. But it is narrow enough that of the four commits in the record that most clearly flip an item open, it catches one. **The narrowness argument in the commit message is sound and the implementation is narrower than the argument**: matching every plan.md touch would indeed produce noise, and the fix is not the subject line but the plan.md **diff**, a commit that adds `REOPEN`/`is OPEN`/`is open` to a plan item is detectable from `git diff --cached plan.md` without reading English.

**One incidental finding about the surrounding hook.** It gates on `"git commit" in command` and `re.findall(r"(?:feat|fix|…)\([^)]*\):")` over the whole Bash command, so a `cat > file <<EOF` heredoc that merely *quotes* commit subjects is treated as a commit and refused. This review hit it while writing the test file, which is why [c5_hook_gate.py](../scripts/reviewers/r266/c5_hook_gate.py) concatenates the two words at run time. That is pre-existing rather than new in `26833c0`, and the new gate inherits it.

### The skill text hard-codes the refuted claim

[.claude/skills/research-loop/SKILL.md](../.claude/skills/research-loop/SKILL.md) and `SEARCH_MSG` in the hook both now state, as the worked example justifying the rule, that one search *"returned the classical theory of restitution, which identified that kernel outright as the non-symmetric complement and showed the difficulty was somewhere else entirely."* Claim 1 refutes that sentence. **The process lesson survives without it**, a search that returns the right classical name for an operation is worth running whether or not it settles the item, but the example as written asserts the thing this review measures to be false, in two files that are read every cycle.

## Claim 6, two findings still live, one of them in its fifth cycle

| finding | first raised | state |
|---|---|---|
| The Gram identity's **Frobenius / positive-definiteness** reason | r261 rec 6, then r262, r263, r264 | **STILL ABSENT.** Zero occurrences of `Frobenius`, `positive definite` or `positive-definiteness` in [findings/brauer-pairing.md](../findings/brauer-pairing.md), [findings/INDEX.md](../findings/INDEX.md) or [scripts/runs/](../scripts/runs/). Hits elsewhere in [findings/](../findings/) are unrelated Frobenius norms |
| [plan.md:55](../plan.md) *"A3 cannot start without it"* | r262 claim 3, r263, r264 | **UNCHANGED.** Ambiguous rather than wrong, as r264 says, since obligation (ii) beneath it reads *"A3 consumes the objects, not the theorem"*. Naming the object would settle it |
| The conditional theorem box, *"$B_{12}(12)$ is semisimple"* | r259 rec 1, r261 rec 3 | **APPLIED** by `ef6ed9e`. It now survives only in the historical sentence *"was first filed with semisimplicity of $B_{12}(12)$ as their hypothesis"*, which is correct as history |
| *"Independence is settled (Lehrer–Zhang 3.4, $r\le n$)"* in [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) | r261, r262 | **APPLIED.** The header now opens *"Independence is REOPENED, r259 and r260 refute the closure"* |
| *"all 40 pairs"* | r259's own slip, repeated as fact and caught by r261/r262 | **APPLIED.** Zero occurrences anywhere |
| *"r244 prices it at order $\sim89$"* misattributed to $\det\mathrm{Gram}_S$ | r261, r262 | **APPLIED** in place at [plan.md:74](../plan.md), which now says the figure is r244's pricing of $\xi(n)$ |
| The $19$/$16$ $SO$/$O$ collision | r263, r264 | **APPLIED.** [findings/INDEX.md](../findings/INDEX.md) now reads *"$19$ is the $SO(12)$ count"* |
| The ASWT 3.17(b) citation failing at type $D_6$ | r261, r262 | **APPLIED.** [findings/brauer-pairing.md:52](../findings/brauer-pairing.md) carries the per-type reading and the $SO(4)$ witness |
| [findings/INDEX.md](../findings/INDEX.md) not carrying the seed lemma | r264 | **APPLIED.** The [brauer-pairing.md](../findings/brauer-pairing.md) row now carries the seed, the $k=0$ caveat at $16$ blocks, and *"Obligation (ii) is NOT closed"* |

**And one new one, created by `d46cda0`.** The commit is $+5/-1$ on [plan.md](../plan.md) plus one new script; it touched neither [findings/INDEX.md](../findings/INDEX.md) nor [findings/brauer-pairing.md](../findings/brauer-pairing.md) nor [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py). All three still say the restriction kernel is the open difficulty, [findings/INDEX.md](../findings/INDEX.md) verbatim: *"**Independence on the degree-3 diagonal is a SEPARATE and OPEN question**, restriction kills $10{,}395$ diagrams to rank $2$."* Given Claim 1 those three files are **right** and [plan.md](../plan.md)'s two new paragraphs are wrong, so the propagation gap is the only reason the record is not uniformly incorrect.

## Recommendations

1. **Withdraw the inference, keep the identification.** The sentence to delete from [plan.md](../plan.md), [notes.md](../references/weyl-polarization-primer/notes.md) and [run_restitution_kernel.py](../scripts/runs/run_restitution_kernel.py) is *"$\ker\mathcal R_d$ is exactly the non-symmetric complement"* **as applied to the $10{,}393$**; the sentence to keep is that the surviving rank is $\dim(\mathrm{Sym}^3\mathrm{Weyl}_n)^{O(n)}$ by Remark I.2.4 plus the FFT. The measured split is $10{,}393=10{,}393+0$ at $n=6,7$.
2. **Delete the two contradicting paragraphs or the two contradicted ones.** Item 1 currently states both readings; obligation (i) and the retained third paragraph are the correct halves.
3. **Fix the attribution of the $2$.** It is r250's *independence* of $I_1,I_2$ at $n\ge6$. $I_2=I_1/2$ is $n\le5$, where the count is $1$.
4. **Drop the second assert and scale the tolerance**, or replace both with the exact monomial argument, which needs no points. And state which space the assert is about: the equivariant form is the one the record needs.
5. **Trigger the search gate on the plan.md diff, not the subject line**, and validate the trailer against its two documented forms. As written it misses `475c32e`, `62ccb44` and `d46cda0`, and accepts `Searched: .`
6. **Rewrite the worked example in [SKILL.md](../.claude/skills/research-loop/SKILL.md) and `SEARCH_MSG`.** The search was worth running; what it returned did not settle the kernel.
7. **Add the Frobenius/positive-definiteness reason to [findings/brauer-pairing.md](../findings/brauer-pairing.md).** Fifth cycle, four reviewers.
