# REVIEW r251 -- Gate 2, claims 1 and 2

Reviewer 251. Commits under review: 200d235, 1fe34e0, a380328. Files: [run_n12_diagram_independence.py](../scripts/runs/run_n12_diagram_independence.py), [run_weyl_projector.py](../scripts/runs/run_weyl_projector.py). Scripts: [scripts/reviewers/r251/](../scripts/reviewers/r251/).

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1a | $n^{\#\text{cycles}}$ IS the Frobenius Gram of the diagram tensors | **CONFIRMED**, exactly, and it extends to covariants |
| 1b | a deficient projector-free Gram CERTIFIES dependence on $\mathcal W_n$ | **CONFIRMED** over $\mathbb R$ -- the direction is right and the relations are real |
| 1c | "insufficient, not useless" | **REFUTED** -- the certificate is EMPTY at every $n$ where $\mathcal W_n\neq 0$, and provably cannot fire at $n=12$ |
| 2 | "$P$ fixes an independently built Weyl tensor" separates the true projector | **REFUTED** -- two witnesses pass every live check |

## Claim 2 -- the separating check is INSUFFICIENT, with witnesses

[run_weyl_projector.py:190](../scripts/runs/run_weyl_projector.py#L190) asserts that fixing an independently built Weyl tensor "is the check that separates the true projector from one onto a different 35-dimensional subspace". **That statement is false**, and [c2_wrong_projector.py](../scripts/reviewers/r251/c2_wrong_projector.py) exhibits two projectors onto different 35-dimensional subspaces that pass it.

The construction is one line of linear algebra: $W_i$ lies *inside* $\mathcal W_5$, so orthonormalise $\{W_i\}\cup\mathrm{ON}$, keep the first 34 vectors -- a 34-dimensional subspace of $\mathcal W_5$ that contains $W_i$ -- and complete to 35 with one non-Weyl direction.

| candidate | idempotent | symmetric | trace | fixes $W_i$ | $\lVert Q-P\rVert_\infty$ | file's verdict |
|---|---|---|---|---|---|---|
| true $P$ | 1.7e-16 | 0 | 35.000000 | 3.0e-16 | 0 | accept (correct) |
| D1 = $\mathcal W_5$ + 1 extra direction | 3.1e-16 | 0 | **36.000000** | 8.3e-16 | 0.047 | caught, by the trace |
| **D2** = 34 Weyl dirs incl. $W_i$ + 1 Ricci dir | 2.4e-16 | 0 | 35.000000 | **9.0e-16** | **0.084** | **ACCEPT -- false positive** |
| **D3** = 34 Weyl dirs incl. $W_i$ + 1 generic dir | 2.4e-16 | 0 | 35.000000 | **9.0e-16** | **0.118** | **ACCEPT -- false positive** |

- **The brief's literal suggestion is caught, and by the trace.** $\mathcal W_5$ plus an orthogonal direction has rank 36, and `trace(P)` is a rank functional on any candidate. r249's result is that the trace is *uninformative about which subspace* when $P$ is built from an orthonormal list; it still reads the rank, and it is the only check that catches D1. The file may still appeal to the trace as a rank check -- it may not appeal to it as a range check.
- **The rank-preserving witnesses defeat the whole battery.** D2 and D3 hold trace 35 and fix $W_i$ to $9\times10^{-16}$, an exactness that is structural rather than lucky: $W_i$ is in their span by construction.
- **What the check certifies is exactly one dimension of thirty-five.** Fixing one tensor says $W_i\in\mathrm{range}(P)$. Thirty-four dimensions stay free, and D2/D3 spend one of them outside $\mathcal W_5$.
- **It is a sound randomized screen and a weak deterministic one.** For a wrong subspace chosen independently of the draw, a random Weyl tensor escapes it with probability 1 -- a second tensor at a different seed catches D2 and D3 at relative error 0.30. But the file draws from `default_rng(1)`, so as shipped the check is deterministic and its power is precisely "$\mathrm{range}(P)\not\ni W_i$".

### The repair, which is cheaper than the check it replaces

Range containment is an exact identity on $P$ itself, because the five Weyl equations act on $P$'s first four indices -- no probe tensor and no random draw:

    P + P.transpose(1,0,2,3,...) = 0        P + P.transpose(0,1,3,2,...) = 0
    P - P.transpose(2,3,0,1,...) = 0        P + P^{(0,2,3,1)} + P^{(0,3,1,2)} = 0
    einsum('akbkefgh->abefgh', P) = 0

`range(P) subset Weyl_n` together with `trace(P) = dim Weyl_n` forces `range(P) = Weyl_n`, and with idempotence and symmetry that pins $P$ uniquely. Measured defect: true $P$ 2.2e-16; D1 0.81; D2 0.51; D3 0.32; r249's witness C 1.06; the zero stub passes the range test and fails the trace. **All five wrong candidates are caught, and the true projector is *certified* rather than screened.**

## Claim 1 -- the theorem is right, the certificate it powers is empty

Object, exactly reviewer 250's: the 105 perfect matchings on 8 legs, each giving $(T_M)_{i_1\ldots i_8}=\prod_{(a,b)\in M}\delta_{i_ai_b}$ and the diagram function $f_M(W)=\langle T_M, W\otimes W\rangle$. Script: [c1_frobenius_gram.py](../scripts/reviewers/r251/c1_frobenius_gram.py), all integer/`Fraction` arithmetic.

### 1a CONFIRMED, and the proof is one line

$\langle T_M,T_{M'}\rangle=\sum_{i}\prod_{M}\delta\prod_{M'}\delta$ is $1$ exactly on index assignments constant on each connected component of the graph $M\cup M'$, and $0$ otherwise. Every vertex has degree $2$ (one edge from each matching), so the components are cycles and the sum is $n^{\#\text{cycles}}$. It holds over any commutative ring, not only $\mathbb R$.

Checked as exact integer matrix equality, no tolerance anywhere:

| legs | diagrams | $n$ tested | Frobenius $=n^{\#\text{cycles}}$ |
|---|---|---|---|
| 4 | 3 | 2, 3, 4, 5 | yes |
| 6 | 15 | 2, 3, 4, 5 | yes |
| 8 | 105 | 2, 3, 4 | yes |
| 8 input + 2 output (covariants) | 60 | 2, 3, 4 | yes |

**The covariant row matters and it needed a correction to my own first attempt.** A diagram with $f$ free legs is not "a partial matching tensored with all-ones"; it is a perfect matching on $2k+f$ legs whose $f$ output slots are matched into the inputs. Modelled that way the identity holds; modelled the first way it fails, and that failure was my error rather than the record's.

### 1b CONFIRMED -- and it is stronger than "restriction cannot raise rank"

The chain is sound as written. Over $\mathbb R$ the Frobenius form is positive definite, so $Gc=0\Rightarrow c^\top Gc=\lVert\sum c_MT_M\rVert^2=0\Rightarrow\sum c_MT_M=0$; hence $\mathrm{rank}(G)=\dim\mathrm{span}\{T_M\}$. The map $T\mapsto(W\mapsto\langle T,W^{\otimes 2}\rangle)|_{\mathcal W_n}$ is linear, so $\mathrm{rank}\{f_M\}\le\mathrm{rank}(G)$, and a deficient $G$ forces a relation. **Verified constructively rather than inferred:** every exact $\mathbb Q$-kernel vector of $G$ was cleared of denominators and applied to the integer tensors, giving the zero tensor exactly.

| $n$ | rank $G$ (exact over $\mathbb Q$) | nullity | $\max\lvert\sum v_MT_M\rvert$ over the kernel | $\dim\mathcal W_n$ |
|---|---|---|---|---|
| 2 | 35 | 70 | **0** | 0 |
| 3 | 91 | 14 | **0** | 0 |
| 4 | 105 | 0 | -- | 10 |
| 5 | 105 | 0 | -- | 35 |

The record's numbers 35, 91, 105 reproduce. The certificate is in fact stronger than claimed: the kernel vectors kill the *tensors*, so the relations hold on all of $(\mathbb R^n)^{\otimes 4}$, not merely on $\mathcal W_n$.

**One scoping hazard.** Soundness is over $\mathbb R$ (or any real field), and the file says so for the rank equality but not for the certificate sentence that follows. Over $\mathbb F_p$ it fails outright, because $n^{\#\text{cycles}}\equiv 0$ whenever $p\mid n$: at $n=12,p=2$ the Gram has rank $0$ while the 105 tensors have rank 105 mod 2. The sibling [run_n5_diagram_gram.py](../scripts/runs/run_n5_diagram_gram.py) computes mod $10007$, where the certificate certifies nothing.

### 1c REFUTED -- "insufficient, not useless" is the overstatement in this commit

Three independent measurements, all pointing the same way.

- **Both cited instances live where $\mathcal W_n=0$.** $\dim\mathcal W_2=\dim\mathcal W_3=0$. The record's "14 relations at $n=3$ with no projector needed" is a certificate about the zero vector space, where all 105 functions vanish identically and the true relation space is 105-dimensional, not 14. (The quartic $n(n+1)(n+2)(n-3)/12$ used elsewhere in the same file returns $-2$ at $n=2$.)
- **Where $\mathcal W_n\neq 0$ it certifies nothing at all, while everything is there to certify.** The 105 degree-2 diagram functions on $\mathcal W_n$ span a **1-dimensional** space at $n=4,5,6$ -- $\mathcal W_n$ is $O(n)$-irreducible, so its invariant quadratic form is unique up to scale. So 104 relations exist and the certificate finds **0 of 104**, at every $n$ in range.
- **It provably cannot fire at $n=12$.** Measured full-rank thresholds: matchings on $2k$ legs become independent exactly at $n=k$ -- $k=2,3,4,5$ giving thresholds $n=2,3,4,5$ (ranks $1/3$, $1/10/15$, $1/35/91/105$, $1/126/603/903/945$), the classical Brauer/FFT statement. Degree-3 covariants have $12+f$ legs, so $k=6+f/2\le 12$, and $n=12\ge k$: **the Gram is nonsingular there for every carrier the programme uses.** Spot check at 12 legs and $n=12$: 900 random matchings, Gram rank $900/900$. A subset of an independent set is independent, so the 184 covariants inherit it.

**The ladder the certificate never descends** ([c1b_rank_ladder.py](../scripts/reviewers/r251/c1b_rank_ladder.py), 130 samples per rung, identical at $n=4,5,6,7,8$):

| rung | rank of the 105 diagrams |
|---|---|
| the tensors $T_M$ themselves = rank of the projector-free Gram | **105** |
| their functions on generic 4-tensors | 65 |
| on algebraic curvature tensors ($\lVert R\rVert^2$, $\lVert\mathrm{Ric}\rVert^2$, $\mathrm{sc}^2$) | 3 |
| on $\mathcal W_n$ | **1** |

Forty dimensions are lost before the Riemann symmetries are even reached, and the certificate stops on the top rung.

**The structural reason.** The kernel of the projector-free Gram is spanned by antisymmetrisation relations that exist only because $n$ is too small for the first fundamental theorem to be free. It has nothing to do with $\mathcal W_n$, which is why it vanishes as soon as $n$ is large enough for the question the programme is asking. **Sound and empty is the right verdict, not "insufficient, not useless".**

### Suggested wording

Replace "SOUND FOR DEPENDENCE and unsound for independence: insufficient, not useless" with: *sound for dependence over $\mathbb R$, and empty in the range that matters -- the matchings on $2k$ legs are independent for $n\ge k$, so at $n=12$ a degree-3 projector-free Gram is nonsingular and certifies nothing. The instances at $n=2,3$ certify relations on $\mathcal W_n=0$.*
