# REVIEW r267, Gate 2, cubes span Sym^3 and the extraction screen

Reviewer 267. Commits under review: `a5f8c0d` (primary), `878f7bb`, `3e9c304`.
Primary files: [run_cubes_span.py](../scripts/runs/run_cubes_span.py), [run_basis_extraction.py](../scripts/runs/run_basis_extraction.py), [plan.md](../plan.md) section 2 item 1 obligation (i). Constraining prior reviews: [r259](REVIEW_r259.md), [r260](REVIEW_r260.md), [r261](REVIEW_r261.md), [r262](REVIEW_r262.md), [r263](REVIEW_r263.md), [r264](REVIEW_r264.md), [r265](REVIEW_r265.md), [r266](REVIEW_r266.md).
Scripts: [scripts/reviewers/r267/](../scripts/reviewers/r267/). Reviewer 268 runs the identical brief concurrently and independently; I read none of its files.

Nothing below shares a line with either reviewed script. Cubes-span is settled **constructively**, the complete polarization identity is verified as an exact identity over $\mathbb Z$, which exhibits the spanning coefficients and needs no rank, no sampling and no tolerance, and then again by exact rational elimination on the points that identity itself names. Weyl tensors are built from the **Kulkarni–Nomizu product and the Schouten tensor with the denominators cleared**, so they are integers, and every symmetry is checked as an integer identity before use; the family is verified to span $\mathcal W_n$ against $n(n+1)(n+2)(n-3)/12$ at $n=4,5,6,7$. Diagram values are single `einsum`s whose subscript string **is** the matching, evaluated in $\mathbb F_{1009}$, and every rank is a mod-$p$ elimination. The diagram action in claim 4 is an explicit incidence matrix built by broadcasting over index tuples, a different route from the reviewed file's $O(n^{2f})$ double loop and fast enough to re-run each question two hundred times.

| # | Claim | Verdict |
|---|---|---|
| 1 | Is `a5f8c0d`'s argument the one `bc593d4` retracted? | **THE DISTINCTION IS REAL AND THE ARGUMENT IS CORRECT, AND IT IS THE HALF [r266](REVIEW_r266.md) ALREADY GRANTED, WORTH $\mathbf0$ OF THE $10{,}393$.** The two claims are about **different arrows** of the same composite and have different truth values, so it is not a relabelling. Measured arrow by arrow at the programme's own degree: the $10{,}395$ contractions have rank $\mathbf2$ **already on $\mathcal W_6^{\otimes3}$**, rank $\mathbf2$ after symmetrising, and rank $\mathbf2$ on the diagonal, so the collapse is $10{,}393+0+0$ and the arrow `a5f8c0d` proves injective is the one that never lost anything. [r266](REVIEW_r266.md) claim 1 states the same fact verbatim (*"$\mathcal R_d$ injective on $\mathrm{Sym}$ … Weyl tensors included"*). **One unstated step**: the record's realisation theorem gives $e\,M_\lambda=\operatorname{Hom}(V_\lambda,\mathrm{Sym}^3\mathcal W_n)$, maps **into** $\mathrm{Sym}^3$; "evaluation at $W^{\otimes3}$" needs the **opposite** direction, and the identification is by self-duality, which the record uses without saying so |
| 2 | Does "cubes span $\mathrm{Sym}^3(U)$" hold as stated? | **CONFIRMED, CONSTRUCTIVELY AND EXACTLY, INCLUDING FOR $\mathcal W_n$ ITSELF, and being cut out by linear conditions is what makes it work.** The complete polarization identity holds exactly over $\mathbb Z$ at twelve $(\dim U,d)$ cells and at $\dim U=\dim\mathcal W_5=35$ and $\dim\mathcal W_6=84$; all twelve cells of the reviewed tables reproduce by exact rational elimination. The identity needs $U$ closed under the sums it forms, and **linear** conditions are exactly that, checked in the ambient $V^{\otimes8}$ with no basis at $n=4,5,6$. **One real caveat the file's method needs and does not state**: cubes span, but not the cubes of any family, Vandermonde points $(1,t,\dots,t^{\dim-1})$ lie on the rational normal curve and stall at rank $\mathbf7$ where $\dim\mathrm{Sym}^3=10$. Gaussian samples are Zariski-dense, so `run_cubes_span.py` is safe; its assert would have caught the failure anyway |
| 3 | What the reduction actually reduces | **THE PLAN UNDERSTATES ONE HALF AND DROPS A QUANTIFIER ON THE OTHER.** [r265](REVIEW_r265.md)'s $182$ carried **two** questions: injectivity of evaluation at cubes, and whether the diagrams **reach** $m_\lambda$. Cubes-span settles the first at every block and every $n$; the **FFT settles the second**, unconditionally in $n$, [r260](REVIEW_r260.md) claim 4's own finding, and the record's realisation theorem says $\{e\,\nu(D)c_0\}$ spans $e\,M_\lambda$ outright. So $184$ independent covariants **exist** at every $n\ge12$: obligation (i) as worded is a theorem, and what is left is obligation (ii). **And "what remains is finite" is finite only at one $n$.** [r245](REVIEW_r245.md) 1(iii) states the hypothesis as independence *"at EVERY $n\ge12$ … equivalently the $184\times184$ covariant Gram over $\mathbb Q(n)$ has root-free determinant on $[12,\infty)$"*; `a5f8c0d`'s *"finite linear algebra at $n=12$"* is the local check that item 1's own bullet (iii) calls **"a GLOBAL obligation, not a local check"** three bullets below. The mechanism is live: the same fixed $10{,}395$ diagrams have rank $\mathbf1$ at $n=4,5$ and $\mathbf2$ at $n=6$ |
| 4 | The extraction screen | **THE HEADLINE NUMBER IS AN ARTEFACT OF THE ENUMERATION ORDER; "FLAT IN $n$" IS A TAUTOLOGY; AND THE ASSERT FAILS AT NON-TRIVIAL $\lambda$.** (c) The rank-raising diagrams sit at positions $\{1,16,31\}$ (**the same three at $n=2,3,4,5,6,7$**) so $31$ is a property of `matchings`, not of the mathematics, and "flat in $n$" restates that the enumeration order does not depend on $n$. Under $200$ random orders the median is $\mathbf5$, not $31$: **used/$m$ is $1.7$, not $10.3$**. (b) At $\lambda=(4)$ and $\lambda=(1^4)$ the same enumeration consumes $\mathbf{53}$ diagrams for a block of dimension $1$, the file's own `assert used <= 12*target + 5` **would fire**, at $53>17$, at $n=4,5,6$. (a) Odd $f$ cannot reach $\varnothing$: parity of $\lvert\lambda\rvert$ equals parity of $f$, **true, and a statement about that block alone**; odd $f$ carries $m_{(1)}=105$ and $m_{(3)}=105$ at $f=7$. And `seed(f,n)` returns a vector of length $n^{f-1}$ at odd $f$, which `apply_diagram` cannot consume, so odd $f$ was never runnable. (d) The prune is **not rank-safe**, it sorts by $\max\lvert\text{entry}\rvert$, which is not a rank criterion, and duplicate rows are the norm here ($105$ diagrams give $\mathbf2$ distinct vectors at $\lambda=(4)$), but it **never fires** in the four reported cells, `used` staying under $4m+40$ everywhere, so the published numbers are unaffected |
| 5 | The blocked-on-data claim | **CONFIRMED IN EVERY PART, AND THE $77/191\to71/184$ ARITHMETIC CHECKS OUT FROM THE PICKLE ITSELF.** [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl) is $1{,}343$ bytes: $77$ $\mathfrak{so}(12)$ weights mapping to **integers**, summing to $191$. Twelve keys have $\lambda_6\ne0$, forming $6$ chiral pairs with multiplicities $\{1^{10},2^2\}$: $77-6=\mathbf{71}$ and $191-7=\mathbf{184}$, exactly as claimed. **No covariant data exists anywhere**, no `.pkl` is git-tracked at all, [run_n12_covariants.py](../scripts/runs/run_n12_covariants.py) contains no `pickle.dump`, `np.save` or `json.dump`, no artefact matching covariants has ever been added or deleted in history, and [weyl12.pkl](../scripts/reviewers/r216/weyl12.pkl) holds weight multiplicities and raising operators, not covariants |
| 6 | Anything from r259–r266 still unapplied | **THE FROBENIUS REASON LANDED AT LAST, IN ITS SIXTH CYCLE. THREE STAND, AND `a5f8c0d` OPENS A FOURTH.** Applied by `3e9c304`: the Frobenius/positive-definiteness reason now reads in [brauer-pairing.md](../findings/brauer-pairing.md) and [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py), asked for by r261, r262, r263, r264, r265 and r266. Also applied: the *"obligation (ii) closes structurally"* header, and the *"six primes"* assert. **Standing**: [plan.md:55](../plan.md)'s *"A3 cannot start without it"* (r262, r263, r264, r265, r266, sixth cycle); [brauer-pairing.md:75](../findings/brauer-pairing.md)'s *"which semisimplicity plus the double centraliser forces"* (r260, r265); the $f=12$ row still asserted with no committed run (r259, r263, r265); and [run_restitution_kernel.py:70](../scripts/runs/run_restitution_kernel.py)'s `assert total - r == total - sd`, which both r265 and r266 showed is assert 1 with the same integer on both sides. **NEW, and the same shape r266 flagged one commit earlier**: `a5f8c0d` is $+5/-1$ on plan.md alone, so [findings/INDEX.md](../findings/INDEX.md) still reads *"Independence on the degree-3 diagonal is a SEPARATE and OPEN question"* while plan.md says REDUCED |

---

## Claim 1, the two arguments are about different arrows, and only one of them ever lost anything

Script: [c1_factorization.py](../scripts/reviewers/r267/c1_factorization.py) / [out_c1_factorization.txt](../scripts/reviewers/r267/out_c1_factorization.txt).

### The composite, written out

Every statement in this dispute is about one factorisation:

$$(V^{\otimes12})^{*}\ \xrightarrow{\ A\ }\ (\mathcal W_n^{\otimes3})^{*}\ \xrightarrow{\ B\ }\ (\mathrm{Sym}^3\mathcal W_n)^{*}\ \xrightarrow{\ C\ }\ \{\text{functions of }W\}$$

$A$ is restriction of the domain to the Weyl subspace, $B$ is symmetrisation, $C$ is restitution, evaluation at $W\otimes W\otimes W$.

- **`bc593d4` retracted a claim about $B$**: that the $10{,}393$ collapse is the non-symmetric complement. [r265](REVIEW_r265.md) and [r266](REVIEW_r266.md) refuted it.
- **`a5f8c0d` claims $C$ is injective.** Different arrow, and the claim is true.

So the distinction is **real**, not a relabelling. The record's own phrasing for it, *"the space is $\mathrm{Sym}^3(\mathcal W_n)$ from the start"* and *"the subspace step has already happened"*, is an accurate description of starting after $A$ and $B$.

### Measured, arrow by arrow, at the programme's own degree

Integer Weyl tensors from the Kulkarni–Nomizu product with the Schouten denominators cleared, every symmetry verified as an integer identity, and the family verified to span:

| $n$ | rank of the span of the constructed $W$ | $n(n+1)(n+2)(n-3)/12$ |
|---|---|---|
| 4 | 10 | 10 |
| 5 | 35 | 35 |
| 6 | 84 | 84 |
| 7 | 168 | 168 |

All $10{,}395$ matchings on $12$ points, $40$ independent samples per slot, ranks over $\mathbb F_{1009}$:

| $n$ | diagrams | on $\mathcal W_n^{\otimes3}$ | on $\mathrm{Sym}^3\mathcal W_n$ | at $W\otimes W\otimes W$ |
|---|---|---|---|---|
| 4 | 10,395 | 1 | 1 | 1 |
| 5 | 10,395 | 1 | 1 | 1 |
| **6** | **10,395** | **2** | **2** | **2** |

At $n=6$ the split of [r260](REVIEW_r260.md)'s kernel is $10{,}393 = 10{,}393 + 0 + 0$. **$A$ takes everything; $B$ and $C$ take nothing.** The same at degree $2$ with $8$ legs, where all $105$ matchings restrict from rank $105$ on $V^{\otimes8}$ to rank $1$ on $\mathcal W_n^{\otimes2}$ and stay at $1$ through $B$ and $C$, at $n=4,5,6,7$; and at degree $3$ on the traceless symmetric $2$-tensors, $15\to1\to1\to1$ at $n=3,4,5,6$.

**So `a5f8c0d`'s theorem is true and worth $0$ of the $10{,}393$**, which is precisely what the commit says it is worth, since it makes no claim about the collapse. That is the difference from the retracted argument, which claimed the collapse and delivered $0$.

### What it is not: new

[r266](REVIEW_r266.md) claim 1, in the review that refuted the predecessor, states the granted half in these words: *"the abstract consequence ($\ker\mathcal R_d$ is the non-symmetric complement, $\mathcal R_d$ injective on $\mathrm{Sym}$), is correct for **any** finite-dimensional representation, Weyl tensors included"*. Injectivity of $\mathcal R_3$ on $\mathrm{Sym}^3\mathcal W_n$ **is** injectivity of arrow $C$. `a5f8c0d` re-derives, as a new result, the half both refuting reviewers explicitly conceded. The derivation is sound and the fourteen cells are real; the record should say where it came from.

### One step the record takes without saying so

[plan.md](../plan.md) states the realisation theorem as $e\,M_\lambda=\operatorname{Hom}_{O(n)}(V_\lambda,\mathrm{Sym}^3\mathcal W_n)$, maps **into** $\mathrm{Sym}^3\mathcal W_n$. Obligation (i) now opens *"a covariant is an equivariant map $\mathrm{Sym}^3(\mathcal W_n)\to V_\lambda$"*, maps **out of** it. Only the second admits "evaluation at $W^{\otimes3}$" as a sentence. The two spaces are isomorphic because $O(n)$-representations are self-dual over $\mathbb R$, so the dimension $m_\lambda$ and the whole reduction survive; but the identification is via the invariant inner product, and the record has been bitten by exactly this kind of silent identification before ([r245](REVIEW_r245.md) claim 1(ii), citing r204's real-structure refutation). One sentence fixes it.

---

## Claim 2, cubes span, proved with the coefficients rather than measured with a tolerance

Script: [c2_cubes_exact.py](../scripts/reviewers/r267/c2_cubes_exact.py) / [out_c2_cubes_exact.txt](../scripts/reviewers/r267/out_c2_cubes_exact.txt).

### Route 1, the spanning coefficients, exhibited

The complete polarization identity

$$d!\;(u_1\odot\cdots\odot u_d)\;=\;\sum_{\varnothing\ne S\subseteq[d]}(-1)^{d-\lvert S\rvert}\Big(\sum_{i\in S}u_i\Big)^{\otimes d}$$

writes **every generator** of $\mathrm{Sym}^d(U)$ as an explicit signed integer sum of $d$-th powers of elements of $U$. That is the spanning statement with its coefficients, and it needs no rank, no sampling and no tolerance. Verified as an exact identity over $\mathbb Z$ on integer vectors, $8$ trials each, at $\dim U\in\{2,3,4,5\}$ and $d\in\{2,3,4\}$ (twelve cells, **zero failures**) and at $\dim U=35$ and $84$, the dimensions of $\mathcal W_5$ and $\mathcal W_6$.

The identity requires $U$ to contain $\sum_{i\in S}u_i$ for every subset. **A subspace cut out by linear conditions contains exactly those sums**, which is the whole answer to whether $\mathcal W_n$'s definition matters: it matters, and in the direction that makes the argument work.

### Route 2, every cell of the reviewed tables, over $\mathbb Q$

Exact rational elimination on the points route 1 names, plus random integer points:

| $\dim U$ | $d$ | points | rank | $\dim\mathrm{Sym}^d$ |
|---|---|---|---|---|
| 2 | 3 | 33 | 4 | 4 |
| 3 | 3 | 49 | 10 | 10 |
| 4 | 3 | 74 | 20 | 20 |
| 5 | 3 | 110 | 35 | 35 |
| 6 | 3 | 159 | 56 | 56 |
| 8 | 3 | 304 | 120 | 120 |
| 3 | 2 | 35 | 6 | 6 |
| 3 | 4 | 69 | 15 | 15 |
| 4 | 2 | 44 | 10 | 10 |
| 4 | 4 | 124 | 35 | 35 |
| 5 | 2 | 55 | 15 | 15 |
| 5 | 4 | 215 | 70 | 70 |

All twelve of the reviewed file's cells, with no float anywhere.

### Route 3, $U=\mathcal W_n$ itself

$\mathcal W_n$ built as the nullspace of its defining conditions gives dimensions $10,35,84$ at $n=4,5,6$, matching $n(n+1)(n+2)(n-3)/12$. Cubes of $\mathcal W_4$ span all $220$ dimensions of $\mathrm{Sym}^3(\mathcal W_4)$ by exact elimination over $525$ points. And in the ambient $V^{\otimes8}$, with **no basis and no coordinates**, the degree-$2$ identity $2(W_1\odot W_2)=(W_1+W_2)^{\otimes2}-W_1^{\otimes2}-W_2^{\otimes2}$ holds to $7\times10^{-16}$ relative at $n=4,5,6$, with $W_1+W_2$ verified to lie in $\mathcal W_n$ to $2\times10^{-15}$.

### The one caveat the file's method needs

**Cubes span; the cubes of an arbitrary family do not.** My first attempt used the deterministic Vandermonde points $u_t=(1,t,t^2,\dots)$. They lie on the rational normal curve, their monomials collapse to $t^{i+j+k}$, and the exact rank stalls at $\mathbf7$ against $\dim\mathrm{Sym}^3=10$ at $\dim U=3$. Gaussian samples are Zariski-dense so [run_cubes_span.py](../scripts/runs/run_cubes_span.py) is safe, and its assert would have caught the failure had they not been. But the file's prose reads as though the rank measurement *is* the theorem, and it is not: the theorem is route 1, and the measurement is a check on the sampler.

---

## Claim 3, both halves of the 182 are theorems, and "finite" is finite at one $n$

### What [r265](REVIEW_r265.md)'s 182 actually carried

[r260](REVIEW_r260.md) measured **rank $2$** for the $10{,}395$ $\gamma_D$ on the diagonal, and [r265](REVIEW_r265.md) sharpened it to $2=m_\varnothing$ exactly, leaving $182$ multiplicities untested. That single measurement confirmed **two** things at once at $\lambda=\varnothing$:

1. **No loss beyond the subspace step**, evaluation at cubes is injective on the covariant space.
2. **The diagrams reach the whole covariant space**, the rank attains $m_\varnothing$ rather than falling short.

`a5f8c0d` settles (1) at all $182$. It says nothing about (2), and correctly does not claim to.

### (2) is already settled too, by the record's own theorems

[r260](REVIEW_r260.md) claim 4: *"Surjectivity is unconditional in $n$ … the **First** Fundamental Theorem (Brauer 1937)"*. And [plan.md](../plan.md)'s realisation theorem: $M_\lambda$ is irreducible over the image $\nu(B_{12}(n))$ at every $n$, so one nonzero seed generates it, and $e\,M_\lambda=\operatorname{Hom}_{O(n)}(V_\lambda,\mathrm{Sym}^3\mathcal W_n)$ **exactly**. Those two say $\{e\,\nu(D)c_0\}$ spans a space of dimension $m_\lambda$ per block.

Combining with claim 1: a basis of $e\,M_\lambda$, evaluated on the diagonal, is $m_\lambda$ linearly independent $V_\lambda$-valued functions of $W$. Summing over blocks, **$184$ independent covariants exist at every $n\ge12$**. Obligation (i), as [plan.md](../plan.md) words it (*"independence as functions on the diagonal"*), is a theorem of the record as it stands. What is left is exhibiting them, which is obligation (ii). The plan's separation of (i) from (ii) has become a separation between an existence theorem and its constructive content, and the plan does not say so.

### And the quantifier that went missing

[r245](REVIEW_r245.md) claim 1(iii) states the hypothesis A2″ consumes:

> The theorem needs the covariant family the constraint data is built on (one family, rational in $n$), to be independent at **EVERY** $n\ge12$; equivalently, the $184\times184$ covariant Gram over $\mathbb Q(n)$ has root-free determinant on $[12,\infty)$.

`a5f8c0d`'s message reads *"finite linear algebra at $n=12$"*, and [plan.md](../plan.md) obligation (i) now closes *"What remains is finite: whether the $184$ constructed covariants attain rank $184$"*, with no $n$. Three bullets below, the same item says of the sibling obligation:

> **(iii) $\det\mathrm{Gram}_S(n)$ is a GLOBAL obligation, not a local check.** r242's danger is a *dimension-dependent syzygy*, a relation holding at one $n$ and failing at the next.

**The same danger applies to the covariant Gram**, and [plan.md:37](../plan.md) still carries r245's version of it. The rank of a fixed diagram family is genuinely $n$-dependent, my own table: the same $10{,}395$ contractions have rank $\mathbf1$ at $n=4,5$ and $\mathbf2$ at $n=6$. Above $12$ the block table is stable, which fixes the target dimension but not the rank of a chosen family.

**One softening, which is r245's own.** [r245](REVIEW_r245.md) claim 2 observes that the Helly step needs only $S_{12}$ compact, so independence at $n=12$ alone may carry the downstream use. That makes *"finite"* defensible for the consumer and wrong for the theorem as [run_a2pp_constant_t.py](../scripts/runs/run_a2pp_constant_t.py) states it (*"$S_n$ is bounded at every $n\ge12$"*). Item 1(i) should say which it means.

### What is now known, precisely

| statement | status |
|---|---|
| Evaluation at $W^{\otimes3}$ is injective on $\operatorname{Hom}(\mathrm{Sym}^3\mathcal W_n,V_\lambda)$, every $\lambda$, every $n$ | **proved** (`a5f8c0d`, and independently above) |
| Diagram combinations span $\operatorname{Hom}(V_\lambda,\mathrm{Sym}^3\mathcal W_n)$, every $\lambda$, every $n$ | **proved** (FFT + the realisation theorem, already in the record) |
| $184$ independent covariants exist at each $n\ge12$ | **follows from the two above** |
| A *specific* family of $184$, exhibited as diagram combinations | **not built**, $7$ of $71$ blocks, nothing committed (claim 5) |
| That family independent at **every** $n\ge12$, root-free Gram determinant on $[12,\infty)$ | **open**, [r245](REVIEW_r245.md) 1(iii), unchanged |

---

## Claim 4, the screen measures the enumeration order

Scripts: [c4_extraction.py](../scripts/reviewers/r267/c4_extraction.py) / [out_c4_extraction.txt](../scripts/reviewers/r267/out_c4_extraction.txt), [out_c4b_flat_in_n.txt](../scripts/reviewers/r267/out_c4b_flat_in_n.txt).

### (a) Odd $f$, true, and about one block

An up–down path in Young's lattice changes $\lvert\lambda\rvert$ by exactly $\pm1$ each step, so $\lvert\lambda\rvert$ after $f$ steps has the parity of $f$; odd $f$ cannot end at $\varnothing$. Confirmed by enumeration at $n=6$:

| $f$ | $m_\varnothing$ | $m_{(1)}$ | $m_{(2)}$ | $m_{(1,1)}$ | $m_{(3)}$ |
|---|---|---|---|---|---|
| 3 | 0 | 3 | 0 | 0 | 1 |
| 4 | 3 | 0 | 6 | 6 | 0 |
| 5 | 0 | 15 | 0 | 0 | 10 |
| 7 | 0 | 105 | 0 | 0 | 105 |

**It is a statement about the $\varnothing$ block only.** Odd $f$ carries plenty of blocks; the reason no row appears is that the file only ever targets $\varnothing$. Two further notes: `seed(f, n)` performs `f // 2` Kronecker products, returning a vector of length $n^{f-1}$ at odd $f$, which `apply_diagram` cannot consume, odd $f$ would have raised, not returned an empty row. And *"only TWO leg counts were measured"* understates it: **$f=2$ contributes `used = 1` against `target = 1`**, so the ratio the file reports rests on the $f=4$ row alone.

### (c) The reported number is the enumeration order, decisive

At the cup seed, $f=4$, I recorded **which** diagrams raise the running rank:

| $n$ | target | as-enumerated `used` | rank-raising positions |
|---|---|---|---|
| 2 | 3 | 31 | $\{1,16,31\}$ |
| 3 | 3 | 31 | $\{1,16,31\}$ |
| 4 | 3 | 31 | $\{1,16,31\}$ |
| 5 | 3 | 31 | $\{1,16,31\}$ |
| 6 | 3 | 31 | $\{1,16,31\}$ |
| 7 | 3 | 31 | $\{1,16,31\}$ |

The reviewed file's $31$ at $n=2,3,4$ reproduces exactly, and it is **the same three positions at every $n$**. `matchings` does not depend on $n$, so *"flat in $n$ across $n=2,3,4$"* (offered as *"the one thing these rows do show"*), restates that the enumeration order does not depend on $n$. It shows nothing about the extraction.

Under $200$ **random** orders, target = the rank of the full diagram orbit of the seed:

| $f$ | $n$ | seed | target | as-enum | rand min | rand median | rand max | median/target |
|---|---|---|---|---|---|---|---|---|
| 4 | 3–6 | cup ($\lambda=\varnothing$) | 3 | 31 | 3 | **5** | 13 | **1.7** |
| 4 | 4–6 | $e_0\wedge e_1\wedge e_2\wedge e_3$ ($\lambda=(1^4)$) | 1 | 53 | 1 | **3** | 23 | **3.0** |
| 4 | 3–6 | harmonic symmetric ($\lambda=(4)$) | 1 | 53 | 1 | **3** | 23 | **3.0** |
| 4 | 4–6 | generic (all blocks) | 99 | 105 | 102 | 105 | 105 | 1.1 |

**"About ten diagrams per dimension" is $1.7$ under a random order.** The number the file publishes is an artefact, and it happens to be pessimistic, which is why the qualitative conclusion (bounded cost per dimension at these sizes) survives while the figure does not.

The generic row is worth its own line: when the target is **all** blocks at once, the enumeration consumes $105$ of $105$ diagrams. At $f=12$ that is the whole $316{,}234{,}143{,}225$, which is [r260](REVIEW_r260.md)'s standing objection restated as a measurement.

### (b) Non-trivial $\lambda$, the assert would fire

The file tests $\lambda=\varnothing$ only, and $n=12$ needs $71$ blocks. Running the reviewed loop **verbatim** on a $\lambda=(4)$ seed and a $\lambda=(1^4)$ seed:

| $f$ | $n$ | seed | target | `used`, with prune | `used`, no prune | `12*target + 5` |
|---|---|---|---|---|---|---|
| 4 | 4 | harmonic symmetric | 1 | 53 | 53 | 17, **would fire** |
| 4 | 4 | antisymmetric | 1 | 53 | 53 | 17, **would fire** |
| 4 | 5 | harmonic symmetric | 1 | 53 | 53 | 17, **would fire** |
| 4 | 5 | antisymmetric | 1 | 53 | 53 | 17, **would fire** |
| 4 | 6 | harmonic symmetric | 1 | 53 | 53 | 17, **would fire** |
| 4 | 6 | antisymmetric | 1 | 53 | 53 | 17, **would fire** |

So the cost does **not** look the same at non-trivial $\lambda$ in the order the file uses, it is three times worse per dimension, and the file's own guard would reject it. Under a random order the ratio is $3.0$ against the cup seed's $1.7$, still bounded but not equal. Either way the published statement is measured on the one block that $n=12$ needs $71$ of.

### (d) The prune is not rank-safe, and does not fire

```
if len(rows) > 4 * target + 40:
    rows = list(np.array(rows)[np.argsort(-np.abs(np.array(rows)).max(1))][:target + 10])
```

Sorting by $\max\lvert\text{entry}\rvert$ is not a rank criterion. Minimal witness: rows $[1000,0]$, $[1000,0]$, $[0,1]$, keeping the top two by magnitude gives **rank 1** where the full rank is $2$. And duplicate rows are the normal situation here, since many diagrams send the seed to the same vector:

| $f$ | $n$ | seed | rows | distinct rows | full rank |
|---|---|---|---|---|---|
| 4 | 4 | cup | 105 | 9 | 3 |
| 4 | 4 | antisymmetric | 105 | 3 | 1 |
| 4 | 4 | harmonic symmetric | 105 | **2** | 1 |
| 4 | 4 | generic | 105 | 105 | 99 |

There is a second defect compounding it: after a prune the loop **never lowers `rank`** (`rank` is updated only under `if r > rank`) while `r` is recomputed on the pruned set. If a prune drops the rank, the loop must climb back past a stale high-water mark before it will record anything, and can return `None` on a seed whose cumulative span is full.

**In the four reported cells it never fires.** `used` is $1$ and $31$ against thresholds of $44$ and $52$, so `len(rows)` never reaches the branch and the published numbers are unaffected. It is latent, not active, and at the non-trivial-$\lambda$ seeds above, where `used = 53` exceeds the threshold $44$, the prune and no-prune runs happen to agree because the target is $1$.

---

## Claim 5, the blocked-on-data claim, verified

Sweep: [out_c5_data_sweep.txt](../scripts/reviewers/r267/out_c5_data_sweep.txt).

**[n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl) holds the block table and nothing else.** $1{,}343$ bytes; a `dict` of $77$ six-tuples mapping to plain `int`s in $\{1,\dots,9\}$, summing to $191$. I verified the $O(12)$ reduction from the file itself rather than from the record: exactly $12$ keys have $\lambda_6\ne0$, forming $6$ chirality pairs, with multiplicities $\{1,1,1,1,1,1,1,1,1,1,2,2\}$. Fusing each pair gives $77-6=\mathbf{71}$ blocks and $191-7=\mathbf{184}$ multiplicities, the commit's numbers, reproduced.

**No covariant data exists anywhere in the repository.**

- No `.pkl`, `.npz` or `.npy` file is git-tracked at all; every pickle in the tree, [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl) included, is untracked.
- [run_n12_covariants.py](../scripts/runs/run_n12_covariants.py) contains no `pickle.dump`, `np.save`, `savez` or `json.dump`, it emits nothing to disk.
- `git log --all --diff-filter=A` over every blob ever added, and `--diff-filter=D` over every one deleted, turns up no artefact named for covariants or a basis.
- The nearest candidate, [weyl12.pkl](../scripts/reviewers/r216/weyl12.pkl), holds `WEYL` (853 weight multiplicities), `E` (six raising operators) and `ALPHA` (six simple roots), the input to the construction, not its output.

The claim is accurate in every part, including *"naming that is the finding, not a caveat around one"*.

---

## Claim 6, the sweep

| finding | first named | status at `878f7bb` |
|---|---|---|
| The Gram identity's **Frobenius / positive-definiteness** reason | [r261](REVIEW_r261.md) rec 6 | **APPLIED** by `3e9c304`. [brauer-pairing.md:73](../findings/brauer-pairing.md) now carries it in full, and [run_diagram_realisation.py:209](../scripts/runs/run_diagram_realisation.py) with it. Asked for by six reviewers over six cycles; this is the cycle it landed |
| [run_seed_is_a_diagram.py](../scripts/runs/run_seed_is_a_diagram.py) header contradicting its own body | [r264](REVIEW_r264.md) | **APPLIED.** The header now opens *"obligation (ii) is NOT closed"* |
| The *"six primes"* assert over a two-prime tuple | [r264](REVIEW_r264.md) claim 5 | **APPLIED.** No occurrence remains |
| [plan.md:55](../plan.md)'s *"A3 cannot start without it"* | [r262](REVIEW_r262.md) claim 3 | **STANDS**, verbatim and unchanged. r262, r263, r264, r265, r266, this is the sixth cycle |
| [brauer-pairing.md:75](../findings/brauer-pairing.md)'s *"which **semisimplicity** plus the double centraliser forces"* | [r260](REVIEW_r260.md) claim 5, [r265](REVIEW_r265.md) | **STANDS.** The image is $\bigoplus_\lambda\mathrm{End}(M_\lambda)$ at every $n$ by the centraliser alone; the file says *"the inequality never enters"* elsewhere |
| The $f=12$ row asserted with no committed run | [r259](REVIEW_r259.md) rec 5, [r263](REVIEW_r263.md) 6(iii), [r265](REVIEW_r265.md) | **STANDS.** [brauer-pairing.md:81](../findings/brauer-pairing.md) still asserts *"at $f=12$ the two part company at every $n\le10$"*; nothing in [scripts/runs/](../scripts/runs/) computes it, and r263 verified it is true |
| `assert total - r == total - sd`, assert 1 with the same integer on both sides | [r265](REVIEW_r265.md) claim 3, [r266](REVIEW_r266.md) claim 3 and rec 4 | **STANDS** at [run_restitution_kernel.py:70](../scripts/runs/run_restitution_kernel.py) |
| The search gate firing on the subject line rather than the plan.md diff | [r265](REVIEW_r265.md), [r266](REVIEW_r266.md) rec 5 | **PARTLY APPLIED.** [cycle_deliverable.py:94](../.claude/hooks/cycle_deliverable.py) still reads only line 1 of the command, but its docstring now concedes *"A TRIPWIRE, NOT A PROOF"* and says which shapes it misses. The mechanism is unchanged; the claim about it is now honest |
| The retracted inference in prose | [r265](REVIEW_r265.md), [r266](REVIEW_r266.md) rec 1–3 | **APPLIED.** [plan.md](../plan.md) carries the composite accounting and the misattribution of the $2$; [run_restitution_kernel.py](../scripts/runs/run_restitution_kernel.py) opens with *"what this file first wrongly claimed"* |

**And one new gap, of the shape [r266](REVIEW_r266.md) flagged one commit earlier.** `a5f8c0d` is $+5/-1$ on [plan.md](../plan.md) plus one new script; `878f7bb` is one new script. Neither touches [findings/INDEX.md](../findings/INDEX.md) or [findings/brauer-pairing.md](../findings/brauer-pairing.md). So [FINDINGS.md:40](../findings/INDEX.md) still reads:

> **Independence on the degree-3 diagonal is a SEPARATE and OPEN question**, restriction kills $10{,}395$ diagrams to rank $2$.

while [plan.md](../plan.md) item 1(i) now reads *"REDUCED to a rank computation … the function-space question is gone"*. Unlike the `d46cda0` case, where r266 found the un-propagated files were the correct ones, here **both sentences are true of different things**, the restriction from $V^{\otimes12}$ does kill $10{,}395$ to rank $2$, and evaluation at cubes is injective on what survives. Which is exactly why the record should say so in one place rather than two.

## Recommendations

1. **Say where the argument came from.** Obligation (i)'s injectivity claim is [r266](REVIEW_r266.md) claim 1's granted half. Citing it costs a clause and removes the appearance that the retracted argument was re-run.
2. **Close obligation (i) properly, or restate it.** With the FFT and the realisation theorem already in the record, cubes-span finishes the existence-and-independence statement outright. What is left is (ii) plus r245's every-$n$ obligation, and (i) should say that rather than name a rank computation on a set that does not exist.
3. **Put the quantifier back.** *"What remains is finite"* is finite at one $n$. [r245](REVIEW_r245.md) 1(iii) asks for root-freeness on $[12,\infty)$, and item 1's own bullet (iii) calls that shape of obligation global. Say which of the two obligation (i) now carries.
4. **Withdraw the number ten.** `used = 31` is the position of the third rank-raising diagram in `matchings`, identical at every $n$; the random-order median is $5$. Report the random-order figure with its spread, or report nothing.
5. **Delete *"flat in $n$"*.** The rank-raising positions are $\{1,16,31\}$ at $n=2$ through $7$. The enumeration order does not depend on $n$, and that is all the row says.
6. **Measure one non-trivial $\lambda$ before drawing a cost.** At $\lambda=(4)$ and $\lambda=(1^4)$ the file's own assert fires, at $53$ against a bound of $17$. $n=12$ needs $71$ blocks and $70$ of them are not $\varnothing$.
7. **Remove the prune or make it rank-safe.** It never fires in the reported cells, so removing it costs nothing today; keeping it means a magnitude sort deciding which vectors carry the rank, with `rank` never lowered after the cut.
8. **Add one sentence on the duality.** $\operatorname{Hom}(V_\lambda,\mathrm{Sym}^3\mathcal W_n)$ and $\operatorname{Hom}(\mathrm{Sym}^3\mathcal W_n,V_\lambda)$ are interchanged silently between the realisation theorem and obligation (i); the identification is the invariant inner product.
9. **Propagate to [findings/INDEX.md](../findings/INDEX.md).** Two commits in a row have moved item 1 in plan.md alone.
